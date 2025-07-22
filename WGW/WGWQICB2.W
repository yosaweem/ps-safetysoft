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
  wuwqtis2.w :  Import text file from  ICBCTL  to create  new policy   
               Add in table  tlt Quey & Update data before Gen.
  Create  by  :  Ranu I. A59-0288  date. 26/09/2016 
  Modify by : Ranu I. A60-0263 date 12/06/2017 เพิ่มช่องแคมเปญ 
+++++++++++++++++++++++++++++++++++++++++++++++*/
Def  Input  parameter  nv_recidtlt  as  recid  .
Def  var nv_index  as int  init 0.
DEF  VAR nv_chaidrep AS CHAR . /*A57-0262*/
DEF VAR n_length  AS INT INIT 0 .
DEF VAR n_wht70   AS char format "x(15)"  init "" . 
DEF VAR n_wht72   AS char format "x(15)"  init "" . 
DEF VAR n_fi      AS char format "x(15)"  init "" . 
DEF VAR n_char    AS CHAR FORMAT "x(100)" init "" .
DEF VAR n_comdat    AS CHAR.
DEF VAR n_expdat    AS CHAR.
DEF VAR n_comdat72  AS CHAR.
DEF VAR n_expdat72  AS CHAR.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS fi_vatcode fi_tel fi_policy fi_covcod2 ~
fi_occ fi_polstatus fi_polsystem fi_compol fi_producer fi_agent fi_pro_off ~
fi_branch fi_notno fi_accno fi_comprem fi_notcode fi_ins_off fi_brand ~
fi_vehuse fi_year fi_ton fi_eng_no fi_cha_no fi_licence fi_province ~
fi_covcod fi_tp1 fi_dealer fi_FI fi_wht fi_comdat fi_expdat fi_sumsi ~
fi_gross_amt fi_comdat72 fi_expdat72 fi_compprm fi_sckno fi_prem1 fi_garage ~
fi_tp2 fi_title fi_firstname fi_lastname fi_icno fi_addr1 fi_addr2 fi_addr3 ~
fi_addr4 fi_driv1 fi_birth1 fi_drivid1 fi_driv2 fi_birth2 fi_drivid2 ~
fi_benname fi_client fi_remark1 fi_remark2 bu_save bu_exit fi_wht72 ~
fi_class fi_drivic1 fi_drivic2 fi_inspace fi_recname fi_recadd fi_camp ~
RECT-335 RECT-381 RECT-382 RECT-383 RECT-385 RECT-386 
&Scoped-Define DISPLAYED-OBJECTS fi_vatcode fi_desbran fi_tel fi_policy ~
fi_covcod2 fi_occ fi_type fi_polstatus fi_paydate fi_status fi_polsystem ~
fi_compol fi_producer fi_agent fi_pro_off fi_branch fi_notno fi_accno ~
fi_comprem fi_notcode fi_ins_off fi_brand fi_vehuse fi_year fi_ton ~
fi_eng_no fi_cha_no fi_licence fi_province fi_covcod fi_tp1 fi_dealer fi_FI ~
fi_wht fi_comdat fi_expdat fi_sumsi fi_gross_amt fi_comdat72 fi_expdat72 ~
fi_compprm fi_sckno fi_prem1 fi_garage fi_tp2 fi_title fi_firstname ~
fi_lastname fi_icno fi_addr1 fi_addr2 fi_addr3 fi_addr4 fi_driv1 fi_birth1 ~
fi_drivid1 fi_driv2 fi_birth2 fi_drivid2 fi_benname fi_client fi_remark1 ~
fi_remark2 fi_ldate fi_ltime fi_trndat fi_userid fi_wht72 fi_class ~
fi_drivic1 fi_drivic2 fi_inspace fi_recname fi_recadd fi_camp 

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
     SIZE 8 BY 1
     FONT 6.

DEFINE BUTTON bu_save 
     LABEL "Save" 
     SIZE 8 BY 1
     FONT 6.

DEFINE VARIABLE fi_accno AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 17.33 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_addr1 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 48 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_addr2 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 48.17 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_addr3 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 48 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_addr4 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 48.17 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_agent AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 14.17 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_benname AS CHARACTER FORMAT "X(65)":U 
     VIEW-AS FILL-IN 
     SIZE 36.83 BY .86
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_birth1 AS CHARACTER FORMAT "X(15)":U INITIAL "0" 
     VIEW-AS FILL-IN 
     SIZE 13 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_birth2 AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 13 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_branch AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 5.17 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_brand AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 21.5 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_camp AS CHARACTER FORMAT "X(45)":U 
     VIEW-AS FILL-IN 
     SIZE 18.5 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_cha_no AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 23 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_class AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 11 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_client AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 11 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_comdat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_comdat72 AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_compol AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 20 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_compprm AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 18 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_comprem AS DECIMAL FORMAT "->>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 18.17 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_covcod AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 4 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_covcod2 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_dealer AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 32 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_desbran AS CHARACTER FORMAT "X(15)":U 
      VIEW-AS TEXT 
     SIZE 13.5 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_driv1 AS CHARACTER FORMAT "X(60)":U 
     VIEW-AS FILL-IN 
     SIZE 30 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_driv2 AS CHARACTER FORMAT "X(60)":U 
     VIEW-AS FILL-IN 
     SIZE 30 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_drivic1 AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_drivic2 AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_drivid1 AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_drivid2 AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_eng_no AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 23 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_expdat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_expdat72 AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_FI AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 13 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_firstname AS CHARACTER FORMAT "X(75)":U 
     VIEW-AS FILL-IN 
     SIZE 23.5 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_garage AS CHARACTER FORMAT "X(30)":U INITIAL ? 
     VIEW-AS FILL-IN 
     SIZE 13.67 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_gross_amt AS DECIMAL FORMAT "->>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 18.17 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_icno AS CHARACTER FORMAT "X(13)":U 
     VIEW-AS FILL-IN 
     SIZE 20.33 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_inspace AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 31.83 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_ins_off AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 23.17 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_lastname AS CHARACTER FORMAT "X(45)":U 
     VIEW-AS FILL-IN 
     SIZE 26 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_ldate AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 15.33 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_licence AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 10 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_ltime AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 11 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_notcode AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 11.5 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_notno AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 17.83 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_occ AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 32.67 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_paydate AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 16.5 BY 1
     BGCOLOR 19 FGCOLOR 6 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_policy AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 21 BY 1
     FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE fi_polstatus AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 17.33 BY 1
     BGCOLOR 19 FGCOLOR 6 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_polsystem AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 20 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_prem1 AS DECIMAL FORMAT "->>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 18.33 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_producer AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_province AS CHARACTER FORMAT "X(35)":U 
     VIEW-AS FILL-IN 
     SIZE 18 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_pro_off AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 11 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_recadd AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 91.33 BY .86
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_recname AS CHARACTER FORMAT "X(85)":U 
     VIEW-AS FILL-IN 
     SIZE 35.67 BY .86
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_remark1 AS CHARACTER FORMAT "X(85)":U 
     VIEW-AS FILL-IN 
     SIZE 91.33 BY .86
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_remark2 AS CHARACTER FORMAT "X(85)":U 
     VIEW-AS FILL-IN 
     SIZE 91.33 BY .86
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_sckno AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 18.33 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_status AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 19.33 BY 1
     BGCOLOR 19 FGCOLOR 6 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_sumsi AS INTEGER FORMAT ">>>,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 18.33 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_tel AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 25.5 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_title AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 11 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_ton AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 12 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_tp1 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 38.33 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_tp2 AS CHARACTER FORMAT "x(15)":U 
     VIEW-AS FILL-IN 
     SIZE 13 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_trndat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 15.17 BY 1
     BGCOLOR 10 FGCOLOR 4 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_type AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 15.33 BY 1
     BGCOLOR 31 FGCOLOR 7 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_userid AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 11 BY 1
     BGCOLOR 7 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_vatcode AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 19.17 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_vehuse AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 29.17 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_wht AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 13 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_wht72 AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 11.83 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_year AS CHARACTER FORMAT "X(4)":U INITIAL "0" 
     VIEW-AS FILL-IN 
     SIZE 7.33 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE RECTANGLE RECT-335
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132.67 BY 28
     BGCOLOR 19 FGCOLOR 2 .

DEFINE RECTANGLE RECT-381
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 10.5 BY 1.52
     BGCOLOR 5 FGCOLOR 2 .

DEFINE RECTANGLE RECT-382
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 10.5 BY 1.52
     BGCOLOR 4 .

DEFINE RECTANGLE RECT-383
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 131 BY 3.81
     BGCOLOR 29 .

DEFINE RECTANGLE RECT-385
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 131 BY 9.62.

DEFINE RECTANGLE RECT-386
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 130.5 BY 10.62.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     fi_vatcode AT ROW 5.33 COL 110.83 COLON-ALIGNED NO-LABEL
     fi_desbran AT ROW 4.19 COL 116.5 COLON-ALIGNED NO-LABEL
     fi_tel AT ROW 17.95 COL 94.67 COLON-ALIGNED NO-LABEL
     fi_policy AT ROW 1.24 COL 39.67 COLON-ALIGNED NO-LABEL
     fi_covcod2 AT ROW 9.48 COL 33.17 COLON-ALIGNED NO-LABEL
     fi_occ AT ROW 17.95 COL 49.67 COLON-ALIGNED NO-LABEL
     fi_type AT ROW 1.29 COL 3.17 NO-LABEL
     fi_polstatus AT ROW 27.43 COL 88.67 COLON-ALIGNED NO-LABEL
     fi_paydate AT ROW 27.43 COL 55.5 COLON-ALIGNED NO-LABEL
     fi_status AT ROW 27.38 COL 19.17 COLON-ALIGNED NO-LABEL
     fi_polsystem AT ROW 1.24 COL 77 COLON-ALIGNED NO-LABEL
     fi_compol AT ROW 1.24 COL 110.67 COLON-ALIGNED NO-LABEL
     fi_producer AT ROW 3.14 COL 77.67 COLON-ALIGNED NO-LABEL
     fi_agent AT ROW 3.1 COL 106.33 COLON-ALIGNED NO-LABEL
     fi_pro_off AT ROW 4.19 COL 48.17 COLON-ALIGNED NO-LABEL
     fi_branch AT ROW 4.19 COL 110.5 COLON-ALIGNED NO-LABEL
     fi_notno AT ROW 5.24 COL 18.17 COLON-ALIGNED NO-LABEL
     fi_accno AT ROW 5.24 COL 49.33 COLON-ALIGNED NO-LABEL
     fi_comprem AT ROW 14.71 COL 50.33 COLON-ALIGNED NO-LABEL
     fi_notcode AT ROW 11.57 COL 109.83 COLON-ALIGNED NO-LABEL
     fi_ins_off AT ROW 5.29 COL 76.83 COLON-ALIGNED NO-LABEL
     fi_brand AT ROW 7.48 COL 18.5 COLON-ALIGNED NO-LABEL
     fi_vehuse AT ROW 7.48 COL 48.5 COLON-ALIGNED NO-LABEL
     fi_year AT ROW 7.43 COL 85.5 COLON-ALIGNED NO-LABEL
     fi_ton AT ROW 7.48 COL 105.83 COLON-ALIGNED NO-LABEL
     fi_eng_no AT ROW 8.48 COL 18.5 COLON-ALIGNED NO-LABEL
     fi_cha_no AT ROW 8.48 COL 54.67 COLON-ALIGNED NO-LABEL
     fi_licence AT ROW 8.43 COL 88 COLON-ALIGNED NO-LABEL
     fi_province AT ROW 8.48 COL 108.17 COLON-ALIGNED NO-LABEL
     fi_covcod AT ROW 9.57 COL 18.5 COLON-ALIGNED NO-LABEL
     fi_tp1 AT ROW 9.52 COL 59.17 COLON-ALIGNED NO-LABEL
     fi_dealer AT ROW 4.19 COL 71.5 COLON-ALIGNED NO-LABEL
     fi_FI AT ROW 10.52 COL 108.5 COLON-ALIGNED NO-LABEL
     fi_wht AT ROW 11.62 COL 79.5 COLON-ALIGNED NO-LABEL
     fi_comdat AT ROW 10.57 COL 18.5 COLON-ALIGNED NO-LABEL
     fi_expdat AT ROW 10.52 COL 50.33 COLON-ALIGNED NO-LABEL
     fi_sumsi AT ROW 10.52 COL 79.33 COLON-ALIGNED NO-LABEL
     fi_gross_amt AT ROW 11.57 COL 50.33 COLON-ALIGNED NO-LABEL
     fi_comdat72 AT ROW 13.71 COL 18.17 COLON-ALIGNED NO-LABEL
     fi_expdat72 AT ROW 13.71 COL 50.33 COLON-ALIGNED NO-LABEL
     fi_compprm AT ROW 14.71 COL 18.33 COLON-ALIGNED NO-LABEL
     fi_sckno AT ROW 13.67 COL 106 COLON-ALIGNED NO-LABEL
     fi_prem1 AT ROW 11.62 COL 18.33 COLON-ALIGNED NO-LABEL
     fi_garage AT ROW 12.67 COL 50.5 COLON-ALIGNED NO-LABEL
     fi_tp2 AT ROW 9.52 COL 113 COLON-ALIGNED NO-LABEL
     fi_title AT ROW 17 COL 18 COLON-ALIGNED NO-LABEL
     fi_firstname AT ROW 16.95 COL 36.17 COLON-ALIGNED NO-LABEL
     fi_lastname AT ROW 16.91 COL 70.33 COLON-ALIGNED NO-LABEL
     fi_icno AT ROW 18.05 COL 17.67 COLON-ALIGNED NO-LABEL
     fi_addr1 AT ROW 19.1 COL 17.5 COLON-ALIGNED NO-LABEL
     fi_addr2 AT ROW 19 COL 77.33 COLON-ALIGNED NO-LABEL
     fi_addr3 AT ROW 20.1 COL 17.5 COLON-ALIGNED NO-LABEL
     fi_addr4 AT ROW 20 COL 77.33 COLON-ALIGNED NO-LABEL
     fi_driv1 AT ROW 21.1 COL 17.5 COLON-ALIGNED NO-LABEL
     fi_birth1 AT ROW 21.1 COL 58.33 COLON-ALIGNED NO-LABEL
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1.67 ROW 1.1
         SIZE 133 BY 28.24
         BGCOLOR 3 FGCOLOR 1 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     fi_drivid1 AT ROW 21.05 COL 84 COLON-ALIGNED NO-LABEL
     fi_driv2 AT ROW 22.1 COL 17.67 COLON-ALIGNED NO-LABEL
     fi_birth2 AT ROW 22.1 COL 58.33 COLON-ALIGNED NO-LABEL
     fi_drivid2 AT ROW 22.05 COL 84 COLON-ALIGNED NO-LABEL
     fi_benname AT ROW 23.1 COL 17.67 COLON-ALIGNED NO-LABEL
     fi_client AT ROW 13.67 COL 79.33 COLON-ALIGNED NO-LABEL
     fi_remark1 AT ROW 24.95 COL 19.67 NO-LABEL
     fi_remark2 AT ROW 25.86 COL 17.67 COLON-ALIGNED NO-LABEL
     bu_save AT ROW 27.52 COL 112.33
     bu_exit AT ROW 27.52 COL 123
     fi_ldate AT ROW 3.1 COL 18.33 COLON-ALIGNED NO-LABEL
     fi_ltime AT ROW 3.1 COL 48.33 COLON-ALIGNED NO-LABEL
     fi_trndat AT ROW 4.14 COL 18.33 COLON-ALIGNED NO-LABEL
     fi_userid AT ROW 25.76 COL 115 COLON-ALIGNED NO-LABEL
     fi_wht72 AT ROW 14.76 COL 79.5 COLON-ALIGNED NO-LABEL
     fi_class AT ROW 12.67 COL 18.5 COLON-ALIGNED NO-LABEL
     fi_drivic1 AT ROW 21.05 COL 108.5 COLON-ALIGNED NO-LABEL
     fi_drivic2 AT ROW 22.1 COL 108.5 COLON-ALIGNED NO-LABEL
     fi_inspace AT ROW 12.67 COL 79.67 COLON-ALIGNED NO-LABEL
     fi_recname AT ROW 23.1 COL 73.5 NO-LABEL
     fi_recadd AT ROW 24.05 COL 19.67 NO-LABEL
     fi_camp AT ROW 16.81 COL 109 COLON-ALIGNED NO-LABEL WIDGET-ID 2
     "ฺ Birth :":30 VIEW-AS TEXT
          SIZE 7 BY .95 AT ROW 21.05 COL 53
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " คำนำหน้าชื่อ :":30 VIEW-AS TEXT
          SIZE 13 BY .95 AT ROW 17.1 COL 6.67
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "Class72 :":30 VIEW-AS TEXT
          SIZE 9.5 BY .95 AT ROW 13.67 COL 71.17
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "ดีลเลอร์ :":35 VIEW-AS TEXT
          SIZE 9.5 BY .95 AT ROW 4.14 COL 63.67
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "WHT72 :":35 VIEW-AS TEXT
          SIZE 9.17 BY .95 AT ROW 14.76 COL 71.83
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " Recepit Name :":30 VIEW-AS TEXT
          SIZE 15.5 BY .86 AT ROW 23.14 COL 57.33
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " ที่อยู่ออกใบเสร็จ :":30 VIEW-AS TEXT
          SIZE 16.33 BY .86 AT ROW 24 COL 2.5
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " IC NO :" VIEW-AS TEXT
          SIZE 8 BY .95 AT ROW 21.05 COL 102.17
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " IC NO :" VIEW-AS TEXT
          SIZE 8 BY .95 AT ROW 22.1 COL 102.17
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " จังหวัด :":30 VIEW-AS TEXT
          SIZE 9.17 BY .95 AT ROW 8.48 COL 100.83
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "ประเภทรถ :":30 VIEW-AS TEXT
          SIZE 10.5 BY .91 AT ROW 9.62 COL 50.17
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " สาขา :":30 VIEW-AS TEXT
          SIZE 6.5 BY .91 AT ROW 4.19 COL 105.5
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " ทะเบียน :":30 VIEW-AS TEXT
          SIZE 10 BY .95 AT ROW 8.48 COL 80
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " ข้อมูลลูกค้า" VIEW-AS TEXT
          SIZE 11.5 BY 1 AT ROW 16 COL 2
          BGCOLOR 19 FGCOLOR 6 FONT 6
     " นามสกุล :":30 VIEW-AS TEXT
          SIZE 9.67 BY .95 AT ROW 16.95 COL 62.67
          BGCOLOR 19 FGCOLOR 2 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1.67 ROW 1.1
         SIZE 133 BY 28.24
         BGCOLOR 3 FGCOLOR 1 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     " ข้อรถและการประกันภัย" VIEW-AS TEXT
          SIZE 21 BY .91 AT ROW 6.29 COL 2
          BGCOLOR 19 FGCOLOR 6 FONT 6
     "รหัสบริษัท :":35 VIEW-AS TEXT
          SIZE 11.5 BY .95 AT ROW 4.24 COL 37.83
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " ข้อมูลการแจ้งงาน" VIEW-AS TEXT
          SIZE 17 BY .81 AT ROW 2.29 COL 2
          BGCOLOR 19 FGCOLOR 6 FONT 6
     "  ที่อยู่ 1 :":30 VIEW-AS TEXT
          SIZE 9 BY .95 AT ROW 19.19 COL 10.17
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " ทุนประกัน :":35 VIEW-AS TEXT
          SIZE 11.5 BY .95 AT ROW 10.57 COL 69
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " เลขตัวถัง :":20 VIEW-AS TEXT
          SIZE 11 BY .95 AT ROW 8.52 COL 45.17
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " วันที่หมดอายุ70 :":35 VIEW-AS TEXT
          SIZE 15.5 BY .95 AT ROW 10.62 COL 36.33
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "ื กรมธรรม์ใหม่  :":35 VIEW-AS TEXT
          SIZE 15 BY .95 AT ROW 1.24 COL 63.5
          BGCOLOR 2 FGCOLOR 7 FONT 6
     " Drive ID :" VIEW-AS TEXT
          SIZE 10.5 BY .95 AT ROW 22 COL 75.17
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "เลขที่สัญญา :":30 VIEW-AS TEXT
          SIZE 11.5 BY .91 AT ROW 5.24 COL 39.67
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "ทุนชน :":35 VIEW-AS TEXT
          SIZE 7.17 BY .95 AT ROW 10.57 COL 102
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "วันที่ Confirm :" VIEW-AS TEXT
          SIZE 14 BY 1 AT ROW 27.43 COL 43
          BGCOLOR 19 FGCOLOR 4 FONT 6
     "เบี้ยสุทธิ 72 :":30 VIEW-AS TEXT
          SIZE 11.67 BY .95 AT ROW 14.71 COL 7.17
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " Agent code :":30 VIEW-AS TEXT
          SIZE 13 BY .95 AT ROW 3.1 COL 95
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " เลขเครื่อง :":35 VIEW-AS TEXT
          SIZE 10.5 BY .95 AT ROW 8.52 COL 8.5
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " วันที่โหลด  :":30 VIEW-AS TEXT
          SIZE 12 BY .95 AT ROW 3.19 COL 7.67
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " ชื่อ :":30 VIEW-AS TEXT
          SIZE 5.67 BY .95 AT ROW 17 COL 32.17
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " Remark :":30 VIEW-AS TEXT
          SIZE 10 BY .86 AT ROW 24.95 COL 8.83
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " Birth :":30 VIEW-AS TEXT
          SIZE 7 BY .95 AT ROW 22.05 COL 52.83
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " เบี้ยรวม72 :":35 VIEW-AS TEXT
          SIZE 12.17 BY .91 AT ROW 14.71 COL 39.5
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " เบี้ยสุทธิ 70 :":25 VIEW-AS TEXT
          SIZE 12.17 BY .95 AT ROW 11.52 COL 7
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "Producer code :":30 VIEW-AS TEXT
          SIZE 16 BY .95 AT ROW 3.14 COL 63.67
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "อาชีพ :" VIEW-AS TEXT
          SIZE 7.5 BY .91 AT ROW 18.05 COL 43.83
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " ประเภทการซ่อม :":35 VIEW-AS TEXT
          SIZE 16.5 BY .95 AT ROW 12.67 COL 35.33
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "Status Policy :" VIEW-AS TEXT
          SIZE 14 BY 1 AT ROW 27.43 COL 75.83
          BGCOLOR 19 FGCOLOR 4 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1.67 ROW 1.1
         SIZE 133 BY 28.24
         BGCOLOR 3 FGCOLOR 1 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     " เวลาโหลด  :":30 VIEW-AS TEXT
          SIZE 12 BY .95 AT ROW 3.1 COL 37.33
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "  ชื่อผู้ขับขี่ 1 :":30 VIEW-AS TEXT
          SIZE 13 BY .95 AT ROW 21.05 COL 6.17
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " ปีรถ :":35 VIEW-AS TEXT
          SIZE 6.5 BY .95 AT ROW 7.48 COL 80.83
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "ผู้รับผลประโยชน์ :":30 VIEW-AS TEXT
          SIZE 16.5 BY .86 AT ROW 23.1 COL 2.5
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "เบอร์โทร :" VIEW-AS TEXT
          SIZE 9.5 BY .91 AT ROW 17.95 COL 87
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "คุ้มครอง :" VIEW-AS TEXT
          SIZE 8.5 BY .91 AT ROW 9.57 COL 26
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " วันที่คุ้มครอง72 :":35 VIEW-AS TEXT
          SIZE 16 BY .95 AT ROW 13.67 COL 3.33
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "เลขสติ๊กเกอร์ :":30 VIEW-AS TEXT
          SIZE 12.67 BY .95 AT ROW 13.67 COL 94.83
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " วันที่ไฟล์แจ้งงาน :" VIEW-AS TEXT
          SIZE 17.17 BY .95 AT ROW 4.19 COL 2.33
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " ชื่อผู้แจ้ง:":30 VIEW-AS TEXT
          SIZE 9.5 BY .95 AT ROW 5.29 COL 69.33
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "IC No :":30 VIEW-AS TEXT
          SIZE 7.5 BY .95 AT ROW 18.05 COL 12.17
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "ระบุผู้ขับขี่  :":30 VIEW-AS TEXT
          SIZE 11 BY .95 AT ROW 11.57 COL 99.5
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "  ชื่อผู้ขับขี่ 2 :":30 VIEW-AS TEXT
          SIZE 13 BY .95 AT ROW 22.1 COL 6.17
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "วันที่จดทะเบียน :":30 VIEW-AS TEXT
          SIZE 14.67 BY .91 AT ROW 9.57 COL 100
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "  ที่อยู่ 4 :":30 VIEW-AS TEXT
          SIZE 9.5 BY .95 AT ROW 19.95 COL 69.17
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "Vat code :":30 VIEW-AS TEXT
          SIZE 10 BY .91 AT ROW 5.29 COL 102.5
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " เลขรับแจ้ง :":35 VIEW-AS TEXT
          SIZE 11.67 BY .95 AT ROW 5.19 COL 7.5
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "  ที่อยู่ 3 :":35 VIEW-AS TEXT
          SIZE 9 BY .95 AT ROW 20.05 COL 10.17
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " ยี่ห้อรถ :":30 VIEW-AS TEXT
          SIZE 8.33 BY .95 AT ROW 7.48 COL 10.67
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " วันที่คุ้มครอง70 :":35 VIEW-AS TEXT
          SIZE 16 BY .95 AT ROW 10.52 COL 3.67
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " รุ่นรถ :":30 VIEW-AS TEXT
          SIZE 7.67 BY .95 AT ROW 7.48 COL 42.83
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "Campaign :":30 VIEW-AS TEXT
          SIZE 11 BY .95 AT ROW 16.86 COL 99.5 WIDGET-ID 4
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "Class70 :":30 VIEW-AS TEXT
          SIZE 9.5 BY .95 AT ROW 12.62 COL 10
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "WHT70 :":35 VIEW-AS TEXT
          SIZE 9.17 BY .95 AT ROW 11.62 COL 71.17
          BGCOLOR 19 FGCOLOR 0 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1.67 ROW 1.1
         SIZE 133 BY 28.24
         BGCOLOR 3 FGCOLOR 1 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     " วันที่คุ้มครอง72 :":35 VIEW-AS TEXT
          SIZE 15.67 BY .95 AT ROW 13.71 COL 35.83
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " เบี้ยรวม 70 :":30 VIEW-AS TEXT
          SIZE 12.83 BY .95 AT ROW 11.67 COL 39.33
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "ตรวจสภาพ :":30 VIEW-AS TEXT
          SIZE 12.17 BY .91 AT ROW 12.62 COL 68.5
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " กรมธรรม์เดิม  :":35 VIEW-AS TEXT
          SIZE 15 BY .95 AT ROW 1.24 COL 26.17
          BGCOLOR 4 FGCOLOR 7 FONT 6
     " เบอร์ พรบ  :":35 VIEW-AS TEXT
          SIZE 12.67 BY .95 AT ROW 1.24 COL 99.33
          BGCOLOR 2 FGCOLOR 7 FONT 6
     " Drive ID :" VIEW-AS TEXT
          SIZE 10.5 BY .95 AT ROW 21 COL 75.17
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " น้ำหนักรถ :":30 VIEW-AS TEXT
          SIZE 10.5 BY .95 AT ROW 7.43 COL 96.67
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "  ที่อยู่ 2 :":30 VIEW-AS TEXT
          SIZE 9.5 BY .95 AT ROW 19.1 COL 69.17
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " ประเภทประกัน :":30 VIEW-AS TEXT
          SIZE 15 BY .91 AT ROW 9.62 COL 4.5
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "ข้อมูลการ Confirm :" VIEW-AS TEXT
          SIZE 17.5 BY 1 AT ROW 27.38 COL 3.17
          BGCOLOR 19 FGCOLOR 4 FONT 6
     RECT-335 AT ROW 1.1 COL 1.17
     RECT-381 AT ROW 27.29 COL 111
     RECT-382 AT ROW 27.29 COL 121.83
     RECT-383 AT ROW 3 COL 2
     RECT-385 AT ROW 6.81 COL 2
     RECT-386 AT ROW 16.57 COL 2.17
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1.67 ROW 1.1
         SIZE 133 BY 28.24
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
         TITLE              = "Update Data ICBCTL (NEW)"
         HEIGHT             = 28.24
         WIDTH              = 134.17
         MAX-HEIGHT         = 29.19
         MAX-WIDTH          = 135
         VIRTUAL-HEIGHT     = 29.19
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
/* SETTINGS FOR FILL-IN fi_desbran IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_ldate IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_ltime IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_paydate IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_recadd IN FRAME fr_main
   ALIGN-L                                                              */
/* SETTINGS FOR FILL-IN fi_recname IN FRAME fr_main
   ALIGN-L                                                              */
/* SETTINGS FOR FILL-IN fi_remark1 IN FRAME fr_main
   ALIGN-L                                                              */
/* SETTINGS FOR FILL-IN fi_status IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_trndat IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_type IN FRAME fr_main
   NO-ENABLE ALIGN-L                                                    */
ASSIGN 
       fi_type:READ-ONLY IN FRAME fr_main        = TRUE.

/* SETTINGS FOR FILL-IN fi_userid IN FRAME fr_main
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Update Data ICBCTL (NEW) */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Update Data ICBCTL (NEW) */
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
            ASSIGN n_comdat   = ""               
                   n_expdat   = ""               
                   n_comdat72 = ""               
                   n_expdat72 = ""            
                   n_comdat   = input fi_comdat   
                   n_expdat   = input fi_expdat   
                   n_comdat72 = input fi_comdat72 
                   n_expdat72 = input fi_expdat72. 
            Find  brstat.tlt Where  Recid(brstat.tlt)  =  nv_recidtlt.
            If  avail  brstat.tlt Then do:
                Assign
                     brstat.tlt.stat         = IF fi_inspace <> "" THEN trim(input fi_garage) + " Inspace:" + trim(INPUT fi_inspace) 
                                               ELSE trim(input fi_garage)                   /*สถานที่ซ่อม     */                                                            
                     brstat.tlt.lince3       = trim(input fi_province)                      /*จังหวัด         */                                                    
                     brstat.tlt.brand        = trim(input fi_brand)                         /*ยี่ห้อ          */                                                    
                     brstat.tlt.comp_sck     = trim(input fi_sckno)                         /*เลขที่สติ๊กเกอร์*/                                                    
                     brstat.tlt.nor_coamt    = (input fi_sumsi)                             /*ทุนประกัน       */                                                    
                     brstat.tlt.comp_coamt   = (input fi_gross_amt)                         /*เบี้ยรวมกธ      */                                                  
                     brstat.tlt.nor_grprm    = (input fi_prem1)                             /*เบี้ยสุทธิกธ.   */                                                      
                     brstat.tlt.comp_grprm   = (input fi_comprem)                           /*เบี้ยสุธิพรบ    */                                                     
                     brstat.tlt.nor_usr_tlt  = "FI " + trim(STRING(input fi_fi)) +          /*ทุนหาย          */                           
                                               " Wht70 " + trim(STRING(input fi_wht))  +    /*wht             */   
                                               " Wht72 " + trim(STRING(input fi_wht72))     /*wht 72          */   
                     brstat.tlt.model        = TRIM(input fi_vehuse)                        /*รุ่น                  */                                                     
                     brstat.tlt.gendat       = DATE(n_comdat)    /* DATE(input fi_comdat)  */                      /*วันที่เริ่มคุ้มครอง        */                                                
                     brstat.tlt.expodat      = date(n_expdat)    /* DATE(input fi_expdat)  */                    /*วันที่สิ้นสุดคุ้มครอง      */                                                
                     brstat.tlt.comp_effdat  = date(n_comdat72)  /* DATE(input fi_comdat72)*/                  /*วันทีเริ่มคุ้มครองพรบ      */                                                
                     brstat.tlt.nor_effdat   = date(n_expdat72)  /* DATE(input fi_expdat72)*/                /*วันที่สิ้นสุดคุ้มครองพรบ   */                                                
                     brstat.tlt.nor_usr_ins  = trim(input fi_ins_off)                       /*ผู้แจ้ง                    */                                                
                     brstat.tlt.comp_usr_tlt = trim(input fi_notcode)                       /*ระยุผู้ขับขี่               */                                               
                     brstat.tlt.ins_addr1    = trim(input fi_addr1)                         /*ที่อยู่ลูกค้า 1             */                                               
                     brstat.tlt.ins_addr2    = trim(input fi_addr2)                         /*ที่อยู่ลูกค้า  2            */                                               
                     brstat.tlt.ins_addr3    = trim(input fi_addr3)                         /*ที่อยู่ลูกค้า3              */                                                
                     brstat.tlt.ins_addr4    = IF INPUT fi_tel <> "" THEN trim(input fi_addr4) +                           /*ที่อยู่ลูกค้า4              */ 
                                               " Tel:" + TRIM(INPUT fi_tel)  ELSE trim(input fi_addr4)
                     brstat.tlt.dri_name1    = IF trim(input fi_driv1) <> "" THEN 
                                               trim(input fi_driv1)  +            /*ระบุผู้ขับขี้1             */    
                                               " ID1 " + trim(input fi_drivid1) +        /*เลขที่ใบขับขี่1            */  
                                               " Licen1 " + TRIM(INPUT fi_drivic1)
                                               ELSE ""
                     brstat.tlt.dri_no1      = IF (INPUT fi_birth1) <> "" THEN SUBSTR(INPUT fi_birth1,7,4) + SUBSTR(INPUT fi_birth1,4,2) 
                                               + SUBSTR(INPUT fi_birth1,1,2) ELSE ""  /*วันเดือนปีเกิด1            */                                                
                     brstat.tlt.dri_name2    = IF trim(INPUT fi_driv2) <> "" THEN
                                               trim(INPUT fi_driv2)  +  /*ระบุผู้ขับขี้2             */     
                                               " ID2 " +  trim(INPUT fi_drivid2) + /*เลขที่ใบขับขี่2            */ 
                                               " Licen2 " +  TRIM(INPUT fi_drivic2) 
                                               ELSE ""
                     brstat.tlt.dri_no2      = IF (INPUT fi_birth1) <> "" THEN SUBSTR(INPUT fi_birth2,7,4) + SUBSTR(INPUT fi_birth2,4,2) 
                                               + SUBSTR(INPUT fi_birth2,1,2) ELSE ""       /*วันเดือนปีเกิด2*/                                                             
                     brstat.tlt.safe3        = "Class72 " + trim(input fi_client)  +    /*class72          */ 
                                               " Class70 " + trim(input fi_class)       /*class70          */                                                                    
                     brstat.tlt.safe1        = trim(input fi_benname) +   /*ผู้รับผลประโยชน์*/                                                            
                                               " Delear " + trim(input fi_dealer)     /*ดีลเลอร์ */                                                                   
                     brstat.tlt.usrid        = trim(INPUT fi_userid)          /*User Load Data */                                                             
                     brstat.tlt.EXP          = INPUT fi_branch               /*สาขา           */                                                             
                     brstat.tlt.old_eng      = trim(input fi_tp1)             /*ประเภทรถ       */                                                             
                     brstat.tlt.old_cha      = trim(input fi_tp2)             /*วันที่จดทะเบียน*/                                                             
                     brstat.tlt.comp_pol     = trim(input fi_compol)          /*เลขกรมธรรม์พรบ */                                                             
                     brstat.tlt.expousr      = "inttyp " + trim(input fi_covcod)  +  /*ประเภทประกัน   */                                                             
                                               " covtyp " + trim(input fi_covcod2)  /*ความคุ้มครอง */                                                                 
                     brstat.tlt.comp_sub     = trim(input fi_producer)    /* produer code */                                                              
                     brstat.tlt.comp_noti_ins= trim(input fi_agent)       /* Agent */                                                                     
                     brstat.tlt.filler2      = trim(input fi_remark1) + trim(INPUT fi_remark2)   /*หมายเหตุ  */                                
                     brstat.tlt.rec_name     = trim(input fi_title)                          /*คำนำหน้าชื่อผู้เอาประกันภัย */                                               
                     /*brstat.tlt.recac        = trim(input fi_status)*/                                                      
                     /*brstat.tlt.dat_ins_noti = INPUT fi_paydate  */                                                                                              
                     brstat.tlt.ins_addr5    = "ICNO " + trim(input fi_icno)  +    /*IC No */ 
                                        " Occ " + trim(input fi_occ )      /*อาชีพ */ 
                     brstat.tlt.nor_noti_ins = input fi_polsystem            /* เบอร์กรมธรรม์ใหม่ */                                                                   
                     /*brstat.tlt.releas       = input fi_polstatus */                                                  
                     brstat.tlt.ins_name     = trim(INPUT fi_firstname) + " " + TRIM(INPUT fi_lastname)                             
                     brstat.tlt.filler1      = trim(input fi_policy)     /* กรมธรรม์เดิม*/                                                                      
                     brstat.tlt.rec_addr3    = trim(input fi_pro_off)   /*บริษัท  */                                                                               
                     brstat.tlt.rec_addr4    = STRING(INPUT fi_compprm)    /*เบี้ยรวมพรบ  */                                                                          
                     brstat.tlt.safe2        = TRIM(input fi_accno)          /*เลขที่สัญญา  */                                                                          
                     brstat.tlt.nor_noti_tlt = TRIM(input fi_notno)          /*เลขที่รับแจ้ง*/                                                                          
                     brstat.tlt.lince2       = TRIM(input fi_year )          /*ปี           */                                                                          
                     brstat.tlt.eng_no       = TRIM(input fi_eng_no)         /*เลขเครื่อง   */                                                                          
                     brstat.tlt.cha_no       = TRIM(input fi_cha_no)         /*เลขถัง       */                                                                          
                     brstat.tlt.cc_weight    = INPUT fi_ton            /*ขนาดเครื่อง  */                                                                          
                     brstat.tlt.lince1       = TRIM(INPUT fi_licence)      /*เลขทะเบียน   */   
                     brstat.tlt.rec_addr1    = trim(input fi_vatcode)            /* Vatcode */
                     brstat.tlt.rec_addr2    = trim(input fi_recname) 
                     brstat.tlt.rec_addr5    = trim(input fi_recadd) 
                     brstat.tlt.lotno        = TRIM(INPUT fi_camp). /*A60-0263*/
            END.
            Apply "Close" to this-procedure.
            Return no-apply.
        END.
        WHEN FALSE THEN /* No */          
            DO:   
            APPLY "entry" TO fi_covcod.
            RETURN NO-APPLY.
        END.
        END CASE.
RELEASE brstat.tlt.
Disp  fi_covcod with  frame  fr_main.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_accno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_accno C-Win
ON LEAVE OF fi_accno IN FRAME fr_main
DO:
  fi_accno = INPUT fi_accno.
  DISP fi_accno WITH FRAM fr_main.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_addr1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_addr1 C-Win
ON LEAVE OF fi_addr1 IN FRAME fr_main
DO:
  fi_addr1 = INPUT fi_addr1 .
  DISP fi_addr1 WITH FRAM fr_main.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_addr2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_addr2 C-Win
ON LEAVE OF fi_addr2 IN FRAME fr_main
DO:
  fi_addr2 = INPUT fi_addr2 .
  DISP fi_addr2 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_addr3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_addr3 C-Win
ON LEAVE OF fi_addr3 IN FRAME fr_main
DO:
  fi_addr3 = INPUT fi_addr3 .
  DISP fi_addr3 WITH FRAM fr_main.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_addr4
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_addr4 C-Win
ON LEAVE OF fi_addr4 IN FRAME fr_main
DO:
    fi_addr4 = INPUT fi_addr4.
    DISP fi_addr4 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_agent
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_agent C-Win
ON LEAVE OF fi_agent IN FRAME fr_main
DO:
  fi_agent = INPUT fi_agent .
  DISP fi_agent WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_benname
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_benname C-Win
ON LEAVE OF fi_benname IN FRAME fr_main
DO:
  fi_benname = INPUT fi_benname .
  DISP fi_benname WITH FRAM fr_main.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_birth1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_birth1 C-Win
ON LEAVE OF fi_birth1 IN FRAME fr_main
DO:
  fi_birth1 = INPUT fi_birth1.
  DISPLAY fi_birth1 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_birth2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_birth2 C-Win
ON LEAVE OF fi_birth2 IN FRAME fr_main
DO:
  fi_birth2 = INPUT fi_birth2 .
  DISP fi_birth2 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_branch
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_branch C-Win
ON LEAVE OF fi_branch IN FRAME fr_main
DO:
  fi_branch = INPUT fi_branch.
  DISP fi_branch WITH FRAM fr_main.
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


&Scoped-define SELF-NAME fi_camp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_camp C-Win
ON LEAVE OF fi_camp IN FRAME fr_main
DO:
    /*A60-0263*/
    fi_camp = INPUT fi_camp .
    DISP fi_camp WITH FRAM fr_main.
     /*A60-0263*/
  
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


&Scoped-define SELF-NAME fi_class
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_class C-Win
ON LEAVE OF fi_class IN FRAME fr_main
DO:
  fi_class = INPUT fi_class.
  DISP fi_class WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_client
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_client C-Win
ON LEAVE OF fi_client IN FRAME fr_main
DO:
  fi_client = INPUT fi_client.
  DISP fi_client WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_comdat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_comdat C-Win
ON LEAVE OF fi_comdat IN FRAME fr_main
DO:
  fi_comdat = INPUT fi_comdat.
  DISP fi_comdat WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_comdat72
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_comdat72 C-Win
ON LEAVE OF fi_comdat72 IN FRAME fr_main
DO:
  fi_comdat72 = INPUT fi_comdat72.
  DISP fi_comdat72 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_compol
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_compol C-Win
ON LEAVE OF fi_compol IN FRAME fr_main
DO:
  fi_compol  =  Input  fi_compol.
  Disp  fi_compol with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_compprm
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_compprm C-Win
ON LEAVE OF fi_compprm IN FRAME fr_main
DO:
  fi_compprm = INPUT fi_compprm.
  DISP fi_compprm WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_comprem
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_comprem C-Win
ON LEAVE OF fi_comprem IN FRAME fr_main
DO:
    fi_comprem = INPUT fi_comprem  .
    DISP fi_comprem WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_covcod
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_covcod C-Win
ON LEAVE OF fi_covcod IN FRAME fr_main
DO:
    fi_covcod = INPUT fi_covcod .
    DISP fi_covcod WITH FRAM fr_main.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_dealer
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_dealer C-Win
ON LEAVE OF fi_dealer IN FRAME fr_main
DO:
  fi_dealer =  Input  fi_dealer.
  Disp  fi_dealer with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_driv1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_driv1 C-Win
ON LEAVE OF fi_driv1 IN FRAME fr_main
DO:
    fi_driv1 = INPUT fi_driv1 .
    DISP fi_driv1 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_driv2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_driv2 C-Win
ON LEAVE OF fi_driv2 IN FRAME fr_main
DO:
  fi_driv2 = INPUT fi_driv2.
  DISP fi_driv2 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_drivic1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_drivic1 C-Win
ON LEAVE OF fi_drivic1 IN FRAME fr_main
DO:
    fi_drivic1 = INPUT fi_drivic1 .
    DISP fi_drivic1 WITH FRAM fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_drivic2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_drivic2 C-Win
ON LEAVE OF fi_drivic2 IN FRAME fr_main
DO:
    fi_drivic2 = INPUT fi_drivic2 .
    DISP fi_drivic2 WITH FRAM fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_drivid1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_drivid1 C-Win
ON LEAVE OF fi_drivid1 IN FRAME fr_main
DO:
  fi_drivid1 = INPUT fi_drivid1 .
    DISP fi_drivid1 WITH FRAM fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_drivid2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_drivid2 C-Win
ON LEAVE OF fi_drivid2 IN FRAME fr_main
DO:
  fi_drivid2 = INPUT fi_drivid2 .
    DISP fi_drivid2 WITH FRAM fr_main.
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
  fi_comdat72 = INPUT fi_comdat72.
  DISP fi_comdat72 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_FI
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_FI C-Win
ON LEAVE OF fi_FI IN FRAME fr_main
DO:
  fi_fi =  Input  fi_fi.
  Disp  fi_fi with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_firstname
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_firstname C-Win
ON LEAVE OF fi_firstname IN FRAME fr_main
DO:
  fi_firstname = INPUT fi_firstname .
  DISP fi_firstname WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_garage
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_garage C-Win
ON LEAVE OF fi_garage IN FRAME fr_main
DO:
  fi_garage =  Input  fi_garage.
  Disp  fi_garage with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_gross_amt
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_gross_amt C-Win
ON LEAVE OF fi_gross_amt IN FRAME fr_main
DO:
  fi_gross_amt = INPUT fi_gross_amt.
  DISP fi_gross_amt WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_icno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_icno C-Win
ON LEAVE OF fi_icno IN FRAME fr_main
DO:
    fi_icno = INPUT fi_icno .
    DISP fi_icno WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_inspace
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_inspace C-Win
ON LEAVE OF fi_inspace IN FRAME fr_main
DO:
    fi_inspace = trim(INPUT fi_inspace) .
    DISP fi_inspace WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_ins_off
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_ins_off C-Win
ON LEAVE OF fi_ins_off IN FRAME fr_main
DO:
  fi_ins_off = INPUT fi_ins_off .
  DISP fi_ins_off WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_lastname
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_lastname C-Win
ON LEAVE OF fi_lastname IN FRAME fr_main
DO:
    fi_lastname = INPUT fi_lastname .
    DISP fi_lastname WITH FRAM fr_main.
  
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


&Scoped-define SELF-NAME fi_notcode
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_notcode C-Win
ON LEAVE OF fi_notcode IN FRAME fr_main
DO:
  fi_notcode = INPUT fi_notcode .
  DISP fi_notcode WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_notno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_notno C-Win
ON LEAVE OF fi_notno IN FRAME fr_main
DO:
  fi_notno = INPUT fi_notno .
  DISP fi_notno WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_occ
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_occ C-Win
ON LEAVE OF fi_occ IN FRAME fr_main
DO:
  fi_occ = INPUT fi_occ .
  DISP fi_occ WITH FRAM fr_main.
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


&Scoped-define SELF-NAME fi_prem1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_prem1 C-Win
ON LEAVE OF fi_prem1 IN FRAME fr_main
DO:
  fi_prem1 = INPUT fi_prem1 .
  DISP fi_prem1 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_producer
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_producer C-Win
ON LEAVE OF fi_producer IN FRAME fr_main
DO:
  fi_producer = INPUT fi_producer .
  DISP fi_producer WITH FRAM fr_main.

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


&Scoped-define SELF-NAME fi_pro_off
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_pro_off C-Win
ON LEAVE OF fi_pro_off IN FRAME fr_main
DO:
  fi_pro_off = INPUT fi_pro_off.
  DISP fi_pro_off WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_recadd
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_recadd C-Win
ON LEAVE OF fi_recadd IN FRAME fr_main
DO:
    fi_recadd = trim(INPUT fi_recadd).
    DISP fi_recadd with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_recname
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_recname C-Win
ON LEAVE OF fi_recname IN FRAME fr_main
DO:
    fi_recname = trim(INPUT fi_recname).
    DISP fi_recname with frame  fr_main.
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


&Scoped-define SELF-NAME fi_sckno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_sckno C-Win
ON LEAVE OF fi_sckno IN FRAME fr_main
DO:
  fi_sckno = INPUT fi_sckno .
  DISP fi_sckno WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_sumsi
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_sumsi C-Win
ON LEAVE OF fi_sumsi IN FRAME fr_main
DO:
    fi_sumsi = INPUT fi_sumsi.
    DISP fi_sumsi WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_title
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_title C-Win
ON LEAVE OF fi_title IN FRAME fr_main
DO:
  fi_title = INPUT fi_title.
  DISP fi_title WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_ton
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_ton C-Win
ON LEAVE OF fi_ton IN FRAME fr_main
DO:
  fi_ton  =  Input  fi_ton.
  Disp  fi_ton with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_tp1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_tp1 C-Win
ON LEAVE OF fi_tp1 IN FRAME fr_main
DO:
    fi_tp1 = INPUT fi_tp1 .
    DISP fi_tp1 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_tp2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_tp2 C-Win
ON LEAVE OF fi_tp2 IN FRAME fr_main
DO:
    fi_tp2 = INPUT fi_tp2 .
    DISP fi_tp2 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_vehuse
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_vehuse C-Win
ON LEAVE OF fi_vehuse IN FRAME fr_main
DO:
  fi_vehuse =  Input  fi_vehuse.
  Disp  fi_vehuse with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_wht
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_wht C-Win
ON LEAVE OF fi_wht IN FRAME fr_main
DO:
  fi_wht =  Input  fi_wht.
  Disp  fi_wht with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_wht72
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_wht72 C-Win
ON LEAVE OF fi_wht72 IN FRAME fr_main
DO:
  fi_wht72 =  Input  fi_wht72.
  Disp  fi_wht72 with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_year
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_year C-Win
ON LEAVE OF fi_year IN FRAME fr_main
DO:
  fi_year = INPUT fi_year .
  DISP fi_year WITH FRAM fr_main.
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
  
  gv_prgid = "wgwqicb2".
  gv_prog  = "Query & Update Data  (ICBC) ".
  RUN  WUT\WUTHEAD ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).
/*********************************************************************/ 
 /*  RUN Wut\WutwiCen ({&WINDOW-NAME}:HANDLE). */ 
  /*CURRENT-WINDOW:WINDOW-STATE = WINDOW-MAXIMIZED.*/
  SESSION:DATA-ENTRY-RETURN = YES.
  
  Find  brstat.tlt  Where  Recid(brstat.tlt)  =  nv_recidtlt NO-LOCK NO-ERROR NO-WAIT .
  If  avail  brstat.tlt  Then do:
         RUN proc_assignfi.
         DISP                                                                                                     
         fi_type      fi_ldate     fi_ltime     fi_trndat    fi_pro_off   fi_comprem                              
         fi_accno     fi_notno     fi_year      fi_eng_no    fi_cha_no    fi_ton       
         fi_licence   fi_garage    fi_province  fi_brand     fi_sckno     fi_sumsi     
         fi_gross_amt fi_prem1     fi_compprm   fi_fi        fi_wht       fi_dealer
         fi_vehuse    fi_comdat    fi_expdat    fi_comdat72  fi_expdat72  fi_covcod2  
         fi_ins_off   fi_notcode   fi_addr1     fi_addr2     fi_addr3     fi_addr4     
         fi_driv1     fi_drivid1   fi_birth1    fi_driv2     fi_drivid2   fi_birth2    
         fi_client    fi_class     fi_benname   fi_userid    fi_branch    fi_tp1       
         fi_tp2       fi_compol    fi_covcod    fi_occ       fi_policy    fi_drivic1
         fi_producer  fi_agent     fi_remark1   fi_remark2   fi_title     fi_firstname 
         fi_lastname  fi_icno      fi_polsystem fi_status    fi_wht72     fi_drivic2
         fi_paydate   fi_polstatus fi_tel       fi_inspace   fi_recname   fi_recadd  
         fi_vatcode   fi_desbran   fi_camp /*A60-0263*/ With frame  fr_main.    
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
  DISPLAY fi_vatcode fi_desbran fi_tel fi_policy fi_covcod2 fi_occ fi_type 
          fi_polstatus fi_paydate fi_status fi_polsystem fi_compol fi_producer 
          fi_agent fi_pro_off fi_branch fi_notno fi_accno fi_comprem fi_notcode 
          fi_ins_off fi_brand fi_vehuse fi_year fi_ton fi_eng_no fi_cha_no 
          fi_licence fi_province fi_covcod fi_tp1 fi_dealer fi_FI fi_wht 
          fi_comdat fi_expdat fi_sumsi fi_gross_amt fi_comdat72 fi_expdat72 
          fi_compprm fi_sckno fi_prem1 fi_garage fi_tp2 fi_title fi_firstname 
          fi_lastname fi_icno fi_addr1 fi_addr2 fi_addr3 fi_addr4 fi_driv1 
          fi_birth1 fi_drivid1 fi_driv2 fi_birth2 fi_drivid2 fi_benname 
          fi_client fi_remark1 fi_remark2 fi_ldate fi_ltime fi_trndat fi_userid 
          fi_wht72 fi_class fi_drivic1 fi_drivic2 fi_inspace fi_recname 
          fi_recadd fi_camp 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE fi_vatcode fi_tel fi_policy fi_covcod2 fi_occ fi_polstatus 
         fi_polsystem fi_compol fi_producer fi_agent fi_pro_off fi_branch 
         fi_notno fi_accno fi_comprem fi_notcode fi_ins_off fi_brand fi_vehuse 
         fi_year fi_ton fi_eng_no fi_cha_no fi_licence fi_province fi_covcod 
         fi_tp1 fi_dealer fi_FI fi_wht fi_comdat fi_expdat fi_sumsi 
         fi_gross_amt fi_comdat72 fi_expdat72 fi_compprm fi_sckno fi_prem1 
         fi_garage fi_tp2 fi_title fi_firstname fi_lastname fi_icno fi_addr1 
         fi_addr2 fi_addr3 fi_addr4 fi_driv1 fi_birth1 fi_drivid1 fi_driv2 
         fi_birth2 fi_drivid2 fi_benname fi_client fi_remark1 fi_remark2 
         bu_save bu_exit fi_wht72 fi_class fi_drivic1 fi_drivic2 fi_inspace 
         fi_recname fi_recadd fi_camp RECT-335 RECT-381 RECT-382 RECT-383 
         RECT-385 RECT-386 
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
Assign
          fi_type       = IF brstat.tlt.flag = "N" THEN "NEW" ELSE "RENEW"
          fi_ldate      = brstat.tlt.entdat              /* วันที่โหลด */  
          fi_ltime      = brstat.tlt.enttim              /* เวลาโหลด   */  
          fi_trndat     = brstat.tlt.trndat              /* วันที่ไฟล์แจ้งงาน */ 
          /*-- comment by A60-0263---
          fi_garage     = IF index(brstat.tlt.stat,"inspace") <> 0 THEN SUBSTR(brstat.tlt.stat,1,INDEX(brstat.tlt.stat,"inspace:") - 8 ) ELSE TRIM(brstat.tlt.stat)
          fi_inspace    = IF index(brstat.tlt.stat,"inspace") <> 0 THEN SUBSTR(brstat.tlt.stat,R-INDEX(brstat.tlt.stat,"inspace:") + 8 ,LENGTH(brstat.tlt.stat))
                          ELSE ""                     /*สถานที่ซ่อม      */  
          --- end A60-0263----*/ 
          fi_inspace    = IF index(brstat.tlt.stat,"Inspace:") <> 0 THEN SUBSTR(brstat.tlt.stat,R-INDEX(brstat.tlt.stat,"Inspace:") + 8 ,LENGTH(brstat.tlt.stat)) /*A60-0263*/
                          ELSE ""                      /*สถานที่ซ่อม      */                                                                                      /*A60-0263*/
          fi_garage     = IF index(brstat.tlt.stat,"Inspace:") <> 0 THEN SUBSTR(brstat.tlt.stat,1,LENGTH(brstat.tlt.stat) - (LENGTH(fi_inspace) + 8))             /*A60-0263*/
                          ELSE TRIM(brstat.tlt.stat)                                                          
          fi_province   = brstat.tlt.lince3              /*จังหวัด          */                                                                                             
          fi_brand      = brstat.tlt.brand               /*ยี่ห้อ           */                                                                                                      
          fi_sckno      = brstat.tlt.comp_sck            /*เลขที่สติ๊กเกอร์ */                                                                                             
          fi_sumsi      = brstat.tlt.nor_coamt           /*ทุนประกัน        */                                                                                                  
          fi_gross_amt  = brstat.tlt.comp_coamt          /*เบี้ยรวมกธ       */                                                                                                  
          fi_prem1      = brstat.tlt.nor_grprm           /*เบี้ยสุทธิกธ.    */                                                                                                  
          fi_comprem    = brstat.tlt.comp_grprm          /*เบี้ยรวมพรบ.    */                                                                                        
          fi_vehuse     = brstat.tlt.model               /*รุ่น             */                                                                                                   
          fi_comdat     = brstat.tlt.gendat              /*วันที่เริ่มคุ้มครอง     */                                                                                            
          fi_expdat     = brstat.tlt.expodat             /*วันที่สิ้นสุดคุ้มครอง   */ 
          fi_comdat72   = brstat.tlt.comp_effdat         /*วันทีเริ่มคุ้มครองพรบ   */  
          fi_expdat72   = brstat.tlt.nor_effdat          /*วันที่สิ้นสุดคุ้มครองพรบ*/  
          fi_ins_off    = brstat.tlt.nor_usr_ins         /*ผู้แจ้ง                 */                                                                                                  
          fi_notcode    = brstat.tlt.comp_usr_tlt        /*ระยุผู้ขับขี่           */                                                                                            
          fi_addr1      = brstat.tlt.ins_addr1           /*ที่อยู่ลูกค้า 1         */                                                                                                     
          fi_addr2      = brstat.tlt.ins_addr2           /*ที่อยู่ลูกค้า  2        */ 
          fi_addr3      = brstat.tlt.ins_addr3           /*ที่อยู่ลูกค้า3          */ 
          fi_tel        = IF INDEX(brstat.tlt.ins_addr4,"Tel") <> 0 THEN SUBSTR(brstat.tlt.ins_addr4,R-INDEX(brstat.tlt.ins_addr4," tel") + 5,LENGTH(brstat.tlt.ins_addr4))
                          ELSE ""  /*เบอร์โทร */
          fi_addr4      = IF fi_tel <> ""  THEN substr(brstat.tlt.ins_addr4,1,LENGTH(brstat.tlt.ins_addr4) - (LENGTH(fi_tel) + 5)) 
                          ELSE IF TRIM(brstat.tlt.ins_addr4) <> "Tel:" THEN trim(brstat.tlt.ins_addr4) ELSE ""        /*ที่อยู่ลูกค้า4          */ 
          fi_policy     = brstat.tlt.filler1             /* กรมธรรม์เดิม*/       
          fi_pro_off    = brstat.tlt.rec_addr3           /*บริษัท  */            
          fi_compprm    = DECI(brstat.tlt.rec_addr4)     /*เบี้ยสุทธิพรบ  */       
          fi_accno      = brstat.tlt.safe2               /*เลขที่สัญญา  */       
          fi_notno      = brstat.tlt.nor_noti_tlt        /*เลขที่รับแจ้ง*/       
          fi_year       = brstat.tlt.lince2              /*ปี           */       
          fi_eng_no     = brstat.tlt.eng_no              /*เลขเครื่อง   */       
          fi_cha_no     = brstat.tlt.cha_no              /*เลขถัง       */       
          fi_ton        = brstat.tlt.cc_weight           /*ขนาดเครื่อง  */       
          fi_licence    = brstat.tlt.lince1              /*เลขทะเบียน   */      
          fi_userid     = brstat.tlt.usrid               /*User Load Data */                                                                                    
          fi_branch     = STRING(brstat.tlt.EXP)         /*สาขา           */                                
          fi_tp1        = brstat.tlt.old_eng             /*ประเภทรถ       */                                                                                                        
          fi_tp2        = brstat.tlt.old_cha             /*วันที่จดทะเบียน*/                                                                                                      
          fi_compol     = brstat.tlt.comp_pol            /*เลขกรมธรรม์พรบ */  
          fi_producer   = brstat.tlt.comp_sub            /* produer code */                                                                                               
          fi_agent      = brstat.tlt.comp_noti_ins       /* Agent */ 
          fi_vatcode    = brstat.tlt.rec_addr1               /* Vatcode */
          fi_recname    = brstat.tlt.rec_addr2
          fi_recadd     = brstat.tlt.rec_addr5
          fi_camp       = brstat.tlt.lotno        /*A60-0263*/
          fi_remark1    = IF LENGTH(brstat.tlt.filler2) <> 0  then SUBSTR(brstat.tlt.filler2,1,80)  else ""     /*หมายเหตุ  */                                
          fi_remark2    = IF LENGTH(brstat.tlt.filler2) > 80  then SUBSTR(brstat.tlt.filler2,81,80) else ""     /*หมายเหตุ  */
          fi_title      = brstat.tlt.rec_name                          /*คำนำหน้าชื่อผู้เอาประกันภัย */
          fi_status     = IF brstat.tlt.recac = "" THEN "ยังไม่Confirm " ELSE brstat.tlt.recac
          fi_paydate    = brstat.tlt.dat_ins_noti       /*วันที่ matchfile confirm */
          fi_polsystem  = brstat.tlt.nor_noti_ins           /* เบอร์กรมธรรม์ใหม่ */ 
          fi_polstatus  = IF brstat.tlt.releas = "NO" THEN "ยังไม่ออกงาน" ELSE IF INDEX(brstat.tlt.releas,"Cancel") <> 0 THEN "ยกเลิก" ELSE "ออกงานแล้ว"
          nv_index      = Index(brstat.tlt.ins_name," ")      /* ชื่อ */                          
          fi_firstname  = IF index(fi_title,"บจก") <> 0 AND index(fi_title,"มูลนิธิ") <> 0 AND  
                          index(fi_title,"หจก") <> 0 AND  index(fi_title,"บริษัท") <> 0 THEN 
                          TRIM(brstat.tlt.ins_name)  ELSE Substr(brstat.tlt.ins_name,1,R-INDEX(brstat.tlt.ins_name," "))               
          fi_lastname   = IF index(fi_title,"บจก") <> 0 AND index(fi_title,"มูลนิธิ") <> 0 AND  
                          index(fi_title,"หจก") <> 0 AND  index(fi_title,"บริษัท") <> 0 THEN ""
                          ELSE Substr(brstat.tlt.ins_name,R-INDEX(brstat.tlt.ins_name," ") + 1,length(brstat.tlt.ins_name)).
          IF fi_branch <> "" THEN DO:
              IF INDEX(fi_branch,"1") <> 0 THEN ASSIGN fi_desbran = "สำนักงานใหญ่".
              ELSE IF INDEX(fi_branch,"2") <> 0 THEN ASSIGN fi_desbran = "นครปฐม".
              ELSE IF INDEX(fi_branch,"3") <> 0 THEN ASSIGN fi_desbran = "ลพบุรี".
              ELSE IF INDEX(fi_branch,"4") <> 0 THEN ASSIGN fi_desbran = "นครราชสีมา".
              ELSE IF INDEX(fi_branch,"5") <> 0 THEN ASSIGN fi_desbran = "ชลบุรี".
              ELSE IF INDEX(fi_branch,"6") <> 0 THEN ASSIGN fi_desbran = "เชียงใหม่".
              ELSE IF INDEX(fi_branch,"7") <> 0 THEN ASSIGN fi_desbran = "พิษณุโลก".
              ELSE IF INDEX(fi_branch,"8") <> 0 THEN ASSIGN fi_desbran = "ขอนแก่น".
          END.
          ELSE ASSIGN fi_desbran = "".

          IF brstat.tlt.dri_name1 <> "" THEN DO:
              ASSIGN
                n_char        = trim(brstat.tlt.dri_name1) /* ผู้ขับขี่ 1 */
                n_length      = LENGTH(n_char)
                fi_drivic1    = Trim(SUBSTR(n_char,R-INDEX(n_char,"Licen1") + 7,n_length)) /* เลขบัตรผู้ขับขี่1 */
                n_char        = Trim(SUBSTR(n_char,1,R-INDEX(n_char,"Licen1") - 1))
                n_length      = LENGTH(n_char)
                fi_driv1      = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"ID1") - 2))         /*ระบุผู้ขับขี้1    */  
                fi_drivid1    = TRIM(SUBSTR(n_char,R-INDEX(n_char,"ID1") + 3,n_length))  /*เลขที่ใบขับขี่1   */ 
                fi_birth1     = IF brstat.tlt.dri_no1 <> "" THEN SUBSTR(brstat.tlt.dri_no1,7,2) + "/" + 
                                                                 SUBSTR(brstat.tlt.dri_no1,5,2) + "/" + 
                                                                 SUBSTR(brstat.tlt.dri_no1,1,4)  ELSE "" .  /*วันเดือนปีเกิด1   */ 
          END.
          ELSE ASSIGN fi_drivic1   = ""     fi_driv1     = ""
                      fi_drivid1   = ""     fi_birth1    = "".
          IF brstat.tlt.dri_name2 <> "" THEN DO:
              ASSIGN 
                n_char        = trim(brstat.tlt.dri_name2)  /*ผู้ขับขี่ 2*/ 
                n_length      = LENGTH(n_char)
                fi_drivic2    = Trim(SUBSTR(n_char,R-INDEX(n_char,"Licen2") + 7,n_length)) /* เลขบัตรผู้ขับขี่2*/
                n_char        = Trim(SUBSTR(n_char,1,R-INDEX(n_char,"Licen2") - 1))
                n_length      = LENGTH(n_char)
                fi_driv2      = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"ID2") - 2))          /*ระบุผู้ขับขี้2      */  
                fi_drivid2    = TRIM(SUBSTR(n_char,R-INDEX(n_char,"ID2") + 3,n_length))   /*เลขที่ใบขับขี่2     */ 
                fi_birth2     = IF brstat.tlt.dri_no2 <> "" THEN SUBSTR(brstat.tlt.dri_no2,7,2) + "/" + 
                                                                 SUBSTR(brstat.tlt.dri_no2,5,2) + "/" + 
                                                                 SUBSTR(brstat.tlt.dri_no2,1,4)  ELSE "" . /*วันเดือนปีเกิด2*/
          END.
          ELSE  ASSIGN fi_drivic2   = ""     fi_driv2     = ""    
                       fi_drivid2   = ""     fi_birth2    = "".  
         IF brstat.tlt.nor_usr_tlt <> "" THEN DO:
            ASSIGN
            n_char        = trim(brstat.tlt.nor_usr_tlt)
            n_length      = LENGTH(n_char)
            n_wht72       = IF INDEX(n_char,"wht72") <> 0 THEN trim(SUBSTR(n_char,INDEX(n_char,"wht72") + 5,n_length)) ELSE ""   /*wht 72*/
            n_char        = IF INDEX(n_char,"wht72") <> 0 THEN SUBSTR(n_char,1,INDEX(n_char,"wht72") - 1) ELSE SUBSTR(n_char,1,n_length) 
            n_length      = LENGTH(n_char)
            n_wht70       = IF INDEX(n_char,"wht70") <> 0 THEN trim(SUBSTR(n_char,R-INDEX(n_char,"wht70") + 5,n_length)) ELSE ""    /*wht70              */
            n_fi          = IF INDEX(n_char,"wht70") <> 0 THEN trim(SUBSTR(n_char,3,R-INDEX(n_char,"wht70") - 3)) 
                            ELSE SUBSTR(n_char,3,n_length)        /*ทุนหาย           */
            fi_fi         = if n_fi    <> "" then  INT(TRIM(n_fi))     else 0
            fi_wht        = if n_wht70 <> "" then  deci(TRIM(n_wht70)) else 0
            fi_wht72      = if n_wht72 <> "" then  deci(TRIM(n_wht72)) else 0  .
          END.
          ELSE  ASSIGN  fi_fi    = 0    fi_wht  = 0     fi_wht72  = 0 .
          ASSIGN        
          n_length      = LENGTH(brstat.tlt.safe3) 
          fi_class      = trim(substr(brstat.tlt.safe3,R-INDEX(brstat.tlt.safe3,"class70") + 7,n_length))  /*class70         */ 
          fi_client     = trim(substr(brstat.tlt.safe3,8,R-INDEX(brstat.tlt.safe3,"class70") - 8))        /*class72         */ 
          n_length      = LENGTH(brstat.tlt.safe1)                                                 
          fi_benname    = trim(SUBSTR(brstat.tlt.safe1,1,R-INDEX(brstat.tlt.safe1,"Delear") - 1))         /*ผู้รับผลประโยชน์*/      
          fi_dealer     = IF brstat.tlt.flag = "N" THEN trim(SUBSTR(brstat.tlt.safe1,R-INDEX(brstat.tlt.safe1,"Delear") + 7,n_length)) ELSE ""  /*ดีลเลอร์ */    
          n_length      = LENGTH(brstat.tlt.expousr)
          fi_covcod     = IF brstat.tlt.flag = "N" THEN trim(SUBSTR(brstat.tlt.expousr,7,R-INDEX(brstat.tlt.expousr,"Covtyp") - 8)) ELSE ""        /*ประเภทประกัน   */ 
          fi_covcod2    = trim(SUBSTR(brstat.tlt.expousr,R-INDEX(brstat.tlt.expousr,"Covtyp") + 6,n_length))     /*ความคุ้มครอง */ 
          n_length      = LENGTH(brstat.tlt.ins_addr5)                                                 
          fi_icno       = IF INDEX(brstat.tlt.ins_addr5,"Occ") <> 0 THEN trim(SUBSTR(brstat.tlt.ins_addr5,5,R-INDEX(brstat.tlt.ins_addr5,"Occ") - 6)) 
                          ELSE trim(SUBSTR(brstat.tlt.ins_addr5,5,LENGTH(brstat.tlt.ins_addr5)))           /*IC No */
          fi_occ        = IF INDEX(brstat.tlt.ins_addr5,"Occ") <> 0 THEN trim(SUBSTR(brstat.tlt.ins_addr5,R-INDEX(brstat.tlt.ins_addr5,"Occ") + 3,n_length))  ELSE "" .  /*อาชีพ */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

