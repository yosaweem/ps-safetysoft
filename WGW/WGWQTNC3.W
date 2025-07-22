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
  wgwqtnc2.w :  Quey & Update , Add data in table  tlt (Thanachat) New
  Create  by    :  Ranu i. A63-0174 Query Data New
-------------------------------------------------------------------------*/

Def  Input  parameter  nv_recidtlt  as  recid  .
Def  var nv_index  as int  init 0.
DEF  VAR nv_chaidrep AS CHAR . /*A57-0262*/
DEF VAR n_length    AS INT .
DEF VAR n_exp       AS CHAR FORMAT "x(15)".
DEF VAR n_IC        AS CHAR FORMAT "x(15)".
DEF VAR n_Com       AS CHAR FORMAT "x(15)".
DEF VAR n_addr5     AS CHAR FORMAT "x(50)".

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS fi_polstatus fi_cartype fi_policy fi_compol ~
fi_producer fi_agent fi_pro_off fi_branch fi_notno fi_accno fi_notiname ~
fi_notdat fi_notcode fi_ins_off fi_brand fi_model fi_year fi_ton fi_eng_no ~
fi_cha_no fi_licence fi_typcomp fi_covcod fi_typcar fi_not_off fi_drive ~
fi_dealer fi_price1 fi_price fi_comdat fi_expdat fi_sumsi fi_gross_amt ~
fi_compprm fi_sckno fi_prem1 fi_garage fi_comment fi_title fi_firstname ~
fi_lastname fi_icno fi_addr1 fi_addr2 fi_addrs1 fi_addrs2 fi_driv1 ~
fi_birth1 fi_drivid1 fi_drivic1 fi_driv2 fi_birth2 fi_drivid2 fi_drivic2 ~
fi_benname fi_typpol fi_remark1 fi_remark2 bu_save bu_exit fi_error ~
fi_taxno fi_seat fi_name2 fi_poltyp fi_mkbr fi_group fi_tel fi_tels ~
fi_color fi_caruse fi_othcar fi_coderb fi_doctyp fi_taxre fi_brtax ~
fi_model2 RECT-335 RECT-381 RECT-382 RECT-383 RECT-384 RECT-385 
&Scoped-Define DISPLAYED-OBJECTS fi_polstatus fi_reldate fi_cartype ~
fi_policy fi_compol fi_producer fi_agent fi_pro_off fi_branch fi_notno ~
fi_accno fi_notiname fi_notdat fi_notcode fi_ins_off fi_brand fi_model ~
fi_year fi_ton fi_eng_no fi_cha_no fi_licence fi_typcomp fi_covcod ~
fi_typcar fi_not_off fi_drive fi_dealer fi_price1 fi_price fi_comdat ~
fi_expdat fi_sumsi fi_gross_amt fi_compprm fi_sckno fi_prem1 fi_garage ~
fi_comment fi_title fi_firstname fi_lastname fi_icno fi_addr1 fi_addr2 ~
fi_addrs1 fi_addrs2 fi_driv1 fi_birth1 fi_drivid1 fi_drivic1 fi_driv2 ~
fi_birth2 fi_drivid2 fi_drivic2 fi_benname fi_typpol fi_remark1 fi_remark2 ~
fi_userid fi_ldate fi_ltime fi_trndat fi_error fi_taxno fi_seat fi_name2 ~
fi_poltyp fi_mkbr fi_group fi_tel fi_tels fi_color fi_caruse fi_othcar ~
fi_coderb fi_doctyp fi_taxre fi_brtax fi_model2 

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
     SIZE 21.17 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_addr1 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 49.67 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_addr2 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 38.5 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_addrs1 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 49.67 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_addrs2 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 38.5 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_agent AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 14.17 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_benname AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 40.33 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_birth1 AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 13 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_birth2 AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 13 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_branch AS CHARACTER FORMAT "X(3)":U 
     VIEW-AS FILL-IN 
     SIZE 6.5 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_brand AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 17.83 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_brtax AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 16.5 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_cartype AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 12.5 BY 1
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_caruse AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 32 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_cha_no AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 23 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_coderb AS CHARACTER FORMAT "X(20)":U INITIAL ? 
     VIEW-AS FILL-IN 
     SIZE 6.67 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_color AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 13.17 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_comdat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 18.33 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_comment AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 63 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_compol AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 20 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_compprm AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 20.33 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_covcod AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 5.83 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_dealer AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 27.17 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_doctyp AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 19.83 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_driv1 AS CHARACTER FORMAT "X(60)":U 
     VIEW-AS FILL-IN 
     SIZE 30 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_driv2 AS CHARACTER FORMAT "X(60)":U 
     VIEW-AS FILL-IN 
     SIZE 30 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_drive AS CHARACTER FORMAT "X(30)":U INITIAL "0" 
     VIEW-AS FILL-IN 
     SIZE 12.83 BY .95
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
     SIZE 16.33 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_drivid2 AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 16.33 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_eng_no AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 23 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_error AS CHARACTER FORMAT "X(150)":U 
     VIEW-AS FILL-IN 
     SIZE 112.17 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_expdat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 18.17 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_firstname AS CHARACTER FORMAT "X(75)":U 
     VIEW-AS FILL-IN 
     SIZE 23.5 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_garage AS CHARACTER FORMAT "X(20)":U INITIAL ? 
     VIEW-AS FILL-IN 
     SIZE 12.17 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_gross_amt AS DECIMAL FORMAT "->>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 21.83 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_group AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 28.5 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_icno AS CHARACTER FORMAT "X(13)":U 
     VIEW-AS FILL-IN 
     SIZE 18.67 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_ins_off AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 24.67 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_lastname AS CHARACTER FORMAT "X(45)":U 
     VIEW-AS FILL-IN 
     SIZE 26.83 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_ldate AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 15.33 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_licence AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 18.33 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_ltime AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 11 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_mkbr AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 24 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_model AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 32 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_model2 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 41 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_name2 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 34.5 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_notcode AS CHARACTER FORMAT "X(3)":U 
     VIEW-AS FILL-IN 
     SIZE 6 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_notdat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_notiname AS CHARACTER FORMAT "X(35)":U 
     VIEW-AS FILL-IN 
     SIZE 24.67 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_notno AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 26.33 BY .95
     BGCOLOR 10 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_not_off AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 33.17 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_othcar AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 25 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_policy AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 20 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_polstatus AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 17.33 BY 1
     BGCOLOR 19 FGCOLOR 6 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_poltyp AS CHARACTER FORMAT "X(3)":U 
      VIEW-AS TEXT 
     SIZE 5 BY 1
     BGCOLOR 19 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_prem1 AS DECIMAL FORMAT "->>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 21.33 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_price AS DECIMAL FORMAT ">>,>>>,>>9.99":U INITIAL ? 
     VIEW-AS FILL-IN 
     SIZE 15.17 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_price1 AS DECIMAL FORMAT ">>,>>>,>>9.99-":U INITIAL ? 
     VIEW-AS FILL-IN 
     SIZE 18.5 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_producer AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_pro_off AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 22.67 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_reldate AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 16.5 BY 1
     BGCOLOR 19 FGCOLOR 6 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_remark1 AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 113.83 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_remark2 AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 113.83 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_sckno AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 17 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_seat AS INTEGER FORMAT ">>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 5.67 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_sumsi AS INTEGER FORMAT ">>>,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 20.17 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_taxno AS CHARACTER FORMAT "X(14)":U INITIAL ? 
     VIEW-AS FILL-IN 
     SIZE 17.33 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_taxre AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 24.17 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_tel AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_tels AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_title AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 11 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_ton AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 10.67 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_trndat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 15.17 BY .95
     BGCOLOR 10 FGCOLOR 4 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_typcar AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 30 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_typcomp AS CHARACTER FORMAT "X(35)":U 
     VIEW-AS FILL-IN 
     SIZE 20.67 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_typpol AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 23.17 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_userid AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 9 BY 1
     BGCOLOR 7 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_year AS CHARACTER FORMAT "X(4)":U INITIAL "0" 
     VIEW-AS FILL-IN 
     SIZE 7.33 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE RECTANGLE RECT-335
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 134 BY 29.71
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
     SIZE 132.5 BY 5.62
     BGCOLOR 29 .

DEFINE RECTANGLE RECT-384
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 132 BY 9.76.

DEFINE RECTANGLE RECT-385
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 132.17 BY 9.52.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     fi_polstatus AT ROW 28.62 COL 57.83 COLON-ALIGNED NO-LABEL
     fi_reldate AT ROW 28.57 COL 20 COLON-ALIGNED NO-LABEL
     fi_cartype AT ROW 13.62 COL 114.5 COLON-ALIGNED NO-LABEL
     fi_policy AT ROW 1.33 COL 65.5 COLON-ALIGNED NO-LABEL
     fi_compol AT ROW 1.33 COL 99.17 COLON-ALIGNED NO-LABEL
     fi_producer AT ROW 2.81 COL 93.33 COLON-ALIGNED NO-LABEL
     fi_agent AT ROW 2.86 COL 117.17 COLON-ALIGNED NO-LABEL
     fi_pro_off AT ROW 5.91 COL 56.33 COLON-ALIGNED NO-LABEL
     fi_branch AT ROW 3.86 COL 83.5 COLON-ALIGNED NO-LABEL
     fi_notno AT ROW 3.81 COL 42.67 COLON-ALIGNED NO-LABEL
     fi_accno AT ROW 5.91 COL 15.33 COLON-ALIGNED NO-LABEL
     fi_notiname AT ROW 4.86 COL 83.33 COLON-ALIGNED NO-LABEL
     fi_notdat AT ROW 3.86 COL 15.33 COLON-ALIGNED NO-LABEL
     fi_notcode AT ROW 4.86 COL 123.83 COLON-ALIGNED NO-LABEL
     fi_ins_off AT ROW 4.91 COL 15.33 COLON-ALIGNED NO-LABEL
     fi_brand AT ROW 9.48 COL 15.5 COLON-ALIGNED NO-LABEL
     fi_model AT ROW 9.48 COL 41.5 COLON-ALIGNED NO-LABEL
     fi_year AT ROW 9.43 COL 81.17 COLON-ALIGNED NO-LABEL
     fi_ton AT ROW 9.43 COL 117.33 COLON-ALIGNED NO-LABEL
     fi_eng_no AT ROW 10.52 COL 15.33 COLON-ALIGNED NO-LABEL
     fi_cha_no AT ROW 10.52 COL 50.17 COLON-ALIGNED NO-LABEL
     fi_licence AT ROW 10.48 COL 84.17 COLON-ALIGNED NO-LABEL
     fi_typcomp AT ROW 6.91 COL 89.83 COLON-ALIGNED NO-LABEL
     fi_covcod AT ROW 11.57 COL 15.33 COLON-ALIGNED NO-LABEL
     fi_typcar AT ROW 14.67 COL 15 COLON-ALIGNED NO-LABEL
     fi_not_off AT ROW 5.91 COL 94.67 COLON-ALIGNED NO-LABEL
     fi_drive AT ROW 22.91 COL 14.5 COLON-ALIGNED NO-LABEL
     fi_dealer AT ROW 6.91 COL 15.33 COLON-ALIGNED NO-LABEL
     fi_price1 AT ROW 11.52 COL 84.17 COLON-ALIGNED NO-LABEL
     fi_price AT ROW 11.48 COL 111.67 COLON-ALIGNED NO-LABEL
     fi_comdat AT ROW 12.57 COL 15.17 COLON-ALIGNED NO-LABEL
     fi_expdat AT ROW 12.57 COL 46.83 COLON-ALIGNED NO-LABEL
     fi_sumsi AT ROW 12.57 COL 77.33 COLON-ALIGNED NO-LABEL
     fi_gross_amt AT ROW 13.67 COL 55.67 COLON-ALIGNED NO-LABEL
     fi_compprm AT ROW 12.62 COL 106.5 COLON-ALIGNED NO-LABEL
     fi_sckno AT ROW 13.67 COL 89.5 COLON-ALIGNED NO-LABEL
     fi_prem1 AT ROW 13.62 COL 15.17 COLON-ALIGNED NO-LABEL
     fi_garage AT ROW 14.71 COL 94 COLON-ALIGNED NO-LABEL
     fi_comment AT ROW 15.71 COL 15 COLON-ALIGNED NO-LABEL
     fi_title AT ROW 18.71 COL 14.5 COLON-ALIGNED NO-LABEL
     fi_firstname AT ROW 18.71 COL 32.67 COLON-ALIGNED NO-LABEL
     fi_lastname AT ROW 18.62 COL 66.67 COLON-ALIGNED NO-LABEL
     fi_icno AT ROW 19.76 COL 14.5 COLON-ALIGNED NO-LABEL
     fi_addr1 AT ROW 20.81 COL 14.33 COLON-ALIGNED NO-LABEL
     fi_addr2 AT ROW 20.76 COL 71.5 COLON-ALIGNED NO-LABEL
     fi_addrs1 AT ROW 21.81 COL 14.33 COLON-ALIGNED NO-LABEL
     fi_addrs2 AT ROW 21.76 COL 71.5 COLON-ALIGNED NO-LABEL
     fi_driv1 AT ROW 23.91 COL 14.5 COLON-ALIGNED NO-LABEL
     fi_birth1 AT ROW 23.86 COL 54.17 COLON-ALIGNED NO-LABEL
     fi_drivid1 AT ROW 23.81 COL 79 COLON-ALIGNED NO-LABEL
     fi_drivic1 AT ROW 23.81 COL 105.5 COLON-ALIGNED NO-LABEL
     fi_driv2 AT ROW 24.91 COL 14.5 COLON-ALIGNED NO-LABEL
     fi_birth2 AT ROW 24.86 COL 54.17 COLON-ALIGNED NO-LABEL
     fi_drivid2 AT ROW 24.81 COL 79 COLON-ALIGNED NO-LABEL
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1.67 ROW 1.1
         SIZE 134.33 BY 29.9
         BGCOLOR 3 FGCOLOR 1 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     fi_drivic2 AT ROW 24.81 COL 105.5 COLON-ALIGNED NO-LABEL
     fi_benname AT ROW 22.81 COL 44 COLON-ALIGNED NO-LABEL
     fi_typpol AT ROW 6.91 COL 56.33 COLON-ALIGNED NO-LABEL
     fi_remark1 AT ROW 25.95 COL 16.67 NO-LABEL
     fi_remark2 AT ROW 26.91 COL 14.67 COLON-ALIGNED NO-LABEL
     bu_save AT ROW 28.86 COL 112.33
     bu_exit AT ROW 28.81 COL 123
     fi_userid AT ROW 1.33 COL 121.5 COLON-ALIGNED NO-LABEL
     fi_ldate AT ROW 2.81 COL 42.83 COLON-ALIGNED NO-LABEL
     fi_ltime AT ROW 2.81 COL 70.67 COLON-ALIGNED NO-LABEL
     fi_trndat AT ROW 2.86 COL 15.33 COLON-ALIGNED NO-LABEL
     fi_error AT ROW 16.71 COL 16.83 NO-LABEL
     fi_taxno AT ROW 19.76 COL 46.67 COLON-ALIGNED NO-LABEL
     fi_seat AT ROW 10.43 COL 111.83 COLON-ALIGNED NO-LABEL
     fi_name2 AT ROW 22.81 COL 96 COLON-ALIGNED NO-LABEL WIDGET-ID 2
     fi_poltyp AT ROW 1.29 COL 39 COLON-ALIGNED NO-LABEL WIDGET-ID 6
     fi_mkbr AT ROW 3.86 COL 100.83 COLON-ALIGNED NO-LABEL WIDGET-ID 10
     fi_group AT ROW 4.86 COL 45.5 COLON-ALIGNED NO-LABEL WIDGET-ID 14
     fi_tel AT ROW 20.76 COL 115.5 COLON-ALIGNED NO-LABEL WIDGET-ID 18
     fi_tels AT ROW 21.76 COL 115.5 COLON-ALIGNED NO-LABEL WIDGET-ID 22
     fi_color AT ROW 9.43 COL 92.33 COLON-ALIGNED NO-LABEL WIDGET-ID 26
     fi_caruse AT ROW 11.57 COL 41 COLON-ALIGNED NO-LABEL WIDGET-ID 32
     fi_othcar AT ROW 14.71 COL 59.67 COLON-ALIGNED NO-LABEL WIDGET-ID 36
     fi_coderb AT ROW 14.76 COL 120.33 COLON-ALIGNED NO-LABEL WIDGET-ID 40
     fi_doctyp AT ROW 18.62 COL 108.67 COLON-ALIGNED NO-LABEL WIDGET-ID 44
     fi_taxre AT ROW 19.67 COL 79.17 COLON-ALIGNED NO-LABEL WIDGET-ID 48
     fi_brtax AT ROW 19.57 COL 112 COLON-ALIGNED NO-LABEL WIDGET-ID 52
     fi_model2 AT ROW 15.76 COL 86 COLON-ALIGNED NO-LABEL WIDGET-ID 56
     "ฺ Birth :":30 VIEW-AS TEXT
          SIZE 7 BY .95 AT ROW 23.86 COL 48.83
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "เลขสติ๊กเกอร์ :":30 VIEW-AS TEXT
          SIZE 11.67 BY .95 AT ROW 13.67 COL 79.83
          BGCOLOR 19 FGCOLOR 0 FONT 1
     "โค้ดตลาดสาขา :":30 VIEW-AS TEXT
          SIZE 12.5 BY .91 AT ROW 3.91 COL 72.5
          BGCOLOR 19 FGCOLOR 2 FONT 1
     " เวลาโหลด  :":30 VIEW-AS TEXT
          SIZE 10.17 BY .95 AT ROW 2.81 COL 62.17
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "ที่นั่ง :":35 VIEW-AS TEXT
          SIZE 5.5 BY .95 AT ROW 10.48 COL 108.33
          BGCOLOR 19 FGCOLOR 0 FONT 1
     " ทุนประกัน  :":35 VIEW-AS TEXT
          SIZE 10.17 BY .95 AT ROW 12.57 COL 68.83
          BGCOLOR 19 FGCOLOR 0 FONT 1
     " ชื่อผู้แจ้ง  :":30 VIEW-AS TEXT
          SIZE 9 BY .95 AT ROW 4.86 COL 8
          BGCOLOR 19 FGCOLOR 2 FONT 1
     " IC NO :" VIEW-AS TEXT
          SIZE 8 BY .95 AT ROW 24.81 COL 99.17
          BGCOLOR 19 FGCOLOR 2 FONT 1
     " วันที่รับแจ้ง  :":30 VIEW-AS TEXT
          SIZE 11 BY .95 AT ROW 3.86 COL 5.5
          BGCOLOR 19 FGCOLOR 2 FONT 1
     " คำนำหน้าชื่อ :":30 VIEW-AS TEXT
          SIZE 11.83 BY .95 AT ROW 18.76 COL 3.33
          BGCOLOR 19 FGCOLOR 2 FONT 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1.67 ROW 1.1
         SIZE 134.33 BY 29.9
         BGCOLOR 3 FGCOLOR 1 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "รหัสประชาชน :":30 VIEW-AS TEXT
          SIZE 12 BY .95 AT ROW 19.76 COL 2.83
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "เลขผู้เสียภาษี:":35 VIEW-AS TEXT
          SIZE 11.17 BY .95 AT ROW 19.76 COL 37.17
          BGCOLOR 19 FGCOLOR 2 FONT 1
     " น้ำหนักรถ :":30 VIEW-AS TEXT
          SIZE 10.5 BY .95 AT ROW 9.38 COL 108.17
          BGCOLOR 19 FGCOLOR 0 FONT 1
     "ประเภทรถ :":30 VIEW-AS TEXT
          SIZE 9.5 BY .91 AT ROW 14.67 COL 6.33
          BGCOLOR 19 FGCOLOR 0 FONT 1
     " วันที่คุ้มครอง :":35 VIEW-AS TEXT
          SIZE 11.5 BY .95 AT ROW 12.57 COL 4.5
          BGCOLOR 19 FGCOLOR 0 FONT 1
     "Status Policy :" VIEW-AS TEXT
          SIZE 14 BY 1 AT ROW 28.62 COL 45
          BGCOLOR 19 FGCOLOR 4 FONT 6
     " วันที่ไฟล์งาน :" VIEW-AS TEXT
          SIZE 12.5 BY .95 AT ROW 2.91 COL 4.5
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "ผู้รับผลประโยชน์ :":30 VIEW-AS TEXT
          SIZE 15 BY .86 AT ROW 22.91 COL 31
          BGCOLOR 19 FGCOLOR 2 FONT 1
     " รุ่นรถ :":30 VIEW-AS TEXT
          SIZE 7.67 BY .95 AT ROW 9.48 COL 35.83
          BGCOLOR 19 FGCOLOR 0 FONT 1
     " นามสกุล :":30 VIEW-AS TEXT
          SIZE 8.5 BY .95 AT ROW 18.71 COL 59.5
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "  ที่อยู่ 1 :":30 VIEW-AS TEXT
          SIZE 7 BY .95 AT ROW 20.81 COL 7.5
          BGCOLOR 19 FGCOLOR 2 FONT 1
     " เบี้ยรวม กธ.+ พรบ. :":30 VIEW-AS TEXT
          SIZE 17 BY .95 AT ROW 13.62 COL 39.5
          BGCOLOR 19 FGCOLOR 0 FONT 1
     "Dealer  :":35 VIEW-AS TEXT
          SIZE 7 BY .95 AT ROW 6.91 COL 9.67
          BGCOLOR 19 FGCOLOR 2 FONT 1
     " วันที่หมดอายุ :":35 VIEW-AS TEXT
          SIZE 12.17 BY .95 AT ROW 12.57 COL 36.33
          BGCOLOR 19 FGCOLOR 0 FONT 1
     "ชื่อกรรมการ:":30 VIEW-AS TEXT
          SIZE 10.67 BY .95 AT ROW 22.81 COL 87.33 WIDGET-ID 4
          BGCOLOR 19 FGCOLOR 2 FONT 1
     " การซ่อม :":35 VIEW-AS TEXT
          SIZE 8.5 BY .95 AT ROW 14.67 COL 87.33
          BGCOLOR 19 FGCOLOR 0 FONT 1
     "ภาคบังคับ:":30 VIEW-AS TEXT
          SIZE 8.5 BY .95 AT ROW 6.91 COL 83.17
          BGCOLOR 19 FGCOLOR 2 FONT 1
     " Drive ID :" VIEW-AS TEXT
          SIZE 10.5 BY .95 AT ROW 24.81 COL 70.17
          BGCOLOR 19 FGCOLOR 2 FONT 1
     " Drive ID :" VIEW-AS TEXT
          SIZE 10.5 BY .95 AT ROW 23.86 COL 70.17
          BGCOLOR 19 FGCOLOR 2 FONT 1
     " IC NO :" VIEW-AS TEXT
          SIZE 8 BY .95 AT ROW 23.81 COL 99.17
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "ราคารถ :":35 VIEW-AS TEXT
          SIZE 7.33 BY .95 AT ROW 11.43 COL 106
          BGCOLOR 19 FGCOLOR 0 FONT 1
     "เหตุผลกรณีซ้ำ :":30 VIEW-AS TEXT
          SIZE 12 BY .91 AT ROW 15.67 COL 3.67
          BGCOLOR 19 FGCOLOR 0 FONT 1
     "ตลาดสาขา :":30 VIEW-AS TEXT
          SIZE 9.17 BY .91 AT ROW 3.86 COL 93.5 WIDGET-ID 12
          BGCOLOR 19 FGCOLOR 2 FONT 1
     " ชื่อ :":30 VIEW-AS TEXT
          SIZE 3.83 BY .95 AT ROW 18.76 COL 30.17
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "ภาคสมัครใจ :":30 VIEW-AS TEXT
          SIZE 10.83 BY .95 AT ROW 6.91 COL 46.5
          BGCOLOR 19 FGCOLOR 2 FONT 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1.67 ROW 1.1
         SIZE 134.33 BY 29.9
         BGCOLOR 3 FGCOLOR 1 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "กลุ่ม :":30 VIEW-AS TEXT
          SIZE 4.67 BY .95 AT ROW 4.91 COL 42.67 WIDGET-ID 16
          BGCOLOR 19 FGCOLOR 2 FONT 1
     " Tel :" VIEW-AS TEXT
          SIZE 4.5 BY .95 AT ROW 20.81 COL 112.5 WIDGET-ID 20
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "ราคากลาง :":35 VIEW-AS TEXT
          SIZE 9.33 BY .95 AT ROW 11.52 COL 76.67
          BGCOLOR 19 FGCOLOR 0 FONT 1
     "  ที่อยู่จัดส่ง1 :":35 VIEW-AS TEXT
          SIZE 10.83 BY .95 AT ROW 21.86 COL 3.67
          BGCOLOR 19 FGCOLOR 2 FONT 1
     " เบี้ยรวม :":25 VIEW-AS TEXT
          SIZE 8.5 BY .95 AT ROW 13.62 COL 7.83
          BGCOLOR 19 FGCOLOR 0 FONT 1
     " เบอร์ พรบ  :":35 VIEW-AS TEXT
          SIZE 12.67 BY .95 AT ROW 1.33 COL 87.83
          BGCOLOR 2 FGCOLOR 7 FONT 6
     " Tel :" VIEW-AS TEXT
          SIZE 4.5 BY .95 AT ROW 21.81 COL 112.5 WIDGET-ID 24
          BGCOLOR 19 FGCOLOR 2 FONT 1
     " เบอร์กรมธรรม์ใหม่  :":35 VIEW-AS TEXT
          SIZE 19.5 BY .95 AT ROW 1.33 COL 47.5
          BGCOLOR 2 FGCOLOR 7 FONT 6
     "สี:":30 VIEW-AS TEXT
          SIZE 2.5 BY .95 AT ROW 9.48 COL 91.67 WIDGET-ID 28
          BGCOLOR 19 FGCOLOR 0 FONT 1
     " เลขรับแจ้ง :":35 VIEW-AS TEXT
          SIZE 10.33 BY .95 AT ROW 3.86 COL 34
          BGCOLOR 19 FGCOLOR 2 FONT 1
     " ข้อมูลลูกค้า" VIEW-AS TEXT
          SIZE 11.5 BY 1 AT ROW 17.76 COL 2.17
          BGCOLOR 19 FGCOLOR 6 FONT 6
     " ผู้รับแจ้ง :":30 VIEW-AS TEXT
          SIZE 8.83 BY .95 AT ROW 4.86 COL 76.33 WIDGET-ID 30
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "ชนิดรถ :" VIEW-AS TEXT
          SIZE 7.5 BY 1 AT ROW 13.62 COL 109
          BGCOLOR 19 FGCOLOR 0 FONT 1
     "ประเภทการใช้รถ :":30 VIEW-AS TEXT
          SIZE 14.83 BY .91 AT ROW 11.57 COL 27.17 WIDGET-ID 34
          BGCOLOR 19 FGCOLOR 0 FONT 1
     " ข้อมูลการแจ้งงาน" VIEW-AS TEXT
          SIZE 17 BY .81 AT ROW 2 COL 1.67
          BGCOLOR 19 FGCOLOR 6 FONT 6
     "ประเภทรถอื่นๆ :":30 VIEW-AS TEXT
          SIZE 13.5 BY .91 AT ROW 14.67 COL 47.83 WIDGET-ID 38
          BGCOLOR 19 FGCOLOR 0 FONT 1
     " Agent :":30 VIEW-AS TEXT
          SIZE 7.33 BY .95 AT ROW 2.86 COL 111.5
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "code rebate :":35 VIEW-AS TEXT
          SIZE 11.5 BY .95 AT ROW 14.76 COL 110.33 WIDGET-ID 42
          BGCOLOR 19 FGCOLOR 0 FONT 1
     "หมายเหตุอื่นๆ:":30 VIEW-AS TEXT
          SIZE 11.5 BY .86 AT ROW 16.67 COL 5
          BGCOLOR 19 FGCOLOR 6 FONT 1
     "ประเภทเอกสาร :":30 VIEW-AS TEXT
          SIZE 13.17 BY .91 AT ROW 18.62 COL 96.83 WIDGET-ID 46
          BGCOLOR 19 FGCOLOR 2 FONT 1
     " ประเภทประกัน :":30 VIEW-AS TEXT
          SIZE 13.5 BY .91 AT ROW 11.57 COL 2.83
          BGCOLOR 19 FGCOLOR 0 FONT 1
     "จดทะเบียนภาษี :":30 VIEW-AS TEXT
          SIZE 13 BY .91 AT ROW 19.67 COL 67.33 WIDGET-ID 50
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "  ชื่อผู้ขับขี่ 1 :":30 VIEW-AS TEXT
          SIZE 10.83 BY .95 AT ROW 23.91 COL 4
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "สาขาที่ :":30 VIEW-AS TEXT
          SIZE 6.17 BY .91 AT ROW 19.57 COL 107 WIDGET-ID 54
          BGCOLOR 19 FGCOLOR 2 FONT 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1.67 ROW 1.1
         SIZE 134.33 BY 29.9
         BGCOLOR 3 FGCOLOR 1 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     " รุ่นย่อย:":30 VIEW-AS TEXT
          SIZE 7.67 BY .91 AT ROW 15.71 COL 80.17 WIDGET-ID 58
          BGCOLOR 19 FGCOLOR 0 FONT 1
     " เลขเครื่อง :":35 VIEW-AS TEXT
          SIZE 9.5 BY .95 AT ROW 10.48 COL 6.67
          BGCOLOR 19 FGCOLOR 0 FONT 1
     "เลขที่สัญญา :":30 VIEW-AS TEXT
          SIZE 10 BY .91 AT ROW 5.91 COL 6.67
          BGCOLOR 19 FGCOLOR 2 FONT 1
     " เลขตัวถัง :":20 VIEW-AS TEXT
          SIZE 9.17 BY .95 AT ROW 10.52 COL 42.33
          BGCOLOR 19 FGCOLOR 0 FONT 1
     " ปีรถ :":35 VIEW-AS TEXT
          SIZE 5.5 BY .95 AT ROW 9.48 COL 77.33
          BGCOLOR 19 FGCOLOR 0 FONT 1
     " ข้อรถและการประกันภัย" VIEW-AS TEXT
          SIZE 21 BY .91 AT ROW 8.38 COL 2
          BGCOLOR 19 FGCOLOR 6 FONT 6
     "เบี้ยสุทธิ :":30 VIEW-AS TEXT
          SIZE 7.5 BY .95 AT ROW 12.62 COL 100.83
          BGCOLOR 19 FGCOLOR 0 FONT 1
     "  ชื่อผู้ขับขี่ 2 :":30 VIEW-AS TEXT
          SIZE 10.83 BY .95 AT ROW 24.91 COL 4
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "เลขคุ้มครองชั่วคราว :":35 VIEW-AS TEXT
          SIZE 16.5 BY .95 AT ROW 5.91 COL 40.83
          BGCOLOR 19 FGCOLOR 2 FONT 1
     " วันที่โหลด  :":30 VIEW-AS TEXT
          SIZE 10.33 BY .95 AT ROW 2.81 COL 34.17
          BGCOLOR 19 FGCOLOR 2 FONT 1
     " ชื่อบริษัทประกัน :":35 VIEW-AS TEXT
          SIZE 14 BY .95 AT ROW 5.86 COL 82.17
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "Producer :":30 VIEW-AS TEXT
          SIZE 10 BY .95 AT ROW 2.81 COL 85.17
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "  ที่อยู่ 2 :":30 VIEW-AS TEXT
          SIZE 7 BY .95 AT ROW 20.81 COL 66
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "วันที่ออกงาน :" VIEW-AS TEXT
          SIZE 14 BY 1 AT ROW 28.57 COL 7.5
          BGCOLOR 19 FGCOLOR 4 FONT 6
     " Birth :":30 VIEW-AS TEXT
          SIZE 7 BY .95 AT ROW 24.86 COL 48.67
          BGCOLOR 19 FGCOLOR 2 FONT 1
     " Remark :":30 VIEW-AS TEXT
          SIZE 8.83 BY .86 AT ROW 25.91 COL 6.17
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "  ที่อยู่ 2 :":30 VIEW-AS TEXT
          SIZE 7 BY .95 AT ROW 21.76 COL 66
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "Code ประกันภัย :":30 VIEW-AS TEXT
          SIZE 14 BY .95 AT ROW 4.86 COL 111.33
          BGCOLOR 19 FGCOLOR 2 FONT 1
     " ยี่ห้อรถ :":30 VIEW-AS TEXT
          SIZE 8.33 BY .95 AT ROW 9.48 COL 8.33
          BGCOLOR 19 FGCOLOR 0 FONT 1
     " ทะเบียน :":30 VIEW-AS TEXT
          SIZE 8.5 BY .95 AT ROW 10.48 COL 77.5
          BGCOLOR 19 FGCOLOR 0 FONT 1
     "ผู้ขับขี่ :":35 VIEW-AS TEXT
          SIZE 5.83 BY .95 AT ROW 23 COL 8.67
          BGCOLOR 19 FGCOLOR 2 FONT 1
     RECT-335 AT ROW 1.14 COL 1.17
     RECT-381 AT ROW 28.62 COL 111
     RECT-382 AT ROW 28.57 COL 121.83
     RECT-383 AT ROW 2.67 COL 2
     RECT-384 AT ROW 18.38 COL 2
     RECT-385 AT ROW 8.62 COL 1.83
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1.67 ROW 1.1
         SIZE 134.33 BY 29.9
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
         TITLE              = "Update Data THANACHAT"
         HEIGHT             = 30
         WIDTH              = 135.33
         MAX-HEIGHT         = 30
         MAX-WIDTH          = 135.33
         VIRTUAL-HEIGHT     = 30
         VIRTUAL-WIDTH      = 135.33
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
/* SETTINGS FOR FILL-IN fi_error IN FRAME fr_main
   ALIGN-L                                                              */
/* SETTINGS FOR FILL-IN fi_ldate IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_ltime IN FRAME fr_main
   NO-ENABLE                                                            */
ASSIGN 
       fi_poltyp:READ-ONLY IN FRAME fr_main        = TRUE.

/* SETTINGS FOR FILL-IN fi_reldate IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_remark1 IN FRAME fr_main
   ALIGN-L                                                              */
/* SETTINGS FOR FILL-IN fi_trndat IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_userid IN FRAME fr_main
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Update Data THANACHAT */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Update Data THANACHAT */
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
            Find  brstat.tlt Where  Recid(tlt)  =  nv_recidtlt.
            If  avail  brstat.tlt Then do:
                ASSIGN  
                    tlt.comp_usr_tlt =   trim(fi_notcode)         /* Code ประกันภัย  */  
                    tlt.comp_sck     =   trim(fi_sckno)           /*เลขที่สติ๊กเกอร์ */  
                    tlt.comp_pol     =   trim(fi_compol)        /*เลขกรมธรรม์พรบ   */  
                    tlt.nor_usr_tlt  =   trim(fi_not_off)         /*ชื่อประกันภัย    */  
                    tlt.nor_noti_tlt =   trim(fi_notno)           /*เลขที่รับแจ้ง    */  
                    tlt.exp          =   "BR:" + trim(fi_branch) +  /*โค้ดตลาดสาขา     */  
                                         " MK:" + trim(fi_mkBR)     /*ตลาดสาขา*/ 
                    tlt.nor_usr_ins  =   trim(fi_ins_off)           /*ผู้แจ้ง          */  
                    tlt.filler1      =   TRIM(fi_group)             /* กลุ่ม         */  
                    tlt.rec_addr4    =   trim(fi_notiname)          /*ผู้รับแจ้ง         */
                    tlt.rec_name     =   trim(fi_title)            /*คำนำหน้าชื่อผู้เอาประกันภัย */                       
                    tlt.ins_name     =   trim(fi_firstname) + " " + trim(fi_lastname)        /*ชื่อผู้เอาประกันภัย */  
                    tlt.ins_addr5    =   TRIM(fi_icno)               /*เลขบัตร           */  
                    tlt.ins_addr1    =   trim(fi_addr1)             /*ที่อยู่ลูกค้า   */  
                    tlt.ins_addr2    =   trim(fi_addr2) +           /*ที่อยู่ลูกค้า   */  
                                         " TEL:" + TRIM(fi_tel)     /*เบอร์โทร        */  
                    tlt.ins_addr3    =   trim(fi_addrs1)            /*ที่อยู่จัดส่ง   */
                    tlt.ins_addr4    =   trim(fi_addrs2) +          /*ที่อยู่จัดส่ง   */
                                         " TEL:" + TRIM(fi_tels)     /*เบอร์โทร        */
                    tlt.nor_coamt    =   deci(fi_sumsi)                       /*ทุนประกัน            */
                    tlt.comp_grprm   =   DECI(fi_compprm)          /*เบี้ยสุทธิ           */  
                    tlt.nor_grprm    =   DECI(fi_prem1)            /*เบี้ยประกันรวม       */ 
                    tlt.comp_coamt   =   DECI(fi_gross_amt)        /*เบี้ยรวม             */ 
                    tlt.rec_addr3    =   trim(fi_pro_off)     /*เลขคุ้มครองชั่วคราว  */
                    tlt.brand        =   trim(fi_brand)       /*ยี่ห้อ               */  
                    tlt.model        =   trim(fi_model)       /*รุ่น                 */  
                    tlt.lince2       =   trim(fi_year)        /*ปี                   */ 
                    tlt.colorcod     =   TRIM(fi_color)       /* สี */
                    tlt.lince1       =   trim(fi_licence)     /*เลขทะเบียน                 */ 
                    tlt.cc_weight    =   INT(fi_ton)            /*ขนาดเครื่อง                */  
                    tlt.eng_no       =   trim(fi_eng_no)         /*เลขเครื่อง                 */  
                    tlt.cha_no       =   trim(fi_cha_no)         /*เลขถัง                     */  
                    tlt.old_cha      =   trim(fi_comment)        /*เหตุผลกรณี เลขเครื่องซ้ำ    */  
                    tlt.safe3        =   trim(fi_typpol)        /*ภาคสมัครใจ แถม/ไม่แถม       */ 
                    tlt.lince3       =   trim(fi_typcomp)        /*ภาคบังคับ แถม/ไม่แถม       */
                    tlt.endcnt       =   INT(fi_price)     /*ราคารถ                 */ 
                    tlt.seqno        =   INT(fi_price1)      /*ราคากลาง                 */ 
                    tlt.lotno        =   TRIM(fi_dealer)           /*ดีลเลอร์              */ 
                    tlt.expousr      =   trim(fi_covcod)           /*ประเภทประกัน               */  
                    tlt.endno        =   TRIM(fi_drive)         /*ผู้ขับขี่         */  
                    tlt.dri_name1    =   "DN1:"  + trim(fi_driv1) +  /*ระบุผู้ขับขี้1             */  
                                         " ID1:" + trim(fi_drivid1)  +   /*เลขที่ใบขับขี่1            */  
                                         " IC1:" + trim(fi_drivic1)      /*เลขที่บัตรประชาชน1         */  
                    tlt.dri_no1      =   trim(fi_birth1)              /*วันเดือนปีเกิด1            */  
                    tlt.dri_name2    =   "DN2:"  + trim(fi_driv2) +   /*ระบุผู้ขับขี้2             */  
                                         " ID2:" + trim(fi_drivid2)  +   /*เลขที่ใบขับขี่2            */  
                                         " IC2:" + trim(fi_drivic2)      /*เลขที่บัตรประชาชน2         */  
                    tlt.dri_no2      =   trim(fi_birth2)             /*วันเดือนปีเกิด2            */ 
                    tlt.gendat       =   if tlt.subins = "V70" then date(fi_comdat) else ?     /*วันที่เริ่มคุ้มครอง        */  
                    tlt.expodat      =   if tlt.subins = "V70" then date(fi_expdat) else ?     /*วันที่สิ้นสุดคุ้มครอง      */ 
                    tlt.comp_effdat  =   if tlt.subins = "V72" then date(fi_comdat) else ?                  /*วันทีเริ่มคุ้มครองพรบ      */  
                    tlt.nor_effdat   =   if tlt.subins = "V72" then date(fi_expdat) else ?                  /*วันที่สิ้นสุดคุ้มครองพรบ   */  
                    tlt.usrsent      =   TRIM(fi_caruse)                 /* ประเภทการใช้รถ*/
                    tlt.rec_addr1    =   TRIM(fi_error)                 /*หมายเหตุอื่นๆ */
                    tlt.recac        =   TRIM(fi_cartype)                /*ชนิดรถ */           
                    tlt.old_eng      =   "Veh:" + trim(fi_typcar) +       /*ประเภทรถ            */ 
                                         " Veh1:" + trim(fi_othcar)      /*ประเภทรถอื่นๆ       */ 
                    tlt.stat         =   "GR:" + trim(fi_garage) +        /*สถานที่ซ่อม         */ 
                                         " CD:" + trim(fi_coderb)         /* code rebate */ 
                    tlt.filler2      =   trim(fi_remark1) + " " + TRIM(fi_remark2)                  /*หมายเหตุ                   */  
                    tlt.sentcnt      =   INT(fi_seat)                /*จำนวนที่นั่ง*/
                    tlt.rec_addr2    =   Trim(fi_taxno)              /*เลขประจำตัวผู้เสียภาษี */
                    tlt.rec_addr5    =   Trim(fi_name2)              /*ชื่อกรรมการ   */    
                    tlt.nor_noti_ins =   TRIM(fi_doctyp)             /* ประเภทเอกสาร */  
                    tlt.comp_noti_tlt =  TRIM(fi_taxre)              /*จดทะเบียนภาษี */  
                    tlt.gentim        =  TRIM(fi_brtax)              /*สาขาที่*/         
                    tlt.safe1        =   trim(fi_benname)            /*ผู้รับผลประโยชน์  */ 
                    tlt.safe2        =   trim(fi_accno)              /*เลขที่ใบคำขอ      */ 
                    tlt.comp_usr_ins =   TRIM(fi_model2)             /* รุ่นยอ่ย */ 

                    tlt.comp_sub      =  trim(fi_producer)           /* produer code */                                                     
                    tlt.comp_noti_ins =  trim(fi_agent)              /* Agent */                     
                    tlt.policy        =  trim(fi_policy) .            /* new policy*/     
                    
            END.
            Apply "Close" to this-procedure.
            Return no-apply.
        END.
        WHEN FALSE THEN /* No */          
            DO:   
            APPLY "entry" TO fi_policy.
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


&Scoped-define SELF-NAME fi_addrs1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_addrs1 C-Win
ON LEAVE OF fi_addrs1 IN FRAME fr_main
DO:
  fi_addrS1 = INPUT fi_addrs1 .
  DISP fi_addrs1 WITH FRAM fr_main.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_addrs2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_addrs2 C-Win
ON LEAVE OF fi_addrs2 IN FRAME fr_main
DO:
    fi_addrs2 = INPUT fi_addrs2.
    DISP fi_addrs2 WITH FRAM fr_main.
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


&Scoped-define SELF-NAME fi_brtax
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_brtax C-Win
ON LEAVE OF fi_brtax IN FRAME fr_main
DO:
    fi_brtax = INPUT fi_brtax .
    DISP fi_brtax WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_cartype
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_cartype C-Win
ON LEAVE OF fi_cartype IN FRAME fr_main
DO:
    fi_cartype = INPUT fi_cartype.
    DISP fi_cartype WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_caruse
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_caruse C-Win
ON LEAVE OF fi_caruse IN FRAME fr_main
DO:
    fi_caruse = INPUT fi_caruse .
    DISP fi_caruse WITH FRAM fr_main.
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


&Scoped-define SELF-NAME fi_coderb
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_coderb C-Win
ON LEAVE OF fi_coderb IN FRAME fr_main
DO:
  fi_coderb =  Input  fi_coderb.
  Disp  fi_coderb with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_color
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_color C-Win
ON LEAVE OF fi_color IN FRAME fr_main
DO:
  fi_color =  Input  fi_color.
  Disp  fi_color with frame  fr_main.
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


&Scoped-define SELF-NAME fi_comment
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_comment C-Win
ON LEAVE OF fi_comment IN FRAME fr_main
DO:
    fi_comment = INPUT fi_comment .
    DISP fi_comment WITH FRAM fr_main.
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


&Scoped-define SELF-NAME fi_doctyp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_doctyp C-Win
ON LEAVE OF fi_doctyp IN FRAME fr_main
DO:
    fi_doctyp = INPUT fi_doctyp .
    DISP fi_doctyp WITH FRAM fr_main.
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


&Scoped-define SELF-NAME fi_drive
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_drive C-Win
ON LEAVE OF fi_drive IN FRAME fr_main
DO:
  fi_drive = INPUT fi_drive.
  DISP fi_drive WITH FRAM fr_main.
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


&Scoped-define SELF-NAME fi_error
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_error C-Win
ON LEAVE OF fi_error IN FRAME fr_main
DO:
    fi_error = trim(INPUT fi_error).
    DISP fi_error with frame  fr_main.
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


&Scoped-define SELF-NAME fi_group
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_group C-Win
ON LEAVE OF fi_group IN FRAME fr_main
DO:
  fi_group = INPUT fi_group .
  DISP fi_group WITH FRAM fr_main.
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


&Scoped-define SELF-NAME fi_mkbr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_mkbr C-Win
ON LEAVE OF fi_mkbr IN FRAME fr_main
DO:
  fi_mkbr = INPUT fi_mkbr.
  DISP fi_mkbr WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_model
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_model C-Win
ON LEAVE OF fi_model IN FRAME fr_main
DO:
  fi_model =  Input  fi_model.
  Disp  fi_model with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_model2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_model2 C-Win
ON LEAVE OF fi_model2 IN FRAME fr_main
DO:
  fi_model2 =  Input  fi_model2.
  Disp  fi_model2 with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_name2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_name2 C-Win
ON LEAVE OF fi_name2 IN FRAME fr_main
DO:
  fi_name2 = INPUT fi_name2.
  DISP fi_name2 WITH FRAM fr_main.
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


&Scoped-define SELF-NAME fi_notdat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_notdat C-Win
ON LEAVE OF fi_notdat IN FRAME fr_main
DO:
  fi_notdat = INPUT fi_notdat .
  DISP fi_notdat WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_notiname
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_notiname C-Win
ON LEAVE OF fi_notiname IN FRAME fr_main
DO:
    fi_notiname = INPUT fi_notiname  .
    DISP fi_notiname WITH FRAM fr_main.
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


&Scoped-define SELF-NAME fi_not_off
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_not_off C-Win
ON LEAVE OF fi_not_off IN FRAME fr_main
DO:
  fi_not_off = INPUT fi_not_off .
  DISP fi_not_off WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_othcar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_othcar C-Win
ON LEAVE OF fi_othcar IN FRAME fr_main
DO:
    fi_othcar = INPUT fi_othcar .
    DISP fi_othcar WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_policy
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_policy C-Win
ON LEAVE OF fi_policy IN FRAME fr_main
DO:
  fi_policy  =  Input  fi_policy.
  Disp  fi_policy with frame  fr_main.
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


&Scoped-define SELF-NAME fi_price
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_price C-Win
ON LEAVE OF fi_price IN FRAME fr_main
DO:
  fi_price =  Input  fi_price.
  Disp  fi_price with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_price1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_price1 C-Win
ON LEAVE OF fi_price1 IN FRAME fr_main
DO:
  fi_price1 =  Input  fi_price1.
  Disp  fi_price1 with frame  fr_main.
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


&Scoped-define SELF-NAME fi_pro_off
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_pro_off C-Win
ON LEAVE OF fi_pro_off IN FRAME fr_main
DO:
  fi_pro_off = INPUT fi_pro_off.
  DISP fi_pro_off WITH FRAM fr_main.
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


&Scoped-define SELF-NAME fi_seat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_seat C-Win
ON LEAVE OF fi_seat IN FRAME fr_main
DO:
  fi_seat  =  Input  fi_seat.
  Disp  fi_seat with frame  fr_main.
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


&Scoped-define SELF-NAME fi_taxno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_taxno C-Win
ON LEAVE OF fi_taxno IN FRAME fr_main
DO:
  fi_taxno  =  Input  fi_taxno.
  Disp  fi_taxno with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_taxre
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_taxre C-Win
ON LEAVE OF fi_taxre IN FRAME fr_main
DO:
    fi_taxre = INPUT fi_taxre .
    DISP fi_taxre WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_tel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_tel C-Win
ON LEAVE OF fi_tel IN FRAME fr_main
DO:
    fi_tel = INPUT fi_tel .
    DISP fi_tel WITH FRAM fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_tels
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_tels C-Win
ON LEAVE OF fi_tels IN FRAME fr_main
DO:
    fi_tels = INPUT fi_tels .
    DISP fi_tels WITH FRAM fr_main.
  
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


&Scoped-define SELF-NAME fi_typcar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_typcar C-Win
ON LEAVE OF fi_typcar IN FRAME fr_main
DO:
    fi_typcar = INPUT fi_typcar .
    DISP fi_typcar WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_typcomp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_typcomp C-Win
ON LEAVE OF fi_typcomp IN FRAME fr_main
DO:
  fi_typcomp =  Input  fi_typcomp.
  Disp  fi_typcomp with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_typpol
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_typpol C-Win
ON LEAVE OF fi_typpol IN FRAME fr_main
DO:
  fi_typpol = INPUT fi_typpol.
  DISP fi_typpol WITH FRAM fr_main.
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
  
  gv_prgid = "wgwqtnc2".
  gv_prog  = "Query & Update Data  (THANACHAT) ".
  RUN  WUT\WUTHEAD ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).

/*********************************************************************/ 
 /*  RUN Wut\WutwiCen ({&WINDOW-NAME}:HANDLE). */ 
  /*CURRENT-WINDOW:WINDOW-STATE = WINDOW-MAXIMIZED.*/
  SESSION:DATA-ENTRY-RETURN = YES.
  
 /* Rect-336:Move-to-top().*/
 /* Rect-337:Move-to-top().*/
  
  /*Hide    fi_difprm  in frame  {&FRAME-NAME}.*/
  Find  tlt  Where  Recid(tlt)  =  nv_recidtlt NO-LOCK NO-ERROR NO-WAIT .
  If  avail  tlt  Then do:
      Assign
          n_length      = 0
          n_exp         = ""
          n_IC          = ""
          n_Com         = ""
          n_addr5       = ""
          fi_icno       = ""
          n_addr5       = ""
          fi_poltyp     = tlt.subins              /* poltype */
          fi_ldate      = tlt.entdat              /* วันที่โหลด */  
          fi_ltime      = tlt.enttim              /* เวลาโหลด   */  
          fi_trndat     = tlt.trndat              /* วันที่ไฟล์แจ้งงาน */  
          fi_notdat     = tlt.datesent            /*วันที่รับแจ้ง    */
          fi_notcode    = tlt.comp_usr_tlt        /* code ประกันภัย  */  
          fi_sckno      = tlt.comp_sck            /*เลขที่สติ๊กเกอร์ */   
          fi_compol     = tlt.comp_pol            /*เลขกรมธรรม์พรบ   */ 
          fi_not_off    = tlt.nor_usr_tlt         /*ชื่อประกันภัย    */ 
          fi_notno      = tlt.nor_noti_tlt        /*เลขที่รับแจ้ง     */  
          fi_branch     = SUBSTR(tlt.EXP,4,INDEX(tlt.EXP,"MK:") - 4 )      /*โค้ดตลาดสาขา      */      
          fi_mkbr       = SUBSTR(tlt.EXP,R-INDEX(tlt.EXP,"MK:") + 3 )
          fi_ins_off    = tlt.nor_usr_ins                       /*ผู้แจ้ง                    */ 
          fi_group      = tlt.filler1                            /* กลุ่ม */   
          fi_notiname   = tlt.rec_addr4                          /*ผู้รับแจ้ง      */   
          fi_title      = tlt.rec_name                          /*คำนำหน้าชื่อผู้เอาประกันภัย */
          nv_index      = Index(tlt.ins_name," ")
          fi_firstname  = IF fi_title <> "บจก." AND fi_title <> "มูลนิธิ" AND fi_title <> "หจก." AND fi_title <> "บริษัท" 
                          THEN Substr(tlt.ins_name,1,nv_index) ELSE TRIM(tlt.ins_name)                   
          fi_lastname   = IF fi_title <> "บจก." AND fi_title <> "มูลนิธิ" AND fi_title <> "หจก." AND fi_title <> "บริษัท" 
                          THEN Substr(tlt.ins_name,nv_index + 1,length(tlt.ins_name) - LENGTH(fi_firstname)) ELSE ""
          fi_icno       = tlt.ins_addr5                         /* เลขบัตรประชาชน */
          fi_addr1      = tlt.ins_addr1                         /*ที่อยู่ลูกค้า 1             */                                                                                                     
          fi_addr2      = substr(tlt.ins_addr2,1,INDEX(tlt.ins_addr2,"TEL:") - 2)                        /*ที่อยู่ลูกค้า  2            */
          fi_tel        = SUBSTR(tlt.ins_addr2,INDEX(tlt.ins_addr2,"TEL:") + 4,LENGTH(tlt.ins_addr2))  /* เบอร์โทร */
          fi_addrS1      = tlt.ins_addr3                        /*ที่อยู่จัดส่ง 1              */
          fi_addrS2      = substr(tlt.ins_addr4,1,INDEX(tlt.ins_addr4,"TEL:") - 2)                        /*ที่อยู่จัดส่ง 2             */
          fi_tels        = SUBSTR(tlt.ins_addr4,INDEX(tlt.ins_addr4,"TEL:") + 4,LENGTH(tlt.ins_addr4))  /* เบอร์โทร */
          fi_sumsi      = tlt.nor_coamt                          /*ทุนประกัน             */
          fi_compprm    = tlt.comp_grprm                        /*เบี้ยสุทธิ            */ 
          fi_prem1      = tlt.nor_grprm                         /*เบี้ยประกันรวม        */ 
          fi_gross_amt  = tlt.comp_coamt                         /*เบี้ยรวม              */                                                                                                  
          fi_pro_off    = tlt.rec_addr3                          /*เลขคุ้มครองชั่วคราว  */                                                                                                   
          fi_brand      = tlt.brand                              /*ยี่ห้อ                */      
          fi_model      = tlt.model                             /*รุ่น                  */  
          fi_year       = tlt.lince2                             /*ปี                    */  
          fi_color      = tlt.colorcod                           /*สี */
          fi_licence    = tlt.lince1                             /*เลขทะเบียน            */ 
          fi_ton        = tlt.cc_weight                          /*นำหนักรถ           */
          fi_eng_no     = tlt.eng_no                             /*เลขเครื่อง            */                                                                                                       
          fi_cha_no     = tlt.cha_no                             /*เลขถัง                */
          fi_comment    = tlt.old_cha                            /*เหตุผลกรณีซ้ำ         */ 
          fi_typpol     = tlt.safe3                              /*ภาคสมัครใจ แถม/ไม่แถม       */
          fi_typcomp    = tlt.lince3                             /*ภาคบังคับ แถม/ไม่แถม       */
          fi_price      = tlt.endcnt                           /*ราคารถ            */ 
          fi_price1     = tlt.seqno                             /*ราคากลาง           */
          fi_dealer     = tlt.lotno                             /*Dealer           */  
          fi_covcod     = tlt.expousr                           /*ประเภทประกัน               */  
          fi_drive      =  tlt.endno                         /*ผู้ขับขี่    */ 
          n_addr5       = "" 
          fi_drivic1    = TRIM(SUBSTR(tlt.dri_name1,R-INDEX(TLT.dri_name1,"IC1:") + 4 ))      /*เลขที่บัตรประชาชน1         */ 
          n_length      = (LENGTH(tlt.dri_name1) - LENGTH(fi_drivic1)) - 4 
          n_addr5       = SUBSTR(tlt.dri_name1,1,n_length)
          fi_drivid1    = SUBSTR(n_addr5,R-INDEX(n_addr5,"ID1:") + 4 )                /*เลขที่ใบขับขี่1            */ 
          fi_driv1      = SUBSTR(n_addr5,5,INDEX(n_addr5,"ID1:") - 5 )        /*ระบุผู้ขับขี้1             */  
          fi_birth1     = (tlt.dri_no1) 
                                                                          /*วันเดือนปีเกิด1            */ 
          n_addr5       = "" 
          fi_drivic2    = TRIM(SUBSTR(tlt.dri_name2,R-INDEX(TLT.dri_name2,"IC2:") + 4 ))         /*เลขที่บัตรประชาชน2         */
          n_length      = (LENGTH(tlt.dri_name2) - LENGTH(fi_drivic2)) - 4  
          n_addr5       = SUBSTR(tlt.dri_name2,1,n_length)            
          fi_drivid2    = SUBSTR(n_addr5,R-INDEX(n_addr5,"ID2:") + 4 )                    /*เลขที่ใบขับขี่2            */
          fi_driv2      = SUBSTR(n_addr5,5,INDEX(n_addr5,"ID2:") - 5 )            /*ระบุผู้ขับขี้2             */  
          fi_birth2     = (tlt.dri_no2)                     /*วันเดือนปีเกิด2            */  
 
          fi_comdat     = if tlt.subins = "V70" then tlt.gendat   else tlt.comp_effdat          /*วันที่เริ่มคุ้มครอง        */                                                                                            
          fi_expdat     = if tlt.subins = "V70" then tlt.expodat  else tlt.nor_effdat           /*วันที่สิ้นสุดคุ้มครอง      */ 
          fi_caruse     = tlt.usrsent                                                           /* ประเภทการใช้รถ*/
          fi_error      = TRIM(tlt.rec_addr1)                                                   /*หมายเหตุอื่นๆ */
          fi_cartype    =  tlt.recac                                                            /*ชนิดรถ */               
          fi_typcar     = trim(substr(tlt.old_eng,5,INDEX(tlt.OLD_eng,"Veh1:") - 5 ))           /*ประเภทรถ                   */  
          fi_othcar     = trim(substr(tlt.OLD_eng,INDEX(tlt.OLD_eng,"Veh1:") + 5 ))             /*ประเภทรถอื่น ๆ */
          fi_garage     = trim(substr(tlt.stat,4,INDEX(tlt.stat,"CD:") - 4 ))                   /*สถานที่ซ่อม           */  
          fi_coderb     = TRIM(substr(tlt.stat,INDEX(tlt.stat,"CD:") + 3 ))                     /* code rebate */
          fi_remark1    = IF LENGTH(tlt.filler2) <> 0  then SUBSTR(tlt.filler2,1,80)  else ""             /*หมายเหตุ                   */                                
          fi_remark2    = IF LENGTH(tlt.filler2) > 80 then SUBSTR(tlt.filler2,81,80) else ""             /*หมายเหตุ                   */
          fi_seat       = tlt.sentcnt              /*ที่นั่ง*/
          fi_taxno       = TRIM(tlt.rec_addr2)     /*Tax no*/
          fi_name2      = TRIM(tlt.rec_addr5)      /*ชื่อกรรมการ */  
          fi_doctyp     = tlt.nor_noti_ins           /* ประเภทเอกสาร */ 
          fi_taxre      =  tlt.comp_noti_tlt                /*จดทะเบียนภาษี */
          fi_brtax      =  tlt.gentim                       /*สาขาที่*/
          fi_benname    = tlt.safe1                             /*ผู้รับผลประโยชน์           */ 
          fi_accno      = tlt.safe2                             /*เลขที่สัญญา           */ 
          fi_model2     = tlt.comp_usr_ins      /* รุ่นยอ่ย */
          
          fi_userid     = tlt.usrid                             /*User Load Data */  
          fi_producer   = tlt.comp_sub                          /* produer code */                                                                                               
          fi_agent      = tlt.comp_noti_ins                     /* Agent */                                                               
          fi_policy     = tlt.policy         /* new policy*/
          fi_reldate    = tlt.dat_ins_noti   /* วันที่ออกกรมธรรม์ */
          fi_polstatus  = IF index(tlt.releas,"NO") <> 0 THEN "ยังไม่ออกงาน" ELSE IF INDEX(tlt.releas,"Cancel") <> 0 THEN "ยกเลิก" ELSE "ออกงานแล้ว" .

         
     
     Disp  fi_poltyp           fi_group       fi_tels        fi_comment    fi_drivic2     fi_remark2   
           fi_ldate            fi_notiname    fi_sumsi       fi_typpol     fi_drivid2     fi_seat      
           fi_ltime            fi_title       fi_compprm     fi_typcomp    fi_driv2       fi_taxno     
           fi_trndat           fi_prem1       fi_price      fi_birth2      fi_name2     
           fi_notdat           fi_firstname   fi_gross_amt   fi_price1     fi_comdat      fi_doctyp    
           fi_notcode          fi_lastname    fi_pro_off     fi_dealer     fi_expdat      fi_taxre     
           fi_sckno            fi_icno        fi_brand       fi_covcod     fi_caruse      fi_brtax     
           fi_compol           fi_addr1       fi_model       fi_drive      fi_error       fi_benname   
           fi_not_off          fi_addr2       fi_year        fi_drivic1    fi_cartype     fi_accno     
           fi_notno            fi_tel         fi_color       fi_drivid1    fi_typcar      fi_model2    
           fi_branch           fi_addrS1      fi_licence     fi_driv1      fi_othcar      fi_userid    
           fi_mkbr             fi_addrS2      fi_ton         fi_birth1     fi_garage      fi_producer  
           fi_ins_off          fi_polstatus   fi_eng_no      fi_coderb     fi_agent       fi_policy
           fi_reldate          fi_cha_no      fi_remark1   With frame  fr_main. 
     IF LENGTH(fi_icno) < 13 THEN DO:
         fi_icno:BGCOLOR = 6 .
         DISP fi_icno WITH FRAME fr_main.
     END.
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
  DISPLAY fi_polstatus fi_reldate fi_cartype fi_policy fi_compol fi_producer 
          fi_agent fi_pro_off fi_branch fi_notno fi_accno fi_notiname fi_notdat 
          fi_notcode fi_ins_off fi_brand fi_model fi_year fi_ton fi_eng_no 
          fi_cha_no fi_licence fi_typcomp fi_covcod fi_typcar fi_not_off 
          fi_drive fi_dealer fi_price1 fi_price fi_comdat fi_expdat fi_sumsi 
          fi_gross_amt fi_compprm fi_sckno fi_prem1 fi_garage fi_comment 
          fi_title fi_firstname fi_lastname fi_icno fi_addr1 fi_addr2 fi_addrs1 
          fi_addrs2 fi_driv1 fi_birth1 fi_drivid1 fi_drivic1 fi_driv2 fi_birth2 
          fi_drivid2 fi_drivic2 fi_benname fi_typpol fi_remark1 fi_remark2 
          fi_userid fi_ldate fi_ltime fi_trndat fi_error fi_taxno fi_seat 
          fi_name2 fi_poltyp fi_mkbr fi_group fi_tel fi_tels fi_color fi_caruse 
          fi_othcar fi_coderb fi_doctyp fi_taxre fi_brtax fi_model2 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE fi_polstatus fi_cartype fi_policy fi_compol fi_producer fi_agent 
         fi_pro_off fi_branch fi_notno fi_accno fi_notiname fi_notdat 
         fi_notcode fi_ins_off fi_brand fi_model fi_year fi_ton fi_eng_no 
         fi_cha_no fi_licence fi_typcomp fi_covcod fi_typcar fi_not_off 
         fi_drive fi_dealer fi_price1 fi_price fi_comdat fi_expdat fi_sumsi 
         fi_gross_amt fi_compprm fi_sckno fi_prem1 fi_garage fi_comment 
         fi_title fi_firstname fi_lastname fi_icno fi_addr1 fi_addr2 fi_addrs1 
         fi_addrs2 fi_driv1 fi_birth1 fi_drivid1 fi_drivic1 fi_driv2 fi_birth2 
         fi_drivid2 fi_drivic2 fi_benname fi_typpol fi_remark1 fi_remark2 
         bu_save bu_exit fi_error fi_taxno fi_seat fi_name2 fi_poltyp fi_mkbr 
         fi_group fi_tel fi_tels fi_color fi_caruse fi_othcar fi_coderb 
         fi_doctyp fi_taxre fi_brtax fi_model2 RECT-335 RECT-381 RECT-382 
         RECT-383 RECT-384 RECT-385 
      WITH FRAME fr_main IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

