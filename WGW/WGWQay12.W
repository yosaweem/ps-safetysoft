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
 Program ID    :  wgwqscb12.w
 Program Name :  Quey & Update data notify Add in table  tlt  
 Create  by  :  Ranu I. A60-0448 Date 16/10/2017
                แสดงข้อมูล และแก้ไขรายละเอียดการแจ้งงาน 
/*Modify by : Kridtiya i. A66-0160 Date. 15/08/2023 Add color */  
/*Modify by   : Ranu I. A67-0162 เพิ่มการเก็บข้อมูลรถไฟฟ้า    */              
+++++++++++++++++++++++++++++++++++++++++++++++*/
Def  Input  parameter  nv_recidtlt  as  recid  .
Def  var nv_index  as int  init 0.
DEF  VAR nv_chaidrep AS CHAR . /*A57-0262*/
DEF  VAR n_char AS CHAR FORMAT "x(250)" INIT "" .
DEF  VAR n_date AS CHAR FORMAT "x(15)" INIT "" .
/* Ranu i. inspection A60-0118           */
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

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS bu_save bu_exit bu_detail2 bu_detail1 ~
fi_brand fi_model fi_body fi_lincen fi_province fi_chssic fi_engno fi_year ~
fi_cc fi_class fi_garcod fi_covtyp fi_covcod fi_si fi_prem fi_lang ~
fi_discdetail fi_refno fi_custcode fi_inspdet fi_brolincen fi_brocod ~
fi_bronam fi_producer fi_agent fi_prem1 fi_stamp fi_vat fi_premtotal fi_dod ~
fi_feelt fi_ncb fi_dridis fi_othdis fi_cctv fi_disc fi_accdet1 fi_accpric1 ~
fi_accdet2 fi_accpric2 fi_accdet3 fi_accpric3 fi_accdet4 fi_accpric4 ~
fi_comdat fi_expdat fi_inspdate fi_remarksend fi_remark fi_polno fi_poltyp ~
fi_trandat fi_user fi_time fi_userup fi_notdat fi_oldpol fi_color fi_maksi ~
fi_watt fi_ev1 fi_ev2 fi_ev3 fi_ev4 fi_ev5 fi_evflag fi_battyr fi_battdat ~
fi_battpric fi_battno fi_battsi fi_charno fi_charbrand fi_accdet5 ~
fi_accpric5 RECT-335 RECT-465 RECT-468 RECT-503 
&Scoped-Define DISPLAYED-OBJECTS fi_brand fi_model fi_body fi_lincen ~
fi_province fi_chssic fi_engno fi_year fi_cc fi_class fi_garcod fi_covtyp ~
fi_covcod fi_si fi_prem fi_lang fi_discdetail fi_refno fi_custcode ~
fi_inspdet fi_brolincen fi_brocod fi_bronam fi_producer fi_agent fi_prem1 ~
fi_stamp fi_vat fi_premtotal fi_dod fi_feelt fi_ncb fi_dridis fi_othdis ~
fi_cctv fi_disc fi_accdet1 fi_accpric1 fi_accdet2 fi_accpric2 fi_accdet3 ~
fi_accpric3 fi_accdet4 fi_accpric4 fi_comdat fi_expdat fi_inspdate ~
fi_remarksend fi_remark fi_polno fi_poltyp fi_trandat fi_user fi_time ~
fi_userup fi_notdat fi_oldpol fi_color fi_maksi fi_watt fi_ev1 fi_ev2 ~
fi_ev3 fi_ev4 fi_ev5 fi_evflag fi_battyr fi_battdat fi_battpric fi_battno ~
fi_battsi fi_charno fi_charbrand fi_accdet5 fi_accpric5 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bu_detail1 
     LABEL "ข้อมูลลูกค้า และการชำระเงิน" 
     SIZE 28 BY 1.52
     BGCOLOR 2 FGCOLOR 7 FONT 6.

DEFINE BUTTON bu_detail2 
     LABEL "ข้อมูลรถและความคุ้มครอง" 
     SIZE 26.67 BY 1.52
     BGCOLOR 7 FGCOLOR 0 FONT 6.

DEFINE BUTTON bu_exit 
     LABEL "Exit" 
     SIZE 8 BY 1.14
     BGCOLOR 6 FGCOLOR 15 FONT 6.

DEFINE BUTTON bu_save 
     LABEL "Save" 
     SIZE 7.83 BY 1.14
     BGCOLOR 2 FGCOLOR 15 FONT 6.

DEFINE VARIABLE fi_accdet1 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 49.67 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_accdet2 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 48 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_accdet3 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 49.67 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_accdet4 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 48 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_accdet5 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 49.67 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_accpric1 AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 11.5 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_accpric2 AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 13.83 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_accpric3 AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 11.5 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_accpric4 AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 13.83 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_accpric5 AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 11.5 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_agent AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 17.5 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_battdat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 13.33 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_battno AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 26.17 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_battpric AS INTEGER FORMAT "->>,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 13 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_battsi AS INTEGER FORMAT "->>,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_battyr AS CHARACTER FORMAT "X(5)":U 
     VIEW-AS FILL-IN 
     SIZE 9 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_body AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 28 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_brand AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 14.83 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_brocod AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 70 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_brolincen AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 17.33 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_bronam AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 28.17 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_cc AS INTEGER FORMAT ">>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 8.33 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_cctv AS DECIMAL FORMAT "->>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 11.33 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_charbrand AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 26.17 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_charno AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 26.17 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_chssic AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 26.17 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_class AS CHARACTER FORMAT "X(5)":U 
     VIEW-AS FILL-IN 
     SIZE 6.5 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_color AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 13.83 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_comdat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 15.17 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_covcod AS CHARACTER FORMAT "X(5)":U 
     VIEW-AS FILL-IN 
     SIZE 7 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_covtyp AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 24.83 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_custcode AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 23.5 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_disc AS DECIMAL FORMAT "->>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 11.33 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_discdetail AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 53.17 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_dod AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 13.17 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_dridis AS DECIMAL FORMAT "->>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 10.67 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_engno AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 28 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_ev1 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 26 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_ev2 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 25 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_ev3 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 25 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_ev4 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 25 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_ev5 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 25 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_evflag AS CHARACTER FORMAT "X(5)":U 
     VIEW-AS FILL-IN 
     SIZE 5.83 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_expdat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 16.5 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_feelt AS DECIMAL FORMAT "->>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 11.33 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_garcod AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 13 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_inspdate AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 12.83 BY .91
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_inspdet AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 52.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_lang AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 13 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_lincen AS CHARACTER FORMAT "X(12)":U 
     VIEW-AS FILL-IN 
     SIZE 13.67 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_maksi AS INTEGER FORMAT "->>,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 15.5 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_model AS CHARACTER FORMAT "X(60)":U 
     VIEW-AS FILL-IN 
     SIZE 28 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_ncb AS DECIMAL FORMAT "->>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 11 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_notdat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 13.67 BY 1
     BGCOLOR 19 FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE fi_oldpol AS CHARACTER FORMAT "X(13)":U 
     VIEW-AS FILL-IN 
     SIZE 17.83 BY 1
     BGCOLOR 15 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_othdis AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 11 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_polno AS CHARACTER FORMAT "X(13)":U 
     VIEW-AS FILL-IN 
     SIZE 17.83 BY 1
     BGCOLOR 15 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_poltyp AS CHARACTER FORMAT "X(3)":U 
     VIEW-AS FILL-IN 
     SIZE 6.17 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_prem AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_prem1 AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 13.67 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_premtotal AS DECIMAL FORMAT "->,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 15.33 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_producer AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 14.67 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_province AS CHARACTER FORMAT "X(35)":U 
     VIEW-AS FILL-IN 
     SIZE 14.67 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_refno AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 23.67 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_remark AS CHARACTER FORMAT "X(150)":U 
     VIEW-AS FILL-IN 
     SIZE 114.33 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_remarksend AS CHARACTER FORMAT "X(80)":U 
     VIEW-AS FILL-IN 
     SIZE 47.33 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_si AS INTEGER FORMAT "->>,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 19.67 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_stamp AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 8.17 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_time AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 13.67 BY 1
     BGCOLOR 8 FGCOLOR 6  NO-UNDO.

DEFINE VARIABLE fi_trandat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 13.67 BY 1
     BGCOLOR 8 FGCOLOR 6  NO-UNDO.

DEFINE VARIABLE fi_user AS CHARACTER FORMAT "X(13)":U 
     VIEW-AS FILL-IN 
     SIZE 10.17 BY 1
     BGCOLOR 8 FGCOLOR 4 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_userup AS CHARACTER FORMAT "X(13)":U 
     VIEW-AS FILL-IN 
     SIZE 10.17 BY 1
     BGCOLOR 19 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_vat AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 11.33 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_watt AS INTEGER FORMAT ">>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 6.5 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_year AS CHARACTER FORMAT "X(5)":U 
     VIEW-AS FILL-IN 
     SIZE 12 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE RECTANGLE RECT-335
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132.5 BY 24.14
     BGCOLOR 19 FGCOLOR 0 .

DEFINE RECTANGLE RECT-465
     EDGE-PIXELS 2 GRAPHIC-EDGE    ROUNDED 
     SIZE 130 BY 17.38
     BGCOLOR 19 FGCOLOR 2 .

DEFINE RECTANGLE RECT-468
     EDGE-PIXELS 2 GRAPHIC-EDGE    ROUNDED 
     SIZE 130.5 BY 4.76
     BGCOLOR 19 FGCOLOR 2 .

DEFINE RECTANGLE RECT-503
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 22.5 BY 1.67
     BGCOLOR 10 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     bu_save AT ROW 26.91 COL 113.17
     bu_exit AT ROW 26.91 COL 124
     bu_detail2 AT ROW 1.1 COL 29.67
     bu_detail1 AT ROW 1.1 COL 1.67
     fi_brand AT ROW 5.38 COL 14.33 COLON-ALIGNED NO-LABEL
     fi_model AT ROW 5.38 COL 37.33 COLON-ALIGNED NO-LABEL
     fi_body AT ROW 5.38 COL 76.5 COLON-ALIGNED NO-LABEL
     fi_lincen AT ROW 5.38 COL 116.17 COLON-ALIGNED NO-LABEL
     fi_province AT ROW 6.48 COL 14.33 COLON-ALIGNED NO-LABEL
     fi_chssic AT ROW 6.48 COL 39.5 COLON-ALIGNED NO-LABEL
     fi_engno AT ROW 6.48 COL 76.5 COLON-ALIGNED NO-LABEL
     fi_year AT ROW 6.48 COL 118 COLON-ALIGNED NO-LABEL
     fi_cc AT ROW 7.57 COL 14.5 COLON-ALIGNED NO-LABEL
     fi_class AT ROW 7.57 COL 42.83 COLON-ALIGNED NO-LABEL
     fi_garcod AT ROW 7.52 COL 58.5 COLON-ALIGNED NO-LABEL
     fi_covtyp AT ROW 7.57 COL 85.67 COLON-ALIGNED NO-LABEL
     fi_covcod AT ROW 8.67 COL 14.5 COLON-ALIGNED NO-LABEL
     fi_si AT ROW 8.67 COL 85.83 COLON-ALIGNED NO-LABEL
     fi_prem AT ROW 9.76 COL 14.17 COLON-ALIGNED NO-LABEL
     fi_lang AT ROW 23.1 COL 99 COLON-ALIGNED NO-LABEL
     fi_discdetail AT ROW 11.91 COL 36.83 COLON-ALIGNED NO-LABEL
     fi_refno AT ROW 4.19 COL 70.33 COLON-ALIGNED NO-LABEL
     fi_custcode AT ROW 4.19 COL 106.17 COLON-ALIGNED NO-LABEL
     fi_inspdet AT ROW 24.14 COL 14 COLON-ALIGNED NO-LABEL
     fi_brolincen AT ROW 22.05 COL 80.83 COLON-ALIGNED NO-LABEL
     fi_brocod AT ROW 23.14 COL 14 COLON-ALIGNED NO-LABEL
     fi_bronam AT ROW 22.1 COL 42.33 COLON-ALIGNED NO-LABEL
     fi_producer AT ROW 4.24 COL 14.5 COLON-ALIGNED NO-LABEL
     fi_agent AT ROW 4.24 COL 38.33 COLON-ALIGNED NO-LABEL
     fi_prem1 AT ROW 9.76 COL 40.67 COLON-ALIGNED NO-LABEL
     fi_stamp AT ROW 9.76 COL 62.83 COLON-ALIGNED NO-LABEL
     fi_vat AT ROW 9.76 COL 76.5 COLON-ALIGNED NO-LABEL
     fi_premtotal AT ROW 9.76 COL 96 COLON-ALIGNED NO-LABEL
     fi_dod AT ROW 9.76 COL 116.5 COLON-ALIGNED NO-LABEL
     fi_feelt AT ROW 10.86 COL 14.33 COLON-ALIGNED NO-LABEL
     fi_ncb AT ROW 10.81 COL 40.67 COLON-ALIGNED NO-LABEL
     fi_dridis AT ROW 10.81 COL 65.83 COLON-ALIGNED NO-LABEL
     fi_othdis AT ROW 10.86 COL 88.5 COLON-ALIGNED NO-LABEL
     fi_cctv AT ROW 10.86 COL 112.5 COLON-ALIGNED NO-LABEL
     fi_disc AT ROW 11.91 COL 14.33 COLON-ALIGNED NO-LABEL
     fi_accdet1 AT ROW 13.86 COL 4.33 COLON-ALIGNED NO-LABEL
     fi_accpric1 AT ROW 13.86 COL 54 COLON-ALIGNED NO-LABEL
     fi_accdet2 AT ROW 13.86 COL 68 COLON-ALIGNED NO-LABEL
     fi_accpric2 AT ROW 13.86 COL 116 COLON-ALIGNED NO-LABEL
     fi_accdet3 AT ROW 14.81 COL 4.33 COLON-ALIGNED NO-LABEL
     fi_accpric3 AT ROW 14.81 COL 54 COLON-ALIGNED NO-LABEL
     fi_accdet4 AT ROW 14.81 COL 68 COLON-ALIGNED NO-LABEL
     fi_accpric4 AT ROW 14.81 COL 116 COLON-ALIGNED NO-LABEL
     fi_comdat AT ROW 8.67 COL 32.17 COLON-ALIGNED NO-LABEL
     fi_expdat AT ROW 8.67 COL 59.33 COLON-ALIGNED NO-LABEL
     fi_inspdate AT ROW 22.14 COL 14.17 COLON-ALIGNED NO-LABEL
     fi_remarksend AT ROW 24.14 COL 80.67 COLON-ALIGNED NO-LABEL
     fi_remark AT ROW 25.19 COL 13.67 COLON-ALIGNED NO-LABEL
     fi_polno AT ROW 2.67 COL 88.33 COLON-ALIGNED NO-LABEL
     fi_poltyp AT ROW 2.71 COL 68.83 COLON-ALIGNED NO-LABEL
     fi_trandat AT ROW 27 COL 12.67 COLON-ALIGNED NO-LABEL
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1.17 ROW 1.05
         SIZE 133.67 BY 27.57
         BGCOLOR 31 FGCOLOR 2 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     fi_user AT ROW 27 COL 51.17 COLON-ALIGNED NO-LABEL
     fi_time AT ROW 27 COL 31.5 COLON-ALIGNED NO-LABEL
     fi_userup AT ROW 27.1 COL 90.33 COLON-ALIGNED NO-LABEL WIDGET-ID 10
     fi_notdat AT ROW 2.67 COL 117.17 COLON-ALIGNED NO-LABEL WIDGET-ID 6
     fi_oldpol AT ROW 2.71 COL 50.5 COLON-ALIGNED NO-LABEL WIDGET-ID 14
     fi_color AT ROW 7.57 COL 116 COLON-ALIGNED NO-LABEL WIDGET-ID 20
     fi_maksi AT ROW 8.62 COL 114.5 COLON-ALIGNED NO-LABEL WIDGET-ID 26
     fi_watt AT ROW 7.62 COL 29.33 COLON-ALIGNED NO-LABEL WIDGET-ID 32
     fi_ev1 AT ROW 17.57 COL 2 COLON-ALIGNED NO-LABEL WIDGET-ID 40
     fi_ev2 AT ROW 17.57 COL 28.33 COLON-ALIGNED NO-LABEL WIDGET-ID 44
     fi_ev3 AT ROW 17.62 COL 53.83 COLON-ALIGNED NO-LABEL WIDGET-ID 48
     fi_ev4 AT ROW 17.62 COL 79.17 COLON-ALIGNED NO-LABEL WIDGET-ID 52
     fi_ev5 AT ROW 17.62 COL 104.5 COLON-ALIGNED NO-LABEL WIDGET-ID 56
     fi_evflag AT ROW 18.67 COL 16.67 COLON-ALIGNED NO-LABEL WIDGET-ID 66
     fi_battyr AT ROW 18.67 COL 32.33 COLON-ALIGNED NO-LABEL WIDGET-ID 70
     fi_battdat AT ROW 18.71 COL 58.5 COLON-ALIGNED NO-LABEL WIDGET-ID 74
     fi_battpric AT ROW 18.71 COL 82.33 COLON-ALIGNED NO-LABEL WIDGET-ID 78
     fi_battno AT ROW 18.76 COL 103.17 COLON-ALIGNED NO-LABEL WIDGET-ID 82
     fi_battsi AT ROW 19.76 COL 16.67 COLON-ALIGNED NO-LABEL WIDGET-ID 86
     fi_charno AT ROW 19.76 COL 48.33 COLON-ALIGNED NO-LABEL WIDGET-ID 90
     fi_charbrand AT ROW 19.81 COL 94.17 COLON-ALIGNED NO-LABEL WIDGET-ID 94
     fi_accdet5 AT ROW 15.76 COL 4.33 COLON-ALIGNED NO-LABEL WIDGET-ID 102
     fi_accpric5 AT ROW 15.76 COL 54 COLON-ALIGNED NO-LABEL WIDGET-ID 104
     "รายละเอียด:" VIEW-AS TEXT
          SIZE 10 BY .91 AT ROW 11.86 COL 28.5
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "เลขเครื่อง:" VIEW-AS TEXT
          SIZE 8.33 BY .91 AT ROW 6.57 COL 68.83
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "2 :" VIEW-AS TEXT
          SIZE 2.17 BY .91 AT ROW 13.91 COL 67.67
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "ส่วนลดเพิ่ม:" VIEW-AS TEXT
          SIZE 9.5 BY .91 AT ROW 11.95 COL 6
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "New Policy :" VIEW-AS TEXT
          SIZE 12.33 BY .91 AT ROW 2.71 COL 77.83
          BGCOLOR 20 FGCOLOR 7 FONT 6
     "Old Policy :" VIEW-AS TEXT
          SIZE 11.33 BY .91 AT ROW 2.76 COL 40.83 WIDGET-ID 16
          BGCOLOR 20 FGCOLOR 7 FONT 6
     "วันคุ้มครอง:" VIEW-AS TEXT
          SIZE 9.5 BY .91 AT ROW 8.71 COL 24.5
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "ทุนประกัน:" VIEW-AS TEXT
          SIZE 8.83 BY .91 AT ROW 8.71 COL 78.5
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "สีรถ :" VIEW-AS TEXT
          SIZE 4.5 BY 1 AT ROW 7.57 COL 113.33 WIDGET-ID 22
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "  ข้อมูลตรวจสภาพและอื่นๆ" VIEW-AS TEXT
          SIZE 24.17 BY .86 AT ROW 21.24 COL 3.67
          BGCOLOR 19 FGCOLOR 6 FONT 6
     "วันที่โหลดงาน:" VIEW-AS TEXT
          SIZE 11.5 BY .91 AT ROW 27.05 COL 3
          FGCOLOR 7 FONT 1
     "ส่วนลดผู้ขับขี่:" VIEW-AS TEXT
          SIZE 11.17 BY .91 AT ROW 10.86 COL 55.67
          BGCOLOR 19 FGCOLOR 2 FONT 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1.17 ROW 1.05
         SIZE 133.67 BY 27.57
         BGCOLOR 31 FGCOLOR 2 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "เลขตัวถัง :" VIEW-AS TEXT
          SIZE 8.5 BY .91 AT ROW 6.52 COL 32.5
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "หมายเหตุ:" VIEW-AS TEXT
          SIZE 8.5 BY .91 AT ROW 25.24 COL 7
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "สถานที่ :" VIEW-AS TEXT
          SIZE 7.5 BY .91 AT ROW 23.19 COL 8.17
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "3:" VIEW-AS TEXT
          SIZE 2.17 BY .91 AT ROW 14.91 COL 4
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "เบี้ยสุทธิหลังลด:" VIEW-AS TEXT
          SIZE 12.33 BY .91 AT ROW 9.86 COL 30.33
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "จังหวัดทะเบียน:" VIEW-AS TEXT
          SIZE 12.67 BY .91 AT ROW 6.52 COL 3.5
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "ความคุ้มครอง:" VIEW-AS TEXT
          SIZE 11.33 BY .91 AT ROW 8.71 COL 5
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "รหัสลูกค้า:" VIEW-AS TEXT
          SIZE 9.5 BY .91 AT ROW 4.24 COL 97.83
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "  ข้อมูลรถและความคุ้มครอง" VIEW-AS TEXT
          SIZE 24.67 BY .91 AT ROW 1.14 COL 108.5
          FGCOLOR 7 FONT 6
     "Update By :" VIEW-AS TEXT
          SIZE 11.5 BY .91 AT ROW 27.14 COL 80.17 WIDGET-ID 12
          FGCOLOR 15 FONT 6
     "ประเภทประกัน:" VIEW-AS TEXT
          SIZE 12.5 BY .91 AT ROW 7.67 COL 75
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "  ข้อมูลรถและความคุ้มครอง" VIEW-AS TEXT
          SIZE 24.17 BY .91 AT ROW 3.1 COL 3.67
          BGCOLOR 19 FGCOLOR 6 FONT 6
     "Class :" VIEW-AS TEXT
          SIZE 5.5 BY .91 AT ROW 7.57 COL 39
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "STAMP:" VIEW-AS TEXT
          SIZE 7.33 BY .91 AT ROW 9.81 COL 57.5
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "ปีจดทะเบียน :" VIEW-AS TEXT
          SIZE 11.17 BY .91 AT ROW 6.52 COL 108.17
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "ผลการตรวจ:" VIEW-AS TEXT
          SIZE 10.5 BY .91 AT ROW 24.19 COL 5.17
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "เลขที่อ้างอิง:" VIEW-AS TEXT
          SIZE 11.33 BY .91 AT ROW 4.29 COL 60.5
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "VAT:" VIEW-AS TEXT
          SIZE 4.5 BY .91 AT ROW 9.81 COL 73.5
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "1:" VIEW-AS TEXT
          SIZE 2.17 BY .91 AT ROW 13.91 COL 4
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "เวลา:" VIEW-AS TEXT
          SIZE 4.5 BY .91 AT ROW 27.05 COL 28.67
          FGCOLOR 7 FONT 1
     "Producer :" VIEW-AS TEXT
          SIZE 10.83 BY .91 AT ROW 4.29 COL 5.17
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "ส่วนลดอื่นๆ:" VIEW-AS TEXT
          SIZE 10 BY .91 AT ROW 10.91 COL 80
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "หมายเหตุการส่ง:" VIEW-AS TEXT
          SIZE 13 BY .91 AT ROW 24.14 COL 69.5
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "ส่วนลดประวัติดี:" VIEW-AS TEXT
          SIZE 13 BY .91 AT ROW 10.86 COL 28.83
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "4:" VIEW-AS TEXT
          SIZE 2.17 BY .91 AT ROW 14.86 COL 67.67
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "แบบตัวถัง:" VIEW-AS TEXT
          SIZE 9 BY .91 AT ROW 5.48 COL 68.17
          BGCOLOR 19 FGCOLOR 2 FONT 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1.17 ROW 1.05
         SIZE 133.67 BY 27.57
         BGCOLOR 31 FGCOLOR 2 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "DOD:" VIEW-AS TEXT
          SIZE 4.5 BY .91 AT ROW 9.81 COL 113.5
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "เบี้ยรวม:" VIEW-AS TEXT
          SIZE 6.83 BY .91 AT ROW 9.86 COL 90.5
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "ขนาดเครื่องCC :" VIEW-AS TEXT
          SIZE 13 BY .91 AT ROW 7.62 COL 3.5
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "ยี่ห้อ:" VIEW-AS TEXT
          SIZE 4.5 BY .91 AT ROW 5.33 COL 11
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "ส่วนลด CCTV:" VIEW-AS TEXT
          SIZE 11.67 BY .91 AT ROW 10.91 COL 102.5
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "Agent Name :" VIEW-AS TEXT
          SIZE 11.5 BY .91 AT ROW 23.14 COL 88.5
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "ชื่อผู้ตรวจสภาพ :" VIEW-AS TEXT
          SIZE 13.67 BY .91 AT ROW 22.14 COL 30.33
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "ทะเบียนรถ :" VIEW-AS TEXT
          SIZE 10.67 BY .91 AT ROW 5.43 COL 107
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "User:" VIEW-AS TEXT
          SIZE 5.33 BY .91 AT ROW 27.05 COL 47.67
          FGCOLOR 7 FONT 6
     "การซ่อม :" VIEW-AS TEXT
          SIZE 7.67 BY .91 AT ROW 7.62 COL 52.33
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "วันที่ตรวจสภาพ:" VIEW-AS TEXT
          SIZE 12.5 BY .91 AT ROW 22.19 COL 3.17
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "รุ่นรถ:" VIEW-AS TEXT
          SIZE 6 BY .91 AT ROW 5.43 COL 32.67
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "รายละเอียดอุปกรณ์เสริม:" VIEW-AS TEXT
          SIZE 24 BY .86 AT ROW 13 COL 6.5 WIDGET-ID 24
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "Car Price :" VIEW-AS TEXT
          SIZE 8.17 BY .91 AT ROW 8.62 COL 108 WIDGET-ID 28
          BGCOLOR 19 FGCOLOR 0 FONT 1
     "ราคา :" VIEW-AS TEXT
          SIZE 6.17 BY .86 AT ROW 12.95 COL 56.33 WIDGET-ID 30
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "Watt :" VIEW-AS TEXT
          SIZE 4.83 BY .91 AT ROW 7.67 COL 25.83 WIDGET-ID 34
          BGCOLOR 19 FGCOLOR 0 FONT 1
     "รายละเอียดอุปกรณ์เสริม :" VIEW-AS TEXT
          SIZE 22 BY .86 AT ROW 13 COL 70.5 WIDGET-ID 36
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "วันที่หมดอายุ:" VIEW-AS TEXT
          SIZE 11.5 BY .91 AT ROW 8.71 COL 49.83
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "ราคา :" VIEW-AS TEXT
          SIZE 6 BY .86 AT ROW 12.95 COL 118.5 WIDGET-ID 38
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "EVMotor 1:" VIEW-AS TEXT
          SIZE 9.5 BY .81 AT ROW 16.76 COL 4.17 WIDGET-ID 42
          BGCOLOR 19 FGCOLOR 0 FONT 1
     "EVMotor 2:" VIEW-AS TEXT
          SIZE 9.5 BY .81 AT ROW 16.76 COL 30.67 WIDGET-ID 58
          BGCOLOR 19 FGCOLOR 0 FONT 1
     "EVMotor 3:" VIEW-AS TEXT
          SIZE 9.5 BY .81 AT ROW 16.76 COL 55.33 WIDGET-ID 60
          BGCOLOR 19 FGCOLOR 0 FONT 1
     "EVMotor 4:" VIEW-AS TEXT
          SIZE 9.5 BY .81 AT ROW 16.76 COL 80.83 WIDGET-ID 62
          BGCOLOR 19 FGCOLOR 0 FONT 1
     "EVMotor 5:" VIEW-AS TEXT
          SIZE 9.5 BY .81 AT ROW 16.76 COL 106.83 WIDGET-ID 64
          BGCOLOR 19 FGCOLOR 0 FONT 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1.17 ROW 1.05
         SIZE 133.67 BY 27.57
         BGCOLOR 31 FGCOLOR 2 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "Change Batt Flag :" VIEW-AS TEXT
          SIZE 14.67 BY .81 AT ROW 18.76 COL 3.5 WIDGET-ID 68
          BGCOLOR 19 FGCOLOR 0 FONT 1
     "Batt Year :" VIEW-AS TEXT
          SIZE 9 BY .91 AT ROW 18.71 COL 25.33 WIDGET-ID 72
          BGCOLOR 19 FGCOLOR 0 FONT 1
     "Batt Purchase Date :" VIEW-AS TEXT
          SIZE 16.5 BY .91 AT ROW 18.76 COL 43.83 WIDGET-ID 76
          BGCOLOR 19 FGCOLOR 0 FONT 1
     "เบอร์โทร:" VIEW-AS TEXT
          SIZE 8.33 BY .91 AT ROW 22.19 COL 73.67
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "วันที่แจ้งงาน:" VIEW-AS TEXT
          SIZE 10.5 BY .91 AT ROW 2.71 COL 108.5 WIDGET-ID 8
          BGCOLOR 20 FGCOLOR 7 FONT 1
     "Batt Price :" VIEW-AS TEXT
          SIZE 9 BY .91 AT ROW 18.71 COL 74.83 WIDGET-ID 80
          BGCOLOR 19 FGCOLOR 0 FONT 1
     "Batt no :" VIEW-AS TEXT
          SIZE 7.5 BY .91 AT ROW 18.81 COL 97.83 WIDGET-ID 84
          BGCOLOR 19 FGCOLOR 0 FONT 1
     "Batt Suminsured :" VIEW-AS TEXT
          SIZE 14 BY .91 AT ROW 19.81 COL 4.33 WIDGET-ID 88
          BGCOLOR 19 FGCOLOR 0 FONT 1
     "Wall Charge No :" VIEW-AS TEXT
          SIZE 13.5 BY .91 AT ROW 19.81 COL 36.17 WIDGET-ID 92
          BGCOLOR 19 FGCOLOR 0 FONT 1
     "Wall Charge Brand :" VIEW-AS TEXT
          SIZE 16.33 BY .91 AT ROW 19.86 COL 79.33 WIDGET-ID 96
          BGCOLOR 19 FGCOLOR 0 FONT 1
     "5:" VIEW-AS TEXT
          SIZE 2.17 BY .91 AT ROW 15.86 COL 4 WIDGET-ID 106
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "ส่วนลดกลุ่ม:" VIEW-AS TEXT
          SIZE 10 BY .91 AT ROW 10.91 COL 6
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "เบี้ยสุทธิก่อนลด:" VIEW-AS TEXT
          SIZE 12.83 BY .91 AT ROW 9.86 COL 3
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "Agent :" VIEW-AS TEXT
          SIZE 7.67 BY .91 AT ROW 4.29 COL 32
          BGCOLOR 19 FGCOLOR 2 FONT 6
     RECT-335 AT ROW 2.57 COL 1.67
     RECT-465 AT ROW 3.86 COL 2.5
     RECT-468 AT ROW 21.71 COL 2.5
     RECT-503 AT ROW 26.71 COL 111 WIDGET-ID 18
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1.17 ROW 1.05
         SIZE 133.67 BY 27.57
         BGCOLOR 31 FGCOLOR 2 .


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
         TITLE              = "Update Data Notify AYCAL"
         HEIGHT             = 27.67
         WIDTH              = 133.83
         MAX-HEIGHT         = 27.67
         MAX-WIDTH          = 135
         VIRTUAL-HEIGHT     = 27.67
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
ASSIGN 
       fi_notdat:READ-ONLY IN FRAME fr_main        = TRUE.

ASSIGN 
       fi_poltyp:READ-ONLY IN FRAME fr_main        = TRUE.

ASSIGN 
       fi_time:READ-ONLY IN FRAME fr_main        = TRUE.

ASSIGN 
       fi_trandat:READ-ONLY IN FRAME fr_main        = TRUE.

ASSIGN 
       fi_user:READ-ONLY IN FRAME fr_main        = TRUE.

ASSIGN 
       fi_userup:READ-ONLY IN FRAME fr_main        = TRUE.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Update Data Notify AYCAL */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Update Data Notify AYCAL */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_detail1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_detail1 C-Win
ON CHOOSE OF bu_detail1 IN FRAME fr_main /* ข้อมูลลูกค้า และการชำระเงิน */
DO:
     nv_recidtlt  =  Recid(tlt).
    
    {&WINDOW-NAME}:hidden  =  Yes. 
    
    Run  wgw\wgwqay11(Input  nv_recidtlt).
    Apply "Close"  To this-procedure.
    Return no-apply.
    {&WINDOW-NAME}:hidden  =  No. 
  
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
                    brstat.tlt.policy        = trim(fi_polno)   
                    brstat.tlt.recac         = trim(fi_agent)   
                    brstat.tlt.subins        = trim(fi_producer)
                    brstat.tlt.nor_noti_ins  = trim(fi_refno)   
                    brstat.tlt.nor_usr_ins   = trim(fi_custcode)
                    brstat.tlt.brand         = TRIM(fi_brand)          /*ชื่อรถยนต์         */                                 
                    brstat.tlt.model         = trim(fi_model)          /*ชื่อรุ่นรถยนต์     */                                 
                    brstat.tlt.expousr       = trim(fi_body )          /*แบบตัวถัง          */                                 
                    brstat.tlt.lince1        = trim(fi_lincen)         /*ทะเบียนรถ          */                                 
                    brstat.tlt.lince2        = trim(fi_province)       /*จังหวัดที่จดทะเบียน*/                                 
                    brstat.tlt.cha_no        = trim(fi_chssic)         /*เลขตัวถัง          */                                   
                    brstat.tlt.eng_no        = trim(fi_engno)          /*เลขเครื่องยนต์     */                                    
                    brstat.tlt.gentim        = trim(fi_year)           /*ปีจดทะเบียนรถ      */                                     
                    /*brstat.tlt.sentcnt       = INT(fi_seat)  */          /*จำนวนที่นั่ง       */                                       
                    brstat.tlt.rencnt        = INT(fi_cc)              /*ขนาดเครื่องยนต์    */                                         
                    /*brstat.tlt.cc_weight     = INT(fi_ton)  */           /*น้ำหนัก            */                                        
                    brstat.tlt.expotim       = trim(fi_class)          /*รหัสการใช้รถยนต์   */
                    brstat.tlt.old_cha       = "GarCd:" + trim(fi_garcod)           /*รหัสการซ่อม        */                            
                                              /* "GarTy:" + trim(fi_garage)  */                 /*ประเภทการซ่อม      */                            
                    /*brstat.tlt.colorcod      = trim(fi_color)  */                             /*สีรถยนต์  */                                    
                    brstat.tlt.rec_addr3     = "CovCod:" + trim(fi_covtyp) + " " +          /*ประเภทของประกันภัย        */                    
                                               "CovTcd:" + trim(fi_covcod)           /*รหัสประเภทของประกันภัย    */                    
                                              /* "CovTyp:" + trim(fi_cover)  + " " +        /*ประเภทของความคุ้มครอง     */                    
                                               "CovTy1:" + trim(fi_subcover) + " " +      /*ประเภทย่อยของความคุ้มครอง */                    
                                               "CovTy2:" + trim(fi_covdetail) */             /*รายละเอียดความคุ้มครอง    */                    
                    brstat.tlt.gendat        = date(fi_comdat)                              /*วันเริ่มความคุ้มครอง      */                    
                    brstat.tlt.expodat       = DATE(fi_expdat)                              /*วันที่สิ้นสุดความคุ้มครอง */                    
                    brstat.tlt.nor_coamt     = DECI(fi_si)                                  /*ทุนประกัน                 */                    
                    brstat.tlt.nor_grprm     = DECI(fi_prem)                                /*เบี้ยสุทธิก่อนหักส่วนลด   */                    
                    brstat.tlt.comp_grprm    = DECI(fi_prem1)                               /*เบี้ยสุทธิหลังหักส่วนลด   */                    
                    brstat.tlt.stat          = "Stm:" + STRING(deci(fi_stamp)) + " " +      /*จำนวนอากรสแตมป์       */                        
                                               "Vat:" + STRING(DECI(fi_vat))                /*จำนวนภาษี SBT/Vat     */                        
                    brstat.tlt.comp_coamt    = deci(fi_premtotal)                           /*เบี้ยรวม ภาษี-อากร    */                        
                    brstat.tlt.endno         = string(DECI(fi_dod))                         /*ค่าความเสียหายส่วนแรก */                        
                    brstat.tlt.comp_sck      = /*"fetP:" + STRING(DECI(fi_feeltp)) + " " + */   /*% ส่วนลดกลุ่ม         */    
                                               "felA:" + STRING(DECI(fi_feelt))             /*จำนวนส่วนลดกลุ่ม      */    
                    brstat.tlt.comp_noti_tlt = /*"NcbP:" + string(DECI(fi_ncbp)) + " " +  */    /*% ส่วนลดประวัติดี     */    
                                               "NcbA:" + string(DECI(fi_ncb))               /*จำนวนส่วนลดประวัติดี  */    
                    brstat.tlt.comp_usr_tlt  = /*"DriP:" + string(DECI(fi_drip)) + " " + */     /*% ส่วนลดกรณีผู้ขับขี่ */    
                                               "DriA:" + string(DECI(fi_dridis))            /*จำนวนส่วนลดกรณีผู้ขับขี่  */    
                    brstat.tlt.comp_noti_ins = /*"OthP:" + string(DECI(fi_oth)) + " " + */      /*%สวนลดอื่นๆ           */    
                                               "OthA:" + string(DECI(fi_othdis))            /*จำนวนส่วนลดอื่นๆ      */    
                    brstat.tlt.comp_usr_ins  = /*"CTVP:" + string(DECI(fi_cctvp)) + " " +  */   /*%สวนลดกล้อง           */    
                                               "CTVA:" + string(DECI(fi_cctv))              /*จำนวนส่วนลดกล้อง      */    
                    brstat.tlt.comp_pol      = /*"SurP:" + string(DECI(fi_discp)) + " " + */    /*%ส่วนลดเพิ่ม        */   
                                               "SurA:" + string(DECI(fi_disc))    + " " +   /*จำนวนส่วนลดเพิ่ม    */    
                                               "SurD:" + trim(fi_discdetail)                /*รายละเอียดส่วนเพิ่ม */    
                    brstat.tlt.filler1       = /*"Acc1:" + trim(fi_accr1)       + " " +  */     /*รหัส อุปกรณ์1  */   
                                               "Acd1:" + trim(fi_accdet1) + " " +           /*รายละเอียด1    */    
                                               "Acp1:" + STRING(DECI(fi_accpric1))  + " " + /*ราคาอุปกรณ์1   */    
                                               /*"Acc2:" + trim(fi_accr2)       + " " +*/       /*รหัส อุปกรณ์2  */    
                                               "Acd2:" + trim(fi_accdet2) + " " +           /*รายละเอียด2    */    
                                               "Acp2:" + STRING(DECI(fi_accpric2))  + " " + /*ราคาอุปกรณ์2   */    
                                               /*"Acc3:" + trim(fi_accr3)       + " " + */      /*รหัส อุปกรณ์3  */    
                                               "Acd3:" + trim(fi_accdet3) + " " +           /*รายละเอียด3    */    
                                               "Acp3:" + STRING(DECI(fi_accpric3))  + " " + /*ราคาอุปกรณ์3   */    
                                               /*"Acc4:" + trim(fi_accr4)       + " " +  */     /*รหัส อุปกรณ์4  */    
                                               "Acd4:" + trim(fi_accdet4) + " " +           /*รายละเอียด 4   */    
                                               "Acp4:" + STRING(DECI(fi_accpric4)) + " " +          /*ราคาอุปกรณ์4   */    
                                              /* "Acc5:" + trim(fi_accr5)       + " " + */      /*รหัส อุปกรณ์5  */    
                                               "Acd5:" + TRIM(fi_accdet5) + " " +           /*รายละเอียด 5   */    
                                               "Acp5:" + STRING(DECI(fi_accpric5))          /*ราคาอุปกรณ์5     */  
                    brstat.tlt.nor_effdat    = date(fi_inspdate)                            /*วันที่ตรวจสภาพรถ */    
                    /*brstat.tlt.comp_effdat   = date(fi_appdate)   */                          /*วันที่อนุมัติตรวจสภาพรถ   */    
                    brstat.tlt.nor_noti_tlt  = /*"InspSt:" + trim(fi_inspres) + " " + */        /*ผลการตรวจสภาพรถ           */    
                                               "InspDe:" + trim(fi_inspdet)                 /*รายละเอียดการตรวจสภาพรถ   */    
                    brstat.tlt.old_eng       = "Bphon:"  + trim(fi_brolincen) + " " +       /*เลขที่ใบอนุญาตนายหน้า   */      
                                               "Bname:"  + trim(fi_bronam) + " " +          /*ชื่อบริษัทนายหน้า       */      
                                               "Bloca:"  + trim(fi_brocod)                  /*รหัสโบรคเกอร์           */      
                    brstat.tlt.filler2       = /*"Detai1:" + trim(fi_lang) + " " +            /*ภาษาในการออกกรมธรรม์    */      
                                               "Detai2:" + trim(fi_polsend) + " " +*/         /*ช่องทางการจัดส่ง        */      
                                               "Detai3:" + trim(fi_remarksend) + " " +      /*หมายเหตุการจัดส่ง       */      
                                              /* "Detai4:" + trim(fi_gift) + " " + */           /*ของแถม                  */      
                                               "Remark:" + trim(fi_remark)                 /*หมายเหตุ                */
                    brstat.tlt.EXP           = trim(fi_lang)
                    brstat.tlt.note1         = trim(fi_color)  /*A66-0160*/
                    brstat.tlt.imp           = /*trim(SUBSTR(brstat.tlt.imp,1,INDEX(brstat.tlt.imp," ") - 1))  + " " +  */      /*ประเภท        */ 
                                               "Pol:" + TRIM(fi_oldpol)                 /*เบอร์เดิม */
                    brstat.tlt.usrid         = IF index(brstat.tlt.usrid,"/") <> 0 THEN SUBSTR(brstat.tlt.usrid,1,INDEX(tlt.usrid,"/")) + USERID(LDBNAME(1)) 
                                               ELSE brstat.tlt.usrid + "/" + USERID(LDBNAME(1))             /*user update*/
                    /* Add by : A67-0162 */
                     brstat.tlt.watts     = input fi_watt     
                     brstat.tlt.maksi     = input fi_maksi    
                     brstat.tlt.note4     = trim(input fi_ev1)      
                     brstat.tlt.note5     = trim(input fi_ev2)      
                     brstat.tlt.note6     = trim(input fi_ev3)      
                     brstat.tlt.note7     = trim(input fi_ev4)      
                     brstat.tlt.note8     = trim(input fi_ev5)      
                     brstat.tlt.battflg   = LOGICAL(fi_evflag)          
                     brstat.tlt.battyr    = input fi_battyr   
                     brstat.tlt.ndate1    = input fi_battdat  
                     brstat.tlt.battprice = input fi_battpric 
                     brstat.tlt.battno    = trim(INPUT fi_battno)   
                     brstat.tlt.battsi    = INPUT fi_battsi   
                     brstat.tlt.chargno   = trim(input fi_charno)   
                     brstat.tlt.note19    = trim(input fi_charbrand) .
                   /* end : A67-0162 */
            END.                                                    
            /*Apply "Close" to this-procedure.
            Return no-apply.*/
             APPLY "entry" TO fi_polno.
            RETURN NO-APPLY. 
        END.
        WHEN FALSE THEN /* No */          
            DO:   
            APPLY "entry" TO fi_polno.
            RETURN NO-APPLY.
        END.
        END CASE.
Disp  fi_polno with  frame  fr_main.
RELEASE brstat.tlt.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_accdet1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_accdet1 C-Win
ON LEAVE OF fi_accdet1 IN FRAME fr_main
DO:
    fi_accdet1 = INPUT fi_accdet1.
    DISP fi_accdet1 WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_accdet2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_accdet2 C-Win
ON LEAVE OF fi_accdet2 IN FRAME fr_main
DO:
    fi_accdet2 = INPUT fi_accdet2.
    DISP fi_accdet2 WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_accdet3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_accdet3 C-Win
ON LEAVE OF fi_accdet3 IN FRAME fr_main
DO:
    fi_accdet3 = INPUT fi_accdet3.
    DISP fi_accdet3 WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_accdet4
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_accdet4 C-Win
ON LEAVE OF fi_accdet4 IN FRAME fr_main
DO:
    fi_accdet4 = INPUT fi_accdet4.
    DISP fi_accdet4 WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_accdet5
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_accdet5 C-Win
ON LEAVE OF fi_accdet5 IN FRAME fr_main
DO:
    fi_accdet5 = INPUT fi_accdet5.
    DISP fi_accdet5 WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_accpric1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_accpric1 C-Win
ON LEAVE OF fi_accpric1 IN FRAME fr_main
DO:
    fi_accpric1 = INPUT fi_accpric1.
    DISP fi_accpric1 WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_accpric2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_accpric2 C-Win
ON LEAVE OF fi_accpric2 IN FRAME fr_main
DO:
    fi_accpric2 = INPUT fi_accpric2.
    DISP fi_accpric2 WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_accpric3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_accpric3 C-Win
ON LEAVE OF fi_accpric3 IN FRAME fr_main
DO:
    fi_accpric3 = INPUT fi_accpric3.
    DISP fi_accpric3 WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_accpric4
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_accpric4 C-Win
ON LEAVE OF fi_accpric4 IN FRAME fr_main
DO:
    fi_accpric4 = INPUT fi_accpric4.
    DISP fi_accpric4 WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_accpric5
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_accpric5 C-Win
ON LEAVE OF fi_accpric5 IN FRAME fr_main
DO:
    fi_accpric5 = INPUT fi_accpric5.
    DISP fi_accpric5 WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_agent
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_agent C-Win
ON LEAVE OF fi_agent IN FRAME fr_main
DO:
    fi_agent = INPUT fi_agent.
    DISP fi_agent WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_battdat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_battdat C-Win
ON LEAVE OF fi_battdat IN FRAME fr_main
DO:
    fi_battdat = INPUT fi_battdat.
    DISP fi_battdat WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_battno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_battno C-Win
ON LEAVE OF fi_battno IN FRAME fr_main
DO:
    fi_battno = INPUT fi_battno.
    DISP fi_battno WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_battpric
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_battpric C-Win
ON LEAVE OF fi_battpric IN FRAME fr_main
DO:
    fi_battpric = INPUT fi_battpric.
    DISP fi_battpric WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_battsi
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_battsi C-Win
ON LEAVE OF fi_battsi IN FRAME fr_main
DO:
    fi_battsi = INPUT fi_battsi.
    DISP fi_battsi WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_battyr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_battyr C-Win
ON LEAVE OF fi_battyr IN FRAME fr_main
DO:
    fi_battyr = INPUT fi_battyr.
    DISP fi_battyr WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_body
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_body C-Win
ON LEAVE OF fi_body IN FRAME fr_main
DO:
    fi_body = INPUT fi_body.
    DISP fi_body WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_brand
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_brand C-Win
ON LEAVE OF fi_brand IN FRAME fr_main
DO:
    fi_brand = INPUT fi_brand.
    DISP fi_brand WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_brocod
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_brocod C-Win
ON LEAVE OF fi_brocod IN FRAME fr_main
DO:
    fi_brocod = INPUT fi_brocod.
    DISP fi_brocod WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_brolincen
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_brolincen C-Win
ON LEAVE OF fi_brolincen IN FRAME fr_main
DO:
    fi_brolincen = INPUT fi_brolincen.
    DISP fi_brolincen WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_bronam
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_bronam C-Win
ON LEAVE OF fi_bronam IN FRAME fr_main
DO:
    fi_bronam = INPUT fi_bronam.
    DISP fi_bronam WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_cc
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_cc C-Win
ON LEAVE OF fi_cc IN FRAME fr_main
DO:
    fi_cc = INPUT fi_cc.
    DISP fi_cc WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_cctv
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_cctv C-Win
ON LEAVE OF fi_cctv IN FRAME fr_main
DO:
    fi_cctv = INPUT fi_cctv.
    DISP fi_cctv WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_charbrand
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_charbrand C-Win
ON LEAVE OF fi_charbrand IN FRAME fr_main
DO:
    fi_charbrand = INPUT fi_charbrand.
    DISP fi_charbrand WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_charno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_charno C-Win
ON LEAVE OF fi_charno IN FRAME fr_main
DO:
    fi_charno = INPUT fi_charno.
    DISP fi_charno WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_chssic
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_chssic C-Win
ON LEAVE OF fi_chssic IN FRAME fr_main
DO:
    fi_chssic = INPUT fi_chssic.
    DISP fi_chssic WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_class
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_class C-Win
ON LEAVE OF fi_class IN FRAME fr_main
DO:
    fi_class = INPUT fi_class.
    DISP fi_class WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_color
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_color C-Win
ON LEAVE OF fi_color IN FRAME fr_main
DO:
    fi_color = INPUT fi_color.
    DISP fi_color WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_comdat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_comdat C-Win
ON LEAVE OF fi_comdat IN FRAME fr_main
DO:
    fi_comdat = INPUT fi_comdat.
    DISP fi_comdat WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_covcod
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_covcod C-Win
ON LEAVE OF fi_covcod IN FRAME fr_main
DO:
    fi_covcod = INPUT fi_covcod.
    DISP fi_covcod WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_covtyp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_covtyp C-Win
ON LEAVE OF fi_covtyp IN FRAME fr_main
DO:
    fi_covtyp = INPUT fi_covtyp.
    DISP fi_covtyp WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_custcode
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_custcode C-Win
ON LEAVE OF fi_custcode IN FRAME fr_main
DO:
    fi_custcode = INPUT fi_custcode.
    DISP fi_custcode WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_disc
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_disc C-Win
ON LEAVE OF fi_disc IN FRAME fr_main
DO:
    fi_disc = INPUT fi_disc.
    DISP fi_disc WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_discdetail
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_discdetail C-Win
ON LEAVE OF fi_discdetail IN FRAME fr_main
DO:
    fi_discdetail = INPUT fi_discdetail.
    DISP fi_discdetail WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_dod
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_dod C-Win
ON LEAVE OF fi_dod IN FRAME fr_main
DO:
    fi_dod = INPUT fi_dod.
    DISP fi_dod WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_dridis
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_dridis C-Win
ON LEAVE OF fi_dridis IN FRAME fr_main
DO:
    fi_dridis = INPUT fi_dridis.
    DISP fi_dridis WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_engno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_engno C-Win
ON LEAVE OF fi_engno IN FRAME fr_main
DO:
    fi_engno = INPUT fi_engno.
    DISP fi_engno WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_ev1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_ev1 C-Win
ON LEAVE OF fi_ev1 IN FRAME fr_main
DO:
    fi_ev1 = INPUT fi_ev1.
    DISP fi_ev1 WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_ev2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_ev2 C-Win
ON LEAVE OF fi_ev2 IN FRAME fr_main
DO:
    fi_ev2 = INPUT fi_ev2.
    DISP fi_ev2 WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_ev3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_ev3 C-Win
ON LEAVE OF fi_ev3 IN FRAME fr_main
DO:
    fi_ev3 = INPUT fi_ev3.
    DISP fi_ev3 WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_ev4
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_ev4 C-Win
ON LEAVE OF fi_ev4 IN FRAME fr_main
DO:
    fi_ev4 = INPUT fi_ev4.
    DISP fi_ev4 WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_ev5
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_ev5 C-Win
ON LEAVE OF fi_ev5 IN FRAME fr_main
DO:
    fi_ev5 = INPUT fi_ev5.
    DISP fi_ev5 WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_evflag
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_evflag C-Win
ON LEAVE OF fi_evflag IN FRAME fr_main
DO:
    fi_evflag = CAPS(INPUT fi_evflag).
    DISP fi_evflag WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_expdat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_expdat C-Win
ON LEAVE OF fi_expdat IN FRAME fr_main
DO:
    fi_expdat = INPUT fi_expdat.
    DISP fi_expdat WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_feelt
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_feelt C-Win
ON LEAVE OF fi_feelt IN FRAME fr_main
DO:
    fi_feelt = INPUT fi_feelt.
    DISP fi_feelt WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_garcod
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_garcod C-Win
ON LEAVE OF fi_garcod IN FRAME fr_main
DO:
    fi_garcod = INPUT fi_garcod.
    DISP fi_garcod WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_inspdate
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_inspdate C-Win
ON LEAVE OF fi_inspdate IN FRAME fr_main
DO:
    fi_inspdate = INPUT fi_inspdate.
    DISP fi_inspdate WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_inspdet
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_inspdet C-Win
ON LEAVE OF fi_inspdet IN FRAME fr_main
DO:
    fi_inspdet = INPUT fi_inspdet.
    DISP fi_inspdet WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_lang
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_lang C-Win
ON LEAVE OF fi_lang IN FRAME fr_main
DO:
    fi_lang = INPUT fi_lang.
    DISP fi_lang WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_lincen
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_lincen C-Win
ON LEAVE OF fi_lincen IN FRAME fr_main
DO:
    fi_lincen = INPUT fi_lincen.
    DISP fi_lincen WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_maksi
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_maksi C-Win
ON LEAVE OF fi_maksi IN FRAME fr_main
DO:
    fi_maksi = INPUT fi_maksi.
    DISP fi_maksi WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_model
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_model C-Win
ON LEAVE OF fi_model IN FRAME fr_main
DO:
    fi_model = INPUT fi_model.
    DISP fi_model WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_ncb
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_ncb C-Win
ON LEAVE OF fi_ncb IN FRAME fr_main
DO:
    fi_ncb = INPUT fi_ncb.
    DISP fi_ncb WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_oldpol
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_oldpol C-Win
ON LEAVE OF fi_oldpol IN FRAME fr_main
DO:
    fi_oldpol = INPUT fi_oldpol.
    DISP fi_oldpol WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_othdis
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_othdis C-Win
ON LEAVE OF fi_othdis IN FRAME fr_main
DO:
    fi_othdis = INPUT fi_othdis.
    DISP fi_othdis WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_polno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_polno C-Win
ON LEAVE OF fi_polno IN FRAME fr_main
DO:
    fi_polno = INPUT fi_polno.
    DISP fi_polno WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_prem
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_prem C-Win
ON LEAVE OF fi_prem IN FRAME fr_main
DO:
    fi_prem = INPUT fi_prem.
    DISP fi_prem WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_prem1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_prem1 C-Win
ON LEAVE OF fi_prem1 IN FRAME fr_main
DO:
    fi_prem1 = INPUT fi_prem1.
    DISP fi_prem1 WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_premtotal
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_premtotal C-Win
ON LEAVE OF fi_premtotal IN FRAME fr_main
DO:
    fi_premtotal = INPUT fi_premtotal.
    DISP fi_premtotal WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_producer
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_producer C-Win
ON LEAVE OF fi_producer IN FRAME fr_main
DO:
    fi_producer = INPUT fi_Producer.
    DISP fi_producer WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_province
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_province C-Win
ON LEAVE OF fi_province IN FRAME fr_main
DO:
    fi_province = INPUT fi_province.
    DISP fi_province WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_refno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_refno C-Win
ON LEAVE OF fi_refno IN FRAME fr_main
DO:
    fi_refno = INPUT fi_refno.
    DISP fi_refno WITH FRAME fr_main.
  
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


&Scoped-define SELF-NAME fi_remarksend
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_remarksend C-Win
ON LEAVE OF fi_remarksend IN FRAME fr_main
DO:
    fi_remarksend = INPUT fi_remarksend.
    DISP fi_remarksend WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_si
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_si C-Win
ON LEAVE OF fi_si IN FRAME fr_main
DO:
    fi_si = INPUT fi_si.
    DISP fi_si WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_stamp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_stamp C-Win
ON LEAVE OF fi_stamp IN FRAME fr_main
DO:
    fi_stamp = INPUT fi_stamp.
    DISP fi_stamp WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_vat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_vat C-Win
ON LEAVE OF fi_vat IN FRAME fr_main
DO:
    fi_vat = INPUT fi_vat.
    DISP fi_vat WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_watt
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_watt C-Win
ON LEAVE OF fi_watt IN FRAME fr_main
DO:
    fi_watt = INPUT fi_watt.
    DISP fi_watt WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_year
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_year C-Win
ON LEAVE OF fi_year IN FRAME fr_main
DO:
    fi_year = INPUT fi_year.
    DISP fi_year WITH FRAME fr_main.
  
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
  
  gv_prgid = "wgwqay12".
  gv_prog  = "Query & Update Notify (AYCAL) ".
  RUN  WUT\WUTHEAD ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).

/*********************************************************************/ 
 /*  RUN Wut\WutwiCen ({&WINDOW-NAME}:HANDLE). */ 
  /*CURRENT-WINDOW:WINDOW-STATE = WINDOW-MAXIMIZED.*/
  SESSION:DATA-ENTRY-RETURN = YES.
 
  Find  brstat.tlt  Where   Recid(tlt)  =  nv_recidtlt NO-LOCK NO-ERROR NO-WAIT .
  If  avail  tlt  Then do:
      Assign
          fi_polno     = trim(brstat.tlt.policy)
          fi_poltyp    = trim(brstat.tlt.flag)
          fi_trandat   = brstat.tlt.entdat
          fi_notdat    = brstat.tlt.trndat
          fi_time      = brstat.tlt.enttim
          fi_user      = IF index(brstat.tlt.usrid,"/") <> 0 THEN SUBSTR(brstat.tlt.usrid,1,INDEX(tlt.usrid,"/") - 1) ELSE brstat.tlt.usrid
          fi_userup    = IF index(brstat.tlt.usrid,"/") <> 0 THEN SUBSTR(brstat.tlt.usrid,r-INDEX(tlt.usrid,"/") + 1) ELSE ""  /* user update */
          fi_agent     = trim(brstat.tlt.recac)
          fi_producer  = trim(brstat.tlt.subins)
          fi_refno     = trim(brstat.tlt.nor_noti_ins)
          fi_custcode  = trim(brstat.tlt.nor_usr_ins)
          fi_oldpol    = TRIM(SUBSTR(brstat.tlt.imp,R-INDEX(brstat.tlt.imp,"Pol:") + 4))     /*เบอร์กรมเดิม */
          /*-- ข้อมูลรถ --*/
          fi_brand     = trim(brstat.tlt.brand)    
          fi_model     = trim(brstat.tlt.model)    
          fi_body      = trim(brstat.tlt.expousr)  
          fi_lincen    = trim(brstat.tlt.lince1)  
          fi_province  = trim(brstat.tlt.lince2)  
          fi_chssic    = trim(brstat.tlt.cha_no)  
          fi_engno     = trim(brstat.tlt.eng_no)  
          fi_year      = trim(brstat.tlt.gentim)  
          fi_cc        = brstat.tlt.rencnt  
          fi_class     = trim(brstat.tlt.expotim)  
          fi_garcod    = trim(substr(brstat.tlt.old_cha,7 )) 
          n_char       = TRIM(brstat.tlt.rec_addr3)
          fi_covcod    = TRIM(SUBSTR(n_char,R-INDEX(n_char,"covtcd:") + 7 ))
          fi_covtyp    = TRIM(SUBSTR(n_char,8,INDEX(n_char,"covtcd:") - 8 ))
          fi_comdat    = brstat.tlt.gendat  
          fi_expdat    = brstat.tlt.expodat
          /*- ทุน เบี้ย ส่วนลด --*/
          fi_si        = brstat.tlt.nor_coamt       
          fi_prem      = brstat.tlt.nor_grprm    
          fi_prem1     = brstat.tlt.comp_grprm 
          fi_stamp     = DECI(SUBSTR(brstat.tlt.stat,5,R-INDEX(brstat.tlt.stat,"Vat:") - 5))  
          fi_vat       = DECI(SUBSTR(brstat.tlt.stat,R-INDEX(brstat.tlt.stat,"Vat:") + 4 )) 
          fi_premtotal = brstat.tlt.comp_coamt 
          fi_dod       = deci(brstat.tlt.endno)

          fi_feelt     = DECI(SUBSTR(brstat.tlt.comp_sck,R-INDEX(brstat.tlt.comp_sck,"felA:") + 5 ))           
          fi_ncb       = DECI(SUBSTR(brstat.tlt.comp_noti_tlt,R-INDEX(brstat.tlt.comp_noti_tlt,"ncbA:") + 5 )) 
          fi_dridis    = DECI(SUBSTR(brstat.tlt.comp_usr_tlt,R-INDEX(brstat.tlt.comp_usr_tlt,"DriA:") + 5 ))   
          fi_othdis    = DECI(SUBSTR(brstat.tlt.comp_noti_ins,R-INDEX(brstat.tlt.comp_noti_ins,"OthA:") + 5 )) 
          fi_cctv      = DECI(SUBSTR(brstat.tlt.comp_usr_ins,R-INDEX(brstat.tlt.comp_usr_ins,"ctvA:") + 5 ))   
          fi_discdetail= trim(SUBSTR(brstat.tlt.comp_pol,R-INDEX(brstat.tlt.comp_pol,"Surd:") + 5 ))           
          n_char       = TRIM(SUBSTR(brstat.tlt.comp_pol,1,R-INDEX(brstat.tlt.comp_pol,"surd:") - 2 ))         
          fi_disc      = DECI(SUBSTR(n_char,R-INDEX(n_char,"SurA:") + 5 )) 
          fi_color     = brstat.tlt.note1  .  /*A66-0160*/

          RUN proc_assignfi .

     DISP fi_polno     fi_poltyp     fi_trandat    fi_user       fi_time  
          fi_brand     fi_model      fi_body       fi_lincen     fi_province       
          fi_engno     fi_year       fi_cc         fi_class      fi_chssic 
          fi_garcod    fi_covtyp     fi_covcod                   
          fi_si        fi_prem       fi_lang       fi_discdetail fi_refno      
          fi_custcode  fi_inspdet    fi_brolincen  fi_brocod     fi_bronam     
          fi_producer  fi_agent      fi_prem1      fi_stamp      
          fi_vat       fi_premtotal  fi_dod        fi_feelt      
          fi_ncb       fi_dridis     fi_othdis                   
          fi_cctv      fi_disc       fi_accdet1    fi_accpric1   
          fi_accdet2   fi_accpric2   fi_accdet3    fi_accpric3   fi_color
          fi_accdet4   fi_accpric4   fi_accdet5    fi_accpric5   fi_comdat     
          fi_expdat    fi_inspdate   fi_remarksend  
          fi_remark    fi_oldpol     fi_notdat     fi_userup 
          /* Add by : A67-0162 */
          fi_watt      fi_ev3        fi_battyr     fi_battsi       
          fi_maksi     fi_ev4        fi_battdat    fi_charno      
          fi_ev1       fi_ev5        fi_battpric   fi_charbrand   
          fi_ev2       fi_evflag     fi_battno 
          /* end : A67-0162 */
          bu_detail1   bu_save       bu_exit WITH frame  fr_main. 
          bu_detail2:BGCOLOR = 19.
          bu_detail2:FGCOLOR = 6. 
          /*DISABLE bu_detail2 WITH FRAME fr_main.*/

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
  DISPLAY fi_brand fi_model fi_body fi_lincen fi_province fi_chssic fi_engno 
          fi_year fi_cc fi_class fi_garcod fi_covtyp fi_covcod fi_si fi_prem 
          fi_lang fi_discdetail fi_refno fi_custcode fi_inspdet fi_brolincen 
          fi_brocod fi_bronam fi_producer fi_agent fi_prem1 fi_stamp fi_vat 
          fi_premtotal fi_dod fi_feelt fi_ncb fi_dridis fi_othdis fi_cctv 
          fi_disc fi_accdet1 fi_accpric1 fi_accdet2 fi_accpric2 fi_accdet3 
          fi_accpric3 fi_accdet4 fi_accpric4 fi_comdat fi_expdat fi_inspdate 
          fi_remarksend fi_remark fi_polno fi_poltyp fi_trandat fi_user fi_time 
          fi_userup fi_notdat fi_oldpol fi_color fi_maksi fi_watt fi_ev1 fi_ev2 
          fi_ev3 fi_ev4 fi_ev5 fi_evflag fi_battyr fi_battdat fi_battpric 
          fi_battno fi_battsi fi_charno fi_charbrand fi_accdet5 fi_accpric5 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE bu_save bu_exit bu_detail2 bu_detail1 fi_brand fi_model fi_body 
         fi_lincen fi_province fi_chssic fi_engno fi_year fi_cc fi_class 
         fi_garcod fi_covtyp fi_covcod fi_si fi_prem fi_lang fi_discdetail 
         fi_refno fi_custcode fi_inspdet fi_brolincen fi_brocod fi_bronam 
         fi_producer fi_agent fi_prem1 fi_stamp fi_vat fi_premtotal fi_dod 
         fi_feelt fi_ncb fi_dridis fi_othdis fi_cctv fi_disc fi_accdet1 
         fi_accpric1 fi_accdet2 fi_accpric2 fi_accdet3 fi_accpric3 fi_accdet4 
         fi_accpric4 fi_comdat fi_expdat fi_inspdate fi_remarksend fi_remark 
         fi_polno fi_poltyp fi_trandat fi_user fi_time fi_userup fi_notdat 
         fi_oldpol fi_color fi_maksi fi_watt fi_ev1 fi_ev2 fi_ev3 fi_ev4 fi_ev5 
         fi_evflag fi_battyr fi_battdat fi_battpric fi_battno fi_battsi 
         fi_charno fi_charbrand fi_accdet5 fi_accpric5 RECT-335 RECT-465 
         RECT-468 RECT-503 
      WITH FRAME fr_main IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assignfi C-Win 
PROCEDURE proc_assignfi :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO:
    ASSIGN 
        /*-- อุปกรณ์ตกแต่ง ---*/
        fi_accpric5  = INT(substr(brstat.tlt.filler1,R-INDEX(brstat.tlt.filler1,"Acp5:") + 5))
        n_char       = TRIM(SUBSTR(brstat.tlt.filler1,1,R-INDEX(brstat.tlt.filler1,"Acp5:") - 2 ))
        fi_accdet5   = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Acd5:") + 5 ))
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acd5:") - 2))
        fi_accpric4  = INT(SUBSTR(n_char,R-INDEX(n_char,"Acp4:") + 5 ))
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acp4:") - 2 ))
        fi_accdet4   = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Acd4:") + 5 ))
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acd4:") - 2 ))
        fi_accpric3  = INT(SUBSTR(n_char,R-INDEX(n_char,"Acp3:") + 5 )) 
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acp3:") - 2 ))
        fi_accdet3   = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Acd3:") + 5 )) 
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acd3:") - 2 )) 
        fi_accpric2  = INT(SUBSTR(n_char,R-INDEX(n_char,"Acp2:") + 5 )) 
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acp2:") - 2 ))
        fi_accdet2   = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Acd2:") + 5 )) 
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acd2:") - 2 ))
        fi_accpric1  = INT(SUBSTR(n_char,R-INDEX(n_char,"Acp1:") + 5 )) 
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acp1:") - 2 ))  
        fi_accdet1   = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Acd1:") + 5 )) 
        fi_inspdate  = brstat.tlt.nor_effdat   
        fi_inspdet   = TRIM(SUBSTR(brstat.tlt.nor_noti_tlt,R-INDEX(brstat.tlt.nor_noti_tlt,"InspDe:") + 7 ))
        fi_brocod    = TRIM(SUBSTR(brstat.tlt.old_eng,R-INDEX(brstat.tlt.old_eng,"Bloca:") + 6 ))    /* Car Inspection Phone            */
        n_char       = TRIM(SUBSTR(brstat.tlt.old_eng,1,R-INDEX(brstat.tlt.old_eng,"Bloca:") - 2 ))  
        fi_bronam    = TRIM(SUBSTR(n_char,R-INDEX(n_char,"bname:") + 6 ))                            /* Car Inspection Name             */                                   
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"bname:") - 2 ))                          
        fi_brolincen = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Bphon:") + 6 ))                            /* Car Inspection Location         */

        fi_remark    = TRIM(SUBSTR(brstat.tlt.filler2,R-INDEX(brstat.tlt.filler2,"Remark:") + 7 ))
        n_char       = TRIM(SUBSTR(brstat.tlt.filler2,1,R-INDEX(brstat.tlt.filler2,"Remark:") - 2 ))
        fi_remarksend = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Detai3:") + 7 ))
        fi_lang      = TRIM(brstat.tlt.exp)

        /* Add by : A67-0162 */
        fi_watt      = brstat.tlt.watts         
        fi_maksi     = brstat.tlt.maksi         
        fi_ev1       = trim(brstat.tlt.note4)           
        fi_ev2       = trim(brstat.tlt.note5)           
        fi_ev3       = trim(brstat.tlt.note6)           
        fi_ev4       = trim(brstat.tlt.note7)           
        fi_ev5       = trim(brstat.tlt.note8)           
        fi_evflag    = CAPS(string(brstat.tlt.battflg))         
        fi_battyr    = brstat.tlt.battyr                
        fi_battdat   = brstat.tlt.ndate1                
        fi_battpric  = brstat.tlt.battprice     
        fi_battno    = trim(brstat.tlt.battno)          
        fi_battsi    = brstat.tlt.battsi        
        fi_charno    = trim(brstat.tlt.chargno)         
        fi_charbrand = trim(brstat.tlt.note19).   
       /* end : A67-0162 */

END.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assignfi-bp C-Win 
PROCEDURE proc_assignfi-bp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*DO:
    ASSIGN 
        /*-- อุปกรณ์ตกแต่ง ---*/
        fi_accpric5  = INT(substr(brstat.tlt.filler1,R-INDEX(brstat.tlt.filler1,"Acp5:") + 5))
        n_char       = TRIM(SUBSTR(brstat.tlt.filler1,1,R-INDEX(brstat.tlt.filler1,"Acp5:") - 2 ))
        fi_accdet5   = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Acd5:") + 5 ))
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acd5:") - 2))
        /*fi_accr5     = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Acc5:") + 5 ))
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acc5:") - 2 ))*/
        fi_accpric4  = INT(SUBSTR(n_char,R-INDEX(n_char,"Acp4:") + 5 ))
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acp4:") - 2 ))
        fi_accdet4   = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Acd4:") + 5 ))
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acd4:") - 2 ))
        /*fi_accr4     = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Acc4:") + 5 ))
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acc4:") - 2 ))*/
        fi_accpric3  = INT(SUBSTR(n_char,R-INDEX(n_char,"Acp3:") + 5 )) 
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acp3:") - 2 ))
        fi_accdet3   = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Acd3:") + 5 )) 
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acd3:") - 2 )) 
        /*fi_accr3     = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Acc3:") + 5 )) 
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acc3:") - 2 ))*/
        fi_accpric2  = INT(SUBSTR(n_char,R-INDEX(n_char,"Acp2:") + 5 )) 
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acp2:") - 2 ))
        fi_accdet2   = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Acd2:") + 5 )) 
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acd2:") - 2 ))
        /*fi_accr2     = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Acc2:") + 5 )) 
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acc2:") - 2 ))*/
        fi_accpric1  = INT(SUBSTR(n_char,R-INDEX(n_char,"Acp1:") + 5 )) 
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acp1:") - 2 ))  
        fi_accdet1   = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Acd1:") + 5 )) 
        /*n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acd1:") - 2 ))
        fi_accr1     = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Acc1:") + 5 ))*/
        fi_inspdate  = brstat.tlt.nor_effdat   
        /*fi_appdate   = brstat.tlt.comp_effdat */
        fi_inspres   = TRIM(SUBSTR(brstat.tlt.nor_noti_tlt,8,R-INDEX(brstat.tlt.nor_noti_tlt,"Inspde:") - 8))
        /*fi_inspdet   = TRIM(SUBSTR(brstat.tlt.nor_noti_tlt,R-INDEX(brstat.tlt.nor_noti_tlt,"Inspde:") + 7))*/
       /* fi_brocod    = TRIM(SUBSTR(brstat.tlt.old_eng,R-INDEX(brstat.tlt.old_eng,"Bcode:") + 6 ))
        n_char       = TRIM(SUBSTR(brstat.tlt.old_eng,1,R-INDEX(brstat.tlt.old_eng,"Bcode:") - 2 ))
        fi_bronam    = TRIM(SUBSTR(n_char,R-INDEX(n_char,"bname:") + 6 ))
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"bname:") - 2 ))
        fi_brolincen = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Blice:") + 6 ))*/

        fi_brocod    = TRIM(SUBSTR(brstat.tlt.old_eng,R-INDEX(brstat.tlt.old_eng,"Bloca:") + 6 ))    /* Car Inspection Phone            */
        n_char       = TRIM(SUBSTR(brstat.tlt.old_eng,1,R-INDEX(brstat.tlt.old_eng,"Bloca:") - 2 ))  
        fi_bronam    = TRIM(SUBSTR(n_char,R-INDEX(n_char,"bname:") + 6 ))                            /* Car Inspection Name             */                                   
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"bname:") - 2 ))                          
        fi_brolincen = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Bphon:") + 6 ))                            /* Car Inspection Location         */

        fi_remark    = TRIM(SUBSTR(brstat.tlt.filler2,R-INDEX(brstat.tlt.filler2,"Remark:") + 7 ))
        n_char       = TRIM(SUBSTR(brstat.tlt.filler2,1,R-INDEX(brstat.tlt.filler2,"Remark:") - 2 ))
        /*fi_gift      = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Detai4:") + 7 ))
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Detai4:") - 2 ))*/
        fi_remarksend = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Detai3:") + 7 ))
        /*n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"detai3:") - 2 ))
        fi_polsend   = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Detai2:") + 7 ))
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"detai2:") - 2 ))
        fi_lang      = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Detai1:") + 7 ))*/ 
        fi_lang      = TRIM(brstat.tlt.exp).
END.*/


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

