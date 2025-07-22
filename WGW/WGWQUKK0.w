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
program id  : wgwqukk0.w
program name: Query & Update flag detail
              Import text file from  KK  to create  new policy Add in table  tlt 
Create  by  : Kridtiya i. [A54-0351]   On   14/11/2011
Connect     : GW_SAFE LD SIC_BRAN, GW_STAT LD BRSTAT ,SICSYAC  [SICUW  not connect Stat]
/*modify by : Kridtiya i. A55-0029 ปรับแก้ไข ไฟล์ .slk เป็น ไฟล์ .csv  */
/*modify by : Kridtiya i. A56-0309 ปรับแก้ไข ไฟล์ เพิ่มการรายงานสถานะข้อมูล Yes/no */
/*modify by : Ranu I. A60-0232 Date 01/06/2017  เพิ่มข้อมูลในไฟล์รายงาน */
/*Modify by : Ranu I. A61-0335 date 11/07/2018 เพิ่มข้อมูล kkapp */
/*Modify by : Kridtiya i. A63-00472  Add Dealer Code */ 
/*Modify by : Ranu I. A65-0288 เพิ่มข้อมูลตรวจสภาพในรายงาน */
/* Modify by   : Ranu I. A67-0076 เพิ่มการเก็บข้อมูลรถไฟฟ้า */
+++++++++++++++++++++++++++++++++++++++++++++++*/
 Def   var  nv_rectlt    as  recid  init  0.
 Def   var  nv_recidtlt  as  recid  init  0.
 def  stream  ns2.
 /* Create by A60-0232*/
 def var n_text     as char format "x(255)" init "".
 def var nv_phone   as char format "x(25)" init "".
 def var nv_icno    as char format "x(15)" init "".
 def var nv_tax     as char format "x(15)" init "".
 def var nv_cstatus as char format "x(20)" init "".
 def var nv_occup   as char format "x(45)" init "".
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
 def var n_send     as char format "x(100)" init "". /*A61-0335*/
 def var n_sendname as char format "x(100)" init "". /*A61-0335*/
 def var n_bennefit as char format "x(100)" init "". /*A61-0335*/
 /* end : A60-0232 */
 DEF VAR nv_file    AS CHAR FORMAT "x(255)" INIT "" . /*A61-0335*/
/*---Begin by Chaiyong W. A64-0135 21/06/2021*/
DEF VAR nv_datafr AS CHAR INIT "".
DEF VAR nv_Datato AS CHAR INIT "".
/*end  by Chaiyong W. A64-0135 21/06/2021---*/
/* add by : A67-0076 */
def var nv_drioccup1    as char init "" .     
def var nv_driToccup1   as char init "" .     
def var nv_driTicono1   as char init "" .     
def var nv_driICNo1     as char init "" .     
def var nv_drioccup2    as char init "" .     
def var nv_driToccup2   as char init "" .     
def var nv_driTicono2   as char init "" .     
def var nv_driICNo2     as char init "" .     
def var nv_drioccup3    as char init "" .     
def var nv_driToccup3   as char init "" .     
def var nv_driTicono3   as char init "" .     
def var nv_driICNo3     as char init "" .     
def var nv_drioccup4    as char init "" .     
def var nv_driToccup4   as char init "" .     
def var nv_driTicono4   as char init "" .     
def var nv_driICNo4     as char init "" .     
def var nv_drioccup5    as char init "" .     
def var nv_driToccup5   as char init "" .     
def var nv_driTicono5   as char init "" .     
def var nv_driICNo5     as char init "" .  

DEF VAR nv_comcod AS CHAR INIT "".
DEF VAR nv_comchr AS CHAR INIT "".
DEF VAR nv_expchr AS CHAR INIT "".
DEF VAR nv_birchr AS CHAR INIT "".
DEF VAR nv_senchr AS CHAR INIT "".
DEF VAR nv_trnchr AS CHAR INIT "".
DEF VAR nv_saddr  AS CHAR INIT "".
DEF VAR nv_first  AS CHAR INIT "".
DEF VAR nv_ccom   AS INT INIT 0.
def var nv_Brancho  as char init "".
def var nv_dealero  as char init "".
DEF VAR nv_campno   AS CHAR INIT "".
DEF VAR nv_Seat AS CHAR INIT "".

def var  nv_ispno             as char no-undo init "".
def var  nv_ispappoit         as char no-undo init "".
def var  nv_ispupdate         as char no-undo init "".
def var  nv_isplocal          as char no-undo init "".
def var  nv_ispclose          as char no-undo init "".
def var  nv_ispresult         as char no-undo init "".
def var  nv_ispdam            as char no-undo init "".
def var  nv_ispacc            as char no-undo init "".
/* end : A67-0076 */

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
&Scoped-define FIELDS-IN-QUERY-br_tlt tlt.releas tlt.expotim tlt.policy ~
tlt.comp_noti_tlt tlt.nor_noti_tlt tlt.ins_name tlt.nor_effdat tlt.expodat ~
tlt.lince1 tlt.old_eng tlt.comp_usr_ins tlt.nor_usr_ins 
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_tlt 
&Scoped-define QUERY-STRING-br_tlt FOR EACH tlt NO-LOCK ~
    BY tlt.comp_noti_tlt
&Scoped-define OPEN-QUERY-br_tlt OPEN QUERY br_tlt FOR EACH tlt NO-LOCK ~
    BY tlt.comp_noti_tlt.
&Scoped-define TABLES-IN-QUERY-br_tlt tlt
&Scoped-define FIRST-TABLE-IN-QUERY-br_tlt tlt


/* Definitions for FRAME fr_main                                        */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS ra_type ra_new cb_search fi_trndatfr ~
fi_trndatto fi_polfr fi_polto bu_ok fi_search bu_sch fi_filename bu_reok ~
bu_exit br_tlt cb_report RECT-332 RECT-333 RECT-338 RECT-340 RECT-341 ~
RECT-343 RECT-344 RECT-346 
&Scoped-Define DISPLAYED-OBJECTS ra_type ra_new cb_search fi_trndatfr ~
fi_trndatto fi_polfr fi_polto fi_search fi_filename cb_report 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR c-wins AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bu_exit 
     LABEL "Exit" 
     SIZE 8 BY 1.24
     FONT 6.

DEFINE BUTTON bu_ok 
     LABEL "Ok" 
     SIZE 8 BY 1.24
     FONT 6.

DEFINE BUTTON bu_reok 
     LABEL "OK" 
     SIZE 5 BY 1.

DEFINE BUTTON bu_sch 
     LABEL "Search" 
     SIZE 8 BY 1.05.

DEFINE VARIABLE cb_report AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEM-PAIRS "Cover","Cover",
                     "Hold","Hold",
                     "Cancel_Hold","Cancel",
                     "Release Yes","Yes",
                     "Release No","No",
                     "Release CA","CA",
                     "Problem","Problem",
                     "Inspection(Y)","Inspection(Y)",
                     "Status-ISP(Y)","Status-ISP(Y)",
                     "Status-ISP(N)","Status-ISP(N)",
                     "All","All"
     DROP-DOWN-LIST
     SIZE 27 BY 1
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE cb_search AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEM-PAIRS "Name","Name",
                     "REKK","REKK",
                     "KK-APP","KK-APP",
                     "Chassis","Chassis",
                     "Cover","Cover",
                     "Hold","Hold",
                     "Cancel_Hold","Cancel",
                     "Release Yes","Yes",
                     "Release No","No",
                     "Release CA","CA",
                     "Policy","Policy",
                     "New","New",
                     "Renew","Renew",
                     "Inspection(Y/N)","Inspection(Y/N)",
                     "Status-ISP(Y/N)","Status-ISP(Y/N)"
     DROP-DOWN-LIST
     SIZE 34.5 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_filename AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 42.83 BY 1.05
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_polfr AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_polto AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 16 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_search AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 48 BY 1.05
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_trndatfr AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_trndatto AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE ra_new AS INTEGER INITIAL 2 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "Old", 1,
"New", 2
     SIZE 25.5 BY .95
     BGCOLOR 8 FONT 6 NO-UNDO.

DEFINE VARIABLE ra_type AS INTEGER INITIAL 3 
     VIEW-AS RADIO-SET HORIZONTAL EXPAND 
     RADIO-BUTTONS 
          "New", 1,
"Renew", 2,
"All", 3
     SIZE 36.5 BY .71
     BGCOLOR 8 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-332
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 131.5 BY 7.76
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-333
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 11 BY 2.19
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-338
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 62 BY 3.57
     BGCOLOR 18 .

DEFINE RECTANGLE RECT-340
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 106.5 BY 3
     BGCOLOR 31 .

DEFINE RECTANGLE RECT-341
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 11 BY 2.19
     BGCOLOR 4 .

DEFINE RECTANGLE RECT-343
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 66.83 BY 3.57
     BGCOLOR 18 .

DEFINE RECTANGLE RECT-344
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 8 BY 1.62
     BGCOLOR 6 .

DEFINE RECTANGLE RECT-346
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 10.17 BY 1.52
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
      tlt.releas FORMAT "x(20)":U WIDTH 7.83
      tlt.expotim COLUMN-LABEL "KK App" FORMAT "x(25)":U WIDTH 14.33
      tlt.policy FORMAT "x(16)":U
      tlt.comp_noti_tlt COLUMN-LABEL "เลขที่รับแจ้งฯ KK" FORMAT "x(25)":U
            WIDTH 14.67
      tlt.nor_noti_tlt COLUMN-LABEL "เลขรับแจ้งฯ KK" FORMAT "x(25)":U
            WIDTH 13.33
      tlt.ins_name FORMAT "x(50)":U WIDTH 19.83
      tlt.nor_effdat COLUMN-LABEL "Comdate." FORMAT "99/99/9999":U
            WIDTH 9.83
      tlt.expodat COLUMN-LABEL "Expydate." FORMAT "99/99/9999":U
            WIDTH 8.83
      tlt.lince1 COLUMN-LABEL "ทะเบียน" FORMAT "x(30)":U WIDTH 11.83
      tlt.old_eng COLUMN-LABEL "วันที่รับแจ้ง/วันที่ระงับเคลม" FORMAT "x(50)":U
            WIDTH 28.83
      tlt.comp_usr_ins FORMAT "x(50)":U WIDTH 23.5
      tlt.nor_usr_ins FORMAT "x(50)":U WIDTH 23.83
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 131.5 BY 15.86
         BGCOLOR 15  ROW-HEIGHT-CHARS .52.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     ra_type AT ROW 4.62 COL 78.5 NO-LABEL WIDGET-ID 18
     ra_new AT ROW 1.71 COL 20 NO-LABEL WIDGET-ID 8
     cb_search AT ROW 4.81 COL 15.5 COLON-ALIGNED NO-LABEL WIDGET-ID 2
     fi_trndatfr AT ROW 2.91 COL 17.17 COLON-ALIGNED NO-LABEL
     fi_trndatto AT ROW 2.91 COL 37 COLON-ALIGNED NO-LABEL
     fi_polfr AT ROW 2.91 COL 68.83 COLON-ALIGNED NO-LABEL
     fi_polto AT ROW 2.91 COL 89.17 COLON-ALIGNED NO-LABEL
     bu_ok AT ROW 1.76 COL 111.17
     fi_search AT ROW 6.14 COL 3.5 NO-LABEL
     bu_sch AT ROW 6.24 COL 53.67
     fi_filename AT ROW 6.67 COL 76 COLON-ALIGNED NO-LABEL
     bu_reok AT ROW 6.38 COL 123.5
     bu_exit AT ROW 1.76 COL 122.17
     br_tlt AT ROW 8.14 COL 1
     cb_report AT ROW 5.57 COL 77 COLON-ALIGNED NO-LABEL WIDGET-ID 6
     "Report File :" VIEW-AS TEXT
          SIZE 12 BY 1 AT ROW 5.57 COL 66.33
          BGCOLOR 5 FGCOLOR 1 FONT 6
     "File name :" VIEW-AS TEXT
          SIZE 11.33 BY 1 AT ROW 6.67 COL 66.5
          BGCOLOR 5 FONT 6
     "To :" VIEW-AS TEXT
          SIZE 4 BY 1 AT ROW 2.91 COL 34.67
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "Transdate From :" VIEW-AS TEXT
          SIZE 15.83 BY 1 AT ROW 2.91 COL 3
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "To :" VIEW-AS TEXT
          SIZE 4.5 BY 1 AT ROW 2.91 COL 86.33
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "REKK no. From :" VIEW-AS TEXT
          SIZE 16 BY 1.05 AT ROW 2.91 COL 54.5
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "Format Type" VIEW-AS TEXT
          SIZE 15.83 BY 1 AT ROW 1.62 COL 3 WIDGET-ID 16
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "Search  By :" VIEW-AS TEXT
          SIZE 12.5 BY .95 AT ROW 4.91 COL 3.5
          BGCOLOR 5 FONT 6
     RECT-332 AT ROW 1.1 COL 1
     RECT-333 AT ROW 1.33 COL 109.5
     RECT-338 AT ROW 4.33 COL 1.5
     RECT-340 AT ROW 1.33 COL 2
     RECT-341 AT ROW 1.33 COL 120.67
     RECT-343 AT ROW 4.33 COL 64
     RECT-344 AT ROW 6.1 COL 122
     RECT-346 AT ROW 6 COL 52.5
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 132.33 BY 23.52
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
  CREATE WINDOW c-wins ASSIGN
         HIDDEN             = YES
         TITLE              = "Query && Update [KK]"
         HEIGHT             = 23.1
         WIDTH              = 131.83
         MAX-HEIGHT         = 31.29
         MAX-WIDTH          = 213.33
         VIRTUAL-HEIGHT     = 31.29
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
IF NOT c-wins:LOAD-ICON("wimage/safety.ico":U) THEN
    MESSAGE "Unable to load icon: wimage/safety.ico"
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
/* BROWSE-TAB br_tlt bu_exit fr_main */
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
     _Options          = "NO-LOCK"
     _OrdList          = "brstat.tlt.comp_noti_tlt|yes"
     _FldNameList[1]   > brstat.tlt.releas
"tlt.releas" ? "x(20)" "character" ? ? ? ? ? ? no ? no no "7.83" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[2]   > brstat.tlt.expotim
"tlt.expotim" "KK App" "x(25)" "character" ? ? ? ? ? ? no ? no no "14.33" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   = brstat.tlt.policy
     _FldNameList[4]   > brstat.tlt.comp_noti_tlt
"tlt.comp_noti_tlt" "เลขที่รับแจ้งฯ KK" ? "character" ? ? ? ? ? ? no ? no no "14.67" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   > brstat.tlt.nor_noti_tlt
"tlt.nor_noti_tlt" "เลขรับแจ้งฯ KK" ? "character" ? ? ? ? ? ? no ? no no "13.33" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[6]   > brstat.tlt.ins_name
"tlt.ins_name" ? ? "character" ? ? ? ? ? ? no ? no no "19.83" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[7]   > brstat.tlt.nor_effdat
"tlt.nor_effdat" "Comdate." ? "date" ? ? ? ? ? ? no ? no no "9.83" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[8]   > brstat.tlt.expodat
"tlt.expodat" "Expydate." "99/99/9999" "date" ? ? ? ? ? ? no ? no no "8.83" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[9]   > brstat.tlt.lince1
"tlt.lince1" "ทะเบียน" "x(30)" "character" ? ? ? ? ? ? no ? no no "11.83" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[10]   > brstat.tlt.old_eng
"tlt.old_eng" "วันที่รับแจ้ง/วันที่ระงับเคลม" "x(50)" "character" ? ? ? ? ? ? no ? no no "28.83" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[11]   > brstat.tlt.comp_usr_ins
"tlt.comp_usr_ins" ? ? "character" ? ? ? ? ? ? no ? no no "23.5" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[12]   > brstat.tlt.nor_usr_ins
"tlt.nor_usr_ins" ? ? "character" ? ? ? ? ? ? no ? no no "23.83" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _Query            is NOT OPENED
*/  /* BROWSE br_tlt */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME c-wins
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c-wins c-wins
ON END-ERROR OF c-wins /* Query  Update [KK] */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c-wins c-wins
ON WINDOW-CLOSE OF c-wins /* Query  Update [KK] */
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
    
    /*---Begin by Chaiyong W. A64-0135 21/06/2021*/
    IF NOT AVAIL tlt THEN DO:
         MESSAGE "Please Select Data!!!" VIEW-AS ALERT-BOX INFORMATION.
         APPLY "entry" to fi_trndatfr.
         RETURN NO-APPLY.
    END.
    IF tlt.note1 <> "" OR
       tlt.note2 <> "" THEN DO:
        RUN wgw\wgwvtlkk0(Input  nv_recidtlt).
    END.
    ELSE DO:
    /*end  by Chaiyong W. A64-0135 21/06/2021---*/
        {&WINDOW-NAME}:hidden  =  Yes. 
        
        Run  wgw\wgwqukk2(Input  nv_recidtlt).
    
        {&WINDOW-NAME}:hidden  =  No.  
    END.   /*---add by Chaiyong W. A64-0135 21/06/2021*/

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_tlt c-wins
ON VALUE-CHANGED OF br_tlt IN FRAME fr_main
DO:
     Get  current  br_tlt.
     nv_rectlt =  recid(tlt).
     /*fi_name   =  tlt.ins_name.
     disp  fi_name  with frame  fr_main.*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_exit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_exit c-wins
ON CHOOSE OF bu_exit IN FRAME fr_main /* Exit */
DO:
   
   Apply "Close" to This-procedure.
   Return no-apply.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_ok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_ok c-wins
ON CHOOSE OF bu_ok IN FRAME fr_main /* Ok */
DO:
    If  fi_polfr  =  "0"   Then  fi_polfr  =  "0"  .
    If  fi_polto  =  "Z"   Then  fi_polto  =  "Z".


    IF ra_new = 1 THEN DO: /*---add by Chaiyong W, A64=0135 13/09/2021*/
        Open Query br_tlt 
            For each tlt Use-index  tlt01  Where
            tlt.trndat  >=   fi_trndatfr   And
            tlt.trndat  <=   fi_trndatto   And
    /*         tlt.policy  >=   fi_polfr     And */
    /*         tlt.policy  <=   fi_polto     And */
            /*tlt.comp_sub  =  fi_producer  And*/

            /*---Begin by Chaiyong W. A64-0135 13/09/2021*/
             tlt.note1  = "" AND
            tlt.note2    =  ""  AND
             /*End by Chaiyong W. A64-0135 13/09/2021-----*/


            tlt.genusr   =  "KK"        no-lock.  
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
    /*---Begin by Chaiyong W. A64-0135 13/09/2021*/
    ELSE DO:
        Open Query br_tlt 
            For each tlt Use-index  tlt01  Where
            tlt.trndat  >=   fi_trndatfr   And
            tlt.trndat  <=   fi_trndatto   AND
            ( tlt.note1     <> "" OR
            tlt.note2    <> "" ) AND
            tlt.genusr   =  "KK"        no-lock.  
                Apply "Entry"  to br_tlt.
                Return no-apply.                  
    END.
    /*End by Chaiyong W. A64-0135 13/09/2021-----*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_reok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_reok c-wins
ON CHOOSE OF bu_reok IN FRAME fr_main /* OK */
DO:
    cb_report = INPUT cb_report. /*--add by Chaiyong W. A64-0135 08/09/2021*/
    /*comment by kridtiya i. A55-0029....
    IF fi_filename = ""  THEN DO:
        MESSAGE "กรุณาใสชื่อไฟล์!!!"  VIEW-AS ALERT-BOX.
        Apply "Entry"  to fi_filename.
        Return no-apply.
    END.
    ELSE RUN proc_report. 
    end...comment by ...kridtiya i. A55-0029*/
    /*kridtiya i. A55-0029.........*/
    IF fi_filename = ""  THEN DO:
        MESSAGE "กรุณาใสชื่อไฟล์!!!"  VIEW-AS ALERT-BOX.
        Apply "Entry"  to fi_filename.
        Return no-apply.
    END.
    ELSE DO: 
        IF ra_new = 1 THEN DO: /*--add else by Chaiyong W. A64-0135 08/09/2021*/
            IF (cb_report = "Hold") OR (cb_report = "CA") THEN RUN proc_reportCA.  
            RUN proc_report2. 
        /*---begin by Chaiyong W. A64-0135 08/09/2021*/
        END.
        ELSE DO:
            IF (cb_report = "Hold") OR (cb_report = "CA") THEN RUN proc_reportCA.  
            ELSE IF cb_report = "Problem" THEN RUN proc_reportp.  
            ELSE RUN proc_report3.

        END.
        /*End by Chaiyong W. A64-0135 08/09/2021-----*/
    END.
    /*kridtiya i. A55-0029.........*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_sch
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_sch c-wins
ON CHOOSE OF bu_sch IN FRAME fr_main /* Search */
DO:
    /*Open Query br_tlt 
        For each tlt Use-index  tlt01  Where
        tlt.trndat  >=   fi_trndatfr   And
        tlt.trndat  <=   fi_trndatto   And
/*         tlt.policy  >=   fi_polfr     And */
/*         tlt.policy  <=   fi_polto     And */
        /*tlt.comp_sub  =  fi_producer  And*/
        tlt.genusr   =  "KK"        no-lock.  
            Apply "Entry"  to br_tlt.
            Return no-apply. */                            
            /*------------------------ 
            {&WINDOW-NAME}:hidden  =  Yes. 
            Run  wuw\wuwqtis1(Input  fi_trndatfr,
            fi_trndatto,
            fi_polfr,
            fi_polto,
            fi_producer).
            {&WINDOW-NAME}:hidden  =  No.                                               
            --------------------------*/
   IF ra_new = 1 THEN DO: /*---add by Chaiyong W, A64=0135 13/09/2021*/
       If  cb_search =  "Name"  Then do:              /* name  */
            Open Query br_tlt 
                For each tlt Use-index  tlt01      Where
                tlt.trndat         >=  fi_trndatfr And
                tlt.trndat         <=  fi_trndatto And
                tlt.comp_noti_tlt  >=  fi_polfr    And
                tlt.comp_noti_tlt  <=  fi_polto    AND
                /*---Begin by Chaiyong W. A64-0135 13/09/2021*/
             tlt.note1  = "" AND
            tlt.note2    =  ""  AND
             /*End by Chaiyong W. A64-0135 13/09/2021-----*/
                tlt.genusr          =  "KK"        And
                index(tlt.ins_name,fi_search) <> 0 no-lock.
                    Apply "Entry"  to br_tlt.
                    Return no-apply.            
        END.
        ELSE If  cb_search  = "REKK"  Then do:   /* rekk */
            Open Query br_tlt 
                For each tlt Use-index  tlt01     Where
                tlt.trndat        >=  fi_trndatfr And 
                tlt.trndat        <=  fi_trndatto And 
                tlt.comp_noti_tlt >=  fi_polfr    AND 
                tlt.comp_noti_tlt <=  fi_polto    AND 
                /*---Begin by Chaiyong W. A64-0135 13/09/2021*/
             tlt.note1  = "" AND
            tlt.note2    =  ""  AND
             /*End by Chaiyong W. A64-0135 13/09/2021-----*/
                tlt.genusr         =  "KK"        And 
                index(tlt.comp_noti_tlt,fi_search) <> 0  no-lock.
                    Apply "Entry"  to br_tlt.
                    Return no-apply.        
        END.
        ELSE If  cb_search  = "KK-APP"  Then do:   /* kk-app */
            Open Query br_tlt 
                For each tlt Use-index  tlt01     Where
                tlt.trndat        >=  fi_trndatfr And 
                tlt.trndat        <=  fi_trndatto And 
                tlt.comp_noti_tlt >=  fi_polfr    AND 
                tlt.comp_noti_tlt <=  fi_polto    AND 
                /*---Begin by Chaiyong W. A64-0135 13/09/2021*/
             tlt.note1  = "" AND
            tlt.note2    =  ""  AND
             /*End by Chaiyong W. A64-0135 13/09/2021-----*/
                tlt.genusr         =  "KK"        And 
                tlt.expotim        =  trim(fi_search)  no-lock.
                    Apply "Entry"  to br_tlt.
                    Return no-apply.        
        END.
        ELSE If  cb_search  = "Chassis"  Then do:     /* chassis no */
            Open Query br_tlt 
                For each tlt Use-index  tlt06      Where
                tlt.trndat         >=  fi_trndatfr  And
                tlt.trndat         <=  fi_trndatto  And
                tlt.comp_noti_tlt  >=  fi_polfr     AND 
                tlt.comp_noti_tlt  <=  fi_polto     AND 
                /*---Begin by Chaiyong W. A64-0135 13/09/2021*/
             tlt.note1  = "" AND
            tlt.note2    =  ""  AND
             /*End by Chaiyong W. A64-0135 13/09/2021-----*/
                tlt.genusr         =  "KK"          And
                INDEX(tlt.cha_no,trim(fi_search)) <> 0 no-lock.
                    Apply "Entry"  to br_tlt.
                    Return no-apply.            
        END.
        ELSE If  cb_search  =  "Cover"  Then do:     /* cover*/
            Open Query br_tlt 
                For each tlt Use-index  tlt01      Where
                tlt.trndat         >=  fi_trndatfr And
                tlt.trndat         <=  fi_trndatto And
                tlt.comp_noti_tlt  >=  fi_polfr    AND 
                tlt.comp_noti_tlt  <=  fi_polto    AND 
                /*---Begin by Chaiyong W. A64-0135 13/09/2021*/
             tlt.note1  = "" AND
            tlt.note2    =  ""  AND
             /*End by Chaiyong W. A64-0135 13/09/2021-----*/
                tlt.genusr          =  "KK"        And
                INDEX(tlt.OLD_eng,"Cover") <> 0    no-lock.
                    Apply "Entry"  to br_tlt.  
                    Return no-apply.           
        END.                                   
        ELSE If  cb_search  =  "Hold"  Then do:     /* hold */
            Open Query br_tlt                  
                For each tlt Use-index  tlt01      Where
                tlt.trndat         >=  fi_trndatfr And
                tlt.trndat         <=  fi_trndatto And
                tlt.comp_noti_tlt  >=  fi_polfr    AND 
                tlt.comp_noti_tlt  <=  fi_polto    AND 
                /*---Begin by Chaiyong W. A64-0135 13/09/2021*/
             tlt.note1  = "" AND
            tlt.note2    =  ""  AND
             /*End by Chaiyong W. A64-0135 13/09/2021-----*/
                tlt.genusr          =  "KK"        And
                INDEX(tlt.OLD_eng,"Hold")  <> 0    AND 
                INDEX(tlt.OLD_eng,"cancel") = 0    no-lock.
                    Apply "Entry"  to br_tlt.  
                    Return no-apply.           
        END.                                   
        ELSE If  cb_search  =  "Cancel"  Then do:    /* cancel */
            Open Query br_tlt                    
                For each tlt Use-index  tlt01       Where
                tlt.trndat         >=  fi_trndatfr  And
                tlt.trndat         <=  fi_trndatto  And
                tlt.comp_noti_tlt  >=  fi_polfr     And  
                tlt.comp_noti_tlt  <=  fi_polto     And 
                /*---Begin by Chaiyong W. A64-0135 13/09/2021*/
             tlt.note1  = "" AND
            tlt.note2    =  ""  AND
             /*End by Chaiyong W. A64-0135 13/09/2021-----*/
                tlt.genusr          =  "KK"         And
                INDEX(tlt.OLD_eng,"Cancel_Hold") > 0     no-lock.
                    Apply "Entry"  to br_tlt.
                    Return no-apply.                             
        END.
        ELSE If  cb_search  =  "Yes"  Then do:    /* YES */
            Open Query br_tlt                    
                For each tlt Use-index  tlt01       Where
                tlt.trndat         >=  fi_trndatfr  And
                tlt.trndat         <=  fi_trndatto  And
                tlt.comp_noti_tlt  >=  fi_polfr     And  
                tlt.comp_noti_tlt  <=  fi_polto     And 
                /*---Begin by Chaiyong W. A64-0135 13/09/2021*/
             tlt.note1  = "" AND
            tlt.note2    =  ""  AND
             /*End by Chaiyong W. A64-0135 13/09/2021-----*/
                tlt.genusr          =  "KK"         And
                INDEX(tlt.releas,"yes") <> 0     no-lock.
                    Apply "Entry"  to br_tlt.
                    Return no-apply.                             
        END.
        ELSE If  cb_search  =  "No"  Then do:    /* NO */
            Open Query br_tlt                    
                For each tlt Use-index  tlt01       Where
                tlt.trndat         >=  fi_trndatfr  And
                tlt.trndat         <=  fi_trndatto  And
                tlt.comp_noti_tlt  >=  fi_polfr     And  
                tlt.comp_noti_tlt  <=  fi_polto     And 
                /*---Begin by Chaiyong W. A64-0135 13/09/2021*/
             tlt.note1  = "" AND
            tlt.note2    =  ""  AND
             /*End by Chaiyong W. A64-0135 13/09/2021-----*/
                tlt.genusr          =  "KK"         And
                INDEX(tlt.releas,"No") <> 0    no-lock.
                    Apply "Entry"  to br_tlt.
                    Return no-apply.                             
        END.
        ELSE If  cb_search  =  "CA"  Then do:    /* ca */
            Open Query br_tlt                    
                For each tlt Use-index  tlt01       Where
                tlt.trndat         >=  fi_trndatfr  And
                tlt.trndat         <=  fi_trndatto  And
                tlt.comp_noti_tlt  >=  fi_polfr     And  
                tlt.comp_noti_tlt  <=  fi_polto     And 
                /*---Begin by Chaiyong W. A64-0135 13/09/2021*/
             tlt.note1  = "" AND
            tlt.note2    =  ""  AND
             /*End by Chaiyong W. A64-0135 13/09/2021-----*/
                tlt.genusr          =  "KK"         And
                INDEX(tlt.releas,"ca") <> 0     no-lock.
                    Apply "Entry"  to br_tlt.
                    Return no-apply.                             
        END.
        /*----begin by Chaiyong W. A64-0135 13/09/2021*/
        ELSE If  cb_search  =  "Policy"  Then do:    /* ca */
            Open Query br_tlt                    
                For each tlt Use-index  tlt01       Where
                tlt.trndat         >=  fi_trndatfr  And
                tlt.trndat         <=  fi_trndatto  And
                tlt.comp_noti_tlt  >=  fi_polfr     And  
                tlt.comp_noti_tlt  <=  fi_polto     And 
             tlt.note1  = "" AND
            tlt.note2    =  ""  AND
            
                tlt.genusr          =  "KK"         And
                INDEX(tlt.policy,trim(fi_search)) <> 0   no-lock.
                    Apply "Entry"  to br_tlt.
                    Return no-apply.                             
        END.
        ELSE If  cb_search  =  "Renew"  Then do:    
            Open Query br_tlt                    
                For each tlt Use-index  tlt01       Where
                tlt.trndat         >=  fi_trndatfr  And
                tlt.trndat         <=  fi_trndatto  And
                tlt.comp_noti_tlt  >=  fi_polfr     And  
                tlt.comp_noti_tlt  <=  fi_polto     And 
             tlt.note1  = "" AND
            tlt.note2    =  ""  AND
                tlt.genusr          =  "KK"         And
                INDEX(tlt.note5,"RENEW") <> 0   no-lock.
                    Apply "Entry"  to br_tlt.
                    Return no-apply.                             
        END.
        ELSE If  cb_search  =  "New"  Then do:   
            Open Query br_tlt                    
                For each tlt Use-index  tlt01       Where
                tlt.trndat         >=  fi_trndatfr  And
                tlt.trndat         <=  fi_trndatto  And
                tlt.comp_noti_tlt  >=  fi_polfr     And  
                tlt.comp_noti_tlt  <=  fi_polto     And 
             tlt.note1  = "" AND
            tlt.note2    =  ""  AND
                tlt.genusr          =  "KK"         And
                INDEX(tlt.note5,"RENEW") = 0   no-lock.
                    Apply "Entry"  to br_tlt.
                    Return no-apply.                             
        END.
        /*End by Chaiyong W. A64-0135 13/09/2021----*/
        Else DO:
            Apply "Entry"  to  fi_search.
            Return no-apply.
        END.
        /*---Begin by Chaiyong W. A64-0135 13/09/2021*/
    END.
    ELSE DO:
        RUN pd_search.
    END.
    /*End by Chaiyong W. A64-0135 13/09/2021-----*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME cb_report
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cb_report c-wins
ON VALUE-CHANGED OF cb_report IN FRAME fr_main
DO:
    cb_report = INPUT cb_report .
    DISP cb_report WITH FRAME fr_main .
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME cb_search
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cb_search c-wins
ON VALUE-CHANGED OF cb_search IN FRAME fr_main
DO:
    cb_search = INPUT cb_search .
    DISP cb_search WITH FRAME fr_main .
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_filename
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_filename c-wins
ON LEAVE OF fi_filename IN FRAME fr_main
DO:
    fi_filename = INPUT fi_filename.
    DISP fi_filename WITH FRAM fr_main.

    IF fi_filename <> ""  THEN DO:
        IF (cb_report = "Hold") THEN DO:
             ASSIGN nv_file = IF INDEX(fi_filename,"CSV") <> 0 THEN SUBSTRING(fi_filename,1,(LENGTH(fi_filename) - 4)) + "_Hold.CSV"
                              ELSE TRIM(fi_filename) + "_Hold.CSV" .
        END.
        IF (cb_report = "CA") THEN DO:
            ASSIGN nv_file = IF INDEX(fi_filename,"CSV") <> 0 THEN SUBSTRING(fi_filename,1,(LENGTH(fi_filename) - 4)) + "_CA.CSV"
                              ELSE TRIM(fi_filename) + "_CA.CSV" .

        END.
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_polfr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_polfr c-wins
ON LEAVE OF fi_polfr IN FRAME fr_main
DO:
  fi_polfr  =  Input  fi_polfr.
  Disp  fi_polfr  with frame  fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_polto
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_polto c-wins
ON LEAVE OF fi_polto IN FRAME fr_main
DO:
    fi_polto = INPUT fi_polto.
  If  Input  fi_polto  <  fi_polfr  Then  fi_polto  =  fi_polfr.
  Else  fi_polto  =  Input fi_polto.
  Disp  fi_polto  with frame  fr_main.
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

    IF ra_new = 1 THEN DO: /*---add by Chaiyong W, A64=0135 13/09/2021*/
        If  cb_search =  "Name"  Then do:              /* name  */
            Open Query br_tlt 
                For each tlt Use-index  tlt01      Where
                tlt.trndat         >=  fi_trndatfr And
                tlt.trndat         <=  fi_trndatto And
                tlt.comp_noti_tlt  >=  fi_polfr    And
                tlt.comp_noti_tlt  <=  fi_polto    AND
                /*---Begin by Chaiyong W. A64-0135 13/09/2021*/
             tlt.note1  = "" AND
            tlt.note2    =  ""  AND
             /*End by Chaiyong W. A64-0135 13/09/2021-----*/
                tlt.genusr          =  "KK"        And
                index(tlt.ins_name,fi_search) <> 0 no-lock.
                    Apply "Entry"  to br_tlt.
                    Return no-apply.            
        END.
        ELSE If  cb_search  = "REKK"  Then do:   /* rekk */
            Open Query br_tlt 
                For each tlt Use-index  tlt01     Where
                tlt.trndat        >=  fi_trndatfr And 
                tlt.trndat        <=  fi_trndatto And 
                tlt.comp_noti_tlt >=  fi_polfr    AND 
                tlt.comp_noti_tlt <=  fi_polto    AND 
                /*---Begin by Chaiyong W. A64-0135 13/09/2021*/
             tlt.note1  = "" AND
            tlt.note2    =  ""  AND
             /*End by Chaiyong W. A64-0135 13/09/2021-----*/
                tlt.genusr         =  "KK"        And 
                index(tlt.comp_noti_tlt,fi_search) <> 0  no-lock.
                    Apply "Entry"  to br_tlt.
                    Return no-apply.        
        END.
        ELSE If  cb_search  = "KK-APP"  Then do:   /* kk-app */
            Open Query br_tlt 
                For each tlt Use-index  tlt01     Where
                tlt.trndat        >=  fi_trndatfr And 
                tlt.trndat        <=  fi_trndatto And 
                tlt.comp_noti_tlt >=  fi_polfr    AND 
                tlt.comp_noti_tlt <=  fi_polto    AND 
                /*---Begin by Chaiyong W. A64-0135 13/09/2021*/
             tlt.note1  = "" AND
            tlt.note2    =  ""  AND
             /*End by Chaiyong W. A64-0135 13/09/2021-----*/
                tlt.genusr         =  "KK"        And 
                tlt.expotim        =  trim(fi_search)  no-lock.
                    Apply "Entry"  to br_tlt.
                    Return no-apply.        
        END.
        ELSE If  cb_search  = "Chassis"  Then do:     /* chassis no */
            Open Query br_tlt 
                For each tlt Use-index  tlt06      Where
                tlt.trndat         >=  fi_trndatfr  And
                tlt.trndat         <=  fi_trndatto  And
                tlt.comp_noti_tlt  >=  fi_polfr     AND 
                tlt.comp_noti_tlt  <=  fi_polto     AND 
                /*---Begin by Chaiyong W. A64-0135 13/09/2021*/
             tlt.note1  = "" AND
            tlt.note2    =  ""  AND
             /*End by Chaiyong W. A64-0135 13/09/2021-----*/
                tlt.genusr         =  "KK"          And
                INDEX(tlt.cha_no,trim(fi_search)) <> 0 no-lock.
                    Apply "Entry"  to br_tlt.
                    Return no-apply.            
        END.
        ELSE If  cb_search  =  "Cover"  Then do:     /* cover*/
            Open Query br_tlt 
                For each tlt Use-index  tlt01      Where
                tlt.trndat         >=  fi_trndatfr And
                tlt.trndat         <=  fi_trndatto And
                tlt.comp_noti_tlt  >=  fi_polfr    AND 
                tlt.comp_noti_tlt  <=  fi_polto    AND 
                /*---Begin by Chaiyong W. A64-0135 13/09/2021*/
             tlt.note1  = "" AND
            tlt.note2    =  ""  AND
             /*End by Chaiyong W. A64-0135 13/09/2021-----*/
                tlt.genusr          =  "KK"        And
                INDEX(tlt.OLD_eng,"Cover") <> 0    no-lock.
                    Apply "Entry"  to br_tlt.  
                    Return no-apply.           
        END.                                   
        ELSE If  cb_search  =  "Hold"  Then do:     /* hold */
            Open Query br_tlt                  
                For each tlt Use-index  tlt01      Where
                tlt.trndat         >=  fi_trndatfr And
                tlt.trndat         <=  fi_trndatto And
                tlt.comp_noti_tlt  >=  fi_polfr    AND 
                tlt.comp_noti_tlt  <=  fi_polto    AND 
                /*---Begin by Chaiyong W. A64-0135 13/09/2021*/
             tlt.note1  = "" AND
            tlt.note2    =  ""  AND
             /*End by Chaiyong W. A64-0135 13/09/2021-----*/
                tlt.genusr          =  "KK"        And
                INDEX(tlt.OLD_eng,"Hold")  <> 0    AND 
                INDEX(tlt.OLD_eng,"cancel") = 0    no-lock.
                    Apply "Entry"  to br_tlt.  
                    Return no-apply.           
        END.                                   
        ELSE If  cb_search  =  "Cancel"  Then do:    /* cancel */
            Open Query br_tlt                    
                For each tlt Use-index  tlt01       Where
                tlt.trndat         >=  fi_trndatfr  And
                tlt.trndat         <=  fi_trndatto  And
                tlt.comp_noti_tlt  >=  fi_polfr     And  
                tlt.comp_noti_tlt  <=  fi_polto     And 
                /*---Begin by Chaiyong W. A64-0135 13/09/2021*/
             tlt.note1  = "" AND
            tlt.note2    =  ""  AND
             /*End by Chaiyong W. A64-0135 13/09/2021-----*/
                tlt.genusr          =  "KK"         And
                INDEX(tlt.OLD_eng,"Cancel") > 0     no-lock.
                    Apply "Entry"  to br_tlt.
                    Return no-apply.                             
        END.
        ELSE If  cb_search  =  "Yes"  Then do:    /* YES */
            Open Query br_tlt                    
                For each tlt Use-index  tlt01       Where
                tlt.trndat         >=  fi_trndatfr  And
                tlt.trndat         <=  fi_trndatto  And
                tlt.comp_noti_tlt  >=  fi_polfr     And  
                tlt.comp_noti_tlt  <=  fi_polto     And 
                /*---Begin by Chaiyong W. A64-0135 13/09/2021*/
             tlt.note1  = "" AND
            tlt.note2    =  ""  AND
             /*End by Chaiyong W. A64-0135 13/09/2021-----*/
                tlt.genusr          =  "KK"         And
                INDEX(tlt.releas,"yes") <> 0     no-lock.
                    Apply "Entry"  to br_tlt.
                    Return no-apply.                             
        END.
        ELSE If  cb_search  =  "No"  Then do:    /* NO */
            Open Query br_tlt                    
                For each tlt Use-index  tlt01       Where
                tlt.trndat         >=  fi_trndatfr  And
                tlt.trndat         <=  fi_trndatto  And
                tlt.comp_noti_tlt  >=  fi_polfr     And  
                tlt.comp_noti_tlt  <=  fi_polto     And 
                /*---Begin by Chaiyong W. A64-0135 13/09/2021*/
             tlt.note1  = "" AND
            tlt.note2    =  ""  AND
             /*End by Chaiyong W. A64-0135 13/09/2021-----*/
                tlt.genusr          =  "KK"         And
                INDEX(tlt.releas,"No") <> 0    no-lock.
                    Apply "Entry"  to br_tlt.
                    Return no-apply.                             
        END.
        ELSE If  cb_search  =  "CA"  Then do:    /* ca */
            Open Query br_tlt                    
                For each tlt Use-index  tlt01       Where
                tlt.trndat         >=  fi_trndatfr  And
                tlt.trndat         <=  fi_trndatto  And
                tlt.comp_noti_tlt  >=  fi_polfr     And  
                tlt.comp_noti_tlt  <=  fi_polto     And 
                tlt.genusr          =  "KK"         And
                /*---Begin by Chaiyong W. A64-0135 13/09/2021*/
             tlt.note1  = "" AND
            tlt.note2    =  ""  AND
             /*End by Chaiyong W. A64-0135 13/09/2021-----*/
                INDEX(tlt.releas,"ca") <> 0     no-lock.
                    Apply "Entry"  to br_tlt.
                    Return no-apply.                             
        END.
         /*----begin by Chaiyong W. A64-0135 13/09/2021*/
        ELSE If  cb_search  =  "Policy"  Then do:   
            Open Query br_tlt                    
                For each tlt Use-index  tlt01       Where
                tlt.trndat         >=  fi_trndatfr  And
                tlt.trndat         <=  fi_trndatto  And
                tlt.comp_noti_tlt  >=  fi_polfr     And  
                tlt.comp_noti_tlt  <=  fi_polto     And 
             tlt.note1  = "" AND
            tlt.note2    =  ""  AND
 
                tlt.genusr          =  "KK"         And
                INDEX(tlt.policy,trim(fi_search)) <> 0   no-lock.
                    Apply "Entry"  to br_tlt.
                    Return no-apply.                             
        END.
        ELSE If  cb_search  =  "Renew"  Then do:    
            Open Query br_tlt                    
                For each tlt Use-index  tlt01       Where
                tlt.trndat         >=  fi_trndatfr  And
                tlt.trndat         <=  fi_trndatto  And
                tlt.comp_noti_tlt  >=  fi_polfr     And  
                tlt.comp_noti_tlt  <=  fi_polto     And 
             tlt.note1  = "" AND
            tlt.note2    =  ""  AND
                tlt.genusr          =  "KK"         And
                INDEX(tlt.note5,"RENEW") <> 0   no-lock.
                    Apply "Entry"  to br_tlt.
                    Return no-apply.                             
        END.
        ELSE If  cb_search  =  "New"  Then do:   
            Open Query br_tlt                    
                For each tlt Use-index  tlt01       Where
                tlt.trndat         >=  fi_trndatfr  And
                tlt.trndat         <=  fi_trndatto  And
                tlt.comp_noti_tlt  >=  fi_polfr     And  
                tlt.comp_noti_tlt  <=  fi_polto     And 
             tlt.note1  = "" AND
            tlt.note2    =  ""  AND
                tlt.genusr          =  "KK"         And
                INDEX(tlt.note5,"RENEW") = 0   no-lock.
                    Apply "Entry"  to br_tlt.
                    Return no-apply.                             
        END.
        /*End by Chaiyong W. A64-0135 13/09/2021----*/
        
        Else DO:
            Apply "Entry"  to  fi_search.
            Return no-apply.
        END.
    /*---Begin by Chaiyong W. A64-0135 13/09/2021*/
    END.
    ELSE DO:
        RUN pd_search.
           
    END.
    /*End by Chaiyong W. A64-0135 13/09/2021-----*/
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


&Scoped-define SELF-NAME ra_new
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_new c-wins
ON VALUE-CHANGED OF ra_new IN FRAME fr_main
DO:
   ra_new = INPUT ra_new.
   IF ra_new = 1 THEN DO:
       ra_type = 3.
       DISABLE ra_type WITH FRAME fr_main.
       
   END.
   ELSE DO:
       ra_type = 3.
       ENABLE ra_type WITH FRAME fr_main.

   END.
   DISP ra_type  WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ra_type
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_type c-wins
ON VALUE-CHANGED OF ra_type IN FRAME fr_main
DO:
    ra_type = INPUT ra_type.
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
    gv_prgid = "wgwqukk0".
    gv_prog  = "Query & Update  Detail  (KK  co.,ltd.) ".
    RUN  WUT\WUTHEAD ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).
    ASSIGN 
        fi_trndatfr = TODAY
        fi_trndatto = TODAY
        /*ra_choice   =  1 */  /*a61-0335*/
        cb_search   = "Name"   /*a61-0335*/
        /*
        fi_polfr    = "0"  comment by Chaiyong W. A64-0135 08/09/2021*/
        fi_polto    = "Z" 
        /*ra_report   = 1.*/    /*a61-0335*/
        cb_report   = "Cover" . /*a61-0335*/
    FOR EACH brstat.tlt WHERE 
        brstat.tlt.genusr    = "KK"    AND
        brstat.tlt.rec_addr5 = ""      AND 
        brstat.tlt.ins_name  = "" .
        DELETE brstat.tlt.
    END.
    Disp fi_trndatfr  fi_trndatto /*ra_choice A61-0335*/  fi_polfr  cb_search cb_report /*a61-0335*/
         fi_polto /*ra_report*/  with frame fr_main.
    /*********************************************************************/ 
    /*  RUN Wut\WutwiCen ({&WINDOW-NAME}:HANDLE). */ 
    /*CURRENT-WINDOW:WINDOW-STATE = WINDOW-MAXIMIZED.*/
    SESSION:DATA-ENTRY-RETURN = YES.
    
    Rect-333:Move-to-top().
    Rect-338:Move-to-top().  
    RECT-346:Move-to-top(). 
   /* Rect-339:Move-to-top().   */ 
    
    IF NOT THIS-PROCEDURE:PERSISTENT THEN
        WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-proc_report2 c-wins 
PROCEDURE 00-proc_report2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*add by Kridtiya i. A55-0029....30/01/2012 modify  .slk >> .csv */
/*DEF VAR   nv_cnt   as  int  init   1.
DEF VAR   nv_row   as  int  init   0.
DEF VAR   n_record AS  INTE INIT   0.
/* add by : A65-0288 */
DEF VAR nv_first    AS CHAR .
def var nv_Brancho  as char .
def var nv_dealero  as char .
def var nv_campno   as char .
def var  nv_ispno             as char no-undo init "".
def var  nv_ispappoit         as char no-undo init "".
def var  nv_ispupdate         as char no-undo init "".
def var  nv_isplocal          as char no-undo init "".
def var  nv_ispclose          as char no-undo init "".
def var  nv_ispresult         as char no-undo init "".
def var  nv_ispdam            as char no-undo init "".
def var  nv_ispacc            as char no-undo init "".
/* end : A65-0288 */
ASSIGN 
    n_record = 0
    nv_cnt   = 0
    nv_row   = 1  .
If  substr(fi_filename,length(fi_filename) - 3,4) <>  ".csv"  THEN 
    fi_filename  =  Trim(fi_filename) + ".csv"  .

OUTPUT TO VALUE(fi_filename). 
EXPORT DELIMITER "|" 
    "บริษัทเงินทุน ธนาคารเกียรตินาคิน จำกัด (มหาชน) ." .
EXPORT DELIMITER "|" 
    "ลำดับที่"                           
    "วันที่รับแจ้ง"                      
    "วันที่รับเงินค่าเบิ้ยประกัน"        
    "รายชื่อบริษัทประกันภัย"             
    "เลขที่สัญญาเช่าซื้อ"                
    "เลขที่กรมธรรม์เดิม"                 
    "รหัสสาขา"                           
    "สาขา KK"                            
    "เลขรับเเจ้ง"                        
    "Campaign"                           
    "Sub Campaign"                       
    "บุคคล/นิติบุคคล"                    
    "คำนำหน้าชื่อ"                       
    "ชื่อผู้เอาประกัน"                   
    "นามสกุลผู้เอาประกัน"                
    "บ้านเลขที่"                         
    "ตำบล/แขวง"                          
    "อำเภอ/เขต"                          
    "จังหวัด"                            
    "รหัสไปรษณีย์"                      
    "ประเภทความคุ้มครอง"                
    "ประเภทการซ่อม"                     
    "วันเริ่มคุ้มครอง"                  
    "วันสิ้นสุดคุ้มครอง"                
    "รหัสรถ"                            
    "ประเภทประกันภัยรถยนต์"             
    "ชื่อยี่ห้อรถ"                      
    "รุ่นรถ"                            
    "New/Used"                          
    "เลขทะเบียน"                        
    "เลขตัวถัง"                         
    "เลขเครื่องยนต์"                    
    "ปีรถยนต์"                          
    "ซีซี"                              
    "น้ำหนัก/ตัน"                       
    "ทุนประกันปี 1 "                    
    "เบี้ยรวมภาษีเเละอากรปี 1"          
    "ทุนประกันปี 2" 
    "ทุนประกันรถยนต์สูญหาย/ไฟไหม้ ปี2(F&T)" /*A60-0232*/
    "เบี้ยรวมภาษีเเละอากรปี 2"          
    "เวลารับเเจ้ง"                      
    "ชื่อเจ้าหน้าที่ MKT"               
    "หมายเหตุ"                          
    "ผู้ขับขี่ที่ 1 เเละวันเกิด"        
    "ผู้ขับขี่ที่ 2 เเละวันเกิด"         
    "คำนำหน้าชื่อ (ใบเสร็จ/ใบกำกับภาษี)" 
    "ชื่อ (ใบเสร็จ/ใบกำกับภาษี)"         
    "นามสกุล (ใบเสร็จ/ใบกำกับภาษี)"      
    "บ้านเลขที่ (ใบเสร็จ/ใบกำกับภาษี)"   
    "ตำบล/แขวง (ใบเสร็จ/ใบกำกับภาษี)"    
    "อำเภอ/เขต (ใบเสร็จ/ใบกำกับภาษี)"    
    "จังหวัด (ใบเสร็จ/ใบกำกับภาษี)"      
    "รหัสไปรษณีย์ (ใบเสร็จ/ใบกำกับภาษี)" 
    "ส่วนลดประวัติดี"                    
    "ส่วนลดงาน Fleet" 
    "เบอร์ติดต่อ "                 /*A60-0232*/
    "เลขที่บัตรประชาชน"            /*A60-0232*/
    "วันเดือนปีเกิด   "            /*A60-0232*/
    "อาชีพ            "            /*A60-0232*/
    "สถานภาพ          "            /*A60-0232*/
    "เลขประจำตัวผู้เสียภาษีอากร"   /*A60-0232*/
    "คำนำหน้าชื่อ 1  "             /*A60-0232*/
    "ชื่อกรรมการ 1   "             /*A60-0232*/
    "นามสกุลกรรมการ 1"             /*A60-0232*/
    "เลขที่บัตรประชาชนกรรมการ 1"   /*A60-0232*/
    "คำนำหน้าชื่อ 2   "            /*A60-0232*/
    "ชื่อกรรมการ 2    "            /*A60-0232*/
    "นามสกุลกรรมการ 2 "            /*A60-0232*/
    "เลขที่บัตรประชาชนกรรมการ 2"   /*A60-0232*/
    "คำนำหน้าชื่อ 3   "            /*A60-0232*/
    "ชื่อกรรมการ 3    "            /*A60-0232*/
    "นามสกุลกรรมการ 3 "            /*A60-0232*/
    "เลขที่บัตรประชาชนกรรมการ 3"   /*A60-0232*/
    "จัดส่งเอกสารที่สาขา "   /*A61-0335*/  
    "ชื่อผู้รับเอกสาร    "   /*A61-0335*/  
    "ผู้รับผลประโยชน์    "   /*A61-0335*/  
    "KK ApplicationNo    "   /*A61-0335*/  
    "Remak1"                       
    "Remak2" 
    "Dealer"        /* A63-00472*/
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
    "Release"       /* A56-0309 */                      
    .
FOR EACH tlt Use-index  tlt01  Where
    tlt.trndat        >=   fi_trndatfr   And
    tlt.trndat        <=   fi_trndatto   And
    tlt.comp_noti_tlt >=   fi_polfr      And
    tlt.comp_noti_tlt <=   fi_polto      And
    tlt.genusr   =  "KK"                 no-lock. 
    /*--Begin by Chaiyong W. A64-0135 13/09/2021*/
    IF ra_new = 2 THEN DO: 
        IF ( tlt.note1     <> "" OR tlt.note2    <>  ""  )  THEN DO:
        END.
        ELSE NEXT.
    END.
    ELSE DO:
        IF ( tlt.note1     =  "" OR tlt.note2   =   ""  )  THEN DO:
        END.
        ELSE NEXT.
    END.
    IF ra_type = 1 THEN DO:
        IF index(tlt.note5,"renew") <> 0 THEN NEXT .
    END.
    ELSE IF ra_type = 2 THEN DO:
        IF index(tlt.note5,"renew") = 0 THEN NEXT.
    END.
    /*End by Chaiyong W. A64-0135 13/09/2021----*/
    IF      (cb_report = "Cover") AND (index(tlt.OLD_eng,"COVER") = 0 )  THEN NEXT.
    ELSE IF (cb_report = "Hold") AND (INDEX(tlt.OLD_eng,"hold") = 0 ) AND (INDEX(tlt.OLD_eng,"Cancel") <> 0 )  THEN NEXT.
    ELSE IF (cb_report = "Cancel") AND (index(tlt.OLD_eng,"CANCEL_HOLD") = 0 ) THEN NEXT.
    ELSE IF (cb_report = "Yes")  AND (index(tlt.Releas,"yes") = 0 ) THEN NEXT.     /* A56-0309 */
    ELSE IF (cb_report = "No")  AND (index(tlt.Releas,"no") = 0 ) THEN NEXT.      /* A56-0309 */
    ELSE IF (cb_report = "CA")  AND (index(tlt.Releas,"ca") = 0 ) THEN NEXT.      /* A61-0335 */
    /* add by : A65-0288 07/10/2022 */
    ELSE IF (cb_report = "Inspection(Y)")  AND tlt.usrsent = "N"  THEN NEXT.
    ELSE IF (cb_report = "Status-ISP(Y)")  AND tlt.usrsent = "Y" and  tlt.lotno   = "N"  THEN NEXT.
    ELSE IF (cb_report = "Status-ISP(N)")  AND tlt.usrsent = "Y" and  tlt.lotno   = "Y"  THEN NEXT.
    /* end : A65-0288 07/10/2022 */

    ASSIGN n_text  = ""     nv_phone   = ""     nv_icno    = ""     nv_tax     = ""
           nv_cstatus = ""  nv_occup   = ""     nv_icno3   = ""     nv_lname3  = ""
           nv_cname3  = ""  nv_tname3  = ""     nv_icno2   = ""     nv_lname2  = ""
           nv_cname2  = ""  nv_tname2  = ""     nv_icno1   = ""     nv_lname1  = ""
           nv_cname1  = ""  nv_tname1  = ""     
           n_send     = ""  n_sendname = ""     n_bennefit = ""     /*A61-0335*/
           nv_ispno     = ""      nv_ispappoit  = ""       nv_ispupdate  = ""      nv_isplocal   = ""     /* A65-0288*/   
           nv_ispclose  = ""      nv_ispresult  = ""       nv_ispdam     = ""      nv_ispacc     = ""    /* A65-0288*/ 
           nv_first     = ""      nv_Brancho    = ""       nv_dealero    = ""      nv_campno     = ""    /* A65-0288*/
           nv_phone     = IF tlt.expousr <> "" THEN SUBSTR(tlt.expousr,5,INDEX(tlt.expousr,"ICNO:") - 5) ELSE ""
           nv_icno      = IF tlt.expousr <> "" THEN SUBSTR(tlt.expousr,R-INDEX(tlt.expousr,"ICNO:") + 5) ELSE "" 
           /* comment by : A65-0288 07/10/2022....
           n_text       = tlt.usrsent
           nv_tax       = SUBSTR(n_text,R-INDEX(n_text,"Tax:") + 4) 
           n_text       = SUBSTR(n_text,1,LENGTH(n_text) - (LENGTH(nv_tax) + 4))
           nv_cstatus   = SUBSTR(n_text,R-INDEX(tlt.usrsent,"Status:") + 7) 
           nv_occup     = SUBSTR(n_text,7,INDEX(tlt.usrsent,"Status:") - 7)
           n_text       = "" 
           n_text       = tlt.lince3
           nv_icno3     = SUBSTR(n_text,R-INDEX(n_text,"IC3:") + 4)         
           n_text       = SUBSTR(n_text,1,LENGTH(n_text) - (LENGTH(nv_icno3) + 4))
           nv_lname3    = SUBSTR(n_text,R-INDEX(n_text,"L3:") + 3)          
           n_text       = SUBSTR(n_text,1,LENGTH(n_text) - (LENGTH(nv_lname3) + 3))
           nv_cname3    = SUBSTR(n_text,R-INDEX(n_text,"N3:") + 3)          
           n_text       = SUBSTR(n_text,1,LENGTH(n_text) - (LENGTH(nv_cname3) + 3))
           nv_tname3    = SUBSTR(n_text,R-INDEX(n_text,"T3:") + 3)          
           n_text       = SUBSTR(n_text,1,LENGTH(n_text) - (LENGTH(nv_tname3) + 3))
           
           nv_icno2     = SUBSTR(n_text,R-INDEX(n_text,"IC2:") + 4)         
           n_text       = SUBSTR(n_text,1,LENGTH(n_text) - (LENGTH(nv_icno2) + 4))
           nv_lname2    = SUBSTR(n_text,R-INDEX(n_text,"L2:") + 3)          
           n_text       = SUBSTR(n_text,1,LENGTH(n_text) - (LENGTH(nv_lname2) + 3))
           nv_cname2    = SUBSTR(n_text,R-INDEX(n_text,"N2:") + 3)          
           n_text       = SUBSTR(n_text,1,LENGTH(n_text) - (LENGTH(nv_cname2) + 3))
           nv_tname2    = SUBSTR(n_text,R-INDEX(n_text,"T2:") + 3)         
           n_text       = SUBSTR(n_text,1,LENGTH(n_text) - (LENGTH(nv_tname2) + 3))
           
           nv_icno1     = SUBSTR(n_text,R-INDEX(n_text,"IC1:") + 4)         
           n_text       = SUBSTR(n_text,1,LENGTH(n_text) - (LENGTH(nv_icno1) + 4))
           nv_lname1    = SUBSTR(n_text,R-INDEX(n_text,"L1:") + 3)          
           n_text       = SUBSTR(n_text,1,LENGTH(n_text) - (LENGTH(nv_lname1) + 3))
           nv_cname1    = SUBSTR(n_text,R-INDEX(n_text,"N1:") + 3)          
           n_text       = SUBSTR(n_text,1,LENGTH(n_text) - (LENGTH(nv_cname1) + 3))
           nv_tname1    = SUBSTR(n_text,R-INDEX(n_text,"T1:") + 3) 
           end A65-0288....*/
           /* end : a60-0232*/
           n_text      = trim(tlt.comp_noti_ins)                                                    /*A61-0335*/
           n_bennefit  = SUBSTR(n_text,R-INDEX(n_text,"BE:") + 3 )      /* ผู้รับผลประโยชน์ */      /*A61-0335*/
           n_text      = SUBSTR(n_text,1,LENGTH(n_text) - (LENGTH(n_bennefit) + 3 ))                /*A61-0335*/
           n_sendname  = SUBSTR(n_text,R-INDEX(n_text,"SN:") + 3 )  /* ชื่อผู้รับเอกสาร */      /*A61-0335*/
           n_text      = SUBSTR(n_text,1,LENGTH(n_text) - (LENGTH(n_sendname) + 3 ))                /*A61-0335*/
           n_send      = SUBSTR(n_text,R-INDEX(n_text,"SE:") + 3 ).  /* สถานที่จัดส่งเอกสาร */   /*A61-0335*/

        /* Add by : A65-0288 */
        IF tlt.ln_fst <> ?  THEN nv_first =  string(tlt.ln_fst).
        IF tlt.note30 <> "" THEN DO:
            ASSIGN
                nv_Brancho  = trim(substr(tlt.note30,1,100))
                nv_dealero  = trim(substr(tlt.note30,101,100)  ) 
                nv_campno   = trim(substr(tlt.note30,201,100)  )   NO-ERROR.
        END.
        IF tlt.lotno = "Y" THEN DO:
            ASSIGN 
            nv_ispno     = trim(substr(tlt.acno1,1,INDEX(tlt.acno1," ")))  
            nv_ispclose  = trim(SUBSTR(tlt.acno1,R-INDEX(tlt.acno1,"Close Date:") + 12))
            nv_ispresult = IF index(tlt.mobile,"รายการความเสียหาย") <> 0 THEN trim(substr(tlt.mobile,1,index(tlt.mobile,"รายการความเสียหาย") - 2)) ELSE tlt.mobile
            nv_ispdam    = IF index(tlt.mobile,"รายการความเสียหาย") <> 0 THEN trim(substr(tlt.mobile,R-INDEX(tlt.mobile,"รายการความเสียหาย") + 17)) ELSE ""
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
        /* end : A65-0288 */
    ASSIGN n_record = n_record + 1.
    EXPORT DELIMITER "|" 
        n_record                                            
        string(tlt.datesent,"99/99/9999")    FORMAT "x(10)"     
        IF tlt.dat_ins_not = ? THEN "" ELSE string(tlt.dat_ins_not,"99/99/9999") FORMAT "x(10)"     
        trim(tlt.nor_usr_ins)                FORMAT "x(50)"     
        trim(tlt.nor_noti_tlt)               FORMAT "x(20)"     
        trim(tlt.nor_noti_ins)               FORMAT "x(20)"     
        trim(tlt.nor_usr_tlt)                FORMAT "x(10)"         
        trim(tlt.comp_usr_tl)                FORMAT "x(35)"                  
        trim(tlt.comp_noti_tlt)              FORMAT "x(20)"                 
        trim(tlt.dri_no1)                    FORMAT "x(30)"       
        trim(tlt.dri_no2)                    FORMAT "x(30)"       
        trim(tlt.safe2)                      FORMAT "x(30)"       
        substr(trim(tlt.ins_name),1,INDEX(trim(tlt.ins_name)," ") - 1 )         FORMAT "x(20)"                
        substr(trim(tlt.ins_name),INDEX(trim(tlt.ins_name)," ") + 1,r-INDEX(trim(tlt.ins_name)," ") - INDEX(trim(tlt.ins_name)," "))  FORMAT "x(35)"                     
        substr(trim(tlt.ins_name),r-INDEX(trim(tlt.ins_name)," ") + 1 )         FORMAT "x(35)"                   
        trim(tlt.ins_addr1)                 FORMAT "x(80)"               
        trim(tlt.ins_addr2)                 FORMAT "x(40)"                    
        trim(tlt.ins_addr3)                 FORMAT "x(40)"                    
        trim(tlt.ins_addr4)                 FORMAT "x(40)"                    
        trim(tlt.ins_addr5)                 FORMAT "x(15)"                  
        trim(tlt.safe3)                                                     
        trim(tlt.stat)                      FORMAT "x(30)"      
        string(tlt.nor_effdat,"99/99/9999") FORMAT "x(10)" 
        string(tlt.expodat,"99/99/9999")    FORMAT "x(10)" 
        trim(tlt.subins)                    FORMAT "x(10)" 
        trim(tlt.filler2)                   FORMAT "x(40)"               
        trim(tlt.brand)                     FORMAT "x(30)"               
        trim(tlt.model)                     FORMAT "x(45)"               
        trim(tlt.filler1)                   FORMAT "x(20)"  
        trim(tlt.lince1)                    FORMAT "x(35)"  
        trim(tlt.cha_no)                    FORMAT "x(30)"  
        trim(tlt.eng_no)                    FORMAT "x(30)"                  
        trim(tlt.lince2)                    FORMAT "x(10)"  
        string(tlt.cc_weight)               FORMAT "x(10)"                
        trim(tlt.colorcod)                  FORMAT "x(10)"                  
        string(tlt.comp_coamt)                                                   
        string(tlt.comp_grprm)                                                 
        string(tlt.nor_coamt)
        STRING(tlt.endcnt)                  FORMAT "x(15)" /*a60-0232 FI*/
        string(tlt.nor_grprm)                                                    
        string(tlt.gentim)                  FORMAT "x(10)"      
        trim(tlt.comp_usr_in)               FORMAT "x(50)"     
        trim(tlt.safe1)                     FORMAT "x(200)"    
        trim(tlt.dri_name1)                 FORMAT "x(50)"     
        trim(tlt.dri_name2)                 FORMAT "x(50)"     
        trim(tlt.rec_name)                                         
        ""                               
        ""                                         
        trim(tlt.rec_addr1)                        
        trim(tlt.rec_addr2)               
        trim(tlt.rec_addr3)             
        trim(tlt.rec_addr4)              
        trim(tlt.rec_addr5)             
        string(tlt.seqno)                 
        tlt.lotno 
        nv_phone                            FORMAT "x(25)"    /*a60-0232*/
        nv_icno                             FORMAT "x(15)"    /*a60-0232*/
        STRING(tlt.gendat,"99/99/9999")                       /*a60-0232*/
        nv_occup                            FORMAT "x(45)"    /*a60-0232*/
        nv_cstatus                          format "x(20)"    /*a60-0232*/
        nv_tax                              format "x(15)"    /*a60-0232*/
        nv_tname1                           format "x(20)"    /*a60-0232*/
        nv_cname1                           format "x(45)"    /*a60-0232*/
        nv_lname1                           format "x(45)"    /*a60-0232*/
        nv_icno1                            format "x(15)"    /*a60-0232*/
        nv_tname2                           format "x(20)"    /*a60-0232*/
        nv_cname2                           format "x(45)"    /*a60-0232*/
        nv_lname2                           format "x(45)"    /*a60-0232*/
        nv_icno2                            format "x(15)"    /*a60-0232*/
        nv_tname3                           format "x(20)"    /*a60-0232*/
        nv_cname3                           format "x(45)"    /*a60-0232*/
        nv_lname3                           format "x(45)"    /*a60-0232*/
        nv_icno3                            format "x(15)"    /*a60-0232*/
        n_send                              format "x(50)"  /*A61-0335*/
        n_sendname                          format "x(50)"  /*A61-0335*/
        n_bennefit                          FORMAT "x(50)"  /*A61-0335*/
        trim(tlt.expotim)    /* kk app */     /*a61-0335*/                                          
        trim(tlt.OLD_eng)      FORMAT "x(150)" 
        trim(tlt.OLD_cha)      FORMAT "x(150)"
        tlt.usrid  FORMAT "x(20)"            /* A63-00472 เก็บ Dealer*/
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
        tlt.Releas FORMAT "x(10)"    .       /* A56-0309 */
END.   /*  end  wdetail  */
OUTPUT CLOSE. /*----add by Chaiyong W. A64-0135 21/06/2021*/
Message "Export data Complete"  View-as alert-box.*/
/*end.add by Kridtiya i. A55-0029.....30/01/2012 */
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-proc_report3 c-wins 
PROCEDURE 00-proc_report3 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* comment by : A67-0076...
DEF VAR nv_comcod AS CHAR INIT "".
DEF VAR nv_comchr AS CHAR INIT "".
DEF VAR nv_expchr AS CHAR INIT "".
DEF VAR nv_birchr AS CHAR INIT "".
DEF VAR nv_senchr AS CHAR INIT "".
DEF VAR nv_trnchr AS CHAR INIT "".
DEF VAR nv_saddr  AS CHAR INIT "".
DEF VAR nv_first  AS CHAR INIT "".
DEF VAR nv_file   AS CHAR INIT "".
DEF VAR nv_ccom   AS INT INIT 0.
def var nv_Brancho  as char init "".
def var nv_dealero  as char init "".
DEF VAR nv_campno   AS CHAR INIT "".
DEF VAR nv_Seat AS CHAR INIT "".
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
 nv_file  = fi_filename.
    IF INDEX (nv_file,".csv") <> 0 THEN DO:
    END.
    ELSE nv_file = nv_file + ".csv".
OUTPUT TO VALUE(nv_file).
EXPORT DELIMITER "|" 
    "ลำดับที่"                           
    "วันที่รับแจ้ง"                      
    "วันที่รับเงินค่าเบิ้ยประกัน"        
    "รายชื่อบริษัทประกันภัย"             
    "เลขที่สัญญาเช่าซื้อ"   
    "New/Renew"
    "เลขที่กรมธรรม์เดิม"                 
    "รหัสสาขา"                           
    "สาขา KK" 
    "สาขา TMSTH"
    "เลขรับเเจ้ง"   
    "KK Offer Flag"
    "Campaign"                           
    "Sub Campaign"                       
    "บุคคล/นิติบุคคล"                    
    "คำนำหน้าชื่อ"                       
    "ชื่อผู้เอาประกัน"                   
    "นามสกุลผู้เอาประกัน"                
    "บ้านเลขที่"                         
    "ตำบล/แขวง"                          
    "อำเภอ/เขต"                          
    "จังหวัด"                            
    "รหัสไปรษณีย์"                      
    "ประเภทความคุ้มครอง"                
    "ประเภทการซ่อม"                     
    "วันเริ่มคุ้มครอง"                  
    "วันสิ้นสุดคุ้มครอง"                
    "รหัสรถ"                            
    "ประเภทประกันภัยรถยนต์"             
    "ชื่อยี่ห้อรถ"                      
    "รุ่นรถ"                            
    "New/Used"                          
    "เลขทะเบียน"   
    "จังหวัดจดทะเบียน"
    "เลขตัวถัง"                         
    "เลขเครื่องยนต์"                    
    "ปีรถยนต์"                          
    "ซีซี"                              
    "น้ำหนัก/ตัน"  
    "ที่นั่ง"
    "ทุนประกันปี 1 "   
    "เบี้ยสุทธิ"
    "เบี้ยรวมภาษีเเละอากรปี 1"          
 /*   "ทุนประกันปี 2" 
    "ทุนประกันรถยนต์สูญหาย/ไฟไหม้ ปี2(F&T)" /*A60-0232*/
    "เบี้ยรวมภาษีเเละอากรปี 2"  */           
    "เวลารับเเจ้ง"                      
    "ชื่อเจ้าหน้าที่ MKT"               
    "หมายเหตุ"                          
    "ผู้ขับขี่ที่ 1     "
    "วันเกิดผู้ขับขี่ 1 "
    "เลขที่ใบขับขี่ 1   "
    "ผู้ขับขี่ที่ 2     "
    "วันเกิดผู้ขับขี่ 2 "
    "เลขที่ใบขับขี่ 2   "
    "คำนำหน้าชื่อ (ใบเสร็จ/ใบกำกับภาษี)" 
    "ชื่อ (ใบเสร็จ/ใบกำกับภาษี)"         
    "นามสกุล (ใบเสร็จ/ใบกำกับภาษี)"      
    "บ้านเลขที่ (ใบเสร็จ/ใบกำกับภาษี)"   
    "ตำบล/แขวง (ใบเสร็จ/ใบกำกับภาษี)"    
    "อำเภอ/เขต (ใบเสร็จ/ใบกำกับภาษี)"    
    "จังหวัด (ใบเสร็จ/ใบกำกับภาษี)"      
    "รหัสไปรษณีย์ (ใบเสร็จ/ใบกำกับภาษี)" 
    "ส่วนลดประวัติดี"                    
    "ส่วนลดงาน Fleet" 
    "เบอร์ติดต่อ "                 /*A60-0232*/
    "เลขที่บัตรประชาชน"            /*A60-0232*/
    "วันเดือนปีเกิด   "            /*A60-0232*/
    "อาชีพ            "            /*A60-0232*/
    "สถานภาพ          "            /*A60-0232*/
    "เพศ              "
    "สัญชาติ          "
    "อีเมลล์          "
    "เลขประจำตัวผู้เสียภาษีอากร"   /*A60-0232*/
    "คำนำหน้าชื่อ 1  "             /*A60-0232*/
    "ชื่อกรรมการ 1   "             /*A60-0232*/
    "นามสกุลกรรมการ 1"             /*A60-0232*/
    "เลขที่บัตรประชาชนกรรมการ 1"   /*A60-0232*/
    "คำนำหน้าชื่อ 2   "            /*A60-0232*/
    "ชื่อกรรมการ 2    "            /*A60-0232*/
    "นามสกุลกรรมการ 2 "            /*A60-0232*/
    "เลขที่บัตรประชาชนกรรมการ 2"   /*A60-0232*/
    "คำนำหน้าชื่อ 3   "            /*A60-0232*/
    "ชื่อกรรมการ 3    "            /*A60-0232*/
    "นามสกุลกรรมการ 3 "            /*A60-0232*/
    "เลขที่บัตรประชาชนกรรมการ 3"   /*A60-0232*/
    "จัดส่งเอกสารที่สาขา "   /*A61-0335*/  
    "ชื่อผู้รับเอกสาร    "   /*A61-0335*/  
    "ผู้รับผลประโยชน์    "   /*A61-0335*/  
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
    "Inspection Detail / Inspection Update"                     
    "inspection Damage/ Inspection Appiontment Date"            
    "inspection Accessory / Inspection Appiontment Location" 
    /* end : A65-0288 */
   SKIP .
OUTPUT CLOSE.

RUN wuw\wuwppics3(INPUT TODAY,INPUT "COMP_CODE",OUTPUT nv_comcod).
IF nv_comcod = "" THEN nv_comcod= "TMSTH".

FOR EACH tlt Use-index  tlt01  Where
    tlt.trndat        >=   fi_trndatfr   And
    tlt.trndat        <=   fi_trndatto   And
    tlt.comp_noti_tlt >=   fi_polfr      And
    tlt.comp_noti_tlt <=   fi_polto      And
    tlt.genusr   =  "KK"                 NO-LOCK:
    /*--Begin by Chaiyong W. A64-0135 13/09/2021*/
    IF ra_new = 2 THEN DO: 
        IF ( tlt.note1     <> "" OR tlt.note2    <>  ""  )  THEN DO:
        END.
        ELSE NEXT.
    END.
    ELSE DO:
        IF ( tlt.note1     =  "" OR tlt.note2   =   ""  )  THEN DO:
        END.
        ELSE NEXT.
    END.
    IF ra_type = 1 THEN DO:
        IF index(tlt.note5,"renew") <> 0 THEN NEXT.
    END.
    ELSE IF ra_type = 2 THEN DO:
        IF index(tlt.note5,"renew") = 0 THEN NEXT.
    END.
    /*End by Chaiyong W. A64-0135 13/09/2021----*/

    IF      (cb_report = "Cover") AND (index(tlt.OLD_eng,"COVER") = 0 )  THEN NEXT.
    ELSE IF (cb_report = "Hold") AND (INDEX(tlt.OLD_eng,"hold") = 0 ) AND (INDEX(tlt.OLD_eng,"Cancel") <> 0 )  THEN NEXT.
    ELSE IF (cb_report = "Cancel") AND (index(tlt.OLD_eng,"CANCEL_HOLD") = 0 ) THEN NEXT.
    ELSE IF (cb_report = "Yes")  AND (index(tlt.Releas,"yes") = 0 ) THEN NEXT.     /* A56-0309 */
    ELSE IF (cb_report = "No")  AND (index(tlt.Releas,"no") = 0 ) THEN NEXT.      /* A56-0309 */
    ELSE IF (cb_report = "CA")  AND (index(tlt.Releas,"ca") = 0 ) THEN NEXT. 
     /* add by : A65-0288 07/10/2022 */
    ELSE IF (cb_report = "Inspection(Y)")   THEN DO: 
        IF (tlt.usrsent = "Y") THEN DO: 
        END.
        ELSE NEXT.
    END.
    ELSE IF (cb_report = "Status-ISP(Y)") THEN DO: 
        IF tlt.usrsent = "Y"  AND  tlt.lotno  = "Y"  THEN DO:
        END.
        ELSE NEXT.
    END.
    ELSE IF (cb_report = "Status-ISP(N)")  THEN DO: 
        IF tlt.usrsent = "Y" and  tlt.lotno   = "N"  THEN DO:
        END.
        ELSE  NEXT.
    END.
    /* end : A65-0288 07/10/2022 */
ASSIGN
    n_text     = "" 
   /* n_text     = tlt.lince3
    nv_icno3   = ""
    nv_lname3  = ""
    nv_cname3  = ""
    nv_tname3  = ""
    nv_icno2   = ""
    nv_lname2  = ""
    nv_cname2  = ""
    nv_tname2  = ""
    nv_icno1   = ""
    nv_lname1  = ""
    nv_cname1  = ""
    nv_tname1  = ""*/
    nv_Brancho  = ""
    nv_dealero  = ""
    nv_seat     = ""
    nv_campno   = ""
    .
    IF tlt.note30 <> "" THEN DO:
        ASSIGN
            nv_Brancho  = trim(substr(tlt.note30,1,100))
            nv_dealero  = trim(substr(tlt.note30,101,100))  
            nv_campno   = trim(substr(tlt.note30,201,100))
            
            NO-ERROR.
    
    END.
    /* comment by : A65-0288...     
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
    IF  tlt.ln_fst <> ?  THEN nv_first =  string(tlt.ln_fst).
    ASSIGN
        nv_comchr  = ""
        nv_expchr  = ""
        nv_birchr  = ""
        nv_senchr  = ""
        nv_trnchr  = ""
        nv_saddr   = ""
        nv_first   = ""
    nv_ccom  = nv_ccom  + 1.
    IF tlt.note26  <> "" THEN nv_trnchr = tlt.note26 .
    ELSE IF tlt.ndate1  <> ? THEN  nv_trnchr = string(tlt.ndate1    ,"99/99/9999") .
    
    if tlt.nor_effdat <> ? then nv_comchr    = string(tlt.nor_effdat,"99/99/9999").   
    if tlt.expodat    <> ? then nv_expchr    = string(tlt.expodat   ,"99/99/9999").   
    IF tlt.gendat  <> ? THEN  nv_birchr   = STRING(tlt.gendat,"99/99/9999").
    IF tlt.datesent  <> ? THEN nv_senchr = STRING(tlt.datesent ,"99/99/9999").
    
    IF tlt.hrg_adddr <> "" THEN nv_saddr = tlt.hrg_adddr.
    ELSE DO:
        IF tlt.hrg_no   <> "" AND index(tlt.hrg_no,"เลขที่") = 0  THEN nv_saddr = "เลขที่ " + tlt.hrg_no                              .
        IF tlt.hrg_moo  <> ""  THEN nv_saddr = nv_saddr + " หมู่ "  + tlt.hrg_moo                  .
        IF tlt.hrg_vill <> ""  THEN nv_saddr =  nv_saddr + " อาคาร "    + tlt.hrg_vill             .
        IF tlt.hrg_floor <> "" THEN nv_saddr =  nv_saddr + " ชั้น "    + tlt.hrg_floor             .
        IF tlt.hrg_room  <> "" THEN nv_saddr =  nv_saddr + " ห้อง "    + tlt.hrg_room              .
        IF tlt.hrg_soi   <> "" THEN nv_saddr   = nv_saddr + " ซอย "    + tlt.hrg_soi               .
        IF tlt.hrg_street    <> "" THEN nv_saddr   = nv_saddr + " ถนน "      + tlt.hrg_street      .
        IF tlt.hrg_district <> "" THEN do:  
            
            IF INDEX( tlt.ins_addr4,"กรุงเทพ") <> 0  THEN nv_saddr  = nv_saddr + " แขวง " + trim(tlt.hrg_district).
            ELSE nv_saddr  = nv_saddr + " ตำบล " + trim(tlt.hrg_district).
        end.
        IF tlt.hrg_subdistrict   <> "" THEN do:  
            IF INDEX( tlt.ins_addr4,"กรุงเทพ") <> 0  THEN nv_saddr   = nv_saddr + " เขต " + trim(tlt.hrg_subdistrict).
            ELSE nv_saddr   = nv_saddr + " อำเภอ " + trim(tlt.hrg_subdistrict).
        end.
        nv_saddr = trim(trim(nv_saddr + " " + tlt.hrg_prov) + " " + tlt.hrg_postcd ).
    END.
    
    nv_Seat = "".
    IF tlt.noteveh1 = "21" THEN nv_Seat = "15".
    ELSE if tlt.noteveh1 = "22" THEN nv_Seat = "20".
    ELSE if tlt.noteveh1 = "23" THEN nv_Seat = "40".
    ELSE if tlt.noteveh1 = "24" THEN nv_Seat = "41".

    IF tlt.lotno = "Y" THEN DO:
        ASSIGN 
        nv_ispno     = trim(substr(tlt.acno1,1,INDEX(tlt.acno1," ")))  
        nv_ispclose  = trim(SUBSTR(tlt.acno1,R-INDEX(tlt.acno1,"Close Date:") + 12))
        nv_ispresult = IF index(tlt.mobile,"รายการความเสียหาย") <> 0 THEN trim(substr(tlt.mobile,1,index(tlt.mobile,"รายการความเสียหาย") - 2)) ELSE tlt.mobile
        nv_ispdam    = IF index(tlt.mobile,"รายการความเสียหาย") <> 0 THEN trim(substr(tlt.mobile,R-INDEX(tlt.mobile,"รายการความเสียหาย") + 17)) ELSE ""
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
    
    OUTPUT TO VALUE(nv_file) APPEND.
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
    nv_Brancho
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
    tlt.prem_amt /*  tlt.note12*/
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
Message "Export data Complete"  View-as alert-box.*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

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
  DISPLAY ra_type ra_new cb_search fi_trndatfr fi_trndatto fi_polfr fi_polto 
          fi_search fi_filename cb_report 
      WITH FRAME fr_main IN WINDOW c-wins.
  ENABLE ra_type ra_new cb_search fi_trndatfr fi_trndatto fi_polfr fi_polto 
         bu_ok fi_search bu_sch fi_filename bu_reok bu_exit br_tlt cb_report 
         RECT-332 RECT-333 RECT-338 RECT-340 RECT-341 RECT-343 RECT-344 
         RECT-346 
      WITH FRAME fr_main IN WINDOW c-wins.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW c-wins.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_search c-wins 
PROCEDURE pd_search :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
If  cb_search =  "Name"  Then do:              /* name  */
    Open Query br_tlt 
        For each tlt Use-index  tlt01      Where
        tlt.trndat         >=  fi_trndatfr And
        tlt.trndat         <=  fi_trndatto And
        tlt.comp_noti_tlt  >=  fi_polfr    And
        tlt.comp_noti_tlt  <=  fi_polto    AND
        ( tlt.note1     <> "" OR
    tlt.note2    <>  "") AND
        tlt.genusr          =  "KK"        And
        index(tlt.ins_name,fi_search) <> 0 no-lock.
            Apply "Entry"  to br_tlt IN FRAME fr_main.
            Return no-apply.            
END.
ELSE If  cb_search  = "REKK"  Then do:   /* rekk */
    Open Query br_tlt 
        For each tlt Use-index  tlt01     Where
        tlt.trndat        >=  fi_trndatfr And 
        tlt.trndat        <=  fi_trndatto And 
        tlt.comp_noti_tlt >=  fi_polfr    AND 
        tlt.comp_noti_tlt <=  fi_polto    AND 
        ( tlt.note1     <> "" OR
    tlt.note2    <>  "") AND
        tlt.genusr         =  "KK"        And 
        index(tlt.comp_noti_tlt,fi_search) <> 0  no-lock.
            Apply "Entry"  to br_tlt IN FRAME fr_main.
            Return no-apply.        
END.
ELSE If  cb_search  = "KK-APP"  Then do:   /* kk-app */
    Open Query br_tlt 
        For each tlt Use-index  tlt01     Where
        tlt.trndat        >=  fi_trndatfr And 
        tlt.trndat        <=  fi_trndatto And 
        tlt.comp_noti_tlt >=  fi_polfr    AND 
        tlt.comp_noti_tlt <=  fi_polto    AND 
        ( tlt.note1     <> "" OR
    tlt.note2    <> "" ) AND
        tlt.genusr         =  "KK"        And 
        tlt.expotim        =  trim(fi_search)  no-lock.
            Apply "Entry"  to br_tlt IN FRAME fr_main.
            Return no-apply.        
END.
ELSE If  cb_search  = "Chassis"  Then do:     /* chassis no */
    Open Query br_tlt 
        For each tlt Use-index  tlt06      Where
        tlt.trndat         >=  fi_trndatfr  And
        tlt.trndat         <=  fi_trndatto  And
        tlt.comp_noti_tlt  >=  fi_polfr     AND 
        tlt.comp_noti_tlt  <=  fi_polto     AND 
        ( tlt.note1     <> "" OR
    tlt.note2    <> "" ) AND
        tlt.genusr         =  "KK"          And
        INDEX(tlt.cha_no,trim(fi_search)) <> 0 no-lock.
            Apply "Entry"  to br_tlt IN FRAME fr_main.
            Return no-apply.            
END.
ELSE If  cb_search  =  "Cover"  Then do:     /* cover*/
    Open Query br_tlt 
        For each tlt Use-index  tlt01      Where
        tlt.trndat         >=  fi_trndatfr And
        tlt.trndat         <=  fi_trndatto And
        tlt.comp_noti_tlt  >=  fi_polfr    AND 
        tlt.comp_noti_tlt  <=  fi_polto    AND 
        ( tlt.note1     <> "" OR
    tlt.note2    <> "" ) AND
        tlt.genusr          =  "KK"        And
        INDEX(tlt.OLD_eng,"Cover") <> 0    no-lock.
            Apply "Entry"  to br_tlt IN FRAME fr_main.  
            Return no-apply.           
END.                                   
ELSE If  cb_search  =  "Hold"  Then do:     /* hold */
    Open Query br_tlt                  
        For each tlt Use-index  tlt01      Where
        tlt.trndat         >=  fi_trndatfr And
        tlt.trndat         <=  fi_trndatto And
        tlt.comp_noti_tlt  >=  fi_polfr    AND 
        tlt.comp_noti_tlt  <=  fi_polto    AND 
        ( tlt.note1     <> "" OR
    tlt.note2    <> "" ) AND
        tlt.genusr          =  "KK"        And
        INDEX(tlt.OLD_eng,"Hold")  <> 0    AND 
        INDEX(tlt.OLD_eng,"cancel") = 0    no-lock.
            Apply "Entry"  to br_tlt IN FRAME fr_main.  
            Return no-apply.           
END.                                   
ELSE If  cb_search  =  "Cancel"  Then do:    /* cancel */
    Open Query br_tlt                    
        For each tlt Use-index  tlt01       Where
        tlt.trndat         >=  fi_trndatfr  And
        tlt.trndat         <=  fi_trndatto  And
        tlt.comp_noti_tlt  >=  fi_polfr     And  
        tlt.comp_noti_tlt  <=  fi_polto     And 
        ( tlt.note1     <> "" OR
    tlt.note2    <>  "") AND
        tlt.genusr          =  "KK"         And
        INDEX(tlt.OLD_eng,"Cancel") > 0     no-lock.
            Apply "Entry"  to br_tlt IN FRAME fr_main.
            Return no-apply.                             
END.
ELSE If  cb_search  =  "Yes"  Then do:    /* YES */
    Open Query br_tlt                    
        For each tlt Use-index  tlt01       Where
        tlt.trndat         >=  fi_trndatfr  And
        tlt.trndat         <=  fi_trndatto  And
        tlt.comp_noti_tlt  >=  fi_polfr     And  
        tlt.comp_noti_tlt  <=  fi_polto     And 
        ( tlt.note1     <> "" OR
    tlt.note2    <> "" ) AND
        tlt.genusr          =  "KK"         And
        INDEX(tlt.releas,"yes") <> 0     no-lock.
            Apply "Entry"  to br_tlt IN FRAME fr_main.
            Return no-apply.                             
END.
ELSE If  cb_search  =  "No"  Then do:    /* NO */
    Open Query br_tlt                    
        For each tlt Use-index  tlt01       Where
        tlt.trndat         >=  fi_trndatfr  And
        tlt.trndat         <=  fi_trndatto  And
        tlt.comp_noti_tlt  >=  fi_polfr     And  
        tlt.comp_noti_tlt  <=  fi_polto     And 
        ( tlt.note1     <> "" OR
    tlt.note2    <>  "") AND
        tlt.genusr          =  "KK"         And
        INDEX(tlt.releas,"No") <> 0    no-lock.
            Apply "Entry"  to br_tlt IN FRAME fr_main.
            Return no-apply.                             
END.
ELSE If  cb_search  =  "CA"  Then do:    /* ca */
    Open Query br_tlt                    
        For each tlt Use-index  tlt01       Where
        tlt.trndat         >=  fi_trndatfr  And
        tlt.trndat         <=  fi_trndatto  And
        tlt.comp_noti_tlt  >=  fi_polfr     And  
        tlt.comp_noti_tlt  <=  fi_polto     And 
        ( tlt.note1     <> "" OR
    tlt.note2    <>  "") AND
        tlt.genusr          =  "KK"         And
        INDEX(tlt.releas,"ca") <> 0     no-lock.
            Apply "Entry"  to br_tlt IN FRAME fr_main.
            Return no-apply.                             
END.
ELSE If  cb_search  =  "Policy"  Then do:    
    Open Query br_tlt                    
        For each tlt Use-index  tlt01       Where
        tlt.trndat         >=  fi_trndatfr  And
        tlt.trndat         <=  fi_trndatto  And
        tlt.comp_noti_tlt  >=  fi_polfr     And  
        tlt.comp_noti_tlt  <=  fi_polto     And 
        ( tlt.note1     <> "" OR
    tlt.note2    <>  "") AND
        tlt.genusr          =  "KK"         And
        INDEX(tlt.policy,trim(fi_search)) <> 0   no-lock.
            Apply "Entry"  to br_tlt IN FRAME fr_main.
            Return no-apply.                             
END.
ELSE If  cb_search  =  "Renew"  Then do:    
    Open Query br_tlt                    
        For each tlt Use-index  tlt01       Where
        tlt.trndat         >=  fi_trndatfr  And
        tlt.trndat         <=  fi_trndatto  And
        tlt.comp_noti_tlt  >=  fi_polfr     And  
        tlt.comp_noti_tlt  <=  fi_polto     And 
 ( tlt.note1     <> "" OR
    tlt.note2    <>  "") AND
        tlt.genusr          =  "KK"         And
        INDEX(tlt.note5,"RENEW") <> 0   no-lock.
            Apply "Entry"  to br_tlt IN FRAME fr_main.
            Return no-apply.                             
END.
ELSE If  cb_search  =  "New"  Then do:   
    Open Query br_tlt                    
        For each tlt Use-index  tlt01       Where
        tlt.trndat         >=  fi_trndatfr  And
        tlt.trndat         <=  fi_trndatto  And
        tlt.comp_noti_tlt  >=  fi_polfr     And  
        tlt.comp_noti_tlt  <=  fi_polto     And 
 ( tlt.note1     <> "" OR
    tlt.note2    <>  "") AND
        tlt.genusr          =  "KK"         And
        INDEX(tlt.note5,"RENEW") = 0   no-lock.
            Apply "Entry"  to br_tlt IN FRAME fr_main.
            Return no-apply.                             
END.
/* add by : Ranu I. A65-0288 */
ELSE If  cb_search  =  "Inspection(Y/N)"  Then do:   
    Open Query br_tlt                    
        For each tlt Use-index  tlt01       Where
        tlt.trndat         >=  fi_trndatfr  And
        tlt.trndat         <=  fi_trndatto  And
        tlt.note1          <>  ""           AND
        tlt.note2          <>  ""           AND
        tlt.genusr         =  "KK"         And
        tlt.usrsent        = trim(fi_search)   no-lock.
            Apply "Entry"  to br_tlt.
            Return no-apply.                             
END.
ELSE If  cb_search  =  "Status-ISP(Y/N)"  Then do:   
    Open Query br_tlt                    
        For each tlt Use-index  tlt01       Where
        tlt.trndat         >=  fi_trndatfr  And
        tlt.trndat         <=  fi_trndatto  And
        tlt.note1          <>  ""           AND
        tlt.note2          <>  ""           AND
        tlt.genusr         =  "KK"         And
        tlt.usrsent        =  "Y"          AND
        tlt.lotno          = trim(fi_search)   no-lock.
            Apply "Entry"  to br_tlt.
            Return no-apply.                             
END.
/* end : A65-0288 */
Else DO:
    Apply "Entry"  to  fi_search.
    Return no-apply.
END.   
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_detail_report3 c-wins 
PROCEDURE proc_detail_report3 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
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
   tlt.dri_title1  /*คำนำหน้าชื่อ 1*/          /*A67-0076*/
   tlt.dri_name1   /*ผู้ขับขี่ที่ 1     */
   tlt.dri_no1     /*วันเกิดผู้ขับขี่ 1 */
   tlt.dri_lic1    /*เลขที่ใบขับขี่ 1   */
   tlt.dri_gender1 /*เพศ 1           */         /*A67-0076*/
   nv_drioccup1    /*อาชีพ 1         */         /*A67-0076*/
   nv_driICNo1     /*ID NO/Passport 1*/         /*A67-0076*/
   ""              /*ระดับผู้ขับขี่ 1*/
   tlt.dri_title2  /*คำนำหน้าชื่อ 2*/          /*A67-0076*/
   tlt.dri_name2   /*ผู้ขับขี่ที่ 2     */
   tlt.dri_no2     /*วันเกิดผู้ขับขี่ 2 */
   tlt.dri_lic2    /*เลขที่ใบขับขี่ 2   */
   tlt.dri_gender2 /*เพศ 2           */    
   nv_drioccup2    /*อาชีพ 2         */     
   nv_driICNo2     /*ID NO/Passport 2*/ 
   ""              /*ระดับผู้ขับขี่ 2*/
   tlt.dri_title3  /*คำนำหน้าชื่อ 3*/       
   tlt.dri_name3   /*ผู้ขับขี่ที่ 3     */  
   tlt.dri_no3     /*วันเกิดผู้ขับขี่ 3 */  
   tlt.dri_lic3    /*เลขที่ใบขับขี่ 3   */  
   tlt.dri_gender3 /*เพศ 3           */     
   nv_drioccup3    /*อาชีพ 3         */     
   nv_driICNo3     /*ID NO/Passport 3*/ 
   ""              /*ระดับผู้ขับขี่ 3*/
   tlt.dri_title4  /*คำนำหน้าชื่อ 4*/       
   tlt.dri_name4   /*ผู้ขับขี่ที่ 4     */  
   tlt.dri_no4     /*วันเกิดผู้ขับขี่ 4 */  
   tlt.dri_lic4    /*เลขที่ใบขับขี่ 4   */  
   tlt.dri_gender4 /*เพศ 4           */     
   nv_drioccup4    /*อาชีพ 4         */     
   nv_driICNo4     /*ID NO/Passport 4*/
   ""              /*ระดับผู้ขับขี่ 4*/
   tlt.dri_title5  /*คำนำหน้าชื่อ 5*/       
   tlt.dri_name5   /*ผู้ขับขี่ที่ 5     */  
   tlt.dri_no5     /*วันเกิดผู้ขับขี่ 5 */  
   tlt.dri_lic5    /*เลขที่ใบขับขี่ 5   */  
   tlt.dri_gender5 /*เพศ 5           */     
   nv_drioccup5    /*อาชีพ 5         */     
   nv_driICNo5     /*ID NO/Passport 5*/
   ""              /*ระดับผู้ขับขี่5*/
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
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_report c-wins 
PROCEDURE proc_report :
/*------------------------------------------------------------------------------
Purpose:     
Parameters:  <none>
Notes:       
------------------------------------------------------------------------------*/
/*comment by Kridtiya i. A55-0029....
DEF VAR   nv_cnt   as  int  init   1.
DEF VAR   nv_row   as  int  init   0.
DEF VAR   n_record AS  INTE INIT   0.
ASSIGN 
    n_record = 0
    nv_cnt   = 0
    nv_row   = 1  .
If  substr(fi_filename,length(fi_filename) - 3,4) <>  ".slk"  THEN 
    fi_filename  =  Trim(fi_filename) + ".slk"  .

ASSIGN nv_cnt  =  0
       nv_row  =  1.
OUTPUT STREAM ns2 TO VALUE(fi_filename).
PUT STREAM ns2 "ID;PND" SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"' "บริษัทเงินทุน ธนาคารเกียรตินาคิน จำกัด (มหาชน) ."  '"' SKIP.
nv_row  =  nv_row + 1.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"   '"' "ลำดับที่"                           '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"   '"' "วันที่รับแจ้ง"                      '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"   '"' "วันที่รับเงินค่าเบิ้ยประกัน"         '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"   '"' "รายชื่อบริษัทประกันภัย"             '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"   '"' "เลขที่สัญญาเช่าซื้อ"                '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"   '"' "เลขที่กรมธรรม์เดิม"                 '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"   '"' "รหัสสาขา"                           '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"   '"' "สาขา KK"                            '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"   '"' "เลขรับเเจ้ง"                        '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K"  '"' "Campaign"                           '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K"  '"' "Sub Campaign"                       '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K"  '"' "บุคคล/นิติบุคคล"                    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K"  '"' "คำนำหน้าชื่อ"                       '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K"  '"' "ชื่อผู้เอาประกัน"                   '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K"  '"' "นามสกุลผู้เอาประกัน"                '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K"  '"' "บ้านเลขที่"                          '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K"  '"' "ตำบล/แขวง"                          '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K"  '"' "อำเภอ/เขต"                          '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K"  '"' "จังหวัด"                            '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K"  '"' "รหัสไปรษณีย์"                       '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K"  '"' "ประเภทความคุ้มครอง"                 '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K"  '"' "ประเภทการซ่อม"                      '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K"  '"' "วันเริ่มคุ้มครอง"                   '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K"  '"' "วันสิ้นสุดคุ้มครอง"                 '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K"  '"' "รหัสรถ"                             '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K"  '"' "ประเภทประกันภัยรถยนต์"              '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K"  '"' "ชื่อยี่ห้อรถ"                       '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K"  '"' "รุ่นรถ"                             '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K"  '"' "New/Used"                           '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K"  '"' "เลขทะเบียน"                         '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K"  '"' "เลขตัวถัง"                          '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K"  '"' "เลขเครื่องยนต์"                     '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K"  '"' "ปีรถยนต์"                           '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K"  '"' "ซีซี"                               '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K"  '"' "น้ำหนัก/ตัน"                        '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K"  '"' "ทุนประกันปี 1 "                      '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K"  '"' "เบี้ยรวมภาษีเเละอากรปี 1"           '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K"  '"' "ทุนประกันปี 2"                      '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X39;K"  '"' "เบี้ยรวมภาษีเเละอากรปี 2"           '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X40;K"  '"' "เวลารับเเจ้ง"                       '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X41;K"  '"' "ชื่อเจ้าหน้าที่ MKT"                '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X42;K"  '"' "หมายเหตุ"                           '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X43;K"  '"' "ผู้ขับขี่ที่ 1 เเละวันเกิด"         '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X44;K"  '"' "ผู้ขับขี่ที่ 2 เเละวันเกิด"         '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X45;K"  '"' "คำนำหน้าชื่อ (ใบเสร็จ/ใบกำกับภาษี)" '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X46;K"  '"' "ชื่อ (ใบเสร็จ/ใบกำกับภาษี)"         '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X47;K"  '"' "นามสกุล (ใบเสร็จ/ใบกำกับภาษี)"      '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X48;K"  '"' "บ้านเลขที่ (ใบเสร็จ/ใบกำกับภาษี)"   '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X49;K"  '"' "ตำบล/แขวง (ใบเสร็จ/ใบกำกับภาษี)"    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X50;K"  '"' "อำเภอ/เขต (ใบเสร็จ/ใบกำกับภาษี)"    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X51;K"  '"' "จังหวัด (ใบเสร็จ/ใบกำกับภาษี)"      '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X52;K"  '"' "รหัสไปรษณีย์ (ใบเสร็จ/ใบกำกับภาษี)" '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X53;K"  '"' "ส่วนลดประวัติดี"                    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X54;K"  '"' "ส่วนลดงาน Fleet"                    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X55;K"  '"' "Remak1"                             '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X56;K"  '"' "Remak2"                             '"' SKIP.

FOR EACH tlt Use-index  tlt01  Where
        tlt.trndat        >=   fi_trndatfr   And
        tlt.trndat        <=   fi_trndatto   And
        tlt.comp_noti_tlt >=   fi_polfr      And
        tlt.comp_noti_tlt <=   fi_polto      And
        tlt.genusr   =  "KK"                 no-lock.  
    IF      (ra_report = 1) AND (index(tlt.OLD_eng,"COVER") = 0 ) THEN NEXT.
    ELSE IF (ra_report = 2) AND (index(tlt.OLD_eng,"hold")  = 0 ) THEN NEXT.
    ELSE IF (ra_report = 3) AND (index(tlt.OLD_eng,"CANCEL") = 0 ) THEN NEXT.
    ELSE IF (ra_report = 4) THEN DO: 
        IF index(tlt.OLD_eng,"COVER") = 0  THEN 
            IF (index(tlt.OLD_eng,"CANCEL") = 0 )  THEN NEXT.
    END.
    ASSIGN 
        n_record =  n_record + 1
        nv_cnt   =  nv_cnt  + 1 
        nv_row   =  nv_row  + 1.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"' n_record                                            '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"' string(tlt.datesent,"99/99/9999")    FORMAT "x(10)" '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"' string(tlt.dat_ins_not,"99/99/9999") FORMAT "x(10)" '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"  '"' trim(tlt.nor_usr_ins)                FORMAT "x(50)" '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"' trim(tlt.nor_noti_tlt)               FORMAT "x(20)" '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"  '"' trim(tlt.nor_noti_ins)               FORMAT "x(20)" '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"  '"' trim(tlt.nor_usr_tlt)                FORMAT "x(10)" '"' SKIP.        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"  '"' trim(tlt.comp_usr_tl)                FORMAT "x(35)" '"' SKIP.                 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"  '"' trim(tlt.comp_noti_tlt)              FORMAT "x(20)" '"' SKIP.                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K" '"' trim(tlt.dri_no1)                    FORMAT "x(30)" '"' SKIP.      
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K" '"' trim(tlt.dri_no2)                    FORMAT "x(30)" '"' SKIP.      
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K" '"' trim(tlt.safe2)                      FORMAT "x(30)" '"' SKIP.      
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K" '"' substr(trim(tlt.ins_name),1,INDEX(trim(tlt.ins_name)," ") - 1 )         FORMAT "x(20)" '"' SKIP.                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K" '"' substr(trim(tlt.ins_name),INDEX(trim(tlt.ins_name)," ") + 1,r-INDEX(trim(tlt.ins_name)," ") - INDEX(trim(tlt.ins_name)," "))  FORMAT "x(35)" '"' SKIP.                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K" '"' substr(trim(tlt.ins_name),r-INDEX(trim(tlt.ins_name)," ") + 1 )         FORMAT "x(35)" '"' SKIP.                   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K" '"' trim(tlt.ins_addr1)                 FORMAT "x(80)" '"' SKIP.              
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K" '"' trim(tlt.ins_addr2)                 FORMAT "x(40)" '"' SKIP.                   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K" '"' trim(tlt.ins_addr3)                 FORMAT "x(40)" '"' SKIP.                   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K" '"' trim(tlt.ins_addr4)                 FORMAT "x(40)" '"' SKIP.                   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K" '"' trim(tlt.ins_addr5)                 FORMAT "x(15)" '"' SKIP.                 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K" '"' trim(tlt.safe3)                                    '"' SKIP.                 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K" '"' trim(tlt.stat)                      FORMAT "x(30)" '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K" '"' string(tlt.nor_effdat,"99/99/9999") FORMAT "x(10)" '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K" '"' string(tlt.expodat,"99/99/9999")    FORMAT "x(10)" '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K" '"' trim(tlt.subins)                    FORMAT "x(10)" '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K" '"' trim(tlt.filler2)                   FORMAT "x(40)" '"' SKIP.              
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K" '"' trim(tlt.brand)                     FORMAT "x(30)" '"' SKIP.              
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K" '"' trim(tlt.model)                     FORMAT "x(45)" '"' SKIP.              
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K" '"' trim(tlt.filler1)                   FORMAT "x(20)" '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K" '"' trim(tlt.lince1)                    FORMAT "x(30)" '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K" '"' trim(tlt.cha_no)                    FORMAT "x(30)" '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K" '"' trim(tlt.eng_no)                    FORMAT "x(30)" '"' SKIP.                 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K" '"' trim(tlt.lince2)                    FORMAT "x(10)" '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K" '"' string(tlt.cc_weight)               FORMAT "x(10)" '"' SKIP.               
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K" '"' trim(tlt.colorcod)                  FORMAT "x(10)" '"' SKIP.                 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K" '"' string(tlt.comp_coamt)              '"' SKIP.                                      
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K" '"' string(tlt.comp_grprm)              '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K" '"' string(tlt.nor_coamt)               '"' SKIP.                                     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X39;K" '"' string(tlt.nor_grprm)               '"' SKIP.                                      
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X40;K" '"' string(tlt.gentim)                  FORMAT "x(10)"     '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X41;K" '"' trim(tlt.comp_usr_in)               FORMAT "x(50)"     '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X42;K" '"' trim(tlt.safe1)                     FORMAT "x(100)"     '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X43;K" '"' trim(tlt.dri_name1)                 FORMAT "x(50)"     '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X44;K" '"' trim(tlt.dri_name2)                 FORMAT "x(50)"     '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X45;K" '"' trim(tlt.rec_name)             '"' SKIP.                            
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X46;K" '"' ""                             '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X47;K" '"' ""                             '"' SKIP.            
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X48;K" '"' trim(tlt.rec_addr1)            '"' SKIP.            
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X49;K" '"' trim(tlt.rec_addr2)            '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X50;K" '"' trim(tlt.rec_addr3)            '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X51;K" '"' trim(tlt.rec_addr4)            '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X52;K" '"' trim(tlt.rec_addr5)            '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X53;K" '"' string(tlt.seqno)              '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X54;K" '"' tlt.lotno                      '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X55;K" '"' trim(tlt.OLD_eng)       FORMAT "x(100)"  '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X56;K" '"' trim(tlt.OLD_cha)       FORMAT "x(100)"  '"' SKIP.
END.   /*  end  wdetail  */
nv_row  =  nv_row  + 1. 
PUT STREAM ns2 "E".

OUTPUT STREAM ns2 CLOSE.  

Message "Export data Complete"  View-as alert-box.
end.comment by Kridtiya i. A55-0029....*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_report2 c-wins 
PROCEDURE proc_report2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*add by Kridtiya i. A55-0029....30/01/2012 modify  .slk >> .csv */
DEF VAR   nv_cnt   as  int  init   1.
DEF VAR   nv_row   as  int  init   0.
DEF VAR   n_record AS  INTE INIT   0.
/* add by : A65-0288 */
DEF VAR nv_first    AS CHAR .
def var nv_Brancho  as char .
def var nv_dealero  as char .
def var nv_campno   as char .
def var  nv_ispno             as char no-undo init "".
def var  nv_ispappoit         as char no-undo init "".
def var  nv_ispupdate         as char no-undo init "".
def var  nv_isplocal          as char no-undo init "".
def var  nv_ispclose          as char no-undo init "".
def var  nv_ispresult         as char no-undo init "".
def var  nv_ispdam            as char no-undo init "".
def var  nv_ispacc            as char no-undo init "".
/* end : A65-0288 */
ASSIGN 
    n_record = 0
    nv_cnt   = 0
    nv_row   = 1  .
If  substr(fi_filename,length(fi_filename) - 3,4) <>  ".csv"  THEN 
    fi_filename  =  Trim(fi_filename) + ".csv"  .

OUTPUT TO VALUE(fi_filename). 
EXPORT DELIMITER "|" 
    "บริษัทเงินทุน ธนาคารเกียรตินาคิน จำกัด (มหาชน) ." .
EXPORT DELIMITER "|" 
    "ลำดับที่"                           
    "วันที่รับแจ้ง"                      
    "วันที่รับเงินค่าเบิ้ยประกัน"        
    "รายชื่อบริษัทประกันภัย"             
    "เลขที่สัญญาเช่าซื้อ"                
    "เลขที่กรมธรรม์เดิม"                 
    "รหัสสาขา"                           
    "สาขา KK"                            
    "เลขรับเเจ้ง"                        
    "Campaign"                           
    "Sub Campaign"                       
    "บุคคล/นิติบุคคล"                    
    "คำนำหน้าชื่อ"                       
    "ชื่อผู้เอาประกัน"                   
    "นามสกุลผู้เอาประกัน"                
    "บ้านเลขที่"                         
    "ตำบล/แขวง"                          
    "อำเภอ/เขต"                          
    "จังหวัด"                            
    "รหัสไปรษณีย์"                      
    "ประเภทความคุ้มครอง"                
    "ประเภทการซ่อม"                     
    "วันเริ่มคุ้มครอง"                  
    "วันสิ้นสุดคุ้มครอง"                
    "รหัสรถ"                            
    "ประเภทประกันภัยรถยนต์"             
    "ชื่อยี่ห้อรถ"                      
    "รุ่นรถ"                            
    "New/Used"                          
    "เลขทะเบียน"                        
    "เลขตัวถัง"                         
    "เลขเครื่องยนต์"                    
    "ปีรถยนต์"                          
    "ซีซี"                              
    "น้ำหนัก/ตัน"                       
    "ทุนประกันปี 1 "                    
    "เบี้ยรวมภาษีเเละอากรปี 1"          
    "ทุนประกันปี 2" 
    "ทุนประกันรถยนต์สูญหาย/ไฟไหม้ ปี2(F&T)" /*A60-0232*/
    "เบี้ยรวมภาษีเเละอากรปี 2"          
    "เวลารับเเจ้ง"                      
    "ชื่อเจ้าหน้าที่ MKT"               
    "หมายเหตุ"                          
    "ผู้ขับขี่ที่ 1 เเละวันเกิด"        
    "ผู้ขับขี่ที่ 2 เเละวันเกิด"         
    "คำนำหน้าชื่อ (ใบเสร็จ/ใบกำกับภาษี)" 
    "ชื่อ (ใบเสร็จ/ใบกำกับภาษี)"         
    "นามสกุล (ใบเสร็จ/ใบกำกับภาษี)"      
    "บ้านเลขที่ (ใบเสร็จ/ใบกำกับภาษี)"   
    "ตำบล/แขวง (ใบเสร็จ/ใบกำกับภาษี)"    
    "อำเภอ/เขต (ใบเสร็จ/ใบกำกับภาษี)"    
    "จังหวัด (ใบเสร็จ/ใบกำกับภาษี)"      
    "รหัสไปรษณีย์ (ใบเสร็จ/ใบกำกับภาษี)" 
    "ส่วนลดประวัติดี"                    
    "ส่วนลดงาน Fleet" 
    "เบอร์ติดต่อ "                 /*A60-0232*/
    "เลขที่บัตรประชาชน"            /*A60-0232*/
    "วันเดือนปีเกิด   "            /*A60-0232*/
    "อาชีพ            "            /*A60-0232*/
    "สถานภาพ          "            /*A60-0232*/
    "เลขประจำตัวผู้เสียภาษีอากร"   /*A60-0232*/
    "คำนำหน้าชื่อ 1  "             /*A60-0232*/
    "ชื่อกรรมการ 1   "             /*A60-0232*/
    "นามสกุลกรรมการ 1"             /*A60-0232*/
    "เลขที่บัตรประชาชนกรรมการ 1"   /*A60-0232*/
    "คำนำหน้าชื่อ 2   "            /*A60-0232*/
    "ชื่อกรรมการ 2    "            /*A60-0232*/
    "นามสกุลกรรมการ 2 "            /*A60-0232*/
    "เลขที่บัตรประชาชนกรรมการ 2"   /*A60-0232*/
    "คำนำหน้าชื่อ 3   "            /*A60-0232*/
    "ชื่อกรรมการ 3    "            /*A60-0232*/
    "นามสกุลกรรมการ 3 "            /*A60-0232*/
    "เลขที่บัตรประชาชนกรรมการ 3"   /*A60-0232*/
    "จัดส่งเอกสารที่สาขา "   /*A61-0335*/  
    "ชื่อผู้รับเอกสาร    "   /*A61-0335*/  
    "ผู้รับผลประโยชน์    "   /*A61-0335*/  
    "KK ApplicationNo    "   /*A61-0335*/  
    "Remak1"                       
    "Remak2" 
    "Dealer KK"        /* A63-00472*/
    /*add by : A65-0288 */
    "Dealer TMSTH " 
    "Campaign no TMSTH"
    "Campaign OV  " 
    "Producer code" 
    "Agent Code   " 
    "ReferenceNo  " 
    "KK Quotation No. "
    "Rider  No.   " 
    "Release      " 
    "Loan First Date"   
    "Policy Premium "   
    "Note Un Problem"   
    "Color"
    "Inspection"                                                
    "Inspection status"                                         
    "Inspection No"                                             
    "Inspection Closed Date"                                         
    "Inspection Detail / Inspection Update"                     
    "inspection Damage/ Inspection Appiontment Date"            
    "inspection Accessory / Inspection Appiontment Location"
    /* end : A65-0288 */
    "Release"       /* A56-0309 */                      
    .
FOR EACH tlt Use-index  tlt01  Where
    tlt.trndat        >=   fi_trndatfr   And
    tlt.trndat        <=   fi_trndatto   And
    tlt.comp_noti_tlt >=   fi_polfr      And
    tlt.comp_noti_tlt <=   fi_polto      And
    tlt.genusr   =  "KK"                 no-lock. 
    /*--Begin by Chaiyong W. A64-0135 13/09/2021*/
    IF ra_new = 2 THEN DO: 
        IF ( tlt.note1     <> "" OR tlt.note2    <>  ""  )  THEN DO:
        END.
        ELSE NEXT.
    END.
    ELSE DO:
        IF ( tlt.note1     =  "" OR tlt.note2   =   ""  )  THEN DO:
        END.
        ELSE NEXT.
    END.
    IF ra_type = 1 THEN DO:
        IF index(tlt.note5,"renew") <> 0 THEN NEXT .
    END.
    ELSE IF ra_type = 2 THEN DO:
        IF index(tlt.note5,"renew") = 0 THEN NEXT.
    END.
    /*End by Chaiyong W. A64-0135 13/09/2021----*/
    IF      (cb_report = "Cover") AND (index(tlt.OLD_eng,"COVER") = 0 )  THEN NEXT.
    ELSE IF (cb_report = "Hold") AND (INDEX(tlt.OLD_eng,"hold") = 0 ) AND (INDEX(tlt.OLD_eng,"Cancel") <> 0 )  THEN NEXT.
    ELSE IF (cb_report = "Cancel") AND (index(tlt.OLD_eng,"CANCEL_HOLD") = 0 ) THEN NEXT.
    ELSE IF (cb_report = "Yes")  AND (index(tlt.Releas,"yes") = 0 ) THEN NEXT.     /* A56-0309 */
    ELSE IF (cb_report = "No")  AND (index(tlt.Releas,"no") = 0 ) THEN NEXT.      /* A56-0309 */
    ELSE IF (cb_report = "CA")  AND (index(tlt.Releas,"ca") = 0 ) THEN NEXT.      /* A61-0335 */
    /* add by : A65-0288 07/10/2022 */
    ELSE IF (cb_report = "Inspection(Y)")  AND tlt.usrsent = "N"  THEN NEXT.
    ELSE IF (cb_report = "Status-ISP(Y)")  AND tlt.usrsent = "Y" and  tlt.lotno   = "N"  THEN NEXT.
    ELSE IF (cb_report = "Status-ISP(N)")  AND tlt.usrsent = "Y" and  tlt.lotno   = "Y"  THEN NEXT.
    /* end : A65-0288 07/10/2022 */

    ASSIGN n_text  = ""     nv_phone   = ""     nv_icno    = ""     nv_tax     = ""
           nv_cstatus = ""  nv_occup   = ""     nv_icno3   = ""     nv_lname3  = ""
           nv_cname3  = ""  nv_tname3  = ""     nv_icno2   = ""     nv_lname2  = ""
           nv_cname2  = ""  nv_tname2  = ""     nv_icno1   = ""     nv_lname1  = ""
           nv_cname1  = ""  nv_tname1  = ""     
           n_send     = ""  n_sendname = ""     n_bennefit = ""     /*A61-0335*/
           nv_ispno     = ""      nv_ispappoit  = ""       nv_ispupdate  = ""      nv_isplocal   = ""     /* A65-0288*/   
           nv_ispclose  = ""      nv_ispresult  = ""       nv_ispdam     = ""      nv_ispacc     = ""    /* A65-0288*/ 
           nv_first     = ""      nv_Brancho    = ""       nv_dealero    = ""      nv_campno     = ""    /* A65-0288*/
           nv_phone     = IF tlt.expousr <> "" THEN SUBSTR(tlt.expousr,5,INDEX(tlt.expousr,"ICNO:") - 5) ELSE ""
           nv_icno      = IF tlt.expousr <> "" THEN SUBSTR(tlt.expousr,R-INDEX(tlt.expousr,"ICNO:") + 5) ELSE "" 
          /* end : a60-0232*/
           n_text      = trim(tlt.comp_noti_ins)                                                    /*A61-0335*/
           n_bennefit  = SUBSTR(n_text,R-INDEX(n_text,"BE:") + 3 )      /* ผู้รับผลประโยชน์ */      /*A61-0335*/
           n_text      = SUBSTR(n_text,1,LENGTH(n_text) - (LENGTH(n_bennefit) + 3 ))                /*A61-0335*/
           n_sendname  = SUBSTR(n_text,R-INDEX(n_text,"SN:") + 3 )  /* ชื่อผู้รับเอกสาร */      /*A61-0335*/
           n_text      = SUBSTR(n_text,1,LENGTH(n_text) - (LENGTH(n_sendname) + 3 ))                /*A61-0335*/
           n_send      = SUBSTR(n_text,R-INDEX(n_text,"SE:") + 3 ).  /* สถานที่จัดส่งเอกสาร */   /*A61-0335*/

        /* Add by : A65-0288 */
        IF tlt.ln_fst <> ?  THEN nv_first =  string(tlt.ln_fst).
        IF tlt.note30 <> "" THEN DO:
            ASSIGN
                nv_Brancho  = trim(substr(tlt.note30,1,100))
                nv_dealero  = trim(substr(tlt.note30,101,100)  ) 
                nv_campno   = trim(substr(tlt.note30,201,100)  )   NO-ERROR.
        END.
        IF tlt.lotno = "Y" THEN DO:
            ASSIGN 
            nv_ispno     = trim(substr(tlt.acno1,1,INDEX(tlt.acno1," ")))  
            nv_ispclose  = trim(SUBSTR(tlt.acno1,R-INDEX(tlt.acno1,"Close Date:") + 12))
            nv_ispresult = IF index(tlt.mobile,"รายการความเสียหาย") <> 0 THEN trim(substr(tlt.mobile,1,index(tlt.mobile,"รายการความเสียหาย") - 2)) ELSE tlt.mobile
            nv_ispdam    = IF index(tlt.mobile,"รายการความเสียหาย") <> 0 THEN trim(substr(tlt.mobile,R-INDEX(tlt.mobile,"รายการความเสียหาย") + 17)) ELSE ""
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
        /* end : A65-0288 */
    ASSIGN n_record = n_record + 1.
    EXPORT DELIMITER "|" 
        n_record                                            
        string(tlt.datesent,"99/99/9999")    FORMAT "x(10)"     
        IF tlt.dat_ins_not = ? THEN "" ELSE string(tlt.dat_ins_not,"99/99/9999") FORMAT "x(10)"     
        trim(tlt.nor_usr_ins)                FORMAT "x(50)"     
        trim(tlt.nor_noti_tlt)               FORMAT "x(20)"     
        trim(tlt.nor_noti_ins)               FORMAT "x(20)"     
        trim(tlt.nor_usr_tlt)                FORMAT "x(10)"         
        trim(tlt.comp_usr_tl)                FORMAT "x(35)"                  
        trim(tlt.comp_noti_tlt)              FORMAT "x(20)"                 
        trim(tlt.dri_no1)                    FORMAT "x(30)"       
        trim(tlt.dri_no2)                    FORMAT "x(30)"       
        trim(tlt.safe2)                      FORMAT "x(30)"       
        substr(trim(tlt.ins_name),1,INDEX(trim(tlt.ins_name)," ") - 1 )         FORMAT "x(20)"                
        substr(trim(tlt.ins_name),INDEX(trim(tlt.ins_name)," ") + 1,r-INDEX(trim(tlt.ins_name)," ") - INDEX(trim(tlt.ins_name)," "))  FORMAT "x(35)"                     
        substr(trim(tlt.ins_name),r-INDEX(trim(tlt.ins_name)," ") + 1 )         FORMAT "x(35)"                   
        trim(tlt.ins_addr1)                 FORMAT "x(80)"               
        trim(tlt.ins_addr2)                 FORMAT "x(40)"                    
        trim(tlt.ins_addr3)                 FORMAT "x(40)"                    
        trim(tlt.ins_addr4)                 FORMAT "x(40)"                    
        trim(tlt.ins_addr5)                 FORMAT "x(15)"                  
        trim(tlt.safe3)                                                     
        trim(tlt.stat)                      FORMAT "x(30)"      
        string(tlt.nor_effdat,"99/99/9999") FORMAT "x(10)" 
        string(tlt.expodat,"99/99/9999")    FORMAT "x(10)" 
        trim(tlt.subins)                    FORMAT "x(10)" 
        trim(tlt.filler2)                   FORMAT "x(40)"               
        trim(tlt.brand)                     FORMAT "x(30)"               
        trim(tlt.model)                     FORMAT "x(45)"               
        trim(tlt.filler1)                   FORMAT "x(20)"  
        trim(tlt.lince1)                    FORMAT "x(35)"  
        trim(tlt.cha_no)                    FORMAT "x(30)"  
        trim(tlt.eng_no)                    FORMAT "x(30)"                  
        trim(tlt.lince2)                    FORMAT "x(10)"  
        string(tlt.cc_weight)               FORMAT "x(10)"                
        trim(tlt.colorcod)                  FORMAT "x(10)"                  
        string(tlt.comp_coamt)                                                   
        string(tlt.comp_grprm)                                                 
        string(tlt.nor_coamt)
        STRING(tlt.endcnt)                  FORMAT "x(15)" /*a60-0232 FI*/
        string(tlt.nor_grprm)                                                    
        string(tlt.gentim)                  FORMAT "x(10)"      
        trim(tlt.comp_usr_in)               FORMAT "x(50)"     
        trim(tlt.safe1)                     FORMAT "x(200)"    
        trim(tlt.dri_name1)                 FORMAT "x(50)"     
        trim(tlt.dri_name2)                 FORMAT "x(50)"     
        trim(tlt.rec_name)                                         
        ""                               
        ""                                         
        trim(tlt.rec_addr1)                        
        trim(tlt.rec_addr2)               
        trim(tlt.rec_addr3)             
        trim(tlt.rec_addr4)              
        trim(tlt.rec_addr5)             
        string(tlt.seqno)                 
        tlt.lotno 
        nv_phone                            FORMAT "x(25)"    /*a60-0232*/
        nv_icno                             FORMAT "x(15)"    /*a60-0232*/
        STRING(tlt.gendat,"99/99/9999")                       /*a60-0232*/
        nv_occup                            FORMAT "x(45)"    /*a60-0232*/
        nv_cstatus                          format "x(20)"    /*a60-0232*/
        nv_tax                              format "x(15)"    /*a60-0232*/
        nv_tname1                           format "x(20)"    /*a60-0232*/
        nv_cname1                           format "x(45)"    /*a60-0232*/
        nv_lname1                           format "x(45)"    /*a60-0232*/
        nv_icno1                            format "x(15)"    /*a60-0232*/
        nv_tname2                           format "x(20)"    /*a60-0232*/
        nv_cname2                           format "x(45)"    /*a60-0232*/
        nv_lname2                           format "x(45)"    /*a60-0232*/
        nv_icno2                            format "x(15)"    /*a60-0232*/
        nv_tname3                           format "x(20)"    /*a60-0232*/
        nv_cname3                           format "x(45)"    /*a60-0232*/
        nv_lname3                           format "x(45)"    /*a60-0232*/
        nv_icno3                            format "x(15)"    /*a60-0232*/
        n_send                              format "x(50)"  /*A61-0335*/
        n_sendname                          format "x(50)"  /*A61-0335*/
        n_bennefit                          FORMAT "x(50)"  /*A61-0335*/
        trim(tlt.expotim)    /* kk app */     /*a61-0335*/                                          
        trim(tlt.OLD_eng)      FORMAT "x(150)" 
        trim(tlt.OLD_cha)      FORMAT "x(150)"
        tlt.usrid  FORMAT "x(20)"            /* A63-00472 เก็บ Dealer*/
        /* add by : A65-0288  07/10/2022  */
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
        tlt.lince3 
        tlt.usrsent
        tlt.lotno 
        nv_ispno  
        if tlt.lotno = "Y" then nv_ispclose  else ""
        if tlt.lotno = "Y" then nv_ispresult else nv_ispappoit
        if tlt.lotno = "Y" then nv_ispdam    else nv_ispupdate
        if tlt.lotno = "Y" then nv_ispacc    else nv_isplocal 
        /* end : A65-0288  07/10/2022  */
        tlt.Releas FORMAT "x(10)"    .       /* A56-0309 */
END.   /*  end  wdetail  */
OUTPUT CLOSE. /*----add by Chaiyong W. A64-0135 21/06/2021*/
Message "Export data Complete"  View-as alert-box.
/*end.add by Kridtiya i. A55-0029.....30/01/2012 */
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_report3 c-wins 
PROCEDURE proc_report3 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
 ASSIGN 
 nv_comcod = ""  
 nv_comchr = ""  
 nv_expchr = ""  
 nv_birchr = ""  
 nv_senchr = ""  
 nv_trnchr = ""  
 nv_saddr  = ""  
 nv_first  = ""  
 nv_file   = ""  
 nv_ccom   = 0   
 nv_Brancho = "" 
 nv_dealero = "" 
 nv_campno  = "" 
 nv_Seat    = "" 
 nv_ispno      = ""    
 nv_ispappoit  = ""    
 nv_ispupdate  = ""    
 nv_isplocal   = ""    
 nv_ispclose   = ""    
 nv_ispresult  = ""    
 nv_ispdam     = ""    
 nv_ispacc     = ""  .  

nv_file  = fi_filename.
IF INDEX (nv_file,".csv") <> 0 THEN DO:
END.
ELSE nv_file = nv_file + ".csv".
OUTPUT TO VALUE(nv_file).
EXPORT DELIMITER "|" 
    "ลำดับที่       "   
    "วันที่รับแจ้ง  "   
    "วันที่รับเงินค่าเบิ้ยประกัน "
    "รายชื่อบริษัทประกันภัย "   
    "เลขที่สัญญาเช่าซื้อ"   
    "New/Renew          "   
    "เลขที่กรมธรรม์เดิม "   
    "รหัสสาขา        "   
    "สาขา KK         "   
    "สาขา TMSTH      "   
    "เลขรับเเจ้ง     "   
    "KK Offer Flag   "   
    "Campaign        "   
    "Sub Campaign    "   
    "บุคคล/นิติบุคคล "   
    "คำนำหน้าชื่อ    "   
    "ชื่อผู้เอาประกัน   "   
    "นามสกุลผู้เอาประกัน"   
    "บ้านเลขที่  "  
    "ตำบล/แขวง   "  
    "อำเภอ/เขต   "  
    "จังหวัด     "  
    "รหัสไปรษณีย์"  
    "ประเภทความคุ้มครอง "   
    "ประเภทการซ่อม      "   
    "วันเริ่มคุ้มครอง   "   
    "วันสิ้นสุดคุ้มครอง "   
    "รหัสรถ             "   
    "ประเภทประกันภัยรถยนต์" 
    "ชื่อยี่ห้อรถ     " 
    "รุ่นรถ           " 
    "New/Used         " 
    "เลขทะเบียน       " 
    "จังหวัดจดทะเบียน " 
    "เลขตัวถัง        " 
    "เลขเครื่องยนต์   " 
    "ปีรถยนต์         " 
    "ซีซี             " 
    "แรงม้า           " 
    "น้ำหนัก/ตัน      " 
    "ที่นั่ง          " 
    "ทุนประกันปี 1    " 
    "เบี้ยสุทธิ       " 
    "เบี้ยรวมภาษีเเละอากรปี 1    "
    "เวลารับเเจ้ง       "   
    "ชื่อเจ้าหน้าที่ MKT"   
    "หมายเหตุ           "   
    "คำนำหน้าชื่อ 1     "   
    "ผู้ขับขี่ที่ 1     "   
    "วันเกิดผู้ขับขี่ 1 "   
    "เลขที่ใบขับขี่ 1   "   
    "เพศ 1              "   
    "อาชีพ 1            "   
    "ID NO/Passport 1   "   
    "ระดับผู้ขับขี่ 1   "   
    "คำนำหน้าชื่อ 2     "   
    "ผู้ขับขี่ที่ 2     "   
    "วันเกิดผู้ขับขี่ 2 "   
    "เลขที่ใบขับขี่ 2   "   
    "เพศ 2              "   
    "อาชีพ 2            "   
    "ID NO/Passport 2   "   
    "ระดับผู้ขับขี่ 2   "   
    "คำนำหน้าชื่อ 3     "   
    "ผู้ขับขี่ที่ 3     "   
    "วันเกิดผู้ขับขี่ 3 "   
    "เลขที่ใบขับขี่ 3   "   
    "เพศ 3              "   
    "อาชีพ 3            "   
    "ID NO/Passport 3   "   
    "ระดับผู้ขับขี่ 3   "   
    "คำนำหน้าชื่อ 4     "   
    "ผู้ขับขี่ที่ 4     "   
    "วันเกิดผู้ขับขี่ 4 "   
    "เลขที่ใบขับขี่ 4   "   
    "เพศ 4              "   
    "อาชีพ 4            "   
    "ID NO/Passport 4   "   
    "ระดับผู้ขับขี่ 4   "   
    "คำนำหน้าชื่อ 5     "   
    "ผู้ขับขี่ที่ 5     "   
    "วันเกิดผู้ขับขี่ 5 "   
    "เลขที่ใบขับขี่ 5   "   
    "เพศ 5              "   
    "อาชีพ 5            "   
    "ID NO/Passport 5   "   
    "ระดับผู้ขับขี่5    "   
    "คำนำหน้าชื่อ (ใบเสร็จ/ใบกำกับภาษี) "
    "ชื่อ (ใบเสร็จ/ใบกำกับภาษี)         "
    "นามสกุล (ใบเสร็จ/ใบกำกับภาษี)      "
    "บ้านเลขที่ (ใบเสร็จ/ใบกำกับภาษี)   "
    "ตำบล/แขวง (ใบเสร็จ/ใบกำกับภาษี)    "
    "อำเภอ/เขต (ใบเสร็จ/ใบกำกับภาษี)    "
    "จังหวัด (ใบเสร็จ/ใบกำกับภาษี)      "
    "รหัสไปรษณีย์ (ใบเสร็จ/ใบกำกับภาษี) "
    "ส่วนลดประวัติดี"   
    "ส่วนลดงาน Fleet"   
    "เบอร์ติดต่อ    "   
    "เลขที่บัตรประชาชน "
    "วันเดือนปีเกิด "   
    "อาชีพ    " 
    "สถานภาพ  " 
    "เพศ      " 
    "สัญชาติ  " 
    "อีเมลล์  " 
    "เลขประจำตัวผู้เสียภาษีอากร"
    "คำนำหน้าชื่อ 1    "
    "ชื่อกรรมการ 1     "
    "นามสกุลกรรมการ 1  "
    "เลขที่บัตรประชาชนกรรมการ1 "
    "คำนำหน้าชื่อ 2    "
    "ชื่อกรรมการ 2     "
    "นามสกุลกรรมการ 2  "
    "เลขที่บัตรประชาชนกรรมการ2 "
    "คำนำหน้าชื่อ 3     "   
    "ชื่อกรรมการ 3      "   
    "นามสกุลกรรมการ 3   "   
    "เลขที่บัตรประชาชนกรรมการ3 "
    "จัดส่งเอกสารที่สาขา"   
    "ชื่อผู้รับเอกสาร   "   
    "ผู้รับผลประโยชน์   "   
    "KK ApplicationNo   "   
    "Remak1    " 
    "Remak2    " 
    "Dealer KK " 
    "Dealer TMSTH " 
    "Campaign no TMSTH "
    "Campaign OV  " 
    "Producer code" 
    "Agent Code" 
    "ReferenceNo  " 
    "KK Quotation No."  
    "Rider  No."     
    "Release   "     
    "Loan FirstDate  "  
    "Policy Premium  "  
    "Note Un Problem "  
    "Color     " 
    "Inspection"                                                
    "Inspection status"                                         
    "Inspection No"                                             
    "Inspection Closed Date"                                         
    "Inspection Detail / Inspection Update"                     
    "inspection Damage/ Inspection Appiontment Date"            
    "inspection Accessory / Inspection Appiontment Location"
    "วันที่จดทะเบียนครั้งแรก" 
    "Payment option" 
    "Battery Serial Number" 
    "Battery Year  " 
    "Market value price" 
    "Wall Charge Serial Number"
    "Vehicle_Key"
   SKIP .
OUTPUT CLOSE.
RUN wuw\wuwppics3(INPUT TODAY,INPUT "COMP_CODE",OUTPUT nv_comcod).
IF nv_comcod = "" THEN nv_comcod= "TMSTH".
FOR EACH tlt Use-index  tlt01  Where
    tlt.trndat        >=   fi_trndatfr   And
    tlt.trndat        <=   fi_trndatto   And
    tlt.comp_noti_tlt >=   fi_polfr      And
    tlt.comp_noti_tlt <=   fi_polto      And
    tlt.genusr   =  "KK"                 NO-LOCK:
    /*--Begin by Chaiyong W. A64-0135 13/09/2021*/
    IF ra_new = 2 THEN DO: 
        IF ( tlt.note1     <> "" OR tlt.note2    <>  ""  )  THEN DO:
        END. ELSE NEXT.
    END.
    ELSE DO:
        IF ( tlt.note1     =  "" OR tlt.note2   =   ""  )  THEN DO:
        END. ELSE NEXT.
    END.
    IF ra_type = 1 THEN DO:
        IF index(tlt.note5,"renew") <> 0 THEN NEXT.
    END.
    ELSE IF ra_type = 2 THEN DO:
        IF index(tlt.note5,"renew") = 0 THEN NEXT.
    END.
    /*End by Chaiyong W. A64-0135 13/09/2021----*/
    IF      (cb_report = "Cover") AND (index(tlt.OLD_eng,"COVER") = 0 )  THEN NEXT.
    ELSE IF (cb_report = "Hold") AND (INDEX(tlt.OLD_eng,"hold") = 0 ) AND (INDEX(tlt.OLD_eng,"Cancel") <> 0 )  THEN NEXT.
    ELSE IF (cb_report = "Cancel") AND (index(tlt.OLD_eng,"CANCEL_HOLD") = 0 ) THEN NEXT.
    ELSE IF (cb_report = "Yes")  AND (index(tlt.Releas,"yes") = 0 ) THEN NEXT.     /* A56-0309 */
    ELSE IF (cb_report = "No")  AND (index(tlt.Releas,"no") = 0 ) THEN NEXT.      /* A56-0309 */
    ELSE IF (cb_report = "CA")  AND (index(tlt.Releas,"ca") = 0 ) THEN NEXT. 
    /* add by : A65-0288 07/10/2022 */
    ELSE IF (cb_report = "Inspection(Y)")   THEN DO: 
        IF (tlt.usrsent = "Y") THEN DO: 
        END. ELSE NEXT.
    END.
    ELSE IF (cb_report = "Status-ISP(Y)") THEN DO: 
        IF tlt.usrsent = "Y"  AND  tlt.lotno  = "Y"  THEN DO:
        END. ELSE NEXT.
    END.
    ELSE IF (cb_report = "Status-ISP(N)")  THEN DO: 
        IF tlt.usrsent = "Y" and  tlt.lotno   = "N"  THEN DO:
        END. ELSE  NEXT.
    END.
    /* end : A65-0288 07/10/2022 */
ASSIGN
    n_text     = "" 
    nv_Brancho  = ""
    nv_dealero  = ""
    nv_seat     = ""
    nv_campno   = "" .
    IF tlt.note30 <> "" THEN DO:
        ASSIGN
            nv_Brancho  = trim(substr(tlt.note30,1,100))
            nv_dealero  = trim(substr(tlt.note30,101,100))  
            nv_campno   = trim(substr(tlt.note30,201,100)) NO-ERROR.
    END.
    IF  tlt.ln_fst <> ?  THEN nv_first =  string(tlt.ln_fst).
    ASSIGN
        nv_comchr  = ""     nv_expchr  = ""     nv_birchr  = ""     nv_senchr  = ""
        nv_trnchr  = ""     nv_saddr   = ""     nv_first   = ""     nv_ccom  = nv_ccom  + 1.
    IF tlt.note26  <> "" THEN nv_trnchr = tlt.note26 .
    ELSE IF tlt.ndate1  <> ? THEN  nv_trnchr = string(tlt.ndate1    ,"99/99/9999") .
    if tlt.nor_effdat <> ? then nv_comchr    = string(tlt.nor_effdat,"99/99/9999").   
    if tlt.expodat    <> ? then nv_expchr    = string(tlt.expodat   ,"99/99/9999").   
    IF tlt.gendat  <> ? THEN  nv_birchr   = STRING(tlt.gendat,"99/99/9999").
    IF tlt.datesent  <> ? THEN nv_senchr = STRING(tlt.datesent ,"99/99/9999").
    
    IF tlt.hrg_adddr <> "" THEN nv_saddr = tlt.hrg_adddr.
    ELSE DO:
        IF tlt.hrg_no   <> "" AND index(tlt.hrg_no,"เลขที่") = 0  THEN nv_saddr = "เลขที่ " + tlt.hrg_no                              .
        IF tlt.hrg_moo  <> ""  THEN nv_saddr = nv_saddr + " หมู่ "  + tlt.hrg_moo                  .
        IF tlt.hrg_vill <> ""  THEN nv_saddr =  nv_saddr + " อาคาร "    + tlt.hrg_vill             .
        IF tlt.hrg_floor <> "" THEN nv_saddr =  nv_saddr + " ชั้น "    + tlt.hrg_floor             .
        IF tlt.hrg_room  <> "" THEN nv_saddr =  nv_saddr + " ห้อง "    + tlt.hrg_room              .
        IF tlt.hrg_soi   <> "" THEN nv_saddr   = nv_saddr + " ซอย "    + tlt.hrg_soi               .
        IF tlt.hrg_street    <> "" THEN nv_saddr   = nv_saddr + " ถนน "      + tlt.hrg_street      .
        IF tlt.hrg_district <> "" THEN do:  
            IF INDEX( tlt.ins_addr4,"กรุงเทพ") <> 0  THEN nv_saddr  = nv_saddr + " แขวง " + trim(tlt.hrg_district).
            ELSE nv_saddr  = nv_saddr + " ตำบล " + trim(tlt.hrg_district).
        end.
        IF tlt.hrg_subdistrict   <> "" THEN do:  
            IF INDEX( tlt.ins_addr4,"กรุงเทพ") <> 0  THEN nv_saddr   = nv_saddr + " เขต " + trim(tlt.hrg_subdistrict).
            ELSE nv_saddr   = nv_saddr + " อำเภอ " + trim(tlt.hrg_subdistrict).
        end.
        nv_saddr = trim(trim(nv_saddr + " " + tlt.hrg_prov) + " " + tlt.hrg_postcd ).
    END.
    /* add by : A67-0076 */
    ASSIGN nv_drioccup1  = ""   nv_drioccup2  = ""      nv_drioccup3  = ""   nv_drioccup4  = ""   nv_drioccup5  = ""     
        nv_driToccup1    = ""   nv_driToccup2 = ""      nv_driToccup3 = ""   nv_driToccup4 = ""   nv_driToccup5 = ""     
        nv_driTicono1    = ""   nv_driTicono2 = ""      nv_driTicono3 = ""   nv_driTicono4 = ""   nv_driTicono5 = ""     
        nv_driICNo1      = ""   nv_driICNo2   = ""      nv_driICNo3   = ""   nv_driICNo4   = ""   nv_driICNo5   = "" 
        nv_drioccup1    =  if INDEX(tlt.dir_occ1,"TOCC:")  <> 0  then trim(SUBSTR(tlt.dir_occ1,1,INDEX(tlt.dir_occ1,"TOCC:") - 2)) else tlt.dir_occ1
        nv_driToccup1   =  if INDEX(tlt.dir_occ1,"TOCC:")  <> 0  then trim(substr(tlt.dir_occ1,R-INDEX(tlt.dir_occ1,"TOCC:")))     else ""
        nv_driTicono1   =  if index(tlt.dri_ic1,"ICNO:")   <> 0  then trim(SUBSTR(tlt.dri_ic1,1,INDEX(tlt.dri_ic1,"ICNO:") - 2))   else tlt.dri_ic1    
        nv_driICNo1     =  if index(tlt.dri_ic1,"ICNO:")   <> 0  then trim(substr(tlt.dri_ic1,R-INDEX(tlt.dri_ic1,"ICNO:")))       else ""
        nv_drioccup1    =  if index(nv_drioccup1,"OCCUP:") <> 0  then trim(replace(nv_drioccup1,"OCCUP:","")) else nv_drioccup1
        nv_driToccup1   =  if index(nv_driToccup1,"TOCC:") <> 0  then trim(replace(nv_driToccup1,"TOCC:","")) else nv_driToccup1
        nv_driTicono1   =  if index(nv_driTicono1,"TIC:")  <> 0  then trim(replace(nv_driTicono1,"TIC:",""))  else nv_driTicono1
        nv_driICNo1     =  if index(nv_driICNo1,"ICNO:")   <> 0  then trim(replace(nv_driICNo1,"ICNO:",""))   else nv_driICNo1
        nv_drioccup2    =  if INDEX(tlt.dri_occ2,"TOCC:")  <> 0  then trim(SUBSTR(tlt.dri_occ2,1,INDEX(tlt.dri_occ2,"TOCC:") - 2)) else tlt.dri_occ2    
        nv_driToccup2   =  if INDEX(tlt.dri_occ2,"TOCC:")  <> 0  then trim(substr(tlt.dri_occ2,R-INDEX(tlt.dri_occ2,"TOCC:")))     else ""    
        nv_driTicono2   =  if index(tlt.dri_ic2,"ICNO:")   <> 0  then trim(SUBSTR(tlt.dri_ic2,1,INDEX(tlt.dri_ic2,"ICNO:") - 2))   else tlt.dri_ic2    
        nv_driICNo2     =  if index(tlt.dri_ic2,"ICNO:")   <> 0  then trim(substr(tlt.dri_ic2,R-INDEX(tlt.dri_ic2,"ICNO:")))       else ""
        nv_drioccup2    =  if index(nv_drioccup2,"OCCUP:") <> 0  then trim(replace(nv_drioccup2,"OCCUP:","")) else nv_drioccup2   
        nv_driToccup2   =  if index(nv_driToccup2,"TOCC:") <> 0  then trim(replace(nv_driToccup2,"TOCC:","")) else nv_driToccup2  
        nv_driTicono2   =  if index(nv_driTicono2,"TIC:")  <> 0  then trim(replace(nv_driTicono2,"TIC:",""))  else nv_driTicono2  
        nv_driICNo2     =  if index(nv_driICNo2,"ICNO:")   <> 0  then trim(replace(nv_driICNo2,"ICNO:",""))   else nv_driICNo2    
        nv_drioccup3    =  if INDEX(tlt.dir_occ3,"TOCC:")  <> 0  then trim(SUBSTR(tlt.dir_occ3,1,INDEX(tlt.dir_occ3,"TOCC:") - 2)) else tlt.dir_occ3                           
        nv_driToccup3   =  if INDEX(tlt.dir_occ3,"TOCC:")  <> 0  then trim(substr(tlt.dir_occ3,R-INDEX(tlt.dir_occ3,"TOCC:")))     else ""            
        nv_driTicono3   =  if index(tlt.dri_ic3,"ICNO:")   <> 0  then trim(SUBSTR(tlt.dri_ic3,1,INDEX(tlt.dri_ic3,"ICNO:") - 2))   else tlt.dri_ic3   
        nv_driICNo3     =  if index(tlt.dri_ic3,"ICNO:")   <> 0  then trim(substr(tlt.dri_ic3,R-INDEX(tlt.dri_ic3,"ICNO:")))       else ""           
        nv_drioccup3    =  if index(nv_drioccup3,"OCCUP:") <> 0  then trim(replace(nv_drioccup3,"OCCUP:",""))   else nv_drioccup3  
        nv_driToccup3   =  if index(nv_driToccup3,"TOCC:") <> 0  then trim(replace(nv_driToccup3,"TOCC:",""))   else nv_driToccup3 
        nv_driTicono3   =  if index(nv_driTicono3,"TIC:")  <> 0  then trim(replace(nv_driTicono3,"TIC:",""))    else nv_driTicono3 
        nv_driICNo3     =  if index(nv_driICNo3,"ICNO:")   <> 0  then trim(replace(nv_driICNo3,"ICNO:",""))     else nv_driICNo3   
        nv_drioccup4    =  if INDEX(tlt.dri_occ4,"TOCC:")  <> 0  then trim(SUBSTR(tlt.dri_occ4,1,INDEX(tlt.dri_occ4,"TOCC:") - 2)) else tlt.dri_occ4  
        nv_driToccup4   =  if INDEX(tlt.dri_occ4,"TOCC:")  <> 0  then trim(substr(tlt.dri_occ4,R-INDEX(tlt.dri_occ4,"TOCC:")))     else ""            
        nv_driTicono4   =  if index(tlt.dri_ic4,"ICNO:")   <> 0  then trim(SUBSTR(tlt.dri_ic4,1,INDEX(tlt.dri_ic4,"ICNO:") - 2))   else tlt.dri_ic4   
        nv_driICNo4     =  if index(tlt.dri_ic4,"ICNO:")   <> 0  then trim(substr(tlt.dri_ic4,R-INDEX(tlt.dri_ic4,"ICNO:")))       else ""           
        nv_drioccup4    =  if index(nv_drioccup4,"OCCUP:") <> 0  then trim(replace(nv_drioccup4,"OCCUP:",""))  else nv_drioccup4 
        nv_driToccup4   =  if index(nv_driToccup4,"TOCC:") <> 0  then trim(replace(nv_driToccup4,"TOCC:",""))  else nv_driToccup4
        nv_driTicono4   =  if index(nv_driTicono4,"TIC:")  <> 0  then trim(replace(nv_driTicono4,"TIC:",""))   else nv_driTicono4
        nv_driICNo4     =  if index(nv_driICNo4,"ICNO:")   <> 0  then trim(replace(nv_driICNo4,"ICNO:",""))    else nv_driICNo4  
        nv_drioccup5    =  if INDEX(tlt.dri_occ5,"TOCC:")  <> 0  then trim(SUBSTR(tlt.dri_occ5,1,INDEX(tlt.dri_occ5,"TOCC:") - 2)) else tlt.dri_occ5    
        nv_driToccup5   =  if INDEX(tlt.dri_occ5,"TOCC:")  <> 0  then trim(substr(tlt.dri_occ5,R-INDEX(tlt.dri_occ5,"TOCC:")))     else ""              
        nv_driTicono5   =  if index(tlt.dri_ic5,"ICNO:")   <> 0  then trim(SUBSTR(tlt.dri_ic5,1,INDEX(tlt.dri_ic5,"ICNO:") - 2))   else tlt.dri_ic5     
        nv_driICNo5     =  if index(tlt.dri_ic5,"ICNO:")   <> 0  then trim(substr(tlt.dri_ic5,R-INDEX(tlt.dri_ic5,"ICNO:")))       else ""           
        nv_drioccup5    =  if index(nv_drioccup5,"OCCUP:") <> 0  then trim(replace(nv_drioccup5,"OCCUP:",""))  else nv_drioccup5  
        nv_driToccup5   =  if index(nv_driToccup5,"TOCC:") <> 0  then trim(replace(nv_driToccup5,"TOCC:",""))  else nv_driToccup5 
        nv_driTicono5   =  if index(nv_driTicono5,"TIC:")  <> 0  then trim(replace(nv_driTicono5,"TIC:",""))   else nv_driTicono5 
        nv_driICNo5     =  if index(nv_driICNo5,"ICNO:")   <> 0  then trim(replace(nv_driICNo5,"ICNO:",""))    else nv_driICNo5   .
    /* end : A67-0076 */                                                                                                 
    nv_Seat = "".
    IF tlt.noteveh1 = "21" THEN nv_Seat = "15".
    ELSE if tlt.noteveh1 = "22" THEN nv_Seat = "20".
    ELSE if tlt.noteveh1 = "23" THEN nv_Seat = "40".
    ELSE if tlt.noteveh1 = "24" THEN nv_Seat = "41".
    IF tlt.lotno = "Y" THEN DO:
        ASSIGN 
        nv_ispno     = trim(substr(tlt.acno1,1,INDEX(tlt.acno1," ")))  
        nv_ispclose  = trim(SUBSTR(tlt.acno1,R-INDEX(tlt.acno1,"Close Date:") + 12))
        nv_ispresult = IF index(tlt.mobile,"รายการความเสียหาย") <> 0 THEN trim(substr(tlt.mobile,1,index(tlt.mobile,"รายการความเสียหาย") - 2)) ELSE tlt.mobile
        nv_ispdam    = IF index(tlt.mobile,"รายการความเสียหาย") <> 0 THEN trim(substr(tlt.mobile,R-INDEX(tlt.mobile,"รายการความเสียหาย") + 17)) ELSE ""
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
    OUTPUT TO VALUE(nv_file) APPEND.
        RUN proc_detail_report3.
    OUTPUT CLOSE.
END.
Message "Export data Complete"  View-as alert-box.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_reportca c-wins 
PROCEDURE proc_reportca :
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

nv_file = fi_filename. /*--add by Chaiyong W. A64-0135 21/06/2021*/
If  substr(nv_file,length(nv_file) - 3,4) <>  ".csv"  THEN 
    nv_file  =  Trim(nv_file) + ".csv"  .

OUTPUT TO VALUE(nv_file). 
EXPORT DELIMITER "|" 
    "บริษัทเงินทุน ธนาคารเกียรตินาคิน จำกัด (มหาชน) ." .
EXPORT DELIMITER "|" 
    "ลำดับที่" 
    "วันที่แจ้งกลับงานติดปัญหา"  
    "บริษัทประกัน             "  
    "ประเภทงานติดปัญหา        "  
    "เลขที่สัญญา              "  
    "ชื่อ-สกุล ลูกค้า         "  
    "Telesale                 "  
    "ปัญหา                    "  
    "สาเหตุ                   "  
    "หัวหน้าทีม               "  
    "แจ้งผลกลับ               "  
    "เบอร์ติดต่อกลับลูกค้า    "  
    "วันที่แจ้งผลกลับ         "  
    "หมายเหตุ                 "  
    "KK Application No.       "
    "ตรวจสภาพ                 " 
    "สถานะกล่องตรวจสภาพ       "
    "เลขที่ตรวจสภาพ           "
    "Status                   "  .

FOR EACH tlt Use-index  tlt01  Where
    tlt.trndat        >=   fi_trndatfr   And
    tlt.trndat        <=   fi_trndatto   And
    tlt.comp_noti_tlt >=   fi_polfr      And
    tlt.comp_noti_tlt <=   fi_polto      And
    tlt.genusr   =  "KK"                 no-lock. 
    IF (cb_report = "Hold") THEN DO: 
        IF (INDEX(tlt.OLD_eng,"hold") = 0 ) THEN NEXT. 
        IF (INDEX(tlt.OLD_eng,"Cancel_Hold") <> 0 )  THEN NEXT.
    END.
    IF (cb_report = "CA") AND (index(tlt.Releas,"ca") = 0 ) THEN NEXT.      /* A61-0335 */
    /*--Begin by Chaiyong W. A64-0135 13/09/2021*/
    IF ra_new = 2 THEN DO: 
        IF ( tlt.note1     <> "" OR tlt.note2    <>  ""  )  THEN DO:
        END.
        ELSE NEXT.
    END.
    ELSE DO:
        IF ( tlt.note1     =  "" OR tlt.note2   =   ""  )  THEN DO:
        END.
        ELSE NEXT.

    END.
    IF ra_type = 1 THEN DO:
        IF index(tlt.note5,"renew") <> 0 THEN NEXT .
    END.
    ELSE IF ra_type = 2 THEN DO:
        IF index(tlt.note5,"renew") = 0 THEN NEXT .
    END.
    /*End by Chaiyong W. A64-0135 13/09/2021----*/
           
    ASSIGN n_record = n_record + 1.
    EXPORT DELIMITER "|" 
        n_record                                            
        string(TODAY,"99/99/9999") FORMAT "x(15)" 
        trim(tlt.nor_usr_ins)      FORMAT "x(50)"   
        "ประกัน "                  
        trim(tlt.nor_noti_tlt)     FORMAT "X(20)"
        trim(tlt.ins_name)         FORMAT "X(100)"             
        trim(tlt.comp_usr_in)      FORMAT "X(60)"
        trim(tlt.OLD_eng)          FORMAT "X(250)"
        trim(tlt.OLD_cha)          FORMAT "X(250)"
        ""                         
        ""                         
        ""                         
        STRING(today,"99/99/9999") FORMAT "X(15)" 
        trim(tlt.safe1)            FORMAT "X(250)"
        trim(tlt.expotim)          FORMAT "X(20)"
        tlt.usrsent                                    /*A65-0288*/
        tlt.lotno                                      /*A65-0288*/
        trim(substr(tlt.acno1,1,INDEX(tlt.acno1," "))) /*A65-0288*/  
        tlt.Releas FORMAT "x(10)"    .       /* A56-0309 */
END.   /*  end  wdetail  */

RELEASE tlt.
/*end.add by Kridtiya i. A55-0029.....30/01/2012 */
OUTPUT CLOSE. /*----add by Chaiyong W. A64-0135 21/06/2021*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_reportp c-wins 
PROCEDURE proc_reportp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

DEF VAR nv_inscom AS CHAR INIT "".
DEF VAR nv_comcod AS CHAR INIT "".

DEF VAR nv_month  AS CHAR INIT "".
DEF VAR nv_trchr  AS CHAR INIT "".
DEF VAR nv_file   AS CHAR INIT "".
DEF VAR nv_file2  AS CHAR INIT "".
DEF VAR nv_comchr AS CHAR INIT "".
DEF VAR nv_expchr AS CHAR INIT "".
DEF VAR nv_birchr AS CHAR INIT "".
DEF VAR nv_senchr AS CHAR INIT "".
DEF VAR nv_trnchr AS CHAR INIT "".
DEF VAR nv_saddr  AS CHAR INIT "".
DEF VAR nv_first  AS CHAR INIT "".
DEF VAR nv_chol   AS INT  INIT 0.
def var  nv_Brancho   as char init "".
def var  nv_dealero   as char init "".


RUN wuw\wuwppics3(INPUT TODAY,INPUT "COMP_NO",OUTPUT nv_inscom).
IF nv_inscom = "" THEN nv_inscom = "2780".
RUN wuw\wuwppics3(INPUT TODAY,INPUT "COMP_CODE",OUTPUT nv_comcod).
IF nv_comcod = "" THEN nv_comcod= "TMSTH".
 nv_file  = fi_filename.
 
    IF INDEX (nv_file,".csv") <> 0 THEN DO:

    END.
    ELSE nv_file = nv_file + ".csv".

    
  OUTPUT TO VALUE(nv_file). 
 EXPORT DELIMITER "|"
    "KK_APP_NO             "                            
    "QUOTATION_NO          "
    "INSURANCE_COMPANY_CODE"
    "TRANSACTION_DATE      "
    "PROBLEM_DESCRIPTION   "
    "REMARK                " SKIP.
 
 OUTPUT CLOSE.
loop_for:
FOR EACH tlt Use-index  tlt01  Where
    tlt.trndat        >=   fi_trndatfr   And
    tlt.trndat        <=   fi_trndatto   And
    tlt.comp_noti_tlt >=   fi_polfr      And
    tlt.comp_noti_tlt <=   fi_polto      And
    tlt.genusr   =  "KK"                 NO-LOCK: 
    
    IF ra_type = 1 THEN DO:
        IF index(tlt.note5,"renew") <> 0 THEN NEXT loop_for.
    END.
    ELSE IF ra_type = 2 THEN DO:
        IF index(tlt.note5,"renew") = 0 THEN NEXT loop_for.
    END.

    ASSIGN

         nv_month    = ""
         nv_trchr    = ""
         nv_comchr   = ""
         nv_expchr   = ""
         nv_birchr   = ""
         nv_senchr   = ""
         nv_trnchr   = ""
         nv_saddr    = ""
         nv_first    = ""
         nv_Brancho  = ""
         nv_dealero  = ""
        .                                                  
   
    IF tlt.note29 <> "Y" THEN NEXT.

 
        IF tlt.trndat <> ? THEN DO:
            nv_month = STRING((MONTH(tlt.trndat) + 12),"999").
            FIND FIRST sicsyac.xmd179 USE-INDEX xmd17901 WHERE xmd179.docno = "008" AND
                      xmd179.poltyp EQ "" AND xmd179.headno = nv_month NO-LOCK NO-ERROR.
            IF AVAIL sicsyac.xmd179 THEN nv_month = caps(trim(SUBSTR(sicsyac.xmd179.head,1,3)))  .
            ELSE nv_month = " ".
    
             nv_trchr  = STRING(DAY(tlt.trndat),"99")  + "-" + nv_month + "-" + STRING(YEAR(tlt.trndat),"9999").
    
    
        END.
    
    
        OUTPUT TO VALUE( nv_file) APPEND.
        EXPORT DELIMITER "|"
                tlt.expotim
                tlt.note3    
             IF  nv_inscom = "" THEN   tlt.nor_usr_ins ELSE  nv_inscom
                nv_trchr 
                tlt.note24  
                ""
                SKIP.
        OUTPUT CLOSE.
    END.
   Message "Export data Complete"  View-as alert-box.
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
    For each tlt Use-index  tlt01 NO-LOCK 
    WHERE 
    tlt.trndat         >=  fi_trndatfr   And
    tlt.trndat         <=  fi_trndatto   And
    tlt.comp_noti_tlt  >=  fi_polfr      And
    tlt.comp_noti_tlt  <=  fi_polto      And
    tlt.genusr   =  "KK"          .
        
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

