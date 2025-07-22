&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          brstat           PROGRESS
*/
&Scoped-define WINDOW-NAME WUWCODEL
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS WUWCODEL 
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
/*          This .W file was created with the Progress AppBuilder.      */
/*----------------------------------------------------------------------*/

/* Create an unnamed pool to store all the widgets created 
     by this procedure. This is a good default which assures
     that this procedure's triggers and internal procedures 
     will execute in this procedure's storage, and that proper
     cleanup will occur on deletion of the procedure. */
/*Modify by   : Kridtiya i.A53-0182 เพิ่มตัวเก็บ code producer,agent code 
              ตรวจสอบที่ table xmm600 ถ้าไม่พบไม่ให้เก็บค่า แสดงเป็นค่าว่าง */
/*Modify by   : Kridtiya i.A53-0232 ขยายการเช็คชื่อบริษัทจากเดิม ไม่เกิน 3 ตัว
              ปรับเป็น 10 ตัวอักษร                                          */
CREATE WIDGET-POOL.

/* ***************************  Definitions  ************************** */

/* Parameters Definitions ---                                           */

/* Local Variable Definitions ---                                       */

/*{wuw/wuwm0001.i}*/

DEF SHARED VAR n_User     AS CHAR.
DEF SHARED VAR n_Passwd   AS CHAR.
DEF VAR    cUpdate AS CHAR.
DEF BUFFER bComp   FOR Company.
DEF VAR nv_progname AS CHAR.
DEF VAR nv_objname AS CHAR.
DEF VAR nv_StrEnd AS CHAR.
DEF VAR nv_Str AS CHAR.
DEF VAR nv_NextPolflg AS INT.
DEF VAR nv_RenewPolflg AS INT.
DEF VAR nv_PrePol  AS CHAR.
DEF VAR pComp AS CHAR.
DEF VAR pRowIns AS ROWID.
DEF NEW SHARED VAR gUser   AS CHAR.
DEF NEW SHARED VAR gPasswd AS CHAR.
DEF VAR gComp   AS CHAR.
/* gComp = "5". */
DEF NEW SHARED VAR gRecMod   AS Recid.
DEF NEW SHARED VAR gRecBen   AS Recid.
DEF NEW SHARED VAR gRecIns     AS Recid.
DEF VAR n_InsNo         AS INT.
DEF TEMP-TABLE TTariff 
    FIELD idno  AS CHAR FORMAT "x(5)"
    FIELD name1 AS CHAR FORMAT "x(50)"
    FIELD name2 AS CHAR FORMAT "x(30)"
    INDEX ttariff01  idno . 
DEF VAR Name2 AS CHAR FORMAT "x(40)" .
DEF VAR rPol        AS ROWID.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME frComp
&Scoped-define BROWSE-NAME brInsure

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES Insure MsgCode

/* Definitions for BROWSE brInsure                                      */
&Scoped-define FIELDS-IN-QUERY-brInsure Insure.CompNo Insure.InsNo ~
Insure.FName Insure.LName 
&Scoped-define ENABLED-FIELDS-IN-QUERY-brInsure 
&Scoped-define QUERY-STRING-brInsure FOR EACH Insure NO-LOCK ~
    BY Insure.InsNo
&Scoped-define OPEN-QUERY-brInsure OPEN QUERY brInsure FOR EACH Insure NO-LOCK ~
    BY Insure.InsNo.
&Scoped-define TABLES-IN-QUERY-brInsure Insure
&Scoped-define FIRST-TABLE-IN-QUERY-brInsure Insure


/* Definitions for BROWSE brtitle                                       */
&Scoped-define FIELDS-IN-QUERY-brtitle MsgCode.CompNo MsgCode.MsgNo ~
MsgCode.MsgDesc MsgCode.Branch 
&Scoped-define ENABLED-FIELDS-IN-QUERY-brtitle 
&Scoped-define QUERY-STRING-brtitle FOR EACH MsgCode NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-brtitle OPEN QUERY brtitle FOR EACH MsgCode NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-brtitle MsgCode
&Scoped-define FIRST-TABLE-IN-QUERY-brtitle MsgCode


/* Definitions for FRAME frinsure                                       */

/* Definitions for FRAME fr_title                                       */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS RECT-458 RECT-467 RECT-471 RECT-476 ~
btn_Import btn_exit ra_typset 
&Scoped-Define DISPLAYED-OBJECTS ra_typset fiCompNo fiName 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR WUWCODEL AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON btn_exit 
     LABEL "EXIT" 
     SIZE 12 BY 1.52
     FONT 6.

DEFINE BUTTON btn_Import 
     LABEL "IMPORT" 
     SIZE 12 BY 1.52
     FONT 2.

DEFINE VARIABLE fiCompNo AS CHARACTER FORMAT "X(10)":U 
      VIEW-AS TEXT 
     SIZE 14 BY .62
     FGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiName AS CHARACTER FORMAT "X(60)":U 
      VIEW-AS TEXT 
     SIZE 24.5 BY .62
     FGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE ra_typset AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          " TITLE ", 1,
" PROVINCE", 2
     SIZE 28.33 BY 1.43
     FGCOLOR 15 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-458
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 111 BY 3.81.

DEFINE RECTANGLE RECT-467
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 15.17 BY 2.38
     BGCOLOR 6 .

DEFINE RECTANGLE RECT-471
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 15.17 BY 2.38
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-476
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 34.5 BY 2.38.

DEFINE BUTTON btninadd_pro 
     LABEL "เพิ่ม" 
     SIZE 10 BY 1.24
     FONT 6.

DEFINE BUTTON btnInCancel_pro 
     LABEL "Cancel" 
     SIZE 10 BY 1.24
     FONT 6.

DEFINE BUTTON btnInDelete_pro 
     LABEL "ลบ" 
     SIZE 10 BY 1.24
     FONT 6.

DEFINE BUTTON btnInOK_pro 
     LABEL "OK" 
     SIZE 10 BY 1.24
     FONT 6.

DEFINE BUTTON btnInUpdate_pro 
     LABEL "แก้ไข" 
     SIZE 10 BY 1.24
     FONT 6.

DEFINE BUTTON btnNextPro 
     LABEL ">" 
     SIZE 4 BY 1
     FONT 2.

DEFINE BUTTON btnPrevPro 
     LABEL "<" 
     SIZE 4 BY 1
     FONT 2.

DEFINE VARIABLE fiInComp AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 10 BY 1
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fiName1 AS CHARACTER FORMAT "X(60)":U 
     VIEW-AS FILL-IN 
     SIZE 43 BY 1
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fiName2 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 43 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_search AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 20.17 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-465
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 53.67 BY 2.29
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-473
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 31.67 BY 2.29.

DEFINE RECTANGLE RECT-477
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 61.5 BY 10.

DEFINE BUTTON btninadd 
     LABEL "เพิ่ม" 
     SIZE 9 BY 1.24
     FONT 6.

DEFINE BUTTON btnInCancel 
     LABEL "Cancel" 
     SIZE 10 BY 1.24
     FONT 6.

DEFINE BUTTON btnInDelete 
     LABEL "ลบ" 
     SIZE 10 BY 1.24
     FONT 6.

DEFINE BUTTON btnInOK 
     LABEL "OK" 
     SIZE 10 BY 1.24
     FONT 6.

DEFINE BUTTON btnInUpdate 
     LABEL "แก้ไข" 
     SIZE 10 BY 1.24
     FONT 6.

DEFINE BUTTON btnNextTi 
     LABEL ">" 
     SIZE 4 BY 1
     FONT 6.

DEFINE BUTTON btnPrevTi 
     LABEL "<" 
     SIZE 4 BY 1
     FONT 2.

DEFINE VARIABLE fi_no AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 10 BY 1
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_SearchTi AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 19 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_tinam1 AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 41 BY 1
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_tinam2 AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 41 BY 1
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-20
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 53 BY 2.05
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-474
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 31 BY 2.38.

DEFINE RECTANGLE RECT-475
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 59.33 BY 10.1.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY brInsure FOR 
      Insure SCROLLING.

DEFINE QUERY brtitle FOR 
      MsgCode SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE brInsure
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS brInsure WUWCODEL _STRUCTURED
  QUERY brInsure NO-LOCK DISPLAY
      Insure.CompNo FORMAT "X(3)":U
      Insure.InsNo FORMAT "X(7)":U
      Insure.FName FORMAT "X(50)":U WIDTH 13.83
      Insure.LName FORMAT "X(50)":U WIDTH 22.17
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 48.67 BY 10
         BGCOLOR 15  ROW-HEIGHT-CHARS .57.

DEFINE BROWSE brtitle
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS brtitle WUWCODEL _STRUCTURED
  QUERY brtitle NO-LOCK DISPLAY
      MsgCode.CompNo FORMAT "X(10)":U WIDTH 11.33
      MsgCode.MsgNo COLUMN-LABEL "No." FORMAT "X(6)":U WIDTH 9
      MsgCode.MsgDesc COLUMN-LABEL "Title_name1" FORMAT "X(30)":U
            WIDTH 13.33
      MsgCode.Branch COLUMN-LABEL "Title_name2" FORMAT "X(20)":U
            WIDTH 11.67
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 51.5 BY 10.1
         BGCOLOR 15  ROW-HEIGHT-CHARS .57.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME frmain
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 114.83 BY 15.33
         BGCOLOR 18 .

DEFINE FRAME fr_title
     brtitle AT ROW 1.38 COL 62
     btnPrevTi AT ROW 3.86 COL 48.17
     fi_SearchTi AT ROW 3.81 COL 26.83 COLON-ALIGNED NO-LABEL
     fi_no AT ROW 4.38 COL 13.17 COLON-ALIGNED NO-LABEL
     fi_tinam1 AT ROW 5.86 COL 13.17 COLON-ALIGNED NO-LABEL
     btninadd AT ROW 8.76 COL 5.67
     fi_tinam2 AT ROW 7.05 COL 13.17 COLON-ALIGNED NO-LABEL
     btnInUpdate AT ROW 8.76 COL 14.67
     btnInDelete AT ROW 8.76 COL 24.67
     btnInOK AT ROW 8.76 COL 34.67
     btnInCancel AT ROW 8.76 COL 44.67
     btnNextTi AT ROW 3.86 COL 52.33
     " TITLE NAME" VIEW-AS TEXT
          SIZE 14.17 BY .95 AT ROW 1 COL 4.67
          FGCOLOR 7 FONT 6
     " Name :" VIEW-AS TEXT
          SIZE 10 BY 1 AT ROW 5.86 COL 4.67
          FGCOLOR 7 FONT 6
     "  ค้นหาคำนำหน้าชื่อ" VIEW-AS TEXT
          SIZE 17.5 BY .95 AT ROW 2.52 COL 28
          BGCOLOR 1 FGCOLOR 7 FONT 6
     " Name2 :" VIEW-AS TEXT
          SIZE 10 BY 1 AT ROW 7.19 COL 4.5
          FGCOLOR 7 FONT 6
     " No." VIEW-AS TEXT
          SIZE 10 BY 1 AT ROW 4.38 COL 4.67
          FGCOLOR 7 FONT 6
     RECT-20 AT ROW 8.33 COL 3.67
     RECT-474 AT ROW 2.95 COL 27
     RECT-475 AT ROW 1.38 COL 2.17
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 5.29
         SIZE 114.5 BY 10.95
         BGCOLOR 3 .

DEFINE FRAME frComp
     btn_Import AT ROW 2.48 COL 81.67
     btn_exit AT ROW 2.48 COL 96.33
     ra_typset AT ROW 2.52 COL 49.5 NO-LABEL
     fiCompNo AT ROW 2.29 COL 14.5 COLON-ALIGNED NO-LABEL
     fiName AT ROW 3.52 COL 14.5 COLON-ALIGNED NO-LABEL
     " TYPE" VIEW-AS TEXT
          SIZE 6.5 BY 1.19 AT ROW 1.52 COL 41.67
          FGCOLOR 7 FONT 6
     " รหัสบริษัท:" VIEW-AS TEXT
          SIZE 12.5 BY 1 AT ROW 2 COL 3.5
          FGCOLOR 7 FONT 6
     " ชื่อบริษัท :" VIEW-AS TEXT
          SIZE 9.5 BY 1 AT ROW 3.29 COL 3.5
          FGCOLOR 7 FONT 6
     RECT-458 AT ROW 1.24 COL 2
     RECT-467 AT ROW 2 COL 94.67
     RECT-471 AT ROW 2 COL 80
     RECT-476 AT ROW 2 COL 45
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 114.5 BY 4.29
         BGCOLOR 3 .

DEFINE FRAME frinsure
     brInsure AT ROW 1.48 COL 64.5
     fi_search AT ROW 3.24 COL 27.5 COLON-ALIGNED NO-LABEL
     btnPrevPro AT ROW 3.24 COL 50
     btnNextPro AT ROW 3.24 COL 54.17
     fiInComp AT ROW 3.57 COL 14.33 COLON-ALIGNED NO-LABEL
     fiName1 AT ROW 5.05 COL 14.33 COLON-ALIGNED NO-LABEL
     fiName2 AT ROW 6.57 COL 14.33 COLON-ALIGNED NO-LABEL
     btninadd_pro AT ROW 9.1 COL 7.33
     btnInUpdate_pro AT ROW 9.1 COL 17.5
     btnInDelete_pro AT ROW 9.1 COL 27.67
     btnInOK_pro AT ROW 9.1 COL 37.83
     btnInCancel_pro AT ROW 9.1 COL 48
     "Name1 :" VIEW-AS TEXT
          SIZE 10 BY 1 AT ROW 5.05 COL 5.83
          FGCOLOR 7 FONT 6
     "Name 2 :" VIEW-AS TEXT
          SIZE 10 BY 1 AT ROW 6.57 COL 5.83
          FGCOLOR 7 FONT 6
     "No." VIEW-AS TEXT
          SIZE 10 BY 1 AT ROW 3.57 COL 5.83
          FGCOLOR 7 FONT 6
     " PROVINCE" VIEW-AS TEXT
          SIZE 11.17 BY 1 AT ROW 1.05 COL 3.83
          FGCOLOR 7 FONT 6
     "  ค้นหาชื่อจังหวัด" VIEW-AS TEXT
          SIZE 15.5 BY .95 AT ROW 2 COL 28.83
          BGCOLOR 1 FGCOLOR 7 FONT 6
     RECT-465 AT ROW 8.57 COL 5.67
     RECT-473 AT ROW 2.38 COL 27.83
     RECT-477 AT ROW 1.48 COL 2
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 5.29
         SIZE 114.5 BY 10.95
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
  CREATE WINDOW WUWCODEL ASSIGN
         HIDDEN             = YES
         TITLE              = "Set Title Code and Provin Code"
         HEIGHT             = 15.14
         WIDTH              = 114.33
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
         MESSAGE-AREA       = no
         SENSITIVE          = yes.
ELSE {&WINDOW-NAME} = CURRENT-WINDOW.
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW WUWCODEL
  VISIBLE,,RUN-PERSISTENT                                               */
/* REPARENT FRAME */
ASSIGN FRAME frComp:FRAME = FRAME frmain:HANDLE
       FRAME frinsure:FRAME = FRAME frmain:HANDLE
       FRAME fr_title:FRAME = FRAME frmain:HANDLE.

/* SETTINGS FOR FRAME frComp
                                                                        */
/* SETTINGS FOR FILL-IN fiCompNo IN FRAME frComp
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fiName IN FRAME frComp
   NO-ENABLE                                                            */
/* SETTINGS FOR FRAME frinsure
                                                                        */
/* BROWSE-TAB brInsure RECT-477 frinsure */
/* SETTINGS FOR FILL-IN fiInComp IN FRAME frinsure
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fiName1 IN FRAME frinsure
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fiName2 IN FRAME frinsure
   NO-ENABLE                                                            */
/* SETTINGS FOR FRAME frmain
   Custom                                                               */

DEFINE VARIABLE XXTABVALXX AS LOGICAL NO-UNDO.

ASSIGN XXTABVALXX = FRAME frComp:MOVE-BEFORE-TAB-ITEM (FRAME fr_title:HANDLE)
       XXTABVALXX = FRAME frinsure:MOVE-BEFORE-TAB-ITEM (FRAME frComp:HANDLE)
/* END-ASSIGN-TABS */.

/* SETTINGS FOR FRAME fr_title
   Custom                                                               */
/* BROWSE-TAB brtitle 1 fr_title */
/* SETTINGS FOR FILL-IN fi_no IN FRAME fr_title
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_tinam1 IN FRAME fr_title
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_tinam2 IN FRAME fr_title
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(WUWCODEL)
THEN WUWCODEL:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE brInsure
/* Query rebuild information for BROWSE brInsure
     _TblList          = "brstat.Insure"
     _Options          = "NO-LOCK"
     _OrdList          = "sic_bran.Insure.InsNo|yes"
     _FldNameList[1]   > brstat.Insure.CompNo
"Insure.CompNo" ? "X(3)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[2]   = brstat.Insure.InsNo
     _FldNameList[3]   > brstat.Insure.FName
"Insure.FName" ? ? "character" ? ? ? ? ? ? no ? no no "13.83" yes no no "U" "" ""
     _FldNameList[4]   > brstat.Insure.LName
"Insure.LName" ? ? "character" ? ? ? ? ? ? no ? no no "22.17" yes no no "U" "" ""
     _Query            is NOT OPENED
*/  /* BROWSE brInsure */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE brtitle
/* Query rebuild information for BROWSE brtitle
     _TblList          = "brstat.MsgCode"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _FldNameList[1]   > brstat.MsgCode.CompNo
"CompNo" ? "X(10)" "character" ? ? ? ? ? ? no ? no no "11.33" yes no no "U" "" ""
     _FldNameList[2]   > brstat.MsgCode.MsgNo
"MsgNo" "No." ? "character" ? ? ? ? ? ? no ? no no "9" yes no no "U" "" ""
     _FldNameList[3]   > brstat.MsgCode.MsgDesc
"MsgDesc" "Title_name1" "X(30)" "character" ? ? ? ? ? ? no ? no no "13.33" yes no no "U" "" ""
     _FldNameList[4]   > brstat.MsgCode.Branch
"Branch" "Title_name2" "X(20)" "character" ? ? ? ? ? ? no ? no no "11.67" yes no no "U" "" ""
     _Query            is NOT OPENED
*/  /* BROWSE brtitle */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME WUWCODEL
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL WUWCODEL WUWCODEL
ON END-ERROR OF WUWCODEL /* Set Title Code and Provin Code */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL WUWCODEL WUWCODEL
ON WINDOW-CLOSE OF WUWCODEL /* Set Title Code and Provin Code */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME brInsure
&Scoped-define FRAME-NAME frinsure
&Scoped-define SELF-NAME brInsure
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brInsure WUWCODEL
ON MOUSE-SELECT-CLICK OF brInsure IN FRAME frinsure
DO:
    GET CURRENT brInsure.
    RUN PdDispIns IN THIS-PROCEDURE. 

    FIND CURRENT Insure NO-LOCK.
    IF NOT AVAIL Insure THEN RETURN NO-APPLY.
    IF AVAIL Insure AND Insure.CompNo = pComp THEN DO:
       pRowIns = ROWID (Insure).
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brInsure WUWCODEL
ON MOUSE-SELECT-DBLCLICK OF brInsure IN FRAME frinsure
DO:
    /*
    APPLY "MOUSE-SELECT-CLICK" TO brInsure IN FRAME frbrins.    
    APPLY "CLOSE" TO THIS-PROCEDURE.*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brInsure WUWCODEL
ON VALUE-CHANGED OF brInsure IN FRAME frinsure
DO:
  FIND CURRENT Insure NO-LOCK.
      RUN pdDispIns IN THIS-PROCEDURE. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME brtitle
&Scoped-define FRAME-NAME fr_title
&Scoped-define SELF-NAME brtitle
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brtitle WUWCODEL
ON VALUE-CHANGED OF brtitle IN FRAME fr_title
DO:
  FIND CURRENT msgcode NO-LOCK.
      RUN pdDisptitle IN THIS-PROCEDURE. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btninadd
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btninadd WUWCODEL
ON CHOOSE OF btninadd IN FRAME fr_title /* เพิ่ม */
DO: 
  DEF BUFFER bIns FOR Insure.
  DEF VAR vInsNo    AS INTE INIT 0.
  DEF VAR vInsC     AS CHAR FORMAT "X" INIT "W".
  DEF VAR vInsFirst AS CHAR.   
  DEF VAR v_InsNo   AS char.
  DEF VAR nv_Insno  AS CHAR.
  DEF VAR nv_vinsc  AS CHAR.
  DEF VAR insno     AS CHAR.
  DEF VAR insno1    AS CHAR.
  DEF VAR n_Insno   AS INT.
  gComp = fiCompno.
  RUN PDEnable IN THIS-PROCEDURE.
  DISABLE fi_SearchTi btnprevti btnnextti WITH FRAME fr_title.
  ASSIGN 
    cUpdate   = "ADD"
    fi_no      = nv_InsNo
    fi_tinam1  = ""
    /*btnFirst:Sensitive  = No
    btnPrev:Sensitive   = No
    btnNext:Sensitive   = No
    btnLast:Sensitive   = No*/
    btnPrevTi:Sensitive   = No
    btnNextTi:Sensitive   = No
    btnInAdd:Sensitive    = No
    btnInUpdate:Sensitive = No
    btnInDelete:Sensitive = No  
    btnInOK:Sensitive     = Yes
    btnInCancel:Sensitive = Yes.
  DISPLAY 
     fi_no  fi_tinam1 fi_tinam2  WITH FRAME fr_title.
  
  APPLY "ENTRY" TO fi_no IN FRAME fr_title .
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frinsure
&Scoped-define SELF-NAME btninadd_pro
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btninadd_pro WUWCODEL
ON CHOOSE OF btninadd_pro IN FRAME frinsure /* เพิ่ม */
DO: 
    DEF BUFFER bIns FOR Insure.
    DEF VAR vInsNo    AS INTE INIT 0.
    DEF VAR vInsC     AS CHAR FORMAT "X" INIT "W".
    DEF VAR vInsFirst AS CHAR.   
    DEF VAR v_InsNo   AS char.
    DEF VAR nv_Insno  AS CHAR.
    DEF VAR nv_vinsc  AS CHAR.
    DEF VAR insno     AS CHAR.
    DEF VAR insno1    AS CHAR.
    DEF VAR n_Insno   AS INT.
    gComp = fiCompno.
    RUN PDEnable IN THIS-PROCEDURE.
    DISABLE fi_search WITH FRAME frinsure.
    ASSIGN 
      cUpdate   = "ADD"
      fiincomp   = nv_InsNo
      finame1    = ""
      finame2    = ""  
      /*btnFirst_pro:Sensitive  = No
      btnPrev_pro:Sensitive   = No
      btnNext_pro:Sensitive   = No
      btnLast_pro:Sensitive   = No*/
      btnPrevpro:Sensitive      = No
      btnNextpro:Sensitive      = No
      btnInAdd_pro:Sensitive    = No
      btnInUpdate_pro:Sensitive = No
      btnInDelete_pro:Sensitive = No  
      btnInOK_pro:Sensitive     = Yes
      btnInCancel_pro:Sensitive = Yes.
    DISPLAY 
       fiincomp finame1  finame2  
    WITH FRAME frinsure.

    APPLY "ENTRY" TO fiincomp IN FRAME frinsure .
  END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fr_title
&Scoped-define SELF-NAME btnInCancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnInCancel WUWCODEL
ON CHOOSE OF btnInCancel IN FRAME fr_title /* Cancel */
DO:
   RUN ProcDisable IN THIS-PROCEDURE.
   ENABLE fi_SearchTi btnPrevTi btnnextti WITH FRAME fr_title.
   ASSIGN 
       /*btnFirst:Sensitive    IN FRAM fr_title = Yes
       btnPrev:Sensitive     IN FRAM fr_title = Yes
       btnNext:Sensitive     IN FRAM fr_title = Yes
       btnLast:Sensitive     IN FRAM fr_title = Yes*/
       btnPrevTi:Sensitive   IN FRAME fr_title = YES
       btnNextTi:Sensitive   IN FRAME fr_title = YES
       btnInAdd:Sensitive    IN FRAME fr_title = Yes
       btnInUpdate:Sensitive IN FRAME fr_title = Yes
       btnInDelete:Sensitive IN FRAME fr_title = Yes
       btnInOK:Sensitive     IN FRAME fr_title = No
       btnInCancel:Sensitive IN FRAME fr_title = No.
       brtitle:Sensitive IN FRAME fr_title = Yes.
       APPLY "VALUE-CHANGED" TO  brtitle IN FRAME fr_title.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frinsure
&Scoped-define SELF-NAME btnInCancel_pro
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnInCancel_pro WUWCODEL
ON CHOOSE OF btnInCancel_pro IN FRAME frinsure /* Cancel */
DO:
    RUN ProcDisable IN THIS-PROCEDURE.
    ENABLE fi_search WITH FRAME frinsure.
    ASSIGN 
       /*btnFirst_pro:Sensitive    IN FRAM frinsure = Yes
       btnPrev_pro:Sensitive     IN FRAM frinsure = Yes
       btnNext_pro:Sensitive     IN FRAM frinsure = Yes
       btnLast_pro:Sensitive     IN FRAM frinsure = Yes*/
       btnPrevpro:Sensitive      IN FRAME frinsure = YES
       btnNextpro:Sensitive      IN FRAME frinsure = YES
       btnInAdd_pro:Sensitive    IN FRAME frinsure = Yes
       btnInUpdate_pro:Sensitive IN FRAME frinsure = Yes
       btnInDelete_pro:Sensitive IN FRAME frinsure = Yes
       btnInOK_pro:Sensitive     IN FRAME frinsure = No
       btnInCancel_pro:Sensitive IN FRAME frinsure = No.
       brInsure:Sensitive IN FRAME frinsure = Yes.
       APPLY "VALUE-CHANGED" TO  brInsure IN FRAME frinsure.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fr_title
&Scoped-define SELF-NAME btnInDelete
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnInDelete WUWCODEL
ON CHOOSE OF btnInDelete IN FRAME fr_title /* ลบ */
DO:
    DEF VAR logAns AS LOGI INIT No.  
    logAns = No.
    /*MESSAGE "ต้องการลบข้อมูลรายการ " + TRIM (msgcode.msgno) + " " + 
        TRIM (msgcode.DESC) +  " ?"  UPDATE logAns 
        VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO*/
    MESSAGE "ต้องการลบข้อมูลรายการ " + TRIM (msgcode.msgno) + " " + TRIM (msgcode.msgDESC) + " " +  " ?"  UPDATE logAns 
        VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO
        TITLE "ลบข้อมูลชื่อนี้".   
    IF logAns THEN DO:  
        GET CURRENT brtitle EXCLUSIVE-LOCK.
        DELETE msgcode.
        MESSAGE "ลบข้อมูลดีเลอร์เรียบร้อย ..." VIEW-AS ALERT-BOX INFORMATION.  
    END.  
    RUN PdUpdateQ.
    APPLY "VALUE-CHANGED" TO brtitle IN FRAM fr_title.  
    RUN ProcDisable IN THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frinsure
&Scoped-define SELF-NAME btnInDelete_pro
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnInDelete_pro WUWCODEL
ON CHOOSE OF btnInDelete_pro IN FRAME frinsure /* ลบ */
DO:
    DEF VAR logAns AS LOGI INIT No.  
    logAns = No.
    MESSAGE "ต้องการลบข้อมูลรายการ " + TRIM (Insure.Insno) + " " + 
        TRIM (Insure.Fname) + " " + TRIM (Insure.LName) + " ?"  UPDATE logAns 
        VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO
        TITLE "ลบข้อมูลชื่อนี้".   
    IF logAns THEN DO:  
        GET CURRENT brInsure EXCLUSIVE-LOCK.
        DELETE insure.
        MESSAGE "ลบข้อมูลดีเลอร์เรียบร้อย ..." VIEW-AS ALERT-BOX INFORMATION.  
    END.  
    RUN PdUpdateQ.
    APPLY "VALUE-CHANGED" TO brInsure IN FRAM frinsure.  
    RUN ProcDisable IN THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fr_title
&Scoped-define SELF-NAME btnInOK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnInOK WUWCODEL
ON CHOOSE OF btnInOK IN FRAME fr_title /* OK */
DO:
    ASSIGN
        FRAME fr_title fi_no
        FRAME fr_title fi_tinam1
        FRAME fr_title fi_tinam2.
    
    IF (fi_no = ""  OR fi_tinam1  = "" ) THEN DO:
            MESSAGE "ข้อมูลผิดพลาด  กรุณาตรวจสอบข้อมูลใหม่ "  VIEW-AS ALERT-BOX ERROR.
            APPLY "ENTRY" TO fi_tinam1 IN FRAME fr_title.
    END.
    ELSE DO:
        RUN ProcUpdateTitle IN THIS-PROCEDURE (INPUT cUpdate).
        ENABLE fi_SearchTi btnPrevTi btnnextti WITH FRAME fr_title.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frinsure
&Scoped-define SELF-NAME btnInOK_pro
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnInOK_pro WUWCODEL
ON CHOOSE OF btnInOK_pro IN FRAME frinsure /* OK */
DO:
     ASSIGN
        FRAME frInsure fiIncomp
        FRAME frInsure fiName1
        FRAME frInsure fiName2 .
    
    
    IF (fiIncomp = ""  OR fiName1  = "" ) THEN DO:
            MESSAGE "ข้อมูลผิดพลาด  กรุณาตรวจสอบข้อมูลใหม่ "  VIEW-AS ALERT-BOX ERROR.
            APPLY "ENTRY" TO fiIncomp IN FRAME frinsure.
    END.
    ELSE DO:
        RUN ProcUpdateInsure IN THIS-PROCEDURE (INPUT cUpdate).
        ENABLE fi_search btnPrevPro btnNextPro WITH FRAME frinsure.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fr_title
&Scoped-define SELF-NAME btnInUpdate
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnInUpdate WUWCODEL
ON CHOOSE OF btnInUpdate IN FRAME fr_title /* แก้ไข */
DO:
  RUN PdEnable IN THIS-PROCEDURE.
  DISABLE fi_SearchTi btnprevti btnnextti WITH FRAME fr_title.
  ASSIGN
    fi_no fi_tinam1  fi_tinam2
    cUpdate = "UPDATE"
    /*btnFirst:SENSITIVE    IN FRAME fr_title = No
    btnPrev:Sensitive     IN FRAME fr_title = No
    btnNext:Sensitive     IN FRAME fr_title = No
    btnLast:Sensitive     IN FRAME fr_title = No*/
    btnPrevTi:Sensitive   IN FRAME fr_title = No
    btnNextTi:Sensitive   IN FRAME fr_title = No
    btnInAdd:Sensitive    IN FRAME fr_title = No
    btnInUpdate:Sensitive IN FRAME fr_title = No
    btnInDelete:Sensitive IN FRAME fr_title = No  
    btnInOK:Sensitive     IN FRAME fr_title = Yes
    btnInCancel:Sensitive IN FRAME fr_title = Yes
    brtitle:Sensitive IN FRAME fr_title = No.
    RUN pddisptitle IN THIS-PROCEDURE.
  APPLY "ENTRY" TO fi_no IN FRAM fr_title.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frinsure
&Scoped-define SELF-NAME btnInUpdate_pro
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnInUpdate_pro WUWCODEL
ON CHOOSE OF btnInUpdate_pro IN FRAME frinsure /* แก้ไข */
DO: 
    RUN PdEnable IN THIS-PROCEDURE.
    DISABLE fi_search WITH FRAME frinsure.
    ASSIGN
        fiincomp  finame1  finame2   
        cUpdate = "UPDATE"
        /*btnFirst_pro:SENSITIVE    IN FRAME frinsure = No
        btnPrev_pro:Sensitive     IN FRAME frinsure = No
        btnNext_pro:Sensitive     IN FRAME frinsure = No
        btnLast_pro:Sensitive     IN FRAME frinsure = No*/
        btnPrevpro:Sensitive      IN FRAME frinsure = No
        btnNextpro:Sensitive      IN FRAME frinsure = No
        btnInAdd_pro:Sensitive    IN FRAME frinsure = No
        btnInUpdate_pro:Sensitive IN FRAME frinsure = No
        btnInDelete_pro:Sensitive IN FRAME frinsure = No  
        btnInOK_pro:Sensitive     IN FRAME frinsure = Yes
        btnInCancel_pro:Sensitive IN FRAME frinsure = Yes
        brInsure:Sensitive IN FRAME frinsure = No.
    RUN PdDispIns IN THIS-PROCEDURE.
    APPLY "ENTRY" TO fiincomp IN FRAM frinsure.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnNextPro
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnNextPro WUWCODEL
ON CHOOSE OF btnNextPro IN FRAME frinsure /* > */
DO:
  FIND NEXT Insure WHERE 
            Insure.CompNo = gcomp    AND
            Insure.FName  = TRIM(fi_search)  NO-LOCK NO-ERROR.
    IF NOT AVAIL Insure THEN RETURN NO-APPLY.
    IF AVAIL Insure THEN DO:
       rPol = ROWID (Insure).
       REPOSITION brInsure TO ROWID rPol.

       FIND CURRENT Insure NO-LOCK.
       RUN pdDispIns IN THIS-PROCEDURE.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fr_title
&Scoped-define SELF-NAME btnNextTi
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnNextTi WUWCODEL
ON CHOOSE OF btnNextTi IN FRAME fr_title /* > */
DO:
  FIND NEXT Insure WHERE 
            Insure.CompNo = gcomp    AND
            Insure.FName  = TRIM(fi_searchTi)  NO-LOCK NO-ERROR.
    IF NOT AVAIL Insure THEN RETURN NO-APPLY.
    IF AVAIL Insure THEN DO:
       rPol = ROWID (Insure).
       REPOSITION brInsure TO ROWID rPol.

       FIND CURRENT Insure NO-LOCK.
       RUN pdDispIns IN THIS-PROCEDURE.
    END.
  /*---
  GET NEXT brtitle.
  IF NOT AVAIL msgcode THEN RETURN NO-APPLY.
  REPOSITION brtitle TO ROWID ROWID  (msgcode).
  APPLY "VALUE-CHANGED" TO brtitle IN FRAME fr_title.
  ----*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frinsure
&Scoped-define SELF-NAME btnPrevPro
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnPrevPro WUWCODEL
ON CHOOSE OF btnPrevPro IN FRAME frinsure /* < */
DO:
  FIND PREV Insure WHERE 
            Insure.CompNo = gcomp    AND
            Insure.FName  = TRIM(fi_search)  NO-LOCK NO-ERROR.
    IF NOT AVAIL Insure THEN RETURN NO-APPLY.
    IF AVAIL Insure THEN DO:
       rPol = ROWID (Insure).
       REPOSITION brInsure TO ROWID rPol.

       FIND CURRENT Insure NO-LOCK.
       RUN pdDispIns IN THIS-PROCEDURE.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fr_title
&Scoped-define SELF-NAME btnPrevTi
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnPrevTi WUWCODEL
ON CHOOSE OF btnPrevTi IN FRAME fr_title /* < */
DO:
  FIND PREV MsgCode WHERE 
            MsgCode.CompNo = gcomp    AND
            MsgCode.Msgdesc  = TRIM(fi_searchTi)  NO-LOCK NO-ERROR.
    IF NOT AVAIL MsgCode THEN RETURN NO-APPLY.
    IF AVAIL MsgCode THEN DO:
       rPol = ROWID (MsgCode).
       REPOSITION brTitle TO ROWID rPol.

       FIND CURRENT MsgCode NO-LOCK.
       RUN pdDispTitle IN THIS-PROCEDURE.
    END.

  /*---
  GET PREV brtitle.
  IF NOT AVAIL msgcode THEN RETURN NO-APPLY.
  REPOSITION brtitle TO ROWID ROWID  (msgcode).
  APPLY "VALUE-CHANGED" TO brtitle IN FRAME fr_title.
  ----*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frComp
&Scoped-define SELF-NAME btn_exit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_exit WUWCODEL
ON CHOOSE OF btn_exit IN FRAME frComp /* EXIT */
DO:
  APPLY "CLOSE" TO THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_Import
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_Import WUWCODEL
ON CHOOSE OF btn_Import IN FRAME frComp /* IMPORT */
DO:
  DEF VAR FileName2 AS CHAR.
  DEF VAR i AS INTE INIT 0. 
  IF ra_typset = 1 THEN DO: 
      FIND  Company WHERE Company.CompNo = gComp NO-LOCK NO-ERROR.
      /*ASSIGN
      Name2 = Company.Text4 + "\DataPara\".   */
      MESSAGE "Input File Name :" UPDATE FileName2 FORMAT "X(35)". 
      IF SEARCH (Name2 + FileName2) = ? THEN DO:
          MESSAGE "หาไฟล์ไม่พบ" VIEW-AS ALERT-BOX ERROR.
          RETURN NO-APPLY.
      END.
      ELSE
         MESSAGE "หาไฟล์ " Name2 + FileName2 " พบ" VIEW-AS ALERT-BOX INFORMATION.
      FOR EACH TTariff . 
          DELETE TTariff. 
      END.
      INPUT FROM VALUE(Name2 + FileName2).
      REPEAT.
          CREATE TTariff.
          IMPORT DELIMITER "|"
              tTariff.idno 
              tTariff.name1.
      END.    /* Repeat */
      FOR EACH ttariff NO-LOCK.
          FIND FIRST msgcode WHERE 
              msgcode.CompNo   = "999"        AND
              msgcode.MsgNo    = tTariff.idno AND      
              msgcode.MsgDesc  = tTariff.name1   NO-ERROR NO-WAIT.
          IF NOT AVAIL msgcode  THEN DO:
              CREATE msgcode.
              ASSIGN msgcode.CompNo = "999"     
              msgcode.MsgNo         = tTariff.idno       
              msgcode.MsgDesc       = tTariff.name1  .
  
          END.
              
      END.
      FOR EACH TTariff . 
          DELETE TTariff. 
      END.
      RUN pdUpdateQ.
  END.
  IF ra_typset = 2 THEN DO:
      FIND  Company WHERE Company.CompNo = gComp NO-LOCK NO-ERROR.
      /*ASSIGN
      Name2 = Company.Text4 + "\DataPara\".   */
      MESSAGE "Input File Name :" UPDATE FileName2 FORMAT "X(30)". 
      IF SEARCH (Name2 + FileName2) = ? THEN DO:
          MESSAGE "หาไฟล์ไม่พบ" VIEW-AS ALERT-BOX ERROR.
          RETURN NO-APPLY.
      END.
      ELSE
         MESSAGE "หาไฟล์ " Name2 + FileName2 " พบ" VIEW-AS ALERT-BOX INFORMATION.
      FOR EACH TTariff . 
          DELETE TTariff. 
      END.
      INPUT FROM VALUE(Name2 + FileName2).
      REPEAT.
          CREATE TTariff.
          IMPORT DELIMITER "|"
              tTariff.idno 
              tTariff.name1
              tTariff.name2.
      END.    /* Repeat */
      FOR EACH ttariff NO-LOCK.
          FIND FIRST insure USE-INDEX Insure03 WHERE 
              insure.compno = "999"        AND
              Insure.InsNo  = tTariff.idno        AND
              Insure.FName  = tTariff.name1       AND
              Insure.LName  = tTariff.name2       NO-ERROR NO-WAIT.
          IF NOT AVAIL insure  THEN DO:      
              CREATE insure.
              ASSIGN insure.compno = "999" 
                  Insure.InsNo     = tTariff.idno     
                  Insure.FName     = tTariff.name1    
                  Insure.LName     = tTariff.name2.
          END.
              
      END.
      FOR EACH TTariff . 
          DELETE TTariff. 
      END.
      RUN pdUpdateQ.
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frinsure
&Scoped-define SELF-NAME fiInComp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiInComp WUWCODEL
ON LEAVE OF fiInComp IN FRAME frinsure
DO:
   fiInComp  = INPUT fiInComp.
   DISP fiincomp WITH FRAM frinsure.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frComp
&Scoped-define SELF-NAME fiName
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiName WUWCODEL
ON LEAVE OF fiName IN FRAME frComp
DO:
/*      fiName = INPUT fiCompNo.*/

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frinsure
&Scoped-define SELF-NAME fiName1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiName1 WUWCODEL
ON LEAVE OF fiName1 IN FRAME frinsure
DO:
   fiName1  = INPUT fiName1.
   DISP finame1 WITH FRAM frinsure.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiName2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiName2 WUWCODEL
ON LEAVE OF fiName2 IN FRAME frinsure
DO:
  fiName2  = INPUT fiName2.
  DISP finame2 WITH FRAM frinsure.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fr_title
&Scoped-define SELF-NAME fi_no
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_no WUWCODEL
ON LEAVE OF fi_no IN FRAME fr_title
DO:
   fi_no = INPUT fi_no.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frinsure
&Scoped-define SELF-NAME fi_search
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_search WUWCODEL
ON RETURN OF fi_search IN FRAME frinsure
DO:

  fi_Search = CAPS (INPUT fi_Search).
  DISP fi_search WITH FRAME frinsure.
  ASSIGN 
      fi_Search.
          
  IF fi_Search = ""  THEN RETURN NO-APPLY. 

  FIND FIRST Insure WHERE  Insure.CompNo = gcomp    AND
                           Insure.FName  = TRIM(fi_Search)  NO-LOCK NO-ERROR.
  IF NOT AVAIL Insure THEN DO:
     Message "ไม่พบ Province ที่ต้องการค้นหา  " SKIP
             "Province  = "  fi_Search   view-as alert-box ERROR .
     APPLY "ENTRY" TO fi_Search.
     RETURN NO-APPLY.
  END. 
  ELSE DO:
    rPol = ROWID (Insure).
    REPOSITION brInsure TO ROWID rPol.

   FIND CURRENT Insure NO-LOCK.
   RUN pdDispIns IN THIS-PROCEDURE.
         
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fr_title
&Scoped-define SELF-NAME fi_SearchTi
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_SearchTi WUWCODEL
ON RETURN OF fi_SearchTi IN FRAME fr_title
DO:
  fi_SearchTi = CAPS (INPUT fi_SearchTi).
  DISP fi_searchTi WITH FRAME fr_Title.
  ASSIGN 
      fi_SearchTi.
          
  IF fi_SearchTi = ""  THEN RETURN NO-APPLY. 

  FIND FIRST MsgCode WHERE MsgCode.CompNo = gcomp    AND
                           MsgCode.MsgDesc  = TRIM(fi_SearchTi)  NO-LOCK NO-ERROR.
  IF NOT AVAIL MsgCode THEN DO:
     Message "ไม่พบคำนำหน้าชื่อ ที่ต้องการค้นหา  " SKIP
             "คำนำหน้าชื่อ  = "  fi_SearchTi   view-as alert-box ERROR .
     APPLY "ENTRY" TO fi_SearchTi.
     RETURN NO-APPLY.
  END. 
  ELSE DO:
    rPol = ROWID (MsgCode).
    REPOSITION brtitle TO ROWID rPol.

   FIND CURRENT MsgCode NO-LOCK.
   RUN pdDispTitle IN THIS-PROCEDURE.
         
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_tinam1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_tinam1 WUWCODEL
ON LEAVE OF fi_tinam1 IN FRAME fr_title
DO:
   fi_tinam1  = INPUT fi_tinam1.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_tinam2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_tinam2 WUWCODEL
ON LEAVE OF fi_tinam2 IN FRAME fr_title
DO:
   fi_tinam1  = INPUT fi_tinam1.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frComp
&Scoped-define SELF-NAME ra_typset
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_typset WUWCODEL
ON VALUE-CHANGED OF ra_typset IN FRAME frComp
DO:
  ra_typset = INPUT ra_typset.
  IF ra_typset = 1 THEN DO:
       VIEW FRAME fr_title.
       HIDE FRAME frinsure.
       RUN pdUpdateQ.
  END.
  ELSE DO:
       HIDE FRAME fr_title.
       VIEW FRAME frinsure.
       RUN pdUpdateQ.
  END.
  IF ra_typset = 1 THEN RUN pddisptitle.
                   ELSE RUN pdDispIns.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME brInsure
&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK WUWCODEL 


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
    RUN WUT\WUTDICEN (WUWCODEL:HANDLE).
    SESSION:DATA-ENTRY-RETURN = Yes.
    ASSIGN ra_typset = 1.
    /*fiUser = "".*/
    /*fiUser = n_user.*/
    /*fiFdate = ?.*/
    /*fiFdate = TODAY.*/
    FIND FIRST Company WHERE Company.compno = "999" NO-ERROR NO-WAIT.
    IF AVAIL company THEN DO:
        RUN pdDispComp.
        gComp = Company.Compno.
    END.
    ELSE DO:
        DISP "" @ fiCompNo
             "" @ fiName  
            WITH FRAME frComp.
        CREATE company .
        ASSIGN  Company.Compno  = "999"
                Company.NAME    = "SAFETY INSURANCE" 
            fiCompNo  = "999"               
            fiName   = "SAFETY INSURANCE"  .
        RUN pdDispComp.
        gComp = Company.Compno.
    END.
    /*FIND FIRST Company WHERE Company.compno = "999" NO-ERROR NO-WAIT.
    IF AVAIL company THEN DO:
        RUN pdDispComp.
        gComp = Company.Compno.
    END.*/
    IF ra_typset = 1 THEN DO:
        IF CAN-FIND (FIRST msgcode WHERE msgcode.compno = gComp )  THEN DO:
            RUN PdUpdateQ IN THIS-PROCEDURE.
            APPLY "VALUE-CHANGED" TO brtitle.
        END.

    END.
    ELSE DO:
        IF CAN-FIND (FIRST Insure WHERE Insure.compno = gComp )  THEN DO:
            RUN PdUpdateQ IN THIS-PROCEDURE.
            APPLY "VALUE-CHANGED" TO brInsure.
        END.
    END.

    IF ra_typset = 1 THEN DO:
       VIEW FRAME fr_title.
       HIDE FRAME frinsure.
    END.
    IF NOT THIS-PROCEDURE:PERSISTENT THEN
        WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI WUWCODEL  _DEFAULT-DISABLE
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
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(WUWCODEL)
  THEN DELETE WIDGET WUWCODEL.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI WUWCODEL  _DEFAULT-ENABLE
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
  DISPLAY ra_typset fiCompNo fiName 
      WITH FRAME frComp IN WINDOW WUWCODEL.
  ENABLE RECT-458 RECT-467 RECT-471 RECT-476 btn_Import btn_exit ra_typset 
      WITH FRAME frComp IN WINDOW WUWCODEL.
  {&OPEN-BROWSERS-IN-QUERY-frComp}
  VIEW FRAME frmain IN WINDOW WUWCODEL.
  {&OPEN-BROWSERS-IN-QUERY-frmain}
  DISPLAY fi_search fiInComp fiName1 fiName2 
      WITH FRAME frinsure IN WINDOW WUWCODEL.
  ENABLE RECT-465 RECT-473 RECT-477 brInsure fi_search btnPrevPro btnNextPro 
         btninadd_pro btnInUpdate_pro btnInDelete_pro btnInOK_pro 
         btnInCancel_pro 
      WITH FRAME frinsure IN WINDOW WUWCODEL.
  {&OPEN-BROWSERS-IN-QUERY-frinsure}
  DISPLAY fi_SearchTi fi_no fi_tinam1 fi_tinam2 
      WITH FRAME fr_title IN WINDOW WUWCODEL.
  ENABLE brtitle btnPrevTi fi_SearchTi btninadd btnInUpdate btnInDelete btnInOK 
         btnInCancel btnNextTi RECT-20 RECT-474 RECT-475 
      WITH FRAME fr_title IN WINDOW WUWCODEL.
  {&OPEN-BROWSERS-IN-QUERY-fr_title}
  VIEW WUWCODEL.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdAddCom WUWCODEL 
PROCEDURE pdAddCom :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ENABLE ALL WITH FRAME frComp.
DISABLE ALL WITH FRAME frInsure.
DISABLE ALL WITH FRAME frbrins.
APPLY "ENTRY" TO fiCompNo IN FRAME frComp.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDDisableComp WUWCODEL 
PROCEDURE PDDisableComp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
 /* DISABLE 
    fiCompNo fibranch fiAbName  fiName fiName2 fiAddr1 fiAddr2 fiAddr3 fiAddr4 fiTelNo 
    WITH FRAME frComp.
  /* kridtiya in .................
  DISABLE ALL WITH FRAME frinsure.*/
  /*DISABLE brinsure  WITH  FRAME frbrins.*/
  DISABLE    btnCompOK   btnCompReset   WITH FRAME frcomp.
/*  DISABLE   btnCompdet WITH FRAME frCompdet.*/*/
  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDDispComp WUWCODEL 
PROCEDURE PDDispComp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN
    fiCompNo = Company.Compno
    fiName   = Company.NAME.
DISP fiCompNo
     fiName  
     ra_typset WITH FRAME frComp.

 /*FIND FIRST insure USE-INDEX insure01 WHERE insure.compno = ficompno NO-WAIT NO-ERROR.
 IF AVAIL insure  THEN DO:
     ASSIGN
         fiincomp   = insure.insno
         fiInBranch = insure.Branch
         fifNAme    = insure.FName
         fiLName    = insure.LNAME
         fiInAddr1  = insure.Addr1
         fiInAddr2  = insure.Addr2
         fiInAddr3  = insure.Addr3
         fiInAddr4  = insure.Addr4
         fiInTelno  = insure.Telno  .
     DISP fiincomp  
         fiInBranch
         fifNAme   
         fiLName   
         fiInAddr1 
         fiInAddr2 
         fiInAddr3 
         fiInAddr4 
         fiInTelno  
         WITH FRAME frinsure.
 END.*/
  gComp = company.compno.
  RUN pdUpdateQ.
 
 DISP brinsure  WITH FRAME frinsure.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdDispIns WUWCODEL 
PROCEDURE pdDispIns :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DISPLAY 
     Insure.insno     @ fiInComp     
     Insure.FName     @ fiName1
     Insure.LName     @ fiName2
   WITH FRAME frinsure.

  
   /*raSex = IF Insure.Sex = "M" THEN 1 ELSE IF Insure.Sex = "F" THEN 2 ELSE 3 .     
   DISP raSex  WITH FRAME {&FRAME-NAME}.*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pddisplogin WUWCODEL 
PROCEDURE pddisplogin :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

ASSIGN
    fiCompNo    = Company.CompNo
    fiName      = Company.Name
   /*fiName2     = Company.Name2
    fiAddr1     = Company.Addr1
    fiAddr2     = Company.Addr2
    fiAddr3     = Company.Addr3
    fiAddr4     = Company.Addr4
    fiTelNo     = Company.TelNo
    fiuser      = Company.PowerName*/  .
DISP fiCompNo fiName  WITH FRAME frComp.
FIND FIRST insure USE-INDEX insure01 WHERE
    insure.compno = ficompno NO-WAIT NO-ERROR.
IF AVAIL insure THEN DO:
    ASSIGN
        fiincomp   = insure.insNo
        fiName1    = insure.fname
        fiName2    = insure.lName
        brInsure:Sensitive  IN FRAM frinsure = Yes.   
END.
DISP   fiincomp 
       fiName1 
       fiName2 
          WITH FRAME frinsure.
DISP brInsure WITH FRAME frinsure.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pddisptitle WUWCODEL 
PROCEDURE pddisptitle :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DISPLAY  msgcode.MsgNo   @ fi_no   
         msgcode.MsgDesc @ fi_tiNam1   
         msgcode.branch  @ fi_tiNam2      
           
   WITH FRAME fr_title.
  
   /*raSex = IF Insure.Sex = "M" THEN 1 ELSE IF Insure.Sex = "F" THEN 2 ELSE 3 .     
   DISP raSex  WITH FRAME {&FRAME-NAME}.*/


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdEnable WUWCODEL 
PROCEDURE pdEnable :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*ENABLE 
    fiInComp fiInBranch  fivatcode   fiFName 
    fiLName   fiInAddr1 fiInAddr2   fiInAddr3   fiInAddr4  
    fiInTelNo   btnInOK     btnInCancel 
    WITH FRAME frinsure.*/
IF ra_typset = 2 THEN
    ENABLE 
    fiInComp fiName1  fiName2 
    WITH FRAME frinsure.
ELSE 
    ENABLE 
    fi_no  fi_tinam1 fi_tinam2 
    WITH FRAME fr_title.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdenablecomp WUWCODEL 
PROCEDURE pdenablecomp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ENABLE 
    fiCompNo fiName 
    WITH FRAME frComp.
    ENABLE ALL WITH  FRAME fiinsure.
    /*ENABLE   btnInOK_pro btnInCancel_pro  brinsure   WITH FRAME fiinsure.*/
    
  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDInitData WUWCODEL 
PROCEDURE PDInitData :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN 
    FRAME frComp fiCompNo fiCompNo = ""
    FRAME frComp fiName   fiName   = ""
    
   /* btnCompAdd:Sensitive   IN FRAME frcomp = Yes
    btnCompUpd:Sensitive   IN FRAME frcomp = Yes
    btnCompDel:Sensitive   IN FRAME frcomp = Yes

    btnCompOK:Sensitive    IN FRAME frcomp = No
    btnCompReset:Sensitive IN FRAME frcomp = No    
        
    btnCompFirst:Sensitive IN FRAME frcomp = Yes
    btnCompPrev:Sensitive  IN FRAME frcomp = Yes
    btnCompNext:Sensitive  IN FRAME frcomp = Yes
    btnCompLast:Sensitive  IN FRAME frcomp = Yes*/
    
    cUpdate = "".
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdUpdateQ WUWCODEL 
PROCEDURE pdUpdateQ :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
IF ra_typset = 2 THEN DO:
    OPEN QUERY brInsure  FOR EACH Insure USE-INDEX Insure01 NO-LOCK
        WHERE CompNo = gComp
        BY Insure.InsNo .
END.
ELSE DO:
    OPEN QUERY brtitle  FOR EACH msgcode USE-INDEX msgcode01 NO-LOCK
                WHERE msgcode.CompNo = gComp
                        BY msgcode.MsgNo  .

END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE ProcDisable WUWCODEL 
PROCEDURE ProcDisable :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
IF ra_typset = 2 THEN  
    DISABLE 
        fiincomp fiName1 fiName2  WITH FRAME frinsure. 
ELSE 
    DISABLE 
        fi_no fi_tiNam1 fi_tinam2 WITH FRAME fr_title.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE ProcUpdateInsure WUWCODEL 
PROCEDURE ProcUpdateInsure :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF INPUT PARAMETER cmode AS CHAR.
DEF BUFFER bIns FOR Insure.
DEF VAR logAns    AS LOGI INIT No.  
DEF VAR rIns      AS ROWID.
DEF VAR vInsNo    AS INTE INIT 0.
DEF VAR vInsC     AS CHAR FORMAT "X" INIT "W".
DEF VAR vInsFirst AS CHAR.  
  /* vComp  = fiInbranch.*/  
pComp = fiCompno.
FIND FIRST Company WHERE Company.CompNo =  pComp  .
DO:  vInsFirst = Company.InsNoPrf. END.          
ASSIGN
    rIns   = ROWID (Insure)
    logAns = No.
IF cmode = "ADD" THEN DO:
    MESSAGE "เพิ่มข้อมูลรายการดีเลอร์ " UPDATE logAns 
        VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO
        TITLE "เพิ่มข้อมูลรายการดีเลอร์".
    IF logAns THEN DO:
           FIND LAST bIns   USE-INDEX Insure01 WHERE bIns.CompNo = pComp NO-LOCK NO-ERROR.
           CREATE Insure.
    END.
END.   /* ADD */
ELSE IF cmode = "UPDATE" THEN DO WITH FRAME frbrins /*{&FRAME-NAME}*/:
    GET CURRENT brInsure EXCLUSIVE-LOCK.
END.
ASSIGN 
    /*fiTitle */
    FRAME frcomp    ficompno
    FRAME frInsure  fiIncomp
    FRAME frInsure  fiName1  
    FRAME frInsure  fiName2 
    
    insure.compno = ficompno
    Insure.InsNo  = fiInComp
    Insure.FName  = fiName1
    Insure.LName  = fiName2

    /*Insure.Sex    = IF raSex = 1 THEN "M" ELSE IF raSex = 2 THEN "F" ELSE "O"
    Company.Text8 = IF LENGTH(Insure.InsNo) = 10 THEN  SUBSTRING(Insure.InsNo,7,4)
    ELSE SUBSTRING(Insure.InsNo,4,4)

    Insure.BirthDate   = fiBirthDate           
    Insure.PostCode    = fiPostCode 
    Insure.InsTitle    = fiTitle*/        
    /*btnFirst_pro:Sensitive IN FRAM frinsure = Yes
    btnPrev_pro:Sensitive  IN FRAM frinsure = Yes
    btnNext_pro:Sensitive  IN FRAM frinsure = Yes
    btnLast_pro:Sensitive  IN FRAM frinsure = Yes*/

    btnInAdd_pro:Sensitive    IN FRAM frinsure = Yes
    btnInUpdate_pro:Sensitive IN FRAM frinsure = Yes
    btnInDelete_pro:Sensitive IN FRAM frinsure = Yes

    btnInOK_pro:Sensitive     IN FRAM frinsure = No
    btnInCancel_pro:Sensitive IN FRAM frinsure = NO
    brInsure:Sensitive  IN FRAM frinsure = Yes.   
        
    RUN PDUpdateQ.
    APPLY "VALUE-CHANGED" TO brInsure IN FRAME frinsure.
    RUN ProcDisable IN THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE ProcUpdateTitle WUWCODEL 
PROCEDURE ProcUpdateTitle :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF INPUT PARAMETER cmode AS CHAR.
DEF BUFFER bIns FOR msgcode.
DEF VAR logAns    AS LOGI INIT No.  
DEF VAR rIns      AS ROWID.
DEF VAR vInsNo    AS INTE INIT 0.
DEF VAR vInsC     AS CHAR FORMAT "X" INIT "W".
DEF VAR vInsFirst AS CHAR.  /* multi  company*/
  /* vComp  = fiInbranch.*/  pComp = fiCompno.
  FIND FIRST Company WHERE Company.CompNo =  pComp  .
  DO:  vInsFirst = Company.InsNoPrf. END.          
  ASSIGN
    rIns   = ROWID (Insure)
    logAns = No.
    IF cmode = "ADD" THEN DO:
       MESSAGE "เพิ่มข้อมูลรายการดีเลอร์ " UPDATE logAns 
       VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO
       TITLE "เพิ่มข้อมูลรายการดีเลอร์".
       IF logAns THEN DO:
           FIND LAST bIns   USE-INDEX MsgCode01 WHERE msgcode.CompNo = pComp NO-LOCK NO-ERROR.
           CREATE msgcode.
       END.
    END. /* ADD */
    ELSE IF cmode = "UPDATE" THEN DO WITH FRAME fr_title   /*{&FRAME-NAME}*/:
         GET CURRENT brtitle EXCLUSIVE-LOCK.
    END. 
    ASSIGN 
        /*fiTitle */
        FRAME frcomp    ficompno
        FRAME fr_title  fi_no 
        FRAME fr_title  fi_tinam1
        FRAME fr_title  fi_tinam2
        
        msgcode.CompNo      = ficompno      
        msgcode.MsgNo       = fi_no         
        msgcode.MsgDesc     = fi_tinam1 
        msgcode.branch      = fi_tinam2


              
        /*btnFirst:Sensitive IN FRAM fr_title = Yes
        btnPrev:Sensitive  IN FRAM fr_title = Yes
        btnNext:Sensitive  IN FRAM fr_title = Yes
        btnLast:Sensitive  IN FRAM fr_title = Yes*/
          
        btnInAdd:Sensitive    IN FRAM fr_title = Yes
        btnInUpdate:Sensitive IN FRAM fr_title = Yes
        btnInDelete:Sensitive IN FRAM fr_title = Yes
          
        btnInOK:Sensitive     IN FRAM fr_title = No
        btnInCancel:Sensitive IN FRAM fr_title = NO
        brtitle:Sensitive  IN FRAM fr_title = Yes.   
        
    RUN PDUpdateQ.
    APPLY "VALUE-CHANGED" TO brtitle IN FRAME fr_title.
    RUN ProcDisable IN THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

