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
program id       :  wuwqukk3.w 
program name     :  Update data KK to create  new policy  Add in table  tlt  
                    Quey & Update data before Gen.
Create  by       :  Kridtiya i. A55-0055   date. 14/02/2012
Database Connect :  gw_stat ld brstat , gw_safe ld sic_bran ,sic_test ld sicuw sicsyac :not connect stat
Modify by       : Ranu I. A61-0335  Date:11/07/2018 เพิ่มข้อมูล kk app 
+++++++++++++++++++++++++++++++++++++++++++++++*/
Def  Input  parameter  nv_recidtlt  as  recid  .
Def  var nv_index  as int  init 0.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS fi_policy fi_notno fi_cmrcode fi_pro_off ~
fi_campaign fi_subcamp fi_typfree fi_typename fi_institle fi_preinsur ~
fi_preinsur2 fi_insaddr1 fi_insaddr2 fi_insaddr3 fi_insaddr4 fi_insaddr5 ~
fi_covcod fi_garage fi_subclass fi_province fi_brand fi_model fi_status ~
fi_licence fi_cha_no fi_eng_no fi_year fi_power fi_ton fi_sumsi fi_prem1 ~
fi_sumsi2 fi_prem2 fi_stkno fi_comdat72 fi_expdat72 fi_premcomp fi_ins_off ~
fi_remark2 fi_drivno1 fi_brith1 fi_drivno2 fi_brith2 fi_receipt fi_addr_re1 ~
fi_remark1 fi_client fi_agent bu_save bu_exit fi_kkapp RECT-335 RECT-343 ~
RECT-344 RECT-368 
&Scoped-Define DISPLAYED-OBJECTS fi_notdat fi_nottim fi_receivdat ~
fi_ins_comp fi_policy fi_notno fi_cmrcode fi_pro_off fi_campaign fi_subcamp ~
fi_typfree fi_typename fi_institle fi_preinsur fi_preinsur2 fi_insaddr1 ~
fi_insaddr2 fi_insaddr3 fi_insaddr4 fi_insaddr5 fi_covcod fi_garage ~
fi_comdat fi_expdat fi_subclass fi_province fi_brand fi_model fi_status ~
fi_licence fi_cha_no fi_eng_no fi_year fi_power fi_ton fi_sumsi fi_prem1 ~
fi_sumsi2 fi_prem2 fi_stkno fi_comdat72 fi_expdat72 fi_premcomp fi_ins_off ~
fi_remark2 fi_drivno1 fi_brith1 fi_drivno2 fi_brith2 fi_receipt fi_addr_re1 ~
fi_remark1 fi_client fi_agent fi_trndat fi_release fi_userid fi_kkapp 

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
     SIZE 62 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_agent AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_brand AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 12 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_brith1 AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_brith2 AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_campaign AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 30 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_cha_no AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 26 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_client AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_cmrcode AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 8.5 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_comdat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 13 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_comdat72 AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_covcod AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_drivno1 AS CHARACTER FORMAT "X(60)":U 
     VIEW-AS FILL-IN 
     SIZE 38 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_drivno2 AS CHARACTER FORMAT "X(60)":U 
     VIEW-AS FILL-IN 
     SIZE 38 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_eng_no AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 20 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_expdat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 13 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_expdat72 AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_garage AS CHARACTER FORMAT "X(20)":U INITIAL ? 
     VIEW-AS FILL-IN 
     SIZE 9.5 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_insaddr1 AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 54 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_insaddr2 AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 39 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_insaddr3 AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 35 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_insaddr4 AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 35 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_insaddr5 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 12 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_institle AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 12.5 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_ins_comp AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 31 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_ins_off AS CHARACTER FORMAT "X(60)":U 
     VIEW-AS FILL-IN 
     SIZE 30 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_kkapp AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 26.5 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_licence AS CHARACTER FORMAT "X(35)":U 
     VIEW-AS FILL-IN 
     SIZE 26 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_model AS CHARACTER FORMAT "X(45)":U 
     VIEW-AS FILL-IN 
     SIZE 32 BY 1
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
     SIZE 8 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_policy AS CHARACTER FORMAT "X(26)":U 
     VIEW-AS FILL-IN 
     SIZE 19 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_power AS DECIMAL FORMAT "->>,>>9.99":U INITIAL ? 
     VIEW-AS FILL-IN 
     SIZE 12 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_preinsur AS CHARACTER FORMAT "X(35)":U 
     VIEW-AS FILL-IN 
     SIZE 23 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_preinsur2 AS CHARACTER FORMAT "X(45)":U 
     VIEW-AS FILL-IN 
     SIZE 30 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_prem1 AS DECIMAL FORMAT "->>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 16 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_prem2 AS DECIMAL FORMAT "->>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 16 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_premcomp AS DECIMAL FORMAT "->>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 16 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_province AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 21 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_pro_off AS CHARACTER FORMAT "X(35)":U 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_receipt AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 62 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_receivdat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 13 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_release AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 6 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_remark1 AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_remark2 AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 65.83 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_status AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 11 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_stkno AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 20 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_subcamp AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 70 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_subclass AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 8 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_sumsi AS INTEGER FORMAT ">>>,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 17 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_sumsi2 AS DECIMAL FORMAT "->>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 17 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_ton AS CHARACTER FORMAT "X(35)":U INITIAL ? 
     VIEW-AS FILL-IN 
     SIZE 26 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_trndat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_typename AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_typfree AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 24 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_userid AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 9 BY 1
     BGCOLOR 4 FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE fi_year AS CHARACTER FORMAT "X(5)":U INITIAL "0" 
     VIEW-AS FILL-IN 
     SIZE 8 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE RECTANGLE RECT-335
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 127.33 BY 21.67
     BGCOLOR 19 FGCOLOR 0 .

DEFINE RECTANGLE RECT-343
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 10 BY 1.91
     BGCOLOR 3 FGCOLOR 0 .

DEFINE RECTANGLE RECT-344
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 10 BY 1.91
     BGCOLOR 4 .

DEFINE RECTANGLE RECT-368
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 26 BY 2.62
     BGCOLOR 18 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     fi_notdat AT ROW 1.19 COL 18.5 COLON-ALIGNED NO-LABEL
     fi_nottim AT ROW 1.19 COL 42 COLON-ALIGNED NO-LABEL
     fi_receivdat AT ROW 1.19 COL 64.5 COLON-ALIGNED NO-LABEL
     fi_ins_comp AT ROW 1.19 COL 93.5 COLON-ALIGNED NO-LABEL
     fi_policy AT ROW 2.24 COL 18.5 COLON-ALIGNED NO-LABEL
     fi_notno AT ROW 2.24 COL 50.5 COLON-ALIGNED NO-LABEL
     fi_cmrcode AT ROW 3.33 COL 18.5 COLON-ALIGNED NO-LABEL
     fi_pro_off AT ROW 3.33 COL 37.83 COLON-ALIGNED NO-LABEL
     fi_campaign AT ROW 3.33 COL 73.5 COLON-ALIGNED NO-LABEL
     fi_subcamp AT ROW 4.43 COL 18.5 COLON-ALIGNED NO-LABEL
     fi_typfree AT ROW 4.43 COL 100.33 COLON-ALIGNED NO-LABEL
     fi_typename AT ROW 5.52 COL 18.5 COLON-ALIGNED NO-LABEL
     fi_institle AT ROW 5.52 COL 40.33 COLON-ALIGNED NO-LABEL
     fi_preinsur AT ROW 5.52 COL 62 COLON-ALIGNED NO-LABEL
     fi_preinsur2 AT ROW 5.52 COL 94.33 COLON-ALIGNED NO-LABEL
     fi_insaddr1 AT ROW 6.62 COL 18.5 COLON-ALIGNED NO-LABEL
     fi_insaddr2 AT ROW 6.62 COL 85.33 COLON-ALIGNED NO-LABEL
     fi_insaddr3 AT ROW 7.67 COL 18.5 COLON-ALIGNED NO-LABEL
     fi_insaddr4 AT ROW 7.67 COL 65.33 COLON-ALIGNED NO-LABEL
     fi_insaddr5 AT ROW 7.67 COL 112.33 COLON-ALIGNED NO-LABEL
     fi_covcod AT ROW 8.76 COL 18.5 COLON-ALIGNED NO-LABEL
     fi_garage AT ROW 8.76 COL 43.83 COLON-ALIGNED NO-LABEL
     fi_comdat AT ROW 8.76 COL 65.67 COLON-ALIGNED NO-LABEL
     fi_expdat AT ROW 8.76 COL 92.67 COLON-ALIGNED NO-LABEL
     fi_subclass AT ROW 8.76 COL 116.33 COLON-ALIGNED NO-LABEL
     fi_province AT ROW 9.81 COL 18.5 COLON-ALIGNED NO-LABEL
     fi_brand AT ROW 9.81 COL 48.83 COLON-ALIGNED NO-LABEL
     fi_model AT ROW 9.81 COL 70.33 COLON-ALIGNED NO-LABEL
     fi_status AT ROW 9.81 COL 113.33 COLON-ALIGNED NO-LABEL
     fi_licence AT ROW 10.86 COL 18.5 COLON-ALIGNED NO-LABEL
     fi_cha_no AT ROW 10.86 COL 58.67 COLON-ALIGNED NO-LABEL
     fi_eng_no AT ROW 10.86 COL 104.33 COLON-ALIGNED NO-LABEL
     fi_year AT ROW 11.91 COL 18.5 COLON-ALIGNED NO-LABEL
     fi_power AT ROW 11.91 COL 38.5 COLON-ALIGNED NO-LABEL
     fi_ton AT ROW 11.91 COL 68.67 COLON-ALIGNED NO-LABEL
     fi_sumsi AT ROW 12.95 COL 18.5 COLON-ALIGNED NO-LABEL
     fi_prem1 AT ROW 12.95 COL 47.17 COLON-ALIGNED NO-LABEL
     fi_sumsi2 AT ROW 12.95 COL 81.33 COLON-ALIGNED NO-LABEL
     fi_prem2 AT ROW 12.95 COL 108.33 COLON-ALIGNED NO-LABEL
     fi_stkno AT ROW 14.1 COL 18.67 COLON-ALIGNED NO-LABEL
     fi_comdat72 AT ROW 14.1 COL 53.17 COLON-ALIGNED NO-LABEL
     fi_expdat72 AT ROW 14.1 COL 81.33 COLON-ALIGNED NO-LABEL
     fi_premcomp AT ROW 14.1 COL 108.33 COLON-ALIGNED NO-LABEL
     fi_ins_off AT ROW 15.29 COL 18.5 COLON-ALIGNED NO-LABEL
     fi_remark2 AT ROW 15.29 COL 58.5 COLON-ALIGNED NO-LABEL
     fi_drivno1 AT ROW 16.43 COL 18.5 COLON-ALIGNED NO-LABEL
     fi_brith1 AT ROW 16.38 COL 65.5 COLON-ALIGNED NO-LABEL
     fi_drivno2 AT ROW 17.52 COL 18.5 COLON-ALIGNED NO-LABEL
     fi_brith2 AT ROW 17.52 COL 65.5 COLON-ALIGNED NO-LABEL
     fi_receipt AT ROW 18.62 COL 18.5 COLON-ALIGNED NO-LABEL
     fi_addr_re1 AT ROW 19.71 COL 18.5 COLON-ALIGNED NO-LABEL
     fi_remark1 AT ROW 20.76 COL 18.5 COLON-ALIGNED NO-LABEL
     fi_client AT ROW 20.76 COL 44.33 COLON-ALIGNED NO-LABEL
     fi_agent AT ROW 20.76 COL 66.5 COLON-ALIGNED NO-LABEL
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1.05
         SIZE 128.33 BY 22
         BGCOLOR 3 FGCOLOR 1 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     fi_trndat AT ROW 19.71 COL 92 COLON-ALIGNED NO-LABEL
     fi_release AT ROW 20.76 COL 92 COLON-ALIGNED NO-LABEL
     fi_userid AT ROW 20.76 COL 98.17 COLON-ALIGNED NO-LABEL
     bu_save AT ROW 18.76 COL 114.17
     bu_exit AT ROW 20.62 COL 114.17
     fi_kkapp AT ROW 2.29 COL 77 COLON-ALIGNED NO-LABEL WIDGET-ID 2
     "Subclass :":35 VIEW-AS TEXT
          SIZE 10 BY 1 AT ROW 8.76 COL 108
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "       Driv Name 1 :":30 VIEW-AS TEXT
          SIZE 18 BY 1 AT ROW 16.43 COL 2
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "Receipt Dat :":30 VIEW-AS TEXT
          SIZE 13.5 BY 1 AT ROW 1.19 COL 52.5
          BGCOLOR 18 FGCOLOR 0 FONT 6
     " Expiry Date :":35 VIEW-AS TEXT
          SIZE 13 BY 1 AT ROW 8.76 COL 81.17
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "     Driv Name 2 :":30 VIEW-AS TEXT
          SIZE 18 BY 1 AT ROW 17.52 COL 2.17
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "    ข้อมูลระบบKK :":30 VIEW-AS TEXT
          SIZE 18 BY 1 AT ROW 20.76 COL 2.17
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "Type Free :" VIEW-AS TEXT
          SIZE 11 BY 1 AT ROW 4.43 COL 91
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "Agent :":30 VIEW-AS TEXT
          SIZE 7.5 BY 1 AT ROW 20.76 COL 60.67
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "Date1:":30 VIEW-AS TEXT
          SIZE 7 BY 1 AT ROW 16.43 COL 59.17
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "Date2:":30 VIEW-AS TEXT
          SIZE 7 BY 1 AT ROW 17.52 COL 59.17
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "            STK no  :":35 VIEW-AS TEXT
          SIZE 18 BY 1 AT ROW 14.1 COL 2.17
          BGCOLOR 18 FGCOLOR 0 FONT 6
     " Reci . Addr1 :":30 VIEW-AS TEXT
          SIZE 18 BY 1 AT ROW 19.71 COL 2.17
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "Producer :":30 VIEW-AS TEXT
          SIZE 10 BY 1 AT ROW 20.76 COL 36
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "Ins_Addr2 :":30 VIEW-AS TEXT
          SIZE 11.5 BY 1 AT ROW 6.62 COL 75.33
          BGCOLOR 18 FGCOLOR 2 FONT 6
     "Ins_Addr4 :":30 VIEW-AS TEXT
          SIZE 11 BY 1 AT ROW 7.67 COL 56
          BGCOLOR 18 FGCOLOR 2 FONT 6
     "                Year  :":35 VIEW-AS TEXT
          SIZE 18 BY 1 AT ROW 11.91 COL 2
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "Com_date :":35 VIEW-AS TEXT
          SIZE 11 BY 1 AT ROW 14.1 COL 43.5
          BGCOLOR 18 FGCOLOR 0 FONT 6
     " Expiry Date :":35 VIEW-AS TEXT
          SIZE 13 BY 1 AT ROW 14.1 COL 69.83
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "Prem Comp :":30 VIEW-AS TEXT
          SIZE 11.5 BY 1 AT ROW 14.1 COL 98.33
          BGCOLOR 18 FGCOLOR 0 FONT 6
     " เลขที่สัญญา :":35 VIEW-AS TEXT
          SIZE 12 BY 1 AT ROW 2.24 COL 40
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "FName :":35 VIEW-AS TEXT
          SIZE 8.5 BY 1 AT ROW 5.52 COL 55.17
          BGCOLOR 18 FGCOLOR 2 FONT 6
     "         Sub Camp :":35 VIEW-AS TEXT
          SIZE 18 BY 1 AT ROW 4.43 COL 2
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "Model :":30 VIEW-AS TEXT
          SIZE 8 BY 1 AT ROW 9.81 COL 63.67
          BGCOLOR 18 FGCOLOR 0 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1.05
         SIZE 128.33 BY 22
         BGCOLOR 3 FGCOLOR 1 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "          Type title :":35 VIEW-AS TEXT
          SIZE 18 BY 1 AT ROW 5.52 COL 2
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "Trandat :" VIEW-AS TEXT
          SIZE 8.5 BY 1 AT ROW 19.71 COL 85
          FGCOLOR 2 FONT 6
     "Release:" VIEW-AS TEXT
          SIZE 8.5 BY 1 AT ROW 20.76 COL 85
          FGCOLOR 2 FONT 6
     "      Licence No. :":30 VIEW-AS TEXT
          SIZE 18 BY 1 AT ROW 10.86 COL 2
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "       Insur. MKT  :":35 VIEW-AS TEXT
          SIZE 18 BY 1 AT ROW 15.29 COL 2.17
          BGCOLOR 18 FGCOLOR 0 FONT 6
     " Sum  Si  Year 2 :":25 VIEW-AS TEXT
          SIZE 17 BY 1 AT ROW 12.95 COL 65.83
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "Ins_Addr5 :":30 VIEW-AS TEXT
          SIZE 11 BY 1 AT ROW 7.67 COL 102.83
          BGCOLOR 18 FGCOLOR 2 FONT 6
     "           Type car :":30 VIEW-AS TEXT
          SIZE 18 BY 1 AT ROW 9.81 COL 2
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "     Notified Date  :":30 VIEW-AS TEXT
          SIZE 18 BY 1 AT ROW 1.19 COL 2
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "Garage  :":35 VIEW-AS TEXT
          SIZE 9 BY 1 AT ROW 8.76 COL 36.17
          BGCOLOR 18 FGCOLOR 0 FONT 6
     " Weight Kg/Ton :":30 VIEW-AS TEXT
          SIZE 17 BY 1 AT ROW 11.91 COL 53.17
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "Com. date :":35 VIEW-AS TEXT
          SIZE 11.5 BY 1 AT ROW 8.76 COL 55.83
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "LName :":35 VIEW-AS TEXT
          SIZE 8 BY 1 AT ROW 5.52 COL 87.67
          BGCOLOR 18 FGCOLOR 2 FONT 6
     "   Sum  Si  Year 1 :":35 VIEW-AS TEXT
          SIZE 18 BY 1 AT ROW 12.95 COL 2
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "           BR Code :":35 VIEW-AS TEXT
          SIZE 18 BY 1 AT ROW 3.33 COL 2
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "Power.CC :":30 VIEW-AS TEXT
          SIZE 10.5 BY 1 AT ROW 11.91 COL 29.33
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "       Engine no.  :":35 VIEW-AS TEXT
          SIZE 18 BY 1 AT ROW 10.86 COL 87.67
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "หมายเหตุ :":30 VIEW-AS TEXT
          SIZE 9.33 BY 1 AT ROW 15.29 COL 50.83
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "Chassis No. :":20 VIEW-AS TEXT
          SIZE 12.5 BY 1 AT ROW 10.86 COL 47.33
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "    Receipt Name  :":30 VIEW-AS TEXT
          SIZE 18 BY 1 AT ROW 18.62 COL 2.17
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "BR Name :":35 VIEW-AS TEXT
          SIZE 10 BY 1 AT ROW 3.33 COL 29.5
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "Ins. Company :":35 VIEW-AS TEXT
          SIZE 15 BY 1 AT ROW 1.19 COL 80
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "Title :":35 VIEW-AS TEXT
          SIZE 6 BY 1 AT ROW 5.52 COL 36
          BGCOLOR 18 FGCOLOR 2 FONT 6
     "       Insur Addr3 :":30 VIEW-AS TEXT
          SIZE 18 BY 1 AT ROW 7.67 COL 2
          BGCOLOR 18 FGCOLOR 2 FONT 6
     "Prem 2  :":30 VIEW-AS TEXT
          SIZE 9 BY 1 AT ROW 12.95 COL 100.83
          BGCOLOR 18 FGCOLOR 0 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1.05
         SIZE 128.33 BY 22
         BGCOLOR 3 FGCOLOR 1 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "               Cover  :":30 VIEW-AS TEXT
          SIZE 18 BY 1 AT ROW 8.76 COL 2
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "          SKKI  No. :":35 VIEW-AS TEXT
          SIZE 18 BY 1 AT ROW 2.24 COL 2
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "KK App:":35 VIEW-AS TEXT
          SIZE 8.33 BY 1 AT ROW 2.29 COL 70.5 WIDGET-ID 4
          BGCOLOR 19 FGCOLOR 6 FONT 6
     "NotiTime :":30 VIEW-AS TEXT
          SIZE 9.5 BY 1 AT ROW 1.19 COL 34
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "Brand  :":30 VIEW-AS TEXT
          SIZE 8 BY 1 AT ROW 9.81 COL 42.33
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "       Insur Addr1 :":30 VIEW-AS TEXT
          SIZE 18 BY 1 AT ROW 6.62 COL 2
          BGCOLOR 18 FGCOLOR 2 FONT 6
     "Prem.  1  :":30 VIEW-AS TEXT
          SIZE 10 BY 1 AT ROW 12.95 COL 38.67
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "Campaign No. :":35 VIEW-AS TEXT
          SIZE 16 BY 1 AT ROW 3.33 COL 58.83
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "New/Use :":35 VIEW-AS TEXT
          SIZE 10 BY 1 AT ROW 9.81 COL 104.83
          BGCOLOR 18 FGCOLOR 0 FONT 6
     RECT-335 AT ROW 1 COL 1.17
     RECT-343 AT ROW 18.33 COL 113.17
     RECT-344 AT ROW 20.19 COL 113.17
     RECT-368 AT ROW 19.48 COL 84
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1.05
         SIZE 128.33 BY 22
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
         HEIGHT             = 21.95
         WIDTH              = 128.17
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
/* SETTINGS FOR FILL-IN fi_ins_comp IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_notdat IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_nottim IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_receivdat IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_release IN FRAME fr_main
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
                    /*tlt.datesent       = INPUT fi_notdat                                                                     
                    tlt.gentim         = INPUT fi_nottim                                                                     
                    tlt.dat_ins_noti   = INPUT fi_receivdat                                                                   
                    tlt.nor_usr_ins    = trim( Input fi_ins_comp )  */                                                                  
                    tlt.comp_noti_tlt  = trim( Input fi_policy   )                                                                    
                    tlt.nor_noti_tlt   = trim( Input fi_notno    )                                                                    
                    /*tlt.nor_noti_ins   = trim( INPUT fi_polsystem) *//*A61-0335*/                                                                   
                    tlt.nor_usr_tlt    = trim( INPUT fi_cmrcode  )                                                                    
                    tlt.comp_usr_tl    = trim( INPUT fi_pro_off  ) 
                    tlt.lotno          = trim( Input fi_campaign)                                                                    
                    tlt.lince3         = trim( Input fi_subcamp)                                                                       
                    tlt.comp_pol       = trim( Input fi_typfree)                                                                       
                    tlt.safe2          = trim( INPUT fi_typename)                                                                       
                    tlt.ins_name       = trim( INPUT fi_institle)  + " " +                                              
                                         trim( INPUT fi_preinsur)  + " " +                      
                                         trim( Input fi_preinsur2 )
                    tlt.ins_addr1      = trim( Input fi_insaddr1) 
                    tlt.ins_addr2      = trim( Input fi_insaddr2) 
                    tlt.ins_addr3      = trim( Input fi_insaddr3) 
                    tlt.ins_addr4      = trim( Input fi_insaddr4) 
                    tlt.ins_addr5      = trim( Input fi_insaddr5) 
                    tlt.safe3          = trim( Input fi_covcod)   
                    tlt.stat           = trim( Input fi_garage)   
                    tlt.nor_effdat     = Input fi_comdat  
                    tlt.expodat        = Input fi_expdat  
                    tlt.subins         = trim( Input fi_subclass)  
                    tlt.filler2        = trim( Input fi_province)  
                    tlt.brand          = trim( Input fi_brand)  
                    tlt.model          = trim( Input fi_model)  
                    tlt.filler1        = trim( Input fi_status)  
                    tlt.lince1         = trim( Input fi_licence)  
                    tlt.cha_no         = trim( Input fi_cha_no)  
                    tlt.eng_no         = trim( Input fi_eng_no)  
                    tlt.lince2         = trim( Input fi_year)  
                    tlt.cc_weight      = Input fi_power  
                    tlt.colorcod       = Input fi_ton  
                    tlt.comp_coamt     = Input fi_sumsi   
                    tlt.comp_grprm     = Input fi_prem1   
                    tlt.nor_coamt      = Input fi_sumsi2   
                    tlt.nor_grprm      = Input fi_prem2   
                    tlt.comp_sck       = trim( Input fi_stkno)               
                    tlt.comp_effdat    = Input fi_comdat72             
                    tlt.gendat         = Input fi_expdat72             
                    tlt.comp_noti_ins  = STRING(fi_premcomp)      
                    tlt.comp_usr_ins   = trim( Input fi_ins_off)   
                    tlt.old_cha        = trim( Input fi_remark2)   
                    tlt.dri_name1      = trim( Input fi_drivno1)   
                    tlt.dri_no1        = trim( Input fi_brith1)   
                    tlt.dri_name2      = trim( Input fi_drivno2)   
                    tlt.dri_no2        = trim( Input fi_brith2)   
                    tlt.rec_name       = trim( Input fi_receipt)   
                    tlt.rec_addr1      = trim( Input fi_addr_re1) 
                    tlt.OLD_eng        = trim( Input fi_remark1)  
                    tlt.comp_sub       = trim( Input fi_client)   
                    tlt.recac          = trim( Input fi_agent) 
                    tlt.expotim        = TRIM(INPUT fi_kkapp)   /*a61-0335*/
                    /*tlt.trndat        =  Input fi_trndat        
                    tlt.releas          =  Input fi_release   
                    tlt.endno           =  Input fi_userid */   .
            END.                            
            Apply "Close" to THIS-PROCEDURE  .
            Return no-apply.
        END.
        WHEN FALSE THEN /* No */          
            DO:   
            APPLY "entry" TO fi_policy.
            RETURN NO-APPLY.
        END.
        /*OTHERWISE /* Cancel */             
        STOP.*/
        END CASE.
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


&Scoped-define SELF-NAME fi_agent
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_agent C-Win
ON LEAVE OF fi_agent IN FRAME fr_main
DO:
  fi_agent  = INPUT fi_agent.
  DISP fi_agent WITH FRAM fr_main.
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


&Scoped-define SELF-NAME fi_brith1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_brith1 C-Win
ON LEAVE OF fi_brith1 IN FRAME fr_main
DO:
  fi_drivno2  = INPUT fi_drivno2.
  DISP fi_drivno2 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_brith2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_brith2 C-Win
ON LEAVE OF fi_brith2 IN FRAME fr_main
DO:
  fi_drivno2  = INPUT fi_drivno2.
  DISP fi_drivno2 WITH FRAM fr_main.
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


&Scoped-define SELF-NAME fi_covcod
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_covcod C-Win
ON LEAVE OF fi_covcod IN FRAME fr_main
DO:
  fi_covcod = INPUT fi_covcod.
  DISP fi_covcod WITH FRAM fr_main.
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


&Scoped-define SELF-NAME fi_expdat72
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_expdat72 C-Win
ON LEAVE OF fi_expdat72 IN FRAME fr_main
DO:
  fi_expdat72 = INPUT fi_expdat72.
  DISP fi_expdat72 WITH FRAM fr_main.
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
  fi_institle = INPUT fi_institle.
  DISP fi_institle WITH FRAM fr_main.
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
  fi_kkapp = INPUT fi_kkapp.
  DISP fi_kkapp WITH FRAM fr_main.
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


&Scoped-define SELF-NAME fi_model
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_model C-Win
ON LEAVE OF fi_model IN FRAME fr_main
DO:
  fi_model = INPUT fi_model.
  DISP fi_model WITH FRAM fr_main.
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


&Scoped-define SELF-NAME fi_policy
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_policy C-Win
ON LEAVE OF fi_policy IN FRAME fr_main
DO:
  fi_policy  =  Input  fi_policy.
  Disp  fi_policy with frame  fr_main.
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


&Scoped-define SELF-NAME fi_preinsur
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_preinsur C-Win
ON LEAVE OF fi_preinsur IN FRAME fr_main
DO:
  fi_preinsur = INPUT fi_preinsur.
  DISP fi_preinsur WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_preinsur2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_preinsur2 C-Win
ON LEAVE OF fi_preinsur2 IN FRAME fr_main
DO:
  fi_preinsur2 = INPUT fi_preinsur2.
  DISP fi_preinsur2 WITH FRAM fr_main.
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


&Scoped-define SELF-NAME fi_premcomp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_premcomp C-Win
ON LEAVE OF fi_premcomp IN FRAME fr_main
DO:
    fi_premcomp = INPUT fi_premcomp.
    DISP fi_premcomp WITH FRAM fr_main.
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


&Scoped-define SELF-NAME fi_status
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_status C-Win
ON LEAVE OF fi_status IN FRAME fr_main
DO:
  fi_status = INPUT fi_status.
  DISP fi_status WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_stkno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_stkno C-Win
ON LEAVE OF fi_stkno IN FRAME fr_main
DO:
  fi_stkno = INPUT fi_stkno.
  DISP fi_stkno WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_subcamp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_subcamp C-Win
ON LEAVE OF fi_subcamp IN FRAME fr_main
DO:
    fi_subcamp  =  Input  fi_subcamp.
    Disp  fi_subcamp with frame  fr_main.
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
    fi_typename  =  Input  fi_typename.
    Disp  fi_typename with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_typfree
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_typfree C-Win
ON LEAVE OF fi_typfree IN FRAME fr_main
DO:
    fi_typfree = INPUT fi_typfree.
    DISP fi_typfree WITH FRAM fr_main.
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

    gv_prgid = "wgwqukk3".
    gv_prog  = "Query &Update (KK-new Bank  co.,ltd.) ".
  RUN  WUT\WUTHEAD ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).

/*********************************************************************/ 
 /*  RUN Wut\WutwiCen ({&WINDOW-NAME}:HANDLE). */ 
  /*CURRENT-WINDOW:WINDOW-STATE = WINDOW-MAXIMIZED.*/
  SESSION:DATA-ENTRY-RETURN = YES.
  /*Rect-336:Move-to-top().*/
  /* Hide    fi_difprm  in frame  {&FRAME-NAME}.*/
  Find  tlt  Where   Recid(tlt)  =  nv_recidtlt NO-LOCK NO-ERROR NO-WAIT .
  If  avail  tlt  Then do:
      Assign
          fi_notdat    = tlt.datesent                                                                                        
          fi_nottim    = tlt.gentim                                                                                          
          fi_receivdat = tlt.dat_ins_noti                                                                                    
          fi_ins_comp  = tlt.nor_usr_ins                                                                                     
          fi_policy    = tlt.comp_noti_tlt                                                                                   
          fi_notno     = tlt.nor_noti_tlt                                                                                    
          /*fi_polsystem = tlt.nor_noti_ins */ /*A61-0335*/                                                                                   
          fi_cmrcode   = tlt.nor_usr_tlt                                                                                     
          fi_pro_off   = tlt.comp_usr_tl
          fi_campaign  = tlt.lotno                                                                                           
          fi_subcamp   = tlt.lince3                                                                                          
          fi_typfree   = tlt.comp_pol                                                                                        
          fi_typename  = tlt.safe2                                                                                           
          fi_institle  = substr(tlt.ins_name,1,INDEX(tlt.ins_name," "))                                                      
          fi_preinsur  = substr(tlt.ins_name,INDEX(tlt.ins_name," ") + 1,r-INDEX(tlt.ins_name," ") - INDEX(tlt.ins_name," "))
          fi_preinsur2 = substr(tlt.ins_name,r-INDEX(tlt.ins_name," ") + 1 )                                                 
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
          fi_ton       = tlt.colorcod     
          fi_sumsi     = tlt.comp_coamt   
          fi_prem1     = tlt.comp_grprm   
          fi_sumsi2    = tlt.nor_coamt    
          fi_prem2     = tlt.nor_grprm    
          fi_stkno     = tlt.comp_sck                 
          fi_comdat72  = tlt.comp_effdat              
          fi_expdat72  = tlt.gendat                   
          fi_premcomp  = deci(tlt.comp_noti_ins)      
          fi_ins_off   = tlt.comp_usr_ins 
          fi_remark2   = tlt.old_cha
          fi_drivno1   = tlt.dri_name1
          fi_brith1    = tlt.dri_no1
          fi_drivno2   = tlt.dri_name2      
          fi_brith2    = tlt.dri_no2  
          fi_receipt   = tlt.rec_name   
          fi_addr_re1  = tlt.rec_addr1  
          fi_remark1   = tlt.OLD_eng   
          fi_client    = tlt.comp_sub  
          fi_agent     = tlt.recac     
          fi_trndat    = tlt.trndat  
          fi_release   = tlt.releas 
          fi_userid    = tlt.endno
          fi_kkapp     = tlt.expotim .  /*A61-0335*/
      DISP  fi_notdat   fi_nottim    fi_receivdat    fi_ins_comp      
          fi_policy     fi_notno     /*fi_polsystem A61-0335*/    fi_cmrcode  
          fi_pro_off    fi_campaign  fi_subcamp      fi_typfree 
          fi_typename   fi_institle  fi_preinsur     fi_preinsur2 
          fi_insaddr1   fi_insaddr2  fi_insaddr3     fi_insaddr4  
          fi_insaddr5   fi_covcod    fi_garage       fi_comdat   
          fi_expdat     fi_subclass  fi_province     fi_brand    
          fi_model      fi_status    fi_licence      fi_cha_no  
          fi_eng_no     fi_year      fi_power        fi_ton       
          fi_sumsi      fi_prem1     fi_sumsi2       fi_prem2     
          fi_stkno      fi_comdat72  fi_expdat72     fi_premcomp  
          fi_ins_off    fi_remark2   fi_drivno1      fi_brith1  
          fi_drivno2    fi_brith2    fi_receipt      fi_addr_re1    
          fi_remark1    fi_client    fi_agent        fi_trndat 
          fi_release    fi_userid    fi_kkapp /*a61-0335*/    With frame  fr_main.
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
  DISPLAY fi_notdat fi_nottim fi_receivdat fi_ins_comp fi_policy fi_notno 
          fi_cmrcode fi_pro_off fi_campaign fi_subcamp fi_typfree fi_typename 
          fi_institle fi_preinsur fi_preinsur2 fi_insaddr1 fi_insaddr2 
          fi_insaddr3 fi_insaddr4 fi_insaddr5 fi_covcod fi_garage fi_comdat 
          fi_expdat fi_subclass fi_province fi_brand fi_model fi_status 
          fi_licence fi_cha_no fi_eng_no fi_year fi_power fi_ton fi_sumsi 
          fi_prem1 fi_sumsi2 fi_prem2 fi_stkno fi_comdat72 fi_expdat72 
          fi_premcomp fi_ins_off fi_remark2 fi_drivno1 fi_brith1 fi_drivno2 
          fi_brith2 fi_receipt fi_addr_re1 fi_remark1 fi_client fi_agent 
          fi_trndat fi_release fi_userid fi_kkapp 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE fi_policy fi_notno fi_cmrcode fi_pro_off fi_campaign fi_subcamp 
         fi_typfree fi_typename fi_institle fi_preinsur fi_preinsur2 
         fi_insaddr1 fi_insaddr2 fi_insaddr3 fi_insaddr4 fi_insaddr5 fi_covcod 
         fi_garage fi_subclass fi_province fi_brand fi_model fi_status 
         fi_licence fi_cha_no fi_eng_no fi_year fi_power fi_ton fi_sumsi 
         fi_prem1 fi_sumsi2 fi_prem2 fi_stkno fi_comdat72 fi_expdat72 
         fi_premcomp fi_ins_off fi_remark2 fi_drivno1 fi_brith1 fi_drivno2 
         fi_brith2 fi_receipt fi_addr_re1 fi_remark1 fi_client fi_agent bu_save 
         bu_exit fi_kkapp RECT-335 RECT-343 RECT-344 RECT-368 
      WITH FRAME fr_main IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

