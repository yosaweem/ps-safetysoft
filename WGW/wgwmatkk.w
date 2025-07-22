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
/* ***************************  Definitions  **************************     */
/* Parameters Definitions ---                                               */  
/*Local Variable Definitions ---                                            */   
/*Program name     : Match Text file KK to excel file                       */  
/*create by        : Kridtiya il. A54-0351  01/12/2011                      */  
/*                   Match file confirm to file Load Text �����excel     */  
/*DataBase connect : GW_SAFE -LD SIC_BRAN, GW_STAT -LD BRSTAT,SICSYAC,SICUW */ 
/*modify by        : Kridtiya i. A55-0029  ��Ѻ��������ʴ��Ţ�������� �ҡ��������ش����
                     ����ʴ���ͨҡ ������� �Ţ����������� */
/*modify by : Kridtiya i. A55-0055  ��Ѻ���ʶҹС�����������¹����;��Ţ����������ҹ��*/
/*Modify by : Ranu I. A61-0335 Date. 10/07/2018  ��������觡�Ѻ KK    */
/*Modify by : Kridtiya i. A63-0472 ���¢�Ҵ ��ͧ�Ѻ���                 */
/*Modify by : Ranu I. A64-0135 �������͹䢡�� Match Policy format new */
/*Modify by : Ranu I. A65-0288 ���������ŵ�Ǩ��Ҿ                     */
/*Modify by : Kridtiya i. A66-0140 chang index tlt05 to tlt06    */
/*Modify by : Ranu I. A67-0076 �������͹䢡���红�����ö俿�� */
/*--------------------------------------------------------------------------*/
DEF  stream  ns1.
DEFINE VAR   nv_daily        AS CHARACTER FORMAT "X(1024)"     INITIAL ""  NO-UNDO.
DEFINE VAR   nv_reccnt       AS  INT  INIT  0.
DEFINE VAR   nv_completecnt  AS   INT   INIT  0.
DEFINE VAR   nv_enttim       AS  CHAR          INIT  "".
def    var   nv_export       as  date  init  ""  format "99/99/9999".
def  stream  ns2.
DEFINE VAR   nv_file1        AS CHARACTER FORMAT "X(100)"     INITIAL ""  NO-UNDO.
DEFINE VAR   nv_file2        AS CHARACTER FORMAT "X(100)"     INITIAL ""  NO-UNDO.

DEF VAR   nv_cnt   as  int  init   1.
DEF VAR   nv_row   as  int  init   0.
DEF VAR   n_record AS  INTE INIT   0.
/*--------------------------����Ѻ�����š�������  -------------------------*/
DEFINE NEW SHARED TEMP-TABLE wdetail
    FIELD recodno        AS CHAR FORMAT "X(10)"  INIT ""  /*  0     */     
    FIELD Notify_dat     AS CHAR FORMAT "X(15)"  INIT ""  /*  1  �ѹ����Ѻ��   */                        
    FIELD recive_dat     AS CHAR FORMAT "X(15)"  INIT ""  /*  2  �ѹ����Ѻ�Թ������»�Сѹ */            
    FIELD comp_code      AS CHAR FORMAT "X(60)"  INIT ""  /*  3  ��ª��ͺ���ѷ��Сѹ���  */                
    FIELD cedpol         AS CHAR FORMAT "X(20)"  INIT ""  /*  4  �Ţ����ѭ����ҫ��� */                    
    FIELD prepol         AS CHAR FORMAT "X(16)"  INIT ""  /*  5  �Ţ�������������  */                    
    FIELD cmbr_no        AS CHAR FORMAT "X(25)"  INIT ""  /*  6  �����Ң�    */                            
    FIELD cmbr_code      AS CHAR FORMAT "X(35)"  INIT ""  /*  7  �Ң� KK */                                
    FIELD notifyno       AS CHAR FORMAT "X(20)"  INIT ""  /*  8  �Ţ�Ѻ��� */                            
    FIELD campaigno      AS CHAR FORMAT "X(30)"  INIT ""  /*  9  Campaign    */                            
    FIELD campaigsub     AS CHAR FORMAT "X(30)"  INIT ""  /*  10 Sub Campaign    */                        
    FIELD typper         AS CHAR FORMAT "X(20)"  INIT ""  /*  11 �ؤ��/�ԵԺؤ�� */                        
    FIELD n_TITLE        AS CHAR FORMAT "X(20)"  INIT ""  /*  12 �ӹ�˹�Ҫ���    */                        
    FIELD n_name1        AS CHAR FORMAT "X(40)"  INIT ""  /*  13 ���ͼ����һ�Сѹ    */                    
    FIELD n_name2        AS CHAR FORMAT "X(40)"  INIT ""  /*  14 ���ʡ�ż����һ�Сѹ */                    
    FIELD ADD_1          AS CHAR FORMAT "X(100)"  INIT ""  /*  15 ��ҹ�Ţ���  */                            
    FIELD ADD_2          AS CHAR FORMAT "X(35)"  INIT ""   /*  16 ����    */                                
    FIELD ADD_3          AS CHAR FORMAT "X(35)"  INIT ""  /*  17 �����ҹ    */                            
    FIELD ADD_4          AS CHAR FORMAT "X(35)"  INIT ""  /*  18 �Ҥ��   */                                
    FIELD ADD_5          AS CHAR FORMAT "X(35)"  INIT ""  /*  19 ��� */                                    
    FIELD cover          AS CHAR FORMAT "X(20)"  INIT ""  /*  25 ����������������ͧ  */                    
    FIELD garage         AS CHAR FORMAT "X(20)"  INIT ""  /*  26 ��������ë���   */                        
    FIELD comdat         AS CHAR FORMAT "X(15)"  INIT ""  /*  27 �ѹ�����������ͧ    */                    
    FIELD expdat         AS CHAR FORMAT "X(15)"  INIT ""  /*  28 �ѹ����ش������ͧ  */                    
    FIELD subclass       AS CHAR FORMAT "X(20)"  INIT ""  /*  29 ����ö  */                                
    FIELD n_43           AS CHAR FORMAT "X(50)"  INIT ""  /*  30 ��������Сѹ���ö¹��   */                
    FIELD brand          AS CHAR FORMAT "X(20)"  INIT ""  /*  31 ����������ö    */                        
    FIELD model          AS CHAR FORMAT "X(50)"  INIT ""  /*  32 ���ö  */                                
    FIELD nSTATUS        AS CHAR FORMAT "X(10)"  INIT ""  /*  33 New/Used    */                            
    FIELD licence        AS CHAR FORMAT "X(45)"  INIT ""  /*  34 �Ţ����¹  */                            
    FIELD chassis        AS CHAR FORMAT "X(30)"  INIT ""  /*  35 �Ţ��Ƕѧ   */                            
    FIELD engine         AS CHAR FORMAT "X(30)"  INIT ""  /*  36 �Ţ����ͧ¹��  */                        
    FIELD cyear          AS CHAR FORMAT "X(10)"  INIT ""  /*  37 ��ö¹��    */                            
    FIELD power          AS CHAR FORMAT "X(10)"  INIT ""  /*  38 �ի�    */                                
    FIELD weight         AS CHAR FORMAT "X(10)"  INIT ""  /*  39 ���˹ѡ/�ѹ */   
    FIELD seat           AS CHAR FORMAT "X(2)"   INIT ""  /*  ����� */   
    FIELD ins_amt1       AS CHAR FORMAT "X(20)"  INIT ""  /*  40 �ع��Сѹ�� 1   */                        
    FIELD prem1          AS CHAR FORMAT "X(20)"  INIT ""  /*  41 ����������������ҡû� 1    */            
    FIELD ins_amt2       AS CHAR FORMAT "X(20)"  INIT ""  /*  42 �ع��Сѹ�� 2   */                        
    FIELD prem2          AS CHAR FORMAT "X(20)"  INIT ""  /*  43 ����������������ҡû� 2    */ 
    FIELD fi             AS CHAR FORMAT "X(20)"  INIT ""  /*  �٭�������� A61-0335 */     
    FIELD time_notify    AS CHAR FORMAT "X(10)"  INIT ""  /*  44 �����Ѻ���    */                        
    FIELD NAME_mkt       AS CHAR FORMAT "X(50)"  INIT ""  /*  45 �������˹�ҷ�� MKT */                    
    /*FIELD bennam         AS CHAR FORMAT "X(50)"  INIT ""  /*  46 �����˵�    */ */  /*kridtiya i.  A55-0240 */
    FIELD bennam         AS CHAR FORMAT "X(350)"  INIT ""  /*  46 �����˵�    */      /*kridtiya i.  A55-0240 */
/*47*/  FIELD drivno1        AS CHAR FORMAT "X(60)"  INIT ""  /*  47 ���Ѻ����� 1 �����ѹ�Դ  */            
/*48*/  FIELD drivno2        AS CHAR FORMAT "X(60)"  INIT ""  /*  48 ���Ѻ����� 2 �����ѹ�Դ  */            
/*49*/  FIELD reci_title     AS CHAR FORMAT "X(20)"  INIT ""  /*  49 �ӹ�˹�Ҫ��� (�����/㺡ӡѺ����)  */    
/*50*/  FIELD reci_name1     AS CHAR FORMAT "X(40)"  INIT ""  /*  50 ���� (�����/㺡ӡѺ����)  */            
/*51*/  FIELD reci_name2     AS CHAR FORMAT "X(40)"  INIT ""  /*  51 ���ʡ�� (�����/㺡ӡѺ����)   */        
/*54*/  FIELD reci_1         AS CHAR FORMAT "X(35)"  INIT ""  /*  54 �Ҥ�� (�����/㺡ӡѺ����) */            
/*55*/  FIELD reci_2         AS CHAR FORMAT "X(35)"  INIT ""  /*  55 ��� (�����/㺡ӡѺ����)   */            
/*56*/  FIELD reci_3         AS CHAR FORMAT "X(35)"  INIT ""  /*  56 ��� (�����/㺡ӡѺ����)   */            
/*57*/  FIELD reci_4         AS CHAR FORMAT "X(35)"  INIT ""  /*  57 �Ӻ�/�ǧ (�����/㺡ӡѺ����) */        
/*58*/  FIELD reci_5         AS CHAR FORMAT "X(35)"  INIT ""  /*  58 �����/ࢵ (�����/㺡ӡѺ����) */        
/*59*/  FIELD ncb            AS CHAR FORMAT "X(10)"  INIT ""  /*  61 ��ǹŴ����ѵԴ� */                          
        FIELD fleet          AS CHAR FORMAT "X(10)"  INIT ""  /*  62  ��ǹŴ�ҹ Fleet */ 
        /*-- A61-0335 --*/
        field phone         as char format "x(25)" init ""   /*����Դ���      */
        field icno          as char format "x(15)" init ""   /*�Ţ���ѵû�ЪҪ�           */
        FIELD bdate         AS CHAR FORMAT "X(15)" INIT ""   /*�ѹ��͹���Դ              */
        field tax           as char format "x(15)" init ""   /*�Ҫվ                       */
        field cstatus       as char format "x(20)" init ""   /*ʶҹ�Ҿ                     */
        field occup         as char format "x(45)" init ""   /*�Ţ��Шӵ�Ǽ�����������ҡ�  */
        field icno3         as char format "x(15)" init ""   /*�ӹ�˹�Ҫ��� 1              */
        field lname3        as char format "x(45)" init ""   /*���͡������ 1               */
        field cname3        as char format "x(45)" init ""   /*���ʡ�š������ 1            */
        field tname3        as char format "x(20)" init ""   /*�Ţ���ѵû�ЪҪ�������� 1  */
        field icno2         as char format "x(15)" init ""   /*�ӹ�˹�Ҫ��� 2              */
        field lname2        as char format "x(45)" init ""   /*���͡������ 2               */
        field cname2        as char format "x(45)" init ""   /*���ʡ�š������ 2            */
        field tname2        as char format "x(20)" init ""   /*�Ţ���ѵû�ЪҪ�������� 2  */
        field icno1         as char format "x(15)" init ""   /*�ӹ�˹�Ҫ��� 3              */
        field lname1        as char format "x(45)" init ""   /*���͡������ 3               */
        field cname1        as char format "x(45)" init ""   /*���ʡ�š������ 3            */
        field tname1        as char format "x(20)" init ""   /*�Ţ���ѵû�ЪҪ�������� 3  */
        /*field nsend         as char format "x(50)" init ""  -- A64-0135-- */ /*�Ѵ���͡��÷���Ң�         */
        field nsend         as char format "x(150)" init ""   /*�Ѵ���͡��÷���Ң�         */
        field sendname      as char format "x(100)" init ""  /*���ͼ���Ѻ�͡���            */
        field bennefit      as char format "x(100)" init ""  /*����Ѻ�Ż���ª��            */
        field KKapp         as char format "x(25)" init ""  /*KKApplicationNo.            */
        /*-- end A61-0335 --*/
        FIELD n_policy       AS CHAR FORMAT "x(15)"  INIT "" 
        /* A64-0135 */
        field typpol     as char format "x(35)" init "" 
        field kkflag     as char format "x(25)" init "" 
        field province   as char format "x(45)" init "" 
        field netprem    as char format "x(15)" init ""   
        field drivdat1   as char format "x(15)" init ""  
        field drivid1    as char format "x(15)" init "" 
        field drivdat2   as char format "x(15)" init ""  
        field drivid2    as char format "x(15)" init "" 
        field remak1     as char format "x(225)" init "" 
        field remak2     as char format "x(225)" init "" 
        field dealercd   as char format "x(50)" init "" 
        field packcod    as char format "x(15)" init "" 
        field campOV     as char format "x(15)" init "" 
        field producer   as char format "x(15)" init "" 
        field Agent      as char format "x(15)" init "" 
        field RefNo      as char format "x(25)" init ""        
        field KKQuo      as char format "x(25)" init "" 
        field RiderNo    as char format "x(25)" init "" 
        field releas     as char format "x(25)" init "" 
        field loandat    as char format "x(20)" init "" 
        FIELD Remark     AS CHAR FORMAT "X(200)" INIT ""
        FIELD brtms      AS CHAR FORMAT "x(50)"  INIT ""
        FIELD dealtms    AS CHAR FORMAT "x(10)"  INIT ""
        FIELD vatcode    AS CHAR FORMAT "x(10)"  INIT ""  
        field gender     as char format "x(50)"  init "" 
        field nation     as char format "x(50)"  init "" 
        field email      as char format "x(50)"  init "" 
        /* end A64-0135 */
        /* add by : A65-0288 */
        FIELD polpremium      AS CHAR FORMAT "x(12)" INIT ""
        FIELD probleam        AS CHAR FORMAT "x(255)" INIT "" 
        FIELD Colors          as char format "X(25)" init ""
        FIELD Inspection      as char format "X(2)" init ""
        field Insp_status     as char format "X(2)" init ""
        field Insp_No         as char format "X(15)" init ""
        field Insp_Closed     as char format "X(15)" init ""
        field Insp_Detail     as char format "X(150)" init ""
        field insp_Damage     as char format "X(250)" init ""
        field insp_Accessory  as char format "X(250)" init "" 
     /* A67-0076 */
    field hp            as char init ""   
    field drititle1     as char init ""   
    field drigender1    as char init ""   
    field drioccup1     as char init ""   
    field driToccup1    as char init ""   
    field driTicono1    as char init ""   
    field driICNo1      as char init "" 
    field drilevel1     as char init "" 
    field drititle2     as char init ""   
    field drigender2    as char init ""   
    field drioccup2     as char init ""   
    field driToccup2    as char init ""   
    field driTicono2    as char init ""   
    field driICNo2      as char init "" 
    field drilevel2     as char init "" 
    field drilic3       as char init ""   
    field drititle3     as char init ""   
    field driname3      as char init ""   
    field drivno3       as char init ""   
    field drigender3    as char init ""   
    field drioccup3     as char init ""   
    field driToccup3    as char init ""   
    field driTicono3    as char init ""   
    field driICNo3      as char init "" 
    field drilevel3     as char init "" 
    field drilic4       as char init ""   
    field drititle4     as char init ""   
    field driname4      as char init ""   
    field drivno4       as char init ""   
    field drigender4    as char init ""   
    field drioccup4     as char init ""   
    field driToccup4    as char init ""   
    field driTicono4    as char init ""   
    field driICNo4      as char init "" 
    field drilevel4     as char init "" 
    field drilic5       as char init ""   
    field drititle5     as char init ""   
    field driname5      as char init ""   
    field drivno5       as char init ""   
    field drigender5    as char init ""   
    field drioccup5     as char init ""   
    field driToccup5    as char init ""   
    field driTicono5    as char init ""   
    field driICNo5      as char init "" 
    field drilevel5     as char init "" 
    field dateregis     as char init ""   
    field pay_option    as char init ""   
    field battno        as char init ""   
    field battyr        as char init ""   
    field maksi         as char init ""   
    field chargno       as char init ""   
    field veh_key       as char init "" .
/* end A67-0076 */

DEF VAR nv_camp   AS CHAR FORMAT "x(100)" .
    /* end : A65-288 */

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS fi_filename fi_outfile bu_ok bu_exit bu_file ~
fi_outfile2 rs_type RECT-76 RECT-77 
&Scoped-Define DISPLAYED-OBJECTS fi_filename fi_outfile fi_outfile2 rs_type 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bu_exit 
     LABEL "Exit" 
     SIZE 7.5 BY 1.05
     FONT 6.

DEFINE BUTTON bu_file 
     LABEL "..." 
     SIZE 3.5 BY 1.05.

DEFINE BUTTON bu_ok 
     LABEL "Ok" 
     SIZE 7.5 BY 1.05
     FONT 6.

DEFINE VARIABLE fi_filename AS CHARACTER FORMAT "X(500)":U 
     VIEW-AS FILL-IN 
     SIZE 80 BY 1.05
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_outfile AS CHARACTER FORMAT "X(500)":U 
     VIEW-AS FILL-IN 
     SIZE 85 BY 1.05
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_outfile2 AS CHARACTER FORMAT "X(500)":U 
     VIEW-AS FILL-IN 
     SIZE 85 BY 1.05
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE rs_type AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "Old format", 1,
"New format", 2
     SIZE 79.83 BY 1.19
     BGCOLOR 19 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-76
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 110 BY 8.33
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-77
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 19.5 BY 1.57
     BGCOLOR 1 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     fi_filename AT ROW 3.95 COL 12.83 COLON-ALIGNED NO-LABEL
     fi_outfile AT ROW 5.14 COL 12.83 COLON-ALIGNED NO-LABEL
     bu_ok AT ROW 7.76 COL 61.83
     bu_exit AT ROW 7.76 COL 71.5
     bu_file AT ROW 3.95 COL 96.17
     fi_outfile2 AT ROW 6.29 COL 13 COLON-ALIGNED NO-LABEL WIDGET-ID 2
     rs_type AT ROW 2.67 COL 15.17 NO-LABEL WIDGET-ID 12
     "Input File :" VIEW-AS TEXT
          SIZE 12 BY 1.05 AT ROW 3.95 COL 2.5
          BGCOLOR 29 FGCOLOR 2 FONT 6
     "Output File :" VIEW-AS TEXT
          SIZE 12 BY 1.05 AT ROW 5.14 COL 2.5
          BGCOLOR 29 FGCOLOR 2 FONT 6
     "File Load Renew Match Policy New" VIEW-AS TEXT
          SIZE 30 BY 1.05 AT ROW 7.43 COL 25 WIDGET-ID 6
          BGCOLOR 19 FGCOLOR 6 FONT 1
     "  Match Text File Load (KK-Renew) to GW and Premium[Policy]" VIEW-AS TEXT
          SIZE 107.5 BY 1.38 AT ROW 1.19 COL 2.5
          BGCOLOR 18 FGCOLOR 2 FONT 2
     "Output KK :" VIEW-AS TEXT
          SIZE 12 BY 1.05 AT ROW 6.29 COL 2.67 WIDGET-ID 4
          BGCOLOR 29 FGCOLOR 2 FONT 6
     RECT-76 AT ROW 1.1 COL 1.17
     RECT-77 AT ROW 7.52 COL 60.5
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 111 BY 8.57
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
         TITLE              = "Match Text File Load (KK)"
         HEIGHT             = 8.67
         WIDTH              = 110.5
         MAX-HEIGHT         = 18.76
         MAX-WIDTH          = 172.33
         VIRTUAL-HEIGHT     = 18.76
         VIRTUAL-WIDTH      = 172.33
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
       bu_file:AUTO-RESIZE IN FRAME fr_main      = TRUE.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Match Text File Load (KK) */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Match Text File Load (KK) */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_exit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_exit C-Win
ON CHOOSE OF bu_exit IN FRAME fr_main /* Exit */
DO:
  Apply "Close" to this-procedure.
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
    DEF  VAR NO_add AS CHAR FORMAT "x(50)" .

   SYSTEM-DIALOG GET-FILE cvData
        TITLE      "Choose Data File to Import ..."
        FILTERS    /*"Text Documents" "*.txt",*/
                    "Text Documents" "*.csv",
                            "Data Files (*.*)"     "*.*"
                            
        MUST-EXIST
        USE-FILENAME
        UPDATE OKpressed.
      
    IF OKpressed = TRUE THEN DO:
         fi_filename  = cvData.
         ASSIGN 
         no_add =    STRING(MONTH(TODAY),"99")    + 
                     STRING(DAY(TODAY),"99")      + 
                     SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) + 
                     SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2) 
         fi_outfile  = SUBSTRING(cvData,1,(LENGTH(fi_filename) - 4)) + "_Pol" + no_add + ".slk" . /*.csv*/

         IF rs_type = 1 THEN fi_outfile2 = SUBSTRING(cvData,1,R-INDEX(fi_filename,"\")) + "FileSend_KKRenew_" + no_add + ".slk".
         ELSE fi_outfile2 = "" .
    END.
    DISP fi_filename fi_outfile fi_outfile2 WITH FRAME fr_main.



END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_ok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_ok C-Win
ON CHOOSE OF bu_ok IN FRAME fr_main /* Ok */
DO:
    nv_reccnt  =  0.
    For each  wdetail:
        DELETE  wdetail.
    END.
    IF rs_type = 1 THEN DO: /*A64-0135*/
        INPUT FROM VALUE (fi_filename) .   /*create in TEMP-TABLE wImport*/
        REPEAT:    
            CREATE wdetail.
            IMPORT DELIMITER "|" 
                wdetail.recodno
                wdetail.Notify_dat   /*1  �ѹ����Ѻ��   */                        
                wdetail.recive_dat   /*2  �ѹ����Ѻ�Թ������»�Сѹ */            
                wdetail.comp_code    /*3  ��ª��ͺ���ѷ��Сѹ���  */                
                wdetail.cedpol       /*4  �Ţ����ѭ����ҫ��� */                    
                wdetail.prepol       /*5  �Ţ�������������  */                    
                wdetail.cmbr_no      /*6  �����Ң�    */                            
                wdetail.cmbr_code    /*7  �Ң� KK */                                
                wdetail.notifyno     /*8  �Ţ�Ѻ��� */                            
                wdetail.campaigno    /*9  Campaign    */                            
                wdetail.campaigsub   /*10 Sub Campaign    */                        
                wdetail.typper       /*11 �ؤ��/�ԵԺؤ�� */                        
                wdetail.n_TITLE      /*12 �ӹ�˹�Ҫ���    */                        
                wdetail.n_name1      /*13 ���ͼ����һ�Сѹ    */                  
                wdetail.n_name2      /*14 ���ʡ�ż����һ�Сѹ */           
                wdetail.ADD_1        /*15 ��ҹ�Ţ���  */                          
                wdetail.ADD_2        /*21 �Ӻ�/�ǧ*/                     
                wdetail.ADD_3        /*22 �����/ࢵ*/                     
                wdetail.ADD_4        /*23 �ѧ��Ѵ*/                               
                wdetail.ADD_5        /*24 ������ɳ���*/                       
                wdetail.cover        /*  25 ����������������ͧ  */                    
                wdetail.garage       /*  26 ��������ë���   */                        
                wdetail.comdat       /*  27 �ѹ�����������ͧ    */                    
                wdetail.expdat       /*  28 �ѹ����ش������ͧ  */                    
                wdetail.subclass     /*  29 ����ö  */                                
                wdetail.n_43         /*  30 ��������Сѹ���ö¹��   */                
                wdetail.brand        /*  31 ����������ö    */                        
                wdetail.model        /*  32 ���ö  */                                
                wdetail.nSTATUS      /*  33 New/Used    */                            
                wdetail.licence      /*  34 �Ţ����¹  */                            
                wdetail.chassis      /*  35 �Ţ��Ƕѧ   */                            
                wdetail.engine       /*  36 �Ţ����ͧ¹��  */                        
                wdetail.cyear        /*  37 ��ö¹��    */                            
                wdetail.power        /*  38 �ի�    */                            
                wdetail.weight       /*  39 ���˹ѡ/�ѹ */                        
                wdetail.ins_amt1     /*  40 �ع��Сѹ�� 1   */                    
                wdetail.prem1        /*  41 ����������������ҡû� 1    */        
                wdetail.ins_amt2     /*  42 �ع��Сѹ�� 2   */                    
                wdetail.prem2        /*  43 ����������������ҡû� 2    */  
                wdetail.fi           /* �ع�٭�������� A61-0335 */           
                wdetail.time_notify  /*  44 �����Ѻ���    */                    
                wdetail.NAME_mkt     /*  45 �������˹�ҷ�� MKT */                
                wdetail.bennam       /*  46 �����˵�    */                        
                wdetail.drivno1      /*  47 ���Ѻ����� 1 �����ѹ�Դ        */ 
                wdetail.drivno2      /*  48 ���Ѻ����� 2 �����ѹ�Դ        */ 
                wdetail.reci_title   /*  49 �ӹ�˹�Ҫ��� (�����/㺡ӡѺ����)*/ 
                wdetail.reci_name1   /*  50 ���� (�����/㺡ӡѺ����)        */ 
                wdetail.reci_name2   /*  51 ���ʡ�� (�����/㺡ӡѺ����)     */ 
                wdetail.reci_1       /*  52 ��ҹ�Ţ��� (�����/㺡ӡѺ����)  */
                wdetail.reci_2       /*  57 �Ӻ�/�ǧ (�����/㺡ӡѺ����) */        
                wdetail.reci_3       /*  58 �����/ࢵ (�����/㺡ӡѺ����) */        
                wdetail.reci_4       /*  59 �ѧ��Ѵ (�����/㺡ӡѺ����)   */        
                wdetail.reci_5       /*  60 ������ɳ��� (�����/㺡ӡѺ����)*/    
                wdetail.ncb          /*  61 ��ǹŴ����ѵԴ� */                          
                wdetail.fleet       /*  62  ��ǹŴ�ҹ Fleet */ 
                /* A61-0335 */
                wdetail.phone         /*����Դ���                  */ 
                wdetail.icno          /*�Ţ���ѵû�ЪҪ�            */ 
                wdetail.bdate         /*�ѹ��͹���Դ               */ 
                wdetail.occup         /*�Ҫվ                        */ 
                wdetail.cstatus       /*ʶҹ�Ҿ                      */ 
                wdetail.tax           /*�Ţ��Шӵ�Ǽ�����������ҡ�   */ 
                wdetail.tname1        /*�ӹ�˹�Ҫ��� 1               */ 
                wdetail.cname1        /*���͡������ 1                */ 
                wdetail.lname1        /*���ʡ�š������ 1             */ 
                wdetail.icno1         /*�Ţ���ѵû�ЪҪ�������� 1   */ 
                wdetail.tname2        /*�ӹ�˹�Ҫ��� 2               */ 
                wdetail.cname2        /*���͡������ 2                */ 
                wdetail.lname2        /*���ʡ�š������ 2             */ 
                wdetail.icno2         /*�Ţ���ѵû�ЪҪ�������� 2   */ 
                wdetail.tname3        /*�ӹ�˹�Ҫ��� 3               */ 
                wdetail.cname3        /*���͡������ 3                */ 
                wdetail.lname3        /*���ʡ�š������ 3             */ 
                wdetail.icno3         /*�Ţ���ѵû�ЪҪ�������� 3   */ 
                wdetail.nsend         /*�Ѵ���͡��÷���Ң�          */ 
                wdetail.sendname      /*���ͼ���Ѻ�͡���             */ 
                wdetail.bennefit      /*����Ѻ�Ż���ª��             */ 
                wdetail.KKapp .       /*KKApplicationNo.             */ 
               /* end A61-0335 */
        END.    /* repeat  */
    END.
    ELSE DO: 
        RUN proc_assign. /*A64-0135*/
    END.
    FOR EACH wdetail.
        IF index(wdetail.recodno,"����ѷ") <> 0 THEN DELETE wdetail.
        ELSE IF index(wdetail.recodno,"�ӴѺ") <> 0 THEN DELETE wdetail.
    END.
    RUN  Pro_matchfile_prem.
    IF rs_type = 1 THEN DO:
        Run  Pro_createfile.
        RUN  pro_createfileKK. /*A61-0335*/
    END.
    ELSE DO:
        RUN proc_filenew .
    END.
    Message "Export data Complete"  View-as alert-box.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_filename
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_filename C-Win
ON LEAVE OF fi_filename IN FRAME fr_main
DO:
  fi_filename  =  Input  fi_filename.
  Disp  fi_filename  with frame  fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_outfile
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_outfile C-Win
ON LEAVE OF fi_outfile IN FRAME fr_main
DO:
  fi_outfile  =  Input  fi_outfile.
  Disp  fi_outfile  with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_outfile2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_outfile2 C-Win
ON LEAVE OF fi_outfile2 IN FRAME fr_main
DO:
  fi_outfile2  =  Input  fi_outfile2.
  Disp  fi_outfile2 with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME rs_type
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL rs_type C-Win
ON VALUE-CHANGED OF rs_type IN FRAME fr_main
DO:
  rs_type = INPUT rs_type.
  DISP rs_type WITH FRAME fr_main.
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
  
      gv_prgid = "WGWMATKK.W".
  gv_prog  = "Import Text && OUTPUT File Confirm (KK) to Excel".
  RUN  WUT\WUTHEAD ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).

/*********************************************************************/ 
   RUN Wut\WutwiCen ({&WINDOW-NAME}:HANDLE).  
  /*CURRENT-WINDOW:WINDOW-STATE = WINDOW-MAXIMIZED.*/
  SESSION:DATA-ENTRY-RETURN = YES.

  ASSIGN rs_type =  1.
  DISP rs_type WITH FRAM fr_main.
  
  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-proc_assign C-Win 
PROCEDURE 00-proc_assign :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: A64-0135       
------------------------------------------------------------------------------*/
/* comment by : A67-0076 ...
DO:
    INPUT FROM VALUE (fi_filename) .   /*create in TEMP-TABLE wImport*/
    REPEAT:
        CREATE wdetail.
        IMPORT DELIMITER "|" 
            wdetail.recodno        /* �ӴѺ���                     */
            wdetail.Notify_dat     /* �ѹ����Ѻ��                */
            wdetail.recive_dat     /* �ѹ����Ѻ�Թ������»�Сѹ  */
            wdetail.comp_code      /* ��ª��ͺ���ѷ��Сѹ���       */
            wdetail.cedpol         /* �Ţ����ѭ����ҫ���          */
            wdetail.typpol         /* New/Renew                    */
            wdetail.prepol         /* �Ţ�������������           */
            wdetail.cmbr_no        /* �����Ң�                     */
            wdetail.cmbr_code      /* �Ң� KK                      */
            wdetail.brtms          /* �Ң� TMSTH                  */
            wdetail.notifyno       /* �Ţ�Ѻ���                  */
            wdetail.kkflag         /* KK offer */
            wdetail.campaigno      /* Campaign                     */
            wdetail.campaigsub     /* Sub Campaign                 */
            wdetail.typper         /* �ؤ��/�ԵԺؤ��              */
            wdetail.n_TITLE        /* �ӹ�˹�Ҫ���                 */
            wdetail.n_name1        /* ���ͼ����һ�Сѹ             */
            wdetail.n_name2        /* ���ʡ�ż����һ�Сѹ          */
            wdetail.ADD_1          /* ��ҹ�Ţ���                   */
            wdetail.ADD_2          /* �Ӻ�/�ǧ                    */
            wdetail.ADD_3          /* �����/ࢵ                    */
            wdetail.ADD_4          /* �ѧ��Ѵ                      */
            wdetail.ADD_5          /* ������ɳ���                 */
            wdetail.cover          /* ����������������ͧ           */
            wdetail.garage         /* ��������ë���                */
            wdetail.comdat         /* �ѹ�����������ͧ             */
            wdetail.expdat         /* �ѹ����ش������ͧ           */
            wdetail.subclass       /* ����ö                       */
            wdetail.n_43           /* ��������Сѹ���ö¹��        */
            wdetail.brand          /* ����������ö                 */
            wdetail.model          /* ���ö                       */
            wdetail.nSTATUS        /* New/Used                     */
            wdetail.licence        /* �Ţ����¹                   */
            wdetail.province       /* �ѧ��Ѵ������¹             */
            wdetail.chassis        /* �Ţ��Ƕѧ                    */
            wdetail.engine         /* �Ţ����ͧ¹��              */
            wdetail.cyear          /* ��ö¹��                    */
            wdetail.power          /* �ի�                        */
            wdetail.weight         /* ���˹ѡ/�ѹ                 */
            wdetail.seat           /* ����� */
            wdetail.ins_amt1       /* �ع��Сѹ�� 1               */
            wdetail.netprem        /* �����ط��                  */
            wdetail.prem1          /* ����������������ҡû� 1    */
            wdetail.time_notif     /* �����Ѻ���                */
            wdetail.NAME_mkt       /* �������˹�ҷ�� MKT         */
            wdetail.bennam         /* �����˵�                    */
            wdetail.drivno1        /* ���Ѻ����� 1              */
            wdetail.drivdat1       /* �ѹ�Դ���Ѻ��� 1          */
            wdetail.drivid1        /* �Ţ���㺢Ѻ��� 1            */
            wdetail.drivno2        /* ���Ѻ����� 2              */
            wdetail.drivdat2       /* �ѹ�Դ���Ѻ��� 2          */
            wdetail.drivid2        /* �Ţ���㺢Ѻ��� 2            */
            wdetail.reci_title     /* �ӹ�˹�Ҫ��� (�����/㺡ӡѺ����) */
            wdetail.reci_name1     /* ���� (�����/㺡ӡѺ����)         */
            wdetail.reci_name2     /* ���ʡ�� (�����/㺡ӡѺ����)      */
            wdetail.reci_1         /* ��ҹ�Ţ��� (�����/㺡ӡѺ����)   */
            wdetail.reci_2         /* �Ӻ�/�ǧ (�����/㺡ӡѺ����)    */
            wdetail.reci_3         /* �����/ࢵ (�����/㺡ӡѺ����)    */
            wdetail.reci_4         /* �ѧ��Ѵ (�����/㺡ӡѺ����)      */
            wdetail.reci_5         /* ������ɳ��� (�����/㺡ӡѺ����) */
            wdetail.ncb            /* ��ǹŴ����ѵԴ�             */
            wdetail.fleet          /* ��ǹŴ�ҹ Fleet             */
            wdetail.phone          /* ����Դ���                 */
            wdetail.icno           /* �Ţ���ѵû�ЪҪ�           */
            wdetail.bdate          /* �ѹ��͹���Դ              */
            wdetail.occup          /* �Ҫվ                       */
            wdetail.cstatus        /* ʶҹ�Ҿ                     */
            wdetail.gender         /* �� */
            wdetail.nation         /* �ѭ�ҵ� */
            wdetail.email          /* ������ */
            wdetail.tax            /* �Ţ��Шӵ�Ǽ�����������ҡ�  */
            wdetail.tname1         /* �ӹ�˹�Ҫ��� 1              */
            wdetail.cname1         /* ���͡������ 1               */
            wdetail.lname1         /* ���ʡ�š������ 1            */
            wdetail.icno1          /* �Ţ���ѵû�ЪҪ�������� 1  */
            wdetail.tname2         /* �ӹ�˹�Ҫ��� 2              */
            wdetail.cname2         /* ���͡������ 2               */
            wdetail.lname2         /* ���ʡ�š������ 2            */
            wdetail.icno2          /* �Ţ���ѵû�ЪҪ�������� 2  */
            wdetail.tname3         /* �ӹ�˹�Ҫ��� 3              */
            wdetail.cname3         /* ���͡������ 3               */
            wdetail.lname3         /* ���ʡ�š������ 3            */
            wdetail.icno3          /* �Ţ���ѵû�ЪҪ�������� 3  */
            wdetail.nsend          /* �Ѵ���͡��÷���Ң�         */
            wdetail.sendname       /* ���ͼ���Ѻ�͡���            */
            wdetail.bennefit       /* ����Ѻ�Ż���ª��            */
            wdetail.KKapp          /* KK ApplicationNo            */
            wdetail.remak1         /* Remak1                      */
            wdetail.remak2         /* Remak2                      */
            wdetail.dealercd       /* Dealer KK                     */
            wdetail.dealtms        /* dealer TMSTH */
            wdetail.packcod        /* Campaignno TMSTH            */
            wdetail.campOV         /* Campaign OV                 */
            wdetail.producer       /* Producer code      */
            wdetail.Agent          /* Agent code        */
            Wdetail.RefNo          /*ReferenceNo  */
            Wdetail.KKQuo          /* KK Quotation No.*/
            Wdetail.RiderNo        /* Rider  No.  */
            wdetail.releas         /* Release                     */
            wdetail.loandat       /* Loan First Date             */
            /* add by : A65-0288 */
            wdetail.polpremium  
            wdetail.probleam
            wdetail.Colors          /* Color                */  
            wdetail.Inspection      /* Inspection           */  
            wdetail.Insp_status     /* Inspection status    */  
            wdetail.Insp_No         /* Inspection No        */  
            wdetail.Insp_Closed     /* Inspection Closed Date */
            wdetail.Insp_Detail     /* Inspection Detail    */  
            wdetail.insp_Damage     /* inspection Damage    */  
            wdetail.insp_Accessory . /*inspection Accessory */  
           /* end : A65-0288 */
        IF index(wdetail.recodno,"���") <> 0 THEN DELETE wdetail.
        ELSE IF INDEX(wdetail.recodno,"�������") <> 0 THEN DELETE wdetail.
        ELSE IF wdetail.recodno = " "  THEN DELETE wdetail.

    END. 
    FOR EACH wdetail. 
        IF      index(wdetail.cover,"1")   <> 0  THEN ASSIGN wdetail.cover = "1" .
        ELSE IF index(wdetail.cover,"2+")  <> 0  THEN ASSIGN wdetail.cover = "2.2" .
        ELSE IF index(wdetail.cover,"2 +") <> 0  THEN ASSIGN wdetail.cover = "2.2" .
        ELSE IF index(wdetail.cover,"2")   <> 0  AND index(wdetail.cover,"Plus") <> 0 THEN ASSIGN wdetail.cover = "2.2" .
        ELSE IF index(wdetail.cover,"2")   <> 0  THEN ASSIGN wdetail.cover = "2" .
        ELSE IF index(wdetail.cover,"3+")  <> 0  THEN ASSIGN wdetail.cover = "3.2" .
        ELSE IF index(wdetail.cover,"3 +") <> 0  THEN ASSIGN wdetail.cover = "3.2" .
        ELSE IF index(wdetail.cover,"3")   <> 0  AND index(wdetail.cover,"Plus") <> 0 THEN ASSIGN wdetail.cover = "3.2" .
        ELSE IF index(wdetail.cover,"3")   <> 0  THEN ASSIGN wdetail.cover = "3" .
        ELSE IF (INDEX(wdetail.cover,"�.�.�.") <> 0 OR INDEX(wdetail.cover,"�Ҥ�ѧ�Ѻ") <> 0) THEN wdetail.cover = "T" .

      /*  IF index(wdetail.garage,"��ҧ") <> 0 THEN  ASSIGN wdetail.garage = "G" .
        ELSE ASSIGN wdetail.garage = " " . */
    END.

END.
..end A67-0076...*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-proc_filenew C-Win 
PROCEDURE 00-proc_filenew :
/*------------------------------------------------------------------------------
Purpose:     
Parameters:  <none>
Notes:       
------------------------------------------------------------------------------*/
/* comment by : A67-0076 ....
ASSIGN 
    n_record = 0
    nv_cnt   = 0
    nv_row   = 1  .

If  substr(fi_outfile,length(fi_outfile) - 3,4) <>  ".slk"  THEN 
    fi_outfile  =  Trim(fi_outfile) + ".slk"  .

ASSIGN nv_cnt =  0
    nv_row    =  1 .

OUTPUT STREAM ns2 TO VALUE(fi_outfile).
PUT STREAM ns2 "ID;PND" SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"' "��Ҥ�����õԹҤԹ�ѷ� �ӡѴ (��Ҫ�) ."  '"' SKIP.
nv_row  =  nv_row + 1.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"   '"' "�ӴѺ���        "                      '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"   '"' "�ѹ����Ѻ��   "                      '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"   '"' "�ѹ����Ѻ�Թ������»�Сѹ "          '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"   '"' "��ª��ͺ���ѷ��Сѹ��� "               '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"   '"' "�Ţ����ѭ����ҫ���"                   '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"   '"' "New/Renew          "                   '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"   '"' "Policy No.         "                   '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"   '"' "�Ţ������������� "                   '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"   '"' "�����Ң�           "                   '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K"  '"' "�Ң� KK            "                   '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K"  '"' "�Ң� TMSTH         "                   '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K"  '"' "�Ţ�Ѻ���        "                   '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K"  '"' "KK Offer Flag      "                   '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K"  '"' "Campaign           "                   '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K"  '"' "Sub Campaign       "                   '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K"  '"' "�ؤ��/�ԵԺؤ��    "                   '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K"  '"' "�ӹ�˹�Ҫ���       "                   '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K"  '"' "���ͼ����һ�Сѹ   "                   '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K"  '"' "���ʡ�ż����һ�Сѹ"                   '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K"  '"' "��ҹ�Ţ���         "                   '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K"  '"' "�Ӻ�/�ǧ          "                   '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K"  '"' "�����/ࢵ          "                   '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K"  '"' "�ѧ��Ѵ            "                   '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K"  '"' "������ɳ���       "                   '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K"  '"' "����������������ͧ "                   '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K"  '"' "��������ë���      "                   '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K"  '"' "�ѹ�����������ͧ   "                   '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K"  '"' "�ѹ����ش������ͧ "                   '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K"  '"' "����ö             "                   '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K"  '"' "��������Сѹ���ö¹�� "                '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K"  '"' "����������ö     "                     '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K"  '"' "���ö           "                     '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K"  '"' "New/Used         "                     '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K"  '"' "�Ţ����¹       "                     '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K"  '"' "�ѧ��Ѵ������¹ "                     '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K"  '"' "�Ţ��Ƕѧ        "                     '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K"  '"' "�Ţ����ͧ¹��   "                     '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K"  '"' "��ö¹��         "                     '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X39;K"  '"' "�ի�             "                     '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X40;K"  '"' "���˹ѡ/�ѹ      "                     '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X41;K"  '"' "�����    "                           '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X42;K"  '"' "�ع��Сѹ�� 1    "                     '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X43;K"  '"' "�����ط��       "                     '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X44;K"  '"' "����������������ҡû� 1 "             '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X45;K"  '"' "�����Ѻ���     "                     '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X46;K"  '"' "�������˹�ҷ�� MKT"                   '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X47;K"  '"' "�����˵�         "                     '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X48;K"  '"' "���Ѻ����� 1   "                     '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X49;K"  '"' "�ѹ�Դ���Ѻ��� 1 "                   '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X50;K"  '"' "�Ţ���㺢Ѻ��� 1 "                     '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X51;K"  '"' "���Ѻ����� 2   "                     '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X52;K"  '"' "�ѹ�Դ���Ѻ��� 2 "                   '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X53;K"  '"' "�Ţ���㺢Ѻ��� 2 "                     '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X54;K"  '"' "�ӹ�˹�Ҫ��� (�����/㺡ӡѺ����)"    '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X55;K"  '"' "���� (�����/㺡ӡѺ����)        "    '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X56;K"  '"' "���ʡ�� (�����/㺡ӡѺ����)     "    '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X57;K"  '"' "��ҹ�Ţ��� (�����/㺡ӡѺ����)  "    '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X58;K"  '"' "�Ӻ�/�ǧ (�����/㺡ӡѺ����)   "    '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X59;K"  '"' "�����/ࢵ (�����/㺡ӡѺ����)   "    '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X60;K"  '"' "�ѧ��Ѵ (�����/㺡ӡѺ����)     "    '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X61;K"  '"' "������ɳ��� (�����/㺡ӡѺ����)"    '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X62;K"  '"' "��ǹŴ����ѵԴ�   "                    '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X63;K"  '"' "��ǹŴ�ҹ Fleet   "                    '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X64;K"  '"' "����Դ���       "                    '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X65;K"  '"' "�Ţ���ѵû�ЪҪ� "                    '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X66;K"  '"' "�ѹ��͹���Դ    "                    '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X67;K"  '"' "�Ҫվ             "                    '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X68;K"  '"' "ʶҹ�Ҿ           "                    '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X69;K"  '"' "��"                                   '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X70;K"  '"' "�ѭ�ҵ�     "                          '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X71;K"  '"' "������      "                          '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X72;K"  '"' "�Ţ��Шӵ�Ǽ�����������ҡ�"            '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X73;K"  '"' "�ӹ�˹�Ҫ��� 1     "                   '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X74;K"  '"' "���͡������ 1      "                   '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X75;K"  '"' "���ʡ�š������ 1   "                   '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X76;K"  '"' "�Ţ���ѵû�ЪҪ�� ������ 1"           '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X77;K"  '"' "�ӹ�˹�Ҫ��� 2     "                   '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X78;K"  '"' "���͡������ 2      "                   '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X79;K"  '"' "���ʡ�š������ 2   "                   '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X80;K"  '"' "�Ţ���ѵû�ЪҪ�� ������ 2"           '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X81;K"  '"' "�ӹ�˹�Ҫ��� 3     "                   '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X82;K"  '"' "���͡������ 3      "                   '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X83;K"  '"' "���ʡ�š������ 3   "                   '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X84;K"  '"' "�Ţ���ѵû�ЪҪ�������� 3"            '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X85;K"  '"' "�Ѵ���͡��÷���Ң�    "               '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X86;K"  '"' "���ͼ���Ѻ�͡��� "         '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X87;K"  '"' "����Ѻ�Ż���ª�� "         '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X88;K"  '"' "KK ApplicationNo "         '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X89;K"  '"' "Remak1     "               '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X90;K"  '"' "Remak2     "               '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X91;K"  '"' "Dealer KK    "             '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X92;K"  '"' "Dealer TMSTH     "         '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X93;K"  '"' "Campaign no TMSTH"         '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X94;K"  '"' "Campaign OV      "         '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X95;K"  '"' "Producer         "         '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X96;K"  '"' "Agent            "         '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X97;K"  '"' "Vat code         "         '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X98;K"  '"' "ReferenceNo      "         '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X99;K"  '"' "KK Quotation No. "         '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X100;K" '"' "Rider  No.       "         '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X101;K" '"' "Release          "         '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X102;K" '"' "Loan First Date  "         '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X103;K" '"' "Policy Premium   "         '"' SKIP.  /* A65-0288*/ 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X104;K" '"' "Note Problem     "         '"' SKIP.  /* A65-0288*/                                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X105;K" '"' "Color            "         '"' SKIP.  /* A65-0288*/
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X106;K" '"' "Inspection       "         '"' SKIP.  /* A65-0288*/
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X107;K" '"' "Inspection status"         '"' SKIP.  /* A65-0288*/
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X108;K" '"' "Inspection No    "         '"' SKIP.  /* A65-0288*/
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X109;K" '"' "Inspection Closed Date"    '"' SKIP.  /* A65-0288*/
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X110;K" '"' "Inspection Detail  "       '"' SKIP.  /* A65-0288*/
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X111;K" '"' "inspection Damage  "       '"' SKIP.  /* A65-0288*/
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X112;K" '"' "inspection Accessory  "    '"' SKIP.  /* A65-0288*/
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X113;K" '"' "�����˵�  "                '"' SKIP.       

RUN proc_filenew02.
...end A67-0076 ...*/
 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-proc_filenew02 C-Win 
PROCEDURE 00-proc_filenew02 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* comment by : A67-0076 ...
FOR EACH wdetail WHERE wdetail.chassis <> "" no-lock.
    ASSIGN 
        n_record =  n_record + 1
        nv_cnt   =  nv_cnt   + 1 
        nv_row   =  nv_row   + 1.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"'   n_record                  '"' SKIP. /* �ӴѺ���                     */     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"'   wdetail.Notify_dat        '"' SKIP. /* �ѹ����Ѻ��                */     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"'   wdetail.recive_dat        '"' SKIP. /* �ѹ����Ѻ�Թ������»�Сѹ  */     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"  '"'   wdetail.comp_code         '"' SKIP. /* ��ª��ͺ���ѷ��Сѹ���       */     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"'   wdetail.cedpol            '"' SKIP. /* �Ţ����ѭ����ҫ���          */     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"  '"'   wdetail.typpol            '"' SKIP. /* New/Renew                    */     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"  '"'   wdetail.n_policy          '"' SKIP. /* �Ţ��������������           */
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"  '"'   wdetail.prepol            '"' SKIP. /* �Ţ�������������           */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"  '"'   wdetail.cmbr_no           '"' SKIP. /* �����Ң�                     */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K"  '"'  wdetail.cmbr_code         '"' SKIP. /* �Ң� KK                      */ 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K"  '"'  wdetail.brtms             '"' SKIP. /* �Ң� TMSTH                  */
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K"  '"'  wdetail.notifyno          '"' SKIP. /* �Ţ�Ѻ���                  */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K"  '"'  wdetail.kkflag            '"' SKIP. /* KK offer */                                           
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K"  '"'  wdetail.campaigno         '"' SKIP. /* Campaign                     */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K"  '"'  wdetail.campaigsub        '"' SKIP. /* Sub Campaign                 */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K"  '"'  wdetail.typper            '"' SKIP. /* �ؤ��/�ԵԺؤ��              */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K"  '"'  wdetail.n_TITLE           '"' SKIP. /* �ӹ�˹�Ҫ���                 */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K"  '"'  wdetail.n_name1           '"' SKIP. /* ���ͼ����һ�Сѹ             */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K"  '"'  wdetail.n_name2           '"' SKIP. /* ���ʡ�ż����һ�Сѹ          */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K"  '"'  wdetail.ADD_1             '"' SKIP. /* ��ҹ�Ţ���                   */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K"  '"'  wdetail.ADD_2             '"' SKIP. /* �Ӻ�/�ǧ                    */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K"  '"'  wdetail.ADD_3             '"' SKIP. /* �����/ࢵ                    */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K"  '"'  wdetail.ADD_4             '"' SKIP. /* �ѧ��Ѵ                      */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K"  '"'  wdetail.ADD_5             '"' SKIP. /* ������ɳ���                 */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K"  '"'  wdetail.cover             '"' SKIP. /* ����������������ͧ           */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K"  '"'  wdetail.garage            '"' SKIP. /* ��������ë���                */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K"  '"'  wdetail.comdat            '"' SKIP. /* �ѹ�����������ͧ             */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K"  '"'  wdetail.expdat            '"' SKIP. /* �ѹ����ش������ͧ           */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K"  '"'  wdetail.subclass          '"' SKIP. /* ����ö                       */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K"  '"'  wdetail.n_43              '"' SKIP. /* ��������Сѹ���ö¹��        */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K"  '"'  wdetail.brand             '"' SKIP. /* ����������ö                 */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K"  '"'  wdetail.model             '"' SKIP. /* ���ö                       */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K"  '"'  wdetail.nSTATUS           '"' SKIP. /* New/Used                     */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K"  '"'  wdetail.licence           '"' SKIP. /* �Ţ����¹                   */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K"  '"'  wdetail.province          '"' SKIP. /* �ѧ��Ѵ������¹             */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K"  '"'  wdetail.chassis           '"' SKIP. /* �Ţ��Ƕѧ                    */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K"  '"'  wdetail.engine            '"' SKIP. /* �Ţ����ͧ¹��              */                        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K"  '"'  wdetail.cyear             '"' SKIP. /* ��ö¹��                    */                        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X39;K"  '"'  wdetail.power             '"' SKIP. /* �ի�                        */                        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X40;K"  '"'  wdetail.weight            '"' SKIP. /* ���˹ѡ/�ѹ                 */   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X41;K"  '"'  wdetail.seat              '"' SKIP. /* �����              */   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X42;K"  '"'  wdetail.ins_amt1          '"' SKIP. /* �ع��Сѹ�� 1               */                        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X43;K"  '"'  wdetail.netprem           '"' SKIP. /* �����ط��                  */                        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X44;K"  '"'  wdetail.prem1             '"' SKIP. /* ����������������ҡû� 1    */                        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X45;K"  '"'  wdetail.time_notify       '"' SKIP. /* �����Ѻ���                */                        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X46;K"  '"'  wdetail.NAME_mkt          '"' SKIP. /* �������˹�ҷ�� MKT         */                        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X47;K"  '"'  wdetail.bennam            '"' SKIP. /* �����˵�                    */                        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X48;K"  '"'  wdetail.drivno1           '"' SKIP. /* ���Ѻ����� 1              */                        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X49;K"  '"'  wdetail.drivdat1          '"' SKIP. /* �ѹ�Դ���Ѻ��� 1          */                        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X50;K"  '"'  wdetail.drivid1           '"' SKIP. /* �Ţ���㺢Ѻ��� 1            */                        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X51;K"  '"'  wdetail.drivno2           '"' SKIP. /* ���Ѻ����� 2              */                        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X52;K"  '"'  wdetail.drivdat2          '"' SKIP. /* �ѹ�Դ���Ѻ��� 2          */                        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X53;K"  '"'  wdetail.drivid2           '"' SKIP. /* �Ţ���㺢Ѻ��� 2            */                        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X54;K"  '"'  wdetail.reci_title        '"' SKIP. /* �ӹ�˹�Ҫ��� (�����/㺡ӡѺ����)*/                  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X55;K"  '"'  wdetail.reci_name1        '"' SKIP.  /* ���� (�����/㺡ӡѺ����)      */                   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X56;K"  '"'  wdetail.reci_name2        '"' SKIP.  /* ���ʡ�� (�����/㺡ӡѺ����)   */                   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X57;K"  '"'  wdetail.reci_1            '"' SKIP.  /* ��ҹ�Ţ��� (�����/㺡ӡѺ����)*/                   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X58;K"  '"'  wdetail.reci_2            '"' SKIP.  /* �Ӻ�/�ǧ (�����/㺡ӡѺ����) */                   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X59;K"  '"'  wdetail.reci_3             '"' SKIP. /* �����/ࢵ (�����/㺡ӡѺ����) */                   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X60;K"  '"'  wdetail.reci_4             '"' SKIP. /* �ѧ��Ѵ (�����/㺡ӡѺ����)   */                   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X61;K"  '"'  wdetail.reci_5             '"' SKIP. /* ������ɳ��� (�����/㺡ӡѺ����) */                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X62;K"  '"'  wdetail.ncb                '"' SKIP. /* ��ǹŴ����ѵԴ�             */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X63;K"  '"'  wdetail.fleet              '"' SKIP. /* ��ǹŴ�ҹ Fleet             */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X64;K"  '"'  wdetail.phone              '"' SKIP. /* ����Դ���                 */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X65;K"  '"'  wdetail.icno               '"' SKIP. /* �Ţ���ѵû�ЪҪ�           */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X66;K"  '"'  wdetail.bdate              '"' SKIP. /* �ѹ��͹���Դ              */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X67;K"  '"'  wdetail.occup              '"' SKIP. /* �Ҫվ                       */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X68;K"  '"'  wdetail.cstatus            '"' SKIP. /* ʶҹ�Ҿ                     */ 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X69;K"  '"'  wdetail.gender             '"' SKIP. /* �� */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X70;K"  '"'  wdetail.nation             '"' SKIP. /* �ѭ�ҵ� */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X71;K"  '"'  wdetail.email              '"' SKIP. /* ������  */  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X72;K"  '"'  wdetail.tax                '"' SKIP. /* �Ţ��Шӵ�Ǽ�����������ҡ�  */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X73;K"  '"'  wdetail.tname1             '"' SKIP. /* �ӹ�˹�Ҫ��� 1              */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X74;K"  '"'  wdetail.cname1             '"' SKIP. /* ���͡������ 1               */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X75;K"  '"'  wdetail.lname1             '"' SKIP. /* ���ʡ�š������ 1            */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X76;K"  '"'  wdetail.icno1              '"' SKIP. /* �Ţ���ѵû�ЪҪ�������� 1  */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X77;K"  '"'  wdetail.tname2             '"' SKIP. /* �ӹ�˹�Ҫ��� 2              */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X78;K"  '"'  wdetail.cname2             '"' SKIP. /* ���͡������ 2               */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X79;K"  '"'  wdetail.lname2             '"' SKIP. /* ���ʡ�š������ 2            */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X80;K"  '"'  wdetail.icno2              '"' SKIP. /* �Ţ���ѵû�ЪҪ�������� 2  */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X81;K"  '"'  wdetail.tname3             '"' SKIP. /* �ӹ�˹�Ҫ��� 3              */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X82;K"  '"'  wdetail.cname3             '"' SKIP. /* ���͡������ 3               */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X83;K"  '"'  wdetail.lname3             '"' SKIP. /* ���ʡ�š������ 3            */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X84;K"  '"'  wdetail.icno3              '"' SKIP. /* �Ţ���ѵû�ЪҪ�������� 3  */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X85;K"  '"'  wdetail.nsend              '"' SKIP. /* �Ѵ���͡��÷���Ң�         */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X86;K"  '"'  wdetail.sendname           '"' SKIP. /* ���ͼ���Ѻ�͡���            */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X87;K"  '"'  wdetail.bennefit           '"' SKIP. /* ����Ѻ�Ż���ª��            */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X88;K"  '"'  wdetail.KKapp              '"' SKIP. /* KK ApplicationNo            */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X89;K"  '"'  wdetail.remak1             '"' SKIP. /* Remak1                      */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X90;K"  '"'  wdetail.remak2             '"' SKIP. /* Remak2                      */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X91;K"  '"'  wdetail.dealercd           '"' SKIP. /* Dealer                      */ 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X92;K"  '"'  wdetail.dealtms            '"' SKIP. /* Dealer TMSTH            */   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X93;K"  '"'  wdetail.packcod            '"' SKIP. /* Campaignno TMSTH            */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X94;K"  '"'  wdetail.campOV             '"' SKIP. /* Campaign OV                 */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X95;K"  '"'  wdetail.producer           '"' SKIP. /* Producer code      */                                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X96;K"  '"'  wdetail.Agent              '"' SKIP. /* Agent code        */  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X97;K"  '"'  Wdetail.vatcode            '"' SKIP. /*vat code  */  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X98;K"  '"'  Wdetail.RefNo              '"' SKIP. /*ReferenceNo  */                                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X99;K"  '"'  Wdetail.KKQuo              '"' SKIP. /* KK Quotation No.*/                                   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X100;K" '"'  Wdetail.RiderNo            '"' SKIP. /* Rider  No.  */                                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X101;K" '"'  wdetail.releas             '"' SKIP. /* Release                     */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X102;K" '"'  wdetail.loandat            '"' SKIP. /* Loan First Date             */ 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X103;K" '"'  wdetail.PolPremium             '"' SKIP.  /*A65-0288*/ 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X104;K" '"'  wdetail.polpremium         '"' SKIP.  /*A65-0288*/ 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X105;K" '"'  wdetail.Colors             '"' SKIP.  /*A65-0288*/
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X106;K" '"'  wdetail.Inspection         '"' SKIP.  /*A65-0288*/
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X107;K" '"'  wdetail.Insp_status        '"' SKIP.  /*A65-0288*/
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X108;K" '"'  wdetail.Insp_No            '"' SKIP.  /*A65-0288*/
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X109;K" '"'  wdetail.Insp_Closed        '"' SKIP.  /*A65-0288*/
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X110;K" '"'  wdetail.Insp_Detail        '"' SKIP.   /*A65-0288*/
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X111;K" '"'  wdetail.insp_Damage        '"' SKIP.   /*A65-0288*/
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X112;K" '"'  wdetail.insp_Accessory     '"' SKIP.   /*A65-0288*/
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X113;K" '"'  wdetail.remark             '"' SKIP.   
END. 
                                                                                     
nv_row  =  nv_row  + 1.                                                              
PUT STREAM ns2 "E".                                                                  
OUTPUT STREAM ns2 CLOSE.                                                             
 ...end A67-0076 ...*/                                                                                    
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
  DISPLAY fi_filename fi_outfile fi_outfile2 rs_type 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE fi_filename fi_outfile bu_ok bu_exit bu_file fi_outfile2 rs_type 
         RECT-76 RECT-77 
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
  Notes: A64-0135       
------------------------------------------------------------------------------*/
DO:
    INPUT FROM VALUE (fi_filename) .   /*create in TEMP-TABLE wImport*/
    REPEAT:
        CREATE wdetail.
        IMPORT DELIMITER "|" 
            wdetail.recodno         /* �ӴѺ���                     */                  
            wdetail.Notify_dat    /* �ѹ����Ѻ��                */                  
            wdetail.recive_dat    /* �ѹ����Ѻ�Թ������»�Сѹ  */                  
            wdetail.comp_code     /* ��ª��ͺ���ѷ��Сѹ���       */                  
            wdetail.cedpol        /* �Ţ����ѭ����ҫ���          */                  
            wdetail.typpol        /* New/Renew                    */                  
            wdetail.prepol        /* �Ţ�������������           */                  
            wdetail.cmbr_no       /* �����Ң�                     */                  
            wdetail.cmbr_code     /* �Ң� KK                      */                  
            wdetail.brtms         /* �Ң� TMSTH                   */                  
            wdetail.notifyno      /* �Ţ�Ѻ���                  */                  
            wdetail.kkflag        /* KK offer */                                      
            wdetail.campaigno     /* Campaign                     */                  
            wdetail.campaigsub    /* Sub Campaign                 */                  
            wdetail.typper        /* �ؤ��/�ԵԺؤ��              */                  
            wdetail.n_TITLE       /* �ӹ�˹�Ҫ���                 */                  
            wdetail.n_name1       /* ���ͼ����һ�Сѹ             */                  
            wdetail.n_name2       /* ���ʡ�ż����һ�Сѹ          */                  
            wdetail.ADD_1         /* ��ҹ�Ţ���                   */                  
            wdetail.ADD_2         /* �Ӻ�/�ǧ                    */                  
            wdetail.ADD_3         /* �����/ࢵ                    */                  
            wdetail.ADD_4         /* �ѧ��Ѵ                      */                  
            wdetail.ADD_5         /* ������ɳ���                 */                  
            wdetail.cover         /* ����������������ͧ           */                  
            wdetail.garage        /* ��������ë���                */                  
            wdetail.comdat        /* �ѹ�����������ͧ             */                  
            wdetail.expdat        /* �ѹ����ش������ͧ           */                  
            wdetail.subclass      /* ����ö                       */                  
            wdetail.n_43          /* ��������Сѹ���ö¹��        */                  
            wdetail.brand         /* ����������ö                 */                  
            wdetail.model         /* ���ö                       */                  
            wdetail.nSTATUS       /* New/Used                     */                  
            wdetail.licence       /* �Ţ����¹                   */                  
            wdetail.province       /* �ѧ��Ѵ������¹             */                 
            wdetail.chassis       /* �Ţ��Ƕѧ                    */                  
            wdetail.engine        /* �Ţ����ͧ¹��              */                   
            wdetail.cyear         /* ��ö¹��                    */                   
            wdetail.power         /* �ի�                        */                   
            wdetail.hp            /* �ç��� */                         /* A67-0076 */ 
            wdetail.weight        /* ���˹ѡ/�ѹ                 */                   
            wdetail.seat          /* ����� */                                       
            wdetail.ins_amt1      /* �ع��Сѹ�� 1               */                   
            wdetail.netprem       /* �����ط��                  */                   
            wdetail.prem1         /* ����������������ҡû� 1    */                   
            wdetail.time_notify   /* �����Ѻ���                */                   
            wdetail.NAME_mkt      /* �������˹�ҷ�� MKT         */                   
            wdetail.bennam        /* �����˵�                    */                   
            wdetail.drititle1     /* �ӹ�˹�Ҫ��� */             /* A67-0076 */       
            wdetail.drivno1       /* ���Ѻ����� 1              */                   
            wdetail.drivdat1      /* �ѹ�Դ���Ѻ��� 1          */                   
            wdetail.drivid1       /* �Ţ���㺢Ѻ��� 1            */                   
            wdetail.drigender1     /* A67-0076 */                                     
            wdetail.drioccup1      /* A67-0076 */                                     
            wdetail.driICNo1       /* A67-0076 */                                     
            wdetail.drilevel1      /* A67-0076 */                                     
            wdetail.drititle2      /* A67-0076 */                                     
            wdetail.drivno2       /* ���Ѻ����� 2              */                   
            wdetail.drivdat2      /* �ѹ�Դ���Ѻ��� 2          */                   
            wdetail.drivid2       /* �Ţ���㺢Ѻ��� 2            */                   
            /* add : A67-0076 */                                                       
            wdetail.drigender2                                                        
            wdetail.drioccup2                                                         
            wdetail.driICNo2                                                          
            wdetail.drilevel2                                                         
            wdetail.drilic3                                                           
            wdetail.drititle3                                                         
            wdetail.driname3                                                          
            wdetail.drivno3                                                           
            wdetail.drigender3                                                        
            wdetail.drioccup3                                                         
            wdetail.driICNo3                                                          
            wdetail.drilevel3                                                         
            wdetail.drilic4                                                           
            wdetail.drititle4                                                         
            wdetail.driname4                                                          
            wdetail.drivno4                                                           
            wdetail.drigender4                                                        
            wdetail.drioccup4                                                         
            wdetail.driICNo4                                                          
            wdetail.drilevel4                                                         
            wdetail.drilic5                                                           
            wdetail.drititle5                                                         
            wdetail.driname5                                                          
            wdetail.drivno5                                                           
            wdetail.drigender5                                                        
            wdetail.drioccup5                                                         
            wdetail.driICNo5                                                          
            wdetail.drilevel5                                                         
            /* end : A67-0076 */                                                       
            wdetail.reci_title    /* �ӹ�˹�Ҫ��� (�����/㺡ӡѺ����) */            
            wdetail.reci_name1    /* ���� (�����/㺡ӡѺ����)         */            
            wdetail.reci_name2    /* ���ʡ�� (�����/㺡ӡѺ����)      */            
            wdetail.reci_1        /* ��ҹ�Ţ��� (�����/㺡ӡѺ����)   */            
            wdetail.reci_2        /* �Ӻ�/�ǧ (�����/㺡ӡѺ����)    */            
            wdetail.reci_3        /* �����/ࢵ (�����/㺡ӡѺ����)    */            
            wdetail.reci_4        /* �ѧ��Ѵ (�����/㺡ӡѺ����)      */            
            wdetail.reci_5        /* ������ɳ��� (�����/㺡ӡѺ����) */            
            wdetail.ncb           /* ��ǹŴ����ѵԴ�             */                   
            wdetail.fleet         /* ��ǹŴ�ҹ Fleet             */                   
            wdetail.phone         /* ����Դ���                 */                   
            wdetail.icno          /* �Ţ���ѵû�ЪҪ�           */                   
            wdetail.bdate         /* �ѹ��͹���Դ              */                   
            wdetail.occup         /* �Ҫվ                       */                   
            wdetail.cstatus       /* ʶҹ�Ҿ                     */                   
            wdetail.gender        /* ��   */                                         
            wdetail.nation        /* �ѭ�ҵ�   */                                     
            wdetail.email         /* ����   */                                        
            wdetail.tax           /* �Ţ��Шӵ�Ǽ�����������ҡ�  */                   
            wdetail.tname1        /* �ӹ�˹�Ҫ��� 1              */                   
            wdetail.cname1        /* ���͡������ 1               */                   
            wdetail.lname1        /* ���ʡ�š������ 1            */                   
            wdetail.icno1         /* �Ţ���ѵû�ЪҪ�������� 1  */                   
            wdetail.tname2        /* �ӹ�˹�Ҫ��� 2              */                   
            wdetail.cname2        /* ���͡������ 2               */                   
            wdetail.lname2        /* ���ʡ�š������ 2            */                   
            wdetail.icno2         /* �Ţ���ѵû�ЪҪ�������� 2  */                   
            wdetail.tname3        /* �ӹ�˹�Ҫ��� 3              */                   
            wdetail.cname3        /* ���͡������ 3               */                   
            wdetail.lname3        /* ���ʡ�š������ 3            */                   
            wdetail.icno3         /* �Ţ���ѵû�ЪҪ�������� 3  */                   
            wdetail.nsend         /* �Ѵ���͡��÷���Ң�         */                   
            wdetail.sendname      /* ���ͼ���Ѻ�͡���            */                   
            wdetail.bennefit      /* ����Ѻ�Ż���ª��            */                   
            wdetail.KKapp         /* KK ApplicationNo            */                   
            wdetail.remak1        /* Remak1                      */                   
            wdetail.remak2        /* Remak2                      */                   
            wdetail.dealercd      /* Dealer KK                    */                  
            wdetail.dealtms       /* Dealer TMSTH                  */                 
            wdetail.packcod       /* Campaignno TMSTH            */                   
            wdetail.campOV        /* Campaign OV                 */                   
            wdetail.producer      /* Producer code      */                            
            wdetail.Agent         /* Agent code        */                             
            wdetail.RefNo         /*ReferenceNo  */                                   
            wdetail.KKQuo         /* KK Quotation No.*/                               
            wdetail.RiderNo       /* Rider  No.  */                                   
            wdetail.releas        /* Release                     */                   
            wdetail.loandat       /* Loan First Date             */                   
            /* add by : A65-0288 */                                                    
            wdetail.PolPrem           /*Policy Premium   */                           
            wdetail.probleam     /*Note Un Problem  */                               
            wdetail.colors        /* color  */ 
            wdetail.Inspection    /* ��Ǩ��Ҿ */           
            wdetail.Insp_status   /* ʶҹС��ͧ��Ǩ��Ҿ*/  
            wdetail.Insp_No       /* �Ţ���ͧ*/            
            wdetail.Insp_Closed   /* �ѹ���Դ����ͧ*/     
            wdetail.Insp_Detail   /* �ŵ�Ǩ��Ҿ*/          
            wdetail.insp_Damage   /* ��¡�ä����������*/   
            wdetail.insp_Accessory /* �ػ�ó������ */   
            /* end : A65-0288 */                                                       
            /* A67-0076 */                                                             
            wdetail.dateregis                                                         
            wdetail.pay_option                                                        
            wdetail.battno                                                            
            wdetail.battyr                                                            
            wdetail.maksi                                                             
            wdetail.chargno                                                           
            wdetail.veh_key .                                                         
            /*  end : A67-0076 */     
        IF index(wdetail.recodno,"���") <> 0 THEN DELETE wdetail.
        ELSE IF INDEX(wdetail.recodno,"�������") <> 0 THEN DELETE wdetail.
        ELSE IF wdetail.recodno = " "  THEN DELETE wdetail.

    END. 
    FOR EACH wdetail. 
        IF      index(wdetail.cover,"1")   <> 0  THEN ASSIGN wdetail.cover = "1" .
        ELSE IF index(wdetail.cover,"2+")  <> 0  THEN ASSIGN wdetail.cover = "2.2" .
        ELSE IF index(wdetail.cover,"2 +") <> 0  THEN ASSIGN wdetail.cover = "2.2" .
        ELSE IF index(wdetail.cover,"2")   <> 0  AND index(wdetail.cover,"Plus") <> 0 THEN ASSIGN wdetail.cover = "2.2" .
        ELSE IF index(wdetail.cover,"2")   <> 0  THEN ASSIGN wdetail.cover = "2" .
        ELSE IF index(wdetail.cover,"3+")  <> 0  THEN ASSIGN wdetail.cover = "3.2" .
        ELSE IF index(wdetail.cover,"3 +") <> 0  THEN ASSIGN wdetail.cover = "3.2" .
        ELSE IF index(wdetail.cover,"3")   <> 0  AND index(wdetail.cover,"Plus") <> 0 THEN ASSIGN wdetail.cover = "3.2" .
        ELSE IF index(wdetail.cover,"3")   <> 0  THEN ASSIGN wdetail.cover = "3" .
        ELSE IF (INDEX(wdetail.cover,"�.�.�.") <> 0 OR INDEX(wdetail.cover,"�Ҥ�ѧ�Ѻ") <> 0) THEN wdetail.cover = "T" .

      /*  IF index(wdetail.garage,"��ҧ") <> 0 THEN  ASSIGN wdetail.garage = "G" .
        ELSE ASSIGN wdetail.garage = " " . */
    END.

END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_filenew C-Win 
PROCEDURE proc_filenew :
/*------------------------------------------------------------------------------
Purpose:     
Parameters:  <none>
Notes: A67-0076       
------------------------------------------------------------------------------*/
ASSIGN 
    n_record = 0
    nv_cnt   = 0
    nv_row   = 1  .

If  substr(fi_outfile,length(fi_outfile) - 3,4) <>  ".slk"  THEN 
    fi_outfile  =  Trim(fi_outfile) + ".slk"  .

ASSIGN nv_cnt =  0
    nv_row    =  1 .
OUTPUT STREAM ns2 TO VALUE(fi_outfile).
PUT STREAM ns2 "ID;PND" SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"' "��Ҥ�����õԹҤԹ�ѷ� �ӡѴ (��Ҫ�) ."  '"' SKIP.
nv_row  =  nv_row + 1.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"   '"' "�ӴѺ���      "        '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"   '"' "�ѹ����Ѻ�� "        '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"   '"' "�ѹ����Ѻ�Թ������»�Сѹ " '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"   '"' "��ª��ͺ���ѷ��Сѹ��� " '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"   '"' "�Ţ����ѭ����ҫ���"   '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"   '"' "New/Renew          "   '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"   '"' "Policy no        " '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"   '"' "�Ţ������������� "   '"' SKIP.                        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"   '"' "�����Ң�           "   '"' SKIP.                        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K"  '"' "�Ң� KK            "   '"' SKIP.                        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K"  '"' "�Ң� TMSTH         "   '"' SKIP.                        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K"  '"' "�Ţ�Ѻ���        "   '"' SKIP.                        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K"  '"' "KK Offer Flag      "   '"' SKIP.                        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K"  '"' "Campaign           "   '"' SKIP.                        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K"  '"' "Sub Campaign       "   '"' SKIP.                        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K"  '"' "�ؤ��/�ԵԺؤ��    "   '"' SKIP.                        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K"  '"' "�ӹ�˹�Ҫ���       "   '"' SKIP.                        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K"  '"' "���ͼ����һ�Сѹ   "   '"' SKIP.                        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K"  '"' "���ʡ�ż����һ�Сѹ"   '"' SKIP.                        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K"  '"' "��ҹ�Ţ���         "   '"' SKIP.                        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K"  '"' "�Ӻ�/�ǧ          "   '"' SKIP.                        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K"  '"' "�����/ࢵ          "   '"' SKIP.                        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K"  '"' "�ѧ��Ѵ            "   '"' SKIP.                        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K"  '"' "������ɳ���       "   '"' SKIP.                        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K"  '"' "����������������ͧ "   '"' SKIP.                        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K"  '"' "��������ë���      "   '"' SKIP.                        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K"  '"' "�ѹ�����������ͧ   "   '"' SKIP.                        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K"  '"' "�ѹ����ش������ͧ "   '"' SKIP.                        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K"  '"' "����ö             "   '"' SKIP.                        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K"  '"' "��������Сѹ���ö¹�� "'"' SKIP.                        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K"  '"' "����������ö     "     '"' SKIP.                        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K"  '"' "���ö           "     '"' SKIP.                        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K"  '"' "New/Used         "     '"' SKIP.                        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K"  '"' "�Ţ����¹       "     '"' SKIP.                        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K"  '"' "�ѧ��Ѵ������¹ "     '"' SKIP.                        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K"  '"' "�Ţ��Ƕѧ        "     '"' SKIP.                        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K"  '"' "�Ţ����ͧ¹��   "     '"' SKIP.                        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K"  '"' "��ö¹��         "     '"' SKIP.                        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X39;K"  '"' "�ի�             "     '"' SKIP.                        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X40;K"  '"' "�ç���           "     '"' SKIP.                        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X41;K"  '"' "���˹ѡ/�ѹ      "     '"' SKIP.                        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X42;K"  '"' "�����          "     '"' SKIP.                        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X43;K"  '"' "�ع��Сѹ�� 1    "     '"' SKIP.                        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X44;K"  '"' "�����ط��       "     '"' SKIP.                        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X45;K"  '"' "����������������ҡû� 1" '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X46;K"  '"' "�����Ѻ���       "  '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X47;K"  '"' "�������˹�ҷ�� MKT"  '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X48;K"  '"' "�����˵�           "  '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X49;K"  '"' "�ӹ�˹�Ҫ��� 1     "  '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X50;K"  '"' "���Ѻ����� 1     "  '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X51;K"  '"' "�ѹ�Դ���Ѻ��� 1 "  '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X52;K"  '"' "�Ţ���㺢Ѻ��� 1   "  '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X53;K"  '"' "�� 1              "  '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X54;K"  '"' "�Ҫվ 1            "  '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X55;K"  '"' "ID NO/Passport 1   "  '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X56;K"  '"' "�дѺ���Ѻ��� 1   "  '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X57;K"  '"' "�ӹ�˹�Ҫ��� 2     "  '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X58;K"  '"' "���Ѻ����� 2     "  '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X59;K"  '"' "�ѹ�Դ���Ѻ��� 2 "  '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X60;K"  '"' "�Ţ���㺢Ѻ��� 2   "  '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X61;K"  '"' "�� 2              "  '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X62;K"  '"' "�Ҫվ 2            "  '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X63;K"  '"' "ID NO/Passport 2   "  '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X64;K"  '"' "�дѺ���Ѻ��� 2   "  '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X65;K"  '"' "�ӹ�˹�Ҫ��� 3     "  '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X66;K"  '"' "���Ѻ����� 3     "  '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X67;K"  '"' "�ѹ�Դ���Ѻ��� 3 "  '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X68;K"  '"' "�Ţ���㺢Ѻ��� 3   "  '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X69;K"  '"' "�� 3              "  '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X70;K"  '"' "�Ҫվ 3            "  '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X71;K"  '"' "ID NO/Passport 3   "  '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X72;K"  '"' "�дѺ���Ѻ��� 3   "  '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X73;K"  '"' "�ӹ�˹�Ҫ��� 4     "  '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X74;K"  '"' "���Ѻ����� 4     "  '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X75;K"  '"' "�ѹ�Դ���Ѻ��� 4 "  '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X76;K"  '"' "�Ţ���㺢Ѻ��� 4   "  '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X77;K"  '"' "�� 4              "  '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X78;K"  '"' "�Ҫվ 4            "  '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X79;K"  '"' "ID NO/Passport 4   "  '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X80;K"  '"' "�дѺ���Ѻ��� 4   "  '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X81;K"  '"' "�ӹ�˹�Ҫ��� 5     "  '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X82;K"  '"' "���Ѻ����� 5     "  '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X83;K"  '"' "�ѹ�Դ���Ѻ��� 5 "  '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X84;K"  '"' "�Ţ���㺢Ѻ��� 5   "  '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X85;K"  '"' "�� 5              "  '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X86;K"  '"' "�Ҫվ 5            "  '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X87;K"  '"' "ID NO/Passport 5   "  '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X88;K"  '"' "�дѺ���Ѻ���5    "  '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X89;K"  '"' "�ӹ�˹�Ҫ��� (�����/㺡ӡѺ����)"  '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X90;K"  '"' "���� (�����/㺡ӡѺ����)    "      '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X91;K"  '"' "���ʡ�� (�����/㺡ӡѺ����) "      '"' SKIP.          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X92;K"  '"' "��ҹ�Ţ��� (�����/㺡ӡѺ����)  "  '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X93;K"  '"' "�Ӻ�/�ǧ (�����/㺡ӡѺ����)   "  '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X94;K"  '"' "�����/ࢵ (�����/㺡ӡѺ����)   "  '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X95;K"  '"' "�ѧ��Ѵ (�����/㺡ӡѺ����) "      '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X96;K"  '"' "������ɳ��� (�����/㺡ӡѺ����)"  '"' SKIP.          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X97;K"  '"' "��ǹŴ����ѵԴ�   "   '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X98;K"  '"' "��ǹŴ�ҹ Fleet   "   '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X99;K"  '"' "����Դ���       "   '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X100;K" '"' "�Ţ���ѵû�ЪҪ� "   '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X101;K" '"' "�ѹ��͹���Դ    "   '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X102;K" '"' "�Ҫվ    "            '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X103;K" '"' "ʶҹ�Ҿ  "            '"' SKIP.                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X104;K" '"' "��      "            '"' SKIP.  /* A65-0288*/                                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X105;K" '"' "�ѭ�ҵ�  "            '"' SKIP.  /* A65-0288*/          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X106;K" '"' "�������  "            '"' SKIP.  /* A65-0288*/          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X107;K" '"' "�Ţ��Шӵ�Ǽ�����������ҡ� "  '"' SKIP.  /* A65-0288*/  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X108;K" '"' "�ӹ�˹�Ҫ��� 1    "   '"' SKIP.  /* A65-0288*/          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X109;K" '"' "���͡������ 1     "   '"' SKIP.  /* A65-0288*/          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X110;K" '"' "���ʡ�š������ 1  "   '"' SKIP.  /* A65-0288*/          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X111;K" '"' "�Ţ���ѵû�ЪҪ�������� 1 "  '"' SKIP.  /* A65-0288*/  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X112;K" '"' "�ӹ�˹�Ҫ��� 2    "   '"' SKIP.  /* A65-0288*/          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X113;K" '"' "���͡������ 2     "   '"' SKIP.  /* A65-0288*/          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X114;K" '"' "���ʡ�š������ 2  "   '"' SKIP.                                  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X115;K" '"' "�Ţ���ѵû�ЪҪ�������� 2 "  '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X116;K" '"' "�ӹ�˹�Ҫ��� 3    "           '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X117;K" '"' "���͡������ 3     "           '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X118;K" '"' "���ʡ�š������ 3  "           '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X119;K" '"' "�Ţ���ѵû�ЪҪ�������� 3 "  '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X120;K" '"' "�Ѵ���͡��÷���Ң�"          '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X121;K" '"' "���ͼ���Ѻ�͡���"             '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X122;K" '"' "����Ѻ�Ż���ª��"             '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X123;K" '"' "KK ApplicationNo"             '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X124;K" '"' "Remak1          "             '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X125;K" '"' "Remak2          "             '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X126;K" '"' "Dealer KK       "             '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X127;K" '"' "Dealer TMSTH    "             '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X128;K" '"' "Campaign no TMSTH  "          '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X129;K" '"' "Campaign OV     "             '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X130;K" '"' "Producer code   "             '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X131;K" '"' "Agent Code      "             '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X132;K" '"' "Vat code "                    '"' SKIP.                       
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X133;K" '"' "ReferenceNo     "             '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X134;K" '"' "KK Quotation No."             '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X135;K" '"' "Rider  No.      "             '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X136;K" '"' "Release         "             '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X137;K" '"' "Loan First Date "             '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X138;K" '"' "Policy Premium  "             '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X139;K" '"' "Note Un Problem "             '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X140;K" '"' "Color           "             '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X141;K" '"' "Inspection      "             '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X142;K" '"' "Inspection status  "          '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X143;K" '"' "Inspection No   "             '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X144;K" '"' "Inspection Closed Date"       '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X145;K" '"' "Inspection Detail     "       '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X146;K" '"' "inspection Damage     "       '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X147;K" '"' "inspection Accessory  "       '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X148;K" '"' "�ѹ��訴����¹�����á  "    '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X149;K" '"' "Payment option  "             '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X151;K" '"' "Battery Serial Number"        '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X152;K" '"' "Battery Year    "             '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X153;K" '"' "Market value price   "        '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X154;K" '"' "Wall Charge Serial Number"    '"' SKIP.                 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X155;K" '"' "Vehicle_Key     "             '"' SKIP.                 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X156;K" '"' "�����˵� "                    '"' SKIP. 
RUN proc_filenew02. 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_filenew02 C-Win 
PROCEDURE proc_filenew02 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:  add by A67-0076     
------------------------------------------------------------------------------*/
FOR EACH wdetail WHERE wdetail.chassis <> "" no-lock.
    
    ASSIGN 
        n_record =  n_record + 1
        nv_cnt   =  nv_cnt   + 1 
        nv_row   =  nv_row   + 1.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"   '"' n_record            '"' SKIP. /* �ӴѺ���                     */     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"   '"' wdetail.Notify_dat  '"' SKIP. /* �ѹ����Ѻ��                */     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"   '"' wdetail.recive_dat  '"' SKIP. /* �ѹ����Ѻ�Թ������»�Сѹ  */     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"   '"' wdetail.comp_code   '"' SKIP. /* ��ª��ͺ���ѷ��Сѹ���       */     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"   '"' wdetail.cedpol      '"' SKIP. /* �Ţ����ѭ����ҫ���          */     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"   '"' wdetail.typpol      '"' SKIP. /* New/Renew                    */     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"   '"' wdetail.n_policy    '"' SKIP. /* �Ţ��������������           */
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"   '"' wdetail.prepol      '"' SKIP. /* �Ţ�������������           */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"   '"' wdetail.cmbr_no     '"' SKIP. /* �����Ң�                     */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K"  '"' wdetail.cmbr_code   '"' SKIP. /* �Ң� KK                      */ 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K"  '"' wdetail.brtms       '"' SKIP. /* �Ң� TMSTH                  */
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K"  '"' wdetail.notifyno    '"' SKIP. /* �Ţ�Ѻ���                  */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K"  '"' wdetail.kkflag      '"' SKIP. /* KK offer */                                           
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K"  '"' wdetail.campaigno   '"' SKIP. /* Campaign                     */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K"  '"' wdetail.campaigsub  '"' SKIP. /* Sub Campaign                 */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K"  '"' wdetail.typper      '"' SKIP. /* �ؤ��/�ԵԺؤ��              */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K"  '"' wdetail.n_TITLE     '"' SKIP. /* �ӹ�˹�Ҫ���                 */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K"  '"' wdetail.n_name1     '"' SKIP. /* ���ͼ����һ�Сѹ             */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K"  '"' wdetail.n_name2     '"' SKIP. /* ���ʡ�ż����һ�Сѹ          */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K"  '"' wdetail.ADD_1       '"' SKIP. /* ��ҹ�Ţ���                   */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K"  '"' wdetail.ADD_2       '"' SKIP. /* �Ӻ�/�ǧ                    */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K"  '"' wdetail.ADD_3       '"' SKIP. /* �����/ࢵ                    */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K"  '"' wdetail.ADD_4       '"' SKIP. /* �ѧ��Ѵ                      */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K"  '"' wdetail.ADD_5       '"' SKIP. /* ������ɳ���                 */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K"  '"' wdetail.cover       '"' SKIP. /* ����������������ͧ           */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K"  '"' wdetail.garage      '"' SKIP. /* ��������ë���                */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K"  '"' wdetail.comdat      '"' SKIP. /* �ѹ�����������ͧ             */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K"  '"' wdetail.expdat      '"' SKIP. /* �ѹ����ش������ͧ           */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K"  '"' wdetail.subclass    '"' SKIP. /* ����ö                       */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K"  '"' wdetail.n_43        '"' SKIP. /* ��������Сѹ���ö¹��        */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K"  '"' wdetail.brand       '"' SKIP. /* ����������ö                 */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K"  '"' wdetail.model       '"' SKIP. /* ���ö                       */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K"  '"' wdetail.nSTATUS     '"' SKIP. /* New/Used                     */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K"  '"' wdetail.licence     '"' SKIP. /* �Ţ����¹                   */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K"  '"' wdetail.province    '"' SKIP. /* �ѧ��Ѵ������¹             */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K"  '"' wdetail.chassis     '"' SKIP. /* �Ţ��Ƕѧ                    */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K"  '"' wdetail.engine      '"' SKIP. /* �Ţ����ͧ¹��              */                        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K"  '"' wdetail.cyear       '"' SKIP. /* ��ö¹��                    */                        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X39;K"  '"' wdetail.power       '"' SKIP. /* �ի�                        */                        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X40;K"  '"' wdetail.hp          '"' SKIP. /* ���˹ѡ/�ѹ                 */   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X41;K"  '"' wdetail.weight      '"' SKIP. /* �����              */   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X42;K"  '"' wdetail.seat        '"' SKIP. /* �ع��Сѹ�� 1               */                        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X43;K"  '"' wdetail.ins_amt1    '"' SKIP. /* �����ط��                  */                        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X44;K"  '"' wdetail.netprem     '"' SKIP. /* ����������������ҡû� 1    */                        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X45;K"  '"' wdetail.prem1       '"' SKIP. /* �����Ѻ���                */                        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X46;K"  '"' wdetail.time_notify '"' SKIP. /* �������˹�ҷ�� MKT         */                        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X47;K"  '"' wdetail.NAME_mkt    '"' SKIP. /* �����˵�                    */                        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X48;K"  '"' wdetail.bennam      '"' SKIP. /* ���Ѻ����� 1              */                        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X49;K"  '"' wdetail.drititle1   '"' SKIP. /* �ѹ�Դ���Ѻ��� 1          */                        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X50;K"  '"' wdetail.drivno1     '"' SKIP. /* �Ţ���㺢Ѻ��� 1            */                        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X51;K"  '"' wdetail.drivdat1    '"' SKIP. /* ���Ѻ����� 2              */                        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X52;K"  '"' wdetail.drivid1     '"' SKIP. /* �ѹ�Դ���Ѻ��� 2          */                        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X53;K"  '"' wdetail.drigender1  '"' SKIP. /* �Ţ���㺢Ѻ��� 2            */                        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X54;K"  '"' wdetail.drioccup1   '"' SKIP. /* �ӹ�˹�Ҫ��� (�����/㺡ӡѺ����)*/                  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X55;K"  '"' wdetail.driICNo1    '"' SKIP. /** ���� (�����/㺡ӡѺ����)      */                   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X56;K"  '"' wdetail.drilevel1   '"' SKIP.  /* ���ʡ�� (�����/㺡ӡѺ����)   */                   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X57;K"  '"' wdetail.drititle2   '"' SKIP.  /* ��ҹ�Ţ��� (�����/㺡ӡѺ����)*/                   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X58;K"  '"' wdetail.drivno2     '"' SKIP.  /* �Ӻ�/�ǧ (�����/㺡ӡѺ����) */                   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X59;K"  '"' wdetail.drivdat2    '"' SKIP.  /* �����/ࢵ (�����/㺡ӡѺ����) */                   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X60;K"  '"' wdetail.drivid2     '"' SKIP. /* �ѧ��Ѵ (�����/㺡ӡѺ����)   */                   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X61;K"  '"' wdetail.drigender2  '"' SKIP. /* ������ɳ��� (�����/㺡ӡѺ����) */                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X62;K"  '"' wdetail.drioccup2   '"' SKIP. /* ��ǹŴ����ѵԴ�             */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X63;K"  '"' wdetail.driICNo2    '"' SKIP. /* ��ǹŴ�ҹ Fleet             */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X64;K"  '"' wdetail.drilevel2   '"' SKIP. /* ����Դ���                 */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X65;K"  '"' wdetail.drilic3     '"' SKIP. /* �Ţ���ѵû�ЪҪ�           */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X66;K"  '"' wdetail.drititle3   '"' SKIP. /* �ѹ��͹���Դ              */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X67;K"  '"' wdetail.driname3    '"' SKIP. /* �Ҫվ                       */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X68;K"  '"' wdetail.drivno3     '"' SKIP. /* ʶҹ�Ҿ                     */ 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X69;K"  '"' wdetail.drigender3  '"' SKIP. /* �� */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X70;K"  '"' wdetail.drioccup3   '"' SKIP. /* �ѭ�ҵ� */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X71;K"  '"' wdetail.driICNo3    '"' SKIP. /* ������  */  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X72;K"  '"' wdetail.drilevel3   '"' SKIP. /* �Ţ��Шӵ�Ǽ�����������ҡ�  */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X73;K"  '"' wdetail.drilic4     '"' SKIP. /* �ӹ�˹�Ҫ��� 1              */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X74;K"  '"' wdetail.drititle4   '"' SKIP. /* ���͡������ 1               */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X75;K"  '"' wdetail.driname4    '"' SKIP. /* ���ʡ�š������ 1            */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X76;K"  '"' wdetail.drivno4     '"' SKIP. /* �Ţ���ѵû�ЪҪ�������� 1  */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X77;K"  '"' wdetail.drigender4  '"' SKIP. /* �ӹ�˹�Ҫ��� 2              */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X78;K"  '"' wdetail.drioccup4   '"' SKIP. /* ���͡������ 2               */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X79;K"  '"' wdetail.driICNo4    '"' SKIP. /* ���ʡ�š������ 2            */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X80;K"  '"' wdetail.drilevel4   '"' SKIP. /* �Ţ���ѵû�ЪҪ�������� 2  */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X81;K"  '"' wdetail.drilic5     '"' SKIP. /* �ӹ�˹�Ҫ��� 3              */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X82;K"  '"' wdetail.drititle5   '"' SKIP. /* ���͡������ 3               */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X83;K"  '"' wdetail.driname5    '"' SKIP. /* ���ʡ�š������ 3            */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X84;K"  '"' wdetail.drivno5     '"' SKIP. /* �Ţ���ѵû�ЪҪ�������� 3  */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X85;K"  '"' wdetail.drigender5  '"' SKIP. /* �Ѵ���͡��÷���Ң�         */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X86;K"  '"' wdetail.drioccup5   '"' SKIP. /* ���ͼ���Ѻ�͡���            */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X87;K"  '"' wdetail.driICNo5    '"' SKIP. /* ����Ѻ�Ż���ª��            */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X88;K"  '"' wdetail.drilevel5   '"' SKIP. /* KK ApplicationNo            */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X89;K"  '"' wdetail.reci_title  '"' SKIP. /* Remak1                      */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X90;K"  '"' wdetail.reci_name1  '"' SKIP. /* Remak2                      */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X91;K"  '"' wdetail.reci_name2  '"' SKIP. /* Dealer                      */ 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X92;K"  '"' wdetail.reci_1      '"' SKIP. /* Dealer TMSTH            */   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X93;K"  '"' wdetail.reci_2      '"' SKIP. /* Campaignno TMSTH            */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X94;K"  '"' wdetail.reci_3      '"' SKIP. /* Campaign OV                 */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X95;K"  '"' wdetail.reci_4      '"' SKIP. /* Producer code      */                                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X96;K"  '"' wdetail.reci_5      '"' SKIP. /* Agent code        */  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X97;K"  '"' wdetail.ncb         '"' SKIP. /*vat code  */  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X98;K"  '"' wdetail.fleet       '"' SKIP. /*ReferenceNo  */                                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X99;K"  '"' wdetail.phone       '"' SKIP. /* KK Quotation No.*/                                   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X100;K" '"' wdetail.icno        '"' SKIP. /* Rider  No.  */                                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X101;K" '"' wdetail.bdate       '"' SKIP. /* Release                     */                       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X102;K" '"' wdetail.occup       '"' SKIP. /* Loan First Date             */ 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X103;K" '"' wdetail.cstatus     '"' SKIP. /**A65-0288*/ 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X104;K" '"' wdetail.gender      '"' SKIP.  /*A65-0288*/ 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X105;K" '"' wdetail.nation      '"' SKIP.  /*A65-0288*/
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X106;K" '"' wdetail.email       '"' SKIP.  /*A65-0288*/
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X107;K" '"' wdetail.tax         '"' SKIP.  /*A65-0288*/
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X108;K" '"' wdetail.tname1      '"' SKIP.  /*A65-0288*/
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X109;K" '"' wdetail.cname1      '"' SKIP.  /*A65-0288*/
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X110;K" '"' wdetail.lname1      '"' SKIP.  //*A65-0288*/
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X111;K" '"' wdetail.icno1       '"' SKIP.   /*A65-0288*/
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X112;K" '"' wdetail.tname2      '"' SKIP.   /*A65-0288*/
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X113;K" '"' wdetail.cname2      '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X114;K" '"' wdetail.lname2      '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X115;K" '"' wdetail.icno2       '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X116;K" '"' wdetail.tname3      '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X117;K" '"' wdetail.cname3      '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X118;K" '"' wdetail.lname3      '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X119;K" '"' wdetail.icno3       '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X120;K" '"' wdetail.nsend       '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X121;K" '"' wdetail.sendname    '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X122;K" '"' wdetail.bennefit    '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X123;K" '"' wdetail.KKapp       '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X124;K" '"' wdetail.remak1      '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X125;K" '"' wdetail.remak2      '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X126;K" '"' wdetail.dealercd    '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X127;K" '"' wdetail.dealtms     '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X128;K" '"' wdetail.packcod     '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X129;K" '"' wdetail.campOV      '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X130;K" '"' wdetail.producer    '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X131;K" '"' wdetail.Agent       '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X132;K" '"' wdetail.vatcode     '"' SKIP .
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X133;K" '"' wdetail.RefNo       '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X134;K" '"' wdetail.KKQuo       '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X135;K" '"' wdetail.RiderNo     '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X136;K" '"' wdetail.releas      '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X137;K" '"' wdetail.loandat     '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X138;K" '"' wdetail.PolPrem     '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X139;K" '"' wdetail.probleam    '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X140;K" '"' wdetail.colors      '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X141;K" '"' wdetail.Inspection  '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X142;K" '"' wdetail.Insp_status '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X143;K" '"' wdetail.Insp_No     '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X144;K" '"' wdetail.Insp_Closed '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X145;K" '"' wdetail.Insp_Detail '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X146;K" '"' wdetail.insp_Damage '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X147;K" '"' wdetail.insp_Accessory '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X148;K" '"' wdetail.dateregis   '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X149;K" '"' wdetail.pay_option  '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X151;K" '"' wdetail.battno      '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X152;K" '"' wdetail.battyr      '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X153;K" '"' wdetail.maksi       '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X154;K" '"' wdetail.chargno     '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X155;K" '"' wdetail.veh_key     '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X156;K" '"' wdetail.remark      '"' SKIP.   
END.                                                  
nv_row  =  nv_row  + 1.                                                              
PUT STREAM ns2 "E".                                                                  
OUTPUT STREAM ns2 CLOSE.                                                             
/* ...end A67-0076 ...*/                                                                                    
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_uwd102 C-Win 
PROCEDURE proc_uwd102 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nvw_fptr  AS RECID.
DEF Var nv_fptr   As RECID   Initial    0.
DEF Var nv_bptr   As RECID   Initial    0.

DEF VAR nv_txt8   AS CHAR FORMAT "x(750)".
DEF VAR nv_f8     AS CHAR FORMAT "x(750)".

DO:
 ASSIGN  nv_txt8 = ""       nv_camp = ""  
         nv_f8   = ""
         nv_fptr = 0
         nv_bptr = 0
         nv_fptr = sicuw.uwm100.fptr02
         nv_bptr = sicuw.uwm100.bptr02.
         IF nv_fptr <> 0 Or nv_fptr <> ? THEN DO:   
             DO WHILE nv_fptr  <>  0 :
               
                FIND sicuw.uwd102  WHERE RECID(uwd102) = nv_fptr NO-LOCK NO-ERROR .
                IF AVAIL sicuw.uwd102 THEN DO:
                    nv_f8 = trim(SUBSTRING(uwd102.ltext,1,LENGTH(uwd102.ltext))). 
                    nv_fptr  =  uwd102.fptr.
                    IF nv_f8 = ? THEN nv_f8 = "" .
                END.
                ELSE DO: 
                    nv_fptr  = 0.
                END.
                nv_txt8 =  nv_txt8 + nv_f8.
                IF nv_fptr = 0 THEN LEAVE.
             END.
         END.
     RELEASE sicuw.uwd102.
     IF INDEX(nv_txt8,"Campaign") <> 0 THEN nv_camp = SUBSTR(nv_txt8,R-INDEX(nv_txt8,"Campaign")) .
     IF nv_camp <> "" THEN wdetail.remark = wdetail.remark + " " + nv_camp .
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pro_createfile C-Win 
PROCEDURE Pro_createfile :
/*------------------------------------------------------------------------------
Purpose:     
Parameters:  <none>
Notes:       
------------------------------------------------------------------------------*/
DEF VAR   nv_cnt   as  int  init   1.
DEF VAR   nv_row   as  int  init   0.
DEF VAR   n_record AS  INTE INIT   0.
ASSIGN 
    n_record = 0
    nv_cnt   = 0
    nv_row   = 1  .

If  substr(fi_outfile,length(fi_outfile) - 3,4) <>  ".slk"  THEN 
    fi_outfile  =  Trim(fi_outfile) + ".slk"  .

ASSIGN nv_cnt =  0
    nv_row    =  1 .

OUTPUT STREAM ns2 TO VALUE(fi_outfile).
PUT STREAM ns2 "ID;PND" SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"' "����ѷ�Թ�ع ��Ҥ�����õԹҤԹ �ӡѴ (��Ҫ�) ."  '"' SKIP.
nv_row  =  nv_row + 1.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"   '"' "�ӴѺ��� "                           '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"   '"' "�ѹ����Ѻ�� "                      '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"   '"' "�ѹ����Ѻ�Թ������»�Сѹ"         '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"   '"' "��ª��ͺ���ѷ��Сѹ��� "             '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"   '"' "�Ţ����ѭ����ҫ��� "                '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"   '"' "�Ţ��������������"                  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"   '"' "�Ţ������������� "                 '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"   '"' "�����Ң� "                           '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"   '"' "�Ң� KK "                            '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K"  '"' "�Ţ�Ѻ��� "                        '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K"  '"' "Campaign "                           '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K"  '"' "Sub Campaign "                       '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K"  '"' "�ؤ��/�ԵԺؤ�� "                    '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K"  '"' "�ӹ�˹�Ҫ��� "                       '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K"  '"' "���ͼ����һ�Сѹ "                   '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K"  '"' "���ʡ�ż����һ�Сѹ "                '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K"  '"' "��ҹ�Ţ���"                          '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K"  '"' "�Ӻ�/�ǧ "                          '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K"  '"' "�����/ࢵ "                          '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K"  '"' "�ѧ��Ѵ "                            '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K"  '"' "������ɳ��� "                       '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K"  '"' "����������������ͧ "                 '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K"  '"' "��������ë��� "                      '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K"  '"' "�ѹ�����������ͧ "                   '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K"  '"' "�ѹ����ش������ͧ "                 '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K"  '"' "����ö "                             '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K"  '"' "��������Сѹ���ö¹�� "              '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K"  '"' "����������ö "                       '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K"  '"' "���ö "                             '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K"  '"' "New/Used "                           '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K"  '"' "�Ţ����¹ "                         '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K"  '"' "�Ţ��Ƕѧ "                          '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K"  '"' "�Ţ����ͧ¹�� "                     '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K"  '"' "��ö¹�� "                           '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K"  '"' "�ի� "                               '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K"  '"' "���˹ѡ/�ѹ "                        '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K"  '"' "�ع��Сѹ�� 1 "                      '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K"  '"' "����������������ҡû� 1 "           '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X39;K"  '"' "�ع��Сѹ�� 2 "                      '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X40;K"  '"' "����������������ҡû� 2 "           '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X41;K"  '"' "�ع�٭���/�����"                   '"' SKIP.  /*a61-0335*/ 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X42;K"  '"' "�����Ѻ��� "                       '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X43;K"  '"' "�������˹�ҷ�� MKT "                '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X44;K"  '"' "�����˵� "                           '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X45;K"  '"' "���Ѻ����� 1 �����ѹ�Դ "         '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X46;K"  '"' "���Ѻ����� 2 �����ѹ�Դ "         '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X47;K"  '"' "�ӹ�˹�Ҫ��� (�����/㺡ӡѺ����) " '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X48;K"  '"' "���� (�����/㺡ӡѺ����) "         '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X49;K"  '"' "���ʡ�� (�����/㺡ӡѺ����) "      '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X50;K"  '"' "��ҹ�Ţ��� (�����/㺡ӡѺ����) "   '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X51;K"  '"' "�Ӻ�/�ǧ (�����/㺡ӡѺ����) "    '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X52;K"  '"' "�����/ࢵ (�����/㺡ӡѺ����) "    '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X53;K"  '"' "�ѧ��Ѵ (�����/㺡ӡѺ����) "      '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X54;K"  '"' "������ɳ��� (�����/㺡ӡѺ����) " '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X55;K"  '"' "��ǹŴ����ѵԴ� "                    '"' SKIP.  /*A55-0029*/
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X56;K"  '"' "��ǹŴ�ҹ Fleet "                    '"' SKIP.  /*A61-0335*/ 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X57;K"  '"'  "����Դ���      "                  '"' SKIP.  /*A61-0335*/ 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X58;K"  '"'  "�Ţ���ѵû�ЪҪ�"                  '"' SKIP.  /*A61-0335*/ 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X59;K"  '"'  "�ѹ��͹���Դ   "                  '"' SKIP.  /*A61-0335*/ 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X60;K"  '"'  "�Ҫվ            "                  '"' SKIP.  /*A61-0335*/ 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X61;K"  '"'  "ʶҹ�Ҿ          "                  '"' SKIP.  /*A61-0335*/ 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X62;K"  '"'  "�Ţ��Шӵ�Ǽ�����������ҡ� "        '"' SKIP.  /*A61-0335*/ 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X63;K"  '"'  "�ӹ�˹�Ҫ��� 1   "                  '"' SKIP.  /*A61-0335*/ 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X64;K"  '"'  "���͡������ 1    "                  '"' SKIP.  /*A61-0335*/ 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X65;K"  '"'  "���ʡ�š������ 1 "                  '"' SKIP.  /*A61-0335*/ 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X66;K"  '"'  "�Ţ���ѵû�ЪҪ�������� 1 "        '"' SKIP.  /*A61-0335*/ 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X67;K"  '"'  "�ӹ�˹�Ҫ��� 2   "                  '"' SKIP.  /*A61-0335*/ 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X68;K"  '"'  "���͡������ 2    "                  '"' SKIP.  /*A61-0335*/ 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X69;K"  '"'  "���ʡ�š������ 2 "                  '"' SKIP.  /*A61-0335*/ 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X70;K"  '"'  "�Ţ���ѵû�ЪҪ�������� 2 "        '"' SKIP.  /*A61-0335*/ 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X71;K"  '"'  "�ӹ�˹�Ҫ��� 3   "                  '"' SKIP.  /*A61-0335*/ 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X72;K"  '"'  "���͡������ 3    "                  '"' SKIP.  /*A61-0335*/ 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X73;K"  '"'  "���ʡ�š������ 3 "                  '"' SKIP.  /*A61-0335*/ 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X74;K"  '"'  "�Ţ���ѵû�ЪҪ�������� 3 "        '"' SKIP.  /*A61-0335*/ 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X75;K"  '"'  "�Ѵ���͡��÷���Ң�  "              '"' SKIP.  /*A61-0335*/ 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X76;K"  '"'  "���ͼ���Ѻ�͡��� "                  '"' SKIP.  /*A61-0335*/ 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X77;K"  '"'  "����Ѻ�Ż���ª�� "                  '"' SKIP.  /*A61-0335*/
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X78;K"  '"'  "KK Applicationno."                                '"' SKIP.  /*A61-0335*/

FOR EACH wdetail WHERE wdetail.chassis <> "" no-lock.
    ASSIGN 
        n_record =  n_record + 1
        nv_cnt   =  nv_cnt  + 1 
        nv_row   =  nv_row  + 1.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"'   n_record               '"' SKIP. /*�ӴѺ��� */                        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"'   wdetail.Notify_dat     '"' SKIP. /*�ѹ����Ѻ�� */                   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"'   wdetail.recive_dat     '"' SKIP. /*�ѹ����Ѻ�Թ������»�Сѹ*/      
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"  '"'   wdetail.comp_code      '"' SKIP. /*��ª��ͺ���ѷ��Сѹ��� */          
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"'   wdetail.cedpol         '"' SKIP. /*�Ţ����ѭ����ҫ��� */             
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"  '"'   wdetail.n_policy       '"' SKIP. /*�Ţ��������������*/               
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"  '"'   wdetail.prepol         '"' SKIP. /*�Ţ������������� */                      
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"  '"'   wdetail.cmbr_no        '"' SKIP. /*�����Ң� */                                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"  '"'   wdetail.cmbr_code      '"' SKIP. /*�Ң� KK */                                 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K"  '"'  wdetail.notifyno       '"' SKIP. /*�Ţ�Ѻ��� */                             
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K"  '"'  wdetail.campaigno      '"' SKIP. /*Campaign */                                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K"  '"'  wdetail.campaigsub     '"' SKIP. /*Sub Campaign */                            
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K"  '"'  wdetail.typper         '"' SKIP. /*�ؤ��/�ԵԺؤ�� */                         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K"  '"'  wdetail.n_TITLE        '"' SKIP. /*�ӹ�˹�Ҫ��� */                            
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K"  '"'  wdetail.n_name1        '"' SKIP. /*���ͼ����һ�Сѹ */                        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K"  '"'  wdetail.n_name2        '"' SKIP. /*���ʡ�ż����һ�Сѹ */                     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K"  '"'  wdetail.ADD_1          '"' SKIP. /*��ҹ�Ţ���*/                                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K"  '"'  wdetail.ADD_2          '"' SKIP. /*�Ӻ�/�ǧ */                               
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K"  '"'  wdetail.ADD_3          '"' SKIP. /*�����/ࢵ */                               
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K"  '"'  wdetail.ADD_4          '"' SKIP. /*�ѧ��Ѵ */                                 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K"  '"'  wdetail.ADD_5          '"' SKIP. /*������ɳ��� */                            
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K"  '"'  wdetail.cover          '"' SKIP. /*����������������ͧ */                      
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K"  '"'  wdetail.garage         '"' SKIP. /*��������ë��� */                           
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K"  '"'  wdetail.comdat         '"' SKIP. /*�ѹ�����������ͧ */                        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K"  '"'  wdetail.expdat         '"' SKIP. /*�ѹ����ش������ͧ */                      
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K"  '"'  wdetail.subclass       '"' SKIP. /*����ö */                                  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K"  '"'  wdetail.n_43           '"' SKIP. /*��������Сѹ���ö¹�� */                   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K"  '"'  wdetail.brand          '"' SKIP. /*����������ö */                            
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K"  '"'  wdetail.model          '"' SKIP. /*���ö */                             
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K"  '"'  wdetail.nSTATUS        '"' SKIP. /*New/Used */                           
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K"  '"'  wdetail.licence        '"' SKIP. /*�Ţ����¹ */                         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K"  '"'  wdetail.chassis        '"' SKIP. /*�Ţ��Ƕѧ */                               
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K"  '"'  wdetail.engine         '"' SKIP. /*�Ţ����ͧ¹�� */                          
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K"  '"'  wdetail.cyear          '"' SKIP. /*��ö¹�� */                                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K"  '"'  wdetail.power          '"' SKIP. /*�ի� */                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K"  '"'  wdetail.weight         '"' SKIP. /*���˹ѡ/�ѹ */                             
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K"  '"'  wdetail.ins_amt1       '"' SKIP. /*�ع��Сѹ�� 1 */                           
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K"  '"'  wdetail.prem1          '"' SKIP. /*����������������ҡû� 1 */                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X39;K"  '"'  wdetail.ins_amt2       '"' SKIP. /*�ع��Сѹ�� 2 */                            
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X40;K"  '"'  wdetail.prem2          '"' SKIP. /*����������������ҡû� 2 */           
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X41;K"  '"'  wdetail.fi             '"' SKIP. /*�ع����� */              
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X42;K"  '"'  wdetail.time_notify    '"' SKIP.  /*�����Ѻ��� */                      
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X43;K"  '"'  wdetail.NAME_mkt       '"' SKIP.  /*�������˹�ҷ�� MKT */               
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X44;K"  '"'  wdetail.bennam         '"' SKIP.  /*�����˵� */             
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X45;K"  '"'  wdetail.drivno1        '"' SKIP.                              
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X46;K"  '"'  wdetail.drivno2        '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X47;K"  '"'  wdetail.reci_title     '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X48;K"  '"'  wdetail.reci_name1     '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X49;K"  '"'  wdetail.reci_name2     '"' SKIP.          
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X50;K"  '"'  wdetail.reci_1         '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X51;K"  '"'  wdetail.reci_2         '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X52;K"  '"'  wdetail.reci_3         '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X53;K"  '"'  wdetail.reci_4         '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X54;K"  '"'  wdetail.reci_5         '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X55;K"  '"'  wdetail.ncb            '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X56;K"  '"'  wdetail.fleet           '"' SKIP.  /*A61-0335*/ 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X57;K"  '"'  wdetail.phone           '"' SKIP.  /*A61-0335*/ 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X58;K"  '"'  wdetail.icno            '"' SKIP.  /*A61-0335*/ 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X59;K"  '"'  wdetail.bdate           '"' SKIP.  /*A61-0335*/ 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X60;K"  '"'  wdetail.occup           '"' SKIP.  /*A61-0335*/ 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X61;K"  '"'  wdetail.cstatus         '"' SKIP.  /*A61-0335*/ 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X62;K"  '"'  wdetail.tax             '"' SKIP.  /*A61-0335*/ 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X63;K"  '"'  wdetail.tname1          '"' SKIP.  /*A61-0335*/ 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X64;K"  '"'  wdetail.cname1          '"' SKIP.  /*A61-0335*/ 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X65;K"  '"'  wdetail.lname1          '"' SKIP.  /*A61-0335*/ 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X66;K"  '"'  wdetail.icno1           '"' SKIP.  /*A61-0335*/ 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X67;K"  '"'  wdetail.tname2          '"' SKIP.  /*A61-0335*/ 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X68;K"  '"'  wdetail.cname2          '"' SKIP.  /*A61-0335*/ 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X69;K"  '"'  wdetail.lname2          '"' SKIP.  /*A61-0335*/ 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X70;K"  '"'  wdetail.icno2           '"' SKIP.  /*A61-0335*/ 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X71;K"  '"'  wdetail.tname3          '"' SKIP.  /*A61-0335*/ 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X72;K"  '"'  wdetail.cname3          '"' SKIP.  /*A61-0335*/ 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X73;K"  '"'  wdetail.lname3          '"' SKIP.  /*A61-0335*/ 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X74;K"  '"'  wdetail.icno3           '"' SKIP.  /*A61-0335*/ 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X75;K"  '"'  wdetail.nsend           '"' SKIP.  /*A61-0335*/ 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X76;K"  '"'  wdetail.sendname        '"' SKIP.  /*A61-0335*/ 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X77;K"  '"'  wdetail.bennefit        '"' SKIP.  /*A61-0335*/
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X78;K"  '"'  wdetail.KKapp           '"' SKIP.  /*A61-0335*/

END.    /*  end  wdetail  */
nv_row  =  nv_row  + 1. 
PUT STREAM ns2 "E".
OUTPUT STREAM ns2 CLOSE.  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pro_createfileKK C-Win 
PROCEDURE pro_createfileKK :
/*------------------------------------------------------------------------------
Purpose:     
Parameters:  <none>
Notes:       
------------------------------------------------------------------------------*/
DEF VAR   nv_cnt   as  int  init   1.
DEF VAR   nv_row   as  int  init   0.
DEF VAR   n_record AS  INTE INIT   0.
ASSIGN 
    n_record = 0
    nv_cnt   = 0
    nv_row   = 1  .

If  substr(fi_outfile2,length(fi_outfile2) - 3,4) <>  ".slk"  THEN 
    fi_outfile2  =  Trim(fi_outfile2) + ".slk"  .

ASSIGN nv_cnt =  0
    nv_row    =  1 .

OUTPUT STREAM ns2 TO VALUE(fi_outfile2).
PUT STREAM ns2 "ID;PND" SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"' "����ѷ�Թ�ع ��Ҥ�����õԹҤԹ �ӡѴ (��Ҫ�) ."  '"' SKIP.
nv_row  =  nv_row + 1.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"   '"' "�ӴѺ���       "            '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"   '"' "����ѷ��Сѹ   "            '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"   '"' "�Ţ���������� "            '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"   '"' "�����Ң�       "            '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"   '"' "�Ң� KK        "            '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"   '"' "�Ţ����ѭ��    "            '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"   '"' "�ӹ�˹�Ҫ���   "            '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"   '"' "���ͼ����һ�Сѹ"           '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"   '"' "���ʡ�ż����һ�Сѹ"        '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K"  '"' "�Ţ����Ѻ��  "            '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K"  '"' "�ѹ����͡�Ţ����Ѻ��"     '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K"  '"' "�Ţ����¹     "            '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K"  '"' "������ö       "            '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K"  '"' "�Ţ���ö       "            '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K"  '"' "���˹�ҷ�� MKT"            '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K"  '"' "���˹�ҷ�����"           '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K"  '"' "����������������ͧ "        '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K"  '"' "��������ë���  "            '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K"  '"' "�ع��Сѹ      "            '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K"  '"' "���������������ҡ�"        '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K"  '"' "�ѹ������� �ú"            '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K"  '"' "�ѹ����ش �ú "            '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K"  '"' "���ͼ���Ѻ "                '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K"  '"' "��ҹ�Ţ��� "                '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K"  '"' "����       "                '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K"  '"' "�����ҹ   "                '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K"  '"' "�Ҥ��      "                '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K"  '"' "���        "                '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K"  '"' "���        "                '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K"  '"' "�Ӻ�/�ǧ  "                '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K"  '"' "�����/ࢵ  "                '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K"  '"' "�ѧ��Ѵ    "                '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K"  '"' "������ɳ���  "             '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K"  '"' "�����˵�   "                '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K"  '"' "����Դ���"                '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K"  '"' "�Ѵ���͡��÷���Ң�"        '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K"  '"' "���ͼ���Ѻ�͡���   "        '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K"  '"' "KK ApplicationNo.  "        '"' SKIP. 

FOR EACH wdetail WHERE wdetail.chassis <> "" no-lock.
    ASSIGN 
        n_record =  n_record + 1
        nv_cnt   =  nv_cnt  + 1 
        nv_row   =  nv_row  + 1.


    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"'   n_record            '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"'   wdetail.comp_code   '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"'   wdetail.n_policy    '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"  '"'   wdetail.cmbr_no     '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"'   wdetail.cmbr_code   '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"  '"'   wdetail.cedpol      '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"  '"'   wdetail.n_TITLE     '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"  '"'   wdetail.n_name1     '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"  '"'   wdetail.n_name2     '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K"  '"'  wdetail.notifyno    '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K"  '"'  wdetail.Notify_dat  '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K"  '"'  wdetail.licence     '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K"  '"'  wdetail.brand       '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K"  '"'  wdetail.chassis     '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K"  '"'  wdetail.NAME_mkt    '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K"  '"'  ""                  '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K"  '"'  wdetail.cover       '"' SKIP.          
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K"  '"'  wdetail.garage      '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K"  '"'  wdetail.ins_amt2    '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K"  '"'  wdetail.prem2       '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K"  '"'  wdetail.comdat      '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K"  '"'  wdetail.expdat      '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K"  '"'  wdetail.sendname    '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K"  '"'  " "                 '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K"  '"'  " "                 '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K"  '"'  " "                 '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K"  '"'  " "                 '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K"  '"'  " "                 '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K"  '"'  " "                 '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K"  '"'  " "                 '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K"  '"'  " "                 '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K"  '"'  " "                 '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K"  '"'  " "                 '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K"  '"'  " "                 '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K"  '"'  wdetail.phone       '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K"  '"'  wdetail.nsend       '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K"  '"'  wdetail.sendname    '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K"  '"'  wdetail.KKapp       '"' SKIP.         
    
END.    /*  end  wdetail  */
nv_row  =  nv_row  + 1. 
PUT STREAM ns2 "E".
OUTPUT STREAM ns2 CLOSE.  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pro_matchfile_prem C-Win 
PROCEDURE pro_matchfile_prem :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR  n_poltyp AS CHAR . 
DEF VAR  n_status AS CHAR.
FOR EACH wdetail .
    n_poltyp = "" .
    n_status = "no" .
    IF rs_type = 1 THEN n_poltyp = "V70".
    ELSE DO:
        IF trim(wdetail.cover) = "T" THEN n_poltyp = "V72".
        ELSE n_poltyp = "V70" .
    END.
    IF trim(wdetail.kkapp) <> "" THEN DO:
        
        FIND LAST brstat.tlt USE-INDEX tlt06 WHERE 
            brstat.tlt.cha_no   = trim(wdetail.chassis)  AND   /*Modify by      : Kridtiya i. A66-0140 chang index tlt05 to tlt06    */
            brstat.tlt.expotim  = trim(wdetail.kkapp) AND         
            brstat.tlt.genusr   =  "kk"                NO-ERROR NO-WAIT.
        IF AVAIL brstat.tlt THEN DO:
            
            FIND LAST sicuw.uwm100 USE-INDEX uwm10002      WHERE  
                sicuw.uwm100.cedpol = trim(wdetail.kkapp)  AND 
                sicuw.uwm100.comdat <> ?                   AND
                sicuw.uwm100.comdat = DATE(wdetail.comdat) AND
                sicuw.uwm100.poltyp = n_poltyp   NO-LOCK NO-ERROR.  
            IF AVAIL sicuw.uwm100 THEN DO: 
                
                IF index(brstat.tlt.releas,"YES") <> 0 THEN ASSIGN brstat.tlt.releas  = brstat.tlt.releas .
                ELSE IF brstat.tlt.releas = "NO" THEN ASSIGN brstat.tlt.releas  = "YES".
                ELSE ASSIGN brstat.tlt.releas  = "YES/CA".
                ASSIGN brstat.tlt.policy       = sicuw.uwm100.policy 
                    wdetail.n_policy = sicuw.uwm100.policy
                    wdetail.brtms    = sicuw.uwm100.branch 
                    wdetail.vatcode  = sicuw.uwm100.bs_cd  
                    wdetail.remark   = tlt.releas
                    n_status = "yes"   .
                IF uwm100.prem_t = deci(wdetail.netprem ) THEN wdetail.remark = wdetail.remark + "/���µç".
                ELSE wdetail.remark = wdetail.remark + "/�������ç " + STRING(uwm100.prem_t - deci(wdetail.netprem)).
                RUN proc_uwd102. 
            END.
            ELSE ASSIGN wdetail.n_policy = " "
                wdetail.remark   = "����բ�����㹶ѧ�ѡ".
            /*Modify by      : Kridtiya i. A66-0140 chang index tlt05 to tlt06    */
            IF wdetail.n_policy = "" THEN DO:
                FIND LAST sicuw.uwm100 USE-INDEX uwm10002 WHERE  
                    sicuw.uwm100.cedpol = trim(wdetail.kkapp) AND 
                    sicuw.uwm100.comdat <> ?                   AND
                    sicuw.uwm100.comdat = DATE(wdetail.comdat) AND
                    sicuw.uwm100.poltyp = n_poltyp   NO-LOCK NO-ERROR. 
                IF AVAIL sicuw.uwm100 THEN DO:
                    IF index(brstat.tlt.releas,"YES") <> 0 THEN ASSIGN brstat.tlt.releas  = brstat.tlt.releas .
                    ELSE IF brstat.tlt.releas = "NO" THEN ASSIGN brstat.tlt.releas  = "YES".
                    ELSE ASSIGN brstat.tlt.releas  = "YES/CA".
                    ASSIGN  brstat.tlt.policy       = sicuw.uwm100.policy  
                        wdetail.n_policy = sicuw.uwm100.policy 
                        wdetail.brtms    = sicuw.uwm100.branch 
                        wdetail.vatcode  = sicuw.uwm100.bs_cd  
                        wdetail.remark   = brstat.tlt.releas
                        n_status = "yes"  .
                    IF uwm100.prem_t = deci(wdetail.netprem ) THEN wdetail.remark = wdetail.remark + "/���µç".
                    ELSE wdetail.remark = wdetail.remark + "/�������ç " + STRING(uwm100.prem_t - deci(wdetail.netprem)).
                    RUN proc_uwd102. 
                END.
                ELSE ASSIGN wdetail.n_policy = " "
                    wdetail.remark   = wdetail.remark + "/��辺�������� ".
            END.   /*wdetail.n_policy = ""*/
        END.  /* brstat.tlt */
    END.   /*trim(wdetail.kkapp) <> ""*/
    /*Modify by      : Kridtiya i. A66-0140 chang index tlt05 to tlt06    */
    IF n_status = "no"  THEN DO:
     
        IF trim(wdetail.cedpol) <> "" THEN DO:
        FIND LAST brstat.tlt  WHERE       
            brstat.tlt.nor_noti_tlt   =  trim(wdetail.cedpol) AND   /* A64-0135*/ 
            brstat.tlt.genusr         =  "kk"             NO-ERROR NO-WAIT.
        IF AVAIL brstat.tlt THEN DO:
            
            FIND LAST sicuw.uwm100 USE-INDEX uwm10002 WHERE  
                sicuw.uwm100.cedpol = trim(wdetail.cedpol) AND
                sicuw.uwm100.comdat <> ?                   AND
                sicuw.uwm100.comdat = date(wdetail.comdat) AND
                sicuw.uwm100.poltyp = n_poltyp   NO-LOCK NO-ERROR. 
            IF AVAIL sicuw.uwm100 THEN DO:
                
                IF index(brstat.tlt.releas,"YES") <> 0 THEN ASSIGN brstat.tlt.releas  = brstat.tlt.releas .
                ELSE IF brstat.tlt.releas = "NO" THEN ASSIGN brstat.tlt.releas  = "YES".
                ELSE ASSIGN brstat.tlt.releas  = "YES/CA".
                ASSIGN  brstat.tlt.policy = sicuw.uwm100.policy 
                    wdetail.n_policy  = sicuw.uwm100.policy 
                    wdetail.brtms     = sicuw.uwm100.branch 
                    wdetail.vatcode   = sicuw.uwm100.bs_cd  
                    wdetail.remark    = brstat.tlt.releas.
                IF uwm100.prem_t = deci(wdetail.netprem ) THEN wdetail.remark = wdetail.remark + "/���µç".
                ELSE wdetail.remark = wdetail.remark + "/�������ç " + STRING(uwm100.prem_t - deci(wdetail.netprem)).
                RUN proc_uwd102. /* A65-0288 */
            END.
            ELSE ASSIGN wdetail.n_policy = " "
                wdetail.remark   = "����բ�����㹶ѧ�ѡ".
        END.
       
        IF wdetail.n_policy = ""  THEN DO:
            FIND LAST sicuw.uwm100 USE-INDEX uwm10002 WHERE  
                sicuw.uwm100.cedpol = trim(wdetail.cedpol) AND 
                sicuw.uwm100.comdat <> ?                   AND
                sicuw.uwm100.comdat = date(wdetail.comdat) AND
                sicuw.uwm100.poltyp = n_poltyp   NO-LOCK NO-ERROR.  /*A64-0135*/
            IF AVAIL sicuw.uwm100 THEN DO:
                IF sicuw.uwm100.expdat >  date(wdetail.comdat) THEN DO: 
                    ASSIGN  wdetail.n_policy = sicuw.uwm100.policy 
                        wdetail.brtms    = sicuw.uwm100.branch 
                        wdetail.vatcode  = sicuw.uwm100.bs_cd  
                        wdetail.remark   = "��辺������㹶ѧ�ѡ" .
                    IF uwm100.prem_t = deci(wdetail.netprem ) THEN wdetail.remark = wdetail.remark + "/���µç".
                    ELSE wdetail.remark = wdetail.remark + "/�������ç " + STRING(uwm100.prem_t - deci(wdetail.netprem)).
                         RUN proc_uwd102. /* A65-0288 */
                END.
            END.
            ELSE ASSIGN wdetail.n_policy = " "
                wdetail.remark   = wdetail.remark + "/��辺�������� ".
        END.
    END.
    END.  /*Modify by      : Kridtiya i. A66-0140 chang index tlt05 to tlt06    */
END.  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pro_matchfile_prem-01 C-Win 
PROCEDURE Pro_matchfile_prem-01 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*comment by Kridtiya i. A55-0055
FOR EACH wdetail .
    FIND LAST brstat.tlt  WHERE       
        brstat.tlt.comp_noti_tlt   =  wdetail.notifyno AND 
        tlt.genusr                 =  "kk"             NO-ERROR NO-WAIT.
    IF AVAIL brstat.tlt THEN DO:
        FIND LAST sicuw.uwm100 USE-INDEX uwm10002 WHERE  
            sicuw.uwm100.cedpol = trim(wdetail.cedpol) NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL sicuw.uwm100 THEN DO:
            IF sicuw.uwm100.poltyp = "V70"  THEN  
                ASSIGN  
                wdetail.n_policy = sicuw.uwm100.policy
                tlt.releas =  "yes". 
        END.
        ELSE 
            ASSIGN tlt.releas =  "No".
                wdetail.n_policy = "".

        /*IF INDEX(tlt.releas,"yes") = 0 THEN DO: 
            IF tlt.releas = "" THEN
                ASSIGN tlt.releas =  "yes".
            ELSE DO:  
                IF INDEX(tlt.releas,"cancel") = 0 THEN 
                    ASSIGN tlt.releas = "yes".
                ELSE ASSIGN tlt.releas = "cancel/yes".
            END.
        END.*/
    END.
END.      /* wdetail*/
end...comment by Kridtiya i. A55-0055*/
/*
DEF VAR  n_poltyp AS CHAR .  /* A64-0135 */
/*Add by Kridtiya i. A55-0055*/
FOR EACH wdetail .
    /* A64-0135 */
    n_poltyp = "" .
    IF rs_type = 1 THEN n_poltyp = "V70".
    ELSE DO:
        IF trim(wdetail.cover) = "T" THEN n_poltyp = "V72".
        ELSE n_poltyp = "V70" .
    END.
    /* end A64-0135 */
    FIND LAST brstat.tlt  WHERE       
        /*brstat.tlt.comp_noti_tlt   =  wdetail.notifyno AND */ /* A64-0135*/
        brstat.tlt.expotim  =  trim(wdetail.kkapp) AND         /* A64-0135 */
        brstat.tlt.genusr   =  "kk"             NO-ERROR NO-WAIT.
    IF AVAIL brstat.tlt THEN DO:
        FIND LAST sicuw.uwm100 USE-INDEX uwm10002      WHERE  
            sicuw.uwm100.cedpol = trim(wdetail.cedpol) AND 
            sicuw.uwm100.comdat = DATE(wdetail.comdat) AND
            /*sicuw.uwm100.poltyp = "V70"              */       /*A64-0135*/
            sicuw.uwm100.poltyp = n_poltyp   NO-LOCK NO-ERROR.  /*A64-0135*/
        IF AVAIL sicuw.uwm100 THEN DO: 
            IF index(tlt.releas,"YES") <> 0 THEN ASSIGN tlt.releas  = tlt.releas .
            ELSE IF tlt.releas = "NO" THEN ASSIGN tlt.releas  = "YES".
            ELSE ASSIGN tlt.releas  = "YES/CA".
            ASSIGN tlt.policy       = sicuw.uwm100.policy /*A64-0135*/
                   wdetail.n_policy = sicuw.uwm100.policy
                   wdetail.brtms    = sicuw.uwm100.branch /*A64-0135*/
                   wdetail.vatcode  = sicuw.uwm100.bs_cd  /*A64-0135*/
                   wdetail.remark   = tlt.releas .
            IF uwm100.prem_t = deci(wdetail.netprem ) THEN wdetail.remark = wdetail.remark + "/���µç".
            ELSE wdetail.remark = wdetail.remark + "/�������ç " + STRING(uwm100.prem_t - deci(wdetail.netprem)).
        END.
        ELSE DO:
            /* create by A61-0335*/
            FIND LAST sicuw.uwm100 USE-INDEX uwm10002 WHERE  
                sicuw.uwm100.cedpol = trim(wdetail.kkapp) AND 
                sicuw.uwm100.comdat = DATE(wdetail.comdat) AND
                /*sicuw.uwm100.poltyp = "V70"              */       /*A64-0135*/
                sicuw.uwm100.poltyp = n_poltyp   NO-LOCK NO-ERROR.  /*A64-0135*/
            IF AVAIL sicuw.uwm100 THEN DO:
               IF index(tlt.releas,"YES") <> 0 THEN ASSIGN tlt.releas  = tlt.releas .
               ELSE IF tlt.releas = "NO" THEN ASSIGN tlt.releas  = "YES".
               ELSE ASSIGN tlt.releas  = "YES/CA".
               ASSIGN  tlt.policy       = sicuw.uwm100.policy /*A64-0135*/
                       wdetail.n_policy = sicuw.uwm100.policy 
                       wdetail.brtms    = sicuw.uwm100.branch /*A64-0135*/
                       wdetail.vatcode  = sicuw.uwm100.bs_cd  /*A64-0135*/
                       wdetail.remark   = tlt.releas.

            IF uwm100.prem_t = deci(wdetail.netprem ) THEN wdetail.remark = wdetail.remark + "/���µç".
            ELSE wdetail.remark = wdetail.remark + "/�������ç " + STRING(uwm100.prem_t - deci(wdetail.netprem)).
               
            END.
            /*end A61-0335*/
            ELSE ASSIGN wdetail.n_policy = " "
                        wdetail.remark   = "��辺�������� ".
        END.
    END.
    /* add by : A64-0135 */
    ELSE DO:
        FIND LAST brstat.tlt  WHERE       
            brstat.tlt.nor_noti_tlt   =  trim(wdetail.cedpol) AND   /* A64-0135*/ 
            brstat.tlt.genusr         =  "kk"             NO-ERROR NO-WAIT.
        IF AVAIL brstat.tlt THEN DO:
             FIND LAST sicuw.uwm100 USE-INDEX uwm10002 WHERE  
                    sicuw.uwm100.cedpol = trim(wdetail.kkapp) AND
                    sicuw.uwm100.comdat = date(wdetail.comdat) AND
                    sicuw.uwm100.poltyp = n_poltyp   NO-LOCK NO-ERROR. 
                IF AVAIL sicuw.uwm100 THEN DO:
                   IF index(brstat.tlt.releas,"YES") <> 0 THEN ASSIGN brstat.tlt.releas  = brstat.tlt.releas .
                   ELSE IF brstat.tlt.releas = "NO" THEN ASSIGN brstat.tlt.releas  = "YES".
                   ELSE ASSIGN brstat.tlt.releas  = "YES/CA".
                   ASSIGN  brstat.tlt.policy = sicuw.uwm100.policy 
                           wdetail.n_policy  = sicuw.uwm100.policy 
                           wdetail.brtms     = sicuw.uwm100.branch 
                           wdetail.vatcode   = sicuw.uwm100.bs_cd  
                           wdetail.remark    = brstat.tlt.releas.
                   IF uwm100.prem_t = deci(wdetail.netprem ) THEN wdetail.remark = wdetail.remark + "/���µç".
                   ELSE wdetail.remark = wdetail.remark + "/�������ç " + STRING(uwm100.prem_t - deci(wdetail.netprem)).
                END.
                ELSE ASSIGN wdetail.n_policy = " "
                            wdetail.remark   = "��辺�������� ".
        END.
        ELSE DO:
            FIND LAST sicuw.uwm100 USE-INDEX uwm10002 WHERE  
                      sicuw.uwm100.cedpol = trim(wdetail.kkapp) AND 
                      sicuw.uwm100.comdat = date(wdetail.comdat) AND
                      sicuw.uwm100.poltyp = n_poltyp   NO-LOCK NO-ERROR.  /*A64-0135*/
                IF AVAIL sicuw.uwm100 THEN DO:
                    IF sicuw.uwm100.expdat >  date(wdetail.comdat) THEN DO: 
                        ASSIGN  wdetail.n_policy = sicuw.uwm100.policy 
                                wdetail.brtms    = sicuw.uwm100.branch 
                                wdetail.vatcode  = sicuw.uwm100.bs_cd  
                                wdetail.remark   = "��辺������㹶ѧ�ѡ" .
                        IF uwm100.prem_t = deci(wdetail.netprem ) THEN wdetail.remark = wdetail.remark + "/���µç".
                        ELSE wdetail.remark = wdetail.remark + "/�������ç " + STRING(uwm100.prem_t - deci(wdetail.netprem)).
                    END.
                END.
                ELSE ASSIGN wdetail.n_policy = ""  
                            wdetail.remark = "��辺��������/ ��辺������㹶ѧ�ѡ" .
        END.
    END.
    /* end: A64-0135 */
END. */ /* wdetail*/
/*Add by Kridtiya i. A55-0055*/
 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pro_matchfile_prem_bk C-Win 
PROCEDURE pro_matchfile_prem_bk :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR  n_poltyp AS CHAR .  /* A64-0135 */
/*Add by Kridtiya i. A55-0055*/
FOR EACH wdetail .
    /* A64-0135 */
    n_poltyp = "" .
    IF rs_type = 1 THEN n_poltyp = "V70".
    ELSE DO:
        IF trim(wdetail.cover) = "T" THEN n_poltyp = "V72".
        ELSE n_poltyp = "V70" .
    END.
    /* end A64-0135 */
    IF trim(wdetail.kkapp) <> "" THEN DO:
        FIND LAST brstat.tlt  WHERE       
            brstat.tlt.expotim  =  trim(wdetail.kkapp) AND         
            brstat.tlt.genusr   =  "kk"             NO-ERROR NO-WAIT.
        IF AVAIL brstat.tlt THEN DO:
            FIND LAST sicuw.uwm100 USE-INDEX uwm10002      WHERE  
                sicuw.uwm100.cedpol = trim(wdetail.kkapp) AND 
                sicuw.uwm100.comdat <> ?                   AND
                sicuw.uwm100.comdat = DATE(wdetail.comdat) AND
                sicuw.uwm100.poltyp = n_poltyp   NO-LOCK NO-ERROR.  /*A64-0135*/
            IF AVAIL sicuw.uwm100 THEN DO: 
                IF index(tlt.releas,"YES") <> 0 THEN ASSIGN tlt.releas  = tlt.releas .
                ELSE IF tlt.releas = "NO" THEN ASSIGN tlt.releas  = "YES".
                ELSE ASSIGN tlt.releas  = "YES/CA".
                ASSIGN tlt.policy       = sicuw.uwm100.policy /*A64-0135*/
                       wdetail.n_policy = sicuw.uwm100.policy
                       wdetail.brtms    = sicuw.uwm100.branch /*A64-0135*/
                       wdetail.vatcode  = sicuw.uwm100.bs_cd  /*A64-0135*/
                       wdetail.remark   = tlt.releas .
                IF uwm100.prem_t = deci(wdetail.netprem ) THEN wdetail.remark = wdetail.remark + "/���µç".
                ELSE wdetail.remark = wdetail.remark + "/�������ç " + STRING(uwm100.prem_t - deci(wdetail.netprem)).
                RUN proc_uwd102. /* A65-0288 */
            END.
            ELSE ASSIGN wdetail.n_policy = " "
                        wdetail.remark   = "����բ�����㹶ѧ�ѡ".
        END.
        IF wdetail.n_policy = "" THEN DO:
            /* create by A61-0335*/
            FIND LAST sicuw.uwm100 USE-INDEX uwm10002 WHERE  
                sicuw.uwm100.cedpol = trim(wdetail.kkapp) AND 
                sicuw.uwm100.comdat <> ?                   AND
                sicuw.uwm100.comdat = DATE(wdetail.comdat) AND
                sicuw.uwm100.poltyp = n_poltyp   NO-LOCK NO-ERROR. 
            IF AVAIL sicuw.uwm100 THEN DO:
               IF index(tlt.releas,"YES") <> 0 THEN ASSIGN tlt.releas  = tlt.releas .
               ELSE IF tlt.releas = "NO" THEN ASSIGN tlt.releas  = "YES".
               ELSE ASSIGN tlt.releas  = "YES/CA".
               ASSIGN  tlt.policy       = sicuw.uwm100.policy /*A64-0135*/
                       wdetail.n_policy = sicuw.uwm100.policy 
                       wdetail.brtms    = sicuw.uwm100.branch /*A64-0135*/
                       wdetail.vatcode  = sicuw.uwm100.bs_cd  /*A64-0135*/
                       wdetail.remark   = tlt.releas.

               IF uwm100.prem_t = deci(wdetail.netprem ) THEN wdetail.remark = wdetail.remark + "/���µç".
               ELSE wdetail.remark = wdetail.remark + "/�������ç " + STRING(uwm100.prem_t - deci(wdetail.netprem)).
               RUN proc_uwd102. /* A65-0288 */
               
            END.
            /*end A61-0335*/
            ELSE ASSIGN wdetail.n_policy = " "
                        wdetail.remark   = wdetail.remark + "/��辺�������� ".
        END.
    END.
    /* add by : A64-0135 */
    ELSE IF trim(wdetail.cedpol) <> "" THEN DO:
        FIND LAST brstat.tlt  WHERE       
            brstat.tlt.nor_noti_tlt   =  trim(wdetail.cedpol) AND   /* A64-0135*/ 
            brstat.tlt.genusr         =  "kk"             NO-ERROR NO-WAIT.
        IF AVAIL brstat.tlt THEN DO:
             FIND LAST sicuw.uwm100 USE-INDEX uwm10002 WHERE  
                    sicuw.uwm100.cedpol = trim(wdetail.cedpol) AND
                    sicuw.uwm100.comdat <> ?                   AND
                    sicuw.uwm100.comdat = date(wdetail.comdat) AND
                    sicuw.uwm100.poltyp = n_poltyp   NO-LOCK NO-ERROR. 
                IF AVAIL sicuw.uwm100 THEN DO:
                   IF index(brstat.tlt.releas,"YES") <> 0 THEN ASSIGN brstat.tlt.releas  = brstat.tlt.releas .
                   ELSE IF brstat.tlt.releas = "NO" THEN ASSIGN brstat.tlt.releas  = "YES".
                   ELSE ASSIGN brstat.tlt.releas  = "YES/CA".
                   ASSIGN  brstat.tlt.policy = sicuw.uwm100.policy 
                           wdetail.n_policy  = sicuw.uwm100.policy 
                           wdetail.brtms     = sicuw.uwm100.branch 
                           wdetail.vatcode   = sicuw.uwm100.bs_cd  
                           wdetail.remark    = brstat.tlt.releas.
                   IF uwm100.prem_t = deci(wdetail.netprem ) THEN wdetail.remark = wdetail.remark + "/���µç".
                   ELSE wdetail.remark = wdetail.remark + "/�������ç " + STRING(uwm100.prem_t - deci(wdetail.netprem)).
                   RUN proc_uwd102. /* A65-0288 */

                END.
                ELSE ASSIGN wdetail.n_policy = " "
                            wdetail.remark   = "����բ�����㹶ѧ�ѡ".
        END.
        IF wdetail.n_policy = ""  THEN DO:
            FIND LAST sicuw.uwm100 USE-INDEX uwm10002 WHERE  
                      sicuw.uwm100.cedpol = trim(wdetail.cedpol) AND 
                      sicuw.uwm100.comdat <> ?                   AND
                      sicuw.uwm100.comdat = date(wdetail.comdat) AND
                      sicuw.uwm100.poltyp = n_poltyp   NO-LOCK NO-ERROR.  /*A64-0135*/
                IF AVAIL sicuw.uwm100 THEN DO:
                    IF sicuw.uwm100.expdat >  date(wdetail.comdat) THEN DO: 
                        ASSIGN  wdetail.n_policy = sicuw.uwm100.policy 
                                wdetail.brtms    = sicuw.uwm100.branch 
                                wdetail.vatcode  = sicuw.uwm100.bs_cd  
                                wdetail.remark   = "��辺������㹶ѧ�ѡ" .
                        IF uwm100.prem_t = deci(wdetail.netprem ) THEN wdetail.remark = wdetail.remark + "/���µç".
                        ELSE wdetail.remark = wdetail.remark + "/�������ç " + STRING(uwm100.prem_t - deci(wdetail.netprem)).
                        RUN proc_uwd102. /* A65-0288 */
                    END.
                END.
                ELSE ASSIGN wdetail.n_policy = " "
                            wdetail.remark   = wdetail.remark + "/��辺�������� ".
        END.
    END.
    /* end: A64-0135 */
END.  /* wdetail*/
/*Add by Kridtiya i. A55-0055*/
 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

