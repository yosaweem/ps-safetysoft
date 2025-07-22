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
/*          This .W file wAS created with the Progress UIB.             */
/*----------------------------------------------------------------------*/

/* Create an unnamed pool to store all the widgets created 
     by this procedure. This is a good default which ASsures
     that this procedure's triggers and internal procedures 
     will execute in this procedure's storage, and that proper
     cleanup will occur on deletion of the procedure. */

CREATE WIDGET-POOL.
/* ***************************  DefINITions  **************************     */
                                                                            
/* Parameters DefINITions ---                                               */
/* Local Variable DefINITions ---                                           */
/*Program ID   : wgwmtscb3.w                                                */
/*Program name : Match File Load and Update Data TLT                        */
/*create by    : Ranu i. A60-0488  date 16/10/2017 
                ����� match file ����Ѻ��Ŵ��� GW ��� Match Policy no on TLT */
/*              Match file Load , match policy no                           */
/*Modify BY : Kridtiya i. DATE.12/08/2022 A65-0174 ��Ѻ����ٻẺ����*/
/*DataBASe connect : GW_SAFE -LD SIC_BRAN, GW_STAT -LD BRSTAT,SICSYAC,SICUW */
/* Modify By : Tontawan S. A66-0006 16/05/2023 
             : ��Ǩ�ͺ���͹��ա���� Match File Load ���� Producer ���ç�Ѻ ��
             : ���� Column ����Ѻ��� Match File Load ����� Column ��ë��� 
               ����鹢����� ��ҫ�������
             : ���� Column ����Ѻ���  Match File Load ����Ѻ 
               Column ����ö¹�� ��ҡ����к� Package  ���� �� T110 ,P320  �繵�
             : Match File Load �����ط�� ��������ͧ����
             : Match File Load �ç��ö �������к� premium
             : �����Ţ���ͧ��Ǩ��Ҿö �ç���  ��� ��ͧ�纤��� Memo Text ����
             : ���������� �ç��ͧ Campaign ������繢��������ǡѺ �ͧ 
               Producer code �� Producer: B3MLSCB204  ������ Camp. B3MLSCB204
             : Match File Load  �͡����ҡ������§�����ŵ����� User ��ͧ���   */
/* Modify By : Tontawan S. A68-0059 27/03/2025
             : Add 35 Field for support EV                                   */        
/*---------------------------------------------------------------------------*/
DEF VAR gv_id  AS CHAR FORMAT "X(12)" NO-UNDO.      
DEF VAR n_user  AS CHAR FORMAT "X(12)" NO-UNDO.
DEF VAR nv_pwd AS CHAR FORMAT "x(15)" NO-UNDO. 
DEF  stream ns1.
DEFINE VAR  nv_daily       AS CHARACTER FORMAT "X(1024)"     INITIAL ""  NO-UNDO.
DEFINE VAR  nv_reccnt      AS  INT  INIT  0.
DEFINE VAR  nv_completecnt AS   INT   INIT  0.
DEFINE VAR  nv_enttim      AS  CHAR          INIT  "".
DEFINE VAR  nv_export      AS  date  INIT  ""  FORMAT "99/99/9999".
DEF stream  ns2.
DEFINE VAR nv_file1        AS CHARACTER FORMAT "X(100)"     INITIAL ""  NO-UNDO.
DEFINE VAR nv_file2        AS CHARACTER FORMAT "X(100)"     INITIAL ""  NO-UNDO.

{wgw/wgwmtscb3.i}
/*--------------------------����Ѻ�����š�������  -------------------------*/
/*-- ������� .i ���ͧ�ҡ��鹷����������Ѻ˹�ҹ�� -- Tontawan S. A68-0059 --
DEFINE NEW SHARED TEMP-TABLE wload NO-UNDO
    FIELD poltyp         AS  CHAR FORMAT "x(5)"   INIT ""                      /* ��������������*/                       
    FIELD policy         AS  CHAR FORMAT "x(13)"  INIT "" 
    FIELD prepol         AS  CHAR FORMAT "x(13)"  INIT ""                     
    field cedcode        AS  CHAR FORMAT "X(20)"  INIT ""                  /* ������ҧ�ԧ   */                           
    field inscode        AS  CHAR FORMAT "X(20)"  INIT ""                  /* �����١���    */                           
    FIELD campcode       AS  CHAR FORMAT "X(20)"  INIT ""                  /* ������໭    */                           
    FIELD campname       AS  CHAR FORMAT "X(35)"  INIT ""                  /* ������໭    */                           
    FIELD procode        AS  CHAR FORMAT "X(20)"  INIT ""                  /* ���ʼ�Ե�ѳ�� */                           
    FIELD proname        AS  CHAR FORMAT "X(35)"  INIT ""                  /* ���ͼ�Ե�ѳ�� */                           
    FIELD packname       AS  CHAR FORMAT "X(35)"  INIT ""                  /* ����ᾤ��   */                           
    FIELD packcode       AS  CHAR FORMAT "X(20)"  INIT ""                  /* ����ᾤ��   */                           
    FIELD instype        AS  CHAR FORMAT "X(1)"   INIT ""                  /* �����������һ�Сѹ */                      
    FIELD pol_title      AS  CHAR FORMAT "X(20)"  INIT ""                  /* �ӹ�˹�Ҫ��� �����һ�Сѹ */               
    FIELD pol_fname      AS  CHAR FORMAT "X(100)" INIT ""                  /* ���� �����һ�Сѹ         */               
    FIELD pol_title_eng  AS  CHAR FORMAT "X(10)"  INIT ""                  /* �ӹ�˹�Ҫ��� �����һ�Сѹ (Eng) */         
    FIELD pol_fname_eng  AS  CHAR FORMAT "X(100)" INIT ""                  /* ���� �����һ�Сѹ (Eng)*/                  
    FIELD icno           AS  CHAR FORMAT "X(13)"  INIT ""                  /* �Ţ�ѵü����һ�Сѹ */                     
    FIELD bdate          AS  CHAR FORMAT "X(15)"  INIT ""                  /* �ѹ�Դ�����һ�Сѹ */                     
    FIELD occup          AS  CHAR FORMAT "X(50)"  INIT ""                  /* �Ҫվ�����һ�Сѹ*/                        
    FIELD tel            AS  CHAR FORMAT "X(50)"  INIT ""                  /* �����ü����һ�Сѹ*/                     
    FIELD mail           AS  CHAR FORMAT "X(50)"  INIT ""                  /* ����������һ�Сѹ  */                     
    FIELD addrpol1       AS  CHAR FORMAT "X(45)"  INIT ""                  /* �������˹�ҵ��ҧ1*/                        
    FIELD addrpol2       AS  CHAR FORMAT "X(45)"  INIT ""                  /* �������˹�ҵ��ҧ2*/                        
    FIELD addrpol3       AS  CHAR FORMAT "X(45)"  INIT ""                  /* �������˹�ҵ��ҧ3*/                        
    FIELD addrpol4       AS  CHAR FORMAT "X(45)"  INIT ""                  /* �������˹�ҵ��ҧ4*/                        
    FIELD addrsend1      AS  CHAR FORMAT "X(45)"  INIT ""                  /* �������Ѵ�� 1  */                        
    FIELD addrsend2      AS  CHAR FORMAT "X(45)"  INIT ""                  /* �������Ѵ�� 2  */                        
    FIELD addrsend3      AS  CHAR FORMAT "X(45)"  INIT ""                  /* �������Ѵ�� 3  */                        
    FIELD addrsend4      AS  CHAR FORMAT "X(45)"  INIT ""                  /* �������Ѵ�� 4  */                        
    FIELD paytype        AS  CHAR FORMAT "X(2)"   INIT ""                  /* �������������Թ*/                        
    FIELD paytitle       AS  CHAR FORMAT "X(20)"  INIT ""                  /* �ӹ�˹�Ҫ��� �������Թ*/                 
    FIELD payname        AS  CHAR FORMAT "X(100)" INIT ""                  /* ���� �������Թ*/                         
    FIELD icpay          AS  CHAR FORMAT "X(50)"  INIT ""                  /* �Ţ��Шӵ�Ǽ����������*/                   
    FIELD addrpay1       AS  CHAR FORMAT "X(40)"  INIT ""                  /* ��������͡�����1*/                       
    FIELD addrpay2       AS  CHAR FORMAT "X(40)"  INIT ""                  /* ��������͡�����2*/                       
    FIELD addrpay3       AS  CHAR FORMAT "X(40)"  INIT ""                  /* ��������͡�����3*/                       
    FIELD addrpay4       AS  CHAR FORMAT "X(40)"  INIT ""                  /* ��������͡�����4*/                       
    FIELD branch         AS  CHAR FORMAT "X(20)"  INIT ""                  /* �Ң�*/                                     
    FIELD ben_name       AS  CHAR FORMAT "X(100)" INIT ""                  /* ����Ѻ�Ż���ª��  */                       
    FIELD pmentcode      AS  CHAR FORMAT "X(10)"  INIT ""                  /* ���ʻ�������è��� */                       
    FIELD pmenttyp       AS  CHAR FORMAT "X(75)"  INIT ""                  /* ��������è��� */                           
    FIELD pmentcode1     AS  CHAR FORMAT "X(10)"  INIT ""                  /* ���ʪ�ͧ�ҧ��è���*/                       
    FIELD pmentcode2     AS  CHAR FORMAT "X(75)"  INIT ""                  /* ��ͧ�ҧ��è���  */                         
    FIELD pmentbank      AS  CHAR FORMAT "X(50)"  INIT ""                  /* ��Ҥ�÷�����*/                            
    FIELD pmentdate      AS  CHAR FORMAT "X(15)"  INIT ""                  /* �ѹ������   */                            
    FIELD pmentsts       AS  CHAR FORMAT "X(15)"  INIT ""                  /* ʶҹС�è��� */                            
    field brand          AS  CHAR FORMAT "x(35)"  INIT ""                  /* ������  */                                 
    field Model          AS  CHAR FORMAT "x(50)"  INIT ""                  /* ���    */                                 
    field body           AS  CHAR FORMAT "x(20)"  INIT ""                  /* Ẻ��Ƕѧ*/                                
    field licence        AS  CHAR FORMAT "x(11)"  INIT ""                  /* ����¹ */                                 
    field province       AS  CHAR FORMAT "x(25)"  INIT ""                  /* �ѧ��Ѵ����¹ */                          
    field chASsis        AS  CHAR FORMAT "x(20)"  INIT ""                  /* �Ţ��Ƕѧ*/                                
    field engine         AS  CHAR FORMAT "x(20)"  INIT ""                  /* �Ţ����ͧ */                              
    field yrmanu         AS  CHAR FORMAT "x(5)"   INIT ""                  /* ��ö    */                                 
    field seatenew       AS  CHAR FORMAT "x(5)"   INIT ""                  /* ����� */                                 
    FIELD power          AS  CHAR FORMAT "x(15)"  INIT ""                  /* �ի�    */                                 
    FIELD weight         AS  CHAR FORMAT "X(15)"  INIT ""                  /* ���˹ѡ */                                 
    FIELD clASs          AS  CHAR FORMAT "x(5)"   INIT ""                  /* ����ö  */  
    FIELD tclASs         AS  CHAR FORMAT "x(5)"   INIT ""                  /* ����ö¹��  */  //Ton
    FIELD garage         AS  CHAR FORMAT "x(35)"  INIT ""                  /* ��ë��� */                                 
    FIELD colorcode      AS  CHAR FORMAT "x(35)"  INIT ""                  /* ��  */                                     
    FIELD covcod         AS  CHAR FORMAT "x(50)"  INIT ""                  /* ��������û�Сѹ */                         
    FIELD covtyp         AS  CHAR FORMAT "x(30)"  INIT ""                  /* ���ʡ�û�Сѹ*/                            
    FIELD comdat         AS  CHAR FORMAT "x(15)"  INIT ""                  /* �ѹ��������ͧ  */                         
    FIELD expdat         AS  CHAR FORMAT "x(15)"  INIT ""                  /* �ѹ����������*/                            
    FIELD ins_amt        AS  CHAR FORMAT "x(20)"  INIT ""                  /* �ع��Сѹ*/                                
    FIELD prem1          AS  CHAR FORMAT "x(20)"  INIT ""                  /* �����ط�ԡ�͹�ѡ��ǹŴ*/                  
    FIELD gross_prm      AS  CHAR FORMAT "x(20)"  INIT ""                  /* �����ط����ѧ�ѡ��ǹŴ*/                  
    FIELD stamp          AS  CHAR FORMAT "x(10)"  INIT ""                  /* �����  */                                 
    FIELD vat            AS  CHAR FORMAT "X(10)"  INIT ""                  /* ����    */                                 
    FIELD premtotal      AS  CHAR FORMAT "x(20)"  INIT ""                  /* �������*/                                 
    field deduct         AS  CHAR FORMAT "x(10)"  INIT ""                  /* Deduct  */                                 
    field fleetper       AS  CHAR FORMAT "x(10)"  INIT ""                  /* fleet   */                                 
    field ncbper         AS  CHAR FORMAT "x(10)"  INIT ""                  /* ncb     */                                 
    field othper         AS  CHAR FORMAT "X(10)"  INIT ""                  /* other   */                                 
    field cctvper        AS  CHAR FORMAT "X(10)"  INIT ""                  /* cctv    */                                 
    FIELD driver         AS  CHAR FORMAT "X(2)"   INIT ""                  /* �кؼ��Ѻ���    */                        
    FIELD drivename1     AS  CHAR FORMAT "X(70)"  INIT ""                  /* ���ͼ��Ѻ���1   */                        
    FIELD driveno1       AS  CHAR FORMAT "X(15)"  INIT ""                  /* �Ţ�ѵü��Ѻ���1*/                        
    FIELD occupdriv1     AS  CHAR FORMAT "X(50)"  INIT ""                  /* �Ҫվ���Ѻ���1  */                        
    FIELD sexdriv1       AS  CHAR FORMAT "X(10)"  INIT ""                  /* �ȼ��Ѻ���1    */                        
    FIELD bdatedriv1     AS  CHAR FORMAT "X(15)"  INIT ""                  /* �ѹ�Դ���Ѻ���1*/                        
    FIELD drivename2     AS  CHAR FORMAT "x(70)"  INIT ""                  /* ���ͼ��Ѻ���2   */                        
    FIELD driveno2       AS  CHAR FORMAT "x(15)"  INIT ""                  /* �Ţ�ѵü��Ѻ���2*/                        
    FIELD occupdriv2     AS  CHAR FORMAT "x(50)"  INIT ""                  /* �Ҫվ���Ѻ���2  */                        
    FIELD sexdriv2       AS  CHAR FORMAT "x(10)"  INIT ""                  /* �ȼ��Ѻ���2    */                        
    FIELD bdatedriv2     AS  CHAR FORMAT "x(15)"  INIT ""                 /* �ѹ�Դ���Ѻ���2*/
    FIELD producer       AS  CHAR FORMAT "x(25)"  INIT ""   /*Kridtiya i. A64-0295 DATE. 25/07/2021 */
    FIELD agent          AS  CHAR FORMAT "x(25)"  INIT ""   /*Kridtiya i. A64-0295 DATE. 25/07/2021 */
    /*-- Add By Tontawan S. A66-0006 17/05/2023 --*/
    FIELD sellcode       AS  CHAR FORMAT "X(25)"  INIT ""  
    FIELD sellname       AS  CHAR FORMAT "X(100)" INIT ""  
    FIELD selling_ch     AS  CHAR FORMAT "X(100)" INIT ""  
    FIELD branch_c       AS  CHAR FORMAT "X(25)"  INIT ""  
    FIELD campaign       AS  CHAR FORMAT "X(25)"  INIT ""
    FIELD person         AS  CHAR FORMAT "X(20)"  INIT ""
    FIELD peracc         AS  CHAR FORMAT "X(20)"  INIT ""
    FIELD perpd          AS  CHAR FORMAT "X(20)"  INIT ""
    FIELD si411          AS  CHAR FORMAT "X(20)"  INIT ""
    FIELD si412          AS  CHAR FORMAT "X(20)"  INIT ""
    FIELD si43           AS  CHAR FORMAT "X(20)"  INIT "".
    /*-- End By Tontawan S. A66-0006 17/05/2023 --*/*/

DEFINE NEW SHARED TEMP-TABLE wtxt NO-UNDO
    FIELD poltyp          AS  CHAR FORMAT "x(5)" INIT ""
    FIELD policy          AS  CHAR FORMAT "x(13)" INIT ""
    field cedcode         AS  CHAR FORMAT "X(20)"  INIT ""
    field inscode         AS  CHAR FORMAT "X(20)"  INIT ""
    field acc1            AS  CHAR FORMAT "X(100)" INIT ""
    field accdetail1      AS  CHAR FORMAT "X(100)" INIT ""
    field accprice1       AS  CHAR FORMAT "X(20)"  INIT ""
    field acc2            AS  CHAR FORMAT "X(100)" INIT ""
    field accdetail2      AS  CHAR FORMAT "X(100)" INIT ""
    field accprice2       AS  CHAR FORMAT "X(20)"  INIT ""
    field acc3            AS  CHAR FORMAT "X(100)" INIT ""
    field accdetail3      AS  CHAR FORMAT "X(100)" INIT ""
    field accprice3       AS  CHAR FORMAT "X(20)"  INIT ""
    field acc4            AS  CHAR FORMAT "X(100)" INIT ""
    field accdetail4      AS  CHAR FORMAT "X(100)" INIT ""
    field accprice4       AS  CHAR FORMAT "X(20)"  INIT ""
    field acc5            AS  CHAR FORMAT "X(100)" INIT ""
    field accdetail5      AS  CHAR FORMAT "X(100)" INIT ""
    field accprice5       AS  CHAR FORMAT "X(20)"  INIT ""
    field inspdate        AS  CHAR FORMAT "X(15)"  INIT ""
    field inspdate_app    AS  CHAR FORMAT "X(50)"  INIT ""
    field inspsts         AS  CHAR FORMAT "X(50)"  INIT ""
    field inspdetail      AS  CHAR FORMAT "X(250)" INIT ""
    field not_date        AS  CHAR FORMAT "X(15)"  INIT ""
    field paydate         AS  CHAR FORMAT "X(15)"  INIT ""
    field paysts          AS  CHAR FORMAT "X(15)"  INIT ""
    field licenBroker     AS  CHAR FORMAT "X(20)"  INIT ""
    field brokname        AS  CHAR FORMAT "X(100)" INIT ""
    field brokcode        AS  CHAR FORMAT "X(15)"  INIT ""
    field lang            AS  CHAR FORMAT "X(50)"  INIT ""
    field deli            AS  CHAR FORMAT "X(100)" INIT ""
    field delidetail      AS  CHAR FORMAT "X(100)" INIT ""
    field gift            AS  CHAR FORMAT "X(100)" INIT ""
    field remark          AS  CHAR FORMAT "X(250)" INIT ""
    FIELD insno           AS  CHAR FORMAT "x(25)" INIT ""
    FIELD resultins       AS  CHAR FORMAT "x(250)" INIT ""
    field damage1         AS  CHAR FORMAT "x(250)" INIT ""
    field damage2         AS  CHAR FORMAT "x(250)" INIT ""
    field damage3         AS  CHAR FORMAT "x(250)" INIT ""
    field dataoth         AS  CHAR FORMAT "x(250)" INIT ""
    FIELD ben_2title      AS CHAR FORMAT "X(10)"  INIT ""  /*Kridtiya i. A64-0295 DATE. 25/07/2021 */ 
    FIELD ben_2name       AS CHAR FORMAT "X(50)"  INIT ""  /*Kridtiya i. A64-0295 DATE. 25/07/2021 */
    field ben_2lname      AS CHAR FORMAT "X(50)"  INIT ""  /*Kridtiya i. A64-0295 DATE. 25/07/2021 */
    field ben_3title      AS CHAR FORMAT "X(10)"  INIT ""  /*Kridtiya i. A64-0295 DATE. 25/07/2021 */
    field ben_3name       AS CHAR FORMAT "X(50)"  INIT ""  /*Kridtiya i. A64-0295 DATE. 25/07/2021 */
    field ben_3lname      AS CHAR FORMAT "X(50)"  INIT ""  /*Kridtiya i. A64-0295 DATE. 25/07/2021 */
    field Agent_Code      AS CHAR FORMAT "x(250)" INIT ""  /*Kridtiya i. A64-0295 DATE. 25/07/2021 */
    field Agent_NameTH    AS CHAR FORMAT "x(250)" INIT ""  /*Kridtiya i. A64-0295 DATE. 25/07/2021 */
    field Agent_NameEng   AS CHAR FORMAT "x(250)" INIT ""  /*Kridtiya i. A64-0295 DATE. 25/07/2021 */
    field Selling_Channel AS CHAR FORMAT "x(250)" INIT ""  /*Kridtiya i. A64-0295 DATE. 25/07/2021 */
    FIELD ispno          AS  CHAR FORMAT "X(20)"  INIT "". /*-- Add By Tontawan S. A66-0006 --*/ 
   
DEF VAR nv_cnt            AS int INIT 0.
DEF VAR nv_row            AS int INIT 0.
DEF VAR nv_oldpol         AS CHAR FORMAT "x(15)" INIT "".
DEF VAR nv_output         AS CHAR FORMAT "x(60)" INIT "".
DEF VAR nv_policy         AS CHAR FORMAT "X(13)" INIT "" .
DEF VAR nv_matchpol       AS INTE INIT 1.

DEFINE VAR nv_appen     AS CHAR FORMAT "X(20)" INIT "" .  /*-- Add By Tontawan S. A66-0006 --*/

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS fi_loadname fi_outload bu_file-3 bu_ok ~
bu_exit-2 RECT-381 RECT-382 RECT-383 RECT-384 
&Scoped-Define DISPLAYED-OBJECTS fi_loadname fi_outload 

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
     SIZE 5 BY 1.24.

DEFINE BUTTON bu_ok 
     LABEL "OK" 
     SIZE 7.5 BY 1.05
     FONT 6.

DEFINE VARIABLE fi_loadname AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 60 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_outload AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 60 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE RECTANGLE RECT-381
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 90 BY 7.19
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-382
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 10 BY 2
     BGCOLOR 4 .

DEFINE RECTANGLE RECT-383
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 10 BY 2
     BGCOLOR 2 .

DEFINE RECTANGLE RECT-384
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 88 BY 1.43
     BGCOLOR 18 FGCOLOR 2 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     fi_loadname AT ROW 5.05 COL 16.5 COLON-ALIGNED NO-LABEL
     fi_outload AT ROW 6.19 COL 16.5 COLON-ALIGNED NO-LABEL
     bu_file-3 AT ROW 5.05 COL 79.67
     bu_ok AT ROW 8.05 COL 59.5
     bu_exit-2 AT ROW 8.05 COL 69.67
     "OUTPUT FILE :" VIEW-AS TEXT
          SIZE 15 BY 1 AT ROW 6.14 COL 2.83
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "Date:05/09/2022" VIEW-AS TEXT
          SIZE 17 BY 1 AT ROW 3.57 COL 72.33 WIDGET-ID 4
          BGCOLOR 18 FGCOLOR 3 FONT 6
     "IMPORT FILE :" VIEW-AS TEXT
          SIZE 15 BY 1 AT ROW 5.05 COL 3.17
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " MATCH POLICY ON (SCBPT)" VIEW-AS TEXT
          SIZE 90 BY 2 AT ROW 1 COL 1.5
          BGCOLOR 30 FGCOLOR 7 FONT 2
     "** �����˵� : Match file policy no �������Ŵ" VIEW-AS TEXT
          SIZE 42 BY 1 AT ROW 7.43 COL 3
          BGCOLOR 19 FGCOLOR 6 FONT 5
     "Match Policy No and Update SCBPT" VIEW-AS TEXT
          SIZE 42 BY 1 AT ROW 3.57 COL 3.17 WIDGET-ID 2
          BGCOLOR 18 FGCOLOR 1 FONT 6
     RECT-381 AT ROW 3.1 COL 1.5
     RECT-382 AT ROW 7.62 COL 68.33
     RECT-383 AT ROW 7.62 COL 58.33
     RECT-384 AT ROW 3.33 COL 2
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 91.17 BY 9.48
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
         TITLE              = "Match text  File Confirm Recepit (SCB-T)"
         HEIGHT             = 9.48
         WIDTH              = 90.83
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
ON END-ERROR OF C-Win /* Match text  File Confirm Recepit (SCB-T) */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Match text  File Confirm Recepit (SCB-T) */
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
          no_add = STRING(MONTH(TODAY),"99")    + 
                   STRING(DAY(TODAY),"99")      + 
                   SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) + 
                   SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2) .
        fi_loadname  = cvData.
        nv_output = "".
/*
        IF ra_matchpol = 1 THEN ASSIGN /*fi_outload   = SUBSTR(fi_loadname,1,R-INDEX(fi_loadname,".") - 1 ) + "_receipt" + NO_add*/
                                       fi_outload  = SUBSTR(fi_loadname,1,R-INDEX(fi_loadname,".") - 1 ) + "_Load".
                                       /*fi_outload3  = SUBSTR(fi_loadname,1,R-INDEX(fi_loadname,".") - 1 ) + "_Error" + NO_add.*/
        ELSE IF ra_matchpol = 2 THEN ASSIGN fi_outload   = SUBSTR(fi_loadname,1,R-INDEX(fi_loadname,".") - 1 ) + "_policy".
       */
        ASSIGN fi_outload   = SUBSTR(fi_loadname,1,R-INDEX(fi_loadname,".") - 1 ) + "_policy".

        
        /* ELSE IF ra_matchpol = 3 THEN ASSIGN fi_outload   = SUBSTR(fi_loadname,1,R-INDEX(fi_loadname,".") - 1 ) + "_NoConfirm" + NO_add.*/
        DISP fi_loadname fi_outload   WITH FRAME fr_main .     
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_ok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_ok C-Win
ON CHOOSE OF bu_ok IN FRAME fr_main /* OK */
DO:
    ASSIGN 
        nv_reccnt  =  0.
    /*For each  wdetail:
        DELETE  wdetail.
    END.
    For each  wdetail2:
        DELETE  wdetail2.
    END.*/
    FOR EACH wload:
        DELETE wload.
    END.

    FOR EACH wtxt:
        DELETE wtxt.
    END.

    IF fi_outload = "" THEN DO:
        MESSAGE "File name output not Empty..!!!"    SKIP
                "Insert file name Output file...!!!" VIEW-AS ALERT-BOX.
        APPLY "Entry" TO fi_outload.
        RETURN NO-APPLY.
    END.

    /* IF ra_matchpol = 1 THEN RUN proc_impmatpol1.        /* file load */    */
    /* ELSE IF ra_matchpol = 2  THEN RUN proc_impmatpol2.  /* match pol no.*/ */

    RUN proc_impmatpol2.  /* match pol no.*/
   
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
     /* ra_matchpol       = 1*/
      nv_matchpol        = 2
      /*ra_matpoltyp      = 1*/
      gv_prgid          = "WGWMTSCB3".
      
  gv_prog  = "Match File Policy Send To SCBPT".
  RUN  WUT\WUTHEAD ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).
  /*RUN proc_createpack.*/
/*   DISP ra_matchpol    WITH FRAM fr_main. */
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
  DISPLAY fi_loadname fi_outload 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE fi_loadname fi_outload bu_file-3 bu_ok bu_exit-2 RECT-381 RECT-382 
         RECT-383 RECT-384 
      WITH FRAME fr_main IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW C-Win.
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
FIND FIRST wload WHERE wload.covtyp   = TRIM(n_covtyp)   AND
                       wload.cedcode  = TRIM(n_cedcode)  AND
                       wload.inscode  = TRIM(n_inscode)  NO-LOCK NO-ERROR.
    IF NOT AVAIL wload THEN DO:
        CREATE wload.
        ASSIGN                                     
            wload.poltyp         = TRIM(n_poltyp)                                          
            wload.cedcode        = TRIM(n_cedcode)                                          
            wload.inscode        = TRIM(n_inscode)                                          
            wload.campcode       = TRIM(n_campcode)                                          
            wload.campname       = TRIM(n_campname)                                          
            wload.procode        = TRIM(n_procode)                                          
            wload.proname        = TRIM(n_proname)                                          
            wload.packname       = TRIM(n_packname)                                          
            wload.packcode       = TRIM(n_packcode) 
            wload.prepol         = TRIM(n_prepol)
            wload.instype        = TRIM(n_instype)                                          
            wload.pol_title      = TRIM(n_pol_title)                                          
            wload.pol_fname      = TRIM(n_pol_fname)                                          
            wload.pol_title_eng  = TRIM(n_pol_title_eng)                                          
            wload.pol_fname_eng  = TRIM(n_pol_fname_eng)                                          
            wload.icno           = TRIM(n_icno)                   
            wload.bdate          = TRIM(n_bdate)                   
            wload.occup          = TRIM(n_occup)                   
            wload.tel            = TRIM(n_tel)                   
            wload.mail           = TRIM(n_mail)                   
            wload.addrpol1       = TRIM(n_addr1_70)                   
            wload.addrpol2       = TRIM(n_addr2_70)                   
            wload.addrpol3       = TRIM(n_addr3_70)                   
            wload.addrpol4       = TRIM(n_addr4_70)                   
            wload.addrsend1      = TRIM(n_addr1_72)                   
            wload.addrsend2      = TRIM(n_addr2_72)                   
            wload.addrsend3      = TRIM(n_addr3_72)                   
            wload.addrsend4      = TRIM(n_addr4_72)                   
            wload.paytype        = TRIM(n_paytype)                   
            wload.paytitle       = TRIM(n_paytitle)                   
            wload.payname        = TRIM(n_payname)
            wload.icpay          = TRIM(n_payicno)  
            wload.addrpay1       = TRIM(n_payaddr1)  
            wload.addrpay2       = TRIM(n_payaddr2)  
            wload.addrpay3       = TRIM(n_payaddr3)  
            wload.addrpay4       = TRIM(n_payaddr4)  
            wload.branch         = TRIM(n_branch)                   
            wload.ben_name       = TRIM(n_ben_name)                   
            wload.pmentcode      = TRIM(n_pmentcode)                                          
            wload.pmenttyp       = TRIM(n_pmenttyp)                                          
            wload.pmentcode1     = TRIM(n_pmentcode1)                                          
            wload.pmentcode2     = TRIM(n_pmentcode2)                                          
            wload.pmentbank      = TRIM(n_pmentbank)                                          
            wload.pmentdate      = TRIM(n_pmentdate)                                          
            wload.pmentsts       = TRIM(n_pmentsts)                                          
            wload.brand          = TRIM(n_brand)                                          
            wload.Model          = TRIM(n_Model)                                          
            wload.body           = TRIM(n_body)                                          
            wload.licence        = TRIM(n_licence)                                          
            wload.province       = TRIM(n_province)                                          
            wload.chassis        = TRIM(n_chassis)                                          
            wload.engine         = TRIM(n_engine)                                          
            wload.yrmanu         = TRIM(n_yrmanu)                                          
            wload.seatenew       = TRIM(n_seatenew)                                          
            wload.power          = TRIM(n_power)                                          
            wload.weight         = TRIM(n_weight)                                          
            wload.class          = TRIM(n_class)                                          
            wload.garage         = TRIM(n_garage)                                          
            wload.colorcode      = TRIM(n_colorcode)                                          
            wload.covcod         = TRIM(n_covcod)                                          
            wload.covtyp         = TRIM(n_covtyp)                                          
            wload.comdat         = TRIM(n_comdat)                                          
            wload.expdat         = TRIM(n_expdat)                                          
            wload.ins_amt        = TRIM(n_ins_amt)                                          
            wload.prem1          = TRIM(n_prem1)                                          
            wload.gross_prm      = TRIM(n_gross_prm)                                          
            wload.stamp          = TRIM(n_stamp)                                          
            wload.vat            = TRIM(n_vat)                                          
            wload.premtotal      = TRIM(n_premtotal)                                          
            wload.deduct         = TRIM(n_deduct)                                          
            wload.fleetper       = TRIM(n_fleetper)                                          
            wload.ncbper         = TRIM(n_ncbper)    
            wload.othper         = TRIM(n_othper)                                     
            wload.cctvper        = TRIM(n_cctvper)  
            wload.driver         = TRIM(n_driver)                                          
            wload.drivename1     = TRIM(n_drivename1)                                          
            wload.driveno1       = TRIM(n_driveno1)                                          
            wload.occupdriv1     = TRIM(n_occupdriv1)                                          
            wload.sexdriv1       = TRIM(n_sexdriv1)                                          
            wload.bdatedriv1     = TRIM(n_bdatedriv1)                                          
            wload.drivename2     = TRIM(n_drivename2)                                          
            wload.driveno2       = TRIM(n_driveno2)                                          
            wload.occupdriv2     = TRIM(n_occupdriv2)                                          
            wload.sexdriv2       = TRIM(n_sexdriv2)                                          
            wload.bdatedriv2     = TRIM(n_bdatedriv2)     
            wload.sellcode       = TRIM(n_sellcode)               //Add By Tontawan S. A66-0006 17/05/2023
            wload.sellname       = TRIM(n_sellname)               //.
            wload.selling_ch     = TRIM(n_selling_ch)             //.
            wload.branch_c       = TRIM(n_branch_c)               //.
            wload.campaign       = TRIM(n_campaign)               //.
            wload.person         = TRIM(n_person)                 //.
            wload.peracc         = TRIM(n_peracc)                 //.
            wload.perpd          = TRIM(n_perpd)                  //.
            wload.si411          = TRIM(n_si411)                  //.
            wload.si412          = TRIM(n_si412)                  //.
            wload.si43           = TRIM(n_si43)                   //End By Tontawan S. A66-0006 17/05/2023 --*/
            wload.drv3_salutation_M = TRIM(n_drv3_salutation_M)   //Add Tontawan S. A68-0059 27/03/2025
            wload.drv3_fname        = TRIM(n_drv3_fname)          //.
            wload.drv3_lname        = TRIM(n_drv3_lname)          //.
            wload.drv3_nid          = TRIM(n_drv3_nid)            //.
            wload.drv3_occupation   = TRIM(n_drv3_occupation)     //.
            wload.drv3_gender       = TRIM(n_drv3_gender)         //. 
            wload.drv3_birthdate    = IF TRIM(n_drv3_birthdate) <> "" THEN STRING(DATE(n_drv3_birthdate),"99/99/9999") ELSE ""
            wload.drv4_salutation_M = TRIM(n_drv4_salutation_M)   //.
            wload.drv4_fname        = TRIM(n_drv4_fname)          //.
            wload.drv4_lname        = TRIM(n_drv4_lname)          //.
            wload.drv4_nid          = TRIM(n_drv4_nid)            //.
            wload.drv4_occupation   = TRIM(n_drv4_occupation)     //.
            wload.drv4_gender       = TRIM(n_drv4_gender)         //.
            wload.drv4_birthdate    = IF TRIM(n_drv4_birthdate) <> "" THEN STRING(DATE(n_drv4_birthdate),"99/99/9999") ELSE ""
            wload.drv5_salutation_M = TRIM(n_drv5_salutation_M)   //.
            wload.drv5_fname        = TRIM(n_drv5_fname)          //.    
            wload.drv5_lname        = TRIM(n_drv5_lname)          //.    
            wload.drv5_nid          = TRIM(n_drv5_nid)            //.      
            wload.drv5_occupation   = TRIM(n_drv5_occupation)     //.
            wload.drv5_gender       = TRIM(n_drv5_gender)         //.
            wload.drv5_birthdate    = IF TRIM(n_drv5_birthdate) <> "" THEN STRING(DATE(n_drv5_birthdate),"99/99/9999") ELSE ""
            wload.drv1_dlicense     = TRIM(n_drv1_dlicense)       //.
            wload.drv2_dlicense     = TRIM(n_drv2_dlicense)       //.
            wload.drv3_dlicense     = TRIM(n_drv3_dlicense)       //.
            wload.drv4_dlicense     = TRIM(n_drv4_dlicense)       //.
            wload.drv5_dlicense     = TRIM(n_drv5_dlicense)       //.
            wload.baty_snumber      = TRIM(n_baty_snumber)        //.
            wload.batydate          = TRIM(n_batydate)            //.
            wload.baty_rsi          = TRIM(n_baty_rsi)            //.
            wload.baty_npremium     = TRIM(n_baty_npremium)       //.
            wload.baty_gpremium     = TRIM(n_baty_gpremium)       //.
            wload.wcharge_snumber   = TRIM(n_wcharge_snumber)     //.
            wload.wcharge_si        = TRIM(n_wcharge_si)          //.
            wload.wcharge_npremium  = TRIM(n_wcharge_npremium)    //.
            wload.wcharge_gpremium  = TRIM(n_wcharge_gpremium).   //End Tontawan S. A68-0059 27/03/2025

        CREATE wtxt.                                                         
        ASSIGN                                                               
            wtxt.poltyp        =  TRIM(n_poltyp )                                       
            wtxt.cedcode       =  TRIM(n_cedcode)                                       
            wtxt.inscode       =  TRIM(n_inscode)                                       
            wtxt.acc1          =  TRIM(n_acc1)                                                                                 
            wtxt.accdetail1    =  TRIM(n_accdetail1)                                                                                 
            wtxt.accprice1     =  TRIM(n_accprice1)                                                                                 
            wtxt.acc2          =  TRIM(n_acc2)                                                              
            wtxt.accdetail2    =  TRIM(n_accdetail2)                                                                                 
            wtxt.accprice2     =  TRIM(n_accprice2)                                                                                 
            wtxt.acc3          =  TRIM(n_acc3)                                                              
            wtxt.accdetail3    =  TRIM(n_accdetail3)                                                                                 
            wtxt.accprice3     =  TRIM(n_accprice3)                                                                                 
            wtxt.acc4          =  TRIM(n_acc4)                                                              
            wtxt.accdetail4    =  TRIM(n_accdetail4)                                                                                 
            wtxt.accprice4     =  TRIM(n_accprice4)                                                                                 
            wtxt.acc5          =  TRIM(n_acc5)                                                                
            wtxt.accdetail5    =  TRIM(n_accdetail5)                                                                                 
            wtxt.accprice5     =  TRIM(n_accprice5)                                                                                 
            wtxt.inspdate      =  TRIM(n_inspdate)                                                                               
            wtxt.inspdate_app  =  TRIM(n_inspdate_app)                                                                              
            wtxt.inspsts       =  TRIM(n_inspsts)                                                         
            wtxt.inspdetail    =  TRIM(n_inspdetail)                                                                                 
            wtxt.not_date      =  TRIM(n_not_date)                                                                                 
            wtxt.paydate       =  TRIM(n_paydate)                                                         
            wtxt.paysts        =  TRIM(n_paysts)                                                         
            wtxt.licenBroker   =  TRIM(n_licenBroker)                                               
            wtxt.brokname      =  TRIM(n_brokname)                                       
            wtxt.brokcode      =  TRIM(n_brokcode)                                       
            wtxt.lang          =  TRIM(n_lang)                                       
            wtxt.deli          =  TRIM(n_deli)                                       
            wtxt.delidetail    =  TRIM(n_delidetail)    
            wtxt.gift          =  TRIM(n_gift)    
            wtxt.remark        =  TRIM(n_remark)   
            wtxt.insno         =  TRIM(n_insno)   
            wtxt.resultins     =  TRIM(n_resultins)
            wtxt.damage1       =  TRIM(n_damage1)   
            wtxt.damage2       =  TRIM(n_damage2)   
            wtxt.damage3       =  TRIM(n_damage3)   
            wtxt.dataoth       =  TRIM(n_dataoth)
            wtxt.ispno         =  TRIM(n_ispno). /*-- Add By Tontawan S. A66-0006 --*/
    END.                                 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chassis C-Win 
PROCEDURE proc_chassis :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VAR nv_chanew       AS CHAR.
DEFINE VAR nv_len          AS INTE INIT 0.
DEFINE VAR nv_uwm301trareg AS CHAR INIT "" FORMAT "x(30)".

ASSIGN nv_uwm301trareg = trim(wload.chassis) .     
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
    ASSIGN wload.chassis =   trim(nv_uwm301trareg).     

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chkaddr C-Win 
PROCEDURE proc_chkaddr :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO:
DEF VAR n AS CHAR INIT "".
    /*--- ������˹�ҵ��ҧ----*/
    IF n_addr2_70   <> ""  THEN DO: 
        IF INDEX(n_addr2_70,"�Ҥ��")     <> 0    THEN ASSIGN n_addr2_70 = trim(n_addr2_70). 
        ELSE IF INDEX(n_addr2_70,"�֡")  <> 0    THEN ASSIGN n_addr2_70 = trim(n_addr2_70).
        ELSE IF INDEX(n_addr2_70,"��ҹ") <> 0    THEN ASSIGN n_addr2_70 = trim(n_addr2_70).
        ELSE IF index(n_addr2_70,"���")  <> 0    THEN ASSIGN n_addr2_70 = trim(n_addr2_70).
        ELSE IF index(n_addr2_70,"˨�")  <> 0    THEN ASSIGN n_addr2_70 = trim(n_addr2_70).
        ELSE IF index(n_addr2_70,"����ѷ")  <> 0 THEN ASSIGN n_addr2_70 = trim(n_addr2_70).
        ELSE IF index(n_addr2_70,"��ҧ")    <> 0 THEN ASSIGN n_addr2_70 = trim(n_addr2_70).
        ELSE IF index(n_addr2_70,"��ŹԸ�") <> 0 THEN ASSIGN n_addr2_70 = trim(n_addr2_70).
        ELSE IF index(n_addr2_70,"���")    <> 0 THEN ASSIGN n_addr2_70 = trim(n_addr2_70).
        ELSE IF index(n_addr2_70,"��ͧ")    <> 0 THEN ASSIGN n_addr2_70 = trim(n_addr2_70).
        ELSE ASSIGN n_addr2_70 = "�����ҹ" + trim(n_addr2_70).
    END.
    IF n_addr3_70  <> ""  THEN DO: 
        IF INDEX(n_addr3_70,"����")      <> 0      THEN n_addr3_70 = REPLACE(n_addr3_70,"����","�.").
        ELSE IF INDEX(n_addr3_70,"�.")   <> 0      THEN n_addr3_70 = trim(n_addr3_70).
        ELSE IF INDEX(n_addr3_70,"��ҹ") <> 0      THEN n_addr3_70 = trim(n_addr3_70). 
        ELSE IF INDEX(n_addr3_70,"�����ҹ") <> 0  THEN n_addr3_70 = trim(n_addr3_70).
        ELSE IF INDEX(n_addr3_70,"���")  <> 0      THEN n_addr3_70 = trim(n_addr3_70).
        ELSE DO:
            ASSIGN  n = ""  
                n = SUBSTR(TRIM(n_addr3_70),1,1).
                IF INDEX("0123456789",n) <> 0 THEN n_addr3_70 = "�." + trim(n_addr3_70).
                ELSE n_addr3_70 = trim(n_addr3_70).
        END.
    END.
    IF n_addr4_70 <> ""  THEN DO:
        IF      INDEX(n_addr4_70,"�.")  <> 0 THEN n_addr4_70 = trim(n_addr4_70) .
        ELSE IF INDEX(n_addr4_70,"���") <> 0 THEN n_addr4_70 = REPLACE(n_addr4_70,"���","�.").
        ELSE n_addr4_70 = "�." + trim(n_addr4_70) .
    END.
    IF n_addr5_70 <> ""  THEN DO: 
        IF INDEX(n_addr5_70,"�.")       <> 0 THEN n_addr5_70 = trim(n_addr5_70).
        ELSE IF INDEX(n_addr5_70,"���") <> 0 THEN n_addr5_70 = REPLACE(n_addr5_70,"���","�.").
        ELSE n_addr5_70 = "�." + trim(n_addr5_70) .
    END.    
    IF n_nprovin70 <> ""  THEN DO:
        IF (index(n_nprovin70,"���") <> 0 ) OR (index(n_nprovin70,"��ا෾") <> 0 ) THEN DO:
            ASSIGN 
            n_nsub_dist70  = IF index(n_nsub_dist70,"�ǧ") <> 0 THEN trim(n_nsub_dist70) ELSE "�ǧ" + trim(n_nsub_dist70)
            n_ndirection70 = IF index(n_ndirection70,"ࢵ") <> 0 THEN trim(n_ndirection70) ELSE "ࢵ" + trim(n_ndirection70)
            n_nprovin70    = trim(n_nprovin70)
            n_zipcode70    = trim(n_zipcode70). 
        END.
        ELSE DO:
            ASSIGN 
            n_nsub_dist70  = IF index(n_nsub_dist70,"�.") <> 0 THEN trim(n_nsub_dist70) 
                             ELSE IF index(n_nsub_dist70,"�Ӻ�") <> 0 THEN REPLACE(n_nsub_dist70,"�Ӻ�","�.")
                             ELSE "�." + trim(n_nsub_dist70)
            n_ndirection70 = IF index(n_ndirection70,"�.") <> 0 THEN trim(n_ndirection70) 
                             ELSE IF index(n_ndirection70,"�����") <> 0  THEN REPLACE(n_nsub_dist70,"�����","�.")
                             ELSE "�." + trim(n_ndirection70)
            n_nprovin70    = IF index(n_nprovin70,"�ѧ��Ѵ") <> 0 OR INDEX(n_nprovin70,"�.") <> 0 THEN TRIM(n_nprovin70)
                             ELSE "�." + TRIM(n_nprovin70)
            n_zipcode70    = trim(n_zipcode70).
        END.
    END.
    /*--- ������Ѵ��----*/
    IF n_addr2_72   <> ""  THEN DO: 
        IF INDEX(n_addr2_72,"�Ҥ��")     <> 0    THEN ASSIGN n_addr2_72 = trim(n_addr2_72). 
        ELSE IF INDEX(n_addr2_72,"�֡")  <> 0    THEN ASSIGN n_addr2_72 = trim(n_addr2_72).
        ELSE IF INDEX(n_addr2_72,"��ҹ") <> 0    THEN ASSIGN n_addr2_72 = trim(n_addr2_72).
        ELSE IF index(n_addr2_72,"���")  <> 0    THEN ASSIGN n_addr2_72 = trim(n_addr2_72).
        ELSE IF index(n_addr2_72,"˨�")  <> 0    THEN ASSIGN n_addr2_72 = trim(n_addr2_72).
        ELSE IF index(n_addr2_72,"����ѷ")  <> 0 THEN ASSIGN n_addr2_72 = trim(n_addr2_72).
        ELSE IF index(n_addr2_72,"��ҧ")    <> 0 THEN ASSIGN n_addr2_72 = trim(n_addr2_72).
        ELSE IF index(n_addr2_72,"��ŹԸ�") <> 0 THEN ASSIGN n_addr2_72 = trim(n_addr2_72).
        ELSE IF index(n_addr2_72,"���")    <> 0 THEN ASSIGN n_addr2_72 = trim(n_addr2_72).
        ELSE IF index(n_addr2_72,"��ͧ")    <> 0 THEN ASSIGN n_addr2_72 = trim(n_addr2_72).
        ELSE ASSIGN n_addr2_72 = "�����ҹ" + trim(n_addr2_72).
    END.
    IF n_addr3_72  <> ""  THEN DO: 
        IF INDEX(n_addr3_72,"����")      <> 0      THEN n_addr3_72 = REPLACE(n_addr3_72,"����","�.").
        ELSE IF INDEX(n_addr3_72,"�.")   <> 0      THEN n_addr3_72 = trim(n_addr3_72).
        ELSE IF INDEX(n_addr3_72,"��ҹ") <> 0      THEN n_addr3_72 = trim(n_addr3_72). 
        ELSE IF INDEX(n_addr3_72,"�����ҹ") <> 0  THEN n_addr3_72 = trim(n_addr3_72).
        ELSE IF INDEX(n_addr3_72,"���")  <> 0      THEN n_addr3_72 = trim(n_addr3_72).
        ELSE DO:
            ASSIGN  n = ""  
                n = SUBSTR(TRIM(n_addr3_72),1,1).
                IF INDEX("0123456789",n) <> 0 THEN n_addr3_72 = "�." + trim(n_addr3_72).
                ELSE n_addr3_72 = trim(n_addr3_72).
        END.
    END.
    IF n_addr4_72 <> ""  THEN DO:
        IF INDEX(n_addr4_72,"�.")       <> 0 THEN n_addr4_72 = trim(n_addr4_72) .
        ELSE IF INDEX(n_addr4_72,"���") <> 0 THEN n_addr4_72 = REPLACE(n_addr4_72,"���","�.").
        ELSE n_addr4_72 = "�." + trim(n_addr4_72) .
    END.
    IF n_addr5_72 <> ""  THEN DO: 
        IF INDEX(n_addr5_72,"�.")       <> 0 THEN n_addr5_72 = trim(n_addr5_72) .
        ELSE IF INDEX(n_addr5_72,"���") <> 0 THEN n_addr5_72 = REPLACE(n_addr5_72,"���","�.").
        ELSE n_addr5_72 = "�." + trim(n_addr5_72) .
    END.    
    IF n_nprovin72 <> ""  THEN DO:
        IF (index(n_nprovin72,"���") <> 0 ) OR (index(n_nprovin72,"��ا෾") <> 0 ) THEN DO:
            ASSIGN 
            n_nsub_dist72  = IF index(n_nsub_dist72,"�ǧ") <> 0 THEN trim(n_nsub_dist72) ELSE "�ǧ" + trim(n_nsub_dist72)
            n_ndirection72 = IF index(n_ndirection72,"ࢵ") <> 0 THEN trim(n_ndirection72) ELSE "ࢵ" + trim(n_ndirection72)
            n_nprovin72    = trim(n_nprovin72)
            n_zipcode72    = trim(n_zipcode72). 
        END.
        ELSE DO:
            ASSIGN 
            n_nsub_dist72  = IF index(n_nsub_dist72,"�Ӻ�")    <> 0 THEN REPLACE(n_nsub_dist72,"�Ӻ�","�.")
                             ELSE IF index(n_nsub_dist72,"�.") <> 0 THEN trim(n_nsub_dist72) 
                             ELSE "�." + trim(n_nsub_dist72)
            n_ndirection72 = IF index(n_ndirection72,"�����")   <> 0 THEN REPLACE(n_ndirection72,"�����","�.") 
                             ELSE IF index(n_ndirection72,"�.") <> 0 THEN trim(n_ndirection72) 
                             ELSE "�." + trim(n_ndirection72)
            n_nprovin72    = IF index(n_nprovin72,"�ѧ��Ѵ")    <> 0 THEN REPLACE(n_nprovin72,"�ѧ��Ѵ","�.") 
                             ELSE IF INDEX(n_nprovin72,"�.")    <> 0 THEN TRIM(n_nprovin72)
                             ELSE "�." + TRIM(n_nprovin72)
            n_zipcode72    = trim(n_zipcode72).
        END.
    END.
    /*--- ����������Թ----*/
    IF n_payaddr2   <> ""  THEN DO: 
        IF INDEX(n_payaddr2,"�Ҥ��")     <> 0    THEN ASSIGN n_payaddr2 = trim(n_payaddr2). 
        ELSE IF INDEX(n_payaddr2,"�֡")  <> 0    THEN ASSIGN n_payaddr2 = trim(n_payaddr2).
        ELSE IF INDEX(n_payaddr2,"��ҹ") <> 0    THEN ASSIGN n_payaddr2 = trim(n_payaddr2).
        ELSE IF index(n_payaddr2,"���")  <> 0    THEN ASSIGN n_payaddr2 = trim(n_payaddr2).
        ELSE IF index(n_payaddr2,"˨�")  <> 0    THEN ASSIGN n_payaddr2 = trim(n_payaddr2).
        ELSE IF index(n_payaddr2,"����ѷ")  <> 0 THEN ASSIGN n_payaddr2 = trim(n_payaddr2).
        ELSE IF index(n_payaddr2,"��ҧ")    <> 0 THEN ASSIGN n_payaddr2 = trim(n_payaddr2).
        ELSE IF index(n_payaddr2,"��ŹԸ�") <> 0 THEN ASSIGN n_payaddr2 = trim(n_payaddr2).
        ELSE IF index(n_payaddr2,"���")    <> 0 THEN ASSIGN n_payaddr2 = trim(n_payaddr2).
        ELSE IF index(n_payaddr2,"��ͧ")    <> 0 THEN ASSIGN n_payaddr2 = trim(n_payaddr2).
        ELSE ASSIGN n_payaddr2 = "�����ҹ" + trim(n_payaddr2).
    END.
    IF n_payaddr3  <> ""  THEN DO: 
        IF INDEX(n_payaddr3,"����")      <> 0      THEN n_payaddr3 = REPLACE(n_payaddr3,"����","�.").
        ELSE IF INDEX(n_payaddr3,"�.")   <> 0      THEN n_payaddr3 = trim(n_payaddr3).
        ELSE IF INDEX(n_payaddr3,"��ҹ") <> 0      THEN n_payaddr3 = trim(n_payaddr3). 
        ELSE IF INDEX(n_payaddr3,"�����ҹ") <> 0  THEN n_payaddr3 = trim(n_payaddr3).
        ELSE IF INDEX(n_payaddr3,"���")  <> 0      THEN n_payaddr3 = trim(n_payaddr3).
        ELSE DO:
            ASSIGN  n = ""  
                n = SUBSTR(TRIM(n_payaddr3),1,1).
                IF INDEX("0123456789",n) <> 0 THEN n_payaddr3 = "�." + trim(n_payaddr3).
                ELSE n_payaddr3 = trim(n_payaddr3).
        END.
    END.
    IF n_payaddr4 <> ""  THEN DO:
        IF INDEX(n_payaddr4,"�.") <> 0  THEN n_payaddr4 = trim(n_payaddr4) .
        ELSE IF INDEX(n_payaddr4,"���") <> 0 THEN n_payaddr4 = REPLACE(n_payaddr4,"���","�.").
        ELSE n_payaddr4 = "�." + trim(n_payaddr4) .
    END.
    IF n_payaddr5 <> ""  THEN DO: 
        IF INDEX(n_payaddr5,"�.") <> 0 THEN n_payaddr5 = trim(n_payaddr5) .
        ELSE IF INDEX(n_payaddr5,"���") <> 0  THEN n_payaddr5 = REPLACE(n_payaddr5,"���","�.").
        ELSE n_payaddr5 = "�." + trim(n_payaddr5) .
    END.    
    IF n_payaddr8 <> ""  THEN DO:
        IF (index(n_payaddr8,"���") <> 0 ) OR (index(n_payaddr8,"��ا෾") <> 0 ) THEN DO:
            ASSIGN 
            n_payaddr6 = IF index(n_payaddr6,"�ǧ") <> 0 THEN trim(n_payaddr6) ELSE "�ǧ" + trim(n_payaddr6)
            n_payaddr7 = IF index(n_payaddr7,"ࢵ") <> 0 THEN trim(n_payaddr7) ELSE "ࢵ" + trim(n_payaddr7)
            n_payaddr8 = trim(n_payaddr8)
            n_payaddr9 = trim(n_payaddr9). 
        END.           
        ELSE DO:       
            ASSIGN     
            n_payaddr6 = IF index(n_payaddr6,"�Ӻ�")    <> 0 THEN REPLACE(n_payaddr6,"�Ӻ�","�.") 
                         ELSE IF index(n_payaddr6,"�.") <> 0 THEN trim(n_payaddr6) 
                         ELSE "�." + trim(n_payaddr6)
            n_payaddr7 = IF index(n_payaddr7,"�����")   <> 0 THEN REPLACE(n_payaddr7,"�����","�.")
                         ELSE IF index(n_payaddr7,"�.") <> 0 THEN trim(n_payaddr7)
                         ELSE "�." + trim(n_payaddr7)
            n_payaddr8 = IF index(n_payaddr8,"�ѧ��Ѵ") <> 0 THEN REPLACE(n_payaddr8,"�ѧ��Ѵ","�.")
                         ELSE IF INDEX(n_payaddr8,"�.") <> 0 THEN TRIM(n_payaddr8)
                         ELSE "�." + TRIM(n_payaddr8)
            n_payaddr9 = trim(n_payaddr9).
        END.
    END.
    /* �ѡ����ͨѧ��Ѵ */
    FIND FIRST brstat.insure USE-INDEX Insure05   WHERE   /*use-index fname */
        brstat.insure.compno = "999" AND 
        brstat.insure.FName  = trim(n_province) NO-LOCK NO-WAIT NO-ERROR.
    IF AVAIL brstat.insure THEN DO:  
        ASSIGN n_province = Insure.LName.
    END.

    /*-- ����������ͧ ----*/
    IF n_deduct = "no" THEN n_deduct = "0".
    IF index(n_covtyp,"1") <> 0 THEN n_covcod = "1" .
    ELSE IF index(n_covtyp,"2+") <> 0 THEN DO: 
        IF deci(n_deduct) > 0 THEN n_covcod = "2.1" .
        ELSE n_covcod = "2.2" .
    END.
    ELSE IF index(n_covtyp,"3+") <> 0 THEN DO: 
        IF deci(n_deduct) > 0 THEN n_covcod = "3.1" .
        ELSE n_covcod = "3.2" .
    END.
    ELSE IF index(n_covtyp,"2") <> 0 THEN n_covcod = "2" .
    ELSE IF index(n_covtyp,"3") <> 0 THEN n_covcod = "3" .
    ELSE IF index(n_covtyp,"CMI") <> 0 THEN n_covcod = "T" .

END.
   
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chkcampaign C-Win 
PROCEDURE proc_chkcampaign :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: create by A61-0228      
------------------------------------------------------------------------------*/
DEF VAR n_garage AS CHAR INIT "" .

IF index(wload.garage,"�������") <> 0  THEN ASSIGN n_garage = "".
ELSE ASSIGN n_garage = "G".

IF index(wload.proname,"��з�ǧ") <> 0  THEN DO:
    IF wload.covcod = "1" THEN DO:        
        IF  wload.brand = "HONDA" THEN DO:
             FIND LAST brstat.insure USE-INDEX insure03 WHERE 
                  brstat.insure.compno        = "MOPH" AND 
                  brstat.insure.insno         = "MOPH" AND
                  trim(brstat.insure.text1)   = "HONDA"              AND 
                  trim(brstat.insure.text2)   = trim(n_garage)   AND                          
                  trim(brstat.insure.vatcode) = trim(wload.covcod)   AND 
                  deci(brstat.insure.icno)    = deci(wload.prem1)  NO-ERROR NO-WAIT.   /*cover*/
        END.
        ELSE DO:
            FIND LAST brstat.insure USE-INDEX insure03 WHERE 
                  brstat.insure.compno        = "MOPH" AND 
                  brstat.insure.insno         = "MOPH" AND
                  trim(brstat.insure.text1)   = "OTHER"              AND 
                  trim(brstat.insure.text2)   = trim(n_garage)   AND                          
                  trim(brstat.insure.vatcode) = trim(wload.covcod)   AND 
                  deci(brstat.insure.icno)    = deci(wload.prem1)  NO-ERROR NO-WAIT. 
        END.
        IF AVAIL brstat.insure THEN DO:
                ASSIGN wload.campcode = brstat.insure.text4
                       wload.packcode = brstat.insure.text5. /*A61-0228*/
        END.
    END.
    ELSE DO:
        FIND LAST brstat.insure USE-INDEX insure03 WHERE 
                      brstat.insure.compno        =  TRIM(wload.campcode) AND /*campaign*/
                      brstat.insure.insno         =  TRIM(wload.campcode) AND 
                      trim(brstat.insure.text2)   =  trim(n_garage)   AND                          
                      trim(brstat.insure.vatcode) =  trim(wload.covcod)   AND 
                      DECI(brstat.insure.icno)    =  deci(wload.prem1)      NO-ERROR NO-WAIT.   /*cover*/
            END.
            IF AVAIL brstat.insure THEN DO:
                    ASSIGN wload.packcode = brstat.insure.text5. /*A61-0228*/

        END.
    END.
ELSE DO:
        IF index(wload.campcode,"00305") <> 0 THEN ASSIGN wload.campcode = "C61/00216" .
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chklicen C-Win 
PROCEDURE proc_chklicen :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_licen AS CHAR FORMAT "x(11)" INIT "" .

IF trim(wload.licence) <> ""  AND trim(wload.licence) <> "����ᴧ" THEN DO:
   ASSIGN nv_licen = REPLACE(wload.licence," ","").
   IF INDEX("0123456789",SUBSTR(wload.licence,1,1)) <> 0 THEN DO:
       IF LENGTH(nv_licen) = 4 THEN 
          ASSIGN nv_licen    = SUBSTR(nv_licen,1,1) + SUBSTR(nv_licen,2,2) + " " + SUBSTR(nv_licen,4,1).
       ELSE IF LENGTH(nv_licen) = 5 THEN
           ASSIGN nv_licen    = SUBSTR(nv_licen,1,1) + SUBSTR(nv_licen,2,2) + " " + SUBSTR(nv_licen,4,2).
       ELSE IF LENGTH(nv_licen) = 6 THEN DO:
           IF INDEX("0123456789",SUBSTR(nv_licen,2,1)) <> 0 THEN
               ASSIGN nv_licen    = SUBSTR(nv_licen,1,2) + " " + SUBSTR(nv_licen,3,4).
           ELSE IF INDEX("0123456789",SUBSTR(nv_licen,3,1)) <> 0 THEN
               ASSIGN nv_licen    = SUBSTR(nv_licen,1,2) + " " + SUBSTR(nv_licen,3,4).
           ELSE 
               ASSIGN nv_licen    = SUBSTR(nv_licen,1,1) + SUBSTR(nv_licen,2,2) + " " + SUBSTR(nv_licen,4,3). 
       END.
       ELSE 
           ASSIGN nv_licen    = SUBSTR(nv_licen,1,1) + SUBSTR(nv_licen,2,2) + " " + SUBSTR(nv_licen,4,4).
    END.
    ELSE DO:
        IF LENGTH(nv_licen) = 3 THEN 
          ASSIGN nv_licen    = SUBSTR(nv_licen,1,2) + " "  + SUBSTR(nv_licen,3,1) .
        ELSE IF LENGTH(nv_licen) = 4 THEN
           ASSIGN nv_licen    = SUBSTR(nv_licen,1,2) + " " + SUBSTR(nv_licen,3,2) .
        ELSE IF LENGTH(nv_licen) = 6 THEN
           ASSIGN nv_licen    = SUBSTR(nv_licen,1,2) + " " + SUBSTR(nv_licen,3,4) .
        ELSE IF LENGTH(nv_licen) = 5 THEN DO:
            IF INDEX("0123456789",SUBSTR(nv_licen,2,1)) <> 0 THEN
               ASSIGN nv_licen    = SUBSTR(nv_licen,1,1) + " " + SUBSTR(nv_licen,2,4).
            ELSE 
               ASSIGN nv_licen    = SUBSTR(nv_licen,1,2) + " " + SUBSTR(nv_licen,3,3).
        END.
    END.
    ASSIGN wload.licence = nv_licen .
END.
ELSE DO: 
    IF LENGTH(wload.chassis) < 8 THEN ASSIGN wload.licence = "/" + TRIM(wload.chassis) .
    ELSE ASSIGN wload.licence = "/" + SUBSTR(wload.chassis,LENGTH(wload.chassis) - 8,LENGTH(wload.chassis)).
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chkwload C-Win 
PROCEDURE proc_chkwload :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR np_expdat AS CHAR FORMAT "x(15)".
DEF VAR np_year AS INT INIT 0.

FOR EACH wload .
       IF wload.poltyp  = "" THEN DELETE wload.
       ELSE DO:
           IF wload.poltyp = "V70" THEN DO:
               FOR EACH sicuw.uwm100 USE-INDEX uwm10002 WHERE sicuw.uwm100.cedpol = TRIM(wload.cedcode) NO-LOCK BREAK BY sicuw.uwm100.expdat DESCENDING.
                  IF sicuw.uwm100.poltyp <> "V70" THEN NEXT.
                  ELSE IF YEAR(sicuw.uwm100.expdat) <= YEAR(TODAY)  THEN NEXT.
                  ELSE DO:
                    ASSIGN np_expdat = ""
                           np_expdat = STRING(sicuw.uwm100.expdat,"99/99/9999").

                          /* Add By Tontawan S. 16/05/2023 */
                          IF wload.garage = "G" THEN wload.garage = "������ҧ". 
                          ELSE wload.garage = "�������".
                          /* End By Tontawan S. 16/05/2023 */

                          IF DATE(np_expdat) = DATE(wload.expdat) THEN DO:
                              ASSIGN  
                                  wload.policy   = sicuw.uwm100.policy 
                                  wload.producer = sicuw.uwm100.acno1 
                                  wload.agent    = sicuw.uwm100.agent .

                              /* Add By Tontawan S. 16/05/2023 */
                              FIND FIRST sicuw.uwm120 WHERE sicuw.uwm120.policy = sicuw.uwm100.policy NO-ERROR.
                              IF AVAIL sicuw.uwm120 THEN DO:
                                ASSIGN
                                    wload.tclass = sicuw.uwm120.CLASS.
                              END.
                              ELSE wload.tclass = "".
                              /* End By Tontawan S. 16/05/2023 */
                               
                              /*-- FIND LAST brstat.tlt USE-INDEX tlt05  WHERE -- Comment By Tontawan S. --*/ 
                                FIND LAST brstat.tlt USE-INDEX tlt06  WHERE  /*-- Add By Tontawan S. --*/ 
                                        brstat.tlt.cha_no  =  TRIM(wload.chassis) AND              
                                        brstat.tlt.genusr  =  "SCBPT"             AND 
                                        brstat.tlt.flag    =  "V70"               NO-ERROR NO-WAIT.     
                              IF AVAIL brstat.tlt THEN DO:
                                  ASSIGN 
                                     brstat.tlt.releas = "YES".
                                  IF brstat.tlt.policy = ""  THEN ASSIGN brstat.tlt.policy = wload.policy.
                              END.
                              RELEASE brstat.tlt.
                          END.
                          ELSE ASSIGN wload.policy  = "".
                  END.
               END.
               RELEASE sicuw.uwm100.
           END.
           IF wload.poltyp = "V72" THEN DO:
                  FOR EACH sicuw.uwm100 USE-INDEX uwm10002 WHERE sicuw.uwm100.cedpol = TRIM(wload.cedcode) NO-LOCK BREAK BY sicuw.uwm100.expdat DESCENDING. 
                        IF sicuw.uwm100.poltyp <> "V72" THEN NEXT.
                        ELSE IF YEAR(sicuw.uwm100.expdat) <= YEAR(TODAY)  THEN NEXT.
                        ELSE DO:
                            ASSIGN np_expdat     = ""
                                   np_expdat     = STRING(sicuw.uwm100.expdat,"99/99/9999")
                                   wload.garage  = "". /*-- Add By Tontawan S. A66-0006 16/05/2023 --*/

                            IF DATE(np_expdat) = DATE(wload.expdat) THEN DO:
                                ASSIGN  
                                    wload.policy    = sicuw.uwm100.policy 
                                    wload.producer  = sicuw.uwm100.acno1 
                                    wload.agent     = sicuw.uwm100.agent 
                                    nv_appen        = sicuw.uwm100.cr_2. /*-- Add By Tontawan S. A66-0006 --*/

                                /*-- Add By Tontawan S. A66-0006 --*/
                                FIND FIRST sicuw.uwm120 WHERE sicuw.uwm120.policy = sicuw.uwm100.policy NO-ERROR.
                                IF AVAIL sicuw.uwm120 THEN DO:
                                  ASSIGN
                                      wload.tclass = sicuw.uwm120.CLASS.
                                END.
                                ELSE wload.tclass = "".
                                /*-- End By Tontawan S. A66-0006 --*/

                                /*-- FIND LAST brstat.tlt USE-INDEX tlt05  WHERE -- Comment By Tontawan S. --*/ 
                                FIND LAST brstat.tlt USE-INDEX tlt06  WHERE /*-- Add By Tontawan S. --*/ 
                                          brstat.tlt.cha_no  =  TRIM(wload.chassis) AND              
                                          brstat.tlt.genusr  =  "SCBPT"             AND
                                          brstat.tlt.flag    =  "V72"               NO-ERROR NO-WAIT. 
                                IF AVAIL brstat.tlt THEN DO:
                                    ASSIGN brstat.tlt.releas = "YES".
                                    IF brstat.tlt.policy     = ""  THEN ASSIGN brstat.tlt.policy  = wload.policy.
                                END.
                                RELEASE brstat.tlt.
                            END.
                            ELSE ASSIGN wload.policy = "".
                        END.
                 END.

                 /*-- Add By Tontawan S. A66-0006 --*/
                 IF nv_appen <> "" THEN DO:
                     FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE sicuw.uwm100.policy = nv_appen NO-LOCK NO-ERROR NO-WAIT.
                     IF AVAIL sicuw.uwm100 THEN DO:
                         ASSIGN wload.producer = sicuw.uwm100.acno1.
                     END.
                 END.
                 /*-- End By Tontawan S. A66-0006 --*/
                 RELEASE sicuw.uwm100.
           END.
       END. /* else do */
    END. /*wload */
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
ASSIGN n_cmr_code          = ""         
       n_comp_code         = ""         
       n_campcode          = ""         
       n_campname          = ""         
       n_procode           = ""         
       n_proname           = ""         
       n_packname          = ""         
       n_packcode          = "" 
       n_prepol            = ""
       n_instype           = ""         
       n_pol_title         = ""         
       n_pol_fname         = ""         
       n_pol_lname         = ""         
       n_pol_title_eng     = ""         
       n_pol_fname_eng     = ""         
       n_pol_lname_eng     = ""         
       n_icno              = ""         
       n_sex               = ""         
       n_bdate             = ""         
       n_occup             = ""         
       n_tel               = ""         
       n_phone             = ""         
       n_teloffic          = ""         
       n_telext            = ""         
       n_moblie            = ""         
       n_mobliech          = ""         
       n_mail              = ""         
       n_lineid            = ""         
       n_addr1_70          = ""         
       n_addr2_70          = ""         
       n_addr3_70          = ""         
       n_addr4_70          = ""         
       n_addr5_70          = ""         
       n_nsub_dist70       = ""         
       n_ndirection70      = ""         
       n_nprovin70         = ""         
       n_zipcode70         = ""         
       n_addr1_72          = ""         
       n_addr2_72          = ""         
       n_addr3_72          = ""         
       n_addr4_72          = ""         
       n_addr5_72          = ""         
       n_nsub_dist72       = ""         
       n_ndirection72      = ""         
       n_nprovin72         = ""         
       n_zipcode72         = ""         
       n_paytype           = ""         
       n_paytitle          = ""         
       n_payname           = ""         
       n_paylname          = ""         
       n_payicno           = ""         
       n_payaddr1          = ""         
       n_payaddr2          = ""         
       n_payaddr3          = ""         
       n_payaddr4          = ""         
       n_payaddr5          = ""         
       n_payaddr6          = ""         
       n_payaddr7          = ""         
       n_payaddr8          = ""         
       n_payaddr9          = ""         
       n_branch            = ""         
       n_ben_title         = ""         
       n_ben_name          = ""         
       n_ben_lname         = ""         
       n_pmentcode         = ""         
       n_pmenttyp          = ""         
       n_pmentcode1        = ""         
       n_pmentcode2        = ""         
       n_pmentbank         = ""         
       n_pmentdate         = ""         
       n_pmentsts          = ""         
       n_driver            = ""         
       n_drivetitle1       = ""         
       n_drivename1        = ""         
       n_drivelname1       = ""         
       n_driveno1          = ""         
       n_occupdriv1        = ""         
       n_sexdriv1          = ""         
       n_bdatedriv1        = ""         
       n_drivetitle2       = ""         
       n_drivename2        = ""         
       n_drivelname2       = ""         
       n_driveno2          = ""         
       n_occupdriv2        = ""         
       n_sexdriv2          = ""         
       n_bdatedriv2        = ""         
       n_brand             = ""         
       n_brand_cd          = ""         
       n_Model             = ""         
       n_Model_cd          = ""         
       n_body              = ""         
       n_body_cd           = ""         
       n_licence           = ""         
       n_province          = ""         
       n_chassis           = ""         
       n_engine            = ""         
       n_yrmanu            = ""         
       n_seatenew          = ""         
       n_power             = ""         
       n_weight            = ""         
       n_class             = ""         
       n_garage_cd         = ""         
       n_garage            = ""         
       n_colorcode         = ""         
       n_covcod            = ""         
       n_covtyp            = ""         
       n_covtyp1           = ""         
       n_covtyp2           = ""         
       n_covtyp3           = ""         
       n_comdat            = ""         
       n_expdat            = ""         
       n_ins_amt           = ""         
       n_prem1             = ""         
       n_gross_prm         = ""         
       n_stamp             = ""         
       n_vat               = ""         
       n_premtotal         = ""         
       n_deduct            = ""         
       n_fleetper          = ""         
       n_fleet             = ""         
       n_ncbper            = ""         
       n_ncb               = ""         
       n_drivper           = ""         
       n_drivdis           = ""         
       n_othper            = ""         
       n_oth               = ""         
       n_cctvper           = ""         
       n_cctv              = ""         
       n_Surcharper        = ""         
       n_Surchar           = ""         
       n_Surchardetail     = ""         
       n_acc1              = ""         
       n_accdetail1        = ""         
       n_accprice1         = ""         
       n_acc2              = ""         
       n_accdetail2        = ""         
       n_accprice2         = ""         
       n_acc3              = ""         
       n_accdetail3        = ""         
       n_accprice3         = ""         
       n_acc4              = ""         
       n_accdetail4        = ""         
       n_accprice4         = ""         
       n_acc5              = ""         
       n_accdetail5        = ""         
       n_accprice5         = ""         
       n_inspdate          = ""         
       n_inspdate_app      = ""         
       n_inspsts           = ""         
       n_inspdetail        = ""         
       n_not_date          = ""         
       n_paydate           = ""         
       n_paysts            = ""         
       n_licenBroker       = ""         
       n_brokname          = ""         
       n_brokcode          = ""         
       n_lang              = ""         
       n_deli              = ""         
       n_delidetail        = ""         
       n_gift              = ""         
       n_cedcode           = ""         
       n_inscode           = ""         
       n_remark            = "" 
       n_poltyp            = ""
       n_insno             = ""
       n_resultins         = "" 
       n_damage1           = ""
       n_damage2           = ""
       n_damage3           = ""
       n_dataoth           = "" 
       n_ben_2title        = ""      /*Kridtiya i. A64-0295 DATE. 25/07/2021 */ 
       n_ben_2name         = ""      /*Kridtiya i. A64-0295 DATE. 25/07/2021 */ 
       n_ben_2lname        = ""      /*Kridtiya i. A64-0295 DATE. 25/07/2021 */ 
       n_ben_3title        = ""      /*Kridtiya i. A64-0295 DATE. 25/07/2021 */ 
       n_ben_3name         = ""      /*Kridtiya i. A64-0295 DATE. 25/07/2021 */ 
       n_ben_3lname        = ""      /*Kridtiya i. A64-0295 DATE. 25/07/2021 */
       n_Agent_Code        = ""      /*Kridtiya i. A64-0295 DATE. 25/07/2021 */ 
       n_Agent_NameTH      = ""      /*Kridtiya i. A64-0295 DATE. 25/07/2021 */ 
       n_Agent_NameEng     = ""      /*Kridtiya i. A64-0295 DATE. 25/07/2021 */ 
       n_Selling_Channel   = ""      /*Kridtiya i. A64-0295 DATE. 25/07/2021 */ 
       n_sellcode          = ""      //Add By Tontawan S. A66-0006 24/05/2023                          
       n_sellname          = ""      //.
       n_selling_ch        = ""      //.
       n_branch_c          = ""      //.
       n_campaign          = ""      //.
       n_person            = "0.00"  //.
       n_peracc            = "0.00"  //.
       n_perpd             = "0.00"  //.
       n_si411             = "0.00"  //.
       n_si412             = "0.00"  //.
       n_si43              = "0.00"  //.
       n_ispno             = ""      //End By Tontawan S. A66-0006 24/05/2023
       n_drv3_salutation_M = ""      //Add By Tontawan S. A68-0059 23/07/2025
       n_drv3_fname        = ""      //.
       n_drv3_lname        = ""      //.
       n_drv3_nid          = ""      //.
       n_drv3_occupation   = ""      //.
       n_drv3_gender       = ""      //.
       n_drv3_birthdate    = ""      //.
       n_drv4_salutation_M = ""      //.
       n_drv4_fname        = ""      //.
       n_drv4_lname        = ""      //.
       n_drv4_nid          = ""      //.
       n_drv4_occupation   = ""      //.
       n_drv4_gender       = ""      //.
       n_drv4_birthdate    = ""      //.
       n_drv5_salutation_M = ""      //.
       n_drv5_fname        = ""      //.
       n_drv5_lname        = ""      //.
       n_drv5_nid          = ""      //.
       n_drv5_occupation   = ""      //.
       n_drv5_gender       = ""      //.
       n_drv5_birthdate    = ""      //.
       n_drv1_dlicense     = ""      //.
       n_drv2_dlicense     = ""      //.
       n_drv3_dlicense     = ""      //.
       n_drv4_dlicense     = ""      //.
       n_drv5_dlicense     = ""      //.
       n_baty_snumber      = ""      //.
       n_batydate          = ""      //.
       n_baty_rsi          = "0.00"  //.
       n_baty_npremium     = "0.00"  //.
       n_baty_gpremium     = "0.00"  //.
       n_wcharge_snumber   = "0.00"  //.
       n_wcharge_si        = "0.00"  //.
       n_wcharge_npremium  = "0.00"  //.
       n_wcharge_gpremium  = "0.00". //Add By Tontawan S. A68-0059 23/07/2025    
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_create C-Win 
PROCEDURE proc_create :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
IF index(n_covtyp,"Insur") <> 0 /*OR INDEX(n_covtyp,"��Сѹ���") <> 0*/ THEN NEXT.
ELSE DO:
    FIND FIRST wload WHERE wload.covtyp   = trim(n_covtyp)   AND
                           wload.cedcode  = trim(n_cedcode)  AND
                           wload.inscode  = trim(n_inscode)  NO-LOCK NO-ERROR.
    IF NOT AVAIL wload THEN DO:
        RUN proc_chkaddr.
        CREATE wload.
        ASSIGN 
            wload.poltyp         = IF trim(n_covtyp) = "CMI" THEN "V72" ELSE "V70"
            wload.cedcode        = trim(n_cedcode)    
            wload.inscode        = trim(n_inscode)    
            wload.campcode       = trim(n_procode)
            wload.campname       = trim(n_proname)
            wload.procode        = trim(n_campcode)    
            wload.proname        = trim(n_campname)    
            wload.packname       = trim(n_packname)
            wload.packcode       = trim(n_packcode)
            wload.instype        = trim(n_instype)
            wload.pol_title      = trim(n_pol_title)
            wload.pol_fname      = trim(n_pol_fname) + " " + TRIM(n_pol_lname) 
            wload.pol_title_eng  = trim(n_pol_title_eng)
            wload.pol_fname_eng  = trim(n_pol_fname_eng) + " " + trim(n_pol_lname_eng)
            wload.icno           = trim(n_icno)
            wload.bdate          = IF trim(n_bdate) <> "" THEN SUBSTR(TRIM(n_bdate),9,2) + "/"  + /*'1985-08-01*/
                                                               SUBSTR(TRIM(n_bdate),6,2) + "/"  +
                                                               SUBSTR(TRIM(n_bdate),1,4) ELSE ""
            wload.occup          = trim(n_occup)
            wload.tel            = trim(n_tel) + "," + trim(n_moblie) + "," + trim(n_mobliech)
            wload.mail           = trim(n_mail)
            wload.addrpol1       = trim(n_addr1_70) + " " +
                                   trim(n_addr2_70) + " " +
                                   trim(n_addr3_70)
            wload.addrpol2       = trim(n_addr4_70) + " " + trim(n_addr5_70) 
            wload.addrpol3       = trim(n_nsub_dist70) + " " + trim(n_ndirection70)
            wload.addrpol4       = trim(n_nprovin70) + " " + trim(n_zipcode70)
            wload.addrsend1      = trim(n_addr1_72) + " " +
                                   trim(n_addr2_72) + " " + 
                                   trim(n_addr3_72)
            wload.addrsend2      = trim(n_addr4_72) + " " + trim(n_addr5_72)
            wload.addrsend3      = trim(n_nsub_dist72) + " " + trim(n_ndirection72)
            wload.addrsend4      = trim(n_nprovin72) + " " + trim(n_zipcode72)
            wload.paytype        = trim(n_paytype)
            wload.paytitle       = trim(n_paytitle)
            wload.payname        = trim(n_payname) + " " + trim(n_paylname)
            wload.icpay          = trim(n_payicno)
            wload.addrpay1       = trim(n_payaddr1) + " " +
                                   TRIM(n_payaddr2) + " " + 
                                   TRIM(n_payaddr3)
            wload.addrpay2       = trim(n_payaddr4) + " "  + TRIM(n_payaddr5)
            wload.addrpay3       = trim(n_payaddr6) + " "  + TRIM(n_payaddr7)
            wload.addrpay4       = trim(n_payaddr8) + " "  + TRIM(n_payaddr9)
            wload.branch         = trim(n_branch)
            wload.ben_name       = trim(n_ben_title) + trim(n_ben_name) + " " + trim(n_ben_lname)
            wload.pmentcode      = trim(n_pmentcode)
            wload.pmenttyp       = trim(n_pmenttyp)
            wload.pmentcode1     = trim(n_pmentcode1)
            wload.pmentcode2     = trim(n_pmentcode2)
            wload.pmentbank      = trim(n_pmentbank)
            wload.pmentdate      = IF trim(n_pmentdate) <> "" THEN  SUBSTR(TRIM(n_pmentdate),9,2) + "/"  +  /*'2021-10-05 21:26:00*/  
                                                                    SUBSTR(TRIM(n_pmentdate),6,2) + "/"  + 
                                                                    SUBSTR(TRIM(n_pmentdate),1,4) ELSE ""
            wload.pmentsts       = trim(n_pmentsts)
            wload.brand          = trim(n_brand)
            wload.Model          = trim(n_Model)
            wload.body           = trim(n_body)
            wload.licence        = trim(n_licence)
            wload.province       = trim(n_province)
            wload.chassis        = CAPS(trim(n_chassis))
            wload.engine         = CAPS(trim(n_engine))
            wload.yrmanu         = trim(n_yrmanu)
            wload.seatenew       = trim(n_seatenew)
            wload.power          = trim(n_power)
            wload.weight         = trim(n_weight)
            wload.class          = trim(n_class)
            wload.garage         = trim(n_garage)
            wload.colorcode      = trim(n_colorcode)
            wload.covcod         = trim(n_covcod)
            wload.covtyp         = trim(n_covtyp)
            wload.comdat         = IF trim(n_comdat) <> "" THEN SUBSTR(TRIM(n_comdat),9,2) + "/"  +
                                                                SUBSTR(TRIM(n_comdat),6,2) + "/"  +
                                                                SUBSTR(TRIM(n_comdat),1,4) ELSE ""
            wload.expdat         = IF trim(n_expdat) <> "" THEN SUBSTR(TRIM(n_expdat),9,2) + "/"  +
                                                                SUBSTR(TRIM(n_expdat),6,2) + "/"  +
                                                                SUBSTR(TRIM(n_expdat),1,4) ELSE ""
            wload.ins_amt        = trim(n_ins_amt)
            wload.prem1          = trim(n_prem1)
            wload.gross_prm      = trim(n_gross_prm)
            wload.stamp          = trim(n_stamp)
            wload.vat            = trim(n_vat)
            wload.premtotal      = trim(n_premtotal)
            wload.deduct         = trim(n_deduct)
            wload.fleetper       = IF INDEX(n_fleetper,"%") <> 0 THEN REPLACE(n_fleetper,"%","") ELSE trim(n_fleetper)      
            wload.ncbper         = IF INDEX(n_ncbper,"%") <> 0 THEN REPLACE(n_ncbper,"%","") ELSE trim(n_ncbper)  
            wload.othper         = IF INDEX(n_othper,"%") <> 0 THEN REPLACE(n_othper,"%","") ELSE trim(n_othper)            
            wload.cctvper        = IF INDEX(n_cctvper,"%") <> 0 THEN REPLACE(n_cctvper,"%","") ELSE trim(n_cctvper)
            wload.driver         = trim(n_driver)
            wload.drivename1     = trim(n_drivetitle1) + trim(n_drivename1) + " " + trim(n_drivelname1)
            wload.driveno1       = trim(n_driveno1)
            wload.occupdriv1     = trim(n_occupdriv1)
            wload.sexdriv1       = trim(n_sexdriv1)
            wload.bdatedriv1     = IF trim(n_bdatedriv1) <> "" THEN STRING(DATE(n_bdatedriv1),"99/99/9999") ELSE ""
            wload.drivename2     = trim(n_drivetitle2) + trim(n_drivename2) + " " + trim(n_drivelname2)
            wload.driveno2       = trim(n_driveno2)
            wload.occupdriv2     = trim(n_occupdriv2)
            wload.sexdriv2       = trim(n_sexdriv2)
            wload.bdatedriv2     = IF trim(n_bdatedriv2) <> "" THEN string(DATE(n_bdatedriv2),"99/99/9999") ELSE "". 
            
        CREATE wtxt.
        ASSIGN 
            wtxt.poltyp        = IF trim(n_covtyp) = "CMI" THEN "V72" ELSE "V70"
            wtxt.cedcode       = trim(n_cedcode)    
            wtxt.inscode       = trim(n_inscode)    
            wtxt.acc1          = trim(n_acc1)                                                                             
            wtxt.accdetail1    = trim(n_accdetail1)                                                                       
            wtxt.accprice1     = trim(n_accprice1)                                                                        
            wtxt.acc2          = trim(n_acc2)                                                                             
            wtxt.accdetail2    = trim(n_accdetail2)                                                                       
            wtxt.accprice2     = trim(n_accprice2)                                                                        
            wtxt.acc3          = trim(n_acc3)                                                                             
            wtxt.accdetail3    = trim(n_accdetail3)                                                                       
            wtxt.accprice3     = trim(n_accprice3)                                                                        
            wtxt.acc4          = trim(n_acc4)                                                                             
            wtxt.accdetail4    = trim(n_accdetail4)                                                                       
            wtxt.accprice4     = trim(n_accprice4)                                                                        
            wtxt.acc5          = trim(n_acc5)                                                                             
            wtxt.accdetail5    = trim(n_accdetail5)                                                                       
            wtxt.accprice5     = trim(n_accprice5)                                                                        
            /*wtxt.inspdate      = if trim(n_inspdate) <> "" THEN STRING(DATE(n_inspdate),"99/99/9999") ELSE ""                                                        
            wtxt.inspdate_app  = if trim(n_inspdate_app) <> "" THEN STRING(DATE(n_inspdate_app),"99/99/9999") ELSE "" */ 
            wtxt.inspdate      = trim(n_inspdate)                                                        
            wtxt.inspdate_app  = trim(n_inspdate_app)  
            wtxt.inspsts       = trim(n_inspsts)                                                                          
            wtxt.inspdetail    = trim(n_inspdetail)                                                                       
            wtxt.not_date      = if trim(n_not_date) <> "" then SUBSTR(TRIM(n_not_date),9,2) + "/"  +
                                                                SUBSTR(TRIM(n_not_date),6,2) + "/"  +
                                                                SUBSTR(TRIM(n_not_date),1,4) else ""  
            wtxt.paydate       = if trim(n_paydate)  <> "" then SUBSTR(TRIM(n_paydate),9,2) + "/"  + 
                                                                SUBSTR(TRIM(n_paydate),6,2) + "/"  +
                                                                SUBSTR(TRIM(n_paydate),1,4) else ""                                                    
            wtxt.paysts        = trim(n_paysts)                                                                           
            wtxt.licenBroker   = trim(n_licenBroker)
            wtxt.brokname      = trim(n_brokname)   
            wtxt.brokcode      = trim(n_brokcode)   
            wtxt.lang          = trim(n_lang)       
            wtxt.deli          = trim(n_deli)       
            wtxt.delidetail    = trim(n_delidetail) 
            wtxt.gift          = trim(n_gift)       
            wtxt.remark        = trim(n_remark) 
            wtxt.ben_2title      = trim(n_ben_2title)        /*Kridtiya i. A64-0295 DATE. 25/07/2021 */  
            wtxt.ben_2name       = trim(n_ben_2name)         /*Kridtiya i. A64-0295 DATE. 25/07/2021 */  
            wtxt.ben_2lname      = trim(n_ben_2lname)        /*Kridtiya i. A64-0295 DATE. 25/07/2021 */  
            wtxt.ben_3title      = trim(n_ben_3title)        /*Kridtiya i. A64-0295 DATE. 25/07/2021 */  
            wtxt.ben_3name       = trim(n_ben_3name)         /*Kridtiya i. A64-0295 DATE. 25/07/2021 */  
            wtxt.ben_3lname      = trim(n_ben_3lname)        /*Kridtiya i. A64-0295 DATE. 25/07/2021 */  
            wtxt.Agent_Code      = trim(n_Agent_Code)        /*Kridtiya i. A64-0295 DATE. 25/07/2021 */  
            wtxt.Agent_NameTH    = trim(n_Agent_NameTH)      /*Kridtiya i. A64-0295 DATE. 25/07/2021 */  
            wtxt.Agent_NameEng   = trim(n_Agent_NameEng)     /*Kridtiya i. A64-0295 DATE. 25/07/2021 */  
            wtxt.Selling_Channel = trim(n_Selling_Channel) . /*Kridtiya i. A64-0295 DATE. 25/07/2021 */  
    END.                                                                                                            
END.  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_detailpolicy C-Win 
PROCEDURE proc_detailpolicy :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH wload NO-LOCK.
    FIND LAST wtxt WHERE wtxt.poltyp  = wload.poltyp  AND
                         wtxt.cedcode = wload.cedcode AND
                         wtxt.inscode = wload.inscode NO-LOCK NO-ERROR .
    IF AVAIL wtxt  THEN DO:
        
    nv_row  =  nv_row + 1.

    EXPORT DELIMITER "|" 
        wload.producer 
        wload.agent    
        wload.poltyp                                /* ��������������*/ 
        wload.policy                                /* policy no. */
        wload.cedcode                               /* ������ҧ�ԧ   */               
        wload.inscode                               /* �����١���    */               
        wload.campcode                              /* ������໭    */               
        wload.campname                              /* ������໭    */               
        wload.procode                               /* ���ʼ�Ե�ѳ�� */               
        wload.proname                               /* ���ͼ�Ե�ѳ�� */               
        wload.packname                              /* ����ᾤ��   */               
        wload.packcode                              /* ����ᾤ��   */
        wload.prepol                                /* ��.��� */
        wload.instype                               /* �����������һ�Сѹ */          
        wload.pol_title                             /* �ӹ�˹�Ҫ��� �����һ�Сѹ */   
        wload.pol_fname                             /* ���� �����һ�Сѹ         */   
        wload.pol_title_eng                         /* �ӹ�˹�Ҫ��� �����һ�Сѹ */   
        wload.pol_fname_eng                         /* ���� �����һ�Сѹ*/            
        wload.icno                                  /* �Ţ�ѵü����һ�Сѹ */         
        wload.bdate                                 /* �ѹ�Դ�����һ�Сѹ */         
        wload.occup                                 /* �Ҫվ�����һ�Сѹ*/            
        IF INDEX(wload.tel,",,") <> 0 THEN REPLACE(wload.tel,",,","") ELSE TRIM(wload.tel)  /* �����ü����һ�Сѹ*/         
        wload.mail                                  /* ����������һ�Сѹ  */         
        wload.addrpol1                              /* �������˹�ҵ��ҧ1*/            
        wload.addrpol2                              /* �������˹�ҵ��ҧ2*/            
        wload.addrpol3                              /* �������˹�ҵ��ҧ3*/            
        wload.addrpol4                              /* �������˹�ҵ��ҧ4*/            
        wload.addrsend1                             /* �������Ѵ�� 1  */            
        wload.addrsend2                             /* �������Ѵ�� 2  */            
        wload.addrsend3                             /* �������Ѵ�� 3  */            
        wload.addrsend4                             /* �������Ѵ�� 4  */            
        wload.paytype                               /* �������������Թ*/            
        wload.paytitle                              /* �ӹ�˹�Ҫ��� �������Թ*/     
        wload.payname                               /* ���� �������Թ*/   
        wload.icpay                                 /* �Ţ��Шӵ�Ǽ����������*/    
        wload.addrPay1                              /* ��������͡�����1*/        
        wload.addrPay2                              /* ��������͡�����2*/        
        wload.addrPay3                              /* ��������͡�����3*/        
        wload.addrPay4                              /* ��������͡�����4*/        
        wload.branch                                /* �Ң�*/                         
        wload.ben_name                              /* ����Ѻ�Ż���ª��  */           
        wload.pmentcode                             /* ���ʻ�������è��� */           
        wload.pmenttyp                              /* ��������è��� */               
        wload.pmentcode1                            /* ���ʪ�ͧ�ҧ��è���*/           
        wload.pmentcode2                            /* ��ͧ�ҧ��è���  */             
        wload.pmentbank                             /* ��Ҥ�÷�����*/                
        wload.pmentdate                             /* �ѹ������   */                
        wload.pmentsts                              /* ʶҹС�è��� */                
        wload.brand                                 /* ������  */                     
        wload.Model                                 /* ���    */                     
        wload.body                                  /* Ẻ��Ƕѧ*/                    
        wload.licence                               /* ����¹ */                     
        wload.province                              /* �ѧ��Ѵ����¹ */              
        wload.chassis                               /* �Ţ��Ƕѧ*/                    
        wload.engine                                /* �Ţ����ͧ */                  
        wload.yrmanu                                /* ��ö    */                     
        wload.seatenew                              /* ����� */                     
        wload.power                                 /* �ի�    */                     
        wload.weight                                /* ���˹ѡ */                     
        wload.class                                 /* ����ö  */    
        CAPS(wload.tclass)                          /* ����ö¹�� */ /*-- Add By Tontawan S. A66-0006 16/05/2023 ---*/
        wload.garage                                /* ��ë��� */                     
        wload.colorcode                             /* ��  */                         
        wload.covcod                                /* ��������û�Сѹ */             
        wload.covtyp                                /* ���ʡ�û�Сѹ*/                
        wload.comdat                                /* �ѹ��������ͧ  */             
        wload.expdat                                /* �ѹ����������*/                
        wload.ins_amt                               /* �ع��Сѹ*/                    
        wload.prem1                                 /* �����ط�ԡ�͹�ѡ��ǹŴ*/      
        /*wload.gross_prm                             /* �����ط����ѧ�ѡ��ǹŴ*/ -- Comment By Tontawan S. 16/05/2023 A66-0006 --*/     
        wload.stamp                                 /* �����  */                     
        wload.vat                                   /* ����    */                     
        wload.premtotal                             /* �������*/                     
        wload.deduct                                /* Deduct  */                     
        wload.fleetper                              /* fleet   */                     
        wload.ncbper                                /* ncb     */ 
        wload.othper                                /* other   */                     
        wload.cctvper                               /* cctv    */ 
        wload.driver                                /* �кؼ��Ѻ���    */            
        wload.drivename1                            /* ���ͼ��Ѻ���1   */    
        wload.driveno1                              /* �Ţ�ѵü��Ѻ���1*/            
        wload.occupdriv1                            /* �Ҫվ���Ѻ���1  */            
        wload.sexdriv1                              /* �ȼ��Ѻ���1    */            
        IF wload.bdatedriv1 <> ? THEN STRING(DATE(wload.bdatedriv1),"99/99/9999") ELSE "" /* �ѹ�Դ���Ѻ���1*/            
        wload.drivename2                            /* ���ͼ��Ѻ���2   */                 
        wload.driveno2                              /* �Ţ�ѵü��Ѻ���2*/          
        wload.occupdriv2                            /* �Ҫվ���Ѻ���2  */            
        wload.sexdriv2                              /* �ȼ��Ѻ���2    */            
        IF wload.bdatedriv2 <> ? THEN STRING(DATE(wload.bdatedriv2),"99/99/9999") ELSE "" /* �ѹ�Դ���Ѻ���2*/            
        wtxt.acc1                                   /* �ػ�ó쵡��1   */            
        wtxt.accdetail1                             /* ��������´�ػ�ó�1*/           
        wtxt.accprice1                              /* �Ҥ��ػ�ó�1  */               
        wtxt.acc2                                   /* �ػ�ó쵡��2*/               
        wtxt.accdetail2                             /* ��������´�ػ�ó�2*/           
        wtxt.accprice2                              /* �Ҥ��ػ�ó�2  */               
        wtxt.acc3                                   /* �ػ�ó쵡��3*/               
        wtxt.accdetail3                             /* ��������´�ػ�ó�3*/           
        wtxt.accprice3                              /* �Ҥ��ػ�ó�3  */               
        wtxt.acc4                                   /* �ػ�ó쵡��4*/               
        wtxt.accdetail4                             /* ��������´�ػ�ó�4*/           
        wtxt.accprice4                              /* �Ҥ��ػ�ó�4  */               
        wtxt.acc5                                   /* �ػ�ó쵡��5*/               
        wtxt.accdetail5                             /* ��������´�ػ�ó�5*/           
        wtxt.accprice5                              /* �Ҥ��ػ�ó�5  */               
        IF wtxt.inspdate = ? THEN string(date(wtxt.inspdate),"99/99/9999") ELSE ""   /* �ѹ����Ǩ��Ҿ*/               
        IF wtxt.inspdate_app = ? THEN string(date(wtxt.inspdate_app),"99/99/9999") ELSE "" /* �ѹ���͹��ѵԼš�õ�Ǩ*/       
        wtxt.ispno                                  /* �Ţ��Ǩö ISP */ /*-- Add By Tontawan S. A66-0006 --*/
        wtxt.inspsts                                /* �š�õ�Ǩ��Ҿ*/                
        wtxt.inspdetail                             /* ��������´��õ�Ǩ��Ҿ*/        
        wtxt.not_date                               /* �ѹ�����*/                    
        wtxt.paydate                                /* �ѹ����Ѻ�����Թ*/            
        wtxt.paysts                                 /* ʶҹС�è���*/                 
        wtxt.licenBroker                            /* �Ţ����͹حҵ���˹��*/        
        wtxt.brokname                               /* ���͹��˹�� */                 
        wtxt.brokcode                               /* ���ʹ��˹�� */                 
        wtxt.lang                                   /* ����        */                 
        wtxt.deli                                   /* ��èѴ�觡�������   */         
        wtxt.delidetail                             /* ��������´��èѴ�� */         
        wtxt.gift                                   /* �ͧ��  */                     
        wtxt.remark                                 /* �����˵�*/
        wtxt.insno                                  /* �Ţ��Ǩ��Ҿ */  
        wtxt.resultins                              /* �š�õ�Ǩ */    
        wtxt.damage1                                /* �����������1 */ 
        wtxt.damage2                                /* �����������2 */ 
        wtxt.damage3                                /* �����������3 */ 
        wtxt.dataoth                                /* ���������� */
        wload.sellcode                              /* ������ */               /* Add By Tontawan S. A66-0006 17/05/2023 */     
        wload.sellname                              /* ������ */      
        wload.selling_ch                            /* ��ͧ�ҧ��â�� */
        wload.branch_c                              /* �����Ң� */     
        wload.campaign                              /* ��໭ */      
        wload.person                                /* Per Person (BI)  */                                
        wload.peracc                                /* Per Accident     */
        wload.perpd                                 /* Per Accident(PD) */
        wload.si411                                 /* 411 SI.          */
        wload.si412                                 /* 412 Sum          */
        wload.si43                                  /* 43  Sum  .       */       /* End By Tontawan S. A66-0006 17/05/2023 */
        wload.drv3_salutation_M + " " + wload.drv3_fname + " " + wload.drv3_lname   // ���Ѻ 3 : �ӹ�˹��           Add By Tontawan S. A68-0059 17/05/2025   
        //wload.drv3_fname                            // ���Ѻ 3 : ����               ""
        //wload.drv3_lname                            // ���Ѻ 3 : ���ʡ��            ""
        wload.drv3_nid                              // ���Ѻ 3 : �Ţ�ѵû�ЪҪ�     ""
        wload.drv3_occupation                       // ���Ѻ 3 : �Ҫվ              ""
        wload.drv3_gender                           // ���Ѻ 3 : ��                ""
        wload.drv3_birthdate                        // ���Ѻ 3 : �ѹ�Դ            ""
        wload.drv4_salutation_M + " " + wload.drv4_fname + " " + wload.drv4_lname                    // ���Ѻ 4 : �ӹ�˹��           ""
        //wload.drv4_fname                            // ���Ѻ 4 : ����               ""
        //wload.drv4_lname                            // ���Ѻ 4 : ���ʡ��            ""
        wload.drv4_nid                              // ���Ѻ 4 : �Ţ�ѵû�ЪҪ�     ""
        wload.drv4_occupation                       // ���Ѻ 4 : �Ҫվ              ""
        wload.drv4_gender                           // ���Ѻ 4 : ��                ""
        wload.drv4_birthdate                        // ���Ѻ 4 : �ѹ�Դ            ""
        wload.drv5_salutation_M + " " + wload.drv5_fname + " " + wload.drv5_lname                     // ���Ѻ 5 : �ӹ�˹��           ""
        //wload.drv5_fname                            // ���Ѻ 5 : ����               ""
        //wload.drv5_lname                            // ���Ѻ 5 : ���ʡ��            ""
        wload.drv5_nid                              // ���Ѻ 5 : �Ţ�ѵû�ЪҪ�     ""
        wload.drv5_occupation                       // ���Ѻ 5 : �Ҫվ              ""
        wload.drv5_gender                           // ���Ѻ 5 : ��                ""
        wload.drv5_birthdate                        // ���Ѻ 5 : �ѹ�Դ            ""
        wload.drv1_dlicense                         // ���Ѻ 1 : ����¹ö          ""
        wload.drv2_dlicense                         // ���Ѻ 2 : ����¹ö          ""
        wload.drv3_dlicense                         // ���Ѻ 3 : ����¹ö          ""
        wload.drv4_dlicense                         // ���Ѻ 4 : ����¹ö          ""
        wload.drv5_dlicense                         // ���Ѻ 5 : ����¹ö          ""
        wload.baty_snumber                          // Battery : Serial Number      ""
        wload.batydate                              // Battery : Year               ""
        wload.baty_rsi                              // Battery : Replacement SI     ""
        wload.baty_npremium                         // Battery : Net Premium        ""
        wload.baty_gpremium                         // Battery : Gross_Premium      ""
        wload.wcharge_snumber                       // Wall Charge : Serial_Number  ""
        wload.wcharge_si                            // Wall Charge : SI             ""
        wload.wcharge_npremium                      // Wall Charge : Net Premium    ""
        wload.wcharge_gpremium.                     // Wall Charge : Gross Premium  End By Tontawan S. A68-0059 17/05/2025
    END.          
END.
OUTPUT CLOSE.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_detailreport C-Win 
PROCEDURE proc_detailreport :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_damdetail AS LONGCHAR .
DEF VAR nv_yrpol AS INT INIT 0.
DEF VAR nv_yr AS INT INIT 0.
FOR EACH wload NO-LOCK.
    
    FIND LAST wtxt WHERE wtxt.poltyp  = wload.poltyp  AND
                         wtxt.cedcode = wload.cedcode AND
                         wtxt.inscode = wload.inscode NO-LOCK NO-ERROR .

        ASSIGN nv_damdetail = "" .
        /* �礢����ŵ�Ǩ��Ҿ */
        FIND LAST brstat.tlt USE-INDEX tlt06 WHERE tlt.cha_no = wload.chassis AND 
                                                   tlt.eng_no = wload.engine  AND
                                                   tlt.flag   = "INSPEC"      AND 
                                                   tlt.genusr = "SCBPT"       NO-LOCK NO-ERROR.
        IF AVAIL tlt THEN DO:
            

            ASSIGN wtxt.insno       = brstat.tlt.nor_noti_tlt
                   wtxt.resultins   = brstat.tlt.safe1
                   nv_damdetail     = brstat.tlt.safe2
                   wtxt.dataoth     = brstat.tlt.filler2 . 
             IF nv_damdetail <> "" THEN DO:
               IF INDEX(nv_damdetail,"21.") <> 0 THEN DO: 
                   ASSIGN wtxt.damage3 = TRIM(SUBSTR(nv_damdetail,R-INDEX(nv_damdetail,"21.")))
                          nv_damdetail = TRIM(SUBSTR(nv_damdetail,1,R-INDEX(nv_damdetail,"21.") - 2))
                          wtxt.damage2 = TRIM(SUBSTR(nv_damdetail,R-INDEX(nv_damdetail,"11.")))
                          wtxt.damage1 = TRIM(SUBSTR(nv_damdetail,1,R-INDEX(nv_damdetail,"11.") - 2)).
               END.
               ELSE IF INDEX(nv_damdetail,"11.") <> 0 THEN DO:
                   ASSIGN wtxt.damage3 = ""
                          wtxt.damage2 = TRIM(SUBSTR(nv_damdetail,R-INDEX(nv_damdetail,"11.")))
                          wtxt.damage1 = TRIM(SUBSTR(nv_damdetail,1,R-INDEX(nv_damdetail,"11.") - 2)).
               END.
               ELSE DO:
                   ASSIGN wtxt.damage3 = "" 
                          wtxt.damage2 = ""
                          wtxt.damage1 = TRIM(nv_damdetail) .
               END.
             END.
             ELSE  ASSIGN wtxt.damage3 = "" 
                          wtxt.damage2 = "" 
                          wtxt.damage1 = "".
        END.
        ELSE ASSIGN wtxt.insno       = ""
                    wtxt.resultins   = ""
                    wtxt.damage1     = ""
                    wtxt.damage2     = ""
                    wtxt.damage3     = ""
                    wtxt.dataoth     = "" .

        IF INDEX(wload.CLASS,".") <> 0  THEN wload.CLASS = REPLACE(wload.class,".","") .
        IF LENGTH(wload.class) < 3 THEN wload.class = wload.class + "0" .
        RUN proc_chklicen. /*�礷���¹ */
        RUN proc_chkcampaign . /* ����໭ */ /*A61-0228*/
        /* ������������ */
        IF wload.chassis <> "" AND wload.prepol = "" THEN DO: 
            ASSIGN  nv_yrpol = 0    nv_yr = 0.  /*A61-0228*/
            RUN proc_chassis.
            IF wload.poltyp = "V70" THEN DO:
                FIND LAST sicuw.uwm301 USE-INDEX uwm30121  WHERE 
                          sicuw.uwm301.cha_no = trim(wload.chassis) AND 
                          sicuw.uwm301.tariff = "X" NO-LOCK NO-ERROR NO-WAIT.
                 IF AVAIL sicuw.uwm301 THEN DO:
                     /*A61-0228*/
                     nv_yrpol = (INT(SUBSTR(sicuw.uwm301.policy,5,2)) + 2500 ).
                     nv_yr    = (YEAR(TODAY) + 543 ) . 
                     nv_yr    = nv_yr - nv_yrpol .
                     IF nv_yr <= 5 THEN ASSIGN wload.prepol = sicuw.uwm301.policy.
                     ELSE ASSIGN wload.prepol = "" .
                    /* end A61-0228*/
                 END.
                 ELSE ASSIGN wload.prepol = "" .
            END.
            ELSE DO:
                FIND LAST sicuw.uwm301 USE-INDEX uwm30121  WHERE 
                          sicuw.uwm301.cha_no = trim(wload.chassis) AND 
                          sicuw.uwm301.tariff = "9" NO-LOCK NO-ERROR NO-WAIT.
                 IF AVAIL sicuw.uwm301 THEN DO:
                    /*A61-0228*/
                    nv_yrpol = (INT(SUBSTR(sicuw.uwm301.policy,5,2)) + 2500 ).
                    nv_yr    = (YEAR(TODAY) + 543 ) . 
                    nv_yr    = nv_yr - nv_yrpol .
                    IF nv_yr <= 5 THEN ASSIGN wload.prepol = sicuw.uwm301.policy.
                    ELSE ASSIGN wload.prepol = "" .
                    /* end A61-0228*/
                 END.
                 ELSE ASSIGN wload.prepol = "" .

            END.
        END.
        /* �礡���͡�ҹ */
        FIND LAST brstat.tlt USE-INDEX tlt06 WHERE tlt.cha_no = wload.chassis AND 
                                                   tlt.eng_no = wload.engine  AND
                                                   tlt.flag   = wload.poltyp  AND 
                                                   tlt.genusr = "SCBPT"       AND 
                                                   tlt.releas = "Yes"         NO-ERROR NO-WAIT.
                IF AVAIL tlt THEN DO:
                   ASSIGN wload.poltyp = wload.poltyp + " �͡�ҹ����" 
                          wload.prepol = tlt.policy .
                   
                END.

    nv_row  =  nv_row + 1.
    EXPORT DELIMITER "|"                            
        wload.poltyp                                /* ��������������*/               
        wload.cedcode                               /* ������ҧ�ԧ   */               
        wload.inscode                               /* �����١���    */               
        wload.campcode                              /* ������໭    */               
        wload.campname                              /* ������໭    */               
        wload.procode                               /* ���ʼ�Ե�ѳ�� */               
        wload.proname                               /* ���ͼ�Ե�ѳ�� */               
        wload.packname                              /* ����ᾤ��   */               
        wload.packcode                              /* ����ᾤ��   */
        wload.prepol                                /* ��.��� */
        wload.instype                               /* �����������һ�Сѹ */          
        IF wload.instype = "P" THEN "�س" ELSE wload.pol_title   /* �ӹ�˹�Ҫ��� �����һ�Сѹ */   
        wload.pol_fname                             /* ���� �����һ�Сѹ         */   
        wload.pol_title_eng                         /* �ӹ�˹�Ҫ��� �����һ�Сѹ */   
        wload.pol_fname_eng                         /* ���� �����һ�Сѹ*/            
        wload.icno                                  /* �Ţ�ѵü����һ�Сѹ */         
        wload.bdate                                 /* �ѹ�Դ�����һ�Сѹ */         
        wload.occup                                 /* �Ҫվ�����һ�Сѹ*/            
        IF index(wload.tel,",,") <> 0 THEN REPLACE(wload.tel,",,","") ELSE TRIM(wload.tel)  /* �����ü����һ�Сѹ*/         
        wload.mail                                  /* ����������һ�Сѹ  */         
        wload.addrpol1                              /* �������˹�ҵ��ҧ1*/            
        wload.addrpol2                              /* �������˹�ҵ��ҧ2*/            
        wload.addrpol3                              /* �������˹�ҵ��ҧ3*/            
        wload.addrpol4                              /* �������˹�ҵ��ҧ4*/            
        wload.addrsend1                             /* �������Ѵ�� 1  */            
        wload.addrsend2                             /* �������Ѵ�� 2  */            
        wload.addrsend3                             /* �������Ѵ�� 3  */            
        wload.addrsend4                             /* �������Ѵ�� 4  */            
        wload.paytype                               /* �������������Թ*/            
        IF wload.paytype = "P" THEN "�س" ELSE wload.paytitle                              /* �ӹ�˹�Ҫ��� �������Թ*/     
        wload.payname                               /* ���� �������Թ*/  
        wload.icpay                                 /* �Ţ��Шӵ�Ǽ����������*/                     
        wload.addrPay1                              /* ��������͡�����1*/                         
        wload.addrPay2                              /* ��������͡�����2*/                         
        wload.addrPay3                              /* ��������͡�����3*/                         
        wload.addrPay4                              /* ��������͡�����4*/ 
        wload.branch                                /* �Ң�*/                         
        wload.ben_name                              /* ����Ѻ�Ż���ª��  */           
        wload.pmentcode                             /* ���ʻ�������è��� */           
        wload.pmenttyp                              /* ��������è��� */               
        wload.pmentcode1                            /* ���ʪ�ͧ�ҧ��è���*/           
        wload.pmentcode2                            /* ��ͧ�ҧ��è���  */             
        wload.pmentbank                             /* ��Ҥ�÷�����*/                
        wload.pmentdate                             /* �ѹ������   */                
        wload.pmentsts                              /* ʶҹС�è��� */                
        wload.brand                                 /* ������  */                     
        wload.Model                                 /* ���    */                     
        wload.body                                  /* Ẻ��Ƕѧ*/                    
        wload.licence                               /* ����¹ */                     
        wload.province                              /* �ѧ��Ѵ����¹ */              
        wload.chassis                               /* �Ţ��Ƕѧ*/                    
        wload.engine                                /* �Ţ����ͧ */                  
        wload.yrmanu                                /* ��ö    */                     
        wload.seatenew                              /* ����� */                     
        wload.power                                 /* �ի�    */                     
        wload.weight                                /* ���˹ѡ */                     
        wload.class                                 /* ����ö  */                     
        wload.garage                                /* ��ë��� */                     
        wload.colorcode                             /* ��  */                         
        wload.covcod                                /* ��������û�Сѹ */             
        wload.covtyp                                /* ���ʡ�û�Сѹ*/                
        wload.comdat                                /* �ѹ��������ͧ  */             
        wload.expdat                                /* �ѹ����������*/                
        wload.ins_amt                               /* �ع��Сѹ*/                    
        wload.prem1                                 /* �����ط�ԡ�͹�ѡ��ǹŴ*/      
        wload.gross_prm                             /* �����ط����ѧ�ѡ��ǹŴ*/      
        wload.stamp                                 /* �����  */                     
        wload.vat                                   /* ����    */                     
        wload.premtotal                             /* �������*/                     
        wload.deduct                                /* Deduct  */                     
        wload.fleetper                              /* fleet   */                     
        wload.ncbper                                /* ncb     */
        wload.othper                                /* other   */                     
        wload.cctvper                               /* cctv    */ 
        wload.driver                                /* �кؼ��Ѻ���    */            
        wload.drivename1                            /* ���ͼ��Ѻ���1   */    
        wload.driveno1                              /* �Ţ�ѵü��Ѻ���1*/            
        wload.occupdriv1                            /* �Ҫվ���Ѻ���1  */            
        wload.sexdriv1                              /* �ȼ��Ѻ���1    */            
        IF wload.bdatedriv1 <> "" THEN STRING(DATE(wload.bdatedriv1),"99/99/9999") ELSE "" /* �ѹ�Դ���Ѻ���1*/            
        wload.drivename2                            /* ���ͼ��Ѻ���2   */                 
        wload.driveno2                              /* �Ţ�ѵü��Ѻ���2*/          
        wload.occupdriv2                            /* �Ҫվ���Ѻ���2  */            
        wload.sexdriv2                              /* �ȼ��Ѻ���2    */            
        IF wload.bdatedriv2 <> "" THEN STRING(DATE(wload.bdatedriv2),"99/99/9999") ELSE "" /* �ѹ�Դ���Ѻ���2*/            
        wtxt.acc1                                   /* �ػ�ó쵡��1   */            
        wtxt.accdetail1                             /* ��������´�ػ�ó�1*/           
        wtxt.accprice1                              /* �Ҥ��ػ�ó�1  */               
        wtxt.acc2                                   /* �ػ�ó쵡��2*/               
        wtxt.accdetail2                             /* ��������´�ػ�ó�2*/           
        wtxt.accprice2                              /* �Ҥ��ػ�ó�2  */               
        wtxt.acc3                                   /* �ػ�ó쵡��3*/               
        wtxt.accdetail3                             /* ��������´�ػ�ó�3*/           
        wtxt.accprice3                              /* �Ҥ��ػ�ó�3  */               
        wtxt.acc4                                   /* �ػ�ó쵡��4*/               
        wtxt.accdetail4                             /* ��������´�ػ�ó�4*/           
        wtxt.accprice4                              /* �Ҥ��ػ�ó�4  */               
        wtxt.acc5                                   /* �ػ�ó쵡��5*/               
        wtxt.accdetail5                             /* ��������´�ػ�ó�5*/           
        wtxt.accprice5                              /* �Ҥ��ػ�ó�5  */               
        wtxt.inspdate                               /* �ѹ����Ǩ��Ҿ*/               
        wtxt.inspdate_app                           /* �ѹ���͹��ѵԼš�õ�Ǩ*/       
        wtxt.inspsts                                /* �š�õ�Ǩ��Ҿ*/                
        wtxt.inspdetail                             /* ��������´��õ�Ǩ��Ҿ*/        
        wtxt.not_date                               /* �ѹ�����*/                    
        wtxt.paydate                                /* �ѹ����Ѻ�����Թ*/            
        wtxt.paysts                                 /* ʶҹС�è���*/                 
        wtxt.licenBroker                            /* �Ţ����͹حҵ���˹��*/        
        wtxt.brokname                               /* ���͹��˹�� */                 
        wtxt.brokcode                               /* ���ʹ��˹�� */                 
        wtxt.lang                                   /* ����        */                 
        wtxt.deli                                   /* ��èѴ�觡�������   */         
        wtxt.delidetail                             /* ��������´��èѴ�� */         
        wtxt.gift                                   /* �ͧ��  */                     
        wtxt.remark                                 /* �����˵�*/                     
        wtxt.insno                                   /* �Ţ��Ǩ��Ҿ */      
        wtxt.resultins                               /* �š�õ�Ǩ */   
        wtxt.damage1                                 /* �����������1 */ 
        wtxt.damage2                                 /* �����������2 */
        wtxt.damage3                                 /* �����������3 */   
        wtxt.dataoth     .                           /* ���������� */  


END. 
 MESSAGE "export"  n_cedcode  n_covtyp       
n_inscode  
     VIEW-AS ALERT-BOX.
                                                         
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_impmatpol1 C-Win 
PROCEDURE proc_impmatpol1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH  wload :
    DELETE  wload.
END.
FOR EACH  wtxt :
    DELETE  wtxt.
END.
RUN Proc_Cleardata.
INPUT FROM VALUE(fi_loadName).
REPEAT:
    IMPORT DELIMITER "|"
        n_cmr_code               /*���ʺ���ѷ */ 
        n_comp_code              /*���ͺ���ѷ */ 
        n_campcode               /*��໭�ͧ sCB*/ 
        n_campname               /*������໭ SCB */ 
        n_procode                /*��໭ ������� */ 
        n_proname                /*������໭ */ 
        n_packname               /*����ᾤ�� */ 
        n_packcode               /*����ᾤ�� */ 
        n_instype                /*�������١��� */ 
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
        n_addr1_70              /*�Ţ����ҹ   */  
        n_addr2_70              /*�����ҹ     */ 
        n_addr3_70              /*����         */ 
        n_addr4_70              /*���          */ 
        n_addr5_70              /*���          */ 
        n_nsub_dist70           /*�����ǧ     */ 
        n_ndirection70          /*ࢵ/�����    */ 
        n_nprovin70             /*�ѧ��Ѵ      */ 
        n_zipcode70             /*������ɳ��� */ 
        n_addr1_72              /*�Ţ����ҹ   �Ѵ�� */ 
        n_addr2_72              /*�����ҹ     �Ѵ�� */ 
        n_addr3_72              /*����         �Ѵ�� */ 
        n_addr4_72              /*���          �Ѵ�� */ 
        n_addr5_72              /*���          �Ѵ�� */ 
        n_nsub_dist72           /*�����ǧ     �Ѵ�� */ 
        n_ndirection72          /*ࢵ/�����    �Ѵ�� */ 
        n_nprovin72             /*�ѧ��Ѵ      �Ѵ�� */ 
        n_zipcode72             /*������ɳ��� �Ѵ�� */ 
        n_paytype               
        n_paytitle              
        n_payname               
        n_paylname              
        n_payicno               
        n_payaddr1              /*�Ţ����ҹ   �����Թ */      
        n_payaddr2              /*�����ҹ     �����Թ */   
        n_payaddr3              /*����         �����Թ */   
        n_payaddr4              /*���          �����Թ */   
        n_payaddr5              /*���          �����Թ */   
        n_payaddr6              /*�����ǧ     �����Թ */   
        n_payaddr7              /*ࢵ/�����    �����Թ */   
        n_payaddr8              /*�ѧ��Ѵ      �����Թ */   
        n_payaddr9              /*������ɳ��� �����Թ */   
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
        n_paydate      
        n_paysts       
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
        n_Agent_Code       /*Kridtiya i. A64-0295 DATE. 25/07/2021 */ 
        n_Agent_NameTH     /*Kridtiya i. A64-0295 DATE. 25/07/2021 */ 
        n_Agent_NameEng    /*Kridtiya i. A64-0295 DATE. 25/07/2021 */ 
        n_Selling_Channel. /*Kridtiya i. A64-0295 DATE. 25/07/2021 */ 
       IF n_cmr_code  = "" THEN  NEXT.
       ELSE IF INDEX(n_cmr_code,"Insurer") <> 0 THEN NEXT.
       ELSE DO:
           RUN proc_create.
           RUN proc_cleardata.
       END.
END.  /* repeat  */ 
   
Run Proc_reportloadgw.
Message "Export data Complete"  View-as alert-box.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_impmatpol2 C-Win 
PROCEDURE proc_impmatpol2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
INPUT FROM VALUE (fi_loadname) .  /*create in TEMP-TABLE wImport*/
    REPEAT:    
        CREATE wload.
        CREATE wtxt.
        IMPORT DELIMITER "|" 
            n_poltyp                                                            
            n_cedcode                                                                                               
            n_inscode                                                                                               
            n_campcode                                                                                              
            n_campname                                                                                              
            n_procode                                                                                               
            n_proname                                                                                               
            n_packname                                                                                              
            n_packcode
            n_prepol
            n_instype                                                                                               
            n_pol_title                                                                                             
            n_pol_fname                                                                    
            n_pol_title_eng                                                                                         
            n_pol_fname_eng                                                          
            n_icno                                                                                                  
            n_bdate                                                                          
            n_occup                                                                                                 
            n_tel                                                  
            n_mail                                                                                                  
            n_addr1_70                                                                   
            n_addr2_70                                                                   
            n_addr3_70                                                                   
            n_addr4_70                                                                  
            n_addr1_72                                                                                     
            n_addr2_72                                                                                     
            n_addr3_72                                                                                              
            n_addr4_72                                                                 
            n_paytype                                                                                               
            n_paytitle                                                                                              
            n_payname
            n_payicno  
            n_payaddr1 
            n_payaddr2 
            n_payaddr3 
            n_payaddr4 
            n_branch                                                                                                
            n_ben_name                                          
            n_pmentcode                                                                                             
            n_pmenttyp                                                                                              
            n_pmentcode1                                                                                            
            n_pmentcode2                                                                                            
            n_pmentbank                                                                                             
            n_pmentdate                                                                      
            n_pmentsts                                                                                              
            n_brand                                                                                                 
            n_Model                                                                                                 
            n_body                                                                                                  
            n_licence                                                                                               
            n_province                                                                                              
            n_chassis                                                                                               
            n_engine                                                                                                
            n_yrmanu                                                                                                
            n_seatenew                                                                                              
            n_power                                                                                                 
            n_weight                                                                                                
            n_class                                                                                                 
            n_garage                                                                                                
            n_colorcode                                                                                             
            n_covcod                                                                                                
            n_covtyp                                                                                                
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
            n_ncbper                
            n_othper                                 
            n_cctvper                                                                              
            n_driver                                                                                         
            n_drivename1                                       
            n_driveno1                                                                                              
            n_occupdriv1                                                                                            
            n_sexdriv1                                                                                              
            n_bdatedriv1                                                                
            n_drivename2                                   
            n_driveno2                                                                                              
            n_occupdriv2                                                                                            
            n_sexdriv2                                                                                              
            n_bdatedriv2                                                             
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
            n_ispno                 /*-- Add By Tontawan S. A66-0006 "�Ţ��Ǩö" ISP --*/
            n_inspsts                                                                                                 
            n_inspdetail                                                                                              
            n_not_date                                                                          
            n_paydate                                                                        
            n_paysts                                                                                                 
            n_licenBroker                                                                                              
            n_brokname                                                                                                
            n_brokcode                                                                                                
            n_lang                                                                                                    
            n_deli                                                                                                    
            n_delidetail                                                                                              
            n_gift                                                                                                    
            n_remark
            n_insno    
            n_resultins
            n_damage1  
            n_damage2  
            n_damage3  
            n_dataoth 
            n_sellcode              /*-- " ������ "          --*/ //Add Tontawan S. A66-0006 24/05/2023 
            n_sellname              /*-- " ������ "          --*/
            n_selling_ch            /*-- " ��ͧ�ҧ��â�� "    --*/
            n_branch_c              /*-- " �����Ң� "         --*/
            n_campaign              /*-- " ��໭ "           --*/
            n_person                /*-- " Per Person (BI) "  --*/
            n_peracc                /*-- " Per Accident "     --*/
            n_perpd                 /*-- " Per Accident(PD) " --*/
            n_si411                 /*-- " 411 SI. "          --*/
            n_si412                 /*-- " 412 Sum "          --*/
            n_si43                  /*-- " 43  Sum " .        --*/ //End Tontawan S. A66-0006 24/05/2023
            n_drv3_salutation_M     // ���Ѻ 3 : �ӹ�˹��          //Add Tontawan S. A68-0059 27/03/2025     
            n_drv3_fname            // ���Ѻ 3 : ����             
            n_drv3_lname            // ���Ѻ 3 : ���ʡ��          
            n_drv3_nid              // ���Ѻ 3 : �Ţ�ѵû�ЪҪ�   
            n_drv3_occupation       // ���Ѻ 3 : �Ҫվ            
            n_drv3_gender           // ���Ѻ 3 : ��              
            n_drv3_birthdate        // ���Ѻ 3 : �ѹ�Դ          
            n_drv4_salutation_M     // ���Ѻ 4 : �ӹ�˹��         
            n_drv4_fname            // ���Ѻ 4 : ����             
            n_drv4_lname            // ���Ѻ 4 : ���ʡ��          
            n_drv4_nid              // ���Ѻ 4 : �Ţ�ѵû�ЪҪ�   
            n_drv4_occupation       // ���Ѻ 4 : �Ҫվ            
            n_drv4_gender           // ���Ѻ 4 : ��              
            n_drv4_birthdate        // ���Ѻ 4 : �ѹ�Դ          
            n_drv5_salutation_M     // ���Ѻ 5 : �ӹ�˹��         
            n_drv5_fname            // ���Ѻ 5 : ����             
            n_drv5_lname            // ���Ѻ 5 : ���ʡ��          
            n_drv5_nid              // ���Ѻ 5 : �Ţ�ѵû�ЪҪ�   
            n_drv5_occupation       // ���Ѻ 5 : �Ҫվ            
            n_drv5_gender           // ���Ѻ 5 : ��              
            n_drv5_birthdate        // ���Ѻ 5 : �ѹ�Դ          
            n_drv1_dlicense         // ���Ѻ 1 : ����¹ö        
            n_drv2_dlicense         // ���Ѻ 2 : ����¹ö        
            n_drv3_dlicense         // ���Ѻ 3 : ����¹ö        
            n_drv4_dlicense         // ���Ѻ 4 : ����¹ö        
            n_drv5_dlicense         // ���Ѻ 5 : ����¹ö        
            n_baty_snumber          // Battery : Serial Number    
            n_batydate              // Battery : Year             
            n_baty_rsi              // Battery : Replacement SI   
            n_baty_npremium         // Battery : Net Premium      
            n_baty_gpremium         // Battery : Gross_Premium    
            n_wcharge_snumber       // Wall Charge : Serial_Number
            n_wcharge_si            // Wall Charge : SI           
            n_wcharge_npremium      // Wall Charge : Net Premium  
            n_wcharge_gpremium.     // Wall Charge : Gross Premium //End Tontawan S. A68-0059 27/03/2025

        IF INDEX(n_poltyp,"������") <> 0 THEN NEXT.
        ELSE IF n_poltyp = "" THEN NEXT.
        ELSE DO: 
            RUN proc_assign.
            RUN proc_cleardata.
        END.
    END.
    
    RUN proc_chkwload.
    RUN proc_reportpolicy.
    MESSAGE "Export data Complete"  VIEW-AS ALERT-BOX.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_impmatpol2-OLD C-Win 
PROCEDURE proc_impmatpol2-OLD :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR np_expdat AS CHAR FORMAT "x(15)".
DEF VAR np_year AS INT INIT 0.
INPUT FROM VALUE (fi_loadname) .  /*create in TEMP-TABLE wImport*/
    REPEAT:    
        CREATE wload.
        CREATE wtxt.
        IMPORT DELIMITER "|" 
            n_poltyp                                                            
            n_cedcode                                                                                               
            n_inscode                                                                                               
            n_campcode                                                                                              
            n_campname                                                                                              
            n_procode                                                                                               
            n_proname                                                                                               
            n_packname                                                                                              
            n_packcode
            n_prepol
            n_instype                                                                                               
            n_pol_title                                                                                             
            n_pol_fname                                                                    
            n_pol_title_eng                                                                                         
            n_pol_fname_eng                                                          
            n_icno                                                                                                  
            n_bdate                                                                          
            n_occup                                                                                                 
            n_tel                                                  
            n_mail                                                                                                  
            n_addr1_70                                                                   
            n_addr2_70                                                                   
            n_addr3_70                                                                   
            n_addr4_70                                                                  
            n_addr1_72                                                                                     
            n_addr2_72                                                                                     
            n_addr3_72                                                                                              
            n_addr4_72                                                                 
            n_paytype                                                                                               
            n_paytitle                                                                                              
            n_payname
            n_payicno  
            n_payaddr1 
            n_payaddr2 
            n_payaddr3 
            n_payaddr4 
            n_branch                                                                                                
            n_ben_name                                          
            n_pmentcode                                                                                             
            n_pmenttyp                                                                                              
            n_pmentcode1                                                                                            
            n_pmentcode2                                                                                            
            n_pmentbank                                                                                             
            n_pmentdate                                                                      
            n_pmentsts                                                                                              
            n_brand                                                                                                 
            n_Model                                                                                                 
            n_body                                                                                                  
            n_licence                                                                                               
            n_province                                                                                              
            n_chassis                                                                                               
            n_engine                                                                                                
            n_yrmanu                                                                                                
            n_seatenew                                                                                              
            n_power                                                                                                 
            n_weight                                                                                                
            n_class                                                                                                 
            n_garage                                                                                                
            n_colorcode                                                                                             
            n_covcod                                                                                                
            n_covtyp                                                                                                
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
            n_ncbper                
            n_othper                                 
            n_cctvper                                                                              
            n_driver                                                                                         
            n_drivename1                                       
            n_driveno1                                                                                              
            n_occupdriv1                                                                                            
            n_sexdriv1                                                                                              
            n_bdatedriv1                                                                
            n_drivename2                                   
            n_driveno2                                                                                              
            n_occupdriv2                                                                                            
            n_sexdriv2                                                                                              
            n_bdatedriv2                                                             
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
            n_ispno                 /*-- Add By Tontawan S. A66-0006 "�Ţ��Ǩö" ISP --*/
            n_inspsts                                                                                                 
            n_inspdetail                                                                                              
            n_not_date                                                                          
            n_paydate                                                                        
            n_paysts                                                                                                 
            n_licenBroker                                                                                              
            n_brokname                                                                                                
            n_brokcode                                                                                                
            n_lang                                                                                                    
            n_deli                                                                                                    
            n_delidetail                                                                                              
            n_gift                                                                                                    
            n_remark
            n_insno    
            n_resultins
            n_damage1  
            n_damage2  
            n_damage3  
            n_dataoth 
            /*-- Add BY Tontawan S. A66-0006 24/05/2023 --*/
            n_sellcode              /*-- " ������ "          --*/ 
            n_sellname              /*-- " ������ "          --*/
            n_selling_ch            /*-- " ��ͧ�ҧ��â�� "    --*/
            n_branch_c              /*-- " �����Ң� "         --*/
            n_campaign              /*-- " ��໭ "           --*/
            n_person                /*-- " Per Person (BI) "  --*/
            n_peracc                /*-- " Per Accident "     --*/
            n_perpd                 /*-- " Per Accident(PD) " --*/
            n_si411                 /*-- " 411 SI. "          --*/
            n_si412                 /*-- " 412 Sum "          --*/
            n_si43                  /*-- " 43  Sum " .        --*/
            /*-- End Add BY Tontawan S. A66-0006 24/05/2023 --*/
            .

        IF INDEX(n_poltyp,"������") <> 0 THEN NEXT.
        ELSE IF n_poltyp = "" THEN NEXT.
        ELSE DO: 
            RUN proc_assign.
            RUN proc_cleardata.
        END.
    END.
    FOR EACH wload .
       IF wload.poltyp  = "" THEN DELETE wload.
       ELSE DO:
           IF wload.poltyp = "V70" THEN DO:
               FOR EACH sicuw.uwm100 USE-INDEX uwm10002 WHERE sicuw.uwm100.cedpol = TRIM(wload.cedcode) NO-LOCK BREAK BY sicuw.uwm100.expdat DESCENDING.
                  IF sicuw.uwm100.poltyp <> "V70" THEN NEXT.
                  ELSE IF YEAR(sicuw.uwm100.expdat) <= YEAR(TODAY)  THEN NEXT.
                  ELSE DO:
                    ASSIGN np_expdat = ""
                           np_expdat = STRING(sicuw.uwm100.expdat,"99/99/9999").

                          /* Add By Tontawan S. 16/05/2023 */
                          IF wload.garage = "G" THEN wload.garage = "������ҧ". 
                          ELSE wload.garage = "�������".
                          /* End By Tontawan S. 16/05/2023 */

                          IF DATE(np_expdat) = DATE(wload.expdat) THEN DO:
                              ASSIGN  
                                  wload.policy   = sicuw.uwm100.policy 
                                  wload.producer = sicuw.uwm100.acno1 
                                  wload.agent    = sicuw.uwm100.agent .

                              /* Add By Tontawan S. 16/05/2023 */
                              FIND FIRST sicuw.uwm120 WHERE sicuw.uwm120.policy = sicuw.uwm100.policy NO-ERROR.
                              IF AVAIL sicuw.uwm120 THEN DO:
                                ASSIGN
                                    wload.tclass = sicuw.uwm120.CLASS.
                              END.
                              ELSE wload.tclass = "".
                              /* End By Tontawan S. 16/05/2023 */
                               
                              /*-- FIND LAST brstat.tlt USE-INDEX tlt05  WHERE -- Comment By Tontawan S. --*/ 
                                FIND LAST brstat.tlt USE-INDEX tlt06  WHERE  /*-- Add By Tontawan S. --*/ 
                                        brstat.tlt.cha_no  =  TRIM(wload.chassis) AND              
                                        brstat.tlt.genusr  =  "SCBPT"             AND 
                                        brstat.tlt.flag    =  "V70"               NO-ERROR NO-WAIT.     
                              IF AVAIL brstat.tlt THEN DO:
                                  ASSIGN 
                                     brstat.tlt.releas = "YES".
                                  IF brstat.tlt.policy = ""  THEN ASSIGN brstat.tlt.policy = wload.policy.
                              END.
                              RELEASE brstat.tlt.
                          END.
                          ELSE ASSIGN wload.policy  = "".
                  END.
               END.
               RELEASE sicuw.uwm100.
           END.
           IF wload.poltyp = "V72" THEN DO:
                  FOR EACH sicuw.uwm100 USE-INDEX uwm10002 WHERE sicuw.uwm100.cedpol = TRIM(wload.cedcode) NO-LOCK BREAK BY sicuw.uwm100.expdat DESCENDING. 
                        IF sicuw.uwm100.poltyp <> "V72" THEN NEXT.
                        ELSE IF YEAR(sicuw.uwm100.expdat) <= YEAR(TODAY)  THEN NEXT.
                        ELSE DO:
                            ASSIGN np_expdat     = ""
                                   np_expdat     = STRING(sicuw.uwm100.expdat,"99/99/9999")
                                   wload.garage  = "". /*-- Add By Tontawan S. A66-0006 16/05/2023 --*/

                            IF DATE(np_expdat) = DATE(wload.expdat) THEN DO:
                                ASSIGN  
                                    wload.policy    = sicuw.uwm100.policy 
                                    wload.producer  = sicuw.uwm100.acno1 
                                    wload.agent     = sicuw.uwm100.agent 
                                    nv_appen        = sicuw.uwm100.cr_2. /*-- Add By Tontawan S. A66-0006 --*/

                                /*-- Add By Tontawan S. A66-0006 --*/
                                FIND FIRST sicuw.uwm120 WHERE sicuw.uwm120.policy = sicuw.uwm100.policy NO-ERROR.
                                IF AVAIL sicuw.uwm120 THEN DO:
                                  ASSIGN
                                      wload.tclass = sicuw.uwm120.CLASS.
                                END.
                                ELSE wload.tclass = "".
                                /*-- End By Tontawan S. A66-0006 --*/

                                /*-- FIND LAST brstat.tlt USE-INDEX tlt05  WHERE -- Comment By Tontawan S. --*/ 
                                FIND LAST brstat.tlt USE-INDEX tlt06  WHERE /*-- Add By Tontawan S. --*/ 
                                          brstat.tlt.cha_no  =  TRIM(wload.chassis) AND              
                                          brstat.tlt.genusr  =  "SCBPT"             AND
                                          brstat.tlt.flag    =  "V72"               NO-ERROR NO-WAIT. 
                                IF AVAIL brstat.tlt THEN DO:
                                    ASSIGN brstat.tlt.releas = "YES".
                                    IF brstat.tlt.policy     = ""  THEN ASSIGN brstat.tlt.policy  = wload.policy.
                                END.
                                RELEASE brstat.tlt.
                            END.
                            ELSE ASSIGN wload.policy = "".
                        END.
                 END.

                 /*-- Add By Tontawan S. A66-0006 --*/
                 IF nv_appen <> "" THEN DO:
                     FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE sicuw.uwm100.policy = nv_appen NO-LOCK NO-ERROR NO-WAIT.
                     IF AVAIL sicuw.uwm100 THEN DO:
                         ASSIGN wload.producer = sicuw.uwm100.acno1.
                     END.
                 END.
                 /*-- End By Tontawan S. A66-0006 --*/
                 
                 RELEASE sicuw.uwm100.
           END.
       END. /* else do */
    END. /*wload */

RUN Proc_reportpolicy.

MESSAGE "Export data Complete"  VIEW-AS ALERT-BOX.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_reportloadgw C-Win 
PROCEDURE proc_reportloadgw :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
If  substr(fi_outload,length(fi_outload) - 3,4) <>  ".CSV"  THEN 
    fi_outload  =  Trim(fi_outload) + ".CSV"  .
ASSIGN nv_cnt =  0
       nv_row  =  1.
OUTPUT TO VALUE(fi_outload).
EXPORT DELIMITER "|" 
   " ��������������" 
   " ������ҧ�ԧ   "
   " �����١���    "
   " ������໭    "
   " ������໭    "
   " ���ʼ�Ե�ѳ�� "
   " ���ͼ�Ե�ѳ�� "
   " ����ᾤ��   "
   " ����ᾤ��   "
   " �����������  "
   " �����������һ�Сѹ "
   " �ӹ�˹�Ҫ��� �����һ�Сѹ "
   " ���� �����һ�Сѹ         "
   " �ӹ�˹�Ҫ��� �����һ�Сѹ (Eng) "
   " ���� �����һ�Сѹ (Eng)" 
   " �Ţ�ѵü����һ�Сѹ "
   " �ѹ�Դ�����һ�Сѹ "
   " �Ҫվ�����һ�Сѹ" 
   " �����ü����һ�Сѹ"
   " ����������һ�Сѹ  "
   " �������˹�ҵ��ҧ1" 
   " �������˹�ҵ��ҧ2" 
   " �������˹�ҵ��ҧ3" 
   " �������˹�ҵ��ҧ4" 
   " �������Ѵ�� 1  " 
   " �������Ѵ�� 2  " 
   " �������Ѵ�� 3  " 
   " �������Ѵ�� 4  " 
   " �������������Թ" 
   " �ӹ�˹�Ҫ��� �������Թ"
   " ���� �������Թ"
   " �Ţ��Шӵ�Ǽ����������"
   " ��������͡�����1"
   " ��������͡�����2"
   " ��������͡�����3"
   " ��������͡�����4"
   " �Ң�"
   " ����Ѻ�Ż���ª��  "
   " ���ʻ�������è��� "
   " ��������è��� "
   " ���ʪ�ͧ�ҧ��è���"
   " ��ͧ�ҧ��è���  "
   " ��Ҥ�÷�����" 
   " �ѹ������   " 
   " ʶҹС�è��� " 
   " ������  "  
   " ���    "  
   " Ẻ��Ƕѧ" 
   " ����¹ "
   " �ѧ��Ѵ����¹ "
   " �Ţ��Ƕѧ" 
   " �Ţ����ͧ " 
   " ��ö    "  
   " ����� "  
   " �ի�    "  
   " ���˹ѡ "  
   " ����ö  "  
   " ��ë��� "  
   " ��  "  
   " ��������û�Сѹ "
   " ���ʡ�û�Сѹ" 
   " �ѹ��������ͧ  "
   " �ѹ����������" 
   " �ع��Сѹ"
   " �����ط�ԡ�͹�ѡ��ǹŴ"
   " �����ط����ѧ�ѡ��ǹŴ"
   " �����  "
   " ����    "
   " �������"
   " Deduct  "
   " fleet   " 
   " ncb     " 
   " other   "   
   " cctv    "
   " �кؼ��Ѻ���    " 
   " ���ͼ��Ѻ���1   " 
   " �Ţ�ѵü��Ѻ���1" 
   " �Ҫվ���Ѻ���1  " 
   " �ȼ��Ѻ���1    " 
   " �ѹ�Դ���Ѻ���1" 
   " ���ͼ��Ѻ���2   " 
   " �Ţ�ѵü��Ѻ���2" 
   " �Ҫվ���Ѻ���2  " 
   " �ȼ��Ѻ���2    " 
   " �ѹ�Դ���Ѻ���2" 
   " �ػ�ó쵡��1   " 
   " ��������´�ػ�ó�1"
   " �Ҥ��ػ�ó�1  "
   " �ػ�ó쵡��2"
   " ��������´�ػ�ó�2"
   " �Ҥ��ػ�ó�2  "
   " �ػ�ó쵡��3"
   " ��������´�ػ�ó�3"
   " �Ҥ��ػ�ó�3  "
   " �ػ�ó쵡��4"
   " ��������´�ػ�ó�4"
   " �Ҥ��ػ�ó�4  "
   " �ػ�ó쵡��5"
   " ��������´�ػ�ó�5"
   " �Ҥ��ػ�ó�5  "
   " �ѹ����Ǩ��Ҿ"
   " �ѹ���͹��ѵԼš�õ�Ǩ"
   " �š�õ�Ǩ��Ҿ"
   " ��������´��õ�Ǩ��Ҿ"
   " �ѹ�����"
   " �ѹ����Ѻ�����Թ"
   " ʶҹС�è���"
   " �Ţ����͹حҵ���˹��"
   " ���͹��˹�� "
   " ���ʹ��˹�� "
   " ����        "
   " ��èѴ�觡�������   "
   " ��������´��èѴ�� "
   " �ͧ��  "
   " �����˵�" 
   " �Ţ��Ǩ��Ҿ "
   " �š�õ�Ǩ "
   " �����������1 "
   " �����������2 "
   " �����������3 "
   " ���������� " .

   RUN proc_detailreport.

OUTPUT CLOSE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_reportpolicy C-Win 
PROCEDURE proc_reportpolicy :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
If  substr(fi_outload,length(fi_outload) - 3,4) <>  ".CSV"  THEN 
    fi_outload  =  Trim(fi_outload) + ".CSV"  .

OUTPUT TO VALUE(fi_outload).

EXPORT DELIMITER "|" 
   "Producer"
   "Agent"
   " ��������������" 
   " ����������� "
   " ������ҧ�ԧ   "
   " �����١���    "
   " ������໭    "
   " ������໭    "
   " ���ʼ�Ե�ѳ�� "
   " ���ͼ�Ե�ѳ�� "
   " ����ᾤ��   "
   " ����ᾤ��   "
   " �����������  "
   " �����������һ�Сѹ "
   " �ӹ�˹�Ҫ��� �����һ�Сѹ "
   " ���� �����һ�Сѹ         "
   " �ӹ�˹�Ҫ��� �����һ�Сѹ "
   " ���� �����һ�Сѹ" 
   " �Ţ�ѵü����һ�Сѹ "
   " �ѹ�Դ�����һ�Сѹ "
   " �Ҫվ�����һ�Сѹ" 
   " �����ü����һ�Сѹ"
   " ����������һ�Сѹ  "
   " �������˹�ҵ��ҧ1" 
   " �������˹�ҵ��ҧ2" 
   " �������˹�ҵ��ҧ3" 
   " �������˹�ҵ��ҧ4" 
   " �������Ѵ�� 1  " 
   " �������Ѵ�� 2  " 
   " �������Ѵ�� 3  " 
   " �������Ѵ�� 4  " 
   " �������������Թ" 
   " �ӹ�˹�Ҫ��� �������Թ"
   " ���� �������Թ"
   " �Ţ��Шӵ�Ǽ����������"
   " ��������͡�����1"
   " ��������͡�����2"
   " ��������͡�����3"
   " ��������͡�����4"
   " �Ң�"
   " ����Ѻ�Ż���ª��  "
   " ���ʻ�������è��� "
   " ��������è��� "
   " ���ʪ�ͧ�ҧ��è���"
   " ��ͧ�ҧ��è���  "
   " ��Ҥ�÷�����" 
   " �ѹ������   " 
   " ʶҹС�è��� " 
   " ������  "  
   " ���    "  
   " Ẻ��Ƕѧ" 
   " ����¹"
   " �ѧ��Ѵ����¹"
   " �Ţ��Ƕѧ" 
   " �Ţ����ͧ " 
   " ��ö    "  
   " ����� "  
   " �ի�    "  
   " ���˹ѡ "  
   " ����ö  "  
   " ����ö¹��  "      /*-- Add By Tontawan S. A66-0006 16/05/2023 ---*/ 
   " ��ë��� "  
   " ��  "  
   " ��������û�Сѹ "
   " ���ʡ�û�Сѹ" 
   " �ѹ��������ͧ  "
   " �ѹ����������" 
   " �ع��Сѹ"
   " �����ط��"         /*-- Add By Tontawan S. A66-0006 16/05/2023 ---*/
   /*" �����ط����ѧ�ѡ��ǹŴ" -- Comment By Tontawan S. 16/05/2023 ---*/
   " �����  "
   " ����    "
   " �������"
   " Deduct  "
   " fleet   " 
   " ncb     " 
   " other   "   
   " cctv    "
   " �кؼ��Ѻ���    " 
   " ���ͼ��Ѻ���1   " 
   " �Ţ�ѵü��Ѻ���1" 
   " �Ҫվ���Ѻ���1  " 
   " �ȼ��Ѻ���1    " 
   " �ѹ�Դ���Ѻ���1" 
   " ���ͼ��Ѻ���2   " 
   " �Ţ�ѵü��Ѻ���2" 
   " �Ҫվ���Ѻ���2  " 
   " �ȼ��Ѻ���2    " 
   " �ѹ�Դ���Ѻ���2" 
   " �ػ�ó쵡��1   " 
   " ��������´�ػ�ó�1"
   " �Ҥ��ػ�ó�1  "
   " �ػ�ó쵡��2"
   " ��������´�ػ�ó�2"
   " �Ҥ��ػ�ó�2  "
   " �ػ�ó쵡��3"
   " ��������´�ػ�ó�3"
   " �Ҥ��ػ�ó�3  "
   " �ػ�ó쵡��4"
   " ��������´�ػ�ó�4"
   " �Ҥ��ػ�ó�4  "
   " �ػ�ó쵡��5"
   " ��������´�ػ�ó�5"
   " �Ҥ��ػ�ó�5  "
   " �ѹ����Ǩ��Ҿ"
   " �ѹ���͹��ѵԼš�õ�Ǩ"
   " �Ţ��Ǩö" /*--- Add By Tontawan S. A66-0006 --*/
   " �š�õ�Ǩ��Ҿ"
   " ��������´��õ�Ǩ��Ҿ"
   " �ѹ�����"
   " �ѹ����Ѻ�����Թ"
   " ʶҹС�è���"
   " �Ţ����͹حҵ���˹��"
   " ���͹��˹�� "
   " ���ʹ��˹�� "
   " ����        "
   " ��èѴ�觡�������   "
   " ��������´��èѴ�� "
   " �ͧ��  "
   " �����˵�" 
   " �Ţ��Ǩ��Ҿ "
   " �š�õ�Ǩ "
   " �����������1 "
   " �����������2 "
   " �����������3 "
   " ���������� " 
   " ������ "                                                  //Add By Tontawan S. A66-0006 17/05/2023
   " ������ "                                                  //
   " ��ͧ�ҧ��â�� "                                            //
   " �����Ң� "                                                 //
   " ��໭ "                                                   //
   " Per Person (BI) "                                          //
   " Per Accident "                                             //
   " Per Accident(PD) "                                         //
   " 411 SI. "                                                  //
   " 412 Sum "                                                  //
   " 43  Sum "                                                  //End By Tontawan S. A66-0006 17/05/2023
   " ���ͼ��Ѻ���3 "                                           //Add By Tontawan S. A68-0059 27/03/2025     
   " �Ţ�ѵü��Ѻ���3 "                                        //.
   " �Ҫվ���Ѻ���3 "                                          //.
   " �ȼ��Ѻ���3 "                                            //.
   " �ѹ�Դ���Ѻ���3 "                                        //.
   " ���ͼ��Ѻ���4 "                                           //.
   " �Ţ�ѵü��Ѻ���4 "                                        //.
   " �Ҫվ���Ѻ���4 "                                          //.
   " �ȼ��Ѻ���4 "                                            //.
   " �ѹ�Դ���Ѻ���4 "                                        //.
   " ���ͼ��Ѻ���5 "                                           //.
   " �Ţ�ѵü��Ѻ���5 "                                        //.
   " �Ҫվ���Ѻ���5 "                                          //.
   " �ȼ��Ѻ���5 "                                            //.
   " �ѹ�Դ���Ѻ���5 "                                        //.
   " �Ţ���㺢Ѻ��� ���Ѻ��� 1 "                               //.
   " �Ţ���㺢Ѻ��� ���Ѻ��� 2 "                               //.
   " �Ţ���㺢Ѻ��� ���Ѻ��� 3 "                               //.
   " �Ţ���㺢Ѻ��� ���Ѻ��� 4 "                               //.
   " �Ţ���㺢Ѻ��� ���Ѻ��� 5 "                               //.
   " �Ţ serial �ͧẵ����� "                                  //.
   " �ѹ���ͧẵ����� "                                       //.
   " �ع��Сѹ��¢ͧẵ�������������� "                     //.
   " ���»�Сѹ����ط�Ԣͧẵ����� "                          //.
   " ���»�Сѹ�������ͧẵ����� "                            //.
   " �Ţ serial �ͧ����ͧ����ö¹��俿��Ẻ�Դ��ѧ "          //.
   " �ع��Сѹ��¢ͧ����ͧ����ö¹��俿��Ẻ�Դ��ѧ "         //.
   " ���»�Сѹ����ط�Ԣͧ����ͧ����ö¹��俿��Ẻ�Դ��ѧ "  //.
   " ���»�Сѹ�������ͧ����ͧ����ö¹��俿��Ẻ�Դ��ѧ ".   //End By Tontawan S. A68-0059 27/03/2025
   RUN proc_detailpolicy.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

