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
  wuwqtis2.w :  Import text file from  Lockton Add in table  tlt  
                         Quey & Update data before Gen.
 Create  by    :  Ranu I. A60-0139 Date 10/04/2017
 Connect :  gw_stat ld brstat , gw_safe ld sic_bran ,sic_test ld sicuw sicsyac :not connect stat
+++++++++++++++++++++++++++++++++++++++++++++++*/
/*Modify by : Ranu I. A60-0272 Date : 23/06/2017 เพิ่มช่องแสดงข้อมูล ICNO */
/*Modify by : Ranu I. A61-0142 Date : 13/03/2018 แก้ไขการแสดงข้อมูลช่อง RY*/
/*----------------------------------------------------------------------------------------------*/
Def  Input  parameter  nv_recidtlt  as  recid  .
Def  var nv_index  as int  init 0.
DEF  VAR nv_chaidrep AS CHAR . /*A57-0262*/
DEF  VAR nv_length   AS INT .
DEF  VAR nv_ry1      AS CHAR FORMAT "X(70)".
DEF  VAR nv_ry2      AS CHAR FORMAT "X(20)".
DEF  VAR nv_ry3      AS CHAR FORMAT "X(20)".

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS fi_br fi_policy fi_tempol fi_dspc ~
fi_polsystem fi_notno fi_year fi_eng_no fi_ton fi_camp fi_garage fi_cha_no ~
fi_fleetper fi_othper fi_deduct fi_Model fi_seatnew fi_brand fi_licence ~
fi_deduct2 fi_comdat fi_expdat fi_sumsi fi_sumfi fi_72comdat fi_72expdat ~
fi_pd3 fi_prem1 fi_compprm fi_gross_amt fi_sckno fi_si fi_ins_off fi_ldate ~
fi_pd1 fi_pd2 fi_title fi_firstname fi_compol fi_addr1 fi_addr2 fi_status ~
fi_driv1 fi_driv2 fi_paydate fi_producer fi_agent fi_icno fi_accno ~
fi_benname fi_remark1 fi_remark2 fi_remark3 fi_covcod fi_polstatus fi_tp1 ~
fi_tp2 fi_tp3 bu_save bu_exit fi_closedat fi_bdate fi_id1 fi_bdate2 fi_id2 ~
fi_client RECT-337 RECT-338 RECT-462 
&Scoped-Define DISPLAYED-OBJECTS fi_br fi_policy fi_tempol fi_dspc ~
fi_polsystem fi_notno fi_year fi_eng_no fi_ton fi_camp fi_garage fi_cha_no ~
fi_fleetper fi_othper fi_deduct fi_Model fi_seatnew fi_brand fi_licence ~
fi_deduct2 fi_comdat fi_expdat fi_sumsi fi_sumfi fi_72comdat fi_72expdat ~
fi_pd3 fi_prem1 fi_compprm fi_gross_amt fi_sckno fi_si fi_ins_off fi_pd1 ~
fi_pd2 fi_title fi_firstname fi_compol fi_addr1 fi_addr2 fi_status fi_driv1 ~
fi_driv2 fi_paydate fi_producer fi_agent fi_icno fi_accno fi_benname ~
fi_remark1 fi_remark2 fi_remark3 fi_covcod fi_polstatus fi_tp1 fi_tp2 ~
fi_tp3 fi_trndat fi_userid fi_trntime fi_closedat fi_bdate fi_id1 fi_bdate2 ~
fi_id2 fi_client 

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
     SIZE 8 BY 1.57
     FONT 6.

DEFINE BUTTON bu_save 
     LABEL "Save" 
     SIZE 8 BY 1.57
     FONT 6.

DEFINE VARIABLE fi_72comdat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_72expdat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_accno AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 19.17 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_addr1 AS CHARACTER FORMAT "X(120)":U 
     VIEW-AS FILL-IN 
     SIZE 68.5 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 1 NO-UNDO.

DEFINE VARIABLE fi_addr2 AS CHARACTER FORMAT "X(120)":U 
     VIEW-AS FILL-IN 
     SIZE 68.5 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_agent AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 15.5 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_bdate AS CHARACTER FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 12.5 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_bdate2 AS CHARACTER FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 12.5 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_benname AS CHARACTER FORMAT "X(65)":U 
     VIEW-AS FILL-IN 
     SIZE 36.67 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_br AS CHARACTER FORMAT "X(3)":U 
     VIEW-AS FILL-IN 
     SIZE 5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_brand AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_camp AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 13 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_cha_no AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 23 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_client AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 16.5 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_closedat AS DATE FORMAT "99/99/9999":U 
      VIEW-AS TEXT 
     SIZE 15.5 BY .91
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_comdat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_compol AS CHARACTER FORMAT "X(45)":U 
     VIEW-AS FILL-IN 
     SIZE 17.67 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_compprm AS DECIMAL FORMAT "->>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 15.17 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_covcod AS CHARACTER FORMAT "X(3)":U 
     VIEW-AS FILL-IN 
     SIZE 6.33 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_deduct AS DECIMAL FORMAT "->,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 12.33 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_deduct2 AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 14.67 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_driv1 AS CHARACTER FORMAT "X(70)":U 
     VIEW-AS FILL-IN 
     SIZE 31.83 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_driv2 AS CHARACTER FORMAT "X(70)":U 
     VIEW-AS FILL-IN 
     SIZE 31.83 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_dspc AS DECIMAL FORMAT "->>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 12.5 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_eng_no AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 23 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_expdat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_firstname AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 44 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_fleetper AS DECIMAL FORMAT "->>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 11.33 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_garage AS CHARACTER FORMAT "X(2)":U INITIAL ? 
     VIEW-AS FILL-IN 
     SIZE 7.33 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_gross_amt AS DECIMAL FORMAT "->>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_icno AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 16.5 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_id1 AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 16.33 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_id2 AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 16.33 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_ins_off AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 20 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_ldate AS DATE FORMAT "99/99/9999":U 
      VIEW-AS TEXT 
     SIZE 15 BY .91
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_licence AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 18.17 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_Model AS CHARACTER FORMAT "X(60)":U 
     VIEW-AS FILL-IN 
     SIZE 27.5 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_notno AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 30.5 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_othper AS DECIMAL FORMAT "->>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 12.33 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_paydate AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 13 BY 1
     BGCOLOR 28 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_pd1 AS INTEGER FORMAT "->>,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 14.5 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_pd2 AS INTEGER FORMAT "->>,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_pd3 AS INTEGER FORMAT "->>,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 13.5 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_policy AS CHARACTER FORMAT "X(26)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_polstatus AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 16.5 BY 1
     BGCOLOR 28 FGCOLOR 6 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_polsystem AS CHARACTER FORMAT "X(26)":U 
     VIEW-AS FILL-IN 
     SIZE 17 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_prem1 AS DECIMAL FORMAT "->>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_producer AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 16.17 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_remark1 AS CHARACTER FORMAT "X(110)":U 
     VIEW-AS FILL-IN 
     SIZE 89 BY .86
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_remark2 AS CHARACTER FORMAT "X(85)":U 
     VIEW-AS FILL-IN 
     SIZE 89 BY .86
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_remark3 AS CHARACTER FORMAT "X(85)":U 
     VIEW-AS FILL-IN 
     SIZE 89 BY .86
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_sckno AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 16.33 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_seatnew AS INTEGER FORMAT "->>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 5.5 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_si AS INTEGER FORMAT "->>>,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 18 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_status AS CHARACTER FORMAT "X(15)":U 
      VIEW-AS TEXT 
     SIZE 13.17 BY 1
     BGCOLOR 28 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_sumfi AS INTEGER FORMAT "->>>,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 15.5 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_sumsi AS INTEGER FORMAT "->>>,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_tempol AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 16 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_title AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_ton AS INTEGER FORMAT "->>>>>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 10.5 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_tp1 AS INTEGER FORMAT "->>>,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 14.5 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_tp2 AS INTEGER FORMAT "->>>,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 14.83 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_tp3 AS INTEGER FORMAT "->>>,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 13.33 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_trndat AS DATE FORMAT "99/99/9999":U 
      VIEW-AS TEXT 
     SIZE 14.33 BY .91
     BGCOLOR 29 FGCOLOR 4 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_trntime AS CHARACTER FORMAT "X(20)":U 
      VIEW-AS TEXT 
     SIZE 10 BY .91
     BGCOLOR 29 FGCOLOR 4 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_userid AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 10.33 BY 1
     BGCOLOR 7 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_year AS CHARACTER FORMAT "X(4)":U INITIAL "0" 
     VIEW-AS FILL-IN 
     SIZE 7.5 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE RECTANGLE RECT-337
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 11.5 BY 2.24
     BGCOLOR 4 .

DEFINE RECTANGLE RECT-338
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 11.17 BY 2.24
     BGCOLOR 2 FGCOLOR 0 .

DEFINE RECTANGLE RECT-462
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 129 BY 21.29
     BGCOLOR 21 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     fi_br AT ROW 22.19 COL 77.83 COLON-ALIGNED NO-LABEL
     fi_policy AT ROW 2.67 COL 20.17 COLON-ALIGNED NO-LABEL
     fi_tempol AT ROW 2.62 COL 83 COLON-ALIGNED NO-LABEL
     fi_dspc AT ROW 17.14 COL 20.17 COLON-ALIGNED NO-LABEL
     fi_polsystem AT ROW 2.62 COL 52 COLON-ALIGNED NO-LABEL
     fi_notno AT ROW 3.76 COL 46.5 COLON-ALIGNED NO-LABEL
     fi_year AT ROW 7.95 COL 113.5 COLON-ALIGNED NO-LABEL
     fi_eng_no AT ROW 9 COL 56.83 COLON-ALIGNED NO-LABEL
     fi_ton AT ROW 9 COL 87 COLON-ALIGNED NO-LABEL
     fi_camp AT ROW 18.24 COL 89.17 COLON-ALIGNED NO-LABEL
     fi_garage AT ROW 10 COL 68.67 COLON-ALIGNED NO-LABEL
     fi_cha_no AT ROW 9 COL 20.17 COLON-ALIGNED NO-LABEL
     fi_fleetper AT ROW 17.1 COL 45.83 COLON-ALIGNED NO-LABEL
     fi_othper AT ROW 17.14 COL 70.67 COLON-ALIGNED NO-LABEL
     fi_deduct AT ROW 15.05 COL 20.33 COLON-ALIGNED NO-LABEL
     fi_Model AT ROW 7.95 COL 47 COLON-ALIGNED NO-LABEL
     fi_seatnew AT ROW 9.05 COL 107 COLON-ALIGNED NO-LABEL
     fi_brand AT ROW 7.91 COL 20.17 COLON-ALIGNED NO-LABEL
     fi_licence AT ROW 7.95 COL 87 COLON-ALIGNED NO-LABEL
     fi_deduct2 AT ROW 15.1 COL 46.5 COLON-ALIGNED NO-LABEL
     fi_comdat AT ROW 13 COL 20.33 COLON-ALIGNED NO-LABEL
     fi_expdat AT ROW 13 COL 50.5 COLON-ALIGNED NO-LABEL
     fi_sumsi AT ROW 14 COL 20.33 COLON-ALIGNED NO-LABEL
     fi_sumfi AT ROW 16.1 COL 45.67 COLON-ALIGNED NO-LABEL
     fi_72comdat AT ROW 13.05 COL 80.83 COLON-ALIGNED NO-LABEL
     fi_72expdat AT ROW 13.05 COL 110.83 COLON-ALIGNED NO-LABEL
     fi_pd3 AT ROW 16.1 COL 112.5 COLON-ALIGNED NO-LABEL
     fi_prem1 AT ROW 14.05 COL 50.5 COLON-ALIGNED NO-LABEL
     fi_compprm AT ROW 14.05 COL 80.83 COLON-ALIGNED NO-LABEL
     fi_gross_amt AT ROW 14.1 COL 110.83 COLON-ALIGNED NO-LABEL
     fi_sckno AT ROW 10.1 COL 107.17 COLON-ALIGNED NO-LABEL
     fi_si AT ROW 16.1 COL 20.17 COLON-ALIGNED NO-LABEL
     fi_ins_off AT ROW 18.24 COL 55.17 COLON-ALIGNED NO-LABEL
     fi_ldate AT ROW 3.81 COL 20.17 COLON-ALIGNED NO-LABEL
     fi_pd1 AT ROW 16.05 COL 68.5 COLON-ALIGNED NO-LABEL
     fi_pd2 AT ROW 16.1 COL 90.33 COLON-ALIGNED NO-LABEL
     fi_title AT ROW 4.81 COL 20.17 COLON-ALIGNED NO-LABEL
     fi_firstname AT ROW 4.81 COL 46.5 COLON-ALIGNED NO-LABEL
     fi_compol AT ROW 2.62 COL 110.83 COLON-ALIGNED NO-LABEL
     fi_addr1 AT ROW 5.86 COL 22.17 NO-LABEL
     fi_addr2 AT ROW 6.91 COL 20.17 COLON-ALIGNED NO-LABEL
     fi_status AT ROW 23.86 COL 20.83 COLON-ALIGNED NO-LABEL
     fi_driv1 AT ROW 11 COL 20.17 COLON-ALIGNED NO-LABEL
     fi_driv2 AT ROW 12 COL 20.17 COLON-ALIGNED NO-LABEL
     fi_paydate AT ROW 23.86 COL 50.33 COLON-ALIGNED NO-LABEL
     fi_producer AT ROW 22.14 COL 20 COLON-ALIGNED NO-LABEL
     fi_agent AT ROW 22.14 COL 52.17 COLON-ALIGNED NO-LABEL
     fi_icno AT ROW 4.76 COL 98.83 COLON-ALIGNED NO-LABEL
     fi_accno AT ROW 18.19 COL 20 COLON-ALIGNED NO-LABEL
     fi_benname AT ROW 10.05 COL 20.17 COLON-ALIGNED NO-LABEL
     fi_remark1 AT ROW 19.24 COL 22.17 NO-LABEL
     fi_remark2 AT ROW 20.19 COL 20.17 COLON-ALIGNED NO-LABEL
     fi_remark3 AT ROW 21.14 COL 20.17 COLON-ALIGNED NO-LABEL
     fi_covcod AT ROW 10.05 COL 87 COLON-ALIGNED NO-LABEL
     fi_polstatus AT ROW 23.86 COL 83.5 COLON-ALIGNED NO-LABEL
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1.05
         SIZE 133 BY 25.76
         BGCOLOR 3 FGCOLOR 1 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     fi_tp1 AT ROW 15.1 COL 68.5 COLON-ALIGNED NO-LABEL
     fi_tp2 AT ROW 15.1 COL 90.5 COLON-ALIGNED NO-LABEL
     fi_tp3 AT ROW 15.1 COL 112.5 COLON-ALIGNED NO-LABEL
     bu_save AT ROW 24.24 COL 111.33
     bu_exit AT ROW 24.24 COL 122
     fi_trndat AT ROW 22.14 COL 103.83 COLON-ALIGNED NO-LABEL
     fi_userid AT ROW 20.95 COL 115.17 COLON-ALIGNED NO-LABEL
     fi_trntime AT ROW 22.14 COL 118.83 COLON-ALIGNED NO-LABEL
     fi_closedat AT ROW 3.71 COL 90.67 COLON-ALIGNED NO-LABEL
     fi_bdate AT ROW 11 COL 64 COLON-ALIGNED NO-LABEL
     fi_id1 AT ROW 11 COL 89.33 COLON-ALIGNED NO-LABEL
     fi_bdate2 AT ROW 12 COL 64 COLON-ALIGNED NO-LABEL
     fi_id2 AT ROW 12 COL 89.33 COLON-ALIGNED NO-LABEL
     fi_client AT ROW 6.86 COL 102.5 COLON-ALIGNED NO-LABEL
     " Campaing :":35 VIEW-AS TEXT
          SIZE 12 BY .95 AT ROW 18.24 COL 78.67
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "Birth Date :":30 VIEW-AS TEXT
          SIZE 11 BY .95 AT ROW 12 COL 54.5
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " First TPPD :":30 VIEW-AS TEXT
          SIZE 12.5 BY .95 AT ROW 15.1 COL 35.17
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "            Brand :":30 VIEW-AS TEXT
          SIZE 15.5 BY .95 AT ROW 7.91 COL 5.33
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " ID Driver :":30 VIEW-AS TEXT
          SIZE 11.5 BY .95 AT ROW 12 COL 79.33
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "        INS Title :":30 VIEW-AS TEXT
          SIZE 15.5 BY .95 AT ROW 4.81 COL 5.5
          BGCOLOR 19 FGCOLOR 1 FONT 6
     " Policy  NEW :":35 VIEW-AS TEXT
          SIZE 15 BY .95 AT ROW 2.62 COL 38.5
          BGCOLOR 2 FGCOLOR 7 FONT 6
     "  Driver name1 :":30 VIEW-AS TEXT
          SIZE 15.5 BY .95 AT ROW 10.95 COL 5.33
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "Temp Policy :":35 VIEW-AS TEXT
          SIZE 13 BY .95 AT ROW 2.62 COL 71.5
          BGCOLOR 2 FGCOLOR 7 FONT 6
     "    Beneficiary :":30 VIEW-AS TEXT
          SIZE 15.5 BY .86 AT ROW 10 COL 5.33
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "       Address1 :":30 VIEW-AS TEXT
          SIZE 15.5 BY .95 AT ROW 5.86 COL 5.5
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "Close Date :":30 VIEW-AS TEXT
          SIZE 12 BY .95 AT ROW 3.71 COL 80.17
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " Covcod :":30 VIEW-AS TEXT
          SIZE 9.5 BY .91 AT ROW 10.05 COL 79
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "    Chassis No :":20 VIEW-AS TEXT
          SIZE 15.5 BY .95 AT ROW 8.95 COL 5.33
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " Exp_Date72 :":30 VIEW-AS TEXT
          SIZE 13.5 BY .95 AT ROW 13.05 COL 99
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "Producer code :":30 VIEW-AS TEXT
          SIZE 15.5 BY .95 AT ROW 22.14 COL 5.67
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " Year :":35 VIEW-AS TEXT
          SIZE 6.5 BY .95 AT ROW 7.95 COL 108.5
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " Sticker No :":30 VIEW-AS TEXT
          SIZE 12.5 BY .95 AT ROW 10.05 COL 96
          BGCOLOR 19 FGCOLOR 0 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1.05
         SIZE 133 BY 25.76
         BGCOLOR 3 FGCOLOR 1 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     " FT :":30 VIEW-AS TEXT
          SIZE 6 BY .95 AT ROW 16.14 COL 41.17
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " TP2 :":30 VIEW-AS TEXT
          SIZE 6.5 BY .91 AT ROW 15.1 COL 85.67
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "           DSPC :":35 VIEW-AS TEXT
          SIZE 15.5 BY .95 AT ROW 17.14 COL 5.5
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " RY2 :":30 VIEW-AS TEXT
          SIZE 6.5 BY .95 AT ROW 16.14 COL 85.67
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "       Address2 :":30 VIEW-AS TEXT
          SIZE 15.5 BY .95 AT ROW 6.86 COL 5.5
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "Com_Date72 :":30 VIEW-AS TEXT
          SIZE 14 BY .95 AT ROW 13.05 COL 68.5
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " Driver name2 :":30 VIEW-AS TEXT
          SIZE 15.33 BY .95 AT ROW 12 COL 5.5
          BGCOLOR 19 FGCOLOR 1 FONT 6
     " Engine no :":35 VIEW-AS TEXT
          SIZE 11.83 BY .95 AT ROW 9 COL 46.5
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "Other Disc :":35 VIEW-AS TEXT
          SIZE 12 BY .95 AT ROW 17.19 COL 60.17
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " Fleet Disc :":35 VIEW-AS TEXT
          SIZE 12 BY .95 AT ROW 17.19 COL 35.17
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "       Remark1 :":30 VIEW-AS TEXT
          SIZE 15.5 BY .86 AT ROW 19.24 COL 5.67
          BGCOLOR 19 FGCOLOR 1 FONT 6
     " RY3 :":30 VIEW-AS TEXT
          SIZE 6.5 BY .95 AT ROW 16.14 COL 107.67
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "       Remark3 :":30 VIEW-AS TEXT
          SIZE 15.5 BY .86 AT ROW 21.14 COL 5.67
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "Paid Date :":30 VIEW-AS TEXT
          SIZE 11.5 BY .95 AT ROW 23.86 COL 40.5
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "Total Prem :":25 VIEW-AS TEXT
          SIZE 12.33 BY .95 AT ROW 14.1 COL 100.17
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "Policy72 :":30 VIEW-AS TEXT
          SIZE 10 BY .95 AT ROW 2.62 COL 102
          BGCOLOR 2 FGCOLOR 7 FONT 6
     "        First OD :":35 VIEW-AS TEXT
          SIZE 15.5 BY .95 AT ROW 15.05 COL 5.5
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " Client Code :":30 VIEW-AS TEXT
          SIZE 13 BY 1 AT ROW 6.86 COL 91.17
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "      Load Date :":30 VIEW-AS TEXT
          SIZE 15.5 BY .95 AT ROW 3.81 COL 5.5
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "  Com_Date70 :":35 VIEW-AS TEXT
          SIZE 15.5 BY .95 AT ROW 13 COL 5.5
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " Exp_Date70 :":35 VIEW-AS TEXT
          SIZE 13.83 BY .95 AT ROW 13 COL 38.33
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " Agent code :":30 VIEW-AS TEXT
          SIZE 13 BY .95 AT ROW 22.14 COL 40.67
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "Pol Status :":30 VIEW-AS TEXT
          SIZE 11.83 BY .91 AT ROW 23.86 COL 72.83
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "   Old Policy :":35 VIEW-AS TEXT
          SIZE 15.5 BY .95 AT ROW 2.67 COL 5.67
          BGCOLOR 2 FGCOLOR 7 FONT 6
     "       Remark2 :":30 VIEW-AS TEXT
          SIZE 15.5 BY .86 AT ROW 20.19 COL 5.67
          BGCOLOR 19 FGCOLOR 1 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1.05
         SIZE 133 BY 25.76
         BGCOLOR 3 FGCOLOR 1 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     " Garage :":35 VIEW-AS TEXT
          SIZE 9 BY .95 AT ROW 10 COL 61
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "Birth Date :":30 VIEW-AS TEXT
          SIZE 11 BY .95 AT ROW 11 COL 54.67
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "IC NO:":30 VIEW-AS TEXT
          SIZE 7.5 BY .95 AT ROW 4.76 COL 93
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "TP1 :":30 VIEW-AS TEXT
          SIZE 5.83 BY .91 AT ROW 15.1 COL 64.17
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "User Closing :":30 VIEW-AS TEXT
          SIZE 14 BY .95 AT ROW 18.19 COL 42.17
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "RY1 :":30 VIEW-AS TEXT
          SIZE 6 BY .95 AT ROW 16.1 COL 64
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " Name :":30 VIEW-AS TEXT
          SIZE 8.67 BY .95 AT ROW 4.76 COL 38.83
          BGCOLOR 19 FGCOLOR 1 FONT 6
     " Seat :":30 VIEW-AS TEXT
          SIZE 7 BY .95 AT ROW 9.05 COL 101.5
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "Branch :" VIEW-AS TEXT
          SIZE 9.5 BY .95 AT ROW 22.19 COL 70.17
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " CC :":30 VIEW-AS TEXT
          SIZE 5.67 BY .95 AT ROW 8.95 COL 82.83
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "               OD :":35 VIEW-AS TEXT
          SIZE 15.5 BY .95 AT ROW 16.1 COL 5.5
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "   Account No :":30 VIEW-AS TEXT
          SIZE 15.5 BY .95 AT ROW 18.19 COL 5.67
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "         Sum  SI :":35 VIEW-AS TEXT
          SIZE 15.5 BY .95 AT ROW 14 COL 5.5
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "Ref No :":35 VIEW-AS TEXT
          SIZE 8.83 BY .95 AT ROW 3.71 COL 38.67
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "Status Confirm :":30 VIEW-AS TEXT
          SIZE 15.5 BY .95 AT ROW 23.86 COL 5.67
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "Model :":30 VIEW-AS TEXT
          SIZE 10 BY .95 AT ROW 7.95 COL 38.33
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " Prem_V70 :":30 VIEW-AS TEXT
          SIZE 12.17 BY .95 AT ROW 14.05 COL 40
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " Prem_V72 :":30 VIEW-AS TEXT
          SIZE 13 BY .95 AT ROW 14.1 COL 69.33
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " TP3 :":30 VIEW-AS TEXT
          SIZE 6.33 BY .91 AT ROW 15.1 COL 107.83
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "Licen No :":30 VIEW-AS TEXT
          SIZE 10.5 BY .95 AT ROW 7.95 COL 78
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " ID Driver :":30 VIEW-AS TEXT
          SIZE 11.5 BY .95 AT ROW 11 COL 79.33
          BGCOLOR 19 FGCOLOR 0 FONT 6
     RECT-337 AT ROW 23.86 COL 120.17
     RECT-338 AT ROW 23.86 COL 109.5
     RECT-462 AT ROW 2.33 COL 3.5
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1.05
         SIZE 133 BY 25.76
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
         TITLE              = "Update Data Lockton (TLT)"
         HEIGHT             = 26.1
         WIDTH              = 134.17
         MAX-HEIGHT         = 33.91
         MAX-WIDTH          = 170.67
         VIRTUAL-HEIGHT     = 33.91
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
/* SETTINGS FOR FILL-IN fi_addr1 IN FRAME fr_main
   ALIGN-L                                                              */
/* SETTINGS FOR FILL-IN fi_ldate IN FRAME fr_main
   NO-DISPLAY                                                           */
ASSIGN 
       fi_paydate:READ-ONLY IN FRAME fr_main        = TRUE.

ASSIGN 
       fi_polstatus:READ-ONLY IN FRAME fr_main        = TRUE.

/* SETTINGS FOR FILL-IN fi_remark1 IN FRAME fr_main
   ALIGN-L                                                              */
ASSIGN 
       fi_status:READ-ONLY IN FRAME fr_main        = TRUE.

/* SETTINGS FOR FILL-IN fi_trndat IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_trntime IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_userid IN FRAME fr_main
   NO-ENABLE                                                            */
ASSIGN 
       fi_userid:READ-ONLY IN FRAME fr_main        = TRUE.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Update Data Lockton (TLT) */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Update Data Lockton (TLT) */
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
                 /*fi_ldate     =  brstat.tlt.entdat       
                 fi_trndat    =  brstat.tlt.trndat            
                 fi_trntime   =  brstat.tlt.trntime*/      
                 brstat.tlt.nor_noti_tlt  =  trim(INPUT fi_notno)      
                 /*fi_closedat  =  brstat.tlt.datesent*/     
                 brstat.tlt.rec_name    = trim(fi_title)        
                 brstat.tlt.ins_name    = trim(fi_firstname)      
                 brstat.tlt.safe3       = trim(fi_client)                
                 brstat.tlt.ins_addr1   = trim(fi_addr1)          
                 brstat.tlt.ins_addr2   = trim(fi_addr2)        
                 brstat.tlt.brand       = trim(fi_brand)                 
                 brstat.tlt.model       = trim(fi_Model)        
                 brstat.tlt.lince1      = trim(fi_licence)      
                 brstat.tlt.lince2      = TRIM(fi_year)                 
                 brstat.tlt.cha_no      = trim(fi_cha_no)             
                 brstat.tlt.eng_no      = trim(fi_eng_no)               
                 brstat.tlt.cc_weight   = fi_ton          
                 brstat.tlt.safe1       = trim(fi_benname)      
                 brstat.tlt.filler1     = trim(fi_policy)          
                 brstat.tlt.comp_sck    = trim(fi_sckno )             
                 brstat.tlt.rec_addr5   = trim(fi_compol)       
                 brstat.tlt.stat        = trim(fi_garage)                 
                 brstat.tlt.expousr     = trim(fi_covcod)        
                 brstat.tlt.dri_name1   = trim(fi_driv1 ) 
                 brstat.tlt.dri_no1     = TRIM(fi_bdate)                
                 brstat.tlt.dri_name1   = if trim(fi_id1)  <> "" THEN brstat.tlt.dri_name1 + "/" + trim(fi_id1)  ELSE brstat.tlt.dri_name1 
                 brstat.tlt.dri_name2   = trim(fi_driv2 )  
                 brstat.tlt.dri_no2     = TRIM(fi_bdate2)
                 brstat.tlt.dri_name2   = if trim(fi_id2)  <> "" then brstat.tlt.dri_name2 + "/" + trim(fi_id2)  ELSE brstat.tlt.dri_name2 
                 brstat.tlt.gendat      = fi_comdat            
                 brstat.tlt.expodat     = fi_expdat              
                 brstat.tlt.nor_effdat  = fi_72comdat      
                 brstat.tlt.comp_effdat = fi_72expdat      
                 brstat.tlt.nor_coamt   = INPUT fi_sumsi        
                 brstat.tlt.nor_grprm   = INPUT fi_prem1       
                 brstat.tlt.comp_grprm  = INPUT fi_compprm     
                 brstat.tlt.comp_coamt  = INPUT fi_gross_amt     
                 brstat.tlt.endno       = string(fi_deduct)     
                 brstat.tlt.lince3      = string(fi_deduct2)           
                 brstat.tlt.old_eng     = string(fi_tp1)         
                 brstat.tlt.old_cha     = string(fi_tp2)         
                 brstat.tlt.comp_pol    = string(fi_tp3)         
                 brstat.tlt.nor_usr_tlt = string(fi_si)         
                 brstat.tlt.rec_addr1   = string(fi_sumfi)       
                 brstat.tlt.rec_addr4   = string(fi_dspc)                                          
                 brstat.tlt.lotno       = string(fi_fleetper)                                     
                 brstat.tlt.endcnt      = INPUT fi_othper                                       
                 brstat.tlt.sentcnt     = fi_seatnew                                
                 brstat.tlt.filler2     = TRIM(fi_remark1) +
                                          " r2:" + TRIM(fi_remark2) +
                                          " r3:" + TRIM(fi_remark3)                
                 brstat.tlt.safe2       = trim(fi_accno)              /*ContractNo      */                                      
                 brstat.tlt.nor_usr_ins = trim(fi_ins_off)            /*UserClosing     */  
                 brstat.tlt.policy      = trim(fi_polsystem)          /*PolicyNo        */                       
                 brstat.tlt.rec_addr3   = trim(fi_tempol)             /*TempPolicyNo    */ 
                 brstat.tlt.colorcod    = trim(fi_camp)               /*Campaign        */ 
                 brstat.tlt.comp_sub    = trim(fi_producer)         /*producer code*/
                 brstat.tlt.comp_noti_ins  = trim(INPUT fi_agent)        /*Agent code*/
                 brstat.tlt.EXP         = TRIM(fi_br)
                 brstat.tlt.subins      = TRIM(fi_icno).  /*A60-0272*/
                 /*fi_status    =  IF brstat.tlt.recac = "" THEN "ยังไม่Confirm " ELSE brstat.tlt.recac    
                 fi_paydate   =  brstat.tlt.dat_ins_noti       /*วันที่ matchfile confirm */
                 fi_polstatus =  IF brstat.tlt.releas = "NO" THEN "ยังไม่ออกงาน" ELSE IF INDEX(brstat.tlt.releas,"Cancel") <> 0 THEN "ยกเลิก" ELSE "ออกงานแล้ว" */
                brstat.tlt.comp_usr_tlt = "PD1:" + string(fi_pd1) +
                                          "PD2:" + STRING(fi_pd2) +
                                          "PD3:" + string(fi_pd3).
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


&Scoped-define SELF-NAME fi_agent
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_agent C-Win
ON LEAVE OF fi_agent IN FRAME fr_main
DO:
  fi_agent = INPUT fi_agent .
  DISP fi_agent WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_bdate
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_bdate C-Win
ON LEAVE OF fi_bdate IN FRAME fr_main
DO:
    fi_bdate = INPUT fi_bdate .
    DISP fi_bdate WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_bdate2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_bdate2 C-Win
ON LEAVE OF fi_bdate2 IN FRAME fr_main
DO:
    fi_bdate2 = INPUT fi_bdate2 .
    DISP fi_bdate2 WITH FRAM fr_main.
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
  fi_camp = INPUT fi_camp .
  DISP fi_camp WITH FRAM fr_main.

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


&Scoped-define SELF-NAME fi_client
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_client C-Win
ON LEAVE OF fi_client IN FRAME fr_main
DO:
  fi_client = INPUT fi_client.
  DISP fi_client WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_closedat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_closedat C-Win
ON LEAVE OF fi_closedat IN FRAME fr_main
DO:
  fi_closedat = INPUT fi_closedat .
  DISP fi_closedat WITH FRAM fr_main.
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


&Scoped-define SELF-NAME fi_compol
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_compol C-Win
ON LEAVE OF fi_compol IN FRAME fr_main
DO:
    fi_compol = INPUT fi_compol .
    DISP fi_compol WITH FRAM fr_main.
  
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


&Scoped-define SELF-NAME fi_deduct
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_deduct C-Win
ON LEAVE OF fi_deduct IN FRAME fr_main
DO:
  fi_deduct = INPUT fi_deduct.
  DISP fi_deduct WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_deduct2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_deduct2 C-Win
ON LEAVE OF fi_deduct2 IN FRAME fr_main
DO:
  fi_deduct2 =  Input  fi_deduct2.
  Disp  fi_deduct2 with frame  fr_main.
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


&Scoped-define SELF-NAME fi_dspc
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_dspc C-Win
ON LEAVE OF fi_dspc IN FRAME fr_main
DO:
    fi_dspc = INPUT fi_dspc  .
    DISP fi_dspc WITH FRAM fr_main.
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


&Scoped-define SELF-NAME fi_firstname
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_firstname C-Win
ON LEAVE OF fi_firstname IN FRAME fr_main
DO:
  fi_firstname = INPUT fi_firstname .
  DISP fi_firstname WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_fleetper
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_fleetper C-Win
ON LEAVE OF fi_fleetper IN FRAME fr_main
DO:
  fi_fleetper =  Input  fi_fleetper.
  Disp  fi_fleetper with frame  fr_main.
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
  fi_icno = INPUT fi_icno.
  DISP fi_icno WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_id1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_id1 C-Win
ON LEAVE OF fi_id1 IN FRAME fr_main
DO:
  fi_id1 = INPUT fi_id1 .
  DISP fi_id1 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_id2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_id2 C-Win
ON LEAVE OF fi_id2 IN FRAME fr_main
DO:
  fi_id2 = INPUT fi_id2 .
  DISP fi_id2 WITH FRAM fr_main.
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


&Scoped-define SELF-NAME fi_licence
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_licence C-Win
ON LEAVE OF fi_licence IN FRAME fr_main
DO:
  fi_licence =  Input  fi_licence.
  Disp  fi_licence with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_Model
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_Model C-Win
ON LEAVE OF fi_Model IN FRAME fr_main
DO:
  fi_model =  Input  fi_model.
  Disp  fi_model with frame  fr_main.
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


&Scoped-define SELF-NAME fi_othper
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_othper C-Win
ON LEAVE OF fi_othper IN FRAME fr_main
DO:
  fi_othper =  Input  fi_othper.
  Disp  fi_othper with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_paydate
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_paydate C-Win
ON LEAVE OF fi_paydate IN FRAME fr_main
DO:
  fi_paydate = INPUT fi_paydate .
  DISP fi_paydate WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_pd1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_pd1 C-Win
ON LEAVE OF fi_pd1 IN FRAME fr_main
DO:
  fi_pd1 = INPUT fi_pd1 .
  DISP fi_pd1 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_pd2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_pd2 C-Win
ON LEAVE OF fi_pd2 IN FRAME fr_main
DO:
  fi_pd2 = INPUT fi_pd2 .
  DISP fi_pd2 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_pd3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_pd3 C-Win
ON LEAVE OF fi_pd3 IN FRAME fr_main
DO:
    fi_pd3 = INPUT fi_pd3 .
    DISP fi_pd3 WITH FRAM fr_main.
  
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


&Scoped-define SELF-NAME fi_polstatus
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_polstatus C-Win
ON LEAVE OF fi_polstatus IN FRAME fr_main
DO:
    fi_polstatus = INPUT fi_polstatus .
    DISP fi_polstatus WITH FRAM fr_main.
  
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
  DISP fi_producer WITH FRAM fi_producer.

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


&Scoped-define SELF-NAME fi_sckno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_sckno C-Win
ON LEAVE OF fi_sckno IN FRAME fr_main
DO:
  fi_sckno = INPUT fi_sckno .
  DISP fi_sckno WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_seatnew
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_seatnew C-Win
ON LEAVE OF fi_seatnew IN FRAME fr_main
DO:
  fi_seatnew =  Input  fi_seatnew.
  Disp  fi_seatnew with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_si
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_si C-Win
ON LEAVE OF fi_si IN FRAME fr_main
DO:
  fi_si = INPUT fi_si .
  DISP fi_si WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_status
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_status C-Win
ON LEAVE OF fi_status IN FRAME fr_main
DO:
    fi_status = INPUT fi_status .
    DISP fi_status WITH FRAM fr_main.
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


&Scoped-define SELF-NAME fi_sumsi
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_sumsi C-Win
ON LEAVE OF fi_sumsi IN FRAME fr_main
DO:
    fi_sumsi = INPUT fi_sumsi.
    DISP fi_sumsi WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_tempol
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_tempol C-Win
ON LEAVE OF fi_tempol IN FRAME fr_main
DO:
  fi_tempol = INPUT fi_tempol.
  DISP fi_tempol WITH FRAM fr_main.
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


&Scoped-define SELF-NAME fi_tp3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_tp3 C-Win
ON LEAVE OF fi_tp3 IN FRAME fr_main
DO:
    fi_tp3 = INPUT fi_tp3.
    DISP fi_tp3 WITH FRAM fr_main.
  
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
  
  gv_prgid = "wgwqloc2".
  gv_prog  = "Query &Update Data (Lockton) ".
  RUN  WUT\WUTHEAD ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).

/*********************************************************************/ 
 /*  RUN Wut\WutwiCen ({&WINDOW-NAME}:HANDLE). */ 
  /*CURRENT-WINDOW:WINDOW-STATE = WINDOW-MAXIMIZED.*/
  SESSION:DATA-ENTRY-RETURN = YES.
  
 /* Rect-336:Move-to-top().*/
  Rect-462:Move-to-top().
  
  /*Hide    fi_difprm  in frame  {&FRAME-NAME}.*/
  
  Find  brstat.tlt  Where   Recid(tlt)  =  nv_recidtlt NO-LOCK NO-ERROR NO-WAIT .
  If  avail  tlt  Then do:
      Assign
          fi_ldate     =  brstat.tlt.entdat       
          fi_trndat    =  brstat.tlt.trndat            
          fi_trntime   =  brstat.tlt.trntime      
          fi_notno     =  brstat.tlt.nor_noti_tlt 
          fi_closedat  =  brstat.tlt.datesent     
          fi_title     =  brstat.tlt.rec_name    
          fi_firstname =  brstat.tlt.ins_name      
          fi_client    =  brstat.tlt.safe3                
          fi_addr1     =  brstat.tlt.ins_addr1     
          fi_addr2     =  brstat.tlt.ins_addr2   
          fi_brand     =  brstat.tlt.brand                
          fi_Model     =  brstat.tlt.model       
          fi_licence   =  brstat.tlt.lince1      
          fi_year      =  brstat.tlt.lince2              
          fi_cha_no    =  brstat.tlt.cha_no            
          fi_eng_no    =  brstat.tlt.eng_no              
          fi_ton       =  brstat.tlt.cc_weight   
          fi_benname   =  brstat.tlt.safe1       
          fi_policy    =  brstat.tlt.filler1        
          fi_sckno     =  brstat.tlt.comp_sck          
          fi_compol    =  brstat.tlt.rec_addr5   
          fi_garage    =  brstat.tlt.stat                  
          fi_covcod    =  brstat.tlt.expousr      
          /*fi_driv1     =  if brstat.tlt.dri_name1 <> "" and index(brstat.tlt.dri_name1,"/") <> 0 THEN  
                          substr(brstat.tlt.dri_name1,1,index(brstat.tlt.dri_name1,"/") - 1) ELSE brstat.tlt.dri_name1
          fi_driv2     =  if brstat.tlt.dri_name2 <> "" and index(brstat.tlt.dri_name2,"/") <> 0 THEN  
                          substr(brstat.tlt.dri_name2,1,index(brstat.tlt.dri_name2,"/") - 1) ELSE brstat.tlt.dri_name2*/
          fi_comdat    =  brstat.tlt.gendat           
          fi_expdat    =  brstat.tlt.expodat            
          fi_72comdat  =  brstat.tlt.nor_effdat   
          fi_72expdat  =  brstat.tlt.comp_effdat  
          fi_sumsi     =  INT(brstat.tlt.nor_coamt)       
          fi_prem1     =  deci(brstat.tlt.nor_grprm)    
          fi_compprm   =  deci(brstat.tlt.comp_grprm)   
          fi_gross_amt =  deci(brstat.tlt.comp_coamt)      
          fi_deduct    =  deci(brstat.tlt.endno)         
          fi_deduct2   =  deci(brstat.tlt.lince3)              
          fi_tp1       =  int(brstat.tlt.old_eng)      
          fi_tp2       =  int(brstat.tlt.old_cha)      
          fi_tp3       =  int(brstat.tlt.comp_pol)     
          fi_si        =  int(brstat.tlt.nor_usr_tlt)   
          fi_sumfi     =  int(brstat.tlt.rec_addr1) 
          fi_dspc      =  deci(brstat.tlt.rec_addr4)                                       
          fi_fleetper  =  deci(brstat.tlt.lotno)                                          
          fi_othper    =  deci(brstat.tlt.endcnt)                                       
          fi_seatnew   =  brstat.tlt.sentcnt                                        
          fi_remark1   =  IF index(tlt.filler2,"r2:") <> 0 THEN   Substr(tlt.filler2,1,index(tlt.filler2,"r2:") - 1) ELSE TRIM(tlt.filler2) 
          fi_remark2   =  IF index(tlt.filler2,"r2:") <> 0 THEN   Substr(tlt.filler2,index(tlt.filler2,"r2:") + 3 ) ELSE ""                 
          fi_remark2   =  IF index(fi_remark2,"r3:")  <> 0 THEN   Substr(fi_remark2,1,index(fi_remark2,"r3:") - 1) ELSE fi_remark2          
          fi_remark3   =  IF index(tlt.filler2,"r3:") <> 0 THEN   Substr(tlt.filler2,index(tlt.filler2,"r3:") + 3 ) ELSE ""                 
          fi_accno     =  brstat.tlt.safe2             /*ContractNo      */                                      
          fi_ins_off   =  brstat.tlt.nor_usr_ins     /*UserClosing     */  
          fi_polsystem =  brstat.tlt.policy         /*PolicyNo        */                       
          fi_tempol    =  brstat.tlt.rec_addr3     /*TempPolicyNo    */ 
          fi_camp      =  brstat.tlt.colorcod       /*Campaign        */ 
          fi_userid    =  brstat.tlt.usrid         
          fi_producer  =  brstat.tlt.comp_sub     /*producer code*/
          fi_agent     =  brstat.tlt.comp_noti_ins  /*Agent code*/
          fi_status    =  IF brstat.tlt.recac = "" THEN "ยังไม่Confirm " ELSE brstat.tlt.recac    /* confirm date*/ 
          fi_paydate   =  brstat.tlt.dat_ins_noti       /*วันที่ paid date */
          fi_polstatus =  IF brstat.tlt.releas = "NO" OR index(brstat.tlt.releas,"/No") <> 0 THEN "ยังไม่ออกงาน" 
                          ELSE IF INDEX(brstat.tlt.releas,"Cancel") <> 0 THEN "ยกเลิก" ELSE "ออกงานแล้ว" 
          nv_length    =  LENGTH(brstat.tlt.comp_usr_tlt)
          nv_ry3       =  TRIM(SUBSTR(brstat.tlt.comp_usr_tlt,R-INDEX(brstat.tlt.comp_usr_tlt,"PD3:") + 4,nv_length))   /*RY03     */
          nv_length    =  LENGTH(nv_ry3)                                                                               
          nv_ry2       =  TRIM(SUBSTR(brstat.tlt.comp_usr_tlt,R-INDEX(brstat.tlt.comp_usr_tlt,"PD2:") + 4,nv_length))   /*RY02     */
          nv_length    =  LENGTH(nv_ry2)                                                                               
          nv_ry1       =  TRIM(SUBSTR(brstat.tlt.comp_usr_tlt,r-index(brstat.tlt.comp_usr_tlt,"PD1:") + 4,nv_length))   /*RY01    */ 
          fi_pd1       =  if index(nv_ry1,"P") <> 0 THEN int(replace(nv_ry1,"P","")) else INT(nv_ry1)  /*A61-0142*/
          fi_pd2       =  if index(nv_ry2,"P") <> 0 THEN int(replace(nv_ry2,"P","")) else INT(nv_ry2)  /*A61-0142*/
          fi_pd3       =  if index(nv_ry3,"P") <> 0 THEN int(replace(nv_ry3,"P","")) else INT(nv_ry3)  /*A61-0142*/                              
          fi_br        =  brstat.tlt.EXP
          fi_icno      =  TRIM(brstat.tlt.subins) .  /*A60-0272*/
          IF brstat.tlt.dri_name1 <> ""   THEN DO:
              ASSIGN  nv_length = 0  
                      nv_length = LENGTH(brstat.tlt.dri_name1) 
                      fi_driv1  = if index(brstat.tlt.dri_name1,"/") <> 0 THEN TRIM(SUBSTR(brstat.tlt.dri_name1,1,index(brstat.tlt.dri_name1,"/") - 1)) 
                                  ELSE brstat.tlt.dri_name1  /*name1  */
                      fi_bdate  = trim(brstat.tlt.dri_no1)  
                      fi_id1    = if index(brstat.tlt.dri_name1,"/") <> 0 THEN TRIM(SUBSTR(brstat.tlt.dri_name1,R-INDEX(brstat.tlt.dri_name1,"/") + 1,nv_length)) 
                                  ELSE "" /*id1    */.
          END.
          IF brstat.tlt.dri_name2 <> "" THEN DO:
              ASSIGN   nv_length = 0   
                       nv_length =  LENGTH(brstat.tlt.dri_name2) 
                       fi_driv2  = if index(brstat.tlt.dri_name2,"/") <> 0 THEN TRIM(SUBSTR(brstat.tlt.dri_name2,1,index(brstat.tlt.dri_name2,"/") - 1)) 
                                   ELSE brstat.tlt.dri_name2  /*name1  */ 
                       fi_bdate2  = trim(brstat.tlt.dri_no2)
                       fi_id2    = if index(brstat.tlt.dri_name2,"/") <> 0 THEN TRIM(SUBSTR(brstat.tlt.dri_name2,R-INDEX(brstat.tlt.dri_name2,"/") + 1,nv_length)) ELSE "" /*id1    */.
          END.
          
     IF INDEX(brstat.tlt.releas,"YES") <> 0 THEN DO:
         DISABLE fi_ldate       fi_trndat       fi_trntime      fi_notno     
           fi_closedat    fi_title        fi_firstname    fi_client    
           fi_addr1       fi_addr2        fi_brand        fi_Model     
           fi_licence     fi_year         fi_cha_no       fi_eng_no    
           fi_ton         fi_benname      fi_policy       fi_sckno     
           fi_compol      fi_garage       fi_covcod       fi_driv1     
           fi_driv2       fi_comdat       fi_expdat       fi_72comdat  
           fi_72expdat    fi_sumsi        fi_prem1        fi_compprm   
           fi_gross_amt   fi_deduct       fi_deduct2      fi_tp1       
           fi_tp2         fi_tp3          fi_si           fi_sumfi     
           fi_pd1         fi_pd2          fi_pd3          fi_dspc      
           fi_fleetper    fi_othper       fi_seatnew      fi_remark1   
           fi_remark2     fi_remark2      fi_remark3      fi_accno     
           fi_ins_off     fi_polsystem    fi_tempol       fi_camp      
           fi_userid       fi_producer    fi_agent       fi_br
           fi_status      fi_paydate      fi_polstatus   bu_save
           fi_driv1       fi_bdate         fi_id1
           fi_driv2       fi_bdate2         fi_id2        fi_icno /*A60-0272*/
           WITH FRAME fr_main.
           bu_save:BGCOLOR = 18.
     END.
     Disp  fi_ldate       fi_trndat       fi_trntime      fi_notno     
           fi_closedat    fi_title        fi_firstname    fi_client    
           fi_addr1       fi_addr2        fi_brand        fi_Model     
           fi_licence     fi_year         fi_cha_no       fi_eng_no    
           fi_ton         fi_benname      fi_policy       fi_sckno     
           fi_compol      fi_garage       fi_covcod       fi_driv1     
           fi_driv2       fi_comdat       fi_expdat       fi_72comdat  
           fi_72expdat    fi_sumsi        fi_prem1        fi_compprm   
           fi_gross_amt   fi_deduct       fi_deduct2      fi_tp1       
           fi_tp2         fi_tp3          fi_si           fi_sumfi     
           fi_pd1         fi_pd2          fi_pd3          fi_dspc      
           fi_fleetper    fi_othper       fi_seatnew      fi_remark1   
           fi_remark2     fi_remark2      fi_remark3      fi_accno     
           fi_ins_off     fi_polsystem    fi_tempol       fi_camp      
           fi_userid       fi_producer     fi_agent       fi_br
           fi_status      fi_paydate      fi_polstatus 
           fi_driv1       fi_bdate         fi_id1 
           fi_driv2       fi_bdate2         fi_id2      fi_icno /*A60-0272*/
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
  DISPLAY fi_br fi_policy fi_tempol fi_dspc fi_polsystem fi_notno fi_year 
          fi_eng_no fi_ton fi_camp fi_garage fi_cha_no fi_fleetper fi_othper 
          fi_deduct fi_Model fi_seatnew fi_brand fi_licence fi_deduct2 fi_comdat 
          fi_expdat fi_sumsi fi_sumfi fi_72comdat fi_72expdat fi_pd3 fi_prem1 
          fi_compprm fi_gross_amt fi_sckno fi_si fi_ins_off fi_pd1 fi_pd2 
          fi_title fi_firstname fi_compol fi_addr1 fi_addr2 fi_status fi_driv1 
          fi_driv2 fi_paydate fi_producer fi_agent fi_icno fi_accno fi_benname 
          fi_remark1 fi_remark2 fi_remark3 fi_covcod fi_polstatus fi_tp1 fi_tp2 
          fi_tp3 fi_trndat fi_userid fi_trntime fi_closedat fi_bdate fi_id1 
          fi_bdate2 fi_id2 fi_client 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE fi_br fi_policy fi_tempol fi_dspc fi_polsystem fi_notno fi_year 
         fi_eng_no fi_ton fi_camp fi_garage fi_cha_no fi_fleetper fi_othper 
         fi_deduct fi_Model fi_seatnew fi_brand fi_licence fi_deduct2 fi_comdat 
         fi_expdat fi_sumsi fi_sumfi fi_72comdat fi_72expdat fi_pd3 fi_prem1 
         fi_compprm fi_gross_amt fi_sckno fi_si fi_ins_off fi_ldate fi_pd1 
         fi_pd2 fi_title fi_firstname fi_compol fi_addr1 fi_addr2 fi_status 
         fi_driv1 fi_driv2 fi_paydate fi_producer fi_agent fi_icno fi_accno 
         fi_benname fi_remark1 fi_remark2 fi_remark3 fi_covcod fi_polstatus 
         fi_tp1 fi_tp2 fi_tp3 bu_save bu_exit fi_closedat fi_bdate fi_id1 
         fi_bdate2 fi_id2 fi_client RECT-337 RECT-338 RECT-462 
      WITH FRAME fr_main IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

