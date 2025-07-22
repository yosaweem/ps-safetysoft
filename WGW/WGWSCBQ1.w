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
 create  by  : Ranu I. A63-0161 Query & Update flag detail  */
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
     FIELD policy        AS CHAR FORMAT "x(13)"  INIT "" . /*A62-0219*/

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
tlt.filler1 tlt.safe2 tlt.nor_noti_ins tlt.comp_pol tlt.ins_name tlt.cha_no ~
tlt.gendat tlt.expodat tlt.nor_coamt tlt.comp_sck tlt.comp_grprm ~
tlt.comp_coamt 
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_tlt 
&Scoped-define QUERY-STRING-br_tlt FOR EACH tlt NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-br_tlt OPEN QUERY br_tlt FOR EACH tlt NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-br_tlt tlt
&Scoped-define FIRST-TABLE-IN-QUERY-br_tlt tlt


/* Definitions for FRAME fr_main                                        */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS fi_emp bu_exit ra_status fi_trndatfr ~
fi_trndatto bu_ok cb_search bu_oksch br_tlt fi_search bu_update cb_report ~
fi_outfile bu_report bu_upyesno RECT-332 RECT-338 RECT-339 RECT-340 ~
RECT-341 RECT-381 RECT-342 
&Scoped-Define DISPLAYED-OBJECTS fi_emp ra_status fi_trndatfr fi_trndatto ~
cb_search fi_search fi_name cb_report fi_outfile 

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
     SIZE 10 BY 1.

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
     SIZE 35 BY 1
     BGCOLOR 10 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-332
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132.5 BY 8
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-338
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 58.5 BY 2.91
     BGCOLOR 21 .

DEFINE RECTANGLE RECT-339
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 71 BY 2.91
     BGCOLOR 18 .

DEFINE RECTANGLE RECT-340
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 130.5 BY 1.67
     BGCOLOR 1 .

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

DEFINE VARIABLE fi_emp AS LOGICAL INITIAL no 
     LABEL "DATA EMPIRE" 
     VIEW-AS TOGGLE-BOX
     SIZE 16.17 BY 1
     BGCOLOR 8  NO-UNDO.

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
      tlt.filler1 COLUMN-LABEL "Old Policy" FORMAT "x(20)":U WIDTH 15
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
     fi_emp AT ROW 6.1 COL 114.67 WIDGET-ID 2
     bu_exit AT ROW 1.57 COL 106.67
     ra_status AT ROW 6.05 COL 77.5 NO-LABEL
     fi_trndatfr AT ROW 1.67 COL 25.33 COLON-ALIGNED NO-LABEL
     fi_trndatto AT ROW 1.67 COL 61.5 COLON-ALIGNED NO-LABEL
     bu_ok AT ROW 1.57 COL 94.17
     cb_search AT ROW 3.19 COL 16.83 COLON-ALIGNED NO-LABEL
     bu_oksch AT ROW 4.52 COL 53.33
     br_tlt AT ROW 9.48 COL 1.33
     fi_search AT ROW 4.43 COL 3.67 NO-LABEL
     fi_name AT ROW 4.43 COL 61 COLON-ALIGNED NO-LABEL
     bu_update AT ROW 4.48 COL 102.83
     cb_report AT ROW 6.1 COL 16.33 COLON-ALIGNED NO-LABEL
     fi_outfile AT ROW 7.24 COL 27.5 NO-LABEL
     bu_report AT ROW 7.24 COL 104.67
     bu_upyesno AT ROW 4.48 COL 118
     "CLICK FOR UPDATE DATA FLAG CANCEL":40 VIEW-AS TEXT
          SIZE 41.5 BY .95 AT ROW 3.19 COL 63.33
          BGCOLOR 18 FGCOLOR 7 FONT 6
     "REPORT BY :" VIEW-AS TEXT
          SIZE 14 BY .95 AT ROW 6.14 COL 3.33
          BGCOLOR 3 FGCOLOR 7 FONT 6
     " STATUS FLAG :" VIEW-AS TEXT
          SIZE 17 BY 1 AT ROW 6.05 COL 60
          BGCOLOR 3 FGCOLOR 7 FONT 6
     "To  :" VIEW-AS TEXT
          SIZE 7.5 BY 1 AT ROW 1.67 COL 55
          FGCOLOR 7 FONT 6
     " OUTPUT FILE NAME :" VIEW-AS TEXT
          SIZE 23.33 BY .95 AT ROW 7.24 COL 3.33
          BGCOLOR 3 FGCOLOR 7 FONT 6
     "วันที่ไฟล์แจ้งงาน  From :" VIEW-AS TEXT
          SIZE 21.5 BY 1 AT ROW 1.67 COL 4.83
          FGCOLOR 7 FONT 6
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
         TITLE              = "Query && Update [SCB RENEW]"
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
     _FldNameList[3]   > brstat.tlt.filler1
"tlt.filler1" "Old Policy" "x(20)" "character" ? ? ? ? ? ? no ? no no "15" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   > brstat.tlt.safe2
"tlt.safe2" "เลขที่สัญญา" "x(10)" "character" ? ? ? ? ? ? no ? no no "14.83" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   > brstat.tlt.nor_noti_ins
"tlt.nor_noti_ins" "New Policy" "x(20)" "character" ? ? ? ? ? ? no ? no no "15" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[6]   > brstat.tlt.comp_pol
"tlt.comp_pol" "Comp Policy" "x(20)" "character" ? ? ? ? ? ? no ? no no "15" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[7]   > brstat.tlt.ins_name
"tlt.ins_name" "Insured name" ? "character" ? ? ? ? ? ? no ? no no "25" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[8]   > brstat.tlt.cha_no
"tlt.cha_no" "Chassic no." ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[9]   > brstat.tlt.gendat
"tlt.gendat" "Comdate_70" ? "date" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[10]   > brstat.tlt.expodat
"tlt.expodat" "Expdat_70" "99/99/9999" "date" ? ? ? ? ? ? no ? no no "10" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[11]   > brstat.tlt.nor_coamt
"tlt.nor_coamt" "SI" ? "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[12]   > brstat.tlt.comp_sck
"tlt.comp_sck" "Sticker no." "x(15)" "character" ? ? ? ? ? ? no ? no no "14.17" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[13]   > brstat.tlt.comp_grprm
"tlt.comp_grprm" "Gross premium 72" ">>>,>>9.99" "decimal" ? ? ? ? ? ? no ? no no "9.33" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[14]   > brstat.tlt.comp_coamt
"tlt.comp_coamt" "Total Prem." ? "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _Query            is NOT OPENED
*/  /* BROWSE br_tlt */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME c-wins
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c-wins c-wins
ON END-ERROR OF c-wins /* Query  Update [SCB RENEW] */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c-wins c-wins
ON WINDOW-CLOSE OF c-wins /* Query  Update [SCB RENEW] */
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
    Run  wgw\wgwscbq2(Input  nv_recidtlt).
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


&Scoped-define SELF-NAME bu_exit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_exit c-wins
ON CHOOSE OF bu_exit IN FRAME fr_main /* EXIT */
DO:
  APPLY "CLOSE" TO THIS-PROCEDURE.
  RETURN NO-APPLY.
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
        tlt.genusr   =  "SCBRE"        AND 
        tlt.flag      =  "R"           no-lock.  
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
    If  cb_search = "ชื่อลูกค้า"  Then do:              /* name  */                          
        Open Query br_tlt                                                        
            For each tlt Use-index  tlt01      Where                                     
            tlt.trndat  >=  fi_trndatfr        And                                            
            tlt.trndat  <=  fi_trndatto        And  
            tlt.genusr   =  "SCBRE"            And
            index(tlt.ins_name,fi_search) <> 0 no-lock.  
                ASSIGN nv_rectlt =  recid(tlt) . 
                Apply "Entry"  to br_tlt.
                Return no-apply.            
    END.
    ELSE If  cb_search  =  "กรมธรรม์ใหม่"  Then do:   /* policy */
        Open Query br_tlt 
            For each tlt Use-index  tlt01 Where
            tlt.trndat   >=  fi_trndatfr  And
            tlt.trndat   <=  fi_trndatto  And
            tlt.genusr    =  "SCBRE"      And
            index(tlt.nor_noti_ins,fi_search) <> 0  no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .  
                Apply "Entry"  to br_tlt.
                Return no-apply.        
    END.
    ELSE If  cb_search  =  "เลขที่สัญญา"  Then do:   /*  */
        Open Query br_tlt 
            For each tlt Use-index  tlt01 Where
            tlt.trndat   >=  fi_trndatfr  And
            tlt.trndat   <=  fi_trndatto  And
            tlt.genusr    =  "SCBRE"      And
            index(tlt.safe2,fi_search) <> 0  no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .  
                Apply "Entry"  to br_tlt.
                Return no-apply.        
    END.
    
    ELSE If  cb_search  =  "กรมธรรม์เก่า"  Then do:   /* */
        Open Query br_tlt 
            For each tlt Use-index  tlt01 Where
            tlt.trndat   >=  fi_trndatfr  And
            tlt.trndat   <=  fi_trndatto  And
            tlt.genusr    =  "SCBRE"      And
            index(brstat.tlt.filler1,fi_search) <> 0  no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .  
                Apply "Entry"  to br_tlt.
                Return no-apply.        
    END.
    ELSE If  cb_search  = "เลขตัวถัง"  Then do:  /* chassis no */
        Open Query br_tlt 
            For each tlt Use-index  tlt06 Where
            tlt.trndat >=  fi_trndatfr    And
            tlt.trndat <=  fi_trndatto    AND 
            tlt.genusr   =  "SCBRE"       And
            INDEX(tlt.cha_no,trim(fi_search)) <> 0  no-lock.
                ASSIGN nv_rectlt =  recid(tlt) . 
                Apply "Entry"  to br_tlt.
                Return no-apply.            
    END.
    ELSE If  cb_search  = "งานเอ็มไพร์"  Then do:  /* EMP */
        Open Query br_tlt 
            For each tlt Use-index  tlt06 Where
            tlt.trndat >=  fi_trndatfr    And
            tlt.trndat <=  fi_trndatto    AND 
            tlt.genusr   =  "SCBRE"       And
            tlt.imp      = "EMP"          no-lock.
                ASSIGN nv_rectlt =  recid(tlt) . 
                Apply "Entry"  to br_tlt.
                Return no-apply.            
    END.
    ELSE If  cb_search  = "งานอรกานต์"  Then do:  /* ORA */
        Open Query br_tlt 
            For each tlt Use-index  tlt06 Where
            tlt.trndat >=  fi_trndatfr    And
            tlt.trndat <=  fi_trndatto    AND 
            tlt.genusr   =  "SCBRE"       And
            tlt.imp      = "ORA"          no-lock.
                ASSIGN nv_rectlt =  recid(tlt) . 
                Apply "Entry"  to br_tlt.
                Return no-apply.            
    END.
    ELSE If  cb_search  =  "ออกงานแล้ว"  Then do:   /* Confirm yes..*/
        Open Query br_tlt 
            For each tlt Use-index  tlt01  Where
            tlt.trndat >=  fi_trndatfr     And
            tlt.trndat <=  fi_trndatto     And
            tlt.genusr   =  "SCBRE"        And
            INDEX(tlt.releas,"yes") <> 0   no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .  
                Apply "Entry"  to br_tlt.
                Return no-apply.            
    END.
    ELSE If  cb_search  =  "ยังไม่ออกงาน"  Then do:     /* confirm no...*/
        Open Query br_tlt 
            For each tlt Use-index  tlt01   Where
            tlt.trndat >=  fi_trndatfr      And
            tlt.trndat <=  fi_trndatto      And
            tlt.genusr   =  "SCBRE"         And
            INDEX(tlt.releas,"no") <> 0     no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .  
                Apply "Entry"  to br_tlt.
                Return no-apply.            
    END.
    ELSE If  cb_search  =  "ยกเลิก"  Then do:    /* cancel */
        Open Query br_tlt 
            For each tlt Use-index  tlt01  Where
            tlt.trndat  >=  fi_trndatfr    And
            tlt.trndat  <=  fi_trndatto    And
            tlt.genusr   =  "SCBRE"        And
            index(tlt.releas,"cancel") > 0     no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .  
                Apply "Entry"  to br_tlt.
                Return no-apply.                             
    END.
    ELSE If  cb_search  =  "Status_Close"  Then do:    /* close*/
        Open Query br_tlt 
            For each tlt Use-index  tlt01  Where
            tlt.trndat  >=  fi_trndatfr    And
            tlt.trndat  <=  fi_trndatto    And
            tlt.genusr   =  "SCBRE"        And
            index(brstat.tlt.lotno, "Close") <> 0      no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .  
                Apply "Entry"  to br_tlt.
                Return no-apply.                             
    END.
    ELSE If  cb_search  =  "Status_Active"  Then do:    /* active */
        Open Query br_tlt 
            For each tlt Use-index  tlt01  Where
            tlt.trndat  >=  fi_trndatfr    And
            tlt.trndat  <=  fi_trndatto    And
            tlt.genusr   =  "SCBRE"        And
            INDEX(brstat.tlt.lotno,"Active") <> 0     no-lock.
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
ON CHOOSE OF bu_report IN FRAME fr_main /* REPORT FILE */
DO:
    IF fi_outfile = "" THEN DO:
        MESSAGE "กรุณาใสชื่อไฟล์!!!"  VIEW-AS ALERT-BOX.
        Apply "Entry"  to fi_outfile.
        Return no-apply. 
    END.
    ELSE DO:
        RUN pd_reportfiel.
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


&Scoped-define SELF-NAME fi_emp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_emp c-wins
ON MOUSE-SELECT-CLICK OF fi_emp IN FRAME fr_main /* DATA EMPIRE */
DO:
    fi_emp = INPUT fi_emp .
    DISP fi_emp WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_emp c-wins
ON VALUE-CHANGED OF fi_emp IN FRAME fr_main /* DATA EMPIRE */
DO:
    fi_emp = INPUT fi_emp.
    DISP fi_emp WITH FRAME fr_main.

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
  gv_prgid = "wgwscbq1".
  gv_prog  = "Query & Update  Detail  (SCBRE) ".
  RUN  WUT\WUTHEAD ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).

  SESSION:DATA-ENTRY-RETURN = YES.


  Rect-338:Move-to-top().  
  Rect-339:Move-to-top(). 
  RECT-381:Move-to-top().

  ASSIGN 
      fi_trndatfr = TODAY
      fi_trndatto = TODAY
      fi_emp      = NO
      vAcProc_fil = vAcProc_fil   + "ชื่อลูกค้า"   + ","   
                                  + "กรมธรรม์ใหม่" + ","   
                                  + "เลขที่สัญญา"  + ","    
                                  + "กรมธรรม์เก่า" + ","   
                                  + "เลขตัวถัง"    + "," 
                                  + "งานเอ็มไพร์"  + ","
                                  + "งานอรกานต์"  + ","
                                  + "ออกงานแล้ว"   + "," 
                                  + "ยังไม่ออกงาน" + ","   
                                  + "ยกเลิก"  + ","        
                                  + "Status_Close"  + ","  
                                  + "Status_Active"  + "," 
        cb_search:LIST-ITEMS = vAcProc_fil
        cb_search = ENTRY(1,vAcProc_fil)
        vAcProc_fil1 = vAcProc_fil1 
                                  + "All"  + ","
                                  + "Status_Close" + ","  
                                  + "Status_Active" + ","
        cb_report:LIST-ITEMS = vAcProc_fil1
        cb_report = ENTRY(1,vAcProc_fil1)
      ra_status = 4  
      fi_outfile = "C:\TEMP\Report_SCBRE" + 
                    STRING(YEAR(TODAY),"9999") + 
                    STRING(MONTH(TODAY),"99")  + 
                    STRING(DAY(TODAY),"99")    + 
                    SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) + 
                    SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2) + ".slk" .
  Disp fi_trndatfr  fi_trndatto cb_search cb_report ra_status fi_outfile fi_emp
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
  DISPLAY fi_emp ra_status fi_trndatfr fi_trndatto cb_search fi_search fi_name 
          cb_report fi_outfile 
      WITH FRAME fr_main IN WINDOW c-wins.
  ENABLE fi_emp bu_exit ra_status fi_trndatfr fi_trndatto bu_ok cb_search 
         bu_oksch br_tlt fi_search bu_update cb_report fi_outfile bu_report 
         bu_upyesno RECT-332 RECT-338 RECT-339 RECT-340 RECT-341 RECT-381 
         RECT-342 
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
/*OUTPUT TO VALUE(nv_filemat).
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
                                               brstat.tlt.genusr    = "SCBRE"  AND 
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
OUTPUT   CLOSE. */ 

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
DEF VAR nv_count AS INT INIT 0.

If  substr(fi_outfile,length(fi_outfile) - 3,4) <>  ".slk"  THEN 
    fi_outfile  =  Trim(fi_outfile) + ".slk"  .

ASSIGN nv_count =  0 .

OUTPUT TO VALUE(fi_outfile).
EXPORT DELIMITER "|" 
    "Export Data SCBRE :" 
    string(TODAY)   .
EXPORT DELIMITER "|" 
    "ลำดับที่       "                           /*1 */ 
    "วันที่         "                           /*2 */ 
    "ชื่อเจ้าหน้าที่ผู้แจ้งประกันภัย  "         /*3 */ 
    "ชื่อบริษัท     "                           /*4 */ 
    "ชื่อผู้เอาประกัน "                         /*5 */ 
    "กรมธรรม์เดิม   "                           /*6 */ 
    "ประเภทรถ       "                           /*7 */ 
    "ยี่ห้อรถ/รุ่น  "                           /*8 */ 
    "ปีรุ่น         "                           /*9 */ 
    "ทะเบียนรถ      "                           /*10*/ 
    "จังหวัด        "                           /*11*/ 
    "ขนาด           "                           /*12*/ 
    "น้ำหนัก        "                           /*13*/ 
    "เลขตัวถัง      "                           /*14*/ 
    "เลขเครื่องยนต์ "                           /*15*/ 
    "ประเภทการประกันภัย "                       /*16*/ 
    "วันที่คุ้มครอง   "                         /*17*/ 
    "ค่าเบี้ยประกันภัย"                         /*18*/ 
    "ทุนประกัน    "                             /*19*/ 
    "สถานที่ซ่อม  "                             /*20*/ 
    "ประเภท   "                                 /*21*/ 
    "%NCB     "                                 /*22*/ 
    "ค่าเสียหายส่วนแรก"                         /*23*/ 
    "ระบุผู้ขับขี่    "                         /*24*/ 
    "ผู้ขับขี่1"
    "เลขบัตรใบขับขี่1 "                         /*25*/
    "ผู้ขับขี่2"
    "เลขบัตรใบขับขี่2 "  
    "อุปกรณ์เพิ่มเติม "                         /*26*/ 
    "วันคุ้มครองพรบ.  "                         /*27*/ 
    "ค่าเบี้ยพรบ."                              /*28*/ 
    "สติกเกอร์"                                 /*29*/ 
    "Status"                                    /*30*/ 
    "ID    "                                    /*31*/ 
    "เวลาส่งงาน  "                              /*32*/ 
    "เลขที่สัญญา "                              /*33*/ 
    "ที่อยู่ในการส่งเอกสาร "                    /*34*/ 
    "ที่อยู่ในการส่งเอกสาร "                    /*35*/ 
    "ที่อยู่ในการส่งเอกสาร "                    /*36*/ 
    "ที่อยู่ในการส่งเอกสาร "                    /*37*/ 
    "ที่อยู่ในการส่งเอกสาร "                    /*38*/ 
    "หมายเหตุ"                                  /*39*/ 
    "producer"                                  /*40*/ 
    "agent   "                                  /*41*/ 
    "เบอร์กรมธรรม์ใหม่ "                        /*42*/ 
    "เบอร์ พรบ. "                               /*43*/ 
    "วันที่ออกงาน "                             /*44*/ 
    "Subspect  "                                /*45*/
    "เลขตรวจสภาพ"                               /*46*/ 
    "ผลตรวจสภาพ "
    "ผู้รับผลประโยชน์"
    "แคมเปญ "
    "สถานะ  " .                                 

loop_tlt:
For each tlt Use-index  tlt01 Where
            tlt.trndat   >=  fi_trndatfr   And
            tlt.trndat   <=  fi_trndatto   And
            tlt.genusr    =  "SCBRE"        no-lock. 

    IF cb_report = "Status_Close" THEN DO:
        IF INDEX(tlt.lotno,"Close") = 0 THEN NEXT.
    END.
    ELSE IF cb_report = "Status_Active" THEN DO:
        IF INDEX(tlt.lotno,"Active") = 0 THEN NEXT.
    END.

    IF  ra_status = 1 THEN DO: 
        IF INDEX(tlt.releas,"yes") = 0    THEN NEXT.
    END.
    ELSE IF ra_status = 2 THEN DO: 
        IF INDEX(tlt.releas,"no") = 0     THEN NEXT.
    END.
    ELSE IF ra_status = 3 THEN DO: 
        IF index(tlt.releas,"cancel") = 0 THEN NEXT.
    END.

    IF fi_emp = YES AND brstat.tlt.imp <> "EMP" THEN NEXT.

    nv_count = nv_count + 1.
    EXPORT DELIMITER "|"
        nv_count                                                                        /*1 */ 
        brstat.tlt.datesent                                                             /*2 */ 
        brstat.tlt.nor_usr_ins                                                          /*3 */ 
        brstat.tlt.nor_usr_tlt                                                          /*4 */ 
        brstat.tlt.ins_name                                                             /*5 */ 
        brstat.tlt.filler1                                                              /*6 */ 
        trim(brstat.tlt.old_cha)                                                        /*7 */ 
        brstat.tlt.model                                                                /*8 */ 
        brstat.tlt.lince2                                                               /*9 */ 
        brstat.tlt.lince1                                                               /*10*/ 
        brstat.tlt.lince3                                                               /*11*/ 
        brstat.tlt.cc_weight                                                            /*12*/ 
        TRIM(brstat.tlt.OLD_eng)                                                        /*13*/ 
        brstat.tlt.cha_no                                                               /*14*/ 
        brstat.tlt.eng_no                                                               /*15*/ 
        brstat.tlt.colorcod                                                             /*16*/ 
        brstat.tlt.gendat                                                               /*17*/ 
        brstat.tlt.comp_coam                                                            /*18*/ 
        brstat.tlt.nor_coamt                                                            /*19*/ 
        TRIM(brstat.tlt.stat)                                                           /*20*/ 
        trim(brstat.tlt.comp_usr_tlt)                                                   /*21*/ 
        SUBSTR(brstat.tlt.rec_addr5,5,INDEX(brstat.tlt.rec_addr5,"DD:") - 5 )           /*22*/ 
        SUBSTR(brstat.tlt.rec_addr5,r-index(brstat.tlt.rec_addr5,"DD:") + 3 )           /*23*/ 
        brstat.tlt.endno 
        brstat.tlt.dri_no1                                                               /*24*/ 
        brstat.tlt.dri_name1 
        brstat.tlt.dri_no2                                                               /*24*/ 
        brstat.tlt.dri_name2                                                            /*25*/ 
        brstat.tlt.safe1                                                                /*26*/ 
        brstat.tlt.comp_effdat                                                          /*27*/ 
        brstat.tlt.comp_grprm                                                           /*28*/ 
        brstat.tlt.comp_sck                                                             /*29*/ 
        brstat.tlt.lotno                                                                /*30*/ 
        brstat.tlt.ins_addr5                                                            /*32*/ 
        brstat.tlt.trntim                                                               /*33*/ 
        brstat.tlt.safe2                                                                /*34*/ 
        trim(brstat.tlt.ins_addr1)                                                      /*35*/ 
        trim(brstat.tlt.ins_addr2)                                                      /*36*/ 
        trim(brstat.tlt.ins_addr3)                                                      /*37*/ 
        trim(brstat.tlt.ins_addr4)                                                      /*38*/
        "" 
        brstat.tlt.filler2                                                              /*39*/ 
        brstat.tlt.comp_sub                                                             /*40*/ 
        brstat.tlt.comp_noti_ins                                                        /*41*/ 
        brstat.tlt.nor_noti_ins                                                         /*42*/ 
        brstat.tlt.comp_pol                                                             /*43*/ 
        brstat.tlt.dat_ins_noti                                                         /*44*/ 
        brstat.tlt.expotim                                                              /*45*/ 
        SUBSTR(brstat.tlt.rec_addr1,5,index(brstat.tlt.rec_addr1,"RES:") - 5)
        SUBSTR(brstat.tlt.rec_addr1,R-INDEX(brstat.tlt.rec_addr1,"RES:") + 4)
        SUBSTR(brstat.tlt.rec_addr2,5,index(brstat.tlt.rec_addr2,"CAM:") - 5)     /* ผู้รับผลประโยชน์ */   
        SUBSTR(brstat.tlt.rec_addr2,R-INDEX(brstat.tlt.rec_addr2,"CAM:") + 4)     /* แคมเปญ */             
        brstat.tlt.releas
        brstat.tlt.rec_addr3 .    /* User ID ที่แก้ไขข้อมูล */
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
        tlt.genusr   =  "SCBRE" NO-LOCK .
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

