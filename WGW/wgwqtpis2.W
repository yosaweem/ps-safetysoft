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
  wuwqtis2.w :  Import text file from  Tpis  to create  new policy   
                         Add in table  tlt  
                         Quey & Update data before Gen.
  Create  by    :  Sarinya c. A64-0432 On   30/12/2021
  /*Modify by      : Kridtiya i. A68-0044 Date. 02/05/2025 Add Drivername 5 Person */ 
+++++++++++++++++++++++++++++++++++++++++++++++*/
Def  Input  PARAMETER  nv_recidtlt  as  recid  .
Def  var nv_index  as int  init 0.
DEF  VAR nv_chaidrep AS CHAR . 
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
DEF VAR n_Rec_name72  AS CHAR FORMAT "x(150)" INIT "".   
DEF VAR n_Rec_add1    AS CHAR FORMAT "x(60)"  INIT "".   
DEF VAR n_Rec_add2    AS CHAR FORMAT "x(60)"  INIT "".   
DEF VAR nv_cutrec     AS CHAR FORMAT "x(200)" INIT "".

DEF VAR n_list      AS INT init 0.
DEF VAR n_count     AS INT init 0.
DEF VAR n_repair    AS CHAR FORMAT "x(10)" init "".
DEF VAR n_dam       AS CHAR FORMAT "x(10)" init "".
DEF VAR n_deatil    AS CHAR FORMAT "x(60)" init "".
DEF VAR nv_damag    AS CHAR FORMAT "x(30)" init "".
DEF VAR nv_repair   AS CHAR FORMAT "x(30)" init "".
DEF VAR nv_damdetail AS LONGCHAR  INIT "".
DEF VAR nv_docno     AS CHAR FORMAT "x(15)" .
DEF VAR nv_survey   AS CHAR FORMAT "x(50)" .
DEF VAR nv_detail   AS CHAR FORMAT "x(255)".
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
Def var nv_acctotal      as char format "x(250)".  
DEF VAR nv_today         AS CHAR FORMAT "x(15)" .

def var nv_title       as char format "x(50)" .
def var nv_firstname   as char format "x(100)" .
def var nv_lastname    as char format "x(100)" .
def var nv_sumfi       as char format "x(15)" .
def var nv_comdat      as char format "x(15)" .
def var nv_expdat      as char format "x(15)" .
def var nv_gprem       as char format "x(15)" .
def var nv_producer    as char format "x(10)" .

DEF VAR nv_nameT         AS CHAR FORMAT "X(50)".
DEF VAR nv_agentname     AS CHAR FORMAT "X(60)".
DEF VAR nv_brand         AS CHAR FORMAT "X(50)". 
DEF VAR nv_model         AS CHAR FORMAT "X(50)". 
DEF VAR nv_licentyp      AS CHAR FORMAT "X(50)".
DEF VAR nv_licen         AS CHAR FORMAT "X(20)". 
DEF VAR nv_pattern1      AS CHAR FORMAT "X(20)".  
DEF VAR nv_pattern4      AS CHAR FORMAT "X(20)".  
DEF VAR nv_nolicen       AS CHAR FORMAT "x(15)".
DEF VAR nv_province      AS CHAR FORMAT "x(10)".
DEF VAR nv_time          AS CHAR FORMAT "x(15)" .

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS fi_ispno fi_Usage fi_prvpol fi_polsystem ~
fi_mdyear fi_eng_no fi_cc fi_year fi_color fi_cha_no fi_brand fi_licence ~
fi_province fi_acc fi_compulsory bu_save ra_poltyp bu_exit fi_carmodel ~
fi_accamt fi_inspection fi_ispdetail fi_flag fi_ispdamage fi_ispacc fi_acc2 ~
fi_insp fi_ispdamage2 fi_ispacc2 cb_problem bu_upins bu_addisp fi_dri1_tlt ~
fi_dri1_name fi_dri1_name2 fi_dri1_birth fi_dri1_idno fi_dri1_lice ~
fi_dri1_occ fi_dri2_tlt fi_dri2_name fi_dri2_name2 fi_dri2_birth ~
fi_dri2_idno fi_dri2_lice fi_dri2_occ fi_dri3_tlt fi_dri3_name ~
fi_dri3_name2 fi_dri3_birth fi_dri3_idno fi_dri3_lice fi_dri3_occ ~
fi_dri4_tlt fi_dri4_name fi_dri4_name2 fi_dri4_birth fi_dri4_idno ~
fi_dri4_lice fi_dri4_occ fi_dri5_tlt fi_dri5_name fi_dri5_name2 ~
fi_dri5_birth fi_dri5_idno fi_dri5_lice fi_dri5_occ RECT-340 RECT-341 ~
RECT-342 
&Scoped-Define DISPLAYED-OBJECTS fi_ispno fi_Usage fi_prvpol fi_polsystem ~
fi_mdyear fi_eng_no fi_cc fi_year fi_color fi_cha_no fi_brand fi_licence ~
fi_province fi_acc fi_compulsory ra_poltyp fi_userid fi_carmodel fi_accamt ~
fi_userupdate fi_updat fi_inspection fi_ispdetail fi_flag fi_timeup ~
fi_ispdamage fi_ispacc fi_acc2 fi_insp fi_ispdamage2 fi_ispacc2 cb_problem ~
fi_dri1_tlt fi_dri1_name fi_dri1_name2 fi_dri1_birth fi_dri1_idno ~
fi_dri1_lice fi_dri1_occ fi_dri2_tlt fi_dri2_name fi_dri2_name2 ~
fi_dri2_birth fi_dri2_idno fi_dri2_lice fi_dri2_occ fi_dri3_tlt ~
fi_dri3_name fi_dri3_name2 fi_dri3_birth fi_dri3_idno fi_dri3_lice ~
fi_dri3_occ fi_dri4_tlt fi_dri4_name fi_dri4_name2 fi_dri4_birth ~
fi_dri4_idno fi_dri4_lice fi_dri4_occ fi_dri5_tlt fi_dri5_name ~
fi_dri5_name2 fi_dri5_birth fi_dri5_idno fi_dri5_lice fi_dri5_occ 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bu_addisp 
     LABEL "CREATE ISP" 
     SIZE 14.83 BY .91
     BGCOLOR 7 FGCOLOR 4 FONT 6.

DEFINE BUTTON bu_exit 
     LABEL "Exit" 
     SIZE 8 BY 1.29
     BGCOLOR 6 FGCOLOR 6 FONT 6.

DEFINE BUTTON bu_save 
     LABEL "Save" 
     SIZE 8 BY 1.29
     BGCOLOR 2 FGCOLOR 2 FONT 6.

DEFINE BUTTON bu_upins 
     LABEL "UPDATE ISP" 
     SIZE 15.33 BY .91
     BGCOLOR 2 FGCOLOR 2 FONT 6.

DEFINE VARIABLE cb_problem AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEM-PAIRS "Yes","1 ",
                     "No","2"
     DROP-DOWN-LIST
     SIZE 8 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_acc AS CHARACTER FORMAT "X(150)":U 
     VIEW-AS FILL-IN 
     SIZE 111.5 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_acc2 AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 74.17 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_accamt AS INTEGER FORMAT "->,>>>,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_brand AS CHARACTER FORMAT "X(35)":U 
     VIEW-AS FILL-IN 
     SIZE 16.83 BY .95
     BGCOLOR 15 FGCOLOR 1 FONT 1 NO-UNDO.

DEFINE VARIABLE fi_carmodel AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 27.5 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_cc AS DECIMAL FORMAT "->>>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 12 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_cha_no AS CHARACTER FORMAT "X(35)":U 
     VIEW-AS FILL-IN 
     SIZE 23.83 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_color AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 16.83 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_compulsory AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 17.83 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_dri1_birth AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 10 BY .81
     BGCOLOR 15 FGCOLOR 1 FONT 1 NO-UNDO.

DEFINE VARIABLE fi_dri1_idno AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .81
     BGCOLOR 15 FGCOLOR 1 FONT 1 NO-UNDO.

DEFINE VARIABLE fi_dri1_lice AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .81
     BGCOLOR 15 FGCOLOR 1 FONT 1 NO-UNDO.

DEFINE VARIABLE fi_dri1_name AS CHARACTER FORMAT "X(60)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .81
     BGCOLOR 15 FGCOLOR 1 FONT 1 NO-UNDO.

DEFINE VARIABLE fi_dri1_name2 AS CHARACTER FORMAT "X(60)":U 
     VIEW-AS FILL-IN 
     SIZE 19 BY .81
     BGCOLOR 15 FGCOLOR 1 FONT 1 NO-UNDO.

DEFINE VARIABLE fi_dri1_occ AS CHARACTER FORMAT "X(60)":U 
     VIEW-AS FILL-IN 
     SIZE 16 BY .81
     BGCOLOR 15 FGCOLOR 1 FONT 1 NO-UNDO.

DEFINE VARIABLE fi_dri1_tlt AS CHARACTER FORMAT "X(60)":U 
     VIEW-AS FILL-IN 
     SIZE 11 BY .81
     BGCOLOR 15 FGCOLOR 1 FONT 1 NO-UNDO.

DEFINE VARIABLE fi_dri2_birth AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 10 BY .81
     BGCOLOR 15 FGCOLOR 1 FONT 1 NO-UNDO.

DEFINE VARIABLE fi_dri2_idno AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .81
     BGCOLOR 15 FGCOLOR 1 FONT 1 NO-UNDO.

DEFINE VARIABLE fi_dri2_lice AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .81
     BGCOLOR 15 FGCOLOR 1 FONT 1 NO-UNDO.

DEFINE VARIABLE fi_dri2_name AS CHARACTER FORMAT "X(60)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .81
     BGCOLOR 15 FGCOLOR 1 FONT 1 NO-UNDO.

DEFINE VARIABLE fi_dri2_name2 AS CHARACTER FORMAT "X(60)":U 
     VIEW-AS FILL-IN 
     SIZE 19 BY .81
     BGCOLOR 15 FGCOLOR 1 FONT 1 NO-UNDO.

DEFINE VARIABLE fi_dri2_occ AS CHARACTER FORMAT "X(60)":U 
     VIEW-AS FILL-IN 
     SIZE 16 BY .81
     BGCOLOR 15 FGCOLOR 1 FONT 1 NO-UNDO.

DEFINE VARIABLE fi_dri2_tlt AS CHARACTER FORMAT "X(60)":U 
     VIEW-AS FILL-IN 
     SIZE 11 BY .81
     BGCOLOR 15 FGCOLOR 1 FONT 1 NO-UNDO.

DEFINE VARIABLE fi_dri3_birth AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 10 BY .81
     BGCOLOR 15 FGCOLOR 1 FONT 1 NO-UNDO.

DEFINE VARIABLE fi_dri3_idno AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .81
     BGCOLOR 15 FGCOLOR 1 FONT 1 NO-UNDO.

DEFINE VARIABLE fi_dri3_lice AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .81
     BGCOLOR 15 FGCOLOR 1 FONT 1 NO-UNDO.

DEFINE VARIABLE fi_dri3_name AS CHARACTER FORMAT "X(60)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .81
     BGCOLOR 15 FGCOLOR 1 FONT 1 NO-UNDO.

DEFINE VARIABLE fi_dri3_name2 AS CHARACTER FORMAT "X(60)":U 
     VIEW-AS FILL-IN 
     SIZE 19 BY .81
     BGCOLOR 15 FGCOLOR 1 FONT 1 NO-UNDO.

DEFINE VARIABLE fi_dri3_occ AS CHARACTER FORMAT "X(60)":U 
     VIEW-AS FILL-IN 
     SIZE 16 BY .81
     BGCOLOR 15 FGCOLOR 1 FONT 1 NO-UNDO.

DEFINE VARIABLE fi_dri3_tlt AS CHARACTER FORMAT "X(60)":U 
     VIEW-AS FILL-IN 
     SIZE 11 BY .81
     BGCOLOR 15 FGCOLOR 1 FONT 1 NO-UNDO.

DEFINE VARIABLE fi_dri4_birth AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 10 BY .81
     BGCOLOR 15 FGCOLOR 1 FONT 1 NO-UNDO.

DEFINE VARIABLE fi_dri4_idno AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .81
     BGCOLOR 15 FGCOLOR 1 FONT 1 NO-UNDO.

DEFINE VARIABLE fi_dri4_lice AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .81
     BGCOLOR 15 FGCOLOR 1 FONT 1 NO-UNDO.

DEFINE VARIABLE fi_dri4_name AS CHARACTER FORMAT "X(60)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .81
     BGCOLOR 15 FGCOLOR 1 FONT 1 NO-UNDO.

DEFINE VARIABLE fi_dri4_name2 AS CHARACTER FORMAT "X(60)":U 
     VIEW-AS FILL-IN 
     SIZE 19 BY .81
     BGCOLOR 15 FGCOLOR 1 FONT 1 NO-UNDO.

DEFINE VARIABLE fi_dri4_occ AS CHARACTER FORMAT "X(60)":U 
     VIEW-AS FILL-IN 
     SIZE 16 BY .81
     BGCOLOR 15 FGCOLOR 1 FONT 1 NO-UNDO.

DEFINE VARIABLE fi_dri4_tlt AS CHARACTER FORMAT "X(60)":U 
     VIEW-AS FILL-IN 
     SIZE 11 BY .81
     BGCOLOR 15 FGCOLOR 1 FONT 1 NO-UNDO.

DEFINE VARIABLE fi_dri5_birth AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 10 BY .81
     BGCOLOR 15 FGCOLOR 1 FONT 1 NO-UNDO.

DEFINE VARIABLE fi_dri5_idno AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .81
     BGCOLOR 15 FGCOLOR 1 FONT 1 NO-UNDO.

DEFINE VARIABLE fi_dri5_lice AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .81
     BGCOLOR 15 FGCOLOR 1 FONT 1 NO-UNDO.

DEFINE VARIABLE fi_dri5_name AS CHARACTER FORMAT "X(60)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .81
     BGCOLOR 15 FGCOLOR 1 FONT 1 NO-UNDO.

DEFINE VARIABLE fi_dri5_name2 AS CHARACTER FORMAT "X(60)":U 
     VIEW-AS FILL-IN 
     SIZE 19 BY .81
     BGCOLOR 15 FGCOLOR 1 FONT 1 NO-UNDO.

DEFINE VARIABLE fi_dri5_occ AS CHARACTER FORMAT "X(60)":U 
     VIEW-AS FILL-IN 
     SIZE 16 BY .81
     BGCOLOR 15 FGCOLOR 1 FONT 1 NO-UNDO.

DEFINE VARIABLE fi_dri5_tlt AS CHARACTER FORMAT "X(60)":U 
     VIEW-AS FILL-IN 
     SIZE 11 BY .81
     BGCOLOR 15 FGCOLOR 1 FONT 1 NO-UNDO.

DEFINE VARIABLE fi_eng_no AS CHARACTER FORMAT "X(35)":U 
     VIEW-AS FILL-IN 
     SIZE 27.33 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_flag AS CHARACTER FORMAT "X(10)":U 
      VIEW-AS TEXT 
     SIZE 11.17 BY .91
     BGCOLOR 33  NO-UNDO.

DEFINE VARIABLE fi_insp AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 9.67 BY .91
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_inspection AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 5.67 BY .91
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_ispacc AS CHARACTER FORMAT "X(150)":U 
     VIEW-AS FILL-IN 
     SIZE 104.5 BY .91
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_ispacc2 AS CHARACTER FORMAT "X(150)":U 
     VIEW-AS FILL-IN 
     SIZE 104.5 BY .91
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_ispdamage AS CHARACTER FORMAT "X(150)":U 
     VIEW-AS FILL-IN 
     SIZE 104.5 BY .91
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_ispdamage2 AS CHARACTER FORMAT "X(150)":U 
     VIEW-AS FILL-IN 
     SIZE 104.5 BY .91
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_ispdetail AS CHARACTER FORMAT "X(35)":U 
     VIEW-AS FILL-IN 
     SIZE 27.67 BY .91
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_ispno AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 20.83 BY .91
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_licence AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 13.5 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_mdyear AS CHARACTER FORMAT "X(4)":U INITIAL "0" 
     VIEW-AS FILL-IN 
     SIZE 7.5 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_polsystem AS CHARACTER FORMAT "X(16)":U 
     VIEW-AS FILL-IN 
     SIZE 18.83 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_province AS CHARACTER FORMAT "X(35)":U 
     VIEW-AS FILL-IN 
     SIZE 10.5 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_prvpol AS CHARACTER FORMAT "X(26)":U 
     VIEW-AS FILL-IN 
     SIZE 18.67 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_timeup AS CHARACTER FORMAT "X(15)":U 
      VIEW-AS TEXT 
     SIZE 10.17 BY .71
     BGCOLOR 33 FGCOLOR 1 FONT 1 NO-UNDO.

DEFINE VARIABLE fi_updat AS DATE FORMAT "99/99/9999":U 
      VIEW-AS TEXT 
     SIZE 10 BY .71
     BGCOLOR 33 FGCOLOR 1 FONT 1 NO-UNDO.

DEFINE VARIABLE fi_Usage AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 42.17 BY 1
     BGCOLOR 15 FGCOLOR 1 FONT 1 NO-UNDO.

DEFINE VARIABLE fi_userid AS CHARACTER FORMAT "X(10)":U 
      VIEW-AS TEXT 
     SIZE 7.5 BY .71
     BGCOLOR 33 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_userupdate AS CHARACTER FORMAT "X(10)":U 
      VIEW-AS TEXT 
     SIZE 7.33 BY .71
     BGCOLOR 33 FGCOLOR 0 FONT 1 NO-UNDO.

DEFINE VARIABLE fi_year AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 10.33 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE ra_poltyp AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "New", 1,
"Renew", 2,
"Transfer", 3,
"Usedcar", 4,
"Refinance", 5
     SIZE 48.5 BY 1.19
     BGCOLOR 33 FGCOLOR 7 FONT 1 NO-UNDO.

DEFINE RECTANGLE RECT-340
     EDGE-PIXELS 2 GRAPHIC-EDGE    ROUNDED 
     SIZE 132 BY 6.48
     BGCOLOR 34 FGCOLOR 2 .

DEFINE RECTANGLE RECT-341
     EDGE-PIXELS 2 GRAPHIC-EDGE    ROUNDED 
     SIZE 129 BY 7.14
     BGCOLOR 34 FGCOLOR 2 .

DEFINE RECTANGLE RECT-342
     EDGE-PIXELS 2 GRAPHIC-EDGE    ROUNDED 
     SIZE 132 BY 2
     BGCOLOR 33 FGCOLOR 34 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     fi_ispno AT ROW 17.48 COL 21.17 COLON-ALIGNED NO-LABEL WIDGET-ID 154
     fi_Usage AT ROW 5.71 COL 13 COLON-ALIGNED NO-LABEL WIDGET-ID 12
     fi_prvpol AT ROW 2.05 COL 61.33 COLON-ALIGNED NO-LABEL
     fi_polsystem AT ROW 2.05 COL 86.67 COLON-ALIGNED NO-LABEL
     fi_mdyear AT ROW 4.57 COL 82.67 COLON-ALIGNED NO-LABEL
     fi_eng_no AT ROW 6.95 COL 13 COLON-ALIGNED NO-LABEL
     fi_cc AT ROW 5.71 COL 100.17 COLON-ALIGNED NO-LABEL
     fi_year AT ROW 5.76 COL 120.17 COLON-ALIGNED NO-LABEL
     fi_color AT ROW 5.71 COL 63.67 COLON-ALIGNED NO-LABEL
     fi_cha_no AT ROW 7.05 COL 53.83 COLON-ALIGNED NO-LABEL
     fi_brand AT ROW 4.62 COL 13 COLON-ALIGNED NO-LABEL
     fi_licence AT ROW 7 COL 91.83 COLON-ALIGNED NO-LABEL
     fi_province AT ROW 7 COL 119.83 COLON-ALIGNED NO-LABEL
     fi_acc AT ROW 8.14 COL 18.5 NO-LABEL
     fi_compulsory AT ROW 2.05 COL 111.17 COLON-ALIGNED NO-LABEL
     bu_save AT ROW 23.19 COL 113.5
     ra_poltyp AT ROW 1.52 COL 10.5 NO-LABEL
     bu_exit AT ROW 23.14 COL 122
     fi_userid AT ROW 23.48 COL 54.17 COLON-ALIGNED NO-LABEL
     fi_carmodel AT ROW 4.62 COL 41.67 COLON-ALIGNED NO-LABEL WIDGET-ID 54
     fi_accamt AT ROW 9.14 COL 112.67 COLON-ALIGNED NO-LABEL WIDGET-ID 86
     fi_userupdate AT ROW 23.52 COL 73.17 COLON-ALIGNED NO-LABEL WIDGET-ID 132
     fi_updat AT ROW 23.48 COL 89 COLON-ALIGNED NO-LABEL WIDGET-ID 138
     fi_inspection AT ROW 16.48 COL 48.33 COLON-ALIGNED NO-LABEL WIDGET-ID 156
     fi_ispdetail AT ROW 17.48 COL 63.83 COLON-ALIGNED NO-LABEL WIDGET-ID 168
     fi_flag AT ROW 23.38 COL 9.17 COLON-ALIGNED NO-LABEL WIDGET-ID 176
     fi_timeup AT ROW 23.48 COL 99.17 COLON-ALIGNED NO-LABEL WIDGET-ID 188
     fi_ispdamage AT ROW 18.52 COL 21 COLON-ALIGNED NO-LABEL WIDGET-ID 194
     fi_ispacc AT ROW 20.52 COL 21 COLON-ALIGNED NO-LABEL WIDGET-ID 198 DISABLE-AUTO-ZAP 
     fi_acc2 AT ROW 9.19 COL 18.5 NO-LABEL WIDGET-ID 204
     fi_insp AT ROW 16.43 COL 21.33 COLON-ALIGNED NO-LABEL WIDGET-ID 210
     fi_ispdamage2 AT ROW 19.48 COL 21 COLON-ALIGNED NO-LABEL WIDGET-ID 214
     fi_ispacc2 AT ROW 21.52 COL 21 COLON-ALIGNED NO-LABEL WIDGET-ID 216
     cb_problem AT ROW 23.38 COL 35.67 COLON-ALIGNED NO-LABEL WIDGET-ID 254
     bu_upins AT ROW 17.33 COL 95.83 WIDGET-ID 260
     bu_addisp AT ROW 17.33 COL 112.17 WIDGET-ID 258
     fi_dri1_tlt AT ROW 10.76 COL 5 COLON-ALIGNED NO-LABEL WIDGET-ID 264
     fi_dri1_name AT ROW 10.76 COL 19.67 COLON-ALIGNED NO-LABEL WIDGET-ID 266
     fi_dri1_name2 AT ROW 10.76 COL 37.83 COLON-ALIGNED NO-LABEL WIDGET-ID 268
     fi_dri1_birth AT ROW 10.76 COL 63.5 COLON-ALIGNED NO-LABEL WIDGET-ID 270
     fi_dri1_idno AT ROW 10.76 COL 77.17 COLON-ALIGNED NO-LABEL WIDGET-ID 272
     fi_dri1_lice AT ROW 10.76 COL 97 COLON-ALIGNED NO-LABEL WIDGET-ID 274
     fi_dri1_occ AT ROW 10.76 COL 115 COLON-ALIGNED NO-LABEL WIDGET-ID 276
     fi_dri2_tlt AT ROW 11.71 COL 5 COLON-ALIGNED NO-LABEL WIDGET-ID 304
     fi_dri2_name AT ROW 11.71 COL 19.67 COLON-ALIGNED NO-LABEL WIDGET-ID 298
     fi_dri2_name2 AT ROW 11.71 COL 37.83 COLON-ALIGNED NO-LABEL WIDGET-ID 300
     fi_dri2_birth AT ROW 11.71 COL 63.5 COLON-ALIGNED NO-LABEL WIDGET-ID 292
     fi_dri2_idno AT ROW 11.71 COL 77.17 COLON-ALIGNED NO-LABEL WIDGET-ID 294
     fi_dri2_lice AT ROW 11.71 COL 97 COLON-ALIGNED NO-LABEL WIDGET-ID 296
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1.17 ROW 1.05
         SIZE 133 BY 24
         BGCOLOR 29 FGCOLOR 1 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     fi_dri2_occ AT ROW 11.71 COL 115 COLON-ALIGNED NO-LABEL WIDGET-ID 302
     fi_dri3_tlt AT ROW 12.67 COL 5 COLON-ALIGNED NO-LABEL WIDGET-ID 332
     fi_dri3_name AT ROW 12.67 COL 19.67 COLON-ALIGNED NO-LABEL WIDGET-ID 326
     fi_dri3_name2 AT ROW 12.67 COL 37.83 COLON-ALIGNED NO-LABEL WIDGET-ID 328
     fi_dri3_birth AT ROW 12.67 COL 63.5 COLON-ALIGNED NO-LABEL WIDGET-ID 320
     fi_dri3_idno AT ROW 12.67 COL 77.17 COLON-ALIGNED NO-LABEL WIDGET-ID 322
     fi_dri3_lice AT ROW 12.67 COL 97 COLON-ALIGNED NO-LABEL WIDGET-ID 324
     fi_dri3_occ AT ROW 12.67 COL 115 COLON-ALIGNED NO-LABEL WIDGET-ID 330
     fi_dri4_tlt AT ROW 13.62 COL 5 COLON-ALIGNED NO-LABEL WIDGET-ID 360
     fi_dri4_name AT ROW 13.62 COL 19.67 COLON-ALIGNED NO-LABEL WIDGET-ID 354
     fi_dri4_name2 AT ROW 13.62 COL 37.83 COLON-ALIGNED NO-LABEL WIDGET-ID 356
     fi_dri4_birth AT ROW 13.62 COL 63.5 COLON-ALIGNED NO-LABEL WIDGET-ID 348
     fi_dri4_idno AT ROW 13.62 COL 77.17 COLON-ALIGNED NO-LABEL WIDGET-ID 350
     fi_dri4_lice AT ROW 13.62 COL 97 COLON-ALIGNED NO-LABEL WIDGET-ID 352
     fi_dri4_occ AT ROW 13.62 COL 115 COLON-ALIGNED NO-LABEL WIDGET-ID 358
     fi_dri5_tlt AT ROW 14.57 COL 5 COLON-ALIGNED NO-LABEL WIDGET-ID 388
     fi_dri5_name AT ROW 14.57 COL 19.67 COLON-ALIGNED NO-LABEL WIDGET-ID 382
     fi_dri5_name2 AT ROW 14.57 COL 37.83 COLON-ALIGNED NO-LABEL WIDGET-ID 384
     fi_dri5_birth AT ROW 14.57 COL 63.5 COLON-ALIGNED NO-LABEL WIDGET-ID 376
     fi_dri5_idno AT ROW 14.57 COL 77.17 COLON-ALIGNED NO-LABEL WIDGET-ID 378
     fi_dri5_lice AT ROW 14.57 COL 97 COLON-ALIGNED NO-LABEL WIDGET-ID 380
     fi_dri5_occ AT ROW 14.57 COL 115 COLON-ALIGNED NO-LABEL WIDGET-ID 386
     " Color :":35 VIEW-AS TEXT
          SIZE 6.17 BY 1 AT ROW 5.71 COL 59
          BGCOLOR 34 FGCOLOR 0 FONT 1
     "Model Year :":35 VIEW-AS TEXT
          SIZE 12 BY .95 AT ROW 4.57 COL 72.5
          BGCOLOR 34 FGCOLOR 0 FONT 1
     "Flag Problem :":30 VIEW-AS TEXT
          SIZE 14.17 BY .95 AT ROW 23.38 COL 23.5 WIDGET-ID 182
          BGCOLOR 29 FGCOLOR 4 FONT 6
     "Comp. no :":30 VIEW-AS TEXT
          SIZE 10.17 BY .76 AT ROW 1.24 COL 113.33
          BGCOLOR 33 FGCOLOR 1 FONT 6
     "Inspection No :":30 VIEW-AS TEXT
          SIZE 12.5 BY .95 AT ROW 17.48 COL 10 WIDGET-ID 190
          BGCOLOR 34 FGCOLOR 2 FONT 1
     "Policy no :":35 VIEW-AS TEXT
          SIZE 10.5 BY .76 AT ROW 1.29 COL 88.83
          BGCOLOR 33 FONT 6
     "สกุล":30 VIEW-AS TEXT
          SIZE 3.5 BY .81 AT ROW 12.67 COL 36 WIDGET-ID 338
          BGCOLOR 34 FGCOLOR 0 FONT 1
     "Chassis No :":20 VIEW-AS TEXT
          SIZE 9.83 BY .95 AT ROW 7.05 COL 45.5
          BGCOLOR 34 FGCOLOR 0 FONT 1
     " Inspection Detail :":30 VIEW-AS TEXT
          SIZE 28 BY .81 AT ROW 15.52 COL 3 WIDGET-ID 244
          BGCOLOR 29 FGCOLOR 4 FONT 2
     "Dri 1:":30 VIEW-AS TEXT
          SIZE 4.5 BY .81 AT ROW 10.76 COL 2 WIDGET-ID 278
          BGCOLOR 34 FGCOLOR 0 FONT 1
     "ชื่อ":30 VIEW-AS TEXT
          SIZE 2.5 BY .81 AT ROW 10.76 COL 18.5 WIDGET-ID 280
          BGCOLOR 34 FGCOLOR 0 FONT 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1.17 ROW 1.05
         SIZE 133 BY 24
         BGCOLOR 29 FGCOLOR 1 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "User Load :":30 VIEW-AS TEXT
          SIZE 9.5 BY .91 AT ROW 23.38 COL 46.5 WIDGET-ID 134
          BGCOLOR 19 FGCOLOR 4 FONT 1
     "สกุล":30 VIEW-AS TEXT
          SIZE 3.5 BY .81 AT ROW 10.76 COL 36 WIDGET-ID 282
          BGCOLOR 34 FGCOLOR 0 FONT 1
     "Dri 4:":30 VIEW-AS TEXT
          SIZE 4.5 BY .81 AT ROW 13.62 COL 2 WIDGET-ID 362
          BGCOLOR 34 FGCOLOR 0 FONT 1
     " Car Detail :":30 VIEW-AS TEXT
          SIZE 18.5 BY .81 AT ROW 3.24 COL 2 WIDGET-ID 256
          BGCOLOR 29 FGCOLOR 4 FONT 2
     "Licenes No :":30 VIEW-AS TEXT
          SIZE 11 BY .95 AT ROW 7 COL 82.5
          BGCOLOR 34 FGCOLOR 0 FONT 1
     "วันเกิด":30 VIEW-AS TEXT
          SIZE 5.5 BY .81 AT ROW 10.76 COL 59.5 WIDGET-ID 284
          BGCOLOR 34 FGCOLOR 0 FONT 1
     "Status :":30 VIEW-AS TEXT
          SIZE 8 BY .95 AT ROW 23.38 COL 3 WIDGET-ID 178
          BGCOLOR 29 FGCOLOR 4 FONT 6
     "ID":30 VIEW-AS TEXT
          SIZE 2.5 BY .81 AT ROW 10.76 COL 76 WIDGET-ID 286
          BGCOLOR 34 FGCOLOR 0 FONT 1
     "Lice":30 VIEW-AS TEXT
          SIZE 4 BY .81 AT ROW 10.76 COL 94.5 WIDGET-ID 288
          BGCOLOR 34 FGCOLOR 0 FONT 1
     "Dri 5:":30 VIEW-AS TEXT
          SIZE 4.5 BY .81 AT ROW 14.57 COL 2 WIDGET-ID 390
          BGCOLOR 34 FGCOLOR 0 FONT 1
     "สกุล":30 VIEW-AS TEXT
          SIZE 3.5 BY .81 AT ROW 14.57 COL 36 WIDGET-ID 394
          BGCOLOR 34 FGCOLOR 0 FONT 1
     "User Update:":30 VIEW-AS TEXT
          SIZE 10.83 BY .91 AT ROW 23.38 COL 64 WIDGET-ID 136
          BGCOLOR 19 FGCOLOR 4 FONT 1
     "Occ":30 VIEW-AS TEXT
          SIZE 3.5 BY .81 AT ROW 10.76 COL 113.17 WIDGET-ID 290
          BGCOLOR 34 FGCOLOR 0 FONT 1
     "Dri 2:":30 VIEW-AS TEXT
          SIZE 4.5 BY .81 AT ROW 11.71 COL 2 WIDGET-ID 306
          BGCOLOR 34 FGCOLOR 0 FONT 1
     "วันเกิด":30 VIEW-AS TEXT
          SIZE 5.5 BY .81 AT ROW 12.67 COL 59.5 WIDGET-ID 340
          BGCOLOR 34 FGCOLOR 0 FONT 1
     "ชื่อ":30 VIEW-AS TEXT
          SIZE 2.5 BY .81 AT ROW 11.71 COL 18.5 WIDGET-ID 308
          BGCOLOR 34 FGCOLOR 0 FONT 1
     "Occ":30 VIEW-AS TEXT
          SIZE 3.5 BY .81 AT ROW 14.57 COL 113.17 WIDGET-ID 402
          BGCOLOR 34 FGCOLOR 0 FONT 1
     "Inspection Year :":30 VIEW-AS TEXT
          SIZE 13.5 BY .95 AT ROW 16.43 COL 9 WIDGET-ID 212
          BGCOLOR 34 FGCOLOR 2 FONT 1
     "สกุล":30 VIEW-AS TEXT
          SIZE 3.5 BY .81 AT ROW 11.71 COL 36 WIDGET-ID 310
          BGCOLOR 34 FGCOLOR 0 FONT 1
     "วันเกิด":30 VIEW-AS TEXT
          SIZE 5.5 BY .81 AT ROW 11.71 COL 59.5 WIDGET-ID 312
          BGCOLOR 34 FGCOLOR 0 FONT 1
     "วันเกิด":30 VIEW-AS TEXT
          SIZE 5.5 BY .81 AT ROW 13.62 COL 59.5 WIDGET-ID 368
          BGCOLOR 34 FGCOLOR 0 FONT 1
     "ID":30 VIEW-AS TEXT
          SIZE 2.5 BY .81 AT ROW 11.71 COL 76 WIDGET-ID 314
          BGCOLOR 34 FGCOLOR 0 FONT 1
     "Accessories amount :":30 VIEW-AS TEXT
          SIZE 20.33 BY .95 AT ROW 9.14 COL 94 WIDGET-ID 88
          BGCOLOR 34 FGCOLOR 1 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1.17 ROW 1.05
         SIZE 133 BY 24
         BGCOLOR 29 FGCOLOR 1 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     " Accessories  :":30 VIEW-AS TEXT
          SIZE 14.5 BY .95 AT ROW 8.1 COL 3.5
          BGCOLOR 34 FGCOLOR 1 FONT 6
     "Lice":30 VIEW-AS TEXT
          SIZE 4 BY .81 AT ROW 11.71 COL 94.5 WIDGET-ID 316
          BGCOLOR 34 FGCOLOR 0 FONT 1
     "Occ":30 VIEW-AS TEXT
          SIZE 3.5 BY .81 AT ROW 11.71 COL 113.17 WIDGET-ID 318
          BGCOLOR 34 FGCOLOR 0 FONT 1
     "วันเกิด":30 VIEW-AS TEXT
          SIZE 5.5 BY .81 AT ROW 14.57 COL 59.5 WIDGET-ID 396
          BGCOLOR 34 FGCOLOR 0 FONT 1
     "ID":30 VIEW-AS TEXT
          SIZE 2.5 BY .81 AT ROW 12.67 COL 76 WIDGET-ID 342
          BGCOLOR 34 FGCOLOR 0 FONT 1
     "Update :":30 VIEW-AS TEXT
          SIZE 7 BY .91 AT ROW 23.38 COL 83.33 WIDGET-ID 140
          BGCOLOR 19 FGCOLOR 1 FONT 1
     "Lice":30 VIEW-AS TEXT
          SIZE 4 BY .81 AT ROW 12.67 COL 94.5 WIDGET-ID 344
          BGCOLOR 34 FGCOLOR 0 FONT 1
     "Occ":30 VIEW-AS TEXT
          SIZE 3.5 BY .81 AT ROW 12.67 COL 113.17 WIDGET-ID 346
          BGCOLOR 34 FGCOLOR 0 FONT 1
     "TYPE :":35 VIEW-AS TEXT
          SIZE 7.5 BY .76 AT ROW 1.76 COL 2.67 WIDGET-ID 218
          BGCOLOR 33 FONT 6
     "ID":30 VIEW-AS TEXT
          SIZE 2.5 BY .81 AT ROW 13.62 COL 76 WIDGET-ID 370
          BGCOLOR 34 FGCOLOR 0 FONT 1
     "Inspection :":30 VIEW-AS TEXT
          SIZE 9.5 BY .95 AT ROW 16.43 COL 40.5 WIDGET-ID 162
          BGCOLOR 34 FGCOLOR 2 FONT 1
     "Lice":30 VIEW-AS TEXT
          SIZE 4 BY .81 AT ROW 13.62 COL 94.5 WIDGET-ID 372
          BGCOLOR 34 FGCOLOR 0 FONT 1
     "Occ":30 VIEW-AS TEXT
          SIZE 3.5 BY .81 AT ROW 13.62 COL 113.17 WIDGET-ID 374
          BGCOLOR 34 FGCOLOR 0 FONT 1
     "Brand :":30 VIEW-AS TEXT
          SIZE 5.83 BY .95 AT ROW 4.67 COL 8.83
          BGCOLOR 34 FGCOLOR 0 FONT 1
     "ID":30 VIEW-AS TEXT
          SIZE 2.5 BY .81 AT ROW 14.57 COL 76 WIDGET-ID 398
          BGCOLOR 34 FGCOLOR 0 FONT 1
     "Lice":30 VIEW-AS TEXT
          SIZE 4 BY .81 AT ROW 14.57 COL 94.5 WIDGET-ID 400
          BGCOLOR 34 FGCOLOR 0 FONT 1
     "Engine no :":35 VIEW-AS TEXT
          SIZE 9.17 BY .95 AT ROW 6.95 COL 5.5
          BGCOLOR 34 FGCOLOR 0 FONT 1
     "ชื่อ":30 VIEW-AS TEXT
          SIZE 2.5 BY .81 AT ROW 12.67 COL 18.5 WIDGET-ID 336
          BGCOLOR 34 FGCOLOR 0 FONT 1
     " Year :":30 VIEW-AS TEXT
          SIZE 5.5 BY .95 AT ROW 5.76 COL 116.5
          BGCOLOR 34 FGCOLOR 0 FONT 1
     "Dri 3:":30 VIEW-AS TEXT
          SIZE 4.5 BY .81 AT ROW 12.67 COL 2 WIDGET-ID 334
          BGCOLOR 34 FGCOLOR 0 FONT 1
     "Inspection Result :":30 VIEW-AS TEXT
          SIZE 14.83 BY .95 AT ROW 17.48 COL 50 WIDGET-ID 192
          BGCOLOR 34 FGCOLOR 2 FONT 1
     "สกุล":30 VIEW-AS TEXT
          SIZE 3.5 BY .81 AT ROW 13.62 COL 36 WIDGET-ID 366
          BGCOLOR 34 FGCOLOR 0 FONT 1
     "Car Model :":30 VIEW-AS TEXT
          SIZE 11 BY .95 AT ROW 4.62 COL 32.67 WIDGET-ID 58
          BGCOLOR 34 FGCOLOR 0 FONT 1
     "ชื่อ":30 VIEW-AS TEXT
          SIZE 2.5 BY .81 AT ROW 13.62 COL 18.5 WIDGET-ID 364
          BGCOLOR 34 FGCOLOR 0 FONT 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1.17 ROW 1.05
         SIZE 133 BY 24
         BGCOLOR 29 FGCOLOR 1 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     " Pol renew :":35 VIEW-AS TEXT
          SIZE 11.33 BY .76 AT ROW 1.29 COL 62.67
          BGCOLOR 33 FONT 6
     "Car Weight (CC.) :":30 VIEW-AS TEXT
          SIZE 14.5 BY .95 AT ROW 5.71 COL 87
          BGCOLOR 34 FGCOLOR 0 FONT 1
     "ชื่อ":30 VIEW-AS TEXT
          SIZE 2.5 BY .81 AT ROW 14.57 COL 18.5 WIDGET-ID 392
          BGCOLOR 34 FGCOLOR 0 FONT 1
     "Usage Type :":30 VIEW-AS TEXT
          SIZE 11.33 BY .95 AT ROW 5.76 COL 3.5 WIDGET-ID 14
          BGCOLOR 34 FGCOLOR 0 FONT 1
     "Provin Reg. :":30 VIEW-AS TEXT
          SIZE 10.67 BY .95 AT ROW 7 COL 111
          BGCOLOR 34 FGCOLOR 0 FONT 1
     " Accessories :":30 VIEW-AS TEXT
          SIZE 11.83 BY .95 AT ROW 20.52 COL 10.5 WIDGET-ID 200
          BGCOLOR 34 FGCOLOR 2 FONT 1
     "Inspection Damage :":30 VIEW-AS TEXT
          SIZE 17 BY .95 AT ROW 18.57 COL 5.5 WIDGET-ID 196
          BGCOLOR 34 FGCOLOR 2 FONT 1
     RECT-340 AT ROW 4.05 COL 1.5 WIDGET-ID 124
     RECT-341 AT ROW 15.76 COL 2 WIDGET-ID 142
     RECT-342 AT ROW 1.14 COL 1.5 WIDGET-ID 144
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1.17 ROW 1.05
         SIZE 133 BY 24
         BGCOLOR 29 FGCOLOR 1 .


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
         TITLE              = "Update Data TISCO"
         HEIGHT             = 24.14
         WIDTH              = 133.17
         MAX-HEIGHT         = 34.67
         MAX-WIDTH          = 170.67
         VIRTUAL-HEIGHT     = 34.67
         VIRTUAL-WIDTH      = 170.67
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
/* SETTINGS FOR FILL-IN fi_acc IN FRAME fr_main
   ALIGN-L                                                              */
/* SETTINGS FOR FILL-IN fi_acc2 IN FRAME fr_main
   ALIGN-L                                                              */
ASSIGN 
       fi_flag:READ-ONLY IN FRAME fr_main        = TRUE.

/* SETTINGS FOR FILL-IN fi_timeup IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_updat IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_userid IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_userupdate IN FRAME fr_main
   NO-ENABLE                                                            */
ASSIGN 
       ra_poltyp:HIDDEN IN FRAME fr_main           = TRUE.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Update Data TISCO */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Update Data TISCO */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_addisp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_addisp C-Win
ON CHOOSE OF bu_addisp IN FRAME fr_main /* CREATE ISP */
DO:
 MESSAGE "Do you want Create Inspection !!!!"        
        VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO     /*-CANCEL */    
        TITLE "" UPDATE choice1 AS LOGICAL.
    CASE choice1:         
        WHEN TRUE THEN /* Yes */ 
            DO: 
            Find  brstat.tlt Where  Recid(tlt)  =  nv_recidtlt.
            If  avail  brstat.tlt Then do:
                RUN proc_addinsp.
            END.                                                    
            Apply "Close" to this-procedure.
            Return no-apply.
           
        END.
        WHEN FALSE THEN /* No */          
            DO:   
            APPLY "entry" TO fi_insp.
            RETURN NO-APPLY.
        END.
     END CASE.
Disp fi_insp with  frame  fr_main.
DISP fi_inspection        fi_ispno        fi_ispdetail 
     fi_ispdamage         fi_ispdamage2   fi_ispacc    
     fi_ispacc2   WITH FRAME fr_main.
RELEASE brstat.tlt.

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
                   brstat.tlt.brand      = trim(input fi_brand    ) 
                   brstat.tlt.model      = trim(input fi_carmodel ) 
                   brstat.tlt.old_eng    = trim(input fi_mdyear   ) 
                   brstat.tlt.vehuse     = trim(input fi_Usage    ) 
                   brstat.tlt.colordes   = trim(input fi_color    ) 
                   brstat.tlt.cc_weight  = input fi_cc 
                   brstat.tlt.old_cha    = trim(input fi_year     ) 
                   brstat.tlt.eng_no     = trim(input fi_eng_no   ) 
                   brstat.tlt.cha_no     = trim(input fi_cha_no   ) 
                   brstat.tlt.filler1    = TRIM(trim(input fi_acc)  + " " + TRIM(INPUT fi_acc2))
                   brstat.tlt.filler2    = input fi_accamt    
                   brstat.tlt.lince1     = trim(input fi_licence  ) 
                   brstat.tlt.lince2     = trim(input fi_province ) 
                   brstat.tlt.note7      = trim(input fi_inspection )   
                   brstat.tlt.note8      = trim(input fi_ispno      )   
                   brstat.tlt.note9      = trim(input fi_ispdetail  ) 
                   brstat.tlt.note10     = trim(trim(fi_ispdamage) + " " + TRIM(fi_ispdamage2)) 
                   brstat.tlt.note11     = trim(trim(fi_ispacc) + " " + TRIM(fi_ispacc2))  
                   brstat.tlt.dri_title1 = trim(fi_dri1_tlt)    /*A68-0044*/
                   brstat.tlt.dri_fname1 = trim(fi_dri1_name)   /*A68-0044*/
                   brstat.tlt.dri_lname1 = trim(fi_dri1_name2)  /*A68-0044*/ 
                   brstat.tlt.dri_birth1 = trim(fi_dri1_birth)  /*A68-0044*/ 
                   brstat.tlt.dri_no1    = trim(fi_dri1_idno)   /*A68-0044*/
                   brstat.tlt.dri_lic1   = trim(fi_dri1_lice)   /*A68-0044*/
                   brstat.tlt.dir_occ1   = trim(fi_dri1_occ)    /*A68-0044*/
                   brstat.tlt.dri_title2 = trim(fi_dri2_tlt)    /*A68-0044*/
                   brstat.tlt.dri_fname2 = trim(fi_dri2_name)   /*A68-0044*/
                   brstat.tlt.dri_lname2 = trim(fi_dri2_name2)  /*A68-0044*/ 
                   brstat.tlt.dri_birth2 = trim(fi_dri2_birth)  /*A68-0044*/ 
                   brstat.tlt.dri_no2    = trim(fi_dri2_idno)   /*A68-0044*/
                   brstat.tlt.dri_lic2   = trim(fi_dri2_lice)   /*A68-0044*/
                   brstat.tlt.dri_occ2   = trim(fi_dri2_occ)    /*A68-0044*/
                   brstat.tlt.dri_title3 = trim(fi_dri3_tlt)    /*A68-0044*/
                   brstat.tlt.dri_fname3 = trim(fi_dri3_name)   /*A68-0044*/
                   brstat.tlt.dri_lname3 = trim(fi_dri3_name2)  /*A68-0044*/ 
                   brstat.tlt.dri_birth3 = trim(fi_dri3_birth)  /*A68-0044*/ 
                   brstat.tlt.dri_no3    = trim(fi_dri3_idno)   /*A68-0044*/
                   brstat.tlt.dri_lic3   = trim(fi_dri3_lice)   /*A68-0044*/
                   brstat.tlt.dir_occ3   = trim(fi_dri3_occ)    /*A68-0044*/
                   brstat.tlt.dri_title4 = trim(fi_dri4_tlt)    /*A68-0044*/
                   brstat.tlt.dri_fname4 = trim(fi_dri4_name)   /*A68-0044*/
                   brstat.tlt.dri_lname4 = trim(fi_dri4_name2)  /*A68-0044*/ 
                   brstat.tlt.dri_birth4 = trim(fi_dri4_birth)  /*A68-0044*/ 
                   brstat.tlt.dri_no4    = trim(fi_dri4_idno)   /*A68-0044*/
                   brstat.tlt.dri_lic4   = trim(fi_dri4_lice)   /*A68-0044*/
                   brstat.tlt.dri_occ4   = trim(fi_dri4_occ)    /*A68-0044*/
                   brstat.tlt.dri_title5 = trim(fi_dri5_tlt)    /*A68-0044*/
                   brstat.tlt.dri_fname5 = trim(fi_dri5_name)   /*A68-0044*/
                   brstat.tlt.dri_lname5 = trim(fi_dri5_name2)  /*A68-0044*/ 
                   brstat.tlt.dri_birth5 = trim(fi_dri5_birth)  /*A68-0044*/ 
                   brstat.tlt.dri_no5    = trim(fi_dri5_idno)   /*A68-0044*/
                   brstat.tlt.dri_lic5   = trim(fi_dri5_lice)   /*A68-0044*/
                   brstat.tlt.dri_occ5   = trim(fi_dri5_occ) .   /*A68-0044*/
            END.                                                    
            Apply "Close" to this-procedure.
            Return no-apply.
            /* APPLY "entry" TO fi_branch.
            RETURN NO-APPLY. */
        END.
        WHEN FALSE THEN /* No */          
            DO:   
            APPLY "entry" TO fi_brand.
            RETURN NO-APPLY.
        END.
        /*OTHERWISE /* Cancel */             
        STOP.*/
        END CASE.
Disp  fi_brand with  frame  fr_main.
RELEASE brstat.tlt.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_upins
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_upins C-Win
ON CHOOSE OF bu_upins IN FRAME fr_main /* UPDATE ISP */
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: Create by A60-0118      
------------------------------------------------------------------------------*/
DO:
ASSIGN  nv_docno    = ""     nv_survey   = ""    nv_detail   = ""     
        nv_damlist  = ""     nv_damage   = ""    nv_totaldam = ""    nv_attfile = ""     nv_device  = ""     nv_acc1     = ""
        nv_acc2     = ""     nv_acc3     = ""    nv_acc4     = ""    nv_acc5    = ""     nv_acc6    = ""     nv_acc7     = ""
        nv_acc8     = ""     nv_acc9     = ""    nv_acc10    = ""    nv_acc11   = ""     nv_acc12   = ""     nv_acctotal = ""
        nv_tmp      = "Inspect" + SUBSTR(fi_insp,3,2) + ".nsf" .
       

/*--------- Server Real ---------- */
nv_server = "Safety_NotesServer/Safety".
nv_tmp   = "safety\uw\" + nv_tmp .
/* -------------------------------*/
/*---------- Server test local -------
nv_server = "".
nv_tmp    = "D:\Lotus\Notes\Data\" + nv_tmp .
-----------------------------*/
CREATE "Notes.NotesSession"  chNotesSession.
chNotesDatabase  = chNotesSession:GetDatabase (nv_server,nv_tmp).
             
  IF  chNotesDatabase:IsOpen()  = NO  THEN  DO:
     MESSAGE "Can not open database" SKIP  
             "Please Check database and serve" VIEW-AS  ALERT-BOX ERROR.
  END.
  ELSE DO:
    chNotesView    = chNotesDatabase:GetView("chassis_no").
    chNavView      = chNotesView:CreateViewNav.
    chDocument     = chNotesView:GetDocumentByKey(trim(fi_cha_no)).
    
    IF VALID-HANDLE(chDocument) = YES THEN DO:

        chitem       = chDocument:Getfirstitem("docno"). 
        IF chitem <> 0 THEN nv_docno = chitem:TEXT. 
        ELSE nv_docno = "".

        chitem       = chDocument:Getfirstitem("SurveyClose").
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
               ASSIGN n_list     = INT(nv_damlist)
                      nv_damlist = "จำนวนความเสียหาย " + nv_damlist + " รายการ " .
           END.
           /*IF nv_totaldam <> "" THEN ASSIGN nv_totaldam = "รวมความเสียหายทั้งสิ้น " + nv_totaldam + " บาท " .*/
         
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
                         ASSIGN nv_damdetail = nv_damdetail + string(n_count) + "." + nv_damag + /*" " + nv_repair +*/ " , " .
                     n_count = n_count + 1.
                 END.
                 ELSE LEAVE loop_damage.
             END.
           END.
        END. /* end ความเสียหาย */
        /*-- อุปกรณ์เสริม --*/  
          chitem       = chDocument:Getfirstitem("device1").
          IF chitem <> 0 THEN  nv_device = chitem:TEXT. 
          ELSE nv_device = "".

          IF nv_device <> "" THEN DO:
              chitem       = chDocument:Getfirstitem("pricesTotal").  /* ราคารวมอุปกรณ์เสริม */
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
              
              ASSIGN nv_device = "อุปกรณ์เสริม : " .
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
              nv_acctotal = " ราคารวมอุปกรณ์เสริม " + nv_acctotal + " บาท " .
          END.
    
        IF nv_docno <> ""  THEN DO:
            IF nv_survey <> "" THEN DO:
                IF nv_detail = "ติดปัญหา" THEN DO:
                   ASSIGN fi_inspection = "Y"          /*brstat.tlt.note7   */
                          fi_ispno      = nv_docno     /*brstat.tlt.note8   */
                          fi_ispdetail  = nv_detail    /*brstat.tlt.note9   */
                          fi_ispdamage  = nv_damage     /*brstat.tlt.note10  */
                          fi_ispdamage2 = ""
                          fi_ispacc     = IF length(nv_device) >= 200 THEN SUBSTR(nv_device,1,200) ELSE nv_device   /*brstat.tlt.note11  */
                          fi_ispacc2    = IF length(nv_device) > 200 THEN SUBSTR(nv_device,201,200) ELSE "" .
                END.
                ELSE IF nv_detail = "มีความเสียหาย"  THEN DO:
                  ASSIGN fi_inspection = "Y"
                         fi_ispno      = nv_docno
                         fi_ispdetail  = nv_detail 
                         fi_ispdamage  = nv_damlist  
                         fi_ispdamage2 = nv_damdetail 
                         fi_ispacc     = IF length(nv_device) >= 200 THEN SUBSTR(nv_device,1,200) ELSE nv_device   /*brstat.tlt.note11  */
                         fi_ispacc2    = IF length(nv_device) > 200 THEN SUBSTR(nv_device,201,200) ELSE "" .
                END.
                ELSE DO:
                  ASSIGN fi_inspection = "Y"
                         fi_ispno      = nv_docno
                         fi_ispdetail  = nv_detail 
                         fi_ispdamage  = ""
                         fi_ispdamage2 = ""
                         fi_ispacc     = IF length(nv_device) >= 200 THEN SUBSTR(nv_device,1,200) ELSE nv_device   /*brstat.tlt.note11  */
                         fi_ispacc2    = IF length(nv_device) > 200 THEN SUBSTR(nv_device,201,200) ELSE "" .
                END.
            END.
            ELSE DO:
              ASSIGN fi_inspection = "Y"
                     fi_ispno      = nv_docno
                     fi_ispdetail  = ""
                     fi_ispdamage  = ""
                     fi_ispdamage2 = "" 
                     fi_ispacc     = IF length(nv_device) >= 200 THEN SUBSTR(nv_device,1,200) ELSE nv_device   /*brstat.tlt.note11  */
                     fi_ispacc2    = IF length(nv_device) > 200 THEN SUBSTR(nv_device,201,200) ELSE "" .
            END.
        END.
        ELSE DO:
            ASSIGN   fi_inspection   = "Y"
                     fi_ispno      = ""
                     fi_ispdetail  = ""
                     fi_ispdamage  = ""
                     fi_ispdamage2 = "" 
                     fi_ispacc     = IF length(nv_device) >= 200 THEN SUBSTR(nv_device,1,200) ELSE nv_device   /*brstat.tlt.note11  */
                     fi_ispacc2    = IF length(nv_device) > 200 THEN SUBSTR(nv_device,201,200) ELSE "" .
        END.
        RELEASE  OBJECT chitem          NO-ERROR.
        RELEASE  OBJECT chDocument      NO-ERROR.          
        RELEASE  OBJECT chNotesDataBase NO-ERROR.     
        RELEASE  OBJECT chNotesSession  NO-ERROR.
    END.
  END.
  DISP fi_inspection        fi_ispno        fi_ispdetail 
       fi_ispdamage         fi_ispdamage2   fi_ispacc    
       fi_ispacc2   WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_acc
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_acc C-Win
ON LEAVE OF fi_acc IN FRAME fr_main
DO:
    fi_acc = trim(INPUT fi_acc).
    DISP fi_acc with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_acc2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_acc2 C-Win
ON LEAVE OF fi_acc2 IN FRAME fr_main
DO:
    fi_acc2 = trim(INPUT fi_acc2).
    DISP fi_acc2 with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_accamt
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_accamt C-Win
ON LEAVE OF fi_accamt IN FRAME fr_main
DO:
    fi_accamt = INPUT fi_accamt.
    DISP fi_accamt WITH FRAM fr_main.
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


&Scoped-define SELF-NAME fi_carmodel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_carmodel C-Win
ON LEAVE OF fi_carmodel IN FRAME fr_main
DO:
  fi_carmodel = INPUT fi_carmodel .
  DISP fi_carmodel WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_cc
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_cc C-Win
ON LEAVE OF fi_cc IN FRAME fr_main
DO:
  fi_cc  =  Input  fi_cc.
  Disp  fi_cc with frame  fr_main.
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


&Scoped-define SELF-NAME fi_color
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_color C-Win
ON LEAVE OF fi_color IN FRAME fr_main
DO:
  fi_color = INPUT fi_color .
  DISP fi_color WITH FRAM fr_main.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_compulsory
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_compulsory C-Win
ON LEAVE OF fi_compulsory IN FRAME fr_main
DO:
    fi_compulsory = INPUT fi_compulsory.
    DISP fi_compulsory WITH FRAM fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_dri1_birth
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_dri1_birth C-Win
ON LEAVE OF fi_dri1_birth IN FRAME fr_main
DO:
  fi_dri1_birth = INPUT fi_dri1_birth .
  DISP fi_dri1_birth WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_dri1_idno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_dri1_idno C-Win
ON LEAVE OF fi_dri1_idno IN FRAME fr_main
DO:
  fi_dri1_idno = INPUT fi_dri1_idno .
  DISP fi_dri1_idno WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_dri1_lice
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_dri1_lice C-Win
ON LEAVE OF fi_dri1_lice IN FRAME fr_main
DO:
  fi_dri1_lice = INPUT fi_dri1_lice .
  DISP fi_dri1_lice WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_dri1_name
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_dri1_name C-Win
ON LEAVE OF fi_dri1_name IN FRAME fr_main
DO:
  fi_dri1_name = INPUT fi_dri1_name .
  DISP fi_dri1_name WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_dri1_name2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_dri1_name2 C-Win
ON LEAVE OF fi_dri1_name2 IN FRAME fr_main
DO:
  fi_dri1_name2 = INPUT fi_dri1_name2 .
  DISP fi_dri1_name2 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_dri1_occ
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_dri1_occ C-Win
ON LEAVE OF fi_dri1_occ IN FRAME fr_main
DO:
  fi_dri1_occ = INPUT fi_dri1_occ .
  DISP fi_dri1_occ WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_dri1_tlt
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_dri1_tlt C-Win
ON LEAVE OF fi_dri1_tlt IN FRAME fr_main
DO:
  fi_dri1_tlt = INPUT fi_dri1_tlt .
  DISP fi_dri1_tlt WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_dri2_birth
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_dri2_birth C-Win
ON LEAVE OF fi_dri2_birth IN FRAME fr_main
DO:
  fi_dri2_birth = INPUT fi_dri2_birth .
  DISP fi_dri2_birth WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_dri2_idno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_dri2_idno C-Win
ON LEAVE OF fi_dri2_idno IN FRAME fr_main
DO:
  fi_dri2_idno = INPUT fi_dri2_idno .
  DISP fi_dri2_idno WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_dri2_lice
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_dri2_lice C-Win
ON LEAVE OF fi_dri2_lice IN FRAME fr_main
DO:
  fi_dri2_lice = INPUT fi_dri2_lice .
  DISP fi_dri2_lice WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_dri2_name
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_dri2_name C-Win
ON LEAVE OF fi_dri2_name IN FRAME fr_main
DO:
  fi_dri2_name = INPUT fi_dri2_name .
  DISP fi_dri2_name WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_dri2_name2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_dri2_name2 C-Win
ON LEAVE OF fi_dri2_name2 IN FRAME fr_main
DO:
  fi_dri2_name2 = INPUT fi_dri2_name2 .
  DISP fi_dri2_name2 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_dri2_occ
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_dri2_occ C-Win
ON LEAVE OF fi_dri2_occ IN FRAME fr_main
DO:
  fi_dri2_occ = INPUT fi_dri2_occ .
  DISP fi_dri2_occ WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_dri2_tlt
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_dri2_tlt C-Win
ON LEAVE OF fi_dri2_tlt IN FRAME fr_main
DO:
  fi_dri2_tlt = INPUT fi_dri2_tlt .
  DISP fi_dri2_tlt WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_dri3_birth
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_dri3_birth C-Win
ON LEAVE OF fi_dri3_birth IN FRAME fr_main
DO:
  fi_dri3_birth = INPUT fi_dri3_birth .
  DISP fi_dri3_birth WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_dri3_idno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_dri3_idno C-Win
ON LEAVE OF fi_dri3_idno IN FRAME fr_main
DO:
  fi_dri3_idno = INPUT fi_dri3_idno .
  DISP fi_dri3_idno WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_dri3_lice
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_dri3_lice C-Win
ON LEAVE OF fi_dri3_lice IN FRAME fr_main
DO:
  fi_dri3_lice = INPUT fi_dri3_lice .
  DISP fi_dri3_lice WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_dri3_name
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_dri3_name C-Win
ON LEAVE OF fi_dri3_name IN FRAME fr_main
DO:
  fi_dri3_name = INPUT fi_dri3_name .
  DISP fi_dri3_name WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_dri3_name2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_dri3_name2 C-Win
ON LEAVE OF fi_dri3_name2 IN FRAME fr_main
DO:
  fi_dri3_name2 = INPUT fi_dri3_name2 .
  DISP fi_dri3_name2 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_dri3_occ
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_dri3_occ C-Win
ON LEAVE OF fi_dri3_occ IN FRAME fr_main
DO:
  fi_dri3_occ = INPUT fi_dri3_occ .
  DISP fi_dri3_occ WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_dri3_tlt
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_dri3_tlt C-Win
ON LEAVE OF fi_dri3_tlt IN FRAME fr_main
DO:
  fi_dri3_tlt = INPUT fi_dri3_tlt .
  DISP fi_dri3_tlt WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_dri4_birth
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_dri4_birth C-Win
ON LEAVE OF fi_dri4_birth IN FRAME fr_main
DO:
  fi_dri4_birth = INPUT fi_dri4_birth .
  DISP fi_dri4_birth WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_dri4_idno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_dri4_idno C-Win
ON LEAVE OF fi_dri4_idno IN FRAME fr_main
DO:
  fi_dri4_idno = INPUT fi_dri4_idno .
  DISP fi_dri4_idno WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_dri4_lice
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_dri4_lice C-Win
ON LEAVE OF fi_dri4_lice IN FRAME fr_main
DO:
  fi_dri4_lice = INPUT fi_dri4_lice .
  DISP fi_dri4_lice WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_dri4_name
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_dri4_name C-Win
ON LEAVE OF fi_dri4_name IN FRAME fr_main
DO:
  fi_dri4_name = INPUT fi_dri4_name .
  DISP fi_dri4_name WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_dri4_name2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_dri4_name2 C-Win
ON LEAVE OF fi_dri4_name2 IN FRAME fr_main
DO:
  fi_dri4_name2 = INPUT fi_dri4_name2 .
  DISP fi_dri4_name2 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_dri4_occ
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_dri4_occ C-Win
ON LEAVE OF fi_dri4_occ IN FRAME fr_main
DO:
  fi_dri4_occ = INPUT fi_dri4_occ .
  DISP fi_dri4_occ WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_dri4_tlt
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_dri4_tlt C-Win
ON LEAVE OF fi_dri4_tlt IN FRAME fr_main
DO:
  fi_dri4_tlt = INPUT fi_dri4_tlt .
  DISP fi_dri4_tlt WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_dri5_birth
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_dri5_birth C-Win
ON LEAVE OF fi_dri5_birth IN FRAME fr_main
DO:
  fi_dri5_birth = INPUT fi_dri5_birth .
  DISP fi_dri5_birth WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_dri5_idno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_dri5_idno C-Win
ON LEAVE OF fi_dri5_idno IN FRAME fr_main
DO:
  fi_dri5_idno = INPUT fi_dri5_idno .
  DISP fi_dri5_idno WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_dri5_lice
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_dri5_lice C-Win
ON LEAVE OF fi_dri5_lice IN FRAME fr_main
DO:
  fi_dri5_lice = INPUT fi_dri5_lice .
  DISP fi_dri5_lice WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_dri5_name
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_dri5_name C-Win
ON LEAVE OF fi_dri5_name IN FRAME fr_main
DO:
  fi_dri5_name = INPUT fi_dri5_name .
  DISP fi_dri5_name WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_dri5_name2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_dri5_name2 C-Win
ON LEAVE OF fi_dri5_name2 IN FRAME fr_main
DO:
  fi_dri5_name2 = INPUT fi_dri5_name2 .
  DISP fi_dri5_name2 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_dri5_occ
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_dri5_occ C-Win
ON LEAVE OF fi_dri5_occ IN FRAME fr_main
DO:
  fi_dri5_occ = INPUT fi_dri5_occ .
  DISP fi_dri5_occ WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_dri5_tlt
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_dri5_tlt C-Win
ON LEAVE OF fi_dri5_tlt IN FRAME fr_main
DO:
  fi_dri5_tlt = INPUT fi_dri5_tlt .
  DISP fi_dri5_tlt WITH FRAM fr_main.
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


&Scoped-define SELF-NAME fi_flag
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_flag C-Win
ON LEAVE OF fi_flag IN FRAME fr_main
DO:
  fi_flag = INPUT fi_flag .
  DISP fi_flag WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_insp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_insp C-Win
ON LEAVE OF fi_insp IN FRAME fr_main
DO:
    fi_insp = INPUT fi_insp .
  DISP fi_insp WITH FRAM fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_inspection
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_inspection C-Win
ON LEAVE OF fi_inspection IN FRAME fr_main
DO:
    fi_inspection = INPUT fi_inspection .
  DISP fi_inspection WITH FRAM fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_ispacc
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_ispacc C-Win
ON LEAVE OF fi_ispacc IN FRAME fr_main
DO:
   fi_ispacc = INPUT fi_ispacc .
  DISP fi_ispacc WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_ispacc2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_ispacc2 C-Win
ON LEAVE OF fi_ispacc2 IN FRAME fr_main
DO:
   fi_ispacc2 = INPUT fi_ispacc2.
  DISP fi_ispacc2 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_ispdamage
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_ispdamage C-Win
ON LEAVE OF fi_ispdamage IN FRAME fr_main
DO:
   fi_ispdamage = INPUT fi_ispdamage .
  DISP fi_ispdamage WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_ispdamage2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_ispdamage2 C-Win
ON LEAVE OF fi_ispdamage2 IN FRAME fr_main
DO:
   fi_ispdamage2 = INPUT fi_ispdamage2 .
  DISP fi_ispdamage2 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_ispdetail
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_ispdetail C-Win
ON LEAVE OF fi_ispdetail IN FRAME fr_main
DO:
   fi_ispdetail = INPUT fi_ispdetail .
  DISP fi_ispdetail WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_ispno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_ispno C-Win
ON LEAVE OF fi_ispno IN FRAME fr_main
DO:
    fi_ispno = INPUT fi_ispno .
  DISP fi_ispno WITH FRAM fr_main.
  
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


&Scoped-define SELF-NAME fi_mdyear
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_mdyear C-Win
ON LEAVE OF fi_mdyear IN FRAME fr_main
DO:
  fi_mdyear = INPUT fi_mdyear .
  DISP fi_mdyear WITH FRAM fr_main.
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


&Scoped-define SELF-NAME fi_province
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_province C-Win
ON LEAVE OF fi_province IN FRAME fr_main
DO:
  fi_province =  Input  fi_province.
  Disp  fi_province with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_prvpol
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_prvpol C-Win
ON LEAVE OF fi_prvpol IN FRAME fr_main
DO:
  fi_prvpol  =  Input  fi_prvpol.
  Disp  fi_prvpol with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_Usage
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_Usage C-Win
ON LEAVE OF fi_Usage IN FRAME fr_main
DO:
  fi_Usage = INPUT fi_Usage .
  DISP fi_Usage WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_year
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_year C-Win
ON LEAVE OF fi_year IN FRAME fr_main
DO:
  fi_year    =  Input  fi_year.
  Disp  fi_year with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ra_poltyp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_poltyp C-Win
ON VALUE-CHANGED OF ra_poltyp IN FRAME fr_main
DO:
  /*Apply "Entry" to  fi_title.
  Return no-apply.*/
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
  
  gv_prgid = "wgwqtis2".
  gv_prog  = "Query &Update Data  (Tisco  co.,ltd.) ".
  RUN  WUT\WUTHEAD ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).

/*********************************************************************/ 
 /*  RUN Wut\WutwiCen ({&WINDOW-NAME}:HANDLE). */ 
  /*CURRENT-WINDOW:WINDOW-STATE = WINDOW-MAXIMIZED.*/
  SESSION:DATA-ENTRY-RETURN = YES.

  ASSIGN 
      nv_title      = "" 
      nv_firstname  = "" 
      nv_lastname   = "" 
      nv_sumfi      = "" 
      nv_comdat     = "" 
      nv_expdat     = "" 
      nv_gprem      = "" 
      nv_producer   = "" .
  Find  brstat.tlt  Where   Recid(tlt)  =  nv_recidtlt NO-LOCK NO-ERROR NO-WAIT .
  If  avail  tlt  Then do:
      Assign
          nv_title          =   brstat.tlt.ins_title       
          nv_firstname      =   brstat.tlt.ins_firstname   
          nv_lastname       =   brstat.tlt.ins_lastname 
          nv_sumfi          =   string(brstat.tlt.nor_coamt,">,>>>,>>9.99")       
          nv_comdat         =   string(brstat.tlt.gendat,"99/99/9999")          
          nv_expdat         =   string(brstat.tlt.expodat,"99/99/9999") 
          nv_gprem          =   string(brstat.tlt.ndeci1,">,>>>,>>9.99")   
          nv_producer       =   brstat.tlt.acno1

          fi_brand          =   brstat.tlt.brand           
          fi_carmodel       =   brstat.tlt.model  
          fi_mdyear         =   brstat.tlt.old_eng         
          fi_Usage          =   brstat.tlt.vehuse          
          fi_color          =   brstat.tlt.colordes         
          fi_cc             =   brstat.tlt.cc_weight       
          fi_year           =   brstat.tlt.old_cha         
          fi_eng_no         =   brstat.tlt.eng_no          
          fi_cha_no         =   brstat.tlt.cha_no          
          fi_acc            =   IF LENGTH(brstat.tlt.filler1) >= 150 THEN SUBSTR(brstat.tlt.filler1,1,150) ELSE brstat.tlt.filler1 
          fi_acc2           =   IF LENGTH(brstat.tlt.filler1) > 150 THEN SUBSTR(brstat.tlt.filler1,151,150) ELSE ""
          fi_accamt         =   deci(brstat.tlt.filler2)         
          fi_licence        =   brstat.tlt.lince1          
          fi_province       =   brstat.tlt.lince2  
          fi_insp           =   STRING(YEAR(TODAY),"9999")
          fi_inspection     =   brstat.tlt.note7           
          fi_ispno          =   brstat.tlt.note8           
          fi_ispdetail      =   brstat.tlt.note9
          fi_ispdamage      =   IF LENGTH(brstat.tlt.note10) >= 150 THEN SUBSTR(brstat.tlt.note10,1,150) ELSE brstat.tlt.note10
          fi_ispdamage2     =   IF LENGTH(brstat.tlt.note10) > 150  THEN SUBSTR(brstat.tlt.note10,151,150) ELSE ""
          fi_ispacc         =   IF LENGTH(brstat.tlt.note11) >= 150 THEN SUBSTR(brstat.tlt.note11,1,150) ELSE brstat.tlt.note11
          fi_ispacc2        =   IF LENGTH(brstat.tlt.note11) > 150  THEN SUBSTR(brstat.tlt.note11,151,150) ELSE ""
          cb_problem        =  IF brstat.tlt.hclfg = "N" THEN "2" ELSE "1"   
          fi_updat          =  brstat.tlt.ndate1 
          ra_poltyp         =  IF trim(brstat.tlt.flag) = "NW" THEN 1 ELSE IF trim(brstat.tlt.flag) = "RW" THEN 2 
                               ELSE IF trim(brstat.tlt.flag) = "TF" THEN  3 ELSE IF trim(brstat.tlt.flag) = "UC" THEN  4 ELSE 5
          fi_userid         =  brstat.tlt.usrid   
          fi_userupdate     =  brstat.tlt.usrsent
          fi_timeup         =  brstat.tlt.trntime
          fi_flag           =  brstat.tlt.releas 
          fi_polsystem      =  brstat.tlt.policy 
          fi_prvpol         =  brstat.tlt.nor_noti_ins
          fi_compulsory     =  brstat.tlt.comp_pol  
          fi_dri1_tlt       =  brstat.tlt.dri_title1   /*A68-0044*/ 
          fi_dri1_name      =  brstat.tlt.dri_fname1   /*A68-0044*/ 
          fi_dri1_name2     =  brstat.tlt.dri_lname1   /*A68-0044*/ 
          fi_dri1_birth     =  brstat.tlt.dri_birth1   /*A68-0044*/ 
          fi_dri1_idno      =  brstat.tlt.dri_no1      /*A68-0044*/ 
          fi_dri1_lice      =  brstat.tlt.dri_lic1     /*A68-0044*/ 
          fi_dri1_occ       =  brstat.tlt.dir_occ1     /*A68-0044*/ 
          fi_dri2_tlt       =  brstat.tlt.dri_title2   /*A68-0044*/ 
          fi_dri2_name      =  brstat.tlt.dri_fname2   /*A68-0044*/ 
          fi_dri2_name2     =  brstat.tlt.dri_lname2   /*A68-0044*/ 
          fi_dri2_birth     =  brstat.tlt.dri_birth2   /*A68-0044*/ 
          fi_dri2_idno      =  brstat.tlt.dri_no2      /*A68-0044*/ 
          fi_dri2_lice      =  brstat.tlt.dri_lic2     /*A68-0044*/ 
          fi_dri2_occ       =  brstat.tlt.dri_occ2     /*A68-0044*/ 
          fi_dri3_tlt       =  brstat.tlt.dri_title3   /*A68-0044*/ 
          fi_dri3_name      =  brstat.tlt.dri_fname3   /*A68-0044*/ 
          fi_dri3_name2     =  brstat.tlt.dri_lname3   /*A68-0044*/ 
          fi_dri3_birth     =  brstat.tlt.dri_birth3   /*A68-0044*/ 
          fi_dri3_idno      =  brstat.tlt.dri_no3      /*A68-0044*/ 
          fi_dri3_lice      =  brstat.tlt.dri_lic3     /*A68-0044*/ 
          fi_dri3_occ       =  brstat.tlt.dir_occ3     /*A68-0044*/ 
          fi_dri4_tlt       =  brstat.tlt.dri_title4   /*A68-0044*/ 
          fi_dri4_name      =  brstat.tlt.dri_fname4   /*A68-0044*/ 
          fi_dri4_name2     =  brstat.tlt.dri_lname4   /*A68-0044*/ 
          fi_dri4_birth     =  brstat.tlt.dri_birth4  /*A68-0044*/ 
          fi_dri4_idno      =  brstat.tlt.dri_no4      /*A68-0044*/ 
          fi_dri4_lice      =  brstat.tlt.dri_lic4     /*A68-0044*/ 
          fi_dri4_occ       =  brstat.tlt.dri_occ4     /*A68-0044*/ 
          fi_dri5_tlt       =  brstat.tlt.dri_title5   /*A68-0044*/ 
          fi_dri5_name      =  brstat.tlt.dri_fname5   /*A68-0044*/ 
          fi_dri5_name2     =  brstat.tlt.dri_lname5   /*A68-0044*/ 
          fi_dri5_birth     =  brstat.tlt.dri_birth5   /*A68-0044*/ 
          fi_dri5_idno      =  brstat.tlt.dri_no5      /*A68-0044*/ 
          fi_dri5_lice      =  brstat.tlt.dri_lic5     /*A68-0044*/ 
          fi_dri5_occ       =  brstat.tlt.dri_occ5 .   /*A68-0044*/  
                               

      DISP   
          fi_brand        fi_carmodel    fi_mdyear      fi_Usage       
          fi_color        fi_cc          fi_year        fi_eng_no      
          fi_cha_no       fi_acc         fi_acc2        fi_accamt      
          fi_licence      
          fi_province     fi_insp        fi_inspection  fi_ispno       
          fi_ispdetail    fi_ispdamage   fi_ispdamage2  fi_ispacc      
          fi_ispacc2      fi_updat       ra_poltyp                    
          fi_userid       fi_userupdate  fi_timeup      fi_flag        
          fi_polsystem    fi_prvpol       fi_compulsory  cb_problem 
          /*A68-0044*/  
fi_dri1_tlt fi_dri1_name  fi_dri1_name2  fi_dri1_birth fi_dri1_idno fi_dri1_lice fi_dri1_occ     
fi_dri2_tlt fi_dri2_name  fi_dri2_name2  fi_dri2_birth fi_dri2_idno fi_dri2_lice fi_dri2_occ   
fi_dri3_tlt fi_dri3_name  fi_dri3_name2  fi_dri3_birth fi_dri3_idno fi_dri3_lice fi_dri3_occ     
fi_dri4_tlt fi_dri4_name  fi_dri4_name2  fi_dri4_birth fi_dri4_idno fi_dri4_lice fi_dri4_occ     
fi_dri5_tlt fi_dri5_name  fi_dri5_name2  fi_dri5_birth fi_dri5_idno fi_dri5_lice fi_dri5_occ   
          /*A68-0044*/  
      With frame  fr_main.               

          
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
  DISPLAY fi_ispno fi_Usage fi_prvpol fi_polsystem fi_mdyear fi_eng_no fi_cc 
          fi_year fi_color fi_cha_no fi_brand fi_licence fi_province fi_acc 
          fi_compulsory ra_poltyp fi_userid fi_carmodel fi_accamt fi_userupdate 
          fi_updat fi_inspection fi_ispdetail fi_flag fi_timeup fi_ispdamage 
          fi_ispacc fi_acc2 fi_insp fi_ispdamage2 fi_ispacc2 cb_problem 
          fi_dri1_tlt fi_dri1_name fi_dri1_name2 fi_dri1_birth fi_dri1_idno 
          fi_dri1_lice fi_dri1_occ fi_dri2_tlt fi_dri2_name fi_dri2_name2 
          fi_dri2_birth fi_dri2_idno fi_dri2_lice fi_dri2_occ fi_dri3_tlt 
          fi_dri3_name fi_dri3_name2 fi_dri3_birth fi_dri3_idno fi_dri3_lice 
          fi_dri3_occ fi_dri4_tlt fi_dri4_name fi_dri4_name2 fi_dri4_birth 
          fi_dri4_idno fi_dri4_lice fi_dri4_occ fi_dri5_tlt fi_dri5_name 
          fi_dri5_name2 fi_dri5_birth fi_dri5_idno fi_dri5_lice fi_dri5_occ 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE fi_ispno fi_Usage fi_prvpol fi_polsystem fi_mdyear fi_eng_no fi_cc 
         fi_year fi_color fi_cha_no fi_brand fi_licence fi_province fi_acc 
         fi_compulsory bu_save ra_poltyp bu_exit fi_carmodel fi_accamt 
         fi_inspection fi_ispdetail fi_flag fi_ispdamage fi_ispacc fi_acc2 
         fi_insp fi_ispdamage2 fi_ispacc2 cb_problem bu_upins bu_addisp 
         fi_dri1_tlt fi_dri1_name fi_dri1_name2 fi_dri1_birth fi_dri1_idno 
         fi_dri1_lice fi_dri1_occ fi_dri2_tlt fi_dri2_name fi_dri2_name2 
         fi_dri2_birth fi_dri2_idno fi_dri2_lice fi_dri2_occ fi_dri3_tlt 
         fi_dri3_name fi_dri3_name2 fi_dri3_birth fi_dri3_idno fi_dri3_lice 
         fi_dri3_occ fi_dri4_tlt fi_dri4_name fi_dri4_name2 fi_dri4_birth 
         fi_dri4_idno fi_dri4_lice fi_dri4_occ fi_dri5_tlt fi_dri5_name 
         fi_dri5_name2 fi_dri5_birth fi_dri5_idno fi_dri5_lice fi_dri5_occ 
         RECT-340 RECT-341 RECT-342 
      WITH FRAME fr_main IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_addinsp C-Win 
PROCEDURE proc_addinsp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: Create by A60-0118      
------------------------------------------------------------------------------*/
DO:
    ASSIGN  nv_nameT    = ""   nv_agentname = ""  nv_brand    = ""   nv_model     = ""   nv_licentyp = ""   nv_licen     = ""  
            nv_pattern1 = ""   nv_pattern4  = ""  nv_today    = ""   nv_time      = ""   nv_docno    = ""   nv_survey    = ""  
            nv_detail   = ""   
            nv_tmp      = "Inspect" + SUBSTR(fi_insp,3,2) + ".nsf" 
            nv_today    = STRING(DAY(TODAY),"99") + "/" + STRING(MONTH(TODAY),"99") + "/" + STRING(YEAR(TODAY),"9999")
            nv_time     = STRING(TIME,"HH:MM:SS")
            nv_nolicen  = TRIM(brstat.tlt.lince1)
            nv_province = TRIM(brstat.tlt.lince2).
    
    IF INDEX(nv_title,"คุณ")               <> 0 THEN ASSIGN nv_title = REPLACE(nv_title,"คุณ","")    nv_nameT = "บุคคล".
    ELSE IF INDEX(nv_title,"นาย")          <> 0 THEN ASSIGN nv_title = REPLACE(nv_title,"นาย","")    nv_nameT = "บุคคล".
    ELSE IF INDEX(nv_title,"นางสาว")       <> 0 THEN ASSIGN nv_title = REPLACE(nv_title,"นางสาว","") nv_nameT = "บุคคล".
    ELSE IF INDEX(nv_title,"นาง")          <> 0 THEN ASSIGN nv_title = REPLACE(nv_title,"นาง","")    nv_nameT = "บุคคล".
    ELSE IF INDEX(nv_title,"น.ส.")         <> 0 THEN ASSIGN nv_title = REPLACE(nv_title,"น.ส.","")   nv_nameT = "บุคคล".
    ELSE IF INDEX(nv_title,"ห้างหุ้นส่วน") <> 0 THEN ASSIGN nv_nameT = "ห้างหุ้นส่วนจำกัด / ห้างหุ้นส่วน".
    ELSE IF INDEX(nv_title,"หจก")          <> 0 THEN ASSIGN nv_nameT = "ห้างหุ้นส่วนจำกัด / ห้างหุ้นส่วน".
    ELSE IF INDEX(nv_title,"บริษัท")       <> 0 THEN ASSIGN nv_nameT = "บริษัท".
    ELSE IF INDEX(nv_title,"บจก")          <> 0 THEN ASSIGN nv_nameT = "บริษัท".
    ELSE IF INDEX(nv_title,"มูลนิธิ")      <> 0 THEN ASSIGN nv_nameT = "มูลนิธิ".
    ELSE IF INDEX(nv_title,"โรงแรม")       <> 0 THEN ASSIGN nv_nameT = "โรงแรม".
    ELSE IF INDEX(nv_title,"โรงเรียน")     <> 0 THEN ASSIGN nv_nameT = "โรงเรียน".
    ELSE IF INDEX(nv_title,"ร.ร.")         <> 0 THEN ASSIGN nv_nameT = "โรงเรียน".
    ELSE IF INDEX(nv_title,"โรงพยาบาล")    <> 0 THEN ASSIGN nv_nameT = "โรงพยาบาล".
    ELSE IF INDEX(nv_title,"นิติบุคคลอาคารชุด") <> 0 THEN ASSIGN nv_nameT = "นิติบุคคลอาคารชุด".
    ELSE ASSIGN nv_nameT = "อื่นๆ".
    
    ASSIGN nv_brand = trim(brstat.tlt.brand) nv_model = TRIM(brstat.tlt.model).
    
    IF trim(nv_nolicen) <> "" AND trim(nv_province) <> "" THEN DO:
        ASSIGN nv_licentyp = "รถเก๋ง/กระบะ/บรรทุก".
        RUN proc_province.
    END.
    ELSE DO: 
        ASSIGN nv_licentyp = "รถที่ยังไม่มีทะเบียน"
               nv_pattern4 = "/ZZZZZZZZZ" 
               nv_nolicen = "/" + SUBSTR(brstat.tlt.cha_no,LENGTH(brstat.tlt.cha_no) - 8,LENGTH(brstat.tlt.cha_no)) 
               nv_province = "".
    END.
    IF trim(nv_producer) <> "" THEN DO:
     FIND sicsyac.xmm600 USE-INDEX xmm60001   WHERE
          xmm600.acno  =  trim(nv_producer) NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL sicsyac.xmm600 THEN DO:
            FIND sicsyac.xtm600 USE-INDEX xtm60001  WHERE xtm600.acno  =  trim(nv_producer) NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL xtm600 THEN 
                ASSIGN nv_agentname = TRIM(sicsyac.xtm600.ntitle) + "  "  + TRIM(sicsyac.xtm600.name) .
            ELSE ASSIGN nv_agentname = "".
        END.
        ELSE ASSIGN nv_agentname =  TRIM(sicsyac.xmm600.ntitle) + "  "  + TRIM(sicsyac.xmm600.name) .
    END.
    IF trim(nv_nolicen) <> "" THEN DO:
       ASSIGN nv_licen = REPLACE(nv_nolicen," ","").
       IF INDEX("0123456789",SUBSTR(nv_nolicen,1,1)) <> 0 THEN DO:
           IF LENGTH(nv_licen) = 4 THEN 
               ASSIGN nv_Pattern1 = "yxx-y-xx"     nv_licen = SUBSTR(nv_licen,1,3) + " " + SUBSTR(nv_licen,4,1).   /*A63-0448*/
           ELSE IF LENGTH(nv_licen) = 5 THEN
               ASSIGN nv_Pattern1 = "yxx-yy-xx"    nv_licen = SUBSTR(nv_licen,1,3) + " " + SUBSTR(nv_licen,4,2).     /*A63-0448*/
           ELSE IF LENGTH(nv_licen) = 6 THEN DO:
               IF INDEX("0123456789",SUBSTR(nv_licen,2,1)) <> 0 THEN
                   ASSIGN nv_Pattern1 = "yy-yyyy-xx"  nv_licen  = SUBSTR(nv_licen,1,2) + " " + SUBSTR(nv_licen,3,4).
               ELSE IF INDEX("0123456789",SUBSTR(nv_licen,3,1)) <> 0 THEN
                   ASSIGN nv_Pattern1 = "yx-yyyy-xx"  nv_licen  = SUBSTR(nv_licen,1,2) + " " + SUBSTR(nv_licen,3,4).
               ELSE  ASSIGN nv_Pattern1 = "yxx-yyy-xx"   nv_licen = SUBSTR(nv_licen,1,3) + " " + SUBSTR(nv_licen,4,3).  /*A63-0448*/
           END.
           ELSE ASSIGN nv_Pattern1 = "yxx-yyyy-xx"   nv_licen = SUBSTR(nv_licen,1,3) + " " + SUBSTR(nv_licen,4,4).  /*A63-0448*/
        END.
        ELSE DO:
            IF      LENGTH(nv_licen) = 3 THEN  ASSIGN nv_Pattern1 = "xx-y-xx"   nv_licen = SUBSTR(nv_licen,1,2) + " " + SUBSTR(nv_licen,3,1) .
            ELSE IF LENGTH(nv_licen) = 4 THEN  ASSIGN nv_Pattern1 = "xx-yy-xx"  nv_licen = SUBSTR(nv_licen,1,2) + " " + SUBSTR(nv_licen,3,2) .
            ELSE IF LENGTH(nv_licen) = 6 THEN DO:
              IF INDEX("0123456789",SUBSTR(nv_licen,3,1)) <> 0 THEN  /*A63-0448*/
                  ASSIGN nv_Pattern1 = "xx-yyyy-xx"  nv_licen = SUBSTR(nv_licen,1,2) + " " + SUBSTR(nv_licen,3,4) .
              ELSE ASSIGN nv_Pattern1 = "xxx-yyy-xx"  nv_licen = SUBSTR(nv_licen,1,3) + " " + SUBSTR(nv_licen,4,3). /*A63-0448*/
            END.
            ELSE IF LENGTH(nv_licen) = 5 THEN DO:
                IF INDEX("0123456789",SUBSTR(nv_licen,2,1)) <> 0 THEN
                   ASSIGN nv_Pattern1 = "x-yyyy-xx"  nv_licen = SUBSTR(nv_licen,1,1) + " " + SUBSTR(nv_licen,2,4).
                ELSE ASSIGN nv_Pattern1 = "xx-yyy-xx"   nv_licen = SUBSTR(nv_licen,1,2) + " " + SUBSTR(nv_licen,3,3).
            END.
        END.
    END.
    /*--------- Server Real ----------*/
    nv_server = "Safety_NotesServer/Safety".
    nv_tmp   = "safety\uw\" + nv_tmp .
    /*-------------------------------*/
    /*---------- Server test local -----------
    nv_server = "". 
    nv_tmp    = "D:\Lotus\Notes\Data\" + nv_tmp .
    ---------------------------------------*/
    CREATE "Notes.NotesSession"  chNotesSession.
    chNotesDatabase  = chNotesSession:GetDatabase (nv_server,nv_tmp).
    IF  chNotesDatabase:IsOpen()  = NO  THEN  DO:
       MESSAGE "Can not open database" SKIP  
               "Please Check database and serve" VIEW-AS  ALERT-BOX ERROR.
    END.
    ELSE DO:
          /*chNotesView    = chNotesDatabase:GetView("เลขตัวถัง").*/
          chNotesView    = chNotesDatabase:GetView("chassis_no").
          chNavView      = chNotesView:CreateViewNavFromCategory(brstat.tlt.cha_no).
          chViewEntry    = chNavView:GetLastDocument.
         IF chViewEntry <> 0 THEN DO: 
             chDocument = chViewEntry:Document.
             IF VALID-HANDLE(chDocument) = YES THEN DO:
                 MESSAGE "Have Data Inspection Plaese Update ISP !! " VIEW-AS ALERT-BOX.
                RELEASE  OBJECT chitem          NO-ERROR.
                RELEASE  OBJECT chDocument      NO-ERROR.          
                RELEASE  OBJECT chNotesDataBase NO-ERROR.     
                RELEASE  OBJECT chNotesSession  NO-ERROR.
             END. /* end chDocument = yes */
             ELSE IF VALID-HANDLE(chDocument) = NO  THEN DO:
                   chDocument = chNotesDatabase:CreateDocument.
                   chDocument:AppendItemValue( "Form", "Inspection").
                   chDocument:AppendItemValue( "createdBy", chNotesSession:UserName).
                   chDocument:AppendItemValue( "createdOn", nv_today + " " + nv_time).
                   chDocument:AppendItemValue( "App", 0 ).
                   chDocument:AppendItemValue( "Chk", 0 ).
                   chDocument:AppendItemValue( "dateS", nv_comdat).
                   chDocument:AppendItemValue( "dateE", nv_expdat).
                   chDocument:AppendItemValue( "ReqType_sub", "ตรวจสภาพใหม่").
                   chDocument:AppendItemValue( "BranchReq", "Dealer Business 1").
                   chDocument:AppendItemValue( "Tname", nv_nameT).
                   chDocument:AppendItemValue( "Fname", nv_firstname).    
                   chDocument:AppendItemValue( "Lname", nv_lastname).
                   chDocument:AppendItemValue( "Phone1", "").
                   chDocument:AppendItemValue( "Phone2", "" ).
                   chDocument:AppendItemValue( "dateMeet", "").    
                   chDocument:AppendItemValue( "placeMeet", "").
                   chDocument:AppendItemValue( "PolicyNo", ""). 
                   chDocument:AppendItemValue( "agentCode",trim(nv_producer)).  
                   chDocument:AppendItemValue( "Agentname",TRIM(nv_agentname)).
                   chDocument:AppendItemValue( "model", nv_brand).
                   chDocument:AppendItemValue( "modelCode", nv_model).
                   chDocument:AppendItemValue( "carCC", trim(brstat.tlt.cha_no)).
                   chDocument:AppendItemValue( "Year", trim(brstat.tlt.old_eng)).           
                   chDocument:AppendItemValue( "LicenseType", trim(nv_licentyp)).
                   chDocument:AppendItemValue( "PatternLi1", trim(nv_Pattern1)).
                   chDocument:AppendItemValue( "PatternLi4", trim(nv_Pattern4)).
                   chDocument:AppendItemValue( "LicenseNo_1", trim(nv_licen)).
                   chDocument:AppendItemValue( "LicenseNo_2", trim(nv_province)).
                   chDocument:AppendItemValue( "commentMK", "ทุนประกัน " + nv_sumfi  ).
                   chDocument:AppendItemValue( "Premium", nv_gprem ).
                   chDocument:AppendItemValue( "StList",0 ).                                  
                   chDocument:AppendItemValue( "stHide",0 ).                                  
                   chDocument:AppendItemValue( "SendTo", "" ).                                 
                   chDocument:AppendItemValue( "SendCC", "" ).
                   chDocument:SAVE(TRUE,TRUE).
                 RELEASE  OBJECT chitem          NO-ERROR.
                 RELEASE  OBJECT chDocument      NO-ERROR.          
                 RELEASE  OBJECT chNotesDataBase NO-ERROR.     
                 RELEASE  OBJECT chNotesSession  NO-ERROR.
                ASSIGN brstat.tlt.note7  = "Y"              /* fi_inspection  */                                                                  
                       brstat.tlt.note8  = ""              /* fi_ispno       */
                       brstat.tlt.note9  = ""              /* fi_ispdetail   */
                       brstat.tlt.note10 = ""              /* fi_ispdamage   */
                       brstat.tlt.note11 = "".              /* fi_ispacc      */
             END. /* end chDocument = NO  */
         END.
         ELSE DO: /* entry view = 0 */
                   chDocument = chNotesDatabase:CreateDocument.
                   chDocument:AppendItemValue( "Form", "Inspection").
                   chDocument:AppendItemValue( "createdBy", chNotesSession:UserName).
                   chDocument:AppendItemValue( "createdOn", nv_today + " " + nv_time).
                   chDocument:AppendItemValue( "App", 0 ).
                   chDocument:AppendItemValue( "Chk", 0 ).
                   chDocument:AppendItemValue( "dateS", nv_comdat).
                   chDocument:AppendItemValue( "dateE", nv_expdat).
                   chDocument:AppendItemValue( "ReqType_sub", "ตรวจสภาพใหม่").
                   chDocument:AppendItemValue( "BranchReq", "Dealer Business 1").
                   chDocument:AppendItemValue( "Tname", nv_nameT).
                   chDocument:AppendItemValue( "Fname", nv_firstname).    
                   chDocument:AppendItemValue( "Lname", nv_lastname).
                   chDocument:AppendItemValue( "Phone1", "").
                   chDocument:AppendItemValue( "Phone2", "" ).
                   chDocument:AppendItemValue( "dateMeet", "").    
                   chDocument:AppendItemValue( "placeMeet", "").
                   chDocument:AppendItemValue( "PolicyNo", ""). 
                   chDocument:AppendItemValue( "agentCode",trim(nv_producer)).  
                   chDocument:AppendItemValue( "Agentname",TRIM(nv_agentname)).
                   chDocument:AppendItemValue( "model", nv_brand).
                   chDocument:AppendItemValue( "modelCode", nv_model).
                   chDocument:AppendItemValue( "carCC", trim(brstat.tlt.cha_no)).
                   chDocument:AppendItemValue( "Year", trim(brstat.tlt.old_eng)).           
                   chDocument:AppendItemValue( "LicenseType", trim(nv_licentyp)).
                   chDocument:AppendItemValue( "PatternLi1", trim(nv_Pattern1)).
                   chDocument:AppendItemValue( "PatternLi4", trim(nv_Pattern4)).
                   chDocument:AppendItemValue( "LicenseNo_1", trim(nv_licen)).
                   chDocument:AppendItemValue( "LicenseNo_2", trim(nv_province)).
                   chDocument:AppendItemValue( "commentMK", "ทุนประกัน " + nv_sumfi  ).
                   chDocument:AppendItemValue( "Premium", nv_gprem ).
                   chDocument:AppendItemValue( "StList",0 ).                                  
                   chDocument:AppendItemValue( "stHide",0 ).                                  
                   chDocument:AppendItemValue( "SendTo", "" ).                                 
                   chDocument:AppendItemValue( "SendCC", "" ).
                   chDocument:SAVE(TRUE,TRUE).
                 RELEASE  OBJECT chitem          NO-ERROR.
                 RELEASE  OBJECT chDocument      NO-ERROR.          
                 RELEASE  OBJECT chNotesDataBase NO-ERROR.     
                 RELEASE  OBJECT chNotesSession  NO-ERROR.
                ASSIGN brstat.tlt.note7  = "Y"              /* fi_inspection  */                                                                  
                       brstat.tlt.note8  = ""              /* fi_ispno       */
                       brstat.tlt.note9  = ""              /* fi_ispdetail   */
                       brstat.tlt.note10 = ""              /* fi_ispdamage   */
                       brstat.tlt.note11 = "".              /* fi_ispacc      */
              
        END.
      END.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_province C-Win 
PROCEDURE proc_province :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
       IF INDEX(nv_province,".") <> 0 THEN REPLACE(nv_province,".","").
        IF nv_province = "กทม"  THEN nv_province = "กท".
        ELSE IF index(nv_province,"กรุงเทพ") <> 0  THEN nv_province = "กท". 
        ELSE DO:
           FIND FIRST brstat.insure USE-INDEX Insure05   WHERE   /*use-index fname */
                brstat.insure.compno = "999" AND 
                brstat.insure.FName  = TRIM(nv_province) NO-LOCK NO-WAIT NO-ERROR.
            IF AVAIL brstat.insure THEN  ASSIGN nv_province = brstat.Insure.LName.
        END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

