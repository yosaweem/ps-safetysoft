&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          brstat           PROGRESS
*/
&Scoped-define WINDOW-NAME WUWSETCOM
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS WUWSETCOM 
/*------------------------------------------------------------------------

  File: 

  Description: Create Data company code (brstat.company) and branch code (brstat.insure)

  Input Parameters:
      <none>

  Output Parameters:
      <none>

  program id :  wgwsetcom.w
  Duplicate : wgwhpcom.w
  Created: Ranu I. A62-0219 date.08/05/2019  

------------------------------------------------------------------------*/
/*          This .W file was created with the Progress AppBuilder.      */
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
/*DEF SHARED VAR gComp   AS CHAR.*/
DEF VAR gComp   AS CHAR.
DEF NEW SHARED VAR gRecMod   AS Recid.
DEF NEW SHARED VAR gRecBen   AS Recid.
DEF NEW SHARED VAR gRecIns     AS Recid.
DEF VAR n_InsNo         AS INT.
DEF VAR n_name  AS CHAR .
DEF VAR n_text  AS CHAR.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME frbrIns
&Scoped-define BROWSE-NAME brInsure

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES Insure

/* Definitions for BROWSE brInsure                                      */
&Scoped-define FIELDS-IN-QUERY-brInsure Insure.CompNo Insure.Branch ~
Insure.LName Insure.FName 
&Scoped-define ENABLED-FIELDS-IN-QUERY-brInsure 
&Scoped-define QUERY-STRING-brInsure FOR EACH Insure NO-LOCK ~
    BY Insure.LName INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-brInsure OPEN QUERY brInsure FOR EACH Insure NO-LOCK ~
    BY Insure.LName INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-brInsure Insure
&Scoped-define FIRST-TABLE-IN-QUERY-brInsure Insure


/* Definitions for FRAME frbrIns                                        */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS brInsure 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR WUWSETCOM AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON btncompadd 
     LABEL "เพิ่ม" 
     SIZE 8 BY 1
     FONT 6.

DEFINE BUTTON btncompdel 
     LABEL "ลบ" 
     SIZE 8 BY 1
     FONT 6.

DEFINE BUTTON btncompfirst 
     IMAGE-UP FILE "adeicon\pvfirst":U
     IMAGE-DOWN FILE "adeicon\pvfirstd":U
     IMAGE-INSENSITIVE FILE "adeicon\pvfirstx":U
     LABEL "<<" 
     SIZE 5.5 BY 1.

DEFINE BUTTON btncomplast 
     IMAGE-UP FILE "adeicon\pvlast":U
     IMAGE-DOWN FILE "adeicon\pvlastd":U
     IMAGE-INSENSITIVE FILE "adeicon\pvlastx":U
     LABEL ">>" 
     SIZE 5.5 BY 1.

DEFINE BUTTON btncompnext 
     IMAGE-UP FILE "adeicon\pvforw":U
     IMAGE-DOWN FILE "adeicon\pvforwd":U
     IMAGE-INSENSITIVE FILE "adeicon\pvforwx":U
     LABEL ">" 
     SIZE 6 BY 1.

DEFINE BUTTON btncompok 
     LABEL "OK" 
     SIZE 8 BY 1
     FONT 6.

DEFINE BUTTON btncompprev 
     IMAGE-UP FILE "adeicon\pvback":U
     IMAGE-DOWN FILE "adeicon\pvbackd":U
     IMAGE-INSENSITIVE FILE "adeicon\pvbackx":U
     LABEL "<" 
     SIZE 5.5 BY 1.

DEFINE BUTTON btncompreset 
     LABEL "Cancel" 
     SIZE 8 BY 1
     FONT 6.

DEFINE BUTTON btncompupd 
     LABEL "แก้ไข" 
     SIZE 8 BY 1
     FONT 6.

DEFINE BUTTON bu_sch 
     LABEL "sch" 
     SIZE 5.5 BY .95.

DEFINE VARIABLE fiabname AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 11.67 BY .91
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiAddr1 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 40 BY .91
     BGCOLOR 15 FONT 1 NO-UNDO.

DEFINE VARIABLE fiAddr2 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 40 BY .91
     BGCOLOR 15 FONT 1 NO-UNDO.

DEFINE VARIABLE fiAddr3 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 40 BY .91
     BGCOLOR 15 FONT 1 NO-UNDO.

DEFINE VARIABLE fiAddr4 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 16.17 BY .91
     BGCOLOR 15 FONT 1 NO-UNDO.

DEFINE VARIABLE fibranch AS CHARACTER FORMAT "X(3)":U 
     VIEW-AS FILL-IN 
     SIZE 5 BY .91
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiCompNo AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 18 BY .91
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiName AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 40 BY .91
     BGCOLOR 15 FONT 1 NO-UNDO.

DEFINE VARIABLE fiName2 AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 40 BY .91
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fiTelNo AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .91
     BGCOLOR 15 FONT 1 NO-UNDO.

DEFINE VARIABLE fi_agentcompa AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .91
     BGCOLOR 15 FONT 1 NO-UNDO.

DEFINE VARIABLE fi_producerbike AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .91
     BGCOLOR 15 FONT 1 NO-UNDO.

DEFINE VARIABLE fi_producernewcomp AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .91
     BGCOLOR 15 FONT 1 NO-UNDO.

DEFINE VARIABLE fi_producerrenew AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .91
     BGCOLOR 15 FONT 1 NO-UNDO.

DEFINE VARIABLE fi_producerusecomp AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .91
     BGCOLOR 15 FONT 1 NO-UNDO.

DEFINE VARIABLE fi_schech AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 10.67 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-17
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 30 BY 1.62
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-455
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 58.5 BY 14.76.

DEFINE RECTANGLE RECT-488
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 25 BY 1.52
     BGCOLOR 2 FGCOLOR 0 .

DEFINE RECTANGLE RECT-82
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 26 BY 1.62
     BGCOLOR 5 .

DEFINE BUTTON btnFirst 
     IMAGE-UP FILE "adeicon\pvfirst":U
     IMAGE-DOWN FILE "adeicon\pvfirstd":U
     IMAGE-INSENSITIVE FILE "adeicon\pvfirstx":U
     LABEL "<<" 
     SIZE 5.5 BY 1.

DEFINE BUTTON btninadd 
     LABEL "เพิ่ม" 
     SIZE 6 BY .95
     FONT 6.

DEFINE BUTTON btnInCancel 
     LABEL "Cancel" 
     SIZE 7 BY .95
     FONT 6.

DEFINE BUTTON btnInDelete 
     LABEL "ลบ" 
     SIZE 6 BY .95
     FONT 6.

DEFINE BUTTON btnInOK 
     LABEL "OK" 
     SIZE 6 BY .95
     FONT 6.

DEFINE BUTTON btnInUpdate 
     LABEL "แก้ไข" 
     SIZE 6 BY .95
     FONT 6.

DEFINE BUTTON btnLast 
     IMAGE-UP FILE "adeicon\pvlast":U
     IMAGE-DOWN FILE "adeicon\pvlastd":U
     IMAGE-INSENSITIVE FILE "adeicon\pvlastx":U
     LABEL ">>" 
     SIZE 5.5 BY 1.

DEFINE BUTTON btnNext 
     IMAGE-UP FILE "adeicon\pvforw":U
     IMAGE-DOWN FILE "adeicon\pvforwd":U
     IMAGE-INSENSITIVE FILE "adeicon\pvforwx":U
     LABEL ">" 
     SIZE 6 BY 1.

DEFINE BUTTON btnPrev 
     IMAGE-UP FILE "adeicon\pvback":U
     IMAGE-DOWN FILE "adeicon\pvbackd":U
     IMAGE-INSENSITIVE FILE "adeicon\pvbackx":U
     LABEL "<" 
     SIZE 5.5 BY 1.

DEFINE BUTTON BU_schins 
     LABEL "sch" 
     SIZE 5.5 BY 1.

DEFINE VARIABLE fiInBranch AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 30 BY 1
     BGCOLOR 15 FGCOLOR 1 FONT 2 NO-UNDO.

DEFINE VARIABLE fiInComp AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fiInsch AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 17 BY .95
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fiIn_br AS CHARACTER FORMAT "X(5)":U 
     VIEW-AS FILL-IN 
     SIZE 5.83 BY 1
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-20
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 24.5 BY 1.52
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-21
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 25.5 BY 1.62
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-454
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 58 BY 5.81.

DEFINE RECTANGLE RECT-83
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 19 BY 1.52
     BGCOLOR 1 .

DEFINE BUTTON btnReturn 
     LABEL "EXIT" 
     SIZE 8.5 BY 1
     FONT 6.

DEFINE RECTANGLE RECT-84
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 13.17 BY 2
     BGCOLOR 4 .

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY brInsure FOR 
      Insure SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE brInsure
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS brInsure WUWSETCOM _STRUCTURED
  QUERY brInsure NO-LOCK DISPLAY
      Insure.CompNo FORMAT "X(10)":U WIDTH 10.83
      Insure.Branch COLUMN-LABEL "Br name." FORMAT "X(30)":U WIDTH 14.33
      Insure.LName COLUMN-LABEL "Code" FORMAT "X(20)":U WIDTH 5.83
      Insure.FName COLUMN-LABEL "BR_STY" FORMAT "X(10)":U WIDTH 7.83
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 46.5 BY 19.86
         BGCOLOR 15  ROW-HEIGHT-CHARS .62.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME frmain
     btnReturn AT ROW 21.95 COL 77.67
     RECT-84 AT ROW 21.33 COL 75.17
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 107.67 BY 23.19
         BGCOLOR 20 .

DEFINE FRAME frComp
     fi_schech AT ROW 1.38 COL 10.83 COLON-ALIGNED NO-LABEL
     bu_sch AT ROW 1.43 COL 24.67
     btncomplast AT ROW 1.43 COL 51.5
     btncompfirst AT ROW 1.48 COL 33.67
     btncompprev AT ROW 1.48 COL 39.33
     btncompnext AT ROW 1.48 COL 45
     fiCompNo AT ROW 2.43 COL 10.83 COLON-ALIGNED NO-LABEL
     fiabname AT ROW 3.43 COL 10.83 COLON-ALIGNED NO-LABEL
     fibranch AT ROW 3.43 COL 30.17 COLON-ALIGNED NO-LABEL
     fiName AT ROW 4.43 COL 10.83 COLON-ALIGNED NO-LABEL
     fiName2 AT ROW 5.43 COL 10.83 COLON-ALIGNED NO-LABEL
     fiAddr1 AT ROW 6.48 COL 10.83 COLON-ALIGNED NO-LABEL
     fiAddr2 AT ROW 7.48 COL 10.83 COLON-ALIGNED NO-LABEL
     fiAddr3 AT ROW 8.48 COL 10.83 COLON-ALIGNED NO-LABEL
     fiAddr4 AT ROW 9.48 COL 10.83 COLON-ALIGNED NO-LABEL
     fiTelNo AT ROW 9.48 COL 35.83 COLON-ALIGNED NO-LABEL
     fi_producernewcomp AT ROW 10.57 COL 21.17 COLON-ALIGNED NO-LABEL
     fi_producerusecomp AT ROW 11.57 COL 21.17 COLON-ALIGNED NO-LABEL
     fi_producerrenew AT ROW 12.57 COL 21.17 COLON-ALIGNED NO-LABEL
     fi_producerbike AT ROW 13.57 COL 21.17 COLON-ALIGNED NO-LABEL
     fi_agentcompa AT ROW 14.57 COL 21.17 COLON-ALIGNED NO-LABEL
     btncompadd AT ROW 16.33 COL 3.67
     btncompupd AT ROW 16.33 COL 12.83
     btncompdel AT ROW 16.33 COL 22.17
     btncompok AT ROW 16.33 COL 37
     btncompreset AT ROW 16.33 COL 47.17
     "    ค้นหา" VIEW-AS TEXT
          SIZE 10 BY .95 AT ROW 1.38 COL 2.67
          BGCOLOR 18 FGCOLOR 6 FONT 6
     "โทรศัพท์" VIEW-AS TEXT
          SIZE 8 BY .91 AT ROW 9.48 COL 29.33
          FGCOLOR 15 
     "Producer  New Car :" VIEW-AS TEXT
          SIZE 20 BY .91 AT ROW 10.57 COL 2.67
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Branch" VIEW-AS TEXT
          SIZE 7 BY .91 AT ROW 3.43 COL 24.83
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Producer  Use Car :" VIEW-AS TEXT
          SIZE 20 BY .91 AT ROW 11.57 COL 2.67
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Producer     ต่ออายุ :" VIEW-AS TEXT
          SIZE 20 BY .91 AT ROW 12.57 COL 2.67
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "ชื่อบริษัท" VIEW-AS TEXT
          SIZE 10 BY .91 AT ROW 4.43 COL 2.67
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "ชื่อ 2" VIEW-AS TEXT
          SIZE 10 BY .91 AT ROW 5.43 COL 2.67
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Producer      BIKE :" VIEW-AS TEXT
          SIZE 20 BY .91 AT ROW 13.57 COL 2.67
          BGCOLOR 2 FGCOLOR 7 FONT 6
     "รหัสบริษัท" VIEW-AS TEXT
          SIZE 10 BY .91 AT ROW 2.43 COL 2.67
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "         Agent Code :" VIEW-AS TEXT
          SIZE 20 BY .91 AT ROW 14.57 COL 2.67
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "ที่อยู่" VIEW-AS TEXT
          SIZE 10 BY .91 AT ROW 6.48 COL 2.67
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "อักษรหลังปี" VIEW-AS TEXT
          SIZE 10 BY .91 AT ROW 3.43 COL 2.67
          BGCOLOR 8 FGCOLOR 1 FONT 6
     RECT-17 AT ROW 16.05 COL 2
     RECT-82 AT ROW 16.05 COL 32.83
     RECT-455 AT ROW 1 COL 1
     RECT-488 AT ROW 1.24 COL 32.67
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 59 BY 17
         BGCOLOR 3 .

DEFINE FRAME frInsure
     fiInBranch AT ROW 3 COL 7.5 COLON-ALIGNED NO-LABEL
     fiInComp AT ROW 4.05 COL 7.5 COLON-ALIGNED NO-LABEL
     fiIn_br AT ROW 4.1 COL 31.67 COLON-ALIGNED NO-LABEL
     fiInsch AT ROW 1.57 COL 7.67 COLON-ALIGNED NO-LABEL
     btnFirst AT ROW 1.57 COL 34.5
     btnPrev AT ROW 1.57 COL 40.17
     btnNext AT ROW 1.57 COL 45.83
     btnLast AT ROW 1.57 COL 52.17
     btninadd AT ROW 5.48 COL 4
     btnInUpdate AT ROW 5.48 COL 11.5
     btnInDelete AT ROW 5.48 COL 18.83
     btnInOK AT ROW 5.48 COL 31.5
     btnInCancel AT ROW 5.52 COL 39.5
     BU_schins AT ROW 1.57 COL 27
     "ชื่อสาขา:" VIEW-AS TEXT
          SIZE 7 BY 1 AT ROW 3 COL 2.33
          BGCOLOR 3 FGCOLOR 15 FONT 6
     "   รหัส :" VIEW-AS TEXT
          SIZE 7 BY 1 AT ROW 4.05 COL 2.33
          BGCOLOR 3 FGCOLOR 15 FONT 6
     "สาขาSTY :" VIEW-AS TEXT
          SIZE 8.5 BY 1 AT ROW 4.1 COL 24.83
          BGCOLOR 3 FGCOLOR 15 FONT 6
     "ค้นหา :" VIEW-AS TEXT
          SIZE 7 BY 1 AT ROW 1.57 COL 2.5
          BGCOLOR 3 FGCOLOR 6 FONT 6
     RECT-20 AT ROW 5.19 COL 2
     RECT-83 AT ROW 5.19 COL 29.5
     RECT-454 AT ROW 1.1 COL 1.5
     RECT-21 AT ROW 1.29 COL 33.17
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 18
         SIZE 59 BY 6.1
         BGCOLOR 29 .

DEFINE FRAME frbrIns
     brInsure AT ROW 1.14 COL 1.5
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 60 ROW 1
         SIZE 48 BY 20.24
         BGCOLOR 5 .


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
  CREATE WINDOW WUWSETCOM ASSIGN
         HIDDEN             = YES
         TITLE              = "Setup company code"
         HEIGHT             = 23.19
         WIDTH              = 107.67
         MAX-HEIGHT         = 33.71
         MAX-WIDTH          = 170.67
         VIRTUAL-HEIGHT     = 33.71
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
/* SETTINGS FOR WINDOW WUWSETCOM
  VISIBLE,,RUN-PERSISTENT                                               */
/* REPARENT FRAME */
ASSIGN FRAME frbrIns:FRAME = FRAME frmain:HANDLE
       FRAME frComp:FRAME = FRAME frmain:HANDLE
       FRAME frInsure:FRAME = FRAME frmain:HANDLE.

/* SETTINGS FOR FRAME frbrIns
   FRAME-NAME                                                           */
/* BROWSE-TAB brInsure 1 frbrIns */
ASSIGN 
       Insure.LName:AUTO-RESIZE IN BROWSE brInsure = TRUE.

/* SETTINGS FOR FRAME frComp
                                                                        */
/* SETTINGS FOR FILL-IN fiabname IN FRAME frComp
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fiAddr1 IN FRAME frComp
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fiAddr2 IN FRAME frComp
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fiAddr3 IN FRAME frComp
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fiAddr4 IN FRAME frComp
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fibranch IN FRAME frComp
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fiCompNo IN FRAME frComp
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fiName IN FRAME frComp
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fiTelNo IN FRAME frComp
   NO-ENABLE                                                            */
/* SETTINGS FOR FRAME frInsure
   Custom                                                               */
/* SETTINGS FOR FILL-IN fiInComp IN FRAME frInsure
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fiIn_br IN FRAME frInsure
   NO-ENABLE                                                            */
/* SETTINGS FOR FRAME frmain
   Custom                                                               */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(WUWSETCOM)
THEN WUWSETCOM:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE brInsure
/* Query rebuild information for BROWSE brInsure
     _TblList          = "brstat.Insure"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _OrdList          = "brstat.Insure.LName|yes"
     _FldNameList[1]   > brstat.Insure.CompNo
"Insure.CompNo" ? "X(10)" "character" ? ? ? ? ? ? no ? no no "10.83" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[2]   > brstat.Insure.Branch
"Insure.Branch" "Br name." "X(30)" "character" ? ? ? ? ? ? no ? no no "14.33" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   > brstat.Insure.LName
"Insure.LName" "Code" "X(20)" "character" ? ? ? ? ? ? no ? no no "5.83" yes yes no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   > brstat.Insure.FName
"Insure.FName" "BR_STY" "X(10)" "character" ? ? ? ? ? ? no ? no no "7.83" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _Query            is NOT OPENED
*/  /* BROWSE brInsure */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME WUWSETCOM
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL WUWSETCOM WUWSETCOM
ON END-ERROR OF WUWSETCOM /* Setup company code */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL WUWSETCOM WUWSETCOM
ON WINDOW-CLOSE OF WUWSETCOM /* Setup company code */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME brInsure
&Scoped-define SELF-NAME brInsure
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brInsure WUWSETCOM
ON MOUSE-SELECT-CLICK OF brInsure IN FRAME frbrIns
DO:
    GET CURRENT brInsure.
    RUN PdDispIns IN THIS-PROCEDURE. 
    FIND CURRENT Insure NO-LOCK.
    IF NOT AVAIL Insure THEN RETURN NO-APPLY.
    IF AVAIL Insure AND Insure.CompNo = gComp THEN DO:
        pRowIns = ROWID (Insure).
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brInsure WUWSETCOM
ON MOUSE-SELECT-DBLCLICK OF brInsure IN FRAME frbrIns
DO:
    APPLY "MOUSE-SELECT-CLICK" TO brInsure IN FRAME frbrins.    
    APPLY "CLOSE" TO THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brInsure WUWSETCOM
ON VALUE-CHANGED OF brInsure IN FRAME frbrIns
DO:
    FIND CURRENT Insure NO-LOCK.
    ASSIGN
        n_name  = gcomp 
        n_text  = "save".
    RUN pdDispIns IN THIS-PROCEDURE. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frComp
&Scoped-define SELF-NAME btncompadd
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btncompadd WUWSETCOM
ON CHOOSE OF btncompadd IN FRAME frComp /* เพิ่ม */
DO:  
    APPLY "CHOOSE" TO btnCompReset IN FRAME frcomp.
    RUN PDInitData IN THIS-PROCEDURE.
    RUN PDEnableComp IN THIS-PROCEDURE.
    ASSIGN
        cUpdate = "Add"
        btnCompAdd:Sensitive   IN FRAME frcomp = No
        btnCompUpd:Sensitive   IN FRAME frcomp = No
        btnCompDel:Sensitive   IN FRAME frcomp = No
        btnCompOK:SENSITIVE    IN FRAME frcomp = Yes
        btnCompReset:SENSITIVE IN FRAME frcomp = Yes
        btnCompFirst:SENSITIVE IN FRAME frcomp = No
        btnCompPrev:SENSITIVE  IN FRAME frcomp = No
        btnCompNext:SENSITIVE  IN FRAME frcomp = No
        btnCompLast:SENSITIVE  IN FRAME frcomp = No.
    DISP 
        fiCompNo fiAbName fiName fiName2 fibranch
        fiAddr1 fiAddr2 fiAddr3 fiAddr4  fiTelNo  
        WITH FRAME frComp.
    APPLY "ENTRY" TO fiCompNo IN FRAME frComp.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btncompdel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btncompdel WUWSETCOM
ON CHOOSE OF btncompdel IN FRAME frComp /* ลบ */
DO:
    DEF VAR logAns    AS LOGI INIT No.  
    DEF BUFFER bComp  FOR Company.
    DEF VAR rComp     AS ROWID.
    ASSIGN
        logAns = No
        rComp  = ROWID (Company)
        btnCompAdd:Sensitive   = Yes
        btnCompUpd:Sensitive   = Yes
        btnCompDel:Sensitive   = Yes.
    MESSAGE "Are you want to delete " + STRING (Company.CompNo) + "-" + Company.Name + " ?" 
        UPDATE logAns 
        VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO
        TITLE " Confirm Deletion ".   
    IF logAns THEN DO:  
        FIND bComp WHERE ROWID (bComp) = rComp EXCLUSIVE-LOCK.
        FOR EACH CompDet WHERE CompDet.CompNo = bComp.CompNo EXCLUSIVE-LOCK:
            DELETE CompDet.
        END.
        DELETE Company.
        MESSAGE "Deleted Comple ..."  VIEW-AS ALERT-BOX INFORMATION.  
        FIND NEXT Company NO-LOCK NO-ERROR.
        IF NOT AVAIL Company THEN FIND LAST Company NO-LOCK.
        RUN PDDispComp IN THIS-PROCEDURE.
    END.
    RUN PDDisableComp IN THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btncompfirst
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btncompfirst WUWSETCOM
ON CHOOSE OF btncompfirst IN FRAME frComp /* << */
DO:
   
    FIND FIRST Company WHERE 
        Company.NAME    = "phone" AND                
        Company.compno  <> " "    NO-LOCK NO-ERROR. 
    IF NOT AVAIL Company THEN RETURN NO-APPLY.
    RUN PDDispLogin IN THIS-PROCEDURE.
    ASSIGN 
        gComp           = company.compno .
       
    RUN pdUpdateQ.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btncomplast
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btncomplast WUWSETCOM
ON CHOOSE OF btncomplast IN FRAME frComp /* >> */
DO:
  FIND LAST Company WHERE 
      Company.NAME    = "phone" AND               
      Company.compno <> "" NO-LOCK NO-ERROR.
  IF NOT AVAIL Company THEN RETURN NO-APPLY.
  RUN PDDispLogin IN THIS-PROCEDURE.
  ASSIGN 
        gComp           = company.compno .
       
  RUN pdUpdateQ.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btncompnext
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btncompnext WUWSETCOM
ON CHOOSE OF btncompnext IN FRAME frComp /* > */
DO:
    FIND bComp WHERE ROWID (bComp) = ROWID (Company) NO-LOCK NO-ERROR.
    FIND NEXT bComp WHERE 
        bcomp.NAME    = "phone" AND               
        bComp.compno <> ""   NO-LOCK NO-ERROR. 
    IF NOT AVAIL bComp THEN RETURN NO-APPLY.
    FIND NEXT Company WHERE  
        Company.NAME    = "phone" AND                
        Company.compno <> "" NO-LOCK NO-ERROR. 

    RUN PDDispLogin IN THIS-PROCEDURE.
    ASSIGN 
        gComp           = company.compno.
       
    RUN pdUpdateQ.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btncompok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btncompok WUWSETCOM
ON CHOOSE OF btncompok IN FRAME frComp /* OK */
DO:
    IF cUpdate = "" THEN RETURN NO-APPLY.
    DEF VAR rComp  AS ROWID.
    DEF VAR logAns AS LOGI INIT No.  
    ASSIGN 
        FRAME frComp fiCompNo
        FRAME frComp fiAbName 
        FRAME frComp fiName .
    IF fiCompNo = "" OR fiAbName = "" OR fiName = ""  THEN DO:
        MESSAGE "ข้อมูลผิดพลาด กรุณาตรวจสอบข้อมูล"           VIEW-AS ALERT-BOX ERROR.      
        RETURN NO-APPLY.  
    END.
    DO WITH FRAME frComp : 
        ASSIGN
            logAns = No.
        IF cUpdate = "ADD" THEN DO:
            MESSAGE "ต้องการเพิ่มข้อมูลรายการนี้ ?" 
                UPDATE logAns 
                VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO
                TITLE "ยืนยันการเพิ่มข้อมูล".   
            IF logAns THEN DO:
                CREATE Company.
            END.
        END.    /* ADD */
        ELSE IF cUpdate = "UPDATE" THEN DO:
                FIND CURRENT Company EXCLUSIVE-LOCK.
        END.     /* UPDATE */
        ASSIGN 
            FRAME frComp fiCompNo 
            FRAME frComp fiAbName 
            FRAME frComp fibranch
            FRAME frComp fiName
            FRAME frComp fiName2
            FRAME frComp fiAddr1 
            FRAME frComp fiAddr2 
            FRAME frComp fiAddr3 
            FRAME frComp fiAddr4
            FRAME frComp fiTelNo 
            FRAME frComp fi_producernewcomp 
            FRAME frComp fi_producerusecomp 
            FRAME frComp fi_producerrenew   
            FRAME frComp fi_producerbike     /*A57-0063*/
            FRAME frComp fi_agentcompa  
            Company.CompNo   = caps(fiCompNo)
            Company.AbName   = caps(fiAbName)
            Company.Branch   = caps(fibranch)
            Company.Name     = fiName
            Company.Name2    = fiName2
            Company.Addr1     = fiAddr1
            Company.Addr2     = fiAddr2 
            Company.Addr3     = fiAddr3
            Company.Addr4     = fiAddr4
            Company.TelNo     = fiTelNo
            company.Text1     = fi_producernewcomp 
            company.Text2     = fi_producerusecomp 
            company.Text3     = fi_producerrenew   
            company.Text5     = fi_producerbike     /*A57-0063*/
            company.Text4     = fi_agentcompa   
            
            btnCompAdd:Sensitive   IN FRAME frcomp = Yes
            btnCompUpd:Sensitive   IN FRAME frcomp = Yes
            btnCompDel:Sensitive   IN FRAME frcomp = Yes
            btnCompFirst:Sensitive IN FRAME frcomp = Yes
            btnCompPrev:Sensitive  IN FRAME frcomp = Yes
            btnCompNext:Sensitive  IN FRAME frcomp = Yes
            btnCompLast:Sensitive  IN FRAME frcomp = Yes
            btnCompOK:Sensitive    IN FRAME frcomp = No
            btnCompReset:Sensitive IN FRAME frcomp = No.
        cUpdate = "". 
        RUN PDDispComp  IN THIS-PROCEDURE.
        RUN PDDisableComp IN THIS-PROCEDURE.
           /*RUN PDEnable IN THIS-PROCEDURE.*/
           /* APPLY "CHOOSE" TO btnInAdd IN FRAME frInsure.*/
    END.   /* DO WITH FRAME */
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btncompprev
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btncompprev WUWSETCOM
ON CHOOSE OF btncompprev IN FRAME frComp /* < */
DO:
    FIND bComp WHERE ROWID (bComp) = ROWID (Company) NO-LOCK NO-ERROR.
   
    FIND PREV bComp WHERE 
        bcomp.NAME    = "phone" AND                /*kridtiya i. A55-0073*/
        bcomp.compno <> ""   NO-LOCK NO-ERROR.    
    IF NOT AVAIL bComp THEN RETURN NO-APPLY.
    FIND PREV Company WHERE 
        Company.NAME    = "phone" AND              /*kridtiya i. A55-0073*/
        Company.compno <> ""   NO-LOCK NO-ERROR.
    RUN PDDispLogin IN THIS-PROCEDURE.
    ASSIGN 
        gComp           = company.compno .
       
    RUN pdUpdateQ.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btncompreset
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btncompreset WUWSETCOM
ON CHOOSE OF btncompreset IN FRAME frComp /* Cancel */
DO:
    IF cUpdate = "" THEN RETURN NO-APPLY.
    RUN PDDisableComp IN THIS-PROCEDURE.
    RUN PDInitData IN THIS-PROCEDURE.
    FIND CURRENT Company NO-LOCK.
    RUN PDDispComp IN THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btncompupd
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btncompupd WUWSETCOM
ON CHOOSE OF btncompupd IN FRAME frComp /* แก้ไข */
DO:
    RUN PDEnableComp IN THIS-PROCEDURE.
    ASSIGN 
        cUpdate = "UPDATE"
        btnCompAdd:Sensitive   IN FRAME frcomp = No
        btnCompUpd:Sensitive   IN FRAME frcomp = No
        btnCompDel:Sensitive   IN FRAME frcomp = No
        
        btnCompOK:SENSITIVE    IN FRAME frcomp = Yes
        btnCompReset:SENSITIVE IN FRAME frcomp = Yes
        btnCompFirst:SENSITIVE IN FRAME frcomp = No
        btnCompPrev:SENSITIVE  IN FRAME frcomp = No
        btnCompNext:SENSITIVE  IN FRAME frcomp = No
        btnCompLast:SENSITIVE  IN FRAME frcomp = No.
    APPLY "ENTRY" TO fiCompNo IN FRAME frComp.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frInsure
&Scoped-define SELF-NAME btnFirst
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnFirst WUWSETCOM
ON CHOOSE OF btnFirst IN FRAME frInsure /* << */
DO:
  GET FIRST brInsure.
  IF NOT AVAIL Insure THEN RETURN NO-APPLY.  
  REPOSITION brInsure TO ROWID ROWID (Insure).
  APPLY "VALUE-CHANGED" TO brInsure IN FRAME frbrIns.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btninadd
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btninadd WUWSETCOM
ON CHOOSE OF btninadd IN FRAME frInsure /* เพิ่ม */
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
    ASSIGN 
        cUpdate    = "ADD"
        fiInbranch = ""
        fiIncomp   = nv_InsNo
        fiIn_br    = ""
       
        btnFirst:Sensitive  = No
        btnPrev:Sensitive   = No
        btnNext:Sensitive   = No
        btnLast:Sensitive   = No
        btnInAdd:Sensitive    = No
        btnInUpdate:Sensitive = No
        btnInDelete:Sensitive = No  
        btnInOK:Sensitive     = Yes
        btnInCancel:Sensitive = Yes.
    DISPLAY 
        fiIn_br fiInComp  fiInbranch      
        WITH FRAME frInsure.
    
    APPLY "ENTRY" TO fiInbranch IN FRAME frInsure .
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnInCancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnInCancel WUWSETCOM
ON CHOOSE OF btnInCancel IN FRAME frInsure /* Cancel */
DO:
  RUN ProcDisable IN THIS-PROCEDURE.
  ASSIGN 
    btnFirst:Sensitive IN FRAM frinsure = Yes
    btnPrev:Sensitive  IN FRAM frinsure = Yes
    btnNext:Sensitive  IN FRAM frinsure = Yes
    btnLast:Sensitive  IN FRAM frinsure = Yes
     
    btnInAdd:Sensitive    IN FRAM frinsure = Yes
    btnInUpdate:Sensitive IN FRAM frinsure = Yes
    btnInDelete:Sensitive IN FRAM frinsure = Yes
         
    btnInOK:Sensitive     IN FRAM frinsure = No
    btnInCancel:Sensitive IN FRAM frinsure = No.
    brInsure:Sensitive IN FRAM frbrins = Yes.
    
  APPLY "VALUE-CHANGED" TO brInsure IN FRAME frbrins.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnInDelete
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnInDelete WUWSETCOM
ON CHOOSE OF btnInDelete IN FRAME frInsure /* ลบ */
DO:
    DEF VAR logAns AS LOGI INIT No.  
    logAns = No.
    MESSAGE "ต้องการลบข้อมูลรายการ " + TRIM (Insure.Insno) 
        UPDATE logAns 
        VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO
        TITLE "ลบข้อมูลชื่อดีเลอร์นี้".   
    IF logAns THEN DO:  
        GET CURRENT brInsure EXCLUSIVE-LOCK.
        DELETE Insure.
        MESSAGE "ลบข้อมูลดีเลอร์เรียบร้อย ..." VIEW-AS ALERT-BOX INFORMATION.  
        RUN PdUpdateQ.
        APPLY "VALUE-CHANGED" TO brInsure IN FRAM frbrins.  
        RUN ProcDisable IN THIS-PROCEDURE.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnInOK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnInOK WUWSETCOM
ON CHOOSE OF btnInOK IN FRAME frInsure /* OK */
DO:
    ASSIGN
        FRAME frInsure fiInBranch
        FRAME frInsure fiIncomp
        FRAME frInsure fiIn_br.
    
    IF (fiInBranch = ""  OR fiIncomp  = "" ) THEN DO:
            MESSAGE "ข้อมูลผิดพลาด  กรุณาตรวจสอบข้อมูลใหม่ "  VIEW-AS ALERT-BOX ERROR.
            APPLY "ENTRY" TO fiIncomp IN FRAME frinsure.
    END.
    ELSE DO:
        RUN ProcUpdateInsure IN THIS-PROCEDURE (INPUT cUpdate).
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnInUpdate
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnInUpdate WUWSETCOM
ON CHOOSE OF btnInUpdate IN FRAME frInsure /* แก้ไข */
DO:
    RUN PdEnable IN THIS-PROCEDURE.
    ASSIGN
        fiInBranch fiIn_br  fiIncomp
        cUpdate = "UPDATE"
        btnFirst:SENSITIVE IN FRAME frInsure = No
        btnPrev:Sensitive  IN FRAME frInsure = No
        btnNext:Sensitive  IN FRAME frInsure = No
        btnLast:Sensitive  IN FRAME frInsure = No
        btnInAdd:Sensitive    IN FRAME frInsure = No
        btnInUpdate:Sensitive IN FRAME frInsure = No
        btnInDelete:Sensitive IN FRAME frInsure = No  
        btnInOK:Sensitive     IN FRAME frInsure = Yes
        btnInCancel:Sensitive IN FRAME frInsure = Yes
        brInsure:Sensitive IN FRAME frbrins = No.
    RUN PdDispIns IN THIS-PROCEDURE.
    APPLY "ENTRY" TO fiInbranch IN FRAM frInsure.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnLast
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnLast WUWSETCOM
ON CHOOSE OF btnLast IN FRAME frInsure /* >> */
DO:
  GET LAST brInsure.
  IF NOT AVAIL Insure THEN RETURN NO-APPLY.
  REPOSITION brInsure TO ROWID ROWID (Insure).
  APPLY "VALUE-CHANGED" TO brInsure IN FRAME frbrins.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnNext
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnNext WUWSETCOM
ON CHOOSE OF btnNext IN FRAME frInsure /* > */
DO:
  GET NEXT brInsure.
  IF NOT AVAIL Insure THEN RETURN NO-APPLY.
  REPOSITION brInsure TO ROWID ROWID (Insure).
  APPLY "VALUE-CHANGED" TO brInsure IN FRAME frbrins.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnPrev
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnPrev WUWSETCOM
ON CHOOSE OF btnPrev IN FRAME frInsure /* < */
DO:
  GET PREV brInsure.
  IF NOT AVAIL Insure THEN RETURN NO-APPLY.
  REPOSITION brInsure TO ROWID ROWID (Insure).
  APPLY "VALUE-CHANGED" TO brInsure IN FRAME frbrins.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frmain
&Scoped-define SELF-NAME btnReturn
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnReturn WUWSETCOM
ON CHOOSE OF btnReturn IN FRAME frmain /* EXIT */
DO:
   APPLY "CLOSE" TO THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frComp
&Scoped-define SELF-NAME bu_sch
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_sch WUWSETCOM
ON CHOOSE OF bu_sch IN FRAME frComp /* sch */
DO:
    IF fi_schech = "" THEN 
        DISP fi_schech WITH FRAM frComp.
    ELSE DO:
        FIND FIRST Company WHERE Company.compno = fi_schech NO-ERROR NO-WAIT.      /*A55-0046*/
        IF AVAIL company THEN DO:
            RUN pdDispComp.
            gComp = Company.Compno.
        END. 
    END.
    DISP fi_schech WITH FRAM frComp.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frInsure
&Scoped-define SELF-NAME BU_schins
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BU_schins WUWSETCOM
ON CHOOSE OF BU_schins IN FRAME frInsure /* sch */
DO:
    IF fiInsch = ""  THEN
        DISP fiInsch WITH FRAM frInsure.
    ELSE DO:
        FIND FIRST Insure WHERE Insure.compno = gComp   AND 
            Insure.Branch = fiInsch NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL Insure THEN RETURN NO-APPLY.
        REPOSITION brInsure TO ROWID ROWID (Insure).
        APPLY "VALUE-CHANGED" TO brInsure IN FRAME frbrins.
    END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frComp
&Scoped-define SELF-NAME fiabname
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiabname WUWSETCOM
ON LEAVE OF fiabname IN FRAME frComp
DO:
    fiabname = INPUT fiabname.
    DISP  CAPS(fiabname) @ fiabname WITH FRAME frComp. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiAddr1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiAddr1 WUWSETCOM
ON LEAVE OF fiAddr1 IN FRAME frComp
DO:
    fiAddr1 = INPUT fiAddr1 .
    DISP fiAddr1  WITH FRAM frComp.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiAddr2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiAddr2 WUWSETCOM
ON LEAVE OF fiAddr2 IN FRAME frComp
DO:
  fiAddr2 = INPUT fiAddr2 .
  DISP fiAddr2  WITH FRAM frComp.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiAddr3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiAddr3 WUWSETCOM
ON LEAVE OF fiAddr3 IN FRAME frComp
DO:
  fiAddr2 = INPUT fiAddr3 .
  DISP fiAddr3  WITH FRAM frComp.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiAddr4
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiAddr4 WUWSETCOM
ON LEAVE OF fiAddr4 IN FRAME frComp
DO:
  fiAddr4 = INPUT fiAddr4 .
  DISP fiAddr4  WITH FRAM frComp.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fibranch
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fibranch WUWSETCOM
ON LEAVE OF fibranch IN FRAME frComp
DO:
   /* fiabname = INPUT fiabname.
    DISP  CAPS(fiabname) @ fiabname WITH FRAME frComp.*/
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiCompNo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiCompNo WUWSETCOM
ON LEAVE OF fiCompNo IN FRAME frComp
DO:
    fiCompNo = caps(INPUT fiCompNo).
    DISP fiCompno  WITH FRAM frComp.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frInsure
&Scoped-define SELF-NAME fiInBranch
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiInBranch WUWSETCOM
ON LEAVE OF fiInBranch IN FRAME frInsure
DO:
  fiinbranch = INPUT fiinbranch.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiInComp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiInComp WUWSETCOM
ON LEAVE OF fiInComp IN FRAME frInsure
DO:
   fiInComp  = INPUT fiInComp.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiInsch
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiInsch WUWSETCOM
ON LEAVE OF fiInsch IN FRAME frInsure
DO:
   fiInsch  = INPUT fiInsch.
   DISP fiInsch WITH FRAM frinsure.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiIn_br
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiIn_br WUWSETCOM
ON LEAVE OF fiIn_br IN FRAME frInsure
DO:
   fiIn_br  = INPUT fiIn_br.
   DISP fiin_br WITH FRAM frinsur.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frComp
&Scoped-define SELF-NAME fiName
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiName WUWSETCOM
ON LEAVE OF fiName IN FRAME frComp
DO:
      ASSIGN fiName = "Phone". 
      DISP finame  WITH FRAM frComp.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiName2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiName2 WUWSETCOM
ON LEAVE OF fiName2 IN FRAME frComp
DO:
    fiName2 = INPUT finame2 . 
    DISP finame2 WITH FRAM frcomp.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiTelNo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiTelNo WUWSETCOM
ON LEAVE OF fiTelNo IN FRAME frComp
DO:
  fitelno = INPUT fitelno .
  DISP fitelno  WITH FRAM frComp.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_agentcompa
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_agentcompa WUWSETCOM
ON LEAVE OF fi_agentcompa IN FRAME frComp
DO:
  fi_agentcompa = caps(INPUT fi_agentcompa).
  DISP fi_agentcompa WITH FRAM frcomp. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_producerbike
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_producerbike WUWSETCOM
ON LEAVE OF fi_producerbike IN FRAME frComp
DO:
    fi_producerbike  = caps(INPUT fi_producerbike).
    DISP fi_producerbike WITH FRAM frcomp. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_producernewcomp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_producernewcomp WUWSETCOM
ON LEAVE OF fi_producernewcomp IN FRAME frComp
DO:
  fi_producernewcomp = caps(INPUT fi_producernewcomp) .
  DISP fi_producernewcomp WITH FRAM frcomp.   
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_producerrenew
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_producerrenew WUWSETCOM
ON LEAVE OF fi_producerrenew IN FRAME frComp
DO:
  fi_producerrenew = caps(INPUT fi_producerrenew).
  DISP fi_producerrenew WITH FRAM frcomp. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_producerusecomp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_producerusecomp WUWSETCOM
ON LEAVE OF fi_producerusecomp IN FRAME frComp
DO:
  fi_producerusecomp = caps(INPUT fi_producerusecomp) .
  DISP fi_producerusecomp WITH FRAM frcomp. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_schech
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_schech WUWSETCOM
ON LEAVE OF fi_schech IN FRAME frComp
DO:
      fi_schech = INPUT fi_schech .
      DISP fi_schech WITH FRAM frComp.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frbrIns
&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK WUWSETCOM 


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
DEF  VAR  gv_prgid   AS   CHAR.
DEF  VAR  gv_prog    AS   CHAR.
ASSIGN 
    gv_prgid = "wgwsetcom.w"
    gv_prog  = "Setup company code...".
RUN  WUT\WUTHEAD ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).

MAIN-BLOCK:
DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
   ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:
  RUN enable_UI.
  RUN WUT\WUTDICEN (WUWSETCOM:HANDLE).
  SESSION:DATA-ENTRY-RETURN = Yes.
  ASSIGN 
     
      fiInComp   = ""  
      fiIn_br    = ""
      fiInBranch = "" 
      fi_schech  = "SCB". 
  FIND FIRST Company WHERE 
      Company.NAME    = "phone" AND               
      Company.compno <>  ""     NO-ERROR NO-WAIT. 
  IF AVAIL company THEN DO:
      RUN pdDispComp.
      gComp = Company.Compno.
  END.
  ELSE DO:
      DISP "" @ fi_schech  
           "" @ fiCompNo
           "" @ fiBranch
           "" @ fiABNAme
           "" @ fiName  
           "" @ finame2 
           "" @ fiAddr1 
           "" @ fiAddr2 
           "" @ fiAddr3 
           "" @ fiAddr4 
           "" @ fiTelno 
           "" @ fi_producernewcomp
           "" @ fi_producerusecomp
           "" @ fi_producerrenew  
           "" @ fi_producerbike    
           "" @ fi_agentcompa  WITH FRAME frComp.
  END.
  IF CAN-FIND (FIRST Insure WHERE Insure.compno = gComp )  THEN DO:
      RUN PdUpdateQ IN THIS-PROCEDURE.
      APPLY "VALUE-CHANGED" TO brInsure.
  END.
  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI WUWSETCOM  _DEFAULT-DISABLE
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
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(WUWSETCOM)
  THEN DELETE WIDGET WUWSETCOM.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI WUWSETCOM  _DEFAULT-ENABLE
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
  DISPLAY fi_schech fiCompNo fiabname fibranch fiName fiName2 fiAddr1 fiAddr2 
          fiAddr3 fiAddr4 fiTelNo fi_producernewcomp fi_producerusecomp 
          fi_producerrenew fi_producerbike fi_agentcompa 
      WITH FRAME frComp IN WINDOW WUWSETCOM.
  ENABLE RECT-17 RECT-82 RECT-455 RECT-488 fi_schech bu_sch btncomplast 
         btncompfirst btncompprev btncompnext fiName2 fi_producernewcomp 
         fi_producerusecomp fi_producerrenew fi_producerbike fi_agentcompa 
         btncompadd btncompupd btncompdel btncompok btncompreset 
      WITH FRAME frComp IN WINDOW WUWSETCOM.
  {&OPEN-BROWSERS-IN-QUERY-frComp}
  ENABLE btnReturn RECT-84 
      WITH FRAME frmain IN WINDOW WUWSETCOM.
  {&OPEN-BROWSERS-IN-QUERY-frmain}
  ENABLE brInsure 
      WITH FRAME frbrIns IN WINDOW WUWSETCOM.
  {&OPEN-BROWSERS-IN-QUERY-frbrIns}
  DISPLAY fiInBranch fiInComp fiIn_br fiInsch 
      WITH FRAME frInsure IN WINDOW WUWSETCOM.
  ENABLE fiInBranch fiInsch btnFirst btnPrev btnNext btnLast btninadd 
         btnInUpdate btnInDelete btnInOK btnInCancel BU_schins RECT-20 RECT-83 
         RECT-454 RECT-21 
      WITH FRAME frInsure IN WINDOW WUWSETCOM.
  {&OPEN-BROWSERS-IN-QUERY-frInsure}
  VIEW WUWSETCOM.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdAddCom WUWSETCOM 
PROCEDURE pdAddCom :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ENABLE  ALL WITH FRAME frComp.
DISABLE ALL WITH FRAME frInsure.
DISABLE ALL WITH FRAME frbrins.
APPLY "ENTRY" TO fiCompNo IN FRAME frComp.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDDisableComp WUWSETCOM 
PROCEDURE PDDisableComp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DISABLE  fiCompNo fibranch fiAbName  fiName fiName2 fiAddr1 fiAddr2 fiAddr3 fiAddr4 fiTelNo WITH FRAME frComp.
DISABLE  btnCompOK   btnCompReset   WITH FRAME frcomp.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pddisabledompp WUWSETCOM 
PROCEDURE pddisabledompp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DISABLE 
    fiCompNo fibranch fiAbName fiName fiName2 fiAddr1 fiAddr2 fiAddr3 fiAddr4 fiTelNo 
    WITH FRAME frComp.
    ENABLE ALL WITH  FRAME fiinsure.
    DISABLE   btnCompOK btnCompReset   WITH FRAME frcomp.
    
  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDDispComp WUWSETCOM 
PROCEDURE PDDispComp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN
    fiCompNo           = Company.Compno
    fiBranch           = Company.Branch
    fiABNAme           = Company.ABName
    fiName             = Company.NAME
    finame2            = Company.Name2
    fiAddr1            = Company.Addr1
    fiAddr2            = Company.Addr2
    fiAddr3            = Company.Addr3
    fiAddr4            = Company.Addr4
    fiTelno            = Company.Telno
    fi_producernewcomp = company.Text1    
    fi_producerusecomp = company.Text2    
    fi_producerrenew   = company.Text3 
    fi_producerbike    = company.Text5    /*a57-0063*/ 
    fi_agentcompa      = company.Text4  
   /* n_benname          = Company.Name2    /*A56-0024*/
    n_producernew      = company.Text1    /*A56-0024*/
    n_produceruse      = company.Text2    /*A56-0024*/
    n_producerbike     = company.Text5    /*A57-0063*/
    n_agent            = company.Text4*/ .  /*A56-0024*/

DISP fiCompNo  fiBranch  fiABNAme           fiName           finame2 
     fiAddr1   fiAddr2   fiAddr3            fiAddr4          fiTelno
     fi_producernewcomp  fi_producerusecomp fi_producerrenew fi_agentcompa
     fi_producerbike   WITH FRAME frComp.
 /*DISP fiuser fiFdate WITH FRAME fruser.*/
    gComp = company.compno.
    RUN pdUpdateQ.
    DISP brinsure  WITH FRAME frbrins.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdDispIns WUWSETCOM 
PROCEDURE pdDispIns :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN  fiInComp   = "" 
        fiIn_br    = "" 
        fiInBranch = "".
       
DISPLAY 
     Insure.Branch    @ fiInBranch
     Insure.lname     @ fiInComp 
     Insure.Fname     @ fiIn_br   WITH FRAME frinsure .

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pddisplogin WUWSETCOM 
PROCEDURE pddisplogin :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN
    fi_producernewcomp      =  ""
    fi_producerusecomp      =  ""
    fi_producerrenew        =  ""
    fi_agentcompa           =  ""
    fi_producerbike         =  ""  
    fiCompNo    = Company.CompNo
    fiABName    = Company.ABName
    fibranch    = Company.Branch
    fiName      = Company.Name
    fiName2     = Company.Name2
    fiAddr1     = Company.Addr1
    fiAddr2     = Company.Addr2
    fiAddr3     = Company.Addr3
    fiAddr4     = Company.Addr4
    fiTelNo     = Company.TelNo
    fi_producernewcomp      =  company.Text1  
    fi_producerusecomp      =  company.Text2  
    fi_producerrenew        =  company.Text3  
    fi_producerbike         =  company.Text5  
    fi_agentcompa           =  company.Text4  
    /*fiuser      = Company.PowerName*/    .
DISP fiCompNo fiAbName fibranch fiName fiName2
     fiAddr1 fiAddr2 fiAddr3 fiAddr4 fiTelNo 
     fi_producernewcomp
     fi_producerusecomp
     fi_producerrenew  
     fi_producerbike        /*A57-0063*/
     fi_agentcompa     WITH FRAME frComp.
FIND FIRST insure USE-INDEX insure01 WHERE
    insure.compno = fiCompNo NO-LOCK NO-WAIT NO-ERROR.
IF AVAIL insure THEN DO:
    ASSIGN
        fiincomp     = insure.Lname
        fiin_br      = insure.Fname
        fiinbranch   = insure.Branch .
    brInsure:Sensitive  IN FRAM frbrins = Yes.   
END.
ELSE DO: 
    ASSIGN
        fiincomp     = ""
        fiin_br      = ""
        fiinbranch   = ""
    brInsure:Sensitive  IN FRAM frbrins = Yes. 
END.
DISP  fiin_br fiincomp fiinbranch WITH FRAME frinsure.
DISP  brInsure WITH FRAME frbrins.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdEnable WUWSETCOM 
PROCEDURE pdEnable :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ENABLE 
    fiInBranch fiInComp fiin_br    btnInOK     btnInCancel 
    WITH FRAME frinsure.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdenablecomp WUWSETCOM 
PROCEDURE pdenablecomp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ENABLE 
    fiCompNo fiabname fiName fiName2 fibranch 
    fiAddr1 fiAddr2 fiAddr3 fiAddr4  fiTelNo  
    fi_producernewcomp 
    fi_producerusecomp 
    fi_producerrenew  
    fi_producerbike        /*A57-0063*/
    fi_agentcompa      
    WITH FRAME frComp.
    ENABLE ALL WITH  FRAME fiinsure.
    ENABLE   btnCompOK btnCompReset   WITH FRAME frcomp.
    ENABLE   brinsure   WITH FRAME frbrins.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDInitData WUWSETCOM 
PROCEDURE PDInitData :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN 
    FRAME frComp fiCompNo fiCompNo = ""
    FRAME frComp fiABName fiAbName = ""
    FRAME frComp fiName   fiName   = ""
    FRAME frComp fiName2  fiName2  = ""
    FRAME frComp fiAddr1  fiAddr1  = ""
    FRAME frComp fiAddr2  fiAddr2  = ""
    FRAME frComp fiAddr3  fiAddr3  = ""
    FRAME frComp fiAddr4  fiAddr4  = ""
    FRAME frComp fiTelNo  fiTelNo  = ""
    btnCompAdd:Sensitive   IN FRAME frcomp = Yes
    btnCompUpd:Sensitive   IN FRAME frcomp = Yes
    btnCompDel:Sensitive   IN FRAME frcomp = Yes
    btnCompOK:Sensitive    IN FRAME frcomp = No
    btnCompReset:Sensitive IN FRAME frcomp = No  
        
    btnCompFirst:Sensitive IN FRAME frcomp = Yes
    btnCompPrev:Sensitive  IN FRAME frcomp = Yes
    btnCompNext:Sensitive  IN FRAME frcomp = Yes
    btnCompLast:Sensitive  IN FRAME frcomp = Yes
    
    cUpdate = "".
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdUpdateQ WUWSETCOM 
PROCEDURE pdUpdateQ :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
OPEN QUERY brInsure  FOR EACH Insure USE-INDEX Insure01 NO-LOCK
    WHERE insure.compno  = ficompno
    BY Insure.lname .
    ASSIGN 
        FRAME frInsure fiInBranch fiInComp fiIn_br = "".

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE ProcDisable WUWSETCOM 
PROCEDURE ProcDisable :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DISABLE fiin_br fiincomp fiinBranch  WITH FRAME frinsure.  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE ProcUpdateInsure WUWSETCOM 
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
ASSIGN pComp = ficompno .
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
END.      /* ADD */
ELSE IF cmode = "UPDATE" THEN DO WITH FRAME frbrins  /*{&FRAME-NAME}*/:
    GET CURRENT brInsure EXCLUSIVE-LOCK.
END.
ASSIGN 
    /*fiTitle */
    FRAME frcomp    ficompno
    FRAME frInsure  fiIncomp
    FRAME frInsure  fiIn_br
    FRAME frInsure  fiInBranch
    
    insure.compno  = ficompno
    Insure.Branch  = fiInBranch
    Insure.LName   = fiInComp
    Insure.FName   = fiIn_br

  
    btnFirst:Sensitive IN FRAM frinsure = Yes
    btnPrev:Sensitive  IN FRAM frinsure = Yes
    btnNext:Sensitive  IN FRAM frinsure = Yes
    btnLast:Sensitive  IN FRAM frinsure = Yes
      
    btnInAdd:Sensitive    IN FRAM frinsure = Yes
    btnInUpdate:Sensitive IN FRAM frinsure = Yes
    btnInDelete:Sensitive IN FRAM frinsure = Yes
      
    btnInOK:Sensitive     IN FRAM frinsure = YES
    btnInCancel:Sensitive IN FRAM frinsure = YES
    brInsure:Sensitive  IN FRAM frbrins = Yes.   
        
    RUN PDUpdateQ.
    APPLY "VALUE-CHANGED" TO brInsure IN FRAME frbrins.
    
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

