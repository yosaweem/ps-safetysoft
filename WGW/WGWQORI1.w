&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
&Scoped-define WINDOW-NAME cC-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS cC-Win 
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
  Create  by  :  Ranu I. A59-0288  date. 26/09/2016 
  Modify by : Ranu I. A60-0263 date 12/06/2017 เพิ่มช่องแคมเปญ 
  Modify by : Ranu I. A62-0454 date 16/10/2019 เพิ่มการเช็คข้อมูลเลขตรวจสภาพ
  modify by : Ranu I. A63-0450 date 15/10/2020 แก้ไขฟอร์แมตทะเบียนรถให้ตรงกับกล่องตรวจสภาพ  
  modify by : Kridtiya i. A66-0107 Date.26/05/2023 เก็บข้อมูลความเสียหายแยกออกมา
  modify by : Kridtiya i. A66-0134 display damage */
/*+++++++++++++++++++++++++++++++++++++++++++++++*/
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
&Scoped-Define ENABLED-OBJECTS buchk fi_vatcode fi_taxno fi_policy ~
fi_covcod2 fi_saleid fi_polstatus fi_polsystem fi_compol fi_producer ~
fi_agent fi_nottime fi_branchsaf fi_notno fi_accno fi_comtotal fi_ins_off ~
fi_brand fi_vehuse fi_year fi_ton fi_eng_no fi_cha_no fi_licence ~
fi_province fi_covcod fi_dealer fi_accprice fi_comdat fi_expdat fi_sumsi ~
fi_gross_amt fi_compprm fi_sckno fi_prem1 fi_garage fi_acc fi_title ~
fi_firstname fi_lastname fi_icno fi_addr1 fi_addr2 fi_addr3 fi_addr4 ~
fi_driv1 fi_birth1 fi_drivid1 fi_driv2 fi_birth2 fi_drivid2 fi_benname ~
fi_remark1 fi_remark2 bu_save bu_exit fi_class fi_inspace fi_recname ~
fi_recadd fi_camp fi_branchtax fi_color fi_occup fi_comtyp fi_ispdetail ~
RECT-335 RECT-381 RECT-382 RECT-383 RECT-385 RECT-386 
&Scoped-Define DISPLAYED-OBJECTS fi_vatcode fi_taxno fi_policy fi_covcod2 ~
fi_saleid fi_type fi_polstatus fi_paydate fi_polsystem fi_compol ~
fi_producer fi_agent fi_nottime fi_branchsaf fi_notno fi_accno fi_comtotal ~
fi_ins_off fi_brand fi_vehuse fi_year fi_ton fi_eng_no fi_cha_no fi_licence ~
fi_province fi_covcod fi_dealer fi_accprice fi_comdat fi_expdat fi_sumsi ~
fi_gross_amt fi_compprm fi_sckno fi_prem1 fi_garage fi_acc fi_title ~
fi_firstname fi_lastname fi_icno fi_addr1 fi_addr2 fi_addr3 fi_addr4 ~
fi_driv1 fi_birth1 fi_drivid1 fi_driv2 fi_birth2 fi_drivid2 fi_benname ~
fi_remark1 fi_remark2 fi_ldate fi_ltime fi_trndat fi_userid fi_class ~
fi_inspace fi_recname fi_recadd fi_camp fi_branchtax fi_color fi_trndat1 ~
fi_occup fi_comtyp fi_ispdetail 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR cC-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON buchk 
     LABEL "ISP" 
     SIZE 7 BY .91
     BGCOLOR 2 FGCOLOR 15 FONT 6.

DEFINE BUTTON bu_exit 
     LABEL "Exit" 
     SIZE 8 BY 1
     FONT 6.

DEFINE BUTTON bu_save 
     LABEL "Save" 
     SIZE 8 BY 1
     FONT 6.

DEFINE VARIABLE fi_acc AS CHARACTER FORMAT "x(150)":U 
     VIEW-AS FILL-IN 
     SIZE 110.5 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_accno AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 17.33 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_accprice AS CHARACTER FORMAT "X(15)":U INITIAL "0" 
     VIEW-AS FILL-IN 
     SIZE 16.67 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

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
     SIZE 14.17 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_benname AS CHARACTER FORMAT "X(65)":U 
     VIEW-AS FILL-IN 
     SIZE 53.5 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_birth1 AS CHARACTER FORMAT "X(15)":U INITIAL "0" 
     VIEW-AS FILL-IN 
     SIZE 13 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_birth2 AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 13 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_branchsaf AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 5.17 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_branchtax AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 20.83 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_brand AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 17.5 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_camp AS CHARACTER FORMAT "X(45)":U 
     VIEW-AS FILL-IN 
     SIZE 20.17 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_cha_no AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 23.33 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_class AS CHARACTER FORMAT "X(5)":U 
     VIEW-AS FILL-IN 
     SIZE 8.83 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_color AS CHARACTER FORMAT "X(25)":U INITIAL "0" 
     VIEW-AS FILL-IN 
     SIZE 13.67 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_comdat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 15.17 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_compol AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 20 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_compprm AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 13 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_comtotal AS DECIMAL FORMAT "->>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 15.33 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_comtyp AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 9.5 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_covcod AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 13 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_covcod2 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 9.5 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_dealer AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 36.5 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_driv1 AS CHARACTER FORMAT "X(60)":U 
     VIEW-AS FILL-IN 
     SIZE 30 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_driv2 AS CHARACTER FORMAT "X(60)":U 
     VIEW-AS FILL-IN 
     SIZE 30 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_drivid1 AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_drivid2 AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_eng_no AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 22 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_expdat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 15.33 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_firstname AS CHARACTER FORMAT "X(75)":U 
     VIEW-AS FILL-IN 
     SIZE 29 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_garage AS CHARACTER FORMAT "X(30)":U INITIAL ? 
     VIEW-AS FILL-IN 
     SIZE 16.67 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_gross_amt AS DECIMAL FORMAT "->>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 19.17 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_icno AS CHARACTER FORMAT "X(13)":U 
     VIEW-AS FILL-IN 
     SIZE 20.33 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_inspace AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 18 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_ins_off AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 23.17 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_ispdetail AS CHARACTER FORMAT "X(500)":U 
     VIEW-AS FILL-IN 
     SIZE 95.5 BY .86
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_lastname AS CHARACTER FORMAT "X(45)":U 
     VIEW-AS FILL-IN 
     SIZE 40 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_ldate AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 15.33 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_licence AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 13.5 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_ltime AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 12.17 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_notno AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 17.83 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_nottime AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 12.33 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_occup AS CHARACTER FORMAT "X(60)":U 
     VIEW-AS FILL-IN 
     SIZE 24.83 BY .91
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

DEFINE VARIABLE fi_prem1 AS DECIMAL FORMAT "->>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 18.33 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_producer AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_province AS CHARACTER FORMAT "X(35)":U 
     VIEW-AS FILL-IN 
     SIZE 16.83 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_recadd AS CHARACTER FORMAT "X(150)":U 
     VIEW-AS FILL-IN 
     SIZE 107.5 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_recname AS CHARACTER FORMAT "X(85)":U 
     VIEW-AS FILL-IN 
     SIZE 56 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_remark1 AS CHARACTER FORMAT "X(250)":U 
     VIEW-AS FILL-IN 
     SIZE 95.5 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_remark2 AS CHARACTER FORMAT "X(250)":U 
     VIEW-AS FILL-IN 
     SIZE 95.5 BY .86
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_saleid AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 19.33 BY .91
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_sckno AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 18.33 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_sumsi AS INTEGER FORMAT ">>>,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 21 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_taxno AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 20.83 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_title AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 14.17 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_ton AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 9.17 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_trndat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 15.17 BY .91
     BGCOLOR 10 FGCOLOR 4 FONT 6 NO-UNDO.

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

DEFINE VARIABLE fi_vatcode AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 17.67 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_vehuse AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 27 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_year AS CHARACTER FORMAT "X(4)":U INITIAL "0" 
     VIEW-AS FILL-IN 
     SIZE 6.83 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE RECTANGLE RECT-335
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132 BY 28.71
     BGCOLOR 3 FGCOLOR 2 .

DEFINE RECTANGLE RECT-381
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 10.5 BY 1.52
     BGCOLOR 11 FGCOLOR 2 .

DEFINE RECTANGLE RECT-382
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 10.5 BY 1.52
     BGCOLOR 6 FGCOLOR 0 .

DEFINE RECTANGLE RECT-383
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 130 BY 3.48
     BGCOLOR 29 .

DEFINE RECTANGLE RECT-385
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 130 BY 7.76.

DEFINE RECTANGLE RECT-386
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 130 BY 13.29.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     buchk AT ROW 12.19 COL 36.5
     fi_vatcode AT ROW 17.05 COL 85.17 COLON-ALIGNED NO-LABEL
     fi_taxno AT ROW 18.05 COL 53.17 COLON-ALIGNED NO-LABEL
     fi_policy AT ROW 1.43 COL 38.33 COLON-ALIGNED NO-LABEL
     fi_covcod2 AT ROW 9.1 COL 40.5 COLON-ALIGNED NO-LABEL
     fi_saleid AT ROW 18.05 COL 18 COLON-ALIGNED NO-LABEL
     fi_type AT ROW 1.33 COL 3.17 NO-LABEL
     fi_polstatus AT ROW 28.14 COL 50.67 COLON-ALIGNED NO-LABEL
     fi_paydate AT ROW 28.14 COL 17.5 COLON-ALIGNED NO-LABEL
     fi_polsystem AT ROW 1.43 COL 75.67 COLON-ALIGNED NO-LABEL
     fi_compol AT ROW 1.43 COL 109.33 COLON-ALIGNED NO-LABEL
     fi_producer AT ROW 3.19 COL 77.67 COLON-ALIGNED NO-LABEL
     fi_agent AT ROW 3.19 COL 106.33 COLON-ALIGNED NO-LABEL
     fi_nottime AT ROW 4.19 COL 47.83 COLON-ALIGNED NO-LABEL
     fi_branchsaf AT ROW 4.19 COL 115.17 COLON-ALIGNED NO-LABEL
     fi_notno AT ROW 5.19 COL 18.17 COLON-ALIGNED NO-LABEL
     fi_accno AT ROW 5.19 COL 49.33 COLON-ALIGNED NO-LABEL
     fi_comtotal AT ROW 11.14 COL 42.5 COLON-ALIGNED NO-LABEL
     fi_ins_off AT ROW 5.19 COL 77 COLON-ALIGNED NO-LABEL
     fi_brand AT ROW 7.14 COL 16.5 COLON-ALIGNED NO-LABEL
     fi_vehuse AT ROW 7.05 COL 43.33 COLON-ALIGNED NO-LABEL
     fi_year AT ROW 7.05 COL 78.17 COLON-ALIGNED NO-LABEL
     fi_ton AT ROW 7.05 COL 95.83 COLON-ALIGNED NO-LABEL
     fi_eng_no AT ROW 8.1 COL 16.5 COLON-ALIGNED NO-LABEL
     fi_cha_no AT ROW 8.1 COL 51.33 COLON-ALIGNED NO-LABEL
     fi_licence AT ROW 8.1 COL 85.83 COLON-ALIGNED NO-LABEL
     fi_province AT ROW 8.1 COL 109.17 COLON-ALIGNED NO-LABEL
     fi_covcod AT ROW 9.1 COL 16.5 COLON-ALIGNED NO-LABEL
     fi_dealer AT ROW 4.19 COL 71 COLON-ALIGNED NO-LABEL
     fi_accprice AT ROW 12.19 COL 110.33 COLON-ALIGNED NO-LABEL
     fi_comdat AT ROW 9.1 COL 80.5 COLON-ALIGNED NO-LABEL
     fi_expdat AT ROW 9.1 COL 110.5 COLON-ALIGNED NO-LABEL
     fi_sumsi AT ROW 10.1 COL 16.5 COLON-ALIGNED NO-LABEL
     fi_gross_amt AT ROW 10.1 COL 86.83 COLON-ALIGNED NO-LABEL
     fi_compprm AT ROW 11.14 COL 16.5 COLON-ALIGNED NO-LABEL
     fi_sckno AT ROW 11.14 COL 72.17 COLON-ALIGNED NO-LABEL
     fi_prem1 AT ROW 10.1 COL 52.67 COLON-ALIGNED NO-LABEL
     fi_garage AT ROW 11.14 COL 110.33 COLON-ALIGNED NO-LABEL
     fi_acc AT ROW 13.24 COL 16.33 COLON-ALIGNED NO-LABEL
     fi_title AT ROW 15.05 COL 18 COLON-ALIGNED NO-LABEL
     fi_firstname AT ROW 15.05 COL 38.17 COLON-ALIGNED NO-LABEL
     fi_lastname AT ROW 15.05 COL 78 COLON-ALIGNED NO-LABEL
     fi_icno AT ROW 16.05 COL 18 COLON-ALIGNED NO-LABEL
     fi_addr1 AT ROW 20.05 COL 18 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     fi_addr2 AT ROW 20.05 COL 77.67 COLON-ALIGNED NO-LABEL
     fi_addr3 AT ROW 21.05 COL 18 COLON-ALIGNED NO-LABEL
     fi_addr4 AT ROW 21.05 COL 77.67 COLON-ALIGNED NO-LABEL
     fi_driv1 AT ROW 22.05 COL 18 COLON-ALIGNED NO-LABEL
     fi_birth1 AT ROW 22.05 COL 58.67 COLON-ALIGNED NO-LABEL
     fi_drivid1 AT ROW 22.05 COL 84.33 COLON-ALIGNED NO-LABEL
     fi_driv2 AT ROW 23.05 COL 18 COLON-ALIGNED NO-LABEL
     fi_birth2 AT ROW 23.05 COL 58.67 COLON-ALIGNED NO-LABEL
     fi_drivid2 AT ROW 23.05 COL 84.33 COLON-ALIGNED NO-LABEL
     fi_benname AT ROW 24.05 COL 18 COLON-ALIGNED NO-LABEL
     fi_remark1 AT ROW 25.1 COL 20 NO-LABEL
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1.67 ROW 1.1
         SIZE 133 BY 29
         BGCOLOR 3 FGCOLOR 1 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     fi_remark2 AT ROW 26.05 COL 18 COLON-ALIGNED NO-LABEL
     bu_save AT ROW 28.33 COL 112.33
     bu_exit AT ROW 28.33 COL 123
     fi_ldate AT ROW 3.19 COL 18.17 COLON-ALIGNED NO-LABEL
     fi_ltime AT ROW 3.19 COL 47.83 COLON-ALIGNED NO-LABEL
     fi_trndat AT ROW 4.19 COL 18.17 COLON-ALIGNED NO-LABEL
     fi_userid AT ROW 24.29 COL 115 COLON-ALIGNED NO-LABEL
     fi_class AT ROW 12.19 COL 49 COLON-ALIGNED NO-LABEL
     fi_inspace AT ROW 12.19 COL 16.33 COLON-ALIGNED NO-LABEL
     fi_recname AT ROW 17.05 COL 20 NO-LABEL
     fi_recadd AT ROW 19.05 COL 20 NO-LABEL
     fi_camp AT ROW 12.19 COL 70.33 COLON-ALIGNED NO-LABEL
     fi_branchtax AT ROW 18.05 COL 82.17 COLON-ALIGNED NO-LABEL
     fi_color AT ROW 7.05 COL 112.33 COLON-ALIGNED NO-LABEL
     fi_trndat1 AT ROW 23.19 COL 115 COLON-ALIGNED
     fi_occup AT ROW 16.05 COL 49 COLON-ALIGNED NO-LABEL
     fi_comtyp AT ROW 9.1 COL 56.83 COLON-ALIGNED NO-LABEL
     fi_ispdetail AT ROW 26.95 COL 18 COLON-ALIGNED NO-LABEL WIDGET-ID 2
     "ฺ Birth :":30 VIEW-AS TEXT
          SIZE 7 BY .91 AT ROW 22.05 COL 53.17
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " วันที่หมดอายุ :":35 VIEW-AS TEXT
          SIZE 13.83 BY .91 AT ROW 9.1 COL 98.5
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " Drive ID :" VIEW-AS TEXT
          SIZE 10.5 BY .91 AT ROW 22.05 COL 75.5
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " เบี้ยรวม 70 :":30 VIEW-AS TEXT
          SIZE 12.83 BY .91 AT ROW 10.1 COL 75.67
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "เลขที่ผู้เสียภาษี :" VIEW-AS TEXT
          SIZE 14.33 BY .91 AT ROW 18.05 COL 40.5
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " ยี่ห้อรถ :":30 VIEW-AS TEXT
          SIZE 8.33 BY .91 AT ROW 7.05 COL 9.17
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "เลขที่สัญญา :":30 VIEW-AS TEXT
          SIZE 11.5 BY .91 AT ROW 5.19 COL 39.67
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " เลขตัวถัง :":20 VIEW-AS TEXT
          SIZE 11 BY .91 AT ROW 8.1 COL 42.17
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " Recepit Name :":30 VIEW-AS TEXT
          SIZE 15.5 BY .91 AT ROW 17.05 COL 4
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " Agent code :":30 VIEW-AS TEXT
          SIZE 13 BY .91 AT ROW 3.19 COL 95
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " ความคุ้มครอง :":30 VIEW-AS TEXT
          SIZE 14 BY .91 AT ROW 9.1 COL 3.5
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " นามสกุล :":30 VIEW-AS TEXT
          SIZE 9.67 BY .91 AT ROW 15.05 COL 70
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "เบี้ยสุทธิ 72 :":30 VIEW-AS TEXT
          SIZE 11.67 BY .91 AT ROW 11.14 COL 5.83
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "Campaign :":30 VIEW-AS TEXT
          SIZE 11 BY .91 AT ROW 12.19 COL 61.17
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " ชื่อ :":30 VIEW-AS TEXT
          SIZE 5 BY .91 AT ROW 15.05 COL 34.83
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "พรบ :" VIEW-AS TEXT
          SIZE 6.33 BY .91 AT ROW 9.1 COL 52.33
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "Class :":30 VIEW-AS TEXT
          SIZE 6.83 BY .91 AT ROW 12.19 COL 44
          BGCOLOR 19 FGCOLOR 0 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1.67 ROW 1.1
         SIZE 133 BY 29
         BGCOLOR 3 FGCOLOR 1 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     " เบี้ยสุทธิ 70 :":25 VIEW-AS TEXT
          SIZE 12.17 BY .91 AT ROW 10.1 COL 42.17
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " ข้อรถและการประกันภัย" VIEW-AS TEXT
          SIZE 21 BY .81 AT ROW 6.19 COL 2
          BGCOLOR 3 FGCOLOR 7 FONT 6
     " เบี้ยรวม72 :":35 VIEW-AS TEXT
          SIZE 12 BY .91 AT ROW 11.14 COL 32
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "IC No :":30 VIEW-AS TEXT
          SIZE 7.5 BY .91 AT ROW 16.05 COL 12
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " สาขา :":30 VIEW-AS TEXT
          SIZE 6.5 BY .91 AT ROW 4.19 COL 110.5
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " กรมธรรม์เดิม  :":35 VIEW-AS TEXT
          SIZE 15 BY .95 AT ROW 1.43 COL 24.83
          BGCOLOR 4 FGCOLOR 7 FONT 6
     " เบอร์ พรบ  :":35 VIEW-AS TEXT
          SIZE 12.67 BY .95 AT ROW 1.43 COL 98
          BGCOLOR 2 FGCOLOR 7 FONT 6
     " เวลาโหลด  :":30 VIEW-AS TEXT
          SIZE 12.67 BY .91 AT ROW 3.19 COL 36.83
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "ื กรมธรรม์ใหม่  :":35 VIEW-AS TEXT
          SIZE 15 BY .95 AT ROW 1.43 COL 62.17
          BGCOLOR 2 FGCOLOR 7 FONT 6
     "Status Policy :" VIEW-AS TEXT
          SIZE 14 BY 1 AT ROW 28.14 COL 37.83
          BGCOLOR 19 FGCOLOR 4 FONT 6
     " เลขรับแจ้ง :":35 VIEW-AS TEXT
          SIZE 11.67 BY .91 AT ROW 5.19 COL 7.83
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " คำนำหน้าชื่อ :":30 VIEW-AS TEXT
          SIZE 13 BY .91 AT ROW 15.05 COL 6.5
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " น้ำหนัก :":30 VIEW-AS TEXT
          SIZE 8.83 BY .91 AT ROW 7.05 COL 88.67
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " ทะเบียน :":30 VIEW-AS TEXT
          SIZE 10 BY .91 AT ROW 8.1 COL 77.5
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " เลขเครื่อง :":35 VIEW-AS TEXT
          SIZE 10.5 BY .91 AT ROW 8.1 COL 7
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "ประกันภัย :" VIEW-AS TEXT
          SIZE 9.83 BY .91 AT ROW 9.1 COL 32.5
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " วันที่คุ้มครอง :":35 VIEW-AS TEXT
          SIZE 13.33 BY .91 AT ROW 9.1 COL 69
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "วันที่ออกงาน :" VIEW-AS TEXT
          SIZE 14 BY 1 AT ROW 28.14 COL 5
          BGCOLOR 19 FGCOLOR 4 FONT 6
     " สาขา :":30 VIEW-AS TEXT
          SIZE 6.5 BY .91 AT ROW 18.05 COL 77.17
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " ทุนประกัน :":35 VIEW-AS TEXT
          SIZE 10.83 BY .91 AT ROW 10.1 COL 6.67
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "  อาชีพ :":30 VIEW-AS TEXT
          SIZE 8.33 BY .91 AT ROW 16.05 COL 42.5
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "  ชื่อผู้ขับขี่ 2 :":30 VIEW-AS TEXT
          SIZE 13 BY .91 AT ROW 23.05 COL 6.5
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " Birth :":30 VIEW-AS TEXT
          SIZE 7 BY .91 AT ROW 23.05 COL 53.17
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "เวลาแจ้งงาน :":35 VIEW-AS TEXT
          SIZE 12.83 BY .91 AT ROW 4.19 COL 36.67
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " จังหวัด :":30 VIEW-AS TEXT
          SIZE 9.17 BY .91 AT ROW 8.1 COL 101.83
          BGCOLOR 19 FGCOLOR 0 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1.67 ROW 1.1
         SIZE 133 BY 29
         BGCOLOR 3 FGCOLOR 1 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "เลขทะเบียนการค้า :" VIEW-AS TEXT
          SIZE 16.5 BY .91 AT ROW 18.05 COL 3
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "  ที่อยู่ 3 :":35 VIEW-AS TEXT
          SIZE 9 BY .91 AT ROW 21.05 COL 10.5
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "ดีลเลอร์ :":35 VIEW-AS TEXT
          SIZE 9.5 BY .91 AT ROW 4.19 COL 63.33
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " Drive ID :" VIEW-AS TEXT
          SIZE 10.5 BY .91 AT ROW 23.05 COL 75.5
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " ที่อยู่หน้าตาราง1 :":30 VIEW-AS TEXT
          SIZE 16 BY .91 AT ROW 20.05 COL 3.5
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " ปีรถ :":35 VIEW-AS TEXT
          SIZE 6.5 BY .91 AT ROW 7.05 COL 73.5
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "ความเสียหาย :":30 VIEW-AS TEXT
          SIZE 12 BY .91 AT ROW 26.91 COL 7.5 WIDGET-ID 4
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " รุ่นรถ :":30 VIEW-AS TEXT
          SIZE 7.67 BY .91 AT ROW 7.05 COL 37.5
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " วันที่โหลด  :":30 VIEW-AS TEXT
          SIZE 12 BY .91 AT ROW 3.19 COL 7.5
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "วันที่ไฟล์แจ้งงาน :" VIEW-AS TEXT
          SIZE 16.5 BY .91 AT ROW 4.19 COL 3
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "ราคาอุปกรณ์ตกแต่ง :":35 VIEW-AS TEXT
          SIZE 19 BY .91 AT ROW 12.19 COL 93
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "เลขตรวจสภาพ :":30 VIEW-AS TEXT
          SIZE 14.5 BY .91 AT ROW 12.19 COL 3
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "Producer code :":30 VIEW-AS TEXT
          SIZE 16 BY .91 AT ROW 3.19 COL 63.33
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "  ที่อยู่ 4 :":30 VIEW-AS TEXT
          SIZE 9.5 BY .91 AT ROW 21.05 COL 69.5
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " Remark :":30 VIEW-AS TEXT
          SIZE 10 BY .91 AT ROW 25.05 COL 9.5
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " ที่อยู่ออกใบเสร็จ :":30 VIEW-AS TEXT
          SIZE 16.33 BY .91 AT ROW 19.05 COL 3.17
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "  ชื่อผู้ขับขี่ 1 :":30 VIEW-AS TEXT
          SIZE 13 BY .91 AT ROW 22.05 COL 6.5
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " ประเภทการซ่อม :":35 VIEW-AS TEXT
          SIZE 19 BY .91 AT ROW 11.14 COL 93
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "  ที่อยู่ 2 :":30 VIEW-AS TEXT
          SIZE 9.5 BY .91 AT ROW 20.05 COL 69.5
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "เลขสติ๊กเกอร์ :":30 VIEW-AS TEXT
          SIZE 12.67 BY .91 AT ROW 11.14 COL 61.17
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "ผู้รับผลประโยชน์ :":30 VIEW-AS TEXT
          SIZE 16.5 BY .91 AT ROW 24.05 COL 3
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " สีรถ :":30 VIEW-AS TEXT
          SIZE 6.5 BY .91 AT ROW 7.05 COL 107.67
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "อุปกรณ์ตกแต่ง :":30 VIEW-AS TEXT
          SIZE 14.33 BY .91 AT ROW 13.24 COL 3.17
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " ชื่อผู้แจ้ง:":30 VIEW-AS TEXT
          SIZE 9.5 BY .91 AT ROW 5.19 COL 69.33
          BGCOLOR 19 FGCOLOR 2 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1.67 ROW 1.1
         SIZE 133 BY 29
         BGCOLOR 3 FGCOLOR 1 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     " ข้อมูลการแจ้งงาน" VIEW-AS TEXT
          SIZE 17 BY .81 AT ROW 2.38 COL 2
          BGCOLOR 3 FGCOLOR 7 FONT 6
     " ข้อมูลลูกค้า" VIEW-AS TEXT
          SIZE 11.5 BY .81 AT ROW 14.29 COL 2.33
          BGCOLOR 3 FGCOLOR 7 FONT 6
     "Vat code :":30 VIEW-AS TEXT
          SIZE 10 BY .91 AT ROW 17.05 COL 77
          BGCOLOR 19 FGCOLOR 2 FONT 6
     RECT-335 AT ROW 1.1 COL 1.33
     RECT-381 AT ROW 28.1 COL 111
     RECT-382 AT ROW 28.1 COL 121.83
     RECT-383 AT ROW 2.91 COL 2
     RECT-385 AT ROW 6.71 COL 2
     RECT-386 AT ROW 14.67 COL 2
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1.67 ROW 1.1
         SIZE 133 BY 29
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
  CREATE WINDOW cC-Win ASSIGN
         HIDDEN             = YES
         TITLE              = "Update Data ORICO (NEW/RENEW)"
         HEIGHT             = 29.05
         WIDTH              = 133.33
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
IF NOT cC-Win:LOAD-ICON("wimage\safety":U) THEN
    MESSAGE "Unable to load icon: wimage\safety"
            VIEW-AS ALERT-BOX WARNING BUTTONS OK.
&ENDIF
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW cC-Win
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
/* SETTINGS FOR FILL-IN fi_recadd IN FRAME fr_main
   ALIGN-L                                                              */
/* SETTINGS FOR FILL-IN fi_recname IN FRAME fr_main
   ALIGN-L                                                              */
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
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(cC-Win)
THEN cC-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME cC-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cC-Win cC-Win
ON END-ERROR OF cC-Win /* Update Data ORICO (NEW/RENEW) */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cC-Win cC-Win
ON WINDOW-CLOSE OF cC-Win /* Update Data ORICO (NEW/RENEW) */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buchk
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buchk cC-Win
ON CHOOSE OF buchk IN FRAME fr_main /* ISP */
/* comment by A62-0454 ................
DO:
    DEF VAR nv_docno  AS CHAR FORMAT "x(25)".
    DEF VAR nv_survey AS CHAR FORMAT "x(25)".
    DEF VAR nv_detail AS CHAR FORMAT "x(30)".
    DEF VAR nv_year   AS CHAR FORMAT "x(5)".*/
    /*
    ASSIGN  nv_docno    = ""   nv_tmp   = ""   
            nv_year     = STRING(YEAR(TODAY),"9999")
            nv_tmp      = "Inspect" + SUBSTR(nv_year,3,2) + ".nsf".

    /*--------- Server Real ----------*/
    nv_server = "Safety_NotesServer/Safety".
    nv_tmp   = "safety\uw\" + nv_tmp .
    /*-------------------------------*/
    /*---------- Server test local -------
    nv_server = "".
    nv_tmp    = "D:\Lotus\Notes\Data\ranu\" + nv_tmp .
    -----------------------------*/
    CREATE "Notes.NotesSession"  chNotesSession.
    chNotesDatabase  = chNotesSession:GetDatabase (nv_server,nv_tmp).

      IF  chNotesDatabase:IsOpen()  = NO  THEN  DO:
         MESSAGE "Can not open database" SKIP  
                 "Please Check database and serve" VIEW-AS  ALERT-BOX ERROR.
      END.
      chNotesView    = chNotesDatabase:GetView("เลขตัวถัง").
      chNavView      = chNotesView:CreateViewNav.
      chDocument     = chNotesView:GetDocumentByKey(brstat.tlt.cha_no).
      IF VALID-HANDLE(chDocument) = YES THEN DO:

          chitem       = chDocument:Getfirstitem("docno"). 
          IF chitem <> 0 THEN nv_docno   = chitem:TEXT. 
          ELSE nv_docno = "".

          /*chitem       = chDocument:Getfirstitem("SurveyClose").
          IF chitem <> 0 THEN nv_survey    = chitem:TEXT. 
          ELSE nv_survey = "".
          
          chitem       = chDocument:Getfirstitem("SurveyResult").
          IF chitem <> 0 THEN nv_detail    = chitem:TEXT.
          ELSE nv_detail = "".*/

          IF nv_docno <> ""  THEN DO:
              ASSIGN  fi_inspace = nv_docno.
              
          END.
          ELSE ASSIGN  fi_inspace = "" .
                       

          RELEASE  OBJECT chitem          NO-ERROR.
          RELEASE  OBJECT chDocument      NO-ERROR.          
          RELEASE  OBJECT chNotesDataBase NO-ERROR.     
          RELEASE  OBJECT chNotesSession  NO-ERROR.
      END.
end .
.......end A62-0454.................*/
/* add by A62-0454 */    
DO: 
   /* DEF VAR nv_survey AS CHAR FORMAT "x(25)".
    DEF VAR nv_detail AS CHAR FORMAT "x(30)".*/
  
   ASSIGN  
        nv_docno    = ""   
        nv_year      = STRING(YEAR(TODAY))
        nv_year      = SUBSTR(nv_year,3,2) 
        /* real database*/ 
        nv_server  = "Safety_NotesServer/Safety"
        nv_tmp     = "safety\uw\inspect" + nv_year + ".nsf"
        
        
        /* test database  
        nv_server  = ""
        nv_tmp     = "D:\Lotus\Notes\Data\inspect" + nv_year + ".nsf"  */

        NotesView    = "chassis_no" /* วิวซ่อนของเลขตัวถัง */ /*A62-0219*/
        nv_chkdoc    = NO  
        nv_count     = 0
        nv_text1     = ""
        nv_text2     = ""
        nv_chktext   = 0
        nv_cha_no    = TRIM(fi_cha_no) . 

    nv_licence1 = trim(fi_licence).
    
    IF TRIM(nv_licence1) = ""
    OR TRIM(nv_cha_no)   = "" THEN DO:
        MESSAGE "ทะเบียนรถ หรือ เลขตัวถัง เป็นค่าว่าง" SKIP
                "กรุณาระบุข้อมูลให้ครบถ้วน !" 
        VIEW-AS ALERT-BOX ERROR.
        RETURN NO-APPLY.
    END.

    IF TRIM(fi_province) <> "" THEN DO:
        FIND FIRST brstat.insure USE-INDEX Insure05   WHERE   /*use-index fname */
                brstat.insure.compno = "999" AND 
                brstat.insure.FName  = TRIM(fi_province) NO-LOCK NO-WAIT NO-ERROR.
            IF AVAIL brstat.insure THEN  ASSIGN nv_provin = brstat.Insure.LName.
            ELSE ASSIGN nv_provin = TRIM(fi_province).
    END.
    
    nv_licence2 = trim(nv_licence1) /*+ " " + trim(nv_provin) A64-0244 */ .
    IF trim(nv_licence2) <> "" THEN DO:
       ASSIGN nv_licence2 = REPLACE(nv_licence2," ","").
       RUN proc_chkpattern. /*a63-0450*/ 

       /* comment by A63-0450... 
       IF INDEX("0123456789",SUBSTR(nv_licence2,1,1)) <> 0 THEN DO:
          IF LENGTH(nv_licence2) = 4 THEN 
             ASSIGN nv_Pattern = "y-xx-y-xx"
                    nv_licence2    = SUBSTR(nv_licence2,1,1) + " " + SUBSTR(nv_licence2,2,2) + " " + SUBSTR(nv_licence2,4,1).
          ELSE IF LENGTH(nv_licence2) = 5 THEN
              ASSIGN nv_Pattern = "y-xx-yy-xx"
                     nv_licence2    = SUBSTR(nv_licence2,1,1) + " " + SUBSTR(nv_licence2,2,2) + " " + SUBSTR(nv_licence2,4,2).
          ELSE IF LENGTH(nv_licence2) = 6 THEN DO:
              IF INDEX("0123456789",SUBSTR(nv_licence2,2,1)) <> 0 THEN
                  ASSIGN nv_Pattern = "yy-yyyy-xx"
                         nv_licence2    = SUBSTR(nv_licence2,1,2) + " " + SUBSTR(nv_licence2,3,4).
              ELSE IF INDEX("0123456789",SUBSTR(nv_licence2,3,1)) <> 0 THEN
                  ASSIGN nv_Pattern = "yx-yyyy-xx"
                         nv_licence2    = SUBSTR(nv_licence2,1,2) + " " + SUBSTR(nv_licence2,3,4).
              ELSE 
                  ASSIGN nv_Pattern = "y-xx-yyy-xx"
                         nv_licence2    = SUBSTR(nv_licence2,1,1) + " " + SUBSTR(nv_licence2,2,2) + " " + SUBSTR(nv_licence2,4,3). 
          END.
          ELSE 
              ASSIGN nv_Pattern = "y-xx-yyyy-xx"
                     nv_licence2    = SUBSTR(nv_licence2,1,1) + " " + SUBSTR(nv_licence2,2,2) + " " + SUBSTR(nv_licence2,4,4).
       END.
       ELSE DO:
           IF LENGTH(nv_licence2) = 3 THEN 
             ASSIGN nv_Pattern = "xx-y-xx"
                    nv_licence2    = SUBSTR(nv_licence2,1,2) + " "  + SUBSTR(nv_licence2,3,1) .
           ELSE IF LENGTH(nv_licence2) = 4 THEN
              ASSIGN nv_Pattern = "xx-yy-xx"
                     nv_licence2    = SUBSTR(nv_licence2,1,2) + " " + SUBSTR(nv_licence2,3,2) .
           ELSE IF LENGTH(nv_licence2) = 6 THEN
              ASSIGN nv_Pattern = "xx-yyyy-xx" 
                     nv_licence2    = SUBSTR(nv_licence2,1,2) + " " + SUBSTR(nv_licence2,3,4) .
           ELSE IF LENGTH(nv_licence2) = 5 THEN DO:
               IF INDEX("0123456789",SUBSTR(nv_licence2,2,1)) <> 0 THEN
                  ASSIGN nv_Pattern = "x-yyyy-xx"
                         nv_licence2    = SUBSTR(nv_licence2,1,1) + " " + SUBSTR(nv_licence2,2,4).
               ELSE 
                  ASSIGN nv_Pattern = "xx-yyy-xx" 
                         nv_licence2    = SUBSTR(nv_licence2,1,2) + " " + SUBSTR(nv_licence2,3,3).
           END.
           ELSE ASSIGN nv_Pattern = "xxx-yyy-xx" 
                       nv_licence2    = SUBSTR(nv_licence2,1,3) + " " + SUBSTR(nv_licence2,4,3).
       END.
       ... end A63-0448..*/
    END.
    
    CREATE "Notes.NotesSession" chSession.                              
    CREATE "Notes.NotesUIWorkSpace" chWorkSpace.    
    chDatabase = chSession:GetDatabase(nv_server,nv_tmp).    
    
    IF chDatabase:isOpen = NO THEN DO: 
        MESSAGE "Can not open Database !" VIEW-AS ALERT-BOX.
        RETURN NO-APPLY.
    END.
    ELSE DO: 
        chName   = chSession:CreateName(chSession:UserName).        
        nv_name  = chName:Abbreviated.                                          /*A64-0244*/
        nv_datim = STRING(TODAY,"99/99/9999") + " " + STRING(TIME,"HH:MM:SS").  /*A64-0244*/
        /* Check Record Duplication */        
        chWorkspace:OpenDatabase(nv_server,nv_tmp,NotesView,"",FALSE,FALSE).
        chView = chDatabase:GetView(NotesView).        

        IF VALID-HANDLE(chView) = NO THEN DO:
            nv_chkdoc = NO.
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
                        /* add by : A64-0244 */
                        chitem       = chDocument:Getfirstitem("SurveyClose").    /* สเตตัสปิดเรื่อง */
                        IF chitem <> 0 THEN nv_surcl   = chitem:TEXT. 
                        ELSE nv_surcl  = "".

                        chitem       = chDocument:Getfirstitem("docno"). 
                        IF chitem <> 0 THEN nv_docno   = chitem:TEXT. 
                        ELSE nv_docno = "".

                        nv_chkdoc = NO.
                        LEAVE loop_chkrecord.
                        /* end A64-0244 */
                        /* comment by : A64-0244  ยกเลิกเงื่อนไขการเช็คทะเบียน ...
                        nv_licen1 = chDocument:GetFirstItem("LicenseNo_1"):TEXT.
                        nv_licen2 = chDocument:GetFirstItem("LicenseNo_2"):TEXT.  
          
                        nv_key1   = nv_licen1 + IF nv_licen2 = "" THEN "" ELSE " " + nv_licen2. /* Notes */
                        nv_key3   = nv_licence1 + " " + nv_provin . /*A62-0219*/          /* PM */

                        IF INDEX(nv_key1," ") <> 0 THEN nv_key1 = REPLACE(nv_key1," ","") .
                        IF INDEX(nv_key3," ") <> 0 THEN nv_key3 = REPLACE(nv_key3," ","") .

                        IF nv_key1 = nv_key3 THEN DO:

                            chitem       = chDocument:Getfirstitem("SurveyClose").    /* สเตตัสปิดเรื่อง */
                            IF chitem <> 0 THEN nv_surcl   = chitem:TEXT. 
                            ELSE nv_surcl  = "".
                            
                            IF nv_surcl = "" THEN DO: /* ยังไม่ปิดเรื่อง */

                              chitem       = chDocument:Getfirstitem("docno"). 
                              IF chitem <> 0 THEN nv_docno   = chitem:TEXT. 
                              ELSE nv_docno = "".

                              nv_chkdoc = NO.
                              LEAVE loop_chkrecord.
                            END.
                            ELSE DO: /* ปิดเรื่องแล้ว */
                               /*  chitem       = chDocument:Getfirstitem("docno"). 
                               IF chitem <> 0 THEN nv_docno   = chitem:TEXT. 
                               ELSE nv_docno = "".

                               chitem       = chDocument:Getfirstitem("SurveyClose"). 
                               IF chitem <> 0 THEN nv_survey   = chitem:TEXT. 
                               ELSE nv_survey = "".

                               chitem       = chDocument:Getfirstitem("SurveyResult"). 
                               IF chitem <> 0 THEN nv_detail   = chitem:TEXT. 
                               ELSE nv_detail = "".
                            
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
                                 IF nv_totaldam <> "" THEN ASSIGN nv_totaldam = "รวมทั้งสิ้น " + nv_totaldam + " บาท " .
                                 
                               END.*/
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
                        ... end A64-0244 ...*/
                    END. /*  else  */
                END. /* end repeate */
            END.  
            /* End Check */
            IF nv_chkdoc = NO THEN DO:
                IF nv_docno <> ""  THEN DO:
                     RUN proc_getisp .
                     ASSIGN 
                     /*fi_remark2   = trim(nv_detail + " " + nv_damlist + " " + nv_totaldam) + " " + TRIM(nv_device + " " + nv_acctotal) */ /*comment kridtiya i. A66-0107*/
                     fi_ispdetail = trim(nv_detail + " " + nv_damlist + " " + nv_damdetail) + " " + TRIM(nv_device + " " + nv_acctotal)      /*Add kridtiya i. A66-0107*/
                     fi_inspace   = TRIM(nv_docno).                                          
                END.
            END.
            ELSE DO:
                /*IF fi_type = "RENEW"  THEN DO:*/ /*A64-0244*/
                    chDocument = chDatabase:CreateDocument.
                    ASSIGN
                        chDocument:FORM        = "Inspection"                        
                        chDocument:createdBy   = nv_name
                        chDocument:createdOn   = nv_datim 
                        chDocument:dateS       = brstat.tlt.gendat                            
                        chDocument:dateE       = brstat.tlt.expodat                           
                        chDocument:ReqType_sub = "ลูกค้า/ตัวแทน/นายหน้าเป็นผู้ส่งรูปตรวจสภาพ"
                        /*chDocument:BranchReq   = "Business Unit 3"  */ /*A64-0244*/    
                        chDocument:BranchReq   = "Bank & Finance"      /*A64-0244*/ 
                        chDocument:Tname       = "บุคคล"                             
                        chDocument:Fname       = SUBSTR(brstat.tlt.ins_name,1,INDEX(brstat.tlt.ins_name," ") - 1)                         
                        chDocument:Lname       = SUBSTR(brstat.tlt.ins_name,R-INDEX(brstat.tlt.ins_name," ") + 1)                        
                        chDocument:phone1      = ""
                        chDocument:garage      = trim(fi_garage)
                        chDocument:PolicyNo    = ""                          
                        chDocument:agentCode   = trim(fi_producer)                         
                        chDocument:agentName   = nv_brname                           
                        chDocument:Premium     = STRING(fi_gross_amt)                          
                        chDocument:model       = brstat.tlt.brand   /*nv_model    */                        
                        chDocument:modelCode   = brstat.tlt.model   /*nv_modelcode*/                        
                        chDocument:Year        = brstat.tlt.lince2                            
                        chDocument:carCC       = nv_cha_no                           
                        chDocument:LicenseType = "รถเก๋ง/กระบะ/บรรทุก"               
                        chDocument:PatternLi1  = nv_pattern                          
                        chDocument:LicenseNo_1 = nv_licence1                         
                        chDocument:LicenseNo_2 = nv_provin     
                        chDocument:App         = 0                                   
                        chDocument:Chk         = 0                                   
                        chDocument:StList      = 0                                   
                        chDocument:stHide      = 0                                   
                        chDocument:SendTo      = ""                                  
                        chDocument:SendCC      = ""                                  
                        chDocument:SendClose   = ""
                        chDocument:SurveyClose = ""                    
                        chDocument:docno       = "".   
                    chDocument:SAVE(TRUE,FALSE).
                    chWorkSpace:ViewRefresh.  
                    chUIDocument = chWorkSpace:CurrentDocument.                                         
                    chUIDocument = chWorkSpace:EditDocument(FALSE,chDocument) NO-ERROR.
                /*END.*/ /*A64-0244*/
            END.
        END.
    END.
    
    MESSAGE "Check data Inspection complete " VIEW-AS ALERT-BOX.

    RELEASE OBJECT chSession       NO-ERROR.
    RELEASE OBJECT chWorkSpace     NO-ERROR.
    RELEASE OBJECT chName          NO-ERROR.
    RELEASE OBJECT chDatabase      NO-ERROR.
    RELEASE OBJECT chView          NO-ERROR.
    RELEASE OBJECT chViewEntry     NO-ERROR.    
    RELEASE OBJECT chViewNavigator NO-ERROR.
    RELEASE OBJECT chDocument      NO-ERROR.
    RELEASE OBJECT chUIDocument    NO-ERROR.   

    DISP fi_inspace fi_remark2 WITH FRAME fr_main.
  /* end A62-0454 */
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_exit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_exit cC-Win
ON CHOOSE OF bu_exit IN FRAME fr_main /* Exit */
DO:
  Apply "Close"  To this-procedure.
  Return no-apply.
 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_save
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_save cC-Win
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
                       brstat.tlt.filler1         =  trim(input fi_policy)       /* กรมธรรม์เดิม*/
                       brstat.tlt.nor_noti_ins    =  trim(input fi_polsystem)    /* เบอร์กรมธรรม์ใหม่ */ 
                       brstat.tlt.comp_pol        =  trim(input fi_compol)       /*เลขกรมธรรม์พรบ */ 
                       brstat.tlt.comp_sub        =  trim(input fi_producer)     /* produer code */                                                                                               
                       brstat.tlt.comp_noti_ins   =  trim(input fi_agent)        /* Agent */ 
                       brstat.tlt.rec_addr1       =  trim(input fi_vatcode)      /* Vatcode */
                       brstat.tlt.EXP             =  trim(input fi_branchsaf)    /*สาขาคุ้มภัย      */
                       brstat.tlt.nor_noti_tlt    =  trim(input fi_notno)        /*เลขที่รับแจ้ง*/
                       brstat.tlt.safe2           =  trim(input fi_accno)        /*เลขที่สัญญา  */   
                       brstat.tlt.nor_usr_ins     =  trim(input fi_ins_off)      /*ผู้แจ้ง                 */ 
                       brstat.tlt.brand           =  trim(input fi_brand)        /*ยี่ห้อ           */ 
                       brstat.tlt.model           =  trim(input fi_vehuse)       /*รุ่น             */ 
                       brstat.tlt.lince2          =  trim(input fi_year)         /*ปี           */  
                       brstat.tlt.cc_weight       =  fi_ton                /*ขนาดเครื่อง  */ 
                       brstat.tlt.colorcod        =  trim(fi_color)              /*สี*/
                       brstat.tlt.eng_no          =  trim(input fi_eng_no)       /*เลขเครื่อง   */ 
                       brstat.tlt.cha_no          =  trim(input fi_cha_no)       /*เลขถัง       */ 
                       brstat.tlt.lince1          =  trim(input fi_licence)      /*เลขทะเบียน   */ 
                       brstat.tlt.lince3          =  trim(input fi_province)     /*จังหวัด          */
                       brstat.tlt.comp_usr_tlt    =  trim(input fi_covcod)       /*ความคุ้มครอง */       
                       brstat.tlt.expousr         =  trim(input fi_covcod2)      /*ประเภทประกัน   */
                       brstat.tlt.old_eng         =  TRIM(INPUT fi_comtyp)       /*ประเภท พรบ.   */
                       brstat.tlt.gendat          =  input fi_comdat             /*วันที่เริ่มคุ้มครอง     */                                                                                            
                       brstat.tlt.expodat         =  input fi_expdat             /*วันที่สิ้นสุดคุ้มครอง   */
                       brstat.tlt.nor_coamt       =  input fi_sumsi              /*ทุนประกัน        */       
                       brstat.tlt.nor_grprm       =  input fi_prem1              /*เบี้ยสุทธิกธ.    */    
                       brstat.tlt.comp_coamt      =  input fi_gross_amt          /*เบี้ยรวมกธ       */ 
                       brstat.tlt.rec_addr4       =  string(input fi_compprm)    /*เบี้ยสุทธิพรบ.    */
                       brstat.tlt.comp_grprm      =  input fi_comtotal           /*เบี้ยรวมพรบ.    */ 
                       brstat.tlt.comp_sck        =  trim(input fi_sckno)        /*เลขที่สติ๊กเกอร์ */
                       brstat.tlt.stat            =  trim(input fi_garage)       /*สถานที่ซ่อม */
                       brstat.tlt.rec_addr3       =  trim(input fi_inspace)      /*ตรวจสภาพ     */                                                                                      /*A60-0263*/
                       brstat.tlt.safe3           =  trim(input fi_class)        /*class70         */      
                       brstat.tlt.lotno           =  trim(input fi_camp)         /*แคมเปญ*/                                  
                       brstat.tlt.old_cha         =  trim(input fi_acc) + " PRICE:" + trim(INPUT fi_accprice)  /*อุปกรณ์*/ /*ราคาอุปกรณ์*/  
                       brstat.tlt.rec_name        =  trim(fi_title)                    /*คำนำหน้าชื่อผู้เอาประกันภัย */                                                                                           
                       brstat.tlt.ins_name        =  trim(fi_firstname) + " " + trim(fi_lastname)           /* ชื่อ */                          
                       brstat.tlt.ins_addr5       =  trim(fi_icno)          /*IC No */                                                                                              
                       brstat.tlt.rec_addr2       =  trim(fi_recname)     /*ชื่อออกใบกำกับภาษี*/
                       brstat.tlt.rec_addr5       =  trim(fi_recadd)      /*ที่อยู่ออกใบกำกับภาษี*/
                       brstat.tlt.ins_addr1       =  trim(fi_addr1)       /*ที่อยู่ลูกค้า1         */                                                                                                     
                       brstat.tlt.ins_addr2       =  trim(fi_addr2)       /*ที่อยู่ลูกค้า2        */ 
                       brstat.tlt.ins_addr3       =  trim(fi_addr3)       /*ที่อยู่ลูกค้า3          */ 
                       brstat.tlt.ins_addr4       =  trim(fi_addr4)      /*ที่อยู่ลูกค้า4          */ 
                       brstat.tlt.recac           =  trim(fi_occup)      /*อาชีพ*/ 
                       brstat.tlt.safe1           =  trim(fi_benname) + " Delear:" + trim(fi_dealer)  /*ดีลเลอร์ */ 
                       brstat.tlt.filler2         =  trim(fi_remark1) + " " + trim(fi_remark2)   /*หมายเหตุ  */
                       brstat.tlt.dri_name1       =  trim(fi_driv1) + " ID1:" + TRIM(fi_drivid1)
                       brstat.tlt.dri_no1         =  trim(fi_birth1) 
                       brstat.tlt.dri_name2       =  trim(fi_driv2) + " ID2:" + trim(fi_drivid2)
                       brstat.tlt.dri_no2         =  trim(fi_birth2)
                       brstat.tlt.nor_usr_tlt     =  "TAX:" + trim(fi_taxno)   +
                                                     " ID:" + trim(fi_saleid)   +   
                                                     " BR:" + trim(fi_branchtax) 
                       brstat.tlt.note1           = trim(fi_ispdetail)   .  /*Add by Kridtiya i. A66-0107*/ 
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


&Scoped-define SELF-NAME fi_acc
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_acc cC-Win
ON LEAVE OF fi_acc IN FRAME fr_main
DO:
    fi_acc = INPUT fi_acc .
    DISP fi_acc WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_accno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_accno cC-Win
ON LEAVE OF fi_accno IN FRAME fr_main
DO:
  fi_accno = INPUT fi_accno.
  DISP fi_accno WITH FRAM fr_main.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_accprice
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_accprice cC-Win
ON LEAVE OF fi_accprice IN FRAME fr_main
DO:
  fi_accprice =  Input  fi_accprice.
  Disp  fi_accprice with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_addr1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_addr1 cC-Win
ON LEAVE OF fi_addr1 IN FRAME fr_main
DO:
  fi_addr1 = INPUT fi_addr1 .
  DISP fi_addr1 WITH FRAM fr_main.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_addr2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_addr2 cC-Win
ON LEAVE OF fi_addr2 IN FRAME fr_main
DO:
  fi_addr2 = INPUT fi_addr2 .
  DISP fi_addr2 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_addr3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_addr3 cC-Win
ON LEAVE OF fi_addr3 IN FRAME fr_main
DO:
  fi_addr3 = INPUT fi_addr3 .
  DISP fi_addr3 WITH FRAM fr_main.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_addr4
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_addr4 cC-Win
ON LEAVE OF fi_addr4 IN FRAME fr_main
DO:
    fi_addr4 = INPUT fi_addr4.
    DISP fi_addr4 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_agent
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_agent cC-Win
ON LEAVE OF fi_agent IN FRAME fr_main
DO:
  fi_agent = INPUT fi_agent .
  DISP fi_agent WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_benname
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_benname cC-Win
ON LEAVE OF fi_benname IN FRAME fr_main
DO:
  fi_benname = INPUT fi_benname .
  DISP fi_benname WITH FRAM fr_main.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_birth1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_birth1 cC-Win
ON LEAVE OF fi_birth1 IN FRAME fr_main
DO:
  fi_birth1 = INPUT fi_birth1.
  DISPLAY fi_birth1 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_birth2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_birth2 cC-Win
ON LEAVE OF fi_birth2 IN FRAME fr_main
DO:
  fi_birth2 = INPUT fi_birth2 .
  DISP fi_birth2 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_branchsaf
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_branchsaf cC-Win
ON LEAVE OF fi_branchsaf IN FRAME fr_main
DO:
  fi_branchsaf = INPUT fi_branchsaf.
  DISP fi_branchsaf WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_branchtax
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_branchtax cC-Win
ON LEAVE OF fi_branchtax IN FRAME fr_main
DO:
  fi_branchtax  = INPUT fi_branchtax.
  DISP fi_branchtax WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_brand
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_brand cC-Win
ON LEAVE OF fi_brand IN FRAME fr_main
DO:
  fi_brand = INPUT fi_brand .
  DISP fi_brand WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_camp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_camp cC-Win
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
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_cha_no cC-Win
ON LEAVE OF fi_cha_no IN FRAME fr_main
DO:
  fi_cha_no  =  Input  fi_cha_no.
  Disp  fi_cha_no with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_class
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_class cC-Win
ON LEAVE OF fi_class IN FRAME fr_main
DO:
  fi_class = INPUT fi_class.
  DISP fi_class WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_color
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_color cC-Win
ON LEAVE OF fi_color IN FRAME fr_main
DO:
  fi_color  =  Input  fi_color.
  Disp  fi_color with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_comdat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_comdat cC-Win
ON LEAVE OF fi_comdat IN FRAME fr_main
DO:
  fi_comdat = INPUT fi_comdat.
  DISP fi_comdat WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_compol
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_compol cC-Win
ON LEAVE OF fi_compol IN FRAME fr_main
DO:
  fi_compol  =  Input  fi_compol.
  Disp  fi_compol with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_compprm
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_compprm cC-Win
ON LEAVE OF fi_compprm IN FRAME fr_main
DO:
  fi_compprm = INPUT fi_compprm.
  DISP fi_compprm WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_comtotal
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_comtotal cC-Win
ON LEAVE OF fi_comtotal IN FRAME fr_main
DO:
    fi_comtotal = INPUT fi_comtotal  .
    DISP fi_comtotal WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_comtyp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_comtyp cC-Win
ON LEAVE OF fi_comtyp IN FRAME fr_main
DO:
    fi_comtyp = INPUT fi_comtyp.
    DISP fi_comtyp WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_covcod
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_covcod cC-Win
ON LEAVE OF fi_covcod IN FRAME fr_main
DO:
    fi_covcod = INPUT fi_covcod .
    DISP fi_covcod WITH FRAM fr_main.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_covcod2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_covcod2 cC-Win
ON LEAVE OF fi_covcod2 IN FRAME fr_main
DO:
    fi_covcod2 = INPUT fi_covcod2.
    DISP fi_covcod2 WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_dealer
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_dealer cC-Win
ON LEAVE OF fi_dealer IN FRAME fr_main
DO:
  fi_dealer =  Input  fi_dealer.
  Disp  fi_dealer with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_driv1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_driv1 cC-Win
ON LEAVE OF fi_driv1 IN FRAME fr_main
DO:
    fi_driv1 = INPUT fi_driv1 .
    DISP fi_driv1 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_driv2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_driv2 cC-Win
ON LEAVE OF fi_driv2 IN FRAME fr_main
DO:
  fi_driv2 = INPUT fi_driv2.
  DISP fi_driv2 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_drivid1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_drivid1 cC-Win
ON LEAVE OF fi_drivid1 IN FRAME fr_main
DO:
  fi_drivid1 = INPUT fi_drivid1 .
    DISP fi_drivid1 WITH FRAM fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_drivid2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_drivid2 cC-Win
ON LEAVE OF fi_drivid2 IN FRAME fr_main
DO:
  fi_drivid2 = INPUT fi_drivid2 .
    DISP fi_drivid2 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_eng_no
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_eng_no cC-Win
ON LEAVE OF fi_eng_no IN FRAME fr_main
DO:
  fi_eng_no  =  Input  fi_eng_no.
  Disp  fi_eng_no with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_expdat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_expdat cC-Win
ON LEAVE OF fi_expdat IN FRAME fr_main
DO:
  fi_expdat = INPUT fi_expdat.
  DISP fi_expdat WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_firstname
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_firstname cC-Win
ON LEAVE OF fi_firstname IN FRAME fr_main
DO:
  fi_firstname = INPUT fi_firstname .
  DISP fi_firstname WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_garage
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_garage cC-Win
ON LEAVE OF fi_garage IN FRAME fr_main
DO:
  fi_garage =  Input  fi_garage.
  Disp  fi_garage with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_gross_amt
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_gross_amt cC-Win
ON LEAVE OF fi_gross_amt IN FRAME fr_main
DO:
  fi_gross_amt = INPUT fi_gross_amt.
  DISP fi_gross_amt WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_icno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_icno cC-Win
ON LEAVE OF fi_icno IN FRAME fr_main
DO:
    fi_icno = INPUT fi_icno .
    DISP fi_icno WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_inspace
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_inspace cC-Win
ON LEAVE OF fi_inspace IN FRAME fr_main
DO:
    fi_inspace = INPUT fi_inspace .
    DISP fi_inspace WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_ins_off
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_ins_off cC-Win
ON LEAVE OF fi_ins_off IN FRAME fr_main
DO:
  fi_ins_off = INPUT fi_ins_off .
  DISP fi_ins_off WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_ispdetail
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_ispdetail cC-Win
ON LEAVE OF fi_ispdetail IN FRAME fr_main
DO:
    fi_ispdetail = trim(INPUT fi_ispdetail).
    DISP fi_ispdetail with frame  fr_main.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_lastname
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_lastname cC-Win
ON LEAVE OF fi_lastname IN FRAME fr_main
DO:
    fi_lastname = INPUT fi_lastname .
    DISP fi_lastname WITH FRAM fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_licence
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_licence cC-Win
ON LEAVE OF fi_licence IN FRAME fr_main
DO:
  fi_licence =  Input  fi_licence.
  Disp  fi_licence with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_notno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_notno cC-Win
ON LEAVE OF fi_notno IN FRAME fr_main
DO:
  fi_notno = INPUT fi_notno .
  DISP fi_notno WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_occup
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_occup cC-Win
ON LEAVE OF fi_occup IN FRAME fr_main
DO:
    fi_occup = INPUT fi_occup .
    DISP fi_occup WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_polsystem
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_polsystem cC-Win
ON LEAVE OF fi_polsystem IN FRAME fr_main
DO:
  fi_polsystem  =  Input  fi_polsystem.
  Disp  fi_polsystem with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_prem1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_prem1 cC-Win
ON LEAVE OF fi_prem1 IN FRAME fr_main
DO:
  fi_prem1 = INPUT fi_prem1 .
  DISP fi_prem1 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_producer
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_producer cC-Win
ON LEAVE OF fi_producer IN FRAME fr_main
DO:
  fi_producer = INPUT fi_producer .
  DISP fi_producer WITH FRAM fr_main.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_province
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_province cC-Win
ON LEAVE OF fi_province IN FRAME fr_main
DO:
  fi_province =  Input  fi_province.
  Disp  fi_province with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_recadd
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_recadd cC-Win
ON LEAVE OF fi_recadd IN FRAME fr_main
DO:
    fi_recadd = trim(INPUT fi_recadd).
    DISP fi_recadd with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_recname
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_recname cC-Win
ON LEAVE OF fi_recname IN FRAME fr_main
DO:
    fi_recname = trim(INPUT fi_recname).
    DISP fi_recname with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_remark1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_remark1 cC-Win
ON LEAVE OF fi_remark1 IN FRAME fr_main
DO:
    fi_remark1 = trim(INPUT fi_remark1).
    DISP fi_remark1 with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_remark2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_remark2 cC-Win
ON LEAVE OF fi_remark2 IN FRAME fr_main
DO:
    fi_remark2 = trim(INPUT fi_remark2).
    DISP fi_remark2 with frame  fr_main.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_saleid
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_saleid cC-Win
ON LEAVE OF fi_saleid IN FRAME fr_main
DO:
  fi_saleid = INPUT fi_saleid .
  DISP fi_saleid WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_sckno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_sckno cC-Win
ON LEAVE OF fi_sckno IN FRAME fr_main
DO:
  fi_sckno = INPUT fi_sckno .
  DISP fi_sckno WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_sumsi
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_sumsi cC-Win
ON LEAVE OF fi_sumsi IN FRAME fr_main
DO:
    fi_sumsi = INPUT fi_sumsi.
    DISP fi_sumsi WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_taxno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_taxno cC-Win
ON LEAVE OF fi_taxno IN FRAME fr_main
DO:
    fi_taxno = INPUT fi_taxno.
    DISP fi_taxno WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_title
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_title cC-Win
ON LEAVE OF fi_title IN FRAME fr_main
DO:
  fi_title = INPUT fi_title.
  DISP fi_title WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_ton
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_ton cC-Win
ON LEAVE OF fi_ton IN FRAME fr_main
DO:
  fi_ton  =  Input  fi_ton.
  Disp  fi_ton with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_trndat1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_trndat1 cC-Win
ON LEAVE OF fi_trndat1 IN FRAME fr_main /* Trndat */
DO:
   /* fi_trndat1 = INPUT fi_trndat1.
    DISP fi_trndat1 WITH FRAME fr_main.*/
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_vehuse
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_vehuse cC-Win
ON LEAVE OF fi_vehuse IN FRAME fr_main
DO:
  fi_vehuse =  Input  fi_vehuse.
  Disp  fi_vehuse with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_year
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_year cC-Win
ON LEAVE OF fi_year IN FRAME fr_main
DO:
  fi_year = INPUT fi_year .
  DISP fi_year WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK cC-Win 


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
  
  gv_prgid = "wgwqori1".
  gv_prog  = "Query & Update Data  (orico) ".
  RUN  WUT\WUTHEAD ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).
/*********************************************************************/ 
 /*  RUN Wut\WutwiCen ({&WINDOW-NAME}:HANDLE). */ 
  /*CURRENT-WINDOW:WINDOW-STATE = WINDOW-MAXIMIZED.*/
  SESSION:DATA-ENTRY-RETURN = YES.
  
  Find  brstat.tlt  Where  Recid(brstat.tlt)  =  nv_recidtlt NO-LOCK NO-ERROR NO-WAIT .
  If  avail  brstat.tlt  Then do:
         RUN proc_assignfi.
         DISP                                                                                                     
         fi_type      fi_ldate     fi_ltime     fi_trndat    fi_comtotal                              
         fi_accno     fi_notno     fi_year      fi_eng_no    fi_cha_no    fi_ton       
         fi_licence   fi_garage    fi_province  fi_brand     fi_sckno     fi_sumsi     
         fi_gross_amt fi_prem1     fi_compprm   fi_dealer    fi_inspace   fi_color
         fi_vehuse    fi_comdat    fi_expdat    fi_covcod2   fi_accprice  fi_acc
         fi_ins_off   fi_addr1     fi_addr2     fi_addr3     fi_addr4     fi_branchsaf
         fi_driv1     fi_drivid1   fi_birth1    fi_driv2     fi_drivid2   fi_birth2    
         fi_class     fi_benname   fi_userid    fi_branchtax fi_saleid    fi_taxno          
         fi_compol    fi_covcod    fi_policy    fi_producer  fi_agent     fi_remark1   
         fi_remark2   fi_title     fi_firstname fi_lastname  fi_icno      fi_polsystem    
         fi_paydate   fi_polstatus fi_recname   fi_recadd    fi_nottime   fi_comtyp
         fi_vatcode   fi_camp      fi_trndat1   fi_occup    fi_ispdetail  With frame  fr_main. 

        /* IF INDEX(brstat.tlt.releas,"YES") <> 0 THEN DO:
            DISABLE  fi_type      fi_ldate     fi_ltime     fi_trndat    fi_comtotal                              
            fi_accno     fi_notno     fi_year      fi_eng_no    fi_cha_no    fi_ton       
            fi_licence   fi_garage    fi_province  fi_brand     fi_sckno     fi_sumsi     
            fi_gross_amt fi_prem1     fi_compprm   fi_dealer    fi_inspace   fi_color
            fi_vehuse    fi_comdat    fi_expdat    fi_covcod2   fi_accprice  fi_acc
            fi_ins_off   fi_addr1     fi_addr2     fi_addr3     fi_addr4     fi_branchsaf
            fi_driv1     fi_drivid1   fi_birth1    fi_driv2     fi_drivid2   fi_birth2    
            fi_class     fi_benname   fi_userid    fi_branchtax fi_saleid    fi_taxno          
            fi_compol    fi_covcod    fi_policy    fi_producer  fi_agent     fi_remark1   
            fi_remark2   fi_title     fi_firstname fi_lastname  fi_icno      fi_polsystem    
            fi_paydate   fi_polstatus fi_recname   fi_recadd    fi_nottime   fi_comtyp
            fi_vatcode   fi_camp      fi_trndat1   fi_occup      bu_save     buchk With frame  fr_main.  
            bu_save:BGCOLOR = 18.
            buchk:BGCOLOR = 18.
         END.*/
  END.
  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI cC-Win  _DEFAULT-DISABLE
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
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(cC-Win)
  THEN DELETE WIDGET cC-Win.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI cC-Win  _DEFAULT-ENABLE
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
  DISPLAY fi_vatcode fi_taxno fi_policy fi_covcod2 fi_saleid fi_type 
          fi_polstatus fi_paydate fi_polsystem fi_compol fi_producer fi_agent 
          fi_nottime fi_branchsaf fi_notno fi_accno fi_comtotal fi_ins_off 
          fi_brand fi_vehuse fi_year fi_ton fi_eng_no fi_cha_no fi_licence 
          fi_province fi_covcod fi_dealer fi_accprice fi_comdat fi_expdat 
          fi_sumsi fi_gross_amt fi_compprm fi_sckno fi_prem1 fi_garage fi_acc 
          fi_title fi_firstname fi_lastname fi_icno fi_addr1 fi_addr2 fi_addr3 
          fi_addr4 fi_driv1 fi_birth1 fi_drivid1 fi_driv2 fi_birth2 fi_drivid2 
          fi_benname fi_remark1 fi_remark2 fi_ldate fi_ltime fi_trndat fi_userid 
          fi_class fi_inspace fi_recname fi_recadd fi_camp fi_branchtax fi_color 
          fi_trndat1 fi_occup fi_comtyp fi_ispdetail 
      WITH FRAME fr_main IN WINDOW cC-Win.
  ENABLE buchk fi_vatcode fi_taxno fi_policy fi_covcod2 fi_saleid fi_polstatus 
         fi_polsystem fi_compol fi_producer fi_agent fi_nottime fi_branchsaf 
         fi_notno fi_accno fi_comtotal fi_ins_off fi_brand fi_vehuse fi_year 
         fi_ton fi_eng_no fi_cha_no fi_licence fi_province fi_covcod fi_dealer 
         fi_accprice fi_comdat fi_expdat fi_sumsi fi_gross_amt fi_compprm 
         fi_sckno fi_prem1 fi_garage fi_acc fi_title fi_firstname fi_lastname 
         fi_icno fi_addr1 fi_addr2 fi_addr3 fi_addr4 fi_driv1 fi_birth1 
         fi_drivid1 fi_driv2 fi_birth2 fi_drivid2 fi_benname fi_remark1 
         fi_remark2 bu_save bu_exit fi_class fi_inspace fi_recname fi_recadd 
         fi_camp fi_branchtax fi_color fi_occup fi_comtyp fi_ispdetail RECT-335 
         RECT-381 RECT-382 RECT-383 RECT-385 RECT-386 
      WITH FRAME fr_main IN WINDOW cC-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW cC-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assignfi cC-Win 
PROCEDURE proc_assignfi :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
Assign
          fi_type       = IF brstat.tlt.flag = "N" THEN "NEW" ELSE "RENEW"
          fi_policy     = brstat.tlt.filler1             /* กรมธรรม์เดิม*/
          fi_polsystem  = brstat.tlt.nor_noti_ins           /* เบอร์กรมธรรม์ใหม่ */ 
          fi_compol     = brstat.tlt.comp_pol            /*เลขกรมธรรม์พรบ */ 
          fi_ldate      = brstat.tlt.entdat              /* วันที่โหลด */  
          fi_ltime      = brstat.tlt.enttim              /* เวลาโหลด   */  
          fi_producer   = brstat.tlt.comp_sub            /* produer code */                                                                                               
          fi_agent      = brstat.tlt.comp_noti_ins       /* Agent */ 
          fi_vatcode    = brstat.tlt.rec_addr1            /* Vatcode */
          fi_trndat     = brstat.tlt.datesent              /* วันที่ไฟล์แจ้งงาน */ 
          fi_nottime    = brstat.tlt.trntim              /* เวลาแจ้งงาน */
          fi_branchsaf  = brstat.tlt.EXP                 /*สาขาคุ้มภัย      */
          fi_notno      = brstat.tlt.nor_noti_tlt        /*เลขที่รับแจ้ง*/
          fi_accno      = brstat.tlt.safe2               /*เลขที่สัญญา  */   
          fi_ins_off    = brstat.tlt.nor_usr_ins         /*ผู้แจ้ง                 */ 
          fi_brand      = brstat.tlt.brand               /*ยี่ห้อ           */ 
          fi_vehuse     = brstat.tlt.model               /*รุ่น             */ 
          fi_year       = brstat.tlt.lince2              /*ปี           */  
          fi_ton        = brstat.tlt.cc_weight           /*ขนาดเครื่อง  */ 
          fi_color      = brstat.tlt.colorcod            /*สี*/
          fi_eng_no     = brstat.tlt.eng_no              /*เลขเครื่อง   */ 
          fi_cha_no     = brstat.tlt.cha_no              /*เลขถัง       */ 
          fi_licence    = brstat.tlt.lince1              /*เลขทะเบียน   */ 
          fi_province   = brstat.tlt.lince3              /*จังหวัด          */
          fi_covcod     = trim(brstat.tlt.comp_usr_tlt)  /*ความคุ้มครอง */       
          fi_covcod2    = TRIM(brstat.tlt.expousr)       /*ประเภทประกัน   */ 
          fi_comtyp     = TRIM(brstat.tlt.OLD_eng)       /*ประเภท พรบ.  */
          fi_comdat     = brstat.tlt.gendat              /*วันที่เริ่มคุ้มครอง     */                                                                                            
          fi_expdat     = brstat.tlt.expodat             /*วันที่สิ้นสุดคุ้มครอง   */
          fi_sumsi      = brstat.tlt.nor_coamt           /*ทุนประกัน        */       
          fi_prem1      = brstat.tlt.nor_grprm           /*เบี้ยสุทธิกธ.    */    
          fi_gross_amt  = brstat.tlt.comp_coamt          /*เบี้ยรวมกธ       */ 
          fi_compprm    = deci(brstat.tlt.rec_addr4)     /*เบี้ยสุทธิพรบ.    */
          fi_comtotal   = brstat.tlt.comp_grprm          /*เบี้ยรวมพรบ.    */ 
          fi_sckno      = brstat.tlt.comp_sck            /*เลขที่สติ๊กเกอร์ */
          fi_garage     = TRIM(brstat.tlt.stat)          /*สถานที่ซ่อม */
          fi_inspace    = brstat.tlt.rec_addr3           /*ตรวจสภาพ     */                                                                                      /*A60-0263*/
          fi_class      = trim(brstat.tlt.safe3)            /*class70         */      
          fi_camp       = brstat.tlt.lotno                 /*แคมเปญ*/                                  
          fi_accprice   = IF trim(brstat.tlt.old_cha) <> "PRICE:" THEN substr(brstat.tlt.old_cha,R-INDEX(brstat.tlt.old_cha,"PRICE:") + 6)  ELSE ""           /*ราคาอุปกรณ์*/                                                                               
          fi_acc        = IF trim(brstat.tlt.old_cha) <> "PRICE:" THEN substr(brstat.tlt.old_cha,1,INDEX(brstat.tlt.old_cha,"PRICE:") - 2)  ELSE ""          /*อุปกรณ์*/                                                                                               
          fi_title      = brstat.tlt.rec_name                          /*คำนำหน้าชื่อผู้เอาประกันภัย */                                                                                           
          nv_index      = Index(brstat.tlt.ins_name," ")      /* ชื่อ */                          
          fi_firstname  = IF index(fi_title,"บจก") <> 0 AND index(fi_title,"มูลนิธิ") <> 0 AND  
                          index(fi_title,"หจก") <> 0 AND  index(fi_title,"บริษัท") <> 0 THEN 
                          TRIM(brstat.tlt.ins_name)  ELSE Substr(brstat.tlt.ins_name,1,R-INDEX(brstat.tlt.ins_name," "))               
          fi_lastname   = IF index(fi_title,"บจก") <> 0 AND index(fi_title,"มูลนิธิ") <> 0 AND  
                          index(fi_title,"หจก") <> 0 AND  index(fi_title,"บริษัท") <> 0 THEN ""
                          ELSE Substr(brstat.tlt.ins_name,R-INDEX(brstat.tlt.ins_name," ") + 1,length(brstat.tlt.ins_name))                                                                                                 
          fi_icno       = TRIM(brstat.tlt.ins_addr5)           /*IC No */                                                                                              
          fi_recname    = brstat.tlt.rec_addr2         /*ชื่อออกใบกำกับภาษี*/
          fi_recadd     = brstat.tlt.rec_addr5         /*ที่อยู่ออกใบกำกับภาษี*/
          fi_addr1      = brstat.tlt.ins_addr1         /*ที่อยู่ลูกค้า1         */                                                                                                     
          fi_addr2      = brstat.tlt.ins_addr2         /*ที่อยู่ลูกค้า2        */ 
          fi_addr3      = brstat.tlt.ins_addr3         /*ที่อยู่ลูกค้า3          */ 
          fi_addr4      = trim(brstat.tlt.ins_addr4)   /*ที่อยู่ลูกค้า4          */ 
          fi_occup      = brstat.tlt.recac             /*อาชีพ*/
          n_length      = LENGTH(brstat.tlt.safe1)                                                 
          fi_benname    = IF trim(brstat.tlt.safe1) <> "Delear:" THEN trim(SUBSTR(brstat.tlt.safe1,1,R-INDEX(brstat.tlt.safe1,"Delear:") - 1)) ELSE ""   /*ผู้รับผลประโยชน์*/      
          fi_dealer     = IF trim(brstat.tlt.safe1) <> "Delear:" THEN trim(SUBSTR(brstat.tlt.safe1,R-INDEX(brstat.tlt.safe1,"Delear:") + 7,n_length)) ELSE ""  /*ดีลเลอร์ */      
          fi_remark1    = IF LENGTH(brstat.tlt.filler2) <> 0  then SUBSTR(brstat.tlt.filler2,1,100)  else ""     /*หมายเหตุ  */                                
          fi_remark2    = IF LENGTH(brstat.tlt.filler2) > 100  then SUBSTR(brstat.tlt.filler2,101,100) else ""     /*หมายเหตุ  */
          fi_paydate    = brstat.tlt.dat_ins_noti       /*วันที่ matchfile confirm */
          fi_polstatus  = IF brstat.tlt.releas = "NO" THEN "ยังไม่ออกงาน" ELSE IF INDEX(brstat.tlt.releas,"Cancel") <> 0 THEN "ยกเลิก" ELSE "ออกงานแล้ว"
          fi_trndat1    = brstat.tlt.entdat
          fi_userid     = brstat.tlt.usrid                /*User Load Data */
          fi_ispdetail  = brstat.tlt.note1  .  /*Add by Kridtiya i. A66-0107*/ 

          IF brstat.tlt.dri_name1 <> "" AND TRIM(brstat.tlt.dri_name1) <> "ID1:" THEN DO:
              ASSIGN
                n_char        = trim(brstat.tlt.dri_name1) /* ผู้ขับขี่ 1 */
                n_length      = LENGTH(n_char)
                fi_driv1      = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"ID1:") - 1))         /*ระบุผู้ขับขี้1    */  
                fi_drivid1    = TRIM(SUBSTR(n_char,R-INDEX(n_char,"ID1:") + 4,n_length))  /*เลขที่ใบขับขี่1   */ 
                fi_birth1     = trim(brstat.tlt.dri_no1 ). /*วันเดือนปีเกิด1   */ 
          END.
          ELSE ASSIGN fi_drivid1   = ""     fi_driv1     = ""   fi_birth1    = "".

          IF brstat.tlt.dri_name2 <> "" AND TRIM(brstat.tlt.dri_name2) <> "ID2:"THEN DO:
              ASSIGN 
                n_char        = trim(brstat.tlt.dri_name2)  /*ผู้ขับขี่ 2*/ 
                n_length      = LENGTH(n_char)
                fi_driv2      = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"ID2:") - 1))          /*ระบุผู้ขับขี้2      */  
                fi_drivid2    = TRIM(SUBSTR(n_char,R-INDEX(n_char,"ID2:") + 4,n_length))   /*เลขที่ใบขับขี่2     */ 
                fi_birth2     = trim(brstat.tlt.dri_no2). /*วันเดือนปีเกิด2*/
          END.
          ELSE  ASSIGN fi_drivid2   = ""     fi_driv2     = ""    fi_birth2    = "".  

        IF brstat.tlt.nor_usr_tlt <> "" AND TRIM(brstat.tlt.nor_usr_tlt) <> "TAX: ID: BR:" THEN DO:
            ASSIGN
            n_char        = trim(brstat.tlt.nor_usr_tlt)
            n_length      = LENGTH(n_char)
            n_br          = IF INDEX(n_char,"BR:") <> 0 THEN trim(SUBSTR(n_char,R-INDEX(n_char,"BR:"),n_length)) ELSE ""   /*wht 72*/
            n_char        = IF INDEX(n_char,"BR:") <> 0 THEN SUBSTR(n_char,1,INDEX(n_char,"BR:")) ELSE SUBSTR(n_char,1,n_length) 
            n_length      = LENGTH(n_char)
            n_ID2         = IF INDEX(n_char,"ID:") <> 0 THEN trim(SUBSTR(n_char,R-INDEX(n_char,"ID:"),n_length)) ELSE ""    /*wht70              */
            n_ID1         = IF INDEX(n_char,"TAX:") <> 0 THEN trim(SUBSTR(n_char,1,INDEX(n_char,"ID:"))) 
                            ELSE ""       /*ทุนหาย           */
            fi_taxno     = if n_ID1  <> "TAX:" then  substr(n_id1,5,(LENGTH(n_id1) - 5 ))  else ""
            fi_saleid    = if n_ID2  <> "ID:"  then  substr(n_id2,4,(LENGTH(n_id2) - 5 ))  else ""
            fi_branchtax = if n_br   <> "BR:"  then  substr(n_br,4,LENGTH(n_br))   else ""  .
          END.
          ELSE  ASSIGN  fi_saleid    = ""    fi_taxno = ""   fi_branchtax = "".
         
         
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chkpattern cC-Win 
PROCEDURE proc_chkpattern :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: create by A63-0450        
------------------------------------------------------------------------------*/
DO:
   /* IF INDEX("0123456789",SUBSTR(wdetail.licence,1,1)) <> 0 THEN DO:
          IF LENGTH(nv_licen) = 4 THEN 
             ASSIGN nv_Pattern1 = "yxx-y-xx"
                    nv_licen    = SUBSTR(nv_licen,1,3) + " " + SUBSTR(nv_licen,4,1).
          ELSE IF LENGTH(nv_licen) = 5 THEN
              ASSIGN nv_Pattern1 = "yxx-yy-xx"
                     nv_licen    = SUBSTR(nv_licen,1,3) + " " + SUBSTR(nv_licen,4,2).
          ELSE IF LENGTH(nv_licen) = 6 THEN DO:
              IF INDEX("0123456789",SUBSTR(nv_licen,2,1)) <> 0 THEN
                  ASSIGN nv_Pattern1 = "yy-yyyy-xx"
                         nv_licen    = SUBSTR(nv_licen,1,2) + " " + SUBSTR(nv_licen,3,4).
              ELSE IF INDEX("0123456789",SUBSTR(nv_licen,3,1)) <> 0 THEN
                  ASSIGN nv_Pattern1 = "yx-yyyy-xx"
                         nv_licen    = SUBSTR(nv_licen,1,2) + " " + SUBSTR(nv_licen,3,4).
              ELSE 
                  ASSIGN nv_Pattern1 = "yxx-yyy-xx"
                         nv_licen    = SUBSTR(nv_licen,1,3) + " " + SUBSTR(nv_licen,4,3). 
          END.
          ELSE 
              ASSIGN nv_Pattern1 = "yxx-yyyy-xx"
                     nv_licen    = SUBSTR(nv_licen,1,3) + " " + SUBSTR(nv_licen,4,4).
       END.
       ELSE DO:
           IF LENGTH(nv_licen) = 3 THEN 
             ASSIGN nv_Pattern1 = "xx-y-xx"
                    nv_licen    = SUBSTR(nv_licen,1,2) + " "  + SUBSTR(nv_licen,3,1) .
           ELSE IF LENGTH(nv_licen) = 4 THEN
              ASSIGN nv_Pattern1 = "xx-yy-xx"
                     nv_licen    = SUBSTR(nv_licen,1,2) + " " + SUBSTR(nv_licen,3,2) .
           ELSE IF LENGTH(nv_licen) = 6 THEN
              IF INDEX("0123456789",SUBSTR(nv_licen,3,1)) <> 0 THEN
              ASSIGN nv_Pattern1 = "xx-yyyy-xx" 
                     nv_licen    = SUBSTR(nv_licen,1,2) + " " + SUBSTR(nv_licen,3,4) .
              ELSE ASSIGN nv_Pattern1 = "xxx-yyy-xx" 
                     nv_licen    = SUBSTR(nv_licen,1,2) + " " + SUBSTR(nv_licen,3,4) .
           ELSE IF LENGTH(nv_licen) = 5 THEN DO:
               IF INDEX("0123456789",SUBSTR(nv_licen,2,1)) <> 0 THEN
                  ASSIGN nv_Pattern1 = "x-yyyy-xx"
                         nv_licen    = SUBSTR(nv_licen,1,1) + " " + SUBSTR(nv_licen,2,4).
               ELSE 
                  ASSIGN nv_Pattern1 = "xx-yyy-xx" 
                         nv_licen    = SUBSTR(nv_licen,1,2) + " " + SUBSTR(nv_licen,3,3).
           END.
       END.
END.*/



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
              ASSIGN nv_Pattern = "xx-yyyy-xx" 
                     nv_licence2    = SUBSTR(nv_licence2,1,2) + " " + SUBSTR(nv_licence2,3,4) .
           ELSE IF LENGTH(nv_licence2) = 5 THEN DO:
               IF INDEX("0123456789",SUBSTR(nv_licence2,2,1)) <> 0 THEN
                  ASSIGN nv_Pattern = "x-yyyy-xx"
                         nv_licence2    = SUBSTR(nv_licence2,1,1) + " " + SUBSTR(nv_licence2,2,4).
               ELSE 
                  ASSIGN nv_Pattern = "xx-yyy-xx" 
                         nv_licence2    = SUBSTR(nv_licence2,1,2) + " " + SUBSTR(nv_licence2,3,3).
           END.
           ELSE ASSIGN nv_Pattern   = "xxx-yyy-xx" 
                       nv_licence2  = SUBSTR(nv_licence2,1,3) + " " + SUBSTR(nv_licence2,4,3).
       END.

END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_getisp cC-Win 
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
          chitem       = chDocument:Getfirstitem("TotalExpensive").  /* ราคาความเสียหาย */
          IF chitem <> 0 THEN nv_totaldam  = chitem:TEXT.
          ELSE nv_totaldam = "".

          IF nv_damlist <> "" THEN DO: 
              ASSIGN    n_list     = INT(nv_damlist) 
                        nv_damlist = " " + nv_damlist + " รายการ " .
          END.
          IF nv_totaldam <> "" THEN ASSIGN nv_totaldam = "รวมความเสียหาย " + nv_totaldam + " บาท " .
          
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
          nv_acctotal = " ราคารวม" + nv_acctotal + " บาท " .

      END.

END.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

