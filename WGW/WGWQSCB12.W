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
 Program ID   : wgwqscb12.w
 Program Name : Quey & Update data notify Add in table  tlt  
 Create  by   : Ranu I. A60-0448 Date 16/10/2017
                แสดงข้อมูล และแก้ไขรายละเอียดการแจ้งงาน 
**************************************************************************
 Modify By    : Tontawan S. A66-0006 10/05/2023
              : ขยาย Format ช่อง น้ำหนัก
              : แก่ไขการแสดงข้อมูลของช่อง การซ่อม และรหัสการซ่อมให้ถูกต้อง
**************************************************************************/
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
fi_seat fi_cc fi_ton fi_class fi_garcod fi_garage fi_color fi_covtyp ~
fi_covcod fi_covdetail fi_si fi_prem fi_lang fi_discdetail fi_accr1 ~
fi_refno fi_custcode fi_inspres fi_inspdet fi_brolincen fi_brocod fi_bronam ~
fi_producer fi_agent fi_cover fi_subcover fi_prem1 fi_stamp fi_vat ~
fi_premtotal fi_dod fi_feeltp fi_feelt fi_ncbp fi_ncb fi_drip fi_dridis ~
fi_oth fi_othdis fi_cctvp fi_cctv fi_discp fi_disc fi_accdet1 fi_accpric1 ~
fi_accr2 fi_accdet2 fi_accpric2 fi_accr3 fi_accdet3 fi_accpric3 fi_accr4 ~
fi_accdet4 fi_accpric4 fi_accr5 fi_accdet5 fi_accpric5 fi_comdat fi_expdat ~
fi_inspdate fi_appdate fi_polsend fi_remarksend fi_gift fi_remark fi_polno ~
fi_poltyp fi_trandat fi_user fi_time RECT-335 RECT-465 RECT-468 
&Scoped-Define DISPLAYED-OBJECTS fi_brand fi_model fi_body fi_lincen ~
fi_province fi_chssic fi_engno fi_year fi_seat fi_cc fi_ton fi_class ~
fi_garcod fi_garage fi_color fi_covtyp fi_covcod fi_covdetail fi_si fi_prem ~
fi_lang fi_discdetail fi_accr1 fi_refno fi_custcode fi_inspres fi_inspdet ~
fi_brolincen fi_brocod fi_bronam fi_producer fi_agent fi_cover fi_subcover ~
fi_prem1 fi_stamp fi_vat fi_premtotal fi_dod fi_feeltp fi_feelt fi_ncbp ~
fi_ncb fi_drip fi_dridis fi_oth fi_othdis fi_cctvp fi_cctv fi_discp fi_disc ~
fi_accdet1 fi_accpric1 fi_accr2 fi_accdet2 fi_accpric2 fi_accr3 fi_accdet3 ~
fi_accpric3 fi_accr4 fi_accdet4 fi_accpric4 fi_accr5 fi_accdet5 fi_accpric5 ~
fi_comdat fi_expdat fi_inspdate fi_appdate fi_polsend fi_remarksend fi_gift ~
fi_remark fi_polno fi_poltyp fi_trandat fi_user fi_time 

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
     SIZE 28 BY 1
     BGCOLOR 10 FGCOLOR 1 FONT 6.

DEFINE BUTTON bu_detail2 
     LABEL "ข้อมูลรถและความคุ้มครอง" 
     SIZE 26.67 BY 1
     BGCOLOR 10 FGCOLOR 0 FONT 6.

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
     SIZE 38.67 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_accdet2 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 38.67 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_accdet3 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 38.67 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_accdet4 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 38.67 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_accdet5 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 38.67 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_accpric1 AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 17.83 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_accpric2 AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 17.83 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_accpric3 AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 17.83 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_accpric4 AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 17.83 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_accpric5 AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 17.83 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_accr1 AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 39.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_accr2 AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 39.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_accr3 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 39.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_accr4 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 39.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_accr5 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 39.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_agent AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 17.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_appdate AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 13.33 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_body AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 24.83 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_brand AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 14.83 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_brocod AS CHARACTER FORMAT "X(12)":U 
     VIEW-AS FILL-IN 
     SIZE 19.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_brolincen AS CHARACTER FORMAT "X(13)":U 
     VIEW-AS FILL-IN 
     SIZE 17.33 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_bronam AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 35.17 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_cc AS INTEGER FORMAT ">>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 8.33 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_cctv AS DECIMAL FORMAT "->>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 11.33 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_cctvp AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 5.83 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_chssic AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 26.17 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_class AS CHARACTER FORMAT "X(5)":U 
     VIEW-AS FILL-IN 
     SIZE 7.67 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_color AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_comdat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 15.17 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_covcod AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 13.83 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_covdetail AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 31.17 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_cover AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 19.17 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_covtyp AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 26 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_custcode AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 23.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_disc AS DECIMAL FORMAT "->>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 11 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_discdetail AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 53.17 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_discp AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 5.83 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_dod AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 13.17 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_dridis AS DECIMAL FORMAT "->>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 10.67 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_drip AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 5.83 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_engno AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 24.67 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_expdat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 16.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_feelt AS DECIMAL FORMAT "->>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 11.33 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_feeltp AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 5.83 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_garage AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_garcod AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_gift AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 30.17 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_inspdate AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 12.83 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_inspdet AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 40.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_inspres AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 18.17 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_lang AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_lincen AS CHARACTER FORMAT "X(12)":U 
     VIEW-AS FILL-IN 
     SIZE 15.67 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_model AS CHARACTER FORMAT "X(60)":U 
     VIEW-AS FILL-IN 
     SIZE 28 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_ncb AS DECIMAL FORMAT "->>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 11 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_ncbp AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 5.83 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_oth AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 5.83 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_othdis AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 11 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_polno AS CHARACTER FORMAT "X(13)":U 
     VIEW-AS FILL-IN 
     SIZE 17.83 BY 1
     BGCOLOR 10 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_polsend AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 23.17 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_poltyp AS CHARACTER FORMAT "X(3)":U 
     VIEW-AS FILL-IN 
     SIZE 6.17 BY 1
     BGCOLOR 10 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_prem AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_prem1 AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 13.67 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_premtotal AS DECIMAL FORMAT "->,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 15.33 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_producer AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 14.67 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_province AS CHARACTER FORMAT "X(35)":U 
     VIEW-AS FILL-IN 
     SIZE 14.67 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_refno AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 23.67 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_remark AS CHARACTER FORMAT "X(150)":U 
     VIEW-AS FILL-IN 
     SIZE 115.83 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_remarksend AS CHARACTER FORMAT "X(80)":U 
     VIEW-AS FILL-IN 
     SIZE 40.33 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_seat AS INTEGER FORMAT ">9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_si AS INTEGER FORMAT "->>,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 18.17 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_stamp AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 8.17 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_subcover AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 20.33 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_time AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 13.67 BY 1
     BGCOLOR 10 FGCOLOR 6  NO-UNDO.

DEFINE VARIABLE fi_ton AS DECIMAL FORMAT ">>>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 10.83 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_trandat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 13.67 BY 1
     BGCOLOR 10 FGCOLOR 6  NO-UNDO.

DEFINE VARIABLE fi_user AS CHARACTER FORMAT "X(13)":U 
     VIEW-AS FILL-IN 
     SIZE 10.17 BY 1
     BGCOLOR 7 FGCOLOR 4 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_vat AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 11.33 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_year AS CHARACTER FORMAT "X(5)":U 
     VIEW-AS FILL-IN 
     SIZE 12 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE RECTANGLE RECT-335
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132.5 BY 24.76
     BGCOLOR 19 FGCOLOR 0 .

DEFINE RECTANGLE RECT-465
     EDGE-PIXELS 2 GRAPHIC-EDGE    ROUNDED 
     SIZE 130.5 BY 16.05
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-468
     EDGE-PIXELS 2 GRAPHIC-EDGE    ROUNDED 
     SIZE 130.5 BY 5.57
     BGCOLOR 19 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     bu_save AT ROW 25.57 COL 113.67
     bu_exit AT ROW 25.57 COL 124.5
     bu_detail2 AT ROW 1.1 COL 29.83
     bu_detail1 AT ROW 1.1 COL 1.67
     fi_brand AT ROW 4.76 COL 14.33 COLON-ALIGNED NO-LABEL
     fi_model AT ROW 4.76 COL 37.33 COLON-ALIGNED NO-LABEL
     fi_body AT ROW 4.76 COL 76.5 COLON-ALIGNED NO-LABEL
     fi_lincen AT ROW 4.76 COL 113.83 COLON-ALIGNED NO-LABEL
     fi_province AT ROW 5.86 COL 14.33 COLON-ALIGNED NO-LABEL
     fi_chssic AT ROW 5.86 COL 39.5 COLON-ALIGNED NO-LABEL
     fi_engno AT ROW 5.91 COL 76.5 COLON-ALIGNED NO-LABEL
     fi_year AT ROW 5.91 COL 114.17 COLON-ALIGNED NO-LABEL
     fi_seat AT ROW 7.05 COL 14.17 COLON-ALIGNED NO-LABEL
     fi_cc AT ROW 7.05 COL 24.17 COLON-ALIGNED NO-LABEL
     fi_ton AT ROW 7.05 COL 40.67 COLON-ALIGNED NO-LABEL
     fi_class AT ROW 7.05 COL 58.17 COLON-ALIGNED NO-LABEL
     fi_garcod AT ROW 6.95 COL 78 COLON-ALIGNED NO-LABEL
     fi_garage AT ROW 6.95 COL 91.83 COLON-ALIGNED NO-LABEL
     fi_color AT ROW 7 COL 115.5 COLON-ALIGNED NO-LABEL
     fi_covtyp AT ROW 8.14 COL 14 COLON-ALIGNED NO-LABEL
     fi_covcod AT ROW 8.14 COL 50.83 COLON-ALIGNED NO-LABEL
     fi_covdetail AT ROW 9.29 COL 14 COLON-ALIGNED NO-LABEL
     fi_si AT ROW 9.24 COL 111.33 COLON-ALIGNED NO-LABEL
     fi_prem AT ROW 10.43 COL 14 COLON-ALIGNED NO-LABEL
     fi_lang AT ROW 21.71 COL 115 COLON-ALIGNED NO-LABEL
     fi_discdetail AT ROW 12.67 COL 76.33 COLON-ALIGNED NO-LABEL
     fi_accr1 AT ROW 13.76 COL 14.33 COLON-ALIGNED NO-LABEL
     fi_refno AT ROW 3.57 COL 70.33 COLON-ALIGNED NO-LABEL
     fi_custcode AT ROW 3.57 COL 106.17 COLON-ALIGNED NO-LABEL
     fi_inspres AT ROW 20.57 COL 61.17 COLON-ALIGNED NO-LABEL
     fi_inspdet AT ROW 20.57 COL 89.5 COLON-ALIGNED NO-LABEL
     fi_brolincen AT ROW 21.71 COL 14.17 COLON-ALIGNED NO-LABEL
     fi_brocod AT ROW 21.67 COL 89.5 COLON-ALIGNED NO-LABEL
     fi_bronam AT ROW 21.71 COL 42.5 COLON-ALIGNED NO-LABEL
     fi_producer AT ROW 3.62 COL 14.5 COLON-ALIGNED NO-LABEL
     fi_agent AT ROW 3.62 COL 38.33 COLON-ALIGNED NO-LABEL
     fi_cover AT ROW 8.14 COL 77.17 COLON-ALIGNED NO-LABEL
     fi_subcover AT ROW 8.05 COL 109 COLON-ALIGNED NO-LABEL
     fi_prem1 AT ROW 10.43 COL 40.67 COLON-ALIGNED NO-LABEL
     fi_stamp AT ROW 10.43 COL 62.83 COLON-ALIGNED NO-LABEL
     fi_vat AT ROW 10.43 COL 76.5 COLON-ALIGNED NO-LABEL
     fi_premtotal AT ROW 10.43 COL 96 COLON-ALIGNED NO-LABEL
     fi_dod AT ROW 10.43 COL 116.33 COLON-ALIGNED NO-LABEL
     fi_feeltp AT ROW 11.52 COL 14.17 COLON-ALIGNED NO-LABEL
     fi_feelt AT ROW 11.52 COL 22.5 COLON-ALIGNED NO-LABEL
     fi_ncbp AT ROW 11.48 COL 47.83 COLON-ALIGNED NO-LABEL
     fi_ncb AT ROW 11.48 COL 56.5 COLON-ALIGNED NO-LABEL
     fi_drip AT ROW 11.48 COL 79.5 COLON-ALIGNED NO-LABEL
     fi_dridis AT ROW 11.48 COL 88.5 COLON-ALIGNED NO-LABEL
     fi_oth AT ROW 11.52 COL 109.83 COLON-ALIGNED NO-LABEL
     fi_othdis AT ROW 11.52 COL 118.5 COLON-ALIGNED NO-LABEL
     fi_cctvp AT ROW 12.62 COL 14.33 COLON-ALIGNED NO-LABEL
     fi_cctv AT ROW 12.62 COL 22.5 COLON-ALIGNED NO-LABEL
     fi_discp AT ROW 12.62 COL 44.83 COLON-ALIGNED NO-LABEL
     fi_disc AT ROW 12.62 COL 53.5 COLON-ALIGNED NO-LABEL
     fi_accdet1 AT ROW 13.76 COL 66.17 COLON-ALIGNED NO-LABEL
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133.67 BY 25.95
         BGCOLOR 30 FGCOLOR 1 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     fi_accpric1 AT ROW 13.76 COL 112 COLON-ALIGNED NO-LABEL
     fi_accr2 AT ROW 14.86 COL 14.33 COLON-ALIGNED NO-LABEL
     fi_accdet2 AT ROW 14.86 COL 66.17 COLON-ALIGNED NO-LABEL
     fi_accpric2 AT ROW 14.86 COL 112 COLON-ALIGNED NO-LABEL
     fi_accr3 AT ROW 15.95 COL 14.33 COLON-ALIGNED NO-LABEL
     fi_accdet3 AT ROW 15.95 COL 66.17 COLON-ALIGNED NO-LABEL
     fi_accpric3 AT ROW 15.95 COL 112 COLON-ALIGNED NO-LABEL
     fi_accr4 AT ROW 17.05 COL 14.33 COLON-ALIGNED NO-LABEL
     fi_accdet4 AT ROW 17.05 COL 66.17 COLON-ALIGNED NO-LABEL
     fi_accpric4 AT ROW 17.05 COL 112 COLON-ALIGNED NO-LABEL
     fi_accr5 AT ROW 18.14 COL 14.33 COLON-ALIGNED NO-LABEL
     fi_accdet5 AT ROW 18.14 COL 66.17 COLON-ALIGNED NO-LABEL
     fi_accpric5 AT ROW 18.14 COL 112 COLON-ALIGNED NO-LABEL
     fi_comdat AT ROW 9.29 COL 55.83 COLON-ALIGNED NO-LABEL
     fi_expdat AT ROW 9.29 COL 84.33 COLON-ALIGNED NO-LABEL
     fi_inspdate AT ROW 20.57 COL 14.17 COLON-ALIGNED NO-LABEL
     fi_appdate AT ROW 20.57 COL 36.67 COLON-ALIGNED NO-LABEL
     fi_polsend AT ROW 22.91 COL 13.83 COLON-ALIGNED NO-LABEL
     fi_remarksend AT ROW 22.91 COL 51.17 COLON-ALIGNED NO-LABEL
     fi_gift AT ROW 22.91 COL 99.83 COLON-ALIGNED NO-LABEL
     fi_remark AT ROW 24.05 COL 14.17 COLON-ALIGNED NO-LABEL
     fi_polno AT ROW 2.24 COL 44 COLON-ALIGNED NO-LABEL
     fi_poltyp AT ROW 2.24 COL 62.17 COLON-ALIGNED NO-LABEL
     fi_trandat AT ROW 2.19 COL 82.17 COLON-ALIGNED NO-LABEL
     fi_user AT ROW 2.19 COL 120.5 COLON-ALIGNED NO-LABEL
     fi_time AT ROW 2.19 COL 101 COLON-ALIGNED NO-LABEL
     "รายละเอียด:" VIEW-AS TEXT
          SIZE 10 BY .91 AT ROW 12.67 COL 68
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "รุ่นรถ:" VIEW-AS TEXT
          SIZE 6 BY .91 AT ROW 4.81 COL 32.67
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "เบี้ยรวม:" VIEW-AS TEXT
          SIZE 6.83 BY .91 AT ROW 10.52 COL 90.5
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "ประเภทประกัน:" VIEW-AS TEXT
          SIZE 12.5 BY .91 AT ROW 8.24 COL 3.33
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "รายละเอียด :" VIEW-AS TEXT
          SIZE 10 BY .91 AT ROW 9.38 COL 5.33
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "วันที่หมดอายุ:" VIEW-AS TEXT
          SIZE 11.5 BY .91 AT ROW 9.33 COL 74.83
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "วันที่ตรวจสภาพ:" VIEW-AS TEXT
          SIZE 12.5 BY .91 AT ROW 20.67 COL 3.17
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "การซ่อม:" VIEW-AS TEXT
          SIZE 7.83 BY .91 AT ROW 7 COL 85.67
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "การจัดส่ง:" VIEW-AS TEXT
          SIZE 7.5 BY .91 AT ROW 22.95 COL 8
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "  ข้อมูลรถและความคุ้มครอง" VIEW-AS TEXT
          SIZE 24.17 BY .91 AT ROW 2.57 COL 3.67
          BGCOLOR 19 FGCOLOR 6 FONT 6
     "%" VIEW-AS TEXT
          SIZE 2 BY .91 AT ROW 11.48 COL 56.67
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "Policy No :" VIEW-AS TEXT
          SIZE 10.5 BY .91 AT ROW 2.29 COL 35.33
          BGCOLOR 19 FGCOLOR 4 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133.67 BY 25.95
         BGCOLOR 30 FGCOLOR 1 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "ความคุ้มครอง:" VIEW-AS TEXT
          SIZE 11.5 BY .91 AT ROW 8.19 COL 67.33
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "วันที่อนุมัติ:" VIEW-AS TEXT
          SIZE 9 BY .91 AT ROW 20.62 COL 29.5
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "  ข้อมูลตรวจสภาพและอื่นๆ" VIEW-AS TEXT
          SIZE 24.17 BY .91 AT ROW 19.57 COL 3.67
          BGCOLOR 19 FGCOLOR 6 FONT 6
     "เลขที่อ้างอิง:" VIEW-AS TEXT
          SIZE 11.33 BY .91 AT ROW 3.67 COL 60.5
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "เบี้ยสุทธิก่อนลด:" VIEW-AS TEXT
          SIZE 12.83 BY .91 AT ROW 10.52 COL 3
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "สีรถ :" VIEW-AS TEXT
          SIZE 4.5 BY .91 AT ROW 7.05 COL 112.83
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "ส่วนลดอื่นๆ:" VIEW-AS TEXT
          SIZE 10 BY .91 AT ROW 11.57 COL 101.83
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "VAT:" VIEW-AS TEXT
          SIZE 4.5 BY .91 AT ROW 10.48 COL 73.5
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "รหัสนายหน้า:" VIEW-AS TEXT
          SIZE 10.5 BY .91 AT ROW 21.71 COL 80.5
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "ผลการตรวจ:" VIEW-AS TEXT
          SIZE 10.5 BY .91 AT ROW 20.62 COL 52.67
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "หมายเหตุการส่ง:" VIEW-AS TEXT
          SIZE 13 BY .91 AT ROW 22.95 COL 40
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "เบี้ยสุทธิหลังลด:" VIEW-AS TEXT
          SIZE 12.33 BY .91 AT ROW 10.52 COL 30.33
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "ทุนประกัน:" VIEW-AS TEXT
          SIZE 8.83 BY .91 AT ROW 9.29 COL 104
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "ส่วนลดเพิ่ม:" VIEW-AS TEXT
          SIZE 9.5 BY .91 AT ROW 12.67 COL 37
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "ส่วนลดประวัติดี:" VIEW-AS TEXT
          SIZE 13 BY .91 AT ROW 11.52 COL 36.67
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "Producer :" VIEW-AS TEXT
          SIZE 10.83 BY .91 AT ROW 3.67 COL 5.17
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "  ข้อมูลรถและความคุ้มครอง" VIEW-AS TEXT
          SIZE 22 BY .91 AT ROW 1.14 COL 111.17
          FGCOLOR 15 FONT 1
     "ส่วนลดกลุ่ม:" VIEW-AS TEXT
          SIZE 10 BY .91 AT ROW 11.57 COL 6
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "คุ้มครองย่อย :" VIEW-AS TEXT
          SIZE 11 BY .91 AT ROW 8.14 COL 99.83
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "หมายเหตุ:" VIEW-AS TEXT
          SIZE 8.5 BY .91 AT ROW 24.1 COL 7.5
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "%" VIEW-AS TEXT
          SIZE 2 BY .91 AT ROW 11.48 COL 88.33
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "ชื่อนายหน้า:" VIEW-AS TEXT
          SIZE 10 BY .91 AT ROW 21.76 COL 34.17
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "Agent :" VIEW-AS TEXT
          SIZE 7.67 BY .91 AT ROW 3.67 COL 32
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "ส่วนลดผู้ขับขี่:" VIEW-AS TEXT
          SIZE 11.17 BY .91 AT ROW 11.52 COL 70.17
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "DOD:" VIEW-AS TEXT
          SIZE 4.5 BY .91 AT ROW 10.48 COL 113.5
          BGCOLOR 19 FGCOLOR 2 FONT 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133.67 BY 25.95
         BGCOLOR 30 FGCOLOR 1 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "ราคา2:" VIEW-AS TEXT
          SIZE 5.5 BY .91 AT ROW 14.91 COL 108.33
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "%" VIEW-AS TEXT
          SIZE 2 BY .91 AT ROW 12.62 COL 22.33
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "เลขเครื่อง:" VIEW-AS TEXT
          SIZE 8.33 BY .91 AT ROW 5.95 COL 68.83
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "ส่วนลด CCTV:" VIEW-AS TEXT
          SIZE 11.67 BY .91 AT ROW 12.67 COL 4.33
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "ของแถม:" VIEW-AS TEXT
          SIZE 7.5 BY .91 AT ROW 22.95 COL 94
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "ราคา3:" VIEW-AS TEXT
          SIZE 5.5 BY .91 AT ROW 16 COL 108.33
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "ราคา1:" VIEW-AS TEXT
          SIZE 5.5 BY .91 AT ROW 13.81 COL 108.33
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "รหัสการซ่อม :" VIEW-AS TEXT
          SIZE 10.5 BY .91 AT ROW 7 COL 69
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "รายละเอียด1:" VIEW-AS TEXT
          SIZE 10.67 BY .91 AT ROW 13.81 COL 57.33
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "%" VIEW-AS TEXT
          SIZE 2 BY .91 AT ROW 11.52 COL 118.5
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "ราคา4:" VIEW-AS TEXT
          SIZE 5.5 BY .91 AT ROW 17.1 COL 108.33
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "รายละเอียด2:" VIEW-AS TEXT
          SIZE 10.67 BY .91 AT ROW 14.91 COL 57.33
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "อุปกรณ์เสริม2:" VIEW-AS TEXT
          SIZE 11.5 BY .91 AT ROW 14.91 COL 4.33
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "%" VIEW-AS TEXT
          SIZE 2 BY .91 AT ROW 12.62 COL 53.33
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "รายละเอียด:" VIEW-AS TEXT
          SIZE 9.83 BY .91 AT ROW 20.62 COL 81.5
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "รายละเอียด3:" VIEW-AS TEXT
          SIZE 10.67 BY .91 AT ROW 16.05 COL 57.33
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "อุปกรณ์เสริม3:" VIEW-AS TEXT
          SIZE 11.5 BY .91 AT ROW 16 COL 4.33
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "User:" VIEW-AS TEXT
          SIZE 5.33 BY .91 AT ROW 2.24 COL 117.17
          BGCOLOR 19 FGCOLOR 6 FONT 1
     "ราคา5:" VIEW-AS TEXT
          SIZE 5.5 BY .91 AT ROW 18.19 COL 108.33
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "รายละเอียด4:" VIEW-AS TEXT
          SIZE 10.67 BY .91 AT ROW 17.1 COL 57.33
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "อุปกรณ์เสริม4:" VIEW-AS TEXT
          SIZE 11.5 BY .91 AT ROW 17.1 COL 4.33
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "จังหวัดทะเบียน:" VIEW-AS TEXT
          SIZE 12.67 BY .91 AT ROW 5.91 COL 3.5
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "เวลา:" VIEW-AS TEXT
          SIZE 4.5 BY .91 AT ROW 2.24 COL 98.17
          BGCOLOR 19 FGCOLOR 6 FONT 1
     "อุปกรณ์เสริม5:" VIEW-AS TEXT
          SIZE 11.5 BY .91 AT ROW 18.19 COL 4.33
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "CC :" VIEW-AS TEXT
          SIZE 3.67 BY .91 AT ROW 7.14 COL 22.17
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "เลขตัวถัง :" VIEW-AS TEXT
          SIZE 8.5 BY .91 AT ROW 5.91 COL 32.5
          BGCOLOR 19 FGCOLOR 2 FONT 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133.67 BY 25.95
         BGCOLOR 30 FGCOLOR 1 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "รายละเอียด5:" VIEW-AS TEXT
          SIZE 10.67 BY .91 AT ROW 18.19 COL 57.33
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "Class :" VIEW-AS TEXT
          SIZE 5.5 BY .91 AT ROW 7.05 COL 54.33
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "น้ำหนัก :" VIEW-AS TEXT
          SIZE 7 BY .91 AT ROW 7.1 COL 35
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "วันคุ้มครอง:" VIEW-AS TEXT
          SIZE 9.5 BY .91 AT ROW 9.33 COL 48.17
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "ภาษา:" VIEW-AS TEXT
          SIZE 4.83 BY .91 AT ROW 21.76 COL 112
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "รหัสประเภท:" VIEW-AS TEXT
          SIZE 10.17 BY .91 AT ROW 8.19 COL 42.5
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "วันที่โหลดงาน:" VIEW-AS TEXT
          SIZE 11.5 BY .91 AT ROW 2.24 COL 72.5
          BGCOLOR 19 FGCOLOR 6 FONT 1
     "รหัสลูกค้า:" VIEW-AS TEXT
          SIZE 9.5 BY .91 AT ROW 3.62 COL 97.83
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "แบบตัวถัง:" VIEW-AS TEXT
          SIZE 9 BY .91 AT ROW 4.86 COL 68.17
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "STAMP:" VIEW-AS TEXT
          SIZE 7.33 BY .91 AT ROW 10.48 COL 57.5
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "เลขใบอนุญาต:" VIEW-AS TEXT
          SIZE 11.83 BY .91 AT ROW 21.71 COL 4.17
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "%" VIEW-AS TEXT
          SIZE 2 BY .91 AT ROW 11.52 COL 22.5
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "ยี่ห้อ:" VIEW-AS TEXT
          SIZE 4.5 BY .91 AT ROW 4.71 COL 11
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "อุปกรณ์เสริม1:" VIEW-AS TEXT
          SIZE 11.5 BY .91 AT ROW 13.81 COL 4.33
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "ปีจดทะเบียน :" VIEW-AS TEXT
          SIZE 11.17 BY .91 AT ROW 5.95 COL 104.17
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "ทะเบียนรถ :" VIEW-AS TEXT
          SIZE 10.67 BY .91 AT ROW 4.81 COL 105
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "จำนวนที่นั่ง :" VIEW-AS TEXT
          SIZE 10 BY .91 AT ROW 7.1 COL 5.67
          BGCOLOR 19 FGCOLOR 2 FONT 1
     RECT-335 AT ROW 2.05 COL 1.5
     RECT-465 AT ROW 3.38 COL 2.67
     RECT-468 AT ROW 19.91 COL 2.5
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133.67 BY 25.95
         BGCOLOR 30 FGCOLOR 1 .


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
         TITLE              = "Update Data Notify SCBPT"
         HEIGHT             = 26.1
         WIDTH              = 134
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
       fi_poltyp:READ-ONLY IN FRAME fr_main        = TRUE.

ASSIGN 
       fi_time:READ-ONLY IN FRAME fr_main        = TRUE.

ASSIGN 
       fi_trandat:READ-ONLY IN FRAME fr_main        = TRUE.

ASSIGN 
       fi_user:READ-ONLY IN FRAME fr_main        = TRUE.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Update Data Notify SCBPT */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Update Data Notify SCBPT */
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
    
    Run  wgw\wgwqscb11(Input  nv_recidtlt).
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
                    brstat.tlt.sentcnt       = INT(fi_seat)            /*จำนวนที่นั่ง       */                                       
                    brstat.tlt.rencnt        = INT(fi_cc)              /*ขนาดเครื่องยนต์    */                                         
                    brstat.tlt.cc_weight     = INT(fi_ton)             /*น้ำหนัก            */                                        
                    brstat.tlt.expotim       = trim(fi_class)          /*รหัสการใช้รถยนต์   */
                  /*brstat.tlt.old_cha       = "GarCd:" + trim(fi_garcod) + " " +           /*รหัสการซ่อม        */                            
                                               "GarTy:" + trim(fi_garage)                   /*ประเภทการซ่อม      */ -- Comment By Tontawan S. A66-0006 --*/    
                    /*-- Add By Tontawan S. A66-0006 --*/ 
                    brstat.tlt.old_cha       = "GarCd:" + trim(fi_garage) + " " +           /*รหัสการซ่อม        */                            
                                               "GarTy:" + trim(fi_garcod)                   /*ประเภทการซ่อม      */ 
                    /*-- End By Tontawan S. A66-0006 --*/    
                    brstat.tlt.colorcod      = trim(fi_color)                               /*สีรถยนต์  */                                    
                    brstat.tlt.rec_addr3     = "CovCod:" + trim(fi_covtyp) + " " +          /*ประเภทของประกันภัย        */                    
                                               "CovTcd:" + trim(fi_covcod) + " " +          /*รหัสประเภทของประกันภัย    */                    
                                               "CovTyp:" + trim(fi_cover)  + " " +          /*ประเภทของความคุ้มครอง     */                    
                                               "CovTy1:" + trim(fi_subcover) + " " +        /*ประเภทย่อยของความคุ้มครอง */                    
                                               "CovTy2:" + trim(fi_covdetail)               /*รายละเอียดความคุ้มครอง    */                    
                    brstat.tlt.gendat        = date(fi_comdat)                              /*วันเริ่มความคุ้มครอง      */                    
                    brstat.tlt.expodat       = DATE(fi_expdat)                              /*วันที่สิ้นสุดความคุ้มครอง */                    
                    brstat.tlt.nor_coamt     = DECI(fi_si)                                  /*ทุนประกัน                 */                    
                    brstat.tlt.nor_grprm     = DECI(fi_prem)                                /*เบี้ยสุทธิก่อนหักส่วนลด   */                    
                    brstat.tlt.comp_grprm    = DECI(fi_prem1)                               /*เบี้ยสุทธิหลังหักส่วนลด   */                    
                    brstat.tlt.stat          = "Stm:" + STRING(deci(fi_stamp)) + " " +      /*จำนวนอากรสแตมป์       */                        
                                               "Vat:" + STRING(DECI(fi_vat))                /*จำนวนภาษี SBT/Vat     */                        
                    brstat.tlt.comp_coamt    = deci(fi_premtotal)                           /*เบี้ยรวม ภาษี-อากร    */                        
                    brstat.tlt.endno         = string(DECI(fi_dod))                         /*ค่าความเสียหายส่วนแรก */                        
                    brstat.tlt.comp_sck      = "fetP:" + STRING(DECI(fi_feeltp)) + " " +    /*% ส่วนลดกลุ่ม         */    
                                               "felA:" + STRING(DECI(fi_feelt))             /*จำนวนส่วนลดกลุ่ม      */    
                    brstat.tlt.comp_noti_tlt = "NcbP:" + string(DECI(fi_ncbp)) + " " +      /*% ส่วนลดประวัติดี     */    
                                               "NcbA:" + string(DECI(fi_ncb))               /*จำนวนส่วนลดประวัติดี  */    
                    brstat.tlt.comp_usr_tlt  = "DriP:" + string(DECI(fi_drip)) + " " +      /*% ส่วนลดกรณีผู้ขับขี่ */    
                                               "DriA:" + string(DECI(fi_dridis))            /*จำนวนส่วนลดกรณีผู้ขับขี่  */    
                    brstat.tlt.comp_noti_ins = "OthP:" + string(DECI(fi_oth)) + " " +       /*%สวนลดอื่นๆ           */    
                                               "OthA:" + string(DECI(fi_othdis))            /*จำนวนส่วนลดอื่นๆ      */    
                    brstat.tlt.comp_usr_ins  = "CTVP:" + string(DECI(fi_cctvp)) + " " +     /*%สวนลดกล้อง           */    
                                               "CTVA:" + string(DECI(fi_cctv))              /*จำนวนส่วนลดกล้อง      */    
                    brstat.tlt.comp_pol      = "SurP:" + string(DECI(fi_discp)) + " " +     /*%ส่วนลดเพิ่ม        */   
                                               "SurA:" + string(DECI(fi_disc))    + " " +   /*จำนวนส่วนลดเพิ่ม    */    
                                               "SurD:" + trim(fi_discdetail)                /*รายละเอียดส่วนเพิ่ม */    
                    brstat.tlt.filler1       = "Acc1:" + trim(fi_accr1)       + " " +       /*รหัส อุปกรณ์1  */   
                                               "Acd1:" + trim(fi_accdet1) + " " +           /*รายละเอียด1    */    
                                               "Acp1:" + STRING(DECI(fi_accpric1))  + " " + /*ราคาอุปกรณ์1   */    
                                               "Acc2:" + trim(fi_accr2)       + " " +       /*รหัส อุปกรณ์2  */    
                                               "Acd2:" + trim(fi_accdet2) + " " +           /*รายละเอียด2    */    
                                               "Acp2:" + STRING(DECI(fi_accpric2))  + " " + /*ราคาอุปกรณ์2   */    
                                               "Acc3:" + trim(fi_accr3)       + " " +       /*รหัส อุปกรณ์3  */    
                                               "Acd3:" + trim(fi_accdet3) + " " +           /*รายละเอียด3    */    
                                               "Acp3:" + STRING(DECI(fi_accpric3))  + " " + /*ราคาอุปกรณ์3   */    
                                               "Acc4:" + trim(fi_accr4)       + " " +       /*รหัส อุปกรณ์4  */    
                                               "Acd4:" + trim(fi_accdet4) + " " +           /*รายละเอียด 4   */    
                                               "Acp4:" + STRING(DECI(fi_accpric4))  + " " + /*ราคาอุปกรณ์4   */    
                                               "Acc5:" + trim(fi_accr5)       + " " +       /*รหัส อุปกรณ์5  */    
                                               "Acd5:" + TRIM(fi_accdet5) + " " +           /*รายละเอียด 5   */    
                                               "Acp5:" + STRING(DECI(fi_accpric5))          /*ราคาอุปกรณ์5     */    
                    brstat.tlt.nor_effdat    = date(fi_inspdate)                            /*วันที่ตรวจสภาพรถ */    
                    brstat.tlt.comp_effdat   = date(fi_appdate)                             /*วันที่อนุมัติตรวจสภาพรถ   */    
                    brstat.tlt.nor_noti_tlt  = "InspSt:" + trim(fi_inspres) + " " +         /*ผลการตรวจสภาพรถ           */    
                                               "InspDe:" + trim(fi_inspdet)                 /*รายละเอียดการตรวจสภาพรถ   */    
                    brstat.tlt.old_eng       = "BLice:"  + trim(fi_brolincen) + " " +       /*เลขที่ใบอนุญาตนายหน้า   */      
                                               "Bname:"  + trim(fi_bronam) + " " +          /*ชื่อบริษัทนายหน้า       */      
                                               "Bcode:"  + trim(fi_brocod)                  /*รหัสโบรคเกอร์           */      
                    brstat.tlt.filler2       = "Detai1:" + trim(fi_lang) + " " +            /*ภาษาในการออกกรมธรรม์    */      
                                               "Detai2:" + trim(fi_polsend) + " " +         /*ช่องทางการจัดส่ง        */      
                                               "Detai3:" + trim(fi_remarksend) + " " +      /*หมายเหตุการจัดส่ง       */      
                                               "Detai4:" + trim(fi_gift) + " " +            /*ของแถม                  */      
                                               "Remark:" + trim(fi_remark) .                /*หมายเหตุ                */ 
                   
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


&Scoped-define SELF-NAME fi_accr1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_accr1 C-Win
ON LEAVE OF fi_accr1 IN FRAME fr_main
DO:
    fi_accr1 = INPUT fi_accr1.
    DISP fi_accr1 WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_accr2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_accr2 C-Win
ON LEAVE OF fi_accr2 IN FRAME fr_main
DO:
    fi_accr2 = INPUT fi_accr2.
    DISP fi_accr2 WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_accr3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_accr3 C-Win
ON LEAVE OF fi_accr3 IN FRAME fr_main
DO:
  fi_accr3 = INPUT fi_accr3.
    DISP fi_accr3 WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_accr4
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_accr4 C-Win
ON LEAVE OF fi_accr4 IN FRAME fr_main
DO:
    fi_accr4 = INPUT fi_accr4.
    DISP fi_accr4 WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_accr5
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_accr5 C-Win
ON LEAVE OF fi_accr5 IN FRAME fr_main
DO:
  fi_accr5 = INPUT fi_accr5.
    DISP fi_accr5 WITH FRAME fr_main.
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


&Scoped-define SELF-NAME fi_appdate
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_appdate C-Win
ON LEAVE OF fi_appdate IN FRAME fr_main
DO:
    fi_appdate = INPUT fi_appdate.
    DISP fi_appdate WITH FRAME fr_main.
  
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


&Scoped-define SELF-NAME fi_cctvp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_cctvp C-Win
ON LEAVE OF fi_cctvp IN FRAME fr_main
DO:
    fi_cctvp = INPUT fi_cctvp.
    DISP fi_cctvp WITH FRAME fr_main.
  
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


&Scoped-define SELF-NAME fi_covdetail
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_covdetail C-Win
ON LEAVE OF fi_covdetail IN FRAME fr_main
DO:
    fi_covdetail = INPUT fi_covdetail.
    DISP fi_covdetail WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_cover
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_cover C-Win
ON LEAVE OF fi_cover IN FRAME fr_main
DO:
    fi_cover = INPUT fi_cover.
    DISP fi_cover WITH FRAME fr_main.
  
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


&Scoped-define SELF-NAME fi_discp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_discp C-Win
ON LEAVE OF fi_discp IN FRAME fr_main
DO:
    fi_discp = INPUT fi_discp.
    DISP fi_discp WITH FRAME fr_main.
  
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


&Scoped-define SELF-NAME fi_drip
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_drip C-Win
ON LEAVE OF fi_drip IN FRAME fr_main
DO:
    fi_drip = INPUT fi_drip.
    DISP fi_drip WITH FRAME fr_main.
  
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


&Scoped-define SELF-NAME fi_feeltp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_feeltp C-Win
ON LEAVE OF fi_feeltp IN FRAME fr_main
DO:
    fi_feeltp = INPUT fi_feeltp.
    DISP fi_feeltp WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_garage
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_garage C-Win
ON LEAVE OF fi_garage IN FRAME fr_main
DO:
    fi_garage = INPUT fi_garage.
    DISP fi_garage WITH FRAME fr_main.
  
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


&Scoped-define SELF-NAME fi_gift
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_gift C-Win
ON LEAVE OF fi_gift IN FRAME fr_main
DO:
    fi_gift = INPUT fi_gift.
    DISP fi_gift WITH FRAME fr_main.
  
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


&Scoped-define SELF-NAME fi_inspres
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_inspres C-Win
ON LEAVE OF fi_inspres IN FRAME fr_main
DO:
    fi_inspres = INPUT fi_inspres.
    DISP fi_inspres WITH FRAME fr_main.
  
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


&Scoped-define SELF-NAME fi_ncbp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_ncbp C-Win
ON LEAVE OF fi_ncbp IN FRAME fr_main
DO:
    fi_ncbp = INPUT fi_ncbp.
    DISP fi_ncbp WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_oth
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_oth C-Win
ON LEAVE OF fi_oth IN FRAME fr_main
DO:
    fi_oth = INPUT fi_oth.
    DISP fi_oth WITH FRAME fr_main.
  
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


&Scoped-define SELF-NAME fi_polsend
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_polsend C-Win
ON LEAVE OF fi_polsend IN FRAME fr_main
DO:
    fi_polsend = INPUT fi_polsend.
    DISP fi_polsend WITH FRAME fr_main.
  
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


&Scoped-define SELF-NAME fi_seat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_seat C-Win
ON LEAVE OF fi_seat IN FRAME fr_main
DO:
    fi_seat = INPUT fi_seat.
    DISP fi_seat WITH FRAME fr_main.
  
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


&Scoped-define SELF-NAME fi_subcover
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_subcover C-Win
ON LEAVE OF fi_subcover IN FRAME fr_main
DO:
    fi_subcover = INPUT fi_subcover.
    DISP fi_subcover WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_ton
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_ton C-Win
ON LEAVE OF fi_ton IN FRAME fr_main
DO:
    fi_ton = INPUT fi_ton.
    DISP fi_ton WITH FRAME fr_main.
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
  
  gv_prgid = "wgwqscb12".
  gv_prog  = "Query & Update Notify (SCBPT) ".
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
          fi_time      = brstat.tlt.enttim
          fi_user      = brstat.tlt.usrid
          fi_agent     = trim(brstat.tlt.recac)
          fi_producer  = trim(brstat.tlt.subins)
          fi_refno     = trim(brstat.tlt.nor_noti_ins)
          fi_custcode  = trim(brstat.tlt.nor_usr_ins)
          /*-- ข้อมูลรถ --*/
          fi_brand     = trim(brstat.tlt.brand)    
          fi_model     = trim(brstat.tlt.model)    
          fi_body      = trim(brstat.tlt.expousr)  
          fi_lincen    = trim(brstat.tlt.lince1)  
          fi_province  = trim(brstat.tlt.lince2)  
          fi_chssic    = trim(brstat.tlt.cha_no)  
          fi_engno     = trim(brstat.tlt.eng_no)  
          fi_year      = trim(brstat.tlt.gentim)  
          fi_seat      = brstat.tlt.sentcnt  
          fi_cc        = brstat.tlt.rencnt  
          fi_ton       = brstat.tlt.cc_weight
          fi_class     = TRIM(brstat.tlt.expotim)  
          /*
          fi_garcod    = TRIM(SUBSTR(brstat.tlt.old_cha,7,INDEX(tlt.old_cha,"garty:") - 7))
          fi_garage    = TRIM(SUBSTR(brstat.tlt.old_cha,R-INDEX(tlt.old_cha,"garty:") + 6)) --- Comment By Tontawan S. A66-0006 --*/
          /*--- Add By Tontawan S. A66-0006 ---*/
          fi_garage    = TRIM(SUBSTR(brstat.tlt.old_cha,7,INDEX(tlt.old_cha,"garty:") - 7))
          fi_garcod    = TRIM(SUBSTR(brstat.tlt.old_cha,R-INDEX(tlt.old_cha,"garty:") + 6))
          /*--- End By Tontawan S. A66-0006 ---*/ 
          fi_color     = TRIM(brstat.tlt.colorcod)
          /* ประเภทความคุ้มครอง */
          fi_covdetail = TRIM(SUBSTR(brstat.tlt.rec_addr3,R-INDEX(brstat.tlt.rec_addr3,"covty2:") + 7 ))
          n_char       = TRIM(SUBSTR(brstat.tlt.rec_addr3,1,R-INDEX(brstat.tlt.rec_addr3,"Covty2:") - 2 ))
          fi_subcover  = TRIM(SUBSTR(n_char,R-INDEX(n_char,"covty1:") + 7 ))
          n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"covty1:") - 2 ))
          fi_cover     = TRIM(SUBSTR(n_char,R-INDEX(n_char,"covtyp:") + 7 ))
          n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"covtyp:") - 2 ))
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
          fi_feeltp    = INT(SUBSTR(brstat.tlt.comp_sck,6,R-INDEX(brstat.tlt.comp_sck,"felA:") - 6))   
          fi_feelt     = DECI(SUBSTR(brstat.tlt.comp_sck,R-INDEX(brstat.tlt.comp_sck ,"felA:") + 5 ))  
          fi_ncbp      = INT(SUBSTR(brstat.tlt.comp_noti_tlt,6,R-INDEX(brstat.tlt.comp_noti_tlt,"ncbA:") - 6))         
          fi_ncb       = DECI(SUBSTR(brstat.tlt.comp_noti_tlt,R-INDEX(brstat.tlt.comp_noti_tlt ,"ncbA:") + 5 ))     
          fi_drip      = INT(SUBSTR(brstat.tlt.comp_usr_tlt,6,R-INDEX(brstat.tlt.comp_usr_tlt,"DriA:") - 6))        
          fi_dridis    = DECI(SUBSTR(brstat.tlt.comp_usr_tlt,R-INDEX(brstat.tlt.comp_usr_tlt ,"DriA:") + 5 ))      
          fi_oth       = INT(SUBSTR(brstat.tlt.comp_noti_ins,6,R-INDEX(brstat.tlt.comp_noti_ins,"OthA:") - 6))        
          fi_othdis    = DECI(SUBSTR(brstat.tlt.comp_noti_ins,R-INDEX(brstat.tlt.comp_noti_ins ,"OthA:") + 5 ))      
          fi_cctvp     = INT(SUBSTR(brstat.tlt.comp_usr_ins,6,R-INDEX(brstat.tlt.comp_usr_ins,"ctvA:") - 6))         
          fi_cctv      = DECI(SUBSTR(brstat.tlt.comp_usr_ins,R-INDEX(brstat.tlt.comp_usr_ins ,"ctvA:") + 5 ))  
          fi_discdetail= trim(SUBSTR(brstat.tlt.comp_pol,R-INDEX(brstat.tlt.comp_pol,"Surd:") + 5 ))
          n_char       = TRIM(SUBSTR(brstat.tlt.comp_pol,1,R-INDEX(brstat.tlt.comp_pol,"surd:") - 2 ))
          fi_discp     = INT(SUBSTR(n_char,6,R-INDEX(n_char,"SurA:") - 6))        
          fi_disc      = DECI(SUBSTR(n_char,R-INDEX(n_char,"SurA:") + 5 )) .
          RUN proc_assignfi .

     DISP fi_polno     fi_poltyp         fi_trandat    fi_user       fi_time  
          fi_brand      fi_model          fi_body       fi_lincen     fi_province   fi_chssic     
          fi_engno      fi_year           fi_seat       fi_cc         fi_ton        fi_class      
          fi_garcod     fi_garage         fi_color      fi_covtyp     fi_covcod     fi_covdetail  
          fi_si         fi_prem           fi_lang       fi_discdetail fi_accr1      fi_refno      
          fi_custcode   fi_inspres        fi_inspdet    fi_brolincen  fi_brocod     fi_bronam     
          fi_producer   fi_agent          fi_cover      fi_subcover   fi_prem1      fi_stamp      
          fi_vat        fi_premtotal      fi_dod        fi_feeltp     fi_feelt      fi_ncbp       
          fi_ncb        fi_drip           fi_dridis     fi_oth        fi_othdis     fi_cctvp      
          fi_cctv       fi_discp          fi_disc       fi_accdet1    fi_accpric1   fi_accr2      
          fi_accdet2    fi_accpric2       fi_accr3      fi_accdet3    fi_accpric3   fi_accr4      
          fi_accdet4    fi_accpric4       fi_accr5      fi_accdet5    fi_accpric5   fi_comdat     
          fi_expdat     fi_inspdate       fi_appdate    fi_polsend    fi_remarksend fi_gift       
          fi_remark     bu_detail1        bu_save       bu_exit WITH frame  fr_main. 
          bu_detail2:BGCOLOR = 19.
          bu_detail2:FGCOLOR = 6. 
          DISABLE bu_detail2 WITH FRAME fr_main.

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
          fi_year fi_seat fi_cc fi_ton fi_class fi_garcod fi_garage fi_color 
          fi_covtyp fi_covcod fi_covdetail fi_si fi_prem fi_lang fi_discdetail 
          fi_accr1 fi_refno fi_custcode fi_inspres fi_inspdet fi_brolincen 
          fi_brocod fi_bronam fi_producer fi_agent fi_cover fi_subcover fi_prem1 
          fi_stamp fi_vat fi_premtotal fi_dod fi_feeltp fi_feelt fi_ncbp fi_ncb 
          fi_drip fi_dridis fi_oth fi_othdis fi_cctvp fi_cctv fi_discp fi_disc 
          fi_accdet1 fi_accpric1 fi_accr2 fi_accdet2 fi_accpric2 fi_accr3 
          fi_accdet3 fi_accpric3 fi_accr4 fi_accdet4 fi_accpric4 fi_accr5 
          fi_accdet5 fi_accpric5 fi_comdat fi_expdat fi_inspdate fi_appdate 
          fi_polsend fi_remarksend fi_gift fi_remark fi_polno fi_poltyp 
          fi_trandat fi_user fi_time 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE bu_save bu_exit bu_detail2 bu_detail1 fi_brand fi_model fi_body 
         fi_lincen fi_province fi_chssic fi_engno fi_year fi_seat fi_cc fi_ton 
         fi_class fi_garcod fi_garage fi_color fi_covtyp fi_covcod fi_covdetail 
         fi_si fi_prem fi_lang fi_discdetail fi_accr1 fi_refno fi_custcode 
         fi_inspres fi_inspdet fi_brolincen fi_brocod fi_bronam fi_producer 
         fi_agent fi_cover fi_subcover fi_prem1 fi_stamp fi_vat fi_premtotal 
         fi_dod fi_feeltp fi_feelt fi_ncbp fi_ncb fi_drip fi_dridis fi_oth 
         fi_othdis fi_cctvp fi_cctv fi_discp fi_disc fi_accdet1 fi_accpric1 
         fi_accr2 fi_accdet2 fi_accpric2 fi_accr3 fi_accdet3 fi_accpric3 
         fi_accr4 fi_accdet4 fi_accpric4 fi_accr5 fi_accdet5 fi_accpric5 
         fi_comdat fi_expdat fi_inspdate fi_appdate fi_polsend fi_remarksend 
         fi_gift fi_remark fi_polno fi_poltyp fi_trandat fi_user fi_time 
         RECT-335 RECT-465 RECT-468 
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
        fi_accr5     = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Acc5:") + 5 ))
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acc5:") - 2 ))
        fi_accpric4  = INT(SUBSTR(n_char,R-INDEX(n_char,"Acp4:") + 5 ))
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acp4:") - 2 ))
        fi_accdet4   = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Acd4:") + 5 ))
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acd4:") - 2 ))
        fi_accr4     = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Acc4:") + 5 ))
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acc4:") - 2 ))
        fi_accpric3  = INT(SUBSTR(n_char,R-INDEX(n_char,"Acp3:") + 5 )) 
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acp3:") - 2 ))
        fi_accdet3   = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Acd3:") + 5 )) 
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acd3:") - 2 )) 
        fi_accr3     = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Acc3:") + 5 )) 
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acc3:") - 2 ))
        fi_accpric2  = INT(SUBSTR(n_char,R-INDEX(n_char,"Acp2:") + 5 )) 
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acp2:") - 2 ))
        fi_accdet2   = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Acd2:") + 5 )) 
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acd2:") - 2 ))
        fi_accr2     = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Acc2:") + 5 )) 
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acc2:") - 2 ))
        fi_accpric1  = INT(SUBSTR(n_char,R-INDEX(n_char,"Acp1:") + 5 )) 
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acp1:") - 2 ))  
        fi_accdet1   = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Acd1:") + 5 )) 
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acd1:") - 2 ))
        fi_accr1     = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Acc1:") + 5 ))
        fi_inspdate  = brstat.tlt.nor_effdat   
        fi_appdate   = brstat.tlt.comp_effdat 
        fi_inspres   = TRIM(SUBSTR(brstat.tlt.nor_noti_tlt,8,R-INDEX(brstat.tlt.nor_noti_tlt,"Inspde:") - 8))
        fi_inspdet   = TRIM(SUBSTR(brstat.tlt.nor_noti_tlt,R-INDEX(brstat.tlt.nor_noti_tlt,"Inspde:") + 7))
        fi_brocod    = TRIM(SUBSTR(brstat.tlt.old_eng,R-INDEX(brstat.tlt.old_eng,"Bcode:") + 6 ))
        n_char       = TRIM(SUBSTR(brstat.tlt.old_eng,1,R-INDEX(brstat.tlt.old_eng,"Bcode:") - 2 ))
        fi_bronam    = TRIM(SUBSTR(n_char,R-INDEX(n_char,"bname:") + 6 ))
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"bname:") - 2 ))
        fi_brolincen = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Blice:") + 6 ))
        fi_remark    = TRIM(SUBSTR(brstat.tlt.filler2,R-INDEX(brstat.tlt.filler2,"Remark:") + 7 ))
        n_char       = TRIM(SUBSTR(brstat.tlt.filler2,1,R-INDEX(brstat.tlt.filler2,"Remark:") - 2 ))
        fi_gift      = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Detai4:") + 7 ))
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Detai4:") - 2 ))
        fi_remarksend = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Detai3:") + 7 ))
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"detai3:") - 2 ))
        fi_polsend   = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Detai2:") + 7 ))
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"detai2:") - 2 ))
        fi_lang      = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Detai1:") + 7 )) .
END.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

