&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          brstat           PROGRESS
*/
&Scoped-define WINDOW-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS C-Win 
/*------------------------------------------------------------------------
File: 
Description: 
Input Parameters:<none>
Output Parameters:<none>
Author: 
Created: ------------------------------------------------------------------------*/
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
wgwimscb.w :  Import noitfy and Inspection file on table tlt( brstat)  
Program Import Text File    - File detail notify
                            -  File detail Inspection
Create  by   : Ranu I. A61-0024 Date: 20/01/2018
copy program : wgwimpa60.w  
Connect    : GW_SAFE -LD SIC_BRAN, GW_STAT -LD BRSTAT ,SICSYAC  ,SICUW (not connect dbstat)*/
/*+++++++++++++++++++++++++++++++++++++++++++++++*/
DEF     SHARED VAR n_User    AS CHAR.  /*A60-0118*/
DEF     SHARED VAR n_Passwd  AS CHAR.  /*A60-0118*/
DEFINE VAR nv_daily       AS CHARACTER FORMAT "X(1024)"     INITIAL ""  NO-UNDO.
DEFINE VAR nv_reccnt      AS INT  INIT  0.
DEFINE VAR nv_dri_cnt     AS INT  INIT  0.
DEFINE VAR nv_completecnt AS INT  INIT  0.
DEFINE VAR nv_updatecnt   AS INT  INIT  0.
DEFINE VAR nv_dri_complet AS INT  INIT  0.
DEFINE VAR nv_enttim      AS CHAR INIT  "".
DEFINE VAR nv_Load        AS LOGIC  INIT   Yes.
DEF    VAR nv_type        AS CHAR FORMAT "x(5)" INIT "".
/*--------------------------สำหรับข้อมูลกรมธรรม์  -------------------------*/
DEFINE TEMP-TABLE wdetail NO-UNDO
    field cmr_code   as CHAR FORMAT "X(50)"   init ""   /*No.                */       
    field not_date   as CHAR FORMAT "X(15)"   init ""   /*วันที่ส่งข้อมูล    */    
    field cedcode    as CHAR FORMAT "X(15)"   init ""   /*APPLICATION_ID     */    
    field pol_title  as CHAR FORMAT "X(25)"   init ""   /*TITLE_NAME         */    
    field pol_fname  as CHAR FORMAT "X(100)"  init ""   /*INSURED_NAME       */    
    field pol_lname  as CHAR FORMAT "X(100)"  init ""   /*INSURED_LASTNAME   */    
    field icno       as CHAR FORMAT "X(15)"   init ""   /*CUSTOMER_ID        */    
    field bdate      as CHAR FORMAT "X(15)"   init ""   /*BIRDTE             */    
    field age        as CHAR FORMAT "X(2)"    init ""   /*AGE                */    
    field covcod     as CHAR FORMAT "X(2)"    init ""   /*Plan               */    
    field ins_amt    as CHAR FORMAT "X(20)"   init ""   /*Sum Insurance      */    
    field premtotal  as CHAR FORMAT "X(15)"   init ""   /*ค่าเบี้ย PA        */    
    field addr1      as CHAR FORMAT "X(250)"  init ""   /*ADDR1              */    
    field addr2      as CHAR FORMAT "X(100)"  init ""   /*AMPHUR             */    
    field addr3      as CHAR FORMAT "X(100)"  init ""   /*PROVINCE_TH        */    
    field addr4      as CHAR FORMAT "X(100)"  init ""   /*POST_CODE          */    
    field tel        as CHAR FORMAT "X(15) "  init ""   /*MOBILE_NUMBER      */    
    field phone      as CHAR FORMAT "X(10)"   init ""   /*PHONE_NUMBER       */    
    field comdat     as CHAR FORMAT "X(15)"   init ""   /*Eff.Date */ 
    FIELD remark     AS CHAR FORMAT "x(250)"  INIT ""
    FIELD pass       AS CHAR FORMAT "x(2)"    INIT ""
    FIELD comment    AS CHAR FORMAT "x(100)"  INIT "" .
    
def var n_cmr_code    as CHAR FORMAT "X(50)"   init "".   /*No.                */       
def var n_not_date    as CHAR FORMAT "X(15)"   init "".   /*วันที่ส่งข้อมูล    */       
def var n_cedcode     as CHAR FORMAT "X(15)"   init "".   /*APPLICATION_ID     */       
def var n_pol_title   as CHAR FORMAT "X(25)"   init "".   /*TITLE_NAME         */       
def var n_pol_fname   as CHAR FORMAT "X(100)"  init "".   /*INSURED_NAME       */       
def var n_pol_lname   as CHAR FORMAT "X(100)"  init "".   /*INSURED_LASTNAME   */       
def var n_icno        as CHAR FORMAT "X(15)"   init "".   /*CUSTOMER_ID        */       
def var n_bdate       as CHAR FORMAT "X(15)"   init "".   /*BIRDTE             */       
def var n_age         as CHAR FORMAT "X(2)"    init "".   /*AGE                */       
def var n_covcod      as CHAR FORMAT "X(2)"    init "".   /*Plan               */       
def var n_ins_amt     as CHAR FORMAT "X(20)"   init "".   /*Sum Insurance      */       
def var n_premtotal   as CHAR FORMAT "X(15)"   init "".   /*ค่าเบี้ย PA        */       
def var n_addr1       as CHAR FORMAT "X(250)"  init "".   /*ADDR1              */       
def var n_addr2       as CHAR FORMAT "X(100)"  init "".   /*AMPHUR             */       
def var n_addr3       as CHAR FORMAT "X(100)"  init "".   /*PROVINCE_TH        */       
def var n_addr4       as CHAR FORMAT "X(100)"  init "".   /*POST_CODE          */       
def var n_tel         as CHAR FORMAT "X(15) "  init "".   /*MOBILE_NUMBER      */       
def var n_phone       as CHAR FORMAT "X(10)"   init "".   /*PHONE_NUMBER       */       
def var n_comdat      as CHAR FORMAT "X(15)"   init "" . /*Eff.Date */                 
DEF VAR n_remark1      AS CHAR FORMAT "x(250)" INIT "".
DEF VAR n_remark2      AS CHAR FORMAT "x(250)" INIT "".
DEF BUFFER bfwdetail FOR wdetail.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main
&Scoped-define BROWSE-NAME br_imptxt

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES tlt

/* Definitions for BROWSE br_imptxt                                     */
&Scoped-define FIELDS-IN-QUERY-br_imptxt tlt.nor_noti_ins tlt.ins_name ~
tlt.rec_addr5 tlt.nor_coamt tlt.comp_coamt tlt.gendat tlt.filler2 
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_imptxt 
&Scoped-define QUERY-STRING-br_imptxt FOR EACH tlt NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-br_imptxt OPEN QUERY br_imptxt FOR EACH tlt NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-br_imptxt tlt
&Scoped-define FIRST-TABLE-IN-QUERY-br_imptxt tlt


/* Definitions for FRAME fr_main                                        */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS fi_loaddat fi_compa ra_txttyp fi_producer ~
fi_agent fi_filename bu_file bu_ok bu_exit br_imptxt bu_hpacno1 bu_hpacno2 ~
RECT-1 RECT-387 RECT-388 
&Scoped-Define DISPLAYED-OBJECTS fi_loaddat fi_compa ra_txttyp fi_producer ~
fi_agent fi_filename fi_proname fi_impcnt fi_completecnt fi_proname2 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bu_exit 
     LABEL "EXIT" 
     SIZE 8.5 BY 1
     FONT 6.

DEFINE BUTTON bu_file 
     LABEL "..." 
     SIZE 4 BY 1.

DEFINE BUTTON bu_hpacno1 
     IMAGE-UP FILE "I:/Safety/WALP10/WIMAGE/help.bmp":U
     LABEL "" 
     SIZE 4 BY 1.

DEFINE BUTTON bu_hpacno2 
     IMAGE-UP FILE "I:/Safety/WALP10/WIMAGE/help.bmp":U
     LABEL "" 
     SIZE 4 BY 1.

DEFINE BUTTON bu_ok 
     LABEL "OK" 
     SIZE 8.5 BY 1
     FONT 6.

DEFINE VARIABLE fi_agent AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 16.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_compa AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 18 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_completecnt AS INTEGER FORMAT ">,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 11.5 BY 1
     BGCOLOR 10 FGCOLOR 6 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_filename AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 76 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_impcnt AS INTEGER FORMAT ">,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 11 BY 1
     BGCOLOR 10 FGCOLOR 6 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_loaddat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 16.5 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_producer AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 16.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_proname AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 45.67 BY 1
     BGCOLOR 20 FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE fi_proname2 AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 45.67 BY 1
     BGCOLOR 20 FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE ra_txttyp AS INTEGER INITIAL 1 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "ไฟล์แจ้งงาน", 1,
"ไฟล์ยกเลิก", 2
     SIZE 66.5 BY .95
     BGCOLOR 29 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132 BY 23.76
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-387
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 10.17 BY 1.29
     BGCOLOR 2 .

DEFINE RECTANGLE RECT-388
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 10.17 BY 1.29
     BGCOLOR 6 .

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_imptxt FOR 
      tlt SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_imptxt
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_imptxt C-Win _STRUCTURED
  QUERY br_imptxt NO-LOCK DISPLAY
      tlt.nor_noti_ins COLUMN-LABEL "เลขรับแจ้ง" FORMAT "x(25)":U
            WIDTH 17.17
      tlt.ins_name FORMAT "x(30)":U WIDTH 26.83
      tlt.rec_addr5 COLUMN-LABEL "นามสกุล" FORMAT "x(30)":U WIDTH 24.83
      tlt.nor_coamt COLUMN-LABEL "ทุนประกัน" FORMAT "->,>>>,>>>,>>9.99":U
      tlt.comp_coamt COLUMN-LABEL "เบี้ยประกันภัย" FORMAT "->>,>>>,>>9.99":U
      tlt.gendat COLUMN-LABEL "วันที่คุ้มครอง" FORMAT "99/99/9999":U
            WIDTH 13.5
      tlt.filler2 COLUMN-LABEL "หมายเหตุ" FORMAT "x(100)":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 129.17 BY 15.62
         BGCOLOR 15  ROW-HEIGHT-CHARS .52.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     fi_loaddat AT ROW 1.81 COL 36.17 COLON-ALIGNED NO-LABEL
     fi_compa AT ROW 1.81 COL 72.5 COLON-ALIGNED NO-LABEL
     ra_txttyp AT ROW 2.91 COL 38.5 NO-LABEL
     fi_producer AT ROW 3.95 COL 36.17 COLON-ALIGNED NO-LABEL
     fi_agent AT ROW 5.1 COL 36.17 COLON-ALIGNED NO-LABEL
     fi_filename AT ROW 6.24 COL 36.17 COLON-ALIGNED NO-LABEL
     bu_file AT ROW 6.24 COL 114.5
     bu_ok AT ROW 7.52 COL 108.83
     bu_exit AT ROW 7.52 COL 119.67
     br_imptxt AT ROW 8.86 COL 3.17
     fi_proname AT ROW 3.95 COL 57.33 COLON-ALIGNED NO-LABEL
     fi_impcnt AT ROW 7.57 COL 36.5 COLON-ALIGNED NO-LABEL
     fi_completecnt AT ROW 7.57 COL 74 COLON-ALIGNED NO-LABEL
     fi_proname2 AT ROW 5.1 COL 57.33 COLON-ALIGNED NO-LABEL
     bu_hpacno1 AT ROW 3.95 COL 55.17
     bu_hpacno2 AT ROW 5.1 COL 55.17
     "รายการ" VIEW-AS TEXT
          SIZE 7 BY 1 AT ROW 7.57 COL 50.83
          BGCOLOR 1 FGCOLOR 7 FONT 6
     "                   วันที่ไฟล์แจ้งงาน :" VIEW-AS TEXT
          SIZE 29 BY .95 AT ROW 1.81 COL 7.67
          BGCOLOR 1 FGCOLOR 7 FONT 6
     "                  Producer Code  :" VIEW-AS TEXT
          SIZE 29 BY 1 AT ROW 4 COL 7.67
          BGCOLOR 1 FGCOLOR 7 FONT 6
     "Company Code :" VIEW-AS TEXT
          SIZE 16 BY .95 AT ROW 1.81 COL 57.83
          BGCOLOR 1 FGCOLOR 7 FONT 6
     "รายการ" VIEW-AS TEXT
          SIZE 7 BY 1 AT ROW 7.57 COL 88.33
          BGCOLOR 1 FGCOLOR 7 FONT 6
     "นำเข้าระบบได้  :":60 VIEW-AS TEXT
          SIZE 15 BY 1 AT ROW 7.57 COL 59.83
          BGCOLOR 1 FGCOLOR 7 FONT 6
     "          กรุณาป้อนชื่อไฟล์นำเข้า :" VIEW-AS TEXT
          SIZE 29 BY 1 AT ROW 6.24 COL 7.67
          BGCOLOR 1 FGCOLOR 7 FONT 6
     "               ข้อมูลนำเข้าทั้งหมด  :":50 VIEW-AS TEXT
          SIZE 29 BY 1 AT ROW 7.57 COL 7.67
          BGCOLOR 1 FGCOLOR 7 FONT 6
     "                      Agent Code  :" VIEW-AS TEXT
          SIZE 29 BY 1 AT ROW 5.1 COL 7.67
          BGCOLOR 1 FGCOLOR 7 FONT 6
     "                   เลือกข้อมูลนำเข้า  :" VIEW-AS TEXT
          SIZE 29 BY .95 AT ROW 2.91 COL 7.67
          BGCOLOR 1 FGCOLOR 7 FONT 6
     RECT-1 AT ROW 1.1 COL 1.67
     RECT-387 AT ROW 7.38 COL 108
     RECT-388 AT ROW 7.38 COL 118.83
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133.5 BY 24.05
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
  CREATE WINDOW C-Win ASSIGN
         HIDDEN             = YES
         TITLE              = "Import text file SCBPT"
         HEIGHT             = 23.71
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
         MESSAGE-AREA       = no
         SENSITIVE          = yes.
ELSE {&WINDOW-NAME} = CURRENT-WINDOW.

&IF '{&WINDOW-SYSTEM}' NE 'TTY' &THEN
IF NOT C-Win:LOAD-ICON("I:/Safety/WALP10/WIMAGE/safety.ico":U) THEN
    MESSAGE "Unable to load icon: I:/Safety/WALP10/WIMAGE/safety.ico"
            VIEW-AS ALERT-BOX WARNING BUTTONS OK.
&ENDIF
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW C-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME fr_main
   FRAME-NAME Custom                                                    */
/* BROWSE-TAB br_imptxt bu_exit fr_main */
ASSIGN 
       bu_file:AUTO-RESIZE IN FRAME fr_main      = TRUE.

/* SETTINGS FOR FILL-IN fi_completecnt IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_impcnt IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_proname IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_proname2 IN FRAME fr_main
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_imptxt
/* Query rebuild information for BROWSE br_imptxt
     _TblList          = "brstat.tlt"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _FldNameList[1]   > brstat.tlt.nor_noti_ins
"tlt.nor_noti_ins" "เลขรับแจ้ง" ? "character" ? ? ? ? ? ? no ? no no "17.17" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[2]   > brstat.tlt.ins_name
"tlt.ins_name" ? "x(30)" "character" ? ? ? ? ? ? no ? no no "26.83" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   > brstat.tlt.rec_addr5
"tlt.rec_addr5" "นามสกุล" "x(30)" "character" ? ? ? ? ? ? no ? no no "24.83" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   > brstat.tlt.nor_coamt
"tlt.nor_coamt" "ทุนประกัน" ? "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   > brstat.tlt.comp_coamt
"tlt.comp_coamt" "เบี้ยประกันภัย" ? "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[6]   > brstat.tlt.gendat
"tlt.gendat" "วันที่คุ้มครอง" ? "date" ? ? ? ? ? ? no ? no no "13.5" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[7]   > brstat.tlt.filler2
"tlt.filler2" "หมายเหตุ" "x(100)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _Query            is NOT OPENED
*/  /* BROWSE br_imptxt */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Import text file SCBPT */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Import text file SCBPT */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_exit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_exit C-Win
ON CHOOSE OF bu_exit IN FRAME fr_main /* EXIT */
DO:
  Apply "Close" To  This-procedure.
  Return no-apply.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_file
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_file C-Win
ON CHOOSE OF bu_file IN FRAME fr_main /* ... */
DO:
    DEFINE VARIABLE cvData        AS CHARACTER NO-UNDO.
    DEFINE VARIABLE OKpressed AS LOGICAL INITIAL TRUE.
    SYSTEM-DIALOG GET-FILE cvData
        TITLE      "Choose Data File to Import ..."
        /*      FILTERS    "Text Documents" "*.txt"    */
        FILTERS    /* "Text Documents"   "*.txt",
        "Data Files (*.*)"     "*.*"*/
        "Text Documents" "*.csv"
        
        
        MUST-EXIST
        USE-FILENAME
        UPDATE OKpressed.
    IF OKpressed = TRUE THEN DO:
        fi_filename  = cvData.
        DISP fi_filename WITH FRAME fr_main.     
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_hpacno1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_hpacno1 C-Win
ON CHOOSE OF bu_hpacno1 IN FRAME fr_main
DO:
   Def   var     n_acno       As  Char.
   Def   var     n_agent      As  Char.    
     
   Run whp\whpacno1(output  n_acno,
                                      output  n_agent).
                                          
     If  n_acno  <>  ""  Then  fi_producer =  n_acno.
     
     disp  fi_producer  with frame  fr_main.

     Apply "Entry"  to  fi_producer.
     Return no-apply.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_hpacno2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_hpacno2 C-Win
ON CHOOSE OF bu_hpacno2 IN FRAME fr_main
DO:
   Def   var     n_acno       As  Char.
   Def   var     n_agent      As  Char.    
     
   Run whp\whpacno1(output  n_acno,output  n_agent).
                                          
     If  n_acno  <>  ""  Then  fi_agent =  n_acno.
     
     disp  fi_agent  with frame  fr_main.

     Apply "Entry"  to  fi_agent.
     Return no-apply.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_ok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_ok C-Win
ON CHOOSE OF bu_ok IN FRAME fr_main /* OK */
DO:
    DEF VAR n_text AS CHAR FORMAT "x(70)" INIT "" .
    ASSIGN 
        nv_daily     = ""
        nv_reccnt    = 0.
    For each  wdetail:
        DELETE  wdetail.
    END.
    IF ra_txttyp = 1 Then n_text = "ต้องการนำเข้า ไฟล์แจ้งงาน หรือไม่".
    ELSE n_text = "ต้องการนำเข้า ไฟล์ยกเลิก (CANCEL) หรือไม่".

    MESSAGE n_text VIEW-AS ALERT-BOX QUESTION BUTTON YES-NO TITLE "นำเข้าข้อมูล" UPDATE choic AS LOGICAL.
    CASE choic:
        WHEN TRUE THEN DO:
            Run  Import_File. 
        END.
        WHEN FALSE THEN DO:
            RETURN NO-APPLY.
        END.
    END CASE.

    RELEASE brstat.tlt.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_agent
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_agent C-Win
ON LEAVE OF fi_agent IN FRAME fr_main
DO:
    fi_agent = INPUT fi_agent .

    If Input  fi_agent  =  ""  Then do:
        Apply "Choose"  to  bu_hpacno2.
        Return no-apply.
    END.
    FIND sicsyac.xmm600 USE-INDEX xmm60001   WHERE
        xmm600.acno  =  Input fi_agent    NO-LOCK NO-ERROR NO-WAIT.
    IF NOT AVAIL sicsyac.xmm600 THEN DO:
        Message  "Not on Name & Address Master File xmm600" 
            View-as alert-box.
        Apply "Entry" To  fi_agent.
        Return no-apply.
    END.
    ELSE 
        ASSIGN fi_proname2 =  TRIM(xmm600.ntitle) + "  "  + TRIM(sicsyac.xmm600.name) .
        fi_agent =  CAPS(INPUT fi_agent).
    Disp  fi_agent  fi_proname2  WITH Frame  fr_main.                 

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_compa
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_compa C-Win
ON LEAVE OF fi_compa IN FRAME fr_main
DO:
    fi_compa =  INPUT  fi_compa.
    Disp  fi_compa   WITH Frame  fr_main.                 

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_filename
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_filename C-Win
ON LEAVE OF fi_filename IN FRAME fr_main
DO:
  fi_filename  =  Input  fi_filename .
  Disp  fi_filename with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_loaddat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_loaddat C-Win
ON LEAVE OF fi_loaddat IN FRAME fr_main
DO:
    fi_loaddat  =  Input  fi_loaddat.
    Disp fi_loaddat  with frame  fr_main. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_producer
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_producer C-Win
ON LEAVE OF fi_producer IN FRAME fr_main
DO:
    /*
    If  Input  fi_producer  =  ""  Then do:
       Message "กรุณาระบุรหัสผู้หางาน "  View-as alert-box.
       Apply "Entry" to fi_producer.
       End.
    */
    If Input  fi_producer  =  ""  Then do:
        Apply "Choose"  to  bu_hpacno1.
        Return no-apply.
    END.
    FIND sicsyac.xmm600 USE-INDEX xmm60001   WHERE
        xmm600.acno  =  Input fi_producer    NO-LOCK NO-ERROR NO-WAIT.
    IF NOT AVAIL sicsyac.xmm600 THEN DO:
        Message  "Not on Name & Address Master File xmm600" 
            View-as alert-box.
        Apply "Entry" To  fi_producer.
        Return no-apply.
    END.
    ELSE 
        ASSIGN fi_proname =  TRIM(xmm600.ntitle) + "  "  + TRIM(sicsyac.xmm600.name) .
    fi_producer =  CAPS(INPUT fi_producer).
    Disp  fi_producer  fi_proname  WITH Frame  fr_main.                 

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ra_txttyp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_txttyp C-Win
ON ENTER OF ra_txttyp IN FRAME fr_main
DO:
  Apply "Entry" to fi_producer.
  Return no-apply.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_txttyp C-Win
ON VALUE-CHANGED OF ra_txttyp IN FRAME fr_main
DO:
  ra_txttyp  =  Input  ra_txttyp.
  Disp  ra_txttyp  with  frame fr_main.

  IF ra_txttyp = 3 THEN DO:
      DISABLE fi_Producer fi_agent bu_hpacno1 bu_hpacno2 WITH FRAME fr_main.
      fi_producer:BGCOLOR = 19.
      fi_agent:BGCOLOR = 19.
  END.
  ELSE DO:
      ENABLE fi_Producer fi_agent bu_hpacno1 bu_hpacno2 WITH FRAME fr_main.
      fi_producer:BGCOLOR = 15.
      fi_agent:BGCOLOR = 15.

  END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br_imptxt
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
  
     /********************  T I T L E   F O R  C - W I N  ****************/
  DEF  VAR  gv_prgid   AS   CHAR.
  DEF  VAR  gv_prog    AS   CHAR.
  
  gv_prgid = "wgwimpa60".
  gv_prog  = "Import Text File PAM60 (PIMB) ".
  RUN  WUT\WUTHEAD (c-win:handle,gv_prgid,gv_prog).

/*********************************************************************/ 

  /*CURRENT-WINDOW:WINDOW-STATE = WINDOW-MAXIMIZED.*/
  SESSION:DATA-ENTRY-RETURN = YES.
  
  /*RECT-4:MOVE-TO-TOP().
  RECT-75:MOVE-TO-TOP().  */
 
  Hide Frame  fr_gen  .
  ASSIGN  
      fi_loaddat  =  today
      fi_compa    = "PMIB"
      fi_producer = ""
      fi_agent    = ""
      ra_txttyp   = 1 .
  disp  fi_loaddat  fi_producer ra_txttyp fi_compa fi_agent with  frame  fr_main.
  
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
  DISPLAY fi_loaddat fi_compa ra_txttyp fi_producer fi_agent fi_filename 
          fi_proname fi_impcnt fi_completecnt fi_proname2 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE fi_loaddat fi_compa ra_txttyp fi_producer fi_agent fi_filename bu_file 
         bu_ok bu_exit br_imptxt bu_hpacno1 bu_hpacno2 RECT-1 RECT-387 RECT-388 
      WITH FRAME fr_main IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE import_file C-Win 
PROCEDURE import_file :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH  wdetail :
    DELETE  wdetail.
END.

RUN Proc_Cleardata.
INPUT FROM VALUE(fi_FileName).
REPEAT:
    IMPORT DELIMITER "|"
        n_cmr_code   
        n_not_date
        n_cedcode
        n_pol_title 
        n_pol_fname 
        n_pol_lname 
        n_icno
        n_bdate
        n_age
        n_covcod
        n_ins_amt 
        n_premtotal
        n_addr1
        n_addr2
        n_addr3
        n_addr4
        n_tel    
        n_phone  
        n_comdat
        n_remark1 
        n_remark2 .
       IF n_cmr_code   = "" THEN  NEXT.
       ELSE IF index(n_cmr_code,"No") <> 0 THEN NEXT.
       ELSE IF INDEX(n_cmr_code,"Mail") <> 0  THEN NEXT.
       ELSE DO:
           RUN proc_create.
           RUN proc_cleardata.
       END.
END.  /* repeat  */ 

ASSIGN nv_reccnt       = 0
       nv_completecnt  = 0 . 

Run  proc_noti_tlt. 

If  nv_completecnt  <>  0  Then do:
    Enable br_imptxt  With frame fr_main.
End. 

fi_completecnt  =  nv_completecnt.
fi_impcnt       =  nv_reccnt.

Disp fi_completecnt   fi_impcnt with frame  fr_main.
Message "Load  Data Finnish "  View-as alert-box.  
Run Open_tlt.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Open_tlt C-Win 
PROCEDURE Open_tlt :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
IF ra_txttyp = 1  THEN DO:
    Open Query br_imptxt  For each tlt  Use-index tlt01  where
               tlt.trndat     =  fi_loaddat   and
               index(tlt.releas,"Cancel") = 0 AND
               tlt.genusr     =  fi_compa     AND 
               tlt.flag       =  "M60"        NO-LOCK .
END.
ELSE IF ra_txttyp = 2 THEN do: 
    Open Query br_imptxt  For each tlt  Use-index tlt01  where
               tlt.trndat     =  fi_loaddat   and
               index(tlt.releas,"Cancel") <> 0 AND
               tlt.genusr     =  fi_compa      AND 
               tlt.flag       =  "M60"       NO-LOCK .
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chkaddr C-Win 
PROCEDURE proc_chkaddr :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_name AS CHAR FORMAT "x(60)" INIT "" .
DEF VAR nv_lname AS CHAR FORMAT "x(60)" INIT "" .
DEF VAR n_length AS INT INIT 0.
DEF VAR n AS CHAR INIT "".
DEF VAR n_day   AS int init 0.  
DEF VAR n_month AS int init 0.  
DEF VAR n_year  AS int init 0.
DEF VAR n_date AS DATE .
DO:
    ASSIGN n_date = ?
           n_day    = 0
           n_month  = 0
           n_year   = 0
           nv_name   = ""
           nv_lname  = "".

    IF n_comdat <> ""  THEN DO:
        n_date = DATE(n_comdat) .
        IF YEAR(n_date) > YEAR(TODAY) THEN DO:
           ASSIGN n_day      = DAY(n_date)
                  n_month    = MONTH(n_date)
                  n_year     = (YEAR(n_date) - 543)
                  n_comdat   = STRING(n_day,"99") + "/" +
                               STRING(n_month,"99") + "/" +
                               STRING(n_year,"9999") .
                 /* n_expdat   = STRING(n_day,"99") + "/" +
                               STRING(n_month,"99") + "/" +
                               STRING(n_year + 1,"9999")
                  n_firstdat = n_effdat .*/
        END.
    END.
    /*IF n_bdate <> ""  THEN DO:
        ASSIGN  n_day    = 0
                n_month  = 0
                n_year   = 0
                n_day    = DAY(DATE(n_bdate)) 
                n_month  = MONTH(DATE(n_bdate)) 
                n_year   = (YEAR(DATE(n_bdate)) - 543 )
                n_bdate  = STRING(n_day,"99") + "/" +
                           STRING(n_month,"99") + "/" +
                           STRING(n_year,"9999").
    END.*/
    /*---- check Address --------------*/
   /* IF INDEX(n_addr1,"ส่งถึง") <> 0 THEN DO:
        IF INDEX(n_addr1,"(")  <> 0 THEN n_addr1  = trim(REPLACE(n_addr1,"("," ")).
        IF INDEX(n_addr1,")")  <> 0 THEN n_addr1  = trim(REPLACE(n_addr1,")"," ")).
        IF INDEX(n_addr1,"  ") <> 0 THEN n_addr1 = trim(REPLACE(n_addr1,"  "," ")).
        
        ASSIGN  nv_name  = trim(SUBSTR(n_addr1,1,INDEX(n_addr1," ")))
                n_length = LENGTH(nv_name) + 1
                n_addr1  = trim(SUBSTR(n_addr1,n_length,LENGTH(n_addr1)))  
                nv_lname = trim(SUBSTR(n_addr1,1,INDEX(n_addr1," ")))
                n_length = LENGTH(nv_lname) + 1 
                n_addr1  = trim(SUBSTR(n_addr1,n_length,LENGTH(n_addr1))) .
    END.

    IF trim(n_addr3) <> ""  THEN DO:
        IF (index(n_addr3,"กทม") <> 0 ) OR (index(n_addr3,"กรุงเทพ") <> 0 ) THEN 
            ASSIGN 
            n_addr2   = "เขต" + trim(n_addr2)
            n_addr3   = trim(n_addr3) 
            n_addr4   = TRIM(n_addr4) .
            
        ELSE ASSIGN 
            n_addr2   = "อ." + trim(n_addr2)
            n_addr3   = "จ." + trim(n_addr3) + " " + trim(n_addr4)  
            n_addr4   = "" .
    END.

    DO WHILE INDEX(n_addr1,"  ") <> 0 :
        ASSIGN n_addr1 = trim(REPLACE(n_addr1,"  "," ")).
    END.
    DO WHILE INDEX(n_addr1,"บ้านเลขที่") <> 0 :
        ASSIGN n_addr1 = trim(REPLACE(n_addr1,"บ้านเลขที่","")).
    END.
    DO WHILE INDEX(n_addr1,"ถนน") <> 0 :
        ASSIGN n_addr1 = trim(REPLACE(n_addr1,"ถนน","ถ.")).
    END.
    DO WHILE INDEX(n_addr1,"ซอย") <> 0 :
        ASSIGN n_addr1 = trim(REPLACE(n_addr1,"ซอย","ซ.")).
    END.
    DO WHILE INDEX(n_addr1,"หมู่ที่") <> 0 :
        ASSIGN n_addr1 = trim(REPLACE(n_addr1,"หมู่ที่","ม.")).
    END.
    DO WHILE INDEX(n_addr1,"ตำบล") <> 0 :
        ASSIGN n_addr1 = trim(REPLACE(n_addr1,"ตำบล","ต.")).
    END.
    DO WHILE INDEX(n_addr1,"หมู่บ้าน/อาคาร") <> 0 :
        ASSIGN n_addr1 = trim(REPLACE(n_addr1,"หมู่บ้าน/อาคาร","")).
    END.
    DO WHILE INDEX(n_addr3,"กรุงเทพมหานคร") <> 0 :
        ASSIGN n_addr3 = trim(REPLACE(n_addr3,"กรุงเทพมหานคร","กรุงเทพฯ")).
    END.


    IF LENGTH(n_addr1) > 35  THEN DO:
      loop_add01:
      DO WHILE LENGTH(n_addr1) > 35 :
          IF r-INDEX(n_addr1," ") <> 0 THEN DO:
              ASSIGN 
                  n_addr2  = trim(SUBSTR(n_addr1,r-INDEX(n_addr1," "))) + " " + TRIM(n_addr2) 
                  n_addr1  = trim(SUBSTR(n_addr1,1,r-INDEX(n_addr1," "))).
          END.
          ELSE LEAVE loop_add01.
      END.
      loop_add02:
      DO WHILE LENGTH(n_addr2) > 35 :
          IF r-INDEX(n_addr2," ") <> 0 THEN DO:
              ASSIGN 
                  n_addr3  = trim(SUBSTR(n_addr2,r-INDEX(n_addr2," "))) + " " + TRIM(n_addr3) 
                  n_addr2  = trim(SUBSTR(n_addr2,1,r-INDEX(n_addr2," "))).
          END.
          ELSE LEAVE loop_add02.
      END.
      loop_add03:
      DO WHILE LENGTH(n_addr3) > 35 :
          IF r-INDEX(n_addr3," ") <> 0 THEN DO:
              ASSIGN 
                  n_addr4  = trim(SUBSTR(n_addr3,r-INDEX(n_addr3," "))) + " " + TRIM(n_addr4)
                  n_addr3  = trim(SUBSTR(n_addr3,1,r-INDEX(n_addr3," "))).
          END.
          ELSE LEAVE loop_add03.
      END.
    END.
  */
    /*--- ทีอยุ่หน้าตาราง----*/
  /*  IF n_addr2_70   <> ""  THEN DO: 
        IF INDEX(n_addr2_70,"อาคาร")     <> 0    THEN ASSIGN n_addr2_70 = trim(n_addr2_70). 
        ELSE IF INDEX(n_addr2_70,"ตึก")  <> 0    THEN ASSIGN n_addr2_70 = trim(n_addr2_70).
        ELSE IF INDEX(n_addr2_70,"บ้าน") <> 0    THEN ASSIGN n_addr2_70 = trim(n_addr2_70).
        ELSE IF index(n_addr2_70,"บจก")  <> 0    THEN ASSIGN n_addr2_70 = trim(n_addr2_70).
        ELSE IF index(n_addr2_70,"หจก")  <> 0    THEN ASSIGN n_addr2_70 = trim(n_addr2_70).
        ELSE IF index(n_addr2_70,"บริษัท")  <> 0 THEN ASSIGN n_addr2_70 = trim(n_addr2_70).
        ELSE IF index(n_addr2_70,"ห้าง")    <> 0 THEN ASSIGN n_addr2_70 = trim(n_addr2_70).
        ELSE IF index(n_addr2_70,"มูลนิธิ") <> 0 THEN ASSIGN n_addr2_70 = trim(n_addr2_70).
        ELSE IF index(n_addr2_70,"ชั้น")    <> 0 THEN ASSIGN n_addr2_70 = trim(n_addr2_70).
        ELSE IF index(n_addr2_70,"ห้อง")    <> 0 THEN ASSIGN n_addr2_70 = trim(n_addr2_70).
        ELSE ASSIGN n_addr2_70 = "หมู่บ้าน" + trim(n_addr2_70).
    END.
    IF n_addr3_70  <> ""  THEN DO: 
        IF INDEX(n_addr3_70,"หมู่")      <> 0      THEN n_addr3_70 = REPLACE(n_addr3_70,"หมู่","ม.").
        ELSE IF INDEX(n_addr3_70,"ม.")   <> 0      THEN n_addr3_70 = trim(n_addr3_70).
        ELSE IF INDEX(n_addr3_70,"บ้าน") <> 0      THEN n_addr3_70 = trim(n_addr3_70). 
        ELSE IF INDEX(n_addr3_70,"หมู่บ้าน") <> 0  THEN n_addr3_70 = trim(n_addr3_70).
        ELSE IF INDEX(n_addr3_70,"ที่")  <> 0      THEN n_addr3_70 = trim(n_addr3_70).
        ELSE DO:
            ASSIGN  n = ""  
                n = SUBSTR(TRIM(n_addr3_70),1,1).
                IF INDEX("0123456789",n) <> 0 THEN n_addr3_70 = "ม." + trim(n_addr3_70).
                ELSE n_addr3_70 = trim(n_addr3_70).
        END.
    END.
    IF n_addr4_70 <> ""  THEN DO:
        IF      INDEX(n_addr4_70,"ซ.")  <> 0 THEN n_addr4_70 = trim(n_addr4_70) .
        ELSE IF INDEX(n_addr4_70,"ซอย") <> 0 THEN n_addr4_70 = REPLACE(n_addr4_70,"ซอย","ซ.").
        ELSE n_addr4_70 = "ซ." + trim(n_addr4_70) .
    END.
    IF n_addr5_70 <> ""  THEN DO: 
        IF INDEX(n_addr5_70,"ถ.")       <> 0 THEN n_addr5_70 = trim(n_addr5_70).
        ELSE IF INDEX(n_addr5_70,"ถนน") <> 0 THEN n_addr5_70 = REPLACE(n_addr5_70,"ถนน","ถ.").
        ELSE n_addr5_70 = "ถ." + trim(n_addr5_70) .
    END.    
    IF n_nprovin70 <> ""  THEN DO:
        IF (index(n_nprovin70,"กทม") <> 0 ) OR (index(n_nprovin70,"กรุงเทพ") <> 0 ) THEN DO:
            ASSIGN 
            n_nsub_dist70  = IF index(n_nsub_dist70,"แขวง") <> 0 THEN trim(n_nsub_dist70) ELSE "แขวง" + trim(n_nsub_dist70)
            n_ndirection70 = IF index(n_ndirection70,"เขต") <> 0 THEN trim(n_ndirection70) ELSE "เขต" + trim(n_ndirection70)
            n_nprovin70    = trim(n_nprovin70)
            n_zipcode70    = trim(n_zipcode70). 
        END.
        ELSE DO:
            ASSIGN 
            n_nsub_dist70  = IF index(n_nsub_dist70,"ต.") <> 0 THEN trim(n_nsub_dist70) 
                             ELSE IF index(n_nsub_dist70,"ตำบล") <> 0 THEN REPLACE(n_nsub_dist70,"ตำบล","ต.")
                             ELSE "ต." + trim(n_nsub_dist70)
            n_ndirection70 = IF index(n_ndirection70,"อ.") <> 0 THEN trim(n_ndirection70) 
                             ELSE IF index(n_ndirection70,"อำเภอ") <> 0  THEN REPLACE(n_nsub_dist70,"อำเภอ","อ.")
                             ELSE "อ." + trim(n_ndirection70)
            n_nprovin70    = IF index(n_nprovin70,"จังหวัด") <> 0 OR INDEX(n_nprovin70,"จ.") <> 0 THEN TRIM(n_nprovin70)
                             ELSE "จ." + TRIM(n_nprovin70)
            n_zipcode70    = trim(n_zipcode70).
        END.
    END.*/
END.
    
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_cleardata C-Win 
PROCEDURE proc_cleardata :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN n_cmr_code   = ""     
       n_not_date   = ""     
       n_cedcode    = ""     
       n_pol_title  = ""     
       n_pol_fname  = ""     
       n_pol_lname  = ""     
       n_icno       = ""     
       n_bdate      = ""     
       n_age        = ""     
       n_covcod     = ""     
       n_ins_amt    = ""     
       n_premtotal  = ""     
       n_addr1      = ""     
       n_addr2      = ""     
       n_addr3      = ""     
       n_addr4      = ""     
       n_tel        = ""     
       n_phone      = ""     
       n_comdat     = ""
       n_remark1    = ""
       n_remark2    = ""    . 

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_create C-Win 
PROCEDURE proc_create :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FIND FIRST wdetail WHERE wdetail.icno       = trim(n_icno)     AND
                         wdetail.cedcode    = trim(n_cedcode)  NO-LOCK NO-ERROR.
IF NOT AVAIL wdetail THEN DO:
    RUN proc_chkaddr.
    CREATE wdetail.
    ASSIGN 
        wdetail.cmr_code       = trim(n_cmr_code) 
        wdetail.not_date       = string(DATE(n_not_date),"99/99/9999")
        wdetail.cedcode        = trim(n_cedcode)
        wdetail.pol_title      = trim(n_pol_title)     
        wdetail.pol_fname      = trim(n_pol_fname)     
        wdetail.pol_lname      = TRIM(n_pol_lname) 
        wdetail.icno           = trim(n_icno)
        wdetail.bdate          = STRING(DATE(n_bdate),"99/99/9999")         
        wdetail.age            = trim(n_age) 
        wdetail.covcod         = TRIM(n_covcod)
        wdetail.ins_amt        = trim(n_ins_amt) 
        wdetail.premtotal      = trim(n_premtotal)
        wdetail.addr1          = trim(n_addr1)      
        wdetail.addr2          = trim(n_addr2)      
        wdetail.addr3          = trim(n_addr3)      
        wdetail.addr4          = trim(n_addr4)    
        wdetail.tel            = trim(n_tel)         
        wdetail.phone          = trim(n_phone)  
        wdetail.comdat         = trim(n_comdat)
        wdetail.remark         = TRIM(n_remark1) + " " + TRIM(n_remark2)
        wdetail.pass           = "Y"
        wdetail.comment        = "" .
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_noti_tlt C-Win 
PROCEDURE proc_noti_tlt :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO:
    FOR EACH wdetail .
        IF index(wdetail.cmr_code,"No") <> 0 THEN DELETE wdetail.
        ELSE IF wdetail.cmr_code = "" THEN DELETE wdetail.
        ELSE DO:
            nv_reccnt = nv_reccnt + 1.
            FIND LAST brstat.tlt WHERE brstat.tlt.rec_addr1     = trim(wdetail.icno)     AND
                                       brstat.tlt.nor_noti_ins  = trim(wdetail.cedcode)  AND
                                       brstat.tlt.genusr        = trim(fi_compa)         AND
                                       brstat.tlt.flag          = "M60"                  NO-ERROR NO-WAIT .
                 IF NOT AVAIL brstat.tlt THEN DO: 
                     IF ra_txttyp = 1 THEN DO:
                        CREATE brstat.tlt.
                        nv_completecnt  =  nv_completecnt + 1.
                        ASSIGN  /*1  */  brstat.tlt.trndat        = fi_loaddat                 /*วันที่นำเข้าข้อมูล */
                                /*2  */  brstat.tlt.enttim        = STRING(TIME,"HH:MM:SS")   
                                /*3  */  brstat.tlt.genusr        = "PMIB" 
                                /*4  */  brstat.tlt.flag          = "M60" 
                                /*5  */  brstat.tlt.usrid         = USERID(LDBNAME(1))       /* user import data*/    
                                /*6  */  brstat.tlt.policy        = ""                        
                                /*7  */  brstat.tlt.releas        = "NO"                      /*การออกงาน */    
                                /*8  */  brstat.tlt.subins        = TRIM(fi_producer)         
                                /*9  */  brstat.tlt.recac         = TRIM(fi_agent)            
                                /*10 */  brstat.tlt.entdat        = ?                         /*วันที่ Load file to GW*/
                                /*11 */  brstat.tlt.usrsent       = ""                         /* user Load */
                                /*12 */  brstat.tlt.expodat       = ?                          /* วันที่ยกเลิก */
                                /*13 */  brstat.tlt.stat          = ""                         /* user ที่ยกเลิก */ 
                                 
                                /*14 */  brstat.tlt.datesent      = date(wdetail.not_date)    
                                /*15 */  brstat.tlt.nor_noti_ins  = trim(wdetail.cedcode)     
                                /*16 */  brstat.tlt.rec_name      = trim(wdetail.pol_title)   /*คำนำหน้าชื่อ  */                   
                                /*17 */  brstat.tlt.ins_name      = trim(wdetail.pol_fname)   /*ชื่อผู้เอาประกัน    */                   
                                /*18 */  brstat.tlt.rec_addr5     = trim(wdetail.pol_lname)   /*นามสกุลผู้เอาประกัน */                   
                                /*19 */  brstat.tlt.rec_addr1     = trim(wdetail.icno)        
                                /*20 */  brstat.tlt.rec_addr2     = trim(wdetail.bdate)       
                                /*21 */  brstat.tlt.rec_addr3     = TRIM(wdetail.age)         
                                /*22 */  brstat.tlt.rec_addr4     = trim(wdetail.covcod)      
                                /*23 */  brstat.tlt.nor_coamt     = DECI(wdetail.ins_amt)     
                                /*24 */  brstat.tlt.comp_coamt    = DECI(wdetail.premtotal)   
                                /*25 */  brstat.tlt.ins_addr1     = trim(wdetail.addr1)       
                                /*26 */  brstat.tlt.ins_addr2     = trim(wdetail.addr2)       
                                /*27 */  brstat.tlt.ins_addr3     = trim(wdetail.addr3)       
                                /*28 */   brstat.tlt.ins_addr4     = trim(wdetail.addr4)       
                                /*29 */  brstat.tlt.old_eng       = trim(wdetail.tel )        
                                /*30 */  brstat.tlt.old_cha       = trim(wdetail.phone)       
                                /*31 */  brstat.tlt.gendat        = date(wdetail.comdat)
                                /*32 */  brstat.tlt.filler2       = TRIM(wdetail.remark)
                                /*33 */  brstat.tlt.filler1       = ""  .
                     END.
                     ELSE DO:
                         ASSIGN  wdetail.pass    = "N"
                                 wdetail.comment = "ไม่พบข้อมูลในถังพัก".
                         MESSAGE "ไม่สามารถยกเลิกข้อมูลได้ เนื่องจากไม่พบข้อมูลในถังพัก" VIEW-AS ALERT-BOX.
                     END.
                 END.
                 ELSE DO:
                     IF ra_txttyp = 1 THEN DO:
                         nv_completecnt  =  nv_completecnt + 1.
                        ASSIGN  /*1  */    brstat.tlt.trndat        = fi_loaddat                 /*วันที่นำเข้าข้อมูล */
                                /*2  */    brstat.tlt.enttim        = STRING(TIME,"HH:MM:SS")   
                                /*3  */    brstat.tlt.genusr        = "PMIB" 
                                /*4  */    brstat.tlt.flag          = "M60" 
                                /*5  */    brstat.tlt.usrid         = USERID(LDBNAME(1))       /* user import data*/    
                                /*6  */    brstat.tlt.policy        = ""                        
                                /*7  */    brstat.tlt.releas        = "NO"                      /*การออกงาน */    
                                /*8  */    brstat.tlt.subins        = TRIM(fi_producer)         
                                /*9  */    brstat.tlt.recac         = TRIM(fi_agent)            
                                /*10 */    brstat.tlt.entdat        = ?                         /*วันที่ Load file to GW */
                                /*11 */    brstat.tlt.usrsent       = ""                        /* user Load */
                                /*12 */    brstat.tlt.expodat       = ?                         /* วันที่ยกเลิก */
                                /*13 */    brstat.tlt.stat          = ""                        /* user ที่ยกเลิก */ 
                                        
                                /*14 */    brstat.tlt.datesent      = date(wdetail.not_date)    
                                /*15 */    brstat.tlt.nor_noti_ins  = trim(wdetail.cedcode)     
                                /*16 */    brstat.tlt.rec_name      = trim(wdetail.pol_title)   /*คำนำหน้าชื่อ  */                   
                                /*17 */    brstat.tlt.ins_name      = trim(wdetail.pol_fname)   /*ชื่อผู้เอาประกัน    */                   
                                /*18 */    brstat.tlt.rec_addr5     = trim(wdetail.pol_lname)   /*นามสกุลผู้เอาประกัน */                   
                                /*19 */    brstat.tlt.rec_addr1     = trim(wdetail.icno)       /*เลขบัตร ปปช. */
                                /*20 */    brstat.tlt.rec_addr2     = trim(wdetail.bdate)      /*วันเกิด */
                                /*21 */    brstat.tlt.rec_addr3     = TRIM(wdetail.age)        /*อายุ */
                                /*22 */    brstat.tlt.rec_addr4     = trim(wdetail.covcod)     /*แผน */
                                /*23 */    brstat.tlt.nor_coamt     = DECI(wdetail.ins_amt)    /*ทุน */
                                /*24 */    brstat.tlt.comp_coamt    = DECI(wdetail.premtotal)  /*เบี้ย*/
                                /*25 */    brstat.tlt.ins_addr1     = trim(wdetail.addr1)      /*ที่อยู๋*/
                                /*26 */    brstat.tlt.ins_addr2     = trim(wdetail.addr2)      /*ที่อยู๋*/
                                /*27 */    brstat.tlt.ins_addr3     = trim(wdetail.addr3)      /*ที่อยู๋*/
                                /*28 */    brstat.tlt.ins_addr4     = trim(wdetail.addr4)      /*ที่อยู๋*/
                                /*29 */    brstat.tlt.old_eng       = trim(wdetail.tel )       /*เบอร์โทร */
                                /*30 */    brstat.tlt.old_cha       = trim(wdetail.phone)      /*มือถือ */
                                /*31 */    brstat.tlt.gendat        = date(wdetail.comdat)     /*วันคุ้มครอง */
                                /*32 */    brstat.tlt.filler2       = TRIM(wdetail.remark)     /*หมายเหตุ */
                                /*33 */    brstat.tlt.filler1       = "".
                     END.
                     ELSE DO:
                         nv_completecnt  =  nv_completecnt + 1.
                         ASSIGN /*brstat.tlt.entdat  = TODAY */
                                /*brstat.tlt.usrsent = USERID(LDBNAME(1))*/ /* user ที่ยกเลิก */
                                brstat.tlt.expodat = TODAY                 /* วันที่ยกเลิก */
                                brstat.tlt.stat    = USERID(LDBNAME(1))    /* user ที่ยกเลิก */
                                brstat.tlt.releas  = "CANCEL/" + brstat.tlt.releas
                                brstat.tlt.filler2 = IF brstat.tlt.filler2 <> "" THEN brstat.tlt.filler2 + " " + TRIM(wdetail.remark)
                                                     ELSE TRIM(wdetail.remark) . 
                     END.
                 END.
        END.
    END.
    RELEASE brstat.tlt.

END.
         

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

