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
program id   : wgwqutp1.w
program name : Query & Update Data til-tpib
               Import text file from  Aycal to create  new policy Add in table  tlt 
Create  by   : Kridtiya i. [A57-0010]   On   14/01/2014
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
DEFINE  WORKFILE wdetail NO-UNDO
    FIELD notifydate      AS CHAR FORMAT "X(10)"  INIT ""                                                    
    FIELD branch          AS CHAR FORMAT "X(2)"   INIT ""                                    
    FIELD policy          AS CHAR FORMAT "X(12)"  INIT ""   
    FIELD stk             AS CHAR FORMAT "X(15)"  INIT ""                                       
    FIELD docno           AS CHAR FORMAT "X(10)"  INIT ""                                    
    FIELD remark          AS CHAR FORMAT "X(150)" INIT "".
    
    





























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
tlt.nor_noti_tlt tlt.comp_usr_tlt tlt.cha_no tlt.safe2 tlt.filler2 ~
tlt.usrid 
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_tlt 
&Scoped-define QUERY-STRING-br_tlt FOR EACH tlt NO-LOCK
&Scoped-define OPEN-QUERY-br_tlt OPEN QUERY br_tlt FOR EACH tlt NO-LOCK.
&Scoped-define TABLES-IN-QUERY-br_tlt tlt
&Scoped-define FIRST-TABLE-IN-QUERY-br_tlt tlt


/* Definitions for FRAME fr_main                                        */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS ra_bydelete bu_delete fi_loaddate ~
fi_inputfile fi_trndatfr fi_trndatto fi_search bu_sch cb_report ~
fi_repolicyfr_key fi_repolicyto_key fi_reportdata fi_filename bu_reok ~
bu_exit bu_file bu_imp bu_ok cb_search fi_report br_tlt fi_datadelform ~
fi_datadelto bu_update bu_updatecan RECT-332 RECT-343 RECT-346 RECT-494 ~
RECT-495 RECT-496 RECT-497 RECT-499 RECT-500 RECT-501 
&Scoped-Define DISPLAYED-OBJECTS ra_bydelete fi_loaddate fi_inputfile ~
fi_trndatfr fi_trndatto fi_search cb_report fi_repolicyfr_key ~
fi_repolicyto_key fi_reportdata fi_filename cb_search fi_report ~
fi_datadelform fi_datadelto fi_repolicyfr fi_repolicyto 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR c-wins AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bu_delete 
     LABEL "DELETE" 
     SIZE 7.5 BY 1.24.

DEFINE BUTTON bu_exit 
     LABEL "Exit" 
     SIZE 6 BY 1
     FONT 6.

DEFINE BUTTON bu_file 
     LABEL "..." 
     SIZE 3.5 BY 1.

DEFINE BUTTON bu_imp 
     LABEL "IMP" 
     SIZE 7 BY 1
     FONT 6.

DEFINE BUTTON bu_ok 
     LABEL "Ok" 
     SIZE 7 BY 1
     FONT 6.

DEFINE BUTTON bu_reok 
     LABEL "OK" 
     SIZE 5.5 BY 1.

DEFINE BUTTON bu_sch 
     LABEL "Search" 
     SIZE 7.5 BY 1.

DEFINE BUTTON bu_update 
     LABEL "Yes / No" 
     SIZE 10 BY 1
     FONT 6.

DEFINE BUTTON bu_updatecan 
     LABEL "Cancel / OK" 
     SIZE 17 BY 1
     FONT 6.

DEFINE VARIABLE cb_report AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEMS "เลขกรมธรรม์" 
     DROP-DOWN-LIST
     SIZE 29 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE cb_search AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEMS "เลขกรมธรรม์" 
     DROP-DOWN-LIST
     SIZE 36 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_datadelform AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 18 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_datadelto AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 18 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_filename AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 47.5 BY 1
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_inputfile AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 58 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_loaddate AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_repolicyfr AS CHARACTER FORMAT "X(12)":U 
     VIEW-AS FILL-IN 
     SIZE 12 BY 1
     BGCOLOR 2 FGCOLOR 7  NO-UNDO.

DEFINE VARIABLE fi_repolicyfr_key AS CHARACTER FORMAT "X(12)":U 
     VIEW-AS FILL-IN 
     SIZE 17 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_repolicyto AS CHARACTER FORMAT "X(12)":U 
     VIEW-AS FILL-IN 
     SIZE 10.5 BY 1
     BGCOLOR 2 FGCOLOR 7  NO-UNDO.

DEFINE VARIABLE fi_repolicyto_key AS CHARACTER FORMAT "X(12)":U 
     VIEW-AS FILL-IN 
     SIZE 17 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_report AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 10.5 BY 1
     BGCOLOR 2 FGCOLOR 7  NO-UNDO.

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
     SIZE 14 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_trndatto AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE ra_bydelete AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "By Trandate", 1,
"By Policy", 2
     SIZE 47.5 BY .95
     FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-332
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 132.5 BY 8.52
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-343
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 52 BY 6.81
     BGCOLOR 18 .

DEFINE RECTANGLE RECT-346
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 10.5 BY 1.52
     BGCOLOR 6 FGCOLOR 0 .

DEFINE RECTANGLE RECT-494
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 132.5 BY 1.81
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-495
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 9.5 BY 1.52
     BGCOLOR 2 FGCOLOR 7 .

DEFINE RECTANGLE RECT-496
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 78 BY 3.95
     BGCOLOR 18 .

DEFINE RECTANGLE RECT-497
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 78 BY 4.14
     BGCOLOR 18 .

DEFINE RECTANGLE RECT-499
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 8.5 BY 1.52
     BGCOLOR 5 .

DEFINE RECTANGLE RECT-500
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 8.5 BY 1.52
     BGCOLOR 6 .

DEFINE RECTANGLE RECT-501
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 9.5 BY 1.43
     BGCOLOR 6 FGCOLOR 6 .

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
      tlt.filler2 COLUMN-LABEL "หมายเหตุ" FORMAT "x(90)":U
      tlt.usrid FORMAT "x(8)":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 132.5 BY 13.24
         BGCOLOR 15 FGCOLOR 0 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     ra_bydelete AT ROW 3.24 COL 66.17 NO-LABEL
     bu_delete AT ROW 4.29 COL 113.83
     fi_loaddate AT ROW 1.43 COL 24.33 COLON-ALIGNED NO-LABEL
     fi_inputfile AT ROW 1.43 COL 57.17 COLON-ALIGNED NO-LABEL
     fi_trndatfr AT ROW 3.24 COL 17.67 COLON-ALIGNED NO-LABEL
     fi_trndatto AT ROW 4.38 COL 17.5 COLON-ALIGNED NO-LABEL
     fi_search AT ROW 6.95 COL 3.5 NO-LABEL
     bu_sch AT ROW 6.95 COL 43.67
     cb_report AT ROW 7.19 COL 66.33 COLON-ALIGNED NO-LABEL
     fi_repolicyfr_key AT ROW 8.33 COL 78 COLON-ALIGNED NO-LABEL
     fi_repolicyto_key AT ROW 8.33 COL 106.67 COLON-ALIGNED NO-LABEL
     fi_reportdata AT ROW 7.19 COL 106.33 COLON-ALIGNED NO-LABEL
     fi_filename AT ROW 9.52 COL 64.33 COLON-ALIGNED NO-LABEL
     bu_reok AT ROW 9.67 COL 115.83
     bu_exit AT ROW 9.67 COL 124.33
     bu_file AT ROW 1.43 COL 117.67
     bu_imp AT ROW 1.43 COL 122.67
     bu_ok AT ROW 4.38 COL 35.5
     cb_search AT ROW 5.71 COL 16.67 NO-LABEL
     fi_report AT ROW 7.19 COL 95.5 COLON-ALIGNED NO-LABEL
     br_tlt AT ROW 11.52 COL 1
     fi_datadelform AT ROW 4.38 COL 70.33 COLON-ALIGNED NO-LABEL
     fi_datadelto AT ROW 4.38 COL 93.33 COLON-ALIGNED NO-LABEL
     bu_update AT ROW 5.67 COL 77.83
     bu_updatecan AT ROW 5.67 COL 88.83
     fi_repolicyfr AT ROW 8.33 COL 65.83 COLON-ALIGNED NO-LABEL
     fi_repolicyto AT ROW 8.33 COL 96.17 COLON-ALIGNED NO-LABEL
     "Report File :" VIEW-AS TEXT
          SIZE 12.5 BY 1 AT ROW 7.19 COL 55.5
          BGCOLOR 5 FGCOLOR 7 FONT 6
     "To :" VIEW-AS TEXT
          SIZE 4 BY .95 AT ROW 4.38 COL 91
          BGCOLOR 2 FGCOLOR 7 FONT 6
     "Search By :" VIEW-AS TEXT
          SIZE 12.5 BY 1 AT ROW 5.71 COL 3.5
          BGCOLOR 2 FGCOLOR 7 FONT 6
     " TIL/TPIB :" VIEW-AS TEXT
          SIZE 11 BY 1 AT ROW 1.43 COL 2.5
          BGCOLOR 2 FGCOLOR 6 FONT 6
     "File name :" VIEW-AS TEXT
          SIZE 10.5 BY 1 AT ROW 9.52 COL 55.67
          BGCOLOR 2 FGCOLOR 7 FONT 6
     "Load Date :" VIEW-AS TEXT
          SIZE 11.5 BY 1 AT ROW 1.43 COL 14.67
          BGCOLOR 2 FGCOLOR 7 FONT 6
     "Up Status :" VIEW-AS TEXT
          SIZE 11 BY 1 AT ROW 5.62 COL 66.17
          BGCOLOR 2 FGCOLOR 7 FONT 6
     " Import File STK :" VIEW-AS TEXT
          SIZE 17 BY 1 AT ROW 1.43 COL 41.83
          BGCOLOR 2 FGCOLOR 7 FONT 6
     "Transdate To   :" VIEW-AS TEXT
          SIZE 16 BY 1 AT ROW 4.38 COL 3.5
          BGCOLOR 2 FGCOLOR 7 FONT 6
     "Transdate From :" VIEW-AS TEXT
          SIZE 16 BY 1 AT ROW 3.24 COL 3.5
          BGCOLOR 2 FGCOLOR 7 FONT 6
     "From :" VIEW-AS TEXT
          SIZE 5.5 BY .95 AT ROW 4.38 COL 66.17
          BGCOLOR 2 FGCOLOR 7 FONT 6
     RECT-332 AT ROW 2.81 COL 1
     RECT-343 AT ROW 3 COL 1.83
     RECT-346 AT ROW 6.76 COL 42.17
     RECT-494 AT ROW 1 COL 1
     RECT-495 AT ROW 4.1 COL 34.33
     RECT-496 AT ROW 2.91 COL 54.83
     RECT-497 AT ROW 6.86 COL 54.83
     RECT-499 AT ROW 9.38 COL 114.5
     RECT-500 AT ROW 9.38 COL 123.17
     RECT-501 AT ROW 1.24 COL 121.5
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
         TITLE              = "Query && Update [DATA BY TIL Compulsory]"
         HEIGHT             = 23.86
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
/* BROWSE-TAB br_tlt fi_report fr_main */
ASSIGN 
       br_tlt:SEPARATOR-FGCOLOR IN FRAME fr_main      = 0.

ASSIGN 
       bu_file:AUTO-RESIZE IN FRAME fr_main      = TRUE.

/* SETTINGS FOR COMBO-BOX cb_search IN FRAME fr_main
   ALIGN-L                                                              */
/* SETTINGS FOR FILL-IN fi_repolicyfr IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_repolicyto IN FRAME fr_main
   NO-ENABLE                                                            */
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
"tlt.releas" ? "X(15)" "character" ? ? ? ? ? ? no ? no no "11.83" yes no no "U" "" ""
     _FldNameList[2]   = brstat.tlt.trndat
     _FldNameList[3]   > brstat.tlt.nor_noti_tlt
"tlt.nor_noti_tlt" "เลขกรมธรรม์พรบ." "x(20)" "character" ? ? ? ? ? ? no ? no no "19.83" yes no no "U" "" ""
     _FldNameList[4]   > brstat.tlt.comp_usr_tlt
"tlt.comp_usr_tlt" "สาขา" ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[5]   > brstat.tlt.cha_no
"tlt.cha_no" "เลขสติ๊กเกอร์" ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[6]   > brstat.tlt.safe2
"tlt.safe2" "เลขที่ใบเสร็จ" "x(15)" "character" ? ? ? ? ? ? no ? no no "14.33" yes no no "U" "" ""
     _FldNameList[7]   > brstat.tlt.filler2
"tlt.filler2" "หมายเหตุ" "x(90)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[8]   = brstat.tlt.usrid
     _Query            is NOT OPENED
*/  /* BROWSE br_tlt */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME c-wins
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c-wins c-wins
ON END-ERROR OF c-wins /* Query  Update [DATA BY TIL Compulsory] */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c-wins c-wins
ON WINDOW-CLOSE OF c-wins /* Query  Update [DATA BY TIL Compulsory] */
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
    Run  wgw\wgwqutp2(Input  nv_recidtlt).
    {&WINDOW-NAME}:hidden  =  No.    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_tlt c-wins
ON VALUE-CHANGED OF br_tlt IN FRAME fr_main
DO:
     Get  current  br_tlt.
     nv_rectlt =  recid(tlt).
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_delete
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_delete c-wins
ON CHOOSE OF bu_delete IN FRAME fr_main /* DELETE */
DO:
    DEF VAR logAns AS LOGI INIT No.  
    logAns = No.
    IF ra_bydelete = 1 THEN DO:  
        MESSAGE "ต้องการลบข้อมูลรายการ "  DATE(fi_datadelform)   " - "    DATE(fi_datadelto)  
            UPDATE logAns                     
            VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO
            TITLE "ลบข้อมูลรายการนี้".  
    END.
    ELSE DO:
        MESSAGE "ต้องการลบข้อมูลรายการ "   trim(fi_datadelform)   " - "    trim(fi_datadelto)  
            UPDATE logAns                     
            VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO
            TITLE "ลบข้อมูลกรมธรรม์นี้".   
    END.
    IF logAns THEN DO:  
        IF ra_bydelete = 1 THEN DO:
            For each tlt Use-index  tlt01  Where
                tlt.trndat  >=   DATE(fi_datadelform)  And
                tlt.trndat  <=   DATE(fi_datadelto)    And
                tlt.genusr   =  "til72"           .  
                DELETE tlt. 
            END.
        END.
        ELSE DO:
            For each tlt Use-index  tlt01  Where
                tlt.nor_noti_tlt  >=   trim(fi_datadelform)  And
                tlt.nor_noti_tlt  <=   trim(fi_datadelto)    And
                tlt.genusr         =  "til72"          .  
                DELETE tlt. 
            END.
        END.
        MESSAGE "ลบข้อมูลเรียบร้อย ..." VIEW-AS ALERT-BOX INFORMATION.  
    END.  
    RUN Open_tlt2.
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
    ELSE Run Import_notification1.
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
        tlt.genusr   =   "til72"       no-lock.  
            ASSIGN nv_rectlt =  recid(tlt) .
            Apply "Entry"  to br_tlt.
            Return no-apply.                             
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_reok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_reok c-wins
ON CHOOSE OF bu_reok IN FRAME fr_main /* OK */
DO:
    IF fi_filename = ""  THEN DO:
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
    If  cb_search =  "เลขกรมธรรม์"   Then do:               /* name  */
        Open Query br_tlt                      
            For each tlt Use-index  tlt01 Where
            tlt.trndat       >=  fi_trndatfr    And
            tlt.trndat       <=  fi_trndatto    And
            tlt.genusr        =  "til72"        And
            tlt.nor_noti_tlt  = trim(fi_search) no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .
                Apply "Entry"  to br_tlt.
                Return no-apply.            
    END.
    ELSE IF  cb_search  = "สาขา"  THEN DO:
        Open Query br_tlt                      
            For each tlt Use-index  tlt01 Where
            tlt.trndat         >=  fi_trndatfr    And 
            tlt.trndat         <=  fi_trndatto    And 
            tlt.genusr          =  "til72"        And 
            tlt.comp_usr_tlt    = trim(fi_search) no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .
                Apply "Entry"  to br_tlt.      
                Return no-apply.  
    END.
    ELSE If  cb_search  =  "เลขสติ๊กเกอร์"    Then do:        /* cedpol */  
        Open Query br_tlt                      
            For each tlt Use-index  tlt01   Where
            tlt.trndat   >=  fi_trndatfr    And 
            tlt.trndat   <=  fi_trndatto    And 
            tlt.genusr    =  "til72"        And 
            tlt.cha_no    = trim(fi_search) no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .
                Apply "Entry"  to br_tlt.      
                Return no-apply.               
    END. 
    ELSE If  cb_search  =  "เลขที่ใบเสร็จ"  Then do:        /* prepol */  
        Open Query br_tlt                      
            For each tlt Use-index  tlt01 Where
            tlt.trndat   >=  fi_trndatfr  And 
            tlt.trndat   <=  fi_trndatto  And 
            tlt.genusr    =  "til72"       And 
            tlt.safe2     = trim(fi_search)  no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .
                Apply "Entry"  to br_tlt.      
                Return no-apply.               
    END. 
    ELSE If  cb_search  =  "Release Yes" Then do:         /* not ..complete... */
        Open Query br_tlt                      
            For each tlt Use-index  tlt01      Where
            tlt.trndat         >=  fi_trndatfr And
            tlt.trndat         <=  fi_trndatto And
            tlt.genusr          =  "til72"     And
            tlt.releas          =  "Yes"       no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .
                Apply "Entry"  to br_tlt.
                Return no-apply.                             
    END.
    ELSE If  cb_search  =  "Release No"  Then do:         /* not ..complete... */
        Open Query br_tlt                      
            For each tlt Use-index  tlt01      Where
            tlt.trndat         >=  fi_trndatfr And
            tlt.trndat         <=  fi_trndatto And
            tlt.genusr          =  "til72"     And
            tlt.releas          =  "No"        no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .
                Apply "Entry"  to br_tlt.
                Return no-apply.                             
    END.
    ELSE If  cb_search  =  "Release cancel"  Then do:         /* not ..complete... */
        Open Query br_tlt                      
            For each tlt Use-index  tlt01      Where
            tlt.trndat         >=  fi_trndatfr And
            tlt.trndat         <=  fi_trndatto And
            tlt.genusr          =  "til72"     And
            tlt.releas          =  "Cancel"    no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .
                Apply "Entry"  to br_tlt.
                Return no-apply.                             
    END.    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_update
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_update c-wins
ON CHOOSE OF bu_update IN FRAME fr_main /* Yes / No */
DO:
    Find tlt Where Recid(tlt)  =  nv_rectlt.
    If  avail tlt Then do:
        If  index(tlt.releas,"No")  =  0  Then do:    /* yes */
            message "Update No ข้อมูลรายการนี้  "  View-as alert-box.
            IF tlt.releas = "" THEN tlt.releas  =  "NO" .
            ELSE IF index(tlt.releas,"Cancel")  <> 0 THEN 
                ASSIGN tlt.releas  =  "No/Cancel" .
            ELSE ASSIGN tlt.releas  =  "No" .
        END.
        Else do:    /* no */
            If  index(tlt.releas,"Yes")  =  0  Then do:  /* no */
                message "Update Yes ข้อมูลรายการนี้  "  View-as alert-box.
                IF tlt.releas = "" THEN tlt.releas  =  "Yes" .
                ELSE IF index(tlt.releas,"Cancel")  <> 0 THEN 
                    ASSIGN tlt.releas  =  "Yes/Cancel" .
                ELSE ASSIGN tlt.releas  =  "Yes" .
            END.
        END.
    END.
    RUN Open_tlt2.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_updatecan
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_updatecan c-wins
ON CHOOSE OF bu_updatecan IN FRAME fr_main /* Cancel / OK */
DO:
    Find tlt Where Recid(tlt)  =  nv_rectlt.
    If  avail tlt Then do:
        If  index(tlt.releas,"/Cancel")  =  0  Then do:      /* cancel */
            message "Update No ข้อมูลรายการนี้  "  View-as alert-box.
            IF index(tlt.releas,"Yes") <> 0  THEN ASSIGN tlt.releas  =  "Yes/Cancel" .
            ELSE ASSIGN tlt.releas  =  "No/Cancel"  .
        END.
        Else do:    /* no */
            If   index(tlt.releas,"/Cancel")  <>  0   Then do:  /* no */
                message "Update Yes ข้อมูลรายการนี้  "  View-as alert-box.
                IF index(tlt.releas,"Yes") <> 0  THEN ASSIGN tlt.releas  =  "Yes" .
                ELSE ASSIGN tlt.releas  =  "No"  .
            END.
        END. 
    END.    
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
        ASSIGN 
            fi_report     = ""
            fi_repolicyfr = "Policy Form" 
            fi_repolicyto = "Policy To"  .  
        DISP  fi_repolicyfr fi_repolicyto  WITH FRAM fr_main.
        APPLY "ENTRY" TO fi_repolicyfr_key .
        RETURN NO-APPLY.
    END.
    ELSE IF      cb_report = "สาขา"               THEN DO:  
        ASSIGN fi_report = "สาขา"  .  
        DISP fi_report WITH FRAM fr_main.
        APPLY "ENTRY" TO fi_reportdata .
        RETURN NO-APPLY.
    END.
    ELSE IF cb_report = "ประเภทความคุ้มครอง" THEN DO:  
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
    END.  
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
    fi_datadelform  =  Input  fi_datadelform.
    Disp fi_datadelform  with frame fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_datadelto
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_datadelto c-wins
ON LEAVE OF fi_datadelto IN FRAME fr_main
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
            For each tlt Use-index  tlt01 Where
            tlt.trndat       >=  fi_trndatfr    And
            tlt.trndat       <=  fi_trndatto    And
            tlt.genusr        =  "til72"        And
            tlt.nor_noti_tlt  = trim(fi_search) no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .
                Apply "Entry"  to br_tlt.
                Return no-apply.            
    END.
    ELSE IF  cb_search  = "สาขา"  THEN DO:
        Open Query br_tlt                      
            For each tlt Use-index  tlt01 Where
            tlt.trndat         >=  fi_trndatfr    And 
            tlt.trndat         <=  fi_trndatto    And 
            tlt.genusr          =  "til72"        And 
            tlt.comp_usr_tlt    = trim(fi_search) no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .
                Apply "Entry"  to br_tlt.      
                Return no-apply.  
    END.
    ELSE If  cb_search  =  "เลขสติ๊กเกอร์"    Then do:        /* cedpol */  
        Open Query br_tlt                      
            For each tlt Use-index  tlt01   Where
            tlt.trndat   >=  fi_trndatfr    And 
            tlt.trndat   <=  fi_trndatto    And 
            tlt.genusr    =  "til72"        And 
            tlt.cha_no    = trim(fi_search) no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .
                Apply "Entry"  to br_tlt.      
                Return no-apply.               
    END. 
    ELSE If  cb_search  =  "เลขที่ใบเสร็จ"  Then do:        /* prepol */  
        Open Query br_tlt                      
            For each tlt Use-index  tlt01 Where
            tlt.trndat   >=  fi_trndatfr  And 
            tlt.trndat   <=  fi_trndatto  And 
            tlt.genusr    =  "til72"       And 
            tlt.safe2     = trim(fi_search)  no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .
                Apply "Entry"  to br_tlt.      
                Return no-apply.               
    END. 
    ELSE If  cb_search  =  "Release Yes" Then do:         /* not ..complete... */
        Open Query br_tlt                      
            For each tlt Use-index  tlt01      Where
            tlt.trndat         >=  fi_trndatfr And
            tlt.trndat         <=  fi_trndatto And
            tlt.genusr          =  "til72"     And
            tlt.releas          =  "Yes"       no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .
                Apply "Entry"  to br_tlt.
                Return no-apply.                             
    END.
    ELSE If  cb_search  =  "Release No"  Then do:         /* not ..complete... */
        Open Query br_tlt                      
            For each tlt Use-index  tlt01      Where
            tlt.trndat         >=  fi_trndatfr And
            tlt.trndat         <=  fi_trndatto And
            tlt.genusr          =  "til72"     And
            tlt.releas          =  "No"        no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .
                Apply "Entry"  to br_tlt.
                Return no-apply.                             
    END.
    ELSE If  cb_search  =  "Release cancel"  Then do:         /* not ..complete... */
        Open Query br_tlt                      
            For each tlt Use-index  tlt01      Where
            tlt.trndat         >=  fi_trndatfr And
            tlt.trndat         <=  fi_trndatto And
            tlt.genusr          =  "til72"     And
            tlt.releas          =  "Cancel"    no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .
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
    DISP ra_bydelete WITH FRAM fr_main.

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
    gv_prgid = "wgwqutp1".
    gv_prog  = "Query & Update DATA Detail By TIL Compulsary".
    RUN  WUT\WUTHEAD ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).
    ASSIGN 
        fi_loaddate = TODAY
        fi_trndatfr = TODAY
        fi_trndatto = TODAY
        fi_repolicyfr = "Policy Form" 
        fi_repolicyto = "Policy To"    
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
        ra_bydelete = 1 .
    RUN Open_tlt.
    Disp   ra_bydelete fi_loaddate cb_search cb_report fi_trndatfr  fi_trndatto   fi_report fi_repolicyfr fi_repolicyto   with frame fr_main.
    /*********************************************************************/ 
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
  DISPLAY ra_bydelete fi_loaddate fi_inputfile fi_trndatfr fi_trndatto fi_search 
          cb_report fi_repolicyfr_key fi_repolicyto_key fi_reportdata 
          fi_filename cb_search fi_report fi_datadelform fi_datadelto 
          fi_repolicyfr fi_repolicyto 
      WITH FRAME fr_main IN WINDOW c-wins.
  ENABLE ra_bydelete bu_delete fi_loaddate fi_inputfile fi_trndatfr fi_trndatto 
         fi_search bu_sch cb_report fi_repolicyfr_key fi_repolicyto_key 
         fi_reportdata fi_filename bu_reok bu_exit bu_file bu_imp bu_ok 
         cb_search fi_report br_tlt fi_datadelform fi_datadelto bu_update 
         bu_updatecan RECT-332 RECT-343 RECT-346 RECT-494 RECT-495 RECT-496 
         RECT-497 RECT-499 RECT-500 RECT-501 
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
        wdetail.branch       /*  2  สาขา           */                          
        wdetail.policy       /*  3  เลขกรมธรรม์    */                                  
        wdetail.stk          /*  4  เลขสติ๊กเกอร์  */                                  
        wdetail.docno        /*  5  เลขที่ใบเสร็จ  */                   
        wdetail.remark    .  /*  6  หมายเหตุ       */
END.
ASSIGN 
    nv_countdata     = 0
    nv_countnotcomp  = 0.
    nv_countcomplete = 0.
FOR EACH wdetail .
    IF      INDEX(wdetail.notifydate,"ลำดับที่") <> 0 THEN DELETE wdetail.
    ELSE IF       wdetail.notifydate   <> " "         THEN  DO:
        ASSIGN  nv_countdata = nv_countdata  + 1 .
        RUN proc_cutpolicy.
        IF substr(trim(wdetail.stk),1,1) <> "0"  THEN ASSIGN wdetail.stk  = "0" + TRIM(wdetail.stk).
        FIND FIRST tlt    WHERE 
            tlt.nor_noti_tlt   = trim(wdetail.policy)   AND 
            tlt.cha_no         = trim(wdetail.stk)      AND 
            tlt.genusr         = "til72"                NO-ERROR NO-WAIT .
        IF NOT AVAIL tlt THEN DO: 
            ASSIGN nv_countcomplete = nv_countcomplete + 1.
            CREATE tlt.
            ASSIGN
                tlt.entdat         = TODAY
                tlt.enttim         = STRING(TIME,"HH:MM:SS")
                tlt.trntime        = STRING(TIME,"HH:MM:SS")
                tlt.trndat         = fi_loaddate
                tlt.genusr         = "til72"               /* wdetail.Company   */ 
                tlt.nor_noti_tlt   = trim(wdetail.policy)  /* 3  เลขกรมธรรม์    */  
                tlt.cha_no         = trim(wdetail.stk)     /* 4  เลขสติ๊กเกอร์  */                           
                tlt.comp_usr_tlt   = trim(wdetail.branch)  /* 2  สาขา           */  
                tlt.safe2          = TRIM(wdetail.docno)   /* 5  เลขที่ใบเสร็จ  */ 
                tlt.filler2        = trim(wdetail.remark)  /* 6  หมายเหตุ       */ 
                tlt.endno          = USERID(LDBNAME(1))    /* User Load Data    */
                tlt.imp            = "IM"                  /* Import Data       */
                tlt.releas         = "No"   .
            DELETE wdetail.
        END.
        ELSE nv_countnotcomp = nv_countnotcomp + 1.
    END.
END.
/*RUN proc_reportnotcom.*/
Run Open_tlt.
Message "Load  Data Complete "  SKIP
    "จำนวนข้อมูลทั้งหมด:    "  nv_countdata      SKIP
    "จำนวนข้อมูลที่นำเข้า:  "  nv_countcomplete  SKIP
    "จำนวนข้อมูลที่ไม่สามารถนำเข้า:  "  nv_countnotcomp  View-as alert-box.  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Import_notificationkpi c-wins 
PROCEDURE Import_notificationkpi :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*
FOR EACH  wdetail :
    DELETE  wdetail.
END.
INPUT FROM VALUE(fi_filename2).
REPEAT:
    CREATE wdetail.
    IMPORT DELIMITER "|" 
        wdetail.number           /*  No.     */                                                        
        wdetail.Contract_No      /*  เลขที่สัญญาลูกค้า/ Contract No.*/                            
        wdetail.Ref_no           /*  Ref.NO.     */                                                    
        wdetail.comdat           /*  ระยะเวลาคุ้มครอง/Period Insured วันเริ่มต้น Start   */            
        wdetail.expdat           /*  วันสิ้นสุด Expiry   */                                        
        wdetail.ntitle           /*  ชื่อผู้เอาประกันภัย/The Insured name    คำนำหน้า/Title  */        
        wdetail.insurce          /*  ชื่อ/Name   */                                                
        wdetail.Surename         /*  นามสกุล/Surename    */                                        
        wdetail.Contact_Address  /*  ที่อยู่/Address ทีอยู่ที่ติดต่อได้/ Contact Address */            
        wdetail.Sub_District     /*  ตำบล/Sub District*/                                        
        wdetail.District         /*  อำเภอ/District*/                                            
        wdetail.Province         /*  จังหวัด/Province*/                                        
        wdetail.Postcode         /*  รหัสไปรษณีย์/Postcode*/                                    
        wdetail.Landmark         /*  สถานที่ใกล้เคียง/Landmark*/                                
        wdetail.Brand            /*  ยี่ห้อ/Brand      */                                            
        wdetail.nColor           /*  สี/Color          */                                                
        wdetail.model            /*  รุ่น/Model        */                                                
        wdetail.License          /*  ทะเบียน/License   */                                            
        wdetail.Li_Province      /*  จังหวัด/Province  */                                        
        wdetail.Chassis          /*  เลขตัวถัง/Chassis */                                        
        wdetail.Engine           /*  เลขเครื่อง/Engine */                                        
        wdetail.model_year       /*  รถปี/Model year   */                                            
        wdetail.cc               /*  กำลังเครื่องยนต์/C.C. */                                    
        wdetail.Weight           /*  น้ำหนัก/Weight        */                                            
        wdetail.finance_Comp     /*  บริษัท ไฟแนนซ์/Finance Comp. */                            
        wdetail.Insurance_Type   /*  ประเภทของสัญญาประกันภัย/Insurance Type */                    
        wdetail.Insured_Amount   /*  จำนวนเงินเอาประกันภัย/ Insured Amount  */                    
        wdetail.Voluntary        /*  ค่าเบี้ยประกันภัย/ Insurance Premium ประกันภัย/Voluntary */
        wdetail.Compulsory       /*  พรบ./Compulsory  */                                        
        wdetail.nTotal           /*  รวม/Total        */                                                
        wdetail.Request_Date     /*  วันแจ้งประกัน/Request Date */                                
        wdetail.companyins       /*  บริษัทประกันภย */                                            
        wdetail.policy72         /*  กรมธรรมุ้คุ้มครองผู้ประสบภัยจากรถ (พรบ.) เลขที่     */            
        wdetail.comdat72         /*  ระยะเวลาคุ้มครอง/Period Insured วันเริ่มต้น Start   */            
        wdetail.expdat72         /*  วันสิ้นสุด Expiry   */                                        
        wdetail.prepol           /*  กรมธรรม์เดิม        */                                            
        wdetail.notino           /*  เลขรับแจ้ง      */                                                
        wdetail.remark           /*  Remark      */                                                    
        wdetail.icno             /*  เลขบัตรประชาชน      */
        wdetail.sendContact_Addr /*  ที่อยู่จัดส่งเอกสาร     ทีอยู่ที่ติดต่อได้/ Contact Address */
        wdetail.sendSub_District /*  ตำบล/   Sub District  */
        wdetail.sendDistrict     /*  อำเภอ/  District      */
        wdetail.sendProvince     /*  จังหวัด/Province      */
        wdetail.sendPostcode.    /*  รหัสไปรษณีย์/Postcode */
END.
FOR EACH wdetail.
    IF index(wdetail.SEQ,"SEQ") <> 0    THEN DELETE wdetail.
    ELSE IF wdetail.SEQ         =  ""   THEN DELETE wdetail.
    /*ELSE RUN proc_cutpolicy.*/
END.*/
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
Open Query br_tlt  For each tlt  NO-LOCK
     WHERE tlt.trndat     =  TODAY   and
           tlt.genusr     =  "til72"  
    BY tlt.nor_noti_tlt   .
    ASSIGN nv_rectlt =  recid(tlt) .

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
Open Query br_tlt  For each tlt  NO-LOCK
    WHERE      tlt.trndat  >=   fi_trndatfr   And
               tlt.trndat  <=   fi_trndatto   And
               tlt.genusr   =   "til72"  
    BY tlt.nor_noti_tlt  .
    ASSIGN nv_rectlt =  recid(tlt) .

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_cutaddr c-wins 
PROCEDURE proc_cutaddr :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
    IF (R-INDEX(np_addr1,"กทม")  <> 0 ) THEN DO:
        ASSIGN np_addr4  =  trim(SUBSTR(np_addr1,R-INDEX(np_addr1,"กทม") - 1 ))
            np_addr1     =  trim(SUBSTR(np_addr1,1,R-INDEX(np_addr1,"กทม") - 1 )).

    END.
    ELSE IF (R-INDEX(np_addr1,"กรุง")  <> 0 )  THEN DO:
        ASSIGN np_addr4  =  trim(SUBSTR(np_addr1,R-INDEX(np_addr1,"กรุง") - 1 ))
            np_addr1     =  trim(SUBSTR(np_addr1,1,R-INDEX(np_addr1,"กรุง") - 1 )).
    END.
    ELSE IF (R-INDEX(np_addr1,"จ.")  <> 0 )  THEN DO:
        ASSIGN np_addr4  =  trim(SUBSTR(np_addr1,R-INDEX(np_addr1,"จ.") - 1 ))
            np_addr1     =  trim(SUBSTR(np_addr1,1,R-INDEX(np_addr1,"จ.") - 1 )).
    END.
    ELSE IF (R-INDEX(np_addr1,"จังหวัด")  <> 0 )  THEN DO:
        ASSIGN np_addr4  =  trim(SUBSTR(np_addr1,R-INDEX(np_addr1,"จังหวัด") - 1 ))
            np_addr1     =  trim(SUBSTR(np_addr1,1,R-INDEX(np_addr1,"จังหวัด") - 1 )).
    END.
    IF (R-INDEX(np_addr1,"เขต")  <> 0 )  THEN DO:
        ASSIGN np_addr3  =  trim(SUBSTR(np_addr1,R-INDEX(np_addr1,"เขต") - 1 ))
            np_addr1     =  trim(SUBSTR(np_addr1,1,R-INDEX(np_addr1,"เขต") - 1 )).
    END.
    IF (R-INDEX(np_addr1,"อำเภอ")  <> 0 )  THEN DO:
        ASSIGN np_addr3  =  trim(SUBSTR(np_addr1,R-INDEX(np_addr1,"อำเภอ") - 1 ))
            np_addr1     =  trim(SUBSTR(np_addr1,1,R-INDEX(np_addr1,"อำเภอ") - 1 )).
    END.
    IF (R-INDEX(np_addr1,"แขวง")  <> 0 )  THEN DO:
        ASSIGN np_addr2  =  trim(SUBSTR(np_addr1,R-INDEX(np_addr1,"แขวง") - 1 ))
            np_addr1     =  trim(SUBSTR(np_addr1,1,R-INDEX(np_addr1,"แขวง") - 1 )).
    END.
    IF (R-INDEX(np_addr1,"ตำบล")  <> 0 )  THEN DO:
        ASSIGN np_addr2  =  trim(SUBSTR(np_addr1,R-INDEX(np_addr1,"ตำบล") - 1 ))
            np_addr1     =  trim(SUBSTR(np_addr1,1,R-INDEX(np_addr1,"ตำบล") - 1 )).
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_ficomname1 c-wins 
PROCEDURE proc_ficomname1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH tlt Use-index  tlt01  Where
    tlt.trndat        >=   fi_trndatfr   And
    tlt.trndat        <=   fi_trndatto   And
    tlt.genusr   =  "aycal"               no-lock. 
    IF      (cb_report = "สาขา" ) AND (tlt.colorcod <> trim(fi_reportdata))           THEN NEXT.
    ELSE IF (cb_report = "ประเภทความคุ้มครอง") AND (tlt.safe3 <> trim(fi_reportdata)) THEN NEXT.
    ELSE IF (cb_report = "Complete" ) AND (index(tlt.OLD_eng,"not") = 0 )  THEN NEXT.
    ELSE IF (cb_report = "Not complete") AND (tlt.releas = "No" )          THEN NEXT.
    ELSE IF (cb_report = "Release Yes" ) AND (tlt.releas = "No" )          THEN NEXT.
    ELSE IF (cb_report = "Release No"  ) AND (tlt.releas = "Yes" )         THEN NEXT. 
    ASSIGN 
        n_record =  n_record + 1
        np_title = IF index(tlt.ins_name," ") <> 0 THEN SUBSTR(tlt.ins_name,1,index(tlt.ins_name," ") - 1 )  ELSE "คุณ"
        np_name  = IF index(tlt.ins_name," ") <> 0 THEN SUBSTR(tlt.ins_name,index(tlt.ins_name," ") + 1 ) ELSE tlt.ins_name
        np_name2 = IF index(np_name," ") <> 0 THEN SUBSTR(np_name,index(np_name," ") + 1 )   ELSE tlt.ins_name
        np_name  = IF index(np_name," ") <> 0 THEN SUBSTR(np_name,1,index(np_name," ") - 1 )  ELSE tlt.ins_name .  
    EXPORT DELIMITER "|" 
        n_record                                           /*  1  ลำดับที่     */             
        string(tlt.datesent,"99/99/9999") FORMAT "x(10)"   /*  2  วันที่แจ้ง   */            
        tlt.nor_noti_tlt               /*  3  เลขรับแจ้ง   */           
        caps(TRIM(tlt.comp_usr_tlt))   /*  4  Branch       */           
        trim(tlt.recac)                /*  5  Contract     */           
        trim(np_title)                 /*  6  คำนำหน้าชื่อ */           
        trim(np_name)                  /*  7  ชื่อ         */           
        trim(np_name2)                 /*  8  นามสกุล      */           
        trim(tlt.ins_addr1)               FORMAT "x(50)"                /*  9  ที่อยู่ 1    */           
        trim(tlt.ins_addr2)               FORMAT "x(40)"                /*  10 ที่อยู่ 2    */           
        trim(tlt.ins_addr3)               FORMAT "x(40)"                /*  11 ที่อยู่ 3    */           
        trim(tlt.ins_addr4) + " " + trim(tlt.ins_addr5) FORMAT "x(40)"  /*  12 ที่อยู่ 4    */           
        tlt.brand               /*  13 ยี่ห้อรถ     */           
        tlt.model               /*  14 รุ่นรถ       */           
        tlt.lince1              /*  15 เลขทะเบียน   */           
        tlt.lince2              /*  16 ปีรถ         */           
        tlt.cc_weight           /*  17 CC.          */           
        tlt.cha_no              /*  18 เลขตัวถัง    */           
        tlt.eng_no              /*  19 เลขเครื่อง   */           
        tlt.comp_noti_tlt       /*  20 Code ผู้แจ้ง */           
        tlt.safe3               /*  21 ประเภท       */           
        tlt.nor_usr_ins         /*  22 Code บ.ประกัน        */  
        tlt.nor_noti_ins        /*  23 เลขกรมธรรม์เดิม      */ 
        IF tlt.nor_effdat = ? THEN "" ELSE string(tlt.nor_effdat,"99/99/9999") FORMAT "x(10)" /*  24 วันคุ้มครองประกัน    */
        IF tlt.expodat    = ? THEN "" ELSE string(tlt.expodat,"99/99/9999") FORMAT "x(10)"    /*  25 วันหมดประกัน         */   
        tlt.comp_coamt         /*  26 ทุนประกัน    */           
        DECI(tlt.dri_name2)    /*  27 ค่าเบี้ยสุทธิ์ */         
        tlt.nor_grprm          /*  28 ค่าเบี้ยรวมภาษีอากร */    
        tlt.seqno              /*  29 Deduct       */           
        tlt.nor_usr_tlt        /*  30 Code บ.ประกัน พรบ.   */   
        IF tlt.comp_effdat  = ? THEN "" ELSE string(tlt.comp_effdat,"99/99/9999")  FORMAT "x(10)"  /*  31 วันคุ้มครองพรบ.*/   
        IF tlt.dat_ins_noti = ? THEN "" ELSE string(tlt.dat_ins_noti,"99/99/9999") FORMAT "x(10)"  /*  32 วันหมดพรบ.   */           
        deci(tlt.dri_no1)   /*  33 ค่าพรบ.      */           
        tlt.dri_name1       /*  34 ระบุผู้ขับขี่        */   
        tlt.stat            /*  35 ซ่อมห้าง     */           
        tlt.safe1           /*  36 คุ้มครองอุปกรณ์เพิ่มเติม*/
        tlt.filler1         /*  37 แก้ไขที่อยู่    */        
        tlt.comp_usr_ins    /*  38 ผู้รับผลประโยชน์ */       
        tlt.OLD_cha         /*  39 หมายเหตุ */               
        tlt.OLD_eng         /*  40 complete/not complete */  
        tlt.releas   .      /*  41 Yes/No . */ 
END.                  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_ficomname2 c-wins 
PROCEDURE proc_ficomname2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

FOR EACH tlt Use-index  tlt01  Where
    tlt.trndat        >=   fi_trndatfr   And
    tlt.trndat        <=   fi_trndatto   And
    tlt.lotno          =   n_comname   AND
    tlt.genusr         =  "phone"              no-lock.  
        /*IF (ra_report = 2) AND (index(tlt.OLD_eng,"not")  <> 0 )  THEN NEXT.
        ELSE IF (ra_report = 3) AND (index(tlt.OLD_eng,"not") = 0 )   THEN NEXT.
        ELSE IF (ra_report = 4) AND (tlt.releas        = "No" )       THEN NEXT.
        ELSE IF (ra_report = 5) AND (tlt.releas        = "Yes" )     THEN NEXT.*/
    IF      (cb_report = "สาขา" ) AND (tlt.colorcod <> trim(fi_reportdata))           THEN NEXT.
    ELSE IF (cb_report = "ประเภทความคุ้มครอง") AND (tlt.safe3 <> trim(fi_reportdata)) THEN NEXT.
    ELSE IF (cb_report = "Complete" ) AND (index(tlt.OLD_eng,"not") = 0 )  THEN NEXT.
    ELSE IF (cb_report = "Not complete") AND (tlt.releas = "No" )          THEN NEXT.
    /*ELSE IF (cb_report = "Release Yes" ) AND (tlt.releas = "Yes" )         THEN NEXT.
    ELSE IF (cb_report = "Release No"  ) AND (tlt.releas = "No" )          THEN NEXT. */
    ELSE IF (cb_report = "Release Yes" ) AND (tlt.releas = "No" )          THEN NEXT.
    ELSE IF (cb_report = "Release No"  ) AND (tlt.releas = "Yes")          THEN NEXT. 
    ASSIGN 
        n_record =  n_record + 1.
     /*   nv_cnt   =  nv_cnt  + 1 
        nv_row   =  nv_row  + 1.*/
    EXPORT DELIMITER "|" 
    n_record                                        /*"ลำดับที่"      */            
    string(tlt.trndat,"99/99/9999") FORMAT "x(10)"  /*"วันที่รับแจ้ง" */        
    string(tlt.trntime)             FORMAT "x(10)"  /*"เวลารับแจ้ง"   */         
    trim(tlt.nor_noti_tlt)          FORMAT "x(50)"  /*"เลขรับแจ้งงาน" */       
    trim(tlt.lotno)                 FORMAT "x(20)"  /*"รหัสบรษัท" */           
    trim(tlt.nor_usr_ins)           FORMAT "x(40)"  /*"ชื่อเจ้าหน้าที่ MKT"*/ 
    trim(tlt.nor_usr_tlt)           FORMAT "x(10)"  /*"รหัสสาขา"             */             
    trim(tlt.nor_noti_ins)          FORMAT "x(35)"  /*"Code: "               */                       
    trim(tlt.colorcod)              FORMAT "x(20)"  /*"รหัสสาขา_STY "*/               
    trim(tlt.comp_sub)              FORMAT "x(30)"  /*"Producer." */           
    trim(tlt.recac)                 FORMAT "x(30)"  /*"Agent." */              
    trim(tlt.subins)                FORMAT "x(30)"  /* "Campaign no." */ 
    tlt.safe1                                       /*"ประเภทประกัน"*/
    tlt.safe2                                       /*"ประเภทรถ"*/          
    tlt.safe3                                       /*"ประเภทความคุ้มครอง"*/
    tlt.stat
    tlt.filler1                                     /*"ประกัน แถม/ไม่แถม"*/ 
    tlt.filler2                                     /*"พรบ.   แถม/ไม่แถม"*/
    tlt.nor_effdat            /*"วันเริ่มคุ้มครอง"       */
    tlt.expodat               /*"วันสิ้นสุดความคุ้มครอง" */
    tlt.dri_no2               /*  A55-0046.....*/
    tlt.policy                /*"เลขกรมธรรม์70"*/    
    tlt.comp_pol              /*"เลขกรมธรรม์72"*/   
    substr(trim(tlt.ins_name),1,INDEX(trim(tlt.ins_name)," ") - 1 ) FORMAT "x(20)"       /*"คำนำหน้าชื่อ"*/     
    substr(trim(tlt.ins_name),INDEX(trim(tlt.ins_name)," ") + 1 )  FORMAT "x(35)"        /*"ชื่อผู้เอาประกัน"*/ 
    trim(tlt.endno)            /*id no */                                               
    IF tlt.dat_ins_noti = ? THEN "" ELSE trim(string(tlt.dat_ins_noti))  /*birth of date. */
    IF tlt.entdat = ?       THEN "" ELSE TRIM(STRING(tlt.entdat))        /*birth of date. */
    trim(tlt.flag)            /*occup */
    trim(tlt.usrsent)         /*Name drirect */
    trim(tlt.ins_addr1)       /*"บ้านเลขที่" */      
    trim(tlt.ins_addr2)       /*"ตำบล/แขวง" */
    trim(tlt.ins_addr3)       /*"อำเภอ/เขต"*/        
    trim(tlt.ins_addr4)       /*"จังหวัด" */
    trim(tlt.ins_addr5)       /*"รหัสไปรษณีย์"*/         
    tlt.comp_noti_ins         /*"เบอร์โทรศัพท์" */  
    IF tlt.dri_name1 = "" THEN "ไม่ระบุผู้ขับขี่" ELSE "ระบุผู้ขับขี่"
     /*drivname  "ผู้ขับขี่คนที่1"1*/    IF tlt.dri_name1 = "" THEN  "" ELSE SUBSTR(tlt.dri_name1,1,INDEX(tlt.dri_name1,"sex:") - 1 )
     /*sex       "เพศ"            1*/    IF tlt.dri_name1 = "" THEN  "" ELSE IF trim(substr(tlt.dri_name1,INDEX(tlt.dri_name1,"sex:") + 4,1)) =  "2" THEN "FEMALE" ELSE "MALE"
     /*birth day "วันเกิด"        1*/    IF tlt.dri_name1 = "" THEN  "" ELSE (SUBSTR(tlt.dri_name1,INDEX(tlt.dri_name1,"hbd:") + 4 ,10))
     /*occup     "อาชัพ"          1*/    IF tlt.dri_name1 = "" THEN  "" ELSE substr(tlt.dri_name1,INDEX(tlt.dri_name1,"occ:") + 4 )   
     /*id driv   "เลขที่ใบขับขี่" 1*/    IF tlt.dri_name1 = "" THEN  "" ELSE trim(tlt.dri_no1)
     /*drivname "ผู้ขับขี่คนที่2" 2*/    IF tlt.dri_name1 = "" THEN  "" ELSE  SUBSTR(tlt.enttim,1,INDEX(tlt.enttim,"sex:") - 1 )
     /*sex      "เพศ"             2*/    IF tlt.dri_name1 = "" THEN  "" ELSE IF trim(substr(tlt.enttim,INDEX(tlt.enttim,"sex:") + 4,1)) =  "2" THEN "FEMALE" ELSE "MALE"
     /*birth day"วันเกิด"         2*/    IF tlt.dri_name1 = "" THEN  "" ELSE (SUBSTR(tlt.enttim,INDEX(tlt.enttim,"hbd:") + 4 ,10)) 
     /*occup    "อาชัพ"           2*/    IF tlt.dri_name1 = "" THEN  "" ELSE substr(tlt.enttim,INDEX(tlt.enttim,"occ:") + 4 )   
     /*id driv  "เลขที่ใบขับขี่"  2*/    IF tlt.dri_name1 = "" THEN  "" ELSE trim(tlt.expotim)   

     /*/*drivname  "ผู้ขับขี่คนที่1"1*/    IF substr(tlt.dri_name1,1,INDEX(tlt.dri_name1,"sex:") - 1 ) = "" THEN "" ELSE SUBSTR(tlt.dri_name1,1,INDEX(tlt.dri_name1,"sex:") - 1 )
     /*sex       "เพศ"            1*/    IF trim(substr(tlt.dri_name1,INDEX(tlt.dri_name1,"sex:") + 4,1)) =  "2" THEN "FEMALE" ELSE "MALE"
     /*birth day "วันเกิด"        1*/    IF substr(tlt.dri_name1,1,INDEX(tlt.dri_name1,"sex:") - 1 ) = "" THEN "" ELSE (SUBSTR(tlt.dri_name1,INDEX(tlt.dri_name1,"hbd:") + 4 ,10))
     /*occup     "อาชัพ"          1*/    IF substr(tlt.dri_name1,1,INDEX(tlt.dri_name1,"sex:") - 1 ) = "" THEN "" ELSE substr(tlt.dri_name1,INDEX(tlt.dri_name1,"occ:") + 4 )   
     /*id driv   "เลขที่ใบขับขี่" 1*/    trim(tlt.dri_no1)
        
     /*drivname "ผู้ขับขี่คนที่2" 2*/    IF substr(tlt.enttim,1,INDEX(tlt.enttim,"sex:") - 1 ) = "" THEN "" ELSE SUBSTR(tlt.enttim,1,INDEX(tlt.enttim,"sex:") - 1 )
     /*sex      "เพศ"             2*/    IF trim(substr(tlt.enttim,INDEX(tlt.enttim,"sex:") + 4,1)) =  "2" THEN "FEMALE" ELSE "MALE"
     /*birth day"วันเกิด"         2*/    IF substr(tlt.enttim,1,INDEX(tlt.enttim,"sex:") - 1 ) = "" THEN "" ELSE (SUBSTR(tlt.enttim,INDEX(tlt.enttim,"hbd:") + 4 ,10)) 
     /*occup    "อาชัพ"           2*/    IF substr(tlt.enttim,1,INDEX(tlt.enttim,"sex:") - 1 ) = "" THEN "" ELSE substr(tlt.enttim,INDEX(tlt.enttim,"occ:") + 4 )   
     /*id driv  "เลขที่ใบขับขี่"  2*/    trim(tlt.expotim)  */
    tlt.brand                 /*"ชื่อยี่ห้อรถ"*/         
    tlt.model                 /*"รุ่นรถ" */              
    tlt.eng_no                /*"เลขเครื่องยนต์" */
    tlt.cha_no                /*"เลขตัวถัง" */           
    tlt.cc_weight             /*"ซีซี" */               
    tlt.lince2                /*"ปีรถยนต์"*/            
    /*substr(tlt.lince1,1,R-INDEX(tlt.lince1," ") - 1) FORMAT "x(7)"  /*"เลขทะเบียน"  */*//*A54-0112*/ 
    substr(tlt.lince1,1,R-INDEX(tlt.lince1," ") - 1) FORMAT "x(8)"  /*"เลขทะเบียน"  *//*A54-0112*/
    substr(tlt.lince1,R-INDEX(tlt.lince1," ") + 1) FORMAT "x(30)"    /*"จังหวัดที่จดทะเบียน"*/ 
    tlt.lince3                /*"แพคเกจ"*/
    tlt.exp                   /*"การซ่อม" */                                 
    tlt.nor_coamt             /*"ทุนประกัน"*/  
    tlt.dri_name2  FORMAT "x(30)"
    tlt.nor_grprm             /*"เบี้ยประกัน" */                             
    tlt.comp_coamt            /*"เบี้ยพรบ." */      
    tlt.comp_grprm            /*"เบี้ยรวม"*/        
    tlt.comp_sck              /*"เลขสติ๊กเกอร์" */  
    tlt.comp_noti_tlt         /*"เลขReferance no."*/
    tlt.rec_name              /*"ออกใบเสร็จในนาม"*/ 
    tlt.comp_usr_tlt          /*"Vatcode " */
    tlt.expousr               /*"ผู้รับแจ้ง"             */
    tlt.comp_usr_ins          /*"ผู้รับผลประโยชน์"       */
    tlt.OLD_cha               /*"หมายเหตุ"               */
    tlt.OLD_eng              /*"complete/not complete"  */ 
    tlt.releas. 
END.                   /*  end  wdetail  */
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
ASSIGN 
    n_record = 0
    nv_cnt   = 0
    nv_row   = 1  .
If  substr(fi_filename,length(fi_filename) - 3,4) <>  ".csv"  THEN 
    fi_filename  =  Trim(fi_filename) + ".csv"  .

ASSIGN nv_cnt  =  0
       nv_row  =  1.
OUTPUT TO VALUE(fi_filename). 
EXPORT DELIMITER "|" 
    "ข้อมูลกรมธรรม์/เลขสติ๊กเกอร์ TIL/TPIB" .
EXPORT DELIMITER "|" 
    "วันที่"  
    "สาขา "
    "เลขกรมธรรม์"
    "เลขสติ๊กเกอร์"
    "เลขที่ใบเสร็จ"
    "หมายเหตุ"
    "Status".
IF cb_report = "เลขกรมธรรม์"      THEN DO:
    FOR EACH tlt  NO-LOCK 
        WHERE tlt.nor_noti_tlt        >=   fi_repolicyfr_key   And
        tlt.nor_noti_tlt        <=   fi_repolicyto_key   And
        tlt.genusr   =  "til72"   
        BREAK BY tlt.nor_noti_tlt  .
        EXPORT DELIMITER "|" 
            tlt.trndat         /*  1  วันที่         */  
            tlt.comp_usr_tlt   /*  2  สาขา           */  
            tlt.nor_noti_tlt   /*  3  เลขกรมธรรม์    */  
            tlt.cha_no         /*  4  เลขสติ๊กเกอร์  */  
            tlt.safe2          /*  5  เลขที่ใบเสร็จ  */  
            tlt.filler2        /*  6  หมายเหตุ       */  
            tlt.releas   .    
    END. 
END.
ELSE DO:
    FOR EACH tlt Use-index  tlt01  Where
        tlt.trndat        >=   fi_trndatfr   And
        tlt.trndat        <=   fi_trndatto   And
        tlt.genusr   =  "til72"              no-lock. 
        IF      (cb_report = "สาขา" ) AND (tlt.colorcod <> trim(fi_reportdata))        THEN NEXT.
        ELSE IF (cb_report = "Release Yes" ) AND (index(tlt.releas,"yes") = 0 )        THEN NEXT.
        ELSE IF (cb_report = "Release No"  ) AND (index(tlt.releas,"no")  = 0 )        THEN NEXT. 
        ELSE IF (cb_report = "Release Cancel"  ) AND (index(tlt.releas,"Cancel") = 0 ) THEN NEXT. 
        EXPORT DELIMITER "|" 
            tlt.trndat         /*  1  วันที่         */  
            tlt.comp_usr_tlt   /*  2  สาขา           */  
            tlt.nor_noti_tlt   /*  3  เลขกรมธรรม์    */  
            tlt.cha_no         /*  4  เลขสติ๊กเกอร์  */  
            tlt.safe2          /*  5  เลขที่ใบเสร็จ  */  
            tlt.filler2        /*  6  หมายเหตุ       */  
            tlt.releas   .    
    END. 
END.
Message "Export data Complete"  View-as alert-box.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_report1 c-wins 
PROCEDURE proc_report1 :
/*------------------------------------------------------------------------------
Purpose:     
Parameters:  <none>
Notes:       
------------------------------------------------------------------------------*/
DEF VAR   nv_cnt   as  int  init   1.
DEF VAR   nv_row   as  int  init   0.
DEF VAR   n_record AS  INTE INIT   0.
ASSIGN 
    n_record = 0
    nv_cnt   = 0
    nv_row   = 1  .
If  substr(fi_filename,length(fi_filename) - 3,4) <>  ".csv"  THEN 
    fi_filename  =  Trim(fi_filename) + ".csv"  .

ASSIGN nv_cnt  =  0
       nv_row  =  1.
OUTPUT STREAM ns2 TO VALUE(fi_filename).
PUT STREAM ns2 "ID;PND" SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"' "บริษัทเงินทุน ธนาคารเกียรตินาคิน จำกัด (มหาชน) ."  '"' SKIP.
nv_row  =  nv_row + 1.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"   '"' "ลำดับที่"                           '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"   '"' "วันที่รับแจ้ง"                      '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"   '"' "วันที่รับเงินค่าเบิ้ยประกัน"         '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"   '"' "รายชื่อบริษัทประกันภัย"             '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"   '"' "เลขที่สัญญาเช่าซื้อ"                '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"   '"' "เลขที่กรมธรรม์เดิม"                 '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"   '"' "รหัสสาขา"                           '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"   '"' "สาขา KK"                            '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"   '"' "เลขรับเเจ้ง"                        '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K"  '"' "Campaign"                           '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K"  '"' "Sub Campaign"                       '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K"  '"' "บุคคล/นิติบุคคล"                    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K"  '"' "คำนำหน้าชื่อ"                       '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K"  '"' "ชื่อผู้เอาประกัน"                   '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K"  '"' "นามสกุลผู้เอาประกัน"                '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K"  '"' "บ้านเลขที่"                          '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K"  '"' "ตำบล/แขวง"                          '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K"  '"' "อำเภอ/เขต"                          '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K"  '"' "จังหวัด"                            '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K"  '"' "รหัสไปรษณีย์"                       '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K"  '"' "ประเภทความคุ้มครอง"                 '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K"  '"' "ประเภทการซ่อม"                      '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K"  '"' "วันเริ่มคุ้มครอง"                   '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K"  '"' "วันสิ้นสุดคุ้มครอง"                 '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K"  '"' "รหัสรถ"                             '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K"  '"' "ประเภทประกันภัยรถยนต์"              '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K"  '"' "ชื่อยี่ห้อรถ"                       '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K"  '"' "รุ่นรถ"                             '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K"  '"' "New/Used"                           '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K"  '"' "เลขทะเบียน"                         '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K"  '"' "เลขตัวถัง"                          '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K"  '"' "เลขเครื่องยนต์"                     '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K"  '"' "ปีรถยนต์"                           '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K"  '"' "ซีซี"                               '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K"  '"' "น้ำหนัก/ตัน"                        '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K"  '"' "ทุนประกันปี 1 "                      '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K"  '"' "เบี้ยรวมภาษีเเละอากรปี 1"           '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K"  '"' "ทุนประกันปี 2"                      '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X39;K"  '"' "เบี้ยรวมภาษีเเละอากรปี 2"           '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X40;K"  '"' "เวลารับเเจ้ง"                       '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X41;K"  '"' "ชื่อเจ้าหน้าที่ MKT"                '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X42;K"  '"' "หมายเหตุ"                           '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X43;K"  '"' "ผู้ขับขี่ที่ 1 เเละวันเกิด"         '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X44;K"  '"' "ผู้ขับขี่ที่ 2 เเละวันเกิด"         '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X45;K"  '"' "คำนำหน้าชื่อ (ใบเสร็จ/ใบกำกับภาษี)" '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X46;K"  '"' "ชื่อ (ใบเสร็จ/ใบกำกับภาษี)"         '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X47;K"  '"' "นามสกุล (ใบเสร็จ/ใบกำกับภาษี)"      '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X48;K"  '"' "บ้านเลขที่ (ใบเสร็จ/ใบกำกับภาษี)"   '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X49;K"  '"' "ตำบล/แขวง (ใบเสร็จ/ใบกำกับภาษี)"    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X50;K"  '"' "อำเภอ/เขต (ใบเสร็จ/ใบกำกับภาษี)"    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X51;K"  '"' "จังหวัด (ใบเสร็จ/ใบกำกับภาษี)"      '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X52;K"  '"' "รหัสไปรษณีย์ (ใบเสร็จ/ใบกำกับภาษี)" '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X53;K"  '"' "ส่วนลดประวัติดี"                    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X54;K"  '"' "ส่วนลดงาน Fleet"                    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X55;K"  '"' "Remak1"                             '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X56;K"  '"' "Remak2"                             '"' SKIP.

FOR EACH tlt Use-index  tlt01  Where
        tlt.trndat        >=   fi_trndatfr   And
        tlt.trndat        <=   fi_trndatto   And
        /*tlt.comp_noti_tlt >=   fi_polfr      And
        tlt.comp_noti_tlt <=   fi_polto      And*/
        tlt.genusr   =  "phone"                no-lock.  
    /*IF      (ra_report = 1) AND (tlt.lotno <> fi_comname ) THEN NEXT.
    ELSE IF (ra_report = 2) AND (index(tlt.OLD_eng,"not")  <> 0 ) THEN NEXT.
    ELSE IF (ra_report = 3) AND (index(tlt.OLD_eng,"not") = 0 )   THEN NEXT.*/
    ASSIGN 
        n_record =  n_record + 1
        nv_cnt   =  nv_cnt  + 1 
        nv_row   =  nv_row  + 1.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"' n_record                                            '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"' string(tlt.trndat,"99/99/9999")      FORMAT "x(10)" '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"' string(tlt.dat_ins_not,"99/99/9999") FORMAT "x(10)" '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"  '"' trim(tlt.nor_usr_ins)                FORMAT "x(50)" '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"' trim(tlt.nor_noti_tlt)               FORMAT "x(20)" '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"  '"' trim(tlt.nor_noti_ins)               FORMAT "x(20)" '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"  '"' trim(tlt.nor_usr_tlt)                FORMAT "x(10)" '"' SKIP.        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"  '"' trim(tlt.comp_usr_tl)                FORMAT "x(35)" '"' SKIP.                 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"  '"' trim(tlt.comp_noti_tlt)              FORMAT "x(20)" '"' SKIP.                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K" '"' trim(tlt.dri_no1)                    FORMAT "x(30)" '"' SKIP.      
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K" '"' trim(tlt.dri_no2)                    FORMAT "x(30)" '"' SKIP.      
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K" '"' trim(tlt.safe2)                      FORMAT "x(30)" '"' SKIP.      
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K" '"' substr(trim(tlt.ins_name),1,INDEX(trim(tlt.ins_name)," ") - 1 )         FORMAT "x(20)" '"' SKIP.                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K" '"' substr(trim(tlt.ins_name),INDEX(trim(tlt.ins_name)," ") + 1,r-INDEX(trim(tlt.ins_name)," ") - INDEX(trim(tlt.ins_name)," "))  FORMAT "x(35)" '"' SKIP.                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K" '"' substr(trim(tlt.ins_name),r-INDEX(trim(tlt.ins_name)," ") + 1 )         FORMAT "x(35)" '"' SKIP.                   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K" '"' trim(tlt.ins_addr1)                 FORMAT "x(80)" '"' SKIP.              
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K" '"' trim(tlt.ins_addr2)                 FORMAT "x(40)" '"' SKIP.                   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K" '"' trim(tlt.ins_addr3)                 FORMAT "x(40)" '"' SKIP.                   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K" '"' trim(tlt.ins_addr4)                 FORMAT "x(40)" '"' SKIP.                   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K" '"' trim(tlt.ins_addr5)                 FORMAT "x(15)" '"' SKIP.                 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K" '"' trim(tlt.safe3)                                    '"' SKIP.                 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K" '"' trim(tlt.stat)                      FORMAT "x(30)" '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K" '"' string(tlt.nor_effdat,"99/99/9999") FORMAT "x(10)" '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K" '"' string(tlt.expodat,"99/99/9999")    FORMAT "x(10)" '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K" '"' trim(tlt.subins)                    FORMAT "x(10)" '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K" '"' trim(tlt.filler2)                   FORMAT "x(40)" '"' SKIP.              
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K" '"' trim(tlt.brand)                     FORMAT "x(30)" '"' SKIP.              
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K" '"' trim(tlt.model)                     FORMAT "x(45)" '"' SKIP.              
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K" '"' trim(tlt.filler1)                   FORMAT "x(20)" '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K" '"' trim(tlt.lince1)                    FORMAT "x(30)" '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K" '"' trim(tlt.cha_no)                    FORMAT "x(30)" '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K" '"' trim(tlt.eng_no)                    FORMAT "x(30)" '"' SKIP.                 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K" '"' trim(tlt.lince2)                    FORMAT "x(10)" '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K" '"' string(tlt.cc_weight)               FORMAT "x(10)" '"' SKIP.               
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K" '"' trim(tlt.colorcod)                  FORMAT "x(10)" '"' SKIP.                 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K" '"' string(tlt.comp_coamt)              '"' SKIP.                                      
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K" '"' string(tlt.comp_grprm)              '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K" '"' string(tlt.nor_coamt)               '"' SKIP.                                     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X39;K" '"' string(tlt.nor_grprm)               '"' SKIP.                                      
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X40;K" '"' string(tlt.gentim)                  FORMAT "x(10)"     '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X41;K" '"' trim(tlt.comp_usr_in)               FORMAT "x(50)"     '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X42;K" '"' trim(tlt.safe1)                     FORMAT "x(100)"     '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X43;K" '"' trim(tlt.dri_name1)                 FORMAT "x(50)"     '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X44;K" '"' trim(tlt.dri_name2)                 FORMAT "x(50)"     '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X45;K" '"' trim(tlt.rec_name)             '"' SKIP.                            
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X46;K" '"' ""                             '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X47;K" '"' ""                             '"' SKIP.            
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X48;K" '"' trim(tlt.rec_addr1)            '"' SKIP.            
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X49;K" '"' trim(tlt.rec_addr2)            '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X50;K" '"' trim(tlt.rec_addr3)            '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X51;K" '"' trim(tlt.rec_addr4)            '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X52;K" '"' trim(tlt.rec_addr5)            '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X53;K" '"' string(tlt.seqno)              '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X54;K" '"' tlt.lotno                      '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X55;K" '"' trim(tlt.OLD_eng)       FORMAT "x(100)"  '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X56;K" '"' trim(tlt.OLD_cha)       FORMAT "x(100)"  '"' SKIP.
END.   /*  end  wdetail  */
nv_row  =  nv_row  + 1. 
PUT STREAM ns2 "E".

OUTPUT STREAM ns2 CLOSE.  

Message "Export data Complete"  View-as alert-box.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_reportfileerr c-wins 
PROCEDURE proc_reportfileerr :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*
FOR EACH wdetail NO-LOCK.
    EXPORT DELIMITER "|" 
        wdetail.Seqno         /*  1   Seq.    1   */                                  
        wdetail.Company       /*  2   Company AYCAL   */                          
        wdetail.Porduct       /*  3   Porduct HP  */                                  
        wdetail.Branch        /*  4   Branch  17  */                                  
        wdetail.Contract      /*  5   Contract    TU03590 */                   
        wdetail.nTITLE        /*  6   ชื่อ+นามสกุล    นาย */                                                   
        wdetail.name1         /*  7       สมชาย   */                     
        wdetail.name2         /*  8       พลไกร   */                     
        wdetail.addr1         /*  9   ที่อยู่ 17/2 ม.2    */                   
        wdetail.addr2         /*  10      ต.ขุนศรี อ.ไทรน้อย  */ 
        wdetail.addr3         /*  11      นนทบุรี */                                          
        wdetail.addr4         /*  12      11150   */                        
        wdetail.brand         /*  13  ยี่ห้อรถ    TOY */                          
        wdetail.model         /*  14  รุ่นรถ  FORTUNER TRD    */                  
        wdetail.coler         /*  15  สี  ขาว */                                          
        wdetail.vehreg        /*  16  เลขทะเบียน  ฎฉ 9525 */                      
        wdetail.provin        /*  17  จังหวัดที่จดทะเบียน กรุงเทพมหานคร   */      
        wdetail.caryear       /*  18  ปีรถ    2009    */                          
        wdetail.cc            /*  19  CC. 2982    */                              
        wdetail.chassis       /*  20  เลขตัวถัง   MR0YZ59G200090615   */          
        wdetail.engno         /*  21  เลขเครื่อง  1KD6400738  */                  
        wdetail.notifyno      /*  22  Code ผู้แจ้ง    1716    */                  
        wdetail.covcod        /*  23  ประเภท  1   */                              
        wdetail.Codecompany   /*  24  Code บ.ประกัน   KPI */                      
        wdetail.prepol        /*  25  เลขกรมธรรม์เดิม DM7055023011    */          
        wdetail.comdat70      /*  26  วันคุ้มครองประกัน   561019  */              
        wdetail.expdat70      /*  27  วันหมดประกัน    571019  */                      
        wdetail.si            /*  28  ทุนประกัน   38000000    */                  
        wdetail.premt         /*  29  ค่าเบี้ยสุทธิ์  1505151 */                  
        wdetail.premtnet      /*  30  ค่าเบี้ยรวมภาษีอากร 1616884 */ 
        wdetail.other         /*  31      539000  */                                                             
        wdetail.renew         /*  32  ปีประกัน    5   */                                       
        wdetail.policy        /*  33  เลขรับแจ้ง  STAY13-0349 */        
        wdetail.idno          /*  34  เลขบัตรประชาชน */                                                                   
        wdetail.remak         /*  35  หมายเหตุ. */                                                                               
        wdetail.notifydate    /*  36  วันที่แจ้ง  560821  */                                              
        wdetail.Deduct        /*  37  Deduct */                                                          
        wdetail.Codecompa72   /*  38  Code บ.ประกัน พรบ. */                                                  
        wdetail.comdat72      /*  39  วันคุ้มครองพรบ.*/                                                          
        wdetail.expdat72      /*  40  วันหมดพรบ. */                                                      
        wdetail.comp          /*  41  ค่าพรบ.*/                                                              
        wdetail.driverno      /*  42  ระบุผู้ขับขี่ */                                             
        wdetail.garage        /*  43  ซ่อมห้าง */                                                      
        wdetail.access        /*  44  คุ้มครองอุปกรณ์เพิ่มเติม */
        wdetail.endoresadd .  /*  45  แก้ไขที่อยู่  */
END. */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_reportmat1 c-wins 
PROCEDURE proc_reportmat1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*
ASSIGN 
    nv_countdata     = 0
    nv_countcomplete = 0 
    n_record         = 0.
FOR EACH wdetail WHERE wdetail.policy  <> "" .
    ASSIGN fi_process2 =  "Process data match Aycal/KPI : " + wdetail.policy .
    DISP fi_process2 WITH FRAM fr_main.  
    ASSIGN nv_countdata     = nv_countdata  + 1 .
    FIND LAST tlt   Where
        tlt.nor_noti_tlt   = trim(wdetail.policy)   AND 
        tlt.genusr   =  "aycal"               NO-LOCK NO-ERROR . 
    IF NOT AVAIL tlt THEN  DELETE wdetail.
END.
 

RUN proc_reporttitle.*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_reportmat11 c-wins 
PROCEDURE proc_reportmat11 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*
ASSIGN 
    nv_countdata     = 0
    nv_countcomplete = 0 
    n_record         = 0.
FOR EACH wdetail  NO-LOCK .
    ASSIGN nv_countdata     = nv_countdata  + 1 .
    FIND LAST tlt   Where
        tlt.nor_noti_tlt   = trim(wdetail.policy)   AND 
        tlt.genusr   =  "aycal"               NO-LOCK NO-ERROR . 
    IF AVAIL tlt THEN DO:
        ASSIGN 
            nv_countcomplete = nv_countcomplete + 1 
        n_record =  n_record + 1 
        np_title = IF index(tlt.ins_name," ") <> 0 THEN SUBSTR(tlt.ins_name,1,index(tlt.ins_name," ") - 1 )  ELSE "คุณ"
        np_name  = IF index(tlt.ins_name," ") <> 0 THEN SUBSTR(tlt.ins_name,index(tlt.ins_name," ") + 1 ) ELSE tlt.ins_name
        np_name2 = IF index(np_name," ") <> 0 THEN SUBSTR(np_name,index(np_name," ") + 1 )   ELSE tlt.ins_name
        np_name  = IF index(np_name," ") <> 0 THEN SUBSTR(np_name,1,index(np_name," ") - 1 )  ELSE tlt.ins_name.
        
        EXPORT DELIMITER "|" 
            n_record                                           /*  1  ลำดับที่     */             
            string(tlt.datesent,"99/99/9999") FORMAT "x(10)"   /*  2  วันที่แจ้ง   */            
            tlt.nor_noti_tlt               /*  3  เลขรับแจ้ง   */           
            caps(TRIM(tlt.comp_usr_tlt))   /*  4  Branch       */           
            trim(tlt.recac)                /*  5  Contract     */           
            trim(np_title)                 /*  6  คำนำหน้าชื่อ */           
            trim(np_name)                  /*  7  ชื่อ         */           
            trim(np_name2)                 /*  8  นามสกุล      */           
            trim(tlt.ins_addr1)               FORMAT "x(50)"                /*  9  ที่อยู่ 1    */           
            trim(tlt.ins_addr2)               FORMAT "x(40)"                /*  10 ที่อยู่ 2    */           
            trim(tlt.ins_addr3)               FORMAT "x(40)"                /*  11 ที่อยู่ 3    */           
            trim(tlt.ins_addr4) + " " + trim(tlt.ins_addr5) FORMAT "x(40)"  /*  12 ที่อยู่ 4    */           
            tlt.brand               /*  13 ยี่ห้อรถ     */           
            tlt.model               /*  14 รุ่นรถ       */           
            tlt.lince1              /*  15 เลขทะเบียน   */           
            tlt.lince2              /*  16 ปีรถ         */           
            tlt.cc_weight           /*  17 CC.          */           
            tlt.cha_no              /*  18 เลขตัวถัง    */           
            tlt.eng_no              /*  19 เลขเครื่อง   */           
            tlt.comp_noti_tlt       /*  20 Code ผู้แจ้ง */           
            tlt.safe3               /*  21 ประเภท       */           
            tlt.nor_usr_ins         /*  22 Code บ.ประกัน        */  
            tlt.nor_noti_ins        /*  23 เลขกรมธรรม์เดิม      */ 
            tlt.safe2
            IF tlt.nor_effdat = ? THEN "" ELSE string(tlt.nor_effdat,"99/99/9999") FORMAT "x(10)" /*  24 วันคุ้มครองประกัน    */
            IF tlt.expodat = ? THEN "" ELSE string(tlt.expodat,"99/99/9999") FORMAT "x(10)"    /*  25 วันหมดประกัน         */   
            tlt.comp_coamt         /*  26 ทุนประกัน    */           
            DECI(tlt.dri_name2)    /*  27 ค่าเบี้ยสุทธิ์ */         
            tlt.nor_grprm          /*  28 ค่าเบี้ยรวมภาษีอากร */    
            tlt.seqno              /*  29 Deduct       */           
            tlt.nor_usr_tlt        /*  30 Code บ.ประกัน พรบ.   */   
            IF tlt.comp_effdat = ? THEN "" ELSE string(tlt.comp_effdat,"99/99/9999")  FORMAT "x(10)"  /*  31 วันคุ้มครองพรบ.*/   
            IF tlt.dat_ins_noti = ? THEN "" ELSE string(tlt.dat_ins_noti,"99/99/9999") FORMAT "x(10)"  /*  32 วันหมดพรบ.   */           
            deci(tlt.dri_no1)   /*  33 ค่าพรบ.      */           
            tlt.dri_name1       /*  34 ระบุผู้ขับขี่        */   
            tlt.stat            /*  35 ซ่อมห้าง     */           
            tlt.safe1           /*  36 คุ้มครองอุปกรณ์เพิ่มเติม*/
            tlt.filler1         /*  37 แก้ไขที่อยู่    */        
            tlt.comp_usr_ins    /*  38 ผู้รับผลประโยชน์ */       
            tlt.OLD_cha         /*  39 หมายเหตุ */               
            tlt.OLD_eng         /*  40 complete/not complete */  
            tlt.releas         /*  41 Yes/No . */ 
            wdetail.premtnet      /*  เบี้ยรวม    */
            wdetail.recivedat.    /*  ชำระล่าสุด  */
    END.
END.*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_reportmat2 c-wins 
PROCEDURE proc_reportmat2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*
ASSIGN 
    nv_countdata     = 0
    nv_countcomplete = 0 
    n_record         = 0.
FOR EACH wdetail WHERE wdetail.policy  <> "" .
    ASSIGN fi_process2 =  "Process data match Aycal/KPI : " + wdetail.policy .
    DISP fi_process2 WITH FRAM fr_main.  
    ASSIGN nv_countdata     = nv_countdata  + 1 .
    FIND LAST tlt   Where
        tlt.recac    = trim(wdetail.Contract)  AND 
        tlt.genusr   =  "aycal72"               NO-LOCK NO-ERROR . 
    IF NOT AVAIL tlt THEN  DELETE wdetail.
END.
RUN proc_reporttitle.*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_reportmat22 c-wins 
PROCEDURE proc_reportmat22 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*
ASSIGN 
    nv_countdata     = 0
    nv_countcomplete = 0 
    n_record         = 0.
FOR EACH wdetail  NO-LOCK .
    ASSIGN nv_countdata     = nv_countdata  + 1 .

    FIND LAST tlt   Where
        tlt.recac    = trim(wdetail.Contract)  AND 
        tlt.genusr   =  "aycal"               NO-LOCK NO-ERROR . 
    IF AVAIL tlt THEN DO:
        ASSIGN nv_countcomplete = nv_countcomplete + 1
        n_record =  n_record + 1 
        np_title = IF index(tlt.ins_name," ") <> 0 THEN SUBSTR(tlt.ins_name,1,index(tlt.ins_name," ") - 1 )  ELSE "คุณ"
        np_name  = IF index(tlt.ins_name," ") <> 0 THEN SUBSTR(tlt.ins_name,index(tlt.ins_name," ") + 1 ) ELSE tlt.ins_name
        np_name2 = IF index(np_name," ") <> 0 THEN SUBSTR(np_name,index(np_name," ") + 1 )   ELSE tlt.ins_name
        np_name  = IF index(np_name," ") <> 0 THEN SUBSTR(np_name,1,index(np_name," ") - 1 )  ELSE tlt.ins_name.
        
        EXPORT DELIMITER "|" 
            n_record                                           /*  1  ลำดับที่     */             
            string(tlt.datesent,"99/99/9999") FORMAT "x(10)"   /*  2  วันที่แจ้ง   */            
            tlt.nor_noti_tlt               /*  3  เลขรับแจ้ง   */           
            caps(TRIM(tlt.comp_usr_tlt))   /*  4  Branch       */           
            trim(tlt.recac)                /*  5  Contract     */           
            trim(np_title)                 /*  6  คำนำหน้าชื่อ */           
            trim(np_name)                  /*  7  ชื่อ         */           
            trim(np_name2)                 /*  8  นามสกุล      */           
            trim(tlt.ins_addr1)               FORMAT "x(50)"                /*  9  ที่อยู่ 1    */           
            trim(tlt.ins_addr2)               FORMAT "x(40)"                /*  10 ที่อยู่ 2    */           
            trim(tlt.ins_addr3)               FORMAT "x(40)"                /*  11 ที่อยู่ 3    */           
            trim(tlt.ins_addr4) + " " + trim(tlt.ins_addr5) FORMAT "x(40)"  /*  12 ที่อยู่ 4    */           
            tlt.brand               /*  13 ยี่ห้อรถ     */           
            tlt.model               /*  14 รุ่นรถ       */           
            tlt.lince1              /*  15 เลขทะเบียน   */           
            tlt.lince2              /*  16 ปีรถ         */           
            tlt.cc_weight           /*  17 CC.          */           
            tlt.cha_no              /*  18 เลขตัวถัง    */           
            tlt.eng_no              /*  19 เลขเครื่อง   */           
            tlt.comp_noti_tlt       /*  20 Code ผู้แจ้ง */           
            tlt.safe3               /*  21 ประเภท       */           
            tlt.nor_usr_ins         /*  22 Code บ.ประกัน        */  
            tlt.nor_noti_ins        /*  23 เลขกรมธรรม์เดิม      */ 
            tlt.safe2
            IF tlt.nor_effdat = ? THEN "" ELSE string(tlt.nor_effdat,"99/99/9999") FORMAT "x(10)" /*  24 วันคุ้มครองประกัน    */
            IF tlt.expodat = ? THEN "" ELSE string(tlt.expodat,"99/99/9999") FORMAT "x(10)"    /*  25 วันหมดประกัน         */   
            tlt.comp_coamt         /*  26 ทุนประกัน    */           
            DECI(tlt.dri_name2)    /*  27 ค่าเบี้ยสุทธิ์ */         
            tlt.nor_grprm          /*  28 ค่าเบี้ยรวมภาษีอากร */    
            tlt.seqno              /*  29 Deduct       */           
            tlt.nor_usr_tlt        /*  30 Code บ.ประกัน พรบ.   */   
            IF tlt.comp_effdat = ? THEN "" ELSE string(tlt.comp_effdat,"99/99/9999")  FORMAT "x(10)"  /*  31 วันคุ้มครองพรบ.*/   
            IF tlt.dat_ins_noti = ? THEN "" ELSE string(tlt.dat_ins_noti,"99/99/9999") FORMAT "x(10)"  /*  32 วันหมดพรบ.   */           
            deci(tlt.dri_no1)   /*  33 ค่าพรบ.      */           
            tlt.dri_name1       /*  34 ระบุผู้ขับขี่        */   
            tlt.stat            /*  35 ซ่อมห้าง     */           
            tlt.safe1           /*  36 คุ้มครองอุปกรณ์เพิ่มเติม*/
            tlt.filler1         /*  37 แก้ไขที่อยู่    */        
            tlt.comp_usr_ins    /*  38 ผู้รับผลประโยชน์ */       
            tlt.OLD_cha         /*  39 หมายเหตุ */               
            tlt.OLD_eng         /*  40 complete/not complete */  
            tlt.releas          /*  41 Yes/No . */ 
            wdetail.premtnet      /*  เบี้ยรวม    */
            wdetail.recivedat.    /*  ชำระล่าสุด  */
    END.
END.*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_reportmat3 c-wins 
PROCEDURE proc_reportmat3 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*
ASSIGN 
    nv_countdata     = 0
    nv_countcomplete = 0 
    n_record         = 0.
FOR EACH wdetail WHERE wdetail.policy  <> "" .
    ASSIGN fi_process2 =  "Process data match Aycal/KPI : " + wdetail.policy .
    DISP fi_process2 WITH FRAM fr_main.  
    ASSIGN nv_countdata     = nv_countdata  + 1 .
    FIND LAST tlt   Where
        tlt.lince1   = trim(wdetail.vehreg) + " " +  trim(wdetail.provin) AND 
        tlt.genusr   =  "aycal"               NO-LOCK NO-ERROR . 
    IF NOT AVAIL tlt THEN  DELETE wdetail.
END.
RUN proc_reporttitle.
*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_reportmat33 c-wins 
PROCEDURE proc_reportmat33 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*
ASSIGN 
    nv_countdata     = 0
    nv_countcomplete = 0 
    n_record         = 0.
FOR EACH wdetail  NO-LOCK .
    ASSIGN nv_countdata     = nv_countdata  + 1 .

    FIND LAST tlt   Where
        tlt.lince1         = trim(wdetail.vehreg) + " " +  trim(wdetail.provin) AND 
        tlt.genusr   =  "aycal"               NO-LOCK NO-ERROR . 
    IF AVAIL tlt THEN DO:
        ASSIGN nv_countcomplete = nv_countcomplete + 1
        n_record =  n_record + 1 
        np_title = IF index(tlt.ins_name," ") <> 0 THEN SUBSTR(tlt.ins_name,1,index(tlt.ins_name," ") - 1 )  ELSE "คุณ"
        np_name  = IF index(tlt.ins_name," ") <> 0 THEN SUBSTR(tlt.ins_name,index(tlt.ins_name," ") + 1 ) ELSE tlt.ins_name
        np_name2 = IF index(np_name," ") <> 0 THEN SUBSTR(np_name,index(np_name," ") + 1 )   ELSE tlt.ins_name
        np_name  = IF index(np_name," ") <> 0 THEN SUBSTR(np_name,1,index(np_name," ") - 1 )  ELSE tlt.ins_name.
        
        EXPORT DELIMITER "|" 
            n_record                                           /*  1  ลำดับที่     */             
            string(tlt.datesent,"99/99/9999") FORMAT "x(10)"   /*  2  วันที่แจ้ง   */            
            tlt.nor_noti_tlt               /*  3  เลขรับแจ้ง   */           
            caps(TRIM(tlt.comp_usr_tlt))   /*  4  Branch       */           
            trim(tlt.recac)                /*  5  Contract     */           
            trim(np_title)                 /*  6  คำนำหน้าชื่อ */           
            trim(np_name)                  /*  7  ชื่อ         */           
            trim(np_name2)                 /*  8  นามสกุล      */           
            trim(tlt.ins_addr1)               FORMAT "x(50)"                /*  9  ที่อยู่ 1    */           
            trim(tlt.ins_addr2)               FORMAT "x(40)"                /*  10 ที่อยู่ 2    */           
            trim(tlt.ins_addr3)               FORMAT "x(40)"                /*  11 ที่อยู่ 3    */           
            trim(tlt.ins_addr4) + " " + trim(tlt.ins_addr5) FORMAT "x(40)"  /*  12 ที่อยู่ 4    */           
            tlt.brand               /*  13 ยี่ห้อรถ     */           
            tlt.model               /*  14 รุ่นรถ       */           
            tlt.lince1              /*  15 เลขทะเบียน   */           
            tlt.lince2              /*  16 ปีรถ         */           
            tlt.cc_weight           /*  17 CC.          */           
            tlt.cha_no              /*  18 เลขตัวถัง    */           
            tlt.eng_no              /*  19 เลขเครื่อง   */           
            tlt.comp_noti_tlt       /*  20 Code ผู้แจ้ง */           
            tlt.safe3               /*  21 ประเภท       */           
            tlt.nor_usr_ins         /*  22 Code บ.ประกัน        */  
            tlt.nor_noti_ins        /*  23 เลขกรมธรรม์เดิม      */ 
            tlt.safe2
            IF tlt.nor_effdat = ? THEN "" ELSE string(tlt.nor_effdat,"99/99/9999") FORMAT "x(10)" /*  24 วันคุ้มครองประกัน    */
            IF tlt.expodat = ? THEN "" ELSE string(tlt.expodat,"99/99/9999") FORMAT "x(10)"    /*  25 วันหมดประกัน         */   
            tlt.comp_coamt         /*  26 ทุนประกัน    */           
            DECI(tlt.dri_name2)    /*  27 ค่าเบี้ยสุทธิ์ */         
            tlt.nor_grprm          /*  28 ค่าเบี้ยรวมภาษีอากร */    
            tlt.seqno              /*  29 Deduct       */           
            tlt.nor_usr_tlt        /*  30 Code บ.ประกัน พรบ.   */   
            IF tlt.comp_effdat = ? THEN "" ELSE string(tlt.comp_effdat,"99/99/9999")  FORMAT "x(10)"  /*  31 วันคุ้มครองพรบ.*/   
            IF tlt.dat_ins_noti = ? THEN "" ELSE string(tlt.dat_ins_noti,"99/99/9999") FORMAT "x(10)"  /*  32 วันหมดพรบ.   */           
            deci(tlt.dri_no1)   /*  33 ค่าพรบ.      */           
            tlt.dri_name1       /*  34 ระบุผู้ขับขี่        */   
            tlt.stat            /*  35 ซ่อมห้าง     */           
            tlt.safe1           /*  36 คุ้มครองอุปกรณ์เพิ่มเติม*/
            tlt.filler1         /*  37 แก้ไขที่อยู่    */        
            tlt.comp_usr_ins    /*  38 ผู้รับผลประโยชน์ */       
            tlt.OLD_cha         /*  39 หมายเหตุ */               
            tlt.OLD_eng         /*  40 complete/not complete */  
            tlt.releas         /*  41 Yes/No . */ 
            wdetail.premtnet      /*  เบี้ยรวม    */
            wdetail.recivedat.    /*  ชำระล่าสุด  */
    END.
END.*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_reportmat4 c-wins 
PROCEDURE proc_reportmat4 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*
ASSIGN 
    nv_countdata     = 0
    nv_countcomplete = 0 
    n_record         = 0.
FOR EACH wdetail WHERE wdetail.SEQ  <> "" .
    ASSIGN fi_process2 =  "Process data match TIL-Stkno. : " + wdetail.policy .
    DISP fi_process2 WITH FRAM fr_main.  
    ASSIGN nv_countdata     = nv_countdata  + 1
        /*wdetail.STICKERNO   = IF SUBSTR(wdetail.STICKERNO,1,1) = "0" THEN wdetail.STICKERNO ELSE "0" + wdetail.STICKERNO */  .
    FIND LAST tlt  USE-INDEX tlt06 Where
        tlt.cha_no   = trim(wdetail.STICKERNO)   AND 
        tlt.genusr   =  "til72"                  NO-LOCK NO-ERROR . 
    IF NOT AVAIL tlt THEN  DELETE wdetail.
    ELSE ASSIGN wdetail.policy = trim(tlt.nor_noti_tlt)
                wdetail.branch = TRIM(tlt.comp_usr_tlt).
END.
RUN proc_reporttitle. */
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_reportmat44 c-wins 
PROCEDURE proc_reportmat44 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*
ASSIGN 
    nv_countdata     = 0
    nv_countcomplete = 0 
    n_record         = 0.
FOR EACH wdetail  NO-LOCK .
    ASSIGN nv_countdata     = nv_countdata  + 1 .
    /*FIND LAST tlt   Where
        tlt.cha_no   = trim(wdetail.stk)  AND 
        tlt.genusr   =  "aycal72"               NO-LOCK NO-ERROR . 
    IF AVAIL tlt THEN DO:
        ASSIGN nv_countcomplete = nv_countcomplete + 1
        n_record =  n_record + 1 
        np_title = IF index(tlt.ins_name," ") <> 0 THEN SUBSTR(tlt.ins_name,1,index(tlt.ins_name," ") - 1 )  ELSE "คุณ"
        np_name  = IF index(tlt.ins_name," ") <> 0 THEN SUBSTR(tlt.ins_name,index(tlt.ins_name," ") + 1 ) ELSE tlt.ins_name
        np_name2 = IF index(np_name," ") <> 0 THEN SUBSTR(np_name,index(np_name," ") + 1 )   ELSE tlt.ins_name
        np_name  = IF index(np_name," ") <> 0 THEN SUBSTR(np_name,1,index(np_name," ") - 1 )  ELSE tlt.ins_name.
        */
        EXPORT DELIMITER "|" 
            wdetail.SEQ            /*  1   SEQ             */              
            wdetail.INSURANCECODE  /*  2   INSURANCECODE   */  
            wdetail.CONTRACTNO     /*  3   CONTRACTNO      */      
            wdetail.BRANCHCODE     /*  4   BRANCHCODE      */      
            wdetail.BRANCHNO       /*  5   BRANCHNO        */      
            wdetail.policy
            wdetail.branch
            wdetail.STICKERNO      /*  6   STICKERNO       */      
            wdetail.CUSTOMERNAME   /*  7   CUSTOMERNAME    */      
            wdetail.ADDRESS        /*  8   ADDRESS         */           
            wdetail.CARNO          /*  9   CARNO           */              
            wdetail.BRAND          /*  10  BRAND           */          
            wdetail.MODEL          /*  11  MODEL           */          
            wdetail.CC             /*  12  CC              */              
            wdetail.REGISTRATION   /*  13  REGISTRATION    */  
            wdetail.PROVINCE       /*  14  PROVINCE        */      
            wdetail.BODY           /*  15  BODY            */          
            wdetail.ENGINE         /*  16  ENGINE          */          
            wdetail.STARTDATE      /*  17  STARTDATE       */      
            wdetail.ENDDATE        /*  18  ENDDATE         */          
            wdetail.NETINCOME      /*  19  NETINCOME       */      
            wdetail.TOTALINCOME    /*  20  TOTALINCOME     */      
            wdetail.CARDID   .     /*  21  CARDID          */ 
     
END.
*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_reportmat5 c-wins 
PROCEDURE proc_reportmat5 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*
ASSIGN 
    nv_countdata     = 0
    nv_countcomplete = 0 
    n_record         = 0.
FOR EACH wdetail WHERE wdetail.policy  <> "" .
    ASSIGN fi_process2 =  "Process data match Aycal/KPI : " + wdetail.policy .
    DISP fi_process2 WITH FRAM fr_main.  
    ASSIGN nv_countdata     = nv_countdata  + 1 .
    FIND LAST tlt   Where
       (tlt.recac        = trim(wdetail.Contract)  OR
        tlt.nor_noti_tlt = trim(wdetail.policy)    OR
        tlt.lince1       = trim(wdetail.vehreg) + " " +  trim(wdetail.provin) OR
        tlt.cha_no       = trim(wdetail.chassis)  ) AND 
        tlt.genusr   =  "aycal"               NO-LOCK NO-ERROR . 
    IF NOT AVAIL tlt THEN  DELETE wdetail.
END.
RUN proc_reporttitle.
*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_reportmat55 c-wins 
PROCEDURE proc_reportmat55 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*
ASSIGN 
    nv_countdata     = 0
    nv_countcomplete = 0 
    n_record         = 0.
FOR EACH wdetail  NO-LOCK .
    ASSIGN nv_countdata     = nv_countdata  + 1 .
    FIND LAST tlt   Where
       (tlt.recac        = trim(wdetail.Contract)  OR
        tlt.nor_noti_tlt = trim(wdetail.policy)    OR
        tlt.lince1       = trim(wdetail.vehreg) + " " +  trim(wdetail.provin) OR
        tlt.cha_no       = trim(wdetail.chassis)  ) AND 
        tlt.genusr   =  "aycal"               NO-LOCK NO-ERROR . 
    IF AVAIL tlt THEN DO:
        ASSIGN nv_countcomplete = nv_countcomplete + 1
        n_record =  n_record + 1 
        np_title = IF index(tlt.ins_name," ") <> 0 THEN SUBSTR(tlt.ins_name,1,index(tlt.ins_name," ") - 1 )  ELSE "คุณ"
        np_name  = IF index(tlt.ins_name," ") <> 0 THEN SUBSTR(tlt.ins_name,index(tlt.ins_name," ") + 1 ) ELSE tlt.ins_name
        np_name2 = IF index(np_name," ") <> 0 THEN SUBSTR(np_name,index(np_name," ") + 1 )   ELSE tlt.ins_name
        np_name  = IF index(np_name," ") <> 0 THEN SUBSTR(np_name,1,index(np_name," ") - 1 )  ELSE tlt.ins_name.
        
        EXPORT DELIMITER "|" 
            n_record                                           /*  1  ลำดับที่     */             
            string(tlt.datesent,"99/99/9999") FORMAT "x(10)"   /*  2  วันที่แจ้ง   */            
            tlt.nor_noti_tlt               /*  3  เลขรับแจ้ง   */           
            caps(TRIM(tlt.comp_usr_tlt))   /*  4  Branch       */           
            trim(tlt.recac)                /*  5  Contract     */           
            trim(np_title)                 /*  6  คำนำหน้าชื่อ */           
            trim(np_name)                  /*  7  ชื่อ         */           
            trim(np_name2)                 /*  8  นามสกุล      */           
            trim(tlt.ins_addr1)               FORMAT "x(50)"                /*  9  ที่อยู่ 1    */           
            trim(tlt.ins_addr2)               FORMAT "x(40)"                /*  10 ที่อยู่ 2    */           
            trim(tlt.ins_addr3)               FORMAT "x(40)"                /*  11 ที่อยู่ 3    */           
            trim(tlt.ins_addr4) + " " + trim(tlt.ins_addr5) FORMAT "x(40)"  /*  12 ที่อยู่ 4    */           
            tlt.brand               /*  13 ยี่ห้อรถ     */           
            tlt.model               /*  14 รุ่นรถ       */           
            tlt.lince1              /*  15 เลขทะเบียน   */           
            tlt.lince2              /*  16 ปีรถ         */           
            tlt.cc_weight           /*  17 CC.          */           
            tlt.cha_no              /*  18 เลขตัวถัง    */           
            tlt.eng_no              /*  19 เลขเครื่อง   */           
            tlt.comp_noti_tlt       /*  20 Code ผู้แจ้ง */           
            tlt.safe3               /*  21 ประเภท       */           
            tlt.nor_usr_ins         /*  22 Code บ.ประกัน        */  
            tlt.nor_noti_ins        /*  23 เลขกรมธรรม์เดิม      */ 
            tlt.safe2
            IF tlt.nor_effdat = ? THEN "" ELSE string(tlt.nor_effdat,"99/99/9999") FORMAT "x(10)" /*  24 วันคุ้มครองประกัน    */
            IF tlt.expodat = ? THEN "" ELSE string(tlt.expodat,"99/99/9999") FORMAT "x(10)"    /*  25 วันหมดประกัน         */   
            tlt.comp_coamt         /*  26 ทุนประกัน    */           
            DECI(tlt.dri_name2)    /*  27 ค่าเบี้ยสุทธิ์ */         
            tlt.nor_grprm          /*  28 ค่าเบี้ยรวมภาษีอากร */    
            tlt.seqno              /*  29 Deduct       */           
            tlt.nor_usr_tlt        /*  30 Code บ.ประกัน พรบ.   */   
            IF tlt.comp_effdat = ? THEN "" ELSE string(tlt.comp_effdat,"99/99/9999")  FORMAT "x(10)"  /*  31 วันคุ้มครองพรบ.*/   
            IF tlt.dat_ins_noti = ? THEN "" ELSE string(tlt.dat_ins_noti,"99/99/9999") FORMAT "x(10)"  /*  32 วันหมดพรบ.   */           
            deci(tlt.dri_no1)   /*  33 ค่าพรบ.      */           
            tlt.dri_name1       /*  34 ระบุผู้ขับขี่        */   
            tlt.stat            /*  35 ซ่อมห้าง     */           
            tlt.safe1           /*  36 คุ้มครองอุปกรณ์เพิ่มเติม*/
            tlt.filler1         /*  37 แก้ไขที่อยู่    */        
            tlt.comp_usr_ins    /*  38 ผู้รับผลประโยชน์ */       
            tlt.OLD_cha         /*  39 หมายเหตุ */               
            tlt.OLD_eng         /*  40 complete/not complete */  
            tlt.releas          /*  41 Yes/No . */ 
            wdetail.premtnet      /*  เบี้ยรวม    */
            wdetail.recivedat.    /*  ชำระล่าสุด  */
    END.
END.*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_reportnotcom c-wins 
PROCEDURE proc_reportnotcom :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_outputerr AS CHAR .

ASSIGN 
    n_record = 0
    nv_cnt   = 0
    nv_row   = 1  .
If  substr(fi_inputfile,length(fi_inputfile) - 3,4) <>  ".csv"  THEN 
    nv_outputerr  =  Trim(fi_filename) + ".csv"  .
ELSE  nv_outputerr = substr(fi_inputfile,1,length(fi_inputfile) - 4) +  "_outerr.csv" .  

ASSIGN nv_cnt  =  0
       nv_row  =  1.
OUTPUT TO VALUE(nv_outputerr). 
EXPORT DELIMITER "|" 
    "ข้อมูลงานรับประกันภัย AYCL" .
EXPORT DELIMITER "|" 
    "ลำดับที่"  
    "วันที่แจ้ง "
    "เลขรับแจ้ง "
    "Branch     "
    "Contract   "
    "คำนำหน้าชื่อ"
    "ชื่อ"  
    "นามสกุล"  
    "ที่อยู่ 1   "
    "ที่อยู่ 2   "  
    "ที่อยู่ 3   "  
    "ที่อยู่ 4   "  
    "ยี่ห้อรถ   "
    "รุ่นรถ     "
    "เลขทะเบียน "
    "ปีรถ       "
    "CC.        "
    "เลขตัวถัง  "
    "เลขเครื่อง "
    "Code ผู้แจ้ง       "
    "ประเภท     "
    "Code บ.ประกัน      "
    "เลขกรมธรรม์เดิม    "
    "วันคุ้มครองประกัน  "
    "วันหมดประกัน       "
    "ทุนประกัน  "
    "ค่าเบี้ยสุทธิ์     "
    "ค่าเบี้ยรวมภาษีอากร        "   
    "Deduct     "
    "Code บ.ประกัน พรบ. "
    "วันคุ้มครองพรบ.    "
    "วันหมดพรบ. "
    "ค่าพรบ.    "
    "ระบุผู้ขับขี่      "
    "ซ่อมห้าง   "
    "คุ้มครองอุปกรณ์เพิ่มเติม   "
    "แก้ไขที่อยู่       "
    "ผู้รับผลประโยชน์" 
    "หมายเหตุ"                           
    "complete/not complete"
    "Yes/No" .  
RUN proc_reportfileerr.

Message "Export data Complete"  View-as alert-box.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_reporttitle c-wins 
PROCEDURE proc_reporttitle :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*
ASSIGN 
    n_record = 0
    nv_cnt   = 0
    nv_row   = 1  .
If  substr(fi_outfile,length(fi_outfile) - 3,4) <>  ".csv"  THEN 
    fi_outfile  =  Trim(fi_outfile) + "_mat.csv"  .
ASSIGN nv_cnt  =  0
       nv_row  =  1.
OUTPUT TO VALUE(fi_outfile). 
EXPORT DELIMITER "|" 
    "Match file KPN_Aycal" .
EXPORT DELIMITER "|" 
    "SEQ"   
    "INSURANCECODE"   
    "CONTRACTNO"   
    "BRANCHCODE"   
    "BRANCHNO " 
    "POLICY_COMP" 
    "Branch"
    "STICKERNO"   
    "CUSTOMERNAME"   
    "ADDRESS"   
    "CARNO"   
    "BRAND"   
    "MODEL"   
    "CC"   
    "REGISTRATION "   
    "PROVINCE"   
    "BODY"   
    "ENGINE"   
    "STARTDATE"   
    "ENDDATE"   
    "NETINCOME"   
    "TOTALINCOME"   
    "CARDID" .
    
RUN proc_reportmat44.
*/
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
    tlt.genusr   =  "phone"         .
        
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

