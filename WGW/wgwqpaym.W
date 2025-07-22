&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
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
  wgwqscb3.w  : Query and Update data Payment on table tlt  
  Create  by :  Ranu i. A61-0573 Date : 02/04/2019
  Connect   :  gw_stat ld brstat , gw_safe ld sic_bran ,sic_test ld sicuw sicsyac :not connect stat
+++++++++++++++++++++++++++++++++++++++++++++++*/
/* Modify by : Ranu I. A63-0448 เพิ่มการแยกข้อมูลไฟล์งานเอ็มไพร์และอรกานต์   */
/*---------------------------------------------------------------------------*/
Def  Input  parameter  nv_recidtlt  as  recid  .
Def  var nv_index  as int  init 0.
DEF  VAR nv_chaidrep AS CHARACTER . /*A57-0262*/
Def  Var chNotesSession  As Com-Handle.
Def  Var chNotesDataBase As Com-Handle.
Def  Var chDocument      As Com-Handle.
Def  Var chNotesView     As Com-Handle .
Def  Var chNavView       As Com-Handle .
Def  Var chViewEntry     As Com-Handle .
Def  Var chItem          As Com-Handle .
Def  Var chData          As Com-Handle .
Def  Var nv_server       As Char.
Def  Var nv_tmp          As char .
DEF VAR nv_year          AS CHAR FORMAT "x(5)" .
DEF VAR nv_docno         AS CHAR FORMAT "x(25)".
DEF VAR nv_survey        AS CHAR FORMAT "x(25)".
DEF VAR nv_detail        AS CHAR FORMAT "x(30)".
DEF VAR nv_remark1       AS CHAR FORMAT "x(250)".
DEF VAR nv_remark2       AS CHAR FORMAT "x(250)".
DEF VAR nv_damlist       AS CHAR FORMAT "x(150)" INIT "" .
DEF VAR nv_damage        AS CHAR FORMAT "x(250)" INIT "" .
DEF VAR nv_totaldam      AS CHAR FORMAT "X(150)" .
DEF VAR nv_attfile       AS CHAR FORMAT "x(100)" INIT "" .
DEF VAR nv_device        AS CHAR FORMAT "x(500)" INIT "".
Def var nv_acc1          as char format "x(50)".   
Def var nv_acc2          as char format "x(50)".   
Def var nv_acc3          as char format "x(50)".   
Def var nv_acc4          as char format "x(50)".   
Def var nv_acc5          as char format "x(50)".   
Def var nv_acc6          as char format "x(50)".   
Def var nv_acc7          as char format "x(50)".   
Def var nv_acc8          as char format "x(50)".   
Def var nv_acc9          as char format "x(50)".   
Def var nv_acc10         as char format "x(50)".   
Def var nv_acc11         as char format "x(50)".   
Def var nv_acc12         as char format "x(50)".   
Def var nv_acctotal      as char format "x(100)".   
DEF VAR nv_surdata       AS CHAR FORMAT "x(250)".
DEF VAR nv_date          AS CHAR FORMAT "x(15)".

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS rs_status bu_save bu_exit fi_trntyp ~
fi_producid fi_campid fi_paymode fi_cardname fi_cardbank fi_cardexp ~
fi_insname fi_trandat fi_user fi_time fi_premtotal fi_duedat fi_cardno ~
fi_Payno fi_refno fi_inscode fi_paytype fi_cardtyp fi_Polno fi_paydate ~
fi_payamount fi_appcode fi_matchdat fi_trntyppay fi_remark bu_chk ~
fi_remark2 fi_remark3 fi_userup bu_chk-2 fi_Holdname fi_custno RECT-462 ~
RECT-468 RECT-469 RECT-662 
&Scoped-Define DISPLAYED-OBJECTS rs_status fi_trntyp fi_producid fi_campid ~
fi_paymode fi_cardname fi_cardbank fi_cardexp fi_insname fi_trandat fi_user ~
fi_time fi_premtotal fi_duedat fi_cardno fi_Payno fi_refno fi_inscode ~
fi_paytype fi_cardtyp fi_Polno fi_paydate fi_payamount fi_result fi_appcode ~
fi_matchdat fi_trntyppay fi_remark fi_remark2 fi_remark3 fi_userup ~
fi_Holdname fi_custno 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bu_chk 
     LABEL "CHECK PAYMENT" 
     SIZE 18.5 BY 1
     BGCOLOR 10 FGCOLOR 1 FONT 1.

DEFINE BUTTON bu_chk-2 
     LABEL "Update Result" 
     SIZE 16.5 BY 1.62
     BGCOLOR 10 FGCOLOR 1 FONT 6.

DEFINE BUTTON bu_exit 
     LABEL "Exit" 
     SIZE 8 BY 1.67
     BGCOLOR 6 FONT 6.

DEFINE BUTTON bu_save 
     LABEL "Save" 
     SIZE 7.83 BY 1.62
     BGCOLOR 2 FGCOLOR 15 FONT 6.

DEFINE VARIABLE fi_appcode AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 20.17 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_campid AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_cardbank AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 32.17 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_cardexp AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 12.17 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_cardname AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 25.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_cardno AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 20.33 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_cardtyp AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 13 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_custno AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 19 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_duedat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 13.33 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_Holdname AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 32.17 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_inscode AS CHARACTER FORMAT "X(5)":U 
     VIEW-AS FILL-IN 
     SIZE 4.83 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_insname AS CHARACTER FORMAT "X(70)":U 
     VIEW-AS FILL-IN 
     SIZE 42.17 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_matchdat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 13.33 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_payamount AS DECIMAL FORMAT "->,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 13.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_paydate AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 13.33 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_paymode AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 32.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_Payno AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 20.17 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_paytype AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 30 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_Polno AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 15.17 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_premtotal AS DECIMAL FORMAT "->,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 13.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_producid AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 19 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_refno AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 18.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_remark AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 85.33 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_remark2 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 85.33 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_remark3 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 85.33 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_result AS CHARACTER FORMAT "X(25)":U 
      VIEW-AS TEXT 
     SIZE 14.17 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_time AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 12 BY 1
     BGCOLOR 8 FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE fi_trandat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 13.67 BY 1
     BGCOLOR 8 FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE fi_trntyp AS CHARACTER FORMAT "X(5)":U 
     VIEW-AS FILL-IN 
     SIZE 6.17 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_trntyppay AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 20 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_user AS CHARACTER FORMAT "X(13)":U 
     VIEW-AS FILL-IN 
     SIZE 9 BY 1
     BGCOLOR 7 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_userup AS CHARACTER FORMAT "X(13)":U 
     VIEW-AS FILL-IN 
     SIZE 12.5 BY 1
     BGCOLOR 10 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE rs_status AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "Approve", 1,
"Reject", 2
     SIZE 21.67 BY 1
     BGCOLOR 8 FGCOLOR 2  NO-UNDO.

DEFINE RECTANGLE RECT-462
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132 BY 22.81
     BGCOLOR 10 .

DEFINE RECTANGLE RECT-468
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 129.67 BY 7.38
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-469
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 129 BY 7.95
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-662
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 20.67 BY 1.57
     BGCOLOR 2 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     rs_status AT ROW 14.48 COL 21.5 NO-LABEL WIDGET-ID 66
     bu_save AT ROW 21.95 COL 108.5
     bu_exit AT ROW 21.95 COL 118.5
     fi_trntyp AT ROW 6.24 COL 52.33 COLON-ALIGNED NO-LABEL
     fi_producid AT ROW 9.71 COL 79.67 COLON-ALIGNED NO-LABEL
     fi_campid AT ROW 9.76 COL 47 COLON-ALIGNED NO-LABEL
     fi_paymode AT ROW 6.24 COL 74.5 COLON-ALIGNED NO-LABEL
     fi_cardname AT ROW 8.52 COL 18 COLON-ALIGNED NO-LABEL
     fi_cardbank AT ROW 8.52 COL 55.67 COLON-ALIGNED NO-LABEL
     fi_cardexp AT ROW 7.43 COL 117.67 COLON-ALIGNED NO-LABEL
     fi_insname AT ROW 5.1 COL 41.33 COLON-ALIGNED NO-LABEL
     fi_trandat AT ROW 2.76 COL 83.5 COLON-ALIGNED NO-LABEL
     fi_user AT ROW 2.76 COL 120.5 COLON-ALIGNED NO-LABEL
     fi_time AT ROW 2.76 COL 102.33 COLON-ALIGNED NO-LABEL
     fi_premtotal AT ROW 9.76 COL 18 COLON-ALIGNED NO-LABEL
     fi_duedat AT ROW 8.57 COL 106.17 COLON-ALIGNED NO-LABEL
     fi_cardno AT ROW 7.38 COL 58.33 COLON-ALIGNED NO-LABEL WIDGET-ID 2
     fi_Payno AT ROW 6.24 COL 18.33 COLON-ALIGNED NO-LABEL WIDGET-ID 14
     fi_refno AT ROW 2.76 COL 52.33 COLON-ALIGNED NO-LABEL WIDGET-ID 18
     fi_inscode AT ROW 5.1 COL 18.67 COLON-ALIGNED NO-LABEL WIDGET-ID 20
     fi_paytype AT ROW 7.38 COL 18.17 COLON-ALIGNED NO-LABEL WIDGET-ID 22
     fi_cardtyp AT ROW 7.38 COL 89.67 COLON-ALIGNED NO-LABEL WIDGET-ID 26
     fi_Polno AT ROW 2.76 COL 26.67 COLON-ALIGNED NO-LABEL WIDGET-ID 30
     fi_paydate AT ROW 15.76 COL 19.67 COLON-ALIGNED NO-LABEL WIDGET-ID 42
     fi_payamount AT ROW 15.81 COL 51.5 COLON-ALIGNED NO-LABEL WIDGET-ID 46
     fi_result AT ROW 14.48 COL 42.83 COLON-ALIGNED NO-LABEL WIDGET-ID 50
     fi_appcode AT ROW 14.48 COL 72.33 COLON-ALIGNED NO-LABEL WIDGET-ID 54
     fi_matchdat AT ROW 15.86 COL 79.67 COLON-ALIGNED NO-LABEL WIDGET-ID 58
     fi_trntyppay AT ROW 14.48 COL 109 COLON-ALIGNED NO-LABEL WIDGET-ID 62
     fi_remark AT ROW 17.19 COL 19.17 COLON-ALIGNED NO-LABEL WIDGET-ID 70
     bu_chk AT ROW 19.14 COL 109.67 WIDGET-ID 74
     fi_remark2 AT ROW 18.29 COL 19.17 COLON-ALIGNED NO-LABEL WIDGET-ID 78
     fi_remark3 AT ROW 19.38 COL 19.33 COLON-ALIGNED NO-LABEL WIDGET-ID 80
     fi_userup AT ROW 15.76 COL 110.5 COLON-ALIGNED NO-LABEL WIDGET-ID 82
     bu_chk-2 AT ROW 21.95 COL 90 WIDGET-ID 86
     fi_Holdname AT ROW 5.05 COL 96.83 COLON-ALIGNED NO-LABEL WIDGET-ID 88
     fi_custno AT ROW 9.76 COL 110.17 COLON-ALIGNED NO-LABEL WIDGET-ID 92
     "Card Name :" VIEW-AS TEXT
          SIZE 10.5 BY .91 AT ROW 8.57 COL 9
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "Payment No :" VIEW-AS TEXT
          SIZE 13 BY .91 AT ROW 6.24 COL 7 WIDGET-ID 16
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "User:" VIEW-AS TEXT
          SIZE 5.33 BY .91 AT ROW 2.81 COL 117.17
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "Update by :" VIEW-AS TEXT
          SIZE 9.5 BY .91 AT ROW 15.81 COL 102.5 WIDGET-ID 84
          BGCOLOR 19 FGCOLOR 2 FONT 1
     " Query and Update Data Payment AYCAL" VIEW-AS TEXT
          SIZE 45 BY .91 AT ROW 1.14 COL 2
          FGCOLOR 7 FONT 6
     "Campaign Code :" VIEW-AS TEXT
          SIZE 14.17 BY .91 AT ROW 9.81 COL 34.67
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "Payment Due Date :" VIEW-AS TEXT
          SIZE 16.5 BY .91 AT ROW 8.57 COL 91
          BGCOLOR 19 FGCOLOR 2 FONT 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1.17 ROW 1.05
         SIZE 133.67 BY 25.95
         BGCOLOR 18 FGCOLOR 1 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "  ข้อมูลบัตรเครดิต" VIEW-AS TEXT
          SIZE 17 BY .91 AT ROW 4.05 COL 3
          BGCOLOR 19 FGCOLOR 4 FONT 6
     "Card Bank :" VIEW-AS TEXT
          SIZE 9.5 BY .91 AT ROW 8.57 COL 47.17
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "Payment Amount :" VIEW-AS TEXT
          SIZE 15 BY .91 AT ROW 15.86 COL 37.83 WIDGET-ID 48
          BGCOLOR 19 FGCOLOR 6 FONT 1
     "Holder Name :" VIEW-AS TEXT
          SIZE 11.5 BY .91 AT ROW 5.1 COL 86.83 WIDGET-ID 90
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "Crard Exp Date :" VIEW-AS TEXT
          SIZE 13.5 BY .91 AT ROW 7.48 COL 105.83
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "Cust Code :" VIEW-AS TEXT
          SIZE 9.5 BY .91 AT ROW 9.81 COL 102 WIDGET-ID 94
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "Payment Mode :" VIEW-AS TEXT
          SIZE 13.33 BY .91 AT ROW 6.29 COL 62.83
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "X-Refno :" VIEW-AS TEXT
          SIZE 9.17 BY .91 AT ROW 2.76 COL 45.17
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "Payment Type :" VIEW-AS TEXT
          SIZE 13 BY .91 AT ROW 7.43 COL 7 WIDGET-ID 24
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "Card Type :" VIEW-AS TEXT
          SIZE 9.5 BY .91 AT ROW 7.43 COL 81.67 WIDGET-ID 28
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "  ผลการตัดบัตรเครดิต" VIEW-AS TEXT
          SIZE 20.83 BY .91 AT ROW 13.14 COL 3.17 WIDGET-ID 40
          BGCOLOR 19 FGCOLOR 6 FONT 6
     "Payment Date :" VIEW-AS TEXT
          SIZE 12.5 BY .91 AT ROW 15.81 COL 8.5 WIDGET-ID 44
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "Due Amount :" VIEW-AS TEXT
          SIZE 11.83 BY .91 AT ROW 9.81 COL 7.5
          BGCOLOR 19 FGCOLOR 6 FONT 1
     "Policy :" VIEW-AS TEXT
          SIZE 7.5 BY .91 AT ROW 2.76 COL 20.83 WIDGET-ID 32
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "Result Payment :" VIEW-AS TEXT
          SIZE 14 BY .91 AT ROW 14.52 COL 6.5 WIDGET-ID 52
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "Approve Code :" VIEW-AS TEXT
          SIZE 13 BY .91 AT ROW 14.52 COL 61.17 WIDGET-ID 56
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "Trans Type :" VIEW-AS TEXT
          SIZE 10.67 BY .91 AT ROW 6.29 COL 43.5
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "Match Date :" VIEW-AS TEXT
          SIZE 11.33 BY .91 AT ROW 15.91 COL 70 WIDGET-ID 60
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "Remark :" VIEW-AS TEXT
          SIZE 8 BY .91 AT ROW 17.24 COL 12.5 WIDGET-ID 72
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "Insurance Code :" VIEW-AS TEXT
          SIZE 16.5 BY .91 AT ROW 5.19 COL 3.67
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "Transection Type :" VIEW-AS TEXT
          SIZE 15.17 BY .91 AT ROW 14.52 COL 95.33 WIDGET-ID 64
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "วันที่โหลดไฟล์:" VIEW-AS TEXT
          SIZE 11.5 BY .91 AT ROW 2.81 COL 73.83
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "Insurance Name :" VIEW-AS TEXT
          SIZE 16.5 BY .91 AT ROW 5.14 COL 26.33
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "Card No :" VIEW-AS TEXT
          SIZE 7.67 BY .91 AT ROW 7.43 COL 51.67 WIDGET-ID 4
          BGCOLOR 19 FGCOLOR 2 FONT 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1.17 ROW 1.05
         SIZE 133.67 BY 25.95
         BGCOLOR 18 FGCOLOR 1 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "เวลา:" VIEW-AS TEXT
          SIZE 4.5 BY .91 AT ROW 2.81 COL 99.5
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "Producut Code :" VIEW-AS TEXT
          SIZE 13 BY .91 AT ROW 9.76 COL 68
          BGCOLOR 19 FGCOLOR 2 FONT 1
     RECT-462 AT ROW 2.24 COL 1.67
     RECT-468 AT ROW 4.57 COL 2.83 WIDGET-ID 36
     RECT-469 AT ROW 13.52 COL 3 WIDGET-ID 38
     RECT-662 AT ROW 18.86 COL 108.5 WIDGET-ID 76
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1.17 ROW 1.05
         SIZE 133.67 BY 25.95
         BGCOLOR 18 FGCOLOR 1 .


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
         TITLE              = "Update Data Payment AYCAL"
         HEIGHT             = 26.1
         WIDTH              = 134.17
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
         MESSAGE-AREA       = no
         SENSITIVE          = yes.
ELSE {&WINDOW-NAME} = CURRENT-WINDOW.

&IF '{&WINDOW-SYSTEM}' NE 'TTY' &THEN
IF NOT C-Win:LOAD-ICON("wimage\safety":U) THEN
    MESSAGE "Unable to load icon: wimage\safety"
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
/* SETTINGS FOR FILL-IN fi_result IN FRAME fr_main
   NO-ENABLE                                                            */
ASSIGN 
       fi_time:READ-ONLY IN FRAME fr_main        = TRUE.

ASSIGN 
       fi_trandat:READ-ONLY IN FRAME fr_main        = TRUE.

ASSIGN 
       fi_user:READ-ONLY IN FRAME fr_main        = TRUE.

ASSIGN 
       fi_userup:READ-ONLY IN FRAME fr_main        = TRUE.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Update Data Payment AYCAL */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Update Data Payment AYCAL */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_chk
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_chk C-Win
ON CHOOSE OF bu_chk IN FRAME fr_main /* CHECK PAYMENT */
DO:
    DEF VAR n_list      AS INT init 0.
    DEF VAR n_count     AS INT init 0.
    DEF VAR n_repair    AS CHAR FORMAT "x(10)" init "".
    DEF VAR n_dam       AS CHAR FORMAT "x(10)" init "".
    DEF VAR n_deatil    AS CHAR FORMAT "x(60)" init "".
    DEF VAR nv_damag    AS CHAR FORMAT "x(30)" init "".
    DEF VAR nv_repair   AS CHAR FORMAT "x(30)" init "".
    DEF VAR nv_damdetail AS LONGCHAR  INIT "".
    DEF VAR n_agent      AS CHAR FORMAT "x(10)" INIT "".
    DEF VAR chViewEntry  AS COM-HANDLE.

    ASSIGN  nv_year    = ""     nv_docno  = ""      nv_survey   = ""    nv_detail  = ""     nv_remark1 = ""     nv_remark2  = ""
            nv_damlist = ""     nv_damage = ""      nv_totaldam = ""    nv_attfile = ""     nv_device  = ""     nv_acc1     = ""
            nv_acc2    = ""     nv_acc3   = ""      nv_acc4     = ""    nv_acc5    = ""     nv_acc6    = ""     nv_acc7     = ""
            nv_acc8    = ""     nv_acc9   = ""      nv_acc10    = ""    nv_acc11   = ""     nv_acc12   = ""     nv_acctotal = ""
            nv_surdata = ""     nv_tmp   = ""       nv_date     = ""    n_list     = 0      n_agent    = "" 
            nv_year     = STRING(YEAR(TODAY),"9999")
            nv_tmp      = "Payin.nsf".

    /*--------- Server Real ----------*/
    nv_server = "Safety_NotesServer/Safety".
    nv_tmp   = "safety\m3\" + nv_tmp .
    /*-------------------------------*/
    /*---------- Server test local -------
    nv_server = "".
    nv_tmp    = "U:\Lotus\Notes\Data\ranu\" + nv_tmp .
    -----------------------------*/
    CREATE "Notes.NotesSession"  chNotesSession.
    chNotesDatabase  = chNotesSession:GetDatabase (nv_server,nv_tmp).

      IF  chNotesDatabase:IsOpen()  = NO  THEN  DO:
         MESSAGE "Can not open database" SKIP  
                 "Please Check database and serve" VIEW-AS  ALERT-BOX ERROR.
      END.
      chNotesView    = chNotesDatabase:GetView("BY Policy").
      chNavView      = chNotesView:CreateViewNavFromCategory(fi_polno).
      chViewEntry    = chNavView:GetLastDocument.
      chDocument     = chViewEntry:Document. 

      IF VALID-HANDLE(chDocument) = YES THEN DO:
          chitem       = chDocument:Getfirstitem("insured").     /* ผู้เอาประกัน */
          IF chitem <> 0 THEN nv_acc1  = chitem:TEXT.              
          ELSE nv_acc1 = "".  

          chitem       = chDocument:Getfirstitem("License").     /* ทะเบียน */
          IF chitem <> 0 THEN nv_acc2  = chitem:TEXT.              
          ELSE nv_acc2 = "".  

          chitem       = chDocument:Getfirstitem("Producer_Code").     /* Producer code */
          IF chitem <> 0 THEN n_agent  = chitem:TEXT.              
          ELSE n_agent = "". 

         /* chitem       = chDocument:Getfirstitem("Description").     /* รายละเอียด*/
          IF chitem <> 0 THEN nv_remark1  = chitem:TEXT.              
          ELSE nv_remark1 = "".*/

          chitem       = chDocument:Getfirstitem("FinanceNumber").   /*เลขที่ใบรับเงิน*/
          IF chitem <> 0 THEN nv_docno = chitem:TEXT.                
          ELSE nv_docno = "".   

          chitem       = chDocument:Getfirstitem("status_2").     /* ขั้นตอนการดำเนินการ */
          IF chitem <> 0 THEN nv_detail  = chitem:TEXT.              
          ELSE nv_detail = "". 

          IF nv_detail = "ดำเนินการเรียบร้อยแล้ว" THEN DO:

              chitem       = chDocument:Getfirstitem("KeyOn_2").    /*วันที่ปิดเรื่อง*/
              IF chitem <> 0 THEN nv_date = chitem:TEXT.                 
              ELSE nv_date = "".   
          END.
          ELSE DO:
              chitem       = chDocument:Getfirstitem("status_1").     /* ขั้นตอนการดำเนินการ */
              IF chitem <> 0 THEN nv_detail  = chitem:TEXT.              
              ELSE nv_detail = "". 

              chitem       = chDocument:Getfirstitem("KeyOn_1").    /*วันที่ปิดเรื่อง*/
              IF chitem <> 0 THEN nv_date = chitem:TEXT.                 
              ELSE nv_date = "". 
          END.

           IF nv_detail = "ดำเนินการเรียบร้อยแล้ว" THEN DO:
               ASSIGN  
                       fi_appcode    = nv_docno
                       rs_status     = 1
                       fi_result     = "Approve"
                       fi_payamount  = fi_premtotal
                       fi_trntyppay  = nv_detail 
                       fi_paydate    = DATE(trim(substr(nv_date,6)))
                       fi_remark2    = "ผู้เอาประกัน : " + TRIM(nv_acc1) + " " + "ทะเบียน " + TRIM(nv_acc2) + " Code:" + TRIM(n_agent) .
                       /*fi_remark3    = trim(nv_remark1)*/
           END.
           ELSE IF nv_detail = "กำลังดำเนินการ" THEN DO: 
               ASSIGN  fi_appcode    = nv_docno
                       rs_status     = 2
                       fi_result     = "Reject"
                       fi_trntyppay  = nv_detail
                       fi_paydate    = DATE(trim(substr(nv_date,6)))
                       fi_remark2    = "ผู้เอาประกัน : " + TRIM(nv_acc1) + " " + "ทะเบียน " + TRIM(nv_acc2) + " Code:" + TRIM(n_agent) .
                      /* fi_remark3    = trim(nv_remark1).*/
           END.
           ELSE DO: 
               ASSIGN  fi_appcode     = "" 
                        rs_status      = 2
                        fi_trntyppay   = ""
                        fi_remark2    = "ผู้เอาประกัน : " + TRIM(nv_acc1) + " " + "ทะเบียน " + TRIM(nv_acc2) + " Code:" + TRIM(n_agent) 
                        fi_remark3    = trim(nv_remark1).
           END.

          RELEASE  OBJECT chitem          NO-ERROR.
          RELEASE  OBJECT chDocument      NO-ERROR.          
          RELEASE  OBJECT chNotesDataBase NO-ERROR.     
          RELEASE  OBJECT chNotesSession  NO-ERROR.
      END.
      
      DISP fi_appcode rs_status  fi_trntyppay fi_payamount fi_paydate fi_remark2  fi_remark3 WITH FRAME fr_main.
      MESSAGE " Check Data Payin Complete " VIEW-AS ALERT-BOX.       

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_chk-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_chk-2 C-Win
ON CHOOSE OF bu_chk-2 IN FRAME fr_main /* Update Result */
DO:
    MESSAGE " ข้อมูลเดิมจะถูกเคลียร์เป็นค่าว่าง หากมีการ Update Result Payment " SKIP  
            " ต้องการ Update Result Payment เป็น Reject หรือไม่ "        
        VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO     /*-CANCEL */    
        TITLE "Confirm" UPDATE choice AS LOGICAL.
    CASE choice:         
        WHEN TRUE THEN /* Yes */ 
            DO: 
                ASSIGN rs_status    = 2
                       fi_result    = "Reject" 
                       fi_paydate   = ? 
                       fi_payamount = 0
                       fi_appcode   = ""
                       fi_trntyppay = ""
                       fi_matchdat  = ? 
                       fi_remark    = " " 
                       fi_remark2   = " "  
                       fi_remark3   = "" .
                ENABLE rs_status WITH FRAME fr_main.
                DISP  rs_status      fi_result      fi_paydate      fi_payamount        fi_appcode  
                      fi_trntyppay    fi_matchdat    fi_remark       fi_remark2          fi_remark3 with  frame  fr_main.
            /*Apply "Close" .*/
            Return no-apply.
        END.
        WHEN FALSE THEN 
            DO: /* No */     
               
            APPLY "entry" TO fi_polno.
            RETURN NO-APPLY.
        END.
    END CASE.
    

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_exit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_exit C-Win
ON CHOOSE OF bu_exit IN FRAME fr_main /* Exit */
DO:
     MESSAGE "ต้องการ save ข้อมูลก่อนออกจากหน้าจอหรือไม่ !!!!"        
        VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO     /*-CANCEL */    
        TITLE "" UPDATE choice AS LOGICAL.
     CASE choice:         
        WHEN TRUE THEN /* Yes */ 
            DO: 
               APPLY "CHOOSE" TO bu_save.
        END.
        WHEN FALSE THEN 
            DO: /* No */       
            Apply "Close"  To this-procedure.
            Return no-apply.
        END.
       
        END CASE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_save
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_save C-Win
ON CHOOSE OF bu_save IN FRAME fr_main /* Save */
DO:
    MESSAGE "Do you want SAVE  !!!!"        
        VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO     /*-CANCEL */    
        TITLE "" UPDATE choice AS LOGICAL.
    CASE choice:         
        WHEN TRUE THEN /* Yes */ 
            DO: 
                IF trim(fi_result) = "Approve" THEN DO:
                   IF  fi_paydate = ? THEN DO:
                       MESSAGE "Payment Date Not null ! " VIEW-AS ALERT-BOX.
                       APPLY "entry" TO fi_paydate.
                       RETURN NO-APPLY.
                   END.
                   IF deci(fi_payamount) = 0 THEN DO: 
                       ASSIGN fi_payamount = fi_premtotal .
                       /*MESSAGE "Payment Amount Not null ! " VIEW-AS ALERT-BOX.
                       APPLY "entry" TO fi_payamount.
                       RETURN NO-APPLY.*/
                   END.
                   IF fi_appcode = "" THEN DO: 
                       MESSAGE "Approve Code Not null ! " VIEW-AS ALERT-BOX.
                       APPLY "entry" TO fi_appcode.
                       RETURN NO-APPLY.
                   END.
                   IF fi_paydate <> ? AND DECI(fi_payamount) <> 0 AND fi_appcode <> ""  THEN ASSIGN fi_matchdat = TODAY .
                      
                END.
                Find  brstat.tlt Where  Recid(tlt)  =  nv_recidtlt.
                If  avail  brstat.tlt Then do:
                    ASSIGN 
                         brstat.tlt.nor_usr_ins    = trim(fi_inscode)   
                         brstat.tlt.lotno          = trim(fi_insname)   
                         brstat.tlt.cha_no         = trim(fi_refno)   
                         brstat.tlt.policy         = trim(fi_polno)   
                         brstat.tlt.rec_addr2      = trim(fi_trntyp)   
                         brstat.tlt.nor_noti_ins   = trim(fi_Payno)   
                         brstat.tlt.rec_addr5      = trim(fi_paymode)   
                         brstat.tlt.ins_name       = trim(fi_paytype)   
                         brstat.tlt.rec_name       = trim(fi_cardno)   
                         brstat.tlt.lince1         = trim(fi_cardtyp)   
                         brstat.tlt.rec_addr1      = trim(fi_cardexp)   
                         brstat.tlt.rec_addr3      = trim(fi_cardname) 
                         brstat.tlt.old_cha        = trim(fi_cardbank) 
                         brstat.tlt.gendat         = fi_duedat   
                         brstat.tlt.nor_coamt      = fi_premtotal
                         brstat.tlt.safe3          = trim(fi_campid)   
                         brstat.tlt.safe2          = trim(fi_producid) 

                         brstat.tlt.recac          = trim(fi_holdname) /*A63-0448*/
                         brstat.tlt.subins         = trim(fi_custno)   /*A63-0448*/
                         brstat.tlt.safe1          = trim(fi_result)   
                         brstat.tlt.datesent       = fi_paydate  
                         brstat.tlt.exp            = STRING(fi_payamount,"->>,>>>,>>>.99")
                         brstat.tlt.comp_sub       = trim(fi_appcode)  
                         brstat.tlt.rec_addr4      = trim(fi_trntyppay)
                         brstat.tlt.dat_ins_noti   = IF brstat.tlt.dat_ins_noti = ? THEN fi_matchdat ELSE brstat.tlt.dat_ins_noti
                         brstat.tlt.filler1        = TRIM(fi_remark) + " " + TRIM(fi_remark2) + " " + TRIM(fi_remark3)
                         brstat.tlt.releas         = IF trim(fi_result) = "Approve" THEN "YES" ELSE "NO" 
                         brstat.tlt.imp            = USERID(LDBNAME(1)).
                   
                END.                                                    
            Apply "Close" to this-procedure.
            Return no-apply.
        END.
        WHEN FALSE THEN 
            DO: /* No */       
               
            APPLY "entry" TO fi_polno.
            RETURN NO-APPLY.
        END.
        /*OTHERWISE /* Cancel */             
        STOP.*/
        END CASE.
Disp  fi_polno with  frame  fr_main.
RELEASE brstat.tlt.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_appcode
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_appcode C-Win
ON LEAVE OF fi_appcode IN FRAME fr_main
DO:
    fi_appcode = INPUT fi_appcode.
    DISP fi_appcode WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_campid
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_campid C-Win
ON LEAVE OF fi_campid IN FRAME fr_main
DO:
    fi_campid = INPUT fi_campid .
    DISP fi_campid WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_cardbank
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_cardbank C-Win
ON LEAVE OF fi_cardbank IN FRAME fr_main
DO:
    fi_cardbank = INPUT fi_cardbank .
    DISP fi_cardbank WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_cardexp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_cardexp C-Win
ON LEAVE OF fi_cardexp IN FRAME fr_main
DO:
    fi_cardexp = INPUT fi_cardexp .
    DISP fi_cardexp WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_cardname
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_cardname C-Win
ON LEAVE OF fi_cardname IN FRAME fr_main
DO:
    fi_cardname = INPUT fi_cardname .
    DISP fi_cardname WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_cardno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_cardno C-Win
ON LEAVE OF fi_cardno IN FRAME fr_main
DO:
    fi_cardno = INPUT fi_cardno .
    DISP fi_cardno WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_cardtyp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_cardtyp C-Win
ON LEAVE OF fi_cardtyp IN FRAME fr_main
DO:
    fi_cardtyp = INPUT fi_cardtyp .
    DISP fi_cardtyp WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_custno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_custno C-Win
ON LEAVE OF fi_custno IN FRAME fr_main
DO:
    fi_custno = INPUT fi_custno .
    DISP fi_custno WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_duedat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_duedat C-Win
ON LEAVE OF fi_duedat IN FRAME fr_main
DO:
    fi_duedat = INPUT fi_duedat.
    DISP fi_duedat WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_Holdname
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_Holdname C-Win
ON LEAVE OF fi_Holdname IN FRAME fr_main
DO:
    fi_holdname = INPUT fi_holdname .
    DISP fi_holdname WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_inscode
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_inscode C-Win
ON LEAVE OF fi_inscode IN FRAME fr_main
DO:
    fi_inscode = INPUT fi_inscode .
    DISP fi_inscode WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_insname
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_insname C-Win
ON LEAVE OF fi_insname IN FRAME fr_main
DO:
    fi_insname = INPUT fi_insname .
    DISP fi_insname WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_matchdat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_matchdat C-Win
ON LEAVE OF fi_matchdat IN FRAME fr_main
DO:
    fi_matchdat = INPUT fi_matchdat.
    DISP fi_matchdat WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_payamount
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_payamount C-Win
ON LEAVE OF fi_payamount IN FRAME fr_main
DO:
    fi_payamount = INPUT fi_payamount.
    DISP fi_payamount WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_paydate
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_paydate C-Win
ON LEAVE OF fi_paydate IN FRAME fr_main
DO:
    fi_paydate = INPUT fi_paydate.
    DISP fi_paydate WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_paymode
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_paymode C-Win
ON LEAVE OF fi_paymode IN FRAME fr_main
DO:
    fi_paymode = INPUT fi_paymode .
    DISP fi_paymode WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_Payno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_Payno C-Win
ON LEAVE OF fi_Payno IN FRAME fr_main
DO:
    fi_payno = INPUT fi_payno .
    DISP fi_payno WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_paytype
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_paytype C-Win
ON LEAVE OF fi_paytype IN FRAME fr_main
DO:
    fi_paytype = INPUT fi_paytype .
    DISP fi_paytype WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_Polno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_Polno C-Win
ON LEAVE OF fi_Polno IN FRAME fr_main
DO:
    fi_polno = INPUT fi_polno .
    DISP fi_polno WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_premtotal
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_premtotal C-Win
ON LEAVE OF fi_premtotal IN FRAME fr_main
DO:
    fi_premtotal = INPUT fi_premtotal.
    DISP fi_premtotal WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_producid
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_producid C-Win
ON LEAVE OF fi_producid IN FRAME fr_main
DO:
    fi_producid = INPUT fi_producid .
    DISP fi_producid WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_refno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_refno C-Win
ON LEAVE OF fi_refno IN FRAME fr_main
DO:
    fi_refno = INPUT fi_refno .
    DISP fi_refno WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_remark
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_remark C-Win
ON LEAVE OF fi_remark IN FRAME fr_main
DO:
    fi_remark = INPUT fi_remark.
    DISP fi_remark WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_remark2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_remark2 C-Win
ON LEAVE OF fi_remark2 IN FRAME fr_main
DO:
    fi_remark = INPUT fi_remark.
    DISP fi_remark WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_remark3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_remark3 C-Win
ON LEAVE OF fi_remark3 IN FRAME fr_main
DO:
    fi_remark = INPUT fi_remark.
    DISP fi_remark WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_result
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_result C-Win
ON LEAVE OF fi_result IN FRAME fr_main
DO:
    fi_result = INPUT fi_result.
    DISP fi_result WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_trntyp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_trntyp C-Win
ON LEAVE OF fi_trntyp IN FRAME fr_main
DO:
    fi_trntyp = INPUT fi_trntyp .
    DISP fi_trntyp WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_trntyppay
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_trntyppay C-Win
ON LEAVE OF fi_trntyppay IN FRAME fr_main
DO:
    fi_trntyppay = INPUT fi_trntyppay .
    DISP fi_trntyppay WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME rs_status
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL rs_status C-Win
ON LEAVE OF rs_status IN FRAME fr_main
DO:
    IF rs_status = 1 THEN DO:
        ASSIGN fi_result = "Approve".
    END.
    ELSE IF rs_status = 2 THEN DO:
        ASSIGN fi_result = "Reject".
        HIDE bu_chk-2.
    END.
    DISP rs_status fi_result WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL rs_status C-Win
ON VALUE-CHANGED OF rs_status IN FRAME fr_main
DO:
    rs_status = INPUT rs_status.
    DISP rs_status WITH FRAME fr_main.

    IF rs_status = 1 THEN DO:
        ASSIGN fi_result = "Approve"
               fi_paydate   = ? 
               fi_payamount = 0 
               fi_appcode   = "" 
               fi_trntyppay = "" 
               fi_matchdat  =  ?.
    END.
    ELSE IF rs_status = 2 THEN DO:
        ASSIGN fi_result = "Reject"
               fi_paydate   = ? 
               fi_payamount = 0 
               fi_appcode   = "" 
               fi_trntyppay = "" 
               fi_matchdat  =  ?.
    END.
    DISP rs_status fi_result fi_paydate  fi_payamount fi_appcode  fi_trntyppay fi_matchdat WITH FRAME fr_main.
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


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
  
  gv_prgid = "wgwqpaym".
  gv_prog  = "Query & Update Payment (AYCAL) ".
  RUN  WUT\WUTHEAD ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).

/*********************************************************************/ 
 /*  RUN Wut\WutwiCen ({&WINDOW-NAME}:HANDLE). */ 
  /*CURRENT-WINDOW:WINDOW-STATE = WINDOW-MAXIMIZED.*/
  SESSION:DATA-ENTRY-RETURN = YES.
  
 /* Rect-336:Move-to-top().*/
/*  Rect-337:Move-to-top().
  
  /*Hide    fi_difprm  in frame  {&FRAME-NAME}.*/*/
  
  Find  brstat.tlt  Where   Recid(tlt)  =  nv_recidtlt NO-LOCK NO-ERROR NO-WAIT .
  If  avail  tlt  Then do:
      ASSIGN 
          fi_trandat    = brstat.tlt.trndat 
          fi_time       = brstat.tlt.trntim
          fi_user       = brstat.tlt.usrid 
          fi_inscode    = brstat.tlt.nor_usr_ins 
          fi_insname    = brstat.tlt.lotno       
          fi_refno      = brstat.tlt.cha_no
          fi_polno      = brstat.tlt.policy 
          fi_trntyp     = brstat.tlt.rec_addr2
          fi_Payno      = brstat.tlt.nor_noti_ins
          fi_paymode    = brstat.tlt.rec_addr5
          fi_paytype    = brstat.tlt.ins_name 
          fi_cardno     = brstat.tlt.rec_name 
          fi_cardtyp    = brstat.tlt.lince1     
          fi_cardexp    = brstat.tlt.rec_addr1 
          fi_cardname   = brstat.tlt.rec_addr3 
          fi_cardbank   = brstat.tlt.old_cha   
          fi_duedat     = brstat.tlt.gendat    
          fi_premtotal  = brstat.tlt.nor_coamt 
          fi_campid     = brstat.tlt.safe3     
          fi_producid   = brstat.tlt.safe2
          fi_holdname   = brstat.tlt.recac   /*a63-0448*/
          fi_custno     = brstat.tlt.subins  /*a63-0448*/ 
          fi_result     = brstat.tlt.safe1
          fi_paydate    = brstat.tlt.datesent 
          fi_payamount  = DECI(brstat.tlt.exp)
          fi_appcode    = brstat.tlt.comp_sub
          fi_trntyppay  = brstat.tlt.rec_addr4
          fi_matchdat   = brstat.tlt.dat_ins_noti
          fi_userup     = brstat.tlt.imp
          fi_remark     = IF TRIM(brstat.tlt.filler1) <> "" AND LENGTH(brstat.tlt.filler1) > 100 THEN SUBSTR(brstat.tlt.filler1,1,100) ELSE (brstat.tlt.filler1).
          fi_remark2    = IF TRIM(brstat.tlt.filler1) <> "" AND LENGTH(brstat.tlt.filler1) > 100 THEN SUBSTR(brstat.tlt.filler1,101,100) ELSE "".
          fi_remark3    = IF TRIM(brstat.tlt.filler1) <> "" AND LENGTH(brstat.tlt.filler1) > 200 THEN SUBSTR(brstat.tlt.filler1,201,100) ELSE "".
          IF fi_result <> "" THEN DO:
            IF fi_result = "Approve" THEN do: 
                rs_status = 1.
                DISABLE rs_status WITH FRAME fr_main.
            END.
            IF fi_result = "Reject"  THEN  do: 
                rs_status = 2.
                HIDE bu_chk-2.
            END.
          END.
          ELSE DO: 
              rs_status = 2.
              HIDE bu_chk-2.
          END.
      
      DISP fi_trntyp fi_producid fi_campid fi_paymode fi_cardname fi_cardbank 
          fi_cardexp fi_insname fi_trandat fi_user fi_time fi_premtotal 
          fi_duedat fi_cardno fi_Payno fi_refno fi_inscode fi_paytype fi_cardtyp 
          fi_Polno fi_paydate fi_payamount fi_result fi_appcode fi_matchdat 
          fi_trntyppay fi_remark fi_remark2 fi_remark3 rs_status fi_userup  
          fi_custno  fi_holdname /* a63-0448*/ WITH FRAME fr_main. 
                                                 
  End.
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
  DISPLAY rs_status fi_trntyp fi_producid fi_campid fi_paymode fi_cardname 
          fi_cardbank fi_cardexp fi_insname fi_trandat fi_user fi_time 
          fi_premtotal fi_duedat fi_cardno fi_Payno fi_refno fi_inscode 
          fi_paytype fi_cardtyp fi_Polno fi_paydate fi_payamount fi_result 
          fi_appcode fi_matchdat fi_trntyppay fi_remark fi_remark2 fi_remark3 
          fi_userup fi_Holdname fi_custno 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE rs_status bu_save bu_exit fi_trntyp fi_producid fi_campid fi_paymode 
         fi_cardname fi_cardbank fi_cardexp fi_insname fi_trandat fi_user 
         fi_time fi_premtotal fi_duedat fi_cardno fi_Payno fi_refno fi_inscode 
         fi_paytype fi_cardtyp fi_Polno fi_paydate fi_payamount fi_appcode 
         fi_matchdat fi_trntyppay fi_remark bu_chk fi_remark2 fi_remark3 
         fi_userup bu_chk-2 fi_Holdname fi_custno RECT-462 RECT-468 RECT-469 
         RECT-662 
      WITH FRAME fr_main IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

