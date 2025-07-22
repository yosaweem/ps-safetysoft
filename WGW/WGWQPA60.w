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
  wgwqpa60.w :   Query & Update Add in table  tlt 
  Create  by :   Ranu I. A61-0024 Date 23/01/2018
  Connect    :  sicuw,sicsyac,sic_bran ,brstat  
 +++++++++++++++++++++++++++++++++++++++++++++++*/

 Def    var  nv_rectlt    as recid  init  0.
 Def    var  nv_recidtlt  as recid  init  0.
 DEFINE VAR  n_asdat      AS CHAR.
 DEFINE VAR  vAcProc_fil  AS CHAR.
 DEFINE VAR  n_asdat1     AS CHAR. /*A55-0365 */
 DEFINE VAR  vAcProc_fil1 AS CHAR. /*A55-0365 */

 DEFINE stream  ns2.
 DEF VAR nv_row AS INT INIT 0.  /*A60-0118*/

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
&Scoped-define FIELDS-IN-QUERY-br_tlt tlt.releas tlt.policy ~
tlt.nor_noti_ins tlt.ins_name + " " + tlt.rec_addr5 tlt.gendat ~
tlt.nor_coamt tlt.comp_coamt tlt.datesent 
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_tlt 
&Scoped-define QUERY-STRING-br_tlt FOR EACH tlt NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-br_tlt OPEN QUERY br_tlt FOR EACH tlt NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-br_tlt tlt
&Scoped-define FIRST-TABLE-IN-QUERY-br_tlt tlt


/* Definitions for FRAME fr_main                                        */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS ra_status fi_trndatfr fi_trndatto bu_ok ~
cb_search bu_oksch br_tlt fi_search bu_update cb_report fi_outfile ~
bu_report bu_exit bu_upyesno fi_datare RECT-338 RECT-339 RECT-341 RECT-386 ~
RECT-342 
&Scoped-Define DISPLAYED-OBJECTS ra_status fi_trndatfr fi_trndatto ~
cb_search fi_search fi_name cb_report fi_outfile fi_datare 

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
     SIZE 7 BY 1
     BGCOLOR 22 FONT 6.

DEFINE BUTTON bu_oksch 
     LABEL "OK" 
     SIZE 5 BY .95
     BGCOLOR 2 FONT 6.

DEFINE BUTTON bu_report 
     LABEL "OK" 
     SIZE 7 BY .95
     BGCOLOR 5 FONT 6.

DEFINE BUTTON bu_update 
     LABEL "CANCEL" 
     SIZE 14 BY 1.05
     BGCOLOR 6 FONT 6.

DEFINE BUTTON bu_upyesno 
     LABEL "YES/NO" 
     SIZE 14 BY 1.05
     BGCOLOR 2 FONT 6.

DEFINE VARIABLE cb_report AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEMS "Item 1" 
     DROP-DOWN-LIST
     SIZE 35.67 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE cb_search AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEMS "ชื่อผู้เอาประกัน" 
     DROP-DOWN-LIST
     SIZE 40 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_datare AS CHARACTER FORMAT "X(60)":U 
     VIEW-AS FILL-IN 
     SIZE 29 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_name AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 39 BY .95
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_outfile AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 79.33 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_search AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 48 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_trndatfr AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 26.5 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_trndatto AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 26.5 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE ra_status AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "Yes", 1,
"No", 2,
"Cancel", 3,
"All", 4
     SIZE 28.5 BY 1
     BGCOLOR 19 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-338
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 59.33 BY 2.52
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-339
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 71 BY 2.52
     BGCOLOR 10 .

DEFINE RECTANGLE RECT-341
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 12.33 BY 1.76
     BGCOLOR 6 .

DEFINE RECTANGLE RECT-342
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 133 BY 1.67
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-386
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 130.33 BY 2.62
     BGCOLOR 3 .

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_tlt FOR 
      tlt SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_tlt
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_tlt c-wins _STRUCTURED
  QUERY br_tlt NO-LOCK DISPLAY
      tlt.releas COLUMN-LABEL "Status" FORMAT "x(20)":U WIDTH 12
      tlt.policy FORMAT "x(16)":U WIDTH 18.33
      tlt.nor_noti_ins COLUMN-LABEL "เลขที่สัญญา" FORMAT "x(20)":U
            WIDTH 17.33
      tlt.ins_name + " " + tlt.rec_addr5 COLUMN-LABEL "ชื่อ - สกุล" FORMAT "X(60)":U
            WIDTH 31.67
      tlt.gendat COLUMN-LABEL "วันคุ้มครอง" FORMAT "99/99/9999":U
            WIDTH 13.33
      tlt.nor_coamt COLUMN-LABEL "ทุนประกัน" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 15.33
      tlt.comp_coamt COLUMN-LABEL "เบี้ยรวม" FORMAT "->>,>>>,>>9.99":U
            WIDTH 13.17
      tlt.datesent COLUMN-LABEL "วันที่ส่งข้อมูล" FORMAT "99/99/9999":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 130.5 BY 14.33
         BGCOLOR 15  ROW-HEIGHT-CHARS .75.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     ra_status AT ROW 7.67 COL 102.5 NO-LABEL
     fi_trndatfr AT ROW 3.43 COL 23.33 COLON-ALIGNED NO-LABEL
     fi_trndatto AT ROW 3.43 COL 59.83 COLON-ALIGNED NO-LABEL
     bu_ok AT ROW 3.43 COL 92
     cb_search AT ROW 5.05 COL 17.5 COLON-ALIGNED NO-LABEL
     bu_oksch AT ROW 6.19 COL 54.67
     br_tlt AT ROW 10.29 COL 2.33
     fi_search AT ROW 6.14 COL 4.33 NO-LABEL
     fi_name AT ROW 6.05 COL 60.67 COLON-ALIGNED NO-LABEL
     bu_update AT ROW 5.95 COL 102.5
     cb_report AT ROW 7.67 COL 12.83 COLON-ALIGNED NO-LABEL
     fi_outfile AT ROW 8.81 COL 14.67 NO-LABEL
     bu_report AT ROW 8.86 COL 95
     bu_exit AT ROW 3.1 COL 121.67
     bu_upyesno AT ROW 5.95 COL 117.67
     fi_datare AT ROW 7.71 COL 64.83 NO-LABEL
     "Click for update Flag Cancel":40 VIEW-AS TEXT
          SIZE 29.5 BY .95 AT ROW 5 COL 63
          BGCOLOR 10 FGCOLOR 6 FONT 6
     "Export File :" VIEW-AS TEXT
          SIZE 12 BY .95 AT ROW 7.67 COL 2.67
          BGCOLOR 3 FGCOLOR 7 FONT 6
     "   QUERY DATA PA60 PMIB" VIEW-AS TEXT
          SIZE 29.5 BY 1.43 AT ROW 1.1 COL 49
          BGCOLOR 1 FGCOLOR 7 FONT 6
     "Report Data :" VIEW-AS TEXT
          SIZE 13 BY .95 AT ROW 7.71 COL 51.5
          BGCOLOR 3 FGCOLOR 7 FONT 6
     "Status :" VIEW-AS TEXT
          SIZE 7.5 BY .95 AT ROW 7.67 COL 94.67
          BGCOLOR 3 FGCOLOR 7 FONT 6
     "To  :" VIEW-AS TEXT
          SIZE 5.5 BY 1 AT ROW 3.43 COL 55.17
          BGCOLOR 19 FONT 6
     "Output :" VIEW-AS TEXT
          SIZE 8.33 BY .95 AT ROW 8.81 COL 6.17
          BGCOLOR 3 FGCOLOR 7 FONT 6
     "วันที่นำเข้าข้อมูล  From :" VIEW-AS TEXT
          SIZE 21.5 BY 1 AT ROW 3.43 COL 2.83
          BGCOLOR 19 FONT 6
     " Search Data :" VIEW-AS TEXT
          SIZE 14 BY 1 AT ROW 5.05 COL 4.33
          BGCOLOR 21 FGCOLOR 2 FONT 6
     RECT-338 AT ROW 4.81 COL 2.17
     RECT-339 AT ROW 4.81 COL 61.5
     RECT-341 AT ROW 2.76 COL 120
     RECT-386 AT ROW 7.43 COL 2.17
     RECT-342 AT ROW 1 COL 1.17 
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133.17 BY 24
         BGCOLOR 20 FGCOLOR 0 .


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
         TITLE              = "Query && Update [PMIB 60 ]"
         HEIGHT             = 24
         WIDTH              = 133.17
         MAX-HEIGHT         = 24
         MAX-WIDTH          = 133.17
         VIRTUAL-HEIGHT     = 24
         VIRTUAL-WIDTH      = 133.17
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
/* SETTINGS FOR FILL-IN fi_datare IN FRAME fr_main
   ALIGN-L                                                              */
/* SETTINGS FOR FILL-IN fi_name IN FRAME fr_main
   NO-ENABLE                                                            */
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
     _FldNameList[1]   > brstat.tlt.releas
"tlt.releas" "Status" "x(20)" "character" ? ? ? ? ? ? no ? no no "12" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[2]   > brstat.tlt.policy
"tlt.policy" ? ? "character" ? ? ? ? ? ? no ? no no "18.33" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   > brstat.tlt.nor_noti_ins
"tlt.nor_noti_ins" "เลขที่สัญญา" "x(20)" "character" ? ? ? ? ? ? no ? no no "17.33" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   > "_<CALC>"
"tlt.ins_name + "" "" + tlt.rec_addr5" "ชื่อ - สกุล" "X(60)" ? ? ? ? ? ? ? no ? no no "31.67" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   > brstat.tlt.gendat
"tlt.gendat" "วันคุ้มครอง" ? "date" ? ? ? ? ? ? no ? no no "13.33" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[6]   > brstat.tlt.nor_coamt
"tlt.nor_coamt" "ทุนประกัน" ? "decimal" ? ? ? ? ? ? no ? no no "15.33" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[7]   > brstat.tlt.comp_coamt
"tlt.comp_coamt" "เบี้ยรวม" ? "decimal" ? ? ? ? ? ? no ? no no "13.17" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[8]   > brstat.tlt.datesent
"tlt.datesent" "วันที่ส่งข้อมูล" ? "date" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _Query            is NOT OPENED
*/  /* BROWSE br_tlt */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME c-wins
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c-wins c-wins
ON END-ERROR OF c-wins /* Query  Update [PMIB 60 ] */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c-wins c-wins
ON WINDOW-CLOSE OF c-wins /* Query  Update [PMIB 60 ] */
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
ON LEFT-MOUSE-CLICK OF br_tlt IN FRAME fr_main
DO:
     Get  current  br_tlt.
     nv_rectlt =  recid(tlt).
     fi_name   =  tlt.ins_name + " " + tlt.rec_addr5.
     disp  fi_name  with frame  fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_tlt c-wins
ON LEFT-MOUSE-DBLCLICK OF br_tlt IN FRAME fr_main
DO:
   
        Get Current br_tlt.
              nv_recidtlt  =  Recid(tlt).
        
        {&WINDOW-NAME}:hidden  =  Yes. 
        
        Run  wgw\wgwqp601(Input  nv_recidtlt).
        
        {&WINDOW-NAME}:hidden  =  No. 
   
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_tlt c-wins
ON VALUE-CHANGED OF br_tlt IN FRAME fr_main
DO:
     Get  current  br_tlt.
     nv_rectlt =  recid(tlt).
     fi_name   =  tlt.ins_name + " " + tlt.rec_addr5.
     disp  fi_name  with frame  fr_main.
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
ON CHOOSE OF bu_ok IN FRAME fr_main /* OK */
DO:
        Open Query br_tlt 
         For each tlt Use-index  tlt01  Where
         tlt.trndat  >=   fi_trndatfr   And
         tlt.trndat  <=   fi_trndatto   And
         tlt.flag     =   "M60"         AND
         tlt.genusr   =   "PMIB"        no-lock.  

         nv_rectlt =  recid(tlt).   
         Apply "Entry"  to br_tlt.
         Return no-apply. 
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_oksch
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_oksch c-wins
ON CHOOSE OF bu_oksch IN FRAME fr_main /* OK */
DO:
    Disp fi_search  with frame fr_main.
    If  cb_search = "ชื่อลูกค้า"  Then do:              /* name  */                          
        Open Query br_tlt                                                        
            For each tlt Use-index  tlt01  Where                                     
            tlt.trndat  >=  fi_trndatfr    And                                            
            tlt.trndat  <=  fi_trndatto    And  
            tlt.genusr   =  "PMIB"         And
            tlt.flag     =  "M60"           AND 
            index(tlt.ins_name,fi_search) <> 0 no-lock.  
           ASSIGN nv_rectlt =  recid(tlt) .  
           Apply "Entry"  to br_tlt.
           Return no-apply.
            
    END.
    ELSE If  cb_search  =  "เบอร์กรมธรรม์"  Then do:   /* policy */
        Open Query br_tlt 
            For each tlt Use-index  tlt01 Where
            tlt.trndat   >=  fi_trndatfr  And
            tlt.trndat   <=  fi_trndatto  And
            tlt.genusr    =  "PMIB"       And
            tlt.flag      =  "M60"         AND 
            index(tlt.policy,fi_search) <> 0  no-lock.
              ASSIGN nv_rectlt =  recid(tlt) .  
              Apply "Entry"  to br_tlt.
              Return no-apply.
            
    END.
    ELSE If  cb_search  =  "เลขที่สัญญา"  Then do:   /* policy */
        Open Query br_tlt 
            For each tlt Use-index  tlt01 Where
            tlt.trndat   >=  fi_trndatfr  And
            tlt.trndat   <=  fi_trndatto  And
            tlt.genusr    =  "PMIB"      And
            tlt.flag      =  "M60"         AND
            index(tlt.nor_noti_ins,fi_search) <> 0  no-lock.
              ASSIGN nv_rectlt =  recid(tlt) .  
              Apply "Entry"  to br_tlt.
              Return no-apply.
            
    END.
    ELSE If  cb_search  =  "Status_yes"  Then do:   /* Confirm yes..*/
        Open Query br_tlt 
            For each tlt Use-index  tlt01  Where
            tlt.trndat >=  fi_trndatfr     And
            tlt.trndat <=  fi_trndatto     And
            tlt.genusr  =  "PMIB"        And
            tlt.flag    =  "M60"         AND
            INDEX(tlt.releas,"yes") <> 0   no-lock.
            ASSIGN nv_rectlt =  recid(tlt) .  
            Apply "Entry"  to br_tlt.
            Return no-apply.
            
    END.
    ELSE If  cb_search  =  "Status_no"  Then do:     /* confirm no...*/
        Open Query br_tlt 
            For each tlt Use-index  tlt01   Where
            tlt.trndat >=  fi_trndatfr      And
            tlt.trndat <=  fi_trndatto      And
            tlt.genusr  =  "PMIB"         And
            tlt.flag    =  "M60"         AND
            INDEX(tlt.releas,"no") <> 0     no-lock.
            ASSIGN nv_rectlt =  recid(tlt) .  
            Apply "Entry"  to br_tlt.
            Return no-apply.
            
    END.
    ELSE If  cb_search  =  "Status_Cancel"  Then do:    /* cancel */
        Open Query br_tlt 
            For each tlt Use-index  tlt01  Where
            tlt.trndat  >=  fi_trndatfr    And
            tlt.trndat  <=  fi_trndatto    And
            tlt.genusr   =  "PMIB"        And
            tlt.flag     =  "M60"         AND
            index(tlt.releas,"cancel") > 0     no-lock.
            ASSIGN nv_rectlt =  recid(tlt) .  
            Apply "Entry"  to br_tlt.
            Return no-apply.
    END.
    Else  do:
        ASSIGN nv_rectlt =  recid(tlt) .  /*add Kridtiya i. A56-0323*/
        Apply "Entry"  to  fi_search.
        Return no-apply.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_report
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_report c-wins
ON CHOOSE OF bu_report IN FRAME fr_main /* OK */
DO:
    IF fi_outfile = "" THEN DO:
        MESSAGE "กรุณาใสชื่อไฟล์!!!"  VIEW-AS ALERT-BOX.
        Apply "Entry"  to fi_outfile.
        Return no-apply. 
    END.
    ELSE DO:
        RUN pd_report.
        Message "Export data Complete"  View-as alert-box.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_update
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_update c-wins
ON CHOOSE OF bu_update IN FRAME fr_main /* CANCEL */
DO:
    Find tlt Where Recid(tlt)  =  nv_rectlt .
    If  avail tlt Then do:
        If  index(tlt.releas,"CANCEL")  =  0  Then do:
            message "ยกเลิกข้อมูลรายการนี้  "  View-as alert-box.
            IF tlt.releas = "" THEN DO: 
                ASSIGN 
                    tlt.releas  =  "CANCEL"
                    tlt.expodat =  TODAY 
                    tlt.stat    =  USERID(LDBNAME(1)) + " /CA".  
            END.
            ELSE DO: 
                ASSIGN tlt.releas  =  "CANCEL/" + tlt.releas 
                       tlt.expodat =  TODAY 
                       tlt.stat    =  USERID(LDBNAME(1)) + " /CA". 
            END.
        END.
        Else do:
            message "เรียกข้อมูลกลับมาใช้งาน "  View-as alert-box.
            IF index(tlt.releas,"CANCEL/")  =  0 THEN DO:
                ASSIGN tlt.releas  =  substr(tlt.releas,index(tlt.releas,"CANCEL") + 6 ) 
                       tlt.expodat =  TODAY 
                       tlt.stat    =  USERID(LDBNAME(1)) + "/IF". 

            END.
            ELSE DO:
                ASSIGN tlt.releas =  substr(tlt.releas,index(tlt.releas,"CANCEL") + 7 ) 
                       tlt.expodat =  TODAY 
                       tlt.stat    =  USERID(LDBNAME(1)) + "/IF". 
            END.
                
        END.
    END.
    RELEASE tlt.
    Run Pro_OpenQuery2.
    Apply "Entry"  to br_tlt.
    Return no-apply.  
END.

      /*  If  index(tlt.releas,"cancel") = 0 THEN DO: 
        ASSIGN tlt.releas =  "cancel" + tlt.releas .
            message "ยกเลิกข้อมูลรายการนี้  " tlt.releas  /*FORMAT "x(20)" */
                View-as alert-box.
            

    END.
    ELSE IF index(tlt.releas,"cancel") <> 0   THEN DO:
        DISP tlt.releas  FORMAT "x(20)"  index(tlt.releas,"cancel").
        tlt.releas =  substr(tlt.releas,INDEX(tlt.releas,"cancel") + 6 ) + "/YES".
        DISP tlt.releas  FORMAT "x(20)"  index(tlt.releas,"cancel").
    END.*/

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_upyesno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_upyesno c-wins
ON CHOOSE OF bu_upyesno IN FRAME fr_main /* YES/NO */
DO:
    Find tlt Where Recid(tlt)  =  nv_rectlt.
    If  avail tlt Then do:
        If  index(tlt.releas,"NO")  =  0  Then do:  /* yes */
            message "Update No ข้อมูลรายการนี้  "  View-as alert-box.
            IF tlt.releas = "" THEN tlt.releas  =  "NO" .
            ELSE IF index(tlt.releas,"CANCEL/")  <> 0 THEN 
                ASSIGN tlt.releas  =  "CANCEL/NO" .
            ELSE ASSIGN tlt.releas  =  "NO" .
        END.
        Else do:    /* no */
            If  index(tlt.releas,"YES")  =  0  Then do:  /* yes */
            message "Update Yes ข้อมูลรายการนี้  "  View-as alert-box.
            IF tlt.releas = "" THEN tlt.releas  =  "YES" .
            ELSE IF index(tlt.releas,"Cancel/")  <> 0 THEN 
                ASSIGN tlt.releas  =  "CANCEL/YES" .
            ELSE ASSIGN tlt.releas  =  "YES" .
        END.
        END.
    END.
    RELEASE tlt.
    Run Pro_OpenQuery2.
    Apply "Entry"  to br_tlt.
    Return no-apply. 
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


&Scoped-define SELF-NAME fi_datare
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_datare c-wins
ON LEAVE OF fi_datare IN FRAME fr_main
DO:
  fi_datare = INPUT fi_datare.
  DISP fi_datare WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_name
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_name c-wins
ON LEAVE OF fi_name IN FRAME fr_main
DO:
  /*fi_polfr  =  Input  fi_polfr.
  Disp  fi_polfr  with frame  fr_main.*/
  
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
/*
    If  cb_search = "ชื่อลูกค้า"  Then do:              /* name  */                          
        Open Query br_tlt                                                        
            For each tlt Use-index  tlt01  Where                                     
            tlt.trndat  >=  fi_trndatfr         And                                            
            tlt.trndat  <=  fi_trndatto         And  
            tlt.genusr   =  "SCBPT"             And
            index(tlt.ins_name,fi_search) <> 0  no-lock.      
                ASSIGN nv_rectlt =  recid(tlt) .  /*add Kridtiya i. A56-0323*/
                Apply "Entry"  to br_tlt.
                Return no-apply.            
    END.
    ELSE If  cb_search  =  "กรมธรรม์ใหม่"  Then do:   /* policy */
        Open Query br_tlt 
            For each tlt Use-index  tlt01 Where
            tlt.trndat   >=  fi_trndatfr  And
            tlt.trndat   <=  fi_trndatto  And
            tlt.genusr    =  "SCBPT"      And
            index(tlt.nor_noti_ins,fi_search) <> 0  no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .  /*add Kridtiya i. A56-0323*/
                Apply "Entry"  to br_tlt.
                Return no-apply.        
    END.
    ELSE If  cb_search  =  "กรมธรรม์เก่า"  Then do:   /* policy */
        Open Query br_tlt 
            For each tlt Use-index  tlt01 Where
            tlt.trndat   >=  fi_trndatfr  And
            tlt.trndat   <=  fi_trndatto  And
            tlt.genusr    =  "SCBPT"      And
            index(tlt.rec_addr5,fi_search) <> 0  no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .  /*add Kridtiya i. A56-0323*/
                Apply "Entry"  to br_tlt.
                Return no-apply.        
    END.
    ELSE If  cb_search  =  "ป้ายแดง"  Then do:    
        Open Query br_tlt 
            For each tlt Use-index  tlt01 Where
            tlt.trndat   >=  fi_trndatfr  And
            tlt.trndat   <=  fi_trndatto  And
            tlt.genusr    =  "SCBPT"      And
            tlt.flag      =  "N"          no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .  /*add Kridtiya i. A56-0323*/
                Apply "Entry"  to br_tlt.
                Return no-apply.        
    END.
    ELSE If  cb_search  =  "ต่ออายุ"  Then do:    
        Open Query br_tlt 
            For each tlt Use-index  tlt01 Where
            tlt.trndat   >=  fi_trndatfr            And 
            tlt.trndat   <=  fi_trndatto            And 
            tlt.genusr    =  "SCBPT"                And 
            tlt.flag      =  "R"                    no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .  /*add Kridtiya i. A56-0323*/
                Apply "Entry"  to br_tlt.           
                Return no-apply.                    
    END.                                            
    ELSE If  cb_search  = "เลขตัวถัง"  Then do:  /* chassis no */
        Open Query br_tlt                           
            For each tlt Use-index  tlt06 Where     
            tlt.trndat >=  fi_trndatfr              And 
            tlt.trndat <=  fi_trndatto              AND 
            tlt.genusr   =  "SCBPT"                 And 
            INDEX(tlt.cha_no,trim(fi_search)) <> 0  no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .  /*add Kridtiya i. A56-0323*/
                Apply "Entry"  to br_tlt.           
                Return no-apply.                    
    END.                                            
    ELSE If  cb_search  =  "Confirm_yes"  Then do:  /* Confirm yes..*/
        Open Query br_tlt                           
            For each tlt Use-index  tlt01  Where    
            tlt.trndat  >=  fi_trndatfr             And 
            tlt.trndat  <=  fi_trndatto             And 
            tlt.genusr   =  "SCBPT"                 And 
            INDEX(tlt.releas,"yes") <> 0            no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .     /*add Kridtiya i. A56-0323*/
                Apply "Entry"  to br_tlt.            
                Return no-apply.                    
    END.                                            
    ELSE If  cb_search  =  "Confirm_no"  Then do:    /* confirm no...*/
        Open Query br_tlt                           
            For each tlt Use-index  tlt01   Where   
            tlt.trndat  >=  fi_trndatfr             And 
            tlt.trndat  <=  fi_trndatto             And 
            tlt.genusr   =  "SCBPT"                 And 
            INDEX(tlt.releas,"no") <> 0             no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .       /*add Kridtiya i. A56-0323*/
                Apply "Entry"  to br_tlt.
                Return no-apply.            
    END.
    ELSE If  cb_search  =  "Status_cancel"  Then do:    /* cancel */
        Open Query br_tlt 
            For each tlt Use-index  tlt01  Where
            tlt.trndat  >=  fi_trndatfr    And
            tlt.trndat  <=  fi_trndatto    And
            tlt.genusr   =  "SCBPT"        And
            index(tlt.releas,"cancel") > 0 no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .     /*add Kridtiya i. A56-0323*/
                Apply "Entry"  to br_tlt.
                Return no-apply.                             
    END.
    ELSE If  cb_search  =  "สาขา"  Then do:          /* cancel */
        Open Query br_tlt 
            For each tlt Use-index  tlt01  Where
            tlt.trndat  >=  fi_trndatfr    And
            tlt.trndat  <=  fi_trndatto    And
            tlt.genusr   =  "SCBPT"        And
            tlt.EXP      =  fi_search      no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .     /*add Kridtiya i. A56-0323*/
                Apply "Entry"  to br_tlt.
                Return no-apply.                             
    END.
    Else  do:
        ASSIGN nv_rectlt =  recid(tlt) .             /*add Kridtiya i. A56-0323*/
        Apply "Entry"  to  fi_search.
        Return no-apply.
    END.*/
    /*A55-0184*/
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


&Scoped-define SELF-NAME ra_status
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_status c-wins
ON VALUE-CHANGED OF ra_status IN FRAME fr_main
DO:
  ra_status = INPUT ra_status.
  DISP ra_status WITH FRAM fr_main.
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
  gv_prgid = "wgwqpa60".
  gv_prog  = "Query & Update  Detail PA60 (PMIB) ".
  RUN  WUT\WUTHEAD ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).
  SESSION:DATA-ENTRY-RETURN = YES.
  ASSIGN 
      fi_trndatfr = TODAY
      fi_trndatto = TODAY
      ra_status =  4 
      vAcProc_fil = vAcProc_fil  + "ชื่อลูกค้า"   + ","
                                  + "เบอร์กรมธรรม์" + "," 
                                  + "เลขที่สัญญา"    + "," 
                                  + "status_Yes"   + "," 
                                  + "status_No"    + "," 
                                  + "Status_cancel"  + ","
       cb_search:LIST-ITEMS = vAcProc_fil
       cb_search = ENTRY(1,vAcProc_fil) 
      
       vAcProc_fil1 = vAcProc_fil1 
                       + "All"  + ","
                       + "วันที่ส่งข้อมูล" + ","  
                       + "วันที่ยกเลิก"    + ","       
                       + "วันที่โหลดงาน"   + ","
                       + "วันที่คุ้มครอง"  + ","
        cb_report:LIST-ITEMS = vAcProc_fil1
        cb_report = ENTRY(1,vAcProc_fil1) 
     
      fi_outfile = "D:\PMIB_M60" + 
                    STRING(YEAR(TODAY),"9999") + 
                    STRING(MONTH(TODAY),"99")  + 
                    STRING(DAY(TODAY),"99")    + 
                    SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) + 
                    SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2) + ".SLK" .
  
  Disp fi_trndatfr  fi_trndatto cb_search cb_report ra_status fi_outfile with frame fr_main.

/*********************************************************************/ 
 /*  RUN Wut\WutwiCen ({&WINDOW-NAME}:HANDLE). */ 
  /*CURRENT-WINDOW:WINDOW-STATE = WINDOW-MAXIMIZED.*/
 
  Rect-338:Move-to-top().  
  Rect-339:Move-to-top(). 
  
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
  DISPLAY ra_status fi_trndatfr fi_trndatto cb_search fi_search fi_name 
          cb_report fi_outfile fi_datare 
      WITH FRAME fr_main IN WINDOW c-wins.
  ENABLE ra_status fi_trndatfr fi_trndatto bu_ok cb_search bu_oksch br_tlt 
         fi_search bu_update cb_report fi_outfile bu_report bu_exit bu_upyesno 
         fi_datare RECT-338 RECT-339 RECT-341 RECT-386 RECT-342 
      WITH FRAME fr_main IN WINDOW c-wins.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW c-wins.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_report c-wins 
PROCEDURE pd_report :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_count AS INT.
DEF VAR nv_data AS CHAR FORMAT "x(50)" INIT "".
If  substr(fi_outfile,length(fi_outfile) - 3,4) <>  ".slk"  THEN 
    fi_outfile  =  Trim(fi_outfile) + ".slk"  .
ASSIGN nv_count = 0 
       nv_data  = "" .
    /*nv_row  =  1.*/
OUTPUT TO VALUE(fi_outfile).
EXPORT DELIMITER "|" 
    "Report PMIB60 :" string(TODAY,"99/99/9999")   .
EXPORT DELIMITER "|"    
   "ลำดับที่       "        /*1   */                                   
   "สถานะข้อมูล "           /*2   */ 
   "วันที่ส่งข้อมูล"        /*3   */ 
   "เลขรับแจ้ง     "        /*4   */ 
   "คำนำหน้าชื่อ   "        /*5   */ 
   "ชื่อ           "        /*6   */ 
   "นามสกุล        "        /*7   */ 
   "เลขบัตร ปปช.   "        /*8   */ 
   "วันเกิด        "        /*9   */ 
   " อายุ          "        /*10  */ 
   "แผนประกัน      "        /*11  */ 
   "ทุนประกัน      "        /*12  */ 
   "ค่าเบี้ยรวม    "        /*13  */ 
   "ที่อยู่1       "        /*14  */ 
   "ที่อยู่1       "        /*15  */ 
   "ที่อยู่1       "        /*16  */ 
   "ที่อยู่1       "        /*17  */ 
   "เบอร์โทร       "        /*18  */ 
   "เบอร์มือถือ    "        /*19  */ 
   "วันที่คุ้มครอง "        /*20  */ 
   "วันที่นำเข้าข้อมูล "    /*21  */ 
   "วันที่โหลดงาน"          /*22  */ 
   "วันที่ยกเลิก "
   "เบอร์กรมธรรม์ "         /*23  */
   "Producer Code " 
   "Agent Code "
   "หมายเหตุ " .
             
 nv_data = trim(fi_datare).
 loop_tlt:
 For each brstat.tlt Use-index  tlt01 Where
          brstat.tlt.trndat   >=  fi_trndatfr   And
          brstat.tlt.trndat   <=  fi_trndatto   And
          brstat.tlt.genusr    =  "PMIB"        AND 
          brstat.tlt.flag      =  "M60"         no-lock.
     
     IF cb_report = "วันที่ส่งข้อมูล" THEN DO:
         IF STRING(tlt.datesent,"99/99/9999") <> nv_data THEN NEXT.
     END.
     ELSE IF cb_report = "วันที่ยกเลิก" THEN DO:
         IF STRING(tlt.expodat,"99/99/9999") <> nv_data and
            index(tlt.RELEAS,"Cancel") = 0 THEN NEXT.
     END.
     ELSE IF cb_report = "วันที่โหลดงาน" THEN DO:
         IF STRING(tlt.entdat,"99/99/9999") <> nv_data and
            index(tlt.RELEAS,"Yes") = 0 THEN NEXT.
     END.
     ELSE IF cb_report = "วันที่คุ้มครอง" THEN DO:
         IF STRING(tlt.gendat,"99/99/9999") <> nv_data THEN NEXT.
     END.
     IF      ra_status = 1 THEN DO: 
         IF index(brstat.tlt.releas,"yes") = 0 THEN NEXT.
     END.                                      
     ELSE IF ra_status = 2 THEN DO:            
         IF index(brstat.tlt.releas,"no") = 0  THEN NEXT.
     END.                                      
     ELSE IF ra_status = 3 THEN DO: 
         IF index(brstat.tlt.releas,"cancel") = 0 THEN NEXT.
     END.
     nv_count = nv_count + 1 .
     EXPORT DELIMITER "|"
         nv_count 
         brstat.tlt.releas
         brstat.tlt.datesent     
         brstat.tlt.nor_noti_ins 
         brstat.tlt.rec_name     
         brstat.tlt.ins_name     
         brstat.tlt.rec_addr5    
         brstat.tlt.rec_addr1    
         brstat.tlt.rec_addr2    
         brstat.tlt.rec_addr3    
         brstat.tlt.rec_addr4    
         brstat.tlt.nor_coamt    
         brstat.tlt.comp_coamt   
         brstat.tlt.ins_addr1    
         brstat.tlt.ins_addr2    
         brstat.tlt.ins_addr3    
         brstat.tlt.ins_addr4    
         brstat.tlt.old_eng      
         brstat.tlt.old_cha      
         brstat.tlt.gendat
         brstat.tlt.trndat
         brstat.tlt.entdat
         brstat.tlt.expodat
         brstat.tlt.policy
         brstat.tlt.subins
         brstat.tlt.recac
         brstat.tlt.filler2
         brstat.tlt.filler1.
 END.
 OUTPUT CLOSE.
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
DO:
    Open Query br_tlt 
        For each tlt Use-index  tlt01 Where
            tlt.trndat  >=  fi_trndatfr  And
            tlt.trndat  <=  fi_trndatto  And
            tlt.flag     =  "M60"      AND
            tlt.genusr   =  "PMIB"      no-lock.
            ASSIGN
                nv_rectlt =  recid(tlt).   
END.

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
DO:

    Open Query br_tlt 
        FOR EACH tlt Where Recid(tlt)  =  nv_rectlt NO-LOCK .
            ASSIGN nv_rectlt =  recid(tlt).   /*A57-0017*/

END.
        
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

