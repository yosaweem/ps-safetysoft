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
program id   : wgwstkb1.w
program name : Query & Update Data sticker BU3
               Import text file Data sticker Add in table  tlt 
Create  by   : Ranu I. [A59-0527]   On   03/11/2016
Connect      : GW_SAFE LD SIC_BRAN, GW_STAT LD BRSTAT ,SICSYAC,SICUW [Not connect : Stat]
+++++++++++++++++++++++++++++++++++++++++++++++*/
DEFINE  VAR nv_rectlt    as recid init  0.  
DEFINE  VAR nv_recidtlt  as recid init  0.  
DEF  STREAM ns2.                        
DEFINE  VAR nv_cnt       as int   init  1. 
DEFINE  VAR nv_row       as int   init  0. 
DEFINE  VAR n_record     AS INTE  INIT  0. 
DEFINE  VAR n_comname    AS CHAR  INIT  "".
DEFINE  VAR n_asdat      AS CHAR.
DEFINE  VAR vAcProc_fil  AS CHAR.
DEFINE  VAR vAcProc_fil2 AS CHAR.
DEFINE  VAR n_asdat2     AS CHAR.
DEFINE  VAR n_producer   AS CHAR .
DEFINE  WORKFILE wdetail NO-UNDO
    FIELD notifydate      AS CHAR FORMAT "X(10)"  INIT ""                                                    
    FIELD branch          AS CHAR FORMAT "X(2)"   INIT ""                                    
    FIELD policy          AS CHAR FORMAT "X(12)"  INIT ""   
    FIELD stk             AS CHAR FORMAT "X(15)"  INIT ""                                       
    FIELD docno           AS CHAR FORMAT "X(10)"  INIT ""                                    
    FIELD remark          AS CHAR FORMAT "X(150)" INIT ""
    FIELD pass            AS CHAR FORMAT "x(25)" INIT "".
DEF VAR nv_countdata     AS DECI INIT 0.
DEF VAR nv_countnotcomp  AS DECI INIT 0.
DEF VAR nv_countcomplete AS DECI INIT 0.
DEF VAR np_addr1     AS CHAR FORMAT "x(256)" INIT "" .
DEF VAR np_addr2     AS CHAR FORMAT "x(40)" INIT "" .
DEF VAR np_addr3     AS CHAR FORMAT "x(40)" INIT "" .
DEF VAR np_addr4     AS CHAR FORMAT "x(40)" INIT "" .
DEF VAR np_title     AS CHAR FORMAT "x(30)" INIT "" .
DEF VAR np_name      AS CHAR FORMAT "x(40)" INIT "" .
DEF VAR np_name2     AS CHAR FORMAT "x(40)" INIT "" .
DEF VAR nv_outfile   AS CHAR FORMAT "x(256)" INIT "" .

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
&Scoped-define FIELDS-IN-QUERY-br_tlt tlt.releas tlt.trndat ~
tlt.nor_noti_tlt tlt.comp_usr_tlt tlt.cha_no tlt.safe2 tlt.genusr ~
tlt.filler2 tlt.usrid 
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_tlt 
&Scoped-define QUERY-STRING-br_tlt FOR EACH tlt NO-LOCK
&Scoped-define OPEN-QUERY-br_tlt OPEN QUERY br_tlt FOR EACH tlt NO-LOCK.
&Scoped-define TABLES-IN-QUERY-br_tlt tlt
&Scoped-define FIRST-TABLE-IN-QUERY-br_tlt tlt


/* Definitions for FRAME fr_main                                        */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS br_tlt fi_loaddate fi_producer fi_inputfile ~
bu_file bu_imp fi_producer2 fi_trndatfr fi_trndatto bu_ok cb_search ~
fi_search bu_sch ra_bydelete fi_datadelform fi_datadelto bu_update ~
bu_updatecan cb_report fi_reportdata fi_repolicyfr_key fi_repolicyto_key ~
fi_filename bu_reok bu_exit fi_despro RECT-332 RECT-343 RECT-346 RECT-494 ~
RECT-495 RECT-496 RECT-497 RECT-499 RECT-500 RECT-501 RECT-502 
&Scoped-Define DISPLAYED-OBJECTS fi_loaddate fi_producer fi_inputfile ~
fi_producer2 fi_trndatfr fi_trndatto cb_search fi_search ra_bydelete ~
fi_datadelform fi_datadelto cb_report fi_reportdata fi_repolicyfr_key ~
fi_repolicyto_key fi_filename fi_despro 

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
     SIZE 6.83 BY 1
     FONT 6.

DEFINE BUTTON bu_file 
     LABEL "..." 
     SIZE 3.5 BY 1.

DEFINE BUTTON bu_imp 
     LABEL "IMP" 
     SIZE 7 BY 1
     FONT 6.

DEFINE BUTTON bu_ok 
     LABEL "OK" 
     SIZE 7 BY 1
     FONT 6.

DEFINE BUTTON bu_reok 
     LABEL "OK" 
     SIZE 6.5 BY 1
     FONT 6.

DEFINE BUTTON bu_sch 
     LABEL "Search" 
     SIZE 7.5 BY 1.

DEFINE BUTTON bu_update 
     LABEL "Yes / No" 
     SIZE 13 BY .91
     FONT 6.

DEFINE BUTTON bu_updatecan 
     LABEL "Cancel / OK" 
     SIZE 14 BY .91
     FONT 6.

DEFINE VARIABLE cb_report AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEMS "เลขกรมธรรม์" 
     DROP-DOWN-LIST
     SIZE 29 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE cb_search AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEMS "เลขกรมธรรม์" 
     DROP-DOWN-LIST
     SIZE 36 BY 1
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_datadelform AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 18 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_datadelto AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 18 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_despro AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 39.17 BY .91
     FGCOLOR 7 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_filename AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 47.5 BY 1
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_inputfile AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 62.17 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_loaddate AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 16 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_producer AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 19 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_producer2 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 16.67 BY 1
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_repolicyfr_key AS CHARACTER FORMAT "X(12)":U 
     VIEW-AS FILL-IN 
     SIZE 17 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_repolicyto_key AS CHARACTER FORMAT "X(12)":U 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_reportdata AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 5 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_search AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 38 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_trndatfr AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 16.83 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_trndatto AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 16.83 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE ra_bydelete AS INTEGER 
     VIEW-AS RADIO-SET VERTICAL
     RADIO-BUTTONS 
          "By Trandate", 1,
"By Sticker", 2
     SIZE 15 BY 1.81
     BGCOLOR 10 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-332
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132.5 BY 10.48
     BGCOLOR 18 .

DEFINE RECTANGLE RECT-343
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 52 BY 7.14
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-346
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 10.5 BY 1.52
     BGCOLOR 6 FGCOLOR 0 .

DEFINE RECTANGLE RECT-494
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132.5 BY 2.91
     BGCOLOR 3 .

DEFINE RECTANGLE RECT-495
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 9.5 BY 1.52
     BGCOLOR 2 FGCOLOR 7 .

DEFINE RECTANGLE RECT-496
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 79 BY 3.1
     BGCOLOR 29 .

DEFINE RECTANGLE RECT-497
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 79.17 BY 4.1
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-499
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 8.5 BY 1.38
     BGCOLOR 2 .

DEFINE RECTANGLE RECT-500
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 8.83 BY 1.38
     BGCOLOR 6 .

DEFINE RECTANGLE RECT-501
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 9.5 BY 1.43
     BGCOLOR 6 FGCOLOR 6 .

DEFINE RECTANGLE RECT-502
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 17 BY 2.24
     BGCOLOR 10 .

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_tlt FOR 
      tlt SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_tlt
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_tlt c-wins _STRUCTURED
  QUERY br_tlt NO-LOCK DISPLAY
      tlt.releas FORMAT "X(15)":U WIDTH 11.83
      tlt.trndat FORMAT "99/99/9999":U
      tlt.nor_noti_tlt COLUMN-LABEL "เลขกรมธรรม์พรบ." FORMAT "x(20)":U
            WIDTH 19.83
      tlt.comp_usr_tlt COLUMN-LABEL "สาขา" FORMAT "x(4)":U
      tlt.cha_no COLUMN-LABEL "เลขสติ๊กเกอร์" FORMAT "x(20)":U
      tlt.safe2 COLUMN-LABEL "เลขที่ใบเสร็จ" FORMAT "x(15)":U WIDTH 14.33
      tlt.genusr COLUMN-LABEL "Producer code" FORMAT "x(10)":U
            WIDTH 13.33
      tlt.filler2 COLUMN-LABEL "หมายเหตุ" FORMAT "x(90)":U
      tlt.usrid FORMAT "x(8)":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 132.5 BY 12.33
         BGCOLOR 15 FGCOLOR 0 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     br_tlt AT ROW 11.57 COL 1.33
     fi_loaddate AT ROW 1.48 COL 28.67 COLON-ALIGNED NO-LABEL
     fi_producer AT ROW 1.43 COL 63.67 COLON-ALIGNED NO-LABEL
     fi_inputfile AT ROW 2.67 COL 28.33 COLON-ALIGNED NO-LABEL
     bu_file AT ROW 2.67 COL 92.83
     bu_imp AT ROW 2.62 COL 98.83
     fi_producer2 AT ROW 4.57 COL 18.67 COLON-ALIGNED NO-LABEL
     fi_trndatfr AT ROW 5.67 COL 18.5 COLON-ALIGNED NO-LABEL
     fi_trndatto AT ROW 6.76 COL 18.5 COLON-ALIGNED NO-LABEL
     bu_ok AT ROW 6.52 COL 39.67
     cb_search AT ROW 8.19 COL 16.33 NO-LABEL
     fi_search AT ROW 9.48 COL 3.5 NO-LABEL
     bu_sch AT ROW 9.52 COL 43.67
     ra_bydelete AT ROW 4.71 COL 56.67 NO-LABEL
     fi_datadelform AT ROW 4.52 COL 78.33 COLON-ALIGNED NO-LABEL
     fi_datadelto AT ROW 4.52 COL 101.33 COLON-ALIGNED NO-LABEL
     bu_update AT ROW 5.86 COL 88.5
     bu_updatecan AT ROW 5.86 COL 102.5
     cb_report AT ROW 7.52 COL 66.67 COLON-ALIGNED NO-LABEL
     fi_reportdata AT ROW 8.67 COL 60.33 COLON-ALIGNED NO-LABEL
     fi_repolicyfr_key AT ROW 8.67 COL 79.67 COLON-ALIGNED NO-LABEL
     fi_repolicyto_key AT ROW 8.67 COL 108 COLON-ALIGNED NO-LABEL
     fi_filename AT ROW 9.95 COL 64.33 COLON-ALIGNED NO-LABEL
     bu_reok AT ROW 9.95 COL 115
     bu_exit AT ROW 10 COL 123.5
     fi_despro AT ROW 1.48 COL 83.33 COLON-ALIGNED NO-LABEL
     "Policy To :" VIEW-AS TEXT
          SIZE 10.5 BY 1 AT ROW 8.67 COL 99.17
          BGCOLOR 8 FGCOLOR 0 FONT 6
     "Load Date :" VIEW-AS TEXT
          SIZE 11.5 BY 1 AT ROW 1.48 COL 18.5
          BGCOLOR 3 FGCOLOR 7 FONT 6
     " Up Status :" VIEW-AS TEXT
          SIZE 12.33 BY 1 AT ROW 5.76 COL 73.33
          BGCOLOR 16 FGCOLOR 2 FONT 6
     " Import File STK :" VIEW-AS TEXT
          SIZE 17 BY 1 AT ROW 2.67 COL 13
          BGCOLOR 3 FGCOLOR 7 FONT 6
     "Transdate To   :" VIEW-AS TEXT
          SIZE 16 BY 1 AT ROW 6.76 COL 4
          BGCOLOR 14 FGCOLOR 1 FONT 6
     "Policy From :" VIEW-AS TEXT
          SIZE 13 BY 1 AT ROW 8.67 COL 68.33
          BGCOLOR 8 FGCOLOR 0 FONT 6
     "สาขา :" VIEW-AS TEXT
          SIZE 5.83 BY 1 AT ROW 8.67 COL 56
          BGCOLOR 8 FGCOLOR 0 FONT 6
     "Producer code  :" VIEW-AS TEXT
          SIZE 17 BY 1 AT ROW 4.57 COL 3.33
          BGCOLOR 2 FGCOLOR 7 FONT 6
     "Producer code :" VIEW-AS TEXT
          SIZE 16 BY 1 AT ROW 1.43 COL 49.83
          FGCOLOR 7 FONT 6
     "From :" VIEW-AS TEXT
          SIZE 6.5 BY .95 AT ROW 4.52 COL 73.17
          BGCOLOR 29 FGCOLOR 2 FONT 6
     "To :" VIEW-AS TEXT
          SIZE 4 BY .95 AT ROW 4.52 COL 99
          BGCOLOR 29 FGCOLOR 2 FONT 6
     "Search By :" VIEW-AS TEXT
          SIZE 12.5 BY 1 AT ROW 8.19 COL 3.5
          BGCOLOR 2 FGCOLOR 7 FONT 6
     "Transdate From :" VIEW-AS TEXT
          SIZE 16 BY 1 AT ROW 5.67 COL 3.83
          BGCOLOR 14 FGCOLOR 1 FONT 6
     "File name :" VIEW-AS TEXT
          SIZE 10.5 BY 1 AT ROW 9.95 COL 55.67
          BGCOLOR 5 FGCOLOR 7 FONT 6
     "Report File :" VIEW-AS TEXT
          SIZE 12.5 BY 1 AT ROW 7.52 COL 55.83
          BGCOLOR 5 FGCOLOR 7 FONT 6
     RECT-332 AT ROW 1 COL 1
     RECT-343 AT ROW 4.14 COL 1.83
     RECT-346 AT ROW 9.29 COL 42.17
     RECT-494 AT ROW 1.1 COL 1
     RECT-495 AT ROW 6.29 COL 38.5
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133.17 BY 23.05
         BGCOLOR 3 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     RECT-496 AT ROW 4.1 COL 54.17
     RECT-497 AT ROW 7.24 COL 54.17
     RECT-499 AT ROW 9.76 COL 114
     RECT-500 AT ROW 9.81 COL 122.5
     RECT-501 AT ROW 2.43 COL 97.5
     RECT-502 AT ROW 4.52 COL 55.5
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133.17 BY 23.05
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
         TITLE              = "[DATA STRICKER  BU3]"
         HEIGHT             = 22.95
         WIDTH              = 133
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
/* BROWSE-TAB br_tlt 1 fr_main */
ASSIGN 
       br_tlt:SEPARATOR-FGCOLOR IN FRAME fr_main      = 0.

ASSIGN 
       bu_file:AUTO-RESIZE IN FRAME fr_main      = TRUE.

/* SETTINGS FOR COMBO-BOX cb_search IN FRAME fr_main
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
     _Options          = "NO-LOCK"
     _FldNameList[1]   > brstat.tlt.releas
"tlt.releas" ? "X(15)" "character" ? ? ? ? ? ? no ? no no "11.83" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[2]   = brstat.tlt.trndat
     _FldNameList[3]   > brstat.tlt.nor_noti_tlt
"tlt.nor_noti_tlt" "เลขกรมธรรม์พรบ." "x(20)" "character" ? ? ? ? ? ? no ? no no "19.83" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   > brstat.tlt.comp_usr_tlt
"tlt.comp_usr_tlt" "สาขา" ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   > brstat.tlt.cha_no
"tlt.cha_no" "เลขสติ๊กเกอร์" ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[6]   > brstat.tlt.safe2
"tlt.safe2" "เลขที่ใบเสร็จ" "x(15)" "character" ? ? ? ? ? ? no ? no no "14.33" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[7]   > brstat.tlt.genusr
"tlt.genusr" "Producer code" "x(10)" "character" ? ? ? ? ? ? no ? no no "13.33" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[8]   > brstat.tlt.filler2
"tlt.filler2" "หมายเหตุ" "x(90)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[9]   = brstat.tlt.usrid
     _Query            is NOT OPENED
*/  /* BROWSE br_tlt */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME c-wins
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c-wins c-wins
ON END-ERROR OF c-wins /* [DATA STRICKER  BU3] */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c-wins c-wins
ON WINDOW-CLOSE OF c-wins /* [DATA STRICKER  BU3] */
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
    Run  wgw\wgwstkb2(Input  nv_recidtlt).
    {&WINDOW-NAME}:hidden  =  No.    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_tlt c-wins
ON VALUE-CHANGED OF br_tlt IN FRAME fr_main
DO:
     Get  current  br_tlt.
     nv_rectlt =  recid(tlt).

     fi_datadelform = brstat.tlt.cha_no.
     fi_datadelto   = brstat.tlt.cha_no.
     DISP fi_datadelform fi_datadelto WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_exit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_exit c-wins
ON CHOOSE OF bu_exit IN FRAME fr_main /* EXIT */
DO:
    Apply "Close" to This-procedure.
    Return no-apply.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_file
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_file c-wins
ON CHOOSE OF bu_file IN FRAME fr_main /* ... */
DO:
    DEFINE VARIABLE cvData        AS CHARACTER NO-UNDO.
    DEFINE VARIABLE OKpressed AS LOGICAL INITIAL TRUE.
    SYSTEM-DIALOG GET-FILE cvData
        TITLE      "Choose Data File to Import ..."
        FILTERS    "Text Documents" "*.csv"
        MUST-EXIST
        USE-FILENAME
        UPDATE OKpressed.
    IF OKpressed = TRUE THEN DO:
        fi_inputfile  = cvData.
        DISP fi_inputfile WITH FRAME fr_main.     
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_imp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_imp c-wins
ON CHOOSE OF bu_imp IN FRAME fr_main /* IMP */
DO:
    IF  fi_inputfile = "" THEN DO:
        MESSAGE "please input file name ...........!!!" VIEW-AS ALERT-BOX.
        Apply "Entry"  to fi_inputfile.
        Return no-apply.
    END.
    ELSE IF fi_producer = ""  THEN DO:
        MESSAGE "กรุณาระบุ Producer code !!!" VIEW-AS ALERT-BOX.
        Apply "Entry"  to fi_producer.
        Return no-apply.
    END.
    ELSE DO: 
        ASSIGN n_producer = ""
               n_producer = fi_producer.
        Run Import_notification1.
    END.
    ASSIGN 
    fi_producer  = ""
    n_producer   = ""
    fi_despro    = ""
    fi_inputfile = "".
    DISP fi_producer fi_despro fi_inputfile WITH FRAME fr_main.

    RELEASE brstat.tlt.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_ok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_ok c-wins
ON CHOOSE OF bu_ok IN FRAME fr_main /* OK */
DO:
    IF fi_producer2 = "" THEN DO:
        MESSAGE " กรุณาระบุ Prodecer code ที่ต้องการดูข้อมูล " VIEW-AS ALERT-BOX.
        Apply "Entry"  to fi_producer2.
        Return no-apply.
    END.
    ELSE DO:
        Open Query br_tlt
            For each brstat.tlt Use-index  tlt01  Where
            brstat.tlt.trndat  >=   fi_trndatfr   And
            brstat.tlt.trndat  <=   fi_trndatto   And
            brstat.tlt.genusr   =   fi_producer2  no-lock. 
                ASSIGN nv_rectlt =  recid(brstat.tlt) .
                Apply "Entry"  to br_tlt.
                Return no-apply.   
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_reok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_reok c-wins
ON CHOOSE OF bu_reok IN FRAME fr_main /* OK */
DO:
    IF fi_producer2  = "" THEN DO:
        MESSAGE "กรุณาระบุ producer code !!!"  VIEW-AS ALERT-BOX.
        Apply "Entry"  to fi_producer2 .
        Return no-apply.
    END.
    ELSE IF fi_filename = ""  THEN DO:
        MESSAGE "กรุณาใสชื่อไฟล์!!!"  VIEW-AS ALERT-BOX.
        Apply "Entry"  to fi_filename.
        Return no-apply.
    END.
    ELSE RUN proc_report.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_sch
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_sch c-wins
ON CHOOSE OF bu_sch IN FRAME fr_main /* Search */
DO:
fi_search     =  Input  fi_search .
    Disp fi_search  with frame fr_main.

    IF fi_producer2 = "" THEN DO:
        MESSAGE " กรุณาระบุ Prodecer code ที่ต้องการดูข้อมูล " VIEW-AS ALERT-BOX.
        Apply "Entry"  to fi_producer2.
        Return no-apply.
    END.
    ELSE DO:
      If  cb_search =  "เลขกรมธรรม์"   Then do:               /* name  */
          Open Query br_tlt                      
              For each brstat.tlt Use-index  tlt01 Where
              brstat.tlt.trndat       >=  fi_trndatfr    And
              brstat.tlt.trndat       <=  fi_trndatto    And
              brstat.tlt.genusr        =  fi_producer2        And
              brstat.tlt.nor_noti_tlt  = trim(fi_search) no-lock.
                  ASSIGN nv_rectlt =  recid(brstat.tlt) .
                  Apply "Entry"  to br_tlt.
                  Return no-apply.            
      END.
      ELSE IF  cb_search  = "สาขา"  THEN DO:
          Open Query br_tlt                      
              For each brstat.tlt Use-index  tlt01 Where
              brstat.tlt.trndat         >=  fi_trndatfr    And 
              brstat.tlt.trndat         <=  fi_trndatto    And 
              brstat.tlt.genusr          =  fi_producer2        And 
              brstat.tlt.comp_usr_tlt    = trim(fi_search) no-lock.
                  ASSIGN nv_rectlt =  recid(brstat.tlt) .
                  Apply "Entry"  to br_tlt.      
                  Return no-apply.  
      END.
      ELSE If  cb_search  =  "เลขสติ๊กเกอร์"    Then do:        /* cedpol */  
          Open Query br_tlt                      
              For each brstat.tlt Use-index  tlt01   Where
              brstat.tlt.trndat   >=  fi_trndatfr    And 
              brstat.tlt.trndat   <=  fi_trndatto    And 
              brstat.tlt.genusr    =  fi_producer2        And 
              brstat.tlt.cha_no    = trim(fi_search) no-lock.
                  ASSIGN nv_rectlt =  recid(brstat.tlt) .
                  Apply "Entry"  to br_tlt.      
                  Return no-apply.               
      END. 
      ELSE If  cb_search  =  "เลขที่ใบเสร็จ"  Then do:        /* prepol */  
          Open Query br_tlt                      
              For each brstat.tlt Use-index  tlt01 Where
              brstat.tlt.trndat   >=  fi_trndatfr  And 
              brstat.tlt.trndat   <=  fi_trndatto  And 
              brstat.tlt.genusr    =  fi_producer2       And 
              brstat.tlt.safe2     = trim(fi_search)  no-lock.
                  ASSIGN nv_rectlt =  recid(brstat.tlt) .
                  Apply "Entry"  to br_tlt.      
                  Return no-apply.               
      END. 
      ELSE If  cb_search  =  "Release Yes" Then do:         /* not ..complete... */
          Open Query br_tlt                      
              For each brstat.tlt Use-index  tlt01      Where
              brstat.tlt.trndat         >=  fi_trndatfr And
              brstat.tlt.trndat         <=  fi_trndatto And
              brstat.tlt.genusr          =  fi_producer2     And
              brstat.tlt.releas          =  "Yes"       no-lock.
                  ASSIGN nv_rectlt =  recid(brstat.tlt) .
                  Apply "Entry"  to br_tlt.
                  Return no-apply.                             
      END.
      ELSE If  cb_search  =  "Release No"  Then do:         /* not ..complete... */
          Open Query br_tlt                      
              For each brstat.tlt Use-index  tlt01      Where
              brstat.tlt.trndat         >=  fi_trndatfr And
              brstat.tlt.trndat         <=  fi_trndatto And
              brstat.tlt.genusr          =  fi_producer2     And
              brstat.tlt.releas          =  "No"        no-lock.
                  ASSIGN nv_rectlt =  recid(brstat.tlt) .
                  Apply "Entry"  to br_tlt.
                  Return no-apply.                             
      END.
      ELSE If  cb_search  =  "Release cancel"  Then do:         /* not ..complete... */
          Open Query br_tlt                      
              For each brstat.tlt Use-index  tlt01      Where
              brstat.tlt.trndat         >=  fi_trndatfr And
              brstat.tlt.trndat         <=  fi_trndatto And
              brstat.tlt.genusr          =  fi_producer2     And
              index(brstat.tlt.releas,"Cancel") <> 0    no-lock.
                  ASSIGN nv_rectlt =  recid(brstat.tlt) .
                  Apply "Entry"  to br_tlt.
                  Return no-apply.                             
      END. 
   END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_update
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_update c-wins
ON CHOOSE OF bu_update IN FRAME fr_main /* Yes / No */
DO:
    /*Add by : A64-0060 */
    IF ra_bydelete = 1 THEN DO:
        FIND FIRST brstat.tlt Use-index  tlt01  Where
                   brstat.tlt.trndat  >=   date(fi_datadelform)    And
                   brstat.tlt.trndat  <=   date(fi_datadelto)      And
                   brstat.tlt.genusr   =   fi_producer2      NO-ERROR NO-WAIT. 
            If  avail brstat.tlt Then do:
               For each brstat.tlt Use-index  tlt01  Where
                        brstat.tlt.trndat  >=   date(fi_datadelform)    And
                        brstat.tlt.trndat  <=   date(fi_datadelto)      And
                        brstat.tlt.genusr   =   fi_producer2  . 
                    If  index(brstat.tlt.releas,"No")  =  0  Then do:    /* yes */
                        message "Update No ข้อมูลรายการนี้  "  View-as alert-box.
                        IF brstat.tlt.releas = "" THEN brstat.tlt.releas  =  "NO" .
                        ELSE IF index(brstat.tlt.releas,"Cancel")  <> 0 THEN 
                            ASSIGN brstat.tlt.releas  =  "No/Cancel" .
                        ELSE ASSIGN brstat.tlt.releas  =  "No" .
                    END.
                    Else do:    /* no */
                        If  index(brstat.tlt.releas,"Yes")  =  0  Then do:  /* no */
                            message "Update Yes ข้อมูลรายการนี้  "  View-as alert-box.
                            IF brstat.tlt.releas = "" THEN brstat.tlt.releas  =  "Yes" .
                            ELSE IF index(brstat.tlt.releas,"Cancel")  <> 0 THEN 
                                ASSIGN brstat.tlt.releas  =  "Yes/Cancel" .
                            ELSE ASSIGN brstat.tlt.releas  =  "Yes" .
                        END.
                    END.
                END.
            END.
    END.
    ELSE DO:
   
        FIND FIRST brstat.tlt Where brstat.tlt.cha_no  >=  fi_datadelform AND
                                    brstat.tlt.cha_no  <=  fi_datadelto   AND 
                                    brstat.tlt.genusr  =   fi_producer2   NO-LOCK NO-ERROR.
            If  avail brstat.tlt Then do:
                FOR EACH brstat.tlt WHERE brstat.tlt.cha_no  >=  fi_datadelform AND   
                                          brstat.tlt.cha_no  <=  fi_datadelto   AND 
                                          brstat.tlt.genusr  =   fi_producer2   .
                    If  index(brstat.tlt.releas,"No")  =  0  Then do:    /* yes */
                        message "Update No ข้อมูลรายการนี้  "  View-as alert-box.
                        IF brstat.tlt.releas = "" THEN brstat.tlt.releas  =  "NO" .
                        ELSE IF index(brstat.tlt.releas,"Cancel")  <> 0 THEN 
                            ASSIGN brstat.tlt.releas  =  "No/Cancel" .
                        ELSE ASSIGN brstat.tlt.releas  =  "No" .
                    END.
                    Else do:    /* no */
                        If  index(brstat.tlt.releas,"Yes")  =  0  Then do:  /* no */
                            message "Update Yes ข้อมูลรายการนี้  "  View-as alert-box.
                            IF brstat.tlt.releas = "" THEN brstat.tlt.releas  =  "Yes" .
                            ELSE IF index(brstat.tlt.releas,"Cancel")  <> 0 THEN 
                                ASSIGN brstat.tlt.releas  =  "Yes/Cancel" .
                            ELSE ASSIGN brstat.tlt.releas  =  "Yes" .
                        END.
                    END.
                END.
            END.
    END.
     /* end : A64-0060 */
    /* comment by : A64-0060 ..
    FIND FIRST brstat.tlt Where brstat.tlt.cha_no  >=  fi_datadelform AND
                                brstat.tlt.cha_no  <=  fi_datadelto NO-LOCK NO-ERROR.
    If  avail brstat.tlt Then do:
        FOR EACH brstat.tlt WHERE brstat.tlt.cha_no  >=  fi_datadelform AND   
                                  brstat.tlt.cha_no  <=  fi_datadelto   NO-LOCK .
            If  index(brstat.tlt.releas,"No")  =  0  Then do:    /* yes */
                message "Update No ข้อมูลรายการนี้  "  View-as alert-box.
                IF brstat.tlt.releas = "" THEN brstat.tlt.releas  =  "NO" .
                ELSE IF index(brstat.tlt.releas,"Cancel")  <> 0 THEN 
                    ASSIGN brstat.tlt.releas  =  "No/Cancel" .
                ELSE ASSIGN brstat.tlt.releas  =  "No" .
            END.
            Else do:    /* no */
                If  index(brstat.tlt.releas,"Yes")  =  0  Then do:  /* no */
                    message "Update Yes ข้อมูลรายการนี้  "  View-as alert-box.
                    IF brstat.tlt.releas = "" THEN brstat.tlt.releas  =  "Yes" .
                    ELSE IF index(brstat.tlt.releas,"Cancel")  <> 0 THEN 
                        ASSIGN brstat.tlt.releas  =  "Yes/Cancel" .
                    ELSE ASSIGN brstat.tlt.releas  =  "Yes" .
                END.
            END.
        END.
    END.
    .. end : A64-0060 ...*/
    RUN Open_tlt2.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_updatecan
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_updatecan c-wins
ON CHOOSE OF bu_updatecan IN FRAME fr_main /* Cancel / OK */
DO:
    /*Find brstat.tlt Where Recid(brstat.tlt)  =  nv_rectlt.*/
    IF ra_bydelete = 1 THEN DO:

    END.
    ELSE DO:
        FIND FIRST brstat.tlt Where brstat.tlt.cha_no  >=  fi_datadelform AND
                              brstat.tlt.cha_no        <=  fi_datadelto   AND 
                              brstat.tlt.genusr        =   fi_producer2 NO-ERROR NO-WAIT.
        If  avail brstat.tlt Then do:
            FOR EACH brstat.tlt WHERE brstat.tlt.cha_no >=  fi_datadelform AND
                              brstat.tlt.cha_no         <=  fi_datadelto   AND 
                              brstat.tlt.genusr         =   fi_producer2 .
                If  index(brstat.tlt.releas,"/Cancel")  =  0  Then do:      /* cancel */
                    message brstat.tlt.cha_no + " Update Cancel ข้อมูลรายการนี้  "  View-as alert-box.
                    IF index(brstat.tlt.releas,"Yes") <> 0  THEN ASSIGN brstat.tlt.releas  =  "Yes/Cancel" .
                    ELSE ASSIGN brstat.tlt.releas  =  "No/Cancel"  .
                END.
                Else do:    /* no */
                    If   index(brstat.tlt.releas,"/Cancel")  <>  0   Then do:  /* no */
                        message brstat.tlt.cha_no + "ยกเลิก Cancel  ข้อมูลรายการนี้  "  View-as alert-box.
                        IF index(brstat.tlt.releas,"Yes") <> 0  THEN ASSIGN brstat.tlt.releas  =  "Yes" .
                        ELSE ASSIGN brstat.tlt.releas  =  "No"  .
                    END.
                END.
            END.
        END.  
    END.

    /* comment by : A64-0060 ...
    Find brstat.tlt Where brstat.tlt.cha_no  >=  fi_datadelform AND
                          brstat.tlt.cha_no  <=  fi_datadelto .
    If  avail brstat.tlt Then do:
        If  index(brstat.tlt.releas,"/Cancel")  =  0  Then do:      /* cancel */
            message "Update No ข้อมูลรายการนี้  "  View-as alert-box.
            IF index(brstat.tlt.releas,"Yes") <> 0  THEN ASSIGN brstat.tlt.releas  =  "Yes/Cancel" .
            ELSE ASSIGN brstat.tlt.releas  =  "No/Cancel"  .
        END.
        Else do:    /* no */
            If   index(brstat.tlt.releas,"/Cancel")  <>  0   Then do:  /* no */
                message "Update Yes ข้อมูลรายการนี้  "  View-as alert-box.
                IF index(brstat.tlt.releas,"Yes") <> 0  THEN ASSIGN brstat.tlt.releas  =  "Yes" .
                ELSE ASSIGN brstat.tlt.releas  =  "No"  .
            END.
        END. 
    END.  
    ... end A64-0060..*/  
    RUN Open_tlt2.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME cb_report
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cb_report c-wins
ON LEAVE OF cb_report IN FRAME fr_main
DO:
  
  
    /*p-------------*/
    cb_report = INPUT cb_report.
    n_asdat2 = INPUT cb_report.

    IF n_asdat2 = "" THEN DO:
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
    n_asdat2 =  (INPUT cb_report).
    IF      cb_report = "เลขกรมธรรม์"               THEN DO:  
        /*ASSIGN 
            fi_report     = ""
            fi_repolicyfr = "Policy Form" 
            fi_repolicyto = "Policy To"  .  
        DISP  fi_repolicyfr fi_repolicyto  WITH FRAM fr_main.*/
        APPLY "ENTRY" TO fi_repolicyfr_key .
        RETURN NO-APPLY.
    END.
    ELSE IF      cb_report = "สาขา"               THEN DO:  
       /* ASSIGN fi_report = "สาขา"  .  
        DISP fi_report WITH FRAM fr_main.*/
        APPLY "ENTRY" TO fi_reportdata .
        RETURN NO-APPLY.
    END.
   /* ELSE IF cb_report = "ประเภทความคุ้มครอง" THEN DO:  
        ASSIGN fi_report = "ประเภท" .   
        DISP fi_report WITH FRAM fr_main.
        APPLY "ENTRY" TO fi_reportdata .
        RETURN NO-APPLY.
    END.    
    ELSE DO:
        ASSIGN fi_report = ""
               fi_reportdata = "" .   
        DISP fi_report WITH FRAM fr_main.
        APPLY "ENTRY" TO fi_filename .
        RETURN NO-APPLY.
    END.  */
    IF n_asdat2 = "" THEN DO:
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


&Scoped-define SELF-NAME fi_datadelform
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_datadelform c-wins
ON LEAVE OF fi_datadelform IN FRAME fr_main
DO:
    fi_datadelform  =  INPUT fi_datadelform.
    Disp fi_datadelform  with frame fr_main.

    IF ra_bydelete = 1 THEN DO:
       IF DATE(fi_datadelform) = ? THEN
           MESSAGE "Input format date ('DD/MM/YYYY') ." VIEW-AS ALERT-BOX.
           APPLY "entry" TO fi_datadelform .
           RETURN NO-APPLY.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_datadelform c-wins
ON VALUE-CHANGED OF fi_datadelform IN FRAME fr_main
DO:
    fi_datadelform = INPUT fi_datadelform .
    DISP fi_datadelform WITH FRAME fr_main.
    
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_datadelto
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_datadelto c-wins
ON LEAVE OF fi_datadelto IN FRAME fr_main
DO:
    fi_datadelto =  Input  fi_datadelto  .
    Disp  fi_datadelto  with frame fr_main.

    IF ra_bydelete = 1 THEN DO:
       IF DATE(fi_datadelto) = ? THEN
           MESSAGE "Input format date ('DD/MM/YYYY') ." VIEW-AS ALERT-BOX.
           APPLY "entry" TO fi_datadelto .
           RETURN NO-APPLY.
    END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_datadelto c-wins
ON VALUE-CHANGED OF fi_datadelto IN FRAME fr_main
DO:
     fi_datadelto =  Input  fi_datadelto  .
    Disp  fi_datadelto  with frame fr_main.
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_filename
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_filename c-wins
ON LEAVE OF fi_filename IN FRAME fr_main
DO:
    fi_filename = INPUT fi_filename.
    DISP fi_filename WITH FRAM fr_main.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_inputfile
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_inputfile c-wins
ON LEAVE OF fi_inputfile IN FRAME fr_main
DO:
    fi_inputfile  =  Input  fi_inputfile .
    Disp  fi_inputfile with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_loaddate
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_loaddate c-wins
ON LEAVE OF fi_loaddate IN FRAME fr_main
DO:
    fi_loaddate  =  Input  fi_loaddate.
    Disp fi_loaddate  with frame fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_producer
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_producer c-wins
ON LEAVE OF fi_producer IN FRAME fr_main
DO:
    fi_producer = INPUT fi_producer.
    DISP fi_producer WITH FRAME fr_main.

    IF fi_producer <> "" THEN DO:
        FIND sicsyac.xmm600 USE-INDEX xmm60001   WHERE
            xmm600.acno  =  Input fi_producer    NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL sicsyac.xmm600 THEN DO:
            Message  "Not on Name & Address Master File xmm600" 
                View-as alert-box.
            Apply "Entry" To  fi_producer.
            Return no-apply.
        END.
        ELSE 
            ASSIGN fi_despro =  TRIM(xmm600.ntitle) + "  "  + TRIM(sicsyac.xmm600.name) .
            fi_producer =  INPUT  fi_producer.
            fi_producer2 = fi_producer.
    END.
    Disp  fi_producer  fi_despro fi_producer2 WITH Frame  fr_main.                 


END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_producer2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_producer2 c-wins
ON LEAVE OF fi_producer2 IN FRAME fr_main
DO:
    fi_producer2 = INPUT fi_producer2.
    DISP fi_producer2 WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_repolicyfr_key
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_repolicyfr_key c-wins
ON LEAVE OF fi_repolicyfr_key IN FRAME fr_main
DO:
    fi_repolicyfr_key = trim( INPUT fi_repolicyfr_key ).
    Disp  fi_repolicyfr_key  with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_repolicyto_key
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_repolicyto_key c-wins
ON LEAVE OF fi_repolicyto_key IN FRAME fr_main
DO:
    fi_repolicyto_key = trim( INPUT fi_repolicyto_key ).
    Disp  fi_repolicyto_key  with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_reportdata
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_reportdata c-wins
ON LEAVE OF fi_reportdata IN FRAME fr_main
DO:
    fi_reportdata = trim( INPUT fi_reportdata ).
    Disp  fi_reportdata  with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_search
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_search c-wins
ON LEAVE OF fi_search IN FRAME fr_main
DO:
    fi_search     =  Input  fi_search .
    Disp fi_search  with frame fr_main.
    If  cb_search =  "เลขกรมธรรม์"   Then do:               /* name  */
        Open Query br_tlt                      
            For each brstat.tlt Use-index  tlt01 Where
            brstat.tlt.trndat       >=  fi_trndatfr    And
            brstat.tlt.trndat       <=  fi_trndatto    And
            brstat.tlt.genusr        =  "til72"        And
            brstat.tlt.nor_noti_tlt  = trim(fi_search) no-lock.
                ASSIGN nv_rectlt =  recid(brstat.tlt) .
                Apply "Entry"  to br_tlt.
                Return no-apply.            
    END.
    ELSE IF  cb_search  = "สาขา"  THEN DO:
        Open Query br_tlt                      
            For each brstat.tlt Use-index  tlt01 Where
            brstat.tlt.trndat         >=  fi_trndatfr    And 
            brstat.tlt.trndat         <=  fi_trndatto    And 
            brstat.tlt.genusr          =  "til72"        And 
            brstat.tlt.comp_usr_tlt    = trim(fi_search) no-lock.
                ASSIGN nv_rectlt =  recid(brstat.tlt) .
                Apply "Entry"  to br_tlt.      
                Return no-apply.  
    END.
    ELSE If  cb_search  =  "เลขสติ๊กเกอร์"    Then do:        /* cedpol */  
        Open Query br_tlt                      
            For each brstat.tlt Use-index  tlt01   Where
            brstat.tlt.trndat   >=  fi_trndatfr    And 
            brstat.tlt.trndat   <=  fi_trndatto    And 
            brstat.tlt.genusr    =  "til72"        And 
            brstat.tlt.cha_no    = trim(fi_search) no-lock.
                ASSIGN nv_rectlt =  recid(brstat.tlt) .
                Apply "Entry"  to br_tlt.      
                Return no-apply.               
    END. 
    ELSE If  cb_search  =  "เลขที่ใบเสร็จ"  Then do:        /* prepol */  
        Open Query br_tlt                      
            For each brstat.tlt Use-index  tlt01 Where
            brstat.tlt.trndat   >=  fi_trndatfr  And 
            brstat.tlt.trndat   <=  fi_trndatto  And 
            brstat.tlt.genusr    =  "til72"       And 
            brstat.tlt.safe2     = trim(fi_search)  no-lock.
                ASSIGN nv_rectlt =  recid(brstat.tlt) .
                Apply "Entry"  to br_tlt.      
                Return no-apply.               
    END. 
    ELSE If  cb_search  =  "Release Yes" Then do:         /* not ..complete... */
        Open Query br_tlt                      
            For each brstat.tlt Use-index  tlt01      Where
            brstat.tlt.trndat         >=  fi_trndatfr And
            brstat.tlt.trndat         <=  fi_trndatto And
            brstat.tlt.genusr          =  "til72"     And
            brstat.tlt.releas          =  "Yes"       no-lock.
                ASSIGN nv_rectlt =  recid(brstat.tlt) .
                Apply "Entry"  to br_tlt.
                Return no-apply.                             
    END.
    ELSE If  cb_search  =  "Release No"  Then do:         /* not ..complete... */
        Open Query br_tlt                      
            For each brstat.tlt Use-index  tlt01      Where
            brstat.tlt.trndat         >=  fi_trndatfr And
            brstat.tlt.trndat         <=  fi_trndatto And
            brstat.tlt.genusr          =  "til72"     And
            brstat.tlt.releas          =  "No"        no-lock.
                ASSIGN nv_rectlt =  recid(brstat.tlt) .
                Apply "Entry"  to br_tlt.
                Return no-apply.                             
    END.
    ELSE If  cb_search  =  "Release cancel"  Then do:         /* not ..complete... */
        Open Query br_tlt                      
            For each brstat.tlt Use-index  tlt01      Where
            brstat.tlt.trndat         >=  fi_trndatfr And
            brstat.tlt.trndat         <=  fi_trndatto And
            brstat.tlt.genusr          =  "til72"     And
            brstat.tlt.releas          =  "Cancel"    no-lock.
                ASSIGN nv_rectlt =  recid(brstat.tlt) .
                Apply "Entry"  to br_tlt.
                Return no-apply.                             
    END.    
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


&Scoped-define SELF-NAME ra_bydelete
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_bydelete c-wins
ON VALUE-CHANGED OF ra_bydelete IN FRAME fr_main
DO:
    ra_bydelete = INPUT ra_bydelete .
    IF ra_bydelete = 1  THEN DO:
       ASSIGN  fi_datadelform = string(fi_trndatfr,"99/99/9999").
               fi_datadelto   = string(fi_trndatto,"99/99/9999").
    END.
    DISP ra_bydelete fi_datadelform fi_datadelto  WITH FRAM fr_main.
                         

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
    RECT-346:Move-to-top(). 
    /********************  T I T L E   F O R  C - W I N  ****************/
    DEF  VAR  gv_prgid   AS   CHAR.
    DEF  VAR  gv_prog    AS   CHAR.
    gv_prgid = "wgwstkb1".
    gv_prog  = "Query & Update DATA STK BU3".
    RUN  WUT\WUTHEAD ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).
    ASSIGN 
        fi_loaddate = TODAY
        fi_trndatfr = TODAY
        fi_trndatto = TODAY
        vAcProc_fil = vAcProc_fil   + "เลขกรมธรรม์"      + ","
                                    + "สาขา"             + ","   
                                    + "เลขสติ๊กเกอร์"    + ","   
                                    + "เลขที่ใบเสร็จ"    + "," 
                                    + "Release Yes"      + "," 
                                    + "Release No"       + "," 
                                    + "Release cancel"   + ","
        cb_search:LIST-ITEMS = vAcProc_fil
        cb_search = ENTRY(1,vAcProc_fil)
        vAcProc_fil2 = vAcProc_fil2 + "เลขกรมธรรม์"  + "," 
                                    + "สาขา"         + ","    
                                    + "Release Yes"  + "," 
                                    + "Release No"   + ","
                                    + "Release cancel"   + ","
                                    + "All"          + ","
        cb_report:LIST-ITEMS = vAcProc_fil2
        cb_report = ENTRY(1,vAcProc_fil2)
        cb_report =  "เลขกรมธรรม์"   
        ra_bydelete = 2 .
    RUN Open_tlt.
    Disp   ra_bydelete fi_loaddate cb_search cb_report fi_trndatfr  fi_trndatto   /*fi_report fi_repolicyfr fi_repolicyto*/ 
          fi_producer fi_producer2   with frame fr_main.
    /**************************** *****************************************/ 
    /*  RUN Wut\WutwiCen ({&WINDOW-NAME}:HANDLE). */ 
    /*CURRENT-WINDOW:WINDOW-STATE = WINDOW-MAXIMIZED.*/
    SESSION:DATA-ENTRY-RETURN = YES.
    RECT-346:Move-to-top(). 
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
  DISPLAY fi_loaddate fi_producer fi_inputfile fi_producer2 fi_trndatfr 
          fi_trndatto cb_search fi_search ra_bydelete fi_datadelform 
          fi_datadelto cb_report fi_reportdata fi_repolicyfr_key 
          fi_repolicyto_key fi_filename fi_despro 
      WITH FRAME fr_main IN WINDOW c-wins.
  ENABLE br_tlt fi_loaddate fi_producer fi_inputfile bu_file bu_imp 
         fi_producer2 fi_trndatfr fi_trndatto bu_ok cb_search fi_search bu_sch 
         ra_bydelete fi_datadelform fi_datadelto bu_update bu_updatecan 
         cb_report fi_reportdata fi_repolicyfr_key fi_repolicyto_key 
         fi_filename bu_reok bu_exit fi_despro RECT-332 RECT-343 RECT-346 
         RECT-494 RECT-495 RECT-496 RECT-497 RECT-499 RECT-500 RECT-501 
         RECT-502 
      WITH FRAME fr_main IN WINDOW c-wins.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW c-wins.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Import_notification1 c-wins 
PROCEDURE Import_notification1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH  wdetail :
    DELETE  wdetail.
END.
INPUT FROM VALUE(fi_inputfile).
REPEAT:
    CREATE wdetail.
    IMPORT DELIMITER "|" 
        wdetail.notifydate   /*  1  ลำดับที่       */  
        wdetail.policy       /*  2  เลขกรมธรรม์    */                                  
        wdetail.stk          /*  3  เลขสติ๊กเกอร์  */                                  
        wdetail.docno        /*  4  เลขที่ใบเสร็จ  */                   
        wdetail.remark    .  /*  5  หมายเหตุ       */
END.
ASSIGN 
    nv_countdata     = 0
    nv_countnotcomp  = 0.
    nv_countcomplete = 0.
FOR EACH wdetail .
    IF INDEX(wdetail.notifydate,"บริษัท") <> 0 THEN DELETE wdetail.
    ELSE IF INDEX(wdetail.notifydate,"ที่") <> 0 THEN DELETE wdetail.
    ELSE IF TRIM(wdetail.stk) = ""  THEN DELETE wdetail.  /* A64-0060*/
    ELSE IF wdetail.notifydate   <> " "         THEN  DO:
        ASSIGN  nv_countdata = nv_countdata  + 1.
        RUN proc_cutpolicy.
        IF substr(trim(wdetail.stk),1,1) <> "0"   THEN ASSIGN wdetail.stk  = "0" + TRIM(wdetail.stk).
        FIND FIRST brstat.tlt USE-INDEX tlt06   WHERE   
            brstat.tlt.cha_no   = trim(wdetail.stk)  NO-ERROR NO-WAIT .
        IF NOT AVAIL brstat.tlt THEN DO: 
            ASSIGN nv_countcomplete = nv_countcomplete + 1.
            CREATE brstat.tlt.
            ASSIGN
                brstat.tlt.entdat         = TODAY
                brstat.tlt.enttim         = STRING(TIME,"HH:MM:SS")
                brstat.tlt.trntime        = STRING(TIME,"HH:MM:SS")
                brstat.tlt.trndat         = fi_loaddate
                brstat.tlt.genusr         = trim(n_producer)      /* wdetail.Company   */ 
                brstat.tlt.nor_noti_tlt   = trim(wdetail.policy)  /* 3  เลขกรมธรรม์    */  
                brstat.tlt.cha_no         = trim(wdetail.stk)     /* 4  เลขสติ๊กเกอร์  */                    
                brstat.tlt.safe2          = TRIM(wdetail.docno)   /* 5  เลขที่ใบเสร็จ  */ 
                brstat.tlt.filler2        = trim(wdetail.remark)  /* 6  หมายเหตุ       */ 
                brstat.tlt.endno          = USERID(LDBNAME(1))    /* User Load Data    */
                brstat.tlt.imp            = "IM"                  /* Import Data       */
                brstat.tlt.releas         = "No"   .
            IF brstat.tlt.nor_noti_tlt <> "" THEN DO:
                IF SUBSTR(brstat.tlt.nor_noti_tlt,1,1) = "D" THEN
                    ASSIGN brstat.tlt.comp_usr_tlt   = SUBSTR(brstat.tlt.nor_noti_tlt,2,1).  /* สาขา 1 หลัก*/ 
                ELSE 
                    ASSIGN brstat.tlt.comp_usr_tlt   = SUBSTR(brstat.tlt.nor_noti_tlt,1,2).  /* สาขา 2 หลัก*/ 
            END.
            ELSE ASSIGN brstat.tlt.comp_usr_tlt   =  "".
            ASSIGN wdetail.pass = "Complete". 
        END.
        ELSE DO:
            ASSIGN wdetail.pass = "มีข้อมูลแล้ว Code : " + brstat.tlt.genusr  . 
            nv_countnotcomp = nv_countnotcomp + 1.
        END.
    END.
END.
RUN proc_reportimp.
Run Open_tlt.
Message "Load  Data Complete "  SKIP
    "จำนวนข้อมูลทั้งหมด:    "  nv_countdata      SKIP
    "จำนวนข้อมูลที่นำเข้า:  "  nv_countcomplete  SKIP
    "จำนวนข้อมูลที่ไม่สามารถนำเข้า:  "  nv_countnotcomp  View-as alert-box.  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Open_tlt c-wins 
PROCEDURE Open_tlt :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
Open Query br_tlt  For each brstat.tlt  NO-LOCK
     WHERE brstat.tlt.trndat     =  TODAY   and
           brstat.tlt.genusr     =  TRIM(n_producer)  
    BY brstat.tlt.nor_noti_tlt   .
    ASSIGN nv_rectlt =  recid(brstat.tlt) .
  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Open_tlt2 c-wins 
PROCEDURE Open_tlt2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
IF ra_bydelete = 1  THEN DO:
    Open Query br_tlt  For each brstat.tlt  NO-LOCK
        WHERE     brstat.tlt.trndat  >=   fi_trndatfr   And
                  brstat.tlt.trndat  <=   fi_trndatto   And
                  brstat.tlt.genusr   =   TRIM(n_producer)  
        BY brstat.tlt.nor_noti_tlt  .
        ASSIGN nv_rectlt =  recid(brstat.tlt) .
END.
ELSE DO:
    Open Query br_tlt FOR EACH brstat.tlt Where 
        Recid(brstat.tlt)  =  nv_rectlt NO-LOCK .
        ASSIGN nv_rectlt =  recid(brstat.tlt).  
    
END.
    

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_cutpolicy c-wins 
PROCEDURE proc_cutpolicy :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_i AS INT .
DEF VAR nv_c AS CHAR.
DEF VAR nv_l AS INT.
DEF VAR nv_p AS CHAR.
DEF VAR ind  AS INT.
ASSIGN 
    nv_c = trim(wdetail.policy)
    nv_i = 0
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
    ind = INDEX(nv_c,"_").
    IF ind <> 0 THEN DO:
        nv_c = TRIM (SUBSTRING(nv_c,1,ind - 1) + SUBSTRING(nv_c,ind + 1, nv_l)).
    END.
    ind = INDEX(nv_c,".").
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
    wdetail.policy  = nv_c . 
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
DEF VAR n_sck AS CHAR .
ASSIGN 
    n_producer = ""
    n_record = 0
    nv_cnt   = 0
    nv_row   = 1  .
If  substr(fi_filename,length(fi_filename) - 3,4) <>  ".csv"  THEN 
    fi_filename  =  Trim(fi_filename) + ".csv"  .

ASSIGN n_producer = fi_producer2
       nv_cnt  =  0
       nv_row  =  1.
OUTPUT TO VALUE(fi_filename). 
EXPORT DELIMITER "|" 
    "ข้อมูลกรมธรรม์/เลขสติ๊กเกอร์ : " + n_producer .
EXPORT DELIMITER "|" 
    "วันที่"  
    "สาขา "
    "เลขกรมธรรม์"
    "เลขสติ๊กเกอร์"
    "เลขที่ใบเสร็จ"
    "หมายเหตุ"
    "Status".
IF cb_report = "เลขกรมธรรม์"      THEN DO:
    FOR EACH brstat.tlt  NO-LOCK 
        WHERE brstat.tlt.nor_noti_tlt >=   fi_repolicyfr_key   And
        brstat.tlt.nor_noti_tlt       <=   fi_repolicyto_key   And
        brstat.tlt.genusr              =   TRIM(n_producer)   BREAK BY brstat.tlt.nor_noti_tlt  .
        EXPORT DELIMITER "|" 
            brstat.tlt.trndat         /*  1  วันที่         */  
            brstat.tlt.comp_usr_tlt   /*  2  สาขา           */  
            brstat.tlt.nor_noti_tlt   /*  3  เลขกรมธรรม์    */  
            brstat.tlt.cha_no         /*  4  เลขสติ๊กเกอร์  */  
            brstat.tlt.safe2          /*  5  เลขที่ใบเสร็จ  */  
            brstat.tlt.filler2        /*  6  หมายเหตุ       */  
            brstat.tlt.releas.
    END. 
END.
ELSE DO:
    FOR EACH brstat.tlt Use-index  tlt01  Where
        brstat.tlt.trndat        >=   fi_trndatfr   And
        brstat.tlt.trndat        <=   fi_trndatto   And
        brstat.tlt.genusr         =  TRIM(n_producer) NO-LOCK . 
        IF      (cb_report = "สาขา" ) AND (brstat.tlt.comp_usr_tlt <> trim(fi_reportdata))  THEN NEXT.
        ELSE IF (cb_report = "Release Yes") AND (index(brstat.tlt.releas,"yes") = 0 )       THEN NEXT.
        ELSE IF (cb_report = "Release No" ) AND (index(brstat.tlt.releas,"no")  = 0 )       THEN NEXT. 
        ELSE IF (cb_report = "Release Cancel") AND (index(brstat.tlt.releas,"Cancel") = 0 ) THEN NEXT. 
        EXPORT DELIMITER "|" 
            brstat.tlt.trndat         /*  1  วันที่         */  
            brstat.tlt.comp_usr_tlt   /*  2  สาขา           */  
            brstat.tlt.nor_noti_tlt   /*  3  เลขกรมธรรม์    */  
            brstat.tlt.cha_no         /*  4  เลขสติ๊กเกอร์  */  
            brstat.tlt.safe2          /*  5  เลขที่ใบเสร็จ  */  
            brstat.tlt.filler2        /*  6  หมายเหตุ       */  
            brstat.tlt.releas .
    END. 
END.
Message "Export data Complete"  View-as alert-box.
RELEASE brstat.tlt.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_reportimp c-wins 
PROCEDURE proc_reportimp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
If  substr(fi_inputfile,length(fi_inputfile) - 3,4) <>  "Error.csv"  THEN 
    fi_inputfile  =  Trim(fi_inputfile) + "Error.csv"  .
OUTPUT TO VALUE(fi_inputfile). 
EXPORT DELIMITER "|" 
    "ข้อมูลนำเข้าเลขสติ๊กเกอร์ : " + n_producer .
EXPORT DELIMITER "|" 
    "วันที่"  
    "สาขา "
    "เลขกรมธรรม์"
    "เลขสติ๊กเกอร์"
    "เลขที่ใบเสร็จ"
    "หมายเหตุ"
    "Status ".
FOR EACH wdetail WHERE wdetail.pass <> "Complete" NO-LOCK.
    EXPORT DELIMITER "|" 
    wdetail.notifydate  
    wdetail.branch      
    wdetail.policy      
    wdetail.stk         
    wdetail.docno
    wdetail.remark
    wdetail.pass.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

