&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
*/
&Scoped-define WINDOW-NAME wgwtrnon
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS wgwtrnon 
/*------------------------------------------------------------------------

  File: 

  Description: 

  Input Parameters:
      <none>

  Output Parameters:
      <none>

  Author: 

  Created: 
------------------------------------------------------------------------
 Create By : Sarinya C  A63-0319   16/12/2020  
           : Transfer Non Motor Policy To GW
------------------------------------------------------------------------*/
/*             correct st. releas and create vat                        */ 
/* Create an unnamed pool to store all the widgets created 
     by this procedure. This is a good default which assures
     that this procedure's triggers and internal procedures 
     will execute in this procedure's storage, and that proper
     cleanup will occur on deletion of the procedure.                   */

CREATE WIDGET-POOL.

/* ***************************  Definitions  ************************** */

/* Parameters Definitions ---                                           */

/* Local Variable Definitions ---                                       */
DEFINE VAR  nv_progid AS CHAR.  

DEF VAR nv_Recuwm100 AS RECID.
DEF VAR n_insref  AS CHAR.
                                         
/*DEF SHARED VAR n_user     AS   CHAR. ploy*/ 
DEF VAR n_user     AS   CHAR.
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
DEF VAR nv_RenCnt   AS INT FORMAT ">9".
DEF VAR nv_EndCnt   AS INT FORMAT "999".
DEF VAR nv_Branch   AS CHAR.
DEF VAR nv_next     AS LOGICAL.
DEF VAR nv_message  AS CHAR FORMAT "X(200)".
DEF VAR putchr      AS CHAR FORMAT "X(100)" INIT "" NO-UNDO.
DEF VAR putchr1     AS CHAR FORMAT "X(80)"  INIT "" NO-UNDO.
DEF VAR textchr     AS CHAR FORMAT "X(80)"  INIT "" NO-UNDO.
DEF VAR nv_trferr   AS CHAR FORMAT "X(80)"  INIT "" NO-UNDO.

DEF VAR nv_errfile AS CHAR FORMAT "X(30)"  INIT "" NO-UNDO.
DEF VAR nv_error   AS LOGICAL    INIT NO     NO-UNDO.

DEF BUFFER wk_uwm100 FOR CTXBRAN.uwm100.
DEF NEW SHARED STREAM ns1.
DEF NEW SHARED STREAM ns2.
DEF NEW SHARED STREAM ns3.
DEF NEW SHARED STREAM ns5.
DEF NEW SHARED STREAM ns6.

DEF TEMP-TABLE t_opnpol
    FIELD opnpol AS CHAR INIT "".
DEF NEW SHARED TEMP-TABLE t_policy
    FIELD opnpol AS CHAR INIT ""
    FIELD policy AS CHAR INIT ""
    FIELD nrecid AS RECID
    FIELD rencnt AS INT 
    FIELD endcnt AS INT
    FIELD trndat AS DATE
    FIELD entdat AS DATE
    FIELD usrid  AS CHAR  
    FIELD ntitle AS CHAR 
    FIELD name1  AS CHAR .
DEF VAR nv_err AS CHAR INIT "".
DEF WORKFILE w_chkbr
    FIELD branch   AS CHAR FORMAT "X(2)" 
    FIELD producer AS CHAR FORMAT "X(10)".
    
DEF WORKFILE w_polno
    FIELD trndat AS DATE FORMAT "99/99/9999"
    FIELD polno  AS CHAR FORMAT "X(20)"
    FIELD ntitle AS CHAR FORMAT "X(20)"
    FIELD name1  AS CHAR FORMAT "X(30)"
    FIELD rencnt AS INT  FORMAT "999"
    FIELD endcnt AS INT  FORMAT "999"
    FIELD trty11 AS CHAR FORMAT "X"
    FIELD docno1 AS CHAR FORMAT "X(10)"   
    FIELD agent  AS CHAR FORMAT "X(10)"
    FIELD acno1  AS CHAR FORMAT "X(10)"
    FIELD bchyr  AS INT FORMAT "9999"
    FIELD bchno  AS CHAR FORMAT "X(13)"
    FIELD bchcnt AS INT FORMAT "99"
    FIELD releas AS LOGICAL INIT NO
    FIELD modcod AS CHAR FORMAT "X(10)"
    FIELD moddes AS CHAR FORMAT "X(30)"
    .

DEF VAR nv_des    AS CHAR    INIT "".
DEF VAR nv_csuc   AS INT     INIT 0. /*count successs*/
DEF VAR nv_cnsuc  AS INT     INIT 0. /*Count not success*/

DEFINE            VAR nv_chk    AS   CHAR FORMAT "X".
DEFINE            VAR nv_vat    AS   LOGICAL .        
DEFINE            VAR nv_uwd132 AS   LOGICAL .        

DEF VAR nv_brnfile1   AS CHAR. 
DEF VAR nv_duprec1    AS CHAR.
DEF VAR nv_errfile1   AS CHAR FORMAT "X(30)"  INIT "" NO-UNDO.



DEF VAR nv_trnyes   AS LOGICAL  INIT NO  NO-UNDO.
DEF VAR s_recid1    AS RECID             NO-UNDO.  /* uwm100.recid */
DEF VAR gv_acm001OK AS LOG.
DEF VAR gv_acm002OK AS LOG.

DEF VAR nv_relok    AS INT.
DEF VAR nv_relerr   AS INT.
DEF VAR nv_relyet   AS LOG.

DEF VAR nv_out AS CHAR INIT "C:\GWTRANF\".


DEF VAR nv_poltyp AS CHAR INIT "".
DEF VAR nv_lookup AS INT  INIT 0.
DEF VAR nv_detyp  AS CHAR INIT "".
DEF VAR nv_age    AS INT  INIT 0.

DEF VAR nv_chkre  AS CHAR INIT "YES". 

DEF VAR nv_plist1 AS CHAR INIT "PA สมาชิกศรีกรุง".
DEF VAR n_index   AS INT  INIT 0.
DEF VAR n_cut     AS CHAR INIT "".
DEF NEW SHARED TEMP-TABLE tgroup 
    FIELD gcode  AS CHAR INIT ""
    FIELD ggroup AS INT  INIT 0
    FIELD gthai  AS CHAR INIT ""
    FIELD gplan  AS CHAR INIT ""
    FIELD gacno  AS CHAR INIT ""
    INDEX tgroup01 ggroup ASCENDING
    INDEX tgroup02 gthai  ASCENDING.

DEF BUFFER buwm100 FOR CTXBRAN.uwm100.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main
&Scoped-define BROWSE-NAME br_uwm100

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES w_polno

/* Definitions for BROWSE br_uwm100                                     */
&Scoped-define FIELDS-IN-QUERY-br_uwm100 w_polno.trndat w_polno.polno STRING(w_polno.RenCnt,"99") + "/" + STRING(w_polno.EndCnt,"999") w_polno.ntitle + " " + w_polno.name1 w_polno.trty11 w_polno.docno1 /*Kridtiya i. A63-00029*/ w_polno.modcod w_polno.moddes w_polno.agent w_polno.acno1 w_polno.bchyr w_polno.bchno w_polno.bchcnt w_polno.releas   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_uwm100   
&Scoped-define SELF-NAME br_uwm100
&Scoped-define QUERY-STRING-br_uwm100 FOR EACH w_polno NO-LOCK BY w_polno.polno
&Scoped-define OPEN-QUERY-br_uwm100 OPEN QUERY br_uwm100 FOR EACH w_polno NO-LOCK BY w_polno.polno.
&Scoped-define TABLES-IN-QUERY-br_uwm100 w_polno
&Scoped-define FIRST-TABLE-IN-QUERY-br_uwm100 w_polno


/* Definitions for FRAME fr_main                                        */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS br_uwm100 fi_TrnDate fi_trndatt co_poltyp ~
fi_acno bu_refresh fi_Policyfr fi_Policyto bu_exit bu_Transfer fi_brnfile ~
fi_TranPol fi_errfile fi_strTime fi_time fi_TotalTime fi_File fi_relOk ~
fi_relerr fi_duprec fi_Success RECT-1 RECT-636 RECT-2 RECT-640 RECT-649 ~
RECT-3 
&Scoped-Define DISPLAYED-OBJECTS fi_proce fi_acdes fi_TrnDate fi_trndatt ~
co_poltyp fi_acno fi_Policyfr fi_Policyto fi_poldes fi_brnfile fi_TranPol ~
fi_errfile fi_strTime fi_time fi_TotalTime fi_File fi_relOk fi_relerr ~
fi_duprec fi_Success 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR wgwtrnon AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bu_exit AUTO-END-KEY 
     LABEL "EXIT" 
     SIZE 16 BY 1.43
     FONT 6.

DEFINE BUTTON bu_refresh 
     IMAGE-UP FILE "wimage/flipu.bmp":U
     LABEL "" 
     SIZE 11.17 BY 1.14.

DEFINE BUTTON bu_Transfer 
     LABEL "TRANSFER TO GW" 
     SIZE 21.5 BY 1.43
     FONT 6.

DEFINE VARIABLE co_poltyp AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEMS "Item 1" 
     DROP-DOWN-LIST
     SIZE 10.33 BY 1
     FONT 6 NO-UNDO.

DEFINE VARIABLE fi_acdes AS CHARACTER FORMAT "X(30)":U 
     LABEL "" 
     VIEW-AS FILL-IN 
     SIZE 38.5 BY 1
     FONT 6 NO-UNDO.

DEFINE VARIABLE fi_acno AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 15.83 BY 1
     FONT 6 NO-UNDO.

DEFINE VARIABLE fi_brnfile AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 50 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_duprec AS CHARACTER FORMAT "X(100)":U 
      VIEW-AS TEXT 
     SIZE 50 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_errfile AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 50 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_File AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 50 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_poldes AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 27.17 BY 1
     FONT 6 NO-UNDO.

DEFINE VARIABLE fi_Policyfr AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 23 BY 1
     FONT 6 NO-UNDO.

DEFINE VARIABLE fi_Policyto AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 23 BY 1
     FONT 6 NO-UNDO.

DEFINE VARIABLE fi_proce AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 22.5 BY 1
     BGCOLOR 19 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_relerr AS CHARACTER FORMAT "X(100)":U 
      VIEW-AS TEXT 
     SIZE 50 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_relOk AS CHARACTER FORMAT "X(100)":U 
      VIEW-AS TEXT 
     SIZE 50 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_strTime AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 12 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_Success AS INTEGER FORMAT ">>>>,>>9":U INITIAL 0 
      VIEW-AS TEXT 
     SIZE 10 BY 1
     BGCOLOR 15 FGCOLOR 5 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_time AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 12 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_TotalTime AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 12 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_TranPol AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 50 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_TrnDate AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 15.5 BY 1
     FONT 6 NO-UNDO.

DEFINE VARIABLE fi_trndatt AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 15.5 BY 1
     FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 114.67 BY 1.29
     BGCOLOR 32 FGCOLOR 3 .

DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 19 BY 2.14
     BGCOLOR 4 .

DEFINE RECTANGLE RECT-3
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 23.5 BY 2.14
     BGCOLOR 62 .

DEFINE RECTANGLE RECT-636
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 114.5 BY 17.62
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-640
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 12.67 BY 1.52
     BGCOLOR 62 .

DEFINE RECTANGLE RECT-649
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 78.67 BY 10.57.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_uwm100 FOR 
      w_polno SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_uwm100
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_uwm100 wgwtrnon _FREEFORM
  QUERY br_uwm100 DISPLAY
      w_polno.trndat COLUMN-LABEL "Trn Date"       FORMAT "99/99/9999"
w_polno.polno  COLUMN-LABEL "Policy No"      FORMAT "X(14)"
STRING(w_polno.RenCnt,"99") + "/" +  STRING(w_polno.EndCnt,"999") COLUMN-LABEL "R/E"
w_polno.ntitle + " "  + w_polno.name1 COLUMN-LABEL "Insure" FORMAT "X(25)"
w_polno.trty11 COLUMN-LABEL "Ty1"            FORMAT "X"
w_polno.docno1 COLUMN-LABEL "Doc.no.1"       FORMAT "X(10)"   /*Kridtiya i. A63-00029*/
w_polno.modcod COLUMN-LABEL "Open Policy"    FORMAT "X(20)"
w_polno.moddes COLUMN-LABEL "Group"          FORMAT "X(25)"
w_polno.agent  COLUMN-LABEL "Agent Code"     FORMAT "X(10)"
w_polno.acno1  COLUMN-LABEL "Account no."    FORMAT "X(10)"
w_polno.bchyr  COLUMN-LABEL "Bch Year"       FORMAT "9999"
w_polno.bchno  COLUMN-LABEL "Bch No."        FORMAT "X(20)"
w_polno.bchcnt COLUMN-LABEL "Batch Cnt."     FORMAT "99"
w_polno.releas COLUMN-LABEL "Releas"         FORMAT "Yes/No"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 113.33 BY 6.43 ROW-HEIGHT-CHARS .52 FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     br_uwm100 AT ROW 5.29 COL 2.17
     fi_proce AT ROW 14.33 COL 26.83 RIGHT-ALIGNED NO-LABEL
     fi_acdes AT ROW 3.67 COL 32.5 COLON-ALIGNED
     fi_TrnDate AT ROW 2.48 COL 15.67 COLON-ALIGNED NO-LABEL
     fi_trndatt AT ROW 2.48 COL 35.33 COLON-ALIGNED NO-LABEL
     co_poltyp AT ROW 2.48 COL 61.17 COLON-ALIGNED NO-LABEL
     fi_acno AT ROW 3.67 COL 15.67 COLON-ALIGNED NO-LABEL
     bu_refresh AT ROW 2.71 COL 103
     fi_Policyfr AT ROW 13.38 COL 85.83 COLON-ALIGNED NO-LABEL
     fi_Policyto AT ROW 14.57 COL 85.83 COLON-ALIGNED NO-LABEL
     bu_exit AT ROW 18.76 COL 91.5
     bu_Transfer AT ROW 16.43 COL 88.5
     fi_poldes AT ROW 2.43 COL 72 COLON-ALIGNED NO-LABEL
     fi_brnfile AT ROW 13.19 COL 27.17 COLON-ALIGNED NO-LABEL
     fi_TranPol AT ROW 14.29 COL 27.17 COLON-ALIGNED NO-LABEL
     fi_errfile AT ROW 16.48 COL 27.17 COLON-ALIGNED NO-LABEL
     fi_strTime AT ROW 18.71 COL 27 COLON-ALIGNED NO-LABEL
     fi_time AT ROW 18.71 COL 45 COLON-ALIGNED NO-LABEL
     fi_TotalTime AT ROW 18.71 COL 65 COLON-ALIGNED NO-LABEL
     fi_File AT ROW 15.38 COL 27.17 COLON-ALIGNED NO-LABEL
     fi_relOk AT ROW 19.86 COL 27 COLON-ALIGNED NO-LABEL
     fi_relerr AT ROW 21 COL 26.83 COLON-ALIGNED NO-LABEL
     fi_duprec AT ROW 17.57 COL 27.17 COLON-ALIGNED NO-LABEL
     fi_Success AT ROW 3.62 COL 83 COLON-ALIGNED NO-LABEL WIDGET-ID 80
     "From" VIEW-AS TEXT
          SIZE 6.17 BY .95 AT ROW 13.33 COL 81.33
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "To" VIEW-AS TEXT
          SIZE 3.5 BY 1 AT ROW 2.48 COL 33.67
          FONT 6
     "Transfer Error put to file" VIEW-AS TEXT
          SIZE 23.5 BY .95 AT ROW 16.43 COL 5
          BGCOLOR 19 FGCOLOR 5 FONT 6
     "Policy No. Write to file" VIEW-AS TEXT
          SIZE 22 BY .95 AT ROW 13.19 COL 6.17
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "Total" VIEW-AS TEXT
          SIZE 5.83 BY .95 AT ROW 18.71 COL 60.33
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "Start Time" VIEW-AS TEXT
          SIZE 10.5 BY .95 AT ROW 18.71 COL 17.67
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "Pol. type" VIEW-AS TEXT
          SIZE 9.33 BY 1 AT ROW 2.48 COL 53.5
          FONT 6
     "End" VIEW-AS TEXT
          SIZE 4 BY .95 AT ROW 18.76 COL 41.83
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "    Show Detail Transfer" VIEW-AS TEXT
          SIZE 78 BY .95 AT ROW 11.95 COL 2.33
          BGCOLOR 14 FGCOLOR 5 FONT 6
     "   Policy Transfer" VIEW-AS TEXT
          SIZE 34.5 BY .95 AT ROW 11.95 COL 80.83
          BGCOLOR 14 FGCOLOR 5 FONT 6
     "Policy Duplicate put to file" VIEW-AS TEXT
          SIZE 25.67 BY .95 AT ROW 17.57 COL 2.5
          BGCOLOR 19 FGCOLOR 5 FONT 6
     "Policy Release Completed" VIEW-AS TEXT
          SIZE 25.33 BY .95 AT ROW 19.86 COL 2.83
          BGCOLOR 19 FGCOLOR 4 FONT 6
     "Transfer Data Citrix Non Motor Policy To GW" VIEW-AS TEXT
          SIZE 43.5 BY .91 AT ROW 1.24 COL 36.83
          BGCOLOR 32 FGCOLOR 2 FONT 6
     "Success" VIEW-AS TEXT
          SIZE 9.33 BY 1 AT ROW 3.62 COL 74 WIDGET-ID 82
          FONT 6
     "Tran.Date From" VIEW-AS TEXT
          SIZE 15.17 BY 1 AT ROW 2.48 COL 1.83
          FONT 6
     "Policy Release Error" VIEW-AS TEXT
          SIZE 20.17 BY .95 AT ROW 21 COL 8.33
          BGCOLOR 19 FGCOLOR 4 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 115.17 BY 21.71.

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "Account Code :" VIEW-AS TEXT
          SIZE 15.33 BY 1 AT ROW 3.71 COL 1.83
          FONT 6
     "To" VIEW-AS TEXT
          SIZE 3.17 BY .95 AT ROW 14.52 COL 83.17
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "Update File" VIEW-AS TEXT
          SIZE 11 BY .95 AT ROW 15.33 COL 16.67
          BGCOLOR 19 FGCOLOR 1 FONT 6
     RECT-1 AT ROW 1.05 COL 1.33
     RECT-636 AT ROW 5.05 COL 1.5
     RECT-2 AT ROW 18.43 COL 107.83 RIGHT-ALIGNED
     RECT-640 AT ROW 2.52 COL 102.33
     RECT-649 AT ROW 11.86 COL 2.17
     RECT-3 AT ROW 16.05 COL 110 RIGHT-ALIGNED
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 115.17 BY 21.71.


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
  CREATE WINDOW wgwtrnon ASSIGN
         HIDDEN             = YES
         TITLE              = "wgwTrnGW : Transfer Data Citrix Non Motor Policy To GW"
         HEIGHT             = 21.67
         WIDTH              = 115.33
         MAX-HEIGHT         = 46.43
         MAX-WIDTH          = 213.33
         VIRTUAL-HEIGHT     = 46.43
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
IF NOT wgwtrnon:LOAD-ICON("wimage/iconhead.ico":U) THEN
    MESSAGE "Unable to load icon: wimage/iconhead.ico"
            VIEW-AS ALERT-BOX WARNING BUTTONS OK.
&ENDIF
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW wgwtrnon
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME fr_main
   FRAME-NAME Custom                                                    */
/* BROWSE-TAB br_uwm100 1 fr_main */
/* SETTINGS FOR FILL-IN fi_acdes IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_poldes IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_proce IN FRAME fr_main
   NO-ENABLE ALIGN-R                                                    */
/* SETTINGS FOR RECTANGLE RECT-2 IN FRAME fr_main
   ALIGN-R                                                              */
/* SETTINGS FOR RECTANGLE RECT-3 IN FRAME fr_main
   ALIGN-R                                                              */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(wgwtrnon)
THEN wgwtrnon:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_uwm100
/* Query rebuild information for BROWSE br_uwm100
     _START_FREEFORM
OPEN QUERY br_uwm100 FOR EACH w_polno NO-LOCK BY w_polno.polno.
     _END_FREEFORM
     _Query            is NOT OPENED
*/  /* BROWSE br_uwm100 */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME wgwtrnon
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wgwtrnon wgwtrnon
ON END-ERROR OF wgwtrnon /* wgwTrnGW : Transfer Data Citrix Non Motor Policy To GW */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wgwtrnon wgwtrnon
ON WINDOW-CLOSE OF wgwtrnon /* wgwTrnGW : Transfer Data Citrix Non Motor Policy To GW */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br_uwm100
&Scoped-define SELF-NAME br_uwm100
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_uwm100 wgwtrnon
ON MOUSE-SELECT-DBLCLICK OF br_uwm100 IN FRAME fr_main
DO:
   fi_Policyfr = w_polno.polno .
   DISP  fi_Policyfr WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_uwm100 wgwtrnon
ON ROW-DISPLAY OF br_uwm100 IN FRAME fr_main
DO:
    /*--- Add A57-0300 ---*/
    IF w_polno.modcod = "" AND (co_poltyp = "V70" OR co_poltyp = "V72" OR co_poltyp = "V73" OR
                                co_poltyp = "V74" OR (co_poltyp = "M64" AND SUBSTR(w_polno.polno,1,1) = "C")) THEN DO:

        w_polno.polno :BGCOLOR IN BROWSE br_uwm100 = 4 NO-ERROR.
        w_polno.modcod:BGCOLOR IN BROWSE br_uwm100 = 4 NO-ERROR.
        w_polno.moddes:BGCOLOR IN BROWSE br_uwm100 = 4 NO-ERROR.

        w_polno.polno :FGCOLOR IN BROWSE br_uwm100 = 17 NO-ERROR.
        w_polno.modcod:FGCOLOR IN BROWSE br_uwm100 = 17 NO-ERROR.
        w_polno.moddes:FGCOLOR IN BROWSE br_uwm100 = 17 NO-ERROR.

        w_polno.polno :FONT IN BROWSE br_uwm100 = 7 NO-ERROR.
        w_polno.modcod:FONT IN BROWSE br_uwm100 = 7 NO-ERROR.
        w_polno.moddes:FONT IN BROWSE br_uwm100 = 7 NO-ERROR.

    END.
    /*--- End A57-0300 ---*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_exit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_exit wgwtrnon
ON CHOOSE OF bu_exit IN FRAME fr_main /* EXIT */
DO:
APPLY  "CLOSE"  TO THIS-PROCEDURE.
RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_refresh
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_refresh wgwtrnon
ON CHOOSE OF bu_refresh IN FRAME fr_main
DO:
    ASSIGN
        fi_trndate = INPUT fi_trndate
        fi_Trndatt = INPUT fi_Trndatt
        fi_acno = CAPS(TRIM(INPUT fi_acno)).

    
    IF fi_trndatt < fi_trndate THEN DO:
        MESSAGE "Transaction Date to ต้องมากกว่า Transaction Date Form!!!"  VIEW-AS ALERT-BOX INFORMATION.
        APPLY "ENTRY"  TO fi_trndatt.
        RETURN NO-APPLY.
    END.

    IF fi_acno = "" THEN DO:
        MESSAGE "Please Insert Data Account Code!!" VIEW-AS ALERT-BOX INFORMATION.
        APPLY "ENTRY"  TO fi_acno.
        RETURN NO-APPLY.
    END.

    RUN PDUpdateQ.

    DISP  fi_Success WITH FRAME fr_main.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_Transfer
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_Transfer wgwtrnon
ON CHOOSE OF bu_Transfer IN FRAME fr_main /* TRANSFER TO GW */
DO:
    ASSIGN
        fi_trndate  = INPUT fi_trndate
        fi_Trndatt  = INPUT fi_Trndatt
        fi_acno     = CAPS(TRIM(INPUT fi_acno))
        fi_policyfr = INPUT fi_policyfr
        fi_policyto = INPUT fi_policyto .

    IF fi_trndatt < fi_trndate THEN DO:
        MESSAGE "Transaction Date to ต้องมากกว่า Transaction Date Form!!!"  VIEW-AS ALERT-BOX INFORMATION.
        APPLY "ENTRY"  TO fi_trndatt.
        RETURN NO-APPLY.
    END.

    IF fi_acno = "" THEN DO:
        MESSAGE "Please Insert Data Account Code!!" VIEW-AS ALERT-BOX INFORMATION.
        APPLY "ENTRY"  TO fi_acno.
        RETURN NO-APPLY.
    END.
    
    IF fi_policyfr = "" THEN DO:
        MESSAGE "Policy From is Mandatory" VIEW-AS ALERT-BOX INFORMATION.
        APPLY "ENTRY"  TO fi_policyfr.
        RETURN NO-APPLY.
    END.

    IF fi_policyto = "" THEN DO:
        MESSAGE "Policy To is mandatory" VIEW-AS ALERT-BOX INFORMATION.
        APPLY "ENTRY"  TO fi_policyto.
        RETURN NO-APPLY.
    END.

    IF fi_policyfr > fi_policyto THEN DO:
        MESSAGE "Policy From ต้องน้อยกว่า Policy TO" VIEW-AS ALERT-BOX INFORMATION.
        APPLY "ENTRY"  TO fi_policyto.
        RETURN NO-APPLY.
    END.

    fi_proce     = "Transfer Policy".
    DISP fi_proce WITH FRAME fr_main.

    ASSIGN
     fi_brnfile   = ""
     fi_TranPol   = ""
     fi_File      = ""
     fi_errfile   = "" 
     fi_strTime   = "" 
     fi_time      = "" 
     fi_TotalTime = ""
     nv_Insno     = ""
     nv_total     = ""
     nv_start     = STRING(TIME,"HH:MM:SS")
     fi_strTime   = STRING(TIME,"HH:MM:SS")
     nv_timestart = TIME
     nv_timeend   = TIME
     nv_polmst    = ""
     fi_relOk     = ""
     fi_relerr    = ""
     nv_relok     = 0
     nv_relerr    = 0
     nv_csuc      = 0
     nv_cnsuc     = 0.

    IF SEARCH(nv_out) = ? OR SEARCH(nv_out) = "" THEN DO:
        OS-COMMAND SILENT MD VALUE (nv_out).  /*Create Folder*/
    END. 

    nv_errfile   = "C:\GWTRANF\" + 
                             STRING(CAPS(n_user)) + "_" +
                           STRING(MONTH(TODAY),"99")    + 
                           STRING(DAY(TODAY),"99")      + 
                 SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) + 
                 SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2) + ".err".

    nv_brnfile   = "C:\GWTRANF\" + 
                             STRING(CAPS(n_user)) + "_" +
                           STRING(MONTH(TODAY),"99")    +
                           STRING(DAY(TODAY),"99")      +
                 SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) +
                 SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2) + ".fuw".

    nv_duprec    = "C:\GWTRANF\" +                  
                             STRING(CAPS(n_user)) + "_" +
                           STRING(MONTH(TODAY),"99")    +
                           STRING(DAY(TODAY),"99")      +
                 SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) + 
                 SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2) + ".dup".    

    nv_errfile1  = "C:\GWTRANF\" + "REL_"               +
                                   STRING(CAPS(n_user)) +
                           STRING(MONTH(TODAY),"99")    + 
                           STRING(DAY(TODAY),"99")      + 
                 SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) + 
                 SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2) + ".err".

    nv_brnfile1  = "C:\GWTRANF\" + "REL_"               +
                                   STRING(CAPS(n_user)) +
                           STRING(MONTH(TODAY),"99")    +
                           STRING(DAY(TODAY),"99")      +
                 SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) +
                 SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2) + ".fuw".

    OUTPUT STREAM ns1 TO VALUE(nv_errfile).  
    OUTPUT STREAM ns2 TO VALUE(nv_brnfile).  
    OUTPUT STREAM ns3 TO VALUE(nv_duprec).  

    OUTPUT STREAM ns5 TO VALUE(nv_errfile1).
    OUTPUT STREAM ns6 TO VALUE(nv_brnfile1).

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
       "  Batch File : " nv_batchyr "/" nv_batchno "/" nv_batcnt SKIP.
   PUT STREAM ns2 FILL("-",100) FORMAT "X(100)" SKIP.
   PUT STREAM ns2 "Ceding Pol.       R/E    Policy No.        R/E    Trn.Date    Ent.Date    UserID   Insure Name " SKIP.

   /*---Header Dup---*/
   PUT STREAM ns3
   "Transfer Duplicate   "
   "Transfer Date : " TODAY  FORMAT "99/99/9999"
   "  Time : " STRING(TIME,"HH:MM:SS") 
   "  Batch File : " nv_batchyr "/" nv_batchno "/" nv_batcnt SKIP.
   PUT STREAM ns3 FILL("-",100) FORMAT "X(100)" SKIP.
   PUT STREAM ns3 "Policy No.      R/E    Dup. on Policy No.   R/E " SKIP.
   /*----------------*/
   
   /*---Header Release Completed---*/
   PUT STREAM ns5
   "Release Completed   "
   "Release Date : " TODAY  FORMAT "99/99/9999"
   "  Time : " STRING(TIME,"HH:MM:SS") 
   "  Batch File : " nv_batchyr "/" nv_batchno "/" nv_batcnt SKIP.
   PUT STREAM ns5 FILL("-",100) FORMAT "X(100)" SKIP.
   PUT STREAM ns5 "Ceding Pol.       R/E    Policy No.        R/E    Trn.Date    Ent.Date    UserID    Insure Name " SKIP.
   /*----------------*/
   /*---Header Release Error ---*/
   PUT STREAM ns6
   "Release Error   "
   "Release Date : " TODAY  FORMAT "99/99/9999"
   "  Time : " STRING(TIME,"HH:MM:SS") 
   "  Batch File : " nv_batchyr "/" nv_batchno "/" nv_batcnt SKIP.
   PUT STREAM ns6 FILL("-",100) FORMAT "X(100)" SKIP.
   PUT STREAM ns6 "Policy No.      R/E     TrnType Docno    Rel.Date    UserID    Insure Name " SKIP.
   /*----------------*/
  


FOR EACH t_opnpol:
    DELETE t_opnpol.
END.
FOR EACH t_policy:
    DELETE t_policy.
END.
FOR EACH w_polno WHERE 
    w_polno.polno >= fi_policyfr AND 
    w_polno.polno <= fi_policyto NO-LOCK BREAK BY w_polno.polno.

    FIND FIRST  CTXBRAN.uwm100 USE-INDEX  uwm10001
    WHERE CTXBRAN.uwm100.policy = w_polno.polno  AND
          CTXBRAN.uwm100.rencnt = w_polno.rencnt AND
          CTXBRAN.uwm100.endcnt = w_polno.endcnt NO-ERROR.
    IF AVAIL uwm100 THEN DO:
        
        ASSIGN
         nv_Policy  = CTXBRAN.uwm100.Policy
         nv_RenCnt  = CTXBRAN.uwm100.RenCnt
         nv_EndCnt  = CTXBRAN.uwm100.EndCnt
         nv_Insno   = CTXBRAN.uwm100.insref.

         s_recid1  = RECID(uwm100).

         /*DO:*/
         ASSIGN
            fi_brnfile = nv_brnfile
            fi_errfile = nv_errfile
            fi_duprec  = nv_duprec.

         DISP fi_brnfile fi_errfile fi_duprec fi_strTime WITH FRAME fr_main.
         
         ASSIGN
             nv_error = NO
             fi_TranPol =  "Process :" + STRING(CTXBRAN.uwm100.Policy,"XX-XX-XX/XXXXXX") + " " + 
                           STRING(CTXBRAN.uwm100.RenCnt,"99") + "/" +
                           STRING(CTXBRAN.uwm100.EndCnt,"999") + "      " +
                           CTXBRAN.uwm100.Name1
             fi_time    = STRING(TIME,"HH:MM:SS")
             nv_timeend = TIME.

         nv_RecUwm100 = RECID(CTXBRAN.uwm100).
        
         IF co_poltyp = "M64" AND SUBSTR(CTXBRAN.uwm100.policy,1,1) = "C" THEN DO:  /*Cers PA*/
            /* RUN PDCheckns1. ploy*/
             DISP  fi_TranPol fi_time WITH FRAME fr_main.

             IF nv_error = NO THEN DO:      

                 nv_csuc  = nv_csuc + 1.
                 
                 DISPLAY  "uwm100" @ fi_File WITH FRAME fr_main.
                 
                 DO TRANSACTION: 

                     RUN WGW\WGWGwCtx.p 
                         (  nv_Policy
                          , nv_RenCnt
                          , nv_EndCnt
                          , 0                       /* RECID(uwm100) */
                          , "1883"  /* GSE  */
                          , "PA" /* PA , TA */
                          , "P200").  /* P100 , PA2M , APSP , APYP */
                 END. 
            
                 IF nv_error = NO THEN DO:
            
                     PUT STREAM ns2
                        CTXBRAN.uwm100.policy FORMAT "x(16)" " " 
                        CTXBRAN.uwm100.rencnt "/" CTXBRAN.uwm100.endcnt "  " 
                        nv_policy FORMAT "X(16)" " "
                        nv_rencnt "/" nv_endcnt "  "
                        CTXBRAN.uwm100.trndat "  "
                        CTXBRAN.uwm100.entdat "  "
                        CTXBRAN.uwm100.usrid "   " 
                        TRIM(TRIM(CTXBRAN.uwm100.ntitle) + " " + 
                        TRIM(CTXBRAN.uwm100.name1)) FORMAT "x(60)" SKIP.
            
                     
                     fi_relerr = nv_errfile1.
                     fi_relok  = nv_brnfile1.
                     DISP fi_relok fi_relerr WITH FRAME fr_main.
     
                     /*RUN PD_ChkRelease.  ploy*/
                 END.
         
             END. /*nv_error = no*/
             ELSE nv_cnsuc  = nv_cnsuc + 1.

         END. /*M64*/

    END.  /*For each*/
    
    RELEASE CTXBRAN.uwm100.
    /*RELEASE sicuw.uwm100.*/

END.  /*---for each */

OUTPUT STREAM ns1 close.
OUTPUT STREAM ns2 close.
OUTPUT STREAM ns3 CLOSE.
OUTPUT STREAM ns5 close.
OUTPUT STREAM ns6 close.

fi_TotalTime    = STRING((nv_timeend - nv_timestart),"HH:MM:SS").
DISP  fi_TotalTime WITH FRAME fr_main.


IF nv_cnsuc = 0 THEN
    MESSAGE "Transfer Data To Premium Complete..!"  nv_csuc   "Records"  VIEW-AS ALERT-BOX INFORMATION.
ELSE
    MESSAGE "Transfer Data To Premium Complete..!"  nv_csuc   "Records" SKIP 
        "Not Success..................!"  nv_cnsuc  "Records" VIEW-AS ALERT-BOX INFORMATION.

RUN PDUpdateQ.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME co_poltyp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL co_poltyp wgwtrnon
ON RETURN OF co_poltyp IN FRAME fr_main
DO:
    co_poltyp = INPUT co_poltyp.

    FIND FIRST CTXBRAN.xmm031 USE-INDEX xmm03101 WHERE
        xmm031.poltyp = co_poltyp NO-LOCK NO-ERROR.
    IF AVAIL CTXBRAN.xmm031 THEN
        fi_poldes = CTXBRAN.xmm031.poldes.
    DISP fi_poldes WITH FRAME fr_main.

    APPLY "ENTRY"  TO fi_acno.
    RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL co_poltyp wgwtrnon
ON VALUE-CHANGED OF co_poltyp IN FRAME fr_main
DO:
    co_poltyp = INPUT co_poltyp.

    FIND FIRST CTXBRAN.xmm031 USE-INDEX xmm03101 WHERE
        xmm031.poltyp = co_poltyp NO-LOCK NO-ERROR.
    IF AVAIL CTXBRAN.xmm031 THEN
        ASSIGN
            nv_detyp  = CTXBRAN.xmm031.dept
            fi_poldes = CTXBRAN.xmm031.poldes.

    IF co_poltyp = "M64" THEN
        fi_proce     = "Process Cer Policy".
    ELSE
        fi_proce     = "Transfer Policy".

   IF co_poltyp = "M64" THEN DO:
       FOR EACH tgroup :
           DELETE tgroup.
       END.
       /**** ploy
       FOR EACH sicsyac.xcpara49 WHERE 
           xcpara49.CLASS   = "GRPPROD"   AND
           xcpara49.TYPE[3] = "M64"       AND
           /*(SUBSTR(xcpara49.TYPE[1],1,5)  = "PASKG"  OR SUBSTR(xcpara49.TYPE[1],1,5)  = "PAGSE")    AND*/ /*Sarinya C A63-0319*/
           xcpara49.TYPE[6]              = "PRODUCT"   AND 
           SUBSTR(xcpara49.TYPE[7],1,4)  = "PLAN"   NO-LOCK:
           ASSIGN
               n_cut   = SUBSTR(xcpara49.TYPE[7],5)
               n_cut   = TRIM(n_cut).
               n_index = INT(n_cut) NO-ERROR.
               IF n_index <> 0 THEN DO:
                   FIND FIRST tgroup  WHERE tgroup.gcode   = xcpara49.TYPE[1] NO-ERROR.
                   IF NOT AVAIL tgroup THEN CREATE tgroup.
                   ASSIGN
                       tgroup.ggroup  = n_index
                       tgroup.gcode   = xcpara49.TYPE[1]
                       tgroup.gthai   = STRING(tgroup.ggroup) + ". กลุ่มที่ " + STRING(tgroup.ggroup)
                       .
               END.

           RELEASE tgroup.
       END.
       ****/
   END.
    
    DISP fi_poldes fi_proce WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_acdes
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_acdes wgwtrnon
ON LEAVE OF fi_acdes IN FRAME fr_main
DO:
    fi_acno = INPUT fi_acno.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_acno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_acno wgwtrnon
ON LEAVE OF fi_acno IN FRAME fr_main
DO:
    fi_acno = INPUT fi_acno.
    
    fi_acno = CAPS(TRIM(INPUT fi_acno)).

    ASSIGN
        fi_acdes  = ""
        nv_branch = "".
    
    DISP fi_acno fi_acdes WITH FRAME fr_main.
    IF fi_acno = "" THEN DO:
        MESSAGE "Please Insert Data Account Code!!" VIEW-AS ALERT-BOX INFORMATION.
        APPLY "ENTRY"  TO fi_acno.
        RETURN NO-APPLY.
    END.
    ELSE DO:
        
        FIND FIRST CTXBRAN.xmm600 WHERE CTXBRAN.xmm600.acno = fi_acno NO-LOCK NO-ERROR.
        IF AVAIL CTXBRAN.xmm600 THEN DO:
            /*** ploy
            FIND FIRST w_chkbr WHERE
                   (w_chkbr.branch = "*" AND w_chkbr.producer = "*") OR 
                   (w_chkbr.branch = "*" AND w_chkbr.producer = fi_acno) NO-LOCK NO-ERROR.
            IF AVAIL w_chkbr THEN DO:
                FOR EACH sic_bran.xmm023 USE-INDEX xmm02301 NO-LOCK:
                    IF nv_branch = "" THEN
                        nv_branch = nv_branch + xmm023.branch.
                    ELSE
                        nv_branch = nv_branch + "," + xmm023.branch.
                END.
            END.
            ELSE DO:
                FOR EACH w_chkbr WHERE 
                         w_chkbr.producer = fi_acno OR 
                         w_chkbr.producer = "*"     NO-LOCK:
                    IF nv_branch = "" THEN
                        nv_branch = nv_branch + w_chkbr.branch.
                    ELSE
                        nv_branch = nv_branch + "," + w_chkbr.branch.
                END.
            END.

            IF nv_branch = "" THEN DO:
                MESSAGE "Not found Parameter Security User ID SET!!!" VIEW-AS ALERT-BOX INFORMATION.
                APPLY "ENTRY"  TO fi_acno.
                RETURN NO-APPLY.  
            END.

            ****/



            fi_acdes = CTXBRAN.xmm600.NAME.
            DISP fi_acno fi_acdes WITH FRAME fr_main.
        END.
        ELSE DO:
            MESSAGE "Not found Parameter Account Code!!!" VIEW-AS ALERT-BOX INFORMATION.
            APPLY "ENTRY"  TO fi_acno.
            RETURN NO-APPLY.
        END.
    END.
    

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_Policyfr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_Policyfr wgwtrnon
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


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_Policyfr wgwtrnon
ON RETURN OF fi_Policyfr IN FRAME fr_main
DO:
    fi_Policyfr = CAPS (INPUT fi_Policyfr).
    IF fi_policyto < fi_policyfr THEN
        fi_policyto = fi_policyfr.
    DISP fi_policyfr fi_policyto WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_Policyto
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_Policyto wgwtrnon
ON LEAVE OF fi_Policyto IN FRAME fr_main
DO:
  fi_Policyto = CAPS (INPUT fi_Policyto).
  DISP fi_policyto WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_TrnDate
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_TrnDate wgwtrnon
ON LEAVE OF fi_TrnDate IN FRAME fr_main
DO:
  fi_TrnDate = INPUT fi_TrnDate.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_trndatt
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_trndatt wgwtrnon
ON LEAVE OF fi_trndatt IN FRAME fr_main
DO:
    fi_Trndatt = INPUT fi_Trndatt.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_trndatt wgwtrnon
ON RETURN OF fi_trndatt IN FRAME fr_main
DO:
    fi_Trndatt = INPUT fi_Trndatt.
    IF fi_trndatt < fi_trndate THEN DO:
        MESSAGE "Transaction Date to ต้องมากกว่า Transaction Date Form!!!"  VIEW-AS ALERT-BOX INFORMATION.
        APPLY "ENTRY"  TO fi_trndatt.
        RETURN NO-APPLY.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK wgwtrnon 


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
  
  gv_prgid = "WGWTrNon.W".
  gv_prog  = "Query Batch No Transfer Non Motor Policy To Premium".  
  /*RUN  WUT\WUTHEAD ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).*/
  RUN  WUT\WUTWICEN ({&WINDOW-NAME}:HANDLE). 
  SESSION:DATA-ENTRY-RETURN = YES.
/*********************************************************************/ 

    ASSIGN
        fi_Trndatt = TODAY
        fi_TrnDate = TODAY
        nv_branch  = ""
        fi_acno    = "B300408"
        .   
    
    DISP  fi_acdes fi_TrnDate fi_Trndatt fi_acno WITH FRAME fr_main.

    ASSIGN
        nv_lookup = 0
        nv_poltyp = "".
    FOR EACH CTXBRAN.xmm031 USE-INDEX xmm03101 WHERE  
                              CTXBRAN.xmm031.dept <> "H" AND 
                              CTXBRAN.xmm031.dept <> "I" NO-LOCK:

        nv_lookup = nv_lookup + 1.
        IF nv_poltyp = "" THEN
            nv_poltyp = nv_poltyp + CTXBRAN.xmm031.poltyp.
        ELSE 
            nv_poltyp = nv_poltyp + ',' + CTXBRAN.xmm031.poltyp .
    END.

    ASSIGN
        co_poltyp:LIST-ITEMS = nv_poltyp
        nv_detyp  = "M64"
        nv_lookup = 0.

    nv_lookup = LOOKUP("M64",nv_poltyp).  /*Default poltyp*/

    co_poltyp = IF nv_lookup > 0 THEN ENTRY(nv_lookup,nv_poltyp)
                ELSE  ENTRY(1,nv_poltyp).

    FIND FIRST CTXBRAN.xmm031 USE-INDEX xmm03101 WHERE
        CTXBRAN.xmm031.poltyp = co_poltyp NO-LOCK NO-ERROR.
    IF AVAIL CTXBRAN.xmm031 THEN
        ASSIGN
            nv_detyp  = CTXBRAN.xmm031.dept
            fi_poldes = CTXBRAN.xmm031.poldes.
   
    IF co_poltyp = "M64" THEN
        fi_proce     = "Process Cer Policy".
    ELSE
        fi_proce     = "Transfer Policy".
    
    DISP co_poltyp fi_poldes fi_proce fi_Success WITH FRAME fr_main.
    
    APPLY "ENTRY"  TO fi_TrnDate.

  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI wgwtrnon  _DEFAULT-DISABLE
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
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(wgwtrnon)
  THEN DELETE WIDGET wgwtrnon.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI wgwtrnon  _DEFAULT-ENABLE
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
  DISPLAY fi_proce fi_acdes fi_TrnDate fi_trndatt co_poltyp fi_acno fi_Policyfr 
          fi_Policyto fi_poldes fi_brnfile fi_TranPol fi_errfile fi_strTime 
          fi_time fi_TotalTime fi_File fi_relOk fi_relerr fi_duprec fi_Success 
      WITH FRAME fr_main IN WINDOW wgwtrnon.
  ENABLE br_uwm100 fi_TrnDate fi_trndatt co_poltyp fi_acno bu_refresh 
         fi_Policyfr fi_Policyto bu_exit bu_Transfer fi_brnfile fi_TranPol 
         fi_errfile fi_strTime fi_time fi_TotalTime fi_File fi_relOk fi_relerr 
         fi_duprec fi_Success RECT-1 RECT-636 RECT-2 RECT-640 RECT-649 RECT-3 
      WITH FRAME fr_main IN WINDOW wgwtrnon.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW wgwtrnon.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDUpdateQ wgwtrnon 
PROCEDURE PDUpdateQ :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH w_polno:
    DELETE w_polno.
END.
fi_Success = 0.
FOR EACH  buwm100  USE-INDEX  uwm10008
    WHERE buwm100.Trndat >= fi_TrnDate
    AND buwm100.trndat   <= fi_trndatt 
    AND buwm100.acno1     = fi_Acno    
    AND buwm100.poltyp    = co_poltyp
    AND buwm100.releas    = NO       
    NO-LOCK BREAK BY  buwm100.Policy
                  BY  buwm100.endcnt .

    IF buwm100.polsta = "CA" THEN NEXT.

    IF substr(buwm100.policy,1,1) <> "C" THEN NEXT.

    FIND LAST  CTXBRAN.uwm100 USE-INDEX uwm10001 WHERE
        CTXBRAN.uwm100.Policy = buwm100.Policy NO-LOCK NO-ERROR NO-WAIT.
    IF AVAILABLE CTXBRAN.uwm100 THEN DO:
         
        FIND LAST w_polno WHERE w_polno.polno = CTXBRAN.uwm100.Policy  AND
            w_polno.rencnt = CTXBRAN.uwm100.rencnt AND
            w_polno.endcnt = CTXBRAN.uwm100.endcnt  NO-ERROR.
        IF NOT AVAIL w_polno THEN DO:
            CREATE w_polno.
            ASSIGN
                w_polno.trndat              =   CTXBRAN.uwm100.trndat 
                w_polno.polno               =   CTXBRAN.uwm100.policy
                w_polno.ntitle              =   CTXBRAN.uwm100.ntitle
                w_polno.name1               =   CTXBRAN.uwm100.name1
                w_polno.rencnt              =   CTXBRAN.uwm100.rencnt
                w_polno.endcnt              =   CTXBRAN.uwm100.endcnt 
                w_polno.trty11              =   CTXBRAN.uwm100.trty11 
                w_polno.docno1              =   CTXBRAN.uwm100.docno1   
                w_polno.agent               =   CTXBRAN.uwm100.agent  
                w_polno.acno1               =   CTXBRAN.uwm100.acno1  
                w_polno.releas              =   CTXBRAN.uwm100.releas.

            fi_Success = fi_Success + 1.
        
            IF CTXBRAN.uwm100.poltyp = "M64" THEN
                ASSIGN
                    w_polno.modcod  = uwm100.opnpol
                    w_polno.moddes  = uwm100.cr_1.
            ELSE IF nv_detyp  = "G" OR nv_detyp  = "M" THEN DO:
                FIND LAST CTXBRAN.uwm301 USE-INDEX uwm30101
                 WHERE CTXBRAN.uwm301.policy = CTXBRAN.uwm100.policy
                   AND CTXBRAN.uwm301.rencnt = CTXBRAN.uwm100.rencnt
                   AND CTXBRAN.uwm301.endcnt = CTXBRAN.uwm100.endcnt NO-LOCK NO-ERROR.
                IF AVAIL CTXBRAN.uwm301 THEN DO:
                    ASSIGN
                        w_polno.modcod  =  CTXBRAN.uwm301.modcod
                        w_polno.moddes  =  CTXBRAN.uwm301.moddes.
                END.
            END.
        END.
    END.

END.
OPEN QUERY br_uwm100 FOR EACH w_polno NO-LOCK BY w_polno.polno.



END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

