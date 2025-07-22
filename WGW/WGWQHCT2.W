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
  WGWQHCT2.w :  Quey & Update data notify Add in table  tlt  
  Create  by    : Kridtiya I. A64-0414 Date 27/11/2021
  Connect :  gw_stat ld brstat , gw_safe ld sic_bran ,sic_test ld sicuw sicsyac :not connect stat 
+++++++++++++++++++++++++++++++++++++++++++++++*/
Def  Input  parameter  nv_recidtlt  as  recid  .
Def  var nv_index  as int  init 0.
DEF  VAR nv_chaidrep AS CHAR .  
DEF  VAR n_char AS CHAR FORMAT "x(250)" INIT "" .
DEF  VAR n_date AS CHAR FORMAT "x(15)" INIT "" .
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

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS bu_save bu_exit bu_detail2 bu_detail1 ~
fi_OwnDamage fi_OwnDaDeduct fi_FITheft fi_411 fi_passager fi_412 ~
fi_driverper fi_passagerper fi_passageracc fi_42 fi_43 fi_statusdata ~
fi_typesenddata fi_contractsale fi_dealer fi_pricegress fi_acc5 fi_TPPDPer ~
fi_deductamt fi_brins fi_brandgress fi_detailadddes fi_TPBIPer fi_TPBIAcc ~
fi_brdealer fi_hondapro fi_carold fi_acc1 fi_priceacc1 fi_acc2 fi_priceacc2 ~
fi_acc3 fi_priceacc3 fi_acc4 fi_priceacc4 fi_amountamt fi_userpay ~
fi_agentlicen fi_receiptype fi_receipname fi_detailcam fi_surcepay ~
fi_paymount fi_creditbank fi_typeofsenddata fi_companynoti fi_branchnoty ~
fi_totleaccamt fi_userup fi_priceacc5 fi_bookno fi_bookdate bu_detail-3 ~
RECT-335 RECT-465 RECT-503 
&Scoped-Define DISPLAYED-OBJECTS fi_OwnDamage fi_OwnDaDeduct fi_FITheft ~
fi_411 fi_passager fi_412 fi_driverper fi_passagerper fi_passageracc fi_42 ~
fi_43 fi_statusdata fi_typesenddata fi_contractsale fi_dealer fi_pricegress ~
fi_acc5 fi_TPPDPer fi_deductamt fi_brins fi_brandgress fi_detailadddes ~
fi_TPBIPer fi_TPBIAcc fi_brdealer fi_hondapro fi_carold fi_acc1 ~
fi_priceacc1 fi_acc2 fi_priceacc2 fi_acc3 fi_priceacc3 fi_acc4 fi_priceacc4 ~
fi_amountamt fi_userpay fi_agentlicen fi_receiptype fi_receipname ~
fi_detailcam fi_surcepay fi_paymount fi_creditbank fi_typeofsenddata ~
fi_companynoti fi_branchnoty fi_totleaccamt fi_userup fi_priceacc5 ~
fi_bookno fi_bookdate 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bu_detail-3 
     LABEL "หน้า3" 
     SIZE 18 BY 1.52
     BGCOLOR 7 FGCOLOR 0 FONT 6.

DEFINE BUTTON bu_detail1 
     LABEL "หน้า1" 
     SIZE 18 BY 1.52
     BGCOLOR 2 FGCOLOR 7 FONT 6.

DEFINE BUTTON bu_detail2 
     LABEL "หน้า2" 
     SIZE 18 BY 1.52
     BGCOLOR 7 FGCOLOR 0 FONT 6.

DEFINE BUTTON bu_exit 
     LABEL "Exit" 
     SIZE 8 BY 1.14
     BGCOLOR 6 FGCOLOR 15 FONT 6.

DEFINE BUTTON bu_save 
     LABEL "Save" 
     SIZE 7.83 BY 1.14
     BGCOLOR 2 FGCOLOR 15 FONT 6.

DEFINE VARIABLE fi_411 AS DECIMAL FORMAT "->>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 18 BY .81
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_412 AS DECIMAL FORMAT "->>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 18 BY .81
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_42 AS DECIMAL FORMAT "->>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 18 BY .81
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_43 AS DECIMAL FORMAT "->>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 18 BY .81
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_acc1 AS CHARACTER FORMAT "X(256)":U INITIAL "0" 
     VIEW-AS FILL-IN 
     SIZE 13 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_acc2 AS CHARACTER FORMAT "X(25)":U INITIAL "0" 
     VIEW-AS FILL-IN 
     SIZE 13 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_acc3 AS CHARACTER FORMAT "X(25)":U INITIAL "0" 
     VIEW-AS FILL-IN 
     SIZE 13 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_acc4 AS CHARACTER FORMAT "X(25)":U INITIAL "0" 
     VIEW-AS FILL-IN 
     SIZE 13 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_acc5 AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 13 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_agentlicen AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 25 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_amountamt AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_bookdate AS CHARACTER FORMAT "X(25)":U INITIAL "0" 
     VIEW-AS FILL-IN 
     SIZE 13.5 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_bookno AS CHARACTER FORMAT "X(25)":U INITIAL "0" 
     VIEW-AS FILL-IN 
     SIZE 13 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_branchnoty AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 25 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_brandgress AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 20 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_brdealer AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 11.5 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_brins AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 7 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_carold AS CHARACTER FORMAT "X(25)":U INITIAL "0" 
     VIEW-AS FILL-IN 
     SIZE 4 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_companynoti AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 10 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_contractsale AS CHARACTER FORMAT "X(100)":U INITIAL "0" 
     VIEW-AS FILL-IN 
     SIZE 30 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_creditbank AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 12 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_dealer AS CHARACTER FORMAT "X(25)":U INITIAL "0" 
     VIEW-AS FILL-IN 
     SIZE 9.83 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_deductamt AS DECIMAL FORMAT "->>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_detailadddes AS CHARACTER FORMAT "X(255)":U 
     VIEW-AS FILL-IN 
     SIZE 70 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_detailcam AS CHARACTER FORMAT "X(256)":U INITIAL "0" 
     VIEW-AS FILL-IN 
     SIZE 30 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_driverper AS DECIMAL FORMAT "->>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 18 BY .81
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_FITheft AS DECIMAL FORMAT "->>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_hondapro AS CHARACTER FORMAT "X(25)":U INITIAL "0" 
     VIEW-AS FILL-IN 
     SIZE 9 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_OwnDaDeduct AS DECIMAL FORMAT "->>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_OwnDamage AS DECIMAL FORMAT "->>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_passager AS DECIMAL FORMAT "->>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 18 BY .81
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_passageracc AS DECIMAL FORMAT "->>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 18 BY .81
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_passagerper AS DECIMAL FORMAT "->>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 18 BY .81
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_paymount AS CHARACTER FORMAT "X(256)":U INITIAL "0" 
     VIEW-AS FILL-IN 
     SIZE 5 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_priceacc1 AS CHARACTER FORMAT "X(25)":U INITIAL "0" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_priceacc2 AS CHARACTER FORMAT "X(25)":U INITIAL "0" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_priceacc3 AS CHARACTER FORMAT "X(25)":U INITIAL "0" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_priceacc4 AS CHARACTER FORMAT "X(25)":U INITIAL "0" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_priceacc5 AS CHARACTER FORMAT "X(25)":U INITIAL "0" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_pricegress AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 13 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_receipname AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 90 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_receiptype AS CHARACTER FORMAT "X(25)":U INITIAL "0" 
     VIEW-AS FILL-IN 
     SIZE 5.5 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_statusdata AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 8 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_surcepay AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 4 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_totleaccamt AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 12.83 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_TPBIAcc AS DECIMAL FORMAT "->>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_TPBIPer AS DECIMAL FORMAT "->>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_TPPDPer AS DECIMAL FORMAT "->>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_typeofsenddata AS CHARACTER FORMAT "X(256)":U INITIAL "0" 
     VIEW-AS FILL-IN 
     SIZE 3 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_typesenddata AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 12 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_userpay AS CHARACTER FORMAT "X(256)":U INITIAL "0" 
     VIEW-AS FILL-IN 
     SIZE 12 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_userup AS CHARACTER FORMAT "X(13)":U 
     VIEW-AS FILL-IN 
     SIZE 10.17 BY 1
     BGCOLOR 19 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-335
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 131.5 BY 21.67
     BGCOLOR 19 FGCOLOR 0 .

DEFINE RECTANGLE RECT-465
     EDGE-PIXELS 2 GRAPHIC-EDGE    ROUNDED 
     SIZE 127.5 BY 8.1
     BGCOLOR 19 FGCOLOR 2 .

DEFINE RECTANGLE RECT-503
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 22.5 BY 1.67
     BGCOLOR 10 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     bu_save AT ROW 1.24 COL 110
     bu_exit AT ROW 1.24 COL 119
     bu_detail2 AT ROW 1.1 COL 19.83
     bu_detail1 AT ROW 1.1 COL 1.67
     fi_OwnDamage AT ROW 7.91 COL 29.5 COLON-ALIGNED NO-LABEL
     fi_OwnDaDeduct AT ROW 8.86 COL 29.5 COLON-ALIGNED NO-LABEL
     fi_FITheft AT ROW 9.81 COL 29.5 COLON-ALIGNED NO-LABEL
     fi_411 AT ROW 3.86 COL 89.5 COLON-ALIGNED NO-LABEL
     fi_passager AT ROW 4.71 COL 89.5 COLON-ALIGNED NO-LABEL
     fi_412 AT ROW 5.57 COL 89.5 COLON-ALIGNED NO-LABEL
     fi_driverper AT ROW 6.48 COL 89.5 COLON-ALIGNED NO-LABEL
     fi_passagerper AT ROW 7.33 COL 89.5 COLON-ALIGNED NO-LABEL
     fi_passageracc AT ROW 8.24 COL 89.5 COLON-ALIGNED NO-LABEL
     fi_42 AT ROW 9.1 COL 89.67 COLON-ALIGNED NO-LABEL
     fi_43 AT ROW 10 COL 89.83 COLON-ALIGNED NO-LABEL
     fi_statusdata AT ROW 11.33 COL 12.5 COLON-ALIGNED NO-LABEL
     fi_typesenddata AT ROW 11.33 COL 38.5 COLON-ALIGNED NO-LABEL
     fi_contractsale AT ROW 12.38 COL 11.5 COLON-ALIGNED NO-LABEL
     fi_dealer AT ROW 12.38 COL 56.5 COLON-ALIGNED NO-LABEL
     fi_pricegress AT ROW 20.91 COL 66 COLON-ALIGNED NO-LABEL
     fi_acc5 AT ROW 15.57 COL 18 COLON-ALIGNED NO-LABEL
     fi_TPPDPer AT ROW 5.86 COL 29.5 COLON-ALIGNED NO-LABEL
     fi_deductamt AT ROW 6.91 COL 29.5 COLON-ALIGNED NO-LABEL
     fi_brins AT ROW 20.91 COL 10.5 COLON-ALIGNED NO-LABEL
     fi_brandgress AT ROW 20.91 COL 30.5 COLON-ALIGNED NO-LABEL
     fi_detailadddes AT ROW 19.86 COL 54.5 COLON-ALIGNED NO-LABEL
     fi_TPBIPer AT ROW 3.86 COL 29.5 COLON-ALIGNED NO-LABEL
     fi_TPBIAcc AT ROW 4.81 COL 29.5 COLON-ALIGNED NO-LABEL
     fi_brdealer AT ROW 12.38 COL 83.5 COLON-ALIGNED NO-LABEL
     fi_hondapro AT ROW 12.38 COL 109 COLON-ALIGNED NO-LABEL
     fi_carold AT ROW 12.38 COL 125 COLON-ALIGNED NO-LABEL
     fi_acc1 AT ROW 13.48 COL 18 COLON-ALIGNED NO-LABEL
     fi_priceacc1 AT ROW 13.48 COL 36.17 COLON-ALIGNED NO-LABEL
     fi_acc2 AT ROW 13.48 COL 68.67 COLON-ALIGNED NO-LABEL
     fi_priceacc2 AT ROW 13.48 COL 87.17 COLON-ALIGNED NO-LABEL
     fi_acc3 AT ROW 14.52 COL 18 COLON-ALIGNED NO-LABEL
     fi_priceacc3 AT ROW 14.52 COL 36.33 COLON-ALIGNED NO-LABEL
     fi_acc4 AT ROW 14.52 COL 68.83 COLON-ALIGNED NO-LABEL
     fi_priceacc4 AT ROW 14.52 COL 87.33 COLON-ALIGNED NO-LABEL
     fi_amountamt AT ROW 16.62 COL 50 COLON-ALIGNED NO-LABEL
     fi_userpay AT ROW 16.62 COL 72.33 COLON-ALIGNED NO-LABEL
     fi_agentlicen AT ROW 16.57 COL 97.83 COLON-ALIGNED NO-LABEL
     fi_receiptype AT ROW 17.67 COL 17.5 COLON-ALIGNED NO-LABEL
     fi_receipname AT ROW 17.67 COL 33 COLON-ALIGNED NO-LABEL
     fi_detailcam AT ROW 18.76 COL 19.5 COLON-ALIGNED NO-LABEL
     fi_surcepay AT ROW 18.76 COL 62 COLON-ALIGNED NO-LABEL
     fi_paymount AT ROW 18.76 COL 75.5 COLON-ALIGNED NO-LABEL
     fi_creditbank AT ROW 18.76 COL 96.5 COLON-ALIGNED NO-LABEL
     fi_typeofsenddata AT ROW 18.76 COL 126 COLON-ALIGNED NO-LABEL
     fi_companynoti AT ROW 11.33 COL 72 COLON-ALIGNED NO-LABEL
     fi_branchnoty AT ROW 11.33 COL 104 COLON-ALIGNED NO-LABEL
     fi_totleaccamt AT ROW 19.86 COL 20 COLON-ALIGNED NO-LABEL
     fi_userup AT ROW 1.24 COL 74.5 COLON-ALIGNED NO-LABEL WIDGET-ID 10
     fi_priceacc5 AT ROW 15.57 COL 36.33 COLON-ALIGNED NO-LABEL WIDGET-ID 20
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 23.57
         BGCOLOR 31 FGCOLOR 2 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     fi_bookno AT ROW 16.62 COL 7 COLON-ALIGNED NO-LABEL WIDGET-ID 24
     fi_bookdate AT ROW 16.62 COL 26.17 COLON-ALIGNED NO-LABEL WIDGET-ID 28
     bu_detail-3 AT ROW 1.1 COL 38.17 WIDGET-ID 88
     "บริการเสริมพิเศษ 5" VIEW-AS TEXT
          SIZE 16 BY .91 AT ROW 15.57 COL 3.5
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "  ข้อมูลความคุ้มครอง" VIEW-AS TEXT
          SIZE 24.17 BY .91 AT ROW 2.81 COL 3.67
          BGCOLOR 19 FGCOLOR 6 FONT 6
     "ความเสียหายต่อทรัพย์สิน" VIEW-AS TEXT
          SIZE 27 BY .91 AT ROW 5.91 COL 3.5
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "จำนวนเงิน" VIEW-AS TEXT
          SIZE 9 BY .91 AT ROW 16.62 COL 42.5
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "รวมราคาอุปกรณ์เสริม" VIEW-AS TEXT
          SIZE 18 BY .91 AT ROW 19.86 COL 3.5
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "อุบัติเหตุส่วนบุคคลเสียชีวิตผู้โดยสาร/ครั้ง" VIEW-AS TEXT
          SIZE 32 BY .81 AT ROW 5.67 COL 50.5
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "รับประกันจ่ายแน่ๆ" VIEW-AS TEXT
          SIZE 10.67 BY .91 AT ROW 18.76 COL 52.5
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "รถยนต์สูญหาย/ไฟไหม้" VIEW-AS TEXT
          SIZE 22 BY .91 AT ROW 9.91 COL 3.5
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "ประเภทผู้แจ้งประกัน" VIEW-AS TEXT
          SIZE 16 BY .91 AT ROW 11.33 COL 23
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "เลมที่" VIEW-AS TEXT
          SIZE 5 BY .91 AT ROW 16.62 COL 3.5 WIDGET-ID 26
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "สาขาบริษัทของผู้เอาประกัน" VIEW-AS TEXT
          SIZE 8.33 BY .91 AT ROW 20.91 COL 3.5
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "สาขาบริษัทผู้แจ้งประกัน" VIEW-AS TEXT
          SIZE 18.5 BY .91 AT ROW 11.33 COL 86.83
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "ความเสียหายส่วนแรกบุคคล" VIEW-AS TEXT
          SIZE 27 BY .91 AT ROW 6.91 COL 3.5
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "ความเสียหายต่อชีวิต (บาท/คน)" VIEW-AS TEXT
          SIZE 27 BY .91 AT ROW 3.91 COL 3.5
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "บริการเสริมพิเศษ 1" VIEW-AS TEXT
          SIZE 16 BY .91 AT ROW 13.48 COL 3.5
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "ความเสียหายต่อรถยนต์" VIEW-AS TEXT
          SIZE 25 BY .91 AT ROW 7.91 COL 3.5
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "Honda Project" VIEW-AS TEXT
          SIZE 12 BY .91 AT ROW 12.38 COL 98
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "บริษัทที่ปล่อยรถ" VIEW-AS TEXT
          SIZE 12.83 BY .91 AT ROW 12.38 COL 44.5
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "อุบัติเหตุส่วนบุคคลทุพพลภาพชั่วคราว จน.ผู้โดยสาร" VIEW-AS TEXT
          SIZE 40 BY .81 AT ROW 7.48 COL 50.5
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "ราคา" VIEW-AS TEXT
          SIZE 4.5 BY .91 AT ROW 13.48 COL 33.33
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "บริการเสริมพิเศษ 4" VIEW-AS TEXT
          SIZE 16 BY .91 AT ROW 14.52 COL 54.33
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "อุบัติเหตุส่วนบุคคลทุพพลภาพชั่วคราวผู้โดยสาร/ครั้ง" VIEW-AS TEXT
          SIZE 40 BY .81 AT ROW 8.38 COL 50.5
          BGCOLOR 19 FGCOLOR 2 FONT 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 23.57
         BGCOLOR 31 FGCOLOR 2 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "สาขาบริษัทที่ปล่อยรถ" VIEW-AS TEXT
          SIZE 16 BY .91 AT ROW 12.38 COL 69
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "อุบัติเหตุส่วนบุคคลเสียชีวิตผู้ขับขี่" VIEW-AS TEXT
          SIZE 30 BY .81 AT ROW 3.86 COL 50.5
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "ราคา" VIEW-AS TEXT
          SIZE 4.5 BY .91 AT ROW 14.52 COL 33.33
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "ชื่อผู้ติดต่อ" VIEW-AS TEXT
          SIZE 8.83 BY .91 AT ROW 12.38 COL 3.5
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "อายุรถ" VIEW-AS TEXT
          SIZE 6 BY .91 AT ROW 12.38 COL 120.5
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "การประกันตัวผู้ขับขี่" VIEW-AS TEXT
          SIZE 30 BY .81 AT ROW 10.19 COL 50.67
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "ความเสียหายส่วนแรกรถยนต์" VIEW-AS TEXT
          SIZE 24 BY .91 AT ROW 8.91 COL 3.5
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "ราคา" VIEW-AS TEXT
          SIZE 4.5 BY .91 AT ROW 14.52 COL 84.33
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "ราคา" VIEW-AS TEXT
          SIZE 4.5 BY .91 AT ROW 13.48 COL 84.17
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "ประเภทการแจ้งงาน" VIEW-AS TEXT
          SIZE 16 BY .91 AT ROW 18.76 COL 111.17
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "วันที่" VIEW-AS TEXT
          SIZE 4.5 BY .91 AT ROW 16.62 COL 22.83 WIDGET-ID 30
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "ค่ารักษาพยาบาล" VIEW-AS TEXT
          SIZE 30 BY .81 AT ROW 9.29 COL 50.5
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "บริการเสริมพิเศษ 2" VIEW-AS TEXT
          SIZE 16 BY .91 AT ROW 13.48 COL 54.17
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "บริการเสริมพิเศษ 3" VIEW-AS TEXT
          SIZE 16 BY .91 AT ROW 14.52 COL 3.5
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "สถานะข้อมูล" VIEW-AS TEXT
          SIZE 10 BY .91 AT ROW 11.33 COL 3.5
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "รายละเอียดอุปกรณ์เสริม" VIEW-AS TEXT
          SIZE 20 BY .91 AT ROW 19.86 COL 36
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "ความเสียหายต่อชีวิต (บาท/ครั้ง)" VIEW-AS TEXT
          SIZE 27.5 BY .91 AT ROW 4.91 COL 3.5
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "อุบัติเหตุส่วนบุคคลทุพพลภาพชั่วคราว ผู้ขับขี่" VIEW-AS TEXT
          SIZE 35 BY .81 AT ROW 6.57 COL 50.5
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "เลขที่บัตร" VIEW-AS TEXT
          SIZE 10.67 BY .91 AT ROW 16.62 COL 88
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "ชำระโดย" VIEW-AS TEXT
          SIZE 7 BY .91 AT ROW 16.62 COL 66.67
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "ผ่อนชำระ" VIEW-AS TEXT
          SIZE 8 BY .91 AT ROW 18.76 COL 68.5
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "ยี่ห้อเคลือบแก้ว" VIEW-AS TEXT
          SIZE 12 BY .91 AT ROW 20.91 COL 20
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "ออกใบเสร็จในนาม" VIEW-AS TEXT
          SIZE 15.5 BY .91 AT ROW 17.71 COL 3.5
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "ชื่อใบเสร็จ" VIEW-AS TEXT
          SIZE 9 BY .91 AT ROW 17.71 COL 25.5
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "อุบัติเหตุส่วนบุคคลเสียชีวิตจน.ผู้โดยสาร" VIEW-AS TEXT
          SIZE 32 BY .81 AT ROW 4.76 COL 50.5
          BGCOLOR 19 FGCOLOR 2 FONT 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 23.57
         BGCOLOR 31 FGCOLOR 2 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "Update By :" VIEW-AS TEXT
          SIZE 11.5 BY .91 AT ROW 1.24 COL 64.5 WIDGET-ID 12
          FGCOLOR 15 FONT 6
     "รายละเอียดเคมเปญ" VIEW-AS TEXT
          SIZE 17 BY .91 AT ROW 18.76 COL 3.5
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "บัตรเครดิตธนาคาร" VIEW-AS TEXT
          SIZE 15 BY .91 AT ROW 18.76 COL 83
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "ราคาเคลือบแก้ว" VIEW-AS TEXT
          SIZE 13 BY .91 AT ROW 20.91 COL 54.5
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "รหัสบริษัทผู้แจ้งประกัน" VIEW-AS TEXT
          SIZE 18 BY .91 AT ROW 11.33 COL 54.5
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "ราคา" VIEW-AS TEXT
          SIZE 4.5 BY .91 AT ROW 15.57 COL 33.33 WIDGET-ID 22
          BGCOLOR 19 FGCOLOR 2 FONT 1
     RECT-335 AT ROW 2.67 COL 1.5
     RECT-465 AT ROW 3.14 COL 2.5
     RECT-503 AT ROW 1 COL 107.5 WIDGET-ID 18
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 23.57
         BGCOLOR 31 FGCOLOR 2 .


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
         TITLE              = "Update Data Notify AYCAL"
         HEIGHT             = 23.62
         WIDTH              = 132.83
         MAX-HEIGHT         = 37.76
         MAX-WIDTH          = 178
         VIRTUAL-HEIGHT     = 37.76
         VIRTUAL-WIDTH      = 178
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
ASSIGN 
       fi_userup:READ-ONLY IN FRAME fr_main        = TRUE.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Update Data Notify AYCAL */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Update Data Notify AYCAL */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_detail-3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_detail-3 C-Win
ON CHOOSE OF bu_detail-3 IN FRAME fr_main /* หน้า3 */
DO:
  nv_recidtlt  =  Recid(tlt).
    
    {&WINDOW-NAME}:hidden  =  Yes. 
    
    Run  wgw\WGWQHCT3(Input  nv_recidtlt).
    Apply "Close"  To this-procedure.
    Return no-apply.
    {&WINDOW-NAME}:hidden  =  No. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_detail1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_detail1 C-Win
ON CHOOSE OF bu_detail1 IN FRAME fr_main /* หน้า1 */
DO:
     nv_recidtlt  =  Recid(tlt).
    
    {&WINDOW-NAME}:hidden  =  Yes. 
    
    Run  wgw\WGWQHCT1(Input  nv_recidtlt).
    Apply "Close"  To this-procedure.
    Return no-apply.
    {&WINDOW-NAME}:hidden  =  No. 
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_exit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_exit C-Win
ON CHOOSE OF bu_exit IN FRAME fr_main /* Exit */
DO:
  Apply "Close"  To this-procedure.
  Return no-apply.
 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_save
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_save C-Win
ON CHOOSE OF bu_save IN FRAME fr_main /* Save */
DO:
    /*
    MESSAGE "Do you want SAVE  !!!!"        
        VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO     /*-CANCEL */    
        TITLE "" UPDATE choice AS LOGICAL.
    CASE choice:         
        WHEN TRUE THEN /* Yes */ 
            DO: 
            Find  brstat.tlt Where  Recid(tlt)  =  nv_recidtlt.
            If  avail  brstat.tlt Then do:
                Assign
                    brstat.tlt.policy        = trim(fi_polno)   
                    brstat.tlt.recac         = trim(fi_agent)   
                    brstat.tlt.subins        = trim(fi_producer)
                    brstat.tlt.nor_noti_ins  = trim(fi_refno)   
                    brstat.tlt.nor_usr_ins   = trim(fi_custcode)
                    brstat.tlt.brand         = TRIM(fi_brand)          /*ชื่อรถยนต์         */                                 
                    brstat.tlt.model         = trim(fi_model)          /*ชื่อรุ่นรถยนต์     */                                 
                    brstat.tlt.expousr       = trim(fi_body )          /*แบบตัวถัง          */                                 
                    brstat.tlt.lince1        = trim(fi_lincen)         /*ทะเบียนรถ          */                                 
                    brstat.tlt.lince2        = trim(fi_province)       /*จังหวัดที่จดทะเบียน*/                                 
                    brstat.tlt.cha_no        = trim(fi_chssic)         /*เลขตัวถัง          */                                   
                    brstat.tlt.eng_no        = trim(fi_engno)          /*เลขเครื่องยนต์     */                                    
                    brstat.tlt.gentim        = trim(fi_year)           /*ปีจดทะเบียนรถ      */                                     
                    /*brstat.tlt.sentcnt       = INT(fi_seat)  */          /*จำนวนที่นั่ง       */                                       
                    brstat.tlt.rencnt        = INT(fi_cc)              /*ขนาดเครื่องยนต์    */                                         
                    /*brstat.tlt.cc_weight     = INT(fi_ton)  */           /*น้ำหนัก            */                                        
                    brstat.tlt.expotim       = trim(fi_class)          /*รหัสการใช้รถยนต์   */
                    brstat.tlt.old_cha       = "GarCd:" + trim(fi_garcod)           /*รหัสการซ่อม        */                            
                                              /* "GarTy:" + trim(fi_garage)  */                 /*ประเภทการซ่อม      */                            
                    /*brstat.tlt.colorcod      = trim(fi_color)  */                             /*สีรถยนต์  */                                    
                    brstat.tlt.rec_addr3     = "CovCod:" + trim(fi_covtyp) + " " +          /*ประเภทของประกันภัย        */                    
                                               "CovTcd:" + trim(fi_covcod)           /*รหัสประเภทของประกันภัย    */                    
                                              /* "CovTyp:" + trim(fi_cover)  + " " +        /*ประเภทของความคุ้มครอง     */                    
                                               "CovTy1:" + trim(fi_subcover) + " " +      /*ประเภทย่อยของความคุ้มครอง */                    
                                               "CovTy2:" + trim(fi_covdetail) */             /*รายละเอียดความคุ้มครอง    */                    
                    brstat.tlt.gendat        = date(fi_comdat)                              /*วันเริ่มความคุ้มครอง      */                    
                    brstat.tlt.expodat       = DATE(fi_expdat)                              /*วันที่สิ้นสุดความคุ้มครอง */                    
                    brstat.tlt.nor_coamt     = DECI(fi_si)                                  /*ทุนประกัน                 */                    
                    brstat.tlt.nor_grprm     = DECI(fi_prem)                                /*เบี้ยสุทธิก่อนหักส่วนลด   */                    
                    brstat.tlt.comp_grprm    = DECI(fi_prem1)                               /*เบี้ยสุทธิหลังหักส่วนลด   */                    
                    brstat.tlt.stat          = "Stm:" + STRING(deci(fi_stamp)) + " " +      /*จำนวนอากรสแตมป์       */                        
                                               "Vat:" + STRING(DECI(fi_vat))                /*จำนวนภาษี SBT/Vat     */                        
                    brstat.tlt.comp_coamt    = deci(fi_premtotal)                           /*เบี้ยรวม ภาษี-อากร    */                        
                    brstat.tlt.endno         = string(DECI(fi_dod))                         /*ค่าความเสียหายส่วนแรก */                        
                    brstat.tlt.comp_sck      = /*"fetP:" + STRING(DECI(fi_feeltp)) + " " + */   /*% ส่วนลดกลุ่ม         */    
                                               "felA:" + STRING(DECI(fi_feelt))             /*จำนวนส่วนลดกลุ่ม      */    
                    brstat.tlt.comp_noti_tlt = /*"NcbP:" + string(DECI(fi_ncbp)) + " " +  */    /*% ส่วนลดประวัติดี     */    
                                               "NcbA:" + string(DECI(fi_ncb))               /*จำนวนส่วนลดประวัติดี  */    
                    brstat.tlt.comp_usr_tlt  = /*"DriP:" + string(DECI(fi_drip)) + " " + */     /*% ส่วนลดกรณีผู้ขับขี่ */    
                                               "DriA:" + string(DECI(fi_dridis))            /*จำนวนส่วนลดกรณีผู้ขับขี่  */    
                    brstat.tlt.comp_noti_ins = /*"OthP:" + string(DECI(fi_oth)) + " " + */      /*%สวนลดอื่นๆ           */    
                                               "OthA:" + string(DECI(fi_othdis))            /*จำนวนส่วนลดอื่นๆ      */    
                    brstat.tlt.comp_usr_ins  = /*"CTVP:" + string(DECI(fi_cctvp)) + " " +  */   /*%สวนลดกล้อง           */    
                                               "CTVA:" + string(DECI(fi_cctv))              /*จำนวนส่วนลดกล้อง      */    
                    brstat.tlt.comp_pol      = /*"SurP:" + string(DECI(fi_discp)) + " " + */    /*%ส่วนลดเพิ่ม        */   
                                               "SurA:" + string(DECI(fi_disc))    + " " +   /*จำนวนส่วนลดเพิ่ม    */    
                                               "SurD:" + trim(fi_discdetail)                /*รายละเอียดส่วนเพิ่ม */    
                    brstat.tlt.filler1       = /*"Acc1:" + trim(fi_accr1)       + " " +  */     /*รหัส อุปกรณ์1  */   
                                               "Acd1:" + trim(fi_accdet1) + " " +           /*รายละเอียด1    */    
                                               "Acp1:" + STRING(DECI(fi_accpric1))  + " " + /*ราคาอุปกรณ์1   */    
                                               /*"Acc2:" + trim(fi_accr2)       + " " +*/       /*รหัส อุปกรณ์2  */    
                                               "Acd2:" + trim(fi_accdet2) + " " +           /*รายละเอียด2    */    
                                               "Acp2:" + STRING(DECI(fi_accpric2))  + " " + /*ราคาอุปกรณ์2   */    
                                               /*"Acc3:" + trim(fi_accr3)       + " " + */      /*รหัส อุปกรณ์3  */    
                                               "Acd3:" + trim(fi_accdet3) + " " +           /*รายละเอียด3    */    
                                               "Acp3:" + STRING(DECI(fi_accpric3))  + " " + /*ราคาอุปกรณ์3   */    
                                               /*"Acc4:" + trim(fi_accr4)       + " " +  */     /*รหัส อุปกรณ์4  */    
                                               "Acd4:" + trim(fi_accdet4) + " " +           /*รายละเอียด 4   */    
                                               "Acp4:" + STRING(DECI(fi_accpric4))  + " " + /*ราคาอุปกรณ์4   */    
                                              /* "Acc5:" + trim(fi_accr5)       + " " + */      /*รหัส อุปกรณ์5  */    
                                               "Acd5:" + TRIM(fi_accdet5) + " " +           /*รายละเอียด 5   */    
                                               "Acp5:" + STRING(DECI(fi_accpric5))          /*ราคาอุปกรณ์5     */    
                    brstat.tlt.nor_effdat    = date(fi_inspdate)                            /*วันที่ตรวจสภาพรถ */    
                    /*brstat.tlt.comp_effdat   = date(fi_appdate)   */                          /*วันที่อนุมัติตรวจสภาพรถ   */    
                    brstat.tlt.nor_noti_tlt  = /*"InspSt:" + trim(fi_inspres) + " " + */        /*ผลการตรวจสภาพรถ           */    
                                               "InspDe:" + trim(fi_inspdet)                 /*รายละเอียดการตรวจสภาพรถ   */    
                    brstat.tlt.old_eng       = "Bphon:"  + trim(fi_brolincen) + " " +       /*เลขที่ใบอนุญาตนายหน้า   */      
                                               "Bname:"  + trim(fi_bronam) + " " +          /*ชื่อบริษัทนายหน้า       */      
                                               "Bloca:"  + trim(fi_brocod)                  /*รหัสโบรคเกอร์           */      
                    brstat.tlt.filler2       = /*"Detai1:" + trim(fi_lang) + " " +            /*ภาษาในการออกกรมธรรม์    */      
                                               "Detai2:" + trim(fi_polsend) + " " +*/         /*ช่องทางการจัดส่ง        */      
                                               "Detai3:" + trim(fi_remarksend) + " " +      /*หมายเหตุการจัดส่ง       */      
                                              /* "Detai4:" + trim(fi_gift) + " " + */           /*ของแถม                  */      
                                               "Remark:" + trim(fi_remark)                 /*หมายเหตุ                */
                    brstat.tlt.EXP           = trim(fi_lang)
                    brstat.tlt.imp           = /*trim(SUBSTR(brstat.tlt.imp,1,INDEX(brstat.tlt.imp," ") - 1))  + " " +  */      /*ประเภท        */ 
                                               "Pol:" + TRIM(fi_oldpol)                 /*เบอร์เดิม */
                    brstat.tlt.usrid         = IF index(brstat.tlt.usrid,"/") <> 0 THEN SUBSTR(brstat.tlt.usrid,1,INDEX(tlt.usrid,"/")) + USERID(LDBNAME(1)) 
                                               ELSE brstat.tlt.usrid + "/" + USERID(LDBNAME(1))  .           /*user update*/

                   
            END.                                                    
            /*Apply "Close" to this-procedure.
            Return no-apply.*/
             APPLY "entry" TO fi_polno.
            RETURN NO-APPLY. 
        END.
        WHEN FALSE THEN /* No */          
            DO:   
            APPLY "entry" TO fi_polno.
            RETURN NO-APPLY.
        END.
        END CASE.
Disp  fi_polno with  frame  fr_main.
RELEASE brstat.tlt.
*/

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
  
  gv_prgid = "WGWQHCT2".
  gv_prog  = "Query & Update Notify (HCT) ".
  RUN  WUT\WUTHEAD ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).

/*********************************************************************/ 
 /*  RUN Wut\WutwiCen ({&WINDOW-NAME}:HANDLE). */ 
  /*CURRENT-WINDOW:WINDOW-STATE = WINDOW-MAXIMIZED.*/
  SESSION:DATA-ENTRY-RETURN = YES.
 
  Find  brstat.tlt  Where   Recid(tlt)  =  nv_recidtlt NO-LOCK NO-ERROR NO-WAIT .
  If  avail  tlt  Then do:
      Assign
          fi_TPBIPer          =     brstat.tlt.comp_coamt        
          fi_TPBIAcc          =     brstat.tlt.comp_grprm        
          fi_TPPDPer          =     brstat.tlt.mileage           
          fi_deductamt        =     brstat.tlt.ndeci1            
          fi_OwnDamage        =     brstat.tlt.ndeci2            
          fi_OwnDaDeduct      =     brstat.tlt.ndeci3            
          fi_FITheft          =     brstat.tlt.ndeci4  
          fi_411              =     brstat.tlt.ndeci5            
          fi_passager         =     brstat.tlt.nor_coamt         
          fi_412              =     brstat.tlt.nor_grprm         
          fi_driverper        =     brstat.tlt.prem_amt          
          fi_passagerper      =     brstat.tlt.prem_amttcop      
          fi_passageracc      =     brstat.tlt.rstp              
          fi_42               =     brstat.tlt.rtax              
          fi_43               =     brstat.tlt.tax_coporate  
          fi_statusdata        =    brstat.tlt.note5                     
          fi_typesenddata      =    brstat.tlt.note6                     
          fi_companynoti       =    brstat.tlt.note7                     
          fi_branchnoty        =    brstat.tlt.note8
          fi_contractsale      =    brstat.tlt.note9                    
          fi_dealer            =    brstat.tlt.noteveh1                 
          fi_brdealer          =    brstat.tlt.noteveh2                 
          fi_hondapro          =    brstat.tlt.old_cha                  
          fi_carold            =    brstat.tlt.old_eng  
          fi_acc1              =    brstat.tlt.pack                       
          fi_priceacc1         =    brstat.tlt.packnme                    
          fi_acc2              =    brstat.tlt.period                     
          fi_priceacc2         =    brstat.tlt.policy                     
          fi_acc3              =    brstat.tlt.product                    
          fi_priceacc3         =    brstat.tlt.projnme                    
          fi_acc4              =    brstat.tlt.proveh                     
          fi_priceacc4         =    brstat.tlt.race                       
          fi_acc5              =    brstat.tlt.recac                   
          fi_priceacc5         =    brstat.tlt.rec_addr
          fi_bookno            =    brstat.tlt.rec_addr1        
          fi_bookdate          =    brstat.tlt.rec_addr2        
          fi_amountamt         =    brstat.tlt.rec_addr3        
          fi_userpay           =    brstat.tlt.rec_addr4        
          fi_agentlicen        =    brstat.tlt.rec_addr5        
          fi_receiptype        =    brstat.tlt.rec_brins        
          fi_receipname        =    brstat.tlt.rec_cou          
          fi_detailcam         =    brstat.tlt.rec_icno         
          fi_surcepay          =    brstat.tlt.rec_name         
          fi_paymount          =    brstat.tlt.rec_name2        
          fi_creditbank        =    brstat.tlt.rec_note1        
          fi_typeofsenddata    =    brstat.tlt.rec_note2        
          fi_totleaccamt       =    brstat.tlt.rec_title        
          fi_detailadddes      =    brstat.tlt.rec_typ          
          fi_brins             =    brstat.tlt.rider            
          fi_brandgress        =    brstat.tlt.safe1            
          fi_pricegress        =    brstat.tlt.safe2 

          .
      /*RUN proc_assignfi .*/

      DISP fi_TPBIPer   fi_TPBIAcc fi_TPPDPer  fi_deductamt  fi_OwnDamage fi_OwnDaDeduct    
          fi_FITheft fi_411  fi_passager  fi_412  fi_driverper      fi_passagerper    fi_passageracc    
          fi_42 fi_43     fi_statusdata fi_typesenddata  fi_companynoti   fi_branchnoty    fi_contractsale      
          fi_dealer  fi_brdealer   fi_hondapro  fi_carold  fi_acc1 fi_priceacc1   fi_acc2                
          fi_priceacc2   fi_acc3  fi_priceacc3  fi_acc4   fi_priceacc4    fi_acc5     fi_priceacc5      
          fi_bookno   fi_bookdate    fi_amountamt     fi_userpay    fi_agentlicen fi_receiptype     
          fi_receipname   fi_detailcam    fi_surcepay      fi_paymount     fi_creditbank      fi_typeofsenddata     
          fi_totleaccamt  fi_detailadddes  fi_brins   fi_brandgress   fi_pricegress     bu_detail1        bu_save       bu_exit WITH frame  fr_main. 
          bu_detail2:BGCOLOR = 19.
          bu_detail2:FGCOLOR = 6. 
          /*DISABLE bu_detail2 WITH FRAME fr_main.*/

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
  DISPLAY fi_OwnDamage fi_OwnDaDeduct fi_FITheft fi_411 fi_passager fi_412 
          fi_driverper fi_passagerper fi_passageracc fi_42 fi_43 fi_statusdata 
          fi_typesenddata fi_contractsale fi_dealer fi_pricegress fi_acc5 
          fi_TPPDPer fi_deductamt fi_brins fi_brandgress fi_detailadddes 
          fi_TPBIPer fi_TPBIAcc fi_brdealer fi_hondapro fi_carold fi_acc1 
          fi_priceacc1 fi_acc2 fi_priceacc2 fi_acc3 fi_priceacc3 fi_acc4 
          fi_priceacc4 fi_amountamt fi_userpay fi_agentlicen fi_receiptype 
          fi_receipname fi_detailcam fi_surcepay fi_paymount fi_creditbank 
          fi_typeofsenddata fi_companynoti fi_branchnoty fi_totleaccamt 
          fi_userup fi_priceacc5 fi_bookno fi_bookdate 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE bu_save bu_exit bu_detail2 bu_detail1 fi_OwnDamage fi_OwnDaDeduct 
         fi_FITheft fi_411 fi_passager fi_412 fi_driverper fi_passagerper 
         fi_passageracc fi_42 fi_43 fi_statusdata fi_typesenddata 
         fi_contractsale fi_dealer fi_pricegress fi_acc5 fi_TPPDPer 
         fi_deductamt fi_brins fi_brandgress fi_detailadddes fi_TPBIPer 
         fi_TPBIAcc fi_brdealer fi_hondapro fi_carold fi_acc1 fi_priceacc1 
         fi_acc2 fi_priceacc2 fi_acc3 fi_priceacc3 fi_acc4 fi_priceacc4 
         fi_amountamt fi_userpay fi_agentlicen fi_receiptype fi_receipname 
         fi_detailcam fi_surcepay fi_paymount fi_creditbank fi_typeofsenddata 
         fi_companynoti fi_branchnoty fi_totleaccamt fi_userup fi_priceacc5 
         fi_bookno fi_bookdate bu_detail-3 RECT-335 RECT-465 RECT-503 
      WITH FRAME fr_main IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assignfi C-Win 
PROCEDURE proc_assignfi :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO:
    /*
    ASSIGN 
        /*-- อุปกรณ์ตกแต่ง ---*/
        fi_accpric5  = INT(substr(brstat.tlt.filler1,R-INDEX(brstat.tlt.filler1,"Acp5:") + 5))
        n_char       = TRIM(SUBSTR(brstat.tlt.filler1,1,R-INDEX(brstat.tlt.filler1,"Acp5:") - 2 ))
        fi_accdet5   = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Acd5:") + 5 ))
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acd5:") - 2))
        fi_accpric4  = INT(SUBSTR(n_char,R-INDEX(n_char,"Acp4:") + 5 ))
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acp4:") - 2 ))
        fi_accdet4   = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Acd4:") + 5 ))
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acd4:") - 2 ))
        fi_accpric3  = INT(SUBSTR(n_char,R-INDEX(n_char,"Acp3:") + 5 )) 
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acp3:") - 2 ))
        fi_accdet3   = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Acd3:") + 5 )) 
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acd3:") - 2 )) 
        fi_accpric2  = INT(SUBSTR(n_char,R-INDEX(n_char,"Acp2:") + 5 )) 
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acp2:") - 2 ))
        fi_accdet2   = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Acd2:") + 5 )) 
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acd2:") - 2 ))
        fi_accpric1  = INT(SUBSTR(n_char,R-INDEX(n_char,"Acp1:") + 5 )) 
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acp1:") - 2 ))  
        fi_accdet1   = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Acd1:") + 5 )) 
        fi_inspdate  = brstat.tlt.nor_effdat   
        fi_inspdet   = TRIM(SUBSTR(brstat.tlt.nor_noti_tlt,R-INDEX(brstat.tlt.nor_noti_tlt,"InspDe:") + 7 ))
        fi_brocod    = TRIM(SUBSTR(brstat.tlt.old_eng,R-INDEX(brstat.tlt.old_eng,"Bloca:") + 6 ))    /* Car Inspection Phone            */
        n_char       = TRIM(SUBSTR(brstat.tlt.old_eng,1,R-INDEX(brstat.tlt.old_eng,"Bloca:") - 2 ))  
        fi_bronam    = TRIM(SUBSTR(n_char,R-INDEX(n_char,"bname:") + 6 ))                            /* Car Inspection Name             */                                   
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"bname:") - 2 ))                          
        fi_brolincen = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Bphon:") + 6 ))                            /* Car Inspection Location         */

        fi_remark    = TRIM(SUBSTR(brstat.tlt.filler2,R-INDEX(brstat.tlt.filler2,"Remark:") + 7 ))
        n_char       = TRIM(SUBSTR(brstat.tlt.filler2,1,R-INDEX(brstat.tlt.filler2,"Remark:") - 2 ))
        fi_remarksend = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Detai3:") + 7 ))
        fi_lang      = TRIM(brstat.tlt.exp).
        */
END.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assignfi-bp C-Win 
PROCEDURE proc_assignfi-bp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*DO:
    ASSIGN 
        /*-- อุปกรณ์ตกแต่ง ---*/
        fi_accpric5  = INT(substr(brstat.tlt.filler1,R-INDEX(brstat.tlt.filler1,"Acp5:") + 5))
        n_char       = TRIM(SUBSTR(brstat.tlt.filler1,1,R-INDEX(brstat.tlt.filler1,"Acp5:") - 2 ))
        fi_accdet5   = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Acd5:") + 5 ))
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acd5:") - 2))
        /*fi_accr5     = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Acc5:") + 5 ))
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acc5:") - 2 ))*/
        fi_accpric4  = INT(SUBSTR(n_char,R-INDEX(n_char,"Acp4:") + 5 ))
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acp4:") - 2 ))
        fi_accdet4   = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Acd4:") + 5 ))
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acd4:") - 2 ))
        /*fi_accr4     = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Acc4:") + 5 ))
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acc4:") - 2 ))*/
        fi_accpric3  = INT(SUBSTR(n_char,R-INDEX(n_char,"Acp3:") + 5 )) 
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acp3:") - 2 ))
        fi_accdet3   = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Acd3:") + 5 )) 
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acd3:") - 2 )) 
        /*fi_accr3     = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Acc3:") + 5 )) 
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acc3:") - 2 ))*/
        fi_accpric2  = INT(SUBSTR(n_char,R-INDEX(n_char,"Acp2:") + 5 )) 
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acp2:") - 2 ))
        fi_accdet2   = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Acd2:") + 5 )) 
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acd2:") - 2 ))
        /*fi_accr2     = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Acc2:") + 5 )) 
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acc2:") - 2 ))*/
        fi_accpric1  = INT(SUBSTR(n_char,R-INDEX(n_char,"Acp1:") + 5 )) 
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acp1:") - 2 ))  
        fi_accdet1   = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Acd1:") + 5 )) 
        /*n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acd1:") - 2 ))
        fi_accr1     = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Acc1:") + 5 ))*/
        fi_inspdate  = brstat.tlt.nor_effdat   
        /*fi_appdate   = brstat.tlt.comp_effdat */
        fi_inspres   = TRIM(SUBSTR(brstat.tlt.nor_noti_tlt,8,R-INDEX(brstat.tlt.nor_noti_tlt,"Inspde:") - 8))
        /*fi_inspdet   = TRIM(SUBSTR(brstat.tlt.nor_noti_tlt,R-INDEX(brstat.tlt.nor_noti_tlt,"Inspde:") + 7))*/
       /* fi_brocod    = TRIM(SUBSTR(brstat.tlt.old_eng,R-INDEX(brstat.tlt.old_eng,"Bcode:") + 6 ))
        n_char       = TRIM(SUBSTR(brstat.tlt.old_eng,1,R-INDEX(brstat.tlt.old_eng,"Bcode:") - 2 ))
        fi_bronam    = TRIM(SUBSTR(n_char,R-INDEX(n_char,"bname:") + 6 ))
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"bname:") - 2 ))
        fi_brolincen = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Blice:") + 6 ))*/

        fi_brocod    = TRIM(SUBSTR(brstat.tlt.old_eng,R-INDEX(brstat.tlt.old_eng,"Bloca:") + 6 ))    /* Car Inspection Phone            */
        n_char       = TRIM(SUBSTR(brstat.tlt.old_eng,1,R-INDEX(brstat.tlt.old_eng,"Bloca:") - 2 ))  
        fi_bronam    = TRIM(SUBSTR(n_char,R-INDEX(n_char,"bname:") + 6 ))                            /* Car Inspection Name             */                                   
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"bname:") - 2 ))                          
        fi_brolincen = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Bphon:") + 6 ))                            /* Car Inspection Location         */

        fi_remark    = TRIM(SUBSTR(brstat.tlt.filler2,R-INDEX(brstat.tlt.filler2,"Remark:") + 7 ))
        n_char       = TRIM(SUBSTR(brstat.tlt.filler2,1,R-INDEX(brstat.tlt.filler2,"Remark:") - 2 ))
        /*fi_gift      = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Detai4:") + 7 ))
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Detai4:") - 2 ))*/
        fi_remarksend = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Detai3:") + 7 ))
        /*n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"detai3:") - 2 ))
        fi_polsend   = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Detai2:") + 7 ))
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"detai2:") - 2 ))
        fi_lang      = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Detai1:") + 7 ))*/ 
        fi_lang      = TRIM(brstat.tlt.exp).
END.*/


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

