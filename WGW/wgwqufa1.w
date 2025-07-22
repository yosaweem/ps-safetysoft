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
program id       :  wuwqufa1.w 
program name     :  Update data fax to create  new policy  Add in table  tlt  
                    Quey & Update data before Gen.
Create  by       :  Kridtiya i. A56-0024  date. 31/01/2013
Connect          :  GW_SAFE -LD SIC_BRAN, GW_STAT -LD BRSTAT ,SICSYAC  ,SICUW ,STAT 
Database Connect :  gw_stat ld brstat , gw_safe ld sic_bran ,sic_test ld sicuw sicsyac  stat
+++++++++++++++++++++++++++++++++++++++++++++++*/
Def  Input  parameter  nv_recidtlt as  recid  . 
DEF                VAR nv_index    as int  init 0.
DEF  NEW   SHARED  VAR gComp       AS CHAR.
DEF  NEW   SHARED  VAR n_agent1    LIKE sicsyac.xmm600.acno. 
DEF  NEW   SHARED  VAR n_agent2    LIKE sicsyac.xmm600.acno. 
/* Parameters Definitions ---                                           */
Def  VAR   n_name     As   Char    Format    "x(35)".
Def  VAR   n_nO1      As   Char    Format    "x(35)".
Def  VAR   n_nO2      As   Char    Format    "x(35)".
Def  VAR   n_nO3      As   Char    Format    "x(35)".
DEF  VAR   n_text     AS   CHAR    FORMAT    "x(35)".
Def  VAR   n_chkname  As   Char    Format    "x(35)".
DEFINE VAR vAcProc_fil  AS CHAR.
DEFINE VAR vAcProc_fil3  AS CHAR.
DEFINE  WORKFILE wdetail NO-UNDO
/*1*/  FIELD provi_no       AS CHAR      FORMAT "x(5)"
/*2*/  FIELD provi_name     AS CHARACTER FORMAT "X(30)"   INITIAL "".
DEF VAR n_poltyp  AS CHAR INIT "".
DEF VAR nv_brnpol AS CHAR INIT "".
DEF VAR n_undyr2  AS CHAR INIT "".
DEF VAR n_brsty   AS CHAR INIT "".
DEF VAR n_br      AS CHAR INIT "" FORMAT "x(5)" .
DEFINE VAR nv_check     AS  CHARACTER  INITIAL ""  NO-UNDO.
DEFINE VAR nv_check70   AS  CHARACTER  INITIAL ""  NO-UNDO.
DEFINE VAR nv_check72   AS  CHARACTER  INITIAL ""  NO-UNDO.
DEF VAR n_banno         AS  CHAR  INIT "" FORMAT "x(20)".
DEF VAR n_muno          AS  CHAR  INIT "" FORMAT "x(20)".
DEF VAR n_build         AS  CHAR  INIT "" FORMAT "x(50)".
DEF VAR n_road          AS  CHAR  INIT "" FORMAT "x(40)".
DEF VAR n_soy           AS  CHAR  INIT "" FORMAT "x(40)".
DEF VAR n_addr11        AS  CHAR  INIT "" FORMAT "x(200)".
DEF VAR nv_benname      AS  CHAR  INIT "" FORMAT "x(10)".
DEF VAR n_producernew   As  Char  Format    "x(10)".  /*A56-0024*/
DEF VAR n_produceruse   As  Char  Format    "x(10)".  /*A56-0024*/
DEF VAR n_agent         As  Char  Format    "x(10)".  /*A56-0024*/

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
fi_cmrcode2 fi_campaign ra_car ra_cover fi_cover1 bu_cover ra_pa fi_product ~
bu_product ra_pree ra_comp fi_producer fi_agent fi_deler fi_cmrsty ~
fi_notno70 fi_notno72 bu_create fi_institle fi_preinsur fi_preinsur2 ~
fi_idno fi_birthday fi_age fi_idnoexpdat fi_occup fi_namedrirect ~
fi_insadd1no fi_insadd1mu ra_ban fi_insadd1build fi_insadd1soy ~
fi_insadd1road fi_insadd2tam fi_insadd3amp fi_insadd4cunt fi_insadd5post ~
fi_insadd6tel fi_comdat fi_expdat fi_ispno fi_brand fi_model bu_model ~
fi_year fi_power fi_licence1 fi_licence2 fi_provin fi_cha_no fi_eng_no ~
fi_pack fi_class fi_garage fi_sumsi fi_gap fi_premium fi_precomp ~
fi_totlepre fi_stk fi_refer fi_recipname fi_vatcode fi_user fi_benname ~
co_benname fi_remark1 ra_complete bu_save bu_exit ra_driv RECT-488 RECT-489 ~
RECT-490 RECT-491 RECT-492 RECT-493 
&Scoped-Define DISPLAYED-OBJECTS fi_ins_off fi_comco fi_cmrcode fi_cmrcode2 ~
fi_campaign ra_car ra_cover fi_cover1 ra_pa fi_product ra_pree ra_comp ~
fi_producer fi_agent fi_deler fi_cmrsty fi_notno70 fi_notno72 fi_institle ~
fi_preinsur fi_preinsur2 fi_idno fi_birthday fi_age fi_idnoexpdat fi_occup ~
fi_namedrirect fi_insadd1no fi_insadd1mu ra_ban fi_insadd1build ~
fi_insadd1soy fi_insadd1road fi_insadd2tam fi_insadd3amp fi_insadd4cunt ~
fi_insadd5post fi_insadd6tel fi_comdat fi_expdat fi_ispno fi_brand fi_model ~
fi_year fi_power fi_licence1 fi_licence2 fi_provin fi_cha_no fi_eng_no ~
fi_pack fi_class fi_garage fi_sumsi fi_gap fi_premium fi_precomp ~
fi_totlepre fi_stk fi_refer fi_recipname fi_vatcode fi_user fi_benname ~
co_benname fi_remark1 ra_complete fi_userid ra_driv fi_notino fi_notdat ~
fi_nottim 

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
     BGCOLOR 2 FGCOLOR 7 FONT 6 NO-UNDO.

DEFINE VARIABLE ra_sex2 AS INTEGER 
     VIEW-AS RADIO-SET VERTICAL
     RADIO-BUTTONS 
          "Male", 1,
"Female", 2
     SIZE 10 BY .95
     BGCOLOR 2 FGCOLOR 7 FONT 6 NO-UNDO.

DEFINE BUTTON buselecom 
     IMAGE-UP FILE "I:/Safety/WALP10/WIMAGE/next.bmp":U
     LABEL "" 
     SIZE 4 BY .95.

DEFINE BUTTON bu_cover 
     IMAGE-UP FILE "I:/Safety/WALP10/WIMAGE/next.bmp":U
     LABEL "" 
     SIZE 3.5 BY .95.

DEFINE BUTTON bu_create 
     LABEL "Create" 
     SIZE 7.5 BY 1
     FONT 6.

DEFINE BUTTON bu_exit 
     LABEL "Exit" 
     SIZE 7.5 BY .95
     FONT 6.

DEFINE BUTTON bu_model 
     IMAGE-UP FILE "I:/Safety/WALP10/WIMAGE/next.bmp":U
     LABEL "" 
     SIZE 3.5 BY .95.

DEFINE BUTTON bu_product 
     IMAGE-UP FILE "I:/Safety/WALP10/WIMAGE/next.bmp":U
     LABEL "" 
     SIZE 3.5 BY .95.

DEFINE BUTTON bu_save 
     LABEL "Save" 
     SIZE 7.5 BY .95
     FONT 6.

DEFINE VARIABLE co_benname AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS COMBO-BOX INNER-LINES 5
     DROP-DOWN-LIST
     SIZE 60 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_age AS INTEGER FORMAT "->>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 4.5 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_agent AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 11.5 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_benname AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 60 BY .91
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

DEFINE VARIABLE fi_cover1 AS CHARACTER FORMAT "X(1)":U 
     VIEW-AS FILL-IN 
     SIZE 4 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_deler AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 13 BY .95
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
     SIZE 18 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_insadd1mu AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 5 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_insadd1no AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 10 BY .95
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
     SIZE 27 BY .95
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
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_notino AS CHARACTER FORMAT "X(35)":U 
     VIEW-AS FILL-IN 
     SIZE 17 BY .95
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_notno70 AS CHARACTER FORMAT "X(16)":U 
     VIEW-AS FILL-IN 
     SIZE 18 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_notno72 AS CHARACTER FORMAT "X(16)":U 
     VIEW-AS FILL-IN 
     SIZE 18 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_nottim AS CHARACTER FORMAT "X(13)":U 
     VIEW-AS FILL-IN 
     SIZE 10 BY .95
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_occup AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 20 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_pack AS CHARACTER FORMAT "X(1)":U 
     VIEW-AS FILL-IN 
     SIZE 3.5 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_power AS DECIMAL FORMAT ">>,>>9.99":U INITIAL ? 
     VIEW-AS FILL-IN 
     SIZE 11 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_precomp AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 10 BY .95
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

DEFINE VARIABLE fi_producer AS CHARACTER FORMAT "X(10)":U 
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

DEFINE VARIABLE fi_recipname AS CHARACTER FORMAT "X(100)":U INITIAL ? 
     VIEW-AS FILL-IN 
     SIZE 33 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_refer AS CHARACTER FORMAT "X(35)":U 
     VIEW-AS FILL-IN 
     SIZE 21 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_remark1 AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 60 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_stk AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 20 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_sumsi AS DECIMAL FORMAT "->>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 16 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_totlepre AS DECIMAL FORMAT "->,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 14.5 BY .95
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
     SIZE 8 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE ra_ban AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "non", 1,
"อาคาร", 2,
"หมู่บ้าน", 3
     SIZE 24 BY .95 NO-UNDO.

DEFINE VARIABLE ra_car AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "เก๋ง", 1,
"กระบะ", 2,
"โดยสาร", 3
     SIZE 24.5 BY .95
     BGCOLOR 5 FGCOLOR 7 FONT 6 NO-UNDO.

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
"User car", 2
     SIZE 21.5 BY .95
     BGCOLOR 2 FGCOLOR 7 FONT 6 NO-UNDO.

DEFINE VARIABLE ra_driv AS INTEGER 
     VIEW-AS RADIO-SET VERTICAL
     RADIO-BUTTONS 
          "ไม่ระบุ", 1,
"ระบุ", 2
     SIZE 9 BY 2.38
     BGCOLOR 2 FGCOLOR 7  NO-UNDO.

DEFINE VARIABLE ra_pa AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "ไม่ขายPA", 1,
"ขายPA", 2
     SIZE 20 BY .95
     BGCOLOR 2 FGCOLOR 7  NO-UNDO.

DEFINE VARIABLE ra_pree AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "แถม  ", 1,
"ไม่แถม", 2
     SIZE 19 BY .95
     FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-488
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 132.5 BY 23.86
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-489
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 40.33 BY 2.52
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
     fi_ins_off AT ROW 3.33 COL 17.5 COLON-ALIGNED NO-LABEL
     fi_comco AT ROW 3.33 COL 51.33 COLON-ALIGNED NO-LABEL
     buselecom AT ROW 3.33 COL 64.67
     fi_cmrcode AT ROW 3.33 COL 73.17 COLON-ALIGNED NO-LABEL
     fi_cmrcode2 AT ROW 3.33 COL 95 COLON-ALIGNED NO-LABEL
     fi_campaign AT ROW 3.33 COL 115.5 COLON-ALIGNED NO-LABEL
     ra_car AT ROW 4.38 COL 19.83 NO-LABEL
     ra_cover AT ROW 4.38 COL 44.83 NO-LABEL
     fi_cover1 AT ROW 4.38 COL 83.5 COLON-ALIGNED NO-LABEL
     bu_cover AT ROW 4.38 COL 89.83
     ra_pa AT ROW 4.38 COL 93.83 NO-LABEL
     fi_product AT ROW 4.38 COL 120.67 COLON-ALIGNED NO-LABEL
     bu_product AT ROW 4.38 COL 129
     ra_pree AT ROW 5.38 COL 19.83 NO-LABEL
     ra_comp AT ROW 5.38 COL 46 NO-LABEL
     fi_producer AT ROW 6.43 COL 17.83 COLON-ALIGNED NO-LABEL
     fi_agent AT ROW 6.43 COL 37.67 COLON-ALIGNED NO-LABEL
     fi_deler AT ROW 6.43 COL 57.67 COLON-ALIGNED NO-LABEL
     fi_cmrsty AT ROW 6.43 COL 75.33 COLON-ALIGNED NO-LABEL
     fi_notno70 AT ROW 5.76 COL 93.17 COLON-ALIGNED NO-LABEL
     fi_notno72 AT ROW 6.86 COL 93.17 COLON-ALIGNED NO-LABEL
     bu_create AT ROW 6.38 COL 114
     fi_institle AT ROW 8.52 COL 17.67 COLON-ALIGNED NO-LABEL
     fi_preinsur AT ROW 8.52 COL 37.33 COLON-ALIGNED NO-LABEL
     fi_preinsur2 AT ROW 8.52 COL 75.17 COLON-ALIGNED NO-LABEL
     fi_idno AT ROW 8.52 COL 110.33 COLON-ALIGNED NO-LABEL
     fi_birthday AT ROW 9.57 COL 17.67 COLON-ALIGNED NO-LABEL
     fi_age AT ROW 9.57 COL 36.17 COLON-ALIGNED NO-LABEL
     fi_idnoexpdat AT ROW 9.57 COL 54 COLON-ALIGNED NO-LABEL
     fi_occup AT ROW 9.57 COL 74.33 COLON-ALIGNED NO-LABEL
     fi_namedrirect AT ROW 9.57 COL 107.17 COLON-ALIGNED NO-LABEL
     fi_insadd1no AT ROW 10.67 COL 17.67 COLON-ALIGNED NO-LABEL
     fi_insadd1mu AT ROW 10.67 COL 32.33 COLON-ALIGNED NO-LABEL
     ra_ban AT ROW 10.67 COL 39.67 NO-LABEL
     fi_insadd1build AT ROW 10.67 COL 62.17 COLON-ALIGNED NO-LABEL
     fi_insadd1soy AT ROW 10.67 COL 86.5 COLON-ALIGNED NO-LABEL
     fi_insadd1road AT ROW 10.67 COL 111.33 COLON-ALIGNED NO-LABEL
     fi_insadd2tam AT ROW 11.76 COL 17.67 COLON-ALIGNED NO-LABEL
     fi_insadd3amp AT ROW 11.76 COL 47 COLON-ALIGNED NO-LABEL
     fi_insadd4cunt AT ROW 11.76 COL 73 COLON-ALIGNED NO-LABEL
     fi_insadd5post AT ROW 11.76 COL 96.67 COLON-ALIGNED NO-LABEL
     fi_insadd6tel AT ROW 11.76 COL 114.33 COLON-ALIGNED NO-LABEL
     fi_comdat AT ROW 12.81 COL 34.5 COLON-ALIGNED NO-LABEL
     fi_expdat AT ROW 12.81 COL 72.17 COLON-ALIGNED NO-LABEL
     fi_ispno AT ROW 12.81 COL 102 COLON-ALIGNED NO-LABEL
     fi_brand AT ROW 13.86 COL 17.67 COLON-ALIGNED NO-LABEL
     fi_model AT ROW 13.86 COL 44.83 COLON-ALIGNED NO-LABEL
     bu_model AT ROW 13.86 COL 89.67
     fi_year AT ROW 13.86 COL 98.67 COLON-ALIGNED NO-LABEL
     fi_power AT ROW 13.86 COL 118 COLON-ALIGNED NO-LABEL
     fi_licence1 AT ROW 14.95 COL 17.67 COLON-ALIGNED NO-LABEL
     fi_licence2 AT ROW 14.95 COL 24.67 COLON-ALIGNED NO-LABEL
     fi_provin AT ROW 14.95 COL 31.5 COLON-ALIGNED NO-LABEL DISABLE-AUTO-ZAP 
     fi_cha_no AT ROW 14.95 COL 68.83 COLON-ALIGNED NO-LABEL
     fi_eng_no AT ROW 14.95 COL 105.83 COLON-ALIGNED NO-LABEL
     fi_pack AT ROW 18.52 COL 17.67 COLON-ALIGNED NO-LABEL
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 24
         BGCOLOR 3 FGCOLOR 1 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     fi_class AT ROW 18.52 COL 28.67 COLON-ALIGNED NO-LABEL
     fi_garage AT ROW 18.52 COL 44 COLON-ALIGNED NO-LABEL
     fi_sumsi AT ROW 18.52 COL 59.5 COLON-ALIGNED NO-LABEL
     fi_gap AT ROW 18.52 COL 85 COLON-ALIGNED NO-LABEL
     fi_premium AT ROW 18.52 COL 115.5 COLON-ALIGNED NO-LABEL
     fi_precomp AT ROW 19.57 COL 17.67 COLON-ALIGNED NO-LABEL
     fi_totlepre AT ROW 19.57 COL 37.17 COLON-ALIGNED NO-LABEL
     fi_stk AT ROW 19.57 COL 71.83 COLON-ALIGNED NO-LABEL
     fi_refer AT ROW 19.57 COL 108 COLON-ALIGNED NO-LABEL
     fi_recipname AT ROW 20.62 COL 17.67 COLON-ALIGNED NO-LABEL
     fi_vatcode AT ROW 20.62 COL 62.67 COLON-ALIGNED NO-LABEL
     fi_user AT ROW 20.62 COL 90 COLON-ALIGNED NO-LABEL
     fi_benname AT ROW 21.67 COL 17.67 COLON-ALIGNED NO-LABEL
     co_benname AT ROW 22.67 COL 17.67 COLON-ALIGNED NO-LABEL
     fi_remark1 AT ROW 23.81 COL 17.67 COLON-ALIGNED NO-LABEL
     ra_complete AT ROW 23.1 COL 82 NO-LABEL
     bu_save AT ROW 23.14 COL 113.5
     bu_exit AT ROW 23.1 COL 124
     fi_userid AT ROW 7 COL 121.83 COLON-ALIGNED NO-LABEL
     ra_driv AT ROW 16 COL 2 NO-LABEL
     fi_notino AT ROW 2.24 COL 29.33 COLON-ALIGNED NO-LABEL
     fi_notdat AT ROW 2.24 COL 59.67 COLON-ALIGNED NO-LABEL
     fi_nottim AT ROW 2.24 COL 85.5 COLON-ALIGNED NO-LABEL
     "รหัสบริษัท:":30 VIEW-AS TEXT
          SIZE 10 BY .95 AT ROW 3.33 COL 43
          BGCOLOR 18 FGCOLOR 1 FONT 6
     " รหัส:":35 VIEW-AS TEXT
          SIZE 5 BY .95 AT ROW 3.33 COL 91.67
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "         ผู้แจ้ง MKT:":35 VIEW-AS TEXT
          SIZE 17 BY .95 AT ROW 3.33 COL 2
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "Reference no:":30 VIEW-AS TEXT
          SIZE 14 BY .95 AT ROW 19.57 COL 95.33
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "Notify no.:" VIEW-AS TEXT
          SIZE 11 BY .95 AT ROW 2.24 COL 19.83
          BGCOLOR 18 FGCOLOR 2 FONT 6
     "Br:":35 VIEW-AS TEXT
          SIZE 3.5 BY .95 AT ROW 6.43 COL 73.33
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "วันที่เริ่มค้มครอง :":35 VIEW-AS TEXT
          SIZE 16 BY .95 AT ROW 12.81 COL 19.83
          BGCOLOR 18 FGCOLOR 4 FONT 6
     "เลขตรวจสภาพ :":30 VIEW-AS TEXT
          SIZE 15 BY .95 AT ROW 12.81 COL 88.67
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "           ข้อมูลลูกค้า" VIEW-AS TEXT
          SIZE 17 BY .95 AT ROW 7.52 COL 2
          BGCOLOR 2 FGCOLOR 7 FONT 6
     " รุ่นรถ :":30 VIEW-AS TEXT
          SIZE 8 BY .95 AT ROW 13.86 COL 38.33
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "วันหมดอายุความคุ้มครอง :":35 VIEW-AS TEXT
          SIZE 22.5 BY .95 AT ROW 12.81 COL 51
          BGCOLOR 18 FGCOLOR 4 FONT 6
     "         ทะเบียนรถ :":30 VIEW-AS TEXT
          SIZE 17 BY .95 AT ROW 14.95 COL 2
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "                เลขที่  :":30 VIEW-AS TEXT
          SIZE 17 BY .95 AT ROW 10.67 COL 2
          BGCOLOR 18 FGCOLOR 2 FONT 6
     "    8.3  ไฟแนนซ์ :":30 VIEW-AS TEXT
          SIZE 17 BY .91 AT ROW 21.67 COL 2
          BGCOLOR 18 FGCOLOR 0 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 24
         BGCOLOR 3 FGCOLOR 1 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "เบี้ยรวม":30 VIEW-AS TEXT
          SIZE 8 BY .95 AT ROW 19.57 COL 30.33
          BGCOLOR 18 FGCOLOR 0 FONT 6
     " ทุนประกัน :":30 VIEW-AS TEXT
          SIZE 11 BY .95 AT ROW 18.52 COL 50.17
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "           เบี้ย พรบ.:":30 VIEW-AS TEXT
          SIZE 17 BY .95 AT ROW 19.57 COL 2
          BGCOLOR 18 FGCOLOR 0 FONT 6
     " Policy 70 :":35 VIEW-AS TEXT
          SIZE 11.5 BY .95 AT ROW 5.81 COL 83.33
          BGCOLOR 3 FGCOLOR 0 FONT 6
     "             ยี่ห้อรถ  :":30 VIEW-AS TEXT
          SIZE 17 BY .95 AT ROW 13.86 COL 2
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "       ตำบล/แขวง  :":30 VIEW-AS TEXT
          SIZE 17 BY .95 AT ROW 11.76 COL 2
          BGCOLOR 18 FGCOLOR 2 FONT 6
     "โทรศัพท์:":30 VIEW-AS TEXT
          SIZE 8 BY .95 AT ROW 11.76 COL 107.83
          BGCOLOR 18 FGCOLOR 2 FONT 6
     " NOTIFY  ENTRY" VIEW-AS TEXT
          SIZE 17 BY .95 AT ROW 2.24 COL 2
          BGCOLOR 15 FGCOLOR 1 FONT 6
     " สาขา :":35 VIEW-AS TEXT
          SIZE 5.5 BY .95 AT ROW 3.33 COL 69.17
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "          Package :":35 VIEW-AS TEXT
          SIZE 17 BY .95 AT ROW 18.52 COL 2
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "เลขตัวถังรถ :":20 VIEW-AS TEXT
          SIZE 13 BY .95 AT ROW 14.95 COL 57.17
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "นามสกุล :":35 VIEW-AS TEXT
          SIZE 9 BY .95 AT ROW 8.52 COL 67.67
          BGCOLOR 18 FGCOLOR 2 FONT 6
     " ใบเสร็จออกในนาม :":35 VIEW-AS TEXT
          SIZE 17 BY .95 AT ROW 20.62 COL 2
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "                 คำนำ :":35 VIEW-AS TEXT
          SIZE 17 BY .95 AT ROW 8.52 COL 2
          BGCOLOR 18 FGCOLOR 2 FONT 6
     "Class :":35 VIEW-AS TEXT
          SIZE 6.5 BY .95 AT ROW 18.52 COL 23.67
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "บัตรหมดอายุ:":35 VIEW-AS TEXT
          SIZE 12 BY .95 AT ROW 9.57 COL 43.67
          BGCOLOR 18 FGCOLOR 2 FONT 6
     "    ประเภทประกัน :":30 VIEW-AS TEXT
          SIZE 17 BY .95 AT ROW 4.38 COL 2
          BGCOLOR 2 FGCOLOR 7 FONT 6
     " Agent :":30 VIEW-AS TEXT
          SIZE 7.5 BY .95 AT ROW 6.43 COL 31.83
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "ประเภทความคุ้มครอง" VIEW-AS TEXT
          SIZE 18.5 BY .95 AT ROW 4.38 COL 66.67
          BGCOLOR 5 FGCOLOR 7 FONT 6
     "เบี้ยสุทธฺ:":30 VIEW-AS TEXT
          SIZE 8.5 BY .95 AT ROW 18.52 COL 77.83
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "อำเภอ/เขต :":30 VIEW-AS TEXT
          SIZE 9.5 BY .95 AT ROW 11.76 COL 39
          BGCOLOR 18 FGCOLOR 2 FONT 6
     "              ประกัน :":30 VIEW-AS TEXT
          SIZE 17 BY .95 AT ROW 5.38 COL 2
          BGCOLOR 18 FGCOLOR 0 FONT 6
     " No.Time :":30 VIEW-AS TEXT
          SIZE 11 BY .95 AT ROW 2.24 COL 76.17
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "ขนาดCC :":30 VIEW-AS TEXT
          SIZE 10 BY .95 AT ROW 13.86 COL 109.33
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "จังหวัด:":30 VIEW-AS TEXT
          SIZE 7 BY .95 AT ROW 11.76 COL 67.5
          BGCOLOR 18 FGCOLOR 2 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 24
         BGCOLOR 3 FGCOLOR 1 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "ถนน :":30 VIEW-AS TEXT
          SIZE 5 BY .95 AT ROW 10.67 COL 107.83
          BGCOLOR 18 FGCOLOR 2 FONT 6
     " Deler :":30 VIEW-AS TEXT
          SIZE 7.5 BY .95 AT ROW 6.43 COL 51.67
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "เลขพรบ.(สติ๊กเกอร์):":30 VIEW-AS TEXT
          SIZE 18.83 BY .95 AT ROW 19.57 COL 54.33
          BGCOLOR 18 FGCOLOR 0 FONT 6
     " ปีรถ :":35 VIEW-AS TEXT
          SIZE 6 BY .95 AT ROW 13.86 COL 93.83
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "Notify Date :":30 VIEW-AS TEXT
          SIZE 12 BY .95 AT ROW 2.24 COL 49
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "การซ่อม:":35 VIEW-AS TEXT
          SIZE 8.5 BY .95 AT ROW 18.52 COL 36.83
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "   ข้อมูลประกันภัย :":30 VIEW-AS TEXT
          SIZE 17 BY .95 AT ROW 12.81 COL 2.17
          BGCOLOR 2 FGCOLOR 7 FONT 6
     "IDno :":30 VIEW-AS TEXT
          SIZE 6 BY .95 AT ROW 8.52 COL 106
          BGCOLOR 18 FGCOLOR 2 FONT 6
     "เลขเครื่องยนต์ :":35 VIEW-AS TEXT
          SIZE 14 BY .95 AT ROW 14.95 COL 93.5
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "    UPDATE FAX   UPDATE FAX   UPDATE FAX  UPDATE FAX  DATA........." VIEW-AS TEXT
          SIZE 128.5 BY .95 AT ROW 1.14 COL 2
          BGCOLOR 12 FGCOLOR 7 FONT 2
     "อายุ:":35 VIEW-AS TEXT
          SIZE 4.5 BY .95 AT ROW 9.57 COL 33.33
          BGCOLOR 18 FGCOLOR 2 FONT 6
     "อาชีพ:":35 VIEW-AS TEXT
          SIZE 6 BY .95 AT ROW 9.57 COL 70
          BGCOLOR 18 FGCOLOR 2 FONT 6
     " ชื่อ :":35 VIEW-AS TEXT
          SIZE 5 BY .95 AT ROW 8.52 COL 34
          BGCOLOR 18 FGCOLOR 2 FONT 6
     "     วันเดือนปีเกิด :":35 VIEW-AS TEXT
          SIZE 17 BY .95 AT ROW 9.57 COL 2
          BGCOLOR 18 FGCOLOR 2 FONT 6
     " Policy 72 :":35 VIEW-AS TEXT
          SIZE 11.5 BY .95 AT ROW 6.86 COL 83.33
          BGCOLOR 3 FGCOLOR 0 FONT 6
     "Campaign No.:":35 VIEW-AS TEXT
          SIZE 14.5 BY .95 AT ROW 3.33 COL 102.5
          BGCOLOR 18 FGCOLOR 0 FONT 6
     " พรบ.":30 VIEW-AS TEXT
          SIZE 6 BY .95 AT ROW 5.38 COL 39.33
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "ชื่อกรรมการ:":35 VIEW-AS TEXT
          SIZE 12 BY .95 AT ROW 9.57 COL 96.83
          BGCOLOR 18 FGCOLOR 2 FONT 6
     "หมู่ :":30 VIEW-AS TEXT
          SIZE 4 BY .95 AT ROW 10.67 COL 29.83
          BGCOLOR 18 FGCOLOR 2 FONT 6
     "          Producer :":30 VIEW-AS TEXT
          SIZE 17 BY .95 AT ROW 6.43 COL 2
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "          หมายเหตุ :":30 VIEW-AS TEXT
          SIZE 17 BY .91 AT ROW 23.81 COL 2
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "เบี้ยรวมภาษีอากร :":30 VIEW-AS TEXT
          SIZE 16 BY .95 AT ROW 18.52 COL 101.17
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "Product" VIEW-AS TEXT
          SIZE 8 BY .95 AT ROW 4.38 COL 114.17
          BGCOLOR 29 FGCOLOR 2 FONT 6
     "User by:" VIEW-AS TEXT
          SIZE 9 BY 1 AT ROW 5.76 COL 123.17
          BGCOLOR 18 FGCOLOR 2 FONT 6
     "  Vatcode :":30 VIEW-AS TEXT
          SIZE 11 BY .95 AT ROW 20.62 COL 53.17
          BGCOLOR 18 FGCOLOR 0 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 24
         BGCOLOR 3 FGCOLOR 1 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     " ผู้รับแจ้ง :":35 VIEW-AS TEXT
          SIZE 11 BY .95 AT ROW 20.62 COL 80.17
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "รหัส:":30 VIEW-AS TEXT
          SIZE 4.5 BY .95 AT ROW 11.76 COL 93.5
          BGCOLOR 18 FGCOLOR 2 FONT 6
     "ซอย :":30 VIEW-AS TEXT
          SIZE 5 BY .95 AT ROW 10.67 COL 82.83
          BGCOLOR 18 FGCOLOR 2 FONT 6
     RECT-488 AT ROW 1 COL 1
     RECT-489 AT ROW 5.52 COL 82.33
     RECT-490 AT ROW 6.81 COL 123
     RECT-491 AT ROW 22.57 COL 122.67
     RECT-492 AT ROW 22.57 COL 112.33
     RECT-493 AT ROW 22.57 COL 80.5
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 24
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
         AT COL 11.33 ROW 16
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
         TITLE              = "UPDATE  DATA BY FAX ..."
         HEIGHT             = 24
         WIDTH              = 133.17
         MAX-HEIGHT         = 33.91
         MAX-WIDTH          = 174.67
         VIRTUAL-HEIGHT     = 33.91
         VIRTUAL-WIDTH      = 174.67
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
ON END-ERROR OF C-Win /* UPDATE  DATA BY FAX ... */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* UPDATE  DATA BY FAX ... */
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
                          INPUT-OUTPUT n_nO3,          
                          INPUT-OUTPUT nv_benname,     
                          INPUT-OUTPUT n_producernew,  
                          INPUT-OUTPUT n_produceruse,  
                          INPUT-OUTPUT n_agent,        
                          INPUT-OUTPUT n_text).
        IF n_text  = "save" THEN
            Assign 
            fi_benname   = nv_benname    
            fi_cmrcode2  = n_nO1
            fi_cmrcode   = n_nO2
            fi_cmrsty    = n_nO3  
            fi_comco     = gComp .
    END.
    ELSE DO:
        RUN wgw\wgwhpcom (INPUT-OUTPUT n_name,
                          INPUT-OUTPUT n_nO1,
                          INPUT-OUTPUT n_nO2,
                          INPUT-OUTPUT n_nO3,   
                          INPUT-OUTPUT nv_benname,      
                          INPUT-OUTPUT n_producernew,  
                          INPUT-OUTPUT n_produceruse,  
                          INPUT-OUTPUT n_agent,        
                          INPUT-OUTPUT n_text).
        IF n_text  = "save" THEN
            Assign fi_benname   = nv_benname    
            fi_cmrcode2  = n_nO1
            fi_cmrcode   = n_nO2
            fi_cmrsty    = n_nO3    
            fi_comco     = gComp .
        
        FIND FIRST brstat.company WHERE Company.CompNo = fi_comco NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL company THEN DO: 
            RUN wgw\wgwhpcom (INPUT-OUTPUT n_name,
                              INPUT-OUTPUT n_nO1,
                              INPUT-OUTPUT n_nO2,
                              INPUT-OUTPUT n_nO3,   
                              INPUT-OUTPUT nv_benname,      
                              INPUT-OUTPUT n_producernew,  
                              INPUT-OUTPUT n_produceruse,  
                              INPUT-OUTPUT n_agent,        
                              INPUT-OUTPUT n_text).
            Assign 
                fi_benname  = nv_benname    
                fi_cmrcode2 = n_nO1
                fi_cmrcode  = n_nO2
                fi_cmrsty   = n_nO3  
                fi_comco    = gComp.
        END.
    END.
    ASSIGN n_brsty = fi_cmrsty 
        fi_benname = nv_benname   .
    IF ra_cover = 1 THEN                   
        ASSIGN fi_producer = n_producernew
               fi_agent    = n_agent .      
    ELSE                                   
        ASSIGN fi_producer = n_produceruse
               fi_agent    = n_agent. 
    Disp fi_comco  fi_cmrcode2  fi_cmrcode  fi_producer fi_agent fi_benname  fi_cmrsty  with FRAM fr_main.
    IF fi_comco = "" THEN DO:
        APPLY "entry" TO fi_comco . 
        RETURN NO-APPLY.
    END.
    ELSE DO: 
        IF ra_cover = 1 THEN
            ASSIGN fi_pack = "G"
            fi_producer = n_producernew  
            fi_agent    =  n_agent    .
        ELSE 
            ASSIGN 
                fi_producer = n_produceruse 
                fi_agent    = n_agent    .
         Disp fi_comco fi_producer fi_agent fi_benname   
              fi_cmrcode2  fi_cmrcode  fi_cmrsty  with FRAM fr_main.
        
    END.
    IF fi_cmrsty = "" THEN ASSIGN fi_cmrsty = "M".
    ASSIGN n_brsty   = fi_cmrsty.     
    Disp fi_comco fi_producer fi_agent fi_benname 
         fi_cmrcode2  fi_cmrcode  fi_cmrsty fi_class with FRAM fr_main.
    APPLY "entry" TO fi_cmrcode . 
        RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_cover
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_cover C-Win
ON CHOOSE OF bu_cover IN FRAME fr_main
DO:
    Run  wgw\wgwhpco1(Input-output  fi_cover1).
    ASSIGN fi_benname   = nv_benname .     
    IF      fi_cover1 = "1" THEN ASSIGN fi_pack = "G".
    ELSE IF fi_cover1 = "2" THEN ASSIGN fi_pack = "Y".
    ELSE IF fi_cover1 = "3" THEN 
        ASSIGN fi_pack = "R" 
        fi_benname  = ""   .
    ELSE IF fi_cover1 = "5" THEN ASSIGN fi_pack = "B".
    Disp  fi_cover1 fi_pack fi_class  fi_benname with frame  fr_main. 
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
                END.  /*else do:...*/
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
                                (tlt.genusr     = "Phone"      OR
                                 tlt.genusr     = "FAX"  )     AND
                                tlt.comp_pol    = fi_notno72  NO-LOCK NO-ERROR NO-WAIT.
                            IF NOT AVAIL tlt THEN DO:
                                FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE 
                                    sicuw.uwm100.policy = CAPS(fi_notno72) NO-LOCK NO-ERROR.
                                IF AVAIL sicuw.uwm100 THEN DO:  
                                    IF  (sicuw.uwm100.name1 <> "") OR (sicuw.uwm100.comdat <> ? ) THEN 
                                        NEXT running_polno2.
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


&Scoped-define SELF-NAME bu_model
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_model C-Win
ON CHOOSE OF bu_model IN FRAME fr_main
DO:
    Run  wgw\wgwhpmod(Input-output  fi_model,
                      INPUT         fi_brand, 
                      Input-output  fi_year,
                      Input-output  fi_power ).
  Disp  fi_model fi_year fi_power  with frame  fr_main.    
  IF fi_model = ""  THEN 
      Apply "Entry"  To  fi_model .
  ELSE Apply "Entry"  To  fi_licence1 .
  Return no-apply. 
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


&Scoped-define SELF-NAME bu_save
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_save C-Win
ON CHOOSE OF bu_save IN FRAME fr_main /* Save */
DO:
    IF fi_notno70 <> "" THEN DO:
        FIND LAST  tlt    WHERE 
            tlt.genusr        = "FAX"      AND
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
            tlt.genusr        = "FAX"  AND
            tlt.comp_pol      = trim(INPUT fi_notno72)   NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL tlt THEN DO:
            IF tlt.nor_noti_tlt <> fi_notino  THEN DO:
                MESSAGE "Found policy72 duplicate...tlt: " + tlt.nor_noti_tlt VIEW-AS ALERT-BOX.
                APPLY "entry" TO fi_notno72.
                RETURN NO-APPLY.
            END.
        END.
    END.
    Find  tlt  Where   Recid(tlt)  =  nv_recidtlt   NO-ERROR NO-WAIT .
    IF AVAIL tlt THEN DO:
        ASSIGN 
            /*1 */  tlt.nor_usr_ins   = trim(fi_ins_off)  
            /*2 */  tlt.lotno         = trim(fi_comco)
            /*3 */  tlt.nor_noti_ins  = trim(fi_cmrcode) 
            /*4 */  tlt.nor_usr_tlt   = trim(fi_cmrcode2)   
            /*5 */  tlt.subins        = trim(fi_campaign)
            /*6 */  tlt.safe1         = IF      ra_car  = 1 THEN "เก๋ง"      
                                        ELSE IF ra_car  = 2 THEN "กระบะ"   
                                                            ELSE "โดยสาร" 
            /*7 */   tlt.safe2        = IF    ra_cover  = 1 THEN "ป้ายแดง" 
                                                            ELSE "use car" 
            /*8 */   tlt.safe3        = trim(fi_cover1)
            /*9 */   tlt.stat         = IF ra_pa = 1   THEN "" ELSE fi_product
            /*10*/   tlt.filler1      = IF ra_pree = 1 THEN "แถม"
                                                       ELSE "ไม่แถม"
            /*11*/   tlt.filler2      = IF ra_comp = 1 THEN "แถม"
                                        ELSE IF ra_comp = 2 THEN "ไม่แถม"  
                                        ELSE "ไม่เอาพรบ."
            /*12*/   tlt.comp_sub     = trim(fi_producer)        
            /*13*/   tlt.recac        = trim(fi_agent)
                     tlt.rec_addr4    = TRIM(fi_deler)  
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
            /*25*/   tlt.ins_addr1    = IF ra_ban = 1 THEN 
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
                                   ELSE      /*ra_ban = 3*/
                                  trim((IF n_banno = "" THEN "" ELSE "เลขที่ " + TRIM(n_banno)) + " " +  
            /*31*/                     (IF n_muno  = "" THEN "" ELSE "หมู่ "   + TRIM(n_muno))  + " " +
                                       (IF n_build = "" THEN "" ELSE "หมู่บ้าน"  + n_build )    + " " +  
                                       (IF n_soy   = "" THEN "" ELSE "ซอย"     + TRIM(n_soy))   + " " +  
            /*  */                     (IF n_road  = "" THEN "" ELSE "ถนน"     + TRIM(n_road))) 
             
            /*32*/   tlt.ins_addr2     = trim(fi_insadd2tam)     
            /*33*/   tlt.ins_addr3     = TRIM(fi_insadd3amp)     
            /*34*/   tlt.ins_addr4     = TRIM(fi_insadd4cunt)     
            /*35*/   tlt.ins_addr5     = TRIM(fi_insadd5post)   
            /*36*/   tlt.comp_noti_ins = TRIM(fi_insadd6tel)

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
            /*43*/   tlt.dri_no2       = trim(fi_ispno)
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
            /*67*/   tlt.OLD_cha       = USERID(LDBNAME(1))  + ":" + trim(fi_remark1)        
            /*68*/   tlt.OLD_eng       = IF ra_complete = 1 THEN "complete"
                                         ELSE "not complete"
            /*  */   tlt.genusr        = "FAX"   
            /*  */   tlt.imp           = "IM"                     /*Import Data*/
            /*  */   tlt.releas        = "No"
                     tlt.endno         = fi_idno 
            /*  */   tlt.dat_ins_noti  = fi_birthday    /*birthday*//*date */  
            /*  */   tlt.seqno         = fi_age         /*age      *//*inte */           
            /*  */   tlt.flag          = fi_occup       /*occupn   */  
            /*  */   tlt.usrsent       = fi_namedrirect /*name direct */.
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


&Scoped-define SELF-NAME co_benname
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL co_benname C-Win
ON VALUE-CHANGED OF co_benname IN FRAME fr_main
DO:
    co_benname = INPUT co_benname .
    ASSIGN fi_benname = INPUT co_benname
        co_benname = "" .
    DISP co_benname fi_benname WITH FRAM fr_main.
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


&Scoped-define SELF-NAME fi_benname
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_benname C-Win
ON LEAVE OF fi_benname IN FRAME fr_main
DO:
  fi_benname  = INPUT fi_benname.
  DISP fi_benname WITH FRAM fr_main.
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
            ASSIGN fi_benname = Company.Name2      
                nv_benname    = Company.Name2 .    
            IF ra_cover = 1 THEN                   
                ASSIGN fi_producer = company.Text1 
                fi_agent    = company.Text4 .      
            ELSE                                   
                ASSIGN fi_producer = company.Text2 
                    fi_agent    = company.Text4 .  
        END.
    END.
    DISP  fi_comco fi_producer fi_agent fi_benname WITH FRAM fr_main.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_comdat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_comdat C-Win
ON LEAVE OF fi_comdat IN FRAME fr_main
DO:
  fi_comdat = INPUT fi_comdat.
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
    ASSIGN fi_benname   = nv_benname .     
    IF      fi_cover1 = "1" THEN ASSIGN fi_pack = "G".
    ELSE IF fi_cover1 = "2" THEN ASSIGN fi_pack = "Y".
    ELSE IF fi_cover1 = "3" THEN DO:
        IF ra_car = 2 THEN
            ASSIGN fi_pack = "R" 
            fi_benname  = ""  .
        ELSE ASSIGN fi_pack = "V" 
            fi_benname  = ""  .
    END.
    ELSE IF fi_cover1 = "5" THEN ASSIGN fi_pack = "B".
    Disp  fi_cover1 fi_pack fi_benname  with frame  fr_main. 
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
  DISP fi_ispno WITH FRAM fr_main.
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
            IF substr(TRIM(fi_notno70),2,1) <> TRIM(fi_cmrsty) THEN 
                MESSAGE "สาขา" + TRIM(fi_cmrsty) + "ไม่ตรงกับ เลขกรมธรรม์!!!" VIEW-AS ALERT-BOX.
        END.
        ELSE DO:
            IF substr(TRIM(fi_notno70),1,2) <> TRIM(fi_cmrsty) THEN 
                MESSAGE "สาขา" + TRIM(fi_cmrsty) + "ไม่ตรงกับ เลขกรมธรรม์!!!" VIEW-AS ALERT-BOX.
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
            RUN proc_create70.    
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
            tlt.comp_pol       = INPUT fi_notno72  NO-LOCK NO-ERROR NO-WAIT.
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
            RUN proc_create72.  
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


&Scoped-define SELF-NAME fi_year
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_year C-Win
ON LEAVE OF fi_year IN FRAME fr_main
DO:
    fi_year  =  Input fi_year.
    Disp fi_year with frame  fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ra_ban
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_ban C-Win
ON VALUE-CHANGED OF ra_ban IN FRAME fr_main
DO: 
    ra_ban = INPUT ra_ban.
    IF ra_ban = 1 THEN DO:
        ASSIGN fi_insadd1build = "".
        DISP fi_insadd1build ra_ban WITH FRAM fr_main.
        APPLY "entry" TO fi_insadd1soy.
        RETURN NO-APPLY.


    END.
    ELSE DO:
        DISP   ra_ban WITH FRAM fr_main.
        APPLY "entry" TO fi_insadd1build.
        RETURN NO-APPLY.
    END.
    DISP ra_ban WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ra_car
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_car C-Win
ON VALUE-CHANGED OF ra_car IN FRAME fr_main
DO:
    ra_car = INPUT ra_car.
    IF ra_car = 1 THEN DO:
        ASSIGN fi_class = "110".
        IF fi_cover1 = "3" THEN 
            ASSIGN fi_pack = "V" 
                fi_benname  = "" .
        
    END.
    ELSE IF ra_car = 2 THEN DO:
        IF fi_cover1 = "3" THEN 
                ASSIGN fi_pack = "R" 
                fi_benname  = "" .
        ASSIGN fi_class = "320".
    END.
    ELSE IF ra_car = 3 THEN DO:
        ASSIGN fi_class = "210".
        IF fi_cover1 = "3" THEN DO:
            IF ra_car = 2 THEN
                ASSIGN fi_pack = "R" 
                fi_benname  = "" .
            ELSE ASSIGN fi_pack = "V" 
                fi_benname  = "" .
        END.
    END.
    DISP ra_car fi_pack fi_class fi_benname  WITH FRAM fr_main.
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
    IF ra_cover = 1 THEN                  
        ASSIGN fi_pack = "G"
        fi_producer = n_producernew  
        fi_agent    = n_agent    .
    ELSE 
        ASSIGN 
            fi_producer =  n_produceruse 
            fi_agent    =  n_agent    .   

    DISP ra_cover fi_comco fi_producer fi_agent  WITH FRAM fr_main. 
    APPLY "ENTRY" TO fi_pack IN FRAME fr_main.
    RETURN NO-APPLY.
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
    gv_prgid = "wgwqufa1".
    gv_prog  = "UPDATE  DATA BY FAX...".
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
        Assign
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
            ra_car        =  IF      tlt.safe1 = "เก๋ง"    THEN 1 
                             ELSE IF tlt.safe1 = "กระบะ"   THEN 2 ELSE 3

            ra_cover      =  IF      tlt.safe2 = "ป้ายแดง" THEN 1 ELSE 2
            /*ra_cover2   =  IF      tlt.safe3 = "ป.1"     THEN 1       
                             ELSE IF tlt.safe3 = "ป.2"     THEN 2
                             ELSE 3  */
            fi_cover1     = tlt.safe3 
            ra_pa         = IF tlt.stat  = "" THEN 1 ELSE 2
            fi_product    = tlt.stat
            ra_pree       =  IF      trim(tlt.filler1) = "แถม"    THEN 1 ELSE 2
            ra_comp       =  IF      trim(tlt.filler2) = "แถม"    THEN 1 
                             ELSE IF trim(tlt.filler2) = "ไม่แถม" THEN 2 
                             ELSE 3
            fi_producer   =  tlt.comp_sub     
            fi_agent      =  tlt.recac    
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
            fi_insadd6tel  = tlt.comp_noti_ins
            fi_comdat      = tlt.nor_effdat
            fi_expdat      = tlt.expodat   
            fi_ispno       = tlt.dri_no2         
            fi_brand       = tlt.brand          
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
            fi_remark1     = substr(tlt.OLD_cha,index(tlt.old_cha,":") + 1) 
            ra_complete   =  IF trim(tlt.OLD_eng) =  "complete" THEN 1 ELSE 2
            fi_userid     =  tlt.usrid
            n_addr11      =  tlt.ins_addr1  
            vAcProc_fil3   = " " 
            vAcProc_fil3   = vAcProc_fil3  + " " .  
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
    END. 
    IF INDEX(n_addr11,"ถนน") = 0 THEN ASSIGN fi_insadd1road = "".  
    ELSE ASSIGN fi_insadd1road = SUBSTR(n_addr11,INDEX(n_addr11,"ถนน") + 3 )
                      n_road   = SUBSTR(n_addr11,INDEX(n_addr11,"ถนน") + 3 )
                      n_addr11 = SUBSTR(n_addr11,1,length(n_addr11) - (LENGTH(fi_insadd1road)) - 3 ).
    IF   INDEX(n_addr11,"ซอย") = 0 THEN ASSIGN fi_insadd1soy = "".  
    ELSE  ASSIGN fi_insadd1soy = SUBSTR(n_addr11,INDEX(n_addr11,"ซอย") + 3 )
                         n_soy = SUBSTR(n_addr11,INDEX(n_addr11,"ซอย") + 3 )
                      n_addr11 = SUBSTR(n_addr11,1,length(n_addr11) - (LENGTH(fi_insadd1soy)) - 3 ).
     IF R-INDEX(n_addr11,"อาคาร") <> 0 THEN 
         ASSIGN fi_insadd1build  = SUBSTR(n_addr11,r-INDEX(n_addr11,"อาคาร") + 5 )
                          ra_ban = 2
                         n_build = SUBSTR(n_addr11,INDEX(n_addr11,"อาคาร") + 5 )
                        n_addr11 = SUBSTR(n_addr11,1,length(n_addr11) - (LENGTH(fi_insadd1build)) - 5 ).
     ELSE IF R-INDEX(n_addr11,"หมู่บ้าน") <> 0 THEN 
         ASSIGN fi_insadd1build = SUBSTR(n_addr11,R-INDEX(n_addr11,"หมู่บ้าน") + 8 )
                        ra_ban  = 3
                         n_build = SUBSTR(n_addr11,R-INDEX(n_addr11,"หมู่บ้าน") + 8 )
                        n_addr11 = SUBSTR(n_addr11,1,length(n_addr11) - (LENGTH(fi_insadd1build)) - 8 ).
     ELSE ASSIGN fi_insadd1build = ""
                 ra_ban  = 1.
     IF INDEX(n_addr11,"หมู่") = 0 THEN ASSIGN fi_insadd1mu = "".  
     ELSE ASSIGN fi_insadd1mu  = SUBSTR(n_addr11,INDEX(n_addr11,"หมู่") + 5 )
                       n_muno  = SUBSTR(n_addr11,INDEX(n_addr11,"หมู่") + 5 )
                      n_addr11 = SUBSTR(n_addr11,1,length(n_addr11) - (LENGTH(fi_insadd1mu)) - 5 ).
     IF INDEX(n_addr11,"เลขที่") = 0 THEN ASSIGN fi_insadd1no = "".  
     ELSE ASSIGN fi_insadd1no = SUBSTR(n_addr11,8)
                 n_banno      = SUBSTR(n_addr11,8) .
     FOR EACH company WHERE company.NAME = "phone" NO-LOCK . 
         ASSIGN vAcProc_fil3   = vAcProc_fil3  + " " + "," + TRIM(company.NAME2).
     END.
     ASSIGN 
         co_benname:LIST-ITEMS = vAcProc_fil3 
         co_benname  = ENTRY(1,vAcProc_fil3)  .
    RUN  proc_dispable.
    Disp fi_notino       fi_comco        fi_cmrcode2     fi_cmrcode      fi_ins_off         
         fi_notdat       fi_nottim       fi_cmrsty       fi_producer     fi_agent           
         fi_campaign     ra_car          ra_cover        fi_cover1       ra_pa fi_product       
         ra_pree         ra_comp         fi_notno70      fi_notno72      fi_institle        
         fi_preinsur     fi_preinsur2    fi_insadd1no    fi_insadd1mu    fi_insadd1build    
         fi_insadd1soy   fi_insadd1road  fi_insadd2tam   fi_insadd3amp   fi_insadd4cunt     
         fi_insadd5post  fi_insadd6tel   fi_brand        fi_model        fi_eng_no   
         fi_cha_no       fi_power        fi_year         fi_licence1     fi_licence2     
         fi_provin       fi_pack         fi_class        fi_sumsi        fi_premium      
         fi_precomp      fi_totlepre     fi_stk          fi_refer        fi_recipname    
         fi_vatcode      fi_comdat       fi_expdat       fi_gap          fi_ispno        
         fi_user         fi_benname      fi_remark1      fi_garage       ra_complete  
         fi_idno         ra_ban          fi_birthday     fi_age          fi_occup                
         fi_namedrirect  fi_userid       fi_idnoexpdat  ra_driv  fi_deler   With frame   fr_main.
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
  DISPLAY fi_ins_off fi_comco fi_cmrcode fi_cmrcode2 fi_campaign ra_car ra_cover 
          fi_cover1 ra_pa fi_product ra_pree ra_comp fi_producer fi_agent 
          fi_deler fi_cmrsty fi_notno70 fi_notno72 fi_institle fi_preinsur 
          fi_preinsur2 fi_idno fi_birthday fi_age fi_idnoexpdat fi_occup 
          fi_namedrirect fi_insadd1no fi_insadd1mu ra_ban fi_insadd1build 
          fi_insadd1soy fi_insadd1road fi_insadd2tam fi_insadd3amp 
          fi_insadd4cunt fi_insadd5post fi_insadd6tel fi_comdat fi_expdat 
          fi_ispno fi_brand fi_model fi_year fi_power fi_licence1 fi_licence2 
          fi_provin fi_cha_no fi_eng_no fi_pack fi_class fi_garage fi_sumsi 
          fi_gap fi_premium fi_precomp fi_totlepre fi_stk fi_refer fi_recipname 
          fi_vatcode fi_user fi_benname co_benname fi_remark1 ra_complete 
          fi_userid ra_driv fi_notino fi_notdat fi_nottim 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE fi_ins_off fi_comco buselecom fi_cmrcode fi_cmrcode2 fi_campaign 
         ra_car ra_cover fi_cover1 bu_cover ra_pa fi_product bu_product ra_pree 
         ra_comp fi_producer fi_agent fi_deler fi_cmrsty fi_notno70 fi_notno72 
         bu_create fi_institle fi_preinsur fi_preinsur2 fi_idno fi_birthday 
         fi_age fi_idnoexpdat fi_occup fi_namedrirect fi_insadd1no fi_insadd1mu 
         ra_ban fi_insadd1build fi_insadd1soy fi_insadd1road fi_insadd2tam 
         fi_insadd3amp fi_insadd4cunt fi_insadd5post fi_insadd6tel fi_comdat 
         fi_expdat fi_ispno fi_brand fi_model bu_model fi_year fi_power 
         fi_licence1 fi_licence2 fi_provin fi_cha_no fi_eng_no fi_pack fi_class 
         fi_garage fi_sumsi fi_gap fi_premium fi_precomp fi_totlepre fi_stk 
         fi_refer fi_recipname fi_vatcode fi_user fi_benname co_benname 
         fi_remark1 ra_complete bu_save bu_exit ra_driv RECT-488 RECT-489 
         RECT-490 RECT-491 RECT-492 RECT-493 
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
Find  tlt  Where   Recid(tlt)  =  nv_recidtlt AND 
    tlt.releas        = "yes"    NO-LOCK NO-ERROR NO-WAIT .
If  avail  tlt  Then 
    /*DISABLE fi_notino     fi_comco      fi_cmrcode2   fi_cmrcode    fi_ins_off    fi_notdat     
    fi_nottim     fi_cmrsty     fi_producer   fi_agent      fi_campaign   ra_car        ra_cover      
    fi_cover1    fi_product   ra_pree      ra_comp      fi_notno70    fi_notno72    fi_institle   
    fi_preinsur                                   fi_preinsur2                          fi_insadd2tam 
    fi_insadd3amp fi_insadd4cunt  fi_insadd5post  fi_insadd6tel   fi_brand        fi_model        
    fi_eng_no       fi_cha_no       fi_power        fi_year         fi_licence1     fi_licence2   
    fi_provin      fi_pack   fi_class      
    fi_sumsi      fi_premium    fi_precomp    fi_totlepre   fi_stk        fi_refer      
    fi_recipname  fi_vatcode    fi_comdat     fi_expdat     fi_gap        fi_ispno      fi_user       
    fi_benname    fi_remark1    fi_garage     ra_complete   fi_userid          WITH FRAM fr_main.  */
    DISABLE buselecom    bu_cover        bu_product      bu_create       bu_model    bu_save
         fi_notino       fi_comco        fi_cmrcode2     fi_cmrcode      fi_ins_off         
         fi_notdat       fi_nottim       fi_cmrsty       fi_producer     fi_agent           
         fi_campaign     ra_car          ra_cover        fi_cover1       fi_product         
         ra_pree         ra_comp         fi_notno70      fi_notno72      fi_institle        
         fi_preinsur     fi_preinsur2    fi_insadd1no    fi_insadd1mu    fi_insadd1build
         fi_insadd1soy   fi_insadd1road  fi_insadd2tam   fi_insadd3amp   fi_insadd4cunt  
         fi_insadd5post  fi_insadd6tel   fi_brand        fi_model        fi_eng_no   
         fi_cha_no       fi_power        fi_year         fi_licence1     fi_licence2     
         fi_provin       fi_pack         fi_class        fi_sumsi        fi_premium      
         fi_precomp      fi_totlepre     fi_stk          fi_refer        fi_recipname    
         fi_vatcode      fi_comdat       fi_expdat       fi_gap          fi_ispno        
         fi_user         fi_benname     fi_remark1       fi_garage       ra_complete  fi_userid WITH FRAM fr_main.
 
    END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

