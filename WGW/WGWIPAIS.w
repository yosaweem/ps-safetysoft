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
  wgwipais.w :  Query & Export file IPA
  Create  by   :  Ranu i. [A60-0268]   On 16/06/2017
  Connect      :  brstat  
+++++++++++++++++++++++++++++++++++++++++++++++*/

 Def    var  nv_rectlt    as recid  init  0.
 Def    var  nv_recidtlt  as recid  init  0.
 DEFINE VAR  n_asdat      AS CHAR.
 DEFINE VAR  vAcProc_fil  AS CHAR.
 DEFINE VAR  n_asdat1     AS CHAR.
 DEFINE VAR  vAcProc_fil1 AS CHAR.
 DEF    VAR  nv_72Reciept AS CHAR INIT "" .
 DEFINE stream  ns2.
 DEF VAR nv_row AS INT INIT 0.  
/*------- create by A60-0118------------*/
DEFINE TEMP-TABLE wdetail NO-UNDO
     FIELD n_no         AS INT   INIT 0                  
     FIELD n_pol        AS CHAR FORMAT "X(12)"  INIT ""  
     FIELD n_repdat     AS char format "x(15)"  init "" 
     FIELD n_Trndat     AS char format "x(15)"  init ""   
     FIELD n_MY         AS CHAR FORMAT "X(15)"  INIT ""  
     FIELD n_title      AS CHAR FORMAT "X(25)"  INIT ""  
     FIELD n_name       AS CHAR FORMAT "X(45)"  INIT "" 
     FIELD n_lname      AS CHAR FORMAT "X(45)"  INIT ""  
     FIELD n_brand      AS CHAR FORMAT "X(25)"  INIT ""  
     FIELD n_model      AS CHAR FORMAT "X(25)"  INIT ""  
     FIELD n_year       AS CHAR FORMAT "X(04)"  INIT ""  
     FIELD n_chano      AS CHAR FORMAT "X(20)"  INIT ""  
     FIELD n_licen      AS CHAR FORMAT "X(11)"  INIT ""  
     FIELD n_plicen     AS CHAR FORMAT "X(25)"  INIT ""  
     FIELD n_comdat     AS CHAR FORMAT "X(15)"  INIT ""  
     FIELD n_expdat     AS CHAR FORMAT "X(15)"  INIT ""  
     FIELD n_ipa        AS CHAR FORMAT "X(05)"  INIT ""  
     FIELD n_trntyp     AS CHAR FORMAT "X(02)"  INIT ""  
     FIELD n_countp     AS CHAR FORMAT "X(05)"  INIT ""  
     FIELD n_producer   AS CHAR FORMAT "X(11)"  INIT ""  
     FIELD n_proname    AS CHAR FORMAT "X(50)"  INIT ""  
     FIELD n_branch     AS CHAR FORMAT "X(02)"  INIT ""  
     FIELD n_region     AS CHAR FORMAT "X(25)"  INIT ""  .

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
&Scoped-define FIELDS-IN-QUERY-br_tlt tlt.trndat tlt.entdat tlt.policy ~
tlt.filler1 tlt.rec_name tlt.ins_name tlt.rec_addr5 tlt.brand tlt.model ~
tlt.lince2 tlt.cha_no tlt.lince1 tlt.lince3 tlt.gendat tlt.expodat tlt.exp ~
tlt.flag tlt.lotno tlt.recac tlt.safe1 tlt.safe2 tlt.safe3 
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_tlt 
&Scoped-define QUERY-STRING-br_tlt FOR EACH tlt NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-br_tlt OPEN QUERY br_tlt FOR EACH tlt NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-br_tlt tlt
&Scoped-define FIRST-TABLE-IN-QUERY-br_tlt tlt


/* Definitions for FRAME fr_main                                        */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS rs_typ fi_trndatfr fi_trndatto bu_ok ~
cb_search bu_oksch br_tlt fi_search cb_report fi_outfile bu_report bu_exit ~
fi_data RECT-332 RECT-333 RECT-338 RECT-341 RECT-382 RECT-462 
&Scoped-Define DISPLAYED-OBJECTS rs_typ fi_trndatfr fi_trndatto cb_search ~
fi_search cb_report fi_outfile fi_data 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR c-wins AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bu_exit 
     LABEL "Exit" 
     SIZE 9 BY 1
     FONT 6.

DEFINE BUTTON bu_ok 
     LABEL "OK" 
     SIZE 7.33 BY .71
     FONT 6.

DEFINE BUTTON bu_oksch 
     LABEL "OK" 
     SIZE 6.5 BY .95
     FONT 6.

DEFINE BUTTON bu_report 
     LABEL "EXP" 
     SIZE 8.17 BY .95
     FONT 6.

DEFINE VARIABLE cb_report AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEMS "Item 1" 
     DROP-DOWN-LIST
     SIZE 18.17 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE cb_search AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEMS "ชื่อผู้เอาประกัน" 
     DROP-DOWN-LIST
     SIZE 29.5 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_data AS CHARACTER FORMAT "X(12)":U 
     VIEW-AS FILL-IN 
     SIZE 21 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_outfile AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 47 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_search AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 44.67 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_trndatfr AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 26.5 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_trndatto AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 26.5 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE rs_typ AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "All", 1,
"N", 2,
"E", 3,
"C", 4
     SIZE 19.17 BY 1
     BGCOLOR 20 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-332
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132.5 BY 5.48
     BGCOLOR 29 .

DEFINE RECTANGLE RECT-333
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 9.5 BY 1.52
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-338
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 53.83 BY 3.1
     BGCOLOR 10 .

DEFINE RECTANGLE RECT-341
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 12.33 BY 1.76
     BGCOLOR 6 FGCOLOR 4 .

DEFINE RECTANGLE RECT-382
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 9.67 BY 1.43
     BGCOLOR 22 FGCOLOR 4 .

DEFINE RECTANGLE RECT-462
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 77.67 BY 3.1
     BGCOLOR 19 .

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_tlt FOR 
      tlt SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_tlt
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_tlt c-wins _STRUCTURED
  QUERY br_tlt NO-LOCK DISPLAY
      tlt.trndat COLUMN-LABEL "Report Date" FORMAT "99/99/9999":U
            WIDTH 11.33
      tlt.entdat COLUMN-LABEL "Trans Date" FORMAT "99/99/9999":U
            WIDTH 11.83
      tlt.policy COLUMN-LABEL "Policy" FORMAT "x(16)":U WIDTH 13.83
      tlt.filler1 COLUMN-LABEL "Mounth:Year" FORMAT "x(15)":U WIDTH 10.83
      tlt.rec_name COLUMN-LABEL "คำนำหน้าชื่อ" FORMAT "x(30)":U
            WIDTH 11.5
      tlt.ins_name COLUMN-LABEL "ชื่อ" FORMAT "x(30)":U WIDTH 23.33
      tlt.rec_addr5 COLUMN-LABEL "สกุล" FORMAT "x(30)":U WIDTH 23.83
      tlt.brand COLUMN-LABEL "ยี่ห้อ" FORMAT "x(30)":U
      tlt.model COLUMN-LABEL "รุ่น" FORMAT "x(25)":U
      tlt.lince2 COLUMN-LABEL "ปีรถ" FORMAT "x(5)":U
      tlt.cha_no FORMAT "x(20)":U WIDTH 21.83
      tlt.lince1 COLUMN-LABEL "ทะเบียน" FORMAT "x(10)":U
      tlt.lince3 COLUMN-LABEL "จังหวัดจดทะเบียน" FORMAT "x(20)":U
      tlt.gendat COLUMN-LABEL "วันที่คุ้มครอง" FORMAT "99/99/9999":U
      tlt.expodat COLUMN-LABEL "วันที่สิ้นสุด" FORMAT "99/99/9999":U
            WIDTH 9.5
      tlt.exp COLUMN-LABEL "IPA/Mondial" FORMAT "X(5)":U
      tlt.flag COLUMN-LABEL "Trans Type" FORMAT "XX":U
      tlt.lotno COLUMN-LABEL "Count Pol" FORMAT "x(9)":U
      tlt.recac COLUMN-LABEL "Producer" FORMAT "X(10)":U
      tlt.safe1 COLUMN-LABEL "Producer Name" FORMAT "x(30)":U
      tlt.safe2 COLUMN-LABEL "Branch" FORMAT "x(20)":U
      tlt.safe3 COLUMN-LABEL "Region" FORMAT "x(20)":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 132.5 BY 16.67
         BGCOLOR 15  ROW-HEIGHT-CHARS .75.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     rs_typ AT ROW 4.95 COL 113 NO-LABEL 
     fi_trndatfr AT ROW 3 COL 22.67 COLON-ALIGNED NO-LABEL
     fi_trndatto AT ROW 3 COL 59.17 COLON-ALIGNED NO-LABEL
     bu_ok AT ROW 3.1 COL 90.67
     cb_search AT ROW 4.95 COL 16 COLON-ALIGNED NO-LABEL
     bu_oksch AT ROW 6.19 COL 48
     br_tlt AT ROW 8.14 COL 1.33
     fi_search AT ROW 6.19 COL 2.83 NO-LABEL
     cb_report AT ROW 4.95 COL 65.17 COLON-ALIGNED NO-LABEL
     fi_outfile AT ROW 6.24 COL 74 NO-LABEL
     bu_report AT ROW 6.33 COL 122.67
     bu_exit AT ROW 3.05 COL 122
     fi_data AT ROW 4.95 COL 83.5 COLON-ALIGNED NO-LABEL
     "QUERY DATA REPORT ROADSIDE" VIEW-AS TEXT
          SIZE 39 BY 1.19 AT ROW 1.24 COL 51
          FGCOLOR 15 FONT 36
     "To  :" VIEW-AS TEXT
          SIZE 7.5 BY 1 AT ROW 3 COL 52.17
          BGCOLOR 18 FONT 6
     "Type" VIEW-AS TEXT
          SIZE 6 BY 1 AT ROW 4.95 COL 107 
          BGCOLOR 2 FGCOLOR 7 FONT 6
     "Output file name :" VIEW-AS TEXT
          SIZE 17 BY .95 AT ROW 6.24 COL 56
          BGCOLOR 2 FGCOLOR 7 FONT 6
     "Process Date From :" VIEW-AS TEXT
          SIZE 21.17 BY 1 AT ROW 3 COL 2.83
          BGCOLOR 18 FONT 6
     "   Search  By :" VIEW-AS TEXT
          SIZE 14 BY 1 AT ROW 4.95 COL 2.83
          BGCOLOR 3 FGCOLOR 7 FONT 6
     "Report BY" VIEW-AS TEXT
          SIZE 10.67 BY .95 AT ROW 5 COL 56.17
          BGCOLOR 2 FGCOLOR 7 FONT 6
     RECT-332 AT ROW 2.43 COL 1.33
     RECT-333 AT ROW 2.71 COL 89.5
     RECT-338 AT ROW 4.57 COL 1.67
     RECT-341 AT ROW 2.67 COL 120.33
     RECT-382 AT ROW 6.1 COL 122.5
     RECT-462 AT ROW 4.57 COL 55.5 
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133.17 BY 24.05
         BGCOLOR 1 .


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
         TITLE              = "Query && Update [LOCKTON]"
         HEIGHT             = 24.05
         WIDTH              = 133.17
         MAX-HEIGHT         = 45.76
         MAX-WIDTH          = 213.33
         VIRTUAL-HEIGHT     = 45.76
         VIRTUAL-WIDTH      = 213.33
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
     _FldNameList[1]   > brstat.tlt.trndat
"tlt.trndat" "Report Date" ? "date" ? ? ? ? ? ? no ? no no "11.33" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[2]   > brstat.tlt.entdat
"tlt.entdat" "Trans Date" ? "date" ? ? ? ? ? ? no ? no no "11.83" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   > brstat.tlt.policy
"tlt.policy" "Policy" ? "character" ? ? ? ? ? ? no ? no no "13.83" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   > brstat.tlt.filler1
"tlt.filler1" "Mounth:Year" "x(15)" "character" ? ? ? ? ? ? no ? no no "10.83" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   > brstat.tlt.rec_name
"tlt.rec_name" "คำนำหน้าชื่อ" "x(30)" "character" ? ? ? ? ? ? no ? no no "11.5" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[6]   > brstat.tlt.ins_name
"tlt.ins_name" "ชื่อ" "x(30)" "character" ? ? ? ? ? ? no ? no no "23.33" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[7]   > brstat.tlt.rec_addr5
"tlt.rec_addr5" "สกุล" "x(30)" "character" ? ? ? ? ? ? no ? no no "23.83" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[8]   > brstat.tlt.brand
"tlt.brand" "ยี่ห้อ" "x(30)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[9]   > brstat.tlt.model
"tlt.model" "รุ่น" ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[10]   > brstat.tlt.lince2
"tlt.lince2" "ปีรถ" ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[11]   > brstat.tlt.cha_no
"tlt.cha_no" ? ? "character" ? ? ? ? ? ? no ? no no "21.83" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[12]   > brstat.tlt.lince1
"tlt.lince1" "ทะเบียน" "x(10)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[13]   > brstat.tlt.lince3
"tlt.lince3" "จังหวัดจดทะเบียน" "x(20)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[14]   > brstat.tlt.gendat
"tlt.gendat" "วันที่คุ้มครอง" ? "date" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[15]   > brstat.tlt.expodat
"tlt.expodat" "วันที่สิ้นสุด" "99/99/9999" "date" ? ? ? ? ? ? no ? no no "9.5" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[16]   > brstat.tlt.exp
"tlt.exp" "IPA/Mondial" "X(5)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[17]   > brstat.tlt.flag
"tlt.flag" "Trans Type" "XX" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[18]   > brstat.tlt.lotno
"tlt.lotno" "Count Pol" ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[19]   > brstat.tlt.recac
"tlt.recac" "Producer" "X(10)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[20]   > brstat.tlt.safe1
"tlt.safe1" "Producer Name" "x(30)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[21]   > brstat.tlt.safe2
"tlt.safe2" "Branch" "x(20)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[22]   > brstat.tlt.safe3
"tlt.safe3" "Region" "x(20)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _Query            is NOT OPENED
*/  /* BROWSE br_tlt */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME c-wins
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c-wins c-wins
ON END-ERROR OF c-wins /* Query  Update [LOCKTON] */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c-wins c-wins
ON WINDOW-CLOSE OF c-wins /* Query  Update [LOCKTON] */
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
  /*  Get Current br_tlt.
          nv_recidtlt  =  Recid(tlt).

    {&WINDOW-NAME}:hidden  =  Yes. 
    
    Run  wgw\wgwqloc2(Input  nv_recidtlt).

    {&WINDOW-NAME}:hidden  =  No. */                                              

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_tlt c-wins
ON VALUE-CHANGED OF br_tlt IN FRAME fr_main
DO:
    /* Get  current  br_tlt.
     nv_rectlt =  recid(tlt).
     fi_name   =  tlt.ins_name.
     disp  fi_name  with frame  fr_main.*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_exit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_exit c-wins
ON CHOOSE OF bu_exit IN FRAME fr_main /* Exit */
DO:
   APPLY "close" TO THIS-PROCEDURE.
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
        tlt.trndat  <=   fi_trndatto   And
        /*tlt.policy  >=   fi_polfr     And
        tlt.policy  <=   fi_polto     And*/
        /*tlt.comp_sub  =  fi_producer  And*/
        tlt.genusr   =  "Roadside"        no-lock. 
            /*
            nv_rectlt =  recid(tlt).   /*A55-0184*/
            Apply "Entry"  to br_tlt.
            Return no-apply.    */                         
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
   If  cb_search = "ชื่อลูกค้า"  Then do:              /* name  */                          
        Open Query br_tlt                                                        
            For each tlt Use-index  tlt01      Where                                     
            tlt.trndat  >=  fi_trndatfr        And                                            
            tlt.trndat  <=  fi_trndatto        And  
            tlt.genusr   =  "Roadside"         And
            index(tlt.ins_name,fi_search) <> 0 no-lock. 
    END.
    ELSE If  cb_search  =  "กรมธรรม์"  Then do:   /* policy */
        Open Query br_tlt 
            For each tlt Use-index  tlt01 Where
            tlt.trndat   >=  fi_trndatfr  And
            tlt.trndat   <=  fi_trndatto  And
            tlt.genusr    =  "Roadside"   And
            index(tlt.policy,fi_search) <> 0  no-lock.
    END.
   ELSE If  cb_search  = "เลขตัวถัง"  Then do:  /* chassis no */
        Open Query br_tlt 
            For each tlt Use-index  tlt06 Where
            tlt.trndat >=  fi_trndatfr    And
            tlt.trndat <=  fi_trndatto    AND 
            tlt.genusr   =  "Roadside"       And
            INDEX(tlt.cha_no,trim(fi_search)) <> 0  no-lock.
    END.
    ELSE If  cb_search  =  "วันที่โอนงาน"  Then do:   /* Tran date..*/
        Open Query br_tlt 
            For each tlt Use-index  tlt01  Where
            tlt.trndat >=  fi_trndatfr     And
            tlt.trndat <=  fi_trndatto     And
            tlt.entdat  =  DATE(fi_search) AND
            tlt.genusr  =  "Roadside"      no-lock.
    END.
    ELSE If  cb_search  =  "Month:Year"  Then do:     /* Month*/
        Open Query br_tlt 
            For each tlt Use-index  tlt01   Where
            tlt.trndat  >=  fi_trndatfr      And 
            tlt.trndat  <=  fi_trndatto      And 
            tlt.genusr   =  "Roadside"      And
            tlt.filler1  = TRIM(fi_search)  no-lock.
    END.
    ELSE If  cb_search  =  "Producer Code"  Then do:    /* cancel */
        Open Query br_tlt 
            For each tlt Use-index  tlt01  Where
            tlt.trndat  >=  fi_trndatfr    And
            tlt.trndat  <=  fi_trndatto    And
            tlt.genusr   =  "Roadside"        And
            tlt.recac    =  TRIM(fi_search)     no-lock.
    END.
    ELSE If  cb_search  =  "สาขา"  Then do:    /* cancel */
        Open Query br_tlt 
            For each tlt Use-index  tlt01  Where
            tlt.trndat  >=  fi_trndatfr    And
            tlt.trndat  <=  fi_trndatto    And
            tlt.genusr   =  "Roadside"     And
            tlt.safe2    = trim(fi_search) no-lock.
               /* ASSIGN nv_rectlt =  recid(tlt) .  /*add Kridtiya i. A56-0323*/
                Apply "Entry"  to br_tlt.
                Return no-apply. */                            
    END.
    ELSE If  cb_search  =  "Trans Type"  Then do:    /* cancel */
        Open Query br_tlt 
            For each tlt Use-index  tlt01  Where
            tlt.trndat  >=  fi_trndatfr    And
            tlt.trndat  <=  fi_trndatto    And
            tlt.genusr   =  "Roadside"     And
            tlt.flag     = trim(fi_search) no-lock.
               /* ASSIGN nv_rectlt =  recid(tlt) .  /*add Kridtiya i. A56-0323*/
                Apply "Entry"  to br_tlt.
                Return no-apply. */                            
    END.
   /* Else  do:
        ASSIGN nv_rectlt =  recid(tlt) .  /*add Kridtiya i. A56-0323*/
        Apply "Entry"  to  fi_search.
        Return no-apply.
    END.*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_report
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_report c-wins
ON CHOOSE OF bu_report IN FRAME fr_main /* EXP */
DO:
    IF fi_outfile = "" THEN DO:
        MESSAGE "กรุณาใสชื่อไฟล์!!!"  VIEW-AS ALERT-BOX.
        Apply "Entry"  to fi_outfile.
        Return no-apply. 
    END.
    ELSE DO:
        FOR EACH wdetail :
            DELETE wdetail.
        END.
        RUN pd_reportfile. 
        Message "Export data Complete"  View-as alert-box.
    END.
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
   /* ELSE IF n_asdat1 = "Old Policy" THEN DO:
        APPLY "ENTRY" TO fi_data.
        RETURN NO-APPLY.
    END.*/
   
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


&Scoped-define SELF-NAME fi_data
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_data c-wins
ON LEAVE OF fi_data IN FRAME fr_main
DO:
  fi_data = CAPS(INPUT fi_data) .
  DISP fi_data WITH FRAM fr_main.
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
    Disp fi_search  with frame fr_main.
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


&Scoped-define SELF-NAME rs_typ
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL rs_typ c-wins
ON VALUE-CHANGED OF rs_typ IN FRAME fr_main
DO:
    rs_typ = INPUT rs_typ.
    DISP rs_typ WITH FRAME fr_main.
  
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
  gv_prgid = "wgwipais".
  gv_prog  = "Query Data Report Roadside (ISUZU) ".
  RUN  WUT\WUTHEAD ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).
  ASSIGN 
      fi_trndatfr = TODAY
      fi_trndatto = TODAY
      vAcProc_fil = vAcProc_fil   + "ชื่อลูกค้า"    + "," 
                                  + "กรมธรรม์"      + "," 
                                  + "เลขตัวถัง"     + "," 
                                  + "วันที่โอนงาน"  + "," 
                                  + "Producer Code" + ","
                                  + "สาขา"          + ","
                                  + "Trans Type "   + ","
        cb_search:LIST-ITEMS = vAcProc_fil
        cb_search = ENTRY(1,vAcProc_fil)
        vAcProc_fil1 = vAcProc_fil1
                                  + "All"           + ","
                                  + "Trans Date"    + ","
                                  + "Month:Year"    + ","
                                  + "Producer Code" + ","
                                  + "Branch"        + ","
        cb_report:LIST-ITEMS = vAcProc_fil1
        cb_report = ENTRY(1,vAcProc_fil1)
        rs_typ = 1
        fi_outfile = "D:\Export_Roadside" + 
                    STRING(YEAR(TODAY),"9999") + 
                    STRING(MONTH(TODAY),"99")  + 
                    STRING(DAY(TODAY),"99")    + 
                    SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) + 
                    SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2) + ".SLK" .
 
  Disp fi_trndatfr  fi_trndatto cb_search cb_report rs_typ fi_outfile
      /*fi_polfr 
      fi_polto*/  with frame fr_main.

/*********************************************************************/ 
 /*  RUN Wut\WutwiCen ({&WINDOW-NAME}:HANDLE). */ 
  /*CURRENT-WINDOW:WINDOW-STATE = WINDOW-MAXIMIZED.*/
  SESSION:DATA-ENTRY-RETURN = YES.
  
  
  Rect-333:Move-to-top().
  Rect-338:Move-to-top().  
  
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
  DISPLAY rs_typ fi_trndatfr fi_trndatto cb_search fi_search cb_report 
          fi_outfile fi_data 
      WITH FRAME fr_main IN WINDOW c-wins.
  ENABLE rs_typ fi_trndatfr fi_trndatto bu_ok cb_search bu_oksch br_tlt 
         fi_search cb_report fi_outfile bu_report bu_exit fi_data RECT-332 
         RECT-333 RECT-338 RECT-341 RECT-382 RECT-462 
      WITH FRAME fr_main IN WINDOW c-wins.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW c-wins.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_reportfile c-wins 
PROCEDURE pd_reportfile :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR n_typn    AS int INIT 0.
DEF VAR n_typc    AS int INIT 0.
DEF VAR n_type    AS int INIT 0.
DEF VAR nv_length AS INT INIT 0.

If  substr(fi_outfile,length(fi_outfile) - 3,4) <>  ".slk"  THEN 
    fi_outfile  =  Trim(fi_outfile) + ".slk"  .

ASSIGN  nv_row  = 0         n_typn  = 0   
        n_typc  = 0         n_type  = 0.  

OUTPUT TO VALUE(fi_outfile).
EXPORT DELIMITER "|" 
    "Repor RoadSide " 
    string(TODAY)   .
EXPORT DELIMITER "|" 
    "no      "
    "Report date"
    "pol     "
    "Trndat  "
    "Month:Year "
    "title   "
    "name    "
    "lname   "
    "brand   "
    "model   "
    "year    "
    "chano   "
    "licen   "
    "plicen  "
    "comdat  "
    "expdat  "
    "ipa     "
    "trntyp  "
    "countp  "
    "producer"
    "proname "
    "branch  "
    "region  ".

For each brstat.tlt Use-index  tlt01 Where
            brstat.tlt.trndat   >=  fi_trndatfr   And
            brstat.tlt.trndat   <=  fi_trndatto   And
            brstat.tlt.genusr    =  "Roadside"    no-lock. 

    
    IF cb_report = "Branch" THEN DO:
        IF brstat.tlt.EXP  <> trim(fi_data)  THEN NEXT.
    END.
    ELSE IF cb_report = "Trans Date" THEN DO:
        IF (brstat.tlt.entdat) <> DATE(fi_data) THEN NEXT.
    END.
    /*ELSE IF cb_report = "Trans Type" THEN DO:
        IF (brstat.tlt.flag) <> trim(fi_data) THEN NEXT.
    END.*/
    ELSE IF cb_report =   "Month:Year"   THEN DO:
        IF tlt.filler1  <> TRIM(fi_data)  THEN NEXT.
    END.
    ELSE IF cb_report =   "Producer Code"   THEN DO:
        IF tlt.recac   <>  TRIM(fi_data) THEN NEXT.
    END.

    IF rs_typ = 2 THEN do:
        IF brstat.tlt.flag <> "N" THEN NEXT.
    END.
    ELSE IF rs_typ = 3 THEN DO:
        IF brstat.tlt.flag <> "E" THEN NEXT.
    END.
    ELSE IF rs_typ = 4 THEN DO:
        IF brstat.tlt.flag <> "C" THEN NEXT.
    END.

    FIND LAST wdetail WHERE wdetail.n_pol    = brstat.tlt.policy   AND
                            wdetail.n_countp = brstat.tlt.lotno NO-ERROR NO-WAIT.
    IF NOT AVAIL wdetail THEN DO:
        CREATE wdetail.
        ASSIGN       
               wdetail.n_pol         = tlt.policy 
               wdetail.n_repdat      = string(tlt.trndat,"99/99/9999") 
               wdetail.n_Trndat      = string(tlt.entdat,"99/99/9999")    
               wdetail.n_MY          = tlt.filler1  
               wdetail.n_title       = tlt.rec_name 
               wdetail.n_name        = tlt.ins_name 
               wdetail.n_lname       = tlt.rec_addr5
               wdetail.n_brand       = tlt.brand    
               wdetail.n_model       = tlt.model    
               wdetail.n_year        = tlt.lince2   
               wdetail.n_chano       = tlt.cha_no   
               wdetail.n_licen       = tlt.lince1   
               wdetail.n_plicen      = tlt.lince3   
               wdetail.n_comdat      = string(tlt.gendat,"99/99/9999")   
               wdetail.n_expdat      = string(tlt.expodat,"99/99/9999")  
               wdetail.n_ipa         = tlt.EXP      
               wdetail.n_trntyp      = tlt.flag     
               wdetail.n_countp      = string(tlt.lotno)    
               wdetail.n_producer    = tlt.recac    
               wdetail.n_proname     = tlt.safe1    
               wdetail.n_branch      = tlt.safe2    
               wdetail.n_region      = tlt.safe3 .
    END.
    ELSE DO:
         ASSIGN       
               wdetail.n_pol         = tlt.policy 
               wdetail.n_repdat      = string(tlt.trndat,"99/99/9999")
               wdetail.n_Trndat      = string(tlt.entdat,"99/99/9999")     
               wdetail.n_MY          = tlt.filler1  
               wdetail.n_title       = tlt.rec_name 
               wdetail.n_name        = tlt.ins_name 
               wdetail.n_lname       = tlt.rec_addr5
               wdetail.n_brand       = tlt.brand    
               wdetail.n_model       = tlt.model    
               wdetail.n_year        = tlt.lince2   
               wdetail.n_chano       = tlt.cha_no   
               wdetail.n_licen       = tlt.lince1   
               wdetail.n_plicen      = tlt.lince3   
               wdetail.n_comdat      = string(tlt.gendat,"99/99/9999")   
               wdetail.n_expdat      = string(tlt.expodat,"99/99/9999")  
               wdetail.n_ipa         = tlt.EXP      
               wdetail.n_trntyp      = tlt.flag     
               wdetail.n_countp      = string(tlt.lotno)    
               wdetail.n_producer    = tlt.recac    
               wdetail.n_proname     = tlt.safe1    
               wdetail.n_branch      = tlt.safe2    
               wdetail.n_region      = tlt.safe3 .
    END.
END.
FOR EACH wdetail NO-LOCK.
      nv_row = nv_row + 1 .
      EXPORT DELIMITER "|" 
            nv_row              /*no      */
            wdetail.n_repdat    /*Report Date*/
            wdetail.n_pol       /*pol     */
            wdetail.n_Trndat    /*Trndat  */ 
            wdetail.n_MY        /*MY      */      
            wdetail.n_title     /*title   */      
            wdetail.n_name      /*name    */      
            wdetail.n_lname     /*lname   */      
            wdetail.n_brand     /*brand   */      
            wdetail.n_model     /*model   */      
            wdetail.n_year      /*year    */      
            wdetail.n_chano     /*chano   */      
            wdetail.n_licen     /*licen   */      
            wdetail.n_plicen    /*plicen  */      
            wdetail.n_comdat    /*comdat  */      
            wdetail.n_expdat    /*expdat  */      
            wdetail.n_ipa       /*ipa     */      
            wdetail.n_trntyp    /*trntyp  */      
            wdetail.n_countp    /*countp  */      
            wdetail.n_producer  /*producer*/      
            wdetail.n_proname   /*proname */      
            wdetail.n_branch    /*branch  */      
            wdetail.n_region .  /*region  */      
END.   
IF rs_typ = 1 THEN DO:
    FOR EACH wdetail NO-LOCK.
        IF      wdetail.n_trntyp = "N" THEN ASSIGN n_typn = n_typn + 1 .
        ELSE IF wdetail.n_trntyp = "E" THEN ASSIGN n_type = n_type + 1 .
        ELSE IF wdetail.n_trntyp = "C" THEN ASSIGN n_typc = n_typc + 1 .
    END.
    nv_row = nv_row + 1 .
    EXPORT DELIMITER "|"
        "Transtype : N "  n_typn.
    nv_row = nv_row + 1 . 
    EXPORT DELIMITER "|"  
        "Transtype : E "  n_type.
    nv_row = nv_row + 1 . 
    EXPORT DELIMITER "|"  
        "Transtype : C "  n_typc .
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
        tlt.genusr   =  "Roadside"      no-lock.
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
                             tlt.genusr   =  "Tisco"      no-lock.*/
    FOR EACH tlt Where Recid(tlt)  =  nv_rectlt NO-LOCK .
        ASSIGN nv_rectlt =  recid(tlt).   /*A57-0017*/
        
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

