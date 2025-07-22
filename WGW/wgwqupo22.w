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
program id       :  wuwqupo22.w 
program name     :  Update data Phone to create  new policy  Add in table  tlt  
                    Quey & Update data before Gen.
Create  by       :  Ranu I. A62-0219 date.08/05/2019
Database Connect :  gw_stat ld brstat , gw_safe ld sic_bran ,sic_test ld sicuw sicsyac :not connect stat
/*--------------------------------------------------------------------------------------------------*/
Modify by        :  Ranu I. A62-0343 date : 23/07/2019 แก้ไขปุ่ม save ไม่ต้อง update tlt.releas 
Modify by        : Ranu I. A62-0345 date : 08/08/2019 Status CA ไม่สามารถแก้ไขอัพเดทข้อมูลได้
/*Modify by      : Ranu I. A63-0392 แก้ไข format ทะเบียนรถให้ตรงกับ pattern ในกล่อง inspection    */
+++++++++++++++++++++++++++++++++++++++++++++++*/

Def  Input  parameter  nv_recidtlt  as  recid  .
Def   var    nv_index  as int  init 0.
DEF  NEW   SHARED  VAR gComp   AS CHAR.
DEF  NEW   SHARED  VAR n_agent1    LIKE sicsyac.xmm600.acno. 
DEF  NEW   SHARED  VAR n_agent2    LIKE sicsyac.xmm600.acno. 
/* Parameters Definitions ---                                           */
Def  VAR   n_name  As   Char    Format    "x(35)".
Def  VAR   n_nO1    As   Char    Format    "x(35)".
Def  VAR   n_nO2    As   Char    Format    "x(35)".
Def  VAR   n_nO3    As   Char    Format    "x(35)".
DEF VAR    n_text   AS   CHAR    FORMAT    "x(35)".
Def    VAR   n_chkname   As   Char    Format    "x(35)".
DEFINE VAR vAcProc_fil   AS CHAR.
DEFINE VAR vAcProc_fil3  AS CHAR.
DEFINE VAR vAcProc_fil4  AS   CHAR.  /*A57-0063*/
DEFINE VAR vAcProc_fil5  AS   CHAR.  /*A57-0063*/
DEFINE VAR nv_cartyp     AS   CHAR.  /*A57-0063*/
DEFINE  WORKFILE wdetail NO-UNDO
/*1*/  FIELD provi_no       AS CHAR      FORMAT "x(5)"
/*2*/  FIELD provi_name     AS CHARACTER FORMAT "X(30)"   INITIAL "".
DEF VAR n_poltyp  AS CHAR INIT "".
DEF VAR nv_brnpol AS CHAR INIT "".
DEF VAR n_undyr2  AS CHAR INIT "".
DEF VAR n_brsty   AS CHAR INIT "".
DEF VAR n_br      AS CHAR INIT "" FORMAT "x(5)" .
DEFINE VAR nv_check     AS   CHARACTER  INITIAL ""  NO-UNDO.
DEFINE VAR nv_check70  AS   CHARACTER  INITIAL ""  NO-UNDO.
DEFINE VAR nv_check72  AS   CHARACTER  INITIAL ""  NO-UNDO.
DEF VAR n_banno  AS  CHAR   INIT "" FORMAT "x(20)".
DEF VAR n_muno   AS  CHAR   INIT "" FORMAT "x(20)".
DEF VAR n_build  AS  CHAR   INIT "" FORMAT "x(50)".
DEF VAR n_road   AS  CHAR   INIT "" FORMAT "x(40)".
DEF VAR n_soy    AS  CHAR   INIT "" FORMAT "x(40)".
DEF VAR n_addr11 AS  CHAR   INIT "" FORMAT "x(200)".
DEF VAR nv_benname      As   Char    Format    "x(10)".  
DEF VAR n_producernew   As   Char    Format    "x(10)".  
DEF VAR n_produceruse   As   Char    Format    "x(10)".  
DEF VAR n_producerbike  As   Char    Format    "x(10)".  
DEF VAR n_agent         As   Char    Format    "x(10)".  

DEF VAR n_chk     AS LOG. 
DEF VAR n_quota   AS CHAR.
DEF VAR n_garage  AS CHAR.
DEF VAR n_remark1 AS CHAR.
DEF VAR n_remark2 AS CHAR.
DEF VAR n_other1  AS CHAR.
DEF VAR n_other2  AS CHAR.
DEF VAR n_other3  AS CHAR.
DEF VAR vAcProc_fil6 AS CHAR.
DEF VAR nv_ispstatus AS CHAR.
DEF VAR chSession       AS COM-HANDLE.
DEF VAR chWorkSpace     AS COM-HANDLE.
DEF VAR chName          AS COM-HANDLE.
DEF VAR chDatabase      AS COM-HANDLE.
DEF VAR chView          AS COM-HANDLE.
DEF VAR chViewEntry     AS COM-HANDLE.
DEF VAR chViewNavigator AS COM-HANDLE.
DEF VAR chDocument      AS COM-HANDLE.
DEF VAR chUIDocument    AS COM-HANDLE.
/**/
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

def var   nv_notno70  as  char  format "x(13)" .
def var   nv_notno72  as  char  format "x(13)" .
def var   nv_preinsur   as char format "x(50)" .
def var   nv_preinsur2  as char format "x(50)" .
def var   nv_insadd6tel as char format "x(20)" .

Def var   n_campno    As   Char    Format    "x(15)".
DEF var   n_gar       As   Char    Format    "x(5)" .
DEF var   n_pack      As   Char    Format    "x(5)" .
DEF var   n_company   As   Char    Format    "x(10)" .
DEF var   n_tpp       As   Char    Format    "x(20)" . 
DEF var   n_tpa       As   Char    Format    "x(20)" .  
DEF var   n_tpd       As   Char    Format    "x(20)" .  
DEF var   n_41        As   Char    Format    "x(20)" .  
DEF var   n_42        As   Char    Format    "x(20)" .  
DEF var   n_43        As   Char    Format    "x(20)" .
DEF VAR vAcproc_fil7 AS CHAR.

DEF VAR nv_brdesc AS CHAR FORMAT "x(50)" INIT "" .
DEF VAR nv_brcode AS CHAR FORMAT "x(3)" INIT "" .
DEF VAR nv_comco AS CHAR FORMAT "x(10)" INIT "" .
DEF VAR nv_producer AS CHAR FORMAT "x(10)" INIT "" .
DEF VAR nv_agent AS CHAR FORMAT "x(10)" INIT "" .
DEF VAR nv_char AS CHAR FORMAT "x(225)" INIT "" .
DEF VAR nv_length AS INT INIT 0.
Def  Var chItem          As Com-Handle .
Def  Var chData          As Com-Handle .
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

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS bu_not1 bu_notes fi_comdat fi_expdat ~
fi_ispno fi_brand fi_model fi_year fi_power fi_licence1 fi_licence2 ~
fi_provin fi_cha_no fi_eng_no fi_pack fi_class fi_garage fi_sumsi fi_gap ~
fi_premium fi_precomp fi_totlepre fi_baseod fi_stk ra_driv bu_brand ~
fi_other2 fi_other3 fi_ispstatus co_caruse fi_cover1 bu_cover ra_pa ~
fi_product bu_product fi_quo bu_quo-2 co_garage fi_campaign bu_cam fi_tp ~
fi_ta fi_td fi_41 fi_42 fi_43 fi_doc1 fi_remark ra_complete bu_save bu_exit ~
fi_sumfi fi_redbook RECT-488 RECT-490 RECT-494 RECT-496 RECT-498 RECT-495 ~
RECT-499 RECT-500 RECT-501 
&Scoped-Define DISPLAYED-OBJECTS fi_comdat fi_expdat fi_ispno fi_brand ~
fi_model fi_year fi_power fi_licence1 fi_licence2 fi_provin fi_cha_no ~
fi_eng_no fi_pack fi_class fi_garage fi_sumsi fi_gap fi_premium fi_precomp ~
fi_totlepre fi_baseod fi_stk fi_userid ra_driv fi_notino fi_notdat ~
fi_nottim fi_other2 fi_other3 fi_ispstatus co_caruse ra_cover fi_cover1 ~
ra_pa fi_product ra_pree ra_comp fi_quo co_garage fi_campaign fi_tp fi_ta ~
fi_td fi_41 fi_42 fi_43 fi_doc1 fi_remark ra_complete fi_pol70 fi_pol72 ~
fi_sumfi fi_redbook 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE VARIABLE fi_agedriv1 AS INTEGER FORMAT "->>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 6 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_agedriv2 AS INTEGER FORMAT "->>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 5.83 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_drivername1 AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 31.33 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_drivername2 AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 31.33 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_hbdri1 AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_hbdri2 AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_idnodriv1 AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 18.67 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 1 NO-UNDO.

DEFINE VARIABLE fi_idnodriv2 AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 18.33 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_occupdriv1 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 18.83 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_occupdriv2 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 19.17 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE ra_sex1 AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "Male", 1,
"Female", 2
     SIZE 18 BY 1
     BGCOLOR 19 FGCOLOR 2 FONT 1 NO-UNDO.

DEFINE VARIABLE ra_sex2 AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "Male", 1,
"Female", 2
     SIZE 18 BY 1
     BGCOLOR 19 FGCOLOR 2 FONT 1 NO-UNDO.

DEFINE BUTTON bu_brand 
     IMAGE-UP FILE "I:/Safety/WALP10/WIMAGE/next.bmp":U
     LABEL "" 
     SIZE 3.5 BY 1.

DEFINE BUTTON bu_cam 
     IMAGE-UP FILE "I:/Safety/WALP10/WIMAGE/next.bmp":U
     LABEL "" 
     SIZE 3.5 BY 1.

DEFINE BUTTON bu_cover 
     IMAGE-UP FILE "I:/Safety/WALP10/WIMAGE/next.bmp":U
     LABEL "" 
     SIZE 3.5 BY .95.

DEFINE BUTTON bu_exit 
     LABEL "Exit" 
     SIZE 7.5 BY .95
     FONT 6.

DEFINE BUTTON bu_not1 
     LABEL "ข้อมูลลูกค้า" 
     SIZE 16 BY 1.19
     BGCOLOR 1 FGCOLOR 7 FONT 6.

DEFINE BUTTON bu_notes 
     LABEL "Notes" 
     SIZE 10.17 BY 1
     BGCOLOR 10 FONT 6.

DEFINE BUTTON bu_product 
     IMAGE-UP FILE "I:/Safety/WALP10/WIMAGE/next.bmp":U
     LABEL "" 
     SIZE 3.67 BY 1.

DEFINE BUTTON bu_quo-2 
     LABEL "Quotation" 
     SIZE 12.5 BY 1
     BGCOLOR 12 FONT 6.

DEFINE BUTTON bu_save 
     LABEL "Save" 
     SIZE 7.5 BY .95
     FONT 6.

DEFINE VARIABLE co_caruse AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS COMBO-BOX INNER-LINES 6
     DROP-DOWN-LIST
     SIZE 21.67 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE co_garage AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 5
     DROP-DOWN-LIST
     SIZE 20.17 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_41 AS INT64 FORMAT "->>,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 17.5 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_42 AS INT64 FORMAT "->>,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 17.83 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_43 AS INT64 FORMAT "->>,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 13.5 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_baseod AS DECIMAL FORMAT "->,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 12.5 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_brand AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 17.17 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_campaign AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 15.83 BY 1
     BGCOLOR 8 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_cha_no AS CHARACTER FORMAT "X(35)":U 
     VIEW-AS FILL-IN 
     SIZE 23.83 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_class AS CHARACTER FORMAT "X(5)":U 
     VIEW-AS FILL-IN 
     SIZE 6.33 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_comdat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 14.67 BY 1
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_cover1 AS CHARACTER FORMAT "X(3)":U 
     VIEW-AS FILL-IN 
     SIZE 6 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_doc1 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 16.33 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_eng_no AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 24 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_expdat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_gap AS DECIMAL FORMAT "->,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 13.17 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_garage AS CHARACTER FORMAT "X(5)":U 
     VIEW-AS FILL-IN 
     SIZE 4.67 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_ispno AS CHARACTER FORMAT "X(45)":U 
     VIEW-AS FILL-IN 
     SIZE 21.17 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_ispstatus AS CHARACTER FORMAT "X(1)":U 
     VIEW-AS FILL-IN 
     SIZE 4.67 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_licence1 AS CHARACTER FORMAT "X(3)":U 
     VIEW-AS FILL-IN 
     SIZE 6 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_licence2 AS CHARACTER FORMAT "X(4)":U 
     VIEW-AS FILL-IN 
     SIZE 6.5 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_model AS CHARACTER FORMAT "X(60)":U 
     VIEW-AS FILL-IN 
     SIZE 27.17 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_notdat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 13.5 BY 1
     BGCOLOR 19 FGCOLOR 2 FONT 1 NO-UNDO.

DEFINE VARIABLE fi_notino AS CHARACTER FORMAT "X(35)":U 
     VIEW-AS FILL-IN 
     SIZE 17 BY 1
     BGCOLOR 19 FGCOLOR 2 FONT 1 NO-UNDO.

DEFINE VARIABLE fi_nottim AS CHARACTER FORMAT "X(13)":U 
     VIEW-AS FILL-IN 
     SIZE 10 BY 1
     BGCOLOR 19 FGCOLOR 2 FONT 1 NO-UNDO.

DEFINE VARIABLE fi_other2 AS DECIMAL FORMAT "->,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 16.83 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_other3 AS CHARACTER FORMAT "X(60)":U 
     VIEW-AS FILL-IN 
     SIZE 47.67 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_pack AS CHARACTER FORMAT "X(1)":U 
     VIEW-AS FILL-IN 
     SIZE 4.67 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_pol70 AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 17 BY 1
     BGCOLOR 19 FGCOLOR 2 FONT 1 NO-UNDO.

DEFINE VARIABLE fi_pol72 AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 17 BY 1
     BGCOLOR 19 FGCOLOR 2 FONT 1 NO-UNDO.

DEFINE VARIABLE fi_power AS INTEGER FORMAT "->>>>>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 8.5 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_precomp AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 11.17 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_premium AS DECIMAL FORMAT "->,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 14.67 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_product AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_provin AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 19.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_quo AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 21.83 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_redbook AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 13 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_remark AS CHARACTER FORMAT "X(500)":U 
     VIEW-AS FILL-IN 
     SIZE 112 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_stk AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 17 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_sumfi AS INTEGER FORMAT "->>,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 14.17 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_sumsi AS INTEGER FORMAT "->>,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 20.5 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_ta AS INT64 FORMAT "->>,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 17.83 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_td AS INT64 FORMAT "->>,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 13.5 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_totlepre AS DECIMAL FORMAT "->,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 17.17 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_tp AS INT64 FORMAT "->>,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 17.5 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_userid AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 7.5 BY .76
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_year AS CHARACTER FORMAT "X(5)":U INITIAL "0" 
     VIEW-AS FILL-IN 
     SIZE 7.33 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE ra_comp AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "แถม", 1,
"ไม่แถม", 2,
"ไม่เอาพรบ.", 3
     SIZE 31.83 BY .95
     BGCOLOR 10 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE ra_complete AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "Complete", 1,
"Not Complete", 2
     SIZE 28.5 BY .95
     BGCOLOR 19 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE ra_cover AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "ป้ายแดง", 1,
"User car", 2,
"BIKE", 3
     SIZE 34 BY .95
     BGCOLOR 10 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE ra_driv AS INTEGER 
     VIEW-AS RADIO-SET VERTICAL
     RADIO-BUTTONS 
          "ไม่ระบุ", 1,
"ระบุ", 2
     SIZE 10.17 BY 4.57
     BGCOLOR 10 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE ra_pa AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "ไม่ขายPA", 1,
"ขายPA", 2
     SIZE 22.17 BY .95
     BGCOLOR 10 FONT 6 NO-UNDO.

DEFINE VARIABLE ra_pree AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "แถม  ", 1,
"ไม่แถม", 2
     SIZE 19 BY .95
     BGCOLOR 10 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-488
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132.5 BY 23.81
     BGCOLOR 3 .

DEFINE RECTANGLE RECT-490
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 9.5 BY 1.19
     BGCOLOR 29 FGCOLOR 0 .

DEFINE RECTANGLE RECT-494
     EDGE-PIXELS 2 GRAPHIC-EDGE    ROUNDED 
     SIZE 131.5 BY 19.33
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-495
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 10 BY 1.81
     BGCOLOR 12 .

DEFINE RECTANGLE RECT-496
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 112 BY 4.86
     BGCOLOR 10 FGCOLOR 1 .

DEFINE RECTANGLE RECT-498
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE .67 BY 19.05
     BGCOLOR 10 .

DEFINE RECTANGLE RECT-499
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 10 BY 1.81
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-500
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 31.5 BY 1.81
     BGCOLOR 29 .

DEFINE RECTANGLE RECT-501
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 54.33 BY 1.33
     BGCOLOR 3 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     bu_not1 AT ROW 1.95 COL 31.33 WIDGET-ID 56
     bu_notes AT ROW 5.67 COL 117.5 WIDGET-ID 2
     fi_comdat AT ROW 5.71 COL 17 COLON-ALIGNED NO-LABEL
     fi_expdat AT ROW 5.71 COL 55.83 COLON-ALIGNED NO-LABEL
     fi_ispno AT ROW 5.67 COL 87.5 COLON-ALIGNED NO-LABEL
     fi_brand AT ROW 6.86 COL 16.83 COLON-ALIGNED NO-LABEL
     fi_model AT ROW 6.86 COL 45 COLON-ALIGNED NO-LABEL
     fi_year AT ROW 6.81 COL 102.83 COLON-ALIGNED NO-LABEL
     fi_power AT ROW 6.81 COL 119 COLON-ALIGNED NO-LABEL
     fi_licence1 AT ROW 7.95 COL 16.67 COLON-ALIGNED NO-LABEL
     fi_licence2 AT ROW 7.95 COL 23.5 COLON-ALIGNED NO-LABEL
     fi_provin AT ROW 7.95 COL 30.5 COLON-ALIGNED NO-LABEL DISABLE-AUTO-ZAP 
     fi_cha_no AT ROW 8 COL 63 COLON-ALIGNED NO-LABEL
     fi_eng_no AT ROW 8 COL 103 COLON-ALIGNED NO-LABEL
     fi_pack AT ROW 15.33 COL 43.17 COLON-ALIGNED NO-LABEL
     fi_class AT ROW 15.33 COL 55.33 COLON-ALIGNED NO-LABEL
     fi_garage AT ROW 15.33 COL 70.67 COLON-ALIGNED NO-LABEL
     fi_sumsi AT ROW 15.33 COL 108.17 COLON-ALIGNED NO-LABEL
     fi_gap AT ROW 16.48 COL 40.33 COLON-ALIGNED NO-LABEL
     fi_premium AT ROW 16.48 COL 65.17 COLON-ALIGNED NO-LABEL
     fi_precomp AT ROW 16.48 COL 90.83 COLON-ALIGNED NO-LABEL
     fi_totlepre AT ROW 16.48 COL 111.5 COLON-ALIGNED NO-LABEL
     fi_baseod AT ROW 18.86 COL 77.83 COLON-ALIGNED NO-LABEL
     fi_stk AT ROW 18.86 COL 105.33 COLON-ALIGNED NO-LABEL
     fi_userid AT ROW 2 COL 121.67 COLON-ALIGNED NO-LABEL
     ra_driv AT ROW 9.24 COL 19.17 NO-LABEL
     fi_notino AT ROW 1.95 COL 56.67 COLON-ALIGNED NO-LABEL
     fi_notdat AT ROW 1.95 COL 86.17 COLON-ALIGNED NO-LABEL
     fi_nottim AT ROW 1.95 COL 110.17 COLON-ALIGNED NO-LABEL
     bu_brand AT ROW 6.86 COL 36.17
     fi_other2 AT ROW 20.05 COL 59.17 COLON-ALIGNED NO-LABEL
     fi_other3 AT ROW 20.05 COL 81.17 COLON-ALIGNED NO-LABEL
     fi_ispstatus AT ROW 5.67 COL 109.17 COLON-ALIGNED NO-LABEL
     co_caruse AT ROW 14.19 COL 43.33 COLON-ALIGNED NO-LABEL WIDGET-ID 18
     ra_cover AT ROW 4.62 COL 19.5 NO-LABEL WIDGET-ID 28
     fi_cover1 AT ROW 14.19 COL 17 COLON-ALIGNED NO-LABEL WIDGET-ID 20
     bu_cover AT ROW 14.19 COL 25.33 WIDGET-ID 14
     ra_pa AT ROW 14.19 COL 69 NO-LABEL WIDGET-ID 32
     fi_product AT ROW 15.29 COL 17 COLON-ALIGNED NO-LABEL WIDGET-ID 22
     bu_product AT ROW 15.29 COL 33.17 WIDGET-ID 16
     ra_pree AT ROW 4.57 COL 64.33 NO-LABEL WIDGET-ID 36
     ra_comp AT ROW 4.57 COL 92 NO-LABEL WIDGET-ID 24
     fi_quo AT ROW 3.43 COL 17.17 COLON-ALIGNED NO-LABEL WIDGET-ID 70
     bu_quo-2 AT ROW 3.43 COL 41.83 WIDGET-ID 68
     co_garage AT ROW 15.29 COL 76.17 COLON-ALIGNED NO-LABEL WIDGET-ID 74
     fi_campaign AT ROW 14.1 COL 106.17 COLON-ALIGNED NO-LABEL WIDGET-ID 84
     bu_cam AT ROW 14.1 COL 124 WIDGET-ID 76
     fi_tp AT ROW 17.67 COL 16.83 COLON-ALIGNED NO-LABEL WIDGET-ID 106
     fi_ta AT ROW 17.67 COL 49.5 COLON-ALIGNED NO-LABEL WIDGET-ID 110
     fi_td AT ROW 17.67 COL 83.17 COLON-ALIGNED NO-LABEL WIDGET-ID 108
     fi_41 AT ROW 17.67 COL 105.5 COLON-ALIGNED NO-LABEL WIDGET-ID 118
     fi_42 AT ROW 18.86 COL 16.83 COLON-ALIGNED NO-LABEL WIDGET-ID 122
     fi_43 AT ROW 18.86 COL 53.5 COLON-ALIGNED NO-LABEL WIDGET-ID 120
     fi_doc1 AT ROW 20 COL 16.67 COLON-ALIGNED NO-LABEL WIDGET-ID 130
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 134 BY 23.91
         BGCOLOR 3 FGCOLOR 1 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     fi_remark AT ROW 21.14 COL 16.67 COLON-ALIGNED NO-LABEL WIDGET-ID 134
     ra_complete AT ROW 23 COL 81.5 NO-LABEL WIDGET-ID 144
     bu_save AT ROW 23 COL 113 WIDGET-ID 142
     bu_exit AT ROW 23.05 COL 123.33 WIDGET-ID 140
     fi_pol70 AT ROW 3.33 COL 79.67 COLON-ALIGNED NO-LABEL WIDGET-ID 154
     fi_pol72 AT ROW 3.33 COL 105.17 COLON-ALIGNED NO-LABEL WIDGET-ID 156
     fi_sumfi AT ROW 16.48 COL 16.83 COLON-ALIGNED NO-LABEL WIDGET-ID 164
     fi_redbook AT ROW 6.86 COL 82.83 COLON-ALIGNED NO-LABEL WIDGET-ID 172
     "เบี้ยรวม70 :":30 VIEW-AS TEXT
          SIZE 11.33 BY .95 AT ROW 16.48 COL 55.83
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "วันที่คุ้มครอง :":35 VIEW-AS TEXT
          SIZE 12.67 BY 1 AT ROW 5.67 COL 4.33
          BGCOLOR 19 FGCOLOR 4 FONT 6
     " พรบ :":30 VIEW-AS TEXT
          SIZE 6 BY .95 AT ROW 4.57 COL 84.83 WIDGET-ID 46
          BGCOLOR 19 FGCOLOR 4 FONT 6
     "รุ่นรถ :":30 VIEW-AS TEXT
          SIZE 6.5 BY .95 AT ROW 6.91 COL 40.17
          BGCOLOR 19 FGCOLOR 4 FONT 6
     "42 MEDICAL :":30 VIEW-AS TEXT
          SIZE 13.83 BY .95 AT ROW 18.86 COL 3.5 WIDGET-ID 124
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "เลขที่เอกสาร :":30 VIEW-AS TEXT
          SIZE 12.17 BY .95 AT ROW 20 COL 5.5 WIDGET-ID 132
          BGCOLOR 19 FGCOLOR 4 FONT 6
     "Pol 72 :" VIEW-AS TEXT
          SIZE 7.83 BY .95 AT ROW 3.33 COL 99.17 WIDGET-ID 160
          BGCOLOR 3 FGCOLOR 7 FONT 6
     " Quotation :":30 VIEW-AS TEXT
          SIZE 12 BY .95 AT ROW 3.48 COL 5.5 WIDGET-ID 72
          BGCOLOR 1 FGCOLOR 7 FONT 6
     "DEDUCT":30 VIEW-AS TEXT
          SIZE 8.5 BY .95 AT ROW 18.86 COL 70.5
          BGCOLOR 19 FGCOLOR 6 FONT 6
     "Eng CC :":30 VIEW-AS TEXT
          SIZE 8 BY .95 AT ROW 6.81 COL 112.67
          BGCOLOR 19 FGCOLOR 4 FONT 6
     "เบี้ยรวม :":30 VIEW-AS TEXT
          SIZE 8.5 BY .95 AT ROW 16.48 COL 105
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "ผลตรวจสภาพ :":30 VIEW-AS TEXT
          SIZE 14 BY .95 AT ROW 21 COL 3.67 WIDGET-ID 136
          BGCOLOR 19 FGCOLOR 4 FONT 6
     "Pol 70 :" VIEW-AS TEXT
          SIZE 7.83 BY .95 AT ROW 3.33 COL 73.33 WIDGET-ID 158
          BGCOLOR 3 FGCOLOR 7 FONT 6
     "เลขตัวถังรถ :":20 VIEW-AS TEXT
          SIZE 11.83 BY .95 AT ROW 8 COL 53.17
          BGCOLOR 19 FGCOLOR 4 FONT 6
     "TP BI/Acc. :":30 VIEW-AS TEXT
          SIZE 12.17 BY .95 AT ROW 17.67 COL 38.33 WIDGET-ID 112
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "เลขตรวจสภาพ:":30 VIEW-AS TEXT
          SIZE 13.83 BY .95 AT ROW 5.67 COL 74.67
          BGCOLOR 19 FGCOLOR 6 FONT 6
     "Campaign No :":35 VIEW-AS TEXT
          SIZE 13.83 BY .95 AT ROW 14.14 COL 92.5 WIDGET-ID 102
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "  ข้อมูลรถและความคุ้มครอง" VIEW-AS TEXT
          SIZE 28.5 BY 1.57 AT ROW 1.48 COL 2.67 WIDGET-ID 138
          BGCOLOR 1 FGCOLOR 7 FONT 15
     " ทุนประกัน :":30 VIEW-AS TEXT
          SIZE 11 BY .95 AT ROW 15.33 COL 98.83
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "TP BI/Person :":30 VIEW-AS TEXT
          SIZE 14.5 BY .95 AT ROW 17.67 COL 3 WIDGET-ID 114
          BGCOLOR 19 FGCOLOR 2 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 134 BY 23.91
         BGCOLOR 3 FGCOLOR 1 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "เบี้ย พรบ :":30 VIEW-AS TEXT
          SIZE 9.83 BY .95 AT ROW 16.48 COL 82.83
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "Notify no.:" VIEW-AS TEXT
          SIZE 9.5 BY 1 AT ROW 1.95 COL 49
          BGCOLOR 19 FGCOLOR 4 FONT 6
     "เลขเครื่องยนต์ :":35 VIEW-AS TEXT
          SIZE 14 BY .95 AT ROW 8 COL 90.5
          BGCOLOR 19 FGCOLOR 4 FONT 6
     "41 PA :":30 VIEW-AS TEXT
          SIZE 7 BY .95 AT ROW 17.67 COL 99.5 WIDGET-ID 126
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "Product :" VIEW-AS TEXT
          SIZE 9.5 BY .95 AT ROW 15.29 COL 8.17 WIDGET-ID 48
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " ระบุผู้ขับขี่ :":30 VIEW-AS TEXT
          SIZE 11 BY .95 AT ROW 9 COL 5.83 WIDGET-ID 6
          BGCOLOR 19 FGCOLOR 4 FONT 6
     "43 BAIL BOND :":30 VIEW-AS TEXT
          SIZE 15.67 BY .95 AT ROW 18.86 COL 38.83 WIDGET-ID 128
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "        ยี่ห้อรถ :":30 VIEW-AS TEXT
          SIZE 13 BY .95 AT ROW 6.81 COL 4
          BGCOLOR 19 FGCOLOR 4 FONT 6
     "เบี้ยสุทธิ :":30 VIEW-AS TEXT
          SIZE 8.5 BY .95 AT ROW 16.48 COL 33.33
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " ปีรถ :":35 VIEW-AS TEXT
          SIZE 6 BY .95 AT ROW 6.81 COL 98.33
          BGCOLOR 19 FGCOLOR 4 FONT 6
     "ประเภทงาน :":30 VIEW-AS TEXT
          SIZE 11.5 BY .95 AT ROW 4.67 COL 5.67 WIDGET-ID 50
          BGCOLOR 19 FGCOLOR 4 FONT 6
     " No.Time :":30 VIEW-AS TEXT
          SIZE 10.17 BY 1 AT ROW 1.95 COL 101.83
          BGCOLOR 19 FGCOLOR 4 FONT 6
     "อุปกรณ์เสริมคุ้มครองไม่เกิน :":30 VIEW-AS TEXT
          SIZE 25.17 BY .95 AT ROW 20.05 COL 35.83
          BGCOLOR 19 FGCOLOR 4 FONT 6
     "TP PD/Acc.:":30 VIEW-AS TEXT
          SIZE 12.67 BY .95 AT ROW 17.67 COL 71.33 WIDGET-ID 116
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "Redbook:":35 VIEW-AS TEXT
          SIZE 9.67 BY .95 AT ROW 6.86 COL 74.83 WIDGET-ID 170
          BGCOLOR 19 FGCOLOR 4 FONT 6
     " ประเภทประกัน :":30 VIEW-AS TEXT
          SIZE 15.17 BY .95 AT ROW 14.14 COL 2.5 WIDGET-ID 40
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "วันหมดอายุความคุ้มครอง:":35 VIEW-AS TEXT
          SIZE 21.67 BY .95 AT ROW 5.71 COL 35.17
          BGCOLOR 19 FGCOLOR 4 FONT 6
     " Pack :":35 VIEW-AS TEXT
          SIZE 7 BY .95 AT ROW 15.33 COL 37.33
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " ประเภทรถ :" VIEW-AS TEXT
          SIZE 11.5 BY .95 AT ROW 14.19 COL 33.17 WIDGET-ID 42
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "ประกัน :":30 VIEW-AS TEXT
          SIZE 8 BY .95 AT ROW 4.57 COL 55.5 WIDGET-ID 44
          BGCOLOR 19 FGCOLOR 4 FONT 6
     "Notify Date :":30 VIEW-AS TEXT
          SIZE 12 BY 1 AT ROW 1.95 COL 76
          BGCOLOR 19 FGCOLOR 4 FONT 6
     "สูญหาย/ไฟไหม้ :":30 VIEW-AS TEXT
          SIZE 15 BY .95 AT ROW 16.48 COL 2.5 WIDGET-ID 166
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "   ทะเบียนรถ :":30 VIEW-AS TEXT
          SIZE 13 BY .95 AT ROW 7.91 COL 4.17
          BGCOLOR 19 FGCOLOR 4 FONT 6
     "Class :":35 VIEW-AS TEXT
          SIZE 6.5 BY .95 AT ROW 15.33 COL 50.33
          BGCOLOR 19 FGCOLOR 2 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 134 BY 23.91
         BGCOLOR 3 FGCOLOR 1 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "เลขสติ๊กเกอร์ :":30 VIEW-AS TEXT
          SIZE 12.17 BY .95 AT ROW 18.86 COL 94.17
          BGCOLOR 19 FGCOLOR 4 FONT 6
     "การซ่อม:":35 VIEW-AS TEXT
          SIZE 8.5 BY .95 AT ROW 15.33 COL 64
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "Bth.":30 VIEW-AS TEXT
          SIZE 4.5 BY .95 AT ROW 20.1 COL 78.33
          BGCOLOR 19 FGCOLOR 4 FONT 6
     RECT-488 AT ROW 1.05 COL 1.17
     RECT-490 AT ROW 1.81 COL 122.83
     RECT-494 AT ROW 3.05 COL 1.83 WIDGET-ID 4
     RECT-496 AT ROW 9.14 COL 18.83 WIDGET-ID 12
     RECT-498 AT ROW 3.24 COL 18 WIDGET-ID 60
     RECT-495 AT ROW 22.62 COL 122.17 WIDGET-ID 148
     RECT-499 AT ROW 22.62 COL 111.83 WIDGET-ID 150
     RECT-500 AT ROW 22.62 COL 80 WIDGET-ID 152
     RECT-501 AT ROW 3.14 COL 72.17 WIDGET-ID 162
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 134 BY 23.91
         BGCOLOR 3 FGCOLOR 1 .

DEFINE FRAME fr_driv
     ra_sex1 AT ROW 1.1 COL 48.5 NO-LABEL
     fi_drivername1 AT ROW 1.14 COL 9.33 COLON-ALIGNED NO-LABEL
     fi_hbdri1 AT ROW 1.19 COL 73 COLON-ALIGNED NO-LABEL
     fi_agedriv1 AT ROW 1.19 COL 92.17 COLON-ALIGNED NO-LABEL
     fi_occupdriv1 AT ROW 2.19 COL 9.33 COLON-ALIGNED NO-LABEL
     fi_idnodriv1 AT ROW 2.19 COL 46.33 COLON-ALIGNED NO-LABEL
     fi_agedriv2 AT ROW 3.19 COL 92.17 COLON-ALIGNED NO-LABEL
     fi_drivername2 AT ROW 3.24 COL 9.17 COLON-ALIGNED NO-LABEL
     ra_sex2 AT ROW 3.24 COL 48.5 NO-LABEL
     fi_hbdri2 AT ROW 3.24 COL 72.83 COLON-ALIGNED NO-LABEL
     fi_occupdriv2 AT ROW 4.33 COL 9 COLON-ALIGNED NO-LABEL
     fi_idnodriv2 AT ROW 4.38 COL 46.33 COLON-ALIGNED NO-LABEL
     "เพศ :" VIEW-AS TEXT
          SIZE 4.67 BY 1 AT ROW 3.24 COL 43.33 WIDGET-ID 16
          FGCOLOR 2 FONT 1
     "อาชีพ :" VIEW-AS TEXT
          SIZE 5.5 BY 1 AT ROW 4.33 COL 5.17 WIDGET-ID 22
          FGCOLOR 2 FONT 1
     "ชื่อผู้ขับขี่ 2 :" VIEW-AS TEXT
          SIZE 9.5 BY 1 AT ROW 3.19 COL 1.67 WIDGET-ID 14
          FGCOLOR 2 FONT 1
     "วันเกิด :" VIEW-AS TEXT
          SIZE 7 BY 1 AT ROW 1.14 COL 68 WIDGET-ID 6
          FGCOLOR 2 FONT 1
     "เพศ :" VIEW-AS TEXT
          SIZE 5 BY 1 AT ROW 1.14 COL 43.5 WIDGET-ID 4
          FGCOLOR 2 FONT 1
     "ชื่อผู้ขับขี่ 1 :" VIEW-AS TEXT
          SIZE 9.5 BY 1 AT ROW 1.14 COL 1.67 WIDGET-ID 2
          FGCOLOR 2 FONT 1
     "อาชีพ :" VIEW-AS TEXT
          SIZE 5.5 BY 1 AT ROW 2.1 COL 5.33 WIDGET-ID 10
          FGCOLOR 2 FONT 1
     "เลขบัตรประชาชน :" VIEW-AS TEXT
          SIZE 15 BY 1 AT ROW 4.38 COL 32.67 WIDGET-ID 24
          FGCOLOR 2 FONT 1
     "อายุ :" VIEW-AS TEXT
          SIZE 4.33 BY 1 AT ROW 1.19 COL 89.67 WIDGET-ID 8
          FGCOLOR 2 FONT 1
     "อายุ :" VIEW-AS TEXT
          SIZE 4.33 BY 1 AT ROW 3.19 COL 89.67 WIDGET-ID 20
          FGCOLOR 2 FONT 1
     "วันเกิด :" VIEW-AS TEXT
          SIZE 7 BY 1 AT ROW 3.19 COL 67.67 WIDGET-ID 18
          FGCOLOR 2 FONT 1
     "เลขบัตรประชาชน :" VIEW-AS TEXT
          SIZE 15 BY 1 AT ROW 2.14 COL 32.5 WIDGET-ID 12
          FGCOLOR 2 FONT 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         NO-LABELS SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 30 ROW 9.29
         SIZE 100 BY 4.57
         BGCOLOR 8 .


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
         TITLE              = "UPDATE  DATA BY TELEPHONE ..."
         HEIGHT             = 24
         WIDTH              = 133
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
IF NOT C-Win:LOAD-ICON("wimage/safety.ico":U) THEN
    MESSAGE "Unable to load icon: wimage/safety.ico"
            VIEW-AS ALERT-BOX WARNING BUTTONS OK.
&ENDIF
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* REPARENT FRAME */
ASSIGN FRAME fr_driv:FRAME = FRAME fr_main:HANDLE.

/* SETTINGS FOR FRAME fr_driv
                                                                        */
/* SETTINGS FOR FRAME fr_main
   FRAME-NAME Custom                                                    */

DEFINE VARIABLE XXTABVALXX AS LOGICAL NO-UNDO.

ASSIGN XXTABVALXX = FRAME fr_driv:MOVE-AFTER-TAB-ITEM (fi_userid:HANDLE IN FRAME fr_main)
       XXTABVALXX = FRAME fr_driv:MOVE-BEFORE-TAB-ITEM (ra_driv:HANDLE IN FRAME fr_main)
/* END-ASSIGN-TABS */.

/* SETTINGS FOR FILL-IN fi_notdat IN FRAME fr_main
   NO-ENABLE                                                            */
ASSIGN 
       fi_notdat:HIDDEN IN FRAME fr_main           = TRUE.

/* SETTINGS FOR FILL-IN fi_notino IN FRAME fr_main
   NO-ENABLE                                                            */
ASSIGN 
       fi_notino:HIDDEN IN FRAME fr_main           = TRUE.

/* SETTINGS FOR FILL-IN fi_nottim IN FRAME fr_main
   NO-ENABLE                                                            */
ASSIGN 
       fi_nottim:HIDDEN IN FRAME fr_main           = TRUE.

/* SETTINGS FOR FILL-IN fi_pol70 IN FRAME fr_main
   NO-ENABLE                                                            */
ASSIGN 
       fi_pol70:HIDDEN IN FRAME fr_main           = TRUE
       fi_pol70:READ-ONLY IN FRAME fr_main        = TRUE.

/* SETTINGS FOR FILL-IN fi_pol72 IN FRAME fr_main
   NO-ENABLE                                                            */
ASSIGN 
       fi_pol72:HIDDEN IN FRAME fr_main           = TRUE
       fi_pol72:READ-ONLY IN FRAME fr_main        = TRUE.

/* SETTINGS FOR FILL-IN fi_userid IN FRAME fr_main
   NO-ENABLE                                                            */
ASSIGN 
       fi_userid:HIDDEN IN FRAME fr_main           = TRUE.

/* SETTINGS FOR RADIO-SET ra_comp IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR RADIO-SET ra_cover IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR RADIO-SET ra_pree IN FRAME fr_main
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* UPDATE  DATA BY TELEPHONE ... */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* UPDATE  DATA BY TELEPHONE ... */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_brand
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_brand C-Win
ON CHOOSE OF bu_brand IN FRAME fr_main
DO:
    Run  wgw\wgwhpmod(Input-output  fi_model,    
                      INPUT-OUTPUT  fi_brand,    
                      Input-output  fi_year,     
                      Input-output  fi_power ,
                      OUTPUT fi_redbook,
                      OUTPUT nv_sumsi).  


    IF fi_cover1 = "1" AND fi_quo = "" THEN 
        ASSIGN fi_sumsi =  nv_sumsi 
               fi_sumfi =  nv_sumsi . 

    Disp fi_brand fi_model fi_year fi_power fi_redbook fi_sumsi fi_sumfi  with frame  fr_main.  
    IF fi_brand = "" THEN DO:
        APPLY "Entry" TO fi_brand.
        RETURN NO-APPLY.
    END.
    IF fi_model = ""  THEN DO:
        Apply "Entry"  To  fi_model .
        Return no-apply.
    END.
    ELSE DO:
        Apply "Entry"  To  fi_licence1 .
        Return no-apply.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_cam
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_cam C-Win
ON CHOOSE OF bu_cam IN FRAME fr_main
DO:
    /* Add by A62-0219 */
    ASSIGN n_campno   = ""
           n_gar      = ""
           n_pack     = ""
           n_company  = ""
           n_tpp      = ""
           n_tpa      = ""
           n_tpd      = ""
           n_41       = ""
           n_42       = ""
           n_43       = "" .
    Run  wgw\wgwphcam(Input-output  fi_cover1,
                      input-output  n_campno , 
                      input-output  n_gar    , 
                      input-output  n_pack   , 
                      input-output  n_company, 
                      input-output  n_tpp    , 
                      input-output  n_tpa    , 
                      input-output  n_tpd    , 
                      input-output  n_41     , 
                      input-output  n_42     , 
                      input-output  n_43     ).

    IF n_campno <> ""   THEN DO:

        IF  trim(n_company) <> "" AND INDEX(n_company,nv_comco) = 0 THEN DO:
            MESSAGE " Campaign Code Use for Company :" n_company " Only ! " VIEW-AS ALERT-BOX.
            Apply "Entry"  To  fi_campaign.
            Return no-apply.
        END.
        ELSE DO:
            ASSIGN fi_campaign = n_campno
               co_garage   = "ซ่อม" + trim(n_gar)
               fi_pack     = SUBSTR(n_pack,1,1)
               fi_class    = SUBSTR(n_pack,2,3)
               fi_garage   = IF trim(n_gar) = "ห้าง" THEN "G" ELSE "" 
               fi_tp       = int(n_tpp)    
               fi_ta       = int(n_tpa)    
               fi_td       = int(n_tpd)    
               fi_41       = int(n_41)    
               fi_42       = int(n_42)    
               fi_43       = int(n_43)
               fi_sumsi     = 0 
               fi_sumfi     = 0
               fi_gap       = 0 
               fi_premium   = 0 
               fi_precomp   = 0 
               fi_totlepre  = 0
               fi_baseod    = 0
               fi_quo       = ""
               n_quota      = "" .
        /* a63-0392 */
        IF fi_cover1 = "1" AND fi_garage = "G" THEN ASSIGN fi_pack = "U" . 
        ELSE fi_pack = "T" .
        /* end A63-0392 */
        END.
    END.
    DISP fi_cover1 fi_campaign co_garage  fi_pack  fi_class  fi_garage fi_quo fi_sumfi
         fi_sumsi  fi_gap  fi_premium  fi_precomp  fi_totlepre fi_baseod 
         fi_tp     fi_ta   fi_td       fi_41       fi_42       fi_43    with frame  fr_main.
   
    Apply "Entry"  To ra_pa.
    Return no-apply.

                    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_cover
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_cover C-Win
ON CHOOSE OF bu_cover IN FRAME fr_main
DO:
    Run  wgw\wgwhpco1(Input-output  fi_cover1).
    /*Add kridtiya i.A55-0108 */
    /*IF      fi_comco = "SCB"   THEN fi_benname = "ธนาคารไทยพาณิชย์ จำกัด (มหาชน)".
    ELSE IF fi_comco = "AYCAL" THEN fi_benname = "บริษัท อยุธยา แคปปิตอล ออโต้ลิส จำกัด(มหาชน)".
    ELSE IF fi_comco = "TCR"   THEN fi_benname = "ธนาคาร ไทยเครดิต เพื่อรายย่อย จำกัด (มหาชน)".
    ELSE IF fi_comco = "ASK"   THEN fi_benname = "บริษัท เอเซียเสริมกิจลีสซิ่ง จำกัด (มหาชน)".
    ELSE IF fi_comco = "BGPL"  THEN fi_benname = "บริษัท กรุงเทพแกรนด์แปซิฟิคลีส จำกัด ( มหาชน)".
    ELSE IF fi_comco = "RTN"   THEN fi_benname = "บริษัท ราชธานี ลีสซิ่ง จำกัด (มหาชน)".
    ELSE fi_benname = "".*/
    /*ASSIGN  fi_benname   = nv_benname .    /*A56-0024*/
    IF (nv_cartyp = "BIKE(บุคคล)") OR (nv_cartyp = "BIKE(พาณิชย์)")  THEN ASSIGN fi_pack = "Z" .
    ELSE IF fi_cover1 = "1" THEN ASSIGN fi_pack = "G".
    ELSE IF fi_cover1 = "2" THEN ASSIGN fi_pack = "Y".
    ELSE IF fi_cover1 = "3" THEN 
        ASSIGN fi_pack = "R" 
        fi_benname  = ""   .
    ELSE IF fi_cover1 = "5" THEN ASSIGN fi_pack = "B".
    /*Add kridtiya i.A55-0108 */*/
    Disp  fi_cover1  with frame  fr_main.
    Apply "Entry"  To  fi_cover1.
    Return no-apply.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_exit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_exit C-Win
ON CHOOSE OF bu_exit IN FRAME fr_main /* Exit */
DO:
    MESSAGE "Do you want EXIT now...  !!!!"         SKIP
        "Are you sure SAVE Complete...  !!!!"   SKIP
        VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO     /*-CANCEL */    
        TITLE "" UPDATE choice AS LOGICAL.
    CASE choice:  
        WHEN TRUE THEN  /* Yes */ 
            DO: 
            RELEASE brstat.tlt.
            Apply "Close"  To this-procedure.
            Return no-apply.
        END.
    END CASE. 
    APPLY "entry" TO bu_save.
    RETURN NO-APPLY.
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_not1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_not1 C-Win
ON CHOOSE OF bu_not1 IN FRAME fr_main /* ข้อมูลลูกค้า */
DO:
     {&WINDOW-NAME}:hidden  =  Yes. 
      Run  wgw\wgwqupo21(Input nv_recidtlt).
      Apply "Close"  To this-procedure.
      RETURN NO-APPLY.
     {&WINDOW-NAME}:hidden  =  No. 
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_notes
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_notes C-Win
ON CHOOSE OF bu_notes IN FRAME fr_main /* Notes */
DO:
  
    ASSIGN              
        nv_year      = STRING(YEAR(TODAY))
        nv_year      = SUBSTR(nv_year,3,2) 
        /* real database */
        NotesServer  = "Safety_NotesServer/Safety"
        NotesApp     = "safety\uw\inspect" + nv_year + ".nsf"
        
        /* test database 
        NotesServer  = ""
        NotesApp     = "D:\Lotus\Notes\Data\inspect" + nv_year + ".nsf" */

        /*NotesView    = "เลขตัวถัง"*/ /*A62-0219*/
        NotesView    = "chassis_no" /* วิวซ่อนของเลขตัวถัง */ /*A62-0219*/
        nv_chkdoc    = NO             
        nv_msgbox    = ""
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
        nv_provin    = "" /*A62-0219*/
        nv_key1      = "" /*A62-0219*/
        nv_key2      = "" /*A62-0219*/
        nv_key3      = "" /*A62-0219*/
        nv_cha_no    = TRIM(fi_cha_no).
                                                                                                                                           
    nv_licence1 = trim(fi_licence1).
    nv_licence2 = trim(fi_licence2).

    IF TRIM(nv_licence1) = ""
    OR TRIM(nv_licence2) = ""
    OR TRIM(nv_cha_no)   = "" THEN DO:

        MESSAGE "ทะเบียนรถ หรือ เลขตัวถัง เป็นค่าว่าง" SKIP
                "กรุณาระบุข้อมูลให้ครบถ้วน !" 
        VIEW-AS ALERT-BOX ERROR.
        RETURN NO-APPLY.
    END.

     /* add by a62-0219 */
    IF TRIM(fi_provin) <> "" THEN DO:
        FIND FIRST brstat.insure USE-INDEX Insure05   WHERE   /*use-index fname */
                brstat.insure.compno = "999" AND 
                brstat.insure.FName  = TRIM(fi_provin) NO-LOCK NO-WAIT NO-ERROR.
            IF AVAIL brstat.insure THEN  ASSIGN nv_provin = brstat.Insure.LName.
            ELSE ASSIGN nv_provin = TRIM(fi_provin).
    END.
    /* end A62-0219 */
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
        
        /* nv_branch */       
        IF nv_notno70 <> ""  THEN DO:                        
            IF SUBSTR(nv_notno70,1,1) >  "0" AND 
               SUBSTR(nv_notno70,1,1) <= "9" THEN DO:  
                nv_branch = SUBSTR(nv_notno70,1,2).
                RUN PD_BranchNotes.    
            END.  /* ELSE nv_branch = SUBSTR(nv_notno70,2,1).*/ /*A62-0219*/
            /*A62-0219*/
            ELSE IF SUBSTR(nv_notno70,1,1) =  "D" THEN DO:
                nv_branch = SUBSTR(nv_notno70,2,1).
                RUN PD_BranchNotes.    
            END.
            ELSE nv_branch = "" .
        END.
        /* end A62-0219 */
        IF nv_branch = "" THEN RUN PD_BranchNotes. /*A62-0219*/

        /* nv_brname */
        FIND FIRST sicsyac.xmm600                               
             WHERE sicsyac.xmm600.acno = nv_producer  NO-LOCK NO-ERROR.
        IF AVAIL sicsyac.xmm600 THEN nv_brname = sicsyac.xmm600.NAME.
        /*----------*/
               
        /* nv_licence */ 
        /* comment by A63-0392 ....
        IF LENGTH(nv_licence1) = 3 THEN                          
            nv_licence1 = SUBSTR(nv_licence1,1,1) + " " + SUBSTR(nv_licence1,2,2).
        ... end A63-0392...*/

        nv_licence1 = nv_licence1 + " " + nv_licence2.
        /*------------*/
        
        /* nv_pattern */        
        DO nv_count = 1 TO LENGTH(nv_licence1):                 
            nv_text1 = SUBSTR(nv_licence1,nv_count,1).

            IF nv_text1 = " " THEN nv_text2 = "-".
            ELSE DO:
                nv_chktext = INT(nv_text1) NO-ERROR.

                IF ERROR-STATUS:ERROR THEN nv_text2 = "x".
                ELSE nv_text2 = "y".
            END.

            nv_pattern = nv_pattern + nv_text2.
        END.
        nv_pattern = nv_pattern + "-xx".
        /*------------*/
        
        /* Check Record Duplication */        
        chWorkspace:OpenDatabase(NotesServer,NotesApp,NotesView,"",FALSE,FALSE).
        chView = chDatabase:GetView(NotesView).        

        IF VALID-HANDLE(chView) = NO THEN DO:
            nv_chkdoc = NO.
            nv_msgbox = "Can not Connect View !".
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
                        nv_key2   = nv_licence1 + " " + fi_provin.  /* PM */
                        nv_key3   = nv_licence1 + " " + nv_provin . /*A62-0219*/          /* PM */
                        
                        IF nv_key1 = nv_key2 OR nv_key1 = nv_key3 THEN DO:
                            /*nv_surcl  = chDocument:GetFirstItem("SurveyClose"):TEXT. */  /*A62-0219*/
                            /* add by A62-0219 */
                            chitem       = chDocument:Getfirstitem("SurveyClose").    /* สเตตัสปิดเรื่อง */
                            IF chitem <> 0 THEN nv_surcl   = chitem:TEXT. 
                            ELSE nv_surcl  = "".
                           /* end A62-0219*/
                            IF nv_surcl = "" THEN DO:                            
                                nv_docno  = chDocument:GetFirstItem("docno"):TEXT.
                                nv_chkdoc = NO.
                                nv_msgbox = "มีข้อมูลเลขตัวถังกับเลขทะเบียนในกล่อง ยังไม่ปิดเรื่อง " + nv_docno .
                                LEAVE loop_chkrecord.
                            END.
                            ELSE DO:
                                /* A62-0219 */
                                chitem       = chDocument:Getfirstitem("ConsiderDate").      /*วันที่ปิดเรื่อง*/
                                IF chitem <> 0 THEN nv_date = chitem:TEXT. 
                                ELSE nv_date = "".

                                nv_docno  = chDocument:GetFirstItem("docno"):TEXT.

                                nv_msgbox = "มีข้อมูลเลขตัวถังกับเลขทะเบียนในกล่อง ปิดเรื่องแล้ว " + nv_docno .
                               
                                nv_chkdoc = NO.
                                LEAVE loop_chkrecord.

                               /* IF nv_date <> "" AND YEAR(DATE(nv_date)) = YEAR(TODAY) THEN DO:
                                    nv_chkdoc = NO.
                                    LEAVE loop_chkrecord.
                                END.
                                ELSE DO:*/
                                 /* comment by A62-0219 ....
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
                               ..end a62-0219..*/
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
                    END.
                END.                
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
                FIND tlt WHERE RECID(tlt) = nv_recidtlt NO-ERROR NO-WAIT.
                IF AVAIL tlt THEN DO:
                    nv_chknotes = "L".
                    tlt.comp_noti_ins = TRIM(SUBSTR(tlt.comp_noti_ins,1,20)) 
                                      + FILL(" ", 20 - LENGTH(TRIM(SUBSTR(tlt.comp_noti_ins,1,20))))
                                      + nv_chknotes.
                    /* create A62-0219 */
                     ASSIGN 
                     tlt.gentim        = trim(nv_detail + " " + nv_damage + " " + nv_damlist + " " + 
                                              nv_damdetail + " " + nv_surdata + " " + nv_device + " " + nv_acctotal )   /* ผลตรวจสภาพ*/
                     tlt.dri_no2       = TRIM(nv_docno) + FILL(" ", 50 - LENGTH(TRIM(nv_docno))) + "Y"
                     fi_ispno          = nv_docno
                     fi_ispstatus      = IF fi_ispno = "" THEN "N" ELSE "Y" 
                     fi_remark         = tlt.gentim .
                    /* end A62-0219 */
                END.

                RELEASE tlt.            
                DISABLE bu_notes WITH FRAME fr_main.
            END.
            ELSE DO:
                chDocument = chDatabase:CreateDocument.
                ASSIGN
                    chDocument:FORM        = "Inspection"                        
                    chDocument:createdBy   = nv_name                             
                    chDocument:createdOn   = nv_datim                            
                    chDocument:dateS       = fi_comdat                           
                    chDocument:dateE       = fi_expdat                           
                    chDocument:ReqType_sub = "ลูกค้า/ตัวแทน/นายหน้าเป็นผู้ส่งรูปตรวจสภาพ"
                    chDocument:BranchReq   = nv_branch                           
                    chDocument:Tname       = "บุคคล"                             
                    chDocument:Fname       = nv_preinsur                         
                    chDocument:Lname       = nv_preinsur2                        
                    chDocument:phone1      = TRIM(SUBSTR(nv_insadd6tel,1,20))    
                    chDocument:PolicyNo    = nv_notno70                          
                    chDocument:agentCode   = nv_producer /*nv_agent   */                         
                    chDocument:agentName   = nv_brname                           
                    chDocument:Premium     = fi_premium                          
                    chDocument:model       = fi_brand  /*nv_model    */                        
                    chDocument:modelCode   = fi_model  /*nv_modelcode*/                        
                    chDocument:Year        = fi_year                             
                    chDocument:carCC       = fi_cha_no                           
                    chDocument:LicenseType = "รถเก๋ง/กระบะ/บรรทุก"               
                    chDocument:PatternLi1  = nv_pattern                          
                    chDocument:LicenseNo_1 = nv_licence1                         
                    /*chDocument:LicenseNo_2 = fi_provin */ /*A62-0219*/ 
                    chDocument:LicenseNo_2 = nv_provin      /*a62-0219*/
                    chDocument:App         = 0                                   
                    chDocument:Chk         = 0                                   
                    chDocument:StList      = 0                                   
                    chDocument:stHide      = 0                                   
                    chDocument:SendTo      = ""                                  
                    chDocument:SendCC      = ""                                  
                    chDocument:SendClose   = ""
                    chDocument:SurveyClose = ""                    
                    chDocument:docno       = "".       
            
                /*chDocument:SAVE(TRUE,FALSE).*/ /*A62-0219*/
                chDocument:SAVE(TRUE,TRUE).  /*A62-0219*/
                chWorkSpace:ViewRefresh.                                                            
                                                                                                    
                FIND tlt WHERE RECID(tlt) = nv_recidtlt NO-ERROR NO-WAIT.                           
                IF AVAIL tlt THEN DO:      
                    nv_chknotes       = "L".
                    tlt.comp_noti_ins = TRIM(SUBSTR(tlt.comp_noti_ins,1,20))                        
                                      + FILL(" ", 20 - LENGTH(TRIM(SUBSTR(tlt.comp_noti_ins,1,20))))
                                      + nv_chknotes.                                                        
                END.                                                                                
                RELEASE tlt. 
                fi_ispstatus = "Y" .   
                                                                                                    
                /* comment a62-0219 */
                chUIDocument = chWorkSpace:CurrentDocument.                                         
                chUIDocument = chWorkSpace:EditDocument(FALSE,chDocument) NO-ERROR.
                /*.. end A62-0219 ...*/                
                                                                                                    
                nv_msgbox = "Create Record in Lotus Notes Complete !".                              
                                                                                                    
                DISABLE bu_notes WITH FRAME fr_main.                                                
            END.                                            
        END.
    END.
    DISP fi_ispno fi_ispstatus fi_remark WITH FRAME fr_main.
    IF nv_msgbox <> "" THEN MESSAGE nv_msgbox VIEW-AS ALERT-BOX INFORMATION.    
    
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


&Scoped-define SELF-NAME bu_product
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_product C-Win
ON CHOOSE OF bu_product IN FRAME fr_main
DO:
    Run  wgw\wgwhppro(Input-output  fi_product).
    
    IF SUBSTR(fi_product,1,2) = "PB" OR SUBSTR(fi_product,1,2) = "PA"  THEN ASSIGN ra_pa = 2. /*A63-0392*/

    Disp  fi_product ra_pa  with frame  fr_main.

    Apply "Entry"  To  fi_product.
    Return no-apply. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_quo-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_quo-2 C-Win
ON CHOOSE OF bu_quo-2 IN FRAME fr_main /* Quotation */
DO:    
    n_chk = YES.
    RUN wgw\wgwqupoQ (INPUT  fi_quo,      INPUT-OUTPUT n_chk,  OUTPUT fi_redbook,
                      OUTPUT fi_brand,    OUTPUT fi_model,     OUTPUT fi_year,     
                      OUTPUT fi_power,    OUTPUT ra_driv,                      
                      OUTPUT fi_drivername1, OUTPUT fi_drivername2,
                      OUTPUT ra_sex1,        OUTPUT ra_sex2,
                      OUTPUT fi_hbdri1,      OUTPUT fi_hbdri2,
                      OUTPUT fi_agedriv1,    OUTPUT fi_agedriv2,
                      OUTPUT fi_occupdriv1,  OUTPUT fi_occupdriv2,
                      OUTPUT fi_idnodriv1,   OUTPUT fi_idnodriv2,
                      OUTPUT fi_pack,     OUTPUT fi_class,    OUTPUT fi_garage,
                      OUTPUT fi_sumsi,    OUTPUT fi_gap,      OUTPUT fi_premium,
                      OUTPUT fi_precomp,  OUTPUT fi_totlepre, OUTPUT fi_baseod,
                      output fi_tp , 
                      output fi_ta , 
                      output fi_td , 
                      output fi_41 , 
                      output fi_42 , 
                      output fi_43 ).         

    IF n_chk = YES THEN DO:  

        fi_campaign  = "" .  
        IF fi_cover1 = "1" THEN ASSIGN fi_sumfi = fi_sumsi. 
        IF fi_garage = "G" THEN ASSIGN co_garage = "ซ่อมห้าง" .
        ELSE ASSIGN co_garage = "ซ่อมอู่" .

        ASSIGN n_quota = fi_quo.
        DISP fi_brand       fi_model     fi_year     fi_power 
             ra_driv        fi_pack      fi_class    fi_garage
             fi_sumsi       fi_gap       fi_premium  fi_precomp
             fi_totlepre    fi_baseod    fi_redbook  fi_tp 
             fi_ta          fi_td        fi_41       fi_42
             fi_43          fi_campaign  fi_sumfi    co_garage
        WITH FRAME fr_main.
    
        DISP fi_drivername1   fi_drivername2   ra_sex1         ra_sex2 
             fi_hbdri1        fi_hbdri2        fi_agedriv1     fi_agedriv2
             fi_occupdriv1    fi_occupdriv2    fi_idnodriv1    fi_idnodriv2
        WITH FRAME fr_driv.
    
       IF ra_driv = 2 THEN DO:
            ENABLE ALL WITH FRAME fr_driv.
            
        END. 
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_save
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_save C-Win
ON CHOOSE OF bu_save IN FRAME fr_main /* Save */
DO:
    IF ra_pa = 2 AND fi_product = ""  THEN DO:
        MESSAGE "กรุณาเลือก Product ของงาน PA "  VIEW-AS ALERT-BOX.
        ASSIGN fi_product = "".
        APPLY "entry" TO ra_pa.
        RETURN NO-APPLY.  
    END.
    ELSE DO:
        MESSAGE "Do you want SAVE  !!!!"        
        VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO     /*-CANCEL */    
        TITLE "" UPDATE choice AS LOGICAL.
        CASE choice:         
        WHEN TRUE THEN  /* Yes */ 
        DO: 
            
            IF nv_notno70  <> "" THEN DO:
                FIND LAST  tlt    WHERE 
                    tlt.genusr        = "Phone"      AND
                    tlt.policy        =  nv_notno70   NO-LOCK NO-ERROR NO-WAIT.
                IF AVAIL tlt THEN DO:
                    IF tlt.nor_noti_tlt <> fi_notino  THEN DO:
                        MESSAGE "Found policy70 duplicate...tlt: " + tlt.nor_noti_tlt VIEW-AS ALERT-BOX.
                        RETURN NO-APPLY.
                    END.
                END.
            END.
            IF nv_notno72 <> "" THEN DO:
                FIND LAST  tlt    WHERE 
                    tlt.genusr        = "Phone"  AND
                    tlt.comp_pol      = nv_notno72   NO-LOCK NO-ERROR NO-WAIT.
                IF AVAIL tlt THEN DO:
                    IF tlt.nor_noti_tlt <> fi_notino  THEN DO:
                        MESSAGE "Found policy72 duplicate...tlt: " + tlt.nor_noti_tlt VIEW-AS ALERT-BOX.
                        RETURN NO-APPLY.
                    END.
                END.
            END.
        
            ASSIGN n_quota = INPUT fi_quo.
            IF LENGTH(n_quota) <= 4 THEN DO: 
                n_quota  = "".
                n_garage = "".
            END.
            ELSE DO:
                n_quota  = n_quota + FILL(" ", 20 - LENGTH(n_quota)).
                n_garage = co_garage.
                n_garage = n_garage + FILL(" ", 20 - LENGTH(n_garage)).
            END.
        
            Find  tlt  Where   Recid(tlt)  =  nv_recidtlt  NO-ERROR NO-WAIT .
            IF AVAIL tlt THEN DO: 
               
                ASSIGN 
                     tlt.subins       = trim(fi_campaign)
                     tlt.safe1        = co_caruse
                     tlt.safe3        = trim(fi_cover1)
                     /*tlt.stat         = IF ra_pa = 1   THEN "" ELSE fi_product */ /*A63-0392*/
                     tlt.stat         = TRIM(fi_product)   /*A63-0392*/
                     tlt.dri_name1    = IF ra_driv = 1 THEN ""
                                        ELSE IF trim(fi_drivername1) = "" THEN ""
                                        ELSE  trim(fi_drivername1) + " sex:" + string(ra_sex1)  + " hbd:" + STRING(fi_hbdri1) + " age:" +  string(fi_agedriv1) + " occ:" + trim(fi_occupdriv1) 
                     tlt.dri_no1      = IF ra_driv = 1 THEN ""
                                        ELSE trim(fi_idnodriv1) 
                     tlt.enttim       = IF ra_driv = 1 THEN ""
                                        ELSE IF trim(fi_drivername2) = "" THEN ""
                                        ELSE  trim(fi_drivername2) + " sex:" + string(ra_sex2)  + " hbd:" + STRING(fi_hbdri2) + "age:" +  string(fi_agedriv2) + "occ:" + trim(fi_occupdriv2) 
                     tlt.expotim      = IF ra_driv = 1 THEN ""
                                        ELSE trim(fi_idnodriv2)
                     tlt.nor_effdat   = INPUT fi_comdat         
                     tlt.expodat      = Input fi_expdat
                     tlt.dri_no2      = trim(fi_ispno) 
                     tlt.dri_no2      = TRIM(fi_ispno) + FILL(" ", 50 - LENGTH(TRIM(fi_ispno))) + fi_ispstatus  
                     tlt.brand        = TRIM(fi_brand) + IF TRIM(fi_redbook) <> "" THEN " RB:" + TRIM(fi_redbook) ELSE ""           
                     tlt.model        = trim(Input fi_model)
                     tlt.lince2       = trim(Input fi_year) 
                     tlt.cc_weight    = INPUT fi_power
                     tlt.lince1       = trim(fi_licence1) + " " +      
                                        trim(fi_licence2) + " " +      
                                        trim(fi_provin)
                     tlt.cha_no       = trim(fi_cha_no)
                     tlt.eng_no       = trim(fi_eng_no)
                     tlt.lince3       = trim(fi_pack)  +        
                                        trim(fi_class)         
                     tlt.exp          = trim(fi_garage)       
                     tlt.nor_coamt    = fi_sumsi 
                     tlt.sentcnt      = fi_sumfi   
                     tlt.dri_name2    = STRING(fi_gap )
                     tlt.nor_grprm    = fi_premium  
                     tlt.comp_coamt   = fi_precomp  
                     tlt.comp_grprm   = fi_totlepre
                     tlt.comp_sck     = "STK:" + trim(fi_stk) + " " + "DOC:" + TRIM(fi_doc1)
                     tlt.rec_addr2    = "TPP:" + string(fi_tp) + " " +
                                        "TPA:" + string(fi_ta) + " " +
                                        "TPD:" + string(fi_td) 
                     tlt.rec_addr3    = "41:" +  string(fi_41) + " " +
                                        "42:" +  string(fi_42) + " " +
                                        "43:" +  string(fi_43)
                     tlt.gentim       = TRIM(fi_remark)     /* ผลตรวจสภาพ*/
                     n_remark1        = USERID(LDBNAME(1))  + " : " + TRIM(n_remark1)  
                     n_remark1        = n_remark1 + FILL(" ", 100 - LENGTH(n_remark1))
                 
                     n_remark2        = TRIM(n_remark2)                              
                     n_remark2        = n_remark2 + FILL(" ", 100 - LENGTH(n_remark2))
                    
                     n_other1         = "อุปกรณ์เสริมคุ้มครองไม่เกิน"
                     n_other1         = n_other1 + FILL(" ", 50 - LENGTH(n_other1))
                     n_other2         = STRING(fi_other2) + FILL(" " , 10 - LENGTH(STRING(fi_other2))) 
                     n_other3         = STRING(fi_other3) + FILL(" " , 60 - LENGTH(STRING(fi_other3)))
                                                                                                                             
                     tlt.OLD_cha      = n_remark1 + n_remark2 + n_other1 + n_other2 + n_other3 + n_quota + n_garage
                 
                     tlt.OLD_eng      = IF ra_complete = 1 THEN "complete"
                                        ELSE "not complete"
                     tlt.genusr       = "Phone"  
                     tlt.imp          = "IM"                     /*Import Data*/
                     /*tlt.releas     = "No" */ /*a62-0343*/
                     tlt.rec_addr5    = IF      co_caruse = "BIKE(บุคคล)"    THEN STRING(fi_baseod)      /*A57-0063*/
                                        ELSE IF co_caruse = "BIKE(พาณิชย์)"  THEN STRING(fi_baseod) 
                                        ELSE "0" .  
                     tlt.rec_addr5    =  STRING(fi_baseod) .                                                                                            
            END.
            RELEASE brstat.tlt.
            Apply "Close"  To this-procedure.
            Return no-apply.
        END.
        WHEN FALSE THEN /* No */          
                DO:   
                RETURN NO-APPLY.
            END.
        END CASE. 
    END.
   
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME co_caruse
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL co_caruse C-Win
ON LEAVE OF co_caruse IN FRAME fr_main
DO:
  co_caruse = INPUT co_caruse. 
   
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL co_caruse C-Win
ON return OF co_caruse IN FRAME fr_main
DO:
  APPLY "LEAVE" TO co_caruse.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL co_caruse C-Win
ON VALUE-CHANGED OF co_caruse IN FRAME fr_main
DO:
    co_caruse = INPUT co_caruse.
    ASSIGN nv_cartyp = co_caruse.
    /* add by : A63-0392 */
    IF fi_cover1 = "1" AND fi_garage = "G" THEN ASSIGN fi_pack = "U" .
    ELSE ASSIGN fi_pack = "T" .
    IF  nv_cartyp = "เก๋ง" THEN DO:
        ASSIGN fi_class = "110".
    END.
    ELSE IF nv_cartyp = "กระบะ" THEN DO:
        ASSIGN fi_class = "320".
    END.
    ELSE IF nv_cartyp = "โดยสาร(บุคคล)"  THEN DO:
        ASSIGN fi_class = "210".
    END.
    ELSE IF nv_cartyp = "โดยสาร(พาณิชย์)" THEN DO:
        ASSIGN fi_class = "220".
    END. 
    ELSE IF nv_cartyp = "BIKE(บุคคล)" THEN DO:
        ASSIGN fi_class   = "610" .
           
    END.
    ELSE IF nv_cartyp = "BIKE(พาณิชย์)" THEN DO:
        ASSIGN fi_class   = "620" .
    END.
    /* end A63-0392*/
    /*IF  nv_cartyp = "เก๋ง" THEN DO:
        ASSIGN fi_class = "110".
        IF fi_cover1 = "3" THEN 
            ASSIGN fi_pack = "V"  
            fi_benname  = "" .
        disable fi_baseod .
    END.
    ELSE IF nv_cartyp = "กระบะ" THEN DO:
        ASSIGN fi_class = "320".
        IF fi_cover1 = "3" THEN 
            ASSIGN fi_pack = "R"  
            fi_benname  = "".
        disable fi_baseod .
    END.
    ELSE IF nv_cartyp = "โดยสาร(บุคคล)"  THEN DO:
        ASSIGN fi_class = "210".
        IF fi_cover1 = "3" THEN DO:
            IF nv_cartyp = "กระบะ"  THEN
                ASSIGN 
                fi_pack    = "R" 
                fi_class   = "" 
                fi_garage  = ""
                fi_benname = "" .
            ELSE ASSIGN    
                fi_pack    = "V"  
                fi_class   = "" 
                fi_garage  = ""
                fi_benname = "" .
        END.
        disable fi_baseod  WITH FRAM fr_main.
    END.
    ELSE IF nv_cartyp = "โดยสาร(พาณิชย์)" THEN DO:
        ASSIGN fi_class = "220".
        IF fi_cover1 = "3" THEN DO:
            IF nv_cartyp = "กระบะ"  THEN
                ASSIGN 
                fi_pack    = "R" 
                fi_class   = "" 
                fi_garage  = ""
                fi_benname = "" .
            ELSE ASSIGN    
                fi_pack    = "V"  
                fi_class   = "" 
                fi_garage  = ""
                fi_benname = "" .
        END.
        disable fi_baseod  WITH FRAM fr_main.
    END. 
    ELSE IF nv_cartyp = "BIKE(บุคคล)" THEN DO:
        ASSIGN 
            fi_pack    = "Z"
            fi_class   = "610" 
            fi_garage  = "G"
            fi_benname = "" .
        ENABLE  fi_baseod  WITH FRAM fr_main.
    END.
    ELSE IF nv_cartyp = "BIKE(พาณิชย์)" THEN DO:
        ASSIGN 
            fi_pack    = "Z"
            fi_class   = "620" 
            fi_garage  = "G"
            fi_benname = "" .
        ENABLE  fi_baseod  WITH FRAM fr_main.
    END.*/
    DISP co_caruse  fi_pack fi_class /*fi_benname*/ fi_garage  WITH FRAM fr_main.
    APPLY "entry" TO fi_cover1.
    RETURN NO-APPLY.
  DISP co_caruse WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME co_garage
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL co_garage C-Win
ON VALUE-CHANGED OF co_garage IN FRAME fr_main
DO:
    co_garage = INPUT co_garage .

    IF co_garage = "ซ่อมห้าง" THEN 
        ASSIGN fi_garage = "G".
    ELSE  ASSIGN fi_garage = "" .

    DISP co_garage fi_garage WITH FRAM fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_41
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_41 C-Win
ON LEAVE OF fi_41 IN FRAME fr_main
DO:
    fi_41   = INPUT fi_41.
    DISP fi_41   WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_42
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_42 C-Win
ON LEAVE OF fi_42 IN FRAME fr_main
DO:
    fi_42  = INPUT fi_42.
    DISP fi_42 WITH FRAM fr_main. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_43
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_43 C-Win
ON LEAVE OF fi_43 IN FRAME fr_main
DO:
    fi_43  = INPUT fi_43.
    
    DISP fi_43 fi_totlepre WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fr_driv
&Scoped-define SELF-NAME fi_agedriv1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_agedriv1 C-Win
ON LEAVE OF fi_agedriv1 IN FRAME fr_driv
DO:
  fi_agedriv1  = INPUT fi_agedriv1.
  DISP fi_agedriv1 WITH FRAM fr_driv.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_agedriv2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_agedriv2 C-Win
ON LEAVE OF fi_agedriv2 IN FRAME fr_driv
DO:
  fi_agedriv2  = INPUT fi_agedriv2.
  DISP fi_agedriv2 WITH FRAM fr_driv.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fr_main
&Scoped-define SELF-NAME fi_baseod
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_baseod C-Win
ON LEAVE OF fi_baseod IN FRAME fr_main
DO:
    fi_baseod = INPUT fi_baseod.
    DISP fi_baseod WITH FRAM fr_main. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_brand
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_brand C-Win
ON LEAVE OF fi_brand IN FRAME fr_main
DO:
   /* fi_brand = caps(INPUT fi_brand ).
    IF ra_cover = 1 THEN DO:   /*new car */
        IF TRIM(fi_brand) = "isuzu" THEN ASSIGN fi_pack = "V".
        ELSE IF TRIM(fi_brand) = "hondda" THEN ASSIGN fi_pack = "H".
        ELSE IF TRIM(fi_brand) = "toyota" THEN ASSIGN fi_pack = "X".
        ELSE ASSIGN fi_pack = "Z".
    END.
    ELSE ASSIGN fi_pack = "Z".  /*use car */

    DISP fi_brand WITH FRAM fr_main.*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_campaign
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_campaign C-Win
ON LEAVE OF fi_campaign IN FRAME fr_main
DO:
  fi_campaign  =  caps(Input  fi_campaign).
  Disp  fi_campaign with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_cha_no
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_cha_no C-Win
ON LEAVE OF fi_cha_no IN FRAME fr_main
DO:
  fi_cha_no  =  caps( Input  fi_cha_no ).
  Disp  fi_cha_no with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_class
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_class C-Win
ON LEAVE OF fi_class IN FRAME fr_main
DO:
  fi_class  =  caps(Input  fi_class).
  Disp  fi_class with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_comdat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_comdat C-Win
ON LEAVE OF fi_comdat IN FRAME fr_main
DO:
  fi_comdat = INPUT fi_comdat.
   n_day = 0. 
   IF YEAR(fi_comdat) <> YEAR(TODAY) OR YEAR(fi_comdat) <> (YEAR(TODAY) - 1) THEN DO:
       MESSAGE "กรุณาปี ค.ศ " VIEW-AS ALERT-BOX.
       APPLY "entry" TO fi_comdat .
       RETURN NO-APPLY.
   END.
   /* Add by A63-0392 */
   ELSE IF DATE(fi_comdat) = DATE(fi_expdat) THEN DO:
       MESSAGE "วันที่เริ่มต้นคุ้มครอง และวันที่หมดอายุเป็นวันเดียวกัน ! " VIEW-AS ALERT-BOX.
       APPLY "entry" TO fi_expdat .
       RETURN NO-APPLY.
       
   END.
   /* end A63-0392 */
   /* comment by : A63-0392...
   ELSE IF DATE(fi_comdat) < TODAY THEN DO:
       n_day = DATE(TODAY) - DATE(fi_comdat) .
       IF n_day > 15 THEN DO:
           MESSAGE "ระบุวันที่เริ่มต้นคุ้มครองย้อนหลังได้ไม่เกิน 15 วัน ! " VIEW-AS ALERT-BOX.
           APPLY "entry" TO fi_comdat .
           RETURN NO-APPLY.
       END.
   END.
    end A63-0392...*/

   IF (INTE(DAY(fi_comdat)) = 29 ) AND (int(MONTH(fi_comdat)) = 2 ) THEN
       ASSIGN fi_expdat = DATE(("01") + "/" +
                               STRING(MONTH(fi_comdat),"99") + "/" +
                               string(year(fi_comdat) + 1 ,"9999")).
   ELSE ASSIGN fi_expdat = DATE(STRING(DAY(fi_comdat),"99") + "/" +
                               STRING(MONTH(fi_comdat),"99") + "/" +
                               string(year(fi_comdat) + 1 ,"9999")).

 
  DISP fi_comdat fi_expdat WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_comdat C-Win
ON VALUE-CHANGED OF fi_comdat IN FRAME fr_main
DO:
  /*  fi_comdat = INPUT fi_comdat.
   
    DISP fi_comdat fi_expdat WITH FRAM fr_main.*/
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_cover1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_cover1 C-Win
ON LEAVE OF fi_cover1 IN FRAME fr_main
DO:
    fi_cover1 = INPUT fi_cover1.
    /*Add kridtiya i.A55-0108 */
    /*IF      fi_comco = "SCB"   THEN fi_benname = "ธนาคารไทยพาณิชย์ จำกัด (มหาชน)".
    ELSE IF fi_comco = "AYCAL" THEN fi_benname = "บริษัท อยุธยา แคปปิตอล ออโต้ลิส จำกัด(มหาชน)".
    ELSE IF fi_comco = "TCR"   THEN fi_benname = "ธนาคาร ไทยเครดิต เพื่อรายย่อย จำกัด (มหาชน)".
    ELSE IF fi_comco = "ASK"   THEN fi_benname = "บริษัท เอเซียเสริมกิจลีสซิ่ง จำกัด (มหาชน)".
    ELSE IF fi_comco = "BGPL"  THEN fi_benname = "บริษัท กรุงเทพแกรนด์แปซิฟิคลีส จำกัด ( มหาชน)".
    ELSE IF fi_comco = "RTN"   THEN fi_benname = "บริษัท ราชธานี ลีสซิ่ง จำกัด (มหาชน)".
    ELSE fi_benname = "".*/
   /* ASSIGN fi_benname   = nv_benname .    /*A56-0024*/
    IF (nv_cartyp = "BIKE(บุคคล)") OR (nv_cartyp = "BIKE(พาณิชย์)")  THEN ASSIGN fi_pack = "Z" .
    ELSE IF fi_cover1 = "1" THEN ASSIGN fi_pack = "G".
    ELSE IF fi_cover1 = "2" THEN ASSIGN fi_pack = "Y".
    ELSE IF fi_cover1 = "3" THEN DO:
        /*IF ra_car = 2 THEN*/
        IF co_caruse = "กระบะ" THEN
            ASSIGN fi_pack = "R" 
            fi_benname  = ""  .
        ELSE ASSIGN fi_pack = "V" 
            fi_benname  = ""  .
    END.
    ELSE IF fi_cover1 = "5" THEN ASSIGN fi_pack = "B".

    /* Begin by Phaiboon W. [A59-0488] Date 07/11/2016 */
    ELSE IF fi_cover1 = "2.1" OR
            fi_cover1 = "2.2" OR
            fi_cover1 = "3.1" OR
            fi_cover1 = "3.2" THEN ASSIGN fi_pack = "C".

    IF fi_cover1 = "1" AND
       ra_cover  = 1   THEN ASSIGN fi_pack = "Z".*/

    /*
    IF ra_cover <> 1 THEN DO:
        IF fi_cover1 = "1"   OR 
           fi_cover1 = "2.1" OR
           fi_cover1 = "2.2" THEN fi_ispstatus = "Y".
        ELSE fi_ispstatus = "N".
    END.
    ELSE fi_ispstatus = "".    
    */
    /* End by Phaiboon W. [A59-0488] Date 07/11/2016 */
    

    /*Add kridtiya i.A55-0108 */
    Disp  fi_cover1 fi_pack /*fi_benname*/ fi_ispstatus with frame  fr_main. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_doc1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_doc1 C-Win
ON LEAVE OF fi_doc1 IN FRAME fr_main
DO:
  fi_doc1  = INPUT fi_doc1.
  DISP fi_doc1 WITH FRAM fr_main. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fr_driv
&Scoped-define SELF-NAME fi_drivername1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_drivername1 C-Win
ON LEAVE OF fi_drivername1 IN FRAME fr_driv
DO:
    fi_drivername1  = INPUT fi_drivername1.
    DISP fi_drivername1 WITH FRAM fr_driv.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_drivername2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_drivername2 C-Win
ON LEAVE OF fi_drivername2 IN FRAME fr_driv
DO:
    fi_drivername2  = INPUT fi_drivername2.
    DISP fi_drivername2 WITH FRAM fr_driv.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fr_main
&Scoped-define SELF-NAME fi_eng_no
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_eng_no C-Win
ON LEAVE OF fi_eng_no IN FRAME fr_main
DO:
  fi_eng_no  =  caps( Input  fi_eng_no ).
  Disp  fi_eng_no with frame  fr_main.
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


&Scoped-define SELF-NAME fi_gap
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_gap C-Win
ON LEAVE OF fi_gap IN FRAME fr_main
DO:
    fi_gap   = INPUT fi_gap.
    ASSIGN 
        fi_premium =  Truncate(fi_gap * 0.4 / 100,0) + (IF (fi_gap * 0.4 / 100) - Truncate(fi_gap * 0.4 / 100,0) > 0 Then 1 Else 0)
                  + fi_gap .
        fi_premium = ( fi_premium * 7 / 100 ) +  fi_premium .
        DISP fi_gap fi_premium   WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_garage
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_garage C-Win
ON LEAVE OF fi_garage IN FRAME fr_main
DO:
  fi_garage  =  caps(Input fi_garage ) .
  Disp  fi_garage with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fr_driv
&Scoped-define SELF-NAME fi_hbdri1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_hbdri1 C-Win
ON LEAVE OF fi_hbdri1 IN FRAME fr_driv
DO:
    fi_hbdri1 = INPUT fi_hbdri1.
    DISP fi_hbdri1 WITH FRAM fr_driv.
    IF YEAR(fi_hbdri1) <= 2012 THEN MESSAGE "กรุณาใส่ ปี พ.ศ....!!!" VIEW-AS ALERT-BOX.
    ELSE DO:
        ASSIGN fi_agedriv1 = (YEAR(TODAY) + 543 ) - YEAR(fi_hbdri1) .
        DISP  fi_hbdri1  fi_agedriv1 WITH FRAM fr_driv.
        APPLY "entry" TO fi_occupdriv1.
        RETURN NO-APPLY.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_hbdri2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_hbdri2 C-Win
ON LEAVE OF fi_hbdri2 IN FRAME fr_driv
DO:
    fi_hbdri2 = INPUT fi_hbdri2.
    DISP fi_hbdri2 WITH FRAM fr_driv.
    IF YEAR(fi_hbdri2) <= YEAR(TODAY) THEN MESSAGE "กรุณาใส่ ปี พ.ศ....!!!" VIEW-AS ALERT-BOX.
    ELSE DO:
        ASSIGN fi_agedriv2 = (YEAR(TODAY) + 543 ) - YEAR(fi_hbdri2) .
        DISP  fi_hbdri2  fi_agedriv2 WITH FRAM fr_driv.
        APPLY "entry" TO fi_occupdriv2.
        RETURN NO-APPLY.
    END.
  DISP fi_hbdri2 WITH FRAM fr_driv.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_idnodriv1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_idnodriv1 C-Win
ON LEAVE OF fi_idnodriv1 IN FRAME fr_driv
DO:
  fi_idnodriv1  = INPUT fi_idnodriv1.
  DISP fi_idnodriv1 WITH FRAM fr_driv.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_idnodriv2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_idnodriv2 C-Win
ON LEAVE OF fi_idnodriv2 IN FRAME fr_driv
DO:
  fi_idnodriv2  = INPUT fi_idnodriv2.
  DISP fi_idnodriv2 WITH FRAM fr_driv.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fr_main
&Scoped-define SELF-NAME fi_ispno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_ispno C-Win
ON LEAVE OF fi_ispno IN FRAME fr_main
DO:
  fi_ispno = caps( INPUT fi_ispno ) .

  /* Begin by Phaiboon W. [A59-0488] Date 01/12/2016 */
    nv_ispstatus = fi_ispno.
    IF INDEX(nv_ispstatus,"ISP") > 0 THEN DO:        
        fi_ispstatus = "Y".        
    END.
    /* comment by Phaiboon W. [A59-04]
    ELSE IF INDEX(nv_ispstatus,"ไม่ตรวจ") > 0 OR
            INDEX(nv_ispstatus,"รถ")      > 0 THEN DO:

        fi_ispstatus = "N".        
    END.   
    ELSE fi_ispstatus = "".          
    */
    ELSE fi_ispstatus = "N".
    /* End by Phaiboon W. [A59-0488] Date 01/12/2016 */

  DISP fi_ispno fi_ispstatus WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_ispno C-Win
ON RETURN OF fi_ispno IN FRAME fr_main
DO:
    APPLY "Entry" TO fi_ispstatus.
    RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_ispstatus
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_ispstatus C-Win
ON LEAVE OF fi_ispstatus IN FRAME fr_main
DO:
  fi_ispstatus = caps( INPUT fi_ispstatus ) .
  DISP fi_ispstatus WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_ispstatus C-Win
ON RETURN OF fi_ispstatus IN FRAME fr_main
DO:
    APPLY "Entry" TO fi_brand.
    RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_licence1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_licence1 C-Win
ON LEAVE OF fi_licence1 IN FRAME fr_main
DO:
    fi_licence1 =  Input  fi_licence1.
    Disp  fi_licence1 with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_licence2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_licence2 C-Win
ON LEAVE OF fi_licence2 IN FRAME fr_main
DO:
    fi_licence2 =  Input  fi_licence2.
    Disp  fi_licence2 with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_model
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_model C-Win
ON LEAVE OF fi_model IN FRAME fr_main
DO:
  fi_model = INPUT fi_model.
  DISP fi_model WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fr_driv
&Scoped-define SELF-NAME fi_occupdriv1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_occupdriv1 C-Win
ON LEAVE OF fi_occupdriv1 IN FRAME fr_driv
DO:
    fi_occupdriv1  = INPUT fi_occupdriv1.
    DISP fi_occupdriv1 WITH FRAM fr_driv.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_occupdriv2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_occupdriv2 C-Win
ON LEAVE OF fi_occupdriv2 IN FRAME fr_driv
DO:
  fi_occupdriv2  = INPUT fi_occupdriv2.
  DISP fi_occupdriv2 WITH FRAM fr_driv.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fr_main
&Scoped-define SELF-NAME fi_other2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_other2 C-Win
ON LEAVE OF fi_other2 IN FRAME fr_main
DO:
    fi_other2 = INPUT fi_other2.
    DISP fi_other2 WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_other2 C-Win
ON RETURN OF fi_other2 IN FRAME fr_main
DO:
    APPLY "Entry" TO fi_other3.
    RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_other3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_other3 C-Win
ON LEAVE OF fi_other3 IN FRAME fr_main
DO:
    fi_other3 = INPUT fi_other3.
    DISP fi_other3 WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_other3 C-Win
ON RETURN OF fi_other3 IN FRAME fr_main
DO:
    APPLY "Entry" TO fi_remark.
    RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_pack
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_pack C-Win
ON LEAVE OF fi_pack IN FRAME fr_main
DO:
  fi_pack  =  caps(Input  fi_pack).
  Disp  fi_pack with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_power
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_power C-Win
ON LEAVE OF fi_power IN FRAME fr_main
DO:
  fi_power  =  Input  fi_power.
  Disp  fi_power with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_precomp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_precomp C-Win
ON LEAVE OF fi_precomp IN FRAME fr_main
DO:
    fi_precomp  = INPUT fi_precomp.
    ASSIGN 
      fi_totlepre =  fi_premium + fi_precomp.
    DISP fi_precomp fi_totlepre WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_premium
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_premium C-Win
ON LEAVE OF fi_premium IN FRAME fr_main
DO:
    fi_premium  = INPUT fi_premium.
    DISP fi_premium WITH FRAM fr_main. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_product
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_product C-Win
ON LEAVE OF fi_product IN FRAME fr_main
DO:
    fi_product = INPUT fi_product.
    /* comment by : A63-0392 ...
    IF ((INPUT fi_product) <> "" ) AND (ra_pa = 1) THEN DO:
        MESSAGE "กรุณาเลือก ขาย PA "   VIEW-AS ALERT-BOX.
        ASSIGN fi_product = "".
        APPLY "entry" TO ra_pa.
        RETURN NO-APPLY.   
    END. */
    DISP ra_pa fi_product WITH FRAM fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_provin
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_provin C-Win
ON LEAVE OF fi_provin IN FRAME fr_main
DO:
  fi_provin  = INPUT fi_provin.
  DISP fi_provin WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_quo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_quo C-Win
ON LEAVE OF fi_quo IN FRAME fr_main
DO:
    fi_quo = CAPS(INPUT fi_quo).
    DISP fi_quo WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_quo C-Win
ON VALUE-CHANGED OF fi_quo IN FRAME fr_main
DO:
    
    fi_quo = INPUT fi_quo.

    /*IF fi_quo <> "" THEN 
        DISABLE fi_notno72 WITH FRAME fr_main.   
    ELSE ENABLE fi_notno72 WITH FRAME fr_main.*/
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_redbook
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_redbook C-Win
ON LEAVE OF fi_redbook IN FRAME fr_main
DO:
  fi_redbook = INPUT fi_redbook.
  DISP fi_redbook WITH FRAM fr_main.
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


&Scoped-define SELF-NAME fi_stk
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_stk C-Win
ON LEAVE OF fi_stk IN FRAME fr_main
DO:
  fi_stk  = INPUT fi_stk.
  DISP fi_stk WITH FRAM fr_main. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_sumfi
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_sumfi C-Win
ON LEAVE OF fi_sumfi IN FRAME fr_main
DO:
    fi_sumfi  = INPUT fi_sumfi.
  DISP fi_sumfi  WITH FRAM fr_main. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_sumsi
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_sumsi C-Win
ON LEAVE OF fi_sumsi IN FRAME fr_main
DO:
    fi_sumsi  = INPUT fi_sumsi.
   /* add by A62-0219 */
    IF fi_sumsi <> 0  AND fi_quo = "" AND fi_campaign <> "" THEN DO:
        nv_insi = ((nv_sumsi * 80) / 100 ).
        IF fi_sumsi < nv_insi   THEN DO:
            MESSAGE "ทุนประกันต้องไม่ต่ำกว่า " nv_insi VIEW-AS ALERT-BOX.
            APPLY "entry" TO fi_sumsi.
            RETURN NO-APPLY.
        END.
    END.
    IF fi_cover1 = "1" THEN  ASSIGN fi_sumfi = fi_sumsi .
    /* end A62-0219*/
  DISP fi_sumsi fi_sumfi  WITH FRAM fr_main. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_ta
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_ta C-Win
ON LEAVE OF fi_ta IN FRAME fr_main
DO:
    fi_ta  = INPUT fi_ta.
    DISP fi_ta WITH FRAM fr_main. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_td
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_td C-Win
ON LEAVE OF fi_td IN FRAME fr_main
DO:
    fi_td  = INPUT fi_td.
    DISP fi_td WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_totlepre
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_totlepre C-Win
ON LEAVE OF fi_totlepre IN FRAME fr_main
DO:
    fi_totlepre  = INPUT fi_totlepre.
    DISP fi_totlepre WITH FRAM fr_main. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_tp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_tp C-Win
ON LEAVE OF fi_tp IN FRAME fr_main
DO:
    fi_tp   = INPUT fi_tp.
    DISP fi_tp   WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_year
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_year C-Win
ON LEAVE OF fi_year IN FRAME fr_main
DO:
    fi_year  =  Input fi_year.
    Disp fi_year with frame  fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ra_comp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_comp C-Win
ON VALUE-CHANGED OF ra_comp IN FRAME fr_main
DO:
    ra_comp = INPUT ra_comp.
    DISP ra_comp WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ra_complete
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_complete C-Win
ON VALUE-CHANGED OF ra_complete IN FRAME fr_main
DO:
  ra_complete = INPUT ra_complete.
  DISP ra_complete WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ra_cover
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_cover C-Win
ON VALUE-CHANGED OF ra_cover IN FRAME fr_main
DO:
   /* ra_cover = INPUT ra_cover .
    IF ra_cover = 1 THEN                  /*A56-0024*/  
        ASSIGN 
        /*fi_pack = "G"*/
        nv_producer = n_producernew  
        nv_agent    = n_agent    .
    ELSE IF ra_cover = 3 THEN            /*Bike A57-0063*/
        ASSIGN 
        /*fi_pack = "Z"*/
        nv_producer = n_producerbike
        nv_agent    = n_agent    .
    ELSE 
        ASSIGN 
            nv_producer = n_produceruse 
            nv_agent    = n_agent    . */  /*A56-0024*/
    /*comment BY Kridtiya i. A56-0024 .
    IF fi_comco = "SCB" THEN DO:
        IF ra_cover = 1 THEN
            ASSIGN 
            fi_producer = "B3M0009"
            fi_agent  = "B3M0009".
        ELSE ASSIGN 
            fi_producer = "B3M0010"
            fi_agent  = "B3M0009".
    END.
    ELSE IF fi_comco = "AYCAL" THEN DO:
        IF ra_cover = 1 THEN
            ASSIGN 
            fi_producer = "A0M0061"
            fi_agent  = "B300303".
        ELSE ASSIGN 
            fi_producer = "A0M1011"
            fi_agent  = "B300303".
    END.
    ELSE IF fi_comco = "TCR" THEN DO:
        IF ra_cover = 1 THEN
            ASSIGN 
            fi_producer = "B3M0013"
            fi_agent  = "B3M0013".
        ELSE ASSIGN 
            fi_producer = "B3M0014"
            fi_agent  = "B3M0013".
    END.
    ELSE IF fi_comco = "ASK" THEN DO:
        IF ra_cover = 1 THEN
            ASSIGN 
            fi_producer = "A0M1004"
            fi_agent  = "B300303".
        ELSE ASSIGN 
            fi_producer = "A0M1004"
            fi_agent  = "B300303".
    END.
    ELSE IF fi_comco = "BGPL" THEN DO:
        IF ra_cover = 1 THEN
            ASSIGN 
            fi_producer = "A000774"
            fi_agent  = "B300303".
        ELSE ASSIGN 
            fi_producer = "A000774"
            fi_agent  = "B300303".
    END.
    ELSE IF fi_comco = "RTN" THEN DO:
        IF ra_cover = 1 THEN
            ASSIGN 
            fi_producer = "A0M0069"
            fi_agent  = "B300303".
        ELSE ASSIGN 
            fi_producer = "A0M1002"
            fi_agent  = "B300303".
    END.
    END...comment BY Kridtiya i. A56-0024 ...*/
    /*IF (nv_cartyp = "BIKE(บุคคล)") OR (nv_cartyp = "BIKE(พาณิชย์)")  THEN ASSIGN fi_pack = "Z" .*/
    DISP ra_cover /*fi_comco fi_producer fi_agent*/ fi_pack  WITH FRAM fr_main. 
    /*
    APPLY "ENTRY" TO fi_cover1.
    RETURN NO-APPLY.
    */

    /* Begin by Phaiboon W. [A59-0488] Date 07/11/2016 */
    /*IF (nv_cartyp = "BIKE(บุคคล)") OR (nv_cartyp = "BIKE(พาณิชย์)")  THEN ASSIGN fi_pack = "Z" .
    ELSE IF fi_cover1 = "1" THEN ASSIGN fi_pack = "G".
    ELSE IF fi_cover1 = "2" THEN ASSIGN fi_pack = "Y".
    ELSE IF fi_cover1 = "3" THEN DO:        
        IF co_caruse = "กระบะ" THEN
            ASSIGN fi_pack = "R" 
            fi_benname  = ""  .
        ELSE ASSIGN fi_pack = "V" 
            fi_benname  = ""  .
    END.
    ELSE IF fi_cover1 = "5" THEN ASSIGN fi_pack = "B".
    
    ELSE IF fi_cover1 = "2.1" OR
            fi_cover1 = "2.2" OR
            fi_cover1 = "3.1" OR
            fi_cover1 = "3.2" THEN ASSIGN fi_pack = "C".

    IF fi_cover1 = "1" AND
    ra_cover  = 1   THEN ASSIGN fi_pack = "Z".

    /*
    IF ra_cover <> 1 THEN DO:
        IF fi_cover1 = "1"   OR 
           fi_cover1 = "2.1" OR
           fi_cover1 = "2.2" THEN fi_ispstatus = "Y".
        ELSE fi_ispstatus = "N".
    END.
    ELSE fi_ispstatus = "".
    */
       
    Disp  fi_cover1 fi_pack fi_benname fi_ispstatus  with frame  fr_main. */

    APPLY "ENTRY" TO fi_cover1.
    RETURN NO-APPLY.
    /* End by Phaiboon W. [A59-0488] Date 07/11/2016 */
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ra_driv
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_driv C-Win
ON VALUE-CHANGED OF ra_driv IN FRAME fr_main
DO:
  ra_driv = INPUT ra_driv .
    DISP ra_driv WITH FRAM fr_main.
    IF ra_driv = 1  THEN DO:
       /* ASSIGN 
            FRAME fr_driv  fi_text1   fi_text1  = ""
            FRAME fr_driv  fi_text2   fi_text2  = ""
            FRAME fr_driv  fi_text3   fi_text3  = ""
            FRAME fr_driv  fi_text4   fi_text4  = ""
            FRAME fr_driv  fi_text5   fi_text5  = ""
            FRAME fr_driv  fi_text6   fi_text6  = ""
            FRAME fr_driv  fi_text7   fi_text7  = ""
            FRAME fr_driv  fi_text8   fi_text8  = ""
            FRAME fr_driv  fi_text9   fi_text9  = ""
            FRAME fr_driv  fi_text10  fi_text10 = ""   .
        
        DISP fi_text1 
             fi_text2 
             fi_text3 
             fi_text4 
             fi_text5 
             fi_text6 
             fi_text7 
             fi_text8 
             fi_text9 
             fi_text10 WITH FRAME fr_driv.*/
        DISABLE ALL WITH FRAME fr_driv.
        DISABLE  
        fi_drivername1 ra_sex1 fi_hbdri1 fi_occupdriv1  fi_idnodriv1
        fi_drivername2 ra_sex2 fi_hbdri2 fi_occupdriv2  fi_idnodriv2 WITH FRAM fr_driv. 
    END.
    ELSE DO:
        /*ASSIGN                  
            FRAME fr_driv  fi_text1    fi_text1  = "ชื่อผู้ขับ1"
            FRAME fr_driv  fi_text2    fi_text2  = "ชื่อผู้ขับ2"
            FRAME fr_driv  fi_text3    fi_text3  = "HBD"
            FRAME fr_driv  fi_text4    fi_text4  = "HBD"
            FRAME fr_driv  fi_text5    fi_text5  = "Age"
            FRAME fr_driv  fi_text6    fi_text6  = "Age"
            FRAME fr_driv  fi_text7    fi_text7  = "อาชีพ"
            FRAME fr_driv  fi_text8    fi_text8  = "อาชีพ"
            FRAME fr_driv  fi_text9    fi_text9  = "Idno"
            FRAME fr_driv  fi_text10   fi_text10 = "Idno".
        ENABLE ALL WITH FRAME fr_driv.
        DISP fi_text1 
             fi_text2 
             fi_text3 
             fi_text4 
             fi_text5 
             fi_text6 
             fi_text7 
             fi_text8 
             fi_text9 
             fi_text10 WITH FRAME fr_driv.*/
      ENABLE  
          fi_drivername1 ra_sex1 fi_hbdri1 fi_occupdriv1  fi_idnodriv1
          fi_drivername2 ra_sex2 fi_hbdri2 fi_occupdriv2  fi_idnodriv2 WITH FRAM fr_driv.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ra_pa
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_pa C-Win
ON VALUE-CHANGED OF ra_pa IN FRAME fr_main
DO:
  ra_pa = INPUT ra_pa.

 /* comment by : a63-0392...
 IF ra_pa = 1 THEN
      ASSIGN fi_product = "" .
  ELSE ASSIGN fi_product = "PA1" . */

  DISP ra_pa fi_product WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ra_pree
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_pree C-Win
ON VALUE-CHANGED OF ra_pree IN FRAME fr_main
DO:
  ra_pree = INPUT ra_pree.
  DISP ra_pree WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fr_driv
&Scoped-define SELF-NAME ra_sex1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_sex1 C-Win
ON VALUE-CHANGED OF ra_sex1 IN FRAME fr_driv
DO:
    ra_sex1 = INPUT ra_sex1.
    DISP ra_sex1 WITH FRAM fr_driv.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ra_sex2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_sex2 C-Win
ON VALUE-CHANGED OF ra_sex2 IN FRAME fr_driv
DO:
   ra_sex2 = INPUT ra_sex2.
    DISP ra_sex2 WITH FRAM fr_driv.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fr_main
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
    ASSIGN 
        gv_prgid = "wgwqupo22" 
        gv_prog  = "UPDATE  DATA BY TELEPHONE ...".
    RUN  WUT\WUTHEAD ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).
    /*********************************************************************/ 
   Find  tlt  Where  Recid(tlt)  =  nv_recidtlt NO-LOCK NO-ERROR NO-WAIT .
    If  avail  tlt  Then do:                        
        ASSIGN                        
            nv_check70    = "no"
            nv_check72    = "no"
            n_brsty       =  tlt.colorcod  
            fi_notino     =  tlt.nor_noti_tlt
            fi_notdat     =  tlt.trndat       
            fi_nottim     =  tlt.trntime  
            nv_comco      =  tlt.lotno    
            fi_campaign   =  tlt.subins
            ra_cover      =  IF      tlt.safe2 = "ป้ายแดง" THEN 1   
                             ELSE IF tlt.safe2 = "bike"    THEN 3  
                                                           ELSE 2 
            fi_cover1     =  tlt.safe3 
            /*ra_pa         =  IF tlt.stat  = "" THEN 1 ELSE 2*/ /*A63-0392*/
            ra_pa         =  IF tlt.stat  = "" THEN 1 ELSE IF SUBSTR(tlt.stat,1,2) = "PA" OR SUBSTR(tlt.stat,1,2) = "PB" THEN 2 ELSE 1  /*A63-0392*/
            fi_product    =  tlt.stat
            ra_pree       =  IF      trim(tlt.filler1) = "แถม"    THEN 1 ELSE 2
            ra_comp       =  IF      trim(tlt.filler2) = "แถม"    THEN 1 
                             ELSE IF trim(tlt.filler2) = "ไม่แถม" THEN 2 
                             ELSE 3

            nv_producer   =  tlt.comp_sub     
            nv_agent      =  tlt.recac 
            nv_notno70    =  tlt.policy        
            nv_notno72    =  tlt.comp_pol 
            fi_pol70      =  tlt.policy
            fi_pol72      =  tlt.comp_pol
            nv_preinsur   =  substr(tlt.ins_name,INDEX(tlt.ins_name," ") + 1,R-INDEX(tlt.ins_name," ") - INDEX(tlt.ins_name," "))                                     
            nv_preinsur2  =  substr(tlt.ins_name,r-INDEX(tlt.ins_name," ") + 1)   
            nv_insadd6tel  = TRIM(SUBSTR(tlt.comp_noti_ins,1,20)) 
            nv_chknotes    = SUBSTR(tlt.comp_noti_ins,21,1) 

            fi_comdat      = tlt.nor_effdat
            fi_expdat      = tlt.expodat   
            fi_ispno       = TRIM(SUBSTR(tlt.dri_no2,1,50)) 
            fi_ispstatus   = TRIM(SUBSTR(tlt.dri_no2,51,1))       

            fi_brand       = IF index(tlt.brand,"RB:") <> 0 THEN SUBSTR(tlt.brand,1,INDEX(tlt.brand,"RB:") - 2) ELSE tlt.brand
            fi_redbook     = IF index(tlt.brand,"RB:") <> 0 THEN SUBSTR(tlt.brand,R-INDEX(tlt.brand,"RB:") + 3) ELSE ""
            fi_model       = tlt.model      
            fi_year        = tlt.lince2           
            fi_power       = tlt.cc_weight     
            
            fi_licence1    = IF tlt.lince1 = "" THEN ""
                             ELSE IF INDEX(tlt.lince1," ") <> 0 THEN trim(substr(tlt.lince1,1,INDEX(tlt.lince1," ") - 1 ))
                             ELSE  trim(substr(tlt.lince1,1,3))
            fi_licence2    = IF  (R-INDEX(tlt.lince1," ") <> 0 ) AND (INDEX(tlt.lince1," ") <> 0) THEN 
                             trim(substr(tlt.lince1,INDEX(tlt.lince1," ") + 1,R-INDEX(tlt.lince1," ") - INDEX(tlt.lince1," ") - 1)) 
                             ELSE  trim(substr(tlt.lince1,4,5))
            fi_provin      = IF R-INDEX(tlt.lince1," ") <> 0 THEN 
                             trim(substr(tlt.lince1,r-INDEX(tlt.lince1," ") + 1)) 
                             ELSE ""
            fi_cha_no      = tlt.cha_no  
            fi_eng_no      = tlt.eng_no 
            fi_pack        = substr(tlt.lince3,1,1)        
            fi_class       = substr(tlt.lince3,2,3)        
            fi_garage      = tlt.EXP 
            fi_sumsi       = tlt.nor_coamt   
            fi_sumfi       = tlt.sentcnt
            fi_gap         = DECI(tlt.dri_name2) 
            fi_premium     = tlt.nor_grprm       
            fi_precomp     = tlt.comp_coamt      
            fi_totlepre    = tlt.comp_grprm      
            fi_stk         = IF index(tlt.comp_sck,"DOC:") <> 0 THEN SUBSTR(tlt.comp_sck,5,INDEX(tlt.comp_sck,"DOC:") - 5) ELSE tlt.comp_sck
            fi_doc1        = IF index(tlt.comp_sck,"DOC:") <> 0 THEN SUBSTR(tlt.comp_sck,R-INDEX(tlt.comp_sck,"DOC:") + 4 ) ELSE ""
            n_remark1      = TRIM(SUBSTR(tlt.OLD_cha,INDEX(tlt.old_cha,":") + 1, 100 - (INDEX(tlt.old_cha,":") + 1)))            
            n_remark2      = TRIM(SUBSTR(tlt.OLD_cha,101,100))
            fi_other2      = DEC(SUBSTR(tlt.OLD_cha,251,10))   
            fi_other3      = TRIM(SUBSTR(tlt.OLD_cha,261,60))
            fi_quo         = TRIM(SUBSTR(tlt.OLD_cha,321,20))
            
            ra_complete   =  IF trim(tlt.OLD_eng) =  "complete" THEN 1 ELSE 2
            fi_userid     =  tlt.usrid
            n_addr11      =  tlt.ins_addr1  
            fi_baseod     =  IF (tlt.rec_addr5 = "") OR (DECI(tlt.rec_addr5) = 0 ) THEN 0 ELSE deci(tlt.rec_addr5)  /*A57-0063*/  
            vAcProc_fil3   = " " 
            vAcProc_fil3   = vAcProc_fil3  + " " .  
            
        ASSIGN   
            vAcProc_fil4   = ""   
            vAcProc_fil5   = ""   
            vAcProc_fil6   = ""   
            vAcProc_fil4   = vAcProc_fil4 
                             + "เก๋ง"            + ","  
                             + "กระบะ"           + "," 
                             + "โดยสาร(บุคคล)"   + ","  
                             + "โดยสาร(พาณิชย์)" + ","
                             + "BIKE(บุคคล)"     + ","
                             + "BIKE(พาณิชย์)" 
        
            vAcProc_fil6   = vAcProc_fil6
                           + "ซ่อมอู่"    + ","
                           + "ซ่อมห้าง"

            co_caruse:LIST-ITEMS  = vAcproc_fil4 
            co_garage:LIST-ITEMS  = vAcproc_fil6 
            co_caruse   = tlt.safe1              
            nv_cartyp   = tlt.safe1              
            co_garage   = IF tlt.EXP = "G" THEN "ซ่อมห้าง" ELSE "ซ่อมอู่"  
            fi_remark   = tlt.gentim  .  /* ผลตรวจสภาพ*/
            
        /* เพิ่มความคุ้มครอง */
       nv_char = "" .
       IF tlt.rec_addr2 <> ""  THEN DO:
            ASSIGN 
                fi_td       = INT(TRIM(SUBSTR(tlt.rec_addr2,R-INDEX(tlt.rec_addr2,"TPD:") + 4 )))
                nv_char     = SUBSTR(tlt.rec_addr2,1,INDEX(tlt.rec_addr2,"TPD:") - 2 )
                fi_ta       = INT(TRIM(SUBSTR(nv_char,R-INDEX(nv_char,"TPA:") + 4 )))
                fi_tp       = INT(trim(SUBSTR(nv_char,5,INDEX(nv_char,"TPA:") - 5 ))) . 
        END.
        ELSE DO:
            ASSIGN fi_td       = 0
                   fi_ta       = 0
                   fi_tp       = 0 .
                  
        END.
        IF tlt.rec_addr3 <> ""  THEN DO:
            ASSIGN 
                fi_43       = INT(TRIM(SUBSTR(tlt.rec_addr3,R-INDEX(tlt.rec_addr3,"43:") + 3 )))
                nv_char     = SUBSTR(tlt.rec_addr3,1,INDEX(tlt.rec_addr3,"43:") - 2 ) 
                fi_42       = INT(trim(SUBSTR(nv_char,R-INDEX(nv_char,"42:") + 3 ))) 
                fi_41       = INT(TRIM(SUBSTR(nv_char,4,INDEX(nv_char,"42:") - 4))) .
        END.
        ELSE DO:
            ASSIGN fi_43       = 0
                   fi_42       = 0
                   fi_41       = 0 .
        END.
        
        IF  tlt.dri_name1 = "" THEN DO:  /*driver name 1.*/
            ASSIGN 
                ra_driv = 1.
                DISABLE ALL WITH FRAME fr_driv.
        END.
        ELSE DO:
            IF tlt.dri_name1 = "" THEN  /*driver 1*/
                ASSIGN fi_drivername1 = ""
                fi_idnodriv1  = ""
                fi_occupdriv1 = ""
                fi_hbdri1 = ?.
            ELSE ASSIGN  
                ra_driv        = 2
                fi_drivername1 = IF substr(tlt.dri_name1,1,INDEX(tlt.dri_name1,"sex:") - 1 ) = "" THEN ""
                                 ELSE SUBSTR(tlt.dri_name1,1,INDEX(tlt.dri_name1,"sex:") - 1 )
                fi_idnodriv1   = tlt.dri_no1  
                ra_sex1        = IF trim(substr(tlt.dri_name1,INDEX(tlt.dri_name1,"sex:") + 4,1)) =  "2" THEN 2
                                 ELSE 1 
                fi_hbdri1      = IF substr(tlt.dri_name1,1,INDEX(tlt.dri_name1,"sex:") - 1 ) = "" THEN ?
                ELSE date(SUBSTR(tlt.dri_name1,INDEX(tlt.dri_name1,"hbd:") + 4 ,10))
                fi_agedriv1    = IF substr(tlt.dri_name1,1,INDEX(tlt.dri_name1,"sex:") - 1 ) = "" THEN 0
                ELSE (YEAR(TODAY) + 543) - Year(date(SUBSTR(tlt.dri_name1,INDEX(tlt.dri_name1,"hbd:") + 4 ,10)))  
                fi_occupdriv1  = IF substr(tlt.dri_name1,1,INDEX(tlt.dri_name1,"sex:") - 1 ) = "" THEN ""
                                 ELSE substr(tlt.dri_name1,INDEX(tlt.dri_name1,"occ:") + 4 ) .
            IF tlt.enttim = "" THEN  /*driver 2*/
                ASSIGN fi_drivername2 = ""
                fi_idnodriv2          = ""
                fi_occupdriv2         = ""
                fi_hbdri2             = ?.
            ELSE ASSIGN 
                fi_drivername2 = IF substr(tlt.enttim,1,INDEX(tlt.enttim,"sex:") - 1 ) = "" THEN ""
                                 ELSE SUBSTR(tlt.enttim,1,INDEX(tlt.enttim,"sex:") - 1 )
                fi_idnodriv2   = tlt.expotim     
                ra_sex2        = IF trim(substr(tlt.enttim,INDEX(tlt.enttim,"sex:") + 4,1)) =  "2" THEN 2
                                 ELSE 1 
                fi_hbdri2      = IF substr(tlt.enttim,1,INDEX(tlt.enttim,"sex:") - 1 ) = "" THEN ?
                                 ELSE date(SUBSTR(tlt.enttim,INDEX(tlt.enttim,"hbd:") + 4 ,10))
                fi_agedriv2    = IF substr(tlt.enttim,1,INDEX(tlt.enttim,"sex:") - 1 ) = "" THEN 0
                                 ELSE (YEAR(TODAY) + 543) - Year(date(SUBSTR(tlt.enttim,INDEX(tlt.enttim,"hbd:") + 4 ,10)))  
                fi_occupdriv2  = IF substr(tlt.enttim,1,INDEX(tlt.enttim,"sex:") - 1 ) = "" THEN ""
                                 ELSE substr(tlt.enttim,INDEX(tlt.enttim,"occ:") + 4 )  
                fi_idnodriv2  =  tlt.expotim    . 
           
            ENABLE ALL WITH FRAME fr_driv.
           
        END. 
        
    END. 
   
    RUN  proc_dispable.
    Disp fi_notino      fi_notdat     fi_nottim      fi_campaign    ra_cover        fi_cover1       
         ra_pa          fi_product    ra_pree        ra_comp        fi_brand        fi_model        
         fi_eng_no      fi_cha_no     fi_power       fi_year        fi_licence1     fi_licence2     
         fi_provin      fi_pack       fi_class       fi_sumsi       fi_premium      fi_ispno 
         fi_precomp     fi_totlepre   fi_stk         fi_comdat      fi_expdat       fi_gap                 
         fi_other2      fi_other3     fi_garage      ra_complete    fi_ispstatus    fi_quo
         fi_userid      ra_driv       co_caruse      fi_baseod      co_garage       fi_tp 
         fi_ta          fi_td         fi_41          fi_42          fi_43           fi_doc1 
         fi_remark      bu_cam        fi_pol70       fi_pol72       fi_sumfi        fi_redbook  With FRAME fr_main.
   
    DISP  
        fi_drivername1 ra_sex1 fi_hbdri1 fi_occupdriv1  fi_idnodriv1
        fi_drivername2 ra_sex2 fi_hbdri2 fi_occupdriv2  fi_idnodriv2 WITH FRAM fr_driv.

    SESSION:DATA-ENTRY-RETURN = YES.
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
  DISPLAY fi_comdat fi_expdat fi_ispno fi_brand fi_model fi_year fi_power 
          fi_licence1 fi_licence2 fi_provin fi_cha_no fi_eng_no fi_pack fi_class 
          fi_garage fi_sumsi fi_gap fi_premium fi_precomp fi_totlepre fi_baseod 
          fi_stk fi_userid ra_driv fi_notino fi_notdat fi_nottim fi_other2 
          fi_other3 fi_ispstatus co_caruse ra_cover fi_cover1 ra_pa fi_product 
          ra_pree ra_comp fi_quo co_garage fi_campaign fi_tp fi_ta fi_td fi_41 
          fi_42 fi_43 fi_doc1 fi_remark ra_complete fi_pol70 fi_pol72 fi_sumfi 
          fi_redbook 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE bu_not1 bu_notes fi_comdat fi_expdat fi_ispno fi_brand fi_model 
         fi_year fi_power fi_licence1 fi_licence2 fi_provin fi_cha_no fi_eng_no 
         fi_pack fi_class fi_garage fi_sumsi fi_gap fi_premium fi_precomp 
         fi_totlepre fi_baseod fi_stk ra_driv bu_brand fi_other2 fi_other3 
         fi_ispstatus co_caruse fi_cover1 bu_cover ra_pa fi_product bu_product 
         fi_quo bu_quo-2 co_garage fi_campaign bu_cam fi_tp fi_ta fi_td fi_41 
         fi_42 fi_43 fi_doc1 fi_remark ra_complete bu_save bu_exit fi_sumfi 
         fi_redbook RECT-488 RECT-490 RECT-494 RECT-496 RECT-498 RECT-495 
         RECT-499 RECT-500 RECT-501 
      WITH FRAME fr_main IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  DISPLAY ra_sex1 fi_drivername1 fi_hbdri1 fi_agedriv1 fi_occupdriv1 
          fi_idnodriv1 fi_agedriv2 fi_drivername2 ra_sex2 fi_hbdri2 
          fi_occupdriv2 fi_idnodriv2 
      WITH FRAME fr_driv IN WINDOW C-Win.
  ENABLE ra_sex1 fi_drivername1 fi_hbdri1 fi_agedriv1 fi_occupdriv1 
         fi_idnodriv1 fi_agedriv2 fi_drivername2 ra_sex2 fi_hbdri2 
         fi_occupdriv2 fi_idnodriv2 
      WITH FRAME fr_driv IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_driv}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PD_BranchNotes C-Win 
PROCEDURE PD_BranchNotes :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR chDBranch   AS COM-HANDLE.
DEF VAR chDView     AS COM-HANDLE.
DEF VAR chDocBranch AS COM-HANDLE.
DEF VAR NotesBranch AS CHAR.
DEF VAR NotesView   AS CHAR.
DEF VAR NotesKey    AS CHAR.

IF nv_branch  <> ""  THEN DO:
    FIND FIRST sicsyac.xmm023 USE-INDEX xmm02301 
         WHERE sicsyac.xmm023.branch = TRIM(nv_branch) NO-LOCK NO-ERROR.
    IF AVAIL sicsyac.xmm023 THEN DO:
        nv_branch = sicsyac.xmm023.bdes.
        
        IF      nv_branch = "M1" THEN nv_branch = "Business Unit 1".
    
        ELSE IF nv_branch = "M2" OR
                nv_branch = "M5" THEN nv_branch = "Business Unit 2".
    
        ELSE IF nv_branch = "M3" THEN nv_branch = "Business Unit 3".
        ELSE IF sicsyac.xmm023.branch = "T" THEN nv_branch = "เทพารักษ์".
        /* comment by A62-0219 */
        /*ELSE DO:
            ASSIGN
                NotesBranch = "safety\is\branch.nsf"
                NotesView   = "By Code"
                NotesKey    = sicsyac.xmm023.branch
                chDBranch   = chSession:GetDatabase(NotesServer,NotesBranch).
    
            IF NotesKey >= "91" AND 
               NotesKey <= "98" THEN NotesKey = "91-98".
    
            MESSAGE NotesKey VIEW-AS ALERT-BOX.
    
            IF chDBranch:isOpen = NO THEN
                nv_msgbox = "Can not Connect Branch Lotus Notes !".
            ELSE DO:
                chDView     = chDBranch:GetView(NotesView).
                chDocBranch = chDView:GetDocumentByKey(NotesKey).
    
                IF VALID-HANDLE(chDocBranch) = YES THEN 
                    nv_branch = chDocBranch:GetFirstItem("nameThai"):TEXT.                
                ELSE nv_msgbox = "Not Found Branch Information".
            END.       
        END.*/
    END.
    ELSE DO:
        nv_branch = "" .
    END.
END.
/* create by A62-0219 */
IF nv_branch = ""  THEN DO:
    FIND FIRST sicsyac.xmm023 USE-INDEX xmm02301 
              WHERE sicsyac.xmm023.branch = TRIM(n_brsty) NO-LOCK NO-ERROR.
         IF AVAIL sicsyac.xmm023 THEN 
             nv_branch = sicsyac.xmm023.bdes.

         IF      nv_branch = "M1" THEN nv_branch = "Business Unit 1".
         ELSE IF nv_branch = "M2" OR
                 nv_branch = "M5" THEN nv_branch = "Business Unit 2".
         ELSE IF nv_branch = "M3" THEN nv_branch = "Business Unit 3".
         ELSE IF sicsyac.xmm023.branch = "T" THEN nv_branch = "เทพารักษ์".
    
END.
/* end A62-0219*/
IF nv_msgbox <> "" THEN MESSAGE nv_msgbox VIEW-AS ALERT-BOX ERROR.
nv_msgbox = "".

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_dispable C-Win 
PROCEDURE proc_dispable :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
Find  tlt  Where   Recid(tlt)  =  nv_recidtlt  AND 
    tlt.releas        = "yes"    NO-LOCK NO-ERROR NO-WAIT .
If  avail  tlt  THEN DO: 
    DISABLE  bu_cover    bu_product      bu_cam          bu_save
         fi_notino       fi_notdat       fi_nottim       fi_campaign     ra_cover        
         fi_cover1       fi_product      fi_gap          fi_ispno   
         ra_pree         ra_comp         fi_brand        fi_model        fi_eng_no   
         fi_cha_no       fi_power        fi_year         fi_licence1     fi_licence2     
         fi_provin       fi_pack         fi_class        fi_sumsi        fi_premium      
         fi_precomp      fi_totlepre     fi_stk          fi_comdat       fi_expdat               
         fi_remark       fi_garage       ra_complete     fi_userid  WITH FRAM fr_main.
END.
/* A62-0345*/
Find  tlt  Where   Recid(tlt)  =  nv_recidtlt  AND
      INDEX(tlt.releas,"CA") <> 0   NO-LOCK NO-ERROR NO-WAIT .
If  avail  tlt  Then DO:
    DISABLE  bu_cover    bu_product      bu_cam          bu_save
         fi_notino       fi_notdat       fi_nottim       fi_campaign     ra_cover        
         fi_cover1       fi_product      fi_gap          fi_ispno   
         ra_pree         ra_comp         fi_brand        fi_model        fi_eng_no   
         fi_cha_no       fi_power        fi_year         fi_licence1     fi_licence2     
         fi_provin       fi_pack         fi_class        fi_sumsi        fi_premium      
         fi_precomp      fi_totlepre     fi_stk          fi_comdat       fi_expdat               
         fi_remark       fi_garage       ra_complete     fi_userid  WITH FRAM fr_main.
END.
/* end a62-0345*/


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_getisp C-Win 
PROCEDURE proc_getisp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR n_list      AS INT init 0.
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

      /*chitem       = chDocument:Getfirstitem("agentCode").      /*agentCode*/
      IF chitem <> 0 THEN n_agent = chitem:TEXT. 
      ELSE n_agent = "".
      IF TRIM(n_agent) <> "" THEN ASSIGN nv_surdata = nv_surdata + " โค้ดตัวแทน: " + n_agent.*/

     

END.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

