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
program id   : wgwqupo3.w
program name : Query & Update flag detail
Create  by   : Kridtiya i. [A55-0073]   On   28/02/2012
Connect      : GW_SAFE LD SIC_BRAN, GW_STAT LD BRSTAT ,SICSYAC  [SICUW  not connect Stat]
modify by    : Kridtiya i. A55-0125...ปรับแก้ไขให้ กรณีงาน 1เรคคอร์ดสามารถลบแก้ไขได้ค่ะ
modify by    : Kridtiya i. A55-0257...ปรับแก้ไขให้ แสดงเลขทะเบียนรถได้ถูกต้อง
Modify by    : Ranu I. A62-0219 เพิ่มปุ่ม Cancel (UP_CA)
+++++++++++++++++++++++++++++++++++++++++++++++*/
DEF VAR   nv_rectlt     as recid init  0.
DEF VAR   nv_recidtlt   as recid init  0.
def  stream  ns2.          
DEF VAR   nv_cnt        as int   init   1.
DEF VAR   nv_row        as int   init   0.
DEF VAR   n_record      AS INTE  INIT   0.
DEF VAR   n_comname     AS CHAR  INIT  "".
DEF VAR   n_asdat       AS CHAR.
DEF VAR   vAcProc_fil   AS CHAR.

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
&Scoped-define FIELDS-IN-QUERY-br_tlt tlt.releas tlt.nor_noti_tlt tlt.lotno ~
tlt.lince1 tlt.policy tlt.ins_name tlt.nor_effdat tlt.expodat tlt.cha_no ~
tlt.nor_usr_ins tlt.expousr tlt.comp_pol 
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_tlt 
&Scoped-define QUERY-STRING-br_tlt FOR EACH tlt NO-LOCK ~
    BY tlt.comp_noti_tlt
&Scoped-define OPEN-QUERY-br_tlt OPEN QUERY br_tlt FOR EACH tlt NO-LOCK ~
    BY tlt.comp_noti_tlt.
&Scoped-define TABLES-IN-QUERY-br_tlt tlt
&Scoped-define FIRST-TABLE-IN-QUERY-br_tlt tlt


/* Definitions for FRAME fr_main                                        */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS bu_reles cb_search fi_trndatfr fi_trndatto ~
fi_polfr fi_polto bu_ok fi_search bu_sch bu_exit br_tlt fi_searchcom bu_del ~
btnFirst btnPrev btnNext btnLast bu_ca RECT-332 RECT-333 RECT-340 RECT-494 ~
RECT-495 RECT-21 RECT-496 RECT-497 RECT-499 RECT-500 RECT-498 
&Scoped-Define DISPLAYED-OBJECTS fi_policy70 cb_search fi_trndatfr ~
fi_trndatto fi_polfr fi_polto fi_search fi_searchcom fi_policy72 fi_polname ~
fi_chassisno fi_vehregno fi_releaseno 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR c-wins AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON btnFirst 
     IMAGE-UP FILE "adeicon\pvfirst":U
     IMAGE-DOWN FILE "adeicon\pvfirstd":U
     IMAGE-INSENSITIVE FILE "adeicon\pvfirstx":U
     LABEL "<<" 
     SIZE 5.5 BY 1.

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

DEFINE BUTTON bu_ca 
     LABEL "UP_CA" 
     SIZE 9.5 BY 1.19.

DEFINE BUTTON bu_del 
     LABEL "DELETE" 
     SIZE 9.5 BY 1.19.

DEFINE BUTTON bu_exit 
     LABEL "Exit" 
     SIZE 9.5 BY 1.19
     FONT 6.

DEFINE BUTTON bu_ok 
     LABEL "Ok" 
     SIZE 8 BY 1.62
     FONT 6.

DEFINE BUTTON bu_reles 
     LABEL "UP_REL" 
     SIZE 9.5 BY 1.19.

DEFINE BUTTON bu_sch 
     LABEL "Search" 
     SIZE 8 BY 1.48.

DEFINE VARIABLE cb_search AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEMS "ชื่อลูกค้า" 
     DROP-DOWN-LIST
     SIZE 38 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_chassisno AS CHARACTER FORMAT "X(35)":U 
     VIEW-AS FILL-IN 
     SIZE 23.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_polfr AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_policy70 AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 22 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_policy72 AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 22 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_polname AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 48.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_polto AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 16 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_releaseno AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 23.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_search AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 38 BY 1.05
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_searchcom AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 38 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_trndatfr AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_trndatto AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 16 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_vehregno AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 23.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE RECTANGLE RECT-21
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 25.5 BY 2.1
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-332
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 67 BY 4
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-333
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 11 BY 3
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-340
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 54.5 BY 3
     BGCOLOR 31 .

DEFINE RECTANGLE RECT-494
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 67 BY 19.76
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-495
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 12.5 BY 2.14
     BGCOLOR 2 .

DEFINE RECTANGLE RECT-496
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 65.5 BY 4.05
     BGCOLOR 18 .

DEFINE RECTANGLE RECT-497
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 10.17 BY 2.29
     BGCOLOR 10 .

DEFINE RECTANGLE RECT-498
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 11.83 BY 2.14
     BGCOLOR 4 .

DEFINE RECTANGLE RECT-499
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 12.67 BY 2.14
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-500
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 12.5 BY 2.14
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
      tlt.releas FORMAT "x(10)":U WIDTH 6
      tlt.nor_noti_tlt FORMAT "x(25)":U WIDTH 17
      tlt.lotno COLUMN-LABEL "Company" FORMAT "x(15)":U WIDTH 9
      tlt.lince1 COLUMN-LABEL "ทะเบียน" FORMAT "x(30)":U WIDTH 11.83
      tlt.policy FORMAT "x(16)":U
      tlt.ins_name FORMAT "x(50)":U WIDTH 18.33
      tlt.nor_effdat COLUMN-LABEL "Comdate." FORMAT "99/99/9999":U
            WIDTH 10.83
      tlt.expodat COLUMN-LABEL "Expydate." FORMAT "99/99/9999":U
            WIDTH 10.33
      tlt.cha_no FORMAT "x(20)":U WIDTH 18.83
      tlt.nor_usr_ins FORMAT "x(50)":U WIDTH 23.83
      tlt.expousr FORMAT "x(8)":U
      tlt.comp_pol FORMAT "x(16)":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 65 BY 23.86
         BGCOLOR 15 FONT 6 ROW-HEIGHT-CHARS .67.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     bu_reles AT ROW 13.05 COL 44.5
     fi_policy70 AT ROW 9.48 COL 17.17 COLON-ALIGNED NO-LABEL
     cb_search AT ROW 5.62 COL 15.83 NO-LABEL
     fi_trndatfr AT ROW 1.57 COL 16.83 COLON-ALIGNED NO-LABEL
     fi_trndatto AT ROW 1.57 COL 37 COLON-ALIGNED NO-LABEL
     fi_polfr AT ROW 2.76 COL 16.83 COLON-ALIGNED NO-LABEL
     fi_polto AT ROW 2.76 COL 37 COLON-ALIGNED NO-LABEL
     bu_ok AT ROW 1.86 COL 57.5
     fi_search AT ROW 7.71 COL 15.83 NO-LABEL
     bu_sch AT ROW 6.14 COL 57.17
     bu_exit AT ROW 22.91 COL 23
     br_tlt AT ROW 1 COL 68.17
     fi_searchcom AT ROW 6.62 COL 15.83 NO-LABEL
     fi_policy72 AT ROW 10.52 COL 17.17 COLON-ALIGNED NO-LABEL
     fi_polname AT ROW 11.62 COL 17.17 COLON-ALIGNED NO-LABEL
     fi_chassisno AT ROW 12.71 COL 17.17 COLON-ALIGNED NO-LABEL
     fi_vehregno AT ROW 13.81 COL 17.17 COLON-ALIGNED NO-LABEL
     bu_del AT ROW 15.19 COL 44.67
     btnFirst AT ROW 10 COL 43.17
     btnPrev AT ROW 10 COL 48.83
     btnNext AT ROW 10 COL 54.5
     btnLast AT ROW 10 COL 60.83
     fi_releaseno AT ROW 14.91 COL 17.17 COLON-ALIGNED NO-LABEL
     bu_ca AT ROW 13.1 COL 57 WIDGET-ID 2
     "To :" VIEW-AS TEXT
          SIZE 4.5 BY 1 AT ROW 1.57 COL 34.33
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "Search  By :" VIEW-AS TEXT
          SIZE 12.5 BY 1 AT ROW 5.57 COL 2.83
          BGCOLOR 5 FONT 6
     "Policy no70" VIEW-AS TEXT
          SIZE 12 BY 1 AT ROW 9.48 COL 6.67
          BGCOLOR 18 FONT 6
     "Policy no72" VIEW-AS TEXT
          SIZE 12 BY 1 AT ROW 10.57 COL 6.67
          BGCOLOR 18 FONT 6
     "Search .." VIEW-AS TEXT
          SIZE 12.5 BY 1 AT ROW 7.76 COL 2.83
          BGCOLOR 3 FONT 6
     "Insurname" VIEW-AS TEXT
          SIZE 12 BY 1 AT ROW 11.67 COL 6.67
          BGCOLOR 18 FONT 6
     "Chassis" VIEW-AS TEXT
          SIZE 12 BY 1 AT ROW 12.76 COL 6.67
          BGCOLOR 18 FONT 6
     "Vehreg" VIEW-AS TEXT
          SIZE 12 BY 1 AT ROW 13.86 COL 6.67
          BGCOLOR 18 FONT 6
     "Release" VIEW-AS TEXT
          SIZE 12 BY 1 AT ROW 14.95 COL 6.67
          BGCOLOR 18 FONT 6
     "Transdate From :" VIEW-AS TEXT
          SIZE 15.83 BY 1 AT ROW 1.57 COL 2.67
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "To :" VIEW-AS TEXT
          SIZE 4.5 BY 1 AT ROW 2.76 COL 34.33
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "By Company:" VIEW-AS TEXT
          SIZE 12.5 BY 1 AT ROW 6.67 COL 2.83
          BGCOLOR 5 FONT 6
     "Policy From :" VIEW-AS TEXT
          SIZE 16 BY 1.05 AT ROW 2.76 COL 2.5
          BGCOLOR 18 FGCOLOR 1 FONT 6
     RECT-332 AT ROW 1 COL 1
     RECT-333 AT ROW 1.29 COL 56.33
     RECT-340 AT ROW 1.29 COL 1.67
     RECT-494 AT ROW 5.05 COL 1
     RECT-495 AT ROW 12.62 COL 43.17
     RECT-21 AT ROW 9.48 COL 41.83
     RECT-496 AT ROW 5.29 COL 1.67
     RECT-497 AT ROW 5.76 COL 56
     RECT-499 AT ROW 22.43 COL 21.5
     RECT-500 AT ROW 14.76 COL 43.17
     RECT-498 AT ROW 12.67 COL 55.83 WIDGET-ID 4
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 24
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
         TITLE              = "Query && Update [DATA BY Phone..]"
         HEIGHT             = 24
         WIDTH              = 132.83
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
/* BROWSE-TAB br_tlt bu_exit fr_main */
/* SETTINGS FOR COMBO-BOX cb_search IN FRAME fr_main
   ALIGN-L                                                              */
/* SETTINGS FOR FILL-IN fi_chassisno IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_policy70 IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_policy72 IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_polname IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_releaseno IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_search IN FRAME fr_main
   ALIGN-L                                                              */
/* SETTINGS FOR FILL-IN fi_searchcom IN FRAME fr_main
   ALIGN-L                                                              */
/* SETTINGS FOR FILL-IN fi_vehregno IN FRAME fr_main
   NO-ENABLE                                                            */
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
"tlt.releas" ? "x(10)" "character" ? ? ? ? ? ? no ? no no "6" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[2]   > brstat.tlt.nor_noti_tlt
"tlt.nor_noti_tlt" ? ? "character" ? ? ? ? ? ? no ? no no "17" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   > brstat.tlt.lotno
"tlt.lotno" "Company" "x(15)" "character" ? ? ? ? ? ? no ? no no "9" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   > brstat.tlt.lince1
"tlt.lince1" "ทะเบียน" "x(30)" "character" ? ? ? ? ? ? no ? no no "11.83" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   = brstat.tlt.policy
     _FldNameList[6]   > brstat.tlt.ins_name
"tlt.ins_name" ? ? "character" ? ? ? ? ? ? no ? no no "18.33" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[7]   > brstat.tlt.nor_effdat
"tlt.nor_effdat" "Comdate." ? "date" ? ? ? ? ? ? no ? no no "10.83" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[8]   > brstat.tlt.expodat
"tlt.expodat" "Expydate." "99/99/9999" "date" ? ? ? ? ? ? no ? no no "10.33" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[9]   > brstat.tlt.cha_no
"tlt.cha_no" ? ? "character" ? ? ? ? ? ? no ? no no "18.83" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[10]   > brstat.tlt.nor_usr_ins
"tlt.nor_usr_ins" ? ? "character" ? ? ? ? ? ? no ? no no "23.83" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[11]   = brstat.tlt.expousr
     _FldNameList[12]   > brstat.tlt.comp_pol
"tlt.comp_pol" ? "x(16)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _Query            is NOT OPENED
*/  /* BROWSE br_tlt */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME c-wins
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c-wins c-wins
ON END-ERROR OF c-wins /* Query  Update [DATA BY Phone..] */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c-wins c-wins
ON WINDOW-CLOSE OF c-wins /* Query  Update [DATA BY Phone..] */
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
    RUN pdDisptlt.

    {&WINDOW-NAME}:hidden  =  Yes. 
    /*Run  wgw\wgwqupo2(Input  nv_recidtlt).*/   /*A62-0219*/
    Run  wgw\wgwqupo21(Input  nv_recidtlt).      /*A62-0219*/
    RUN pdDisptlt .
    {&WINDOW-NAME}:hidden  =  No.                                               

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_tlt c-wins
ON MOUSE-SELECT-CLICK OF br_tlt IN FRAME fr_main
DO:
    GET CURRENT br_tlt.
    RUN pdDisptlt  IN THIS-PROCEDURE. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_tlt c-wins
ON VALUE-CHANGED OF br_tlt IN FRAME fr_main
DO:
     Get  current  br_tlt.
     nv_rectlt =  recid(tlt).
     RUN pdDisptlt.
     /*fi_name   =  tlt.ins_name.
     disp  fi_name  with frame  fr_main.*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnFirst
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnFirst c-wins
ON CHOOSE OF btnFirst IN FRAME fr_main /* << */
DO:
  GET FIRST br_tlt.
  IF NOT AVAIL tlt THEN RETURN NO-APPLY.  
  REPOSITION br_tlt TO ROWID ROWID (tlt).
  APPLY "VALUE-CHANGED" TO br_tlt IN FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnLast
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnLast c-wins
ON CHOOSE OF btnLast IN FRAME fr_main /* >> */
DO:
  GET LAST br_tlt.
  IF NOT AVAIL tlt THEN RETURN NO-APPLY.
  REPOSITION br_tlt TO ROWID ROWID (tlt).
  APPLY "VALUE-CHANGED" TO br_tlt IN FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnNext
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnNext c-wins
ON CHOOSE OF btnNext IN FRAME fr_main /* > */
DO:
  GET NEXT br_tlt.
  IF NOT AVAIL tlt THEN RETURN NO-APPLY.
  REPOSITION br_tlt TO ROWID ROWID (tlt).
  APPLY "VALUE-CHANGED" TO br_tlt IN FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnPrev
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnPrev c-wins
ON CHOOSE OF btnPrev IN FRAME fr_main /* < */
DO:
  GET PREV br_tlt.
  IF NOT AVAIL tlt THEN RETURN NO-APPLY.
  REPOSITION br_tlt TO ROWID ROWID (tlt).
  APPLY "VALUE-CHANGED" TO br_tlt IN FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_ca
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_ca c-wins
ON CHOOSE OF bu_ca IN FRAME fr_main /* UP_CA */
DO:
  ASSIGN
        FRAME fr_main fi_releaseno .

  RUN ProcUpdatetlt_CA.
  RUN pdDisptlt.

  
     
  /*Open Query br_tlt 
        For each tlt Use-index  tlt01  Where
        tlt.trndat  >=   fi_trndatfr   And
        tlt.trndat  <=   fi_trndatto   And
        tlt.policy   = fi_policy70     AND
        tlt.genusr   =  "phone"        no-lock. 
            
            RUN pdDisptlt.

            Apply "Entry"  to br_tlt.
            Return no-apply.  */
  
  /*APPLY "VALUE-CHANGED" TO br_tlt IN FRAME fr_main.*/

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_del
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_del c-wins
ON CHOOSE OF bu_del IN FRAME fr_main /* DELETE */
DO:
    DEF VAR logAns AS LOGI INIT No.  
    logAns = No.
    MESSAGE "ต้องการลบข้อมูลรายการ " + TRIM (tlt.policy)  /*+ " " + 
        TRIM (tlt.Fname) + " " + TRIM (tlt.LName) + " ?" */  
        UPDATE logAns 
        VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO
        TITLE "ลบข้อมูลชื่อดีเลอร์นี้".   
    IF logAns THEN DO:  
        GET CURRENT br_tlt EXCLUSIVE-LOCK.
        DELETE tlt. 
        MESSAGE "ลบข้อมูลดีเลอร์เรียบร้อย ..." VIEW-AS ALERT-BOX INFORMATION.  
    END.  
    /*RUN PdUpdateQ.*/
    RUN Pro_openQuery.
    APPLY "VALUE-CHANGED" TO br_tlt IN FRAM fr_main. 
    /*RUN ProcDisable IN THIS-PROCEDURE.*/
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
    Open Query br_tlt 
        For each tlt Use-index  tlt01  Where
        tlt.trndat  >=   fi_trndatfr   And
        tlt.trndat  <=   fi_trndatto   And
/*      tlt.policy  >=   fi_polfr     And */
/*      tlt.policy  <=   fi_polto     And */
        /*tlt.comp_sub  =  fi_producer  And*/
        tlt.genusr   =  "phone"        no-lock. 
            nv_rectlt =  recid(tlt).
            RUN pdDisptlt.

            Apply "Entry"  to br_tlt.
            Return no-apply.                             
            
    

    
  END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_reles
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_reles c-wins
ON CHOOSE OF bu_reles IN FRAME fr_main /* UP_REL */
DO:
  ASSIGN
        FRAME fr_main fi_releaseno .

  RUN ProcUpdatetlt.
  RUN pdDisptlt.

  
     
  /*Open Query br_tlt 
        For each tlt Use-index  tlt01  Where
        tlt.trndat  >=   fi_trndatfr   And
        tlt.trndat  <=   fi_trndatto   And
        tlt.policy   = fi_policy70     AND
        tlt.genusr   =  "phone"        no-lock. 
            
            RUN pdDisptlt.

            Apply "Entry"  to br_tlt.
            Return no-apply.  */
  
  /*APPLY "VALUE-CHANGED" TO br_tlt IN FRAME fr_main.*/

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_sch
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_sch c-wins
ON CHOOSE OF bu_sch IN FRAME fr_main /* Search */
DO:
    /*If  cb_search =  1  Then do:               /* name  */
        Open Query br_tlt                      
            For each tlt Use-index  tlt01      Where
            tlt.trndat         >=  fi_trndatfr And
            tlt.trndat         <=  fi_trndatto And
            tlt.genusr          =  "phone"     And
            index(tlt.ins_name,fi_search) <> 0 no-lock.
                Apply "Entry"  to br_tlt.
                Return no-apply.            
    END.
    ELSE If  cb_search  =  2  Then do:         /* policy */
        Open Query br_tlt                      
            For each tlt Use-index  tlt01      Where
            tlt.trndat        >=  fi_trndatfr  And 
            tlt.trndat        <=  fi_trndatto  And 
            tlt.genusr         =  "phone"      And 
            tlt.policy         = fi_search     no-lock.
                Apply "Entry"  to br_tlt.      
                Return no-apply.               
    END.                                       
    ELSE If  cb_search  =  3  Then do:         /* company  */
        Open Query br_tlt                      
            For each tlt Use-index  tlt06      Where
            tlt.trndat         >=  fi_trndatfr And
            tlt.trndat         <=  fi_trndatto And
            tlt.genusr          =  "phone"     And
            tlt.lotno           =  fi_search   no-lock.
                Apply "Entry"  to  br_tlt.     
                Return no-apply.               
    END.                                       
    ELSE If  cb_search  =  4  Then do:         /* chassis...*/
        Open Query br_tlt                      
            For each tlt Use-index  tlt01      Where
            tlt.trndat         >=  fi_trndatfr And
            tlt.trndat         <=  fi_trndatto And
            tlt.genusr          =  "phone"     And
            tlt.cha_no          =  trim(fi_search) no-lock.
                Apply "Entry"  to br_tlt.  
                Return no-apply.           
    END.                                   
    ELSE If  cb_search  =  5  Then do:         /* complete..*/
        Open Query br_tlt                      
            For each tlt Use-index  tlt01      Where
            tlt.trndat         >=  fi_trndatfr And
            tlt.trndat         <=  fi_trndatto And
            tlt.genusr          =  "phone"     And
            INDEX(tlt.OLD_eng,"not") = 0       no-lock.
                Apply "Entry"  to br_tlt.      
                Return no-apply.               
    END.                                       
    ELSE If  cb_search  =  6  Then do:         /* not ..complete... */
        Open Query br_tlt                      
            For each tlt Use-index  tlt01      Where
            tlt.trndat         >=  fi_trndatfr And
            tlt.trndat         <=  fi_trndatto And
            tlt.genusr          =  "phone"     And
            INDEX(tlt.OLD_eng,"not")  <> 0     no-lock.
                Apply "Entry"  to br_tlt.
                Return no-apply.                             
    END.  
    ELSE If  cb_search  =  7  Then do:         /* not ..complete... */
        Open Query br_tlt                      
            For each tlt Use-index  tlt01      Where
            tlt.trndat         >=  fi_trndatfr And
            tlt.trndat         <=  fi_trndatto And
            tlt.genusr          =  "phone"     And
            tlt.releas          =  "Yes"       no-lock.
                Apply "Entry"  to br_tlt.
                Return no-apply.                             
    END.
    ELSE If  cb_search  =  8  Then do:         /* not ..complete... */
        Open Query br_tlt                      
            For each tlt Use-index  tlt01      Where
            tlt.trndat         >=  fi_trndatfr And
            tlt.trndat         <=  fi_trndatto And
            tlt.genusr          =  "phone"     And
            tlt.releas          =  "No"       no-lock.
                Apply "Entry"  to br_tlt.
                Return no-apply.                             
    END.
    Else DO:
        Apply "Entry"  to  fi_search.
        Return no-apply.
    END.*/
    IF fi_searchcom  = "" THEN DO:
        If  cb_search =  "ชื่อลูกค้า"  Then do:               /* name  */
            Open Query br_tlt                      
                For each tlt Use-index  tlt01      Where
                tlt.trndat         >=  fi_trndatfr And
                tlt.trndat         <=  fi_trndatto And
                tlt.genusr          =  "phone"     And
                index(tlt.ins_name,fi_search) <> 0 no-lock.
                    Apply "Entry"  to br_tlt.
                    Return no-apply.            
        END.
        ELSE If  cb_search  =  "Policy "  Then do:         /* policy */
            Open Query br_tlt                      
                For each tlt Use-index  tlt01      Where
                tlt.trndat        >=  fi_trndatfr  And 
                tlt.trndat        <=  fi_trndatto  And 
                tlt.genusr         =  "phone"      And 
                tlt.policy         = fi_search     no-lock.
                    RUN pdDisptlt2.
                    Apply "Entry"  to br_tlt.      
                    Return no-apply.               
        END. 
        ELSE If  cb_search  =  "สาขา"  Then do:             /* สาขา  */ 
        Open Query br_tlt                               
            For each tlt Use-index  tlt01      Where    
            tlt.trndat        >=  fi_trndatfr  And      
            tlt.trndat        <=  fi_trndatto  And      
            tlt.genusr         =  "phone"      And      
            tlt.colorcod          = fi_search     no-lock.    
                Apply "Entry"  to br_tlt.               
                Return no-apply.                        
    END.                                                
    ELSE If  cb_search  =  "ทะเบียนรถ"  Then do:        /* + "ทะเบียนรถ"  */ 

        Open Query br_tlt                               
            For each tlt Use-index  tlt01      Where    
            tlt.trndat        >=  fi_trndatfr  And      
            tlt.trndat        <=  fi_trndatto  And      
            tlt.genusr         =  "phone"      And      
            index(tlt.lince1,trim(fi_search)) <> 0     no-lock.
                Apply "Entry"  to br_tlt.               
                Return no-apply.                        
    END.                              
        ELSE If  cb_search  =  "company"  Then do:         /* company  */
            Open Query br_tlt                      
                For each tlt Use-index  tlt06      Where
                tlt.trndat         >=  fi_trndatfr And
                tlt.trndat         <=  fi_trndatto And
                tlt.genusr          =  "phone"     And
                tlt.lotno           =  fi_searchcom  no-lock.
                    Apply "Entry"  to  br_tlt.     
                    Return no-apply.               
        END.
        ELSE If  cb_search  =  "Chassis"  Then do:         /* chassis...*/
            Open Query br_tlt                      
                For each tlt Use-index  tlt01      Where
                tlt.trndat         >=  fi_trndatfr And
                tlt.trndat         <=  fi_trndatto And
                tlt.genusr          =  "phone"     And
                tlt.cha_no          =  trim(fi_search) no-lock.
                    Apply "Entry"  to br_tlt.  
                    Return no-apply.           
        END.  
        ELSE If  cb_search  =  "Complete"  Then do:         /* complete..*/
            Open Query br_tlt                      
                For each tlt Use-index  tlt01      Where
                tlt.trndat         >=  fi_trndatfr And
                tlt.trndat         <=  fi_trndatto And
                tlt.genusr          =  "phone"     And
                INDEX(tlt.OLD_eng,"not") = 0       no-lock.
                    Apply "Entry"  to br_tlt.      
                    Return no-apply.               
        END.                                       
        ELSE If  cb_search  =  "Not complete"  Then do:         /* not ..complete... */
            Open Query br_tlt                      
                For each tlt Use-index  tlt01      Where
                tlt.trndat         >=  fi_trndatfr And
                tlt.trndat         <=  fi_trndatto And
                tlt.genusr          =  "phone"     And
                INDEX(tlt.OLD_eng,"not")  <> 0     no-lock.
                    Apply "Entry"  to br_tlt.
                    Return no-apply.                             
        END.  
        ELSE If  cb_search  =  "Release Yes" Then do:         /* not ..complete... */
        Open Query br_tlt                      
            For each tlt Use-index  tlt01      Where
            tlt.trndat         >=  fi_trndatfr And
            tlt.trndat         <=  fi_trndatto And
            tlt.genusr          =  "phone"     And
            tlt.releas          =  "Yes"       no-lock.
                Apply "Entry"  to br_tlt.
                Return no-apply.                             
    END.
    ELSE If  cb_search  =  "Release No"  Then do:         /* not ..complete... */
        Open Query br_tlt                      
            For each tlt Use-index  tlt01      Where
            tlt.trndat         >=  fi_trndatfr And
            tlt.trndat         <=  fi_trndatto And
            tlt.genusr          =  "phone"     And
            tlt.releas          =  "No"       no-lock.
                Apply "Entry"  to br_tlt.
                Return no-apply.                             
    END.                          
    Else DO:
        Apply "Entry"  to  fi_search.
        Return no-apply.
    END.
    END.
    ELSE DO:
          If  cb_search =  "ชื่อลูกค้า"  Then do:               /* name  */
              Open Query br_tlt                      
                  For each tlt Use-index  tlt01       Where
                  tlt.trndat         >=  fi_trndatfr  And
                  tlt.trndat         <=  fi_trndatto  And
                  tlt.genusr          =  "phone"      And
                  tlt.lotno           =  fi_searchcom AND  
                  index(tlt.ins_name,fi_search) <> 0 no-lock.
                      Apply "Entry"  to br_tlt.
                      Return no-apply.            
          END.
          ELSE If  cb_search  =  "Policy "  Then do:         /* policy */
              Open Query br_tlt                      
                  For each tlt Use-index  tlt01       Where
                  tlt.trndat        >=  fi_trndatfr   And 
                  tlt.trndat        <=  fi_trndatto   And 
                  tlt.genusr         =  "phone"       And 
                  tlt.lotno           =  fi_searchcom AND  
                  tlt.policy         = fi_search      no-lock.
                      RUN pdDisptlt2.
                      Apply "Entry"  to br_tlt.      
                      Return no-apply.               
          END.                                       
          ELSE If  cb_search  =  "company"  Then do:         /* company  */
              Open Query br_tlt                      
                  For each tlt Use-index  tlt06      Where
                  tlt.trndat         >=  fi_trndatfr And
                  tlt.trndat         <=  fi_trndatto And
                  tlt.genusr          =  "phone"     And
                  tlt.lotno           =  fi_searchcom   no-lock.
                      Apply "Entry"  to  br_tlt.     
                      Return no-apply.               
          END.
          ELSE If  cb_search  =  "Chassis"  Then do:         /* chassis...*/
              Open Query br_tlt                      
                  For each tlt Use-index  tlt01       Where
                  tlt.trndat         >=  fi_trndatfr  And
                  tlt.trndat         <=  fi_trndatto  And
                  tlt.genusr          =  "phone"      And
                  tlt.lotno           =  fi_searchcom AND  
                  tlt.cha_no          =  trim(fi_search) no-lock.
                      Apply "Entry"  to br_tlt.  
                      Return no-apply.           
          END.
          ELSE If  cb_search  =  "Complete"  Then do:         /* complete..*/
              Open Query br_tlt                      
                  For each tlt Use-index  tlt01       Where
                  tlt.trndat         >=  fi_trndatfr  And
                  tlt.trndat         <=  fi_trndatto  And
                  tlt.genusr          =  "phone"      And
                  tlt.lotno           =  fi_searchcom AND  
                  INDEX(tlt.OLD_eng,"not") = 0       no-lock.
                      Apply "Entry"  to br_tlt.      
                      Return no-apply.               
          END.
          ELSE If  cb_search  =  "Not complete"  Then do:         /* not ..complete... */
              Open Query br_tlt                      
                  For each tlt Use-index  tlt01       Where
                  tlt.trndat         >=  fi_trndatfr  And
                  tlt.trndat         <=  fi_trndatto  And
                  tlt.genusr          =  "phone"      And
                  tlt.lotno           =  fi_searchcom AND  
                  INDEX(tlt.OLD_eng,"not")  <> 0     no-lock.
                      Apply "Entry"  to br_tlt.
                      Return no-apply.                             
          END.
          ELSE If  cb_search  =  "Release Yes" Then do:         /* not ..complete... */
              Open Query br_tlt                      
                  For each tlt Use-index  tlt01       Where
                  tlt.trndat         >=  fi_trndatfr  And
                  tlt.trndat         <=  fi_trndatto  And
                  tlt.genusr          =  "phone"      And
                  tlt.lotno           =  fi_searchcom AND  
                  tlt.releas          =  "Yes"       no-lock.
                      Apply "Entry"  to br_tlt.
                      Return no-apply.                             
          END.
          ELSE If  cb_search  =  "Release No"  Then do:         /* not ..complete... */
              Open Query br_tlt                      
                  For each tlt Use-index  tlt01       Where
                  tlt.trndat         >=  fi_trndatfr  And
                  tlt.trndat         <=  fi_trndatto  And
                  tlt.genusr          =  "phone"      And
                  tlt.lotno           =  fi_searchcom AND 
                  tlt.releas          =  "No"       no-lock.
                      Apply "Entry"  to br_tlt.
                      Return no-apply.                             
          END.                          
          Else DO:
              Apply "Entry"  to  fi_search.
              Return no-apply.
          END.
          
          END.
          RUN pdDisptlt.
           
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


&Scoped-define SELF-NAME fi_chassisno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_chassisno c-wins
ON LEAVE OF fi_chassisno IN FRAME fr_main
DO:
  fi_chassisno = INPUT fi_chassisno.
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


&Scoped-define SELF-NAME fi_policy70
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_policy70 c-wins
ON LEAVE OF fi_policy70 IN FRAME fr_main
DO:
  fi_policy70 = INPUT fi_policy70.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_policy72
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_policy72 c-wins
ON LEAVE OF fi_policy72 IN FRAME fr_main
DO:
  fi_policy72 = INPUT fi_policy72.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_polname
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_polname c-wins
ON LEAVE OF fi_polname IN FRAME fr_main
DO:
  fi_polname = INPUT fi_polname.
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


&Scoped-define SELF-NAME fi_releaseno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_releaseno c-wins
ON LEAVE OF fi_releaseno IN FRAME fr_main
DO:
  fi_releaseno = INPUT fi_releaseno.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_search
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_search c-wins
ON LEAVE OF fi_search IN FRAME fr_main
DO:
    fi_search     =  Input  fi_search.
    Disp fi_search  with frame fr_main.
    /**
    If  ra_choice =  1  Then do:               /* name  */
        Open Query br_tlt                      
            For each tlt Use-index  tlt01      Where
            tlt.trndat         >=  fi_trndatfr And
            tlt.trndat         <=  fi_trndatto And
            tlt.genusr          =  "phone"     And
            index(tlt.ins_name,fi_search) <> 0 no-lock.
                Apply "Entry"  to br_tlt.
                Return no-apply.            
    END.
    ELSE If  ra_choice  =  2  Then do:         /* policy */
        Open Query br_tlt                      
            For each tlt Use-index  tlt01      Where
            tlt.trndat        >=  fi_trndatfr  And 
            tlt.trndat        <=  fi_trndatto  And 
            tlt.genusr         =  "phone"      And 
            tlt.policy         = fi_search     no-lock.
                Apply "Entry"  to br_tlt.      
                Return no-apply.               
    END.                                       
    ELSE If  ra_choice  =  3  Then do:         /* company  */
        Open Query br_tlt                      
            For each tlt Use-index  tlt06      Where
            tlt.trndat         >=  fi_trndatfr And
            tlt.trndat         <=  fi_trndatto And
            tlt.genusr          =  "phone"     And
            tlt.lotno           =  fi_search   no-lock.
                Apply "Entry"  to  br_tlt.     
                Return no-apply.               
    END.                                       
    ELSE If  ra_choice  =  4  Then do:         /* chassis...*/
        Open Query br_tlt                      
            For each tlt Use-index  tlt01      Where
            tlt.trndat         >=  fi_trndatfr And
            tlt.trndat         <=  fi_trndatto And
            tlt.genusr          =  "phone"     And
            tlt.cha_no          =  trim(fi_search) no-lock.
                Apply "Entry"  to br_tlt.  
                Return no-apply.           
    END.                                   
    ELSE If  ra_choice  =  5  Then do:         /* complete..*/
        Open Query br_tlt                      
            For each tlt Use-index  tlt01      Where
            tlt.trndat         >=  fi_trndatfr And
            tlt.trndat         <=  fi_trndatto And
            tlt.genusr          =  "phone"     And
            INDEX(tlt.OLD_eng,"not") = 0       no-lock.
                Apply "Entry"  to br_tlt.      
                Return no-apply.               
    END.                                       
    ELSE If  ra_choice  =  6  Then do:         /* not ..complete... */
        Open Query br_tlt                      
            For each tlt Use-index  tlt01      Where
            tlt.trndat         >=  fi_trndatfr And
            tlt.trndat         <=  fi_trndatto And
            tlt.genusr          =  "phone"     And
            INDEX(tlt.OLD_eng,"not")  <> 0     no-lock.
                Apply "Entry"  to br_tlt.
                Return no-apply.                             
    END. 
    ELSE If  ra_choice  =  7  Then do:         /* not ..complete... */
        Open Query br_tlt                      
            For each tlt Use-index  tlt01      Where
            tlt.trndat         >=  fi_trndatfr And
            tlt.trndat         <=  fi_trndatto And
            tlt.genusr          =  "phone"     And
            tlt.releas          =  "Yes"       no-lock.
                Apply "Entry"  to br_tlt.
                Return no-apply.                             
    END.
    ELSE If  ra_choice  =  8  Then do:         /* not ..complete... */
        Open Query br_tlt                      
            For each tlt Use-index  tlt01      Where
            tlt.trndat         >=  fi_trndatfr And
            tlt.trndat         <=  fi_trndatto And
            tlt.genusr          =  "phone"     And
            tlt.releas          =  "No"       no-lock.
                Apply "Entry"  to br_tlt.
                Return no-apply.                             
    END.
    Else DO:
        Apply "Entry"  to  fi_search.
        Return no-apply.
    END.*/
    IF fi_searchcom  = "" THEN DO:
           If  cb_search =  "ชื่อลูกค้า"  Then do:         /* name  */
        Open Query br_tlt                                  
            For each tlt Use-index  tlt01      Where       
            tlt.trndat         >=  fi_trndatfr And         
            tlt.trndat         <=  fi_trndatto And         
            tlt.genusr          =  "phone"     And         
            index(tlt.ins_name,fi_search) <> 0 no-lock.    
                RUN pdDisptlt.                             
                Apply "Entry"  to br_tlt.                  
                Return no-apply.                           
    END.                                                   
    ELSE If  cb_search  =  "Policy "  Then do:             /* policy */ 
                                    
        Open Query br_tlt                                  
            For each tlt Use-index  tlt01      Where       
            tlt.trndat        >=  fi_trndatfr  And         
            tlt.trndat        <=  fi_trndatto  And         
            tlt.genusr         =  "phone"      And         
            tlt.policy         = fi_search     no-lock.    
                Apply "Entry"  to br_tlt.                  
                Return no-apply.                           
    END.                                                   
    ELSE If  cb_search  =  "สาขา"  Then do:             /* สาขา  */ 
        Open Query br_tlt                               
            For each tlt Use-index  tlt01      Where    
            tlt.trndat        >=  fi_trndatfr  And      
            tlt.trndat        <=  fi_trndatto  And      
            tlt.genusr         =  "phone"      And      
            tlt.colorcod          = fi_search     no-lock.    
                Apply "Entry"  to br_tlt.               
                Return no-apply.                        
    END.                                                
    ELSE If  cb_search  =  "ทะเบียนรถ"  Then do:        /* + "ทะเบียนรถ"  */ 

        Open Query br_tlt                               
            For each tlt Use-index  tlt01      Where    
            tlt.trndat        >=  fi_trndatfr  And      
            tlt.trndat        <=  fi_trndatto  And      
            tlt.genusr         =  "phone"      And      
            index(tlt.lince1,trim(fi_search)) <> 0     no-lock.
                Apply "Entry"  to br_tlt.               
                Return no-apply.                        
    END.                                                
    ELSE If  cb_search  =  "company"  Then do:          /* company  */
        Open Query br_tlt                      
            For each tlt Use-index  tlt06      Where
            tlt.trndat         >=  fi_trndatfr And
            tlt.trndat         <=  fi_trndatto And
            tlt.genusr          =  "phone"     And
            tlt.lotno           =  fi_searchcom   no-lock.
                Apply "Entry"  to  br_tlt.     
                Return no-apply.               
    END.                                       
    ELSE If  cb_search  =  "Chassis"  Then do:         /* chassis...*/
        Open Query br_tlt                      
            For each tlt Use-index  tlt01      Where
            tlt.trndat         >=  fi_trndatfr And
            tlt.trndat         <=  fi_trndatto And
            tlt.genusr          =  "phone"     And
            tlt.cha_no          =  trim(fi_search) no-lock.
                Apply "Entry"  to br_tlt.  
                Return no-apply.           
    END.                                   
    ELSE If  cb_search  =  "Complete"  Then do:         /* complete..*/
        Open Query br_tlt                      
            For each tlt Use-index  tlt01      Where
            tlt.trndat         >=  fi_trndatfr And
            tlt.trndat         <=  fi_trndatto And
            tlt.genusr          =  "phone"     And
            INDEX(tlt.OLD_eng,"not") = 0       no-lock.
                Apply "Entry"  to br_tlt.      
                Return no-apply.               
    END.                                       
    ELSE If  cb_search  =  "Not complete"  Then do:         /* not ..complete... */
        Open Query br_tlt                      
            For each tlt Use-index  tlt01      Where
            tlt.trndat         >=  fi_trndatfr And
            tlt.trndat         <=  fi_trndatto And
            tlt.genusr          =  "phone"     And
            INDEX(tlt.OLD_eng,"not")  <> 0     no-lock.
                Apply "Entry"  to br_tlt.
                Return no-apply.                             
    END.  
    ELSE If  cb_search  =  "Release Yes" Then do:         /* not ..complete... */
        Open Query br_tlt                      
            For each tlt Use-index  tlt01      Where
            tlt.trndat         >=  fi_trndatfr And
            tlt.trndat         <=  fi_trndatto And
            tlt.genusr          =  "phone"     And
            tlt.releas          =  "Yes"       no-lock.
                Apply "Entry"  to br_tlt.
                Return no-apply.                             
    END.
    ELSE If  cb_search  =  "Release No"  Then do:         /* not ..complete... */
        Open Query br_tlt                      
            For each tlt Use-index  tlt01      Where
            tlt.trndat         >=  fi_trndatfr And
            tlt.trndat         <=  fi_trndatto And
            tlt.genusr          =  "phone"     And
            tlt.releas          =  "No"       no-lock.
                Apply "Entry"  to br_tlt.
                Return no-apply.                             
    END.                          
    Else DO:
        Apply "Entry"  to  fi_search.
        Return no-apply.
    END.
    END.
    ELSE DO:
          If  cb_search =  "ชื่อลูกค้า"  Then do:               /* name  */
              Open Query br_tlt                      
                  For each tlt Use-index  tlt01       Where
                  tlt.trndat         >=  fi_trndatfr  And
                  tlt.trndat         <=  fi_trndatto  And
                  tlt.genusr          =  "phone"      And
                  tlt.lotno           =  fi_searchcom AND  
                  index(tlt.ins_name,fi_search) <> 0 no-lock.
                      Apply "Entry"  to br_tlt.
                      Return no-apply.            
          END.
          ELSE If  cb_search  =  "Policy "  Then do:         /* policy */
              Open Query br_tlt                      
                  For each tlt Use-index  tlt01       Where
                  tlt.trndat        >=  fi_trndatfr   And 
                  tlt.trndat        <=  fi_trndatto   And 
                  tlt.genusr         =  "phone"       And 
                  tlt.lotno           =  fi_searchcom AND  
                  tlt.policy         = fi_search      no-lock.
                      Apply "Entry"  to br_tlt.      
                      Return no-apply.               
          END.                                       
          ELSE If  cb_search  =  "company"  Then do:         /* company  */
              Open Query br_tlt                      
                  For each tlt Use-index  tlt06      Where
                  tlt.trndat         >=  fi_trndatfr And
                  tlt.trndat         <=  fi_trndatto And
                  tlt.genusr          =  "phone"     And
                  tlt.lotno           =  fi_searchcom   no-lock.
                      Apply "Entry"  to  br_tlt.     
                      Return no-apply.               
          END.
          ELSE If  cb_search  =  "Chassis"  Then do:         /* chassis...*/
              Open Query br_tlt                      
                  For each tlt Use-index  tlt01       Where
                  tlt.trndat         >=  fi_trndatfr  And
                  tlt.trndat         <=  fi_trndatto  And
                  tlt.genusr          =  "phone"      And
                  tlt.lotno           =  fi_searchcom AND  
                  tlt.cha_no          =  trim(fi_search) no-lock.
                      Apply "Entry"  to br_tlt.  
                      Return no-apply.           
          END.
          ELSE If  cb_search  =  "Complete"  Then do:         /* complete..*/
              Open Query br_tlt                      
                  For each tlt Use-index  tlt01       Where
                  tlt.trndat         >=  fi_trndatfr  And
                  tlt.trndat         <=  fi_trndatto  And
                  tlt.genusr          =  "phone"      And
                  tlt.lotno           =  fi_searchcom AND  
                  INDEX(tlt.OLD_eng,"not") = 0       no-lock.
                      Apply "Entry"  to br_tlt.      
                      Return no-apply.               
          END.
          ELSE If  cb_search  =  "Not complete"  Then do:         /* not ..complete... */
              Open Query br_tlt                      
                  For each tlt Use-index  tlt01       Where
                  tlt.trndat         >=  fi_trndatfr  And
                  tlt.trndat         <=  fi_trndatto  And
                  tlt.genusr          =  "phone"      And
                  tlt.lotno           =  fi_searchcom AND  
                  INDEX(tlt.OLD_eng,"not")  <> 0     no-lock.
                      Apply "Entry"  to br_tlt.
                      Return no-apply.                             
          END.
          ELSE If  cb_search  =  "Release Yes" Then do:         /* not ..complete... */
              Open Query br_tlt                      
                  For each tlt Use-index  tlt01       Where
                  tlt.trndat         >=  fi_trndatfr  And
                  tlt.trndat         <=  fi_trndatto  And
                  tlt.genusr          =  "phone"      And
                  tlt.lotno           =  fi_searchcom AND  
                  tlt.releas          =  "Yes"       no-lock.
                      Apply "Entry"  to br_tlt.
                      Return no-apply.                             
          END.
          ELSE If  cb_search  =  "Release No"  Then do:         /* not ..complete... */
              Open Query br_tlt                      
                  For each tlt Use-index  tlt01       Where
                  tlt.trndat         >=  fi_trndatfr  And
                  tlt.trndat         <=  fi_trndatto  And
                  tlt.genusr          =  "phone"      And
                  tlt.lotno           =  fi_searchcom AND 
                  tlt.releas          =  "No"       no-lock.
                      Apply "Entry"  to br_tlt.
                      Return no-apply.                             
          END.                          
          Else DO:
              Apply "Entry"  to  fi_search.
              Return no-apply.
          END.
           
          END.
          RUN pdDisptlt.
           
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_searchcom
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_searchcom c-wins
ON LEAVE OF fi_searchcom IN FRAME fr_main
DO:
    fi_searchcom     =  INPUT fi_searchcom.
    Disp fi_searchcom  with frame fr_main.
    
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


&Scoped-define SELF-NAME fi_vehregno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_vehregno c-wins
ON LEAVE OF fi_vehregno IN FRAME fr_main
DO:
  fi_vehregno = INPUT fi_vehregno.
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
    gv_prgid = "wgwqupo3".
    gv_prog  = "Update DATA Detail By PHONE...".
    RUN  WUT\WUTHEAD ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).
    ASSIGN 
        fi_trndatfr = TODAY
        fi_trndatto = TODAY
        /*ra_choice   =  1 */
        fi_polfr    = ""
        fi_polto    = ""  
        vAcProc_fil = vAcProc_fil   + "ชื่อลูกค้า" + "," 
                                    + "Policy " + "," 
                                    + "สาขา" + ","        /*A55-0257 */
                                    + "ทะเบียนรถ" + ","   /*A55-0257 */
                                    + "company" + "," 
                                    + "Chassis" + "," 
                                    + "Complete" + "," 
                                    + "Not complete" + "," 
                                    + "Release Yes" + "," 
                                    + "Release No" + "," 
                                    
        cb_search:LIST-ITEMS = vAcProc_fil
        cb_search = ENTRY(1,vAcProc_fil)
        fi_policy70   = "" 
        fi_policy72   = "" 
        fi_polname    = "" 
        fi_chassisno  = "" 
        fi_vehregno   = "" 
        fi_releaseno  = "" .
    
    Disp   cb_search fi_trndatfr  fi_trndatto  fi_polfr 
         fi_polto  with frame fr_main.
    /*********************************************************************/ 
    /*  RUN Wut\WutwiCen ({&WINDOW-NAME}:HANDLE). */ 
    /*CURRENT-WINDOW:WINDOW-STATE = WINDOW-MAXIMIZED.*/
    SESSION:DATA-ENTRY-RETURN = YES.
    
    Rect-333:Move-to-top().
    /*Rect-338:Move-to-top().  */
    /*RECT-346:Move-to-top(). */
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
  DISPLAY fi_policy70 cb_search fi_trndatfr fi_trndatto fi_polfr fi_polto 
          fi_search fi_searchcom fi_policy72 fi_polname fi_chassisno fi_vehregno 
          fi_releaseno 
      WITH FRAME fr_main IN WINDOW c-wins.
  ENABLE bu_reles cb_search fi_trndatfr fi_trndatto fi_polfr fi_polto bu_ok 
         fi_search bu_sch bu_exit br_tlt fi_searchcom bu_del btnFirst btnPrev 
         btnNext btnLast bu_ca RECT-332 RECT-333 RECT-340 RECT-494 RECT-495 
         RECT-21 RECT-496 RECT-497 RECT-499 RECT-500 RECT-498 
      WITH FRAME fr_main IN WINDOW c-wins.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW c-wins.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdDisptlt c-wins 
PROCEDURE pdDisptlt :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DISPLAY  
       tlt.policy   @ fi_policy70      
       tlt.comp_pol @ fi_policy72     
       tlt.ins_name @ fi_polname      
       tlt.cha_no   @ fi_chassisno    
       tlt.lince1   @ fi_vehregno     
       tlt.releas   @ fi_releaseno 
      WITH FRAME fr_main.
   
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdDisptlt2 c-wins 
PROCEDURE pdDisptlt2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*For each tlt Use-index  tlt01      Where
                tlt.trndat        >=  fi_trndatfr  And 
                tlt.trndat        <=  fi_trndatto  And 
                tlt.genusr         =  "phone"      And 
                tlt.policy         = fi_search     no-lock.*/

    ASSIGN 
           fi_policy70  = tlt.policy     
           fi_policy72  = tlt.comp_pol  
           fi_polname   = tlt.ins_name  
           fi_chassisno = tlt.cha_no    
           fi_vehregno  = tlt.lince1    
           fi_releaseno = tlt.releas  .
    DISP fi_policy70 
         fi_policy72 
         fi_polname  
         fi_chassisno
         fi_vehregno 
         fi_releaseno WITH FRAM fr_main.

         

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PdUpdateQ c-wins 
PROCEDURE PdUpdateQ :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
           
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE ProcDisable c-wins 
PROCEDURE ProcDisable :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE ProcUpdatetlt c-wins 
PROCEDURE ProcUpdatetlt :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
GET CURRENT br_tlt EXCLUSIVE-LOCK.

ASSIGN   
    FRAME fr_main   fi_releaseno 
    tlt.RELEAS = IF fi_releaseno = "yes" THEN  "no"
                 ELSE  "yes".
                       
    RUN Pro_openQuery.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE ProcUpdatetlt_CA c-wins 
PROCEDURE ProcUpdatetlt_CA :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
GET CURRENT br_tlt EXCLUSIVE-LOCK.

ASSIGN   
    FRAME fr_main   fi_releaseno .
    IF fi_releaseno = "yes" THEN ASSIGN tlt.RELEAS = "yes/ca".
    ELSE IF fi_releaseno = "no" THEN ASSIGN tlt.RELEAS = "no/ca".
    ELSE IF index(fi_releaseno,"ca") <> 0 THEN ASSIGN tlt.RELEAS = trim(REPLACE(fi_releaseno,"/ca","")).
    RUN Pro_openQuery.

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
    tlt.genusr   =  "phone"         .
    Get  current  br_tlt.
     nv_rectlt =  recid(tlt).

     RUN pdDisptlt.
        
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

