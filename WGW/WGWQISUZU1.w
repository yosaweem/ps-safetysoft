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
  wuwqisuzu1.w :  Quey & Update data ISUZU
  Create  by  :  Ranu I. A64-0426 date : 17/12/2021 
 +++++++++++++++++++++++++++++++++++++++++++++++*/
Def  Input  parameter  nv_recidtlt  as  recid  .
Def  var nv_index  as int  init 0.
DEF  VAR nv_chaidrep AS CHAR .
DEF VAR n_length  AS INT INIT 0 .
DEF VAR n_id1   AS char format "x(15)"  init "" . 
DEF VAR n_id2   AS char format "x(15)"  init "" . 
DEF VAR n_br    AS char format "x(15)"  init "" . 
DEF VAR n_char  AS CHAR FORMAT "x(100)" init "" .
DEF VAR n_comdat    AS CHAR.
DEF VAR n_expdat    AS CHAR.
DEF VAR n_comdat72  AS CHAR.
DEF VAR n_expdat72  AS CHAR.
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

DEF VAR nv_ispstatus AS CHAR.
DEF VAR chSession       AS COM-HANDLE.
DEF VAR chWorkSpace     AS COM-HANDLE.
DEF VAR chName          AS COM-HANDLE.
DEF VAR chDatabase      AS COM-HANDLE.
DEF VAR chView          AS COM-HANDLE.
DEF VAR chViewNavigator AS COM-HANDLE.
DEF VAR chUIDocument    AS COM-HANDLE.
DEF VAR NotesServer  AS CHAR.
DEF VAR NotesApp     AS CHAR.
DEF VAR NotesView    AS CHAR.
DEF VAR nv_chknotes  AS CHAR.
DEF VAR nv_chkdoc    AS LOG.
DEF VAR nv_year      AS CHAR.
DEF VAR nv_msgbox    AS CHAR.   
DEF VAR nv_name      AS CHAR.
DEF VAR nv_datim     AS CHAR.
DEF VAR nv_branch    AS CHAR.
DEF VAR nv_brname    AS CHAR.
DEF VAR nv_pattern   AS CHAR.
DEF VAR nv_count     AS INT.
DEF VAR nv_text1     AS CHAR.
DEF VAR nv_text2     AS CHAR.
DEF VAR nv_chktext   AS INT.
DEF VAR nv_model     AS CHAR.
DEF VAR nv_modelcode AS CHAR.
DEF VAR nv_makdes    AS CHAR.
DEF VAR nv_licence1  AS CHAR.
DEF VAR nv_licence2  AS CHAR.
/**/
DEF VAR nv_cha_no  AS CHAR.
DEF VAR nv_doc_num AS INT.
DEF VAR nv_licen1  AS CHAR.
DEF VAR nv_licen2  AS CHAR.
DEF VAR nv_key1    AS CHAR.
DEF VAR nv_key2    AS CHAR.
DEF VAR nv_surcl   AS CHAR.
DEF VAR nv_docno   AS CHAR.

DEF VAR nv_brdesc AS CHAR FORMAT "x(50)" INIT "" .
DEF VAR nv_brcode AS CHAR FORMAT "x(3)" INIT "" .
DEF VAR nv_comco AS CHAR FORMAT "x(10)" INIT "" .
DEF VAR nv_producer AS CHAR FORMAT "x(10)" INIT "" .
DEF VAR nv_agent AS CHAR FORMAT "x(10)" INIT "" .
DEF VAR nv_char AS CHAR FORMAT "x(225)" INIT "" .
DEF VAR nv_length AS INT INIT 0.
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
DEF VAR nv_date          AS CHAR FORMAT "x(15)" .
DEF VAR nv_damdetail     AS LONGCHAR .
DEF VAR nv_sumsi         AS DECI INIT 0 .
DEF VAR n_day AS INT INIT 0.
DEF VAR nv_insi AS DECI INIT 0.
DEF VAR nv_provin AS CHAR FORMAT "x(10)" .
DEF VAR nv_key3 AS CHAR FORMAT "x(35)" .
DEF VAR nv_susupect AS CHAR FORMAT "x(200)" .

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS rs_status fi_policy fi_covcod2 fi_polstatus ~
fi_polsystem fi_compol fi_producer fi_agent fi_branch fi_accno fi_comtotal ~
fi_ins_off fi_brand fi_model fi_year fi_ton fi_eng_no fi_cha_no fi_licence ~
fi_covcod fi_comdat fi_expdat fi_sumsi fi_gross_amt fi_compprm fi_sckno ~
fi_prem1 fi_garage fi_title fi_firstname fi_lastname fi_icno fi_addr1 ~
fi_addr2 fi_addr3 fi_addr4 fi_benname fi_remark1 fi_remark2 bu_save bu_exit ~
fi_class fi_camp fi_vehuse fi_dealer fi_post fi_totalprm fi_bdate ~
fi_expbdat fi_acc1 fi_acc2 fi_delcode fi_vatcode fi_showroom fi_suspect ~
fi_class72 RECT-335 RECT-381 RECT-382 RECT-383 RECT-385 RECT-386 
&Scoped-Define DISPLAYED-OBJECTS rs_status fi_policy fi_covcod2 fi_type ~
fi_polstatus fi_paydate fi_polsystem fi_compol fi_producer fi_agent ~
fi_branch fi_accno fi_comtotal fi_ins_off fi_brand fi_model fi_year fi_ton ~
fi_eng_no fi_cha_no fi_licence fi_covcod fi_comdat fi_expdat fi_sumsi ~
fi_gross_amt fi_compprm fi_sckno fi_prem1 fi_garage fi_title fi_firstname ~
fi_lastname fi_icno fi_addr1 fi_addr2 fi_addr3 fi_addr4 fi_benname ~
fi_remark1 fi_remark2 fi_ldate fi_ltime fi_userid fi_trndat fi_class ~
fi_camp fi_vehuse fi_trndat1 fi_dealer fi_post fi_totalprm fi_bdate ~
fi_expbdat fi_acc1 fi_acc2 fi_delcode fi_vatcode fi_showroom fi_suspect ~
fi_class72 

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
     SIZE 8 BY 1
     FONT 6.

DEFINE BUTTON bu_save 
     LABEL "Save" 
     SIZE 8 BY 1
     FONT 6.

DEFINE VARIABLE fi_acc1 AS CHARACTER FORMAT "X(85)":U 
     VIEW-AS FILL-IN 
     SIZE 89 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_acc2 AS CHARACTER FORMAT "X(85)":U 
     VIEW-AS FILL-IN 
     SIZE 89 BY .86
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_accno AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 14.67 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_addr1 AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 58.33 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_addr2 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 30.33 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_addr3 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 26.83 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_addr4 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 20.83 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_agent AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 14.17 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_bdate AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 13.83 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_benname AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 53.5 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_branch AS CHARACTER FORMAT "X(4)":U 
     VIEW-AS FILL-IN 
     SIZE 5.17 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_brand AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 17.5 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_camp AS CHARACTER FORMAT "X(45)":U 
     VIEW-AS FILL-IN 
     SIZE 13.67 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_cha_no AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 28.67 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_class AS CHARACTER FORMAT "X(5)":U 
     VIEW-AS FILL-IN 
     SIZE 8.33 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_class72 AS CHARACTER FORMAT "X(5)":U 
     VIEW-AS FILL-IN 
     SIZE 8.33 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_comdat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 15.17 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_compol AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 20 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_compprm AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 13 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_comtotal AS DECIMAL FORMAT "->>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 15.33 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_covcod AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 9.5 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_covcod2 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 30.5 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_dealer AS CHARACTER FORMAT "X(60)":U 
     VIEW-AS FILL-IN 
     SIZE 28 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_delcode AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_eng_no AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 22 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_expbdat AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_expdat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 15.33 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_firstname AS CHARACTER FORMAT "X(75)":U 
     VIEW-AS FILL-IN 
     SIZE 30.67 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_garage AS CHARACTER FORMAT "X(30)":U INITIAL ? 
     VIEW-AS FILL-IN 
     SIZE 7.17 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_gross_amt AS DECIMAL FORMAT "->>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 19.17 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_icno AS CHARACTER FORMAT "X(13)":U 
     VIEW-AS FILL-IN 
     SIZE 20.33 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_ins_off AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 22.33 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_lastname AS CHARACTER FORMAT "X(45)":U 
     VIEW-AS FILL-IN 
     SIZE 31 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_ldate AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 14.33 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_licence AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 15.67 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_ltime AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 12.17 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_model AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 36.5 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_paydate AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 16.5 BY 1
     BGCOLOR 19 FGCOLOR 6 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_policy AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 21 BY 1
     BGCOLOR 15 FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE fi_polstatus AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 17.33 BY 1
     BGCOLOR 19 FGCOLOR 6 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_polsystem AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 20 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_post AS CHARACTER FORMAT "X(5)":U 
     VIEW-AS FILL-IN 
     SIZE 17.17 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_prem1 AS DECIMAL FORMAT "->>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 15.33 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_producer AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_remark1 AS CHARACTER FORMAT "X(85)":U 
     VIEW-AS FILL-IN 
     SIZE 89 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_remark2 AS CHARACTER FORMAT "X(85)":U 
     VIEW-AS FILL-IN 
     SIZE 89 BY .86
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_sckno AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 19 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_showroom AS CHARACTER FORMAT "X(60)":U 
     VIEW-AS FILL-IN 
     SIZE 23 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_sumsi AS INTEGER FORMAT ">>>,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 19.33 BY .95
     BGCOLOR 15 FGCOLOR 1 FONT 1 NO-UNDO.

DEFINE VARIABLE fi_suspect AS CHARACTER FORMAT "X(200)":U 
     VIEW-AS FILL-IN 
     SIZE 77 BY .95
     BGCOLOR 15 FGCOLOR 6  NO-UNDO.

DEFINE VARIABLE fi_title AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 14.17 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_ton AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 9.17 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_totalprm AS DECIMAL FORMAT "->>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 18.5 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_trndat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 14.33 BY 1
     BGCOLOR 21 FGCOLOR 4 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_trndat1 AS DATE FORMAT "99/99/9999":U 
     LABEL "Trndat" 
     VIEW-AS FILL-IN 
     SIZE 14.17 BY 1
     BGCOLOR 3 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_type AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 15.33 BY 1
     BGCOLOR 1 FGCOLOR 7 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_userid AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 11 BY 1
     BGCOLOR 7 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_vatcode AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 14.17 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_vehuse AS CHARACTER FORMAT "X(30)":U INITIAL "0" 
     VIEW-AS FILL-IN 
     SIZE 24 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_year AS CHARACTER FORMAT "X(4)":U INITIAL "0" 
     VIEW-AS FILL-IN 
     SIZE 6.83 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE rs_status AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "NO", 1,
"YES", 2
     SIZE 16.17 BY .95
     BGCOLOR 19 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-335
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132.67 BY 28
     BGCOLOR 32 FGCOLOR 2 .

DEFINE RECTANGLE RECT-381
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 10.5 BY 1.52
     BGCOLOR 3 FGCOLOR 2 .

DEFINE RECTANGLE RECT-382
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 10.5 BY 1.52
     BGCOLOR 6 FGCOLOR 0 .

DEFINE RECTANGLE RECT-383
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 131 BY 3.81
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-385
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 131 BY 6.67
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-386
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 131 BY 11.67
     BGCOLOR 19 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     rs_status AT ROW 27.62 COL 86.33 NO-LABEL WIDGET-ID 84
     fi_policy AT ROW 1.43 COL 38.33 COLON-ALIGNED NO-LABEL
     fi_covcod2 AT ROW 9.81 COL 92.83 COLON-ALIGNED NO-LABEL
     fi_type AT ROW 1.33 COL 3.17 NO-LABEL
     fi_polstatus AT ROW 27.57 COL 47.17 COLON-ALIGNED NO-LABEL
     fi_paydate AT ROW 27.57 COL 15.67 COLON-ALIGNED NO-LABEL
     fi_polsystem AT ROW 1.43 COL 75.67 COLON-ALIGNED NO-LABEL
     fi_compol AT ROW 1.43 COL 109.33 COLON-ALIGNED NO-LABEL
     fi_producer AT ROW 3.24 COL 77 COLON-ALIGNED NO-LABEL
     fi_agent AT ROW 3.24 COL 106.33 COLON-ALIGNED NO-LABEL
     fi_branch AT ROW 4.33 COL 39.83 COLON-ALIGNED NO-LABEL
     fi_accno AT ROW 4.33 COL 61 COLON-ALIGNED NO-LABEL
     fi_comtotal AT ROW 11.81 COL 77.67 COLON-ALIGNED NO-LABEL
     fi_ins_off AT ROW 5.38 COL 17.83 COLON-ALIGNED NO-LABEL
     fi_brand AT ROW 7.86 COL 19 COLON-ALIGNED NO-LABEL
     fi_model AT ROW 7.81 COL 46 COLON-ALIGNED NO-LABEL
     fi_year AT ROW 7.81 COL 92.83 COLON-ALIGNED NO-LABEL
     fi_ton AT ROW 7.76 COL 112.83 COLON-ALIGNED NO-LABEL
     fi_eng_no AT ROW 8.86 COL 19 COLON-ALIGNED NO-LABEL
     fi_cha_no AT ROW 8.81 COL 53.83 COLON-ALIGNED NO-LABEL
     fi_licence AT ROW 8.81 COL 92.83 COLON-ALIGNED NO-LABEL
     fi_covcod AT ROW 9.86 COL 58.83 COLON-ALIGNED NO-LABEL
     fi_comdat AT ROW 10.86 COL 19 COLON-ALIGNED NO-LABEL
     fi_expdat AT ROW 10.86 COL 48.83 COLON-ALIGNED NO-LABEL
     fi_sumsi AT ROW 10.81 COL 77.67 COLON-ALIGNED NO-LABEL
     fi_gross_amt AT ROW 11.86 COL 19 COLON-ALIGNED NO-LABEL
     fi_compprm AT ROW 11.86 COL 51 COLON-ALIGNED NO-LABEL
     fi_sckno AT ROW 12.91 COL 18.83 COLON-ALIGNED NO-LABEL
     fi_prem1 AT ROW 10.81 COL 110.67 COLON-ALIGNED NO-LABEL
     fi_garage AT ROW 12.86 COL 110.83 COLON-ALIGNED NO-LABEL
     fi_title AT ROW 15.52 COL 17.83 COLON-ALIGNED NO-LABEL
     fi_firstname AT ROW 15.48 COL 38 COLON-ALIGNED NO-LABEL
     fi_lastname AT ROW 15.43 COL 79.17 COLON-ALIGNED NO-LABEL
     fi_icno AT ROW 16.57 COL 17.67 COLON-ALIGNED NO-LABEL
     fi_addr1 AT ROW 17.57 COL 17.67 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     fi_addr2 AT ROW 17.67 COL 91.17 COLON-ALIGNED NO-LABEL
     fi_addr3 AT ROW 18.57 COL 17.5 COLON-ALIGNED NO-LABEL
     fi_addr4 AT ROW 18.57 COL 55.33 COLON-ALIGNED NO-LABEL
     fi_benname AT ROW 19.57 COL 17.67 COLON-ALIGNED NO-LABEL
     fi_remark1 AT ROW 22.52 COL 19.67 NO-LABEL
     fi_remark2 AT ROW 23.48 COL 17.67 COLON-ALIGNED NO-LABEL
     bu_save AT ROW 27.71 COL 112.33
     bu_exit AT ROW 27.67 COL 123
     fi_ldate AT ROW 3.24 COL 18.17 COLON-ALIGNED NO-LABEL
     fi_ltime AT ROW 3.24 COL 46.33 COLON-ALIGNED NO-LABEL
     fi_userid AT ROW 25.1 COL 115.67 COLON-ALIGNED NO-LABEL
     fi_trndat AT ROW 4.29 COL 18.17 COLON-ALIGNED NO-LABEL
     fi_class AT ROW 12.91 COL 48.17 COLON-ALIGNED NO-LABEL
     fi_camp AT ROW 12.86 COL 87.17 COLON-ALIGNED NO-LABEL
     fi_vehuse AT ROW 9.86 COL 19 COLON-ALIGNED NO-LABEL
     fi_trndat1 AT ROW 23.91 COL 115.17 COLON-ALIGNED
     fi_dealer AT ROW 5.38 COL 52.83 COLON-ALIGNED NO-LABEL
     fi_post AT ROW 18.62 COL 91.17 COLON-ALIGNED NO-LABEL WIDGET-ID 6
     fi_totalprm AT ROW 11.81 COL 110.67 COLON-ALIGNED NO-LABEL WIDGET-ID 10
     fi_bdate AT ROW 16.52 COL 46.83 COLON-ALIGNED NO-LABEL WIDGET-ID 14
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1.67 ROW 1.1
         SIZE 133 BY 28.24
         BGCOLOR 3 FGCOLOR 1 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     fi_expbdat AT ROW 16.52 COL 75.5 COLON-ALIGNED NO-LABEL WIDGET-ID 18
     fi_acc1 AT ROW 20.62 COL 19.67 NO-LABEL WIDGET-ID 56
     fi_acc2 AT ROW 21.57 COL 17.67 COLON-ALIGNED NO-LABEL WIDGET-ID 58
     fi_delcode AT ROW 4.29 COL 90 COLON-ALIGNED NO-LABEL WIDGET-ID 64
     fi_vatcode AT ROW 4.29 COL 115.5 COLON-ALIGNED NO-LABEL WIDGET-ID 62
     fi_showroom AT ROW 5.38 COL 90 COLON-ALIGNED NO-LABEL WIDGET-ID 70
     fi_suspect AT ROW 24.38 COL 17.67 COLON-ALIGNED NO-LABEL WIDGET-ID 74
     fi_class72 AT ROW 12.91 COL 66.5 COLON-ALIGNED NO-LABEL WIDGET-ID 78
     " ทุนประกัน :":35 VIEW-AS TEXT
          SIZE 10.83 BY .95 AT ROW 10.81 COL 67.83
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " ทะเบียน :":30 VIEW-AS TEXT
          SIZE 8.67 BY .95 AT ROW 8.81 COL 85.33
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "ที่อยู่3 :":35 VIEW-AS TEXT
          SIZE 6.67 BY .95 AT ROW 18.57 COL 12.33
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " ความคุ้มครอง :":30 VIEW-AS TEXT
          SIZE 14 BY .91 AT ROW 9.86 COL 46.33
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " ชื่อ :":30 VIEW-AS TEXT
          SIZE 5 BY .95 AT ROW 15.52 COL 34.67
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " เบี้ยรวม 70 :":30 VIEW-AS TEXT
          SIZE 12.83 BY .95 AT ROW 11.86 COL 8
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "โชว์รูม :":30 VIEW-AS TEXT
          SIZE 7.67 BY .91 AT ROW 5.38 COL 83.83 WIDGET-ID 72
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " เบี้ยสุทธิ 70 :":25 VIEW-AS TEXT
          SIZE 12.17 BY .95 AT ROW 10.81 COL 100.33
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " เวลาโหลด  :":30 VIEW-AS TEXT
          SIZE 12.67 BY .95 AT ROW 3.24 COL 35.33
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " ข้อมูลการแจ้งงาน" VIEW-AS TEXT
          SIZE 17 BY .81 AT ROW 2.43 COL 2.17
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "บัตรหมดอายุ :":30 VIEW-AS TEXT
          SIZE 12.67 BY .91 AT ROW 16.52 COL 64.33 WIDGET-ID 20
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "อุปกรณ์ตกแต่ง :":30 VIEW-AS TEXT
          SIZE 14.33 BY .86 AT ROW 20.62 COL 4.5 WIDGET-ID 60
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "เลขรับแจ้ง พรบ :":30 VIEW-AS TEXT
          SIZE 15.5 BY .91 AT ROW 4.33 COL 47.5
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " วันที่โหลด  :":30 VIEW-AS TEXT
          SIZE 12 BY .95 AT ROW 3.33 COL 7.5
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "IC No :":30 VIEW-AS TEXT
          SIZE 7.5 BY .91 AT ROW 16.57 COL 11.67
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "เบี้ยกธ. + พรบ. :":30 VIEW-AS TEXT
          SIZE 15.5 BY .91 AT ROW 11.81 COL 97 WIDGET-ID 12
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " ข้อมูลลูกค้า" VIEW-AS TEXT
          SIZE 11.5 BY .91 AT ROW 14.57 COL 2.33
          BGCOLOR 19 FGCOLOR 1 FONT 6
     " เบอร์ พรบ  :":35 VIEW-AS TEXT
          SIZE 12.67 BY .95 AT ROW 1.43 COL 98
          BGCOLOR 2 FGCOLOR 7 FONT 6
     "Class 70:":30 VIEW-AS TEXT
          SIZE 9 BY .95 AT ROW 12.91 COL 41
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "Campaign :":30 VIEW-AS TEXT
          SIZE 11 BY .95 AT ROW 12.91 COL 78
          BGCOLOR 19 FGCOLOR 0 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1.67 ROW 1.1
         SIZE 133 BY 28.24
         BGCOLOR 3 FGCOLOR 1 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "เลขสติ๊กเกอร์ :":30 VIEW-AS TEXT
          SIZE 12.67 BY .95 AT ROW 12.91 COL 7.67
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "รหัสไปรษณีย์ :":30 VIEW-AS TEXT
          SIZE 13.33 BY .91 AT ROW 18.62 COL 79.33 WIDGET-ID 8
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "วันที่ออกงาน :" VIEW-AS TEXT
          SIZE 12.5 BY 1 AT ROW 27.57 COL 5
          BGCOLOR 19 FGCOLOR 12 FONT 6
     "SUSPECT:":30 VIEW-AS TEXT
          SIZE 11 BY .95 AT ROW 24.33 COL 8.5 WIDGET-ID 76
          BGCOLOR 19 FGCOLOR 6 FONT 6
     "วันที่ไฟล์แจ้งงาน :" VIEW-AS TEXT
          SIZE 16.5 BY .95 AT ROW 4.33 COL 3
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "ลูกค้าซื้อ/ ดีลเลอร์แถม :" VIEW-AS TEXT
          SIZE 20.5 BY .91 AT ROW 9.81 COL 74.17
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " ปีรถ :":35 VIEW-AS TEXT
          SIZE 6.5 BY .95 AT ROW 7.76 COL 88.17
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " ข้อรถและการประกันภัย" VIEW-AS TEXT
          SIZE 21 BY .91 AT ROW 6.95 COL 2.17
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "Status Policy :" VIEW-AS TEXT
          SIZE 14 BY 1 AT ROW 27.57 COL 35
          BGCOLOR 19 FGCOLOR 4 FONT 6
     " Remark :":30 VIEW-AS TEXT
          SIZE 10 BY .86 AT ROW 22.43 COL 9
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "Producer code :":30 VIEW-AS TEXT
          SIZE 16 BY .95 AT ROW 3.24 COL 62.67
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " น้ำหนัก :":30 VIEW-AS TEXT
          SIZE 8.83 BY .95 AT ROW 7.76 COL 105.67
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " ยี่ห้อรถ :":30 VIEW-AS TEXT
          SIZE 8.33 BY .95 AT ROW 7.86 COL 11.83
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " วันที่คุ้มครอง :":35 VIEW-AS TEXT
          SIZE 13.33 BY .95 AT ROW 10.86 COL 6.83
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " ที่อยู่หน้าตาราง1 :":30 VIEW-AS TEXT
          SIZE 16 BY .95 AT ROW 17.57 COL 3.17
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "ที่อยู่ 2 :":30 VIEW-AS TEXT
          SIZE 7.5 BY .91 AT ROW 17.67 COL 85.5
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " กรมธรรม์เดิม  :":35 VIEW-AS TEXT
          SIZE 15 BY .95 AT ROW 1.43 COL 24.83
          BGCOLOR 4 FGCOLOR 7 FONT 6
     "ผู้รับผลประโยชน์ :":30 VIEW-AS TEXT
          SIZE 16.5 BY .86 AT ROW 19.62 COL 2.83
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "ลักษณะการใช้รถ :":30 VIEW-AS TEXT
          SIZE 16.17 BY .95 AT ROW 9.91 COL 4.67
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " เลขเครื่อง :":35 VIEW-AS TEXT
          SIZE 10.5 BY .95 AT ROW 8.86 COL 9.67
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "Class 72:":30 VIEW-AS TEXT
          SIZE 9 BY .95 AT ROW 12.91 COL 59.33 WIDGET-ID 80
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " เบี้ยรวม 72 :":35 VIEW-AS TEXT
          SIZE 12.33 BY .91 AT ROW 11.81 COL 66.83
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "ื กรมธรรม์ใหม่  :":35 VIEW-AS TEXT
          SIZE 15 BY .95 AT ROW 1.43 COL 62.17
          BGCOLOR 2 FGCOLOR 7 FONT 6
     " เลขตัวถัง :":20 VIEW-AS TEXT
          SIZE 11 BY .95 AT ROW 8.81 COL 44.67
          BGCOLOR 19 FGCOLOR 0 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1.67 ROW 1.1
         SIZE 133 BY 28.24
         BGCOLOR 3 FGCOLOR 1 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "Dealer code :":30 VIEW-AS TEXT
          SIZE 13 BY .95 AT ROW 4.29 COL 79 WIDGET-ID 66
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "วันเกิด :":30 VIEW-AS TEXT
          SIZE 7.5 BY .91 AT ROW 16.57 COL 41 WIDGET-ID 16
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "เบี้ย พรบ. :":30 VIEW-AS TEXT
          SIZE 10.67 BY .95 AT ROW 11.86 COL 42
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " ชื่อผู้แจ้ง:":30 VIEW-AS TEXT
          SIZE 9.5 BY .95 AT ROW 5.38 COL 10
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " รุ่นรถ :":30 VIEW-AS TEXT
          SIZE 7.67 BY .95 AT ROW 7.81 COL 40
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " วันที่หมดอายุ :":35 VIEW-AS TEXT
          SIZE 13.83 BY .95 AT ROW 10.86 COL 36.83
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "สถานะงานติดปัญหา :":30 VIEW-AS TEXT
          SIZE 18.33 BY .95 AT ROW 27.62 COL 68 WIDGET-ID 82
          BGCOLOR 19 FGCOLOR 6 FONT 6
     " Agent code :":30 VIEW-AS TEXT
          SIZE 13 BY .95 AT ROW 3.24 COL 95
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " ชื่อดีลเลอร์:":30 VIEW-AS TEXT
          SIZE 11 BY .91 AT ROW 5.38 COL 43.33
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " นามสกุล :":30 VIEW-AS TEXT
          SIZE 9.67 BY .95 AT ROW 15.43 COL 71.17
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " สาขา :":30 VIEW-AS TEXT
          SIZE 6.5 BY .91 AT ROW 4.33 COL 35.17
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "การซ่อม :":35 VIEW-AS TEXT
          SIZE 9 BY .95 AT ROW 12.86 COL 103.17
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "Vat code:":30 VIEW-AS TEXT
          SIZE 9.83 BY .95 AT ROW 4.29 COL 107.67 WIDGET-ID 68
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "  ที่อยู่ 4 :":30 VIEW-AS TEXT
          SIZE 9.5 BY .91 AT ROW 18.62 COL 47.33
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " คำนำหน้าชื่อ :":30 VIEW-AS TEXT
          SIZE 13 BY .95 AT ROW 15.57 COL 6.17
          BGCOLOR 19 FGCOLOR 2 FONT 6
     RECT-335 AT ROW 1.24 COL 1
     RECT-381 AT ROW 27.43 COL 111
     RECT-382 AT ROW 27.43 COL 121.83
     RECT-383 AT ROW 3 COL 2
     RECT-385 AT ROW 7.57 COL 2
     RECT-386 AT ROW 14.95 COL 2 WIDGET-ID 46
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1.67 ROW 1.1
         SIZE 133 BY 28.24
         BGCOLOR 3 FGCOLOR 1 .


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
         TITLE              = "Update Data ISUZU (New)"
         HEIGHT             = 28.67
         WIDTH              = 134.17
         MAX-HEIGHT         = 29.19
         MAX-WIDTH          = 135
         VIRTUAL-HEIGHT     = 29.19
         VIRTUAL-WIDTH      = 135
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
/* SETTINGS FOR FILL-IN fi_acc1 IN FRAME fr_main
   ALIGN-L                                                              */
/* SETTINGS FOR FILL-IN fi_ldate IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_ltime IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_paydate IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_remark1 IN FRAME fr_main
   ALIGN-L                                                              */
/* SETTINGS FOR FILL-IN fi_trndat IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_trndat1 IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_type IN FRAME fr_main
   NO-ENABLE ALIGN-L                                                    */
ASSIGN 
       fi_type:READ-ONLY IN FRAME fr_main        = TRUE.

/* SETTINGS FOR FILL-IN fi_userid IN FRAME fr_main
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Update Data ISUZU (New) */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Update Data ISUZU (New) */
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
            Find  brstat.tlt Where  Recid(brstat.tlt)  =  nv_recidtlt.
            If  avail  brstat.tlt Then do:
                Assign
                      brstat.tlt.filler1            =  trim(fi_policy)       /* กรมธรรม์เดิม*/
                      brstat.tlt.nor_noti_ins       =  trim(fi_polsystem)    /* เบอร์กรมธรรม์ใหม่ */ 
                      brstat.tlt.comp_pol           =  trim(fi_compol)       /*เลขกรมธรรม์พรบ */ 
                      brstat.tlt.comp_sub           =  trim(fi_producer)     /* produer code */                                                                                               
                      brstat.tlt.comp_noti_ins      =  trim(fi_agent)        /* Agent */ 
                      brstat.tlt.safe2              =  trim(fi_accno)        /*เลขที่สัญญา  */ 
                      brstat.tlt.nor_usr_ins        =  trim(fi_ins_off)      /*ผู้แจ้ง                 */ 
                      brstat.tlt.EXP                =  trim(fi_branch)       /*สาขาคุ้มภัย      */
                      brstat.tlt.brand              =  trim(fi_brand)        /*ยี่ห้อ           */ 
                      brstat.tlt.model              =  trim(fi_model)        /*รุ่น             */
                      brstat.tlt.vehuse             =  trim(fi_vehuse)       
                      brstat.tlt.lince2             =  trim(fi_year)         /*ปี           */ 
                      brstat.tlt.cc_weight          =  fi_ton                /*ขนาดเครื่อง  */ 
                      brstat.tlt.colorcod           =  trim(fi_icno)         /*IC No*/
                      brstat.tlt.OLD_cha            =  trim(fi_bdate)        /*วันเกิด */
                      brstat.tlt.OLD_eng            =  trim(fi_expbdat)      /*วันที่บัตรหมดอายุ */ 
                      brstat.tlt.expousr            =  trim(fi_covcod2)      /* ประกันแถม/ไม่แถม*/ 
                      brstat.tlt.comp_usr_tlt       =  trim(fi_covcod)       /*ความคุ้มครอง */
                      brstat.tlt.eng_no             =  trim(fi_eng_no)       /*เลขเครื่อง   */ 
                      brstat.tlt.cha_no             =  trim(fi_cha_no)       /*เลขถัง       */ 
                      brstat.tlt.lince1             =  trim(fi_licence)      /*เลขทะเบียน   */ 
                      brstat.tlt.lince3             =  trim(fi_dealer)       /*ชื่อดีลเลอร์         */
                      brstat.tlt.subins             =  trim(fi_showroom)     /*showroom*/
                      brstat.tlt.safe3              =  trim(fi_class)        /*class70         */
                      brstat.tlt.ins_bus            =  TRIM( fi_class72)     /* class72 */
                      brstat.tlt.gendat             =  fi_comdat             /*วันที่เริ่มคุ้มครอง     */                                                                                            
                      brstat.tlt.expodat            =  fi_expdat             /*วันที่สิ้นสุดคุ้มครอง   */
                      brstat.tlt.nor_coamt          =  fi_sumsi              /*ทุนประกัน        */
                      brstat.tlt.rec_name           =  trim(fi_title)         /*คำนำหน้าชื่อผู้เอาประกันภัย */  
                      brstat.tlt.ins_name           =  trim(fi_firstname) + " " + TRIM(fi_lastname)  
                      brstat.tlt.nor_grprm          =  fi_prem1            /*เบี้ยสุทธิกธ.    */    
                      brstat.tlt.comp_coamt         =  fi_gross_amt        /*เบี้ยรวมกธ       */
                      brstat.tlt.rec_addr4          =  string(fi_compprm)        /*เบี้ยสุทธิพรบ.    */
                      brstat.tlt.comp_grprm         =  fi_comtotal         /*เบี้ยรวมพรบ.    */ 
                      brstat.tlt.recac              =  string(fi_totalprm)         /*เบี้ย กธ.+ พรบ. */
                      brstat.tlt.comp_sck           =  trim(fi_sckno)          /*เลขที่สติ๊กเกอร์ */
                      brstat.tlt.lotno              =  trim(fi_camp)          /*แคมเปญ*/ 
                      brstat.tlt.ins_addr1          =  trim(fi_addr1)          /*ที่อยู่ลูกค้า1*/                                                                                                     
                      brstat.tlt.ins_addr2          =  trim(fi_addr2)          /*ที่อยู่ลูกค้า2*/ 
                      brstat.tlt.ins_addr3          =  trim(fi_addr3)          /*ที่อยู่ลูกค้า3*/ 
                      brstat.tlt.ins_addr4          =  trim(fi_addr4)          /*ที่อยู่ลูกค้า4*/ 
                      brstat.tlt.ins_addr5          =  trim(fi_post)          
                      brstat.tlt.safe1              =  trim(fi_benname)           /*ผู้รับผลประโยชน์*/ 
                      brstat.tlt.note1              =  trim(fi_acc1)        
                      brstat.tlt.note2              =  trim(fi_acc2)    
                      brstat.tlt.dealer             =  trim(fi_delcode)       
                      brstat.tlt.finint             =  trim(fi_vatcode)  
                      brstat.tlt.filler2            =  trim(fi_remark1)  + " " + trim(fi_remark2)    
                      brstat.tlt.expotim            =  trim(fi_suspect)            /* suspect */
                      brstat.tlt.stat               =  trim(fi_garage)          /*สถานที่ซ่อม */
                      brstat.tlt.note3              =  IF rs_status = 1 THEN "NO" ELSE "YES"
                      /*brstat.tlt.rec_addr3          =  trim(fi_inspace)          /*ตรวจสภาพ     */ 
                      brstat.tlt.gentim             =  trim(fi_result) */ .          /* ผลตรวจสภาพ */
            END.
            Apply "Close" to this-procedure.
            Return no-apply.
        END.
        WHEN FALSE THEN /* No */          
            DO:   
            APPLY "entry" TO fi_covcod.
            RETURN NO-APPLY.
        END.
        END CASE.
RELEASE brstat.tlt.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_acc1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_acc1 C-Win
ON LEAVE OF fi_acc1 IN FRAME fr_main
DO:
    fi_acc1 = trim(INPUT fi_acc1).
    DISP fi_acc1 with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_acc2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_acc2 C-Win
ON LEAVE OF fi_acc2 IN FRAME fr_main
DO:
    fi_acc2 = trim(INPUT fi_acc2).
    DISP fi_acc2 with frame  fr_main.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_accno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_accno C-Win
ON LEAVE OF fi_accno IN FRAME fr_main
DO:
  fi_accno = INPUT fi_accno.
  DISP fi_accno WITH FRAM fr_main.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_addr1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_addr1 C-Win
ON LEAVE OF fi_addr1 IN FRAME fr_main
DO:
  fi_addr1 = INPUT fi_addr1 .
  DISP fi_addr1 WITH FRAM fr_main.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_addr2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_addr2 C-Win
ON LEAVE OF fi_addr2 IN FRAME fr_main
DO:
  fi_addr2 = INPUT fi_addr2 .
  DISP fi_addr2 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_addr3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_addr3 C-Win
ON LEAVE OF fi_addr3 IN FRAME fr_main
DO:
  fi_addr3 = INPUT fi_addr3 .
  DISP fi_addr3 WITH FRAM fr_main.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_addr4
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_addr4 C-Win
ON LEAVE OF fi_addr4 IN FRAME fr_main
DO:
    fi_addr4 = INPUT fi_addr4.
    DISP fi_addr4 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_agent
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_agent C-Win
ON LEAVE OF fi_agent IN FRAME fr_main
DO:
  fi_agent = INPUT fi_agent .
  DISP fi_agent WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_bdate
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_bdate C-Win
ON LEAVE OF fi_bdate IN FRAME fr_main
DO:
    fi_bdate = INPUT fi_bdate .
    DISP fi_bdate WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_benname
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_benname C-Win
ON LEAVE OF fi_benname IN FRAME fr_main
DO:
  fi_benname = INPUT fi_benname .
  DISP fi_benname WITH FRAM fr_main.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_branch
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_branch C-Win
ON LEAVE OF fi_branch IN FRAME fr_main
DO:
  fi_branch = INPUT fi_branch.
  DISP fi_branch WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_brand
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_brand C-Win
ON LEAVE OF fi_brand IN FRAME fr_main
DO:
  fi_brand = INPUT fi_brand .
  DISP fi_brand WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_camp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_camp C-Win
ON LEAVE OF fi_camp IN FRAME fr_main
DO:
    /*A60-0263*/
    fi_camp = INPUT fi_camp .
    DISP fi_camp WITH FRAM fr_main.
     /*A60-0263*/
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_cha_no
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_cha_no C-Win
ON LEAVE OF fi_cha_no IN FRAME fr_main
DO:
  fi_cha_no  =  Input  fi_cha_no.
  Disp  fi_cha_no with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_class
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_class C-Win
ON LEAVE OF fi_class IN FRAME fr_main
DO:
  fi_class = INPUT fi_class.
  DISP fi_class WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_class72
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_class72 C-Win
ON LEAVE OF fi_class72 IN FRAME fr_main
DO:
  fi_class72 = INPUT fi_class72.
  DISP fi_class72 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_comdat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_comdat C-Win
ON LEAVE OF fi_comdat IN FRAME fr_main
DO:
  fi_comdat = INPUT fi_comdat.
  DISP fi_comdat WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_compol
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_compol C-Win
ON LEAVE OF fi_compol IN FRAME fr_main
DO:
  fi_compol  =  Input  fi_compol.
  Disp  fi_compol with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_compprm
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_compprm C-Win
ON LEAVE OF fi_compprm IN FRAME fr_main
DO:
  fi_compprm = INPUT fi_compprm.
  DISP fi_compprm WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_comtotal
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_comtotal C-Win
ON LEAVE OF fi_comtotal IN FRAME fr_main
DO:
    fi_comtotal = INPUT fi_comtotal  .
    DISP fi_comtotal WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_covcod
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_covcod C-Win
ON LEAVE OF fi_covcod IN FRAME fr_main
DO:
    fi_covcod = INPUT fi_covcod .
    DISP fi_covcod WITH FRAM fr_main.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_covcod2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_covcod2 C-Win
ON LEAVE OF fi_covcod2 IN FRAME fr_main
DO:
    fi_covcod2 = INPUT fi_covcod2.
    DISP fi_covcod2 WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_dealer
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_dealer C-Win
ON LEAVE OF fi_dealer IN FRAME fr_main
DO:
    fi_dealer = INPUT fi_dealer .
    DISP fi_dealer WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_delcode
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_delcode C-Win
ON LEAVE OF fi_delcode IN FRAME fr_main
DO:
  fi_delcode = INPUT fi_delcode .
  DISP fi_delcode WITH FRAM fr_main.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_eng_no
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_eng_no C-Win
ON LEAVE OF fi_eng_no IN FRAME fr_main
DO:
  fi_eng_no  =  Input  fi_eng_no.
  Disp  fi_eng_no with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_expbdat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_expbdat C-Win
ON LEAVE OF fi_expbdat IN FRAME fr_main
DO:
    fi_expbdat = INPUT fi_expbdat .
    DISP fi_expbdat WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_expdat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_expdat C-Win
ON LEAVE OF fi_expdat IN FRAME fr_main
DO:
  fi_expdat = INPUT fi_expdat.
  DISP fi_expdat WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_firstname
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_firstname C-Win
ON LEAVE OF fi_firstname IN FRAME fr_main
DO:
  fi_firstname = INPUT fi_firstname .
  DISP fi_firstname WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_garage
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_garage C-Win
ON LEAVE OF fi_garage IN FRAME fr_main
DO:
  fi_garage =  Input  fi_garage.
  Disp  fi_garage with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_gross_amt
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_gross_amt C-Win
ON LEAVE OF fi_gross_amt IN FRAME fr_main
DO:
  fi_gross_amt = INPUT fi_gross_amt.
  DISP fi_gross_amt WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_icno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_icno C-Win
ON LEAVE OF fi_icno IN FRAME fr_main
DO:
    fi_icno = INPUT fi_icno .
    DISP fi_icno WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_ins_off
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_ins_off C-Win
ON LEAVE OF fi_ins_off IN FRAME fr_main
DO:
  fi_ins_off = INPUT fi_ins_off .
  DISP fi_ins_off WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_lastname
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_lastname C-Win
ON LEAVE OF fi_lastname IN FRAME fr_main
DO:
    fi_lastname = INPUT fi_lastname .
    DISP fi_lastname WITH FRAM fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_licence
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_licence C-Win
ON LEAVE OF fi_licence IN FRAME fr_main
DO:
  fi_licence =  Input  fi_licence.
  Disp  fi_licence with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_model
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_model C-Win
ON LEAVE OF fi_model IN FRAME fr_main
DO:
  fi_vehuse =  Input  fi_vehuse.
  Disp  fi_vehuse with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_polsystem
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_polsystem C-Win
ON LEAVE OF fi_polsystem IN FRAME fr_main
DO:
  fi_polsystem  =  Input  fi_polsystem.
  Disp  fi_polsystem with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_post
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_post C-Win
ON LEAVE OF fi_post IN FRAME fr_main
DO:
    fi_post = INPUT fi_post.
    DISP fi_post WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_prem1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_prem1 C-Win
ON LEAVE OF fi_prem1 IN FRAME fr_main
DO:
  fi_prem1 = INPUT fi_prem1 .
  DISP fi_prem1 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_producer
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_producer C-Win
ON LEAVE OF fi_producer IN FRAME fr_main
DO:
  fi_producer = INPUT fi_producer .
  DISP fi_producer WITH FRAM fr_main.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_remark1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_remark1 C-Win
ON LEAVE OF fi_remark1 IN FRAME fr_main
DO:
    fi_remark1 = trim(INPUT fi_remark1).
    DISP fi_remark1 with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_remark2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_remark2 C-Win
ON LEAVE OF fi_remark2 IN FRAME fr_main
DO:
    fi_remark2 = trim(INPUT fi_remark2).
    DISP fi_remark2 with frame  fr_main.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_sckno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_sckno C-Win
ON LEAVE OF fi_sckno IN FRAME fr_main
DO:
  fi_sckno = INPUT fi_sckno .
  DISP fi_sckno WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_showroom
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_showroom C-Win
ON LEAVE OF fi_showroom IN FRAME fr_main
DO:
    fi_showroom = INPUT fi_showroom .
    DISP fi_showroom WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_sumsi
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_sumsi C-Win
ON LEAVE OF fi_sumsi IN FRAME fr_main
DO:
    fi_sumsi = INPUT fi_sumsi.
    DISP fi_sumsi WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_suspect
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_suspect C-Win
ON LEAVE OF fi_suspect IN FRAME fr_main
DO:
  fi_suspect = INPUT fi_suspect .
  DISP fi_suspect WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_title
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_title C-Win
ON LEAVE OF fi_title IN FRAME fr_main
DO:
  fi_title = INPUT fi_title.
  DISP fi_title WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_ton
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_ton C-Win
ON LEAVE OF fi_ton IN FRAME fr_main
DO:
  fi_ton  =  Input  fi_ton.
  Disp  fi_ton with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_totalprm
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_totalprm C-Win
ON LEAVE OF fi_totalprm IN FRAME fr_main
DO:
    fi_totalprm = INPUT fi_totalprm .
    DISP fi_totalprm WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_trndat1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_trndat1 C-Win
ON LEAVE OF fi_trndat1 IN FRAME fr_main /* Trndat */
DO:
   /* fi_trndat1 = INPUT fi_trndat1.
    DISP fi_trndat1 WITH FRAME fr_main.*/
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_vatcode
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_vatcode C-Win
ON LEAVE OF fi_vatcode IN FRAME fr_main
DO:
  fi_vatcode = INPUT fi_vatcode .
  DISP fi_vatcode WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_vehuse
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_vehuse C-Win
ON LEAVE OF fi_vehuse IN FRAME fr_main
DO:
  fi_vehuse  =  Input  fi_vehuse.
  Disp  fi_vehuse with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_year
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_year C-Win
ON LEAVE OF fi_year IN FRAME fr_main
DO:
  fi_year = INPUT fi_year .
  DISP fi_year WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME rs_status
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL rs_status C-Win
ON VALUE-CHANGED OF rs_status IN FRAME fr_main
DO:
    rs_status = INPUT rs_status .
    DISP rs_status WITH FRAME fr_main.
  
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
  
  gv_prgid = "wgwqisuzu1".
  gv_prog  = "Query & Update Data  (ISUZU) ".
  RUN  WUT\WUTHEAD ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).
/*********************************************************************/ 
 /*  RUN Wut\WutwiCen ({&WINDOW-NAME}:HANDLE). */ 
  /*CURRENT-WINDOW:WINDOW-STATE = WINDOW-MAXIMIZED.*/
  SESSION:DATA-ENTRY-RETURN = YES.
  
  Find  brstat.tlt  Where  Recid(brstat.tlt)  =  nv_recidtlt NO-LOCK NO-ERROR NO-WAIT .
  If  avail  brstat.tlt  Then do:
         RUN proc_assignfi.
         DISP fi_type             fi_icno               fi_comtotal        
              fi_policy           fi_bdate              fi_totalprm        
              fi_polsystem        fi_expbdat            fi_sckno           
              fi_compol           fi_covcod2            fi_garage          
              fi_ldate            fi_covcod             /*fi_inspace  */       
              fi_ltime            fi_eng_no             fi_camp            
              fi_producer         fi_cha_no             fi_addr1           
              fi_agent            fi_licence            fi_addr2           
              fi_trndat           fi_dealer             fi_addr3           
              fi_accno            fi_class              fi_addr4           
              fi_ins_off          fi_comdat             fi_post            
              fi_branch           fi_expdat             fi_benname         
              fi_brand            fi_sumsi              fi_remark1         
              fi_model            fi_title              fi_remark2         
              fi_vehuse           fi_firstname          fi_userid          
              fi_year             fi_lastname           fi_polstatus       
              fi_ton              fi_prem1              fi_paydate         
              fi_gross_amt        fi_suspect            fi_compprm            
              /*fi_result   */    fi_acc1               fi_acc2 
              fi_delcode          fi_vatcode            fi_showroom
              fi_class72          rs_status  WITH FRAME fr_main.
  END.
  IF NOT THIS-PROCEDURE:PERSISTENT THEN WAIT-FOR CLOSE OF THIS-PROCEDURE.
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
  DISPLAY rs_status fi_policy fi_covcod2 fi_type fi_polstatus fi_paydate 
          fi_polsystem fi_compol fi_producer fi_agent fi_branch fi_accno 
          fi_comtotal fi_ins_off fi_brand fi_model fi_year fi_ton fi_eng_no 
          fi_cha_no fi_licence fi_covcod fi_comdat fi_expdat fi_sumsi 
          fi_gross_amt fi_compprm fi_sckno fi_prem1 fi_garage fi_title 
          fi_firstname fi_lastname fi_icno fi_addr1 fi_addr2 fi_addr3 fi_addr4 
          fi_benname fi_remark1 fi_remark2 fi_ldate fi_ltime fi_userid fi_trndat 
          fi_class fi_camp fi_vehuse fi_trndat1 fi_dealer fi_post fi_totalprm 
          fi_bdate fi_expbdat fi_acc1 fi_acc2 fi_delcode fi_vatcode fi_showroom 
          fi_suspect fi_class72 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE rs_status fi_policy fi_covcod2 fi_polstatus fi_polsystem fi_compol 
         fi_producer fi_agent fi_branch fi_accno fi_comtotal fi_ins_off 
         fi_brand fi_model fi_year fi_ton fi_eng_no fi_cha_no fi_licence 
         fi_covcod fi_comdat fi_expdat fi_sumsi fi_gross_amt fi_compprm 
         fi_sckno fi_prem1 fi_garage fi_title fi_firstname fi_lastname fi_icno 
         fi_addr1 fi_addr2 fi_addr3 fi_addr4 fi_benname fi_remark1 fi_remark2 
         bu_save bu_exit fi_class fi_camp fi_vehuse fi_dealer fi_post 
         fi_totalprm fi_bdate fi_expbdat fi_acc1 fi_acc2 fi_delcode fi_vatcode 
         fi_showroom fi_suspect fi_class72 RECT-335 RECT-381 RECT-382 RECT-383 
         RECT-385 RECT-386 
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
    ASSIGN 
          fi_type       = IF brstat.tlt.flag = "N" THEN "NEW" ELSE "RENEW"
          fi_policy     = brstat.tlt.filler1                /* กรมธรรม์เดิม*/
          fi_polsystem  = brstat.tlt.nor_noti_ins           /* เบอร์กรมธรรม์ใหม่ */ 
          fi_compol     = brstat.tlt.comp_pol               /*เลขกรมธรรม์พรบ */ 
          fi_ldate      = brstat.tlt.entdat                 /* วันที่โหลด */  
          fi_ltime      = brstat.tlt.enttim                 /* เวลาโหลด   */  
          fi_producer   = brstat.tlt.comp_sub               /* produer code */                                                                                               
          fi_agent      = brstat.tlt.comp_noti_ins          /* Agent */ 
          fi_trndat     = brstat.tlt.trndat                 /* วันที่ไฟล์แจ้งงาน */ 
          fi_accno      = brstat.tlt.safe2                  /*เลขที่สัญญา  */ 
          fi_ins_off    = brstat.tlt.nor_usr_ins            /*ผู้แจ้ง                 */ 
          fi_branch     = brstat.tlt.EXP                    /*สาขาคุ้มภัย      */
          fi_brand      = brstat.tlt.brand                  /*ยี่ห้อ           */ 
          fi_model      = brstat.tlt.model                  /*รุ่น             */
          fi_vehuse     = brstat.tlt.vehuse                 
          fi_year       = brstat.tlt.lince2                 /*ปี           */ 
          fi_ton        = brstat.tlt.cc_weight              /*ขนาดเครื่อง  */ 
          fi_icno       = brstat.tlt.colorcod               /*IC No*/
          fi_bdate      = brstat.tlt.OLD_cha                /*วันเกิด */
          fi_expbdat    = TRIM(brstat.tlt.OLD_eng)          /*วันที่บัตรหมดอายุ */ 
          fi_covcod2    = TRIM(brstat.tlt.expousr)          /* ประกันแถม/ไม่แถม*/ 
          fi_covcod     = trim(brstat.tlt.comp_usr_tlt)     /*ความคุ้มครอง */
          fi_eng_no     = brstat.tlt.eng_no                 /*เลขเครื่อง   */ 
          fi_cha_no     = brstat.tlt.cha_no                 /*เลขถัง       */ 
          fi_licence    = brstat.tlt.lince1                 /*เลขทะเบียน   */ 
          fi_dealer     = brstat.tlt.lince3                 /*ชื่อดีลเลอร์         */
          fi_showroom   = brstat.tlt.subins                 /*showroom*/
          fi_class      = trim(brstat.tlt.safe3)            /*class70         */ 
          fi_class72    = TRIM(brstat.tlt.ins_bus)          /* class72 */
          fi_comdat     = brstat.tlt.gendat                 /*วันที่เริ่มคุ้มครอง     */                                                                                            
          fi_expdat     = brstat.tlt.expodat                /*วันที่สิ้นสุดคุ้มครอง   */
          fi_sumsi      = brstat.tlt.nor_coamt              /*ทุนประกัน        */
          fi_title      = trim(brstat.tlt.rec_name)         /*คำนำหน้าชื่อผู้เอาประกันภัย */  
          fi_firstname  = /*IF TRIM(brstat.tlt.ins_name) = "บจก." OR TRIM(brstat.tlt.ins_name) = "มูลนิธิ" OR 
                             TRIM(brstat.tlt.ins_name) = "หจก." OR TRIM(brstat.tlt.ins_name) = "บริษัท" THEN 
                             TRIM(brstat.tlt.ins_name)  
                          ELSE */ Substr(brstat.tlt.ins_name,1,R-INDEX(brstat.tlt.ins_name," "))               
          fi_lastname   = /*IF TRIM(brstat.tlt.ins_name) = "บจก." OR TRIM(brstat.tlt.ins_name) = "มูลนิธิ" OR 
                             TRIM(brstat.tlt.ins_name) = "หจก." OR TRIM(brstat.tlt.ins_name) = "บริษัท"  THEN ""
                          ELSE*/ Substr(brstat.tlt.ins_name,R-INDEX(brstat.tlt.ins_name," ") + 1,length(brstat.tlt.ins_name))  
          fi_prem1      = brstat.tlt.nor_grprm             /*เบี้ยสุทธิกธ.    */    
          fi_gross_amt  = brstat.tlt.comp_coamt            /*เบี้ยรวมกธ       */
          fi_compprm    = deci(brstat.tlt.rec_addr4)       /*เบี้ยสุทธิพรบ.    */
          fi_comtotal   = brstat.tlt.comp_grprm            /*เบี้ยรวมพรบ.    */ 
          fi_totalprm   = DECI(brstat.tlt.recac)           /*เบี้ย กธ.+ พรบ. */
          fi_sckno      = brstat.tlt.comp_sck              /*เลขที่สติ๊กเกอร์ */
          fi_camp       = trim(brstat.tlt.lotno)           /*แคมเปญ*/ 
          fi_addr1      = trim(brstat.tlt.ins_addr1)       /*ที่อยู่ลูกค้า1*/                                                                                                     
          fi_addr2      = trim(brstat.tlt.ins_addr2)       /*ที่อยู่ลูกค้า2*/ 
          fi_addr3      = trim(brstat.tlt.ins_addr3)       /*ที่อยู่ลูกค้า3*/ 
          fi_addr4      = TRIM(brstat.tlt.ins_addr4)       /*ที่อยู่ลูกค้า4*/ 
          fi_post       = TRIM(brstat.tlt.ins_addr5)       
          fi_benname    = trim(brstat.tlt.safe1)           /*ผู้รับผลประโยชน์*/ 
          fi_remark1    = IF LENGTH(brstat.tlt.filler2) > 80  then SUBSTR(brstat.tlt.filler2,1,80)  else TRIM(brstat.tlt.filler2)     /*หมายเหตุ  */                                
          fi_remark2    = IF LENGTH(brstat.tlt.filler2) > 80  then SUBSTR(brstat.tlt.filler2,81,LENGTH(brstat.tlt.filler2)) else ""     /*หมายเหตุ  */
          fi_userid     = brstat.tlt.usrid               /*User Load Data */
          fi_polstatus  = IF brstat.tlt.releas = "NO" THEN "ยังไม่ออกงาน" ELSE IF INDEX(brstat.tlt.releas,"Cancel") <> 0 THEN "ยกเลิก" ELSE "ออกงานแล้ว"
          fi_paydate    = brstat.tlt.dat_ins_noti       /*วันที่ ออกงาน*/
          fi_acc1       = brstat.tlt.note1        
          fi_acc2       = brstat.tlt.note2
          fi_delcode    = brstat.tlt.dealer      
          fi_vatcode    = brstat.tlt.finint 
          rs_status     = IF brstat.tlt.note3 = "NO" THEN 1 ELSE 2 
          fi_suspect    = brstat.tlt.expotim     /* suspect */  
          fi_garage     = TRIM(brstat.tlt.stat)  /*สถานที่ซ่อม */
          /*fi_inspace    = brstat.tlt.rec_addr3 /*ตรวจสภาพ     */  
          fi_result     = brstat.tlt.gentim*/    /* ผลตรวจสภาพ */ .

END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assignfi-01 C-Win 
PROCEDURE proc_assignfi-01 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*Assign
          fi_type       = IF brstat.tlt.flag = "N" THEN "NEW" ELSE "RENEW"
          fi_policy     = brstat.tlt.filler1             /* กรมธรรม์เดิม*/
          fi_polsystem  = brstat.tlt.nor_noti_ins       /* เบอร์กรมธรรม์ใหม่ */ 
          fi_compol     = brstat.tlt.comp_pol           /*เลขกรมธรรม์พรบ */ 
          fi_ldate      = brstat.tlt.entdat             /* วันที่โหลด */  
          fi_ltime      = brstat.tlt.enttim             /* เวลาโหลด   */  
          fi_producer   = brstat.tlt.comp_sub           /* produer code */                                                                                               
          fi_agent      = brstat.tlt.comp_noti_ins      /* Agent */ 
          fi_trndat     = brstat.tlt.datesent           /* วันที่ไฟล์แจ้งงาน */ 
          fi_branch     = brstat.tlt.EXP                /*สาขาคุ้มภัย      */
          fi_comname    = brstat.tlt.nor_noti_tlt       /* รหัสบริษัท */
          fi_accno      = brstat.tlt.safe2              /*เลขที่สัญญา  */   
          fi_ins_off    = brstat.tlt.nor_usr_ins        /*ผู้แจ้ง                 */ 
          fi_brand      = brstat.tlt.brand              /*ยี่ห้อ           */ 
          fi_vehuse     = brstat.tlt.model              /*รุ่น             */ 
          fi_year       = brstat.tlt.lince2             /*ปี           */  
          fi_ton        = brstat.tlt.cc_weight          /*ขนาดเครื่อง  */ 
          fi_cartyp     = brstat.tlt.colorcod           /*ประเภทประกัน*/
          fi_instyp     = brstat.tlt.OLD_cha            /*ประเภทรถ */
          fi_eng_no     = brstat.tlt.eng_no             /*เลขเครื่อง   */ 
          fi_cha_no     = brstat.tlt.cha_no             /*เลขถัง       */ 
          fi_licence    = brstat.tlt.lince1             /*เลขทะเบียน   */ 
          fi_province   = brstat.tlt.lince3             /*จังหวัด          */
          fi_covcod     = trim(brstat.tlt.comp_usr_tlt)  /*ความคุ้มครอง */
          fi_covcod2    = TRIM(brstat.tlt.expousr)      /* ประกันแถม/ไม่แถม*/  
          fi_comtyp     = TRIM(brstat.tlt.OLD_eng)       /* พรบ . แถม/ไม่แถม */ 
          fi_comdat     = brstat.tlt.gendat             /*วันที่เริ่มคุ้มครอง     */                                                                                            
          fi_expdat     = brstat.tlt.expodat            /*วันที่สิ้นสุดคุ้มครอง   */
          fi_sumsi      = brstat.tlt.nor_coamt          /*ทุนประกัน        */       
          fi_prem1      = brstat.tlt.nor_grprm          /*เบี้ยสุทธิกธ.    */    
          fi_gross_amt  = brstat.tlt.comp_coamt         /*เบี้ยรวมกธ       */ 
          fi_compprm    = deci(brstat.tlt.rec_addr4)    /*เบี้ยสุทธิพรบ.    */
          fi_comtotal   = brstat.tlt.comp_grprm         /*เบี้ยรวมพรบ.    */ 
          fi_sckno      = brstat.tlt.comp_sck           /*เลขที่สติ๊กเกอร์ */
          fi_garage     = TRIM(brstat.tlt.stat)         /*สถานที่ซ่อม */
          fi_inspace    = brstat.tlt.rec_addr3          /*ตรวจสภาพ     */                                                                                      /*A60-0263*/
          fi_class      = trim(brstat.tlt.safe3)        /*class70         */      
          fi_camp       = trim(brstat.tlt.lotno)              /*แคมเปญ*/                                       
          fi_title      = trim(brstat.tlt.rec_name)                          /*คำนำหน้าชื่อผู้เอาประกันภัย */                                                                                           
          /* ชื่อ */                          
          fi_firstname  = IF TRIM(brstat.tlt.rec_name) = "บจก." OR TRIM(brstat.tlt.rec_name) = "มูลนิธิ" OR 
                             TRIM(brstat.tlt.rec_name) = "หจก." OR TRIM(brstat.tlt.rec_name) = "บริษัท" THEN 
                             TRIM(brstat.tlt.ins_name)  
                         ELSE Substr(brstat.tlt.ins_name,1,R-INDEX(brstat.tlt.ins_name," "))               
          fi_lastname   =IF TRIM(brstat.tlt.rec_name) = "บจก." OR TRIM(brstat.tlt.rec_name) = "มูลนิธิ" OR 
                            TRIM(brstat.tlt.rec_name) = "หจก." OR TRIM(brstat.tlt.rec_name) = "บริษัท"  THEN ""
                         ELSE Substr(brstat.tlt.ins_name,R-INDEX(brstat.tlt.ins_name," ") + 1,length(brstat.tlt.ins_name))                                                                                                 
          fi_name2      = TRIM(brstat.tlt.nor_usr_tlt)                                                                                       
          fi_recname    = trim(brstat.tlt.rec_addr5)         /*ชื่อออกใบกำกับภาษี*/
          fi_addr1      = trim(brstat.tlt.ins_addr1)         /*ที่อยู่ลูกค้า1*/                                                                                                     
          fi_addr2      = trim(brstat.tlt.ins_addr2)         /*ที่อยู่ลูกค้า2*/ 
          fi_addr3      = trim(brstat.tlt.ins_addr3)         /*ที่อยู่ลูกค้า3*/ 
          fi_addr4      = IF index(brstat.tlt.ins_addr4," ") <> 0 THEN SUBSTR(tlt.ins_addr4,1,INDEX(tlt.ins_addr4," ") - 1) ELSE TRIM(brstat.tlt.ins_addr4)   /*ที่อยู่ลูกค้า4*/ 
          fi_post       = IF index(brstat.tlt.ins_addr4," ") <> 0 THEN SUBSTR(tlt.ins_addr4,R-INDEX(tlt.ins_addr4," ")) ELSE "" 
          fi_occup      = trim(brstat.tlt.recac)        /*อาชีพ*/
          fi_drivno     = trim(brstat.tlt.endno)        /*ระบุผู้ขับขี่ */
          fi_benname    = trim(brstat.tlt.safe1)  /*ผู้รับผลประโยชน์*/ 
          fi_remark1    = IF LENGTH(brstat.tlt.filler2) <> 0  then SUBSTR(brstat.tlt.filler2,1,80)  else ""     /*หมายเหตุ  */                                
          fi_remark2    = IF LENGTH(brstat.tlt.filler2) > 80  then SUBSTR(brstat.tlt.filler2,81,80) else ""     /*หมายเหตุ  */
          fi_paydate    = brstat.tlt.dat_ins_noti       /*วันที่ matchfile confirm */
          fi_polstatus  = IF brstat.tlt.releas = "NO" THEN "ยังไม่ออกงาน" ELSE IF INDEX(brstat.tlt.releas,"Cancel") <> 0 THEN "ยกเลิก" ELSE "ออกงานแล้ว"
          fi_trndat1    = brstat.tlt.entdat
          fi_userid     = brstat.tlt.usrid               /*User Load Data */
          fi_suspect    = brstat.tlt.expotim   /* suspect */       /* A62-0445*/
          fi_result     = brstat.tlt.gentim .   /* ผลตรวจสภาพ */    /* A62-0445*/
             
        
        IF brstat.tlt.ins_addr5 <> "" AND trim(brstat.tlt.ins_addr5) <> "IC: BD: BE: TE:" THEN DO:
            ASSIGN  n_char     = ""     n_length    = 0 
                    n_char     = TRIM(brstat.tlt.ins_addr5)
                    fi_phone   = TRIM(SUBSTR(n_char,R-INDEX(n_char,"TE:")))
                    n_char     = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"TE:") - 2))
                    fi_expbdat = TRIM(SUBSTR(n_char,R-INDEX(n_char,"BE:")))
                    n_char     = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"BE:") - 2))
                    fi_bdate   = TRIM(SUBSTR(n_char,R-INDEX(n_char,"BD:"))) 
                    n_char     = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"BD:") - 2)) 
                    fi_icno    = TRIM(SUBSTR(n_char,R-INDEX(n_char,"IC:"))) .

             IF index(fi_icno,"IC:")    <> 0 THEN ASSIGN fi_icno    = REPLACE(fi_icno,"IC:","").      /* เลขบัตร ปชช */ 
             IF index(fi_bdate,"BD:")   <> 0 THEN ASSIGN fi_bdate   = REPLACE(fi_bdate,"BD:","").     /* วันเกิด */ 
             IF index(fi_expbdat,"BE:") <> 0 THEN ASSIGN fi_expbdat = REPLACE(fi_expbdat,"BE:","") .  /*บัตรหมดอายุ */
             IF index(fi_phone,"TE:")   <> 0 THEN ASSIGN fi_phone   = REPLACE(fi_phone,"TE:","").     /*เบอร์โทร */
           
        END.
        
       IF trim(brstat.tlt.endno) = "ระบุผู้ขับขี่"  THEN DO:
           /* ผู้ขับขี่ 1 */
            IF brstat.tlt.dri_name1 <> "" AND TRIM(brstat.tlt.dri_name1) <> "ID1:" THEN DO:
                ASSIGN
                  n_char        = trim(brstat.tlt.dri_name1) /* ผู้ขับขี่ 1 */
                  n_length      = LENGTH(n_char)
                  fi_driv1      = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"ID1:") - 1))         /*ระบุผู้ขับขี้1    */  
                  fi_drivid1    = TRIM(SUBSTR(n_char,R-INDEX(n_char,"ID1:") + 4,n_length))  /*เลขที่ใบขับขี่1   */ 
                  fi_birth1     = trim(brstat.tlt.dri_no1 ). /*วันเดือนปีเกิด1   */ 
                
                IF brstat.tlt.rec_addr1 <> "" AND TRIM(brstat.tlt.rec_addr1) <> "OC1:"  THEN DO:
                    ASSIGN n_char     = ""
                           n_length   = 0
                           n_char     = trim(brstat.tlt.rec_addr1) /* ผู้ขับขี่ 1 */
                           n_length   = LENGTH(n_char)
                           fi_drivgen1  = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"OC1:") - 1))         /*เพศผู้ขับขี้1    */  
                           fi_drivocc1  = TRIM(SUBSTR(n_char,R-INDEX(n_char,"OC1:") + 4,n_length)).  /*อาชีพขับขี่1   */ 
                END.
            END.
            ELSE ASSIGN fi_drivid1   = ""     fi_driv1     = ""   fi_birth1    = "" fi_drivgen1 = ""  fi_drivocc1 = "".
            

             /* ผู้ขับขี่ 2 */
            IF brstat.tlt.dri_name2 <> "" AND TRIM(brstat.tlt.dri_name2) <> "ID2:"THEN DO:
                ASSIGN 
                  n_char        = trim(brstat.tlt.dri_name2)  /*ผู้ขับขี่ 2*/ 
                  n_length      = LENGTH(n_char)
                  fi_driv2      = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"ID2:") - 1))          /*ระบุผู้ขับขี้2      */  
                  fi_drivid2    = TRIM(SUBSTR(n_char,R-INDEX(n_char,"ID2:") + 4,n_length))   /*เลขที่ใบขับขี่2     */ 
                  fi_birth2     = trim(brstat.tlt.dri_no2). /*วันเดือนปีเกิด2*/

                
                IF brstat.tlt.rec_addr2 <> "" AND TRIM(brstat.tlt.rec_addr2) <> "OC2:"  THEN DO:
                    ASSIGN n_char     = ""
                           n_length   = 0
                           n_char     = trim(brstat.tlt.rec_addr2) /* ผู้ขับขี่ 1 */
                           n_length   = LENGTH(n_char)
                           fi_drivgen2  = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"OC2:") - 1))         /*เพศผู้ขับขี้1    */  
                           fi_drivocc2  = TRIM(SUBSTR(n_char,R-INDEX(n_char,"OC2:") + 4,n_length)).  /*อาชีพขับขี่1   */ 
                END.
            END.
            ELSE  ASSIGN fi_drivid2   = ""     fi_driv2     = ""    fi_birth2    = "" fi_drivgen2 = ""  fi_drivocc2 = "".  
            
        END.
        ELSE DO:
            ASSIGN fi_drivid1   = ""     fi_driv1     = ""   fi_birth1    = ""  fi_drivgen1 = ""  fi_drivocc1 = ""
                   fi_drivid2   = ""     fi_driv2     = ""   fi_birth2    = ""  fi_drivgen2 = ""  fi_drivocc2 = "".

        END.
 */       
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_getisp C-Win 
PROCEDURE Proc_getisp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:  Create by A62-0445 Date 01/10/2019       
------------------------------------------------------------------------------*/
/*DEF VAR n_list      AS INT init 0.
DEF VAR n_count     AS INT init 0.
DEF VAR n_agent     AS CHAR FORMAT "x(10)" INIT "".
DEF VAR n_repair    AS CHAR FORMAT "x(10)" init "".
DEF VAR n_dam       AS CHAR FORMAT "x(10)" init "".
DEF VAR n_deatil    AS CHAR FORMAT "x(60)" init "".
DEF VAR nv_damag    AS CHAR FORMAT "x(30)" init "".
DEF VAR nv_repair   AS CHAR FORMAT "x(30)" init "".
DO:
      chitem       = chDocument:Getfirstitem("ConsiderDate").      /*วันที่ปิดเรื่อง*/
      IF chitem <> 0 THEN nv_date = chitem:TEXT. 
      ELSE nv_date = "".

      chitem       = chDocument:Getfirstitem("docno").      /*เลขตรวจสภาพ*/
      IF chitem <> 0 THEN nv_docno = chitem:TEXT. 
      ELSE nv_docno = "".
      
      chitem       = chDocument:Getfirstitem("SurveyClose").    /* สเตตัสปิดเรื่อง */
      IF chitem <> 0 THEN nv_survey  = chitem:TEXT. 
      ELSE nv_survey = "".

      chitem       = chDocument:Getfirstitem("SurveyResult").  /*ผลการตรวจ*/
      IF chitem <> 0 THEN  nv_detail = chitem:TEXT. 
      ELSE nv_detail = "".

      IF nv_detail = "ติดปัญหา" THEN DO:
          chitem       = chDocument:Getfirstitem("DamageC").    /*ข้อมูลการติดปัญหา */
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
              ASSIGN    n_list     = INT(nv_damlist) 
                        nv_damlist = " " + nv_damlist + " รายการ " .
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
                        ASSIGN nv_damdetail = nv_damdetail + STRING(n_count) + "." + nv_damag + " " + nv_repair + " , " .
                        
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
      IF trim(nv_surdata) <> "" THEN  nv_surdata = "ข้อมูลอื่นๆ :"  +  nv_surdata .
      
     /*-- อุปกรณ์เสริม --*/  
      chitem       = chDocument:Getfirstitem("device1").
      IF chitem <> 0 THEN  nv_device = chitem:TEXT. 
      ELSE nv_device = "".
      IF nv_device <> "" THEN DO:
          chitem       = chDocument:Getfirstitem("PricesTotal").  /* ราคารวมอุปกรณ์เสริม */
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
          
          nv_device = "" .
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
          nv_device   = " อุปกรณ์เสริม :" + TRIM(nv_device).
          nv_acctotal = " ราคารวมอุปกรณ์เสริม " + nv_acctotal + " บาท " .

      END.

END.
*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

