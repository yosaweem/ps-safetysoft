&ANALYZE-SUSPEND _VERSION-NUMBER AB_v10r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
*/
&Scoped-define WINDOW-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS C-Win 
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
/************************************************************************/
/*  wgwpchar  - Program Set Channel Auto Transfer                        */
/* Copyright    : Tokio Marine Safety Insurance (Thailand) PCL.          */
/*                        บริษัท คุ้มภัยโตเกียวมารีนประกันภัย (ประเทศไทย)*/
/* CREATE BY    : Chaiyong W.   ASSIGN A66-0221   DATE 20/10/2023        */
/* Create an unnamed pool to store all the widgets created 
     by this procedure. This is a good default which assures
     that this procedure's triggers and internal procedures 
     will execute in this procedure's storage, and that proper
     cleanup will occur on deletion of the procedure. */

CREATE WIDGET-POOL.

/* ***************************  Definitions  ************************** */
/*DEF INPUT PARAMETER nv_upbranch AS CHAR INIT "" .
  DEF INPUT PARAMETER nv_head     AS CHAR INIT "" . */
/* Parameters Definitions ---                                           */
def var  nv_upbranch  as char init "".
def var  nv_head      as char init "".
DEF TEMP-TABLE tsym100
    //FIELD tabcod AS CHAR INIT ""
    FIELD itmcod AS CHAR INIT ""
    FIELD itmdes AS CHAR INIT "".
DEF TEMP-TABLE tuzpbrn
    FIELD typeg     AS CHAR INIT ""
    FIELD typcode   AS CHAR INIT ""
    FIELD type      AS CHAR INIT ""
    FIELD typpara   AS CHAR INIT ""
    FIELD typname   AS CHAR INIT ""
    FIELD note1     AS CHAR INIT ""
    FIELD note1des  AS CHAR INIT ""
    FIELD note2     AS CHAR INIT ""
    FIELD entid     AS CHAR INIT ""
    FIELD entdat    AS DATE INIT ?
    FIELD entime    AS CHAR INIT ""
    FIELD nrecid    AS RECID INIT ?
    FIELD notee     AS CHAR INIT "" EXTENT 20
    field trndat    as DATE INIT ?
    field revtime   as char init ""
    field revid     as char init "".
DEF TEMP-TABLE tuzpbrn2 LIKE tuzpbrn.
/* Local Variable Definitions ---                                       */
DEF VAR nv_typeg   AS CHAR INIT "".
DEF VAR nv_typcode AS CHAR INIT "".
DEF VAR nv_stac    AS LOGICAL INIT NO.
DEF VAR nv_status  AS CHAR INIT "".
DEF VAR n_messer AS CHAR INIT "".
DEF VAR nv_recid AS RECID INIT ?.

DEF TEMP-TABLE w_chkbr
    FIELD branch   AS CHAR FORMAT "X(2)" 
    FIELD producer AS CHAR FORMAT "X(10)".
DEF VAR nv_branch AS CHAR INIT "".
DEF VAR nv_lookup AS INT INIT 0.
DEF VAR nv_stqal AS CHAR INIT "".
DEF VAR nv_stall AS CHAR INIT "".
DEF  TEMP-TABLE timport LIKE tuzpbrn.
DEF  BUFFER  btimport FOR timport.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define BROWSE-NAME br_que1

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES tuzpbrn2

/* Definitions for BROWSE br_que1                                       */
&Scoped-define FIELDS-IN-QUERY-br_que1 tuzpbrn2.type tuzpbrn2.typpara tuzpbrn2.typname tuzpbrn2.note1des   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_que1   
&Scoped-define SELF-NAME br_que1
&Scoped-define QUERY-STRING-br_que1 FOR EACH tuzpbrn2 NO-LOCK
&Scoped-define OPEN-QUERY-br_que1 OPEN QUERY {&SELF-NAME} FOR EACH tuzpbrn2 NO-LOCK.
&Scoped-define TABLES-IN-QUERY-br_que1 tuzpbrn2
&Scoped-define FIRST-TABLE-IN-QUERY-br_que1 tuzpbrn2


/* Definitions for FRAME fr_que1                                        */
&Scoped-define OPEN-BROWSERS-IN-QUERY-fr_que1 ~
    ~{&OPEN-QUERY-br_que1}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS buexit 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON buexit 
     LABEL "Exit" 
     SIZE 12.5 BY 1.91
     FONT 6.

DEFINE BUTTON btn_file 
     LABEL "Browse" 
     SIZE 10 BY 1.

DEFINE BUTTON bt_cancel 
     LABEL "Cancel" 
     SIZE 15 BY 1.14
     FONT 32.

DEFINE BUTTON bt_create 
     LABEL "Create" 
     SIZE 15 BY 1.14
     FONT 32.

DEFINE BUTTON bt_delete 
     LABEL "Delete" 
     SIZE 15 BY 1.14
     FONT 32.

DEFINE BUTTON bt_edit 
     LABEL "Edit" 
     SIZE 15 BY 1.14
     FONT 32.

DEFINE BUTTON bu_export 
     LABEL "Export" 
     SIZE 15 BY 1.14
     FONT 32.

DEFINE BUTTON bu_import 
     LABEL "Import" 
     SIZE 15 BY 1.14
     FONT 32.

DEFINE VARIABLE fi_export AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 68 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_import AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 56.5 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_iddes AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 71.67 BY 1
     FONT 6 NO-UNDO.

DEFINE VARIABLE fi_iddes2 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 71.67 BY 1
     FONT 6 NO-UNDO.

DEFINE VARIABLE fi_iddes3 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 71.67 BY 1
     FONT 6 NO-UNDO.

DEFINE BUTTON bt_help 
     LABEL "List" 
     SIZE 5.5 BY .95
     FONT 6.

DEFINE VARIABLE cb_pgid AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 58.5 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_code AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 15.5 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_head AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 50 BY 1
     BGCOLOR 3 FGCOLOR 15 FONT 23 NO-UNDO.

DEFINE BUTTON bt_can1 
     LABEL "Cancel" 
     SIZE 15 BY 1.14
     FONT 32.

DEFINE BUTTON bt_save1 
     LABEL "Save" 
     SIZE 15 BY 1.14
     FONT 32.

DEFINE VARIABLE co_branch AS CHARACTER 
     VIEW-AS COMBO-BOX SORT INNER-LINES 5
     LIST-ITEMS "Item 1" 
     DROP-DOWN MAX-CHARS 3
     SIZE 17 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_brdesc AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 67 BY 1
     FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_codedes1 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 67 BY 1
     FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_inputcode1 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 17 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_poldes AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 67 BY 1
     FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_poltyp AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 17 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE ra_auto AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "Auto Transfer", 1,
"Not Auto Transfer", 2
     SIZE 40.5 BY 1
     FONT 32 NO-UNDO.

DEFINE BUTTON bt_reset 
     LABEL "Refresh" 
     SIZE 10.33 BY 1.14
     FONT 32.

DEFINE VARIABLE fi_search AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 29 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE ra_search AS INTEGER INITIAL 1 
     VIEW-AS RADIO-SET VERTICAL
     RADIO-BUTTONS 
          "Branch", 1,
"Policy Type", 2,
"Producer Code", 3
     SIZE 19.5 BY 1.91
     FONT 32 NO-UNDO.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_que1 FOR 
      tuzpbrn2 SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_que1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_que1 C-Win _FREEFORM
  QUERY br_que1 DISPLAY
      tuzpbrn2.type     COLUMN-LABEL "Branch"        FORMAT "x(10)":U  
      tuzpbrn2.typpara  COLUMN-LABEL "Policy Type"   FORMAT "x(15)":U  
      tuzpbrn2.typname  COLUMN-LABEL "Producer Code" FORMAT "x(20)":U
      tuzpbrn2.note1des COLUMN-LABEL "Status"        FORMAT "x(20)":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 99.5 BY 11.43
         BGCOLOR 15 FONT 6 ROW-HEIGHT-CHARS .6 FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     buexit AT ROW 30.76 COL 90 WIDGET-ID 8
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 103.67 BY 32.67
         BGCOLOR 8  WIDGET-ID 100.

DEFINE FRAME fr_disp
     fi_iddes AT ROW 1.24 COL 12 COLON-ALIGNED NO-LABEL WIDGET-ID 2
     fi_iddes2 AT ROW 2.43 COL 12 COLON-ALIGNED NO-LABEL WIDGET-ID 136
     fi_iddes3 AT ROW 3.62 COL 12 COLON-ALIGNED NO-LABEL WIDGET-ID 140
     "Prvious by" VIEW-AS TEXT
          SIZE 10.5 BY 1 AT ROW 2.43 COL 1.67 WIDGET-ID 138
          FONT 32
     "Entry by" VIEW-AS TEXT
          SIZE 10.5 BY 1 AT ROW 3.62 COL 1.67 WIDGET-ID 142
          FONT 32
     "Review by" VIEW-AS TEXT
          SIZE 10.5 BY 1 AT ROW 1.24 COL 1.67 WIDGET-ID 132
          FONT 32
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1.67 ROW 29.52
         SIZE 86.5 BY 3.95
         BGCOLOR 3 FGCOLOR 15  WIDGET-ID 900.

DEFINE FRAME fr_head
     bt_help AT ROW 3.1 COL 2.83 WIDGET-ID 278
     fi_code AT ROW 3.1 COL 22.17 COLON-ALIGNED NO-LABEL WIDGET-ID 2
     cb_pgid AT ROW 3.1 COL 41.5 COLON-ALIGNED NO-LABEL WIDGET-ID 276
     fi_head AT ROW 1.52 COL 27.33 COLON-ALIGNED NO-LABEL WIDGET-ID 274
     "Channel" VIEW-AS TEXT
          SIZE 10 BY 1 AT ROW 3.05 COL 12.83 WIDGET-ID 126
          FGCOLOR 15 FONT 32
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 2 ROW 1.19
         SIZE 102 BY 3.38
         BGCOLOR 3  WIDGET-ID 200.

DEFINE FRAME fr_que1
     br_que1 AT ROW 1.48 COL 2.5 WIDGET-ID 800
     ra_search AT ROW 13.05 COL 10 NO-LABEL WIDGET-ID 138
     fi_search AT ROW 13.48 COL 31.33 COLON-ALIGNED NO-LABEL WIDGET-ID 2
     bt_reset AT ROW 13.43 COL 65.5 WIDGET-ID 136
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 2 ROW 4.76
         SIZE 102.5 BY 14.1
         BGCOLOR 8  WIDGET-ID 400.

DEFINE FRAME fr_bt
     bt_create AT ROW 1.43 COL 39.83 WIDGET-ID 4
     bt_edit AT ROW 1.43 COL 55.5 WIDGET-ID 6
     bt_delete AT ROW 1.43 COL 71.17 WIDGET-ID 8
     bt_cancel AT ROW 1.43 COL 87 WIDGET-ID 10
     fi_export AT ROW 2.86 COL 12.67 COLON-ALIGNED NO-LABEL WIDGET-ID 162
     bu_export AT ROW 2.71 COL 87.17 WIDGET-ID 166
     fi_import AT ROW 4.1 COL 12.5 COLON-ALIGNED NO-LABEL WIDGET-ID 170
     btn_file AT ROW 4.1 COL 72 WIDGET-ID 174
     bu_import AT ROW 3.95 COL 87.17 WIDGET-ID 172
     "Export To" VIEW-AS TEXT
          SIZE 11 BY 1 AT ROW 2.81 COL 1.5 WIDGET-ID 164
          FONT 32
     "Import To" VIEW-AS TEXT
          SIZE 11 BY 1 AT ROW 4.1 COL 1.5 WIDGET-ID 168
          FONT 32
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 2 ROW 24.81
         SIZE 102.5 BY 4.52
         BGCOLOR 8  WIDGET-ID 600.

DEFINE FRAME fr_input1
     co_branch AT ROW 1.33 COL 16 COLON-ALIGNED NO-LABEL WIDGET-ID 12
     fi_brdesc AT ROW 1.33 COL 34 COLON-ALIGNED NO-LABEL WIDGET-ID 160
     fi_poltyp AT ROW 2.52 COL 16 COLON-ALIGNED NO-LABEL WIDGET-ID 144
     fi_poldes AT ROW 2.52 COL 34 COLON-ALIGNED NO-LABEL WIDGET-ID 142
     fi_inputcode1 AT ROW 3.81 COL 16 COLON-ALIGNED NO-LABEL WIDGET-ID 4
     fi_codedes1 AT ROW 3.81 COL 34 COLON-ALIGNED NO-LABEL WIDGET-ID 6
     ra_auto AT ROW 5.14 COL 18 NO-LABEL WIDGET-ID 148
     bt_save1 AT ROW 5.05 COL 71.5 WIDGET-ID 136
     bt_can1 AT ROW 5.05 COL 87.17 WIDGET-ID 134
     "Policy Type" VIEW-AS TEXT
          SIZE 15.33 BY 1 AT ROW 2.52 COL 1.5 WIDGET-ID 146
          FONT 32
     "Producer Code" VIEW-AS TEXT
          SIZE 15.33 BY 1 AT ROW 3.81 COL 1.5 WIDGET-ID 126
          FONT 32
     "Branch Code" VIEW-AS TEXT
          SIZE 15.33 BY 1 AT ROW 1.33 COL 1.67 WIDGET-ID 156
          FONT 32
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 2 ROW 19
         SIZE 102.67 BY 5.57
         BGCOLOR 8  WIDGET-ID 500.


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
  CREATE WINDOW C-Win ASSIGN
         HIDDEN             = YES
         TITLE              = "<insert window title>"
         HEIGHT             = 32.67
         WIDTH              = 103.83
         MAX-HEIGHT         = 46.24
         MAX-WIDTH          = 213.33
         VIRTUAL-HEIGHT     = 46.24
         VIRTUAL-WIDTH      = 213.33
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

&IF '{&WINDOW-SYSTEM}' NE 'TTY' &THEN
IF NOT C-Win:LOAD-ICON("WIMAGE/iconhead.ico":U) THEN
    MESSAGE "Unable to load icon: WIMAGE/iconhead.ico"
            VIEW-AS ALERT-BOX WARNING BUTTONS OK.
&ENDIF
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW C-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* REPARENT FRAME */
ASSIGN FRAME fr_bt:FRAME = FRAME DEFAULT-FRAME:HANDLE
       FRAME fr_disp:FRAME = FRAME DEFAULT-FRAME:HANDLE
       FRAME fr_head:FRAME = FRAME DEFAULT-FRAME:HANDLE
       FRAME fr_input1:FRAME = FRAME DEFAULT-FRAME:HANDLE
       FRAME fr_que1:FRAME = FRAME DEFAULT-FRAME:HANDLE.

/* SETTINGS FOR FRAME DEFAULT-FRAME
   FRAME-NAME                                                           */

DEFINE VARIABLE XXTABVALXX AS LOGICAL NO-UNDO.

ASSIGN XXTABVALXX = FRAME fr_disp:MOVE-BEFORE-TAB-ITEM (buexit:HANDLE IN FRAME DEFAULT-FRAME)
       XXTABVALXX = FRAME fr_bt:MOVE-BEFORE-TAB-ITEM (FRAME fr_disp:HANDLE)
       XXTABVALXX = FRAME fr_input1:MOVE-BEFORE-TAB-ITEM (FRAME fr_bt:HANDLE)
       XXTABVALXX = FRAME fr_que1:MOVE-BEFORE-TAB-ITEM (FRAME fr_input1:HANDLE)
       XXTABVALXX = FRAME fr_head:MOVE-BEFORE-TAB-ITEM (FRAME fr_que1:HANDLE)
/* END-ASSIGN-TABS */.

/* SETTINGS FOR FRAME fr_bt
   Custom                                                               */
ASSIGN 
       btn_file:AUTO-RESIZE IN FRAME fr_bt      = TRUE.

/* SETTINGS FOR FRAME fr_disp
                                                                        */
/* SETTINGS FOR FILL-IN fi_iddes IN FRAME fr_disp
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_iddes2 IN FRAME fr_disp
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_iddes3 IN FRAME fr_disp
   NO-ENABLE                                                            */
/* SETTINGS FOR FRAME fr_head
                                                                        */
/* SETTINGS FOR FILL-IN cb_pgid IN FRAME fr_head
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_code IN FRAME fr_head
   NO-ENABLE                                                            */
/* SETTINGS FOR FRAME fr_input1
   Custom                                                               */
/* SETTINGS FOR FILL-IN fi_inputcode1 IN FRAME fr_input1
   NO-DISPLAY                                                           */
/* SETTINGS FOR FILL-IN fi_poltyp IN FRAME fr_input1
   NO-DISPLAY                                                           */
/* SETTINGS FOR FRAME fr_que1
   Custom                                                               */
/* BROWSE-TAB br_que1 1 fr_que1 */
ASSIGN 
       br_que1:SEPARATOR-FGCOLOR IN FRAME fr_que1      = 8.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_que1
/* Query rebuild information for BROWSE br_que1
     _START_FREEFORM
OPEN QUERY {&SELF-NAME} FOR EACH tuzpbrn2 NO-LOCK.
     _END_FREEFORM
     _Query            is OPENED
*/  /* BROWSE br_que1 */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* <insert window title> */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* <insert window title> */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br_que1
&Scoped-define FRAME-NAME fr_que1
&Scoped-define SELF-NAME br_que1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_que1 C-Win
ON MOUSE-SELECT-CLICK OF br_que1 IN FRAME fr_que1
DO:
   RUN pd_display.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_que1 C-Win
ON VALUE-CHANGED OF br_que1 IN FRAME fr_que1
DO:
   RUN pd_display.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fr_bt
&Scoped-define SELF-NAME btn_file
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_file C-Win
ON CHOOSE OF btn_file IN FRAME fr_bt /* Browse */
DO:
    DEFINE VARIABLE cvData        AS CHARACTER NO-UNDO.
    DEFINE VARIABLE OKpressed AS LOGICAL INITIAL TRUE.
  

   SYSTEM-DIALOG GET-FILE cvData
        TITLE     "Choose Data File to Import ..."
        FILTERS   "Excel (*.csv)" "*.csv",                  
                  "Text Files (*.txt)" "*.txt",
                  "Text Files (*.*)" "*.*"
        MUST-EXIST
        USE-FILENAME
        UPDATE OKpressed.
    IF OKpressed = TRUE THEN DO:
         fi_import = cvData.
         DISP fi_import WITH FRAME {&FRAME-NAME}.     
    END.

 

     
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fr_input1
&Scoped-define SELF-NAME bt_can1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bt_can1 C-Win
ON CHOOSE OF bt_can1 IN FRAME fr_input1 /* Cancel */
DO:
    RUN pd_clrfield.
    ENABLE ALL WITH FRAME fr_bt.
    DISABLE ALL WITH FRAME fr_input1.
    FIND FIRST  tuzpbrn2 NO-LOCK NO-ERROR.
    IF AVAIL  tuzpbrn2 THEN ENABLE ALL WITH FRAME fr_que1.
    ELSE DISABLE ALL WITH FRAME fr_que1.
    OPEN QUERY br_que1 FOR EACH tuzpbrn2 NO-LOCK BY tuzpbrn2.type.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fr_bt
&Scoped-define SELF-NAME bt_cancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bt_cancel C-Win
ON CHOOSE OF bt_cancel IN FRAME fr_bt /* Cancel */
DO:
    
    ENABLE bt_help  WITH FRAME fr_head.
    DISABLE ALL WITH FRAME fr_choose.
    DISABLE ALL WITH FRAME fr_que1.
    DISABLE ALL WITH FRAME fr_input1.
    DISABLE ALL WITH FRAME fr_input2.
    DISABLE ALL WITH FRAME fr_bt.
    ENABLE fi_import  btn_file  bu_import WITH FRAME fr_bt.
    RUN pd_clrfield.
    /*-- temp --*/
    FOR EACH tuzpbrn:
        DELETE tuzpbrn.
    END.
    FOR EACH tuzpbrn2:
        DELETE tuzpbrn2.
    END.
    OPEN QUERY br_que1 FOR EACH tuzpbrn2 NO-LOCK BY tuzpbrn2.type.
    ASSIGN
        fi_code = ""
        cb_pgid = "".
        DISP  fi_code cb_pgid WITH FRAME fr_head.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bt_create
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bt_create C-Win
ON CHOOSE OF bt_create IN FRAME fr_bt /* Create */
DO:
    DISABLE ALL WITH FRAME fr_que1.
    DISABLE ALL WITH FRAME fr_input1.
    DISABLE ALL WITH FRAME fr_input2.
    DISABLE ALL WITH FRAME fr_bt.
    RUN pd_clrfield.
    nv_status = "Create".
    RUN pd_branchdis.
     ENABLE co_branch bt_save1 bt_can1 fi_inputcode1 fi_poltyp ra_auto WITH FRAME fr_input1.
     
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bt_delete
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bt_delete C-Win
ON CHOOSE OF bt_delete IN FRAME fr_bt /* Delete */
DO:
    IF nv_recid  <> ? THEN DO:
    
        MESSAGE "Do you want to Delete this?"
        UPDATE chkappr AS LOGICAL
        VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO  TITLE "Delete".
        IF chkappr THEN DO:
           nv_status = "delete".
           RUN pd_delete.
           RUN pd_clrfield.
           RUN pd_choose.
        END.
    END.
    ELSE DO:
        MESSAGE "Please Select Data" VIEW-AS ALERT-BOX INFORMATION.
    END.
    RUN pd_clrfield.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bt_edit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bt_edit C-Win
ON CHOOSE OF bt_edit IN FRAME fr_bt /* Edit */
DO:

        IF (TRIM(INPUT FRAME fr_input1 co_branch) = "" OR
            TRIM(INPUT FRAME fr_input1 co_branch) = ?)  and
           trim(INPUT FRAME fr_input1 fi_poltyp) = ""  and
           trim(INPUT FRAME fr_input1 fi_inputcode1) = "" THEN DO:
            MESSAGE "Please Select Data !" VIEW-AS ALERT-BOX INFORMATION.
            APPLY "CHOOSE" TO bt_edit IN FRAME fr_bt.
            RETURN NO-APPLY.
        END.
        ENABLE co_branch bt_save1 bt_can1 fi_poltyp fi_inputcode1 ra_auto WITH FRAME fr_input1.
        APPLY "leave" TO fi_inputcode1 IN FRAME fr_input1.
 
    nv_status = "Edit".
    DISABLE ALL WITH FRAME fr_que1.
    DISABLE ALL WITH FRAME fr_bt.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fr_head
&Scoped-define SELF-NAME bt_help
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bt_help C-Win
ON CHOOSE OF bt_help IN FRAME fr_head /* List */
DO:
    DEF VAR nv_data  AS CHAR INIT "".
    DEF VAR nv_data2 AS CHAR INIT "".

    //DISABLE ALL WITH FRAME fr_head.
    RUN whp\whpqda2ct(INPUT "Help Channel",OUTPUT nv_data,OUTPUT nv_data2,INPUT TABLE tsym100).
    IF nv_data <> "" THEN DO:
        ASSIGN
            fi_code = nv_data
            cb_pgid = nv_data2.
        DISP  fi_code 
              cb_pgid  WITH FRAME fr_head.


        nv_typcode = fi_code.
        IF fi_code <> "" THEN DO:
            FIND FIRST tsym100 WHERE tsym100.itmcod = fi_code NO-LOCK NO-ERROR.
            IF AVAIL tsym100 THEN DO:
                nv_typcode = tsym100.itmcod.
                //MESSAGE nv_typcode cb_pgid.
            END.
        END.
        ELSE DO:
            /*MESSAGE "Please Choose Channel" VIEW-AS ALERT-BOX INFORMATION.
            RETURN NO-APPLY. */
        END.
        DISABLE ALL WITH FRAME fr_head.
        ENABLE ALL WITH FRAME fr_bt.
        DISABLE ALL WITH FRAME fr_choose.
        RUN pd_choose.
    END.
    //ENABLE bt_help bt_set WITH FRAME fr_head.      
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fr_que1
&Scoped-define SELF-NAME bt_reset
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bt_reset C-Win
ON CHOOSE OF bt_reset IN FRAME fr_que1 /* Refresh */
DO:
    RUN pd_choose.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fr_input1
&Scoped-define SELF-NAME bt_save1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bt_save1 C-Win
ON CHOOSE OF bt_save1 IN FRAME fr_input1 /* Save */
DO:

    APPLY "leave" TO co_branch     IN FRAME fr_input1.
    APPLY "leave" TO fi_inputcode1 IN FRAME fr_input1.
    APPLY "leave" TO fi_poltyp     IN FRAME fr_input1.

    ra_auto = INPUT ra_auto.

    co_branch = INPUT co_branch.
    IF co_branch = "" THEN DO:
        MESSAGE "Branch is Mandatory!!" VIEW-AS ALERT-BOX INFORMATION.
        APPLY "ENTRY" TO fi_inputcode1 IN FRAME fr_input1.
        RETURN NO-APPLY.


    END.
    ELSE IF fi_inputcode1 = "" THEN DO:
        MESSAGE "Producer Code is Mandatory!!" VIEW-AS ALERT-BOX INFORMATION.
        APPLY "ENTRY" TO fi_inputcode1 IN FRAME fr_input1.
        RETURN NO-APPLY.


    END.
    ELSE IF fi_poltyp = "" THEN DO:
        MESSAGE "Policy Type is Mandatory!!" VIEW-AS ALERT-BOX INFORMATION.
        APPLY "ENTRY" TO fi_poltyp IN FRAME fr_input1.
        RETURN NO-APPLY.             
    END.
    RUN pd_chkdup(OUTPUT n_messer).
    IF n_messer <> "" THEN DO:
        MESSAGE n_messer  VIEW-AS ALERT-BOX INFORMATION.
                APPLY "ENTRY" TO fi_inputcode1 IN FRAME fr_input1.
                RETURN NO-APPLY.

    END.

    MESSAGE "Do you want to " + nv_status + " this?"
        UPDATE chkappr AS LOGICAL VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO  TITLE nv_status.
    IF chkappr THEN DO:
        RUN pd_create1.
    END.
    RUN pd_clrfield.
    ENABLE ALL WITH FRAME fr_bt.
    ENABLE ALL WITH FRAME fr_que1.

    DISABLE ALL WITH FRAME fr_input1.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define SELF-NAME buexit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buexit C-Win
ON CHOOSE OF buexit IN FRAME DEFAULT-FRAME /* Exit */
DO:
  APPLY "CLOSE" TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fr_bt
&Scoped-define SELF-NAME bu_export
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_export C-Win
ON CHOOSE OF bu_export IN FRAME fr_bt /* Export */
DO:

    DEF VAR nv_stdes AS CHAR INIT "".
    DEF VAR nv_rev   AS CHAR INIT "".
    DEF VAR nv_prv   AS CHAR INIT "".
    DEF VAR nv_ent   AS CHAR INIT "".
    DEF VAR nv_brnm  AS CHAR INIT "".
    DEF VAR nv_acnm  AS CHAR INIT "".
    DEF VAR nv_iexport AS INT INIT 0.


    fi_export = trim(INPUT fi_export).
    IF fi_export = "" OR fi_export = ? THEN DO:
        MESSAGE "Export To is Mandatory!!" VIEW-AS ALERT-BOX INFORMATION.
        APPLY "ENTRY" TO fi_export IN FRAME fr_bt.
        RETURN NO-APPLY.
    END.



    OUTPUT TO VALUE(fi_export).



    EXPORT DELIMITER ","
        "Channel Code"
        "Branch Code"
        "Branch Name"
        "Policy Type"
        "Producer Code"
        "Producer Name"
        "Status Transfer"
        "Review By" 
        "Previous By" 
        "Entry By"    SKIP.


    FOR EACH brstat.uzpbrn USE-INDEX uzpbrn02 WHERE 
        brstat.uzpbrn.typeg   = nv_typeg   AND 
        brstat.uzpbrn.typcode = nv_typcode NO-LOCK: 
        //IF LOOKUP(brstat.uzpbrn.type,nv_branch) = 0  THEN NEXT.
    
        IF uzpbrn.note1 = "Y" THEN nv_stdes  = "Auto Transfer".
        ELSE nv_stdes = "Not Auto Transfer".
        ASSIGN
            nv_rev  = ""
            nv_prv  = ""
            nv_ent  = ""
            nv_brnm = ""
            nv_acnm = "".
        IF uzpbrn.revid     <> "" THEN nv_rev  = uzpbrn.revid     + "    " + STRING(uzpbrn.trndat,"99/99/9999") + "    " + uzpbrn.revtime .
        IF uzpbrn.notee[3]  <> "" THEN nv_prv  = uzpbrn.notee[3]  + "    " + uzpbrn.notee[1]                    + "    " + uzpbrn.notee[2].
                                       nv_ent  = uzpbrn.entid     + "    " + STRING(uzpbrn.entdat,"99/99/9999") + "    " + uzpbrn.entime.

        IF brstat.uzpbrn.TYPE = "ALL" THEN nv_brnm = "ALL Branch".
        ELSE DO:
            FIND sicsyac.xmm023 USE-INDEX xmm02301 WHERE sicsyac.xmm023.branch = brstat.uzpbrn.type NO-LOCK NO-ERROR.
            IF AVAIL sicsyac.xmm023 THEN nv_brnm = sicsyac.xmm023.bdes.
        END.
        IF brstat.uzpbrn.typname = "ALL" THEN nv_acnm = "ALL Branch".
        ELSE DO:
            FIND sicsyac.xmm600 USE-INDEX xmm60001 WHERE sicsyac.xmm600.acno =  brstat.uzpbrn.typname NO-LOCK NO-ERROR.
            IF AVAIL sicsyac.xmm600 THEN nv_acnm = sicsyac.xmm600.NAME.
        END.

        nv_iexport = nv_iexport + 1.


        EXPORT DELIMITER ","
            brstat.uzpbrn.typcode
            brstat.uzpbrn.type  
            nv_brnm
            brstat.uzpbrn.typpara 
            brstat.uzpbrn.typname 
            nv_acnm
            nv_stdes
            nv_rev 
            nv_prv 
            nv_ent SKIP.



    END.


    OUTPUT CLOSE.

    IF nv_iexport <> 0  THEN MESSAGE "Export Complete" VIEW-AS ALERT-BOX INFORMATION.
    ELSE MESSAGE "Not Found Data to Export" VIEW-AS ALERT-BOX INFORMATION.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_import
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_import C-Win
ON CHOOSE OF bu_import IN FRAME fr_bt /* Import */
DO:

    def var nv_channel as char init "".  
    def var nv_branch  as char init "". 
    def var nv_acno    as char init "".
    DEF VAR nv_poltyp   AS CHAR INIT "".
    DEF VAR nv_stdes AS CHAR INIT "".
    DEF VAR nv_rev   AS CHAR INIT "".
    DEF VAR nv_prv   AS CHAR INIT "".
    DEF VAR nv_ent   AS CHAR INIT "".
    DEF VAR nv_brnm  AS CHAR INIT "".
    DEF VAR nv_acnm  AS CHAR INIT "".

    DEF VAR nv_search AS CHAR INIT "".
    DEF VAR fi_implog AS CHAR INIT "".

    DEF VAR nv_iimport AS INT INIT 0.
    DEF VAR nv_crdata  AS INT INIT 0.

    fi_import = trim(INPUT fi_import).
    IF fi_import = "" OR fi_import = ? THEN DO:
        MESSAGE "Import File is Mandatory!!" VIEW-AS ALERT-BOX INFORMATION.
        APPLY "ENTRY" TO fi_import IN FRAME fr_bt.
        RETURN NO-APPLY.
    END.
    nv_search = SEARCH(fi_import).
    IF  nv_search = ? OR  nv_search = "" THEN DO:
        MESSAGE "Not found File Import" VIEW-AS ALERT-BOX INFORMATION.
        APPLY "ENTRY" TO fi_import IN FRAME fr_bt.
        RETURN NO-APPLY.
    END.
    IF INDEX(fi_import,".") <> 0 THEN DO:
        fi_implog = substr(fi_import,1,r-INDEX(fi_import,".") - 1) + "log" + substr(fi_import,r-INDEX(fi_import,".")).

    END.
    ELSE fi_implog = fi_import + "log".

    fi_implog = TRIM(fi_implog).
    EMPTY TEMP-TABLE Timport NO-ERROR.
    INPUT FROM VALUE(fi_import).
    loop_import:
    REPEAT:
        ASSIGN
            nv_poltyp   = ""
            nv_channel  = ""
            nv_branch   = ""
            nv_brnm     = ""
            nv_acno     = ""
            nv_acnm     = ""
            nv_stdes    = "" 
            nv_iimport  = nv_iimport + 1.
                        
        IMPORT DELIMITER ","
            nv_channel
            nv_branch
           // nv_brnm
            nv_poltyp
            nv_acno
           // nv_acnm
            nv_stdes           .

        ASSIGN
            nv_channel    = trim(nv_channel  )
            nv_branch     = trim(nv_branch   )
            nv_brnm       = trim(nv_brnm     )
            nv_poltyp     = TRIM(nv_poltyp   )
            nv_acno       = trim(nv_acno     )
            nv_acnm       = trim(nv_acnm     )
            nv_stdes      = trim(nv_stdes    ).
        IF nv_iimport = 1 THEN DO:
            IF  "Channel Code" =   nv_channel  OR  
                "Branch"       =   nv_branch   THEN DO:
                NEXT loop_import. /*Head File*/
            END.
        END.
    
        CREATE timport.
        ASSIGN
            nv_crdata        = nv_crdata   + 1
            timport.typeg    = TRIM(nv_typeg)  
            timport.typcode  = nv_channel
            timport.type     = nv_branch 
            timport.typpara  = nv_poltyp
            timport.typname  = nv_acno
            timport.revtime  = nv_brnm 
            timport.revid    = nv_acnm 
            .

        


        IF nv_channel <> "" AND
           nv_branch  <> "" AND
           nv_poltyp  <> "" AND
           nv_acno    <> "" THEN DO:
            IF nv_stdes = "Auto Transfer" THEN timport.note1 = "Y".
            ELSE timport.note1 = "N".

            FIND FIRST tsym100 WHERE tsym100.itmcod = nv_channel NO-LOCK NO-ERROR.
            IF NOT AVAIL tsym100 THEN timport.note1des = trim(timport.note1des + " " + "Not Found Channel").

            IF  nv_branch <> "ALL" THEN DO:
                FIND FIRST sicsyac.xmm023 USE-INDEX xmm02301 WHERE xmm023.branch = nv_branch NO-LOCK NO-ERROR.
                IF NOT AVAIL sicsyac.xmm023 THEN timport.note1des = trim(timport.note1des + " " + "Not Found Branch").
            END.
            IF nv_poltyp <> "ALL" THEN DO:
                FIND sicsyac.xmm031 WHERE xmm031.poltyp = nv_poltyp NO-LOCK NO-ERROR.
                IF NOT AVAIL sicsyac.xmm031 THEN timport.note1des = trim(timport.note1des + " " + "Not Found Policy Type").
            END.
            IF nv_acno <> "ALL" THEN DO:
                FIND sicsyac.xmm600 USE-INDEX xmm60001 WHERE sicsyac.xmm600.acno = nv_acno NO-LOCK NO-ERROR.
                IF NOT AVAIL sicsyac.xmm600 THEN timport.note1des = trim(timport.note1des + " " + "Not Found Producer Code").
            END.
            IF timport.note1des = "" THEN DO:
                FIND FIRST btimport WHERE 
                    btimport.typeg    = timport.typeg   AND
                    btimport.typcode  = timport.typcode and
                    btimport.type     = timport.type    and
                    btimport.typpara  = timport.typpara and
                    btimport.typname  = timport.typname AND 
                    //btimport.note1   <> timport.note1   AND
                    RECID(btimport)   <> RECID(timport) NO-ERROR NO-WAIT.
                IF AVAIL btimport THEN DO:
                    ASSIGN
                        timport.note1des  = trim("Cannot Transfer")
                        btimport.note1des = trim("Cannot Transfer").
                END.
            END.
           

        END.
        ELSE DO:
            if nv_channel  = "" then timport.note1des = trim(timport.note1des + " " + "Blank Channel").
            if nv_branch   = "" then timport.note1des = trim(timport.note1des + " " + "Blank Branch").
            if nv_poltyp   = "" then timport.note1des = trim(timport.note1des + " " + "Blank Policy Type").
            if nv_acno     = "" then timport.note1des = trim(timport.note1des + " " + "Blank Producer").

        END.
        
         /*
        ELSE DO:
            FIND FIRST btimport WHERE 
                btimport.typcode  = timport.typcode and
                btimport.type     = timport.type    and
                btimport.typpara  = timport.typpara and
                btimport.typname  = timport.typname AND 
                btimport.note1   <> timport.note1   AND
                RECID(btimport)   = RECID(timport)  NO-LOCK NO-ERROR.
            IF AVAIL btimport THEN DO:
                ASSIGN
                    timport.note1des  = trim( timport.note1des + " " + "Dupplicated in file")
                   
    
            END.
        END. */








    END.
    INPUT CLOSE.

    nv_iimport = 0.
    FIND FIRST timport NO-LOCK NO-ERROR.
    IF AVAIL timport THEN DO:

        
        loop_for:
        FOR EACH timport WHERE timport.note1des = "" :
            FIND FIRST brstat.uzpbrn USE-INDEX uzpbrn02 WHERE 
                brstat.uzpbrn.typeg   = timport.typeg     and
                brstat.uzpbrn.typcode = timport.typcode   and
                brstat.uzpbrn.type    = timport.type      and
                brstat.uzpbrn.typpara = timport.typpara   and
                brstat.uzpbrn.typname = timport.typname   NO-ERROR NO-WAIT.
            IF NOT AVAILA brstat.uzpbrn THEN DO:
                CREATE brstat.uzpbrn.
                ASSIGN
                    nv_iimport            = nv_iimport + 1
                    brstat.uzpbrn.typeg   = timport.typeg     
                    brstat.uzpbrn.typcode = timport.typcode   
                    brstat.uzpbrn.type    = timport.type      
                    brstat.uzpbrn.typpara = timport.typpara   
                    brstat.uzpbrn.typname = timport.typname   
                    brstat.uzpbrn.entid   = USERID(LDBNAME(1))  
                    brstat.uzpbrn.entime  = STRING(TIME,"HH:MM:SS")
                    brstat.uzpbrn.entdat  = TODAY 
                    Timport.nrecid        = RECID(brstat.uzpbrn)
                    brstat.uzpbrn.note1 = timport.note1.
                 
               
            END.
            ELSE DO:
                IF brstat.uzpbrn.note1   = timport.note1 THEN NEXT loop_for.

                IF brstat.uzpbrn.revid <> "" THEN DO:
                    ASSIGN
                        brstat.uzpbrn.notee[1] = STRING(brstat.uzpbrn.trndat,"99/99/9999")
                        brstat.uzpbrn.notee[2] = brstat.uzpbrn.revtime
                        brstat.uzpbrn.notee[3] = brstat.uzpbrn.revid  .

                END.
                ASSIGN
                    brstat.uzpbrn.type    = timport.type        
                    brstat.uzpbrn.typpara = timport.typpara     
                    brstat.uzpbrn.typname = timport.typname     
                    brstat.uzpbrn.trndat  = TODAY
                    brstat.uzpbrn.revtime = STRING(TIME,"HH:MM:SS")
                    brstat.uzpbrn.revid   = USERID(LDBNAME(1))   
                    brstat.uzpbrn.note1   = timport.note1
                    Timport.nrecid        = RECID(brstat.uzpbrn)
                    nv_iimport            = nv_iimport + 1.
                

                

            END.
                
            RELEASE brstat.uzpbrn.

        END.
        OUTPUT TO VALUE(fi_implog).
        EXPORT DELIMITER ","
            "Channel Code"
            "Branch"
            //"Branch Name"
            "Policy Type"
            "Producer Code"
            //"Producer Name"
            "Status Transfer"
            //"Review By" 
            //"Previous By" 
            //"Entry By" 
            "Remark"     SKIP.

        FOR EACH timport :
            IF timport.nrecid <> ? THEN DO:
                FIND brstat.uzpbrn WHERE RECID(brstat.uzpbrn) = timport.nrecid NO-LOCK NO-ERROR.
                IF AVAIL brstat.uzpbrn THEN DO:
                    IF uzpbrn.note1 = "Y" THEN nv_stdes  = "Auto Transfer".
                    ELSE nv_stdes = "Not Auto Transfer".
                    ASSIGN
                        nv_rev  = ""
                        nv_prv  = ""
                        nv_ent  = ""
                        nv_brnm = ""
                        nv_acnm = "".
                    IF uzpbrn.revid     <> "" THEN nv_rev  = uzpbrn.revid     + "    " + STRING(uzpbrn.trndat,"99/99/9999") + "    " + uzpbrn.revtime .
                    IF uzpbrn.notee[3]  <> "" THEN nv_prv  = uzpbrn.notee[3]  + "    " + uzpbrn.notee[1]                    + "    " + uzpbrn.notee[2].
                                                   nv_ent  = uzpbrn.entid     + "    " + STRING(uzpbrn.entdat,"99/99/9999") + "    " + uzpbrn.entime.
            
                    IF brstat.uzpbrn.TYPE = "ALL" THEN nv_brnm = "ALL Branch".
                    ELSE DO:
                        FIND sicsyac.xmm023 USE-INDEX xmm02301 WHERE sicsyac.xmm023.branch = brstat.uzpbrn.type NO-LOCK NO-ERROR.
                        IF AVAIL sicsyac.xmm023 THEN nv_brnm = sicsyac.xmm023.bdes.
                    END.
                    IF brstat.uzpbrn.typname = "ALL" THEN nv_acnm = "ALL Branch".
                    ELSE DO:
                        FIND sicsyac.xmm600 USE-INDEX xmm60001 WHERE sicsyac.xmm600.acno =  brstat.uzpbrn.typname NO-LOCK NO-ERROR.
                        IF AVAIL sicsyac.xmm600 THEN nv_acnm = sicsyac.xmm600.NAME.
                    END.
            
            
                     nv_search  = "".
                     IF uzpbrn.revid <> "" THEN nv_search =  "Update Complete".
                     ELSE nv_search =  "Create Complete".
            
                    EXPORT DELIMITER ","
                        brstat.uzpbrn.typcode
                        brstat.uzpbrn.type  
                        //nv_brnm
                        brstat.uzpbrn.typpara 
                        brstat.uzpbrn.typname 
                        //nv_acnm
                        nv_stdes
                        //nv_rev 
                        //nv_prv 
                        //nv_ent 
                        nv_search
                        SKIP.
                END.
            END.
            ELSE DO:

                nv_search = "".
                IF timport.note1des <> "" THEN nv_search = timport.note1des.
                ELSE nv_search = "Record is Dupplicated".
                IF timport.note1 = "Y" THEN nv_stdes = "Auto Transfer" .
                ELSE nv_stdes = "Not Auto Transfer".
                EXPORT DELIMITER ","
                        timport.typcode
                        timport.type  
                        //timport.revtime          
                        timport.typpara     
                        timport.typname 
                        //timport.revid 
                        nv_stdes
                        nv_search
                     
                    
                    SKIP.


            END.
        END.
        OUTPUT CLOSE.
    END.

    EMPTY TEMP-TABLE timport NO-ERROR.

    IF nv_crdata <> 0 THEN DO: 
        IF nv_iimport <> 0 THEN MESSAGE "Import Complete" VIEW-AS ALERT-BOX INFORMATION.
        ELSE MESSAGE "File Import Not Found Data To Create / Update" VIEW-AS ALERT-BOX INFORMATION.
    END.
    ELSE MESSAGE "Not Found Data To Import" VIEW-AS ALERT-BOX INFORMATION.
    //nv_typcode = fi_code.
    IF fi_code <> "" THEN DO:
        RUN pd_choose.
    END.
    APPLY "choose" TO bt_can1 IN FRAME fr_input1.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fr_input1
&Scoped-define SELF-NAME co_branch
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL co_branch C-Win
ON LEAVE OF co_branch IN FRAME fr_input1
DO:
  
     
    
    fi_brdesc = "".
    DISP fi_brdesc WITH FRAME fr_input1.
    co_branch = INPUT co_branch.
    IF trim(INPUT co_branch) = "" OR trim(INPUT co_branch) = ? THEN DO:
        MESSAGE "Branch is not Blank" VIEW-AS ALERT-BOX INFORMATION.
        APPLY "entry" TO co_branch.
        RETURN NO-APPLY.
    END.     
    IF INPUT co_branch <> "" THEN DO:
        IF LOOKUP(INPUT co_branch,nv_branch) = 0  AND nv_status <> "" THEN DO:
            MESSAGE "Branch is not Permission" VIEW-AS ALERT-BOX INFORMATION.
            APPLY "entry" TO co_branch.
            RETURN NO-APPLY.

        END.
        IF trim(INPUT co_branch) = "ALL" THEN DO:
            co_branch = CAPS(TRIM(INPUT co_branch)).
            fi_brdesc = "ALL Branch".
            
             DISP co_branch fi_brdesc  WITH FRAME fr_input1.
        END.
        ELSE DO:
            FIND FIRST sicsyac.xmm023 USE-INDEX xmm02301 WHERE
                xmm023.branch = INPUT co_branch NO-LOCK NO-ERROR.
            IF AVAIL sicsyac.xmm023 THEN DO:
                co_branch = TRIM(INPUT co_branch).
                ASSIGN
                    fi_brdesc = sicsyac.xmm023.bdes.
                DISP co_branch fi_brdesc  WITH FRAME fr_input1.
            END.
        END.
    END.
    
    
     
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL co_branch C-Win
ON RETURN OF co_branch IN FRAME fr_input1
DO:
                      
    APPLY "ENTRY"  TO fi_poltyp.
    RETURN NO-APPLY.
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_inputcode1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_inputcode1 C-Win
ON LEAVE OF fi_inputcode1 IN FRAME fr_input1
DO:
    fi_inputcode1 = CAPS(INPUT fi_inputcode1).
    fi_codedes1   = "".
    DISP fi_codedes1 fi_inputcode1  WITH FRAME fr_input1.

    IF fi_inputcode1 <> "" THEN DO:
        IF fi_inputcode1 <> "ALL" THEN DO:
            FIND sicsyac.xmm600 USE-INDEX xmm60001 WHERE sicsyac.xmm600.acno = fi_inputcode1 NO-LOCK NO-ERROR.
            IF AVAIL sicsyac.xmm600 THEN DO: 
                fi_codedes1 = xmm600.NAME.
            END.
            ELSE IF nv_status <> "" THEN  DO: 
                MESSAGE "Not Found Producer Code!" VIEW-AS ALERT-BOX INFORMATION.
                APPLY "ENTRY" TO fi_inputcode1 IN FRAME fr_input1.
                RETURN NO-APPLY.
            END.
        END.
        ELSE DO:
            fi_codedes1 = "ALL Producer Code".
        END.
    END.
    DISP fi_codedes1 fi_inputcode1  WITH FRAME fr_input1.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_poltyp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_poltyp C-Win
ON LEAVE OF fi_poltyp IN FRAME fr_input1
DO:
    fi_poltyp = CAPS(trim(INPUT fi_poltyp)).
    fi_poldes = "".
    DISP fi_poltyp fi_poldes WITH FRAME fr_input1.

    IF fi_poltyp <> "" THEN DO:
        IF fi_poltyp <> "All" THEN DO:
            FIND sicsyac.xmm031 WHERE xmm031.poltyp = fi_poltyp NO-LOCK NO-ERROR.
            IF AVAIL sicsyac.xmm031 THEN DO:
                fi_poldes = xmm031.poldes.
                
            END.
            ELSE IF nv_status <>  "" THEN DO:
                MESSAGE "Policy Type is Not found" VIEW-AS ALERT-BOX INFORMATION.
                APPLY "entry" TO fi_poltyp.
                RETURN NO-APPLY.
            END.
        END.
        ELSE  fi_poldes  = "ALL Policy Type".
        DISP fi_poldes WITH FRAME fr_input1.
        
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fr_que1
&Scoped-define SELF-NAME fi_search
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_search C-Win
ON LEAVE OF fi_search IN FRAME fr_que1
DO:
    fi_search  = INPUT fi_search.
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_search C-Win
ON RETURN OF fi_search IN FRAME fr_que1
DO:
    fi_search  = TRIM(INPUT fi_search).

    RUN pd_choose.
    RUN pd_query(INPUT fi_search ).
   
    APPLY "ENTRY" TO fi_search.
    RETURN NO-APPLY.

    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fr_input1
&Scoped-define SELF-NAME ra_auto
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_auto C-Win
ON VALUE-CHANGED OF ra_auto IN FRAME fr_input1
DO:
  ra_auto = INPUT ra_auto.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fr_que1
&Scoped-define SELF-NAME ra_search
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_search C-Win
ON VALUE-CHANGED OF ra_search IN FRAME fr_que1
DO:

    DEF VAR nv_rsearch2 AS INT INIT 0.

    nv_rsearch2 = ra_search.
        
    
    IF ra_search <> INPUT ra_search THEN DO:
        ra_search   = INPUT ra_search.

        //IF nv_rsearch2 = THEN BROWSE  br_que1:MOVE-COLUMN(1,2).


        /*
        IF nv_rsearch2 = 3 THEN DO:     

                    
            
            /*
            BROWSE  br_que1:MOVE-COLUMN(1,2).
            BROWSE  br_que1:MOVE-COLUMN(1,2). */
        END.
        ELSE */
        IF nv_rsearch2 = 3 THEN DO:
           // BROWSE  br_que1:MOVE-COLUMN(1,2).
            BROWSE  br_que1:MOVE-COLUMN(1,3).
        END.
        ELSE IF nv_rsearch2  = 2  THEN DO:
            BROWSE  br_que1:MOVE-COLUMN(1,2).             
        END.

        IF ra_search = 3 THEN DO:
           // BROWSE  br_que1:MOVE-COLUMN(1,2).
            BROWSE  br_que1:MOVE-COLUMN(3,1).
        END.
        ELSE IF ra_search = 2  THEN DO:
            BROWSE  br_que1:MOVE-COLUMN(1,2).             
        END.
        //ELSE BROWSE  br_que1:MOVE-COLUMN(1,2).



    END.
    ra_search   = INPUT ra_search.
    RUN pd_choose.
    RUN pd_query(INPUT "").

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME DEFAULT-FRAME
&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK C-Win 


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
  SESSION:DATA-ENTRY-RETURN = YES.
  DEF  VAR  gv_prgid   AS   CHAR  FORMAT "X(8)"   NO-UNDO.
  DEF  VAR  gv_prog    AS   CHAR  FORMAT "X(50)" NO-UNDO.
  gv_prgid = "wgwpchar.w".
  gv_prog  =  "Check Channel Auto Transfer Policy".
  
  RUN  WUT\WUTHEAD (c-win:handle,gv_prgid,gv_prog).
  RUN  WUT\WUTWICEN (c-win:handle).  
  SESSION:DATA-ENTRY-RETURN = YES.
  ASSIGN
      nv_typeg  = "chkreleasenon".
  RUN pd_branch.
  RUN pd_pararun.
  HIDE FRAME fr_input2.
  APPLY "VALUE-CHANGED" TO cb_pgid IN FRAME fr_head.
  fi_head = gv_prog.
  DISP fi_head WITH FRAME fr_head.
  DISABLE ALL WITH FRAME fr_choose.
  DISABLE ALL WITH FRAME fr_que1.
  DISABLE ALL WITH FRAME fr_input1.
  DISABLE ALL WITH FRAME fr_input2.
  DISABLE ALL WITH FRAME fr_bt.
  ASSIGN
      FILE-INFO:FILE-NAME = "."
      fi_export   = trim(FILE-INFO:FULL-PATHNAME) + "\" + "channeltransfer.txt".
  DISP fi_export WITH FRAME fr_bt.
  ENABLE fi_import  btn_file  bu_import WITH FRAME fr_bt.

  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI C-Win  _DEFAULT-DISABLE
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
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
  THEN DELETE WIDGET C-Win.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI C-Win  _DEFAULT-ENABLE
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
  ENABLE buexit 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  DISPLAY fi_code cb_pgid fi_head 
      WITH FRAME fr_head IN WINDOW C-Win.
  ENABLE bt_help fi_head 
      WITH FRAME fr_head IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_head}
  DISPLAY ra_search fi_search 
      WITH FRAME fr_que1 IN WINDOW C-Win.
  ENABLE br_que1 ra_search fi_search bt_reset 
      WITH FRAME fr_que1 IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_que1}
  DISPLAY co_branch fi_brdesc fi_poldes fi_codedes1 ra_auto 
      WITH FRAME fr_input1 IN WINDOW C-Win.
  ENABLE co_branch fi_brdesc fi_poltyp fi_poldes fi_inputcode1 fi_codedes1 
         ra_auto bt_save1 bt_can1 
      WITH FRAME fr_input1 IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_input1}
  DISPLAY fi_export fi_import 
      WITH FRAME fr_bt IN WINDOW C-Win.
  ENABLE bt_create bt_edit bt_delete bt_cancel fi_export bu_export fi_import 
         btn_file bu_import 
      WITH FRAME fr_bt IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_bt}
  DISPLAY fi_iddes fi_iddes2 fi_iddes3 
      WITH FRAME fr_disp IN WINDOW C-Win.
  VIEW FRAME fr_disp IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_disp}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_branch C-Win 
PROCEDURE pd_branch :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR n_user AS CHAR INIT "".
n_user = USERID(LDBNAME(1)). 

    
    
    nv_branch  = "".  /*Collect Branch*/
                                  /*
    FIND FIRST brstat.usrsec_fil WHERE usrsec_fil.usrid = n_user AND
               TRIM(SUBSTR(usrsec_fil.CLASS,1,5))  = "*"  AND 
               TRIM(SUBSTR(usrsec_fil.CLASS,6,10)) = "*" NO-LOCK NO-ERROR.
    IF AVAIL usrsec_fil THEN DO:*/
        
         FOR EACH sicsyac.xmm023 USE-INDEX xmm02301 NO-LOCK:
             nv_lookup = nv_lookup + 1.
            IF nv_branch = "" THEN nv_branch = nv_branch + xmm023.branch.
                          ELSE nv_branch = nv_branch + ',' + xmm023.branch .

         END.
         nv_branch = nv_branch + "," + "ALL".
        
         /*
    END.
    ELSE DO:
        CREATE w_chkbr.
        ASSIGN
            w_chkbr.branch   = TRIM(SUBSTRING(n_user,6,2))
            w_chkbr.producer = "*"
            nv_branch        = TRIM(SUBSTRING(n_user,6,2))
            nv_lookup        = 0
            nv_lookup        = nv_lookup + 1.
        FOR EACH usrsec_fil WHERE usrsec_fil.usrid = n_user NO-LOCK:

            IF  TRIM(SUBSTR(usrsec_fil.CLASS,1,5)) <> TRIM(SUBSTRING(n_user,6,2)) THEN DO:
                CREATE w_chkbr.
                ASSIGN
                    w_chkbr.branch   = TRIM(SUBSTR(usrsec_fil.CLASS,1,5))
                    w_chkbr.producer = TRIM(SUBSTR(usrsec_fil.CLASS,6,10)).

                IF w_chkbr.branch = "" THEN w_chkbr.branch = "*".
                IF w_chkbr.producer = "" THEN w_chkbr.producer = "*".

                IF nv_stall <> "Y" THEN DO:
                    
                    IF  LOOKUP(TRIM(w_chkbr.branch),nv_branch) = 0 THEN DO:
                        IF w_chkbr.branch = "*" THEN DO:
                            nv_stall = "Y".
                            FOR EACH sicsyac.xmm023 USE-INDEX xmm02301 NO-LOCK:
                                 nv_lookup = nv_lookup + 1.
                                IF nv_branch = "" THEN nv_branch = nv_branch + xmm023.branch.
                                              ELSE nv_branch = nv_branch + ',' + xmm023.branch .
                    
                             END.

                        END.
                        ELSE
                            ASSIGN
                                 nv_lookup = nv_lookup + 1
                                nv_branch = nv_branch + "," + trim(w_chkbr.branch).
                    END.
                END.
            END.
        END.
    END. */
          
        
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_branchdis C-Win 
PROCEDURE pd_branchdis :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO WITH FRAME fr_input1:
        ASSIGN
            co_branch:LIST-ITEMS = nv_branch 
            nv_lookup = LOOKUP("ALL",nv_branch).
        co_branch = IF nv_lookup > 0 THEN ENTRY(nv_lookup,nv_branch)
                                     ELSE ENTRY(1,nv_branch).
   
    DISP co_branch WITH FRAME fr_input1.
    APPLY "leave" TO co_branch.
    IF co_branch <> "ALL" THEN DISABLE co_branch WITH FRAME fr_input1.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_chkdup C-Win 
PROCEDURE pd_chkdup :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF OUTPUT PARAMETER n_err  AS CHAR INIT "".


FIND FIRST brstat.uzpbrn USE-INDEX uzpbrn02 WHERE 
           brstat.uzpbrn.typeg   = nv_typeg      AND 
           brstat.uzpbrn.typcode = nv_typcode    AND 
           brstat.uzpbrn.type    = co_branch     AND 
           brstat.uzpbrn.typpara = fi_poltyp     AND 
           brstat.uzpbrn.typname = fi_inputcode1 NO-LOCK NO-ERROR.
IF AVAILA brstat.uzpbrn THEN DO:

    IF nv_status = "edit"  THEN DO:
        IF RECID(brstat.uzpbrn) <> nv_recid THEN DO:
            n_err = "Branch : " + brstat.uzpbrn.type  + "/"+ "Policy Type : " + brstat.uzpbrn.typpara + "/" + "Producer Code : " +   brstat.uzpbrn.type  + " This code is already in the system !".
        END.
    END.    
    ELSE DO:
         n_err = "Branch : " + brstat.uzpbrn.type  + "/"+ "Policy Type : " + brstat.uzpbrn.typpara + "/" + "Producer Code : " +   brstat.uzpbrn.type  + " This code is already in the system !".
    END.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_choose C-Win 
PROCEDURE pd_choose :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
EMPTY TEMP-TABLE tuzpbrn.
EMPTY TEMP-TABLE tuzpbrn2.
fi_code = nv_typcode.
DISP fi_code WITH FRAME fr_head.
FOR EACH brstat.uzpbrn USE-INDEX uzpbrn02 WHERE brstat.uzpbrn.typeg   = nv_typeg   AND 
                                         brstat.uzpbrn.typcode = nv_typcode NO-LOCK: 
    IF LOOKUP(brstat.uzpbrn.type,nv_branch) = 0  THEN NEXT.
    
    CREATE tuzpbrn.
    ASSIGN
        tuzpbrn.typeg   = brstat.uzpbrn.typeg     /*Group*/
        tuzpbrn.typcode = brstat.uzpbrn.typcode   /*SSB2B/SSB2C/WEBSERVICE*/
        tuzpbrn.type    = brstat.uzpbrn.type      /*Branch*/
        tuzpbrn.typpara = brstat.uzpbrn.typpara   /*Policy Type*/
        tuzpbrn.typname = brstat.uzpbrn.typname   /*Producer Code*/
        tuzpbrn.note1   = brstat.uzpbrn.note1  
        tuzpbrn.note2   = brstat.uzpbrn.note2  
        tuzpbrn.entid   = brstat.uzpbrn.entid  
        tuzpbrn.entime  = brstat.uzpbrn.entime 
        tuzpbrn.entdat  = brstat.uzpbrn.entdat
        tuzpbrn.notee   = brstat.uzpbrn.notee
        tuzpbrn.nrecid  = RECID(brstat.uzpbrn) 
        tuzpbrn.trndat  = uzpbrn.trndat  
        tuzpbrn.revtime = uzpbrn.revtime 
        tuzpbrn.revid   = uzpbrn.revid   .
    IF tuzpbrn.note1 = "Y" THEN tuzpbrn.note1des = "Auto Transfer".
    ELSE tuzpbrn.note1des = "Not Auto Transfer".


    CREATE tuzpbrn2.
    ASSIGN
        tuzpbrn2.typeg    = tuzpbrn.typeg  
        tuzpbrn2.typcode  = tuzpbrn.typcode
        tuzpbrn2.type     = tuzpbrn.type   
        tuzpbrn2.typpara  = tuzpbrn.typpara
        tuzpbrn2.typname  = tuzpbrn.typname
        tuzpbrn2.note1    = tuzpbrn.note1  
        tuzpbrn2.note2    = tuzpbrn.note2  
        tuzpbrn2.entid    = tuzpbrn.entid  
        tuzpbrn2.entime   = tuzpbrn.entime 
        tuzpbrn2.entdat   = tuzpbrn.entdat 
        tuzpbrn2.nrecid   = RECID(brstat.uzpbrn)
        tuzpbrn2.notee    = tuzpbrn.notee
        tuzpbrn2.trndat   = tuzpbrn.trndat      
        tuzpbrn2.revtime  = tuzpbrn.revtime     
        tuzpbrn2.revid    = tuzpbrn.revid 
        tuzpbrn2.note1des = tuzpbrn.note1des
        .
END.
//RUN wuw\wuwewait(INPUT 1).
FIND FIRST  tuzpbrn2 NO-LOCK NO-ERROR.
IF AVAIL  tuzpbrn2 THEN ENABLE ALL WITH FRAME fr_que1.
ELSE DISABLE ALL WITH FRAME fr_que1.
RUN pd_query(INPUT "").
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_clrfield C-Win 
PROCEDURE pd_clrfield :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN
    fi_inputcode1 = ""
    fi_codedes1   = ""
    fi_poltyp     = ""
    fi_poldes     = ""
    fi_brdesc     = ""
    nv_stac       = NO
    nv_status     = ""
    fi_iddes      = ""
    fi_iddes2     = ""
    fi_iddes3     = ""
    n_messer      = ""
    fi_search     = ""
    nv_recid      = ?
    ra_auto       = 1
    co_branch     = "".
DISP fi_brdesc co_branch fi_inputcode1 fi_codedes1 fi_poltyp  fi_poldes ra_auto WITH FRAME fr_input1.
DISP fi_iddes fi_iddes2 fi_iddes3  WITH FRAME fr_disp.
DISP fi_search WITH FRAME fr_que1.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_create1 C-Win 
PROCEDURE pd_create1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
IF nv_status = "create" THEN DO:
        FIND FIRST brstat.uzpbrn USE-INDEX uzpbrn02 WHERE 
            brstat.uzpbrn.typeg   = TRIM(nv_typeg)       and
            brstat.uzpbrn.typcode = TRIM(nv_typcode)     and
            brstat.uzpbrn.type    = TRIM(co_branch)      and
            brstat.uzpbrn.typpara = TRIM(fi_poltyp)      and
            brstat.uzpbrn.typname = TRIM(fi_inputcode1)  NO-LOCK NO-ERROR.
        IF NOT AVAILA brstat.uzpbrn THEN DO:
            CREATE brstat.uzpbrn.
            ASSIGN
                brstat.uzpbrn.typeg   = TRIM(nv_typeg)  
                brstat.uzpbrn.typcode = TRIM(nv_typcode)
                brstat.uzpbrn.type    = TRIM(co_branch)
                brstat.uzpbrn.typpara = TRIM(fi_poltyp)      
                brstat.uzpbrn.typname = TRIM(fi_inputcode1)  
                brstat.uzpbrn.entid   = USERID(LDBNAME(1))  
                brstat.uzpbrn.entime  = STRING(TIME,"HH:MM:SS")
                brstat.uzpbrn.entdat  = TODAY 
                nv_recid              = RECID(brstat.uzpbrn)
                .
            IF ra_auto = 1 THEN brstat.uzpbrn.note1 = "Y".
            ELSE brstat.uzpbrn.note1 = "N".
        END.
END.
ELSE IF nv_status = "edit" THEN DO:
        FIND  brstat.uzpbrn WHERE RECID(brstat.uzpbrn) = nv_recid NO-ERROR.
        IF AVAILA brstat.uzpbrn THEN DO:

            IF brstat.uzpbrn.revid <> "" THEN DO:
                ASSIGN
                    brstat.uzpbrn.notee[1] = STRING(brstat.uzpbrn.trndat,"99/99/9999")
                    brstat.uzpbrn.notee[2] = brstat.uzpbrn.revtime
                    brstat.uzpbrn.notee[3] = brstat.uzpbrn.revid  .

            END.
            ASSIGN
                brstat.uzpbrn.type    = TRIM(co_branch)
                brstat.uzpbrn.typpara = TRIM(fi_poltyp)      
                brstat.uzpbrn.typname = TRIM(fi_inputcode1)  
                brstat.uzpbrn.trndat  = TODAY
                brstat.uzpbrn.revtime = STRING(TIME,"HH:MM:SS")
                brstat.uzpbrn.revid   = USERID(LDBNAME(1))   .  
            IF ra_auto = 1 THEN brstat.uzpbrn.note1 = "Y".
            ELSE brstat.uzpbrn.note1 = "N".

                /*
                brstat.uzpbrn.entid   = USERID(LDBNAME(1))  
                brstat.uzpbrn.entime  = STRING(TIME,"HH:MM:SS")
                brstat.uzpbrn.entdat  = TODAY                   */ .
        END.
END. 
RUN pd_choose.
RUN pd_clrfield. 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_delete C-Win 
PROCEDURE pd_delete :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
IF nv_status = "delete" THEN DO:
    
        FIND brstat.uzpbrn WHERE RECID(brstat.uzpbrn) = nv_recid NO-ERROR.
        /*
        FIND FIRST brstat.uzpbrn USE-INDEX uzpbrn02 WHERE brstat.uzpbrn.typeg   = nv_typeg   AND 
                                                   brstat.uzpbrn.typcode = nv_typcode AND 
                                                   brstat.uzpbrn.type    = nv_choose  AND 
                                                   brstat.uzpbrn.typpara = TRIM(fi_inputcode1) NO-ERROR.*/
        IF AVAILA brstat.uzpbrn THEN DO:
            DELETE brstat.uzpbrn.
        END.
        FIND brstat.uzpbrn WHERE RECID(brstat.uzpbrn) = nv_recid NO-LOCK NO-ERROR.
        IF NOT AVAILA brstat.uzpbrn THEN MESSAGE "Delete Complete" VIEW-AS ALERT-BOX INFORMATION.
        ELSE MESSAGE "Delete Not Complete" VIEW-AS ALERT-BOX INFORMATION.
      
END.
RELEASE brstat.uzpbrn NO-ERROR.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_display C-Win 
PROCEDURE pd_display :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
RUN pd_branchdis.
ASSIGN
    nv_recid      = tuzpbrn2.nrecid
    co_branch     = tuzpbrn2.type 
    fi_inputcode1 = tuzpbrn2.typname
    fi_poltyp     = tuzpbrn2.typpara.
IF tuzpbrn2.note1 = "Y" THEN ra_auto = 1.
ELSE ra_auto = 2.
DISP co_branch fi_inputcode1 fi_poltyp ra_auto WITH FRAME fr_input1.
APPLY "leave" TO co_branch     IN FRAME fr_input1.
APPLY "leave" TO fi_inputcode1 IN FRAME fr_input1.
APPLY "leave" TO fi_poltyp     IN FRAME fr_input1.
ASSIGN
    fi_iddes   = ""
    fi_iddes2  = ""
    fi_iddes3  = ""
    fi_iddes3   = tuzpbrn2.entid  + "    " + STRING(tuzpbrn2.entdat,"99/99/9999") + "    " + tuzpbrn2.entime.
IF tuzpbrn2.notee[3]  <> "" THEN fi_iddes2  = tuzpbrn2.notee[3]  + "    " + tuzpbrn2.notee[1]  + "    " + tuzpbrn2.notee[2].
IF tuzpbrn2.revid <> "" THEN     fi_iddes   = tuzpbrn2.revid + "    " + STRING(tuzpbrn2.trndat,"99/99/9999") + "    " + tuzpbrn2.revtime.



DISP fi_iddes fi_iddes2 fi_iddes3 WITH FRAME fr_disp.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_pararun C-Win 
PROCEDURE pd_pararun :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR n_pgid AS CHAR INIT "".

FOR EACH sicsyac.sym100 USE-INDEX sym10001 WHERE sym100.tabcod >= "UWS02" AND 
                                         sym100.tabcod <= "UWSZZ" NO-LOCK:
    FIND tsym100 WHERE tsym100.itmcod = sym100.itmcod NO-ERROR.
    IF NOT AVAILA tsym100 THEN DO:
        CREATE tsym100.
        ASSIGN
           //tsym100.tabcod = sym100.tabcod
            tsym100.itmcod = sym100.itmcod 
            tsym100.itmdes = sym100.itmdes.
        /*IF n_pgid = "" THEN n_pgid = sym100.itmdes + "," + sym100.itmcod.
        ELSE n_pgid = n_pgid + "," + sym100.itmdes + "," + sym100.itmcod.*/
    END.
END.
/*---
DO WITH FRAME fr_head:
    cb_pgid:LIST-ITEM-PAIRS IN FRAME fr_head = n_pgid.
    cb_pgid = ENTRY(2,n_pgid).
    DISP cb_pgid WITH FRAME fr_head.
END. */
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_query C-Win 
PROCEDURE pd_query :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF INPUT PARAMETER nv_s AS CHAR INIT "".
DEF VAR nv_qnormal AS LOGICAL INIT NO.
IF nv_status  <> "" AND nv_recid <> ? THEN DO:
    IF ra_search = 1 THEN DO:
        OPEN QUERY br_que1 FOR EACH tuzpbrn2 by  tuzpbrn2.type   by  tuzpbrn2.typpara  by  tuzpbrn2.typname .
        FIND  tuzpbrn2  WHERE tuzpbrn2.nrecid  = nv_recid  NO-LOCK NO-ERROR.
        IF AVAIL tuzpbrn2 THEN REPOSITION br_que1 TO RECID RECID(tuzpbrn2).
        ELSE DO: 
            MESSAGE "Branch code not found !" VIEW-AS ALERT-BOX INFORMATION.
            fi_search = "".
            DISPLAY fi_search WITH FRAME fr_que1.
        END.
    END.
    ELSE IF ra_search = 2 THEN DO:
        OPEN QUERY br_que1 FOR EACH tuzpbrn2 by  tuzpbrn2.typpara by  tuzpbrn2.type     by  tuzpbrn2.typname .
        FIND  tuzpbrn2  WHERE tuzpbrn2.nrecid  = nv_recid NO-LOCK NO-ERROR.
        IF AVAIL tuzpbrn2 THEN REPOSITION br_que1 TO RECID RECID(tuzpbrn2).
        ELSE DO: 
            MESSAGE "Policy Type Not Found !" VIEW-AS ALERT-BOX INFORMATION.
            fi_search = "".
            DISPLAY fi_search WITH FRAME fr_que1.
        END.
    END.
    ELSE DO: 
        OPEN QUERY br_que1 FOR EACH tuzpbrn2  by  tuzpbrn2.typname by  tuzpbrn2.type   by  tuzpbrn2.typpara  .
        FIND  tuzpbrn2  WHERE tuzpbrn2.nrecid  = nv_recid NO-LOCK NO-ERROR.
        IF AVAIL tuzpbrn2 THEN REPOSITION br_que1 TO RECID RECID(tuzpbrn2).
        ELSE DO: 
            MESSAGE "Producer Code Not Found !" VIEW-AS ALERT-BOX INFORMATION.
            fi_search = "".
            DISPLAY fi_search WITH FRAME fr_que1.
        END.
        
    END.

END.
ELSE IF nv_s <> "" THEN DO:
    //MESSAGE "AA" SKIP  fi_search  VIEW-AS ALERT-BOX.
    IF ra_search = 1 THEN DO:
        OPEN QUERY br_que1 FOR EACH tuzpbrn2 by  tuzpbrn2.type   by  tuzpbrn2.typpara  by  tuzpbrn2.typname .
        FIND FIRST  tuzpbrn2  WHERE tuzpbrn2.type BEGINS fi_search NO-LOCK NO-ERROR.
        IF AVAIL tuzpbrn2 THEN REPOSITION br_que1 TO RECID RECID(tuzpbrn2).
        ELSE DO: 
            MESSAGE "Branch code not found !" VIEW-AS ALERT-BOX INFORMATION.
            fi_search = "".
            DISPLAY fi_search WITH FRAME fr_que1.
        END.
    END.
    ELSE IF ra_search = 2 THEN DO:
        OPEN QUERY br_que1 FOR EACH tuzpbrn2 by  tuzpbrn2.typpara by  tuzpbrn2.type     by  tuzpbrn2.typname .
        FIND FIRST  tuzpbrn2  WHERE tuzpbrn2.typpara BEGINS fi_search NO-LOCK NO-ERROR.
        IF AVAIL tuzpbrn2 THEN REPOSITION br_que1 TO RECID RECID(tuzpbrn2).
        ELSE DO: 
            MESSAGE "Policy Type Not Found !" VIEW-AS ALERT-BOX INFORMATION.
            fi_search = "".
            DISPLAY fi_search WITH FRAME fr_que1.
        END.
    END.
    ELSE DO: 
        OPEN QUERY br_que1 FOR EACH tuzpbrn2  by  tuzpbrn2.typname by  tuzpbrn2.type   by  tuzpbrn2.typpara  .
        FIND FIRST tuzpbrn2  WHERE tuzpbrn2.typname BEGINS fi_search NO-LOCK NO-ERROR.
        IF AVAIL tuzpbrn2 THEN REPOSITION br_que1 TO RECID RECID(tuzpbrn2).
        ELSE DO: 
            MESSAGE "Producer Code Not Found !" VIEW-AS ALERT-BOX INFORMATION.
            fi_search = "".
            DISPLAY fi_search WITH FRAME fr_que1.
        END.
        
    END.
        

END.
ELSE nv_qnormal = YES.
IF nv_qnormal THEN DO:
    IF ra_search = 1      THEN OPEN QUERY br_que1 FOR EACH tuzpbrn2 by  tuzpbrn2.type   by  tuzpbrn2.typpara  by  tuzpbrn2.typname.
    ELSE IF ra_search = 2 THEN OPEN QUERY br_que1 FOR EACH tuzpbrn2 by  tuzpbrn2.typpara by  tuzpbrn2.type    by  tuzpbrn2.typname .
    ELSE OPEN QUERY br_que1 FOR EACH tuzpbrn2 by  tuzpbrn2.typname by  tuzpbrn2.type   by  tuzpbrn2.typpara  .
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

