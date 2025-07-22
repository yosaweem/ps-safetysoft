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
 wgwqtnc0.w :  Quey & Update data in table  tlt (Toyota and hino)
 Create  by    :  Kridtiya i. A63-0259 Date. 04/08/2020 
                  Query �����š���駧ҹ�ͧToyota and hino ������¡��§ҹ 
 modify  by    : Kridtiya i. A67-0184 Date. 24/10/2024 ���� ����
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/

Def    var  nv_rectlt    as recid  init  0.
Def    var  nv_recidtlt  as recid  init  0.
DEFINE VAR  n_asdat      AS CHAR.
DEFINE VAR  vAcProc_fil  AS CHAR.
DEFINE VAR  n_asdat1     AS CHAR. 
DEFINE VAR  vAcProc_fil1 AS CHAR. 
DEFINE   TEMP-TABLE TB-ErrorCd NO-UNDO
    FIELD   ntype           AS CHAR      /*��������¡�� D                                    */
    FIELD   companycode     AS CHAR      /*���ʺ���ѷ   SAFE                                 */
    FIELD   sendate         AS CHAR      /*�ѹ�����    20200625                             */
    FIELD   applino         as char      /*�Ţ���(ApplicationNo.)       H B0801048               */
    FIELD   lotno           as char      /*Lotno.       000004100                                */
    FIELD   seqno           as char      /*Seqno.       000002                                   */
    FIELD   recordno        as char      /*Record Active.       A                                */
    FIELD   nSTATUS         as char      /*ʶҹ�        A                                        */
    FIELD   flag            as char      /*����Ţ����ͧ¹��/�Ţ��Ƕѧ                         */
    FIELD   nTITLE          as char      /*�ӹ� �.�.�.                                       */
    FIELD   nNAME           as char      /*���ͼ����һ�Сѹ���  �������͹ʵ�Ѥ���         */
    FIELD   addr1           as char      /*�����������һ�Сѹ���1      102 ������ 7            */
    FIELD   addr2           as char      /*�����������һ�Сѹ���2      �.�Ѻ��ԡ                */
    FIELD   addr3           as char      /*�����������һ�Сѹ���3                               */
    FIELD   addr4           as char      /*�����������һ�Сѹ���4      �.���ͧ��к�� �.��к��   */
    FIELD   addr5           as char      /*�����������һ�Сѹ���5      81000                    */
    FIELD   engno           as char      /*�Ţ����ͧ¹��       J05EUTH11384                     */
    FIELD   chano           as char      /*�Ţ��Ƕѧ    MNKFC9JEMXHX10382                    */
    FIELD   brand           as char      /*����������ö 002                                  */
    FIELD   model           as char      /*���ö       Dominator                                */
    FIELD   engcc           as char      /*��Ҵ����ͧ¹��      12000                            */
    FIELD   nCOLOR          as char      /*��ö 0001                                         */
    FIELD   lince1          as char      /*����¹ö1                                        */
    FIELD   lince2          as char      /*����¹ö2                                        */
    FIELD   lince3          as char      /*�ѧ��Ѵ��訴����¹                               */
    FIELD   subcompany1     as char      /*�������º���ѷ��Сѹ���      K3GD                     */
    FIELD   covamount       as char      /*Normal Coverage amount       1400000                  */
    FIELD   grosspremt      as char      /*Normal Gross premium 48344.74                     */
    FIELD   effective       as char      /*Effective date       24/06/2020                       */
    FIELD   notitlt         as char      /*�Ţ�Ѻ��� TLT.     ��¸��ĵ �Դ��ʹ ,�� ��.+�ú. ���TIB */
    FIELD   usrnotlt        as char      /*���ʼ���Ѻ��� TLT. TLT                                */
    FIELD   notipolins      as char      /*�Ţ�Ѻ��� �ҡ�.��Сѹ���   H B0801048                 */
    FIELD   usrnotiins      as char      /*���ͼ���Ѻ��� �ͧ�.��Сѹ���                              */
    FIELD   subcompany2     as char      /*�������º���ѷ��Сѹ���      K3GD                           */
    FIELD   compcovamount   as char      /*Compl. Coverage amount       500000                         */
    FIELD   compgrosspremt  as char      /*Compl. Gross premium 1408.12                            */
    FIELD   compeffective   as char      /*Compl. Effective date        24/06/2020                     */
    FIELD   comp_stk        as char      /*����ͧ���� (�ú.)                                      */
    FIELD   comp_notitlt    as char      /*�Ţ�Ѻ��� TLT.                                            */
    FIELD   comp_usrnotlt   as char      /*���ʼ���Ѻ��� TLT.                                    */
    FIELD   comp_notipolins as char      /*�Ţ�Ѻ��� �ҡ�.��Сѹ���   H B0801048                 */
    FIELD   comp_usrnotiins as char      /*���ͼ���Ѻ��� �ͧ�.��Сѹ���                              */
    FIELD   comp_policy     as char      /*�Ţ�������� �ú.                                            */
    FIELD   trandate        as char      /*�ѹ���.��Сѹ��� �Ѻ���   00000000                   */
    FIELD   driver1         as char      /*���ͼ��Ѻ��� ����� 1        00000 �ӹѡ�ҹ�˭�             */
    FIELD   driver2         as char      /*���ͼ��Ѻ��� ����� 2                                       */
    FIELD   licendriver1    as char      /*�Ţ���㺢Ѻ��� ����� 1       0925536000201                  */
    FIELD   licendriver2    as char      /*�Ţ���㺢Ѻ��� ����� 2                                      */
    FIELD   OLD_engno       as char      /*�����Ţ����ͧ¹�� (���)                               */
    FIELD   OLD_chano       as char      /*�����Ţ��Ƕѧö (���)                                      */
    FIELD   receivename     as char      /*����-ʡ������Ѻ�͡������Ѻ�Թ     ���.���� ��ѧ         */
    FIELD   receiveaddr1    as char      /*������� ��÷Ѵ���1   50 �.1                             */
    FIELD   receiveaddr2    as char      /*������� ��÷Ѵ���2   �.���§��                         */
    FIELD   receiveaddr3    as char      /*������� ��÷Ѵ���3   �.���ͧ��ѧ �.��ѧ                 */
    FIELD   receiveaddr4    as char      /*������� ��÷Ѵ���4                                      */
    FIELD   receiveaddr5    as char      /*������ɳ��� 92170                                      */
    FIELD   Reserved1       as char      /*Reserved1    0000000000000                              */
    FIELD   Reserved2       as char      /*Reserved2    0000000000000                              */
    FIELD   norcovdate      as char      /*Normal End coverage date     24/06/2021                     */
    FIELD   compcovdate     as char      /*Compulsory End coverage date         24/06/2021             */
    FIELD   dealercode      as char      /*Dealer code  HHL1                                       */
    FIELD   caryear         as char      /*��ö 2020                                               */
    FIELD   renewtype       as char      /*Renewal type N                                          */
    FIELD   Reserved5       as char      /*Reserved5                                               */
    FIELD   Reserved6       as char      /*Reserved6    0813558001161                              */
    FIELD   access          as char      /*access                                                      */
    FIELD   branch          as char      /*branch                                                      */
    FIELD   producer        as char      /*producer                                                    */
    FIELD   agent           as char      /*agent                                                       */
    FIELD   Previous        as char      /*Previous Policy                                             */
    FIELD   covcod          as char      /*covcod       1                                              */
    FIELD   nclass          as char       /*class       X110                                           */
    FIELD   GarageType              as char
    FIELD   DriverFlag              as char
    FIELD   Driver1name                 as char
    FIELD   Driver1DOB              as char
    FIELD   Driver1License          as char
    FIELD   Driver2name                 as char
    FIELD   Driver2DOB              as char
    FIELD   Driver2License          as char
    FIELD   DealerCodetlt              as char
    FIELD   CarUsageCode            as char
    FIELD   DeductAmount            as char
    FIELD   EndorsementAdditionals  as char
    FIELD   EndorsementAdditionalP  as char.

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
&Scoped-define FIELDS-IN-QUERY-br_tlt SUBSTRING (tlt.usrsent,1,1) ~
SUBSTRING (tlt.usrsent,2,4) SUBSTRING (tlt.usrsent,6,10) tlt.lotno ~
tlt.seqno tlt.recac tlt.stat tlt.flag tlt.ins_name tlt.ins_addr1 ~
tlt.ins_addr2 tlt.ins_addr3 tlt.ins_addr4 tlt.ins_addr5 tlt.eng_no ~
tlt.cha_no tlt.brand tlt.model tlt.cc_weight tlt.colorcod tlt.lince1 ~
tlt.lince2 tlt.lince3 tlt.subins tlt.nor_coamt tlt.nor_grprm tlt.nor_effdat ~
tlt.nor_noti_tlt tlt.nor_usr_tlt tlt.nor_noti_ins tlt.nor_usr_ins ~
tlt.comp_sub tlt.comp_coamt tlt.comp_grprm tlt.comp_effdat tlt.comp_sck ~
tlt.comp_noti_tlt tlt.comp_usr_tlt tlt.comp_noti_ins tlt.comp_usr_ins ~
tlt.comp_pol tlt.dat_ins_noti tlt.dri_name1 tlt.dri_name2 tlt.dri_no1 ~
tlt.dri_no2 tlt.old_eng tlt.old_cha tlt.rec_name tlt.rec_addr1 ~
tlt.rec_addr2 tlt.rec_addr3 tlt.rec_addr4 tlt.rec_addr5 tlt.filler1 ~
tlt.filler2 
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_tlt 
&Scoped-define QUERY-STRING-br_tlt FOR EACH tlt NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-br_tlt OPEN QUERY br_tlt FOR EACH tlt NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-br_tlt tlt
&Scoped-define FIRST-TABLE-IN-QUERY-br_tlt tlt


/* Definitions for FRAME fr_main                                        */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS bu_im fi_load bu_exit fi_trndatfr ~
fi_trndatto bu_ok cb_search bu_oksch br_tlt fi_search fi_outfile bu_report ~
bu_imp RECT-383 RECT-384 RECT-385 
&Scoped-Define DISPLAYED-OBJECTS fi_load fi_trndatfr fi_trndatto cb_search ~
fi_search fi_outfile 

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

DEFINE BUTTON bu_im 
     LABEL "....." 
     SIZE 8 BY 1.

DEFINE BUTTON bu_imp 
     LABEL "IMP..." 
     SIZE 9 BY 1
     BGCOLOR 7 FONT 6.

DEFINE BUTTON bu_ok 
     LABEL "OK" 
     SIZE 9 BY 1
     BGCOLOR 7 FONT 6.

DEFINE BUTTON bu_oksch 
     LABEL "OK" 
     SIZE 5 BY 1
     FONT 6.

DEFINE BUTTON bu_report 
     LABEL "EXPORT" 
     SIZE 8 BY 1.

DEFINE VARIABLE cb_search AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEMS "���ͼ����һ�Сѹ" 
     DROP-DOWN-LIST
     SIZE 40 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_load AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 60 BY 1 NO-UNDO.

DEFINE VARIABLE fi_outfile AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 50 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_search AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 48 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_trndatfr AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 20 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_trndatto AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 20 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-383
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 71 BY 3.1
     BGCOLOR 23 .

DEFINE RECTANGLE RECT-384
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 58 BY 3.1.

DEFINE RECTANGLE RECT-385
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 13.5 BY 1.91
     BGCOLOR 6 .

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_tlt FOR 
      tlt SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_tlt
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_tlt c-wins _STRUCTURED
  QUERY br_tlt NO-LOCK DISPLAY
      SUBSTRING (tlt.usrsent,1,1) COLUMN-LABEL "Rec.Type"
      SUBSTRING (tlt.usrsent,2,4) COLUMN-LABEL "ComCode"
      SUBSTRING (tlt.usrsent,6,10) COLUMN-LABEL "Application"
      tlt.lotno FORMAT "x(9)":U
      tlt.seqno FORMAT "999999":U
      tlt.recac FORMAT "x":U
      tlt.stat FORMAT "x":U
      tlt.flag FORMAT "x":U
      tlt.ins_name FORMAT "x(50)":U
      tlt.ins_addr1 FORMAT "x(30)":U
      tlt.ins_addr2 FORMAT "x(30)":U
      tlt.ins_addr3 FORMAT "x(30)":U
      tlt.ins_addr4 FORMAT "x(30)":U
      tlt.ins_addr5 FORMAT "x(5)":U
      tlt.eng_no FORMAT "x(20)":U
      tlt.cha_no FORMAT "x(20)":U
      tlt.brand FORMAT "x(3)":U
      tlt.model FORMAT "x(25)":U
      tlt.cc_weight FORMAT ">>,>>9":U
      tlt.colorcod FORMAT "x(4)":U
      tlt.lince1 FORMAT "x(2)":U
      tlt.lince2 FORMAT "x(5)":U
      tlt.lince3 FORMAT "x(2)":U
      tlt.subins FORMAT "x(4)":U
      tlt.nor_coamt FORMAT "->,>>>,>>>,>>9.99":U
      tlt.nor_grprm FORMAT "->,>>>,>>>,>>9.99":U
      tlt.nor_effdat FORMAT "99/99/9999":U
      tlt.nor_noti_tlt FORMAT "x(25)":U
      tlt.nor_usr_tlt FORMAT "x(4)":U
      tlt.nor_noti_ins FORMAT "x(25)":U
      tlt.nor_usr_ins FORMAT "x(50)":U
      tlt.comp_sub FORMAT "x(4)":U
      tlt.comp_coamt FORMAT "->>,>>>,>>9.99":U
      tlt.comp_grprm FORMAT "->>,>>>,>>9.99":U
      tlt.comp_effdat FORMAT "99/99/9999":U
      tlt.comp_sck FORMAT "x(25)":U
      tlt.comp_noti_tlt FORMAT "x(25)":U
      tlt.comp_usr_tlt FORMAT "x(4)":U
      tlt.comp_noti_ins FORMAT "x(25)":U
      tlt.comp_usr_ins FORMAT "x(50)":U
      tlt.comp_pol FORMAT "x(25)":U
      tlt.dat_ins_noti FORMAT "99/99/9999":U
      tlt.dri_name1 FORMAT "x(30)":U
      tlt.dri_name2 FORMAT "x(30)":U
      tlt.dri_no1 FORMAT "x(13)":U
      tlt.dri_no2 FORMAT "x(13)":U
      tlt.old_eng FORMAT "x(20)":U
      tlt.old_cha FORMAT "x(20)":U
      tlt.rec_name FORMAT "x(50)":U
      tlt.rec_addr1 FORMAT "x(30)":U
      tlt.rec_addr2 FORMAT "x(30)":U
      tlt.rec_addr3 FORMAT "x(30)":U
      tlt.rec_addr4 FORMAT "x(30)":U
      tlt.rec_addr5 FORMAT "x(5)":U
      tlt.filler1 FORMAT "x(80)":U
      tlt.filler2 FORMAT "x(80)":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 130 BY 15.95
         BGCOLOR 15 FGCOLOR 1 FONT 1 ROW-HEIGHT-CHARS .81.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     bu_im AT ROW 2.62 COL 85.5 WIDGET-ID 14
     fi_load AT ROW 2.57 COL 23 COLON-ALIGNED NO-LABEL WIDGET-ID 8
     bu_exit AT ROW 2.95 COL 119.5
     fi_trndatfr AT ROW 3.91 COL 23 COLON-ALIGNED NO-LABEL
     fi_trndatto AT ROW 3.91 COL 50 COLON-ALIGNED NO-LABEL
     bu_ok AT ROW 3.91 COL 74.5
     cb_search AT ROW 5.38 COL 16.5 COLON-ALIGNED NO-LABEL
     bu_oksch AT ROW 6.52 COL 53.33
     br_tlt AT ROW 8.62 COL 2.5
     fi_search AT ROW 6.52 COL 3.5 NO-LABEL
     fi_outfile AT ROW 6.52 COL 72.67 NO-LABEL
     bu_report AT ROW 6.52 COL 123.33
     bu_imp AT ROW 2.62 COL 94 WIDGET-ID 12
     " OUTPUT:" VIEW-AS TEXT
          SIZE 10 BY 1 AT ROW 6.52 COL 62
          BGCOLOR 3 FGCOLOR 7 FONT 6
     "�ѹ�������駧ҹ  From :" VIEW-AS TEXT
          SIZE 21.5 BY 1 AT ROW 3.91 COL 2.5
          BGCOLOR 29 FGCOLOR 2 FONT 6
     "SEARCH BY :" VIEW-AS TEXT
          SIZE 14 BY 1 AT ROW 5.38 COL 3.5
          BGCOLOR 3 FGCOLOR 7 FONT 6
     "REPORT BY :" VIEW-AS TEXT
          SIZE 14 BY 1 AT ROW 5.38 COL 62
          BGCOLOR 3 FGCOLOR 7 FONT 6
     "               LOAD FILE :" VIEW-AS TEXT
          SIZE 21.5 BY 1 AT ROW 2.57 COL 2.5 WIDGET-ID 10
          BGCOLOR 29 FGCOLOR 2 FONT 6
     "To  :" VIEW-AS TEXT
          SIZE 5.5 BY 1 AT ROW 3.91 COL 46
          BGCOLOR 29 FGCOLOR 2 FONT 6
     "                         LOAD FILE / QUERY / EXPORT DATA  TOYOTA AND HINO" VIEW-AS TEXT
          SIZE 131 BY 1.19 AT ROW 1.19 COL 1.5 WIDGET-ID 18
          BGCOLOR 3 FGCOLOR 7 FONT 2
     RECT-383 AT ROW 5.05 COL 61 WIDGET-ID 20
     RECT-384 AT ROW 5.05 COL 2.5 WIDGET-ID 22
     RECT-385 AT ROW 2.57 COL 118 WIDGET-ID 24
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 24
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
         TITLE              = "Query && Update [Toyota and Hino]"
         HEIGHT             = 23.91
         WIDTH              = 132
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
     _FldNameList[1]   > "_<CALC>"
"SUBSTRING (tlt.usrsent,1,1)" "Rec.Type" ? ? ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[2]   > "_<CALC>"
"SUBSTRING (tlt.usrsent,2,4)" "ComCode" ? ? ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   > "_<CALC>"
"SUBSTRING (tlt.usrsent,6,10)" "Application" ? ? ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   = brstat.tlt.lotno
     _FldNameList[5]   = brstat.tlt.seqno
     _FldNameList[6]   = brstat.tlt.recac
     _FldNameList[7]   = brstat.tlt.stat
     _FldNameList[8]   = brstat.tlt.flag
     _FldNameList[9]   = brstat.tlt.ins_name
     _FldNameList[10]   = brstat.tlt.ins_addr1
     _FldNameList[11]   = brstat.tlt.ins_addr2
     _FldNameList[12]   = brstat.tlt.ins_addr3
     _FldNameList[13]   = brstat.tlt.ins_addr4
     _FldNameList[14]   = brstat.tlt.ins_addr5
     _FldNameList[15]   = brstat.tlt.eng_no
     _FldNameList[16]   = brstat.tlt.cha_no
     _FldNameList[17]   = brstat.tlt.brand
     _FldNameList[18]   = brstat.tlt.model
     _FldNameList[19]   = brstat.tlt.cc_weight
     _FldNameList[20]   = brstat.tlt.colorcod
     _FldNameList[21]   = brstat.tlt.lince1
     _FldNameList[22]   = brstat.tlt.lince2
     _FldNameList[23]   = brstat.tlt.lince3
     _FldNameList[24]   = brstat.tlt.subins
     _FldNameList[25]   = brstat.tlt.nor_coamt
     _FldNameList[26]   = brstat.tlt.nor_grprm
     _FldNameList[27]   = brstat.tlt.nor_effdat
     _FldNameList[28]   = brstat.tlt.nor_noti_tlt
     _FldNameList[29]   = brstat.tlt.nor_usr_tlt
     _FldNameList[30]   = brstat.tlt.nor_noti_ins
     _FldNameList[31]   = brstat.tlt.nor_usr_ins
     _FldNameList[32]   = brstat.tlt.comp_sub
     _FldNameList[33]   = brstat.tlt.comp_coamt
     _FldNameList[34]   = brstat.tlt.comp_grprm
     _FldNameList[35]   = brstat.tlt.comp_effdat
     _FldNameList[36]   = brstat.tlt.comp_sck
     _FldNameList[37]   = brstat.tlt.comp_noti_tlt
     _FldNameList[38]   = brstat.tlt.comp_usr_tlt
     _FldNameList[39]   = brstat.tlt.comp_noti_ins
     _FldNameList[40]   = brstat.tlt.comp_usr_ins
     _FldNameList[41]   = brstat.tlt.comp_pol
     _FldNameList[42]   = brstat.tlt.dat_ins_noti
     _FldNameList[43]   = brstat.tlt.dri_name1
     _FldNameList[44]   = brstat.tlt.dri_name2
     _FldNameList[45]   = brstat.tlt.dri_no1
     _FldNameList[46]   = brstat.tlt.dri_no2
     _FldNameList[47]   = brstat.tlt.old_eng
     _FldNameList[48]   = brstat.tlt.old_cha
     _FldNameList[49]   = brstat.tlt.rec_name
     _FldNameList[50]   = brstat.tlt.rec_addr1
     _FldNameList[51]   = brstat.tlt.rec_addr2
     _FldNameList[52]   = brstat.tlt.rec_addr3
     _FldNameList[53]   = brstat.tlt.rec_addr4
     _FldNameList[54]   = brstat.tlt.rec_addr5
     _FldNameList[55]   = brstat.tlt.filler1
     _FldNameList[56]   = brstat.tlt.filler2
     _Query            is NOT OPENED
*/  /* BROWSE br_tlt */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME c-wins
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c-wins c-wins
ON END-ERROR OF c-wins /* Query  Update [Toyota and Hino] */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c-wins c-wins
ON WINDOW-CLOSE OF c-wins /* Query  Update [Toyota and Hino] */
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
    
    Run  wgw\wgwqtib3 (Input  nv_recidtlt).

    {&WINDOW-NAME}:hidden  =  No.                                               

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_tlt c-wins
ON MOUSE-SELECT-CLICK OF br_tlt IN FRAME fr_main
DO:
    Get  current  br_tlt.
     nv_rectlt =  recid(tlt).
     
      
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_tlt c-wins
ON VALUE-CHANGED OF br_tlt IN FRAME fr_main
DO:
     Get  current  br_tlt.
     nv_rectlt =  recid(tlt).
      
     
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


&Scoped-define SELF-NAME bu_im
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_im c-wins
ON CHOOSE OF bu_im IN FRAME fr_main /* ..... */
DO:
    DEFINE VARIABLE cvData        AS CHARACTER NO-UNDO.
    DEFINE VARIABLE OKpressed AS LOGICAL INITIAL TRUE.
    DEF VAR no_add AS CHAR FORMAT "x(8)" .  
    SYSTEM-DIALOG GET-FILE cvData
        TITLE      "Choose Data File to Import ..."
        FILTERS     "CSV (Comma Delimited)"   "*.csv" 
        MUST-EXIST
        USE-FILENAME
        UPDATE OKpressed.
    IF OKpressed = TRUE THEN DO:
        ASSIGN
            fi_load  = cvData .
        
        DISP fi_load  WITH FRAME fr_main. 
        APPLY "Entry" TO fi_load.
        RETURN NO-APPLY.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_imp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_imp c-wins
ON CHOOSE OF bu_imp IN FRAME fr_main /* IMP... */
DO:
    IF fi_load = "" THEN DO:
        MESSAGE "��س��ʪ������!!!"  VIEW-AS ALERT-BOX.
        Apply "Entry"  to fi_load.
        Return no-apply. 
    END.
    ELSE DO:
        RUN pd_loadfile.
        Message "Load data Complete"  View-as alert-box.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_ok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_ok c-wins
ON CHOOSE OF bu_ok IN FRAME fr_main /* OK */
DO:
    Open Query br_tlt
        For each brstat.tlt Use-index  tlt01  Where
        brstat.tlt.trndat  >=   fi_trndatfr   And
        brstat.tlt.trndat  <=   fi_trndatto   AND 
        brstat.tlt.genusr   =  "TIB"        no-lock.  
            nv_rectlt =  recid(brstat.tlt).   
            Apply "Entry"  to br_tlt.
            Return no-apply.  
     
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_oksch
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_oksch c-wins
ON CHOOSE OF bu_oksch IN FRAME fr_main /* OK */
DO:
    If  cb_search = "�����١���"  Then do:              /* name  */                          
        Open Query br_tlt                                                        
            For each brstat.tlt Use-index  tlt01      Where                                     
            brstat.tlt.trndat  >=  fi_trndatfr        And                                            
            brstat.tlt.trndat  <=  fi_trndatto        And  
            brstat.tlt.genusr   =  "TIB"              And
            index(brstat.tlt.ins_name,fi_search) <> 0 no-lock.
                ASSIGN nv_rectlt =  recid(brstat.tlt) .  
                Apply "Entry"  to br_tlt.
                Return no-apply.   
    END.
    ELSE If  cb_search  = "�Ţ��Ƕѧ"  Then do:  /* chassis no */
        Open Query br_tlt 
            For each brstat.tlt Use-index  tlt06 Where
            brstat.tlt.cha_no   = trim(fi_search)  AND
            brstat.tlt.genusr   =  "TIB"           no-lock.
                ASSIGN nv_rectlt =  recid(brstat.tlt) .  
                Apply "Entry"  to br_tlt.
                Return no-apply.            
    END.
    ELSE If  cb_search  = "�Ţ����ͧ"  Then do:  /* eng_no */
        Open Query br_tlt 
            For each brstat.tlt Use-index  tlt07 Where
            brstat.tlt.eng_no  = trim(fi_search)  AND
            brstat.tlt.genusr  =  "TIB"           no-lock.

                ASSIGN nv_rectlt =  recid(brstat.tlt) .  
                Apply "Entry"  to br_tlt.
                Return no-apply.            
    END.  
    ELSE If  cb_search  = "Lotno"  Then do:  /* Lotno */
        Open Query br_tlt 
            For each brstat.tlt Use-index  tlt01  Where
            brstat.tlt.trndat >=  fi_trndatfr      And
            brstat.tlt.trndat <=  fi_trndatto      AND 
            brstat.tlt.genusr  =  "TIB"            And
            brstat.tlt.lotno   = trim(fi_search)   no-lock.
                ASSIGN nv_rectlt =  recid(brstat.tlt) .  
                Apply "Entry"  to br_tlt.
                Return no-apply.            
    END.   
    ELSE If  cb_search  =  "�Ţ����Ѻ��"  Then do:   /* policy */
        Open Query br_tlt 
            For each brstat.tlt Use-index  tlt01 Where
            brstat.tlt.trndat   >=  fi_trndatfr  And
            brstat.tlt.trndat   <=  fi_trndatto  And
            brstat.tlt.genusr    =  "TIB"  And
            index(brstat.tlt.nor_noti_ins,fi_search) <> 0  no-lock.
                ASSIGN nv_rectlt =  recid(brstat.tlt) .  
                Apply "Entry"  to br_tlt.
                Return no-apply.        
    END.  /*
    ELSE If  cb_search  =  "������������"  Then do:   /* policy */
        Open Query br_tlt 
            For each tlt Use-index  tlt01 Where
            tlt.trndat   >=  fi_trndatfr  And
            tlt.trndat   <=  fi_trndatto  And
            tlt.genusr    =  "TIB"      And
            tlt.flag     =  "R"                And  /*a63-0174 */
            index(tlt.nor_noti_ins,fi_search) <> 0  no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .  
                Apply "Entry"  to br_tlt.
                Return no-apply.        
    END.*/
    
    Else  do:
            ASSIGN nv_rectlt =  recid(brstat.tlt) .  
            Apply "Entry"  to  fi_search.
            Return no-apply.
         
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
        RUN pd_reportnew.  
        Message "Export data Complete"  View-as alert-box.
    END.
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
    cb_search = INPUT cb_search.
    n_asdat =  (INPUT cb_search).
    IF n_asdat = "" THEN DO:
        MESSAGE "��辺������ ��ä�" VIEW-AS ALERT-BOX WARNING.
        RETURN NO-APPLY.
    END.
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_load
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_load c-wins
ON LEAVE OF fi_load IN FRAME fr_main
DO:
  fi_load = INPUT fi_load.
  DISP fi_load WITH FRAM fr_main.
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
  gv_prgid = "wgwqtib0.w".
  gv_prog  = "Query & Update  Detail  (TOYOTA AND HINO) ".
  RUN  WUT\WUTHEAD ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).

  SESSION:DATA-ENTRY-RETURN = YES.

  /*Rect-333:Move-to-top().*/
 


  ASSIGN 
       
      fi_trndatfr = TODAY
      fi_trndatto = TODAY
     /*ra_choice   =  1 */ /*A55-0184*/
      /*fi_polfr    = "0"
      fi_polto    = "Z" */   
      vAcProc_fil = vAcProc_fil   + "�����١���"   + "," 
                                  + "�Ţ��Ƕѧ"    + ","
                                  + "�Ţ����ͧ"   + "," 
                                  + "Lotno"   + "," 
                                /*  + "������������" + "," 
                                  + "�Ţ����Ѻ��" + "," 
                                  + "�Ţ����ѭ��" + "," 
                                  + "�����������" + "," 
                                  + "�Ţ��Ƕѧ"      + "," 
                                  + "Confirm_yes"     + "," 
                                  + "Confirm_No" + ","
                                  + "������������"  + ","  
                                  + "Status_cancel"  + ","
                                  + "�Ң�"  + ","*/
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
         
         
       
      fi_outfile = "D:\TEMP\TOYOTA_HINO" + 
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

  /*HIDE br_tlt.*/
  Disp fi_trndatfr  fi_trndatto cb_search   fi_outfile
         with frame fr_main.

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
  DISPLAY fi_load fi_trndatfr fi_trndatto cb_search fi_search fi_outfile 
      WITH FRAME fr_main IN WINDOW c-wins.
  ENABLE bu_im fi_load bu_exit fi_trndatfr fi_trndatto bu_ok cb_search bu_oksch 
         br_tlt fi_search fi_outfile bu_report bu_imp RECT-383 RECT-384 
         RECT-385 
      WITH FRAME fr_main IN WINDOW c-wins.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW c-wins.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_loadfile c-wins 
PROCEDURE pd_loadfile :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

FOR EACH TB-ErrorCd.
    DELETE TB-ErrorCd.
END.

INPUT FROM VALUE(fi_load).  
REPEAT:
    CREATE TB-ErrorCd.
    IMPORT DELIMITER "|" 
        TB-ErrorCd.ntype          
        TB-ErrorCd.companycode    
        TB-ErrorCd.sendate        
        TB-ErrorCd.applino        
        TB-ErrorCd.lotno          
        TB-ErrorCd.seqno          
        TB-ErrorCd.recordno       
        TB-ErrorCd.nSTATUS        
        TB-ErrorCd.flag           
        TB-ErrorCd.nTITLE         
        TB-ErrorCd.nNAME          
        TB-ErrorCd.addr1          
        TB-ErrorCd.addr2          
        TB-ErrorCd.addr3          
        TB-ErrorCd.addr4          
        TB-ErrorCd.addr5          
        TB-ErrorCd.engno          
        TB-ErrorCd.chano          
        TB-ErrorCd.brand          
        TB-ErrorCd.model          
        TB-ErrorCd.engcc          
        TB-ErrorCd.nCOLOR         
        TB-ErrorCd.lince1         
        TB-ErrorCd.lince2         
        TB-ErrorCd.lince3         
        TB-ErrorCd.subcompany1    
        TB-ErrorCd.covamount      
        TB-ErrorCd.grosspremt     
        TB-ErrorCd.effective      
        TB-ErrorCd.notitlt        
        TB-ErrorCd.usrnotlt       
        TB-ErrorCd.notipolins     
        TB-ErrorCd.usrnotiins     
        TB-ErrorCd.subcompany2    
        TB-ErrorCd.compcovamount  
        TB-ErrorCd.compgrosspremt 
        TB-ErrorCd.compeffective  
        TB-ErrorCd.comp_stk       
        TB-ErrorCd.comp_notitlt   
        TB-ErrorCd.comp_usrnotlt  
        TB-ErrorCd.comp_notipolins
        TB-ErrorCd.comp_usrnotiins
        TB-ErrorCd.comp_policy    
        TB-ErrorCd.trandate       
        TB-ErrorCd.driver1        
        TB-ErrorCd.driver2  
        TB-ErrorCd.licendriver1
        TB-ErrorCd.licendriver2
        TB-ErrorCd.OLD_engno   
        TB-ErrorCd.OLD_chano   
        TB-ErrorCd.receivename 
        TB-ErrorCd.receiveaddr1
        TB-ErrorCd.receiveaddr2
        TB-ErrorCd.receiveaddr3
        TB-ErrorCd.receiveaddr4
        TB-ErrorCd.receiveaddr5
        TB-ErrorCd.Reserved1   
        TB-ErrorCd.Reserved2   
        TB-ErrorCd.norcovdate  
        TB-ErrorCd.compcovdate 
        TB-ErrorCd.dealercode  
        TB-ErrorCd.caryear     
        TB-ErrorCd.renewtype   
        TB-ErrorCd.Reserved5   
        TB-ErrorCd.Reserved6   
        TB-ErrorCd.access      
        TB-ErrorCd.branch      
        TB-ErrorCd.producer    
        TB-ErrorCd.agent       
        TB-ErrorCd.Previous                  
        TB-ErrorCd.covcod                   
        TB-ErrorCd.nclass                    
        TB-ErrorCd.GarageType               
        TB-ErrorCd.DriverFlag           
        TB-ErrorCd.Driver1name               
        TB-ErrorCd.Driver1DOB             
        TB-ErrorCd.Driver1License            
        TB-ErrorCd.Driver2name           
        TB-ErrorCd.Driver2DOB              
        TB-ErrorCd.Driver2License     
        TB-ErrorCd.DealerCodetlt            
        TB-ErrorCd.CarUsageCode             
        TB-ErrorCd.DeductAmount             
        TB-ErrorCd.EndorsementAdditionals   
        TB-ErrorCd.EndorsementAdditionalP   
        .
END.

FOR EACH TB-ErrorCd WHERE 
    TB-ErrorCd.ntype <> "��������¡��" AND 
    TB-ErrorCd.ntype <> ""             NO-LOCK . 

    FIND LAST tlt WHERE 
        tlt.genusr       = "TIB"                  AND 
        tlt.lotno        = TB-ErrorCd.lotno       AND   
        tlt.seqno        = int(TB-ErrorCd.seqno)       AND 
        tlt.nor_noti_ins = TB-ErrorCd.notipolins  NO-LOCK NO-ERROR.    
    IF NOT AVAIL tlt THEN DO:
        CREATE tlt.
        ASSIGN 
            tlt.genusr    = "TIB" 
            tlt.trndat    = TODAY                                                   
            substr(tlt.usrsent,1,1)   = trim(TB-ErrorCd.ntype)           /*��������¡��*/
            substr(tlt.usrsent,2,4)   = trim(TB-ErrorCd.companycode)                          /*���ʺ���ѷ*/
            substr(tlt.usrsent,6,10)  = trim(TB-ErrorCd.applino)                                /*�Ţ���(ApplicationNo.)*/
            tlt.datesent  = date(substr(trim(TB-ErrorCd.sendate),7,2) + "/" +       /*�ѹ�����*/
                                 substr(trim(TB-ErrorCd.sendate),5,2) + "/" +       
                                 substr(trim(TB-ErrorCd.sendate),1,4))              
                         
            tlt.lotno         = trim(TB-ErrorCd.lotno)                              /*Lotno.                        */
            tlt.seqno         = int(trim(TB-ErrorCd.seqno))                         /*Seqno.                        */
            tlt.recac         = trim(TB-ErrorCd.recordno)                           /*Record Active.                */
            tlt.stat          = trim(TB-ErrorCd.nSTATUS)                            /*ʶҹ�                         */
            tlt.flag          = trim(TB-ErrorCd.flag)                               /*����Ţ����ͧ¹��/�Ţ��Ƕѧ */
            tlt.ins_name      = trim(TB-ErrorCd.nTITLE)    + " " +                  /*�ӹ�                          */
                                trim(TB-ErrorCd.nNAME)                                  /*���ͼ����һ�Сѹ���           */
            tlt.ins_addr1     = trim(TB-ErrorCd.addr1)                                  /*�����������һ�Сѹ���1       */
            tlt.ins_addr2     = trim(TB-ErrorCd.addr2)                                  /*�����������һ�Сѹ���2       */
            tlt.ins_addr3     = trim(TB-ErrorCd.addr3)                                  /*�����������һ�Сѹ���3       */
            tlt.ins_addr4     = trim(TB-ErrorCd.addr4)                                  /*�����������һ�Сѹ���4       */
            tlt.ins_addr5     = trim(TB-ErrorCd.addr5)                                  /*�����������һ�Сѹ���5       */
            tlt.eng_no        = trim(TB-ErrorCd.engno)                                  /*�Ţ����ͧ¹��                */
            tlt.cha_no        = trim(TB-ErrorCd.chano)                                  /*�Ţ��Ƕѧ                     */
            tlt.brand         = trim(TB-ErrorCd.brand)                                  /*����������ö                  */
            tlt.model         = trim(TB-ErrorCd.model)                                  /*���ö                        */
            tlt.cc_weight     = int(trim(TB-ErrorCd.engcc))                         /*��Ҵ����ͧ¹��               */
            tlt.colorcod      = trim(TB-ErrorCd.nCOLOR)                                 /*��ö                          */
            tlt.lince1        = trim(TB-ErrorCd.lince1)                                 /*����¹ö1                    */
            tlt.lince2        = trim(TB-ErrorCd.lince2)                                 /*����¹ö2                    */
            tlt.lince3        = trim(TB-ErrorCd.lince3)                                 /*�ѧ��Ѵ��訴����¹           */
            tlt.subins        = trim(TB-ErrorCd.subcompany1)                            /*�������º���ѷ��Сѹ���       */
            tlt.nor_coamt     = deci(trim(TB-ErrorCd.covamount))                    /*Normal Coverage amount        */
            tlt.nor_grprm     = deci(trim(TB-ErrorCd.grosspremt))                   /*Normal Gross premium          */
            tlt.nor_effdat    = date(substr(trim(TB-ErrorCd.effective),1,2) + "/" +  /*Effective date                */
                                     substr(trim(TB-ErrorCd.effective),4,2) + "/" +
                                     substr(trim(TB-ErrorCd.effective),7,4))       
            tlt.nor_noti_tlt  = trim(TB-ErrorCd.notitlt)                                /*�Ţ�Ѻ��� TLT.              */
            tlt.nor_usr_tlt   = trim(TB-ErrorCd.usrnotlt)                               /*���ʼ���Ѻ��� TLT.          */
            tlt.nor_noti_ins  = trim(TB-ErrorCd.notipolins)                             /*�Ţ�Ѻ��� �ҡ�.��Сѹ���    */
            tlt.nor_usr_ins   = trim(TB-ErrorCd.usrnotiins)                             /*���ͼ���Ѻ��� �ͧ�.��Сѹ���*/
            tlt.comp_sub      = trim(TB-ErrorCd.subcompany2)                            /*�������º���ѷ��Сѹ���          */
            tlt.comp_coamt    = deci(trim(TB-ErrorCd.compcovamount))                    /*Compl. Coverage amount           */
            tlt.comp_grprm    = deci(trim(TB-ErrorCd.compgrosspremt))                   /*Compl. Gross premium             */

            tlt.comp_effdat   = IF TB-ErrorCd.compeffective = "00/00/0000" THEN ? 
                                ELSE IF TB-ErrorCd.compeffective = "" THEN ? 
                                ELSE 
                                    date(substr(trim(TB-ErrorCd.compeffective),1,2) + "/" +  /*Compl. Effective date            */
                                     substr(trim(TB-ErrorCd.compeffective),4,2) + "/" +  
                                     substr(trim(TB-ErrorCd.compeffective),7,4))         
            tlt.comp_sck      = trim(TB-ErrorCd.comp_stk)                                    /*����ͧ���� (�ú.)               */
            tlt.comp_noti_tlt = trim(TB-ErrorCd.comp_notitlt)                                /*�Ţ�Ѻ��� TLT.                 */
            tlt.comp_usr_tlt  = trim(TB-ErrorCd.comp_usrnotlt)                               /*���ʼ���Ѻ��� TLT.             */
            tlt.comp_noti_ins = trim(TB-ErrorCd.comp_notipolins)                             /*�Ţ�Ѻ��� �ҡ�.��Сѹ���       */
            tlt.comp_usr_ins  = trim(TB-ErrorCd.comp_usrnotiins)                             /*���ͼ���Ѻ��� �ͧ�.��Сѹ���   */
            tlt.comp_pol      = trim(TB-ErrorCd.comp_policy)                                 /*�Ţ�������� �ú.                 */
            tlt.imp           = trim(TB-ErrorCd.trandate)          

            tlt.dri_name1     = trim(TB-ErrorCd.driver1)                       /*���ͼ��Ѻ��� ����� 1            */
            tlt.dri_name2     = trim(TB-ErrorCd.driver2)                       /*���ͼ��Ѻ��� ����� 2            */
            tlt.dri_no1       = trim(TB-ErrorCd.licendriver1)                  /*�Ţ���㺢Ѻ��� ����� 1           */
            tlt.dri_no2       = trim(TB-ErrorCd.licendriver2)                  /*�Ţ���㺢Ѻ��� ����� 2           */
            tlt.old_eng       = trim(TB-ErrorCd.OLD_engno)                     /*�����Ţ����ͧ¹�� (���)        */
            tlt.old_cha       = trim(TB-ErrorCd.OLD_chano)                     /*�����Ţ��Ƕѧö (���)           */
            tlt.rec_name      = trim(TB-ErrorCd.receivename)                   /*����-ʡ������Ѻ�͡������Ѻ�Թ */
            tlt.rec_addr1     = trim(TB-ErrorCd.receiveaddr1)                  /*������� ��÷Ѵ���1               */
            tlt.rec_addr2     = trim(TB-ErrorCd.receiveaddr2)                  /*������� ��÷Ѵ���2               */
            tlt.rec_addr3     = trim(TB-ErrorCd.receiveaddr3)                  /*������� ��÷Ѵ���3               */
            tlt.rec_addr4     = trim(TB-ErrorCd.receiveaddr4)                  /*������� ��÷Ѵ���4               */
            tlt.rec_addr5     = trim(TB-ErrorCd.receiveaddr5)                  /*������ɳ���                     */
            tlt.filler1       = trim(TB-ErrorCd.Reserved1)                     /*Reserved1                        */
            tlt.filler2       = trim(TB-ErrorCd.Reserved2)                 /*Reserved2                        */
            tlt.exp           = trim(TB-ErrorCd.norcovdate)                /*Normal End coverage date         */
            tlt.expodat       = IF      TB-ErrorCd.compcovdate = "00/00/0000" THEN ? 
                                ELSE IF TB-ErrorCd.compcovdate = "" THEN ? 
                                ELSE date(substr(trim(TB-ErrorCd.compcovdate),1,2) + "/" +        /*Compulsory End coverage date     */
                                          substr(trim(TB-ErrorCd.compcovdate),4,2) + "/" +
                                          substr(trim(TB-ErrorCd.compcovdate),7,4))      
                                


            tlt.safe1         = "Dealer:"      + TB-ErrorCd.dealercode  +  /*Dealer code                      */
                                "Caryear:"     + TB-ErrorCd.caryear     +  /*��ö           */ 
                                "RenewalType:" + TB-ErrorCd.renewtype   +  /*Renewal type   */ 
                                "ID:"          + TB-ErrorCd.Reserved6   +  /*Reserved6      */ 
                                "Branch:"      + TB-ErrorCd.branch      +  /*branch         */ 
                                "Producer:"    + TB-ErrorCd.producer    +  /*producer       */ 
                                "Agent:"       + TB-ErrorCd.agent       +  /*agent          */ 
                                "Prepol:"      + TB-ErrorCd.Previous    +  /*Previous Policy*/ 
                                "Cover:"       + TB-ErrorCd.covcod      +  /*covcod         */ 
                                "Class:"       + TB-ErrorCd.nclass         /*class          */ 
            tlt.safe2     = trim(TB-ErrorCd.Reserved5)                 /*Reserved5      */ 
            tlt.safe3     = TRIM(TB-ErrorCd.access)  
            tlt.note8     = trim(TB-ErrorCd.GarageType)
            tlt.note9     = trim(TB-ErrorCd.DriverFlag)
            tlt.dri_name1 = trim(TB-ErrorCd.Driver1name)
            tlt.note1     = trim(TB-ErrorCd.Driver1DOB)
            tlt.dri_lic1  = trim(TB-ErrorCd.Driver1License)
            tlt.dri_name2 = trim(TB-ErrorCd.Driver2name)
            tlt.note2     = trim(TB-ErrorCd.Driver2DOB)
            tlt.dri_lic2  = trim(TB-ErrorCd.Driver2License)
            tlt.note3     = trim(TB-ErrorCd.DealerCodetlt)
            tlt.note4     = trim(TB-ErrorCd.CarUsageCode)
            tlt.note5     = trim(TB-ErrorCd.DeductAmount)
            tlt.note6     = trim(TB-ErrorCd.EndorsementAdditionals)
            tlt.note7     = trim(TB-ErrorCd.EndorsementAdditionalP)
                                    .            /*access         */ 
        
    END.
END.
 
MESSAGE  "Import Data Complete"   VIEW-AS ALERT-BOX.  

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
DEF VAR nv_title AS CHAR .
DEF VAR nv_name  AS CHAR .

DEF VAR nv_Dealer       as char.
DEF VAR nv_Caryear      as char.
DEF VAR nv_RenewalType  as char.
DEF VAR nv_ID           as char.
DEF VAR nv_Branch       as char.
DEF VAR nv_Producer     as char.
DEF VAR nv_Agent        as char.
DEF VAR nv_Prepol       as char.
DEF VAR nv_Cover        as char.
DEF VAR nv_CLASS        as char.
DEF VAR safe1           AS CHAR.

If  substr(fi_outfile,length(fi_outfile) - 3,4) <>  ".slk"  THEN 
    fi_outfile  =  Trim(fi_outfile) + ".slk"  .
OUTPUT TO VALUE(fi_outfile).
EXPORT DELIMITER "|" 
    "��������¡��"
    "���ʺ���ѷ"
    "�ѹ�����"
    "�Ţ���(ApplicationNo.)"
    "Lotno."
    "Seqno."
    "Record Active."
    "ʶҹ�"
    "����Ţ����ͧ¹��/�Ţ��Ƕѧ"
    "�ӹ�"
    "���ͼ����һ�Сѹ���"
    "�����������һ�Сѹ���1"
    "�����������һ�Сѹ���2"
    "�����������һ�Сѹ���3"
    "�����������һ�Сѹ���4"
    "�����������һ�Сѹ���5"
    "�Ţ����ͧ¹��"
    "�Ţ��Ƕѧ"
    "����������ö"
    "���ö"
    "��Ҵ����ͧ¹��"
    "��ö"
    "����¹ö1"
    "����¹ö2"
    "�ѧ��Ѵ��訴����¹"
    "�������º���ѷ��Сѹ���"
    "Normal Coverage amount"
    "Normal Gross premium"
    "Effective date"
    "�Ţ�Ѻ��� TLT."
    "���ʼ���Ѻ��� TLT."
    "�Ţ�Ѻ��� �ҡ�.��Сѹ���"
    "���ͼ���Ѻ��� �ͧ�.��Сѹ���"
    "�������º���ѷ��Сѹ���"
    "Compl. Coverage amount"
    "Compl. Gross premium"
    "Compl. Effective date"
    "����ͧ���� (�ú.)"
    "�Ţ�Ѻ��� TLT."
    "���ʼ���Ѻ��� TLT."
    "�Ţ�Ѻ��� �ҡ�.��Сѹ���"
    "���ͼ���Ѻ��� �ͧ�.��Сѹ���"
    "�Ţ�������� �ú."
    "�ѹ���.��Сѹ��� �Ѻ���"
    "���ͼ��Ѻ��� ����� 1"
    "���ͼ��Ѻ��� ����� 2"
    "�Ţ���㺢Ѻ��� ����� 1"
    "�Ţ���㺢Ѻ��� ����� 2"
    "�����Ţ����ͧ¹�� (���)"
    "�����Ţ��Ƕѧö (���)"
    "����-ʡ������Ѻ�͡������Ѻ�Թ"
    "������� ��÷Ѵ���1" 
    "������� ��÷Ѵ���2"
    "������� ��÷Ѵ���3"
    "������� ��÷Ѵ���4"
    "������ɳ���"
    "Reserved1"
    "Reserved2"
    "Normal End coverage date"
    "Compulsory End coverage date"
    "Dealer code"
    "��ö"
    "Renewal type"
    "Reserved5"
    "Reserved6"
    "access"
    "branch"
    "producer"
    "agent"
    "Previous Policy"
    "covcod"
    "class" 
    "GarageType"                            
    "DriverFlag"                            
    "Driver1Name"                       
    "Driver1DOB"                       
    "Driver1License"               
    "Driver2Name"                          
    "Driver2DOB"               
    "Driver2License"  
    "Dealer Code"
    "Car Usage Code"                                 
    "Deduct Amount"                                       
    "�ع��ѡ��ѧ����"               
    "������ѡ��ѧ����" .

For each brstat.tlt Use-index  tlt01 Where
    brstat.tlt.trndat   >=  fi_trndatfr   And
    brstat.tlt.trndat   <=  fi_trndatto   And
    brstat.tlt.genusr    =  "TIB"         no-lock. 

    IF INDEX(tlt.ins_name," ") <> 0 THEN 
        ASSIGN 
        nv_title  = trim(SUBSTR(tlt.ins_name,1,INDEX(tlt.ins_name," ")))
        nv_name   = trim(SUBSTR(tlt.ins_name,INDEX(tlt.ins_name," "))).
    ELSE 
        ASSIGN     
            nv_title  = ""
            nv_name   = tlt.ins_name.
        
    ASSIGN
        safe1          = TRIM(tlt.safe1)
        nv_CLASS       = SUBSTR(safe1,INDEX(safe1,"Class:"))  
        nv_CLASS       = REPLACE(nv_CLASS,"Class:","")
        safe1          = SUBSTR(safe1,1,INDEX(safe1,"Class:") - 1 )
        nv_Cover       = SUBSTR(safe1,INDEX(safe1,"Cover:"))  
        nv_Cover       = REPLACE(nv_Cover,"Cover:","")
        safe1          = SUBSTR(safe1,1,INDEX(safe1,"Cover:") - 1 )
        nv_Prepol      = SUBSTR(safe1,INDEX(safe1,"Prepol:"))  
        nv_Prepol      = REPLACE(nv_Prepol,"Prepol:","")
        safe1          = SUBSTR(safe1,1,INDEX(safe1,"Prepol:") - 1 )
        nv_Agent       = SUBSTR(safe1,INDEX(safe1,"Agent:"))  
        nv_Agent       = REPLACE(nv_Agent,"Agent:","")
        safe1          = SUBSTR(safe1,1,INDEX(safe1,"Agent:") - 1 )
        nv_Producer    = SUBSTR(safe1,INDEX(safe1,"Producer:"))  
        nv_Producer    = REPLACE(nv_Producer,"Producer:","")
        safe1          = SUBSTR(safe1,1,INDEX(safe1,"Producer:") - 1 ) 
        nv_Branch      = SUBSTR(safe1,INDEX(safe1,"Branch:")) 
        nv_Branch      = REPLACE(nv_Branch,"Branch:","")
        safe1          = SUBSTR(safe1,1,INDEX(safe1,"Branch:") - 1 ) 
        nv_ID          = SUBSTR(safe1,INDEX(safe1,"ID:")) 
        nv_ID          = REPLACE(nv_ID,"ID:","")
        safe1          = SUBSTR(safe1,1,INDEX(safe1,"ID:") - 1 ) 
        nv_RenewalType = SUBSTR(safe1,INDEX(safe1,"RenewalType:")) 
        nv_RenewalType = REPLACE(nv_RenewalType,"RenewalType:","")
        safe1          = SUBSTR(safe1,1,INDEX(safe1,"RenewalType:") - 1 ) 
        nv_Caryear     = SUBSTR(safe1,INDEX(safe1,"Caryear:")) 
        nv_Caryear     = REPLACE(nv_Caryear,"Caryear:","")
        safe1          = SUBSTR(safe1,1,INDEX(safe1,"Caryear:") - 1 )
        nv_Dealer      = SUBSTR(safe1,INDEX(safe1,"Dealer:")) 
        nv_Dealer      = REPLACE(nv_Dealer,"Dealer:","")
        safe1          = SUBSTR(safe1,1,INDEX(safe1,"Dealer:") - 1 )    

                .         



    EXPORT DELIMITER "|"
        SUBSTR(tlt.usrsent,1,1)
        SUBSTR(tlt.usrsent,2,4)
        string(YEAR(tlt.datesent),"9999") + string(MONTH(tlt.datesent),"99") + string(DAY(tlt.datesent),"99")
        SUBSTR(tlt.usrsent,6,10)
        tlt.lotno                            /*Lotno.                        */
        string(tlt.seqno,"999999")           /*Seqno.                        */
        tlt.recac                            /*Record Active.                */
        tlt.stat                             /*ʶҹ�                         */
        tlt.flag                             /*����Ţ����ͧ¹��/�Ţ��Ƕѧ */
        nv_title                             /*�ӹ�                          */ 
        nv_name                              /*���ͼ����һ�Сѹ���           */ 
        tlt.ins_addr1                        /*�����������һ�Сѹ���1       */
        tlt.ins_addr2                        /*�����������һ�Сѹ���2       */
        tlt.ins_addr3                        /*�����������һ�Сѹ���3       */
        tlt.ins_addr4                        /*�����������һ�Сѹ���4       */
        tlt.ins_addr5                        /*�����������һ�Сѹ���5       */
        tlt.eng_no                           /*�Ţ����ͧ¹��                */
        tlt.cha_no                           /*�Ţ��Ƕѧ                     */
        tlt.brand                            /*����������ö                  */
        tlt.model                            /*���ö                        */
        tlt.cc_weight                        /*��Ҵ����ͧ¹��               */
        tlt.colorcod                         /*��ö                          */
        tlt.lince1                           /*����¹ö1                    */
        tlt.lince2                           /*����¹ö2                    */
        tlt.lince3                           /*�ѧ��Ѵ��訴����¹           */
        tlt.subins                           /*�������º���ѷ��Сѹ���       */
        tlt.nor_coamt                        /*Normal Coverage amount        */
        tlt.nor_grprm                        /*Normal Gross premium          */
        tlt.nor_effdat                       
        tlt.nor_noti_tlt                     /*�Ţ�Ѻ��� TLT.              */
        tlt.nor_usr_tlt                      /*���ʼ���Ѻ��� TLT.          */
        tlt.nor_noti_ins                     /*�Ţ�Ѻ��� �ҡ�.��Сѹ���    */
        tlt.nor_usr_ins                      /*���ͼ���Ѻ��� �ͧ�.��Сѹ���*/
        tlt.comp_sub                         /*�������º���ѷ��Сѹ���          */
        tlt.comp_coamt                       /*Compl. Coverage amount           */
        tlt.comp_grprm                       /*Compl. Gross premium             */
        string(tlt.comp_effdat,"99/99/9999") /*Compl. Effective date            */
        tlt.comp_sck                         /*����ͧ���� (�ú.)               */
        tlt.comp_noti_tlt                    /*�Ţ�Ѻ��� TLT.                 */
        tlt.comp_usr_tlt                     /*���ʼ���Ѻ��� TLT.             */
        tlt.comp_noti_ins                    /*�Ţ�Ѻ��� �ҡ�.��Сѹ���       */
        tlt.comp_usr_ins                     /*���ͼ���Ѻ��� �ͧ�.��Сѹ���   */
        tlt.comp_pol                         /*�Ţ�������� �ú.                 */
        tlt.imp
        tlt.dri_name1                        /*���ͼ��Ѻ��� ����� 1            */
        tlt.dri_name2                        /*���ͼ��Ѻ��� ����� 2            */
        tlt.dri_no1                          /*�Ţ���㺢Ѻ��� ����� 1           */
        tlt.dri_no2                          /*�Ţ���㺢Ѻ��� ����� 2           */
        tlt.old_eng                          /*�����Ţ����ͧ¹�� (���)        */
        tlt.old_cha                          /*�����Ţ��Ƕѧö (���)           */

        tlt.rec_name                         /*����-ʡ������Ѻ�͡������Ѻ�Թ */
        tlt.rec_addr1                        /*������� ��÷Ѵ���1               */
        tlt.rec_addr2                        /*������� ��÷Ѵ���2               */
        tlt.rec_addr3                        /*������� ��÷Ѵ���3               */
        tlt.rec_addr4                        /*������� ��÷Ѵ���4               */
        tlt.rec_addr5                        /*������ɳ���                     */
        tlt.filler1                          /*Reserved1                        */
        tlt.filler2                          /*Reserved2                        */
        tlt.exp                              /*Normal End coverage date         */
        string(tlt.expodat,"99/99/9999")     /*Compulsory End coverage date     */
        nv_Dealer     
        nv_Caryear    
        nv_RenewalType
        tlt.safe2
        nv_ID     
        tlt.safe3
        nv_Branch     
        nv_Producer   
        nv_Agent      
        nv_Prepol     
        nv_Cover      
        nv_CLASS 
        tlt.note8     
        tlt.note9     
        tlt.dri_name1 
        tlt.note1     
        tlt.dri_lic1  
        tlt.dri_name2 
        tlt.note2     
        tlt.dri_lic2  
        tlt.note3     
        tlt.note4     
        tlt.note5     
        tlt.note6     
        tlt.note7 
        
        .

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
 
    Open Query br_tlt
        For each tlt Use-index  tlt01 Where
            tlt.trndat  >=  fi_trndatfr  And
            tlt.trndat  <=  fi_trndatto  And
            tlt.flag     =  "R"  AND
            tlt.genusr   =  "THANACHAT" NO-LOCK .
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

