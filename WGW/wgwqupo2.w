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
program id       :  wuwqukk2.w 
program name     :  Update data KK to create  new policy  Add in table  tlt  
                    Quey & Update data before Gen.
Create  by       :  Kridtiya i. A54-0351  On   14/11/2011
Database Connect :  gw_stat ld brstat , gw_safe ld sic_bran ,sic_test ld sicuw sicsyac :not connect stat
modify by        :  Kridtiya i. A55-0108 เพิ่มการให้ค่าแพคเกจตามประเภทประกัน
/*modify by      :  Kridtiya i. A55-0125 date. 02/04/2012 เพิ่มการให้ค่าที่อยู่อาคาร */
Modify By        :  Phaiboon W. [A59-0488] Date 11/10/2016
                    เพิ่ม Format field ความคุ้มครอง , เพิ่มช่อง Remark , เพิ่ม ช่องดึงข้อมูล Quotation
Modify by        :  Phaiboon W. [A59-0625] Date 22/12/2016 
                    เพิ่มปุ่ม Create Record in LotusNotes Database กล่องตรวจสภาพ 
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
DEF VAR nv_benname      As   Char    Format    "x(10)".  /*A56-0024*/
DEF VAR n_producernew   As   Char    Format    "x(10)".  /*A56-0024*/
DEF VAR n_produceruse   As   Char    Format    "x(10)".  /*A56-0024*/
DEF VAR n_producerbike  As   Char    Format    "x(10)".  /*A56-0024*/
DEF VAR n_agent         As   Char    Format    "x(10)".  /*A56-0024*/

/* Begin by Phaiboon W. [A59-0488] Date 11/10/2016 */
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
/* End by Phaiboon W. [A59-0488] Date 11/10/2016 */

/* Begin by Phaiboon W. [A59-0625] Date 22/12/2016 */
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
/* End by Phaiboon W. [A59-0625] Date 22/12/2016 */

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS bu_notes fi_ins_off fi_comco buselecom ~
fi_cmrcode fi_cmrcode2 fi_campaign co_caruse ra_cover fi_cover1 bu_cover ~
ra_pa fi_product bu_product ra_pree ra_comp fi_producer fi_agent fi_deler ~
fi_cmrsty fi_notno70 fi_notno72 bu_create fi_institle fi_preinsur ~
fi_preinsur2 fi_idno fi_birthday fi_age fi_idnoexpdat fi_occup ~
fi_namedrirect fi_insadd1no fi_insadd1mu co_addr fi_insadd1build ~
fi_insadd1soy fi_insadd1road fi_insadd2tam fi_insadd3amp fi_insadd4cunt ~
fi_insadd5post fi_insadd6tel fi_comdat fi_expdat fi_ispno fi_brand fi_model ~
fi_year fi_power fi_licence1 fi_licence2 fi_provin fi_cha_no fi_eng_no ~
fi_pack fi_class fi_garage fi_sumsi fi_gap fi_premium fi_precomp ~
fi_totlepre fi_baseod fi_stk fi_refer fi_recipname fi_vatcode fi_user ~
fi_benname co_benname fi_remark1 ra_complete bu_save bu_exit ra_driv ~
bu_brand fi_remark2 fi_quo bu_quo fi_other2 co_garage fi_other3 ~
fi_ispstatus RECT-488 RECT-489 RECT-490 RECT-491 RECT-492 RECT-493 
&Scoped-Define DISPLAYED-OBJECTS fi_ins_off fi_comco fi_cmrcode fi_cmrcode2 ~
fi_campaign co_caruse ra_cover fi_cover1 ra_pa fi_product ra_pree ra_comp ~
fi_producer fi_agent fi_deler fi_cmrsty fi_notno70 fi_notno72 fi_institle ~
fi_preinsur fi_preinsur2 fi_idno fi_birthday fi_age fi_idnoexpdat fi_occup ~
fi_namedrirect fi_insadd1no fi_insadd1mu co_addr fi_insadd1build ~
fi_insadd1soy fi_insadd1road fi_insadd2tam fi_insadd3amp fi_insadd4cunt ~
fi_insadd5post fi_insadd6tel fi_comdat fi_expdat fi_ispno fi_brand fi_model ~
fi_year fi_power fi_licence1 fi_licence2 fi_provin fi_cha_no fi_eng_no ~
fi_pack fi_class fi_garage fi_sumsi fi_gap fi_premium fi_precomp ~
fi_totlepre fi_baseod fi_stk fi_refer fi_recipname fi_vatcode fi_user ~
fi_benname co_benname fi_remark1 ra_complete fi_userid ra_driv fi_notino ~
fi_notdat fi_nottim fi_remark2 fi_quo fi_other2 co_garage fi_other3 ~
fi_ispstatus 

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
     SIZE 5 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_agedriv2 AS INTEGER FORMAT "->>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 5 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_drivername1 AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 26 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_drivername2 AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 26 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_hbdri1 AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_hbdri2 AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_idnodriv1 AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 14.5 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_idnodriv2 AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 14.5 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_occupdriv1 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 18 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_occupdriv2 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 18 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_text1 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 8 BY .95 NO-UNDO.

DEFINE VARIABLE fi_text10 AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 5.17 BY .95 NO-UNDO.

DEFINE VARIABLE fi_text2 AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 8 BY .95 NO-UNDO.

DEFINE VARIABLE fi_text3 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 5.17 BY .95 NO-UNDO.

DEFINE VARIABLE fi_text4 AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 5.17 BY .95 NO-UNDO.

DEFINE VARIABLE fi_text5 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 5.17 BY .95 NO-UNDO.

DEFINE VARIABLE fi_text6 AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 5.17 BY .95 NO-UNDO.

DEFINE VARIABLE fi_text7 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 5.17 BY .95 NO-UNDO.

DEFINE VARIABLE fi_text8 AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 5.17 BY .95 NO-UNDO.

DEFINE VARIABLE fi_text9 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 5.17 BY .95 NO-UNDO.

DEFINE VARIABLE ra_sex1 AS INTEGER 
     VIEW-AS RADIO-SET VERTICAL
     RADIO-BUTTONS 
          "Male", 1,
"Female", 2
     SIZE 10 BY .95
     BGCOLOR 14 FGCOLOR 7 FONT 6 NO-UNDO.

DEFINE VARIABLE ra_sex2 AS INTEGER 
     VIEW-AS RADIO-SET VERTICAL
     RADIO-BUTTONS 
          "Male", 1,
"Female", 2
     SIZE 10 BY .95
     BGCOLOR 14 FGCOLOR 7 FONT 6 NO-UNDO.

DEFINE BUTTON buselecom 
     IMAGE-UP FILE "i:/safety/walp10/wimage/next.bmp":U
     LABEL "" 
     SIZE 4 BY .95.

DEFINE BUTTON bu_brand 
     IMAGE-UP FILE "I:/Safety/WALP10/WIMAGE/next.bmp":U
     LABEL "" 
     SIZE 3.5 BY .95.

DEFINE BUTTON bu_cover 
     IMAGE-UP FILE "I:/Safety/WALP10/WIMAGE/next.bmp":U
     LABEL "" 
     SIZE 3.5 BY .95.

DEFINE BUTTON bu_create 
     LABEL "Create" 
     SIZE 8 BY 1
     FONT 6.

DEFINE BUTTON bu_exit 
     LABEL "Exit" 
     SIZE 7.5 BY .95
     FONT 6.

DEFINE BUTTON bu_notes 
     LABEL "Notes" 
     SIZE 6 BY .95.

DEFINE BUTTON bu_product 
     IMAGE-UP FILE "I:/Safety/WALP10/WIMAGE/next.bmp":U
     LABEL "" 
     SIZE 3.5 BY .95.

DEFINE BUTTON bu_quo 
     LABEL "Quotation" 
     SIZE 12.33 BY 1
     FONT 6.

DEFINE BUTTON bu_save 
     LABEL "Save" 
     SIZE 7.5 BY .95
     FONT 6.

DEFINE VARIABLE co_addr AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS COMBO-BOX INNER-LINES 10
     DROP-DOWN-LIST
     SIZE 15 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE co_benname AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 5
     DROP-DOWN-LIST
     SIZE 59.83 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE co_caruse AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS COMBO-BOX INNER-LINES 6
     DROP-DOWN-LIST
     SIZE 20 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE co_garage AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 5
     DROP-DOWN-LIST
     SIZE 25.5 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_age AS INTEGER FORMAT "->>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 4.5 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_agent AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 11.5 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_baseod AS DECIMAL FORMAT "->,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 12.5 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_benname AS CHARACTER FORMAT "X(65)":U INITIAL ? 
     VIEW-AS FILL-IN 
     SIZE 60 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_birthday AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 13.5 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_brand AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 18 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_campaign AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 8 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_cha_no AS CHARACTER FORMAT "X(35)":U 
     VIEW-AS FILL-IN 
     SIZE 22 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_class AS CHARACTER FORMAT "X(5)":U 
     VIEW-AS FILL-IN 
     SIZE 5.5 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_cmrcode AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 16 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_cmrcode2 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 5 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_cmrsty AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 4.5 BY .95
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_comco AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 11 BY .95
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_comdat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_cover1 AS CHARACTER FORMAT "X(3)":U 
     VIEW-AS FILL-IN 
     SIZE 6 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_deler AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 11.5 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_eng_no AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 24 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_expdat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_gap AS DECIMAL FORMAT "->,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 13.5 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_garage AS CHARACTER FORMAT "X(5)":U 
     VIEW-AS FILL-IN 
     SIZE 3.5 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_idno AS CHARACTER FORMAT "X(13)":U 
     VIEW-AS FILL-IN 
     SIZE 20 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_idnoexpdat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 13.5 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_insadd1build AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 26 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_insadd1mu AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 5 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_insadd1no AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 10.5 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_insadd1road AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 19 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_insadd1soy AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 19 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_insadd2tam AS CHARACTER FORMAT "X(35)":U 
     VIEW-AS FILL-IN 
     SIZE 18.5 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_insadd3amp AS CHARACTER FORMAT "X(35)":U 
     VIEW-AS FILL-IN 
     SIZE 18 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_insadd4cunt AS CHARACTER FORMAT "X(35)":U 
     VIEW-AS FILL-IN 
     SIZE 18 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_insadd5post AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 8 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_insadd6tel AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 16 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_institle AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_ins_off AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 23 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_ispno AS CHARACTER FORMAT "X(45)":U 
     VIEW-AS FILL-IN 
     SIZE 22.67 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_ispstatus AS CHARACTER FORMAT "X(1)":U 
     VIEW-AS FILL-IN 
     SIZE 4.67 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_licence1 AS CHARACTER FORMAT "X(3)":U 
     VIEW-AS FILL-IN 
     SIZE 6 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_licence2 AS CHARACTER FORMAT "X(4)":U 
     VIEW-AS FILL-IN 
     SIZE 6.5 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_model AS CHARACTER FORMAT "X(45)":U 
     VIEW-AS FILL-IN 
     SIZE 42 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_namedrirect AS CHARACTER FORMAT "X(60)":U 
     VIEW-AS FILL-IN 
     SIZE 23 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_notdat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .95
     BGCOLOR 8 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_notino AS CHARACTER FORMAT "X(35)":U 
     VIEW-AS FILL-IN 
     SIZE 17 BY .95
     BGCOLOR 8  NO-UNDO.

DEFINE VARIABLE fi_notno70 AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 17 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_notno72 AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 17 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_nottim AS CHARACTER FORMAT "X(13)":U 
     VIEW-AS FILL-IN 
     SIZE 10 BY .95
     BGCOLOR 8 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_occup AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 20 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_other2 AS DECIMAL FORMAT "->,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 22 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_other3 AS CHARACTER FORMAT "X(60)":U 
     VIEW-AS FILL-IN 
     SIZE 53 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_pack AS CHARACTER FORMAT "X(1)":U 
     VIEW-AS FILL-IN 
     SIZE 3.5 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_power AS DECIMAL FORMAT ">>,>>9.99":U INITIAL ? 
     VIEW-AS FILL-IN 
     SIZE 11.5 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_precomp AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 10.5 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_preinsur AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 28 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_preinsur2 AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 28 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_premium AS DECIMAL FORMAT "->,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 13.5 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_producer AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 11.5 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_product AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 6 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_provin AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 23 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_quo AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 18.67 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_recipname AS CHARACTER FORMAT "X(100)":U INITIAL ? 
     VIEW-AS FILL-IN 
     SIZE 33 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_refer AS CHARACTER FORMAT "X(35)":U 
     VIEW-AS FILL-IN 
     SIZE 15.5 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_remark1 AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 60.83 BY .95
     BGCOLOR 8 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_remark2 AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 60.83 BY .95
     BGCOLOR 8 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_stk AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 17 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_sumsi AS DECIMAL FORMAT "->>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 16 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_totlepre AS DECIMAL FORMAT "->,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 13 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_user AS CHARACTER FORMAT "X(100)":U INITIAL ? 
     VIEW-AS FILL-IN 
     SIZE 39 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_userid AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 7.5 BY .76
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_vatcode AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_year AS CHARACTER FORMAT "X(5)":U INITIAL "0" 
     VIEW-AS FILL-IN 
     SIZE 7 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE ra_comp AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "แถม", 1,
"ไม่แถม", 2,
"ไม่เอาพรบ.", 3
     SIZE 28 BY .95
     FONT 6 NO-UNDO.

DEFINE VARIABLE ra_complete AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "Complete", 1,
"Not Complete", 2
     SIZE 28.5 BY .95
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE ra_cover AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "ป้ายแดง", 1,
"User car", 2,
"BIKE", 3
     SIZE 29 BY .95
     BGCOLOR 14 FGCOLOR 7 FONT 6 NO-UNDO.

DEFINE VARIABLE ra_driv AS INTEGER 
     VIEW-AS RADIO-SET VERTICAL
     RADIO-BUTTONS 
          "ไม่ระบุ", 1,
"ระบุ", 2
     SIZE 9 BY 2.38
     BGCOLOR 14 FGCOLOR 7  NO-UNDO.

DEFINE VARIABLE ra_pa AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "ไม่ขายPA", 1,
"ขายPA", 2
     SIZE 20 BY .95
     BGCOLOR 14 FGCOLOR 7  NO-UNDO.

DEFINE VARIABLE ra_pree AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "แถม  ", 1,
"ไม่แถม", 2
     SIZE 19 BY .95
     FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-488
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132.5 BY 23.81
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-489
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 38.33 BY 2.52
     BGCOLOR 6 .

DEFINE RECTANGLE RECT-490
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 9.5 BY 1.19
     BGCOLOR 2 FGCOLOR 0 .

DEFINE RECTANGLE RECT-491
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 10 BY 2
     BGCOLOR 12 .

DEFINE RECTANGLE RECT-492
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 10 BY 2
     BGCOLOR 3 .

DEFINE RECTANGLE RECT-493
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 31.5 BY 2
     BGCOLOR 5 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     bu_notes AT ROW 11.81 COL 127
     fi_ins_off AT ROW 2.33 COL 17.33 COLON-ALIGNED NO-LABEL
     fi_comco AT ROW 2.33 COL 51 COLON-ALIGNED NO-LABEL
     buselecom AT ROW 2.33 COL 64.33
     fi_cmrcode AT ROW 2.33 COL 72.67 COLON-ALIGNED NO-LABEL
     fi_cmrcode2 AT ROW 2.33 COL 94.5 COLON-ALIGNED NO-LABEL
     fi_campaign AT ROW 2.33 COL 115 COLON-ALIGNED NO-LABEL
     co_caruse AT ROW 3.43 COL 17.33 COLON-ALIGNED NO-LABEL
     ra_cover AT ROW 3.38 COL 39.83 NO-LABEL
     fi_cover1 AT ROW 3.38 COL 80.67 COLON-ALIGNED NO-LABEL
     bu_cover AT ROW 3.38 COL 88.83
     ra_pa AT ROW 3.38 COL 93.33 NO-LABEL
     fi_product AT ROW 3.38 COL 120.17 COLON-ALIGNED NO-LABEL
     bu_product AT ROW 3.38 COL 128.5
     ra_pree AT ROW 4.48 COL 19.33 NO-LABEL
     ra_comp AT ROW 4.48 COL 45.5 NO-LABEL
     fi_producer AT ROW 5.52 COL 17.17 COLON-ALIGNED NO-LABEL
     fi_agent AT ROW 5.52 COL 37.5 COLON-ALIGNED NO-LABEL
     fi_deler AT ROW 5.52 COL 58 COLON-ALIGNED NO-LABEL
     fi_cmrsty AT ROW 5.52 COL 77.17 COLON-ALIGNED NO-LABEL
     fi_notno70 AT ROW 4.62 COL 94 COLON-ALIGNED NO-LABEL
     fi_notno72 AT ROW 5.71 COL 94 COLON-ALIGNED NO-LABEL
     bu_create AT ROW 5.14 COL 113.67
     fi_institle AT ROW 7.62 COL 17.17 COLON-ALIGNED NO-LABEL
     fi_preinsur AT ROW 7.62 COL 36.83 COLON-ALIGNED NO-LABEL
     fi_preinsur2 AT ROW 7.62 COL 74.67 COLON-ALIGNED NO-LABEL
     fi_idno AT ROW 7.62 COL 109.83 COLON-ALIGNED NO-LABEL
     fi_birthday AT ROW 8.67 COL 17.17 COLON-ALIGNED NO-LABEL
     fi_age AT ROW 8.67 COL 35.67 COLON-ALIGNED NO-LABEL
     fi_idnoexpdat AT ROW 8.67 COL 53.5 COLON-ALIGNED NO-LABEL
     fi_occup AT ROW 8.67 COL 73.83 COLON-ALIGNED NO-LABEL
     fi_namedrirect AT ROW 8.67 COL 106.67 COLON-ALIGNED NO-LABEL
     fi_insadd1no AT ROW 9.71 COL 17.17 COLON-ALIGNED NO-LABEL
     fi_insadd1mu AT ROW 9.71 COL 32.67 COLON-ALIGNED NO-LABEL
     co_addr AT ROW 9.71 COL 38 COLON-ALIGNED NO-LABEL
     fi_insadd1build AT ROW 9.71 COL 53 COLON-ALIGNED NO-LABEL
     fi_insadd1soy AT ROW 9.71 COL 86 COLON-ALIGNED NO-LABEL
     fi_insadd1road AT ROW 9.71 COL 110.83 COLON-ALIGNED NO-LABEL
     fi_insadd2tam AT ROW 10.76 COL 17.17 COLON-ALIGNED NO-LABEL
     fi_insadd3amp AT ROW 10.76 COL 46.5 COLON-ALIGNED NO-LABEL
     fi_insadd4cunt AT ROW 10.76 COL 72.5 COLON-ALIGNED NO-LABEL
     fi_insadd5post AT ROW 10.76 COL 96.17 COLON-ALIGNED NO-LABEL
     fi_insadd6tel AT ROW 10.76 COL 113.83 COLON-ALIGNED NO-LABEL
     fi_comdat AT ROW 11.81 COL 33.17 COLON-ALIGNED NO-LABEL
     fi_expdat AT ROW 11.81 COL 69.17 COLON-ALIGNED NO-LABEL
     fi_ispno AT ROW 11.81 COL 97.33 COLON-ALIGNED NO-LABEL
     fi_brand AT ROW 12.86 COL 17.17 COLON-ALIGNED NO-LABEL
     fi_model AT ROW 12.86 COL 48.67 COLON-ALIGNED NO-LABEL
     fi_year AT ROW 12.86 COL 101.5 COLON-ALIGNED NO-LABEL
     fi_power AT ROW 12.86 COL 118 COLON-ALIGNED NO-LABEL
     fi_licence1 AT ROW 13.91 COL 17.17 COLON-ALIGNED NO-LABEL
     fi_licence2 AT ROW 13.91 COL 24.17 COLON-ALIGNED NO-LABEL
     fi_provin AT ROW 13.91 COL 31 COLON-ALIGNED NO-LABEL DISABLE-AUTO-ZAP 
     fi_cha_no AT ROW 13.91 COL 68.33 COLON-ALIGNED NO-LABEL
     fi_eng_no AT ROW 13.91 COL 105.33 COLON-ALIGNED NO-LABEL
     fi_pack AT ROW 17.43 COL 17.17 COLON-ALIGNED NO-LABEL
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 132.5 BY 23.91
         BGCOLOR 3 FGCOLOR 1 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     fi_class AT ROW 17.43 COL 28.17 COLON-ALIGNED NO-LABEL
     fi_garage AT ROW 17.43 COL 43.5 COLON-ALIGNED NO-LABEL
     fi_sumsi AT ROW 17.43 COL 59 COLON-ALIGNED NO-LABEL
     fi_gap AT ROW 17.43 COL 84.5 COLON-ALIGNED NO-LABEL
     fi_premium AT ROW 17.43 COL 115 COLON-ALIGNED NO-LABEL
     fi_precomp AT ROW 18.48 COL 17.17 COLON-ALIGNED NO-LABEL
     fi_totlepre AT ROW 18.48 COL 36 COLON-ALIGNED NO-LABEL
     fi_baseod AT ROW 18.48 COL 58.5 COLON-ALIGNED NO-LABEL
     fi_stk AT ROW 18.48 COL 82 COLON-ALIGNED NO-LABEL
     fi_refer AT ROW 18.48 COL 113.83 COLON-ALIGNED NO-LABEL
     fi_recipname AT ROW 19.52 COL 17.17 COLON-ALIGNED NO-LABEL
     fi_vatcode AT ROW 19.52 COL 62 COLON-ALIGNED NO-LABEL
     fi_user AT ROW 21.62 COL 88.5 COLON-ALIGNED NO-LABEL
     fi_benname AT ROW 20.57 COL 17.17 COLON-ALIGNED NO-LABEL
     co_benname AT ROW 21.62 COL 17.17 COLON-ALIGNED NO-LABEL
     fi_remark1 AT ROW 22.76 COL 17.17 COLON-ALIGNED NO-LABEL
     ra_complete AT ROW 23.19 COL 82 NO-LABEL
     bu_save AT ROW 23.24 COL 113.5
     bu_exit AT ROW 23.19 COL 124
     fi_userid AT ROW 6.1 COL 121.33 COLON-ALIGNED NO-LABEL
     ra_driv AT ROW 14.95 COL 1.5 NO-LABEL
     fi_notino AT ROW 1.24 COL 28.83 COLON-ALIGNED NO-LABEL
     fi_notdat AT ROW 1.24 COL 59.17 COLON-ALIGNED NO-LABEL
     fi_nottim AT ROW 1.24 COL 85 COLON-ALIGNED NO-LABEL
     bu_brand AT ROW 12.86 COL 38
     fi_remark2 AT ROW 23.81 COL 17.17 COLON-ALIGNED NO-LABEL
     fi_quo AT ROW 6.57 COL 24.33 COLON-ALIGNED NO-LABEL
     bu_quo AT ROW 6.57 COL 45.17
     fi_other2 AT ROW 19.57 COL 103 COLON-ALIGNED NO-LABEL
     co_garage AT ROW 6.57 COL 55.67 COLON-ALIGNED NO-LABEL
     fi_other3 AT ROW 20.57 COL 77.5 COLON-ALIGNED NO-LABEL
     fi_ispstatus AT ROW 11.81 COL 120.17 COLON-ALIGNED NO-LABEL
     "รหัสบริษัท:":30 VIEW-AS TEXT
          SIZE 10 BY .95 AT ROW 2.33 COL 42.67
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "อายุ:":35 VIEW-AS TEXT
          SIZE 4.5 BY .95 AT ROW 8.67 COL 32.83
          BGCOLOR 18 FGCOLOR 2 FONT 6
     "อุปกรณ์เสริมคุ้มครองไม่เกิน :":30 VIEW-AS TEXT
          SIZE 25.17 BY .95 AT ROW 19.57 COL 79.33
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "จังหวัด:":30 VIEW-AS TEXT
          SIZE 7 BY .95 AT ROW 10.76 COL 67
          BGCOLOR 18 FGCOLOR 2 FONT 6
     "                เลขที่  :":30 VIEW-AS TEXT
          SIZE 17 BY .95 AT ROW 9.71 COL 1.5
          BGCOLOR 18 FGCOLOR 2 FONT 6
     "เบี้ยรวม":30 VIEW-AS TEXT
          SIZE 7.5 BY .95 AT ROW 18.48 COL 30.17
          BGCOLOR 18 FGCOLOR 0 FONT 6
     " ทุนประกัน :":30 VIEW-AS TEXT
          SIZE 11 BY .95 AT ROW 17.43 COL 49.67
          BGCOLOR 18 FGCOLOR 0 FONT 6
     " Policy 70 :":35 VIEW-AS TEXT
          SIZE 11 BY .95 AT ROW 4.67 COL 84.67
          BGCOLOR 3 FGCOLOR 0 FONT 6
     " ปีรถ :":35 VIEW-AS TEXT
          SIZE 6 BY .95 AT ROW 12.86 COL 97
          BGCOLOR 18 FGCOLOR 0 FONT 6
     " Policy 72 :":35 VIEW-AS TEXT
          SIZE 11 BY .95 AT ROW 5.71 COL 84.67
          BGCOLOR 3 FGCOLOR 0 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 132.5 BY 23.91
         BGCOLOR 3 FGCOLOR 1 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "              ประกัน :":30 VIEW-AS TEXT
          SIZE 17 BY .95 AT ROW 4.48 COL 1.5
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "   ข้อมูลประกันภัย :":30 VIEW-AS TEXT
          SIZE 17 BY .95 AT ROW 11.81 COL 1.67
          BGCOLOR 2 FGCOLOR 7 FONT 6
     "       ตำบล/แขวง  :":30 VIEW-AS TEXT
          SIZE 17 BY .95 AT ROW 10.76 COL 1.5
          BGCOLOR 18 FGCOLOR 2 FONT 6
     " NOTIFY  ENTRY" VIEW-AS TEXT
          SIZE 17 BY .95 AT ROW 1.24 COL 1.5
          BGCOLOR 2 FGCOLOR 7 FONT 6
     " สาขา :":35 VIEW-AS TEXT
          SIZE 5.5 BY .95 AT ROW 2.33 COL 68.67
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "เลขตัวถังรถ :":20 VIEW-AS TEXT
          SIZE 13 BY .95 AT ROW 13.91 COL 56.67
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "เลขเครื่องยนต์ :":35 VIEW-AS TEXT
          SIZE 14 BY .95 AT ROW 13.91 COL 93
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "หมู่ :":30 VIEW-AS TEXT
          SIZE 4 BY .95 AT ROW 9.71 COL 30.17
          BGCOLOR 18 FGCOLOR 2 FONT 6
     "(สติ๊กเกอร์):":30 VIEW-AS TEXT
          SIZE 10 BY .95 AT ROW 18.48 COL 73.5
          BGCOLOR 18 FGCOLOR 0 FONT 6
     " ใบเสร็จออกในนาม :":35 VIEW-AS TEXT
          SIZE 17 BY .95 AT ROW 19.52 COL 1.5
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "Class :":35 VIEW-AS TEXT
          SIZE 6.5 BY .95 AT ROW 17.43 COL 23.17
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "         ผู้แจ้ง MKT:":35 VIEW-AS TEXT
          SIZE 17 BY .95 AT ROW 2.33 COL 1.5
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "บัตรหมดอายุ:":35 VIEW-AS TEXT
          SIZE 12 BY .95 AT ROW 8.67 COL 43.17
          BGCOLOR 18 FGCOLOR 2 FONT 6
     " ชื่อ :":35 VIEW-AS TEXT
          SIZE 5 BY .95 AT ROW 7.62 COL 33.5
          BGCOLOR 18 FGCOLOR 2 FONT 6
     "เบี้ยรวมภาษีอากร :":30 VIEW-AS TEXT
          SIZE 16 BY .95 AT ROW 17.43 COL 100.67
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "IDno :":30 VIEW-AS TEXT
          SIZE 6 BY .95 AT ROW 7.62 COL 105.5
          BGCOLOR 18 FGCOLOR 2 FONT 6
     "    ประเภทประกัน :":30 VIEW-AS TEXT
          SIZE 17 BY .95 AT ROW 3.38 COL 1.5
          BGCOLOR 2 FGCOLOR 7 FONT 6
     "อำเภอ/เขต :":30 VIEW-AS TEXT
          SIZE 9.5 BY .95 AT ROW 10.76 COL 38.5
          BGCOLOR 18 FGCOLOR 2 FONT 6
     "DEDUCT":30 VIEW-AS TEXT
          SIZE 8.5 BY .95 AT ROW 18.48 COL 51.5
          BGCOLOR 2 FGCOLOR 6 FONT 6
     "Bth":30 VIEW-AS TEXT
          SIZE 5 BY .95 AT ROW 19.57 COL 127.5
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "  Vatcode :":30 VIEW-AS TEXT
          SIZE 11 BY .95 AT ROW 19.52 COL 52.67
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "อาชีพ:":35 VIEW-AS TEXT
          SIZE 6 BY .95 AT ROW 8.67 COL 69.5
          BGCOLOR 18 FGCOLOR 2 FONT 6
     " No.Time :":30 VIEW-AS TEXT
          SIZE 11 BY .95 AT ROW 1.24 COL 75.67
          BGCOLOR 18 FGCOLOR 0 FONT 6
     " ความคุ้มครอง :" VIEW-AS TEXT
          SIZE 13.5 BY .95 AT ROW 3.38 COL 69
          BGCOLOR 5 FGCOLOR 7 FONT 6
     "ถนน :":30 VIEW-AS TEXT
          SIZE 5 BY .95 AT ROW 9.71 COL 107.33
          BGCOLOR 18 FGCOLOR 2 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 132.5 BY 23.91
         BGCOLOR 3 FGCOLOR 1 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     " พรบ.":30 VIEW-AS TEXT
          SIZE 6 BY .95 AT ROW 4.48 COL 38.83
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "ซอย :":30 VIEW-AS TEXT
          SIZE 5 BY .95 AT ROW 9.71 COL 82.33
          BGCOLOR 18 FGCOLOR 2 FONT 6
     "Campaign No.:":35 VIEW-AS TEXT
          SIZE 14.5 BY .95 AT ROW 2.33 COL 102
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "Notify Date :":30 VIEW-AS TEXT
          SIZE 12 BY .95 AT ROW 1.24 COL 48.5
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "การซ่อม:":35 VIEW-AS TEXT
          SIZE 8.5 BY .95 AT ROW 17.43 COL 36.33
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "STYBr:":35 VIEW-AS TEXT
          SIZE 6.5 BY .95 AT ROW 5.52 COL 72.17
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "           ข้อมูลลูกค้า" VIEW-AS TEXT
          SIZE 17 BY .95 AT ROW 6.57 COL 1.5
          BGCOLOR 2 FGCOLOR 7 FONT 6
     "         Producer :":30 VIEW-AS TEXT
          SIZE 17 BY .95 AT ROW 5.52 COL 1.5
          BGCOLOR 18 FGCOLOR 0 FONT 6
     " UPDATE     DATA........." VIEW-AS TEXT
          SIZE 34.67 BY .95 AT ROW 1.24 COL 97.33
          BGCOLOR 12 FGCOLOR 7 FONT 2
     "Notify no.:" VIEW-AS TEXT
          SIZE 11 BY .95 AT ROW 1.24 COL 19.33
          BGCOLOR 18 FGCOLOR 2 FONT 6
     "    8.3  ไฟแนนซ์ :":30 VIEW-AS TEXT
          SIZE 17 BY .95 AT ROW 20.57 COL 1.5
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "           เบี้ย พรบ.:":30 VIEW-AS TEXT
          SIZE 17 BY .95 AT ROW 18.48 COL 1.5
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "Product" VIEW-AS TEXT
          SIZE 8 BY .95 AT ROW 3.38 COL 113.67
          BGCOLOR 29 FGCOLOR 2 FONT 6
     "     วันเดือนปีเกิด :":35 VIEW-AS TEXT
          SIZE 17 BY .95 AT ROW 8.67 COL 1.5
          BGCOLOR 18 FGCOLOR 2 FONT 6
     "โทรศัพท์:":30 VIEW-AS TEXT
          SIZE 8 BY .95 AT ROW 10.76 COL 107.33
          BGCOLOR 18 FGCOLOR 2 FONT 6
     "          Package :":35 VIEW-AS TEXT
          SIZE 17 BY .95 AT ROW 17.43 COL 1.5
          BGCOLOR 18 FGCOLOR 0 FONT 6
     " ผู้รับแจ้ง :":35 VIEW-AS TEXT
          SIZE 11 BY .95 AT ROW 21.62 COL 79.33
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "Q No.":30 VIEW-AS TEXT
          SIZE 6.83 BY .95 AT ROW 6.57 COL 19.33
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "ชื่อกรรมการ:":35 VIEW-AS TEXT
          SIZE 12 BY .95 AT ROW 8.67 COL 96.33
          BGCOLOR 18 FGCOLOR 2 FONT 6
     "                 คำนำ :":35 VIEW-AS TEXT
          SIZE 17 BY .95 AT ROW 7.62 COL 1.5
          BGCOLOR 18 FGCOLOR 2 FONT 6
     "วันที่เริ่มค้มครอง :":35 VIEW-AS TEXT
          SIZE 16 BY .95 AT ROW 11.81 COL 19
          BGCOLOR 18 FGCOLOR 4 FONT 6
     " Deler :":30 VIEW-AS TEXT
          SIZE 8 BY .95 AT ROW 5.52 COL 51.5
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "          หมายเหตุ :":30 VIEW-AS TEXT
          SIZE 17 BY .95 AT ROW 22.86 COL 1.5
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "เบี้ยสุทธฺ:":30 VIEW-AS TEXT
          SIZE 8.5 BY .95 AT ROW 17.43 COL 77.33
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "วันหมดอายุความคุ้มครอง:":35 VIEW-AS TEXT
          SIZE 21.67 BY .95 AT ROW 11.81 COL 49.33
          BGCOLOR 18 FGCOLOR 4 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 132.5 BY 23.91
         BGCOLOR 3 FGCOLOR 1 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "User by:" VIEW-AS TEXT
          SIZE 9 BY 1 AT ROW 4.86 COL 122.67
          BGCOLOR 18 FGCOLOR 2 FONT 6
     "Reference no:":30 VIEW-AS TEXT
          SIZE 13.5 BY .95 AT ROW 18.48 COL 101.67
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "             ยี่ห้อรถ  :":30 VIEW-AS TEXT
          SIZE 17 BY .95 AT ROW 12.86 COL 1.5
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "รหัส:":30 VIEW-AS TEXT
          SIZE 4.5 BY .95 AT ROW 10.76 COL 93
          BGCOLOR 18 FGCOLOR 2 FONT 6
     "         ทะเบียนรถ :":30 VIEW-AS TEXT
          SIZE 17 BY .95 AT ROW 13.91 COL 1.5
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "นามสกุล :":35 VIEW-AS TEXT
          SIZE 9 BY .95 AT ROW 7.62 COL 67.17
          BGCOLOR 18 FGCOLOR 2 FONT 6
     "เลขตรวจสภาพ:":30 VIEW-AS TEXT
          SIZE 13.83 BY .95 AT ROW 11.81 COL 85.33
          BGCOLOR 18 FGCOLOR 0 FONT 6
     " รหัส:":35 VIEW-AS TEXT
          SIZE 5 BY .95 AT ROW 2.33 COL 91.17
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "  Agent :":30 VIEW-AS TEXT
          SIZE 8 BY .95 AT ROW 5.52 COL 31
          BGCOLOR 18 FGCOLOR 0 FONT 6
     " รุ่นรถ :":30 VIEW-AS TEXT
          SIZE 8 BY .95 AT ROW 12.86 COL 42.17
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "Eng CC :":30 VIEW-AS TEXT
          SIZE 8 BY .95 AT ROW 12.86 COL 111.17
          BGCOLOR 18 FGCOLOR 0 FONT 6
     RECT-488 AT ROW 1 COL 1
     RECT-489 AT ROW 4.43 COL 84
     RECT-490 AT ROW 5.91 COL 122.5
     RECT-491 AT ROW 22.67 COL 122.67
     RECT-492 AT ROW 22.67 COL 112.33
     RECT-493 AT ROW 22.67 COL 80.5
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 132.5 BY 23.91
         BGCOLOR 3 FGCOLOR 1 .

DEFINE FRAME fr_driv
     fi_text1 AT ROW 1.14 COL 1.5 NO-LABEL
     fi_drivername1 AT ROW 1.14 COL 7.83 COLON-ALIGNED NO-LABEL
     ra_sex1 AT ROW 1.14 COL 36.17 NO-LABEL
     fi_text3 AT ROW 1.14 COL 46.67 NO-LABEL
     fi_text5 AT ROW 1.14 COL 66.5 NO-LABEL
     fi_agedriv1 AT ROW 1.14 COL 70 COLON-ALIGNED NO-LABEL
     fi_occupdriv1 AT ROW 1.14 COL 80.67 COLON-ALIGNED NO-LABEL
     fi_text9 AT ROW 1.14 COL 101 NO-LABEL
     fi_idnodriv1 AT ROW 1.14 COL 104.67 COLON-ALIGNED NO-LABEL
     fi_hbdri1 AT ROW 1.19 COL 50.17 COLON-ALIGNED NO-LABEL
     fi_text7 AT ROW 1.19 COL 77.33 NO-LABEL
     fi_text2 AT ROW 2.19 COL 1.5 NO-LABEL
     fi_drivername2 AT ROW 2.19 COL 7.83 COLON-ALIGNED NO-LABEL
     ra_sex2 AT ROW 2.19 COL 36.17 NO-LABEL
     fi_text4 AT ROW 2.19 COL 46.67 NO-LABEL
     fi_hbdri2 AT ROW 2.19 COL 50.17 COLON-ALIGNED NO-LABEL
     fi_text6 AT ROW 2.19 COL 66.5 NO-LABEL
     fi_agedriv2 AT ROW 2.19 COL 70 COLON-ALIGNED NO-LABEL
     fi_text8 AT ROW 2.19 COL 77.33 NO-LABEL
     fi_occupdriv2 AT ROW 2.19 COL 80.67 COLON-ALIGNED NO-LABEL
     fi_text10 AT ROW 2.19 COL 101 NO-LABEL
     fi_idnodriv2 AT ROW 2.19 COL 104.67 COLON-ALIGNED NO-LABEL
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         NO-LABELS SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 10.83 ROW 14.95
         SIZE 121 BY 2.38
         BGCOLOR 5 .


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
         HEIGHT             = 23.91
         WIDTH              = 132.5
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
/* SETTINGS FOR WINDOW C-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* REPARENT FRAME */
ASSIGN FRAME fr_driv:FRAME = FRAME fr_main:HANDLE.

/* SETTINGS FOR FRAME fr_driv
                                                                        */
/* SETTINGS FOR FILL-IN fi_text1 IN FRAME fr_driv
   ALIGN-L                                                              */
/* SETTINGS FOR FILL-IN fi_text10 IN FRAME fr_driv
   ALIGN-L                                                              */
/* SETTINGS FOR FILL-IN fi_text2 IN FRAME fr_driv
   ALIGN-L                                                              */
/* SETTINGS FOR FILL-IN fi_text3 IN FRAME fr_driv
   ALIGN-L                                                              */
/* SETTINGS FOR FILL-IN fi_text4 IN FRAME fr_driv
   ALIGN-L                                                              */
/* SETTINGS FOR FILL-IN fi_text5 IN FRAME fr_driv
   ALIGN-L                                                              */
/* SETTINGS FOR FILL-IN fi_text6 IN FRAME fr_driv
   ALIGN-L                                                              */
/* SETTINGS FOR FILL-IN fi_text7 IN FRAME fr_driv
   ALIGN-L                                                              */
/* SETTINGS FOR FILL-IN fi_text8 IN FRAME fr_driv
   ALIGN-L                                                              */
/* SETTINGS FOR FILL-IN fi_text9 IN FRAME fr_driv
   ALIGN-L                                                              */
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

/* SETTINGS FOR FILL-IN fi_userid IN FRAME fr_main
   NO-ENABLE                                                            */
ASSIGN 
       fi_userid:HIDDEN IN FRAME fr_main           = TRUE.

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


&Scoped-define SELF-NAME buselecom
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buselecom C-Win
ON CHOOSE OF buselecom IN FRAME fr_main
DO:
    n_chkname = "1". 
    IF fi_comco = "" THEN DO:       
        RUN wgw\wgwhpcom (INPUT-OUTPUT n_name,
                          INPUT-OUTPUT n_nO1,
                          INPUT-OUTPUT n_nO2,
                          INPUT-OUTPUT n_nO3,          /*kridtiya i. A55-0125*/
                          INPUT-OUTPUT nv_benname,     /*kridtiya i. A56-0024*/ 
                          INPUT-OUTPUT n_producernew,  /*kridtiya i. A56-0024*/
                          INPUT-OUTPUT n_produceruse,  /*kridtiya i. A56-0024*/
                          INPUT-OUTPUT n_producerbike,  /*kridtiya i. A57-0063*/
                          INPUT-OUTPUT n_agent,        /*kridtiya i. A56-0024*/
                          INPUT-OUTPUT n_text).
        IF n_text  = "save" THEN
            Assign 
            fi_benname   = nv_benname   /*A56-0024*/
            co_benname   = nv_benname   /* add by Phaiboon W. [A59-0488] Date 18/11/2016 */
            fi_cmrcode2  = n_nO1
            fi_cmrcode   = n_nO2
            fi_cmrsty    = n_nO3        /*kridtiya i. A55-0125*/
            fi_comco     = gComp .
    END.
    ELSE DO:
        RUN wgw\wgwhpcom (INPUT-OUTPUT n_name,
                          INPUT-OUTPUT n_nO1,
                          INPUT-OUTPUT n_nO2,
                          INPUT-OUTPUT n_nO3,          /*kridtiya i. A55-0125*/
                          INPUT-OUTPUT nv_benname,     /*kridtiya i. A56-0024*/ 
                          INPUT-OUTPUT n_producernew,  /*kridtiya i. A56-0024*/
                          INPUT-OUTPUT n_produceruse,  /*kridtiya i. A56-0024*/
                          INPUT-OUTPUT n_producerbike,  /*kridtiya i. A57-0063*/
                          INPUT-OUTPUT n_agent,        /*kridtiya i. A56-0024*/
                          INPUT-OUTPUT n_text).
        IF n_text  = "save" THEN
            Assign 
            fi_benname   = nv_benname   /*A56-0024*/
            co_benname   = nv_benname   /* add by Phaiboon W. [A59-0488] Date 18/11/2016 */
            fi_cmrcode2  = n_nO1
            fi_cmrcode   = n_nO2
            fi_cmrsty    = n_nO3        /*kridtiya i. A55-0125*/
            fi_comco     = gComp .
        
        FIND FIRST brstat.company WHERE Company.CompNo = fi_comco NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL company THEN DO: 
            RUN wgw\wgwhpcom (INPUT-OUTPUT n_name,
                              INPUT-OUTPUT n_nO1,
                              INPUT-OUTPUT n_nO2,
                              INPUT-OUTPUT n_nO3,          /*kridtiya i. A55-0125*/
                              INPUT-OUTPUT nv_benname,     /*kridtiya i. A56-0024*/ 
                              INPUT-OUTPUT n_producernew,  /*kridtiya i. A56-0024*/
                              INPUT-OUTPUT n_produceruse,  /*kridtiya i. A56-0024*/
                              INPUT-OUTPUT n_producerbike,  /*kridtiya i. A57-0063*/
                              INPUT-OUTPUT n_agent,        /*kridtiya i. A56-0024*/
                              INPUT-OUTPUT n_text).
            Assign fi_benname   = nv_benname               /*A56-0024*/
                   co_benname   = nv_benname                /* add by Phaiboon W. [A59-0488] Date 18/11/2016 */
                fi_cmrcode2 = n_nO1
                fi_cmrcode  = n_nO2
                fi_cmrsty   = n_nO3                        /*kridtiya i. A55-0125*/
                fi_comco    = gComp.
        END.
    END.
    IF fi_comco = "" THEN DO:
        APPLY "entry" TO fi_comco . 
        RETURN NO-APPLY.
    END.
    ELSE DO: 
        IF ra_cover = 1 THEN
            ASSIGN fi_pack = "G"
            fi_producer = n_producernew  
            fi_agent    =  n_agent    .
        ELSE IF ra_cover = 3 THEN
            ASSIGN fi_pack = "G"
            fi_producer = n_producerbike
            fi_agent    =  n_agent    .
        ELSE 
            ASSIGN 
                fi_producer = n_produceruse 
                fi_agent    = n_agent    .
    END.
    IF fi_cmrsty = "" THEN ASSIGN fi_cmrsty = "M".
    ASSIGN n_brsty   = fi_cmrsty.    /*A55-0125*/

    Disp fi_comco  fi_cmrcode2  fi_cmrcode  fi_producer fi_agent fi_benname  fi_cmrsty  co_benname with FRAM fr_main.
    APPLY "entry" TO fi_cmrcode . 
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
                      Input-output  fi_power ).  
    Disp fi_brand fi_model fi_year fi_power  with frame  fr_main.  
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
    ASSIGN  fi_benname   = nv_benname .    /*A56-0024*/
    IF (nv_cartyp = "BIKE(บุคคล)") OR (nv_cartyp = "BIKE(พาณิชย์)")  THEN ASSIGN fi_pack = "Z" .
    ELSE IF fi_cover1 = "1" THEN ASSIGN fi_pack = "G".
    ELSE IF fi_cover1 = "2" THEN ASSIGN fi_pack = "Y".
    ELSE IF fi_cover1 = "3" THEN 
        ASSIGN fi_pack = "R" 
        fi_benname  = ""   .
    ELSE IF fi_cover1 = "5" THEN ASSIGN fi_pack = "B".
    /*Add kridtiya i.A55-0108 */
    Disp  fi_cover1 fi_pack fi_class fi_benname with frame  fr_main. 
    Apply "Entry"  To  fi_cover1.
    Return no-apply.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_create
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_create C-Win
ON CHOOSE OF bu_create IN FRAME fr_main /* Create */
DO:
    IF fi_notno70 = "" THEN DO:
        ASSIGN  nv_check70 = "NO" 
            nv_check72     = "NO" . 
        MESSAGE "Do you Gen Policy70 Auto..Now  !!!!"        
            VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO      /*-CANCEL */    
            TITLE "" UPDATE choice AS LOGICAL.
        CASE choice:         
            WHEN TRUE THEN  /* Yes */ 
                DO:
                ASSIGN n_br    = "".
                /*nv_check70 = "NO" .*/
                IF fi_comco = "" THEN DO:
                    MESSAGE "ไม่พบบริษัทที่ต้องการนำเข้า]...!!!"       SKIP
                        "Plese Set up Company code. !!!"  VIEW-AS ALERT-BOX.
                    APPLY "entry" TO fi_comco.
                    RETURN NO-APPLY.
                END.
                IF fi_cmrsty = "" THEN DO:
                    MESSAGE "ไม่พบสาขาที่ต้องการนำเข้า]...!!!"       SKIP
                        "Plese Set up Branch..sty. !!!"  VIEW-AS ALERT-BOX.
                    APPLY "entry" TO fi_cmrsty.
                    RETURN NO-APPLY.
                END.
                FIND FIRST company WHERE Company.CompNo = fi_comco   NO-LOCK NO-ERROR NO-WAIT.
                IF NOT AVAIL company THEN DO:
                    MESSAGE "Not fond Company code[ ไม่พบบริษัทที่ต้องการนำเข้า]...!!!"       SKIP
                        "Plese Set up Company code. !!!"  VIEW-AS ALERT-BOX.
                    APPLY "entry" TO fi_comco.
                    RETURN NO-APPLY.
                END.
                ELSE DO:
                    ASSIGN 
                        n_brsty    = fi_cmrsty
                        n_br       = Company.AbName 
                        fi_notno70 = ""
                        n_poltyp   = "V70"
                        nv_brnpol  = n_brsty + n_br
                        n_undyr2   = string(YEAR(TODAY)) .
                    running_polno:    /*--Running 70 */
                    REPEAT:
                        RUN  wgw\wgwpon03(INPUT    YES,  
                                          INPUT    n_poltyp,
                                          INPUT    nv_brnpol,
                                          INPUT    string(n_undyr2),
                                          INPUT    fi_producer,
                                          INPUT-OUTPUT fi_notno70,
                                          INPUT-OUTPUT nv_check). 
                        IF fi_notno70 = "" THEN LEAVE running_polno.
                        FIND LAST  tlt    WHERE 
                            (tlt.genusr        = "Phone"      OR
                             tlt.genusr        = "FAX"  )     AND
                             tlt.policy        =  fi_notno70  NO-LOCK NO-ERROR NO-WAIT.
                        IF NOT AVAIL tlt THEN DO:
                            FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE 
                                sicuw.uwm100.policy = fi_notno70  NO-LOCK NO-ERROR.
                            IF AVAIL sicuw.uwm100 THEN DO:
                                IF  (sicuw.uwm100.name1 <> "") OR (sicuw.uwm100.comdat <> ? ) THEN  NEXT running_polno.
                            END.
                            ASSIGN  fi_notno70 = CAPS(fi_notno70)
                                nv_check70 = "yes".

                            Find  tlt  Where   Recid(tlt)  =  nv_recidtlt  NO-ERROR NO-WAIT .
                            IF AVAIL tlt THEN  ASSIGN tlt.policy        =  fi_notno70 .
                            RELEASE tlt.
                            LEAVE running_polno.
                        END.
                        ELSE NEXT running_polno.
                    END.   /*repeat*/
                    DISP fi_notno70 WITH FRAM fr_main.
                END. /*else do:...*/
                MESSAGE "Do you Gen Policy72 Auto..Now  !!!!"    /*-Gen policy 72  */        
                    VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO     
                    TITLE "" UPDATE choice2 AS LOGICAL.
                CASE choice2:         
                    WHEN TRUE THEN  /* Yes */ 
                        DO:
                        ASSIGN
                            nv_check72 = "no"
                            fi_notno72 = ""
                            n_poltyp   = "V72"
                            nv_brnpol  = n_brsty + n_br
                            n_undyr2   = string(YEAR(TODAY)) .
                        running_polno2:   /*--Running Line 04--*/
                        REPEAT:
                            RUN  wgw\wgwpon03(INPUT        YES,  
                                              INPUT        n_poltyp,
                                              INPUT        nv_brnpol,
                                              INPUT        string(n_undyr2),
                                              INPUT        fi_producer,
                                              INPUT-OUTPUT fi_notno72,
                                              INPUT-OUTPUT nv_check). 
                            IF fi_notno72 = "" THEN LEAVE running_polno2 .
                            FIND LAST  tlt    WHERE 
                                (tlt.genusr    = "Phone"      OR
                                tlt.genusr     = "FAX"  )     AND
                                tlt.comp_pol   = fi_notno72  NO-LOCK NO-ERROR NO-WAIT.
                            IF NOT AVAIL tlt THEN DO:
                                FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE 
                                    sicuw.uwm100.policy = CAPS(fi_notno72) NO-LOCK NO-ERROR.
                                IF AVAIL sicuw.uwm100 THEN DO:  
                                    IF  (sicuw.uwm100.name1 <> "") OR (sicuw.uwm100.comdat <> ? ) THEN NEXT running_polno2.

                                END.
                                ELSE DO:
                                    ASSIGN fi_notno72 = CAPS(fi_notno72)
                                        nv_check72 = "yes".
                                    Find  tlt  Where   Recid(tlt)  =  nv_recidtlt  NO-ERROR NO-WAIT .
                                    IF AVAIL tlt THEN  ASSIGN tlt.comp_pol      =  fi_notno72.
                                    RELEASE tlt.
                                    LEAVE running_polno2 .
                                END.
                            END.
                        END.        /*repeat*/
                        DISP  fi_notno72 WITH FRAM fr_main.
                    END.
                    WHEN FALSE THEN    /* No */ 
                        DO:   
                        APPLY "entry" TO fi_notno72.
                        RETURN NO-APPLY.
                    END. 
                END CASE .
                DISP fi_notno72 WITH FRAM fr_main.
                APPLY "entry" TO fi_institle.
                RETURN NO-APPLY.
            END.
            WHEN FALSE THEN /* No */          
                DO:   
                APPLY "entry" TO fi_notno70.
                RETURN NO-APPLY.
            END.
        END CASE.
    END.  /* if fi_notno70= "" */
    ELSE IF fi_notno72 = "" THEN DO:
        ASSIGN  nv_check72 = "NO" .
        MESSAGE "Do you Gen Policy72 Auto..Now  !!!!"        
            VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO     /*-CANCEL */    
            TITLE "" UPDATE choice3 AS LOGICAL.
        CASE choice3:         
            WHEN TRUE THEN  /* Yes */ 
                DO:
                FIND FIRST company WHERE Company.CompNo   = INPUT fi_comco NO-LOCK NO-ERROR NO-WAIT.
                IF NOT AVAIL company THEN 
                    MESSAGE "Not fond Company code...!!!"     SKIP
                            "Plese Set up Company code. !!!"  VIEW-AS ALERT-BOX.
                ELSE DO:
                    ASSIGN 
                        n_br = Company.AbName
                        fi_notno72 = ""
                        n_poltyp   = "V72"
                        nv_brnpol  = n_brsty + n_br
                        n_undyr2  = string(YEAR(TODAY)) .
                    running_polno3:   /*--Running Line 04--*/
                    REPEAT:
                        RUN  wgw\wgwpon03(INPUT        YES,  
                                          INPUT        n_poltyp,
                                          INPUT        nv_brnpol,
                                          INPUT        string(n_undyr2),
                                          INPUT        fi_producer,
                                          INPUT-OUTPUT fi_notno72,
                                          INPUT-OUTPUT nv_check). 
                        IF fi_notno72 = "" THEN LEAVE running_polno3 .
                        FIND LAST  tlt    WHERE 
                            (tlt.genusr     = "Phone"      OR
                             tlt.genusr     = "FAX"  )     AND
                            tlt.comp_pol   = fi_notno72  NO-LOCK NO-ERROR NO-WAIT.
                        IF NOT AVAIL tlt THEN DO:
                            FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE 
                                sicuw.uwm100.policy = CAPS(fi_notno72) NO-LOCK NO-ERROR.
                            IF AVAIL sicuw.uwm100 THEN DO:  
                                IF  (sicuw.uwm100.name1 <> "") OR (sicuw.uwm100.comdat <> ? ) THEN NEXT running_polno3.
                            END.
                            ELSE DO:
                                ASSIGN fi_notno72 = CAPS(fi_notno72)
                                    nv_check72 = "yes".
                                Find  tlt  Where   Recid(tlt)  =  nv_recidtlt  NO-ERROR NO-WAIT .
                                IF AVAIL tlt THEN  ASSIGN tlt.comp_pol      =  fi_notno72.
                                RELEASE tlt.
                                LEAVE running_polno3 .
                            END.
                        END.
                    END.        /*repeat*/
                    DISP  fi_notno72 WITH FRAM fr_main.
                    APPLY "entry" TO fi_institle.
                    RETURN NO-APPLY.
                END.
            END.
            WHEN FALSE THEN /* No */          
                DO:   
                APPLY "entry" TO fi_notno72.
                RETURN NO-APPLY.
            END.
        END CASE. 
    END.
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
        /*Apply "Close"  To this-procedure.
        Return no-apply.*/
 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_notes
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_notes C-Win
ON CHOOSE OF bu_notes IN FRAME fr_main /* Notes */
DO:
    /* Begin by Phaiboon W. [A59-0625] Date 22/12/2016 */       
    ASSIGN              
        nv_year      = SUBSTR(STRING(YEAR(TODAY)),3,2)   
        NotesServer  = "Safety_NotesServer/Safety"
        NotesApp     = "safety\uw\inspect" + nv_year + ".nsf"
        NotesView    = "เลขตัวถัง"
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
        nv_cha_no    = TRIM(fi_cha_no).
                                                                                                                                           
    nv_licence1 = fi_licence1.
    nv_licence2 = fi_licence2.

    IF TRIM(nv_licence1) = ""
    OR TRIM(nv_licence2) = ""
    OR TRIM(nv_cha_no)   = "" THEN DO:

        MESSAGE "ทะเบียนรถ หรือ เลขตัวถัง เป็นค่าว่าง" SKIP
                "กรุณาระบุข้อมูลให้ครบถ้วน !" 
        VIEW-AS ALERT-BOX ERROR.
        RETURN NO-APPLY.
    END.

    CREATE "Notes.NotesSession" chSession.                              
    CREATE "Notes.NotesUIWorkSpace" chWorkSpace.    
    chDatabase = chSession:GetDatabase(NotesServer,NotesApp).    
    /* chDatabase = chSession:GetDatabase("","inspect16.nsf"). /* Test */ */
                    
    IF chDatabase:isOpen = NO THEN DO:    

        MESSAGE "Can not open Database !" VIEW-AS ALERT-BOX.
        RETURN NO-APPLY.
    END.
    ELSE DO:
        chName   = chSession:CreateName(chSession:UserName).        
        nv_name  = chName:Abbreviated.
        nv_datim = STRING(TODAY,"99/99/9999") + " " + STRING(TIME,"HH:MM:SS").
                
        /* nv_branch */       
        IF fi_notno70 <> "" THEN DO:                        
            IF SUBSTR(fi_notno70,1,1) >  "0" AND 
               SUBSTR(fi_notno70,1,1) <= "9" THEN nv_branch = SUBSTR(fi_notno70,1,2).
                                             ELSE nv_branch = SUBSTR(fi_notno70,2,1).
            RUN PD_BranchNotes.            
        END.
        /*----------*/
               
        /* nv_brname */
        FIND FIRST sicsyac.xmm600                               
             WHERE sicsyac.xmm600.acno = fi_agent NO-LOCK NO-ERROR.
        IF AVAIL sicsyac.xmm600 THEN nv_brname = sicsyac.xmm600.NAME.
        /*----------*/
               
        /* nv_model nv_modelcode */
        FIND FIRST sicuw.uwm301 USE-INDEX uwm30191              
             WHERE sicuw.uwm301.modcod = TRIM(fi_brand) NO-LOCK NO-ERROR.
        IF AVAIL sicuw.uwm301 THEN DO:                        
            nv_model  = TRIM(SUBSTR(uwm301.moddes,1,INDEX(uwm301.moddes," "))).
            nv_makdes = TRIM(SUBSTR(uwm301.moddes,INDEX(uwm301.moddes," "),(LENGTH(uwm301.moddes) + 1) - INDEX(uwm301.moddes," "))).            
            IF INDEX(nv_makdes," ") <> 0 THEN DO:
                
                nv_modelcode = TRIM(SUBSTR(nv_makdes,1,INDEX(nv_makdes," "))).
            END.           
            ELSE nv_modelcode = nv_makdes.                 
        END.
        /*----------------------*/
         
        /* nv_licence */                                            
        IF LENGTH(nv_licence1) = 3 THEN                          
            nv_licence1 = SUBSTR(nv_licence1,1,1) + " " + SUBSTR(nv_licence1,2,2).

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
                        nv_key2   = nv_licence1 + " " + fi_provin.                              /* PM */
                        
                        IF nv_key1 = nv_key2 THEN DO:
                            nv_surcl  = chDocument:GetFirstItem("SurveyClose"):TEXT.                                                                                                  
                            IF nv_surcl = "" THEN DO:                            
                                nv_docno  = chDocument:GetFirstItem("docno"):TEXT.
                                nv_chkdoc = NO.
                                nv_msgbox = "พบ เลขตัวถังกับเลขทะเบียนซ้ำที่เลข Doc. " + nv_docno.
                                LEAVE loop_chkrecord.
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
                FIND tlt WHERE RECID(tlt) = nv_recidtlt NO-ERROR NO-WAIT.
                IF AVAIL tlt THEN DO:
                    nv_chknotes = "L".
                    tlt.comp_noti_ins = TRIM(SUBSTR(tlt.comp_noti_ins,1,20)) 
                                      + FILL(" ", 20 - LENGTH(TRIM(SUBSTR(tlt.comp_noti_ins,1,20))))
                                      + nv_chknotes.
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
                    chDocument:Fname       = fi_preinsur                         
                    chDocument:Lname       = fi_preinsur2                        
                    chDocument:phone1      = TRIM(SUBSTR(fi_insadd6tel,1,20))    
                    chDocument:PolicyNo    = fi_notno70                          
                    chDocument:agentCode   = fi_agent                            
                    chDocument:agentName   = nv_brname                           
                    chDocument:Premium     = fi_premium                          
                    chDocument:model       = nv_model                            
                    chDocument:modelCode   = nv_modelcode                        
                    chDocument:Year        = fi_year                             
                    chDocument:carCC       = fi_cha_no                           
                    chDocument:LicenseType = "รถเก๋ง/กระบะ/บรรทุก"               
                    chDocument:PatternLi1  = nv_pattern                          
                    chDocument:LicenseNo_1 = nv_licence1                         
                    chDocument:LicenseNo_2 = fi_provin                           
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
                                                                                                    
                FIND tlt WHERE RECID(tlt) = nv_recidtlt NO-ERROR NO-WAIT.                           
                IF AVAIL tlt THEN DO:      
                    nv_chknotes       = "L".
                    tlt.comp_noti_ins = TRIM(SUBSTR(tlt.comp_noti_ins,1,20))                        
                                      + FILL(" ", 20 - LENGTH(TRIM(SUBSTR(tlt.comp_noti_ins,1,20))))
                                      + nv_chknotes.                                                        
                END.                                                                                
                RELEASE tlt.                                                                        
                                                                                                    
                chUIDocument = chWorkSpace:CurrentDocument.                                         
                chUIDocument = chWorkSpace:EditDocument(FALSE,chDocument) NO-ERROR.                 
                                                                                                    
                nv_msgbox = "Create Record in Lotus Notes Complete !".                              
                                                                                                    
                DISABLE bu_notes WITH FRAME fr_main.                                                
            END.                                            
        END.
    END.
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
    /* End by Phaiboon W. [A59-0625] Date 22/12/206 */
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_product
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_product C-Win
ON CHOOSE OF bu_product IN FRAME fr_main
DO:
    Run  wgw\wgwhppro(Input-output  fi_product).
    Disp  fi_product   with frame  fr_main.                                     
    Apply "Entry"  To  fi_product.
    Return no-apply. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_quo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_quo C-Win
ON CHOOSE OF bu_quo IN FRAME fr_main /* Quotation */
DO:    
    n_chk = YES.
    RUN wgw\wgwqupoQ (INPUT  fi_quo,      INPUT-OUTPUT n_chk,
                      OUTPUT fi_brand,    OUTPUT fi_model,     OUTPUT fi_year,     
                      OUTPUT fi_power,    /* OUTPUT fi_licence1,  OUTPUT fi_licence2, */
                      /* OUTPUT fi_cha_no,   OUTPUT fi_eng_no, */    OUTPUT ra_driv,                      
                      OUTPUT fi_drivername1, OUTPUT fi_drivername2,
                      OUTPUT ra_sex1,        OUTPUT ra_sex2,
                      OUTPUT fi_hbdri1,      OUTPUT fi_hbdri2,
                      OUTPUT fi_agedriv1,    OUTPUT fi_agedriv2,
                      OUTPUT fi_occupdriv1,  OUTPUT fi_occupdriv2,
                      OUTPUT fi_idnodriv1,   OUTPUT fi_idnodriv2,
                      OUTPUT fi_pack,     OUTPUT fi_class,    OUTPUT fi_garage,
                      OUTPUT fi_sumsi,    OUTPUT fi_gap,      OUTPUT fi_premium,
                      OUTPUT fi_precomp,  OUTPUT fi_totlepre, OUTPUT fi_baseod).        

    IF n_chk = YES THEN DO:          
        DISP fi_brand       fi_model     fi_year     fi_power 
             /* fi_licence1    fi_licence2  fi_cha_no   fi_eng_no */
             ra_driv        fi_pack      fi_class    fi_garage
             fi_sumsi       fi_gap       fi_premium  fi_precomp
             fi_totlepre    fi_baseod
        WITH FRAME fr_main.
    
        DISP fi_drivername1   fi_drivername2   ra_sex1         ra_sex2 
             fi_hbdri1        fi_hbdri2        fi_agedriv1     fi_agedriv2
             fi_occupdriv1    fi_occupdriv2    fi_idnodriv1    fi_idnodriv2
        WITH FRAME fr_driv.
    
        IF ra_driv = 2 THEN DO:
            ASSIGN                  
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
                 fi_text10 WITH FRAME fr_driv.
        END.  
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_save
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_save C-Win
ON CHOOSE OF bu_save IN FRAME fr_main /* Save */
DO:
    /*IF fi_notno70 = "" THEN DO:
        APPLY "entry" TO fi_notno70.
        RETURN NO-APPLY.
    END.*/
    /*MESSAGE "Do you want SAVE  !!!!"        
    VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO     /*-CANCEL */    
    TITLE "" UPDATE choice AS LOGICAL.
    CASE choice:         
    WHEN TRUE THEN  /* Yes */ 
    DO: */
    IF fi_notno70 <> "" THEN DO:
        FIND LAST  tlt    WHERE 
            tlt.genusr        = "Phone"      AND
            tlt.policy        =  fi_notno70  NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL tlt THEN DO:
            IF tlt.nor_noti_tlt <> fi_notino  THEN DO:
                MESSAGE "Found policy70 duplicate...tlt: " + tlt.nor_noti_tlt VIEW-AS ALERT-BOX.
                APPLY "entry" TO fi_notno70.
                RETURN NO-APPLY.
            END.
        END.
    END.
    IF fi_notno72 <> "" THEN DO:
        FIND LAST  tlt    WHERE 
            tlt.genusr        = "Phone"  AND
            tlt.comp_pol      = trim(INPUT fi_notno72)   NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL tlt THEN DO:
            IF tlt.nor_noti_tlt <> fi_notino  THEN DO:
                MESSAGE "Found policy72 duplicate...tlt: " + tlt.nor_noti_tlt VIEW-AS ALERT-BOX.
                APPLY "entry" TO fi_notno72.
                RETURN NO-APPLY.
            END.
        END.
    END.

    /* Begin by Phaiboon W. [A59-0488] Date 15/11/2016 */
    n_quota = TRIM(fi_quo).
    n_quota = REPLACE(n_quota,"+","").
    n_quota = REPLACE(n_quota,"-","").
    n_quota = REPLACE(n_quota,"*","").
    n_quota = REPLACE(n_quota,".","").
    n_quota = REPLACE(n_quota,",","").

    IF LENGTH(n_quota) <= 4 THEN DO: 
        n_quota  = "".
        n_garage = "".
    END.
    ELSE DO:
        n_quota  = n_quota + FILL(" ", 20 - LENGTH(n_quota)).
        n_garage = co_garage.
        n_garage = n_garage + FILL(" ", 20 - LENGTH(n_garage)).
    END.
    /* End by Phaiboon W. [A59-0488] Date 15/11/2016 */

    /*FIND LAST  tlt    WHERE 
        tlt.nor_noti_tlt = fi_notino    AND
        tlt.genusr       = "Phone"      NO-ERROR NO-WAIT .*/
    Find  tlt  Where   Recid(tlt)  =  nv_recidtlt  NO-ERROR NO-WAIT .
    IF AVAIL tlt THEN DO: 
        /*CREATE tlt.*/
        ASSIGN 
            /*/*tlt.nor_noti_tlt  = fi_notino*/
            tlt.nor_usr_ins   = fi_ins_off
            tlt.lotno         = fi_comco 
            tlt.nor_noti_ins  = fi_cmrcode 
            tlt.nor_usr_tlt   = fi_cmrcode2
            tlt.trndat        = fi_notdat
            tlt.trntime       = fi_nottim
            tlt.subins        = fi_campaign
            tlt.safe1         = IF      ra_car  = 1 THEN "เก๋ง" 
            ELSE IF ra_car  = 2 THEN "กระบะ"    
                                ELSE    "โดยสาร" 
            tlt.safe2         = IF ra_cover  = 1 THEN "ป้ายแดง" 
                                ELSE  "use car" 
            tlt.safe3         = fi_cover1
            /*tlt.safe3         = IF fi_cover1 = 1 THEN "ป.1" 
                                  ELSE IF fi_cover1 = 2 THEN "ป.2"    
                                  ELSE IF fi_cover1 = 3 THEN "ป.3"  
                                  ELSE  "ป.5"*/                /*A55-0073*/
            tlt.stat          = fi_product                     /*A55-0073*/
            tlt.filler1       = IF ra_pree = 1 THEN "แถม"
                                               ELSE "ไม่แถม"
            tlt.filler2       = IF      ra_comp = 1 THEN "แถม"
                                ELSE IF ra_comp = 2 THEN "ไม่แถม"  
                                ELSE "ไม่เอาพรบ."
            tlt.comp_sub      = fi_producer        
            tlt.recac         = fi_agent 
            tlt.colorcod      = fi_cmrsty 
            tlt.policy        = fi_notno70       
            tlt.comp_pol      = fi_notno72
            tlt.ins_name      = trim(fi_institle )  + " " +    
                                trim(fi_preinsur )  + " " +      
                                trim(fi_preinsur2 )      
            /*tlt.ins_addr1     = Input fi_insaddr1*/ /*A55-0073*/
            tlt.ins_addr1     = trim((IF n_banno = "" THEN "" ELSE "เลขที่ " + TRIM(n_banno)) + " " +
                                     (IF n_muno  = "" THEN "" ELSE "หมู่ "   + TRIM(n_muno))  + " " +
                                     (IF n_build = "" THEN "" ELSE "อาคาร"  + TRIM(n_build)) + " " +
                                     (IF n_soy   = "" THEN "" ELSE "ซอย"    + TRIM(n_soy))   + " " + 
                                     (IF n_road  = "" THEN "" ELSE "ถนน"    + TRIM(n_road)))
            tlt.ins_addr2     = fi_insadd2tam      
            tlt.ins_addr3     = fi_insadd3amp      
            tlt.ins_addr4     = fi_insadd4cunt     
            tlt.ins_addr5     = fi_insadd5post   
            tlt.comp_noti_ins = fi_insadd6tel 
            tlt.nor_effdat    = fi_comdat        
            tlt.expodat       = fi_expdat
            tlt.dri_no2       = fi_ispno
            tlt.brand         = fi_brand            
            tlt.model         = fi_model
            tlt.lince2        = fi_year 
            tlt.cc_weight     = fi_power
            tlt.lince1        = fi_licence1 + " " +      
                                fi_licence2 + " " +      
                                fi_provin
            tlt.cha_no        = fi_cha_no
            tlt.eng_no        = fi_eng_no
            tlt.lince3        = fi_pack  +        
                                fi_class         
            tlt.exp           = fi_garage       
            tlt.nor_coamt     = fi_sumsi 
            tlt.dri_name2     = STRING( fi_gap )
            tlt.nor_grprm     = fi_premium  
            tlt.comp_coamt    = fi_precomp  
            tlt.comp_grprm    = fi_totlepre
            tlt.comp_sck      = fi_stk             
            tlt.comp_noti_tlt = fi_refer         
            tlt.rec_name      = fi_recipname  
            tlt.comp_usr_tlt  = fi_vatcode 
            tlt.expousr       = fi_user       
            tlt.comp_usr_ins  = fi_benname       
            tlt.OLD_cha       = USERID(LDBNAME(1))  + ":" + Input fi_remark1        
            tlt.OLD_eng       = IF ra_complete = 1 THEN "complete"
                                ELSE "not complete"
            tlt.genusr        = "Phone" .*/
            /*/*1 */tlt.nor_noti_tlt  = fi_notino      
            tlt.trndat        = fi_notdat                  
            tlt.trntime       = string(TIME,"HH:MM:SS")  */
            /*1 */  tlt.nor_usr_ins   = trim(fi_ins_off)  
            /*2 */  tlt.lotno         = trim(fi_comco)
            /*3 */  tlt.nor_noti_ins  = trim(fi_cmrcode) 
            /*4 */  tlt.nor_usr_tlt   = trim(fi_cmrcode2)   
            /*5 */  tlt.subins        = trim(fi_campaign)
            /*6 */  tlt.safe1         = /*IF      ra_car  = 1 THEN "เก๋ง"      
                                        ELSE IF ra_car  = 2 THEN "กระบะ"   
                                                            ELSE "โดยสาร" */
                                        co_caruse
            /*7 */   tlt.safe2        = IF      ra_cover  = 1 THEN "ป้ายแดง" 
                                        ELSE IF ra_cover  = 2 THEN "use car" 
                                                              ELSE "BIKE"
            /*8 */   tlt.safe3        = trim(fi_cover1)
            /*9 */   tlt.stat         = IF ra_pa = 1   THEN "" ELSE fi_product
            /*10*/   tlt.filler1      = IF ra_pree = 1 THEN "แถม"
                                                       ELSE "ไม่แถม"
            /*11*/   tlt.filler2      = IF ra_comp = 1 THEN "แถม"
                                        ELSE IF ra_comp = 2 THEN "ไม่แถม"  
                                        ELSE "ไม่เอาพรบ."
            /*12*/   tlt.comp_sub     = trim(fi_producer)        
            /*13*/   tlt.recac        = trim(fi_agent)
            /*14*/   tlt.colorcod     = caps(trim(fi_cmrsty)) 
            /*15*/   tlt.policy       = caps(trim(fi_notno70))       
            /*16*/   tlt.comp_pol     = caps(trim(fi_notno72))
            /*17*/   tlt.ins_name     = trim(fi_institle )  + " " +    
            /*18*/                      trim(fi_preinsur )  + " " +      
            /*19*/                      trim(fi_preinsur2 ).
            ASSIGN
            /*20*/   tlt.endno        = trim(fi_idno) 
            /*21*/   tlt.dat_ins_noti = fi_birthday    /*birthday*//*date */  
            /*22*/   tlt.seqno        = fi_age          /*age      *//*inte */ 
                     tlt.entdat       = fi_idnoexpdat
            /*23*/   tlt.flag         = trim(fi_occup)       /*occupn   */  
            /*24*/   tlt.usrsent      = trim(fi_namedrirect) /*name direct */  
            /*25*/   tlt.ins_addr1    = /*IF ra_ban = 1 THEN 
                                  trim((IF n_banno = "" THEN "" ELSE "เลขที่ " + TRIM(n_banno)) + " " +  
            /*26*/                     (IF n_muno  = "" THEN "" ELSE "หมู่ "   + TRIM(n_muno))  + " " +
            /*27*/                     (IF n_soy   = "" THEN "" ELSE "ซอย"     + TRIM(n_soy))   + " " +  
            /*28*/                     (IF n_road  = "" THEN "" ELSE "ถนน"     + TRIM(n_road)))  
                                   ELSE IF ra_ban  = 2 THEN 
                                  trim((IF n_banno = "" THEN "" ELSE "เลขที่ " + TRIM(n_banno)) + " " +  
            /*29*/                     (IF n_muno  = "" THEN "" ELSE "หมู่ "   + TRIM(n_muno))  + " " +
                                /*26*/ (IF n_build = "" THEN "" ELSE "อาคาร"   + n_build )      + " " +  
                                       (IF n_soy   = "" THEN "" ELSE "ซอย"     + TRIM(n_soy))   + " " +  
            /*30*/                     (IF n_road  = "" THEN "" ELSE "ถนน"     + TRIM(n_road)))  
                                   ELSE      /*ra_ban = 3*/*/
                                  trim((IF n_banno = "" THEN "" ELSE "เลขที่ " + TRIM(n_banno) + " " )  + 
            /*31*/                     (IF n_muno  = "" THEN "" ELSE "หมู่ "   + TRIM(n_muno)  + " " )  + 
                                       /*(IF n_build = "" THEN "" ELSE "หมู่บ้าน"  + n_build )    + " " + */ 
                                       (IF (co_addr + trim(n_build)) = "" THEN "" 
                                             ELSE  (co_addr + trim(n_build))  + " " )  + 
                                       (IF n_soy   = "" THEN "" ELSE "ซอย"     + TRIM(n_soy) + " " )  +     
            /*  */                     (IF n_road  = "" THEN "" ELSE "ถนน"     + TRIM(n_road))) 
            /*Kridtiya i. A55-0125*/
            /*32*/   tlt.ins_addr2     = trim(fi_insadd2tam)     
            /*33*/   tlt.ins_addr3     = TRIM(fi_insadd3amp)     
            /*34*/   tlt.ins_addr4     = TRIM(fi_insadd4cunt)     
            /*35*/   tlt.ins_addr5     = TRIM(fi_insadd5post)   
                     /* tlt.comp_noti_ins = TRIM(fi_insadd6tel) Comment by Phaiboon W. [A59-0625] DAte 22/12/2016  */

            /*36*/   tlt.comp_noti_ins = TRIM(fi_insadd6tel) + FILL(" ", 20 - LENGTH(TRIM(fi_insadd6tel))) + nv_chknotes /* Add by Phaiboon W. [A59-0625] DAte 22/12/2016 */
                                                               
            /*37*/   tlt.dri_name1     = IF ra_driv = 1 THEN ""
                                         ELSE IF trim(fi_drivername1) = "" THEN ""
                                         ELSE  trim(fi_drivername1) + " sex:" + string(ra_sex1)  + " hbd:" + STRING(fi_hbdri1) + " age:" +  string(fi_agedriv1) + " occ:" + trim(fi_occupdriv1) 
            /*38*/   tlt.dri_no1       = IF ra_driv = 1 THEN ""
                                         ELSE trim(fi_idnodriv1) 
            /*39*/   tlt.enttim        = IF ra_driv = 1 THEN ""
                                         ELSE IF trim(fi_drivername2) = "" THEN ""
                                         ELSE  trim(fi_drivername2) + " sex:" + string(ra_sex2)  + " hbd:" + STRING(fi_hbdri2) + "age:" +  string(fi_agedriv2) + "occ:" + trim(fi_occupdriv2) 
            /*40*/   tlt.expotim       = IF ra_driv = 1 THEN ""
                                         ELSE trim(fi_idnodriv2)
            /*41*/   tlt.nor_effdat    = INPUT fi_comdat         
            /*42*/   tlt.expodat       = Input fi_expdat
            /* /*43*/   tlt.dri_no2       = trim(fi_ispno) */
            /*43*/   tlt.dri_no2       = TRIM(fi_ispno) + FILL(" ", 50 - LENGTH(TRIM(fi_ispno))) + fi_ispstatus /* add by Phaiboon W. [A59-0488] Date 30/11/2016 */
            /*44*/   tlt.brand         = TRIM(fi_brand)           
            /*45*/   tlt.model         = trim(Input fi_model)
            /*46*/   tlt.lince2        = trim(Input fi_year) 
            /*47*/   tlt.cc_weight     = INPUT fi_power
            /*48*/   tlt.lince1        = trim(fi_licence1) + " " +      
            /*49*/                       trim(fi_licence2) + " " +      
            /*50*/                       trim(fi_provin)
            /*51*/   tlt.cha_no        = trim(fi_cha_no)
            /*52*/   tlt.eng_no        = trim(fi_eng_no)
            /*53*/   tlt.lince3        = trim(fi_pack)  +        
            /*54*/                       trim(fi_class)         
            /*55*/   tlt.exp           = trim(fi_garage)       
            /*56*/   tlt.nor_coamt     = fi_sumsi 
            /*57*/   tlt.dri_name2     = STRING(fi_gap )
            /*58*/   tlt.nor_grprm     = fi_premium  
            /*59*/   tlt.comp_coamt    = fi_precomp  
            /*60*/   tlt.comp_grprm    = fi_totlepre
            /*61*/   tlt.comp_sck      = trim(fi_stk)
            /*62*/   tlt.comp_noti_tlt = trim(fi_refer)         
            /*63*/   tlt.rec_name      = trim(fi_recipname)  
            /*64*/   tlt.comp_usr_tlt  = trim(fi_vatcode) 
            /*65*/   tlt.expousr       = trim(fi_user)
            /*66*/   tlt.comp_usr_ins  = trim(fi_benname)   
                     /*tlt.comp_usr_ins = co_benname*/

                    /* Begin by Phaiboon W. [A59-0488] Date 11/10/2016 */
            /* /*67*/   tlt.OLD_cha       = USERID(LDBNAME(1))  + ":" + trim(fi_remark1) */
                     n_remark1         = USERID(LDBNAME(1))  + " : " + TRIM(fi_remark1)  
                     n_remark1         = n_remark1 + FILL(" ", 100 - LENGTH(n_remark1))

                     n_remark2         = TRIM(fi_remark2)                              
                     n_remark2         = n_remark2 + FILL(" ", 100 - LENGTH(n_remark2))
                        
                     n_other1          = "อุปกรณ์เสริมคุ้มครองไม่เกิน"
                     n_other1          = n_other1 + FILL(" ", 50 - LENGTH(n_other1))
                     n_other2          = STRING(fi_other2) + FILL(" " , 10 - LENGTH(STRING(fi_other2))) 
                     n_other3          = STRING(fi_other3) + FILL(" " , 60 - LENGTH(STRING(fi_other3)))
                                                                                                                                 
                     tlt.OLD_cha       = n_remark1 + n_remark2 + n_other1 + n_other2 + n_other3 + n_quota + n_garage
                    /* End by Phaiboon W. [A59-0488] Date 11/10/2016 */

            /*68*/   tlt.OLD_eng       = IF ra_complete = 1 THEN "complete"
                                         ELSE "not complete"
                     tlt.rec_addr4     = TRIM(fi_deler)           /*A56-0024*/
            /*  */   tlt.genusr        = "Phone"  
            /*/*  */   tlt.usrid         = USERID(LDBNAME(1)) */  /*User Load Data *//*ฤ55-0108*/
            /*  */   tlt.imp           = "IM"                     /*Import Data*/
            /*  */   tlt.releas        = "No"
                     tlt.endno         = fi_idno 
            /*  */   tlt.dat_ins_noti  = fi_birthday    /*birthday*//*date */  
            /*  */   tlt.seqno         = fi_age         /*age      *//*inte */           
            /*  */   tlt.flag          = fi_occup       /*occupn   */  
            /*  */   tlt.usrsent       = fi_namedrirect /*name direct */
                    /* tlt.rec_addr5     = IF      co_caruse = "BIKE(บุคคล)"    THEN STRING(fi_baseod)      /*A57-0063*/
                                         ELSE IF co_caruse = "BIKE(พาณิชย์)"  THEN STRING(fi_baseod) 
                                         ELSE "0" .  */
                     tlt.rec_addr5     =  STRING(fi_baseod) .                                                                                            
    END.
    ELSE DO: 
        MESSAGE "found policy no duplicate...tlt" VIEW-AS ALERT-BOX.
        APPLY "entry" TO fi_remark1.
        Return no-apply.
    END.
    MESSAGE "SAVE COMPLETE....   "  SKIP
        "Do you want EXIT now...  !!!!"         SKIP
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
            /*Apply "Close" to this-procedure.
            Return no-apply.*/
           /*comment kridtiya i. A55-0108....
            APPLY "entry" TO fi_notno70.
            RETURN NO-APPLY. 
        END.
        
        WHEN FALSE THEN /* No */          
            DO:   
            /*APPLY "entry" TO fi_covcod.*/
            RETURN NO-APPLY.
        END.
        /*OTHERWISE /* Cancel */             
        STOP.*/
        END CASE. 
        comment kridtiya i. A55-0108..*/
/*Disp  fi_pack with  frame  fr_main.*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME co_addr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL co_addr C-Win
ON VALUE-CHANGED OF co_addr IN FRAME fr_main
DO:
    co_addr = INPUT co_addr.
    DISP co_addr WITH FRAM fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME co_benname
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL co_benname C-Win
ON VALUE-CHANGED OF co_benname IN FRAME fr_main
DO:
    co_benname = INPUT co_benname .
    ASSIGN fi_benname = INPUT co_benname
        co_benname = "" .
  /*IF co_benname = "" THEN DO:
      APPLY "entry" TO fi_user2.
      RETURN NO-APPLY.
  END.*/
  DISP co_benname fi_benname WITH FRAM fr_main.
  
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
    IF  nv_cartyp = "เก๋ง" THEN DO:
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
    END.
    DISP co_caruse  fi_pack fi_class fi_benname fi_garage  WITH FRAM fr_main.
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
    DISP co_garage WITH FRAM fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_age
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_age C-Win
ON LEAVE OF fi_age IN FRAME fr_main
DO:
 /* fi_age = INPUT fi_age.
  DISP fi_age WITH FRAM fr_main.*/
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
&Scoped-define SELF-NAME fi_agent
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_agent C-Win
ON LEAVE OF fi_agent IN FRAME fr_main
DO:
    fi_agent  = caps(INPUT fi_agent).
    DISP fi_agent WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_baseod
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_baseod C-Win
ON LEAVE OF fi_baseod IN FRAME fr_main
DO:
    fi_baseod = INPUT fi_baseod.
    DISP fi_baseod WITH FRAM fr_main. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_benname
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_benname C-Win
ON LEAVE OF fi_benname IN FRAME fr_main
DO:
    fi_benname =  Input  fi_benname.
    Disp  fi_benname with frame  fr_main. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_birthday
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_birthday C-Win
ON LEAVE OF fi_birthday IN FRAME fr_main
DO:
    fi_birthday = INPUT fi_birthday.
    IF year(fi_birthday) <= YEAR(TODAY) THEN DO:
        MESSAGE "กรุณา ใส่ปีเกิดเป็น ปี พ.ศ....!!!" VIEW-AS ALERT-BOX.
        APPLY "entry" TO fi_birthday.
        RETURN NO-APPLY.
    END.
    ELSE DO: 
        ASSIGN fi_age = (YEAR(TODAY) + 543) - year(fi_birthday).
        DISP fi_birthday fi_age WITH FRAM fr_main.
        APPLY "entry" TO fi_idnoexpdat.
        RETURN NO-APPLY.
    END.
    DISP fi_birthday fi_age WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_brand
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_brand C-Win
ON LEAVE OF fi_brand IN FRAME fr_main
DO:
    fi_brand = caps(INPUT fi_brand ).
    IF ra_cover = 1 THEN DO:   /*new car */
        IF TRIM(fi_brand) = "isuzu" THEN ASSIGN fi_pack = "V".
        ELSE IF TRIM(fi_brand) = "hondda" THEN ASSIGN fi_pack = "H".
        ELSE IF TRIM(fi_brand) = "toyota" THEN ASSIGN fi_pack = "X".
        ELSE ASSIGN fi_pack = "Z".
    END.
    ELSE ASSIGN fi_pack = "Z".  /*use car */

    DISP fi_brand WITH FRAM fr_main.
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


&Scoped-define SELF-NAME fi_cmrcode
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_cmrcode C-Win
ON LEAVE OF fi_cmrcode IN FRAME fr_main
DO:
  fi_cmrcode = INPUT fi_cmrcode.
  DISP fi_cmrcode WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_cmrcode2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_cmrcode2 C-Win
ON LEAVE OF fi_cmrcode2 IN FRAME fr_main
DO:
  fi_cmrcode2 = INPUT fi_cmrcode2.
  DISP fi_cmrcode2 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_cmrsty
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_cmrsty C-Win
ON LEAVE OF fi_cmrsty IN FRAME fr_main
DO:
  fi_cmrsty = caps(INPUT fi_cmrsty)  .
  ASSIGN fi_cmrsty = caps(fi_cmrsty) 
  n_brsty   = caps(fi_cmrsty).
  APPLY "entry" TO fi_notno70.
  RETURN NO-APPLY.
  DISP fi_cmrsty WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_comco
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_comco C-Win
ON LEAVE OF fi_comco IN FRAME fr_main
DO:   
    fi_comco = caps(INPUT fi_comco).
    IF fi_comco <> "" THEN DO:
        FIND FIRST company WHERE Company.CompNo = fi_comco  NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL company THEN  
            MESSAGE "Not found Company code...!!!"    SKIP
            "Plese Set up Company code. !!!"  VIEW-AS ALERT-BOX.
        ELSE DO:
            ASSIGN 
                fi_benname = Company.Name2      /*A56-0024*/
                nv_benname = Company.Name2 .    /*A56-0024*/ 
            IF ra_cover = 1 THEN                   
                ASSIGN 
                fi_producer = company.Text1     /*A56-0024*/
                fi_agent    = company.Text4 .      
            ELSE                                   
                ASSIGN 
                    fi_producer = company.Text2    /*A56-0024*/
                    fi_agent    = company.Text4 .  /*A56-0024*/
            /*comment by kridtiya i. A56-0024....
            IF fi_comco = "scb" THEN DO:
                /*ASSIGN fi_benname = "ธนาคารไทยพาณิชย์ จำกัด (มหาชน)".*/
                IF ra_cover = 1 THEN
                    ASSIGN 
                    fi_producer  = "B3M0009"
                    fi_agent     = "B3M0009".
                ELSE ASSIGN 
                    fi_producer  = "B3M0010"
                    fi_agent   = "B3M0009"  .
            END.
            ELSE IF fi_comco = "aycal" THEN DO:
                /*ASSIGN fi_benname = "บริษัท อยุธยา แคปปิตอล ออโต้ลิส จำกัด(มหาชน)" .*/
                IF ra_cover = 1 THEN
                    ASSIGN 
                    fi_producer = "A0M0061"
                    fi_agent  = "B300303".
                ELSE ASSIGN 
                    fi_producer = "A0M1011"
                    fi_agent  = "B300303" .
            END.
            ELSE IF fi_comco = "TCR" THEN DO:
                /*ASSIGN fi_benname = "ธนาคาร ไทยเครดิต เพื่อรายย่อย จำกัด (มหาชน)".*/
                IF ra_cover = 1 THEN
                    ASSIGN 
                    fi_producer = "B3M0013"
                    fi_agent  = "B3M0013".
                ELSE ASSIGN 
                    fi_producer = "B3M0014"
                    fi_agent  = "B3M0013".
            END.
            ELSE IF fi_comco = "ASK" THEN DO:
                /*ASSIGN fi_benname = "บริษัท เอเซียเสริมกิจลีสซิ่ง จำกัด (มหาชน)".*/
                IF ra_cover = 1 THEN
                    ASSIGN 
                    fi_producer = "A0M1004"
                    fi_agent  = "B300303".
                ELSE ASSIGN 
                    fi_producer = "A0M1004"
                    fi_agent  = "B300303"  .
            END.
            ELSE IF fi_comco = "BGPL" THEN DO:
                /*ASSIGN fi_benname = "บริษัท กรุงเทพแกรนด์แปซิฟิคลีส จำกัด ( มหาชน)".*/
                IF ra_cover = 1 THEN
                    ASSIGN 
                    fi_producer = "A000774"
                    fi_agent  = "B300303".
                ELSE ASSIGN 
                    fi_producer = "A000774"
                    fi_agent  = "B300303" .
            END.
            ELSE IF fi_comco = "RTN" THEN DO:
                /*ASSIGN fi_benname = "บริษัท ราชธานี ลีสซิ่ง จำกัด (มหาชน)".*/
                IF ra_cover = 1 THEN
                    ASSIGN 
                    fi_producer = "A0M0069"
                    fi_agent  = "B300303".
                ELSE ASSIGN 
                    fi_producer = "A0M1002"
                    fi_agent  = "B300303".
            END.
            ELSE ASSIGN 
                fi_producer  = ""
                fi_agent   = ""
                fi_benname = "" .
                end...comment BY kridtiya i. A56-0024...*/
        END.
    END.
    /*IF fi_comco <> "" AND (string(fi_notdat) <> "" ) THEN DO:
        ASSIGN fi_notino  = CAPS(fi_comco) + trim(STRING(fi_notdat,"99/99/9999")) + string(TIME,"HH:MM:SS").
        DISP fi_notino WITH FRAM fr_main. 
    END.
    ELSE DO:
        ASSIGN fi_notino  = ""
               fi_benname = "" .
        DISP fi_notino fi_benname  WITH FRAM fr_main. 
    END.*/
    DISP  fi_comco fi_producer fi_agent fi_benname WITH FRAM fr_main.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_comdat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_comdat C-Win
ON LEAVE OF fi_comdat IN FRAME fr_main
DO:
  fi_comdat = INPUT fi_comdat.

  /*fi_expdat = DATE(STRING(DAY(fi_comdat),"99") + "/" +
                   STRING(MONTH(fi_comdat),"99") + "/" +
                   string(year(fi_comdat) + 1 ,"9999")).*/
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
    ASSIGN fi_benname   = nv_benname .    /*A56-0024*/
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
    /* End by Phaiboon W. [A59-0488] Date 07/11/2016 */
    

    /*Add kridtiya i.A55-0108 */
    Disp  fi_cover1 fi_pack fi_benname fi_ispstatus with frame  fr_main. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_deler
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_deler C-Win
ON LEAVE OF fi_deler IN FRAME fr_main
DO:
    fi_deler  = caps(INPUT fi_deler).
    DISP fi_deler WITH FRAM fr_main.
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


&Scoped-define FRAME-NAME fr_main
&Scoped-define SELF-NAME fi_idno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_idno C-Win
ON LEAVE OF fi_idno IN FRAME fr_main
DO:
    fi_idno  = INPUT fi_idno.

    DISP fi_idno WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fr_driv
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
&Scoped-define SELF-NAME fi_idnoexpdat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_idnoexpdat C-Win
ON LEAVE OF fi_idnoexpdat IN FRAME fr_main
DO:
    fi_idnoexpdat = INPUT fi_idnoexpdat.
    IF year(fi_idnoexpdat) <= YEAR(TODAY) THEN DO:
        MESSAGE "กรุณา ใส่ปีเกิดเป็น ปี พ.ศ....!!!" VIEW-AS ALERT-BOX.
        APPLY "entry" TO fi_idnoexpdat.
        RETURN NO-APPLY.
    END.
    DISP fi_idnoexpdat  WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_insadd1build
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_insadd1build C-Win
ON LEAVE OF fi_insadd1build IN FRAME fr_main
DO:
    fi_insadd1build  = INPUT fi_insadd1build.
    ASSIGN n_build = fi_insadd1build .
/*
    IF  ra_ban  = 1  THEN  ASSIGN n_build = "อาคาร" + fi_insadd1build .
    ELSE ASSIGN n_build = "หมู่บ้าน"  + fi_insadd1build .*/
    DISP fi_insadd1build WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_insadd1mu
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_insadd1mu C-Win
ON LEAVE OF fi_insadd1mu IN FRAME fr_main
DO:
    fi_insadd1mu  = INPUT fi_insadd1mu.
    ASSIGN n_muno = fi_insadd1mu .
    DISP fi_insadd1mu WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_insadd1no
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_insadd1no C-Win
ON LEAVE OF fi_insadd1no IN FRAME fr_main
DO:
    fi_insadd1no  = INPUT fi_insadd1no.
    ASSIGN n_banno = fi_insadd1no .
    DISP fi_insadd1no WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_insadd1road
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_insadd1road C-Win
ON LEAVE OF fi_insadd1road IN FRAME fr_main
DO:
    fi_insadd1road  = INPUT fi_insadd1road.
    ASSIGN n_road = fi_insadd1road .
    DISP fi_insadd1road WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_insadd1soy
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_insadd1soy C-Win
ON LEAVE OF fi_insadd1soy IN FRAME fr_main
DO:
    fi_insadd1soy  = INPUT fi_insadd1soy.
    ASSIGN n_soy = fi_insadd1soy .
    DISP fi_insadd1soy WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_insadd2tam
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_insadd2tam C-Win
ON LEAVE OF fi_insadd2tam IN FRAME fr_main
DO:
    fi_insadd2tam  = INPUT fi_insadd2tam.
    DISP fi_insadd2tam WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_insadd3amp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_insadd3amp C-Win
ON LEAVE OF fi_insadd3amp IN FRAME fr_main
DO:
  fi_insadd3amp = INPUT fi_insadd3amp.
  DISP fi_insadd3amp WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_insadd4cunt
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_insadd4cunt C-Win
ON LEAVE OF fi_insadd4cunt IN FRAME fr_main
DO:
  fi_insadd4cunt  = INPUT fi_insadd4cunt.
  DISP fi_insadd4cunt WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_insadd5post
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_insadd5post C-Win
ON LEAVE OF fi_insadd5post IN FRAME fr_main
DO:
  fi_insadd5post  = INPUT fi_insadd5post.
  DISP fi_insadd5post WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_insadd6tel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_insadd6tel C-Win
ON LEAVE OF fi_insadd6tel IN FRAME fr_main
DO:
  fi_insadd6tel  = INPUT fi_insadd6tel.
  DISP fi_insadd6tel WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_institle
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_institle C-Win
ON LEAVE OF fi_institle IN FRAME fr_main
DO:
  fi_institle = INPUT fi_institle.
  DISP fi_institle WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_ins_off
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_ins_off C-Win
ON LEAVE OF fi_ins_off IN FRAME fr_main
DO:
    fi_ins_off = INPUT fi_ins_off.
    DISP fi_ins_off WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


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


&Scoped-define SELF-NAME fi_namedrirect
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_namedrirect C-Win
ON LEAVE OF fi_namedrirect IN FRAME fr_main
DO:
  fi_namedrirect = INPUT fi_namedrirect.
  DISP fi_namedrirect WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_notno70
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_notno70 C-Win
ON LEAVE OF fi_notno70 IN FRAME fr_main
DO:
    fi_notno70 = caps(INPUT fi_notno70) .
    IF (fi_notno70  <> "")  THEN DO:
        IF length(TRIM(fi_cmrsty)) = 1 THEN DO:
            IF substr(TRIM(fi_notno70),2,1) <> TRIM(fi_cmrsty) THEN MESSAGE "สาขา" + TRIM(fi_cmrsty) + "ไม่ตรงกับ เลขกรมธรรม์!!!" VIEW-AS ALERT-BOX.
        END.
        ELSE DO:
            IF substr(TRIM(fi_notno70),1,2) <> TRIM(fi_cmrsty) THEN MESSAGE "สาขา" + TRIM(fi_cmrsty) + "ไม่ตรงกับ เลขกรมธรรม์!!!" VIEW-AS ALERT-BOX.
        END.
        FIND LAST  tlt    WHERE 
            (tlt.genusr        = "Phone"        OR
             tlt.genusr        = "FAX"  )       AND
            tlt.policy        =  fi_notno70     NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL tlt THEN DO:
            IF tlt.nor_noti_tlt <> fi_notino  THEN DO:
                MESSAGE "Found policy70 duplicate..BY: " + tlt.genusr + " " + tlt.nor_noti_tlt VIEW-AS ALERT-BOX.
                APPLY "entry" TO fi_notno70.
                RETURN NO-APPLY.
            END.
        END.
        ELSE DO: 
            FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE 
                sicuw.uwm100.policy = trim( INPUT fi_notno70 ) NO-LOCK NO-ERROR.
            IF AVAIL sicuw.uwm100 THEN DO:
                IF  (sicuw.uwm100.name1 <> "") OR (sicuw.uwm100.comdat <> ? ) THEN DO:
                    MESSAGE "พบเลขกรมธรรม์นี้ในระบบ Premium !!!" VIEW-AS ALERT-BOX.
                    APPLY "entry" TO fi_notno70.
                    RETURN NO-APPLY.
                END.
            END.
            RUN proc_create70.   /* A55-0108 */
        END.
    END.
    DISP fi_notno70 WITH FRAM fr_main. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_notno72
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_notno72 C-Win
ON LEAVE OF fi_notno72 IN FRAME fr_main
DO:
    fi_notno72 = caps(INPUT fi_notno72) .
    IF (fi_notno72  <> "") THEN DO:
        FIND LAST  tlt    WHERE 
            (tlt.genusr        = "Phone"           OR
             tlt.genusr        = "FAX"  )          AND
             tlt.comp_pol      = INPUT fi_notno72   NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL tlt THEN DO:
            IF tlt.nor_noti_tlt <> fi_notino  THEN DO:
                MESSAGE "Found policy72 duplicate...BY: " +  tlt.genusr + " " + tlt.nor_noti_tlt VIEW-AS ALERT-BOX.
                APPLY "entry" TO fi_notno72.
                RETURN NO-APPLY.
            END.
        END.
        ELSE DO:
            FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE 
                sicuw.uwm100.policy = trim( INPUT fi_notno72 ) NO-LOCK NO-ERROR.
            IF AVAIL sicuw.uwm100 THEN DO:
                IF  (sicuw.uwm100.name1 <> "") OR (sicuw.uwm100.comdat <> ? ) THEN DO:
                    MESSAGE "พบเลขกรมธรรม์นี้ในระบบ Premium !!!" VIEW-AS ALERT-BOX.
                    APPLY "entry" TO fi_notno72.
                    RETURN NO-APPLY.
                END.
            END.
            RUN proc_create72.   /* A55-0108 */
        END.
    END.
    DISP fi_notno72 WITH FRAM fr_main. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_occup
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_occup C-Win
ON LEAVE OF fi_occup IN FRAME fr_main
DO:
  fi_occup = INPUT fi_occup.
  DISP fi_occup WITH FRAM fr_main.
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
    APPLY "Entry" TO fi_user.
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


&Scoped-define SELF-NAME fi_preinsur
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_preinsur C-Win
ON LEAVE OF fi_preinsur IN FRAME fr_main
DO:
  fi_preinsur = INPUT fi_preinsur.
  DISP fi_preinsur WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_preinsur2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_preinsur2 C-Win
ON LEAVE OF fi_preinsur2 IN FRAME fr_main
DO:
  fi_preinsur2 = INPUT fi_preinsur2.
  DISP fi_preinsur2 WITH FRAM fr_main.
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


&Scoped-define SELF-NAME fi_producer
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_producer C-Win
ON LEAVE OF fi_producer IN FRAME fr_main
DO:
    fi_producer  = caps(INPUT fi_producer).
    DISP fi_producer WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_product
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_product C-Win
ON LEAVE OF fi_product IN FRAME fr_main
DO:
    fi_product = INPUT fi_product.
    IF ((INPUT fi_product) <> "" ) AND (ra_pa = 1) THEN DO:
        MESSAGE "กรุณาเลือก ขาย PA "   VIEW-AS ALERT-BOX.
        ASSIGN fi_product = "".
        APPLY "entry" TO ra_pa.
        RETURN NO-APPLY.   
    END.
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
    /*
    fi_quo = INPUT fi_quo.
    IF fi_quo <> "" THEN 
        DISABLE fi_notno72 WITH FRAME fr_main.   
    ELSE ENABLE fi_notno72 WITH FRAME fr_main.
    */
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_recipname
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_recipname C-Win
ON LEAVE OF fi_recipname IN FRAME fr_main
DO:
  fi_recipname =  Input  fi_recipname.
  Disp  fi_recipname with frame  fr_main. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_refer
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_refer C-Win
ON LEAVE OF fi_refer IN FRAME fr_main
DO:
  fi_refer  = INPUT fi_refer.
  DISP fi_refer WITH FRAM fr_main.
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


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_remark1 C-Win
ON RETURN OF fi_remark1 IN FRAME fr_main
DO:
    APPLY "Entry" TO fi_remark2.
    RETURN NO-APPLY.
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


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_remark2 C-Win
ON RETURN OF fi_remark2 IN FRAME fr_main
DO:
    APPLY "Entry" TO ra_complete.
    RETURN NO-APPLY.
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


&Scoped-define SELF-NAME fi_sumsi
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_sumsi C-Win
ON LEAVE OF fi_sumsi IN FRAME fr_main
DO:
    fi_sumsi  = INPUT fi_sumsi.
  DISP fi_sumsi  WITH FRAM fr_main. 
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


&Scoped-define SELF-NAME fi_user
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_user C-Win
ON LEAVE OF fi_user IN FRAME fr_main
DO:
  fi_user =  Input  fi_user.
  Disp  fi_user with frame  fr_main.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_vatcode
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_vatcode C-Win
ON LEAVE OF fi_vatcode IN FRAME fr_main
DO:
    fi_vatcode  = caps( INPUT fi_vatcode ).
    DISP fi_vatcode WITH FRAM fr_main. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_vatcode C-Win
ON RETURN OF fi_vatcode IN FRAME fr_main
DO:
    APPLY "Entry" TO fi_other2.
    RETURN NO-APPLY.
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
    ra_cover = INPUT ra_cover .
    IF ra_cover = 1 THEN                  /*A56-0024*/  
        ASSIGN 
        /*fi_pack = "G"*/
        fi_producer = n_producernew  
        fi_agent    = n_agent    .
    ELSE IF ra_cover = 3 THEN            /*Bike A57-0063*/
        ASSIGN 
        /*fi_pack = "Z"*/
        fi_producer = n_producerbike
        fi_agent    = n_agent    .
    ELSE 
        ASSIGN 
            fi_producer = n_produceruse 
            fi_agent    = n_agent    .   /*A56-0024*/
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
    DISP ra_cover fi_comco fi_producer fi_agent fi_pack  WITH FRAM fr_main. 
    /*
    APPLY "ENTRY" TO fi_cover1.
    RETURN NO-APPLY.
    */

    /* Begin by Phaiboon W. [A59-0488] Date 07/11/2016 */
    IF (nv_cartyp = "BIKE(บุคคล)") OR (nv_cartyp = "BIKE(พาณิชย์)")  THEN ASSIGN fi_pack = "Z" .
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
       
    Disp  fi_cover1 fi_pack fi_benname fi_ispstatus  with frame  fr_main. 

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
        ASSIGN 
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
             fi_text10 WITH FRAME fr_driv.
        DISABLE ALL WITH FRAME fr_driv.
        DISABLE  
        fi_text1 fi_text2  fi_text3 fi_text4 fi_text5  fi_text6  fi_text7 fi_text8 fi_text9 fi_text10 
        fi_drivername1 ra_sex1 fi_hbdri1 fi_occupdriv1  fi_idnodriv1
        fi_drivername2 ra_sex2 fi_hbdri2 fi_occupdriv2  fi_idnodriv2 WITH FRAM fr_driv. 
    END.
    ELSE DO:
        ASSIGN                  
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
             fi_text10 WITH FRAME fr_driv.
     /* ENABLE  
          fi_text1 fi_text2  fi_text3 fi_text4 fi_text5  fi_text6  fi_text7 fi_text8 fi_text9 fi_text10
          fi_drivername1 ra_sex1 fi_hbdri1 fi_occupdriv1  fi_idnodriv1
          fi_drivername2 ra_sex2 fi_hbdri2 fi_occupdriv2  fi_idnodriv2 WITH FRAM fr_driv.*/
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ra_pa
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_pa C-Win
ON VALUE-CHANGED OF ra_pa IN FRAME fr_main
DO:
  ra_pa = INPUT ra_pa.
  IF ra_pa = 1 THEN
      ASSIGN fi_product = "" .
  ELSE ASSIGN fi_product = "PA1" . 
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
        gv_prgid = "wgwqupo2" 
        gv_prog  = "UPDATE  DATA BY TELEPHONE ...".
    RUN  WUT\WUTHEAD ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).
    /*********************************************************************/ 
    /*  RUN Wut\WutwiCen ({&WINDOW-NAME}:HANDLE). */ 
    /*CURRENT-WINDOW:WINDOW-STATE = WINDOW-MAXIMIZED.*/
    SESSION:DATA-ENTRY-RETURN = YES.
    /*RECT-343:Move-to-top().
    RECT-344:Move-to-top().
    RECT-480:Move-to-top(). 
    RECT-481:Move-to-top().
    RECT-482:Move-to-top().
    RECT-488:Move-to-top().*/
    /*Rect-336:Move-to-top().*/
    /*co_provin = vAcProc_fil.*/
    /*------------------------*/
    /*RUN proc_provin.*/
    /*------------------------*/
    Find  tlt  Where   Recid(tlt)  =  nv_recidtlt NO-LOCK NO-ERROR NO-WAIT .
    If  avail  tlt  Then do:                        
        ASSIGN                        
            nv_check70    = "no"
            nv_check72    = "no"
            n_brsty       =  tlt.colorcod  
            fi_notino     =  tlt.nor_noti_tlt
            fi_notdat     =  tlt.trndat       
            fi_nottim     =  tlt.trntime  
            fi_ins_off    =  tlt.nor_usr_ins 
            fi_comco      =  tlt.lotno    
            fi_cmrcode    =  tlt.nor_noti_ins
            fi_cmrcode2   =  tlt.nor_usr_tlt  
            fi_campaign   =  tlt.subins
            /*comment by A57-0063....
            ra_car        =  IF      tlt.safe1 = "เก๋ง"    THEN 1 
                             ELSE IF tlt.safe1 = "กระบะ"   THEN 2 ELSE 3*/
            ra_cover      =  IF      tlt.safe2 = "ป้ายแดง" THEN 1 
                             /*ELSE IF tlt.safe2 = "use car" THEN 2*/  
                             ELSE IF tlt.safe2 = "bike"    THEN 3  
                                                           ELSE 2 

            /*ra_cover2   =  IF      tlt.safe3 = "ป.1"     THEN 1       
                             ELSE IF tlt.safe3 = "ป.2"     THEN 2
                             ELSE 3  
            end...A57-0063....*/
            fi_cover1     =  tlt.safe3 
            ra_pa         =  IF tlt.stat  = "" THEN 1 ELSE 2
            fi_product    =  tlt.stat
            ra_pree       =  IF      trim(tlt.filler1) = "แถม"    THEN 1 ELSE 2
            ra_comp       =  IF      trim(tlt.filler2) = "แถม"    THEN 1 
                             ELSE IF trim(tlt.filler2) = "ไม่แถม" THEN 2 
                             ELSE 3
            fi_producer   =  tlt.comp_sub     
            fi_agent      =  tlt.recac 
            n_producernew =  tlt.comp_sub  
            n_produceruse =  tlt.comp_sub  
            n_producerbike = tlt.comp_sub  /*a57-0063*/
            n_agent       =  tlt.recac      
            fi_deler      =  tlt.rec_addr4       
            fi_cmrsty     =  tlt.colorcod     
            fi_notno70    =  tlt.policy         
            fi_notno72    =  tlt.comp_pol 
            fi_institle   =  substr(tlt.ins_name,1,INDEX(tlt.ins_name," "))         
            fi_preinsur   =  substr(tlt.ins_name,INDEX(tlt.ins_name," ") + 1,R-INDEX(tlt.ins_name," ") - INDEX(tlt.ins_name," "))                                     
            fi_preinsur2  =  substr(tlt.ins_name,r-INDEX(tlt.ins_name," ") + 1)   
            fi_idno        = tlt.endno
            fi_birthday    = tlt.dat_ins_noti
            fi_age         = tlt.seqno
            fi_idnoexpdat  = tlt.entdat 
            fi_occup       = tlt.flag        
            fi_namedrirect = tlt.usrsent 
            fi_insadd2tam  = tlt.ins_addr2     
            fi_insadd3amp  = tlt.ins_addr3     
            fi_insadd4cunt = tlt.ins_addr4     
            fi_insadd5post = tlt.ins_addr5 
            /* fi_insadd6tel  = tlt.comp_noti_ins  Comment by Phaiboon W. [A59-0625] Date 23/12/2016 */
            
            fi_insadd6tel  = TRIM(SUBSTR(tlt.comp_noti_ins,1,20)) /* Add by Phaiboon W. [A59-0625] Date 22/12/2016 */
                             /* nv_chknotes = "N" New / nv_chknotes  "L" Lock  */
            nv_chknotes    = SUBSTR(tlt.comp_noti_ins,21,1)   /* Add by Phaiboon W. [A59-0625] Date 22/12/2016 */
                                        
            fi_comdat      = tlt.nor_effdat
            fi_expdat      = tlt.expodat   
            /* fi_ispno       = tlt.dri_no2 */
            fi_ispno       = TRIM(SUBSTR(tlt.dri_no2,1,50)) /* add by Phaiboon W. [A59-0488] Date 30/11/2016 */
            fi_ispstatus   = TRIM(SUBSTR(tlt.dri_no2,51,1)) /* add by Phaiboon W. [A59-0488] Date 30/11/2016 */            

            fi_brand       = tlt.brand          
            fi_model       = tlt.model      
            fi_year        = tlt.lince2           
            fi_power       = tlt.cc_weight     
            /*fi_licence1    = IF substr(tlt.lince1,1,2) = "" THEN "" 
                             ELSE trim(substr(tlt.lince1,1,2)) 
            fi_licence2    = IF trim(substr(tlt.lince1,3,5)) = "" THEN "" 
                             ELSE trim(substr(tlt.lince1,3,5))
            fi_provin      = IF R-INDEX(tlt.lince1," ") <> 0 THEN trim(substr(tlt.lince1,r-INDEX(tlt.lince1," ") + 1)) 
                             ELSE ""*/
            /*A54-0112....
            fi_licence1    = IF INDEX(tlt.lince1," ") <> 0 THEN trim(substr(tlt.lince1,1,INDEX(tlt.lince1," ") - 1 ))
                             ELSE  trim(substr(tlt.lince1,1,3))
            fi_licence2    = IF ( R-INDEX(tlt.lince1," ") <> 0 ) AND ( INDEX(tlt.lince1," ") <> R-INDEX(tlt.lince1," ") ) THEN 
                             trim(substr(tlt.lince1,INDEX(tlt.lince1," ") + 1,R-INDEX(tlt.lince1," ") - INDEX(tlt.lince1," "))) 
                             ELSE  trim(substr(tlt.lince1,4,5))
            fi_provin      = IF R-INDEX(tlt.lince1," ") <> 0 THEN trim(substr(tlt.lince1,r-INDEX(tlt.lince1," ") + 1)) 
                             ELSE ""
            end ...a54-0112 ...*/
            /* A54-0112 */
            fi_licence1    = IF tlt.lince1 = "" THEN ""
                             ELSE IF INDEX(tlt.lince1," ") <> 0 THEN trim(substr(tlt.lince1,1,INDEX(tlt.lince1," ") - 1 ))
                             ELSE  trim(substr(tlt.lince1,1,3))
            fi_licence2    = IF  (R-INDEX(tlt.lince1," ") <> 0 ) AND (INDEX(tlt.lince1," ") <> 0) THEN 
                             trim(substr(tlt.lince1,INDEX(tlt.lince1," ") + 1,R-INDEX(tlt.lince1," ") - INDEX(tlt.lince1," ") - 1)) 
                             ELSE  trim(substr(tlt.lince1,4,5))
            fi_provin      = IF R-INDEX(tlt.lince1," ") <> 0 THEN 
                             trim(substr(tlt.lince1,r-INDEX(tlt.lince1," ") + 1)) 
                             ELSE ""
            /*a54-0112 */
            fi_cha_no      = tlt.cha_no  
            fi_eng_no      = tlt.eng_no 
            fi_pack        = substr(tlt.lince3,1,1)        
            fi_class       = substr(tlt.lince3,2,3)        
            fi_garage      = tlt.EXP 
            fi_sumsi       = tlt.nor_coamt       
            fi_gap         = DECI(tlt.dri_name2) 
            fi_premium     = tlt.nor_grprm       
            fi_precomp     = tlt.comp_coamt      
            fi_totlepre    = tlt.comp_grprm      
            fi_stk         = tlt.comp_sck 
            fi_refer       = tlt.comp_noti_tlt   
            fi_recipname   = tlt.rec_name        
            fi_vatcode     = tlt.comp_usr_tlt  
            fi_user        = tlt.expousr 
            fi_benname     = tlt.comp_usr_ins 
            nv_benname     = tlt.comp_usr_ins  
           
            /* Begin by Phaiboon W. [A59-0488] Date 11/10/2015 */
            /* fi_remark1     = substr(tlt.OLD_cha,index(tlt.old_cha,":") + 1) Comment by Phaiboon [A59-0488] */            
            fi_remark1     = TRIM(SUBSTR(tlt.OLD_cha,INDEX(tlt.old_cha,":") + 1, 100 - (INDEX(tlt.old_cha,":") + 1)))            
            fi_remark2     = TRIM(SUBSTR(tlt.OLD_cha,101,100))                  
            fi_other2      = DEC(SUBSTR(tlt.OLD_cha,251,10))   
            fi_other3      = TRIM(SUBSTR(tlt.OLD_cha,261,60))
            fi_quo         = TRIM(SUBSTR(tlt.OLD_cha,321,20))
            /* End by Phaiboon W. [A59-0488] Date 11/10/2015 */           
            
            ra_complete   =  IF trim(tlt.OLD_eng) =  "complete" THEN 1 ELSE 2
            fi_userid     =  tlt.usrid
            n_addr11      =  tlt.ins_addr1  
            fi_baseod     =  IF (tlt.rec_addr5 = "") OR (DECI(tlt.rec_addr5) = 0 ) THEN 0 ELSE deci(tlt.rec_addr5)  /*A57-0063*/  
            vAcProc_fil3   = " " 
            vAcProc_fil3   = vAcProc_fil3  + " " .    

            IF fi_institle = "" THEN fi_institle = "คุณ".  /* add by Phaiboon W. [A59-0488] Date 18/11/2016 */

        ASSIGN   
            vAcProc_fil4   = ""   /* A57-0063 */
            vAcProc_fil5   = ""   /* A57-0063 */
            vAcProc_fil6   = ""   /* add by Phaiboon W. [A59-0488] Date 15/11/2016 */
            vAcProc_fil4   = vAcProc_fil4 
                             + "เก๋ง"            + ","  
                             + "กระบะ"           + "," 
                             + "โดยสาร(บุคคล)"   + ","  
                             + "โดยสาร(พาณิชย์)" + ","
                             + "BIKE(บุคคล)"     + ","
                             + "BIKE(พาณิชย์)" 
            vAcProc_fil5   = vAcProc_fil5 + " " + "," 
                        + "หมู่บ้าน"       + ","  
                        + "อาคาร"          + ","  
                        + "บริษัท"         + ","  
                        + "บจก."           + ","  
                        + "บ."             + ","    
                        + "หจก."           + ","            
                        + "หสน."           + ","            
                        + "บรรษัท"         + ","         
                        + "มูลนิธิ"        + ","  
                        + "โรงเรียน"       + ","  
                        + "โรงพยาบาล"      + ","  
                        + "ห้างหุ้นส่วน"   
            vAcProc_fil6   = vAcProc_fil6
                           + "ซ่อมอู่"    + ","
                           + "ซ่อมห้าง"

            co_addr:LIST-ITEMS    = vAcproc_fil5      /*A57-0063*/ 
            co_caruse:LIST-ITEMS  = vAcproc_fil4    /*A57-0063*/
            co_garage:LIST-ITEMS  = vAcproc_fil6            /* add by Phaiboon W. [A59-0488] Date 15/11/2016 */
            /*co_addr:LIST-ITEMS  = vAcproc_fil5      /*A57-0063*/*/
            co_caruse   = tlt.safe1               /*A57-0063*/
            nv_cartyp   = tlt.safe1               /*A57-0063*/
            co_garage   = TRIM(SUBSTR(tlt.OLD_cha,341,20)). /* add by Phaiboon W. [A59-0488] Date 15/11/2016 */
            
        IF  tlt.dri_name1 = "" THEN DO:  /*driver name 1.*/
            ASSIGN 
                ra_driv = 1
                FRAME fr_driv  fi_text1   fi_text1  = ""
                FRAME fr_driv  fi_text2   fi_text2  = ""
                FRAME fr_driv  fi_text3   fi_text3  = ""
                FRAME fr_driv  fi_text4   fi_text4  = ""
                FRAME fr_driv  fi_text5   fi_text5  = ""
                FRAME fr_driv  fi_text6   fi_text6  = ""
                FRAME fr_driv  fi_text7   fi_text7  = ""
                FRAME fr_driv  fi_text8   fi_text8  = ""
                FRAME fr_driv  fi_text9   fi_text9  = ""
                FRAME fr_driv  fi_text10  fi_text10 = "" .
            DISP fi_text1 fi_text2 fi_text3 fi_text4 fi_text5 fi_text6 
                 fi_text7 fi_text8  fi_text9 fi_text10 WITH FRAME fr_driv.
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
            ASSIGN                  
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
            DISP fi_text1       fi_text2      fi_text3       fi_text4       fi_text5     fi_text6   fi_text7  
                 fi_text8       fi_text9      fi_text10      fi_drivername1 fi_idnodriv1 ra_sex1    fi_hbdri1    
                 fi_agedriv1    fi_occupdriv1 fi_drivername2 fi_idnodriv2   ra_sex2      fi_hbdri2  fi_agedriv2
                 fi_occupdriv2  WITH FRAME fr_driv.
        END. 
        /*fi_drivername1 = substr(tlt.dri_name1,1  = trim(fi_drivername1) + "sex:" + string(ra_sex1)  + "hbd:" + STRING(fi_hbdri1) + "age:" +  string(fi_agedriv1) + "occ:" + trim(fi_occupdriv1) 
        *//**/
            /*tlt.enttim    = trim(fi_drivername2) + "sex:" + string(ra_sex2)  + 
            "hbd:" + STRING(fi_hbdri2) +
             "age:" +  string(fi_agedriv2) +
              "occ:" + trim(fi_occupdriv2) */
    END. 

    IF nv_chknotes = "L" THEN DISABLE bu_notes WITH FRAME fr_main.  /* add by Phaiboon W. [A59-0625] Date 26/12/2016 */
    ELSE ENABLE bu_notes WITH FRAME fr_main.
    
    /*A57-0063*/    
    RUN proc_initdata.
    FIND FIRST company WHERE Company.CompNo = fi_comco  NO-LOCK NO-ERROR NO-WAIT.
    IF   AVAIL company THEN  
        ASSIGN nv_benname     = Company.Name2  
        n_producernew  = company.Text1 
        n_produceruse  = company.Text2 
        n_producerbike = company.Text5   
        n_agent        = company.Text4.
    /*A57-0063*/
    FOR EACH company WHERE company.NAME = "phone" NO-LOCK . 
    ASSIGN vAcProc_fil3   = vAcProc_fil3  + " " + "," + TRIM(company.NAME2).
    END.
    ASSIGN 
        co_benname:LIST-ITEMS = vAcProc_fil3 
        co_benname  = ENTRY(1,vAcProc_fil3)  .
    RUN  proc_dispable.
    Disp fi_notino       fi_comco        fi_cmrcode2     fi_cmrcode      fi_ins_off         
         fi_notdat       fi_nottim       fi_cmrsty       fi_producer     fi_agent             
         fi_campaign     /*ra_car*/      ra_cover        fi_cover1       ra_pa fi_product       
         ra_pree         ra_comp         fi_notno70      fi_notno72      fi_institle        
         fi_preinsur     fi_preinsur2    fi_insadd1no    fi_insadd1mu    fi_insadd1build    
         fi_insadd1soy   fi_insadd1road  fi_insadd2tam   fi_insadd3amp   fi_insadd4cunt     
         fi_insadd5post  fi_insadd6tel   fi_brand        fi_model        fi_eng_no   
         fi_cha_no       fi_power        fi_year         fi_licence1     fi_licence2     
         fi_provin       fi_pack         fi_class        fi_sumsi        fi_premium      
         fi_precomp      fi_totlepre     fi_stk          fi_refer        fi_recipname    
         fi_vatcode      fi_comdat       fi_expdat       fi_gap          fi_ispno        
         fi_user         co_benname      fi_benname      fi_remark1      fi_remark2             
         fi_other2       fi_other3       fi_garage       ra_complete     fi_ispstatus
         fi_idno         /*ra_ban */     co_addr         fi_birthday     fi_age          fi_occup                
         fi_namedrirect  fi_userid       fi_idnoexpdat   ra_driv         fi_deler     
         co_caruse       fi_baseod       co_garage       fi_quo          
    With FRAME fr_main.
    /* End.*/
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
  DISPLAY fi_ins_off fi_comco fi_cmrcode fi_cmrcode2 fi_campaign co_caruse 
          ra_cover fi_cover1 ra_pa fi_product ra_pree ra_comp fi_producer 
          fi_agent fi_deler fi_cmrsty fi_notno70 fi_notno72 fi_institle 
          fi_preinsur fi_preinsur2 fi_idno fi_birthday fi_age fi_idnoexpdat 
          fi_occup fi_namedrirect fi_insadd1no fi_insadd1mu co_addr 
          fi_insadd1build fi_insadd1soy fi_insadd1road fi_insadd2tam 
          fi_insadd3amp fi_insadd4cunt fi_insadd5post fi_insadd6tel fi_comdat 
          fi_expdat fi_ispno fi_brand fi_model fi_year fi_power fi_licence1 
          fi_licence2 fi_provin fi_cha_no fi_eng_no fi_pack fi_class fi_garage 
          fi_sumsi fi_gap fi_premium fi_precomp fi_totlepre fi_baseod fi_stk 
          fi_refer fi_recipname fi_vatcode fi_user fi_benname co_benname 
          fi_remark1 ra_complete fi_userid ra_driv fi_notino fi_notdat fi_nottim 
          fi_remark2 fi_quo fi_other2 co_garage fi_other3 fi_ispstatus 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE bu_notes fi_ins_off fi_comco buselecom fi_cmrcode fi_cmrcode2 
         fi_campaign co_caruse ra_cover fi_cover1 bu_cover ra_pa fi_product 
         bu_product ra_pree ra_comp fi_producer fi_agent fi_deler fi_cmrsty 
         fi_notno70 fi_notno72 bu_create fi_institle fi_preinsur fi_preinsur2 
         fi_idno fi_birthday fi_age fi_idnoexpdat fi_occup fi_namedrirect 
         fi_insadd1no fi_insadd1mu co_addr fi_insadd1build fi_insadd1soy 
         fi_insadd1road fi_insadd2tam fi_insadd3amp fi_insadd4cunt 
         fi_insadd5post fi_insadd6tel fi_comdat fi_expdat fi_ispno fi_brand 
         fi_model fi_year fi_power fi_licence1 fi_licence2 fi_provin fi_cha_no 
         fi_eng_no fi_pack fi_class fi_garage fi_sumsi fi_gap fi_premium 
         fi_precomp fi_totlepre fi_baseod fi_stk fi_refer fi_recipname 
         fi_vatcode fi_user fi_benname co_benname fi_remark1 ra_complete 
         bu_save bu_exit ra_driv bu_brand fi_remark2 fi_quo bu_quo fi_other2 
         co_garage fi_other3 fi_ispstatus RECT-488 RECT-489 RECT-490 RECT-491 
         RECT-492 RECT-493 
      WITH FRAME fr_main IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  DISPLAY fi_text1 fi_drivername1 ra_sex1 fi_text3 fi_text5 fi_agedriv1 
          fi_occupdriv1 fi_text9 fi_idnodriv1 fi_hbdri1 fi_text7 fi_text2 
          fi_drivername2 ra_sex2 fi_text4 fi_hbdri2 fi_text6 fi_agedriv2 
          fi_text8 fi_occupdriv2 fi_text10 fi_idnodriv2 
      WITH FRAME fr_driv IN WINDOW C-Win.
  ENABLE fi_text1 fi_drivername1 ra_sex1 fi_text3 fi_text5 fi_agedriv1 
         fi_occupdriv1 fi_text9 fi_idnodriv1 fi_hbdri1 fi_text7 fi_text2 
         fi_drivername2 ra_sex2 fi_text4 fi_hbdri2 fi_text6 fi_agedriv2 
         fi_text8 fi_occupdriv2 fi_text10 fi_idnodriv2 
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

FIND FIRST sicsyac.xmm023 USE-INDEX xmm02301 
     WHERE sicsyac.xmm023.branch = TRIM(nv_branch) NO-LOCK NO-ERROR.
IF AVAIL sicsyac.xmm023 THEN DO:
    nv_branch = sicsyac.xmm023.bdes.

    IF      nv_branch = "M1" THEN nv_branch = "Business Unit 1".

    ELSE IF nv_branch = "M2" OR
            nv_branch = "M5" THEN nv_branch = "Business Unit 2".

    ELSE IF nv_branch = "M3" THEN nv_branch = "Business Unit 3".
    ELSE IF sicsyac.xmm023.branch = "T" THEN nv_branch = "เทพารักษ์".
    ELSE DO:
        ASSIGN
            NotesBranch = "safety\is\branch.nsf"
            NotesView   = "By Code"
            NotesKey    = sicsyac.xmm023.branch
            chDBranch   = chSession:GetDatabase(NotesServer,NotesBranch).

        IF NotesKey >= "91" AND 
           NotesKey <= "98" THEN NotesKey = "91-98".

        IF chDBranch:isOpen = NO THEN
            nv_msgbox = "Can not Connect Branch Lotus Notes !".
        ELSE DO:
            chDView     = chDBranch:GetView(NotesView).
            chDocBranch = chDView:GetDocumentByKey(NotesKey).

            IF VALID-HANDLE(chDocBranch) = YES THEN 
                nv_branch = chDocBranch:GetFirstItem("nameThai"):TEXT.                
            ELSE nv_msgbox = "Not Found Branch Information".
        END.       
    END.
END.

IF nv_msgbox <> "" THEN MESSAGE nv_msgbox VIEW-AS ALERT-BOX ERROR.
nv_msgbox = "".

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_create70 C-Win 
PROCEDURE proc_create70 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

/*FIND LAST  tlt    WHERE 
    tlt.genusr        = "Phone"      AND
    tlt.nor_noti_tlt  = fi_notino    NO-ERROR NO-WAIT.*/
Find  tlt  Where   Recid(tlt)  =  nv_recidtlt  NO-ERROR NO-WAIT .
IF AVAIL tlt THEN  ASSIGN tlt.policy        =  fi_notno70 .
RELEASE tlt.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_create72 C-Win 
PROCEDURE proc_create72 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
Find  tlt  Where   Recid(tlt)  =  nv_recidtlt  NO-ERROR NO-WAIT .
IF AVAIL tlt THEN  ASSIGN tlt.comp_pol      =  fi_notno72.
RELEASE tlt.
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
If  avail  tlt  Then 
    /*DISABLE 
    fi_notino      fi_comco        fi_cmrcode2    fi_cmrcode     fi_ins_off    fi_notdat     
    fi_nottim      fi_cmrsty       fi_producer    fi_agent       fi_campaign   ra_car        ra_cover      
    fi_cover1      fi_product      ra_pree        ra_comp        fi_notno70    fi_notno72    fi_institle   
    fi_preinsur    fi_preinsur2                   fi_insadd2tam                
    fi_insadd3amp  fi_insadd4cunt  fi_insadd5post fi_insadd6tel  fi_brand      fi_model        
    fi_eng_no      fi_cha_no       fi_power       fi_year        fi_licence1   fi_licence2   
    fi_provin      fi_pack         fi_class                                    
    fi_sumsi       fi_premium      fi_precomp     fi_totlepre    fi_stk        fi_refer      
    fi_recipname   fi_vatcode      fi_comdat      fi_expdat      fi_gap        fi_ispno      fi_user       
    fi_benname     fi_remark1      fi_garage      ra_complete    fi_userid     WITH FRAM fr_main.  */
    DISABLE buselecom    bu_cover        bu_product      bu_create       /*bu_model*/    bu_save
         fi_notino       fi_comco        fi_cmrcode2     fi_cmrcode      fi_ins_off         
         fi_notdat       fi_nottim       fi_cmrsty       fi_producer     fi_agent           
         fi_campaign    /* ra_car*/      ra_cover        fi_cover1       fi_product         
         ra_pree         ra_comp         fi_notno70      fi_notno72      fi_institle        
         fi_preinsur     fi_preinsur2    fi_insadd1no    fi_insadd1mu    fi_insadd1build
         fi_insadd1soy   fi_insadd1road  fi_insadd2tam   fi_insadd3amp   fi_insadd4cunt  
         fi_insadd5post  fi_insadd6tel   fi_brand        fi_model        fi_eng_no   
         fi_cha_no       fi_power        fi_year         fi_licence1     fi_licence2     
         fi_provin       fi_pack         fi_class        fi_sumsi        fi_premium      
         fi_precomp      fi_totlepre     fi_stk          fi_refer        fi_recipname    
         fi_vatcode      fi_comdat       fi_expdat       fi_gap          fi_ispno        
         fi_user         co_benname   /*fi_benname */    fi_remark1      fi_remark2
         fi_garage       ra_complete     fi_userid WITH FRAM fr_main.
 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_initdata C-Win 
PROCEDURE proc_initdata :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
IF INDEX(n_addr11,"ถนน") = 0 THEN ASSIGN fi_insadd1road = "".  
ELSE ASSIGN fi_insadd1road = SUBSTR(n_addr11,INDEX(n_addr11,"ถนน") + 3 )
    n_road   = SUBSTR(n_addr11,INDEX(n_addr11,"ถนน") + 3 )
    n_addr11 = SUBSTR(n_addr11,1,length(n_addr11) - (LENGTH(fi_insadd1road)) - 3 ).
IF   INDEX(n_addr11,"ซอย") = 0 THEN ASSIGN fi_insadd1soy = "".  
ELSE  ASSIGN fi_insadd1soy = SUBSTR(n_addr11,INDEX(n_addr11,"ซอย") + 3 )
    n_soy = SUBSTR(n_addr11,INDEX(n_addr11,"ซอย") + 3 )
    n_addr11 = SUBSTR(n_addr11,1,length(n_addr11) - (LENGTH(fi_insadd1soy)) - 3 ).
IF R-INDEX(n_addr11,"หมู่บ้าน") <> 0 THEN 
    ASSIGN fi_insadd1build  = SUBSTR(n_addr11,r-INDEX(n_addr11,"หมู่บ้าน") + 8 )
    co_addr  = "หมู่บ้าน"
    n_build  = SUBSTR(n_addr11,INDEX(n_addr11,"หมู่บ้าน") + 8 )
    n_addr11 = SUBSTR(n_addr11,1,length(n_addr11) - (LENGTH(fi_insadd1build)) - 8 ).
ELSE IF R-INDEX(n_addr11,"อาคาร") <> 0 THEN 
    ASSIGN fi_insadd1build  = SUBSTR(n_addr11,r-INDEX(n_addr11,"อาคาร") + 5 )
    co_addr  =  "อาคาร"  
    n_build  = SUBSTR(n_addr11,INDEX(n_addr11,"อาคาร") + 5 )
    n_addr11 = SUBSTR(n_addr11,1,length(n_addr11) - (LENGTH(fi_insadd1build)) - 5 ).
ELSE IF R-INDEX(n_addr11,"บริษัท") <> 0 THEN 
    ASSIGN fi_insadd1build  = SUBSTR(n_addr11,r-INDEX(n_addr11,"บริษัท") + 6 )
    co_addr  = "บริษัท"   
    n_build  = SUBSTR(n_addr11,INDEX(n_addr11,"บริษัท") + 6 )
    n_addr11 = SUBSTR(n_addr11,1,length(n_addr11) - (LENGTH(fi_insadd1build)) - 6 ).
ELSE IF R-INDEX(n_addr11,"บจก.") <> 0 THEN 
    ASSIGN fi_insadd1build  = SUBSTR(n_addr11,r-INDEX(n_addr11,"บจก.") + 4 )
    co_addr  = "บจก."
    n_build  = SUBSTR(n_addr11,INDEX(n_addr11,"บจก.") + 4 )
    n_addr11 = SUBSTR(n_addr11,1,length(n_addr11) - (LENGTH(fi_insadd1build)) - 4 ).
ELSE IF R-INDEX(n_addr11,"บ.") <> 0 THEN 
    ASSIGN fi_insadd1build  = SUBSTR(n_addr11,r-INDEX(n_addr11,"บ.") + 2 )
    co_addr  = "บ."  
    n_build  = SUBSTR(n_addr11,INDEX(n_addr11,"บ.") + 2 )
    n_addr11 = SUBSTR(n_addr11,1,length(n_addr11) - (LENGTH(fi_insadd1build)) - 2 ).
ELSE IF R-INDEX(n_addr11,"หจก.") <> 0 THEN 
    ASSIGN fi_insadd1build  = SUBSTR(n_addr11,r-INDEX(n_addr11,"หจก.") + 4 )
    co_addr  = "หจก."  
    n_build  = SUBSTR(n_addr11,INDEX(n_addr11,"หจก.") + 4 )
    n_addr11 = SUBSTR(n_addr11,1,length(n_addr11) - (LENGTH(fi_insadd1build)) - 4 ).
ELSE IF R-INDEX(n_addr11,"หสน.") <> 0 THEN 
    ASSIGN fi_insadd1build  = SUBSTR(n_addr11,r-INDEX(n_addr11,"หสน.") + 4 )
    co_addr  = "หสน."  
    n_build  = SUBSTR(n_addr11,INDEX(n_addr11,"หสน.") + 4 )
    n_addr11 = SUBSTR(n_addr11,1,length(n_addr11) - (LENGTH(fi_insadd1build)) - 4 ).
ELSE IF R-INDEX(n_addr11,"บรรษัท") <> 0 THEN 
    ASSIGN fi_insadd1build  = SUBSTR(n_addr11,r-INDEX(n_addr11,"บรรษัท") + 6 )
    co_addr  = "บรรษัท"  
    n_build  = SUBSTR(n_addr11,INDEX(n_addr11,"บรรษัท") + 6 )
    n_addr11 = SUBSTR(n_addr11,1,length(n_addr11) - (LENGTH(fi_insadd1build)) - 6 ).
ELSE IF R-INDEX(n_addr11,"มูลนิธิ") <> 0 THEN 
    ASSIGN fi_insadd1build  = SUBSTR(n_addr11,r-INDEX(n_addr11,"มูลนิธิ") + 7 )
    co_addr  = "มูลนิธิ"  
    n_build  = SUBSTR(n_addr11,INDEX(n_addr11,"มูลนิธิ") + 7 )
    n_addr11 = SUBSTR(n_addr11,1,length(n_addr11) - (LENGTH(fi_insadd1build)) - 7 ).
ELSE IF R-INDEX(n_addr11,"โรงเรียน") <> 0 THEN 
    ASSIGN fi_insadd1build  = SUBSTR(n_addr11,r-INDEX(n_addr11,"โรงเรียน") + 8 )
    co_addr  = "โรงเรียน"  
    n_build  = SUBSTR(n_addr11,INDEX(n_addr11,"โรงเรียน") + 8 )
    n_addr11 = SUBSTR(n_addr11,1,length(n_addr11) - (LENGTH(fi_insadd1build)) - 8 ).
ELSE IF R-INDEX(n_addr11,"โรงพยาบาล") <> 0 THEN 
    ASSIGN fi_insadd1build  = SUBSTR(n_addr11,r-INDEX(n_addr11,"โรงพยาบาล") + 9 )
    co_addr  = "โรงพยาบาล"  
    n_build  = SUBSTR(n_addr11,INDEX(n_addr11,"โรงพยาบาล") + 9 )
    n_addr11 = SUBSTR(n_addr11,1,length(n_addr11) - (LENGTH(fi_insadd1build)) - 9).
ELSE IF R-INDEX(n_addr11,"ห้างหุ้นส่วน") <> 0 THEN 
    ASSIGN fi_insadd1build  = SUBSTR(n_addr11,r-INDEX(n_addr11,"ห้างหุ้นส่วน") + 12 )
    co_addr  = "ห้างหุ้นส่วน"  
    n_build  = SUBSTR(n_addr11,INDEX(n_addr11,"ห้างหุ้นส่วน") + 12 )
    n_addr11 = SUBSTR(n_addr11,1,length(n_addr11) - (LENGTH(fi_insadd1build)) - 12 ).
ELSE ASSIGN fi_insadd1build = ""
    co_addr  = ""  . 
IF INDEX(n_addr11,"หมู่") = 0 THEN ASSIGN fi_insadd1mu = "".  
ELSE ASSIGN fi_insadd1mu  = SUBSTR(n_addr11,INDEX(n_addr11,"หมู่") + 5 )
    n_muno  = SUBSTR(n_addr11,INDEX(n_addr11,"หมู่") + 5 )
    n_addr11 = SUBSTR(n_addr11,1,length(n_addr11) - (LENGTH(fi_insadd1mu)) - 5 ).
IF INDEX(n_addr11,"เลขที่") = 0 THEN ASSIGN fi_insadd1no = "".  
ELSE ASSIGN fi_insadd1no = SUBSTR(n_addr11,8)
    n_banno      = SUBSTR(n_addr11,8) . 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

