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
  wgwqscb3.w  : Query and Update data Inspection on table tlt  
  Create  by :  Ranu i. A60-0448 Date : 16/10/2017
  Connect   :  gw_stat ld brstat , gw_safe ld sic_bran ,sic_test ld sicuw sicsyac :not connect stat
+++++++++++++++++++++++++++++++++++++++++++++++*/
Def  Input  parameter  nv_recidtlt  as  recid  .
Def  var nv_index  as int  init 0.
DEF  VAR nv_chaidrep AS CHARACTER . /*A57-0262*/
/* Ranu i. inspection A60-0118           */
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
&Scoped-Define ENABLED-OBJECTS bu_save bu_exit fi_camp fi_campnam fi_produc ~
fi_producnam fi_pacg fi_pacgnam fi_nameth fi_surth fi_instime fi_inspdate ~
fi_telcon fi_poltel fi_mail fi_line fi_poladdr1 fi_contnam fi_cover ~
fi_refno fi_custcode fi_polno fi_agent fi_trandat fi_user fi_time fi_brand ~
fi_model fi_lincen fi_province fi_chssic fi_engno fi_year fi_seat fi_cc ~
fi_ton fi_class fi_si fi_premtotal fi_comdat fi_expdat fi_accr1 fi_accdet1 ~
fi_accpric1 fi_accr2 fi_accdet2 fi_accpric2 fi_accr3 fi_accdet3 fi_accpric3 ~
fi_accr4 fi_accdet4 fi_accpric4 fi_accr5 fi_accdet5 fi_accpric5 ~
fi_insresult fi_inspno fi_status fi_inspdes bu_upins fi_resultdel ~
fi_detailoth fi_closedat fi_confirm fi_datesent fi_resultdel2 fi_inspacc ~
fi_resultdel3 fi_custno fi_tmpcon1 fi_tmpcon2 RECT-462 RECT-465 RECT-466 
&Scoped-Define DISPLAYED-OBJECTS fi_camp fi_campnam fi_produc fi_producnam ~
fi_pacg fi_pacgnam fi_nameth fi_surth fi_instime fi_inspdate fi_telcon ~
fi_poltel fi_mail fi_line fi_poladdr1 fi_contnam fi_cover fi_refno ~
fi_custcode fi_polno fi_agent fi_trandat fi_user fi_time fi_brand fi_model ~
fi_lincen fi_province fi_chssic fi_engno fi_year fi_seat fi_cc fi_ton ~
fi_class fi_si fi_premtotal fi_comdat fi_expdat fi_accr1 fi_accdet1 ~
fi_accpric1 fi_accr2 fi_accdet2 fi_accpric2 fi_accr3 fi_accdet3 fi_accpric3 ~
fi_accr4 fi_accdet4 fi_accpric4 fi_accr5 fi_accdet5 fi_accpric5 ~
fi_insresult fi_inspno fi_status fi_inspdes fi_resultdel fi_detailoth ~
fi_closedat fi_confirm fi_datesent fi_resultdel2 fi_inspacc fi_resultdel3 ~
fi_custno fi_tmpcon1 fi_tmpcon2 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bu_exit 
     LABEL "Exit" 
     SIZE 8 BY 1.67
     BGCOLOR 6 FONT 6.

DEFINE BUTTON bu_save 
     LABEL "Save" 
     SIZE 7.83 BY 1.62
     BGCOLOR 2 FGCOLOR 15 FONT 6.

DEFINE BUTTON bu_upins 
     LABEL "อัพเดทข้อมูล" 
     SIZE 12.67 BY 1
     BGCOLOR 13 FGCOLOR 2 FONT 6.

DEFINE VARIABLE fi_accdet1 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 38.67 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_accdet2 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 38.67 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_accdet3 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 38.67 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_accdet4 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 38.67 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_accdet5 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 38.67 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_accpric1 AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 17.83 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_accpric2 AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 17.83 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_accpric3 AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 17.83 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_accpric4 AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 17.83 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_accpric5 AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 17.83 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_accr1 AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 39.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_accr2 AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 39.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_accr3 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 39.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_accr4 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 39.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_accr5 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 39.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_agent AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 16 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_brand AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 13.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_camp AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 13.33 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_campnam AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 18.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_cc AS INTEGER FORMAT ">>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 7.67 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_chssic AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 19.17 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_class AS CHARACTER FORMAT "X(5)":U 
     VIEW-AS FILL-IN 
     SIZE 6.33 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_closedat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 13.67 BY 1
     BGCOLOR 19 FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE fi_comdat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 14.17 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_confirm AS CHARACTER FORMAT "X(60)":U 
      VIEW-AS TEXT 
     SIZE 5.67 BY .95
     BGCOLOR 19 FGCOLOR 6 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_contnam AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 36.33 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_cover AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 22.17 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_custcode AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 17.33 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_custno AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 24.33 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_datesent AS DATE FORMAT "99/99/9999":U 
      VIEW-AS TEXT 
     SIZE 11.83 BY .95
     BGCOLOR 19 FGCOLOR 6 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_detailoth AS CHARACTER FORMAT "X(250)":U 
     VIEW-AS FILL-IN 
     SIZE 91.67 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_engno AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 16.17 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_expdat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 13.33 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_inspacc AS CHARACTER FORMAT "X(250)":U 
     VIEW-AS FILL-IN 
     SIZE 105.67 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_inspdate AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 13.83 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_inspdes AS CHARACTER FORMAT "X(60)":U 
     VIEW-AS FILL-IN 
     SIZE 10.17 BY 1
     BGCOLOR 19 FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE fi_inspno AS CHARACTER FORMAT "X(60)":U 
     VIEW-AS FILL-IN 
     SIZE 17.33 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_insresult AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 105.67 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_instime AS CHARACTER FORMAT "X(13)":U 
     VIEW-AS FILL-IN 
     SIZE 12.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_lincen AS CHARACTER FORMAT "X(12)":U 
     VIEW-AS FILL-IN 
     SIZE 10.67 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_line AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 26.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_mail AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 27.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_model AS CHARACTER FORMAT "X(60)":U 
     VIEW-AS FILL-IN 
     SIZE 19.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_nameth AS CHARACTER FORMAT "X(60)":U 
     VIEW-AS FILL-IN 
     SIZE 27 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_pacg AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 16.33 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_pacgnam AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 22.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_poladdr1 AS CHARACTER FORMAT "X(150)":U 
     VIEW-AS FILL-IN 
     SIZE 60 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_polno AS CHARACTER FORMAT "X(13)":U 
     VIEW-AS FILL-IN 
     SIZE 17.83 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_poltel AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 18.17 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_premtotal AS DECIMAL FORMAT "->,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 16.83 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_produc AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 19 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_producnam AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 31.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_province AS CHARACTER FORMAT "X(35)":U 
     VIEW-AS FILL-IN 
     SIZE 16.17 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_refno AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 22.17 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_resultdel AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 105.67 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_resultdel2 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 105.67 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_resultdel3 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 105.67 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_seat AS INTEGER FORMAT ">9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 4.33 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_si AS INTEGER FORMAT "->>,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 16.17 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_status AS CHARACTER FORMAT "X(60)":U 
     VIEW-AS FILL-IN 
     SIZE 7 BY 1
     BGCOLOR 19 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_surth AS CHARACTER FORMAT "X(60)":U 
     VIEW-AS FILL-IN 
     SIZE 26.33 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_telcon AS CHARACTER FORMAT "X(60)":U 
     VIEW-AS FILL-IN 
     SIZE 24.67 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_time AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 12 BY 1
     BGCOLOR 8 FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE fi_tmpcon1 AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 33 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_tmpcon2 AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 32.67 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_ton AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 6.67 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_trandat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 13.67 BY 1
     BGCOLOR 8 FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE fi_user AS CHARACTER FORMAT "X(13)":U 
     VIEW-AS FILL-IN 
     SIZE 9 BY 1
     BGCOLOR 10 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_year AS CHARACTER FORMAT "X(5)":U 
     VIEW-AS FILL-IN 
     SIZE 8.33 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE RECTANGLE RECT-462
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132.5 BY 24.62
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-465
     EDGE-PIXELS 2 GRAPHIC-EDGE    ROUNDED 
     SIZE 130.67 BY 15.24
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-466
     EDGE-PIXELS 2 GRAPHIC-EDGE    ROUNDED 
     SIZE 122.33 BY 7.62
     BGCOLOR 29 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     bu_save AT ROW 22.76 COL 125.5
     bu_exit AT ROW 24.57 COL 125.5
     fi_camp AT ROW 4.86 COL 13.67 COLON-ALIGNED NO-LABEL
     fi_campnam AT ROW 4.86 COL 38 COLON-ALIGNED NO-LABEL
     fi_produc AT ROW 4.81 COL 67.33 COLON-ALIGNED NO-LABEL
     fi_producnam AT ROW 4.81 COL 98 COLON-ALIGNED NO-LABEL
     fi_pacg AT ROW 5.95 COL 13.67 COLON-ALIGNED NO-LABEL
     fi_pacgnam AT ROW 5.95 COL 42.5 COLON-ALIGNED NO-LABEL
     fi_nameth AT ROW 7 COL 13.5 COLON-ALIGNED NO-LABEL
     fi_surth AT ROW 7 COL 45.17 COLON-ALIGNED NO-LABEL
     fi_instime AT ROW 8.05 COL 34.17 COLON-ALIGNED NO-LABEL
     fi_inspdate AT ROW 8.05 COL 13.5 COLON-ALIGNED NO-LABEL
     fi_telcon AT ROW 8 COL 105 COLON-ALIGNED NO-LABEL
     fi_poltel AT ROW 6.95 COL 81 COLON-ALIGNED NO-LABEL
     fi_mail AT ROW 10.14 COL 13.5 COLON-ALIGNED NO-LABEL
     fi_line AT ROW 9.05 COL 103 COLON-ALIGNED NO-LABEL
     fi_poladdr1 AT ROW 10.1 COL 50.17 COLON-ALIGNED NO-LABEL
     fi_contnam AT ROW 8.05 COL 57.17 COLON-ALIGNED NO-LABEL
     fi_cover AT ROW 6.95 COL 107.5 COLON-ALIGNED NO-LABEL
     fi_refno AT ROW 3.76 COL 42.67 COLON-ALIGNED NO-LABEL
     fi_custcode AT ROW 3.71 COL 81 COLON-ALIGNED NO-LABEL
     fi_polno AT ROW 2.38 COL 53 COLON-ALIGNED NO-LABEL
     fi_agent AT ROW 3.76 COL 13.67 COLON-ALIGNED NO-LABEL
     fi_trandat AT ROW 2.43 COL 83.5 COLON-ALIGNED NO-LABEL
     fi_user AT ROW 2.43 COL 120.5 COLON-ALIGNED NO-LABEL
     fi_time AT ROW 2.43 COL 102.33 COLON-ALIGNED NO-LABEL
     fi_brand AT ROW 10.14 COL 116.17 COLON-ALIGNED NO-LABEL
     fi_model AT ROW 11.19 COL 13.33 COLON-ALIGNED NO-LABEL
     fi_lincen AT ROW 12.24 COL 13.33 COLON-ALIGNED NO-LABEL
     fi_province AT ROW 11.19 COL 100.33 COLON-ALIGNED NO-LABEL
     fi_chssic AT ROW 12.24 COL 33.33 COLON-ALIGNED NO-LABEL
     fi_engno AT ROW 12.19 COL 62.5 COLON-ALIGNED NO-LABEL
     fi_year AT ROW 11.19 COL 121.17 COLON-ALIGNED NO-LABEL
     fi_seat AT ROW 11.14 COL 53 COLON-ALIGNED NO-LABEL
     fi_cc AT ROW 11.14 COL 66 COLON-ALIGNED NO-LABEL
     fi_ton AT ROW 11.14 COL 83.5 COLON-ALIGNED NO-LABEL
     fi_class AT ROW 11.19 COL 40.17 COLON-ALIGNED NO-LABEL
     fi_si AT ROW 5.91 COL 76.67 COLON-ALIGNED NO-LABEL
     fi_premtotal AT ROW 5.91 COL 104 COLON-ALIGNED NO-LABEL
     fi_comdat AT ROW 12.24 COL 89.33 COLON-ALIGNED NO-LABEL
     fi_expdat AT ROW 12.24 COL 116.17 COLON-ALIGNED NO-LABEL
     fi_accr1 AT ROW 13.29 COL 13.33 COLON-ALIGNED NO-LABEL
     fi_accdet1 AT ROW 13.29 COL 65.17 COLON-ALIGNED NO-LABEL
     fi_accpric1 AT ROW 13.29 COL 111 COLON-ALIGNED NO-LABEL
     fi_accr2 AT ROW 14.33 COL 13.33 COLON-ALIGNED NO-LABEL
     fi_accdet2 AT ROW 14.33 COL 65.17 COLON-ALIGNED NO-LABEL
     fi_accpric2 AT ROW 14.33 COL 111 COLON-ALIGNED NO-LABEL
     fi_accr3 AT ROW 15.38 COL 13.33 COLON-ALIGNED NO-LABEL
     fi_accdet3 AT ROW 15.38 COL 65.17 COLON-ALIGNED NO-LABEL
     fi_accpric3 AT ROW 15.38 COL 111 COLON-ALIGNED NO-LABEL
     fi_accr4 AT ROW 16.43 COL 13.33 COLON-ALIGNED NO-LABEL
     fi_accdet4 AT ROW 16.43 COL 65.17 COLON-ALIGNED NO-LABEL
     fi_accpric4 AT ROW 16.43 COL 111 COLON-ALIGNED NO-LABEL
     fi_accr5 AT ROW 17.48 COL 13.33 COLON-ALIGNED NO-LABEL
     fi_accdet5 AT ROW 17.48 COL 65.17 COLON-ALIGNED NO-LABEL
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1.17 ROW 1.05
         SIZE 133.67 BY 25.95
         BGCOLOR 18 FGCOLOR 1 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     fi_accpric5 AT ROW 17.48 COL 111 COLON-ALIGNED NO-LABEL
     fi_insresult AT ROW 20.19 COL 14.33 COLON-ALIGNED NO-LABEL
     fi_inspno AT ROW 19.14 COL 74 COLON-ALIGNED NO-LABEL
     fi_status AT ROW 19.14 COL 46.83 COLON-ALIGNED NO-LABEL
     fi_inspdes AT ROW 19.14 COL 54.17 COLON-ALIGNED NO-LABEL
     bu_upins AT ROW 25.24 COL 109.67
     fi_resultdel AT ROW 21.19 COL 14.33 COLON-ALIGNED NO-LABEL
     fi_detailoth AT ROW 25.19 COL 14.33 COLON-ALIGNED NO-LABEL
     fi_closedat AT ROW 19.14 COL 103.5 COLON-ALIGNED NO-LABEL
     fi_confirm AT ROW 19.14 COL 14.83 COLON-ALIGNED NO-LABEL
     fi_datesent AT ROW 19.14 COL 21.5 COLON-ALIGNED NO-LABEL
     fi_resultdel2 AT ROW 22.19 COL 14.33 COLON-ALIGNED NO-LABEL
     fi_inspacc AT ROW 24.19 COL 14.33 COLON-ALIGNED NO-LABEL
     fi_resultdel3 AT ROW 23.19 COL 14.33 COLON-ALIGNED NO-LABEL
     fi_custno AT ROW 3.71 COL 105.17 COLON-ALIGNED NO-LABEL WIDGET-ID 2
     fi_tmpcon1 AT ROW 9.1 COL 13.5 COLON-ALIGNED NO-LABEL WIDGET-ID 6
     fi_tmpcon2 AT ROW 9.1 COL 60.67 COLON-ALIGNED NO-LABEL WIDGET-ID 10
     "ชื่อ :" VIEW-AS TEXT
          SIZE 3.33 BY .91 AT ROW 7.1 COL 11
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "ความเสียหาย :" VIEW-AS TEXT
          SIZE 12.5 BY .91 AT ROW 21.24 COL 3.5
          BGCOLOR 29 FGCOLOR 12 FONT 6
     "น้ำหนักรถ :" VIEW-AS TEXT
          SIZE 9 BY .91 AT ROW 11.24 COL 76.17
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "Tmp contact2 :" VIEW-AS TEXT
          SIZE 12.5 BY .91 AT ROW 9.14 COL 49.5 WIDGET-ID 12
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "รายละเอียด1:" VIEW-AS TEXT
          SIZE 10.67 BY .91 AT ROW 13.33 COL 56.33
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "รายละเอียด2:" VIEW-AS TEXT
          SIZE 10.67 BY .91 AT ROW 14.38 COL 56.33
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "อุปกรณ์เสริม1:" VIEW-AS TEXT
          SIZE 11.5 BY .91 AT ROW 13.38 COL 3
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "User:" VIEW-AS TEXT
          SIZE 5.33 BY .91 AT ROW 2.48 COL 117.17
          BGCOLOR 19 FGCOLOR 4 FONT 1
     "เลขเครื่อง :" VIEW-AS TEXT
          SIZE 9 BY .91 AT ROW 12.29 COL 55.33
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "ชื่อแคมเปญ:" VIEW-AS TEXT
          SIZE 10.17 BY .91 AT ROW 4.91 COL 29.5
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "จ.ทะเบียน :" VIEW-AS TEXT
          SIZE 9.5 BY .91 AT ROW 11.29 COL 92.67
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "เวลา:" VIEW-AS TEXT
          SIZE 4.5 BY .91 AT ROW 2.48 COL 99.5
          BGCOLOR 19 FGCOLOR 4 FONT 1
     "ราคา3:" VIEW-AS TEXT
          SIZE 5.5 BY .91 AT ROW 15.43 COL 107.33
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "อุปกรณ์เสริม5:" VIEW-AS TEXT
          SIZE 11.5 BY .91 AT ROW 17.57 COL 3
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "วันนัดหมาย :" VIEW-AS TEXT
          SIZE 10.67 BY .91 AT ROW 8.1 COL 3.83
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "ยี่ห้อ :" VIEW-AS TEXT
          SIZE 4.5 BY .91 AT ROW 10.24 COL 112.67
          BGCOLOR 19 FGCOLOR 2 FONT 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1.17 ROW 1.05
         SIZE 133.67 BY 25.95
         BGCOLOR 18 FGCOLOR 1 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "ราคา1:" VIEW-AS TEXT
          SIZE 5.5 BY .91 AT ROW 13.33 COL 107.33
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "แพ็คเกจID :" VIEW-AS TEXT
          SIZE 9.67 BY .91 AT ROW 6 COL 4.83
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "ชื่อแพ็คเกจ:" VIEW-AS TEXT
          SIZE 10.17 BY .91 AT ROW 6 COL 33.83
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "ชื่อผู้ติดต่อ :" VIEW-AS TEXT
          SIZE 9 BY .91 AT ROW 8.1 COL 49.83
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "เลขใบคำขอ:" VIEW-AS TEXT
          SIZE 11.83 BY .91 AT ROW 3.81 COL 32.5
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "วันที่โหลดงาน:" VIEW-AS TEXT
          SIZE 11.5 BY .91 AT ROW 2.48 COL 73.83
          BGCOLOR 19 FGCOLOR 4 FONT 1
     "ซีซีรถ :" VIEW-AS TEXT
          SIZE 5.83 BY .91 AT ROW 11.24 COL 61.33
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "รายละเอียด4:" VIEW-AS TEXT
          SIZE 10.67 BY .91 AT ROW 16.48 COL 56.33
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "เลขตัวถัง :" VIEW-AS TEXT
          SIZE 8.17 BY .91 AT ROW 12.33 COL 27
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "ราคา5:" VIEW-AS TEXT
          SIZE 5.5 BY .91 AT ROW 17.52 COL 107.33
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "ทะเบียน :" VIEW-AS TEXT
          SIZE 8 BY .91 AT ROW 12.33 COL 6.67
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "Prospect no :" VIEW-AS TEXT
          SIZE 15.5 BY .91 AT ROW 3.81 COL 67.33
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "ชื่อผลิตภัณฑ์:" VIEW-AS TEXT
          SIZE 11 BY .91 AT ROW 4.86 COL 89
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "Insp No :" VIEW-AS TEXT
          SIZE 8.67 BY .91 AT ROW 19.14 COL 66.83
          BGCOLOR 29 FGCOLOR 12 FONT 6
     "อีเมล์:" VIEW-AS TEXT
          SIZE 4.5 BY .91 AT ROW 10.24 COL 9.67
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "อุปกรณ์เสริม :" VIEW-AS TEXT
          SIZE 12.5 BY .91 AT ROW 24.24 COL 3.5
          BGCOLOR 29 FGCOLOR 12 FONT 6
     "Class :" VIEW-AS TEXT
          SIZE 5.5 BY .91 AT ROW 11.24 COL 36.17
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "ปี :" VIEW-AS TEXT
          SIZE 2.83 BY .91 AT ROW 11.29 COL 120
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "Cust :" VIEW-AS TEXT
          SIZE 6 BY .91 AT ROW 3.76 COL 101 WIDGET-ID 4
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "เบอร์ติดต่อ :" VIEW-AS TEXT
          SIZE 10 BY .91 AT ROW 8.1 COL 96.83
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "ส่งข้อมูลกลับ :" VIEW-AS TEXT
          SIZE 12.5 BY .91 AT ROW 19.19 COL 3.83
          BGCOLOR 29 FGCOLOR 6 FONT 6
     "เวลา :" VIEW-AS TEXT
          SIZE 5 BY .91 AT ROW 8.05 COL 30.67
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "วันที่หมดอายุ:" VIEW-AS TEXT
          SIZE 11.5 BY .91 AT ROW 12.29 COL 106.17
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "  แคมเปญID :" VIEW-AS TEXT
          SIZE 11 BY .91 AT ROW 5.14 COL 3.67
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "สกุล:" VIEW-AS TEXT
          SIZE 4 BY .91 AT ROW 7.05 COL 43
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "  ข้อมูลลูกค้า" VIEW-AS TEXT
          SIZE 12.17 BY .91 AT ROW 2.95 COL 4
          BGCOLOR 19 FGCOLOR 4 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1.17 ROW 1.05
         SIZE 133.67 BY 25.95
         BGCOLOR 18 FGCOLOR 1 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "สถานที่:" VIEW-AS TEXT
          SIZE 6.5 BY .91 AT ROW 10.1 COL 45
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "ทุนประกัน:" VIEW-AS TEXT
          SIZE 8.83 BY .91 AT ROW 5.95 COL 69.33
          BGCOLOR 19 FGCOLOR 6 FONT 1
     " Query and Update Data Inspection AYCAL" VIEW-AS TEXT
          SIZE 43.5 BY .91 AT ROW 1.14 COL 2
          BGCOLOR 18 FGCOLOR 7 FONT 6
     "ไลน์ไอดี:" VIEW-AS TEXT
          SIZE 7.5 BY .91 AT ROW 9.05 COL 97
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "ประเภท:" VIEW-AS TEXT
          SIZE 7 BY .91 AT ROW 7 COL 102
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "ผลิตภัณฑ์ID:" VIEW-AS TEXT
          SIZE 10 BY .91 AT ROW 4.86 COL 59.33
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "อุปกรณ์เสริม4:" VIEW-AS TEXT
          SIZE 11.5 BY .91 AT ROW 16.52 COL 3
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "อุปกรณ์เสริม3:" VIEW-AS TEXT
          SIZE 11.5 BY .91 AT ROW 15.48 COL 3
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "เบี้ยรวม:" VIEW-AS TEXT
          SIZE 6.83 BY .91 AT ROW 5.95 COL 98.5
          BGCOLOR 19 FGCOLOR 6 FONT 1
     "Agent :" VIEW-AS TEXT
          SIZE 7.67 BY .91 AT ROW 3.86 COL 7.67
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "ผลการตรวจ :" VIEW-AS TEXT
          SIZE 12.5 BY .91 AT ROW 20.24 COL 3.5
          BGCOLOR 29 FGCOLOR 12 FONT 6
     "อุปกรณ์เสริม2:" VIEW-AS TEXT
          SIZE 11.5 BY .91 AT ROW 14.43 COL 3
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "ที่นั่ง :" VIEW-AS TEXT
          SIZE 5 BY .91 AT ROW 11.19 COL 49.67
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "    ข้อมูลอื่นๆ:" VIEW-AS TEXT
          SIZE 12.5 BY .91 AT ROW 25.19 COL 3.17
          BGCOLOR 29 FGCOLOR 12 FONT 6
     "สถานะกล่อง:" VIEW-AS TEXT
          SIZE 11.33 BY .91 AT ROW 19.19 COL 36.83
          BGCOLOR 29 FGCOLOR 12 FONT 6
     "ราคา4:" VIEW-AS TEXT
          SIZE 5.5 BY .91 AT ROW 16.48 COL 107.33
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "วันคุ้มครอง:" VIEW-AS TEXT
          SIZE 9.5 BY .91 AT ROW 12.29 COL 81.33
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "Policy No :" VIEW-AS TEXT
          SIZE 10.5 BY .91 AT ROW 2.43 COL 44.33
          BGCOLOR 19 FGCOLOR 6 FONT 6
     "Tmp contact :" VIEW-AS TEXT
          SIZE 10.83 BY .91 AT ROW 9.14 COL 3.33 WIDGET-ID 8
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "รุ่นรถ:" VIEW-AS TEXT
          SIZE 6 BY .91 AT ROW 11.24 COL 9
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "ราคา2:" VIEW-AS TEXT
          SIZE 5.5 BY .91 AT ROW 14.38 COL 107.33
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "รายละเอียด3:" VIEW-AS TEXT
          SIZE 10.67 BY .91 AT ROW 15.48 COL 56.33
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "เบอร์โทร:" VIEW-AS TEXT
          SIZE 8.17 BY .91 AT ROW 7 COL 74.5
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "รายละเอียด5:" VIEW-AS TEXT
          SIZE 10.67 BY .91 AT ROW 17.52 COL 56.33
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "วันที่ปิดเรื่อง:" VIEW-AS TEXT
          SIZE 11.67 BY .91 AT ROW 19.19 COL 93.83
          BGCOLOR 29 FGCOLOR 6 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1.17 ROW 1.05
         SIZE 133.67 BY 25.95
         BGCOLOR 18 FGCOLOR 1 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     RECT-462 AT ROW 2.19 COL 1.5
     RECT-465 AT ROW 3.52 COL 2
     RECT-466 AT ROW 18.86 COL 2.33
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
         TITLE              = "Update Data Inspection AYCAL"
         HEIGHT             = 26.05
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
ASSIGN 
       fi_confirm:READ-ONLY IN FRAME fr_main        = TRUE.

ASSIGN 
       fi_datesent:READ-ONLY IN FRAME fr_main        = TRUE.

ASSIGN 
       fi_inspdes:READ-ONLY IN FRAME fr_main        = TRUE.

ASSIGN 
       fi_status:READ-ONLY IN FRAME fr_main        = TRUE.

ASSIGN 
       fi_time:READ-ONLY IN FRAME fr_main        = TRUE.

ASSIGN 
       fi_trandat:READ-ONLY IN FRAME fr_main        = TRUE.

ASSIGN 
       fi_user:READ-ONLY IN FRAME fr_main        = TRUE.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Update Data Inspection AYCAL */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Update Data Inspection AYCAL */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
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
    MESSAGE "Do you want SAVE  !!!!"        
        VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO     /*-CANCEL */    
        TITLE "" UPDATE choice AS LOGICAL.
    CASE choice:         
        WHEN TRUE THEN /* Yes */ 
            DO: 
            Find  brstat.tlt Where  Recid(tlt)  =  nv_recidtlt.
            If  avail  brstat.tlt Then do:
                ASSIGN 
                    brstat.tlt.releas        = trim(fi_status)
                    /*brstat.tlt.subins        = TRIM(fi_producer) */       
                    brstat.tlt.recac         = TRIM(fi_agent)
                    brstat.tlt.nor_usr_ins   = trim(fi_custcode)                                /*เลขที่ Prospect       */  
                    brstat.tlt.lotno         = "CamCode:" + trim(fi_camp)  + " " +              /*รหัสแคมเปญ            */  
                                               "CamName:" + trim(fi_campnam)                    /*ชื่อแคมเปญ            */  
                    brstat.tlt.usrsent       = "ProCode:" + trim(fi_produc)    + " " +          /*รหัสผลิตภัณฑ์         */  
                                               "ProName:" + trim(fi_producnam) + " " +          /*ชื่อผลิตภัณฑ์         */  
                                               "PlanCod:" + trim(fi_pacg)      + " " +          /*รหัสย่อยผลิตภัณฑ์     */  
                                               "PlanNam:" + trim(fi_pacgnam)                    /*ชื่อรหัสย่อยผลิตภัณฑ์ */  
                    brstat.tlt.nor_noti_ins  = trim(fi_refno)                                   /*เลขที่ใบคำขอ          */  
                    brstat.tlt.ins_name      = trim(fi_nameth) + " " + TRIM(fi_surth)           /*ชื่อผู้เอาประกัน      */  
                    brstat.tlt.ins_addr5     = trim(fi_poltel)                                  /*เบอร์โทรศัพท์ผู้เอาประกัน */
                    brstat.tlt.imp           = trim(fi_cover)                                   /*ประเภทผู้เอาประกัน        */
                    brstat.tlt.nor_effdat    = DATE(fi_inspdate)                                /*วันทีนัดตรวจสภาพรถยนต์    */
                    brstat.tlt.old_eng       = trim(fi_instime)                                 /*เวลาที่นัดตรวจสภาพรถยนต์  */
                    brstat.tlt.ins_addr1     = trim(fi_contnam)                                 /*ชื่อผู้ที่ติดต่อ          */
                    brstat.tlt.ins_addr2     = "InspTel:" + trim(fi_telcon) + " " +             /*เบอร์โทรศัพท์ผู้ติดต่อ    */
                                               "InspLin:" + trim(fi_line) + " " +               /*Line ID                   */
                                               "InspMal:" + TRIM(fi_mail)                       /*email-ผู้ติดต่อ           */
                    brstat.tlt.ins_addr3     = trim(fi_poladdr1)                                /*ที่อยู่ในการตรวจสภาพรถยนต์*/
                    brstat.tlt.brand         = TRIM(fi_brand)                                   /*ยี่ห้อรถ                  */
                    brstat.tlt.model         = trim(fi_model)                                   /*รหัสรุ่นรถ                */
                    brstat.tlt.expotim       = trim(fi_class)                                   /*รหัสรถ (MotorCode)        */
                    brstat.tlt.sentcnt       = INT(fi_seat)                                     /*จำนวนที่นั่ง              */
                    brstat.tlt.rencnt        = deci(fi_cc)                                      /*ขนาด ซี ซี                */
                    brstat.tlt.cc_weight     = deci(fi_ton)                                     /*น้ำหนัก                   */
                    brstat.tlt.lince2        = trim(fi_province)                                /*จังหวัดที่จดทะเบียน       */
                    brstat.tlt.gentim        = trim(fi_year)                                    /*ปีที่จดทะเบียน            */
                    brstat.tlt.lince1        = trim(fi_lincen)                                  /*ทะเบียนรถ                 */
                    brstat.tlt.cha_no        = trim(fi_chssic)                                  /*หมายเลขตัวถัง             */
                    brstat.tlt.eng_no        = trim(fi_engno )                                  /*หมายเลขเครื่อง            */
                    brstat.tlt.gendat        = date(fi_comdat)                                  /*วันที่เริ่มคุ้มครอง       */
                    brstat.tlt.expodat       = date(fi_expdat)                                  /*วันที่สิ้นสุดคุ้มครอง     */
                    brstat.tlt.nor_coamt     = deci(fi_si)                                      /*ทุนประกันภัย              */
                    brstat.tlt.comp_coamt    = deci(fi_premtotal)                               /*ค่าเบี้ยประกันภัย         */
                    brstat.tlt.filler1       = "Acc1:" + trim(fi_accr1)       + " " +           /*รหัส อุปกรณ์1  */   
                                               "Acd1:" + trim(fi_accdet1) + " " +               /*รายละเอียด1    */    
                                               "Acp1:" + STRING(DECI(fi_accpric1))  + " " +     /*ราคาอุปกรณ์1   */    
                                               "Acc2:" + trim(fi_accr2)       + " " +           /*รหัส อุปกรณ์2  */    
                                               "Acd2:" + trim(fi_accdet2) + " " +               /*รายละเอียด2    */    
                                               "Acp2:" + STRING(DECI(fi_accpric2))  + " " +     /*ราคาอุปกรณ์2   */    
                                               "Acc3:" + trim(fi_accr3)       + " " +           /*รหัส อุปกรณ์3  */    
                                               "Acd3:" + trim(fi_accdet3) + " " +               /*รายละเอียด3    */    
                                               "Acp3:" + STRING(DECI(fi_accpric3))  + " " +     /*ราคาอุปกรณ์3   */    
                                               "Acc4:" + trim(fi_accr4)       + " " +           /*รหัส อุปกรณ์4  */    
                                               "Acd4:" + trim(fi_accdet4) + " " +               /*รายละเอียด 4   */    
                                               "Acp4:" + STRING(DECI(fi_accpric4))  + " " +     /*ราคาอุปกรณ์4   */    
                                               "Acc5:" + trim(fi_accr5)       + " " +           /*รหัส อุปกรณ์5  */    
                                               "Acd5:" + TRIM(fi_accdet5) + " " +               /*รายละเอียด 5   */    
                                               "Acp5:" + STRING(DECI(fi_accpric5))              /*ราคาอุปกรณ์5     */
                   brstat.tlt.rec_addr1      = TRIM(fi_custno)
                   brstat.tlt.rec_addr2      = TRIM(fi_tmpcon1)
                   brstat.tlt.rec_addr3      = TRIM(fi_tmpcon2)
                   brstat.tlt.nor_noti_tlt   = trim(fi_inspno)
                   brstat.tlt.safe1          = trim(fi_insresult)
                   brstat.tlt.safe2          = trim(fi_resultdel) + TRIM(fi_resultdel2) + TRIM(fi_resultdel3)
                   brstat.tlt.safe3          = trim(fi_inspacc)
                   brstat.tlt.filler2        = trim(fi_detailoth)
                   brstat.tlt.datesent       = fi_closedat.
                       
            END.                                                    
            Apply "Close" to this-procedure.
            Return no-apply.
            /* APPLY "entry" TO fi_branch.
            RETURN NO-APPLY. */
        END.
        WHEN FALSE THEN /* No */          
            DO:   
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


&Scoped-define SELF-NAME bu_upins
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_upins C-Win
ON CHOOSE OF bu_upins IN FRAME fr_main /* อัพเดทข้อมูล */
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
            nv_tmp      = "Inspect" + SUBSTR(nv_year,3,2) + ".nsf".

    /*--------- Server Real ----------*/
    nv_server = "Safety_NotesServer/Safety".
    nv_tmp   = "safety\uw\" + nv_tmp .
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
      chNotesView    = chNotesDatabase:GetView("chassis_no").
      /*chNavView    = chNotesView:CreateViewNav.*/
      /*chDocument   = chNotesView:GetDocumentByKey(brstat.tlt.cha_no).*/
      chNavView      = chNotesView:CreateViewNavFromCategory(brstat.tlt.cha_no).
      chViewEntry    = chNavView:GetLastDocument.
      chDocument     = chViewEntry:Document. 

      IF VALID-HANDLE(chDocument) = YES THEN DO:
          chitem       = chDocument:Getfirstitem("ConsiderDate").    /*วันที่ปิดเรื่อง*/
          IF chitem <> 0 THEN nv_date = chitem:TEXT.                 
          ELSE nv_date = "".                                         
                                                                     
          chitem       = chDocument:Getfirstitem("docno").           /*เลขตรวจสภาพ*/
          IF chitem <> 0 THEN nv_docno = chitem:TEXT.                
          ELSE nv_docno = "".                                        
                                                                     
          chitem       = chDocument:Getfirstitem("SurveyClose").     /* สเตตัสปิดเรื่อง */
          IF chitem <> 0 THEN nv_survey  = chitem:TEXT.              
          ELSE nv_survey = "".                                       
                                                                     
          chitem       = chDocument:Getfirstitem("SurveyResult").    /*ผลการตรวจ*/
          IF chitem <> 0 THEN  nv_detail = chitem:TEXT.              
          ELSE nv_detail = "".                                       
                                                                     
          IF nv_detail = "ติดปัญหา" THEN DO:                         
              chitem       = chDocument:Getfirstitem("DamageC").     /*ข้อมูลการติดปัญหา */
              IF chitem <> 0 THEN nv_damage    = chitem:TEXT.        
              ELSE nv_damage = "".                                   
          END.                                                       
          IF nv_detail = "มีความเสียหาย"  THEN DO:                   
              chitem       = chDocument:Getfirstitem("DamageList").  /* รายการความเสียหาย */
              IF chitem <> 0 THEN nv_damlist  = chitem:TEXT.
              ELSE nv_damlist = "".
              chitem       = chDocument:Getfirstitem("TotalExpensive").  /* ราคาความเสียหาย */
              IF chitem <> 0 THEN nv_totaldam  = chitem:TEXT.
              ELSE nv_totaldam = "".
             
              IF nv_damlist <> "" THEN DO:
                  ASSIGN n_list     = INT(nv_damlist)
                         nv_damlist = "จำนวนความเสียหาย " + nv_damlist + " รายการ " .
              END.
              IF nv_totaldam <> "" THEN ASSIGN nv_totaldam = "รวมความเสียหายทั้งสิ้น " + nv_totaldam + " บาท " .
             
              IF n_list > 0  THEN DO:
                ASSIGN  n_count = 1 .
                loop_damage:
                REPEAT:
                    IF n_count <= n_list THEN DO:
                        ASSIGN  n_dam    = "List"   + STRING(n_count) 
                                n_repair = "Repair" + STRING(n_count) .
                        
                        chitem       = chDocument:Getfirstitem(n_dam).
                        IF chitem <> 0 THEN  nv_damag  = chitem:TEXT. 
                        ELSE nv_damag = "".  
                        
                        chitem       = chDocument:Getfirstitem(n_repair).
                        IF chitem <> 0 THEN  nv_repair = chitem:TEXT. 
                        ELSE nv_repair = "".
                            
                        IF nv_damag <> "" THEN  
                            ASSIGN nv_damdetail = nv_damdetail + string(n_count) + "." + nv_damag + " " + nv_repair + " , " .
                            
                        n_count = n_count + 1.
                    END.
                    ELSE LEAVE loop_damage.
                END.
              END.
             
          END.
          /*-- ข้อมูลอื่น ๆ ---*/
          chitem       = chDocument:Getfirstitem("SurveyData").
          IF chitem <> 0 THEN  nv_surdata = chitem:TEXT. 
          ELSE nv_surdata = "".
          IF trim(nv_surdata) <> "" THEN  nv_surdata = nv_surdata.
          /*agentcode*/
          chitem       = chDocument:Getfirstitem("agentCode").      
          IF chitem <> 0 THEN n_agent = chitem:TEXT. 
          ELSE n_agent = "".
          IF TRIM(n_agent) <> "" THEN ASSIGN nv_surdata = nv_surdata + " โค้ดตัวแทน: " + n_agent.

          /*-- อุปกรณ์เสริม --*/  
          chitem       = chDocument:Getfirstitem("device1").
          IF chitem <> 0 THEN  nv_device = chitem:TEXT. 
          ELSE nv_device = "".

          IF nv_device <> "" THEN DO:
              chitem       = chDocument:Getfirstitem("pricesTotal").  /* ราคารวมอุปกรณ์เสริม */
              IF chitem <> 0 THEN  nv_acctotal = chitem:TEXT. 
              ELSE nv_acctotal = "".
              chitem       = chDocument:Getfirstitem("DType1").
              IF chitem <> 0 THEN  nv_acc1 = chitem:TEXT. 
              ELSE nv_acc1 = "".
              chitem       = chDocument:Getfirstitem("DType2").
              IF chitem <> 0 THEN  nv_acc2 = chitem:TEXT. 
              ELSE nv_acc2 = "".
              chitem       = chDocument:Getfirstitem("DType3").
              IF chitem <> 0 THEN  nv_acc3 = chitem:TEXT. 
              ELSE nv_acc3 = "".
              chitem       = chDocument:Getfirstitem("DType4").
              IF chitem <> 0 THEN  nv_acc4 = chitem:TEXT. 
              ELSE nv_acc4 = "".
              chitem       = chDocument:Getfirstitem("DType5").
              IF chitem <> 0 THEN  nv_acc5 = chitem:TEXT. 
              ELSE nv_acc5 = "".
              chitem       = chDocument:Getfirstitem("DType6").
              IF chitem <> 0 THEN  nv_acc6 = chitem:TEXT. 
              ELSE nv_acc6 = "".
              chitem       = chDocument:Getfirstitem("DType7").
              IF chitem <> 0 THEN  nv_acc7 = chitem:TEXT. 
              ELSE nv_acc7 = "".
              chitem       = chDocument:Getfirstitem("DType8").
              IF chitem <> 0 THEN  nv_acc8 = chitem:TEXT. 
              ELSE nv_acc8 = "".
              chitem       = chDocument:Getfirstitem("DType9").
              IF chitem <> 0 THEN  nv_acc9 = chitem:TEXT. 
              ELSE nv_acc9 = "".
              chitem       = chDocument:Getfirstitem("DType10").
              IF chitem <> 0 THEN  nv_acc10 = chitem:TEXT. 
              ELSE nv_acc10 = "".
              chitem       = chDocument:Getfirstitem("DType11").
              IF chitem <> 0 THEN  nv_acc11 = chitem:TEXT. 
              ELSE nv_acc11 = "".
              chitem       = chDocument:Getfirstitem("DType12").
              IF chitem <> 0 THEN  nv_acc12 = chitem:TEXT. 
              ELSE nv_acc12 = "".
              
              IF TRIM(nv_acc1)  <> "" THEN nv_device = nv_device + TRIM(nv_acc1).
              IF TRIM(nv_acc2)  <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc2).
              IF TRIM(nv_acc3)  <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc3).
              IF TRIM(nv_acc4)  <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc4).
              IF TRIM(nv_acc5)  <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc5).
              IF TRIM(nv_acc6)  <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc6).
              IF TRIM(nv_acc7)  <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc7).
              IF TRIM(nv_acc8)  <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc8).
              IF TRIM(nv_acc9)  <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc9).
              IF TRIM(nv_acc10) <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc10).
              IF TRIM(nv_acc11) <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc11).
              IF TRIM(nv_acc12) <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc12) .
              nv_acctotal = " ราคารวมอุปกรณ์เสริม " + nv_acctotal + " บาท " .
          END.

          IF nv_docno <> ""  THEN DO:
              IF nv_survey <> "" THEN DO:
                IF nv_detail = "ติดปัญหา" THEN DO:
                    ASSIGN  fi_inspno     = nv_docno
                            fi_status     = "YES"
                            fi_insresult  = nv_detail + " : " + nv_damage 
                            fi_resultdel  = ""
                            fi_resultdel2 = ""
                            fi_inspacc    = nv_device + nv_acctotal
                            fi_detailoth  = nv_surdata
                            fi_closedat   = DATE(nv_date).
                END.
                ELSE IF nv_detail = "มีความเสียหาย"  THEN DO:
                    ASSIGN  fi_inspno     = nv_docno
                            fi_status     = "YES"
                            fi_insresult  = nv_detail + " : " + nv_damlist + nv_totaldam 
                            fi_resultdel  = ""
                            fi_resultdel2 = ""
                            fi_resultdel3 = ""
                            fi_inspacc    = nv_device + nv_acctotal
                            fi_detailoth  = nv_surdata
                            fi_closedat   = DATE(nv_date).

                    IF nv_damdetail <> "" THEN DO:
                       IF INDEX(nv_damdetail,"21.") <> 0 THEN DO: 
                           ASSIGN fi_resultdel3 = TRIM(SUBSTR(nv_damdetail,R-INDEX(nv_damdetail,"21.")))
                                  nv_damdetail  = TRIM(SUBSTR(nv_damdetail,1,R-INDEX(nv_damdetail,"21.") - 2))
                                  fi_resultdel2 = TRIM(SUBSTR(nv_damdetail,R-INDEX(nv_damdetail,"11.")))
                                  fi_resultdel  = TRIM(SUBSTR(nv_damdetail,1,R-INDEX(nv_damdetail,"11.") - 2)).
                       END.
                       ELSE IF INDEX(nv_damdetail,"11.") <> 0 THEN DO:
                           ASSIGN fi_resultdel3 = ""
                                  fi_resultdel2 = TRIM(SUBSTR(nv_damdetail,R-INDEX(nv_damdetail,"11.")))
                                  fi_resultdel  = TRIM(SUBSTR(nv_damdetail,1,R-INDEX(nv_damdetail,"11.") - 2)).
                       END.
                       ELSE DO:
                           ASSIGN fi_resultdel3 = "" 
                                  fi_resultdel2 = ""
                                  fi_resultdel  = TRIM(nv_damdetail) .
                       END.
                    END.
                END.
                ELSE DO: 
                    ASSIGN  fi_inspno     = nv_docno
                            fi_status     = "YES"
                            fi_insresult  = nv_detail
                            fi_resultdel  = ""
                            fi_resultdel2 = ""
                            fi_resultdel3 = ""
                            fi_inspacc    = nv_device + nv_acctotal
                            fi_detailoth  = nv_surdata
                            fi_closedat   = DATE(nv_date).
                END.
              END.
              ELSE DO:
                  ASSIGN  fi_inspno     = nv_docno       
                          fi_status     = "NO"          
                          fi_insresult  = ""
                          fi_resultdel  = ""
                          fi_resultdel2 = ""
                          fi_resultdel3 = ""
                          fi_inspacc    = nv_device + nv_acctotal
                          fi_detailoth  = nv_surdata.
                          
              END.
          END.
          ELSE ASSIGN   fi_inspno      = "" 
                        fi_status      = "NO"
                        fi_insresult   = ""
                        fi_resultdel   = ""
                        fi_resultdel2  = ""
                        fi_resultdel3  = ""
                        fi_inspacc     = ""
                        fi_detailoth   = "" .

          RELEASE  OBJECT chitem          NO-ERROR.
          RELEASE  OBJECT chDocument      NO-ERROR.          
          RELEASE  OBJECT chNotesDataBase NO-ERROR.     
          RELEASE  OBJECT chNotesSession  NO-ERROR.
      END.
      
      DISP fi_inspno fi_status  fi_insresult fi_inspacc fi_resultdel fi_resultdel2 fi_resultdel3  fi_detailoth WITH FRAME fr_main.
      MESSAGE " Check Data Inspection Complete " VIEW-AS ALERT-BOX.          
      /*--- end : A60-0118----*/
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_accdet1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_accdet1 C-Win
ON LEAVE OF fi_accdet1 IN FRAME fr_main
DO:
    fi_accdet1 = INPUT fi_accdet1.
    DISP fi_accdet1 WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_accdet2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_accdet2 C-Win
ON LEAVE OF fi_accdet2 IN FRAME fr_main
DO:
    fi_accdet2 = INPUT fi_accdet2.
    DISP fi_accdet2 WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_accdet3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_accdet3 C-Win
ON LEAVE OF fi_accdet3 IN FRAME fr_main
DO:
    fi_accdet3 = INPUT fi_accdet3.
    DISP fi_accdet3 WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_accdet4
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_accdet4 C-Win
ON LEAVE OF fi_accdet4 IN FRAME fr_main
DO:
    fi_accdet4 = INPUT fi_accdet4.
    DISP fi_accdet4 WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_accdet5
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_accdet5 C-Win
ON LEAVE OF fi_accdet5 IN FRAME fr_main
DO:
    fi_accdet5 = INPUT fi_accdet5.
    DISP fi_accdet5 WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_accpric1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_accpric1 C-Win
ON LEAVE OF fi_accpric1 IN FRAME fr_main
DO:
    fi_accpric1 = INPUT fi_accpric1.
    DISP fi_accpric1 WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_accpric2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_accpric2 C-Win
ON LEAVE OF fi_accpric2 IN FRAME fr_main
DO:
    fi_accpric2 = INPUT fi_accpric2.
    DISP fi_accpric2 WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_accpric3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_accpric3 C-Win
ON LEAVE OF fi_accpric3 IN FRAME fr_main
DO:
    fi_accpric3 = INPUT fi_accpric3.
    DISP fi_accpric3 WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_accpric4
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_accpric4 C-Win
ON LEAVE OF fi_accpric4 IN FRAME fr_main
DO:
    fi_accpric4 = INPUT fi_accpric4.
    DISP fi_accpric4 WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_accpric5
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_accpric5 C-Win
ON LEAVE OF fi_accpric5 IN FRAME fr_main
DO:
    fi_accpric5 = INPUT fi_accpric5.
    DISP fi_accpric5 WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_accr1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_accr1 C-Win
ON LEAVE OF fi_accr1 IN FRAME fr_main
DO:
    fi_accr1 = INPUT fi_accr1.
    DISP fi_accr1 WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_accr2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_accr2 C-Win
ON LEAVE OF fi_accr2 IN FRAME fr_main
DO:
    fi_accr2 = INPUT fi_accr2.
    DISP fi_accr2 WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_accr3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_accr3 C-Win
ON LEAVE OF fi_accr3 IN FRAME fr_main
DO:
  fi_accr3 = INPUT fi_accr3.
    DISP fi_accr3 WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_accr4
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_accr4 C-Win
ON LEAVE OF fi_accr4 IN FRAME fr_main
DO:
    fi_accr4 = INPUT fi_accr4.
    DISP fi_accr4 WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_accr5
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_accr5 C-Win
ON LEAVE OF fi_accr5 IN FRAME fr_main
DO:
  fi_accr5 = INPUT fi_accr5.
    DISP fi_accr5 WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_agent
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_agent C-Win
ON LEAVE OF fi_agent IN FRAME fr_main
DO:
    fi_agent = INPUT fi_agent .
    DISP fi_agent WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_brand
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_brand C-Win
ON LEAVE OF fi_brand IN FRAME fr_main
DO:
    fi_brand = INPUT fi_brand.
    DISP fi_brand WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_camp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_camp C-Win
ON LEAVE OF fi_camp IN FRAME fr_main
DO:
    fi_camp = INPUT fi_camp .
    DISP fi_camp WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_campnam
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_campnam C-Win
ON LEAVE OF fi_campnam IN FRAME fr_main
DO:
    fi_campnam = INPUT fi_campnam .
    DISP fi_campnam WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_cc
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_cc C-Win
ON LEAVE OF fi_cc IN FRAME fr_main
DO:
    fi_cc = INPUT fi_cc.
    DISP fi_cc WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_chssic
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_chssic C-Win
ON LEAVE OF fi_chssic IN FRAME fr_main
DO:
    fi_chssic = INPUT fi_chssic.
    DISP fi_chssic WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_class
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_class C-Win
ON LEAVE OF fi_class IN FRAME fr_main
DO:
    fi_class = INPUT fi_class.
    DISP fi_class WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_closedat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_closedat C-Win
ON LEAVE OF fi_closedat IN FRAME fr_main
DO:
    fi_closedat = INPUT fi_closedat.
    DISP fi_closedat WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_comdat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_comdat C-Win
ON LEAVE OF fi_comdat IN FRAME fr_main
DO:
    fi_comdat = INPUT fi_comdat.
    DISP fi_comdat WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_contnam
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_contnam C-Win
ON LEAVE OF fi_contnam IN FRAME fr_main
DO:
    fi_contnam = INPUT fi_contnam .
    DISP fi_contnam WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_cover
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_cover C-Win
ON LEAVE OF fi_cover IN FRAME fr_main
DO:
    fi_cover = INPUT fi_cover .
    DISP fi_cover WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_custcode
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_custcode C-Win
ON LEAVE OF fi_custcode IN FRAME fr_main
DO:
    fi_custcode = INPUT fi_custcode .
    DISP fi_custcode WITH FRAME fr_main.
  
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


&Scoped-define SELF-NAME fi_detailoth
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_detailoth C-Win
ON LEAVE OF fi_detailoth IN FRAME fr_main
DO:
    fi_detailoth = INPUT fi_detailoth .
    DISP fi_detailoth WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_engno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_engno C-Win
ON LEAVE OF fi_engno IN FRAME fr_main
DO:
    fi_engno = INPUT fi_engno.
    DISP fi_engno WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_expdat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_expdat C-Win
ON LEAVE OF fi_expdat IN FRAME fr_main
DO:
    fi_expdat = INPUT fi_expdat.
    DISP fi_expdat WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_inspacc
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_inspacc C-Win
ON LEAVE OF fi_inspacc IN FRAME fr_main
DO:
    fi_inspacc = INPUT fi_inspacc .
    DISP fi_inspacc WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_inspdate
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_inspdate C-Win
ON LEAVE OF fi_inspdate IN FRAME fr_main
DO:
    fi_inspdate = INPUT fi_inspdate .
    DISP fi_inspdate WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_inspno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_inspno C-Win
ON LEAVE OF fi_inspno IN FRAME fr_main
DO:
    fi_inspno = INPUT fi_inspno .
    DISP fi_inspno WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_insresult
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_insresult C-Win
ON LEAVE OF fi_insresult IN FRAME fr_main
DO:
    fi_insresult = INPUT fi_insresult .
    DISP fi_insresult WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_instime
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_instime C-Win
ON LEAVE OF fi_instime IN FRAME fr_main
DO:
    fi_instime = INPUT fi_instime .
    DISP fi_instime WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_lincen
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_lincen C-Win
ON LEAVE OF fi_lincen IN FRAME fr_main
DO:
    fi_lincen = INPUT fi_lincen.
    DISP fi_lincen WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_line
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_line C-Win
ON LEAVE OF fi_line IN FRAME fr_main
DO:
    fi_line = INPUT fi_line .
    DISP fi_line WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_mail
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_mail C-Win
ON LEAVE OF fi_mail IN FRAME fr_main
DO:
    fi_mail = INPUT fi_mail .
    DISP fi_mail WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_model
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_model C-Win
ON LEAVE OF fi_model IN FRAME fr_main
DO:
    fi_model = INPUT fi_model.
    DISP fi_model WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_nameth
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_nameth C-Win
ON LEAVE OF fi_nameth IN FRAME fr_main
DO:
    fi_nameth = INPUT fi_nameth .
    DISP fi_nameth WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_pacg
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_pacg C-Win
ON LEAVE OF fi_pacg IN FRAME fr_main
DO:
    fi_pacg = INPUT fi_pacg .
    DISP fi_pacg WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_pacgnam
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_pacgnam C-Win
ON LEAVE OF fi_pacgnam IN FRAME fr_main
DO:
    fi_pacgnam = INPUT fi_pacgnam .
    DISP fi_pacgnam WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_poladdr1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_poladdr1 C-Win
ON LEAVE OF fi_poladdr1 IN FRAME fr_main
DO:
    fi_poladdr1 = INPUT fi_poladdr1 .
    DISP fi_poladdr1 WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_polno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_polno C-Win
ON LEAVE OF fi_polno IN FRAME fr_main
DO:
    fi_polno = INPUT fi_polno .
    DISP fi_polno WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_poltel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_poltel C-Win
ON LEAVE OF fi_poltel IN FRAME fr_main
DO:
    fi_poltel = INPUT fi_poltel .
    DISP fi_poltel WITH FRAME fr_main.
  
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


&Scoped-define SELF-NAME fi_produc
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_produc C-Win
ON LEAVE OF fi_produc IN FRAME fr_main
DO:
    fi_produc = INPUT fi_produc .
    DISP fi_produc WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_producnam
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_producnam C-Win
ON LEAVE OF fi_producnam IN FRAME fr_main
DO:
    fi_producnam = INPUT fi_producnam .
    DISP fi_producnam WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_province
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_province C-Win
ON LEAVE OF fi_province IN FRAME fr_main
DO:
    fi_province = INPUT fi_province.
    DISP fi_province WITH FRAME fr_main.
  
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


&Scoped-define SELF-NAME fi_resultdel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_resultdel C-Win
ON LEAVE OF fi_resultdel IN FRAME fr_main
DO:
    fi_resultdel = INPUT fi_resultdel .
    DISP fi_resultdel WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_resultdel2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_resultdel2 C-Win
ON LEAVE OF fi_resultdel2 IN FRAME fr_main
DO:
    fi_resultdel2 = INPUT fi_resultdel2 .
    DISP fi_resultdel2 WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_resultdel3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_resultdel3 C-Win
ON LEAVE OF fi_resultdel3 IN FRAME fr_main
DO:
    fi_resultdel3 = INPUT fi_resultdel3 .
    DISP fi_resultdel3 WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_seat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_seat C-Win
ON LEAVE OF fi_seat IN FRAME fr_main
DO:
    fi_seat = INPUT fi_seat.
    DISP fi_seat WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_si
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_si C-Win
ON LEAVE OF fi_si IN FRAME fr_main
DO:
    fi_si = INPUT fi_si.
    DISP fi_si WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_surth
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_surth C-Win
ON LEAVE OF fi_surth IN FRAME fr_main
DO:
    fi_surth = INPUT fi_surth .
    DISP fi_surth WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_telcon
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_telcon C-Win
ON LEAVE OF fi_telcon IN FRAME fr_main
DO:
    fi_telcon = INPUT fi_telcon .
    DISP fi_telcon WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_tmpcon1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_tmpcon1 C-Win
ON LEAVE OF fi_tmpcon1 IN FRAME fr_main
DO:
    fi_tmpcon1 = INPUT fi_tmpcon1 .
    DISP fi_tmpcon1 WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_tmpcon2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_tmpcon2 C-Win
ON LEAVE OF fi_tmpcon2 IN FRAME fr_main
DO:
    fi_tmpcon2 = INPUT fi_tmpcon2 .
    DISP fi_tmpcon2 WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_ton
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_ton C-Win
ON LEAVE OF fi_ton IN FRAME fr_main
DO:
    fi_ton = INPUT fi_ton.
    DISP fi_ton WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_year
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_year C-Win
ON LEAVE OF fi_year IN FRAME fr_main
DO:
    fi_year = INPUT fi_year.
    DISP fi_year WITH FRAME fr_main.
  
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
  
  gv_prgid = "wgwqayins".
  gv_prog  = "Query & Update Inspection (AYCAL) ".
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

      RUN proc_assignfi.
      RUN proc_assignfi2.
     
      DISP    fi_polno     fi_trandat   fi_time      fi_user      fi_agent     /*fi_producer  */
         fi_refno     fi_custcode  fi_campnam   fi_camp      fi_pacg      fi_pacgnam   
         fi_producnam fi_produc    fi_surth     fi_nameth    fi_poltel    fi_cover     
         fi_inspdate  fi_instime   fi_contnam   fi_mail      fi_line      fi_telcon    
         fi_poladdr1  fi_brand     fi_model     fi_class     fi_seat      fi_cc        
         fi_ton       fi_province  fi_year      fi_lincen    fi_chssic    fi_engno     
         fi_comdat    fi_expdat    fi_si        fi_premtotal fi_accpric5  fi_accdet5   
         fi_accr5     fi_accpric4  fi_accdet4   fi_accr4     fi_accpric3  fi_accdet3
         fi_accr3     fi_accpric2  fi_accdet2   fi_accr2     fi_accpric1  fi_accdet1 
         fi_accr1     fi_inspno    fi_insresult fi_status    fi_inspdes    fi_inspacc
         fi_confirm   fi_closedat  fi_datesent  fi_resultdel fi_resultdel2 fi_resultdel3
         fi_detailoth fi_custno    fi_tmpcon1      fi_tmpcon2
         WITH FRAME fr_main. 
                                                 
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
  DISPLAY fi_camp fi_campnam fi_produc fi_producnam fi_pacg fi_pacgnam fi_nameth 
          fi_surth fi_instime fi_inspdate fi_telcon fi_poltel fi_mail fi_line 
          fi_poladdr1 fi_contnam fi_cover fi_refno fi_custcode fi_polno fi_agent 
          fi_trandat fi_user fi_time fi_brand fi_model fi_lincen fi_province 
          fi_chssic fi_engno fi_year fi_seat fi_cc fi_ton fi_class fi_si 
          fi_premtotal fi_comdat fi_expdat fi_accr1 fi_accdet1 fi_accpric1 
          fi_accr2 fi_accdet2 fi_accpric2 fi_accr3 fi_accdet3 fi_accpric3 
          fi_accr4 fi_accdet4 fi_accpric4 fi_accr5 fi_accdet5 fi_accpric5 
          fi_insresult fi_inspno fi_status fi_inspdes fi_resultdel fi_detailoth 
          fi_closedat fi_confirm fi_datesent fi_resultdel2 fi_inspacc 
          fi_resultdel3 fi_custno fi_tmpcon1 fi_tmpcon2 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE bu_save bu_exit fi_camp fi_campnam fi_produc fi_producnam fi_pacg 
         fi_pacgnam fi_nameth fi_surth fi_instime fi_inspdate fi_telcon 
         fi_poltel fi_mail fi_line fi_poladdr1 fi_contnam fi_cover fi_refno 
         fi_custcode fi_polno fi_agent fi_trandat fi_user fi_time fi_brand 
         fi_model fi_lincen fi_province fi_chssic fi_engno fi_year fi_seat 
         fi_cc fi_ton fi_class fi_si fi_premtotal fi_comdat fi_expdat fi_accr1 
         fi_accdet1 fi_accpric1 fi_accr2 fi_accdet2 fi_accpric2 fi_accr3 
         fi_accdet3 fi_accpric3 fi_accr4 fi_accdet4 fi_accpric4 fi_accr5 
         fi_accdet5 fi_accpric5 fi_insresult fi_inspno fi_status fi_inspdes 
         bu_upins fi_resultdel fi_detailoth fi_closedat fi_confirm fi_datesent 
         fi_resultdel2 fi_inspacc fi_resultdel3 fi_custno fi_tmpcon1 fi_tmpcon2 
         RECT-462 RECT-465 RECT-466 
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
    DEF VAR n_leng AS INT INIT 0.
    DEF VAR n_char AS CHAR FORMAT "x(250)" INIT "" .
    ASSIGN 
     fi_polno     = brstat.tlt.policy
     fi_trandat   = brstat.tlt.trndat
     fi_time      = brstat.tlt.trntim
     fi_user      = brstat.tlt.usrid
     fi_agent     = brstat.tlt.recac
     /*fi_producer  = brstat.tlt.subins*/
     fi_refno     = brstat.tlt.nor_noti_ins
     fi_custcode  = brstat.tlt.nor_usr_ins
     fi_campnam   = trim(substr(brstat.tlt.lotno,R-INDEX(tlt.lotno,"CamName:") + 8 ))     /*ชื่อแคมเปญ*/
     n_char       = trim(SUBSTR(brstat.tlt.lotno,1,R-INDEX(tlt.lotno,"CamName:") - 2 ))
     fi_camp      = trim(substr(n_char,R-INDEX(n_char,"CamCode:") + 8))                   /*รหัสแคมเปญ*/
     fi_pacgnam   = TRIM(SUBSTR(brstat.tlt.usrsent,R-INDEX(brstat.tlt.usrsent,"PlanNam:") + 8))   /*รหัสแพคเกจ    */ 
     n_char       = TRIM(SUBSTR(brstat.tlt.usrsent,1,R-INDEX(tlt.usrsent,"PlanNam:") - 2))
     fi_pacg      = trim(substr(n_char,R-INDEX(n_char,"PlanCod:") + 8))    /*ชื่อแพคเกจ    */ 
     n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"PlanCod:") - 2))
     fi_producnam = trim(substr(n_char,R-INDEX(n_char,"proname:") + 8))    /*ชื่อผลิตภัณฑ์ */ 
     n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"proname:") - 2))
     fi_produc    = trim(substr(n_char,R-INDEX(n_char,"procode:") + 8))     /*รหัสผลิตภัณฑ์ */ 
     fi_surth     = TRIM(SUBSTR(brstat.tlt.ins_name,R-INDEX(tlt.ins_name," ")))
     n_leng       = LENGTH(fi_surth) + 1 
     fi_nameth    = TRIM(SUBSTR(brstat.tlt.ins_name,1,LENGTH(tlt.ins_name) - n_leng)) 
     fi_poltel    = brstat.tlt.ins_addr5   
     fi_cover     = brstat.tlt.imp         
     fi_inspdate  = brstat.tlt.nor_effdat  
     fi_instime   = brstat.tlt.old_eng     
     fi_contnam   = brstat.tlt.ins_addr1  
     fi_mail      = trim(SUBSTR(brstat.tlt.ins_addr2,R-INDEX(brstat.tlt.ins_addr2,"Inspmal:") + 8 ))
     n_char       = TRIM(SUBSTR(brstat.tlt.ins_addr2,1,R-INDEX(brstat.tlt.ins_addr2,"Inspmal:") - 2 ))
     fi_line      = TRIM(SUBSTR(n_char,R-INDEX(n_char,"insplin:") + 8 ))
     fi_telcon    = TRIM(SUBSTR(n_char,9,R-INDEX(n_char,"insplin:") - 9 )) 
     fi_poladdr1  = trim(brstat.tlt.ins_addr3) 
     fi_brand     = trim(brstat.tlt.brand)      
     fi_model     = trim(brstat.tlt.model)     
     fi_class     = trim(brstat.tlt.expotim)   
     fi_seat      = INT(brstat.tlt.sentcnt)    
     fi_cc        = deci(brstat.tlt.rencnt)     
     fi_ton       = deci(brstat.tlt.cc_weight) 
     fi_province  = trim(brstat.tlt.lince2)    
     fi_year      = trim(brstat.tlt.gentim)    
     fi_lincen    = trim(brstat.tlt.lince1)    
     fi_chssic    = trim(brstat.tlt.cha_no)     
     fi_engno     = trim(brstat.tlt.eng_no)    
     fi_comdat    = brstat.tlt.gendat     
     fi_expdat    = brstat.tlt.expodat   
     fi_si        = deci(brstat.tlt.nor_coamt)  
     fi_premtotal = deci(brstat.tlt.comp_coamt) .

END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assignfi2 C-Win 
PROCEDURE proc_assignfi2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO:
    DEF VAR n_char       AS LONGCHAR  INIT "" .
    DEF VAR nv_damdetail AS LONGCHAR  INIT "".
    ASSIGN 
         /*-- อุปกรณ์ตกแต่ง ---*/
     fi_accpric5  = INT(substr(brstat.tlt.filler1,R-INDEX(brstat.tlt.filler1,"Acp5:") + 5))
     n_char        = TRIM(SUBSTR(brstat.tlt.filler1,1,R-INDEX(brstat.tlt.filler1,"Acp5:") - 2 ))
     fi_accdet5    = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Acd5:") + 5 ))
     n_char        = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acd5:") - 2))
     fi_accr5      = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Acc5:") + 5 ))
     n_char        = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acc5:") - 2 ))
     fi_accpric4   = INT(SUBSTR(n_char,R-INDEX(n_char,"Acp4:") + 5 ))
     n_char        = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acp4:") - 2 ))
     fi_accdet4    = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Acd4:") + 5 ))
     n_char        = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acd4:") - 2 ))
     fi_accr4      = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Acc4:") + 5 ))
     n_char        = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acc4:") - 2 ))
     fi_accpric3   = INT(SUBSTR(n_char,R-INDEX(n_char,"Acp3:") + 5 )) 
     n_char        = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acp3:") - 2 ))
     fi_accdet3    = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Acd3:") + 5 )) 
     n_char        = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acd3:") - 2 )) 
     fi_accr3      = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Acc3:") + 5 )) 
     n_char        = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acc3:") - 2 ))
     fi_accpric2   = INT(SUBSTR(n_char,R-INDEX(n_char,"Acp2:") + 5 )) 
     n_char        = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acp2:") - 2 ))
     fi_accdet2    = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Acd2:") + 5 )) 
     n_char        = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acd2:") - 2 ))
     fi_accr2      = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Acc2:") + 5 )) 
     n_char        = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acc2:") - 2 ))
     fi_accpric1   = INT(SUBSTR(n_char,R-INDEX(n_char,"Acp1:") + 5 )) 
     n_char        = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acp1:") - 2 ))  
     fi_accdet1    = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Acd1:") + 5 )) 
     n_char        = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acd1:") - 2 ))
     fi_accr1      = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Acc1:") + 5 ))
     fi_inspno     = trim(brstat.tlt.nor_noti_tlt)
     fi_insresult  = TRIM(brstat.tlt.safe1)
     fi_custno     = TRIM(brstat.tlt.rec_addr1)
     fi_tmpcon1    = TRIM(brstat.tlt.rec_addr2)
     fi_tmpcon2    = TRIM(brstat.tlt.rec_addr3)
     fi_status     = brstat.tlt.releas 
     fi_inspdes    = IF brstat.tlt.releas = "YES" THEN "ปิดเรื่อง" ELSE "ดำเนินการ" 
     fi_inspacc    = trim(brstat.tlt.safe3)
     fi_detailoth  = trim(brstat.tlt.filler2)
     fi_confirm    = brstat.tlt.stat
     fi_closedat   = brstat.tlt.datesent
     fi_datesent   = brstat.tlt.entdat 
     nv_damdetail  = brstat.tlt.safe2 .

     IF nv_damdetail <> "" THEN DO:
        IF INDEX(nv_damdetail,"21.") <> 0 THEN DO: 
            ASSIGN fi_resultdel3 = TRIM(SUBSTR(nv_damdetail,R-INDEX(nv_damdetail,"21.")))
                   nv_damdetail  = TRIM(SUBSTR(nv_damdetail,1,R-INDEX(nv_damdetail,"21.") - 2))
                   fi_resultdel2 = TRIM(SUBSTR(nv_damdetail,R-INDEX(nv_damdetail,"11.")))
                   fi_resultdel  = TRIM(SUBSTR(nv_damdetail,1,R-INDEX(nv_damdetail,"11.") - 2)).
        END.
        ELSE IF INDEX(nv_damdetail,"11.") <> 0 THEN DO:
            ASSIGN fi_resultdel3 = ""
                   fi_resultdel2 = TRIM(SUBSTR(nv_damdetail,R-INDEX(nv_damdetail,"11.")))
                   fi_resultdel  = TRIM(SUBSTR(nv_damdetail,1,R-INDEX(nv_damdetail,"11.") - 2)).
        END.
        ELSE DO:
            ASSIGN fi_resultdel3 = "" 
                   fi_resultdel2 = ""
                   fi_resultdel  = TRIM(nv_damdetail) .
        END.
     END.
     ELSE  ASSIGN fi_resultdel3 = "" 
                  fi_resultdel2 = "" 
                  fi_resultdel  = "".


END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

