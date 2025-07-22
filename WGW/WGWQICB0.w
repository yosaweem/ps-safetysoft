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
  Create  by   :  Kridtiya i. [A53-0207]   On   28/05/2010
  Connect      :  sic_test, stat   
  modify by    :  kridtiya i. A54-0216 ปรับการแสดงกรมธรรม์ให้เร็วยิ่งขึ้น 
  modify by    :  kridtiya i. A55-0184 22/05/2012 ปรับการแสดงกรมธรรม์ให้เร็วยิ่งขึ้น 
  modify by    :  Kridtiya i. A55-0365 เพิ่มส่วนการเรียกรายงานแสดงงานค้างระบบ
  modify by    :  Kridtiya i. A56-0146 เพิ่ม การ update status yes/no/cancel ในข้อมูลแรกได้
  modify by    :  Kridtiya i. A56-0323 เพิ่ม การ ให้ค่า record แรก
/*modify by   : Kridtiya i. A57-0262 add new format idno and id br name */
/*Modify by  : Ranu I. A60-0263 เพิ่มการดึงข้อมูล Campagin ออกในไฟล์ */
+++++++++++++++++++++++++++++++++++++++++++++++*/

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
IF ( tlt.recac  = ""  ) THEN ("NO") ELSE ("YES") ~
If  tlt.flag  =  "N"  Then  "New"  Else If  tlt.flag = "R" Then  "Renew" Else  " " ~
tlt.exp tlt.filler1 tlt.nor_noti_tlt tlt.safe2 tlt.ins_name tlt.cha_no ~
tlt.gendat tlt.expodat tlt.nor_coamt tlt.nor_grprm tlt.comp_sck ~
tlt.comp_effdat tlt.nor_effdat tlt.comp_grprm tlt.comp_coamt ~
tlt.nor_noti_ins tlt.comp_pol 
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_tlt 
&Scoped-define QUERY-STRING-br_tlt FOR EACH tlt NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-br_tlt OPEN QUERY br_tlt FOR EACH tlt NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-br_tlt tlt
&Scoped-define FIRST-TABLE-IN-QUERY-br_tlt tlt


/* Definitions for FRAME fr_main                                        */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS bu_exit ra_status fi_trndatfr fi_trndatto ~
bu_ok cb_search bu_oksch br_tlt fi_search bu_update cb_report fi_br ~
fi_outfile bu_report bu_upyesno RECT-332 RECT-333 RECT-338 RECT-339 ~
RECT-340 RECT-341 RECT-381 RECT-382 
&Scoped-Define DISPLAYED-OBJECTS ra_status fi_trndatfr fi_trndatto ~
cb_search fi_search fi_name cb_report fi_br fi_outfile 

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
     LIST-ITEMS "ชื่อผู้เอาประกัน" 
     DROP-DOWN-LIST
     SIZE 40 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_br AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 3.5 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_name AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 39 BY .95
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

DEFINE RECTANGLE RECT-332
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132.5 BY 8.48
     BGCOLOR 20 .

DEFINE RECTANGLE RECT-333
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 14 BY 1.81
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
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 130.5 BY 2.05
     BGCOLOR 29 .

DEFINE RECTANGLE RECT-341
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 14 BY 1.81
     BGCOLOR 4 .

DEFINE RECTANGLE RECT-381
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 7.5 BY 1.52
     BGCOLOR 2 FGCOLOR 2 .

DEFINE RECTANGLE RECT-382
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 13.67 BY 1.62
     BGCOLOR 12 .

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_tlt FOR 
      tlt SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_tlt
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_tlt c-wins _STRUCTURED
  QUERY br_tlt NO-LOCK DISPLAY
      tlt.releas COLUMN-LABEL "Cancle/Confirm" FORMAT "x(20)":U
            WIDTH 12.83
      IF ( tlt.recac  = ""  ) THEN ("NO") ELSE ("YES") COLUMN-LABEL "Match File" FORMAT "X(5)":U
            WIDTH 8.5
      If  tlt.flag  =  "N"  Then  "New"  Else If  tlt.flag = "R" Then  "Renew"
Else  " " COLUMN-LABEL "New/Renew" FORMAT "x(8)":U
            WIDTH 11.83 LABEL-FGCOLOR 1 LABEL-FONT 6
      tlt.exp COLUMN-LABEL "ฺBR." FORMAT "XX":U
      tlt.filler1 COLUMN-LABEL "Old Policy" FORMAT "x(20)":U WIDTH 15
      tlt.nor_noti_tlt COLUMN-LABEL "เลขรับแจ้ง" FORMAT "x(25)":U
      tlt.safe2 COLUMN-LABEL "เลขที่สัญญา" FORMAT "x(10)":U
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
      tlt.nor_noti_ins COLUMN-LABEL "New Policy" FORMAT "x(20)":U
            WIDTH 15
      tlt.comp_pol COLUMN-LABEL "Comp Policy" FORMAT "x(20)":U
            WIDTH 15
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 132.5 BY 15.14
         BGCOLOR 15 FGCOLOR 1 FONT 1 ROW-HEIGHT-CHARS .75.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     bu_exit AT ROW 1.67 COL 107.67
     ra_status AT ROW 6.33 COL 79.5 NO-LABEL
     fi_trndatfr AT ROW 1.81 COL 25.33 COLON-ALIGNED NO-LABEL
     fi_trndatto AT ROW 1.81 COL 61.5 COLON-ALIGNED NO-LABEL
     bu_ok AT ROW 1.76 COL 94.17
     cb_search AT ROW 3.52 COL 16.83 COLON-ALIGNED NO-LABEL
     bu_oksch AT ROW 4.86 COL 53.33
     br_tlt AT ROW 9.67 COL 1.33
     fi_search AT ROW 4.76 COL 3.67 NO-LABEL
     fi_name AT ROW 4.76 COL 61 COLON-ALIGNED NO-LABEL
     bu_update AT ROW 4.81 COL 102.83
     cb_report AT ROW 6.38 COL 16.33 COLON-ALIGNED NO-LABEL
     fi_br AT ROW 7.52 COL 16.33 COLON-ALIGNED NO-LABEL
     fi_outfile AT ROW 7.52 COL 47.5 NO-LABEL
     bu_report AT ROW 7.38 COL 114.33
     bu_upyesno AT ROW 4.81 COL 118
     "CLICK FOR UPDATE DATA FLAG CANCEL":40 VIEW-AS TEXT
          SIZE 41.5 BY .95 AT ROW 3.52 COL 63.33
          BGCOLOR 19 FGCOLOR 6 FONT 6
     "**สาขาใส่ข้อมูลตามช่อง BR ( ICBC ~\ STY ) :" VIEW-AS TEXT
          SIZE 34.17 BY .67 AT ROW 8.62 COL 3.83
          BGCOLOR 20 FGCOLOR 4 
     " STATUS FLAG :" VIEW-AS TEXT
          SIZE 17 BY 1 AT ROW 6.33 COL 61.5
          BGCOLOR 3 FGCOLOR 7 FONT 6
     " BRANCH :" VIEW-AS TEXT
          SIZE 11.5 BY .95 AT ROW 7.52 COL 5.83
          BGCOLOR 3 FGCOLOR 7 FONT 6
     "To  :" VIEW-AS TEXT
          SIZE 7.5 BY 1 AT ROW 1.81 COL 55
          BGCOLOR 29 FGCOLOR 2 FONT 6
     " OUTPUT FILE NAME :" VIEW-AS TEXT
          SIZE 23.33 BY .95 AT ROW 7.52 COL 23.33
          BGCOLOR 3 FGCOLOR 7 FONT 6
     "วันที่ไฟล์แจ้งงาน  From :" VIEW-AS TEXT
          SIZE 21.5 BY 1 AT ROW 1.81 COL 4.83
          BGCOLOR 29 FGCOLOR 2 FONT 6
     "SEARCH BY :" VIEW-AS TEXT
          SIZE 14 BY 1 AT ROW 3.52 COL 4.33
          BGCOLOR 21 FGCOLOR 0 FONT 6
     " 01 = M , 02 = U , 03 = 36 , 04 = 06  , 05 = P , 06 = 2 , 07 = H , 08 = 3 **" VIEW-AS TEXT
          SIZE 57 BY .62 AT ROW 8.67 COL 38
          BGCOLOR 20 FGCOLOR 4 
     "REPORT BY :" VIEW-AS TEXT
          SIZE 14 BY .95 AT ROW 6.43 COL 3.33
          BGCOLOR 3 FGCOLOR 7 FONT 6
     RECT-332 AT ROW 1.1 COL 1.33
     RECT-333 AT ROW 1.33 COL 91.67
     RECT-338 AT ROW 3.29 COL 2.5
     RECT-339 AT ROW 3.29 COL 61.83
     RECT-340 AT ROW 1.24 COL 2.33
     RECT-341 AT ROW 1.33 COL 105.5
     RECT-381 AT ROW 4.57 COL 52.17
     RECT-382 AT ROW 7.05 COL 112.83
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
         TITLE              = "Query && Update [ICBCTL]"
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
"tlt.releas" "Cancle/Confirm" "x(20)" "character" ? ? ? ? ? ? no ? no no "12.83" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[2]   > "_<CALC>"
"IF ( tlt.recac  = """"  ) THEN (""NO"") ELSE (""YES"")" "Match File" "X(5)" ? ? ? ? ? ? ? no ? no no "8.5" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   > "_<CALC>"
"If  tlt.flag  =  ""N""  Then  ""New""  Else If  tlt.flag = ""R"" Then  ""Renew""
Else  "" """ "New/Renew" "x(8)" ? ? ? ? ? 1 6 no ? no no "11.83" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   > brstat.tlt.exp
"tlt.exp" "ฺBR." ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   > brstat.tlt.filler1
"tlt.filler1" "Old Policy" "x(20)" "character" ? ? ? ? ? ? no ? no no "15" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[6]   > brstat.tlt.nor_noti_tlt
"tlt.nor_noti_tlt" "เลขรับแจ้ง" ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[7]   > brstat.tlt.safe2
"tlt.safe2" "เลขที่สัญญา" "x(10)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[8]   > brstat.tlt.ins_name
"tlt.ins_name" "Insured name" ? "character" ? ? ? ? ? ? no ? no no "25" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[9]   > brstat.tlt.cha_no
"tlt.cha_no" "Chassic no." ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[10]   > brstat.tlt.gendat
"tlt.gendat" "Comdate_70" ? "date" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[11]   > brstat.tlt.expodat
"tlt.expodat" "Expdat_70" "99/99/9999" "date" ? ? ? ? ? ? no ? no no "10" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[12]   > brstat.tlt.nor_coamt
"tlt.nor_coamt" "SI" ? "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[13]   > brstat.tlt.nor_grprm
"tlt.nor_grprm" "Gross premium 70" ">>,>>>,>>9.99" "decimal" ? ? ? ? ? ? no ? no no "11.5" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[14]   > brstat.tlt.comp_sck
"tlt.comp_sck" "Sticker no." "x(15)" "character" ? ? ? ? ? ? no ? no no "14.17" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[15]   > brstat.tlt.comp_effdat
"tlt.comp_effdat" "Comdat_72" ? "date" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[16]   > brstat.tlt.nor_effdat
"tlt.nor_effdat" "Expdat_72" ? "date" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[17]   > brstat.tlt.comp_grprm
"tlt.comp_grprm" "Gross premium 72" ">>>,>>9.99" "decimal" ? ? ? ? ? ? no ? no no "9.33" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[18]   > brstat.tlt.comp_coamt
"tlt.comp_coamt" "Total Prem." ? "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[19]   > brstat.tlt.nor_noti_ins
"tlt.nor_noti_ins" "New Policy" "x(20)" "character" ? ? ? ? ? ? no ? no no "15" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[20]   > brstat.tlt.comp_pol
"tlt.comp_pol" "Comp Policy" "x(20)" "character" ? ? ? ? ? ? no ? no no "15" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _Query            is NOT OPENED
*/  /* BROWSE br_tlt */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME c-wins
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c-wins c-wins
ON END-ERROR OF c-wins /* Query  Update [ICBCTL] */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c-wins c-wins
ON WINDOW-CLOSE OF c-wins /* Query  Update [ICBCTL] */
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
        Run  wgw\wgwqicb2(Input  nv_recidtlt).
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
        tlt.genusr   =  "ICBCTL"        no-lock.  
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
            tlt.genusr   =  "ICBCTL"            And
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
            tlt.genusr    =  "ICBCTL"      And
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
            tlt.genusr    =  "ICBCTL"      And
            tlt.flag      =  "R"          no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .  /*add Kridtiya i. A56-0323*/
                Apply "Entry"  to br_tlt.
                Return no-apply.        
    END.
    ELSE If  cb_search  = "เลขตัวถัง"  Then do:  /* chassis no */
        Open Query br_tlt 
            For each tlt Use-index  tlt06 Where
            tlt.trndat >=  fi_trndatfr    And
            tlt.trndat <=  fi_trndatto    AND 
            tlt.genusr   =  "ICBCTL"       And
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
            tlt.genusr   =  "ICBCTL"        And
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
            tlt.genusr   =  "ICBCTL"         And
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
            tlt.genusr   =  "ICBCTL"        And
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
            tlt.genusr   =  "ICBCTL"        And
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
  gv_prgid = "wgwqicb0".
  gv_prog  = "Query & Update  Detail  (ICBCTL) ".
  RUN  WUT\WUTHEAD ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).

  SESSION:DATA-ENTRY-RETURN = YES.


  Rect-333:Move-to-top().
  Rect-338:Move-to-top().  
  Rect-339:Move-to-top(). 
  RECT-381:Move-to-top().

  ASSIGN 
      fi_trndatfr = TODAY
      fi_trndatto = TODAY
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
      fi_outfile = "C:\TEMP\ICBCTL" + 
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
          cb_report fi_br fi_outfile 
      WITH FRAME fr_main IN WINDOW c-wins.
  ENABLE bu_exit ra_status fi_trndatfr fi_trndatto bu_ok cb_search bu_oksch 
         br_tlt fi_search bu_update cb_report fi_br fi_outfile bu_report 
         bu_upyesno RECT-332 RECT-333 RECT-338 RECT-339 RECT-340 RECT-341 
         RECT-381 RECT-382 
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
DEF VAR n_bran      AS CHAR FORMAT "x(2)".
DEF VAR n_icno    AS CHAR FORMAT "x(15)" init "".
DEF VAR n_class70 AS CHAR FORMAT "x(5)"  init "".
DEF VAR n_class72 AS CHAR FORMAT "x(5)"  init "".
DEF VAR n_covcod  AS CHAR FORMAT "x(25)" init "".
DEF VAR n_fi      AS CHAR FORMAT "x(15)" init "".
DEF VAR n_benname AS CHAR FORMAT "x(50)" init "".
DEF VAR n_delear  AS CHAR FORMAT "x(50)" init "".

If  substr(fi_outfile,length(fi_outfile) - 3,4) <>  ".slk"  THEN 
    fi_outfile  =  Trim(fi_outfile) + ".slk"  .
/*ASSIGN nv_cnt =  0
    nv_row  =  1.*/
OUTPUT TO VALUE(fi_outfile).
EXPORT DELIMITER "|" 
    "Export ICBCTL :" 
    string(TODAY)   .
EXPORT DELIMITER "|" 
    "ประเภทงาน          "
    "ชื่อบริษัทประกัน   "
    "สาขา               "
    "เลขรับแจ้ง         "
    "เลข กธ.เดิม        "
    "เลข กธ.ใหม่        "
    "เลข พรบ.           "
    "เลขสติ๊กเกอร์      "
    "เลขสัญญา           "
    "ชื่อลูกค้า         "
    "เลขบัตรประชาชน     "
    "ที่อยู่ตามหน้าตาราง"
    "ประเภทรถยนต์       "
    "ยี่ห้อ             "
    "รุ่นรถ             "
    "cc                 "
    "ปีรถ               "
    "เลขเครื่อง         "
    "เลขถัง             "
    "ทะเบียน            "
    "จังหวัด            "
    "ประเภทจดทะเบียน    "
    "ความคุ้มครอง       "
    "ทุนชน              "
    "ทุนหาย             "
    "วันคุ้มครอง        "
    "วันหมดอายุ         "
    "เบี้ยสุทธิ         "
    "เบี้ยรวม           "
    "วันคุ้มครอง72      "
    "วันหมดอายุ72       "
    "เบี้ยสุทธิ72       "
    "เบี้ยรวม72         "
    "ผู้แจ้ง            "
    "ผู้รับผลประโยขน์   "
    "ดีลเลอร์           "
    "หมายเหตุ           "
    "แคมเปญ             " /*A60-0263*/
    "ข้อมูลการ Confirm  "
    "วันที่ confirm     "
    "การออกงาน          " .
loop_tlt:
For each tlt Use-index  tlt01 Where
            tlt.trndat   >=  fi_trndatfr   And
            tlt.trndat   <=  fi_trndatto   And
            tlt.genusr    =  "ICBCTL"       no-lock. 
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
    n_bran     = ""      n_icno      = ""
    n_comdat70 = ""      n_class70   = ""
    n_comdat72 = ""      n_class72   = ""
    n_expdat70 = ""      n_covcod    = ""
    n_expdat72 = ""      n_fi        = ""
    n_bdate1   = ""      n_benname   = ""
    n_bdate2   = ""      n_delear    = ""
    n_comdat70 = IF tlt.gendat <> ? THEN STRING(tlt.gendat,"99/99/9999") ELSE ""             /*วันที่เริ่มคุ้มครอง     */         
    n_expdat70 = IF tlt.expodat <> ? THEN STRING(tlt.expodat,"99/99/9999") ELSE ""            /*วันที่สิ้นสุดคุ้มครอง   */         
    n_comdat72 = IF tlt.comp_effdat <> ? THEN STRING(tlt.comp_effdat,"99/99/9999") ELSE ""   /*วันทีเริ่มคุ้มครองพรบ   */         
    n_expdat72 = IF tlt.nor_effdat <> ? THEN STRING(tlt.nor_effdat,"99/99/9999") ELSE ""     /*วันที่สิ้นสุดคุ้มครองพรบ*/         
    n_bdate1   = IF (tlt.dri_no1 <> "" AND tlt.dri_no1 <> ? ) THEN STRING(tlt.dri_no1,"99/99/9999") ELSE ""           /*วันเดือนปีเกิด1         */                                                                                    
    n_bdate2   = IF (tlt.dri_no2 <> "" AND tlt.dri_no2 <> ? ) THEN STRING(tlt.dri_no2,"99/99/9999") ELSE ""       /*วันเดือนปีเกิด2         */
    n_icno     = IF INDEX(tlt.ins_addr5,"Occ") <> 0 THEN trim(SUBSTR(tlt.ins_addr5,5,R-INDEX(tlt.ins_addr5,"Occ") - 6)) 
                 ELSE trim(SUBSTR(tlt.ins_addr5,5,LENGTH(tlt.ins_addr5)))
    n_class72  = trim(substr(tlt.safe3,8,R-INDEX(tlt.safe3,"class70") - 8)) 
    n_covcod   = trim(SUBSTR(tlt.expousr,R-INDEX(tlt.expousr,"Covtyp") + 6,LENGTH(tlt.expousr)))
    n_fi       = IF INDEX(tlt.nor_usr_tlt,"wht70") <> 0 THEN trim(SUBSTR(tlt.nor_usr_tlt,3,R-INDEX(tlt.nor_usr_tlt,"wht70") - 3)) 
                 ELSE SUBSTR(tlt.nor_usr_tlt,3,length(tlt.nor_usr_tlt))
    n_benname  = trim(SUBSTR(tlt.safe1,1,R-INDEX(tlt.safe1,"Delear") - 1))                        
    n_delear   = IF tlt.flag = "N" THEN trim(SUBSTR(tlt.safe1,R-INDEX(tlt.safe1,"Delear") + 7,length(tlt.safe1))) ELSE "" .

                                                                                                                  
    IF tlt.flag = "N" THEN DO:
        IF INDEX(tlt.EXP,"1") <> 0  THEN ASSIGN n_bran = "M".
        ELSE IF index(tlt.EXP,"2") <> 0  THEN ASSIGN n_bran = "U".
        ELSE IF index(tlt.EXP,"3") <> 0  THEN ASSIGN n_bran = "36".
        ELSE IF index(tlt.EXP,"4") <> 0  THEN ASSIGN n_bran = "6".
        ELSE IF index(tlt.EXP,"5") <> 0  THEN ASSIGN n_bran = "P".
        ELSE IF index(tlt.EXP,"6") <> 0  THEN ASSIGN n_bran = "2".
        ELSE IF index(tlt.EXP,"7") <> 0  THEN ASSIGN n_bran = "H".
        ELSE IF index(tlt.EXP,"8") <> 0  THEN ASSIGN n_bran = "3".
    END.
    ELSE DO:
        IF tlt.filler1 <> "" THEN 
            ASSIGN n_bran = IF SUBSTR(tlt.filler1,1,1) = "D" THEN SUBSTR(tlt.filler1,2,1) ELSE SUBSTR(tlt.filler1,1,2).
        ELSE ASSIGN n_bran = "".
    END.

    EXPORT DELIMITER "|"
    IF tlt.flag = "N" THEN "NEW" ELSE "RENEW"                                                           /*ประเภทงาน          */
    tlt.rec_addr3                                                                                       /*ชื่อบริษัทประกัน   */
    n_bran                                                                                              /*สาขา               */
    brstat.tlt.nor_noti_tlt                                                                             /*เลขรับแจ้ง         */
    tlt.filler1                                                                                         /*เลข กธ.เดิม        */
    tlt.nor_noti_ins                                                                                    /*เลข กธ.ใหม่        */
    tlt.comp_pol                                                                                        /*เลข พรบ.           */
    tlt.comp_sck                                                                                        /*เลขสติ๊กเกอร์      */
    tlt.safe2                                                                                           /*เลขสัญญา           */
    tlt.rec_name  + " " + tlt.ins_name                                                                  /*ชื่อลูกค้า         */
    n_icno /*SUBSTR(tlt.ins_addr5,5,INDEX(tlt.ins_addr5," ")) FORMAT "x(15)"*/                                     /*เลขบัตรประชาชน     */
    tlt.ins_addr1 + " " + tlt.ins_addr2 + " " + tlt.ins_addr3 + " " + tlt.ins_addr4                     /*ที่อยู่ตามหน้าตาราง*/
    tlt.old_eng                                                                                         /*ประเภทรถยนต์       */
    tlt.brand                                                                                           /*ยี่ห้อ             */
    tlt.model                                                                                           /*รุ่นรถ             */
    tlt.cc_weight                                                                                       /*cc                 */
    tlt.lince2                                                                                          /*ปีรถ               */
    tlt.eng_no                                                                                          /*เลขเครื่อง         */
    tlt.cha_no                                                                                          /*เลขถัง             */
    tlt.lince1                                                                                          /*ทะเบียน            */
    tlt.lince3                                                                                          /*จังหวัด            */
    n_class72  /*substr(tlt.safe3,8,INDEX(tlt.safe3," ") - 1)*/                                                        /*ประเภทจดทะเบียน    */
    n_covcod   /*substr(tlt.expousr,index(tlt.expousr,"Covtyp") + 8,LENGTH(tlt.expousr)) FORMAT "x(25)" */            /*ความคุ้มครอง       */
    tlt.nor_coamt                                                                                      /*ทุนชน              */
    n_fi /*SUBSTR(tlt.nor_usr_tlt,3,INDEX(tlt.nor_usr_tlt," ")) FORMAT "x(15)" */                               /*ทุนหาย             */
    n_comdat70                                                                                          /*วันคุ้มครอง        */
    n_expdat70                                                                                          /*วันหมดอายุ         */
    tlt.nor_grprm                                                                                       /*เบี้ยสุทธิ         */
    tlt.comp_coamt                                                                                      /*เบี้ยรวม           */
    n_comdat72                                                                                          /*วันคุ้มครอง72      */
    n_expdat72                                                                                          /*วันหมดอายุ72       */
    tlt.comp_grprm                                                                                      /*เบี้ยสุทธิ72       */
    tlt.rec_addr4                                                                                       /*เบี้ยรวม72         */
    tlt.nor_usr_ins                                                                                     /*ผู้แจ้ง            */
    n_benname   /*SUBSTR(tlt.safe1,1,INDEX(tlt.safe1,"Delear") - 7) FORMAT "x(50)" */                                   /*ผู้รับผลประโยขน์   */
    n_delear    
    tlt.filler2                                                                                         /*หมายเหตุ           */
    tlt.lotno   FORMAT "x(20)"  /*A60-0263*/
    IF tlt.recac = "" THEN "ยังไม่ Confirm" ELSE trim(tlt.recac)                                        /*ข้อมูลการ Confirm  */
    IF tlt.dat_ins_noti = ? THEN "" ELSE STRING(tlt.dat_ins_noti,"99/99/9999")                          /*วันที่ confirm     */
    tlt.releas.                                                                                         /*การออกงาน          */

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
/*If  fi_polfr  =   "0"  Then  fi_polfr  =  " "  .*/
Open Query br_tlt 
    For each tlt Use-index  tlt01 Where
        tlt.trndat  >=  fi_trndatfr  And
        tlt.trndat  <=  fi_trndatto  And
        /*tlt.policy >=  fi_polfr      And
        tlt.policy <=  fi_polto     And*/
        /*  tlt.comp_sub  =  fi_producer  And*/
        tlt.genusr   =  "ICBCTL" NO-LOCK .
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

