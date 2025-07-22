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
 wgwqtnc0.w :  Quey & Update data in table  tlt (Thanachat)
 Create  by    :  Ranu i. A59-0316  On   08/07/2016
                  Query �����š���駧ҹ�ͧ���ҵ ������¡��§ҹ 
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
/* Modify by : Ranu I. A59-0471 
            : �������� No confirm ��е�����͡���§ҹ ����Ѻ �����д֧��§ҹ������
              �������ա���׹�ѹ��ê������                                      */
/* Modify By : Ranu I. A60-0383 ����������������˵ء���駧ҹ , ����礢������Ţ�ѵ� ���.*/
/* Modify by : Ranu I. A63-0174 ���������ŧҹ����ᴧ */
/*-----------------------------------------------------------------------------*/

Def    var  nv_rectlt    as recid  init  0.
Def    var  nv_recidtlt  as recid  init  0.
DEFINE VAR  n_asdat      AS CHAR.
DEFINE VAR  vAcProc_fil  AS CHAR.
DEFINE VAR  n_asdat1     AS CHAR. /*A55-0365 */
DEFINE VAR  vAcProc_fil1 AS CHAR. /*A55-0365 */

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
IF ( tlt.recac  = ""  ) THEN ("NO") ELSE ("YES") tlt.subins ~
If  tlt.flag  =  "N"  Then  "New"  Else If  tlt.flag = "R" Then  "Renew" Else  " " ~
tlt.rec_addr1 tlt.exp tlt.filler1 tlt.nor_noti_ins tlt.comp_pol ~
tlt.nor_noti_tlt tlt.safe2 tlt.ins_name tlt.cha_no tlt.gendat tlt.expodat ~
tlt.nor_coamt tlt.nor_grprm tlt.comp_sck tlt.comp_effdat tlt.nor_effdat ~
tlt.comp_grprm tlt.comp_coamt 
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_tlt 
&Scoped-define QUERY-STRING-br_tlt FOR EACH tlt NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-br_tlt OPEN QUERY br_tlt FOR EACH tlt NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-br_tlt tlt
&Scoped-define FIRST-TABLE-IN-QUERY-br_tlt tlt


/* Definitions for BROWSE br_tltnew                                     */
&Scoped-define FIELDS-IN-QUERY-br_tltnew tlt.releas tlt.subins ~
If  tlt.flag  =  "N"  Then  "New"  Else If  tlt.flag = "R" Then  "Renew" Else  " " ~
SUBSTRING (tlt.exp,4,index(tlt.exp,"MK:") - 4) tlt.policy tlt.comp_pol ~
tlt.nor_noti_tlt tlt.safe2 tlt.ins_name tlt.cha_no tlt.gendat tlt.expodat ~
tlt.nor_coamt tlt.nor_grprm tlt.comp_sck tlt.comp_effdat tlt.nor_effdat ~
tlt.comp_grprm tlt.comp_coamt 
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_tltnew 
&Scoped-define QUERY-STRING-br_tltnew FOR EACH tlt NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-br_tltnew OPEN QUERY br_tltnew FOR EACH tlt NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-br_tltnew tlt
&Scoped-define FIRST-TABLE-IN-QUERY-br_tltnew tlt


/* Definitions for FRAME fr_main                                        */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS bu_exit ra_status fi_trndatfr fi_trndatto ~
bu_ok cb_search bu_oksch br_tlt fi_search bu_update cb_report fi_br ~
fi_outfile bu_report bu_upyesno bu_nocon ra_type br_tltnew RECT-332 ~
RECT-333 RECT-338 RECT-339 RECT-340 RECT-341 RECT-381 RECT-382 
&Scoped-Define DISPLAYED-OBJECTS ra_status fi_trndatfr fi_trndatto ~
cb_search fi_search fi_name cb_report fi_br fi_outfile ra_type 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR c-wins AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bu_exit 
     LABEL "EXIT" 
     SIZE 10 BY 1.14.

DEFINE BUTTON bu_nocon 
     LABEL "NO CONFIRM" 
     SIZE 24.83 BY 1.05
     BGCOLOR 22 FONT 6.

DEFINE BUTTON bu_ok 
     LABEL "OK" 
     SIZE 9 BY 1
     BGCOLOR 7 FONT 6.

DEFINE BUTTON bu_oksch 
     LABEL "OK" 
     SIZE 5 BY .95
     FONT 6.

DEFINE BUTTON bu_report 
     LABEL "EXPORT" 
     SIZE 10.67 BY .95.

DEFINE BUTTON bu_update 
     LABEL "CANCEL" 
     SIZE 11.83 BY 1.05
     BGCOLOR 6 FONT 6.

DEFINE BUTTON bu_upyesno 
     LABEL "YES/NO" 
     SIZE 11.17 BY 1.05
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

DEFINE VARIABLE fi_br AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 3.5 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_name AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 42 BY .95
     BGCOLOR 15 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_outfile AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 63.5 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_search AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 48 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_trndatfr AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 13.17 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_trndatto AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 13.5 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE ra_status AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "Yes", 1,
"No", 2,
"Cancel", 3,
"All", 4
     SIZE 31 BY 1
     BGCOLOR 10 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE ra_type AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "NEW", 1,
"RENEW", 2
     SIZE 25.33 BY 1
     BGCOLOR 29 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-332
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132.5 BY 8.24
     BGCOLOR 20 .

DEFINE RECTANGLE RECT-333
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 13 BY 1.81
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-338
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 58.5 BY 3
     BGCOLOR 21 .

DEFINE RECTANGLE RECT-339
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 71 BY 2.91
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-340
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 130.67 BY 2.33
     BGCOLOR 29 .

DEFINE RECTANGLE RECT-341
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 14 BY 1.91
     BGCOLOR 4 .

DEFINE RECTANGLE RECT-381
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 7.5 BY 1.52
     BGCOLOR 2 FGCOLOR 2 .

DEFINE RECTANGLE RECT-382
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 13.67 BY 1.62
     BGCOLOR 2 .

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_tlt FOR 
      tlt SCROLLING.

DEFINE QUERY br_tltnew FOR 
      tlt SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_tlt
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_tlt c-wins _STRUCTURED
  QUERY br_tlt NO-LOCK DISPLAY
      tlt.releas COLUMN-LABEL "Cancle/Confirm" FORMAT "x(20)":U
            WIDTH 12
      IF ( tlt.recac  = ""  ) THEN ("NO") ELSE ("YES") COLUMN-LABEL "��������" FORMAT "X(5)":U
      tlt.subins COLUMN-LABEL "Type" FORMAT "x(4)":U WIDTH 6.33
      If  tlt.flag  =  "N"  Then  "New"  Else If  tlt.flag = "R" Then  "Renew"
Else  " " COLUMN-LABEL "New/Renew" FORMAT "x(8)":U
            WIDTH 11.67 LABEL-FGCOLOR 1 LABEL-FONT 6
      tlt.rec_addr1 COLUMN-LABEL "�����˵ء���駧ҹ" FORMAT "x(60)":U
            WIDTH 52.33
      tlt.exp COLUMN-LABEL "�BR." FORMAT "XX":U
      tlt.filler1 COLUMN-LABEL "Old Policy" FORMAT "x(20)":U WIDTH 13.17
      tlt.nor_noti_ins COLUMN-LABEL "New Policy" FORMAT "x(20)":U
            WIDTH 13.33
      tlt.comp_pol COLUMN-LABEL "Comp Policy" FORMAT "x(20)":U
            WIDTH 13.33
      tlt.nor_noti_tlt COLUMN-LABEL "�Ţ�Ѻ��" FORMAT "x(25)":U
      tlt.safe2 COLUMN-LABEL "�Ţ����ѭ��" FORMAT "x(10)":U
      tlt.ins_name COLUMN-LABEL "Insured name" FORMAT "x(50)":U
            WIDTH 25
      tlt.cha_no COLUMN-LABEL "Chassic no." FORMAT "x(20)":U
      tlt.gendat COLUMN-LABEL "Comdate_70" FORMAT "99/99/9999":U
      tlt.expodat COLUMN-LABEL "Expdat_70" FORMAT "99/99/9999":U
            WIDTH 10
      tlt.nor_coamt COLUMN-LABEL "SI" FORMAT "->,>>>,>>>,>>9.99":U
      tlt.nor_grprm COLUMN-LABEL "Gross premium 70" FORMAT ">>,>>>,>>9.99":U
            WIDTH 11.5
      tlt.comp_sck COLUMN-LABEL "Sticker no." FORMAT "x(15)":U
            WIDTH 14.17
      tlt.comp_effdat COLUMN-LABEL "Comdat_72" FORMAT "99/99/9999":U
      tlt.nor_effdat COLUMN-LABEL "Expdat_72" FORMAT "99/99/9999":U
      tlt.comp_grprm COLUMN-LABEL "Gross premium 72" FORMAT ">>>,>>9.99":U
            WIDTH 9.33
      tlt.comp_coamt COLUMN-LABEL "Total Prem." FORMAT "->>,>>>,>>9.99":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 132.5 BY 14.91
         BGCOLOR 15 FGCOLOR 1 FONT 1 ROW-HEIGHT-CHARS .75.

DEFINE BROWSE br_tltnew
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_tltnew c-wins _STRUCTURED
  QUERY br_tltnew NO-LOCK DISPLAY
      tlt.releas COLUMN-LABEL "Cancle/Confirm" FORMAT "x(20)":U
            WIDTH 12
      tlt.subins COLUMN-LABEL "Type" FORMAT "x(4)":U WIDTH 6.33
      If  tlt.flag  =  "N"  Then  "New"  Else If  tlt.flag = "R" Then  "Renew"
Else  " " COLUMN-LABEL "New/Renew" FORMAT "x(8)":U
            WIDTH 11.67 LABEL-FGCOLOR 1 LABEL-FONT 6
      SUBSTRING (tlt.exp,4,index(tlt.exp,"MK:") - 4) COLUMN-LABEL "BR" FORMAT "X(2)":U
      tlt.policy COLUMN-LABEL "Policy New." FORMAT "x(16)":U
      tlt.comp_pol COLUMN-LABEL "Comp Policy" FORMAT "x(20)":U
            WIDTH 13.33
      tlt.nor_noti_tlt COLUMN-LABEL "�Ţ�Ѻ��" FORMAT "x(25)":U
            WIDTH 20.17
      tlt.safe2 COLUMN-LABEL "�Ţ����ѭ��" FORMAT "x(10)":U WIDTH 13.33
      tlt.ins_name COLUMN-LABEL "����" FORMAT "x(50)":U WIDTH 25
      tlt.cha_no COLUMN-LABEL "Chassic no." FORMAT "x(20)":U
      tlt.gendat COLUMN-LABEL "Comdate_70" FORMAT "99/99/9999":U
      tlt.expodat COLUMN-LABEL "Expdat_70" FORMAT "99/99/9999":U
            WIDTH 10
      tlt.nor_coamt COLUMN-LABEL "SI" FORMAT "->,>>>,>>>,>>9.99":U
      tlt.nor_grprm COLUMN-LABEL "Gross premium 70" FORMAT ">>,>>>,>>9.99":U
            WIDTH 11.5
      tlt.comp_sck COLUMN-LABEL "Sticker no." FORMAT "x(15)":U
            WIDTH 14.17
      tlt.comp_effdat COLUMN-LABEL "Comdat_72" FORMAT "99/99/9999":U
      tlt.nor_effdat COLUMN-LABEL "Expdat_72" FORMAT "99/99/9999":U
      tlt.comp_grprm COLUMN-LABEL "Gross premium 72" FORMAT ">>>,>>9.99":U
            WIDTH 9.33
      tlt.comp_coamt COLUMN-LABEL "Total Prem." FORMAT "->>,>>>,>>9.99":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 131.33 BY 14.91
         BGCOLOR 15 FGCOLOR 1 FONT 1 ROW-HEIGHT-CHARS .75.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     bu_exit AT ROW 1.81 COL 119.83
     ra_status AT ROW 6.81 COL 79.5 NO-LABEL
     fi_trndatfr AT ROW 1.86 COL 63.67 COLON-ALIGNED NO-LABEL
     fi_trndatto AT ROW 1.86 COL 85.17 COLON-ALIGNED NO-LABEL
     bu_ok AT ROW 1.91 COL 106.17
     cb_search AT ROW 3.91 COL 16.83 COLON-ALIGNED NO-LABEL
     bu_oksch AT ROW 5.24 COL 53.33
     br_tlt AT ROW 9.67 COL 1.33
     fi_search AT ROW 5.14 COL 3.67 NO-LABEL
     fi_name AT ROW 5.14 COL 61 COLON-ALIGNED NO-LABEL
     bu_update AT ROW 5.19 COL 107
     cb_report AT ROW 6.86 COL 16.33 COLON-ALIGNED NO-LABEL
     fi_br AT ROW 8 COL 16.33 COLON-ALIGNED NO-LABEL
     fi_outfile AT ROW 8 COL 47.5 NO-LABEL
     bu_report AT ROW 7.62 COL 114.33
     bu_upyesno AT ROW 5.19 COL 120
     bu_nocon AT ROW 3.95 COL 106.83
     ra_type AT ROW 1.91 COL 16 NO-LABEL WIDGET-ID 2
     br_tltnew AT ROW 9.67 COL 2.17 WIDGET-ID 100
     "CLICK FOR UPDATE DATA FLAG CANCEL":40 VIEW-AS TEXT
          SIZE 41.5 BY .95 AT ROW 3.91 COL 63.33
          BGCOLOR 19 FGCOLOR 6 FONT 6
     "�������ҹ :" VIEW-AS TEXT
          SIZE 11.5 BY 1 AT ROW 1.86 COL 3 WIDGET-ID 6
          BGCOLOR 29 FGCOLOR 2 FONT 6
     " BRANCH :" VIEW-AS TEXT
          SIZE 11.5 BY .95 AT ROW 8 COL 5.83
          BGCOLOR 3 FGCOLOR 7 FONT 6
     "To  :" VIEW-AS TEXT
          SIZE 5.5 BY 1 AT ROW 1.86 COL 81.17
          BGCOLOR 29 FGCOLOR 2 FONT 6
     " OUTPUT FILE NAME :" VIEW-AS TEXT
          SIZE 23.33 BY .95 AT ROW 8 COL 23.33
          BGCOLOR 3 FGCOLOR 7 FONT 6
     "�ѹ�������駧ҹ  From :" VIEW-AS TEXT
          SIZE 21.5 BY 1 AT ROW 1.86 COL 43.17
          BGCOLOR 29 FGCOLOR 2 FONT 6
     "SEARCH BY :" VIEW-AS TEXT
          SIZE 14 BY 1 AT ROW 3.91 COL 4.33
          BGCOLOR 21 FGCOLOR 0 FONT 6
     "REPORT BY :" VIEW-AS TEXT
          SIZE 14 BY .95 AT ROW 6.91 COL 3.33
          BGCOLOR 3 FGCOLOR 7 FONT 6
     " STATUS FLAG :" VIEW-AS TEXT
          SIZE 17 BY 1 AT ROW 6.81 COL 61.5
          BGCOLOR 3 FGCOLOR 7 FONT 6
     RECT-332 AT ROW 1.1 COL 1.33
     RECT-333 AT ROW 1.52 COL 104
     RECT-338 AT ROW 3.67 COL 2.5
     RECT-339 AT ROW 3.67 COL 61.83
     RECT-340 AT ROW 1.24 COL 2.33
     RECT-341 AT ROW 1.43 COL 117.67
     RECT-381 AT ROW 4.95 COL 52.17
     RECT-382 AT ROW 7.29 COL 112.83
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133.17 BY 24
         BGCOLOR 8 .


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
         TITLE              = "Query && Update [THANACHAT]"
         HEIGHT             = 24
         WIDTH              = 133.17
         MAX-HEIGHT         = 33.91
         MAX-WIDTH          = 170.67
         VIRTUAL-HEIGHT     = 33.91
         VIRTUAL-WIDTH      = 170.67
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
/* BROWSE-TAB br_tltnew ra_type fr_main */
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
"tlt.releas" "Cancle/Confirm" "x(20)" "character" ? ? ? ? ? ? no ? no no "12" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[2]   > "_<CALC>"
"IF ( tlt.recac  = """"  ) THEN (""NO"") ELSE (""YES"")" "��������" "X(5)" ? ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   > brstat.tlt.subins
"tlt.subins" "Type" ? "character" ? ? ? ? ? ? no ? no no "6.33" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   > "_<CALC>"
"If  tlt.flag  =  ""N""  Then  ""New""  Else If  tlt.flag = ""R"" Then  ""Renew""
Else  "" """ "New/Renew" "x(8)" ? ? ? ? ? 1 6 no ? no no "11.67" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   > brstat.tlt.rec_addr1
"tlt.rec_addr1" "�����˵ء���駧ҹ" "x(60)" "character" ? ? ? ? ? ? no ? no no "52.33" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[6]   > brstat.tlt.exp
"tlt.exp" "�BR." ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[7]   > brstat.tlt.filler1
"tlt.filler1" "Old Policy" "x(20)" "character" ? ? ? ? ? ? no ? no no "13.17" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[8]   > brstat.tlt.nor_noti_ins
"tlt.nor_noti_ins" "New Policy" "x(20)" "character" ? ? ? ? ? ? no ? no no "13.33" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[9]   > brstat.tlt.comp_pol
"tlt.comp_pol" "Comp Policy" "x(20)" "character" ? ? ? ? ? ? no ? no no "13.33" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[10]   > brstat.tlt.nor_noti_tlt
"tlt.nor_noti_tlt" "�Ţ�Ѻ��" ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[11]   > brstat.tlt.safe2
"tlt.safe2" "�Ţ����ѭ��" "x(10)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[12]   > brstat.tlt.ins_name
"tlt.ins_name" "Insured name" ? "character" ? ? ? ? ? ? no ? no no "25" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[13]   > brstat.tlt.cha_no
"tlt.cha_no" "Chassic no." ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[14]   > brstat.tlt.gendat
"tlt.gendat" "Comdate_70" ? "date" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[15]   > brstat.tlt.expodat
"tlt.expodat" "Expdat_70" "99/99/9999" "date" ? ? ? ? ? ? no ? no no "10" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[16]   > brstat.tlt.nor_coamt
"tlt.nor_coamt" "SI" ? "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[17]   > brstat.tlt.nor_grprm
"tlt.nor_grprm" "Gross premium 70" ">>,>>>,>>9.99" "decimal" ? ? ? ? ? ? no ? no no "11.5" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[18]   > brstat.tlt.comp_sck
"tlt.comp_sck" "Sticker no." "x(15)" "character" ? ? ? ? ? ? no ? no no "14.17" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[19]   > brstat.tlt.comp_effdat
"tlt.comp_effdat" "Comdat_72" ? "date" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[20]   > brstat.tlt.nor_effdat
"tlt.nor_effdat" "Expdat_72" ? "date" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[21]   > brstat.tlt.comp_grprm
"tlt.comp_grprm" "Gross premium 72" ">>>,>>9.99" "decimal" ? ? ? ? ? ? no ? no no "9.33" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[22]   > brstat.tlt.comp_coamt
"tlt.comp_coamt" "Total Prem." ? "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _Query            is NOT OPENED
*/  /* BROWSE br_tlt */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_tltnew
/* Query rebuild information for BROWSE br_tltnew
     _TblList          = "brstat.tlt"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _FldNameList[1]   > brstat.tlt.releas
"tlt.releas" "Cancle/Confirm" "x(20)" "character" ? ? ? ? ? ? no ? no no "12" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[2]   > brstat.tlt.subins
"tlt.subins" "Type" ? "character" ? ? ? ? ? ? no ? no no "6.33" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   > "_<CALC>"
"If  tlt.flag  =  ""N""  Then  ""New""  Else If  tlt.flag = ""R"" Then  ""Renew""
Else  "" """ "New/Renew" "x(8)" ? ? ? ? ? 1 6 no ? no no "11.67" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   > "_<CALC>"
"SUBSTRING (tlt.exp,4,index(tlt.exp,""MK:"") - 4)" "BR" "X(2)" ? ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   > brstat.tlt.policy
"tlt.policy" "Policy New." ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[6]   > brstat.tlt.comp_pol
"tlt.comp_pol" "Comp Policy" "x(20)" "character" ? ? ? ? ? ? no ? no no "13.33" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[7]   > brstat.tlt.nor_noti_tlt
"tlt.nor_noti_tlt" "�Ţ�Ѻ��" ? "character" ? ? ? ? ? ? no ? no no "20.17" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[8]   > brstat.tlt.safe2
"tlt.safe2" "�Ţ����ѭ��" "x(10)" "character" ? ? ? ? ? ? no ? no no "13.33" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[9]   > brstat.tlt.ins_name
"tlt.ins_name" "����" ? "character" ? ? ? ? ? ? no ? no no "25" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[10]   > brstat.tlt.cha_no
"tlt.cha_no" "Chassic no." ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[11]   > brstat.tlt.gendat
"tlt.gendat" "Comdate_70" ? "date" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[12]   > brstat.tlt.expodat
"tlt.expodat" "Expdat_70" "99/99/9999" "date" ? ? ? ? ? ? no ? no no "10" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[13]   > brstat.tlt.nor_coamt
"tlt.nor_coamt" "SI" ? "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[14]   > brstat.tlt.nor_grprm
"tlt.nor_grprm" "Gross premium 70" ">>,>>>,>>9.99" "decimal" ? ? ? ? ? ? no ? no no "11.5" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[15]   > brstat.tlt.comp_sck
"tlt.comp_sck" "Sticker no." "x(15)" "character" ? ? ? ? ? ? no ? no no "14.17" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[16]   > brstat.tlt.comp_effdat
"tlt.comp_effdat" "Comdat_72" ? "date" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[17]   > brstat.tlt.nor_effdat
"tlt.nor_effdat" "Expdat_72" ? "date" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[18]   > brstat.tlt.comp_grprm
"tlt.comp_grprm" "Gross premium 72" ">>>,>>9.99" "decimal" ? ? ? ? ? ? no ? no no "9.33" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[19]   > brstat.tlt.comp_coamt
"tlt.comp_coamt" "Total Prem." ? "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _Query            is NOT OPENED
*/  /* BROWSE br_tltnew */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME c-wins
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c-wins c-wins
ON END-ERROR OF c-wins /* Query  Update [THANACHAT] */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c-wins c-wins
ON WINDOW-CLOSE OF c-wins /* Query  Update [THANACHAT] */
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
    
    Run  wgw\wgwqtnc2(Input  nv_recidtlt).

    {&WINDOW-NAME}:hidden  =  No.                                               

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_tlt c-wins
ON MOUSE-SELECT-CLICK OF br_tlt IN FRAME fr_main
DO:
    Get  current  br_tlt.
     nv_rectlt =  recid(tlt).
     fi_name   =  tlt.ins_name.
     disp  fi_name  with frame  fr_main.
  
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


&Scoped-define BROWSE-NAME br_tltnew
&Scoped-define SELF-NAME br_tltnew
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_tltnew c-wins
ON LEFT-MOUSE-DBLCLICK OF br_tltnew IN FRAME fr_main
DO:
    Get Current br_tltnew.
          nv_recidtlt  =  Recid(tlt).

    {&WINDOW-NAME}:hidden  =  Yes. 
    
    Run  wgw\wgwqtnc3(Input  nv_recidtlt).

    {&WINDOW-NAME}:hidden  =  No.                                               

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_tltnew c-wins
ON MOUSE-SELECT-CLICK OF br_tltnew IN FRAME fr_main
DO:
    Get  current  br_tltnew.
     nv_rectlt =  recid(tlt).
     fi_name   =  tlt.ins_name.
     disp  fi_name  with frame  fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_tltnew c-wins
ON VALUE-CHANGED OF br_tltnew IN FRAME fr_main
DO:
     Get  current  br_tltnew.
     nv_rectlt =  recid(tlt).
     fi_name   =  tlt.ins_name.
     disp  fi_name  with frame  fr_main.
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


&Scoped-define SELF-NAME bu_nocon
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_nocon c-wins
ON CHOOSE OF bu_nocon IN FRAME fr_main /* NO CONFIRM */
DO:
    /* Start: A59-0471 */
    Find tlt Where Recid(tlt)  =  nv_rectlt .
    If  avail tlt Then do:
        If  index(tlt.releas,"No_Confirm")  =  0  Then do:
            message "��䢢����� Status ��¡�ù��  "  View-as alert-box.
            IF tlt.releas = "" THEN tlt.releas  =  "No_Confirm" .
            ELSE tlt.releas  =  "No_Confirm/" + tlt.releas .
        END.
        Else do:
            message "���¡�����š�Ѻ����ҹ "  View-as alert-box.
            IF index(tlt.releas,"No_Confirm/")  =  0 THEN
                tlt.releas =  substr(tlt.releas,index(tlt.releas,"No_Confirm") + 10 ) .
            ELSE 
                tlt.releas =  substr(tlt.releas,index(tlt.releas,"No_Confirm/") + 11 ) .
        END.
    END.
    RELEASE tlt.
    Run Pro_OpenQuery2.
    /* A63-0174*/
    IF ra_type = 1  THEN DO:
         Apply "Entry"  to br_tltnew.
        Return no-apply. 
    END.
    ELSE DO:
        Apply "Entry"  to br_tlt.
        Return no-apply. 
    END.
    /* end : A63-0174*/
    /* end : A59-0471 */
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_ok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_ok c-wins
ON CHOOSE OF bu_ok IN FRAME fr_main /* OK */
DO:
    /*If  fi_polfr  =  "0"   Then  fi_polfr  =  "0"  .
    If  fi_polto  =  "Z"   Then  fi_polto  =  "Z".*/

    /* add by : A63-0174 */
    IF ra_type = 1  THEN DO:
         Open Query br_tltnew 
            For each tlt Use-index  tlt01  Where
            tlt.trndat  >=   fi_trndatfr   And
            tlt.trndat  <=   fi_trndatto   AND 
            tlt.flag     =  "N"           AND  /*A63-0174*/
            tlt.genusr   =  "THANACHAT"        no-lock.  
                nv_rectlt =  recid(tlt).   
                Apply "Entry"  to br_tltnew.
                Return no-apply.  
    END.
    /* end : A63-0174*/
    ELSE DO:
        Open Query br_tlt 
            For each tlt Use-index  tlt01  Where
            tlt.trndat  >=   fi_trndatfr   And
            tlt.trndat  <=   fi_trndatto   AND 
            tlt.flag     =  "R"           AND  /*A63-0174*/
            tlt.genusr   =  "THANACHAT"        no-lock.  
                nv_rectlt =  recid(tlt).   /*A55-0184*/
                Apply "Entry"  to br_tlt.
                Return no-apply.  
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_oksch
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_oksch c-wins
ON CHOOSE OF bu_oksch IN FRAME fr_main /* OK */
DO:
    IF ra_type = 2  THEN DO: /*A63-0174*/
        If  cb_search = "�����١���"  Then do:              /* name  */                          
            Open Query br_tlt                                                        
                For each tlt Use-index  tlt01      Where                                     
                tlt.trndat  >=  fi_trndatfr        And                                            
                tlt.trndat  <=  fi_trndatto        And  
                tlt.genusr   =  "THANACHAT"        And
                tlt.flag     =  "R"                And  /*a63-0174 */
                index(tlt.ins_name,fi_search) <> 0 no-lock.
                    ASSIGN nv_rectlt =  recid(tlt) .  
                    Apply "Entry"  to br_tlt.
                    Return no-apply.            
        END.
        ELSE If  cb_search  =  "�Ţ����Ѻ��"  Then do:   /* policy */
            Open Query br_tlt 
                For each tlt Use-index  tlt01 Where
                tlt.trndat   >=  fi_trndatfr  And
                tlt.trndat   <=  fi_trndatto  And
                tlt.genusr    =  "THANACHAT"  And
                tlt.flag     =  "R"                And  /*a63-0174 */
                index(tlt.nor_noti_tlt,fi_search) <> 0  no-lock.
                    ASSIGN nv_rectlt =  recid(tlt) .  
                    Apply "Entry"  to br_tlt.
                    Return no-apply.        
        END.
        ELSE If  cb_search  =  "�Ţ����ѭ��"  Then do:   /* policy */
            Open Query br_tlt 
                For each tlt Use-index  tlt01 Where
                tlt.trndat   >=  fi_trndatfr  And
                tlt.trndat   <=  fi_trndatto  And
                tlt.genusr    =  "THANACHAT"      And
                tlt.flag     =  "R"                And  /*a63-0174 */
                index(tlt.safe2,fi_search) <> 0  no-lock.
                    ASSIGN nv_rectlt =  recid(tlt) .  
                    Apply "Entry"  to br_tlt.
                    Return no-apply.        
        END.
        ELSE If  cb_search  =  "������������"  Then do:   /* policy */
            Open Query br_tlt 
                For each tlt Use-index  tlt01 Where
                tlt.trndat   >=  fi_trndatfr  And
                tlt.trndat   <=  fi_trndatto  And
                tlt.genusr    =  "THANACHAT"      And
                tlt.flag     =  "R"                And  /*a63-0174 */
                index(tlt.nor_noti_ins,fi_search) <> 0  no-lock.
                    ASSIGN nv_rectlt =  recid(tlt) .  
                    Apply "Entry"  to br_tlt.
                    Return no-apply.        
        END.
        ELSE If  cb_search  =  "�����������"  Then do:   /* policy */
            Open Query br_tlt 
                For each tlt Use-index  tlt01 Where
                tlt.trndat   >=  fi_trndatfr  And
                tlt.trndat   <=  fi_trndatto  And
                tlt.genusr    =  "THANACHAT"      And
                tlt.flag     =  "R"                And  /*a63-0174 */
                index(tlt.rec_addr5,fi_search) <> 0  no-lock.
                    ASSIGN nv_rectlt =  recid(tlt) .  
                    Apply "Entry"  to br_tlt.
                    Return no-apply.        
        END.
       /* comment by A63-0174
        ELSE If  cb_search  =  "����ᴧ"  Then do:    
            Open Query br_tlt 
                For each tlt Use-index  tlt01 Where
                tlt.trndat   >=  fi_trndatfr  And
                tlt.trndat   <=  fi_trndatto  And
                tlt.genusr    =  "THANACHAT"      And
                tlt.flag      =  "R"          no-lock.
                    ASSIGN nv_rectlt =  recid(tlt) .  
                    Apply "Entry"  to br_tlt.
                    Return no-apply.        
        END.
        ELSE If  cb_search  =  "�������"  Then do:    
            Open Query br_tlt 
                For each tlt Use-index  tlt01 Where
                tlt.trndat   >=  fi_trndatfr  And
                tlt.trndat   <=  fi_trndatto  And
                tlt.genusr    =  "THANACHAT"      And
                tlt.flag      =  "R"          no-lock.
                    ASSIGN nv_rectlt =  recid(tlt) .  
                    Apply "Entry"  to br_tlt.
                    Return no-apply.        
        END.
        ... end A63-0174...*/
        ELSE If  cb_search  = "�Ţ��Ƕѧ"  Then do:  /* chassis no */
            Open Query br_tlt 
                For each tlt Use-index  tlt06 Where
                tlt.trndat >=  fi_trndatfr    And
                tlt.trndat <=  fi_trndatto    AND 
                tlt.genusr   =  "THANACHAT"       And
                tlt.flag     =  "R"                And  /*a63-0174 */
                INDEX(tlt.cha_no,trim(fi_search)) <> 0  no-lock.
                    ASSIGN nv_rectlt =  recid(tlt) .  
                    Apply "Entry"  to br_tlt.
                    Return no-apply.            
        END.
        ELSE If  cb_search  =  "Confirm_yes"  Then do:   /* Confirm yes..*/
            Open Query br_tlt 
                For each tlt Use-index  tlt01  Where
                tlt.trndat >=  fi_trndatfr     And
                tlt.trndat <=  fi_trndatto     And
                tlt.genusr   =  "THANACHAT"        And
                tlt.flag     =  "R"                And  /*a63-0174 */
                INDEX(tlt.releas,"yes") <> 0   no-lock.
                    ASSIGN nv_rectlt =  recid(tlt) .  
                    Apply "Entry"  to br_tlt.
                    Return no-apply.            
        END.
        ELSE If  cb_search  =  "Confirm_no"  Then do:     /* confirm no...*/
            Open Query br_tlt 
                For each tlt Use-index  tlt01   Where
                tlt.trndat >=  fi_trndatfr      And
                tlt.trndat <=  fi_trndatto      And
                tlt.genusr   =  "THANACHAT"         And
                tlt.flag     =  "R"                And  /*a63-0174 */
                INDEX(tlt.releas,"no") <> 0     no-lock.
                    ASSIGN nv_rectlt =  recid(tlt) .  
                    Apply "Entry"  to br_tlt.
                    Return no-apply.            
        END.
        ELSE If  cb_search  =  "Status_cancel"  Then do:    /* cancel */
            Open Query br_tlt 
                For each tlt Use-index  tlt01  Where
                tlt.trndat  >=  fi_trndatfr    And
                tlt.trndat  <=  fi_trndatto    And
                tlt.genusr   =  "THANACHAT"        And
                tlt.flag     =  "R"                And  /*a63-0174 */
                index(tlt.releas,"cancel") > 0     no-lock.
                    ASSIGN nv_rectlt =  recid(tlt) .  
                    Apply "Entry"  to br_tlt.
                    Return no-apply.                             
        END.
        ELSE If  cb_search  =  "�Ң�"  Then do:    /* cancel */
            Open Query br_tlt 
                For each tlt Use-index  tlt01  Where
                tlt.trndat  >=  fi_trndatfr    And
                tlt.trndat  <=  fi_trndatto    And
                tlt.genusr   =  "THANACHAT"        And
                tlt.flag     =  "R"                And  /*a63-0174 */
                tlt.EXP      = fi_search       no-lock.
                    ASSIGN nv_rectlt =  recid(tlt) .  
                    Apply "Entry"  to br_tlt.
                    Return no-apply.                             
        END.
        /* create by A60-0383*/
        ELSE If  cb_search  =  "������������"  Then do:    
            Open Query br_tlt 
                For each tlt Use-index  tlt01  Where
                tlt.trndat  >=  fi_trndatfr    And
                tlt.trndat  <=  fi_trndatto    And
                tlt.genusr   =  "THANACHAT"    And
                tlt.flag     =  "R"                And  /*a63-0174 */
                tlt.recac    = "������������" no-lock.
                    ASSIGN nv_rectlt =  recid(tlt) .  
                    Apply "Entry"  to br_tlt.
                    Return no-apply.                             
        END.
        /* end A60-0383*/
        Else  do:
            ASSIGN nv_rectlt =  recid(tlt) .  
            Apply "Entry"  to  fi_search.
            Return no-apply.
        END.
    END.
    /* add by : A63-0174*/
    ELSE DO: /* new */
         If  cb_search = "�����١���"  Then do:              /* name  */                          
            Open Query br_tltnew                                                        
                For each tlt Use-index  tlt01      Where                                     
                tlt.trndat  >=  fi_trndatfr        And                                            
                tlt.trndat  <=  fi_trndatto        And  
                tlt.genusr   =  "THANACHAT"            And
                tlt.flag     =  "N"                And  /*a63-0174 */
                index(tlt.ins_name,fi_search) <> 0 no-lock.
                    ASSIGN nv_rectlt =  recid(tlt) .  
                    Apply "Entry"  to br_tltnew.
                    Return no-apply.            
        END.
        ELSE If  cb_search  =  "�Ţ����Ѻ��"  Then do:   /* policy */
            Open Query br_tltnew 
                For each tlt Use-index  tlt01 Where
                tlt.trndat   >=  fi_trndatfr  And
                tlt.trndat   <=  fi_trndatto  And
                tlt.genusr    =  "THANACHAT"      And
                tlt.flag     =  "N"                And  /*a63-0174 */
                index(tlt.nor_noti_tlt,fi_search) <> 0  no-lock.
                    ASSIGN nv_rectlt =  recid(tlt) .  
                    Apply "Entry"  to br_tltnew.
                    Return no-apply.        
        END.
        ELSE If  cb_search  =  "�Ţ���㺤Ӣ�"  Then do:   /* policy */
            Open Query br_tltnew 
                For each tlt Use-index  tlt01 Where
                tlt.trndat   >=  fi_trndatfr  And
                tlt.trndat   <=  fi_trndatto  And
                tlt.genusr    =  "THANACHAT"      And
                tlt.flag      =  "N"                And  /*a63-0174 */
                index(tlt.safe2,fi_search) <> 0  no-lock.
                    ASSIGN nv_rectlt =  recid(tlt) .  
                    Apply "Entry"  to br_tltnew.
                    Return no-apply.        
        END.
        ELSE If  cb_search  =  "������������"  Then do:   /* policy */
            Open Query br_tltnew 
                For each tlt Use-index  tlt01 Where
                tlt.trndat   >=  fi_trndatfr  And
                tlt.trndat   <=  fi_trndatto  And
                tlt.genusr    =  "THANACHAT"      And
                tlt.flag     =  "N"                And  /*a63-0174 */
                index(tlt.policy,fi_search) <> 0  no-lock.
                    ASSIGN nv_rectlt =  recid(tlt) .  
                    Apply "Entry"  to br_tltnew.
                    Return no-apply.        
        END.
        ELSE If  cb_search  = "�Ţ��Ƕѧ"  Then do:  /* chassis no */
            Open Query br_tltnew 
                For each tlt Use-index  tlt06 Where
                tlt.trndat >=  fi_trndatfr    And
                tlt.trndat <=  fi_trndatto    AND 
                tlt.genusr   =  "THANACHAT"       And
                tlt.flag     =  "N"                And  /*a63-0174 */
                INDEX(tlt.cha_no,trim(fi_search)) <> 0  no-lock.
                    ASSIGN nv_rectlt =  recid(tlt) .  
                    Apply "Entry"  to br_tltnew.
                    Return no-apply.            
        END.
        /*ELSE If  cb_search  =  "Confirm_yes"  Then do:   /* Confirm yes..*/
            Open Query br_tltnew 
                For each tlt Use-index  tlt01  Where
                tlt.trndat >=  fi_trndatfr     And
                tlt.trndat <=  fi_trndatto     And
                tlt.genusr   =  "THANACHAT"        And
                tlt.flag     =  "N"                And  /*a63-0174 */
                INDEX(tlt.releas,"yes") <> 0   no-lock.
                    ASSIGN nv_rectlt =  recid(tlt) .  
                    Apply "Entry"  to br_tltnew.
                    Return no-apply.            
        END.
        ELSE If  cb_search  =  "Confirm_no"  Then do:     /* confirm no...*/
            Open Query br_tltnew 
                For each tlt Use-index  tlt01   Where
                tlt.trndat >=  fi_trndatfr      And
                tlt.trndat <=  fi_trndatto      And
                tlt.genusr   =  "THANACHAT"         And
                INDEX(tlt.releas,"no") <> 0     no-lock.
                    ASSIGN nv_rectlt =  recid(tlt) .  
                    Apply "Entry"  to br_tltnew.
                    Return no-apply.            
        END.*/
        ELSE If  cb_search  =  "Status_cancel"  Then do:    /* cancel */
            Open Query br_tltnew 
                For each tlt Use-index  tlt01  Where
                tlt.trndat  >=  fi_trndatfr    And
                tlt.trndat  <=  fi_trndatto    And
                tlt.genusr   =  "THANACHAT"        And
                tlt.flag     =  "N"                And  /*a63-0174 */
                index(tlt.releas,"cancel") <> 0     no-lock.
                    ASSIGN nv_rectlt =  recid(tlt) .  
                    Apply "Entry"  to br_tltnew.
                    Return no-apply.                             
        END.
        ELSE If  cb_search  =  "�Ң�"  Then do:    /* cancel */
            Open Query br_tltnew 
                For each tlt Use-index  tlt01  Where
                tlt.trndat  >=  fi_trndatfr    And
                tlt.trndat  <=  fi_trndatto    And
                tlt.genusr   =  "THANACHAT"        And
                tlt.flag     =  "N"                And  /*a63-0174 */
                trim(SUBSTR(tlt.EXP,4,INDEX(tlt.EXP,"MK:") - 4 )) = trim(fi_search)  no-lock.
                    ASSIGN nv_rectlt =  recid(tlt) .  
                    Apply "Entry"  to br_tltnew.
                    Return no-apply.                             
        END.
        Else  do:
            ASSIGN nv_rectlt =  recid(tlt) .  
            Apply "Entry"  to  fi_search.
            Return no-apply.
        END.
    END.
    /* end a63-0174*/
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
        IF ra_type = 1  THEN RUN pd_reportnew. /*a63-0174*/
        ELSE RUN pd_reportfiel.
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
    /* A63-0174*/
   IF ra_type = 1  THEN DO:
         Apply "Entry"  to br_tltnew.
        Return no-apply. 
    END.
    ELSE DO:
        Apply "Entry"  to br_tlt.
        Return no-apply. 
    END.
    /* end a63-0174*/
END.

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
            IF tlt.releas = "" THEN tlt.releas  =  "No" .
            ELSE IF index(tlt.releas,"Cancel/")  <> 0 THEN 
                ASSIGN tlt.releas  =  "Cancel/no" .
            ELSE ASSIGN tlt.releas  =  "No" .
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
   /* A63-0174*/
    IF ra_type = 1  THEN DO:
         Apply "Entry"  to br_tltnew.
        Return no-apply. 
    END.
    ELSE DO:
        Apply "Entry"  to br_tlt.
        Return no-apply. 
    END.
    /* end : A63-0174*/
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
    DEF VAR  nv_sort   as  int  init 0.
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


&Scoped-define SELF-NAME ra_type
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_type c-wins
ON VALUE-CHANGED OF ra_type IN FRAME fr_main
DO:
  ra_type = INPUT ra_type.
  DISP ra_type WITH FRAM fr_main.

  IF ra_type = 1  THEN DO:
      ASSIGN    vAcProc_fil =     ""
      vAcProc_fil = vAcProc_fil   + "�����١���"   + "," 
                                  + "������������" + "," 
                                  + "�Ţ����Ѻ��" + "," 
                                  + "�Ţ���㺤Ӣ�" + "," 
                                  + "�Ţ��Ƕѧ"      + "," 
                                  + "Status_cancel"  + ","
                                  + "�Ң�"  + ","
        cb_search:LIST-ITEMS = vAcProc_fil
        cb_search = ENTRY(1,vAcProc_fil)
        vAcProc_fil1 = vAcProc_fil1 
                                  + "All"  + ","
                                  + "�Ң�" + "," 
                                  + "Confirm_yes" + "," 
                                  + "Confirm_No" + "," 
                                  + "Status_cancel"  + ","
        cb_report:LIST-ITEMS = vAcProc_fil1
        cb_report = ENTRY(1,vAcProc_fil1).
     
      HIDE br_tlt.
      DISP cb_search cb_report br_tltnew WITH FRAME fr_main .

  END.
  ELSE DO:
      ASSIGN  vAcProc_fil =     ""
      vAcProc_fil = vAcProc_fil   + "�����١���"   + "," 
                                  + "������������" + "," 
                                  + "�Ţ����Ѻ��" + "," 
                                  + "�Ţ����ѭ��" + "," 
                                  + "�����������" + "," 
                                  + "�Ţ��Ƕѧ"      + "," 
                                  + "Confirm_yes"     + "," 
                                  + "Confirm_No" + ","
                                  + "������������"  + ","  
                                  + "Status_cancel"  + ","
                                  + "�Ң�"  + ","
        cb_search:LIST-ITEMS = vAcProc_fil
        cb_search = ENTRY(1,vAcProc_fil)
        vAcProc_fil1 = vAcProc_fil1 
                                  + "All"  + ","
                                  + "�Ң�" + "," 
                                  + "Confirm_yes"     + "," 
                                  + "Confirm_No" + "," 
                                  + "Status_cancel"  + ","
                                  + "����׹�ѹ��ê�������"  + "," 
                                  + "������������"  + ","
                                  + "�ѧ����������"  + ","
        cb_report:LIST-ITEMS = vAcProc_fil1
        cb_report = ENTRY(1,vAcProc_fil1).
      HIDE br_tltnew.
      DISP cb_search cb_report br_tlt WITH FRAME fr_main .
  END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br_tlt
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
  gv_prgid = "wgwqtnc0".
  gv_prog  = "Query & Update  Detail  (THANACHAT) ".
  RUN  WUT\WUTHEAD ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).

  SESSION:DATA-ENTRY-RETURN = YES.

  Rect-333:Move-to-top().
  Rect-338:Move-to-top().  
  Rect-339:Move-to-top(). 
  RECT-381:Move-to-top().

  ASSIGN 
      ra_type     = 2
      fi_trndatfr = TODAY
      fi_trndatto = TODAY
     /*ra_choice   =  1 */ /*A55-0184*/
      /*fi_polfr    = "0"
      fi_polto    = "Z" */   
      vAcProc_fil = vAcProc_fil   + "�����١���"   + "," 
                                  + "������������" + "," 
                                  + "�Ţ����Ѻ��" + "," 
                                  + "�Ţ����ѭ��" + "," 
                                  + "�����������" + "," 
                                 /* + "����ᴧ" + "," */   /*A63-0174*/
                                 /* + "�������" + "," */   /*A63-0174*/
                                  + "�Ţ��Ƕѧ"      + "," 
                                  + "Confirm_yes"     + "," 
                                  + "Confirm_No" + ","
                                  + "������������"  + ","  /*A60-0383*/
                                  + "Status_cancel"  + ","
                                  + "�Ң�"  + ","
        cb_search:LIST-ITEMS = vAcProc_fil
        cb_search = ENTRY(1,vAcProc_fil)
        vAcProc_fil1 = vAcProc_fil1 
                                  + "All"  + ","
                                 /* + "New" + ","   */   /*A63-0174*/ 
                                 /* + "Renew" + "," */   /*A63-0174*/ 
                                  + "�Ң�" + "," 
                                  + "Confirm_yes"     + "," 
                                  + "Confirm_No" + "," 
                                  + "Status_cancel"  + ","
                                  + "����׹�ѹ��ê�������"  + "," /* A59-0471 */
                                  + "������������"  + ","
                                  + "�ѧ����������"  + ","
        cb_report:LIST-ITEMS = vAcProc_fil1
        cb_report = ENTRY(1,vAcProc_fil1)
      ra_status = 4  
      fi_outfile = "C:\TEMP\Thanachat" + 
                    STRING(YEAR(TODAY),"9999") + 
                    STRING(MONTH(TODAY),"99")  + 
                    STRING(DAY(TODAY),"99")    + 
                    SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) + 
                    SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2) + ".slk" .
  /* add by: kridtiya i. A54-0061.. *//*
  FOR EACH brstat.tlt WHERE 
      brstat.tlt.genusr    = "tisco" AND
      brstat.tlt.rec_addr5 = ""      AND 
      brstat.tlt.ins_name  = "" .
      DELETE brstat.tlt.
  END. */   /* add by: kridtiya i. A54-0061.. */

  HIDE br_tltnew.
  Disp fi_trndatfr  fi_trndatto cb_search cb_report ra_status fi_outfile
      ra_type  with frame fr_main.

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
          cb_report fi_br fi_outfile ra_type 
      WITH FRAME fr_main IN WINDOW c-wins.
  ENABLE bu_exit ra_status fi_trndatfr fi_trndatto bu_ok cb_search bu_oksch 
         br_tlt fi_search bu_update cb_report fi_br fi_outfile bu_report 
         bu_upyesno bu_nocon ra_type br_tltnew RECT-332 RECT-333 RECT-338 
         RECT-339 RECT-340 RECT-341 RECT-381 RECT-382 
      WITH FRAME fr_main IN WINDOW c-wins.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW c-wins.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_reportfiel c-wins 
PROCEDURE pd_reportfiel :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR n_comdat70  AS CHAR FORMAT "x(15)" init "".
DEF VAR n_comdat72  AS CHAR FORMAT "x(15)" init "".
DEF VAR n_expdat70  AS CHAR FORMAT "x(15)" init "".
DEF VAR n_expdat72  AS CHAR FORMAT "x(15)" init "".
DEF VAR n_bdate1    AS CHAR FORMAT "x(15)" init "".
DEF VAR n_bdate2    AS CHAR FORMAT "x(15)" init "".
DEF VAR n_length    AS INT .
DEF VAR n_exp       AS CHAR FORMAT "x(15)".
DEF VAR n_IC        AS CHAR FORMAT "x(15)".
DEF VAR n_Com       AS CHAR FORMAT "x(15)".
DEF VAR n_addr5     AS CHAR FORMAT "x(70)".

If  substr(fi_outfile,length(fi_outfile) - 3,4) <>  ".slk"  THEN 
    fi_outfile  =  Trim(fi_outfile) + ".slk"  .
/*ASSIGN nv_cnt =  0
    nv_row  =  1.*/
OUTPUT TO VALUE(fi_outfile).
EXPORT DELIMITER "|" 
    "Export THANACHAT" 
    string(TODAY)   .
EXPORT DELIMITER "|" 
    "ʶҹС���͡�ҹ  "          /* A60-0383*/
    "�������������� "
    "�Ţ����Ѻ������Ң�    "
    "�Ţ����Ѻ��           "
    "�Ң�                    "
    "�Ţ����ѭ��             "
    "�Ţ�������������      "
    "�Ţ��������������      "
    "����ѷ��Сѹ���        "
    "�ӹ�˹�Ҫ���            "
    "���ͼ����һ�Сѹ���     "
    "����Ѻ�Ż���ª��        "
    "�ѹ��������������ͧ     "
    "�ѹ�������ش������ͧ   "
    "�ѹ�������������ͧ�ú   "
    "�ѹ�������ش������ͧ�ú"
    "�Ţ����¹              "
    "�ѧ��Ѵ                 "
    "�ع��Сѹ               "
    "���»�Сѹ���          "
    "���¾ú���             "
    "�������                "
    "�Ţ��������ú          "
    "�Ţ���ʵ������        "
    "���ʼ����             "
    "�����˵�                "
    "�ѹ����Ѻ��           "
    "���ͻ�Сѹ���           "
    "�����                 "
    "������                  "
    "���                    "
    "��                      "
    "��Ҵ����ͧ             "
    "�Ţ����ͧ              "
    "�Ţ�ѧ                  "
    "Pattern Rate            "
    "��������Сѹ            "
    "������ö                "
    "ʶҹ������             "
    "�кؼ��Ѻ���1          "
    "�Ţ���㺢Ѻ���1         "
    "�Ţ���ѵû�ЪҪ�1      "
    "�ѹ��͹���Դ1         "
    "�кؼ��Ѻ���2          "
    "�Ţ���㺢Ѻ���2         "
    "�Ţ���ѵû�ЪҪ�2      "
    "�ѹ��͹���Դ2         "
    "��ǹŴ����ѵ�����       "
    "��ǹŴ�����             "
    "����ѵԴ�               "
    "��� �                  "
    "�������1                "
    "�������2                "
    "�������3                "
    "�������4                "
    "���ʺѵû�ЪҪ�         "
    "�ѹ����͡�ѵ�           "   
    "�ѹ���ѵ��������       "
    "��������ê����Թ       " 
    "��໭                  "
    /*"DateCARD_S              "
    "DateCARD_E              "
    "Type_Paid_1             " */.
loop_tlt:
For each tlt Use-index  tlt01 Where
            tlt.trndat   >=  fi_trndatfr   And
            tlt.trndat   <=  fi_trndatto   And
            tlt.flag      =  "R"           AND  /*a63-0174 */
            tlt.genusr    =  "THANACHAT"   no-lock. 
    
    /* comment by : A63-0174 ...
    IF cb_report = "New" THEN DO:                                              
        IF tlt.flag      =  "R"  THEN NEXT.
    END.
    ELSE IF   cb_report =  "Renew"  THEN DO:
        IF tlt.flag      =  "N"  THEN NEXT.
    END.
    ... end A63-0174...*/
    IF cb_report = "�Ң�" THEN DO:
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
    ELSE IF cb_report = "������������" THEN DO:
        IF brstat.tlt.recac = "" THEN NEXT.
    END.
    ELSE IF cb_report = "�ѧ����������"   THEN DO:
        IF brstat.tlt.recac = "������������" THEN NEXT.
    END.
    /* Start: A59-0471 */
    ELSE IF cb_report = "����׹�ѹ��ê�������" THEN DO:
        IF INDEX(tlt.releas,"No_Confirm") = 0 THEN NEXT.
    END.
    /* end : A59-0471 */
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
    n_comdat70    = ""
    n_comdat72    = ""
    n_expdat70    = ""
    n_expdat72    = ""
    n_bdate1      = ""
    n_bdate2      = ""
    n_length      = 0
    n_exp         = ""
    n_IC          = ""
    n_Com         = ""
    n_addr5       = ""
    n_addr5       = tlt.ins_addr5
    n_length      = LENGTH(n_addr5)                                   
    n_exp         = SUBSTR(n_addr5,R-INDEX(n_addr5,"Exp:") + 4,n_length)  
    n_addr5       = SUBSTR(n_addr5,1,R-INDEX(n_addr5," "))             
    n_length      = LENGTH(n_addr5)                                     
    n_com         = SUBSTR(n_addr5,R-INDEX(n_addr5,"Comm:") + 5,n_length)
    n_ic          = SUBSTR(n_addr5,1 + 3,R-INDEX(n_addr5,"Comm:") - 4)  /*A60-0383 */
    /*n_ic          = SUBSTR(n_addr5,1 + 3,R-INDEX(n_addr5,"Comm:") - 5) */ /*A60-0383 */
    n_comdat70    = IF tlt.gendat <> ? THEN STRING(tlt.gendat,"99/99/9999") ELSE ""             /*�ѹ��������������ͧ     */         
    n_expdat70    = IF tlt.expodat <> ? THEN STRING(tlt.expodat,"99/99/9999") ELSE ""            /*�ѹ�������ش������ͧ   */         
    n_comdat72    = IF tlt.comp_effdat <> ? THEN STRING(tlt.comp_effdat,"99/99/9999") ELSE ""   /*�ѹ�������������ͧ�ú   */         
    n_expdat72    = IF tlt.nor_effdat <> ? THEN STRING(tlt.nor_effdat,"99/99/9999") ELSE ""     /*�ѹ�������ش������ͧ�ú*/         
    n_bdate1      = IF (tlt.dri_no1 <> "" AND tlt.dri_no1 <> ? ) THEN STRING(tlt.dri_no1,"99/99/9999") ELSE ""           /*�ѹ��͹���Դ1         */                                                                                    
    n_bdate2      = IF (tlt.dri_no2 <> "" AND tlt.dri_no2 <> ? ) THEN STRING(tlt.dri_no2,"99/99/9999") ELSE "" .      /*�ѹ��͹���Դ2         */    
    EXPORT DELIMITER "|"
         tlt.releas         /*a60-0383*/
         tlt.subins                             /* type 70 ,72 */
         tlt.rec_addr3                         /*�Ţ����Ѻ������Ң�    */
         tlt.nor_noti_tlt                      /*�Ţ����Ѻ��           */
         tlt.EXP                               /*�Ң�                    */
         tlt.safe2                             /*�Ţ����ѭ��             */
         tlt.filler1                           /*�Ţ�������������      */
         tlt.nor_noti_ins
         tlt.rec_addr4                         /*����ѷ��Сѹ���        */
         tlt.rec_name                          /*�ӹ�˹�Ҫ��� */
         tlt.ins_name                          /*���ͼ����һ�Сѹ���     */
         tlt.safe1                             /*����Ѻ�Ż���ª��        */
         n_comdat70
         n_expdat70
         n_comdat72
         n_expdat72
         tlt.lince1                            /*�Ţ����¹              */
         tlt.lince3                            /*�ѧ��Ѵ                 */
         tlt.nor_coamt                         /*�ع��Сѹ               */
         tlt.nor_grprm                         /*���»�Сѹ���          */
         tlt.comp_grprm                        /*���¾ú���             */
         tlt.comp_coamt                        /*�������                */
         tlt.comp_pol                          /*�Ţ��������ú          */
         tlt.comp_sck                          /*�Ţ���ʵ������        */
         tlt.comp_usr_tlt                      /*���ʼ����             */
         tlt.filler2                           /*�����˵�                */
         tlt.datesent                          /*�ѹ����Ѻ��           */
         tlt.nor_usr_tlt                       /*���ͻ�Сѹ���           */
         tlt.nor_usr_ins                       /*�����                 */
         tlt.brand                             /*������                  */
         tlt.model                             /*���                    */
         tlt.lince2                            /*��                      */
         tlt.cc_weight                         /*��Ҵ����ͧ             */
         tlt.eng_no                            /*�Ţ����ͧ              */
         tlt.cha_no                            /*�Ţ�ѧ                  */
         tlt.old_cha                           /*Pattern Rate            */
         tlt.expousr                           /*��������Сѹ            */
         tlt.old_eng                           /*������ö                */
         tlt.stat                              /*ʶҹ������             */
         SUBSTR(tlt.dri_name1,1,60)            /*�кؼ��Ѻ���1          */
         SUBSTR(tlt.dri_name1,61,20)           /*�Ţ���㺢Ѻ���1         */
         SUBSTR(tlt.dri_name1,81,20)           /*�Ţ���ѵû�ЪҪ�1      */
         n_bdate1 
         SUBSTR(tlt.dri_name2,1,60)            /*�кؼ��Ѻ���2          */
         SUBSTR(tlt.dri_name2,61,20)           /*�Ţ���㺢Ѻ���2         */
         SUBSTR(tlt.dri_name2,81,20)           /*�Ţ���ѵû�ЪҪ�2      */
         n_bdate2 
         tlt.endno                             /*��ǹŴ����ѵ�����       */
         tlt.lotno                             /*��ǹŴ�����             */
         tlt.seqno                             /*����ѵԴ�               */
         tlt.endcnt                            /*��� �                  */
         tlt.ins_addr1                         /*�������1                */
         tlt.ins_addr2                         /*�������2                */
         tlt.ins_addr3                         /*�������3                */
         tlt.ins_addr4                         /*�������4                */
         n_ic                                  /*IDCARD                  */
         n_com                                 /*DateCARD_S              */
         n_exp                                 /*DateCARD_E              */
         tlt.safe3                             /*Type_Paid_1             */
         tlt.rec_addr2 .                       /*campaign  --A60-0383-- */
END.
OUTPUT   CLOSE.  
                  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_reportnew c-wins 
PROCEDURE pd_reportnew :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR n_length    AS INT .
DEF VAR n_addr5     AS CHAR FORMAT "x(150)".
DEF VAR n_br        AS CHAR FORMAT "x(3)".
def var nv_drivic1  as char format "x(15)" .
def var nv_drivid1  as char format "x(15)" .
def var nv_driv1    as char format "x(70)" .
def var nv_drivic2  as char format "x(15)" .
def var nv_drivid2  as char format "x(15)" .
def var nv_driv2    as char format "x(70)" .

If  substr(fi_outfile,length(fi_outfile) - 3,4) <>  ".slk"  THEN 
    fi_outfile  =  Trim(fi_outfile) + ".slk"  .
OUTPUT TO VALUE(fi_outfile).
EXPORT DELIMITER "|" 
    "��§ҹ�����ŧҹ����ᴧ ���ҵ" 
    string(TODAY)   .
EXPORT DELIMITER "|" 
    " ʶҹС���͡�ҹ  "          /* A60-0383*/
    " �������������� "
    " ��������������� "
    " �ѹ����Ѻ��   " 
    " Code ��Сѹ���  "
    " �Ţʵ������   " 
    " �� �ú �Ţ���   " 
    " ���ͻ�Сѹ���   " 
    " �Ţ����Ѻ��   " 
    " ��Ҵ�Ң�        " 
    " Code ��Ҵ�Ң�   " 
    " �����         " 
    " �����           " 
    " ����Ѻ��      " 
    " ���ͼ����һ�Сѹ���    "  
    " �Ţ���ѵ�             "  
    " �������Ѩ�غѹ/��.20  "  
    " �������Ѩ�غѹ/��.20  "  
    " ������        "  
    " ����������͡���  "   
    " ����������͡���1 "   
    " ������1         "   
    " �ع��Сѹ         "   
    " ���»�Сѹ�ط��  "   
    " ���»�Сѹ���    "   
    " ���¾ú �ط��    "   
    " ���¾ú ���      "   
    " ���»�Сѹ+�ú   "   
    " �Ţ������ͧ���Ǥ���    "  
    " ������ "  
    " ���   "  
    " ��     "  
    " ��     "  
    " �Ţ����¹     "  
    " ��Ҵ����ͧ¹��"  
    " �Ţ����ͧ¹�� "  
    " �Ţ��Ƕѧ      "  
    " �˵ؼšó� �Ţ����ͧ/�Ţ�ѧ���  "
    " �Ҥ��Ѥ�� ��/�����"
    " �Ҥ�ѧ�Ѻ ��/����� "
    " �Ҥ�ö     "  
    " �Ҥҡ�ҧ   "  
    " ���� Dealer"  
    " ��������û�Сѹ���   "
    " ���Ѻ���  "  
    " ���� 1     "  
    " �ѹ/��͹/���Դ1    "
    " �Ţ��� ID1  "
    " 㺢Ѻ��� 1 �Ţ���    "
    " ���� 2      "
    " �ѹ/��͹/���Դ2    "
    " �Ţ��� ID2   "
    " 㺢Ѻ��� 2 �Ţ���"
    " �ѹ��������ͧ   "
    " �ѹ����ش������ͧ   "
    " �����������ö"   
    " �����˵����� "   
    " ��Դö        "   
    " ������ö      "   
    " ������ö���� "   
    " ��������ë��� "   
    " Code Rebate   "   
    " �����˵�      "   
    " �ӹǹ�����  "   
    " �Ţ��Шӵ�Ǽ����������"   
    " ���͡�����ú���ѷ     "   
    " �������͡���          "   
    " ������¹������Ť�������������  "
    " �Ңҷ��              "
    " ����Ѻ�Ż���ª��     "
    " �Ţ���㺤Ӣ���ҫ��� "
    " �������             "
    " Producer code "
    " Agent code " .

loop_tlt:
For each tlt Use-index  tlt01 Where
            tlt.trndat   >=  fi_trndatfr   And
            tlt.trndat   <=  fi_trndatto   And
            tlt.flag      =  "N"           AND  /*a63-0174 */
            tlt.genusr    =  "THANACHAT"   no-lock. 
    
    IF cb_report = "�Ң�" THEN DO:
        n_br  = SUBSTR(tlt.EXP,4,INDEX(tlt.EXP,"MK:") - 4 ) .  
        IF n_br  <> fi_br  THEN NEXT.
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
        n_length   = 0
        n_addr5     = "" 
        n_br        = "" 
        nv_drivic1  = "" 
        nv_drivid1  = "" 
        nv_driv1    = "" 
        nv_drivic2  = "" 
        nv_drivid2  = "" 
        nv_driv2    = "" 
        n_addr5     = "" 
        n_br         = SUBSTR(tlt.EXP,4,INDEX(tlt.EXP,"MK:") - 4 )   
        nv_drivic1    = TRIM(SUBSTR(tlt.dri_name1,R-INDEX(TLT.dri_name1,"IC1:") + 4 ))      /*�Ţ���ѵû�ЪҪ�1         */ 
        n_length      = (LENGTH(tlt.dri_name1) - LENGTH(nv_drivic1)) - 4 
        n_addr5       = SUBSTR(tlt.dri_name1,1,n_length)
        nv_drivid1    = SUBSTR(n_addr5,R-INDEX(n_addr5,"ID1:") + 4 )                /*�Ţ���㺢Ѻ���1            */ 
        nv_driv1      = SUBSTR(n_addr5,5,INDEX(n_addr5,"ID1:") - 5 )        /*�кؼ��Ѻ���1             */  
        
        n_addr5       = "" 
        nv_drivic2    = TRIM(SUBSTR(tlt.dri_name2,R-INDEX(TLT.dri_name2,"IC2:") + 4 ))         /*�Ţ���ѵû�ЪҪ�2         */
        n_length      = (LENGTH(tlt.dri_name2) - LENGTH(nv_drivic2)) - 4  
        n_addr5       = SUBSTR(tlt.dri_name2,1,n_length)            
        nv_drivid2    = SUBSTR(n_addr5,R-INDEX(n_addr5,"ID2:") + 4 )                    /*�Ţ���㺢Ѻ���2            */
        nv_driv2      = SUBSTR(n_addr5,5,INDEX(n_addr5,"ID2:") - 5 )  .          /*�кؼ��Ѻ���2             */  
     
    EXPORT DELIMITER "|"
         tlt.releas              /*����͡�ҹ*/
         tlt.subins              /* type 70 ,72 */
         tlt.policy              /* ��������������� */
         tlt.datesent            /* �ѹ��� �Ѻ�� */
         tlt.comp_usr_tlt        /* code ��Сѹ���  */                            
         tlt.comp_sck            /*�Ţ���ʵ������ */                            
         tlt.comp_pol            /*�Ţ��������ú   */                            
         tlt.nor_usr_tlt         /*���ͻ�Сѹ���    */                            
         tlt.nor_noti_tlt        /*�Ţ����Ѻ��     */                           
         n_br                     /*�鴵�Ҵ�Ң�      */  
         SUBSTR(tlt.EXP,R-INDEX(tlt.EXP,"MK:") + 3 )      /*��Ҵ�Ң� */                        
         tlt.nor_usr_ins                       /*�����                    */    
         tlt.filler1                            /* ����� */                       
         tlt.rec_addr4                          /*����Ѻ��      */              
         tlt.rec_name + " " + tlt.ins_name      /*���ͼ����һ�Сѹ��� */   
         tlt.ins_addr5                         /* �Ţ�ѵû�ЪҪ� */                                                       
         tlt.ins_addr1                         /*��������١��� 1             */                                           
         substr(tlt.ins_addr2,1,INDEX(tlt.ins_addr2,"TEL:") - 2)                        /*��������١���  2            */  
         SUBSTR(tlt.ins_addr2,INDEX(tlt.ins_addr2,"TEL:") + 4,LENGTH(tlt.ins_addr2))  /* ������ */                      
         tlt.ins_addr3                        /*�������Ѵ�� 1              */                                          
         substr(tlt.ins_addr4,1,INDEX(tlt.ins_addr4,"TEL:") - 2)                        /*�������Ѵ�� 2             */ 
         SUBSTR(tlt.ins_addr4,INDEX(tlt.ins_addr4,"TEL:") + 4,LENGTH(tlt.ins_addr4))  /* ������ */                     
         tlt.nor_coamt                    /*�ع��Сѹ             */   
         if tlt.subins = "V70" then tlt.comp_grprm  else 0                  /*�����ط��            */              
         if tlt.subins = "V70" then tlt.nor_grprm   else 0                  /*���»�Сѹ���        */
         if tlt.subins = "V72" then tlt.comp_grprm  else 0                  /*�����ط��            */   
         if tlt.subins = "V72" then tlt.nor_grprm   else 0                  /*���»�Сѹ���        */   
         tlt.comp_coamt                    /*�������              */             
         tlt.rec_addr3                     /*�Ţ������ͧ���Ǥ���  */              
         tlt.brand                         /*������                */             
         tlt.model                         /*���                  */              
         tlt.lince2                        /*��                    */             
         tlt.colorcod                      /*�� */                                
         tlt.lince1                        /*�Ţ����¹            */             
         tlt.cc_weight                     /*��˹ѡö           */                
         tlt.eng_no                        /*�Ţ����ͧ            */             
         tlt.cha_no                        /*�Ţ�ѧ                */             
         tlt.old_cha                       /*�˵ؼšóի��         */             
         tlt.safe3                         /*�Ҥ��Ѥ�� ��/�����       */       
         tlt.lince3                        /*�Ҥ�ѧ�Ѻ ��/�����       */        
         tlt.endcnt                        /*�Ҥ�ö            */                   
         tlt.seqno                         /*�Ҥҡ�ҧ           */                 
         tlt.lotno                         /*Dealer           */                   
         tlt.expousr                       /*��������Сѹ               */         
         tlt.endno                         /*���Ѻ���    */                          
         nv_driv1                          /* ���ͼ��Ѻ���1 */ 
         tlt.dri_no1                       /* �ѹ�Դ 1*/
         nv_drivid1                        /* id 1    */
         nv_drivic1                        /* �Ţ��� 1*/
         nv_driv2                          /* ���ͼ��Ѻ���1 */  
         tlt.dri_no2                       /* �ѹ�Դ 1*/        
         nv_drivid2                        /* id 1    */         
         nv_drivic2                        /* �Ţ��� 1*/         
         if tlt.subins = "V70" then tlt.gendat   else tlt.comp_effdat  /* �ѹ��������ͧ*/
         if tlt.subins = "V70" then tlt.expodat  else tlt.nor_effdat   /* �ѹ���������� */
         tlt.usrsent                                                   /* �����������ö*/                            
         TRIM(tlt.rec_addr1)                                           /*�����˵����� */                             
         tlt.recac                                                     /*��Դö */                                    
         trim(substr(tlt.old_eng,5,INDEX(tlt.OLD_eng,"Veh1:") - 5 ))   /*������ö                   */                
         trim(substr(tlt.OLD_eng,INDEX(tlt.OLD_eng,"Veh1:") + 5 ))     /*������ö��� � */                            
         trim(substr(tlt.stat,4,INDEX(tlt.stat,"CD:") - 4 ))           /*ʶҹ������           */                     
         TRIM(substr(tlt.stat,INDEX(tlt.stat,"CD:") + 3 ))             /* code rebate */                              
         trim(tlt.filler2)                                             /*�����˵�                   */     
         tlt.sentcnt                                                   /*�����*/                                     
         TRIM(tlt.rec_addr2)                                           /*Tax no*/                                       
         TRIM(tlt.rec_addr5)                                           /*���͡������ */                                
         tlt.nor_noti_ins                                              /* �������͡��� */                            
         tlt.comp_noti_tlt                                             /*������¹���� */                      
         tlt.gentim                                                    /*�Ңҷ��*/                             
         tlt.safe1                                                     /*����Ѻ�Ż���ª��           */    
         tlt.safe2                                                     /*�Ţ����ѭ��           */         
         tlt.comp_usr_ins                                              /* ������� */                                     
         tlt.comp_sub                                                   /* produer code */                             
         tlt.comp_noti_ins.                                              /* Agent */        

END.
OUTPUT   CLOSE.  
                  
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
/* A63-0174*/
IF ra_type = 1 THEN DO:
    Open Query br_tltnew
        For each tlt Use-index  tlt01 Where
            tlt.trndat  >=  fi_trndatfr  And
            tlt.trndat  <=  fi_trndatto  And
            tlt.flag     =  "N"  AND
            tlt.genusr   =  "THANACHAT" NO-LOCK .
            ASSIGN
                nv_rectlt =  recid(tlt).   /*A55-0184*/
END.
ELSE DO:
    Open Query br_tlt
        For each tlt Use-index  tlt01 Where
            tlt.trndat  >=  fi_trndatfr  And
            tlt.trndat  <=  fi_trndatto  And
            tlt.flag     =  "R"  AND
            tlt.genusr   =  "THANACHAT" NO-LOCK .
            ASSIGN
                nv_rectlt =  recid(tlt).   /*A55-0184*/
END.
/* end A63-0174*/

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
/* A63-0174*/
IF ra_type = 1  THEN DO:
    Open Query br_tltnew 
        FOR EACH tlt Where Recid(tlt)  =  nv_rectlt NO-LOCK .
            ASSIGN nv_rectlt =  recid(tlt).   /*A57-0017*/

END.
/* end A63-0174*/
ELSE DO:
    Open Query br_tlt 
        FOR EACH tlt Where Recid(tlt)  =  nv_rectlt NO-LOCK .
            ASSIGN nv_rectlt =  recid(tlt).   /*A57-0017*/
END.
        
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

