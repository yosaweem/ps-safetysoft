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
  wgwqtib3.w    :  Quey & Update , Add data in table  tlt (TOYOTA AND HINO) New
  Create  by    :  Kridtiya i. A63-0259 Date. 04/08/2020 โปรแกรม แสดงข้อมูลรายละเอียดงาน
  modify  by    : Kridtiya i. A67-0184 Date. 24/10/2024 เพิ่ม ฟิล์ด
-------------------------------------------------------------------------*/

Def Input  parameter  nv_recidtlt  as  recid  .
Def var nv_index       as int  init 0.
DEF VAR nv_chaidrep    AS CHAR .  
DEF VAR n_length       AS INT .
DEF VAR n_exp          AS CHAR FORMAT "x(15)".
DEF VAR n_IC           AS CHAR FORMAT "x(15)".
DEF VAR n_Com          AS CHAR FORMAT "x(15)".
DEF VAR n_addr5        AS CHAR FORMAT "x(50)".
DEF VAR n_textall      AS CHAR.
def var n_Dealer       as char.
def var n_Caryear      as char.
def var n_RenewalType  as char.
def var n_ID           as char.
def var n_Branch       as char.
def var n_Producer     as char.
def var n_Agent        as char.
def var n_Prepol       as char.
def var n_Cover        as char.
def var n_Class        as char.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS fi_polstatus fi_producer fi_agent fi_access ~
fi_lotno fi_appno fi_prepol fi_Status fi_datesend fi_companycode fi_brand ~
fi_model fi_year fi_ton fi_eng_no fi_cha_no fi_licence1 fi_subinscode ~
fi_dat_ins_noti fi_cover fi_dealer fi_norgrossprmt fi_comp_effdat ~
fi_stickerno fi_comp_noti_ins fi_comp_usr_ins fi_comp_noti_tlt fi_firstname ~
fi_rec_name fi_rec_addr1 fi_rec_addr2 fi_dri_name1 fi_dri_no1 fi_dri_name2 ~
fi_dri_no2 fi_filler1 fi_filler2 bu_exit fi_Seqno fi_active fi_rec_addr5 ~
fi_color fi_norcovamt fi_brtax fi_recordtype fi_Flag fi_addr1 fi_addr2 ~
fi_addr3 fi_addr4 fi_addr5 fi_licence2 fi_licence3 fi_oldeng_no ~
fi_oldcha_no fi_rec_addr3 fi_rec_addr4 fi_Reserved5 fi_Reserved6 fi_class ~
fi_comp_usr_tlt fi_comp_pol fi_nor_effdat fi_nor_noti_tlt fi_nor_usr_tlt ~
fi_nor_noti_ins fi_nor_usr_ins fi_comp_sub fi_comp_grprm fi_comp_coamt ~
fi_garage fi_drivfg fi_drivname1 fi_drivname2 fi_drivdob1 fi_drivdob2 ~
fi_drivLin1 fi_drivLin2 fi_caruse fi_dealertlt fi_endorsum fi_endorseprm ~
fi_deduct RECT-382 RECT-383 RECT-384 
&Scoped-Define DISPLAYED-OBJECTS fi_polstatus fi_producer fi_agent ~
fi_access fi_lotno fi_appno fi_prepol fi_Status fi_datesend fi_companycode ~
fi_brand fi_model fi_year fi_ton fi_eng_no fi_cha_no fi_licence1 ~
fi_subinscode fi_dat_ins_noti fi_cover fi_dealer fi_norgrossprmt ~
fi_comp_effdat fi_stickerno fi_comp_noti_ins fi_comp_usr_ins ~
fi_comp_noti_tlt fi_firstname fi_rec_name fi_rec_addr1 fi_rec_addr2 ~
fi_dri_name1 fi_dri_no1 fi_dri_name2 fi_dri_no2 fi_filler1 fi_filler2 ~
fi_Seqno fi_active fi_rec_addr5 fi_color fi_norcovamt fi_brtax ~
fi_recordtype fi_Flag fi_addr1 fi_addr2 fi_addr3 fi_addr4 fi_addr5 ~
fi_licence2 fi_licence3 fi_oldeng_no fi_oldcha_no fi_rec_addr3 fi_rec_addr4 ~
fi_nor_exp fi_expodat fi_Reserved5 fi_Reserved6 fi_class fi_comp_usr_tlt ~
fi_comp_pol fi_nor_effdat fi_nor_noti_tlt fi_nor_usr_tlt fi_nor_noti_ins ~
fi_nor_usr_ins fi_comp_sub fi_comp_grprm fi_comp_coamt fi_garage fi_drivfg ~
fi_drivname1 fi_drivname2 fi_drivdob1 fi_drivdob2 fi_drivLin1 fi_drivLin2 ~
fi_caruse fi_dealertlt fi_endorsum fi_endorseprm fi_deduct 

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

DEFINE VARIABLE fi_access AS CHARACTER FORMAT "X(150)":U 
     VIEW-AS FILL-IN 
     SIZE 108 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_active AS CHARACTER FORMAT "X(5)":U 
     VIEW-AS FILL-IN 
     SIZE 5 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_addr1 AS CHARACTER FORMAT "X(150)":U 
     VIEW-AS FILL-IN 
     SIZE 51 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_addr2 AS CHARACTER FORMAT "X(150)":U 
     VIEW-AS FILL-IN 
     SIZE 55 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_addr3 AS CHARACTER FORMAT "X(150)":U 
     VIEW-AS FILL-IN 
     SIZE 41 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_addr4 AS CHARACTER FORMAT "X(150)":U 
     VIEW-AS FILL-IN 
     SIZE 38 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_addr5 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 20 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_agent AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 14.17 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_appno AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 25 BY .91
     BGCOLOR 10 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_brand AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 17 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_brtax AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 5 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_caruse AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 7 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_cha_no AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 40 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_class AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 7 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_color AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 13.17 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_companycode AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 8 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_comp_coamt AS DECIMAL FORMAT "->,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 14 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_comp_effdat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 13.5 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_comp_grprm AS DECIMAL FORMAT "->,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 12 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_comp_noti_ins AS CHARACTER FORMAT "X(30)":U INITIAL "0" 
     VIEW-AS FILL-IN 
     SIZE 22 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_comp_noti_tlt AS CHARACTER FORMAT "X(100)":U INITIAL "0" 
     VIEW-AS FILL-IN 
     SIZE 72.5 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_comp_pol AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 16 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_comp_sub AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 7 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_comp_usr_ins AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 27 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_comp_usr_tlt AS CHARACTER FORMAT "X(20)":U INITIAL "0" 
     VIEW-AS FILL-IN 
     SIZE 8 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_cover AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 6 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_datesend AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 16 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_dat_ins_noti AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 16 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_dealer AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 10 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_dealertlt AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 8 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_deduct AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 8 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_drivdob1 AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 12 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_drivdob2 AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 12 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_drivfg AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 6 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_drivLin1 AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 13 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_drivLin2 AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 13 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_drivname1 AS CHARACTER FORMAT "X(120)":U 
     VIEW-AS FILL-IN 
     SIZE 62 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_drivname2 AS CHARACTER FORMAT "X(120)":U 
     VIEW-AS FILL-IN 
     SIZE 62 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_dri_name1 AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 26 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_dri_name2 AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 26 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_dri_no1 AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 16 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_dri_no2 AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 16 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_endorseprm AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 12 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_endorsum AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 12 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_eng_no AS CHARACTER FORMAT "X(80)":U 
     VIEW-AS FILL-IN 
     SIZE 44 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_expodat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 16.5 BY .91
     BGCOLOR 19 FGCOLOR 6 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_filler1 AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 20 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_filler2 AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 20 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_firstname AS CHARACTER FORMAT "X(175)":U 
     VIEW-AS FILL-IN 
     SIZE 80 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_Flag AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 12 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_garage AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 5 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_licence1 AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 6 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_licence2 AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 9 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_licence3 AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 6 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_lotno AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 20 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_model AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 25 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_norcovamt AS DECIMAL FORMAT "->,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 19 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_norgrossprmt AS DECIMAL FORMAT "->,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 19 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_nor_effdat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_nor_exp AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .91
     BGCOLOR 19 FGCOLOR 6 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_nor_noti_ins AS CHARACTER FORMAT "X(30)":U INITIAL "0" 
     VIEW-AS FILL-IN 
     SIZE 24 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_nor_noti_tlt AS CHARACTER FORMAT "X(150)":U INITIAL "0" 
     VIEW-AS FILL-IN 
     SIZE 107 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_nor_usr_ins AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 33.5 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_nor_usr_tlt AS CHARACTER FORMAT "X(10)":U INITIAL "0" 
     VIEW-AS FILL-IN 
     SIZE 8 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_oldcha_no AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 23 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_oldeng_no AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 23 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_polstatus AS CHARACTER FORMAT "X(25)":U 
      VIEW-AS TEXT 
     SIZE 4 BY .91
     BGCOLOR 19 FGCOLOR 6 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_prepol AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_producer AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_recordtype AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 4.5 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_rec_addr1 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 51.5 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_rec_addr2 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 52 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_rec_addr3 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 51.5 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_rec_addr4 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 30 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_rec_addr5 AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 10 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_rec_name AS CHARACTER FORMAT "X(150)":U 
     VIEW-AS FILL-IN 
     SIZE 99.5 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_Reserved5 AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 20 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_Reserved6 AS CHARACTER FORMAT "X(150)":U 
     VIEW-AS FILL-IN 
     SIZE 26 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_Seqno AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_Status AS CHARACTER FORMAT "X(5)":U 
     VIEW-AS FILL-IN 
     SIZE 5 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_stickerno AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 20 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_subinscode AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 8 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_ton AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 10 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_year AS CHARACTER FORMAT "X(10)":U INITIAL "0" 
     VIEW-AS FILL-IN 
     SIZE 7 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE RECTANGLE RECT-382
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 10.5 BY 1.52
     BGCOLOR 4 .

DEFINE RECTANGLE RECT-383
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 131.5 BY 7.52
     BGCOLOR 29 .

DEFINE RECTANGLE RECT-384
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 131.5 BY 4.29.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     fi_polstatus AT ROW 26.38 COL 45.67 COLON-ALIGNED NO-LABEL
     fi_producer AT ROW 28.33 COL 23.5 COLON-ALIGNED NO-LABEL
     fi_agent AT ROW 28.33 COL 47 COLON-ALIGNED NO-LABEL
     fi_access AT ROW 27.38 COL 7.5 COLON-ALIGNED NO-LABEL
     fi_lotno AT ROW 2.33 COL 14.5 COLON-ALIGNED NO-LABEL
     fi_appno AT ROW 1.33 COL 101 COLON-ALIGNED NO-LABEL
     fi_prepol AT ROW 28.33 COL 73 COLON-ALIGNED NO-LABEL
     fi_Status AT ROW 2.33 COL 87.83 COLON-ALIGNED NO-LABEL
     fi_datesend AT ROW 1.33 COL 71.17 COLON-ALIGNED NO-LABEL
     fi_companycode AT ROW 1.33 COL 51.33 COLON-ALIGNED NO-LABEL
     fi_brand AT ROW 7.57 COL 8.83 COLON-ALIGNED NO-LABEL
     fi_model AT ROW 7.57 COL 32.5 COLON-ALIGNED NO-LABEL
     fi_year AT ROW 26.38 COL 24 COLON-ALIGNED NO-LABEL
     fi_ton AT ROW 7.57 COL 69.17 COLON-ALIGNED NO-LABEL
     fi_eng_no AT ROW 6.57 COL 34.83 COLON-ALIGNED NO-LABEL
     fi_cha_no AT ROW 6.57 COL 89.5 COLON-ALIGNED NO-LABEL
     fi_licence1 AT ROW 7.57 COL 107.67 COLON-ALIGNED NO-LABEL
     fi_subinscode AT ROW 8.86 COL 17.5 COLON-ALIGNED NO-LABEL
     fi_dat_ins_noti AT ROW 14.95 COL 55 COLON-ALIGNED NO-LABEL
     fi_cover AT ROW 28.33 COL 96 COLON-ALIGNED NO-LABEL
     fi_dealer AT ROW 26.38 COL 7.5 COLON-ALIGNED NO-LABEL
     fi_norgrossprmt AT ROW 8.86 COL 83.83 COLON-ALIGNED NO-LABEL
     fi_comp_effdat AT ROW 11.95 COL 117.33 COLON-ALIGNED NO-LABEL
     fi_stickerno AT ROW 12.95 COL 16.67 COLON-ALIGNED NO-LABEL
     fi_comp_noti_ins AT ROW 13.95 COL 49 COLON-ALIGNED NO-LABEL
     fi_comp_usr_ins AT ROW 13.95 COL 95.5 COLON-ALIGNED NO-LABEL
     fi_comp_noti_tlt AT ROW 12.95 COL 58.33 COLON-ALIGNED NO-LABEL
     fi_firstname AT ROW 3.52 COL 28 COLON-ALIGNED NO-LABEL
     fi_rec_name AT ROW 18.24 COL 30.33 COLON-ALIGNED NO-LABEL
     fi_rec_addr1 AT ROW 19.24 COL 11.67 COLON-ALIGNED NO-LABEL
     fi_rec_addr2 AT ROW 19.24 COL 71.33 COLON-ALIGNED NO-LABEL
     fi_dri_name1 AT ROW 15.95 COL 16.67 COLON-ALIGNED NO-LABEL
     fi_dri_no1 AT ROW 15.95 COL 59.67 COLON-ALIGNED NO-LABEL
     fi_dri_name2 AT ROW 16.95 COL 16.67 COLON-ALIGNED NO-LABEL
     fi_dri_no2 AT ROW 16.95 COL 59.67 COLON-ALIGNED NO-LABEL
     fi_filler1 AT ROW 21.19 COL 13.83 NO-LABEL
     fi_filler2 AT ROW 21.19 COL 43 COLON-ALIGNED NO-LABEL
     bu_exit AT ROW 27.91 COL 123.5
     fi_Seqno AT ROW 2.33 COL 43.83 COLON-ALIGNED NO-LABEL WIDGET-ID 10
     fi_active AT ROW 2.33 COL 74.17 COLON-ALIGNED NO-LABEL WIDGET-ID 14
     fi_rec_addr5 AT ROW 20.24 COL 113.33 COLON-ALIGNED NO-LABEL WIDGET-ID 22
     fi_color AT ROW 7.57 COL 85.5 COLON-ALIGNED NO-LABEL WIDGET-ID 26
     fi_norcovamt AT ROW 8.86 COL 44.83 COLON-ALIGNED NO-LABEL WIDGET-ID 32
     fi_brtax AT ROW 28.33 COL 7.5 COLON-ALIGNED NO-LABEL WIDGET-ID 52
     fi_recordtype AT ROW 1.33 COL 32 COLON-ALIGNED NO-LABEL WIDGET-ID 60
     fi_Flag AT ROW 2.33 COL 100.67 COLON-ALIGNED NO-LABEL WIDGET-ID 64
     fi_addr1 AT ROW 4.52 COL 14.5 COLON-ALIGNED NO-LABEL WIDGET-ID 68
     fi_addr2 AT ROW 4.52 COL 74.17 COLON-ALIGNED NO-LABEL WIDGET-ID 70
     fi_addr3 AT ROW 5.52 COL 14.5 COLON-ALIGNED NO-LABEL WIDGET-ID 76
     fi_addr4 AT ROW 5.52 COL 63.5 COLON-ALIGNED NO-LABEL WIDGET-ID 78
     fi_addr5 AT ROW 5.52 COL 109.33 COLON-ALIGNED NO-LABEL WIDGET-ID 84
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 28.5
         BGCOLOR 3 FGCOLOR 1 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     fi_licence2 AT ROW 7.57 COL 114 COLON-ALIGNED NO-LABEL WIDGET-ID 88
     fi_licence3 AT ROW 7.57 COL 123.33 COLON-ALIGNED NO-LABEL WIDGET-ID 90
     fi_oldeng_no AT ROW 15.95 COL 108 COLON-ALIGNED NO-LABEL WIDGET-ID 98
     fi_oldcha_no AT ROW 16.95 COL 108 COLON-ALIGNED NO-LABEL WIDGET-ID 96
     fi_rec_addr3 AT ROW 20.24 COL 11.67 COLON-ALIGNED NO-LABEL WIDGET-ID 104
     fi_rec_addr4 AT ROW 20.24 COL 71.33 COLON-ALIGNED NO-LABEL WIDGET-ID 106
     fi_nor_exp AT ROW 25.33 COL 28 COLON-ALIGNED NO-LABEL WIDGET-ID 114
     fi_expodat AT ROW 25.33 COL 74.33 COLON-ALIGNED NO-LABEL WIDGET-ID 118
     fi_Reserved5 AT ROW 26.38 COL 61.5 NO-LABEL WIDGET-ID 122
     fi_Reserved6 AT ROW 26.38 COL 89.5 COLON-ALIGNED NO-LABEL WIDGET-ID 124
     fi_class AT ROW 28.33 COL 108.5 COLON-ALIGNED NO-LABEL WIDGET-ID 130
     fi_comp_usr_tlt AT ROW 13.95 COL 16.67 COLON-ALIGNED NO-LABEL WIDGET-ID 134
     fi_comp_pol AT ROW 14.95 COL 16.67 COLON-ALIGNED NO-LABEL WIDGET-ID 140
     fi_nor_effdat AT ROW 8.86 COL 117 COLON-ALIGNED NO-LABEL WIDGET-ID 142
     fi_nor_noti_tlt AT ROW 9.91 COL 24 COLON-ALIGNED NO-LABEL WIDGET-ID 146
     fi_nor_usr_tlt AT ROW 10.95 COL 16.5 COLON-ALIGNED NO-LABEL WIDGET-ID 148
     fi_nor_noti_ins AT ROW 10.95 COL 48.83 COLON-ALIGNED NO-LABEL WIDGET-ID 154
     fi_nor_usr_ins AT ROW 10.95 COL 97.33 COLON-ALIGNED NO-LABEL WIDGET-ID 158
     fi_comp_sub AT ROW 11.95 COL 23.5 COLON-ALIGNED NO-LABEL WIDGET-ID 162
     fi_comp_grprm AT ROW 11.95 COL 86.5 COLON-ALIGNED NO-LABEL WIDGET-ID 168
     fi_comp_coamt AT ROW 11.95 COL 52.5 COLON-ALIGNED NO-LABEL WIDGET-ID 166
     fi_garage AT ROW 22.38 COL 10.33 NO-LABEL WIDGET-ID 176
     fi_drivfg AT ROW 22.38 COL 41.5 NO-LABEL WIDGET-ID 180
     fi_drivname1 AT ROW 23.38 COL 13.83 NO-LABEL WIDGET-ID 184
     fi_drivname2 AT ROW 24.33 COL 13.83 NO-LABEL WIDGET-ID 188
     fi_drivdob1 AT ROW 23.38 COL 87 NO-LABEL WIDGET-ID 192
     fi_drivdob2 AT ROW 24.33 COL 87 NO-LABEL WIDGET-ID 196
     fi_drivLin1 AT ROW 23.38 COL 110.33 NO-LABEL WIDGET-ID 200
     fi_drivLin2 AT ROW 24.33 COL 110.33 NO-LABEL WIDGET-ID 204
     fi_caruse AT ROW 22.38 COL 23.67 NO-LABEL WIDGET-ID 208
     fi_dealertlt AT ROW 22.38 COL 58.5 NO-LABEL WIDGET-ID 212
     fi_endorsum AT ROW 22.38 COL 95.67 NO-LABEL WIDGET-ID 216
     fi_endorseprm AT ROW 22.38 COL 120.83 NO-LABEL WIDGET-ID 220
     fi_deduct AT ROW 22.38 COL 74.67 NO-LABEL WIDGET-ID 224
     "รหัสไปรษณีย์" VIEW-AS TEXT
          SIZE 11 BY .91 AT ROW 20.24 COL 103.83 WIDGET-ID 24
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "เลขกรมธรรม์ พรบ. :":25 VIEW-AS TEXT
          SIZE 16 BY .91 AT ROW 14.95 COL 2 WIDGET-ID 138
          BGCOLOR 19 FGCOLOR 0 FONT 1
     " ปีรถ :":35 VIEW-AS TEXT
          SIZE 5.5 BY .91 AT ROW 26.38 COL 20
          BGCOLOR 19 FGCOLOR 0 FONT 1
     "  Status :":30 VIEW-AS TEXT
          SIZE 7 BY .95 AT ROW 2.33 COL 82 WIDGET-ID 30
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "Effective date :":35 VIEW-AS TEXT
          SIZE 13 BY .95 AT ROW 8.86 COL 105.33 WIDGET-ID 144
          BGCOLOR 19 FGCOLOR 0 FONT 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 28.5
         BGCOLOR 3 FGCOLOR 1 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     " ยี่ห้อรถ :":30 VIEW-AS TEXT
          SIZE 7.5 BY .91 AT ROW 7.57 COL 3
          BGCOLOR 19 FGCOLOR 0 FONT 1
     "Remark for Complusory :":25 VIEW-AS TEXT
          SIZE 20 BY .91 AT ROW 12.95 COL 39.5
          BGCOLOR 19 FGCOLOR 0 FONT 1
     " ที่อยู่จัดส่ง3 :":35 VIEW-AS TEXT
          SIZE 10 BY .91 AT ROW 20.24 COL 3 WIDGET-ID 108
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "Remark for Comprehensive :":25 VIEW-AS TEXT
          SIZE 23 BY .95 AT ROW 9.91 COL 2 WIDGET-ID 150
          BGCOLOR 19 FGCOLOR 0 FONT 1
     "รหัสผู้รับแจ้งฯ TLT. :":25 VIEW-AS TEXT
          SIZE 16 BY .91 AT ROW 10.95 COL 2 WIDGET-ID 152
          BGCOLOR 19 FGCOLOR 0 FONT 1
     "covcod":35 VIEW-AS TEXT
          SIZE 6.5 BY .91 AT ROW 28.33 COL 90.5
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "Reserved6":30 VIEW-AS TEXT
          SIZE 8.83 BY .91 AT ROW 26.38 COL 82.17 WIDGET-ID 128
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "Normal CoverageAmt :":30 VIEW-AS TEXT
          SIZE 18 BY .91 AT ROW 8.86 COL 28.17 WIDGET-ID 34
          BGCOLOR 19 FGCOLOR 0 FONT 1
     "            Lot no. :":30 VIEW-AS TEXT
          SIZE 13 BY .91 AT ROW 2.33 COL 3
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "ชื่อ :":30 VIEW-AS TEXT
          SIZE 5 BY .91 AT ROW 18.24 COL 26.5
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "Normal End coverage date :" VIEW-AS TEXT
          SIZE 26.5 BY .91 AT ROW 25.33 COL 3 WIDGET-ID 116
          BGCOLOR 19 FGCOLOR 4 FONT 6
     "เลขรับแจ้งฯ จากบ.ประกันภัย":30 VIEW-AS TEXT
          SIZE 23 BY .91 AT ROW 10.95 COL 27.17 WIDGET-ID 156
          BGCOLOR 19 FGCOLOR 0 FONT 1
     "ชื่อผู้รับแจ้งฯ ของบ.ประกันภัย":30 VIEW-AS TEXT
          SIZE 23 BY .91 AT ROW 10.95 COL 75.67 WIDGET-ID 160
          BGCOLOR 19 FGCOLOR 0 FONT 1
     "เลขที่ผู้เสียภาษีอาก :" VIEW-AS TEXT
          SIZE 16 BY .91 AT ROW 15.95 COL 45.17
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "Compl. Sub insurance code :":30 VIEW-AS TEXT
          SIZE 23 BY .91 AT ROW 11.95 COL 2 WIDGET-ID 164
          BGCOLOR 19 FGCOLOR 0 FONT 1
     "    Record type :":30 VIEW-AS TEXT
          SIZE 13 BY .91 AT ROW 1.33 COL 20.67 WIDGET-ID 62
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "              ที่อยู่ 1 :":30 VIEW-AS TEXT
          SIZE 13 BY .91 AT ROW 4.52 COL 3 WIDGET-ID 72
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "Sub insurance code :":30 VIEW-AS TEXT
          SIZE 17 BY .91 AT ROW 8.86 COL 2
          BGCOLOR 19 FGCOLOR 0 FONT 1
     "สาขาที่ของนิติบุคคล:":30 VIEW-AS TEXT
          SIZE 16 BY .91 AT ROW 15.95 COL 2
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "Compl. Gross premium :":35 VIEW-AS TEXT
          SIZE 19 BY .91 AT ROW 11.95 COL 69 WIDGET-ID 170
          BGCOLOR 19 FGCOLOR 0 FONT 1
     "Renewal type" VIEW-AS TEXT
          SIZE 13.5 BY .91 AT ROW 26.38 COL 33.67
          BGCOLOR 19 FGCOLOR 4 FONT 6
     "Compl. Coverage amount :":30 VIEW-AS TEXT
          SIZE 21 BY .91 AT ROW 11.95 COL 33 WIDGET-ID 172
          BGCOLOR 19 FGCOLOR 0 FONT 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 28.5
         BGCOLOR 3 FGCOLOR 1 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "              ที่อยู่ 3 :":30 VIEW-AS TEXT
          SIZE 13 BY .91 AT ROW 5.52 COL 3 WIDGET-ID 80
          BGCOLOR 19 FGCOLOR 2 FONT 1
     " ที่อยู่ 5 :":30 VIEW-AS TEXT
          SIZE 7 BY .91 AT ROW 5.52 COL 104 WIDGET-ID 86
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "Color :":30 VIEW-AS TEXT
          SIZE 5.5 BY .91 AT ROW 7.57 COL 81.5 WIDGET-ID 28
          BGCOLOR 19 FGCOLOR 0 FONT 1
     " ข้อมูลออกใบเสร็จรับเงิน" VIEW-AS TEXT
          SIZE 23 BY .91 AT ROW 18.19 COL 3 WIDGET-ID 174
          BGCOLOR 19 FGCOLOR 6 FONT 6
     "CC./Weight :":30 VIEW-AS TEXT
          SIZE 11 BY .91 AT ROW 7.57 COL 59.83
          BGCOLOR 19 FGCOLOR 0 FONT 1
     "ชื่อผู้รับแจ้งฯ ของบ.ประกันภัย":30 VIEW-AS TEXT
          SIZE 23 BY .91 AT ROW 13.95 COL 73.5
          BGCOLOR 19 FGCOLOR 0 FONT 1
     "หมายเลขตัวถังรถ (เดิม)":20 VIEW-AS TEXT
          SIZE 21 BY .91 AT ROW 16.95 COL 88.5 WIDGET-ID 102
          BGCOLOR 19 FGCOLOR 0 FONT 1
     "  ที่อยู่ 2 :":30 VIEW-AS TEXT
          SIZE 7 BY .91 AT ROW 20.24 COL 65.83 WIDGET-ID 110
          BGCOLOR 19 FGCOLOR 2 FONT 1
     " ชื่อผู้เอาประกัน :":30 VIEW-AS TEXT
          SIZE 13 BY .91 AT ROW 3.52 COL 16.5
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "Branch:":30 VIEW-AS TEXT
          SIZE 6.5 BY .91 AT ROW 28.33 COL 2 WIDGET-ID 54
          BGCOLOR 19 FGCOLOR 2 FONT 1
     " เลขตัวถัง :":20 VIEW-AS TEXT
          SIZE 9 BY .91 AT ROW 6.57 COL 81.5
          BGCOLOR 19 FGCOLOR 0 FONT 1
     " เลขเครื่อง :":35 VIEW-AS TEXT
          SIZE 10 BY .91 AT ROW 6.57 COL 26.5
          BGCOLOR 19 FGCOLOR 0 FONT 1
     "Compulsory End coverage date" VIEW-AS TEXT
          SIZE 30 BY .91 AT ROW 25.33 COL 45.67 WIDGET-ID 120
          BGCOLOR 19 FGCOLOR 4 FONT 6
     "  ที่อยู่ 2 :":30 VIEW-AS TEXT
          SIZE 7 BY .91 AT ROW 19.24 COL 65.83
          BGCOLOR 19 FGCOLOR 2 FONT 1
     " ข้อมูลรถและการประกันภัย" VIEW-AS TEXT
          SIZE 23 BY .91 AT ROW 6.57 COL 3
          BGCOLOR 19 FGCOLOR 6 FONT 6
     " ข้อมูลการแจ้งงาน" VIEW-AS TEXT
          SIZE 17 BY .81 AT ROW 1.33 COL 3
          BGCOLOR 19 FGCOLOR 6 FONT 6
     "  ที่อยู่จัดส่ง1 :":35 VIEW-AS TEXT
          SIZE 10 BY .91 AT ROW 19.24 COL 3
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "class":35 VIEW-AS TEXT
          SIZE 5 BY .91 AT ROW 28.33 COL 105 WIDGET-ID 132
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "    Date sent :":30 VIEW-AS TEXT
          SIZE 11 BY .91 AT ROW 1.33 COL 61.67
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "Producer :":30 VIEW-AS TEXT
          SIZE 10 BY .91 AT ROW 28.33 COL 14.83
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "Previous Pol":30 VIEW-AS TEXT
          SIZE 10 BY .91 AT ROW 28.33 COL 64.5
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "Compl. Effective date :":35 VIEW-AS TEXT
          SIZE 18 BY .95 AT ROW 11.95 COL 101
          BGCOLOR 19 FGCOLOR 0 FONT 1
     "รุ่นรถ :":30 VIEW-AS TEXT
          SIZE 6 BY .91 AT ROW 7.57 COL 28.17
          BGCOLOR 19 FGCOLOR 0 FONT 1
     " Agent :":30 VIEW-AS TEXT
          SIZE 7.33 BY .91 AT ROW 28.33 COL 41
          BGCOLOR 19 FGCOLOR 2 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 28.5
         BGCOLOR 3 FGCOLOR 1 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "    ชื่อผู้ขับขี่ คนที่ 2 :":30 VIEW-AS TEXT
          SIZE 16 BY .91 AT ROW 16.95 COL 2
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "Company code :":30 VIEW-AS TEXT
          SIZE 14 BY .91 AT ROW 1.33 COL 38.83
          BGCOLOR 19 FGCOLOR 2 FONT 1
     " ข้อมูลลูกค้า" VIEW-AS TEXT
          SIZE 13 BY 1 AT ROW 3.48 COL 3
          BGCOLOR 19 FGCOLOR 6 FONT 6
     "วันที่บ.ประกันภัย รับแจ้งฯ":30 VIEW-AS TEXT
          SIZE 21 BY .91 AT ROW 14.95 COL 35.5
          BGCOLOR 19 FGCOLOR 0 FONT 1
     "Application No. :":35 VIEW-AS TEXT
          SIZE 13 BY .91 AT ROW 1.33 COL 89.67
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "Dealer:":35 VIEW-AS TEXT
          SIZE 6.5 BY .91 AT ROW 26.38 COL 2
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "Normal Gross premium :":35 VIEW-AS TEXT
          SIZE 19 BY .91 AT ROW 8.86 COL 66.33
          BGCOLOR 19 FGCOLOR 0 FONT 1
     "Garage :":30 VIEW-AS TEXT
          SIZE 7 BY .91 AT ROW 22.38 COL 3 WIDGET-ID 178
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "Driver Flag :":30 VIEW-AS TEXT
          SIZE 10 BY .91 AT ROW 22.38 COL 31 WIDGET-ID 182
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "  Seq.no :":30 VIEW-AS TEXT
          SIZE 8 BY .91 AT ROW 2.33 COL 37.17 WIDGET-ID 12
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "Dri_Name1 :":30 VIEW-AS TEXT
          SIZE 10 BY .91 AT ROW 23.38 COL 3 WIDGET-ID 186
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "Dri_Name2 :":30 VIEW-AS TEXT
          SIZE 10 BY .91 AT ROW 24.33 COL 3 WIDGET-ID 190
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "เลขที่ใบขับขี่ คนที่ 2 :" VIEW-AS TEXT
          SIZE 16 BY .91 AT ROW 16.95 COL 45.17
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "Driver DOB1 :":30 VIEW-AS TEXT
          SIZE 10 BY .91 AT ROW 23.38 COL 76.67 WIDGET-ID 194
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "Driver DOB2 :":30 VIEW-AS TEXT
          SIZE 10 BY .91 AT ROW 24.33 COL 76.67 WIDGET-ID 198
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "Reserved1":30 VIEW-AS TEXT
          SIZE 10 BY .91 AT ROW 21.19 COL 3
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "access:":35 VIEW-AS TEXT
          SIZE 6.5 BY .91 AT ROW 27.38 COL 2
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "Driver Lin1 :":30 VIEW-AS TEXT
          SIZE 10 BY .91 AT ROW 23.38 COL 99.5 WIDGET-ID 202
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "เลขรับแจ้งฯ จากบ.ประกันภัย":30 VIEW-AS TEXT
          SIZE 23 BY .91 AT ROW 13.95 COL 27.5
          BGCOLOR 19 FGCOLOR 0 FONT 1
     "Driver Lin2 :":30 VIEW-AS TEXT
          SIZE 10 BY .91 AT ROW 24.33 COL 99.5 WIDGET-ID 206
          BGCOLOR 19 FGCOLOR 2 FONT 1
     " ทะเบียน :":30 VIEW-AS TEXT
          SIZE 8.5 BY .91 AT ROW 7.57 COL 101
          BGCOLOR 19 FGCOLOR 0 FONT 1
     "Car Use :":30 VIEW-AS TEXT
          SIZE 7.5 BY .91 AT ROW 22.38 COL 15.83 WIDGET-ID 210
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "เครื่องหมาย (พรบ.) :":35 VIEW-AS TEXT
          SIZE 16 BY .91 AT ROW 12.95 COL 2
          BGCOLOR 19 FGCOLOR 0 FONT 1
     "Dealer TLT :":30 VIEW-AS TEXT
          SIZE 10 BY .91 AT ROW 22.38 COL 48 WIDGET-ID 214
          BGCOLOR 19 FGCOLOR 2 FONT 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 28.5
         BGCOLOR 3 FGCOLOR 1 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "  Flag :":30 VIEW-AS TEXT
          SIZE 6 BY .95 AT ROW 2.33 COL 95.67 WIDGET-ID 66
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "Endorse_Sum:":30 VIEW-AS TEXT
          SIZE 12 BY .91 AT ROW 22.38 COL 83.17 WIDGET-ID 218
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "  ที่อยู่ 4 :":30 VIEW-AS TEXT
          SIZE 7 BY .91 AT ROW 5.52 COL 58 WIDGET-ID 82
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "Endorse_Prm:":30 VIEW-AS TEXT
          SIZE 12 BY .91 AT ROW 22.38 COL 108.17 WIDGET-ID 222
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "Deduct :":30 VIEW-AS TEXT
          SIZE 7 BY .91 AT ROW 22.38 COL 67.17 WIDGET-ID 226
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "   Record Active :":30 VIEW-AS TEXT
          SIZE 14 BY .95 AT ROW 2.33 COL 61.33 WIDGET-ID 16
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "  ที่อยู่ 2 :":30 VIEW-AS TEXT
          SIZE 7 BY .91 AT ROW 4.52 COL 68.33 WIDGET-ID 74
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "หมายเลขเครื่องยนต์ (เดิม)":35 VIEW-AS TEXT
          SIZE 21 BY .91 AT ROW 15.95 COL 88.5 WIDGET-ID 100
          BGCOLOR 19 FGCOLOR 0 FONT 1
     "Reserved2":30 VIEW-AS TEXT
          SIZE 10 BY .91 AT ROW 21.19 COL 34.5 WIDGET-ID 112
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "Reserved5":30 VIEW-AS TEXT
          SIZE 8.83 BY .91 AT ROW 26.38 COL 52.17 WIDGET-ID 126
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "รหัสผู้รับแจ้งฯ TLT. :":25 VIEW-AS TEXT
          SIZE 16 BY .91 AT ROW 13.95 COL 2 WIDGET-ID 136
          BGCOLOR 19 FGCOLOR 0 FONT 1
     RECT-382 AT ROW 27.67 COL 122
     RECT-383 AT ROW 1.14 COL 1.33
     RECT-384 AT ROW 18 COL 1.5
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 28.5
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
         HEIGHT             = 28.57
         WIDTH              = 133.17
         MAX-HEIGHT         = 45.81
         MAX-WIDTH          = 213.33
         VIRTUAL-HEIGHT     = 45.81
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
/* SETTINGS FOR FILL-IN fi_caruse IN FRAME fr_main
   ALIGN-L                                                              */
/* SETTINGS FOR FILL-IN fi_dealertlt IN FRAME fr_main
   ALIGN-L                                                              */
/* SETTINGS FOR FILL-IN fi_deduct IN FRAME fr_main
   ALIGN-L                                                              */
/* SETTINGS FOR FILL-IN fi_drivdob1 IN FRAME fr_main
   ALIGN-L                                                              */
/* SETTINGS FOR FILL-IN fi_drivdob2 IN FRAME fr_main
   ALIGN-L                                                              */
/* SETTINGS FOR FILL-IN fi_drivfg IN FRAME fr_main
   ALIGN-L                                                              */
/* SETTINGS FOR FILL-IN fi_drivLin1 IN FRAME fr_main
   ALIGN-L                                                              */
/* SETTINGS FOR FILL-IN fi_drivLin2 IN FRAME fr_main
   ALIGN-L                                                              */
/* SETTINGS FOR FILL-IN fi_drivname1 IN FRAME fr_main
   ALIGN-L                                                              */
/* SETTINGS FOR FILL-IN fi_drivname2 IN FRAME fr_main
   ALIGN-L                                                              */
/* SETTINGS FOR FILL-IN fi_endorseprm IN FRAME fr_main
   ALIGN-L                                                              */
/* SETTINGS FOR FILL-IN fi_endorsum IN FRAME fr_main
   ALIGN-L                                                              */
/* SETTINGS FOR FILL-IN fi_expodat IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_filler1 IN FRAME fr_main
   ALIGN-L                                                              */
/* SETTINGS FOR FILL-IN fi_garage IN FRAME fr_main
   ALIGN-L                                                              */
/* SETTINGS FOR FILL-IN fi_nor_exp IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_Reserved5 IN FRAME fr_main
   ALIGN-L                                                              */
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


&Scoped-define SELF-NAME fi_access
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_access C-Win
ON LEAVE OF fi_access IN FRAME fr_main
DO:
  fi_access = INPUT fi_access.
  DISP fi_access WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_active
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_active C-Win
ON LEAVE OF fi_active IN FRAME fr_main
DO:
    fi_active = INPUT fi_active .
    DISP fi_active WITH FRAM fr_main.
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
    DISP fi_addr4  WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_addr5
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_addr5 C-Win
ON LEAVE OF fi_addr5 IN FRAME fr_main
DO:
    fi_addr5 = INPUT fi_addr5 .
    DISP fi_addr5  WITH FRAM fr_main.

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


&Scoped-define SELF-NAME fi_appno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_appno C-Win
ON LEAVE OF fi_appno IN FRAME fr_main
DO:
    fi_appno = INPUT fi_appno .
    DISP fi_appno WITH FRAM fr_main.
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


&Scoped-define SELF-NAME fi_caruse
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_caruse C-Win
ON LEAVE OF fi_caruse IN FRAME fr_main
DO:
    fi_caruse = trim(INPUT fi_caruse).
    DISP fi_caruse with frame  fr_main.
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
  fi_class = INPUT fi_class .
  DISP fi_class WITH FRAM fr_main.
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


&Scoped-define SELF-NAME fi_companycode
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_companycode C-Win
ON LEAVE OF fi_companycode IN FRAME fr_main
DO:
    fi_companycode = INPUT fi_companycode .
    DISP fi_companycode WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_comp_coamt
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_comp_coamt C-Win
ON LEAVE OF fi_comp_coamt IN FRAME fr_main
DO:
   fi_comp_coamt = INPUT fi_comp_coamt .
    DISP  fi_comp_coamt WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_comp_effdat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_comp_effdat C-Win
ON LEAVE OF fi_comp_effdat IN FRAME fr_main
DO:
  fi_comp_effdat = INPUT fi_comp_effdat.
  DISP fi_comp_effdat WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_comp_grprm
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_comp_grprm C-Win
ON LEAVE OF fi_comp_grprm IN FRAME fr_main
DO:
  fi_comp_grprm =  Input  fi_comp_grprm.
  Disp fi_comp_grprm  with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_comp_noti_ins
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_comp_noti_ins C-Win
ON LEAVE OF fi_comp_noti_ins IN FRAME fr_main
DO:
    fi_comp_noti_ins = INPUT fi_comp_noti_ins.
    DISP fi_comp_noti_ins WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_comp_noti_tlt
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_comp_noti_tlt C-Win
ON LEAVE OF fi_comp_noti_tlt IN FRAME fr_main
DO:
  fi_comp_noti_tlt = INPUT fi_comp_noti_tlt.
  DISP fi_comp_noti_tlt WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_comp_pol
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_comp_pol C-Win
ON LEAVE OF fi_comp_pol IN FRAME fr_main
DO:
    fi_comp_pol = INPUT fi_comp_pol .
    DISP fi_comp_pol WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_comp_sub
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_comp_sub C-Win
ON LEAVE OF fi_comp_sub IN FRAME fr_main
DO:
    fi_comp_sub = INPUT fi_comp_sub .
    DISP fi_comp_sub WITH FRAM fr_main.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_comp_usr_ins
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_comp_usr_ins C-Win
ON LEAVE OF fi_comp_usr_ins IN FRAME fr_main
DO:
    fi_comp_usr_ins = INPUT fi_comp_usr_ins .
    DISP fi_comp_usr_ins WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_comp_usr_tlt
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_comp_usr_tlt C-Win
ON LEAVE OF fi_comp_usr_tlt IN FRAME fr_main
DO:
  fi_comp_usr_tlt = INPUT fi_comp_usr_tlt .
  DISP fi_comp_usr_tlt WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_cover
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_cover C-Win
ON LEAVE OF fi_cover IN FRAME fr_main
DO:
  fi_cover = INPUT fi_cover .
  DISP fi_cover  WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_datesend
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_datesend C-Win
ON LEAVE OF fi_datesend IN FRAME fr_main
DO:
    fi_datesend = INPUT fi_datesend .
    DISP fi_datesend  WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_dat_ins_noti
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_dat_ins_noti C-Win
ON LEAVE OF fi_dat_ins_noti IN FRAME fr_main
DO:
    fi_dat_ins_noti = INPUT fi_dat_ins_noti .
    DISP fi_dat_ins_noti WITH FRAM fr_main.
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


&Scoped-define SELF-NAME fi_dealertlt
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_dealertlt C-Win
ON LEAVE OF fi_dealertlt IN FRAME fr_main
DO:
    fi_dealertlt = trim(INPUT fi_dealertlt).
    DISP fi_dealertlt with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_deduct
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_deduct C-Win
ON LEAVE OF fi_deduct IN FRAME fr_main
DO:
    fi_deduct = trim(INPUT fi_deduct).
    DISP fi_deduct with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_drivdob1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_drivdob1 C-Win
ON LEAVE OF fi_drivdob1 IN FRAME fr_main
DO:
    fi_drivdob1 = trim(INPUT fi_drivdob1).
    DISP fi_drivdob1 with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_drivdob2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_drivdob2 C-Win
ON LEAVE OF fi_drivdob2 IN FRAME fr_main
DO:
    fi_drivdob2 = trim(INPUT fi_drivdob2).
    DISP fi_drivdob2 with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_drivfg
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_drivfg C-Win
ON LEAVE OF fi_drivfg IN FRAME fr_main
DO:
    fi_drivfg = trim(INPUT fi_drivfg).
    DISP fi_drivfg with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_drivLin1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_drivLin1 C-Win
ON LEAVE OF fi_drivLin1 IN FRAME fr_main
DO:
    fi_drivLin1 = trim(INPUT fi_drivLin1).
    DISP fi_drivLin1 with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_drivLin2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_drivLin2 C-Win
ON LEAVE OF fi_drivLin2 IN FRAME fr_main
DO:
    fi_drivLin2 = trim(INPUT fi_drivLin2).
    DISP fi_drivLin2 with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_drivname1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_drivname1 C-Win
ON LEAVE OF fi_drivname1 IN FRAME fr_main
DO:
    fi_drivname1 = trim(INPUT fi_drivname1).
    DISP fi_drivname1 with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_drivname2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_drivname2 C-Win
ON LEAVE OF fi_drivname2 IN FRAME fr_main
DO:
    fi_drivname2 = trim(INPUT fi_drivname2).
    DISP fi_drivname2 with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_dri_name1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_dri_name1 C-Win
ON LEAVE OF fi_dri_name1 IN FRAME fr_main
DO:
    fi_dri_name1 = INPUT fi_dri_name1 .
    DISP fi_dri_name1 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_dri_name2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_dri_name2 C-Win
ON LEAVE OF fi_dri_name2 IN FRAME fr_main
DO:
    fi_dri_name2 = INPUT fi_dri_name2.
    DISP fi_dri_name2 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_dri_no1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_dri_no1 C-Win
ON LEAVE OF fi_dri_no1 IN FRAME fr_main
DO:
    fi_dri_no1 = INPUT fi_dri_no1 .
    DISP fi_dri_no1 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_dri_no2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_dri_no2 C-Win
ON LEAVE OF fi_dri_no2 IN FRAME fr_main
DO:
    fi_dri_no2 = INPUT fi_dri_no2 .
    DISP fi_dri_no2 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_endorseprm
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_endorseprm C-Win
ON LEAVE OF fi_endorseprm IN FRAME fr_main
DO:
    fi_endorseprm = trim(INPUT fi_endorseprm).
    DISP fi_endorseprm with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_endorsum
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_endorsum C-Win
ON LEAVE OF fi_endorsum IN FRAME fr_main
DO:
    fi_endorsum = trim(INPUT fi_endorsum).
    DISP fi_endorsum with frame  fr_main.
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


&Scoped-define SELF-NAME fi_expodat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_expodat C-Win
ON LEAVE OF fi_expodat IN FRAME fr_main
DO:
    fi_expodat = INPUT fi_expodat.
    DISP fi_expodat WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_filler1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_filler1 C-Win
ON LEAVE OF fi_filler1 IN FRAME fr_main
DO:
    fi_filler1 = trim(INPUT fi_filler1).
    DISP fi_filler1 with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_filler2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_filler2 C-Win
ON LEAVE OF fi_filler2 IN FRAME fr_main
DO:
    fi_filler2 = trim(INPUT fi_filler2).
    DISP fi_filler2 with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_firstname
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_firstname C-Win
ON LEAVE OF fi_firstname IN FRAME fr_main
DO:
    fi_firstname = INPUT fi_firstname .
    DISP fi_firstname  WITH FRAM fr_main.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_Flag
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_Flag C-Win
ON LEAVE OF fi_Flag IN FRAME fr_main
DO:
    fi_Flag = INPUT fi_Flag  .
    DISP fi_Flag WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_garage
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_garage C-Win
ON LEAVE OF fi_garage IN FRAME fr_main
DO:
    fi_garage = trim(INPUT fi_garage).
    DISP fi_garage with frame  fr_main.
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


&Scoped-define SELF-NAME fi_licence3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_licence3 C-Win
ON LEAVE OF fi_licence3 IN FRAME fr_main
DO:
  fi_licence3 =  Input fi_licence3.
  Disp fi_licence3 with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_lotno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_lotno C-Win
ON LEAVE OF fi_lotno IN FRAME fr_main
DO:
    fi_lotno = INPUT fi_lotno  .
    DISP fi_lotno WITH FRAM fr_main.
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


&Scoped-define SELF-NAME fi_norcovamt
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_norcovamt C-Win
ON LEAVE OF fi_norcovamt IN FRAME fr_main
DO:
    fi_norcovamt = INPUT fi_norcovamt .
    DISP fi_norcovamt WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_norgrossprmt
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_norgrossprmt C-Win
ON LEAVE OF fi_norgrossprmt IN FRAME fr_main
DO:
  fi_norgrossprmt =  Input  fi_norgrossprmt.
  Disp  fi_norgrossprmt with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_nor_effdat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_nor_effdat C-Win
ON LEAVE OF fi_nor_effdat IN FRAME fr_main
DO:
  fi_nor_effdat = INPUT fi_nor_effdat.
  DISP fi_nor_effdat WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_nor_exp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_nor_exp C-Win
ON LEAVE OF fi_nor_exp IN FRAME fr_main
DO:
    fi_nor_exp = INPUT fi_nor_exp.
    DISP fi_nor_exp WITH FRAM fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_nor_noti_ins
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_nor_noti_ins C-Win
ON LEAVE OF fi_nor_noti_ins IN FRAME fr_main
DO:
  fi_nor_noti_ins = INPUT fi_nor_noti_ins.
  DISP fi_nor_noti_ins WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_nor_noti_tlt
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_nor_noti_tlt C-Win
ON LEAVE OF fi_nor_noti_tlt IN FRAME fr_main
DO:
  fi_nor_noti_tlt = INPUT fi_nor_noti_tlt .
  DISP fi_nor_noti_tlt WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_nor_usr_ins
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_nor_usr_ins C-Win
ON LEAVE OF fi_nor_usr_ins IN FRAME fr_main
DO:
  fi_nor_usr_ins = INPUT fi_nor_usr_ins .
  DISP fi_nor_usr_ins WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_nor_usr_tlt
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_nor_usr_tlt C-Win
ON LEAVE OF fi_nor_usr_tlt IN FRAME fr_main
DO:
  fi_nor_usr_tlt = INPUT fi_nor_usr_tlt .
  DISP fi_nor_usr_tlt WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_oldcha_no
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_oldcha_no C-Win
ON LEAVE OF fi_oldcha_no IN FRAME fr_main
DO:
    fi_oldcha_no  =  Input  fi_oldcha_no.
    Disp fi_oldcha_no with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_oldeng_no
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_oldeng_no C-Win
ON LEAVE OF fi_oldeng_no IN FRAME fr_main
DO:
    fi_oldeng_no  =  Input  fi_oldeng_no.
    Disp fi_oldeng_no with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_polstatus
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_polstatus C-Win
ON LEAVE OF fi_polstatus IN FRAME fr_main
DO:
    fi_polstatus = INPUT fi_polstatus.
    DISP fi_polstatus WITH FRAM fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_prepol
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_prepol C-Win
ON LEAVE OF fi_prepol IN FRAME fr_main
DO:
  fi_prepol = INPUT fi_prepol .
  DISP fi_prepol  WITH FRAM fr_main.

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


&Scoped-define SELF-NAME fi_recordtype
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_recordtype C-Win
ON LEAVE OF fi_recordtype IN FRAME fr_main
DO:
    fi_recordtype = INPUT fi_recordtype .
    DISP fi_recordtype WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_rec_addr1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_rec_addr1 C-Win
ON LEAVE OF fi_rec_addr1 IN FRAME fr_main
DO:
    fi_rec_addr1 = INPUT fi_rec_addr1.
    DISP fi_rec_addr1 WITH FRAM fr_main.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_rec_addr2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_rec_addr2 C-Win
ON LEAVE OF fi_rec_addr2 IN FRAME fr_main
DO:
    fi_rec_addr2 = INPUT fi_rec_addr2.
    DISP fi_rec_addr2 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_rec_addr3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_rec_addr3 C-Win
ON LEAVE OF fi_rec_addr3 IN FRAME fr_main
DO:
  fi_rec_addr3 = INPUT fi_rec_addr3 .
  DISP fi_rec_addr3 WITH FRAM fr_main.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_rec_addr4
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_rec_addr4 C-Win
ON LEAVE OF fi_rec_addr4 IN FRAME fr_main
DO:
    fi_rec_addr4 = INPUT fi_rec_addr4.
    DISP fi_rec_addr4 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_rec_addr5
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_rec_addr5 C-Win
ON LEAVE OF fi_rec_addr5 IN FRAME fr_main
DO:
    fi_rec_addr5 = INPUT fi_rec_addr5 .
    DISP fi_rec_addr5 WITH FRAM fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_rec_name
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_rec_name C-Win
ON LEAVE OF fi_rec_name IN FRAME fr_main
DO:
    fi_rec_name = INPUT fi_rec_name .
    DISP fi_rec_name WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_Reserved5
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_Reserved5 C-Win
ON LEAVE OF fi_Reserved5 IN FRAME fr_main
DO:
    fi_Reserved5 = trim(INPUT fi_Reserved5).
    DISP fi_Reserved5  with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_Reserved6
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_Reserved6 C-Win
ON LEAVE OF fi_Reserved6 IN FRAME fr_main
DO:
    fi_Reserved6 = trim(INPUT fi_Reserved6).
    DISP fi_Reserved6  with frame  fr_main.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_Seqno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_Seqno C-Win
ON LEAVE OF fi_Seqno IN FRAME fr_main
DO:
  fi_Seqno = INPUT fi_Seqno.
  DISP fi_Seqno WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_Status
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_Status C-Win
ON LEAVE OF fi_Status IN FRAME fr_main
DO:
    fi_Status = INPUT fi_Status  .
    DISP fi_Status WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_stickerno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_stickerno C-Win
ON LEAVE OF fi_stickerno IN FRAME fr_main
DO:
    fi_stickerno = INPUT fi_stickerno.
    DISP fi_stickerno WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_subinscode
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_subinscode C-Win
ON LEAVE OF fi_subinscode IN FRAME fr_main
DO:
    fi_subinscode = INPUT fi_subinscode .
    DISP fi_subinscode WITH FRAM fr_main.

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
  
  gv_prgid = "wgwqtib3".
  gv_prog  = "Query & Update Data  (TOYOTA & HINO) ".
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
          n_Dealer      = ""
          n_Caryear     = ""
          n_RenewalType = ""
          n_ID          = ""
          n_Branch      = ""
          n_Producer    = ""
          n_Agent       = ""
          n_Prepol      = ""
          n_Cover       = ""
          n_Class       = "" 
        fi_recordtype     = SUBSTR(tlt.usrsent,1,1)
        fi_companycode    = SUBSTR(tlt.usrsent,2,4)
        fi_datesend       =  tlt.datesent 
        fi_appno          = SUBSTR(tlt.usrsent,6,10)
        fi_lotno          =  tlt.lotno        
        fi_Seqno          =  tlt.seqno        
        fi_active         =  tlt.recac        
        fi_Status         =  tlt.stat         
        fi_Flag           =  tlt.flag
        fi_firstname      =  tlt.ins_name      
        fi_addr1          =  tlt.ins_addr1    
        fi_addr2          =  tlt.ins_addr2    
        fi_addr3          =  tlt.ins_addr3    
        fi_addr4          =  tlt.ins_addr4    
        fi_addr5          =  tlt.ins_addr5    
        fi_eng_no         =  tlt.eng_no       
        fi_cha_no         =  tlt.cha_no       
        fi_brand          =  tlt.brand        
        fi_model          =  tlt.model        
        fi_ton            =  tlt.cc_weight   
        fi_color          =  tlt.colorcod     
        fi_licence1       =  tlt.lince1       
        fi_licence2       =  tlt.lince2       
        fi_licence3       =  tlt.lince3       
        fi_subinscode     =  tlt.subins       
        fi_norcovamt      =  tlt.nor_coamt    
        fi_norgrossprmt   =  tlt.nor_grprm    
        fi_nor_effdat     =  tlt.nor_effdat   
        fi_nor_noti_tlt   =  tlt.nor_noti_tlt 
        fi_nor_usr_tlt    =  tlt.nor_usr_tlt  
        fi_nor_noti_ins   =  tlt.nor_noti_ins 
        fi_nor_usr_ins    =  tlt.nor_usr_ins   
        fi_comp_sub       =  tlt.comp_sub     
        fi_comp_coamt     =  tlt.comp_coamt   
        fi_comp_grprm     =  tlt.comp_grprm   
        fi_comp_effdat    =  tlt.comp_effdat  
        fi_stickerno      =  tlt.comp_sck     
        fi_comp_noti_tlt  =  tlt.comp_noti_tlt
        fi_comp_usr_tlt   =  tlt.comp_usr_tlt 
        fi_comp_noti_ins  =  tlt.comp_noti_ins
        fi_comp_usr_ins   =  tlt.comp_usr_ins 
        fi_comp_pol       =  tlt.comp_pol     
        fi_dat_ins_noti   =  tlt.dat_ins_noti   
        fi_dri_name1      =  tlt.dri_name1    
        fi_dri_name2      =  tlt.dri_name2    
        fi_dri_no1        =  tlt.dri_no1      
        fi_dri_no2        =  tlt.dri_no2      
        fi_oldeng_no      =  tlt.old_eng      
        fi_oldcha_no      =  tlt.old_cha      
        fi_rec_name       =  tlt.rec_name     
        fi_rec_addr1      =  tlt.rec_addr1    
        fi_rec_addr2      =  tlt.rec_addr2    
        fi_rec_addr3      =  tlt.rec_addr3    
        fi_rec_addr4      =  tlt.rec_addr4    
        fi_rec_addr5      =  tlt.rec_addr5    
        fi_filler1        =  tlt.filler1      
        fi_filler2        =  tlt.filler2      
        fi_nor_exp        =  date(tlt.exp)          
        fi_expodat        =  tlt.expodat
        fi_Reserved5      =  tlt.safe2        
        fi_access         =  tlt.safe3    
        n_textall         =  tlt.safe1 
        fi_garage      = tlt.note8  
        fi_drivfg      = tlt.note9
        fi_drivname1   = tlt.dri_name1
        fi_drivdob1    = tlt.note1                 
        fi_drivLin1    = tlt.dri_lic1               
        fi_drivname2   = tlt.dri_name2           
        fi_drivdob2    = tlt.note2          
        fi_drivLin2    = tlt.dri_lic2            
        fi_caruse      = tlt.note4  
        fi_dealertlt   = tlt.note3
        fi_deduct      = tlt.note5  
        fi_endorsum    = tlt.note6  
        fi_endorseprm  = tlt.note7   .


      IF n_textall <> "" THEN DO:
          ASSIGN 
              n_Class   = SUBSTR(n_textall,INDEX(n_textall,"Class:"))
              n_Class   = trim(REPLACE(n_Class,"Class:",""))
              n_textall = SUBSTR(n_textall,1,INDEX(n_textall,"Class:") - 1 )

              n_Cover   = SUBSTR(n_textall,INDEX(n_textall,"Cover:"))
              n_Cover   = trim(REPLACE(n_Cover,"Cover:",""))
              n_textall = SUBSTR(n_textall,1,INDEX(n_textall,"Cover:") - 1 )

              n_Prepol   = SUBSTR(n_textall,INDEX(n_textall,"Prepol:"))
              n_Prepol   = trim(REPLACE(n_Prepol,"Prepol:",""))
              n_textall  = SUBSTR(n_textall,1,INDEX(n_textall,"Prepol:") - 1 )

              n_Agent    = SUBSTR(n_textall,INDEX(n_textall,"Agent:"))
              n_Agent    = trim(REPLACE(n_Agent,"Agent:",""))
              n_textall  = SUBSTR(n_textall,1,INDEX(n_textall,"Agent:") - 1 )

              n_Producer = SUBSTR(n_textall,INDEX(n_textall,"Producer:"))
              n_Producer = trim(REPLACE(n_Producer,"Producer:",""))
              n_textall  = SUBSTR(n_textall,1,INDEX(n_textall,"Producer:") - 1 )

              n_Branch   = SUBSTR(n_textall,INDEX(n_textall,"Branch:"))
              n_Branch   = trim(REPLACE(n_Branch,"Branch:",""))
              n_textall  = SUBSTR(n_textall,1,INDEX(n_textall,"Branch:") - 1 )

              n_ID       = SUBSTR(n_textall,INDEX(n_textall,"ID:"))
              n_ID       = trim(REPLACE(n_ID,"ID:",""))
              n_textall  = SUBSTR(n_textall,1,INDEX(n_textall,"ID:") - 1 )

              n_RenewalType = SUBSTR(n_textall,INDEX(n_textall,"RenewalType:"))
              n_RenewalType = trim(REPLACE(n_RenewalType,"RenewalType:",""))
              n_textall     = SUBSTR(n_textall,1,INDEX(n_textall,"RenewalType:") - 1 )

              n_Caryear     = SUBSTR(n_textall,INDEX(n_textall,"Caryear:"))
              n_Caryear     = trim(REPLACE(n_Caryear,"Caryear:",""))
              n_textall     = SUBSTR(n_textall,1,INDEX(n_textall,"Caryear:") - 1 )

               
              n_Dealer      = trim(REPLACE(n_textall,"Dealer:",""))

               .

 ASSIGN 
             fi_dealer      = n_Dealer     
             fi_year        = n_Caryear    
             fi_polstatus   = n_RenewalType
             fi_Reserved6   = n_ID         
             fi_brtax       = n_Branch     
             fi_producer    = n_Producer   
             fi_agent       = n_Agent      
             fi_prepol      = n_Prepol     
             fi_cover       = n_Cover      
             fi_class       = n_Class
     .  
      END.
      Disp  
          fi_recordtype     fi_companycode   fi_datesend     fi_appno            fi_lotno        fi_Seqno            
          fi_active         fi_Status        fi_Flag         fi_firstname        fi_addr1        fi_addr2            
          fi_addr3          fi_addr4         fi_addr5        fi_eng_no           fi_cha_no       fi_brand       
          fi_model          fi_ton           fi_color        fi_licence1         fi_licence2     fi_licence3         
          fi_subinscode     fi_norcovamt     fi_norgrossprmt fi_nor_effdat       fi_nor_noti_tlt fi_nor_usr_tlt  
          fi_nor_noti_ins   fi_nor_usr_ins   fi_comp_sub     fi_comp_coamt       fi_comp_grprm   fi_comp_effdat   
          fi_stickerno      fi_comp_noti_tlt fi_comp_usr_tlt fi_comp_noti_ins    fi_comp_usr_ins fi_comp_pol         
          fi_dat_ins_noti   fi_dri_name1     fi_dri_name2    fi_dri_no1          fi_dri_no2      fi_oldeng_no    
          fi_oldcha_no      fi_rec_name      fi_rec_addr1    fi_rec_addr2        fi_rec_addr3    fi_rec_addr4    
          fi_rec_addr5      fi_filler1       fi_filler2      fi_nor_exp          fi_expodat      fi_dealer       
          fi_year           fi_polstatus     fi_Reserved5    fi_Reserved6        fi_access       fi_brtax       
          fi_producer       fi_agent         fi_prepol       fi_cover            fi_class   
          fi_garage       fi_drivfg      fi_drivname1   fi_drivdob1   fi_drivLin1    fi_drivname2  
          fi_drivdob2   fi_drivLin2   fi_caruse     fi_dealertlt  fi_deduct        fi_endorsum   
          fi_endorseprm 
          
          
          
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
  DISPLAY fi_polstatus fi_producer fi_agent fi_access fi_lotno fi_appno 
          fi_prepol fi_Status fi_datesend fi_companycode fi_brand fi_model 
          fi_year fi_ton fi_eng_no fi_cha_no fi_licence1 fi_subinscode 
          fi_dat_ins_noti fi_cover fi_dealer fi_norgrossprmt fi_comp_effdat 
          fi_stickerno fi_comp_noti_ins fi_comp_usr_ins fi_comp_noti_tlt 
          fi_firstname fi_rec_name fi_rec_addr1 fi_rec_addr2 fi_dri_name1 
          fi_dri_no1 fi_dri_name2 fi_dri_no2 fi_filler1 fi_filler2 fi_Seqno 
          fi_active fi_rec_addr5 fi_color fi_norcovamt fi_brtax fi_recordtype 
          fi_Flag fi_addr1 fi_addr2 fi_addr3 fi_addr4 fi_addr5 fi_licence2 
          fi_licence3 fi_oldeng_no fi_oldcha_no fi_rec_addr3 fi_rec_addr4 
          fi_nor_exp fi_expodat fi_Reserved5 fi_Reserved6 fi_class 
          fi_comp_usr_tlt fi_comp_pol fi_nor_effdat fi_nor_noti_tlt 
          fi_nor_usr_tlt fi_nor_noti_ins fi_nor_usr_ins fi_comp_sub 
          fi_comp_grprm fi_comp_coamt fi_garage fi_drivfg fi_drivname1 
          fi_drivname2 fi_drivdob1 fi_drivdob2 fi_drivLin1 fi_drivLin2 fi_caruse 
          fi_dealertlt fi_endorsum fi_endorseprm fi_deduct 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE fi_polstatus fi_producer fi_agent fi_access fi_lotno fi_appno 
         fi_prepol fi_Status fi_datesend fi_companycode fi_brand fi_model 
         fi_year fi_ton fi_eng_no fi_cha_no fi_licence1 fi_subinscode 
         fi_dat_ins_noti fi_cover fi_dealer fi_norgrossprmt fi_comp_effdat 
         fi_stickerno fi_comp_noti_ins fi_comp_usr_ins fi_comp_noti_tlt 
         fi_firstname fi_rec_name fi_rec_addr1 fi_rec_addr2 fi_dri_name1 
         fi_dri_no1 fi_dri_name2 fi_dri_no2 fi_filler1 fi_filler2 bu_exit 
         fi_Seqno fi_active fi_rec_addr5 fi_color fi_norcovamt fi_brtax 
         fi_recordtype fi_Flag fi_addr1 fi_addr2 fi_addr3 fi_addr4 fi_addr5 
         fi_licence2 fi_licence3 fi_oldeng_no fi_oldcha_no fi_rec_addr3 
         fi_rec_addr4 fi_Reserved5 fi_Reserved6 fi_class fi_comp_usr_tlt 
         fi_comp_pol fi_nor_effdat fi_nor_noti_tlt fi_nor_usr_tlt 
         fi_nor_noti_ins fi_nor_usr_ins fi_comp_sub fi_comp_grprm fi_comp_coamt 
         fi_garage fi_drivfg fi_drivname1 fi_drivname2 fi_drivdob1 fi_drivdob2 
         fi_drivLin1 fi_drivLin2 fi_caruse fi_dealertlt fi_endorsum 
         fi_endorseprm fi_deduct RECT-382 RECT-383 RECT-384 
      WITH FRAME fr_main IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

