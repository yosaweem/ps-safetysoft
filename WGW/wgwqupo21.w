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
program id       :  wuwqupo21.w 
program name     :  Update data Phone to create  new policy  Add in table  tlt Quey & Update data before Gen.
Create  by       :  Ranu I. A62-0219 date. 08/05/2019
Database Connect :  gw_stat ld brstat , gw_safe ld sic_bran ,sic_test ld sicuw sicsyac :not connect stat
Modify by        :  Ranu I. A62-0343 date : 23/07/2019 แก้ไขปุ่ม save ไม่ต้อง update tlt.releas 
Modify by        :  Ranu I. A62-0345 date : 08/08/2019 status CA ไม่สามารถอัพเดทแก้ไขข้อมูลได้ 
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
/* End by Phaiboon W. [A59-0625] Date 22/12/2016 */

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

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS fi_ins_off fi_comco buselecom fi_cmrcode ~
fi_cmrcode2 fi_producer fi_agent fi_deler bu_create fi_institle fi_preinsur ~
fi_preinsur2 fi_idno fi_birthday fi_age fi_idnoexpdat fi_occup ~
fi_namedrirect fi_insadd1no fi_insadd1mu co_addr fi_insadd1build ~
fi_insadd1soy fi_insadd1road fi_insadd2tam fi_insadd3amp fi_insadd4cunt ~
fi_insadd5post fi_insadd6tel fi_user ra_complete bu_save bu_exit bu_not2 ~
co_title fi_refer fi_recipname fi_vatcode fi_benname co_benname fi_remark1 ~
fi_remark2 co_user fi_cmrsty ra_cover ra_pree ra_comp fi_notno70 fi_notno72 ~
RECT-488 RECT-490 RECT-491 RECT-492 RECT-493 RECT-494 RECT-498 RECT-499 
&Scoped-Define DISPLAYED-OBJECTS fi_ins_off fi_comco fi_cmrcode fi_cmrcode2 ~
fi_producer fi_agent fi_deler fi_institle fi_preinsur fi_preinsur2 fi_idno ~
fi_birthday fi_age fi_idnoexpdat fi_occup fi_namedrirect fi_insadd1no ~
fi_insadd1mu co_addr fi_insadd1build fi_insadd1soy fi_insadd1road ~
fi_insadd2tam fi_insadd3amp fi_insadd4cunt fi_insadd5post fi_insadd6tel ~
fi_user ra_complete fi_userid fi_notino fi_notdat fi_nottim co_title ~
fi_refer fi_recipname fi_vatcode fi_benname co_benname fi_remark1 ~
fi_remark2 co_user fi_cmrsty ra_cover ra_pree ra_comp fi_userbr fi_notno70 ~
fi_notno72 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON buselecom 
     IMAGE-UP FILE "i:/safety/walp10/wimage/next.bmp":U
     LABEL "" 
     SIZE 4 BY 1.

DEFINE BUTTON bu_create 
     LABEL "Create" 
     SIZE 8 BY 1
     BGCOLOR 2 FGCOLOR 7 FONT 6.

DEFINE BUTTON bu_exit 
     LABEL "Exit" 
     SIZE 7.5 BY .95
     FONT 6.

DEFINE BUTTON bu_not2 
     LABEL "ข้อมูลรถและความคุ้มครอง" 
     SIZE 24.33 BY 1.19
     BGCOLOR 1 FGCOLOR 7 FONT 6.

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
     SIZE 43.83 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE co_title AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS COMBO-BOX INNER-LINES 6
     DROP-DOWN-LIST
     SIZE 15.17 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE co_user AS CHARACTER FORMAT "X(60)":U 
     VIEW-AS COMBO-BOX INNER-LINES 5
     DROP-DOWN-LIST
     SIZE 22.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_age AS INTEGER FORMAT "->>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 5.67 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_agent AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 17.67 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_benname AS CHARACTER FORMAT "X(65)":U INITIAL ? 
     VIEW-AS FILL-IN 
     SIZE 39.5 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_birthday AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 13.5 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_cmrcode AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 16 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_cmrcode2 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 6.5 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_cmrsty AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 6.33 BY .95
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_comco AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 15.5 BY 1
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_deler AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 17.67 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_idno AS CHARACTER FORMAT "X(13)":U 
     VIEW-AS FILL-IN 
     SIZE 20 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_idnoexpdat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 14.67 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_insadd1build AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 30.5 BY .95
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
     SIZE 25.17 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_insadd1soy AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 23 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_insadd2tam AS CHARACTER FORMAT "X(35)":U 
     VIEW-AS FILL-IN 
     SIZE 20.5 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_insadd3amp AS CHARACTER FORMAT "X(35)":U 
     VIEW-AS FILL-IN 
     SIZE 21.83 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_insadd4cunt AS CHARACTER FORMAT "X(35)":U 
     VIEW-AS FILL-IN 
     SIZE 18 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_insadd5post AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 14.17 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_insadd6tel AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 16 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_institle AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 13.5 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_ins_off AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 23 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_namedrirect AS CHARACTER FORMAT "X(60)":U 
     VIEW-AS FILL-IN 
     SIZE 31.33 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_notdat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .95
     BGCOLOR 19 FGCOLOR 2 FONT 1 NO-UNDO.

DEFINE VARIABLE fi_notino AS CHARACTER FORMAT "X(35)":U 
     VIEW-AS FILL-IN 
     SIZE 17 BY .95
     BGCOLOR 19 FONT 1 NO-UNDO.

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
     BGCOLOR 19 FGCOLOR 2 FONT 1 NO-UNDO.

DEFINE VARIABLE fi_occup AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 22.17 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_preinsur AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 24.83 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_preinsur2 AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 25 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_producer AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 14.83 BY .95
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
     SIZE 83.5 BY 1
     BGCOLOR 8 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_remark2 AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 83.5 BY 1
     BGCOLOR 8 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_user AS CHARACTER FORMAT "X(100)":U INITIAL ? 
     VIEW-AS FILL-IN 
     SIZE 27.67 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_userbr AS CHARACTER FORMAT "X(100)":U INITIAL ? 
     VIEW-AS FILL-IN 
     SIZE 21 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_userid AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 7.5 BY .76
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_vatcode AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

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
     BGCOLOR 10 FGCOLOR 7 FONT 6 NO-UNDO.

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
     BGCOLOR 2 FGCOLOR 0 .

DEFINE RECTANGLE RECT-491
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 10 BY 2
     BGCOLOR 12 .

DEFINE RECTANGLE RECT-492
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 10 BY 2
     BGCOLOR 2 .

DEFINE RECTANGLE RECT-493
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 31.5 BY 1.81
     BGCOLOR 29 .

DEFINE RECTANGLE RECT-494
     EDGE-PIXELS 2 GRAPHIC-EDGE    ROUNDED 
     SIZE 130.5 BY 19.52
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-498
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE .67 BY 19.19
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-499
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 82.5 BY 1.71
     BGCOLOR 3 FGCOLOR 7 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     fi_ins_off AT ROW 6.48 COL 19.83 COLON-ALIGNED NO-LABEL
     fi_comco AT ROW 6.48 COL 54 COLON-ALIGNED NO-LABEL
     buselecom AT ROW 6.48 COL 71.33
     fi_cmrcode AT ROW 6.48 COL 81.33 COLON-ALIGNED NO-LABEL
     fi_cmrcode2 AT ROW 6.48 COL 104.5 COLON-ALIGNED NO-LABEL
     fi_producer AT ROW 7.57 COL 19.67 COLON-ALIGNED NO-LABEL
     fi_agent AT ROW 7.57 COL 49.67 COLON-ALIGNED NO-LABEL
     fi_deler AT ROW 7.57 COL 76.83 COLON-ALIGNED NO-LABEL
     bu_create AT ROW 3.57 COL 91.17
     fi_institle AT ROW 8.95 COL 35.17 COLON-ALIGNED NO-LABEL
     fi_preinsur AT ROW 8.95 COL 59.17 COLON-ALIGNED NO-LABEL
     fi_preinsur2 AT ROW 8.95 COL 94.83 COLON-ALIGNED NO-LABEL
     fi_idno AT ROW 10.05 COL 19.67 COLON-ALIGNED NO-LABEL
     fi_birthday AT ROW 10 COL 56.33 COLON-ALIGNED NO-LABEL
     fi_age AT ROW 10 COL 76.17 COLON-ALIGNED NO-LABEL
     fi_idnoexpdat AT ROW 10 COL 95 COLON-ALIGNED NO-LABEL
     fi_occup AT ROW 11.1 COL 19.5 COLON-ALIGNED NO-LABEL
     fi_namedrirect AT ROW 11.1 COL 55.33 COLON-ALIGNED NO-LABEL
     fi_insadd1no AT ROW 12.14 COL 19.5 COLON-ALIGNED NO-LABEL
     fi_insadd1mu AT ROW 12.14 COL 35.33 COLON-ALIGNED NO-LABEL
     co_addr AT ROW 12.14 COL 40.67 COLON-ALIGNED NO-LABEL
     fi_insadd1build AT ROW 12.14 COL 56.33 COLON-ALIGNED NO-LABEL
     fi_insadd1soy AT ROW 12.1 COL 94.33 COLON-ALIGNED NO-LABEL
     fi_insadd1road AT ROW 13.24 COL 19.5 COLON-ALIGNED NO-LABEL
     fi_insadd2tam AT ROW 13.24 COL 59 COLON-ALIGNED NO-LABEL
     fi_insadd3amp AT ROW 13.24 COL 92.33 COLON-ALIGNED NO-LABEL
     fi_insadd4cunt AT ROW 14.29 COL 19.67 COLON-ALIGNED NO-LABEL
     fi_insadd5post AT ROW 14.33 COL 52.17 COLON-ALIGNED NO-LABEL
     fi_insadd6tel AT ROW 14.33 COL 77.33 COLON-ALIGNED NO-LABEL
     fi_user AT ROW 20 COL 73.83 COLON-ALIGNED NO-LABEL
     ra_complete AT ROW 23.1 COL 79 NO-LABEL
     bu_save AT ROW 23.14 COL 110.5
     bu_exit AT ROW 23.19 COL 120.83
     fi_userid AT ROW 1.86 COL 121.83 COLON-ALIGNED NO-LABEL
     fi_notino AT ROW 1.81 COL 56.67 COLON-ALIGNED NO-LABEL
     fi_notdat AT ROW 1.81 COL 85.83 COLON-ALIGNED NO-LABEL
     fi_nottim AT ROW 1.81 COL 110.17 COLON-ALIGNED NO-LABEL
     bu_not2 AT ROW 1.71 COL 17.5 WIDGET-ID 58
     co_title AT ROW 8.91 COL 19.67 COLON-ALIGNED NO-LABEL WIDGET-ID 64
     fi_refer AT ROW 15.67 COL 19.5 COLON-ALIGNED NO-LABEL WIDGET-ID 88
     fi_recipname AT ROW 15.71 COL 54.83 COLON-ALIGNED NO-LABEL WIDGET-ID 86
     fi_vatcode AT ROW 15.71 COL 100.5 COLON-ALIGNED NO-LABEL WIDGET-ID 94
     fi_benname AT ROW 16.76 COL 19.5 COLON-ALIGNED NO-LABEL WIDGET-ID 84
     co_benname AT ROW 16.76 COL 59.33 COLON-ALIGNED NO-LABEL WIDGET-ID 82
     fi_remark1 AT ROW 17.86 COL 19.5 COLON-ALIGNED NO-LABEL WIDGET-ID 90
     fi_remark2 AT ROW 18.91 COL 19.5 COLON-ALIGNED NO-LABEL WIDGET-ID 92
     co_user AT ROW 20 COL 19.67 COLON-ALIGNED NO-LABEL WIDGET-ID 110
     fi_cmrsty AT ROW 7.57 COL 110.33 COLON-ALIGNED NO-LABEL WIDGET-ID 112
     ra_cover AT ROW 5.29 COL 22.33 NO-LABEL WIDGET-ID 28
     ra_pree AT ROW 5.24 COL 67.17 NO-LABEL WIDGET-ID 36
     ra_comp AT ROW 5.24 COL 94.83 NO-LABEL WIDGET-ID 116
     fi_userbr AT ROW 20.05 COL 42.5 COLON-ALIGNED NO-LABEL WIDGET-ID 122
     fi_notno70 AT ROW 3.57 COL 33.83 COLON-ALIGNED NO-LABEL
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 23.91
         BGCOLOR 3 FGCOLOR 1 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     fi_notno72 AT ROW 3.62 COL 67.83 COLON-ALIGNED NO-LABEL
     "รหัสบริษัท:":30 VIEW-AS TEXT
          SIZE 10 BY .95 AT ROW 6.48 COL 45.67
          BGCOLOR 19 FGCOLOR 4 FONT 6
     " คำนำชื่อ :":35 VIEW-AS TEXT
          SIZE 8.83 BY .95 AT ROW 8.95 COL 11.17
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "   ข้อมูลลูกค้า" VIEW-AS TEXT
          SIZE 14.67 BY 1.57 AT ROW 1.48 COL 2.83 WIDGET-ID 138
          BGCOLOR 1 FGCOLOR 7 FONT 15
     "อายุ:":35 VIEW-AS TEXT
          SIZE 4.5 BY .95 AT ROW 10 COL 73.5
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "ชื่อกรรมการ:":35 VIEW-AS TEXT
          SIZE 12 BY .95 AT ROW 11.1 COL 45
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "Producer Code :":30 VIEW-AS TEXT
          SIZE 15.5 BY .95 AT ROW 7.57 COL 4.67
          BGCOLOR 19 FGCOLOR 4 FONT 6
     "เลขบัตรประชาชน :":30 VIEW-AS TEXT
          SIZE 16.5 BY .95 AT ROW 10.05 COL 3.5
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "ถนน :":30 VIEW-AS TEXT
          SIZE 5 BY .95 AT ROW 13.24 COL 14.83
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " Policy 70 :":35 VIEW-AS TEXT
          SIZE 11 BY .95 AT ROW 3.57 COL 24.5
          BGCOLOR 3 FGCOLOR 7 FONT 6
     "ประกัน :":30 VIEW-AS TEXT
          SIZE 8 BY .95 AT ROW 5.24 COL 58.33 WIDGET-ID 44
          BGCOLOR 19 FGCOLOR 4 FONT 6
     " Policy 72 :":35 VIEW-AS TEXT
          SIZE 11 BY .95 AT ROW 3.62 COL 58.5
          BGCOLOR 3 FGCOLOR 7 FONT 6
     " ที่อยู่เลขที่ :":30 VIEW-AS TEXT
          SIZE 10 BY .95 AT ROW 12.14 COL 9.83
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "ซอย :":30 VIEW-AS TEXT
          SIZE 5 BY .95 AT ROW 12.1 COL 90.67
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " ตำบล/แขวง  :":30 VIEW-AS TEXT
          SIZE 13.67 BY .95 AT ROW 13.24 COL 47.17
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " ผู้รับแจ้ง :":35 VIEW-AS TEXT
          SIZE 10 BY .95 AT ROW 20 COL 65.67
          BGCOLOR 19 FGCOLOR 4 FONT 6
     "สาขาของ STY :":35 VIEW-AS TEXT
          SIZE 14 BY .95 AT ROW 7.57 COL 97.67 WIDGET-ID 114
          BGCOLOR 19 FGCOLOR 4 FONT 6
     "หมู่ :":30 VIEW-AS TEXT
          SIZE 4 BY .95 AT ROW 12.14 COL 32.83
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "บัตรหมดอายุ:":35 VIEW-AS TEXT
          SIZE 12 BY .95 AT ROW 10 COL 84.33
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "หมายเหตุ :":30 VIEW-AS TEXT
          SIZE 9.33 BY .95 AT ROW 17.91 COL 10.5 WIDGET-ID 104
          BGCOLOR 19 FGCOLOR 4 FONT 6
     " ใบเสร็จออกในนาม :":35 VIEW-AS TEXT
          SIZE 17.83 BY .95 AT ROW 15.71 COL 38.67 WIDGET-ID 102
          BGCOLOR 19 FGCOLOR 4 FONT 6
     "ประเภทงาน :":30 VIEW-AS TEXT
          SIZE 11.5 BY .95 AT ROW 5.33 COL 8.67 WIDGET-ID 50
          BGCOLOR 19 FGCOLOR 4 FONT 6
     "รหัสไปรษณีย ์:":30 VIEW-AS TEXT
          SIZE 13 BY .95 AT ROW 14.33 COL 40.83
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " ผู้แจ้ง MKT :":35 VIEW-AS TEXT
          SIZE 12.17 BY .95 AT ROW 6.48 COL 7.83
          BGCOLOR 19 FGCOLOR 4 FONT 6
     "  Agent Code :":30 VIEW-AS TEXT
          SIZE 14 BY .95 AT ROW 7.57 COL 37.5
          BGCOLOR 19 FGCOLOR 4 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 23.91
         BGCOLOR 3 FGCOLOR 1 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     " No.Time :":30 VIEW-AS TEXT
          SIZE 8.83 BY .95 AT ROW 1.81 COL 102.5
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "สาขาที่แจ้ง :":35 VIEW-AS TEXT
          SIZE 10.5 BY .95 AT ROW 20 COL 9.5 WIDGET-ID 108
          BGCOLOR 19 FGCOLOR 4 FONT 6
     " สาขา :":35 VIEW-AS TEXT
          SIZE 6.5 BY .95 AT ROW 6.48 COL 76.5
          BGCOLOR 19 FGCOLOR 4 FONT 6
     "Reference no :":30 VIEW-AS TEXT
          SIZE 14.17 BY .95 AT ROW 15.71 COL 5.83 WIDGET-ID 96
          BGCOLOR 19 FGCOLOR 4 FONT 6
     " พรบ :":30 VIEW-AS TEXT
          SIZE 6 BY .95 AT ROW 5.24 COL 87.67 WIDGET-ID 46
          BGCOLOR 19 FGCOLOR 4 FONT 6
     "อำเภอ/เขต :":30 VIEW-AS TEXT
          SIZE 11.17 BY .95 AT ROW 13.24 COL 82.83
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "  Vatcode :":30 VIEW-AS TEXT
          SIZE 11 BY .95 AT ROW 15.71 COL 91.17 WIDGET-ID 100
          BGCOLOR 19 FGCOLOR 4 FONT 6
     "นามสกุล :":35 VIEW-AS TEXT
          SIZE 9 BY .95 AT ROW 8.95 COL 87.33
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "อาชีพ :":35 VIEW-AS TEXT
          SIZE 6.33 BY .95 AT ROW 11.1 COL 13.5
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " วันเดือนปีเกิด :":35 VIEW-AS TEXT
          SIZE 14 BY .95 AT ROW 10 COL 44
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " ชื่อลูกค้า :":35 VIEW-AS TEXT
          SIZE 9.67 BY .95 AT ROW 8.95 COL 51.17
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "Notify Date :":30 VIEW-AS TEXT
          SIZE 11.5 BY .95 AT ROW 1.81 COL 76.17
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "โทรศัพท์:":30 VIEW-AS TEXT
          SIZE 8 BY .95 AT ROW 14.33 COL 70.83
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " รหัส:":35 VIEW-AS TEXT
          SIZE 6.17 BY .95 AT ROW 6.48 COL 100
          BGCOLOR 19 FGCOLOR 4 FONT 6
     "จังหวัด :":30 VIEW-AS TEXT
          SIZE 8 BY .95 AT ROW 14.29 COL 12
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "8.3 ไฟแนนซ์ :":30 VIEW-AS TEXT
          SIZE 12.67 BY .95 AT ROW 16.76 COL 7.17 WIDGET-ID 98
          BGCOLOR 19 FGCOLOR 4 FONT 6
     "Notify no.:" VIEW-AS TEXT
          SIZE 10.17 BY .95 AT ROW 1.81 COL 48.17
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " Dealer :":30 VIEW-AS TEXT
          SIZE 8.67 BY .95 AT ROW 7.57 COL 69.83
          BGCOLOR 19 FGCOLOR 4 FONT 6
     RECT-488 AT ROW 1.1 COL 1
     RECT-490 AT ROW 1.67 COL 123
     RECT-491 AT ROW 22.62 COL 119.67
     RECT-492 AT ROW 22.62 COL 109.33
     RECT-493 AT ROW 22.67 COL 77.5
     RECT-494 AT ROW 2.91 COL 1.83 WIDGET-ID 4
     RECT-498 AT ROW 3.1 COL 20.33 WIDGET-ID 62
     RECT-499 AT ROW 3.19 COL 23 WIDGET-ID 120
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 23.91
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
/* SETTINGS FOR WINDOW C-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME fr_main
   FRAME-NAME Custom                                                    */
ASSIGN 
       co_user:MANUAL-HIGHLIGHT IN FRAME fr_main = TRUE.

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

/* SETTINGS FOR FILL-IN fi_userbr IN FRAME fr_main
   NO-ENABLE                                                            */
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
            ASSIGN /*fi_pack = "G"*/
            fi_producer = n_producernew  
            fi_agent    =  n_agent    .
        ELSE IF ra_cover = 3 THEN
            ASSIGN /*fi_pack = "G"*/
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


&Scoped-define SELF-NAME bu_not2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_not2 C-Win
ON CHOOSE OF bu_not2 IN FRAME fr_main /* ข้อมูลรถและความคุ้มครอง */
DO:
   {&WINDOW-NAME}:hidden  =  Yes. 
    
    Run  wgw\wgwqupo22(Input  nv_recidtlt).
    Apply "Close"  To this-procedure.
    RETURN NO-APPLY.

    {&WINDOW-NAME}:hidden  =  No. 
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_save
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_save C-Win
ON CHOOSE OF bu_save IN FRAME fr_main /* Save */
DO:
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


    IF LENGTH(n_quota) <= 4 THEN DO: 
        n_quota  = "".
        n_garage = "".
    END.
    ELSE DO:
        n_quota  = n_quota + FILL(" ", 20 - LENGTH(n_quota)).
        n_garage = n_garage + FILL(" ", 20 - LENGTH(n_garage)).
    END.

  
    Find  tlt  Where   Recid(tlt)  =  nv_recidtlt  NO-ERROR NO-WAIT .
    IF AVAIL tlt THEN DO: 
       
        ASSIGN 
             tlt.nor_usr_ins   = trim(fi_ins_off)  
             tlt.lotno         = trim(fi_comco)
             tlt.nor_noti_ins  = trim(fi_cmrcode) 
             tlt.nor_usr_tlt   = trim(fi_cmrcode2)  
             tlt.safe2         = IF      ra_cover  = 1 THEN "ป้ายแดง" 
                                 ELSE IF ra_cover  = 2 THEN "use car" 
                                                       ELSE "BIKE"
            
              tlt.filler1      = IF ra_pree = 1 THEN "แถม"
                                                ELSE "ไม่แถม"
              tlt.filler2      = IF ra_comp = 1 THEN "แถม"
                                 ELSE IF ra_comp = 2 THEN "ไม่แถม"  
                                 ELSE "ไม่เอาพรบ."
             tlt.comp_sub     = trim(fi_producer)        
             tlt.recac        = trim(fi_agent)
             tlt.colorcod     = caps(trim(fi_cmrsty)) 
             tlt.policy       = caps(trim(fi_notno70))       
             tlt.comp_pol     = caps(trim(fi_notno72))
             tlt.ins_name     = trim(fi_institle )  + " " +    
                                trim(fi_preinsur )  + " " +      
                                trim(fi_preinsur2 )
              tlt.endno        = trim(fi_idno) 
              tlt.dat_ins_noti = fi_birthday    /*birthday*//*date */  
              tlt.seqno        = fi_age          /*age      *//*inte */ 
              tlt.entdat       = fi_idnoexpdat
              tlt.flag         = trim(fi_occup)       /*occupn   */  
              tlt.usrsent      = trim(fi_namedrirect) /*name direct */  
              tlt.ins_addr1    =  trim((IF n_banno = "" THEN "" ELSE "เลขที่ " + TRIM(n_banno) + " " )  + 
                                (IF n_muno  = "" THEN "" ELSE "หมู่ "   + TRIM(n_muno)  + " " )  + 
                                (IF (co_addr + trim(n_build)) = "" THEN "" 
                                      ELSE  (co_addr + trim(n_build))  + " " )  + 
                                (IF n_soy   = "" THEN "" ELSE "ซอย"     + TRIM(n_soy) + " " )  +     
                                (IF n_road  = "" THEN "" ELSE "ถนน"     + TRIM(n_road))) 
              tlt.ins_addr2     = trim(fi_insadd2tam)     
              tlt.ins_addr3     = TRIM(fi_insadd3amp)     
              tlt.ins_addr4     = TRIM(fi_insadd4cunt)     
              tlt.ins_addr5     = TRIM(fi_insadd5post)   

              tlt.comp_noti_ins = TRIM(fi_insadd6tel) + FILL(" ", 20 - LENGTH(TRIM(fi_insadd6tel))) + nv_chknotes /* Add by Phaiboon W. [A59-0625] DAte 22/12/2016 */
                                                        
              tlt.comp_noti_tlt = trim(fi_refer)         
              tlt.rec_name      = trim(fi_recipname)  
              tlt.comp_usr_tlt  = trim(fi_vatcode) 
              tlt.expousr       = "BR:" + TRIM(fi_userbr) + " USER:" + trim(fi_user)
              tlt.comp_usr_ins  = trim(fi_benname)   
    
              n_remark1         = USERID(LDBNAME(1))  + " : " + TRIM(fi_remark1)  
              n_remark1         = n_remark1 + FILL(" ", 100 - LENGTH(n_remark1))

              n_remark2         = TRIM(fi_remark2)                              
              n_remark2         = n_remark2 + FILL(" ", 100 - LENGTH(n_remark2))
                
              n_other1          = "อุปกรณ์เสริมคุ้มครองไม่เกิน"
              n_other1          = n_other1 + FILL(" ", 50 - LENGTH(n_other1))
              n_other2          = STRING(n_other2) + FILL(" " , 10 - LENGTH(STRING(n_other2))) 
              n_other3          = STRING(n_other3) + FILL(" " , 60 - LENGTH(STRING(n_other3)))
                                                                                                                         
              tlt.OLD_cha       = n_remark1 + n_remark2 + n_other1 + n_other2 + n_other3 + n_quota + n_garage

              tlt.OLD_eng       = IF ra_complete = 1 THEN "complete"  ELSE "not complete"
              tlt.rec_addr4     = TRIM(fi_deler)           
              tlt.genusr        = "Phone"  
              tlt.imp           = "IM"                     /*Import Data*/
              /*tlt.releas        = "No"*/ /* A62-0343 */
              tlt.endno         = fi_idno 
              tlt.dat_ins_noti  = fi_birthday    /*birthday*//*date */  
              tlt.seqno         = fi_age         /*age      *//*inte */           
              tlt.flag          = fi_occup       /*occupn   */  
              tlt.usrsent       = fi_namedrirect . /*name direct */
                                                                                                         
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


&Scoped-define SELF-NAME co_title
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL co_title C-Win
ON LEAVE OF co_title IN FRAME fr_main
DO:
  co_title = INPUT co_title. 
   
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL co_title C-Win
ON return OF co_title IN FRAME fr_main
DO:
  APPLY "LEAVE" TO co_title.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL co_title C-Win
ON VALUE-CHANGED OF co_title IN FRAME fr_main
DO:
    co_title = INPUT co_title .
    ASSIGN fi_institle = INPUT co_title
        co_title = "" .
  /*IF co_title = "" THEN DO:
      APPLY "entry" TO fi_user2.
      RETURN NO-APPLY.
  END.*/
  DISP co_title fi_institle WITH FRAM fr_main.
   
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME co_user
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL co_user C-Win
ON VALUE-CHANGED OF co_user IN FRAME fr_main
DO:
   co_user = INPUT co_user .
   fi_userbr = co_user.
   DISP co_user fi_userbr WITH FRAM fr_main.
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


&Scoped-define SELF-NAME fi_agent
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_agent C-Win
ON LEAVE OF fi_agent IN FRAME fr_main
DO:
    fi_agent  = caps(INPUT fi_agent).
    DISP fi_agent WITH FRAM fr_main.
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


&Scoped-define SELF-NAME fi_deler
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_deler C-Win
ON LEAVE OF fi_deler IN FRAME fr_main
DO:
    fi_deler  = caps(INPUT fi_deler).
    DISP fi_deler WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_idno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_idno C-Win
ON LEAVE OF fi_idno IN FRAME fr_main
DO:
    fi_idno  = INPUT fi_idno.

    DISP fi_idno WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


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


&Scoped-define SELF-NAME fi_producer
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_producer C-Win
ON LEAVE OF fi_producer IN FRAME fr_main
DO:
    fi_producer  = caps(INPUT fi_producer).
    DISP fi_producer WITH FRAM fr_main.
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


&Scoped-define SELF-NAME fi_user
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_user C-Win
ON LEAVE OF fi_user IN FRAME fr_main
DO:
  fi_user =  Input  fi_user.
  Disp  fi_user with frame  fr_main.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_userbr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_userbr C-Win
ON LEAVE OF fi_userbr IN FRAME fr_main
DO:
  fi_userbr =  Input  fi_userbr.
  Disp  fi_userbr with frame  fr_main. 
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
    APPLY "Entry" TO fi_benname.
    RETURN NO-APPLY.
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
    DISP ra_cover fi_comco fi_producer fi_agent  WITH FRAM fr_main. 
    /*
    APPLY "ENTRY" TO fi_cover1.
    RETURN NO-APPLY.
    */

   /* /* Begin by Phaiboon W. [A59-0488] Date 07/11/2016 */
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
    /* End by Phaiboon W. [A59-0488] Date 07/11/2016 */*/
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


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK C-Win 


/* ***************************  Main Block  *************************** */
/* Set CURRENT-WINDOW: this will parent dialog-boxes and frames.        */
ASSIGN CURRENT-WINDOW                = {&WINDOW-NAME} 
    THIS-PROCEDURE:CURRENT-WINDOW = {&WINDOW-NAME}.
ON CLOSE OF THIS-PROCEDURE 
    RUN disable_UI.
/* Best default for GUI applications is...                              */
PAUSE 0 BEFORE-HIDE.
MAIN-BLOCK:
DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
    ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:
    RUN enable_UI.
    /********************  T I T L E   F O R  C - W I N  ****************/
    DEF  VAR  gv_prgid   AS   CHAR.
    DEF  VAR  gv_prog    AS   CHAR.
    ASSIGN 
        gv_prgid = "wgwqupo21" 
        gv_prog  = "UPDATE  DATA BY TELEPHONE ...".
    RUN  WUT\WUTHEAD ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).
    /*********************************************************************/ 
   
    SESSION:DATA-ENTRY-RETURN = YES.
    
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
            ra_cover      =  IF      tlt.safe2 = "ป้ายแดง" THEN 1 
                             ELSE IF tlt.safe2 = "bike"    THEN 3  
                                                           ELSE 2 
            ra_pree       =  IF      trim(tlt.filler1) = "แถม"    THEN 1 ELSE 2
            ra_comp       =  IF      trim(tlt.filler2) = "แถม"    THEN 1 
                             ELSE IF trim(tlt.filler2) = "ไม่แถม" THEN 2 
                             ELSE 3
            fi_producer   =  tlt.comp_sub     
            fi_agent      =  tlt.recac 
            n_producernew =  tlt.comp_sub  
            n_produceruse =  tlt.comp_sub  
            n_producerbike = tlt.comp_sub  
            n_agent       =  tlt.recac      
            fi_deler      =  tlt.rec_addr4       
            fi_cmrsty     =  tlt.colorcod     
            fi_notno70    =  tlt.policy         
            fi_notno72    =  tlt.comp_pol 
            fi_institle   =  substr(tlt.ins_name,1,INDEX(tlt.ins_name," "))         
            fi_preinsur   =  IF index(tlt.ins_name,"และหรือ") = 0 then substr(tlt.ins_name,INDEX(tlt.ins_name," ") + 1,R-INDEX(tlt.ins_name," ") - INDEX(tlt.ins_name," "))
                             ELSE trim(substr(tlt.ins_name,INDEX(tlt.ins_name," ") + 1,R-INDEX(tlt.ins_name,"และหรือ") - 9 ))
            fi_preinsur2  =  IF index(tlt.ins_name,"และหรือ") = 0 THEN substr(tlt.ins_name,r-INDEX(tlt.ins_name," ") + 1) 
                             ELSE substr(tlt.ins_name,r-INDEX(tlt.ins_name,"และหรือ"))   
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
            fi_insadd6tel  = TRIM(SUBSTR(tlt.comp_noti_ins,1,20)) 
                             
            nv_chknotes    = SUBSTR(tlt.comp_noti_ins,21,1)  
            fi_refer       = tlt.comp_noti_tlt   
            fi_recipname   = tlt.rec_name        
            fi_vatcode     = tlt.comp_usr_tlt  
            fi_user         = IF INDEX(tlt.expousr,"USER:") <> 0 THEN SUBSTR(tlt.expousr,R-INDEX(tlt.expousr,"USER:") + 5) ELSE tlt.expousr
            fi_userbr       = IF INDEX(tlt.expousr,"BR:") <> 0 THEN SUBSTR(tlt.expousr,4,INDEX(tlt.expousr," ") + 1) ELSE ""
            fi_benname     = tlt.comp_usr_ins 
            nv_benname     = tlt.comp_usr_ins 
            
            fi_remark1  = TRIM(SUBSTR(tlt.OLD_cha,INDEX(tlt.old_cha,":") + 1, 100 - (INDEX(tlt.old_cha,":") + 1)))            
            fi_remark2  = TRIM(SUBSTR(tlt.OLD_cha,101,100))                  
            n_other2    = TRIM(SUBSTR(tlt.OLD_cha,251,10))   
            n_other3    = TRIM(SUBSTR(tlt.OLD_cha,261,60))
            n_quota     = TRIM(SUBSTR(tlt.OLD_cha,321,20))
            n_garage    = TRIM(SUBSTR(tlt.OLD_cha,341,20))

            ra_complete   =  IF trim(tlt.OLD_eng) =  "complete" THEN 1 ELSE 2
            fi_userid     =  tlt.usrid
            n_addr11      =  tlt.ins_addr1
            vAcProc_fil3   = " " 
            vAcProc_fil3   = vAcProc_fil3  + " " . 
            IF fi_institle = "" THEN fi_institle = "คุณ". 

        ASSIGN   
            vAcProc_fil4   = ""  
            vAcProc_fil5   = ""  
            vAcProc_fil6   = ""  
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
            co_addr:LIST-ITEMS    = vAcproc_fil5 
            nv_cartyp   = tlt.safe1              
            n_garage    = TRIM(SUBSTR(tlt.OLD_cha,341,20)).
    END. 
    RUN proc_initdata.

    FIND FIRST company WHERE Company.CompNo = fi_comco  NO-LOCK NO-ERROR NO-WAIT.
    IF   AVAIL company THEN  
        ASSIGN nv_benname     = Company.Name2  
        n_producernew  = company.Text1 
        n_produceruse  = company.Text2 
        n_producerbike = company.Text5   
        n_agent        = company.Text4.
    
    FOR EACH company WHERE company.NAME = "phone" NO-LOCK . 
    ASSIGN vAcProc_fil3   = vAcProc_fil3  + " " + "," + TRIM(company.NAME2).
    END.
    ASSIGN 
        co_benname:LIST-ITEMS = vAcProc_fil3 
        co_benname  = ENTRY(1,vAcProc_fil3)  .
   
    FOR EACH sicsyac.xmm023 NO-LOCK.
        ASSIGN   nv_brdesc = ""   nv_brcode = "" 
            nv_brdesc  = trim(xmm023.bdes)
            nv_brcode  = trim(xmm023.branch)
            nv_brcode  = IF LENGTH(nv_brcode) = 1 THEN " (D" + nv_brcode + ")" ELSE " (" + nv_brcode + ")"
            vAcProc_fil4 = vAcProc_fil4 + " " + "," + nv_brdesc + nv_brcode.
    END.
    ASSIGN co_user:LIST-ITEMS = vAcProc_fil4 
           co_user = ENTRY(1,vAcProc_fil4)  .
    
    FOR EACH brstat.msgcode WHERE brstat.msgcode.compno        = "999" NO-LOCK .
        ASSIGN vAcProc_fil6 = vAcProc_fil6 + " " + "," + trim(brstat.msgcode.branch).
    END.
    ASSIGN 
        co_title:LIST-ITEMS = vAcProc_fil6 
        co_title  = ENTRY(1,vAcProc_fil6)  .

    RUN  proc_dispable.
    Disp fi_notino       fi_comco        fi_cmrcode2     fi_cmrcode      fi_ins_off         
         fi_notdat       fi_nottim       fi_cmrsty       fi_producer     fi_agent             
         ra_cover        ra_pree         ra_comp         fi_notno70      fi_notno72      
         fi_institle     fi_preinsur     fi_preinsur2    fi_insadd1no    fi_insadd1mu    
         fi_insadd1build fi_insadd1soy   fi_insadd1road  fi_insadd2tam   fi_insadd3amp   
         fi_insadd4cunt  fi_insadd5post  fi_insadd6tel   fi_refer        fi_recipname    
         fi_vatcode      fi_user         co_benname      fi_benname                 
         ra_complete     fi_idno         co_addr         fi_birthday     fi_age          fi_occup                
         fi_namedrirect  fi_userid       fi_idnoexpdat   fi_deler        fi_remark1      fi_remark2  
         co_title  co_user fi_userbr     With FRAME fr_main.
    
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
  DISPLAY fi_ins_off fi_comco fi_cmrcode fi_cmrcode2 fi_producer fi_agent 
          fi_deler fi_institle fi_preinsur fi_preinsur2 fi_idno fi_birthday 
          fi_age fi_idnoexpdat fi_occup fi_namedrirect fi_insadd1no fi_insadd1mu 
          co_addr fi_insadd1build fi_insadd1soy fi_insadd1road fi_insadd2tam 
          fi_insadd3amp fi_insadd4cunt fi_insadd5post fi_insadd6tel fi_user 
          ra_complete fi_userid fi_notino fi_notdat fi_nottim co_title fi_refer 
          fi_recipname fi_vatcode fi_benname co_benname fi_remark1 fi_remark2 
          co_user fi_cmrsty ra_cover ra_pree ra_comp fi_userbr fi_notno70 
          fi_notno72 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE fi_ins_off fi_comco buselecom fi_cmrcode fi_cmrcode2 fi_producer 
         fi_agent fi_deler bu_create fi_institle fi_preinsur fi_preinsur2 
         fi_idno fi_birthday fi_age fi_idnoexpdat fi_occup fi_namedrirect 
         fi_insadd1no fi_insadd1mu co_addr fi_insadd1build fi_insadd1soy 
         fi_insadd1road fi_insadd2tam fi_insadd3amp fi_insadd4cunt 
         fi_insadd5post fi_insadd6tel fi_user ra_complete bu_save bu_exit 
         bu_not2 co_title fi_refer fi_recipname fi_vatcode fi_benname 
         co_benname fi_remark1 fi_remark2 co_user fi_cmrsty ra_cover ra_pree 
         ra_comp fi_notno70 fi_notno72 RECT-488 RECT-490 RECT-491 RECT-492 
         RECT-493 RECT-494 RECT-498 RECT-499 
      WITH FRAME fr_main IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
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
      tlt.releas        = "yes"   NO-LOCK NO-ERROR NO-WAIT .
If  avail  tlt  THEN DO: 
    DISABLE buselecom    bu_create       bu_save
         fi_notino       fi_comco        fi_cmrcode2     fi_cmrcode      fi_ins_off         
         fi_notdat       fi_nottim       fi_cmrsty       fi_producer     fi_agent           
         ra_cover        ra_pree         ra_comp         fi_notno70      fi_notno72      fi_institle        
         fi_preinsur     fi_preinsur2    fi_insadd1no    fi_insadd1mu    fi_insadd1build
         fi_insadd1soy   fi_insadd1road  fi_insadd2tam   fi_insadd3amp   fi_insadd4cunt  
         fi_insadd5post  fi_insadd6tel   fi_refer        fi_recipname    
         fi_vatcode      fi_user         co_benname      fi_remark1      fi_remark2
         fi_userbr   co_user   fi_userbr  ra_complete     fi_userid WITH FRAM fr_main.
END.

/* A62-0345*/
Find  tlt  Where   Recid(tlt)  =  nv_recidtlt  AND
      INDEX(tlt.releas,"CA") <> 0   NO-LOCK NO-ERROR NO-WAIT .
If  avail  tlt  THEN DO: 
    DISABLE buselecom    bu_create       bu_save
         fi_notino       fi_comco        fi_cmrcode2     fi_cmrcode      fi_ins_off         
         fi_notdat       fi_nottim       fi_cmrsty       fi_producer     fi_agent           
         ra_cover        ra_pree         ra_comp         fi_notno70      fi_notno72      fi_institle        
         fi_preinsur     fi_preinsur2    fi_insadd1no    fi_insadd1mu    fi_insadd1build
         fi_insadd1soy   fi_insadd1road  fi_insadd2tam   fi_insadd3amp   fi_insadd4cunt  
         fi_insadd5post  fi_insadd6tel   fi_refer        fi_recipname    
         fi_vatcode      fi_user         co_benname      fi_remark1      fi_remark2
         fi_userbr   co_user   fi_userbr  ra_complete     fi_userid WITH FRAM fr_main.
END.
/* end A62-0345*/



 
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
do: 
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

   /* IF INDEX(n_addr11,"หมู่") = 0 THEN ASSIGN fi_insadd1mu = "".  
    ELSE ASSIGN fi_insadd1mu  = SUBSTR(n_addr11,INDEX(n_addr11,"หมู่") + 5 )
        n_muno  = SUBSTR(n_addr11,INDEX(n_addr11,"หมู่") + 5 )
        n_addr11 = SUBSTR(n_addr11,1,length(n_addr11) - (LENGTH(fi_insadd1mu)) - 5 ).

    IF INDEX(n_addr11,"เลขที่") = 0 THEN ASSIGN fi_insadd1no = "".  
    ELSE ASSIGN fi_insadd1no = SUBSTR(n_addr11,8)
        n_banno      = SUBSTR(n_addr11,8) . */


    IF INDEX(n_addr11,"หมู่ที่") <> 0 THEN DO:
        ASSIGN fi_insadd1mu  = SUBSTR(n_addr11,INDEX(n_addr11,"หมู่ที่") + 8 )
        n_muno  = SUBSTR(n_addr11,INDEX(n_addr11,"หมู่ที่") + 8 )
        n_addr11 = SUBSTR(n_addr11,1,length(n_addr11) - (LENGTH(fi_insadd1mu)) - 8 ).
    END.
    ELSE IF INDEX(n_addr11,"หมู่") <> 0 THEN DO:
        ASSIGN fi_insadd1mu  = SUBSTR(n_addr11,INDEX(n_addr11,"หมู่") + 5 )
        n_muno  = SUBSTR(n_addr11,INDEX(n_addr11,"หมู่") + 5 )
        n_addr11 = SUBSTR(n_addr11,1,length(n_addr11) - (LENGTH(fi_insadd1mu)) - 5 ).
    END.
    ELSE IF INDEX(n_addr11,"ม.") <> 0 THEN DO:
        ASSIGN fi_insadd1mu  = SUBSTR(n_addr11,INDEX(n_addr11,"ม.") + 3 )
        n_muno  = SUBSTR(n_addr11,INDEX(n_addr11,"ม.") + 3 )
        n_addr11 = SUBSTR(n_addr11,1,length(n_addr11) - (LENGTH(fi_insadd1mu)) - 3 ).
    END.
    ELSE ASSIGN fi_insadd1mu  = "" .

    IF INDEX(n_addr11,"เลขที่") <> 0 THEN DO:
        ASSIGN fi_insadd1no = SUBSTR(n_addr11,8)
               n_banno      = SUBSTR(n_addr11,8) .
    END.
    ELSE ASSIGN fi_insadd1no = TRIM(n_addr11)
                n_banno      = TRIM(n_addr11).

END.    
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

