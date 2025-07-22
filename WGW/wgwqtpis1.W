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
Def  Input  parameter  nv_recidtlt  as  recid . 
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
DEF var ins_addr1 AS CHAR INIT "".
DEF var ins_addr2 AS CHAR INIT "".
DEF VAR n_length AS INT.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS bu_carisp cb_problem fi_gprem fi_pro_off ~
fi_cmrcode fi_ins_comp fi_notno fi_garage fi_vatvmi fi_compstamp fi_compvat ~
fi_custyp fi_comdat fi_expdat fi_sumfi fi_72comdat fi_72expdat fi_prem1 ~
fi_compgros fi_compprm fi_not_off fi_ins_off fi_stamdat fi_icno fi_title ~
fi_firstname fi_lastname fi_addr1 fi_addr3 fi_showroom fi_dealer fi_Maddr1 ~
fi_modeldesc fi_campaign fi_lastpol fi_Typewk fi_polcust fi_receipt ~
fi_benname fi_covcod fi_pack fi_compwht bu_save bu_exit fi_occcode ~
fi_Stampvmi fi_WHTvmi fi_com_no fi_REMARK fi_addr2 fi_instyp fi_addr4 ~
fi_addr5 fi_addr6 fi_addr7 fi_addr8 fi_addr9 fi_Maddr3 fi_Maddr2 fi_Maddr4 ~
fi_Maddr5 fi_Maddr6 fi_Maddr7 fi_Maddr8 fi_Maddr9 fi_producer fi_agent ~
fi_inspection fi_err fi_branch fi_flag fi_prvpol fi_polsystem fi_compulsory ~
ra_poltyp fi_camptpis fi_REMARK2 fi_product fi_ems RECT-342 RECT-341 ~
RECT-343 
&Scoped-Define DISPLAYED-OBJECTS cb_problem fi_gprem fi_pro_off fi_cmrcode ~
fi_ins_comp fi_notno fi_garage fi_vatvmi fi_compstamp fi_compvat fi_custyp ~
fi_comdat fi_expdat fi_sumfi fi_72comdat fi_72expdat fi_prem1 fi_compgros ~
fi_compprm fi_not_off fi_ins_off fi_stamdat fi_icno fi_title fi_firstname ~
fi_lastname fi_addr1 fi_addr3 fi_showroom fi_dealer fi_Maddr1 fi_modeldesc ~
fi_campaign fi_lastpol fi_Typewk fi_polcust fi_receipt fi_benname fi_covcod ~
fi_pack fi_compwht fi_trndat fi_userid fi_occcode fi_Stampvmi fi_WHTvmi ~
fi_com_no fi_REMARK fi_addr2 fi_instyp fi_time fi_addr4 fi_addr5 fi_addr6 ~
fi_addr7 fi_addr8 fi_addr9 fi_Maddr3 fi_Maddr2 fi_Maddr4 fi_Maddr5 ~
fi_Maddr6 fi_Maddr7 fi_Maddr8 fi_Maddr9 fi_entdat fi_userupdate fi_updat ~
fi_producer fi_agent fi_inspection fi_err fi_branch fi_flag fi_timeup ~
fi_prvpol fi_polsystem fi_compulsory ra_poltyp fi_camptpis fi_REMARK2 ~
fi_product fi_ems fi_time1 fi_trndatPM fi_reldat 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bu_carisp 
     LABEL "Car Detail and Inspection" 
     SIZE 29 BY .95
     BGCOLOR 5 FONT 6.

DEFINE BUTTON bu_exit 
     LABEL "Exit" 
     SIZE 8 BY 1.29
     BGCOLOR 6 FGCOLOR 6 FONT 6.

DEFINE BUTTON bu_save 
     LABEL "Save" 
     SIZE 8 BY 1.29
     BGCOLOR 2 FGCOLOR 2 FONT 6.

DEFINE VARIABLE cb_problem AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEM-PAIRS "Yes","1 ",
                     "No","2"
     DROP-DOWN-LIST
     SIZE 8 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_72comdat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 15.33 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_72expdat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_addr1 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 12.5 BY .91
     BGCOLOR 15 FGCOLOR 1 FONT 1 NO-UNDO.

DEFINE VARIABLE fi_addr2 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 26 BY .91
     BGCOLOR 15 FGCOLOR 1 FONT 1 NO-UNDO.

DEFINE VARIABLE fi_addr3 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 27.83 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_addr4 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 23.17 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_addr5 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 21.83 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_addr6 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 18.67 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_addr7 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 20.67 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_addr8 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 23.33 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_addr9 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 13.33 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_agent AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 13.33 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_benname AS CHARACTER FORMAT "X(65)":U 
     VIEW-AS FILL-IN 
     SIZE 28.67 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_branch AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 4.5 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_campaign AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_camptpis AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_cmrcode AS CHARACTER FORMAT "X(5)":U 
     VIEW-AS FILL-IN 
     SIZE 12.83 BY .91
     BGCOLOR 15 FGCOLOR 1 FONT 1 NO-UNDO.

DEFINE VARIABLE fi_comdat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 14.67 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_compgros AS DECIMAL FORMAT "->>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 14.5 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_compprm AS DECIMAL FORMAT "->>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 13.67 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_compstamp AS DECIMAL FORMAT ">>,>>9.99":U INITIAL ? 
     VIEW-AS FILL-IN 
     SIZE 12.67 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_compulsory AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 17.83 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_compvat AS DECIMAL FORMAT "->,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 11 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_compwht AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 10.5 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_com_no AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 18.83 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_covcod AS CHARACTER FORMAT "X(3)":U 
     VIEW-AS FILL-IN 
     SIZE 5.33 BY .91
     BGCOLOR 15 FGCOLOR 6 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_custyp AS CHARACTER FORMAT "X(1)":U 
     VIEW-AS FILL-IN 
     SIZE 4.5 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_dealer AS CHARACTER FORMAT "X(70)":U 
     VIEW-AS FILL-IN 
     SIZE 34.67 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_ems AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 18.83 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_entdat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 11.5 BY .91
     BGCOLOR 34 FGCOLOR 1 FONT 1 NO-UNDO.

DEFINE VARIABLE fi_err AS CHARACTER FORMAT "X(200)":U 
     VIEW-AS FILL-IN 
     SIZE 113.17 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_expdat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 15.33 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_firstname AS CHARACTER FORMAT "X(75)":U 
     VIEW-AS FILL-IN 
     SIZE 28.67 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_flag AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 11.17 BY .91
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_garage AS CHARACTER FORMAT "X(20)":U INITIAL ? 
     VIEW-AS FILL-IN 
     SIZE 26.17 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_gprem AS DECIMAL FORMAT "->>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 20.33 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_icno AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 15.33 BY .91
     BGCOLOR 15 FGCOLOR 1 FONT 1 NO-UNDO.

DEFINE VARIABLE fi_inspection AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 3.5 BY .91
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_instyp AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 11.83 BY .91
     BGCOLOR 15 FGCOLOR 1 FONT 1 NO-UNDO.

DEFINE VARIABLE fi_ins_comp AS CHARACTER FORMAT "X(8)":U 
     VIEW-AS FILL-IN 
     SIZE 11.67 BY .91
     BGCOLOR 15 FGCOLOR 1 FONT 1 NO-UNDO.

DEFINE VARIABLE fi_ins_off AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 20 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_lastname AS CHARACTER FORMAT "X(45)":U 
     VIEW-AS FILL-IN 
     SIZE 25.83 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_lastpol AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 33.17 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_Maddr1 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 11.83 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_Maddr2 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 21 BY .91
     BGCOLOR 15 FGCOLOR 1 FONT 1 NO-UNDO.

DEFINE VARIABLE fi_Maddr3 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 25 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_Maddr4 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 23 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_Maddr5 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 23.33 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_Maddr6 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 24.33 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_Maddr7 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 24.33 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_Maddr8 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 23.33 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_Maddr9 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 12.67 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_modeldesc AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 26 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_notno AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 21.83 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_not_off AS CHARACTER FORMAT "X(75)":U 
     VIEW-AS FILL-IN 
     SIZE 26 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_occcode AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 11.33 BY .86
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_pack AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 6 BY .91
     BGCOLOR 15 FGCOLOR 6 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_polcust AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 14.67 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_polsystem AS CHARACTER FORMAT "X(16)":U 
     VIEW-AS FILL-IN 
     SIZE 18.83 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_prem1 AS DECIMAL FORMAT "->>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 18.5 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_producer AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 14.17 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_product AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 8 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_pro_off AS CHARACTER FORMAT "X(8)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .91
     BGCOLOR 15 FGCOLOR 1 FONT 1 NO-UNDO.

DEFINE VARIABLE fi_prvpol AS CHARACTER FORMAT "X(26)":U 
     VIEW-AS FILL-IN 
     SIZE 18.67 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_receipt AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 33.67 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_reldat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 11.5 BY .91
     BGCOLOR 29 FGCOLOR 1 FONT 1 NO-UNDO.

DEFINE VARIABLE fi_REMARK AS CHARACTER FORMAT "X(150)":U 
     VIEW-AS FILL-IN 
     SIZE 113 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_REMARK2 AS CHARACTER FORMAT "X(150)":U 
     VIEW-AS FILL-IN 
     SIZE 113 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_showroom AS CHARACTER FORMAT "X(70)":U 
     VIEW-AS FILL-IN 
     SIZE 21.5 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_stamdat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 15.67 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_Stampvmi AS DECIMAL FORMAT "->>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 10 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_sumfi AS INTEGER FORMAT "->,>>>,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 18.67 BY .95
     BGCOLOR 15 FGCOLOR 6  NO-UNDO.

DEFINE VARIABLE fi_time AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 10.83 BY .91
     BGCOLOR 34 FGCOLOR 1 FONT 1 NO-UNDO.

DEFINE VARIABLE fi_time1 AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 9 BY .91
     BGCOLOR 34 FGCOLOR 1 FONT 1 NO-UNDO.

DEFINE VARIABLE fi_timeup AS CHARACTER FORMAT "X(15)":U 
      VIEW-AS TEXT 
     SIZE 8.67 BY .71
     BGCOLOR 33 FGCOLOR 1 FONT 1 NO-UNDO.

DEFINE VARIABLE fi_title AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 13 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_trndat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 10.83 BY .91
     BGCOLOR 34 FGCOLOR 1 FONT 1 NO-UNDO.

DEFINE VARIABLE fi_trndatPM AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 10.83 BY .91
     BGCOLOR 29 FGCOLOR 1 FONT 1 NO-UNDO.

DEFINE VARIABLE fi_Typewk AS CHARACTER FORMAT "X(5)":U 
     VIEW-AS FILL-IN 
     SIZE 6.17 BY .95
     BGCOLOR 15 FGCOLOR 6 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_updat AS DATE FORMAT "99/99/9999":U 
      VIEW-AS TEXT 
     SIZE 10.5 BY .71
     BGCOLOR 33 FGCOLOR 1 FONT 1 NO-UNDO.

DEFINE VARIABLE fi_userid AS CHARACTER FORMAT "X(10)":U 
      VIEW-AS TEXT 
     SIZE 7.5 BY .71
     BGCOLOR 33 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_userupdate AS CHARACTER FORMAT "X(10)":U 
      VIEW-AS TEXT 
     SIZE 7.33 BY .71
     BGCOLOR 33 FGCOLOR 0 FONT 1 NO-UNDO.

DEFINE VARIABLE fi_vatvmi AS DECIMAL FORMAT ">>,>>9.99":U INITIAL ? 
     VIEW-AS FILL-IN 
     SIZE 11.33 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_WHTvmi AS DECIMAL FORMAT "->>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 10.5 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE ra_poltyp AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "New", 1,
"Renew", 2,
"Switf", 3,
"Usedcar", 4,
"Refinance", 5
     SIZE 48.5 BY 1.19
     BGCOLOR 33 FGCOLOR 7 FONT 1 NO-UNDO.

DEFINE RECTANGLE RECT-341
     EDGE-PIXELS 2 GRAPHIC-EDGE    ROUNDED 
     SIZE 132.5 BY 12
     BGCOLOR 34 FGCOLOR 2 .

DEFINE RECTANGLE RECT-342
     EDGE-PIXELS 2 GRAPHIC-EDGE    ROUNDED 
     SIZE 132 BY 2.05
     BGCOLOR 33 FGCOLOR 34 .

DEFINE RECTANGLE RECT-343
     EDGE-PIXELS 2 GRAPHIC-EDGE    ROUNDED 
     SIZE 132.5 BY 10.71
     BGCOLOR 34 FGCOLOR 2 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     bu_carisp AT ROW 3.14 COL 103 WIDGET-ID 256
     cb_problem AT ROW 28.14 COL 38.83 COLON-ALIGNED NO-LABEL WIDGET-ID 254
     fi_gprem AT ROW 19 COL 47.83 COLON-ALIGNED NO-LABEL WIDGET-ID 16
     fi_pro_off AT ROW 5.62 COL 73 COLON-ALIGNED NO-LABEL
     fi_cmrcode AT ROW 5.62 COL 42.67 COLON-ALIGNED NO-LABEL
     fi_ins_comp AT ROW 5.62 COL 100.33 COLON-ALIGNED NO-LABEL
     fi_notno AT ROW 6.62 COL 54.5 COLON-ALIGNED NO-LABEL
     fi_garage AT ROW 15.91 COL 99.17 COLON-ALIGNED NO-LABEL
     fi_vatvmi AT ROW 19.14 COL 94.5 COLON-ALIGNED NO-LABEL
     fi_compstamp AT ROW 21.24 COL 69.5 COLON-ALIGNED NO-LABEL
     fi_compvat AT ROW 21.29 COL 91.83 COLON-ALIGNED NO-LABEL
     fi_custyp AT ROW 7.86 COL 122.33 COLON-ALIGNED NO-LABEL
     fi_comdat AT ROW 18.05 COL 15.83 COLON-ALIGNED NO-LABEL
     fi_expdat AT ROW 18 COL 43.17 COLON-ALIGNED NO-LABEL
     fi_sumfi AT ROW 15.91 COL 70.5 COLON-ALIGNED NO-LABEL
     fi_72comdat AT ROW 20.1 COL 47.83 COLON-ALIGNED NO-LABEL
     fi_72expdat AT ROW 20.14 COL 77.33 COLON-ALIGNED NO-LABEL
     fi_prem1 AT ROW 19.05 COL 15.83 COLON-ALIGNED NO-LABEL
     fi_compgros AT ROW 21.14 COL 44.33 COLON-ALIGNED NO-LABEL
     fi_compprm AT ROW 21.1 COL 15.67 COLON-ALIGNED NO-LABEL
     fi_not_off AT ROW 6.57 COL 90.5 COLON-ALIGNED NO-LABEL
     fi_ins_off AT ROW 6.71 COL 15.17 COLON-ALIGNED NO-LABEL
     fi_stamdat AT ROW 23.29 COL 89.33 COLON-ALIGNED NO-LABEL
     fi_icno AT ROW 8.91 COL 15.17 COLON-ALIGNED NO-LABEL
     fi_title AT ROW 7.91 COL 15.17 COLON-ALIGNED NO-LABEL
     fi_firstname AT ROW 7.81 COL 40.33 COLON-ALIGNED NO-LABEL
     fi_lastname AT ROW 7.81 COL 82 COLON-ALIGNED NO-LABEL
     fi_addr1 AT ROW 8.76 COL 43.5 COLON-ALIGNED NO-LABEL
     fi_addr3 AT ROW 8.81 COL 101.67 COLON-ALIGNED NO-LABEL
     fi_showroom AT ROW 22.24 COL 61 COLON-ALIGNED NO-LABEL
     fi_dealer AT ROW 22.19 COL 15.33 COLON-ALIGNED NO-LABEL
     fi_Maddr1 AT ROW 11.81 COL 15.17 COLON-ALIGNED NO-LABEL
     fi_modeldesc AT ROW 17 COL 15.83 COLON-ALIGNED NO-LABEL
     fi_campaign AT ROW 17 COL 86 COLON-ALIGNED NO-LABEL
     fi_lastpol AT ROW 18.05 COL 70.17 COLON-ALIGNED NO-LABEL
     fi_Typewk AT ROW 15.91 COL 53.83 COLON-ALIGNED NO-LABEL
     fi_polcust AT ROW 23.29 COL 57.33 COLON-ALIGNED NO-LABEL
     fi_receipt AT ROW 22.29 COL 96.33 COLON-ALIGNED NO-LABEL
     fi_benname AT ROW 23.24 COL 15.33 COLON-ALIGNED NO-LABEL
     fi_covcod AT ROW 15.91 COL 33 COLON-ALIGNED NO-LABEL
     fi_pack AT ROW 15.91 COL 16 COLON-ALIGNED NO-LABEL
     fi_compwht AT ROW 21.33 COL 113.33 COLON-ALIGNED NO-LABEL
     bu_save AT ROW 27.81 COL 114.5
     bu_exit AT ROW 27.76 COL 123
     fi_trndat AT ROW 4.57 COL 15.17 COLON-ALIGNED NO-LABEL
     fi_userid AT ROW 28.29 COL 58 COLON-ALIGNED NO-LABEL
     fi_occcode AT ROW 23.33 COL 118.5 COLON-ALIGNED NO-LABEL WIDGET-ID 4
     fi_Stampvmi AT ROW 19.1 COL 77.17 COLON-ALIGNED NO-LABEL WIDGET-ID 20
     fi_WHTvmi AT ROW 19.14 COL 113.33 COLON-ALIGNED NO-LABEL WIDGET-ID 24
     fi_com_no AT ROW 20.05 COL 15.67 COLON-ALIGNED NO-LABEL WIDGET-ID 28
     fi_REMARK AT ROW 24.29 COL 15.33 COLON-ALIGNED NO-LABEL WIDGET-ID 32
     fi_addr2 AT ROW 8.76 COL 66.5 COLON-ALIGNED NO-LABEL WIDGET-ID 44
     fi_instyp AT ROW 5.71 COL 15.17 COLON-ALIGNED NO-LABEL WIDGET-ID 48
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1.17 ROW 1.05
         SIZE 133.33 BY 28.71
         BGCOLOR 29 FGCOLOR 1 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     fi_time AT ROW 4.48 COL 59.17 COLON-ALIGNED NO-LABEL WIDGET-ID 52
     fi_addr4 AT ROW 9.86 COL 15.17 COLON-ALIGNED NO-LABEL WIDGET-ID 60
     fi_addr5 AT ROW 9.71 COL 48.17 COLON-ALIGNED NO-LABEL WIDGET-ID 66
     fi_addr6 AT ROW 9.76 COL 82.33 COLON-ALIGNED NO-LABEL WIDGET-ID 70
     fi_addr7 AT ROW 9.81 COL 108.83 COLON-ALIGNED NO-LABEL WIDGET-ID 74
     fi_addr8 AT ROW 10.81 COL 15.17 COLON-ALIGNED NO-LABEL WIDGET-ID 78
     fi_addr9 AT ROW 10.67 COL 48.17 COLON-ALIGNED NO-LABEL WIDGET-ID 82
     fi_Maddr3 AT ROW 11.71 COL 73.33 COLON-ALIGNED NO-LABEL WIDGET-ID 92
     fi_Maddr2 AT ROW 11.71 COL 40.83 COLON-ALIGNED NO-LABEL WIDGET-ID 90
     fi_Maddr4 AT ROW 11.71 COL 106.5 COLON-ALIGNED NO-LABEL WIDGET-ID 94
     fi_Maddr5 AT ROW 12.76 COL 15.17 COLON-ALIGNED NO-LABEL WIDGET-ID 102
     fi_Maddr6 AT ROW 12.71 COL 56.17 COLON-ALIGNED NO-LABEL WIDGET-ID 110
     fi_Maddr7 AT ROW 12.71 COL 92.17 COLON-ALIGNED NO-LABEL WIDGET-ID 112
     fi_Maddr8 AT ROW 13.71 COL 15.17 COLON-ALIGNED NO-LABEL WIDGET-ID 106
     fi_Maddr9 AT ROW 13.67 COL 48 COLON-ALIGNED NO-LABEL WIDGET-ID 108
     fi_entdat AT ROW 4.48 COL 47.5 COLON-ALIGNED NO-LABEL WIDGET-ID 128
     fi_userupdate AT ROW 28.33 COL 77 COLON-ALIGNED NO-LABEL WIDGET-ID 132
     fi_updat AT ROW 28.29 COL 92.5 COLON-ALIGNED NO-LABEL WIDGET-ID 138
     fi_producer AT ROW 4.52 COL 81 COLON-ALIGNED NO-LABEL WIDGET-ID 146
     fi_agent AT ROW 4.52 COL 103.17 COLON-ALIGNED NO-LABEL WIDGET-ID 150
     fi_inspection AT ROW 3.19 COL 96.33 COLON-ALIGNED NO-LABEL WIDGET-ID 156
     fi_err AT ROW 26.38 COL 15.33 COLON-ALIGNED NO-LABEL WIDGET-ID 158
     fi_branch AT ROW 4.52 COL 126 COLON-ALIGNED NO-LABEL WIDGET-ID 170
     fi_flag AT ROW 28.19 COL 12.67 COLON-ALIGNED NO-LABEL WIDGET-ID 176
     fi_timeup AT ROW 28.29 COL 103.17 COLON-ALIGNED NO-LABEL WIDGET-ID 188
     fi_prvpol AT ROW 2.05 COL 61.33 COLON-ALIGNED NO-LABEL WIDGET-ID 224
     fi_polsystem AT ROW 2.05 COL 86.67 COLON-ALIGNED NO-LABEL WIDGET-ID 222
     fi_compulsory AT ROW 2.05 COL 111.17 COLON-ALIGNED NO-LABEL WIDGET-ID 220
     ra_poltyp AT ROW 1.52 COL 10.5 NO-LABEL WIDGET-ID 226
     fi_camptpis AT ROW 17.05 COL 58.67 COLON-ALIGNED NO-LABEL WIDGET-ID 240
     fi_REMARK2 AT ROW 25.33 COL 15.33 COLON-ALIGNED NO-LABEL WIDGET-ID 258
     fi_product AT ROW 16.95 COL 111.5 COLON-ALIGNED NO-LABEL WIDGET-ID 260
     fi_ems AT ROW 20.24 COL 105 COLON-ALIGNED NO-LABEL WIDGET-ID 264
     fi_time1 AT ROW 4.57 COL 26.17 COLON-ALIGNED NO-LABEL WIDGET-ID 268
     fi_trndatPM AT ROW 13.71 COL 82.5 COLON-ALIGNED NO-LABEL WIDGET-ID 272
     fi_reldat AT ROW 13.67 COL 117.83 COLON-ALIGNED NO-LABEL WIDGET-ID 270
     "Last Name :":30 VIEW-AS TEXT
          SIZE 10 BY .95 AT ROW 7.81 COL 74
          BGCOLOR 34 FGCOLOR 1 FONT 4
     "   Mail House no :":30 VIEW-AS TEXT
          SIZE 14 BY .95 AT ROW 11.71 COL 3
          BGCOLOR 34 FGCOLOR 6 FONT 4
     " Exp Date70 :":35 VIEW-AS TEXT
          SIZE 10.83 BY .95 AT ROW 18.05 COL 34
          BGCOLOR 34 FGCOLOR 0 FONT 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1.17 ROW 1.05
         SIZE 133.33 BY 28.71
         BGCOLOR 29 FGCOLOR 1 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "ID number :":30 VIEW-AS TEXT
          SIZE 9.5 BY .95 AT ROW 8.86 COL 7.5
          BGCOLOR 34 FGCOLOR 1 FONT 4
     "Product :":30 VIEW-AS TEXT
          SIZE 7.5 BY .95 AT ROW 16.95 COL 106 WIDGET-ID 262
          BGCOLOR 34 FGCOLOR 0 FONT 1
     "Entry Date :":30 VIEW-AS TEXT
          SIZE 11.33 BY .95 AT ROW 4.52 COL 38.17 WIDGET-ID 130
          BGCOLOR 34 FGCOLOR 2 FONT 6
     "Agent :":35 VIEW-AS TEXT
          SIZE 7 BY .91 AT ROW 4.52 COL 98 WIDGET-ID 152
          BGCOLOR 34 FGCOLOR 2 FONT 6
     "Campaign TPIS :":30 VIEW-AS TEXT
          SIZE 13.5 BY .95 AT ROW 17.05 COL 47 WIDGET-ID 242
          BGCOLOR 34 FGCOLOR 0 FONT 1
     " Notify and Customer Detail :":30 VIEW-AS TEXT
          SIZE 39.83 BY .81 AT ROW 3.29 COL 2.17 WIDGET-ID 244
          BGCOLOR 29 FGCOLOR 4 FONT 2
     " Com Date70 :":35 VIEW-AS TEXT
          SIZE 11.33 BY .95 AT ROW 18 COL 6 WIDGET-ID 42
          BGCOLOR 34 FGCOLOR 0 FONT 1
     "Garage :":35 VIEW-AS TEXT
          SIZE 7.17 BY .95 AT ROW 15.91 COL 93.83
          BGCOLOR 34 FONT 1
     "Remark :":35 VIEW-AS TEXT
          SIZE 9 BY .95 AT ROW 24.24 COL 8 WIDGET-ID 34
          BGCOLOR 34 FGCOLOR 6 FONT 6
     "EMS No. :":30 VIEW-AS TEXT
          SIZE 9.67 BY .95 AT ROW 20.24 COL 96.83 WIDGET-ID 266
          BGCOLOR 34 FGCOLOR 6 FONT 6
     "House no :":30 VIEW-AS TEXT
          SIZE 8.83 BY .95 AT ROW 8.76 COL 36.17
          BGCOLOR 34 FGCOLOR 1 FONT 4
     "Branch :":30 VIEW-AS TEXT
          SIZE 8.33 BY .91 AT ROW 4.52 COL 119.67 WIDGET-ID 174
          BGCOLOR 34 FGCOLOR 2 FONT 6
     "Net Prem 72 :":30 VIEW-AS TEXT
          SIZE 11.17 BY .91 AT ROW 21.1 COL 6.33
          BGCOLOR 34 FGCOLOR 2 FONT 1
     "Coverage and Dealer Detail :":30 VIEW-AS TEXT
          SIZE 38 BY .81 AT ROW 14.86 COL 2.5 WIDGET-ID 252
          BGCOLOR 29 FGCOLOR 4 FONT 2
     " Model desc :":30 VIEW-AS TEXT
          SIZE 11.33 BY .95 AT ROW 17 COL 6.5
          BGCOLOR 34 FGCOLOR 0 FONT 1
     "Stamp 72 :":35 VIEW-AS TEXT
          SIZE 8.67 BY .95 AT ROW 21.24 COL 62.5
          BGCOLOR 34 FGCOLOR 2 FONT 1
     "Covcod :":30 VIEW-AS TEXT
          SIZE 9 BY .91 AT ROW 15.91 COL 25.83
          BGCOLOR 34 FGCOLOR 6 FONT 6
     "Village :":30 VIEW-AS TEXT
          SIZE 6.83 BY .95 AT ROW 8.81 COL 96.67
          BGCOLOR 34 FGCOLOR 1 FONT 4
     "Campaign :":30 VIEW-AS TEXT
          SIZE 9 BY .95 AT ROW 17 COL 79
          BGCOLOR 34 FGCOLOR 0 FONT 1
     "Building :":30 VIEW-AS TEXT
          SIZE 7.5 BY .91 AT ROW 8.76 COL 61 WIDGET-ID 46
          BGCOLOR 34 FGCOLOR 1 FONT 4
     " Dealer :":30 VIEW-AS TEXT
          SIZE 6.83 BY .95 AT ROW 22.24 COL 10.17
          BGCOLOR 34 FGCOLOR 1 FONT 1
     "Business type :":35 VIEW-AS TEXT
          SIZE 12.17 BY .91 AT ROW 5.62 COL 32.33
          BGCOLOR 34 FGCOLOR 0 FONT 4
     " WHT 72 :":25 VIEW-AS TEXT
          SIZE 8.83 BY .95 AT ROW 21.29 COL 106.33
          BGCOLOR 34 FGCOLOR 2 FONT 1
     "First name :":30 VIEW-AS TEXT
          SIZE 9.5 BY .95 AT ROW 7.81 COL 32.5
          BGCOLOR 34 FGCOLOR 1 FONT 4
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1.17 ROW 1.05
         SIZE 133.33 BY 28.71
         BGCOLOR 29 FGCOLOR 1 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "Class :":30 VIEW-AS TEXT
          SIZE 6.83 BY .91 AT ROW 15.91 COL 11
          BGCOLOR 34 FGCOLOR 6 FONT 6
     " Beneficiary  :":30 VIEW-AS TEXT
          SIZE 11 BY .86 AT ROW 23.24 COL 5.67
          BGCOLOR 34 FGCOLOR 1 FONT 1
     "TAS received by  :":35 VIEW-AS TEXT
          SIZE 15.5 BY .91 AT ROW 5.62 COL 59.17
          BGCOLOR 34 FGCOLOR 0 FONT 4
     "Sub-District :":30 VIEW-AS TEXT
          SIZE 10.67 BY .95 AT ROW 9.76 COL 73.5 WIDGET-ID 72
          BGCOLOR 34 FGCOLOR 1 FONT 4
     "TPIS Contract no:":35 VIEW-AS TEXT
          SIZE 14.33 BY .95 AT ROW 6.62 COL 41.17
          BGCOLOR 34 FGCOLOR 0 FONT 4
     " WHT:":30 VIEW-AS TEXT
          SIZE 6.5 BY .95 AT ROW 19.14 COL 108.83 WIDGET-ID 26
          BGCOLOR 34 FGCOLOR 0 FONT 1
     "Type of work :":30 VIEW-AS TEXT
          SIZE 14 BY .95 AT ROW 15.91 COL 41.33
          BGCOLOR 34 FGCOLOR 6 FONT 6
     "Soi :":30 VIEW-AS TEXT
          SIZE 3.67 BY .95 AT ROW 9.81 COL 13.33 WIDGET-ID 64
          BGCOLOR 34 FGCOLOR 1 FONT 4
     "Road :":30 VIEW-AS TEXT
          SIZE 5.33 BY .95 AT ROW 9.76 COL 44.5 WIDGET-ID 68
          BGCOLOR 34 FGCOLOR 1 FONT 4
     "Post :":30 VIEW-AS TEXT
          SIZE 5 BY .95 AT ROW 10.67 COL 45 WIDGET-ID 84
          BGCOLOR 34 FGCOLOR 1 FONT 4
     "Showroom :":35 VIEW-AS TEXT
          SIZE 10.33 BY .95 AT ROW 22.24 COL 52.5
          BGCOLOR 34 FGCOLOR 1 FONT 1
     "Customer type :":30 VIEW-AS TEXT
          SIZE 12.5 BY .91 AT ROW 7.86 COL 111
          BGCOLOR 34 FGCOLOR 0 FONT 4
     "Insurance ref no :":30 VIEW-AS TEXT
          SIZE 14 BY .95 AT ROW 6.71 COL 3
          BGCOLOR 34 FGCOLOR 0 FONT 4
     "Province :":30 VIEW-AS TEXT
          SIZE 8.33 BY .95 AT ROW 10.76 COL 8.67 WIDGET-ID 80
          BGCOLOR 34 FGCOLOR 1 FONT 4
     "Ins company :":35 VIEW-AS TEXT
          SIZE 11.17 BY .91 AT ROW 5.57 COL 90.83
          BGCOLOR 34 FGCOLOR 0 FONT 4
     "Exp Date72 :":30 VIEW-AS TEXT
          SIZE 10.83 BY .95 AT ROW 20.14 COL 68.17
          BGCOLOR 34 FGCOLOR 2 FONT 1
     "Ins.Year Type :":35 VIEW-AS TEXT
          SIZE 12 BY .91 AT ROW 5.67 COL 4.83 WIDGET-ID 50
          BGCOLOR 34 FGCOLOR 0 FONT 1
     " Payment Type :":30 VIEW-AS TEXT
          SIZE 13 BY .86 AT ROW 22.29 COL 85
          BGCOLOR 34 FGCOLOR 1 FONT 1
     "Stamp :":30 VIEW-AS TEXT
          SIZE 6.67 BY .95 AT ROW 19.1 COL 72.5 WIDGET-ID 22
          BGCOLOR 34 FGCOLOR 0 FONT 1
     "M_Village :":30 VIEW-AS TEXT
          SIZE 9.17 BY .91 AT ROW 11.71 COL 66 WIDGET-ID 96
          BGCOLOR 34 FGCOLOR 6 FONT 4
     "VAT :":35 VIEW-AS TEXT
          SIZE 5.5 BY .95 AT ROW 19.14 COL 90.83
          BGCOLOR 34 FGCOLOR 0 FONT 1
     "District :":30 VIEW-AS TEXT
          SIZE 6.5 BY .95 AT ROW 9.81 COL 104 WIDGET-ID 76
          BGCOLOR 34 FGCOLOR 1 FONT 4
     "Title :":30 VIEW-AS TEXT
          SIZE 4.5 BY .95 AT ROW 7.91 COL 12.5
          BGCOLOR 34 FGCOLOR 1 FONT 4
     "M_Road :":30 VIEW-AS TEXT
          SIZE 8 BY .95 AT ROW 12.67 COL 9 WIDGET-ID 104
          BGCOLOR 34 FGCOLOR 6 FONT 4
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1.17 ROW 1.05
         SIZE 133.33 BY 28.71
         BGCOLOR 29 FGCOLOR 1 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "VAT 72 :":35 VIEW-AS TEXT
          SIZE 7.67 BY .95 AT ROW 21.29 COL 86
          BGCOLOR 34 FGCOLOR 2 FONT 1
     "Last Policy  :":30 VIEW-AS TEXT
          SIZE 10.5 BY .95 AT ROW 18.05 COL 61.5
          BGCOLOR 34 FGCOLOR 0 FONT 1
     "M_Soi :":30 VIEW-AS TEXT
          SIZE 6.33 BY .95 AT ROW 11.71 COL 102 WIDGET-ID 100
          BGCOLOR 34 FGCOLOR 12 FONT 4
     "Sum FI :":30 VIEW-AS TEXT
          SIZE 9 BY .95 AT ROW 15.91 COL 63.33
          BGCOLOR 34 FGCOLOR 12 FONT 6
     "M_Province :":30 VIEW-AS TEXT
          SIZE 10.67 BY .95 AT ROW 13.62 COL 6.5 WIDGET-ID 118
          BGCOLOR 34 FGCOLOR 6 FONT 4
     "Com Date72 :":30 VIEW-AS TEXT
          SIZE 11 BY .95 AT ROW 20.1 COL 38.5
          BGCOLOR 34 FGCOLOR 2 FONT 1
     "M_District :":30 VIEW-AS TEXT
          SIZE 9.5 BY .95 AT ROW 12.71 COL 84.5 WIDGET-ID 116
          BGCOLOR 34 FGCOLOR 6 FONT 4
     "Notify Date :":30 VIEW-AS TEXT
          SIZE 13.5 BY .95 AT ROW 4.52 COL 3.5 WIDGET-ID 126
          BGCOLOR 34 FGCOLOR 2 FONT 6
     "M_Building :":30 VIEW-AS TEXT
          SIZE 9.83 BY .91 AT ROW 11.71 COL 32.83 WIDGET-ID 98
          BGCOLOR 34 FGCOLOR 6 FONT 4
     "Gross prem :":30 VIEW-AS TEXT
          SIZE 10 BY .95 AT ROW 19 COL 39.67 WIDGET-ID 18
          BGCOLOR 34 FGCOLOR 0 FONT 1
     "User Update:":30 VIEW-AS TEXT
          SIZE 10.83 BY .91 AT ROW 28.19 COL 67.83 WIDGET-ID 136
          BGCOLOR 19 FGCOLOR 4 FONT 1
     "Trans Date Premium :":30 VIEW-AS TEXT
          SIZE 20.17 BY .95 AT ROW 13.67 COL 64 WIDGET-ID 274
          BGCOLOR 34 FGCOLOR 5 FONT 6
     "Sticker no :":35 VIEW-AS TEXT
          SIZE 9.33 BY .95 AT ROW 20 COL 8.17 WIDGET-ID 30
          BGCOLOR 34 FGCOLOR 2 FONT 1
     "Director Name :":35 VIEW-AS TEXT
          SIZE 13 BY .95 AT ROW 6.62 COL 79.5
          BGCOLOR 34 FGCOLOR 0 FONT 4
     "Release Date Premium :":30 VIEW-AS TEXT
          SIZE 22.83 BY .95 AT ROW 13.67 COL 96.5 WIDGET-ID 276
          BGCOLOR 34 FGCOLOR 5 FONT 6
     "Update :":30 VIEW-AS TEXT
          SIZE 7 BY .91 AT ROW 28.19 COL 87.17 WIDGET-ID 140
          BGCOLOR 19 FGCOLOR 1 FONT 1
     "Error :":35 VIEW-AS TEXT
          SIZE 5.83 BY .95 AT ROW 26.38 COL 10.83 WIDGET-ID 160
          BGCOLOR 34 FGCOLOR 12 FONT 6
     "Mail Sub-District :":30 VIEW-AS TEXT
          SIZE 14 BY .95 AT ROW 12.71 COL 43.67 WIDGET-ID 114
          BGCOLOR 34 FGCOLOR 6 FONT 4
     "Status :":30 VIEW-AS TEXT
          SIZE 8 BY .95 AT ROW 28.14 COL 6.5 WIDGET-ID 178
          BGCOLOR 29 FGCOLOR 4 FONT 6
     "M_Post :":30 VIEW-AS TEXT
          SIZE 7.33 BY .95 AT ROW 13.67 COL 42.33 WIDGET-ID 120
          BGCOLOR 34 FGCOLOR 6 FONT 4
     "Insur Stamp Date  :":30 VIEW-AS TEXT
          SIZE 15.83 BY .91 AT ROW 23.33 COL 75.33
          BGCOLOR 34 FGCOLOR 1 FONT 1
     "User Load :":30 VIEW-AS TEXT
          SIZE 9.5 BY .91 AT ROW 28.19 COL 50.5 WIDGET-ID 134
          BGCOLOR 19 FGCOLOR 4 FONT 1
     "Occup code :":30 VIEW-AS TEXT
          SIZE 11.83 BY .86 AT ROW 23.33 COL 108.5 WIDGET-ID 6
          BGCOLOR 34 FGCOLOR 1 FONT 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1.17 ROW 1.05
         SIZE 133.33 BY 28.71
         BGCOLOR 29 FGCOLOR 1 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "Pol.cust date :":30 VIEW-AS TEXT
          SIZE 11.5 BY .95 AT ROW 23.29 COL 47.5
          BGCOLOR 34 FGCOLOR 1 FONT 1
     "Comp. no :":30 VIEW-AS TEXT
          SIZE 10.17 BY .76 AT ROW 1.24 COL 113.33 WIDGET-ID 234
          BGCOLOR 33 FGCOLOR 1 FONT 6
     "Producer :":35 VIEW-AS TEXT
          SIZE 9.67 BY .91 AT ROW 4.48 COL 73.17 WIDGET-ID 148
          BGCOLOR 34 FGCOLOR 2 FONT 6
     "TYPE :":35 VIEW-AS TEXT
          SIZE 7.5 BY .76 AT ROW 1.76 COL 2.67 WIDGET-ID 218
          BGCOLOR 33 FONT 6
     " Inspection :":30 VIEW-AS TEXT
          SIZE 12 BY .95 AT ROW 3.14 COL 86 WIDGET-ID 162
          BGCOLOR 32 FGCOLOR 4 FONT 6
     "Flag Problem :":30 VIEW-AS TEXT
          SIZE 14 BY .95 AT ROW 28.19 COL 26.83 WIDGET-ID 182
          BGCOLOR 29 FGCOLOR 4 FONT 6
     "Net prem :":30 VIEW-AS TEXT
          SIZE 8.5 BY .95 AT ROW 19 COL 9.17
          BGCOLOR 34 FGCOLOR 0 FONT 1
     "Gross Prem 72:":30 VIEW-AS TEXT
          SIZE 12.5 BY .95 AT ROW 21.14 COL 33.67
          BGCOLOR 34 FGCOLOR 2 FONT 1
     "Policy no :":35 VIEW-AS TEXT
          SIZE 10.5 BY .76 AT ROW 1.29 COL 88.83 WIDGET-ID 236
          BGCOLOR 33 FONT 6
     " Pol renew :":35 VIEW-AS TEXT
          SIZE 11.33 BY .76 AT ROW 1.29 COL 62.67 WIDGET-ID 238
          BGCOLOR 33 FONT 6
     RECT-342 AT ROW 1.1 COL 1.5 WIDGET-ID 232
     RECT-341 AT ROW 15.67 COL 1.17 WIDGET-ID 246
     RECT-343 AT ROW 4.14 COL 1.33 WIDGET-ID 248
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1.17 ROW 1.05
         SIZE 133.33 BY 28.71
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
         HEIGHT             = 28.86
         WIDTH              = 133.67
         MAX-HEIGHT         = 31.29
         MAX-WIDTH          = 213.33
         VIRTUAL-HEIGHT     = 31.29
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
/* SETTINGS FOR FILL-IN fi_entdat IN FRAME fr_main
   NO-ENABLE                                                            */
ASSIGN 
       fi_entdat:READ-ONLY IN FRAME fr_main        = TRUE.

ASSIGN 
       fi_inspection:READ-ONLY IN FRAME fr_main        = TRUE.

/* SETTINGS FOR FILL-IN fi_reldat IN FRAME fr_main
   NO-ENABLE                                                            */
ASSIGN 
       fi_reldat:READ-ONLY IN FRAME fr_main        = TRUE.

/* SETTINGS FOR FILL-IN fi_time IN FRAME fr_main
   NO-ENABLE                                                            */
ASSIGN 
       fi_time:READ-ONLY IN FRAME fr_main        = TRUE.

/* SETTINGS FOR FILL-IN fi_time1 IN FRAME fr_main
   NO-ENABLE                                                            */
ASSIGN 
       fi_time1:READ-ONLY IN FRAME fr_main        = TRUE.

/* SETTINGS FOR FILL-IN fi_timeup IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_trndat IN FRAME fr_main
   NO-ENABLE                                                            */
ASSIGN 
       fi_trndat:READ-ONLY IN FRAME fr_main        = TRUE.

/* SETTINGS FOR FILL-IN fi_trndatPM IN FRAME fr_main
   NO-ENABLE                                                            */
ASSIGN 
       fi_trndatPM:READ-ONLY IN FRAME fr_main        = TRUE.

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


&Scoped-define SELF-NAME bu_carisp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_carisp C-Win
ON CHOOSE OF bu_carisp IN FRAME fr_main /* Car Detail and Inspection */
DO:
        nv_recidtlt  =  Recid(tlt).

        {&WINDOW-NAME}:hidden  =  Yes. 
        
        Run  wgw\wgwqtpis2(Input nv_recidtlt).
        Apply "Close"  To this-procedure.
        RETURN NO-APPLY.
        
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
                   brstat.tlt.ins_typ             = trim(input fi_instyp  ) 
                   brstat.tlt.rec_addr4           = trim(input fi_cmrcode ) 
                   brstat.tlt.rec_addr3           = trim(input fi_pro_off ) 
                   brstat.tlt.subins              = trim(input fi_ins_comp) 
                   brstat.tlt.nor_usr_ins         = trim(input fi_ins_off ) 
                   brstat.tlt.nor_noti_tlt        = trim(input fi_notno   ) 
                   brstat.tlt.ins_title           = trim(input fi_title   ) 
                   brstat.tlt.ins_firstname       = trim(input fi_firstname) 
                   brstat.tlt.ins_lastname        = trim(input fi_lastname) 
                   brstat.tlt.id_typ              = trim(input fi_custyp ) 
                   brstat.tlt.nor_usr_tlt         = trim(input fi_not_off) 
                   brstat.tlt.ins_icno            = trim(input fi_icno ) 
                   brstat.tlt.hrg_no              = trim(input fi_addr1) 
                   brstat.tlt.hrg_moo             = trim(input fi_addr2) 
                   brstat.tlt.hrg_vill            = trim(input fi_addr3) 
                   brstat.tlt.hrg_soi             = trim(input fi_addr4) 
                   brstat.tlt.hrg_street          = trim(input fi_addr5) 
                   brstat.tlt.hrg_subdistrict     = trim(input fi_addr6) 
                   brstat.tlt.hrg_district        = trim(input fi_addr7) 
                   brstat.tlt.hrg_prov            = trim(input fi_addr8) 
                   brstat.tlt.hrg_postcd          = trim(input fi_addr9) 
                  /* brstat.tlt.brand               = trim(input fi_brand    ) 
                   brstat.tlt.model               = trim(input fi_carmodel ) */
                   brstat.tlt.pack                = trim(input fi_pack     ) 
                  /* brstat.tlt.old_eng             = trim(input fi_mdyear   ) 
                   brstat.tlt.vehuse              = trim(input fi_Usage    ) 
                   brstat.tlt.colordes            = trim(input fi_color    ) 
                   brstat.tlt.cc_weight           = input fi_cc 
                   brstat.tlt.old_cha             = trim(input fi_year     ) 
                   brstat.tlt.eng_no              = trim(input fi_eng_no   ) 
                   brstat.tlt.cha_no              = trim(input fi_cha_no   ) 
                   brstat.tlt.filler1             = trim(input fi_acc      ) 
                   brstat.tlt.filler2             = input fi_accamt    
                   brstat.tlt.lince1              = trim(input fi_licence  ) 
                   brstat.tlt.lince2              = trim(input fi_province ) */
                   brstat.tlt.packnme             = TRIM(INPUT fi_camptpis)
                   brstat.tlt.campaign            = trim(input fi_campaign ) 
                   brstat.tlt.product             = trim(INPUT fi_product)
                   brstat.tlt.safe1               = trim(input fi_Typewk   ) 
                   brstat.tlt.safe2               = trim(input fi_garage   ) 
                   brstat.tlt.safe3               = trim(input fi_modeldesc) 
                   brstat.tlt.nor_coamt           = input fi_sumfi             
                   brstat.tlt.gendat              = input fi_comdat           
                   brstat.tlt.expodat             = input fi_expdat           
                   brstat.tlt.note1               = trim(input fi_lastpol)              
                   brstat.tlt.covcod              = trim(input fi_covcod )           
                   brstat.tlt.nor_grprm           = input fi_prem1       
                   brstat.tlt.ndeci1              = input fi_gprem       
                   brstat.tlt.ndeci2              = input fi_Stampvmi    
                   brstat.tlt.ndeci3              = input fi_vatvmi      
                   brstat.tlt.ndeci4              = input fi_WHTvmi      
                   brstat.tlt.comp_pol            = trim(input fi_compulsory)  
                   brstat.tlt.nor_effdat          = input fi_72comdat    
                   brstat.tlt.comp_effdat         = input fi_72expdat    
                   brstat.tlt.comp_coamt          = input fi_compprm     
                   brstat.tlt.comp_grprm          = input fi_compgros    
                   brstat.tlt.rstp                = input fi_compstamp   
                   brstat.tlt.rtax                = input fi_compvat     
                   brstat.tlt.tax_coporate        = INPUT fi_compwht     
                   brstat.tlt.note2               = trim(input fi_dealer  )         
                   brstat.tlt.note3               = trim(input fi_showroom)       
                   brstat.tlt.note4               = trim(input fi_receipt )         
                   brstat.tlt.ben83               = trim(input fi_benname )         
                   brstat.tlt.ins_addr1           = "MH:" +  trim(input fi_Maddr1) + " " +         
                                                    "MB:" +  trim(input fi_Maddr2) + " " +        
                                                    "MM:" +  trim(input fi_Maddr3)         
                   brstat.tlt.ins_addr2           = "MS:" +  trim(input fi_Maddr4) + " " +       
                                                    "MR:" +  trim(input fi_Maddr5)         
                   brstat.tlt.ins_addr3           = trim(input fi_Maddr6)         
                   brstat.tlt.ins_addr4           = trim(input fi_Maddr7)         
                   brstat.tlt.ins_addr5           = trim(input fi_Maddr8)         
                   brstat.tlt.lince3              = trim(input fi_Maddr9)         
                   brstat.tlt.datesent            = input fi_polcust  
                   brstat.tlt.policy              = trim(input fi_polsystem  )   
                   brstat.tlt.ndate1              = input fi_stamdat      
                   brstat.tlt.note5               = trim(trim(input fi_REMARK)  + " " + TRIM(INPUT fi_remark2)) 
                   brstat.tlt.ins_occ             = trim(input fi_occcode )   
                   brstat.tlt.acno1               = trim(input fi_producer)   
                   brstat.tlt.agent               = trim(input fi_agent )   
                   brstat.tlt.ins_brins           = trim(input fi_branch)   
                   brstat.tlt.hclfg               = IF input cb_problem = "1" THEN "Y" ELSE "N"  
                   brstat.tlt.note7               = trim(input fi_inspection )   
                   /*brstat.tlt.note8               = trim(input fi_ispno      )   
                   brstat.tlt.note9               = trim(input fi_ispdetail  ) */  
                   brstat.tlt.note15              = trim(input fi_err)
                   /* fi_entdat           =  brstat.tlt.entdat  */
                   /* fi_time     =  brstat.tlt.enttim      */
                   /* fi_trndat           =  brstat.tlt.trndat  */
                   /* fi_updat    =  brstat.tlt.ndate1      */
                   /* ra_poltyp           =  IF trim(brstat.tlt.flag) = "NW" THEN 1 ELSE IF trim(brstat.tlt.flag) = "RW" THEN 2 ELSE 3*/
                   /* fi_userid           =  brstat.tlt.usrid  */ 
                   /* fi_userupdate =  brstat.tlt.usrsent  */
                   /* fi_flag     =  brstat.tlt.releas */
                   brstat.tlt.note16   =     trim(INPUT fi_ems)
                   /* fi_prvpol     =  "" policy premium*/
                    brstat.tlt.comp_sck =   trim(fi_com_no)    .

            END.                                                    
            Apply "Close" to this-procedure.
            Return no-apply.
            /* APPLY "entry" TO fi_branch.
            RETURN NO-APPLY. */
        END.
        WHEN FALSE THEN /* No */          
            DO:   
            APPLY "entry" TO fi_covcod.
            RETURN NO-APPLY.
        END.
        /*OTHERWISE /* Cancel */             
        STOP.*/
        END CASE.
Disp  fi_covcod with  frame  fr_main.
RELEASE brstat.tlt.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_72comdat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_72comdat C-Win
ON LEAVE OF fi_72comdat IN FRAME fr_main
DO:
  fi_72comdat = INPUT fi_72comdat.
  DISP fi_72comdat WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_72expdat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_72expdat C-Win
ON LEAVE OF fi_72expdat IN FRAME fr_main
DO:
  fi_72expdat = INPUT fi_72expdat.
  DISP fi_72expdat WITH FRAM fr_main.
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
  fi_addr4 = INPUT fi_addr4 .
  DISP fi_addr4 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_addr5
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_addr5 C-Win
ON LEAVE OF fi_addr5 IN FRAME fr_main
DO:
  fi_addr5 = INPUT fi_addr5 .
  DISP fi_addr5 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_addr6
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_addr6 C-Win
ON LEAVE OF fi_addr6 IN FRAME fr_main
DO:
  fi_addr6 = INPUT fi_addr6 .
  DISP fi_addr6 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_addr7
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_addr7 C-Win
ON LEAVE OF fi_addr7 IN FRAME fr_main
DO:
  fi_addr7 = INPUT fi_addr7 .
  DISP fi_addr7 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_addr8
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_addr8 C-Win
ON LEAVE OF fi_addr8 IN FRAME fr_main
DO:
  fi_addr8 = INPUT fi_addr8 .
  DISP fi_addr8 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_addr9
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_addr9 C-Win
ON LEAVE OF fi_addr9 IN FRAME fr_main
DO:
  fi_addr9 = INPUT fi_addr9.
  DISP fi_addr9 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_agent
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_agent C-Win
ON LEAVE OF fi_agent IN FRAME fr_main
DO:
  fi_agent = INPUT fi_agent.
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


&Scoped-define SELF-NAME fi_branch
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_branch C-Win
ON LEAVE OF fi_branch IN FRAME fr_main
DO:
  fi_branch =  Input  fi_branch.
  Disp  fi_branch with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_campaign
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_campaign C-Win
ON LEAVE OF fi_campaign IN FRAME fr_main
DO:
    fi_campaign = INPUT fi_campaign .
    DISP fi_campaign WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_camptpis
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_camptpis C-Win
ON LEAVE OF fi_camptpis IN FRAME fr_main
DO:
    fi_camptpis = INPUT fi_camptpis .
    DISP fi_camptpis WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_cmrcode
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_cmrcode C-Win
ON LEAVE OF fi_cmrcode IN FRAME fr_main
DO:
    fi_cmrcode = INPUT fi_cmrcode  .
    DISP fi_cmrcode WITH FRAM fr_main.
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


&Scoped-define SELF-NAME fi_compgros
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_compgros C-Win
ON LEAVE OF fi_compgros IN FRAME fr_main
DO:
  fi_compgros = INPUT fi_compgros.
  DISP fi_compgros WITH FRAM fr_main.
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


&Scoped-define SELF-NAME fi_compstamp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_compstamp C-Win
ON LEAVE OF fi_compstamp IN FRAME fr_main
DO:
  fi_compstamp =  Input  fi_compstamp.
  Disp  fi_compstamp with frame  fr_main.
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


&Scoped-define SELF-NAME fi_compvat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_compvat C-Win
ON LEAVE OF fi_compvat IN FRAME fr_main
DO:
  fi_compvat = INPUT fi_compvat.
  DISP fi_compvat WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_compwht
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_compwht C-Win
ON LEAVE OF fi_compwht IN FRAME fr_main
DO:
    fi_compwht = INPUT fi_compwht .
    DISP fi_compwht WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_com_no
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_com_no C-Win
ON LEAVE OF fi_com_no IN FRAME fr_main
DO:
  fi_com_no = INPUT fi_com_no .
  DISP fi_com_no WITH FRAM fr_main.
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


&Scoped-define SELF-NAME fi_custyp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_custyp C-Win
ON LEAVE OF fi_custyp IN FRAME fr_main
DO:
  fi_custyp =  Input  fi_custyp.
  Disp  fi_custyp with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_dealer
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_dealer C-Win
ON LEAVE OF fi_dealer IN FRAME fr_main
DO:
    fi_dealer = INPUT fi_dealer .
    DISP fi_dealer WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_ems
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_ems C-Win
ON LEAVE OF fi_ems IN FRAME fr_main
DO:
  fi_ems = INPUT fi_ems .
  DISP fi_ems WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_err
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_err C-Win
ON LEAVE OF fi_err IN FRAME fr_main
DO:
    fi_err = trim(INPUT fi_err).
    DISP fi_err with frame  fr_main.
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


&Scoped-define SELF-NAME fi_flag
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_flag C-Win
ON LEAVE OF fi_flag IN FRAME fr_main
DO:
  fi_flag = INPUT fi_flag .
  DISP fi_flag WITH FRAM fr_main.
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


&Scoped-define SELF-NAME fi_gprem
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_gprem C-Win
ON LEAVE OF fi_gprem IN FRAME fr_main
DO:
  fi_gprem = INPUT fi_gprem .
  DISP fi_gprem WITH FRAM fr_main.
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


&Scoped-define SELF-NAME fi_inspection
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_inspection C-Win
ON LEAVE OF fi_inspection IN FRAME fr_main
DO:
    fi_inspection = INPUT fi_inspection .
  DISP fi_inspection WITH FRAM fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_instyp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_instyp C-Win
ON LEAVE OF fi_instyp IN FRAME fr_main
DO:
    fi_instyp = INPUT fi_instyp  .
    DISP fi_instyp WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_ins_comp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_ins_comp C-Win
ON LEAVE OF fi_ins_comp IN FRAME fr_main
DO:
  fi_ins_comp = INPUT fi_ins_comp.
  DISP fi_ins_comp WITH FRAM fr_main.
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


&Scoped-define SELF-NAME fi_lastpol
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_lastpol C-Win
ON LEAVE OF fi_lastpol IN FRAME fr_main
DO:
  fi_lastpol = INPUT fi_lastpol.
  DISPLAY fi_lastpol WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_Maddr1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_Maddr1 C-Win
ON LEAVE OF fi_Maddr1 IN FRAME fr_main
DO:
    fi_Maddr1 = INPUT fi_Maddr1.
    DISP fi_Maddr1 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_Maddr2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_Maddr2 C-Win
ON LEAVE OF fi_Maddr2 IN FRAME fr_main
DO:
  fi_Maddr2 = INPUT fi_Maddr2 .
  DISP fi_Maddr2 WITH FRAM fr_main.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_Maddr3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_Maddr3 C-Win
ON LEAVE OF fi_Maddr3 IN FRAME fr_main
DO:
  fi_Maddr3 = INPUT fi_Maddr3 .
  DISP fi_Maddr3 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_Maddr4
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_Maddr4 C-Win
ON LEAVE OF fi_Maddr4 IN FRAME fr_main
DO:
  fi_Maddr4 = INPUT fi_Maddr4 .
  DISP fi_Maddr4 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_Maddr5
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_Maddr5 C-Win
ON LEAVE OF fi_Maddr5 IN FRAME fr_main
DO:
  fi_Maddr5 = INPUT fi_Maddr5 .
  DISP fi_Maddr5 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_Maddr6
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_Maddr6 C-Win
ON LEAVE OF fi_Maddr6 IN FRAME fr_main
DO:
  fi_Maddr6 = INPUT fi_Maddr6 .
  DISP fi_Maddr6 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_Maddr7
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_Maddr7 C-Win
ON LEAVE OF fi_Maddr7 IN FRAME fr_main
DO:
  fi_Maddr7 = INPUT fi_Maddr7 .
  DISP fi_Maddr7 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_Maddr8
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_Maddr8 C-Win
ON LEAVE OF fi_Maddr8 IN FRAME fr_main
DO:
  fi_Maddr8 = INPUT fi_Maddr8 .
  DISP fi_Maddr8 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_Maddr9
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_Maddr9 C-Win
ON LEAVE OF fi_Maddr9 IN FRAME fr_main
DO:
  fi_Maddr9 = INPUT fi_Maddr9 .
  DISP fi_Maddr9 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_modeldesc
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_modeldesc C-Win
ON LEAVE OF fi_modeldesc IN FRAME fr_main
DO:
    fi_modeldesc = INPUT fi_modeldesc.
    DISP fi_modeldesc WITH FRAM fr_main.
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


&Scoped-define SELF-NAME fi_occcode
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_occcode C-Win
ON LEAVE OF fi_occcode IN FRAME fr_main
DO:
  fi_occcode = INPUT fi_occcode .
  DISP fi_occcode WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_pack
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_pack C-Win
ON LEAVE OF fi_pack IN FRAME fr_main
DO:
    fi_pack = INPUT fi_pack .
    DISP fi_pack WITH FRAM fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_polcust
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_polcust C-Win
ON LEAVE OF fi_polcust IN FRAME fr_main
DO:
  fi_polcust = INPUT fi_polcust .
  DISP fi_polcust WITH FRAM fr_main.
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
  fi_producer = INPUT fi_producer.
  DISP fi_producer WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_product
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_product C-Win
ON LEAVE OF fi_product IN FRAME fr_main
DO:
    fi_product = INPUT fi_product .
    DISP fi_product WITH FRAM fr_main.
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


&Scoped-define SELF-NAME fi_prvpol
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_prvpol C-Win
ON LEAVE OF fi_prvpol IN FRAME fr_main
DO:
  fi_prvpol  =  Input  fi_prvpol.
  Disp  fi_prvpol with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_receipt
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_receipt C-Win
ON LEAVE OF fi_receipt IN FRAME fr_main
DO:
  fi_receipt = INPUT fi_receipt .
  DISP fi_receipt WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_REMARK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_REMARK C-Win
ON LEAVE OF fi_REMARK IN FRAME fr_main
DO:
    fi_remark = trim(INPUT fi_remark).
    DISP fi_remark with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_REMARK2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_REMARK2 C-Win
ON LEAVE OF fi_REMARK2 IN FRAME fr_main
DO:
    fi_remark2 = trim(INPUT fi_remark2).
    DISP fi_remark2 with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_showroom
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_showroom C-Win
ON LEAVE OF fi_showroom IN FRAME fr_main
DO:
  fi_showroom = INPUT fi_showroom .
  DISP fi_showroom WITH FRAM fr_main.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_stamdat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_stamdat C-Win
ON LEAVE OF fi_stamdat IN FRAME fr_main
DO:
  fi_stamdat = INPUT fi_stamdat .
  DISP fi_stamdat WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_Stampvmi
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_Stampvmi C-Win
ON LEAVE OF fi_Stampvmi IN FRAME fr_main
DO:
  fi_Stampvmi = INPUT fi_prem1 .
  DISP fi_Stampvmi WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_sumfi
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_sumfi C-Win
ON LEAVE OF fi_sumfi IN FRAME fr_main
DO:
    fi_sumfi = INPUT fi_sumfi.
    DISP fi_sumfi WITH FRAM fr_main.
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


&Scoped-define SELF-NAME fi_Typewk
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_Typewk C-Win
ON LEAVE OF fi_Typewk IN FRAME fr_main
DO:
  fi_typewk = INPUT fi_typewk.
  DISP fi_typewk WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_vatvmi
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_vatvmi C-Win
ON LEAVE OF fi_vatvmi IN FRAME fr_main
DO:
  fi_vatvmi =  Input  fi_vatvmi.
  Disp  fi_vatvmi with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_WHTvmi
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_WHTvmi C-Win
ON LEAVE OF fi_WHTvmi IN FRAME fr_main
DO:
  fi_WHTvmi = INPUT fi_WHTvmi.
  DISPLAY fi_WHTvmi WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ra_poltyp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_poltyp C-Win
ON VALUE-CHANGED OF ra_poltyp IN FRAME fr_main
DO:
  ra_poltyp = INPUT ra_poltyp.
  DISP ra_poltyp WITH FRAME fr_main.
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
  
  gv_prgid = "wgwqtpis1".
  gv_prog  = "Query &Update Data  (Tripet  co.,ltd.) ".
  RUN  WUT\WUTHEAD ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).

/*********************************************************************/ 
 /*  RUN Wut\WutwiCen ({&WINDOW-NAME}:HANDLE). */ 
  /*CURRENT-WINDOW:WINDOW-STATE = WINDOW-MAXIMIZED.*/
  SESSION:DATA-ENTRY-RETURN = YES.
  
  Find  brstat.tlt  Where   Recid(tlt)  =  nv_recidtlt NO-LOCK NO-ERROR NO-WAIT .
  If  avail  tlt  Then do:
      
      Assign
          fi_instyp         =   brstat.tlt.ins_typ         
          fi_cmrcode        =   brstat.tlt.rec_addr4       
          fi_pro_off        =   brstat.tlt.rec_addr3       
          fi_ins_comp       =   brstat.tlt.subins          
          fi_ins_off        =   brstat.tlt.nor_usr_ins     
          fi_notno          =   brstat.tlt.nor_noti_tlt    
          fi_title          =   brstat.tlt.ins_title       
          fi_firstname      =   brstat.tlt.ins_firstname   
          fi_lastname       =   brstat.tlt.ins_lastname    
          fi_custyp         =   brstat.tlt.id_typ          
          fi_not_off        =   brstat.tlt.nor_usr_tlt     
          fi_icno           =   brstat.tlt.ins_icno        
          fi_addr1          =   brstat.tlt.hrg_no          
          fi_addr2          =   brstat.tlt.hrg_moo         
          fi_addr3          =   brstat.tlt.hrg_vill        
          fi_addr4          =   brstat.tlt.hrg_soi         
          fi_addr5          =   brstat.tlt.hrg_street      
          fi_addr6          =   brstat.tlt.hrg_subdistrict 
          fi_addr7          =   brstat.tlt.hrg_district    
          fi_addr8          =   brstat.tlt.hrg_prov        
          fi_addr9          =   brstat.tlt.hrg_postcd      
          /*fi_brand          =   brstat.tlt.brand           
          fi_carmodel       =   brstat.tlt.model */          
          fi_pack           =   brstat.tlt.pack            
         /* fi_mdyear         =   brstat.tlt.old_eng         
          fi_Usage          =   brstat.tlt.vehuse          
          fi_color          =   brstat.tlt.colordes         
          fi_cc             =   brstat.tlt.cc_weight       
          fi_year           =   brstat.tlt.old_cha         
          fi_eng_no         =   brstat.tlt.eng_no          
          fi_cha_no         =   brstat.tlt.cha_no          
          fi_acc            =   brstat.tlt.filler1         
          fi_accamt         =   deci(brstat.tlt.filler2)         
          fi_licence        =   brstat.tlt.lince1          
          fi_province       =   brstat.tlt.lince2   */
          fi_camptpis       =   brstat.tlt.packnme
          fi_campaign       =   brstat.tlt.campaign  
          fi_product        =   brstat.tlt.product
          fi_Typewk         =   brstat.tlt.safe1           
          fi_garage         =   brstat.tlt.safe2           
          fi_modeldesc      =   brstat.tlt.safe3           
          fi_sumfi          =   brstat.tlt.nor_coamt       
          fi_comdat         =   brstat.tlt.gendat          
          fi_expdat         =   brstat.tlt.expodat         
          fi_lastpol        =   brstat.tlt.note1           
          fi_covcod         =   brstat.tlt.covcod          
          fi_prem1          =   brstat.tlt.nor_grprm       
          fi_gprem          =   brstat.tlt.ndeci1          
          fi_Stampvmi       =   brstat.tlt.ndeci2          
          fi_vatvmi         =   brstat.tlt.ndeci3          
          fi_WHTvmi         =   brstat.tlt.ndeci4          
          fi_compulsory     =   brstat.tlt.comp_pol        
          fi_72comdat       =   brstat.tlt.nor_effdat      
          fi_72expdat       =   brstat.tlt.comp_effdat     
          fi_compprm        =   brstat.tlt.comp_coamt      
          fi_compgros       =   brstat.tlt.comp_grprm      
          fi_compstamp      =   brstat.tlt.rstp            
          fi_compvat        =   brstat.tlt.rtax            
          fi_compwht        =   brstat.tlt.tax_coporate    
          fi_dealer         =   brstat.tlt.note2           
          fi_showroom       =   brstat.tlt.note3           
          fi_receipt        =   brstat.tlt.note4           
          fi_benname        =   brstat.tlt.ben83 
          ins_addr1         =   brstat.tlt.ins_addr1
          ins_addr2         =   brstat.tlt.ins_addr2
          /*fi_Maddr1         =   trim(SUBSTR(brstat.tlt.ins_addr1,4,INDEX(brstat.tlt.ins_addr1,"MB:") - 4))       
          fi_Maddr2         =   trim(SUBSTR(brstat.tlt.ins_addr1,INDEX(brstat.tlt.ins_addr1,"MB:") + 3,INDEX(brstat.tlt.ins_addr1,"MM:") - 7))
          fi_Maddr2         =   IF INDEX(fi_Maddr2,"MM:") <> 0 THEN trim(REPLACE(fi_Maddr2,"MM:","")) ELSE IF TRIM(fi_Maddr2) = "MM:" THEN "" 
                                ELSE IF TRIM(fi_Maddr2) = "MM" THEN "" ELSE IF TRIM(fi_Maddr2) = "M" THEN "" ELSE fi_Maddr2 
          fi_Maddr3         =   trim(SUBSTR(brstat.tlt.ins_addr1,R-INDEX(brstat.tlt.ins_addr1,"MM:") + 3))      
          fi_Maddr4         =   trim(SUBSTR(brstat.tlt.ins_addr2,4,INDEX(brstat.tlt.ins_addr2,"MR:") - 4))      
          fi_Maddr5         =   trim(SUBSTR(brstat.tlt.ins_addr2,R-INDEX(brstat.tlt.ins_addr2,"MR:") + 3))*/
          fi_Maddr6         =   brstat.tlt.ins_addr3       
          fi_Maddr7         =   brstat.tlt.ins_addr4       
          fi_Maddr8         =   brstat.tlt.ins_addr5       
          fi_Maddr9         =   brstat.tlt.lince3          
          fi_polcust        =   brstat.tlt.datesent        
          fi_polsystem      =   brstat.tlt.policy          
          fi_stamdat        =   brstat.tlt.ndate1          
          fi_REMARK         =   IF length(brstat.tlt.note5) >= 150 THEN SUBSTR(brstat.tlt.note5,1,150) ELSE trim(brstat.tlt.note5)
          fi_REMARK2        =   IF length(brstat.tlt.note5) > 150 THEN SUBSTR(brstat.tlt.note5,151,150) ELSE ""
          fi_occcode        =   brstat.tlt.ins_occ         
          fi_producer       =   brstat.tlt.acno1           
          fi_agent          =   brstat.tlt.agent           
          fi_branch         =   brstat.tlt.ins_brins       
          cb_problem        =   IF brstat.tlt.hclfg = "N" THEN "2" ELSE "1"          
          fi_inspection     =   brstat.tlt.note7           
          /*fi_ispno          =   brstat.tlt.note8           
          fi_ispdetail      =   brstat.tlt.note9 */          
          fi_err            =  brstat.tlt.note15
          fi_ems            =  brstat.tlt.note16

          fi_trndatPM       =  if trim(brstat.tlt.note17) <> "" then date(brstat.tlt.note17) else ? 
          fi_reldat         =  if trim(brstat.tlt.note18) <> "" then date(brstat.tlt.note18) else ?
          fi_entdat         =  brstat.tlt.entdat  
          fi_time           =  brstat.tlt.enttim  
          fi_trndat         =  brstat.tlt.trndat
          fi_time1          =  brstat.tlt.note14
          fi_updat          =  brstat.tlt.ndate1 
          ra_poltyp         =  IF trim(brstat.tlt.flag) = "NW" THEN 1 ELSE IF trim(brstat.tlt.flag) = "RW" THEN 2 
                               ELSE IF trim(brstat.tlt.flag) = "TF" THEN  3 ELSE IF trim(brstat.tlt.flag) = "UC" THEN  4 ELSE 5
          fi_userid         =  brstat.tlt.usrid   
          fi_userupdate     =  brstat.tlt.usrsent
          fi_flag           =  brstat.tlt.releas 
          fi_prvpol         =  brstat.tlt.nor_noti_ins /*policy premium*/
          fi_com_no         =  brstat.tlt.comp_sck   
          fi_timeup         =  brstat.tlt.trntime.
       ASSIGN
         n_length          = 0  
         fi_Maddr5         = SUBSTR(ins_addr2,R-INDEX(ins_addr2,"MR:"))
         n_length          = LENGTH(fi_Maddr5)
         ins_addr2         = SUBSTR(ins_addr2,1,LENGTH(ins_addr2) - n_length) 
         fi_Maddr4         = SUBSTR(ins_addr2,1,LENGTH(ins_addr2)) 
         fi_Maddr3         = SUBSTR(ins_addr1,R-INDEX(ins_addr1,"MM:"))
         n_length          = LENGTH(fi_Maddr3)
         ins_addr1         = SUBSTR(ins_addr1,1,LENGTH(ins_addr1) - n_length)
         fi_Maddr2         = SUBSTR(ins_addr1,R-INDEX(ins_addr1,"MB:"))
         n_length          = LENGTH(fi_Maddr2)
         ins_addr1         = SUBSTR(ins_addr1,1,LENGTH(ins_addr1) - n_length)
         fi_Maddr1         = SUBSTR(ins_addr1,1,LENGTH(ins_addr1)).
       if index(fi_Maddr1,"MH:") <> 0  then  fi_Maddr1 =  trim(REPLACE(fi_Maddr1,"MH:","")) .
       if index(fi_Maddr2,"MB:") <> 0  then  fi_Maddr2 =  trim(REPLACE(fi_Maddr2,"MB:","")) .
       if index(fi_Maddr3,"MM:") <> 0  then  fi_Maddr3 =  trim(REPLACE(fi_Maddr3,"MM:","")) .
       if index(fi_Maddr4,"MS:") <> 0  then  fi_Maddr4 =  trim(REPLACE(fi_Maddr4,"MS:","")) .
       if index(fi_Maddr5,"MR:") <> 0  then  fi_Maddr5 =  trim(REPLACE(fi_Maddr5,"MR:","")) .

      DISP fi_instyp   fi_cmrcode    fi_pro_off      fi_ins_comp     fi_ins_off    fi_title     fi_firstname 
           fi_notno    fi_icno       fi_addr1        fi_addr2        fi_addr3      fi_lastname  fi_custyp 
           fi_addr4    fi_addr5      fi_addr6        fi_addr7        fi_addr8      fi_camptpis  fi_product
           fi_addr9    /*fi_brand      fi_carmodel*/    fi_pack       /*  fi_mdyear    
           fi_Usage    fi_color      fi_cc           fi_year         fi_eng_no      
           fi_cha_no   fi_acc        fi_accamt       fi_licence      fi_province*/    
           fi_campaign fi_Typewk     fi_garage       fi_modeldesc    fi_sumfi       
           fi_comdat   fi_expdat     fi_lastpol      fi_covcod       fi_prem1       
           fi_gprem    fi_Stampvmi   fi_vatvmi       fi_WHTvmi       fi_compulsory  
           fi_72comdat fi_72expdat   fi_compprm      fi_compgros     fi_compstamp   
           fi_compvat  fi_compwht    fi_dealer       fi_showroom     fi_receipt     
           fi_benname  fi_Maddr1     fi_Maddr2       fi_Maddr3       fi_Maddr4      
           fi_Maddr5   fi_Maddr6     fi_Maddr7       fi_Maddr8       fi_Maddr9      
           fi_polcust  fi_polsystem  fi_stamdat      fi_REMARK       fi_REMARK2     fi_occcode     
           fi_producer fi_agent      fi_branch       cb_problem      fi_inspection  
           /*fi_ispno    fi_ispdetail */ fi_err      fi_entdat       fi_time        
           fi_trndat   fi_updat      ra_poltyp       fi_userid       fi_userupdate  
           fi_flag     fi_prvpol     fi_com_no       fi_timeup       fi_ems         fi_time1
           fi_trndatPM  fi_reldat    
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
  DISPLAY cb_problem fi_gprem fi_pro_off fi_cmrcode fi_ins_comp fi_notno 
          fi_garage fi_vatvmi fi_compstamp fi_compvat fi_custyp fi_comdat 
          fi_expdat fi_sumfi fi_72comdat fi_72expdat fi_prem1 fi_compgros 
          fi_compprm fi_not_off fi_ins_off fi_stamdat fi_icno fi_title 
          fi_firstname fi_lastname fi_addr1 fi_addr3 fi_showroom fi_dealer 
          fi_Maddr1 fi_modeldesc fi_campaign fi_lastpol fi_Typewk fi_polcust 
          fi_receipt fi_benname fi_covcod fi_pack fi_compwht fi_trndat fi_userid 
          fi_occcode fi_Stampvmi fi_WHTvmi fi_com_no fi_REMARK fi_addr2 
          fi_instyp fi_time fi_addr4 fi_addr5 fi_addr6 fi_addr7 fi_addr8 
          fi_addr9 fi_Maddr3 fi_Maddr2 fi_Maddr4 fi_Maddr5 fi_Maddr6 fi_Maddr7 
          fi_Maddr8 fi_Maddr9 fi_entdat fi_userupdate fi_updat fi_producer 
          fi_agent fi_inspection fi_err fi_branch fi_flag fi_timeup fi_prvpol 
          fi_polsystem fi_compulsory ra_poltyp fi_camptpis fi_REMARK2 fi_product 
          fi_ems fi_time1 fi_trndatPM fi_reldat 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE bu_carisp cb_problem fi_gprem fi_pro_off fi_cmrcode fi_ins_comp 
         fi_notno fi_garage fi_vatvmi fi_compstamp fi_compvat fi_custyp 
         fi_comdat fi_expdat fi_sumfi fi_72comdat fi_72expdat fi_prem1 
         fi_compgros fi_compprm fi_not_off fi_ins_off fi_stamdat fi_icno 
         fi_title fi_firstname fi_lastname fi_addr1 fi_addr3 fi_showroom 
         fi_dealer fi_Maddr1 fi_modeldesc fi_campaign fi_lastpol fi_Typewk 
         fi_polcust fi_receipt fi_benname fi_covcod fi_pack fi_compwht bu_save 
         bu_exit fi_occcode fi_Stampvmi fi_WHTvmi fi_com_no fi_REMARK fi_addr2 
         fi_instyp fi_addr4 fi_addr5 fi_addr6 fi_addr7 fi_addr8 fi_addr9 
         fi_Maddr3 fi_Maddr2 fi_Maddr4 fi_Maddr5 fi_Maddr6 fi_Maddr7 fi_Maddr8 
         fi_Maddr9 fi_producer fi_agent fi_inspection fi_err fi_branch fi_flag 
         fi_prvpol fi_polsystem fi_compulsory ra_poltyp fi_camptpis fi_REMARK2 
         fi_product fi_ems RECT-342 RECT-341 RECT-343 
      WITH FRAME fr_main IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

