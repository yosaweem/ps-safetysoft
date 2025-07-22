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
program id       :  wuwqukk2.w 
program name     :  Update data KK to create  new policy  Add in table  tlt  
                    Quey & Update data before Gen.
Create  by       :  Kridtiya i. A54-0351  On   14/11/2011
Database Connect :  gw_stat ld brstat , gw_safe ld sic_bran ,sic_test ld sicuw sicsyac :not connect stat
modify by        : Ranu I. A60-0232  date.01/06/2017 เพิ่มช่องแสดงข้อมูล 
Modify by        : Ranu I. A61-0335  date. 11/07/2018 เพิ่มช่อง kkapp , ผู้รับผลประโยชน์ , ที่จัดส่งเอกสาร , ผู้รับเอกสาร 
+++++++++++++++++++++++++++++++++++++++++++++++*/
Def  Input  parameter  nv_recidtlt  as  recid  .
Def  var nv_index  as int  init 0.
DEF VAR n_text AS CHAR FORMAT "x(250)".

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS fi_ins_comp fi_notno fi_polsystem fi_cmrcode ~
fi_pro_off fi_policy fi_campaign fi_subcamp fi_typename fi_institle ~
fi_insaddr1 fi_insaddr2 fi_insaddr3 fi_insaddr4 fi_insaddr5 fi_covcod ~
fi_garage fi_subclass fi_province fi_brand fi_model fi_status fi_licence ~
fi_cha_no fi_eng_no fi_year fi_power fi_ton fi_sumsi fi_prem1 fi_sumsi2 ~
fi_prem2 fi_drivno1 fi_drivno2 fi_receipt fi_addr_re1 fi_addr_re2 ~
fi_addr_re3 fi_addr_re4 fi_addr_re5 fi_fleetper fi_ncbper fi_client ~
fi_agent fi_remark1 fi_remark2 bu_save bu_exit fi_benname fi_sumFI fi_phone ~
fi_icno fi_occup fi_cstatus fi_dealer fi_tax fi_tname1 fi_tname2 fi_tname3 ~
fi_icno1 fi_icno2 fi_icno3 fi_bdate fi_cname1 fi_cname2 fi_cname3 fi_lname1 ~
fi_lname2 fi_lname3 fi_kkapp fi_bennefit fi_send fi_sendname RECT-335 ~
RECT-343 RECT-344 
&Scoped-Define DISPLAYED-OBJECTS fi_notdat fi_nottim fi_receivdat ~
fi_ins_comp fi_notno fi_polsystem fi_cmrcode fi_pro_off fi_policy ~
fi_campaign fi_subcamp fi_typename fi_institle fi_insaddr1 fi_insaddr2 ~
fi_insaddr3 fi_insaddr4 fi_insaddr5 fi_covcod fi_garage fi_comdat fi_expdat ~
fi_subclass fi_province fi_brand fi_model fi_status fi_licence fi_cha_no ~
fi_eng_no fi_year fi_power fi_ton fi_sumsi fi_prem1 fi_sumsi2 fi_prem2 ~
fi_drivno1 fi_drivno2 fi_ins_off fi_receipt fi_addr_re1 fi_addr_re2 ~
fi_addr_re3 fi_addr_re4 fi_addr_re5 fi_fleetper fi_ncbper fi_client ~
fi_agent fi_remark1 fi_remark2 fi_trndat fi_userid fi_benname fi_sumFI ~
fi_phone fi_icno fi_occup fi_cstatus fi_dealer fi_tax fi_tname1 fi_tname2 ~
fi_tname3 fi_icno1 fi_icno2 fi_icno3 fi_bdate fi_cname1 fi_cname2 fi_cname3 ~
fi_lname1 fi_lname2 fi_lname3 fi_kkapp fi_bennefit fi_send fi_sendname 

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
     SIZE 8 BY 1.05
     FONT 6.

DEFINE BUTTON bu_save 
     LABEL "Save" 
     SIZE 8 BY 1.05
     FONT 6.

DEFINE VARIABLE fi_addr_re1 AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 39.83 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_addr_re2 AS CHARACTER FORMAT "X(35)":U 
     VIEW-AS FILL-IN 
     SIZE 20.83 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_addr_re3 AS CHARACTER FORMAT "X(35)":U 
     VIEW-AS FILL-IN 
     SIZE 26 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_addr_re4 AS CHARACTER FORMAT "X(35)":U 
     VIEW-AS FILL-IN 
     SIZE 27.83 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_addr_re5 AS CHARACTER FORMAT "X(8)":U 
     VIEW-AS FILL-IN 
     SIZE 12.83 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_agent AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_bdate AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_benname AS CHARACTER FORMAT "X(200)":U 
     VIEW-AS FILL-IN 
     SIZE 113 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_bennefit AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 38.83 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_brand AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 14.5 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_campaign AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 20 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_cha_no AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 23 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_client AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_cmrcode AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 6.17 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_cname1 AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 22 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_cname2 AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 22 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_cname3 AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 22 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_comdat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 14.5 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_covcod AS CHARACTER FORMAT "X(1)":U 
     VIEW-AS FILL-IN 
     SIZE 7 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_cstatus AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 10 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_dealer AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_drivno1 AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 49 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_drivno2 AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 49 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_eng_no AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 18.67 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_expdat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 16.5 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_fleetper AS DECIMAL FORMAT ">>9.99":U INITIAL ? 
     VIEW-AS FILL-IN 
     SIZE 12.67 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_garage AS CHARACTER FORMAT "X(1)":U INITIAL ? 
     VIEW-AS FILL-IN 
     SIZE 5.17 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_icno AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 18.67 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_icno1 AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 18.67 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_icno2 AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 18.67 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_icno3 AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 18.67 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_insaddr1 AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 45.83 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_insaddr2 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 16.17 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_insaddr3 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 23.5 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_insaddr4 AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 23.5 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_insaddr5 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 13.83 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_institle AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 35 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_ins_comp AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 34 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_ins_off AS CHARACTER FORMAT "X(60)":U 
     VIEW-AS FILL-IN 
     SIZE 23.5 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_kkapp AS CHARACTER FORMAT "X(26)":U 
     VIEW-AS FILL-IN 
     SIZE 19.83 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_licence AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 20.5 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_lname1 AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 21.67 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_lname2 AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 21.67 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_lname3 AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 21.67 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_model AS CHARACTER FORMAT "X(45)":U 
     VIEW-AS FILL-IN 
     SIZE 26.5 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_ncbper AS DECIMAL FORMAT "->>>>9.99":U INITIAL ? 
     VIEW-AS FILL-IN 
     SIZE 15.5 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_notdat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 13 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_notno AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 17 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_nottim AS CHARACTER FORMAT "X(12)":U 
     VIEW-AS FILL-IN 
     SIZE 10 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_occup AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 35.17 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_phone AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 14.5 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_policy AS CHARACTER FORMAT "X(26)":U 
     VIEW-AS FILL-IN 
     SIZE 17 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_polsystem AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 16.33 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_power AS DECIMAL FORMAT ">>,>>9.99":U INITIAL ? 
     VIEW-AS FILL-IN 
     SIZE 10.5 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_prem1 AS DECIMAL FORMAT "->>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 14.17 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_prem2 AS DECIMAL FORMAT "->>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 13.5 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_province AS CHARACTER FORMAT "X(55)":U 
     VIEW-AS FILL-IN 
     SIZE 42.17 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_pro_off AS CHARACTER FORMAT "X(35)":U 
     VIEW-AS FILL-IN 
     SIZE 18.5 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_receipt AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 36.17 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_receivdat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 13 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_remark1 AS CHARACTER FORMAT "X(200)":U 
     VIEW-AS FILL-IN 
     SIZE 90 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_remark2 AS CHARACTER FORMAT "X(200)":U 
     VIEW-AS FILL-IN 
     SIZE 90 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_send AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 43.67 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_sendname AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 42.5 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_status AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 7.33 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_subcamp AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 18.67 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_subclass AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 8.17 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_sumFI AS DECIMAL FORMAT "->>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 15.67 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_sumsi AS INTEGER FORMAT ">>>,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 17 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_sumsi2 AS DECIMAL FORMAT "->>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 17.17 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_tax AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 33 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_tname1 AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 12 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_tname2 AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 12 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_tname3 AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 12 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_ton AS DECIMAL FORMAT ">,>>9.99":U INITIAL ? 
     VIEW-AS FILL-IN 
     SIZE 10 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_trndat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 17 BY 1
     BGCOLOR 5 FGCOLOR 4 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_typename AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 13.67 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_userid AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 9 BY 1
     BGCOLOR 7 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_year AS CHARACTER FORMAT "X(5)":U INITIAL "0" 
     VIEW-AS FILL-IN 
     SIZE 9.5 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE RECTANGLE RECT-335
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 131.33 BY 23.81
     BGCOLOR 19 FGCOLOR 0 .

DEFINE RECTANGLE RECT-343
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 10 BY 1.91
     BGCOLOR 3 FGCOLOR 0 .

DEFINE RECTANGLE RECT-344
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 10 BY 1.91
     BGCOLOR 4 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     fi_notdat AT ROW 1.19 COL 15.33 COLON-ALIGNED NO-LABEL
     fi_nottim AT ROW 1.19 COL 39.5 COLON-ALIGNED NO-LABEL
     fi_receivdat AT ROW 1.19 COL 65 COLON-ALIGNED NO-LABEL
     fi_ins_comp AT ROW 1.19 COL 95 COLON-ALIGNED NO-LABEL
     fi_notno AT ROW 2.24 COL 15.5 COLON-ALIGNED NO-LABEL
     fi_polsystem AT ROW 2.24 COL 46.17 COLON-ALIGNED NO-LABEL
     fi_cmrcode AT ROW 2.24 COL 73.33 COLON-ALIGNED NO-LABEL
     fi_pro_off AT ROW 2.24 COL 90.5 COLON-ALIGNED NO-LABEL
     fi_policy AT ROW 3.29 COL 15.5 COLON-ALIGNED NO-LABEL
     fi_campaign AT ROW 3.29 COL 77.5 COLON-ALIGNED NO-LABEL
     fi_subcamp AT ROW 3.29 COL 110.33 COLON-ALIGNED NO-LABEL
     fi_typename AT ROW 2.24 COL 115.67 COLON-ALIGNED NO-LABEL
     fi_institle AT ROW 4.33 COL 15.5 COLON-ALIGNED NO-LABEL
     fi_insaddr1 AT ROW 4.33 COL 58.67 COLON-ALIGNED NO-LABEL
     fi_insaddr2 AT ROW 4.33 COL 112.67 COLON-ALIGNED NO-LABEL
     fi_insaddr3 AT ROW 5.38 COL 15.5 COLON-ALIGNED NO-LABEL
     fi_insaddr4 AT ROW 5.38 COL 47.5 COLON-ALIGNED NO-LABEL
     fi_insaddr5 AT ROW 5.38 COL 79.17 COLON-ALIGNED NO-LABEL
     fi_covcod AT ROW 5.38 COL 102 COLON-ALIGNED NO-LABEL
     fi_garage AT ROW 5.38 COL 118.83 COLON-ALIGNED NO-LABEL
     fi_comdat AT ROW 6.43 COL 15.5 COLON-ALIGNED NO-LABEL
     fi_expdat AT ROW 6.48 COL 41.67 COLON-ALIGNED NO-LABEL
     fi_subclass AT ROW 6.43 COL 65.5 COLON-ALIGNED NO-LABEL
     fi_province AT ROW 6.43 COL 81.83 COLON-ALIGNED NO-LABEL
     fi_brand AT ROW 7.48 COL 15.5 COLON-ALIGNED NO-LABEL
     fi_model AT ROW 7.52 COL 38.83 COLON-ALIGNED NO-LABEL
     fi_status AT ROW 7.48 COL 73.5 COLON-ALIGNED NO-LABEL
     fi_licence AT ROW 7.48 COL 90.83 COLON-ALIGNED NO-LABEL
     fi_cha_no AT ROW 8.52 COL 15.5 COLON-ALIGNED NO-LABEL
     fi_eng_no AT ROW 8.57 COL 47.83 COLON-ALIGNED NO-LABEL
     fi_year AT ROW 7.52 COL 120 COLON-ALIGNED NO-LABEL
     fi_power AT ROW 8.57 COL 71.83 COLON-ALIGNED NO-LABEL
     fi_ton AT ROW 8.52 COL 88.67 COLON-ALIGNED NO-LABEL
     fi_sumsi AT ROW 9.62 COL 15.5 COLON-ALIGNED NO-LABEL
     fi_prem1 AT ROW 9.62 COL 42.17 COLON-ALIGNED NO-LABEL
     fi_sumsi2 AT ROW 9.62 COL 65.67 COLON-ALIGNED NO-LABEL
     fi_prem2 AT ROW 9.57 COL 116 COLON-ALIGNED NO-LABEL
     fi_drivno1 AT ROW 12.76 COL 15.5 COLON-ALIGNED NO-LABEL
     fi_drivno2 AT ROW 12.76 COL 79.5 COLON-ALIGNED NO-LABEL
     fi_ins_off AT ROW 8.57 COL 106 COLON-ALIGNED NO-LABEL
     fi_receipt AT ROW 13.81 COL 15.5 COLON-ALIGNED NO-LABEL
     fi_addr_re1 AT ROW 13.81 COL 59.17 COLON-ALIGNED NO-LABEL
     fi_addr_re2 AT ROW 13.76 COL 107.5 COLON-ALIGNED NO-LABEL
     fi_addr_re3 AT ROW 14.86 COL 15.5 COLON-ALIGNED NO-LABEL
     fi_addr_re4 AT ROW 14.91 COL 50.17 COLON-ALIGNED NO-LABEL
     fi_addr_re5 AT ROW 14.91 COL 86.17 COLON-ALIGNED NO-LABEL
     fi_fleetper AT ROW 10.67 COL 15.5 COLON-ALIGNED NO-LABEL
     fi_ncbper AT ROW 10.67 COL 40.17 COLON-ALIGNED NO-LABEL
     fi_client AT ROW 17.1 COL 84 COLON-ALIGNED NO-LABEL
     fi_agent AT ROW 17.1 COL 113 COLON-ALIGNED NO-LABEL
     fi_remark1 AT ROW 22.38 COL 15.5 COLON-ALIGNED NO-LABEL
     fi_remark2 AT ROW 23.38 COL 15.5 COLON-ALIGNED NO-LABEL
     bu_save AT ROW 23.05 COL 112.17
     bu_exit AT ROW 23.05 COL 122.33
     fi_trndat AT ROW 19.91 COL 111 COLON-ALIGNED NO-LABEL
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1.05
         SIZE 132.5 BY 24
         BGCOLOR 3 FGCOLOR 1 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     fi_userid AT ROW 18.91 COL 118.5 COLON-ALIGNED NO-LABEL
     fi_benname AT ROW 11.76 COL 15.5 COLON-ALIGNED NO-LABEL
     fi_sumFI AT ROW 9.62 COL 91.67 COLON-ALIGNED NO-LABEL
     fi_phone AT ROW 14.91 COL 112 COLON-ALIGNED NO-LABEL
     fi_icno AT ROW 15.95 COL 15.5 COLON-ALIGNED NO-LABEL
     fi_occup AT ROW 16 COL 44.83 COLON-ALIGNED NO-LABEL
     fi_cstatus AT ROW 16.05 COL 89 COLON-ALIGNED NO-LABEL
     fi_dealer AT ROW 16 COL 113 COLON-ALIGNED NO-LABEL WIDGET-ID 18
     fi_tax AT ROW 17.1 COL 39 COLON-ALIGNED NO-LABEL
     fi_tname1 AT ROW 18.14 COL 15.33 COLON-ALIGNED NO-LABEL
     fi_tname2 AT ROW 19.19 COL 15.33 COLON-ALIGNED NO-LABEL
     fi_tname3 AT ROW 20.24 COL 15.33 COLON-ALIGNED NO-LABEL
     fi_icno1 AT ROW 18.14 COL 91.17 COLON-ALIGNED NO-LABEL
     fi_icno2 AT ROW 19.19 COL 91.17 COLON-ALIGNED NO-LABEL
     fi_icno3 AT ROW 20.29 COL 91.17 COLON-ALIGNED NO-LABEL
     fi_bdate AT ROW 17.1 COL 15.33 COLON-ALIGNED NO-LABEL
     fi_cname1 AT ROW 18.14 COL 32.33 COLON-ALIGNED NO-LABEL
     fi_cname2 AT ROW 19.19 COL 32.33 COLON-ALIGNED NO-LABEL
     fi_cname3 AT ROW 20.24 COL 32.33 COLON-ALIGNED NO-LABEL
     fi_lname1 AT ROW 18.19 COL 60.5 COLON-ALIGNED NO-LABEL
     fi_lname2 AT ROW 19.24 COL 60.5 COLON-ALIGNED NO-LABEL
     fi_lname3 AT ROW 20.29 COL 60.5 COLON-ALIGNED NO-LABEL
     fi_kkapp AT ROW 3.29 COL 42.67 COLON-ALIGNED NO-LABEL WIDGET-ID 2
     fi_bennefit AT ROW 10.71 COL 72.17 COLON-ALIGNED NO-LABEL WIDGET-ID 10
     fi_send AT ROW 21.33 COL 15.33 COLON-ALIGNED NO-LABEL WIDGET-ID 6
     fi_sendname AT ROW 21.33 COL 67.5 COLON-ALIGNED NO-LABEL WIDGET-ID 8
     "Class :":35 VIEW-AS TEXT
          SIZE 6.5 BY 1 AT ROW 6.48 COL 60.5
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "กรรมการ3 :":30 VIEW-AS TEXT
          SIZE 14.83 BY 1 AT ROW 20.19 COL 1.83
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "Remark2  :":30 VIEW-AS TEXT
          SIZE 14.83 BY 1 AT ROW 23.33 COL 1.83
          BGCOLOR 18 FGCOLOR 1 FONT 6
     " Occup :":30 VIEW-AS TEXT
          SIZE 9.5 BY 1 AT ROW 16 COL 37
          BGCOLOR 18 FGCOLOR 1 FONT 6
     " IC NO:":30 VIEW-AS TEXT
          SIZE 8 BY 1 AT ROW 18.14 COL 85
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "SI YR2 :":25 VIEW-AS TEXT
          SIZE 8.5 BY 1 AT ROW 9.62 COL 58.67
          BGCOLOR 18 FGCOLOR 0 FONT 6
     " SI Year 1 :":35 VIEW-AS TEXT
          SIZE 15 BY 1 AT ROW 9.57 COL 2
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "FI YR2 :":25 VIEW-AS TEXT
          SIZE 8.33 BY 1 AT ROW 9.62 COL 85.17
          BGCOLOR 18 FGCOLOR 0 FONT 6
     " IC NO:":30 VIEW-AS TEXT
          SIZE 8 BY 1 AT ROW 19.19 COL 85
          BGCOLOR 18 FGCOLOR 1 FONT 6
     " IC NO:":30 VIEW-AS TEXT
          SIZE 8 BY 1 AT ROW 20.29 COL 85
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "Ton :":30 VIEW-AS TEXT
          SIZE 5.5 BY 1 AT ROW 8.57 COL 84.67
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "กรรมการ2 :":30 VIEW-AS TEXT
          SIZE 14.83 BY 1 AT ROW 19.14 COL 1.83
          BGCOLOR 18 FGCOLOR 1 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1.05
         SIZE 132.5 BY 24
         BGCOLOR 3 FGCOLOR 1 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "CC :":30 VIEW-AS TEXT
          SIZE 4.5 BY 1 AT ROW 8.57 COL 69
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "Policy (Old) :":35 VIEW-AS TEXT
          SIZE 12.83 BY 1 AT ROW 2.24 COL 35
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "NotiTime :":30 VIEW-AS TEXT
          SIZE 9.5 BY 1 AT ROW 1.19 COL 31.33
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "Status :":30 VIEW-AS TEXT
          SIZE 8 BY 1 AT ROW 16 COL 82.5
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "Cover :":30 VIEW-AS TEXT
          SIZE 7.67 BY 1 AT ROW 5.38 COL 96
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "RE-KK No :":35 VIEW-AS TEXT
          SIZE 14.83 BY 1 AT ROW 3.29 COL 2.17
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "Notified No :":35 VIEW-AS TEXT
          SIZE 14.83 BY 1 AT ROW 2.24 COL 2.17
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "Birth Date :":30 VIEW-AS TEXT
          SIZE 14.83 BY 1 AT ROW 17.05 COL 1.83
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "Insur Company :":35 VIEW-AS TEXT
          SIZE 15.83 BY 1 AT ROW 1.19 COL 80.67
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "Campaign No :":35 VIEW-AS TEXT
          SIZE 14 BY 1 AT ROW 3.29 COL 65.17
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "Addr1 :":30 VIEW-AS TEXT
          SIZE 6.83 BY 1 AT ROW 4.33 COL 53.5
          BGCOLOR 18 FGCOLOR 2 FONT 6
     "ชื่อ :":30 VIEW-AS TEXT
          SIZE 4.5 BY 1 AT ROW 18.14 COL 29.5
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "ชื่อ :":30 VIEW-AS TEXT
          SIZE 4.5 BY 1 AT ROW 19.19 COL 29.5
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "Addr5 :":30 VIEW-AS TEXT
          SIZE 7 BY 1 AT ROW 5.38 COL 73.83
          BGCOLOR 18 FGCOLOR 2 FONT 6
     "ชื่อ :":30 VIEW-AS TEXT
          SIZE 4.5 BY 1 AT ROW 20.29 COL 29.5
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "Garage :":35 VIEW-AS TEXT
          SIZE 8.67 BY 1 AT ROW 5.38 COL 111.67
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "Agent code :":30 VIEW-AS TEXT
          SIZE 13 BY 1 AT ROW 17.1 COL 101.5
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "Addr1:":30 VIEW-AS TEXT
          SIZE 6.5 BY 1 AT ROW 13.86 COL 54.33
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "สกุล :":30 VIEW-AS TEXT
          SIZE 5.5 BY 1 AT ROW 18.19 COL 56.83
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "Eng no :":35 VIEW-AS TEXT
          SIZE 8.33 BY 1 AT ROW 8.57 COL 41
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "สกุล :":30 VIEW-AS TEXT
          SIZE 5.5 BY 1 AT ROW 19.24 COL 56.67
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "Prem 2 :":30 VIEW-AS TEXT
          SIZE 8 BY 1 AT ROW 9.57 COL 109.67
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "Telephone :":30 VIEW-AS TEXT
          SIZE 12 BY 1 AT ROW 14.91 COL 101.5
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "Driv Name 1 :":30 VIEW-AS TEXT
          SIZE 14.83 BY 1 AT ROW 12.81 COL 2
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "สกุล :":30 VIEW-AS TEXT
          SIZE 5.5 BY 1 AT ROW 20.29 COL 56.67
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "Notified Date  :":30 VIEW-AS TEXT
          SIZE 14.83 BY 1 AT ROW 1.19 COL 2.17
          BGCOLOR 18 FGCOLOR 0 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1.05
         SIZE 132.5 BY 24
         BGCOLOR 3 FGCOLOR 1 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "BR Name :":35 VIEW-AS TEXT
          SIZE 10 BY 1 AT ROW 2.24 COL 82
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "Tax no :":30 VIEW-AS TEXT
          SIZE 8 BY 1 AT ROW 17.1 COL 32.83
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "Model :":30 VIEW-AS TEXT
          SIZE 8 BY 1 AT ROW 7.48 COL 32.5
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "Prem.1 :":30 VIEW-AS TEXT
          SIZE 8.83 BY 1 AT ROW 9.62 COL 34.83
          BGCOLOR 18 FGCOLOR 0 FONT 6
     " Fleet Disc :":35 VIEW-AS TEXT
          SIZE 14.67 BY 1 AT ROW 10.67 COL 2
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "Receipt Dat  :":30 VIEW-AS TEXT
          SIZE 14 BY 1 AT ROW 1.19 COL 52.17
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "Addr4 :":30 VIEW-AS TEXT
          SIZE 7.33 BY 1 AT ROW 14.86 COL 44.17
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "รย 43 :":30 VIEW-AS TEXT
          SIZE 7 BY 1 AT ROW 6.43 COL 76.5
          BGCOLOR 18 FGCOLOR 0 FONT 6
     " Driv Name 2 :":30 VIEW-AS TEXT
          SIZE 14 BY 1 AT ROW 12.76 COL 67
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "Beneficiary :":30 VIEW-AS TEXT
          SIZE 14.83 BY 1 AT ROW 11.76 COL 2
          BGCOLOR 18 FGCOLOR 4 FONT 6
     "NCB Disc :":35 VIEW-AS TEXT
          SIZE 11 BY 1 AT ROW 10.67 COL 30.67
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "Remark1  :":30 VIEW-AS TEXT
          SIZE 14.83 BY 1 AT ROW 22.29 COL 1.83
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "Type :":35 VIEW-AS TEXT
          SIZE 6 BY 1 AT ROW 2.24 COL 111.5
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "Status :":35 VIEW-AS TEXT
          SIZE 7.33 BY 1 AT ROW 7.48 COL 67.83
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "KK App :":35 VIEW-AS TEXT
          SIZE 9 BY 1 AT ROW 3.29 COL 35.17 WIDGET-ID 4
          BGCOLOR 19 FGCOLOR 6 FONT 6
     "MKT:":35 VIEW-AS TEXT
          SIZE 6.5 BY 1 AT ROW 8.52 COL 101.17
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "ชื่อผู้รับ:":30 VIEW-AS TEXT
          SIZE 7.5 BY 1 AT ROW 21.29 COL 61.67 WIDGET-ID 12
          BGCOLOR 18 FGCOLOR 2 FONT 6
     "Producer :":30 VIEW-AS TEXT
          SIZE 10.5 BY 1 AT ROW 17.1 COL 74.83
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "ผู้รับผลประโยชน์ :":35 VIEW-AS TEXT
          SIZE 14.83 BY 1 AT ROW 10.71 COL 58.83 WIDGET-ID 14
          BGCOLOR 18 FGCOLOR 2 FONT 6
     "Year  :":35 VIEW-AS TEXT
          SIZE 7.33 BY 1 AT ROW 7.52 COL 114
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "ที่จัดส่งเอกสาร :":30 VIEW-AS TEXT
          SIZE 14.83 BY 1 AT ROW 21.24 COL 1.67 WIDGET-ID 16
          BGCOLOR 18 FGCOLOR 2 FONT 6
     "Brand :":30 VIEW-AS TEXT
          SIZE 15 BY 1 AT ROW 7.48 COL 2
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "Sub Camp :":35 VIEW-AS TEXT
          SIZE 11.5 BY 1 AT ROW 3.29 COL 100.33
          BGCOLOR 18 FGCOLOR 0 FONT 6
     " Rec Addr3 :":30 VIEW-AS TEXT
          SIZE 14.83 BY 1 AT ROW 14.91 COL 2
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "Addr2 :":30 VIEW-AS TEXT
          SIZE 7.5 BY 1 AT ROW 4.33 COL 107
          BGCOLOR 18 FGCOLOR 2 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1.05
         SIZE 132.5 BY 24
         BGCOLOR 3 FGCOLOR 1 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "Addr4 :":30 VIEW-AS TEXT
          SIZE 7.17 BY 1 AT ROW 5.38 COL 42
          BGCOLOR 18 FGCOLOR 2 FONT 6
     "BR Code :":35 VIEW-AS TEXT
          SIZE 10 BY 1 AT ROW 2.24 COL 65
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "Dealer code :":30 VIEW-AS TEXT
          SIZE 13 BY 1 AT ROW 16 COL 101.5 WIDGET-ID 20
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "Addr5 :":30 VIEW-AS TEXT
          SIZE 7 BY 1 AT ROW 14.91 COL 80.67
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "Addr2 :":30 VIEW-AS TEXT
          SIZE 7.83 BY 1 AT ROW 13.81 COL 101.33
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "Rec Name  :":30 VIEW-AS TEXT
          SIZE 14.83 BY 1 AT ROW 13.86 COL 2
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "Com. date  :":35 VIEW-AS TEXT
          SIZE 15 BY 1 AT ROW 6.43 COL 2
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "Insur.Name :":35 VIEW-AS TEXT
          SIZE 14.83 BY 1 AT ROW 4.33 COL 2.17
          BGCOLOR 18 FGCOLOR 2 FONT 6
     "Chass No :":20 VIEW-AS TEXT
          SIZE 15 BY 1 AT ROW 8.52 COL 2
          BGCOLOR 18 FGCOLOR 0 FONT 6
     " IC NO:":30 VIEW-AS TEXT
          SIZE 14.67 BY 1 AT ROW 15.95 COL 2
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "Licence :":30 VIEW-AS TEXT
          SIZE 8.83 BY 1 AT ROW 7.52 COL 83.67
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "กรรมการ1 :":30 VIEW-AS TEXT
          SIZE 14.83 BY 1 AT ROW 18.1 COL 1.83
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "Ins Addr3 :":30 VIEW-AS TEXT
          SIZE 15 BY 1 AT ROW 5.38 COL 2
          BGCOLOR 18 FGCOLOR 2 FONT 6
     "Exp Date :":35 VIEW-AS TEXT
          SIZE 10.67 BY 1 AT ROW 6.43 COL 32.5
          BGCOLOR 18 FGCOLOR 0 FONT 6
     RECT-335 AT ROW 1 COL 1
     RECT-343 AT ROW 22.67 COL 111.17
     RECT-344 AT ROW 22.67 COL 121.17
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1.05
         SIZE 132.5 BY 24
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
         TITLE              = "update data [KK ธนาคารเกียรตินาคิน]"
         HEIGHT             = 24.1
         WIDTH              = 132
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
/* SETTINGS FOR FILL-IN fi_comdat IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_expdat IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_ins_off IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_notdat IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_nottim IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_receivdat IN FRAME fr_main
   NO-ENABLE                                                            */
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
ON END-ERROR OF C-Win /* update data [KK ธนาคารเกียรตินาคิน] */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* update data [KK ธนาคารเกียรตินาคิน] */
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
        WHEN TRUE THEN  /* Yes */ 
            DO: 
            Find  tlt Where  Recid(tlt)  =  nv_recidtlt.
            If  avail  tlt Then do:
                Assign
                    tlt.datesent      = INPUT fi_notdat  
                    tlt.gentim        = INPUT fi_nottim 
                    tlt.dat_ins_noti  = INPUT fi_receivdat 
                    tlt.nor_usr_ins   = Input fi_ins_comp 
                    tlt.nor_noti_tlt  = Input fi_notno 
                    tlt.nor_noti_ins  = Input fi_polsystem
                    tlt.nor_usr_tlt   = Input fi_cmrcode 
                    tlt.comp_usr_tlt  = Input fi_pro_off  
                    tlt.comp_noti_tlt = Input fi_policy 
                    tlt.dri_no1       = Input fi_campaign
                    tlt.dri_no2       = Input fi_subcamp 
                    tlt.safe2         = Input fi_typename
                    tlt.ins_name      = trim( Input fi_institle) /*+ " " +   
                                        trim( Input fi_preinsur) + " " +    
                                        trim( Input fi_preinsur2) */
                    tlt.ins_addr1     = Input  fi_insaddr1
                    tlt.ins_addr2     = Input  fi_insaddr2
                    tlt.ins_addr3     = Input  fi_insaddr3
                    tlt.ins_addr4     = Input  fi_insaddr4
                    tlt.ins_addr5     = Input  fi_insaddr5
                    tlt.safe3         = INPUT  fi_covcod  
                    tlt.stat          = Input  fi_garage 
                    tlt.nor_effdat    = INPUT  fi_comdat     
                    tlt.expodat       = INPUT  fi_expdat
                    tlt.subins        = Input  fi_subclass   
                    tlt.filler2       = Input  fi_province
                    tlt.brand         = Input  fi_brand 
                    tlt.model         = Input  fi_model 
                    tlt.filler1       = input  fi_status
                    tlt.lince1        = Input  fi_licence
                    tlt.eng_no        = Input  fi_eng_no    
                    tlt.cha_no        = Input  fi_cha_no    
                    tlt.lince2        = Input  fi_year             
                    tlt.cc_weight     = Input  fi_power           
                    tlt.colorcod      = string( INPUT fi_ton )   
                    tlt.comp_coamt    = Input  fi_sumsi   
                    tlt.comp_grprm    = INPUT  fi_prem1   
                    tlt.nor_coamt     = Input  fi_sumsi2  
                    tlt.nor_grprm     = INPUT  fi_prem2   
                    tlt.dri_name1     = INPUT  fi_drivno1  
                    tlt.dri_name2     = INPUT  fi_drivno2  
                    tlt.comp_usr_ins  = INPUT  fi_ins_off
                    tlt.safe1         = TRIM(INPUT  fi_benname) /*+ TRIM(INPUT  fi_benname2)*/
                    tlt.rec_name      = INPUT  fi_receipt 
                    tlt.rec_addr1     = INPUT  fi_addr_re1                
                    tlt.rec_addr2     = INPUT  fi_addr_re2  
                    tlt.rec_addr3     = INPUT  fi_addr_re3      
                    tlt.rec_addr4     = INPUT  fi_addr_re4      
                    tlt.rec_addr5     = INPUT  fi_addr_re5      
                    tlt.lotno         = string( INPUT fi_fleetper) 
                    tlt.seqno         = Input  fi_ncbper
                    tlt.comp_sub      = INPUT  fi_client  
                    tlt.recac         = INPUT  fi_agent
                    tlt.OLD_eng       = trim(Input fi_remark1) 
                    tlt.OLD_cha       = trim(Input fi_remark2)
                    tlt.trndat        = Input  fi_trndat 
                    tlt.comp_noti_ins  = "SE:" + TRIM(fi_send) + " " +      /* สถานที่จัดส่ง */         /* A61-0335 */
                                         "SN:" + TRIM(fi_sendname) + " " +  /* ชื่อผู้รับ */            /* A61-0335 */
                                         "BE:" + TRIM(fi_bennefit)          /* ชื่อผู้รับผลประโยชน์ */  /* A61-0335 */
                    tlt.expotim        = trim(fi_KKapp)                     /* KK App */                /* A61-0335 */
                    /*A60-0232 */
                    tlt.endno         = fi_userid
                    tlt.endcnt        = INT(INPUT fi_sumfi)
                    tlt.expousr       = "TEL:"  + TRIM(INPUT fi_phone) + " " +             /*เบอร์ติดต่อ                 */  
                                        "ICNO:" + TRIM(INPUT fi_icno)                   /*เลขที่บัตรประชาชน           */  
                    tlt.usrsent       = "Occup:"  + TRIM(INPUT fi_occup)   + " " +         /*อาชีพ                       */ 
                                        "Status:" + TRIM(INPUT fi_cstatus) + " " +      /*สถานภาพ                     */ 
                                        "Tax:"    + TRIM(INPUT fi_tax)                   /*เลขประจำตัวผู้เสียภาษีอากร  */
                    tlt.gendat        = INPUT fi_bdate                          /*วันเดือนปีเกิด              */
                    tlt.lince3        = "T1:"  + trim(INPUT fi_tname1) + " " +  /*คำนำหน้าชื่อ 1              */
                                        "N1:"  + trim(INPUT fi_cname1) + " " +  /*ชื่อกรรมการ 1               */
                                        "L1:"  + trim(INPUT fi_lname1) + " " +  /*นามสกุลกรรมการ 1            */
                                        "IC1:" + trim(INPUT fi_icno1)  + " " +  /*เลขที่บัตรประชาชนกรรมการ 1  */
                                        "T2:"  + trim(INPUT fi_tname2) + " " +  /*คำนำหน้าชื่อ 1              */
                                        "N2:"  + trim(INPUT fi_cname2) + " " +  /*ชื่อกรรมการ 1               */
                                        "L2:"  + trim(INPUT fi_lname2) + " " +  /*นามสกุลกรรมการ 1            */
                                        "IC2:" + trim(INPUT fi_icno2)  + " " +  /*เลขที่บัตรประชาชนกรรมการ 1  */
                                        "T3:"  + trim(INPUT fi_tname3) + " " +  /*คำนำหน้าชื่อ 1              */
                                        "N3:"  + trim(INPUT fi_cname3) + " " +  /*ชื่อกรรมการ 1               */
                                        "L3:"  + trim(INPUT fi_lname3) + " " +  /*นามสกุลกรรมการ 1            */
                                        "IC3:" + trim(INPUT fi_icno3)           /*เลขที่บัตรประชาชนกรรมการ 1  */
                    tlt.usrid         = INPUT fi_dealer  .                       /* A63-00472 */
                  /* end : A60-0232 */  
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

/*Disp  fi_pack with  frame  fr_main.*/

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_addr_re1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_addr_re1 C-Win
ON LEAVE OF fi_addr_re1 IN FRAME fr_main
DO:
  fi_addr_re1  = INPUT fi_addr_re1.
  DISP fi_addr_re1 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_addr_re2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_addr_re2 C-Win
ON LEAVE OF fi_addr_re2 IN FRAME fr_main
DO:
  fi_addr_re2  = INPUT fi_addr_re2.
  DISP fi_addr_re2 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_addr_re3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_addr_re3 C-Win
ON LEAVE OF fi_addr_re3 IN FRAME fr_main
DO:
  fi_addr_re3  = INPUT fi_addr_re3.
  DISP fi_addr_re3 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_addr_re4
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_addr_re4 C-Win
ON LEAVE OF fi_addr_re4 IN FRAME fr_main
DO:
  fi_addr_re4  = INPUT fi_addr_re4.
  DISP fi_addr_re4 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_addr_re5
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_addr_re5 C-Win
ON LEAVE OF fi_addr_re5 IN FRAME fr_main
DO:
  fi_addr_re5  = INPUT fi_addr_re5.
  DISP fi_addr_re5 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_agent
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_agent C-Win
ON LEAVE OF fi_agent IN FRAME fr_main
DO:
  fi_agent  = INPUT fi_agent.
  DISP fi_agent WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_bdate
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_bdate C-Win
ON LEAVE OF fi_bdate IN FRAME fr_main
DO:
  fi_bdate  = INPUT fi_bdate.
  DISP fi_bdate WITH FRAM fr_main.
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


&Scoped-define SELF-NAME fi_bennefit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_bennefit C-Win
ON LEAVE OF fi_bennefit IN FRAME fr_main
DO:
  fi_bennefit = INPUT fi_bennefit.
  DISP fi_bennefit WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_brand
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_brand C-Win
ON LEAVE OF fi_brand IN FRAME fr_main
DO:
  fi_brand = INPUT fi_brand.
  DISP fi_brand WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_campaign
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_campaign C-Win
ON LEAVE OF fi_campaign IN FRAME fr_main
DO:
  fi_policy  =  Input  fi_policy.
  Disp  fi_policy with frame  fr_main.
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
  fi_client  = INPUT fi_client.
  DISP fi_client WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_cmrcode
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_cmrcode C-Win
ON LEAVE OF fi_cmrcode IN FRAME fr_main
DO:
  fi_cmrcode = INPUT fi_cmrcode.
  DISP fi_cmrcode WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_cname1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_cname1 C-Win
ON LEAVE OF fi_cname1 IN FRAME fr_main
DO:
  fi_cname1  = INPUT fi_cname1.
  DISP fi_cname1 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_cname2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_cname2 C-Win
ON LEAVE OF fi_cname2 IN FRAME fr_main
DO:
  fi_cname2  = INPUT fi_cname2.
  DISP fi_cname2 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_cname3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_cname3 C-Win
ON LEAVE OF fi_cname3 IN FRAME fr_main
DO:
  fi_cname3  = INPUT fi_cname3.
  DISP fi_cname3 WITH FRAM fr_main.
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


&Scoped-define SELF-NAME fi_covcod
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_covcod C-Win
ON LEAVE OF fi_covcod IN FRAME fr_main
DO:
  fi_covcod = INPUT fi_covcod.
  DISP fi_covcod WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_cstatus
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_cstatus C-Win
ON LEAVE OF fi_cstatus IN FRAME fr_main
DO:
  fi_cstatus  = INPUT fi_cstatus.
  DISP fi_cstatus WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_dealer
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_dealer C-Win
ON LEAVE OF fi_dealer IN FRAME fr_main
DO:
    fi_dealer  = INPUT fi_dealer.
    DISP fi_dealer WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_drivno1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_drivno1 C-Win
ON LEAVE OF fi_drivno1 IN FRAME fr_main
DO:
  fi_drivno1  = INPUT fi_drivno1.
  DISP fi_drivno1 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_drivno2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_drivno2 C-Win
ON LEAVE OF fi_drivno2 IN FRAME fr_main
DO:
  fi_drivno2  = INPUT fi_drivno2.
  DISP fi_drivno2 WITH FRAM fr_main.
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


&Scoped-define SELF-NAME fi_icno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_icno C-Win
ON LEAVE OF fi_icno IN FRAME fr_main
DO:
  fi_icno  = INPUT fi_icno.
  DISP fi_icno WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_icno1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_icno1 C-Win
ON LEAVE OF fi_icno1 IN FRAME fr_main
DO:
  fi_icno1  = INPUT fi_icno1.
  DISP fi_icno1 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_icno2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_icno2 C-Win
ON LEAVE OF fi_icno2 IN FRAME fr_main
DO:
  fi_icno2  = INPUT fi_icno2.
  DISP fi_icno2 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_icno3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_icno3 C-Win
ON LEAVE OF fi_icno3 IN FRAME fr_main
DO:
  fi_icno3  = INPUT fi_icno3.
  DISP fi_icno3 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_insaddr1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_insaddr1 C-Win
ON LEAVE OF fi_insaddr1 IN FRAME fr_main
DO:
  fi_insaddr1  = INPUT fi_insaddr1.
  DISP fi_insaddr1 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_insaddr2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_insaddr2 C-Win
ON LEAVE OF fi_insaddr2 IN FRAME fr_main
DO:
  fi_insaddr2  = INPUT fi_insaddr2.
  DISP fi_insaddr2 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_insaddr3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_insaddr3 C-Win
ON LEAVE OF fi_insaddr3 IN FRAME fr_main
DO:
  fi_insaddr3 = INPUT fi_insaddr3.
  DISP fi_insaddr3 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_insaddr4
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_insaddr4 C-Win
ON LEAVE OF fi_insaddr4 IN FRAME fr_main
DO:
  fi_insaddr4  = INPUT fi_insaddr4.
  DISP fi_insaddr4 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_insaddr5
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_insaddr5 C-Win
ON LEAVE OF fi_insaddr5 IN FRAME fr_main
DO:
  fi_insaddr5  = INPUT fi_insaddr5.
  DISP fi_insaddr5 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_institle
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_institle C-Win
ON LEAVE OF fi_institle IN FRAME fr_main
DO:
  /*fi_preinsur = INPUT fi_preinsur.
  DISP fi_preinsur WITH FRAM fr_main.*/
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
  fi_ins_off = INPUT fi_ins_off.
  DISP fi_ins_off WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_kkapp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_kkapp C-Win
ON LEAVE OF fi_kkapp IN FRAME fr_main
DO:
  fi_kkapp  =  Input  fi_kkapp .
  Disp  fi_kkapp with frame  fr_main.
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


&Scoped-define SELF-NAME fi_lname1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_lname1 C-Win
ON LEAVE OF fi_lname1 IN FRAME fr_main
DO:
  fi_lname1  = INPUT fi_lname1.
  DISP fi_lname1 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_lname2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_lname2 C-Win
ON LEAVE OF fi_lname2 IN FRAME fr_main
DO:
  fi_lname2  = INPUT fi_lname2.
  DISP fi_lname2 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_lname3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_lname3 C-Win
ON LEAVE OF fi_lname3 IN FRAME fr_main
DO:
  fi_lname3  = INPUT fi_lname3.
  DISP fi_lname3 WITH FRAM fr_main.
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


&Scoped-define SELF-NAME fi_ncbper
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_ncbper C-Win
ON LEAVE OF fi_ncbper IN FRAME fr_main
DO:
  fi_ncbper =  Input  fi_ncbper.
  Disp  fi_ncbper with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_notdat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_notdat C-Win
ON LEAVE OF fi_notdat IN FRAME fr_main
DO:
  fi_notdat  = INPUT fi_notdat.
  DISP fi_notdat WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_notno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_notno C-Win
ON LEAVE OF fi_notno IN FRAME fr_main
DO:
  fi_notno = INPUT fi_notno.
  DISP fi_notno WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_nottim
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_nottim C-Win
ON LEAVE OF fi_nottim IN FRAME fr_main
DO:
  fi_nottim  = INPUT fi_nottim.
  DISP fi_nottim WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_occup
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_occup C-Win
ON LEAVE OF fi_occup IN FRAME fr_main
DO:
  fi_occup  = INPUT fi_occup.
  DISP fi_occup WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_phone
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_phone C-Win
ON LEAVE OF fi_phone IN FRAME fr_main
DO:
  fi_phone  = INPUT fi_phone.
  DISP fi_phone WITH FRAM fr_main.
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


&Scoped-define SELF-NAME fi_polsystem
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_polsystem C-Win
ON LEAVE OF fi_polsystem IN FRAME fr_main
DO:
  fi_polsystem  =  Input  fi_polsystem.
  Disp  fi_polsystem with frame  fr_main.
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


&Scoped-define SELF-NAME fi_prem1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_prem1 C-Win
ON LEAVE OF fi_prem1 IN FRAME fr_main
DO:
  fi_prem1 = INPUT fi_prem1.
  DISP fi_prem1 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_prem2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_prem2 C-Win
ON LEAVE OF fi_prem2 IN FRAME fr_main
DO:
    fi_prem2 = INPUT fi_prem2.
    DISP fi_prem2 WITH FRAM fr_main.
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


&Scoped-define SELF-NAME fi_receipt
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_receipt C-Win
ON LEAVE OF fi_receipt IN FRAME fr_main
DO:
  fi_receipt  = INPUT fi_receipt.
  DISP fi_receipt WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_receivdat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_receivdat C-Win
ON LEAVE OF fi_receivdat IN FRAME fr_main
DO:
    fi_receivdat  = INPUT fi_receivdat.
    DISP fi_receivdat WITH FRAM fr_main.
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


&Scoped-define SELF-NAME fi_send
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_send C-Win
ON LEAVE OF fi_send IN FRAME fr_main
DO:
  fi_send  = INPUT fi_send.
  DISP fi_send WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_sendname
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_sendname C-Win
ON LEAVE OF fi_sendname IN FRAME fr_main
DO:
  fi_sendname  = INPUT fi_sendname.
  DISP fi_sendname WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_status
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_status C-Win
ON LEAVE OF fi_status IN FRAME fr_main
DO:
  fi_status = INPUT fi_status.
  DISP fi_status WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_subcamp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_subcamp C-Win
ON LEAVE OF fi_subcamp IN FRAME fr_main
DO:
  fi_policy  =  Input  fi_policy.
  Disp  fi_policy with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_subclass
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_subclass C-Win
ON LEAVE OF fi_subclass IN FRAME fr_main
DO:
  fi_subclass = INPUT fi_subclass.
  DISP fi_subclass WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_sumFI
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_sumFI C-Win
ON LEAVE OF fi_sumFI IN FRAME fr_main
DO:
    fi_sumFI = INPUT fi_sumFI.
    DISP fi_sumFI WITH FRAM fr_main.
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


&Scoped-define SELF-NAME fi_sumsi2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_sumsi2 C-Win
ON LEAVE OF fi_sumsi2 IN FRAME fr_main
DO:
    fi_sumsi2 = INPUT fi_sumsi2.
    DISP fi_sumsi2 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_tax
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_tax C-Win
ON LEAVE OF fi_tax IN FRAME fr_main
DO:
  fi_tax  = INPUT fi_tax.
  DISP fi_tax WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_tname1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_tname1 C-Win
ON LEAVE OF fi_tname1 IN FRAME fr_main
DO:
  fi_tname1  = INPUT fi_tname1.
  DISP fi_tname1 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_tname2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_tname2 C-Win
ON LEAVE OF fi_tname2 IN FRAME fr_main
DO:
  fi_tname2  = INPUT fi_tname2.
  DISP fi_tname2 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_tname3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_tname3 C-Win
ON LEAVE OF fi_tname3 IN FRAME fr_main
DO:
  fi_tname3  = INPUT fi_tname3.
  DISP fi_tname3 WITH FRAM fr_main.
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


&Scoped-define SELF-NAME fi_typename
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_typename C-Win
ON LEAVE OF fi_typename IN FRAME fr_main
DO:
  fi_policy  =  Input  fi_policy.
  Disp  fi_policy with frame  fr_main.
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

    gv_prgid = "wgwqukk2".
    gv_prog  = "Query &Update Data  (KK Bank  co.,ltd.) ".
  RUN  WUT\WUTHEAD ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).

/*********************************************************************/ 
 /*  RUN Wut\WutwiCen ({&WINDOW-NAME}:HANDLE). */ 
  /*CURRENT-WINDOW:WINDOW-STATE = WINDOW-MAXIMIZED.*/
  SESSION:DATA-ENTRY-RETURN = YES.

  /*Rect-336:Move-to-top().*/
  
  
  /* Hide    fi_difprm  in frame  {&FRAME-NAME}.*/
  Find  brstat.tlt  Where   Recid(tlt)  =  nv_recidtlt NO-LOCK NO-ERROR NO-WAIT .
  If  avail  tlt  Then do:
      Assign
          fi_notdat    = tlt.datesent
          fi_nottim    = tlt.gentim
          fi_receivdat = tlt.dat_ins_noti
          fi_ins_comp  = tlt.nor_usr_ins   
          fi_notno     = tlt.nor_noti_tlt
          fi_polsystem = tlt.nor_noti_ins
          fi_cmrcode   = tlt.nor_usr_tlt
          fi_pro_off   = tlt.comp_usr_tl
          fi_policy    = tlt.comp_noti_tlt
          fi_campaign  = tlt.dri_no1
          fi_subcamp   = tlt.dri_no2
          fi_typename  = tlt.safe2
          /* comment by a60-0232
          fi_institle  = substr(tlt.ins_name,1,INDEX(tlt.ins_name," ")) 
          fi_preinsur  = substr(tlt.ins_name,INDEX(tlt.ins_name," ") + 1,r-INDEX(tlt.ins_name," ") - INDEX(tlt.ins_name," ")) 
          fi_preinsur2 = substr(tlt.ins_name,r-INDEX(tlt.ins_name," ") + 1 ) 
          end A60-0232 */
          fi_institle  = tlt.ins_name  /*A60-0232*/
          fi_insaddr1  = tlt.ins_addr1 
          fi_insaddr2  = tlt.ins_addr2 
          fi_insaddr3  = tlt.ins_addr3 
          fi_insaddr4  = tlt.ins_addr4 
          fi_insaddr5  = tlt.ins_addr5
          fi_covcod    = tlt.safe3
          fi_garage    = tlt.stat
          fi_comdat    = tlt.nor_effdat 
          fi_expdat    = tlt.expodat
          fi_subclass  = tlt.subins
          fi_province  = tlt.filler2
          fi_brand     = tlt.brand
          fi_model     = tlt.model
          fi_status    = tlt.filler1
          fi_licence   = tlt.lince1
          fi_cha_no    = tlt.cha_no 
          fi_eng_no    = tlt.eng_no
          fi_year      = tlt.lince2
          fi_power     = tlt.cc_weight
          fi_ton       = deci(tlt.colorcod)
          fi_sumsi     = tlt.comp_coamt   
          fi_prem1     = tlt.comp_grprm   
          fi_sumsi2    = tlt.nor_coamt    
          fi_prem2     = tlt.nor_grprm 
          fi_drivno1   = tlt.dri_name1
          fi_drivno2   = tlt.dri_name2
          fi_ins_off   = tlt.comp_usr_in
          /*fi_benname   = substr(tlt.safe1,1,200)    */ /*A60-0232*/
          /*fi_benname2  = substr(tlt.safe1,101)      */ /*A60-0232*/
          fi_benname   = tlt.safe1  /*A60-0232*/
          fi_receipt   = tlt.rec_name
          fi_addr_re1  = tlt.rec_addr1 
          fi_addr_re2  = tlt.rec_addr2 
          fi_addr_re3  = tlt.rec_addr3 
          fi_addr_re4  = tlt.rec_addr4 
          fi_addr_re5  = tlt.rec_addr5 
          fi_fleetper  = Integer(tlt.lotno)
          fi_ncbper    = tlt.seqno
          fi_client    = tlt.comp_sub
          fi_agent     = tlt.recac 
          fi_remark1   = tlt.OLD_eng    
          fi_remark2   = tlt.OLD_cha  
          fi_trndat    = tlt.trndat
          fi_kkapp     = tlt.expotim    /* kk app */                                                /*A61-0335*/                
          n_text       = trim(tlt.comp_noti_ins)                                                    /*A61-0335*/
          fi_bennefit  = SUBSTR(n_text,R-INDEX(n_text,"BE:") + 3 )      /* ผู้รับผลประโยชน์ */      /*A61-0335*/
          n_text       = SUBSTR(n_text,1,LENGTH(n_text) - (LENGTH(fi_bennefit) + 3 ))                /*A61-0335*/
          fi_sendname  = SUBSTR(n_text,R-INDEX(n_text,"SN:") + 3 )  /* ชื่อผู้รับเอกสาร */      /*A61-0335*/
          n_text       = SUBSTR(n_text,1,LENGTH(n_text) - (LENGTH(fi_sendname) + 3 ))                /*A61-0335*/
          fi_send      = SUBSTR(n_text,R-INDEX(n_text,"SE:") + 3 )  /* สถานที่จัดส่งเอกสาร */   /*A61-0335*/
          /* A60-0232*/
          fi_sumFi     = tlt.endcnt
          fi_userid    = tlt.endno
          fi_phone     = IF tlt.expousr <> "" THEN SUBSTR(tlt.expousr,5,INDEX(tlt.expousr,"ICNO:") - 5) ELSE ""
          fi_icno      = IF tlt.expousr <> "" THEN SUBSTR(tlt.expousr,R-INDEX(tlt.expousr,"ICNO:") + 5) ELSE ""
          fi_bdate     = tlt.gendat
          n_text       = tlt.usrsent
          fi_tax       = SUBSTR(n_text,R-INDEX(n_text,"Tax:") + 4) 
          n_text       = SUBSTR(n_text,1,LENGTH(n_text) - (LENGTH(fi_tax) + 4))
          fi_cstatus   = SUBSTR(n_text,R-INDEX(tlt.usrsent,"Status:") + 7) 
          fi_occup     = SUBSTR(n_text,7,INDEX(tlt.usrsent,"Status:") - 7)
          n_text       = tlt.lince3
          fi_icno3     = SUBSTR(n_text,R-INDEX(n_text,"IC3:") + 4)         
          n_text       = SUBSTR(n_text,1,LENGTH(n_text) - (LENGTH(fi_icno3) + 4))
          fi_lname3    = SUBSTR(n_text,R-INDEX(n_text,"L3:") + 3)          
          n_text       = SUBSTR(n_text,1,LENGTH(n_text) - (LENGTH(fi_lname3) + 3))
          fi_cname3    = SUBSTR(n_text,R-INDEX(n_text,"N3:") + 3)          
          n_text       = SUBSTR(n_text,1,LENGTH(n_text) - (LENGTH(fi_cname3) + 3))
          fi_tname3    = SUBSTR(n_text,R-INDEX(n_text,"T3:") + 3)          
          n_text       = SUBSTR(n_text,1,LENGTH(n_text) - (LENGTH(fi_tname3) + 3))

          fi_icno2     = SUBSTR(n_text,R-INDEX(n_text,"IC2:") + 4)         
          n_text       = SUBSTR(n_text,1,LENGTH(n_text) - (LENGTH(fi_icno2) + 4))
          fi_lname2    = SUBSTR(n_text,R-INDEX(n_text,"L2:") + 3)          
          n_text       = SUBSTR(n_text,1,LENGTH(n_text) - (LENGTH(fi_lname2) + 3))
          fi_cname2    = SUBSTR(n_text,R-INDEX(n_text,"N2:") + 3)          
          n_text       = SUBSTR(n_text,1,LENGTH(n_text) - (LENGTH(fi_cname2) + 3))
          fi_tname2    = SUBSTR(n_text,R-INDEX(n_text,"T2:") + 3)         
          n_text       = SUBSTR(n_text,1,LENGTH(n_text) - (LENGTH(fi_tname2) + 3))

          fi_icno1     = SUBSTR(n_text,R-INDEX(n_text,"IC1:") + 4)         
          n_text       = SUBSTR(n_text,1,LENGTH(n_text) - (LENGTH(fi_icno1) + 4))
          fi_lname1    = SUBSTR(n_text,R-INDEX(n_text,"L1:") + 3)          
          n_text       = SUBSTR(n_text,1,LENGTH(n_text) - (LENGTH(fi_lname1) + 3))
          fi_cname1    = SUBSTR(n_text,R-INDEX(n_text,"N1:") + 3)          
          n_text       = SUBSTR(n_text,1,LENGTH(n_text) - (LENGTH(fi_cname1) + 3))
          fi_tname1    = SUBSTR(n_text,R-INDEX(n_text,"T1:") + 3) 
          fi_dealer    = trim(tlt.usrid)  .    /*A63-00472 */                       
         /* end : a60-0232*/

     Disp fi_notdat     fi_nottim    fi_receivdat 
          fi_ins_comp   fi_notno     fi_polsystem 
          fi_cmrcode    fi_pro_off   fi_policy    
          fi_campaign   fi_subcamp   fi_typename  
          fi_institle   /*fi_preinsur  fi_preinsur2 */
          fi_insaddr1   fi_insaddr2  fi_insaddr3 
          fi_insaddr4   fi_insaddr5  fi_covcod   
          fi_garage     fi_comdat    fi_expdat   
          fi_subclass   fi_province  fi_brand    
          fi_model      fi_status    fi_licence   
          fi_cha_no     fi_eng_no    fi_year      
          fi_power      fi_ton       fi_sumsi     
          fi_prem1      fi_sumsi2    fi_prem2     
          fi_drivno1    fi_drivno2   fi_ins_off   
          fi_benname    /*fi_benname2*/  fi_receipt   fi_addr_re1  
          fi_addr_re2   fi_addr_re3  fi_addr_re4  
          fi_addr_re5   fi_fleetper  fi_ncbper    
          fi_client     fi_agent     fi_remark1   
          fi_remark2    fi_trndat    fi_userid
          /*A60-0232 */
          fi_phone      fi_icno      fi_occup   fi_tname1   fi_lname1 
          fi_cstatus    fi_tax       fi_cname1  fi_tname2   fi_lname2 
          fi_icno1      fi_cname2    fi_icno2   fi_tname3   fi_lname3 
          fi_cname3     fi_icno3     fi_bdate   fi_sumfi    fi_dealer      /*A63-00472 */      
         /* end A60-0232*/
          fi_bennefit   fi_send     fi_sendname fi_kkapp /*a61-0335*/
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
  DISPLAY fi_notdat fi_nottim fi_receivdat fi_ins_comp fi_notno fi_polsystem 
          fi_cmrcode fi_pro_off fi_policy fi_campaign fi_subcamp fi_typename 
          fi_institle fi_insaddr1 fi_insaddr2 fi_insaddr3 fi_insaddr4 
          fi_insaddr5 fi_covcod fi_garage fi_comdat fi_expdat fi_subclass 
          fi_province fi_brand fi_model fi_status fi_licence fi_cha_no fi_eng_no 
          fi_year fi_power fi_ton fi_sumsi fi_prem1 fi_sumsi2 fi_prem2 
          fi_drivno1 fi_drivno2 fi_ins_off fi_receipt fi_addr_re1 fi_addr_re2 
          fi_addr_re3 fi_addr_re4 fi_addr_re5 fi_fleetper fi_ncbper fi_client 
          fi_agent fi_remark1 fi_remark2 fi_trndat fi_userid fi_benname fi_sumFI 
          fi_phone fi_icno fi_occup fi_cstatus fi_dealer fi_tax fi_tname1 
          fi_tname2 fi_tname3 fi_icno1 fi_icno2 fi_icno3 fi_bdate fi_cname1 
          fi_cname2 fi_cname3 fi_lname1 fi_lname2 fi_lname3 fi_kkapp fi_bennefit 
          fi_send fi_sendname 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE fi_ins_comp fi_notno fi_polsystem fi_cmrcode fi_pro_off fi_policy 
         fi_campaign fi_subcamp fi_typename fi_institle fi_insaddr1 fi_insaddr2 
         fi_insaddr3 fi_insaddr4 fi_insaddr5 fi_covcod fi_garage fi_subclass 
         fi_province fi_brand fi_model fi_status fi_licence fi_cha_no fi_eng_no 
         fi_year fi_power fi_ton fi_sumsi fi_prem1 fi_sumsi2 fi_prem2 
         fi_drivno1 fi_drivno2 fi_receipt fi_addr_re1 fi_addr_re2 fi_addr_re3 
         fi_addr_re4 fi_addr_re5 fi_fleetper fi_ncbper fi_client fi_agent 
         fi_remark1 fi_remark2 bu_save bu_exit fi_benname fi_sumFI fi_phone 
         fi_icno fi_occup fi_cstatus fi_dealer fi_tax fi_tname1 fi_tname2 
         fi_tname3 fi_icno1 fi_icno2 fi_icno3 fi_bdate fi_cname1 fi_cname2 
         fi_cname3 fi_lname1 fi_lname2 fi_lname3 fi_kkapp fi_bennefit fi_send 
         fi_sendname RECT-335 RECT-343 RECT-344 
      WITH FRAME fr_main IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

