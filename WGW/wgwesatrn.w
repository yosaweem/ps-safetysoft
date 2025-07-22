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

/****************************************************************************************** 
Modify By : Songkran P. A65-0141   12/09/2022      
            : Job Q,R Auto Create Inspection and Transfer to Premium         
*****************************************************************************************/ 
------------------------------------------------------------------------*/
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
DEF VAR n_text AS CHAR FORMAT "x(60)" INIT "".
DISP n_text  FONT 6 BGCOLOR 34 FGCOLOR 2 WITH FRAME msgbox WITH CENTERED NO-LABEL VIEW-AS DIALOG-BOX
TITLE "Wait Processing" .
/* Local Variable Definitions ---                                       */

DEF VAR nv_typeg  AS CHAR INIT "autotransfergw".
DEF BUFFER buff_uzpbrn FOR stat.uzpbrn.
DEF VAR nv_status AS CHAR INIT "".
DEF VAR nv_recid  AS RECID INIT ?.
DEF VAR nv_mflag AS CHAR INIT "".

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_head
&Scoped-define BROWSE-NAME br_que1

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES buff_uzpbrn

/* Definitions for BROWSE br_que1                                       */
&Scoped-define FIELDS-IN-QUERY-br_que1 buff_uzpbrn.typcode buff_uzpbrn.effdat buff_uzpbrn.expdat   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_que1   
&Scoped-define SELF-NAME br_que1
&Scoped-define QUERY-STRING-br_que1 FOR EACH buff_uzpbrn USE-INDEX uzpbrn02      WHERE buff_uzpbrn.typeg = nv_typeg NO-LOCK
&Scoped-define OPEN-QUERY-br_que1 OPEN QUERY br_que1 FOR EACH buff_uzpbrn USE-INDEX uzpbrn02      WHERE buff_uzpbrn.typeg = nv_typeg NO-LOCK .
&Scoped-define TABLES-IN-QUERY-br_que1 buff_uzpbrn
&Scoped-define FIRST-TABLE-IN-QUERY-br_que1 buff_uzpbrn


/* Definitions for FRAME fr_que1                                        */
&Scoped-define OPEN-BROWSERS-IN-QUERY-fr_que1 ~
    ~{&OPEN-QUERY-br_que1}

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bt_create 
     LABEL "CREATE" 
     SIZE 14 BY 1.43.

DEFINE BUTTON bt_delete 
     LABEL "DELETE" 
     SIZE 14 BY 1.43
     BGCOLOR 6 FGCOLOR 0 .

DEFINE BUTTON bt_edit 
     LABEL "EDIT" 
     SIZE 14 BY 1.43.

DEFINE BUTTON bt_exit AUTO-END-KEY 
     LABEL "EXIT" 
     SIZE 14 BY 1.43.

DEFINE VARIABLE fi_search AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 24.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE RECTANGLE RECT-03
     EDGE-PIXELS 3 GRAPHIC-EDGE    
     SIZE 45.5 BY 17.38.

DEFINE BUTTON bu_cancal 
     LABEL "Cancel" 
     SIZE 14 BY 1.33.

DEFINE BUTTON bu_ok 
     LABEL "OK" 
     SIZE 14 BY 1.33.

DEFINE VARIABLE cb_ispbox AS CHARACTER FORMAT "X(256)":U INITIAL "1" 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEM-PAIRS "กล่องกรุงศรี","1",
                     "กล่องอื่นๆ","2",
                     "กล่องอื่นๆ + รูปภาพ","3",
                     "ไม่ตรวจสภาพ","4"
     DROP-DOWN-LIST
     SIZE 23.5 BY 1 TOOLTIP "เลือกกล่อง inspection ที่ต้องตรวจสภาพ"
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE cb_prdck AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 10
     DROP-DOWN-LIST
     SIZE 29.33 BY 1 TOOLTIP "โปรแกรมที่ต้องเช็คเงื่อนไขในการ Auto Transfer"
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE et_sentm AS CHARACTER 
     VIEW-AS EDITOR MAX-CHARS 500 SCROLLBAR-VERTICAL
     SIZE 72.67 BY 3.29 TOOLTIP "ส่งเมลเพิ่มเติม (นอกเหนือจากผู้รับผิดชอบกล่อง)"
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_acno AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 16.83 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_effdat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 16.83 BY 1 TOOLTIP "เริ่มใช้งานเงือนไข"
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_expdat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 16.83 BY 1 TOOLTIP "สิ้นสุดการใช้งานเงือนไข"
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_namdes AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 54.5 BY 1 NO-UNDO.

DEFINE VARIABLE fi_name AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 17 BY 1 TOOLTIP "user id ผู้ที่สร้าง inspection" NO-UNDO.

DEFINE VARIABLE fi_pddes AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 55.83 BY 1 NO-UNDO.

DEFINE VARIABLE fi_userent AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 56.17 BY 1 NO-UNDO.

DEFINE VARIABLE fi_userev AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 56.17 BY 1 NO-UNDO.

DEFINE VARIABLE rs_active AS CHARACTER INITIAL "A" 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "Active", "A",
"Not Active", "N"
     SIZE 34.33 BY 1.19 NO-UNDO.

DEFINE VARIABLE rs_condi AS CHARACTER INITIAL "Q" 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "Job Q", "Q",
"Job R", "R",
"ALL Q,R", "ALL"
     SIZE 38.33 BY .81 TOOLTIP "เลือกประเภทงานที่ต้องการ Auto Trans" NO-UNDO.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_que1 FOR 
      buff_uzpbrn SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_que1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_que1 C-Win _FREEFORM
  QUERY br_que1 DISPLAY
      buff_uzpbrn.typcode        FORMAT "x(10)"        COLUMN-LABEL "Producer code     "
    buff_uzpbrn.effdat      FORMAT "99/99/9999"   COLUMN-LABEL "Start date "
    buff_uzpbrn.expdat      FORMAT "99/99/9999"   COLUMN-LABEL "End date "
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 41.83 BY 15.05
         BGCOLOR 15  FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_head
     "Parameter Auto GW Transfer to Premium" VIEW-AS TEXT
          SIZE 60 BY 1.71 AT ROW 1.33 COL 7.5 WIDGET-ID 70
          FGCOLOR 7 FONT 2
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 140.17 BY 2.19
         BGCOLOR 53 FGCOLOR 15 FONT 6 WIDGET-ID 100.

DEFINE FRAME fr_que1
     br_que1 AT ROW 1.48 COL 3 WIDGET-ID 500
     fi_search AT ROW 16.81 COL 10.5 COLON-ALIGNED NO-LABEL WIDGET-ID 8
     "Search" VIEW-AS TEXT
          SIZE 8 BY .62 AT ROW 17 COL 3.83 WIDGET-ID 10
          FGCOLOR 15 FONT 6
     RECT-03 AT ROW 1 COL 1.17 WIDGET-ID 6
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 3.19
         SIZE 46 BY 17.48
         BGCOLOR 53  WIDGET-ID 200.

DEFINE FRAME fr_setup
     fi_acno AT ROW 1.71 COL 17.5 COLON-ALIGNED NO-LABEL WIDGET-ID 80
     rs_condi AT ROW 3.14 COL 19.5 NO-LABEL WIDGET-ID 118
     cb_prdck AT ROW 4.19 COL 17.5 COLON-ALIGNED NO-LABEL WIDGET-ID 140
     cb_ispbox AT ROW 5.57 COL 17.5 COLON-ALIGNED NO-LABEL WIDGET-ID 128
     fi_name AT ROW 6.76 COL 17.5 COLON-ALIGNED NO-LABEL WIDGET-ID 162
     fi_effdat AT ROW 7.95 COL 17.5 COLON-ALIGNED NO-LABEL WIDGET-ID 146
     fi_expdat AT ROW 7.95 COL 47.5 COLON-ALIGNED NO-LABEL WIDGET-ID 148
     rs_active AT ROW 9.1 COL 19.5 NO-LABEL WIDGET-ID 152
     et_sentm AT ROW 10.33 COL 19.5 NO-LABEL WIDGET-ID 134 NO-TAB-STOP 
     bu_ok AT ROW 14.57 COL 61 WIDGET-ID 108
     bu_cancal AT ROW 14.57 COL 75.5 WIDGET-ID 114
     fi_pddes AT ROW 1.71 COL 35 COLON-ALIGNED NO-LABEL WIDGET-ID 124
     fi_namdes AT ROW 6.81 COL 36 COLON-ALIGNED NO-LABEL WIDGET-ID 166
     fi_userent AT ROW 14 COL 2.5 NO-LABEL WIDGET-ID 158
     fi_userev AT ROW 14.95 COL 2.5 NO-LABEL WIDGET-ID 160
     "Start date" VIEW-AS TEXT
          SIZE 9.67 BY 1 AT ROW 7.95 COL 9 WIDGET-ID 12
     "Inspection Box" VIEW-AS TEXT
          SIZE 14.5 BY 1 AT ROW 5.57 COL 4.5 WIDGET-ID 164
     "Producer code" VIEW-AS TEXT
          SIZE 14.5 BY 1 AT ROW 1.71 COL 4.67 WIDGET-ID 82
     "Check Job" VIEW-AS TEXT
          SIZE 10.5 BY 1 AT ROW 3.05 COL 8.5 WIDGET-ID 132
     "Create by user id" VIEW-AS TEXT
          SIZE 16.83 BY 1 AT ROW 6.71 COL 2 WIDGET-ID 130
     "Program Condition" VIEW-AS TEXT
          SIZE 17.17 BY 1 AT ROW 4.19 COL 1.5 WIDGET-ID 138
     "Send e-mail" VIEW-AS TEXT
          SIZE 11.5 BY 1 AT ROW 10.38 COL 7.33 WIDGET-ID 142
     "End date" VIEW-AS TEXT
          SIZE 8.83 BY 1 AT ROW 7.95 COL 40 WIDGET-ID 150
     "Status" VIEW-AS TEXT
          SIZE 6.17 BY .62 AT ROW 9.38 COL 12.33 WIDGET-ID 156
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 47 ROW 3.19
         SIZE 94.17 BY 15.24
         FONT 6 WIDGET-ID 400.

DEFINE FRAME fr_input
     bt_exit AT ROW 1.38 COL 76.17 WIDGET-ID 132
     bt_create AT ROW 1.43 COL 30.67 WIDGET-ID 44
     bt_edit AT ROW 1.43 COL 45.83 WIDGET-ID 46
     bt_delete AT ROW 1.43 COL 61 WIDGET-ID 124
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 47 ROW 18.33
         SIZE 94.17 BY 2.48
         FONT 6 WIDGET-ID 600.


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
         HEIGHT             = 19.81
         WIDTH              = 140.17
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
IF NOT C-Win:LOAD-ICON("wimage/iconhead.ico":U) THEN
    MESSAGE "Unable to load icon: wimage/iconhead.ico"
            VIEW-AS ALERT-BOX WARNING BUTTONS OK.
&ENDIF
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW C-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME fr_head
   FRAME-NAME                                                           */
/* SETTINGS FOR FRAME fr_input
                                                                        */
/* SETTINGS FOR FRAME fr_que1
                                                                        */
/* BROWSE-TAB br_que1 RECT-03 fr_que1 */
/* SETTINGS FOR FRAME fr_setup
                                                                        */
/* SETTINGS FOR FILL-IN fi_userent IN FRAME fr_setup
   ALIGN-L                                                              */
/* SETTINGS FOR FILL-IN fi_userev IN FRAME fr_setup
   ALIGN-L                                                              */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_que1
/* Query rebuild information for BROWSE br_que1
     _START_FREEFORM
OPEN QUERY br_que1 FOR EACH buff_uzpbrn USE-INDEX uzpbrn02
     WHERE buff_uzpbrn.typeg = nv_typeg NO-LOCK .
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

    IF AVAILA buff_uzpbrn THEN DO:
        ASSIGN
            fi_acno     = buff_uzpbrn.typcode   // producer
            rs_condi    = buff_uzpbrn.TYPE      // type job
            cb_prdck    = buff_uzpbrn.typpara   // progid
            cb_ispbox   = buff_uzpbrn.note3    // isp box
            rs_active   = buff_uzpbrn.note1     // active
            et_sentm    = buff_uzpbrn.note2     // email
            fi_effdat   = buff_uzpbrn.effdat     // start date
            fi_expdat   = buff_uzpbrn.expdat   // end date
            fi_name     = buff_uzpbrn.notee[3]  // create by
            fi_userent  = "Create by: " + buff_uzpbrn.notee[1]
            fi_userev   = IF buff_uzpbrn.notee[2] <> "" THEN "Editor by: " + buff_uzpbrn.notee[2] ELSE ""
            nv_recid    = RECID(buff_uzpbrn).
        
        DISP fi_acno rs_condi cb_prdck cb_ispbox rs_active et_sentm
            fi_effdat fi_expdat fi_userent fi_userent fi_userev  fi_name  WITH FRAME fr_setup.

        APPLY "LEAVE" TO fi_acno IN FRAME fr_setup.
        APPLY "LEAVE" TO fi_name IN FRAME fr_setup.
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_que1 C-Win
ON VALUE-CHANGED OF br_que1 IN FRAME fr_que1
DO:
    APPLY "MOUSE-SELECT-CLICK" TO br_que1 IN FRAME fr_que1.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fr_input
&Scoped-define SELF-NAME bt_create
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bt_create C-Win
ON CHOOSE OF bt_create IN FRAME fr_input /* CREATE */
DO:
    nv_status = "CREATOR".
    ENABLE ALL WITH FRAME fr_setup.
    DISABLE bt_create bt_edit bt_delete bt_exit WITH FRAME fr_input.
    DISABLE ALL WITH FRAME fr_que1.
    CLEAR FRAME fr_setup.
    et_sentm = "".
    fi_effdat = TODAY. fi_expdat = TODAY.
    DISP fi_effdat fi_expdat et_sentm WITH FRAME fr_setup.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bt_delete
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bt_delete C-Win
ON CHOOSE OF bt_delete IN FRAME fr_input /* DELETE */
DO:

    IF nv_recid = ? THEN DO: 
        MESSAGE "Please select producer code" VIEW-AS ALERT-BOX INFORMATION.
        RETURN.
    END.

    MESSAGE "Would you like to delete producer code?" 
        VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO
        TITLE "DELETE CODE"  UPDATE lChoice AS LOGICAL.
    
    IF NOT lChoice THEN RETURN.


    n_text = "PARAMETER WAITING DELETE".
    DISP n_text WITH FRAME  msgbox.

    RUN pd_delete.

    PAUSE 1 NO-MESSAGE.
    n_text = "PARAMETER DELETE " + n_text + " COMPLETE".
    HIDE FRAME msgbox.
    APPLY "CHOOSE" TO bu_cancal IN FRAME fr_setup.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bt_edit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bt_edit C-Win
ON CHOOSE OF bt_edit IN FRAME fr_input /* EDIT */
DO:
    IF TRIM(INPUT FRAME fr_setup fi_acno) = "" OR nv_recid = ? THEN DO:
        MESSAGE "Please select producer code" VIEW-AS ALERT-BOX INFORMATION.
        RETURN.
    END.
    FIND buff_uzpbrn WHERE RECID(buff_uzpbrn) = nv_recid NO-LOCK NO-ERROR.
    IF NOT AVAILA buff_uzpbrn  THEN DO: 
        MESSAGE "Not found producer code " + TRIM(INPUT FRAME fr_setup fi_acno) VIEW-AS ALERT-BOX INFORMATION.
        RETURN.
    END.
    nv_status = "EDIT".
    ENABLE ALL EXCEPT fi_acno WITH FRAME fr_setup.
    DISABLE ALL WITH FRAME fr_input.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bt_exit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bt_exit C-Win
ON CHOOSE OF bt_exit IN FRAME fr_input /* EXIT */
DO:
    APPLY "CLOSE":U TO THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fr_setup
&Scoped-define SELF-NAME bu_cancal
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_cancal C-Win
ON CHOOSE OF bu_cancal IN FRAME fr_setup /* Cancel */
DO:
    ENABLE ALL WITH FRAME fr_que1.
    DISABLE ALL WITH FRAME fr_setup.
    ENABLE ALL WITH FRAME fr_input.
    nv_status = "".
    nv_mflag = "".
    CLEAR FRAME fr_setup  ALL.
    et_sentm  = "". rs_condi = "Q". rs_active = "A". 
    DISP et_sentm rs_condi rs_active WITH FRAME fr_setup.
    RUN  WUT\WUTHEAD (c-win:handle,"wgwesatrm","Parameter Auto Transfer to Premium").
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_ok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_ok C-Win
ON CHOOSE OF bu_ok IN FRAME fr_setup /* OK */
DO:

    IF INPUT fi_acno = "" THEN DO:
        MESSAGE "Please add Producer code" VIEW-AS ALERT-BOX INFORMATION.
        APPLY "LEAVE" TO fi_acno IN FRAME fr_setup.
        RETURN NO-APPLY.
    END. 

    IF INPUT fi_name = "" THEN DO:
        MESSAGE "Please use user id with create inspection number" VIEW-AS ALERT-BOX INFORMATION.
        APPLY "LEAVE" TO fi_name IN FRAME fr_setup.
        RETURN NO-APPLY.
    END.

    IF INPUT fi_effdat > INPUT fi_expdat THEN DO:
        MESSAGE "Start date more than End date" VIEW-AS ALERT-BOX INFORMATION.
        APPLY "LEAVE" TO fi_effdat IN FRAME fr_setup.
        RETURN NO-APPLY.
    END.
    


    n_text = "PARAMETER WAITING " + nv_status.
    DISP n_text WITH FRAME msgbox.
    
    IF nv_status = "CREATOR" THEN DO:
        RUN pd_create.
    END.
    ELSE IF nv_status = "EDIT" THEN DO:
        RUN pd_edit.
    END.

    PAUSE 1 NO-MESSAGE.
    n_text = "PARAMETER " + nv_status + n_text + " COMPLETE".
    DISP n_text WITH FRAME msgbox.
    PAUSE 1 NO-MESSAGE.
    HIDE FRAME msgbox.
    RUN  WUT\WUTHEAD (c-win:handle,"wgwesatrm","Parameter Auto Transfer to Premium").
    IF nv_status = "CREATOR" THEN APPLY "CHOOSE" TO bu_cancal IN FRAME fr_setup.
    APPLY "MOUSE-SELECT-CLICK" TO br_que1 IN FRAME fr_que1.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME cb_ispbox
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cb_ispbox C-Win
ON VALUE-CHANGED OF cb_ispbox IN FRAME fr_setup
DO:
    cb_ispbox = INPUT cb_ispbox.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME cb_prdck
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cb_prdck C-Win
ON VALUE-CHANGED OF cb_prdck IN FRAME fr_setup
DO:
    cb_prdck = INPUT cb_prdck.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME et_sentm
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL et_sentm C-Win
ON LEAVE OF et_sentm IN FRAME fr_setup
DO:
    et_sentm = TRIM(INPUT et_sentm).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_acno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_acno C-Win
ON ENTRY OF fi_acno IN FRAME fr_setup
DO:
    fi_acno = CAPS(TRIM(INPUT fi_acno)).  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_acno C-Win
ON F9 OF fi_acno IN FRAME fr_setup
DO:
    RUN whp\whpacno1(OUTPUT fi_acno,OUTPUT  fi_pddes).
    IF fi_acno <> "" THEN DO:
         DISP fi_pddes  fi_acno WITH FRAME fr_setup.
        // APPLY "ENTRY" TO fi_acno WITH FRAME fr_input.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_acno C-Win
ON LEAVE OF fi_acno IN FRAME fr_setup
DO:
    fi_acno = CAPS(TRIM(INPUT fi_acno)).

    IF fi_acno <> "" THEN DO:
        FIND sicsyac.xmm600 WHERE sicsyac.xmm600.acno = fi_acno NO-LOCK NO-ERROR.
        IF NOT AVAIL sicsyac.xmm600 THEN DO: 
            MESSAGE "Not found Producer code " + fi_acno VIEW-AS ALERT-BOX INFORMATION.
            RETURN.
        END.
        ELSE DO: 
            fi_pddes = sicsyac.xmm600.NAME.
        END.
    END.
    DISP fi_pddes WITH FRAME fr_setup.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_effdat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_effdat C-Win
ON LEAVE OF fi_effdat IN FRAME fr_setup
DO:
    fi_effdat = INPUT fi_effdat.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_expdat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_expdat C-Win
ON LEAVE OF fi_expdat IN FRAME fr_setup
DO:
    fi_expdat = INPUT fi_expdat.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_name
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_name C-Win
ON LEAVE OF fi_name IN FRAME fr_setup
DO:

    fi_name = INPUT fi_name.
    fi_namdes = "".
    IF fi_name <> "" THEN DO:
        RUN wuw\wuwqfinid(INPUT fi_name, OUTPUT fi_namdes).
        DISP fi_namdes WITH FRAME fr_setup.
        IF fi_namdes = "not found" THEN DO:
            APPLY "LEAVE" TO fi_name.
            RETURN NO-APPLY.
        END.
    END.
    DISP fi_namdes WITH FRAME fr_setup.
    
   
        
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fr_que1
&Scoped-define SELF-NAME fi_search
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_search C-Win
ON LEAVE OF fi_search IN FRAME fr_que1
DO:
    fi_search = INPUT fi_search.
    IF fi_search <> "" THEN DO:
        OPEN QUERY br_que1 
            FOR EACH buff_uzpbrn USE-INDEX uzpbrn02 WHERE 
            buff_uzpbrn.typeg = nv_typeg  AND 
            buff_uzpbrn.typcode BEGINS fi_search NO-LOCK BY LENGTH(buff_uzpbrn.typcode).
    END.
    ELSE DO:
        OPEN QUERY br_que1 
             FOR EACH buff_uzpbrn USE-INDEX uzpbrn02 WHERE 
             buff_uzpbrn.typeg = nv_typeg NO-LOCK BY LENGTH(buff_uzpbrn.typcode).
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_search C-Win
ON VALUE-CHANGED OF fi_search IN FRAME fr_que1
DO:
    fi_search = INPUT fi_search.
    IF fi_search <> "" THEN DO:
        OPEN QUERY br_que1 
            FOR EACH buff_uzpbrn USE-INDEX uzpbrn02 WHERE 
            buff_uzpbrn.typeg = nv_typeg  AND 
            buff_uzpbrn.typcode BEGINS fi_search NO-LOCK BY LENGTH(buff_uzpbrn.typcode).
    END.
    ELSE DO:
        OPEN QUERY br_que1 
             FOR EACH buff_uzpbrn USE-INDEX uzpbrn02 WHERE 
             buff_uzpbrn.typeg = nv_typeg AND buff_uzpbrn.typcode >= fi_search  NO-LOCK BY LENGTH(buff_uzpbrn.typcode).
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fr_setup
&Scoped-define SELF-NAME rs_active
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL rs_active C-Win
ON VALUE-CHANGED OF rs_active IN FRAME fr_setup
DO:
    rs_active = INPUT rs_active.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME rs_condi
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL rs_condi C-Win
ON VALUE-CHANGED OF rs_condi IN FRAME fr_setup
DO:
    rs_condi = INPUT rs_condi.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fr_head
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
  RUN  WUT\WUTHEAD (c-win:handle,"wgwesatrn","Parameter GW Auto Transfer to Premium").
  RUN  WUT\WUTWICEN (c-win:handle). 


  DISABLE ALL WITH FRAME fr_setup .
  n_text = "Loading.......".
  DISP n_text WITH FRAME msgbox.
  RUN pd_getpara.
  CLEAR FRAME msgbox.
  HIDE FRAME msgbox.
  OPEN QUERY buff_uzpbrn FOR EACH buff_uzpbrn USE-INDEX uzpbrn02 WHERE buff_uzpbrn.typeg = nv_typeg NO-LOCK .
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
  VIEW FRAME fr_head IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_head}
  DISPLAY fi_search 
      WITH FRAME fr_que1 IN WINDOW C-Win.
  ENABLE RECT-03 br_que1 fi_search 
      WITH FRAME fr_que1 IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_que1}
  DISPLAY fi_acno rs_condi cb_prdck cb_ispbox fi_name fi_effdat fi_expdat 
          rs_active et_sentm fi_pddes fi_namdes fi_userent fi_userev 
      WITH FRAME fr_setup IN WINDOW C-Win.
  ENABLE fi_acno rs_condi cb_prdck cb_ispbox fi_name fi_effdat fi_expdat 
         rs_active et_sentm bu_ok bu_cancal fi_pddes fi_namdes fi_userent 
         fi_userev 
      WITH FRAME fr_setup IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_setup}
  ENABLE bt_exit bt_create bt_edit bt_delete 
      WITH FRAME fr_input IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_input}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_create C-Win 
PROCEDURE pd_create :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
    DEF VAR selcret AS RECID INIT ?.
    FIND FIRST buff_uzpbrn USE-INDEX uzpbrn02 WHERE 
                   buff_uzpbrn.typeg   = nv_typeg  AND 
                   buff_uzpbrn.typcode = fi_acno   NO-LOCK NO-ERROR.
    IF NOT AVAILA buff_uzpbrn THEN DO:                                  
        CREATE buff_uzpbrn.
        ASSIGN
            buff_uzpbrn.typeg     = nv_typeg   // group
            buff_uzpbrn.typcode   = fi_acno    // producer
            buff_uzpbrn.TYPE      = rs_condi   // type job
            buff_uzpbrn.typpara   = cb_prdck   // progid
            buff_uzpbrn.note3     = cb_ispbox  // isp box
            buff_uzpbrn.note1     = rs_active  // active
            buff_uzpbrn.note2     = et_sentm   // email
            buff_uzpbrn.notee[3]  = fi_name    // create by
            buff_uzpbrn.effdat    = fi_effdat  // start date
            buff_uzpbrn.expdat    = fi_expdat  // end date
            buff_uzpbrn.notee[1]  = USERID(LDBNAME(1)) + " " + STRING(TODAY,"99/99/9999") + " " + STRING(TIME,"HH:MM:SS")
            selcret               = RECID(buff_uzpbrn).


        
    END.
    ELSE DO:
        MESSAGE "Found this code " + fi_acno + " in the system" VIEW-AS ALERT-BOX INFORMATION.
    END.
    OPEN QUERY br_que1 FOR EACH buff_uzpbrn USE-INDEX uzpbrn02 WHERE buff_uzpbrn.typeg = nv_typeg NO-LOCK BY LENGTH(buff_uzpbrn.typcode).
    REPOSITION br_que1 TO RECID selcret NO-ERROR.
    

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
    FIND buff_uzpbrn WHERE RECID(buff_uzpbrn) = nv_recid NO-ERROR.
    IF AVAILA buff_uzpbrn THEN DO: 
        DELETE buff_uzpbrn.
    END.
    ELSE DO:
        IF LOCKED buff_uzpbrn THEN MESSAGE "Parameter record is locked" VIEW-AS ALERT-BOX ERROR TITLE "PARAMETER ERROR DELETE!".
        ELSE MESSAGE "Parameter was not delete" VIEW-AS ALERT-BOX ERROR TITLE "PARAMETER ERROR DELETE!".
    END.
    RELEASE buff_uzpbrn NO-ERROR.

    OPEN QUERY  br_que1 FOR EACH buff_uzpbrn USE-INDEX uzpbrn02 WHERE buff_uzpbrn.typeg = nv_typeg NO-LOCK BY LENGTH(buff_uzpbrn.typcode).
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_edit C-Win 
PROCEDURE pd_edit :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    FIND FIRST buff_uzpbrn USE-INDEX uzpbrn02 WHERE 
                   buff_uzpbrn.typeg   = nv_typeg  AND 
                   buff_uzpbrn.typcode = fi_acno   NO-ERROR.
    IF AVAILA buff_uzpbrn THEN DO:                                  
        ASSIGN
            buff_uzpbrn.TYPE      = rs_condi   // type job
            buff_uzpbrn.typpara   = cb_prdck   // progid
            buff_uzpbrn.note3     = cb_ispbox  // isp box
            buff_uzpbrn.note1     = rs_active  // active
            buff_uzpbrn.note2     = et_sentm   // email
            buff_uzpbrn.notee[3]  = fi_name 
            buff_uzpbrn.effdat    = fi_effdat  // start date
            buff_uzpbrn.expdat    = fi_expdat  // end date
            buff_uzpbrn.notee[2]       = USERID(LDBNAME(1)) + " " + STRING(TODAY,"99/99/9999") + " " + STRING(TIME,"HH:MM:SS").
        

            OPEN QUERY br_que1 FOR EACH buff_uzpbrn USE-INDEX uzpbrn02 WHERE buff_uzpbrn.typeg = nv_typeg  NO-LOCK BY LENGTH(buff_uzpbrn.typcode).
            REPOSITION  br_que1 TO RECID RECID(buff_uzpbrn) NO-ERROR.
    END.
    ELSE DO:
        MESSAGE "Not found this code in the system" VIEW-AS ALERT-BOX INFORMATION.
    END.
    RELEASE buff_uzpbrn NO-ERROR.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_getpara C-Win 
PROCEDURE pd_getpara :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR progid AS CHAR INIT "".
FOR EACH stat.uzpdat USE-INDEX uzpdat02 WHERE 
    stat.uzpdat.TYPE      = "gw_auto"    AND
    stat.uzpdat.typpara   <> ""          AND
    stat.uzpdat.expdat    >= TODAY       AND
    stat.uzpdat.effdat    <= TODAY       NO-LOCK:

    IF progid = ""  THEN progid = stat.uzpdat.typpara + "," + stat.uzpdat.typname.
    ELSE progid = progid + "," + stat.uzpdat.typpara + "," + stat.uzpdat.typname.

END.

cb_prdck:LIST-ITEM-PAIRS IN FRAME fr_setup = progid.
cb_prdck = ENTRY(2,progid).

DISP cb_prdck WITH FRAME fr_setup.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

