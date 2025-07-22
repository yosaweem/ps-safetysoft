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
  Create  by : Ranu I. A64-0426  Date: 17/12/2021
 +++++++++++++++++++++++++++++++++++++++++++++++*/

 Def    var  nv_rectlt    as recid  init  0.
 Def    var  nv_recidtlt  as recid  init  0.
 DEFINE VAR  n_asdat      AS CHAR.
 DEFINE VAR  vAcProc_fil  AS CHAR.
 DEFINE VAR  n_asdat1     AS CHAR. /*A55-0365 */
 DEFINE VAR  vAcProc_fil1 AS CHAR. /*A55-0365 */
 DEF VAR nv_filemat AS CHAR FORMAT "x(100)".
 DEF VAR nv_fileerr AS CHAR FORMAT "x(100)" .

 
 DEFINE NEW SHARED TEMP-TABLE wnotify NO-UNDO
     FIELD n_no          AS CHAR FORMAT "X(3)"    INIT ""  
     FIELD policy        AS CHAR FORMAT "x(15)"   INIT "" 
     FIELD compno        AS CHAR FORMAT "x(13)"   INIT ""
     FIELD Account_no    AS CHAR FORMAT "X(20)"   INIT ""  
     FIELD stkno         AS CHAR FORMAT "X(13)"   INIT ""  
     FIELD prevpol       AS CHAR FORMAT "x(13)"   INIT ""
     FIELD name_insur    AS CHAR FORMAT "X(150)"  INIT "" 
     FIELD pol_addr1     as char format "x(50)"   init "" 
     FIELD pol_addr2     as char format "x(50)"   init "" 
     FIELD pol_addr3     as char format "x(50)"   init "" 
     FIELD pol_addr4     as char format "x(50)"   init "" 
     FIELD pol_addr5     as char format "x(50)"   init "" 
     FIELD icno          AS CHAR FORMAT "X(13)"   INIT ""  
     FIELD bdate         as char format "x(15)"   init "" 
     FIELD expbdate      as char format "x(15)"   init "" 
     FIELD brand         AS CHAR FORMAT "X(30)"   INIT ""  
     FIELD Brand_Model   AS CHAR FORMAT "X(30)"   INIT ""  
     FIELD yrmanu        AS CHAR FORMAT "X(5)"    INIT ""  
     FIELD CC            AS CHAR FORMAT "X(10)"   INIT ""  
     FIELD n_class       AS CHAR FORMAT "x(5)"    INIT ""
     FIELD vehuse        AS CHAR FORMAT "X(45)"   INIT ""  
     FIELD RegisNo       AS CHAR FORMAT "X(13)"   INIT ""  
     FIELD chassis       AS CHAR FORMAT "X(15)"   INIT ""  
     FIELD engine        AS CHAR FORMAT "X(15)"   INIT ""  
     FIELD SI            AS CHAR FORMAT "X(15)"   INIT ""  
     FIELD netprem       AS CHAR FORMAT "X(15)"   INIT ""  
     FIELD totalprem     AS CHAR FORMAT "X(15)"   INIT ""  
     FIELD comp_prm      AS CHAR FORMAT "X(10)"   INIT ""  
     FIELD comp_prmtotal AS CHAR FORMAT "x(10)"   INIT ""
     FIELD amount        AS CHAR FORMAT "X(15)"   INIT ""  
     FIELD comdat        AS CHAR FORMAT "X(15)"   INIT ""  
     FIELD expdat        AS CHAR FORMAT "X(15)"   INIT ""  
     FIELD ben_name      AS CHAR FORMAT "X(100)"  INIT ""  
     FIELD accsor        as CHAR FORMAT "X(120)"  INIT ""
     FIELD InsTyp        AS CHAR FORMAT "X(30)"   INIT ""  
     FIELD CMRName       AS CHAR FORMAT "X(50)"   INIT ""  
     FIELD DealerName    AS CHAR FORMAT "X(100)"  INIT ""  
     FIELD showroom      AS CHAR FORMAT "x(100)"  INIT "" 
     FIELD Remark        AS CHAR FORMAT "X(255)"  INIT ""  
     FIELD dealercode    AS CHAR FORMAT "x(10)"   INIT "" 
     FIELD vatcode       AS CHAR FORMAT "x(10)"   INIT "" 
     FIELD pol_title     as char format "x(15)"   init ""
     FIELD pol_fname     as char format "x(150)"  init ""
     FIELD pol_lname     as char format "x(50)"   init ""
     FIELD branch        AS CHAR FORMAT "X(20)"   INIT ""  
     FIELD producer      AS CHAR FORMAT "x(10)"   INIT "" 
     FIELD agent         AS CHAR FORMAT "x(10)"   INIT "" 
     FIELD staus         AS CHAR FORMAT "X(250)"  INIT "" .

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
IF (tlt.expotim = "") THEN ("NO") ELSE ("YES") tlt.note3 tlt.safe2 tlt.exp ~
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
&Scoped-Define ENABLED-OBJECTS fi_type bu_exit ra_status fi_trndatfr ~
fi_trndatto bu_ok cb_search bu_oksch br_tlt fi_search bu_update cb_report ~
fi_br fi_outfile bu_report bu_upyesno buimp bu_match bu_uprel fi_desc ~
RECT-332 RECT-338 RECT-339 RECT-341 RECT-381 RECT-382 RECT-342 RECT-387 
&Scoped-Define DISPLAYED-OBJECTS fi_type ra_status fi_trndatfr fi_trndatto ~
cb_search fi_search fi_name cb_report fi_br fi_outfile fi_match fi_desc 

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
     SIZE 10 BY 1
     FONT 6.

DEFINE BUTTON bu_match 
     LABEL "File Load" 
     SIZE 12 BY .95
     BGCOLOR 7 FONT 6.

DEFINE BUTTON bu_ok 
     LABEL "OK" 
     SIZE 9 BY 1
     FONT 6.

DEFINE BUTTON bu_oksch 
     LABEL "OK" 
     SIZE 5 BY .95
     FONT 6.

DEFINE BUTTON bu_report 
     LABEL "Report" 
     SIZE 8.17 BY .95
     FONT 6.

DEFINE BUTTON bu_update 
     LABEL "CANCEL" 
     SIZE 14 BY 1.05
     BGCOLOR 6 FONT 6.

DEFINE BUTTON bu_uprel 
     LABEL "Up Releas" 
     SIZE 13 BY .95
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
     SIZE 35.5 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_br AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 15.67 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_desc AS CHARACTER FORMAT "X(100)":U 
      VIEW-AS TEXT 
     SIZE 37.5 BY .95 TOOLTIP "�кآ�����"
     BGCOLOR 32 FGCOLOR 7 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_match AS CHARACTER FORMAT "X(256)":U INITIAL "����� Hold 㹡�� Match file" 
     VIEW-AS FILL-IN 
     SIZE 81 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 1 NO-UNDO.

DEFINE VARIABLE fi_name AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 39 BY .95
     BGCOLOR 15 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_outfile AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 61.5 BY .95
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

DEFINE VARIABLE fi_type AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 14.5 BY .95 TOOLTIP "�кآ�����"
     BGCOLOR 32 FGCOLOR 7 FONT 6 NO-UNDO.

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
     SIZE 132.5 BY 7.76
     BGCOLOR 34 .

DEFINE RECTANGLE RECT-338
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 58.5 BY 2.91
     BGCOLOR 29 .

DEFINE RECTANGLE RECT-339
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 71 BY 2.91
     BGCOLOR 19 .

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
     SIZE 7.5 BY 1.19
     BGCOLOR 2 FGCOLOR 2 .

DEFINE RECTANGLE RECT-382
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 132 BY 2.14
     BGCOLOR 33 .

DEFINE RECTANGLE RECT-387
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 130.17 BY 2.62
     BGCOLOR 32 .

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
      tlt.note3 COLUMN-LABEL "�Դ�ѭ��" FORMAT "x(20)":U WIDTH 8.17
      tlt.safe2 COLUMN-LABEL "�Ţ�Ѻ�� �ú" FORMAT "x(20)":U
            WIDTH 14.83
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
    WITH NO-ROW-MARKERS SEPARATORS SIZE 132.5 BY 14.05
         BGCOLOR 15 FGCOLOR 1 FONT 1 ROW-HEIGHT-CHARS .75.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     fi_type AT ROW 6.24 COL 57.5 COLON-ALIGNED NO-LABEL WIDGET-ID 6
     bu_exit AT ROW 1.57 COL 106.67
     ra_status AT ROW 7.29 COL 14.5 NO-LABEL
     fi_trndatfr AT ROW 1.67 COL 25.33 COLON-ALIGNED NO-LABEL
     fi_trndatto AT ROW 1.67 COL 61.5 COLON-ALIGNED NO-LABEL
     bu_ok AT ROW 1.57 COL 94.17
     cb_search AT ROW 3.19 COL 14 COLON-ALIGNED NO-LABEL
     bu_oksch AT ROW 4.33 COL 53.5
     br_tlt AT ROW 8.62 COL 1.33
     fi_search AT ROW 4.43 COL 3.67 NO-LABEL
     fi_name AT ROW 4.43 COL 61 COLON-ALIGNED NO-LABEL
     bu_update AT ROW 4.48 COL 102.83
     cb_report AT ROW 6.19 COL 16.33 COLON-ALIGNED NO-LABEL
     fi_br AT ROW 6.24 COL 72.33 COLON-ALIGNED NO-LABEL
     fi_outfile AT ROW 7.33 COL 57.5 NO-LABEL
     bu_report AT ROW 7.29 COL 119.33
     bu_upyesno AT ROW 4.48 COL 118
     fi_match AT ROW 23.38 COL 18 NO-LABEL
     buimp AT ROW 23.38 COL 99.67
     bu_match AT ROW 23.38 COL 105.5
     bu_uprel AT ROW 23.38 COL 118.5 WIDGET-ID 4
     fi_desc AT ROW 6.24 COL 88.5 COLON-ALIGNED NO-LABEL WIDGET-ID 8
     "CLICK FOR UPDATE DATA FLAG CANCEL":40 VIEW-AS TEXT
          SIZE 41.5 BY .95 AT ROW 3.19 COL 63.33
          BGCOLOR 19 FGCOLOR 6 FONT 6
     "REPORT BY :" VIEW-AS TEXT
          SIZE 14 BY .95 AT ROW 6.29 COL 3.33
          BGCOLOR 32 FGCOLOR 7 FONT 6
     "MATCH FILE :" VIEW-AS TEXT
          SIZE 15.5 BY .95 AT ROW 23.38 COL 2.5
          BGCOLOR 1 FGCOLOR 7 FONT 6
     " STATUS :" VIEW-AS TEXT
          SIZE 10.5 BY 1 AT ROW 7.29 COL 3.67
          BGCOLOR 32 FGCOLOR 7 FONT 6
     "To  :" VIEW-AS TEXT
          SIZE 7.5 BY 1 AT ROW 1.67 COL 55
          BGCOLOR 34 FGCOLOR 2 FONT 6
     " OUTPUT :" VIEW-AS TEXT
          SIZE 11.5 BY .95 AT ROW 7.33 COL 45.83
          BGCOLOR 32 FGCOLOR 7 FONT 6
     "�ѹ����駧ҹ  From :" VIEW-AS TEXT
          SIZE 19.83 BY 1 AT ROW 1.67 COL 6.5
          BGCOLOR 34 FGCOLOR 2 FONT 6
     "���Ң����� :" VIEW-AS TEXT
          SIZE 11.17 BY 1 AT ROW 3.19 COL 4.33
          BGCOLOR 29 FGCOLOR 0 FONT 6
     RECT-332 AT ROW 1.1 COL 1.33
     RECT-338 AT ROW 2.95 COL 2.5
     RECT-339 AT ROW 2.95 COL 61.67
     RECT-341 AT ROW 1.33 COL 104.83
     RECT-381 AT ROW 4.24 COL 52.17
     RECT-382 AT ROW 22.67 COL 1.5
     RECT-342 AT ROW 1.33 COL 92.67
     RECT-387 AT ROW 5.86 COL 2.5 WIDGET-ID 2
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
         TITLE              = "Query && Update [ISUZU]"
         HEIGHT             = 24.05
         WIDTH              = 133
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
ASSIGN 
       fi_desc:READ-ONLY IN FRAME fr_main        = TRUE.

/* SETTINGS FOR FILL-IN fi_match IN FRAME fr_main
   NO-ENABLE ALIGN-L                                                    */
/* SETTINGS FOR FILL-IN fi_name IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_outfile IN FRAME fr_main
   ALIGN-L                                                              */
/* SETTINGS FOR FILL-IN fi_search IN FRAME fr_main
   ALIGN-L                                                              */
ASSIGN 
       fi_type:READ-ONLY IN FRAME fr_main        = TRUE.

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
     _FldNameList[4]   > brstat.tlt.note3
"tlt.note3" "�Դ�ѭ��" ? "character" ? ? ? ? ? ? no ? no no "8.17" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   > brstat.tlt.safe2
"tlt.safe2" "�Ţ�Ѻ�� �ú" "x(20)" "character" ? ? ? ? ? ? no ? no no "14.83" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[6]   > brstat.tlt.exp
"tlt.exp" "�Ң�" "X(15)" "character" ? ? ? ? ? ? no ? no no "12.83" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[7]   > brstat.tlt.filler1
"tlt.filler1" "����������" "x(20)" "character" ? ? ? ? ? ? no ? no no "15" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[8]   > brstat.tlt.nor_noti_ins
"tlt.nor_noti_ins" "��������" "x(20)" "character" ? ? ? ? ? ? no ? no no "15" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[9]   > brstat.tlt.comp_pol
"tlt.comp_pol" "���� �ú." "x(20)" "character" ? ? ? ? ? ? no ? no no "15" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[10]   > brstat.tlt.ins_name
"tlt.ins_name" "���� - ʡ��" ? "character" ? ? ? ? ? ? no ? no no "25" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[11]   > brstat.tlt.cha_no
"tlt.cha_no" "�Ţ��Ƕѧ" ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[12]   > brstat.tlt.gendat
"tlt.gendat" "�ѹ��������ͧ" ? "date" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[13]   > brstat.tlt.expodat
"tlt.expodat" "�ѹ����������" "99/99/9999" "date" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[14]   > brstat.tlt.nor_coamt
"tlt.nor_coamt" "�ع��Сѹ" ? "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[15]   > brstat.tlt.nor_grprm
"tlt.nor_grprm" "�����ط��" ">>,>>>,>>9.99" "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[16]   > brstat.tlt.rec_addr4
"tlt.rec_addr4" "���� �ú." "x(10)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[17]   > brstat.tlt.comp_grprm
"tlt.comp_grprm" "���� ��. + �ú." ? "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[18]   > brstat.tlt.comp_sck
"tlt.comp_sck" "Sticker no." "x(15)" "character" ? ? ? ? ? ? no ? no no "14.17" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _Query            is NOT OPENED
*/  /* BROWSE br_tlt */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME c-wins
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c-wins c-wins
ON END-ERROR OF c-wins /* Query  Update [ISUZU] */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c-wins c-wins
ON WINDOW-CLOSE OF c-wins /* Query  Update [ISUZU] */
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
        Run  wgw\wgwqisuzu1(Input  nv_recidtlt).
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
            nv_fileerr = SUBSTRING(cvData,1,(LENGTH(fi_match) - 4)) + no_add + "_ERR.csv" . /*.csv*/
           
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
ON CHOOSE OF bu_match IN FRAME fr_main /* File Load */
DO:
    IF fi_match = "" THEN DO:
        MESSAGE "��س��ʪ������!!!"  VIEW-AS ALERT-BOX.
        Apply "Entry"  to fi_match.
        Return no-apply. 
    END.
    ELSE DO:
        FOR EACH  wnotify :                                                                          
            DELETE  wnotify.                                                                         
        END.                                                                                         
        INPUT FROM VALUE(fi_match).                                                               
        REPEAT:
        CREATE wnotify.
        IMPORT DELIMITER "|"       
            wnotify.n_no
            wnotify.policy
            wnotify.compno
            wnotify.Account_no
            wnotify.stkno
            wnotify.prevpol
            wnotify.pol_fname    
            wnotify.pol_addr1    
            wnotify.pol_addr2    
            wnotify.pol_addr3    
            wnotify.pol_addr4    
            wnotify.pol_addr5    
            wnotify.icno         
            wnotify.bdate        
            wnotify.expbdate     
            wnotify.brand        
            wnotify.Brand_Model  
            wnotify.yrmanu       
            wnotify.CC           
            wnotify.n_class
            wnotify.vehuse
            wnotify.RegisNo      
            wnotify.chassis      
            wnotify.engine       
            wnotify.SI           
            wnotify.netprem      
            wnotify.totalprem    
            wnotify.comp_prm     
            wnotify.comp_prmtotal
            wnotify.amount
            wnotify.comdat
            wnotify.expdat
            wnotify.ben_name
            wnotify.accsor
            wnotify.instyp
            wnotify.CMRName
            wnotify.DealerName
            wnotify.showroom
            wnotify.remark
            wnotify.dealercode
            wnotify.vatcode .

            IF INDEX(wnotify.n_no,"�駧ҹ")    <> 0 THEN  DELETE wnotify.
            ELSE IF INDEX(wnotify.n_no,"�ӴѺ") <> 0 THEN  DELETE wnotify.
            ELSE IF INDEX(wnotify.n_no,"���")   <> 0 THEN  DELETE wnotify.
            ELSE IF INDEX(wnotify.n_no,"No")    <> 0 THEN  DELETE wnotify.
            ELSE IF  wnotify.n_no               = "" THEN  DELETE wnotify.
        END.  /* repeat  */
        RUN pd_reportfileload.
        FIND FIRST wnotify WHERE  wnotify.staus <> "" NO-LOCK NO-ERROR.
        IF AVAIL wnotify THEN RUN pd_reportnotload .
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_ok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_ok c-wins
ON CHOOSE OF bu_ok IN FRAME fr_main /* OK */
DO:
   
    Open Query br_tlt 
        For each tlt Use-index  tlt01  Where
        tlt.trndat  >=   fi_trndatfr   And
        tlt.trndat  <=   fi_trndatto   AND 
        tlt.genusr   =  "ISUZU-N"        no-lock.  
            nv_rectlt =  recid(tlt).   /*A55-0184*/
            Apply "Entry"  to br_tlt.
            Return no-apply.                             
           
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
            tlt.genusr   =  "ISUZU-N"            And
            index(tlt.ins_name,fi_search) <> 0 no-lock.  
                ASSIGN nv_rectlt =  recid(tlt) .  
                Apply "Entry"  to br_tlt.
                Return no-apply.            
    END.
    ELSE If  cb_search  =  "�Ţ�Ѻ��(�ú)"  Then do:   /* policy */
        Open Query br_tlt 
            For each tlt Use-index  tlt01 Where
            tlt.trndat   >=  fi_trndatfr  And
            tlt.trndat   <=  fi_trndatto  And
            tlt.genusr    =  "ISUZU-N"      And
            trim(tlt.safe2)   =  TRIM(fi_search)  no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .  
                Apply "Entry"  to br_tlt.
                Return no-apply.        
    END.
    ELSE If  cb_search  =  "������������"  Then do:   /* policy */
        Open Query br_tlt 
            For each tlt Use-index  tlt01 Where
            tlt.trndat   >=  fi_trndatfr  And
            tlt.trndat   <=  fi_trndatto  And
            tlt.genusr    =  "ISUZU-N"      And
            tlt.nor_noti_ins = trim(fi_search)  no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .  
                Apply "Entry"  to br_tlt.
                Return no-apply.        
    END.
    ELSE If  cb_search  =  "��������ú."  Then do:   /* policy */
        Open Query br_tlt 
            For each tlt Use-index  tlt01 Where
            tlt.trndat   >=  fi_trndatfr  And
            tlt.trndat   <=  fi_trndatto  And
            tlt.genusr    =  "ISUZU-N"      And
            brstat.tlt.comp_pol = trim(fi_search) no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .  
                Apply "Entry"  to br_tlt.
                Return no-apply.        
    END.
    ELSE If  cb_search  =  "�����������"  Then do:   /* policy */
        Open Query br_tlt 
            For each tlt Use-index  tlt01 Where
            tlt.trndat   >=  fi_trndatfr  And
            tlt.trndat   <=  fi_trndatto  And
            tlt.genusr    =  "ISUZU-N"      And
            brstat.tlt.filler1 = trim(fi_search) no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .  
                Apply "Entry"  to br_tlt.
                Return no-apply.        
    END.
    ELSE If  cb_search  =  "����ᴧ"  Then do:    
        Open Query br_tlt 
            For each tlt Use-index  tlt01 Where
            tlt.trndat   >=  fi_trndatfr  And
            tlt.trndat   <=  fi_trndatto  And
            tlt.genusr    =  "ISUZU-N"      And
            tlt.flag      =  "N"          no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .  
                Apply "Entry"  to br_tlt.
                Return no-apply.        
    END.
    ELSE If  cb_search  =  "�������"  Then do:    
        Open Query br_tlt 
            For each tlt Use-index  tlt01 Where
            tlt.trndat   >=  fi_trndatfr  And
            tlt.trndat   <=  fi_trndatto  And
            tlt.genusr    =  "ISUZU-N"      And
            tlt.flag      =  "R"          no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .  
                Apply "Entry"  to br_tlt.
                Return no-apply.        
    END.
    ELSE If  cb_search  = "�Ţ��Ƕѧ"  Then do:  /* chassis no */
        Open Query br_tlt 
            For each tlt Use-index  tlt06 Where
            tlt.trndat >=  fi_trndatfr    And
            tlt.trndat <=  fi_trndatto    AND 
            tlt.genusr   =  "ISUZU-N"       And
            tlt.cha_no   = trim(fi_search) no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .  
                Apply "Entry"  to br_tlt.
                Return no-apply.            
    END.
    ELSE If  cb_search  =  "Dealer code"  Then do:   
        Open Query br_tlt 
            For each tlt Use-index  tlt01  Where
            tlt.trndat >=  fi_trndatfr     And
            tlt.trndat <=  fi_trndatto     And
            tlt.genusr   =  "ISUZU-N"        And
            brstat.tlt.dealer = trim(fi_search)  no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .  
                Apply "Entry"  to br_tlt.
                Return no-apply.            
    END.
    ELSE If  cb_search  =  "Producer code"  Then do:     /* confirm no...*/
        Open Query br_tlt 
            For each tlt Use-index  tlt01   Where
            tlt.trndat >=  fi_trndatfr      And
            tlt.trndat <=  fi_trndatto      And
            tlt.genusr   =  "ISUZU-N"         And
            brstat.tlt.comp_sub = trim(fi_search) no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .  
                Apply "Entry"  to br_tlt.
                Return no-apply.            
    END.
    ELSE If  cb_search  =  "Status_cancel"  Then do:    /* cancel */
        Open Query br_tlt 
            For each tlt Use-index  tlt01  Where
            tlt.trndat  >=  fi_trndatfr    And
            tlt.trndat  <=  fi_trndatto    And
            tlt.genusr   =  "ISUZU-N"        And
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
            tlt.genusr   =  "ISUZU-N"        And
            tlt.EXP      = fi_search       no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .  
                Apply "Entry"  to br_tlt.
                Return no-apply.                             
    END.
    ELSE If  cb_search  =  "�Ţʵ������"  Then do:    /* stk no */
       Open Query br_tlt 
           For each tlt Use-index  tlt01  Where
           tlt.trndat  >=  fi_trndatfr    And
           tlt.trndat  <=  fi_trndatto    And
           tlt.genusr   =  "ISUZU-N"        And
           tlt.comp_sck =  trim(fi_search)       no-lock.
               ASSIGN nv_rectlt =  recid(tlt) .  
               Apply "Entry"  to br_tlt.
               Return no-apply.                             
    END.
    Else  do:
        ASSIGN nv_rectlt =  recid(tlt) .  
        Apply "Entry"  to  fi_search.
        Return no-apply.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_report
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_report c-wins
ON CHOOSE OF bu_report IN FRAME fr_main /* Report */
DO:
    IF fi_outfile = "" THEN DO:
        MESSAGE "��س��ʪ������!!!"  VIEW-AS ALERT-BOX.
        Apply "Entry"  to fi_outfile.
        Return no-apply. 
    END.
    ELSE DO:
        RUN pd_reportfile.
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


&Scoped-define SELF-NAME bu_uprel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_uprel c-wins
ON CHOOSE OF bu_uprel IN FRAME fr_main /* Up Releas */
DO:
    IF fi_match = "" THEN DO:
        MESSAGE "��س��ʪ������!!!"  VIEW-AS ALERT-BOX.
        Apply "Entry"  to fi_match.
        Return no-apply. 
    END.
    ELSE DO:
        FOR EACH  wnotify :                                                                          
            DELETE  wnotify.                                                                         
        END.                                                                                         
        INPUT FROM VALUE(fi_match).                                                               
        REPEAT:
        CREATE wnotify.
        IMPORT DELIMITER "|"       
            wnotify.n_no
            wnotify.policy
            wnotify.compno
            wnotify.Account_no
            wnotify.stkno
            wnotify.prevpol
            wnotify.pol_fname    
            wnotify.pol_addr1    
            wnotify.pol_addr2    
            wnotify.pol_addr3    
            wnotify.pol_addr4    
            wnotify.pol_addr5    
            wnotify.icno         
            wnotify.bdate        
            wnotify.expbdate     
            wnotify.brand        
            wnotify.Brand_Model  
            wnotify.yrmanu       
            wnotify.CC           
            wnotify.n_class
            wnotify.vehuse
            wnotify.RegisNo      
            wnotify.chassis      
            wnotify.engine       
            wnotify.SI           
            wnotify.netprem      
            wnotify.totalprem    
            wnotify.comp_prm     
            wnotify.comp_prmtotal
            wnotify.amount
            wnotify.comdat
            wnotify.expdat
            wnotify.ben_name
            wnotify.accsor
            wnotify.instyp
            wnotify.CMRName
            wnotify.DealerName
            wnotify.showroom
            wnotify.remark
            wnotify.dealercode
            wnotify.vatcode .

            IF INDEX(wnotify.n_no,"�駧ҹ")    <> 0 THEN  DELETE wnotify.
            ELSE IF INDEX(wnotify.n_no,"�ӴѺ") <> 0 THEN  DELETE wnotify.
            ELSE IF INDEX(wnotify.n_no,"���")   <> 0 THEN  DELETE wnotify.
            ELSE IF INDEX(wnotify.n_no,"No")    <> 0 THEN  DELETE wnotify.
            ELSE IF  wnotify.n_no               = "" THEN  DELETE wnotify.
        END.  /* repeat  */
        RUN pd_uprelease.
        Message "Export data Complete"  View-as alert-box.
    END.
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
    ELSE IF n_asdat1 = "�Ң�" OR n_asdat1 = "�ѹ����駧ҹ" OR n_asdat1 = "�ѹ��������ͧ" OR  n_asdat1 = "Producer code" THEN DO: 
        ASSIGN fi_type = n_asdat1 .
        ENABLE fi_br WITH FRAM fr_main.
        APPLY "ENTRY" TO fi_br .
        DISP fi_type fi_br WITH FRAME fr_main .
    END.
    ELSE DO: 
        ASSIGN fi_type = ""
               fi_desc = ""  .
        HIDE fi_br .
        DISP fi_type WITH FRAM fr_main.
    END.

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

    ASSIGN fi_type = ""
           fi_desc = ""  .
    HIDE fi_br .
    DISP fi_type WITH FRAM fr_main.

    IF n_asdat1 = "" THEN DO:
        MESSAGE "��辺������ ��ä�" VIEW-AS ALERT-BOX WARNING.
        RETURN NO-APPLY.
    END.
    ELSE IF n_asdat1 = "�Ң�" OR n_asdat1 = "�ѹ����駧ҹ" OR n_asdat1 = "�ѹ��������ͧ" OR  n_asdat1 = "Producer code" THEN DO: 
        ASSIGN fi_type = n_asdat1 .
        ENABLE fi_br WITH FRAM fr_main.
        APPLY "ENTRY" TO fi_br .
        DISP fi_type fi_br WITH FRAME fr_main .
    END.
    ELSE DO: 
        ASSIGN fi_type = ""
               fi_desc = ""  .
        HIDE fi_br .
        DISP fi_type WITH FRAM fr_main.
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

  IF fi_br <> "" AND cb_report = "Producer code" THEN DO:
      FIND  sicsyac.xmm600 USE-INDEX xmm60001 WHERE xmm600.acno = TRIM(fi_br) NO-LOCK NO-ERROR .
      IF AVAIL xmm600 THEN ASSIGN fi_desc = xmm600.ntitle + " " + xmm600.firstname + " " + xmm600.lastname .
      ELSE ASSIGN fi_desc = "Not found Producer code on XMM600" .
  END.
  ELSE ASSIGN fi_desc = "" .

  DISP fi_desc WITH FRAME fr_main.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_br c-wins
ON VALUE-CHANGED OF fi_br IN FRAME fr_main
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
  gv_prgid = "wgwqisuzu".
  gv_prog  = "Query & Update  Detail  (ISUZU-N) ".
  RUN  WUT\WUTHEAD ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).

  SESSION:DATA-ENTRY-RETURN = YES.


  Rect-338:Move-to-top().  
  Rect-339:Move-to-top(). 
  RECT-381:Move-to-top().

  ASSIGN 
      fi_trndatfr = TODAY
      fi_trndatto = TODAY
      vAcProc_fil = vAcProc_fil + "�����١���"   + ","
                                + "�Ţ�Ѻ��(�ú)" + ","
                                + "������������" + ","
                                + "��������ú." + "," 
                                + "�Ţʵ������" + ","
                                + "�����������" + "," 
                                + "����ᴧ" + ","
                                + "�������" + "," 
                                + "�Ţ��Ƕѧ"      + ","
                                + "Dealer code" + ","
                                + "Producer code" + ","
                                + "Status_cancel"  + ","
                                + "�Ң�"  + "," 
        cb_search:LIST-ITEMS = vAcProc_fil
        cb_search = ENTRY(1,vAcProc_fil)
        vAcProc_fil1 = vAcProc_fil1 
                                  + "All"  + ","
                                  + "�ѹ����駧ҹ" + ","
                                  + "�ѹ��������ͧ" + ","
                                  + "Producer code" + ","
                                  + "New" + "," 
                                  + "Renew" + "," 
                                  + "�Ң�" + "," 
                                  + "�͡�ҹ����"     + "," 
                                  + "�ѧ����͡�ҹ" + "," 
                                  + "�ҹ�Դ�ѭ��" + ","
                                  + "¡��ԡ"  + ","
                                  + "�Դ suspect" + ","
        cb_report:LIST-ITEMS = vAcProc_fil1
        cb_report = ENTRY(1,vAcProc_fil1)
      ra_status = 4  
      fi_outfile = "D:\TEMP\Report_ISUZU-N" + 
                    STRING(YEAR(TODAY),"9999") + 
                    STRING(MONTH(TODAY),"99")  + 
                    STRING(DAY(TODAY),"99")    + 
                    SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) + 
                    SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2) + ".slk" .
  HIDE fi_br .
  Disp fi_trndatfr  fi_trndatto cb_search cb_report ra_status fi_outfile
      /*fi_polfr 
      fi_polto*/  with frame fr_main.

/*********************************************************************/ 
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
  DISPLAY fi_type ra_status fi_trndatfr fi_trndatto cb_search fi_search fi_name 
          cb_report fi_br fi_outfile fi_match fi_desc 
      WITH FRAME fr_main IN WINDOW c-wins.
  ENABLE fi_type bu_exit ra_status fi_trndatfr fi_trndatto bu_ok cb_search 
         bu_oksch br_tlt fi_search bu_update cb_report fi_br fi_outfile 
         bu_report bu_upyesno buimp bu_match bu_uprel fi_desc RECT-332 RECT-338 
         RECT-339 RECT-341 RECT-381 RECT-382 RECT-342 RECT-387 
      WITH FRAME fr_main IN WINDOW c-wins.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW c-wins.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_detailfileload c-wins 
PROCEDURE pd_detailfileload :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_cnt AS INT.
DEF VAR n_comdat70  AS CHAR FORMAT "x(15)"  init "".
DEF VAR n_expdat70  AS CHAR FORMAT "x(15)"  init "".
DEF VAR nv_custyp AS CHAR FORMAT "x(1)" .
DEF VAR nv_benname AS CHAR FORMAT "x(75)" INIT "" .
DEF VAR nv_cc  AS DECI.
DEF VAR nv_ton AS DECI .
DEF VAR nv_seat AS INT .

DO:
   FOR EACH wnotify WHERE wnotify.policy <> "" .
        RUN proc_cutpol.
        RUN proc_cutchar.
        FIND LAST brstat.tlt USE-INDEX tlt06 WHERE brstat.tlt.cha_no        = wnotify.chassis AND 
                                                   brstat.tlt.nor_noti_ins  = wnotify.policy  AND
                                                   brstat.tlt.genusr        = "ISUZU-N"       NO-LOCK NO-ERROR.  
        IF AVAIL brstat.tlt THEN DO: 
            IF index(brstat.tlt.releas,"YES") <> 0 THEN  ASSIGN wnotify.staus = "���������ա���͡�ҹ����" .
            ELSE IF brstat.tlt.note3 = "YES" THEN ASSIGN wnotify.staus = "�ҹ�Դ�ѭ��" .
            ELSE DO: 
              ASSIGN  n_comdat70 = ""         n_expdat70 = ""      nv_cc  = 0
                      nv_custyp  = ""         nv_benname = ""      nv_ton = 0
                      nv_seat    = 0
                      n_comdat70 = IF tlt.gendat  <> ? THEN STRING(tlt.gendat,"99/99/9999")  ELSE ""   /*�ѹ��������������ͧ */         
                      n_expdat70 = IF tlt.expodat <> ? THEN STRING(tlt.expodat,"99/99/9999") ELSE ""   /*�ѹ�������ش������ͧ*/ 
                      n_comdat70 = IF YEAR(date(n_comdat70)) > (year(today) + 1) THEN 
                                          SUBSTR(n_comdat70,1,6) + string((YEAR(tlt.gendat)  - 543),"9999") ELSE n_comdat70   /*�ѹ��������������ͧ     */         
                      n_expdat70 = IF YEAR(date(n_expdat70)) > (year(today) + 1) THEN 
                                          SUBSTR(n_expdat70,1,6) + string((YEAR(tlt.expodat) - 543),"9999") ELSE n_expdat70 .  /*�ѹ�������ش������ͧ   */ 
             
              IF TRIM(brstat.tlt.rec_name) <> " " THEN DO: 
                  IF  R-INDEX(TRIM(brstat.tlt.rec_name),"��.")             <> 0  OR  
                      R-INDEX(TRIM(brstat.tlt.rec_name),"�ӡѴ")           <> 0  OR  
                      R-INDEX(TRIM(brstat.tlt.rec_name),"(��Ҫ�)")         <> 0  OR  
                      R-INDEX(TRIM(brstat.tlt.rec_name),"INC.")            <> 0  OR 
                      R-INDEX(TRIM(brstat.tlt.rec_name),"CO.")             <> 0  OR 
                      R-INDEX(TRIM(brstat.tlt.rec_name),"LTD.")            <> 0  OR 
                      R-INDEX(TRIM(brstat.tlt.rec_name),"LIMITED")         <> 0  OR 
                      INDEX(TRIM(brstat.tlt.rec_name),"����ѷ")            <> 0  OR 
                      INDEX(TRIM(brstat.tlt.rec_name),"�.")                <> 0  OR 
                      INDEX(TRIM(brstat.tlt.rec_name),"���.")              <> 0  OR 
                      INDEX(TRIM(brstat.tlt.rec_name),"˨�.")              <> 0  OR 
                      INDEX(TRIM(brstat.tlt.rec_name),"�ʹ.")              <> 0  OR 
                      INDEX(TRIM(brstat.tlt.rec_name),"����ѷ")            <> 0  OR 
                      INDEX(TRIM(brstat.tlt.rec_name),"��ŹԸ�")           <> 0  OR 
                      INDEX(TRIM(brstat.tlt.rec_name),"��ҧ")              <> 0  OR 
                      INDEX(TRIM(brstat.tlt.rec_name),"��ҧ�����ǹ")      <> 0  OR 
                      INDEX(TRIM(brstat.tlt.rec_name),"��ҧ�����ǹ�ӡѴ") <> 0  OR
                      INDEX(TRIM(brstat.tlt.rec_name),"��ҧ�����ǹ�ӡ")   <> 0  OR  
                      INDEX(TRIM(brstat.tlt.rec_name),"���/����")          <> 0  THEN nv_custyp = "C".
                  ELSE nv_custyp = "P".   /*P = �ؤ�Ÿ����� C = �ԵԺؤ��*/
              END.
              ELSE nv_custyp = "P".
             
              IF SUBSTR(brstat.tlt.safe3,2,1) = "3"  OR SUBSTR(brstat.tlt.safe3,2,1) = "4" OR 
              SUBSTR(brstat.tlt.safe3,2,1)  = "5"    OR INDEX(brstat.tlt.safe3,"803") <> 0 OR 
              INDEX(brstat.tlt.safe3,"804") <> 0     OR INDEX(brstat.tlt.safe3,"805") <> 0 THEN 
                   ASSIGN nv_ton =  brstat.tlt.cc_weight.
              ELSE ASSIGN nv_cc  =  brstat.tlt.cc_weight .
             
              nv_cnt = nv_cnt + 1 .
              EXPORT DELIMITER "|" 
              /*1   */    wnotify.n_no                                                      
              /*2   */    "1"
              /*3   */    brstat.tlt.nor_noti_ins
              /*4   */    brstat.tlt.exp 
              /*5   */    brstat.tlt.comp_noti_ins
              /*6   */    brstat.tlt.comp_sub     
              /*7   */    brstat.tlt.dealer
              /*8   */    ""
              /*9   */    brstat.tlt.safe2
              /*10  */    brstat.tlt.nor_usr_ins
              /*11  */    "N"
              /*12  */    n_comdat70 
              /*13  */    n_expdat70 
              /*14  */    ""
              /*15  */    ""
              /*16  */    brstat.tlt.lotno
              /*17  */    ""
              /*18  */    ""
              /*19  */    ""
              /*20  */    ""
              /*21  */    ""
              /*22  */    ""
              /*23  */    ""
              /*24  */    brstat.tlt.filler1
              /*25  */    ""
              /*26  */    ""
              /*27  */    ""
              /*28  */    ""
              /*29  */    ""
              /*30  */    ""
              /*31  */    ""
              /*32  */    ""
              /*33  */    ""
              /*34  */    "�ѹ����駧ҹ :" + STRING(brstat.tlt.trndat,"99/99/9999") 
              /*35  */    brstat.tlt.filler2
              /*36  */    ""
              /*37  */    ""
              /*38  */    ""
              /*39  */    ""
              /*40  */    ""
              /*41  */    ""
              /*42  */    ""
              /*43  */    ""
              /*44  */    brstat.tlt.note1
              /*45  */    brstat.tlt.note2
              /*46  */    ""
              /*47  */    ""
              /*48  */    ""
              /*49  */    ""
              /*50  */    ""
              /*51  */    ""
              /*52  */    ""
              /*53  */    ""
              /*54  */    IF brstat.tlt.comp_pol = "" THEN "N" ELSE "Y"
              /*55  */    ""
              /*56  */    nv_custyp 
              /*57  */    "T"
              /*58  */    brstat.tlt.rec_name
              /*59  */    IF INDEX(brstat.tlt.ins_name," ") <> 0 THEN Substr(brstat.tlt.ins_name,1,R-INDEX(brstat.tlt.ins_name," ")) ELSE brstat.tlt.ins_name
              /*60  */    IF INDEX(brstat.tlt.ins_name," ") <> 0 THEN Substr(brstat.tlt.ins_name,R-INDEX(brstat.tlt.ins_name," ") + 1,length(brstat.tlt.ins_name)) ELSE "" 
              /*61  */    brstat.tlt.colorcod
              /*62  */    ""
              /*63  */    ""
              /*64  */    brstat.tlt.ins_addr1
              /*65  */    if (INDEX(brstat.tlt.ins_addr4,"��ا෾") <> 0  OR INDEX(brstat.tlt.ins_addr4,"���") <> 0 ) AND trim(brstat.tlt.ins_addr2) <> "" then "�ǧ" + trim(brstat.tlt.ins_addr2)  else "�Ӻ�" + brstat.tlt.ins_addr2   
              /*66  */    if (INDEX(brstat.tlt.ins_addr4,"��ا෾") <> 0  OR INDEX(brstat.tlt.ins_addr4,"���") <> 0 ) AND trim(brstat.tlt.ins_addr3) <> "" then "ࢵ"  + trim(brstat.tlt.ins_addr3)  else "�����" + brstat.tlt.ins_addr3  
              /*67  */    IF (INDEX(brstat.tlt.ins_addr4,"��ا෾") <> 0  OR INDEX(brstat.tlt.ins_addr4,"���") <> 0 ) AND trim(brstat.tlt.ins_addr4) <> "" THEN trim(brstat.tlt.ins_addr4)  ELSE "�ѧ��Ѵ" + brstat.tlt.ins_addr4
              /*68  */    brstat.tlt.ins_addr5  
              /*69  */    ""
              /*70  */    ""
              /*71  */    ""
              /*72  */    ""
              /*73  */    ""
              /*74  */    ""
              /*75  */    ""
              /*76  */    ""
              /*77  */    ""
              /*78  */    ""
              /*79  */    ""
              /*80  */    ""
              /*81  */    ""
              /*82  */    ""
              /*83  */    ""
              /*84  */    ""
              /*85  */    ""
              /*86  */    ""
              /*87  */    ""
              /*88  */    ""
              /*89  */    ""
              /*90  */    brstat.tlt.expousr 
              /*91  */    ""
              /*92  */    IF INDEX(brstat.tlt.safe1,"cash") <> 0 THEN "" ELSE brstat.tlt.safe1
              /*93  */    ""
              /*94  */    brstat.tlt.finint
              /*95  */    ""
              /*96  */    ""
              /*97  */    ""
              /*98  */    ""
              /*99  */    ""
              /*100 */    ""
              /*101 */    ""
              /*102 */    ""
              /*103 */    ""
              /*104 */    ""
              /*105 */    ""
              /*106 */    ""
              /*107 */    ""
              /*108 */    ""
              /*109 */    ""
              /*110 */    ""
              /*111 */    ""
              /*112 */    ""
              /*113 */    ""
              /*114 */    ""
              /*115 */    ""
              /*116 */    ""
              /*117 */    ""
              /*118 */    ""
              /*119 */    ""
              /*120 */    ""
              /*121 */    ""
              /*122 */    ""
              /*123 */    ""
              /*124 */    ""
              /*125 */    ""
              /*126 */    ""
              /*127 */    ""
              /*128 */    ""
              /*129 */    ""
              /*130 */    ""
              /*131 */    ""
              /*132 */    ""
              /*133 */    ""
              /*134 */    ""
              /*135 */    ""
              /*136 */    ""
              /*137 */    ""
              /*138 */    ""
              /*139 */    ""
              /*140 */    ""
              /*141 */    ""
              /*142 */    ""
              /*143 */    ""
              /*144 */    ""
              /*145 */    ""
              /*146 */    ""
              /*147 */    ""
              /*148 */    ""
              /*149 */    ""
              /*150 */    ""
              /*151 */    ""
              /*152 */    ""
              /*153 */    ""
              /*154 */    ""
              /*155 */    brstat.tlt.comp_usr_tlt
              /*156 */    brstat.tlt.stat
              /*157 */    ""
              /*158 */    ""
              /*159 */    brstat.tlt.safe3
              /*160 */    IF index(brstat.tlt.vehuse,"��ǹ�ؤ��") <> 0 THEN "1" ELSE brstat.tlt.vehuse
              /*161 */    brstat.tlt.brand 
              /*162 */    brstat.tlt.model 
              /*163 */    ""
              /*164 */    brstat.tlt.lince2
              /*165 */    brstat.tlt.cha_no
              /*166 */    brstat.tlt.eng_no
              /*167 */    IF INDEX(brstat.tlt.safe3,"320") <> 0 THEN 3 ELSE 7 
              /*168 */    nv_cc 
              /*169 */    nv_ton
              /*170 */    ""
              /*171 */    IF INDEX(brstat.tlt.model,"D-MAX") <> 0 THEN "PICKUP" ELSE IF INDEX(brstat.tlt.model,"MU-X") <> 0 THEN "WAGON" ELSE "" 
              /*172 */    IF brstat.tlt.flag = "N" THEN "Y" ELSE "N" 
              /*173 */    ""
              /*174 */    brstat.tlt.lince1
              /*175 */    ""
              /*176 */    ""
              /*177 */    ""
              /*178 */    ""
              /*179 */    ""
              /*180 */    ""
              /*181 */    ""
              /*182 */    ""
              /*183 */    ""
              /*184 */    ""
              /*185 */    ""
              /*186 */    ""
              /*187 */    ""
              /*188 */    ""
              /*189 */    ""
              /*190 */    ""
              /*191 */    ""
              /*192 */    ""
              /*193 */    ""
              /*194 */    ""
              /*195 */    ""
              /*196 */    ""
              /*197 */    ""
              /*198 */    ""
              /*199 */    ""
              /*200 */    ""
              /*201 */    ""
              /*202 */    ""
              /*203 */    ""
              /*204 */    brstat.tlt.nor_coamt
              /*205 */    ""
              /*206 */    ""
              /*207 */    ""
              /*208 */    ""
              /*209 */    ""
              /*210 */    ""
              /*211 */    ""
              /*212 */    ""
              /*213 */    ""
              /*214 */    ""
              /*215 */    ""
              /*216 */    ""
              /*217 */    ""
              /*218 */    ""
              /*219 */  /*  ""     ��.412 */
              /*220 */  /*  ""     ��.413 */
              /*221 */  /*  ""     ��.414 */
              /*222 */    ""
              /*223 */    ""
              /*224 */    ""
              /*225 */    ""
              /*226 */    ""
              /*227 */    ""
              /*228 */    ""
              /*229 */    ""
              /*230 */    ""
              /*231 */    ""
              /*232 */    ""
              /*233 */    ""
              /*234 */    ""
              /*235 */    ""
              /*236 */    brstat.tlt.nor_grprm 
              /*237 */    ""
              /*238 */    ""
              /*239 */    ""
              /*240 */    ""
              /*241 */    ""
              /*242 */    ""
              /*243 */    ""
              /*244 */    ""
              /*245 */    ""
              /*246 */    ""
              /*247 */    ""
              /*248 */    ""
              /*249 */    ""
              /*250 */    ""
              /*251 */    ""
              /*252 */    ""
              /*253 */    ""
              /*254 */    ""
              /*255 */    ""
              /*256 */    ""
              /*257 */    ""
              /*258 */    ""
              /*259*/     ""
              /*260*/     ""
              /*261*/     ""
              /*262*/     ""
              /*263*/     ""
              /*264*/     ""
              /*265*/     ""
              /*266*/     ""
              /*267*/     ""
              /*268*/     ""
              /*269*/     ""
              /*270*/     brstat.tlt.comp_pol     
              /*271*/     brstat.tlt.comp_sck
              /*272*/     brstat.tlt.ins_bus
              /*273*/     ""
              /*274*/     ""
              /*275*/     brstat.tlt.rec_addr4 
              /*276*/     ""
              /*277*/     ""
              /*278*/     ""
              /*279*/     ""  .
            END. /* releas <> yes */
        END.
    END. 
    MESSAGE "Match file Load Complete " VIEW-AS ALERT-BOX.
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
   /* DEF VAR n_bdate1    AS CHAR FORMAT "x(15)"  init "".
    DEF VAR n_bdate2    AS CHAR FORMAT "x(15)"  init "".
    DEF VAR n_length    AS INT  init 0.*/
    DEF VAR nv_cnt      AS INT  INIT 0.
   /* DEF VAR n_char      AS CHAR FORMAT "x(250)" init "".
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
    def var n_phone     as char format "x(20)" init "".*/

    If  substr(fi_outfile,length(fi_outfile) - 3,4) <>  ".CSV"  THEN 
        fi_outfile  =  Trim(fi_outfile) + ".CSV"  .
    ASSIGN nv_cnt =  0.
          /* nv_row  =  1.*/
    OUTPUT TO VALUE(fi_outfile).
    EXPORT DELIMITER "|" 
        "Export Data ISUZU-N:" 
        string(TODAY)   .
    EXPORT DELIMITER "|" 
        " �ӴѺ                  "  
        " �Ţ���������Ҥ��Ѥ��  "  
        " �Ţ�������� �.�.�.     "  
        " �Ţ�Ѻ�� �ú.        "  
        " �Ţʵԡ���� �.�.�     "  
        " �Ţ�����������        "  
        " ���� - ʡ�� �����һ�Сѹ���   "   
        " �������                "      
        " �Ӻ�/�ǧ              "      
        " �����/ࢵ              "      
        " �ѧ��Ѵ                "      
        " ������ɳ�             "      
        " �Ţ���ѵû�ЪҪ�/�Ţ�ԵԺؤ��"   
        " �ѹ/��͹/���Դ       "      
        " �ѹ������غѵ�         "      
        " ������                 "      
        " ���                   "      
        " ��                     "      
        " ��Ҵ����ͧ¹��        "      
        " ����ö                 "      
        " �ѡɳС����ö         "      
        " �Ţ����¹             "      
        " �Ţ��Ƕѧ              "      
        " �Ţ����ͧ¹��         "      
        " �ع��Сѹ              "      
        " ���»�Сѹ �.1 (�ط��)"      
        " ���� �.1 (�����������ҡ�)    "   
        " ���� �ú. (�ط��)     "      
        " ���� �ú. (��������ҡ�)      "   
        " ���� �.1+�ú.(��������ҡ�)   "   
        " �ѹ��������������ͧ    "      
        " �ѹ�������ش          "  
        " ����Ѻ�Ż���ª��       "  
        " ��¡���ػ�ó쵡�� ����Ҥ��ػ�ó�"
        " �١��ҫ��� /���������� " 
        " ���� (�����)"   
        " ���ʹ�������  "   
        " ������       "   
        " �����˵�      "   
        " Dealer Code   "   
        " Vat Code      " 
        " ����ö �ú.   "
        " producer      "
        " Agent         "
        " Cover         "
        " Branch        "
        " Campaign      "
        " garage        "
        " Suspect       "
        " �������ҹ     "
        " �ѹ����駧ҹ "
        " �ѹ����͡�ҹ  "
        " ʶҹЧҹ      "
        " Status        " SKIP .

    loop_tlt:
    For each tlt Use-index  tlt01 Where
                tlt.trndat   >=  fi_trndatfr   And
                tlt.trndat   <=  fi_trndatto   And
                tlt.genusr    =  "ISUZU-N"       no-lock. 
        IF cb_report = "New" THEN DO:                                              
            IF tlt.flag      =  "R"  THEN NEXT.
        END.
        ELSE IF   cb_report =  "Renew"  THEN DO:
            IF tlt.flag      =  "N"  THEN NEXT.
        END.
        ELSE IF cb_report = "�Ң�" THEN DO:
            IF fi_br = ""  THEN DO:
                MESSAGE "��س��к��Ң� !"  VIEW-AS ALERT-BOX.
                RETURN NO-APPLY.
            END.
            ELSE IF tlt.EXP    <> trim(fi_br)  THEN NEXT.
        END.
        ELSE IF cb_report = "�ѹ����駧ҹ" THEN DO:
            IF fi_br = ""  THEN DO:
                MESSAGE "��س��к��ѹ����駧ҹ !"  VIEW-AS ALERT-BOX.
                RETURN NO-APPLY.
            END.
            ELSE IF brstat.tlt.trndat <> DATE(fi_br)  THEN NEXT.
        END.
        ELSE IF cb_report = "�ѹ��������ͧ" THEN DO:
            IF fi_br = ""  THEN DO:
                MESSAGE "��س��к��ѹ��������ͧ !"  VIEW-AS ALERT-BOX.
                RETURN NO-APPLY.
            END.
            ELSE IF brstat.tlt.gendat  <> date(fi_br)  THEN NEXT.
        END.
        ELSE IF cb_report = "Producer code" THEN DO:
            IF fi_br = ""  THEN DO:
                MESSAGE "��س��к�Producer code !"  VIEW-AS ALERT-BOX.
                RETURN NO-APPLY.
            END.
            ELSE IF brstat.tlt.comp_sub   <> trim(fi_br)  THEN NEXT.
        END.
        ELSE IF cb_report = "�͡�ҹ����" THEN DO:
            IF INDEX(tlt.releas,"yes") = 0 THEN NEXT.
        END.
        ELSE IF cb_report = "�ѧ����͡�ҹ" THEN DO:
            IF INDEX(tlt.releas,"no") = 0 THEN NEXT.
        END.
        ELSE IF cb_report =   "¡��ԡ"   THEN DO:
            IF index(tlt.releas,"cancel") = 0 THEN NEXT.
        END.
        ELSE IF cb_report = "�Դ suspect"  THEN DO:
            IF brstat.tlt.expotim = ""  THEN NEXT.
        END.
        ELSE IF cb_report = "�ҹ�Դ�ѭ��"  THEN DO:
            IF brstat.tlt.note3 = "NO"  THEN NEXT.
        END.
        /*IF (fi_br <> "") THEN DO:
            IF fi_br <> tlt.EXP THEN NEXT loop_tlt.
        END.*/

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
            n_comdat70 = ""     n_expdat70 = ""   

            n_comdat70 = IF tlt.gendat <> ? THEN STRING(tlt.gendat,"99/99/9999") ELSE ""     /*�ѹ��������������ͧ     */         
            n_expdat70 = IF tlt.expodat <> ? THEN STRING(tlt.expodat,"99/99/9999") ELSE ""   /*�ѹ�������ش������ͧ   */ 
            n_comdat70 = IF YEAR(date(n_comdat70)) > (year(today) + 1) THEN SUBSTR(n_comdat70,1,6) + string((YEAR(tlt.gendat)  - 543),"9999") ELSE n_comdat70          
            n_expdat70 = IF YEAR(date(n_expdat70)) > (year(today) + 1) THEN SUBSTR(n_expdat70,1,6) + string((YEAR(tlt.expodat) - 543),"9999") ELSE n_expdat70 . 

         
        nv_cnt = nv_cnt + 1 .
        EXPORT DELIMITER "|"                                               
        nv_cnt
        brstat.tlt.nor_noti_ins
        brstat.tlt.comp_pol
        brstat.tlt.safe2                                   
        brstat.tlt.comp_sck                                
        brstat.tlt.filler1                                 
        trim(brstat.tlt.rec_name) + " " + trim(brstat.tlt.ins_name)          
        brstat.tlt.ins_addr1                               
        brstat.tlt.ins_addr2                               
        brstat.tlt.ins_addr3                               
        brstat.tlt.ins_addr4                               
        brstat.tlt.ins_addr5                               
        brstat.tlt.colorcod                                
        brstat.tlt.old_cha                                 
        brstat.tlt.old_eng                                 
        brstat.tlt.brand                                   
        brstat.tlt.model                                   
        brstat.tlt.lince2                                  
        brstat.tlt.cc_weight                               
        brstat.tlt.safe3                                   
        brstat.tlt.vehuse                                  
        brstat.tlt.lince1                                  
        brstat.tlt.cha_no                                  
        brstat.tlt.eng_no                                  
        brstat.tlt.nor_coamt                               
        brstat.tlt.nor_grprm
        brstat.tlt.comp_coamt                              
        brstat.tlt.rec_addr4                               
        brstat.tlt.comp_grprm                              
        brstat.tlt.recac                                   
        n_comdat70                                  
        n_expdat70                                  
        brstat.tlt.safe1                                   
        trim(trim(brstat.tlt.note1) + " " + trim(brstat.tlt.note2))                  
        brstat.tlt.expousr                                 
        brstat.tlt.nor_usr_ins                             
        brstat.tlt.lince3                                  
        brstat.tlt.subins                                  
        brstat.tlt.filler2                                 
        brstat.tlt.dealer                                  
        brstat.tlt.finint 
        brstat.tlt.ins_bus
        brstat.tlt.comp_sub                                
        brstat.tlt.comp_noti_ins                           
        brstat.tlt.comp_usr_tlt                            
        brstat.tlt.exp                                     
        brstat.tlt.lotno                                   
        brstat.tlt.stat                                    
        brstat.tlt.expotim                                 
        brstat.tlt.flag  
        brstat.tlt.trndat      
        brstat.tlt.dat_ins_noti
        IF brstat.tlt.note3 = "NO" THEN "���Դ�ѭ��" ELSE "�Դ�ѭ��"
        brstat.tlt.releas .
    END.
    OUTPUT   CLOSE.
    Message "Export data Complete"  View-as alert-box.
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
     /*1   */   "Risk no.                  "
     /*2   */   "ItemNo                    "
     /*3   */   "Policy No (�Ţ�����������Ҥ��Ѥ��)"  
     /*4   */   "Branch (�Ң�)             "         
     /*5   */   "Agent Code (���ʵ��᷹)   "         
     /*6   */   "Producer Code             "         
     /*7   */   "Dealer Code (���ʴ������) "         
     /*8   */   "Finance Code (�����ṹ��)"         
     /*9   */   "Notification Number (�Ţ����Ѻ��) "  
     /*10  */   "Notification Name (���ͼ����)     "  
     /*11  */   "Short Rate                "         
     /*12  */   "Effective Date (�ѹ������������������ͧ)"  
     /*13  */   "Expiry Date (�ѹ�������ش����������ͧ) "  
     /*14  */   "Agree Date                "             
     /*15  */   "First Date                "             
     /*16  */   "������ࡨ               "
     /*17  */   "Campaign Code (������໭)"
     /*18  */   "Campaign Text             "
     /*19  */   "Spec Con                  "
     /*20  */   "Product Type              "
     /*21  */   "Promotion Code            "
     /*22  */   "Renew Count               "
     /*23  */   "Previous Policy (�Ţ�ա��������Ҥ��Ѥ�����)"
     /*24  */   "Policy Text 1   "
     /*25  */   "Policy Text 2   "
     /*26  */   "Policy Text 3   "
     /*27  */   "Policy Text 4   "
     /*28  */   "Policy Text 5   "
     /*29  */   "Policy Text 6   "
     /*30  */   "Policy Text 7   "
     /*31  */   "Policy Text 8   "
     /*32  */   "Policy Text 9   "
     /*33  */   "Policy Text 10  "
     /*34  */   "Memo Text 1     "
     /*35  */   "Memo Text 2     "
     /*36  */   "Memo Text 3     "
     /*37  */   "Memo Text 4     "
     /*38  */   "Memo Text 5     "
     /*39  */   "Memo Text 6     "
     /*40  */   "Memo Text 7     "
     /*41  */   "Memo Text 8     "
     /*42  */   "Memo Text 9     "
     /*43  */   "Memo Text 10    "
     /*44  */   "Accessory Text 1"
     /*45  */   "Accessory Text 2"
     /*46  */   "Accessory Text 3"
     /*47  */   "Accessory Text 4"
     /*48  */   "Accessory Text 5"
     /*49  */   "Accessory Text 6"
     /*50  */   "Accessory Text 7"
     /*51  */   "Accessory Text 8"
     /*52  */   "Accessory Text 9"
     /*53  */   "Accessory Text 10"
     /*54  */   "����������ͤǺ (Y/N)"
     /*55  */   "Insured Code         "
     /*56  */   "�������ؤ��          "
     /*57  */   "���ҷ�������ҧ Cilent Code"
     /*58  */   "�ӹ�˹�� "
     /*59  */   "����     "
     /*60  */   "���ʡ��  "
     /*61  */   "�Ţ���ѵû�ЪҪ� / �Ţ���ԵԺؤ��"
     /*62  */   "�ӴѺ����Ң�       "
     /*63  */   "�Ҫվ              "
     /*64  */   "��������÷Ѵ��� 1 "
     /*65  */   "��������÷Ѵ��� 2 "
     /*66  */   "��������÷Ѵ��� 3 "
     /*67  */   "��������÷Ѵ��� 4 "
     /*68  */   "������ɳ���       "
     /*69  */   "province code      "
     /*70  */   "district code      "
     /*71  */   "sub district code  "
     /*72  */   "AE Code            "
     /*73  */   "Japanese Team      "
     /*74  */   "TS Code            "
     /*75  */   "Gender (Male/Female/Other)"
     /*76  */   "Telephone 1  "
     /*77  */   "Telephone 2  "
     /*78  */   "E-Mail 1     "
     /*79  */   "E-Mail 2     "
     /*80  */   "E-Mail 3     "
     /*81  */   "E-Mail 4     "
     /*82  */   "E-Mail 5     "
     /*83  */   "E-Mail 6     "
     /*84  */   "E-Mail 7     "
     /*85  */   "E-Mail 8     "
     /*86  */   "E-Mail 9     "
     /*87  */   "E-Mail 10    "
     /*88  */   "Fax          "
     /*89  */   "Line ID      "
     /*90  */   "CareOf1      "
     /*91  */   "CareOf2      "
     /*92  */   "Benefit Name "
     /*93  */   "Payer Code   "
     /*94  */   "VAT Code     "
     /*95  */   "Client Code  "
     /*96  */   "�������ؤ��  "
     /*97  */   "�ӹ�˹��     "
     /*98  */   "����         "
     /*99  */   "���ʡ��      "
     /*100 */   "�Ţ���ѵû�ЪҪ� / �Ţ���ԵԺؤ��"
     /*101 */   "�ӴѺ����Ң�       "   
     /*102 */   "��������÷Ѵ��� 1 "   
     /*103 */   "��������÷Ѵ��� 2 "   
     /*104 */   "��������÷Ѵ��� 3 "   
     /*105 */   "��������÷Ѵ��� 4 "   
     /*106 */   "������ɳ���       "   
     /*107 */   "province code      "   
     /*108 */   "district code      "   
     /*109 */   "sub district code  "   
     /*110 */   "���¡�͹�����ҡ�  "   
     /*111 */   "�ҡ�               "   
     /*112 */   "����               "   
     /*113 */   "����Ԫ��� 1       "   
     /*114 */   "����Ԫ��� 2 (co-broker) "
     /*115 */   "Client Code  " 
     /*116 */   "�������ؤ��  " 
     /*117 */   "�ӹ�˹��     " 
     /*118 */   "����         " 
     /*119 */   "���ʡ��      " 
     /*120 */   "�Ţ���ѵû�ЪҪ� / �Ţ���ԵԺؤ��"
     /*121 */   "�ӴѺ����Ң�      "
     /*122 */   "��������÷Ѵ��� 1"
     /*123 */   "��������÷Ѵ��� 2"
     /*124 */   "��������÷Ѵ��� 3"
     /*125 */   "��������÷Ѵ��� 4"
     /*126 */   "������ɳ���      "
     /*127 */   "province code     "
     /*128 */   "district code     "
     /*129 */   "sub district code "
     /*130 */   "���¡�͹�����ҡ� "
     /*131 */   "�ҡ�              "
     /*132 */   "����              "
     /*133 */   "����Ԫ��� 1      "
     /*134 */   "����Ԫ��� 2 (co-broker)"
     /*135 */   "Client Code  "
     /*136 */   "�������ؤ��  "
     /*137 */   "�ӹ�˹��     "
     /*138 */   "����         "
     /*139 */   "���ʡ��      "
     /*140 */   "�Ţ���ѵû�ЪҪ�/�Ţ���ԵԺؤ��"
     /*141 */   "�ӴѺ����Ң�      "
     /*142 */   "��������÷Ѵ��� 1"
     /*143 */   "��������÷Ѵ��� 2"
     /*144 */   "��������÷Ѵ��� 3"
     /*145 */   "��������÷Ѵ��� 4"
     /*146 */   "������ɳ���      "
     /*147 */   "province code     "
     /*148 */   "district code     "
     /*149 */   "sub district code "
     /*150 */   "���¡�͹�����ҡ� "
     /*151 */   "�ҡ�              "
     /*152 */   "����              "
     /*153 */   "����Ԫ��� 1      "
     /*154 */   "����Ԫ��� 2 (co-broker)"
     /*155 */   "Cover Type (����������������ͧ)"
     /*156 */   "Garage (��������ë��� �������/������ҧ)"
     /*157 */   "Spacial Equipment Flag (A/Blank)"  
     /*158 */   "Inspection    "  
     /*159 */   "����ö�Ҥ��Ѥ�� (110/120/320)" 
     /*160 */   "�ѡɳС����ö "                
     /*161 */   "������ö      "         
     /*162 */   "�������ö    "         
     /*163 */   "�����������ö"         
     /*164 */   "�����ö      "         
     /*165 */   "�����Ţ��Ƕѧ "         
     /*166 */   "�����Ţ����ͧ"         
     /*167 */   "�ӹǹ����� (������Ѻ���)   "  
     /*168 */   "����ҵá�к͡�ٺ (CC)"  
     /*169 */   "���˹ѡ (�ѹ)        "  
     /*170 */   "Kilowatt             "  
     /*171 */   "����Ẻ��Ƕѧ        "  
     /*172 */   "����ᴧ (Y/N)        "  
     /*173 */   "�շ�訴����¹       "  
     /*174 */   "�Ţ����¹ö         "  
     /*175 */   "�ѧ��Ѵ��訴����¹  "  
     /*176 */   "Group Car (�����ö)  "  
     /*177 */   "Color (��)           "  
     /*178 */   "Fule (������ԧ)    "  
     /*179 */   "Driver Number        "  
     /*180 */   "�ӹ�˹��             "  
     /*181 */   "����                 "  
     /*182 */   "���ʡ��              "  
     /*183 */   "�Ţ���ѵû�ЪҪ�    "  
     /*184 */   "��                  "  
     /*185 */   "�ѹ�Դ              "  
     /*186 */   "�����Ҫվ            "  
     /*187 */   "�Ţ����͹حҵ�Ѻ��� "  
     /*188 */   "�ӹ�˹��             "  
     /*189 */   "����                 "  
     /*190 */   "���ʡ��              "  
     /*191 */   "�Ţ���ѵû�ЪҪ�    "  
     /*192 */   "��                  "  
     /*193 */   "�ѹ�Դ              "  
     /*194 */   "�����Ҫվ            "  
     /*195 */   "�Ţ����͹حҵ�Ѻ��� "  
     /*196 */   "Base Premium Plus    "  
     /*197 */   "Sum Insured Plus     "  
     /*198 */   "RS10 Amount          "  
     /*199 */   "TPBI / person        "  
     /*200 */   "TPBI / occurrence    "  
     /*201 */   "TPPD                 "  
     /*202 */   "Deduct / OD           "  
     /*203 */   "Deduct / PD           "  
     /*204 */   "ǧ�Թ�ع��Сѹ       "  
     /*205 */   "PA1.1 / driver        "  
     /*206 */   "PA1.1 no.of passenger "  
     /*207 */   "PA1.1 / passenger     "  
     /*208 */   "PA1.2 / driver        "  
     /*209 */   "PA1.2 no.of passenger "  
     /*210 */   "PA1.2 / passenger     "  
     /*211 */   "PA2                   "  
     /*212 */   "PA3                   "  
     /*213 */   "Base Premium          "  
     /*214 */   "Unname                "  
     /*215 */   "Name                  "  
     /*216 */   "TPBI Amount           "  
     /*217 */   "TPPD Amount           "  
     /*218 */   "RY41 Amount           "
     /*219 */  /* "RY412 Amount          "  */
     /*220 */  /* "RY413 Amount          "  */
     /*221 */  /* "RY414 Amount          "  */
     /*222 */   "RY42 Amount           "  
     /*223 */   "RY43 Amount           "  
     /*224 */   "Fleet%                "  
     /*225 */   "NCB%                  "  
     /*226 */   "Load Claim%           "  
     /*227 */   "Other Disc.%          "  
     /*228 */   "CCTV%                 "  
     /*229 */   "Walkin Disc.%         "  
     /*230 */   "Fleet Amount          "  
     /*231 */   "NCB Amount            "  
     /*232 */   "Load Claim Amount     "  
     /*233 */   "Other Disc. Amount    "  
     /*234 */   "CCTV Amount           "  
     /*235 */   "Walk in Disc. Amount  "  
     /*236 */   "�����ط��            "  
     /*237 */   "Stamp Duty            "  
     /*238 */   "VAT                   "  
     /*239 */   "Commission %          "  
     /*240 */   "Commission Amount     "  
     /*241 */   "Agent Code co-broker (���ʵ��᷹) "
     /*242 */   "Commission % co-broker     "   
     /*243 */   "Commission Amount co-broker"   
     /*244 */   "Package (Attach Coverage)  "   
     /*245 */   "Dangerous Object 1 "   
     /*246 */   "Dangerous Object 2 "   
     /*247 */   "Sum Insured        "   
     /*248 */   "Rate%              "   
     /*249 */   "Fleet%             "   
     /*250 */   "NCB%               "   
     /*251 */   "Discount%          "   
     /*252 */   "Walkin Disc.%      "   
     /*253 */   "Premium Attach Coverage"   
     /*254 */   "Discount Fleet     "   
     /*255 */   "Discount NCB       "   
     /*256 */   "Other Discount     "   
     /*257 */   "Walk in Disc. Amount   "   
     /*258 */   "Net Premium        "   
     /*259*/    "Stamp Duty         "   
     /*260*/    "VAT                "   
     /*261*/    "Commission Amount  "   
     /*262*/    "Commission Amount co-broker"   
     /*263*/    "Claim Text         "   
     /*264*/    "Claim Amount       "   
     /*265*/    "Claim Count Fault  "   
     /*266*/    "Claim Count Fault Amount   "   
     /*267*/    "Claim Count Good   "   
     /*268*/    "Claim Count Good Amount    "   
     /*269*/    "Loss Ratio % (Not TP)      "   
     /*270*/    "Compulsory Policy Number (�Ţ���������� �ú.)"
     /*271*/    "Barcode No.                        "
     /*272*/    "Compulsory Class (���� �ú.)       "
     /*273*/    "Compulsory Walk In Discount %      "
     /*274*/    "Compulsory Walk In Discount Amount "
     /*275*/    "�����ط�� �.�.�. �ó� ����������ͤǺ "
     /*276*/    "Stamp Duty        "
     /*277*/    "VAT               "
     /*278*/    "Commission %      "
     /*279*/    "Commission Amount ".
    
    RUN pd_detailfileload .
    OUTPUT CLOSE.  
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_reportfileload-01 c-wins 
PROCEDURE pd_reportfileload-01 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*DEF VAR nv_cnt AS INT.
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
                                                   brstat.tlt.genusr    =  "ISUZU-N"      NO-LOCK NO-ERROR.  
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
END.*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_reportnotload c-wins 
PROCEDURE pd_reportnotload :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO:

  OUTPUT TO VALUE(nv_fileerr).
  EXPORT DELIMITER "|" 
      " �ӴѺ                  "  
      " �Ţ���������Ҥ��Ѥ��  "  
      " �Ţ�������� �.�.�.     "  
      " �Ţ�Ѻ�� �ú.        "  
      " �Ţʵԡ���� �.�.�     "  
      " �Ţ�����������        "  
      " ���� - ʡ�� �����һ�Сѹ���   "   
      " �������                "      
      " �Ӻ�/�ǧ              "      
      " �����/ࢵ              "      
      " �ѧ��Ѵ                "      
      " ������ɳ�             "      
      " �Ţ���ѵû�ЪҪ�/�Ţ�ԵԺؤ��"   
      " �ѹ/��͹/���Դ       "      
      " �ѹ������غѵ�         "      
      " ������                 "      
      " ���                   "      
      " ��                     "      
      " ��Ҵ����ͧ¹��        "      
      " ����ö                 "      
      " �ѡɳС����ö         "      
      " �Ţ����¹             "      
      " �Ţ��Ƕѧ              "      
      " �Ţ����ͧ¹��         "      
      " �ع��Сѹ              "      
      " ���»�Сѹ �.1 (�ط��)"      
      " ���� �.1 (�����������ҡ�)    "   
      " ���� �ú. (�ط��)     "      
      " ���� �ú. (��������ҡ�)      "   
      " ���� �.1+�ú.(��������ҡ�)   "   
      " �ѹ��������������ͧ    "      
      " �ѹ�������ش          "  
      " ����Ѻ�Ż���ª��       "  
      " ��¡���ػ�ó쵡�� ����Ҥ��ػ�ó�"
      " �١��ҫ��� /���������� " 
      " ���� (�����)"   
      " ���ʹ�������  "   
      " ������       "   
      " �����˵�      "   
      " Dealer Code   "   
      " Vat Code      "
      " Status        " SKIP .
  FOR EACH wnotify WHERE wnotify.staus <> "" NO-LOCK.
      EXPORT DELIMITER "|"       
            wnotify.n_no
            wnotify.policy
            wnotify.compno
            wnotify.Account_no
            wnotify.stkno
            wnotify.prevpol
            wnotify.pol_fname    
            wnotify.pol_addr1    
            wnotify.pol_addr2    
            wnotify.pol_addr3    
            wnotify.pol_addr4    
            wnotify.pol_addr5    
            wnotify.icno         
            wnotify.bdate        
            wnotify.expbdate     
            wnotify.brand        
            wnotify.Brand_Model  
            wnotify.yrmanu       
            wnotify.CC           
            wnotify.n_class
            wnotify.vehuse
            wnotify.RegisNo      
            wnotify.chassis      
            wnotify.engine       
            wnotify.SI           
            wnotify.netprem      
            wnotify.totalprem    
            wnotify.comp_prm     
            wnotify.comp_prmtotal
            wnotify.amount
            wnotify.comdat
            wnotify.expdat
            wnotify.ben_name
            wnotify.accsor
            wnotify.instyp
            wnotify.CMRName
            wnotify.DealerName
            wnotify.showroom
            wnotify.remark
            wnotify.dealercode
            wnotify.vatcode 
            wnotify.staus .
  END.
  OUTPUT CLOSE.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_uprelease c-wins 
PROCEDURE pd_uprelease :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_cnt AS INT.
DEF VAR n_comdat70  AS CHAR FORMAT "x(15)"  init "".
DEF VAR n_expdat70  AS CHAR FORMAT "x(15)"  init "".
DO:
    FOR EACH wnotify WHERE wnotify.policy <> "" .
       RUN proc_cutpol.
       RUN proc_cutchar.
       FIND LAST brstat.tlt USE-INDEX tlt06 WHERE brstat.tlt.cha_no        = wnotify.chassis AND 
                                                  brstat.tlt.nor_noti_ins  = wnotify.policy  AND
                                                  brstat.tlt.genusr        = "ISUZU-N"       NO-ERROR.  
       IF AVAIL brstat.tlt THEN DO: 
           ASSIGN  n_comdat70 = ""         n_expdat70 = ""    
                   n_comdat70 = IF tlt.gendat <> ? THEN STRING(tlt.gendat,"99/99/9999") ELSE ""     /*�ѹ��������������ͧ     */         
                   n_expdat70 = IF tlt.expodat <> ? THEN STRING(tlt.expodat,"99/99/9999") ELSE ""   /*�ѹ�������ش������ͧ   */ 
                   n_comdat70 = IF YEAR(date(n_comdat70)) > (year(today) + 1) THEN 
                                       SUBSTR(n_comdat70,1,6) + string((YEAR(tlt.gendat)  - 543),"9999") ELSE n_comdat70   /*�ѹ��������������ͧ     */         
                   n_expdat70 = IF YEAR(date(n_expdat70)) > (year(today) + 1) THEN 
                                       SUBSTR(n_expdat70,1,6) + string((YEAR(tlt.expodat) - 543),"9999") ELSE n_expdat70 .  /*�ѹ�������ش������ͧ   */ 
            
           FIND FIRST sicuw.uwm301 Use-index uwm30121 Where sicuw.uwm301.cha_no = trim(wnotify.chassis)  AND 
                      sicuw.uwm301.policy = trim(wnotify.policy) No-lock no-error no-wait.
              If avail sicuw.uwm301 Then DO:
                    Find LAST sicuw.uwm100 Use-index uwm10001       Where
                        sicuw.uwm100.policy = sicuw.uwm301.policy   and
                        sicuw.uwm100.rencnt = sicuw.uwm301.rencnt   and                         
                        /*sicuw.uwm100.endcnt = sicuw.uwm301.endcnt   AND */ /*A64-0044*/
                        sicuw.uwm100.poltyp = "V70"  No-lock no-error no-wait.
                    If avail sicuw.uwm100 Then DO:
                        IF DATE(sicuw.uwm100.comdat) = date(n_comdat70) AND 
                           DATE(sicuw.uwm100.expdat) = DATE(n_expdat70) THEN DO:
                           ASSIGN brstat.tlt.releas = "YES"
                                  brstat.tlt.dat_ins_noti = sicuw.uwm100.trndat  
                                  wnotify.staus = "Complete" .
                        END.
                        ELSE DO:
                            ASSIGN wnotify.staus = "��Ǩ�ͺ�ѹ��������ͧ����ѹ���������آͧ��� �Ѻ�к��������� " .
                        END.
                    END.
                    ELSE DO:
                         ASSIGN wnotify.staus = "��辺�����ŷ�� uwm100 " .
                    END.
              END.
              ELSE DO:
                  ASSIGN wnotify.staus = "��辺�����ŷ��������� " .
              END.
       END.
       ELSE ASSIGN wnotify.staus = "��辺������㹶ѧ�ѡ" .
    END.

    If  substr(fi_match,length(fi_match) - 3,4) <> ".CSV"  THEN fi_match  =  Trim(fi_match) + "_rel.CSV"  .
    ELSE fi_match  =  substr(fi_match,1,length(fi_match) - 4) + "_rel.CSV" .
    ASSIGN nv_cnt =  0.
          /* nv_row  =  1.*/
    OUTPUT TO VALUE(fi_match).
    EXPORT DELIMITER "|" 
        "Export Data ISUZU-N:" string(TODAY)   .
    EXPORT DELIMITER "|" 
        " �ӴѺ                             "
        " �Ţ���������Ҥ��Ѥ��             "
        " �Ţ�������� �.�.�.                "
        " �Ţ�Ѻ�� �ú.                   "
        " �Ţʵԡ���� �.�.�                "
        " �Ţ�����������                   "
        " ���� - ʡ�� �����һ�Сѹ���       "
        " �������                           "
        " �Ӻ�/�ǧ                         "
        " �����/ࢵ                         "
        " �ѧ��Ѵ                           "
        " ������ɳ�                        "
        " �Ţ���ѵû�ЪҪ�/�Ţ�ԵԺؤ��    "
        " �ѹ/��͹/���Դ                  "
        " �ѹ������غѵ�                    "
        " ������                            "
        " ���                              "
        " ��                                "
        " ��Ҵ����ͧ¹��                   "
        " ����ö                            "
        " �ѡɳС����ö                    "
        " �Ţ����¹                        "
        " �Ţ��Ƕѧ                         "
        " �Ţ����ͧ¹��                    "
        " �ع��Сѹ                         "
        " ���»�Сѹ �.1 (�ط��)           "
        " ���� �.1 (�����������ҡ�)        "
        " ���� �ú. (�ط��)                "
        " ���� �ú. (��������ҡ�)          "
        " ���� �.1+�ú.(��������ҡ�)       "
        " �ѹ��������������ͧ               "
        " �ѹ�������ش                     "
        " ����Ѻ�Ż���ª��                  "
        " ��¡���ػ�ó쵡�� ����Ҥ��ػ�ó�"
        " �١��ҫ��� /���������� " 
        " ���� (�����)"   
        " ���ʹ�������  "   
        " ������       "   
        " �����˵�      "   
        " Dealer Code   "   
        " Vat Code      " 
       /* " ����ö �ú.   "
        " producer      "
        " Agent         "
        " Cover         "
        " Branch        "
        " Campaign      "
        " garage        "
        " Suspect       "
        " �������ҹ     "
        " �ѹ����駧ҹ "
        " �ѹ����͡�ҹ  "*/
        " Status        " SKIP .

    FOR EACH wnotify WHERE wnotify.policy <> "" NO-LOCK.
        EXPORT DELIMITER "|"        
        wnotify.n_no
        wnotify.policy
        wnotify.compno
        wnotify.Account_no
        wnotify.stkno
        wnotify.prevpol
        wnotify.pol_fname    
        wnotify.pol_addr1    
        wnotify.pol_addr2    
        wnotify.pol_addr3    
        wnotify.pol_addr4    
        wnotify.pol_addr5    
        wnotify.icno         
        wnotify.bdate        
        wnotify.expbdate     
        wnotify.brand        
        wnotify.Brand_Model  
        wnotify.yrmanu       
        wnotify.CC           
        wnotify.n_class
        wnotify.vehuse
        wnotify.RegisNo      
        wnotify.chassis      
        wnotify.engine       
        wnotify.SI           
        wnotify.netprem      
        wnotify.totalprem    
        wnotify.comp_prm     
        wnotify.comp_prmtotal
        wnotify.amount
        wnotify.comdat
        wnotify.expdat
        wnotify.ben_name
        wnotify.accsor
        wnotify.instyp
        wnotify.CMRName
        wnotify.DealerName
        wnotify.showroom
        wnotify.remark
        wnotify.dealercode
        wnotify.vatcode
        wnotify.staus .
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
IF wnotify.chassis <> "" THEN DO:
    nv_c = wnotify.chassis.
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
        wnotify.chassis = nv_c .
END.

IF wnotify.engine <> ""  THEN DO:
    nv_c = wnotify.engine.
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
        wnotify.engine = nv_c .

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

IF wnotify.policy <> ""  THEN DO:  /* 70*/
    nv_c = wnotify.policy.
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
        wnotify.policy = nv_c .
END.

IF wnotify.compno <> ""  THEN DO:  /*72*/
    nv_c = wnotify.compno.
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
        wnotify.compno = nv_c .
END.

IF wnotify.prevpol <> "" THEN DO:
    nv_c = wnotify.prevpol.
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
        wnotify.prevpol = nv_c .
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
        tlt.genusr   =  "ISUZU-N" NO-LOCK .
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

