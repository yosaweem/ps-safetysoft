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
  wgwqtnc2.w :  Quey & Update , Add data in table  tlt (Thanachat)
  Create  by    :  Ranu i. A59-0316  On   08/07/2016
-------------------------------------------------------------------------*/
/*Modify by : Ranu I. A59-0471 ปรับเพิ่มเงื่อนไขการเช็ค Status policy    */
/*Modify by : Ranu I. A60-0383 Date. 01/09/2017 เพิ่มช่องหมายเหตุการแจ้งงาน 
             ช่อง แคมเปญ ,ช่อง Loss Ratio เช็คการแสดงข้อมูลเลขบัตร ปปช.*/
/*Modify by : Ranu I. A61-0512 Date : 07/11/2018 เพิ่มช่อง ISP NO  */
/*Modify by : Ranu I. A64-0205 Date : 05/05/2021 เพิ่มผลการตรวจสภาพ  */
/*----------------------------------------------------------------------*/
Def  Input  parameter  nv_recidtlt  as  recid  .
Def  var nv_index  as int  init 0.
DEF  VAR nv_chaidrep AS CHAR . /*A57-0262*/
DEF VAR n_length    AS INT .
DEF VAR n_exp       AS CHAR FORMAT "x(15)".
DEF VAR n_IC        AS CHAR FORMAT "x(15)".
DEF VAR n_Com       AS CHAR FORMAT "x(15)".
DEF VAR n_addr5     AS CHAR FORMAT "x(50)".
/* add by A64-0205  */
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
&Scoped-Define ENABLED-OBJECTS bu_chk fi_polstatus fi_polsystem fi_policy ~
fi_compol fi_producer fi_agent fi_pro_off fi_branch fi_notno fi_accno ~
fi_cmrcode fi_notdat fi_notcode fi_ins_off fi_brand fi_vehuse fi_year ~
fi_ton fi_eng_no fi_cha_no fi_licence fi_province fi_covcod fi_tp1 ~
fi_not_off fi_deduct fi_fleetper fi_ncbper fi_othper fi_comdat fi_expdat ~
fi_sumsi fi_gross_amt fi_comdat72 fi_expdat72 fi_compprm fi_sckno fi_prem1 ~
fi_garage fi_tp2 fi_title fi_firstname fi_lastname fi_icno fi_comm fi_exp ~
fi_addr1 fi_addr2 fi_addr3 fi_addr4 fi_driv1 fi_birth1 fi_drivid1 ~
fi_drivic1 fi_driv2 fi_birth2 fi_drivid2 fi_drivic2 fi_benname fi_client ~
fi_remark1 fi_remark2 bu_save bu_exit fi_error fi_camp fi_loss fi_ispno ~
fi_reisp RECT-335 RECT-381 RECT-382 RECT-383 RECT-384 RECT-385 
&Scoped-Define DISPLAYED-OBJECTS fi_polstatus fi_paydate fi_status ~
fi_polsystem fi_policy fi_compol fi_producer fi_agent fi_pro_off fi_branch ~
fi_notno fi_accno fi_cmrcode fi_notdat fi_notcode fi_ins_off fi_brand ~
fi_vehuse fi_year fi_ton fi_eng_no fi_cha_no fi_licence fi_province ~
fi_covcod fi_tp1 fi_not_off fi_deduct fi_fleetper fi_ncbper fi_othper ~
fi_comdat fi_expdat fi_sumsi fi_gross_amt fi_comdat72 fi_expdat72 ~
fi_compprm fi_sckno fi_prem1 fi_garage fi_tp2 fi_title fi_firstname ~
fi_lastname fi_icno fi_comm fi_exp fi_addr1 fi_addr2 fi_addr3 fi_addr4 ~
fi_driv1 fi_birth1 fi_drivid1 fi_drivic1 fi_driv2 fi_birth2 fi_drivid2 ~
fi_drivic2 fi_benname fi_client fi_remark1 fi_remark2 fi_userid fi_ldate ~
fi_ltime fi_trndat fi_error fi_camp fi_loss fi_ispno fi_reisp 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bu_chk 
     LABEL "CHK-ISP" 
     SIZE 9 BY 1.14
     BGCOLOR 7 FONT 1.

DEFINE BUTTON bu_exit 
     LABEL "Exit" 
     SIZE 8 BY 1
     FONT 6.

DEFINE BUTTON bu_save 
     LABEL "Save" 
     SIZE 8 BY 1
     FONT 6.

DEFINE VARIABLE fi_accno AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 21 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_addr1 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 48 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_addr2 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 48.17 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_addr3 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 48 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_addr4 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 48.17 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_agent AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 14.17 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_benname AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 38.17 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_birth1 AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 13 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_birth2 AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 13 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_branch AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 5.17 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_brand AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 21.5 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_camp AS CHARACTER FORMAT "X(20)":U INITIAL ? 
     VIEW-AS FILL-IN 
     SIZE 18 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_cha_no AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 23 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_client AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 19.5 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_cmrcode AS CHARACTER FORMAT "X(35)":U 
     VIEW-AS FILL-IN 
     SIZE 25 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_comdat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_comdat72 AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_comm AS CHARACTER FORMAT "x(15)":U 
     VIEW-AS FILL-IN 
     SIZE 16 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_compol AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 20 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_compprm AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 12 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_covcod AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 5.83 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_deduct AS DECIMAL FORMAT "->,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_driv1 AS CHARACTER FORMAT "X(60)":U 
     VIEW-AS FILL-IN 
     SIZE 30 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_driv2 AS CHARACTER FORMAT "X(60)":U 
     VIEW-AS FILL-IN 
     SIZE 30 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_drivic1 AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_drivic2 AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_drivid1 AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_drivid2 AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_eng_no AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 23 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_error AS CHARACTER FORMAT "X(150)":U 
     VIEW-AS FILL-IN 
     SIZE 109 BY .86
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_exp AS CHARACTER FORMAT "X(12)":U 
     VIEW-AS FILL-IN 
     SIZE 16 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_expdat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_expdat72 AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_firstname AS CHARACTER FORMAT "X(75)":U 
     VIEW-AS FILL-IN 
     SIZE 23.5 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_fleetper AS DECIMAL FORMAT ">>,>>9.99-":U INITIAL ? 
     VIEW-AS FILL-IN 
     SIZE 14.33 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_garage AS CHARACTER FORMAT "X(20)":U INITIAL ? 
     VIEW-AS FILL-IN 
     SIZE 13.83 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_gross_amt AS DECIMAL FORMAT "->>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 15.17 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_icno AS CHARACTER FORMAT "X(13)":U 
     VIEW-AS FILL-IN 
     SIZE 20.33 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_ins_off AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 28.5 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_ispno AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 16.33 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_lastname AS CHARACTER FORMAT "X(45)":U 
     VIEW-AS FILL-IN 
     SIZE 26 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_ldate AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 15.33 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_licence AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 10 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_loss AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 5.67 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_ltime AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 11 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_ncbper AS DECIMAL FORMAT ">>,>>9.99-":U INITIAL ? 
     VIEW-AS FILL-IN 
     SIZE 17.17 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_notcode AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_notdat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_notno AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 22 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_not_off AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 31.33 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_othper AS DECIMAL FORMAT ">>>>9.99":U INITIAL ? 
     VIEW-AS FILL-IN 
     SIZE 15.17 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_paydate AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 16.5 BY 1
     BGCOLOR 19 FGCOLOR 6 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_policy AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 20 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

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
     SIZE 15 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_producer AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_province AS CHARACTER FORMAT "X(35)":U 
     VIEW-AS FILL-IN 
     SIZE 18 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_pro_off AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 34.67 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_reisp AS CHARACTER FORMAT "X(200)":U 
     VIEW-AS FILL-IN 
     SIZE 108.67 BY .86
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_remark1 AS CHARACTER FORMAT "X(85)":U 
     VIEW-AS FILL-IN 
     SIZE 108.67 BY .86
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_remark2 AS CHARACTER FORMAT "X(85)":U 
     VIEW-AS FILL-IN 
     SIZE 108.67 BY .86
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_sckno AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 23 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_status AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 19.33 BY 1
     BGCOLOR 19 FGCOLOR 6 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_sumsi AS INTEGER FORMAT ">>>,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 18.33 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_title AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 11 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_ton AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 12 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_tp1 AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 40 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_tp2 AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 27 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_trndat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 22 BY .95
     BGCOLOR 10 FGCOLOR 4 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_userid AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 9 BY 1
     BGCOLOR 7 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_vehuse AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 29.17 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_year AS CHARACTER FORMAT "X(4)":U INITIAL "0" 
     VIEW-AS FILL-IN 
     SIZE 7.33 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE RECTANGLE RECT-335
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132.67 BY 27.52
     BGCOLOR 19 FGCOLOR 2 .

DEFINE RECTANGLE RECT-381
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 10.5 BY 1.52
     BGCOLOR 5 FGCOLOR 2 .

DEFINE RECTANGLE RECT-382
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 10.5 BY 1.52
     BGCOLOR 4 .

DEFINE RECTANGLE RECT-383
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 131 BY 4.95
     BGCOLOR 29 .

DEFINE RECTANGLE RECT-384
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 131 BY 11.14.

DEFINE RECTANGLE RECT-385
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 131 BY 7.62.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     bu_chk AT ROW 22 COL 121 WIDGET-ID 10
     fi_polstatus AT ROW 27.19 COL 88.67 COLON-ALIGNED NO-LABEL
     fi_paydate AT ROW 27.19 COL 55.5 COLON-ALIGNED NO-LABEL
     fi_status AT ROW 27.14 COL 19.17 COLON-ALIGNED NO-LABEL
     fi_polsystem AT ROW 1.24 COL 65.5 COLON-ALIGNED NO-LABEL
     fi_policy AT ROW 1.24 COL 18.83 COLON-ALIGNED NO-LABEL
     fi_compol AT ROW 1.24 COL 99.17 COLON-ALIGNED NO-LABEL
     fi_producer AT ROW 3.29 COL 77.67 COLON-ALIGNED NO-LABEL
     fi_agent AT ROW 3.29 COL 106.33 COLON-ALIGNED NO-LABEL
     fi_pro_off AT ROW 4.33 COL 62 COLON-ALIGNED NO-LABEL
     fi_branch AT ROW 4.33 COL 105 COLON-ALIGNED NO-LABEL
     fi_notno AT ROW 5.29 COL 18.17 COLON-ALIGNED NO-LABEL
     fi_accno AT ROW 5.33 COL 54.5 COLON-ALIGNED NO-LABEL
     fi_cmrcode AT ROW 5.33 COL 95.5 COLON-ALIGNED NO-LABEL
     fi_notdat AT ROW 6.29 COL 18.17 COLON-ALIGNED NO-LABEL
     fi_notcode AT ROW 6.33 COL 48.17 COLON-ALIGNED NO-LABEL
     fi_ins_off AT ROW 6.33 COL 79.33 COLON-ALIGNED NO-LABEL
     fi_brand AT ROW 8.33 COL 18.67 COLON-ALIGNED NO-LABEL
     fi_vehuse AT ROW 8.33 COL 48.67 COLON-ALIGNED NO-LABEL
     fi_year AT ROW 8.29 COL 85.67 COLON-ALIGNED NO-LABEL
     fi_ton AT ROW 8.33 COL 106 COLON-ALIGNED NO-LABEL
     fi_eng_no AT ROW 9.38 COL 18.5 COLON-ALIGNED NO-LABEL
     fi_cha_no AT ROW 9.33 COL 54.67 COLON-ALIGNED NO-LABEL
     fi_licence AT ROW 9.29 COL 88 COLON-ALIGNED NO-LABEL
     fi_province AT ROW 9.33 COL 108.17 COLON-ALIGNED NO-LABEL
     fi_covcod AT ROW 10.38 COL 18.5 COLON-ALIGNED NO-LABEL
     fi_tp1 AT ROW 10.33 COL 37.5 COLON-ALIGNED NO-LABEL
     fi_not_off AT ROW 10.33 COL 94.83 COLON-ALIGNED NO-LABEL
     fi_deduct AT ROW 11.33 COL 18.5 COLON-ALIGNED NO-LABEL
     fi_fleetper AT ROW 11.29 COL 47.67 COLON-ALIGNED NO-LABEL
     fi_ncbper AT ROW 11.29 COL 73.83 COLON-ALIGNED NO-LABEL
     fi_othper AT ROW 11.33 COL 104.83 COLON-ALIGNED NO-LABEL
     fi_comdat AT ROW 12.33 COL 18.33 COLON-ALIGNED NO-LABEL
     fi_expdat AT ROW 12.33 COL 50.33 COLON-ALIGNED NO-LABEL
     fi_sumsi AT ROW 12.33 COL 73 COLON-ALIGNED NO-LABEL
     fi_gross_amt AT ROW 14.33 COL 18.33 COLON-ALIGNED NO-LABEL
     fi_comdat72 AT ROW 13.33 COL 18.33 COLON-ALIGNED NO-LABEL
     fi_expdat72 AT ROW 13.33 COL 50.17 COLON-ALIGNED NO-LABEL
     fi_compprm AT ROW 13.33 COL 79.17 COLON-ALIGNED NO-LABEL
     fi_sckno AT ROW 13.38 COL 105 COLON-ALIGNED NO-LABEL
     fi_prem1 AT ROW 12.33 COL 105.17 COLON-ALIGNED NO-LABEL
     fi_garage AT ROW 14.38 COL 44.33 COLON-ALIGNED NO-LABEL
     fi_tp2 AT ROW 14.38 COL 101 COLON-ALIGNED NO-LABEL
     fi_title AT ROW 16.14 COL 18.17 COLON-ALIGNED NO-LABEL
     fi_firstname AT ROW 16.14 COL 36.17 COLON-ALIGNED NO-LABEL
     fi_lastname AT ROW 16.05 COL 70.33 COLON-ALIGNED NO-LABEL
     fi_icno AT ROW 17.14 COL 18.17 COLON-ALIGNED NO-LABEL
     fi_comm AT ROW 17.14 COL 54.83 COLON-ALIGNED NO-LABEL
     fi_exp AT ROW 17.1 COL 92.5 COLON-ALIGNED NO-LABEL
     fi_addr1 AT ROW 18.19 COL 18.17 COLON-ALIGNED NO-LABEL
     fi_addr2 AT ROW 18.14 COL 78 COLON-ALIGNED NO-LABEL
     fi_addr3 AT ROW 19.19 COL 18.17 COLON-ALIGNED NO-LABEL
     fi_addr4 AT ROW 19.14 COL 78 COLON-ALIGNED NO-LABEL
     fi_driv1 AT ROW 20.24 COL 18.33 COLON-ALIGNED NO-LABEL
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1.67 ROW 1.1
         SIZE 133 BY 27.67
         BGCOLOR 3 FGCOLOR 1 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     fi_birth1 AT ROW 20.19 COL 56.33 COLON-ALIGNED NO-LABEL
     fi_drivid1 AT ROW 20.14 COL 80.83 COLON-ALIGNED NO-LABEL
     fi_drivic1 AT ROW 20.14 COL 104.5 COLON-ALIGNED NO-LABEL
     fi_driv2 AT ROW 21.24 COL 18.33 COLON-ALIGNED NO-LABEL
     fi_birth2 AT ROW 21.19 COL 56.33 COLON-ALIGNED NO-LABEL
     fi_drivid2 AT ROW 21.14 COL 80.83 COLON-ALIGNED NO-LABEL
     fi_drivic2 AT ROW 21.14 COL 104.5 COLON-ALIGNED NO-LABEL
     fi_benname AT ROW 22.24 COL 18.33 COLON-ALIGNED NO-LABEL
     fi_client AT ROW 22.19 COL 73 COLON-ALIGNED NO-LABEL
     fi_remark1 AT ROW 24.14 COL 20.33 NO-LABEL
     fi_remark2 AT ROW 25 COL 18.33 COLON-ALIGNED NO-LABEL
     bu_save AT ROW 27.19 COL 112.33
     bu_exit AT ROW 27.19 COL 123
     fi_userid AT ROW 1.24 COL 121.5 COLON-ALIGNED NO-LABEL
     fi_ldate AT ROW 3.29 COL 18.33 COLON-ALIGNED NO-LABEL
     fi_ltime AT ROW 3.29 COL 48.33 COLON-ALIGNED NO-LABEL
     fi_trndat AT ROW 4.29 COL 18.17 COLON-ALIGNED NO-LABEL
     fi_error AT ROW 25.91 COL 20.67 NO-LABEL
     fi_camp AT ROW 14.38 COL 68 COLON-ALIGNED NO-LABEL
     fi_loss AT ROW 16.05 COL 111.33 COLON-ALIGNED NO-LABEL
     fi_ispno AT ROW 22.19 COL 102.17 COLON-ALIGNED NO-LABEL WIDGET-ID 2
     fi_reisp AT ROW 23.24 COL 20.33 NO-LABEL WIDGET-ID 6
     "ฺ Birth :":30 VIEW-AS TEXT
          SIZE 7 BY .95 AT ROW 20.19 COL 51
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "  ชื่อผู้ขับขี่ 1 :":30 VIEW-AS TEXT
          SIZE 13 BY .95 AT ROW 20.24 COL 6.83
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " Remark :":30 VIEW-AS TEXT
          SIZE 10 BY .86 AT ROW 24.05 COL 9.5
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "Producer code :":30 VIEW-AS TEXT
          SIZE 16 BY .95 AT ROW 3.29 COL 63.67
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " ชื่อ :":30 VIEW-AS TEXT
          SIZE 5.67 BY .95 AT ROW 16.19 COL 32.17
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " ชื่อบริษัทประกัน :":35 VIEW-AS TEXT
          SIZE 16.33 BY .95 AT ROW 10.29 COL 80
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " IC NO :" VIEW-AS TEXT
          SIZE 8 BY .95 AT ROW 21.14 COL 98.17
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "ประเภทรถ :":30 VIEW-AS TEXT
          SIZE 10.5 BY .91 AT ROW 10.38 COL 27.67
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " ประเภทการจ่าย :":30 VIEW-AS TEXT
          SIZE 15.5 BY .95 AT ROW 22.19 COL 59
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " เลขเครื่อง :":35 VIEW-AS TEXT
          SIZE 10.5 BY .95 AT ROW 9.33 COL 8.5
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " รหัสผู้แจ้ง  :":30 VIEW-AS TEXT
          SIZE 12.5 BY .95 AT ROW 6.29 COL 37
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "หมายเหตุการแจ้งงาน:":30 VIEW-AS TEXT
          SIZE 18 BY .86 AT ROW 25.86 COL 2.5
          BGCOLOR 19 FGCOLOR 6 FONT 1
     " เวลาโหลด  :":30 VIEW-AS TEXT
          SIZE 12 BY .95 AT ROW 3.29 COL 37.33
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "  ที่อยู่ 2 :":30 VIEW-AS TEXT
          SIZE 9.5 BY .95 AT ROW 18.19 COL 69.83
          BGCOLOR 19 FGCOLOR 2 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1.67 ROW 1.1
         SIZE 133 BY 27.67
         BGCOLOR 3 FGCOLOR 1 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "Status Policy :" VIEW-AS TEXT
          SIZE 14 BY 1 AT ROW 27.19 COL 75.83
          BGCOLOR 19 FGCOLOR 4 FONT 6
     "  ที่อยู่ 1 :":30 VIEW-AS TEXT
          SIZE 9 BY .95 AT ROW 18.19 COL 10.83
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " เบี้ยรวม กธ :":25 VIEW-AS TEXT
          SIZE 12.17 BY .95 AT ROW 12.33 COL 94.17
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " ปีรถ :":35 VIEW-AS TEXT
          SIZE 6.5 BY .95 AT ROW 8.33 COL 81
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " ทะเบียน :":30 VIEW-AS TEXT
          SIZE 10 BY .95 AT ROW 9.29 COL 80
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "แคมเปญ :":35 VIEW-AS TEXT
          SIZE 8.83 BY .95 AT ROW 14.38 COL 61.17
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " ประเภทประกัน :":30 VIEW-AS TEXT
          SIZE 15 BY .91 AT ROW 10.38 COL 4.5
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "ข้อมูลการชำระเบี้ย :" VIEW-AS TEXT
          SIZE 17.5 BY 1 AT ROW 27.14 COL 3.17
          BGCOLOR 19 FGCOLOR 4 FONT 6
     "วันที่ชำระเบี้ย :" VIEW-AS TEXT
          SIZE 14 BY 1 AT ROW 27.19 COL 43
          BGCOLOR 19 FGCOLOR 4 FONT 6
     " ส่วนลดกลุ่ม :":35 VIEW-AS TEXT
          SIZE 12.5 BY .95 AT ROW 11.29 COL 36.33
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " เลขรับแจ้ง :":35 VIEW-AS TEXT
          SIZE 11.67 BY .95 AT ROW 5.24 COL 7.5
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "ส่วนลดประวัติเสีย :":35 VIEW-AS TEXT
          SIZE 16.83 BY .95 AT ROW 11.43 COL 2.67
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "เลขสติ๊กเกอร์ :":30 VIEW-AS TEXT
          SIZE 12.67 BY .95 AT ROW 13.33 COL 93.83
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "เบี้ยรวม พรบ :":30 VIEW-AS TEXT
          SIZE 13 BY .95 AT ROW 13.33 COL 67.83
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " Agent code :":30 VIEW-AS TEXT
          SIZE 13 BY .95 AT ROW 3.29 COL 95
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " สาขา :":30 VIEW-AS TEXT
          SIZE 6.5 BY .91 AT ROW 4.33 COL 100
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "Claim Ratio :":35 VIEW-AS TEXT
          SIZE 12 BY .95 AT ROW 16.05 COL 100.5
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " วันที่คุ้มครอง72 :":35 VIEW-AS TEXT
          SIZE 16 BY .95 AT ROW 13.33 COL 3.5
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "Loss Ratio :":35 VIEW-AS TEXT
          SIZE 12 BY .95 AT ROW 16.05 COL 100.5
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " วันที่โหลด  :":30 VIEW-AS TEXT
          SIZE 12 BY .95 AT ROW 3.38 COL 7.67
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " Birth :":30 VIEW-AS TEXT
          SIZE 7 BY .95 AT ROW 21.19 COL 50.83
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " วันที่รับแจ้ง  :":30 VIEW-AS TEXT
          SIZE 13 BY .95 AT ROW 6.29 COL 6
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "%":35 VIEW-AS TEXT
          SIZE 2 BY .95 AT ROW 16.05 COL 119.83
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "  ชื่อผู้ขับขี่ 2 :":30 VIEW-AS TEXT
          SIZE 13 BY .95 AT ROW 21.24 COL 6.83
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " คำนำหน้าชื่อ :":30 VIEW-AS TEXT
          SIZE 13 BY .95 AT ROW 16.19 COL 6.67
          BGCOLOR 19 FGCOLOR 2 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1.67 ROW 1.1
         SIZE 133 BY 27.67
         BGCOLOR 3 FGCOLOR 1 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "วันที่บัตรหมดอายุ :":30 VIEW-AS TEXT
          SIZE 16.5 BY .95 AT ROW 17.1 COL 77.5
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " บริษัทประกันเดิม :":35 VIEW-AS TEXT
          SIZE 16.5 BY .91 AT ROW 5.33 COL 80.5
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "รหัสประชาชน :":30 VIEW-AS TEXT
          SIZE 13.67 BY .95 AT ROW 17.14 COL 5.5
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " ชื่อผู้แจ้ง  :":30 VIEW-AS TEXT
          SIZE 10.67 BY .95 AT ROW 6.29 COL 70
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " น้ำหนักรถ :":30 VIEW-AS TEXT
          SIZE 10.5 BY .95 AT ROW 8.29 COL 96.83
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " Drive ID :" VIEW-AS TEXT
          SIZE 10.5 BY .95 AT ROW 21.14 COL 72
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " วันที่ไฟล์แจ้งงาน :" VIEW-AS TEXT
          SIZE 17.17 BY .95 AT ROW 4.33 COL 2.33
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "ผู้รับผลประโยชน์ :":30 VIEW-AS TEXT
          SIZE 16.5 BY .86 AT ROW 22.38 COL 3.17
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " วันที่คุ้มครอง70 :":35 VIEW-AS TEXT
          SIZE 16 BY .95 AT ROW 12.33 COL 3.67
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " นามสกุล :":30 VIEW-AS TEXT
          SIZE 9.67 BY .95 AT ROW 16.14 COL 62.67
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " วันที่คุ้มครอง72 :":35 VIEW-AS TEXT
          SIZE 15.67 BY .95 AT ROW 13.33 COL 36
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " วันที่หมดอายุ70 :":35 VIEW-AS TEXT
          SIZE 15.5 BY .95 AT ROW 12.33 COL 36.33
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "  ที่อยู่ 4 :":30 VIEW-AS TEXT
          SIZE 9.5 BY .95 AT ROW 19.14 COL 69.83
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "ISP No :":30 VIEW-AS TEXT
          SIZE 9 BY .95 AT ROW 22.19 COL 95.17 WIDGET-ID 4
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " รุ่นรถ :":30 VIEW-AS TEXT
          SIZE 7.67 BY .95 AT ROW 8.33 COL 43
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " เลขกรมธรรม์เดิม :":35 VIEW-AS TEXT
          SIZE 17.5 BY .95 AT ROW 1.19 COL 2.33
          BGCOLOR 4 FGCOLOR 7 FONT 6
     " ยี่ห้อรถ :":30 VIEW-AS TEXT
          SIZE 8.33 BY .95 AT ROW 8.33 COL 10.83
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " จังหวัด :":30 VIEW-AS TEXT
          SIZE 9.17 BY .95 AT ROW 9.29 COL 100.83
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " การซ่อม :":35 VIEW-AS TEXT
          SIZE 10 BY .95 AT ROW 14.33 COL 36
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "ผลตรวจสภาพ :":30 VIEW-AS TEXT
          SIZE 14.5 BY .86 AT ROW 23.19 COL 5 WIDGET-ID 8
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " IC NO :" VIEW-AS TEXT
          SIZE 8 BY .95 AT ROW 20.14 COL 98.17
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " Pattern Rate :":30 VIEW-AS TEXT
          SIZE 14.67 BY .91 AT ROW 14.38 COL 88
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " ส่วนลดอื่นๆ :":35 VIEW-AS TEXT
          SIZE 12.67 BY .95 AT ROW 11.29 COL 93.83
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "  ที่อยู่ 3 :":35 VIEW-AS TEXT
          SIZE 9 BY .95 AT ROW 19.24 COL 10.83
          BGCOLOR 19 FGCOLOR 2 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1.67 ROW 1.1
         SIZE 133 BY 27.67
         BGCOLOR 3 FGCOLOR 1 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     " เบี้ยรวมทั้งหมด :":30 VIEW-AS TEXT
          SIZE 16 BY .95 AT ROW 14.38 COL 3.5
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " เลขตัวถัง :":20 VIEW-AS TEXT
          SIZE 11 BY .95 AT ROW 9.33 COL 45.17
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " เบอร์ พรบ  :":35 VIEW-AS TEXT
          SIZE 12.67 BY .95 AT ROW 1.24 COL 87.83
          BGCOLOR 2 FGCOLOR 7 FONT 6
     " Drive ID :" VIEW-AS TEXT
          SIZE 10.5 BY .95 AT ROW 20.19 COL 72
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "เลขที่สัญญา :":30 VIEW-AS TEXT
          SIZE 11.5 BY .91 AT ROW 5.33 COL 44.5
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " ข้อมูลลูกค้า" VIEW-AS TEXT
          SIZE 11.5 BY 1 AT ROW 15.19 COL 2
          BGCOLOR 19 FGCOLOR 6 FONT 6
     " ข้อรถและการประกันภัย" VIEW-AS TEXT
          SIZE 21 BY .91 AT ROW 7.33 COL 2
          BGCOLOR 19 FGCOLOR 6 FONT 6
     " ข้อมูลการแจ้งงาน" VIEW-AS TEXT
          SIZE 17 BY .81 AT ROW 2.57 COL 1.5
          BGCOLOR 19 FGCOLOR 6 FONT 6
     "เลขที่รับแจ้งและสาขา :":35 VIEW-AS TEXT
          SIZE 19.83 BY .95 AT ROW 4.38 COL 44
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "วันที่ออกบัตร :":30 VIEW-AS TEXT
          SIZE 13 BY .95 AT ROW 17.14 COL 43.33
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " ประวัติดี :":35 VIEW-AS TEXT
          SIZE 10 BY .95 AT ROW 11.29 COL 65
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " ทุน  :":35 VIEW-AS TEXT
          SIZE 5.83 BY .95 AT ROW 12.29 COL 68.83
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " เบอร์กรมธรรม์ใหม่  :":35 VIEW-AS TEXT
          SIZE 19.5 BY .95 AT ROW 1.24 COL 47.5
          BGCOLOR 2 FGCOLOR 7 FONT 6
     RECT-335 AT ROW 1.05 COL 1
     RECT-381 AT ROW 26.95 COL 111
     RECT-382 AT ROW 26.95 COL 121.83
     RECT-383 AT ROW 2.91 COL 2
     RECT-384 AT ROW 15.81 COL 1.83
     RECT-385 AT ROW 7.91 COL 2
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1.67 ROW 1.1
         SIZE 133 BY 27.67
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
         TITLE              = "Update Data THANACHAT"
         HEIGHT             = 27.76
         WIDTH              = 134
         MAX-HEIGHT         = 29.14
         MAX-WIDTH          = 135
         VIRTUAL-HEIGHT     = 29.14
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
/* SETTINGS FOR FILL-IN fi_error IN FRAME fr_main
   ALIGN-L                                                              */
/* SETTINGS FOR FILL-IN fi_ldate IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_ltime IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_paydate IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_reisp IN FRAME fr_main
   ALIGN-L                                                              */
/* SETTINGS FOR FILL-IN fi_remark1 IN FRAME fr_main
   ALIGN-L                                                              */
/* SETTINGS FOR FILL-IN fi_status IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_trndat IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_userid IN FRAME fr_main
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Update Data THANACHAT */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Update Data THANACHAT */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_chk
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_chk C-Win
ON CHOOSE OF bu_chk IN FRAME fr_main /* CHK-ISP */
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
        NotesApp     = "D:\Lotus\Notes\Data\ranu\inspect20.nsf" */

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
        nv_fname     = trim(fi_firstname)
        nv_lname     = trim(fi_lastname) 
        /*nv_lname     = trim(SUBSTR(brstat.tlt.ins_name,R-INDEX(brstat.tlt.ins_name," ") + 1))
        nv_fname     = trim(SUBSTR(brstat.tlt.ins_name,1,LENGTH(brstat.tlt.ins_name) - LENGTH(nv_lname) - 1 ))
        nv_fname     = trim(SUBSTR(nv_fname,R-INDEX(nv_fname," ")))*/
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
                     fi_ispno    = trim(nv_docno) 
                     fi_reisp    = trim(nv_detail + " " + nv_damage + " " + nv_damlist + " " + nv_damdetail + " " + nv_device) .
                                                   /*+ " " + nv_surdata + " " + nv_device + " " + nv_acctotal*/   /* ผลตรวจสภาพ*/
                END.
                /*RELEASE brstat.tlt. */       
                
            END.
            /*
            ELSE DO:
                chDocument = chDatabase:CreateDocument.
                ASSIGN
                    chDocument:FORM        = "Inspection"                        
                    chDocument:createdBy   = nv_name                             
                    chDocument:createdOn   = nv_datim                            
                    chDocument:dateS       = brstat.tlt.gendat                            
                    chDocument:dateE       = nv_expdat                           
                    chDocument:ReqType_sub = "ลูกค้า/ตัวแทน/นายหน้าเป็นผู้ส่งรูปตรวจสภาพ"
                    chDocument:BranchReq   = "Bank & Finance"                           
                    chDocument:Tname       = "บุคคล"                             
                    chDocument:Fname       = nv_fname                         
                    chDocument:Lname       = nv_lname                        
                    chDocument:phone1      = ""    
                    chDocument:PolicyNo    = ""                          
                    chDocument:agentCode   = trim(brstat.tlt.comp_sub)                         
                    chDocument:agentName   = nv_brname                           
                    chDocument:Premium     = brstat.tlt.comp_coamt                          
                    chDocument:model       = brstat.tlt.brand                       
                    chDocument:modelCode   = brstat.tlt.model                     
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
            END.   */                                     
        END.
    END.
    DISP fi_ispno fi_reisp WITH FRAME fr_main.
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
                Assign
                    brstat.tlt.entdat       = date(STRING(INPUT fi_ldate,"99/99/9999"))       /* วันที่โหลด */                 
                    brstat.tlt.enttim       = STRING(INPUT fi_ltime,"HH:MM:SS")       /* เวลาโหลด   */                 
                    brstat.tlt.trndat       = DATE(STRING(INPUT fi_trndat,"99/99/9999"))      /* วันที่ไฟล์แจ้งงาน */          
                    brstat.tlt.filler1      = INPUT fi_policy      /* กรมธรรม์เดิม  */              
                    brstat.tlt.rec_addr3    = INPUT fi_pro_off     /*เลขที่รับแจ้งและสาขา  */       
                    brstat.tlt.rec_addr4    = INPUT fi_cmrcode     /*บริษัทประกันเก่า      */       
                    brstat.tlt.safe2        = INPUT fi_accno      /*เลขที่สัญญา           */        
                    brstat.tlt.nor_noti_tlt = INPUT fi_notno       /*เลขที่รับแจ้ง         */       
                    brstat.tlt.lince2       = INPUT fi_year       /*ปี                    */       
                    brstat.tlt.eng_no       = INPUT fi_eng_no     /*เลขเครื่อง            */       
                    brstat.tlt.cha_no       = INPUT fi_cha_no     /*เลขถัง                */       
                    brstat.tlt.cc_weight    = INT(INPUT fi_ton)         /*ขนาดเครื่อง           */       
                    brstat.tlt.lince1       = INPUT fi_licence     /*เลขทะเบียน            */       
                    brstat.tlt.stat         = INPUT fi_garage     /*สถานที่ซ่อม           */       
                    brstat.tlt.lince3       = INPUT fi_province   /*จังหวัด               */       
                    brstat.tlt.brand        = INPUT fi_brand       /*ยี่ห้อ                */       
                    brstat.tlt.comp_sck     = INPUT fi_sckno       /*เลขที่สติ๊กเกอร์      */       
                    brstat.tlt.nor_coamt    = INT(INPUT fi_sumsi)       /*ทุนประกัน             */       
                    brstat.tlt.comp_coamt   = DECI(INPUT fi_gross_amt)   /*เบี้ยรวม              */       
                    brstat.tlt.nor_grprm    = DECI(INPUT fi_prem1)       /*เบี้ยประกันรวม        */       
                    brstat.tlt.comp_grprm   = DECI(INPUT fi_compprm)     /*เบี้ยพรบรวม           */       
                    brstat.tlt.endno        = INPUT fi_deduct      /*ส่วนลดประวัติเสีย     */       
                    brstat.tlt.lotno        = INPUT fi_fleetper    /*ส่วนลดกลุ่ม           */       
                    brstat.tlt.seqno        = INPUT fi_ncbper      /*ประวัติดี             */       
                    brstat.tlt.endcnt       = INPUT fi_othper      /*อื่น ๆ                */       
                    brstat.tlt.model        = INPUT fi_vehuse      /*รุ่น                  */       
                    brstat.tlt.gendat       = DATE(string(INPUT fi_comdat,"99/99/9999"))      /*วันที่เริ่มคุ้มครอง        */  
                    brstat.tlt.expodat      = DATE(string(INPUT fi_expdat,"99/99/9999"))      /*วันที่สิ้นสุดคุ้มครอง      */  
                    brstat.tlt.comp_effdat  = DATE(string(INPUT fi_comdat72,"99/99/9999"))    /*วันทีเริ่มคุ้มครองพรบ      */  
                    brstat.tlt.nor_effdat   = DATE(string(INPUT fi_expdat72,"99/99/9999"))    /*วันที่สิ้นสุดคุ้มครองพรบ   */  
                    brstat.tlt.nor_usr_ins  = INPUT fi_ins_off     /*ผู้แจ้ง                    */  
                    brstat.tlt.comp_usr_tlt = INPUT fi_notcode     /*รหัสผู้แจ้ง                */  
                    brstat.tlt.nor_usr_tlt  = INPUT fi_not_off     /*ชื่อประกันภัย              */  
                    brstat.tlt.datesent     = DATE(string(INPUT fi_notdat,"99/99/9999"))      /*วันที่รับแจ้ง              */  
                    brstat.tlt.ins_addr1    = INPUT fi_addr1      /*ที่อยู่ลูกค้า 1             */ 
                    brstat.tlt.ins_addr2    = INPUT fi_addr2      /*ที่อยู่ลูกค้า  2            */ 
                    brstat.tlt.ins_addr3    = INPUT fi_addr3      /*ที่อยู่ลูกค้า3              */ 
                    brstat.tlt.ins_addr4    = INPUT fi_addr4      /*ที่อยู่ลูกค้า4              */ 
                    SUBSTR(brstat.tlt.dri_name1,1,60)   = INPUT fi_driv1       /*ระบุผู้ขับขี้1             */  
                    SUBSTR(brstat.tlt.dri_name1,61,20)  = INPUT fi_drivid1     /*เลขที่ใบขับขี่1            */  
                    SUBSTR(brstat.tlt.dri_name1,81,20)  = INPUT fi_drivic1     /*เลขที่บัตรประชาชน1         */  
                    brstat.tlt.dri_no1     = STRING(INPUT fi_birth1,"99/99/9999")                   /*วันเดือนปีเกิด1            */  
                    SUBSTR(brstat.tlt.dri_name2,1,60)  =  INPUT fi_driv2       /*ระบุผู้ขับขี้2             */  
                    SUBSTR(brstat.tlt.dri_name2,61,20) =  INPUT fi_drivid2     /*เลขที่ใบขับขี่2            */  
                    SUBSTR(brstat.tlt.dri_name2,81,20) =  INPUT fi_drivic2     /*เลขที่บัตรประชาชน2         */  
                    brstat.tlt.dri_no2     = STRING(INPUT fi_birth2,"99/99/9999")                 /*วันเดือนปีเกิด2            */  
                    brstat.tlt.safe3       = INPUT fi_client                  /*Type_Paid_1                */  
                    brstat.tlt.safe1       = INPUT fi_benname                 /*ผู้รับผลประโยชน์           */  
                    brstat.tlt.usrid       = INPUT fi_userid                  /*User Load Data */              
                    brstat.tlt.EXP         = INPUT fi_branch                  /*สาขา                       */  
                    brstat.tlt.old_eng     = INPUT fi_tp1                     /*ประเภทรถ                   */  
                    brstat.tlt.old_cha     = INPUT fi_tp2                     /*Pattern Rate               */  
                    brstat.tlt.comp_pol    = INPUT fi_compol                  /*เลขกรมธรรม์พรบ             */  
                    brstat.tlt.expousr     = INPUT fi_covcod                  /*ประเภทประกัน               */  
                    brstat.tlt.comp_sub    = INPUT fi_producer                /* produer code */               
                    brstat.tlt.comp_noti_ins = INPUT fi_agent                 /* Agent */                      
                    brstat.tlt.filler2       = INPUT fi_remark1 + " " + INPUT fi_remark2     /*หมายเหตุ                   */  
                    brstat.tlt.rec_name      = INPUT fi_title                                 /*คำนำหน้าชื่อผู้เอาประกันภัย */ 
                    brstat.tlt.ins_name      = INPUT fi_firstname + " " + INPUT fi_lastname  /*ชื่อผู้เอาประกันภัย        */ 
                    brstat.tlt.nor_noti_ins  = INPUT fi_polsystem                           /* เบอร์กรมธรรม์ใหม่ */
                    brstat.tlt.rec_addr1     = INPUT fi_error       /*A60-0383*/
                    brstat.tlt.rec_addr2     = INPUT fi_camp        /*a60-0383*/
                    brstat.tlt.sentcnt       = INPUT fi_loss        /*a60-0383*/
                    /*brstat.tlt.recac         = input fi_status */                     
                    brstat.tlt.dat_ins_noti  = DATE(STRING(input fi_paydate,"99/99/9999")) 
                    brstat.tlt.ins_addr5     = "IC:" + INPUT fi_icno  +      /*ICNO */
                                        " Comm:" + SUBSTR(INPUT fi_comm,7,4) + SUBSTR(INPUT fi_comm,4,2) + SUBSTR(INPUT fi_comm,1,2) +
                                        " Exp:"  + SUBSTR(INPUT fi_exp,7,4) + SUBSTR(INPUT fi_exp,4,2) + SUBSTR(INPUT fi_exp,1,2)
                    /*brstat.tlt.rec_addr5     = INPUT fi_ispno .  /*a61-0512 */*/ /*A64-00205*/
                    brstat.tlt.rec_addr5     = "ISP:" + INPUT fi_ispno + " " + "RES:" + INPUT fi_reisp. /*A64-00205*/

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
Disp  fi_covcod with  frame  fr_main.

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


&Scoped-define SELF-NAME fi_benname
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_benname C-Win
ON LEAVE OF fi_benname IN FRAME fr_main
DO:
  fi_benname = INPUT fi_benname .
  DISP fi_benname WITH FRAM fr_main.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_birth1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_birth1 C-Win
ON LEAVE OF fi_birth1 IN FRAME fr_main
DO:
  fi_birth1 = INPUT fi_birth1.
  DISPLAY fi_birth1 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_birth2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_birth2 C-Win
ON LEAVE OF fi_birth2 IN FRAME fr_main
DO:
  fi_birth2 = INPUT fi_birth2 .
  DISP fi_birth2 WITH FRAM fr_main.
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
  fi_camp  =  Input  fi_camp.
  Disp  fi_camp with frame  fr_main.
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


&Scoped-define SELF-NAME fi_client
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_client C-Win
ON LEAVE OF fi_client IN FRAME fr_main
DO:
  fi_client = INPUT fi_client.
  DISP fi_client WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_cmrcode
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_cmrcode C-Win
ON LEAVE OF fi_cmrcode IN FRAME fr_main
DO:
    fi_cmrcode = INPUT fi_cmrcode  .
    DISP fi_cmrcode WITH FRAM fr_main.
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


&Scoped-define SELF-NAME fi_comm
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_comm C-Win
ON LEAVE OF fi_comm IN FRAME fr_main
DO:
    fi_icno = INPUT fi_icno .
    DISP fi_icno WITH FRAM fr_main.
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


&Scoped-define SELF-NAME fi_covcod
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_covcod C-Win
ON LEAVE OF fi_covcod IN FRAME fr_main
DO:
    fi_covcod = INPUT fi_covcod .
    DISP fi_covcod WITH FRAM fr_main.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_deduct
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_deduct C-Win
ON LEAVE OF fi_deduct IN FRAME fr_main
DO:
  fi_deduct = INPUT fi_deduct.
  DISP fi_deduct WITH FRAM fr_main.
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
  fi_driv2 = INPUT fi_driv2.
  DISP fi_driv2 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_drivic1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_drivic1 C-Win
ON LEAVE OF fi_drivic1 IN FRAME fr_main
DO:
    fi_drivic1 = INPUT fi_drivic1 .
    DISP fi_drivic1 WITH FRAM fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_drivic2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_drivic2 C-Win
ON LEAVE OF fi_drivic2 IN FRAME fr_main
DO:
    fi_drivic2 = INPUT fi_drivic2 .
    DISP fi_drivic2 WITH FRAM fr_main.
  
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


&Scoped-define SELF-NAME fi_eng_no
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_eng_no C-Win
ON LEAVE OF fi_eng_no IN FRAME fr_main
DO:
  fi_eng_no  =  Input  fi_eng_no.
  Disp  fi_eng_no with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_error
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_error C-Win
ON LEAVE OF fi_error IN FRAME fr_main
DO:
    fi_error = trim(INPUT fi_error).
    DISP fi_error with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_exp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_exp C-Win
ON LEAVE OF fi_exp IN FRAME fr_main
DO:
    fi_icno = INPUT fi_icno .
    DISP fi_icno WITH FRAM fr_main.
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


&Scoped-define SELF-NAME fi_expdat72
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_expdat72 C-Win
ON LEAVE OF fi_expdat72 IN FRAME fr_main
DO:
  fi_comdat72 = INPUT fi_comdat72.
  DISP fi_comdat72 WITH FRAM fr_main.
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


&Scoped-define SELF-NAME fi_fleetper
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_fleetper C-Win
ON LEAVE OF fi_fleetper IN FRAME fr_main
DO:
  fi_fleetper =  Input  fi_fleetper.
  Disp  fi_fleetper with frame  fr_main.
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


&Scoped-define SELF-NAME fi_ispno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_ispno C-Win
ON LEAVE OF fi_ispno IN FRAME fr_main
DO:
  fi_ispno = INPUT fi_ispno.
  DISP fi_ispno WITH FRAM fr_main.
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


&Scoped-define SELF-NAME fi_loss
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_loss C-Win
ON LEAVE OF fi_loss IN FRAME fr_main
DO:
  fi_loss  =  Input  fi_loss.
  Disp  fi_loss with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_ncbper
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_ncbper C-Win
ON LEAVE OF fi_ncbper IN FRAME fr_main
DO:
  fi_ncbper =  Input  fi_ncbper.
  Disp  fi_ncbper with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_notcode
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_notcode C-Win
ON LEAVE OF fi_notcode IN FRAME fr_main
DO:
  fi_notcode = INPUT fi_notcode .
  DISP fi_notcode WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_notdat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_notdat C-Win
ON LEAVE OF fi_notdat IN FRAME fr_main
DO:
  fi_notdat = INPUT fi_notdat .
  DISP fi_notdat WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_notno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_notno C-Win
ON LEAVE OF fi_notno IN FRAME fr_main
DO:
  fi_notno = INPUT fi_notno .
  DISP fi_notno WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_not_off
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_not_off C-Win
ON LEAVE OF fi_not_off IN FRAME fr_main
DO:
  fi_not_off = INPUT fi_not_off .
  DISP fi_not_off WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_othper
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_othper C-Win
ON LEAVE OF fi_othper IN FRAME fr_main
DO:
  fi_othper =  Input  fi_othper.
  Disp  fi_othper with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_policy
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_policy C-Win
ON LEAVE OF fi_policy IN FRAME fr_main
DO:
  fi_policy  =  Input  fi_policy.
  Disp  fi_policy with frame  fr_main.
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


&Scoped-define SELF-NAME fi_province
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_province C-Win
ON LEAVE OF fi_province IN FRAME fr_main
DO:
  fi_province =  Input  fi_province.
  Disp  fi_province with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_pro_off
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_pro_off C-Win
ON LEAVE OF fi_pro_off IN FRAME fr_main
DO:
  fi_pro_off = INPUT fi_pro_off.
  DISP fi_pro_off WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_reisp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_reisp C-Win
ON LEAVE OF fi_reisp IN FRAME fr_main
DO:
    fi_reisp = trim(INPUT fi_reisp).
    DISP fi_reisp with frame  fr_main.
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


&Scoped-define SELF-NAME fi_sumsi
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_sumsi C-Win
ON LEAVE OF fi_sumsi IN FRAME fr_main
DO:
    fi_sumsi = INPUT fi_sumsi.
    DISP fi_sumsi WITH FRAM fr_main.
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


&Scoped-define SELF-NAME fi_tp1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_tp1 C-Win
ON LEAVE OF fi_tp1 IN FRAME fr_main
DO:
    fi_tp1 = INPUT fi_tp1 .
    DISP fi_tp1 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_tp2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_tp2 C-Win
ON LEAVE OF fi_tp2 IN FRAME fr_main
DO:
    fi_tp2 = INPUT fi_tp2 .
    DISP fi_tp2 WITH FRAM fr_main.
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
  
  gv_prgid = "wgwqtnc2".
  gv_prog  = "Query & Update Data  (THANACHAT) ".
  RUN  WUT\WUTHEAD ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).

/*********************************************************************/ 
 /*  RUN Wut\WutwiCen ({&WINDOW-NAME}:HANDLE). */ 
  /*CURRENT-WINDOW:WINDOW-STATE = WINDOW-MAXIMIZED.*/
  SESSION:DATA-ENTRY-RETURN = YES.
 /* Rect-336:Move-to-top().*/
 /* Rect-337:Move-to-top().*/
  /*Hide    fi_difprm  in frame  {&FRAME-NAME}.*/
  Find  tlt  Where  Recid(tlt)  =  nv_recidtlt NO-LOCK NO-ERROR NO-WAIT .
  If  avail  tlt  Then do:
      Assign
          n_length      = 0
          n_exp         = ""
          n_IC          = ""
          n_Com         = ""
          n_addr5       = ""
          fi_icno       = ""
          fi_comm       = ""
          fi_exp        = ""
          n_addr5       = ""
          fi_ldate      = tlt.entdat                             /* วันที่โหลด */  
          fi_ltime      = tlt.enttim                             /* เวลาโหลด   */  
          fi_trndat     = tlt.trndat                             /* วันที่ไฟล์แจ้งงาน */                                                                                              
          fi_policy     = tlt.filler1                            /* กรมธรรม์เดิม  */                                                                                                   
          fi_pro_off    = tlt.rec_addr3                          /*เลขที่รับแจ้งและสาขา  */                                                                                                  
          fi_cmrcode    = tlt.rec_addr4                          /*บริษัทประกันเก่า      */                                                                                                 
          fi_accno      = tlt.safe2                             /*เลขที่สัญญา           */ 
          fi_notno      = tlt.nor_noti_tlt                       /*เลขที่รับแจ้ง         */                                                                                              
          fi_year       = tlt.lince2                             /*ปี                    */                                                                                                        
          fi_eng_no     = tlt.eng_no                             /*เลขเครื่อง            */                                                                                                       
          fi_cha_no     = tlt.cha_no                             /*เลขถัง                */                                                                                              
          fi_ton        = tlt.cc_weight                          /*ขนาดเครื่อง           */                                                                                              
          fi_licence    = tlt.lince1                             /*เลขทะเบียน            */                                                                                                  
          fi_garage     = tlt.stat                               /*สถานที่ซ่อม           */                                                                                                      
          fi_province   = tlt.lince3                             /*จังหวัด               */                                                                                             
          fi_brand      = tlt.brand                              /*ยี่ห้อ                */                                                                                                      
          fi_sckno      = tlt.comp_sck                           /*เลขที่สติ๊กเกอร์      */                                                                                             
          fi_sumsi      = tlt.nor_coamt                          /*ทุนประกัน             */                                                                                                  
          fi_gross_amt  = tlt.comp_coamt                         /*เบี้ยรวม              */                                                                                                  
          fi_prem1      = tlt.nor_grprm                         /*เบี้ยประกันรวม        */                                                                                                  
          fi_compprm    = tlt.comp_grprm                        /*เบี้ยพรบรวม           */                                                                                             
          fi_deduct     = Integer(tlt.endno)                    /*ส่วนลดประวัติเสีย     */                                                                                       
          fi_fleetper   = Integer(tlt.lotno)                    /*ส่วนลดกลุ่ม           */                                                                                        
          fi_ncbper     = tlt.seqno                             /*ประวัติดี             */                                                                                       
          fi_othper     = tlt.endcnt                            /*อื่น ๆ                */                                                                                       
          fi_vehuse     = tlt.model                             /*รุ่น                  */                                                                                                   
          fi_comdat     = tlt.gendat                            /*วันที่เริ่มคุ้มครอง        */                                                                                            
          fi_expdat     = tlt.expodat                           /*วันที่สิ้นสุดคุ้มครอง      */ 
          fi_comdat72   = tlt.comp_effdat                       /*วันทีเริ่มคุ้มครองพรบ      */  
          fi_expdat72   = tlt.nor_effdat                        /*วันที่สิ้นสุดคุ้มครองพรบ   */  
          fi_ins_off    = tlt.nor_usr_ins                       /*ผู้แจ้ง                    */                                                                                                  
          fi_notcode    = tlt.comp_usr_tlt                      /*รหัสผู้แจ้ง                */                                                                                            
          fi_not_off    = tlt.nor_usr_tlt                       /*ชื่อประกันภัย              */                                                                                                   
          fi_notdat     = tlt.datesent                          /*วันที่รับแจ้ง              */                                                                                                    
          fi_addr1      = tlt.ins_addr1                         /*ที่อยู่ลูกค้า 1             */                                                                                                     
          fi_addr2      = tlt.ins_addr2                         /*ที่อยู่ลูกค้า  2            */ 
          fi_addr3      = tlt.ins_addr3                        /*ที่อยู่ลูกค้า3              */
          fi_addr4      = tlt.ins_addr4                        /*ที่อยู่ลูกค้า4              */
          fi_driv1      = IF LENGTH(tlt.dri_name1) <> 0  THEN SUBSTR(tlt.dri_name1,1,60)  ELSE ""           /*ระบุผู้ขับขี้1             */  
          fi_drivid1    = IF length(tlt.dri_name1) > 60 THEN SUBSTR(tlt.dri_name1,61,20) ELSE ""          /*เลขที่ใบขับขี่1            */ 
          fi_drivic1    = IF length(tlt.dri_name1) > 80 THEN SUBSTR(tlt.dri_name1,81,20) ELSE ""          /*เลขที่บัตรประชาชน1         */
          fi_birth1     = date(tlt.dri_no1)                     /*วันเดือนปีเกิด1            */  
          fi_driv2      = IF LENGTH(tlt.dri_name2) <> 0  THEN SUBSTR(tlt.dri_name2,1,60)  else ""          /*ระบุผู้ขับขี้2             */  
          fi_drivid2    = IF length(tlt.dri_name2) > 60 THEN SUBSTR(tlt.dri_name2,61,20) else ""          /*เลขที่ใบขับขี่2            */ 
          fi_drivic2    = IF length(tlt.dri_name2) > 80 THEN SUBSTR(tlt.dri_name2,81,20) else ""          /*เลขที่บัตรประชาชน2         */ 
          fi_birth2     = date(tlt.dri_no2)                     /*วันเดือนปีเกิด2            */                                                                                  
          fi_client     = tlt.safe3                             /*Type_Paid_1                */                                                                                                      
          fi_benname    = tlt.safe1                             /*ผู้รับผลประโยชน์           */                                                                                                         
          fi_userid     = tlt.usrid                             /*User Load Data */                                                                                    
          fi_branch     = tlt.EXP                               /*สาขา                       */                                
          fi_tp1        = tlt.old_eng                           /*ประเภทรถ                   */                                                                                                        
          fi_tp2        = tlt.old_cha                           /*Pattern Rate               */                                                                                                      
          fi_compol     = tlt.comp_pol                         /*เลขกรมธรรม์พรบ             */                                                                                 
          fi_covcod     = tlt.expousr                           /*ประเภทประกัน               */  
          fi_producer   = tlt.comp_sub                          /* produer code */                                                                                               
          fi_agent      = tlt.comp_noti_ins                     /* Agent */                                                               
          fi_remark1    = IF LENGTH(tlt.filler2) <> 0  then SUBSTR(tlt.filler2,1,80)  else ""             /*หมายเหตุ                   */                                
          fi_remark2    = IF LENGTH(tlt.filler2) > 80 then SUBSTR(tlt.filler2,81,80) else ""             /*หมายเหตุ                   */
          fi_title      = tlt.rec_name                          /*คำนำหน้าชื่อผู้เอาประกันภัย */
          fi_status     = IF tlt.recac = "" THEN "ยังไม่จ่ายเบี้ยประกัน" ELSE tlt.recac
          fi_paydate    = tlt.dat_ins_noti
          n_addr5       = tlt.ins_addr5
          fi_polsystem  = tlt.nor_noti_ins           /* เบอร์กรมธรรม์ใหม่ */ 
          fi_polstatus  = IF index(tlt.releas,"NO") <> 0 THEN "ยังไม่ออกงาน" ELSE IF INDEX(tlt.releas,"Cancel") <> 0 THEN "ยกเลิก" ELSE "ออกงานแล้ว"
          nv_index      = Index(tlt.ins_name," ")                               
          fi_firstname  = IF fi_title <> "บจก." AND fi_title <> "มูลนิธิ" AND fi_title <> "หจก." AND fi_title <> "บริษัท" 
                          THEN Substr(tlt.ins_name,1,nv_index - 1) ELSE TRIM(tlt.ins_name)                   
          fi_lastname   = IF fi_title <> "บจก." AND fi_title <> "มูลนิธิ" AND fi_title <> "หจก." AND fi_title <> "บริษัท" 
                          THEN Substr(tlt.ins_name,nv_index + 1,length(tlt.ins_name) - LENGTH(fi_firstname)) ELSE ""
          n_length      = LENGTH(n_addr5)                                   
          n_exp         = SUBSTR(n_addr5,R-INDEX(n_addr5,"Exp:") + 4,n_length)  
          n_addr5       = SUBSTR(n_addr5,1,R-INDEX(n_addr5," "))             
          n_length      = LENGTH(n_addr5)                                     
          n_com         = SUBSTR(n_addr5,R-INDEX(n_addr5,"Comm:") + 5,n_length)
          /*n_ic          = SUBSTR(n_addr5,1 + 3,R-INDEX(n_addr5,"Comm:") - 5) */ /*A60-0383*/
          n_ic          = SUBSTR(n_addr5,1 + 3,R-INDEX(n_addr5,"Comm:") - 4)   /*A60-0383*/
          fi_icno       = TRIM(n_ic)
          fi_comm       = IF trim(n_com) <> "" THEN SUBSTR(n_com,7,2) + "/" + SUBSTR(n_com,5,2) + "/" + SUBSTR(n_com,1,4) ELSE ""
          fi_exp        = IF trim(n_exp) <> "" THEN SUBSTR(n_exp,7,2) + "/" + SUBSTR(n_exp,5,2) + "/" + SUBSTR(n_exp,1,4) ELSE ""
          fi_loss       = tlt.sentcnt              /*A60-0383*/
          fi_error      = TRIM(tlt.rec_addr1)      /*A60-0383*/
          fi_camp       = TRIM(tlt.rec_addr2)     /*a60-0383*/
          /*fi_ispno      = TRIM(tlt.rec_addr5).    /*A61-0512 */  */ /*A64-02025*/
          /* add vtA64-02025*/
          fi_ispno      = IF INDEX(brstat.tlt.rec_addr5,"ISP:") <> 0 THEN SUBSTR(brstat.tlt.rec_addr5,5,INDEX(brstat.tlt.rec_addr5,"RES:") - 5) 
                          ELSE brstat.tlt.rec_addr5 
          fi_reisp      = IF INDEX(brstat.tlt.rec_addr5,"RES:") <> 0 THEN SUBSTR(brstat.tlt.rec_addr5,R-INDEX(brstat.tlt.rec_addr5,"RES:") + 4) 
                          ELSE "" .
          /* end : A64-02025*/
     Disp  
         fi_ldate     fi_ltime     fi_trndat    fi_policy    fi_pro_off   fi_cmrcode   
         fi_accno     fi_notno     fi_year      fi_eng_no    fi_cha_no    fi_ton       
         fi_licence   fi_garage    fi_province  fi_brand     fi_sckno     fi_sumsi     
         fi_gross_amt fi_prem1     fi_compprm   fi_deduct    fi_fleetper  fi_ncbper    
         fi_othper    fi_vehuse    fi_comdat    fi_expdat    fi_comdat72  fi_expdat72  
         fi_ins_off   fi_notcode   fi_not_off   fi_notdat    fi_addr1     fi_addr2     
         fi_addr3     fi_addr4     fi_driv1     fi_drivid1   fi_drivic1   fi_birth1    
         fi_driv2     fi_drivid2   fi_drivic2   fi_birth2    fi_client    fi_benname   
         fi_userid    fi_branch    fi_tp1       fi_tp2       fi_compol    fi_covcod    
         fi_producer  fi_agent     fi_remark1   fi_remark2   fi_title     fi_firstname 
         fi_lastname  fi_icno      fi_polsystem fi_comm      fi_exp       fi_status 
         fi_paydate   fi_polstatus fi_error     fi_camp      fi_loss  /*A60-0383*/ fi_ispno /*a61-0512*/
         fi_reisp /*A64-0205*/ With frame  fr_main. 
     IF LENGTH(fi_icno) < 13 THEN DO:
         fi_icno:BGCOLOR = 6 .
         DISP fi_icno WITH FRAME fr_main.
     END.
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
  DISPLAY fi_polstatus fi_paydate fi_status fi_polsystem fi_policy fi_compol 
          fi_producer fi_agent fi_pro_off fi_branch fi_notno fi_accno fi_cmrcode 
          fi_notdat fi_notcode fi_ins_off fi_brand fi_vehuse fi_year fi_ton 
          fi_eng_no fi_cha_no fi_licence fi_province fi_covcod fi_tp1 fi_not_off 
          fi_deduct fi_fleetper fi_ncbper fi_othper fi_comdat fi_expdat fi_sumsi 
          fi_gross_amt fi_comdat72 fi_expdat72 fi_compprm fi_sckno fi_prem1 
          fi_garage fi_tp2 fi_title fi_firstname fi_lastname fi_icno fi_comm 
          fi_exp fi_addr1 fi_addr2 fi_addr3 fi_addr4 fi_driv1 fi_birth1 
          fi_drivid1 fi_drivic1 fi_driv2 fi_birth2 fi_drivid2 fi_drivic2 
          fi_benname fi_client fi_remark1 fi_remark2 fi_userid fi_ldate fi_ltime 
          fi_trndat fi_error fi_camp fi_loss fi_ispno fi_reisp 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE bu_chk fi_polstatus fi_polsystem fi_policy fi_compol fi_producer 
         fi_agent fi_pro_off fi_branch fi_notno fi_accno fi_cmrcode fi_notdat 
         fi_notcode fi_ins_off fi_brand fi_vehuse fi_year fi_ton fi_eng_no 
         fi_cha_no fi_licence fi_province fi_covcod fi_tp1 fi_not_off fi_deduct 
         fi_fleetper fi_ncbper fi_othper fi_comdat fi_expdat fi_sumsi 
         fi_gross_amt fi_comdat72 fi_expdat72 fi_compprm fi_sckno fi_prem1 
         fi_garage fi_tp2 fi_title fi_firstname fi_lastname fi_icno fi_comm 
         fi_exp fi_addr1 fi_addr2 fi_addr3 fi_addr4 fi_driv1 fi_birth1 
         fi_drivid1 fi_drivic1 fi_driv2 fi_birth2 fi_drivid2 fi_drivic2 
         fi_benname fi_client fi_remark1 fi_remark2 bu_save bu_exit fi_error 
         fi_camp fi_loss fi_ispno fi_reisp RECT-335 RECT-381 RECT-382 RECT-383 
         RECT-384 RECT-385 
      WITH FRAME fr_main IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW C-Win.
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

