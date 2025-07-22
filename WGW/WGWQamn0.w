&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          brstat           PROGRESS
*/
&Scoped-define WINDOW-NAME c-wins
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS c-wins 
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
/* ***************************  Definitions  ************************** */

/* Parameters Definitions ---                                           */

/* Local Variable Definitions ---                                       */

/*++++++++++++++++++++++++++++++++++++++++++++++
  wgwqtis0.w :  Import text file from  ICBCTL  to create  new policy   
                         Add in table  tlt  
                         Query & Update flag detail
  Create  by : Kridtiya i. [A53-0207]   On   28/05/2010
  Connect    : sic_test, stat   
  modify by  : kridtiya i. A54-0216 ��Ѻ����ʴ������������������觢�� 
  modify by  : kridtiya i. A55-0184 22/05/2012 ��Ѻ����ʴ������������������觢�� 
  modify by  : Kridtiya i. A55-0365 ������ǹ������¡��§ҹ�ʴ��ҹ��ҧ�к�
  modify by  : Kridtiya i. A56-0146 ���� ��� update status yes/no/cancel 㹢������á��
  modify by  : Kridtiya i. A56-0323 ���� ��� ����� record �á
/*modify by  : Kridtiya i. A57-0262 add new format idno and id br name */
/*Modify by  : Ranu I. A60-0263 ������ô֧������ Campagin �͡���� */
/*modify by  : Ranu I. A61-0221 ��� format file �駧ҹ           */
/*modify by  : Ranu I. A62-0445 ����������� suspect ,��� format file load */
/*Modify by  : Ranu I. A64-0150 date.31/03/2021 �����Ҫ�ͧ�Ţ������������͡ */
+++++++++++++++++++++++++++++++++++++++++++++++*/

 Def    var  nv_rectlt    as recid  init  0.
 Def    var  nv_recidtlt  as recid  init  0.
 DEFINE VAR  n_asdat      AS CHAR.
 DEFINE VAR  vAcProc_fil  AS CHAR.
 DEFINE VAR  n_asdat1     AS CHAR. /*A55-0365 */
 DEFINE VAR  vAcProc_fil1 AS CHAR. /*A55-0365 */
 DEF VAR nv_filemat AS CHAR FORMAT "x(60)".

 DEFINE NEW SHARED WORKFILE wdetail NO-UNDO
     FIELD n_no          AS CHAR FORMAT "X(3)"   INIT ""  /*No                   */  
     FIELD branch        AS CHAR FORMAT "X(20)"   INIT ""  /*OffCde               */          
     FIELD safe_no       AS CHAR FORMAT "X(18)"  INIT ""  /*InsuranceReceivedNo  */          
     FIELD Account_no    AS CHAR FORMAT "X(12)"  INIT ""  /*ApplNo               */          
     FIELD name_insur    AS CHAR FORMAT "X(100)" INIT ""  /*CustName             */          
     FIELD icno          AS CHAR FORMAT "X(13)"  INIT ""  /*IDNo                 */          
     FIELD garage        AS CHAR FORMAT "X(2)"   INIT ""  /*RepairType           */          
     FIELD CustAge       AS CHAR FORMAT "X(2)"   INIT ""  /*CustAge              */          
     FIELD Category      AS CHAR FORMAT "X(50)"   INIT ""  /*Category             */          
     FIELD CarType       AS CHAR FORMAT "X(30)"   INIT ""  /*CarType              */          
     FIELD brand         AS CHAR FORMAT "X(30)"  INIT ""  /*Brand                */          
     FIELD Brand_Model   AS CHAR FORMAT "X(30)"  INIT ""  /*Model                */          
     FIELD CC            AS CHAR FORMAT "X(10)"  INIT ""  /*CC                   */          
     FIELD yrmanu        AS CHAR FORMAT "X(5)"   INIT ""  /*CarYear              */          
     FIELD RegisDate     AS CHAR FORMAT "X(15)"  INIT ""  /*RegisDate            */          
     FIELD engine        AS CHAR FORMAT "X(15)"  INIT ""  /*EngineNo             */          
     FIELD chassis       AS CHAR FORMAT "X(15)"  INIT ""  /*ChassisNo            */          
     FIELD RegisNo       AS CHAR FORMAT "X(13)"  INIT ""  /*RegisNo              */          
     FIELD RegisProv     AS CHAR FORMAT "X(25)"  INIT ""  /*RegisProv            */          
     FIELD n_class       AS CHAR FORMAT "X(5)"   INIT ""  /*InsLicTyp            */          
     FIELD InsTyp        AS CHAR FORMAT "X(30)"   INIT ""  /*InsTyp               */  
     FIELD comtyp        AS CHAR FORMAT "X(30)"   INIT "" /* comtyp  */
     FIELD CovTyp        AS CHAR FORMAT "X(30)"   INIT ""  /*CovTyp               */          
     FIELD SI            AS CHAR FORMAT "X(15)"  INIT ""  /*InsuranceAmt (crash) */ 
     FIELD comdat        AS CHAR FORMAT "X(15)"  INIT ""  /*InsuranceStartDate   */          
     FIELD expdat        AS CHAR FORMAT "X(15)"  INIT ""  /*InsuranceExpireDate  */          
     FIELD netprem       AS CHAR FORMAT "X(15)"  INIT ""  /*InsuranceNetFee      */          
     FIELD totalprem     AS CHAR FORMAT "X(15)"  INIT ""  /*InsuranceFee         */ 
     FIELD ben_name      AS CHAR FORMAT "X(50)"  INIT ""  /*Beneficiary          */          
     FIELD CMRName       AS CHAR FORMAT "X(50)"  INIT ""  /*CMRName              */          
     FIELD sckno         AS CHAR FORMAT "X(13)"  INIT ""  /*InsurancePolicyNo    */  
     FIELD comp_prm      AS CHAR FORMAT "X(10)"  INIT ""  /*LawInsFee            */          
     FIELD Remark        AS CHAR FORMAT "X(255)" INIT ""  /*Other                */          
     FIELD DealerName    AS CHAR FORMAT "X(60)"  INIT ""  /*DealerName           */          
     FIELD CustAddress   AS CHAR FORMAT "X(150)" INIT ""  /*CustAddress          */          
     FIELD prevpol       AS CHAR FORMAT "x(13)"  INIT ""
     FIELD pol_addr1     as char format "x(150)" init ""           /*��������١���         */ 
     FIELD branch_saf    AS CHAR FORMAT "x(2)"   INIT ""
     FIELD comp_prmtotal AS CHAR FORMAT "x(10)"  INIT ""
     FIELD producer      AS CHAR FORMAT "x(10)"  INIT ""
     FIELD not_time      AS CHAR FORMAT "x(15)"   INIT ""
     FIELD otherins      AS CHAR FORMAT "x(100)" INIT ""
     FIELD campaign      AS CHAR FORMAT "x(20)"  INIT ""
     FIELD compno        AS CHAR FORMAT "x(13)"  INIT ""
     FIELD saleid        AS CHAR FORMAT "x(15)"  INIT ""
     FIELD taxname       AS CHAR FORMAT "x(50)"  INIT ""
     FIELD taxno         AS CHAR FORMAT "x(15)"  INIT ""
     FIELD n_color       AS CHAR FORMAT "x(30)"  INIT "" 
     FIELD accsor        as CHAR FORMAT "X(120)" INIT ""
     FIELD accsor_price  as CHAR FORMAT "X(15)"  INIT ""
     FIELD drivname1     as char format "x(60)"  init ""
     FIELD drivdate1     as char format "x(15)"  init ""
     FIELD drivid1       as char format "x(15)"  init ""
     FIELD drivname2     as char format "x(60)"  init ""
     FIELD drivdate2     as char format "x(15)"  init ""
     FIELD drivid2       as char format "x(15)"  init ""
     FIELD pack          AS CHAR FORMAT "x(2)"   INIT ""
     FIELD agent         AS CHAR FORMAT "x(10)"  INIT ""
     FIELD vatcode       AS CHAR FORMAT "x(10)"  INIT "" 
     FIELD inspect       AS CHAR FORMAT "x(15)"  INIT ""
     FIELD occup         AS CHAR FORMAT "x(50)"  INIT ""
     FIELD cartyp        as char format "x(50)" init "" 
     FIELD typins        as char format "x(20)" init "" 
     FIELD bdate         as char format "x(15)" init "" 
     FIELD expbdate      as char format "x(15)" init "" 
     FIELD name2         as char format "x(100)" init "" 
     FIELD pol_title     as char format "x(15)"  init ""
     FIELD pol_fname     as char format "x(150)"  init ""
     FIELD pol_addr2     as char format "x(50)" init "" 
     FIELD pol_addr3     as char format "x(50)" init "" 
     FIELD pol_addr4     as char format "x(50)" init "" 
     FIELD pol_addr5     as char format "x(50)" init "" 
     FIELD phone         as char format "x(25)" init "" 
     FIELD drivno        as char format "x(30)" init "" 
     FIELD drivgen1      as char format "x(10)" init "" 
     FIELD drivocc1      as char format "x(50)" init "" 
     FIELD drivgen2      as char format "x(10)" init "" 
     FIELD drivocc2      as char format "x(50)" init "" 
     FIELD stk           as char format "x(15)" init "" 
     FIELD policy        AS CHAR FORMAT "x(15)" INIT ""    /*A62-0445*/
     FIELD appno         AS CHAR FORMAT "x(20)" INIT ""    /*A62-0445*/
     FIELD ispresult     AS CHAR FORMAT "x(255)" INIT ""   /*A62-0445*/
     FIELD comment       AS CHAR FORMAT "x(150)" INIT "" . /*A62-0445*/

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main
&Scoped-define BROWSE-NAME br_tlt

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES tlt

/* Definitions for BROWSE br_tlt                                        */
&Scoped-define FIELDS-IN-QUERY-br_tlt tlt.releas ~
If  tlt.flag  =  "N"  Then  "New"  Else If  tlt.flag = "R" Then  "Renew" Else  " " ~
IF (tlt.expotim = "") THEN ("NO") ELSE ("YES") tlt.safe2 tlt.exp ~
tlt.filler1 tlt.nor_noti_ins tlt.comp_pol tlt.ins_name tlt.cha_no ~
tlt.gendat tlt.expodat tlt.nor_coamt tlt.nor_grprm tlt.rec_addr4 ~
tlt.comp_grprm tlt.comp_sck 
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_tlt 
&Scoped-define QUERY-STRING-br_tlt FOR EACH tlt NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-br_tlt OPEN QUERY br_tlt FOR EACH tlt NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-br_tlt tlt
&Scoped-define FIRST-TABLE-IN-QUERY-br_tlt tlt


/* Definitions for FRAME fr_main                                        */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS bu_exit ra_status fi_trndatfr fi_trndatto ~
bu_ok cb_search bu_oksch br_tlt fi_search bu_update cb_report fi_br ~
fi_outfile bu_report bu_upyesno buimp bu_match RECT-332 RECT-338 RECT-339 ~
RECT-340 RECT-341 RECT-381 RECT-382 RECT-342 
&Scoped-Define DISPLAYED-OBJECTS ra_status fi_trndatfr fi_trndatto ~
cb_search fi_search fi_name cb_report fi_br fi_outfile fi_match 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR c-wins AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON buimp 
     LABEL "..." 
     SIZE 4 BY .95
     FONT 6.

DEFINE BUTTON bu_exit 
     LABEL "EXIT" 
     SIZE 10 BY 1.

DEFINE BUTTON bu_match 
     LABEL "MATCH" 
     SIZE 10.67 BY .95.

DEFINE BUTTON bu_ok 
     LABEL "OK" 
     SIZE 9 BY 1
     FONT 6.

DEFINE BUTTON bu_oksch 
     LABEL "OK" 
     SIZE 5 BY .95
     FONT 6.

DEFINE BUTTON bu_report 
     LABEL "EXPORT" 
     SIZE 10.67 BY .95.

DEFINE BUTTON bu_update 
     LABEL "CANCEL" 
     SIZE 14 BY 1.05
     BGCOLOR 6 FONT 6.

DEFINE BUTTON bu_upyesno 
     LABEL "YES/NO" 
     SIZE 14 BY 1.05
     BGCOLOR 2 FONT 6.

DEFINE VARIABLE cb_report AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEMS "Item 1" 
     DROP-DOWN-LIST
     SIZE 40 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE cb_search AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEMS "���ͼ����һ�Сѹ" 
     DROP-DOWN-LIST
     SIZE 40 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_br AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 15.67 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_match AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 81.17 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_name AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 39 BY .95
     BGCOLOR 15 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_outfile AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 58.5 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_search AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 48 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_trndatfr AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 26.5 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_trndatto AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 26.5 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE ra_status AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "Yes", 1,
"No", 2,
"Cancel", 3,
"All", 4
     SIZE 31 BY 1
     BGCOLOR 8 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-332
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132.5 BY 8.48
     BGCOLOR 10 .

DEFINE RECTANGLE RECT-338
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 58.5 BY 2.91
     BGCOLOR 29 .

DEFINE RECTANGLE RECT-339
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 71 BY 2.91
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-340
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 130.5 BY 1.67
     BGCOLOR 21 .

DEFINE RECTANGLE RECT-341
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 14 BY 1.43
     BGCOLOR 4 .

DEFINE RECTANGLE RECT-342
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 12 BY 1.43
     BGCOLOR 2 .

DEFINE RECTANGLE RECT-381
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 7.5 BY 1.52
     BGCOLOR 2 FGCOLOR 2 .

DEFINE RECTANGLE RECT-382
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 13.67 BY 1.24
     BGCOLOR 14 .

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_tlt FOR 
      tlt SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_tlt
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_tlt c-wins _STRUCTURED
  QUERY br_tlt NO-LOCK DISPLAY
      tlt.releas COLUMN-LABEL "YES/NO" FORMAT "x(20)":U WIDTH 10
      If  tlt.flag  =  "N"  Then  "New"  Else If  tlt.flag = "R" Then  "Renew"
Else  " " COLUMN-LABEL "New/Renew" FORMAT "x(8)":U
            WIDTH 11.83 LABEL-FGCOLOR 1 LABEL-FONT 6
      IF (tlt.expotim = "") THEN ("NO") ELSE ("YES") COLUMN-LABEL "Susupect" FORMAT "X(5)":U
      tlt.safe2 COLUMN-LABEL "�Ţ����ѭ��" FORMAT "x(20)":U WIDTH 14.83
      tlt.exp COLUMN-LABEL "�Ң�" FORMAT "X(15)":U WIDTH 12.83
      tlt.filler1 COLUMN-LABEL "����������" FORMAT "x(20)":U
            WIDTH 15
      tlt.nor_noti_ins COLUMN-LABEL "��������" FORMAT "x(20)":U
            WIDTH 15
      tlt.comp_pol COLUMN-LABEL "���� �ú." FORMAT "x(20)":U WIDTH 15
      tlt.ins_name COLUMN-LABEL "���� - ʡ��" FORMAT "x(50)":U
            WIDTH 25
      tlt.cha_no COLUMN-LABEL "�Ţ��Ƕѧ" FORMAT "x(20)":U
      tlt.gendat COLUMN-LABEL "�ѹ��������ͧ" FORMAT "99/99/9999":U
      tlt.expodat COLUMN-LABEL "�ѹ����������" FORMAT "99/99/9999":U
      tlt.nor_coamt COLUMN-LABEL "�ع��Сѹ" FORMAT "->,>>>,>>>,>>9.99":U
      tlt.nor_grprm COLUMN-LABEL "�����ط��" FORMAT ">>,>>>,>>9.99":U
      tlt.rec_addr4 COLUMN-LABEL "���� �ú." FORMAT "x(10)":U
      tlt.comp_grprm COLUMN-LABEL "���� ��. + �ú." FORMAT "->>,>>>,>>9.99":U
      tlt.comp_sck COLUMN-LABEL "Sticker no." FORMAT "x(15)":U
            WIDTH 14.17
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 132.5 BY 15
         BGCOLOR 15 FGCOLOR 1 FONT 1 ROW-HEIGHT-CHARS .75.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     bu_exit AT ROW 1.57 COL 106.67
     ra_status AT ROW 6.05 COL 80 NO-LABEL
     fi_trndatfr AT ROW 1.67 COL 25.33 COLON-ALIGNED NO-LABEL
     fi_trndatto AT ROW 1.67 COL 61.5 COLON-ALIGNED NO-LABEL
     bu_ok AT ROW 1.57 COL 94.17
     cb_search AT ROW 3.19 COL 16.83 COLON-ALIGNED NO-LABEL
     bu_oksch AT ROW 4.52 COL 53.33
     br_tlt AT ROW 9.81 COL 1.33
     fi_search AT ROW 4.43 COL 3.67 NO-LABEL
     fi_name AT ROW 4.43 COL 61 COLON-ALIGNED NO-LABEL
     bu_update AT ROW 4.48 COL 102.83
     cb_report AT ROW 6.1 COL 16.33 COLON-ALIGNED NO-LABEL
     fi_br AT ROW 7.24 COL 16.33 COLON-ALIGNED NO-LABEL
     fi_outfile AT ROW 7.24 COL 52.5 NO-LABEL
     bu_report AT ROW 7.19 COL 111.67
     bu_upyesno AT ROW 4.48 COL 118
     fi_match AT ROW 8.38 COL 24.33 NO-LABEL
     buimp AT ROW 8.38 COL 105.5
     bu_match AT ROW 8.33 COL 111.67
     "CLICK FOR UPDATE DATA FLAG CANCEL":40 VIEW-AS TEXT
          SIZE 41.5 BY .95 AT ROW 3.19 COL 63.33
          BGCOLOR 19 FGCOLOR 6 FONT 6
     "REPORT BY :" VIEW-AS TEXT
          SIZE 14 BY .95 AT ROW 6.14 COL 3.33
          BGCOLOR 3 FGCOLOR 7 FONT 6
     "MATCH FILE LOAD :" VIEW-AS TEXT
          SIZE 20.5 BY .95 AT ROW 8.38 COL 3.5
          BGCOLOR 14 FGCOLOR 2 FONT 6
     " STATUS FLAG :" VIEW-AS TEXT
          SIZE 17 BY 1 AT ROW 6.05 COL 62
          BGCOLOR 3 FGCOLOR 7 FONT 6
     "    BRANCH :" VIEW-AS TEXT
          SIZE 13.83 BY .95 AT ROW 7.24 COL 3.5
          BGCOLOR 3 FGCOLOR 7 FONT 6
     "To  :" VIEW-AS TEXT
          SIZE 7.5 BY 1 AT ROW 1.67 COL 55
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " OUTPUT NAME :" VIEW-AS TEXT
          SIZE 17.17 BY .95 AT ROW 7.24 COL 34.5
          BGCOLOR 3 FGCOLOR 7 FONT 6
     "�ѹ�������駧ҹ  From :" VIEW-AS TEXT
          SIZE 21.5 BY 1 AT ROW 1.67 COL 4.83
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "SEARCH BY :" VIEW-AS TEXT
          SIZE 14 BY 1 AT ROW 3.19 COL 4.33
          BGCOLOR 29 FGCOLOR 0 FONT 6
     RECT-332 AT ROW 1.1 COL 1.33
     RECT-338 AT ROW 2.95 COL 2.5
     RECT-339 AT ROW 2.95 COL 61.83
     RECT-340 AT ROW 1.24 COL 2.33
     RECT-341 AT ROW 1.33 COL 104.83
     RECT-381 AT ROW 4.24 COL 52.17
     RECT-382 AT ROW 8.19 COL 110
     RECT-342 AT ROW 1.33 COL 92.67
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133.17 BY 24
         BGCOLOR 1 .


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
  CREATE WINDOW c-wins ASSIGN
         HIDDEN             = YES
         TITLE              = "Query && Update [Amanah]"
         HEIGHT             = 24
         WIDTH              = 133
         MAX-HEIGHT         = 24
         MAX-WIDTH          = 133.17
         VIRTUAL-HEIGHT     = 24
         VIRTUAL-WIDTH      = 133.17
         RESIZE             = yes
         SCROLL-BARS        = no
         STATUS-AREA        = no
         BGCOLOR            = ?
         FGCOLOR            = ?
         KEEP-FRAME-Z-ORDER = yes
         THREE-D            = yes
         FONT               = 6
         MESSAGE-AREA       = no
         SENSITIVE          = yes.
ELSE {&WINDOW-NAME} = CURRENT-WINDOW.

&IF '{&WINDOW-SYSTEM}' NE 'TTY' &THEN
IF NOT c-wins:LOAD-ICON("wimage\safety":U) THEN
    MESSAGE "Unable to load icon: wimage\safety"
            VIEW-AS ALERT-BOX WARNING BUTTONS OK.
&ENDIF
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW c-wins
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME fr_main
   FRAME-NAME Custom                                                    */
/* BROWSE-TAB br_tlt bu_oksch fr_main */
/* SETTINGS FOR FILL-IN fi_match IN FRAME fr_main
   NO-ENABLE ALIGN-L                                                    */
/* SETTINGS FOR FILL-IN fi_name IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_outfile IN FRAME fr_main
   ALIGN-L                                                              */
/* SETTINGS FOR FILL-IN fi_search IN FRAME fr_main
   ALIGN-L                                                              */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(c-wins)
THEN c-wins:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_tlt
/* Query rebuild information for BROWSE br_tlt
     _TblList          = "brstat.tlt"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _FldNameList[1]   > brstat.tlt.releas
"tlt.releas" "YES/NO" "x(20)" "character" ? ? ? ? ? ? no ? no no "10" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[2]   > "_<CALC>"
"If  tlt.flag  =  ""N""  Then  ""New""  Else If  tlt.flag = ""R"" Then  ""Renew""
Else  "" """ "New/Renew" "x(8)" ? ? ? ? ? 1 6 no ? no no "11.83" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   > "_<CALC>"
"IF (tlt.expotim = """") THEN (""NO"") ELSE (""YES"")" "Susupect" "X(5)" ? ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   > brstat.tlt.safe2
"tlt.safe2" "�Ţ����ѭ��" "x(20)" "character" ? ? ? ? ? ? no ? no no "14.83" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   > brstat.tlt.exp
"tlt.exp" "�Ң�" "X(15)" "character" ? ? ? ? ? ? no ? no no "12.83" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[6]   > brstat.tlt.filler1
"tlt.filler1" "����������" "x(20)" "character" ? ? ? ? ? ? no ? no no "15" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[7]   > brstat.tlt.nor_noti_ins
"tlt.nor_noti_ins" "��������" "x(20)" "character" ? ? ? ? ? ? no ? no no "15" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[8]   > brstat.tlt.comp_pol
"tlt.comp_pol" "���� �ú." "x(20)" "character" ? ? ? ? ? ? no ? no no "15" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[9]   > brstat.tlt.ins_name
"tlt.ins_name" "���� - ʡ��" ? "character" ? ? ? ? ? ? no ? no no "25" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[10]   > brstat.tlt.cha_no
"tlt.cha_no" "�Ţ��Ƕѧ" ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[11]   > brstat.tlt.gendat
"tlt.gendat" "�ѹ��������ͧ" ? "date" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[12]   > brstat.tlt.expodat
"tlt.expodat" "�ѹ����������" "99/99/9999" "date" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[13]   > brstat.tlt.nor_coamt
"tlt.nor_coamt" "�ع��Сѹ" ? "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[14]   > brstat.tlt.nor_grprm
"tlt.nor_grprm" "�����ط��" ">>,>>>,>>9.99" "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[15]   > brstat.tlt.rec_addr4
"tlt.rec_addr4" "���� �ú." "x(10)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[16]   > brstat.tlt.comp_grprm
"tlt.comp_grprm" "���� ��. + �ú." ? "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[17]   > brstat.tlt.comp_sck
"tlt.comp_sck" "Sticker no." "x(15)" "character" ? ? ? ? ? ? no ? no no "14.17" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _Query            is NOT OPENED
*/  /* BROWSE br_tlt */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME c-wins
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c-wins c-wins
ON END-ERROR OF c-wins /* Query  Update [Amanah] */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c-wins c-wins
ON WINDOW-CLOSE OF c-wins /* Query  Update [Amanah] */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br_tlt
&Scoped-define SELF-NAME br_tlt
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_tlt c-wins
ON LEFT-MOUSE-DBLCLICK OF br_tlt IN FRAME fr_main
DO:
    Get Current br_tlt.
          nv_recidtlt  =  Recid(tlt).

    {&WINDOW-NAME}:hidden  =  Yes. 
        Run  wgw\wgwqamn1(Input  nv_recidtlt).
    {&WINDOW-NAME}:hidden  =  No.                                               

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_tlt c-wins
ON VALUE-CHANGED OF br_tlt IN FRAME fr_main
DO:
     Get  current  br_tlt.
     nv_rectlt =  recid(tlt).
     fi_name   =  tlt.ins_name.
     disp  fi_name  with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buimp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buimp c-wins
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
         ASSIGN
            fi_match  = cvData
            nv_filemat = SUBSTRING(cvData,1,(LENGTH(fi_match) - 4)) + no_add + "_Load.csv" . /*.csv*/
           
         DISP fi_match WITH FRAME fr_main. 
         APPLY "Entry" TO fi_match.
         RETURN NO-APPLY.
    END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_exit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_exit c-wins
ON CHOOSE OF bu_exit IN FRAME fr_main /* EXIT */
DO:
  APPLY "CLOSE" TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_match
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_match c-wins
ON CHOOSE OF bu_match IN FRAME fr_main /* MATCH */
DO:
    IF fi_match = "" THEN DO:
        MESSAGE "��س��ʪ������!!!"  VIEW-AS ALERT-BOX.
        Apply "Entry"  to fi_match.
        Return no-apply. 
    END.
    ELSE DO:
        FOR EACH  wdetail :                                                                          
            DELETE  wdetail.                                                                         
        END.                                                                                         
        INPUT FROM VALUE(fi_match).                                                               
        REPEAT:
        CREATE wdetail.
        IMPORT DELIMITER "|"       
            wdetail.n_no            /*�ӴѺ���        */                                        
            wdetail.RegisDate       /*�ѹ�����      */                                        
            wdetail.Account_no      /*�Ţ�Ѻ�駧ҹ   */
            /*wdetail.prevpol         /*�Ţ��������      */  */ /*A64-0150 */
            wdetail.safe_no         /*���ʺ��ѷ       */                                        
            wdetail.CMRName         /*���ͼ����     */                                        
            wdetail.branch          /*�Ң�            */                                        
            wdetail.cartyp          /*��������Сѹ    */                                        
            wdetail.typins          /*������ö        */                                        
            wdetail.CovTyp          /*����������������ͧ */                                     
            wdetail.InsTyp          /*��Сѹ ��/�����  */                                     
            wdetail.comtyp          /*�ú.   ��/�����  */                                     
            wdetail.comdat          /*�ѹ�����������ͧ*/                                        
            wdetail.expdat          /*�ѹ����ش����������ͧ */                                 
            wdetail.pol_title        /*�ӹ�˹�Ҫ���    */                                        
            wdetail.pol_fname      /*���ͼ����һ�Сѹ*/                                        
            wdetail.icno            /*�Ţ���ѵû�ЪҪ�  */                                     
            wdetail.bdate           /*�ѹ�Դ         */                                        
            wdetail.expbdate        /*�ѹ���ѵ��������  */                                         
            wdetail.occup           /*�Ҫվ           */                                        
            wdetail.name2           /*���͡������     */                                        
            wdetail.pol_addr1       /*��ҹ�Ţ���      */                                        
            wdetail.pol_addr2       /*�Ӻ�/�ǧ       */                                        
            wdetail.pol_addr3       /*�����/ࢵ       */                                        
            wdetail.pol_addr4       /*�ѧ��Ѵ         */                                        
            wdetail.pol_addr5       /*������ɳ���    */                                        
            wdetail.phone           /*�������Ѿ��   */                                        
            wdetail.drivno          /*�кؼ��Ѻ���/����кؼ��Ѻ��*/                           
            wdetail.drivname1       /*���Ѻ��褹���1  */                                       
            wdetail.drivgen1        /*��              */                                       
            wdetail.drivdate1       /*�ѹ�Դ          */                                       
            wdetail.drivocc1        /*�ҪѾ            */                                       
            wdetail.drivid1         /*�Ţ���㺢Ѻ���   */                                       
            wdetail.drivname2       /*���Ѻ��褹���2  */                                       
            wdetail.drivgen2        /*��              */                                       
            wdetail.drivdate2       /*�ѹ�Դ          */                                       
            wdetail.drivocc2        /*�ҪѾ            */                                       
            wdetail.drivid2         /*�Ţ���㺢Ѻ���   */                                       
            wdetail.brand           /*����������ö     */                                       
            wdetail.Brand_Model     /*���ö           */                                       
            wdetail.engine          /*�Ţ����ͧ¹��   */                                       
            wdetail.chassis         /*�Ţ��Ƕѧ        */                                       
            wdetail.CC              /*�ի�             */                                       
            wdetail.yrmanu          /*��ö¹��         */                                       
            wdetail.RegisNo         /*�Ţ����¹       */                                       
            wdetail.RegisProv       /*�ѧ��Ѵ��訴����¹ */                                    
            wdetail.garage          /*��ë���          */                                       
            wdetail.SI              /*�ع��Сѹ        */                                       
            wdetail.netprem         /*�����ط��       */                                       
            wdetail.totalprem       /*���»�Сѹ      */                                       
            wdetail.comp_prm        /*���¾ú.        */                                       
            wdetail.comp_prmtotal   /*������� �ú.    */                                       
            wdetail.stk             /*�Ţʵ������    */                                       
            wdetail.taxname         /*�͡�����㹹��  */                                       
            wdetail.ben_name        /*����Ѻ�Ż���ª�� */                                       
            wdetail.Remark          /*�����˵�         */
            wdetail.policy          /*�Ţ��������       */  /*A62-0445*/
            wdetail.inspect        /*�Ţ��Ǩ��Ҿ      */
            wdetail.appno .        /*�Ţ App no */         /*A62-0445*/
            IF INDEX(wdetail.n_no,"�駧ҹ")    <> 0 THEN  DELETE wdetail.
            ELSE IF INDEX(wdetail.n_no,"�ӴѺ") <> 0 THEN  DELETE wdetail.
            ELSE IF INDEX(wdetail.n_no,"���")   <> 0 THEN  DELETE wdetail.
            ELSE IF INDEX(wdetail.n_no,"No")    <> 0 THEN  DELETE wdetail.
            ELSE IF  wdetail.n_no               = "" THEN  DELETE wdetail.
        END.  /* repeat  */
        RUN pd_reportfileload.
        Message "Export data Complete"  View-as alert-box.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_ok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_ok c-wins
ON CHOOSE OF bu_ok IN FRAME fr_main /* OK */
DO:
    /*If  fi_polfr  =  "0"   Then  fi_polfr  =  "0"  .
    If  fi_polto  =  "Z"   Then  fi_polto  =  "Z".*/
    Open Query br_tlt 
        For each tlt Use-index  tlt01  Where
        tlt.trndat  >=   fi_trndatfr   And
        tlt.trndat  <=   fi_trndatto   AND /*
        tlt.subin    =   "V70"         OR
        tlt.subin    =   "V72"        AND 
        tlt.policy  <=   fi_polto     And*/
        /*tlt.comp_sub  =  fi_producer  And*/
        tlt.genusr   =  "amanah"        no-lock.  
            nv_rectlt =  recid(tlt).   /*A55-0184*/
            Apply "Entry"  to br_tlt.
            Return no-apply.                             
            /*------------------------ 
            {&WINDOW-NAME}:hidden  =  Yes. 
            Run  wuw\wuwqtis1(Input  fi_trndatfr,
            fi_trndatto,
            fi_polfr,
            fi_polto,
            fi_producer).
            {&WINDOW-NAME}:hidden  =  No.                                               
            --------------------------*/
        END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_oksch
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_oksch c-wins
ON CHOOSE OF bu_oksch IN FRAME fr_main /* OK */
DO:
    Disp fi_search  with frame fr_main.
    If  cb_search = "�����١���"  Then do:              /* name  */                          
        Open Query br_tlt                                                        
            For each tlt Use-index  tlt01      Where                                     
            tlt.trndat  >=  fi_trndatfr        And                                            
            tlt.trndat  <=  fi_trndatto        And  
            tlt.genusr   =  "AMANAH"            And
            index(tlt.ins_name,fi_search) <> 0 no-lock.  
                ASSIGN nv_rectlt =  recid(tlt) .  /*add Kridtiya i. A56-0323*/
                Apply "Entry"  to br_tlt.
                Return no-apply.            
    END.
  /*  ELSE If  cb_search  =  "�Ţ����Ѻ��"  Then do:   /* policy */
        Open Query br_tlt 
            For each tlt Use-index  tlt01 Where
            tlt.trndat   >=  fi_trndatfr  And
            tlt.trndat   <=  fi_trndatto  And
            tlt.genusr    =  "AMANAH"      And
            index(tlt.nor_noti_tlt,fi_search) <> 0  no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .  /*add Kridtiya i. A56-0323*/
                Apply "Entry"  to br_tlt.
                Return no-apply.        
    END.*/
    ELSE If  cb_search  =  "�Ţ����ѭ��"  Then do:   /* policy */
        Open Query br_tlt 
            For each tlt Use-index  tlt01 Where
            tlt.trndat   >=  fi_trndatfr  And
            tlt.trndat   <=  fi_trndatto  And
            tlt.genusr    =  "AMANAH"      And
            index(tlt.safe2,fi_search) <> 0  no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .  /*add Kridtiya i. A56-0323*/
                Apply "Entry"  to br_tlt.
                Return no-apply.        
    END.
    ELSE If  cb_search  =  "������������"  Then do:   /* policy */
        Open Query br_tlt 
            For each tlt Use-index  tlt01 Where
            tlt.trndat   >=  fi_trndatfr  And
            tlt.trndat   <=  fi_trndatto  And
            tlt.genusr    =  "AMANAH"      And
            index(tlt.nor_noti_ins,fi_search) <> 0  no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .  /*add Kridtiya i. A56-0323*/
                Apply "Entry"  to br_tlt.
                Return no-apply.        
    END.
    ELSE If  cb_search  =  "�����������"  Then do:   /* policy */
        Open Query br_tlt 
            For each tlt Use-index  tlt01 Where
            tlt.trndat   >=  fi_trndatfr  And
            tlt.trndat   <=  fi_trndatto  And
            tlt.genusr    =  "AMANAH"      And
            index(brstat.tlt.filler1,fi_search) <> 0  no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .  /*add Kridtiya i. A56-0323*/
                Apply "Entry"  to br_tlt.
                Return no-apply.        
    END.
    ELSE If  cb_search  =  "����ᴧ"  Then do:    
        Open Query br_tlt 
            For each tlt Use-index  tlt01 Where
            tlt.trndat   >=  fi_trndatfr  And
            tlt.trndat   <=  fi_trndatto  And
            tlt.genusr    =  "AMANAH"      And
            tlt.flag      =  "N"          no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .  /*add Kridtiya i. A56-0323*/
                Apply "Entry"  to br_tlt.
                Return no-apply.        
    END.
    ELSE If  cb_search  =  "�������"  Then do:    
        Open Query br_tlt 
            For each tlt Use-index  tlt01 Where
            tlt.trndat   >=  fi_trndatfr  And
            tlt.trndat   <=  fi_trndatto  And
            tlt.genusr    =  "AMANAH"      And
            tlt.flag      =  "R"          no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .  /*add Kridtiya i. A56-0323*/
                Apply "Entry"  to br_tlt.
                Return no-apply.        
    END.
    ELSE If  cb_search  = "�Ţ��Ƕѧ"  Then do:  /* chassis no */
        Open Query br_tlt 
            For each tlt Use-index  tlt06 Where
            tlt.trndat >=  fi_trndatfr    And
            tlt.trndat <=  fi_trndatto    AND 
            tlt.genusr   =  "AMANAH"       And
            INDEX(tlt.cha_no,trim(fi_search)) <> 0  no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .  /*add Kridtiya i. A56-0323*/
                Apply "Entry"  to br_tlt.
                Return no-apply.            
    END.
    ELSE If  cb_search  =  "Confirm_yes"  Then do:   /* Confirm yes..*/
        Open Query br_tlt 
            For each tlt Use-index  tlt01  Where
            tlt.trndat >=  fi_trndatfr     And
            tlt.trndat <=  fi_trndatto     And
            tlt.genusr   =  "AMANAH"        And
            INDEX(tlt.releas,"yes") <> 0   no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .  /*add Kridtiya i. A56-0323*/
                Apply "Entry"  to br_tlt.
                Return no-apply.            
    END.
    ELSE If  cb_search  =  "Confirm_no"  Then do:     /* confirm no...*/
        Open Query br_tlt 
            For each tlt Use-index  tlt01   Where
            tlt.trndat >=  fi_trndatfr      And
            tlt.trndat <=  fi_trndatto      And
            tlt.genusr   =  "AMANAH"         And
            INDEX(tlt.releas,"no") <> 0     no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .  /*add Kridtiya i. A56-0323*/
                Apply "Entry"  to br_tlt.
                Return no-apply.            
    END.
    ELSE If  cb_search  =  "Status_cancel"  Then do:    /* cancel */
        Open Query br_tlt 
            For each tlt Use-index  tlt01  Where
            tlt.trndat  >=  fi_trndatfr    And
            tlt.trndat  <=  fi_trndatto    And
            tlt.genusr   =  "AMANAH"        And
            index(tlt.releas,"cancel") > 0     no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .  /*add Kridtiya i. A56-0323*/
                Apply "Entry"  to br_tlt.
                Return no-apply.                             
    END.
    ELSE If  cb_search  =  "�Ң�"  Then do:    /* cancel */
        Open Query br_tlt 
            For each tlt Use-index  tlt01  Where
            tlt.trndat  >=  fi_trndatfr    And
            tlt.trndat  <=  fi_trndatto    And
            tlt.genusr   =  "AMANAH"        And
            tlt.EXP      = fi_search       no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .  /*add Kridtiya i. A56-0323*/
                Apply "Entry"  to br_tlt.
                Return no-apply.                             
    END.
    Else  do:
        ASSIGN nv_rectlt =  recid(tlt) .  /*add Kridtiya i. A56-0323*/
        Apply "Entry"  to  fi_search.
        Return no-apply.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_report
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_report c-wins
ON CHOOSE OF bu_report IN FRAME fr_main /* EXPORT */
DO:
    IF fi_outfile = "" THEN DO:
        MESSAGE "��س��ʪ������!!!"  VIEW-AS ALERT-BOX.
        Apply "Entry"  to fi_outfile.
        Return no-apply. 
    END.
    ELSE DO:
        RUN pd_reportfile.
        Message "Export data Complete"  View-as alert-box.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_update
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_update c-wins
ON CHOOSE OF bu_update IN FRAME fr_main /* CANCEL */
DO:
    Find tlt Where Recid(tlt)  =  nv_rectlt .
    If  avail tlt Then do:
        If  index(tlt.releas,"Cancel")  =  0  Then do:
            message "¡��ԡ��������¡�ù��  "  View-as alert-box.
            IF tlt.releas = "" THEN tlt.releas  =  "Cancel" .
            ELSE tlt.releas  =  "Cancel/" + tlt.releas .
        END.
        Else do:
            message "���¡�����š�Ѻ����ҹ "  View-as alert-box.
            IF index(tlt.releas,"Cancel/")  =  0 THEN
                tlt.releas =  substr(tlt.releas,index(tlt.releas,"Cancel") + 6 ) .
            ELSE 
                tlt.releas =  substr(tlt.releas,index(tlt.releas,"Cancel") + 7 ) .
        END.
    END.
    RELEASE tlt.
    Run Pro_OpenQuery2.
    Apply "Entry"  to br_tlt.
    Return no-apply.  
END.

      /*  If  index(tlt.releas,"cancel") = 0 THEN DO: 
        ASSIGN tlt.releas =  "cancel" + tlt.releas .
            message "¡��ԡ��������¡�ù��  " tlt.releas  /*FORMAT "x(20)" */
                View-as alert-box.
            

    END.
    ELSE IF index(tlt.releas,"cancel") <> 0   THEN DO:
        DISP tlt.releas  FORMAT "x(20)"  index(tlt.releas,"cancel").
        tlt.releas =  substr(tlt.releas,INDEX(tlt.releas,"cancel") + 6 ) + "/YES".
        DISP tlt.releas  FORMAT "x(20)"  index(tlt.releas,"cancel").
    END.*/

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_upyesno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_upyesno c-wins
ON CHOOSE OF bu_upyesno IN FRAME fr_main /* YES/NO */
DO:
    Find tlt Where Recid(tlt)  =  nv_rectlt.
    If  avail tlt Then do:
        If  index(tlt.releas,"No")  =  0  Then do:  /* yes */
            message "Update No ��������¡�ù��  "  View-as alert-box.
            IF tlt.releas = "" THEN tlt.releas  =  "NO" .
            ELSE IF index(tlt.releas,"Cancel/")  <> 0 THEN 
                ASSIGN tlt.releas  =  "Cancel/no" .
            ELSE ASSIGN tlt.releas  =  "no" .
        END.
        Else do:    /* no */
            If  index(tlt.releas,"Yes")  =  0  Then do:  /* yes */
            message "Update Yes ��������¡�ù��  "  View-as alert-box.
            IF tlt.releas = "" THEN tlt.releas  =  "Yes" .
            ELSE IF index(tlt.releas,"Cancel/")  <> 0 THEN 
                ASSIGN tlt.releas  =  "Cancel/Yes" .
            ELSE ASSIGN tlt.releas  =  "Yes" .
        END.
        END.
    END.
    RELEASE tlt.
    Run Pro_OpenQuery2.
    Apply "Entry"  to br_tlt.
    Return no-apply. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME cb_report
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cb_report c-wins
ON LEAVE OF cb_report IN FRAME fr_main
DO:
  /*p-------------*/
    cb_report = INPUT cb_report.
    n_asdat1  = INPUT cb_report.

    IF n_asdat1 = "" THEN DO:
        MESSAGE "��辺������ ��سҵ�Ǩ�ͺ��� Process ������" VIEW-AS ALERT-BOX WARNING.
        RETURN NO-APPLY.
    END.
    /*-------------p*/

    /*APPLY "ENTRY" TO fi_comdatF.*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cb_report c-wins
ON return OF cb_report IN FRAME fr_main
DO:
  APPLY "LEAVE" TO cb_report.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cb_report c-wins
ON VALUE-CHANGED OF cb_report IN FRAME fr_main
DO:
  /*p-------------*/
    cb_report = INPUT cb_report.
    n_asdat1 =  (INPUT cb_report).

    IF n_asdat1 = "" THEN DO:
        MESSAGE "��辺������ ��ä�" VIEW-AS ALERT-BOX WARNING.
        RETURN NO-APPLY.
    END.
    /*APPLY "ENTRY" TO fi_comdatF IN FRAME {&FRAME-NAME}.
    RETURN NO-APPLY.*/
    /*-------------p*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME cb_search
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cb_search c-wins
ON LEAVE OF cb_search IN FRAME fr_main
DO:
  /*p-------------*/
    cb_search = INPUT cb_search.
    n_asdat = INPUT cb_search.

    IF n_asdat = "" THEN DO:
        MESSAGE "��辺������ ��سҵ�Ǩ�ͺ��� Process ������" VIEW-AS ALERT-BOX WARNING.
        RETURN NO-APPLY.
    END.
    /*-------------p*/

    /*APPLY "ENTRY" TO fi_comdatF.*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cb_search c-wins
ON return OF cb_search IN FRAME fr_main
DO:
  APPLY "LEAVE" TO cb_search.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cb_search c-wins
ON VALUE-CHANGED OF cb_search IN FRAME fr_main
DO:
  /*p-------------*/
    cb_search = INPUT cb_search.
    n_asdat =  (INPUT cb_search).

    IF n_asdat = "" THEN DO:
        MESSAGE "��辺������ ��ä�" VIEW-AS ALERT-BOX WARNING.
        RETURN NO-APPLY.
    END.
    /*APPLY "ENTRY" TO fi_comdatF IN FRAME {&FRAME-NAME}.
    RETURN NO-APPLY.*/
    /*-------------p*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_br
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_br c-wins
ON LEAVE OF fi_br IN FRAME fr_main
DO:
  fi_br = INPUT fi_br .
  DISP fi_br WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_match
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_match c-wins
ON LEAVE OF fi_match IN FRAME fr_main
DO:
  fi_match = INPUT fi_match.
  DISP fi_match WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_name
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_name c-wins
ON LEAVE OF fi_name IN FRAME fr_main
DO:
  /*fi_polfr  =  Input  fi_polfr.
  Disp  fi_polfr  with frame  fr_main.*/
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_outfile
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_outfile c-wins
ON LEAVE OF fi_outfile IN FRAME fr_main
DO:
  fi_outfile = INPUT fi_outfile.
  DISP fi_outfile WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_search
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_search c-wins
ON LEAVE OF fi_search IN FRAME fr_main
DO:
   ASSIGN
        fi_search     =  Input  fi_search.
   Disp fi_search  with frame fr_main.
 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_trndatfr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_trndatfr c-wins
ON LEAVE OF fi_trndatfr IN FRAME fr_main
DO:
  fi_trndatfr  =  Input  fi_trndatfr.
  If  fi_trndatto  =  ?  Then  fi_trndatto  =  fi_trndatfr.
  Disp fi_trndatfr  fi_trndatto  with frame fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_trndatto
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_trndatto c-wins
ON LEAVE OF fi_trndatto IN FRAME fr_main
DO:
  If  Input  fi_trndatto  <  fi_trndatfr  Then  fi_trndatto  =  fi_trndatfr.
  Else  fi_trndatto =  Input  fi_trndatto  .
  Disp  fi_trndatto  with frame fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ra_status
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_status c-wins
ON VALUE-CHANGED OF ra_status IN FRAME fr_main
DO:
  ra_status = INPUT ra_status.
  DISP ra_status WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK c-wins 


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
  gv_prgid = "wgwqaman0".
  gv_prog  = "Query & Update  Detail  (AMANAH) ".
  RUN  WUT\WUTHEAD ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).

  SESSION:DATA-ENTRY-RETURN = YES.


  Rect-338:Move-to-top().  
  Rect-339:Move-to-top(). 
  RECT-381:Move-to-top().

  ASSIGN 
      fi_trndatfr = TODAY
      fi_trndatto = TODAY
     /*ra_choice   =  1 */ /*A55-0184*/
      /*fi_polfr    = "0"
      fi_polto    = "Z" */   
      vAcProc_fil = vAcProc_fil   + "�����١���"   + "," 
                                  + "������������" + "," 
                                  + "�Ţ����ѭ��" + "," 
                                  + "�����������" + "," 
                                  + "����ᴧ" + ","
                                  + "�������" + "," 
                                  + "�Ţ��Ƕѧ"      + "," 
                                  + "Confirm_yes"     + "," 
                                  + "Confirm_No" + "," 
                                  + "Status_cancel"  + ","
                                  + "�Ң�"  + ","
        cb_search:LIST-ITEMS = vAcProc_fil
        cb_search = ENTRY(1,vAcProc_fil)
        vAcProc_fil1 = vAcProc_fil1 
                                  + "All"  + ","
                                  + "New" + "," 
                                  + "Renew" + "," 
                                  + "�Ң�" + "," 
                                  + "Confirm_yes"     + "," 
                                  + "Confirm_No" + "," 
                                  + "Status_cancel"  + ","
                                  + "Confirm ����"  + ","
                                  + "�ѧ��� Confirm"  + ","
                                  + "�Դ suspect" + ","
        cb_report:LIST-ITEMS = vAcProc_fil1
        cb_report = ENTRY(1,vAcProc_fil1)
      ra_status = 4  
      fi_outfile = "C:\TEMP\Report_Amanah" + 
                    STRING(YEAR(TODAY),"9999") + 
                    STRING(MONTH(TODAY),"99")  + 
                    STRING(DAY(TODAY),"99")    + 
                    SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) + 
                    SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2) + ".slk" .
  /* add by: kridtiya i. A54-0061.. *//*
  FOR EACH brstat.tlt WHERE 
      brstat.tlt.genusr    = "ICBCTL" AND
      brstat.tlt.rec_addr5 = ""      AND 
      brstat.tlt.ins_name  = "" .
      DELETE brstat.tlt.
  END. */   /* add by: kridtiya i. A54-0061.. */
  Disp fi_trndatfr  fi_trndatto cb_search cb_report ra_status fi_outfile
      /*fi_polfr 
      fi_polto*/  with frame fr_main.

/*********************************************************************/ 
 /*  RUN Wut\WutwiCen ({&WINDOW-NAME}:HANDLE). */ 
  /*CURRENT-WINDOW:WINDOW-STATE = WINDOW-MAXIMIZED.*/


  IF NOT THIS-PROCEDURE:PERSISTENT THEN
      WAIT-FOR CLOSE OF THIS-PROCEDURE.


END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI c-wins  _DEFAULT-DISABLE
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
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(c-wins)
  THEN DELETE WIDGET c-wins.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI c-wins  _DEFAULT-ENABLE
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
  DISPLAY ra_status fi_trndatfr fi_trndatto cb_search fi_search fi_name 
          cb_report fi_br fi_outfile fi_match 
      WITH FRAME fr_main IN WINDOW c-wins.
  ENABLE bu_exit ra_status fi_trndatfr fi_trndatto bu_ok cb_search bu_oksch 
         br_tlt fi_search bu_update cb_report fi_br fi_outfile bu_report 
         bu_upyesno buimp bu_match RECT-332 RECT-338 RECT-339 RECT-340 RECT-341 
         RECT-381 RECT-382 RECT-342 
      WITH FRAME fr_main IN WINDOW c-wins.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW c-wins.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_reportfiel-bp c-wins 
PROCEDURE pd_reportfiel-bp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO:
    DEF VAR n_comdat70  AS CHAR FORMAT "x(15)"  init "".
    DEF VAR n_expdat70  AS CHAR FORMAT "x(15)"  init "".
    DEF VAR n_bdate1    AS CHAR FORMAT "x(15)"  init "".
    DEF VAR n_bdate2    AS CHAR FORMAT "x(15)"  init "".
    DEF VAR n_saleid    AS CHAR FORMAT "x(15)"  init "".
    DEF VAR n_taxno     AS CHAR FORMAT "x(15)"  init "".
    DEF VAR n_brantax AS CHAR FORMAT "x(5)"   init "".
    DEF VAR n_length    AS INT  init 0.
    DEF VAR n_char      AS CHAR FORMAT "x(100)" init "".
    DEF VAR n_benname   AS CHAR FORMAT "x(50)"  init "".
    DEF VAR n_delear    AS CHAR FORMAT "x(50)"  init "".
    DEF VAR n_driv1     as char format "x(50)" init "".
    DEF VAR n_drivid1   as char format "x(15)" init "".
    DEF VAR n_driv2     as char format "x(50)" init "".
    DEF VAR n_drivid2   as char format "x(15)" init "".

    If  substr(fi_outfile,length(fi_outfile) - 3,4) <>  ".CSV"  THEN 
        fi_outfile  =  Trim(fi_outfile) + ".CSV"  .
    /*ASSIGN nv_cnt =  0
        nv_row  =  1.*/
    OUTPUT TO VALUE(fi_outfile).
    EXPORT DELIMITER "|" 
        "Export Data Amanah :" 
        string(TODAY)   .
    EXPORT DELIMITER "|" 
            "�ӴѺ���       "   
            "�ѹ�����     "   
            "�Ţ�Ѻ�駧ҹ  "   
            "���ʺ��ѷ      "   
            "���ͼ����    "   
            "�Ң�           "   
            "��������Сѹ   "   
            "������ö       "   
            "����������������ͧ    "
            "��Сѹ ��/�����"    
            "�ú.   ��/�����"    
            "�ѹ�����������ͧ "    
            "�ѹ����ش����������ͧ"
            "�ӹ�˹�Ҫ���   " 
            "���ͼ����һ�Сѹ " 
            "�Ţ���ѵû�ЪҪ�" 
            "�ѹ�Դ        " 
            "�ѹ���ѵ��������" 
            "�Ҫվ          "   
            "���͡������    "   
            "��ҹ�Ţ���     "   
            "�Ӻ�/�ǧ      "   
            "�����/ࢵ      "   
            "�ѧ��Ѵ        "   
            "������ɳ���   "   
            "�������Ѿ��  "   
            "�кؼ��Ѻ���/����кؼ��Ѻ���   "
            "���Ѻ��褹���1"   
            "��            "   
            "�ѹ�Դ        "   
            "�ҪѾ          "   
            "�Ţ���㺢Ѻ��� "   
            "���Ѻ��褹���2"   
            "��            "   
            "�ѹ�Դ        "   
            "�ҪѾ          "   
            "�Ţ���㺢Ѻ��� "   
            "����������ö   "   
            "���ö         "   
            "�Ţ����ͧ¹�� "   
            "�Ţ��Ƕѧ      "   
            "�ի�           "   
            "��ö¹��       "   
            "�Ţ����¹     "   
            "�ѧ��Ѵ��訴����¹"   
            "��ë���       "    
            "�ع��Сѹ     "    
            "�����ط��    "    
            "���»�Сѹ   "    
            "���¾ú.     "    
            "������� �ú. "    
            "�Ţʵ������ "    
            "�͡�����㹹��    "   
            "����Ѻ�Ż���ª��   "   
            "�����˵�           "   
            "�Ţ��������        "   
            "�Ţ��Ǩ��Ҿ        "   .
    loop_tlt:
    For each tlt Use-index  tlt01 Where
                tlt.trndat   >=  fi_trndatfr   And
                tlt.trndat   <=  fi_trndatto   And
                tlt.genusr    =  "Amanah"       no-lock. 
        IF cb_report = "New" THEN DO:                                              
            IF tlt.flag      =  "R"  THEN NEXT.
        END.
        ELSE IF   cb_report =  "Renew"  THEN DO:
            IF tlt.flag      =  "N"  THEN NEXT.
        END.
        ELSE IF cb_report = "�Ң�" THEN DO:
            IF tlt.EXP    <> fi_br  THEN NEXT.
        END.
        ELSE IF cb_report = "Confirm_yes" THEN DO:
            IF INDEX(tlt.releas,"yes") = 0 THEN NEXT.
        END.
        ELSE IF cb_report = "Confirm_No" THEN DO:
            IF INDEX(tlt.releas,"no") = 0 THEN NEXT.
        END.
        ELSE IF cb_report =   "Status_cancel"   THEN DO:
            IF index(tlt.releas,"cancel") = 0 THEN NEXT.
        END.
        ELSE IF cb_report = "Confirm ����" THEN DO:
            IF brstat.tlt.recac = "" THEN NEXT.
        END.
        ELSE IF cb_report = "�ѧ��� Confirm"   THEN DO:
            IF brstat.tlt.recac = "Confirm ����" THEN NEXT.
        END.
    
        IF (fi_br <> "") THEN DO:
            IF fi_br <> tlt.EXP THEN NEXT loop_tlt.
        END.
        IF      ra_status = 1 THEN DO: 
            IF INDEX(tlt.releas,"yes") = 0    THEN NEXT.
        END.
        ELSE IF ra_status = 2 THEN DO: 
            IF INDEX(tlt.releas,"no") = 0     THEN NEXT.
        END.
        ELSE IF ra_status = 3 THEN DO: 
            IF index(tlt.releas,"cancel") = 0 THEN NEXT.
        END.
        ASSIGN 
            n_char     = ""     n_length    = 0     n_saleid   = ""     n_comdat70 = ""     n_taxno     = ""    n_brantax  = ""
            n_expdat70 = ""     n_bdate1    = ""    n_benname  = ""     n_bdate2   = ""     n_delear    = ""
            n_driv1    = ""     n_drivid1   = ""    n_driv2    = ""     n_drivid2  = "" 
            n_comdat70 = IF tlt.gendat <> ? THEN STRING(tlt.gendat,"99/99/9999") ELSE ""                              /*�ѹ��������������ͧ     */         
            n_expdat70 = IF tlt.expodat <> ? THEN STRING(tlt.expodat,"99/99/9999") ELSE ""                            /*�ѹ�������ش������ͧ   */ 
            n_bdate1   = IF (tlt.dri_no1 <> "" AND tlt.dri_no1 <> ? ) THEN TRIM(tlt.dri_no1) ELSE ""   /*�ѹ��͹���Դ1         */                                                                                    
            n_bdate2   = IF (tlt.dri_no2 <> "" AND tlt.dri_no2 <> ? ) THEN TRIM(tlt.dri_no2) ELSE ""   /*�ѹ��͹���Դ2         */
            n_benname  = trim(SUBSTR(tlt.safe1,1,R-INDEX(tlt.safe1,"Delear:") - 1))                        
            n_delear   = IF tlt.flag = "N" THEN trim(SUBSTR(tlt.safe1,R-INDEX(tlt.safe1,"Delear:") + 7,length(tlt.safe1))) ELSE "" .

        IF brstat.tlt.nor_usr_tlt <> "" AND TRIM(brstat.tlt.nor_usr_tlt) <> "TAX: ID: BR:" THEN DO:
            ASSIGN
                n_char       = trim(brstat.tlt.nor_usr_tlt)
                n_length     = LENGTH(n_char)
                n_brantax    = IF INDEX(n_char,"BR:") <> 0 THEN trim(SUBSTR(n_char,R-INDEX(n_char,"BR:"),n_length)) ELSE ""   /*�Ң�*/
                n_char       = IF INDEX(n_char,"BR:") <> 0 THEN SUBSTR(n_char,1,INDEX(n_char,"BR:")) ELSE SUBSTR(n_char,1,n_length) 
                n_length     = LENGTH(n_char)
                n_taxno      = IF INDEX(n_char,"ID:") <> 0 THEN trim(SUBSTR(n_char,R-INDEX(n_char,"ID:"),n_length)) ELSE ""    /*�Ţ������������� */
                n_saleid     = IF INDEX(n_char,"TAX:") <> 0 THEN trim(SUBSTR(n_char,1,INDEX(n_char,"ID:"))) ELSE ""       /*�Ţ��訴����¹          */
                n_saleid     = if n_saleid    <> "TAX:" then  substr(n_saleid,5,(LENGTH(n_saleid) - 5 ))  else ""
                n_taxno      = if n_taxno     <> "ID:"  then  substr(n_taxno,4,(LENGTH(n_taxno) - 5 ))  else ""
                n_brantax    = if n_brantax   <> "BR:"  then  substr(n_brantax,4,LENGTH(n_brantax))   else ""  .
        END.
        ELSE  ASSIGN  n_saleid    = ""    n_taxno = ""   n_brantax = "".
    
        IF brstat.tlt.dri_name1 <> "" AND TRIM(brstat.tlt.dri_name1) <> "ID1:" THEN DO:
          ASSIGN
            n_char        = trim(brstat.tlt.dri_name1) /* ���Ѻ��� 1 */
            n_length      = LENGTH(n_char)
            n_driv1      = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"ID1:") - 1))         /*�кؼ��Ѻ���1    */  
            n_drivid1    = TRIM(SUBSTR(n_char,R-INDEX(n_char,"ID1:") + 4,n_length)).  /*�Ţ���㺢Ѻ���1   */ 
        END.
        ELSE ASSIGN n_drivid1   = ""     n_driv1     = "" .
        
        IF brstat.tlt.dri_name2 <> "" AND TRIM(brstat.tlt.dri_name2) <> "ID2:"THEN DO:
          ASSIGN 
            n_char        = trim(brstat.tlt.dri_name2)  /*���Ѻ��� 2*/ 
            n_length      = LENGTH(n_char)
            n_driv2      = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"ID2:") - 1))          /*�кؼ��Ѻ���2      */  
            n_drivid2    = TRIM(SUBSTR(n_char,R-INDEX(n_char,"ID2:") + 4,n_length)).   /*�Ţ���㺢Ѻ���2     */ 
        END.
        ELSE  ASSIGN n_drivid2   = ""     n_driv2     = "" . 
    
        EXPORT DELIMITER "|"                                               
        IF tlt.flag = "N" THEN "NEW" ELSE "RENEW"  /*�������ҹ          */
        brstat.tlt.filler2                         /* Marketing            */
        brstat.tlt.safe2                           /* Agreement No.        */
        brstat.tlt.datesent                        /* �ѹ����Ѻ��        */
        brstat.tlt.comp_usr_tlt                    /* ��������Сѹ         */
        brstat.tlt.stat                            /*Type of Garage       */   
        brstat.tlt.filler1                         /* �������� �Ţ���      */
        brstat.tlt.comp_pol                        /* �ú.�Ţ���           */
        brstat.tlt.nor_noti_tlt                    /* �Ţ����Ѻ��        */
        brstat.tlt.nor_usr_ins                     /* ����Ѻ��           */
        brstat.tlt.trntim                          /* �����駧ҹ          */
        brstat.tlt.ins_name                        /* ���ͼ����һ�Сѹ���  */
        brstat.tlt.ins_addr5                       /* ID. Card No.         */
        n_saleid                                   /* �Ţ����¹��ä��(��.20)               */   
        brstat.tlt.rec_addr2                       /*�͡�����/㺡ӡѺ����㹹��            */   
        n_taxno                                    /*�Ţ��Шӵ�Ǽ����������13��ѡ           */   
        n_brantax                                  /*�Ң�                                   */   
        brstat.tlt.rec_addr5                       /*�������㹡���͡�����/㺡ӡѺ����     */   
        brstat.tlt.ins_addr1 + " " + brstat.tlt.ins_addr2 + " " + brstat.tlt.ins_addr3 + " " + brstat.tlt.ins_addr4 /*�������㹡�èѴ���͡���               */   
        string(brstat.tlt.nor_coamt)               /*�ع��Сѹ            */   
        string(brstat.tlt.nor_grprm)               /*���»�Сѹ�ط��     */   
        string(brstat.tlt.comp_coamt)              /*���»�Сѹ���       */   
        STRING(DECI(brstat.tlt.rec_addr4))         /*���¾ú �ط��       */   
        string(brstat.tlt.comp_grprm)              /*���¾ú ���         */   
        brstat.tlt.brand + " " + brstat.tlt.model  /*������ö+���        */   
        brstat.tlt.lince2                          /*��                   */   
        brstat.tlt.colorcod                        /*��                   */   
        brstat.tlt.lince1                          /*�Ţ����¹           */   
        brstat.tlt.lince3                          /*�ѧ��Ѵ              */   
        brstat.tlt.cc_weight                       /*��Ҵ����ͧ¹��      */   
        brstat.tlt.eng_no                          /*�Ţ����ͧ¹��       */   
        brstat.tlt.cha_no                          /*�Ţ��Ƕѧ            */   
        IF trim(brstat.tlt.old_cha) <> "PRICE:" THEN substr(brstat.tlt.old_cha,R-INDEX(brstat.tlt.old_cha,"PRICE:") + 6)  ELSE ""  /*�ػ�ó쵡���������    */   
        IF trim(brstat.tlt.old_cha) <> "PRICE:" THEN substr(brstat.tlt.old_cha,1,INDEX(brstat.tlt.old_cha,"PRICE:") - 2)  ELSE ""  /*�ػ�ó쵡����������Ҥ�*/   
        brstat.tlt.expousr                         /*��/����� ��Сѹ��� */                                                                                   
        brstat.tlt.OLD_eng                         /*��/����� �ú. */                                                                                     
        IF trim(brstat.tlt.safe1) <> "Delear:" THEN trim(SUBSTR(brstat.tlt.safe1,R-INDEX(brstat.tlt.safe1,"Delear:") + 7,n_length)) ELSE "" /*���� Dealer     */    
        n_driv1                                   /*����-���ʡ�� ���Ѻ���1        */                                                                          
        n_bdate1                                  /*�ѹ/��͹/�� �Դ ���Ѻ���1   */   
        n_drivid1                                 /*�Ţ���㺢Ѻ�����Ѻ���1       */   
        n_driv2                                   /*����-���ʡ�� ���Ѻ���2        */   
        n_bdate2                                  /*�ѹ/��͹/�� �Դ ���Ѻ���2   */   
        n_drivid2                                 /*�Ţ���㺢Ѻ��� ���Ѻ���2      */   
        brstat.tlt.gendat                         /*�ѹ��������ͧ                 */   
        brstat.tlt.expodat                        /*�ѹ����ش������ͧ             */   
        IF trim(brstat.tlt.safe1) <> "Delear:" THEN trim(SUBSTR(brstat.tlt.safe1,1,R-INDEX(brstat.tlt.safe1,"Delear:") - 1)) ELSE "" /*����Ѻ�Ż���ª�� */   
        IF trim(brstat.tlt.safe3) <> "" THEN SUBSTR(brstat.tlt.safe3,2,3) ELSE "" /*����ö¹��  */   
        IF trim(brstat.tlt.safe3) <> "" THEN SUBSTR(brstat.tlt.safe3,1,1) ELSE "" /*Pack        */   
        brstat.tlt.comp_sub                       /*Producer    */   
        brstat.tlt.comp_noti_ins                  /*Agent       */   
        brstat.tlt.exp                            /*Branch      */   
        brstat.tlt.rec_addr1                      /*Vat Code    */   
        brstat.tlt.lotno                          /*Campaign    */   
        brstat.tlt.rec_addr3                      /*Inspection  */ 
        brstat.tlt.recac                          /*�Ҫվ */
        tlt.releas.                               /*����͡�ҹ   */ 
    END.                                                                   
    OUTPUT   CLOSE.  
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_reportfile c-wins 
PROCEDURE pd_reportfile :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO:
    DEF VAR n_comdat70  AS CHAR FORMAT "x(15)"  init "".
    DEF VAR n_expdat70  AS CHAR FORMAT "x(15)"  init "".
    DEF VAR n_bdate1    AS CHAR FORMAT "x(15)"  init "".
    DEF VAR n_bdate2    AS CHAR FORMAT "x(15)"  init "".
    DEF VAR n_length    AS INT  init 0.
    DEF VAR nv_cnt      AS INT  INIT 0.
    DEF VAR n_char      AS CHAR FORMAT "x(250)" init "".
    DEF VAR n_driv1     as char format "x(50)" init "".
    DEF VAR n_drivid1   as char format "x(15)" init "".
    DEF VAR n_driv2     as char format "x(50)" init "".
    DEF VAR n_drivid2   as char format "x(15)" init "".
    def var n_gender1   as char format "x(50)" init "".
    def var n_gender2   as char format "x(50)" init "".
    def var n_driocc1   as char format "x(50)" init "".
    def var n_driocc2   as char format "x(50)" init "".
    def var n_icno      as char format "x(20)" init "".
    def var n_bdate     as char format "x(20)" init "".
    def var n_expdate   as char format "x(20)" init "".
    def var n_phone     as char format "x(20)" init "".

    If  substr(fi_outfile,length(fi_outfile) - 3,4) <>  ".CSV"  THEN 
        fi_outfile  =  Trim(fi_outfile) + ".CSV"  .
    ASSIGN nv_cnt =  0.
          /* nv_row  =  1.*/
    OUTPUT TO VALUE(fi_outfile).
    EXPORT DELIMITER "|" 
        "Export Data Amanah :" 
        string(TODAY)   .
    EXPORT DELIMITER "|" 
            "�ӴѺ���       "   
            "�ѹ�����     "   
            "�Ţ�Ѻ�駧ҹ  " 
            "�Ţ��������        "  
            "���ʺ��ѷ      "   
            "���ͼ����    "   
            "�Ң�           "   
            "��������Сѹ   "   
            "������ö       "   
            "����������������ͧ    "
            "��Сѹ ��/�����"    
            "�ú.   ��/�����"    
            "�ѹ�����������ͧ "    
            "�ѹ����ش����������ͧ"
            "�ӹ�˹�Ҫ���   " 
            "���ͼ����һ�Сѹ " 
            "�Ţ���ѵû�ЪҪ�" 
            "�ѹ�Դ        " 
            "�ѹ���ѵ��������" 
            "�Ҫվ          "   
            "���͡������    "   
            "��ҹ�Ţ���     "   
            "�Ӻ�/�ǧ      "   
            "�����/ࢵ      "   
            "�ѧ��Ѵ        "   
            "������ɳ���   "   
            "�������Ѿ��  "   
            "�кؼ��Ѻ���/����кؼ��Ѻ���   "
            "���Ѻ��褹���1"   
            "��            "   
            "�ѹ�Դ        "   
            "�Ҫվ          "   
            "�Ţ���㺢Ѻ��� "   
            "���Ѻ��褹���2"   
            "��            "   
            "�ѹ�Դ        "   
            "�Ҫվ          "   
            "�Ţ���㺢Ѻ��� "   
            "����������ö   "   
            "���ö         "   
            "�Ţ����ͧ¹�� "   
            "�Ţ��Ƕѧ      "   
            "�ի�           "   
            "��ö¹��       "   
            "�Ţ����¹     "   
            "�ѧ��Ѵ��訴����¹"   
            "��ë���       "    
            "�ع��Сѹ     "    
            "�����ط��    "    
            "���»�Сѹ   "    
            "���¾ú.     "    
            "������� �ú. "    
            "�Ţʵ������ "    
            "�͡�����㹹��    "   
            "����Ѻ�Ż���ª��   "   
            "�����˵�           "  
            "�Ţ��Ǩ��Ҿ        "
            "�ŵ�Ǩ��Ҿ         "   /*a62-0445*/
            "Suspect            ".  /*a62-0445*/
    loop_tlt:
    For each tlt Use-index  tlt01 Where
                tlt.trndat   >=  fi_trndatfr   And
                tlt.trndat   <=  fi_trndatto   And
                tlt.genusr    =  "Amanah"       no-lock. 
        IF cb_report = "New" THEN DO:                                              
            IF tlt.flag      =  "R"  THEN NEXT.
        END.
        ELSE IF   cb_report =  "Renew"  THEN DO:
            IF tlt.flag      =  "N"  THEN NEXT.
        END.
        ELSE IF cb_report = "�Ң�" THEN DO:
            IF tlt.EXP    <> fi_br  THEN NEXT.
        END.
        ELSE IF cb_report = "Confirm_yes" THEN DO:
            IF INDEX(tlt.releas,"yes") = 0 THEN NEXT.
        END.
        ELSE IF cb_report = "Confirm_No" THEN DO:
            IF INDEX(tlt.releas,"no") = 0 THEN NEXT.
        END.
        ELSE IF cb_report =   "Status_cancel"   THEN DO:
            IF index(tlt.releas,"cancel") = 0 THEN NEXT.
        END.
        ELSE IF cb_report = "Confirm ����" THEN DO:
            IF brstat.tlt.recac = "" THEN NEXT.
        END.
        ELSE IF cb_report = "�ѧ��� Confirm"   THEN DO:
            IF brstat.tlt.recac = "Confirm ����" THEN NEXT.
        END.
        ELSE IF cb_report = "�Դ suspect"  THEN DO:
            IF brstat.tlt.expotim = ""  THEN NEXT.
        END.
    
        IF (fi_br <> "") THEN DO:
            IF fi_br <> tlt.EXP THEN NEXT loop_tlt.
        END.
        IF      ra_status = 1 THEN DO: 
            IF INDEX(tlt.releas,"yes") = 0    THEN NEXT.
        END.
        ELSE IF ra_status = 2 THEN DO: 
            IF INDEX(tlt.releas,"no") = 0     THEN NEXT.
        END.
        ELSE IF ra_status = 3 THEN DO: 
            IF index(tlt.releas,"cancel") = 0 THEN NEXT.
        END.
        ASSIGN 
            n_char     = ""     n_length    = 0     n_comdat70 = ""     n_expdat70 = ""     
            n_bdate1   = ""     n_bdate2    = ""    n_driv1    = ""     n_drivid1   = ""    
            n_driv2    = ""     n_drivid2   = ""    n_gender1  = ""     n_gender2   = ""
            n_driocc1  = ""     n_driocc2   = ""    n_icno     = ""     n_bdate     = "" 
            n_expdate  = ""     n_phone     = ""

            n_comdat70 = IF tlt.gendat <> ? THEN STRING(tlt.gendat,"99/99/9999") ELSE ""     /*�ѹ��������������ͧ     */         
            n_expdat70 = IF tlt.expodat <> ? THEN STRING(tlt.expodat,"99/99/9999") ELSE ""   /*�ѹ�������ش������ͧ   */ 
            n_comdat70 = IF YEAR(date(n_comdat70)) > (year(today) + 1) THEN SUBSTR(n_comdat70,1,6) + string((YEAR(tlt.gendat)  - 543),"9999") ELSE n_comdat70 /*A62-0445 */  /*�ѹ��������������ͧ     */         
            n_expdat70 = IF YEAR(date(n_expdat70)) > (year(today) + 1) THEN SUBSTR(n_expdat70,1,6) + string((YEAR(tlt.expodat) - 543),"9999") ELSE n_expdat70 /*A62-0445 */  /*�ѹ�������ش������ͧ   */ 

            n_bdate1   = IF (tlt.dri_no1 <> "" AND tlt.dri_no1 <> ? ) THEN TRIM(tlt.dri_no1) ELSE ""   /*�ѹ��͹���Դ1         */                                                                                    
            n_bdate2   = IF (tlt.dri_no2 <> "" AND tlt.dri_no2 <> ? ) THEN TRIM(tlt.dri_no2) ELSE "" .  /*�ѹ��͹���Դ2         */

        IF brstat.tlt.ins_addr5 <> "" AND trim(brstat.tlt.ins_addr5) <> "IC: BD: BE: TE:" THEN DO:
            ASSIGN  n_char    = ""     n_length    = 0 
                    n_char    = TRIM(brstat.tlt.ins_addr5)
                    n_length  = LENGTH(n_char)
                    n_phone   = TRIM(SUBSTR(n_char,R-INDEX(n_char,"TE:")))         /* ������    */  
                    n_char    = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"TE:") - 2))  
                    n_expdate = TRIM(SUBSTR(n_char,R-INDEX(n_char,"BE:")))        /* ������    */  
                    n_char    = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"BE:") - 2))  
                    n_bdate   = TRIM(SUBSTR(n_char,R-INDEX(n_char,"BD:")))   
                    n_char    = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"BD:") - 2)) 
                    n_icno    = TRIM(SUBSTR(n_char,R-INDEX(n_char,"IC:"))) .

             IF index(n_icno,"IC:")    <> 0 THEN ASSIGN n_icno    = REPLACE(n_icno,"IC:","").       
             IF index(n_bdate,"BD:")   <> 0 THEN ASSIGN n_bdate   = REPLACE(n_bdate,"BD:","").      
             IF index(n_expdate,"BE:") <> 0 THEN ASSIGN n_expdate = REPLACE(n_expdate,"BE:","") .
             IF index(n_phone,"TE:")   <> 0 THEN ASSIGN n_phone   = REPLACE(n_phone,"TE:","").
        END.

        IF trim(brstat.tlt.endno) = "�кؼ��Ѻ���"  THEN DO:
            
            IF brstat.tlt.dri_name1 <> "" AND TRIM(brstat.tlt.dri_name1) <> "ID1:" THEN DO:
              ASSIGN
                n_char        = trim(brstat.tlt.dri_name1) /* ���Ѻ��� 1 */
                n_length      = LENGTH(n_char)
                n_driv1      = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"ID1:") - 1))         /*�кؼ��Ѻ���1    */  
                n_drivid1    = TRIM(SUBSTR(n_char,R-INDEX(n_char,"ID1:") + 4,n_length)).  /*�Ţ���㺢Ѻ���1   */ 
            
                IF brstat.tlt.rec_addr1 <> "" AND TRIM(brstat.tlt.rec_addr1) <> "OC1:"  THEN DO:
                    ASSIGN n_char     = ""
                           n_length   = 0
                           n_char     = trim(brstat.tlt.rec_addr1) /* ���Ѻ��� 1 */
                           n_length   = LENGTH(n_char)
                           n_gender1  = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"OC1:") - 1))         /*�ȼ��Ѻ���1    */  
                           n_driocc1  = TRIM(SUBSTR(n_char,R-INDEX(n_char,"OC1:") + 4,n_length)).  /*�Ҫվ�Ѻ���1   */ 
                END.
            END.
            ELSE ASSIGN n_drivid1 = ""     n_driv1 = ""     n_gender1  = ""     n_driocc1 = "" .
            
            IF brstat.tlt.dri_name2 <> "" AND TRIM(brstat.tlt.dri_name2) <> "ID2:"THEN DO:
              ASSIGN 
                n_char        = trim(brstat.tlt.dri_name2)  /*���Ѻ��� 2*/ 
                n_length      = LENGTH(n_char)
                n_driv2      = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"ID2:") - 1))          /*�кؼ��Ѻ���2      */  
                n_drivid2    = TRIM(SUBSTR(n_char,R-INDEX(n_char,"ID2:") + 4,n_length)).   /*�Ţ���㺢Ѻ���2     */ 

                IF brstat.tlt.rec_addr2 <> "" AND TRIM(brstat.tlt.rec_addr2) <> "OC2:"  THEN DO:
                    ASSIGN n_char     = ""
                           n_length   = 0
                           n_char     = trim(brstat.tlt.rec_addr2) /* ���Ѻ��� 1 */
                           n_length   = LENGTH(n_char)
                           n_gender2  = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"OC2:") - 1))         /*�ȼ��Ѻ���1    */  
                           n_driocc2  = TRIM(SUBSTR(n_char,R-INDEX(n_char,"OC2:") + 4,n_length)).  /*�Ҫվ�Ѻ���1   */ 
                END.
            END.
            ELSE  ASSIGN n_driv2    = ""     n_drivid2   = ""    n_gender2   = ""    n_driocc2   = "" . 
        END.
        ELSE DO:
            ASSIGN  n_driv1    = ""     n_drivid1   = ""    n_gender1  = ""     n_driocc1  = ""     
                    n_driv2    = ""     n_drivid2   = ""    n_gender2   = ""    n_driocc2   = "" .
        END.
        nv_cnt = nv_cnt + 1 .
        EXPORT DELIMITER "|"                                               
        nv_cnt
        brstat.tlt.datesent                        /* �ѹ����Ѻ��        */
        brstat.tlt.safe2            /*�Ţ����ѭ��   */ 
        brstat.tlt.filler1          /* �Ţ����������� */
        brstat.tlt.nor_noti_tlt     /*���ʺ���ѷ    */  
        brstat.tlt.nor_usr_ins      /*�����       */   
        brstat.tlt.exp              /*�Ң�          */
        brstat.tlt.colorcod         /*������ö��Сѹ*/ 
        brstat.tlt.old_cha           /* ������ö */
        brstat.tlt.comp_usr_tlt      /*����������������ͧ   */          
        brstat.tlt.expousr           /* ��Сѹ��/�����*/ 
        brstat.tlt.old_eng           /* �ú . ��/����� */
        brstat.tlt.gendat            /*�ѹ��������������ͧ  */  
        brstat.tlt.expodat           /*�ѹ�������ش������ͧ*/  
        brstat.tlt.rec_name          /*�ӹ�˹�Ҫ��ͼ����һ�Сѹ��� */          
        brstat.tlt.ins_name          /*���ͼ����һ�Сѹ��� */    
        n_icno
        n_bdate  
        n_expdate   
        brstat.tlt.recac           /* �Ҫվ */ 
        brstat.tlt.nor_usr_tlt     /* ���͡������ */
        brstat.tlt.ins_addr1       /*��������١��� */          
        brstat.tlt.ins_addr2               
        brstat.tlt.ins_addr3               
        IF index(brstat.tlt.ins_addr4," ") <> 0 THEN SUBSTR(brstat.tlt.ins_addr4,1,INDEX(brstat.tlt.ins_addr4," ")) ELSE TRIM(brstat.tlt.ins_addr4)
        IF index(brstat.tlt.ins_addr4," ") <> 0 THEN SUBSTR(brstat.tlt.ins_addr4,R-INDEX(brstat.tlt.ins_addr4," ")) ELSE ""
        n_phone  
        brstat.tlt.endno      /* �кؼ��Ѻ��� */
        n_driv1               /* ���Ѻ��� */
        n_gender1             /* �� */
        brstat.tlt.dri_no1    /* �ѹ�Դ 1 */
        n_driocc1             /*  �Ҫվ 1 */
        n_drivid1             /*㺢Ѻ��� 1 */ 
        n_driv2               /* ���Ѻ���2 */
        n_gender2             /* �� */ 
        brstat.tlt.dri_no2    /* �ѹ�Դ 2 */
        n_driocc2             /*  �Ҫվ 1 */    
        n_drivid2             /*㺢Ѻ��� 1 */   
        brstat.tlt.brand     
        brstat.tlt.model     
        brstat.tlt.eng_no    
        brstat.tlt.cha_no    
        brstat.tlt.cc_weight 
        brstat.tlt.lince2    
        brstat.tlt.lince1    
        brstat.tlt.lince3    
        brstat.tlt.stat      
        brstat.tlt.nor_coamt 
        brstat.tlt.nor_grprm 
        brstat.tlt.comp_coamt
        brstat.tlt.rec_addr4 
        brstat.tlt.comp_grprm
        brstat.tlt.comp_sck  
        brstat.tlt.rec_addr5 
        brstat.tlt.safe1     
        brstat.tlt.filler2
        brstat.tlt.rec_addr3
        brstat.tlt.gentim    /*�ŵ�Ǩ��Ҿ */     /*A62-0445*/
        brstat.tlt.expotim   /*Suspect*/         /*A62-0445*/
        tlt.releas.           /*����͡�ҹ   */ 
    END.                                                                   
    OUTPUT   CLOSE.  
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_reportfileload c-wins 
PROCEDURE pd_reportfileload :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_cnt AS INT.
DEF VAR n_comdat70  AS CHAR FORMAT "x(15)"  init "".
DEF VAR n_expdat70  AS CHAR FORMAT "x(15)"  init "".
DO:
    ASSIGN nv_cnt =  0.
    OUTPUT TO VALUE(nv_filemat).
    EXPORT DELIMITER "|"
        "Remark         " /*A62-0445*/
        "�ӴѺ���       "   
        "�ѹ�����     "   
        "�Ţ�Ѻ�駧ҹ  " 
        /*"�Ţ��������        "  */ /*A64-0150 */
        "���ʺ��ѷ      "   
        "���ͼ����    "   
        "�Ң�           "   
        "��������Сѹ   "   
        "������ö       "   
        "����������������ͧ    "
        "��Сѹ ��/�����"    
        "�ú.   ��/�����"    
        "�ѹ�����������ͧ "    
        "�ѹ����ش����������ͧ"
        "�ӹ�˹�Ҫ���   " 
        "���ͼ����һ�Сѹ " 
        "�Ţ���ѵû�ЪҪ�" 
        "�ѹ�Դ        " 
        "�ѹ���ѵ��������" 
        "�Ҫվ          "   
        "���͡������    "   
        "��ҹ�Ţ���     "   
        "�Ӻ�/�ǧ      "   
        "�����/ࢵ      "   
        "�ѧ��Ѵ        "   
        "������ɳ���   "   
        "�������Ѿ��  "   
        "�кؼ��Ѻ���/����кؼ��Ѻ���   "
        "���Ѻ��褹���1"   
        "��            "   
        "�ѹ�Դ        "   
        "�Ҫվ          "   
        "�Ţ���㺢Ѻ��� "   
        "���Ѻ��褹���2"   
        "��            "   
        "�ѹ�Դ        "   
        "�Ҫվ          "   
        "�Ţ���㺢Ѻ��� "   
        "����������ö   "   
        "���ö         "   
        "�Ţ����ͧ¹�� "   
        "�Ţ��Ƕѧ      "   
        "�ի�           "   
        "��ö¹��       "   
        "�Ţ����¹     "   
        "�ѧ��Ѵ��訴����¹"   
        "��ë���       "    
        "�ع��Сѹ     "    
        "�����ط��    "    
        "���»�Сѹ   "    
        "���¾ú.     "    
        "������� �ú. "    
        "�Ţʵ������ "    
        "�͡�����㹹��    "   
        "����Ѻ�Ż���ª��   "   
        "�����˵�           "  
        "�Ţ��Ǩ��Ҿ        "
        "class70   " 
        "Producer code" 
        "Agent code "  
        "�ŵ�Ǩ��Ҿ " . /*a62-+0445*/
    
    FOR EACH wdetail WHERE wdetail.n_no <> "" .
        RUN proc_cutpol.
        RUN proc_cutchar.
        FIND LAST brstat.tlt USE-INDEX tlt06 WHERE brstat.tlt.cha_no    = wdetail.chassis AND 
                                                   brstat.tlt.genusr    =  "Amanah"      NO-LOCK NO-ERROR.  
        IF AVAIL brstat.tlt THEN DO:                                 
            ASSIGN  wdetail.n_class    = trim(brstat.tlt.safe3)      /*class */ 
                    wdetail.producer   = brstat.tlt.comp_sub         /*Producer    */   
                    wdetail.agent      = brstat.tlt.comp_noti_ins    /*Agent       */ 
                    wdetail.vatcode    = brstat.tlt.rec_addr1        /*Vat Code    */   
                    wdetail.campaign   = brstat.tlt.lotno            /*Campaign    */   
                    wdetail.inspect    = brstat.tlt.rec_addr3        /*Inspection  */ 
                    wdetail.prevpol    = brstat.tlt.filler1    
                    wdetail.ispresult  = brstat.tlt.gentim             /*�ŵ�Ǩ��Ҿ */ /*A62-0445*/ 
                    /*A62-0445 */
                    wdetail.comment    = IF brstat.tlt.expotim <> "" THEN "�Դ Suspect: " + TRIM(brstat.tlt.expotim) ELSE ""  /* suspect a62-0445*/
                    n_comdat70 = IF tlt.gendat <> ? THEN STRING(tlt.gendat,"99/99/9999") ELSE ""     /*�ѹ��������������ͧ     */         
                    n_expdat70 = IF tlt.expodat <> ? THEN STRING(tlt.expodat,"99/99/9999") ELSE ""   /*�ѹ�������ش������ͧ   */ 
                    wdetail.comdat = IF YEAR(date(n_comdat70)) > (year(today) + 1) THEN SUBSTR(n_comdat70,1,6) + string((YEAR(tlt.gendat)  - 543),"9999") ELSE n_comdat70   /*�ѹ��������������ͧ     */         
                    wdetail.expdat = IF YEAR(date(n_expdat70)) > (year(today) + 1) THEN SUBSTR(n_expdat70,1,6) + string((YEAR(tlt.expodat) - 543),"9999") ELSE n_expdat70 .  /*�ѹ�������ش������ͧ   */ 
                    /* end A62-445*/
        END.
        /* add by A62-0445*/ 
        /*IF wdetail.n_class = "" AND wdetail.producer = "" AND wdetail.agent = ""  THEN NEXT. */

        IF INDEX(wdetail.comtyp,"�����Ҿú") <> 0 THEN DO:
            IF (TRIM(wdetail.comp_prm) <> "-" AND TRIM(wdetail.comp_prm) <> "" AND 
               TRIM(wdetail.comp_prm) <> "0"  AND INDEX(wdetail.comp_prm,"������") = 0 ) THEN 
            ASSIGN wdetail.comment = TRIM("�����Ҿú. �������� �ú. = " + wdetail.comp_prm  + " " + TRIM(wdetail.comment)).
        END.
        ELSE IF INDEX(wdetail.comtyp,"��Ҿú") <> 0 THEN DO:
            IF (TRIM(wdetail.comp_prm) = "-" OR  TRIM(wdetail.comp_prm) = "" OR
               TRIM(wdetail.comp_prm) = "0"  OR  INDEX(wdetail.comp_prm,"������") <> 0 ) THEN DO:
               ASSIGN wdetail.comment = TRIM("��Ҿú. ����������� �ú. " + TRIM(wdetail.comment)).
            END.
        END. 
        ELSE DO:
            IF (TRIM(wdetail.comp_prm) <> "-" and  TRIM(wdetail.comp_prm) <> "" AND
               TRIM(wdetail.comp_prm) <> "0"  and  INDEX(wdetail.comp_prm,"������") = 0 ) THEN DO:
                ASSIGN wdetail.comment = TRIM("�� �ú.���� = " + wdetail.comp_prm  + " " + TRIM(wdetail.comment)).
            END.
        END.

        IF       TRIM(wdetail.comp_prm) = "-" THEN ASSIGN wdetail.comp_prm = "0" .
        ELSE IF  TRIM(wdetail.comp_prm) = ""  THEN ASSIGN wdetail.comp_prm = "0" .
        ELSE IF  TRIM(wdetail.comp_prm) = "0" THEN ASSIGN wdetail.comp_prm = "0" .
        ELSE IF  INDEX(wdetail.comp_prm,"�����Ҿú") <> 0  THEN ASSIGN wdetail.comp_prm = "0" .
        ELSE IF  INDEX(wdetail.comp_prm,"������") <> 0  THEN ASSIGN wdetail.comp_prm = "0" .
        /* end A62-0445 */ 
        nv_cnt = nv_cnt + 1 .
        EXPORT DELIMITER "|" 
            wdetail.comment      /* a62-0445*/
            nv_cnt
            wdetail.RegisDate       /*�ѹ�����      */                     
            wdetail.Account_no      /*�Ţ�Ѻ�駧ҹ   */                     
            /*wdetail.prevpol         /*�Ţ��������      */    */ /*A64-0150*/                
            wdetail.safe_no         /*���ʺ��ѷ       */                     
            wdetail.CMRName         /*���ͼ����     */                     
            wdetail.branch          /*�Ң�            */                     
            wdetail.cartyp          /*��������Сѹ    */                     
            wdetail.typins          /*������ö        */                     
            wdetail.CovTyp          /*����������������ͧ */                  
            wdetail.InsTyp          /*��Сѹ ��/�����  */                  
            wdetail.comtyp          /*�ú.   ��/�����  */                  
            wdetail.comdat          /*�ѹ�����������ͧ*/                     
            wdetail.expdat          /*�ѹ����ش����������ͧ */              
            wdetail.pol_title        /*�ӹ�˹�Ҫ���    */                    
            wdetail.pol_fname      /*���ͼ����һ�Сѹ*/                      
            wdetail.icno            /*�Ţ���ѵû�ЪҪ�  */                  
            wdetail.bdate           /*�ѹ�Դ         */                     
            wdetail.expbdate        /*�ѹ���ѵ��������  */                  
            wdetail.occup           /*�Ҫվ           */                     
            wdetail.name2           /*���͡������     */                     
            wdetail.pol_addr1       /*��ҹ�Ţ���      */                     
            wdetail.pol_addr2       /*�Ӻ�/�ǧ       */                     
            wdetail.pol_addr3       /*�����/ࢵ       */                     
            wdetail.pol_addr4       /*�ѧ��Ѵ         */                     
            wdetail.pol_addr5       /*������ɳ���    */                     
            wdetail.phone           /*�������Ѿ��   */                     
            wdetail.drivno          /*�кؼ��Ѻ���/����кؼ��Ѻ��*/        
            wdetail.drivname1       /*���Ѻ��褹���1  */                    
            wdetail.drivgen1        /*��              */                    
            wdetail.drivdate1       /*�ѹ�Դ          */                    
            wdetail.drivocc1        /*�ҪѾ            */                    
            wdetail.drivid1         /*�Ţ���㺢Ѻ���   */                    
            wdetail.drivname2       /*���Ѻ��褹���2  */                    
            wdetail.drivgen2        /*��              */                    
            wdetail.drivdate2       /*�ѹ�Դ          */                    
            wdetail.drivocc2        /*�ҪѾ            */                    
            wdetail.drivid2         /*�Ţ���㺢Ѻ���   */                    
            wdetail.brand           /*����������ö     */                    
            wdetail.Brand_Model     /*���ö           */                    
            wdetail.engine          /*�Ţ����ͧ¹��   */                    
            wdetail.chassis         /*�Ţ��Ƕѧ        */                    
            wdetail.CC              /*�ի�             */                    
            wdetail.yrmanu          /*��ö¹��         */                    
            wdetail.RegisNo         /*�Ţ����¹       */                    
            wdetail.RegisProv       /*�ѧ��Ѵ��訴����¹ */                 
            wdetail.garage          /*��ë���          */                    
            wdetail.SI              /*�ع��Сѹ        */                    
            wdetail.netprem         /*�����ط��       */                    
            wdetail.totalprem       /*���»�Сѹ      */                    
            wdetail.comp_prm        /*���¾ú.        */                    
            wdetail.comp_prmtotal   /*������� �ú.    */                    
            wdetail.stk             /*�Ţʵ������    */                    
            wdetail.taxname         /*�͡�����㹹��  */                    
            wdetail.ben_name        /*����Ѻ�Ż���ª�� */                    
            wdetail.Remark          /*�����˵�         */                    
            wdetail.inspect         /*�Ţ��Ǩ��Ҿ      */
            wdetail.n_class
            wdetail.producer 
            wdetail.agent 
            wdetail.ispresult .    /* �ŵ�Ǩ��Ҿ A62-0445 */
            
    END.                                                                   
    OUTPUT CLOSE.  
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_cutchar c-wins 
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
IF wdetail.chassis <> "" THEN DO:
    nv_c = wdetail.chassis.
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
        ind = INDEX(nv_c,"*").
        IF ind <> 0 THEN DO:
            nv_c = TRIM (SUBSTRING(nv_c,1,ind - 1) + SUBSTRING(nv_c,ind + 1, nv_l)).
        END.
        ind = INDEX(nv_c,"#").
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
        wdetail.chassis = nv_c .
END.

IF wdetail.engine <> ""  THEN DO:
    nv_c = wdetail.engine.
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
        ind = INDEX(nv_c,"*").
        IF ind <> 0 THEN DO:
            nv_c = TRIM (SUBSTRING(nv_c,1,ind - 1) + SUBSTRING(nv_c,ind + 1, nv_l)).
        END.
        ind = INDEX(nv_c,"#").
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
        wdetail.engine = nv_c .

END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_cutpol c-wins 
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

IF wdetail.safe_no <> ""  THEN DO:  /* 70*/
    nv_c = wdetail.safe_no.
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
        ind = INDEX(nv_c,"*").
        IF ind <> 0 THEN DO:
            nv_c = TRIM (SUBSTRING(nv_c,1,ind - 1) + SUBSTRING(nv_c,ind + 1, nv_l)).
        END.
        ind = INDEX(nv_c,"#").
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
        wdetail.safe_no = nv_c .
END.

IF wdetail.compno <> ""  THEN DO:  /*72*/
    nv_c = wdetail.compno.
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
        ind = INDEX(nv_c,"*").
        IF ind <> 0 THEN DO:
            nv_c = TRIM (SUBSTRING(nv_c,1,ind - 1) + SUBSTRING(nv_c,ind + 1, nv_l)).
        END.
        ind = INDEX(nv_c,"#").
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
        wdetail.compno = nv_c .
END.

IF wdetail.prevpol <> "" THEN DO:
    nv_c = wdetail.prevpol.
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
        ind = INDEX(nv_c,"*").
        IF ind <> 0 THEN DO:
            nv_c = TRIM (SUBSTRING(nv_c,1,ind - 1) + SUBSTRING(nv_c,ind + 1, nv_l)).
        END.
        ind = INDEX(nv_c,"#").
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
        wdetail.prevpol = nv_c .
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pro_openQuery c-wins 
PROCEDURE Pro_openQuery :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
Open Query br_tlt 
    For each tlt Use-index  tlt01 Where
        tlt.trndat  >=  fi_trndatfr  And
        tlt.trndat  <=  fi_trndatto  And
        tlt.genusr   =  "AMANAH" NO-LOCK .
        ASSIGN
            nv_rectlt =  recid(tlt).   /*A55-0184*/
                             

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pro_openQuery2 c-wins 
PROCEDURE Pro_openQuery2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
Open Query br_tlt 
    FOR EACH tlt Where Recid(tlt)  =  nv_rectlt NO-LOCK .
        ASSIGN nv_rectlt =  recid(tlt).   /*A57-0017*/
        
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

