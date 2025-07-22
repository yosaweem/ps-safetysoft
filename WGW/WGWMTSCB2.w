&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
&Scoped-define WINDOW-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS C-Win 
/*------------------------------------------------------------------------

  File: 

  Description: 

  Input Parameters:
      <none>

  Output Parameters:
      <none>

  Author: 

  Created: 

------------------------------------------------------------------------*/
/*          This .W file was created with the Progress UIB.             */
/*----------------------------------------------------------------------*/

/* Create an unnamed pool to store all the widgets created 
     by this procedure. This is a good default which assures
     that this procedure's triggers and internal procedures 
     will execute in this procedure's storage, and that proper
     cleanup will occur on deletion of the procedure. */

CREATE WIDGET-POOL.
/* ***************************  DefINITions  **************************        */

/*Program ID    :  wgwmtscb2.w                                                 */
/*Program name :  Export file policy Send to SCBPT                             */
/*create by    : Ranu i. A60-0488 Match ����駧ҹ��������������觡�Ѻ SCBPT*/
/*DataBase connect : GW_SAFE -LD SIC_BRAN, GW_STAT -LD BRSTAT,SICSYAC,SICUW */  
/*---------------------------------------------------------------------------*/  
/* Modyfy By : Ranu I. A61-0228 Date: 17/05/2018 
               ��䢢����Ū�ͧ Barcode insuredname �������������� fi&theft trntyp */ 
/*modyfy by : Chonlapeet A61-0322 Date : 02/07/2561
            ��䢤������ Format Yesfile ����Ѻ�觡�Ѻ SCB Protect ��
�ҡ������ >>> FireSumInsured ���������� G �������¹����������� O(��) ᷹  */
/*Modify BY  : Kridtiya i. A64-0295 DATE. 25/07/2021 ��Ѻ��䢵�� Layout new ��������� �ͷ�� ��С�ȵ���� */
/*Modify BY  : Kridtiya i. DATE.12/08/2022 A65-0174 ��Ѻ����ٻẺ����*/
/*Modify BY  : Tontawan S. DATE.09/05/2023 A66-0006 
             : Trim �����ŵ͹ Export �ͧ Report_policy 
             : ����¹������� Column (BP) �� Holder_Billing_Repost_code__c     
             : ��� Format ������� Export �� policy_YYYYMMDDHHSS.CSV     
             : ��������� Tracking �ͧ�ҹ 72 ����ҡ����դ�����仴֧����Ţ Appen   */
/*------------------------------------------------------------------------------------*/
// Modify BY : Tontawan S. A68-0059 27/03/2025        
//           : Add 35 FIELD for support EV     
/*------------------------------------------------------------------------------------*/
/* Parameters DefINITions ---                                                  */
/* Local Variable DefINITions ---                                              */
{wgw\wgwmtscb2.i}   /*ADD Kridtiya i. A64-0295 DATE. 25/07/2021 */
DEF  stream ns1.
DEFINE VAR  nv_daily       AS CHARACTER FORMAT "X(1024)"     INITIAL ""  NO-UNDO.
DEFINE VAR  nv_reccnt      AS  INT  INIT  0.
DEFINE VAR  nv_completecnt AS   INT   INIT  0.
DEFINE VAR  nv_enttim      AS  CHAR          INIT  "".
DEFINE VAR  nv_export      as  date  INIT  ""  format "99/99/9999".
DEF stream  ns2.
DEFINE VAR nv_file1        AS CHARACTER FORMAT "X(100)"     INITIAL ""  NO-UNDO.
DEFINE VAR nv_file2        AS CHARACTER FORMAT "X(100)"     INITIAL ""  NO-UNDO.
/*comment by Kridtiya i. A64-0295 DATE. 25/07/2021.............................
/*--------------------------����Ѻ�����š�������  -------------------------*/
DEFINE NEW SHARED WORKFILE wdetail NO-UNDO
    FIELD XRefNo1         AS CHAR FORMAT "X(50)"  INIT ""      /*�Ţ����͡�����ҧ�ԧ        */           
    FIELD Barcode         AS CHAR FORMAT "X(50)"  INIT ""      /*������                   */           
    FIELD InsuredName     AS CHAR FORMAT "X(225)" INIT ""      /*���ͺ���ѷ��Сѹ���        */           
    FIELD PolicyNo        AS CHAR FORMAT "X(20)"  INIT ""      /*�Ţ����������             */           
    FIELD EndorseNo       AS CHAR FORMAT "X(20)"  INIT ""      /*�Ţ�����ѡ��ѧ             */           
    FIELD SumInsured      AS CHAR FORMAT "X(20)"  INIT ""      /*�ع��Сѹ                  */
    FIELD sumfire         AS CHAR FORMAT "x(20)"  INIT ""      /* fire & theft */ /*A61-0228*/
    FIELD NetPremium      AS CHAR FORMAT "X(20)"  INIT ""      /*�����ط��                 */           
    FIELD VatTax          AS CHAR FORMAT "X(10)"  INIT ""      /*������Ť������            */           
    FIELD Stamp           AS CHAR FORMAT "X(10)"  INIT ""      /*�ҡ�                       */           
    FIELD GrossPremium    AS CHAR FORMAT "X(20)"  INIT ""      /*�������                   */           
    FIELD EffectiveDate   AS CHAR FORMAT "X(15)"  INIT ""      /*�ѹ��������������ͧ        */           
    FIELD ExpireDate      AS CHAR FORMAT "X(15)"  INIT ""      /*�ѹ�������ش����������ͧ  */         
    FIELD EndorseReason   AS CHAR FORMAT "X(350)" INIT ""      /*�˵ؼš����ѡ��ѧ          */   
    FIELD trntyp          AS CHAR FORMAT "x(5)"   INIT ""  .   /* transtype */ /*a61-0228*/
end..comment by Kridtiya i. A64-0295 DATE. 25/07/2021 ....................................*/
DEF VAR nv_time             AS CHAR FORMAT "x(20)"  INIT "" .
DEF VAR n_cmr_code          AS CHAR FORMAT "X(50)"  INIT "".  
DEF VAR n_comp_code         AS CHAR FORMAT "X(50)"  INIT "".  
DEF VAR n_campcode          AS CHAR FORMAT "X(50)"  INIT "".  
DEF VAR n_campname          AS CHAR FORMAT "X(50)"  INIT "".  
DEF VAR n_procode           AS CHAR FORMAT "X(50)"  INIT "".  
DEF VAR n_proname           AS CHAR FORMAT "X(50)"  INIT "".  
DEF VAR n_packname          AS CHAR FORMAT "X(50)"  INIT "".  
DEF VAR n_packcode          AS CHAR FORMAT "X(50)"  INIT "".  
DEF VAR n_instype           AS CHAR FORMAT "X(5)"   INIT "".  
DEF VAR n_pol_title         AS CHAR FORMAT "X(20)"  INIT "".  
DEF VAR n_pol_fname         AS CHAR FORMAT "X(100)" INIT "".  
DEF VAR n_pol_lname         AS CHAR FORMAT "X(100)" INIT "".  
DEF VAR n_pol_title_eng     AS CHAR FORMAT "X(20)"  INIT "".  
DEF VAR n_pol_fname_eng     AS CHAR FORMAT "X(50)"  INIT "".  
DEF VAR n_pol_lname_eng     AS CHAR FORMAT "X(50)"  INIT "".  
DEF VAR n_icno              AS CHAR FORMAT "X(20)"  INIT "".  
DEF VAR n_sex               AS CHAR FORMAT "X(1) "  INIT "".  
DEF VAR n_bdate             AS CHAR FORMAT "X(10)"  INIT "".  
DEF VAR n_occup             AS CHAR FORMAT "X(50)"  INIT "".  
DEF VAR n_tel               AS CHAR FORMAT "X(20)"  INIT "".  
DEF VAR n_phone             AS CHAR FORMAT "X(20)"  INIT "".  
DEF VAR n_teloffic          AS CHAR FORMAT "X(20)"  INIT "".  
DEF VAR n_telext            AS CHAR FORMAT "X(20)"  INIT "".  
DEF VAR n_moblie            AS CHAR FORMAT "X(20)"  INIT "".  
DEF VAR n_mobliech          AS CHAR FORMAT "X(20)"  INIT "".  
DEF VAR n_mail              AS CHAR FORMAT "X(40)"  INIT "".  
DEF VAR n_lineid            AS CHAR FORMAT "X(100)" INIT "".  
DEF VAR n_addr1_70          AS CHAR FORMAT "X(100)" INIT "".  
DEF VAR n_addr2_70          AS CHAR FORMAT "X(100)" INIT "".  
DEF VAR n_addr3_70          AS CHAR FORMAT "X(100)" INIT "".  
DEF VAR n_addr4_70          AS CHAR FORMAT "X(100)" INIT "".  
DEF VAR n_addr5_70          AS CHAR FORMAT "X(40)"  INIT "".  
DEF VAR n_nsub_dist70       AS CHAR FORMAT "X(20)"  INIT "".  
DEF VAR n_ndirection70      AS CHAR FORMAT "X(20)"  INIT "".  
DEF VAR n_nprovin70         AS CHAR FORMAT "X(20)"  INIT "".  
DEF VAR n_zipcode70         AS CHAR FORMAT "X(10)"  INIT "".  
DEF VAR n_addr1_72          AS CHAR FORMAT "X(100)" INIT "".  
DEF VAR n_addr2_72          AS CHAR FORMAT "X(100)" INIT "".  
DEF VAR n_addr3_72          AS CHAR FORMAT "X(100)" INIT "".  
DEF VAR n_addr4_72          AS CHAR FORMAT "X(100)" INIT "".  
DEF VAR n_addr5_72          AS CHAR FORMAT "X(40)"  INIT "".  
DEF VAR n_nsub_dist72       AS CHAR FORMAT "X(20)"  INIT "".  
DEF VAR n_ndirection72      AS CHAR FORMAT "X(20)"  INIT "".  
DEF VAR n_nprovin72         AS CHAR FORMAT "X(20)"  INIT "".  
DEF VAR n_zipcode72         AS CHAR FORMAT "X(10)"  INIT "".  
DEF VAR n_paytype           AS CHAR FORMAT "X(1) "  INIT "".  
DEF VAR n_paytitle          AS CHAR FORMAT "X(20)"  INIT "".  
DEF VAR n_payname           AS CHAR FORMAT "X(100)" INIT "".  
DEF VAR n_paylname          AS CHAR FORMAT "X(100)" INIT "".  
DEF VAR n_payicno           AS CHAR FORMAT "X(20)"  INIT "".  
DEF VAR n_payaddr1          AS CHAR FORMAT "X(100)" INIT "".  
DEF VAR n_payaddr2          AS CHAR FORMAT "X(100)" INIT "".  
DEF VAR n_payaddr3          AS CHAR FORMAT "X(100)" INIT "".  
DEF VAR n_payaddr4          AS CHAR FORMAT "X(100)" INIT "".  
DEF VAR n_payaddr5          AS CHAR FORMAT "X(40)"  INIT "".  
DEF VAR n_payaddr6          AS CHAR FORMAT "X(20)"  INIT "".  
DEF VAR n_payaddr7          AS CHAR FORMAT "X(20)"  INIT "".  
DEF VAR n_payaddr8          AS CHAR FORMAT "X(20)"  INIT "".  
DEF VAR n_payaddr9          AS CHAR FORMAT "X(10)"  INIT "".  
DEF VAR n_branch            AS CHAR FORMAT "X(10)"  INIT "".  
DEF VAR n_ben_title         AS CHAR FORMAT "X(10)"  INIT "".  
DEF VAR n_ben_name          AS CHAR FORMAT "X(50)"  INIT "".  
DEF VAR n_ben_lname         AS CHAR FORMAT "X(50)"  INIT "".  
DEF VAR n_pmentcode         AS CHAR FORMAT "X(10)"  INIT "".  
DEF VAR n_pmenttyp          AS CHAR FORMAT "X(20)"  INIT "".  
DEF VAR n_pmentcode1        AS CHAR FORMAT "X(20)"  INIT "".  
DEF VAR n_pmentcode2        AS CHAR FORMAT "X(50)"  INIT "".  
DEF VAR n_pmentbank         AS CHAR FORMAT "X(20)"  INIT "".  
DEF VAR n_pmentdate         AS CHAR FORMAT "X(10)"  INIT "".  
DEF VAR n_pmentsts          AS CHAR FORMAT "X(10)"  INIT "".  
DEF VAR n_driver            AS CHAR FORMAT "X(10)"  INIT "".  
DEF VAR n_drivetitle1       AS CHAR FORMAT "X(10)"  INIT "".  
DEF VAR n_drivename1        AS CHAR FORMAT "X(50)"  INIT "".  
DEF VAR n_drivelname1       AS CHAR FORMAT "X(50)"  INIT "".  
DEF VAR n_driveno1          AS CHAR FORMAT "X(20)"  INIT "".  
DEF VAR n_occupdriv1        AS CHAR FORMAT "X(30)"  INIT "".  
DEF VAR n_sexdriv1          AS CHAR FORMAT "X(1) "  INIT "".  
DEF VAR n_bdatedriv1        AS CHAR FORMAT "X(10)"  INIT "".  
DEF VAR n_drivetitle2       AS CHAR FORMAT "X(10)"  INIT "".  
DEF VAR n_drivename2        AS CHAR FORMAT "X(50)"  INIT "".  
DEF VAR n_drivelname2       AS CHAR FORMAT "X(50)"  INIT "".  
DEF VAR n_driveno2          AS CHAR FORMAT "X(20)"  INIT "".  
DEF VAR n_occupdriv2        AS CHAR FORMAT "X(50)"  INIT "".  
DEF VAR n_sexdriv2          AS CHAR FORMAT "X(1) "  INIT "".  
DEF VAR n_bdatedriv2        AS CHAR FORMAT "X(10)"  INIT "".  
DEF VAR n_brand             AS CHAR FORMAT "X(50)"  INIT "".   
DEF VAR n_brand_cd          AS CHAR FORMAT "X(50)"  INIT "".   
DEF VAR n_Model             AS CHAR FORMAT "X(50)"  INIT "".   
DEF VAR n_Model_cd          AS CHAR FORMAT "X(50)"  INIT "".   
DEF VAR n_body              AS CHAR FORMAT "X(50)"  INIT "".   
DEF VAR n_body_cd           AS CHAR FORMAT "X(50)"  INIT "".   
DEF VAR n_licence           AS CHAR FORMAT "X(50)"  INIT "".   
DEF VAR n_province          AS CHAR FORMAT "X(50)"  INIT "".   
DEF VAR n_chassis           AS CHAR FORMAT "X(50)"  INIT "".   
DEF VAR n_engine            AS CHAR FORMAT "X(50)"  INIT "".   
DEF VAR n_yrmanu            AS CHAR FORMAT "X(10)"  INIT "".   
DEF VAR n_seatenew          AS CHAR FORMAT "X(10)"  INIT "".   
DEF VAR n_power             AS CHAR FORMAT "X(10)"  INIT "".   
DEF VAR n_weight            AS CHAR FORMAT "X(10)"  INIT "".   
DEF VAR n_class             AS CHAR FORMAT "X(10)"  INIT "".   
DEF VAR n_garage_cd         AS CHAR FORMAT "X(10)"  INIT "".   
DEF VAR n_garage            AS CHAR FORMAT "X(10)"  INIT "".   
DEF VAR n_colorcode         AS CHAR FORMAT "X(20)"  INIT "".   
DEF VAR n_covcod            AS CHAR FORMAT "X(10)"  INIT "".   
DEF VAR n_covtyp            AS CHAR FORMAT "X(20)"  INIT "".   
DEF VAR n_covtyp1           AS CHAR FORMAT "X(50)"  INIT "".   
DEF VAR n_covtyp2           AS CHAR FORMAT "X(50)"  INIT "".   
DEF VAR n_covtyp3           AS CHAR FORMAT "X(50)"  INIT "".   
DEF VAR n_comdat            AS CHAR FORMAT "X(20)"  INIT "".   
DEF VAR n_expdat            AS CHAR FORMAT "X(20)"  INIT "".   
DEF VAR n_ins_amt           AS CHAR FORMAT "X(20)"  INIT "".   
DEF VAR n_prem1             AS CHAR FORMAT "X(20)"  INIT "".   
DEF VAR n_gross_prm         AS CHAR FORMAT "X(20)"  INIT "".   
DEF VAR n_stamp             AS CHAR FORMAT "X(20)"  INIT "".   
DEF VAR n_vat               AS CHAR FORMAT "X(20)"  INIT "".   
DEF VAR n_premtotal         AS CHAR FORMAT "X(20)"  INIT "".   
DEF VAR n_deduct            AS CHAR FORMAT "X(20)"  INIT "".   
DEF VAR n_fleetper          AS CHAR FORMAT "X(20)"  INIT "".   
DEF VAR n_fleet             AS CHAR FORMAT "X(20)"  INIT "".   
DEF VAR n_ncbper            AS CHAR FORMAT "X(20)"  INIT "".   
DEF VAR n_ncb               AS CHAR FORMAT "X(20)"  INIT "".   
DEF VAR n_drivper           AS CHAR FORMAT "X(20)"  INIT "".   
DEF VAR n_drivdis           AS CHAR FORMAT "X(20)"  INIT "".   
DEF VAR n_othper            AS CHAR FORMAT "X(20)"  INIT "".   
DEF VAR n_oth               AS CHAR FORMAT "X(20)"  INIT "".   
DEF VAR n_cctvper           AS CHAR FORMAT "X(20)"  INIT "".   
DEF VAR n_cctv              AS CHAR FORMAT "X(20)"  INIT "".   
DEF VAR n_Surcharper        AS CHAR FORMAT "X(20)"  INIT "".   
DEF VAR n_Surchar           AS CHAR FORMAT "X(20)"  INIT "".   
DEF VAR n_Surchardetail     AS CHAR FORMAT "X(20)"  INIT "".   
DEF VAR n_acc1              AS CHAR FORMAT "X(50)"  INIT "".   
DEF VAR n_accdetail1        AS CHAR FORMAT "X(500)" INIT "".   
DEF VAR n_accprice1         AS CHAR FORMAT "X(10)"  INIT "".   
DEF VAR n_acc2              AS CHAR FORMAT "X(50)"  INIT "".   
DEF VAR n_accdetail2        AS CHAR FORMAT "X(500)" INIT "".   
DEF VAR n_accprice2         AS CHAR FORMAT "X(10)"  INIT "".   
DEF VAR n_acc3              AS CHAR FORMAT "X(50)"  INIT "".   
DEF VAR n_accdetail3        AS CHAR FORMAT "X(500)" INIT "".   
DEF VAR n_accprice3         AS CHAR FORMAT "X(10)"  INIT "".   
DEF VAR n_acc4              AS CHAR FORMAT "X(50)"  INIT "".   
DEF VAR n_accdetail4        AS CHAR FORMAT "X(500)" INIT "".   
DEF VAR n_accprice4         AS CHAR FORMAT "X(10)"  INIT "".   
DEF VAR n_acc5              AS CHAR FORMAT "X(50)"  INIT "".   
DEF VAR n_accdetail5        AS CHAR FORMAT "X(500)" INIT "".   
DEF VAR n_accprice5         AS CHAR FORMAT "X(10)"  INIT "".   
DEF VAR n_inspdate          AS CHAR FORMAT "X(10)"  INIT "".   
DEF VAR n_inspdate_app      AS CHAR FORMAT "X(10)"  INIT "".   
DEF VAR n_inspsts           AS CHAR FORMAT "X(10)"  INIT "".   
DEF VAR n_inspdetail        AS CHAR FORMAT "X(500)" INIT "".   
DEF VAR n_not_date          AS CHAR FORMAT "X(10)"  INIT "".   
DEF VAR n_paydate           AS CHAR FORMAT "X(10)"  INIT "".   
DEF VAR n_paysts            AS CHAR FORMAT "X(10)"  INIT "".   
DEF VAR n_licenBroker       AS CHAR FORMAT "X(20)"  INIT "".   
DEF VAR n_brokname          AS CHAR FORMAT "X(20)"  INIT "".   
DEF VAR n_brokcode          AS CHAR FORMAT "X(10)"  INIT "".   
DEF VAR n_lang              AS CHAR FORMAT "X(20)"  INIT "".   
DEF VAR n_deli              AS CHAR FORMAT "X(50)"  INIT "".   
DEF VAR n_delidetail        AS CHAR FORMAT "X(100)" INIT "".   
DEF VAR n_gift              AS CHAR FORMAT "X(100)" INIT "".   
DEF VAR n_cedcode           AS CHAR FORMAT "X(20)"  INIT "".   
DEF VAR n_inscode           AS CHAR FORMAT "X(20)"  INIT "".   
DEF VAR n_remark            AS CHAR FORMAT "X(500)" INIT "" .
DEF VAR n_ben_2title        AS CHAR FORMAT "X(10)"  INIT "".  
DEF VAR n_ben_2name         AS CHAR FORMAT "X(50)"  INIT "".  
DEF VAR n_ben_2lname        AS CHAR FORMAT "X(50)"  INIT "".
DEF VAR n_ben_3title        AS CHAR FORMAT "X(10)"  INIT "".  
DEF VAR n_ben_3name         AS CHAR FORMAT "X(50)"  INIT "".  
DEF VAR n_ben_3lname        AS CHAR FORMAT "X(50)"  INIT "".
DEF VAR n_Agent_Code        AS CHAR FORMAT "X(50)"  INIT "".  
DEF VAR n_Agent_Name_TH     AS CHAR FORMAT "X(50)"  INIT "".  
DEF VAR n_Agent_Name_Eng    AS CHAR FORMAT "X(50)"  INIT "".  
DEF VAR n_Selling_Channel   AS CHAR FORMAT "X(50)"  INIT "". 


DEF VAR nv_agent            AS CHAR FORMAT "x(15)" INIT "".
DEF var ut_net              AS DECI  INIT 0.
def var ut_stamp            AS DECI  INIT 0.
def var ut_vat              AS DECI  INIT 0.
def var ut_tax              AS DECI  INIT 0.
DEF var n_taxp              AS DECI  INIT 0.
def var ut_total            AS DECI  INIT 0.
DEF Var nv_fptr             As RECID   INITial    0.
DEF Var nv_bptr             As RECID   INITial    0.
DEF VAR nv_txt5             AS CHAR FORMAT "x(250)".
DEF VAR nv_oldpol           AS CHAR FORMAT "x(15)" INIT "".
DEF VAR nv_output           AS CHAR FORMAT "x(60)" INIT "".
DEF VAR nt_policyno         AS CHAR.
DEF VAR nv_ems              AS CHAR.
DEF VAR n_ems               AS CHAR.
DEF VAR n_date              AS CHAR.
DEF VAR nv_date             AS CHAR.
DEF VAR nv_doc_num          AS DECI. 
DEF VAR chNotesSession      As Com-Handle.   
DEF VAR chNotesDataBase     As Com-Handle.  
DEF VAR chNotesView         As Com-Handle .
DEF VAR chnotecollection    AS COM-HANDLE. 
DEF VAR chDocument          As Com-Handle.  
DEF VAR chNotesView1        As Com-Handle . 
DEF VAR chDocument1         As Com-Handle.
DEF VAR chItem              As Com-Handle .
DEF VAR chData              As Com-Handle .
DEF VAR nv_tmp              AS CHAR .
DEF VAR n_snote             AS CHAR FORMAT "X(25)" .
DEF VAR nt_round            AS CHAR FORMAT "x(15)" .
DEFINE VAR nv_appen         AS CHAR FORMAT "X(20)" INIT "" .  /*-- Add By Tontawan S. A66-0006 --*/

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS fi_agent fi_loadname bu_file-3 fi_outload ~
bu_ok bu_exit-2 fi_desagent fi_outloadends fi_outloadmemo fi_tranform ~
fi_tranto RECT-381 RECT-382 RECT-383 
&Scoped-Define DISPLAYED-OBJECTS fi_agent fi_loadname fi_outload ~
fi_desagent fi_outloadends fi_outloadmemo fi_tranform fi_tranto 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bu_exit-2 
     LABEL "Exit" 
     SIZE 7.5 BY 1.05
     FONT 6.

DEFINE BUTTON bu_file-3 
     LABEL "..." 
     SIZE 5 BY 1.

DEFINE BUTTON bu_ok 
     LABEL "OK" 
     SIZE 7.5 BY 1.05
     FONT 6.

DEFINE VARIABLE fi_agent AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1
     BGCOLOR 15 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_desagent AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 40 BY 1
     BGCOLOR 20 FGCOLOR 4 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_loadname AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 60 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_outload AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 65.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_outloadends AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 65.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_outloadmemo AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 65.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_tranform AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1
     BGCOLOR 15 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_tranto AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1
     BGCOLOR 15 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-381
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 94 BY 12.24
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-382
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 10 BY 2
     BGCOLOR 4 .

DEFINE RECTANGLE RECT-383
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 10 BY 2
     BGCOLOR 2 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     fi_agent AT ROW 3.62 COL 28.83 COLON-ALIGNED NO-LABEL
     fi_loadname AT ROW 6 COL 26.5 COLON-ALIGNED NO-LABEL
     bu_file-3 AT ROW 5.95 COL 88.83
     fi_outload AT ROW 7.1 COL 26.5 COLON-ALIGNED NO-LABEL
     bu_ok AT ROW 11.05 COL 74.67
     bu_exit-2 AT ROW 11.05 COL 84.83
     fi_desagent AT ROW 3.62 COL 47.5 COLON-ALIGNED NO-LABEL
     fi_outloadends AT ROW 8.24 COL 26.5 COLON-ALIGNED NO-LABEL WIDGET-ID 2
     fi_outloadmemo AT ROW 9.33 COL 26.5 COLON-ALIGNED NO-LABEL WIDGET-ID 10
     fi_tranform AT ROW 4.86 COL 26.5 COLON-ALIGNED NO-LABEL WIDGET-ID 14
     fi_tranto AT ROW 4.86 COL 50.17 COLON-ALIGNED NO-LABEL WIDGET-ID 16
     "OUTPUT FILE NEW :" VIEW-AS TEXT
          SIZE 20.5 BY 1 AT ROW 7.1 COL 6.83
          BGCOLOR 8 FGCOLOR 2 FONT 6
     "** File Endors.Ext. D:~\temp~\endorsement_YYYYMMDD.csv**" VIEW-AS TEXT
          SIZE 58 BY 1 AT ROW 12.71 COL 14.5 WIDGET-ID 8
          BGCOLOR 8 FGCOLOR 6 FONT 6
     "Date:05/09/2022" VIEW-AS TEXT
          SIZE 17 BY 1 AT ROW 12.76 COL 76 WIDGET-ID 22
          BGCOLOR 8 FGCOLOR 3 FONT 6
     "IMPORT FILE :" VIEW-AS TEXT
          SIZE 15 BY 1 AT ROW 6 COL 12.83
          BGCOLOR 8 FGCOLOR 2 FONT 6
     "    MATCH FILE POLICY  SEND TO SCBPT ��§ҹ�������觡�Ѻ SCB" VIEW-AS TEXT
          SIZE 94 BY 2.14 AT ROW 1.24 COL 1.5
          BGCOLOR 30 FGCOLOR 7 FONT 2
     "GROUP PRODUCER CODE :" VIEW-AS TEXT
          SIZE 27.5 BY 1 AT ROW 3.62 COL 2.33
          BGCOLOR 8 FGCOLOR 2 FONT 6
     "** ������駧ҹ�ͧ SCBPT 㹡�� match policy �觡�Ѻ **" VIEW-AS TEXT
          SIZE 58 BY 1 AT ROW 10.52 COL 14.5
          BGCOLOR 8 FGCOLOR 6 FONT 6
     "OUTPUT FILE ENDORSE :" VIEW-AS TEXT
          SIZE 25.5 BY 1 AT ROW 8.24 COL 2 WIDGET-ID 4
          BGCOLOR 8 FGCOLOR 2 FONT 6
     "     OUTPUT FILE MEMO :" VIEW-AS TEXT
          SIZE 25.5 BY 1 AT ROW 9.33 COL 2 WIDGET-ID 12
          BGCOLOR 8 FGCOLOR 2 FONT 6
     "TRANSECTIONDATE F :" VIEW-AS TEXT
          SIZE 23 BY 1 AT ROW 4.81 COL 4.5 WIDGET-ID 18
          BGCOLOR 8 FGCOLOR 2 FONT 6
     "TO :" VIEW-AS TEXT
          SIZE 3 BY 1 AT ROW 4.81 COL 47.83 WIDGET-ID 20
          BGCOLOR 8 FGCOLOR 2 FONT 6
     "** File Pol.Ext. D:~\temp~\policy_YYYYMMDDHHSS.csv **" VIEW-AS TEXT
          SIZE 58 BY 1 AT ROW 11.62 COL 14.5 WIDGET-ID 6
          BGCOLOR 8 FGCOLOR 6 FONT 6
     RECT-381 AT ROW 3.38 COL 1.5
     RECT-382 AT ROW 10.62 COL 83.5
     RECT-383 AT ROW 10.62 COL 73.5
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 95.5 BY 14.86
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
         TITLE              = "Match text  File Policy (THANACHAT)"
         HEIGHT             = 14.76
         WIDTH              = 94.5
         MAX-HEIGHT         = 48.76
         MAX-WIDTH          = 213.33
         VIRTUAL-HEIGHT     = 48.76
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
IF NOT C-Win:LOAD-ICON("wimage\safety":U) THEN
    MESSAGE "Unable to load icon: wimage\safety"
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
ASSIGN 
       bu_file-3:AUTO-RESIZE IN FRAME fr_main      = TRUE.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Match text  File Policy (THANACHAT) */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Match text  File Policy (THANACHAT) */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_exit-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_exit-2 C-Win
ON CHOOSE OF bu_exit-2 IN FRAME fr_main /* Exit */
DO:
  Apply "Close" to this-procedure.
  Return no-apply.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_file-3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_file-3 C-Win
ON CHOOSE OF bu_file-3 IN FRAME fr_main /* ... */
DO:
    DEFINE VARIABLE no_add        AS CHARACTER NO-UNDO.
    DEFINE VARIABLE cvData        AS CHARACTER NO-UNDO.
    DEFINE VARIABLE OKpressed AS LOGICAL INITIAL TRUE.
    SYSTEM-DIALOG GET-FILE cvData
        TITLE      "Choose Data File to Import ..."
        FILTERS    /*"Text Documents" "*.txt",*/
        "Text Documents" "*.csv",
        "Data Files (*.*)"     "*.*"
        
        MUST-EXIST
        USE-FILENAME
        UPDATE OKpressed.
    IF OKpressed = TRUE THEN DO:
        no_add =           STRING(MONTH(TODAY),"99")    + 
                            STRING(DAY(TODAY),"99")      + 
                  SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) + 
                  SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2) .
        fi_loadname  = cvData.
        nv_output = "".
       
       DISP fi_loadname  WITH FRAME fr_main .     
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_ok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_ok C-Win
ON CHOOSE OF bu_ok IN FRAME fr_main /* OK */
DO:
    ASSIGN 
        nv_reccnt  =  0
        nv_agent   = ""
        nv_agent   = INPUT fi_agent.

    For each  wdetail:
        DELETE  wdetail.
    END.
    IF fi_outload = "" THEN DO:
        MESSAGE "File name output not Empty..!!!" SKIP
            "Insert file name Output file...!!!"      VIEW-AS ALERT-BOX.
        APPLY "Entry" TO fi_outload.
        RETURN NO-APPLY.
    END.
    RUN proc_matpol.   /* �������� */
    MESSAGE "Export File Complete " VIEW-AS ALERT-BOX.
   
   
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_agent
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_agent C-Win
ON LEAVE OF fi_agent IN FRAME fr_main
DO:
  fi_agent = INPUT fi_agent.
  DISP fi_agent WITH FRAM fr_main.

   FIND sicsyac.xmm600 USE-INDEX xmm60001   WHERE
        xmm600.acno  =  Input fi_agent    NO-LOCK NO-ERROR NO-WAIT.
    IF NOT AVAIL sicsyac.xmm600 THEN DO:
        Message  "Not on Name & Address Master File xmm600" 
            View-as alert-box.
        Apply "Entry" To  fi_agent.
        Return no-apply.
    END.
    ELSE 
        ASSIGN fi_desagent =  TRIM(xmm600.ntitle) + "  "  + TRIM(sicsyac.xmm600.name) .
               fi_agent    =  CAPS(INPUT fi_agent).
    Disp  fi_agent fi_desagent  WITH Frame  fr_main. 

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_desagent
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_desagent C-Win
ON LEAVE OF fi_desagent IN FRAME fr_main
DO:
  fi_outload = INPUT fi_outload.
  DISP fi_outload WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_outload
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_outload C-Win
ON LEAVE OF fi_outload IN FRAME fr_main
DO:
  fi_outload = INPUT fi_outload.
  DISP fi_outload WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_outloadends
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_outloadends C-Win
ON LEAVE OF fi_outloadends IN FRAME fr_main
DO:
    fi_outloadends = INPUT fi_outloadends.
    DISP fi_outloadends WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_outloadmemo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_outloadmemo C-Win
ON LEAVE OF fi_outloadmemo IN FRAME fr_main
DO:
    fi_outloadmemo = INPUT fi_outloadmemo.
    DISP fi_outloadmemo WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_tranform
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_tranform C-Win
ON LEAVE OF fi_tranform IN FRAME fr_main
DO:
  fi_tranform = INPUT fi_tranform.
  DISP fi_tranform WITH FRAM fr_main.

   

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_tranto
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_tranto C-Win
ON LEAVE OF fi_tranto IN FRAME fr_main
DO:
  fi_tranform = INPUT fi_tranform.
  DISP fi_tranform WITH FRAM fr_main.

    
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

  ASSIGN 
      /*fi_agent = "A0M2016" */ /*A61-0228*/
      fi_agent       = "B3MLSCB200"     /*A61-0228*/
      gv_prgid       = "WGWMTSCB2"
      gv_prog        = "Match Text File Policy Send To SCBPT" 
      fi_tranform    = TODAY 
      fi_tranto      = TODAY 
      /*nv_time      = replace(STRING(TIME,"hh:mm:ss"),":","") --- Comment By Tontawan S. A66-0006  ---
      fi_outload     = "D:\policy_"      + STRING(YEAR(TODAY),"9999") + STRING(MONTH(TODAY),"99") + STRING(DAY(TODAY),"9999") + nv_time + ".csv"*/

      fi_outloadends = "D:\endorsement_" + STRING(YEAR(TODAY),"9999") + STRING(MONTH(TODAY),"99") + STRING(DAY(TODAY),"9999") + ".csv"
      fi_outloadmemo = "D:\memo-list_"   + STRING(YEAR(TODAY),"9999") + STRING(MONTH(TODAY),"99") + STRING(DAY(TODAY),"9999") + ".csv"
      /*-------- Add By Tontawan S. A66-0006  ---*/
      nv_time        = REPLACE(STRING(TIME,"HH:MM"),":","") 
      fi_outload     = "D:\policy_"      + STRING(YEAR(TODAY),"9999") + STRING(MONTH(TODAY),"99") + STRING(DAY(TODAY),"99") + nv_time + ".csv"
      /*-------- End By Tontawan S. A66-0006  ---*/
      .


  DISP fi_agent
       fi_outload    
       fi_outloadends        
       fi_outloadmemo  
       fi_tranto   
       fi_tranform WITH FRAME fr_main.
  RUN  WUT\WUTHEAD ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).
  
  /*********************************************************************/ 
   RUN Wut\WutwiCen ({&WINDOW-NAME}:HANDLE).  
  /*CURRENT-WINDOW:WINDOW-STATE = WINDOW-MAXIMIZED.*/
  SESSION:DATA-ENTRY-RETURN = YES.
  
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
  DISPLAY fi_agent fi_loadname fi_outload fi_desagent fi_outloadends 
          fi_outloadmemo fi_tranform fi_tranto 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE fi_agent fi_loadname bu_file-3 fi_outload bu_ok bu_exit-2 fi_desagent 
         fi_outloadends fi_outloadmemo fi_tranform fi_tranto RECT-381 RECT-382 
         RECT-383 
      WITH FRAME fr_main IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_addwdetail C-Win 
PROCEDURE proc_addwdetail :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FIND FIRST wdetail WHERE 
    wdetail.chassis = trim(n_chassis) AND
    wdetail.covtyp  = trim(n_covtyp)  NO-LOCK NO-ERROR.
IF NOT AVAIL wdetail THEN DO:
    /*RUN proc_chkaddr.*/
    CREATE wdetail.
    ASSIGN 
        wdetail.xrefno1         = trim(n_cedcode)    /*  trim(n_Agent_Code)  trim(n_cedcode)*/
        /*wdetail.InsuredName   = TRIM(n_comp_code) */ /*a61-0228*/
        /*wdetail.Barcode       = ""                */ /*a61-0228*/
        wdetail.InsuredName     = TRIM(n_pol_title ) + " " + TRIM(n_pol_fname) + " " + TRIM(n_pol_lname)  /*a61-0228*/  
        wdetail.Barcode         = TRIM(n_inscode)           /*a61-0228*/  
        wdetail.PolicyNo        = ""
        wdetail.EndorseNo       = ""
        wdetail.SumInsured      = ""
        wdetail.NetPremium      = ""
        wdetail.VatTax          = ""
        wdetail.Stamp           = ""
        wdetail.GrossPremium    = ""
        wdetail.EffectiveDate   = ""
        wdetail.ExpireDate      = ""
        wdetail.EndorseReason   = "" 
        wdetail.trntyp          = "" 
        wdetail.chassis         = trim(n_chassis) 
        wdetail.covcod          = TRIM(n_covcod) 
        wdetail.covtyp          = IF trim(n_covtyp) = "CMI" THEN "V72" ELSE "V70"
        wdetail.cmr_code        = trim(n_cmr_code)     
        wdetail.comp_code       = "����ѷ ��Сѹ������� �ӡѴ(��Ҫ�)"     
        wdetail.campcode        = trim(n_campcode)     
        wdetail.campname        = trim(n_campname)     
        wdetail.procode         = trim(n_procode)     
        wdetail.proname         = trim(n_proname)     
        wdetail.packname        = trim(n_packname)     
        wdetail.packcode        = trim(n_packcode)     
        wdetail.instype         = IF trim(n_instype) = "�ؤ�Ÿ�����" THEN "P"  ELSE IF trim(n_instype) = "�ԵԺؤ��" THEN "C" ELSE "P"
        wdetail.pol_title       = trim(n_pol_title)     
        wdetail.pol_fname       = trim(n_pol_fname)     
        wdetail.pol_lname       = IF index(n_pol_lname," ") <> 0 THEN TRIM(REPLACE(n_pol_lname," ","")) ELSE TRIM(n_pol_lname)    
        wdetail.pol_title_eng   = trim(n_pol_title_eng) 
        wdetail.pol_fname_eng   = trim(n_pol_fname_eng) 
        wdetail.pol_lname_eng   = trim(n_pol_lname_eng) 
        wdetail.icno            = trim(n_icno)         
        wdetail.sex             = trim(n_sex)         
        wdetail.bdate           = TRIM(n_bdate)      
        wdetail.occup           = trim(n_occup)         
        wdetail.tel             = trim(n_tel)         
        wdetail.phone           = trim(n_phone)         
        wdetail.teloffic        = trim(n_teloffic)      
        wdetail.telext          = trim(n_telext)      
        wdetail.moblie          = trim(n_moblie)      
        wdetail.moblie          = trim(n_mobliech)      
        wdetail.mail            = trim(n_mail)      
        wdetail.lineid          = trim(n_lineid)      
        wdetail.addr1_70        = trim(n_addr1_70)      
        wdetail.addr2_70        = trim(n_addr2_70)      
        wdetail.addr3_70        = trim(n_addr3_70)      
        wdetail.addr4_70        = trim(n_addr4_70)      
        wdetail.addr5_70        = trim(n_addr5_70)      
        wdetail.nsub_dist70     = trim(n_nsub_dist70)  
        wdetail.ndirection70    = trim(n_ndirection70) 
        wdetail.nprovin70       = trim(n_nprovin70)  
        wdetail.zipcode70       = trim(n_zipcode70)  
        wdetail.addr1_72        = trim(n_addr1_72)  
        wdetail.addr2_72        = trim(n_addr2_72)  
        wdetail.addr3_72        = trim(n_addr3_72)  
        wdetail.addr4_72        = trim(n_addr4_72)  
        wdetail.addr5_72        = trim(n_addr5_72)  
        wdetail.nsub_dist72     = trim(n_nsub_dist72)  
        wdetail.ndirection72    = trim(n_ndirection72) 
        wdetail.nprovin72       = trim(n_nprovin72)  
        wdetail.zipcode72       = trim(n_zipcode72)  
        wdetail.paytype         = trim(n_paytype)  
        wdetail.paytitle        = trim(n_paytitle)  
        wdetail.payname         = trim(n_payname)  
        wdetail.paylname        = trim(n_paylname)  
        wdetail.payicno         = trim(n_payicno)  
        wdetail.payaddr1        = trim(n_payaddr1)  
        wdetail.payaddr2        = trim(n_payaddr2)  
        wdetail.payaddr3        = trim(n_payaddr3)  
        wdetail.payaddr4        = trim(n_payaddr4)  
        wdetail.payaddr5        = trim(n_payaddr5)  
        wdetail.payaddr6        = trim(n_payaddr6)  
        wdetail.payaddr7        = trim(n_payaddr7)  
        wdetail.payaddr8        = trim(n_payaddr8)  
        wdetail.payaddr9        = trim(n_payaddr9)  
        wdetail.branch          = trim(n_branch)  
        wdetail.ben_title       = trim(n_ben_title)  
        wdetail.ben_name        = trim(n_ben_name)
        wdetail.ben_lname       = trim(n_ben_lname)  
        wdetail.pmentcode       = trim(n_pmentcode)  
        wdetail.pmenttyp        = trim(n_pmenttyp)
        wdetail.pmentcode1      = trim(n_pmentcode1)  
        wdetail.pmentcode2      = trim(n_pmentcode2)  
        wdetail.pmentbank       = trim(n_pmentbank)  
        wdetail.pmentdate       = TRIM(n_pmentdate)  
        wdetail.pmentsts        = trim(n_pmentsts)  
        wdetail.driver          = trim(n_driver)  
        wdetail.drivetitle1     = trim(n_drivetitle1)  
        wdetail.drivename1      = trim(n_drivename1)  
        wdetail.drivelname1     = trim(n_drivelname1)  
        wdetail.driveno1        = trim(n_driveno1)  
        wdetail.occupdriv1      = trim(n_occupdriv1)  
        wdetail.sexdriv1        = trim(n_sexdriv1)  
        wdetail.bdatedriv1      = IF n_bdatedriv1 = "?" OR n_bdatedriv1 = "" THEN "" ELSE TRIM(n_bdatedriv1) 
        wdetail.drivetitle2     = trim(n_drivetitle2)  
        wdetail.drivename2      = trim(n_drivename2)  
        wdetail.drivelname2     = trim(n_drivelname2)  
        wdetail.driveno2        = trim(n_driveno2)  
        wdetail.occupdriv2      = trim(n_occupdriv2)  
        wdetail.sexdriv2        = trim(n_sexdriv2)  
        wdetail.bdatedriv2      = IF n_bdatedriv2 = "?" OR n_bdatedriv2 = "" THEN "" ELSE TRIM(n_bdatedriv2)
        /*-- Add By Tontawan S. A68-0059 27/03/2025 --*/
        wdetail.drv3_salutation_M   = TRIM(n_drv3_salutation_M)
        wdetail.drv3_fname          = TRIM(n_drv3_fname)       
        wdetail.drv3_lname          = TRIM(n_drv3_lname)       
        wdetail.drv3_nid            = TRIM(n_drv3_nid)       
        wdetail.drv3_occupation     = TRIM(n_drv3_occupation)  
        wdetail.drv3_gender         = TRIM(n_drv3_gender)      
        wdetail.drv3_birthdate      = TRIM(n_drv3_birthdate)   
        wdetail.drv4_salutation_M   = TRIM(n_drv4_salutation_M)
        wdetail.drv4_fname          = TRIM(n_drv4_fname)
        wdetail.drv4_lname          = TRIM(n_drv4_lname)
        wdetail.drv4_nid            = TRIM(n_drv4_nid)
        wdetail.drv4_occupation     = TRIM(n_drv4_occupation)
        wdetail.drv4_gender         = TRIM(n_drv4_gender)
        wdetail.drv4_birthdate      = TRIM(n_drv4_birthdate) 
        wdetail.drv5_salutation_M   = TRIM(n_drv5_salutation_M)
        wdetail.drv5_fname          = TRIM(n_drv5_fname)
        wdetail.drv5_lname          = TRIM(n_drv5_lname)
        wdetail.drv5_nid            = TRIM(n_drv5_nid)
        wdetail.drv5_occupation     = TRIM(n_drv5_occupation)
        wdetail.drv5_gender         = TRIM(n_drv5_gender)      
        wdetail.drv5_birthdate      = TRIM(n_drv5_birthdate) 
        wdetail.drv1_dlicense       = TRIM(n_drv1_dlicense)    
        wdetail.drv2_dlicense       = TRIM(n_drv2_dlicense)    
        wdetail.drv3_dlicense       = TRIM(n_drv3_dlicense)    
        wdetail.drv4_dlicense       = TRIM(n_drv4_dlicense)    
        wdetail.drv5_dlicense       = TRIM(n_drv5_dlicense)    
        wdetail.baty_snumber        = n_baty_snumber     
        wdetail.batydate            = n_batydate         
        wdetail.baty_rsi            = n_baty_rsi         
        wdetail.baty_npremium       = n_baty_npremium    
        wdetail.baty_gpremium       = n_baty_gpremium    
        wdetail.wcharge_snumber     = n_wcharge_snumber  
        wdetail.wcharge_si          = n_wcharge_si       
        wdetail.wcharge_npremium    = n_wcharge_npremium 
        wdetail.wcharge_gpremium    = n_wcharge_gpremium.
        /*-- End By Tontawan S. A68-0059 27/03/2025 --*/

    CREATE wdetail2.
    ASSIGN
        wdetail2.chassis        = trim(n_chassis) 
        wdetail2.covcod         = TRIM(n_covcod) 
        wdetail2.covtyp         = IF trim(n_covtyp) = "CMI" THEN "V72" ELSE "V70"
        wdetail2.brand           = trim(n_brand)    
        wdetail2.brand_cd        = trim(n_brand_cd)    
        wdetail2.Model           = trim(n_Model)    
        wdetail2.Model_cd        = trim(n_Model_cd)    
        wdetail2.body            = trim(n_body)    
        wdetail2.body_cd         = trim(n_body_cd)    
        wdetail2.licence         = trim(n_licence)    
        wdetail2.province        = trim(n_province)    
        wdetail2.chassis         = trim(n_chassis)    
        wdetail2.engine          = trim(n_engine)    
        wdetail2.yrmanu          = trim(n_yrmanu)    
        wdetail2.seatenew        = trim(n_seatenew)    
        wdetail2.power           = trim(n_power)    
        wdetail2.weight          = trim(n_weight)    
        wdetail2.class           = trim(n_class)    
        wdetail2.garage_cd       = trim(n_garage_cd)    
        wdetail2.garage          = trim(n_garage)    
        wdetail2.colorcode       = trim(n_colorcode)    
        wdetail2.covcod          = trim(n_covcod)    
        wdetail2.covtyp          = IF trim(n_covtyp) = "CMI" THEN "V72" ELSE "V70"  
        wdetail2.covtyp1         = trim(n_covtyp1)    
        wdetail2.covtyp2         = trim(n_covtyp2)    
        wdetail2.covtyp3         = trim(n_covtyp3)    
        wdetail2.comdat          = trim(n_comdat)    
        wdetail2.expdat          = trim(n_expdat)    
        wdetail2.ins_amt         = trim(n_ins_amt)    
        wdetail2.prem1           = trim(n_prem1)    
        wdetail2.gross_prm       = trim(n_gross_prm)    
        wdetail2.stamp           = trim(n_stamp)    
        wdetail2.vat             = trim(n_vat)    
        wdetail2.premtotal       = trim(n_premtotal)    
        wdetail2.deduct          = trim(n_deduct)    
        wdetail2.fleetper        = IF INDEX(n_fleetper,"%") <> 0 THEN REPLACE(n_fleetper,"%","") ELSE trim(n_fleetper)    
        wdetail2.fleet           = trim(n_fleet)    
        wdetail2.ncbper          = IF INDEX(n_ncbper,"%") <> 0 THEN REPLACE(n_ncbper,"%","") ELSE trim(n_ncbper)    
        wdetail2.ncb             = trim(n_ncb )  
        wdetail2.drivper         = IF INDEX(n_drivper,"%") <> 0 THEN REPLACE(n_drivper,"%","") ELSE trim(n_drivper)    
        wdetail2.drivdis         = trim(n_drivdis)    
        wdetail2.othper          = IF INDEX(n_othper,"%") <> 0 THEN REPLACE(n_othper,"%","") ELSE trim(n_othper)    
        wdetail2.oth             = trim(n_oth )  
        wdetail2.cctvper         = IF INDEX(n_cctvper,"%") <> 0 THEN REPLACE(n_cctvper,"%","") ELSE trim(n_cctvper)    
        wdetail2.cctv            = trim(n_cctv)    
        wdetail2.Surcharper      = IF INDEX(n_Surcharper,"%") <> 0 THEN REPLACE(n_Surcharper,"%","") ELSE trim(n_Surcharper)   
        wdetail2.Surchar         = trim(n_Surchar)
        wdetail2.Surchardetail   = trim(n_Surchardetail)
        wdetail2.acc1            = trim(n_acc1) 
        wdetail2.accdetail1      = trim(n_accdetail1)   
        wdetail2.accprice1       = trim(n_accprice1)
        wdetail2.acc2            = trim(n_acc2) 
        wdetail2.accdetail2      = trim(n_accdetail2)   
        wdetail2.accprice2       = trim(n_accprice2)
        wdetail2.acc3            = trim(n_acc3) 
        wdetail2.accdetail3      = trim(n_accdetail3)   
        wdetail2.accprice3       = trim(n_accprice3)
        wdetail2.acc4            = trim(n_acc4) 
        wdetail2.accdetail4      = trim(n_accdetail4)   
        wdetail2.accprice4       = trim(n_accprice4)
        wdetail2.acc5            = trim(n_acc5) 
        wdetail2.accdetail5      = trim(n_accdetail5)   
        wdetail2.accprice5       = trim(n_accprice5)
        wdetail2.inspdate        = IF n_inspdate     = "" THEN "" ELSE trim(n_inspdate)
        wdetail2.inspdate_app    = IF n_inspdate_app = "" THEN "" ELSE trim(n_inspdate_app) 
        wdetail2.inspsts         = trim(n_inspsts)
        wdetail2.inspdetail      = trim(n_inspdetail)
        wdetail2.not_date        = IF n_not_date = "" THEN "" ELSE trim(n_not_date)
        wdetail2.paydate         = IF n_paydate  = "" THEN "" ELSE trim(n_paydate)
        wdetail2.paysts          = trim(n_paysts)
        wdetail2.licenBroker     = "�00012/2560"                     
        wdetail2.brokname        = "����ѷ �¾ҳԪ�� ��෤ �ӡѴ"  
        wdetail2.brokcode        = "90004601"                       
        wdetail2.lang            = "������"                       
        wdetail2.deli            = "�Ѻ��������ҧ��ɳ��� (�ж١�Ѵ������ 7-14 �ѹ�ӡ��)"
        wdetail2.delidetail      = trim(n_delidetail)
        wdetail2.gift            = trim(n_gift) 
        wdetail2.cedcode         = trim(n_cedcode)  
        wdetail2.inscode         = trim(n_inscode)  
        wdetail2.remark          = trim(n_remark)  
        wdetail2.ben_2title      = trim(n_ben_2title)        /*Add Kridtiya i. A64-0295 DATE. 25/07/2021*/ 
        wdetail2.ben_2name       = trim(n_ben_2name)         /*Add Kridtiya i. A64-0295 DATE. 25/07/2021*/ 
        wdetail2.ben_2lname      = trim(n_ben_2lname)        /*Add Kridtiya i. A64-0295 DATE. 25/07/2021*/ 
        wdetail2.ben_3title      = trim(n_ben_3title)        /*Add Kridtiya i. A64-0295 DATE. 25/07/2021*/ 
        wdetail2.ben_3name       = trim(n_ben_3name)         /*Add Kridtiya i. A64-0295 DATE. 25/07/2021*/ 
        wdetail2.ben_3lname      = trim(n_ben_3lname)        /*Add Kridtiya i. A64-0295 DATE. 25/07/2021*/ 
        wdetail2.Agent_Code      = trim(n_Agent_Code)        /*Add Kridtiya i. A64-0295 DATE. 25/07/2021*/ 
        wdetail2.Agent_Name_TH   = trim(n_Agent_Name_TH)     /*Add Kridtiya i. A64-0295 DATE. 25/07/2021*/ 
        wdetail2.Agent_Name_Eng  = trim(n_Agent_Name_Eng)    /*Add Kridtiya i. A64-0295 DATE. 25/07/2021*/ 
        wdetail2.Selling_Channel = "TSR"   . /*Add Kridtiya i. A64-0295 DATE. 25/07/2021*/ 

        ASSIGN wdetail2.comdat_old    = trim(n_comdat)    
               wdetail2.expdat_old    = trim(n_expdat)    
               wdetail2.ins_amt_old   = trim(n_ins_amt)   
               wdetail2.prem1_old     = trim(n_prem1)     
               wdetail2.gross_prm_old = trim(n_gross_prm) 
               wdetail2.stamp_old     = trim(n_stamp)     
               wdetail2.vat_old       = trim(n_vat)       
               wdetail2.premtotal_old = trim(n_premtotal).  
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_cleardata C-Win 
PROCEDURE proc_cleardata :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN   n_cmr_code        = ""         
         n_comp_code       = ""         
         n_campcode        = ""         
         n_campname        = ""         
         n_procode         = ""         
         n_proname         = ""         
         n_packname        = ""         
         n_packcode        = ""         
         n_instype         = ""         
         n_pol_title       = ""         
         n_pol_fname       = ""         
         n_pol_lname       = ""         
         n_pol_title_eng   = ""         
         n_pol_fname_eng   = ""         
         n_pol_lname_eng   = ""         
         n_icno            = ""         
         n_sex             = ""         
         n_bdate           = ""         
         n_occup           = ""         
         n_tel             = ""         
         n_phone           = ""         
         n_teloffic        = ""         
         n_telext          = ""         
         n_moblie          = ""         
         n_mobliech        = ""         
         n_mail            = ""         
         n_lineid          = ""         
         n_addr1_70        = ""         
         n_addr2_70        = ""         
         n_addr3_70        = ""         
         n_addr4_70        = ""         
         n_addr5_70        = ""         
         n_nsub_dist70     = ""         
         n_ndirection70    = ""         
         n_nprovin70       = ""         
         n_zipcode70       = ""         
         n_addr1_72        = ""         
         n_addr2_72        = ""         
         n_addr3_72        = ""         
         n_addr4_72        = ""         
         n_addr5_72        = ""         
         n_nsub_dist72     = ""         
         n_ndirection72    = ""         
         n_nprovin72       = ""         
         n_zipcode72       = ""         
         n_paytype         = ""         
         n_paytitle        = ""         
         n_payname         = ""         
         n_paylname        = ""         
         n_payicno         = ""         
         n_payaddr1        = ""         
         n_payaddr2        = ""         
         n_payaddr3        = ""         
         n_payaddr4        = ""         
         n_payaddr5        = ""         
         n_payaddr6        = ""         
         n_payaddr7        = ""         
         n_payaddr8        = ""         
         n_payaddr9        = ""         
         n_branch          = ""         
         n_ben_title       = ""         
         n_ben_name        = ""         
         n_ben_lname       = ""         
         n_ben_2title      = ""         
         n_ben_2name       = ""         
         n_ben_2lname      = ""         
         n_ben_3title      = ""         
         n_ben_3name       = ""         
         n_ben_3lname      = ""         
         n_pmentcode       = ""         
         n_pmenttyp        = ""         
         n_pmentcode1      = ""         
         n_pmentcode2      = ""         
         n_pmentbank       = ""         
         n_pmentdate       = ""         
         n_pmentsts        = ""         
         n_driver          = ""         
         n_drivetitle1     = ""         
         n_drivename1      = ""         
         n_drivelname1     = ""         
         n_driveno1        = ""         
         n_occupdriv1      = ""         
         n_sexdriv1        = ""         
         n_bdatedriv1      = ""         
         n_drivetitle2     = ""         
         n_drivename2      = ""         
         n_drivelname2     = ""         
         n_driveno2        = ""         
         n_occupdriv2      = ""         
         n_sexdriv2        = ""         
         n_bdatedriv2      = ""         
         n_brand           = ""         
         n_brand_cd        = ""         
         n_Model           = ""         
         n_Model_cd        = ""         
         n_body            = ""         
         n_body_cd         = ""         
         n_licence         = ""         
         n_province        = ""         
         n_chassis         = ""         
         n_engine          = ""         
         n_yrmanu          = ""         
         n_seatenew        = ""         
         n_power           = ""         
         n_weight          = ""         
         n_class           = ""         
         n_garage_cd       = ""         
         n_garage          = ""         
         n_colorcode       = ""         
         n_covcod          = ""         
         n_covtyp          = ""         
         n_covtyp1         = ""         
         n_covtyp2         = ""         
         n_covtyp3         = ""         
         n_comdat          = ""         
         n_expdat          = ""         
         n_ins_amt         = ""         
         n_prem1           = ""         
         n_gross_prm       = ""         
         n_stamp           = ""         
         n_vat             = ""         
         n_premtotal       = ""         
         n_deduct          = ""         
         n_fleetper        = ""         
         n_fleet           = ""         
         n_ncbper          = ""         
         n_ncb             = ""         
         n_drivper         = ""         
         n_drivdis         = ""         
         n_othper          = ""         
         n_oth             = ""         
         n_cctvper         = ""         
         n_cctv            = ""         
         n_Surcharper      = ""         
         n_Surchar         = ""         
         n_Surchardetail   = ""         
         n_acc1            = ""         
         n_accdetail1      = ""         
         n_accprice1       = ""         
         n_acc2            = ""         
         n_accdetail2      = ""         
         n_accprice2       = ""         
         n_acc3            = ""         
         n_accdetail3      = ""         
         n_accprice3       = ""         
         n_acc4            = ""         
         n_accdetail4      = ""         
         n_accprice4       = ""         
         n_acc5            = ""         
         n_accdetail5      = ""         
         n_accprice5       = ""         
         n_inspdate        = ""         
         n_inspdate_app    = ""         
         n_inspsts         = ""         
         n_inspdetail      = ""         
         n_not_date        = ""         
         n_paydate         = ""         
         n_paysts          = ""         
         n_licenBroker     = ""         
         n_brokname        = ""         
         n_brokcode        = ""         
         n_lang            = ""  
         n_deli            = ""    
         n_delidetail      = ""    
         n_gift            = ""    
         n_cedcode         = ""    
         n_inscode         = ""    
         n_remark          = ""    
         n_Agent_Code      = ""    
         n_Agent_Name_TH   = ""    
         n_Agent_Name_Eng  = ""    
         n_Selling_Channel = "" 
         /*-- Add By Tontawan S. A68-0059 27/03/2025 --*/
         n_drv3_salutation_M = ""
         n_drv3_fname        = ""
         n_drv3_lname        = ""
         n_drv3_nid          = ""
         n_drv3_occupation   = ""
         n_drv3_gender       = ""
         n_drv3_birthdate    = ""
         n_drv4_salutation_M = ""
         n_drv4_fname        = ""
         n_drv4_lname        = ""
         n_drv4_nid          = ""
         n_drv4_occupation   = ""
         n_drv4_gender       = ""
         n_drv4_birthdate    = ""
         n_drv5_salutation_M = ""
         n_drv5_fname        = ""
         n_drv5_lname        = ""
         n_drv5_nid          = ""
         n_drv5_occupation   = ""
         n_drv5_gender       = ""
         n_drv5_birthdate    = ""
         n_drv1_dlicense     = ""
         n_drv2_dlicense     = ""
         n_drv3_dlicense     = ""
         n_drv4_dlicense     = ""
         n_drv5_dlicense     = ""
         n_baty_snumber      = ""
         n_batydate          = ""
         n_baty_rsi          = ""
         n_baty_npremium     = ""
         n_baty_gpremium     = ""
         n_wcharge_snumber   = ""
         n_wcharge_si        = ""
         n_wcharge_npremium  = ""
         n_wcharge_gpremium  = "".
         /*-- End By Tontawan S. A68-0059 27/03/2025 --*/  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_matpol C-Win 
PROCEDURE proc_matpol :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH wdetail :
    DELETE wdetail.
END.
RUN Proc_Cleardata.
INPUT FROM VALUE(fi_loadName).
REPEAT:
    IMPORT DELIMITER "|"
        n_cmr_code     
        n_comp_code    
        n_campcode     
        n_campname     
        n_procode      
        n_proname      
        n_packname     
        n_packcode     
        n_instype      
        n_pol_title    
        n_pol_fname    
        n_pol_lname    
        n_pol_title_eng
        n_pol_fname_eng
        n_pol_lname_eng
        n_icno         
        n_sex          
        n_bdate        
        n_occup        
        n_tel          
        n_phone        
        n_teloffic     
        n_telext       
        n_moblie       
        n_mobliech     
        n_mail         
        n_lineid       
        n_addr1_70          /*�Ţ����ҹ   */  
        n_addr2_70          /*�����ҹ     */ 
        n_addr3_70          /*����         */ 
        n_addr4_70          /*���          */ 
        n_addr5_70          /*���          */ 
        n_nsub_dist70       /*�����ǧ     */ 
        n_ndirection70      /*ࢵ/�����    */ 
        n_nprovin70         /*�ѧ��Ѵ      */ 
        n_zipcode70         /*������ɳ��� */ 
        n_addr1_72          /*�Ţ����ҹ   �Ѵ�� */ 
        n_addr2_72          /*�����ҹ     �Ѵ�� */ 
        n_addr3_72          /*����         �Ѵ�� */ 
        n_addr4_72          /*���          �Ѵ�� */ 
        n_addr5_72          /*���          �Ѵ�� */ 
        n_nsub_dist72       /*�����ǧ     �Ѵ�� */ 
        n_ndirection72      /*ࢵ/�����    �Ѵ�� */ 
        n_nprovin72         /*�ѧ��Ѵ      �Ѵ�� */ 
        n_zipcode72         /*������ɳ��� �Ѵ�� */ 
        n_paytype         
        n_paytitle     
        n_payname      
        n_paylname     
        n_payicno      
        n_payaddr1          /*�Ţ����ҹ   �����Թ */      
        n_payaddr2          /*�����ҹ     �����Թ */   
        n_payaddr3          /*����         �����Թ */   
        n_payaddr4          /*���          �����Թ */   
        n_payaddr5          /*���          �����Թ */   
        n_payaddr6          /*�����ǧ     �����Թ */   
        n_payaddr7          /*ࢵ/�����    �����Թ */   
        n_payaddr8          /*�ѧ��Ѵ      �����Թ */   
        n_payaddr9          /*������ɳ��� �����Թ */   
        n_branch       
        n_ben_title         
        n_ben_name          
        n_ben_lname         
        n_ben_2title        /*Kridtiya i. A64-0295 DATE. 25/07/2021 */  
        n_ben_2name         /*Kridtiya i. A64-0295 DATE. 25/07/2021 */  
        n_ben_2lname        /*Kridtiya i. A64-0295 DATE. 25/07/2021 */  
        n_ben_3title        /*Kridtiya i. A64-0295 DATE. 25/07/2021 */  
        n_ben_3name         /*Kridtiya i. A64-0295 DATE. 25/07/2021 */  
        n_ben_3lname        /*Kridtiya i. A64-0295 DATE. 25/07/2021 */ 
        n_pmentcode    
        n_pmenttyp     
        n_pmentcode1   
        n_pmentcode2   
        n_pmentbank    
        n_pmentdate    
        n_pmentsts     
        n_driver       
        n_drivetitle1  
        n_drivename1   
        n_drivelname1  
        n_driveno1     
        n_occupdriv1   
        n_sexdriv1     
        n_bdatedriv1   
        n_drivetitle2  
        n_drivename2   
        n_drivelname2  
        n_driveno2     
        n_occupdriv2   
        n_sexdriv2     
        n_bdatedriv2   
        n_brand        
        n_brand_cd     
        n_Model        
        n_Model_cd     
        n_body         
        n_body_cd      
        n_licence      
        n_province     
        n_chassis      
        n_engine       
        n_yrmanu       
        n_seatenew     
        n_power        
        n_weight       
        n_class        
        n_garage_cd    
        n_garage       
        n_colorcode    
        n_covcod       
        n_covtyp       
        n_covtyp1      
        n_covtyp2      
        n_covtyp3      
        n_comdat       
        n_expdat       
        n_ins_amt      
        n_prem1        
        n_gross_prm    
        n_stamp        
        n_vat          
        n_premtotal    
        n_deduct       
        n_fleetper     
        n_fleet        
        n_ncbper       
        n_ncb          
        n_drivper      
        n_drivdis      
        n_othper       
        n_oth          
        n_cctvper      
        n_cctv         
        n_Surcharper   
        n_Surchar      
        n_Surchardetail
        n_acc1         
        n_accdetail1   
        n_accprice1    
        n_acc2         
        n_accdetail2   
        n_accprice2    
        n_acc3         
        n_accdetail3   
        n_accprice3    
        n_acc4         
        n_accdetail4   
        n_accprice4    
        n_acc5         
        n_accdetail5   
        n_accprice5    
        n_inspdate     
        n_inspdate_app 
        n_inspsts      
        n_inspdetail   
        n_not_date
        n_licenBroker  
        n_brokname     
        n_brokcode     
        n_lang         
        n_deli         
        n_delidetail   
        n_gift         
        n_cedcode      
        n_inscode      
        n_remark
        n_Agent_Code            /*Kridtiya i. A64-0295 DATE. 25/07/2021 */
        n_Agent_Name_TH         /*Kridtiya i. A64-0295 DATE. 25/07/2021 */
        n_Agent_Name_Eng        /*Kridtiya i. A64-0295 DATE. 25/07/2021 */
        n_Selling_Channel       /*Kridtiya i. A64-0295 DATE. 25/07/2021 */
        /*-- Add By Tontawan S. A68-0059 27/03/2025 --*/
        n_drv3_salutation_M       // ���Ѻ 3 : �ӹ�˹��          
        n_drv3_fname              // ���Ѻ 3 : ����              
        n_drv3_lname              // ���Ѻ 3 : ���ʡ��           
        n_drv3_nid                // ���Ѻ 3 : �Ţ�ѵû�ЪҪ�    
        n_drv3_occupation         // ���Ѻ 3 : �Ҫվ             
        n_drv3_gender             // ���Ѻ 3 : ��               
        n_drv3_birthdate          // ���Ѻ 3 : �ѹ�Դ           
        n_drv4_salutation_M       // ���Ѻ 4 : �ӹ�˹��          
        n_drv4_fname              // ���Ѻ 4 : ����              
        n_drv4_lname              // ���Ѻ 4 : ���ʡ��           
        n_drv4_nid                // ���Ѻ 4 : �Ţ�ѵû�ЪҪ�    
        n_drv4_occupation         // ���Ѻ 4 : �Ҫվ             
        n_drv4_gender             // ���Ѻ 4 : ��               
        n_drv4_birthdate          // ���Ѻ 4 : �ѹ�Դ           
        n_drv5_salutation_M       // ���Ѻ 5 : �ӹ�˹��          
        n_drv5_fname              // ���Ѻ 5 : ����              
        n_drv5_lname              // ���Ѻ 5 : ���ʡ��           
        n_drv5_nid                // ���Ѻ 5 : �Ţ�ѵû�ЪҪ�    
        n_drv5_occupation         // ���Ѻ 5 : �Ҫվ             
        n_drv5_gender             // ���Ѻ 5 : ��               
        n_drv5_birthdate          // ���Ѻ 5 : �ѹ�Դ           
        n_drv1_dlicense           // ���Ѻ 1 : ���ʼ��Ѻ��� 1         
        n_drv2_dlicense           // ���Ѻ 2 : ���ʼ��Ѻ��� 2         
        n_drv3_dlicense           // ���Ѻ 3 : ���ʼ��Ѻ��� 3         
        n_drv4_dlicense           // ���Ѻ 4 : ���ʼ��Ѻ��� 4         
        n_drv5_dlicense           // ���Ѻ 5 : ���ʼ��Ѻ��� 5         
        n_baty_snumber            // Battery : Serial Number     
        n_batydate                // Battery : Year              
        n_baty_rsi                // Battery : Replacement SI    
        n_baty_npremium           // Battery : Net Premium       
        n_baty_gpremium           // Battery : Gross_Premium     
        n_wcharge_snumber         // Wall Charge : Serial_Number 
        n_wcharge_si              // Wall Charge : SI            
        n_wcharge_npremium        // Wall Charge : Net Premium   
        n_wcharge_gpremium.       // Wall Charge : Gross Premium 
        /*-- End By Tontawan S. A68-0059 27/03/2025 --*/

       IF n_cmr_code = "" THEN NEXT.
       ELSE IF index(n_cmr_code,"Insurer") <> 0 THEN NEXT.
       ELSE DO:
          /*comment by Kridtiya i. A64-0295 DATE. 25/07/2021 
           CREATE wdetail.
           ASSIGN   wdetail.xrefno1        = trim(n_cedcode)
                    /*wdetail.InsuredName    = TRIM(n_comp_code) */ /*a61-0228*/
                    /*wdetail.Barcode        = ""                */ /*a61-0228*/
                    wdetail.InsuredName    = TRIM(n_pol_title ) + " " + TRIM(n_pol_fname) + " " + TRIM(n_pol_lname)  /*a61-0228*/  
                    wdetail.Barcode        = TRIM(n_inscode)           /*a61-0228*/  
                    wdetail.PolicyNo       = ""
                    wdetail.EndorseNo      = ""
                    wdetail.SumInsured     = ""
                    wdetail.NetPremium     = ""
                    wdetail.VatTax         = ""
                    wdetail.Stamp          = ""
                    wdetail.GrossPremium   = ""
                    wdetail.EffectiveDate  = ""
                    wdetail.ExpireDate     = ""
                    wdetail.EndorseReason  = "" 
                    wdetail.trntyp         = "" .       /*A61-0228*/
           end...comment by Kridtiya i. A64-0295 DATE. 25/07/2021 */
           RUN proc_addwdetail.
           RUN proc_cleardata.
       END.
END.  /* repeat  */ 
/* �ҡ�������ҡ����駧ҹ */
RUN proc_matpol_new .  /*Add by Kridtiya i. A64-0295 DATE. 25/07/2021 */
    
/*comment by by Kridtiya i. A64-0295 DATE. 25/07/2021...
FOR EACH wdetail .
    IF index(wdetail.xrefno1,"refno") <> 0  THEN DELETE wdetail.
    ELSE IF TRIM(wdetail.xrefno1) = "" THEN DELETE wdetail.
    ELSE DO:
        ASSIGN n_taxp = 0       ut_net = 0      ut_stamp = 0        ut_vat = 0      ut_total = 0 .
        FIND FIRST sicuw.uwm100 USE-INDEX uwm10002 WHERE sicuw.uwm100.cedpol = trim(wdetail.xrefno1)  NO-LOCK NO-ERROR.
        IF AVAIL uwm100 THEN DO:
            /*IF uwm100.releas = NO THEN NEXT.*/
            ASSIGN  
                wdetail.EndorseNo      = ""
                wdetail.policyno       = sicuw.uwm100.policy                                                        
                wdetail.EffectiveDate  = STRING(sicuw.uwm100.comdat,"99/99/9999")  
                wdetail.ExpireDate     = STRING(sicuw.uwm100.expdat,"99/99/9999")
                n_taxp                 = sicuw.uwm100.gstrat
                wdetail.trntyp         = IF uwm100.poltyp = "V70" THEN "VMI" ELSE "CMI" . /*a61-0228*/
                                                                                  
                FIND FIRST sicuw.uwm130 USE-INDEX uwm13001 WHERE
                    sicuw.uwm130.policy = uwm100.policy  AND
                    sicuw.uwm130.rencnt = uwm100.rencnt  AND   
                    sicuw.uwm130.endcnt = uwm100.endcnt  AND 
                    sicuw.uwm130.riskgp = 0              AND
                    sicuw.uwm130.riskno = 1              AND
                    sicuw.uwm130.itemno = 1              NO-LOCK NO-ERROR.
        
                IF AVAIL uwm130 THEN DO:
                     ASSIGN 
                         /*wdetail.SumInsured   = IF uwm100.poltyp = "V72" THEN "0" ELSE STRING(uwm130.uom7_v,">>>,>>>,>>9.99")
                            wdetail.Sumfire      = IF uwm100.poltyp = "V72" THEN "0" ELSE STRING(uwm130.uom6_v,">>>,>>>,>>9.99").*/ /*A61-0228*/
                         
                            wdetail.SumInsured   = IF uwm100.poltyp = "V72" THEN "0" ELSE STRING(uwm130.uom6_v,">>>,>>>,>>9.99")
                            wdetail.Sumfire      = IF uwm100.poltyp = "V72" THEN "0" ELSE STRING(uwm130.uom7_v,">>>,>>>,>>9.99"). /*A61-0322*/
        
                    FOR EACH sicuw.uwd132 USE-INDEX uwd13290
                    WHERE sicuw.uwd132.policy = sicuw.uwm130.policy AND
                          sicuw.uwd132.rencnt = sicuw.uwm130.rencnt AND
                          sicuw.uwd132.endcnt = sicuw.uwm130.endcnt AND
                          sicuw.uwd132.riskgp = sicuw.uwm130.riskgp AND
                          sicuw.uwd132.riskno = sicuw.uwm130.riskno AND
                          sicuw.uwd132.itemno = sicuw.uwm130.itemno NO-LOCK .
                   
                           ASSIGN ut_net   = ut_net + uwd132.prem_c
                                  ut_stamp = (ut_net) * 0.4 / 100.
        
                                  IF ut_stamp - TRUNCATE(ut_stamp,0) > 0 THEN ut_stamp = TRUNCATE(ut_stamp,0) + 1.
                                  ut_vat   = (ut_net + ut_stamp) * n_taxp / 100.
                                  ut_total = ut_net  + ut_stamp + ut_vat.
                    END.
                    ASSIGN wdetail.NetPremium   =  string(ut_net,">>>,>>>,>>9.99")
                           wdetail.VatTax       =  string(ut_vat,">>,>>9.99")
                           wdetail.Stamp        =  string(ut_stamp,">,>>9.99")
                           wdetail.GrossPremium =  string(ut_total,">>>,>>>,>>9.99") .
                END.
        END.
        ELSE DO:
            ASSIGN wdetail.PolicyNo       = ""
                   wdetail.EndorseNo      = ""
                   wdetail.SumInsured     = ""
                   wdetail.sumfire        = ""  /*A61-0228*/
                   wdetail.NetPremium     = ""
                   wdetail.VatTax         = ""
                   wdetail.Stamp          = ""
                   wdetail.GrossPremium   = ""
                   wdetail.EffectiveDate  = ""
                   wdetail.ExpireDate     = ""
                   wdetail.EndorseReason  = "" 
                   wdetail.trntyp         = "" . /*a61-0228*/
        END.
        RELEASE uwm100.
        RELEASE uwm130.
        RELEASE uwd132.
    END.
END.
RELEASE wdetail.
comment by Kridtiya i. A64-0295 DATE. 25/07/2021 ..........*/

/* �Ң����š����������ա����ѡ��ѧ = Today */
ASSIGN n_taxp  = 0       ut_net  = 0      ut_stamp = 0        ut_vat = 0      ut_total = 0  
       nv_fptr = 0       nv_bptr = 0      nv_txt5  = "".

RUN proc_matpol_neweds.  /*Add by Kridtiya i. A64-0295 DATE. 25/07/2021 ..........*/
/*comment by Kridtiya i. A64-0295 DATE. 25/07/2021 ..........
FOR EACH sicuw.uwm100 USE-INDEX uwm10008 WHERE sicuw.uwm100.trndat = TODAY    AND
                                               sicuw.uwm100.acno1  = nv_agent NO-LOCK .
    IF uwm100.endcnt < 1 THEN NEXT.
   /* IF uwm100.releas = NO THEN NEXT.*/
    CREATE wdetail.
    ASSIGN  wdetail.xrefno1        = sicuw.uwm100.cedpol
            wdetail.InsuredName    = "����ѷ ��Сѹ������� �ӡѴ (��Ҫ�)"
            wdetail.EndorseNo      = sicuw.uwm100.endno
            wdetail.policyno       = sicuw.uwm100.policy                                                        
            wdetail.EffectiveDate  = STRING(sicuw.uwm100.comdat,"99/99/9999")  
            wdetail.ExpireDate     = STRING(sicuw.uwm100.expdat,"99/99/9999")
            n_taxp                 = sicuw.uwm100.gstrat
            wdetail.trntyp         = IF uwm100.poltyp = "V70" THEN "VMI" ELSE "CMI" . /*a61-0228*/

    FIND FIRST sicuw.uwm130 USE-INDEX uwm13001 WHERE
        sicuw.uwm130.policy = uwm100.policy  AND
        sicuw.uwm130.rencnt = uwm100.rencnt AND   
        sicuw.uwm130.endcnt = uwm100.endcnt AND 
        sicuw.uwm130.riskgp = 0             AND
        sicuw.uwm130.riskno = 1             AND
        sicuw.uwm130.itemno = 1             NO-LOCK NO-ERROR.

    IF AVAIL uwm130 THEN DO:
         ASSIGN /*wdetail.SumInsured   = IF uwm100.poltyp = "V72" THEN "0" ELSE STRING(uwm130.uom7_v,">>>,>>>,>>9.99")
                wdetail.Sumfire      = IF uwm100.poltyp = "V72" THEN "0" ELSE STRING(uwm130.uom6_v,">>>,>>>,>>9.99").*/ /*A61-0228*/

                wdetail.SumInsured   = IF uwm100.poltyp = "V72" THEN "0" ELSE STRING(uwm130.uom6_v,">>>,>>>,>>9.99")
                wdetail.Sumfire      = IF uwm100.poltyp = "V72" THEN "0" ELSE STRING(uwm130.uom7_v,">>>,>>>,>>9.99"). /*A61-0322*/

        FOR EACH sicuw.uwd132 USE-INDEX uwd13290
        WHERE sicuw.uwd132.policy = sicuw.uwm130.policy AND
              sicuw.uwd132.rencnt = sicuw.uwm130.rencnt AND
              sicuw.uwd132.endcnt = sicuw.uwm130.endcnt AND
              sicuw.uwd132.riskgp = sicuw.uwm130.riskgp AND
              sicuw.uwd132.riskno = sicuw.uwm130.riskno AND
              sicuw.uwd132.itemno = sicuw.uwm130.itemno NO-LOCK .
       
               ASSIGN ut_net   = ut_net + uwd132.prem_c
                      ut_stamp = (ut_net) * 0.4 / 100.

                      IF ut_stamp - TRUNCATE(ut_stamp,0) > 0 THEN ut_stamp = TRUNCATE(ut_stamp,0) + 1.
                      ut_vat   = (ut_net + ut_stamp) * n_taxp / 100.
                      ut_total = ut_net  + ut_stamp + ut_vat.
        END.
        ASSIGN wdetail.NetPremium   =  string(ut_net,">>>,>>>,>>9.99")
               wdetail.VatTax       =  string(ut_vat,">>,>>9.99")
               wdetail.Stamp        =  string(ut_stamp,">,>>9.99")
               wdetail.GrossPremium =  string(ut_total,">>>,>>>,>>9.99") .
    END.
    nv_txt5 = "" .
    IF sicuw.uwm100.endcnt > 0 THEN DO:
        ASSIGN
           nv_txt5 = ""
           nv_fptr = 0
           nv_bptr = 0
           nv_fptr = sicuw.uwm100.fptr05
           nv_bptr = sicuw.uwm100.bptr05.
       IF nv_fptr <> 0 Or nv_fptr <> ? THEN DO:  
           DO WHILE nv_fptr  <>  0 :
               FIND FIRST sicuw.uwd104  WHERE RECID(sicuw.uwd104) = nv_fptr.
               IF   nv_txt5 = "" THEN nv_txt5 = trim(SUBSTRING(sicuw.uwd104.ltext,1,LENGTH(sicuw.uwd104.ltext))). 
               ELSE nv_txt5 = nv_txt5 + "," + trim(SUBSTRING(sicuw.uwd104.ltext,1,LENGTH(sicuw.uwd104.ltext))). 
               nv_fptr  =  sicuw.uwd104.fptr.  
               IF nv_fptr = 0 THEN LEAVE.
           END.
       END.
       ASSIGN wdetail.EndorseReason  = nv_txt5 .
    END.
    RELEASE sicuw.uwd104.
END.
END ...comment by Kridtiya i. A64-0295 DATE. 25/07/2021 ..........*/

RELEASE sicuw.uwm100.
RELEASE sicuw.uwm130.
RELEASE sicuw.uwd132.
RUN pro_reportpolicy.     /*report policy*/
RUN pro_reportpolicyENDS. /*report endorse*/
RUN pro_reportpolicyMO. /*report endorse*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_matpol_new C-Win 
PROCEDURE proc_matpol_new :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VAR nv_benname AS CHAR.
DEFINE VAR nv_chkpol  AS CHAR  FORMAT "X(30)" INITIAL "" NO-UNDO.
DEFINE VAR nv_lnumber AS INT                             NO-UNDO.
DEFINE VAR nv_name1   AS CHAR  FORMAT "X(50)".     
DEFINE VAR nv_name2   AS CHAR  FORMAT "X(50)".  
FOR EACH wdetail .
  IF INDEX(wdetail.xrefno1,"refno") <> 0 THEN DELETE wdetail.
  ELSE IF TRIM(wdetail.xrefno1) = "" THEN DELETE wdetail.
  ELSE DO:
    ASSIGN n_taxp = 0 ut_net = 0 ut_stamp = 0 ut_vat = 0 ut_total = 0.
    FIND LAST wdetail2 WHERE wdetail2.chassis  = wdetail.chassis AND 
              wdetail2.covcod   = wdetail.covcod AND
              wdetail2.covtyp   = wdetail.covtyp NO-ERROR NO-WAIT.
    IF AVAIL wdetail2 THEN DO:
      FIND FIRST sicuw.uwm100 USE-INDEX uwm10002 WHERE 
                 sicuw.uwm100.cedpol = TRIM(wdetail.xrefno1) AND
                 sicuw.uwm100.poltyp = wdetail.covtyp        NO-LOCK NO-ERROR.
      IF AVAIL sicuw.uwm100 THEN DO:
        /*IF uwm100.releas = NO THEN NEXT.*/
        ASSIGN wdetail2.Policy_Year   = STRING(sicuw.uwm100.rencnt + 1 )    /*�ӹǹ�ա�������*/
        wdetail.EndorseNo      = ""
        wdetail.policyno       = sicuw.uwm100.policy
        wdetail.EffectiveDate  = STRING(year(sicuw.uwm100.comdat),"9999") + "-" + 
                                 STRING(MONTH(sicuw.uwm100.comdat),"99")  + "-" + 
                                 STRING(DAY(sicuw.uwm100.comdat),"99")  
        wdetail.ExpireDate     = STRING(year(sicuw.uwm100.expdat),"9999") + "-" +  
                                 STRING(MONTH(sicuw.uwm100.expdat),"99") + "-" + 
                                 STRING(DAY(sicuw.uwm100.expdat),"99")  
        n_taxp                 = sicuw.uwm100.gstrat
        wdetail.trntyp         = IF sicuw.uwm100.poltyp = "V70" THEN "VMI" ELSE "CMI" 
        wdetail2.Agent_Code    = CAPS(sicuw.uwm100.agent)  
        wdetail.icno           = sicuw.uwm100.icno. 

        IF uwm100.langug = "T" THEN
            ASSIGN wdetail.pol_title = uwm100.ntitle
                   wdetail.pol_fname = uwm100.firstName 
                   wdetail.pol_lname = uwm100.lastName .
        ELSE ASSIGN wdetail.pol_title_eng  = uwm100.ntitle     
            wdetail.pol_fname_eng  = uwm100.firstName  
            wdetail.pol_lname_eng  = uwm100.lastName . 
        FIND FIRST sicsyac.xmm600 USE-INDEX xmm60001 WHERE 
            sicsyac.xmm600.acno  = sicuw.uwm100.agent NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL sicsyac.xmm600 THEN 
            wdetail2.Agent_Name_Eng = TRIM(TRIM(sicsyac.xmm600.ntitle) + " " + TRIM(sicsyac.xmm600.name)).
        FIND FIRST sicsyac.xtm600 USE-INDEX xtm60001    WHERE
            sicsyac.xtm600.acno = sicuw.uwm100.agent   NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL sicsyac.xtm600 THEN  wdetail2.Agent_Name_TH  = sicsyac.xtm600.ntitle + " " + TRIM(sicsyac.xtm600.NAME). 
/*1. Active : ������ͧ��������
2. Cancel : ¡��ԡ��������
3. On process : ���ѧ������������
4. Endorse : ��ѡ��ѧ��������
5. Expired : ���������������
6. Partial : ������ͧ��������
7. Change Insured : ����¹�����һ�Сѹ
8. Claim Update : ���Ѿഷ���*/
        IF      uwm100.polsta   = "IF"  THEN ASSIGN wdetail2.Policy_Status = "Active".
        ELSE IF uwm100.polsta   = "CA"  THEN ASSIGN wdetail2.Policy_Status = "Cancel".
        IF sicuw.uwm100.sch_p   = NO    THEN ASSIGN wdetail2.Policy_Status = wdetail2.Policy_Status + ",On process".
        IF sicuw.uwm100.expdat <= TODAY THEN ASSIGN wdetail2.Policy_Status = wdetail2.Policy_Status + ",Expired".
        IF STRING(year(sicuw.uwm100.comdat)) = STRING(year(sicuw.uwm100.expdat)) THEN 
            ASSIGN wdetail2.Policy_Status = wdetail2.Policy_Status + ",Partial".
        ELSE DO: /* year <> year */
            IF MONTH(sicuw.uwm100.comdat) <> MONTH(sicuw.uwm100.expdat) THEN DO:
                IF  (MONTH(sicuw.uwm100.comdat) = 2 ) AND (MONTH(sicuw.uwm100.expdat) <> 3 ) THEN /* �����ҡѹ*/
                    ASSIGN wdetail2.Policy_Status = wdetail2.Policy_Status + ",Partial".
            END.
            ELSE DO:
                IF DAY(sicuw.uwm100.comdat)  <>  DAY(sicuw.uwm100.expdat)  THEN DO:
                    IF  (DAY(sicuw.uwm100.comdat) = 29 )  AND (DAY(sicuw.uwm100.expdat) <> 1 ) THEN
                        ASSIGN wdetail2.Policy_Status = wdetail2.Policy_Status + ",Partial".
                END.
            END.
        END.
        FIND LAST  sicuw.uwm120 USE-INDEX uwm12001 WHERE
            sicuw.uwm120.policy  = sicuw.uwm100.policy  AND
            sicuw.uwm120.rencnt  = sicuw.uwm100.rencnt  AND
            sicuw.uwm120.endcnt  = sicuw.uwm100.endcnt  NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL sicuw.uwm120 THEN DO:
            IF sicuw.uwm100.poltyp = "V70" THEN wdetail2.CLASS = substring(sicuw.uwm120.class,2,3). /*���ʡ����ö¹��    110*/
            ELSE wdetail2.CLASS = substring(sicuw.uwm120.class,1,3).
        END.
        FIND FIRST sicuw.uwm130 USE-INDEX uwm13001 WHERE
            sicuw.uwm130.policy = sicuw.uwm100.policy  AND
            sicuw.uwm130.rencnt = sicuw.uwm100.rencnt  AND   
            sicuw.uwm130.endcnt = sicuw.uwm100.endcnt  AND 
            sicuw.uwm130.riskgp = 0              AND
            sicuw.uwm130.riskno = 1              AND
            sicuw.uwm130.itemno = 1              NO-LOCK NO-ERROR.
        IF AVAIL sicuw.uwm130 THEN DO:
            ASSIGN wdetail.SumInsured = IF sicuw.uwm100.poltyp = "V72" THEN "0" ELSE STRING(sicuw.uwm130.uom6_v,">>>>>>>>9.99")
                wdetail.Sumfire       = IF sicuw.uwm100.poltyp = "V72" THEN "0" ELSE STRING(sicuw.uwm130.uom7_v,">>>>>>>>9.99").  
                FOR EACH sicuw.uwd132 USE-INDEX uwd13290
                    WHERE sicuw.uwd132.policy = sicuw.uwm130.policy AND
                    sicuw.uwd132.rencnt = sicuw.uwm130.rencnt       AND
                    sicuw.uwd132.endcnt = sicuw.uwm130.endcnt       AND
                    sicuw.uwd132.riskgp = sicuw.uwm130.riskgp       AND
                    sicuw.uwd132.riskno = sicuw.uwm130.riskno       AND
                    sicuw.uwd132.itemno = sicuw.uwm130.itemno       NO-LOCK .
                    ASSIGN ut_net   = ut_net + uwd132.prem_c.
                    IF      uwd132.bencod = "DOD"           THEN ASSIGN nv_dedod            = DECI(SUBSTRING(uwd132.benvar,31,30)).
                    ELSE IF uwd132.bencod = "DOD2"          THEN ASSIGN nv_dedod1           = DECI(SUBSTRING(uwd132.benvar,31,30)).
                    ELSE IF uwd132.bencod = "DPD"           THEN ASSIGN nv_dedod2           = DECI(SUBSTRING(uwd132.benvar,31,30)).
                    ELSE IF uwd132.bencod = "FLET"          THEN ASSIGN wdetail2.fleetper   = SUBSTRING(uwd132.benvar,31,30) wdetail2.fleet = string(uwd132.prem_c). 
                    ELSE IF uwd132.bencod = "NCB"           THEN ASSIGN wdetail2.ncbper     = SUBSTRING(uwd132.benvar,31,30) wdetail2.ncb   = string(uwd132.prem_c). 
                    ELSE IF substr(uwd132.bencod,1,1) = "A" THEN ASSIGN wdetail2.drivdis    = string(uwd132.prem_c). 
                    ELSE IF uwd132.bencod = "DSPC"          THEN ASSIGN wdetail2.cctvper    = SUBSTRING(uwd132.benvar,31,30) wdetail2.cctv  = string(uwd132.prem_c).   /*Discount Special %*/
                    ELSE IF uwd132.bencod = "DSTF"          THEN ASSIGN wdetail2.othper     = SUBSTRING(uwd132.benvar,31,30) wdetail2.oth   = string(uwd132.prem_c). 
                    ELSE IF index(uwd132.bencod,"CL") <> 0  THEN ASSIGN wdetail2.Surcharper = SUBSTRING(uwd132.benvar,31,30) wdetail2.Surchar = string(uwd132.prem_c). 
                    ELSE IF uwd132.bencod = "411"   THEN ASSIGN ut_netprm2   = ut_netprm2 + uwd132.prem_c.
                    ELSE IF uwd132.bencod = "412"   THEN ASSIGN ut_netprm2   = ut_netprm2 + uwd132.prem_c.
                    ELSE IF uwd132.bencod = "42"    THEN ASSIGN ut_netprm2   = ut_netprm2 + uwd132.prem_c.
                    ELSE IF uwd132.bencod = "43"    THEN ASSIGN ut_netprm2   = ut_netprm2 + uwd132.prem_c.
                END.
                ASSIGN wdetail2.prem1  = string(ut_net)  
                    wdetail2.prem1 = string(deci(ut_netprm1) + nv_dedod  + nv_dedod1 + nv_dedod2 - DECI(wdetail2.fleet)   
                                - DECI(wdetail2.ncb) - DECI(wdetail2.oth) - DECI(wdetail2.cctv) - DECI(wdetail2.Surchar)      
                                - ut_netprm2)  .
                    ut_stamp = (ut_net) * 0.4 / 100.
                    IF ut_stamp - TRUNCATE(ut_stamp,0) > 0 THEN ut_stamp = TRUNCATE(ut_stamp,0) + 1.
                    ut_vat   = (ut_net + ut_stamp) * n_taxp / 100.
                    ut_total = ut_net  + ut_stamp + ut_vat.
                ASSIGN 
                    wdetail2.deduct      =  string(nv_dedod + nv_dedod1 + nv_dedod2)
                    wdetail.NetPremium   =  string(ut_net,">>>,>>>,>>9.99")
                    wdetail.VatTax       =  string(ut_vat,">>,>>9.99")
                    wdetail.Stamp        =  string(ut_stamp,">,>>9.99")
                    wdetail.GrossPremium =  string(ut_total,">>>,>>>,>>9.99") .
                FIND LAST sicuw.uwm301 USE-INDEX uwm30101 WHERE
                    sicuw.uwm301.policy = sicuw.uwm100.policy  AND
                    sicuw.uwm301.rencnt = sicuw.uwm100.rencnt  AND   
                    sicuw.uwm301.endcnt = sicuw.uwm100.endcnt  NO-LOCK NO-ERROR NO-WAIT.
                IF AVAIL sicuw.uwm301 THEN DO:
                    IF index(sicuw.uwm301.moddes," ") <> 0 THEN 
                        ASSIGN wdetail2.brand =  trim(SUBSTR(sicuw.uwm301.moddes,1,index(sicuw.uwm301.moddes," ")))
                        wdetail2.Model =  trim(SUBSTR(sicuw.uwm301.moddes,index(sicuw.uwm301.moddes," "))).
                    ELSE ASSIGN wdetail2.brand = trim(sicuw.uwm301.moddes)
                                wdetail2.Model = "".
                    wdetail2.body = sicuw.uwm301.body.
                    IF INDEX(TRIM(sicuw.uwm301.vehreg)," ") <> 0 THEN 
                        ASSIGN  wdetail2.licence  = trim(SUBSTR(TRIM(sicuw.uwm301.vehreg),1,r-index(TRIM(sicuw.uwm301.vehreg)," ")))
                                wdetail2.province = trim(SUBSTR(TRIM(sicuw.uwm301.vehreg),r-index(TRIM(sicuw.uwm301.vehreg)," "))).
                    ELSE ASSIGN wdetail2.licence =  TRIM(sicuw.uwm301.vehreg) 
                                wdetail2.province =  "".
                    ASSIGN wdetail.chassis    = sicuw.uwm301.cha_no 
                    wdetail2.chassis   = sicuw.uwm301.cha_no 
                    wdetail2.engine    = sicuw.uwm301.eng_no 
                    wdetail2.yrmanu    = string(sicuw.uwm301.yrmanu) /*�ը�����¹ö   2013   */
                    wdetail2.seatenew  = STRING(sicuw.uwm301.seats)  /*�ӹǹ�����    5      */
                    wdetail2.power     = STRING(sicuw.uwm301.engine) /*��Ҵ����ͧ¹�� 1200   */
                    wdetail2.weight    = STRING(sicuw.uwm301.Tons)   /*���˹ѡ 0              */
                    wdetail2.garage_cd = uwm301.garage         /*��������ë���   1      */
                    wdetail.covcod     = "��Сѹ���ö¹������� " + uwm301.covcod
                    wdetail.covtyp     = "Motor" + uwm301.covcod
                    wdetail2.covcod    = "��Сѹ���ö¹������� " + uwm301.covcod
                    wdetail2.covtyp    = "Motor" + uwm301.covcod
                    wdetail2.gross_prm  = wdetail.NetPremium   
                    wdetail2.stamp      = wdetail.Stamp        
                    wdetail2.vat        = wdetail.VatTax       
                    wdetail2.premtotal  = wdetail.GrossPremium .
                    IF sicuw.uwm301.mv_ben83 <> "" THEN DO: 
                        ASSIGN nv_benname = TRIM(sicuw.uwm301.mv_ben83)
                            nv_titlematch = ""
                            nv_fnamematch = ""
                            nv_lnamematch = "" .
                        RUN wgw/wgwmtscb4 (INPUT nv_benname
                                          ,INPUT-OUTPUT nv_titlematch
                                          ,INPUT-OUTPUT nv_fnamematch
                                          ,INPUT-OUTPUT nv_lnamematch).
                        ASSIGN 
                            wdetail.ben_title = nv_titlematch
                            wdetail.ben_name  = nv_fnamematch
                            wdetail.ben_lname = nv_lnamematch  .
                    END.
                END.
                /**/
                ASSIGN nv_date = ""
                       nv_ems  = "".
                RUN proc_senddocumentFI (INPUT sicuw.uwm100.policy 
                                        ,INPUT-OUTPUT nv_date
                                        ,INPUT-OUTPUT nv_ems  ).
                RUN proc_trackingnum. /* Add By Tontawan S. A66-0006 --*/
                /*Driver name */
                ASSIGN nv_chkpol = TRIM(sicuw.uwm130.policy) + STRING(sicuw.uwm130.rencnt,"99")
                                    + STRING(sicuw.uwm130.endcnt,"999")
                                    + STRING(sicuw.uwm130.riskno,"999") + STRING(sicuw.uwm130.itemno,"999") 
                        nv_lnumber = 1.
                    FIND FIRST stat.mailtxt_fil USE-INDEX mailtxt01  WHERE
                        mailtxt_fil.policy  = nv_chkpol   AND
                        mailtxt_fil.lnumber = nv_lnumber  NO-LOCK NO-ERROR NO-WAIT.  
                    IF AVAILABLE mailtxt_fil THEN DO:
                        ASSIGN wdetail.bdatedriv1 =  SUBSTRING(mailtxt_fil.ltext2,7,4) + "-" +
                                                     SUBSTRING(mailtxt_fil.ltext2,4,2) + "-" + 
                                                     SUBSTRING(mailtxt_fil.ltext2,1,2) 
                            /*nv_age1    = SUBSTRING(mailtxt_fil.ltext2,13,2) */
                            wdetail.occupdriv1  = SUBSTRING(mailtxt_fil.ltext2,16,40)
                            wdetail.driveno1    = SUBSTRING(mailtxt_fil.ltext2,101,50)
                            /*nv_dicn1   = SUBSTRING(mailtxt_fil.ltext2,151,50)*/      .
                        IF TRIM(SUBSTRING(mailtxt_fil.ltext,31,6)) <> "" THEN DO:
                            IF TRIM(SUBSTRING(mailtxt_fil.ltext,31,6)) = "MALE"   OR 
                                TRIM(SUBSTRING(mailtxt_fil.ltext,31,6)) = "FEMALE" THEN DO:
                                nv_name1  = SUBSTRING(mailtxt_fil.ltext,1,30).
                                wdetail.sexdriv1  = IF TRIM(SUBSTRING(mailtxt_fil.ltext,31,6)) = "MALE" THEN "MALE" ELSE "FEMALE".
                            END.
                            ELSE DO:
                                nv_name1  = SUBSTRING(mailtxt_fil.ltext,1,50).
                                wdetail.sexdriv1  = IF TRIM(SUBSTRING(mailtxt_fil.ltext,51,6)) = "MALE" THEN "MALE" ELSE "FEMALE".
                            END.
                        END.
                        ELSE DO:
                            nv_name1  = SUBSTRING(mailtxt_fil.ltext,1,50).
                            wdetail.sexdriv1  = IF TRIM(SUBSTRING(mailtxt_fil.ltext,51,6)) = "MALE" THEN "MALE" ELSE "FEMALE".
                        END. 
                        FIND NEXT mailtxt_fil USE-INDEX mailtxt01 WHERE
                            mailtxt_fil.policy  = nv_chkpol NO-LOCK NO-ERROR NO-WAIT.  
                        IF AVAIL mailtxt_fil THEN DO:
                            ASSIGN  wdetail.bdatedriv2 =  SUBSTRING(mailtxt_fil.ltext2,7,4) + "-" + 
                                                          SUBSTRING(mailtxt_fil.ltext2,4,2) + "-" +  
                                                          SUBSTRING(mailtxt_fil.ltext2,1,2) 
                                /*nv_age2    = SUBSTRING(mailtxt_fil.ltext2,13,2)*/ .
                            ASSIGN wdetail.occupdriv2  = SUBSTRING(mailtxt_fil.ltext2,16,40)
                                wdetail.driveno2    = SUBSTRING(mailtxt_fil.ltext2,101,50)
                                /*nv_dicn2   = SUBSTRING(mailtxt_fil.ltext2,151,50)*/    . 
                            IF TRIM(SUBSTRING(mailtxt_fil.ltext,31,6)) <> "" THEN DO:
                                IF TRIM(SUBSTRING(mailtxt_fil.ltext,31,6)) = "MALE"   OR 
                                    TRIM(SUBSTRING(mailtxt_fil.ltext,31,6)) = "FEMALE" THEN DO:
                                    nv_name2  = SUBSTRING(mailtxt_fil.ltext,1,30).
                                    wdetail.sexdriv2  = IF TRIM(SUBSTRING(mailtxt_fil.ltext,31,6)) = "MALE" THEN "MALE" ELSE "FEMALE".
                                END.
                                ELSE DO:
                                    nv_name2  = SUBSTRING(mailtxt_fil.ltext,1,50).
                                    wdetail.sexdriv2  = IF TRIM(SUBSTRING(mailtxt_fil.ltext,51,6)) = "MALE" THEN "MALE" ELSE "FEMALE".
                                END.
                            END.
                            ELSE DO:
                                nv_name2  = SUBSTRING(mailtxt_fil.ltext,1,50).
                                wdetail.sexdriv2  = IF TRIM(SUBSTRING(mailtxt_fil.ltext,51,6)) = "MALE" THEN "MALE" ELSE "FEMALE".
                            END.
                        END.
                        ELSE DO:
                            /*ASSIGN
                                nv_name2   = " "
                                nv_birdat2 = ?
                                nv_age2    = " "
                                nv_occup2  = " "
                                nv_sex2    = " ".*/
                        END.
                    END.  /*mailtxt_fil */
                    IF nv_name1 <> "" THEN DO:
                        RUN wgw/wgwmtscb4 (INPUT nv_name1
                                               ,INPUT-OUTPUT nv_titlematch
                                               ,INPUT-OUTPUT nv_fnamematch
                                               ,INPUT-OUTPUT nv_lnamematch).
                        ASSIGN wdetail.drivetitle1  =   nv_titlematch
                            wdetail.drivename1   =   nv_fnamematch
                            wdetail.drivelname1  =   nv_lnamematch.
                    END.
                    IF nv_name2 <> "" THEN DO:
                        RUN wgw/wgwmtscb4 (INPUT nv_name2
                                           ,INPUT-OUTPUT nv_titlematch
                                           ,INPUT-OUTPUT nv_fnamematch
                                           ,INPUT-OUTPUT nv_lnamematch).
                        ASSIGN 
                            wdetail.drivetitle2  =   nv_titlematch
                            wdetail.drivename2   =   nv_fnamematch
                            wdetail.drivelname2  =   nv_lnamematch.
                    END.
                END.      /*uwm130      */
            END.
            ELSE DO:
                ASSIGN wdetail.PolicyNo       = ""
                    wdetail.EndorseNo      = ""
                    wdetail.SumInsured     = ""
                    wdetail.sumfire        = ""  /*A61-0228*/
                    wdetail.NetPremium     = ""
                    wdetail.VatTax         = ""
                    wdetail.Stamp          = ""
                    wdetail.GrossPremium   = ""
                    wdetail.EffectiveDate  = ""
                    wdetail.ExpireDate     = ""
                    wdetail.EndorseReason  = "" 
                    wdetail.trntyp         = "" . /*a61-0228*/
            END.
            RELEASE uwm100.
            RELEASE uwm130.
            RELEASE uwd132.
        END. /*wdetail2 */
    END.
END.
RELEASE wdetail.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_matpol_neweds C-Win 
PROCEDURE proc_matpol_neweds :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* �Ң����š����������ա����ѡ��ѧ = Today */
FOR EACH sicsyac.xmm600 USE-INDEX xmm60009 NO-LOCK WHERE 
   sicsyac.xmm600.gpstmt = nv_agent   : 

FOR EACH sicuw.uwm100 USE-INDEX uwm10008 WHERE 
    sicuw.uwm100.trndat >= fi_tranform     AND  
    sicuw.uwm100.trndat <= fi_tranto       AND  
    sicuw.uwm100.acno1  = sicsyac.xmm600.acno  NO-LOCK .

    IF uwm100.endcnt < 1 THEN NEXT.
    /* IF uwm100.releas = NO THEN NEXT.*/
    CREATE wdetail.
    ASSIGN  
        wdetail.xrefno1        = trim(sicuw.uwm100.cedpol)
        wdetail.InsuredName    = "����ѷ ��Сѹ������� �ӡѴ (��Ҫ�)"
        wdetail.EndorseNo      = sicuw.uwm100.endno
        wdetail.policyno       = trim(sicuw.uwm100.policy)                                                        
        wdetail.EffectiveDate  = STRING(year(sicuw.uwm100.comdat),"9999") + "-" +
                                 STRING(MONTH(sicuw.uwm100.comdat),"99")  + "-" +
                                 STRING(DAY(sicuw.uwm100.comdat),"99") 
        wdetail.ExpireDate     = STRING(year(sicuw.uwm100.expdat),"9999") + "-" +
                                 STRING(MONTH(sicuw.uwm100.expdat),"99") + "-" +
                                 STRING(DAY(sicuw.uwm100.expdat),"99") 
        n_taxp                 = sicuw.uwm100.gstrat
        wdetail.trntyp         = IF sicuw.uwm100.poltyp = "V70" THEN "VMI" ELSE "CMI"  
        wdetail.pol_title      = trim(sicuw.uwm100.ntitle)
        wdetail.pol_fname      = trim(sicuw.uwm100.firstName)
        wdetail.pol_lname      = trim(sicuw.uwm100.lastName) 
        wdetail.endorsedat     = string(year(sicuw.uwm100.enddat),"9999") + "-" + 
                                 string(MONTH(sicuw.uwm100.enddat),"99") + "-" + 
                                 string(DAY(sicuw.uwm100.enddat),"99")  .
    FIND FIRST sicuw.uwm130 USE-INDEX uwm13001 WHERE
        sicuw.uwm130.policy = uwm100.policy AND
        sicuw.uwm130.rencnt = uwm100.rencnt AND   
        sicuw.uwm130.endcnt = uwm100.endcnt AND 
        sicuw.uwm130.riskgp = 0             AND 
        sicuw.uwm130.riskno = 1             AND 
        sicuw.uwm130.itemno = 1             NO-LOCK NO-ERROR.

    IF AVAIL uwm130 THEN DO:
         ASSIGN /*
                wdetail.SumInsured   = IF uwm100.poltyp = "V72" THEN "0" ELSE STRING(uwm130.uom7_v,">>>,>>>,>>9.99")
                wdetail.Sumfire      = IF uwm100.poltyp = "V72" THEN "0" ELSE STRING(uwm130.uom6_v,">>>,>>>,>>9.99"). */ /*A61-0228*/
                wdetail.SumInsured   = IF uwm100.poltyp = "V72" THEN "0" ELSE STRING(uwm130.uom6_v,">>>>>>>>9.99")
                wdetail.Sumfire      = IF uwm100.poltyp = "V72" THEN "0" ELSE STRING(uwm130.uom7_v,">>>>>>>>9.99").    /*A61-0322*/

        FOR EACH sicuw.uwd132 USE-INDEX uwd13290
        WHERE sicuw.uwd132.policy = sicuw.uwm130.policy AND
              sicuw.uwd132.rencnt = sicuw.uwm130.rencnt AND
              sicuw.uwd132.endcnt = sicuw.uwm130.endcnt AND
              sicuw.uwd132.riskgp = sicuw.uwm130.riskgp AND
              sicuw.uwd132.riskno = sicuw.uwm130.riskno AND
              sicuw.uwd132.itemno = sicuw.uwm130.itemno NO-LOCK .
       
               ASSIGN ut_net   = ut_net + uwd132.prem_c
                      ut_stamp = (ut_net) * 0.4 / 100.

                      IF ut_stamp - TRUNCATE(ut_stamp,0) > 0 THEN ut_stamp = TRUNCATE(ut_stamp,0) + 1.
                      ut_vat   = (ut_net + ut_stamp) * n_taxp / 100.
                      ut_total = ut_net  + ut_stamp + ut_vat.
        END.
        IF ut_net < 0  THEN DO:
            ASSIGN ut_net        = ut_net   * (-1) 
            wdetail.NetPremium   = "-" + string(ut_net,">>>>>>>>9.99").
        END.
        ELSE wdetail.NetPremium   =  string(ut_net,">>>>>>>>9.99").

        IF ut_vat < 0  THEN DO:
            ASSIGN ut_vat    = ut_vat   * (-1) 
            wdetail.VatTax   = "-" + string(ut_vat,">>>>9.99") .
        END.
        ELSE wdetail.VatTax       =  string(ut_vat,">>>>9.99").
        IF ut_stamp < 0  THEN DO:
            ASSIGN  ut_stamp = ut_stamp   * (-1) 
            wdetail.Stamp  = "-" + string(ut_stamp,">>>9.99").
        END.
        ELSE wdetail.Stamp        =  string(ut_stamp,">>>9.99").

        IF ut_total < 0  THEN DO:
            ASSIGN ut_total = ut_total   * (-1) 
            wdetail.GrossPremium =  "-" + string(ut_total,">>>>>>>>9.99") .
        END.
        ELSE wdetail.GrossPremium =  string(ut_total,">>>>>>>>9.99") .

    END.
    nv_txt5 = "" .
    IF sicuw.uwm100.endcnt > 0 THEN DO:
        ASSIGN
           nv_txt5 = ""
           nv_fptr = 0
           nv_bptr = 0
           nv_fptr = sicuw.uwm100.fptr05
           nv_bptr = sicuw.uwm100.bptr05.
       IF nv_fptr <> 0 Or nv_fptr <> ? THEN DO:  
           DO WHILE nv_fptr  <>  0 :
               FIND FIRST sicuw.uwd104  WHERE RECID(sicuw.uwd104) = nv_fptr.
               IF   nv_txt5 = "" THEN nv_txt5 = trim(SUBSTRING(sicuw.uwd104.ltext,1,LENGTH(sicuw.uwd104.ltext))). 
               ELSE nv_txt5 = nv_txt5 + "," + trim(SUBSTRING(sicuw.uwd104.ltext,1,LENGTH(sicuw.uwd104.ltext))). 
               nv_fptr  =  sicuw.uwd104.fptr.  
               IF nv_fptr = 0 THEN LEAVE.
           END.
       END.
       ASSIGN wdetail.EndorseReason  = nv_txt5 .
    END.
    RELEASE sicuw.uwd104.
END.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_senddocumentFI C-Win 
PROCEDURE proc_senddocumentFI :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE INPUT        PARAMETER  n_pol      AS   CHARACTER NO-UNDO.
DEFINE INPUT-OUTPUT PARAMETER  nt_date    AS   CHARACTER NO-UNDO.
DEFINE INPUT-OUTPUT PARAMETER  nt_ems     AS   CHARACTER NO-UNDO.
ASSIGN 
       nt_policyno  = ""                 
       nt_ems       = ""                 
       n_ems        = ""
       n_date       = ""
       nt_date      = ?
       nv_doc_num   = 0 
       n_snote      = "postdocument" + SUBSTR(STRING(YEAR(TODAY),"9999"),3,2) + ".nsf"  .

       CREATE "Notes.NotesSession"  chNotesSession. 
       /*--------- Lotus Server Real ----------*/
       nv_tmp    = "safety\fi\" + n_snote.
       chNotesDatabase = chNotesSession:GetDatabase ("Safety_NotesServer/Safety",nv_tmp).
       /*-------------------------------------*/
       /*--------- Lotus Server test ----------
       nv_tmp    = "U:\Lotus\Notes\Data\" + n_snote.
       chNotesDatabase = chNotesSession:GetDatabase ("",nv_tmp).
       -------------------------------*/
       IF chNotesDatabase:IsOpen() = NO  THEN  DO:
          MESSAGE "Can not open database" SKIP  
                  "Please Check database and serve" VIEW-AS  ALERT-BOX ERROR.
       END.
       ELSE DO:
           chNotesView      = chNotesDatabase:GetView("By PolicyNo").

           IF VALID-HANDLE(chNotesview) = YES   THEN DO:
              chnotecollection = chNotesView:GetallDocumentsByKey(n_pol).
              nv_doc_num       = chnotecollection:COUNT.
              
              IF nv_doc_num > 0 THEN DO:

                  chDocument = chnotecollection:GetfirstDocument.

                  loop_chkdoc:
                  REPEAT:
                     IF VALID-HANDLE(chDocument) = YES THEN DO:
                       /*IF date(nt_date) >= fi_tranf  AND date(nt_date) <= fi_trant THEN DO:*/
                       chitem       = chDocument:Getfirstitem("PolicyNo"). 
                       nt_policyno  = chitem:TEXT.                      
                       chitem       = chDocument:Getfirstitem("Date").     
                       nt_date      = chitem:TEXT.      
                       chitem       = chDocument:Getfirstitem("Round").  
                       nt_round     = chitem:TEXT. 
                       chitem       = chDocument:Getfirstitem("EmsNo"). 

                       IF nt_date <> ? THEN n_date = STRING(nt_date,"99/99/9999") .

                       IF chitem <> 0 THEN  nt_ems  = chitem:TEXT.
                       ELSE nt_ems = "" .
                       
                       IF nt_ems <> "" THEN DO:
                         /* IF wtext.nw_senddat  <> n_date  THEN DO:
                           ASSIGN wtext.nw_remark   = IF wtext.nw_remark  <> "" THEN wtext.nw_remark + "|" + 
                                                     "���͡���������ѹ���" + STRING(nt_date,"99/99/9999") + " " + "�Ţ����" + nt_ems 
                                                   ELSE "���͡���������ѹ���" + STRING(nt_date,"99/99/9999") + " " + "�Ţ����" + nt_ems 
                                  wtext.nw_senddat  = n_date.
                          END.*/
                       END.
                      /* END.*/
                     END.
                     ELSE LEAVE.
                     chDocument = chnotecollection:GetNextDocument(chDocument) NO-ERROR.
                  END.
              END.
              ELSE DO: 
                  NEXT.
              END.
           END.
           ELSE DO:
             NEXT.
           END. /*viewNotes*/

       END.
      RELEASE  OBJECT chNotesSession NO-ERROR.  
      RELEASE  OBJECT chNotesDataBase NO-ERROR. 
      RELEASE  OBJECT chDocument NO-ERROR.      
      RELEASE  OBJECT chNotesView NO-ERROR.     
      RELEASE  OBJECT chDocument1 NO-ERROR.     
      RELEASE  OBJECT chNotesView1 NO-ERROR.    
      RELEASE  OBJECT chnotecollection NO-ERROR.

      IF  nt_date <> "" THEN nt_date = SUBSTR(nt_date,7,4) + "-" + SUBSTR(nt_date,4,2) + "-" + SUBSTR(nt_date,1,2).
          
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_trackingnum C-Win 
PROCEDURE proc_trackingnum :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: Add By Tontawan S. A66-0006 - ��������� Tracking �ͧ�ҹ 72 ����ҡ����դ�����仴֧����Ţ Appen      
------------------------------------------------------------------------------*/
ASSIGN
    nv_appen = "".

IF wdetail.trntyp <> "CMI" THEN DO:
    ASSIGN 
        wdetail2.Send_Policy_Date = TRIM(nv_date) 
        wdetail2.Tracking_Number  = TRIM(nv_ems).
END.
ELSE DO:
    IF nv_ems = "" THEN DO:
        FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE sicuw.uwm100.policy = wdetail.PolicyNo NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL sicuw.uwm100 THEN DO:
            ASSIGN
                nv_appen = sicuw.uwm100.cr_2.    

            IF nv_appen <> "" THEN DO:
                FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE sicuw.uwm100.policy = nv_appen NO-LOCK NO-ERROR NO-WAIT.
                IF AVAIL sicuw.uwm100 THEN DO:

                    RUN proc_senddocumentFI (INPUT sicuw.uwm100.policy 
                                            ,INPUT-OUTPUT nv_date
                                            ,INPUT-OUTPUT nv_ems  ).

                    ASSIGN 
                        wdetail2.Send_Policy_Date = TRIM(nv_date) 
                        wdetail2.Tracking_Number  = TRIM(nv_ems)  .
                END.
            END.
        END.
    END.
    ELSE nv_ems.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pro_reportpolicy C-Win 
PROCEDURE Pro_reportpolicy :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR pol72 AS CHAR FORMAT "x(12)" INIT "" .   /*A56-0323*/
If  substr(fi_outload,length(fi_outload) - 3,4) <>  ".csv"  THEN 
    fi_outload  =  Trim(fi_outload) + ".csv"  .
/*ASSIGN nv_cnt =  0
nv_row  =  1.*/
OUTPUT TO VALUE(fi_outload)
CONVERT SOURCE "620-2533" TARGET "UTF-8". /*-- Add By Tontawan S. A66-0006 --*/
EXPORT DELIMITER "," 
    /*comment by Kridtiya i. A64-0295 DATE. 25/07/2021 
    " XRefNo1       "
    " Barcode       "
    " InsuredName   "
    " PolicyNo      "
    " EndorseNo     "
    " SumInsured    "
    /* " Fire&THEFT    " */           /*A61-0228*/ /* A61-0322 */
    " NetPremium    "
    " VatTax        "
    " Stamp         "
    " GrossPremium  "
    " EffectiveDate "
    " ExpireDate    "
    " EndorseReason "  
    " Trans type    "                /*A61-0228*/
    " Fire&THEFT    " .           /* A61-0322 */
    comment by Kridtiya i. A64-0295 DATE. 25/07/2021 */
    /*Add by Kridtiya i. A64-0295 DATE. 25/07/2021 */
"Application_Form__c"
"Account__c"
"InsuredName__c"
"PolicyNo__c"   
"EndorseNo__c"  
"SumInsured__c" 
"NetPremium__c" 
"VatTax__c"  
"Stamp__c"  
"GrossPremium__c"
"EffectiveDate__c"
"ExpireDate__c" 
"EndorseReason__c"
"TransType__c"
"FireSumInsured__c"
"Send_Policy_Date__c"
"Tracking_Number__c"
"Yes_File_Date__c"
"Policy_Status__c"
"Policy_Year__c"
"Agent_Code__c" 
"Agent_Name_TH__c"
"Agent_Name_Eng__c"
"InsuranceCode__c"
"InsuranceName__c"
"CampaignCode__c"
"CampaignName__c"
"ProductCode__c"
"ProductName__c"
"PackageName__c"
"PackageCode__c"
"Holder_Type__c"
"Holder_title__c"
"Holder_fname_thai__c"
"Holder_sname_thai__c"
"Holder_title_eng__c"   
"Holder_fname_eng__c"   
"Holder_sname_eng__c"   
"Holder_id_Company__c"  
"Holder_sex__c"   
"Holder_birth_date__c"  
"Holder_occu_code__c"   
"Holder_home__c"   
"Holder_Ext_home__c"   
"Holder_office__c"   
"Holder_Ext_office__c"  
"Holder_mobile__c"   
"Holder_mobile_update__c"
"Holder_email__c"
"Line_ID__c"
"Holder_Register_No__c"
"Holder_Register_Building_Village__c"
"Holder_Register_Moo__c"
"Holder_Register_Soi__c"
"Holder_Register_Road__c"
"Holder_Register_Tambon__c"
"Holder_Register_District__c"
"Holder_Register_province__c"
"Holder_Repost_code__c"
"Holder_Billing_No__c"
"Holder_Billing_Building_Village__c"
"Holder_Billing_Moo__c"
"Holder_Billing_Soi__c"
"Holder_Billing_Road__c"
"Holder_Billing_Tambon__c"
"Holder_Billing_District__c"
"Holder_Billing_province__c"
/*"Holder_Repost_code__c" ------ Comment By Tontawan S. ---*/
"Holder_Billing_Repost_code__c" /*-- Add By Tontawan S. ---*/
"Payer_partner_type__c"
"Payer_title_name__c"
"Payer_fname__c"
"Payer_sname__c"
"Payer_id_code__c"
"Payer_address_No__c"
"Payer_address_Building_Village__c"
"Payer_address_Moo__c"
"Payer_address_Soi__c"
"Payer_address_Road__c"
"Payer_address_Sub_District__c"
"Payer_amp_code_District__c"
"Payer_prov_code__c"
"Payer_postcode__c"
"Branch__c"
"Beneficiary_title_code__c"
"Beneficiary_fname__c"
"Beneficiary_sname__c"
"payment_mode_Code__c"
"payment_mode_Desc__c"
"payment_type_Code__c"
"payment_Channel__c"
"Payment_Bank__c"
"Payment_Date__c"
"Payment_Status__c"
"Drivee_Status__c"
"Driver1_title_code__c"
"Driver1_fname__c"
"Driver1_sname__c"
"Driver1_id_code__c"
"Driver1_Occupation__c"
"Driver1_Gender__c"
"Driver1_birth_date__c"
"Driver2_title_code__c"
"Driver2_fname__c"
"Driver2_sname__c"
"Driver2_id_code__c"
"Driver2_Occupation__c"
"Driver2_Gender__c"
"Driver2_birth_date__c"
"Brand__c"
"Brand_Code__c"
"Model__c"
"Model_Code__c"
"BodyType__c"
"BodyType_Code__c"
"License_Plate__c"
"License_Prov_Code__c"
"Chassis_No__c"
"Engine_No__c"
"Model_Year__c"
"Seats__c"
"CC__c"
"Weight__c"
"Use_Car_Type__c"
"Garage_Type__c"
"Garage_Code__c"
"Color__c"
"Insurance_Type__c"
"Insurance_Type_Code__c"
"Cover_Type__c"
"Sub_cover_type__c"
"Sub_cover_Desc__c"
"term_Date_From__c"
"term_Date_To__c"
"Sum_Insured__c"
"Premium_rate_for_Main_Coveragtes__c"
"Net_Premium__c"
"stamp_vmi__c"
"tax_amt_vmi__c"
"total_prem_vmi__c"
"Deduct_own_damage__c"
"Percent_Fleet_Discount__c"
"Amount_Fleet_Discount__c"
"Percent_No_Claim_Bonus__c"
"Amount_No_Claim_Bonus__c"
"Percent__Discount_for_Driver__c"
"Amount_Discount_for_Driver__c"
"Percemt_Other_Discount__c"
"Amount_Other_Discount__c"
"Percent_Car_DashCam_Discount__c"
"Amount_Car_DashCam_Discount__c"
"Percent_Surcharge__c"
"Amount_Surcharge__c"
"Surcharge_Detail__c"
"accessory_01__c"
"accessory_remarks_01__c"
"accessory_suminsured_01__c"
"accessory_02__c"
"accessory_remarks_02__c"
"accessory_suminsured_02__c"
"accessory_03__c"
"accessory_remarks_03__c"
"accessory_suminsured_03__c"
"accessory_04__c"
"accessory_remarks_04__c"
"accessory_suminsured_04__c"
"accessory_05__c"
"accessory_remarks_05__c"
"accessory_suminsured_05__c"
"Car_Inspection_Date__c"
"Car_Inspection_Approved_Date__c"
"Result_Car_Inspection__c"
"Detail_Car_Inspection__c"
"Sale_Date__c"
/*"Payment_Date__c"
"Payment_Status__c"*/
"License_Broker_Code__c"
"Broker_Name__c"
"Broker_Code__c"
"pol_language__c"
"Delivery_channel_Varchar__c"
"Delivery_Remark_Varchar__c"
"Gift_Premium_Varchar__c"
"Product_Remark__c"
"Selling_Channel__c"
/*-- Add By Tontawan S. A68-0059 27/03/2025 --*/
"Driver3_SalutationMotor__c"  
"Driver3_First_Name__c"       
"Driver3_Last_Name__c"        
"Driver3_National_ID__c"      
"Driver3_Occupation__c"       
"Driver3_Gender__c"           
"Driver3_Birthdate__c"        
"Driver4_SalutationMotor__c"  
"Driver4_First_Name__c"       
"Driver4_Last_Name__c"        
"Driver4_National_ID__c"      
"Driver4_Occupation__c"       
"Driver4_Gender__c"           
"Driver4_Birthdate__c"        
"Driver5_SalutationMotor__c"  
"Driver5_First_Name__c"       
"Driver5_Last_Name__c"        
"Driver5_National_ID__c"      
"Driver5_Occupation__c"       
"Driver5_Gender__c"           
"Driver5_Birthdate__c"        
"Driver1_Driving_License__c"  
"Driver2_Driving_License__c"  
"Driver3_Driving_License__c"  
"Driver4_Driving_License__c"  
"Driver5_Driving_License__c"  
"Battery_Serial_Number__c"    
"Battery_Date__c"             
"Battery_Replacement_SI__c"   
"Battery_Net_Premium__c"      
"Battery_Gross_Premium__c  "  
"Wall_Charge_Serial_Number__c"
"Wall_Charge_SI__c"           
"Wall_Charge_Net_Premium__c"  
"Wall_Charge_Gross_Premium__c".
/*-- End By Tontawan S. A68-0059 27/03/2025 --*/
RUN Pro_reportpolicy2.
    /*Add by Kridtiya i. A64-0295 DATE. 25/07/2021 */
/*comment by Kridtiya i. A64-0295 DATE. 25/07/2021 
FOR EACH wdetail no-lock.
  EXPORT DELIMITER "|" 
      wdetail.XRefNo1               
      wdetail.Barcode                                                                
      wdetail.InsuredName                                                            
      wdetail.PolicyNo                                                               
      wdetail.EndorseNo             
      wdetail.SumInsured           
      /*wdetail.sumfire*/           /*A61-0228*/  /* A61-0322 */
      wdetail.NetPremium                                                                   
      wdetail.VatTax                                                                         
      wdetail.Stamp                 
      wdetail.GrossPremium                                                                   
      wdetail.EffectiveDate                                                                  
      wdetail.ExpireDate                                                                     
      wdetail.EndorseReason 
      wdetail.trntyp                /*A61-0228*/ 
      wdetail.sumfire .           /* A61-0322 */
END. comment by Kridtiya i. A64-0295 DATE. 25/07/2021 */
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pro_reportpolicy2 C-Win 
PROCEDURE Pro_reportpolicy2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:  Add By Tontawan S. A66-0006     
------------------------------------------------------------------------------*/
FOR EACH wdetail NO-LOCK WHERE
    wdetail.EndorseNo = "" .      /* ੾�С������� */
    FIND LAST wdetail2 WHERE
        wdetail2.chassis = wdetail.chassis AND
        wdetail2.covcod  = wdetail.covcod  AND
        wdetail2.covtyp  = wdetail.covtyp  NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL wdetail2 THEN DO:
        EXPORT DELIMITER "," 
            TRIM(wdetail.XRefNo1)      /* "�Ţ���㺤Ӣ͡�������"          */                   
            TRIM(wdetail.Barcode)      /* "�Ţ��� Cuscode"                */                                                   
            TRIM(wdetail.InsuredName)  /* "���ͼ����һ�Сѹ���"           */                                                   
            TRIM(wdetail.PolicyNo)     /* "�Ţ����������"                */                                                   
            TRIM(wdetail.EndorseNo)    /* "�Ţ�����ѡ��ѧ"                */                   
            TRIM(replace(wdetail.SumInsured,",",""))   /* "�ع��Сѹ"                     */     
            TRIM(replace(wdetail.NetPremium,",",""))   /* "���»�Сѹ�ط��"              */                                                         
            TRIM(replace(wdetail.VatTax,",",""))       /* "��������"                     */                                                           
            TRIM(replace(wdetail.Stamp,",",""))        /* "�����ҡ�"                     */     
            TRIM(replace(wdetail.GrossPremium,",","")) /* "���»�Сѹ���"                */                                                           
            TRIM(wdetail.EffectiveDate)     /* "�ѹ�����������ռźѧ�Ѻ"      */                                                           
            TRIM(wdetail.ExpireDate)        /* "�ѹ�������ش��������"         */                                                           
            TRIM(wdetail.EndorseReason)     /* "�˵ؼš�÷���ѡ��ѧ"           */              
            TRIM(wdetail.trntyp)            /* "�������ͧ��Сѹ"               */              
            TRIM(wdetail.sumfire)           /* "�ع�٭��� - �����"            */              
            TRIM(wdetail2.Send_Policy_Date) /* "�ѹ���Ѵ���͡���"            */              
            TRIM(wdetail2.Tracking_Number ) /* "�Ţŧ����¹"                  */              
            TRIM(wdetail2.Yes_File_Date)    /* "�ѹ����駧ҹ"                 */       
            TRIM(wdetail2.Policy_Status)    /* "ʶҹС�������"                 */       
            TRIM(wdetail2.Policy_Year)      /* "�ӹǹ�ա�������"               */       
            TRIM(wdetail2.Agent_Code)       /* "Agent Code"                    */       
            TRIM(wdetail2.Agent_Name_TH)    /* "Agent Name TH"                 */       
            TRIM(wdetail2.Agent_Name_Eng)   /* "Agent Name Eng"                */       
            TRIM(wdetail.cmr_code)          /* "���ʺ���ѷ��Сѹ���"           */       
            TRIM(wdetail.comp_code)         /* "���ͺ���ѷ��Сѹ���"           */       
            TRIM(wdetail.campcode)      /* "������໭"                    */       
            TRIM(wdetail.campname)      /* "������໭"                    */       
            TRIM(wdetail.procode )      /* "���ʼ�Ե�ѳ��"                 */       
            TRIM(wdetail.proname )      /* "���ͼ�Ե�ѳ��ͧ��Сѹ���"     */       
            TRIM(wdetail.packname)      /* "����ᾤࡨ"                    */       
            TRIM(wdetail.packcode)      /* "����ᾤࡨ"                    */       
            TRIM(wdetail.instype)       /* "����������͡�������"          */       
            TRIM(wdetail.pol_title)     /* "�ӹ�˹�Ҫ��� ����͡�������"   */       
            TRIM(wdetail.pol_fname)     /* "���ͼ����һ�Сѹ����͡�������"            */     
            TRIM(wdetail.pol_lname)     /* "���ʡ�ż����һ�Сѹ ����͡�������"        */
            TRIM(wdetail.pol_title_eng) /* "�ӹ�˹�Ҫ��� ����͡������� �����ѧ���     */
            TRIM(wdetail.pol_fname_eng) /* "�������� �ѧ���"                           */
            TRIM(wdetail.pol_lname_eng) /* "���ʡ������ �ѧ���"                        */
            TRIM(wdetail.icno)          /* "�Ţ���ѵû�Шӵ�Ǣͧ����͡�������"       */
            TRIM(wdetail.sex)           /* "�� ����͡�������"                        */
            TRIM(wdetail.bdate)         /* "�ѹ��͹���Դ ����͡�������"             */
            TRIM(wdetail.occup)         /* "�Ҫվ ����͡�������"                      */
            TRIM(wdetail.tel)           /* "���Ѿ��-��ҹ-����͡�������"              */
            TRIM(wdetail.phone)         /* "���������Ѿ��-��ҹ-����͡�������"      */
            TRIM(wdetail.teloffic)      /* "���Ѿ��-���ӧҹ ����͡�������"          */
            TRIM(wdetail.telext)        /* "���������Ѿ��-���ӧҹ ����͡�����     */
            TRIM(wdetail.moblie)        /* "���Ѿ��-��Ͷ�� ����͡�������"            */
            TRIM(wdetail.mobliech)      /* "���Ѿ��-��Ͷ�� ����͡������� ����"       */
            TRIM(wdetail.mail)          /* "email-����͡�������"                      */
            TRIM(wdetail.lineid)        /* "Line_ID"                                   */
            TRIM(wdetail.addr1_70)      /* "������� �Ţ����ҹ-����͡�������"         */
            TRIM(wdetail.addr2_70)      /* "������� �����ҹ - ����͡�������"         */
            TRIM(wdetail.addr3_70)      /* "������� ����-����͡�������"               */
            TRIM(wdetail.addr4_70)      /* "������� ��͡ ���-����͡�������"           */
            TRIM(wdetail.addr5_70)      /* "������� ���-����͡�������"                */
            TRIM(wdetail.nsub_dist70)   /* "������� �����ǧ-����͡�������"           */
            TRIM(wdetail.ndirection70)  /* "������� ࢵ/�����-����͡�������"          */
            TRIM(wdetail.nprovin70)     /* "������� �ѧ��Ѵ-����͡�������"            */
            TRIM(wdetail.zipcode70)     /* "������� ������ɳ���-����͡�������"       */
            TRIM(wdetail.addr1_72)      /* "������� �Ţ����ҹ-�������Ѵ���͡���     */
            TRIM(wdetail.addr2_72)      /* "������� �����ҹ - �������Ѵ���͡���     */
            TRIM(wdetail.addr3_72)      /* "������� ����-�������㹡�èѴ���͡���"     */
            TRIM(wdetail.addr4_72)      /* "������� ��͡ ���-�������Ѵ���͡���"      */
            TRIM(wdetail.addr5_72)      /* "������� ���-�������Ѵ���͡���"           */
            TRIM(wdetail.nsub_dist72)   /* "������� �����ǧ-�������Ѵ���͡���"      */
            TRIM(wdetail.ndirection72)  /* "������� ࢵ/�����-�������Ѵ���͡���"     */
            TRIM(wdetail.nprovin72)     /* "������� �ѧ��Ѵ-�������㹡�èѴ���͡�     */
            TRIM(wdetail.zipcode72)     /* "������� ������ɳ���-�������Ѵ���͡�     */
            TRIM(wdetail.paytype)       /* "������(����ѷ,�ؤ��) �������Թ������     */
            TRIM(wdetail.paytitle)      /* "�ӹ�˹�Ҫ������ �������Թ��������"      */
            TRIM(wdetail.payname)       /* "���ͼ����һ�Сѹ �������Թ��������"      */
            TRIM(wdetail.paylname)      /* "���ʡ�ż����һ�Сѹ �������Թ�������     */
            TRIM(wdetail.payicno)       /* "�Ţ���ѵû�Шӵ�� �������Թ��������     */
            TRIM(wdetail.payaddr1)      /* "������� �Ţ����ҹ-�������Թ"            */
            TRIM(wdetail.payaddr2)      /* "������� �����ҹ - �������Թ"            */
            TRIM(wdetail.payaddr3)      /* "������� ����-�������Թ"                  */
            TRIM(wdetail.payaddr4)      /* "������� ��͡ ���-�������Թ"              */
            TRIM(wdetail.payaddr5)      /* "������� ���-�������Թ"                   */
            TRIM(wdetail.payaddr6)      /* "������� �ǧ-�������Թ"                  */
            TRIM(wdetail.payaddr7)      /* "������� ࢵ/�����(Code)-�������Թ"       */
            TRIM(wdetail.payaddr8)      /* "������� �ѧ��Ѵ(Code)-�������Թ"         */
            TRIM(wdetail.payaddr9)      /* "������� ������ɳ���-�������Թ"          */
            TRIM(wdetail.branch)        /* "�ӹѡ�ҹ�˭�/�Ң�"                         */
            TRIM(wdetail.ben_title)     /* "�ӹ�˹�Ҫ��� ����Ѻ�Ż���ª��"             */
            TRIM(wdetail.ben_name)      /* "���ͼ���Ѻ�Ż���ª��"                      */
            TRIM(wdetail.ben_lname)     /* "���ʡ�� ����Ѻ�Ż���ª��"                  */
            TRIM(wdetail.pmentcode)     /* "���ʻ�������ê������»�Сѹ"              */
            TRIM(wdetail.pmenttyp)      /* "��������ê������»�Сѹ"                  */
            TRIM(wdetail.pmentcode1)    /* "���ʪ�ͧ�ҧ����������"                   */
            TRIM(wdetail.pmentcode2)    /* "��ͧ�ҧ�����Ф������"                    */
            TRIM(wdetail.pmentbank)     /* "��Ҥ�÷���������"                        */
            TRIM(wdetail.pmentdate)     /* "�ѹ�����Ф������"                        */
            TRIM(wdetail.pmentsts)      /* "ʶҹС�ê�������"                         */
            TRIM(wdetail.driver)        /* "����кت��ͼ��Ѻ"                         */
            TRIM(wdetail.drivetitle1)   /* "�ӹ�˹�Ҫ��� ���Ѻ��� 1"                  */
            TRIM(wdetail.drivename1)    /* "���ͼ��Ѻ��� 1"                           */
            TRIM(wdetail.drivelname1)   /* "���ʡ�� ���Ѻ��� 1"                       */
            TRIM(wdetail.driveno1)      /* "�Ţ���ѵû�Шӵ�� ���Ѻ��� 1"            */
            TRIM(wdetail.occupdriv1)    /* "Driver1Occupation"                         */
            TRIM(wdetail.sexdriv1)      /* "�� ���Ѻ��� 1"                           */
            TRIM(wdetail.bdatedriv1)    /* "�ѹ��͹���Դ ( DD/MM/YYYY) ���Ѻ���     */
            TRIM(wdetail.drivetitle2)   /* "�ӹ�˹�Ҫ��� ���Ѻ��� 2"                  */
            TRIM(wdetail.drivename2)    /* "���ͼ��Ѻ��� 2"                           */
            TRIM(wdetail.drivelname2)   /* "���ʡ�� ���Ѻ��� 2"                       */
            TRIM(wdetail.driveno2)      /* "�Ţ���ѵû�Шӵ�� ���Ѻ��� 2"            */
            TRIM(wdetail.occupdriv2)    /* "Driver2Occupation"                         */
            TRIM(wdetail.sexdriv2)      /* "�� ���Ѻ��� 2"                           */
            TRIM(wdetail.bdatedriv2)    /* "�ѹ��͹���Դ ( DD/MM/YYYY) ���Ѻ���     */
            TRIM(wdetail2.brand)        /* "����ö¹��"                                */
            TRIM(wdetail2.brand_cd)     /* "���ʪ���ö¹��"                            */
            TRIM(wdetail2.Model)        /* "�������ö¹��"                            */
            TRIM(wdetail2.Model_cd)     /* "���ʪ������ö¹��"                        */
            TRIM(wdetail2.body)         /* "Ẻ��Ƕѧ"                                 */
            TRIM(wdetail2.body_cd)      /* "����Ẻ��Ƕѧ"                             */
            TRIM(wdetail2.licence)      /* "����¹ö"                                 */
            TRIM(wdetail2.province)     /* "�ѧ��Ѵ��訴����¹"                       */
            TRIM(wdetail2.chassis)      /* "�Ţ��Ƕѧ"                                 */
            TRIM(wdetail2.engine)       /* "�Ţ����ͧ¹��"                            */
            TRIM(wdetail2.yrmanu)       /* "�ը�����¹ö"                             */
            TRIM(wdetail2.seatenew)     /* "�ӹǹ�����"                              */
            TRIM(replace(wdetail2.power,",",""))   /* "��Ҵ����ͧ¹��"                           */
            TRIM(replace(wdetail2.weight,",",""))  /* "���˹ѡ"                                   */
            TRIM(wdetail2.class)         /* "���ʡ����ö¹��"                          */
            TRIM(wdetail2.garage_cd)     /* "��������ë���"                             */
            TRIM(wdetail2.garage)        /* "���ʡ�ë���"                               */
            TRIM(wdetail2.colorcode)     /* "��ö"                                      */
            TRIM(wdetail2.covcod)        /* "���ʻ������ͧ��Сѹ���"                    */
            TRIM(wdetail2.covtyp)        /* "�������ͧ��Сѹ���"                        */
            TRIM(wdetail2.covtyp1)       /* "�������ͧ����������ͧ"                     */
            TRIM(wdetail2.covtyp2)       /* "���������¢ͧ����������ͧ"                 */
            TRIM(wdetail2.covtyp3)       /* "��������´���������¢ͧ����������ͧ"       */
            TRIM(wdetail2.comdat)        /* "�ѹ���������������ͧ"                      */
            TRIM(wdetail2.expdat)        /* "�ѹ�������ش����������ͧ"                 */
            TRIM(replace(wdetail2.ins_amt,",",""))    /* "�ع��Сѹ"                                 */
            TRIM(replace(wdetail2.prem1,",",""))      /* "���»�Сѹ��ѡ (��͹�ѡ��ǹŴ)"           */
            TRIM(replace(wdetail2.gross_prm,",",""))  /* "�����ط����ѧ�ѡ��ǹŴ"                   */
            TRIM(replace(wdetail2.stamp,",",""))      /* "�ӹǹ�ҡ������"                           */
            TRIM(replace(wdetail2.vat,",",""))        /* "�ӹǹ���� SBT/Vat"                         */
            TRIM(replace(wdetail2.premtotal,",",""))  /* "������� ����-�ҡ�"                        */
            TRIM(replace(wdetail2.deduct,",",""))     /* "��Ҥ������������ǹ�á"                     */
            TRIM(wdetail2.fleetper)         /* "% ��ǹŴ�����"                             */
            TRIM(replace(wdetail2.fleet,",",""))  /* "�ӹǹ��ǹŴ�����"                          */
            TRIM(wdetail2.ncbper)           /* "% ��ǹŴ����ѵԴ�"                         */
            TRIM(replace(wdetail2.ncb,",",""))  /* "�ӹǹ��ǹŴ����ѵԴ�"                      */
            TRIM(wdetail2.drivper)          /* "% ��ǹŴ�ó��кت��ͼ��Ѻ���"             */
            TRIM(replace(wdetail2.drivdis,",",""))  /* "�ӹǹ��ǹŴ�ó��кت��ͼ��Ѻ���"          */
            TRIM(wdetail2.othper)           /* "%�ǹŴ����"                               */
            TRIM(replace(wdetail2.oth,",",""))  /* "�ӹǹ��ǹŴ����"                          */
            TRIM(wdetail2.cctvper)          /* "%�ǹŴ���ͧ"                               */
            TRIM(replace(wdetail2.cctv,",","")) /* "�ӹǹ��ǹŴ���ͧ"                          */
            TRIM(wdetail2.Surcharper)       /* "%��ǹŴ����"                              */
            TRIM(replace(wdetail2.Surchar,",",""))  /* "�ӹǹ��ǹŴ����"                          */
            TRIM(wdetail2.Surchardetail)    /* "��������´��ǹ����"                       */
            TRIM(wdetail2.acc1)             /* "���� �ػ�ó� ������� 1"                  */
            TRIM(wdetail2.accdetail1)       /* "��������´������� 1"                     */
            TRIM(wdetail2.accprice1)        /* "�ع��Сѹ�ѹ/�Ҥ��ػ�ó� ������� 1"      */
            TRIM(wdetail2.acc2)             /* "���� �ػ�ó� ������� 2"                  */
            TRIM(wdetail2.accdetail2)       /* "��������´������� 2"                     */
            TRIM(wdetail2.accprice2)        /* "�ع��Сѹ�ѹ/�Ҥ��ػ�ó� ������� 2"      */
            TRIM(wdetail2.acc3)             /* "���� �ػ�ó� ������� 3"                  */
            TRIM(wdetail2.accdetail3)       /* "��������´������� 3"                     */
            TRIM(wdetail2.accprice3)        /* "�ع��Сѹ�ѹ/�Ҥ��ػ�ó� ������� 3"      */
            TRIM(wdetail2.acc4)             /* "���� �ػ�ó� ������� 4"                  */
            TRIM(wdetail2.accdetail4)       /* "��������´������� 4"                     */
            TRIM(wdetail2.accprice4)        /* "�ع��Сѹ�ѹ/�Ҥ��ػ�ó� ������� 4"      */
            TRIM(wdetail2.acc5)             /* "���� �ػ�ó� ������� 5"                  */
            TRIM(wdetail2.accdetail5)       /* "��������´������� 5"                     */
            TRIM(wdetail2.accprice5)        /* "�ع��Сѹ�ѹ/�Ҥ��ػ�ó� ������� 5"      */
            TRIM(wdetail2.inspdate)         /* "�ѹ����Ǩ��Ҿö"                          */
            TRIM(wdetail2.inspdate_app)     /* "�ѹ���͹��ѵԼš�õ�Ǩ��Ҿö"              */
            TRIM(wdetail2.inspsts)          /* "�š�õ�Ǩ��Ҿö"                           */
            TRIM(wdetail2.inspdetail)       /* "��������´��õ�Ǩ��Ҿö"                   */
            TRIM(wdetail2.not_date)         /* "�ѹ�����"                                 */
           /*wdetail2.paydate               /* "�ѹ����Ѻ�����Թ"                         */
            wdetail2.paysts */              /* "ʶҹС�è����Թ"                          */
            TRIM(wdetail2.licenBroker)      /* "�Ţ����͹حҵ���˹�� (SCBPT)"             */
            TRIM(wdetail2.brokname)         /* "���ͺ���ѷ���˹�� (SCBPT)"                 */
            TRIM(wdetail2.brokcode)         /* "�����ä����"                             */
            TRIM(wdetail2.lang)             /* "����㹡���͡��������"                      */
            TRIM(wdetail2.deli)             /* "��ͧ�ҧ��èѴ��"                          */
            TRIM(wdetail2.delidetail)       /* "�����˵ء�èѴ��"                         */
            TRIM(wdetail2.gift)             /* "�ͧ��"                                    */
            TRIM(wdetail2.remark)           /* "�����˵�"                                  */
            TRIM(wdetail2.Selling_Channel)  /* "Selling Channel"  .                        */
            /*-- Add By Tontawan S. A68-0059 27/03/2025 --*/
            TRIM(wdetail.drv3_salutation_M) 
            TRIM(wdetail.drv3_fname)        
            TRIM(wdetail.drv3_lname)        
            TRIM(wdetail.drv3_nid)          
            TRIM(wdetail.drv3_occupation)   
            TRIM(wdetail.drv3_gender)       
            TRIM(wdetail.drv3_birthdate)    
            TRIM(wdetail.drv4_salutation_M) 
            TRIM(wdetail.drv4_fname)        
            TRIM(wdetail.drv4_lname)        
            TRIM(wdetail.drv4_nid)          
            TRIM(wdetail.drv4_occupation)   
            TRIM(wdetail.drv4_gender)       
            TRIM(wdetail.drv4_birthdate)    
            TRIM(wdetail.drv5_salutation_M) 
            TRIM(wdetail.drv5_fname)        
            TRIM(wdetail.drv5_lname)        
            TRIM(wdetail.drv5_nid)          
            TRIM(wdetail.drv5_occupation)   
            TRIM(wdetail.drv5_gender)       
            TRIM(wdetail.drv5_birthdate)    
            TRIM(wdetail.drv1_dlicense)     
            TRIM(wdetail.drv2_dlicense)     
            TRIM(wdetail.drv3_dlicense)     
            TRIM(wdetail.drv4_dlicense)     
            TRIM(wdetail.drv5_dlicense)     
            TRIM(wdetail.baty_snumber)      
            TRIM(wdetail.batydate)          
            TRIM(wdetail.baty_rsi)          
            TRIM(wdetail.baty_npremium)     
            TRIM(wdetail.baty_gpremium)     
            TRIM(wdetail.wcharge_snumber)   
            TRIM(wdetail.wcharge_si)        
            TRIM(wdetail.wcharge_npremium)  
            TRIM(wdetail.wcharge_gpremium). 
            /*-- End By Tontawan S. A68-0059 27/03/2025 --*/
    END.
END.
OUTPUT CLOSE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pro_reportpolicy2_OLD C-Win 
PROCEDURE Pro_reportpolicy2_OLD :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*--- Comment By Tontawan S. A66-0006 ------
FOR EACH wdetail NO-LOCK WHERE
    wdetail.EndorseNo = "" .      /* ੾�С������� */
    FIND LAST wdetail2 WHERE
        wdetail2.chassis = wdetail.chassis AND
        wdetail2.covcod  = wdetail.covcod  AND
        wdetail2.covtyp  = wdetail.covtyp  NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL wdetail2 THEN DO:
        EXPORT DELIMITER "," 
            wdetail.XRefNo1                      /* "�Ţ���㺤Ӣ͡�������"          */                
            wdetail.Barcode                      /* "�Ţ��� Cuscode"                */                                                     
            wdetail.InsuredName                  /* "���ͼ����һ�Сѹ���"           */                                                     
            wdetail.PolicyNo                     /* "�Ţ����������"                */                                                     
            wdetail.EndorseNo                    /* "�Ţ�����ѡ��ѧ"                */       
            replace(wdetail.SumInsured,",","")   /* "�ع��Сѹ"                     */       
            replace(wdetail.NetPremium,",","")   /* "���»�Сѹ�ط��"              */                                                           
            replace(wdetail.VatTax,",","")       /* "��������"                     */                                                             
            replace(wdetail.Stamp,",","")        /* "�����ҡ�"                     */       
            replace(wdetail.GrossPremium,",","") /* "���»�Сѹ���"                */                                                             
            wdetail.EffectiveDate                /* "�ѹ�����������ռźѧ�Ѻ"      */                                                             
            wdetail.ExpireDate                   /* "�ѹ�������ش��������"         */                                                             
            wdetail.EndorseReason                /* "�˵ؼš�÷���ѡ��ѧ"           */       
            wdetail.trntyp                       /* "�������ͧ��Сѹ"               */       
            wdetail.sumfire                      /* "�ع�٭��� - �����"            */       
            wdetail2.Send_Policy_Date            /* "�ѹ���Ѵ���͡���"            */       
            wdetail2.Tracking_Number             /* "�Ţŧ����¹"                  */       
            wdetail2.Yes_File_Date               /* "�ѹ����駧ҹ"                 */       
            wdetail2.Policy_Status               /* "ʶҹС�������"                 */       
            wdetail2.Policy_Year                 /* "�ӹǹ�ա�������"               */       
            wdetail2.Agent_Code                  /* "Agent Code"                    */       
            wdetail2.Agent_Name_TH               /* "Agent Name TH"                 */       
            wdetail2.Agent_Name_Eng              /* "Agent Name Eng"                */       
            wdetail.cmr_code                     /* "���ʺ���ѷ��Сѹ���"           */       
            wdetail.comp_code                    /* "���ͺ���ѷ��Сѹ���"           */       
            wdetail.campcode                     /* "������໭"                    */       
            wdetail.campname                     /* "������໭"                    */       
            wdetail.procode                      /* "���ʼ�Ե�ѳ��"                 */       
            wdetail.proname                   /* "���ͼ�Ե�ѳ��ͧ��Сѹ���"     */       
            wdetail.packname                  /* "����ᾤࡨ"                    */       
            wdetail.packcode                  /* "����ᾤࡨ"                    */       
            wdetail.instype                   /* "����������͡�������"          */       
            wdetail.pol_title                 /* "�ӹ�˹�Ҫ��� ����͡�������"   */       
            wdetail.pol_fname                 /* "���ͼ����һ�Сѹ����͡�������"            */     
            wdetail.pol_lname                 /* "���ʡ�ż����һ�Сѹ ����͡�������"        */
            wdetail.pol_title_eng             /* "�ӹ�˹�Ҫ��� ����͡������� �����ѧ���     */
            wdetail.pol_fname_eng             /* "�������� �ѧ���"                           */
            wdetail.pol_lname_eng             /* "���ʡ������ �ѧ���"                        */
            wdetail.icno                      /* "�Ţ���ѵû�Шӵ�Ǣͧ����͡�������"       */
            wdetail.sex                       /* "�� ����͡�������"                        */
            wdetail.bdate                     /* "�ѹ��͹���Դ ����͡�������"             */
            wdetail.occup                     /* "�Ҫվ ����͡�������"                      */
            wdetail.tel                       /* "���Ѿ��-��ҹ-����͡�������"              */
            wdetail.phone                     /* "���������Ѿ��-��ҹ-����͡�������"      */
            wdetail.teloffic                  /* "���Ѿ��-���ӧҹ ����͡�������"          */
            wdetail.telext                    /* "���������Ѿ��-���ӧҹ ����͡�����     */
            wdetail.moblie                    /* "���Ѿ��-��Ͷ�� ����͡�������"            */
            wdetail.mobliech                  /* "���Ѿ��-��Ͷ�� ����͡������� ����"       */
            wdetail.mail                      /* "email-����͡�������"                      */
            wdetail.lineid                    /* "Line_ID"                                   */
            wdetail.addr1_70                  /* "������� �Ţ����ҹ-����͡�������"         */
            wdetail.addr2_70                  /* "������� �����ҹ - ����͡�������"         */
            wdetail.addr3_70                  /* "������� ����-����͡�������"               */
            wdetail.addr4_70                  /* "������� ��͡ ���-����͡�������"           */
            wdetail.addr5_70                  /* "������� ���-����͡�������"                */
            wdetail.nsub_dist70               /* "������� �����ǧ-����͡�������"           */
            wdetail.ndirection70              /* "������� ࢵ/�����-����͡�������"          */
            wdetail.nprovin70                 /* "������� �ѧ��Ѵ-����͡�������"            */
            wdetail.zipcode70                 /* "������� ������ɳ���-����͡�������"       */
            wdetail.addr1_72                  /* "������� �Ţ����ҹ-�������Ѵ���͡���     */
            wdetail.addr2_72                  /* "������� �����ҹ - �������Ѵ���͡���     */
            wdetail.addr3_72                  /* "������� ����-�������㹡�èѴ���͡���"     */
            wdetail.addr4_72                  /* "������� ��͡ ���-�������Ѵ���͡���"      */
            wdetail.addr5_72                  /* "������� ���-�������Ѵ���͡���"           */
            wdetail.nsub_dist72               /* "������� �����ǧ-�������Ѵ���͡���"      */
            wdetail.ndirection72              /* "������� ࢵ/�����-�������Ѵ���͡���"     */
            wdetail.nprovin72                 /* "������� �ѧ��Ѵ-�������㹡�èѴ���͡�     */
            wdetail.zipcode72                 /* "������� ������ɳ���-�������Ѵ���͡�     */
            wdetail.paytype                   /* "������(����ѷ,�ؤ��) �������Թ������     */
            wdetail.paytitle                  /* "�ӹ�˹�Ҫ������ �������Թ��������"      */
            wdetail.payname                   /* "���ͼ����һ�Сѹ �������Թ��������"      */
            wdetail.paylname                  /* "���ʡ�ż����һ�Сѹ �������Թ�������     */
            wdetail.payicno                   /* "�Ţ���ѵû�Шӵ�� �������Թ��������     */
            wdetail.payaddr1                  /* "������� �Ţ����ҹ-�������Թ"            */
            wdetail.payaddr2                  /* "������� �����ҹ - �������Թ"            */
            wdetail.payaddr3                  /* "������� ����-�������Թ"                  */
            wdetail.payaddr4                  /* "������� ��͡ ���-�������Թ"              */
            wdetail.payaddr5                  /* "������� ���-�������Թ"                   */
            wdetail.payaddr6                  /* "������� �ǧ-�������Թ"                  */
            wdetail.payaddr7                  /* "������� ࢵ/�����(Code)-�������Թ"       */
            wdetail.payaddr8                  /* "������� �ѧ��Ѵ(Code)-�������Թ"         */
            wdetail.payaddr9                  /* "������� ������ɳ���-�������Թ"          */
            wdetail.branch                    /* "�ӹѡ�ҹ�˭�/�Ң�"                         */
            wdetail.ben_title                 /* "�ӹ�˹�Ҫ��� ����Ѻ�Ż���ª��"             */
            wdetail.ben_name                  /* "���ͼ���Ѻ�Ż���ª��"                      */
            wdetail.ben_lname                 /* "���ʡ�� ����Ѻ�Ż���ª��"                  */
            wdetail.pmentcode                 /* "���ʻ�������ê������»�Сѹ"              */
            wdetail.pmenttyp                  /* "��������ê������»�Сѹ"                  */
            wdetail.pmentcode1                /* "���ʪ�ͧ�ҧ����������"                   */
            wdetail.pmentcode2                /* "��ͧ�ҧ�����Ф������"                    */
            wdetail.pmentbank                 /* "��Ҥ�÷���������"                        */
            wdetail.pmentdate                 /* "�ѹ�����Ф������"                        */
            wdetail.pmentsts                  /* "ʶҹС�ê�������"                         */
            wdetail.driver                    /* "����кت��ͼ��Ѻ"                         */
            wdetail.drivetitle1               /* "�ӹ�˹�Ҫ��� ���Ѻ��� 1"                  */
            wdetail.drivename1                /* "���ͼ��Ѻ��� 1"                           */
            wdetail.drivelname1               /* "���ʡ�� ���Ѻ��� 1"                       */
            wdetail.driveno1                  /* "�Ţ���ѵû�Шӵ�� ���Ѻ��� 1"            */
            wdetail.occupdriv1                /* "Driver1Occupation"                         */
            wdetail.sexdriv1                  /* "�� ���Ѻ��� 1"                           */
            wdetail.bdatedriv1                /* "�ѹ��͹���Դ ( DD/MM/YYYY) ���Ѻ���     */
            wdetail.drivetitle2               /* "�ӹ�˹�Ҫ��� ���Ѻ��� 2"                  */
            wdetail.drivename2                /* "���ͼ��Ѻ��� 2"                           */
            wdetail.drivelname2               /* "���ʡ�� ���Ѻ��� 2"                       */
            wdetail.driveno2                  /* "�Ţ���ѵû�Шӵ�� ���Ѻ��� 2"            */
            wdetail.occupdriv2                /* "Driver2Occupation"                         */
            wdetail.sexdriv2                  /* "�� ���Ѻ��� 2"                           */
            wdetail.bdatedriv2                /* "�ѹ��͹���Դ ( DD/MM/YYYY) ���Ѻ���     */
            wdetail2.brand                    /* "����ö¹��"                                */
            wdetail2.brand_cd                 /* "���ʪ���ö¹��"                            */
            wdetail2.Model                    /* "�������ö¹��"                            */
            wdetail2.Model_cd                 /* "���ʪ������ö¹��"                        */
            wdetail2.body                     /* "Ẻ��Ƕѧ"                                 */
            wdetail2.body_cd                  /* "����Ẻ��Ƕѧ"                             */
            wdetail2.licence                  /* "����¹ö"                                 */
            wdetail2.province                 /* "�ѧ��Ѵ��訴����¹"                       */
            wdetail2.chassis                  /* "�Ţ��Ƕѧ"                                 */
            wdetail2.engine                   /* "�Ţ����ͧ¹��"                            */
            wdetail2.yrmanu                   /* "�ը�����¹ö"                             */
            wdetail2.seatenew                 /* "�ӹǹ�����"                              */
            replace(wdetail2.power,",","")    /* "��Ҵ����ͧ¹��"                           */
            replace(wdetail2.weight,",","")   /* "���˹ѡ"                                   */
            wdetail2.class                    /* "���ʡ����ö¹��"                          */
            wdetail2.garage_cd                /* "��������ë���"                             */
            wdetail2.garage                   /* "���ʡ�ë���"                               */
            wdetail2.colorcode                /* "��ö"                                      */
            wdetail2.covcod                   /* "���ʻ������ͧ��Сѹ���"                    */
            wdetail2.covtyp                   /* "�������ͧ��Сѹ���"                        */
            wdetail2.covtyp1                  /* "�������ͧ����������ͧ"                     */
            wdetail2.covtyp2                  /* "���������¢ͧ����������ͧ"                 */
            wdetail2.covtyp3                  /* "��������´���������¢ͧ����������ͧ"       */
            wdetail2.comdat                   /* "�ѹ���������������ͧ"                      */
            wdetail2.expdat                   /* "�ѹ�������ش����������ͧ"                 */
            replace(wdetail2.ins_amt,",","")  /* "�ع��Сѹ"                                 */
            replace(wdetail2.prem1,",","")      /* "���»�Сѹ��ѡ (��͹�ѡ��ǹŴ)"           */
            replace(wdetail2.gross_prm,",","")  /* "�����ط����ѧ�ѡ��ǹŴ"                   */
            replace(wdetail2.stamp,",","")      /* "�ӹǹ�ҡ������"                           */
            replace(wdetail2.vat,",","")        /* "�ӹǹ���� SBT/Vat"                         */
            replace(wdetail2.premtotal,",","")  /* "������� ����-�ҡ�"                        */
            replace(wdetail2.deduct,",","")     /* "��Ҥ������������ǹ�á"                     */
            wdetail2.fleetper                   /* "% ��ǹŴ�����"                             */
            replace(wdetail2.fleet,",","")      /* "�ӹǹ��ǹŴ�����"                          */
            wdetail2.ncbper                     /* "% ��ǹŴ����ѵԴ�"                         */
            replace(wdetail2.ncb,",","")        /* "�ӹǹ��ǹŴ����ѵԴ�"                      */
            wdetail2.drivper                    /* "% ��ǹŴ�ó��кت��ͼ��Ѻ���"             */
            replace(wdetail2.drivdis,",","")    /* "�ӹǹ��ǹŴ�ó��кت��ͼ��Ѻ���"          */
            wdetail2.othper                     /* "%�ǹŴ����"                               */
            replace(wdetail2.oth,",","")        /* "�ӹǹ��ǹŴ����"                          */
            wdetail2.cctvper                    /* "%�ǹŴ���ͧ"                               */
            replace(wdetail2.cctv,",","")       /* "�ӹǹ��ǹŴ���ͧ"                          */
            wdetail2.Surcharper                 /* "%��ǹŴ����"                              */
            replace(wdetail2.Surchar,",","")    /* "�ӹǹ��ǹŴ����"                          */
            wdetail2.Surchardetail     /* "��������´��ǹ����"                       */
            wdetail2.acc1              /* "���� �ػ�ó� ������� 1"                  */
            wdetail2.accdetail1        /* "��������´������� 1"                     */
            wdetail2.accprice1         /* "�ع��Сѹ�ѹ/�Ҥ��ػ�ó� ������� 1"      */
            wdetail2.acc2              /* "���� �ػ�ó� ������� 2"                  */
            wdetail2.accdetail2        /* "��������´������� 2"                     */
            wdetail2.accprice2         /* "�ع��Сѹ�ѹ/�Ҥ��ػ�ó� ������� 2"      */
            wdetail2.acc3              /* "���� �ػ�ó� ������� 3"                  */
            wdetail2.accdetail3        /* "��������´������� 3"                     */
            wdetail2.accprice3         /* "�ع��Сѹ�ѹ/�Ҥ��ػ�ó� ������� 3"      */
            wdetail2.acc4              /* "���� �ػ�ó� ������� 4"                  */
            wdetail2.accdetail4        /* "��������´������� 4"                     */
            wdetail2.accprice4         /* "�ع��Сѹ�ѹ/�Ҥ��ػ�ó� ������� 4"      */
            wdetail2.acc5              /* "���� �ػ�ó� ������� 5"                  */
            wdetail2.accdetail5        /* "��������´������� 5"                     */
            wdetail2.accprice5         /* "�ع��Сѹ�ѹ/�Ҥ��ػ�ó� ������� 5"      */
            wdetail2.inspdate          /* "�ѹ����Ǩ��Ҿö"                          */
            wdetail2.inspdate_app      /* "�ѹ���͹��ѵԼš�õ�Ǩ��Ҿö"              */
            wdetail2.inspsts           /* "�š�õ�Ǩ��Ҿö"                           */
            wdetail2.inspdetail        /* "��������´��õ�Ǩ��Ҿö"                   */
            wdetail2.not_date          /* "�ѹ�����"                                 */
           /* wdetail2.paydate           /* "�ѹ����Ѻ�����Թ"                         */
            wdetail2.paysts */           /* "ʶҹС�è����Թ"                          */
            wdetail2.licenBroker       /* "�Ţ����͹حҵ���˹�� (SCBPT)"             */
            wdetail2.brokname          /* "���ͺ���ѷ���˹�� (SCBPT)"                 */
            wdetail2.brokcode          /* "�����ä����"                             */
            wdetail2.lang              /* "����㹡���͡��������"                      */
            wdetail2.deli              /* "��ͧ�ҧ��èѴ��"                          */
            wdetail2.delidetail        /* "�����˵ء�èѴ��"                         */
            wdetail2.gift              /* "�ͧ��"                                    */
            wdetail2.remark            /* "�����˵�"                                  */
            wdetail2.Selling_Channel.  /* "Selling Channel"  .                        */
    END.
    
END.
OUTPUT CLOSE.
---- Comment By Tontawan S. A66-0006 ------*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pro_reportpolicyENDS C-Win 
PROCEDURE pro_reportpolicyENDS :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR pol72 AS CHAR FORMAT "x(12)" INIT "" .   
If  substr(fi_outloadends,length(fi_outloadends) - 3,4) <>  ".csv"  THEN 
    fi_outloadends  =  Trim(fi_outloadends) + ".csv"  .

OUTPUT TO VALUE(fi_outloadends).
EXPORT DELIMITER "," 
    "Application_Form__c"            
    "Account__c"                                         
    "InsuredName__c"        
    "PolicyNo__c"                                       
    "Name"                                            
    "Endorement_Date__c"                                          
    "Endorsement_Effective_Date__c"                        
    "Endorsement_Expiry_Date__c"                     
    "Edorsement_Type__c"                      
    "Endorsement_Detail__c"                      
    "Selling_Channel__c"  .    

                                      .                                           
FOR EACH wdetail NO-LOCK WHERE 
    wdetail.EndorseNo <> "" .

    EXPORT DELIMITER "," 
        wdetail.XRefNo1             
        wdetail.Barcode                                                                
        wdetail.pol_title + wdetail.pol_fname + " " + wdetail.pol_lname
        wdetail.PolicyNo                                                               
        wdetail.EndorseNo
        wdetail.endorsedat
        wdetail.EffectiveDate 
        wdetail.ExpireDate 
        ""                     /* �����������ѡ��ѧ  */
        wdetail.EndorseReason  /* �����š����ѡ��ѧ  */
        ""                     /* ��ͧ�ҧ��â��      */
        .            
END.
OUTPUT CLOSE.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pro_reportpolicyMO C-Win 
PROCEDURE pro_reportpolicyMO :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_text AS CHAR.
DEF VAR pol72 AS CHAR FORMAT "x(12)" INIT "" .   
If  substr(fi_outloadmemo,length(fi_outloadmemo) - 3,4) <>  ".csv"  THEN 
    fi_outloadmemo  =  Trim(fi_outloadmemo) + ".csv"  .
 
OUTPUT TO VALUE(fi_outloadmemo).
EXPORT DELIMITER "," 
    "Application Form"
    "ProspectID__c"
    "PremiumBeforeDiscount__c"
    "PremiumAfterDiscount__c"
    "Main_Stamp_Premium__c"
    "Main_VAT_Premium__c"
    "Main_Total_Premium__c"
    "EffectiveDate__c"
    "ExpiryDate__c"
    "SI__c"
    "Adjusted_Net_Premium__c"
    "Adjusted_Stamp__c"
    "Adjusted_Vat__c"
    "Adjusted_Total_Premium__c"
    "Adjusted_Remark__c"
    "Adjusted_Effective_Date__c"
    "Adjusted_Expiry_Date__c"
    "Adjusted_SumInsure__c"
    "Selling_Channel__c"
    "Memo_Type__c".
FOR EACH wdetail NO-LOCK WHERE
    wdetail.EndorseNo = "" .      /* ੾�С������� */
    FIND LAST wdetail2 WHERE
        wdetail2.chassis = wdetail.chassis AND
        wdetail2.covcod  = wdetail.covcod  AND
        wdetail2.covtyp  = wdetail.covtyp  NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL wdetail2 THEN DO:
        ASSIGN nv_text = "".
        IF wdetail2.comdat_old <> wdetail2.comdat THEN nv_text = "����¹�ѹ������ͧ".
        IF      (DECI(wdetail2.ins_amt_old)   - deci(wdetail2.ins_amt))   > 0 THEN nv_text = nv_text + "/�����ع".
        ELSE IF (DECI(wdetail2.ins_amt_old)   - deci(wdetail2.ins_amt))   > 0 THEN nv_text = nv_text + "/Ŵ�ع".
        IF      (DECI(wdetail2.gross_prm_old) - deci(wdetail2.gross_prm)) > 0 THEN nv_text = nv_text + "/��������".
        ELSE IF (DECI(wdetail2.gross_prm_old) - deci(wdetail2.gross_prm)) > 0 THEN nv_text = nv_text + "/Ŵ����".


        EXPORT DELIMITER "," 
            wdetail.XRefNo1                           /*"Application Form"          */                
            wdetail.Barcode                           /*"ProspectID__c"             */                    
            replace(wdetail2.prem1_old,",","")            /*"PremiumBeforeDiscount__c"  */ 
            replace(wdetail2.gross_prm_old,",","")        /*"PremiumAfterDiscount__c"   */ 
            replace(wdetail2.stamp_old,",","")            /*"Main_Stamp_Premium__c"     */ 
            replace(wdetail2.vat_old,",","")              /*"Main_VAT_Premium__c"       */ 
            replace(wdetail2.premtotal_old,",","")        /*"Main_Total_Premium__c"     */ 
            wdetail2.comdat_old                           /*"EffectiveDate__c"          */ 
            wdetail2.expdat_old                           /*"ExpiryDate__c"             */
            replace(wdetail2.ins_amt_old,",","")          /*"SI__c"                     */
            replace(wdetail2.gross_prm,",","")        /*"Adjusted_Net_Premium__c"   */
            replace(wdetail2.stamp,",","")            /*"Adjusted_Stamp__c"         */
            replace(wdetail2.vat,",","")              /*"Adjusted_Vat__c"           */
            replace(wdetail2.premtotal,",","")        /*"Adjusted_Total_Premium__c" */
            wdetail2.remark                           /*"Adjusted_Remark__c"        */
            wdetail2.comdat                           /*"Adjusted_Effective_Date__c"*/
            wdetail2.expdat                           /*"Adjusted_Expiry_Date__c"   */
            replace(wdetail2.ins_amt,",","")          /*"Adjusted_SumInsure__c"     */
            wdetail2.Selling_Channel                  /*"Selling_Channel__c"        */
            nv_text . /*"Memo_Type__c".             */
        END.
    
END.
OUTPUT CLOSE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

