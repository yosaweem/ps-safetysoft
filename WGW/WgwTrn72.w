&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          sic_bran         PROGRESS
*/
&Scoped-define WINDOW-NAME wgwtrn72
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS wgwtrn72 
/*************************************************************************
 WGWTRN72.W : Query Batch No Transfer Compulsory To Premium
 Copyright  : Safety Insurance Public Company Limited
              บริษัท ประกันคุ้มภัย จำกัด (มหาชน)
 ------------------------------------------------------------------------                 
 Database   : GW_SAFE - LD SIC_BRAN ;GW_STAT -LD BRSTAT
 ------------------------------------------------------------------------                
 CREATE BY  : Watsana K.   ASSIGN: A56-0299        DATE: 15/10/2013
 *************************************************************************/
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

DEF VAR nv_Recuwm100 AS RECID.
DEF VAR n_insref  AS CHAR FORMAT "x(10)" .

DEF SHARED VAR n_user     AS   CHAR.
DEF SHARED VAR nv_recid     AS RECID . 
DEF SHARED VAR nv_recid1    AS RECID . 

DEF VAR nv_duprec100 AS LOGICAL.

DEF VAR nv_batchyr   AS INT.
DEF VAR nv_batchno   AS CHAR.
DEF VAR nv_batcnt    AS INT.

DEF VAR nv_total     AS CHAR.
DEF VAR nv_start     AS CHAR.
DEF VAR nv_timestart AS INT.
DEF VAR nv_timeend   AS INT.
DEF VAR nv_polmst    AS CHAR.
DEF VAR nv_brnfile   AS CHAR. 
DEF VAR nv_duprec    AS CHAR. 
DEF VAR nv_Insno     AS CHAR.

DEF VAR nv_Policy   AS CHAR.
DEF VAR nv_RenCnt   AS INT.
DEF VAR nv_EndCnt   AS INT.
DEF VAR nv_Branch   AS CHAR.
DEF VAR nv_next     AS LOGICAL.
DEF  VAR nv_message  AS CHAR FORMAT "X(200)".
DEF  VAR putchr      AS CHAR FORMAT "X(100)" INIT "" NO-UNDO.
DEF  VAR putchr1     AS CHAR FORMAT "X(80)"  INIT "" NO-UNDO.
DEF  VAR textchr     AS CHAR FORMAT "X(80)"  INIT "" NO-UNDO.
DEF VAR nv_trferr   AS CHAR FORMAT "X(80)"  INIT "" NO-UNDO.


DEF VAR nv_errfile AS CHAR FORMAT "X(30)"  INIT "" NO-UNDO.
DEF VAR nv_error   AS LOGICAL    INIT NO     NO-UNDO.

DEF BUFFER wk_uwm100 FOR sic_bran.uwm100.
DEF NEW SHARED STREAM ns1.
DEF NEW SHARED STREAM ns2.
DEF NEW SHARED STREAM ns3.

DEF VAR n_pass     AS LOGICAL INITIAL NO.
DEF VAR n_total    AS INTEGER INIT 0.
DEF VAR n_success  AS INTEGER INIT 0.
DEF VAR n_fail     AS INTEGER INIT 0.
DEF VAR n_trndatfr AS DATE    INIT ? .
DEF VAR n_trndatto AS DATE    INIT ? .
DEF VAR nv_batch   AS CHAR    FORMAT "x(30)" INIT "" .

DEF WORKFILE wk_batch 
     FIELDS n_policy AS CHAR FORMAT "x(16)"
     FIELDS n_bchyr  AS INTEGER
     FIELDS n_bchno  AS CHAR FORMAT "x(25)"
     FIELDS n_bchcnt AS INTEGER 
     FIELDS n_trndat AS DATE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main
&Scoped-define BROWSE-NAME br_Uwm100

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES uwm100

/* Definitions for BROWSE br_Uwm100                                     */
&Scoped-define FIELDS-IN-QUERY-br_Uwm100 uwm100.trndat uwm100.policy ~
string(RenCnt,"99") + "/" +  String(EndCnt,"999") ntitle + " "  + name1 ~
uwm100.trty11 uwm100.agent uwm100.acno1 uwm100.bchyr uwm100.bchno ~
uwm100.bchcnt uwm100.releas uwm100.trfflg 
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_Uwm100 
&Scoped-define QUERY-STRING-br_Uwm100 FOR EACH uwm100 NO-LOCK ~
    BY uwm100.trndat INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-br_Uwm100 OPEN QUERY br_Uwm100 FOR EACH uwm100 NO-LOCK ~
    BY uwm100.trndat INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-br_Uwm100 uwm100
&Scoped-define FIRST-TABLE-IN-QUERY-br_Uwm100 uwm100


/* Definitions for FRAME fr_main                                        */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS cb_search fi_companycode fi_fail fi_success ~
fi_total cb_select fi_acno bu_refresh fi_Policyfr fi_Policyto fi_Branch ~
bu_exit bu_Transfer br_Uwm100 fi_brdesc fi_brnfile fi_TranPol fi_dupfile ~
fi_strTime fi_time fi_TotalTime fi_File RECT-1 RECT-636 RECT-2 RECT-640 ~
RECT-649 RECT-3 
&Scoped-Define DISPLAYED-OBJECTS cb_search fi_companycode fi_fail ~
fi_success fi_total cb_select fi_acno fi_Policyfr fi_Policyto fi_Branch ~
fi_brdesc fi_brnfile fi_TranPol fi_dupfile fi_strTime fi_time fi_TotalTime ~
fi_File 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR wgwtrn72 AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bu_exit 
     LABEL "EXIT" 
     SIZE 16 BY 1.43
     BGCOLOR 27 FONT 6.

DEFINE BUTTON bu_refresh 
     LABEL "Search" 
     SIZE 12 BY 1.24
     BGCOLOR 27 FONT 6.

DEFINE BUTTON bu_Transfer 
     LABEL "TRANSFER TO PREMIUN" 
     SIZE 32.33 BY 1.43
     BGCOLOR 27 FONT 6.

DEFINE VARIABLE cb_search AS CHARACTER FORMAT "X(30)":U 
     LABEL "Searchby" 
     VIEW-AS COMBO-BOX INNER-LINES 2
     LIST-ITEMS "Tran.Date","Producer Code" 
     DROP-DOWN-LIST
     SIZE 18 BY 1
     FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE cb_select AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 3
     LIST-ITEMS "Tran.Date","Producer Code","Policy" 
     DROP-DOWN-LIST
     SIZE 20 BY 1
     FONT 6 NO-UNDO.

DEFINE VARIABLE fi_acno AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 15.83 BY 1
     FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_Branch AS CHARACTER FORMAT "X(2)":U 
      VIEW-AS TEXT 
     SIZE 5.17 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_brdesc AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 26.83 BY 1
     BGCOLOR 8 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_brnfile AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 50 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_companycode AS CHARACTER FORMAT "X(60)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_dupfile AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 50 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_fail AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
      VIEW-AS TEXT 
     SIZE 8 BY 1
     BGCOLOR 18 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_File AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 50 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_Policyfr AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 23 BY 1
     FONT 6 NO-UNDO.

DEFINE VARIABLE fi_Policyto AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 23 BY 1
     FONT 6 NO-UNDO.

DEFINE VARIABLE fi_strTime AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 12 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_success AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
      VIEW-AS TEXT 
     SIZE 8 BY 1
     BGCOLOR 20 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_time AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 12 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_total AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
      VIEW-AS TEXT 
     SIZE 9 BY 1
     BGCOLOR 20 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_TotalTime AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 12 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_TranPol AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 50 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132.67 BY 1.29
     BGCOLOR 28 .

DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 19 BY 2.14
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-3
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 35.5 BY 2.14
     BGCOLOR 28 .

DEFINE RECTANGLE RECT-636
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132 BY 20.81
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-640
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 15.17 BY 1.62
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-649
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 74.17 BY 8.24
     BGCOLOR 8 FGCOLOR 0 .

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_Uwm100 FOR 
      uwm100 SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_Uwm100
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_Uwm100 wgwtrn72 _STRUCTURED
  QUERY br_Uwm100 NO-LOCK DISPLAY
      uwm100.trndat COLUMN-LABEL "Trn Date" FORMAT "99/99/9999":U
            WIDTH 10
      uwm100.policy COLUMN-LABEL "Policy No" FORMAT "x(18)":U
      string(RenCnt,"99") + "/" +  String(EndCnt,"999") COLUMN-LABEL "R/E"
            WIDTH 7
      ntitle + " "  + name1 COLUMN-LABEL "Insure" FORMAT "X(30)":U
      uwm100.trty11 COLUMN-LABEL "Type1" FORMAT "x":U WIDTH 5
      uwm100.agent COLUMN-LABEL "Agent Code" FORMAT "x(10)":U
      uwm100.acno1 COLUMN-LABEL "Account no." FORMAT "x(10)":U
      uwm100.bchyr COLUMN-LABEL "Bch Year" FORMAT "9999":U WIDTH 8
      uwm100.bchno COLUMN-LABEL "Bch No." FORMAT "X(13)":U WIDTH 16
      uwm100.bchcnt COLUMN-LABEL "Batch Cnt." FORMAT "99":U WIDTH 9
      uwm100.releas COLUMN-LABEL "Releas" FORMAT "Yes/No":U
      uwm100.trfflg COLUMN-LABEL "TranToPrem" FORMAT "yes/no":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 130 BY 11.91 ROW-HEIGHT-CHARS .6 FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     cb_search AT ROW 2.52 COL 80.83 COLON-ALIGNED
     fi_companycode AT ROW 2.52 COL 15.5 COLON-ALIGNED NO-LABEL
     fi_fail AT ROW 20.67 COL 82.33 COLON-ALIGNED NO-LABEL
     fi_success AT ROW 20.67 COL 102.67 COLON-ALIGNED NO-LABEL
     fi_total AT ROW 20.67 COL 120.33 COLON-ALIGNED NO-LABEL
     cb_select AT ROW 18 COL 76.67 COLON-ALIGNED NO-LABEL
     fi_acno AT ROW 2.52 COL 99.5 COLON-ALIGNED NO-LABEL
     bu_refresh AT ROW 2.43 COL 120.17
     fi_Policyfr AT ROW 17.86 COL 106.67 COLON-ALIGNED NO-LABEL
     fi_Policyto AT ROW 19.05 COL 106.67 COLON-ALIGNED NO-LABEL
     fi_Branch AT ROW 2.52 COL 39 COLON-ALIGNED NO-LABEL
     bu_exit AT ROW 22.57 COL 115.17
     bu_Transfer AT ROW 22.62 COL 79.5
     br_Uwm100 AT ROW 4.14 COL 2.33
     fi_brdesc AT ROW 2.52 COL 44.67 COLON-ALIGNED NO-LABEL
     fi_brnfile AT ROW 17.76 COL 23.5 COLON-ALIGNED NO-LABEL
     fi_TranPol AT ROW 19 COL 23.33 COLON-ALIGNED NO-LABEL
     fi_dupfile AT ROW 21.52 COL 23.33 COLON-ALIGNED NO-LABEL
     fi_strTime AT ROW 22.81 COL 23.33 COLON-ALIGNED NO-LABEL
     fi_time AT ROW 22.81 COL 41.33 COLON-ALIGNED NO-LABEL
     fi_TotalTime AT ROW 22.81 COL 61.33 COLON-ALIGNED NO-LABEL
     fi_File AT ROW 20.24 COL 23.33 COLON-ALIGNED NO-LABEL
     "From" VIEW-AS TEXT
          SIZE 6.17 BY .95 AT ROW 17.95 COL 101.17
          BGCOLOR 19 FONT 6
     "Total:" VIEW-AS TEXT
          SIZE 7 BY 1 AT ROW 20.67 COL 114.17
          FGCOLOR 0 FONT 6
     "Success:" VIEW-AS TEXT
          SIZE 10 BY 1 AT ROW 20.67 COL 93.83
          FGCOLOR 0 FONT 6
     "Fail:" VIEW-AS TEXT
          SIZE 5 BY 1 AT ROW 20.67 COL 78.5
          FGCOLOR 0 FONT 6
     "Total" VIEW-AS TEXT
          SIZE 5.83 BY .95 AT ROW 22.81 COL 56.67
          BGCOLOR 8 FGCOLOR 0 FONT 6
     "End" VIEW-AS TEXT
          SIZE 4 BY .95 AT ROW 22.86 COL 38.17
          BGCOLOR 8 FGCOLOR 0 FONT 6
     "    Show Detail Transfer" VIEW-AS TEXT
          SIZE 73.5 BY .95 AT ROW 16.48 COL 2.5
          BGCOLOR 28 FONT 6
     "   Policy Transfer" VIEW-AS TEXT
          SIZE 55 BY .95 AT ROW 16.38 COL 77
          BGCOLOR 28 FONT 6
     "Branch:" VIEW-AS TEXT
          SIZE 8.17 BY 1 AT ROW 2.57 COL 32.67
          FGCOLOR 0 FONT 6
     "Query Batch No Transfer Compulsory To Premium" VIEW-AS TEXT
          SIZE 53.5 BY .91 AT ROW 1.24 COL 42.83
          BGCOLOR 28 FGCOLOR 0 FONT 6
     "Company Code:" VIEW-AS TEXT
          SIZE 15 BY 1 AT ROW 2.52 COL 2
          FGCOLOR 0 FONT 6
     "To" VIEW-AS TEXT
          SIZE 3.17 BY .95 AT ROW 19.14 COL 103.17
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "Update File" VIEW-AS TEXT
          SIZE 11 BY .95 AT ROW 20.24 COL 13.5
          BGCOLOR 8 FGCOLOR 0 FONT 6
     "Policy No. Dup. to file" VIEW-AS TEXT
          SIZE 21.17 BY .95 AT ROW 21.48 COL 3.67
          BGCOLOR 8 FGCOLOR 0 FONT 6
     "Transfer policy" VIEW-AS TEXT
          SIZE 14.5 BY .95 AT ROW 19 COL 10.17
          BGCOLOR 8 FONT 6
     "Policy No. Write to file" VIEW-AS TEXT
          SIZE 22 BY .95 AT ROW 17.76 COL 3
          BGCOLOR 8 FONT 6
     "Start Time" VIEW-AS TEXT
          SIZE 10.5 BY .95 AT ROW 22.86 COL 14.67
          BGCOLOR 8 FGCOLOR 0 FONT 6
     RECT-1 AT ROW 1.05 COL 1.33
     RECT-636 AT ROW 3.86 COL 1.5
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133.17 BY 23.86.

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     RECT-2 AT ROW 22.24 COL 131.5 RIGHT-ALIGNED
     RECT-640 AT ROW 2.24 COL 118.5
     RECT-649 AT ROW 16.24 COL 2.33
     RECT-3 AT ROW 22.24 COL 112.5 RIGHT-ALIGNED
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133.17 BY 23.86.


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
  CREATE WINDOW wgwtrn72 ASSIGN
         HIDDEN             = YES
         TITLE              = "wgwtrn72 : Query Batch No Transfer Compulsory To Premium"
         HEIGHT             = 23.86
         WIDTH              = 133.17
         MAX-HEIGHT         = 24
         MAX-WIDTH          = 141.83
         VIRTUAL-HEIGHT     = 24
         VIRTUAL-WIDTH      = 141.83
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
IF NOT wgwtrn72:LOAD-ICON("wimage/iconhead.ico":U) THEN
    MESSAGE "Unable to load icon: wimage/iconhead.ico"
            VIEW-AS ALERT-BOX WARNING BUTTONS OK.
&ENDIF
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW wgwtrn72
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME fr_main
   FRAME-NAME Custom                                                    */
/* BROWSE-TAB br_Uwm100 bu_Transfer fr_main */
/* SETTINGS FOR RECTANGLE RECT-2 IN FRAME fr_main
   ALIGN-R                                                              */
/* SETTINGS FOR RECTANGLE RECT-3 IN FRAME fr_main
   ALIGN-R                                                              */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(wgwtrn72)
THEN wgwtrn72:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_Uwm100
/* Query rebuild information for BROWSE br_Uwm100
     _TblList          = "sic_bran.uwm100"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _OrdList          = "sic_bran.uwm100.trndat|yes"
     _FldNameList[1]   > sic_bran.uwm100.trndat
"uwm100.trndat" "Trn Date" ? "date" ? ? ? ? ? ? no ? no no "10" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[2]   > sic_bran.uwm100.policy
"uwm100.policy" "Policy No" "x(18)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   > "_<CALC>"
"string(RenCnt,""99"") + ""/"" +  String(EndCnt,""999"")" "R/E" ? ? ? ? ? ? ? ? no ? no no "7" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   > "_<CALC>"
"ntitle + "" ""  + name1" "Insure" "X(30)" ? ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   > sic_bran.uwm100.trty11
"uwm100.trty11" "Type1" ? "character" ? ? ? ? ? ? no ? no no "5" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[6]   > sic_bran.uwm100.agent
"uwm100.agent" "Agent Code" "x(10)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[7]   > sic_bran.uwm100.acno1
"uwm100.acno1" "Account no." "x(10)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[8]   > sic_bran.uwm100.bchyr
"uwm100.bchyr" "Bch Year" ? "integer" ? ? ? ? ? ? no ? no no "8" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[9]   > sic_bran.uwm100.bchno
"uwm100.bchno" "Bch No." ? "character" ? ? ? ? ? ? no ? no no "16" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[10]   > sic_bran.uwm100.bchcnt
"uwm100.bchcnt" "Batch Cnt." ? "integer" ? ? ? ? ? ? no ? no no "9" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[11]   > sic_bran.uwm100.releas
"uwm100.releas" "Releas" "Yes/No" "logical" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[12]   > sic_bran.uwm100.trfflg
"uwm100.trfflg" "TranToPrem" ? "logical" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _Query            is NOT OPENED
*/  /* BROWSE br_Uwm100 */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME wgwtrn72
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wgwtrn72 wgwtrn72
ON END-ERROR OF wgwtrn72 /* wgwtrn72 : Query Batch No Transfer Compulsory To Premium */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wgwtrn72 wgwtrn72
ON WINDOW-CLOSE OF wgwtrn72 /* wgwtrn72 : Query Batch No Transfer Compulsory To Premium */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_exit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_exit wgwtrn72
ON CHOOSE OF bu_exit IN FRAME fr_main /* EXIT */
DO:
APPLY  "CLOSE"  TO THIS-PROCEDURE.
RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_refresh
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_refresh wgwtrn72
ON CHOOSE OF bu_refresh IN FRAME fr_main /* Search */
DO:
    DO WITH FRAME fr_main:
        cb_search = INPUT cb_search.
        DISP cb_search .

        RUN PDUpdateQ.
    END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_Transfer
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_Transfer wgwtrn72
ON CHOOSE OF bu_Transfer IN FRAME fr_main /* TRANSFER TO PREMIUN */
DO:
/* sic_bran = gw_Safe
   brStat   = gw_sate */

ASSIGN
 fi_brnfile   = ""
 fi_TranPol   = ""
 fi_File      = ""
 fi_dupfile   = "" 
 fi_strTime   = "" 
 fi_time      = "" 
 fi_TotalTime = ""
 nv_Insno   = ""
 nv_total     = ""
 nv_start     = STRING(TIME,"HH:MM:SS")
 fi_strTime   = STRING(TIME,"HH:MM:SS")
 nv_timestart = TIME
 nv_timeend   = TIME
 nv_polmst    = ""
 n_insref     = "" 
 n_fail       = 0
 n_success    = 0
 n_total      = 0 .

ASSIGN 
 cb_select    = INPUT cb_select
 fi_policyfr  = INPUT fi_policyfr
 fi_policyto  = INPUT fi_policyto  
 fi_acno      = INPUT fi_acno  .
 
 nv_errfile   = "C:\GWTRANF\" +                    
                       STRING(MONTH(TODAY),"99")    + 
                       STRING(DAY(TODAY),"99")      + 
             SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) + 
             SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2) + ".err".
nv_brnfile   = "C:\GWTRANF\" + 
                       STRING(MONTH(TODAY),"99")    +
                       STRING(DAY(TODAY),"99")      +
             SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) +
             SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2) + ".fuw".
nv_duprec    = "C:\GWTRANF\" +                  
                       STRING(MONTH(TODAY),"99")    + 
                       STRING(DAY(TODAY),"99")      + 
             SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) + 
             SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2) + ".dup".    

OUTPUT STREAM ns1 TO VALUE(nv_errfile).
OUTPUT STREAM ns2 TO VALUE(nv_brnfile).
OUTPUT STREAM ns3 TO VALUE(nv_duprec). 

/*---Header Err---*/
PUT STREAM ns1
    "Transfer Error  "
    "Transfer Date : " TODAY  FORMAT "99/99/9999"
    "  Time : " STRING(TIME,"HH:MM:SS") 
    "  Batch File : " nv_batchyr "/" nv_batchno "/" nv_batcnt SKIP.  
PUT STREAM ns1 FILL("-",90) FORMAT "X(90)" SKIP.
PUT STREAM ns1 "Policy No.       R / E   Error " SKIP.
/*---Header fuw---*/
PUT STREAM ns2
    "Transfer Complete   "
    "Transfer Date : " TODAY  FORMAT "99/99/9999"
    "  Time : " STRING(TIME,"HH:MM:SS") 
 /*   "  Batch File : " nv_batchyr "/" nv_batchno "/" nv_batcnt */ SKIP.
PUT STREAM ns2 FILL("-",100) FORMAT "X(100)" SKIP.
PUT STREAM ns2 "Ceding Pol.       Policy No.        R/E    Trn.Date    Ent.Date    UserID   Insure Name  Batch File" SKIP.
/*---Header Dup---*/
PUT STREAM ns3
"Transfer Duplicate   "
"Transfer Date : " TODAY  FORMAT "99/99/9999"
"  Time : " STRING(TIME,"HH:MM:SS") 
/* "  Batch File : " nv_batchyr "/" nv_batchno "/" nv_batcnt */ SKIP.
PUT STREAM ns3 FILL("-",100) FORMAT "X(100)" SKIP.
PUT STREAM ns3 "Error          Policy No.        R/E    Trn.Date    Ent.Date    UserID    Insure Name  Batch File " SKIP.
/*----------------*/
n_pass = NO.
FOR EACH wk_batch .
    DELETE wk_batch.
END.

IF cb_select = "Tran.Date" THEN DO:
    
    ASSIGN n_trndatfr = DATE(fi_policyfr)
           n_trndatto = DATE(fi_policyto).
   

    FOR EACH   sic_bran.uwm100 NO-LOCK USE-INDEX  uwm10008
        WHERE  sic_bran.uwm100.trndat >= n_trndatfr
        AND    sic_bran.uwm100.trndat <= n_trndatto
        AND    sic_bran.uwm100.branch  = nv_branch
        AND    sic_bran.uwm100.prog    = "WGWTLTGN"
    BREAK  BY sic_bran.uwm100.trndat
           BY sic_bran.uwm100.Policy
           BY sic_bran.uwm100.bchno
           BY sic_bran.uwm100.bchcnt .
        

        IF LAST-OF(sic_bran.uwm100.policy)  THEN DO:
            FIND FIRST wk_batch WHERE wk_batch.n_policy = sic_bran.uwm100.policy
            NO-ERROR .
            IF NOT AVAIL wk_batch THEN DO:
                CREATE wk_batch.
                ASSIGN 
                    wk_batch.n_policy = sic_bran.uwm100.policy
                    wk_batch.n_bchyr  = sic_bran.uwm100.bchyr
                    wk_batch.n_bchno  = sic_bran.uwm100.bchno
                    wk_batch.n_bchcnt = sic_bran.uwm100.bchcnt 
                    wk_batch.n_trndat = sic_bran.uwm100.trndat .
                n_total = n_total + 1.
            END.
        END.
    END.

END.
ELSE IF cb_select = "Producer Code"  THEN DO:
    FOR EACH   sic_bran.uwm100 NO-LOCK USE-INDEX  uwm10094
        WHERE  sic_bran.uwm100.Acno1 >= fi_Policyfr
        AND    sic_bran.uwm100.Acno1 <= fi_Policyto
        AND    sic_bran.uwm100.branch = nv_branch
        AND    sic_bran.uwm100.prog   = "WGWTLTGN"
    BREAK  BY sic_bran.uwm100.Acno1
           BY sic_bran.uwm100.Policy
           BY sic_bran.uwm100.bchno
           BY sic_bran.uwm100.bchcnt .

        IF LAST-OF(sic_bran.uwm100.policy)  THEN DO:
            FIND FIRST wk_batch WHERE wk_batch.n_policy = sic_bran.uwm100.policy
            NO-ERROR .
            IF NOT AVAIL wk_batch THEN DO:
                CREATE wk_batch.
                ASSIGN 
                    wk_batch.n_policy = sic_bran.uwm100.policy
                    wk_batch.n_bchyr  = sic_bran.uwm100.bchyr
                    wk_batch.n_bchno  = sic_bran.uwm100.bchno
                    wk_batch.n_bchcnt = sic_bran.uwm100.bchcnt 
                    wk_batch.n_trndat = sic_bran.uwm100.trndat .
                n_total = n_total + 1.
            END.
        END.
    END.
END.
ELSE IF cb_select = "Policy" THEN DO:
    
    FOR EACH  sic_bran.uwm100 NO-LOCK USE-INDEX  uwm10001
        WHERE sic_bran.uwm100.policy >= fi_Policyfr
        AND   sic_bran.uwm100.policy <= fi_Policyto
        AND   sic_bran.uwm100.branch  = nv_branch
        AND   sic_bran.uwm100.prog    = "WGWTLTGN"
    BREAK  BY sic_bran.uwm100.Policy
           BY sic_bran.uwm100.bchno
           BY sic_bran.uwm100.bchcnt .

        IF LAST-OF(sic_bran.uwm100.policy)  THEN DO:
                FIND FIRST wk_batch WHERE wk_batch.n_policy = sic_bran.uwm100.policy
                NO-ERROR .
                IF NOT AVAIL wk_batch THEN DO:
                    CREATE wk_batch.
                    ASSIGN 
                        wk_batch.n_policy = sic_bran.uwm100.policy
                        wk_batch.n_bchyr  = sic_bran.uwm100.bchyr
                        wk_batch.n_bchno  = sic_bran.uwm100.bchno
                        wk_batch.n_bchcnt = sic_bran.uwm100.bchcnt .
                    n_total = n_total + 1.
                END.
        END.
    END.
END.


FOR EACH wk_batch NO-LOCK.
  /*  n_total = n_total + 1. */
    
    FIND FIRST sic_bran.uwm100 USE-INDEX uwm10020 
         WHERE sic_bran.uwm100.bchyr    = wk_batch.n_bchyr 
           AND sic_bran.uwm100.bchno    = wk_batch.n_bchno 
           AND sic_bran.uwm100.bchcnt   = wk_batch.n_bchcnt
           AND sic_bran.uwm100.policy   = wk_batch.n_policy 
    NO-LOCK NO-ERROR.
    IF AVAIL sic_bran.uwm100 THEN DO:
       
        ASSIGN
         nv_batchyr = sic_bran.uwm100.bchyr
         nv_batchno = sic_bran.uwm100.bchNo 
         nv_batcnt  = sic_bran.uwm100.bchCnt
         nv_Policy  = sic_bran.uwm100.Policy
         nv_RenCnt  = sic_bran.uwm100.RenCnt
         nv_EndCnt  = sic_bran.uwm100.EndCnt
         nv_Insno   = sic_bran.uwm100.insref.

        /*--Check batch--*/
         IF nv_batchyr <= 0  THEN DO:
            MESSAGE "Batch Year Error...!!" VIEW-AS ALERT-BOX.
            RETURN NO-APPLY.
         END.
         IF nv_batchno = ""  THEN DO:
            MESSAGE "Batch No can't blank..!!" VIEW-AS ALERT-BOX.
            RETURN NO-APPLY.
         END.
         ELSE DO:
            FIND LAST uzm701 USE-INDEX uzm70102
               WHERE uzm701.bchyr = nv_batchyr AND 
                     uzm701.bchno = nv_batchno NO-LOCK NO-ERROR.
            IF NOT AVAIL uzm701 THEN DO:
              MESSAGE "Not found Batch File Master on file uzm701" VIEW-AS ALERT-BOX.
              RETURN NO-APPLY.
            END.
            ELSE DO:
              IF uzm701.bchyr <> nv_batchyr THEN DO:
                 MESSAGE "Not found Batch File Master on file uzm701 (Year)" VIEW-AS ALERT-BOX.
                 RETURN NO-APPLY.
              END.
            END.
         END.
         IF nv_batcnt <= 0  THEN DO:
            MESSAGE "Batch Count error..!!" VIEW-AS ALERT-BOX.
            RETURN NO-APPLY.
         END.
         FIND LAST uzm701 USE-INDEX uzm70102
             WHERE uzm701.bchyr   =  nv_batchyr AND
                   uzm701.bchno   =  nv_batchno AND
                   uzm701.bchcnt  =  nv_batcnt  NO-ERROR.
         IF NOT AVAIL uzm701 THEN DO:
             MESSAGE "Batch No./Count " nv_batchno "/" nv_batcnt " not found" VIEW-AS ALERT-BOX.
             RETURN NO-APPLY.
         END.
         ELSE DO:
                 /*--- เช็ค Batch status = Yes จึงจะให้ transfer batch no ได้ ---*/
             IF  uzm701.cnfflg = NO  THEN DO: 
                 MESSAGE "Batch Status Not Complete..!!" VIEW-AS ALERT-BOX.                  
                 RETURN NO-APPLY.
             END.
             /*--- เช็ค trfflg = Yes แสดงว่ามีการ transfer แล้ว ---*/
             IF uzm701.trfflg = YES THEN DO:
                 MESSAGE "This Batch No. used transfer to Premium..!!" VIEW-AS ALERT-BOX.         
                 RETURN NO-APPLY.
             END.
             ASSIGN
             sic_bran.uzm701.trfbegtim = STRING(TIME,"HH:MM:SS")
             fi_brnfile = nv_brnfile
             fi_dupfile = nv_duprec.
             DISP fi_brnfile fi_dupfile  fi_strTime WITH FRAME fr_main.
        
             ASSIGN
              nv_error = NO
              fi_TranPol =  STRING(sic_bran.uwm100.Policy,"XX-XX-XX/XXXXXX") + " " + 
                            STRING(sic_bran.uwm100.RenCnt,"99") + "/" +
                            STRING(sic_bran.uwm100.EndCnt,"999") + "      " +
                            sic_bran.uwm100.Name1
        
              fi_time = STRING(TIME,"HH:MM:SS").
              nv_timeend   = TIME.
            
              nv_RecUwm100 = RECID(sic_bran.uwm100).
              
              DISPLAY  "xmm600" @ fi_File WITH FRAME fr_main.
              RUN wgw\wgwnamins (INPUT nv_RecUwm100,OUTPUT n_insref,OUTPUT nv_message).

              RUN PDCheckNs1.
              
              DISP  fi_TranPol fi_time WITH FRAME fr_main.
        
              /*-----MOTOR POLICY ON WEB----*/
              IF nv_error = NO THEN DO:          
                    
                    DISPLAY  "uwm100" @ fi_File WITH FRAME fr_main.
                    RUN wgw\wgwtra01 (INPUT nv_batchyr,INPUT nv_batchno,INPUT nv_batcnt,  /*uwm100+uwd100*/
                                      INPUT nv_Policy,INPUT nv_RenCnt,INPUT nv_EndCnt,INPUT n_insref
                                      ,INPUT textchr,OUTPUT nv_message,OUTPUT nv_error).
                    DISPLAY  "uwm120" @ fi_File WITH FRAME fr_main.
                    RUN wgw\wgwtra02 (INPUT nv_batchyr,INPUT nv_batchno,INPUT nv_batcnt,  /*uwm120*/
                                      INPUT nv_Policy,INPUT nv_RenCnt,INPUT nv_EndCnt).
                    DISPLAY  "uwm130" @ fi_File WITH FRAME fr_main.
                    RUN wgw\wgwtra03 (INPUT nv_batchyr,INPUT nv_batchno,INPUT nv_batcnt,  /*uwm130*/
                                      INPUT nv_Policy,INPUT nv_RenCnt,INPUT nv_EndCnt).
                    DISPLAY  "uwm301" @ fi_File WITH FRAME fr_main.
                    RUN wgw\wgwtra04 (INPUT nv_batchyr,INPUT nv_batchno,INPUT nv_batcnt,  /*uwm301*/
                                      INPUT nv_Policy,INPUT nv_RenCnt,INPUT nv_EndCnt).
                    
                    DISPLAY  "Detaitem" @ fi_File WITH FRAME fr_main.
                    RUN wgw\wgwtra06 (INPUT nv_batchyr,INPUT nv_batchno,INPUT nv_batcnt,  /*Detaitem*/
                                      INPUT nv_Policy,INPUT nv_RenCnt,INPUT nv_EndCnt).
                     
                    IF nv_error = NO THEN DO:
                        n_success = n_success + 1.
                        nv_batch  = "" .
                        nv_batch  = string(sic_bran.uwm100.bchyr,"9999") + "/" + sic_bran.uwm100.bchno + "." + string(sic_bran.uwm100.bchcnt,"99").
                      /* n_pass = YES.*/
                       PUT STREAM ns2
                          sic_bran.uwm100.cedpol  FORMAT "x(16)" " " 
                          nv_policy FORMAT "X(16)" " "
                          sic_bran.uwm100.rencnt "/" sic_bran.uwm100.endcnt "  "
                          sic_bran.uwm100.trndat "  "
                          sic_bran.uwm100.entdat "  "
                          sic_bran.uwm100.usrid "   " 
                          TRIM(TRIM(sic_bran.uwm100.ntitle) + " " + 
                          TRIM(sic_bran.uwm100.name1)) FORMAT "x(60)"
                          nv_batch  SKIP.
                    END.

                    IF nv_error = YES THEN DO:
                        n_fail   = n_fail + 1 .
                        nv_batch = "" .
                        nv_batch = string(sic_bran.uwm100.bchyr,"9999") + "/" + sic_bran.uwm100.bchno + "." + string(sic_bran.uwm100.bchcnt,"99").

                      /*  n_pass = YES.*/
                        PUT STREAM ns3 
                          nv_message FORMAT "x(30)" 
                          nv_policy FORMAT "X(16)" " "
                          sic_bran.uwm100.rencnt "/" sic_bran.uwm100.endcnt "  "
                          sic_bran.uwm100.trndat "  "
                          sic_bran.uwm100.entdat "  "
                          sic_bran.uwm100.usrid "   " 
                          TRIM(TRIM(sic_bran.uwm100.ntitle) + " " + 
                          TRIM(sic_bran.uwm100.name1)) FORMAT "x(60)" 
                          nv_batch SKIP.

                    END.
        
              END. /*nv_error = no*/
         END. /*  ELSE DO:*/
    END. /* Find last wk_uwm100 */
END.
ASSIGN
    fi_total   = n_total 
    fi_fail    = n_fail
    fi_success = n_success  .
    
OUTPUT STREAM ns1 close.
OUTPUT STREAM ns2 close.
OUTPUT STREAM ns3 close.
fi_TotalTime    = STRING((nv_timeend - nv_timestart),"HH:MM:SS").
DISP  fi_TotalTime WITH FRAME fr_main.
DISP fi_fail fi_success fi_total WITH FRAME fr_main .

MESSAGE "Transfer Data To Premium Complete..!" VIEW-AS ALERT-BOX INFORMATION.

RUN PDUpdateQ.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_acno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_acno wgwtrn72
ON LEAVE OF fi_acno IN FRAME fr_main
DO:
  fi_acno = INPUT fi_acno.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_Branch
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_Branch wgwtrn72
ON LEAVE OF fi_Branch IN FRAME fr_main
DO:
  fi_branch = CAPS (INPUT fi_branch).
  fi_brdesc = "".
  
  MESSAGE fi_branch VIEW-AS ALERT-BOX.
  DISP fi_branch WITH FRAME fr_Main.
  IF fi_branch <> ""  THEN DO:   
      FIND FIRST sic_bran.xmm023 WHERE sic_bran.xmm023.branch = fi_branch NO-LOCK NO-ERROR.
      IF AVAIL sic_bran.xmm023 THEN DO:
         fi_brdesc = sic_bran.xmm023.bdes.
         DISP fi_brdesc WITH FRAME fr_Main.

         RUN pdUpdateQ.
         ENABLE  br_Uwm100 WITH FRAME fr_main.
      END.     
  END. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_Policyfr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_Policyfr wgwtrn72
ON LEAVE OF fi_Policyfr IN FRAME fr_main
DO:
  fi_Policyfr = CAPS (INPUT fi_Policyfr).
  DISP fi_policyfr WITH FRAME fr_main.

  IF fi_policyto = "" THEN DO:
     fi_policyto = fi_policyfr.
     DISP fi_policyto WITH FRAME fr_main.
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_Policyto
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_Policyto wgwtrn72
ON LEAVE OF fi_Policyto IN FRAME fr_main
DO:
  fi_Policyto = CAPS (INPUT fi_Policyto).
  DISP fi_policyto WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br_Uwm100
&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK wgwtrn72 


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
  DEF  VAR  gv_prgid   AS   CHAR  FORMAT "X(8)"   NO-UNDO.
  DEF  VAR  gv_prog    AS   CHAR  FORMAT "X(40)" NO-UNDO.
  
  gv_prgid = "wgwtrn72.W".
  gv_prog  = "Query Batch No Transfer Compulsory To Premium".  
  RUN  WUT\WUTHEAD ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).
  RUN  WUT\WUTWICEN ({&WINDOW-NAME}:HANDLE).  
  SESSION:DATA-ENTRY-RETURN = YES.
/*********************************************************************/ 
/*MESSAGE
  PDBNAME (1) LDBNAME(1) SKIP
  PDBNAME (2) LDBNAME(2) SKIP
  PDBNAME (3) LDBNAME(3) SKIP 
  PDBNAME (4) LDBNAME(4) SKIP   
  PDBNAME (5) LDBNAME(5) SKIP
  PDBNAME (6) LDBNAME(6) SKIP  
  VIEW-AS ALERT-BOX.
*/
 
  ASSIGN nv_branch          = TRIM(SUBSTRING(n_user,6,2))
         fi_branch          = nv_branch
         fi_companycode     = "LOCKTON"
         fi_acno            = ""
         cb_search          = "Tran.Date"
         cb_select          = "Tran.Date" . 
         
  ASSIGN
      fi_branch = "W"
      nv_branch = "W" . /* Test*/
  

  DISP fi_companycode fi_branch fi_acno cb_search cb_select WITH FRAME fr_main.

  FIND FIRST sic_bran.xmm023 WHERE sic_bran.xmm023.branch = fi_branch NO-LOCK NO-ERROR.
      IF AVAIL sic_bran.xmm023 THEN DO:
         fi_brdesc = sic_bran.xmm023.bdes.
         DISP fi_brdesc WITH FRAME fr_Main.

         /*---RUN pdUpdateQ.
         ENABLE  br_Uwm100 WITH FRAME fr_main.---*/
      END.


  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI wgwtrn72  _DEFAULT-DISABLE
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
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(wgwtrn72)
  THEN DELETE WIDGET wgwtrn72.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI wgwtrn72  _DEFAULT-ENABLE
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
  DISPLAY cb_search fi_companycode fi_fail fi_success fi_total cb_select fi_acno 
          fi_Policyfr fi_Policyto fi_Branch fi_brdesc fi_brnfile fi_TranPol 
          fi_dupfile fi_strTime fi_time fi_TotalTime fi_File 
      WITH FRAME fr_main IN WINDOW wgwtrn72.
  ENABLE cb_search fi_companycode fi_fail fi_success fi_total cb_select fi_acno 
         bu_refresh fi_Policyfr fi_Policyto fi_Branch bu_exit bu_Transfer 
         br_Uwm100 fi_brdesc fi_brnfile fi_TranPol fi_dupfile fi_strTime 
         fi_time fi_TotalTime fi_File RECT-1 RECT-636 RECT-2 RECT-640 RECT-649 
         RECT-3 
      WITH FRAME fr_main IN WINDOW wgwtrn72.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW wgwtrn72.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDCheckNs1 wgwtrn72 
PROCEDURE PDCheckNs1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

ASSIGN putchr  = ""
       putchr1 = ""
       textchr = STRING(TRIM(nv_policy),"x(16)") + " " +
                 STRING(nv_rencnt,"99") + "/" + STRING(nv_endcnt,"999").

FIND LAST wk_uwm100 WHERE RECID(wk_uwm100) = nv_RecUwm100.
IF NOT AVAIL wk_uwm100 THEN DO:
   ASSIGN
    putchr1 = "Not Found Record on sic_bran.uwm100" .
    putchr  = textchr  + "  " + TRIM(putchr1).
   PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
   nv_message = putchr1.
   nv_error = YES.
 /*NEXT.*/
END.
ELSE DO:
  IF wk_uwm100.poltyp = "" THEN DO:
     ASSIGN
      putchr1 = "ไม่มีค่า Policy Type"
      putchr  = textchr + "  " + TRIM(putchr1).
     PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
     nv_message = putchr1.
     nv_error = YES.
   /*NEXT.*/
  END.
  IF wk_uwm100.branch = "" THEN DO:
     ASSIGN
      putchr1 = "ไม่มีค่า Branch"
      putchr  = textchr + "  " + TRIM(putchr1).
     PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
     nv_message = putchr1.
     nv_error = YES.
   /*NEXT.*/
  END.
  IF wk_uwm100.comdat = ? THEN DO:
     ASSIGN 
       putchr1 = "ไม่มีค่า Comdate"
       putchr  = textchr + "  " + TRIM(putchr1).
      PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
      nv_message = putchr1.
      nv_error = YES.
    /*NEXT.*/
  END.
  IF wk_uwm100.expdat = ? THEN DO:
     ASSIGN
       putchr1 = "ไม่มีค่า Expiry Date"
       putchr  = textchr + "  " + TRIM(putchr1).
      PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
      nv_message = putchr1.
      nv_error = YES.
    /*NEXT.*/
  END.
  IF wk_uwm100.name1 = "" THEN DO:
     ASSIGN
      putchr1 = "ไม่มีค่า Name Of Insured"
      putchr  = textchr  + "  " + TRIM(putchr1).
     PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
     nv_message = putchr1.
     nv_error = YES.
   /*NEXT.*/
  END.
  IF wk_uwm100.prem_t = 0 THEN DO:
     ASSIGN
      putchr1 = "ไม่มีค่า Premium"
      putchr  = textchr + "  " + TRIM(putchr1).
     PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
     nv_message = putchr1.
     nv_error = YES.
   /*NEXT.*/
  END.
  IF wk_uwm100.tranty = "" THEN DO:
     ASSIGN
      putchr1 = "ไม่สามารถระบุประเภทงานได้"
      putchr  = textchr + "  " + TRIM(putchr1).
     PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
     nv_message = putchr1.
     nv_error = YES.
   /*NEXT.*/
  END.
  IF wk_uwm100.policy = "" THEN DO:
     ASSIGN
      putchr1 = "Policy No. is blank"
      putchr  = textchr + "  " + TRIM(putchr1).
     PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
     nv_message = putchr1.
     nv_error = YES.
   /*NEXT.*/
  END.
  IF wk_uwm100.RenCnt <> 0 THEN DO:
     ASSIGN
      putchr1 = "Renewal Count error"
      putchr  = textchr + "  " + TRIM(putchr1).
     PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
     nv_message = putchr1.
     nv_error = YES.
   /*NEXT.*/
  END.
  IF wk_uwm100.EndCnt <> 0 THEN DO:
     ASSIGN
      putchr1 = "Endorsement Count error"
      putchr  = textchr + "  " + TRIM(putchr1).
     PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
     nv_message = putchr1.
     nv_error = YES.
   /*NEXT.*/
  END.
  IF wk_uwm100.agent = "" OR wk_uwm100.acno1 = "" THEN DO:
     ASSIGN
      putchr1 = "Producer, Agent are blank"
      putchr  = textchr + "  " + TRIM(putchr1).
     PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
     nv_message = putchr1.
     nv_error = YES.
   /*NEXT.*/
  END.
 /* IF wk_uwm100.insref = "" THEN DO:
     ASSIGN
      putchr1 = "Insured Code is blank"
      putchr  = textchr + "  " + TRIM(putchr1).
     PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
     nv_message = putchr1.
     nv_error = YES.
   /*NEXT.*/
  END.
  */
  IF TRIM(wk_uwm100.Addr1) + TRIM(wk_uwm100.Addr2) +
     TRIM(wk_uwm100.Addr3) + TRIM(wk_uwm100.Addr4) = "" THEN DO:
     ASSIGN
      putchr1 = "Address is blank"
      putchr  = textchr + "  " + TRIM(putchr1).
     PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
     nv_message = putchr1.
     nv_error = YES.
   /*NEXT.*/
  END.   
  /*UWM120*/
  FIND LAST sic_bran.uwm120 USE-INDEX uwm12001
      WHERE sic_bran.uwm120.policy = wk_uwm100.policy
        AND sic_bran.uwm120.rencnt = wk_uwm100.rencnt
        AND sic_bran.uwm120.endcnt = wk_uwm100.endcnt
        AND sic_bran.uwm120.riskgp = 0
        AND sic_bran.uwm120.riskno = 1
        AND sic_bran.uwm120.bchyr  = nv_batchyr
        AND sic_bran.uwm120.bchno  = nv_batchno
        AND sic_bran.uwm120.bchcnt = nv_batcnt NO-LOCK NO-ERROR.
 IF NOT AVAIL sic_bran.uwm120 THEN DO:
    ASSIGN
     putchr1 = "Not Found Record on sic_bran.uwm120".
     putchr  =  textchr  + "  " + TRIM(putchr1).
    PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
    nv_message = putchr1.
    nv_error = YES.
  /*NEXT.*/
 END.
 /*UWM130*/
 FIND LAST sic_bran.uwm130 USE-INDEX uwm13001
     WHERE sic_bran.uwm130.policy = wk_uwm100.policy
       AND sic_bran.uwm130.rencnt = wk_uwm100.rencnt
       AND sic_bran.uwm130.endcnt = wk_uwm100.endcnt
       AND sic_bran.uwm130.riskgp = 0
       AND sic_bran.uwm130.riskno = 1
       AND sic_bran.uwm130.itemno = 1
       AND sic_bran.uwm130.bchyr = nv_batchyr 
       AND sic_bran.uwm130.bchno = nv_batchno 
       AND sic_bran.uwm130.bchcnt  = nv_batcnt NO-LOCK NO-ERROR.
 IF NOT AVAIL  sic_bran.uwm130 THEN DO:
    ASSIGN
     putchr1 = "Not Found Record on sic_bran.uwm130" .
     putchr  =  textchr  + "  " + TRIM(putchr1).
    PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
    nv_message = putchr1.
    nv_error = YES.
  /*NEXT.*/
 END.
 /*UWM301*/
 FIND LAST sic_bran.uwm301 USE-INDEX uwm30101
     WHERE sic_bran.uwm301.policy  = wk_uwm100.policy
       AND sic_bran.uwm301.rencnt  = wk_uwm100.rencnt
       AND sic_bran.uwm301.endcnt  = wk_uwm100.endcnt
       AND sic_bran.uwm301.riskgp  = 0
       AND sic_bran.uwm301.riskno  = 1
       AND sic_bran.uwm301.itemno  = 1
       AND sic_bran.uwm301.bchno   = nv_batchno
       AND sic_bran.uwm301.bchcnt  = nv_batcnt
       AND sic_bran.uwm301.bchyr   = nv_batchyr NO-LOCK NO-ERROR.
 IF NOT AVAIL  sic_bran.uwm301 THEN DO:
    ASSIGN
      putchr1 = "Not Found Record on sic_bran.uwm301" .
      putchr  =  textchr  + "  " + TRIM(putchr1).
    PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
    nv_message = putchr1.
    nv_error = YES.
  /*NEXT.*/
 END.
 ELSE DO:
  IF LENGTH(sic_bran.uwm301.vehreg) > 11 THEN DO:
     ASSIGN
      putchr1 = "Warning : Vehicle Register More Than 11 Characters".    
      putchr  =  textchr  + "  " + TRIM(putchr1).
     PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
     nv_message = putchr1.
     nv_error = YES.
   /*NEXT.*/
  END.
  IF sic_bran.uwm301.vehreg = "" THEN DO:
     ASSIGN
      putchr1 = "Vehicle Register is mandatory field.".
      putchr  =  textchr  + "  " + TRIM(putchr1).
     PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
     nv_message = putchr1.
     nv_error = YES.
   /*NEXT.*/
  END.
  IF sic_bran.uwm301.modcod = "" THEN DO:
     ASSIGN
      putchr1 = "Redbook Code เป็นค่าว่าง ".
      putchr  =  textchr  + "  " + TRIM(putchr1).
     PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
     nv_message = putchr1.
     nv_error = YES.
   /*NEXT.*/
  END.
 END. /*ELSE DO:*/
 /*UWD132*/
 FIND LAST sic_bran.uwd132 USE-INDEX uwd13201
     WHERE sic_bran.uwd132.policy  = wk_uwm100.policy
       AND sic_bran.uwd132.rencnt  = wk_uwm100.rencnt
       AND sic_bran.uwd132.endcnt  = wk_uwm100.endcnt
       AND sic_bran.uwd132.riskgp  = 0
       AND sic_bran.uwd132.riskno  = 1
       AND sic_bran.uwd132.itemno  = 1
       AND sic_bran.uwd132.bchno   = nv_batchno
       AND sic_bran.uwd132.bchcnt  = nv_batcnt
       AND sic_bran.uwd132.bchyr   = nv_batchyr NO-LOCK NO-ERROR.
 IF NOT AVAIL  sic_bran.uwd132 THEN DO:
    ASSIGN
     putchr1 = "Not Found Record on sic_bran.uwd132" .
     putchr  =  textchr  + "  " + TRIM(putchr1).
    PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
    nv_message = putchr1.
    nv_error = YES.
  /*NEXT.*/
 END.

END. /*--WK_UWM100--*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDUpdateQ wgwtrn72 
PROCEDURE PDUpdateQ :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN 
    FRAME fr_Main fi_Branch.
  

DISP fi_branch WITH FRAME fr_main .
/*
IF fi_acno <> "" THEN DO: 
  OPEN QUERY br_Uwm100        
  FOR EACH sic_bran.uwm100 USE-INDEX  uwm10094
     WHERE sic_bran.uwm100.Acno1  = fi_Acno
       AND sic_bran.uwm100.branch = fi_branch
       AND sic_bran.uwm100.releas = NO       
       AND sic_bran.uwm100.
       AND sic_bran.uwm100.Prog   = "WGWTLTGN" NO-LOCK
       BY  sic_bran.uwm100.Policy.
END.
ELSE DO:
  OPEN QUERY br_Uwm100        
  FOR EACH sic_bran.uwm100 USE-INDEX  uwm10021
     WHERE sic_bran.uwm100.Trndat = fi_TrnDate
       AND sic_bran.uwm100.branch = fi_branch
       AND sic_bran.uwm100.releas = NO       
       AND sic_bran.uwm100.Prog   = "WGWTLTGN" NO-LOCK
       BY  sic_bran.uwm100.Policy.
END.

*/

IF cb_search = "Producer Code" THEN DO: 
  OPEN QUERY br_Uwm100        
  FOR EACH sic_bran.uwm100 USE-INDEX  uwm10094
     WHERE sic_bran.uwm100.Acno1  = fi_Acno
       AND sic_bran.uwm100.branch = fi_branch
       AND sic_bran.uwm100.releas = NO       
       AND sic_bran.uwm100.Prog   = "WGWTLTGN" NO-LOCK
       BY  sic_bran.uwm100.Policy.
END.
ELSE DO:
  OPEN QUERY br_Uwm100        
  FOR EACH sic_bran.uwm100 USE-INDEX  uwm10021
     WHERE sic_bran.uwm100.Trndat = DATE(fi_acno)
       AND sic_bran.uwm100.branch = fi_branch
       AND sic_bran.uwm100.releas = NO       
       AND sic_bran.uwm100.Prog   = "WGWTLTGN" NO-LOCK
       BY  sic_bran.uwm100.Policy.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

