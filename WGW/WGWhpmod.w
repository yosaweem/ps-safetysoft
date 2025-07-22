&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          stat             PROGRESS
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
program id   : wgwqukk0.w
program name : Query & Update flag detail
               Import text file from  KK  to create  new policy Add in table  tlt 
Create  by   : Kridtiya i. [A54-0351]   On   14/11/2011
Connect      : GW_SAFE LD SIC_BRAN, GW_STAT LD BRSTAT ,SICSYAC  [SICUW  not connect Stat]
modify  by   : Kridtiya i. [A55-0046]   On  03/02/2012 เพิ่มคอลัมน์ เลขตรวจสภาพ
modify  by   : Ranu I. A62-0219 date.28/05/2019 get value redbook  sumsi
+++++++++++++++++++++++++-+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
 
Def    Input-Output Parameter n_branch As   Char    Format    "x(40)".
Def    INPUT-OUTPUT Parameter n_brand  As   Char    Format    "x(20)".
Def    Input-Output Parameter n_year   As   Char    Format    "x(10)".
Def    Input-Output Parameter n_engcc  As   DECI    Format    "->>,>>9.99".
DEF    OUTPUT Parameter n_redbook  As   Char    Format    "x(10)".
DEF    OUTPUT PARAMETER n_sumsi    AS DECI FORMAT "->>>,>>>,>>9.99" .
Def    var  nv_rectlt   as  recid  init  0.
Def    var  nv_recidtlt  as   recid   init  0.
def   stream  ns2.
DEF VAR   nv_cnt   as  int  init   1.
DEF VAR   nv_row   as  int  init   0.
DEF VAR   n_record AS  INTE INIT   0.
DEF VAR   n_comname AS CHAR INIT  "".
DEFINE  VAR n_asdat       AS CHAR.
DEFINE  VAR vAcProc_fil   AS CHAR.
DEFINE  VAR vAcProc_fil2  AS CHAR.
DEFINE  VAR n_asdat2       AS CHAR.

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
&Scoped-define INTERNAL-TABLES maktab_fil

/* Definitions for BROWSE br_tlt                                        */
&Scoped-define FIELDS-IN-QUERY-br_tlt maktab_fil.sclass maktab_fil.modcod ~
maktab_fil.makdes maktab_fil.moddes maktab_fil.si maktab_fil.makyea ~
maktab_fil.engine maktab_fil.tons maktab_fil.seats 
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_tlt 
&Scoped-define QUERY-STRING-br_tlt FOR EACH maktab_fil NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-br_tlt OPEN QUERY br_tlt FOR EACH maktab_fil NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-br_tlt maktab_fil
&Scoped-define FIRST-TABLE-IN-QUERY-br_tlt maktab_fil


/* Definitions for FRAME fr_main                                        */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS fi_brand3 Bu_ch1 fi_brand2 fi_model2 Bu_ch2 ~
fi_brand1 fi_model1 fi_caryear Bu_ch3 fi_brand fi_model br_tlt fi_caryear1 ~
fi_class Bu_ch4 fi_readbook fi_class3 Bu_ch5 bu_exit RECT-332 RECT-340 ~
RECT-341 RECT-2 RECT-3 RECT-4 RECT-5 RECT-6 
&Scoped-Define DISPLAYED-OBJECTS fi_brand3 fi_brand2 fi_model2 fi_brand1 ~
fi_model1 fi_caryear fi_brand fi_model fi_caryear1 fi_class fi_readbook ~
fi_class3 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR c-wins AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON Bu_ch1 AUTO-GO 
     LABEL "Search" 
     SIZE 8.5 BY .95
     BGCOLOR 8 .

DEFINE BUTTON Bu_ch2 AUTO-GO 
     LABEL "Search" 
     SIZE 8.5 BY .95
     BGCOLOR 8 .

DEFINE BUTTON Bu_ch3 AUTO-GO 
     LABEL "Search1" 
     SIZE 8.5 BY .95
     BGCOLOR 8 .

DEFINE BUTTON Bu_ch4 AUTO-GO 
     LABEL "Search" 
     SIZE 8.5 BY .95
     BGCOLOR 8 .

DEFINE BUTTON Bu_ch5 AUTO-GO 
     LABEL "Search" 
     SIZE 8.5 BY .95
     BGCOLOR 8 .

DEFINE BUTTON bu_exit 
     LABEL "Exit" 
     SIZE 8 BY 1
     FONT 6.

DEFINE VARIABLE fi_brand AS CHARACTER FORMAT "X(35)":U 
     VIEW-AS FILL-IN 
     SIZE 23 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_brand1 AS CHARACTER FORMAT "X(35)":U 
     VIEW-AS FILL-IN 
     SIZE 23 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_brand2 AS CHARACTER FORMAT "X(35)":U 
     VIEW-AS FILL-IN 
     SIZE 23 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_brand3 AS CHARACTER FORMAT "X(35)":U 
     VIEW-AS FILL-IN 
     SIZE 23 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_caryear AS CHARACTER FORMAT "X(4)":U 
     VIEW-AS FILL-IN 
     SIZE 6 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_caryear1 AS CHARACTER FORMAT "X(4)":U 
     VIEW-AS FILL-IN 
     SIZE 6 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_class AS CHARACTER FORMAT "X(3)":U 
     VIEW-AS FILL-IN 
     SIZE 6 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_class3 AS CHARACTER FORMAT "X(3)":U 
     VIEW-AS FILL-IN 
     SIZE 6.5 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_model AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 17 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_model1 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 17 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_model2 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 17 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_readbook AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 19 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 11 BY 1.43
     BGCOLOR 4 FGCOLOR 12 .

DEFINE RECTANGLE RECT-3
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 11 BY 1.43
     BGCOLOR 4 .

DEFINE RECTANGLE RECT-332
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 117 BY 7.52
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-340
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 116 BY 7.38
     BGCOLOR 31 .

DEFINE RECTANGLE RECT-341
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 11 BY 1.52
     BGCOLOR 6 .

DEFINE RECTANGLE RECT-4
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 11 BY 1.43
     BGCOLOR 4 .

DEFINE RECTANGLE RECT-5
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 11 BY 1.43
     BGCOLOR 4 FGCOLOR 7 .

DEFINE RECTANGLE RECT-6
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 11 BY 1.43
     BGCOLOR 4 FGCOLOR 4 .

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_tlt FOR 
      maktab_fil SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_tlt
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_tlt c-wins _STRUCTURED
  QUERY br_tlt NO-LOCK DISPLAY
      maktab_fil.sclass COLUMN-LABEL "คลาส" FORMAT "x(4)":U WIDTH 5
      maktab_fil.modcod COLUMN-LABEL "ReadBook" FORMAT "x(10)":U
            WIDTH 11
      maktab_fil.makdes COLUMN-LABEL "Brand" FORMAT "x(30)":U WIDTH 14
      maktab_fil.moddes COLUMN-LABEL "Model" FORMAT "x(40)":U WIDTH 38
      maktab_fil.si FORMAT ">>>,>>>,>>9":U WIDTH 14
      maktab_fil.makyea COLUMN-LABEL "Year" FORMAT "9999":U WIDTH 6
      maktab_fil.engine COLUMN-LABEL "CC's" FORMAT ">>>>9":U WIDTH 8
      maktab_fil.tons COLUMN-LABEL "Tons" FORMAT ">>>9.99":U WIDTH 6
      maktab_fil.seats COLUMN-LABEL "Seats" FORMAT ">>9":U WIDTH 5.5
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS NO-TAB-STOP SIZE 117 BY 13
         BGCOLOR 15 FONT 6 ROW-HEIGHT-CHARS .5.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     fi_brand3 AT ROW 1.52 COL 17.5 COLON-ALIGNED NO-LABEL
     Bu_ch1 AT ROW 1.52 COL 44.17
     fi_brand2 AT ROW 2.86 COL 17.5 COLON-ALIGNED NO-LABEL
     fi_model2 AT ROW 2.86 COL 49 COLON-ALIGNED NO-LABEL
     Bu_ch2 AT ROW 2.86 COL 70.17
     fi_brand1 AT ROW 4.19 COL 17.5 COLON-ALIGNED NO-LABEL
     fi_model1 AT ROW 4.19 COL 49 COLON-ALIGNED NO-LABEL
     fi_caryear AT ROW 4.19 COL 74.33 COLON-ALIGNED NO-LABEL
     Bu_ch3 AT ROW 4.19 COL 84.5
     fi_brand AT ROW 5.52 COL 17.5 COLON-ALIGNED NO-LABEL
     fi_model AT ROW 5.52 COL 49 COLON-ALIGNED NO-LABEL
     br_tlt AT ROW 8.57 COL 1
     fi_caryear1 AT ROW 5.52 COL 74.33 COLON-ALIGNED NO-LABEL
     fi_class AT ROW 5.52 COL 88.33 COLON-ALIGNED NO-LABEL
     Bu_ch4 AT ROW 5.52 COL 98.5
     fi_readbook AT ROW 6.76 COL 21.5 COLON-ALIGNED NO-LABEL
     fi_class3 AT ROW 6.76 COL 49 COLON-ALIGNED NO-LABEL
     Bu_ch5 AT ROW 6.76 COL 59.5
     bu_exit AT ROW 1.52 COL 98.5
     " รุ่นรถ :" VIEW-AS TEXT
          SIZE 7 BY .95 AT ROW 2.86 COL 43.5
          BGCOLOR 2 FGCOLOR 7 FONT 6
     " รุ่นรถ :" VIEW-AS TEXT
          SIZE 7 BY .95 AT ROW 4.19 COL 43.5
          BGCOLOR 2 FGCOLOR 7 FONT 6
     " CASE2: ยี่ห้อรถ" VIEW-AS TEXT
          SIZE 15 BY .95 AT ROW 2.86 COL 3.5
          BGCOLOR 2 FGCOLOR 7 FONT 6
     " CASE1: ยี่ห้อรถ" VIEW-AS TEXT
          SIZE 15 BY .95 AT ROW 1.52 COL 3.5
          BGCOLOR 2 FGCOLOR 7 FONT 6
     "  ปีรถ :" VIEW-AS TEXT
          SIZE 7 BY .95 AT ROW 4.19 COL 68.67
          BGCOLOR 2 FGCOLOR 7 FONT 6
     " CASE3: ยี่ห้อรถ" VIEW-AS TEXT
          SIZE 15 BY .95 AT ROW 4.19 COL 3.5
          BGCOLOR 2 FGCOLOR 7 FONT 6
     " CASE4: ยี่ห้อรถ" VIEW-AS TEXT
          SIZE 15 BY .95 AT ROW 5.52 COL 3.5
          BGCOLOR 2 FGCOLOR 7 FONT 6
     " CASE5: REDBOOK" VIEW-AS TEXT
          SIZE 19 BY .95 AT ROW 6.76 COL 3.5
          BGCOLOR 2 FGCOLOR 7 FONT 6
     "  ปีรถ :" VIEW-AS TEXT
          SIZE 7 BY .95 AT ROW 5.52 COL 68.67
          BGCOLOR 2 FGCOLOR 7 FONT 6
     " Class :" VIEW-AS TEXT
          SIZE 7 BY .95 AT ROW 6.76 COL 43.5
          BGCOLOR 2 FGCOLOR 7 FONT 6
     " รุ่นรถ :" VIEW-AS TEXT
          SIZE 7 BY .95 AT ROW 5.52 COL 43.5
          BGCOLOR 2 FGCOLOR 7 FONT 6
     " Class :" VIEW-AS TEXT
          SIZE 7 BY .95 AT ROW 5.52 COL 83
          BGCOLOR 2 FGCOLOR 7 FONT 6
     RECT-332 AT ROW 1 COL 1
     RECT-340 AT ROW 1 COL 1
     RECT-341 AT ROW 1.24 COL 97.33
     RECT-2 AT ROW 5.33 COL 97
     RECT-3 AT ROW 2.62 COL 68.83
     RECT-4 AT ROW 6.52 COL 58.33
     RECT-5 AT ROW 3.95 COL 83.33
     RECT-6 AT ROW 1.29 COL 43
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 117.67 BY 20.91
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
         TITLE              = "Query Make/Model Details"
         HEIGHT             = 20.86
         WIDTH              = 117.5
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
/* BROWSE-TAB br_tlt fi_model fr_main */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(c-wins)
THEN c-wins:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_tlt
/* Query rebuild information for BROWSE br_tlt
     _TblList          = "stat.maktab_fil"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _FldNameList[1]   > stat.maktab_fil.sclass
"maktab_fil.sclass" "คลาส" ? "character" ? ? ? ? ? ? no ? no no "5" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[2]   > stat.maktab_fil.modcod
"maktab_fil.modcod" "ReadBook" "x(10)" "character" ? ? ? ? ? ? no ? no no "11" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   > stat.maktab_fil.makdes
"maktab_fil.makdes" "Brand" "x(30)" "character" ? ? ? ? ? ? no ? no no "14" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   > stat.maktab_fil.moddes
"maktab_fil.moddes" "Model" ? "character" ? ? ? ? ? ? no ? no no "38" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   > stat.maktab_fil.si
"maktab_fil.si" ? ">>>,>>>,>>9" "integer" ? ? ? ? ? ? no ? no no "14" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[6]   > stat.maktab_fil.makyea
"maktab_fil.makyea" "Year" ? "integer" ? ? ? ? ? ? no ? no no "6" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[7]   > stat.maktab_fil.engine
"maktab_fil.engine" "CC's" ? "integer" ? ? ? ? ? ? no ? no no "8" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[8]   > stat.maktab_fil.tons
"maktab_fil.tons" "Tons" ? "decimal" ? ? ? ? ? ? no ? no no "6" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[9]   > stat.maktab_fil.seats
"maktab_fil.seats" "Seats" ? "integer" ? ? ? ? ? ? no ? no no "5.5" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _Query            is NOT OPENED
*/  /* BROWSE br_tlt */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME c-wins
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c-wins c-wins
ON END-ERROR OF c-wins /* Query Make/Model Details */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c-wins c-wins
ON WINDOW-CLOSE OF c-wins /* Query Make/Model Details */
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
   ASSIGN 
        n_branch  = stat.maktab_fil.moddes          
        n_brand   = stat.maktab_fil.makdes         
        n_year    = string(stat.maktab_fil.makyea) 
        n_engcc   = stat.maktab_fil.engine
        n_redbook = stat.maktab_fil.modcod   /*a62-0219*/  
        n_sumsi   = stat.maktab_fil.si . /*a62-0219*/
   /* Run  wgw\wgwqupo2(Input  nv_recidtlt).*/
    {&WINDOW-NAME}:hidden  =  No.                                               

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_tlt c-wins
ON MOUSE-SELECT-CLICK OF br_tlt IN FRAME fr_main
DO:
    Get  current  br_tlt.
    /*FIND CURRENT stat.maktab_fil NO-LOCK .*/
    ASSIGN 
        n_branch = stat.maktab_fil.moddes          
        n_brand  = stat.maktab_fil.makdes         
        n_year   = string(stat.maktab_fil.makyea) 
        n_engcc  = stat.maktab_fil.engine
        n_redbook = stat.maktab_fil.modcod   /*a62-0219*/ 
        n_sumsi   = stat.maktab_fil.si . /*a62-0219*/

    Apply "Close" to This-procedure.              
    Return no-apply.
    /*Get Current br_tlt.
    nv_recidtlt  =  Recid(tlt).
    {&WINDOW-NAME}:hidden  =  Yes. 
    FIND LAST maktab_fil WHERE RECID(maktab_fil)  = nv_recidtlt NO-LOCK NO-ERROR.
    IF AVAIL maktab_fil THEN
     ASSIGN 
        n_branch = stat.maktab_fil.moddes          
        n_brand  = stat.maktab_fil.makdes         
        n_year   = string(stat.maktab_fil.makyea) 
        n_engcc  = stat.maktab_fil.engine.   
   /* Run  wgw\wgwqupo2(Input  nv_recidtlt).*/
    {&WINDOW-NAME}:hidden  =  No.*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_tlt c-wins
ON MOUSE-SELECT-DBLCLICK OF br_tlt IN FRAME fr_main
DO:
    Get  current  br_tlt.
    /*FIND CURRENT stat.maktab_fil NO-LOCK .*/
    ASSIGN 
        n_branch = stat.maktab_fil.moddes          
        n_brand  = stat.maktab_fil.makdes         
        n_year   = string(stat.maktab_fil.makyea) 
        n_engcc  = stat.maktab_fil.engine
        n_redbook = stat.maktab_fil.modcod   /*a62-0219*/
        n_sumsi   = stat.maktab_fil.si . /*a62-0219*/

    Apply "Close" to This-procedure.              
    Return no-apply.
    /*Get Current br_tlt.
    nv_recidtlt  =  Recid(tlt).
    {&WINDOW-NAME}:hidden  =  Yes. 
     FIND LAST maktab_fil WHERE RECID(maktab_fil)  = nv_recidtlt NO-LOCK NO-ERROR.
    IF AVAIL maktab_fil THEN
     ASSIGN 
        n_branch = stat.maktab_fil.moddes          
        n_brand  = stat.maktab_fil.makdes         
        n_year   = string(stat.maktab_fil.makyea) 
        n_engcc  = stat.maktab_fil.engine.   
   /* Run  wgw\wgwqupo2(Input  nv_recidtlt).*/
    {&WINDOW-NAME}:hidden  =  No.*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_tlt c-wins
ON VALUE-CHANGED OF br_tlt IN FRAME fr_main
DO:
    Get  current  br_tlt.
    /*FIND CURRENT stat.maktab_fil NO-LOCK .*/
    ASSIGN 
        n_branch = stat.maktab_fil.moddes          
        n_brand  = stat.maktab_fil.makdes         
        n_year   = string(stat.maktab_fil.makyea) 
        n_engcc  = stat.maktab_fil.engine
        n_redbook = stat.maktab_fil.modcod   /*a62-0219*/
        n_sumsi   = stat.maktab_fil.si .   /*a62-0219*/
    Apply "Close" to This-procedure.              
    Return no-apply.
     /*nv_rectlt =  recid(tlt).*/
     /*fi_name   =  tlt.ins_name.
     disp  fi_name  with frame  fr_main.*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Bu_ch1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Bu_ch1 c-wins
ON CHOOSE OF Bu_ch1 IN FRAME fr_main /* Search */
DO:
    Open Query br_tlt 
        FOR EACH stat.maktab_fil  USE-INDEX maktab04 NO-LOCK WHERE
        (index(stat.maktab_fil.makdes,trim(fi_brand3))  <> 0 )  
        BY stat.maktab_fil.moddes
        BY stat.maktab_fil.si    .
            ASSIGN nv_recidtlt  =  Recid(tlt).
            Apply "Entry"  to br_tlt.
            Return no-apply. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Bu_ch2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Bu_ch2 c-wins
ON CHOOSE OF Bu_ch2 IN FRAME fr_main /* Search */
DO:
    Open Query br_tlt 
        FOR EACH stat.maktab_fil  USE-INDEX maktab04 NO-LOCK WHERE
        (index(stat.maktab_fil.makdes,trim(fi_brand2))  <> 0 )  AND
        (index(stat.maktab_fil.moddes,trim(fi_model2)) <> 0 )   
        BY stat.maktab_fil.moddes
        BY stat.maktab_fil.si    .
            ASSIGN nv_recidtlt  =  Recid(tlt).
            Apply "Entry"  to br_tlt.
            Return no-apply. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Bu_ch3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Bu_ch3 c-wins
ON CHOOSE OF Bu_ch3 IN FRAME fr_main /* Search1 */
DO:
    Open Query br_tlt 
        FOR EACH stat.maktab_fil  USE-INDEX maktab04 NO-LOCK WHERE
        (index(stat.maktab_fil.makdes,trim(fi_brand1)) <> 0 ) AND 
        (index(stat.maktab_fil.moddes,trim(fi_model1)) <> 0 ) AND 
                  stat.maktab_fil.makyea    = inte(fi_caryear)      
        BY stat.maktab_fil.moddes
        BY stat.maktab_fil.si    .
            ASSIGN nv_recidtlt  =  Recid(tlt).
            Apply "Entry"  to br_tlt.
            Return no-apply. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Bu_ch4
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Bu_ch4 c-wins
ON CHOOSE OF Bu_ch4 IN FRAME fr_main /* Search */
DO:
    Open Query br_tlt 
        FOR EACH stat.maktab_fil  USE-INDEX maktab02 NO-LOCK WHERE
        stat.maktab_fil.sclass         =  trim(fi_class)     AND 
        (index(stat.maktab_fil.makdes,trim(fi_brand)) <> 0 ) AND 
        (index(stat.maktab_fil.moddes,trim(fi_model)) <> 0 ) AND
               stat.maktab_fil.makyea    = inte(fi_caryear1)     
        BY stat.maktab_fil.moddes
        BY stat.maktab_fil.si    .
            nv_recidtlt  =  Recid(tlt).
            Apply "Entry"  to br_tlt.
            Return no-apply. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Bu_ch5
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Bu_ch5 c-wins
ON CHOOSE OF Bu_ch5 IN FRAME fr_main /* Search */
DO:
    Open Query br_tlt 
        FOR EACH stat.maktab_fil  USE-INDEX maktab01 NO-LOCK WHERE
              stat.maktab_fil.sclass  =  trim(fi_class3)      AND
        index(stat.maktab_fil.modcod,trim(fi_readbook)) <> 0   
        BY stat.maktab_fil.moddes
        BY stat.maktab_fil.si    .
            nv_recidtlt  =  Recid(tlt).
            Apply "Entry"  to br_tlt.
            Return no-apply.
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


&Scoped-define SELF-NAME fi_brand
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_brand c-wins
ON LEAVE OF fi_brand IN FRAME fr_main
DO:
    fi_brand = INPUT fi_brand.
    ASSIGN 
        fi_brand3 = INPUT fi_brand  
        fi_brand2 = INPUT fi_brand  
        fi_brand1 = INPUT fi_brand .
    DISP fi_brand3 fi_brand2  fi_brand1 fi_brand WITH FRAM fr_main. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_brand1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_brand1 c-wins
ON LEAVE OF fi_brand1 IN FRAME fr_main
DO:
    fi_brand1 = INPUT fi_brand1.
    ASSIGN 
        fi_brand3 = INPUT fi_brand1 
        fi_brand2 = INPUT fi_brand1 
        fi_brand  = INPUT fi_brand1.
    DISP fi_brand3 fi_brand2  fi_brand1 fi_brand WITH FRAM fr_main. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_brand2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_brand2 c-wins
ON LEAVE OF fi_brand2 IN FRAME fr_main
DO:
    fi_brand2 = INPUT fi_brand2.
    ASSIGN 
        fi_brand3 = INPUT fi_brand2 
        fi_brand1 = INPUT fi_brand2
        fi_brand  = INPUT fi_brand2.
    DISP fi_brand3 fi_brand2  fi_brand1 fi_brand WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_brand3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_brand3 c-wins
ON LEAVE OF fi_brand3 IN FRAME fr_main
DO:
    fi_brand3 = INPUT fi_brand3.
    ASSIGN 
        fi_brand2 = INPUT fi_brand3 
        fi_brand1 = INPUT fi_brand3
        fi_brand  = INPUT fi_brand3.
    DISP fi_brand3 fi_brand2  fi_brand1 fi_brand WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_caryear
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_caryear c-wins
ON LEAVE OF fi_caryear IN FRAME fr_main
DO:
    fi_caryear = INPUT fi_caryear.
    ASSIGN  fi_caryear1 =  INPUT fi_caryear.
    DISP fi_caryear   fi_caryear1 WITH FRAM fr_main. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_caryear1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_caryear1 c-wins
ON LEAVE OF fi_caryear1 IN FRAME fr_main
DO:
    fi_caryear1 = INPUT fi_caryear1.
    ASSIGN fi_caryear =  INPUT fi_caryear1.
    DISP fi_caryear   fi_caryear1 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_class
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_class c-wins
ON LEAVE OF fi_class IN FRAME fr_main
DO:
    fi_class = INPUT fi_class.
    ASSIGN fi_class3  = INPUT fi_class.
    DISP fi_class fi_class3 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_class3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_class3 c-wins
ON LEAVE OF fi_class3 IN FRAME fr_main
DO:
    fi_class3 = INPUT fi_class3.
    ASSIGN fi_class = INPUT fi_class3.
    DISP fi_class3 fi_class  WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_model
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_model c-wins
ON LEAVE OF fi_model IN FRAME fr_main
DO:
    Assign  fi_model = INPUT fi_model.
    ASSIGN 
        fi_model2  = INPUT fi_model 
        fi_model1   = INPUT fi_model .
    DISP  fi_model2 fi_model1 fi_model  WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_model1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_model1 c-wins
ON LEAVE OF fi_model1 IN FRAME fr_main
DO:
    fi_model1 = INPUT fi_model1.
    ASSIGN 
        fi_model2  = INPUT fi_model1
        fi_model   = INPUT fi_model1.
    DISP  fi_model2 fi_model1 fi_model  WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_model2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_model2 c-wins
ON LEAVE OF fi_model2 IN FRAME fr_main
DO:
    fi_model2 = INPUT fi_model2.
    ASSIGN 
        fi_model1  = INPUT fi_model2
        fi_model   = INPUT fi_model2.
    DISP  fi_model2 fi_model1 fi_model  WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_readbook
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_readbook c-wins
ON LEAVE OF fi_readbook IN FRAME fr_main
DO:
    fi_readbook = INPUT fi_readbook.
    DISP fi_readbook WITH FRAM fr_main.
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
    gv_prgid = "wgwhpmod".
    gv_prog  = "Query Make/Model Details ".
    RUN  WUT\WUTHEAD ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).
    ASSIGN fi_class = ""
        fi_brand3 = n_brand
        fi_brand2 = n_brand
        fi_brand1 = n_brand
        fi_brand  = n_brand
        fi_model  = "" .
   Disp  fi_class fi_brand3 fi_brand2  fi_brand1 fi_brand  fi_model with frame fr_main. 
    /*********************************************************************/ 
    /*  RUN Wut\WutwiCen ({&WINDOW-NAME}:HANDLE). */ 
    /*CURRENT-WINDOW:WINDOW-STATE = WINDOW-MAXIMIZED.*/
    SESSION:DATA-ENTRY-RETURN = YES.
    
    /*Rect-333:Move-to-top().*/
   /* Rect-338:Move-to-top().  */
   /* RECT-346:Move-to-top(). */
   /* Rect-339:Move-to-top().   */ 
    
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
  DISPLAY fi_brand3 fi_brand2 fi_model2 fi_brand1 fi_model1 fi_caryear fi_brand 
          fi_model fi_caryear1 fi_class fi_readbook fi_class3 
      WITH FRAME fr_main IN WINDOW c-wins.
  ENABLE fi_brand3 Bu_ch1 fi_brand2 fi_model2 Bu_ch2 fi_brand1 fi_model1 
         fi_caryear Bu_ch3 fi_brand fi_model br_tlt fi_caryear1 fi_class Bu_ch4 
         fi_readbook fi_class3 Bu_ch5 bu_exit RECT-332 RECT-340 RECT-341 RECT-2 
         RECT-3 RECT-4 RECT-5 RECT-6 
      WITH FRAME fr_main IN WINDOW c-wins.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW c-wins.
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
/*
Open Query br_tlt 
    For each tlt Use-index  tlt01 NO-LOCK 
    WHERE 
    tlt.trndat         >=  fi_trndatfr   And
    tlt.trndat         <=  fi_trndatto   And
    tlt.comp_noti_tlt  >=  fi_polfr      And
    tlt.comp_noti_tlt  <=  fi_polto      And
    tlt.genusr   =  "phone"         .*/
        
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

