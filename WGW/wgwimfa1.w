&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
&Scoped-define WINDOW-NAME wgwimpon
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS wgwimpon 
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
program id       :  wgwimfa1.w 
program name     :  Import data by FAX create  new policy  Add in table  tlt 
Create  by       :  Kridtiya i. A56-0024  On   10/01/2013
Database Connect :  gw_stat ld brstat , gw_safe ld sic_bran ,sic_test ld sicuw sicsyac :not connect stat
+++++++++++++++++++++++++++++++++++++++++++++++*/
DEF Input Parameter    n_policy  AS CHAR FORMAT "x(20)".
DEF                VAR nv_index  as int  init 0.
DEF  NEW   SHARED  VAR gComp     AS CHAR.
DEF  NEW   SHARED  VAR n_agent1  LIKE sicsyac.xmm600.acno. 
DEF  NEW   SHARED  VAR n_agent2  LIKE sicsyac.xmm600.acno. 
DEF  NEW   SHARED  VAR nv_agent  AS CHAR FORMAT "x(10)".
/* Parameters Definitions ---                                           */
DEF VAR    n_name       As   Char    Format    "x(35)".
DEF VAR    n_nO1        As   Char    Format    "x(35)".
DEF VAR    n_nO2        As   Char    Format    "x(35)".
Def  VAR   n_nO3        As   Char    Format    "x(35)".   
DEF VAR    n_text       As   Char    Format    "x(35)".
Def VAR    n_chkname    As   Char    Format    "x(35)".
DEFINE VAR vAcProc_fil  AS   CHAR.
DEFINE VAR vAcProc_fil1 AS   CHAR.
DEFINE VAR vAcProc_fil2 AS   CHAR.
DEFINE VAR vAcProc_fil3 AS   CHAR.   
DEF VAR n_poltyp  AS CHAR INIT "".
DEF VAR nv_brnpol AS CHAR INIT "".
DEF VAR n_undyr2  AS CHAR INIT "".
DEF VAR n_brsty   AS CHAR INIT "".
DEF VAR n_br      AS CHAR INIT "" FORMAT "x(5)" .
DEFINE VAR nv_check    AS   CHARACTER  INITIAL ""  NO-UNDO.
DEFINE VAR nv_check70  AS   CHARACTER  INITIAL ""  NO-UNDO.
DEFINE VAR nv_check72  AS   CHARACTER  INITIAL ""  NO-UNDO.
DEF VAR n_banno AS  CHAR   INIT "" FORMAT "x(20)".
DEF VAR n_muno  AS  CHAR   INIT "" FORMAT "x(20)".
DEF VAR n_build AS  CHAR   INIT "" FORMAT "x(50)".
DEF VAR n_road  AS  CHAR   INIT "" FORMAT "x(40)".
DEF VAR n_soy   AS  CHAR   INIT "" FORMAT "x(40)".
DEF VAR nv_seq          AS INTEGER  INIT  1.
DEF VAR nv_sum          AS INTEGER  INIT  0.
DEF VAR nv_checkdigit   AS INTEGER .
DEF VAR nv_benname      AS   CHAR    FORMAT    "x(60)".  
DEF VAR n_producernew   As   Char    Format    "x(10)". 
DEF VAR n_produceruse   As   Char    Format    "x(10)". 
DEF VAR n_agent         As   Char    Format    "x(10)".

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_driv

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS fi_drivername1 ra_sex1 fi_hbdri1 ~
fi_occupdriv1 fi_idnodriv1 fi_drivername2 ra_sex2 fi_hbdri2 fi_occupdriv2 ~
fi_idnodriv2 fi_text1 fi_text2 fi_text3 fi_text4 fi_text5 fi_text6 fi_text7 ~
fi_text8 fi_text9 fi_text10 
&Scoped-Define DISPLAYED-OBJECTS fi_drivername1 ra_sex1 fi_hbdri1 ~
fi_occupdriv1 fi_idnodriv1 fi_drivername2 ra_sex2 fi_hbdri2 fi_occupdriv2 ~
fi_idnodriv2 fi_agedriv1 fi_agedriv2 fi_text1 fi_text2 fi_text3 fi_text4 ~
fi_text5 fi_text6 fi_text7 fi_text8 fi_text9 fi_text10 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR wgwimpon AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE VARIABLE fi_agedriv1 AS INTEGER FORMAT "->>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 4.5 BY .91
     BGCOLOR 8 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_agedriv2 AS INTEGER FORMAT "->>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 4.5 BY .91
     BGCOLOR 8 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_drivername1 AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 28 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_drivername2 AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 28 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_hbdri1 AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 13 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_hbdri2 AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 13 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_idnodriv1 AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 14.5 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_idnodriv2 AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 14.5 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_occupdriv1 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 18 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_occupdriv2 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 18 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_text1 AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 8 BY .91
     FGCOLOR 7  NO-UNDO.

DEFINE VARIABLE fi_text10 AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 5 BY .91
     FGCOLOR 7  NO-UNDO.

DEFINE VARIABLE fi_text2 AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 8 BY .91
     FGCOLOR 7  NO-UNDO.

DEFINE VARIABLE fi_text3 AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 5.17 BY .91
     FGCOLOR 7  NO-UNDO.

DEFINE VARIABLE fi_text4 AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 5.17 BY .91
     FGCOLOR 7  NO-UNDO.

DEFINE VARIABLE fi_text5 AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 5 BY .91
     FGCOLOR 7  NO-UNDO.

DEFINE VARIABLE fi_text6 AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 5 BY .91
     FGCOLOR 7  NO-UNDO.

DEFINE VARIABLE fi_text7 AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 5.17 BY .91
     FGCOLOR 7  NO-UNDO.

DEFINE VARIABLE fi_text8 AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 5.17 BY .91
     FGCOLOR 7  NO-UNDO.

DEFINE VARIABLE fi_text9 AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 5 BY .91
     FGCOLOR 7  NO-UNDO.

DEFINE VARIABLE ra_sex1 AS INTEGER 
     VIEW-AS RADIO-SET VERTICAL
     RADIO-BUTTONS 
          "Male", 1,
"Female", 2
     SIZE 10 BY .91
     BGCOLOR 2 FGCOLOR 7 FONT 6 NO-UNDO.

DEFINE VARIABLE ra_sex2 AS INTEGER 
     VIEW-AS RADIO-SET VERTICAL
     RADIO-BUTTONS 
          "Male", 1,
"Female", 2
     SIZE 10 BY .91
     BGCOLOR 2 FGCOLOR 7 FONT 6 NO-UNDO.

DEFINE BUTTON buselecom 
     IMAGE-UP FILE "i:/safety/walp10/wimage/next.bmp":U
     LABEL "" 
     SIZE 3.5 BY .95.

DEFINE BUTTON bu_cov 
     IMAGE-UP FILE "I:/Safety/WALP10/WIMAGE/next.bmp":U
     LABEL "" 
     SIZE 3.5 BY .95.

DEFINE BUTTON bu_create 
     LABEL "Create" 
     SIZE 8 BY 1
     BGCOLOR 3 FGCOLOR 2 FONT 6.

DEFINE BUTTON bu_exit 
     LABEL "Exit" 
     SIZE 6 BY 1.05
     FONT 6.

DEFINE BUTTON bu_model 
     IMAGE-UP FILE "I:/Safety/WALP10/WIMAGE/next.bmp":U
     LABEL "" 
     SIZE 4 BY .95.

DEFINE BUTTON bu_product 
     IMAGE-UP FILE "I:/Safety/WALP10/WIMAGE/next.bmp":U
     LABEL "" 
     SIZE 3.5 BY .95.

DEFINE BUTTON bu_save 
     LABEL "Save" 
     SIZE 7 BY 1.05
     FONT 6.

DEFINE VARIABLE co_benname AS CHARACTER FORMAT "X(60)":U 
     VIEW-AS COMBO-BOX INNER-LINES 5
     DROP-DOWN-LIST
     SIZE 60 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE co_brand AS CHARACTER FORMAT "X(35)":U 
     VIEW-AS COMBO-BOX INNER-LINES 5
     DROP-DOWN-LIST
     SIZE 20 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE co_provin AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS COMBO-BOX INNER-LINES 8
     DROP-DOWN-LIST
     SIZE 24.5 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE co_user AS CHARACTER FORMAT "X(60)":U 
     VIEW-AS COMBO-BOX INNER-LINES 5
     DROP-DOWN-LIST
     SIZE 22.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_age AS INTEGER FORMAT "->>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 4.5 BY .95
     BGCOLOR 8 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_agent AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 11.5 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_benname AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 60 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_birthday AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 13.5 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_campaign AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_cha_no AS CHARACTER FORMAT "X(35)":U 
     VIEW-AS FILL-IN 
     SIZE 28 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_class AS CHARACTER FORMAT "X(4)":U 
     VIEW-AS FILL-IN 
     SIZE 5 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_cmrcode AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 18 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_cmrcode2 AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 6 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_cmrsty AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 4 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_comco AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 9 BY .95
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_comdat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_cover1 AS CHARACTER FORMAT "X(1)":U 
     VIEW-AS FILL-IN 
     SIZE 4 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_deler AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 11.5 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_eng_no AS CHARACTER FORMAT "X(35)":U 
     VIEW-AS FILL-IN 
     SIZE 22 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_expdat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_gap AS DECIMAL FORMAT "->,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 13.5 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_garage AS CHARACTER FORMAT "X(1)":U 
     VIEW-AS FILL-IN 
     SIZE 5 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_idno AS CHARACTER FORMAT "X(13)":U 
     VIEW-AS FILL-IN 
     SIZE 20 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_idnoexpdat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 13.5 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_insadd1build AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 20 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_insadd1mu AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 4.5 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_insadd1no AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 10.5 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_insadd1road AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 18 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_insadd1soy AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 19 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_insadd2tam AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 19 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_insadd3amp AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 18 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_insadd4cunt AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 19 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_insadd5post AS CHARACTER FORMAT "X(5)":U 
     VIEW-AS FILL-IN 
     SIZE 8 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_insadd6tel AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 16 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_institle AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_ins_off AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 22 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_ispno AS CHARACTER FORMAT "X(45)":U 
     VIEW-AS FILL-IN 
     SIZE 27 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_licence1 AS CHARACTER FORMAT "X(3)":U 
     VIEW-AS FILL-IN 
     SIZE 5.5 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_licence2 AS CHARACTER FORMAT "X(4)":U 
     VIEW-AS FILL-IN 
     SIZE 6.5 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_model AS CHARACTER FORMAT "X(60)":U 
     VIEW-AS FILL-IN 
     SIZE 43.5 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_namedrirect AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 22 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_notdat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .95
     BGCOLOR 8 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_notino AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 8 FGCOLOR 2  NO-UNDO.

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
     BGCOLOR 8 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_occup AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 24 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_pack AS CHARACTER FORMAT "X(1)":U 
     VIEW-AS FILL-IN 
     SIZE 4.5 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_power AS DECIMAL FORMAT ">>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN NATIVE 
     SIZE 11 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_precomp AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 12 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_preinsur AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 28 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_preinsur2 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 29 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_premium AS DECIMAL FORMAT "->,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 13.5 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_producer AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 11.5 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_product AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 6 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_recipname AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 35 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_refer AS CHARACTER FORMAT "X(35)":U 
     VIEW-AS FILL-IN 
     SIZE 21.5 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_remark1 AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 60 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_stk AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 18.5 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_sumsi AS DECIMAL FORMAT "->>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 16 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_totlepre AS DECIMAL FORMAT "->,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_user AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 7.5 BY .95
     BGCOLOR 18  NO-UNDO.

DEFINE VARIABLE fi_user2 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 21 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_vatcode AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 12 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_year AS CHARACTER FORMAT "X(4)":U INITIAL "0" 
     VIEW-AS FILL-IN 
     SIZE 6.5 BY .95
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
     SIZE 26 BY .95
     BGCOLOR 5 FGCOLOR 7 FONT 6 NO-UNDO.

DEFINE VARIABLE ra_comp AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "แถม", 1,
"ไม่แถม", 2,
"ไม่เอาพรบ.", 3
     SIZE 32 BY .95
     FONT 6 NO-UNDO.

DEFINE VARIABLE ra_complete AS INTEGER 
     VIEW-AS RADIO-SET VERTICAL
     RADIO-BUTTONS 
          "Complete", 1,
"Not Complete", 2
     SIZE 18 BY 2
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE ra_cover AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "ป้ายแดง", 1,
"Usecar", 2
     SIZE 21 BY .95
     BGCOLOR 2 FGCOLOR 7 FONT 6 NO-UNDO.

DEFINE VARIABLE ra_driv AS INTEGER 
     VIEW-AS RADIO-SET VERTICAL
     RADIO-BUTTONS 
          "ไม่ระบุ", 1,
"ระบุ", 2
     SIZE 9 BY 2.29
     BGCOLOR 2 FGCOLOR 7 FONT 6 NO-UNDO.

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
     SIZE 17 BY .95
     FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-483
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 132.5 BY 23.86
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-484
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 9 BY 2
     BGCOLOR 6 .

DEFINE RECTANGLE RECT-485
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 10 BY 2
     BGCOLOR 5 .

DEFINE RECTANGLE RECT-486
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 22 BY 2.71
     BGCOLOR 3 .

DEFINE RECTANGLE RECT-487
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 39.5 BY 2.76
     BGCOLOR 6 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     fi_ins_off AT ROW 3.43 COL 16.67 COLON-ALIGNED NO-LABEL
     fi_comco AT ROW 3.43 COL 49.5 COLON-ALIGNED NO-LABEL
     fi_cmrcode AT ROW 3.43 COL 68.33 COLON-ALIGNED NO-LABEL
     fi_cmrcode2 AT ROW 3.43 COL 95.5 COLON-ALIGNED NO-LABEL
     ra_car AT ROW 4.48 COL 18.83 NO-LABEL
     ra_cover AT ROW 4.48 COL 45.17 NO-LABEL
     fi_cover1 AT ROW 4.48 COL 84.17 COLON-ALIGNED NO-LABEL
     fi_product AT ROW 4.48 COL 120.83 COLON-ALIGNED NO-LABEL
     bu_product AT ROW 4.48 COL 129.17
     ra_pree AT ROW 5.52 COL 18.83 NO-LABEL
     ra_comp AT ROW 5.52 COL 45.17 NO-LABEL
     fi_producer AT ROW 6.57 COL 16.83 COLON-ALIGNED NO-LABEL
     fi_agent AT ROW 6.57 COL 37.17 COLON-ALIGNED NO-LABEL
     fi_deler AT ROW 6.57 COL 57.5 COLON-ALIGNED NO-LABEL
     fi_cmrsty AT ROW 6.57 COL 78.5 COLON-ALIGNED NO-LABEL
     bu_create AT ROW 6.38 COL 115.67
     fi_notno70 AT ROW 5.86 COL 95.5 COLON-ALIGNED NO-LABEL
     fi_notno72 AT ROW 6.91 COL 95.5 COLON-ALIGNED NO-LABEL
     fi_institle AT ROW 8.71 COL 16.83 COLON-ALIGNED NO-LABEL
     fi_preinsur AT ROW 8.71 COL 36.83 COLON-ALIGNED NO-LABEL
     fi_preinsur2 AT ROW 8.71 COL 73.83 COLON-ALIGNED NO-LABEL
     fi_idno AT ROW 8.71 COL 110.5 COLON-ALIGNED NO-LABEL
     fi_birthday AT ROW 9.76 COL 16.83 COLON-ALIGNED NO-LABEL
     fi_age AT ROW 9.76 COL 35 COLON-ALIGNED NO-LABEL
     fi_idnoexpdat AT ROW 9.76 COL 52.17 COLON-ALIGNED NO-LABEL
     fi_occup AT ROW 9.76 COL 72.67 COLON-ALIGNED NO-LABEL
     fi_namedrirect AT ROW 9.76 COL 108.5 COLON-ALIGNED NO-LABEL
     fi_insadd1no AT ROW 10.81 COL 16.83 COLON-ALIGNED NO-LABEL
     fi_insadd1mu AT ROW 10.81 COL 32.5 COLON-ALIGNED NO-LABEL
     ra_ban AT ROW 10.81 COL 39.5 NO-LABEL
     fi_insadd1build AT ROW 10.81 COL 62 COLON-ALIGNED NO-LABEL
     fi_insadd1soy AT ROW 10.81 COL 87 COLON-ALIGNED NO-LABEL
     fi_insadd1road AT ROW 10.81 COL 112.5 COLON-ALIGNED NO-LABEL
     fi_insadd2tam AT ROW 11.86 COL 16.83 COLON-ALIGNED NO-LABEL
     fi_insadd3amp AT ROW 11.86 COL 46.17 COLON-ALIGNED NO-LABEL
     fi_insadd4cunt AT ROW 11.86 COL 72.17 COLON-ALIGNED NO-LABEL
     fi_insadd5post AT ROW 11.86 COL 97.5 COLON-ALIGNED NO-LABEL
     fi_insadd6tel AT ROW 11.86 COL 114.5 COLON-ALIGNED NO-LABEL
     fi_comdat AT ROW 12.91 COL 33.83 COLON-ALIGNED NO-LABEL
     fi_expdat AT ROW 12.91 COL 69.33 COLON-ALIGNED NO-LABEL
     fi_ispno AT ROW 12.91 COL 100.33 COLON-ALIGNED NO-LABEL
     co_brand AT ROW 13.95 COL 16.83 COLON-ALIGNED NO-LABEL
     fi_model AT ROW 13.95 COL 44.67 COLON-ALIGNED NO-LABEL
     bu_model AT ROW 13.95 COL 90.5
     fi_year AT ROW 13.95 COL 100.33 COLON-ALIGNED NO-LABEL
     fi_power AT ROW 13.95 COL 119 COLON-ALIGNED NO-LABEL
     fi_licence1 AT ROW 15 COL 16.83 COLON-ALIGNED NO-LABEL
     fi_licence2 AT ROW 15 COL 22.17 COLON-ALIGNED NO-LABEL
     co_provin AT ROW 15 COL 29 COLON-ALIGNED NO-LABEL
     fi_cha_no AT ROW 15 COL 66.17 COLON-ALIGNED NO-LABEL
     fi_eng_no AT ROW 15 COL 108 COLON-ALIGNED NO-LABEL
     ra_driv AT ROW 16.05 COL 2 NO-LABEL
     fi_pack AT ROW 18.48 COL 16.83 COLON-ALIGNED NO-LABEL
     fi_class AT ROW 18.48 COL 28.67 COLON-ALIGNED NO-LABEL
     fi_garage AT ROW 18.48 COL 42.83 COLON-ALIGNED NO-LABEL
     fi_sumsi AT ROW 18.48 COL 59.67 COLON-ALIGNED NO-LABEL
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 24
         BGCOLOR 3 FGCOLOR 1 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     fi_gap AT ROW 18.48 COL 85.33 COLON-ALIGNED NO-LABEL
     fi_premium AT ROW 18.48 COL 116.5 COLON-ALIGNED NO-LABEL
     fi_precomp AT ROW 19.52 COL 16.83 COLON-ALIGNED NO-LABEL
     fi_totlepre AT ROW 19.52 COL 41.17 COLON-ALIGNED NO-LABEL
     fi_stk AT ROW 19.52 COL 75.17 COLON-ALIGNED NO-LABEL
     fi_refer AT ROW 19.52 COL 108.5 COLON-ALIGNED NO-LABEL
     fi_recipname AT ROW 20.57 COL 16.83 COLON-ALIGNED NO-LABEL
     fi_vatcode AT ROW 20.57 COL 63.17 COLON-ALIGNED NO-LABEL
     co_user AT ROW 20.57 COL 86.17 COLON-ALIGNED NO-LABEL
     fi_user2 AT ROW 20.57 COL 109 COLON-ALIGNED NO-LABEL
     fi_benname AT ROW 21.62 COL 16.83 COLON-ALIGNED NO-LABEL
     co_benname AT ROW 22.67 COL 16.83 COLON-ALIGNED NO-LABEL
     fi_remark1 AT ROW 23.76 COL 16.83 COLON-ALIGNED NO-LABEL
     ra_complete AT ROW 22.43 COL 82.33 NO-LABEL
     bu_save AT ROW 23.1 COL 113.5
     fi_user AT ROW 7.05 COL 122.67 COLON-ALIGNED NO-LABEL
     buselecom AT ROW 3.43 COL 60.67
     fi_campaign AT ROW 3.43 COL 115.67 COLON-ALIGNED NO-LABEL
     ra_pa AT ROW 4.48 COL 94.17 NO-LABEL
     bu_exit AT ROW 23.1 COL 124.17
     fi_notdat AT ROW 2.33 COL 59 COLON-ALIGNED NO-LABEL
     fi_nottim AT ROW 2.33 COL 84.33 COLON-ALIGNED NO-LABEL
     fi_notino AT ROW 2.33 COL 30.83 COLON-ALIGNED NO-LABEL
     bu_cov AT ROW 4.48 COL 90.33
     "รหัสบริษัท :":30 VIEW-AS TEXT
          SIZE 10.5 BY .95 AT ROW 3.43 COL 40.83
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "           ยี่ห้อรถ  :":30 VIEW-AS TEXT
          SIZE 16 BY .95 AT ROW 13.95 COL 2
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "เบี้ยสุทธิ :":30 VIEW-AS TEXT
          SIZE 8.5 BY .95 AT ROW 18.48 COL 78
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "Reference no:":30 VIEW-AS TEXT
          SIZE 14 BY .95 AT ROW 19.52 COL 96
          BGCOLOR 18 FGCOLOR 0 FONT 6
     " ทุนประกัน :":30 VIEW-AS TEXT
          SIZE 11 BY .95 AT ROW 18.48 COL 50.17
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "เลขเครื่องยนต์:":35 VIEW-AS TEXT
          SIZE 13 BY .95 AT ROW 15 COL 96.67
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "               IMPORT DATA BY FAX......................" VIEW-AS TEXT
          SIZE 60 BY 1 AT ROW 1.19 COL 2
          BGCOLOR 3 FGCOLOR 15 FONT 6
     "          บ้านเลขที่ :":30 VIEW-AS TEXT
          SIZE 16 BY .95 AT ROW 10.81 COL 2
          BGCOLOR 18 FGCOLOR 2 FONT 6
     "การซ่อม :":35 VIEW-AS TEXT
          SIZE 8.5 BY .95 AT ROW 18.48 COL 36
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "NOTIFY  ENTRY" VIEW-AS TEXT
          SIZE 16 BY .95 AT ROW 2.33 COL 2
          BGCOLOR 15 FGCOLOR 1 FONT 6
     " ข้อมูลประกันภัย :":30 VIEW-AS TEXT
          SIZE 16 BY .95 AT ROW 12.91 COL 2
          BGCOLOR 2 FGCOLOR 7 FONT 6
     "หมู่ที่":30 VIEW-AS TEXT
          SIZE 4 BY .95 AT ROW 10.81 COL 30
          BGCOLOR 18 FGCOLOR 2 FONT 6
     "Notify Date :":30 VIEW-AS TEXT
          SIZE 12 BY .95 AT ROW 2.33 COL 48.33
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "        Package :":35 VIEW-AS TEXT
          SIZE 16 BY .95 AT ROW 18.48 COL 2
          BGCOLOR 18 FGCOLOR 0 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 24
         BGCOLOR 3 FGCOLOR 1 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "  ประเภทประกัน :":30 VIEW-AS TEXT
          SIZE 16 BY .95 AT ROW 4.48 COL 2
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "ชื่อใบเสร็จในนาม:":35 VIEW-AS TEXT
          SIZE 16 BY .95 AT ROW 20.57 COL 2
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "                คำนำ :":35 VIEW-AS TEXT
          SIZE 16 BY .95 AT ROW 8.71 COL 2
          BGCOLOR 18 FGCOLOR 2 FONT 6
     "อำเภอ/เขต :":30 VIEW-AS TEXT
          SIZE 9.5 BY .95 AT ROW 11.86 COL 38.33
          BGCOLOR 18 FGCOLOR 2 FONT 6
     " Vatcode :":30 VIEW-AS TEXT
          SIZE 10.5 BY .95 AT ROW 20.57 COL 54.33
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "        Producer :":30 VIEW-AS TEXT
          SIZE 16 BY 1 AT ROW 6.57 COL 2
          BGCOLOR 18 FGCOLOR 4 FONT 6
     "      ตำบล/แขวง :":30 VIEW-AS TEXT
          SIZE 16 BY .95 AT ROW 11.86 COL 2
          BGCOLOR 18 FGCOLOR 2 FONT 6
     "ประเภทความคุ้มครอง:" VIEW-AS TEXT
          SIZE 19.5 BY .95 AT ROW 4.48 COL 66.5
          BGCOLOR 5 FGCOLOR 7 FONT 6
     "            ประกัน :":30 VIEW-AS TEXT
          SIZE 16 BY .95 AT ROW 5.52 COL 2
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "Class :":35 VIEW-AS TEXT
          SIZE 6.5 BY .95 AT ROW 18.48 COL 23.83
          BGCOLOR 18 FGCOLOR 0 FONT 6
     " Deler :":30 VIEW-AS TEXT
          SIZE 8 BY 1 AT ROW 6.57 COL 51.17
          BGCOLOR 18 FGCOLOR 4 FONT 6
     " ผู้รับแจ้ง :":35 VIEW-AS TEXT
          SIZE 10 BY .95 AT ROW 20.57 COL 77.67
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "      ทะเบียนรถ :":30 VIEW-AS TEXT
          SIZE 16 BY .95 AT ROW 15 COL 2
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "     วันเดือนปีเกิด :":35 VIEW-AS TEXT
          SIZE 16 BY .95 AT ROW 9.76 COL 2
          BGCOLOR 2 FGCOLOR 6 FONT 6
     " พรบ.":30 VIEW-AS TEXT
          SIZE 7 BY .95 AT ROW 5.52 COL 37.67
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "วันหมดความคุ้มครอง :":35 VIEW-AS TEXT
          SIZE 19.5 BY .95 AT ROW 12.91 COL 51.33
          BGCOLOR 18 FGCOLOR 4 FONT 6
     " รุ่นรถ :":30 VIEW-AS TEXT
          SIZE 7 BY .95 AT ROW 13.95 COL 39.17
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "เบี้ยรวมภาษีอากร :":30 VIEW-AS TEXT
          SIZE 16 BY .95 AT ROW 18.48 COL 101.67
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "อายุ:":35 VIEW-AS TEXT
          SIZE 4 BY .95 AT ROW 9.76 COL 32.67
          BGCOLOR 2 FGCOLOR 6 FONT 6
     "  ปีรถ :":35 VIEW-AS TEXT
          SIZE 7 BY .95 AT ROW 13.95 COL 94.83
          BGCOLOR 18 FGCOLOR 0 FONT 6
     " Policy 72 :":35 VIEW-AS TEXT
          SIZE 11 BY .95 AT ROW 6.91 COL 86
          BGCOLOR 3 FGCOLOR 0 FONT 6
     "นามสกุล :":35 VIEW-AS TEXT
          SIZE 8 BY .95 AT ROW 8.71 COL 67.33
          BGCOLOR 18 FGCOLOR 2 FONT 6
     " เลขตรวจสภาพ:":30 VIEW-AS TEXT
          SIZE 15 BY .95 AT ROW 12.91 COL 87
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "Campaign No.":35 VIEW-AS TEXT
          SIZE 13.5 BY .95 AT ROW 3.43 COL 103.83
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "         ข้อมูลลูกค้า" VIEW-AS TEXT
          SIZE 16 BY .95 AT ROW 7.67 COL 2
          BGCOLOR 2 FGCOLOR 7 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 24
         BGCOLOR 3 FGCOLOR 1 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     " สาขา:":35 VIEW-AS TEXT
          SIZE 5.5 BY .95 AT ROW 3.43 COL 64.5
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "  วันเริ่มคุ้มครอง :":35 VIEW-AS TEXT
          SIZE 16 BY .95 AT ROW 12.91 COL 19
          BGCOLOR 18 FGCOLOR 4 FONT 6
     " STY Br:":35 VIEW-AS TEXT
          SIZE 8.5 BY 1 AT ROW 6.57 COL 71.5
          BGCOLOR 18 FGCOLOR 4 FONT 6
     "         เบี้ย พรบ.:":30 VIEW-AS TEXT
          SIZE 16 BY .95 AT ROW 19.52 COL 2
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "   ชื่อผู้แจ้ง MKT:":35 VIEW-AS TEXT
          SIZE 16 BY .95 AT ROW 3.43 COL 2
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "โทรศัพท์:":30 VIEW-AS TEXT
          SIZE 8 BY .95 AT ROW 11.86 COL 108.17
          BGCOLOR 18 FGCOLOR 2 FONT 6
     "Notify no:" VIEW-AS TEXT
          SIZE 13.5 BY .95 AT ROW 2.33 COL 18.83
          BGCOLOR 18 FGCOLOR 0 FONT 2
     " Agent :":30 VIEW-AS TEXT
          SIZE 8 BY 1 AT ROW 6.57 COL 30.67
          BGCOLOR 18 FGCOLOR 4 FONT 6
     "รหัสสาขา:":35 VIEW-AS TEXT
          SIZE 8.5 BY .95 AT ROW 3.43 COL 88.67
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "เลขพรบ.(สติ๊กเกอร์):":30 VIEW-AS TEXT
          SIZE 18 BY .95 AT ROW 19.52 COL 58.67
          BGCOLOR 18 FGCOLOR 0 FONT 6
     " ขนาด CC :":30 VIEW-AS TEXT
          SIZE 11 BY .95 AT ROW 13.95 COL 109.5
          BGCOLOR 18 FGCOLOR 0 FONT 6
     " No.Time :":30 VIEW-AS TEXT
          SIZE 10 BY .95 AT ROW 2.33 COL 75.67
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "ซอย":30 VIEW-AS TEXT
          SIZE 4 BY .95 AT ROW 10.81 COL 84.5
          BGCOLOR 18 FGCOLOR 2 FONT 6
     "ถนน:":30 VIEW-AS TEXT
          SIZE 5 BY .95 AT ROW 10.81 COL 108.67
          BGCOLOR 18 FGCOLOR 2 FONT 6
     "เบี้ยรวมพรบ.":30 VIEW-AS TEXT
          SIZE 11.5 BY .95 AT ROW 19.52 COL 31.33
          BGCOLOR 18 FGCOLOR 0 FONT 6
     " เลขตัวถังรถ:":20 VIEW-AS TEXT
          SIZE 12 BY .95 AT ROW 15 COL 55.67
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "ชื่อกรรมการ:":35 VIEW-AS TEXT
          SIZE 11 BY .95 AT ROW 9.76 COL 99.17
          BGCOLOR 18 FGCOLOR 2 FONT 6
     "         หมายเหตุ :":30 VIEW-AS TEXT
          SIZE 16 BY .95 AT ROW 23.76 COL 2
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "ID no :":35 VIEW-AS TEXT
          SIZE 6.5 BY .95 AT ROW 8.71 COL 105.5
          BGCOLOR 2 FGCOLOR 6 FONT 6
     "   8.3  ไฟแนนซ์ :":30 VIEW-AS TEXT
          SIZE 16 BY .95 AT ROW 21.62 COL 2
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "Product" VIEW-AS TEXT
          SIZE 8 BY .95 AT ROW 4.48 COL 114.67
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "อาชีพ:":35 VIEW-AS TEXT
          SIZE 6 BY .95 AT ROW 9.76 COL 68.17
          BGCOLOR 18 FGCOLOR 2 FONT 6
     " Policy 70:":35 VIEW-AS TEXT
          SIZE 11 BY .95 AT ROW 5.86 COL 86.17
          BGCOLOR 3 FGCOLOR 0 FONT 6
     " user :" VIEW-AS TEXT
          SIZE 7 BY .95 AT ROW 6 COL 124.83
          FONT 6
     "  ...เลขรับแจ้งจะใช้ได้เมื่อบันทึกข้อมูลเรียบร้อยแล้ว..SAVE COMPLETE..!!!!!" VIEW-AS TEXT
          SIZE 69.5 BY 1 AT ROW 1.19 COL 62
          BGCOLOR 3 FGCOLOR 15 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 24
         BGCOLOR 3 FGCOLOR 1 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "รหัส:":30 VIEW-AS TEXT
          SIZE 5 BY .95 AT ROW 11.86 COL 93.83
          BGCOLOR 18 FGCOLOR 2 FONT 6
     "บัตรหมดอายุ:":35 VIEW-AS TEXT
          SIZE 12 BY .95 AT ROW 9.76 COL 41.83
          BGCOLOR 2 FGCOLOR 6 FONT 6
     "  ชื่อ :":35 VIEW-AS TEXT
          SIZE 5 BY .95 AT ROW 8.71 COL 33.33
          BGCOLOR 18 FGCOLOR 2 FONT 6
     "จังหวัด:":30 VIEW-AS TEXT
          SIZE 7 BY .95 AT ROW 11.86 COL 66.67
          BGCOLOR 18 FGCOLOR 2 FONT 6
     RECT-483 AT ROW 1 COL 1
     RECT-484 AT ROW 22.57 COL 122.5
     RECT-485 AT ROW 22.62 COL 111.83
     RECT-486 AT ROW 21.95 COL 80.33
     RECT-487 AT ROW 5.52 COL 85
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 24
         BGCOLOR 3 FGCOLOR 1 .

DEFINE FRAME fr_driv
     fi_drivername1 AT ROW 1.1 COL 7.5 COLON-ALIGNED NO-LABEL
     ra_sex1 AT ROW 1.1 COL 38.5 NO-LABEL
     fi_hbdri1 AT ROW 1.1 COL 52.67 COLON-ALIGNED NO-LABEL
     fi_occupdriv1 AT ROW 1.1 COL 81.67 COLON-ALIGNED NO-LABEL
     fi_idnodriv1 AT ROW 1.1 COL 105.33 COLON-ALIGNED NO-LABEL
     fi_drivername2 AT ROW 2.14 COL 7.5 COLON-ALIGNED NO-LABEL
     ra_sex2 AT ROW 2.14 COL 38.5 NO-LABEL
     fi_hbdri2 AT ROW 2.14 COL 52.67 COLON-ALIGNED NO-LABEL
     fi_occupdriv2 AT ROW 2.14 COL 81.67 COLON-ALIGNED NO-LABEL
     fi_idnodriv2 AT ROW 2.14 COL 105.33 COLON-ALIGNED NO-LABEL
     fi_agedriv1 AT ROW 1.1 COL 71.33 COLON-ALIGNED NO-LABEL
     fi_agedriv2 AT ROW 2.14 COL 71.33 COLON-ALIGNED NO-LABEL
     fi_text1 AT ROW 1.1 COL 1.17 NO-LABEL
     fi_text2 AT ROW 2.14 COL 1.17 NO-LABEL
     fi_text3 AT ROW 1.1 COL 49 NO-LABEL
     fi_text4 AT ROW 2.14 COL 49 NO-LABEL
     fi_text5 AT ROW 1.1 COL 68 NO-LABEL
     fi_text6 AT ROW 2.14 COL 68 NO-LABEL
     fi_text7 AT ROW 1.1 COL 78.17 NO-LABEL
     fi_text8 AT ROW 2.14 COL 78.17 NO-LABEL
     fi_text9 AT ROW 1.1 COL 102 NO-LABEL
     fi_text10 AT ROW 2.14 COL 102 NO-LABEL
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         NO-LABELS SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 11.33 ROW 16.05
         SIZE 121.5 BY 2.3
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
  CREATE WINDOW wgwimpon ASSIGN
         HIDDEN             = YES
         TITLE              = "IMPORT DATA BY FAX ..."
         HEIGHT             = 24.1
         WIDTH              = 133.33
         MAX-HEIGHT         = 33.91
         MAX-WIDTH          = 171.83
         VIRTUAL-HEIGHT     = 33.91
         VIRTUAL-WIDTH      = 171.83
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
IF NOT wgwimpon:LOAD-ICON("wimage/safety.ico":U) THEN
    MESSAGE "Unable to load icon: wimage/safety.ico"
            VIEW-AS ALERT-BOX WARNING BUTTONS OK.
&ENDIF
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW wgwimpon
  VISIBLE,,RUN-PERSISTENT                                               */
/* REPARENT FRAME */
ASSIGN FRAME fr_driv:FRAME = FRAME fr_main:HANDLE.

/* SETTINGS FOR FRAME fr_driv
   FRAME-NAME Custom                                                    */
/* SETTINGS FOR FILL-IN fi_agedriv1 IN FRAME fr_driv
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_agedriv2 IN FRAME fr_driv
   NO-ENABLE                                                            */
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
   Custom                                                               */

DEFINE VARIABLE XXTABVALXX AS LOGICAL NO-UNDO.

ASSIGN XXTABVALXX = FRAME fr_driv:MOVE-AFTER-TAB-ITEM (fi_birthday:HANDLE IN FRAME fr_main)
       XXTABVALXX = FRAME fr_driv:MOVE-BEFORE-TAB-ITEM (fi_age:HANDLE IN FRAME fr_main)
/* END-ASSIGN-TABS */.

ASSIGN 
       co_benname:MANUAL-HIGHLIGHT IN FRAME fr_main = TRUE.

ASSIGN 
       co_user:MANUAL-HIGHLIGHT IN FRAME fr_main = TRUE.

/* SETTINGS FOR FILL-IN fi_age IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_notdat IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_notino IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_nottim IN FRAME fr_main
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(wgwimpon)
THEN wgwimpon:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK FRAME fr_driv
/* Query rebuild information for FRAME fr_driv
     _Query            is NOT OPENED
*/  /* FRAME fr_driv */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME wgwimpon
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wgwimpon wgwimpon
ON END-ERROR OF wgwimpon /* IMPORT DATA BY FAX ... */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wgwimpon wgwimpon
ON WINDOW-CLOSE OF wgwimpon /* IMPORT DATA BY FAX ... */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fr_main
&Scoped-define SELF-NAME buselecom
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buselecom wgwimpon
ON CHOOSE OF buselecom IN FRAME fr_main
DO:
    ASSIGN 
        n_text    = "exit"
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
            Assign 
            fi_benname   = nv_benname   
            fi_cmrcode2  = n_nO1
            fi_cmrcode   = n_nO2
            fi_cmrsty    = n_nO3       
            fi_comco     = gComp .
        ELSE DO:
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
        ELSE 
            ASSIGN 
                fi_producer = n_produceruse 
                fi_agent    = n_agent    .
    END.
    IF fi_cmrsty = "" THEN ASSIGN fi_cmrsty = "M".
    ASSIGN n_brsty   = fi_cmrsty.    
    Disp fi_comco fi_producer fi_agent fi_benname   fi_cmrcode2  fi_cmrcode  fi_cmrsty  with FRAM fr_main.
    APPLY "entry" TO fi_cmrcode . 
    RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_cov
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_cov wgwimpon
ON CHOOSE OF bu_cov IN FRAME fr_main
DO:
    Run  wgw\wgwhpco1(Input-output  fi_cover1).
    ASSIGN fi_benname   = nv_benname.   
    IF      fi_cover1 = "1" THEN ASSIGN fi_pack = "G".
    ELSE IF fi_cover1 = "2" THEN ASSIGN fi_pack = "Y".
    ELSE IF fi_cover1 = "3" THEN 
        ASSIGN fi_pack    = "R" 
        fi_benname  = "" .
    ELSE IF fi_cover1 = "5" THEN ASSIGN fi_pack = "B".
    Disp  fi_cover1   fi_pack fi_class   fi_benname   with frame  fr_main.                                     
    Apply "Entry"  To  fi_cover1.
    Return no-apply.                   
                    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_create
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_create wgwimpon
ON CHOOSE OF bu_create IN FRAME fr_main /* Create */
DO:
    IF (INPUT fi_notno70) = "" THEN DO:
        ASSIGN  nv_check70 = "NO" .
        MESSAGE "Do you want Gen Policy70 Auto..Now  !!!!"        
            VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO      /*-CANCEL */    
            TITLE "" UPDATE choice AS LOGICAL.
        CASE choice:         
            WHEN TRUE THEN     /* Yes */ 
                DO:
                ASSIGN n_br    = "".
                FIND FIRST company WHERE Company.CompNo = fi_comco NO-LOCK NO-ERROR NO-WAIT.
                IF NOT AVAIL company THEN 
                    MESSAGE "Not fond Company code[n_br ไม่พบอักษรหลังปี]...!!!" fi_comco     SKIP
                            "Plese Set up Company code. !!!"  VIEW-AS ALERT-BOX.
                ELSE DO:
                    ASSIGN  n_br   = Company.AbName 
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
                        ELSE DO:
                            FIND LAST  brstat.tlt    WHERE 
                                (tlt.genusr        = "Phone"          OR
                                 tlt.genusr        = "FAX"  )         AND
                                tlt.policy        = caps(fi_notno70)  NO-LOCK NO-ERROR NO-WAIT.
                            IF NOT AVAIL brstat.tlt THEN DO:  
                                FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE 
                                    sicuw.uwm100.policy = fi_notno70      NO-LOCK NO-ERROR.
                                IF NOT AVAIL sicuw.uwm100 THEN LEAVE running_polno.
                                ELSE NEXT running_polno.
                            END.
                            ELSE NEXT running_polno.
                        END. 
                    END.    /*repeat*/
                    DISP fi_notno70 WITH FRAM fr_main.
                END.   /*else do:...*/
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
                        running_polno2:   /*--Running --*/
                        REPEAT:
                            RUN  wgw\wgwpon03(INPUT        YES,  
                                              INPUT        n_poltyp,
                                              INPUT        nv_brnpol,
                                              INPUT        string(n_undyr2),
                                              INPUT        fi_producer,
                                              INPUT-OUTPUT fi_notno72,
                                              INPUT-OUTPUT nv_check). 
                            IF fi_notno72 = "" THEN LEAVE running_polno2 .
                            ELSE DO:   /*LEAVE running_polno2 .*/
                                FIND LAST  tlt    WHERE
                                    (tlt.genusr     = "Phone"      OR
                                     tlt.genusr     = "FAX"  )     AND
                                     tlt.comp_pol   = fi_notno72   NO-LOCK NO-ERROR NO-WAIT.
                                IF NOT AVAIL tlt THEN DO:
                                    FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE 
                                        sicuw.uwm100.policy = CAPS(fi_notno72) NO-LOCK NO-ERROR.
                                    IF AVAIL sicuw.uwm100 THEN  NEXT running_polno2.
                                    ELSE DO:
                                        ASSIGN
                                            fi_notno72 = CAPS(fi_notno72)
                                            nv_check72 = "yes".
                                        LEAVE running_polno2 .
                                    END.
                                END.
                                ELSE NEXT running_polno2.
                            END. 
                        END.     /*repeat*/
                        DISP  fi_notno72 WITH FRAM fr_main.
                    END.
                    WHEN FALSE THEN    /* No */ 
                        DO:   
                        APPLY "entry" TO fi_notno72.
                        RETURN NO-APPLY.
                    END.
                END CASE.
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
    END.         /* if fi_notno70= "" */
    ELSE IF (INPUT fi_notno72) = "" THEN DO:
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
                        n_br       = Company.AbName
                        fi_notno72 = ""
                        n_poltyp   = "V72"
                        nv_brnpol  = n_brsty + n_br
                        n_undyr2   = string(YEAR(TODAY)) .
                    running_polno3:   /*--Running --*/
                    REPEAT:
                        RUN  wgw\wgwpon03(INPUT        YES,  
                                          INPUT        n_poltyp,
                                          INPUT        nv_brnpol,
                                          INPUT        string(n_undyr2),
                                          INPUT        fi_producer,
                                          INPUT-OUTPUT fi_notno72,
                                          INPUT-OUTPUT nv_check). 
                        IF fi_notno72 = "" THEN LEAVE running_polno3 .
                        ELSE DO:
                            FIND LAST  tlt    WHERE 
                                (tlt.genusr     = "Phone"      OR
                                 tlt.genusr     = "FAX"  )     AND
                                tlt.comp_pol      = fi_notno72  NO-LOCK NO-ERROR NO-WAIT.
                            IF NOT AVAIL tlt THEN DO:
                                FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE 
                                    sicuw.uwm100.policy = CAPS(fi_notno72) NO-LOCK NO-ERROR.
                                IF AVAIL sicuw.uwm100 THEN  NEXT running_polno3.
                                ELSE DO:
                                    ASSIGN
                                        fi_notno72 = CAPS(fi_notno72)
                                        nv_check72 = "yes".
                                    LEAVE running_polno3 .
                                END.
                            END.
                            ELSE NEXT running_polno3.
                        END.
                    END.         /*repeat*/
                    DISP  fi_notno72 WITH FRAM fr_main.
                    APPLY "entry" TO fi_institle.
                    RETURN NO-APPLY.
                END.
            END.
            WHEN FALSE THEN   /* No */          
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
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_exit wgwimpon
ON CHOOSE OF bu_exit IN FRAME fr_main /* Exit */
DO:
    MESSAGE "คุณต้องการออกจากระบบใช่หรือไม่...  !!!!"         SKIP
        "คุณแน่ใจว่าบันทึกข้อมูล เรียบร้อยแล้ว SAVE Complete...  !!!!"   SKIP
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


&Scoped-define SELF-NAME bu_model
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_model wgwimpon
ON CHOOSE OF bu_model IN FRAME fr_main
DO:
    Run  wgw\wgwhpmod(Input-output  fi_model,
                      INPUT         co_brand,
                      Input-output  fi_year,
                      Input-output  fi_power ).
    Disp  fi_model fi_year fi_power  with frame  fr_main.    
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


&Scoped-define SELF-NAME bu_product
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_product wgwimpon
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
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_save wgwimpon
ON CHOOSE OF bu_save IN FRAME fr_main /* Save */
DO:
    FIND LAST  tlt    WHERE 
        tlt.nor_noti_tlt  = fi_notino    AND
        tlt.genusr        = "FAX"        NO-ERROR NO-WAIT .
    IF  AVAIL tlt THEN DO:    
        ASSIGN 
            /*4 */   tlt.nor_usr_ins   = trim(INPUT fi_ins_off)
            /*5 */   tlt.lotno         = trim(INPUT fi_comco) 
            /*6 */   tlt.nor_noti_ins  = trim(Input fi_cmrcode) 
            /*7 */   tlt.nor_usr_tlt   = trim(Input fi_cmrcode2)
            /*8 */   tlt.subins        = trim(Input fi_campaign)
            /*9 */   tlt.safe1         = IF      ra_car  = 1 THEN "เก๋ง" 
                                         ELSE IF ra_car  = 2 THEN "กระบะ"    
                                                             ELSE "โดยสาร" 
            /*12*/   tlt.safe2         = IF    ra_cover  = 1 THEN "ป้ายแดง" 
                                                             ELSE "use car" 
            /*13*/   tlt.safe3         = trim(fi_cover1)
            /*15*/   tlt.stat          = IF ra_pa = 1 THEN "" ELSE trim(fi_product)  
            /*10*/   tlt.filler1       = IF      ra_pree = 1 THEN "แถม"
                                                             ELSE "ไม่แถม"
            /*11*/   tlt.filler2       = IF      ra_comp = 1 THEN "แถม"
                                         ELSE IF ra_comp = 2 THEN "ไม่แถม"  
                                                             ELSE "ไม่เอาพรบ."
            /*16*/   tlt.comp_sub      = trim(Input fi_producer)        
            /*17*/   tlt.recac         = trim(Input fi_agent) 
                     tlt.rec_addr4     = TRIM(fi_deler)         
            /*18*/   tlt.colorcod      = caps(trim(fi_cmrsty)) 
            /*19*/   tlt.policy        = caps(trim(fi_notno70))       
            /*20*/   tlt.comp_pol      = caps(trim(fi_notno72))
            /*21*/   tlt.ins_name      = trim(INPUT fi_institle )  + " " +    
            /*22*/                       trim(INPUT fi_preinsur )  + " " +      
            /*23*/                       trim(Input fi_preinsur2 )  . 
        ASSIGN       tlt.entdat        = fi_idnoexpdat
                     tlt.endno         = fi_idno 
            /*21*/   tlt.dat_ins_noti  = fi_birthday           /*birthday*//*date */  
            /*23*/   tlt.seqno         = fi_age                /*age      *//*inte */           
            /*24*/   tlt.flag          = fi_occup              /*occupn   */  
            /*22*/   tlt.usrsent       = fi_namedrirect        /*name direct */  
            /*22*/   tlt.ins_addr1     = (IF ra_ban = 1 THEN   /*ra_ban = 1  */
                                    trim((IF n_banno = "" THEN "" ELSE "เลขที่ " + TRIM(n_banno)) + " " +  
                                         (IF n_muno  = "" THEN "" ELSE "หมู่ "   + TRIM(n_muno))  + " " +
                                         (IF n_soy   = "" THEN "" ELSE "ซอย"     + TRIM(n_soy))   + " " +  
                                         (IF n_road  = "" THEN "" ELSE "ถนน"     + TRIM(n_road))) 
                                     ELSE IF ra_ban = 2 THEN
                                    trim((IF n_banno = "" THEN "" ELSE "เลขที่ " + TRIM(n_banno)) + " " +  
                                         (IF n_muno  = "" THEN "" ELSE "หมู่ "   + TRIM(n_muno))  + " " +
                                         (IF n_build = "" THEN "" ELSE "อาคาร"   + n_build )      + " " +  
                                         (IF n_soy   = "" THEN "" ELSE "ซอย"     + TRIM(n_soy))   + " " +  
                                         (IF n_road  = "" THEN "" ELSE "ถนน"     + TRIM(n_road))) 
                                     ELSE      /*ra_ban = 3 */
                                    trim((IF n_banno = "" THEN "" ELSE "เลขที่ " + TRIM(n_banno)) + " " +  
                                         (IF n_muno  = "" THEN "" ELSE "หมู่ "   + TRIM(n_muno))  + " " +
                                         (IF n_build = "" THEN "" ELSE "หมู่บ้าน"  + n_build )    + " " +  
                                         (IF n_soy   = "" THEN "" ELSE "ซอย"     + TRIM(n_soy))   + " " +  
                                         (IF n_road  = "" THEN "" ELSE "ถนน"     + TRIM(n_road))))
            /*30*/   tlt.ins_addr2     = trim(Input fi_insadd2tam)     
            /*30*/   tlt.ins_addr3     = TRIM(input fi_insadd3amp)     
            /*31*/   tlt.ins_addr4     = TRIM(Input fi_insadd4cunt)     
            /*32*/   tlt.ins_addr5     = TRIM(Input fi_insadd5post)   
            /*33*/   tlt.comp_noti_ins = TRIM(Input fi_insadd6tel)
            /*33*/   tlt.dri_name1     = IF ra_driv = 1 THEN ""
                                         ELSE IF fi_drivername1 = "" THEN ""
                                         ELSE trim(fi_drivername1) + "sex:" + string(ra_sex1)  + "hbd:" + STRING(fi_hbdri1) + "age:" +  string(fi_agedriv1) + "occ:" + trim(fi_occupdriv1) 
            /*33*/   tlt.dri_no1       = IF ra_driv = 1 THEN ""
                                         ELSE trim(fi_idnodriv1) 
            /*33*/   tlt.enttim        = IF ra_driv = 1 THEN ""
                                         ELSE IF trim(fi_drivername2) = "" THEN ""
                                         ELSE trim(fi_drivername2) + "sex:" + string(ra_sex2)  + "hbd:" + STRING(fi_hbdri2) + "age:" +  string(fi_agedriv2) + "occ:" + trim(fi_occupdriv2) 
            /*33*/   tlt.expotim       = IF ra_driv = 1 THEN ""
                                         ELSE trim(fi_idnodriv2)
            /*34*/   tlt.nor_effdat    = INPUT fi_comdat         
            /*35*/   tlt.expodat       = Input fi_expdat
            /*36*/   tlt.dri_no2       = trim(INPUT fi_ispno)
            /*37*/   tlt.brand         = Input co_brand            
            /*38*/   tlt.model         = trim(Input fi_model)
            /*39*/   tlt.lince2        = trim(Input fi_year) 
            /*40*/   tlt.cc_weight     = INPUT fi_power
            /*41*/   tlt.lince1        = IF (trim(fi_licence1) = "") AND (fi_licence2 = "") THEN ""
                                         ELSE trim(INPUT fi_licence1) + " " +      
            /*42*/                            trim(INPUT fi_licence2) + " " +      
            /*43*/                            INPUT co_provin
            /*44*/   tlt.cha_no        = TRIM( Input fi_cha_no)
            /*45*/   tlt.eng_no        = TRIM( INPUT fi_eng_no)
            /*46*/   tlt.lince3        = TRIM( INPUT fi_pack ) +   
            /*47*/                       TRIM( INPUT fi_class)         
            /*48*/   tlt.exp           = trim(INPUT fi_garage)       
            /*49*/   tlt.nor_coamt     = INPUT fi_sumsi 
            /*50*/   tlt.dri_name2     = STRING(Input fi_gap )
            /*51*/   tlt.nor_grprm     = INPUT fi_premium  
            /*52*/   tlt.comp_coamt    = INPUT fi_precomp  
            /*53*/   tlt.comp_grprm    = INPUT fi_totlepre
            /*54*/   tlt.comp_sck      = trim(INPUT fi_stk)
            /*55*/   tlt.comp_noti_tlt = trim(INPUT fi_refer)         
            /*56*/   tlt.rec_name      = trim(Input fi_recipname)  
            /*57*/   tlt.comp_usr_tlt  = trim(INPUT fi_vatcode) 
            /*58*/   tlt.expousr       = IF co_user = "" THEN fi_user2 
            /*59*/                                       ELSE co_user
            /*60*/   tlt.comp_usr_ins  = fi_benname
            /*61*/   tlt.OLD_cha       = USERID(LDBNAME(1))  + ":" + trim(Input fi_remark1)        
            /*62*/   tlt.OLD_eng       = IF ra_complete = 1 THEN "complete"
                                         ELSE "not complete"
            /*  */   tlt.genusr        = "FAX" 
            /*  */   tlt.imp           = "IM"                     /*Import Data*/
            /*  */   tlt.releas        = "No" .
    END.
    MESSAGE "SAVE COMPLETE..." VIEW-AS ALERT-BOX.
    Apply "Close"  To this-procedure.
    Return no-apply.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME co_benname
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL co_benname wgwimpon
ON VALUE-CHANGED OF co_benname IN FRAME fr_main
DO:
    co_benname = INPUT co_benname .
    ASSIGN fi_benname = INPUT co_benname.
    DISP co_benname fi_benname WITH FRAM fr_main.
    APPLY "entry" TO fi_user2.
    RETURN NO-APPLY.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME co_brand
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL co_brand wgwimpon
ON VALUE-CHANGED OF co_brand IN FRAME fr_main
DO: 
   co_brand = INPUT co_brand.
   /*IF co_brand = ""  THEN DO:
       APPLY "ENTRY" TO fi_brand2 IN FRAME fr_main.
       RETURN NO-APPLY.

   END.
   ELSE DO:
       ASSIGN fi_brand2 = "".
       APPLY "ENTRY" TO fi_model IN FRAME fr_main.
       RETURN NO-APPLY.
   END.*/
   DISP co_brand  WITH FRAM fr_main.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME co_provin
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL co_provin wgwimpon
ON LEAVE OF co_provin IN FRAME fr_main
DO:
   /*p-------------*/
    co_provin = INPUT co_provin.
   /* n_asdat = DATE(INPUT co_provin).

    IF n_asdat = ? THEN DO:
        MESSAGE "ไม่พบข้อมูล กรุณาตรวจสอบการ Process ข้อมูล" VIEW-AS ALERT-BOX WARNING.
        RETURN NO-APPLY.
    END.*/
    /*-------------p*/

    /*APPLY "ENTRY" TO fi_comdatF.*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL co_provin wgwimpon
ON return OF co_provin IN FRAME fr_main
DO:
  APPLY "LEAVE" TO co_provin.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL co_provin wgwimpon
ON VALUE-CHANGED OF co_provin IN FRAME fr_main
DO:
  /*p-------------*/
    co_provin = INPUT co_provin.
    /*n_asdat = DATE(INPUT co_provin).

    IF n_asdat = ? THEN DO:
        MESSAGE "ไม่พบข้อมูล กรุณาตรวจสอบการ Process ข้อมูล" VIEW-AS ALERT-BOX WARNING.
        RETURN NO-APPLY.
    END.*/
    /*APPLY "ENTRY" TO fi_cha_no IN FRAME fr_main.
    RETURN NO-APPLY. */
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME co_user
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL co_user wgwimpon
ON VALUE-CHANGED OF co_user IN FRAME fr_main
DO:
  co_user = INPUT co_user .
  IF co_user = "" THEN DO:
      APPLY "entry" TO fi_user2.
      RETURN NO-APPLY.
  END.
  DISP co_user WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_agent
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_agent wgwimpon
ON LEAVE OF fi_agent IN FRAME fr_main
DO:
    fi_agent  = trim( caps( INPUT fi_agent )).
    DISP fi_agent WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_benname
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_benname wgwimpon
ON LEAVE OF fi_benname IN FRAME fr_main
DO:
  fi_benname = trim(INPUT fi_benname).
  DISP fi_benname with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_birthday
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_birthday wgwimpon
ON LEAVE OF fi_birthday IN FRAME fr_main
DO:
    fi_birthday = INPUT fi_birthday.
    IF fi_birthday = ? THEN DO:
        ASSIGN fi_age  = 0.
        DISP fi_birthday fi_age WITH FRAM fr_main.
    END.
    ELSE DO:
        IF  YEAR(fi_birthday) < YEAR(TODAY) THEN DO:
            MESSAGE "กรุณาคีย์ปีเกิดเป็น  พ.ศ....!!!" VIEW-AS ALERT-BOX.
            APPLY "entry" TO fi_birthday.
            RETURN NO-APPLY.
        END.
        ELSE DO:
            ASSIGN   fi_age  = (YEAR(TODAY) + 543) - YEAR(fi_birthday).
            DISP fi_birthday fi_age WITH FRAM fr_main.
            APPLY "entry" TO fi_idnoexpdat.
            RETURN NO-APPLY.
        END.
    END.
    DISP fi_birthday fi_age WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_campaign
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_campaign wgwimpon
ON LEAVE OF fi_campaign IN FRAME fr_main
DO:
    fi_campaign  =  trim(CAPS( Input  fi_campaign )) .
    Disp  fi_campaign with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_cha_no
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_cha_no wgwimpon
ON LEAVE OF fi_cha_no IN FRAME fr_main
DO:
  fi_cha_no  = TRIM(CAPS( Input  fi_cha_no )).
  Disp  fi_cha_no with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_class
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_class wgwimpon
ON LEAVE OF fi_class IN FRAME fr_main
DO:
    fi_class  =  trim( Input  fi_class) .
    Disp  fi_class with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_cmrcode
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_cmrcode wgwimpon
ON LEAVE OF fi_cmrcode IN FRAME fr_main
DO:
    fi_cmrcode = trim(INPUT fi_cmrcode).
    Disp fi_cmrcode  with FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_cmrcode2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_cmrcode2 wgwimpon
ON LEAVE OF fi_cmrcode2 IN FRAME fr_main
DO:
    fi_cmrcode2 = trim(INPUT fi_cmrcode2).
    DISP fi_cmrcode2 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_cmrsty
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_cmrsty wgwimpon
ON LEAVE OF fi_cmrsty IN FRAME fr_main
DO:
    fi_cmrsty  =  trim( caps(INPUT fi_cmrsty)) .
    ASSIGN fi_cmrsty = caps(fi_cmrsty) 
           n_brsty   = trim(fi_cmrsty).
    DISP fi_cmrsty WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_comco
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_comco wgwimpon
ON LEAVE OF fi_comco IN FRAME fr_main
DO: 
    fi_comco = trim(caps(INPUT fi_comco)).
    IF fi_comco <> "" THEN DO:
        FIND FIRST company WHERE Company.CompNo = fi_comco  NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL company THEN  
            MESSAGE "Not found Company code...!!!"    SKIP
            "Plese Set up Company code. !!!"  VIEW-AS ALERT-BOX.
        ELSE DO:
            ASSIGN fi_benname = Company.Name2       
                nv_benname    = Company.Name2 .     
            IF ra_cover = 1 THEN                    
                ASSIGN                              
                fi_producer = company.Text1         
                fi_agent    = company.Text4 .       
            ELSE                                    
                ASSIGN                              
                    fi_producer = company.Text2     
                    fi_agent    = company.Text4 .  
        END.
    END.
    DISP  fi_comco fi_producer fi_agent fi_benname  WITH FRAM fr_main.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_comdat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_comdat wgwimpon
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
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_cover1 wgwimpon
ON LEAVE OF fi_cover1 IN FRAME fr_main
DO:
    fi_cover1 = INPUT fi_cover1.
    ASSIGN fi_benname   = nv_benname .    
    IF      fi_cover1 = "1" THEN ASSIGN fi_pack = "G".
    ELSE IF fi_cover1 = "2" THEN ASSIGN fi_pack = "Y".
    ELSE IF fi_cover1 = "3" THEN DO:
        IF ra_car = 2 THEN
            ASSIGN fi_pack = "R"  
            fi_benname  = "".
        ELSE ASSIGN fi_pack = "V"  
             fi_benname  = "" .
    END.
    ELSE IF fi_cover1 = "5" THEN ASSIGN fi_pack = "B".
    Disp  fi_cover1 fi_pack fi_class fi_benname  with frame  fr_main. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_deler
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_deler wgwimpon
ON LEAVE OF fi_deler IN FRAME fr_main
DO:
    fi_deler  = caps(trim( INPUT fi_deler )).
    DISP fi_deler WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fr_driv
&Scoped-define SELF-NAME fi_drivername1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_drivername1 wgwimpon
ON LEAVE OF fi_drivername1 IN FRAME fr_driv
DO:
  fi_drivername1  = trim( INPUT fi_drivername1).
  DISP fi_drivername1 WITH FRAM fr_driv.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_drivername2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_drivername2 wgwimpon
ON LEAVE OF fi_drivername2 IN FRAME fr_driv
DO:
  fi_drivername2  = trim( INPUT fi_drivername2).
  DISP fi_drivername2 WITH FRAM fr_driv.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fr_main
&Scoped-define SELF-NAME fi_eng_no
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_eng_no wgwimpon
ON LEAVE OF fi_eng_no IN FRAME fr_main
DO:
  fi_eng_no  = trim( CAPS(Input  fi_eng_no)).
  Disp  fi_eng_no with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_expdat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_expdat wgwimpon
ON LEAVE OF fi_expdat IN FRAME fr_main
DO:
  fi_expdat = INPUT fi_expdat.
  DISP fi_expdat WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_gap
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_gap wgwimpon
ON LEAVE OF fi_gap IN FRAME fr_main
DO:
    fi_gap  = INPUT fi_gap.
    ASSIGN 
        fi_premium =  Truncate(fi_gap * 0.4 / 100,0) + 
                     (IF (fi_gap * 0.4 / 100) - Truncate(fi_gap * 0.4 / 100,0) > 0 Then 1 Else 0)
                      + fi_gap .
        fi_premium = ( fi_premium * 7 / 100 ) +  fi_premium .

    DISP fi_gap fi_premium   WITH FRAM fr_main. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_garage
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_garage wgwimpon
ON LEAVE OF fi_garage IN FRAME fr_main
DO:
    fi_garage  = TRIM( caps(Input fi_garage )) .
    Disp  fi_garage with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fr_driv
&Scoped-define SELF-NAME fi_hbdri1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_hbdri1 wgwimpon
ON LEAVE OF fi_hbdri1 IN FRAME fr_driv
DO:
    fi_hbdri1 = INPUT fi_hbdri1.
    IF fi_hbdri1 <> ? THEN do:
        IF  YEAR(fi_hbdri1) < YEAR(TODAY) THEN DO:
            MESSAGE "กรุณาคีย์ปีเกิดเป็น  พ.ศ....!!!" VIEW-AS ALERT-BOX.
            APPLY "entry" TO fi_hbdri1.
            RETURN NO-APPLY.
        END.
        ELSE DO:
            ASSIGN   fi_agedriv1  = (YEAR(TODAY) + 543) - YEAR(fi_hbdri1).
            DISP fi_hbdri1 fi_agedriv1 WITH FRAM fr_driv.
            APPLY "entry" TO fi_occupdriv1.
            RETURN NO-APPLY.
        END.
    END.
    DISP fi_hbdri1 fi_agedriv1 WITH FRAM fr_driv.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_hbdri2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_hbdri2 wgwimpon
ON LEAVE OF fi_hbdri2 IN FRAME fr_driv
DO:
  fi_hbdri2 = INPUT fi_hbdri2.
  IF fi_hbdri2 <> ? THEN do:
        IF  YEAR(fi_hbdri2) < YEAR(TODAY) THEN DO:
            MESSAGE "กรุณาคีย์ปีเกิดเป็น  พ.ศ....!!!" VIEW-AS ALERT-BOX.
            APPLY "entry" TO fi_hbdri2.
            RETURN NO-APPLY.
        END.
        ELSE DO:
            ASSIGN   fi_agedriv2  = (YEAR(TODAY) + 543) - YEAR(fi_hbdri2).
            DISP fi_hbdri2 fi_agedriv2 WITH FRAM fr_driv.
            APPLY "entry" TO fi_occupdriv2.
            RETURN NO-APPLY.
        END.
    END.
    DISP fi_hbdri2 fi_agedriv2 WITH FRAM fr_driv.
  DISP fi_hbdri2 WITH FRAM fr_driv.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fr_main
&Scoped-define SELF-NAME fi_idno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_idno wgwimpon
ON LEAVE OF fi_idno IN FRAME fr_main
DO:
    fi_idno = trim(INPUT fi_idno).
    ASSIGN 
    nv_seq        = 1
    nv_sum        = 0
    nv_checkdigit = 0 .         
    IF fi_idno <> "" THEN DO:
        IF LENGTH(TRIM(fi_idno)) = 13 THEN DO:
            DO WHILE nv_seq <= 12:
                nv_sum = nv_sum + INTEGER(SUBSTR(TRIM(fi_idno),nv_seq,1)) * (14 - nv_seq).
                nv_seq = nv_seq + 1.
            END.
            nv_checkdigit = 11 - nv_sum MODULO 11.
            IF nv_checkdigit >= 10 THEN nv_checkdigit = nv_checkdigit - 10.
            IF STRING(nv_checkdigit) <> SUBSTR(TRIM(fi_idno),13,1) THEN  
                MESSAGE "| WARNING: พบเลขบัตรประชาชนไม่ถูกต้อง" VIEW-AS ALERT-BOX.
        END.
    END.
    DISP fi_idno WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fr_driv
&Scoped-define SELF-NAME fi_idnodriv1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_idnodriv1 wgwimpon
ON LEAVE OF fi_idnodriv1 IN FRAME fr_driv
DO:
    fi_idnodriv1 = trim( INPUT fi_idnodriv1).
    DISP fi_idnodriv1 WITH FRAM fr_driv.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_idnodriv2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_idnodriv2 wgwimpon
ON LEAVE OF fi_idnodriv2 IN FRAME fr_driv
DO:
  fi_idnodriv2 = trim( INPUT fi_idnodriv2 ).
  DISP fi_idnodriv2 WITH FRAM fr_driv.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fr_main
&Scoped-define SELF-NAME fi_idnoexpdat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_idnoexpdat wgwimpon
ON LEAVE OF fi_idnoexpdat IN FRAME fr_main
DO:
    fi_idnoexpdat = INPUT fi_idnoexpdat.
    IF fi_idnoexpdat <> ?  THEN DO:
        IF  YEAR(fi_idnoexpdat) < YEAR(TODAY) THEN DO:
            MESSAGE "กรุณาคีย์ปีเกิดเป็น  พ.ศ....!!!" VIEW-AS ALERT-BOX.
            APPLY "entry" TO fi_idnoexpdat.
            RETURN NO-APPLY.
        END.
    END.
    DISP fi_idnoexpdat  WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_insadd1build
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_insadd1build wgwimpon
ON LEAVE OF fi_insadd1build IN FRAME fr_main
DO:
    fi_insadd1build  = trim( INPUT fi_insadd1build).
    ASSIGN n_build = fi_insadd1build .
    IF ra_ban = 1 THEN DO: 
        MESSAGE "กรุณาเลือกสถานที่ ...อาคาร/หมู่บ้าน ..." VIEW-AS ALERT-BOX.
        APPLY "entry" TO    ra_ban.
        RETURN NO-APPLY.
    END.
    DISP fi_insadd1build WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_insadd1mu
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_insadd1mu wgwimpon
ON LEAVE OF fi_insadd1mu IN FRAME fr_main
DO:
    fi_insadd1mu  = trim( INPUT fi_insadd1mu ).
    ASSIGN n_muno = fi_insadd1mu .
    DISP fi_insadd1mu WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_insadd1no
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_insadd1no wgwimpon
ON LEAVE OF fi_insadd1no IN FRAME fr_main
DO:
    fi_insadd1no   = trim( INPUT fi_insadd1no ).
    ASSIGN n_banno = fi_insadd1no .
    DISP fi_insadd1no WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_insadd1road
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_insadd1road wgwimpon
ON LEAVE OF fi_insadd1road IN FRAME fr_main
DO:
  fi_insadd1road  = trim( INPUT fi_insadd1road).
  ASSIGN n_road = fi_insadd1road .
  DISP fi_insadd1road WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_insadd1soy
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_insadd1soy wgwimpon
ON LEAVE OF fi_insadd1soy IN FRAME fr_main
DO:
    fi_insadd1soy  = trim( INPUT fi_insadd1soy).
    ASSIGN n_soy   = fi_insadd1soy .
    DISP fi_insadd1soy WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_insadd2tam
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_insadd2tam wgwimpon
ON LEAVE OF fi_insadd2tam IN FRAME fr_main
DO:
    fi_insadd2tam  = trim( INPUT fi_insadd2tam).
    DISP fi_insadd2tam WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_insadd3amp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_insadd3amp wgwimpon
ON LEAVE OF fi_insadd3amp IN FRAME fr_main
DO:
  fi_insadd3amp = trim( INPUT fi_insadd3amp).
  DISP fi_insadd3amp WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_insadd4cunt
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_insadd4cunt wgwimpon
ON LEAVE OF fi_insadd4cunt IN FRAME fr_main
DO:
  fi_insadd4cunt  = trim( INPUT fi_insadd4cunt ).
  DISP fi_insadd4cunt WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_insadd5post
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_insadd5post wgwimpon
ON LEAVE OF fi_insadd5post IN FRAME fr_main
DO:
  fi_insadd5post  = trim( INPUT fi_insadd5post ).
  DISP fi_insadd5post WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_insadd6tel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_insadd6tel wgwimpon
ON LEAVE OF fi_insadd6tel IN FRAME fr_main
DO:
  fi_insadd6tel  = trim( INPUT fi_insadd6tel).
  DISP fi_insadd6tel WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_institle
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_institle wgwimpon
ON LEAVE OF fi_institle IN FRAME fr_main
DO:
    fi_institle = trim( INPUT fi_institle ).
    DISP fi_institle WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_ins_off
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_ins_off wgwimpon
ON LEAVE OF fi_ins_off IN FRAME fr_main
DO:
    fi_ins_off = trim(INPUT fi_ins_off).
    DISP fi_ins_off WITH FRAM fr_main.   
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_ispno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_ispno wgwimpon
ON LEAVE OF fi_ispno IN FRAME fr_main
DO:
    fi_ispno  = trim( CAPS ( INPUT fi_ispno )).
    DISP fi_ispno WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_licence1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_licence1 wgwimpon
ON LEAVE OF fi_licence1 IN FRAME fr_main
DO:
    fi_licence1 = TRIM( Input  fi_licence1).
    Disp  fi_licence1 with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_licence2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_licence2 wgwimpon
ON LEAVE OF fi_licence2 IN FRAME fr_main
DO:
    fi_licence2 = TRIM( Input  fi_licence2 ).
    Disp  fi_licence2 with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_model
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_model wgwimpon
ON LEAVE OF fi_model IN FRAME fr_main
DO:
    fi_model = trim( INPUT fi_model).
    DISP fi_model WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_namedrirect
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_namedrirect wgwimpon
ON LEAVE OF fi_namedrirect IN FRAME fr_main
DO:
  fi_namedrirect = trim( INPUT fi_namedrirect ).
  DISP fi_namedrirect WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_notno70
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_notno70 wgwimpon
ON LEAVE OF fi_notno70 IN FRAME fr_main
DO:
    fi_notno70 = trim( caps(INPUT fi_notno70)) .
    IF (INPUT fi_notno70)  <> ""   THEN DO:   
        IF LENGTH(fi_notno70) <> 12  THEN DO:  
            MESSAGE "เลขกรมธรรม์ต้องเท่ากับ 12 หลัก !!!" VIEW-AS ALERT-BOX.
            APPLY "entry" TO fi_notno70.
            RETURN NO-APPLY.
        END.
        ELSE DO:
            FIND LAST  brstat.tlt    WHERE 
                (tlt.genusr        = "Phone"          OR
                 tlt.genusr        = "FAX"  )         AND
                 tlt.policy        = caps(fi_notno70)  NO-LOCK NO-ERROR NO-WAIT.
            IF NOT AVAIL brstat.tlt THEN DO:  
                FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE 
                    sicuw.uwm100.policy = trim( INPUT fi_notno70 ) NO-LOCK NO-ERROR.
                IF AVAIL sicuw.uwm100 THEN DO:
                    IF  (sicuw.uwm100.name1 <> "") OR (sicuw.uwm100.comdat <> ? ) THEN DO:
                        MESSAGE "พบเลขกรมธรรม์นี้ในระบบ Premium !!!" VIEW-AS ALERT-BOX.
                        APPLY "entry" TO fi_notno70.
                        RETURN NO-APPLY.
                    END.
                END.
            END.
            ELSE DO:
                IF tlt.nor_noti_tlt  <> fi_notino THEN do: 
                MESSAGE "พบเลขกรมธรรม์นี้ในระบบ" + tlt.genusr +  "เลขที่รับแจ้ง " + tlt.nor_noti_tlt  VIEW-AS ALERT-BOX.
                        APPLY "entry" TO fi_notno70.
                        RETURN NO-APPLY.
                END.
            END.
        END.
        IF length(TRIM(fi_cmrsty)) = 1 THEN DO:
            IF substr(TRIM(fi_notno70),2,1) <> TRIM(fi_cmrsty) THEN 
                MESSAGE "สาขา" + TRIM(fi_cmrsty) + "ไม่ตรงกับ เลขกรมธรรม์!!!" VIEW-AS ALERT-BOX.
        END.
        ELSE DO:
            IF substr(TRIM(fi_notno70),1,2) <> TRIM(fi_cmrsty) THEN 
                MESSAGE "สาขา" + TRIM(fi_cmrsty) + "ไม่ตรงกับ เลขกรมธรรม์!!!" VIEW-AS ALERT-BOX.
        END.
    END.
    DISP fi_notno70 WITH FRAM fr_main.
END.

/* fi_notino */

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_notno72
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_notno72 wgwimpon
ON LEAVE OF fi_notno72 IN FRAME fr_main
DO:
    fi_notno72 = trim( caps(INPUT fi_notno72)) .
    IF (fi_notno72  <> "") AND (nv_check72 = "no") THEN DO:  
        IF ((INPUT fi_notno72)  <> "" )   THEN DO:  
            IF LENGTH((INPUT fi_notno72)) <> 12  THEN 
                MESSAGE "เลขกรมธรรม์ต้องเท่ากับ 12 หลัก !!!" VIEW-AS ALERT-BOX.  
            FIND LAST  tlt    WHERE 
                (tlt.genusr        = "Phone"            OR
                 tlt.genusr        = "FAX"  )           AND
                 tlt.comp_pol      = (INPUT fi_notno72) NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL tlt THEN DO:
                IF tlt.nor_noti_tlt  <> fi_notino THEN do: 
                    MESSAGE "Found policy72 duplicate...tlt: " + tlt.nor_noti_tlt VIEW-AS ALERT-BOX.
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
            END.
        END.
    END.
    DISP fi_notno72 WITH FRAM fr_main. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_occup
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_occup wgwimpon
ON LEAVE OF fi_occup IN FRAME fr_main
DO:
  fi_occup = trim( INPUT fi_occup ).
  DISP fi_occup WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fr_driv
&Scoped-define SELF-NAME fi_occupdriv1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_occupdriv1 wgwimpon
ON LEAVE OF fi_occupdriv1 IN FRAME fr_driv
DO:
    fi_occupdriv1 = trim( INPUT fi_occupdriv1).
    DISP fi_occupdriv1 WITH FRAM fr_driv.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_occupdriv2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_occupdriv2 wgwimpon
ON LEAVE OF fi_occupdriv2 IN FRAME fr_driv
DO:
    fi_occupdriv2 = trim( INPUT fi_occupdriv2).
    DISP fi_occupdriv2 WITH FRAM fr_driv.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fr_main
&Scoped-define SELF-NAME fi_pack
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_pack wgwimpon
ON LEAVE OF fi_pack IN FRAME fr_main
DO:
    fi_pack  =  trim( caps(Input  fi_pack)).
    Disp  fi_pack with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_power
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_power wgwimpon
ON LEAVE OF fi_power IN FRAME fr_main
DO:
    fi_power  =  Input  fi_power.
    Disp  fi_power with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_precomp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_precomp wgwimpon
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
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_preinsur wgwimpon
ON LEAVE OF fi_preinsur IN FRAME fr_main
DO:
    fi_preinsur = trim( INPUT fi_preinsur ).
    DISP fi_preinsur WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_preinsur2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_preinsur2 wgwimpon
ON LEAVE OF fi_preinsur2 IN FRAME fr_main
DO:
    fi_preinsur2 = trim( INPUT fi_preinsur2 ).
    DISP fi_preinsur2 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_premium
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_premium wgwimpon
ON LEAVE OF fi_premium IN FRAME fr_main
DO:
    fi_premium  = INPUT fi_premium.
    DISP fi_premium WITH FRAM fr_main. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_producer
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_producer wgwimpon
ON LEAVE OF fi_producer IN FRAME fr_main
DO:
    fi_producer  = trim( caps( INPUT fi_producer )).
    DISP fi_producer WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_product
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_product wgwimpon
ON LEAVE OF fi_product IN FRAME fr_main
DO:
    fi_product = trim( INPUT fi_product ).
    IF ((INPUT fi_product) <> "" ) AND (ra_pa = 1) THEN DO:
        MESSAGE "กรุณาเลือก ขาย PA "   VIEW-AS ALERT-BOX.
        ASSIGN fi_product = "".
        APPLY "entry" TO ra_pa.
        RETURN NO-APPLY.   
    END.
    Disp  fi_product   with frame  fr_main.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_recipname
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_recipname wgwimpon
ON LEAVE OF fi_recipname IN FRAME fr_main
DO:
  fi_recipname = TRIM( Input  fi_recipname).
  Disp  fi_recipname with frame  fr_main. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_refer
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_refer wgwimpon
ON LEAVE OF fi_refer IN FRAME fr_main
DO:
  fi_refer  = TRIM (INPUT fi_refer).
  DISP fi_refer WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_remark1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_remark1 wgwimpon
ON LEAVE OF fi_remark1 IN FRAME fr_main
DO:
  fi_remark1 = trim(INPUT fi_remark1).
  DISP fi_remark1 with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_stk
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_stk wgwimpon
ON LEAVE OF fi_stk IN FRAME fr_main
DO:
  fi_stk  = TRIM( INPUT fi_stk ).
  DISP fi_stk WITH FRAM fr_main. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_sumsi
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_sumsi wgwimpon
ON LEAVE OF fi_sumsi IN FRAME fr_main
DO:
    fi_sumsi  = INPUT fi_sumsi.
  DISP fi_sumsi  WITH FRAM fr_main. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_totlepre
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_totlepre wgwimpon
ON LEAVE OF fi_totlepre IN FRAME fr_main
DO:
    fi_totlepre  = INPUT fi_totlepre.
    DISP fi_totlepre WITH FRAM fr_main. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_user2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_user2 wgwimpon
ON LEAVE OF fi_user2 IN FRAME fr_main
DO:
  fi_user2 = trim( INPUT fi_user2).
  DISP fi_user2 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_vatcode
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_vatcode wgwimpon
ON LEAVE OF fi_vatcode IN FRAME fr_main
DO:
    fi_vatcode  = trim(caps( INPUT fi_vatcode )).
    DISP fi_vatcode WITH FRAM fr_main. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_year
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_year wgwimpon
ON LEAVE OF fi_year IN FRAME fr_main
DO:
    fi_year  =  trim( Input fi_year ).
    Disp fi_year with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ra_ban
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_ban wgwimpon
ON VALUE-CHANGED OF ra_ban IN FRAME fr_main
DO: 
    ra_ban = INPUT ra_ban.
    DISP ra_ban WITH FRAM fr_main.
    IF ra_ban = 1 THEN DO:
        ASSIGN fi_insadd1build = "".
        DISABLE fi_insadd1build .
        DISP fi_insadd1build WITH FRAM fr_main.
        APPLY "entry" TO    fi_insadd1soy.
        RETURN NO-APPLY. 
    END.
    ELSE DO:
        ENABLE fi_insadd1build .
        APPLY "entry" TO    fi_insadd1build.
        RETURN NO-APPLY. 
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ra_car
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_car wgwimpon
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
        ASSIGN fi_class = "320".
        IF fi_cover1 = "3" THEN 
            ASSIGN fi_pack = "R"  
            fi_benname  = "".
    END.
    ELSE IF ra_car = 3 THEN DO:
        ASSIGN fi_class = "210".
        IF fi_cover1 = "3" THEN DO:
            IF ra_car = 2 THEN
                ASSIGN 
                fi_pack    = "R"  
                fi_benname = "" .
            ELSE ASSIGN 
                fi_pack    = "V"  
                fi_benname = "" .
        END.
    END.
    DISP ra_car fi_pack fi_class fi_benname   WITH FRAM fr_main.
    APPLY "entry" TO fi_cover1.
    RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ra_comp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_comp wgwimpon
ON VALUE-CHANGED OF ra_comp IN FRAME fr_main
DO:
    ra_comp = INPUT ra_comp.
    DISP ra_comp WITH FRAM fr_main.
    APPLY "entry" TO fi_producer.
    RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ra_complete
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_complete wgwimpon
ON VALUE-CHANGED OF ra_complete IN FRAME fr_main
DO:
    ra_complete = INPUT ra_complete.
    DISP ra_complete WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ra_cover
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_cover wgwimpon
ON VALUE-CHANGED OF ra_cover IN FRAME fr_main
DO:
    ra_cover = INPUT ra_cover .
    IF ra_cover = 1 THEN
        ASSIGN fi_pack = "G"
        fi_producer = n_producernew  
        fi_agent    = n_agent    .
    ELSE 
        ASSIGN 
            fi_producer = n_produceruse 
            fi_agent    =  n_agent    .
    DISP ra_cover fi_comco fi_producer fi_agent fi_pack  WITH FRAM fr_main. 
    APPLY "entry" TO fi_cover1 .
    RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ra_driv
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_driv wgwimpon
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
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_pa wgwimpon
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
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_pree wgwimpon
ON VALUE-CHANGED OF ra_pree IN FRAME fr_main
DO:
    ra_pree = INPUT ra_pree.
    DISP ra_pree WITH FRAM fr_main.
    APPLY "entry" TO fi_producer.
    RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fr_driv
&Scoped-define SELF-NAME ra_sex1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_sex1 wgwimpon
ON VALUE-CHANGED OF ra_sex1 IN FRAME fr_driv
DO: 
    ra_sex1 = INPUT ra_sex1.
    DISP ra_sex1 WITH FRAM fr_driv.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ra_sex2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_sex2 wgwimpon
ON VALUE-CHANGED OF ra_sex2 IN FRAME fr_driv
DO: 
    ra_sex2 = INPUT ra_sex2.
    DISP ra_sex2 WITH FRAM fr_driv.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK wgwimpon 


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
DO ON ERROR    UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
    ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:
    RUN enable_UI.
    /********************  T I T L E   F O R  C - W I N  ****************/
    DEF  VAR  gv_prgid   AS   CHAR.
    DEF  VAR  gv_prog    AS   CHAR.
    ASSIGN 
        gv_prgid = "wgwimfa1"
        gv_prog  = "Import text file By FAX..." .
    RUN  WUT\WUTHEAD ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).
    
    /*********************************************************************/ 
    /*  RUN Wut\WutwiCen ({&WINDOW-NAME}:HANDLE). */ 
    /*CURRENT-WINDOW:WINDOW-STATE = WINDOW-MAXIMIZED.*/
    
    SESSION:DATA-ENTRY-RETURN = YES. 
    
    /*Rect-336:Move-to-top().*/
    /*co_provin = vAcProc_fil.*/
    /*------------------------*/
    /*RUN proc_provin.*/
    /*------------------------*/
    RUN proc_initdata.
    FIND FIRST tlt WHERE tlt.nor_noti_tlt = n_policy NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL tlt  THEN 
        ASSIGN
        fi_notino  =   tlt.nor_noti_tlt             
        fi_notdat  =   tlt.trndat         
        fi_nottim  =   tlt.trntime              
        fi_user    =   tlt.usrid        .
    ASSIGN 
        co_provin:LIST-ITEMS = vAcProc_fil  
        co_provin = ENTRY(1,vAcProc_fil)   
        co_brand:LIST-ITEMS = vAcProc_fil1  
        co_brand  = ENTRY(1,vAcProc_fil1)
        co_user:LIST-ITEMS = vAcProc_fil2 
        co_user  = ENTRY(1,vAcProc_fil2) 
        co_benname:LIST-ITEMS = vAcProc_fil3 
        co_benname  = ENTRY(1,vAcProc_fil3) 
        fi_comco    = " "
        fi_cmrsty   = "M"
        n_brsty     = "M"
        fi_institle = "คุณ"
        fi_comdat   = TODAY
        fi_expdat   = TODAY
        fi_notino   = n_policy                      
        fi_campaign = "C56/00108"
        ra_cover    = 1
        fi_cover1   = "1"    
        ra_pa       = 1  
        fi_product  = ""
        ra_car      = 1
        ra_pree     = 1
        ra_comp     = 1
        ra_complete = 1
        ra_driv     = 1
        ra_ban      = 1    
        fi_notno70  = ""
        fi_notno72  = ""
        fi_pack     = "G"
        fi_class    = "110"
        nv_check70  = "no"
        nv_check72  = "no".
    
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
        DISP            fi_comco        fi_cmrsty       fi_institle     fi_comdat       fi_expdat       fi_notdat 
        fi_nottim       fi_notino       fi_campaign     ra_cover        fi_cover1       ra_pa   
        fi_product      ra_car          ra_pree         ra_comp         ra_complete     fi_notno70 
        fi_notno72      fi_pack         fi_class        fi_ins_off      fi_cmrcode      fi_cmrcode2
        fi_producer     fi_agent        fi_preinsur     fi_preinsur2    fi_insadd1no    fi_insadd1mu    
        fi_insadd1build fi_insadd1soy   fi_insadd1road  fi_insadd2tam   fi_insadd3amp   fi_insadd4cunt  
        fi_insadd5post  fi_insadd6tel   fi_ispno        co_brand        fi_model        fi_year         
        fi_power        fi_licence1     fi_licence2     co_provin       fi_cha_no       fi_eng_no       
        fi_garage       fi_sumsi        fi_gap          fi_premium      fi_precomp      fi_totlepre     
        fi_stk          fi_refer        fi_recipname    fi_vatcode      co_user         fi_benname       co_benname  
        fi_remark1      fi_user2        ra_ban          fi_user         ra_driv    With frame   fr_main.     
     
    IF NOT THIS-PROCEDURE:PERSISTENT THEN
        WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI wgwimpon  _DEFAULT-DISABLE
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
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(wgwimpon)
  THEN DELETE WIDGET wgwimpon.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI wgwimpon  _DEFAULT-ENABLE
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
  DISPLAY fi_ins_off fi_comco fi_cmrcode fi_cmrcode2 ra_car ra_cover fi_cover1 
          fi_product ra_pree ra_comp fi_producer fi_agent fi_deler fi_cmrsty 
          fi_notno70 fi_notno72 fi_institle fi_preinsur fi_preinsur2 fi_idno 
          fi_birthday fi_age fi_idnoexpdat fi_occup fi_namedrirect fi_insadd1no 
          fi_insadd1mu ra_ban fi_insadd1build fi_insadd1soy fi_insadd1road 
          fi_insadd2tam fi_insadd3amp fi_insadd4cunt fi_insadd5post 
          fi_insadd6tel fi_comdat fi_expdat fi_ispno co_brand fi_model fi_year 
          fi_power fi_licence1 fi_licence2 co_provin fi_cha_no fi_eng_no ra_driv 
          fi_pack fi_class fi_garage fi_sumsi fi_gap fi_premium fi_precomp 
          fi_totlepre fi_stk fi_refer fi_recipname fi_vatcode co_user fi_user2 
          fi_benname co_benname fi_remark1 ra_complete fi_user fi_campaign ra_pa 
          fi_notdat fi_nottim fi_notino 
      WITH FRAME fr_main IN WINDOW wgwimpon.
  ENABLE fi_ins_off fi_comco fi_cmrcode fi_cmrcode2 ra_car ra_cover fi_cover1 
         fi_product bu_product ra_pree ra_comp fi_producer fi_agent fi_deler 
         fi_cmrsty bu_create fi_notno70 fi_notno72 fi_institle fi_preinsur 
         fi_preinsur2 fi_idno fi_birthday fi_idnoexpdat fi_occup fi_namedrirect 
         fi_insadd1no fi_insadd1mu ra_ban fi_insadd1build fi_insadd1soy 
         fi_insadd1road fi_insadd2tam fi_insadd3amp fi_insadd4cunt 
         fi_insadd5post fi_insadd6tel fi_comdat fi_expdat fi_ispno co_brand 
         fi_model bu_model fi_year fi_power fi_licence1 fi_licence2 co_provin 
         fi_cha_no fi_eng_no ra_driv fi_pack fi_class fi_garage fi_sumsi fi_gap 
         fi_premium fi_precomp fi_totlepre fi_stk fi_refer fi_recipname 
         fi_vatcode co_user fi_user2 fi_benname co_benname fi_remark1 
         ra_complete bu_save fi_user buselecom fi_campaign ra_pa bu_exit bu_cov 
         RECT-483 RECT-484 RECT-485 RECT-486 RECT-487 
      WITH FRAME fr_main IN WINDOW wgwimpon.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  DISPLAY fi_drivername1 ra_sex1 fi_hbdri1 fi_occupdriv1 fi_idnodriv1 
          fi_drivername2 ra_sex2 fi_hbdri2 fi_occupdriv2 fi_idnodriv2 
          fi_agedriv1 fi_agedriv2 fi_text1 fi_text2 fi_text3 fi_text4 fi_text5 
          fi_text6 fi_text7 fi_text8 fi_text9 fi_text10 
      WITH FRAME fr_driv IN WINDOW wgwimpon.
  ENABLE fi_drivername1 ra_sex1 fi_hbdri1 fi_occupdriv1 fi_idnodriv1 
         fi_drivername2 ra_sex2 fi_hbdri2 fi_occupdriv2 fi_idnodriv2 fi_text1 
         fi_text2 fi_text3 fi_text4 fi_text5 fi_text6 fi_text7 fi_text8 
         fi_text9 fi_text10 
      WITH FRAME fr_driv IN WINDOW wgwimpon.
  {&OPEN-BROWSERS-IN-QUERY-fr_driv}
  VIEW wgwimpon.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assign wgwimpon 
PROCEDURE proc_assign :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*
fi_notino   =  
    fi_notdat   = TODAY 
    fi_nottim   = TIME
    fi_campaign = 40
        ****
    fi_ins_off  = 100
    fi_comco    = 30
    fi_cmrcode  = 50
    fi_cmrcode2 = 20

        /***/
    ra_car
    ra_cover
    fi_cover1   = 10
    fi_product  = 20
    bu_product
    ra_pree
    ra_comp
    fi_producer = 15
    fi_agent    = 15
    fi_cmrsty   = 2 
    bu_create
    fi_notno70  = 20
    fi_notno72  = 20
    fi_institle = 25
    fi_preinsur = 50
    fi_preinsur2 = 50
    fi_preinsur2 = 13
    fi_birthday
    
    fi_age         = 99
    fi_occup       = 50
    fi_namedrirect = 100
    fi_insadd1no   = 25
    fi_insadd1mu   = 20
    ra_ban
    fi_insadd1build = 50
    fi_insadd1soy   = 50
    fi_insadd1road  = 50
    fi_insadd2tam   = 40
    fi_insadd3amp   = 40
    fi_insadd4cunt  = 40
    fi_insadd5post  = 5
    fi_insadd6tel   = 25
     

    fi_drivername1 = 100  
    ra_sex1        = male 
    fi_hbdri1      = DATE 
    fi_agedriv1    = 99   
    fi_occupdriv1  = 50   
    fi_idnodriv1   = 20   
    fi_drivername2 = 100
    ra_sex2        = male
    fi_hbdri2      = DATE
    fi_agedriv2    = 99
    fi_occupdriv2  = 50
    fi_idnodriv2   = 20

       /*****/
    fi_comdat  = DATE
    fi_expdat  = DATE
    fi_ispno   = 45
    co_brand
    fi_model   = 60
    bu_model 
    fi_year     = 4
    fi_power    = 0
    fi_licence1 = 2
    fi_licence2 = 4
    co_provin
    fi_cha_no   = 35
    fi_eng_no   = 35

        *****
    fi_pack     = 1
    fi_class    = 4 

    fi_garage    = 1
    fi_sumsi     = ->>>,>>>,>>9.99
    fi_gap       = 0
    fi_premium   = 0
    fi_precomp   = 0
    fi_totlepre  = 0
    fi_stk       = 20
    fi_refer     = 35
    fi_recipname = 100
        ****
    fi_vatcode = 15
    co_user
    fi_user2   = 50
    fi_benname = 100
    fi_remark1 = 100
    ra_complete
    bu_save
    bu_new*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_busave wgwimpon 
PROCEDURE proc_busave :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*
DO:
    /*ASSIGN n_build = IF ra_ban = 1 THEN "อาคาร"    +  TRIM(n_build)      /*AddA55-0108*/
                                   ELSE "หมู่บ้าน" +  TRIM(n_build) .    /*AddA55-0108*/*/
    IF fi_notno70 = "" THEN DO:
        MESSAGE "คุณต้องการบันทึกข้อมูลใช่หรือไม่  !!!!" SKIP
                "กรุณาคีย์เลขกรมธรรม์ภาคสมัครใจ(Line70) !!!!" VIEW-AS ALERT-BOX  .  
        APPLY "entry" TO fi_notno70.
        RETURN NO-APPLY.
    END. 
    IF fi_notino = "" THEN DO:
        MESSAGE  "คุณต้องการบันทึกข้อมูลใช่หรือไม่  !!!!" SKIP 
                 "กรุณาคีย์เลขกรมธรรม์ภาคสมัครใจ(Line70) !!!!" VIEW-AS ALERT-BOX  .
        APPLY "entry" TO fi_notno70.
        RETURN NO-APPLY.
    END.
    /*MESSAGE "คุณต้องการบันทึกข้อมูลใช่หรือไม่  !!!!"        
        VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO     /*-CANCEL */    
        TITLE "" UPDATE choice AS LOGICAL.
    CASE choice:  
        WHEN TRUE THEN  /* Yes */ 
            DO: */
            FIND LAST  tlt    WHERE 
                tlt.nor_noti_tlt  = fi_notino    AND
                /*tlt.policy        = fi_notno70   AND*/
                tlt.genusr        = "Phone"      NO-ERROR NO-WAIT .
            IF  AVAIL tlt THEN DO:   /*proc_assign */
                /*CREATE tlt.*/
                ASSIGN 
                    /*1 */   tlt.nor_usr_ins   = trim(INPUT fi_ins_off)
                    /*2 */   tlt.lotno         = trim(INPUT fi_comco) 
                    /*3 */   tlt.nor_noti_ins  = trim(Input fi_cmrcode) 
                    /*4 */   tlt.nor_usr_tlt   = trim(Input fi_cmrcode2)
                    /*5 */   /*A55-0257 .
                             tlt.trndat        = TODAY 
                    /*6 */   tlt.trntime       = fi_nottim 
                    /*7 */   tlt.nor_noti_tlt  = fi_notino                  A55-0257 ....*/
                    /*8 */   tlt.subins        = trim(Input fi_campaign)
                    /*9 */   tlt.safe1         = IF      ra_car  = 1 THEN "เก๋ง" 
                                                 ELSE IF ra_car  = 2 THEN "กระบะ"    
                                                                     ELSE "โดยสาร" 
                    /*10*/   tlt.filler1       = IF      ra_pree = 1 THEN "แถม"
                                                                     ELSE "ไม่แถม"
                    /*11*/   tlt.filler2       = IF      ra_comp = 1 THEN "แถม"
                                                 ELSE IF ra_comp = 2 THEN "ไม่แถม"  
                                                                     ELSE "ไม่เอาพรบ."
                    /*12*/   tlt.safe2         = IF    ra_cover  = 1 THEN "ป้ายแดง" 
                                                                     ELSE "use car" 
                    /*13*/   tlt.safe3         = trim(fi_cover1)
                    /*14     ra_pa     */
                    /*15*/   tlt.stat          = IF ra_pa = 1 THEN "" ELSE trim(fi_product)        /*A55-0073*/
                    /*16*/   tlt.comp_sub      = trim(Input fi_producer)        
                    /*17*/   tlt.recac         = trim(Input fi_agent) 
                    /*18*/   tlt.colorcod      = caps(trim(fi_cmrsty)) 
                    /*19*/   tlt.policy        = caps(trim(fi_notno70))       
                    /*20*/   tlt.comp_pol      = caps(trim(fi_notno72))
                    /*21*/   tlt.ins_name      = trim(INPUT fi_institle )  + " " +    
                    /*22*/                       trim(INPUT fi_preinsur )  + " " +      
                    /*23*/                       trim(Input fi_preinsur2 )  .    
                             /*tlt.ins_addr1     = Input fi_insaddr1*/ /*A55-0073*/
                             /*comment by Kridtiya i..A55-0125....
                             tlt.ins_addr1     = trim((IF n_banno = "" THEN "" ELSE "เลขที่ " + TRIM(n_banno)) + " " +  
                                                         (IF n_muno  = "" THEN "" ELSE "หมู่ "   + TRIM(n_muno))  + " " +  
                                                         (IF n_build = "" THEN "" ELSE TRIM(n_build)) + " " +  
                                                         (IF n_soy   = "" THEN "" ELSE "ซอย"    + TRIM(n_soy))   + " " +  
                                                         (IF n_road  = "" THEN "" ELSE "ถนน"    + TRIM(n_road)))
                             end..comment by Kridtiya i..A55-0125 ...*/
                             /*Kridtiya i. A55-0125*/
                        
                    ASSIGN tlt.ins_addr1     =  (IF ra_ban = 1 THEN  /*ra_ban = 1  */
                                                trim((IF n_banno = "" THEN "" ELSE "เลขที่ " + TRIM(n_banno)) + " " +  
                                                     (IF n_muno  = "" THEN "" ELSE "หมู่ "   + TRIM(n_muno))  + " " +
                                                     (IF n_soy   = "" THEN "" ELSE "ซอย"     + TRIM(n_soy))   + " " +  
                                                     (IF n_road  = "" THEN "" ELSE "ถนน"     + TRIM(n_road))) 
                                                 ELSE IF ra_ban = 2 THEN
                                                trim((IF n_banno = "" THEN "" ELSE "เลขที่ " + TRIM(n_banno)) + " " +  
                                                     (IF n_muno  = "" THEN "" ELSE "หมู่ "   + TRIM(n_muno))  + " " +
                                                     (IF n_build = "" THEN "" ELSE "อาคาร"   + n_build )      + " " +  
                                                     (IF n_soy   = "" THEN "" ELSE "ซอย"     + TRIM(n_soy))   + " " +  
                                                     (IF n_road  = "" THEN "" ELSE "ถนน"     + TRIM(n_road))) 
                                                ELSE      /*ra_ban = 3 */
                                                trim((IF n_banno = "" THEN "" ELSE "เลขที่ " + TRIM(n_banno)) + " " +  
                                                     (IF n_muno  = "" THEN "" ELSE "หมู่ "   + TRIM(n_muno))  + " " +
                                                     (IF n_build = "" THEN "" ELSE "หมู่บ้าน"  + n_build )    + " " +  
                                                     (IF n_soy   = "" THEN "" ELSE "ซอย"     + TRIM(n_soy))   + " " +  
                                                     (IF n_road  = "" THEN "" ELSE "ถนน"     + TRIM(n_road))))
                             /*Kridtiya i. A55-0125*/ /*29*/   
                             tlt.ins_addr2     = trim(Input fi_insadd2tam)     
                    /*30*/   tlt.ins_addr3     = TRIM(input fi_insadd3amp)     
                    /*31*/   tlt.ins_addr4     = TRIM(Input fi_insadd4cunt)     
                    /*32*/   tlt.ins_addr5     = TRIM(Input fi_insadd5post)   
                    /*33*/   tlt.comp_noti_ins = TRIM(Input fi_insadd6tel)
                    /*34*/   tlt.nor_effdat    = INPUT fi_comdat         
                    /*35*/   tlt.expodat       = Input fi_expdat
                    /*36*/   tlt.dri_no2       = trim(INPUT fi_ispno)
                    /*37*/   tlt.brand         = Input co_brand            
                    /*38*/   tlt.model         = trim(Input fi_model)
                    /*39*/   tlt.lince2        = trim(Input fi_year) 
                    /*40*/   tlt.cc_weight     = INPUT fi_power
                    /*41*/   tlt.lince1        = trim(INPUT fi_licence1) + " " +      
                    /*42*/                       trim(INPUT fi_licence2) + " " +      
                    /*43*/                       INPUT co_provin
                    /*44*/   tlt.cha_no        = Input fi_cha_no
                    /*45*/   tlt.eng_no        = INPUT fi_eng_no
                    /*46*/   tlt.lince3        = INPUT fi_pack  +        
                    /*47*/                       trim(INPUT fi_class)         
                    /*48*/   tlt.exp           = trim(INPUT fi_garage)       
                    /*49*/   tlt.nor_coamt     = INPUT fi_sumsi 
                    /*50*/   tlt.dri_name2     = STRING(Input fi_gap )
                    /*51*/   tlt.nor_grprm     = INPUT fi_premium  
                    /*52*/   tlt.comp_coamt    = INPUT fi_precomp  
                    /*53*/   tlt.comp_grprm    = INPUT fi_totlepre
                    /*54*/   tlt.comp_sck      = trim(INPUT fi_stk)
                    /*55*/   tlt.comp_noti_tlt = trim(INPUT fi_refer)         
                    /*56*/   tlt.rec_name      = trim(Input fi_recipname)  
                    /*57*/   tlt.comp_usr_tlt  = trim(INPUT fi_vatcode) 
                    /*58*/   tlt.expousr       = IF co_user = "" THEN fi_user2 
                    /*59*/                                       ELSE co_user
                    /*60*/   tlt.comp_usr_ins  = trim(Input fi_benname)       
                    /*61*/   tlt.OLD_cha       = USERID(LDBNAME(1))  + ":" + trim(Input fi_remark1)        
                    /*62*/   tlt.OLD_eng       = IF ra_complete = 1 THEN "complete"
                                                 ELSE "not complete"
                    /*  */   tlt.genusr        = "Phone"   
                    /*/*  */   tlt.usrid         = USERID(LDBNAME(1))       /*User Load Data */*/
                    /*  */   /*tlt.usrid         = n_User  */                  /*User Load Data */
                    /*  */   tlt.imp           = "IM"                     /*Import Data*/
                    /*  */   tlt.releas        = "No" 
            /*idno    */     tlt.endno         = fi_idno                  
            /*birthday*/     tlt.dat_ins_noti  = fi_birthday       /*date */           
            /*name direct */ tlt.usrsent       = fi_namedrirect                      
            /*age      */    tlt.seqno         = fi_age      /*inte */           
            /*occupn   */    tlt.flag          = fi_occup
                             tlt.dri_name1     = trim(fi_drivername1) + "sex:" + string(ra_sex1)  + "hbd:" + STRING(fi_hbdri1) + "age:" +  string(fi_agedriv1) + "occ:" + trim(fi_occupdriv1) 
                             tlt.dri_no1       = fi_idnodriv1 
                             tlt.enttim        = trim(fi_drivername2) + "sex:" +  string(ra_sex2)  + "hbd:" +  STRING(fi_hbdri2) + "age:" +  string(fi_agedriv2) + "occ:" + trim(fi_occupdriv2) 
                             tlt.expotim       = fi_idnodriv2  .
/*/*idno    */     endno               char              x(8)
  /*birthday*/     dat_ins_noti        date              99/99/9999      ?
  /*name direct */ usrsent             char              x(10)
  /*age      */    seqno               inte              999999          0
  /*occupn   */    flag                char              x
  
  /*driv no 1 */    dri_name1           char              x(30)
  /*driv id no 1 */ dri_no1             char              x(13)
  /*driv no 1 */    enttim              char              x(8)
  /*driv id no 1 */ expotim             char              x(8)
  FIND FIRST   stat.mailtxt_fil  USE-INDEX  mailtxt01  WHERE
   stat.mailtxt_fil.policy  = "DM7055KK001200000001001"      NO-LOCK  NO-ERROR  NO-WAIT.
        IF  AVAIL stat.mailtxt_fil   THEN DO:
                            
                     DISP 
                         stat.mailtxt_fil.policy   FORMAT "x(30)"    SKIP
                         stat.mailtxt_fil.lnumber                    SKIP
                         stat.mailtxt_fil.ltext    FORMAT "x(60)"    SKIP 
                         stat.mailtxt_fil.ltext2       .
               
        END.*/

            END. 
            /*
            ELSE DO:    
                ASSIGN 
                    /*1 */   tlt.nor_usr_ins   = trim(INPUT fi_ins_off)
                    /*2 */   tlt.lotno         = trim(INPUT fi_comco) 
                    /*3 */   tlt.nor_noti_ins  = trim(Input fi_cmrcode) 
                    /*4 */   tlt.nor_usr_tlt   = trim(Input fi_cmrcode2)
                    /*5 */   tlt.trndat        = TODAY
                    /*6 */   tlt.trntime       = fi_nottim 
                    /*/*7 */   tlt.nor_noti_tlt  = fi_notino*/
                    /*8 */   tlt.subins        = trim(Input fi_campaign)
                    /*9 */   tlt.safe1         = IF      ra_car  = 1 THEN "เก๋ง" 
                                                 ELSE IF ra_car  = 2 THEN "กระบะ"    
                                                                     ELSE "โดยสาร" 
                    /*10*/   tlt.filler1       = IF ra_pree = 1 THEN "แถม"
                                                                ELSE "ไม่แถม"
                    /*11*/   tlt.filler2       = IF      ra_comp = 1 THEN "แถม"
                                                 ELSE IF ra_comp = 2 THEN "ไม่แถม"  
                                                                     ELSE "ไม่เอาพรบ."
                    /*12*/   tlt.safe2         = IF    ra_cover  = 1 THEN "ป้ายแดง" 
                                                                     ELSE "use car" 
                    /*13*/   tlt.safe3         = trim(fi_cover1)
                    /*14     ra_pa     */
                    /*15*/   tlt.stat          = IF ra_pa = 1 THEN "" ELSE fi_product        /*A55-0073*/
                    /*16*/   tlt.comp_sub      = trim(Input fi_producer)        
                    /*17*/   tlt.recac         = trim(Input fi_agent) 
                    /*18*/   tlt.colorcod      = caps(trim(Input fi_cmrsty)) 
                    /*/*19*/   tlt.policy        = caps(trim(Input fi_notno70)) */      
                    /*20*/   tlt.comp_pol      = caps(trim(INPUT fi_notno72))
                    /*21*/   tlt.ins_name      = trim(INPUT fi_institle )  + " " +    
                    /*22*/                       trim(INPUT fi_preinsur )  + " " +      
                    /*23*/                       trim(Input fi_preinsur2 )      
                           /*tlt.ins_addr1     = Input fi_insaddr1*/ /*A55-0073*/
                    /*24*/   tlt.ins_addr1     = trim((IF n_banno = "" THEN "" ELSE "เลขที่ " + TRIM(n_banno)) + " " +  
                    /*25*/                            (IF n_muno  = "" THEN "" ELSE "หมู่ "   + TRIM(n_muno))  + " " +  
                    /*26*/                            (IF n_build = "" THEN "" ELSE "อาคาร"  + TRIM(n_build)) + " " +  
                    /*27*/                            (IF n_soy   = "" THEN "" ELSE "ซอย"    + TRIM(n_soy))   + " " +  
                    /*28*/                            (IF n_road  = "" THEN "" ELSE "ถนน"    + TRIM(n_road)))
                    /*29*/   tlt.ins_addr2     = trim(Input fi_insadd2tam)     
                    /*30*/   tlt.ins_addr3     = TRIM(input fi_insadd3amp)     
                    /*31*/   tlt.ins_addr4     = TRIM(Input fi_insadd4cunt)     
                    /*32*/   tlt.ins_addr5     = TRIM(Input fi_insadd5post)   
                    /*33*/   tlt.comp_noti_ins = TRIM(Input fi_insadd6tel)
                    /*34*/   tlt.nor_effdat    = INPUT fi_comdat         
                    /*35*/   tlt.expodat       = Input fi_expdat
                    /*36*/   tlt.dri_no2       = trim(INPUT fi_ispno)
                    /*37*/   tlt.brand         = Input co_brand            
                    /*38*/   tlt.model         = trim(Input fi_model)
                    /*39*/   tlt.lince2        = trim(Input fi_year) 
                    /*40*/   tlt.cc_weight     = INPUT fi_power
                    /*41*/   tlt.lince1        = INPUT fi_licence1 + " " +      
                    /*42*/                       trim(INPUT fi_licence2) + " " +      
                    /*43*/                       INPUT co_provin
                    /*44*/   tlt.cha_no        = Input fi_cha_no
                    /*45*/   tlt.eng_no        = INPUT fi_eng_no
                    /*46*/   tlt.lince3        = INPUT fi_pack  +        
                    /*47*/                       trim(INPUT fi_class)         
                    /*48*/   tlt.exp           = trim(INPUT fi_garage)       
                    /*49*/   tlt.nor_coamt     = INPUT fi_sumsi 
                    /*50*/   tlt.dri_name2     = STRING(Input fi_gap )
                    /*51*/   tlt.nor_grprm     = INPUT fi_premium  
                    /*52*/   tlt.comp_coamt    = INPUT fi_precomp  
                    /*53*/   tlt.comp_grprm    = INPUT fi_totlepre
                    /*54*/   tlt.comp_sck      = trim(INPUT fi_stk)
                    /*55*/   tlt.comp_noti_tlt = trim(INPUT fi_refer)         
                    /*56*/   tlt.rec_name      = trim(Input fi_recipname)  
                    /*57*/   tlt.comp_usr_tlt  = trim(INPUT fi_vatcode) 
                    /*58*/   tlt.expousr       = IF co_user = "" THEN fi_user2 
                    /*59*/                                       ELSE co_user
                    /*60*/   tlt.comp_usr_ins  = trim(Input fi_benname)       
                    /*61*/   tlt.OLD_cha       = USERID(LDBNAME(1))  + ":" + trim(Input fi_remark1)        
                    /*62*/   tlt.OLD_eng       = IF ra_complete = 1 THEN "complete"
                                                 ELSE "not complete"
                    /*  */   tlt.genusr        = "Phone"   
                    /*  */   tlt.usrid         = USERID(LDBNAME(1))       /*User Load Data */
                    /*  */   tlt.imp           = "IM"                     /*Import Data*/
                    /*  */   tlt.releas        = "No".
            END.*/
            /*ELSE MESSAGE "Not SAVE Not found tlt data ..." VIEW-AS ALERT-BOX.
            RELEASE brstat.tlt.
            MESSAGE "SAVE COMPLETE..." VIEW-AS ALERT-BOX.
            APPLY "entry" TO fi_remark1.
            RETURN NO-APPLY.     
        END. 
        WHEN FALSE THEN      /* No */          
            DO:   
            APPLY "entry" TO fi_remark1.
            RETURN NO-APPLY.
        END.
    END CASE.*/
    MESSAGE "SAVE COMPLETE..." VIEW-AS ALERT-BOX.
END.
*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_createnoti wgwimpon 
PROCEDURE proc_createnoti :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*fi_notino   = "PHONE" + STRING(TODAY,"99/99/9999") + string(TIME,"HH:MM:SS") *//*
FIND LAST  tlt  WHERE 
    tlt.nor_noti_tlt  = fi_notino  AND
    tlt.genusr        = "Phone"    NO-ERROR NO-WAIT .
IF NOT AVAIL tlt THEN DO: 
    CREATE tlt.
    ASSIGN tlt.nor_noti_tlt  = fi_notino
        tlt.genusr        = "Phone"  .
END.
ELSE ASSIGN fi_notino   = "PHONE" + STRING(TODAY,"99/99/9999") + string(TIME,"HH:MM:SS") + "_1".
FIND LAST  tlt  WHERE 
    tlt.nor_noti_tlt  = fi_notino  AND
    tlt.genusr        = "Phone"    NO-ERROR NO-WAIT .
IF NOT AVAIL tlt THEN DO: 
    CREATE tlt.
    ASSIGN tlt.nor_noti_tlt  = fi_notino
           tlt.genusr        = "Phone"  .
END.*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_initdata wgwimpon 
PROCEDURE proc_initdata :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN 
    vAcProc_fil    = ""  
    vAcProc_fil1   = ""
    vAcProc_fil2   = ""
    vAcProc_fil3   = ""
    vAcProc_fil    = vAcProc_fil + " " + "," 
                   + "กรุงเทพมหานคร" + "," + "กระบี่"        + "," + "กาญจนบุรี" + "," + "กาฬสินธุ์"  + ","
                   + "กำแพงเพชร"     + "," + "ขอนแก่น"       + "," + "จันทบุรี"  + "," + "ฉะเชิงเทรา" + ","
                   + "ชลบุรี"        + "," + "ชัยนาท"        + "," + "ชัยภูมิ"   + "," + "ชุมพร"      + ","
                   + "เชียงราย"      + "," + "เชียงใหม่"     + "," + "ตรัง"      + "," + "ตราด"       + "," 
                   + "ตาก"           + "," + "นครนายก"       + "," + "นครปฐม"    + "," + "นครพนม"     + ","
                   + "นครราชสีมา"    + "," + "นครศรีธรรมราช" + "," + "นครสวรรค์" + "," + "นนทบุรี"    + ","
                   + "นราธวาส"       + "," + "น่าน"          + "," + "บึงกาฬ"    + "," + "บุรีรัมย์"  + ","          /* บก */
                   + "เบตง"          + "," + "ปทุมธานี"      + "," + "ประจวบคีรีขันธ์" + "," + "ปราจีนบุรี"   + ","  /* บต */
                   + "ปัตตานี"       + "," + "พะเยา"         + "," + "พังงา"     + "," + "พัทลุง"     + ","
                   + "พิจิตร"        + "," + "พิษณุโลก"      + "," + "เพชรบุรี"  + "," + "เพชรบูรณ์"  + "," 
                   + "แพร่"          + "," + "ภูเก็ต"        + "," + "มหาสารคาม" + "," + "มุกดาหาร"   + "," 
                   + "แม่ฮ่องสอน"    + "," + "ยโสธร"         + "," + "ยะลา"      + "," + "ร้อยเอ็ด"   + ","
                   + "ระนอง"         + "," + "ระยอง"         + "," + "ราชบุรี"   + "," + "ลพบุรี"     + "," 
                   + "ลำปาง"         + "," + "ลำพูน"         + "," + "เลย"       + "," + "ศรีสะเกษ"   + "," 
                   + "สกลนคร"        + "," + "สงขลา"         + "," + "สตูล"      + "," + "สระแก้ว"    + ","
                   + "สระบุรี"       + "," + "สิงห์บุรี"     + "," + "สุโขทัย"   + "," + "สุพรรณบุรี" + "," 
                   + "สุมทรปราการ"   + "," + "สุมทรสงคราม"   + "," + "สุมทรสาคร" + "," + "สุราษฎร์ธานี" + "," 
                   + "สุรินทร์"      + "," + "หนองคาย"       + "," + "หนองบัวลำพู"  + "," + "อยุธยา"  + ","
                   + "อ่างทอง"       + "," + "อำนาจเจริญ"    + "," + "อุดรธานี"  + "," + "อุตรดิตถ์"  + "," 
                   + "อุทัยธานี"     + "," + "อุบลราชธานี"   + "," 
    vAcProc_fil1 =  vAcProc_fil1   + " " + "," + "ALFA ROMEO"   + "," + "ASTON MARTIN" + "," + "AUDI"      + "," 
                   + "BENTLEY"  + "," + "BMW"         + "," + "CHERY"        + "," + "CHEVROLET" + "," 
                   + "CHRYSLER" + "," + "CIOEN"       + "," + "DAEWOO"       + "," + "DAIHATSU"  + "," 
                   + "DFM"      + "," + "FERRARI"     + "," + "FIAT"         + "," + "FORD"      + "," 
                   + "FOTON"    + "," + "HONDA"       + "," + "HOLDEN"       + "," + "HUMMER"    + "," 
                   + "HYUNDAI"  + "," + "ISUZU"       + "," + "JAGUAR"       + "," + "JEEP"      + "," 
                   + "KIA"      + "," + "LAMBORGHINI" + "," + "LAND ROVER"   + "," + "LEXUS"     + "," 
                   + "LOTUS"    + "," + "MASERATI"    + "," + "MAZDA"        + "," + "MERCEDES-BENZ"   + ","
                   + "MINI"     + "," + "MITSUOKA"    + "," + "MITSUBISHI"   + "," + "NAZA"      + "," 
                   + "NISSAN"   + "," + "OPEL"        + "," + "PEUGEOT"      + "," + "POLARSUN"  + "," 
                   + "PORSCHE"  + "," + "PROTON"      + "," + "RENAULT"      + "," + "ROLLS-ROYCE" + "," 
                   + "ROVER"    + "," + "SAAB"        + "," + "SEAT"         + "," + "SKODA"     + "," 
                   + "SMART"    + "," + "SPYKER"      + "," + "SSANGYONG"    + "," + "SUBARU"    + "," 
                   + "SUZUKI"   + "," + "TATA"        + "," + "TR"           + "," + "TOYOTA"    + "," 
                   + "VOLKSWAGEN" + "," + "VOLVO"    + "," 
    vAcProc_fil2   = vAcProc_fil2  + " " + ","  + "สุภัทรา  เอกศิลป์"    + ","  
                   + "สุดารัตน์  จำนองกาญจนะ"    + "," + "ปาณรภา ปัญญาทรง"          + ","
                   + "กาญจนา  จิตรมา"            + "," + "บุปผารัตน์  อาราเม"       + "," + "ดุสิตา วังทะพันธ์"   + "," 
                   + "วุฒิชัย  หวังโพล้ง"        + "," + "นันทิยา  เจริญจิตรตระกูล" + "," + "ฟาริด หมัดพิทักษ์"   + ","
                   + "ธนียา  นาคบุตร"            + "," + "หนึ่งนุช  สว่างวิวัฒน์"   + "," + "หนึ่งฤทัย แสงเรือง"  + ","  
                   + "ชิดพงษ์  ศรีวัฒนานุกุลกิจ" + "," + "สุนิสา ชาวบ้านกร่าง"      + "," + "กุลธิดา รอดสุขเจริญ" + "," 
                   + "สุนารี คุชิตา"             + "," + "จรรยพร  นิลรักษา"         + "," + "พรปวีณ์  เชียงแรง"   + "," 
                   + "ณัฐกฤตา เมืองฤทธิ์"        + ","  +  "ตรีนุช มโนสุทธิสาร"     + "," + " " + ","  
    fi_comco    = " "  
    fi_institle = "คุณ"
    nv_benname  = ""
    fi_comdat   = TODAY
    fi_expdat   = TODAY
    fi_notdat   = TODAY 
    fi_nottim   = STRING(TIME,"HH:MM:SS")
    fi_campaign = "C54/00015"
    ra_cover    = 1
    /*ra_cover2   = 1*/
    fi_cover1   = "1"
    ra_car      = 1
    ra_pree     = 1
    ra_comp     = 1
    ra_complete = 1
    fi_pack     = "G"
    fi_class    = "110" 
    vAcProc_fil3   = vAcProc_fil3  + " " .
FOR EACH company WHERE company.NAME = "phone" NO-LOCK .
    /*DISP (company.NAME + " " + company.NAME2 ) FORMAT "x(60)".*/
    ASSIGN vAcProc_fil3   = vAcProc_fil3  + " " + "," + TRIM(company.NAME2).
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_initdata2 wgwimpon 
PROCEDURE proc_initdata2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN 
    fi_comco    = " "
    fi_cmrsty   = "M"
    n_brsty     = "M"
    fi_institle = "คุณ"
    fi_comdat   = TODAY
    fi_expdat   = TODAY
    fi_notdat   = TODAY 
    fi_nottim   = STRING(TIME,"HH:MM:SS")
    fi_notino   = "PHONE" + STRING(TODAY,"99/99/9999") + string(TIME,"HH:MM:SS") 
    fi_campaign = "C54/00015"
    ra_cover    = 1
    fi_cover1   = "1"
    ra_pa       = 1  
    fi_product  = "PA1"
    ra_car      = 1
    ra_pree     = 1
    ra_comp     = 1
    ra_complete = 1
    fi_notno70  = ""
    fi_notno72  = ""
    fi_pack     = "G"
    fi_class    = "110"
    nv_check70  = "no"
    nv_check72  = "no"
    fi_ins_off  = ""
    fi_cmrcode  = ""
    fi_cmrcode2  = ""
    fi_producer = ""
    fi_agent    = ""
    fi_preinsur  = ""     
    fi_preinsur2 = "" 
    n_banno = ""
    n_muno  = ""  
    n_build = ""  
    n_soy   = ""  
    n_road  = "" 
    fi_insadd1no     = ""  
    fi_insadd1mu     = ""  
    fi_insadd1build  = ""  
    fi_insadd1soy    = ""  
    fi_insadd1road   = ""  
    fi_insadd2tam    = ""    
    fi_insadd3amp    = ""    
    fi_insadd4cunt   = ""    
    fi_insadd5post   = ""  
    fi_insadd6tel    = ""  
    fi_ispno         = ""
    co_brand  = ""     
    fi_model  = ""
    fi_year   = ""
    fi_power  = 0
    fi_licence1 = ""  
    fi_licence2 = ""
    co_provin = ""
    fi_cha_no = ""
    fi_eng_no = ""
    fi_garage = ""     
    fi_sumsi  = 0
    fi_gap    = 0
    fi_premium  = 0
    fi_precomp  = 0
    fi_totlepre = 0
    fi_stk      = ""           
    fi_refer        = ""       
    fi_recipname    = ""
    fi_vatcode      = ""
    co_user         = "" 
    /*fi_benname  = ""*/  
    fi_remark1      = "" 
    fi_user2        = "" .
  /*RUN proc_createnoti.*/
  DISP  fi_comco        fi_cmrsty       fi_institle     fi_comdat       fi_expdat       fi_notdat 
        fi_nottim       fi_notino       fi_campaign     ra_cover        fi_cover1       ra_pa   
        fi_product      ra_car          ra_pree         ra_comp         ra_complete     fi_notno70 
        fi_notno72      fi_pack         fi_class        fi_ins_off      fi_cmrcode      fi_cmrcode2
        fi_producer     fi_agent        fi_preinsur     fi_preinsur2    fi_insadd1no    fi_insadd1mu    
        fi_insadd1build fi_insadd1soy   fi_insadd1road  fi_insadd2tam   fi_insadd3amp   fi_insadd4cunt  
        fi_insadd5post  fi_insadd6tel     fi_ispno        co_brand        fi_model      fi_year         
        fi_power        fi_licence1     fi_licence2     co_provin       fi_cha_no       fi_eng_no       
        fi_garage       fi_sumsi        fi_gap          fi_premium      fi_precomp      fi_totlepre     
        fi_stk          fi_refer        fi_recipname    fi_vatcode      co_user         /*fi_benname  */  
        fi_remark1      fi_user2    With frame   fr_main.
  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_save70 wgwimpon 
PROCEDURE proc_save70 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*//*
FIND LAST  tlt    WHERE 
    tlt.nor_noti_tlt  = fi_notino  AND
    tlt.genusr        = "Phone"    NO-ERROR NO-WAIT .
IF AVAIL tlt THEN 
    ASSIGN 
        tlt.policy        =   fi_notno70       
        /*tlt.comp_pol      = INPUT fi_notno72*/ .*/

            
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_save72 wgwimpon 
PROCEDURE proc_save72 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*//*
FIND LAST  tlt    WHERE 
    tlt.nor_noti_tlt  = fi_notino  AND
    tlt.genusr        = "Phone"    NO-ERROR NO-WAIT .
IF AVAIL tlt THEN 
    ASSIGN 
        /*tlt.policy        =   fi_notno70 */      
        tlt.comp_pol      =  fi_notno72 .
*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

