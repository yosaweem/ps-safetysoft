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
  wgwqori0.w :  Query & Update flag detail
 create  by  : Ranu I. A60-0340 Query & Update flag detail  */
/*modify by  : Ranu I. A61-0221 แก้ไข format file แจ้งงาน           */
/*Modify by  : Ranu I. A62-0219 เพิ่มการรันนิ่งเบอร์กรมธรรม์จากระบบ ในเมนู Match File Load */
/*Modify by  : Ranu I. A62-0454 เพิ่มการแสดงข้อมูล  และ Match file พรบ. รายเดี่ยว          */
/*modify by  : Kridtiya i. A66-0107 Date.26/05/2023 เก็บข้อมูลความเสียหายแยกออกมา          */
/*+++++++++++++++++++++++++++++++++++++++++++++++*/

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
     FIELD pol_addr1     as char format "x(150)" init ""           /*ที่อยู่ลูกค้า         */ 
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
     FIELD comment       AS CHAR FORMAT "x(255)" INIT "" 
     FIELD policy        AS CHAR FORMAT "x(13)"  INIT ""   /*A62-0219*/
     FIELD inspdetail    AS CHAR FORMAT "x(255)" INIT "" . /*A66-0107*/

/* create by A62-0219*/
 DEF VAR n_poltyp  AS CHAR INIT "".
DEF VAR nv_brnpol AS CHAR INIT "".
DEF VAR n_undyr2  AS CHAR INIT "".
DEF VAR n_brsty   AS CHAR INIT "".
DEF VAR n_br      AS CHAR INIT "" FORMAT "x(5)" .
DEFINE VAR nv_check    AS   CHARACTER  INITIAL ""  NO-UNDO.
DEFINE VAR nv_check70  AS   CHARACTER  INITIAL ""  NO-UNDO.
DEFINE VAR nv_check72  AS   CHARACTER  INITIAL ""  NO-UNDO.
DEF VAR n_name     AS CHAR FORMAT "x(100)" .
DEF VAR n_namefile AS CHAR FORMAT "x(100)" .
DEF VAR n_chk      AS LOGICAL INIT YES.
DEF VAR nv_notno70 AS CHAR FORMAT "x(12)".
DEF VAR nv_notno72 AS CHAR FORMAT "x(12)".
DEF BUFFER bftlt FOR brstat.tlt.
DEF VAR nv_message AS CHAR FORMAT "x(100)"  INIT "" . /*A62-0454*/

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
If  tlt.flag  =  "N"  Then  "New"  Else If  tlt.flag = "R" Then  "Renew" Else  "Comp " ~
tlt.exp tlt.filler1 tlt.nor_noti_tlt tlt.safe2 tlt.nor_noti_ins ~
tlt.comp_pol tlt.ins_name tlt.cha_no tlt.gendat tlt.expodat tlt.nor_coamt ~
tlt.nor_grprm tlt.comp_sck tlt.comp_grprm tlt.comp_coamt 
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_tlt 
&Scoped-define QUERY-STRING-br_tlt FOR EACH tlt NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-br_tlt OPEN QUERY br_tlt FOR EACH tlt NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-br_tlt tlt
&Scoped-define FIRST-TABLE-IN-QUERY-br_tlt tlt


/* Definitions for FRAME fr_main                                        */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS rs_matctyp bu_exit ra_status fi_trndatfr ~
fi_trndatto bu_ok cb_search bu_oksch br_tlt fi_search bu_update cb_report ~
fi_br fi_outfile bu_report bu_upyesno fi_match buimp bu_match RECT-332 ~
RECT-338 RECT-339 RECT-340 RECT-341 RECT-381 RECT-342 RECT-387 
&Scoped-Define DISPLAYED-OBJECTS rs_matctyp ra_status fi_trndatfr ~
fi_trndatto cb_search fi_search fi_name cb_report fi_br fi_outfile fi_match 

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
     LABEL "Match File Load" 
     SIZE 15.5 BY .95
     BGCOLOR 2 .

DEFINE BUTTON bu_ok 
     LABEL "OK" 
     SIZE 9 BY 1
     FONT 6.

DEFINE BUTTON bu_oksch 
     LABEL "OK" 
     SIZE 5 BY .95
     FONT 6.

DEFINE BUTTON bu_report 
     LABEL "REPORT FILE" 
     SIZE 15.5 BY .95.

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
     LIST-ITEMS "ชื่อผู้เอาประกัน" 
     DROP-DOWN-LIST
     SIZE 40 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_br AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 3.5 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_match AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 74.17 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_name AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 39 BY .95
     BGCOLOR 15 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_outfile AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 75 BY .95
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
     BGCOLOR 10 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE rs_matctyp AS INTEGER 
     VIEW-AS RADIO-SET VERTICAL
     RADIO-BUTTONS 
          "Policy", 1,
"Comp", 2
     SIZE 9.5 BY 1.91
     BGCOLOR 28 FGCOLOR 2 FONT 6 DROP-TARGET NO-UNDO.

DEFINE RECTANGLE RECT-332
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132.5 BY 8.48
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-338
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 58.5 BY 2.91
     BGCOLOR 21 .

DEFINE RECTANGLE RECT-339
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 71 BY 2.91
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-340
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 130.5 BY 1.67
     BGCOLOR 3 .

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

DEFINE RECTANGLE RECT-387
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 29.17 BY 2.38
     BGCOLOR 21 .

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_tlt FOR 
      tlt SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_tlt
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_tlt c-wins _STRUCTURED
  QUERY br_tlt NO-LOCK DISPLAY
      tlt.releas COLUMN-LABEL "YES/NO" FORMAT "x(20)":U WIDTH 11
      If  tlt.flag  =  "N"  Then  "New"  Else If  tlt.flag = "R" Then  "Renew"
Else  "Comp " COLUMN-LABEL "Data Type" FORMAT "x(8)":U
            WIDTH 11.83 LABEL-FGCOLOR 1 LABEL-FONT 6
      tlt.exp COLUMN-LABEL "ฺBR." FORMAT "XX":U
      tlt.filler1 COLUMN-LABEL "Old Policy" FORMAT "x(20)":U WIDTH 15
      tlt.nor_noti_tlt COLUMN-LABEL "เลขรับแจ้ง" FORMAT "x(25)":U
            WIDTH 17
      tlt.safe2 COLUMN-LABEL "เลขที่สัญญา" FORMAT "x(10)":U WIDTH 14.83
      tlt.nor_noti_ins COLUMN-LABEL "New Policy" FORMAT "x(20)":U
            WIDTH 15
      tlt.comp_pol COLUMN-LABEL "Comp Policy" FORMAT "x(20)":U
            WIDTH 15
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
      tlt.comp_grprm COLUMN-LABEL "Gross premium 72" FORMAT ">>>,>>9.99":U
            WIDTH 9.33
      tlt.comp_coamt COLUMN-LABEL "Total Prem." FORMAT "->>,>>>,>>9.99":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 132.5 BY 15
         BGCOLOR 15 FGCOLOR 1 FONT 1 ROW-HEIGHT-CHARS .75.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     rs_matctyp AT ROW 7.33 COL 121.5 NO-LABEL WIDGET-ID 4
     bu_exit AT ROW 1.57 COL 106.67
     ra_status AT ROW 6.05 COL 91.17 NO-LABEL
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
     fi_br AT ROW 6.1 COL 67.33 COLON-ALIGNED NO-LABEL
     fi_outfile AT ROW 7.24 COL 27.5 NO-LABEL
     bu_report AT ROW 7.33 COL 104.67
     bu_upyesno AT ROW 4.48 COL 118
     fi_match AT ROW 8.38 COL 24.33 NO-LABEL
     buimp AT ROW 8.38 COL 98.83
     bu_match AT ROW 8.43 COL 104.67
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
          SIZE 17 BY 1 AT ROW 6.05 COL 73.17
          BGCOLOR 3 FGCOLOR 7 FONT 6
     "BRANCH :" VIEW-AS TEXT
          SIZE 10.5 BY .95 AT ROW 6.1 COL 58.67
          BGCOLOR 3 FGCOLOR 7 FONT 6
     "To  :" VIEW-AS TEXT
          SIZE 7.5 BY 1 AT ROW 1.67 COL 55
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " OUTPUT FILE NAME :" VIEW-AS TEXT
          SIZE 23.33 BY .95 AT ROW 7.24 COL 3.33
          BGCOLOR 3 FGCOLOR 7 FONT 6
     "วันที่ไฟล์แจ้งงาน  From :" VIEW-AS TEXT
          SIZE 21.5 BY 1 AT ROW 1.67 COL 4.83
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "SEARCH BY :" VIEW-AS TEXT
          SIZE 14 BY 1 AT ROW 3.19 COL 4.33
          BGCOLOR 21 FGCOLOR 0 FONT 6
     RECT-332 AT ROW 1.1 COL 1.33
     RECT-338 AT ROW 2.95 COL 2.5
     RECT-339 AT ROW 2.95 COL 61.83
     RECT-340 AT ROW 1.24 COL 2.33
     RECT-341 AT ROW 1.33 COL 104.83
     RECT-381 AT ROW 4.24 COL 52.17
     RECT-342 AT ROW 1.33 COL 92.67
     RECT-387 AT ROW 7.1 COL 103.5 WIDGET-ID 2
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
         TITLE              = "Query && Update [ORICO]"
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
/* SETTINGS FOR FILL-IN fi_match IN FRAME fr_main
   ALIGN-L                                                              */
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
"tlt.releas" "YES/NO" "x(20)" "character" ? ? ? ? ? ? no ? no no "11" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[2]   > "_<CALC>"
"If  tlt.flag  =  ""N""  Then  ""New""  Else If  tlt.flag = ""R"" Then  ""Renew""
Else  ""Comp """ "Data Type" "x(8)" ? ? ? ? ? 1 6 no ? no no "11.83" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   > brstat.tlt.exp
"tlt.exp" "ฺBR." ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   > brstat.tlt.filler1
"tlt.filler1" "Old Policy" "x(20)" "character" ? ? ? ? ? ? no ? no no "15" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   > brstat.tlt.nor_noti_tlt
"tlt.nor_noti_tlt" "เลขรับแจ้ง" ? "character" ? ? ? ? ? ? no ? no no "17" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[6]   > brstat.tlt.safe2
"tlt.safe2" "เลขที่สัญญา" "x(10)" "character" ? ? ? ? ? ? no ? no no "14.83" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[7]   > brstat.tlt.nor_noti_ins
"tlt.nor_noti_ins" "New Policy" "x(20)" "character" ? ? ? ? ? ? no ? no no "15" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[8]   > brstat.tlt.comp_pol
"tlt.comp_pol" "Comp Policy" "x(20)" "character" ? ? ? ? ? ? no ? no no "15" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[9]   > brstat.tlt.ins_name
"tlt.ins_name" "Insured name" ? "character" ? ? ? ? ? ? no ? no no "25" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
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
     _FldNameList[16]   > brstat.tlt.comp_grprm
"tlt.comp_grprm" "Gross premium 72" ">>>,>>9.99" "decimal" ? ? ? ? ? ? no ? no no "9.33" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[17]   > brstat.tlt.comp_coamt
"tlt.comp_coamt" "Total Prem." ? "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _Query            is NOT OPENED
*/  /* BROWSE br_tlt */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME c-wins
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c-wins c-wins
ON END-ERROR OF c-wins /* Query  Update [ORICO] */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c-wins c-wins
ON WINDOW-CLOSE OF c-wins /* Query  Update [ORICO] */
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

    IF tlt.flag <> "COMP" THEN DO: /* กธ */
        {&WINDOW-NAME}:hidden  =  Yes. 
            Run  wgw\wgwqori1(Input  nv_recidtlt).
        {&WINDOW-NAME}:hidden  =  No.   
    END.
    /* create by a62-0454*/
    ELSE DO: /* พรบ. */
        {&WINDOW-NAME}:hidden  =  Yes. 
            Run  wgw\wgwqori2(Input  nv_recidtlt).
        {&WINDOW-NAME}:hidden  =  No.  

    END.
    /* end A62-0454*/

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
ON CHOOSE OF bu_match IN FRAME fr_main /* Match File Load */
DO:
    DEF VAR nv_message AS CHAR FORMAT "x(70)" INIT "" . /*A62-0545*/

    IF fi_match = "" THEN DO:
        MESSAGE "กรุณาใสชื่อไฟล์!!!"  VIEW-AS ALERT-BOX.
        Apply "Entry"  to fi_match.
        Return no-apply. 
    END.
    ELSE DO:
        /* Add by a62-0454*/
        IF rs_matctyp = 1 THEN nv_message = "Match File Load ของกรมธรรม์ (V70) " .
        ELSE nv_message = "Match File Load พรบ.รายเดี่ยว (V72) " .

        MESSAGE nv_message VIEW-AS ALERT-BOX QUESTION 
        BUTTON YES-NO TITLE "Match file Load " UPDATE Ichoice AS LOGICAL.
        CASE Ichoice:
            WHEN TRUE THEN  DO: /* Yes */ 
                IF rs_matctyp = 1 THEN RUN proc_matchpol. /* v70 */
                ELSE RUN proc_matchcomp . /*V72*/
                    
            END.    
            WHEN FALSE THEN  DO:    /* No */  
                APPLY "Entry" TO fi_match .     
                RETURN NO-APPLY.   
            END.
        END CASE.
        /* end A62-0454 */
        /* comment by A62-0454...
        FOR EACH  wdetail :                                                                          
            DELETE  wdetail.                                                                         
        END.                                                                                         
        INPUT FROM VALUE(fi_match).                                                               
        REPEAT:                                                                                      
            CREATE wdetail.                                                                          
            IMPORT DELIMITER "|"                                                                     
                wdetail.n_no                        /*No.                     */     
                wdetail.Remark                      /*Marketing               */     
                wdetail.Account_no                  /*Agreement No.           */     
                wdetail.RegisDate                   /*วันที่รับแจ้ง           */
                wdetail.CovTyp                      /*ประเภทประกัน            */  
                wdetail.garage                      /*Type of Garage          */ 
                wdetail.prevpol                     /*กรมธรรม์ เลขที่         */     
                wdetail.compno                      /*พรบ.เลขที่              */     
                wdetail.safe_no                     /*เลขที่รับแจ้ง           */     
                wdetail.CMRName                     /*ผู้รับแจ้ง              */     
                wdetail.not_time                    /*เวลาแจ้งงาน             */     
                wdetail.name_insur                  /*ชื่อผู้เอาประกันภัย     */     
                wdetail.icno                        /*ID. Card No.            */     
                wdetail.saleid                      /*เลขทะเบียนการค้า(ภพ.20) */     
                wdetail.taxname                     /*ออกใบเสร็จ/ใบกำกับภาษีในนาม  */     
                wdetail.taxno                       /*เลขประจำตัวผู้เสียภาษี13หลัก */     
                wdetail.branch                      /*สาขา      */     
                wdetail.pol_addr1                   /*ที่อยู่ในการออกใบเสร็จ/ใบกำกับภาษี  */     
                wdetail.CustAddress                 /*ที่อยู่ในการจัดส่งเอกสาร  */     
                wdetail.SI                          /*ทุนประกัน          */     
                wdetail.netprem                     /*เบี้ยประกันสุทธิ   */     
                wdetail.totalprem                   /*เบี้ยประกันรวม     */     
                wdetail.comp_prm                    /*เบี้ยพรบ สุทธิ     */     
                wdetail.comp_prmtotal               /*เบี้ยพรบ รวม       */ 
                wdetail.brand                       /* ยี่ห้อ            */ /* A61-0221 */
                wdetail.Brand_Model                 /*รุ่น               */     
                wdetail.yrmanu                      /*ปี                 */     
                wdetail.n_color                     /*สี                 */     
                wdetail.RegisNo                     /*เลขทะเบียน         */     
                wdetail.RegisProv                   /*จังหวัด            */     
                wdetail.CC                          /*ขนาดเครื่องยนต์    */     
                wdetail.engine                      /*เลขเครื่องยนต์     */     
                wdetail.chassis                     /*เลขตัวถัง          */     
                wdetail.accsor                      /*อุปกรณ์ตกแต่งเพิ่มเติม       */     
                wdetail.accsor_price                /*อุปกรณ์ตกแต่งเพิ่มเติมราคา   */     
                wdetail.InsTyp                      /*แถม/ไม่แถม ประกันภัย         */     
                wdetail.comtyp                      /*แถม/ไม่แถม พรบ.              */   
                wdetail.DealerName                  /*ชื่อ Dealer                  */     
                wdetail.drivname1                   /*ชื่อ-นามสกุล ผู้ขับขี่1      */     
                wdetail.drivdate1                   /*วัน/เดือน/ปี เกิด ผู้ขับขี่1 */     
                wdetail.drivid1                     /*เลขที่ใบขับขี่ผู้ขับขี่1     */     
                wdetail.drivname2                   /*ชื่อ-นามสกุล ผู้ขับขี่2      */     
                wdetail.drivdate2                   /*วัน/เดือน/ปี เกิด ผู้ขับขี่2 */     
                wdetail.drivid2                     /*เลขที่ใบขับขี่ ผู้ขับขี่2    */     
                wdetail.comdat                      /*วันที่คุ้มครอง     */     
                wdetail.expdat                      /*วันสิ้นสุดคุ้มครอง */     
                wdetail.ben_name                    /*ผู้รับผลประโยชน์   */   
                wdetail.n_class.                    /*รหัสรถยนต์   */   
                /*wdetail.pack                      /*Pack         */     
                wdetail.producer                    /*Producer     */     
                wdetail.agent                       /*Agent        */     
                wdetail.branch_saf                  /*Branch       */     
                wdetail.vatcode                     /*Vat Code     */     
                wdetail.campaign                    /*Campaign     */     
                wdetail.inspect.  */                /*Inspection   */   
                                                                                                 
            IF INDEX(wdetail.n_no,"No")   <> 0 THEN  DELETE wdetail.                                 
            ELSE IF  wdetail.n_no         = "" THEN  DELETE wdetail.                                 
        END.  /* repeat  */ 
        RUN pd_reportfileload.
        Message "Export data Complete"  View-as alert-box.
        ... end a62-0454...*/
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
        tlt.genusr   =  "ORICO"        no-lock.  
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
    If  cb_search = "ชื่อลูกค้า"  Then do:              /* name  */                          
        Open Query br_tlt                                                        
            For each tlt Use-index  tlt01      Where                                     
            tlt.trndat  >=  fi_trndatfr        And                                            
            tlt.trndat  <=  fi_trndatto        And  
            tlt.genusr   =  "ORICO"            And
            index(tlt.ins_name,fi_search) <> 0 no-lock.  
                ASSIGN nv_rectlt =  recid(tlt) .  /*add Kridtiya i. A56-0323*/
                Apply "Entry"  to br_tlt.
                Return no-apply.            
    END.
    ELSE If  cb_search  =  "เลขที่รับแจ้ง"  Then do:   /* policy */
        Open Query br_tlt 
            For each tlt Use-index  tlt01 Where
            tlt.trndat   >=  fi_trndatfr  And
            tlt.trndat   <=  fi_trndatto  And
            tlt.genusr    =  "ORICO"      And
            index(tlt.nor_noti_tlt,fi_search) <> 0  no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .  /*add Kridtiya i. A56-0323*/
                Apply "Entry"  to br_tlt.
                Return no-apply.        
    END.
    ELSE If  cb_search  =  "เลขที่สัญญา"  Then do:   /* policy */
        Open Query br_tlt 
            For each tlt Use-index  tlt01 Where
            tlt.trndat   >=  fi_trndatfr  And
            tlt.trndat   <=  fi_trndatto  And
            tlt.genusr    =  "ORICO"      And
            index(tlt.safe2,fi_search) <> 0  no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .  /*add Kridtiya i. A56-0323*/
                Apply "Entry"  to br_tlt.
                Return no-apply.        
    END.
    ELSE If  cb_search  =  "กรมธรรม์ใหม่"  Then do:   /* policy */
        Open Query br_tlt 
            For each tlt Use-index  tlt01 Where
            tlt.trndat   >=  fi_trndatfr  And
            tlt.trndat   <=  fi_trndatto  And
            tlt.genusr    =  "ORICO"      And
            index(tlt.nor_noti_ins,fi_search) <> 0  no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .  /*add Kridtiya i. A56-0323*/
                Apply "Entry"  to br_tlt.
                Return no-apply.        
    END.
    ELSE If  cb_search  =  "กรมธรรม์เก่า"  Then do:   /* policy */
        Open Query br_tlt 
            For each tlt Use-index  tlt01 Where
            tlt.trndat   >=  fi_trndatfr  And
            tlt.trndat   <=  fi_trndatto  And
            tlt.genusr    =  "ORICO"      And
            index(brstat.tlt.filler1,fi_search) <> 0  no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .  /*add Kridtiya i. A56-0323*/
                Apply "Entry"  to br_tlt.
                Return no-apply.        
    END.
    ELSE If  cb_search  =  "ป้ายแดง"  Then do:    
        Open Query br_tlt 
            For each tlt Use-index  tlt01 Where
            tlt.trndat   >=  fi_trndatfr  And
            tlt.trndat   <=  fi_trndatto  And
            tlt.genusr    =  "ORICO"      And
            tlt.flag      =  "N"          no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .  /*add Kridtiya i. A56-0323*/
                Apply "Entry"  to br_tlt.
                Return no-apply.        
    END.
    ELSE If  cb_search  =  "ต่ออายุ"  Then do:    
        Open Query br_tlt 
            For each tlt Use-index  tlt01 Where
            tlt.trndat   >=  fi_trndatfr  And
            tlt.trndat   <=  fi_trndatto  And
            tlt.genusr    =  "ORICO"      And
            tlt.flag      =  "R"          no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .  /*add Kridtiya i. A56-0323*/
                Apply "Entry"  to br_tlt.
                Return no-apply.        
    END.
    /* create by a62-0454*/ 
    ELSE If  cb_search  =  "พรบ."  Then do:    
        Open Query br_tlt 
            For each tlt Use-index  tlt01 Where
            tlt.trndat   >=  fi_trndatfr  And
            tlt.trndat   <=  fi_trndatto  And
            tlt.genusr    =  "ORICO"      And
            tlt.flag      =  "COMP"          no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .  
                Apply "Entry"  to br_tlt.
                Return no-apply.        
    END.
    /* end a62-0454*/
    ELSE If  cb_search  = "เลขตัวถัง"  Then do:  /* chassis no */
        Open Query br_tlt 
            For each tlt Use-index  tlt06 Where
            tlt.trndat >=  fi_trndatfr    And
            tlt.trndat <=  fi_trndatto    AND 
            tlt.genusr   =  "ORICO"       And
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
            tlt.genusr   =  "ORICO"        And
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
            tlt.genusr   =  "ORICO"         And
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
            tlt.genusr   =  "ORICO"        And
            index(tlt.releas,"cancel") > 0     no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .  /*add Kridtiya i. A56-0323*/
                Apply "Entry"  to br_tlt.
                Return no-apply.                             
    END.
    ELSE If  cb_search  =  "สาขา"  Then do:    /* cancel */
        Open Query br_tlt 
            For each tlt Use-index  tlt01  Where
            tlt.trndat  >=  fi_trndatfr    And
            tlt.trndat  <=  fi_trndatto    And
            tlt.genusr   =  "ORICO"        And
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
ON CHOOSE OF bu_report IN FRAME fr_main /* REPORT FILE */
DO:
    IF fi_outfile = "" THEN DO:
        MESSAGE "กรุณาใสชื่อไฟล์!!!"  VIEW-AS ALERT-BOX.
        Apply "Entry"  to fi_outfile.
        Return no-apply. 
    END.
    ELSE DO:
        /* Add by a62-0454*/
        IF rs_matctyp = 1 THEN nv_message = "Export File Data Policy V70 " .
        ELSE nv_message = "Export File Data Policy V72 " .

        MESSAGE nv_message VIEW-AS ALERT-BOX QUESTION 
        BUTTON YES-NO TITLE "Match file Load " UPDATE Ichoice AS LOGICAL.
        CASE Ichoice:
            WHEN TRUE THEN  DO: /* Yes */ 
                IF rs_matctyp = 1 THEN RUN pd_reportfiel. /* v70 */
                ELSE RUN pd_reportcomp . /*V72*/
                    
            END.    
            WHEN FALSE THEN  DO:    /* No */  
                APPLY "Entry" TO fi_match .     
                RETURN NO-APPLY.   
            END.
        END CASE.
        /* end A62-0454 */
        /*RUN pd_reportfiel.*/ /*A62-0454*/
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
            message "ยกเลิกข้อมูลรายการนี้  "  View-as alert-box.
            IF tlt.releas = "" THEN tlt.releas  =  "Cancel" .
            ELSE tlt.releas  =  "Cancel/" + tlt.releas .
        END.
        Else do:
            message "เรียกข้อมูลกลับมาใช้งาน "  View-as alert-box.
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
            message "ยกเลิกข้อมูลรายการนี้  " tlt.releas  /*FORMAT "x(20)" */
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
            message "Update No ข้อมูลรายการนี้  "  View-as alert-box.
            IF tlt.releas = "" THEN tlt.releas  =  "NO" .
            ELSE IF index(tlt.releas,"Cancel/")  <> 0 THEN 
                ASSIGN tlt.releas  =  "Cancel/no" .
            ELSE ASSIGN tlt.releas  =  "no" .
        END.
        Else do:    /* no */
            If  index(tlt.releas,"Yes")  =  0  Then do:  /* yes */
            message "Update Yes ข้อมูลรายการนี้  "  View-as alert-box.
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
        MESSAGE "ไม่พบข้อมูล กรุณาตรวจสอบการ Process ข้อมูล" VIEW-AS ALERT-BOX WARNING.
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
        MESSAGE "ไม่พบข้อมูล การค้น" VIEW-AS ALERT-BOX WARNING.
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
        MESSAGE "ไม่พบข้อมูล กรุณาตรวจสอบการ Process ข้อมูล" VIEW-AS ALERT-BOX WARNING.
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
        MESSAGE "ไม่พบข้อมูล การค้น" VIEW-AS ALERT-BOX WARNING.
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
    DEF VAR  nv_sort   as  int  init 0.
    ASSIGN
        fi_search     =  Input  fi_search.
    /*comment by Kridtiya i. A55-0184...
    Disp fi_search  with frame fr_main.
    /*If  fi_polfr  =   "0"  Then  fi_polfr  =  " "  .*//*kridtiya i. A54-0216 ...*/
    If  ra_choice =  1  Then do:              /* name  */
        Open Query br_tlt 
            For each tlt Use-index  tlt01 Where
            tlt.trndat  >=  fi_trndatfr And
            tlt.trndat  <=  fi_trndatto And
           /* tlt.policy  >=  fi_polfr    And
            tlt.policy  <=  fi_polto    And*/
            /*tlt.comp_sub  =  fi_producer  And*/
            tlt.genusr   =  "ICBCTL"     And
            index(tlt.ins_name,fi_search) <> 0   no-lock.
                Apply "Entry"  to br_tlt.
                Return no-apply.            
    END.
    ELSE If  ra_choice  =  2  Then do:   /* policy */
        Open Query br_tlt 
            For each tlt Use-index  tlt01 Where
            tlt.trndat   >=  fi_trndatfr  And
            tlt.trndat   <=  fi_trndatto And
            /*/*kridtiya i. A54-0216 ...*/
            tlt.policy   >=  fi_polfr     And
            tlt.policy   <=  fi_polto     And /*kridtiya i. A54-0216 ...*/*/
            /*tlt.policy   >=  fi_polfr     AND  /*kridtiya i. A54-0216 ...*/
            tlt.policy   <=  fi_polto     AND  /*kridtiya i. A54-0216 ...*/*/
            /*tlt.comp_sub  =  fi_producer  And*/
            tlt.genusr    =  "ICBCTL"      And
            index(tlt.rec_addr5,fi_search) <> 0  no-lock.
                Apply "Entry"  to br_tlt.
                Return no-apply.        
    END.
    ELSE If  ra_choice  =  3  Then do:  /* chassis no */
        Open Query br_tlt 
            For each tlt Use-index  tlt06 Where
            tlt.trndat >=  fi_trndatfr  And
            tlt.trndat <=  fi_trndatto And
            /*tlt.policy >=  fi_polfr      And
            tlt.policy <=  fi_polto     And*/
            /*tlt.comp_sub  =  fi_producer  And*/
            tlt.genusr   =  "ICBCTL"   And
            INDEX(tlt.cha_no,trim(fi_search)) <> 0 
            /*tlt.cha_no  >=  fi_search ) */   no-lock.
                Apply "Entry"  to br_tlt.
                Return no-apply.            
    END.
    ELSE If  ra_choice  =  4  Then do:   /* Confirm yes..*/
        Open Query br_tlt 
            For each tlt Use-index  tlt01  Where
            tlt.trndat >=  fi_trndatfr     And
            tlt.trndat <=  fi_trndatto     And
            /*tlt.policy >=  fi_polfr      And
            tlt.policy <=  fi_polto        And*/
            /*tlt.comp_sub  =  fi_producer And*/
            tlt.genusr   =  "ICBCTL"        And
            INDEX(tlt.releas,"yes") <> 0   no-lock.
                Apply "Entry"  to br_tlt.
                Return no-apply.            
    END.
    ELSE If  ra_choice  =  5  Then do:     /* confirm no...*/
        Open Query br_tlt 
            For each tlt Use-index  tlt01   Where
            tlt.trndat >=  fi_trndatfr      And
            tlt.trndat <=  fi_trndatto      And
            /*tlt.policy >=  fi_polfr       And
            tlt.policy <=  fi_polto         And*/
            /*tlt.comp_sub  =  fi_producer  And*/
            tlt.genusr   =  "ICBCTL"         And
            INDEX(tlt.releas,"no") <> 0     no-lock.
                Apply "Entry"  to br_tlt.
                Return no-apply.            
    END.
    ELSE If  ra_choice  =  6  Then do:    /* cancel */
      /*If  fi_polfr  =   "0"  Then  fi_polfr  =  " "  .*/
      Open Query br_tlt 
          For each tlt Use-index  tlt01 Where
          tlt.trndat  >=  fi_trndatfr   And
          tlt.trndat  <=  fi_trndatto   And
          /*tlt.policy  >=  fi_polfr      And
          tlt.policy  <=  fi_polto      And*/
          /*   tlt.comp_sub  =  fi_producer  And*/
          tlt.genusr   =  "ICBCTL"      And
          index(tlt.releas,"cancel") > 0     no-lock.
              Apply "Entry"  to br_tlt.
              Return no-apply.                             
      END.
      Else  do:
          Apply "Entry"  to  fi_search.
          Return no-apply.
      END. 
      end.......comment by Kridtiya i. A55-0184*/
    /*add A55-0184 */
    Disp fi_search  with frame fr_main.
    If  cb_search = "ชื่อลูกค้า"  Then do:              /* name  */                          
        Open Query br_tlt                                                        
            For each tlt Use-index  tlt01  Where                                     
            tlt.trndat  >=  fi_trndatfr         And                                            
            tlt.trndat  <=  fi_trndatto         And  
            tlt.genusr   =  "ICBCTL"             And
            index(tlt.ins_name,fi_search) <> 0  no-lock.      
                ASSIGN nv_rectlt =  recid(tlt) .  /*add Kridtiya i. A56-0323*/
                Apply "Entry"  to br_tlt.
                Return no-apply.            
    END.
     ELSE If  cb_search  =  "เลขที่รับแจ้ง"  Then do:   /* policy */
        Open Query br_tlt 
            For each tlt Use-index  tlt01 Where
            tlt.trndat   >=  fi_trndatfr  And
            tlt.trndat   <=  fi_trndatto  And
            tlt.genusr    =  "ICBCTL"      And
            index(tlt.nor_noti_tlt,fi_search) <> 0  no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .  /*add Kridtiya i. A56-0323*/
                Apply "Entry"  to br_tlt.
                Return no-apply.        
    END.
    ELSE If  cb_search  =  "เลขที่สัญญา"  Then do:   /* policy */
        Open Query br_tlt 
            For each tlt Use-index  tlt01 Where
            tlt.trndat   >=  fi_trndatfr  And
            tlt.trndat   <=  fi_trndatto  And
            tlt.genusr    =  "ICBCTL"      And
            index(tlt.safe2,fi_search) <> 0  no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .  /*add Kridtiya i. A56-0323*/
                Apply "Entry"  to br_tlt.
                Return no-apply.        
    END.
    ELSE If  cb_search  =  "กรมธรรม์ใหม่"  Then do:   /* policy */
        Open Query br_tlt 
            For each tlt Use-index  tlt01 Where
            tlt.trndat   >=  fi_trndatfr  And
            tlt.trndat   <=  fi_trndatto  And
            tlt.genusr    =  "ICBCTL"      And
            index(tlt.nor_noti_ins,fi_search) <> 0  no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .  /*add Kridtiya i. A56-0323*/
                Apply "Entry"  to br_tlt.
                Return no-apply.        
    END.
    ELSE If  cb_search  =  "กรมธรรม์เก่า"  Then do:   /* policy */
        Open Query br_tlt 
            For each tlt Use-index  tlt01 Where
            tlt.trndat   >=  fi_trndatfr  And
            tlt.trndat   <=  fi_trndatto  And
            tlt.genusr    =  "ICBCTL"      And
            index(tlt.rec_addr5,fi_search) <> 0  no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .  /*add Kridtiya i. A56-0323*/
                Apply "Entry"  to br_tlt.
                Return no-apply.        
    END.
    ELSE If  cb_search  =  "ป้ายแดง"  Then do:    
        Open Query br_tlt 
            For each tlt Use-index  tlt01 Where
            tlt.trndat   >=  fi_trndatfr  And
            tlt.trndat   <=  fi_trndatto  And
            tlt.genusr    =  "ICBCTL"      And
            tlt.flag      =  "N"          no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .  /*add Kridtiya i. A56-0323*/
                Apply "Entry"  to br_tlt.
                Return no-apply.        
    END.
    ELSE If  cb_search  =  "ต่ออายุ"  Then do:    
        Open Query br_tlt 
            For each tlt Use-index  tlt01 Where
            tlt.trndat   >=  fi_trndatfr            And 
            tlt.trndat   <=  fi_trndatto            And 
            tlt.genusr    =  "ICBCTL"                And 
            tlt.flag      =  "R"                    no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .  /*add Kridtiya i. A56-0323*/
                Apply "Entry"  to br_tlt.           
                Return no-apply.                    
    END.                                            
    ELSE If  cb_search  = "เลขตัวถัง"  Then do:  /* chassis no */
        Open Query br_tlt                           
            For each tlt Use-index  tlt06 Where     
            tlt.trndat >=  fi_trndatfr              And 
            tlt.trndat <=  fi_trndatto              AND 
            tlt.genusr   =  "ICBCTL"                 And 
            INDEX(tlt.cha_no,trim(fi_search)) <> 0  no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .  /*add Kridtiya i. A56-0323*/
                Apply "Entry"  to br_tlt.           
                Return no-apply.                    
    END.                                            
    ELSE If  cb_search  =  "Confirm_yes"  Then do:  /* Confirm yes..*/
        Open Query br_tlt                           
            For each tlt Use-index  tlt01  Where    
            tlt.trndat  >=  fi_trndatfr             And 
            tlt.trndat  <=  fi_trndatto             And 
            tlt.genusr   =  "ICBCTL"                 And 
            INDEX(tlt.releas,"yes") <> 0            no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .     /*add Kridtiya i. A56-0323*/
                Apply "Entry"  to br_tlt.            
                Return no-apply.                    
    END.                                            
    ELSE If  cb_search  =  "Confirm_no"  Then do:    /* confirm no...*/
        Open Query br_tlt                           
            For each tlt Use-index  tlt01   Where   
            tlt.trndat  >=  fi_trndatfr             And 
            tlt.trndat  <=  fi_trndatto             And 
            tlt.genusr   =  "ICBCTL"                 And 
            INDEX(tlt.releas,"no") <> 0             no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .       /*add Kridtiya i. A56-0323*/
                Apply "Entry"  to br_tlt.
                Return no-apply.            
    END.
    ELSE If  cb_search  =  "Status_cancel"  Then do:    /* cancel */
        Open Query br_tlt 
            For each tlt Use-index  tlt01  Where
            tlt.trndat  >=  fi_trndatfr    And
            tlt.trndat  <=  fi_trndatto    And
            tlt.genusr   =  "ICBCTL"        And
            index(tlt.releas,"cancel") > 0 no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .     /*add Kridtiya i. A56-0323*/
                Apply "Entry"  to br_tlt.
                Return no-apply.                             
    END.
    ELSE If  cb_search  =  "สาขา"  Then do:          /* cancel */
        Open Query br_tlt 
            For each tlt Use-index  tlt01  Where
            tlt.trndat  >=  fi_trndatfr    And
            tlt.trndat  <=  fi_trndatto    And
            tlt.genusr   =  "ICBCTL"        And
            tlt.EXP      =  fi_search      no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .     /*add Kridtiya i. A56-0323*/
                Apply "Entry"  to br_tlt.
                Return no-apply.                             
    END.
    Else  do:
        ASSIGN nv_rectlt =  recid(tlt) .             /*add Kridtiya i. A56-0323*/
        Apply "Entry"  to  fi_search.
        Return no-apply.
    END.
    /*A55-0184*/
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


&Scoped-define SELF-NAME rs_matctyp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL rs_matctyp c-wins
ON VALUE-CHANGED OF rs_matctyp IN FRAME fr_main
DO:
    rs_matctyp = INPUT rs_matctyp .
    DISP rs_matctyp WITH FRAME fr_main.

  
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
  gv_prgid = "wgwqori0".
  gv_prog  = "Query & Update  Detail  (ORICO) ".
  RUN  WUT\WUTHEAD ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).

  SESSION:DATA-ENTRY-RETURN = YES.


  Rect-338:Move-to-top().  
  Rect-339:Move-to-top(). 
  RECT-381:Move-to-top().

  ASSIGN 
      fi_trndatfr = TODAY
      fi_trndatto = TODAY
      rs_matctyp  = 1   /*a62-0454*/
     /*ra_choice   =  1 */ /*A55-0184*/
      /*fi_polfr    = "0"
      fi_polto    = "Z" */   
      vAcProc_fil = vAcProc_fil   + "ชื่อลูกค้า"   + "," 
                                  + "กรมธรรม์ใหม่" + "," 
                                  + "เลขที่รับแจ้ง" + "," 
                                  + "เลขที่สัญญา" + "," 
                                  + "กรมธรรม์เก่า" + "," 
                                  + "ป้ายแดง" + ","
                                  + "ต่ออายุ" + "," 
                                  + "พรบ." + ","   /*A62-0454*/
                                  + "เลขตัวถัง"      + "," 
                                  + "Confirm_yes"     + "," 
                                  + "Confirm_No" + "," 
                                  + "Status_cancel"  + ","
                                  + "สาขา"  + ","
        cb_search:LIST-ITEMS = vAcProc_fil
        cb_search = ENTRY(1,vAcProc_fil)
        vAcProc_fil1 = vAcProc_fil1 
                                  + "All"  + ","
                                  + "New" + "," 
                                  + "Renew" + ","
                                  + "สาขา" + "," 
                                  + "Confirm_yes"     + "," 
                                  + "Confirm_No" + "," 
                                  + "Status_cancel"  + ","
                                  + "Confirm แล้ว"  + ","
                                  + "ยังไม่ Confirm"  + ","
        cb_report:LIST-ITEMS = vAcProc_fil1
        cb_report = ENTRY(1,vAcProc_fil1)
      ra_status = 4  
      fi_outfile = "C:\TEMP\Report_Orico" + 
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
       rs_matctyp /*A62-0454*/  with frame fr_main.

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
  DISPLAY rs_matctyp ra_status fi_trndatfr fi_trndatto cb_search fi_search 
          fi_name cb_report fi_br fi_outfile fi_match 
      WITH FRAME fr_main IN WINDOW c-wins.
  ENABLE rs_matctyp bu_exit ra_status fi_trndatfr fi_trndatto bu_ok cb_search 
         bu_oksch br_tlt fi_search bu_update cb_report fi_br fi_outfile 
         bu_report bu_upyesno fi_match buimp bu_match RECT-332 RECT-338 
         RECT-339 RECT-340 RECT-341 RECT-381 RECT-342 RECT-387 
      WITH FRAME fr_main IN WINDOW c-wins.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW c-wins.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_filecomp c-wins 
PROCEDURE pd_filecomp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: create by A62-0454   
------------------------------------------------------------------------------*/
/*ASSIGN nv_cnt =  0.*/
OUTPUT TO VALUE(nv_filemat).
EXPORT DELIMITER "|" 
    "Type. " 
    "เลขที่กรมธรรม์  "           
    "เลขเครื่องหมาย  "           
    "ชื่อผู้เอาประกัน"           
    "ที่อยู่         "           
    "วันเริ่มคุ้มครอง/เวลา  "    
    "วันสิ้นสุด  "               
    "รหัส        "
    "ยี่ห้อ      "
    "รุ่นรถ      "               
    "ทะเบียนรถ   " 
    "จังหวัด     "
    "เลขตัวถัง   "               
    "ประเภท      "               
    "ขนาดเครื่องยนต์ "           
    "เลขเครื่องยนต์  "           
    "ปีจดทะเบียน " 
    "เบี้ยสุทธิ  "               
    "อากร        "               
    "ภาษี        "               
    "เบี้ยรวมภาษีอากร"           
    "การใช้รถ   "                
    "วันออกกรมธรรม์  "           
    "เลขที่สัญญา"                
    "ID Card    "
    "Producer   "                
    "Agent      "                
    "Branch     "                
    "Docno      "                
    "อาชีพ     "
    "Comment   " . 
FOR EACH wdetail WHERE wdetail.n_no <> "" .
    RUN proc_cutpol.
    RUN proc_cutchar.
    FIND LAST brstat.tlt USE-INDEX tlt06 WHERE brstat.tlt.cha_no    = trim(wdetail.chassis) AND
                                               brstat.tlt.nor_noti_tlt  = TRIM(wdetail.safe_no) AND
                                               brstat.tlt.genusr    = "ORICO"  AND 
                                               brstat.tlt.flag      = "COMP"  NO-ERROR NO-WAIT. 
    IF AVAIL brstat.tlt THEN DO:
        IF brstat.tlt.releas = "YES" THEN ASSIGN wdetail.comment = "ออกงานแล้ว" .
        ELSE DO:
            ASSIGN  wdetail.brand       = trim(brstat.tlt.brand)
                    wdetail.Brand_Model = trim(brstat.tlt.model)
                    wdetail.RegisNo     = trim(brstat.tlt.lince1) 
                    wdetail.RegisProv   = trim(brstat.tlt.lince3)  
                    wdetail.n_class     = trim(brstat.tlt.safe3)     /*รหัสรถยนต์  */ 
                    wdetail.producer    = trim(brstat.tlt.comp_sub)        /*Producer    */   
                    wdetail.agent       = trim(brstat.tlt.comp_noti_ins)   /*Agent       */   
                    wdetail.branch_saf  = trim(brstat.tlt.exp)             /*Branch      */
                    wdetail.campaign    = trim(brstat.tlt.lotno)           /*docno    */
                    wdetail.sckno       = trim(brstat.tlt.comp_sck)        /* stk no */
                    wdetail.occup       = trim(brstat.tlt.recac)           /* อาชีพ */
                    wdetail.prevpol     = trim(brstat.tlt.filler1)         /* กรมเดิม*/
                    wdetail.comment     = trim(brstat.tlt.filler2)         /* หมายเหตุ */
                    wdetail.n_no        = trim(brstat.tlt.flag)           /* ประเภทงาน */
                    wdetail.comdat      = IF YEAR(brstat.tlt.gendat) > (YEAR(TODAY) + 1) THEN 
                                          STRING(DAY(brstat.tlt.gendat),"99") + "/" + 
                                          STRING(MONTH(brstat.tlt.gendat),"99") + "/" +
                                          STRING(YEAR(brstat.tlt.gendat) - 543,"9999") ELSE  STRING(brstat.tlt.gendat,"99/99/9999")
                    wdetail.expdat      = IF YEAR(brstat.tlt.expodat) > (YEAR(TODAY) + 1) THEN 
                                          STRING(DAY(brstat.tlt.expodat),"99") + "/" + 
                                          STRING(MONTH(brstat.tlt.expodat),"99") + "/" +
                                          STRING(YEAR(brstat.tlt.expodat) - 543,"9999") ELSE STRING(brstat.tlt.expodat,"99/99/9999")                                      
                    wdetail.comment     = trim("วันที่แจ้งงาน : " + string(brstat.tlt.trndat,"99/99/9999") + " " + wdetail.comment) . /* วันที่แจ้งงาน */ 
        END.
    END.
    ELSE DO: 
        ASSIGN  wdetail.n_class    = "" 
                wdetail.pack       = ""
                wdetail.producer   = ""
                wdetail.agent      = ""
                wdetail.branch_saf = ""
                wdetail.campaign   = ""
                wdetail.occup      = "".
    END.
    IF trim(wdetail.comment) = "ออกงานแล้ว" THEN NEXT.

    EXPORT DELIMITER "|"
         wdetail.n_no                       /*type                  */ 
         wdetail.safe_no                    /*เลขที่กรมธรรม์         */ 
         wdetail.sckno                      /*เลขเครื่องหมาย         */ 
         wdetail.name_insur                 /*ชื่อผู้เอาประกัน       */ 
         wdetail.CustAddress                /*ที่อยู่                */ 
         wdetail.comdat                     /*วันเริ่มคุ้มครอง/เวลา  */ 
         wdetail.expdat                     /*วันสิ้นสุด             */ 
         wdetail.n_class                    /*รหัส                   */
         wdetail.brand                       /*ยี่ห้อ  */    
         wdetail.Brand_Model                 /*รุ่น          */
         wdetail.RegisNo                     /*เลขทะเบียน    */                 
         wdetail.RegisProv                   /*จังหวัด       */
         wdetail.chassis                    /*เลขตัวถัง              */ 
         wdetail.comtyp                     /*ประเภท                 */ 
         wdetail.CC                         /*ขนาดเครื่องยนต์        */ 
         wdetail.engine                     /*เลขเครื่องยนต์         */ 
         wdetail.yrmanu                     /*ปีจดทะเบียน            */ 
         wdetail.comp_prm                   /*เบี้ยสุทธิ             */ 
         wdetail.netprem                    /*อากร                   */ 
         wdetail.totalprem                  /*ภาษี                   */ 
         wdetail.comp_prmtotal              /*เบี้ยรวมภาษีอากร       */ 
         wdetail.CovTyp                     /*การใช้รถ               */ 
         wdetail.RegisDate                  /*วันออกกรมธรรม์         */ 
         wdetail.account_no                 /*เลขที่สัญญา            */  
         wdetail.icno                       /*ID Card                */ 
         wdetail.producer                   /*Producer               */     
         wdetail.agent                      /*Agent                  */     
         wdetail.branch_saf                 /*Branch                 */     
         wdetail.campaign                   /*Docno                  */     
         wdetail.occup                      /* อาชีพ */                         
         wdetail.comment .  


END.                                                                   
OUTPUT   CLOSE.  

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_reportcomp c-wins 
PROCEDURE pd_reportcomp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR n_comdat70  AS CHAR FORMAT "x(15)"  init "".
DEF VAR n_expdat70  AS CHAR FORMAT "x(15)"  init "".

If  substr(fi_outfile,length(fi_outfile) - 3,4) <>  ".slk"  THEN 
    fi_outfile  =  Trim(fi_outfile) + ".slk"  .
/*ASSIGN nv_cnt =  0
    nv_row  =  1.*/
OUTPUT TO VALUE(fi_outfile).
EXPORT DELIMITER "|" 
    "Export Data ORICO :" 
    string(TODAY)   .
EXPORT DELIMITER "|" 
    "Type. " 
    "เลขที่กรมธรรม์  "           
    "เลขเครื่องหมาย  "           
    "ชื่อผู้เอาประกัน"           
    "ที่อยู่1         "
    "ที่อยู่2   "
    "ที่อยู่3   "
    "ที่อยู่4   "
    "วันเริ่มคุ้มครอง "    
    "วันสิ้นสุด  "               
    "รหัส        "
    "ยี่ห้อ      "
    "รุ่นรถ      "               
    "ทะเบียนรถ   " 
    "จังหวัด     "
    "เลขตัวถัง   "               
    "ประเภท      "               
    "ขนาดเครื่องยนต์ "           
    "เลขเครื่องยนต์  "           
    "ปีจดทะเบียน " 
    "เบี้ยสุทธิ  "               
    "อากร        "               
    "ภาษี        "               
    "เบี้ยรวมภาษีอากร"           
    "การใช้รถ   "                
    "วันออกกรมธรรม์  "           
    "เลขที่สัญญา"                
    "ID Card    "  
    "Producer   "                
    "Agent      "                
    "Branch     "                
    "Docno      "                
    "อาชีพ      "   
    "Comment    "
    "status     " . 
loop_tlt:
For each tlt Use-index  tlt01 Where
            tlt.trndat   >=  fi_trndatfr   And
            tlt.trndat   <=  fi_trndatto   And
            tlt.genusr    =  "ORICO"       AND 
            tlt.flag      =  "COMP"        no-lock. 

    IF cb_report = "สาขา" THEN DO:
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
    ELSE IF cb_report = "Confirm แล้ว" THEN DO:
        IF brstat.tlt.recac = "" THEN NEXT.
    END.
    ELSE IF cb_report = "ยังไม่ Confirm"   THEN DO:
        IF brstat.tlt.recac = "Confirm แล้ว" THEN NEXT.
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
        n_comdat70 = ""     
        n_expdat70 = ""     
        n_comdat70 = IF tlt.gendat <> ? THEN STRING(tlt.gendat,"99/99/9999") ELSE ""                              /*วันที่เริ่มคุ้มครอง     */         
        n_expdat70 = IF tlt.expodat <> ? THEN STRING(tlt.expodat,"99/99/9999") ELSE "" .                           /*วันที่สิ้นสุดคุ้มครอง   */ 
        
    EXPORT DELIMITER "|"                                               
    IF tlt.flag = "N" THEN "NEW" ELSE IF tlt.flag = "R" THEN "RENEW" ELSE "COMP"  /*ประเภทงาน          */
    brstat.tlt.comp_pol
    brstat.tlt.comp_sck
    brstat.tlt.rec_name + " " + brstat.tlt.ins_name 
    brstat.tlt.ins_addr1 
    brstat.tlt.ins_addr2 
    brstat.tlt.ins_addr3 
    brstat.tlt.ins_addr4
    n_comdat70
    n_expdat70
    brstat.tlt.safe3
    brstat.tlt.brand
    brstat.tlt.model
    brstat.tlt.lince1 
    brstat.tlt.lince3 
    brstat.tlt.cha_no
    brstat.tlt.old_eng 
    brstat.tlt.cc_weight
    brstat.tlt.eng_no
    brstat.tlt.lince2
    brstat.tlt.rec_addr4
    brstat.tlt.nor_grprm  
    brstat.tlt.comp_coamt 
    brstat.tlt.comp_grprm
    brstat.tlt.expousr
    brstat.tlt.datesent
    brstat.tlt.safe2
    brstat.tlt.ins_addr5
    brstat.tlt.comp_sub                       /*Producer    */   
    brstat.tlt.comp_noti_ins                  /*Agent       */   
    brstat.tlt.exp                            /*Branch      */   
    brstat.tlt.lotno                          /*doc no   */   
    brstat.tlt.recac                          /*อาชีพ */
    brstat.tlt.filler2
    tlt.releas.                               /*การออกงาน   */ 
END.                                                                   
OUTPUT   CLOSE.  
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

If  substr(fi_outfile,length(fi_outfile) - 3,4) <>  ".slk"  THEN 
    fi_outfile  =  Trim(fi_outfile) + ".slk"  .
/*ASSIGN nv_cnt =  0
    nv_row  =  1.*/
OUTPUT TO VALUE(fi_outfile).
EXPORT DELIMITER "|" 
    "Export Data ORICO :" 
    string(TODAY)   .
EXPORT DELIMITER "|" 
    "ประเภทงาน  "   
    "Marketing      "   
    "Agreement No.  "   
    "วันที่รับแจ้ง  "   
    "ประเภทประกัน   " 
    "Type of Garage "
    "กรมธรรม์ เลขที่"   
    "พรบ.เลขที่     "   
    "เลขที่รับแจ้ง  "   
    "ผู้รับแจ้ง     "   
    "เวลาแจ้งงาน    "   
    "ชื่อผู้เอาประกันภัย "
    "ID. Card No.        "
    "เลขทะเบียนการค้า(ภพ.20)   "
    "ออกใบเสร็จ/ใบกำกับภาษีในนาม   "
    "เลขประจำตัวผู้เสียภาษี13หลัก  "
    "สาขา  "
    "ที่อยู่ในการออกใบเสร็จ/ใบกำกับภาษี "
    "ที่อยู่ในการจัดส่งเอกสาร     "
    "ทุนประกัน       " 
    "เบี้ยประกันสุทธิ" 
    "เบี้ยประกันรวม  " 
    "เบี้ยพรบ สุทธิ  " 
    "เบี้ยพรบ รวม    " 
    "ยี่ห้อรถ + รุ่น   " 
    "ปี  " 
    "สี  " 
    "เลขทะเบียน      " 
    "จังหวัด         " 
    "ขนาดเครื่องยนต์ " 
    "เลขเครื่องยนต์  " 
    "เลขตัวถัง       " 
    "อุปกรณ์ตกแต่งเพิ่มเติม       "
    "อุปกรณ์ตกแต่งเพิ่มเติมราคา   "
    "แถม/ไม่แถม ประกันภัย "
    "แถม/ไม่แถม พรบ. "
    "ชื่อ Dealer          "
    "ชื่อ-นามสกุล ผู้ขับขี่1      "
    "วัน/เดือน/ปี เกิด ผู้ขับขี่1 " /*A60-0263*/
    "เลขที่ใบขับขี่ผู้ขับขี่1     "
    "ชื่อ-นามสกุล ผู้ขับขี่2      "
    "วัน/เดือน/ปี เกิด ผู้ขับขี่2 " 
    "เลขที่ใบขับขี่ ผู้ขับขี่2 "   
    "วันที่คุ้มครอง     "                
    "วันสิ้นสุดคุ้มครอง "                
    "ผู้รับผลประโยชน์   "                
    "รหัสรถยนต์   "                
    "Pack         "                
    "Producer     "                
    "Agent        "                
    "Branch       "                
    "Vat Code     "                
    "Campaign     "                
    "Inspection   "
    "อาชีพ        " 
    .

loop_tlt:
For each tlt Use-index  tlt01 Where
            tlt.trndat   >=  fi_trndatfr   And
            tlt.trndat   <=  fi_trndatto   And
            tlt.genusr    =  "ORICO"       AND 
            tlt.flag      <> "COMP"        no-lock. 
    IF cb_report = "New" THEN DO:                                              
        IF tlt.flag      =  "R"  THEN NEXT.
    END.
    ELSE IF   cb_report =  "Renew"  THEN DO:
        IF tlt.flag      =  "N"  THEN NEXT.
    END.
    ELSE IF cb_report = "สาขา" THEN DO:
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
    ELSE IF cb_report = "Confirm แล้ว" THEN DO:
        IF brstat.tlt.recac = "" THEN NEXT.
    END.
    ELSE IF cb_report = "ยังไม่ Confirm"   THEN DO:
        IF brstat.tlt.recac = "Confirm แล้ว" THEN NEXT.
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
        n_comdat70 = IF tlt.gendat <> ? THEN STRING(tlt.gendat,"99/99/9999") ELSE ""                              /*วันที่เริ่มคุ้มครอง     */         
        n_expdat70 = IF tlt.expodat <> ? THEN STRING(tlt.expodat,"99/99/9999") ELSE ""                            /*วันที่สิ้นสุดคุ้มครอง   */ 
        n_bdate1   = IF (tlt.dri_no1 <> "" AND tlt.dri_no1 <> ? ) THEN TRIM(tlt.dri_no1) ELSE ""   /*วันเดือนปีเกิด1         */                                                                                    
        n_bdate2   = IF (tlt.dri_no2 <> "" AND tlt.dri_no2 <> ? ) THEN TRIM(tlt.dri_no2) ELSE ""   /*วันเดือนปีเกิด2         */
        n_benname  = trim(SUBSTR(tlt.safe1,1,R-INDEX(tlt.safe1,"Delear:") - 1))                        
        n_delear   = IF tlt.flag = "N" THEN trim(SUBSTR(tlt.safe1,R-INDEX(tlt.safe1,"Delear:") + 7,length(tlt.safe1))) ELSE "" .
    IF brstat.tlt.nor_usr_tlt <> "" AND TRIM(brstat.tlt.nor_usr_tlt) <> "TAX: ID: BR:" THEN DO:
        ASSIGN
            n_char       = trim(brstat.tlt.nor_usr_tlt)
            n_length     = LENGTH(n_char)
            n_brantax    = IF INDEX(n_char,"BR:") <> 0 THEN trim(SUBSTR(n_char,R-INDEX(n_char,"BR:"),n_length)) ELSE ""   /*สาขา*/
            n_char       = IF INDEX(n_char,"BR:") <> 0 THEN SUBSTR(n_char,1,INDEX(n_char,"BR:")) ELSE SUBSTR(n_char,1,n_length) 
            n_length     = LENGTH(n_char)
            n_taxno      = IF INDEX(n_char,"ID:") <> 0 THEN trim(SUBSTR(n_char,R-INDEX(n_char,"ID:"),n_length)) ELSE ""    /*เลขที่ผู้เสียภาษี */
            n_saleid     = IF INDEX(n_char,"TAX:") <> 0 THEN trim(SUBSTR(n_char,1,INDEX(n_char,"ID:"))) ELSE ""       /*เลขที่จดทะเบียน          */
            n_saleid     = if n_saleid    <> "TAX:" then  substr(n_saleid,5,(LENGTH(n_saleid) - 5 ))  else ""
            n_taxno      = if n_taxno     <> "ID:"  then  substr(n_taxno,4,(LENGTH(n_taxno) - 5 ))  else ""
            n_brantax    = if n_brantax   <> "BR:"  then  substr(n_brantax,4,LENGTH(n_brantax))   else ""  .
    END.
    ELSE  ASSIGN  n_saleid    = ""    n_taxno = ""   n_brantax = "".

    IF brstat.tlt.dri_name1 <> "" AND TRIM(brstat.tlt.dri_name1) <> "ID1:" THEN DO:
      ASSIGN
        n_char        = trim(brstat.tlt.dri_name1) /* ผู้ขับขี่ 1 */
        n_length      = LENGTH(n_char)
        n_driv1      = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"ID1:") - 1))         /*ระบุผู้ขับขี้1    */  
        n_drivid1    = TRIM(SUBSTR(n_char,R-INDEX(n_char,"ID1:") + 4,n_length)).  /*เลขที่ใบขับขี่1   */ 
    END.
    ELSE ASSIGN n_drivid1   = ""     n_driv1     = "" .
    
    IF brstat.tlt.dri_name2 <> "" AND TRIM(brstat.tlt.dri_name2) <> "ID2:"THEN DO:
      ASSIGN 
        n_char        = trim(brstat.tlt.dri_name2)  /*ผู้ขับขี่ 2*/ 
        n_length      = LENGTH(n_char)
        n_driv2      = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"ID2:") - 1))          /*ระบุผู้ขับขี้2      */  
        n_drivid2    = TRIM(SUBSTR(n_char,R-INDEX(n_char,"ID2:") + 4,n_length)).   /*เลขที่ใบขับขี่2     */ 
    END.
    ELSE  ASSIGN n_drivid2   = ""     n_driv2     = "" . 

    EXPORT DELIMITER "|"                                               
    IF tlt.flag = "N" THEN "NEW" ELSE "RENEW"  /*ประเภทงาน          */
    brstat.tlt.filler2                         /* Marketing            */
    brstat.tlt.safe2                           /* Agreement No.        */
    brstat.tlt.datesent                        /* วันที่รับแจ้ง        */
    brstat.tlt.comp_usr_tlt                    /* ประเภทประกัน         */
    brstat.tlt.stat                            /*Type of Garage       */   
    brstat.tlt.filler1                         /* กรมธรรม์ เลขที่      */
    brstat.tlt.comp_pol                        /* พรบ.เลขที่           */
    brstat.tlt.nor_noti_tlt                    /* เลขที่รับแจ้ง        */
    brstat.tlt.nor_usr_ins                     /* ผู้รับแจ้ง           */
    brstat.tlt.trntim                          /* เวลาแจ้งงาน          */
    brstat.tlt.ins_name                        /* ชื่อผู้เอาประกันภัย  */
    brstat.tlt.ins_addr5                       /* ID. Card No.         */
    n_saleid                                   /* เลขทะเบียนการค้า(ภพ.20)               */   
    brstat.tlt.rec_addr2                       /*ออกใบเสร็จ/ใบกำกับภาษีในนาม            */   
    n_taxno                                    /*เลขประจำตัวผู้เสียภาษี13หลัก           */   
    n_brantax                                  /*สาขา                                   */   
    brstat.tlt.rec_addr5                       /*ที่อยู่ในการออกใบเสร็จ/ใบกำกับภาษี     */   
    brstat.tlt.ins_addr1 + " " + brstat.tlt.ins_addr2 + " " + brstat.tlt.ins_addr3 + " " + brstat.tlt.ins_addr4 /*ที่อยู่ในการจัดส่งเอกสาร               */   
    string(brstat.tlt.nor_coamt)               /*ทุนประกัน            */   
    string(brstat.tlt.nor_grprm)               /*เบี้ยประกันสุทธิ     */   
    string(brstat.tlt.comp_coamt)              /*เบี้ยประกันรวม       */   
    STRING(DECI(brstat.tlt.rec_addr4))         /*เบี้ยพรบ สุทธิ       */   
    string(brstat.tlt.comp_grprm)              /*เบี้ยพรบ รวม         */   
    brstat.tlt.brand + " " + brstat.tlt.model  /*ยี่ห้อรถ+รุ่น        */   
    brstat.tlt.lince2                          /*ปี                   */   
    brstat.tlt.colorcod                        /*สี                   */   
    brstat.tlt.lince1                          /*เลขทะเบียน           */   
    brstat.tlt.lince3                          /*จังหวัด              */   
    brstat.tlt.cc_weight                       /*ขนาดเครื่องยนต์      */   
    brstat.tlt.eng_no                          /*เลขเครื่องยนต์       */   
    brstat.tlt.cha_no                          /*เลขตัวถัง            */   
    IF trim(brstat.tlt.old_cha) <> "PRICE:" THEN substr(brstat.tlt.old_cha,R-INDEX(brstat.tlt.old_cha,"PRICE:") + 6)  ELSE ""  /*อุปกรณ์ตกแต่งเพิ่มเติม    */   
    IF trim(brstat.tlt.old_cha) <> "PRICE:" THEN substr(brstat.tlt.old_cha,1,INDEX(brstat.tlt.old_cha,"PRICE:") - 2)  ELSE ""  /*อุปกรณ์ตกแต่งเพิ่มเติมราคา*/   
    brstat.tlt.expousr                         /*แถม/ไม่แถม ประกันภัย */                                                                                   
    brstat.tlt.OLD_eng                         /*แถม/ไม่แถม พรบ. */                                                                                     
    IF trim(brstat.tlt.safe1) <> "Delear:" THEN trim(SUBSTR(brstat.tlt.safe1,R-INDEX(brstat.tlt.safe1,"Delear:") + 7,n_length)) ELSE "" /*ชื่อ Dealer     */    
    n_driv1                                   /*ชื่อ-นามสกุล ผู้ขับขี่1        */                                                                          
    n_bdate1                                  /*วัน/เดือน/ปี เกิด ผู้ขับขี่1   */   
    n_drivid1                                 /*เลขที่ใบขับขี่ผู้ขับขี่1       */   
    n_driv2                                   /*ชื่อ-นามสกุล ผู้ขับขี่2        */   
    n_bdate2                                  /*วัน/เดือน/ปี เกิด ผู้ขับขี่2   */   
    n_drivid2                                 /*เลขที่ใบขับขี่ ผู้ขับขี่2      */   
    brstat.tlt.gendat                         /*วันที่คุ้มครอง                 */   
    brstat.tlt.expodat                        /*วันสิ้นสุดคุ้มครอง             */   
    IF trim(brstat.tlt.safe1) <> "Delear:" THEN trim(SUBSTR(brstat.tlt.safe1,1,R-INDEX(brstat.tlt.safe1,"Delear:") - 1)) ELSE "" /*ผู้รับผลประโยชน์ */   
    IF trim(brstat.tlt.safe3) <> "" THEN SUBSTR(brstat.tlt.safe3,2,3) ELSE "" /*รหัสรถยนต์  */   
    IF trim(brstat.tlt.safe3) <> "" THEN SUBSTR(brstat.tlt.safe3,1,1) ELSE "" /*Pack        */   
    brstat.tlt.comp_sub                       /*Producer    */   
    brstat.tlt.comp_noti_ins                  /*Agent       */   
    brstat.tlt.exp                            /*Branch      */   
    brstat.tlt.rec_addr1                      /*Vat Code    */   
    brstat.tlt.lotno                          /*Campaign    */   
    brstat.tlt.rec_addr3                      /*Inspection  */ 
    brstat.tlt.recac                          /*อาชีพ */
    brstat.tlt.releas.                       /*การออกงาน   */ 
END.                                                                   
OUTPUT   CLOSE.  
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
/*ASSIGN nv_cnt =  0.*/
OUTPUT TO VALUE(nv_filemat).
EXPORT DELIMITER "|" 
    "Type. "   
    "Marketing      "   
    "Agreement No.  "   
    "วันที่รับแจ้ง  "   
    "ประเภทประกัน   "
    "Type of Garage       "
    "เบอร์กรมธรรม์เดิม "
    "กรมธรรม์ เลขที่"   
    "พรบ.เลขที่     "   
    "เลขที่รับแจ้ง  "   
    "ผู้รับแจ้ง     "   
    "เวลาแจ้งงาน    "   
    "ชื่อผู้เอาประกันภัย "
    "ID. Card No.        "
    "เลขทะเบียนการค้า(ภพ.20)   "
    "ออกใบเสร็จ/ใบกำกับภาษีในนาม   "
    "เลขประจำตัวผู้เสียภาษี13หลัก  "
    "สาขา  "
    "ที่อยู่ในการออกใบเสร็จ/ใบกำกับภาษี "
    "ที่อยู่ในการจัดส่งเอกสาร     "
    "ทุนประกัน       " 
    "เบี้ยประกันสุทธิ" 
    "เบี้ยประกันรวม  " 
    "เบี้ยพรบ สุทธิ  " 
    "เบี้ยพรบ รวม    " 
    "ยี่ห้อรถ        " 
    "รุ่นรถ         "       /*A61-0221 */
    "ปี  " 
    "สี  " 
    "เลขทะเบียน      " 
    "จังหวัด         " 
    "ขนาดเครื่องยนต์ " 
    "เลขเครื่องยนต์  " 
    "เลขตัวถัง       " 
    "อุปกรณ์ตกแต่งเพิ่มเติม       "
    "อุปกรณ์ตกแต่งเพิ่มเติมราคา   "
    "แถม/ไม่แถม ประกันภัย "
    "แถม/ไม่แถม พรบ. "
    "ชื่อ Dealer          "
    "ชื่อ-นามสกุล ผู้ขับขี่1      "
    "วัน/เดือน/ปี เกิด ผู้ขับขี่1 " /*A60-0263*/
    "เลขที่ใบขับขี่ผู้ขับขี่1     "
    "ชื่อ-นามสกุล ผู้ขับขี่2      "
    "วัน/เดือน/ปี เกิด ผู้ขับขี่2 " 
    "เลขที่ใบขับขี่ ผู้ขับขี่2 "   
    "วันที่คุ้มครอง     "                
    "วันสิ้นสุดคุ้มครอง "                
    "ผู้รับผลประโยชน์   "                
    "รหัสรถยนต์   "                
    "Pack         "                
    "Producer     "                
    "Agent        "                
    "Branch       "                
    "Vat Code     "                
    "Campaign     "                
    "Inspection   " 
    "อาชีพ        "
    "รายการความเสียหาย"
    "  "
     .

FOR EACH wdetail WHERE wdetail.n_no <> "" .
    RUN proc_cutpol.
    RUN proc_cutchar.
    FIND LAST brstat.tlt USE-INDEX tlt06 WHERE brstat.tlt.cha_no    = trim(wdetail.chassis) AND
                                               brstat.tlt.nor_noti_tlt  = TRIM(wdetail.safe_no) AND
                                               brstat.tlt.genusr    = "ORICO"  AND 
                                               brstat.tlt.flag     <> "COMP"  AND  /*A62-0454*/
                                               brstat.tlt.RELEAS    = "NO" NO-ERROR NO-WAIT. 
    IF AVAIL brstat.tlt THEN DO:
        ASSIGN  wdetail.n_class    = IF trim(brstat.tlt.safe3) <> "" THEN SUBSTR(brstat.tlt.safe3,2,3) ELSE "" /*รหัสรถยนต์  */   
                wdetail.pack       = IF trim(brstat.tlt.safe3) <> "" THEN SUBSTR(brstat.tlt.safe3,1,1) ELSE "" /*Pack        */   
                wdetail.producer   = brstat.tlt.comp_sub                                                       /*Producer    */   
                wdetail.agent      = brstat.tlt.comp_noti_ins                                                  /*Agent       */   
                wdetail.branch_saf = brstat.tlt.exp                                                            /*Branch      */   
                wdetail.vatcode    = brstat.tlt.rec_addr1                                                      /*Vat Code    */   
                wdetail.campaign   = brstat.tlt.lotno                                                          /*Campaign    */   
                wdetail.inspect    = brstat.tlt.rec_addr3                                                     /*Inspection  */ 
                wdetail.occup      = brstat.tlt.recac  
                wdetail.prevpol    = brstat.tlt.filler1 
                wdetail.n_no       = brstat.tlt.flag        /* ประเภทงาน */ /*A62-0219*/
                wdetail.inspdetail = trim(brstat.tlt.note1)   .   /* Add A66-0107 */ 

       /*IF brstat.tlt.flag = "N" THEN */ RUN proc_polrunning . /*a62-0219*/

        ASSIGN  brstat.tlt.EXP    = trim(wdetail.branch_saf). /*a62-0219*/

    END.
    ELSE DO: 
        ASSIGN  wdetail.n_class    = "" 
                wdetail.pack       = ""
                wdetail.producer   = ""
                wdetail.agent      = ""
                wdetail.branch_saf = ""
                wdetail.vatcode    = ""
                wdetail.campaign   = ""
                wdetail.inspect    = "" 
                wdetail.occup      = ""
                wdetail.inspdetail = ""
            .
    END.
   /* nv_cnt = nv_cnt + 1*/
    
    EXPORT DELIMITER "|"                                               
                wdetail.n_no                        /*No.                                 */     
                wdetail.Remark                      /*Marketing                           */     
                wdetail.Account_no                  /*Agreement No.                       */     
                wdetail.RegisDate                   /*วันที่รับแจ้ง                       */     
                wdetail.CovTyp                      /*ประเภทประกัน                        */
                wdetail.garage                      /*Type of Garage                      */ 
                wdetail.prevpol                     /*กรมธรรม์ เลขที่                     */
                wdetail.policy                     /* เบอร์กรมใหม่ */       /*A62-0219*/
                wdetail.compno                      /*พรบ.เลขที่                          */     
                wdetail.safe_no                     /*เลขที่รับแจ้ง                       */     
                wdetail.CMRName                     /*ผู้รับแจ้ง                          */     
                wdetail.not_time                    /*เวลาแจ้งงาน                         */     
                wdetail.name_insur                  /*ชื่อผู้เอาประกันภัย                 */     
                wdetail.icno                        /*ID. Card No.                        */     
                wdetail.saleid                      /*เลขทะเบียนการค้า(ภพ.20)             */     
                wdetail.taxname                     /*ออกใบเสร็จ/ใบกำกับภาษีในนาม         */     
                wdetail.taxno                       /*เลขประจำตัวผู้เสียภาษี13หลัก        */     
                wdetail.branch                      /*สาขา                                */     
                wdetail.pol_addr1                   /*ที่อยู่ในการออกใบเสร็จ/ใบกำกับภาษี  */     
                wdetail.CustAddress                 /*ที่อยู่ในการจัดส่งเอกสาร            */     
                wdetail.SI                          /*ทุนประกัน                           */     
                wdetail.netprem                     /*เบี้ยประกันสุทธิ                    */     
                wdetail.totalprem                   /*เบี้ยประกันรวม                      */     
                wdetail.comp_prm                    /*เบี้ยพรบ สุทธิ                      */     
                wdetail.comp_prmtotal               /*เบี้ยพรบ รวม                        */ 
                wdetail.brand                       /*ยี่ห้อ                                */ /*A61-0221*/
                wdetail.Brand_Model                 /*รุ่น                       */     
                wdetail.yrmanu                      /*ปี                                  */     
                wdetail.n_color                     /*สี                                  */     
                wdetail.RegisNo                     /*เลขทะเบียน                          */     
                wdetail.RegisProv                   /*จังหวัด                             */     
                wdetail.CC                          /*ขนาดเครื่องยนต์                     */     
                wdetail.engine                      /*เลขเครื่องยนต์                      */     
                wdetail.chassis                     /*เลขตัวถัง                           */     
                wdetail.accsor                      /*อุปกรณ์ตกแต่งเพิ่มเติม              */     
                wdetail.accsor_price                /*อุปกรณ์ตกแต่งเพิ่มเติมราคา          */     
                wdetail.InsTyp                      /*แถม/ไม่แถม ประกันภัย                */     
                wdetail.comTyp                      /*แถม/ไม่แถม พรบ.                     */      
                wdetail.DealerName                  /*ชื่อ Dealer                         */     
                wdetail.drivname1                   /*ชื่อ-นามสกุล ผู้ขับขี่1             */     
                wdetail.drivdate1                   /*วัน/เดือน/ปี เกิด ผู้ขับขี่1        */     
                wdetail.drivid1                     /*เลขที่ใบขับขี่ผู้ขับขี่1            */     
                wdetail.drivname2                   /*ชื่อ-นามสกุล ผู้ขับขี่2             */     
                wdetail.drivdate2                   /*วัน/เดือน/ปี เกิด ผู้ขับขี่2        */     
                wdetail.drivid2                     /*เลขที่ใบขับขี่ ผู้ขับขี่2           */     
                string(date(wdetail.comdat),"99/99/9999")          /*วันที่คุ้มครอง                      */     
                string(date(wdetail.expdat),"99/99/9999")          /*วันสิ้นสุดคุ้มครอง                  */     
                wdetail.ben_name                    /*ผู้รับผลประโยชน์                    */   
                wdetail.n_class                     /*รหัสรถยนต์                          */   
                wdetail.pack                        /*Pack                                */     
                wdetail.producer                    /*Producer                            */     
                wdetail.agent                       /*Agent                               */     
                wdetail.branch_saf                  /*Branch                              */     
                wdetail.vatcode                     /*Vat Code                            */     
                wdetail.campaign                    /*Campaign                            */     
                wdetail.inspect                     /*Inspection                          */ 
                wdetail.occup 
                wdetail.inspdetail     /*damagelist */ 
                wdetail.comment       /*A62-0219*/    
                .
END.                                                                   
OUTPUT   CLOSE.  

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_matchcomp c-wins 
PROCEDURE proc_matchcomp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO:
     FOR EACH  wdetail :                                                                          
         DELETE  wdetail.                                                                         
     END.                                                                                         
     INPUT FROM VALUE(fi_match).                                                               
     REPEAT:                                                                                      
         CREATE wdetail.                                                                          
         IMPORT DELIMITER "|"  
         wdetail.n_no                       /*No                     */ 
         wdetail.safe_no                    /*เลขที่กรมธรรม์         */ 
         wdetail.sckno                      /*เลขเครื่องหมาย         */ 
         wdetail.name_insur                 /*ชื่อผู้เอาประกัน       */ 
         wdetail.CustAddress                /*ที่อยู่                */ 
         wdetail.comdat                     /*วันเริ่มคุ้มครอง/เวลา  */ 
         wdetail.expdat                     /*วันสิ้นสุด             */ 
         wdetail.n_class                    /*รหัส                   */ 
         wdetail.Brand_Model                /*รุ่นรถ                 */ 
         wdetail.RegisNo                    /*ทะเบียนรถ              */ 
         wdetail.chassis                    /*เลขตัวถัง              */ 
         wdetail.comtyp                     /*ประเภท                 */ 
         wdetail.CC                         /*ขนาดเครื่องยนต์        */ 
         wdetail.engine                     /*เลขเครื่องยนต์         */ 
         wdetail.yrmanu                     /*ปีจดทะเบียน            */ 
         wdetail.comp_prm                   /*เบี้ยสุทธิ             */ 
         wdetail.netprem                    /*อากร                   */ 
         wdetail.totalprem                  /*ภาษี                   */ 
         wdetail.comp_prmtotal              /*เบี้ยรวมภาษีอากร       */ 
         wdetail.CovTyp                   /*การใช้รถ               */ 
         wdetail.RegisDate                  /*วันออกกรมธรรม์         */ 
         wdetail.account_no                 /*เลขที่สัญญา            */  
         wdetail.icno        .              /*ID Card                */ 

         IF INDEX(wdetail.n_no,"No")   <> 0 THEN  DELETE wdetail.                                 
         ELSE IF  wdetail.n_no         = "" THEN  DELETE wdetail.                                 
     END.  /* repeat  */ 
     RUN pd_filecomp.
     Message "Export data Complete"  View-as alert-box.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_matchpol c-wins 
PROCEDURE proc_matchpol :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO:
     FOR EACH  wdetail :                                                                          
            DELETE  wdetail.                                                                         
        END.                                                                                         
        INPUT FROM VALUE(fi_match).                                                               
        REPEAT:                                                                                      
            CREATE wdetail.                                                                          
            IMPORT DELIMITER "|"                                                                     
                wdetail.n_no                        /*No.                     */     
                wdetail.Remark                      /*Marketing               */     
                wdetail.Account_no                  /*Agreement No.           */     
                wdetail.RegisDate                   /*วันที่รับแจ้ง           */
                wdetail.CovTyp                      /*ประเภทประกัน            */  
                wdetail.garage                      /*Type of Garage          */ 
                wdetail.prevpol                     /*กรมธรรม์ เลขที่         */     
                wdetail.compno                      /*พรบ.เลขที่              */     
                wdetail.safe_no                     /*เลขที่รับแจ้ง           */     
                wdetail.CMRName                     /*ผู้รับแจ้ง              */     
                wdetail.not_time                    /*เวลาแจ้งงาน             */     
                wdetail.name_insur                  /*ชื่อผู้เอาประกันภัย     */     
                wdetail.icno                        /*ID. Card No.            */     
                wdetail.saleid                      /*เลขทะเบียนการค้า(ภพ.20) */     
                wdetail.taxname                     /*ออกใบเสร็จ/ใบกำกับภาษีในนาม  */     
                wdetail.taxno                       /*เลขประจำตัวผู้เสียภาษี13หลัก */     
                wdetail.branch                      /*สาขา      */     
                wdetail.pol_addr1                   /*ที่อยู่ในการออกใบเสร็จ/ใบกำกับภาษี  */     
                wdetail.CustAddress                 /*ที่อยู่ในการจัดส่งเอกสาร  */     
                wdetail.SI                          /*ทุนประกัน          */     
                wdetail.netprem                     /*เบี้ยประกันสุทธิ   */     
                wdetail.totalprem                   /*เบี้ยประกันรวม     */     
                wdetail.comp_prm                    /*เบี้ยพรบ สุทธิ     */     
                wdetail.comp_prmtotal               /*เบี้ยพรบ รวม       */ 
                wdetail.brand                       /* ยี่ห้อ            */ /* A61-0221 */
                wdetail.Brand_Model                 /*รุ่น               */     
                wdetail.yrmanu                      /*ปี                 */     
                wdetail.n_color                     /*สี                 */     
                wdetail.RegisNo                     /*เลขทะเบียน         */     
                wdetail.RegisProv                   /*จังหวัด            */     
                wdetail.CC                          /*ขนาดเครื่องยนต์    */     
                wdetail.engine                      /*เลขเครื่องยนต์     */     
                wdetail.chassis                     /*เลขตัวถัง          */     
                wdetail.accsor                      /*อุปกรณ์ตกแต่งเพิ่มเติม       */     
                wdetail.accsor_price                /*อุปกรณ์ตกแต่งเพิ่มเติมราคา   */     
                wdetail.InsTyp                      /*แถม/ไม่แถม ประกันภัย         */     
                wdetail.comtyp                      /*แถม/ไม่แถม พรบ.              */   
                wdetail.DealerName                  /*ชื่อ Dealer                  */     
                wdetail.drivname1                   /*ชื่อ-นามสกุล ผู้ขับขี่1      */     
                wdetail.drivdate1                   /*วัน/เดือน/ปี เกิด ผู้ขับขี่1 */     
                wdetail.drivid1                     /*เลขที่ใบขับขี่ผู้ขับขี่1     */     
                wdetail.drivname2                   /*ชื่อ-นามสกุล ผู้ขับขี่2      */     
                wdetail.drivdate2                   /*วัน/เดือน/ปี เกิด ผู้ขับขี่2 */     
                wdetail.drivid2                     /*เลขที่ใบขับขี่ ผู้ขับขี่2    */     
                wdetail.comdat                      /*วันที่คุ้มครอง     */     
                wdetail.expdat                      /*วันสิ้นสุดคุ้มครอง */     
                wdetail.ben_name                    /*ผู้รับผลประโยชน์   */   
                wdetail.n_class.                    /*รหัสรถยนต์   */   
                /*wdetail.pack                      /*Pack         */     
                wdetail.producer                    /*Producer     */     
                wdetail.agent                       /*Agent        */     
                wdetail.branch_saf                  /*Branch       */     
                wdetail.vatcode                     /*Vat Code     */     
                wdetail.campaign                    /*Campaign     */     
                wdetail.inspect.  */                /*Inspection   */   
                                                                                                 
            IF INDEX(wdetail.n_no,"No")   <> 0 THEN  DELETE wdetail.                                 
            ELSE IF  wdetail.n_no         = "" THEN  DELETE wdetail.                                 
        END.  /* repeat  */ 
        RUN pd_reportfileload.
        Message "Export data Complete"  View-as alert-box.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_polrunning c-wins 
PROCEDURE proc_polrunning :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR n_branch AS CHAR .
DO:
 /*------- check Branch -------------*/
  FIND LAST brstat.insure USE-INDEX insure03 WHERE 
                insure.compno = "ORICO"   AND
                insure.branch = TRIM(wdetail.branch) NO-LOCK NO-ERROR .
      IF AVAIL insure THEN DO:
          ASSIGN wdetail.branch_saf = trim(Insure.FName)
                 n_branch = trim(Insure.FName)
                 n_branch = IF LENGTH(n_branch) = 1 THEN "D" + TRIM(n_branch) ELSE TRIM(n_branch) .
      END.
      ELSE DO:
          n_branch = "" .
          MESSAGE "ไม่พบสาขา " + TRIM(wdetail.branch) + "ในระบบพารามิเตอร์ของ ORICO " VIEW-AS ALERT-BOX.
          ASSIGN wdetail.comment = wdetail.comment + "|" + "กรุณาตรวจสอบข้อมูลสาขาในไฟล์แจ้งงานอีกครั้ง".
      END.

  /* เช็คเบอร์กรมธรรม์ในระบบ กับไฟล์ */
  IF wdetail.safe_no <> "" THEN DO:
      nv_check70 = SUBSTR(wdetail.safe_no,1,2).

      IF trim(nv_check70) = trim(n_branch) THEN DO:  /* สาขากับเบอร์ตรงกัน */
        FIND LAST sicsyac.xmm023  USE-INDEX xmm02301 WHERE 
                 (xmm023.branch         = nv_check70) OR 
                 (("D" + xmm023.branch) = nv_check70) NO-LOCK NO-ERROR.
        IF AVAIL sicsyac.xmm023 THEN DO:
             FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE 
                       sicuw.uwm100.policy = trim(wdetail.safe_no) NO-LOCK NO-ERROR.
             IF NOT AVAIL sicuw.uwm100 THEN DO:
                 FIND LAST  bftlt    WHERE 
                    (bftlt.genusr   = "Phone"  OR 
                     bftlt.genusr   = "FAX" )  AND
                     bftlt.policy   = trim(wdetail.safe_no)  NO-LOCK NO-ERROR NO-WAIT.
                 IF NOT AVAIL bftlt THEN DO: 
                   ASSIGN brstat.tlt.nor_noti_ins = trim(wdetail.safe_no)
                          wdetail.policy          = trim(wdetail.safe_no)
                          wdetail.comment         = "COMPLETE".
                 END.
                 ELSE DO:
                     ASSIGN wdetail.comment = wdetail.comment + "|" + wdetail.safe_no + " มีข้อมูลในระบบ Phone/FAX ".
                 END.
             END.  
             ELSE DO:
                 ASSIGN wdetail.comment = wdetail.comment + "|" + wdetail.safe_no + " มีข้อมูลในระบบพรีเมียมแล้ว".
             END.
        END.
      END.
  END.
  
  /* running policy no */
  IF wdetail.policy = "" AND wdetail.comment = " " THEN DO:
      ASSIGN n_br    = "".
      FIND FIRST brstat.company WHERE Company.CompNo = "ORICO" NO-LOCK NO-ERROR NO-WAIT.
      IF NOT AVAIL company THEN 
          MESSAGE "Not fond Company code[n_br ไม่พบอักษรหลังปี]...!!!" "ORICO"      SKIP
          "Plese Set up Company code. !!!"  VIEW-AS ALERT-BOX.
      ELSE DO:
          ASSIGN  
              n_br   = Company.AbName 
              nv_notno70 = ""
              n_poltyp   = "V70"
              nv_brnpol  = trim(wdetail.branch_saf) + n_br
              n_undyr2   = string(YEAR(TODAY)) .
          running_polno:    /*--Running 70 */
          REPEAT:
              RUN  wgw\wgwpon03(INPUT    YES,  
                                INPUT    n_poltyp,
                                INPUT    nv_brnpol,
                                INPUT    string(n_undyr2),
                                INPUT    brstat.tlt.comp_sub,
                                INPUT-OUTPUT nv_notno70,
                                INPUT-OUTPUT nv_check).
              IF nv_notno70 = "" THEN LEAVE running_polno.
              ELSE DO:
                  FIND LAST  bftlt    WHERE 
                     (bftlt.genusr   = "Phone"  OR 
                      bftlt.genusr   = "FAX" )  AND
                      bftlt.policy   = caps(nv_notno70)  NO-LOCK NO-ERROR NO-WAIT.
                  IF NOT AVAIL bftlt THEN DO:  
                      FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE 
                          sicuw.uwm100.policy = nv_notno70 NO-LOCK NO-ERROR.
                      IF NOT AVAIL sicuw.uwm100 THEN DO: 
                          LEAVE running_polno.
                      END.
                      ELSE NEXT running_polno.
                  END.
                  ELSE DO: 
                      NEXT running_polno.
                  END.
                  RELEASE bftlt.
              END.
              LEAVE running_polno.
          END.
          ASSIGN   wdetail.policy         = CAPS(nv_notno70) 
                   brstat.tlt.nor_noti_ins = CAPS(nv_notno70).
      END. /* end else */
  END. /* wdetail.prevpol */
  /*  running V72 */
  IF deci(wdetail.comp_prm) <>  0 AND wdetail.comment = " " THEN DO:

     IF brstat.tlt.comp_pol <> "" THEN DO: 
        nv_check72 = SUBSTR(brstat.tlt.comp_pol,1,2).
        IF trim(nv_check70) = trim(n_branch) THEN DO:  /* สาขากับเบอร์ตรงกัน */
            FIND LAST sicsyac.xmm023 WHERE 
                ("D" + xmm023.branch = nv_check72) OR 
                (xmm023.branch       = nv_check72) NO-LOCK NO-ERROR.
            IF AVAIL sicsyac.xmm023 THEN DO:
                FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE 
                          sicuw.uwm100.policy = trim(brstat.tlt.comp_pol) NO-LOCK NO-ERROR.
                IF NOT AVAIL sicuw.uwm100 THEN DO: 
                    FIND LAST  bftlt    WHERE 
                      (bftlt.genusr   = "Phone"  OR 
                       bftlt.genusr   = "FAX" )  AND
                       bftlt.policy   = trim(brstat.tlt.comp_pol)  NO-LOCK NO-ERROR NO-WAIT.
                   IF NOT AVAIL bftlt THEN DO: 
                       ASSIGN wdetail.compno = brstat.tlt.comp_pol.
                   END.
                   ELSE DO:
                       ASSIGN wdetail.comment = wdetail.comment + "|" + wdetail.compno + " มีข้อมูลในระบบ Phone/FAX ".
                   END.
                END.
                ELSE DO:
                    ASSIGN wdetail.comment = wdetail.comment + "|" + brstat.tlt.comp_pol + " มีข้อมูลในระบบพรีเมียมแล้ว".
                END.
            END.
        END.
     END.

     IF wdetail.compno = "" AND wdetail.comment = " " THEN DO:
         ASSIGN
              nv_notno72 = ""
              n_poltyp   = "V72"
              nv_brnpol  = trim(wdetail.branch_saf) + n_br
              n_undyr2   = string(YEAR(TODAY)) .
          running_polno2:   /*--Running Line 72--*/
          REPEAT:
              RUN  wgw\wgwpon03(INPUT        YES,  
                                INPUT        n_poltyp,
                                INPUT        nv_brnpol,
                                INPUT        string(n_undyr2),
                                INPUT        brstat.tlt.comp_sub,
                                INPUT-OUTPUT nv_notno72,
                                INPUT-OUTPUT nv_check). 
              IF nv_notno72 = "" THEN LEAVE running_polno2 .
              ELSE DO:   /*LEAVE running_polno2 .*/
                  FIND LAST  bftlt    WHERE
                      (bftlt.genusr   = "Phone"    OR
                       bftlt.genusr   = "FAX"  )   AND
                       bftlt.comp_pol = trim(nv_notno72) NO-LOCK NO-ERROR NO-WAIT.
                  IF NOT AVAIL tlt THEN DO:
                      FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE 
                          sicuw.uwm100.policy = CAPS(nv_notno72) NO-LOCK NO-ERROR.
                      IF AVAIL sicuw.uwm100 THEN  NEXT running_polno2.
                      ELSE DO:
                          ASSIGN nv_notno72 = CAPS(nv_notno72).
                          LEAVE running_polno2 .
                      END.
                  END.
                  ELSE NEXT running_polno2.
              END. 
              LEAVE running_polno2 .
          END.
          ASSIGN wdetail.compno      = CAPS(nv_notno72)
                 brstat.tlt.comp_pol = CAPS(nv_notno72).
     END.
  END. /* wdetail. comp_pre <>  0 */ 
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
/*If  fi_polfr  =   "0"  Then  fi_polfr  =  " "  .*/
Open Query br_tlt 
    For each tlt Use-index  tlt01 Where
        tlt.trndat  >=  fi_trndatfr  And
        tlt.trndat  <=  fi_trndatto  And
        /*tlt.policy >=  fi_polfr      And
        tlt.policy <=  fi_polto     And*/
        /*  tlt.comp_sub  =  fi_producer  And*/
        tlt.genusr   =  "ORICO" NO-LOCK .
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
    /*For each tlt Use-index  tlt01 Where
                             tlt.trndat  >=  fi_trndatfr  And
                             tlt.trndat  <=  fi_trndatto  And
                             /*tlt.policy >=  fi_polfr      And
                             tlt.policy <=  fi_polto     And*/
                           /*  tlt.comp_sub  =  fi_producer  And*/
                             recid(tlt) = nv_rectlt        AND 
                             tlt.genusr   =  "ICBCTL"      no-lock.*/
    FOR EACH tlt Where Recid(tlt)  =  nv_rectlt NO-LOCK .
        ASSIGN nv_rectlt =  recid(tlt).   /*A57-0017*/
        
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

