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
/*CREATE WIDGET-POOL.*/
/* ***************************  Definitions  ************************** */
/* Parameters Definitions ---                                           */
/* Local Variable Definitions ---                                       */
/*++++++++++++++++++++++++++++++++++++++++++++++
program id       :  wgwimpon.w 
program name     :  Import data by Telephone create  new policy  Add in table  tlt 
Create  by       :  Kridtiya i. A55-0015  On   10/01/2012
Database Connect :  gw_stat ld brstat , gw_safe ld sic_bran ,sic_test ld sicuw sicsyac :not connect stat
+++++++++++++++++++++++++++++++++++++++++++++++*/
/*Modify by      : Kridtiya i. A55-0073 ปรับการรับหน้าจอให้รับจากพารามิเตอร์*/
/*modify by      : Kridtiya i. A55-0108 เพิ่มการให้ค่าแพคเกจตามประเภทประกัน*/
/*modify by      : Kridtiya i. A55-0125 date. 02/04/2012 เพิ่มการให้ค่าที่อยู่อาคาร */
/*modify by      : Kridtiya i. A55-0257 date. 17/08/2012 เพิ่มการแสดงชื่อผู้รับงาน  */
/*modify by      : Kridtiya i. A56-0024 date. 09/10/2013 เพิ่มการแสดงชื่อดีเลอร์    */
/*modify by      : Kridtiya i. A57-0063 date. 18/02/2014 เพิ่มการรับประกันรถจักรยานยนต์*/
/*modify by      : Phaiboon W. [A59-0488] Date 07/11/2016 เพิ่ม Remark , เพิ่ม Quatation */
/*modify by      : Phaiboon W. [A59-0625] Date 22/12/2016 เพิ่มปุ่ม Create Record in LotusNotes Database กล่องตรวจสภาพ */
/*Modify by      : Ranu I. A62-0219 แก้ไขหน้าจอ เพิ่มปุ่ม Campaing  ช่อง redbook , ทุนสูญหายไฟไหม้ สาขารับแจ้ง
                  และเก็บค่าความคุ้มครองจากแคมเปญ ลงในระบบ  */
/*Modify by      : Ranu I. A63-0392 แก้ไข format ทะเบียนรถให้ตรงกับ pattern ในกล่อง inspection               */
/*--------------------------------------------------------------------------------------------------------------------*/                 

DEF Input Parameter    n_policy    AS CHAR FORMAT "x(20)".
DEF                VAR nv_index    as int  init 0.
DEF  NEW   SHARED  VAR gComp       AS CHAR.
DEF  NEW   SHARED  VAR n_agent1    LIKE sicsyac.xmm600.acno. 
DEF  NEW   SHARED  VAR n_agent2    LIKE sicsyac.xmm600.acno. 
DEF  NEW   SHARED  VAR nv_agent    AS CHAR FORMAT "x(10)".
/* Parameters Definitions ---                                           */
DEF VAR    n_name       As   Char    Format    "x(35)".
DEF VAR    n_nO1        As   Char    Format    "x(35)".
DEF VAR    n_nO2        As   Char    Format    "x(35)".
Def  VAR   n_nO3        As   Char    Format    "x(35)".   /*A55-0125*/
DEF VAR    n_text       As   Char    Format    "x(35)".
Def VAR    n_chkname    As   Char    Format    "x(35)".
DEFINE VAR vAcProc_fil  AS   CHAR.
/*DEFINE VAR vAcProc_fil1 AS   CHAR.  /*A57-0063*/*/
DEFINE VAR vAcProc_fil2 AS   CHAR.
DEFINE VAR vAcProc_fil3 AS   CHAR.  /*A56-0024*/
DEFINE VAR vAcProc_fil4 AS   CHAR.  /*A57-0063*/
DEFINE VAR vAcProc_fil5 AS   CHAR.  /*A57-0063*/
DEFINE VAR nv_cartyp    AS   CHAR.  /*A57-0063*/
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
DEF VAR nv_seq         AS INTEGER  INIT  1.
DEF VAR nv_sum         AS INTEGER  INIT  0.
DEF VAR nv_checkdigit  AS INTEGER .
DEF VAR nv_benname      AS   CHAR    FORMAT    "x(60)".  /*A56-0024*/
DEF VAR n_producernew   As   Char    Format    "x(10)".  /*A56-0024*/
DEF VAR n_produceruse   As   Char    Format    "x(10)".  /*A56-0024*/
DEF VAR n_producerbike  As   Char    Format    "x(10)".  /*A57-0063*/
DEF VAR n_agent         As   Char    Format    "x(10)".  /*A56-0024*/

/* Begin by Phaiboon W. [A59-0488] Date 07/11/2016 */
DEF VAR n_chk     AS LOG.
DEF VAR n_quota   AS CHAR.
DEF VAR n_garage  AS CHAR.
DEF VAR n_remark1 AS CHAR.
DEF VAR n_remark2 AS CHAR.
DEF VAR n_other1  AS CHAR.
DEF VAR n_other2  AS CHAR.
DEF VAR n_other3  AS CHAR.
DEF VAR vAcproc_fil6 AS CHAR.
DEF VAR nv_ispstatus AS CHAR.
/* End by Phaiboon W. [A59-0488] Date 07/11/2016 */

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

/* add by A62-0219 */
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
DEF VAR n_day AS INT INIT 0.
DEF VAR nv_sumsi AS DECI INIT 0.
DEF VAR nv_insi AS DECI INIT 0.
DEF VAR nv_provin AS CHAR FORMAT "x(10)" .
DEF VAR nv_key3 AS CHAR FORMAT "x(35)" .
/* end A62-0219 */

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
     FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE fi_text10 AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 5 BY .91
     FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE fi_text2 AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 8 BY .91
     FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE fi_text3 AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 5.17 BY .91
     FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE fi_text4 AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 5.17 BY .91
     FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE fi_text5 AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 5 BY .91
     FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE fi_text6 AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 5 BY .91
     FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE fi_text7 AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 5.17 BY .91
     FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE fi_text8 AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 5.17 BY .91
     FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE fi_text9 AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 5 BY .91
     FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE ra_sex1 AS INTEGER 
     VIEW-AS RADIO-SET VERTICAL
     RADIO-BUTTONS 
          "Male", 1,
"Female", 2
     SIZE 10 BY 1
     BGCOLOR 29 FGCOLOR 2 FONT 7 NO-UNDO.

DEFINE VARIABLE ra_sex2 AS INTEGER 
     VIEW-AS RADIO-SET VERTICAL
     RADIO-BUTTONS 
          "Male", 1,
"Female", 2
     SIZE 10 BY 1
     BGCOLOR 29 FGCOLOR 2 FONT 7 NO-UNDO.

DEFINE BUTTON buselecom 
     IMAGE-UP FILE "i:/safety/walp10/wimage/next.bmp":U
     LABEL "" 
     SIZE 3.5 BY .95.

DEFINE BUTTON bu_brand 
     IMAGE-UP FILE "I:/Safety/WALP10/WIMAGE/next.bmp":U
     LABEL "" 
     SIZE 4 BY .95.

DEFINE BUTTON bu_cam 
     IMAGE-UP FILE "I:/Safety/WALP10/WIMAGE/next.bmp":U
     LABEL "" 
     SIZE 3.5 BY .95.

DEFINE BUTTON bu_cov 
     IMAGE-UP FILE "I:/Safety/WALP10/WIMAGE/next.bmp":U
     LABEL "" 
     SIZE 3.5 BY .95.

DEFINE BUTTON bu_create 
     LABEL "Create" 
     SIZE 8 BY 1.19
     BGCOLOR 6 FGCOLOR 2 FONT 6.

DEFINE BUTTON bu_exit 
     LABEL "Exit" 
     SIZE 8 BY .95
     FONT 6.

DEFINE BUTTON bu_notes 
     LABEL "Notes" 
     SIZE 7 BY .95.

DEFINE BUTTON bu_product 
     IMAGE-UP FILE "I:/Safety/WALP10/WIMAGE/next.bmp":U
     LABEL "" 
     SIZE 3.5 BY .95.

DEFINE BUTTON bu_save 
     LABEL "Save" 
     SIZE 8 BY .95
     FONT 6.

DEFINE BUTTON cmtoubu_quo 
     LABEL "Quotation" 
     SIZE 12.33 BY 1
     BGCOLOR 2 FGCOLOR 7 FONT 6.

DEFINE VARIABLE co_addr AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS COMBO-BOX INNER-LINES 10
     DROP-DOWN-LIST
     SIZE 15 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE co_benname AS CHARACTER FORMAT "X(60)":U 
     VIEW-AS COMBO-BOX INNER-LINES 5
     DROP-DOWN-LIST
     SIZE 47 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE co_caruse AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS COMBO-BOX INNER-LINES 6
     DROP-DOWN-LIST
     SIZE 19.5 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE co_garage AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 5
     DROP-DOWN-LIST
     SIZE 24.67 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE co_provin AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS COMBO-BOX INNER-LINES 8
     DROP-DOWN-LIST
     SIZE 24.5 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE co_title AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS COMBO-BOX INNER-LINES 6
     DROP-DOWN-LIST
     SIZE 15.67 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE co_user AS CHARACTER FORMAT "X(60)":U 
     VIEW-AS COMBO-BOX INNER-LINES 5
     DROP-DOWN-LIST
     SIZE 22.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_age AS INTEGER FORMAT "->>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 4.5 BY .91
     BGCOLOR 19 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_agent AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 12 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_baseod AS DECIMAL FORMAT "->>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 13 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_benname AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 47 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_birthday AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 14.5 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_brand AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 18.5 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_campaign AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 13 BY .95
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
     SIZE 4 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_comco AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 9 BY .95
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_comdat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_cover1 AS CHARACTER FORMAT "X(3)":U 
     VIEW-AS FILL-IN 
     SIZE 5 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_deler AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 12 BY .95
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
     SIZE 14 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_garage AS CHARACTER FORMAT "X(1)":U 
     VIEW-AS FILL-IN 
     SIZE 4.5 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_idno AS CHARACTER FORMAT "X(13)":U 
     VIEW-AS FILL-IN 
     SIZE 16 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_idnoexpdat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 13.5 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_insadd1build AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 27 BY .95
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
     SIZE 12.5 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_ins_off AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 22 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_ispno AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 19 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_ispstatus AS CHARACTER FORMAT "X(1)":U 
     VIEW-AS FILL-IN 
     SIZE 4.67 BY .95
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
     SIZE 17 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_notno72 AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 17 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_nottim AS CHARACTER FORMAT "X(13)":U 
     VIEW-AS FILL-IN 
     SIZE 10 BY .95
     BGCOLOR 8 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_occup AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 24 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_other2 AS DECIMAL FORMAT "->,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 25.5 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_other3 AS CHARACTER FORMAT "X(60)":U 
     VIEW-AS FILL-IN 
     SIZE 57.83 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_pack AS CHARACTER FORMAT "X(1)":U 
     VIEW-AS FILL-IN 
     SIZE 3.5 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_power AS DECIMAL FORMAT ">>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN NATIVE 
     SIZE 10 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_precomp AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 11 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_preinsur AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 28 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_preinsur2 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 21.67 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_premium AS DECIMAL FORMAT "->,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 15.17 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_producer AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 12 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_product AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 6 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_quo AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 18.67 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_recipname AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 35 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_redbook AS CHARACTER FORMAT "X(13)":U 
     VIEW-AS FILL-IN 
     SIZE 16 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_refer AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 17 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_remark1 AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 60.33 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_remark2 AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 60.33 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_stk AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 16 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_sumfi AS DECIMAL FORMAT "->>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 16.5 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_sumsi AS DECIMAL FORMAT "->>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 16.5 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_totlepre AS DECIMAL FORMAT "->,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 19.5 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_user AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 7.5 BY .95
     BGCOLOR 18  NO-UNDO.

DEFINE VARIABLE fi_user2 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 23.33 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_vatcode AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 12 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_year AS CHARACTER FORMAT "X(4)":U INITIAL "0" 
     VIEW-AS FILL-IN 
     SIZE 6.5 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE ra_comp AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "แถม", 1,
"ไม่แถม", 2,
"ไม่เอาพรบ.", 3
     SIZE 32 BY .95
     BGCOLOR 29 FGCOLOR 1 FONT 6 NO-UNDO.

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
"Usecar", 2,
"BIKE", 3
     SIZE 27.67 BY .95
     BGCOLOR 14 FGCOLOR 7 FONT 6 NO-UNDO.

DEFINE VARIABLE ra_driv AS INTEGER 
     VIEW-AS RADIO-SET VERTICAL
     RADIO-BUTTONS 
          "ไม่ระบุ", 1,
"ระบุ", 2
     SIZE 9.83 BY 2.33
     BGCOLOR 29 FGCOLOR 1 FONT 6 NO-UNDO.

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
     SIZE 19.33 BY .95
     BGCOLOR 29 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-483
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 115.5 BY 5.38
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-487
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 38.5 BY 2.19
     BGCOLOR 2 FGCOLOR 7 .

DEFINE RECTANGLE RECT-488
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 115.5 BY 5.29
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-489
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 115.5 BY 5.29
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-490
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 115.5 BY 14.19
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-499
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 32 BY 1.91
     BGCOLOR 3 FGCOLOR 7 .

DEFINE RECTANGLE RECT-500
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 10 BY 1.67
     BGCOLOR 2 .

DEFINE RECTANGLE RECT-501
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 10 BY 1.67
     BGCOLOR 6 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     fi_ins_off AT ROW 2.29 COL 16 COLON-ALIGNED NO-LABEL
     fi_comco AT ROW 2.29 COL 49.33 COLON-ALIGNED NO-LABEL
     buselecom AT ROW 2.29 COL 60.67
     fi_cmrcode AT ROW 2.29 COL 68.33 COLON-ALIGNED NO-LABEL
     fi_cmrcode2 AT ROW 2.29 COL 95.5 COLON-ALIGNED NO-LABEL
     fi_cover1 AT ROW 2.24 COL 117 COLON-ALIGNED NO-LABEL
     bu_cov AT ROW 2.24 COL 124.17
     co_caruse AT ROW 3.33 COL 16 COLON-ALIGNED NO-LABEL
     ra_cover AT ROW 3.33 COL 37.83 NO-LABEL
     fi_campaign AT ROW 3.29 COL 75 COLON-ALIGNED NO-LABEL
     bu_cam AT ROW 3.29 COL 90 WIDGET-ID 24
     ra_pa AT ROW 3.33 COL 94 NO-LABEL
     fi_product AT ROW 3.33 COL 120.83 COLON-ALIGNED NO-LABEL
     bu_product AT ROW 3.33 COL 128.83
     ra_pree AT ROW 4.43 COL 18 NO-LABEL
     ra_comp AT ROW 4.43 COL 46.67 NO-LABEL
     fi_producer AT ROW 5.43 COL 16 COLON-ALIGNED NO-LABEL
     fi_agent AT ROW 5.43 COL 36.83 COLON-ALIGNED NO-LABEL
     fi_deler AT ROW 5.43 COL 57.5 COLON-ALIGNED NO-LABEL
     fi_cmrsty AT ROW 5.38 COL 78.67 COLON-ALIGNED NO-LABEL
     fi_quo AT ROW 6.81 COL 23.17 COLON-ALIGNED NO-LABEL
     cmtoubu_quo AT ROW 6.76 COL 44
     co_garage AT ROW 6.71 COL 71.33 COLON-ALIGNED NO-LABEL
     co_title AT ROW 7.81 COL 16 COLON-ALIGNED NO-LABEL WIDGET-ID 64
     fi_institle AT ROW 7.81 COL 31.83 COLON-ALIGNED NO-LABEL
     fi_preinsur AT ROW 7.81 COL 48.83 COLON-ALIGNED NO-LABEL
     fi_preinsur2 AT ROW 7.81 COL 85.83 COLON-ALIGNED NO-LABEL
     fi_idno AT ROW 7.81 COL 114.5 COLON-ALIGNED NO-LABEL
     fi_birthday AT ROW 8.81 COL 16 COLON-ALIGNED NO-LABEL
     fi_age AT ROW 8.81 COL 35.5 COLON-ALIGNED NO-LABEL
     fi_idnoexpdat AT ROW 8.81 COL 52.5 COLON-ALIGNED NO-LABEL
     fi_occup AT ROW 8.81 COL 72.83 COLON-ALIGNED NO-LABEL
     fi_namedrirect AT ROW 8.81 COL 108.5 COLON-ALIGNED NO-LABEL
     fi_insadd1no AT ROW 9.81 COL 16 COLON-ALIGNED NO-LABEL
     fi_insadd1mu AT ROW 9.81 COL 31.67 COLON-ALIGNED NO-LABEL
     co_addr AT ROW 9.76 COL 36.67 COLON-ALIGNED NO-LABEL
     fi_insadd1build AT ROW 9.81 COL 52.17 COLON-ALIGNED NO-LABEL
     fi_insadd1soy AT ROW 9.81 COL 84.17 COLON-ALIGNED NO-LABEL
     fi_insadd1road AT ROW 9.81 COL 109.67 COLON-ALIGNED NO-LABEL
     fi_insadd2tam AT ROW 10.81 COL 16 COLON-ALIGNED NO-LABEL
     fi_insadd3amp AT ROW 10.81 COL 46.17 COLON-ALIGNED NO-LABEL
     fi_insadd4cunt AT ROW 10.81 COL 72.17 COLON-ALIGNED NO-LABEL
     fi_insadd5post AT ROW 10.81 COL 97.5 COLON-ALIGNED NO-LABEL
     fi_insadd6tel AT ROW 10.81 COL 114.5 COLON-ALIGNED NO-LABEL
     fi_comdat AT ROW 12.14 COL 32.33 COLON-ALIGNED NO-LABEL
     fi_expdat AT ROW 12.14 COL 67.33 COLON-ALIGNED NO-LABEL
     fi_ispno AT ROW 12.14 COL 98 COLON-ALIGNED NO-LABEL
     fi_ispstatus AT ROW 12.14 COL 117.33 COLON-ALIGNED NO-LABEL
     fi_brand AT ROW 13.14 COL 16 COLON-ALIGNED NO-LABEL
     bu_brand AT ROW 13.14 COL 37
     fi_model AT ROW 13.14 COL 47 COLON-ALIGNED NO-LABEL
     fi_year AT ROW 13.14 COL 97.67 COLON-ALIGNED NO-LABEL
     fi_power AT ROW 13.14 COL 115.33 COLON-ALIGNED NO-LABEL
     fi_licence1 AT ROW 14.14 COL 16 COLON-ALIGNED NO-LABEL
     fi_licence2 AT ROW 14.14 COL 22.17 COLON-ALIGNED NO-LABEL
     co_provin AT ROW 14.14 COL 29 COLON-ALIGNED NO-LABEL
     fi_cha_no AT ROW 14.14 COL 66.17 COLON-ALIGNED NO-LABEL
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1.17 ROW 1
         SIZE 132.5 BY 25.43
         BGCOLOR 1 FGCOLOR 1 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     fi_eng_no AT ROW 14.14 COL 108 COLON-ALIGNED NO-LABEL
     ra_driv AT ROW 15.24 COL 1.67 NO-LABEL
     fi_pack AT ROW 17.67 COL 16 COLON-ALIGNED NO-LABEL
     fi_class AT ROW 17.67 COL 27.17 COLON-ALIGNED NO-LABEL
     fi_garage AT ROW 17.67 COL 41.5 COLON-ALIGNED NO-LABEL
     fi_sumsi AT ROW 17.67 COL 57.83 COLON-ALIGNED NO-LABEL
     fi_sumfi AT ROW 17.67 COL 95 COLON-ALIGNED NO-LABEL WIDGET-ID 68
     fi_gap AT ROW 18.71 COL 16 COLON-ALIGNED NO-LABEL
     fi_premium AT ROW 18.67 COL 49 COLON-ALIGNED NO-LABEL
     fi_precomp AT ROW 18.67 COL 80 COLON-ALIGNED NO-LABEL
     fi_totlepre AT ROW 18.71 COL 104 COLON-ALIGNED NO-LABEL
     fi_baseod AT ROW 19.71 COL 16 COLON-ALIGNED NO-LABEL
     fi_stk AT ROW 19.67 COL 40 COLON-ALIGNED NO-LABEL
     fi_refer AT ROW 19.67 COL 67.5 COLON-ALIGNED NO-LABEL
     fi_recipname AT ROW 20.71 COL 15.67 COLON-ALIGNED NO-LABEL
     fi_vatcode AT ROW 20.71 COL 62.83 COLON-ALIGNED NO-LABEL
     fi_other2 AT ROW 20.71 COL 100.5 COLON-ALIGNED NO-LABEL
     fi_other3 AT ROW 21.71 COL 71.67 COLON-ALIGNED NO-LABEL
     fi_benname AT ROW 21.71 COL 15.67 COLON-ALIGNED NO-LABEL
     co_benname AT ROW 22.71 COL 15.67 COLON-ALIGNED NO-LABEL
     co_user AT ROW 22.71 COL 73.67 COLON-ALIGNED NO-LABEL
     fi_user2 AT ROW 22.71 COL 106.67 COLON-ALIGNED NO-LABEL
     fi_remark1 AT ROW 23.76 COL 15.67 COLON-ALIGNED NO-LABEL
     fi_remark2 AT ROW 24.76 COL 15.67 COLON-ALIGNED NO-LABEL
     fi_notno70 AT ROW 4.48 COL 93.33 COLON-ALIGNED NO-LABEL
     fi_notno72 AT ROW 5.38 COL 93.33 COLON-ALIGNED NO-LABEL
     bu_create AT ROW 4.71 COL 113.5
     bu_notes AT ROW 12.14 COL 125 WIDGET-ID 2
     ra_complete AT ROW 24.29 COL 80.33 NO-LABEL
     bu_save AT ROW 24.29 COL 111.83
     bu_exit AT ROW 24.29 COL 122.5
     fi_user AT ROW 5.33 COL 123 COLON-ALIGNED NO-LABEL
     fi_notdat AT ROW 1.19 COL 62.17 COLON-ALIGNED NO-LABEL
     fi_nottim AT ROW 1.19 COL 83.17 COLON-ALIGNED NO-LABEL
     fi_notino AT ROW 1.19 COL 30.5 COLON-ALIGNED NO-LABEL
     fi_redbook AT ROW 6.71 COL 109.67 COLON-ALIGNED NO-LABEL WIDGET-ID 72
     "รหัสบริษัท :":30 VIEW-AS TEXT
          SIZE 10.5 BY .95 AT ROW 2.29 COL 40.5
          BGCOLOR 19 FGCOLOR 4 FONT 6
     "ประเภทการซ่อม :":35 VIEW-AS TEXT
          SIZE 15 BY .91 AT ROW 6.76 COL 57.5 WIDGET-ID 22
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "สติ๊กเกอร์:":30 VIEW-AS TEXT
          SIZE 8.67 BY .95 AT ROW 19.67 COL 33
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " รุ่นรถ :":30 VIEW-AS TEXT
          SIZE 7 BY .95 AT ROW 13.14 COL 41.67
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " เลขตรวจสภาพ :":30 VIEW-AS TEXT
          SIZE 15 BY .95 AT ROW 12.14 COL 84.67
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " เลขตัวถังรถ:":20 VIEW-AS TEXT
          SIZE 12 BY .95 AT ROW 14.14 COL 55.67
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "วันหมดความคุ้มครอง :":35 VIEW-AS TEXT
          SIZE 19.5 BY .91 AT ROW 12.14 COL 49.67
          BGCOLOR 19 FGCOLOR 1 FONT 6
     " Eng CC :":30 VIEW-AS TEXT
          SIZE 10 BY .95 AT ROW 13.14 COL 106.83
          BGCOLOR 19 FGCOLOR 0 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1.17 ROW 1
         SIZE 132.5 BY 25.43
         BGCOLOR 1 FGCOLOR 1 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "ซอย":30 VIEW-AS TEXT
          SIZE 4 BY .95 AT ROW 9.81 COL 81.67
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "        Producer :":30 VIEW-AS TEXT
          SIZE 16 BY .95 AT ROW 5.43 COL 1.5
          BGCOLOR 19 FGCOLOR 4 FONT 6
     "ถนน:":30 VIEW-AS TEXT
          SIZE 5 BY .95 AT ROW 9.81 COL 105.83
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "":30 VIEW-AS TEXT
          SIZE 16 BY 1 AT ROW 22.67 COL 1.33 WIDGET-ID 12
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "อุปกรณ์ :":30 VIEW-AS TEXT
          SIZE 8.17 BY .95 AT ROW 21.71 COL 65.17 WIDGET-ID 66
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "   8.3  ไฟแนนซ์ :":30 VIEW-AS TEXT
          SIZE 16 BY .95 AT ROW 21.71 COL 1.33
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "    ข้อมูลแจ้งงาน :" VIEW-AS TEXT
          SIZE 16 BY 1 AT ROW 1.29 COL 1.5
          BGCOLOR 1 FGCOLOR 17 FONT 6
     "เบี้ยรวมพรบ.":30 VIEW-AS TEXT
          SIZE 11.5 BY .95 AT ROW 18.71 COL 94.33
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "ชื่อกรรมการ:":35 VIEW-AS TEXT
          SIZE 11 BY .95 AT ROW 8.81 COL 99.17
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "STY BR:":35 VIEW-AS TEXT
          SIZE 8.5 BY .95 AT ROW 5.43 COL 71.83
          BGCOLOR 19 FGCOLOR 4 FONT 6
     "REDBOOK:":35 VIEW-AS TEXT
          SIZE 11.5 BY .95 AT ROW 6.71 COL 99.83 WIDGET-ID 74
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "      ทะเบียนรถ :":30 VIEW-AS TEXT
          SIZE 16 BY .95 AT ROW 14.19 COL 1.5
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " Pol 70 :":35 VIEW-AS TEXT
          SIZE 8.17 BY .86 AT ROW 4.57 COL 86.5
          BGCOLOR 2 FGCOLOR 7 FONT 6
     "อำเภอ/เขต :":30 VIEW-AS TEXT
          SIZE 9.5 BY .95 AT ROW 10.81 COL 38.33
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "ID no :":35 VIEW-AS TEXT
          SIZE 6.5 BY .95 AT ROW 7.81 COL 109.83
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "Q No.":30 VIEW-AS TEXT
          SIZE 6.5 BY .86 AT ROW 6.81 COL 18.5
          BGCOLOR 3 FGCOLOR 7 FONT 6
     "อาชีพ:":35 VIEW-AS TEXT
          SIZE 6 BY .95 AT ROW 8.81 COL 68.5
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "     วันเดือนปีเกิด :":35 VIEW-AS TEXT
          SIZE 16 BY .95 AT ROW 8.81 COL 1.5
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "อายุ:":35 VIEW-AS TEXT
          SIZE 4 BY .91 AT ROW 8.81 COL 33
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "รหัส:":30 VIEW-AS TEXT
          SIZE 5 BY .95 AT ROW 10.81 COL 93.83
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " Deler :":30 VIEW-AS TEXT
          SIZE 8 BY .95 AT ROW 5.43 COL 51.33
          BGCOLOR 19 FGCOLOR 4 FONT 6
     "        Package :":35 VIEW-AS TEXT
          SIZE 16 BY .95 AT ROW 17.71 COL 1.5
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "userid :" VIEW-AS TEXT
          SIZE 7 BY .71 AT ROW 4.52 COL 125.17
          BGCOLOR 19 FONT 6
     " ข้อมูลประกันภัย :":30 VIEW-AS TEXT
          SIZE 16 BY 1 AT ROW 12.14 COL 1.33
          BGCOLOR 1 FGCOLOR 7 FONT 6
     "        ข้อมูลลูกค้า :" VIEW-AS TEXT
          SIZE 16 BY 1 AT ROW 6.76 COL 1.5
          BGCOLOR 1 FGCOLOR 7 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1.17 ROW 1
         SIZE 132.5 BY 25.43
         BGCOLOR 1 FGCOLOR 1 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "จังหวัด:":30 VIEW-AS TEXT
          SIZE 7 BY .95 AT ROW 10.81 COL 66.67
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " ผู้รับแจ้ง :":35 VIEW-AS TEXT
          SIZE 10 BY .95 AT ROW 22.76 COL 98.5 WIDGET-ID 10
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "      ตำบล/แขวง :":30 VIEW-AS TEXT
          SIZE 16 BY .95 AT ROW 10.81 COL 1.5
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "บัตรหมดอายุ:":35 VIEW-AS TEXT
          SIZE 12 BY .91 AT ROW 8.81 COL 42.33
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " Vatcode :":30 VIEW-AS TEXT
          SIZE 10.5 BY .95 AT ROW 20.71 COL 54
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "   ชื่อผู้แจ้ง MKT:":35 VIEW-AS TEXT
          SIZE 16 BY .95 AT ROW 2.33 COL 1.5
          BGCOLOR 19 FGCOLOR 4 FONT 6
     "NOTIFY DATE :":30 VIEW-AS TEXT
          SIZE 15 BY .95 AT ROW 1.19 COL 48.67
          BGCOLOR 19 FGCOLOR 6 FONT 6
     "         หมายเหตุ :":30 VIEW-AS TEXT
          SIZE 16 BY .95 AT ROW 23.71 COL 1.33
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "เลขเครื่องยนต์:":35 VIEW-AS TEXT
          SIZE 13 BY .95 AT ROW 14.14 COL 96.67
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "สาขาที่แจ้ง :":35 VIEW-AS TEXT
          SIZE 10 BY .95 AT ROW 22.76 COL 65.17
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "*** ENTRY DATA BY TELEPHONE ***" VIEW-AS TEXT
          SIZE 36.33 BY .91 AT ROW 1.19 COL 96.17
          BGCOLOR 1 FGCOLOR 7 FONT 6
     "":30 VIEW-AS TEXT
          SIZE 16 BY .95 AT ROW 24.67 COL 1.33 WIDGET-ID 14
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "Product:" VIEW-AS TEXT
          SIZE 8 BY .95 AT ROW 3.33 COL 114.67
          BGCOLOR 19 FGCOLOR 4 FONT 6
     "  ประเภทประกัน :":30 VIEW-AS TEXT
          SIZE 16 BY .95 AT ROW 3.38 COL 1.5
          BGCOLOR 19 FGCOLOR 4 FONT 6
     "  พรบ :":30 VIEW-AS TEXT
          SIZE 8 BY .95 AT ROW 4.43 COL 38.33
          BGCOLOR 19 FGCOLOR 4 FONT 6
     "ชื่อใบเสร็จในนาม:":35 VIEW-AS TEXT
          SIZE 16 BY .95 AT ROW 20.71 COL 1.33
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "         DEDUCT:":30 VIEW-AS TEXT
          SIZE 15.83 BY .95 AT ROW 19.71 COL 1.5
          BGCOLOR 19 FGCOLOR 4 FONT 6
     "อุปกรณ์เสริมคุ้มครองไม่เกิน :":30 VIEW-AS TEXT
          SIZE 25.17 BY .95 AT ROW 20.71 COL 77
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " Agent :":30 VIEW-AS TEXT
          SIZE 8 BY .95 AT ROW 5.43 COL 30.5
          BGCOLOR 19 FGCOLOR 4 FONT 6
     "Bth":30 VIEW-AS TEXT
          SIZE 3.5 BY .95 AT ROW 20.71 COL 128.5
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "การซ่อม :":35 VIEW-AS TEXT
          SIZE 8.5 BY .95 AT ROW 17.67 COL 34.67
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " ความคุ้มครอง :" VIEW-AS TEXT
          SIZE 14 BY .95 AT ROW 2.24 COL 104.5
          BGCOLOR 19 FGCOLOR 4 FONT 6
     "TIME :":30 VIEW-AS TEXT
          SIZE 6.17 BY .95 AT ROW 1.19 COL 78.5
          BGCOLOR 19 FGCOLOR 6 FONT 6
     "            ประกัน :":30 VIEW-AS TEXT
          SIZE 16 BY .95 AT ROW 4.43 COL 1.5
          BGCOLOR 19 FGCOLOR 4 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1.17 ROW 1
         SIZE 132.5 BY 25.43
         BGCOLOR 1 FGCOLOR 1 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "                คำนำ :":35 VIEW-AS TEXT
          SIZE 16 BY .95 AT ROW 7.81 COL 1.5
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "           เบี้ยสุทธิ :":30 VIEW-AS TEXT
          SIZE 16 BY .95 AT ROW 18.71 COL 1.5
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "           ยี่ห้อรถ  :":30 VIEW-AS TEXT
          SIZE 16 BY .95 AT ROW 13.19 COL 1.5
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "          บ้านเลขที่ :":30 VIEW-AS TEXT
          SIZE 16 BY .95 AT ROW 9.81 COL 1.5
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "  ปีรถ :":35 VIEW-AS TEXT
          SIZE 6.5 BY .95 AT ROW 13.14 COL 92.83
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "นามสกุล :":35 VIEW-AS TEXT
          SIZE 8 BY .91 AT ROW 7.81 COL 79.33
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "Refer no:":30 VIEW-AS TEXT
          SIZE 9 BY .95 AT ROW 19.67 COL 60.17
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "ชื่อ :":35 VIEW-AS TEXT
          SIZE 4 BY .91 AT ROW 7.81 COL 46.83
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " วันเริ่มคุ้มครอง :":35 VIEW-AS TEXT
          SIZE 15.33 BY .91 AT ROW 12.14 COL 18.67
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "หมู่ที่":30 VIEW-AS TEXT
          SIZE 4 BY .95 AT ROW 9.81 COL 29.17
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "Class :":35 VIEW-AS TEXT
          SIZE 6.5 BY .95 AT ROW 17.67 COL 22.17
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "NOTIFY NO:" VIEW-AS TEXT
          SIZE 13.5 BY .95 AT ROW 1.19 COL 18.83
          BGCOLOR 19 FGCOLOR 6 FONT 2
     " Pol 72 :":35 VIEW-AS TEXT
          SIZE 8.33 BY .86 AT ROW 5.33 COL 86.67
          BGCOLOR 2 FGCOLOR 7 FONT 6
     " ทุนสูญหาย/ไฟไหม้ :":30 VIEW-AS TEXT
          SIZE 17.67 BY .95 AT ROW 17.67 COL 78.5 WIDGET-ID 70
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "เบี้ยรวมภาษีอากร :":30 VIEW-AS TEXT
          SIZE 16 BY .95 AT ROW 18.67 COL 33.83
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " สาขา:":35 VIEW-AS TEXT
          SIZE 5.5 BY .95 AT ROW 2.29 COL 64.5
          BGCOLOR 19 FGCOLOR 4 FONT 6
     "Campaign :":35 VIEW-AS TEXT
          SIZE 11 BY .95 AT ROW 3.29 COL 65.83
          BGCOLOR 19 FGCOLOR 4 FONT 6
     "โทรศัพท์:":30 VIEW-AS TEXT
          SIZE 8 BY .95 AT ROW 10.81 COL 108.17
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "เบี้ย พรบ.:":30 VIEW-AS TEXT
          SIZE 10.5 BY .95 AT ROW 18.67 COL 71
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " ทุนประกัน :":30 VIEW-AS TEXT
          SIZE 11 BY .95 AT ROW 17.67 COL 48.5
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "รหัสสาขา:":35 VIEW-AS TEXT
          SIZE 8.5 BY .95 AT ROW 2.29 COL 88.67
          BGCOLOR 19 FGCOLOR 4 FONT 6
     RECT-483 AT ROW 1.14 COL 17.67
     RECT-487 AT ROW 4.29 COL 85.33
     RECT-488 AT ROW 6.62 COL 17.67 WIDGET-ID 4
     RECT-489 AT ROW 6.62 COL 17.67 WIDGET-ID 6
     RECT-490 AT ROW 12.05 COL 17.67 WIDGET-ID 8
     RECT-499 AT ROW 23.81 COL 78.67 WIDGET-ID 16
     RECT-500 AT ROW 23.95 COL 111 WIDGET-ID 18
     RECT-501 AT ROW 23.95 COL 121.5 WIDGET-ID 20
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1.17 ROW 1
         SIZE 132.5 BY 25.43
         BGCOLOR 1 FGCOLOR 1 .

DEFINE FRAME fr_driv
     fi_drivername1 AT ROW 1.14 COL 7.5 COLON-ALIGNED NO-LABEL
     ra_sex1 AT ROW 1.14 COL 38.5 NO-LABEL
     fi_hbdri1 AT ROW 1.14 COL 52.67 COLON-ALIGNED NO-LABEL
     fi_occupdriv1 AT ROW 1.14 COL 81.67 COLON-ALIGNED NO-LABEL
     fi_idnodriv1 AT ROW 1.14 COL 105.33 COLON-ALIGNED NO-LABEL
     fi_drivername2 AT ROW 2.24 COL 7.5 COLON-ALIGNED NO-LABEL
     ra_sex2 AT ROW 2.24 COL 38.5 NO-LABEL
     fi_hbdri2 AT ROW 2.24 COL 52.67 COLON-ALIGNED NO-LABEL
     fi_occupdriv2 AT ROW 2.24 COL 81.67 COLON-ALIGNED NO-LABEL
     fi_idnodriv2 AT ROW 2.24 COL 105.33 COLON-ALIGNED NO-LABEL
     fi_agedriv1 AT ROW 1.14 COL 71.33 COLON-ALIGNED NO-LABEL
     fi_agedriv2 AT ROW 2.24 COL 71.33 COLON-ALIGNED NO-LABEL
     fi_text1 AT ROW 1.14 COL 1.17 NO-LABEL
     fi_text2 AT ROW 2.24 COL 1.17 NO-LABEL
     fi_text3 AT ROW 1.14 COL 49 NO-LABEL
     fi_text4 AT ROW 2.24 COL 49 NO-LABEL
     fi_text5 AT ROW 1.14 COL 68 NO-LABEL
     fi_text6 AT ROW 2.24 COL 68 NO-LABEL
     fi_text7 AT ROW 1.14 COL 78.17 NO-LABEL
     fi_text8 AT ROW 2.24 COL 78.17 NO-LABEL
     fi_text9 AT ROW 1.14 COL 102 NO-LABEL
     fi_text10 AT ROW 2.24 COL 102 NO-LABEL
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         NO-LABELS SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 11.33 ROW 15.19
         SIZE 121.5 BY 2.45
         BGCOLOR 10 .


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
         TITLE              = "IMPORT DATA BY TELEPHONE ..."
         HEIGHT             = 25.57
         WIDTH              = 133
         MAX-HEIGHT         = 26.67
         MAX-WIDTH          = 133
         VIRTUAL-HEIGHT     = 26.67
         VIRTUAL-WIDTH      = 133
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
IF NOT wgwimpon:LOAD-ICON("wimage\safety":U) THEN
    MESSAGE "Unable to load icon: wimage\safety"
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
ON END-ERROR OF wgwimpon /* IMPORT DATA BY TELEPHONE ... */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wgwimpon wgwimpon
ON WINDOW-CLOSE OF wgwimpon /* IMPORT DATA BY TELEPHONE ... */
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
        n_text  = "exit"
        n_chkname = "1". 
    IF fi_comco = "" THEN DO:
        RUN wgw\wgwhpcom (INPUT-OUTPUT n_name,
                          INPUT-OUTPUT n_nO1,
                          INPUT-OUTPUT n_nO2,
                          INPUT-OUTPUT n_nO3,           /*kridtiya i. A55-0125*/
                          INPUT-OUTPUT nv_benname,
                          INPUT-OUTPUT n_producernew,   /*kridtiya i. A56-0024*/
                          INPUT-OUTPUT n_produceruse,   /*kridtiya i. A56-0024*/
                          INPUT-OUTPUT n_producerbike,  /*kridtiya i. A57-0063*/
                          INPUT-OUTPUT n_agent,         /*kridtiya i. A56-0024*/
                          INPUT-OUTPUT n_text).
        IF n_text  = "save" THEN
            Assign 
            fi_benname   = nv_benname   /*A56-0024*/
            co_benname   = nv_benname   /* add by Phaiboon W. [A59-0488] Date 18/11/2016 */
            fi_cmrcode2  = n_nO1
            fi_cmrcode   = n_nO2
            fi_cmrsty    = n_nO3       /*kridtiya i. A55-0125*/
            fi_comco     = gComp .
    END.
    ELSE DO:
        RUN wgw\wgwhpcom (INPUT-OUTPUT n_name,
                          INPUT-OUTPUT n_nO1,
                          INPUT-OUTPUT n_nO2,
                          INPUT-OUTPUT n_nO3,          /*kridtiya i. A55-0125*/
                          INPUT-OUTPUT nv_benname,     
                          INPUT-OUTPUT n_producernew,  /*kridtiya i. A56-0024*/
                          INPUT-OUTPUT n_produceruse,  /*kridtiya i. A56-0024*/
                          INPUT-OUTPUT n_producerbike, /*kridtiya i. A57-0063*/
                          INPUT-OUTPUT n_agent,        /*kridtiya i. A56-0024*/
                          INPUT-OUTPUT n_text).
        IF n_text  = "save" THEN
            Assign 
            fi_benname   = nv_benname    /*A56-0024*/
            co_benname   = nv_benname   /* add by Phaiboon W. [A59-0488] Date 18/11/2016 */
            fi_cmrcode2  = n_nO1
            fi_cmrcode   = n_nO2
            fi_cmrsty    = n_nO3       /*kridtiya i. A55-0125*/
            fi_comco     = gComp .
        ELSE DO:
            FIND FIRST brstat.company WHERE brstat.Company.CompNo = trim(fi_comco) NO-LOCK NO-ERROR NO-WAIT.
            IF NOT AVAIL brstat.company THEN DO: 
                RUN wgw\wgwhpcom (INPUT-OUTPUT n_name,
                                  INPUT-OUTPUT n_nO1,
                                  INPUT-OUTPUT n_nO2,
                                  INPUT-OUTPUT n_nO3,           /*kridtiya i. A55-0125*/
                                  INPUT-OUTPUT nv_benname,
                                  INPUT-OUTPUT n_producernew,   /*kridtiya i. A56-0024*/
                                  INPUT-OUTPUT n_produceruse,   /*kridtiya i. A56-0024*/
                                  INPUT-OUTPUT n_producerbike,  /*kridtiya i. A57-0063*/
                                  INPUT-OUTPUT n_agent,         /*kridtiya i. A56-0024*/
                                  INPUT-OUTPUT n_text).
                Assign 
                    fi_benname  = nv_benname    /*A56-0024*/
                    co_benname  = nv_benname   /* add by Phaiboon W. [A59-0488] Date 18/11/2016 */
                    fi_cmrcode2 = n_nO1
                    fi_cmrcode  = n_nO2
                    fi_cmrsty   = n_nO3       /*kridtiya i. A55-0125*/
                    fi_comco    = gComp.
            END.
        END.
    END.
    IF fi_comco = "" THEN DO:
        APPLY "entry" TO fi_comco . 
        RETURN NO-APPLY.
    END.
    ELSE DO:
        IF ra_cover = 1 THEN                  /* new car */         
            ASSIGN 
            /*fi_pack  = "G"    */    /*A63-0392*/
            fi_pack         = "T"     /*A63-0392*/
            fi_producer     = n_producernew   
            fi_agent        = n_agent    .    
        ELSE IF ra_cover    = 2 THEN          /* use car */
            ASSIGN                            
            fi_producer = n_produceruse       
            fi_agent    = n_agent    .        
        ELSE ASSIGN                           /* bike =  3 */
            fi_producer = n_producerbike      /*A57-0063*/
            fi_agent    = n_agent    .        /*A57-0063*/
        /*A56-0024................
        IF fi_comco = "scb" THEN DO:
            ASSIGN fi_benname = "ธนาคารไทยพาณิชย์ จำกัด (มหาชน)".
                /*IF ra_cover = 1 THEN
                    ASSIGN 
                    fi_producer  = "B3M0009"
                    fi_agent   = "B3M0009".
                ELSE ASSIGN 
                    fi_producer  = "B3M0010"
                    fi_agent   = "B3M0009"  .*/
        END.
        ELSE IF fi_comco = "aycal" THEN DO:
            ASSIGN fi_benname = "บริษัท อยุธยา แคปปิตอล ออโต้ลิส จำกัด(มหาชน)" .
            /*IF ra_cover = 1 THEN
                    ASSIGN 
                    fi_producer = "A0M0061"
                    fi_agent  = "B300303".
                ELSE ASSIGN 
                    fi_producer = "A0M1011"
                    fi_agent  = "B300303" .*/
        END.
        ELSE IF fi_comco = "TCR" THEN DO:
            ASSIGN fi_benname = "ธนาคาร ไทยเครดิต เพื่อรายย่อย จำกัด (มหาชน)".
                /*IF ra_cover = 1 THEN
                    ASSIGN 
                    fi_producer = "B3M0013"
                    fi_agent  = "B3M0013".
                ELSE ASSIGN 
                    fi_producer = "B3M0014"
                    fi_agent  = "B3M0013".*/
        END.
        ELSE IF fi_comco = "ASK" THEN DO:
            ASSIGN fi_benname = "บริษัท เอเซียเสริมกิจลีสซิ่ง จำกัด (มหาชน)".
                /*IF ra_cover = 1 THEN
                    ASSIGN 
                    fi_producer = "A0M1004"
                    fi_agent  = "B300303".
                ELSE ASSIGN 
                    fi_producer = "A0M1004"
                    fi_agent  = "B300303"  .*/
        END.
        ELSE IF fi_comco = "BGPL" THEN DO:
            ASSIGN fi_benname = "บริษัท กรุงเทพแกรนด์แปซิฟิคลีส จำกัด ( มหาชน)".
                /*IF ra_cover = 1 THEN
                    ASSIGN 
                    fi_producer = "A000774"
                    fi_agent  = "B300303".
                ELSE ASSIGN 
                    fi_producer = "A000774"
                    fi_agent  = "B300303" .*/
        END.
        ELSE IF fi_comco = "RTN" THEN DO:
                ASSIGN fi_benname = "บริษัท ราชธานี ลีสซิ่ง จำกัด (มหาชน)".
                /*IF ra_cover = 1 THEN
                    ASSIGN 
                    fi_producer = "A0M0069"
                    fi_agent  = "B300303".
                ELSE ASSIGN 
                    fi_producer = "A0M1002"
                    fi_agent  = "B300303".*/
        END.*/
    END.
    IF fi_cmrsty = "" THEN ASSIGN fi_cmrsty = "M".
    ASSIGN n_brsty   = fi_cmrsty.    /*A55-0125*/
    Disp fi_comco fi_producer fi_agent fi_benname   fi_cmrcode2  fi_cmrcode  fi_cmrsty  co_benname with FRAM fr_main.
    APPLY "entry" TO fi_cmrcode . 
    RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_brand
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_brand wgwimpon
ON CHOOSE OF bu_brand IN FRAME fr_main
DO:
    Run  wgw\wgwhpmod(Input-output  fi_model,    
                      INPUT-OUTPUT  fi_brand,    
                      Input-output  fi_year,     
                      Input-output  fi_power,
                      OUTPUT fi_redbook, /*A62-0219*/ 
                      OUTPUT nv_sumsi ). /*A62-0219*/

    
    IF fi_cover1 = "1" AND fi_quo = "" THEN 
        ASSIGN fi_sumsi =  nv_sumsi 
               fi_sumfi =  nv_sumsi . /* a62-0219 */

    Disp fi_brand fi_model fi_year fi_power fi_redbook fi_sumsi fi_sumfi /*A62-0219*/  with frame  fr_main.

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
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_cam wgwimpon
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
                      input-output  n_43 ).

    IF n_campno <> ""   THEN DO:
       /* IF  trim(n_company) <> "" AND trim(n_company) <> trim(fi_comco) THEN DO:*/
        IF  trim(n_company) <> "" AND INDEX(n_company,fi_comco) = 0 THEN DO:
            MESSAGE " Campaign Code Use for Company :" n_company " Only ! " VIEW-AS ALERT-BOX.
            Apply "Entry"  To  fi_campaign.
            Return no-apply.
        END.
        ELSE DO:
            ASSIGN fi_campaign  = n_campno
                   co_garage    = "ซ่อม" + trim(n_gar)
                   fi_pack      = SUBSTR(n_pack,1,1)
                   fi_class     = SUBSTR(n_pack,2,3)
                   fi_garage    = IF trim(n_gar) = "ห้าง" THEN "G" ELSE "" 
                   fi_sumsi     = 0 
                   fi_sumfi     = 0
                   fi_gap       = 0 
                   fi_premium   = 0 
                   fi_precomp   = 0 
                   fi_totlepre  = 0
                   fi_baseod    = 0
                   fi_quo       = "".
           IF fi_cover1 = "1" AND fi_garage = "G" THEN ASSIGN  fi_pack = "U" .  /*a63-0392 */
           ELSE ASSIGN fi_pack = "T" .                                          /*a63-0392 */
        END.
    END.
        
    DISP fi_cover1 fi_campaign co_garage  fi_pack  fi_class  fi_garage fi_quo fi_sumfi
         fi_sumsi  fi_gap  fi_premium  fi_precomp  fi_totlepre fi_baseod with frame  fr_main.
    Apply "Entry"  To ra_pa.
    Return no-apply.
/* end a62-0219*/
                    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_cov
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_cov wgwimpon
ON CHOOSE OF bu_cov IN FRAME fr_main
DO:
    Run  wgw\wgwhpco1(Input-output  fi_cover1).
    /*Add kridtiya i.A55-0108 */
  /*/* A56-0024 */
  IF      fi_comco = "SCB"   THEN fi_benname = "ธนาคารไทยพาณิชย์ จำกัด (มหาชน)".
  ELSE IF fi_comco = "AYCAL" THEN fi_benname = "บริษัท อยุธยา แคปปิตอล ออโต้ลิส จำกัด(มหาชน)".
  ELSE IF fi_comco = "TCR"   THEN fi_benname = "ธนาคาร ไทยเครดิต เพื่อรายย่อย จำกัด (มหาชน)".
  ELSE IF fi_comco = "ASK"   THEN fi_benname = "บริษัท เอเซียเสริมกิจลีสซิ่ง จำกัด (มหาชน)".
  ELSE IF fi_comco = "BGPL"  THEN fi_benname = "บริษัท กรุงเทพแกรนด์แปซิฟิคลีส จำกัด ( มหาชน)".
  ELSE IF fi_comco = "RTN"   THEN fi_benname = "บริษัท ราชธานี ลีสซิ่ง จำกัด (มหาชน)".
  ELSE fi_benname = "".
  /* A56-0024 */ ......*/
    /*ASSIGN fi_benname   = nv_benname.   /*A56-0024*/*/
    /* comment by ranu i A63-0392....
    IF      fi_cover1 = "1" THEN ASSIGN fi_pack = "G".
    ELSE IF fi_cover1 = "2" THEN ASSIGN fi_pack = "Y".
    ELSE IF fi_cover1 = "3" THEN 
        ASSIGN fi_pack     = "R" 
               fi_benname  = "" .
    ELSE IF fi_cover1 = "5"    THEN ASSIGN fi_pack = "B".
    /*ELSE IF nv_cartyp = "BIKE" THEN ASSIGN fi_pack = "Z" .*/ /*A57-0063*/
    IF (nv_cartyp = "BIKE(บุคคล)") OR (nv_cartyp = "BIKE(พาณิชย์)")  THEN ASSIGN fi_pack = "Z" .  /*Add kridtiya i.A55-0108 */
    /*Add kridtiya i.A55-0108 */
    IF fi_cover1    = "3" THEN ASSIGN fi_benname  = "" .
    ELSE ASSIGN  fi_benname   = nv_benname .    /*A56-0024*/
    ... end A63-0392..*/

    /* add by A62-0219 */
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
    /* end A62-0219*/

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
            WHEN TRUE THEN  /* Yes */ 
                DO:
                ASSIGN n_br    = "".
                /*nv_check70 = "NO" .*/
                FIND FIRST brstat.company WHERE Company.CompNo = fi_comco NO-LOCK NO-ERROR NO-WAIT.
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
                                    sicuw.uwm100.policy = fi_notno70 NO-LOCK NO-ERROR.
                                IF NOT AVAIL sicuw.uwm100 THEN LEAVE running_polno.
                                ELSE NEXT running_polno.
                            END.
                            ELSE NEXT running_polno.

                        END. 
                        /****comment by Kridtiya i. A55-0257.....
                        FIND LAST  brstat.tlt    WHERE 
                            tlt.genusr        = "Phone"           AND
                            tlt.policy        = caps(fi_notno70)  NO-ERROR NO-WAIT.
                        IF NOT AVAIL brstat.tlt THEN DO:
                            CREATE brstat.tlt.
                            ASSIGN 
                                tlt.genusr        = "Phone"     
                                tlt.nor_noti_tlt  = "PHONE" + STRING(TODAY,"99/99/9999") + string(TIME,"HH:MM:SS") 
                                fi_notino         = "PHONE" + STRING(TODAY,"99/99/9999") + string(TIME,"HH:MM:SS")
                                tlt.policy        = CAPS(fi_notno70)
                                fi_notno70        = CAPS(fi_notno70)
                                tlt.nor_usr_ins   = INPUT fi_ins_off
                                tlt.lotno         = INPUT fi_comco 
                                tlt.nor_noti_ins  = Input fi_cmrcode 
                                tlt.nor_usr_tlt   = Input fi_cmrcode2
                                tlt.trndat        = TODAY
                                tlt.trntime       = SUBSTR(fi_notino,16)
                                fi_nottim         = SUBSTR(fi_notino,16)
                                tlt.usrid         = USERID(LDBNAME(1))       
                                tlt.imp           = "IM"                    
                                tlt.releas        = "No"   
                                nv_check70        = "yes"tlt.subins        = trim(Input fi_campaign)
                                tlt.safe1         = IF  ra_car  = 1 THEN "เก๋ง" 
                                                    ELSE IF ra_car  = 2 THEN "กระบะ"    
                                                    ELSE "โดยสาร" 
                                tlt.filler1       = IF ra_pree = 1 THEN "แถม"
                                                    ELSE "ไม่แถม"
                                tlt.filler2       = IF      ra_comp = 1 THEN "แถม"
                                                    ELSE IF ra_comp = 2 THEN "ไม่แถม"  
                                                                        ELSE "ไม่เอาพรบ."
                                tlt.safe2         = IF    ra_cover  = 1 THEN "ป้ายแดง" 
                                                                        ELSE "use car" 
                                tlt.safe3         = trim(fi_cover1)
                                tlt.stat          = IF ra_pa = 1 THEN "" ELSE fi_product        /*A55-0073*/
                                tlt.comp_sub      = trim(Input fi_producer)        
                                tlt.recac         = trim(Input fi_agent) 
                                tlt.colorcod      = caps(trim(Input fi_cmrsty))      
                                tlt.comp_pol      = caps(trim(INPUT fi_notno72))
                                tlt.ins_name      = trim(INPUT fi_institle )  + " " +    
                                                    trim(INPUT fi_preinsur )  + " " +      
                                                    trim(Input fi_preinsur2 )
                                /*comment by Kridtiya i..A55-0125....
                                n_build           = IF n_build = "" THEN ""
                                                    ELSE IF ra_ban = 1 THEN "อาคาร"    +  TRIM(n_build) 
                                                    ELSE "หมู่บ้าน" +  TRIM(n_build)  
                                tlt.ins_addr1     = trim((IF n_banno = "" THEN "" ELSE "เลขที่ " + TRIM(n_banno)) + " " +  
                                                         (IF n_muno  = "" THEN "" ELSE "หมู่ "   + TRIM(n_muno))  + " " +  
                                                         (IF n_build = "" THEN "" ELSE TRIM(n_build)) + " " +  
                                                         (IF n_soy   = "" THEN "" ELSE "ซอย"    + TRIM(n_soy))   + " " +  
                                                         (IF n_road  = "" THEN "" ELSE "ถนน"    + TRIM(n_road)))
                                end..comment by Kridtiya i..A55-0125 ...*/
                                /*Kridtiya i. A55-0125*/
                                tlt.ins_addr1     =  (IF ra_ban = 1 THEN  /*ra_ban = 1  */
                                                trim((IF n_banno = "" THEN "" ELSE "เลขที่ " + TRIM(n_banno)) + " " +  
                                                     (IF n_muno  = "" THEN "" ELSE "หมู่ "   + TRIM(n_muno))  + " " +
                                                     (IF n_build = "" THEN "" ELSE "อาคาร"   + n_build )      + " " +  
                                                     (IF n_soy   = "" THEN "" ELSE "ซอย"     + TRIM(n_soy))   + " " +  
                                                     (IF n_road  = "" THEN "" ELSE "ถนน"     + TRIM(n_road))) 
                                                      ELSE      /*ra_ban = 2 */
                                                trim((IF n_banno = "" THEN "" ELSE "เลขที่ " + TRIM(n_banno)) + " " +  
                                                     (IF n_muno  = "" THEN "" ELSE "หมู่ "   + TRIM(n_muno))  + " " +
                                                     (IF n_build = "" THEN "" ELSE "หมู่บ้าน"  + n_build )    + " " +  
                                                     (IF n_soy   = "" THEN "" ELSE "ซอย"     + TRIM(n_soy))   + " " +  
                                                     (IF n_road  = "" THEN "" ELSE "ถนน"     + TRIM(n_road))))
                                /*Kridtiya i. A55-0125*/
                                tlt.ins_addr2     = trim(Input fi_insadd2tam)     
                                tlt.ins_addr3     = TRIM(input fi_insadd3amp)     
                                tlt.ins_addr4     = TRIM(Input fi_insadd4cunt)     
                                tlt.ins_addr5     = TRIM(Input fi_insadd5post)   
                                tlt.comp_noti_ins = TRIM(Input fi_insadd6tel)
                                tlt.nor_effdat    = INPUT fi_comdat         
                                tlt.expodat       = Input fi_expdat
                                tlt.dri_no2       = trim(INPUT fi_ispno)
                                tlt.brand         = Input co_brand            
                                tlt.model         = trim(Input fi_model)
                                tlt.lince2        = trim(Input fi_year) 
                                tlt.cc_weight     = INPUT fi_power
                                tlt.lince1        = INPUT fi_licence1 + " " +      
                                                    trim(INPUT fi_licence2) + " " +      
                                                    INPUT co_provin
                                tlt.cha_no        = Input fi_cha_no
                                tlt.eng_no        = INPUT fi_eng_no
                                tlt.lince3        = INPUT fi_pack  +        
                                                    trim(INPUT fi_class)         
                                tlt.exp           = trim(INPUT fi_garage)       
                                tlt.nor_coamt     = INPUT fi_sumsi 
                                tlt.dri_name2     = STRING(Input fi_gap )
                                tlt.nor_grprm     = INPUT fi_premium  
                                tlt.comp_coamt    = INPUT fi_precomp  
                                tlt.comp_grprm    = INPUT fi_totlepre
                                tlt.comp_sck      = trim(INPUT fi_stk)
                                tlt.comp_noti_tlt = trim(INPUT fi_refer)         
                                tlt.rec_name      = trim(Input fi_recipname)  
                                tlt.comp_usr_tlt  = trim(INPUT fi_vatcode) 
                                tlt.expousr       = IF co_user = "" THEN fi_user2 
                                                    ELSE co_user
                                tlt.comp_usr_ins  = trim(Input fi_benname)       
                                tlt.OLD_cha       = USERID(LDBNAME(1))  + ":" + trim(Input fi_remark1)        
                                tlt.OLD_eng       = IF ra_complete = 1 THEN "complete"
                                                    ELSE "not complete".
                            MESSAGE "Create Complete by..tlt "  VIEW-AS ALERT-BOX.
                            DISP fi_notino fi_nottim fi_notdat fi_notno70 WITH FRAM fr_main.
                            LEAVE running_polno.
                        END.   *************************************A55-0257  */
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


&Scoped-define SELF-NAME bu_notes
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_notes wgwimpon
ON CHOOSE OF bu_notes IN FRAME fr_main /* Notes */
DO:
    /* Begin by Phaiboon W. [A59-0625] Date 22/12/2016 */       
    ASSIGN              
        nv_year      = SUBSTR(STRING(YEAR(TODAY)),3,2) 

         /* real database */
        NotesServer  = "Safety_NotesServer/Safety"
        NotesApp     = "safety\uw\inspect" + nv_year + ".nsf"

        /* test database 
        NotesServer  = ""
        NotesApp     = "D:\Lotus\Notes\Data\inspect" + nv_year + ".nsf" */
       
        /*NotesView    = "เลขตัวถัง"*/ /*A62-0219*/
        NotesView    = "chassis_no" /*a62-0219*/
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
        nv_key1      = "" /*a62-0219*/
        nv_key2      = "" /*a62-0219*/
        nv_key3      = "" /*a62-0219*/
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
    IF TRIM(co_provin) <> "" THEN DO:
        FIND FIRST brstat.insure USE-INDEX Insure05   WHERE   /*use-index fname */
                brstat.insure.compno = "999" AND 
                brstat.insure.FName  = TRIM(co_provin) NO-LOCK NO-WAIT NO-ERROR.
            IF AVAIL brstat.insure THEN  ASSIGN nv_provin = brstat.Insure.LName.
            ELSE ASSIGN nv_provin = TRIM(co_provin).
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
                
        /*  comment by A62-0219  nv_branch      
        IF fi_notno70 <> "" THEN DO:                        
            IF SUBSTR(fi_notno70,1,1) >  "0" AND 
               SUBSTR(fi_notno70,1,1) <= "9" THEN nv_branch = SUBSTR(fi_notno70,1,2).
                                             ELSE nv_branch = SUBSTR(fi_notno70,2,1).
            RUN PD_BranchNotes.            
        END.
        end A62-0219 */
        /* A62-0219  nv_branch */       
        IF fi_notno70 <> ""  THEN DO:                        
            IF SUBSTR(fi_notno70,1,1) >  "0" AND 
               SUBSTR(fi_notno70,1,1) <= "9" THEN DO:  
                nv_branch = SUBSTR(fi_notno70,1,2).
                RUN PD_BranchNotes.    
            END. 
            ELSE IF SUBSTR(fi_notno70,1,1) =  "D" THEN DO:
                nv_branch = SUBSTR(fi_notno70,2,1).
                RUN PD_BranchNotes.    
            END.
            ELSE nv_branch = "" .
        END.
        IF nv_branch = ""  THEN RUN PD_BranchNotes. 
        /* end A62-0219*/
               
        /* nv_brname */
        FIND FIRST sicsyac.xmm600                               
             /*WHERE sicsyac.xmm600.acno = fi_agent NO-LOCK NO-ERROR.*/ /*A62-0219 */
            WHERE sicsyac.xmm600.acno = fi_producer NO-LOCK NO-ERROR. /*A62-0219 */
        IF AVAIL sicsyac.xmm600 THEN nv_brname = sicsyac.xmm600.NAME.
        /*----------*/
               
        /* nv_model nv_modelcode */
        /* comment by A62-0219......
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
        ........ end A62-0219.......*/
        /*----------------------*/
         
        /* nv_licence */  
        /* comment by A63-0392...
        IF LENGTH(nv_licence1) = 3 THEN                          
            nv_licence1 = SUBSTR(nv_licence1,1,1) + " " + SUBSTR(nv_licence1,2,2).
        ...end A63-0392...*/

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
                        nv_key2   = nv_licence1 + " " + co_provin.      /* PM */
                        nv_key3   = nv_licence1 + " " + nv_provin . /*A62-0219*/          /* PM */
                        
                        IF nv_key1 = nv_key2 OR nv_key1 = nv_key3 THEN DO:
                            /*nv_surcl  = chDocument:GetFirstItem("SurveyClose"):TEXT.  */ /*a62-0219*/
                            /* create by A62-0219 */
                            chitem       = chDocument:Getfirstitem("SurveyClose").    /* สเตตัสปิดเรื่อง */
                            IF chitem <> 0 THEN nv_surcl  = chitem:TEXT. 
                            ELSE nv_surcl = "".
                            /* end A62-0219 */
                            IF nv_surcl = "" THEN DO:                            
                                nv_docno  = chDocument:GetFirstItem("docno"):TEXT.
                                nv_chkdoc = NO.
                                /*nv_msgbox = "พบ เลขตัวถังกับเลขทะเบียนซ้ำที่เลข Doc. " + nv_docno.*/   /*A62-0219*/
                                nv_msgbox = "มีข้อมูลเลขตัวถังกับเลขทะเบียนในกล่อง ยังไม่ปิดเรื่อง " + nv_docno . /*a62-0219*/
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

                                /* end A62-0219 */
                               /* comment by A62-0219 .....
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
                                ...end A62-0219 ...*/
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
            /* add by A62-0219 */    
            IF nv_chkdoc = NO THEN DO:
                 ASSIGN                
                    nv_surdata  = ""   
                    nv_damlist  = ""   
                    nv_damage   = ""   
                    nv_detail   = ""   
                    nv_device   = ""   
                    nv_acctotal = "" . 
                IF nv_surcl <> "" THEN  RUN proc_getisp.
            /* end A62-0219 */
                FIND LAST brstat.tlt
                    WHERE brstat.tlt.nor_noti_tlt = fi_notino
                      AND brstat.tlt.genusr       = "Phone"  NO-ERROR NO-WAIT.
                IF AVAIL brstat.tlt THEN DO:
                    nv_chknotes = "L".
                    brstat.tlt.comp_noti_ins = TRIM(SUBSTR(brstat.tlt.comp_noti_ins,1,20)) 
                                      + FILL(" ", 20 - LENGTH(TRIM(SUBSTR(brstat.tlt.comp_noti_ins,1,20))))
                                      + nv_chknotes.
                    /* add by A62-0219 */
                    ASSIGN 
                    brstat.tlt.gentim        = trim(nv_detail + " " + nv_damage + " " + 
                                             nv_damlist + " " + nv_surdata + " " + nv_device + " " + nv_acctotal )   /* ผลตรวจสภาพ*/
                    brstat.tlt.dri_no2       = TRIM(nv_docno) + FILL(" ", 50 - LENGTH(TRIM(nv_docno))) + "Y"
                    fi_ispno          = nv_docno
                    fi_ispstatus      = IF fi_ispno = "" THEN "N" ELSE "Y" .
                    /* end A62-0219*/
                END.

                RELEASE brstat.tlt.            
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
                    /*chDocument:agentCode   = fi_agent   */ /*a62-0219*/  
                    chDocument:agentCode   = fi_producer     /*a62-0219*/  
                    chDocument:agentName   = nv_brname                           
                    chDocument:Premium     = fi_premium                          
                    /*chDocument:model       = nv_model */        /*A62-0219 */                 
                    /*chDocument:modelCode   = nv_modelcode  */   /*A62-0219 */
                    chDocument:model       = fi_brand             /*A62-0219 */                 
                    chDocument:modelCode   = fi_model             /*A62-0219 */ 
                    chDocument:Year        = fi_year                             
                    chDocument:carCC       = fi_cha_no                           
                    chDocument:LicenseType = "รถเก๋ง/กระบะ/บรรทุก"               
                    chDocument:PatternLi1  = nv_pattern                          
                    chDocument:LicenseNo_1 = nv_licence1                         
                    /*chDocument:LicenseNo_2 = co_provin */ /*A62-0219*/ 
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
                                                                                                    
                FIND LAST brstat.tlt
                    WHERE brstat.tlt.nor_noti_tlt = fi_notino
                      AND brstat.tlt.genusr       = "Phone"  NO-ERROR NO-WAIT.

                IF AVAIL brstat.tlt THEN DO:      
                    nv_chknotes       = "L".
                    brstat.tlt.comp_noti_ins = TRIM(SUBSTR(brstat.tlt.comp_noti_ins,1,20))                        
                                      + FILL(" ", 20 - LENGTH(TRIM(SUBSTR(brstat.tlt.comp_noti_ins,1,20))))
                                      + nv_chknotes. 
                END.                                                                                
                RELEASE brstat.tlt.                                                                        
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
    DISP fi_ispno fi_ispstatus WITH FRAME fr_main.
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
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_product wgwimpon
ON CHOOSE OF bu_product IN FRAME fr_main
DO:
    Run  wgw\wgwhppro(Input-output  fi_product).

    IF SUBSTR(fi_product,1,2) = "PA" OR SUBSTR(fi_product,1,2) = "PB" THEN ASSIGN ra_pa = 2. /*A63-0392*/

    Disp  fi_product ra_pa  with frame  fr_main.                                     
    Apply "Entry"  To  fi_product.
    Return no-apply. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_save
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_save wgwimpon
ON CHOOSE OF bu_save IN FRAME fr_main /* Save */
DO:
    DEF VAR n_sclass AS CHAR .
    /*comment by kridtiya i. A55-0257  comment to run proc_busave.....*/
    /*IF fi_notno70 = "" THEN DO:
    MESSAGE "คุณต้องการบันทึกข้อมูลใช่หรือไม่  !!!!" SKIP
    "กรุณาคีย์เลขกรมธรรม์ภาคสมัครใจ(Line70) !!!!" VIEW-AS ALERT-BOX  .  
    APPLY "entry" TO fi_notno70.
    RETURN NO-APPLY.
    END. */

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
    /* add by A62-0219 */
    IF      index(fi_cha_no,"-") <> 0 THEN ASSIGN fi_cha_no = REPLACE(fi_cha_no,"-","").
    ELSE IF index(fi_cha_no,"/") <> 0 THEN ASSIGN fi_cha_no = REPLACE(fi_cha_no,"/","").
    ELSE IF index(fi_cha_no," ") <> 0 THEN ASSIGN fi_cha_no = REPLACE(fi_cha_no," ","").

    IF      index(fi_eng_no,"-") <> 0 THEN ASSIGN fi_eng_no = REPLACE(fi_eng_no,"-","").
    ELSE IF index(fi_eng_no,"/") <> 0 THEN ASSIGN fi_eng_no = REPLACE(fi_eng_no,"/","").
    ELSE IF index(fi_eng_no," ") <> 0 THEN ASSIGN fi_eng_no = REPLACE(fi_eng_no," ","").
    
    IF fi_quo = "" AND fi_campaign = ""  THEN DO:

        n_sclass = TRIM(fi_pack) + TRIM(fi_class) .
        FIND FIRST stat.clastab_fil Use-index clastab01 Where
            stat.clastab_fil.class   = n_sclass      And
            stat.clastab_fil.covcod  = TRIM(fi_cover1) No-lock  No-error No-wait.
        IF avail stat.clastab_fil Then do:   
            IF substr(n_sclass,1,1) = "Z" THEN DO:
                Assign             
                n_tpp      = ""     
                n_tpa      = ""     
                n_tpd      = ""
                n_41       = ""
                n_42       = ""
                n_43       = "" .
            END.
            ELSE DO:
                ASSIGN      
                 n_tpp       = STRING(stat.clastab_fil.uom1_si)      
                 n_tpa       = STRING(stat.clastab_fil.uom2_si)      
                 n_tpd       = STRING(stat.clastab_fil.uom5_si).
                
                If  fi_garage  =  ""  THEN DO:
                    Assign 
                    n_41    =  string(stat.clastab_fil.si_41unp)
                    n_42    =  string(stat.clastab_fil.si_42)
                    n_43    =  string(stat.clastab_fil.si_43).
                END.
                Else If  fi_garage  = "G"  THEN DO:
                    Assign 
                    n_41   = string(stat.clastab_fil.si_41pai)
                    n_42   = string(stat.clastab_fil.si_42)    
                    n_43   = string(stat.clastab_fil.impsi_43).
                END.
            END.
        END.
    END.
  
    /* end A62-0219 */ 

    FIND LAST  brstat.tlt    WHERE 
        brstat.tlt.nor_noti_tlt  = fi_notino    AND
        brstat.tlt.genusr        = "Phone"      NO-ERROR NO-WAIT .
    IF  AVAIL brstat.tlt THEN DO:   /*proc_assign */
        ASSIGN 
            /*1 *//* brstat.tlt.nor_noti_tlt  = fi_notino   ..........A55-0257...
            /*2 */   brstat.tlt.trndat        = TODAY 
            /*3 */   brstat.tlt.trntime       = fi_nottim            A55-0257 ....*/
            /*4 */   brstat.tlt.nor_usr_ins   = trim(INPUT fi_ins_off)
            /*5 */   brstat.tlt.lotno         = trim(INPUT fi_comco) 
            /*6 */   brstat.tlt.nor_noti_ins  = trim(Input fi_cmrcode) 
            /*7 */   brstat.tlt.nor_usr_tlt   = trim(Input fi_cmrcode2)
            /*8 */   brstat.tlt.subins        = trim(Input fi_campaign)
            /*9 */   /*brstat.tlt.safe1         = IF      ra_car  = 1 THEN "เก๋ง" 
                                         ELSE IF ra_car  = 2 THEN "กระบะ"    
                                                             ELSE "โดยสาร" */
                     brstat.tlt.safe1         = co_caruse          /*A57-0063*/
            /*12*/   brstat.tlt.safe2         = IF      ra_cover  = 1 THEN "ป้ายแดง"
                                         ELSE IF ra_cover  = 2 THEN "use car"  
                                                               ELSE "bike" 
            /*13*/   brstat.tlt.safe3         = trim(fi_cover1)
            /*15*/   /*brstat.tlt.stat          = IF ra_pa = 1 THEN "" ELSE trim(fi_product)  /*A55-0073*/*/ /*A63-0392*/
            /*15*/   brstat.tlt.stat          = trim(fi_product)   /*A63-0392*/
            /*10*/   brstat.tlt.filler1       = IF      ra_pree = 1 THEN "แถม"
                                                             ELSE "ไม่แถม"
            /*11*/   brstat.tlt.filler2       = IF      ra_comp = 1 THEN "แถม"
                                         ELSE IF ra_comp = 2 THEN "ไม่แถม"  
                                                             ELSE "ไม่เอาพรบ."
            /*16*/   brstat.tlt.comp_sub      = caps(trim(Input fi_producer))        
            /*17*/   brstat.tlt.recac         = caps(trim(Input fi_agent)) 
                     brstat.tlt.rec_addr4     = caps(TRIM(fi_deler))         /*A56-0024*/
            /*18*/   brstat.tlt.colorcod      = caps(trim(fi_cmrsty)) 
            /*19*/   brstat.tlt.policy        = caps(trim(fi_notno70))       
            /*20*/   brstat.tlt.comp_pol      = caps(trim(fi_notno72))
            /*21*/   brstat.tlt.ins_name      = trim(INPUT fi_institle )  + " " +    
            /*22*/                       trim(INPUT fi_preinsur )  + " " +      
            /*23*/                       trim(Input fi_preinsur2 )  . 
        ASSIGN       brstat.tlt.entdat        = fi_idnoexpdat
                     brstat.tlt.endno         = fi_idno 
            /*21*/   brstat.tlt.dat_ins_noti  = fi_birthday    /*birthday*//*date */  
            /*23*/   brstat.tlt.seqno         = fi_age         /*age      *//*inte */           
            /*24*/   brstat.tlt.flag          = fi_occup       /*occupn   */  
            /*22*/   brstat.tlt.usrsent       = fi_namedrirect /*name direct */  
            /*22*/   brstat.tlt.ins_addr1     = /*(IF ra_ban = 1 THEN   /*ra_ban = 1  */
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
                                     ELSE      /*ra_ban = 3 */*/
                                    trim((IF n_banno = "" THEN "" ELSE "เลขที่ " + TRIM(n_banno) + " " )  + 
                                         (IF n_muno  = "" THEN "" ELSE "หมู่ "   + TRIM(n_muno)  + " " )  +
                                         /*(IF n_build = "" THEN "" ELSE "หมู่บ้าน"  + n_build )    + " " +  */
                                         (IF (co_addr + trim(n_build)) = "" THEN "" 
                                             ELSE  (co_addr + trim(n_build))  + " " )  + 
                                         (IF n_soy   = "" THEN "" ELSE "ซอย" + TRIM(n_soy) + " " )  +   
                                         (IF n_road  = "" THEN "" ELSE "ถนน" + TRIM(n_road)))
            /*30*/   brstat.tlt.ins_addr2     = trim(Input fi_insadd2tam)     
            /*30*/   brstat.tlt.ins_addr3     = TRIM(input fi_insadd3amp)     
            /*31*/   brstat.tlt.ins_addr4     = TRIM(Input fi_insadd4cunt)     
            /*32*/   brstat.tlt.ins_addr5     = TRIM(Input fi_insadd5post)   
                     /* brstat.tlt.comp_noti_ins = TRIM(Input fi_insadd6tel) Comment by Phaiboon W. [A59-0625] DAte 22/12/2016  */

            /*33*/   brstat.tlt.comp_noti_ins = TRIM(fi_insadd6tel) + FILL(" ", 20 - LENGTH(TRIM(fi_insadd6tel))) + nv_chknotes /* Add by Phaiboon W. [A59-0625] DAte 22/12/2016 */

            /*33*/   brstat.tlt.dri_name1     = IF ra_driv = 1 THEN ""
                                         ELSE IF fi_drivername1 = "" THEN ""
                                         ELSE trim(fi_drivername1) + "sex:" + string(ra_sex1)  + "hbd:" + STRING(fi_hbdri1) + "age:" +  string(fi_agedriv1) + "occ:" + trim(fi_occupdriv1) 
            /*33*/   brstat.tlt.dri_no1       = IF ra_driv = 1 THEN ""
                                         ELSE trim(fi_idnodriv1) 
            /*33*/   brstat.tlt.enttim        = IF ra_driv = 1 THEN ""
                                         ELSE IF trim(fi_drivername2) = "" THEN ""
                                         ELSE trim(fi_drivername2) + "sex:" + string(ra_sex2)  + "hbd:" + STRING(fi_hbdri2) + "age:" +  string(fi_agedriv2) + "occ:" + trim(fi_occupdriv2) 
            /*33*/   brstat.tlt.expotim       = IF ra_driv = 1 THEN ""
                                         ELSE trim(fi_idnodriv2)
            /*34*/   brstat.tlt.nor_effdat    = INPUT fi_comdat         
            /*35*/   brstat.tlt.expodat       = Input fi_expdat
            /* /*36*/   brstat.tlt.dri_no2       = trim(INPUT fi_ispno) */
            /*36*/   brstat.tlt.dri_no2       = TRIM(fi_ispno) + FILL(" ", 50 - LENGTH(TRIM(fi_ispno))) + fi_ispstatus /* add by Phaiboon W. [A59-0488] Date 30/11/2016 */
            /*37*/   /*brstat.tlt.brand       = TRIM(fi_brand) */ /* A62-0219*/   
                     brstat.tlt.brand         = TRIM(fi_brand) + IF TRIM(fi_redbook) <> "" THEN " RB:" + TRIM(fi_redbook) ELSE ""  /* A62-0219*/  
            /*38*/   brstat.tlt.model         = trim(Input fi_model)
            /*39*/   brstat.tlt.lince2        = trim(Input fi_year) 
            /*40*/   brstat.tlt.cc_weight     = INPUT fi_power
            /*41*/   brstat.tlt.lince1        = IF (trim(fi_licence1) = "") AND (fi_licence2 = "") THEN ""
                                         ELSE trim(INPUT fi_licence1) + " " +      
            /*42*/                            trim(INPUT fi_licence2) + " " +      
            /*43*/                            INPUT co_provin
            /*44*/   brstat.tlt.cha_no        = TRIM(Input fi_cha_no)
            /*45*/   brstat.tlt.eng_no        = TRIM(INPUT fi_eng_no)
            /*46*/   brstat.tlt.lince3        = TRIM(INPUT fi_pack ) +   
            /*47*/                       TRIM(INPUT fi_class)         
            /*48*/   brstat.tlt.exp           = trim(INPUT fi_garage)       
            /*49*/   brstat.tlt.nor_coamt     = INPUT fi_sumsi       /*ทุนประกันภัย */
                     brstat.tlt.sentcnt       = INPUT fi_sumfi      /*ทุนสูญหาย ไฟไหม้ */  /*A62-0219*/
            /*50*/   brstat.tlt.dri_name2     = STRING(Input fi_gap )
            /*51*/   brstat.tlt.nor_grprm     = INPUT fi_premium  
            /*52*/   brstat.tlt.comp_coamt    = INPUT fi_precomp  
            /*53*/   brstat.tlt.comp_grprm    = INPUT fi_totlepre
            /*54*/   brstat.tlt.comp_sck      = trim(INPUT fi_stk) /* สติ๊กเกอร์ + docno */
            /*55*/   brstat.tlt.comp_noti_tlt = trim(INPUT fi_refer)         
            /*56*/   brstat.tlt.rec_name      = trim(Input fi_recipname)  
            /*57*/   brstat.tlt.comp_usr_tlt  = trim(INPUT fi_vatcode) 
            /*58*/   /*brstat.tlt.expousr       = IF co_user = "" THEN fi_user2  ELSE co_user   */ /*A62-0219 */
                     brstat.tlt.expousr       = "BR:" + co_user + " " + "USER:" + fi_user2   /*A62-0219 */  
            /*60*/   brstat.tlt.comp_usr_ins  = trim(fi_benname)
             /* Begin by Phaiboon W. [A59-0488] Date 11/10/2016 */
             /*67*/  brstat.tlt.OLD_cha       = USERID(LDBNAME(1))  + ":" + trim(fi_remark1) 
                     n_remark1         = USERID(LDBNAME(1))  + " : " + TRIM(fi_remark1)  
                     n_remark1         = n_remark1 + FILL(" ", 100 - LENGTH(n_remark1))

                     n_remark2         = TRIM(fi_remark2)                              
                     n_remark2         = n_remark2 + FILL(" ", 100 - LENGTH(n_remark2))
                        
                     n_other1          = "อุปกรณ์เสริมคุ้มครองไม่เกิน"
                     n_other1          = n_other1 + FILL(" ", 50 - LENGTH(n_other1))
                     n_other2          = STRING(fi_other2) + FILL(" " , 10 - LENGTH(STRING(fi_other2))) 
                     n_other3          = STRING(fi_other3) + FILL(" " , 60 - LENGTH(STRING(fi_other3)))                        
                     brstat.tlt.OLD_cha       = n_remark1 + n_remark2 + n_other1 + n_other2 + n_other3 + n_quota + n_garage
                    /* End by Phaiboon W. [A59-0488] Date 11/10/2016 */
            /*62*/   brstat.tlt.OLD_eng       = IF ra_complete = 1 THEN "complete"
                                         ELSE "not complete"
            /*  */   brstat.tlt.genusr        = "Phone" 
            /*  */   brstat.tlt.imp           = "IM"                     /*Import Data*/
            /*  */   brstat.tlt.releas        = "No" 
                     brstat.tlt.rec_addr5     = /*IF      co_caruse = "BIKE(บุคคล)"    THEN STRING(fi_baseod) 
                                         ELSE IF co_caruse = "BIKE(พาณิชย์)"  THEN STRING(fi_baseod) 
                                         ELSE "0" .  /*A57-0063*/*/
                                         STRING(fi_baseod)   /*A57-0063*/
                     /* A62-0219 เพิ่มความคุ้มครอง */
                     brstat.tlt.rec_addr2     = "TPP:" +  n_tpp + " " +
                                         "TPA:" +  n_tpa + " " +
                                         "TPD:" +  n_tpd 
                     brstat.tlt.rec_addr3     = "41:" +   n_41  + " " +
                                         "42:" +   n_42  + " " +
                                         "43:" +   n_43 
                     brstat.tlt.gentim        = trim(nv_detail + " " + nv_damage + " " + nv_damlist + " " + nv_surdata) /* ผลตรวจสภาพ*/
                     brstat.tlt.endcnt        = 0 .  /* status Match running ORICO  0 = ยังไม่แมท , 1 = แมทแล้ว */
                     /* end : A62-0219 */
    END.                                  
    MESSAGE "SAVE COMPLETE..." VIEW-AS ALERT-BOX.
    Apply "Close"  To this-procedure.
    Return no-apply.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME cmtoubu_quo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cmtoubu_quo wgwimpon
ON CHOOSE OF cmtoubu_quo IN FRAME fr_main /* Quotation */
DO:    
    n_chk = YES.
    RUN wgw\wgwqupoQ (INPUT  fi_quo,      INPUT-OUTPUT n_chk,  OUTPUT fi_redbook, /*A62-0219*/
                      OUTPUT fi_brand,    OUTPUT fi_model,     OUTPUT fi_year,     
                      OUTPUT fi_power,   /* OUTPUT fi_licence1,  OUTPUT fi_licence2,*/
                     /* OUTPUT fi_cha_no,   OUTPUT fi_eng_no, */   OUTPUT ra_driv,                      
                      OUTPUT fi_drivername1, OUTPUT fi_drivername2,
                      OUTPUT ra_sex1,        OUTPUT ra_sex2,
                      OUTPUT fi_hbdri1,      OUTPUT fi_hbdri2,
                      OUTPUT fi_agedriv1,    OUTPUT fi_agedriv2,
                      OUTPUT fi_occupdriv1,  OUTPUT fi_occupdriv2,
                      OUTPUT fi_idnodriv1,   OUTPUT fi_idnodriv2,
                      OUTPUT fi_pack,        OUTPUT fi_class,    OUTPUT fi_garage,
                      OUTPUT fi_sumsi,       OUTPUT fi_gap,      OUTPUT fi_premium,
                      OUTPUT fi_precomp,     OUTPUT fi_totlepre, OUTPUT fi_baseod,
                      /* add  A62-0219*/
                      output  n_tpp    , 
                      output  n_tpa    , 
                      output  n_tpd    , 
                      output  n_41     , 
                      output  n_42     , 
                      output  n_43 ). 
                     /* end a62-0219 */
    IF n_chk = YES THEN DO:
        /*A62-0219*/
        fi_campaign  = "" .  
        IF fi_cover1 = "1" THEN ASSIGN fi_sumfi = fi_sumsi. 
        IF fi_garage = "G" THEN ASSIGN co_garage = "ซ่อมห้าง" .
        ELSE ASSIGN co_garage = "ซ่อมอู่" .
        /*A62-0219*/

        DISP fi_brand       fi_model     fi_year     fi_power  
             /* fi_licence1    fi_licence2  fi_cha_no   fi_eng_no */
             ra_driv        fi_pack      fi_class    fi_garage
             fi_sumsi       fi_gap       fi_premium  fi_precomp
             fi_totlepre    fi_baseod    fi_redbook  fi_sumfi  fi_campaign  co_garage /*a62-0219*/
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


&Scoped-define SELF-NAME co_addr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL co_addr wgwimpon
ON VALUE-CHANGED OF co_addr IN FRAME fr_main
DO:
    co_addr = INPUT co_addr.
    DISP co_addr WITH FRAM fr_main.
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


&Scoped-define SELF-NAME co_caruse
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL co_caruse wgwimpon
ON LEAVE OF co_caruse IN FRAME fr_main
DO:
  co_caruse = INPUT co_caruse. 
   
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL co_caruse wgwimpon
ON return OF co_caruse IN FRAME fr_main
DO:
  APPLY "LEAVE" TO co_caruse.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL co_caruse wgwimpon
ON VALUE-CHANGED OF co_caruse IN FRAME fr_main
DO:
    co_caruse = INPUT co_caruse.
    ASSIGN nv_cartyp = co_caruse.
    /* Add by :  A63-0392 */       
    IF      nv_cartyp = "เก๋ง"             THEN ASSIGN fi_class = "110".
    ELSE IF nv_cartyp = "กระบะ"            THEN ASSIGN fi_class = "320".   
    ELSE IF nv_cartyp = "โดยสาร(บุคคล)"    THEN ASSIGN fi_class = "210".   
    ELSE IF nv_cartyp = "โดยสาร(พาณิชย์)"  THEN ASSIGN fi_class = "220".   
    ELSE IF nv_cartyp = "BIKE(บุคคล)"      THEN ASSIGN fi_class = "610".   
    ELSE IF nv_cartyp = "BIKE(พาณิชย์)"    THEN ASSIGN fi_class = "620".
    ASSIGN fi_pack   = "T".
    /* end A63-0392 */

    /*  comment by :A63-0392 ..
    IF  nv_cartyp = "เก๋ง" THEN DO:
        ASSIGN fi_class = "110"
            fi_pack     = "G" .
        IF fi_cover1 = "3" THEN 
            ASSIGN 
            fi_pack     = "V"  
            fi_garage   = ""
            fi_benname  = "" .
        /*disable fi_baseod  WITH FRAM fr_main.*/ /*A57-0063*/
    END.
    ELSE IF nv_cartyp = "กระบะ" THEN DO:
        ASSIGN fi_class = "320".
        IF fi_cover1 = "3" THEN 
            ASSIGN 
            fi_pack     = "R" 
            fi_garage   = ""
            fi_benname  = "".
        /*disable fi_baseod  WITH FRAM fr_main.*//*A57-0063*/
    END.
    ELSE IF nv_cartyp = "โดยสาร(บุคคล)"  THEN DO:
        ASSIGN fi_class = "210".
        IF fi_cover1 = "3" THEN 
            ASSIGN    
            fi_pack    = "V"  
            fi_garage  = ""
            fi_benname = "" .
        /*disable fi_baseod  WITH FRAM fr_main.*//*A57-0063*/
    END.
    ELSE IF nv_cartyp = "โดยสาร(พาณิชย์)" THEN DO:
        ASSIGN fi_class = "220".
        IF fi_cover1 = "3" THEN 
            ASSIGN    
                fi_pack    = "V"  
                fi_garage  = ""
                fi_benname = "" .
        /*disable fi_baseod  WITH FRAM fr_main.*//*A57-0063*/
    END.
    ELSE IF nv_cartyp = "BIKE(บุคคล)" THEN DO:
        ASSIGN 
            fi_pack    = "Z"
            fi_class   = "610" 
            fi_garage  = "G"
            fi_benname = "" .
        /*ENABLE  fi_baseod  WITH FRAM fr_main.*//*A57-0063*/
    END.
    ELSE IF nv_cartyp = "BIKE(พาณิชย์)" THEN DO:
        ASSIGN 
            fi_pack    = "Z"
            fi_class   = "620" 
            fi_garage  = "G"
            fi_benname = "" .
        /*ENABLE  fi_baseod  WITH FRAM fr_main.*//*a57-0063*/
    END.
    ... end A63-0392..*/
    DISP co_caruse  fi_pack fi_class fi_benname fi_garage  WITH FRAM fr_main.
    APPLY "entry" TO fi_cover1.
    RETURN NO-APPLY.
    DISP co_caruse WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME co_garage
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL co_garage wgwimpon
ON VALUE-CHANGED OF co_garage IN FRAME fr_main
DO:
    co_garage = INPUT co_garage .
    DISP co_garage WITH FRAM fr_main.  
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


&Scoped-define SELF-NAME co_title
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL co_title wgwimpon
ON LEAVE OF co_title IN FRAME fr_main
DO:
  co_title = INPUT co_title. 
   
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL co_title wgwimpon
ON return OF co_title IN FRAME fr_main
DO:
  APPLY "LEAVE" TO co_title.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL co_title wgwimpon
ON VALUE-CHANGED OF co_title IN FRAME fr_main
DO:
    co_title = INPUT co_title .
    ASSIGN fi_institle = INPUT co_title.

 /* IF co_title = "" THEN DO:
      APPLY "entry" TO fi_user2.
      RETURN NO-APPLY.
  END.*/
  DISP co_title fi_institle WITH FRAM fr_main.
   
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME co_user
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL co_user wgwimpon
ON LEAVE OF co_user IN FRAME fr_main
DO:
    co_user = INPUT co_user .
    DISP co_user WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL co_user wgwimpon
ON RETURN OF co_user IN FRAME fr_main
DO:
  APPLY "LEAVE" TO co_user.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL co_user wgwimpon
ON VALUE-CHANGED OF co_user IN FRAME fr_main
DO:
    co_user = INPUT co_user .
    DISP co_user WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_agent
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_agent wgwimpon
ON LEAVE OF fi_agent IN FRAME fr_main
DO:
    fi_agent  = trim(caps( INPUT fi_agent )).
    DISP fi_agent WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_baseod
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_baseod wgwimpon
ON LEAVE OF fi_baseod IN FRAME fr_main
DO:
    fi_baseod  = INPUT fi_baseod.
    DISP fi_baseod WITH FRAM fr_main. 
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


&Scoped-define SELF-NAME fi_brand
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_brand wgwimpon
ON LEAVE OF fi_brand IN FRAME fr_main
DO:
    fi_brand = trim(INPUT fi_brand).
    DISP fi_brand WITH FRAM fr_main.
  
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
    fi_cmrsty  =  trim(caps(INPUT fi_cmrsty)) .
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
        FIND FIRST brstat.company WHERE Company.CompNo = fi_comco  NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL company THEN  
            MESSAGE "Not found Company code...!!!"    SKIP
                    "Plese Set up Company code. !!!"  VIEW-AS ALERT-BOX.
        ELSE DO:
            ASSIGN 
                fi_benname     = Company.Name2       /*A56-0024*/
                nv_benname     = Company.Name2       /*A56-0024*/ 
                n_producernew  = company.Text1     
                n_produceruse  = company.Text2 
                n_producerbike = company.Text5   /*A57-0063*/
                n_agent        = company.Text4 . 
            IF ra_cover = 1 THEN                 /*new car */                
                ASSIGN                           
                fi_producer = company.Text1      /*A56-0024*/
                fi_agent    = company.Text4 .    
            ELSE IF ra_cover = 3 THEN            /*A57-0063  for bike */                  
                ASSIGN                           /*A57-0063  for bike */
                fi_producer = company.Text5      /*A57-0063  for bike */
                fi_agent    = company.Text4 .    /*A57-0063  for bike */
            ELSE                                    
                ASSIGN                              /*use car */                 
                    fi_producer = company.Text2     /*A56-0024*/
                    fi_agent    = company.Text4 .   /*A56-0024*/
            /*IF fi_comco = "scb" THEN DO:
                /*ASSIGN fi_benname = "ธนาคารไทยพาณิชย์ จำกัด (มหาชน)".*/  /* A56-0024 */
                IF ra_cover = 1 THEN
                    ASSIGN 
                    fi_producer  = "B3M0009"
                    fi_agent     = "B3M0009".
                ELSE ASSIGN 
                    fi_producer  = "B3M0010"
                    fi_agent     = "B3M0009"  .
            END.
            ELSE IF fi_comco = "aycal" THEN DO:
                /*ASSIGN fi_benname = "บริษัท อยุธยา แคปปิตอล ออโต้ลิส จำกัด(มหาชน)" .*//* A56-0024 */
                IF ra_cover = 1 THEN
                    ASSIGN 
                    fi_producer = "A0M0061"
                    fi_agent    = "B300303".
                ELSE ASSIGN 
                    fi_producer = "A0M1011"
                    fi_agent    = "B300303" .
            END.
            ELSE IF fi_comco = "TCR" THEN DO:
                /*ASSIGN fi_benname = "บมจ. ธนาคารไทยเครดิต เพื่อรายย่อย".*/   /* A56-0024 */
                IF ra_cover = 1 THEN
                    ASSIGN 
                    fi_producer = "B3M0013"
                    fi_agent    = "B3M0013".
                ELSE ASSIGN 
                    fi_producer = "B3M0014"
                    fi_agent    = "B3M0013".
            END.
            ELSE IF fi_comco = "ASK" THEN DO:
                /* ASSIGN fi_benname = "บริษัท เอเซียเสริมกิจลีสซิ่ง จำกัด (มหาชน)".*//* A56-0024 */
                IF ra_cover = 1 THEN
                    ASSIGN 
                    fi_producer = "A0M1004"
                    fi_agent    = "B300303".
                ELSE ASSIGN 
                    fi_producer = "A0M1004"
                    fi_agent    = "B300303"  .
            END.
            ELSE IF fi_comco = "BGPL" THEN DO:
                /*ASSIGN fi_benname = "บริษัท กรุงเทพแกรนด์แปซิฟิคลีส จำกัด ( มหาชน)".*//* A56-0024 */
                IF ra_cover = 1 THEN
                    ASSIGN 
                    fi_producer = "A000774"
                    fi_agent    = "B300303".
                ELSE ASSIGN 
                    fi_producer = "A000774"
                    fi_agent    = "B300303" .
            END.
            ELSE IF fi_comco = "RTN" THEN DO:
                /*ASSIGN fi_benname = "บริษัท ราชธานี ลีสซิ่ง จำกัด (มหาชน)".*//* A56-0024 */
                IF ra_cover = 1 THEN
                    ASSIGN 
                    fi_producer = "A0M0069"
                    fi_agent    = "B300303".
                ELSE ASSIGN 
                    fi_producer = "A0M1002"
                    fi_agent    = "B300303".
            END.
            /*/* A56-0024 */
            ELSE ASSIGN 
                fi_producer  = ""
                fi_agent   = ""
                fi_benname = "" . *//* A56-0024 */*/
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
    n_day = 0.
    /*comment by kridtiya i. A56-0024
    IF INTE(DAY(fi_comdat)) = 29 THEN
         ASSIGN fi_expdat = DATE(("01") + "/" +
                                STRING(MONTH(fi_comdat),"99") + "/" +
                                string(year(fi_comdat) + 1 ,"9999")).
    ELSE ASSIGN fi_expdat = DATE(STRING(DAY(fi_comdat),"99") + "/" +
                                 STRING(MONTH(fi_comdat),"99") + "/" +
                                 string(year(fi_comdat) + 1 ,"9999")).
    end..by kridtiya i. A56-0024...*/
    /*kridtiya i. A56-0024...*/
    IF YEAR(fi_comdat) <> YEAR(TODAY) THEN DO:
        MESSAGE "กรุณาปี ค.ศ " VIEW-AS ALERT-BOX.
        APPLY "entry" TO fi_comdat .
        RETURN NO-APPLY.
    END.
    ELSE IF DATE(fi_comdat) < TODAY THEN DO:
        n_day = DATE(TODAY) - DATE(fi_comdat) .
        IF n_day > 15 THEN DO:
            MESSAGE "ระบุวันที่เริ่มต้นคุ้มครองย้อนหลังได้ไม่เกิน 15 วัน ! " VIEW-AS ALERT-BOX.
            APPLY "entry" TO fi_comdat .
            RETURN NO-APPLY.
        END.
    END.
    IF (INTE(DAY(fi_comdat)) = 29 ) AND (int(MONTH(fi_comdat)) = 2 ) THEN
        ASSIGN fi_expdat = DATE(("01") + "/" +
                                STRING(MONTH(fi_comdat),"99") + "/" +
                                string(year(fi_comdat) + 1 ,"9999")).
    ELSE ASSIGN fi_expdat = DATE(STRING(DAY(fi_comdat),"99") + "/" +
                                 STRING(MONTH(fi_comdat),"99") + "/" +
                                 string(year(fi_comdat) + 1 ,"9999")).
    /*kridtiya i. A56-0024...*/
    DISP fi_comdat fi_expdat WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_cover1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_cover1 wgwimpon
ON LEAVE OF fi_cover1 IN FRAME fr_main
DO:
    fi_cover1 = INPUT fi_cover1.
    /*Add kridtiya i.A55-0108 */
    /*IF      fi_comco = "SCB"   THEN fi_benname = "ธนาคารไทยพาณิชย์ จำกัด (มหาชน)".
    ELSE IF fi_comco = "AYCAL" THEN fi_benname = "บริษัท อยุธยา แคปปิตอล ออโต้ลิส จำกัด(มหาชน)".
    /*ELSE IF fi_comco = "TCR"   THEN fi_benname = "ธนาคาร ไทยเครดิต เพื่อรายย่อย จำกัด (มหาชน)".*/
    ELSE IF fi_comco = "TCR"   THEN fi_benname = "บมจ. ธนาคารไทยเครดิต เพื่อรายย่อย".
    ELSE IF fi_comco = "ASK"   THEN fi_benname = "บริษัท เอเซียเสริมกิจลีสซิ่ง จำกัด (มหาชน)".
    ELSE IF fi_comco = "BGPL"  THEN fi_benname = "บริษัท กรุงเทพแกรนด์แปซิฟิคลีส จำกัด ( มหาชน)".
    ELSE IF fi_comco = "RTN"   THEN fi_benname = "บริษัท ราชธานี ลีสซิ่ง จำกัด (มหาชน)".
    ELSE fi_benname = "".*/
    /* comment by Ranu I. A63-0392...
    IF      fi_cover1    = "1" THEN ASSIGN fi_pack = "G".
    ELSE IF fi_cover1    = "2" THEN ASSIGN fi_pack = "Y".
    ELSE IF fi_cover1    = "3" THEN DO:
        /*A55-0125 */
        /*IF ra_car = 2 THEN*/
        IF co_caruse = "กระบะ" THEN
            ASSIGN fi_pack = "R"  
            fi_benname  = "".
        ELSE ASSIGN fi_pack = "V"  
             fi_benname  = "" .
        /*A55-0125 */
    END.
    ELSE IF fi_cover1 = "5"    THEN ASSIGN fi_pack = "B".

    /* Begin by Phaiboon W. [A59-0488] Date 07/11/2016 */
    ELSE IF fi_cover1 = "2.1" OR
            fi_cover1 = "2.2" OR
            fi_cover1 = "3.1" OR
            fi_cover1 = "3.2" THEN ASSIGN fi_pack = "C".

    if fi_cover1 = "1" AND
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

    IF (nv_cartyp = "BIKE(บุคคล)") OR (nv_cartyp = "BIKE(พาณิชย์)")  THEN ASSIGN fi_pack = "Z" .  /*Add kridtiya i.A55-0108 */
    IF fi_cover1    = "3" THEN ASSIGN fi_benname  = "" .
    ELSE ASSIGN  fi_benname   = nv_benname .    /*A56-0024*/
    ... end A63-0392...*/
    Disp  fi_cover1 fi_pack fi_class fi_benname fi_ispstatus with frame  fr_main. 
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
    /*IF ra_ban = 1 THEN DO: 
        MESSAGE "กรุณาเลือกสถานที่ ...อาคาร/หมู่บ้าน ..." VIEW-AS ALERT-BOX.
        APPLY "entry" TO    ra_ban.
        RETURN NO-APPLY.
    END.*/
    DISP fi_insadd1build WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_insadd1mu
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_insadd1mu wgwimpon
ON LEAVE OF fi_insadd1mu IN FRAME fr_main
DO:
    fi_insadd1mu  = trim(INPUT fi_insadd1mu ).
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
    
    /* Begin by Phaiboon W. [A59-0488] Date 01/12/2016 */
    nv_ispstatus = fi_ispno.
    IF INDEX(nv_ispstatus,"ISP") > 0 THEN DO:        
        fi_ispstatus = "Y".        
    END.
    /*
    ELSE IF INDEX(nv_ispstatus,"ไม่ตรวจ") > 0 OR
            INDEX(nv_ispstatus,"รถ")      > 0 THEN DO:

        fi_ispstatus = "N".        
    END.   
    */
    ELSE fi_ispstatus = "N".
    /* End by Phaiboon W. [A59-0488] Date 01/12/2016 */

    DISP fi_ispno fi_ispstatus WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_ispno wgwimpon
ON RETURN OF fi_ispno IN FRAME fr_main
DO:
    APPLY "Entry" TO fi_ispstatus.
    RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_ispstatus
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_ispstatus wgwimpon
ON LEAVE OF fi_ispstatus IN FRAME fr_main
DO:
    fi_ispstatus  = trim( CAPS ( INPUT fi_ispstatus )).
    DISP fi_ispstatus WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_ispstatus wgwimpon
ON RETURN OF fi_ispstatus IN FRAME fr_main
DO:
    APPLY "Entry" TO fi_brand.
    RETURN NO-APPLY.
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
    /*IF (fi_notno70  <> "") AND (nv_check70 = "no") THEN DO:*/  /*A55-0073*/
    IF (INPUT fi_notno70)  <> ""   THEN DO:   /*A55-0073*/
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
                        MESSAGE "พบเลขกรมธรรม์นี้ในระบบ !!!" VIEW-AS ALERT-BOX.
                        APPLY "entry" TO fi_notno70.
                        RETURN NO-APPLY.
                    END.
                END.
            END.
            ELSE DO:
                IF tlt.nor_noti_tlt  <> fi_notino THEN do: 
                MESSAGE "พบเลขกรมธรรม์นี้ในระบบ Phone เลขที่รับแจ้ง " + tlt.nor_noti_tlt  VIEW-AS ALERT-BOX.
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
        /****comment by Kridtiya i. A55-0257.....
        running_notitlt:    /*--Running running_notitlt */
        REPEAT:
            FIND LAST  brstat.tlt    WHERE 
                tlt.genusr        = "Phone"      AND
                tlt.policy        = caps((INPUT fi_notno70))  NO-ERROR NO-WAIT.
            IF NOT AVAIL brstat.tlt THEN DO:
                CREATE brstat.tlt.
                ASSIGN 
                    tlt.genusr        = "Phone"     
                    tlt.nor_noti_tlt  = "PHONE" + STRING(TODAY,"99/99/9999") + string(TIME,"HH:MM:SS") 
                    fi_notino         = "PHONE" + STRING(TODAY,"99/99/9999") + string(TIME,"HH:MM:SS")
                    tlt.policy        = caps((INPUT fi_notno70))
                    tlt.nor_usr_ins   = INPUT fi_ins_off
                    tlt.lotno         = INPUT fi_comco 
                    tlt.nor_noti_ins  = Input fi_cmrcode 
                    tlt.nor_usr_tlt   = Input fi_cmrcode2
                    tlt.trndat        = TODAY
                    tlt.trntime       = SUBSTR(fi_notino,16)
                    fi_nottim         = SUBSTR(fi_notino,16)
                    tlt.usrid         = USERID(LDBNAME(1))       
                    tlt.imp           = "IM"                    
                    tlt.releas        = "No"
                    tlt.subins        = trim(Input fi_campaign)
                    tlt.safe1         = IF      ra_car  = 1 THEN "เก๋ง" 
                                        ELSE IF ra_car  = 2 THEN "กระบะ"    
                                                            ELSE "โดยสาร" 
                    tlt.filler1       = IF ra_pree = 1 THEN "แถม"
                                                       ELSE "ไม่แถม"
                    tlt.filler2       = IF      ra_comp = 1 THEN "แถม"
                                        ELSE IF ra_comp = 2 THEN "ไม่แถม"  
                                                            ELSE "ไม่เอาพรบ."
                    tlt.safe2         = IF    ra_cover  = 1 THEN "ป้ายแดง" 
                                                            ELSE "use car" 
                    tlt.safe3         = trim(fi_cover1)
                    tlt.stat          = IF ra_pa = 1 THEN "" ELSE fi_product        /*A55-0073*/
                    tlt.comp_sub      = trim(Input fi_producer)        
                    tlt.recac         = trim(Input fi_agent) 
                    tlt.colorcod      = caps(trim(Input fi_cmrsty))      
                    tlt.comp_pol      = caps(trim(INPUT fi_notno72))
                    tlt.ins_name      = trim(INPUT fi_institle )  + " " +    
                                        trim(INPUT fi_preinsur )  + " " +      
                                        trim(Input fi_preinsur2 )
                    /*comment by Kridtiya i. A55-0125.........
                    n_build           = IF n_build = "" THEN ""
                                        ELSE IF ra_ban = 1 THEN "อาคาร"    +  TRIM(n_build) 
                                                           ELSE "หมู่บ้าน" +  TRIM(n_build)  
                    tlt.ins_addr1     = trim((IF n_banno = "" THEN "" ELSE "เลขที่ " + TRIM(n_banno)) + " " +  
                                         (IF n_muno  = "" THEN "" ELSE "หมู่ "   + TRIM(n_muno))  + " " +  
                                         (IF n_build = "" THEN "" ELSE TRIM(n_build)) + " " +  
                                         (IF n_soy   = "" THEN "" ELSE "ซอย"    + TRIM(n_soy))   + " " +  
                                         (IF n_road  = "" THEN "" ELSE "ถนน"    + TRIM(n_road)))
                    end....comment by kridtiya i. A55-0125....*/
                    /*Kridtiya i. A55-0125*/
                    tlt.ins_addr1     =  (IF ra_ban = 1 THEN  /*ra_ban = 1  */
                                    trim((IF n_banno = "" THEN "" ELSE "เลขที่ " + TRIM(n_banno)) + " " +  
                                         (IF n_muno  = "" THEN "" ELSE "หมู่ "   + TRIM(n_muno))  + " " +
                                         (IF n_build = "" THEN "" ELSE "อาคาร"   + n_build )      + " " +  
                                         (IF n_soy   = "" THEN "" ELSE "ซอย"     + TRIM(n_soy))   + " " +  
                                         (IF n_road  = "" THEN "" ELSE "ถนน"     + TRIM(n_road))) 
                                          ELSE      /*ra_ban = 2 */
                                    trim((IF n_banno = "" THEN "" ELSE "เลขที่ " + TRIM(n_banno)) + " " +  
                                         (IF n_muno  = "" THEN "" ELSE "หมู่ "   + TRIM(n_muno))  + " " +
                                         (IF n_build = "" THEN "" ELSE "หมู่บ้าน"  + n_build )    + " " +  
                                         (IF n_soy   = "" THEN "" ELSE "ซอย"     + TRIM(n_soy))   + " " +  
                                         (IF n_road  = "" THEN "" ELSE "ถนน"     + TRIM(n_road))))
                        /*Kridtiya i. A55-0125*/
                    tlt.ins_addr2     = trim(Input fi_insadd2tam)     
                    tlt.ins_addr3     = TRIM(input fi_insadd3amp)     
                    tlt.ins_addr4     = TRIM(Input fi_insadd4cunt)     
                    tlt.ins_addr5     = TRIM(Input fi_insadd5post)   
                    tlt.comp_noti_ins = TRIM(Input fi_insadd6tel)
                    tlt.nor_effdat    = INPUT fi_comdat         
                    tlt.expodat       = Input fi_expdat
                    tlt.dri_no2       = trim(INPUT fi_ispno)
                    tlt.brand         = Input co_brand            
                    tlt.model         = trim(Input fi_model)
                    tlt.lince2        = trim(Input fi_year) 
                    tlt.cc_weight     = INPUT fi_power
                    tlt.lince1        = INPUT fi_licence1 + " " +      
                                        trim(INPUT fi_licence2) + " " +      
                                        INPUT co_provin
                    tlt.cha_no        = Input fi_cha_no
                    tlt.eng_no        = INPUT fi_eng_no
                    tlt.lince3        = INPUT fi_pack  +        
                                        trim(INPUT fi_class)         
                    tlt.exp           = trim(INPUT fi_garage)       
                    tlt.nor_coamt     = INPUT fi_sumsi 
                    tlt.dri_name2     = STRING(Input fi_gap )
                    tlt.nor_grprm     = INPUT fi_premium  
                    tlt.comp_coamt    = INPUT fi_precomp  
                    tlt.comp_grprm    = INPUT fi_totlepre
                    tlt.comp_sck      = trim(INPUT fi_stk)
                    tlt.comp_noti_tlt = trim(INPUT fi_refer)         
                    tlt.rec_name      = trim(Input fi_recipname)  
                    tlt.comp_usr_tlt  = trim(INPUT fi_vatcode) 
                    tlt.expousr       = IF co_user = "" THEN fi_user2 
                                                        ELSE co_user
                    tlt.comp_usr_ins  = trim(Input fi_benname)       
                    tlt.OLD_cha       = USERID(LDBNAME(1))  + ":" + trim(Input fi_remark1)        
                    tlt.OLD_eng       = IF ra_complete = 1 THEN "complete"
                                                           ELSE "not complete".
                MESSAGE "Create Complete by..tlt "  VIEW-AS ALERT-BOX.
                DISP fi_notino fi_nottim fi_notdat fi_notno70 WITH FRAM fr_main.
                LEAVE running_notitlt.
            END.
            ELSE DO:
                IF tlt.nor_noti_tlt = fi_notino  THEN  LEAVE running_notitlt.
                ELSE DO:
                    MESSAGE "Found policy70 duplicate...tlt: " + tlt.nor_noti_tlt SKIP 
                            "กรุณาคีย์เลขกรมธรรม์ใหม่อีกครั้ง "   VIEW-AS ALERT-BOX.

                    APPLY "entry" TO fi_notno70.
                    RETURN NO-APPLY.
                    LEAVE running_notitlt.
                END.
            END. 
        END.     /*repeat*/
        RELEASE brstat.tlt.
        */
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
    IF (fi_notno72  <> "") AND (nv_check72 = "no") THEN DO:  /*A55-0073  */
        IF ((INPUT fi_notno72)  <> "" )   THEN DO:  
            IF LENGTH((INPUT fi_notno72)) <> 12  THEN 
                MESSAGE "เลขกรมธรรม์ต้องเท่ากับ 12 หลัก !!!" VIEW-AS ALERT-BOX.  /*A55-0073  */
            FIND LAST  brstat.tlt    WHERE 
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
                        MESSAGE "พบเลขกรมธรรม์นี้ในระบบ !!!" VIEW-AS ALERT-BOX.
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
&Scoped-define SELF-NAME fi_other2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_other2 wgwimpon
ON LEAVE OF fi_other2 IN FRAME fr_main
DO:
    fi_other2 = INPUT fi_other2.
    DISP fi_other2 WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_other2 wgwimpon
ON RETURN OF fi_other2 IN FRAME fr_main
DO:
    APPLY "Entry" TO fi_other3.
    RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_other3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_other3 wgwimpon
ON LEAVE OF fi_other3 IN FRAME fr_main
DO:
    fi_other3  = INPUT fi_other3.
    DISP fi_other3 WITH FRAM fr_main. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_other3 wgwimpon
ON RETURN OF fi_other3 IN FRAME fr_main
DO:
    APPLY "Entry" TO fi_benname.
    RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


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
    fi_producer  = trim(caps( INPUT fi_producer )).
    DISP fi_producer WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_product
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_product wgwimpon
ON LEAVE OF fi_product IN FRAME fr_main
DO:
    fi_product = trim(INPUT fi_product) .
    /* comment by A63-0392 ....
    IF ((INPUT fi_product) <> "" ) AND (ra_pa = 1) THEN DO:
        MESSAGE "กรุณาเลือก ขาย PA "   VIEW-AS ALERT-BOX.
        ASSIGN fi_product = "".
        APPLY "entry" TO ra_pa.
        RETURN NO-APPLY.   
    END.
    ... end A63-0392..*/
    Disp  fi_product   with frame  fr_main.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_quo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_quo wgwimpon
ON LEAVE OF fi_quo IN FRAME fr_main
DO:
    fi_quo = CAPS(INPUT fi_quo).
    DISP fi_quo WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_quo wgwimpon
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
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_recipname wgwimpon
ON LEAVE OF fi_recipname IN FRAME fr_main
DO:
  fi_recipname = TRIM( Input  fi_recipname).
  Disp  fi_recipname with frame  fr_main. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_redbook
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_redbook wgwimpon
ON LEAVE OF fi_redbook IN FRAME fr_main
DO:
    fi_redbook = trim(INPUT fi_redbook).
    DISP fi_redbook WITH FRAM fr_main.
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


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_remark1 wgwimpon
ON Return OF fi_remark1 IN FRAME fr_main
DO:
  APPLY "Entry" TO fi_remark2.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_remark2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_remark2 wgwimpon
ON LEAVE OF fi_remark2 IN FRAME fr_main
DO:
  fi_remark2 = trim(INPUT fi_remark2).
  DISP fi_remark2 with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_remark2 wgwimpon
ON RETURN OF fi_remark2 IN FRAME fr_main
DO:
  APPLY "Entry" TO ra_complete.
  RETURN NO-APPLY.
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


&Scoped-define SELF-NAME fi_sumfi
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_sumfi wgwimpon
ON LEAVE OF fi_sumfi IN FRAME fr_main
DO:
    fi_sumfi  = INPUT fi_sumfi.
  DISP fi_sumfi  WITH FRAM fr_main. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_sumsi
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_sumsi wgwimpon
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
        ELSE DO:
            IF fi_cover1 = "1" THEN  ASSIGN fi_sumfi = fi_sumsi .
        END.
    END.
    IF fi_cover1 = "1" THEN  ASSIGN fi_sumfi = fi_sumsi .
    /* end A62-0219*/
  DISP fi_sumsi fi_sumfi  WITH FRAM fr_main. 
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


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_vatcode wgwimpon
ON RETURN OF fi_vatcode IN FRAME fr_main
DO:
    APPLY "Entry" TO fi_other2.
    RETURN NO-APPLY.
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
    /* by Kridtiya i. A56-0024 ...*/
    IF ra_cover = 1 THEN
        ASSIGN 
        /*fi_pack = "G"*/
        fi_producer = n_producernew  
        fi_agent    = n_agent    .
    ELSE IF ra_cover = 2 THEN  
        ASSIGN 
            fi_producer = n_produceruse 
            fi_agent    =  n_agent    .
    ELSE ASSIGN 
        fi_producer = n_producerbike   /*A57-0063*/
        fi_agent    = n_agent    .     /*A57-0063*/
    /*IF (nv_cartyp = "BIKE(บุคคล)") OR (nv_cartyp = "BIKE(พาณิชย์)")  THEN ASSIGN fi_pack = "Z" .*//*A57-0063*/

    /* by Kridtiya i. A56-0024 ...*/
    /*comment by Kridtiya i. A56-0024 ...
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
    end comment by Kridtiya i. A56-0024 ...*/
    DISP ra_cover fi_comco fi_producer fi_agent fi_pack  WITH FRAM fr_main. 
    /*
    APPLY "entry" TO fi_cover1 .
    RETURN NO-APPLY.
    */
    /* comment by ranu i. A63-0392...
    /* Begin by Phaiboon W. [A59-0488] Date 07/11/2016 */
    IF      fi_cover1    = "1" THEN ASSIGN fi_pack = "G".
    ELSE IF fi_cover1    = "2" THEN ASSIGN fi_pack = "Y".
    ELSE IF fi_cover1    = "3" THEN DO:
        /*A55-0125 */
        /*IF ra_car = 2 THEN*/
        IF co_caruse = "กระบะ" THEN
            ASSIGN fi_pack = "R"  
            fi_benname  = "".
        ELSE ASSIGN fi_pack = "V"  
             fi_benname  = "" .
        /*A55-0125 */
    END.
    ELSE IF fi_cover1 = "5"    THEN ASSIGN fi_pack = "B".
    
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
    
    IF (nv_cartyp = "BIKE(บุคคล)") OR (nv_cartyp = "BIKE(พาณิชย์)")  THEN ASSIGN fi_pack = "Z" .  /*Add kridtiya i.A55-0108 */
    IF fi_cover1    = "3" THEN ASSIGN fi_benname  = "" .
    ELSE ASSIGN  fi_benname   = nv_benname .    /*A56-0024*/
    Disp  fi_cover1 fi_pack fi_class fi_benname fi_ispstatus  with frame  fr_main. 
    ... end A63-0392..*/

    APPLY "entry" TO fi_cover1 .
    RETURN NO-APPLY.
    /* End by Phaiboon W. [A59-0488] Date 07/11/2016 */
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
    /* comment by A63-0392...
    IF ra_pa = 1 THEN
        ASSIGN fi_product = "" .
    ELSE ASSIGN fi_product = "PA1" . 
    end A63-0392...*/
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
        gv_prgid = "wgwimpon"
        gv_prog  = "Import text file By Telephone...".
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
        ASSIGN fi_notino =   tlt.nor_noti_tlt             
        fi_notdat        =   tlt.trndat         
        fi_nottim        =   tlt.trntime              
        fi_user          =   tlt.usrid        .
    ASSIGN 
        co_provin:LIST-ITEMS = vAcProc_fil  
        co_provin = ENTRY(1,vAcProc_fil)   
        /*co_brand:LIST-ITEMS = vAcProc_fil1  *//*kridtiya i. A57-0063 */
        /*co_brand  = ENTRY(1,vAcProc_fil1)*/   /*kridtiya i. A57-0063 */
        co_user:LIST-ITEMS = vAcProc_fil2 
        co_user  = ENTRY(1,vAcProc_fil2) 
        co_benname:LIST-ITEMS = vAcProc_fil3 
        co_caruse:LIST-ITEMS  = vAcproc_fil4    /*kridtiya i. A57-0063 */
        co_addr:LIST-ITEMS    = vAcproc_fil5    /*kridtiya i. A57-0063 */
        co_garage:LIST-ITEMS  = vAcproc_fil6    /* add by Phaiboon W. [A59-0488] */
        co_title:LIST-ITEMS = vAcProc_fil7      /* A62-0219*/
        co_benname  = ENTRY(1,vAcProc_fil3) 
        co_caruse   = "เก๋ง"
        fi_comco    = "AYCAL"                               /* add by Phaiboon W. [A59-0488] */
        fi_benname  = "ธนาคารกรุงศรีอยุธยา จำกัด (มหาชน)"   /* add by Phaiboon W. [A59-0488] */
        co_benname  = "ธนาคารกรุงศรีอยุธยา จำกัด (มหาชน)"   /* add by Phaiboon W. [A59-0488] */
        fi_cmrsty   = "M"
        n_brsty     = "M"
        fi_institle = "คุณ"
        fi_comdat   = TODAY
        fi_expdat   = TODAY
        /*fi_nottim   = STRING(TIME,"HH:MM:SS")*/
        /*fi_notino   = "PHONE" + STRING(TODAY,"99/99/9999") + string(TIME,"HH:MM:SS") *//*A55-0073*/
        fi_notino   = n_policy                                                           /*A55-0073*/
        /*fi_campaign = "C" + SUBSTR(STRING(YEAR(TODAY) + 543),3,2) + "/00"*/ /*A62-0219*/
        fi_campaign = " "   /*A62-0219*/
        ra_cover    = 1
        /*ra_cover2   = 1*/  /*A55-0073*/
        fi_cover1   = "2.2"    /*A55-0073*/
        ra_pa       = 1  
        fi_product  = ""
        /*ra_car      = 1*/
        nv_cartyp  = "เก๋ง"
        ra_pree     = 1
        ra_comp     = 1
        ra_complete = 1
        ra_driv     = 1
        /*ra_ban      = 1    /*A55-0108*/*/
        fi_notno70  = ""
        fi_notno72  = ""
        /*fi_pack     = "C" */ /*a63-0392 */
        fi_pack     = "T"     /*a63-0392 */
        fi_class    = "110"
        nv_check70  = "no"
        nv_check72  = "no".
    /*RUN proc_createnoti.*/
    /*comment by Kridtiya i. A55-0073....
    DISP fi_notino    fi_notno70  fi_notno72  fi_comco    fi_institle 
    fi_comdat    fi_expdat   fi_notdat   fi_nottim   fi_campaign ra_pa  
    ra_cover     fi_cover1   fi_product  ra_car      ra_pree     fi_cmrsty
    ra_comp      ra_complete fi_pack     fi_class    With frame   fr_main. 
    end...  comment by Kridtiya i. A55-0073....*/
    /*add  by Kridtiya i. A55-0073....*/
       
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
        /*disable fi_baseod  WITH FRAM fr_main.*//*kridtiya i. A57-0063 */
    DISP  
        fi_comco        fi_cmrsty       fi_institle     fi_comdat       fi_expdat       fi_notdat 
        fi_nottim       fi_notino       fi_campaign     ra_cover        fi_cover1       ra_pa   
        fi_product      /*ra_car */     ra_pree         ra_comp         ra_complete     fi_notno70 
        fi_notno72      fi_pack         fi_class        fi_ins_off      fi_cmrcode      fi_cmrcode2
        fi_producer     fi_agent        fi_preinsur     fi_preinsur2    fi_insadd1no    fi_insadd1mu    
        fi_insadd1build fi_insadd1soy   fi_insadd1road  fi_insadd2tam   fi_insadd3amp   fi_insadd4cunt  
        /*fi_insadd5post  fi_insadd6tel   fi_ispno      co_brand*/      fi_model        fi_year         
        fi_power        fi_licence1     fi_licence2     co_provin       fi_cha_no       fi_eng_no       
        fi_garage       fi_sumsi        fi_gap          fi_premium      fi_precomp      fi_totlepre     
        fi_stk          fi_refer        fi_recipname    fi_vatcode      fi_other2       fi_other3
        co_user         fi_benname       
        co_benname      fi_remark1      fi_remark2      fi_user2         /* ra_ban */     
        fi_user         ra_driv         fi_sumfi   fi_redbook  /*a62-0219*/
        co_caruse       fi_baseod       co_addr    co_garage     With frame   fr_main.          /*A55-0108*/ 
    /* End.*/
    /*end... Kridtiya i. A55-0073....*/
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
  DISPLAY fi_ins_off fi_comco fi_cmrcode fi_cmrcode2 fi_cover1 co_caruse 
          ra_cover fi_campaign ra_pa fi_product ra_pree ra_comp fi_producer 
          fi_agent fi_deler fi_cmrsty fi_quo co_garage co_title fi_institle 
          fi_preinsur fi_preinsur2 fi_idno fi_birthday fi_age fi_idnoexpdat 
          fi_occup fi_namedrirect fi_insadd1no fi_insadd1mu co_addr 
          fi_insadd1build fi_insadd1soy fi_insadd1road fi_insadd2tam 
          fi_insadd3amp fi_insadd4cunt fi_insadd5post fi_insadd6tel fi_comdat 
          fi_expdat fi_ispno fi_ispstatus fi_brand fi_model fi_year fi_power 
          fi_licence1 fi_licence2 co_provin fi_cha_no fi_eng_no ra_driv fi_pack 
          fi_class fi_garage fi_sumsi fi_sumfi fi_gap fi_premium fi_precomp 
          fi_totlepre fi_baseod fi_stk fi_refer fi_recipname fi_vatcode 
          fi_other2 fi_other3 fi_benname co_benname co_user fi_user2 fi_remark1 
          fi_remark2 fi_notno70 fi_notno72 ra_complete fi_user fi_notdat 
          fi_nottim fi_notino fi_redbook 
      WITH FRAME fr_main IN WINDOW wgwimpon.
  ENABLE fi_ins_off fi_comco buselecom fi_cmrcode fi_cmrcode2 fi_cover1 bu_cov 
         co_caruse ra_cover fi_campaign bu_cam ra_pa fi_product bu_product 
         ra_pree ra_comp fi_producer fi_agent fi_deler fi_cmrsty fi_quo 
         cmtoubu_quo co_garage co_title fi_institle fi_preinsur fi_preinsur2 
         fi_idno fi_birthday fi_idnoexpdat fi_occup fi_namedrirect fi_insadd1no 
         fi_insadd1mu co_addr fi_insadd1build fi_insadd1soy fi_insadd1road 
         fi_insadd2tam fi_insadd3amp fi_insadd4cunt fi_insadd5post 
         fi_insadd6tel fi_comdat fi_expdat fi_ispno fi_ispstatus fi_brand 
         bu_brand fi_model fi_year fi_power fi_licence1 fi_licence2 co_provin 
         fi_cha_no fi_eng_no ra_driv fi_pack fi_class fi_garage fi_sumsi 
         fi_sumfi fi_gap fi_premium fi_precomp fi_totlepre fi_baseod fi_stk 
         fi_refer fi_recipname fi_vatcode fi_other2 fi_other3 fi_benname 
         co_benname co_user fi_user2 fi_remark1 fi_remark2 fi_notno70 
         fi_notno72 bu_create bu_notes ra_complete bu_save bu_exit fi_user 
         fi_redbook RECT-483 RECT-487 RECT-488 RECT-489 RECT-490 RECT-499 
         RECT-500 RECT-501 
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PD_BranchNotes wgwimpon 
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
        ELSE DO:
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
        END.
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_getisp wgwimpon 
PROCEDURE proc_getisp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:  create by A62-0219     
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
                        nv_damlist = "จำนวนความเสียหาย " + nv_damlist + " รายการ " .
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
DEF VAR nv_brdesc AS CHAR FORMAT "x(50)" INIT "" .
DEF VAR nv_brcode AS CHAR FORMAT "x(3)" INIT "" .
ASSIGN 
    vAcProc_fil    = ""  
    /*vAcProc_fil1   = ""*/ /*A57-0063*/
    vAcProc_fil2   = ""
    vAcProc_fil3   = ""
    vAcProc_fil4   = ""    /* A57-0063 */
    vAcProc_fil5   = ""    /* A57-0063 */
    vAcproc_fil6   = ""    /* add by Phaiboon W. [A59-0488] Date 15/11/2016 */
    vAcproc_fil7   = ""    /* A62-0219 */
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
                   + "อุทัยธานี"     + "," + "อุบลราชธานี"   
    /*comment by Kridtiya i. A57-0063....
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
    end....comment by kridtiya i. A57-0063.......*/
    /*  comment by A62-0219 .............
   /* Begin by Phaiboon W. [A59-0488] Date 15/11/2016 */
   vAcProc_fil2   = vAcProc_fil2 + " " + "," 
                     + "สุภัทรา เอกศิลป์"           + "," + "กนกพร เลิศพฤกษา"           + "," 
                     + "ชลนิชา แสนคำ"               + "," + "ชิณณาศิต งามกมลชัย"        + "," 
                     + "ชิดพงษ์ ศรีวัฒนานุกูลกิจ"   + "," + "ธนียา นาคบุตร"             + "," 
                     + "นันทิยา เจริญจิตรตระกูล"    + "," + "เนตรนภา ดวงสุดา"           + "," 
                     + "บุปผารัตน์ จารุเศรษฐการ"    + "," + "ประดิษฐ์ โสทอง"            + "," 
                     + "ปัณชรส สังข์มุรินทร์"       + "," + "ปาณรภา ปัญญาทรง"           +  ","
                     + "พนัชกร พุทธโกมล"            + "," + "พักตร์นิภา อนิวรรตานนท์"   + ","
                     + "พัชรี นิยมสัจจา"            + "," + "พัชรี อินทวงศ์"            + ","
                     + "พุธษา จังธนสมบัติ"          + "," + "มัลลิกา จินตนปัญญา"        + ","
                     + "วรวรรณ ปั้นทอง"             + "," + "วิภาพร แซ่จั๊ว"            + ","
                     + "สมฤทัย วิสิฐศักดิ์ไพบูลย์"  + "," + "สาธนีย์ แข็งกลาง"          + ","
                     + "สุดารัตน์ จำนองกาญจนะ"      + "," + "อนุศรา ศิริมนตรี"
       
    /* End by Phaiboon W. [A59-0488] Date 15/11/2016 */
    end A62-0219 ........*/
   
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
    vAcproc_fil6    = vAcproc_fil6
                    + "ซ่อมอู่"    + ","
                    + "ซ่อมห้าง"
    fi_comco    = ""                   
    fi_institle = " "                                
    nv_benname  = ""
    fi_comdat   = TODAY
    fi_expdat   = TODAY
    fi_notdat   = TODAY 
    fi_nottim   = STRING(TIME,"HH:MM:SS")
    /*fi_campaign = "C54/00015"*/ /*A63-0392*/
    ra_cover    = 1
    /*ra_cover2   = 1*/
    fi_cover1   = "1"
    /*ra_car      = 1*/
    co_caruse   = "เก๋ง"
    co_garage   = "ซ่อมอู่"
    ra_pree     = 1
    ra_comp     = 1
    ra_complete = 1
    /*fi_pack     = "G"*/ /*a63-0392*/
    fi_pack     = "T"     /*a63-0392*/
    fi_class    = "110" 
    vAcProc_fil3   = vAcProc_fil3  + " " .

FOR EACH sicsyac.xmm023 NO-LOCK.
    ASSIGN   nv_brdesc = ""   nv_brcode = "" 
        nv_brdesc  = trim(xmm023.bdes)
        nv_brcode  = trim(xmm023.branch)
        nv_brcode  = IF LENGTH(nv_brcode) = 1 THEN " (D" + nv_brcode + ")" ELSE " (" + nv_brcode + ")"
        vAcProc_fil2 = vAcProc_fil2 + " " + "," + nv_brdesc + nv_brcode.
END.

FOR EACH brstat.msgcode WHERE brstat.msgcode.compno  = "999" NO-LOCK .
   ASSIGN
        vAcProc_fil7 = vAcProc_fil7 + " " + "," + trim(brstat.msgcode.branch).
END.

FOR EACH brstat.company WHERE brstat.company.NAME = "phone" NO-LOCK .
    /*DISP (company.NAME + " " + company.NAME2 ) FORMAT "x(60)".*/
    ASSIGN vAcProc_fil3   = vAcProc_fil3  + " " + "," + TRIM(brstat.company.NAME2).
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
    /*fi_campaign = "C54/00015"*/ /*a63-0392*/
    ra_cover    = 1
    fi_cover1   = "1"
    ra_pa       = 1  
    fi_product  = "PA1"
    /*ra_car      = 1*/
    co_caruse   = "เก๋ง"
    ra_pree     = 1
    ra_comp     = 1
    ra_complete = 1
    fi_notno70  = ""
    fi_notno72  = ""
    /*fi_pack     = "G"*/ /*a63-0392*/
    fi_pack     = "T"     /*a63-0392*/
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
    /*co_brand  = ""  */   
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
        fi_product      /*ra_car */     ra_pree         ra_comp         ra_complete     fi_notno70 
        fi_notno72      fi_pack         fi_class        fi_ins_off      fi_cmrcode      fi_cmrcode2
        fi_producer     fi_agent        fi_preinsur     fi_preinsur2    fi_insadd1no    fi_insadd1mu    
        fi_insadd1build fi_insadd1soy   fi_insadd1road  fi_insadd2tam   fi_insadd3amp   fi_insadd4cunt  
        fi_insadd5post  fi_insadd6tel   fi_ispno        /*co_brand*/    fi_model        fi_year         
        fi_power        fi_licence1     fi_licence2     co_provin       fi_cha_no       fi_eng_no       
        fi_garage       fi_sumsi        fi_gap          fi_premium      fi_precomp      fi_totlepre     
        fi_stk          fi_refer        fi_recipname    fi_vatcode      co_user         /*fi_benname  */  
        fi_remark1      fi_user2  co_caruse  With frame   fr_main.
  
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

