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
  wuwqtis2.w :  Import text file from  ICBCTL  to create  new policy   
               Add in table  tlt Quey & Update data before Gen.
  Create  by  :  Ranu I. A63-0161 
  +++++++++++++++++++++++++++++++++++++++++++++++*/
Def  Input  parameter  nv_recidtlt  as  recid  .
Def  var nv_index  as int  init 0.
DEF  VAR nv_chaidrep AS CHAR . /*A57-0262*/
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

/* add by A62-0445  */
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
DEF VAR nv_count     AS INT.
DEF VAR nv_text1     AS CHAR.
DEF VAR nv_text2     AS CHAR.
DEF VAR nv_chktext   AS INT.
/**/
DEF VAR nv_cha_no  AS CHAR.
DEF VAR nv_doc_num AS INT.
DEF VAR nv_licen1  AS CHAR.
DEF VAR nv_licen2  AS CHAR.
DEF VAR nv_surcl   AS CHAR.
DEF VAR nv_docno   AS CHAR.
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
DEF VAR n_list      AS INT init 0.
DEF VAR n_count     AS INT init 0.
DEF VAR n_agent     AS CHAR FORMAT "x(10)" INIT "".
DEF VAR n_repair    AS CHAR FORMAT "x(10)" init "".
DEF VAR n_dam       AS CHAR FORMAT "x(10)" init "".
DEF VAR n_deatil    AS CHAR FORMAT "x(60)" init "".
DEF VAR nv_damag    AS CHAR FORMAT "x(30)" init "".
DEF VAR nv_repair   AS CHAR FORMAT "x(30)" init "".


DEF VAR nv_name      AS CHAR.
DEF VAR nv_datim     AS CHAR.
DEF VAR nv_branch    AS CHAR.
DEF VAR nv_brname    AS CHAR.
DEF VAR nv_pattern   AS CHAR.
DEF VAR nv_model     AS CHAR.
DEF VAR nv_modelcode AS CHAR.
DEF VAR nv_makdes    AS CHAR.
DEF VAR nv_licence1  AS CHAR.
DEF VAR nv_licence2  AS CHAR.
/**/
DEF VAR nv_key1    AS CHAR.
DEF VAR nv_key2    AS CHAR.

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
DEF VAR n_day AS INT INIT 0.
DEF VAR nv_insi AS DECI INIT 0.
DEF VAR nv_provin AS CHAR FORMAT "x(10)" .
DEF VAR nv_key3 AS CHAR FORMAT "x(35)" .

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS fi_policy fi_covtyp fi_polstatus ~
fi_polsystem fi_compol fi_producer fi_agent fi_nottime fi_accno fi_comtotal ~
fi_ins_off fi_vehuse fi_year fi_cc fi_eng_no fi_cha_no fi_licence ~
fi_province fi_covcod fi_comdat fi_comdat72 fi_sumsi fi_gross_amt fi_sckno ~
fi_garage fi_accsor fi_firstname fi_lastname fi_icno fi_addr2 fi_addr1 ~
fi_addr3 fi_addr4 fi_driv1 fi_drivno fi_subspect fi_status fi_remark1 ~
fi_remark2 bu_save bu_exit fi_NCB fi_ton fi_company fi_cartyp fi_deduct ~
fi_ben fi_drivid1 fi_driv2 fi_drivid2 fi_inspno bu_upins fi_insresult ~
fi_userup fi_camp RECT-335 RECT-383 RECT-385 RECT-386 RECT-387 RECT-388 
&Scoped-Define DISPLAYED-OBJECTS fi_policy fi_covtyp fi_type fi_paydate ~
fi_polstatus fi_polsystem fi_compol fi_producer fi_agent fi_nottime ~
fi_accno fi_comtotal fi_ins_off fi_vehuse fi_year fi_cc fi_eng_no fi_cha_no ~
fi_licence fi_province fi_covcod fi_comdat fi_comdat72 fi_sumsi ~
fi_gross_amt fi_sckno fi_garage fi_accsor fi_firstname fi_lastname fi_icno ~
fi_addr2 fi_addr1 fi_addr3 fi_addr4 fi_driv1 fi_drivno fi_subspect ~
fi_status fi_remark1 fi_remark2 fi_ldate fi_ltime fi_trndat fi_userid ~
fi_NCB fi_trndat1 fi_ton fi_company fi_cartyp fi_deduct fi_ben fi_drivid1 ~
fi_driv2 fi_drivid2 fi_inspno fi_insresult fi_userup fi_camp 

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

DEFINE BUTTON bu_upins 
     LABEL "ตรวจสภาพ" 
     SIZE 11 BY 1
     BGCOLOR 13 FGCOLOR 2 FONT 6.

DEFINE VARIABLE fi_accno AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 22.83 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_accsor AS CHARACTER FORMAT "x(150)":U 
     VIEW-AS FILL-IN 
     SIZE 110.5 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_addr1 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 48 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_addr2 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 48.17 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_addr3 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 48 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_addr4 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 48.17 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_agent AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 14.17 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_ben AS CHARACTER FORMAT "X(60)":U 
     VIEW-AS FILL-IN 
     SIZE 31.5 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_camp AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 17.5 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_cartyp AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 27 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_cc AS INTEGER FORMAT ">>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 9.17 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_cha_no AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 23.33 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_comdat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 15.17 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_comdat72 AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 12.83 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_company AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 59.17 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_compol AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 20 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_comtotal AS DECIMAL FORMAT "->>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 15.33 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_covcod AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 6.17 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_covtyp AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 22 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_deduct AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 8.67 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_driv1 AS CHARACTER FORMAT "X(70)":U 
     VIEW-AS FILL-IN 
     SIZE 27.33 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_driv2 AS CHARACTER FORMAT "X(70)":U 
     VIEW-AS FILL-IN 
     SIZE 27.5 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_drivid1 AS CHARACTER FORMAT "X(13)":U 
     VIEW-AS FILL-IN 
     SIZE 27.83 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_drivid2 AS CHARACTER FORMAT "X(13)":U 
     VIEW-AS FILL-IN 
     SIZE 27.67 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_drivno AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 20 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_eng_no AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 26.17 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_firstname AS CHARACTER FORMAT "X(75)":U 
     VIEW-AS FILL-IN 
     SIZE 23.5 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_garage AS CHARACTER FORMAT "X(30)":U INITIAL ? 
     VIEW-AS FILL-IN 
     SIZE 16.67 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_gross_amt AS DECIMAL FORMAT "->>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 19.17 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_icno AS CHARACTER FORMAT "X(13)":U 
     VIEW-AS FILL-IN 
     SIZE 20.33 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_inspno AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 16.5 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_insresult AS CHARACTER FORMAT "X(150)":U 
     VIEW-AS FILL-IN 
     SIZE 107.33 BY .95
     BGCOLOR 15 FGCOLOR 6  NO-UNDO.

DEFINE VARIABLE fi_ins_off AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 23.17 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_lastname AS CHARACTER FORMAT "X(45)":U 
     VIEW-AS FILL-IN 
     SIZE 23.33 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_ldate AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 15.33 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_licence AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 13.5 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_ltime AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 12.17 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_NCB AS CHARACTER FORMAT "X(45)":U 
     VIEW-AS FILL-IN 
     SIZE 7 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_nottime AS CHARACTER FORMAT "X(35)":U 
     VIEW-AS FILL-IN 
     SIZE 29.67 BY .95
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
     SIZE 15.33 BY 1
     BGCOLOR 19 FGCOLOR 6 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_polsystem AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 20 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_producer AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_province AS CHARACTER FORMAT "X(35)":U 
     VIEW-AS FILL-IN 
     SIZE 16.83 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_remark1 AS CHARACTER FORMAT "X(250)":U 
     VIEW-AS FILL-IN 
     SIZE 107.33 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_remark2 AS CHARACTER FORMAT "X(250)":U 
     VIEW-AS FILL-IN 
     SIZE 107.33 BY .86
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_sckno AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 18.33 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_status AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 11.83 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_subspect AS CHARACTER FORMAT "X(150)":U 
     VIEW-AS FILL-IN 
     SIZE 107.33 BY .95
     BGCOLOR 15 FGCOLOR 6  NO-UNDO.

DEFINE VARIABLE fi_sumsi AS INTEGER FORMAT ">>>,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 16.17 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_ton AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 10.17 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_trndat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 15.17 BY 1
     BGCOLOR 10 FGCOLOR 4 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_trndat1 AS DATE FORMAT "99/99/9999":U 
     LABEL "Trndat" 
     VIEW-AS FILL-IN 
     SIZE 14.17 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_type AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 15.33 BY 1
     BGCOLOR 1 FGCOLOR 7 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_userid AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 11 BY 1
     BGCOLOR 10 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_userup AS CHARACTER FORMAT "X(20)":U 
      VIEW-AS TEXT 
     SIZE 10.83 BY 1
     BGCOLOR 19 FGCOLOR 6 FONT 1 NO-UNDO.

DEFINE VARIABLE fi_vehuse AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 35.33 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_year AS CHARACTER FORMAT "X(4)":U INITIAL "0" 
     VIEW-AS FILL-IN 
     SIZE 6.83 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE RECTANGLE RECT-335
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132.67 BY 28
     BGCOLOR 1 FGCOLOR 2 .

DEFINE RECTANGLE RECT-383
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 131 BY 4.14
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-385
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 131 BY 7.19
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-386
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 130.5 BY 13.52
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-387
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 11 BY 1.48
     BGCOLOR 5 .

DEFINE RECTANGLE RECT-388
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 11 BY 1.48
     BGCOLOR 6 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     fi_policy AT ROW 1.43 COL 38.33 COLON-ALIGNED NO-LABEL
     fi_covtyp AT ROW 10.33 COL 75 COLON-ALIGNED NO-LABEL
     fi_type AT ROW 1.33 COL 3.17 NO-LABEL
     fi_paydate AT ROW 25.86 COL 20 COLON-ALIGNED NO-LABEL
     fi_polstatus AT ROW 25.86 COL 52 COLON-ALIGNED NO-LABEL
     fi_polsystem AT ROW 1.43 COL 75.67 COLON-ALIGNED NO-LABEL
     fi_compol AT ROW 1.43 COL 109.33 COLON-ALIGNED NO-LABEL
     fi_producer AT ROW 3.62 COL 77.67 COLON-ALIGNED NO-LABEL
     fi_agent AT ROW 3.57 COL 106.33 COLON-ALIGNED NO-LABEL
     fi_nottime AT ROW 4.67 COL 47.83 COLON-ALIGNED NO-LABEL
     fi_accno AT ROW 4.67 COL 89.67 COLON-ALIGNED NO-LABEL
     fi_comtotal AT ROW 12.43 COL 76.67 COLON-ALIGNED NO-LABEL
     fi_ins_off AT ROW 5.71 COL 18.17 COLON-ALIGNED NO-LABEL
     fi_vehuse AT ROW 8.19 COL 56.17 COLON-ALIGNED NO-LABEL
     fi_year AT ROW 8.14 COL 98.67 COLON-ALIGNED NO-LABEL
     fi_cc AT ROW 9.19 COL 17 COLON-ALIGNED NO-LABEL
     fi_eng_no AT ROW 9.29 COL 56.33 COLON-ALIGNED NO-LABEL
     fi_cha_no AT ROW 9.24 COL 94.67 COLON-ALIGNED NO-LABEL
     fi_licence AT ROW 10.29 COL 17 COLON-ALIGNED NO-LABEL
     fi_province AT ROW 10.29 COL 40.33 COLON-ALIGNED NO-LABEL
     fi_covcod AT ROW 10.33 COL 112.17 COLON-ALIGNED NO-LABEL
     fi_comdat AT ROW 11.38 COL 16.83 COLON-ALIGNED NO-LABEL
     fi_comdat72 AT ROW 12.43 COL 50.83 COLON-ALIGNED NO-LABEL
     fi_sumsi AT ROW 11.33 COL 44.83 COLON-ALIGNED NO-LABEL
     fi_gross_amt AT ROW 11.33 COL 73.17 COLON-ALIGNED NO-LABEL
     fi_sckno AT ROW 12.43 COL 106.67 COLON-ALIGNED NO-LABEL
     fi_garage AT ROW 12.38 COL 16.83 COLON-ALIGNED NO-LABEL
     fi_accsor AT ROW 13.48 COL 16.83 COLON-ALIGNED NO-LABEL
     fi_firstname AT ROW 15.67 COL 17 COLON-ALIGNED NO-LABEL
     fi_lastname AT ROW 15.67 COL 51.33 COLON-ALIGNED NO-LABEL
     fi_icno AT ROW 15.62 COL 83.83 COLON-ALIGNED NO-LABEL
     fi_addr2 AT ROW 16.71 COL 76.67 COLON-ALIGNED NO-LABEL
     fi_addr1 AT ROW 16.71 COL 17 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     fi_addr3 AT ROW 17.71 COL 17 COLON-ALIGNED NO-LABEL
     fi_addr4 AT ROW 17.71 COL 76.67 COLON-ALIGNED NO-LABEL
     fi_driv1 AT ROW 19.81 COL 17.17 COLON-ALIGNED NO-LABEL
     fi_drivno AT ROW 18.76 COL 17 COLON-ALIGNED NO-LABEL
     fi_subspect AT ROW 24.76 COL 17.17 COLON-ALIGNED NO-LABEL
     fi_status AT ROW 19.81 COL 96.67 COLON-ALIGNED NO-LABEL
     fi_remark1 AT ROW 22.86 COL 19.17 NO-LABEL
     fi_remark2 AT ROW 23.81 COL 17.17 COLON-ALIGNED NO-LABEL
     bu_save AT ROW 26.52 COL 110.67
     bu_exit AT ROW 26.52 COL 121.33
     fi_ldate AT ROW 3.57 COL 18.17 COLON-ALIGNED NO-LABEL
     fi_ltime AT ROW 3.57 COL 47.83 COLON-ALIGNED NO-LABEL
     fi_trndat AT ROW 4.62 COL 18.17 COLON-ALIGNED NO-LABEL
     fi_userid AT ROW 25.91 COL 89 COLON-ALIGNED NO-LABEL
     fi_NCB AT ROW 11.33 COL 99 COLON-ALIGNED NO-LABEL
     fi_trndat1 AT ROW 25.91 COL 74.5 COLON-ALIGNED
     fi_ton AT ROW 9.24 COL 34.17 COLON-ALIGNED NO-LABEL
     fi_company AT ROW 5.71 COL 52.83 COLON-ALIGNED NO-LABEL WIDGET-ID 2
     fi_cartyp AT ROW 8.14 COL 16.83 COLON-ALIGNED NO-LABEL WIDGET-ID 6
     fi_deduct AT ROW 11.33 COL 117.17 COLON-ALIGNED NO-LABEL WIDGET-ID 10
     fi_ben AT ROW 18.71 COL 56 COLON-ALIGNED NO-LABEL WIDGET-ID 16
     fi_drivid1 AT ROW 19.76 COL 59.83 COLON-ALIGNED NO-LABEL WIDGET-ID 20
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1.67 ROW 1.1
         SIZE 133 BY 28.24
         BGCOLOR 3 FGCOLOR 1 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     fi_driv2 AT ROW 20.86 COL 17 COLON-ALIGNED NO-LABEL WIDGET-ID 24
     fi_drivid2 AT ROW 20.81 COL 59.83 COLON-ALIGNED NO-LABEL WIDGET-ID 28
     fi_inspno AT ROW 20.81 COL 96.5 COLON-ALIGNED NO-LABEL WIDGET-ID 34
     bu_upins AT ROW 20.76 COL 115.17 WIDGET-ID 38
     fi_insresult AT ROW 21.86 COL 17 COLON-ALIGNED NO-LABEL WIDGET-ID 44
     fi_userup AT ROW 27.14 COL 89 COLON-ALIGNED NO-LABEL WIDGET-ID 40
     fi_camp AT ROW 18.71 COL 100.17 COLON-ALIGNED NO-LABEL WIDGET-ID 48
     " การซ่อม :":35 VIEW-AS TEXT
          SIZE 9.5 BY .95 AT ROW 12.38 COL 8.17
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " ปีรถ :":35 VIEW-AS TEXT
          SIZE 6.5 BY .95 AT ROW 8.14 COL 94
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " ชื่อ :":30 VIEW-AS TEXT
          SIZE 5 BY .95 AT ROW 15.71 COL 13.67
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "ผู้รับผลประโยชน์ :":30 VIEW-AS TEXT
          SIZE 17 BY .95 AT ROW 18.71 COL 40.5 WIDGET-ID 18
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " ทุนประกัน :":35 VIEW-AS TEXT
          SIZE 10.83 BY .95 AT ROW 11.38 COL 35
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " เลขตัวถัง :":20 VIEW-AS TEXT
          SIZE 11 BY .95 AT ROW 9.29 COL 85.5
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "Dedeuct :":35 VIEW-AS TEXT
          SIZE 10 BY .95 AT ROW 11.33 COL 108.83
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " เลขเครื่อง :":35 VIEW-AS TEXT
          SIZE 10.5 BY .95 AT ROW 9.29 COL 47.5
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "วันที่ออกงาน :" VIEW-AS TEXT
          SIZE 12 BY 1 AT ROW 25.86 COL 8.67
          BGCOLOR 19 FGCOLOR 4 FONT 6
     "Update by :" VIEW-AS TEXT
          SIZE 9.67 BY 1 AT ROW 27.14 COL 80.83 WIDGET-ID 42
          BGCOLOR 19 FGCOLOR 4 FONT 1
     "ผลตรวจสภาพ :":30 VIEW-AS TEXT
          SIZE 14 BY .95 AT ROW 21.86 COL 4.5 WIDGET-ID 46
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "ISP No:" VIEW-AS TEXT
          SIZE 7.83 BY .91 AT ROW 20.81 COL 90.33 WIDGET-ID 36
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "เลขที่สัญญา :":30 VIEW-AS TEXT
          SIZE 11.5 BY .91 AT ROW 4.67 COL 80
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "IC No :":30 VIEW-AS TEXT
          SIZE 7.5 BY .91 AT ROW 15.67 COL 77.83
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " ชื่อผู้แจ้ง :":30 VIEW-AS TEXT
          SIZE 10.33 BY .95 AT ROW 5.71 COL 9
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " เลขที่ใบขับขี่ :":30 VIEW-AS TEXT
          SIZE 13 BY .95 AT ROW 19.76 COL 48.33 WIDGET-ID 22
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "อุปกรณ์ตกแต่ง :":30 VIEW-AS TEXT
          SIZE 14.33 BY .91 AT ROW 13.43 COL 3.5
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "ประเภทรถ :":30 VIEW-AS TEXT
          SIZE 11 BY .95 AT ROW 8.14 COL 6.83 WIDGET-ID 8
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " เบอร์ พรบ  :":35 VIEW-AS TEXT
          SIZE 12.67 BY .95 AT ROW 1.43 COL 98
          BGCOLOR 2 FGCOLOR 7 FONT 6
     " จังหวัด :":30 VIEW-AS TEXT
          SIZE 9.17 BY .95 AT ROW 10.29 COL 33
          BGCOLOR 19 FGCOLOR 0 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1.67 ROW 1.1
         SIZE 133 BY 28.24
         BGCOLOR 3 FGCOLOR 1 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     " Remark :":30 VIEW-AS TEXT
          SIZE 10 BY .86 AT ROW 22.76 COL 8.33
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " วันที่คุ้มครอง :":35 VIEW-AS TEXT
          SIZE 13.33 BY .95 AT ROW 11.19 COL 4.33
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "เวลาส่งงาน :":35 VIEW-AS TEXT
          SIZE 12.83 BY .95 AT ROW 4.71 COL 36.67
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " ข้อมูลลูกค้า" VIEW-AS TEXT
          SIZE 11.5 BY 1 AT ROW 14.62 COL 2.33
          BGCOLOR 3 FGCOLOR 7 FONT 6
     "NCB :":30 VIEW-AS TEXT
          SIZE 5.67 BY .95 AT ROW 11.33 COL 95.17
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "Status :" VIEW-AS TEXT
          SIZE 7.83 BY .91 AT ROW 19.81 COL 90.5
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "น้ำหนัก:" VIEW-AS TEXT
          SIZE 6.83 BY .91 AT ROW 9.24 COL 29.17
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " ข้อรถและการประกันภัย" VIEW-AS TEXT
          SIZE 21 BY .91 AT ROW 7.05 COL 2
          BGCOLOR 3 FGCOLOR 7 FONT 6
     "เลขสติ๊กเกอร์ :":30 VIEW-AS TEXT
          SIZE 12.67 BY .95 AT ROW 12.43 COL 95.67
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "Producer code :":30 VIEW-AS TEXT
          SIZE 16 BY .95 AT ROW 3.62 COL 63.33
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "Status Policy :" VIEW-AS TEXT
          SIZE 14 BY 1 AT ROW 25.86 COL 39.17
          BGCOLOR 19 FGCOLOR 4 FONT 6
     " ทะเบียน :":30 VIEW-AS TEXT
          SIZE 10 BY .95 AT ROW 10.24 COL 8.5
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " เบี้ยรวม72 :":35 VIEW-AS TEXT
          SIZE 12 BY .91 AT ROW 12.43 COL 66.17
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " วันที่คุ้มครอง 72 :":35 VIEW-AS TEXT
          SIZE 16.5 BY .95 AT ROW 12.43 COL 36.17
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " วันที่โหลด  :":30 VIEW-AS TEXT
          SIZE 12 BY .95 AT ROW 3.67 COL 7.5
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "Campaign :" VIEW-AS TEXT
          SIZE 11 BY .91 AT ROW 18.76 COL 90.83 WIDGET-ID 50
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "ประเภทประกันภัย :" VIEW-AS TEXT
          SIZE 17 BY .91 AT ROW 10.33 COL 59.67
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " เบี้ยรวม70 :":30 VIEW-AS TEXT
          SIZE 11.5 BY .95 AT ROW 11.33 COL 63.5
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " ข้อมูลการแจ้งงาน" VIEW-AS TEXT
          SIZE 17 BY .81 AT ROW 2.67 COL 2
          BGCOLOR 3 FGCOLOR 7 FONT 6
     " เลขที่ใบขับขี่ :":30 VIEW-AS TEXT
          SIZE 13 BY .95 AT ROW 20.81 COL 48.33 WIDGET-ID 30
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "ความคุ้มครอง :":30 VIEW-AS TEXT
          SIZE 13.67 BY .91 AT ROW 10.33 COL 100.17
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "ื กรมธรรม์ใหม่  :":35 VIEW-AS TEXT
          SIZE 15 BY .95 AT ROW 1.43 COL 62.17
          BGCOLOR 2 FGCOLOR 7 FONT 6
     "  ที่อยู่ 3 :":35 VIEW-AS TEXT
          SIZE 9 BY .95 AT ROW 17.67 COL 9.5
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " ที่อยู่หน้าตาราง1 :":30 VIEW-AS TEXT
          SIZE 16 BY .95 AT ROW 16.76 COL 2.5
          BGCOLOR 19 FGCOLOR 2 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1.67 ROW 1.1
         SIZE 133 BY 28.24
         BGCOLOR 3 FGCOLOR 1 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     " เวลาโหลด  :":30 VIEW-AS TEXT
          SIZE 12.67 BY .95 AT ROW 3.57 COL 36.83
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " นามสกุล :":30 VIEW-AS TEXT
          SIZE 9.67 BY .95 AT ROW 15.67 COL 43.33
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " ยี่ห้อ/รุ่นรถ :":30 VIEW-AS TEXT
          SIZE 11.5 BY .95 AT ROW 8.19 COL 46.5
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " Agent code :":30 VIEW-AS TEXT
          SIZE 13 BY .95 AT ROW 3.57 COL 95
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " กรมธรรม์เดิม  :":35 VIEW-AS TEXT
          SIZE 15 BY .95 AT ROW 1.43 COL 24.83
          BGCOLOR 4 FGCOLOR 7 FONT 6
     " ขนาดซีซี :":30 VIEW-AS TEXT
          SIZE 10.5 BY .95 AT ROW 9.19 COL 7.83
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "  ที่อยู่ 2 :":30 VIEW-AS TEXT
          SIZE 9.5 BY .91 AT ROW 16.71 COL 68.5
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "วันที่ไฟล์แจ้งงาน :" VIEW-AS TEXT
          SIZE 16.5 BY .95 AT ROW 4.67 COL 3
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " ผู้ขับขี่ 1 :":30 VIEW-AS TEXT
          SIZE 9.5 BY .95 AT ROW 19.81 COL 9.17
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " ผู้ขับขี่ 2 :":30 VIEW-AS TEXT
          SIZE 9.5 BY .95 AT ROW 20.81 COL 8.83 WIDGET-ID 32
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "  ที่อยู่ 4 :":30 VIEW-AS TEXT
          SIZE 9.5 BY .91 AT ROW 17.71 COL 68.5
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "ชื่อบริษัท:":30 VIEW-AS TEXT
          SIZE 9.5 BY .95 AT ROW 5.71 COL 44.5 WIDGET-ID 4
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "Supspect :":30 VIEW-AS TEXT
          SIZE 11 BY .95 AT ROW 24.76 COL 7.67
          BGCOLOR 19 FGCOLOR 12 FONT 6
     "ระบุผู้ขับขี่ :" VIEW-AS TEXT
          SIZE 10.5 BY .91 AT ROW 18.76 COL 8
          BGCOLOR 19 FGCOLOR 2 FONT 6
     RECT-335 AT ROW 1.1 COL 1.17
     RECT-383 AT ROW 3.1 COL 2
     RECT-385 AT ROW 7.62 COL 2
     RECT-386 AT ROW 15.29 COL 2.17
     RECT-387 AT ROW 26.33 COL 109 WIDGET-ID 12
     RECT-388 AT ROW 26.33 COL 120 WIDGET-ID 14
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
         TITLE              = "Update Data SCB RENEW"
         HEIGHT             = 28.38
         WIDTH              = 134.17
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
/* SETTINGS FOR FILL-IN fi_ldate IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_ltime IN FRAME fr_main
   NO-ENABLE                                                            */
ASSIGN 
       fi_nottime:READ-ONLY IN FRAME fr_main        = TRUE.

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
ON END-ERROR OF C-Win /* Update Data SCB RENEW */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Update Data SCB RENEW */
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
                    /* fi_type       = IF brstat.tlt.flag = "N" THEN "NEW" ELSE "RENEW"
                     fi_ldate      = brstat.tlt.entdat               /* วันที่โหลด */                          
                     fi_ltime      = brstat.tlt.enttim               /* เวลาโหลด   */                          
                     fi_trndat1    = brstat.tlt.trndat               /* วันที่จากหน้าจอ*/
                     fi_trndat     = brstat.tlt.datesent             /* วันที่ไฟล์แจ้งงาน */ 
                     fi_nottime    = brstat.tlt.trntim   */            /* เวลาแจ้งงาน*/
                     brstat.tlt.safe2         = trim(fi_accno )   /*เลขที่สัญญา   */ 
                     brstat.tlt.nor_usr_ins   = trim(fi_ins_off)   /*ผู้แจ้ง       */
                     brstat.tlt.colorcod      = trim(fi_covtyp)   /*ประเภทรถประกัน*/ 
                     brstat.tlt.old_cha       = trim(fi_cartyp)   /* ประเภทรถ */
                     brstat.tlt.comp_usr_tlt  = trim(fi_covcod)   /*ประเภทความคุ้มครอง   */   
                     brstat.tlt.gendat        = fi_comdat   /*วันที่เริ่มคุ้มครอง  */  
                     /* ชื่อ */  
                     brstat.tlt.ins_name      = TRIM(fi_firstname) + " " + TRIM(fi_lastname)
                     brstat.tlt.ins_addr5     = trim(fi_icno)      /*IDCARD              */   
                     brstat.tlt.nor_usr_tlt   = trim(fi_company)   /* ชื่อบริษัท */
                     brstat.tlt.ins_addr1     = trim(fi_addr1)     /*ที่อยู่ลูกค้า */          
                     brstat.tlt.ins_addr2     = trim(fi_addr2)     
                     brstat.tlt.ins_addr3     = trim(fi_addr3)     
                     brstat.tlt.ins_addr4     = trim(fi_addr4)     
                     brstat.tlt.endno         = trim(fi_drivno)         /* * ระบุผู้ขับขี่ */
                     brstat.tlt.dri_no1       = trim(fi_drivid1 )         /* * เลขใบขับขี่ 1 */ 
                     brstat.tlt.model         = trim(fi_vehuse)         /* *รุ่น        */
                     brstat.tlt.eng_no        = trim(fi_eng_no)         /* *เลขเครื่อง  */          
                     brstat.tlt.cha_no        = trim(fi_cha_no)         /* *เลขถัง      */ 
                     brstat.tlt.cc_weight     = fi_cc           /* *ขนาดเครื่อง */ 
                     brstat.tlt.OLD_eng       = trim(fi_ton)   /* น้ำหนักรถ*/
                     brstat.tlt.lince2        = trim(fi_year)           /* *ปี          */ 
                     brstat.tlt.lince1        = trim(fi_licence)       /* *เลขทะเบียน   */                 
                     brstat.tlt.lince3        = trim(fi_province)       /* *จังหวัด    */ 
                     brstat.tlt.stat          = trim(fi_garage)       /* *สถานที่ซ่อม */ 
                     brstat.tlt.nor_coamt     = fi_sumsi                        /*ทุนประกัน   */ 
                     brstat.tlt.comp_coamt    = fi_gross_amt             /*เบี้ยรวม กธ.  */ 
                     brstat.tlt.comp_effdat   = fi_comdat72      
                     brstat.tlt.comp_grprm    = fi_comtotal      /*เบี้ยรวม พรบ. */  
                     brstat.tlt.comp_sck      = trim(fi_sckno)               /* สติ๊กเกอร์ */ 
                     brstat.tlt.rec_addr5     = "NCB:" + TRIM(fi_ncb) +       /* ncb */
                                                " DD:" + TRIM(fi_deduct)              /*Deduct */ 
                     brstat.tlt.safe1         = trim(fi_accsor)                 /*อุปกรณ์ตกแต่ง*/ 
                     brstat.tlt.filler2       = trim(fi_remark1) + " " + TRIM(fi_remark2)   
                     brstat.tlt.filler1       = trim(fi_policy)    /*เบอร์ต่ออายุ*/ 
                     brstat.tlt.lotno         = trim(fi_status)    /* status */
                     brstat.tlt.expotim       = trim(fi_subspect)  /* suspect */
                     brstat.tlt.comp_sub      = trim(fi_producer)           
                     brstat.tlt.comp_noti_ins = trim(fi_agent)                  
                     brstat.tlt.nor_noti_ins  = trim(fi_polsystem)        /*เบอร์ใหม่ */            
                     brstat.tlt.comp_pol      = trim(fi_compol)           /*เบอร์ พรบ.  */ 
                     brstat.tlt.dri_name1     = trim(fi_driv1)     /*  ชื่อผู้ขับขี่ 1 */
                     brstat.tlt.dri_name2     = trim(fi_driv2)     /*  ชื่อผู้ขับขี่ 2 */ 
                     brstat.tlt.dri_no2       = trim(fi_drivid2)   /* เลขใบขับขี่ 2 */
                     brstat.tlt.rec_addr1     = "ISP:" + trim(fi_inspno) + " " + /* isp no */
                                                "RES:" + trim(fi_insresult) /* ผลตรวจสภาพ */
                     brstat.tlt.rec_addr2     = "BEN:" + trim(fi_ben)  + " " +      /* ผู้รับผลประโยชน์ */
                                                "CAM:" + TRIM(fi_camp)   /* แคมเปญ */
                     brstat.tlt.rec_addr3     = USERID(LDBNAME(1))  .      /* User ID ที่แก้ไขข้อมูล */
                     /*fi_paydate    = brstat.tlt.dat_ins_noti */                             /*วันที่ออกงาน */
                    /*fi_userid     = brstat.tlt.usrid  */            /*User Load Data */
                     /*fi_polstatus  = IF brstat.tlt.releas = "NO" THEN "ยังไม่ออกงาน" ELSE IF INDEX(brstat.tlt.releas,"Cancel") <> 0 THEN "ยกเลิก" ELSE "ออกงานแล้ว"*/
                      
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


&Scoped-define SELF-NAME bu_upins
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_upins C-Win
ON CHOOSE OF bu_upins IN FRAME fr_main /* ตรวจสภาพ */
DO:
DEF VAR nv_expdat AS CHAR FORMAT "x(15)".
DEF VAR nv_fname  AS CHAR FORMAT "x(50)" .
DEF VAR nv_lname  AS CHAR FORMAT "x(50)".

    ASSIGN              
        nv_year      = STRING(YEAR(TODAY))
        nv_year      = SUBSTR(nv_year,3,2) 
        /* real database */
        NotesServer  = "Safety_NotesServer/Safety"
        NotesApp     = "safety\uw\inspect" + nv_year + ".nsf"
        /**/
        /* test database 
        NotesServer  = ""
        NotesApp     = "D:\Lotus\Notes\Data\inspect" + nv_year + ".nsf" */

        NotesView    = "chassis_no" /* วิวซ่อนของเลขตัวถัง */ 
        nv_chkdoc    = NO             
        /*nv_msgbox    = ""*/
        nv_name      = ""
        nv_datim     = ?
        nv_branch    = ""
        nv_brname    = ""
        nv_pattern   = ""
        nv_count     = 0
        nv_text1     = ""
        nv_text2     = ""
        nv_chktext   = 0
        nv_model     = ""
        nv_modelcode = ""
        nv_makdes    = ""
        nv_licence1  = ""
        nv_licence2  = ""
        nv_provin    = "" 
        nv_key1      = "" 
        nv_key2      = "" 
        nv_key3      = "" 
        nv_fname     = ""
        nv_lname     = ""
        nv_expdat    = ""
        nv_lname     = trim(SUBSTR(brstat.tlt.ins_name,R-INDEX(brstat.tlt.ins_name," ") + 1))
        nv_fname     = trim(SUBSTR(brstat.tlt.ins_name,1,LENGTH(brstat.tlt.ins_name) - LENGTH(nv_lname) - 1 ))
        nv_fname     = trim(SUBSTR(nv_fname,R-INDEX(nv_fname," ")))
        nv_expdat    = STRING(brstat.tlt.gendat,"99/99/9999")
        nv_expdat    = SUBSTR(nv_expdat,1,6) + STRING(INT(SUBSTR(nv_expdat,7,4)) + 1) 
        nv_cha_no    = TRIM(brstat.tlt.cha_no).
                                                                                                                                           
    nv_licence1 = trim(brstat.tlt.lince1).
    
    IF TRIM(nv_licence1) = ""
    OR TRIM(nv_cha_no)   = "" THEN DO:
        MESSAGE "ทะเบียนรถ หรือ เลขตัวถัง เป็นค่าว่าง" SKIP
                "กรุณาระบุข้อมูลให้ครบถ้วน !" 
        VIEW-AS ALERT-BOX ERROR.
        RETURN NO-APPLY.
    END.

    IF TRIM(brstat.tlt.lince3) <> "" THEN DO:
        FIND FIRST brstat.insure USE-INDEX Insure05   WHERE   /*use-index fname */
                brstat.insure.compno = "999" AND 
                brstat.insure.FName  = TRIM(brstat.tlt.lince3) NO-LOCK NO-WAIT NO-ERROR.
            IF AVAIL brstat.insure THEN  ASSIGN nv_provin = brstat.Insure.LName.
            ELSE ASSIGN nv_provin = TRIM(brstat.tlt.lince3).
    END.
    
    nv_licence2 = trim(nv_licence1) .
    IF trim(nv_licence2) <> "" THEN DO:
       ASSIGN nv_licence2 = REPLACE(nv_licence2," ","").

       IF INDEX("0123456789",SUBSTR(nv_licence2,1,1)) <> 0 THEN DO:
          IF LENGTH(nv_licence2) = 4 THEN 
             ASSIGN nv_Pattern = "yxx-y-xx"
                    nv_licence2    = SUBSTR(nv_licence2,1,3) + " " + SUBSTR(nv_licence2,4,1).
          ELSE IF LENGTH(nv_licence2) = 5 THEN
              ASSIGN nv_Pattern = "yxx-yy-xx"
                     nv_licence2    = SUBSTR(nv_licence2,1,3) + " " + SUBSTR(nv_licence2,4,2).
          ELSE IF LENGTH(nv_licence2) = 6 THEN DO:
              IF INDEX("0123456789",SUBSTR(nv_licence2,2,1)) <> 0 THEN
                  ASSIGN nv_Pattern = "yy-yyyy-xx"
                         nv_licence2    = SUBSTR(nv_licence2,1,2) + " " + SUBSTR(nv_licence2,3,4).
              ELSE IF INDEX("0123456789",SUBSTR(nv_licence2,3,1)) <> 0 THEN
                  ASSIGN nv_Pattern = "yx-yyyy-xx"
                         nv_licence2    = SUBSTR(nv_licence2,1,2) + " " + SUBSTR(nv_licence2,3,4).
              ELSE 
                  ASSIGN nv_Pattern = "yxx-yyy-xx"
                         nv_licence2    = SUBSTR(nv_licence2,1,3) + " " + SUBSTR(nv_licence2,4,3). 
          END.
          ELSE 
              ASSIGN nv_Pattern = "yxx-yyyy-xx"
                     nv_licence2    = SUBSTR(nv_licence2,1,3) + " " + SUBSTR(nv_licence2,4,4).
       END.
       ELSE DO:
           IF LENGTH(nv_licence2) = 3 THEN 
             ASSIGN nv_Pattern = "xx-y-xx"
                    nv_licence2    = SUBSTR(nv_licence2,1,2) + " "  + SUBSTR(nv_licence2,3,1) .
           ELSE IF LENGTH(nv_licence2) = 4 THEN
              ASSIGN nv_Pattern = "xx-yy-xx"
                     nv_licence2    = SUBSTR(nv_licence2,1,2) + " " + SUBSTR(nv_licence2,3,2) .
           ELSE IF LENGTH(nv_licence2) = 6 THEN
              IF INDEX("0123456789",SUBSTR(nv_licence2,3,1)) <> 0 THEN
              ASSIGN nv_Pattern = "xx-yyyy-xx" 
                     nv_licence2    = SUBSTR(nv_licence2,1,2) + " " + SUBSTR(nv_licence2,3,4) .
              ELSE ASSIGN nv_Pattern = "xxx-yyy-xx" 
                     nv_licence2    = SUBSTR(nv_licence2,1,2) + " " + SUBSTR(nv_licence2,3,4) .
           ELSE IF LENGTH(nv_licence2) = 5 THEN DO:
               IF INDEX("0123456789",SUBSTR(nv_licence2,2,1)) <> 0 THEN
                  ASSIGN nv_Pattern = "x-yyyy-xx"
                         nv_licence2    = SUBSTR(nv_licence2,1,1) + " " + SUBSTR(nv_licence2,2,4).
               ELSE 
                  ASSIGN nv_Pattern = "xx-yyy-xx" 
                         nv_licence2    = SUBSTR(nv_licence2,1,2) + " " + SUBSTR(nv_licence2,3,3).
           END.
       END.
    END.
    
    CREATE "Notes.NotesSession" chSession.                              
    CREATE "Notes.NotesUIWorkSpace" chWorkSpace.    
    chDatabase = chSession:GetDatabase(NotesServer,NotesApp).    
    
    IF chDatabase:isOpen = NO THEN DO: 
        MESSAGE "Can not open Database !" VIEW-AS ALERT-BOX.
        RETURN NO-APPLY.
    END.
    ELSE DO: 
       chName   = chSession:CreateName(chSession:UserName).        
        nv_name  = chName:Abbreviated.
        nv_datim = STRING(TODAY,"99/99/9999") + " " + STRING(TIME,"HH:MM:SS").
       
        /* nv_brname */
        FIND FIRST sicsyac.xmm600                               
             WHERE sicsyac.xmm600.acno = trim(brstat.tlt.comp_sub)  NO-LOCK NO-ERROR.
        IF AVAIL sicsyac.xmm600 THEN nv_brname = sicsyac.xmm600.NAME.
        /*----------*/
        
        /* Check Record Duplication */        
        chWorkspace:OpenDatabase(NotesServer,NotesApp,NotesView,"",FALSE,FALSE).
        chView = chDatabase:GetView(NotesView).        

        IF VALID-HANDLE(chView) = NO THEN DO:
            nv_chkdoc = NO.
            MESSAGE "Can not Connect View !" VIEW-AS ALERT-BOX.
        END.
        ELSE DO:                
            chViewNavigator = chView:CreateViewNavFromCategory(nv_cha_no).            
            nv_doc_num      = chViewNavigator:COUNT.      
                                            
            IF nv_doc_num = 0 THEN DO:                
                nv_chkdoc = YES.
            END.                
            ELSE DO:                                                  
                chViewEntry = chViewNavigator:GetFirstDocument.
                IF VALID-HANDLE(chViewEntry) = NO THEN 
                    nv_chkdoc  = YES.                                                                      
                ELSE chDocument = chViewEntry:Document. 

                loop_chkrecord:
                REPEAT:
                    IF VALID-HANDLE(chDocument) = NO THEN DO:
                        nv_chkdoc = YES.
                        LEAVE loop_chkrecord.
                    END.
                    ELSE DO:                    
                        nv_licen1 = chDocument:GetFirstItem("LicenseNo_1"):TEXT.
                        nv_licen2 = chDocument:GetFirstItem("LicenseNo_2"):TEXT.  
          
                        nv_key1   = nv_licen1 + IF nv_licen2 = "" THEN "" ELSE " " + nv_licen2. /* Notes */
                        nv_key3   = nv_licence1 + " " + nv_provin .          /* PM */

                        IF INDEX(nv_key1," ") <> 0 THEN nv_key1 = REPLACE(nv_key1," ","") .
                        IF INDEX(nv_key3," ") <> 0 THEN nv_key3 = REPLACE(nv_key3," ","") .
                        
                        IF nv_key1 = nv_key3 THEN DO:
                            
                            chitem       = chDocument:Getfirstitem("SurveyClose").    /* สเตตัสปิดเรื่อง */
                            IF chitem <> 0 THEN nv_surcl   = chitem:TEXT. 
                            ELSE nv_surcl  = "".
                           
                            IF nv_surcl = "" THEN DO:                            
                                nv_docno  = chDocument:GetFirstItem("docno"):TEXT.
                                nv_chkdoc = NO.
                                /*MESSAGE "มีข้อมูลเลขตัวถังกับเลขทะเบียนในกล่อง ยังไม่ปิดเรื่อง " + nv_docno VIEW-AS ALERT-BOX.*/
                                LEAVE loop_chkrecord.
                            END.
                            ELSE DO:
                                
                                chitem       = chDocument:Getfirstitem("ConsiderDate").      /*วันที่ปิดเรื่อง*/
                                IF chitem <> 0 THEN nv_date = chitem:TEXT. 
                                ELSE nv_date = "".
                                nv_docno  = chDocument:GetFirstItem("docno"):TEXT.
                                /*MESSAGE  "มีข้อมูลเลขตัวถังกับเลขทะเบียนในกล่อง ปิดเรื่องแล้ว " + nv_docno VIEW-AS ALERT-BOX.*/
                                nv_chkdoc = NO.
                                LEAVE loop_chkrecord.
                            END.
                        END.
                        ELSE DO:
                            chViewEntry = chViewNavigator:GetNextDocument(chViewEntry). 
                            IF VALID-HANDLE(chViewEntry) = NO THEN DO:                 
                                nv_chkdoc = YES.                                       
                                LEAVE loop_chkrecord.                                  
                            END.                                                       
                            ELSE DO:                                                   
                                chDocument = chViewEntry:Document.                     
                                NEXT loop_chkrecord.                                   
                            END. 
                        END.
                    END. /*  else  */
                END. /* end repeate */
            END.  
            /* End Check */
                
            IF nv_chkdoc = NO THEN DO:
                ASSIGN 
                   nv_surdata  = "" 
                   nv_damlist  = "" 
                   nv_damage   = "" 
                   nv_detail   = "" 
                   nv_device   = "" 
                   nv_acctotal = "" .
                IF nv_surcl <> "" THEN  RUN proc_getisp.
                IF nv_docno <> ""  THEN DO:
                     ASSIGN 
                     fi_inspno    =  trim(nv_docno) 
                     fi_insresult = trim(nv_detail + " " + nv_damage + " " + nv_damlist + " " + nv_damdetail + " " + nv_device) .
                                                   /*+ " " + nv_surdata + " " + nv_device + " " + nv_acctotal*/   /* ผลตรวจสภาพ*/
                END.
                /*RELEASE brstat.tlt. */       
                
            END.
            ELSE DO:
                
                chDocument = chDatabase:CreateDocument.
                ASSIGN
                    chDocument:FORM        = "Inspection"                        
                    chDocument:createdBy   = nv_name                             
                    chDocument:createdOn   = nv_datim                            
                    chDocument:dateS       = brstat.tlt.gendat                            
                    chDocument:dateE       = nv_expdat                           
                    chDocument:ReqType_sub = "ลูกค้า/ตัวแทน/นายหน้าเป็นผู้ส่งรูปตรวจสภาพ"
                    chDocument:BranchReq   = "Business Unit 3"                           
                    chDocument:Tname       = "บุคคล"                             
                    chDocument:Fname       = nv_fname                         
                    chDocument:Lname       = nv_lname                        
                    chDocument:phone1      = ""    
                    chDocument:PolicyNo    = ""                          
                    chDocument:agentCode   = trim(brstat.tlt.comp_sub)                         
                    chDocument:agentName   = nv_brname                           
                    chDocument:Premium     = brstat.tlt.comp_coamt                          
                    chDocument:model       = IF index(brstat.tlt.model,"/") <> 0 THEN SUBSTR(brstat.tlt.model,1,INDEX(brstat.tlt.model,"/") - 1 ) ELSE TRIM(brstat.tlt.model)                     
                    chDocument:modelCode   = IF index(brstat.tlt.model,"/") <> 0 THEN SUBSTR(brstat.tlt.model,R-INDEX(brstat.tlt.model,"/") + 1 ) ELSE ""                         
                    chDocument:Year        = brstat.tlt.lince2                            
                    chDocument:carCC       = nv_cha_no                           
                    chDocument:LicenseType = "รถเก๋ง/กระบะ/บรรทุก"               
                    chDocument:PatternLi1  = nv_pattern                          
                    chDocument:LicenseNo_1 = nv_licence1                       
                    chDocument:LicenseNo_2 = nv_provin 
                    chDocument:garage      = TRIM(brstat.tlt.stat)
                    chDocument:App         = 0                                   
                    chDocument:Chk         = 0                                   
                    chDocument:StList      = 0                                   
                    chDocument:stHide      = 0                                   
                    chDocument:SendTo      = ""                                  
                    chDocument:SendCC      = ""                                  
                    chDocument:SendClose   = ""
                    chDocument:SurveyClose = ""                    
                    chDocument:docno       = "".       
            
                /*chDocument:SAVE(TRUE,FALSE).*/ 
                chDocument:SAVE(TRUE,TRUE).  
                chWorkSpace:ViewRefresh.  
                chUIDocument = chWorkSpace:CurrentDocument.                                         
                chUIDocument = chWorkSpace:EditDocument(FALSE,chDocument) NO-ERROR.
            END.                                        
        END.
    END.
    DISP fi_inspno fi_insresult WITH FRAME fr_main.
    MESSAGE " Check Data Inpection complete " VIEW-AS ALERT-BOX.

    RELEASE OBJECT chSession       NO-ERROR.
    RELEASE OBJECT chWorkSpace     NO-ERROR.
    RELEASE OBJECT chName          NO-ERROR.
    RELEASE OBJECT chDatabase      NO-ERROR.
    RELEASE OBJECT chView          NO-ERROR.
    RELEASE OBJECT chViewEntry     NO-ERROR.    
    RELEASE OBJECT chViewNavigator NO-ERROR.
    RELEASE OBJECT chDocument      NO-ERROR.
    RELEASE OBJECT chUIDocument    NO-ERROR.    
    
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


&Scoped-define SELF-NAME fi_accsor
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_accsor C-Win
ON LEAVE OF fi_accsor IN FRAME fr_main
DO:
    fi_accsor = INPUT fi_accsor .
    DISP fi_accsor WITH FRAM fr_main.
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


&Scoped-define SELF-NAME fi_ben
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_ben C-Win
ON LEAVE OF fi_ben IN FRAME fr_main
DO:
    fi_ben = INPUT fi_ben .
    DISP fi_ben WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_camp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_camp C-Win
ON LEAVE OF fi_camp IN FRAME fr_main
DO:
  fi_camp = INPUT fi_camp .
    DISP fi_camp WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_cartyp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_cartyp C-Win
ON LEAVE OF fi_cartyp IN FRAME fr_main
DO:
  fi_cartyp = INPUT fi_cartyp .
  DISP fi_cartyp WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_cc
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_cc C-Win
ON LEAVE OF fi_cc IN FRAME fr_main
DO:
  fi_CC  =  Input  fi_CC.
  Disp  fi_CC with frame  fr_main.
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


&Scoped-define SELF-NAME fi_comdat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_comdat C-Win
ON LEAVE OF fi_comdat IN FRAME fr_main
DO:
  fi_comdat = INPUT fi_comdat.
  DISP fi_comdat WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_comdat72
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_comdat72 C-Win
ON LEAVE OF fi_comdat72 IN FRAME fr_main
DO:
  fi_comdat72 = INPUT fi_comdat72.
  DISP fi_comdat72 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_company
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_company C-Win
ON LEAVE OF fi_company IN FRAME fr_main
DO:
  fi_company = INPUT fi_company .
  DISP fi_company WITH FRAM fr_main.
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


&Scoped-define SELF-NAME fi_covtyp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_covtyp C-Win
ON LEAVE OF fi_covtyp IN FRAME fr_main
DO:
    fi_covtyp = INPUT fi_covtyp.
    DISP fi_covtyp WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_deduct
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_deduct C-Win
ON LEAVE OF fi_deduct IN FRAME fr_main
DO:
    /*A60-0263*/
    fi_deduct = INPUT fi_deduct .
    DISP fi_deduct WITH FRAM fr_main.
     /*A60-0263*/
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_driv1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_driv1 C-Win
ON LEAVE OF fi_driv1 IN FRAME fr_main
DO:
    fi_driv1 = INPUT fi_driv1 .
    DISP fi_driv1 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_driv2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_driv2 C-Win
ON LEAVE OF fi_driv2 IN FRAME fr_main
DO:
    fi_driv2 = INPUT fi_driv2 .
    DISP fi_driv2 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_drivid1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_drivid1 C-Win
ON LEAVE OF fi_drivid1 IN FRAME fr_main
DO:
    fi_drivid1 = INPUT fi_drivid1 .
    DISP fi_drivid1 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_drivid2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_drivid2 C-Win
ON LEAVE OF fi_drivid2 IN FRAME fr_main
DO:
    fi_drivid2 = INPUT fi_drivid2 .
    DISP fi_drivid2 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_drivno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_drivno C-Win
ON LEAVE OF fi_drivno IN FRAME fr_main
DO:
  fi_drivno = INPUT fi_drivno .
    DISP fi_drivno WITH FRAM fr_main.
  
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


&Scoped-define SELF-NAME fi_inspno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_inspno C-Win
ON LEAVE OF fi_inspno IN FRAME fr_main
DO:
  fi_inspno = INPUT fi_inspno .
    DISP fi_inspno WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_insresult
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_insresult C-Win
ON LEAVE OF fi_insresult IN FRAME fr_main
DO:
  fi_insresult = INPUT fi_insresult.
  DISP fi_insresult WITH FRAM fr_main.
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


&Scoped-define SELF-NAME fi_NCB
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_NCB C-Win
ON LEAVE OF fi_NCB IN FRAME fr_main
DO:
    /*A60-0263*/
    fi_ncb = INPUT fi_ncb .
    DISP fi_ncb WITH FRAM fr_main.
     /*A60-0263*/
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_policy
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_policy C-Win
ON LEAVE OF fi_policy IN FRAME fr_main
DO:
    fi_policy = INPUT fi_policy .
    DISP fi_policy WITH FRAME fr_main.
  
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


&Scoped-define SELF-NAME fi_producer
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_producer C-Win
ON LEAVE OF fi_producer IN FRAME fr_main
DO:
  fi_producer = INPUT fi_producer .
  DISP fi_producer WITH FRAM fr_main.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_province
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_province C-Win
ON LEAVE OF fi_province IN FRAME fr_main
DO:
  fi_province =  Input  fi_province.
  Disp  fi_province with frame  fr_main.
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


&Scoped-define SELF-NAME fi_status
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_status C-Win
ON LEAVE OF fi_status IN FRAME fr_main
DO:
  fi_status = INPUT fi_status .
    DISP fi_status WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_subspect
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_subspect C-Win
ON LEAVE OF fi_subspect IN FRAME fr_main
DO:
  fi_subspect = INPUT fi_subspect.
  DISP fi_subspect WITH FRAM fr_main.
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


&Scoped-define SELF-NAME fi_ton
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_ton C-Win
ON LEAVE OF fi_ton IN FRAME fr_main
DO:
    fi_ton = INPUT fi_ton.
    DISP fi_ton WITH FRAME fr_main.
  
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


&Scoped-define SELF-NAME fi_vehuse
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_vehuse C-Win
ON LEAVE OF fi_vehuse IN FRAME fr_main
DO:
  fi_vehuse =  Input  fi_vehuse.
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
  
  gv_prgid = "wgwscbq2".
  gv_prog  = "Query & Update Data  (SCB Renew) ".
  RUN  WUT\WUTHEAD ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).
/*********************************************************************/ 
 /*  RUN Wut\WutwiCen ({&WINDOW-NAME}:HANDLE). */ 
  /*CURRENT-WINDOW:WINDOW-STATE = WINDOW-MAXIMIZED.*/
  SESSION:DATA-ENTRY-RETURN = YES.
  
  Find  brstat.tlt  Where  Recid(brstat.tlt)  =  nv_recidtlt NO-LOCK NO-ERROR NO-WAIT .
  If  avail  brstat.tlt  Then do:
         RUN proc_assignfi.
         DISP   fi_type         fi_firstname    fi_ton       fi_remark1                                                                                  
                fi_ldate        fi_lastname     fi_year      fi_remark2
                fi_ltime        fi_icno         fi_licence   fi_policy 
                fi_trndat1       fi_company      fi_province  fi_status 
                fi_trndat       fi_addr1        fi_garage    fi_userid 
                fi_nottime      fi_addr2        fi_sumsi    
                fi_accno        fi_addr3        fi_gross_amt  fi_polstatus  
                fi_ins_off      fi_addr4        fi_comdat72   fi_producer   
                fi_covtyp       fi_drivno       fi_comtotal   fi_agent      
                fi_cartyp       fi_driv1        fi_sckno      fi_polsystem  
                fi_covcod       fi_vehuse       fi_NCB        fi_compol     
                fi_cc           fi_eng_no       fi_deduct     fi_paydate    
                fi_comdat       fi_cha_no       fi_accsor     fi_subspect
                fi_driv1        fi_drivid2      fi_insresult  fi_camp
                fi_driv2        fi_inspno       fi_ben    fi_userup
             WITH FRAME fr_main.
  END.
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
  DISPLAY fi_policy fi_covtyp fi_type fi_paydate fi_polstatus fi_polsystem 
          fi_compol fi_producer fi_agent fi_nottime fi_accno fi_comtotal 
          fi_ins_off fi_vehuse fi_year fi_cc fi_eng_no fi_cha_no fi_licence 
          fi_province fi_covcod fi_comdat fi_comdat72 fi_sumsi fi_gross_amt 
          fi_sckno fi_garage fi_accsor fi_firstname fi_lastname fi_icno fi_addr2 
          fi_addr1 fi_addr3 fi_addr4 fi_driv1 fi_drivno fi_subspect fi_status 
          fi_remark1 fi_remark2 fi_ldate fi_ltime fi_trndat fi_userid fi_NCB 
          fi_trndat1 fi_ton fi_company fi_cartyp fi_deduct fi_ben fi_drivid1 
          fi_driv2 fi_drivid2 fi_inspno fi_insresult fi_userup fi_camp 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE fi_policy fi_covtyp fi_polstatus fi_polsystem fi_compol fi_producer 
         fi_agent fi_nottime fi_accno fi_comtotal fi_ins_off fi_vehuse fi_year 
         fi_cc fi_eng_no fi_cha_no fi_licence fi_province fi_covcod fi_comdat 
         fi_comdat72 fi_sumsi fi_gross_amt fi_sckno fi_garage fi_accsor 
         fi_firstname fi_lastname fi_icno fi_addr2 fi_addr1 fi_addr3 fi_addr4 
         fi_driv1 fi_drivno fi_subspect fi_status fi_remark1 fi_remark2 bu_save 
         bu_exit fi_NCB fi_ton fi_company fi_cartyp fi_deduct fi_ben fi_drivid1 
         fi_driv2 fi_drivid2 fi_inspno bu_upins fi_insresult fi_userup fi_camp 
         RECT-335 RECT-383 RECT-385 RECT-386 RECT-387 RECT-388 
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
ASSIGN  
        fi_type       = IF brstat.tlt.flag = "N" THEN "NEW" ELSE "RENEW"
        fi_ldate      = brstat.tlt.entdat               /* วันที่โหลด */                          
        fi_ltime      = brstat.tlt.enttim               /* เวลาโหลด   */                          
        fi_trndat1    = brstat.tlt.trndat               /* วันที่จากหน้าจอ*/
        fi_trndat     = brstat.tlt.datesent             /* วันที่ไฟล์แจ้งงาน */ 
        fi_nottime    = brstat.tlt.trntim               /* เวลาแจ้งงาน*/
        fi_accno      = brstat.tlt.safe2                /*เลขที่สัญญา   */ 
        fi_ins_off    = brstat.tlt.nor_usr_ins          /*ผู้แจ้ง       */
        fi_covtyp      = brstat.tlt.colorcod            /*ประเภทรถประกัน*/ 
        fi_cartyp     = trim(brstat.tlt.old_cha)        /* ประเภทรถ */
        fi_covcod     = trim(brstat.tlt.comp_usr_tlt)   /*ประเภทความคุ้มครอง   */   
        
        fi_comdat     = brstat.tlt.gendat               /*วันที่เริ่มคุ้มครอง  */  
        /* ชื่อ */                          
        fi_firstname  = IF index(brstat.tlt.ins_name,"บจก") <> 0 AND index(brstat.tlt.ins_name,"มูลนิธิ") <> 0 AND  
                      index(brstat.tlt.ins_name,"หจก") <> 0 AND  index(brstat.tlt.ins_name,"บริษัท") <> 0 THEN 
                      TRIM(brstat.tlt.ins_name)  ELSE Substr(brstat.tlt.ins_name,1,R-INDEX(brstat.tlt.ins_name," "))               
        fi_lastname   = IF index(brstat.tlt.ins_name,"บจก") <> 0 AND index(brstat.tlt.ins_name,"มูลนิธิ") <> 0 AND  
                      index(brstat.tlt.ins_name,"หจก") <> 0 AND  index(brstat.tlt.ins_name,"บริษัท") <> 0 THEN ""
                      ELSE Substr(brstat.tlt.ins_name,R-INDEX(brstat.tlt.ins_name," ") + 1,length(brstat.tlt.ins_name)) 
        fi_icno       = TRIM(brstat.tlt.ins_addr5)            /*IDCARD              */   
        fi_company    = brstat.tlt.nor_usr_tlt    /* ชื่อบริษัท */
        fi_addr1      = trim(brstat.tlt.ins_addr1)       /*ที่อยู่ลูกค้า */          
        fi_addr2      = trim(brstat.tlt.ins_addr2) 
        fi_addr3      = trim(brstat.tlt.ins_addr3)  
        fi_addr4      = trim(brstat.tlt.ins_addr4)       
        fi_drivno     = brstat.tlt.endno         /* ระบุผู้ขับขี่ */
        fi_drivid1    = brstat.tlt.dri_no1                  /* ใบขับขี่ 1 */ 
        fi_vehuse     = brstat.tlt.model       /*รุ่น        */
        fi_eng_no     = brstat.tlt.eng_no          /*เลขเครื่อง  */          
        fi_cha_no     = brstat.tlt.cha_no        /*เลขถัง      */ 
        fi_cc         = brstat.tlt.cc_weight          /*ขนาดเครื่อง */ 
        fi_ton        = TRIM(brstat.tlt.OLD_eng)        /* น้ำหนักรถ */
        fi_year       = brstat.tlt.lince2          /*ปี          */ 
        fi_licence    = brstat.tlt.lince1              /*เลขทะเบียน   */                 
        fi_province   = brstat.tlt.lince3       /*จังหวัด    */ 
        fi_garage     = TRIM(brstat.tlt.stat)          /*สถานที่ซ่อม */ 
        fi_sumsi      = brstat.tlt.nor_coamt                    /*ทุนประกัน   */ 
        fi_gross_amt  = brstat.tlt.comp_coamt       /*เบี้ยรวม กธ.  */ 
        fi_comdat72   = brstat.tlt.comp_effdat   
        fi_comtotal   = brstat.tlt.comp_grprm    /*เบี้ยรวม พรบ. */  
        fi_sckno      = brstat.tlt.comp_sck                 /* สติ๊กเกอร์ */  
        fi_NCB        = SUBSTR(brstat.tlt.rec_addr5,5,INDEX(brstat.tlt.rec_addr5,"DD:") - 5 )   /* ncb */
        fi_deduct     = SUBSTR(brstat.tlt.rec_addr5,r-index(brstat.tlt.rec_addr5,"DD:") + 3 )      /*Deduct */ 
        fi_accsor     = brstat.tlt.safe1           /*อุปกรณ์ตกแต่ง*/ 
        fi_remark1    = IF LENGTH(brstat.tlt.filler2) <> 0  then SUBSTR(brstat.tlt.filler2,1,100)  else ""     /*หมายเหตุ  */                                
        fi_remark2    = IF LENGTH(brstat.tlt.filler2) > 100  then SUBSTR(brstat.tlt.filler2,101,100) else ""     /*หมายเหตุ  */
        fi_policy     = brstat.tlt.filler1            /*เบอร์ต่ออายุ*/ 
        fi_status     = brstat.tlt.lotno                /* status */
        fi_userid     = brstat.tlt.usrid              /*User Load Data */

        fi_driv1      = brstat.tlt.dri_name1     /*  ชื่อผู้ขับขี่ 1 */
        fi_driv2      = brstat.tlt.dri_name2     /*  ชื่อผู้ขับขี่ 2 */ 
        fi_drivid2    = brstat.tlt.dri_no2       /* เลขใบขับขี่ 2 */
        fi_inspno     = SUBSTR(brstat.tlt.rec_addr1,5,index(brstat.tlt.rec_addr1,"RES:") - 5)     /* isp no */
        fi_insresult  = SUBSTR(brstat.tlt.rec_addr1,R-INDEX(brstat.tlt.rec_addr1,"RES:") + 4)     /* ผลตรวจสภาพ */
        fi_ben        = SUBSTR(brstat.tlt.rec_addr2,5,index(brstat.tlt.rec_addr2,"CAM:") - 5)     /* ผู้รับผลประโยชน์ */
        fi_camp       = SUBSTR(brstat.tlt.rec_addr2,R-INDEX(brstat.tlt.rec_addr2,"CAM:") + 4)     /* แคมเปญ */
        fi_userup     = brstat.tlt.rec_addr3     /* User ID ที่แก้ไขข้อมูล */
        fi_polstatus  = IF brstat.tlt.releas = "NO" THEN "ยังไม่ออกงาน" ELSE IF INDEX(brstat.tlt.releas,"Cancel") <> 0 THEN "ยกเลิก" ELSE "ออกงานแล้ว"
        fi_producer   = brstat.tlt.comp_sub             
        fi_agent      = brstat.tlt.comp_noti_ins            
        fi_polsystem  = brstat.tlt.nor_noti_ins       /*เบอร์ใหม่ */            
        fi_compol     = brstat.tlt.comp_pol           /*เบอร์ พรบ.  */  
        fi_paydate    = brstat.tlt.dat_ins_noti                              /*วันที่ออกงาน */
        fi_subspect   = brstat.tlt.expotim  .   /* suspect */
         
         
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_getisp C-Win 
PROCEDURE proc_getisp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:  Create by A62-0454 Date 16/10/2019       
------------------------------------------------------------------------------*/
/*DEF VAR n_list      AS INT init 0.
DEF VAR n_count     AS INT init 0.
DEF VAR n_agent     AS CHAR FORMAT "x(10)" INIT "".
DEF VAR n_repair    AS CHAR FORMAT "x(10)" init "".
DEF VAR n_dam       AS CHAR FORMAT "x(10)" init "".
DEF VAR n_deatil    AS CHAR FORMAT "x(60)" init "".
DEF VAR nv_damag    AS CHAR FORMAT "x(30)" init "".
DEF VAR nv_repair   AS CHAR FORMAT "x(30)" init "".*/
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
         /* chitem       = chDocument:Getfirstitem("TotalExpensive").  /* ราคาความเสียหาย */
          IF chitem <> 0 THEN nv_totaldam  = chitem:TEXT.
          ELSE nv_totaldam = "".*/

          IF nv_damlist <> "" THEN DO: 
              ASSIGN    n_list     = INT(nv_damlist) 
                        nv_damlist = " " + nv_damlist + " รายการ " .
          END.
          /*IF nv_totaldam <> "" THEN ASSIGN nv_totaldam = "รวมความเสียหาย " + nv_totaldam + " บาท " .*/
          
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
                   /* chitem       = chDocument:Getfirstitem(n_repair).
                    IF chitem <> 0 THEN  nv_repair = chitem:TEXT. 
                    ELSE nv_repair = "".*/

                    IF nv_damag <> "" THEN  
                        ASSIGN nv_damdetail = nv_damdetail + STRING(n_count) + "." + nv_damag /*+ " " + nv_repair*/ + ", " .
                        
                    n_count = n_count + 1.
                END.
                ELSE LEAVE loop_damage.
            END.
          END.
      END.
      /*-- ข้อมูลอื่น ๆ ---*/
     /* chitem       = chDocument:Getfirstitem("SurveyData").
      IF chitem <> 0 THEN  nv_surdata = chitem:TEXT. 
      ELSE nv_surdata = "".
      IF trim(nv_surdata) <> "" THEN  nv_surdata = "ข้อมูลอื่นๆ :"  +  nv_surdata .*/
      
     /*-- อุปกรณ์เสริม --*/  
      chitem       = chDocument:Getfirstitem("device1").
      IF chitem <> 0 THEN  nv_device = chitem:TEXT. 
      ELSE nv_device = "".
      IF nv_device <> "" THEN DO:
         /* chitem       = chDocument:Getfirstitem("PricesTotal").  /* ราคารวมอุปกรณ์เสริม */
          IF chitem <> 0 THEN  nv_acctotal = chitem:TEXT. 
          ELSE nv_acctotal = "".*/
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
         /* nv_acctotal = " ราคารวม" + nv_acctotal + " บาท " .*/

      END.

END.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

