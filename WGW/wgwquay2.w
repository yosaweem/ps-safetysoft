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
/*++++++++++++++++++++++++++++++++++++++++++++++
program id       :  wuwquay2.w 
program name     :  Update data Aycal to create  new policy  Add in table  tlt  
                    Quey & Update data before Gen.
Create  by       :  Kridtiya i. A56-0241  On   02/08/2013
Database Connect :  gw_stat ld brstat , gw_safe ld sic_bran ,sic_test ld sicuw sicsyac :not connect stat

+++++++++++++++++++++++++++++++++++++++++++++++*/
Modify By        : Porntiwa p.  A58-0361   Date: 25/09/2015
                 : ปรับการแสดงค่า Cancel
Modify By    : Jiraphon P. A59-0451 03/10/2016
             : เพิ่มการแสดงค่าลงช่องข้อมูล 8.3 ไฟแนนซ์,Producer code,Agent code 
Modify By    : Sarinya C. A61-0349 23/07/2018
             : แก้ไขในหน้ารายละเอียด ข้อมูลที่ status Release เป็น Yes ให้สามารถแก้ไขหรือ อัพเดทข้อมูลได้
               มีการเก็บ userid และวันที่ทำการ update ข้อมูลเพิ่ม
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

DEF  Input  parameter  nv_recidtlt  as  recid  . 
DEF  VAR    nv_index  as int  init 0.
DEF  NEW   SHARED  VAR gComp   AS CHAR.
DEF  NEW   SHARED  VAR n_agent1    LIKE sicsyac.xmm600.acno. 
DEF  NEW   SHARED  VAR n_agent2    LIKE sicsyac.xmm600.acno. 
/* Parameters Definitions ---                                           */
DEF  VAR   n_name     As   Char    Format    "x(35)".
DEF  VAR   n_nO1      As   Char    Format    "x(35)".
DEF  VAR   n_nO2      As   Char    Format    "x(35)".
DEF  VAR   n_nO3      As   Char    Format    "x(35)".
DEF  VAR   n_text     AS   CHAR    FORMAT    "x(35)".
DEF  VAR   n_chkname  As   Char    Format    "x(35)".
DEFINE VAR vAcProc_fil      AS CHAR.
DEFINE  WORKFILE wdetail    NO-UNDO
/*1*/  FIELD provi_no       AS CHAR      FORMAT "x(5)"
/*2*/  FIELD provi_name     AS CHARACTER FORMAT "X(30)"   INITIAL "".
DEF VAR n_poltyp  AS CHAR INIT "".
DEF VAR nv_brnpol AS CHAR INIT "".
DEF VAR n_undyr2  AS CHAR INIT "".
DEF VAR n_brsty   AS CHAR INIT "".
DEF VAR n_br      AS CHAR INIT "" FORMAT "x(5)" .
DEFINE VAR nv_check    AS   CHARACTER  INITIAL ""  NO-UNDO.
DEFINE VAR nv_check70  AS   CHARACTER  INITIAL ""  NO-UNDO.
DEFINE VAR nv_check72  AS   CHARACTER  INITIAL ""  NO-UNDO.
DEF VAR n_banno  AS  CHAR   INIT "" FORMAT "x(20)".
DEF VAR n_muno   AS  CHAR   INIT "" FORMAT "x(20)".
DEF VAR n_build  AS  CHAR   INIT "" FORMAT "x(50)".
DEF VAR n_road   AS  CHAR   INIT "" FORMAT "x(40)".
DEF VAR n_soy    AS  CHAR   INIT "" FORMAT "x(40)".
DEF VAR n_addr11 AS  CHAR   INIT "" FORMAT "x(200)".
/**/
DEF VAR n_InspectPhoneNo AS CHAR INIT "".   /*A61-0349*/
DEF VAR n_InspectName    AS CHAR INIT "".   /*A61-0349*/
/*A61-0349*/
Def  Var chNotesSession  As Com-Handle.
Def  Var chNotesDataBase As Com-Handle.
Def  Var chDocument      As Com-Handle.
Def  Var chNotesView     As Com-Handle .
Def  Var chNavView       As Com-Handle .
Def  Var chViewEntry     As Com-Handle .
Def  Var chItem          As Com-Handle .
Def  Var chData          As Com-Handle .
Def  Var nv_server       As Char.           
Def  Var nv_tmp          As char.           
DEF  VAR nv_detailisp    AS CHAR.
/*A61-0349*/
/**/

DEF VAR nv_aaa    AS CHAR.
DEF VAR nv_bbb    AS CHAR.
DEF VAR nv_ccc    AS CHAR.
DEF VAR nv_ddd    AS CHAR.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS bu_upins fi_detailisp fi_insp fi_notino ~
fi_notdat fi_ins_off fi_comco fi_prepol fi_notno70 fi_notno72 fi_cmrsty ~
fi_contact fi_producer fi_agent fi_cover1 fi_renew fi_institle fi_preinsur ~
fi_preinsur2 fi_idno fi_insadd1no fi_insadd1soy fi_insadd1road ~
fi_insadd2tam fi_insadd3amp fi_insadd4cunt fi_insadd5post fi_insadd6tel ~
fi_InspectName fi_comdat fi_expdat fi_brand fi_model bu_model fi_year ~
fi_power fi_licence1 fi_licence2 fi_provin fi_cha_no fi_eng_no fi_sumsi ~
fi_gap fi_premium fi_precomp fi_deduct fi_companycomp fi_stk ra_drivno ~
fi_comdat72 fi_expdat72 fi_pack fi_class fi_garage fi_access fi_editaddr ~
fi_recipname fi_vatcode ra_complete fi_benname fi_remark1 fi_remark2 ~
fi_remark3 bu_save bu_exit fi_inspno RECT-488 RECT-490 RECT-491 RECT-492 ~
RECT-493 RECT-661 
&Scoped-Define DISPLAYED-OBJECTS fi_detailisp fi_insp fi_company fi_notino ~
fi_notdat fi_ins_off fi_comco fi_prepol fi_notno70 fi_notno72 fi_cmrsty ~
fi_contact fi_producer fi_agent fi_cover1 fi_renew fi_institle fi_preinsur ~
fi_preinsur2 fi_idno fi_insadd1no fi_insadd1soy fi_insadd1road ~
fi_insadd2tam fi_insadd3amp fi_insadd4cunt fi_insadd5post fi_insadd6tel ~
fi_InspectName fi_comdat fi_expdat fi_brand fi_model fi_year fi_power ~
fi_licence1 fi_licence2 fi_provin fi_cha_no fi_eng_no fi_sumsi fi_gap ~
fi_premium fi_precomp fi_deduct fi_companycomp fi_stk ra_drivno fi_comdat72 ~
fi_expdat72 fi_pack fi_class fi_garage fi_access fi_editaddr fi_recipname ~
fi_vatcode fi_userid ra_complete fi_benname fi_userby fi_Trndat fi_remark1 ~
fi_remark2 fi_remark3 fi_inspno 

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
     SIZE 7.5 BY 1.33
     FONT 6.

DEFINE BUTTON bu_model 
     IMAGE-UP FILE "I:/Safety/WALP10/WIMAGE/next.bmp":U
     LABEL "" 
     SIZE 3.5 BY .95.

DEFINE BUTTON bu_save 
     LABEL "Save" 
     SIZE 7.5 BY 1.33
     FONT 6.

DEFINE BUTTON bu_upins 
     LABEL "Chech ISP" 
     SIZE 12.5 BY .91
     FONT 6.

DEFINE VARIABLE fi_access AS CHARACTER FORMAT "X(150)":U 
     VIEW-AS FILL-IN 
     SIZE 50 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_agent AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 12 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_benname AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 60 BY .95
     BGCOLOR 15 FGCOLOR 6  NO-UNDO.

DEFINE VARIABLE fi_brand AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 18 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_cha_no AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 22 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_class AS CHARACTER FORMAT "X(5)":U 
     VIEW-AS FILL-IN 
     SIZE 5.5 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_cmrsty AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 5 BY .95
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_comco AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 11 BY 1
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_comdat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_comdat72 AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_company AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 25 BY 1
     BGCOLOR 2 FGCOLOR 7 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_companycomp AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 11 BY .95
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_contact AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 12.5 BY .95
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_cover1 AS CHARACTER FORMAT "X(1)":U 
     VIEW-AS FILL-IN 
     SIZE 5 BY .95
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_deduct AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 12 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_detailisp AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 17.5 BY .91
     BGCOLOR 8  NO-UNDO.

DEFINE VARIABLE fi_editaddr AS CHARACTER FORMAT "X(150)":U 
     VIEW-AS FILL-IN 
     SIZE 60 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_eng_no AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 24 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_expdat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_expdat72 AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_gap AS DECIMAL FORMAT "->,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 13.5 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_garage AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 9 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_idno AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 20 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_insadd1no AS CHARACTER FORMAT "X(60)":U 
     VIEW-AS FILL-IN 
     SIZE 58 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_insadd1road AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 25 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_insadd1soy AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 20 BY .95
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

DEFINE VARIABLE fi_insp AS CHARACTER FORMAT "X(3)":U 
     VIEW-AS FILL-IN 
     SIZE 9.33 BY .95
     BGCOLOR 8  NO-UNDO.

DEFINE VARIABLE fi_InspectName AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 23 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_inspno AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 17.5 BY .91
     BGCOLOR 15 FGCOLOR 4  NO-UNDO.

DEFINE VARIABLE fi_institle AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_ins_off AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 20 BY 1
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

DEFINE VARIABLE fi_notdat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 8 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_notino AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1
     BGCOLOR 8 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_notno70 AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 15.83 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_notno72 AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 14.5 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_pack AS CHARACTER FORMAT "X(1)":U 
     VIEW-AS FILL-IN 
     SIZE 3.5 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_power AS DECIMAL FORMAT ">>,>>9.99":U INITIAL ? 
     VIEW-AS FILL-IN 
     SIZE 11 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_precomp AS DECIMAL FORMAT "->>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 12 BY .95
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

DEFINE VARIABLE fi_prepol AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 17 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_producer AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 12 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_provin AS CHARACTER FORMAT "X(35)":U 
     VIEW-AS FILL-IN 
     SIZE 23 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_recipname AS CHARACTER FORMAT "X(100)":U INITIAL ? 
     VIEW-AS FILL-IN 
     SIZE 33 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_remark1 AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 83.83 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_remark2 AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 91.83 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_remark3 AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 91.83 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_renew AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 5 BY .95
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_stk AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 20 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_sumsi AS DECIMAL FORMAT "->>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 16 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_Trndat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 12.67 BY 1
     BGCOLOR 19 FGCOLOR 4  NO-UNDO.

DEFINE VARIABLE fi_userby AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 7.5 BY 1
     BGCOLOR 15 FGCOLOR 4  NO-UNDO.

DEFINE VARIABLE fi_userid AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 7.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_vatcode AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_year AS CHARACTER FORMAT "X(5)":U INITIAL "0" 
     VIEW-AS FILL-IN 
     SIZE 8 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE ra_complete AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "Complete", 1,
"Not Complete", 2
     SIZE 28.5 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE ra_drivno AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "ระบุผู้ขับขี่", 1,
"ไม่ระบุผู้ขับขี่", 2
     SIZE 30 BY 1
     FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-488
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132.5 BY 23.81
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-490
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 9.5 BY 2
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

DEFINE RECTANGLE RECT-661
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 19.83 BY 3.19
     BGCOLOR 33 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     bu_upins AT ROW 15.67 COL 116.5 WIDGET-ID 28
     fi_detailisp AT ROW 13.67 COL 111.83 COLON-ALIGNED NO-LABEL WIDGET-ID 24
     fi_insp AT ROW 14.57 COL 100.67 COLON-ALIGNED NO-LABEL WIDGET-ID 22
     fi_company AT ROW 1.19 COL 104 COLON-ALIGNED NO-LABEL
     fi_notino AT ROW 2.48 COL 29.17 COLON-ALIGNED NO-LABEL
     fi_notdat AT ROW 2.48 COL 60.17 COLON-ALIGNED NO-LABEL
     fi_ins_off AT ROW 2.48 COL 87 COLON-ALIGNED NO-LABEL
     fi_comco AT ROW 2.48 COL 118 COLON-ALIGNED NO-LABEL
     fi_prepol AT ROW 3.62 COL 17.67 COLON-ALIGNED NO-LABEL
     fi_notno70 AT ROW 3.62 COL 48.67 COLON-ALIGNED NO-LABEL
     fi_notno72 AT ROW 3.62 COL 76.5 COLON-ALIGNED NO-LABEL
     fi_cmrsty AT ROW 3.62 COL 99.83 COLON-ALIGNED NO-LABEL
     fi_contact AT ROW 3.62 COL 116 COLON-ALIGNED NO-LABEL
     fi_producer AT ROW 4.71 COL 18 COLON-ALIGNED NO-LABEL
     fi_agent AT ROW 4.71 COL 39.67 COLON-ALIGNED NO-LABEL
     fi_cover1 AT ROW 4.71 COL 71.17 COLON-ALIGNED NO-LABEL
     fi_renew AT ROW 4.71 COL 88 COLON-ALIGNED NO-LABEL
     fi_institle AT ROW 6.91 COL 17.67 COLON-ALIGNED NO-LABEL
     fi_preinsur AT ROW 6.91 COL 37.33 COLON-ALIGNED NO-LABEL
     fi_preinsur2 AT ROW 6.91 COL 75.17 COLON-ALIGNED NO-LABEL
     fi_idno AT ROW 6.91 COL 110.33 COLON-ALIGNED NO-LABEL
     fi_insadd1no AT ROW 8 COL 17.67 COLON-ALIGNED NO-LABEL
     fi_insadd1soy AT ROW 8 COL 80.5 COLON-ALIGNED NO-LABEL
     fi_insadd1road AT ROW 8 COL 105.33 COLON-ALIGNED NO-LABEL
     fi_insadd2tam AT ROW 9.1 COL 17.67 COLON-ALIGNED NO-LABEL
     fi_insadd3amp AT ROW 9.1 COL 47 COLON-ALIGNED NO-LABEL
     fi_insadd4cunt AT ROW 9.1 COL 73 COLON-ALIGNED NO-LABEL
     fi_insadd5post AT ROW 9.1 COL 96.67 COLON-ALIGNED NO-LABEL
     fi_insadd6tel AT ROW 9.1 COL 114.33 COLON-ALIGNED NO-LABEL
     fi_InspectName AT ROW 10.19 COL 107.33 COLON-ALIGNED NO-LABEL WIDGET-ID 4
     fi_comdat AT ROW 10.33 COL 34.67 COLON-ALIGNED NO-LABEL
     fi_expdat AT ROW 10.33 COL 72.33 COLON-ALIGNED NO-LABEL
     fi_brand AT ROW 11.38 COL 17.67 COLON-ALIGNED NO-LABEL
     fi_model AT ROW 11.38 COL 44.83 COLON-ALIGNED NO-LABEL
     bu_model AT ROW 11.38 COL 89.67
     fi_year AT ROW 11.38 COL 98.67 COLON-ALIGNED NO-LABEL
     fi_power AT ROW 11.38 COL 118 COLON-ALIGNED NO-LABEL
     fi_licence1 AT ROW 12.48 COL 17.67 COLON-ALIGNED NO-LABEL
     fi_licence2 AT ROW 12.48 COL 24.67 COLON-ALIGNED NO-LABEL
     fi_provin AT ROW 12.48 COL 31.5 COLON-ALIGNED NO-LABEL DISABLE-AUTO-ZAP 
     fi_cha_no AT ROW 12.48 COL 68.83 COLON-ALIGNED NO-LABEL
     fi_eng_no AT ROW 12.48 COL 105.83 COLON-ALIGNED NO-LABEL
     fi_sumsi AT ROW 13.52 COL 17.5 COLON-ALIGNED NO-LABEL
     fi_gap AT ROW 13.52 COL 42.67 COLON-ALIGNED NO-LABEL
     fi_premium AT ROW 13.52 COL 73 COLON-ALIGNED NO-LABEL
     fi_precomp AT ROW 13.52 COL 98 COLON-ALIGNED NO-LABEL
     fi_deduct AT ROW 14.57 COL 17.5 COLON-ALIGNED NO-LABEL
     fi_companycomp AT ROW 14.57 COL 45.17 COLON-ALIGNED NO-LABEL
     fi_stk AT ROW 14.57 COL 65.5 COLON-ALIGNED NO-LABEL
     ra_drivno AT ROW 15.67 COL 2 NO-LABEL
     fi_comdat72 AT ROW 15.67 COL 47 COLON-ALIGNED NO-LABEL
     fi_expdat72 AT ROW 15.67 COL 85.33 COLON-ALIGNED NO-LABEL
     fi_pack AT ROW 16.81 COL 17.67 COLON-ALIGNED NO-LABEL
     fi_class AT ROW 16.81 COL 28.67 COLON-ALIGNED NO-LABEL
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 24
         BGCOLOR 3 FGCOLOR 1 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     fi_garage AT ROW 16.81 COL 43.5 COLON-ALIGNED NO-LABEL
     fi_access AT ROW 16.81 COL 75.17 COLON-ALIGNED NO-LABEL
     fi_editaddr AT ROW 17.91 COL 17.67 COLON-ALIGNED NO-LABEL
     fi_recipname AT ROW 19 COL 17.67 COLON-ALIGNED NO-LABEL
     fi_vatcode AT ROW 19 COL 62.67 COLON-ALIGNED NO-LABEL
     fi_userid AT ROW 19.33 COL 122 COLON-ALIGNED NO-LABEL
     ra_complete AT ROW 19.38 COL 82.17 NO-LABEL
     fi_benname AT ROW 20.1 COL 17.67 COLON-ALIGNED NO-LABEL
     fi_userby AT ROW 21.05 COL 110.83 COLON-ALIGNED NO-LABEL WIDGET-ID 8
     fi_Trndat AT ROW 21.05 COL 118.33 COLON-ALIGNED NO-LABEL WIDGET-ID 12
     fi_remark1 AT ROW 21.14 COL 17.67 COLON-ALIGNED NO-LABEL
     fi_remark2 AT ROW 22.19 COL 17.67 COLON-ALIGNED NO-LABEL WIDGET-ID 14
     fi_remark3 AT ROW 23.24 COL 17.67 COLON-ALIGNED NO-LABEL WIDGET-ID 18
     bu_save AT ROW 22.57 COL 113.5
     bu_exit AT ROW 22.62 COL 124
     fi_inspno AT ROW 14.67 COL 111.83 COLON-ALIGNED NO-LABEL WIDGET-ID 26
     "นามสกุล :":35 VIEW-AS TEXT
          SIZE 9 BY .95 AT ROW 6.91 COL 67.67
          BGCOLOR 18 FGCOLOR 2 FONT 6
     "             ยี่ห้อรถ  :":30 VIEW-AS TEXT
          SIZE 17 BY .95 AT ROW 11.38 COL 2
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "จังหวัด:":30 VIEW-AS TEXT
          SIZE 7 BY .95 AT ROW 9.1 COL 67.5
          BGCOLOR 18 FGCOLOR 2 FONT 6
     "Branch:":35 VIEW-AS TEXT
          SIZE 7.5 BY .95 AT ROW 3.62 COL 93.67
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "         แก้ไขที่อยู่ :":30 VIEW-AS TEXT
          SIZE 17 BY .95 AT ROW 17.91 COL 2
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "ประเภทความคุ้มครอง" VIEW-AS TEXT
          SIZE 18.5 BY .95 AT ROW 4.71 COL 54.17
          BGCOLOR 5 FGCOLOR 7 FONT 6
     "  Vatcode :":30 VIEW-AS TEXT
          SIZE 11 BY .95 AT ROW 19 COL 53.17
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "การซ่อม:":35 VIEW-AS TEXT
          SIZE 8.5 BY .95 AT ROW 16.81 COL 36.5
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "Class :":35 VIEW-AS TEXT
          SIZE 6.5 BY .95 AT ROW 16.81 COL 23.67
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "ซอย":30 VIEW-AS TEXT
          SIZE 4 BY .95 AT ROW 8 COL 78
          BGCOLOR 18 FGCOLOR 2 FONT 6
     "          Package :":35 VIEW-AS TEXT
          SIZE 17 BY .95 AT ROW 16.81 COL 2
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "                 คำนำ :":35 VIEW-AS TEXT
          SIZE 17 BY .95 AT ROW 6.91 COL 2
          BGCOLOR 18 FGCOLOR 2 FONT 6
     "           Deduct :":35 VIEW-AS TEXT
          SIZE 17 BY .95 AT ROW 14.57 COL 2
          BGCOLOR 18 FGCOLOR 0 FONT 6
     " Policy 70 :":35 VIEW-AS TEXT
          SIZE 11 BY .95 AT ROW 3.62 COL 67
          BGCOLOR 8 FGCOLOR 0 FONT 6
     "รหัสบริษัท พรบ:":30 VIEW-AS TEXT
          SIZE 14.5 BY .95 AT ROW 14.57 COL 32
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "                เลขที่  :":30 VIEW-AS TEXT
          SIZE 17 BY .95 AT ROW 8 COL 2
          BGCOLOR 18 FGCOLOR 2 FONT 6
     "ปีประกัน :" VIEW-AS TEXT
          SIZE 10 BY .95 AT ROW 4.71 COL 79.17
          BGCOLOR 8 FGCOLOR 0 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 24
         BGCOLOR 3 FGCOLOR 1 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "วันหมดอายุความคุ้มครอง :":35 VIEW-AS TEXT
          SIZE 22.5 BY .95 AT ROW 10.33 COL 51.17
          BGCOLOR 18 FGCOLOR 4 FONT 6
     "          ทุนประกัน :":30 VIEW-AS TEXT
          SIZE 17 BY .95 AT ROW 13.52 COL 2
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "โทรศัพท์:":30 VIEW-AS TEXT
          SIZE 8 BY .95 AT ROW 9.1 COL 107.83
          BGCOLOR 18 FGCOLOR 2 FONT 6
     "รหัส:":30 VIEW-AS TEXT
          SIZE 4.5 BY .95 AT ROW 9.1 COL 93.5
          BGCOLOR 18 FGCOLOR 2 FONT 6
     "เบี้ยสุทธฺ:":30 VIEW-AS TEXT
          SIZE 8.5 BY .95 AT ROW 13.52 COL 36
          BGCOLOR 18 FGCOLOR 0 FONT 6
     " ใบเสร็จออกในนาม :":35 VIEW-AS TEXT
          SIZE 17 BY .95 AT ROW 19 COL 2
          BGCOLOR 18 FGCOLOR 0 FONT 6
     " ปีรถ :":35 VIEW-AS TEXT
          SIZE 6 BY .95 AT ROW 11.38 COL 93.83
          BGCOLOR 18 FGCOLOR 0 FONT 6
     " ผู้แจ้ง MKT:":35 VIEW-AS TEXT
          SIZE 12 BY 1 AT ROW 2.48 COL 76.5
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "คุ้มครองอุปกรณ์เพิ่มเติม:":35 VIEW-AS TEXT
          SIZE 21.5 BY .95 AT ROW 16.81 COL 55.17
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "           UPDATE     UPDATE     UPDATE     UPDATE     DATA.........COMPANY" VIEW-AS TEXT
          SIZE 103 BY 1 AT ROW 1.19 COL 2
          BGCOLOR 5 FGCOLOR 7 FONT 2
     "วันหมดอายุความคุ้มครอง :":35 VIEW-AS TEXT
          SIZE 23 BY 1 AT ROW 15.67 COL 63.5
          BGCOLOR 18 FGCOLOR 4 FONT 6
     "เลขเครื่องยนต์ :":35 VIEW-AS TEXT
          SIZE 14 BY .95 AT ROW 12.48 COL 93.5
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "IDno :":30 VIEW-AS TEXT
          SIZE 6 BY .95 AT ROW 6.91 COL 106
          BGCOLOR 18 FGCOLOR 2 FONT 6
     " ชื่อ :":35 VIEW-AS TEXT
          SIZE 5 BY .95 AT ROW 6.91 COL 34
          BGCOLOR 18 FGCOLOR 2 FONT 6
     "ถนน":30 VIEW-AS TEXT
          SIZE 4 BY .95 AT ROW 8 COL 103
          BGCOLOR 18 FGCOLOR 2 FONT 6
     "วันที่เริ่มค้มครอง :":35 VIEW-AS TEXT
          SIZE 16 BY 1 AT ROW 15.67 COL 32.33
          BGCOLOR 18 FGCOLOR 4 FONT 6
     "Contract:":35 VIEW-AS TEXT
          SIZE 9 BY .95 AT ROW 3.62 COL 108.5
          BGCOLOR 18 FGCOLOR 0 FONT 6
     " รุ่นรถ :":30 VIEW-AS TEXT
          SIZE 8 BY .95 AT ROW 11.38 COL 38.33
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "Notify Date :":30 VIEW-AS TEXT
          SIZE 12 BY 1 AT ROW 2.48 COL 49.83
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "          Producer :":30 VIEW-AS TEXT
          SIZE 17 BY .95 AT ROW 4.71 COL 2
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "เลขตัวถังรถ :":20 VIEW-AS TEXT
          SIZE 13 BY .95 AT ROW 12.48 COL 57.17
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "ขนาดCC :":30 VIEW-AS TEXT
          SIZE 10 BY .95 AT ROW 11.38 COL 109.33
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "         ทะเบียนรถ :":30 VIEW-AS TEXT
          SIZE 17 BY .95 AT ROW 12.48 COL 2
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "รหัสบริษัท:":30 VIEW-AS TEXT
          SIZE 10 BY 1 AT ROW 2.48 COL 109.5
          BGCOLOR 18 FGCOLOR 1 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 24
         BGCOLOR 3 FGCOLOR 1 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "  Agent :":30 VIEW-AS TEXT
          SIZE 8.5 BY .95 AT ROW 4.71 COL 32.83
          BGCOLOR 18 FGCOLOR 0 FONT 6
     " Policy New :":35 VIEW-AS TEXT
          SIZE 13.17 BY .95 AT ROW 3.62 COL 37
          BGCOLOR 8 FGCOLOR 0 FONT 6
     "เลขพรบ":30 VIEW-AS TEXT
          SIZE 8 BY .95 AT ROW 14.57 COL 59
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "          หมายเหตุ :":30 VIEW-AS TEXT
          SIZE 17 BY .95 AT ROW 21.14 COL 2
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "       ตำบล/แขวง  :":30 VIEW-AS TEXT
          SIZE 17 BY .95 AT ROW 9.1 COL 2
          BGCOLOR 18 FGCOLOR 2 FONT 6
     " เบี้ย พรบ.:":30 VIEW-AS TEXT
          SIZE 10 BY .95 AT ROW 13.52 COL 89.5
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "User load:" VIEW-AS TEXT
          SIZE 10 BY 1 AT ROW 19.33 COL 112.5
          BGCOLOR 18 FGCOLOR 2 FONT 6
     "           ข้อมูลลูกค้า" VIEW-AS TEXT
          SIZE 17 BY .95 AT ROW 5.81 COL 2
          BGCOLOR 2 FGCOLOR 7 FONT 6
     " NOTIFY  ENTRY" VIEW-AS TEXT
          SIZE 17 BY 1 AT ROW 2.48 COL 2
          BGCOLOR 2 FGCOLOR 7 FONT 6
     "    8.3  ไฟแนนซ์ :":30 VIEW-AS TEXT
          SIZE 17 BY .95 AT ROW 20.1 COL 2
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "   ข้อมูลประกันภัย :":30 VIEW-AS TEXT
          SIZE 17 BY .95 AT ROW 10.29 COL 2.17
          BGCOLOR 2 FGCOLOR 7 FONT 6
     "User By:" VIEW-AS TEXT
          SIZE 8.17 BY 1 AT ROW 21.05 COL 104 WIDGET-ID 10
          BGCOLOR 18 FGCOLOR 4 FONT 6
     "เบี้ยรวมภาษีอากร :":30 VIEW-AS TEXT
          SIZE 16 BY .95 AT ROW 13.52 COL 58.5
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "             Prepol :":35 VIEW-AS TEXT
          SIZE 17 BY .95 AT ROW 3.62 COL 2
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "วันที่เริ่มค้มครอง :":35 VIEW-AS TEXT
          SIZE 16 BY .95 AT ROW 10.33 COL 20
          BGCOLOR 18 FGCOLOR 4 FONT 6
     "ผู้ตรวจรถ:":30 VIEW-AS TEXT
          SIZE 10 BY .95 AT ROW 10.19 COL 98.83 WIDGET-ID 6
          BGCOLOR 18 FGCOLOR 2 FONT 6
     " ตรวจสภาพ :" VIEW-AS TEXT
          SIZE 12.67 BY .91 AT ROW 14.62 COL 89.5 WIDGET-ID 20
          BGCOLOR 33 FGCOLOR 4 FONT 6
     "อำเภอ/เขต :":30 VIEW-AS TEXT
          SIZE 9.5 BY .95 AT ROW 9.1 COL 39
          BGCOLOR 18 FGCOLOR 2 FONT 6
     "Notify no.:" VIEW-AS TEXT
          SIZE 11 BY 1 AT ROW 2.48 COL 19.83
          BGCOLOR 18 FGCOLOR 2 FONT 6
     RECT-488 AT ROW 1 COL 1.5
     RECT-490 AT ROW 18.86 COL 123
     RECT-491 AT ROW 22.24 COL 122.67
     RECT-492 AT ROW 22.24 COL 112.33
     RECT-493 AT ROW 18.86 COL 80.5
     RECT-661 AT ROW 13.52 COL 112.67 WIDGET-ID 30
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 24
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
         TITLE              = "UPDATE  DATA BY AYCL..."
         HEIGHT             = 23.76
         WIDTH              = 132.33
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
/* SETTINGS FOR FILL-IN fi_company IN FRAME fr_main
   NO-ENABLE                                                            */
ASSIGN 
       fi_notdat:HIDDEN IN FRAME fr_main           = TRUE.

ASSIGN 
       fi_notino:HIDDEN IN FRAME fr_main           = TRUE.

/* SETTINGS FOR FILL-IN fi_Trndat IN FRAME fr_main
   NO-ENABLE                                                            */
ASSIGN 
       fi_Trndat:HIDDEN IN FRAME fr_main           = TRUE.

/* SETTINGS FOR FILL-IN fi_userby IN FRAME fr_main
   NO-ENABLE                                                            */
ASSIGN 
       fi_userby:HIDDEN IN FRAME fr_main           = TRUE.

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
ON END-ERROR OF C-Win /* UPDATE  DATA BY AYCL... */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* UPDATE  DATA BY AYCL... */
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


&Scoped-define SELF-NAME bu_save
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_save C-Win
ON CHOOSE OF bu_save IN FRAME fr_main /* Save */
DO: 

    FIND  tlt  WHERE   RECID(tlt)  =  nv_recidtlt   NO-ERROR NO-WAIT .
    IF  AVAIL  tlt  THEN DO:
        ASSIGN 
            tlt.comp_noti_tlt = TRIM(fi_ins_off)    
            tlt.nor_usr_ins   = CAPS(TRIM(fi_comco))
            tlt.nor_noti_ins  = CAPS(TRIM(fi_prepol)) 
            tlt.comp_usr_tlt  = CAPS(TRIM(fi_cmrsty))     
            tlt.recac         = CAPS(TRIM(fi_contact))    
            tlt.comp_sub      = CAPS(TRIM(fi_producer))   
            tlt.dri_no2       = CAPS(TRIM(fi_agent))      
            tlt.safe3         = TRIM(fi_cover1)     
            tlt.rencnt        = fi_renew 
            tlt.ins_name      = TRIM(fi_institle)  + " " +  
                                TRIM(fi_preinsur)  + " " +                            
                                TRIM(fi_preinsur2) 
            tlt.safe2         = TRIM(fi_idno)
            tlt.ins_addr1     = TRIM(fi_insadd1no) + " " +
                                (IF fi_insadd1soy  = "" THEN "" ELSE "ซ." + TRIM(fi_insadd1soy)  + " "  )  +
                                (IF fi_insadd1road = "" THEN "" ELSE "ถ." + TRIM(fi_insadd1road))
            tlt.ins_addr2     = TRIM(fi_insadd2tam)               
            tlt.ins_addr3     = TRIM(fi_insadd3amp)               
            tlt.ins_addr4     = TRIM(fi_insadd4cunt)                  
            tlt.ins_addr5     = TRIM(fi_insadd5post) 


            tlt.comp_noti_ins = TRIM(fi_insadd6tel)      
            tlt.nor_effdat    = fi_comdat             
            tlt.expodat       = fi_expdat      
            tlt.brand         = TRIM(fi_brand)           
            tlt.model         = TRIM(fi_model) 
            tlt.lince2        = TRIM(fi_year)              
            tlt.cc_weight     = fi_power       
            tlt.lince1        = TRIM(fi_licence1) + " " +  
                                TRIM(fi_licence2) + " " +     
                                TRIM(fi_provin) 
            tlt.cha_no        = TRIM(fi_cha_no)      
            tlt.eng_no        = TRIM(fi_eng_no) 

            tlt.comp_coamt    = fi_sumsi       
            tlt.dri_name2     = STRING(fi_gap)         
            tlt.nor_grprm     = fi_premium     
            tlt.dri_no1       = STRING(fi_precomp)     
            tlt.seqno         = fi_deduct       
            tlt.nor_usr_tlt   = TRIM(fi_companycomp) 
            tlt.comp_sck      = TRIM(fi_stk)
            tlt.dri_name1     = IF ra_drivno  = 1  THEN   "1" ELSE "2"
            tlt.comp_effdat   = fi_comdat72    
            tlt.dat_ins_noti  = fi_expdat72   
            tlt.lince3        = TRIM(fi_pack)  +  TRIM(fi_class)
            tlt.stat          = TRIM(fi_garage)
            tlt.safe1         = TRIM(fi_access)      
            tlt.filler1       = TRIM(fi_editaddr)    
            tlt.rec_name      = TRIM(fi_recipname)   
            tlt.lotno         = TRIM(fi_vatcode)     
            tlt.comp_usr_ins  = TRIM(fi_benname)     
            /*tlt.OLD_cha       = TRIM(fi_remark1) */ /*Comment by Sarinya A61-0349*/
            tlt.policy        = TRIM(fi_notno70)                    
            tlt.comp_pol      = TRIM(fi_notno72)  
            tlt.rec_addr4     = TRIM(fi_agent)      /*Add Jiraphon A59-0451*/
            tlt.datesent      = fi_notdat         /*A58-0384*/
            tlt.nor_noti_tlt  = TRIM(fi_notino)   /*A58-0384*/
            /*tlt.releas        = IF     ra_status =  2 THEN  "No" ELSE "Yes"*/ /*A61-0349*/
            tlt.OLD_eng       = IF ra_complete =  1 THEN   "complete"   ELSE "not complete"   /*A58-0384*/
            /**/
            /*tlt.trndat        = TODAY              /*Date Edit Data*/ /*add By Sarinya C A61-0349 23/07/2018*/*/
            tlt.usrid         = USERID(LDBNAME(1)) /*User Edit Data*/ /*add By Sarinya C A61-0349 23/07/2018*/
            tlt.OLD_cha       = trim(Input fi_remark1) + 
                               ( IF trim(Input  fi_remark2)   <> "" THEN "r2:"     + trim(Input fi_remark2)   ELSE " r2: " )  + 
                               ( IF trim(Input  fi_remark3)   <> "" THEN "r3:"     + trim(Input fi_remark3)   ELSE " r3: " )  +
                               ( IF trim(Input  fi_inspno)    <> "" THEN "ISP:"    + trim(Input fi_inspno )   ELSE " ISP:" )  +
                               ( IF trim(INPUT  fi_detailisp) <> "" THEN "Detail:" + trim(INPUT fi_detailisp) ELSE "" )
                .
    END.                          
    ELSE DO: 
        MESSAGE "Not found policy no Update..tlt" VIEW-AS ALERT-BOX.
    END.
    MESSAGE "SAVE COMPLETE....   "  VIEW-AS ALERT-BOX.
    APPLY "Close"  TO THIS-PROCEDURE.
    RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_upins
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_upins C-Win
ON CHOOSE OF bu_upins IN FRAME fr_main /* Chech ISP */
DO: 
    DEF VAR nv_docno  AS CHAR FORMAT "x(25)".
    DEF VAR nv_survey AS CHAR FORMAT "x(25)".
    DEF VAR nv_detail AS CHAR FORMAT "x(30)".
    DEF VAR nv_year   AS CHAR FORMAT "x(5)".

    ASSIGN  nv_docno    = ""   nv_tmp   = ""   
            nv_year     = STRING(YEAR(TODAY),"9999")
            nv_tmp      = "Inspect" + SUBSTR(nv_year,3,2) + ".nsf".

    /*--------- Server Real ----------*/
    nv_server = "Safety_NotesServer/Safety".
    nv_tmp   = "safety\uw\" + nv_tmp .
    /*-------------------------------*/
    /*---------- Server test local -------*/
    /*
    nv_server = "".
    nv_tmp    = "D:\Lotus\Notes\Data\ranu\" + nv_tmp .
    */
    /*-----------------------------*/
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

          chitem       = chDocument:Getfirstitem("SurveyClose").
          IF chitem <> 0 THEN nv_survey    = chitem:TEXT. 
          ELSE nv_survey = "".
          
          chitem       = chDocument:Getfirstitem("SurveyResult").
          IF chitem <> 0 THEN nv_detail    = chitem:TEXT.
          ELSE nv_detail = "".

          IF nv_docno <> ""  THEN DO:
              IF nv_survey <> "" THEN DO:
                ASSIGN  fi_inspno = nv_docno
                        fi_insp   = "YES"
                        fi_detailisp = nv_detail.
              END.
              ELSE DO:
                  ASSIGN fi_inspno = nv_docno       
                         fi_insp   = "NO"          
                         fi_detailisp = "". 
              END.
          END.
          ELSE ASSIGN  fi_inspno = "" 
                       fi_insp   = "NO"
                       fi_detailisp = "".

          RELEASE  OBJECT chitem          NO-ERROR.
          RELEASE  OBJECT chDocument      NO-ERROR.          
          RELEASE  OBJECT chNotesDataBase NO-ERROR.     
          RELEASE  OBJECT chNotesSession  NO-ERROR.
      END.
      
      DISP fi_inspno fi_insp  fi_detailisp  WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_access
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_access C-Win
ON LEAVE OF fi_access IN FRAME fr_main
DO:
  fi_access  =  caps(Input fi_access ) .
  Disp  fi_access with frame  fr_main.
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
  fi_benname  = INPUT fi_benname.
  DISP fi_benname WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_brand
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_brand C-Win
ON LEAVE OF fi_brand IN FRAME fr_main
DO:
    fi_brand = caps(INPUT fi_brand ).
    DISP fi_brand WITH FRAM fr_main.
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


&Scoped-define SELF-NAME fi_cmrsty
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_cmrsty C-Win
ON LEAVE OF fi_cmrsty IN FRAME fr_main
DO:
    fi_cmrsty = caps(INPUT fi_cmrsty)  .
    DISP fi_cmrsty WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_comco
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_comco C-Win
ON LEAVE OF fi_comco IN FRAME fr_main
DO:  
    fi_comco = caps(INPUT fi_comco).
    DISP  fi_comco  WITH FRAM fr_main.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_comdat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_comdat C-Win
ON LEAVE OF fi_comdat IN FRAME fr_main
DO:
    fi_comdat = INPUT fi_comdat.
    fi_expdat = DATE(STRING(DAY(fi_comdat),"99") + "/" +
                     STRING(MONTH(fi_comdat),"99") + "/" +
                     string(year(fi_comdat) + 1 ,"9999")).
    DISP fi_comdat fi_expdat WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_comdat72
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_comdat72 C-Win
ON LEAVE OF fi_comdat72 IN FRAME fr_main
DO:
    fi_comdat72 = INPUT fi_comdat72.
    fi_expdat72   = DATE(STRING(DAY(fi_comdat72),"99") + "/" +
                  STRING(MONTH(fi_comdat72),"99") + "/" +
                  string(year(fi_comdat72) + 1 ,"9999")).
  DISP fi_comdat72 fi_expdat72  WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_companycomp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_companycomp C-Win
ON LEAVE OF fi_companycomp IN FRAME fr_main
DO:  
    fi_companycomp = caps(INPUT fi_companycomp).
    DISP  fi_companycomp  WITH FRAM fr_main.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_contact
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_contact C-Win
ON LEAVE OF fi_contact IN FRAME fr_main
DO:
    fi_contact = caps(INPUT fi_contact)  .
    DISP fi_contact WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_cover1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_cover1 C-Win
ON LEAVE OF fi_cover1 IN FRAME fr_main
DO:  
    fi_cover1 =  INPUT fi_cover1 .
    DISP  fi_cover1  WITH FRAM fr_main.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_deduct
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_deduct C-Win
ON LEAVE OF fi_deduct IN FRAME fr_main
DO:
  fi_deduct  =   Input  fi_deduct .
  Disp  fi_deduct  with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_detailisp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_detailisp C-Win
ON LEAVE OF fi_detailisp IN FRAME fr_main
DO:
    fi_detailisp = INPUT fi_detailisp.
    DISP fi_detailisp WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_editaddr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_editaddr C-Win
ON LEAVE OF fi_editaddr IN FRAME fr_main
DO:
  fi_editaddr = trim(INPUT fi_editaddr).
  DISP fi_editaddr with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


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


&Scoped-define SELF-NAME fi_expdat72
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_expdat72 C-Win
ON LEAVE OF fi_expdat72 IN FRAME fr_main
DO:
  fi_expdat72 = INPUT fi_expdat72.
  DISP fi_expdat72 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_gap
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_gap C-Win
ON LEAVE OF fi_gap IN FRAME fr_main
DO:
    fi_gap   = INPUT fi_gap.
    /*ASSIGN 
    fi_premium =  Truncate(fi_gap * 0.4 / 100,0) + (IF (fi_gap * 0.4 / 100) - Truncate(fi_gap * 0.4 / 100,0) > 0 Then 1 Else 0)
    + fi_gap .
    fi_premium = ( fi_premium * 7 / 100 ) +  fi_premium .*/
    DISP fi_gap     WITH FRAM fr_main.
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


&Scoped-define SELF-NAME fi_idno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_idno C-Win
ON LEAVE OF fi_idno IN FRAME fr_main
DO:
    fi_idno  = INPUT fi_idno.
    DISP fi_idno WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_insadd1no
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_insadd1no C-Win
ON LEAVE OF fi_insadd1no IN FRAME fr_main
DO:
    fi_insadd1no  = INPUT fi_insadd1no .
    DISP fi_insadd1no WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_insadd1road
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_insadd1road C-Win
ON LEAVE OF fi_insadd1road IN FRAME fr_main
DO:
    fi_insadd1road  = INPUT fi_insadd1road .
    DISP fi_insadd1road WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_insadd1soy
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_insadd1soy C-Win
ON LEAVE OF fi_insadd1soy IN FRAME fr_main
DO:
    fi_insadd1soy  = INPUT fi_insadd1soy.
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
    fi_insadd4cunt   = INPUT fi_insadd4cunt.
    DISP fi_insadd4cunt  WITH FRAM fr_main.
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


&Scoped-define SELF-NAME fi_insp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_insp C-Win
ON LEAVE OF fi_insp IN FRAME fr_main
DO:
  fi_insp = INPUT fi_insp.
  DISP fi_insp WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_InspectName
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_InspectName C-Win
ON LEAVE OF fi_InspectName IN FRAME fr_main
DO:
    /*A61-0349*/
    fi_InspectName  = INPUT fi_InspectName.
    DISP fi_InspectName WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_inspno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_inspno C-Win
ON LEAVE OF fi_inspno IN FRAME fr_main
DO:
    fi_inspno = INPUT fi_inspno.
    DISP fi_inspno WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_institle
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_institle C-Win
ON LEAVE OF fi_institle IN FRAME fr_main
DO:
    fi_institle    = INPUT fi_institle.
    DISP fi_institle WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_ins_off
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_ins_off C-Win
ON LEAVE OF fi_ins_off IN FRAME fr_main
DO:
    fi_ins_off  = INPUT fi_ins_off.
    DISP fi_ins_off  WITH FRAM fr_main.
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


&Scoped-define SELF-NAME fi_notdat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_notdat C-Win
ON LEAVE OF fi_notdat IN FRAME fr_main
DO:
  fi_notdat = INPUT fi_notdat.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_notino
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_notino C-Win
ON LEAVE OF fi_notino IN FRAME fr_main
DO:

  IF TRIM(INPUT fi_notino) = "" THEN DO:
      MESSAGE "Please Input Notify No." VIEW-AS ALERT-BOX WARNING.
      APPLY "ENTRY" TO fi_notino IN FRAME fr_main.
  END.

  IF fi_notino <> INPUT fi_notino THEN DO:

      fi_notino = INPUT fi_notino.

      FIND FIRST tlt WHERE tlt.nor_noti_tlt = TRIM(fi_notino) AND
                           tlt.genusr       = "aycal"         NO-LOCK NO-ERROR.
      IF AVAIL tlt THEN DO:
          MESSAGE "Duplicate Notify No. with : " + tlt.nor_noti_tlt 
          VIEW-AS ALERT-BOX WARNING.
          APPLY "ENTRY" TO fi_notino IN FRAME fr_main.
      END.
  END.

  fi_notino = INPUT fi_notino.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_notno70
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_notno70 C-Win
ON LEAVE OF fi_notno70 IN FRAME fr_main
DO:
    fi_notno70 = INPUT fi_notno70 .
    DISP fi_notno70 WITH FRAM fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_notno72
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_notno72 C-Win
ON LEAVE OF fi_notno72 IN FRAME fr_main
DO:
    fi_notno72 = INPUT fi_notno72 .
    DISP fi_notno72 WITH FRAM fr_main.
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
    DISP fi_precomp WITH FRAM fr_main.
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


&Scoped-define SELF-NAME fi_prepol
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_prepol C-Win
ON LEAVE OF fi_prepol IN FRAME fr_main
DO:
    fi_prepol = caps(INPUT fi_prepol) .
    DISP fi_prepol WITH FRAM fr_main. 
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


&Scoped-define SELF-NAME fi_remark3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_remark3 C-Win
ON LEAVE OF fi_remark3 IN FRAME fr_main
DO:
  fi_remark3 = trim(INPUT fi_remark3).
  DISP fi_remark3 with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_renew
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_renew C-Win
ON LEAVE OF fi_renew IN FRAME fr_main
DO:  
    fi_renew = INPUT fi_renew .
    DISP  fi_renew  WITH FRAM fr_main.  
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


&Scoped-define SELF-NAME ra_complete
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_complete C-Win
ON VALUE-CHANGED OF ra_complete IN FRAME fr_main
DO:
    ra_complete = INPUT ra_complete.
    DISP ra_complete WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ra_drivno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_drivno C-Win
ON VALUE-CHANGED OF ra_drivno IN FRAME fr_main
DO:
    ra_drivno = INPUT ra_drivno .
    DISP ra_drivno WITH FRAM fr_mail.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK C-Win 


/* ***************************  Main Block  *************************** */
/* Set CURRENT-WINDOW: this will parent dialog-boxes and frames.        */
ASSIGN CURRENT-WINDOW             = {&WINDOW-NAME} 
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
    gv_prgid = "wgwquay2".
    gv_prog  = "UPDATE  DATA BY AYCAL ...".
    RUN  WUT\WUTHEAD ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).
    /*********************************************************************/ 
    /*  RUN Wut\WutwiCen ({&WINDOW-NAME}:HANDLE). */ 
    /*CURRENT-WINDOW:WINDOW-STATE = WINDOW-MAXIMIZED.*/
    SESSION:DATA-ENTRY-RETURN = YES.
    Find  tlt  Where   Recid(tlt)  =  nv_recidtlt NO-LOCK NO-ERROR NO-WAIT .
    If  avail  tlt  Then do:
        /*A61-0349*/
        IF INDEX(tlt.usrsent,"IP:") <> 0 THEN  n_InspectPhoneNo = substr(tlt.usrsent,INDEX(tlt.usrsent,"IP:")). ELSE n_InspectPhoneNo = "".
        n_InspectPhoneNo = REPLACE(n_InspectPhoneNo,"IP:","") .

        IF INDEX(tlt.usrsent,"IN:") <> 0 THEN  n_InspectName = substr(tlt.usrsent,INDEX(tlt.usrsent,"IN:"),INDEX(tlt.usrsent,"IP:") - 1 ). ELSE n_InspectName = "".
        n_InspectName = REPLACE(n_InspectName,"IN:","") .
        /*A61-0349*/

        Assign
            nv_check70    = "no"
            nv_check72    = "no"
            n_brsty       = tlt.comp_usr_tlt
            fi_company    = caps(tlt.genusr)
            fi_notino     = tlt.nor_noti_tlt
            fi_notdat     = tlt.datesent
            fi_ins_off    = tlt.comp_noti_tlt
            fi_comco      = tlt.nor_usr_ins 
            fi_prepol     = tlt.nor_noti_ins
            fi_notno70    = tlt.policy                   
            fi_notno72    = tlt.comp_pol  
            fi_cmrsty     = tlt.comp_usr_tlt  
            fi_contact    = tlt.recac
            fi_producer   = tlt.comp_sub   
            fi_agent      = tlt.dri_no2
            fi_cover1     = tlt.safe3 
            fi_renew      = tlt.rencnt 
            fi_userid     = tlt.endno 
            fi_institle   = substr(tlt.ins_name,1,INDEX(tlt.ins_name," "))
            fi_preinsur   = substr(tlt.ins_name,INDEX(tlt.ins_name," ") + 1,R-INDEX(tlt.ins_name," ") - INDEX(tlt.ins_name," "))                   
            fi_preinsur2  = substr(tlt.ins_name,r-INDEX(tlt.ins_name," ") + 1)               
            fi_insadd2tam  = tlt.ins_addr2              
            fi_insadd3amp  = tlt.ins_addr3              
            fi_insadd4cunt = tlt.ins_addr4                  
            fi_insadd5post = tlt.ins_addr5              
            fi_insadd6tel  = tlt.comp_noti_ins + n_InspectPhoneNo /*A61-0349*/
            fi_comdat      = tlt.nor_effdat              
            fi_expdat      = tlt.expodat
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
            fi_sumsi       = tlt.comp_coamt 
            fi_gap         = DECI(tlt.dri_name2) 
            fi_premium     = tlt.nor_grprm   
            fi_precomp     = deci(tlt.dri_no1)
            fi_deduct      = tlt.seqno 
            fi_companycomp = tlt.nor_usr_tlt
            fi_stk         = tlt.comp_sck 
            ra_drivno      = IF tlt.dri_name1 = "1" THEN 2 ELSE 1
            fi_comdat72    = tlt.comp_effdat
            fi_expdat72    = tlt.dat_ins_noti
            fi_pack        = substr(tlt.lince3,1,1)        
            fi_class       = substr(tlt.lince3,2,3)     
            fi_idno        = tlt.safe2 
            fi_garage      = tlt.stat
            fi_access      = tlt.safe1 
            fi_editaddr    = tlt.filler1  
            fi_recipname   = tlt.rec_name        
            fi_vatcode     = tlt.lotno
            fi_benname     = tlt.comp_usr_ins 
            fi_agent       = tlt.rec_addr4  /*Add Jiraphon A59-0451*/
            ra_complete    = IF trim(tlt.OLD_eng) =  "complete" THEN 1 ELSE 2
            n_addr11       = tlt.ins_addr1 
            /**/
            fi_InspectName = trim(n_InspectName) /*A61-0349*/
            fi_userby      = tlt.usrid 
            fi_Trndat      = tlt.trndat               /**/
            .
        
                 ASSIGN 
                    fi_remark1    = IF index(tlt.OLD_cha,"r2:")      <> 0 THEN Substr(tlt.OLD_cha,1,index(tlt.OLD_cha,"r2:")   - 1 ) ELSE TRIM(tlt.OLD_cha)
                    fi_remark2    = IF index(tlt.OLD_cha,"r2:")      <> 0 THEN Substr(tlt.OLD_cha,index(tlt.OLD_cha,"r2:")     + 3 ) ELSE ""
                    fi_remark2    = IF index(fi_remark2,"r3:")       <> 0 THEN Substr(fi_remark2,1,index(fi_remark2,"r3:")     - 1 ) ELSE fi_remark2
                    fi_remark3    = IF index(tlt.OLD_cha,"r3:")      <> 0 THEN Substr(tlt.OLD_cha,index(tlt.OLD_cha,"r3:")     + 3 ) ELSE ""
                    fi_remark3    = IF index(fi_remark3,"ISP:")      <> 0 THEN Substr(fi_remark3,1,index(fi_remark3,"ISP:")    - 1 ) ELSE ""
                    /**/                                             
                    fi_insp       = IF INDEX(tlt.OLD_cha,"Detail:")  <> 0 THEN "YES" ELSE "NO" 
                    fi_inspno     = IF index(tlt.OLD_cha,"ISP:")     <> 0 THEN Substr(tlt.OLD_cha,index(tlt.OLD_cha,"ISP:")    + 4 ) ELSE ""
                    fi_inspno     = IF index(fi_inspno,"Detail:")    <> 0 THEN Substr(fi_inspno,1,index(fi_inspno,"Detail:")   - 1 ) ELSE fi_inspno
                    fi_detailisp  = IF INDEX(tlt.OLD_cha,"Detail:")  <> 0 THEN SUBSTR(tlt.OLD_cha,index(tlt.OLD_cha,"Detail:") + 7 ) ELSE ""
                    .

           
             /*ra_status      = IF tlt.releas = "No" THEN 2 ELSE 1.*//*Phorn A58-0361*/

       /* Add A58-0361 */
             /*IF tlt.releas = "NO"  THEN ra_status = 2.
        ELSE IF tlt.releas = "Yes" THEN ra_status = 1.
        ELSE IF tlt.releas = "CANCEL"  THEN ra_status = 3.*/ /*A61-0349*/
    END.
    ASSIGN fi_insadd1soy = "" . 
    IF (r-INDEX(n_addr11,"ซ.")) > (r-INDEX(n_addr11,"ถ.")) THEN DO:
        IF r-INDEX(n_addr11,"ซ.") <> 0 THEN DO: 
            ASSIGN fi_insadd1soy = SUBSTR(n_addr11,r-INDEX(n_addr11,"ซ.") + 2 )
                n_soy            = SUBSTR(n_addr11,r-INDEX(n_addr11,"ซ.") + 2 )
                n_addr11         = SUBSTR(n_addr11,1,r-INDEX(n_addr11,"ซ.") - 1  ).
        END.
        ELSE IF r-INDEX(n_addr11,"ซอย") <> 0 THEN DO: 
            ASSIGN fi_insadd1soy = SUBSTR(n_addr11,r-INDEX(n_addr11,"ซอย") + 3 )
                n_soy            = SUBSTR(n_addr11,r-INDEX(n_addr11,"ซอย") + 3 )
                n_addr11         = SUBSTR(n_addr11,1,r-INDEX(n_addr11,"ซอย") - 1  ).
        END.
        ELSE ASSIGN fi_insadd1soy = "". 
    END.

    IF r-INDEX(n_addr11,"ถ.") <> 0 THEN DO: 
            ASSIGN fi_insadd1road = SUBSTR(n_addr11,R-INDEX(n_addr11,"ถ.") + 2 )
                n_road            = SUBSTR(n_addr11,R-INDEX(n_addr11,"ถ.") + 2 )
                n_addr11          = SUBSTR(n_addr11,1,R-INDEX(n_addr11,"ถ.") - 1 ).
    END.
    ELSE IF r-INDEX(n_addr11,"ถนน") <> 0  THEN DO:
        ASSIGN fi_insadd1road = SUBSTR(n_addr11,R-INDEX(n_addr11,"ถนน") + 3 )
                n_road   = SUBSTR(n_addr11,r-INDEX(n_addr11,"ถนน") + 3 )
                n_addr11 = SUBSTR(n_addr11,1,r-INDEX(n_addr11,"ถนน") - 1).
    END.
    ELSE ASSIGN fi_insadd1road = "".
    IF   r-INDEX(n_addr11,"ซ.") <> 0 THEN DO: 
        ASSIGN fi_insadd1soy = SUBSTR(n_addr11,r-INDEX(n_addr11,"ซ.") + 2 )
            n_soy            = SUBSTR(n_addr11,r-INDEX(n_addr11,"ซ.") + 2 )
            n_addr11         = SUBSTR(n_addr11,1,r-INDEX(n_addr11,"ซ.") - 1  ).
    END.
    ELSE IF r-INDEX(n_addr11,"ซอย") <> 0 THEN DO: 
        ASSIGN fi_insadd1soy = SUBSTR(n_addr11,r-INDEX(n_addr11,"ซอย") + 3 )
            n_soy            = SUBSTR(n_addr11,r-INDEX(n_addr11,"ซอย") + 3 )
            n_addr11         = SUBSTR(n_addr11,1,r-INDEX(n_addr11,"ซอย") - 1  ).
    END.
    ASSIGN fi_insadd1no = trim(n_addr11).

    RUN  proc_dispable.
    Disp fi_company      fi_notino       fi_comco        fi_ins_off      fi_prepol  
         fi_notdat       fi_cmrsty       fi_producer     fi_agent        fi_contact         
         fi_renew        fi_cover1       fi_notno70      fi_notno72      fi_institle        
         fi_preinsur     fi_preinsur2    fi_insadd1no      
         fi_insadd1soy   fi_insadd1road  fi_insadd2tam   fi_insadd3amp   fi_insadd4cunt     
         fi_insadd5post  fi_insadd6tel   fi_brand        fi_model        fi_eng_no   
         fi_cha_no       fi_power        fi_year         fi_licence1     fi_licence2     
         fi_provin       fi_pack         fi_class        fi_sumsi        fi_premium      
         fi_precomp      fi_stk          fi_recipname    fi_deduct       fi_remark1 
         fi_vatcode      fi_comdat       fi_expdat       fi_gap          fi_companycomp     
         fi_benname      fi_remark1      ra_complete     fi_stk        
         fi_idno         ra_drivno       fi_comdat72     fi_expdat72 
         fi_userid       fi_pack         fi_class        fi_garage       fi_access       fi_editaddr   
         fi_recipname    fi_vatcode      /*ra_status*/   fi_InspectName  fi_userby
         fi_Trndat       fi_remark2      fi_remark3      fi_insp         fi_detailisp    fi_inspno
        /*A61-0349*/
                                                                             
        With frame   fr_main.
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
  DISPLAY fi_detailisp fi_insp fi_company fi_notino fi_notdat fi_ins_off 
          fi_comco fi_prepol fi_notno70 fi_notno72 fi_cmrsty fi_contact 
          fi_producer fi_agent fi_cover1 fi_renew fi_institle fi_preinsur 
          fi_preinsur2 fi_idno fi_insadd1no fi_insadd1soy fi_insadd1road 
          fi_insadd2tam fi_insadd3amp fi_insadd4cunt fi_insadd5post 
          fi_insadd6tel fi_InspectName fi_comdat fi_expdat fi_brand fi_model 
          fi_year fi_power fi_licence1 fi_licence2 fi_provin fi_cha_no fi_eng_no 
          fi_sumsi fi_gap fi_premium fi_precomp fi_deduct fi_companycomp fi_stk 
          ra_drivno fi_comdat72 fi_expdat72 fi_pack fi_class fi_garage fi_access 
          fi_editaddr fi_recipname fi_vatcode fi_userid ra_complete fi_benname 
          fi_userby fi_Trndat fi_remark1 fi_remark2 fi_remark3 fi_inspno 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE bu_upins fi_detailisp fi_insp fi_notino fi_notdat fi_ins_off fi_comco 
         fi_prepol fi_notno70 fi_notno72 fi_cmrsty fi_contact fi_producer 
         fi_agent fi_cover1 fi_renew fi_institle fi_preinsur fi_preinsur2 
         fi_idno fi_insadd1no fi_insadd1soy fi_insadd1road fi_insadd2tam 
         fi_insadd3amp fi_insadd4cunt fi_insadd5post fi_insadd6tel 
         fi_InspectName fi_comdat fi_expdat fi_brand fi_model bu_model fi_year 
         fi_power fi_licence1 fi_licence2 fi_provin fi_cha_no fi_eng_no 
         fi_sumsi fi_gap fi_premium fi_precomp fi_deduct fi_companycomp fi_stk 
         ra_drivno fi_comdat72 fi_expdat72 fi_pack fi_class fi_garage fi_access 
         fi_editaddr fi_recipname fi_vatcode ra_complete fi_benname fi_remark1 
         fi_remark2 fi_remark3 bu_save bu_exit fi_inspno RECT-488 RECT-490 
         RECT-491 RECT-492 RECT-493 RECT-661 
      WITH FRAME fr_main IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
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
FIND LAST  tlt    WHERE 
    tlt.genusr        = "Phone"      AND
    tlt.nor_noti_tlt  = fi_notino    NO-ERROR NO-WAIT.
IF AVAIL tlt THEN  
    ASSIGN tlt.policy        =  fi_notno70 .
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
    
    DISABLE              bu_model    /*bu_save*/ /*Comment By Sarinya C A61-0349 23/07/2018*/
         fi_notino       fi_comco        fi_ins_off         
         fi_notdat       fi_cmrsty       fi_producer     fi_agent fi_cover1             
         fi_notno70      fi_notno72      fi_institle        
         fi_preinsur     fi_preinsur2    fi_insadd1no        
         fi_insadd1soy   fi_insadd1road  fi_insadd2tam   fi_insadd3amp   fi_insadd4cunt  
         fi_insadd5post  fi_insadd6tel   fi_brand        fi_model        fi_eng_no   
         fi_cha_no       fi_power        fi_year         fi_licence1     fi_licence2     
         fi_provin       fi_pack         fi_class        fi_sumsi        fi_premium      
         fi_precomp      fi_stk          fi_recipname    
         fi_vatcode      fi_comdat       fi_expdat       fi_gap             
         fi_benname      fi_garage       ra_complete  fi_userid 
         /*fi_remark1      fi_remark2      fi_remark3   */   /*Comment By Sarinya A61-00349 31/07/2018*/ 
    WITH FRAM fr_main.
 
    END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

