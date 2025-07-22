&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
*/
&Scoped-define WINDOW-NAME wgwtrnlt
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS wgwtrnlt 
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
  Create By : Kridtiya i.   A58-0356   18/09/2014 
            : เพิ่มโปรแกรม Transfer DATA GW to Premium
            duplicate program id. wgwtim70.w
/* Modify by : Chaiyong W. A59-0312 07/07/2016                     */
/*             correct st. releas and create vat                   */   
          
/* Modify By : Jiraphon P. A62-0286  Date : 17/06/2019 
             : แก้ไข Program ID (uwm100.prog)  ให้กำหนด program id 
               ตามงานที่ผ่าน On-web , Web-service , Outsource      */
            
------------------------------------------------------------------------*/
/*----------------------------------------------------------------------*/
/* Create an unnamed pool to store all the widgets created 
     by this procedure. This is a good default which assures
     that this procedure's triggers and internal procedures 
     will execute in this procedure's storage, and that proper
     cleanup will occur on deletion of the procedure. */
/* Modify By : Kridtiya i. A63-00029 Date. 24/02/2020 ขยายเลขที่เอกสาร จาก7 เป็น 10 หลัก*/
/* Modify By : Kridtiya i. A66-0045 Date. 03/03/2023 เพิ่ม การ gen uwm304,uwm200 */

CREATE WIDGET-POOL.

/* ***************************  Definitions  ************************** */

/* Parameters Definitions ---                                           */

/* Local Variable Definitions ---                                       */
DEFINE VAR  nv_progid AS CHAR.   /*Add Jiraphon P. A62-0286*/

DEF VAR nv_Recuwm100 AS RECID.
DEF VAR n_insref  AS CHAR.

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
DEF VAR nv_message  AS CHAR FORMAT "X(200)".
DEF VAR putchr      AS CHAR FORMAT "X(100)" INIT "" NO-UNDO.
DEF VAR putchr1     AS CHAR FORMAT "X(80)"  INIT "" NO-UNDO.
DEF VAR textchr     AS CHAR FORMAT "X(80)"  INIT "" NO-UNDO.
DEF VAR nv_trferr   AS CHAR FORMAT "X(80)"  INIT "" NO-UNDO.


DEF VAR nv_errfile AS CHAR FORMAT "X(30)"  INIT "" NO-UNDO.
DEF VAR nv_error   AS LOGICAL    INIT NO     NO-UNDO.

DEF BUFFER wk_uwm100 FOR sic_bran.uwm100.
DEF NEW SHARED STREAM ns1.
DEF NEW SHARED STREAM ns2.
DEF NEW SHARED STREAM ns3.



/*---Begin by Chaiyong W. A57-0096 04/06/2014*/

DEF WORKFILE w_chkbr
    FIELD branch   AS CHAR FORMAT "X(2)" 
    FIELD producer AS CHAR FORMAT "X(10)".
    
DEF WORKFILE w_polno
    FIELD trndat  AS DATE FORMAT "99/99/9999"
    FIELD polno   AS CHAR FORMAT "X(16)"
    FIELD ntitle  AS CHAR FORMAT "X(15)"
    FIELD name1   AS CHAR FORMAT "X(30)"
    FIELD rencnt  AS INT  FORMAT "999"
    FIELD endcnt  AS INT  FORMAT "999"
    FIELD trty11  AS CHAR FORMAT "X"
    /*FIELD docno1  AS CHAR FORMAT "X(7)"*/  /*Kridtiya i. A63-00029*/  
    FIELD docno1  AS CHAR FORMAT "X(10)"     /*Kridtiya i. A63-00029*/  
    /*-- Add A57-0300 --*/
    FIELD modcod  AS CHAR FORMAT "X(10)"
    FIELD moddes  AS CHAR FORMAT "X(30)"
    /*-- End A57-0300 --*/
    FIELD agent   AS CHAR FORMAT "X(10)"
    FIELD acno1   AS CHAR FORMAT "X(10)"
    FIELD bchyr   AS INT  FORMAT "9999"
    FIELD bchno   AS CHAR FORMAT "X(13)"
    FIELD bchcnt  AS INT  FORMAT "99"
    FIELD releas  AS LOGI INIT NO
    FIELD vehreg  AS CHAR FORMAT "X(13)"   /*Porntiwa P. A58-0335*/
    FIELD chassis AS CHAR FORMAT "X(35)"   /*Porntiwa P. A58-0335*/
    FIELD chkcha  AS CHAR FORMAT "X(35)"   /*Porntiwa P. A58-0335*/
    FIELD markca  AS LOGI INIT NO          /*A58-0339*/
    FIELD insnam  AS CHAR FORMAT "X(80)"   /*A58-0339*/
    FIELD recnt   AS CHAR FORMAT "X(8)"    /*A58-0339*/
    FIELD STATUSPolicy AS CHAR
    .

DEF VAR nv_des    AS CHAR    INIT "".
DEF VAR nv_csuc   AS INT     INIT 0. /*count successs*/
DEF VAR nv_cnsuc  AS INT     INIT 0. /*Count not success*/
/*End by Chaiyong W. A57-0096 04/06/2014-----*/

/*--- A57-0154 ---*/
DEFINE NEW SHARED VAR nv_body     AS CHAR.
DEFINE NEW SHARED VAR nv_subject  AS CHAR.
DEFINE NEW SHARED VAR nv_k        AS INTE.
DEF VAR nv_chkre  AS CHAR INIT "YES".  /*---Add by Chaiyong A58-0123 23/06/2015*/
DEFINE VAR nv_chassis AS CHAR FORMAT "X(40)".  /*Porntiwa P. A58-0335*/
DEF VAR n_trndatfr AS DATE    INIT ? .
DEF VAR n_trndatto AS DATE    INIT ? .

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
&Scoped-define FIELDS-IN-QUERY-br_uwm100 w_polno.trndat w_polno.polno w_polno.StatusPolicy w_polno.recnt w_polno.insnam w_polno.trty11 w_polno.docno1 /*Kridtiya i. A63-00029*/ /*--- A57-0300 --*/ w_polno.modcod w_polno.moddes /*--- A57-0300 --*/ w_polno.chassis /*A58-0335*/ w_polno.vehreg /*A58-0335*/ w_polno.agent w_polno.acno1 w_polno.bchyr w_polno.bchno w_polno.bchcnt w_polno.releas   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_uwm100   
&Scoped-define SELF-NAME br_uwm100
&Scoped-define QUERY-STRING-br_uwm100 FOR EACH w_polno NO-LOCK BY w_polno.polno
&Scoped-define OPEN-QUERY-br_uwm100 OPEN QUERY br_uwm100 FOR EACH w_polno NO-LOCK BY w_polno.polno.
&Scoped-define TABLES-IN-QUERY-br_uwm100 w_polno
&Scoped-define FIRST-TABLE-IN-QUERY-br_uwm100 w_polno


/* Definitions for FRAME fr_main                                        */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS fi_TrnDate fi_trndatt fi_acno bu_refresh ~
fi_Policyfr fi_Policyto bu_exit bu_Transfer br_uwm100 fi_brnfile fi_TranPol ~
fi_dupfile fi_strTime fi_time fi_TotalTime fi_File bu_cancel cb_select ~
RECT-1 RECT-636 RECT-2 RECT-640 RECT-649 RECT-3 RECT-4 
&Scoped-Define DISPLAYED-OBJECTS fi_acdes fi_TrnDate fi_trndatt fi_acno ~
fi_Policyfr fi_Policyto fi_brnfile fi_TranPol fi_dupfile fi_strTime fi_time ~
fi_TotalTime fi_File cb_select 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR wgwtrnlt AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bu_cancel 
     LABEL "CANCEL POL." 
     SIZE 15 BY 1.24
     FONT 6.

DEFINE BUTTON bu_exit AUTO-END-KEY 
     LABEL "EXIT" 
     SIZE 9 BY 1.24
     FONT 6.

DEFINE BUTTON bu_refresh 
     IMAGE-UP FILE "wimage/flipu.bmp":U
     LABEL "" 
     SIZE 10 BY 1.43.

DEFINE BUTTON bu_Transfer 
     LABEL "TRANS. TO PREMIUM" 
     SIZE 24 BY 1.24
     FONT 6.

DEFINE VARIABLE cb_select AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 3
     LIST-ITEMS "Tran.Date","Producer Code","Policy" 
     DROP-DOWN-LIST
     SIZE 20 BY 1
     FONT 6 NO-UNDO.

DEFINE VARIABLE fi_acdes AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 77 BY 1
     FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_acno AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 19.33 BY 1
     FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_brnfile AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 50 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_dupfile AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 50 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_File AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 50 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

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
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

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
     SIZE 18 BY .91
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_trndatt AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 18 BY .91
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 131.5 BY 1.52
     BGCOLOR 2 FGCOLOR 7 .

DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 12 BY 2.05
     BGCOLOR 4 .

DEFINE RECTANGLE RECT-3
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 26 BY 2.05
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-4
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 17.5 BY 2.05
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-636
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132 BY 19.52
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-640
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 12.33 BY 1.86
     BGCOLOR 2 .

DEFINE RECTANGLE RECT-649
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 74.17 BY 6.91.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_uwm100 FOR 
      w_polno SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_uwm100
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_uwm100 wgwtrnlt _FREEFORM
  QUERY br_uwm100 DISPLAY
      w_polno.trndat COLUMN-LABEL "Trn Date" FORMAT "99/99/9999"
w_polno.polno  COLUMN-LABEL "Policy No"      FORMAT "X(14)"
w_polno.StatusPolicy  COLUMN-LABEL "Status"  FORMAT "X(10)"
w_polno.recnt  COLUMN-LABEL "R/E"
w_polno.insnam COLUMN-LABEL "Insure"         FORMAT "X(25)"
w_polno.trty11 COLUMN-LABEL "Ty1"            FORMAT "X"
w_polno.docno1 COLUMN-LABEL "Doc.no.1"       FORMAT "X(10)"   /*Kridtiya i. A63-00029*/
/*--- A57-0300 --*/
w_polno.modcod COLUMN-LABEL "Model Code"     FORMAT "X(9)"
w_polno.moddes COLUMN-LABEL "Make Detail"    FORMAT "X(25)"
/*--- A57-0300 --*/
w_polno.chassis COLUMN-LABEL "Chassis no."   FORMAT "X(20)"  /*A58-0335*/
w_polno.vehreg COLUMN-LABEL "Vehreg no."     FORMAT "X(20)"  /*A58-0335*/
w_polno.agent  COLUMN-LABEL "Agent Code"     FORMAT "X(10)"
w_polno.acno1  COLUMN-LABEL "Account no."    FORMAT "X(10)"
w_polno.bchyr  COLUMN-LABEL "Bch Year"       FORMAT "9999"
w_polno.bchno  COLUMN-LABEL "Bch No."        FORMAT "X(20)"
w_polno.bchcnt COLUMN-LABEL "Batch Cnt."     FORMAT "99"
w_polno.releas COLUMN-LABEL "Releas"         FORMAT "Yes/No"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 130.5 BY 12.14 ROW-HEIGHT-CHARS .57 FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     fi_acdes AT ROW 3.76 COL 38 COLON-ALIGNED NO-LABEL
     fi_TrnDate AT ROW 2.62 COL 72 COLON-ALIGNED NO-LABEL
     fi_trndatt AT ROW 2.62 COL 96.67 COLON-ALIGNED NO-LABEL
     fi_acno AT ROW 3.76 COL 17.17 COLON-ALIGNED NO-LABEL
     bu_refresh AT ROW 2.91 COL 120.5
     fi_Policyfr AT ROW 18.91 COL 105.17 COLON-ALIGNED NO-LABEL
     fi_Policyto AT ROW 20 COL 105.17 COLON-ALIGNED NO-LABEL
     bu_exit AT ROW 22.52 COL 121.83
     bu_Transfer AT ROW 22.52 COL 95.33
     br_uwm100 AT ROW 5.29 COL 2
     fi_brnfile AT ROW 18.91 COL 23.33 COLON-ALIGNED NO-LABEL
     fi_TranPol AT ROW 20 COL 23.33 COLON-ALIGNED NO-LABEL
     fi_dupfile AT ROW 22.19 COL 23.33 COLON-ALIGNED NO-LABEL
     fi_strTime AT ROW 23.29 COL 23.33 COLON-ALIGNED NO-LABEL
     fi_time AT ROW 23.29 COL 41.33 COLON-ALIGNED NO-LABEL
     fi_TotalTime AT ROW 23.29 COL 61.33 COLON-ALIGNED NO-LABEL
     fi_File AT ROW 21.1 COL 23.33 COLON-ALIGNED NO-LABEL
     bu_cancel AT ROW 22.52 COL 78.17
     cb_select AT ROW 18.91 COL 76.67 COLON-ALIGNED NO-LABEL
     "From" VIEW-AS TEXT
          SIZE 5.17 BY .95 AT ROW 18.91 COL 101
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "Update File" VIEW-AS TEXT
          SIZE 11 BY .95 AT ROW 21.05 COL 13
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "Policy No. Dup. to file" VIEW-AS TEXT
          SIZE 15.5 BY .95 AT ROW 22.14 COL 9.33
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "To" VIEW-AS TEXT
          SIZE 4.17 BY .91 AT ROW 2.62 COL 93.67
          FGCOLOR 1 FONT 6
     "Transfer policy" VIEW-AS TEXT
          SIZE 14.5 BY .95 AT ROW 20 COL 9.83
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "Policy No. Write to file" VIEW-AS TEXT
          SIZE 22 BY .95 AT ROW 18.91 COL 2.83
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "Start Time" VIEW-AS TEXT
          SIZE 10.5 BY .95 AT ROW 23.33 COL 13.67
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "Total" VIEW-AS TEXT
          SIZE 5.83 BY .95 AT ROW 23.29 COL 56.67
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "End" VIEW-AS TEXT
          SIZE 4 BY .95 AT ROW 23.33 COL 38.17
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "    Show Detail Transfer" VIEW-AS TEXT
          SIZE 73.5 BY .95 AT ROW 17.67 COL 2.5
          BGCOLOR 3 FGCOLOR 7 FONT 6
     "   Policy Transfer" VIEW-AS TEXT
          SIZE 55.5 BY .95 AT ROW 17.67 COL 76.83
          BGCOLOR 3 FGCOLOR 7 FONT 6
     "Query Policy Motor Web Service Transfer To Premium   13/03/2023" VIEW-AS TEXT
          SIZE 128 BY .91 AT ROW 1.33 COL 3
          BGCOLOR 3 FGCOLOR 7 FONT 6
     "Tran.Date Form" VIEW-AS TEXT
          SIZE 17 BY .91 AT ROW 2.62 COL 56.17
          FGCOLOR 1 FONT 6
     "Account Code :" VIEW-AS TEXT
          SIZE 15.33 BY 1 AT ROW 3.76 COL 2.83
          FGCOLOR 1 FONT 6
     "To" VIEW-AS TEXT
          SIZE 3.17 BY .95 AT ROW 20 COL 103.17
          BGCOLOR 19 FGCOLOR 1 FONT 6
     RECT-1 AT ROW 1.05 COL 1.5
     RECT-636 AT ROW 5.05 COL 1.5
     RECT-2 AT ROW 22.19 COL 131.5 RIGHT-ALIGNED
     RECT-640 AT ROW 2.67 COL 119.17
     RECT-649 AT ROW 17.57 COL 2.33
     RECT-3 AT ROW 22.19 COL 119.33 RIGHT-ALIGNED
     RECT-4 AT ROW 22.19 COL 93.33 RIGHT-ALIGNED
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 24.


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
  CREATE WINDOW wgwtrnlt ASSIGN
         HIDDEN             = YES
         TITLE              = "WGWTRNLT: Query Policy Transfer GW Motor To Premium"
         HEIGHT             = 23.71
         WIDTH              = 132.67
         MAX-HEIGHT         = 45.81
         MAX-WIDTH          = 213.33
         VIRTUAL-HEIGHT     = 45.81
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
IF NOT wgwtrnlt:LOAD-ICON("wimage/iconhead.ico":U) THEN
    MESSAGE "Unable to load icon: wimage/iconhead.ico"
            VIEW-AS ALERT-BOX WARNING BUTTONS OK.
&ENDIF
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW wgwtrnlt
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME fr_main
   FRAME-NAME Custom                                                    */
/* BROWSE-TAB br_uwm100 bu_Transfer fr_main */
/* SETTINGS FOR FILL-IN fi_acdes IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR RECTANGLE RECT-2 IN FRAME fr_main
   ALIGN-R                                                              */
/* SETTINGS FOR RECTANGLE RECT-3 IN FRAME fr_main
   ALIGN-R                                                              */
/* SETTINGS FOR RECTANGLE RECT-4 IN FRAME fr_main
   ALIGN-R                                                              */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(wgwtrnlt)
THEN wgwtrnlt:HIDDEN = no.

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

&Scoped-define SELF-NAME wgwtrnlt
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wgwtrnlt wgwtrnlt
ON END-ERROR OF wgwtrnlt /* WGWTRNLT: Query Policy Transfer GW Motor To Premium */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wgwtrnlt wgwtrnlt
ON WINDOW-CLOSE OF wgwtrnlt /* WGWTRNLT: Query Policy Transfer GW Motor To Premium */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br_uwm100
&Scoped-define SELF-NAME br_uwm100
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_uwm100 wgwtrnlt
ON MOUSE-SELECT-DBLCLICK OF br_uwm100 IN FRAME fr_main
DO:
  FIND CURRENT w_polno NO-ERROR.
  IF AVAIL w_polno THEN DO:
      IF w_polno.markca = YES THEN w_polno.markca = NO.
                              ELSE w_polno.markca = YES.

      IF w_polno.markca = YES THEN DO:
            w_polno.trndat :BGCOLOR IN BROWSE br_uwm100 = 15 NO-ERROR.
            w_polno.polno  :BGCOLOR IN BROWSE br_uwm100 = 15 NO-ERROR.
            w_polno.trty11 :BGCOLOR IN BROWSE br_uwm100 = 15 NO-ERROR.
            w_polno.docno1 :BGCOLOR IN BROWSE br_uwm100 = 15 NO-ERROR.
            w_polno.modcod :BGCOLOR IN BROWSE br_uwm100 = 15 NO-ERROR.
            w_polno.moddes :BGCOLOR IN BROWSE br_uwm100 = 15 NO-ERROR.
            w_polno.chassis:BGCOLOR IN BROWSE br_uwm100 = 15 NO-ERROR.
            w_polno.vehreg :BGCOLOR IN BROWSE br_uwm100 = 15 NO-ERROR.
            w_polno.agent  :BGCOLOR IN BROWSE br_uwm100 = 15 NO-ERROR.
            w_polno.acno1  :BGCOLOR IN BROWSE br_uwm100 = 15 NO-ERROR.
            w_polno.bchyr  :BGCOLOR IN BROWSE br_uwm100 = 15 NO-ERROR.
            w_polno.bchno  :BGCOLOR IN BROWSE br_uwm100 = 15 NO-ERROR.
            w_polno.bchcnt :BGCOLOR IN BROWSE br_uwm100 = 15 NO-ERROR.
            w_polno.releas :BGCOLOR IN BROWSE br_uwm100 = 15 NO-ERROR.
    
            w_polno.trndat :FGCOLOR IN BROWSE br_uwm100 = 12 NO-ERROR.
            w_polno.polno  :FGCOLOR IN BROWSE br_uwm100 = 12 NO-ERROR.
            w_polno.trty11 :FGCOLOR IN BROWSE br_uwm100 = 12 NO-ERROR.
            w_polno.docno1 :FGCOLOR IN BROWSE br_uwm100 = 12 NO-ERROR.
            w_polno.modcod :FGCOLOR IN BROWSE br_uwm100 = 12 NO-ERROR.
            w_polno.moddes :FGCOLOR IN BROWSE br_uwm100 = 12 NO-ERROR.
            w_polno.chassis:FGCOLOR IN BROWSE br_uwm100 = 12 NO-ERROR.
            w_polno.vehreg :FGCOLOR IN BROWSE br_uwm100 = 12 NO-ERROR.
            w_polno.agent  :FGCOLOR IN BROWSE br_uwm100 = 12 NO-ERROR.
            w_polno.acno1  :FGCOLOR IN BROWSE br_uwm100 = 12 NO-ERROR.
            w_polno.bchyr  :FGCOLOR IN BROWSE br_uwm100 = 12 NO-ERROR.
            w_polno.bchno  :FGCOLOR IN BROWSE br_uwm100 = 12 NO-ERROR.
            w_polno.bchcnt :FGCOLOR IN BROWSE br_uwm100 = 12 NO-ERROR.
            w_polno.releas :FGCOLOR IN BROWSE br_uwm100 = 12 NO-ERROR.
      END.
      ELSE DO:
            w_polno.trndat :BGCOLOR IN BROWSE br_uwm100 = 15 NO-ERROR.
            w_polno.polno  :BGCOLOR IN BROWSE br_uwm100 = 15 NO-ERROR.
            w_polno.trty11 :BGCOLOR IN BROWSE br_uwm100 = 15 NO-ERROR.
            w_polno.docno1 :BGCOLOR IN BROWSE br_uwm100 = 15 NO-ERROR.
            w_polno.modcod :BGCOLOR IN BROWSE br_uwm100 = 15 NO-ERROR.
            w_polno.moddes :BGCOLOR IN BROWSE br_uwm100 = 15 NO-ERROR.
            w_polno.chassis:BGCOLOR IN BROWSE br_uwm100 = 15 NO-ERROR.
            w_polno.vehreg :BGCOLOR IN BROWSE br_uwm100 = 15 NO-ERROR.
            w_polno.agent  :BGCOLOR IN BROWSE br_uwm100 = 15 NO-ERROR.
            w_polno.acno1  :BGCOLOR IN BROWSE br_uwm100 = 15 NO-ERROR.
            w_polno.bchyr  :BGCOLOR IN BROWSE br_uwm100 = 15 NO-ERROR.
            w_polno.bchno  :BGCOLOR IN BROWSE br_uwm100 = 15 NO-ERROR.
            w_polno.bchcnt :BGCOLOR IN BROWSE br_uwm100 = 15 NO-ERROR.
            w_polno.releas :BGCOLOR IN BROWSE br_uwm100 = 15 NO-ERROR.
    
            w_polno.trndat :FGCOLOR IN BROWSE br_uwm100 = 0 NO-ERROR.
            w_polno.polno  :FGCOLOR IN BROWSE br_uwm100 = 0 NO-ERROR.
            w_polno.trty11 :FGCOLOR IN BROWSE br_uwm100 = 0 NO-ERROR.
            w_polno.docno1 :FGCOLOR IN BROWSE br_uwm100 = 0 NO-ERROR.
            w_polno.modcod :FGCOLOR IN BROWSE br_uwm100 = 0 NO-ERROR.
            w_polno.moddes :FGCOLOR IN BROWSE br_uwm100 = 0 NO-ERROR.
            w_polno.chassis:FGCOLOR IN BROWSE br_uwm100 = 0 NO-ERROR.
            w_polno.vehreg :FGCOLOR IN BROWSE br_uwm100 = 0 NO-ERROR.
            w_polno.agent  :FGCOLOR IN BROWSE br_uwm100 = 0 NO-ERROR.
            w_polno.acno1  :FGCOLOR IN BROWSE br_uwm100 = 0 NO-ERROR.
            w_polno.bchyr  :FGCOLOR IN BROWSE br_uwm100 = 0 NO-ERROR.
            w_polno.bchno  :FGCOLOR IN BROWSE br_uwm100 = 0 NO-ERROR.
            w_polno.bchcnt :FGCOLOR IN BROWSE br_uwm100 = 0 NO-ERROR.
            w_polno.releas :FGCOLOR IN BROWSE br_uwm100 = 0 NO-ERROR.

            IF w_polno.modcod = "" THEN DO:
        
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
         
            IF (SUBSTR(w_polno.polno,1,1) = "Q" OR SUBSTR(w_polno.polno,1,1) = "R") AND w_polno.chkcha <> "" THEN DO:  /*-- Add A58-0335 --*/
                w_polno.polno :BGCOLOR IN BROWSE br_uwm100 = 5 NO-ERROR.
                w_polno.chassis:BGCOLOR IN BROWSE br_uwm100 = 5 NO-ERROR.
                w_polno.vehreg:BGCOLOR IN BROWSE br_uwm100 = 5 NO-ERROR.
        
                w_polno.polno :FGCOLOR IN BROWSE br_uwm100 = 17 NO-ERROR.
                w_polno.chassis:FGCOLOR IN BROWSE br_uwm100 = 17 NO-ERROR.
                w_polno.vehreg:FGCOLOR IN BROWSE br_uwm100 = 17 NO-ERROR.
        
                w_polno.polno :FONT IN BROWSE br_uwm100 = 7 NO-ERROR.
                w_polno.chassis:FONT IN BROWSE br_uwm100 = 7 NO-ERROR.
                w_polno.vehreg:FONT IN BROWSE br_uwm100 = 7 NO-ERROR.
            END.  /* End A58-0335 */
      END.
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_uwm100 wgwtrnlt
ON ROW-DISPLAY OF br_uwm100 IN FRAME fr_main
DO:
    /*--- Add A57-0300 ---*/
    IF w_polno.modcod = "" THEN DO:

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
 
    IF SUBSTR(w_polno.polno,1,1) = "Q" OR SUBSTR(w_polno.polno,1,1) = "R" THEN DO:  /*-- Add A58-0335 --*/

        IF w_polno.statusPolicy = "SK_FAST" THEN DO:
            w_polno.trndat :FGCOLOR IN BROWSE br_uwm100  = 13 NO-ERROR.
            w_polno.polno  :FGCOLOR IN BROWSE br_uwm100  = 13 NO-ERROR.
            w_polno.StatusPolicy :FGCOLOR IN BROWSE br_uwm100  = 13 NO-ERROR.
            w_polno.recnt  :FGCOLOR IN BROWSE br_uwm100  = 13 NO-ERROR.
            w_polno.insnam :FGCOLOR IN BROWSE br_uwm100  = 13 NO-ERROR.
            w_polno.trty11 :FGCOLOR IN BROWSE br_uwm100  = 13 NO-ERROR.
            w_polno.docno1 :FGCOLOR IN BROWSE br_uwm100  = 13 NO-ERROR.
            w_polno.modcod :FGCOLOR IN BROWSE br_uwm100  = 13 NO-ERROR.
            w_polno.moddes :FGCOLOR IN BROWSE br_uwm100  = 13 NO-ERROR.
            w_polno.chassis:FGCOLOR IN BROWSE br_uwm100  = 13 NO-ERROR.
            w_polno.vehreg :FGCOLOR IN BROWSE br_uwm100  = 13 NO-ERROR.
            w_polno.agent  :FGCOLOR IN BROWSE br_uwm100  = 13 NO-ERROR.
            w_polno.acno1  :FGCOLOR IN BROWSE br_uwm100  = 13 NO-ERROR.
            w_polno.bchyr  :FGCOLOR IN BROWSE br_uwm100  = 13 NO-ERROR.
            w_polno.bchno  :FGCOLOR IN BROWSE br_uwm100  = 13 NO-ERROR.
            w_polno.bchcnt :FGCOLOR IN BROWSE br_uwm100  = 13 NO-ERROR.
            w_polno.releas :FGCOLOR IN BROWSE br_uwm100  = 13 NO-ERROR.


        END.

        IF w_polno.chkcha <> "" AND SUBSTR(w_polno.polno,3,2) = "70" THEN DO:
            w_polno.polno :BGCOLOR IN BROWSE br_uwm100 = 5 NO-ERROR.
            w_polno.chassis:BGCOLOR IN BROWSE br_uwm100 = 5 NO-ERROR.
            w_polno.vehreg:BGCOLOR IN BROWSE br_uwm100 = 5 NO-ERROR.
    
            w_polno.polno :FGCOLOR IN BROWSE br_uwm100 = 17 NO-ERROR.
            w_polno.chassis:FGCOLOR IN BROWSE br_uwm100 = 17 NO-ERROR.
            w_polno.vehreg:FGCOLOR IN BROWSE br_uwm100 = 17 NO-ERROR.
    
            w_polno.polno :FONT IN BROWSE br_uwm100 = 7 NO-ERROR.
            w_polno.chassis:FONT IN BROWSE br_uwm100 = 7 NO-ERROR.
            w_polno.vehreg:FONT IN BROWSE br_uwm100 = 7 NO-ERROR.
        END.
    END.  /* End A58-0335 */
    /*--- End A57-0300 ---*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_uwm100 wgwtrnlt
ON VALUE-CHANGED OF br_uwm100 IN FRAME fr_main
DO:
  /*--- Add A57-0300 ---*/
  FIND CURRENT w_polno NO-LOCK NO-ERROR.
  IF NOT AVAIL w_polno THEN DO:
  END.
  ELSE DO:
      DISPLAY w_polno.polno @ fi_policyfr WITH FRAME fr_main.
  END.
  /*--- End A57-0300 ---*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_cancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_cancel wgwtrnlt
ON CHOOSE OF bu_cancel IN FRAME fr_main /* CANCEL POL. */
DO:
FOR EACH w_polno WHERE w_polno.markca = YES :
    FIND LAST sic_bran.uwm100 USE-INDEX uwm10001 WHERE
              sic_bran.uwm100.policy = w_polno.polno  AND
              sic_bran.uwm100.rencnt = w_polno.rencnt AND
              sic_bran.uwm100.endcnt = w_polno.endcnt AND
              sic_bran.uwm100.bchyr  = w_polno.bchyr  AND
              sic_bran.uwm100.bchno  = w_polno.bchno  AND
              sic_bran.uwm100.bchcnt = w_polno.bchcnt NO-ERROR.
    IF AVAIL sic_bran.uwm100 THEN DO:
        ASSIGN sic_bran.uwm100.polsta = "CA".

        DELETE w_polno.
    END.
END.

OPEN QUERY br_uwm100 FOR EACH w_polno NO-LOCK BY w_polno.polno.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_exit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_exit wgwtrnlt
ON CHOOSE OF bu_exit IN FRAME fr_main /* EXIT */
DO:
APPLY  "CLOSE"  TO THIS-PROCEDURE.
RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_refresh
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_refresh wgwtrnlt
ON CHOOSE OF bu_refresh IN FRAME fr_main
DO:
    
    ASSIGN
        fi_trndate = INPUT fi_trndate
        fi_Trndatt = INPUT fi_Trndatt
        fi_acno    = CAPS(TRIM(INPUT fi_acno)).
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
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_Transfer
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_Transfer wgwtrnlt
ON CHOOSE OF bu_Transfer IN FRAME fr_main /* TRANS. TO PREMIUM */
DO:

/* sic_bran = gw_Safe
   brStat   = gw_sate */
    ASSIGN
        cb_select   = INPUT cb_select
        fi_trndate  = INPUT fi_trndate
        fi_Trndatt  = INPUT fi_Trndatt
        fi_acno     = CAPS(TRIM(INPUT fi_acno))
        fi_policyfr = INPUT fi_policyfr
        fi_policyto = INPUT fi_policyto.

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
    ASSIGN
        fi_brnfile   = ""
        fi_TranPol   = ""
        fi_File      = ""
        fi_dupfile   = "" 
        fi_strTime   = "" 
        fi_time      = "" 
        fi_TotalTime = ""
        nv_Insno     = ""
        nv_total     = ""
        nv_start     = STRING(TIME,"HH:MM:SS")
        fi_strTime   = STRING(TIME,"HH:MM:SS")
        nv_timestart = TIME
        nv_timeend   = TIME
        nv_polmst    = "".

 nv_csuc  = 0.
 nv_cnsuc = 0.

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
PUT STREAM ns3 "Ceding Pol.       R/E    Policy No.        R/E    Trn.Date    Ent.Date    UserID    Insure Name " SKIP.
/*----------------*/

IF      cb_select = "Tran.Date"     THEN  RUN proc_bytrandat.
ELSE IF cb_select = "Producer Code" THEN  RUN proc_byproducer.
ELSE IF cb_select = "Policy"        THEN DO:
    RUN proc_bypolicy.
END.
/*
FOR EACH w_polno WHERE 
    w_polno.polno >= fi_policyfr AND 
    w_polno.polno <= fi_policyto NO-LOCK BREAK BY w_polno.polno.
    FIND FIRST  sic_bran.uwm100 USE-INDEX  uwm10001
    WHERE sic_bran.uwm100.policy = w_polno.polno  AND
          sic_Bran.uwm100.rencnt = w_polno.rencnt AND
          sic_bran.uwm100.endcnt = w_polno.endcnt NO-ERROR.
    IF AVAIL sic_bran.uwm100 THEN DO:
/*End by Chaiyong W. A57-0096 04/06/2014------*/
        ASSIGN
         nv_batchyr = sic_bran.uwm100.bchyr
         nv_batchno = sic_bran.uwm100.bchNo 
         nv_batcnt  = sic_bran.uwm100.bchCnt
         nv_Policy  = sic_bran.uwm100.Policy
         nv_RenCnt  = sic_bran.uwm100.RenCnt
         nv_EndCnt  = sic_bran.uwm100.EndCnt
         nv_Insno   = sic_bran.uwm100.insref.
        /*MESSAGE nv_batchyr
                nv_batchno
                nv_batcnt  SKIP
                nv_Policy 
                nv_RenCnt 
                nv_EndCnt 
                nv_Insno.*/
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
                   uzm701.bchcnt  =  nv_batcnt NO-LOCK NO-ERROR. /*A58-0251 Eakkapong ใส่ no-lock*/
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
         END.
         DO:
             ASSIGN
             /*sic_bran.uzm701.trfbegtim = STRING(TIME,"HH:MM:SS") *//*A58-0251 Eakkapong */
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
              RUN PDCheckNs1.
              DISP  fi_TranPol fi_time WITH FRAME fr_main.

              /*-----MOTOR POLICY ON WEB----*/
              IF nv_error = NO THEN DO:      
                      /*---Begin by Chaiyong W. A57-0096 04/06/2014*/
                      nv_csuc  = nv_csuc + 1.
                      /*End by Chaiyong W. A57-0096 04/06/2014-----*/
                    DISPLAY  "uwm100" @ fi_File WITH FRAME fr_main.
    
                    /*MESSAGE "1" VIEW-AS ALERT-BOX.*/
                    RUN wgw\wgwgen01 (INPUT nv_batchyr,INPUT nv_batchno,INPUT nv_batcnt,  /*uwm100+uwd100*/
                                      INPUT nv_Policy,INPUT nv_RenCnt,INPUT nv_EndCnt
                                      ,INPUT nv_chkre /*---Add by Chaiyong A58-0123 23/06/2015*/
                                      ).
                    DISPLAY  "uwm120" @ fi_File WITH FRAME fr_main.
                    RUN wgw\wgwgen02 (INPUT nv_batchyr,INPUT nv_batchno,INPUT nv_batcnt,  /*uwm120*/
                                      INPUT nv_Policy,INPUT nv_RenCnt,INPUT nv_EndCnt).
                    DISPLAY  "uwm130" @ fi_File WITH FRAME fr_main.
                    RUN wgw\wgwgen03 (INPUT nv_batchyr,INPUT nv_batchno,INPUT nv_batcnt,  /*uwm130*/
                                      INPUT nv_Policy,INPUT nv_RenCnt,INPUT nv_EndCnt).
                    DISPLAY  "uwm301" @ fi_File WITH FRAME fr_main.
                    RUN wgw\wgwgen04 (INPUT nv_batchyr,INPUT nv_batchno,INPUT nv_batcnt,  /*uwm301*/
                                      INPUT nv_Policy,INPUT nv_RenCnt,INPUT nv_EndCnt).

                    /*-- Comment A57-0096 Phorn --*/
                    DISPLAY  "xmm600" @ fi_File WITH FRAME fr_main.
                    RUN wgw\wgwgen05 (INPUT nv_batchyr,INPUT nv_batchno,INPUT nv_batcnt,  /*xmm600*/
                                      INPUT nv_Policy,INPUT nv_RenCnt,INPUT nv_EndCnt). 
                    /*---- End Comment A57-0096 Phorn ---*/

                    /*---
                    IF sic_bran.uwm100.rencnt > 0 THEN DO:
                        DISPLAY  "check_xmm600" @ fi_File WITH FRAME fr_main.
                        RUN wgw\wgwtim01 (INPUT nv_batchyr,INPUT nv_batchno,INPUT nv_batcnt,  /*xmm600*/
                                          INPUT nv_Policy,INPUT nv_RenCnt,INPUT nv_EndCnt). 
                    END.
                    ELSE DO:
                        DISPLAY  "xmm600" @ fi_File WITH FRAME fr_main.
                        RUN wgw\wgwgen05 (INPUT nv_batchyr,INPUT nv_batchno,INPUT nv_batcnt,  /*xmm600*/
                                          INPUT nv_Policy,INPUT nv_RenCnt,INPUT nv_EndCnt). 
                    END.
                    ---*/
                                     
                    DISPLAY  "Detaitem" @ fi_File WITH FRAME fr_main.
                    RUN wgw\wgwgen06 (INPUT nv_batchyr,INPUT nv_batchno,INPUT nv_batcnt,  /*Detaitem*/
                                      INPUT nv_Policy,INPUT nv_RenCnt,INPUT nv_EndCnt).

                    /*comment by Kridtiya i...A58-0356...........
                    /*-- ADD A57-0154 Send Mail to Lotus Note & Inspection --*/
                    IF to_Inspec AND sic_bran.uwm100.poltyp = "V70" AND sic_bran.uwm100.rencnt = 0 THEN DO:
                        FIND FIRST sic_bran.uwm301 USE-INDEX uwm30101 WHERE
                                   sic_bran.uwm301.policy = sic_bran.uwm100.policy AND
                                   sic_bran.uwm301.rencnt = sic_bran.uwm100.rencnt AND
                                   sic_bran.uwm301.endcnt = 0                      AND
                                   sic_bran.uwm301.riskgp = 0                      AND
                                   sic_bran.uwm301.riskno = 1                      AND
                                   sic_bran.uwm301.itemno = 1                      AND
                                   sic_bran.uwm301.bchyr  = sic_bran.uwm100.bchyr  AND
                                   sic_bran.uwm301.bchno  = sic_bran.uwm100.bchno  AND
                                   sic_bran.uwm301.bchcnt = sic_bran.uwm100.bchcnt NO-LOCK NO-ERROR.
                        IF AVAIL sic_bran.uwm301 THEN DO:

                            IF SUBSTR(sic_bran.uwm301.policy,1,1) = "Q" THEN DO: /*-- Add A58-0335 --*/
                                FIND LAST sicuw.uwm301 USE-INDEX uwm30121 WHERE
                                          sicuw.uwm301.cha_no = sic_bran.uwm301.cha_no NO-LOCK NO-ERROR.
                                IF NOT AVAIL sicuw.uwm301 THEN DO:
                                    IF  sic_bran.uwm301.covcod = "1" OR SUBSTR(TRIM(sic_bran.uwm301.covcod),1,1) = "2" THEN DO:
                                        DISPLAY "Inspection" @ fi_File WITH FRAME fr_main.
                                        RUN wgw\wgwtinsp (INPUT nv_batchyr,INPUT nv_batchno,INPUT nv_batcnt,  /*Inspection*/
                                                          INPUT nv_Policy,INPUT nv_RenCnt,INPUT nv_EndCnt).
                                    END.
                                END.
                                ELSE DO:
                                    MESSAGE "Policy: " sic_bran.uwm301.policy SKIP
                                            "พบเลข Chassis: " sicuw.uwm301.cha_no " ในระบบ" SKIP
                                            "ต้องการโอน ข้อมูลเข้ากล่อง Inspection หรือไม่ ?" 
                                    VIEW-AS ALERT-BOX QUESTION BUTTON YES-NO UPDATE Choice AS LOGICAL. 
                                    IF Choice THEN DO:
                                        IF  sic_bran.uwm301.covcod = "1" OR SUBSTR(TRIM(sic_bran.uwm301.covcod),1,1) = "2" THEN DO:
                                            DISPLAY "Inspection" @ fi_File WITH FRAME fr_main.
                                            RUN wgw\wgwtinsp (INPUT nv_batchyr,INPUT nv_batchno,INPUT nv_batcnt,  /*Inspection*/
                                                              INPUT nv_Policy,INPUT nv_RenCnt,INPUT nv_EndCnt).
                                        END.
                                    END.
                                END.
                            END.
                            ELSE DO:  /*-- End A58-0335 --*/
                                IF  sic_bran.uwm301.covcod = "1" OR SUBSTR(TRIM(sic_bran.uwm301.covcod),1,1) = "2" THEN DO:
                                    DISPLAY "Inspection" @ fi_File WITH FRAME fr_main.
                                    RUN wgw\wgwtinsp (INPUT nv_batchyr,INPUT nv_batchno,INPUT nv_batcnt,  /*Inspection*/
                                                      INPUT nv_Policy,INPUT nv_RenCnt,INPUT nv_EndCnt).
                                END.
                            END.
                        END.
                    END.
                    /*-- END A57-0154 Send Mail to Lotus Note & Inspection --*/
                    end....comment by Kridtiya i...A58-0356...*/
    
                    IF nv_error = NO THEN DO:
                       PUT STREAM ns2
                       sic_bran.uwm100.policy FORMAT "x(16)" " " 
                       sic_bran.uwm100.rencnt "/" sic_bran.uwm100.endcnt "  " 
                       nv_policy FORMAT "X(16)" " "
                       nv_rencnt "/" nv_endcnt "  "
                       sic_bran.uwm100.trndat "  "
                       sic_bran.uwm100.entdat "  "
                       sic_bran.uwm100.usrid "   " 
                       TRIM(TRIM(sic_bran.uwm100.ntitle) + " " + 
                       TRIM(sic_bran.uwm100.name1)) FORMAT "x(60)" SKIP.
                    END.
       
              END. /*nv_error = no*/
              /*---Begin by Chaiyong W. A57-0096 04/06/2014*/
              ELSE nv_cnsuc  = nv_cnsuc + 1.
              /*End by Chaiyong W. A57-0096 04/06/2014-----*/
    
    
         END. /*  ELSE DO:*/
    END.  /*For each*/
END.  /*---for each w_polno by Chaiyong W. A57-0096 04/06/201*/*/

OUTPUT STREAM ns1 CLOSE.
OUTPUT STREAM ns2 CLOSE.
OUTPUT STREAM ns3 CLOSE.
fi_TotalTime    = STRING((nv_timeend - nv_timestart),"HH:MM:SS").
DISP  fi_TotalTime WITH FRAME fr_main.
IF nv_cnsuc = 0 THEN
    MESSAGE "TRANSFER DATA TO PREMIUM" SKIP
            "Complete     : " nv_csuc  " Records"
    VIEW-AS ALERT-BOX INFORMATION.
ELSE DO:
    IF nv_message = "" THEN nv_message = "-".
    MESSAGE "TRANSFER DATA TO PREMIUM" SKIP
            "Complete     : " nv_csuc  " Records" SKIP
            "Not Complete : " nv_cnsuc " Records" SKIP
            "Reason : " nv_message 
    VIEW-AS ALERT-BOX ERROR.
    nv_message = "".
END.
RUN PDUpdateQ.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_acdes
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_acdes wgwtrnlt
ON LEAVE OF fi_acdes IN FRAME fr_main
DO:
    fi_acno = INPUT fi_acno.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_acno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_acno wgwtrnlt
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
        FIND FIRST sicsyac.xmm600 WHERE sicsyac.xmm600.acno = fi_acno NO-LOCK NO-ERROR.
        IF AVAIL sicsyac.xmm600 THEN DO:

            /*FIND FIRST w_chkbr WHERE
                   (w_chkbr.branch = "*" AND w_chkbr.producer = "*") OR 
                   (w_chkbr.branch = "*" AND w_chkbr.producer = fi_acno) NO-LOCK NO-ERROR.
            IF AVAIL w_chkbr THEN DO:
                FOR EACH sicsyac.xmm023 USE-INDEX xmm02301 NO-LOCK:
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

                    IF nv_branch = "" THEN DO:
                        nv_branch = nv_branch + w_chkbr.branch.
                    END.
                    ELSE
                        nv_branch = nv_branch + "," + w_chkbr.branch.
                END.
            END. 
            IF nv_branch = "" THEN DO:
                MESSAGE "Not found Parameter Security User ID SET!!!" VIEW-AS ALERT-BOX INFORMATION.
                APPLY "ENTRY"  TO fi_acno.
                RETURN NO-APPLY.  
            END.*/

            fi_acdes = sicsyac.xmm600.NAME.
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
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_Policyfr wgwtrnlt
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


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_Policyfr wgwtrnlt
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
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_Policyto wgwtrnlt
ON LEAVE OF fi_Policyto IN FRAME fr_main
DO:
  fi_Policyto = CAPS (INPUT fi_Policyto).
  DISP fi_policyto WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_TrnDate
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_TrnDate wgwtrnlt
ON LEAVE OF fi_TrnDate IN FRAME fr_main
DO:
  fi_TrnDate = INPUT fi_TrnDate.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_trndatt
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_trndatt wgwtrnlt
ON LEAVE OF fi_trndatt IN FRAME fr_main
DO:
    fi_Trndatt = INPUT fi_Trndatt.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_trndatt wgwtrnlt
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK wgwtrnlt 


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
  
  gv_prgid = "wgwtim70.W".
  gv_prog  = "Query Batch No Transfer Motor Policy To Premium".  
  /*RUN  WUT\WUTHEAD ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).*/
  RUN  WUT\WUTWICEN ({&WINDOW-NAME}:HANDLE). 
  SESSION:DATA-ENTRY-RETURN = YES.
/*********************************************************************/ 
  
  ASSIGN
        fi_Trndatt = TODAY
        fi_TrnDate = TODAY
        /*fi_acno    = "B3W0019" */
        fi_acno    = "B3W0023" 
        nv_branch  = ""                 /*Collect Branch*/
        cb_select  = "Tran.Date" .
  FIND FIRST sicsyac.xmm600 WHERE sicsyac.xmm600.acno = fi_acno NO-LOCK NO-ERROR.
  IF AVAIL sicsyac.xmm600 THEN DO:
      fi_acdes = sicsyac.xmm600.NAME.
      DISP fi_acno fi_acdes WITH FRAME fr_main.
  END.
  ELSE DO:
      MESSAGE "Not found Parameter Account Code!!!" VIEW-AS ALERT-BOX INFORMATION.
      APPLY "ENTRY"  TO fi_acno.
      RETURN NO-APPLY.
  END.
  DISP cb_select  fi_acno  WITH FRAME fr_main.

    /*
    FIND FIRST brstat.usrsec_fil WHERE brstat.usrsec_fil.usrid = n_user AND
               TRIM(SUBSTR(brstat.usrsec_fil.CLASS,1,5))  = "*"  AND 
               TRIM(SUBSTR(brstat.usrsec_fil.CLASS,6,10)) = "*" NO-LOCK NO-ERROR.
    IF AVAIL brstat.usrsec_fil THEN DO:
        ASSIGN
            fi_branch = ""
            fi_brdesc = "ALL Branch".
        CREATE w_chkbr.
        ASSIGN
            w_chkbr.branch   = "*"
            w_chkbr.producer = "*".
    END.
    ELSE DO:
        CREATE w_chkbr.
        ASSIGN
            w_chkbr.branch   = TRIM(SUBSTRING(n_user,6,2))
            w_chkbr.producer = "*"
            nv_des           = TRIM(SUBSTRING(n_user,6,2)) .
        FOR EACH brstat.usrsec_fil WHERE brstat.usrsec_fil.usrid = n_user NO-LOCK:

            IF  TRIM(SUBSTR(brstat.usrsec_fil.CLASS,1,5)) <> TRIM(SUBSTRING(n_user,6,2)) THEN DO:
                CREATE w_chkbr.
                ASSIGN
                    w_chkbr.branch   = TRIM(SUBSTR(brstat.usrsec_fil.CLASS,1,5))
                    w_chkbr.producer = TRIM(SUBSTR(brstat.usrsec_fil.CLASS,6,10)).
                IF w_chkbr.branch = "" THEN w_chkbr.branch = "*".
                IF w_chkbr.producer = "" THEN w_chkbr.producer = "*".

                IF  LOOKUP(TRIM(w_chkbr.branch),nv_des) = 0 THEN DO:
                    IF w_chkbr.branch = "*" THEN
                        IF LOOKUP(TRIM(w_chkbr.producer),nv_des) = 0  THEN
                            nv_des = nv_des.
                        ELSE
                            nv_des = nv_des + "," + w_chkbr.branch.
                     ELSE
                         nv_des = nv_des + "," + w_chkbr.branch.

                END.
            END.
        END.
        IF INDEX(nv_des,",") = 0 THEN DO:    
            FIND FIRST sicsyac.xmm023 USE-INDEX xmm02301 WHERE sicsyac.xmm023.branch = nv_des NO-LOCK NO-ERROR.
            IF AVAIL sicsyac.xmm023 THEN DO:
                ASSIGN
                    fi_branch = nv_des
                    fi_brdesc = sicsyac.xmm023.bdes.
            END.
            ELSE DO:
                MESSAGE "Please Check Parameter Branch!!!" VIEW-AS ALERT-BOX INFORMATION.
                RETURN NO-APPLY.
            END.
        END. 
        ELSE fi_brdesc = nv_des.
    END.
    IF fi_brdesc = "" THEN nv_des = "".
    */

    DISP   fi_TrnDate fi_Trndatt WITH FRAME fr_main.
     

    APPLY "ENTRY" TO fi_TrnDate IN FRAME fr_main.



  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI wgwtrnlt  _DEFAULT-DISABLE
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
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(wgwtrnlt)
  THEN DELETE WIDGET wgwtrnlt.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI wgwtrnlt  _DEFAULT-ENABLE
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
  DISPLAY fi_acdes fi_TrnDate fi_trndatt fi_acno fi_Policyfr fi_Policyto 
          fi_brnfile fi_TranPol fi_dupfile fi_strTime fi_time fi_TotalTime 
          fi_File cb_select 
      WITH FRAME fr_main IN WINDOW wgwtrnlt.
  ENABLE fi_TrnDate fi_trndatt fi_acno bu_refresh fi_Policyfr fi_Policyto 
         bu_exit bu_Transfer br_uwm100 fi_brnfile fi_TranPol fi_dupfile 
         fi_strTime fi_time fi_TotalTime fi_File bu_cancel cb_select RECT-1 
         RECT-636 RECT-2 RECT-640 RECT-649 RECT-3 RECT-4 
      WITH FRAME fr_main IN WINDOW wgwtrnlt.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW wgwtrnlt.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDCheckNS1 wgwtrnlt 
PROCEDURE PDCheckNS1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VAR nv_ChkVat AS LOGICAL.

ASSIGN putchr  = ""
       putchr1 = ""
       textchr = STRING(TRIM(nv_policy),"x(16)") + " " +
                 STRING(nv_rencnt,"99") + "/" + STRING(nv_endcnt,"999").

/*A58-0251 Eakkapong */
FIND FIRST sicuw.uwm100 USE-INDEX uwm10001
    WHERE sicuw.uwm100.policy = sic_bran.uwm100.policy NO-LOCK NO-ERROR.
IF AVAIL sicuw.uwm100 THEN DO:

    ASSIGN
     putchr1 = "Policy Duplication on sicuw.uwm100 " +  string(sicuw.uwm100.policy) + " " + string(sicuw.uwm100.rencnt) + "/" + string(sicuw.uwm100.endcnt)
     putchr  = textchr  + "  " + TRIM(putchr1).
    PUT STREAM ns3 putchr FORMAT "x(200)" SKIP.
    nv_message = putchr1.
    nv_error = YES.
END.
ELSE DO:
/*A58-0251 Eakkapong */
            FIND LAST wk_uwm100 WHERE RECID(wk_uwm100) = nv_RecUwm100.
            IF NOT AVAIL wk_uwm100 THEN DO:
               ASSIGN
                putchr1 = "Not Found Record on sic_bran.uwm100" .
                putchr  = textchr  + "  " + TRIM(putchr1).
               PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
               IF putchr1 <> "" THEN nv_message = putchr1.
               nv_error = YES.
             /*NEXT.*/
            END.
            ELSE DO:
              IF wk_uwm100.poltyp = "" THEN DO:
                 ASSIGN
                  putchr1 = "ไม่มีค่า Policy Type"
                  putchr  = textchr + "  " + TRIM(putchr1).
                 PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
                 IF putchr1 <> "" THEN nv_message = putchr1.
                 nv_error = YES.
               /*NEXT.*/
              END.
              IF wk_uwm100.branch = "" THEN DO:
                 ASSIGN
                  putchr1 = "ไม่มีค่า Branch"
                  putchr  = textchr + "  " + TRIM(putchr1).
                 PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
                 IF putchr1 <> "" THEN nv_message = putchr1.
                 nv_error = YES.
               /*NEXT.*/
              END.
              IF wk_uwm100.comdat = ? THEN DO:
                 ASSIGN 
                   putchr1 = "ไม่มีค่า Comdate"
                   putchr  = textchr + "  " + TRIM(putchr1).
                  PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
                  IF putchr1 <> "" THEN nv_message = putchr1.
                  nv_error = YES.
                /*NEXT.*/
              END.
              IF wk_uwm100.expdat = ? THEN DO:
                 ASSIGN
                   putchr1 = "ไม่มีค่า Expiry Date"
                   putchr  = textchr + "  " + TRIM(putchr1).
                  PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
                  IF putchr1 <> "" THEN nv_message = putchr1.
                  nv_error = YES.
                /*NEXT.*/
              END.
              IF wk_uwm100.name1 = "" THEN DO:
                 ASSIGN
                  putchr1 = "ไม่มีค่า Name Of Insured"
                  putchr  = textchr  + "  " + TRIM(putchr1).
                 PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
                 IF putchr1 <> "" THEN nv_message = putchr1.
                 nv_error = YES.
               /*NEXT.*/
              END.
              IF wk_uwm100.prem_t = 0 THEN DO:
                 ASSIGN
                  putchr1 = "ไม่มีค่า Premium"
                  putchr  = textchr + "  " + TRIM(putchr1).
                 PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
                 IF putchr1 <> "" THEN nv_message = putchr1.
                 nv_error = YES.
               /*NEXT.*/
              END.
              IF wk_uwm100.tranty = "" THEN DO:
                 ASSIGN
                  putchr1 = "ไม่สามารถระบุประเภทงานได้"
                  putchr  = textchr + "  " + TRIM(putchr1).
                 PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
                 IF putchr1 <> "" THEN nv_message = putchr1.
                 nv_error = YES.
               /*NEXT.*/
              END.
              IF wk_uwm100.policy = "" THEN DO:
                 ASSIGN
                  putchr1 = "Policy No. is blank"
                  putchr  = textchr + "  " + TRIM(putchr1).
                 PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
                 IF putchr1 <> "" THEN nv_message = putchr1.
                 nv_error = YES.
               /*NEXT.*/
              END.
              /*-- Comment A57-0096 Phorn --
              IF wk_uwm100.RenCnt <> 0 THEN DO:
                 ASSIGN
                  putchr1 = "Renewal Count error"
                  putchr  = textchr + "  " + TRIM(putchr1).
                 PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
                 nv_message = putchr1.
                 nv_error = YES.
               /*NEXT.*/
              END.
              -- End Comment A57-0096 Phorn ---*/
              /*--- A58-0339 --
              IF wk_uwm100.EndCnt <> 0 THEN DO:
                 ASSIGN
                  putchr1 = "Endorsement Count error"
                  putchr  = textchr + "  " + TRIM(putchr1).
                 PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
                 IF putchr1 <> "" THEN nv_message = putchr1.
                 nv_error = YES.
               /*NEXT.*/
              END.
              --- End A58-0339 ---*/
              IF wk_uwm100.agent = "" OR wk_uwm100.acno1 = "" THEN DO:
                 ASSIGN
                  putchr1 = "Producer, Agent are blank"
                  putchr  = textchr + "  " + TRIM(putchr1).
                 PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
                 IF putchr1 <> "" THEN nv_message = putchr1.
                 nv_error = YES.
               /*NEXT.*/
              END.
              IF wk_uwm100.insref = "" THEN DO:
                 ASSIGN
                  putchr1 = "Insured Code is blank"
                  putchr  = textchr + "  " + TRIM(putchr1).
                 PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
                 IF putchr1 <> "" THEN nv_message = putchr1.
                 nv_error = YES.
               /*NEXT.*/
              END.
              IF TRIM(wk_uwm100.Addr1) + TRIM(wk_uwm100.Addr2) +
                 TRIM(wk_uwm100.Addr3) + TRIM(wk_uwm100.Addr4) = "" THEN DO:
                 ASSIGN
                  putchr1 = "Address is blank"
                  putchr  = textchr + "  " + TRIM(putchr1).
                 PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
                 IF putchr1 <> "" THEN nv_message = putchr1.
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
                IF putchr1 <> "" THEN nv_message = putchr1.
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
                IF putchr1 <> "" THEN nv_message = putchr1.
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
                IF putchr1 <> "" THEN nv_message = putchr1.
                nv_error = YES.
              /*NEXT.*/
             END.
             ELSE DO:
              IF LENGTH(sic_bran.uwm301.vehreg) > 11 THEN DO:
                 ASSIGN
                  putchr1 = "Warning : Vehicle Register More Than 11 Characters".    
                  putchr  =  textchr  + "  " + TRIM(putchr1).
                 PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
                 IF putchr1 <> "" THEN nv_message = putchr1.
                 nv_error = YES.
               /*NEXT.*/
              END.
              IF sic_bran.uwm301.vehreg = "" THEN DO:
                 ASSIGN
                  putchr1 = "Vehicle Register is mandatory field.".
                  putchr  =  textchr  + "  " + TRIM(putchr1).
                 PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
                 IF putchr1 <> "" THEN nv_message = putchr1.
                 nv_error = YES.
               /*NEXT.*/
              END.
              IF sic_bran.uwm301.modcod = "" THEN DO:
                 ASSIGN
                  putchr1 = "Redbook Code เป็นค่าว่าง ".
                  putchr  =  textchr  + "  " + TRIM(putchr1).
                 PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
                 IF putchr1 <> "" THEN nv_message = putchr1.
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
                IF putchr1 <> "" THEN nv_message = putchr1.
                nv_error = YES.
              /*NEXT.*/
             END.
            
            END. /*--WK_UWM100--*/
END. /*A58-0251 Eakkapong */

/*-- Check Document No. --*/
IF sic_bran.uwm100.docno1 <> "0000000" AND sic_bran.uwm100.docno1 <> " " THEN DO:
    FIND FIRST sicuw.uwm100 USE-INDEX uwm10090 WHERE
               sicuw.uwm100.trty11 = sic_bran.uwm100.trty11 AND
               sicuw.uwm100.docno1 = sic_bran.uwm100.docno1 NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL sicuw.uwm100 THEN DO:
        ASSIGN
            putchr1 = "Document No. ซ้ำกับ Policy : " + sicuw.uwm100.policy.
            putchr  =  textchr  + "  " + TRIM(putchr1).
    
        PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
        nv_message = putchr1.
        nv_error = YES.
    END.

    /*--- Add A57-0300 Check Vat 100 ---*/
    RUN wgw\wgwvat01 (INPUT nv_batchyr,INPUT nv_batchno,INPUT nv_batcnt,  
                      INPUT nv_Policy, INPUT nv_RenCnt, INPUT nv_EndCnt,
                      OUTPUT nv_ChkVat, OUTPUT putchr1).
                      /*OUTPUT nv_error, OUTPUT putchr1).*//*A58-0393*/
    
    IF nv_ChkVat = YES THEN DO:
        ASSIGN
            putchr  =  textchr  + "  " + TRIM(putchr1).
            PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
        PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
        nv_message = putchr1.
        nv_error = YES.
    
    END.
    /*--- End A57-0300 Check Vat 100 ---*/
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDChkChas1 wgwtrnlt 
PROCEDURE PDChkChas1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VAR nv_chanew AS CHAR.
DEFINE VAR nv_len AS INTE INIT 0.

loop_chk1:
REPEAT:
    IF INDEX(nv_chassis,"-") <> 0 THEN DO:
        nv_len = LENGTH(nv_chassis).
        nv_chassis = SUBSTR(nv_chassis,1,INDEX(nv_chassis,"-") - 1) +
                     SUBSTR(nv_chassis,INDEX(nv_chassis,"-") + 1,nv_len).
    END.
    ELSE LEAVE loop_chk1.
END.
loop_chk2:
REPEAT:
    IF INDEX(nv_chassis,"/") <> 0 THEN DO:
        nv_len = LENGTH(nv_chassis).
        nv_chassis = SUBSTR(nv_chassis,1,INDEX(nv_chassis,"/") - 1) +
                     SUBSTR(nv_chassis,INDEX(nv_chassis,"/") + 1,nv_len).
    END.
    ELSE LEAVE loop_chk2.
END.
loop_chk3:
REPEAT:
    IF INDEX(nv_chassis,";") <> 0 THEN DO:
        nv_len = LENGTH(nv_chassis).
        nv_chassis = SUBSTR(nv_chassis,1,INDEX(nv_chassis,";") - 1) +
                     SUBSTR(nv_chassis,INDEX(nv_chassis,";") + 1,nv_len).
    END.
    ELSE LEAVE loop_chk3.
END.
loop_chk4:
REPEAT:
    IF INDEX(nv_chassis,".") <> 0 THEN DO:
        nv_len = LENGTH(nv_chassis).
        nv_chassis = SUBSTR(nv_chassis,1,INDEX(nv_chassis,".") - 1) +
                     SUBSTR(nv_chassis,INDEX(nv_chassis,".") + 1,nv_len).
    END.
    ELSE LEAVE loop_chk4.
END.
loop_chk5:
REPEAT:
    IF INDEX(nv_chassis,",") <> 0 THEN DO:
        nv_len = LENGTH(nv_chassis).
        nv_chassis = SUBSTR(nv_chassis,1,INDEX(nv_chassis,",") - 1) +
                     SUBSTR(nv_chassis,INDEX(nv_chassis,",") + 1,nv_len).
    END.
    ELSE LEAVE loop_chk5.
END.
loop_chk6:
REPEAT:
    IF INDEX(nv_chassis," ") <> 0 THEN DO:
        nv_len = LENGTH(nv_chassis).
        nv_chassis = SUBSTR(nv_chassis,1,INDEX(nv_chassis," ") - 1) +
                     SUBSTR(nv_chassis,INDEX(nv_chassis," ") + 1,nv_len).
    END.
    ELSE LEAVE loop_chk6.
END.
loop_chk7:
REPEAT:
    IF INDEX(nv_chassis,"\") <> 0 THEN DO:
        nv_len = LENGTH(nv_chassis).
        nv_chassis = SUBSTR(nv_chassis,1,INDEX(nv_chassis,"\") - 1) +
                     SUBSTR(nv_chassis,INDEX(nv_chassis,"\") + 1,nv_len).
    END.
    ELSE LEAVE loop_chk7.
END.
loop_chk8:
REPEAT:
    IF INDEX(nv_chassis,":") <> 0 THEN DO:
        nv_len = LENGTH(nv_chassis).
        nv_chassis = SUBSTR(nv_chassis,1,INDEX(nv_chassis,":") - 1) +
                     SUBSTR(nv_chassis,INDEX(nv_chassis,":") + 1,nv_len).
    END.
    ELSE LEAVE loop_chk8.
END.
loop_chk9:
REPEAT:
    IF INDEX(nv_chassis,"|") <> 0 THEN DO:
        nv_len = LENGTH(nv_chassis).
        nv_chassis = SUBSTR(nv_chassis,1,INDEX(nv_chassis,"|") - 1) +
                     SUBSTR(nv_chassis,INDEX(nv_chassis,"|") + 1,nv_len).
    END.
    ELSE LEAVE loop_chk9.
END.
loop_chk10:
REPEAT:
    IF INDEX(nv_chassis,"+") <> 0 THEN DO:
        nv_len = LENGTH(nv_chassis).
        nv_chassis = SUBSTR(nv_chassis,1,INDEX(nv_chassis,"+") - 1) +
                     SUBSTR(nv_chassis,INDEX(nv_chassis,"+") + 1,nv_len).
    END.
    ELSE LEAVE loop_chk10.
END.
loop_chk11:
REPEAT:
    IF INDEX(nv_chassis,"#") <> 0 THEN DO:
        nv_len = LENGTH(nv_chassis).
        nv_chassis = SUBSTR(nv_chassis,1,INDEX(nv_chassis,"#") - 1) +
                     SUBSTR(nv_chassis,INDEX(nv_chassis,"#") + 1,nv_len).
    END.
    ELSE LEAVE loop_chk11.
END.
loop_chk12:
REPEAT:
    IF INDEX(nv_chassis,"[") <> 0 THEN DO:
        nv_len = LENGTH(nv_chassis).
        nv_chassis = SUBSTR(nv_chassis,1,INDEX(nv_chassis,"[") - 1) +
                     SUBSTR(nv_chassis,INDEX(nv_chassis,"[") + 1,nv_len).
    END.
    ELSE LEAVE loop_chk12.
END.
loop_chk13:
REPEAT:
    IF INDEX(nv_chassis,"]") <> 0 THEN DO:
        nv_len = LENGTH(nv_chassis).
        nv_chassis = SUBSTR(nv_chassis,1,INDEX(nv_chassis,"]") - 1) +
                     SUBSTR(nv_chassis,INDEX(nv_chassis,"]") + 1,nv_len).
    END.
    ELSE LEAVE loop_chk13.
END.
loop_chk14:
REPEAT:
    IF INDEX(nv_chassis,"'") <> 0 THEN DO:
        nv_len = LENGTH(nv_chassis).
        nv_chassis = SUBSTR(nv_chassis,1,INDEX(nv_chassis,"'") - 1) +
                     SUBSTR(nv_chassis,INDEX(nv_chassis,"'") + 1,nv_len).
    END.
    ELSE LEAVE loop_chk14.
END.
loop_chk15:
REPEAT:
    IF INDEX(nv_chassis,"(") <> 0 THEN DO:
        nv_len = LENGTH(nv_chassis).
        nv_chassis = SUBSTR(nv_chassis,1,INDEX(nv_chassis,"(") - 1) +
                     SUBSTR(nv_chassis,INDEX(nv_chassis,"(") + 1,nv_len).
    END.
    ELSE LEAVE loop_chk15.
END.
loop_chk16:
REPEAT:
    IF INDEX(nv_chassis,")") <> 0 THEN DO:
        nv_len = LENGTH(nv_chassis).
        nv_chassis = SUBSTR(nv_chassis,1,INDEX(nv_chassis,")") - 1) +
                     SUBSTR(nv_chassis,INDEX(nv_chassis,")") + 1,nv_len).
    END.
    ELSE LEAVE loop_chk16.
END.
loop_chk17:
REPEAT:
    IF INDEX(nv_chassis,"_") <> 0 THEN DO:
        nv_len = LENGTH(nv_chassis).
        nv_chassis = SUBSTR(nv_chassis,1,INDEX(nv_chassis,"_") - 1) +
                     SUBSTR(nv_chassis,INDEX(nv_chassis,"_") + 1,nv_len).
    END.
    ELSE LEAVE loop_chk17.
END.
loop_chk18:
REPEAT:
    IF INDEX(nv_chassis,"*") <> 0 THEN DO:
        nv_len = LENGTH(nv_chassis).
        nv_chassis = SUBSTR(nv_chassis,1,INDEX(nv_chassis,"*") - 1) +
                     SUBSTR(nv_chassis,INDEX(nv_chassis,"*") + 1,nv_len).
    END.
    ELSE LEAVE loop_chk18.
END.
loop_chk19:
REPEAT:
    IF INDEX(nv_chassis,"=") <> 0 THEN DO:
        nv_len = LENGTH(nv_chassis).
        nv_chassis = SUBSTR(nv_chassis,1,INDEX(nv_chassis,"=") - 1) +
                     SUBSTR(nv_chassis,INDEX(nv_chassis,"=") + 1,nv_len).
    END.
    ELSE LEAVE loop_chk19.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDUpdateQ wgwtrnlt 
PROCEDURE PDUpdateQ :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*Find Parameter  Add Jiraphon P. A62-0286*/
FOR EACH stat.symprog USE-INDEX symprog05 WHERE stat.symprog.grpcod = "Onweb" NO-LOCK:
    IF nv_progid = "" THEN nv_progid = stat.symprog.prog.
    ELSE IF lookup(stat.symprog.prog,nv_progid) = 0 THEN nv_progid = nv_progid + "," + stat.symprog.prog.
    ELSE NEXT.
END.


FOR EACH w_polno:
    DELETE w_polno.
END.

loop_list: 
FOR EACH  sic_bran.uwm100 USE-INDEX  uwm10021
    WHERE sic_bran.uwm100.Trndat >= fi_TrnDate
    AND sic_bran.uwm100.trndat   <= fi_trndatt 
    AND sic_bran.uwm100.acno1     = fi_Acno  
    /*AND LOOKUP(sic_bran.uwm100.branch,nv_branch) <> 0*/
    AND sic_bran.uwm100.releas  = NO    
    AND LOOKUP(sic_bran.uwm100.prog,nv_progid) <> 0  /*Add Jiraphon p. A62-0286*/
    /*AND sic_bran.uwm100.Prog    = "gwGen100"*/  NO-LOCK BREAK BY  sic_bran.uwm100.Policy .
    IF sic_bran.uwm100.endcnt = 0 AND sic_bran.uwm100.polsta  = "CA" THEN NEXT loop_list.  

    /*IF sic_bran.uwm100.poltyp = "V72" THEN NEXT loop_list. */  /*A66-0045*/
    /*ELSE IF sic_bran.uwm100.poltyp <> "V70" AND /*sic_bran.uwm100.poltyp <> "V72"   AND*/*//*A66-0045*/
     IF sic_bran.uwm100.poltyp <> "V70" AND sic_bran.uwm100.poltyp <> "V72" AND
        sic_bran.uwm100.poltyp <> "V73" AND sic_bran.uwm100.poltyp <> "V74" THEN NEXT loop_list.

    FIND FIRST w_polno WHERE 
        w_polno.polno  = sic_bran.uwm100.policy AND
        w_polno.rencnt = sic_bran.uwm100.rencnt AND
        w_polno.endcnt = sic_bran.uwm100.endcnt NO-ERROR.
    IF NOT AVAIL w_polno THEN DO:
        CREATE w_polno.
        ASSIGN
            w_polno.trndat   =  sic_bran.uwm100.trndat 
            w_polno.polno    =  sic_bran.uwm100.policy
            w_polno.ntitle   =  sic_bran.uwm100.ntitle
            w_polno.name1    =  sic_bran.uwm100.name1
            w_polno.rencnt   =  sic_bran.uwm100.rencnt
            w_polno.endcnt   =  sic_bran.uwm100.endcnt 
            w_polno.trty11   =  sic_bran.uwm100.trty11 
            w_polno.docno1   =  sic_bran.uwm100.docno1   
            w_polno.agent    =  sic_bran.uwm100.agent  
            w_polno.acno1    =  sic_bran.uwm100.acno1  
            w_polno.bchyr    =  sic_bran.uwm100.bchyr  
            w_polno.bchno    =  sic_bran.uwm100.bchno  
            w_polno.bchcnt   =  sic_bran.uwm100.bchcnt 
            w_polno.releas   =  sic_bran.uwm100.releas.

        IF sic_bran.uwm100.sckno = 7000001 THEN w_polno.statusPolicy   = "SK_FAST".   /*กรมธรรม์ ทันใจ */
        ASSIGN
            w_polno.insnam = sic_bran.uwm100.ntitle + " " + sic_bran.uwm100.name1
            w_polno.recnt  = STRING(sic_bran.uwm100.RenCnt,"99") + "/" +  STRING(sic_bran.uwm100.EndCnt,"999").
        FIND LAST sic_bran.uwm301 USE-INDEX uwm30101
             WHERE sic_bran.uwm301.policy = sic_bran.uwm100.policy
               AND sic_bran.uwm301.rencnt = sic_bran.uwm100.rencnt
               AND sic_bran.uwm301.endcnt = sic_bran.uwm100.endcnt
               AND sic_bran.uwm301.bchyr  = sic_bran.uwm100.bchyr
               AND sic_bran.uwm301.bchno  = sic_bran.uwm100.bchno
               AND sic_bran.uwm301.bchcnt = sic_bran.uwm100.bchcnt NO-LOCK NO-ERROR.
        IF AVAIL sic_bran.uwm301 THEN DO:
            ASSIGN
                w_polno.modcod  = sic_bran.uwm301.modcod
                w_polno.moddes  = sic_bran.uwm301.moddes
                w_polno.chassis = sic_bran.uwm301.trareg
                w_polno.vehreg  = sic_bran.uwm301.vehreg. 
            IF sic_bran.uwm100.poltyp = "V70" THEN DO:
                nv_chassis = sic_bran.uwm301.trareg.

                RUN PDChkChas1.

                IF nv_chassis = sic_bran.uwm301.trareg THEN nv_chassis = sic_bran.uwm301.trareg.
                                                       ELSE nv_chassis = nv_chassis.                          
    
                IF nv_chassis <> "" THEN DO:
                    FIND LAST sicuw.uwm301 USE-INDEX uwm30103  WHERE
                              sicuw.uwm301.trareg = nv_chassis NO-LOCK NO-ERROR.
                    IF AVAIL sicuw.uwm301 THEN DO:
                        w_polno.chkcha = sicuw.uwm301.trareg.
                    END.
                END.
            END.
        END.
    END.

END.
OPEN QUERY br_uwm100 FOR EACH w_polno NO-LOCK BY w_polno.polno.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_bypolicy wgwtrnlt 
PROCEDURE proc_bypolicy :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH w_polno WHERE 
    w_polno.polno >= fi_policyfr AND 
    w_polno.polno <= fi_policyto NO-LOCK BREAK BY w_polno.polno.

    FIND FIRST  sic_bran.uwm100 USE-INDEX  uwm10001 WHERE 
        sic_bran.uwm100.policy = w_polno.polno  AND
        sic_Bran.uwm100.rencnt = w_polno.rencnt AND
        sic_bran.uwm100.endcnt = w_polno.endcnt NO-ERROR.
    IF AVAIL sic_bran.uwm100 THEN DO:
        ASSIGN
            nv_batchyr = sic_bran.uwm100.bchyr
            nv_batchno = sic_bran.uwm100.bchNo 
            nv_batcnt  = sic_bran.uwm100.bchCnt
            nv_Policy  = sic_bran.uwm100.Policy
            nv_RenCnt  = sic_bran.uwm100.RenCnt
            nv_EndCnt  = sic_bran.uwm100.EndCnt
            nv_Insno   = sic_bran.uwm100.insref.
        /*MESSAGE nv_batchyr
        nv_batchno
        nv_batcnt  SKIP
        nv_Policy 
        nv_RenCnt 
        nv_EndCnt 
        nv_Insno.*/
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
                  uzm701.bchcnt  =  nv_batcnt  NO-LOCK NO-ERROR. 
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
        END.
        DO:
            ASSIGN
                /*sic_bran.uzm701.trfbegtim = STRING(TIME,"HH:MM:SS") *//*A58-0251 Eakkapong */
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
            RUN PDCheckNs1.
            DISP  fi_TranPol fi_time WITH FRAME fr_main.
            /*-----MOTOR POLICY ON WEB----*/
            IF nv_error = NO THEN DO:      
                DO TRANSACTION: /*---add by Chaiyong W. A59-0312 07/07/2016*/
                /*---Begin by Chaiyong W. A57-0096 04/06/2014*/
                    nv_csuc  = nv_csuc + 1. 

                    DISPLAY  "uwm100" @ fi_File WITH FRAME fr_main.
                    RUN wgw\wgwgen01 (INPUT nv_batchyr,INPUT nv_batchno,INPUT nv_batcnt,  /*uwm100+uwd100*/
                                      INPUT nv_Policy,INPUT nv_RenCnt,INPUT nv_EndCnt
                                      ,INPUT nv_chkre 
                                      ).
                    DISPLAY  "uwm120" @ fi_File WITH FRAME fr_main.
                    RUN wgw\wgwgen02 (INPUT nv_batchyr,INPUT nv_batchno,INPUT nv_batcnt,  /*uwm120*/
                                      INPUT nv_Policy,INPUT nv_RenCnt,INPUT nv_EndCnt).
                    DISPLAY  "uwm130" @ fi_File WITH FRAME fr_main.
                    RUN wgw\wgwgen03 (INPUT nv_batchyr,INPUT nv_batchno,INPUT nv_batcnt,  /*uwm130*/
                                      INPUT nv_Policy,INPUT nv_RenCnt,INPUT nv_EndCnt).
                    DISPLAY  "uwm301" @ fi_File WITH FRAME fr_main.
                    RUN wgw\wgwgen04 (INPUT nv_batchyr,INPUT nv_batchno,INPUT nv_batcnt,  /*uwm301*/
                                      INPUT nv_Policy,INPUT nv_RenCnt,INPUT nv_EndCnt).
                    /*Add Kridtiya i. A66-0045 Date. 03/03/2023*/
                    DISPLAY  "uwm304" @ fi_File WITH FRAME fr_main.    
                    RUN wgw\wgwgen304 (INPUT nv_batchyr,INPUT nv_batchno,INPUT nv_batcnt,  /*uwm301*/
                                       INPUT nv_Policy,INPUT nv_RenCnt,INPUT nv_EndCnt).
                    DISPLAY  "uwm200" @ fi_File WITH FRAME fr_main.
                    RUN wgw\wgwgen200 (INPUT nv_batchyr,INPUT nv_batchno,INPUT nv_batcnt,  /*uwm200*/
                                       INPUT nv_Policy,INPUT nv_RenCnt,INPUT nv_EndCnt).
                    /*Add Kridtiya i. A66-0045 Date. 03/03/2023*/
                    DISPLAY  "xmm600" @ fi_File WITH FRAME fr_main.
                    RUN wgw\wgwgen05 (INPUT nv_batchyr,INPUT nv_batchno,INPUT nv_batcnt,  /*xmm600*/
                                      INPUT nv_Policy,INPUT nv_RenCnt,INPUT nv_EndCnt). 
                    DISPLAY  "Detaitem" @ fi_File WITH FRAME fr_main.
                    RUN wgw\wgwgen06 (INPUT nv_batchyr,INPUT nv_batchno,INPUT nv_batcnt,  /*Detaitem*/
                                      INPUT nv_Policy,INPUT nv_RenCnt,INPUT nv_EndCnt).
                /*---Begin by Chaiyong W. A59-0312 07/07/2016*/
                    /*Add Kridtiya i. A66-0045 Date. 03/03/2023*/
                    DISPLAY  "Release" @ fi_File WITH FRAME fr_main.
                    RUN wgw\wgwgenrl (INPUT nv_batchyr,INPUT nv_batchno,INPUT nv_batcnt,  /*uwm100+uwd100*/
                                      INPUT nv_Policy,INPUT nv_RenCnt,INPUT nv_EndCnt).
                    /*Add Kridtiya i. A66-0045 Date. 03/03/2023*/


                END. /*End by Chaiyong W. A59-0312 07/07/2016----*/


                /*comment by Kridtiya i...A58-0356...........
                    /*-- ADD A57-0154 Send Mail to Lotus Note & Inspection --*/
                    IF to_Inspec AND sic_bran.uwm100.poltyp = "V70" AND sic_bran.uwm100.rencnt = 0 THEN DO:
                        FIND FIRST sic_bran.uwm301 USE-INDEX uwm30101 WHERE
                                   sic_bran.uwm301.policy = sic_bran.uwm100.policy AND
                                   sic_bran.uwm301.rencnt = sic_bran.uwm100.rencnt AND
                                   sic_bran.uwm301.endcnt = 0                      AND
                                   sic_bran.uwm301.riskgp = 0                      AND
                                   sic_bran.uwm301.riskno = 1                      AND
                                   sic_bran.uwm301.itemno = 1                      AND
                                   sic_bran.uwm301.bchyr  = sic_bran.uwm100.bchyr  AND
                                   sic_bran.uwm301.bchno  = sic_bran.uwm100.bchno  AND
                                   sic_bran.uwm301.bchcnt = sic_bran.uwm100.bchcnt NO-LOCK NO-ERROR.
                        IF AVAIL sic_bran.uwm301 THEN DO:

                            IF SUBSTR(sic_bran.uwm301.policy,1,1) = "Q" THEN DO: /*-- Add A58-0335 --*/
                                FIND LAST sicuw.uwm301 USE-INDEX uwm30121 WHERE
                                          sicuw.uwm301.cha_no = sic_bran.uwm301.cha_no NO-LOCK NO-ERROR.
                                IF NOT AVAIL sicuw.uwm301 THEN DO:
                                    IF  sic_bran.uwm301.covcod = "1" OR SUBSTR(TRIM(sic_bran.uwm301.covcod),1,1) = "2" THEN DO:
                                        DISPLAY "Inspection" @ fi_File WITH FRAME fr_main.
                                        RUN wgw\wgwtinsp (INPUT nv_batchyr,INPUT nv_batchno,INPUT nv_batcnt,  /*Inspection*/
                                                          INPUT nv_Policy,INPUT nv_RenCnt,INPUT nv_EndCnt).
                                    END.
                                END.
                                ELSE DO:
                                    MESSAGE "Policy: " sic_bran.uwm301.policy SKIP
                                            "พบเลข Chassis: " sicuw.uwm301.cha_no " ในระบบ" SKIP
                                            "ต้องการโอน ข้อมูลเข้ากล่อง Inspection หรือไม่ ?" 
                                    VIEW-AS ALERT-BOX QUESTION BUTTON YES-NO UPDATE Choice AS LOGICAL. 
                                    IF Choice THEN DO:
                                        IF  sic_bran.uwm301.covcod = "1" OR SUBSTR(TRIM(sic_bran.uwm301.covcod),1,1) = "2" THEN DO:
                                            DISPLAY "Inspection" @ fi_File WITH FRAME fr_main.
                                            RUN wgw\wgwtinsp (INPUT nv_batchyr,INPUT nv_batchno,INPUT nv_batcnt,  /*Inspection*/
                                                              INPUT nv_Policy,INPUT nv_RenCnt,INPUT nv_EndCnt).
                                        END.
                                    END.
                                END.
                            END.
                            ELSE DO:  /*-- End A58-0335 --*/
                                IF  sic_bran.uwm301.covcod = "1" OR SUBSTR(TRIM(sic_bran.uwm301.covcod),1,1) = "2" THEN DO:
                                    DISPLAY "Inspection" @ fi_File WITH FRAME fr_main.
                                    RUN wgw\wgwtinsp (INPUT nv_batchyr,INPUT nv_batchno,INPUT nv_batcnt,  /*Inspection*/
                                                      INPUT nv_Policy,INPUT nv_RenCnt,INPUT nv_EndCnt).
                                END.
                            END.
                        END.
                    END.
                    /*-- END A57-0154 Send Mail to Lotus Note & Inspection --*/
                    end....comment by Kridtiya i...A58-0356...*/
                IF nv_error = NO THEN DO:
                    PUT STREAM ns2
                        sic_bran.uwm100.policy FORMAT "x(16)" " " 
                        sic_bran.uwm100.rencnt "/" sic_bran.uwm100.endcnt "  " 
                        nv_policy FORMAT "X(16)" " "
                        nv_rencnt "/" nv_endcnt "  "
                        sic_bran.uwm100.trndat "  "
                        sic_bran.uwm100.entdat "  "
                        sic_bran.uwm100.usrid "   " 
                        TRIM(TRIM(sic_bran.uwm100.ntitle) + " " + 
                             TRIM(sic_bran.uwm100.name1)) FORMAT "x(60)" SKIP.
                END.
            END.  /*nv_error = no*/
            ELSE nv_cnsuc  = nv_cnsuc + 1.
        END.   /*  ELSE DO:*/
    END.  /*For each*/
END.  /*---for each w_polno by Chaiyong W. A57-0096 04/06/201*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_byproducer wgwtrnlt 
PROCEDURE proc_byproducer :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH w_polno WHERE 
    w_polno.acno1 >= fi_policyfr AND 
    w_polno.acno1 <= fi_policyto NO-LOCK BREAK BY w_polno.polno.

    FIND FIRST  sic_bran.uwm100 USE-INDEX  uwm10001 WHERE 
        sic_bran.uwm100.policy = w_polno.polno  AND
        sic_Bran.uwm100.rencnt = w_polno.rencnt AND
        sic_bran.uwm100.endcnt = w_polno.endcnt NO-ERROR.
    IF AVAIL sic_bran.uwm100 THEN DO:
        ASSIGN
            nv_batchyr = sic_bran.uwm100.bchyr
            nv_batchno = sic_bran.uwm100.bchNo 
            nv_batcnt  = sic_bran.uwm100.bchCnt
            nv_Policy  = sic_bran.uwm100.Policy
            nv_RenCnt  = sic_bran.uwm100.RenCnt
            nv_EndCnt  = sic_bran.uwm100.EndCnt
            nv_Insno   = sic_bran.uwm100.insref.
        /*MESSAGE nv_batchyr
        nv_batchno
        nv_batcnt  SKIP
        nv_Policy 
        nv_RenCnt 
        nv_EndCnt 
        nv_Insno.*/
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
                  uzm701.bchcnt  =  nv_batcnt  NO-LOCK NO-ERROR. 
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
        END.
        DO:
            ASSIGN
                /*sic_bran.uzm701.trfbegtim = STRING(TIME,"HH:MM:SS") *//*A58-0251 Eakkapong */
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
            RUN PDCheckNs1.
            DISP  fi_TranPol fi_time WITH FRAME fr_main.
            /*-----MOTOR POLICY ON WEB----*/
            IF nv_error = NO THEN DO:      
                /*---Begin by Chaiyong W. A57-0096 04/06/2014*/
                nv_csuc  = nv_csuc + 1.
                DISPLAY  "uwm100" @ fi_File WITH FRAME fr_main.
                RUN wgw\wgwgen01 (INPUT nv_batchyr,INPUT nv_batchno,INPUT nv_batcnt,  /*uwm100+uwd100*/
                                  INPUT nv_Policy,INPUT nv_RenCnt,INPUT nv_EndCnt
                                  ,INPUT nv_chkre 
                                  ).
                DISPLAY  "uwm120" @ fi_File WITH FRAME fr_main.
                RUN wgw\wgwgen02 (INPUT nv_batchyr,INPUT nv_batchno,INPUT nv_batcnt,  /*uwm120*/
                                  INPUT nv_Policy,INPUT nv_RenCnt,INPUT nv_EndCnt).
                DISPLAY  "uwm130" @ fi_File WITH FRAME fr_main.
                RUN wgw\wgwgen03 (INPUT nv_batchyr,INPUT nv_batchno,INPUT nv_batcnt,  /*uwm130*/
                                  INPUT nv_Policy,INPUT nv_RenCnt,INPUT nv_EndCnt).
                DISPLAY  "uwm301" @ fi_File WITH FRAME fr_main.
                RUN wgw\wgwgen04 (INPUT nv_batchyr,INPUT nv_batchno,INPUT nv_batcnt,  /*uwm301*/
                                  INPUT nv_Policy,INPUT nv_RenCnt,INPUT nv_EndCnt).
                /*Add Kridtiya i. A66-0045 Date. 03/03/2023*/
                DISPLAY  "uwm304" @ fi_File WITH FRAME fr_main.
                RUN wgw\wgwgen304 (INPUT nv_batchyr,INPUT nv_batchno,INPUT nv_batcnt,  /*uwm301*/
                                   INPUT nv_Policy,INPUT nv_RenCnt,INPUT nv_EndCnt).
                DISPLAY  "uwm200" @ fi_File WITH FRAME fr_main.
                RUN wgw\wgwgen200 (INPUT nv_batchyr,INPUT nv_batchno,INPUT nv_batcnt,  /*uwm200*/
                                   INPUT nv_Policy,INPUT nv_RenCnt,INPUT nv_EndCnt).
                /*Add Kridtiya i. A66-0045 Date. 03/03/2023*/
                DISPLAY  "xmm600" @ fi_File WITH FRAME fr_main.
                RUN wgw\wgwgen05 (INPUT nv_batchyr,INPUT nv_batchno,INPUT nv_batcnt,  /*xmm600*/
                                  INPUT nv_Policy,INPUT nv_RenCnt,INPUT nv_EndCnt). 
                DISPLAY  "Detaitem" @ fi_File WITH FRAME fr_main.
                RUN wgw\wgwgen06 (INPUT nv_batchyr,INPUT nv_batchno,INPUT nv_batcnt,  /*Detaitem*/
                                  INPUT nv_Policy,INPUT nv_RenCnt,INPUT nv_EndCnt).
                /*Add Kridtiya i. A66-0045 Date. 03/03/2023*/
                DISPLAY  "Release" @ fi_File WITH FRAME fr_main.
                RUN wgw\wgwgenrl (INPUT nv_batchyr,INPUT nv_batchno,INPUT nv_batcnt,  /*uwm100+uwd100*/
                                  INPUT nv_Policy,INPUT nv_RenCnt,INPUT nv_EndCnt).
                /*Add Kridtiya i. A66-0045 Date. 03/03/2023*/
                /*comment by Kridtiya i...A58-0356...........
                    /*-- ADD A57-0154 Send Mail to Lotus Note & Inspection --*/
                    IF to_Inspec AND sic_bran.uwm100.poltyp = "V70" AND sic_bran.uwm100.rencnt = 0 THEN DO:
                        FIND FIRST sic_bran.uwm301 USE-INDEX uwm30101 WHERE
                                   sic_bran.uwm301.policy = sic_bran.uwm100.policy AND
                                   sic_bran.uwm301.rencnt = sic_bran.uwm100.rencnt AND
                                   sic_bran.uwm301.endcnt = 0                      AND
                                   sic_bran.uwm301.riskgp = 0                      AND
                                   sic_bran.uwm301.riskno = 1                      AND
                                   sic_bran.uwm301.itemno = 1                      AND
                                   sic_bran.uwm301.bchyr  = sic_bran.uwm100.bchyr  AND
                                   sic_bran.uwm301.bchno  = sic_bran.uwm100.bchno  AND
                                   sic_bran.uwm301.bchcnt = sic_bran.uwm100.bchcnt NO-LOCK NO-ERROR.
                        IF AVAIL sic_bran.uwm301 THEN DO:

                            IF SUBSTR(sic_bran.uwm301.policy,1,1) = "Q" THEN DO: /*-- Add A58-0335 --*/
                                FIND LAST sicuw.uwm301 USE-INDEX uwm30121 WHERE
                                          sicuw.uwm301.cha_no = sic_bran.uwm301.cha_no NO-LOCK NO-ERROR.
                                IF NOT AVAIL sicuw.uwm301 THEN DO:
                                    IF  sic_bran.uwm301.covcod = "1" OR SUBSTR(TRIM(sic_bran.uwm301.covcod),1,1) = "2" THEN DO:
                                        DISPLAY "Inspection" @ fi_File WITH FRAME fr_main.
                                        RUN wgw\wgwtinsp (INPUT nv_batchyr,INPUT nv_batchno,INPUT nv_batcnt,  /*Inspection*/
                                                          INPUT nv_Policy,INPUT nv_RenCnt,INPUT nv_EndCnt).
                                    END.
                                END.
                                ELSE DO:
                                    MESSAGE "Policy: " sic_bran.uwm301.policy SKIP
                                            "พบเลข Chassis: " sicuw.uwm301.cha_no " ในระบบ" SKIP
                                            "ต้องการโอน ข้อมูลเข้ากล่อง Inspection หรือไม่ ?" 
                                    VIEW-AS ALERT-BOX QUESTION BUTTON YES-NO UPDATE Choice AS LOGICAL. 
                                    IF Choice THEN DO:
                                        IF  sic_bran.uwm301.covcod = "1" OR SUBSTR(TRIM(sic_bran.uwm301.covcod),1,1) = "2" THEN DO:
                                            DISPLAY "Inspection" @ fi_File WITH FRAME fr_main.
                                            RUN wgw\wgwtinsp (INPUT nv_batchyr,INPUT nv_batchno,INPUT nv_batcnt,  /*Inspection*/
                                                              INPUT nv_Policy,INPUT nv_RenCnt,INPUT nv_EndCnt).
                                        END.
                                    END.
                                END.
                            END.
                            ELSE DO:  /*-- End A58-0335 --*/
                                IF  sic_bran.uwm301.covcod = "1" OR SUBSTR(TRIM(sic_bran.uwm301.covcod),1,1) = "2" THEN DO:
                                    DISPLAY "Inspection" @ fi_File WITH FRAME fr_main.
                                    RUN wgw\wgwtinsp (INPUT nv_batchyr,INPUT nv_batchno,INPUT nv_batcnt,  /*Inspection*/
                                                      INPUT nv_Policy,INPUT nv_RenCnt,INPUT nv_EndCnt).
                                END.
                            END.
                        END.
                    END.
                    /*-- END A57-0154 Send Mail to Lotus Note & Inspection --*/
                    end....comment by Kridtiya i...A58-0356...*/
                IF nv_error = NO THEN DO:
                    PUT STREAM ns2
                        sic_bran.uwm100.policy FORMAT "x(16)" " " 
                        sic_bran.uwm100.rencnt "/" sic_bran.uwm100.endcnt "  " 
                        nv_policy FORMAT "X(16)" " "
                        nv_rencnt "/" nv_endcnt "  "
                        sic_bran.uwm100.trndat "  "
                        sic_bran.uwm100.entdat "  "
                        sic_bran.uwm100.usrid "   " 
                        TRIM(TRIM(sic_bran.uwm100.ntitle) + " " + 
                             TRIM(sic_bran.uwm100.name1)) FORMAT "x(60)" SKIP.
                END.
            END.  /*nv_error = no*/
            ELSE nv_cnsuc  = nv_cnsuc + 1.
        END.   /*  ELSE DO:*/
    END.  /*For each*/
END.  /*---for each w_polno by Chaiyong W. A57-0096 04/06/201*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_bytrandat wgwtrnlt 
PROCEDURE proc_bytrandat :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN 
    n_trndatfr = DATE(fi_policyfr)
    n_trndatto = DATE(fi_policyto).
FOR EACH w_polno WHERE 
    w_polno.trndat >= n_trndatfr AND
    w_polno.trndat <= n_trndatto
/*  w_polno.polno >= fi_policyfr  AND 
    w_polno.polno <= fi_policyto   */     NO-LOCK BREAK BY w_polno.trndat.
    FIND FIRST  sic_bran.uwm100 USE-INDEX  uwm10001 WHERE 
        sic_bran.uwm100.policy = w_polno.polno  AND
        sic_Bran.uwm100.rencnt = w_polno.rencnt AND
        sic_bran.uwm100.endcnt = w_polno.endcnt NO-ERROR.
    IF AVAIL sic_bran.uwm100 THEN DO:
        ASSIGN
            nv_batchyr = sic_bran.uwm100.bchyr
            nv_batchno = sic_bran.uwm100.bchNo 
            nv_batcnt  = sic_bran.uwm100.bchCnt
            nv_Policy  = sic_bran.uwm100.Policy
            nv_RenCnt  = sic_bran.uwm100.RenCnt
            nv_EndCnt  = sic_bran.uwm100.EndCnt
            nv_Insno   = sic_bran.uwm100.insref.
        /*MESSAGE nv_batchyr
        nv_batchno
        nv_batcnt  SKIP
        nv_Policy 
        nv_RenCnt 
        nv_EndCnt 
        nv_Insno.*/
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
                  uzm701.bchcnt  =  nv_batcnt  NO-LOCK NO-ERROR. 
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
        END.
        DO:
            ASSIGN
                /*sic_bran.uzm701.trfbegtim = STRING(TIME,"HH:MM:SS") *//*A58-0251 Eakkapong */
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
            RUN PDCheckNs1.
            DISP  fi_TranPol fi_time WITH FRAME fr_main.
            /*-----MOTOR POLICY ON WEB----*/
            IF nv_error = NO THEN DO:      
                /*---Begin by Chaiyong W. A57-0096 04/06/2014*/
                nv_csuc  = nv_csuc + 1.
                DISPLAY  "uwm100" @ fi_File WITH FRAME fr_main.
                RUN wgw\wgwgen01 (INPUT nv_batchyr,INPUT nv_batchno,INPUT nv_batcnt,  /*uwm100+uwd100*/
                                  INPUT nv_Policy,INPUT nv_RenCnt,INPUT nv_EndCnt
                                  ,INPUT nv_chkre 
                                  ).
                DISPLAY  "uwm120" @ fi_File WITH FRAME fr_main.
                RUN wgw\wgwgen02 (INPUT nv_batchyr,INPUT nv_batchno,INPUT nv_batcnt,  /*uwm120*/
                                  INPUT nv_Policy,INPUT nv_RenCnt,INPUT nv_EndCnt).
                DISPLAY  "uwm130" @ fi_File WITH FRAME fr_main.
                RUN wgw\wgwgen03 (INPUT nv_batchyr,INPUT nv_batchno,INPUT nv_batcnt,  /*uwm130*/
                                  INPUT nv_Policy,INPUT nv_RenCnt,INPUT nv_EndCnt).
                DISPLAY  "uwm301" @ fi_File WITH FRAME fr_main.
                RUN wgw\wgwgen04 (INPUT nv_batchyr,INPUT nv_batchno,INPUT nv_batcnt,  /*uwm301*/
                                  INPUT nv_Policy,INPUT nv_RenCnt,INPUT nv_EndCnt).
                /*Add Kridtiya i. A66-0045 Date. 03/03/2023*/
                DISPLAY  "uwm304" @ fi_File WITH FRAME fr_main.
                RUN wgw\wgwgen304 (INPUT nv_batchyr,INPUT nv_batchno,INPUT nv_batcnt,  /*uwm301*/
                                   INPUT nv_Policy,INPUT nv_RenCnt,INPUT nv_EndCnt).
                DISPLAY  "uwm200" @ fi_File WITH FRAME fr_main.
                RUN wgw\wgwgen200 (INPUT nv_batchyr,INPUT nv_batchno,INPUT nv_batcnt,  /*uwm200*/
                                   INPUT nv_Policy,INPUT nv_RenCnt,INPUT nv_EndCnt).
                /*Add Kridtiya i. A66-0045 Date. 03/03/2023*/
                DISPLAY  "xmm600" @ fi_File WITH FRAME fr_main.
                RUN wgw\wgwgen05 (INPUT nv_batchyr,INPUT nv_batchno,INPUT nv_batcnt,  /*xmm600*/
                                  INPUT nv_Policy,INPUT nv_RenCnt,INPUT nv_EndCnt). 
                DISPLAY  "Detaitem" @ fi_File WITH FRAME fr_main.
                RUN wgw\wgwgen06 (INPUT nv_batchyr,INPUT nv_batchno,INPUT nv_batcnt,  /*Detaitem*/
                                  INPUT nv_Policy,INPUT nv_RenCnt,INPUT nv_EndCnt).
                /*Add Kridtiya i. A66-0045 Date. 03/03/2023*/
                DISPLAY  "Release" @ fi_File WITH FRAME fr_main.
                RUN wgw\wgwgenrl (INPUT nv_batchyr,INPUT nv_batchno,INPUT nv_batcnt,  /*uwm100+uwd100*/
                                  INPUT nv_Policy,INPUT nv_RenCnt,INPUT nv_EndCnt).
                /*Add Kridtiya i. A66-0045 Date. 03/03/2023*/

                /*comment by Kridtiya i...A58-0356...........
                    /*-- ADD A57-0154 Send Mail to Lotus Note & Inspection --*/
                    IF to_Inspec AND sic_bran.uwm100.poltyp = "V70" AND sic_bran.uwm100.rencnt = 0 THEN DO:
                        FIND FIRST sic_bran.uwm301 USE-INDEX uwm30101 WHERE
                                   sic_bran.uwm301.policy = sic_bran.uwm100.policy AND
                                   sic_bran.uwm301.rencnt = sic_bran.uwm100.rencnt AND
                                   sic_bran.uwm301.endcnt = 0                      AND
                                   sic_bran.uwm301.riskgp = 0                      AND
                                   sic_bran.uwm301.riskno = 1                      AND
                                   sic_bran.uwm301.itemno = 1                      AND
                                   sic_bran.uwm301.bchyr  = sic_bran.uwm100.bchyr  AND
                                   sic_bran.uwm301.bchno  = sic_bran.uwm100.bchno  AND
                                   sic_bran.uwm301.bchcnt = sic_bran.uwm100.bchcnt NO-LOCK NO-ERROR.
                        IF AVAIL sic_bran.uwm301 THEN DO:

                            IF SUBSTR(sic_bran.uwm301.policy,1,1) = "Q" THEN DO: /*-- Add A58-0335 --*/
                                FIND LAST sicuw.uwm301 USE-INDEX uwm30121 WHERE
                                          sicuw.uwm301.cha_no = sic_bran.uwm301.cha_no NO-LOCK NO-ERROR.
                                IF NOT AVAIL sicuw.uwm301 THEN DO:
                                    IF  sic_bran.uwm301.covcod = "1" OR SUBSTR(TRIM(sic_bran.uwm301.covcod),1,1) = "2" THEN DO:
                                        DISPLAY "Inspection" @ fi_File WITH FRAME fr_main.
                                        RUN wgw\wgwtinsp (INPUT nv_batchyr,INPUT nv_batchno,INPUT nv_batcnt,  /*Inspection*/
                                                          INPUT nv_Policy,INPUT nv_RenCnt,INPUT nv_EndCnt).
                                    END.
                                END.
                                ELSE DO:
                                    MESSAGE "Policy: " sic_bran.uwm301.policy SKIP
                                            "พบเลข Chassis: " sicuw.uwm301.cha_no " ในระบบ" SKIP
                                            "ต้องการโอน ข้อมูลเข้ากล่อง Inspection หรือไม่ ?" 
                                    VIEW-AS ALERT-BOX QUESTION BUTTON YES-NO UPDATE Choice AS LOGICAL. 
                                    IF Choice THEN DO:
                                        IF  sic_bran.uwm301.covcod = "1" OR SUBSTR(TRIM(sic_bran.uwm301.covcod),1,1) = "2" THEN DO:
                                            DISPLAY "Inspection" @ fi_File WITH FRAME fr_main.
                                            RUN wgw\wgwtinsp (INPUT nv_batchyr,INPUT nv_batchno,INPUT nv_batcnt,  /*Inspection*/
                                                              INPUT nv_Policy,INPUT nv_RenCnt,INPUT nv_EndCnt).
                                        END.
                                    END.
                                END.
                            END.
                            ELSE DO:  /*-- End A58-0335 --*/
                                IF  sic_bran.uwm301.covcod = "1" OR SUBSTR(TRIM(sic_bran.uwm301.covcod),1,1) = "2" THEN DO:
                                    DISPLAY "Inspection" @ fi_File WITH FRAME fr_main.
                                    RUN wgw\wgwtinsp (INPUT nv_batchyr,INPUT nv_batchno,INPUT nv_batcnt,  /*Inspection*/
                                                      INPUT nv_Policy,INPUT nv_RenCnt,INPUT nv_EndCnt).
                                END.
                            END.
                        END.
                    END.
                    /*-- END A57-0154 Send Mail to Lotus Note & Inspection --*/
                    end....comment by Kridtiya i...A58-0356...*/
                IF nv_error = NO THEN DO:
                    PUT STREAM ns2
                        sic_bran.uwm100.policy FORMAT "x(16)" " " 
                        sic_bran.uwm100.rencnt "/" sic_bran.uwm100.endcnt "  " 
                        nv_policy FORMAT "X(16)" " "
                        nv_rencnt "/" nv_endcnt "  "
                        sic_bran.uwm100.trndat "  "
                        sic_bran.uwm100.entdat "  "
                        sic_bran.uwm100.usrid "   " 
                        TRIM(TRIM(sic_bran.uwm100.ntitle) + " " + 
                             TRIM(sic_bran.uwm100.name1)) FORMAT "x(60)" SKIP.
                END.
            END.  /*nv_error = no*/
            ELSE nv_cnsuc  = nv_cnsuc + 1.
        END.   /*  ELSE DO:*/
    END.  /*For each*/
END.  /*---for each w_polno by Chaiyong W. A57-0096 04/06/201*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

