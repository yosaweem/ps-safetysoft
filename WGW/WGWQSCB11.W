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
  wuwqscb11.w :  Quey & Update data notify Add in table  tlt  
  Create  by    :  Ranu I. A60-0448 Date 16/10/2017
  Connect :  gw_stat ld brstat , gw_safe ld sic_bran ,sic_test ld sicuw sicsyac :not connect stat
  Modify by : Kridtiya i. A64-0295 DATE. 25/07/2021 เพิ่มฟิล์ด Agent Code Agent Name TH Agent Name Eng Selling Channel
+++++++++++++++++++++++++++++++++++++++++++++++*/
Def  Input  parameter  nv_recidtlt  as  recid  .
Def  var nv_index  as int  init 0.
DEF  VAR nv_chaidrep AS CHAR . /*A57-0262*/
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
&Scoped-Define ENABLED-OBJECTS bu_detail2 bu_save bu_exit bu_detail1 ~
fi_comcod fi_comnam fi_camp fi_campnam fi_produc fi_producnam fi_pacg ~
fi_pacgnam fi_custtyp fi_nameth fi_surth fi_nameeng fi_sureng fi_icno ~
fi_sex fi_polbdate fi_polocc fi_poltel fi_mail fi_line fi_poladdr1 ~
fi_poladdr2 fi_senaddr1 fi_senaddr2 fi_paytyp fi_branch fi_paynam fi_paysur ~
fi_payic fi_payaddr1 fi_payaddr2 fi_bennam fi_paymcod fi_paymtyp fi_payway ~
fi_waytyp fi_bank fi_paydat fi_paidsts fi_saledat fi_payin fi_refno ~
fi_custcode fi_polno fi_poltyp fi_driver fi_drinam1 fi_drisur1 fi_driid1 ~
fi_drisex1 fi_driocc1 fi_dridate1 fi_drinam2 fi_drisur2 fi_driid2 ~
fi_drisex2 fi_driocc2 fi_dridate2 fi_producer fi_agent fi_trandat fi_user ~
fi_time fi_paysts fi_bennam2 fi_bennam3 fi_agentcode fi_agentth fi_agenten ~
fi_sellchannel RECT-462 RECT-464 RECT-465 
&Scoped-Define DISPLAYED-OBJECTS fi_custdes fi_comcod fi_comnam fi_camp ~
fi_campnam fi_produc fi_producnam fi_pacg fi_pacgnam fi_custtyp fi_nameth ~
fi_surth fi_nameeng fi_sureng fi_icno fi_sex fi_polbdate fi_polocc ~
fi_poltel fi_mail fi_line fi_poladdr1 fi_poladdr2 fi_senaddr1 fi_senaddr2 ~
fi_paytyp fi_branch fi_paynam fi_paysur fi_payic fi_payaddr1 fi_payaddr2 ~
fi_bennam fi_paymcod fi_paymtyp fi_payway fi_waytyp fi_bank fi_paydat ~
fi_paidsts fi_saledat fi_payin fi_refno fi_custcode fi_polno fi_poltyp ~
fi_driver fi_drinam1 fi_drisur1 fi_driid1 fi_drisex1 fi_driocc1 fi_dridate1 ~
fi_drinam2 fi_drisur2 fi_driid2 fi_drisex2 fi_driocc2 fi_dridate2 ~
fi_producer fi_agent fi_trandat fi_user fi_time fi_paysts fi_bennam2 ~
fi_bennam3 fi_agentcode fi_agentth fi_agenten fi_sellchannel 

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
     BGCOLOR 10 FGCOLOR 2 FONT 6.

DEFINE BUTTON bu_detail2 
     LABEL "ข้อมูลรถและความคุ้มครอง" 
     SIZE 28 BY 1
     BGCOLOR 10 FGCOLOR 1 FONT 6.

DEFINE BUTTON bu_exit 
     LABEL "Exit" 
     SIZE 8 BY 1.14
     BGCOLOR 6 FONT 6.

DEFINE BUTTON bu_save 
     LABEL "Save" 
     SIZE 7.83 BY 1.14
     BGCOLOR 2 FGCOLOR 15 FONT 6.

DEFINE VARIABLE fi_agent AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 17.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_agentcode AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_agenten AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 50 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_agentth AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 50 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_bank AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 30.17 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_bennam AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 36 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_bennam2 AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 36 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_bennam3 AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 35 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_branch AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_camp AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 17 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_campnam AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 24.83 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_comcod AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 12.83 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_comnam AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 28 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_custcode AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 23.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_custdes AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 19 BY 1
     BGCOLOR 19 FGCOLOR 4  NO-UNDO.

DEFINE VARIABLE fi_custtyp AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_dridate1 AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 12 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_dridate2 AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 12 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_driid1 AS CHARACTER FORMAT "X(13)":U 
     VIEW-AS FILL-IN 
     SIZE 12 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_driid2 AS CHARACTER FORMAT "X(13)":U 
     VIEW-AS FILL-IN 
     SIZE 12 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_drinam1 AS CHARACTER FORMAT "X(60)":U 
     VIEW-AS FILL-IN 
     SIZE 22.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_drinam2 AS CHARACTER FORMAT "X(60)":U 
     VIEW-AS FILL-IN 
     SIZE 22.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_driocc1 AS CHARACTER FORMAT "X(60)":U 
     VIEW-AS FILL-IN 
     SIZE 12 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_driocc2 AS CHARACTER FORMAT "X(60)":U 
     VIEW-AS FILL-IN 
     SIZE 12 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_drisex1 AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_drisex2 AS CHARACTER FORMAT "x(20)":U 
     VIEW-AS FILL-IN 
     SIZE 5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_drisur1 AS CHARACTER FORMAT "X(60)":U 
     VIEW-AS FILL-IN 
     SIZE 22.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_drisur2 AS CHARACTER FORMAT "X(60)":U 
     VIEW-AS FILL-IN 
     SIZE 22.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_driver AS INTEGER FORMAT ">9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 6 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_icno AS CHARACTER FORMAT "X(13)":U 
     VIEW-AS FILL-IN 
     SIZE 17.67 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_line AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 16.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_mail AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 22.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_nameeng AS CHARACTER FORMAT "X(60)":U 
     VIEW-AS FILL-IN 
     SIZE 31.67 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_nameth AS CHARACTER FORMAT "X(60)":U 
     VIEW-AS FILL-IN 
     SIZE 35.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_pacg AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 16.83 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_pacgnam AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 24.83 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_paidsts AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 15.33 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_payaddr1 AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 53.67 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_payaddr2 AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 50.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_paydat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 18.33 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_payic AS CHARACTER FORMAT "X(13)":U 
     VIEW-AS FILL-IN 
     SIZE 17.67 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_payin AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 13.67 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_paymcod AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_paymtyp AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 20 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_paynam AS CHARACTER FORMAT "X(60)":U 
     VIEW-AS FILL-IN 
     SIZE 31.33 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_paysts AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 18.83 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_paysur AS CHARACTER FORMAT "X(60)":U 
     VIEW-AS FILL-IN 
     SIZE 30.67 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_paytyp AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 5.83 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_payway AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 4.67 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_poladdr1 AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 45 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_poladdr2 AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 43 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_polbdate AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 13.83 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_polno AS CHARACTER FORMAT "X(13)":U 
     VIEW-AS FILL-IN 
     SIZE 17.83 BY 1
     BGCOLOR 10 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_polocc AS CHARACTER FORMAT "X(60)":U 
     VIEW-AS FILL-IN 
     SIZE 27.33 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_poltel AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 32.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_poltyp AS CHARACTER FORMAT "X(3)":U 
     VIEW-AS FILL-IN 
     SIZE 6.17 BY 1
     BGCOLOR 10 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_produc AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 16.33 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_producer AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 14.67 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_producnam AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 20.17 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_refno AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 23.67 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_saledat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 13.67 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_sellchannel AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_senaddr1 AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 45 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_senaddr2 AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 43 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_sex AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 9 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_sureng AS CHARACTER FORMAT "X(60)":U 
     VIEW-AS FILL-IN 
     SIZE 25.67 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_surth AS CHARACTER FORMAT "X(60)":U 
     VIEW-AS FILL-IN 
     SIZE 32 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_time AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 13.67 BY 1
     BGCOLOR 10 FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE fi_trandat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 13.67 BY 1
     BGCOLOR 10 FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE fi_user AS CHARACTER FORMAT "X(13)":U 
     VIEW-AS FILL-IN 
     SIZE 10.17 BY 1
     BGCOLOR 7 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_waytyp AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 23.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE RECTANGLE RECT-462
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132.5 BY 23.81
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-464
     EDGE-PIXELS 2 GRAPHIC-EDGE    ROUNDED 
     SIZE 131 BY 8
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-465
     EDGE-PIXELS 2 GRAPHIC-EDGE    ROUNDED 
     SIZE 131 BY 13
     BGCOLOR 19 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     fi_custdes AT ROW 7.38 COL 18.83 COLON-ALIGNED NO-LABEL
     bu_detail2 AT ROW 1.14 COL 29.83
     bu_save AT ROW 25 COL 112.67
     bu_exit AT ROW 25 COL 123.5
     bu_detail1 AT ROW 1.14 COL 1.83
     fi_comcod AT ROW 5.14 COL 13.17 COLON-ALIGNED NO-LABEL
     fi_comnam AT ROW 5.14 COL 36.17 COLON-ALIGNED NO-LABEL
     fi_camp AT ROW 5.1 COL 76.17 COLON-ALIGNED NO-LABEL
     fi_campnam AT ROW 5.1 COL 104.83 COLON-ALIGNED NO-LABEL
     fi_produc AT ROW 6.24 COL 13 COLON-ALIGNED NO-LABEL
     fi_producnam AT ROW 6.24 COL 43.83 COLON-ALIGNED NO-LABEL
     fi_pacg AT ROW 6.24 COL 76.33 COLON-ALIGNED NO-LABEL
     fi_pacgnam AT ROW 6.24 COL 104.83 COLON-ALIGNED NO-LABEL
     fi_custtyp AT ROW 7.38 COL 13 COLON-ALIGNED NO-LABEL
     fi_nameth AT ROW 7.38 COL 49.67 COLON-ALIGNED NO-LABEL
     fi_surth AT ROW 7.38 COL 97.67 COLON-ALIGNED NO-LABEL
     fi_nameeng AT ROW 8.52 COL 12.83 COLON-ALIGNED NO-LABEL
     fi_sureng AT ROW 8.52 COL 59.33 COLON-ALIGNED NO-LABEL
     fi_icno AT ROW 8.52 COL 97.67 COLON-ALIGNED NO-LABEL
     fi_sex AT ROW 8.48 COL 120.67 COLON-ALIGNED NO-LABEL
     fi_polbdate AT ROW 9.71 COL 12.67 COLON-ALIGNED NO-LABEL
     fi_polocc AT ROW 9.71 COL 32.67 COLON-ALIGNED NO-LABEL
     fi_poltel AT ROW 9.71 COL 69.33 COLON-ALIGNED NO-LABEL
     fi_mail AT ROW 9.71 COL 107 COLON-ALIGNED NO-LABEL
     fi_line AT ROW 10.86 COL 12.67 COLON-ALIGNED NO-LABEL
     fi_poladdr1 AT ROW 10.86 COL 35 COLON-ALIGNED NO-LABEL
     fi_poladdr2 AT ROW 10.86 COL 86.67 COLON-ALIGNED NO-LABEL
     fi_senaddr1 AT ROW 12.05 COL 12.5 COLON-ALIGNED NO-LABEL
     fi_senaddr2 AT ROW 12.05 COL 68.33 COLON-ALIGNED NO-LABEL
     fi_paytyp AT ROW 17.76 COL 12.67 COLON-ALIGNED NO-LABEL
     fi_branch AT ROW 20 COL 12.67 COLON-ALIGNED NO-LABEL
     fi_paynam AT ROW 17.76 COL 28.17 COLON-ALIGNED NO-LABEL
     fi_paysur AT ROW 17.76 COL 68.33 COLON-ALIGNED NO-LABEL
     fi_payic AT ROW 17.76 COL 111.33 COLON-ALIGNED NO-LABEL
     fi_payaddr1 AT ROW 18.91 COL 12.67 COLON-ALIGNED NO-LABEL
     fi_payaddr2 AT ROW 18.91 COL 78.67 COLON-ALIGNED NO-LABEL
     fi_bennam AT ROW 15.43 COL 16.5 COLON-ALIGNED NO-LABEL
     fi_paymcod AT ROW 20 COL 37.33 COLON-ALIGNED NO-LABEL
     fi_paymtyp AT ROW 20 COL 56.17 COLON-ALIGNED NO-LABEL
     fi_payway AT ROW 20 COL 87.33 COLON-ALIGNED NO-LABEL
     fi_waytyp AT ROW 20 COL 105.67 COLON-ALIGNED NO-LABEL
     fi_bank AT ROW 21.24 COL 12.67 COLON-ALIGNED NO-LABEL
     fi_paydat AT ROW 21.24 COL 51.83 COLON-ALIGNED NO-LABEL
     fi_paidsts AT ROW 21.24 COL 113.67 COLON-ALIGNED NO-LABEL
     fi_saledat AT ROW 22.38 COL 12.83 COLON-ALIGNED NO-LABEL
     fi_payin AT ROW 22.38 COL 36.67 COLON-ALIGNED NO-LABEL
     fi_refno AT ROW 3.91 COL 66.67 COLON-ALIGNED NO-LABEL
     fi_custcode AT ROW 3.91 COL 100.33 COLON-ALIGNED NO-LABEL
     fi_polno AT ROW 2.48 COL 44 COLON-ALIGNED NO-LABEL
     fi_poltyp AT ROW 2.48 COL 62.17 COLON-ALIGNED NO-LABEL
     fi_driver AT ROW 12.05 COL 121.83 COLON-ALIGNED NO-LABEL
     fi_drinam1 AT ROW 13.19 COL 12.5 COLON-ALIGNED NO-LABEL
     fi_drisur1 AT ROW 13.19 COL 39.67 COLON-ALIGNED NO-LABEL
     fi_driid1 AT ROW 13.19 COL 69.67 COLON-ALIGNED NO-LABEL
     fi_drisex1 AT ROW 13.19 COL 104.33 COLON-ALIGNED NO-LABEL
     fi_driocc1 AT ROW 13.19 COL 87.33 COLON-ALIGNED NO-LABEL
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1.17 ROW 1.05
         SIZE 133.67 BY 25.95
         BGCOLOR 30 FGCOLOR 1 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     fi_dridate1 AT ROW 13.19 COL 117 COLON-ALIGNED NO-LABEL
     fi_drinam2 AT ROW 14.33 COL 12.33 COLON-ALIGNED NO-LABEL
     fi_drisur2 AT ROW 14.33 COL 39.67 COLON-ALIGNED NO-LABEL
     fi_driid2 AT ROW 14.33 COL 69.67 COLON-ALIGNED NO-LABEL
     fi_drisex2 AT ROW 14.33 COL 104.33 COLON-ALIGNED NO-LABEL
     fi_driocc2 AT ROW 14.33 COL 87.33 COLON-ALIGNED NO-LABEL
     fi_dridate2 AT ROW 14.33 COL 117 COLON-ALIGNED NO-LABEL
     fi_producer AT ROW 4.05 COL 13.33 COLON-ALIGNED NO-LABEL
     fi_agent AT ROW 4.05 COL 37.17 COLON-ALIGNED NO-LABEL
     fi_trandat AT ROW 2.43 COL 82.17 COLON-ALIGNED NO-LABEL
     fi_user AT ROW 2.43 COL 120.5 COLON-ALIGNED NO-LABEL
     fi_time AT ROW 2.43 COL 101 COLON-ALIGNED NO-LABEL
     fi_paysts AT ROW 21.24 COL 80.67 COLON-ALIGNED NO-LABEL
     fi_bennam2 AT ROW 15.48 COL 55.5 COLON-ALIGNED NO-LABEL WIDGET-ID 2
     fi_bennam3 AT ROW 15.48 COL 94.5 COLON-ALIGNED NO-LABEL WIDGET-ID 6
     fi_agentcode AT ROW 22.38 COL 62 COLON-ALIGNED NO-LABEL WIDGET-ID 10
     fi_agentth AT ROW 23.57 COL 15.83 COLON-ALIGNED NO-LABEL WIDGET-ID 14
     fi_agenten AT ROW 23.62 COL 80 COLON-ALIGNED NO-LABEL WIDGET-ID 18
     fi_sellchannel AT ROW 22.38 COL 91 COLON-ALIGNED NO-LABEL WIDGET-ID 22
     "สาขา:" VIEW-AS TEXT
          SIZE 4.5 BY .91 AT ROW 20.05 COL 9.33
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "วันที่รับเงิน:" VIEW-AS TEXT
          SIZE 9.5 BY .91 AT ROW 22.48 COL 29
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "สถานะการจ่าย:" VIEW-AS TEXT
          SIZE 11.83 BY .91 AT ROW 21.29 COL 102.83
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "ชื่อผู้ขับขี่2:" VIEW-AS TEXT
          SIZE 8.5 BY .91 AT ROW 14.38 COL 5.67
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "Agent :" VIEW-AS TEXT
          SIZE 7.67 BY .91 AT ROW 4.1 COL 30.83
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "Policy No :" VIEW-AS TEXT
          SIZE 10.5 BY .91 AT ROW 2.52 COL 35.33
          BGCOLOR 19 FGCOLOR 4 FONT 6
     "ที่อยู่ 2:" VIEW-AS TEXT
          SIZE 5.5 BY .91 AT ROW 10.91 COL 83.17
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "รหัสช่องทาง:" VIEW-AS TEXT
          SIZE 9.83 BY .91 AT ROW 20.1 COL 78.67
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "ที่อยู่จัดส่ง 2:" VIEW-AS TEXT
          SIZE 9.5 BY .91 AT ROW 12.1 COL 60.17
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "เลขบัตร:" VIEW-AS TEXT
          SIZE 7 BY .91 AT ROW 14.38 COL 64.5
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "ชื่อผู้ขับขี่1:" VIEW-AS TEXT
          SIZE 8.5 BY .91 AT ROW 13.24 COL 6
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "ประเภทการจ่าย:" VIEW-AS TEXT
          SIZE 13 BY .91 AT ROW 20.1 COL 44.83
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "  ข้อมูลลูกค้าและการชำระเงิน" VIEW-AS TEXT
          SIZE 23.5 BY .91 AT ROW 1.14 COL 110.5
          FGCOLOR 15 FONT 1
     "วันเกิด:" VIEW-AS TEXT
          SIZE 6.5 BY .91 AT ROW 13.24 COL 111.83
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "ที่อยู่ใบเสร็จ2:" VIEW-AS TEXT
          SIZE 11.17 BY .91 AT ROW 18.95 COL 69.17
          BGCOLOR 19 FGCOLOR 2 FONT 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1.17 ROW 1.05
         SIZE 133.67 BY 25.95
         BGCOLOR 30 FGCOLOR 1 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "ที่อยู่จัดส่ง1:" VIEW-AS TEXT
          SIZE 9 BY .91 AT ROW 12.14 COL 5.17
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "ผู้รับผลประโยชน์1:" VIEW-AS TEXT
          SIZE 14.5 BY .91 AT ROW 15.48 COL 3.17
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "ชื่อแคมเปญ:" VIEW-AS TEXT
          SIZE 10.67 BY .91 AT ROW 5.14 COL 96
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "สกุล:" VIEW-AS TEXT
          SIZE 3.5 BY .91 AT ROW 14.38 COL 37.33
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "ประเภทลูกค้า:" VIEW-AS TEXT
          SIZE 11.33 BY .91 AT ROW 7.43 COL 3.5
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "ที่อยู่ใบเสร็จ:" VIEW-AS TEXT
          SIZE 9.83 BY .91 AT ROW 19 COL 4
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "รหัสการจ่าย:" VIEW-AS TEXT
          SIZE 10 BY .91 AT ROW 20.1 COL 29
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "  ข้อมูลการชำระเงิน" VIEW-AS TEXT
          SIZE 19 BY .91 AT ROW 16.86 COL 4.67
          BGCOLOR 19 FGCOLOR 6 FONT 6
     "  ข้อมูลลูกค้า" VIEW-AS TEXT
          SIZE 12.17 BY .91 AT ROW 3 COL 3.83
          BGCOLOR 19 FGCOLOR 6 FONT 6
     "ชื่อแพ็คเกจ:" VIEW-AS TEXT
          SIZE 10.17 BY .91 AT ROW 6.29 COL 96.33
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "เพศ:" VIEW-AS TEXT
          SIZE 4.5 BY .91 AT ROW 14.38 COL 101.83
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "เลขบัตร ปชช:" VIEW-AS TEXT
          SIZE 11 BY .91 AT ROW 8.57 COL 88
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "วันที่ชำระ:" VIEW-AS TEXT
          SIZE 7.83 BY .91 AT ROW 21.29 COL 45.33
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "วันที่ขาย:" VIEW-AS TEXT
          SIZE 7.5 BY .91 AT ROW 22.48 COL 6.5
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "เลขที่อ้างอิง:" VIEW-AS TEXT
          SIZE 10.83 BY .91 AT ROW 4 COL 57.5
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "นามสกุลอังกฤษ:" VIEW-AS TEXT
          SIZE 13 BY .91 AT ROW 8.57 COL 48
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "รหัสลูกค้า:" VIEW-AS TEXT
          SIZE 9 BY .91 AT ROW 4 COL 93
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "เบอร์โทร :" VIEW-AS TEXT
          SIZE 8.5 BY .91 AT ROW 9.76 COL 62.5
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "ระบุผู้ขับขี่:" VIEW-AS TEXT
          SIZE 8.5 BY .91 AT ROW 12.1 COL 115
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "สกุล:" VIEW-AS TEXT
          SIZE 3.5 BY .91 AT ROW 13.24 COL 37.5
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "เลขบัตร:" VIEW-AS TEXT
          SIZE 7 BY .91 AT ROW 13.24 COL 64.5
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "อาชีพ:" VIEW-AS TEXT
          SIZE 5.5 BY .91 AT ROW 9.76 COL 29
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "อาชีพ:" VIEW-AS TEXT
          SIZE 5 BY .91 AT ROW 13.24 COL 84.17
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "ที่อยู่1:" VIEW-AS TEXT
          SIZE 5 BY .91 AT ROW 10.95 COL 31.67
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "เพศ:" VIEW-AS TEXT
          SIZE 4.5 BY .91 AT ROW 13.24 COL 101.83
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "นามสกุล:" VIEW-AS TEXT
          SIZE 7.33 BY .91 AT ROW 17.81 COL 62.83
          BGCOLOR 19 FGCOLOR 2 FONT 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1.17 ROW 1.05
         SIZE 133.67 BY 25.95
         BGCOLOR 30 FGCOLOR 1 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "User:" VIEW-AS TEXT
          SIZE 5.33 BY .91 AT ROW 2.48 COL 117.17
          BGCOLOR 19 FGCOLOR 6 FONT 1
     "สถานะชำระ:" VIEW-AS TEXT
          SIZE 9.83 BY .91 AT ROW 21.29 COL 72.5
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "ประเภทผู้จ่าย:" VIEW-AS TEXT
          SIZE 11.33 BY .91 AT ROW 17.76 COL 3
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "อาชีพ:" VIEW-AS TEXT
          SIZE 5 BY .91 AT ROW 14.38 COL 84
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "2:" VIEW-AS TEXT
          SIZE 2 BY .91 AT ROW 15.48 COL 55.17 WIDGET-ID 4
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "3:" VIEW-AS TEXT
          SIZE 2 BY .91 AT ROW 15.48 COL 94 WIDGET-ID 8
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "ชื่อไทย:" VIEW-AS TEXT
          SIZE 6.5 BY .91 AT ROW 7.48 COL 44.83
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "Agent Code:" VIEW-AS TEXT
          SIZE 10 BY .91 AT ROW 22.48 COL 53.5 WIDGET-ID 12
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "Producer :" VIEW-AS TEXT
          SIZE 10.83 BY .91 AT ROW 4.1 COL 4
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "Agent Name TH:" VIEW-AS TEXT
          SIZE 13.5 BY .91 AT ROW 23.48 COL 3.5 WIDGET-ID 16
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "วันที่โหลดงาน:" VIEW-AS TEXT
          SIZE 11.5 BY .91 AT ROW 2.48 COL 72.5
          BGCOLOR 19 FGCOLOR 6 FONT 1
     "Agent Name EN:" VIEW-AS TEXT
          SIZE 13.5 BY .91 AT ROW 23.62 COL 68 WIDGET-ID 20
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "รหัสผลิตภัณฑ์:" VIEW-AS TEXT
          SIZE 11 BY .91 AT ROW 6.29 COL 3.83
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "Selling Channe:" VIEW-AS TEXT
          SIZE 12.5 BY .91 AT ROW 22.48 COL 80 WIDGET-ID 24
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "ช่องทางการจ่าย:" VIEW-AS TEXT
          SIZE 13 BY .91 AT ROW 20.1 COL 94.67
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "ชื่อบริษัท:" VIEW-AS TEXT
          SIZE 8 BY .91 AT ROW 5.19 COL 29.5
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "เลขบัตร ปชช:" VIEW-AS TEXT
          SIZE 11 BY .91 AT ROW 17.81 COL 101.67
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "เวลา:" VIEW-AS TEXT
          SIZE 4.5 BY .91 AT ROW 2.48 COL 98.17
          BGCOLOR 19 FGCOLOR 6 FONT 1
     "วันเกิด:" VIEW-AS TEXT
          SIZE 6.5 BY .91 AT ROW 14.38 COL 111.83
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "ธนาคาร:" VIEW-AS TEXT
          SIZE 7 BY .91 AT ROW 21.29 COL 7
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "รหัสแคมเปญ:" VIEW-AS TEXT
          SIZE 11 BY .91 AT ROW 5.19 COL 67
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "รหัสบริษัท:" VIEW-AS TEXT
          SIZE 9 BY .91 AT ROW 5.19 COL 6
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "เพศ:" VIEW-AS TEXT
          SIZE 4.5 BY .91 AT ROW 8.52 COL 118.17
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "รหัสแพ็คเกจ:" VIEW-AS TEXT
          SIZE 11 BY .91 AT ROW 6.29 COL 67.17
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "ชื่อผลิตภัณฑ์:" VIEW-AS TEXT
          SIZE 11 BY .91 AT ROW 6.29 COL 34.5
          BGCOLOR 19 FGCOLOR 2 FONT 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1.17 ROW 1.05
         SIZE 133.67 BY 25.95
         BGCOLOR 30 FGCOLOR 1 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "อีเมล์:" VIEW-AS TEXT
          SIZE 4.5 BY .91 AT ROW 9.76 COL 104.5
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "ชื่ออังกฤษ:" VIEW-AS TEXT
          SIZE 8.5 BY .91 AT ROW 8.48 COL 6.17
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "นามสกุลไทย:" VIEW-AS TEXT
          SIZE 11.17 BY .91 AT ROW 7.43 COL 88.5
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "วันเดือนปีเกิด:" VIEW-AS TEXT
          SIZE 11.5 BY .91 AT ROW 9.71 COL 3
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "ชื่อผู้จ่าย:" VIEW-AS TEXT
          SIZE 7.5 BY .91 AT ROW 17.86 COL 22.5
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "ไลน์ไอดี:" VIEW-AS TEXT
          SIZE 7.5 BY .91 AT ROW 10.91 COL 7
          BGCOLOR 19 FGCOLOR 2 FONT 1
     RECT-462 AT ROW 2.67 COL 2
     RECT-464 AT ROW 16.81 COL 2
     RECT-465 AT ROW 3.67 COL 2
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1.17 ROW 1.05
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
         HEIGHT             = 25.86
         WIDTH              = 134
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
/* SETTINGS FOR FILL-IN fi_custdes IN FRAME fr_main
   NO-ENABLE                                                            */
ASSIGN 
       fi_custdes:READ-ONLY IN FRAME fr_main        = TRUE.

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


&Scoped-define SELF-NAME bu_detail2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_detail2 C-Win
ON CHOOSE OF bu_detail2 IN FRAME fr_main /* ข้อมูลรถและความคุ้มครอง */
DO:
    /*Get Current br_tlt.*/
        nv_recidtlt  =  Recid(tlt).

        {&WINDOW-NAME}:hidden  =  Yes. 
        
        Run  wgw\wgwqscb12(Input  nv_recidtlt).
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
                ASSIGN 
                    brstat.tlt.policy        = trim(input fi_polno)      /*เบอร์กรม */       
                    brstat.tlt.recac         = trim(input fi_agent)      /*Agent code */
                    brstat.tlt.subins        = trim(input fi_producer)   /*Producer */
                    brstat.tlt.nor_noti_ins  = trim(input fi_refno)      /*เลขอ้างอิง*/
                    brstat.tlt.nor_usr_ins   = trim(input fi_custcode)   /*รหัสลูกค้า */
                    brstat.tlt.lotno         = "InsCode:" + trim(fi_comcod)  + " " +    /*รหัสบริษัทประกันภัย */                                             
                                               "InsName:" + trim(fi_comnam)  + " " +    /*ชื่อบริษัทประกันภัย */                                             
                                               "CamCode:" + trim(fi_camp)    + " " +    /*รหัสแคมเปญ    */                                                   
                                               "CamName:" + trim(fi_campnam)            /*ชื่อแคมเปญ    */                                                   
                    brstat.tlt.usrsent       = "ProCode:" + trim(fi_produc) + " " +     /*รหัสผลิตภัณฑ์ */                                                  
                                               "ProName:" + trim(fi_producnam) + " " +  /*ชื่อผลิตภัณฑ์ */                                                  
                                               "PackNam:" + trim(fi_pacgnam) + " " +    /*ชื่อแพคเกจ    */                                                  
                                               "PackCod:" + trim(fi_pacg)               /*รหัสแพคเกจ    */                                                  
                    brstat.tlt.imp           = TRIM(fi_custtyp)                         /*ประเภท        */                                                  
                    brstat.tlt.ins_name      = "NameTha:" + trim(fi_nameth)  + " "      /*ชื่อผู้เอาประกัน  */                                               
                                                          + trim(fi_surth)   + " " +    /*นามสกุลผู้เอาประกัน */                                               
                                               "NameEng:" + trim(fi_nameeng) + " "      /*ชื่อภาษา อังกฤษ   */                                         
                                                          + trim(fi_sureng)             /*นามสกุลภาษา อังกฤษ*/                                         
                    brstat.tlt.rec_addr5     = "ICNo:"  + trim(fi_icno)  + " " +        /*เลขที่บัตรประชาชน/เลขที่ผูเสียภาษี   */                           
                                               "Sex:"   + trim(fi_sex)   + " " +        /*เพศ                          */                                   
                                               "Birth:" + trim(STRING(fi_polbdate),"99/99/9999") + " " +   /*วันเดือนปีเกิด ( DD/MM/YYYY) */                                   
                                               "Occup:" + trim(fi_polocc)                /*อาชีพ  */                                   
                    brstat.tlt.ins_addr5     = "Phone:" + TRIM(fi_poltel) + " " +        /*เบอร์โทร */
                                               "Email:" + TRIM(fi_mail)   + " " +        /*email   */                                    
                                               "Linid:" + TRIM(fi_line)                  /*Line_ID */                                    
                    brstat.tlt.ins_addr1     = trim(fi_poladdr1)                         /*ที่อยูลูกค้า*/                                                   
                    brstat.tlt.ins_addr2     = trim(fi_poladdr2)                                               
                    brstat.tlt.ins_addr3     = trim(fi_senaddr1)                         /*ที่อยูจัดส่ง*/ 
                    brstat.tlt.ins_addr4     = trim(fi_senaddr2)                         
                    brstat.tlt.exp           = "PayTyp:" + TRIM(fi_paytyp) + " " +       /*ประเภท ผู้จ่ายเงิน*/                       
                                               "Branch:" + TRIM(fi_branch)               /*สาขา*/                                        
                    brstat.tlt.rec_name      = trim(fi_paynam) + " " + trim(fi_paysur)   /* ชื่อ - สกุล ผู้จ่ายเงิน*/   
                    brstat.tlt.comp_sub      = trim(fi_payic)                            /* เลขบัตร ปปช. ผู้จ่ายเงิน*/  
                    brstat.tlt.rec_addr1     = trim(fi_payaddr1)                         /*ที่อยู่ออกใบเสร็จ */                                            
                    brstat.tlt.rec_addr2     = trim(fi_payaddr2)                         
                    brstat.tlt.safe1         = trim(fi_bennam)                           /*ชื่อ - สกุล ผู้รับผลประโยชน์*/ 
                    brstat.tlt.safe2         = "PaymentMD:"   + trim(fi_paymcod) + " " + /*รหัสประเภทการชำระเบี้ยประกัน*/                                      
                                               "PaymentMDTy:" + TRIM(fi_paymtyp) + " " + /*ประเภทการชำระเบี้ยประกัน    */                                   
                                               "PaymentTyCd:" + trim(fi_payway)  + " " + /*รหัสช่องทางที่ชำระเบี้ย*/                                        
                                               "Paymentty:"   + trim(fi_waytyp)          /*ช่องทางที่ชำระค่าเบี้ย */                                        
                    brstat.tlt.safe3         = TRIM(fi_bank)                             /*ธนาคารที่ชำระเบี้ย*/                                                
                    brstat.tlt.rec_addr4     = "Paydat:" + trim(string(fi_paydat),"99/99/9999") + " " +       /*วันที่ชำระค่าเบี้ย*/                                                
                                               "PaySts:" + trim(fi_paysts )  + " " +    /*สถานะการชำระเบี้ย */                                                
                                               "Paid:"   + trim(fi_paidsts)             /*สถานะการจ่ายเงิน*/                                                  
                    brstat.tlt.datesent      = date(fi_saledat)                         /*วันที่ขาย       */                                                  
                    brstat.tlt.dat_ins_noti  = date(fi_payin)                           /*วันที่รับชำระเงิน */                                                
                    brstat.tlt.endcnt        = INT(fi_driver)                           /*การระบุชื่อผู้ขับ */                                                     
                    brstat.tlt.dri_name1     = "Drinam1:" + trim(input fi_drinam1)  + " " +   /*ชื่อผู้ขับขี่ 1 */                                            
                                                            trim(input fi_drisur1) + " " +    /*นามสกุล ผู้ขับขี่ 1   */                                       
                                               "DriId1:"  + trim(input fi_driid1)             /*เลขที่บัตรผู้ขับขี่ 1 */                                     
                    brstat.tlt.dri_no1       = "DriOcc1:" + trim(input fi_driocc1) + " " +    /*Driver1Occupation  */                                            
                                               "DriSex1:" + TRIM(input fi_drisex1) + " " +  /*เพศ ผู้ขับขี่ 1 */                                          
                                               "DriBir1:" + trim(STRING(fi_dridate1),"99/99/9999")     /*วันเดือนปีเกิดผู้ขับขี่ 1 */                        
                    brstat.tlt.dri_name2     = "Drinam2:" + trim(input fi_drinam2)  + " " +   /*ชื่อผู้ขับขี่2    */                                         
                                                            trim(input fi_drisur2) + " " +    /*นามสกุล ผู้ขับขี่ 2*/                                          
                                               "DriId2:"  + trim(input fi_driid2)             /*เลขที่บัตรผู้ขับขี่2 */                                      
                    brstat.tlt.dri_no2       = "DriOcc2:" + trim(input fi_driocc2) + " " +    /*Driver2Occupation  */                                            
                                               "DriSex2:" + TRIM(input fi_drisex2)   + " " +  /*เพศ ผู้ขับขี่2    */                                      
                                               "DriBir2:" + trim(STRING(fi_dridate2),"99/99/9999")      /*วันเดือนปีเกิดผู้ขับขี่ 2 */ 
                    brstat.tlt.ben83    = trim(input fi_bennam2)      /*Kridtiya i. A64-0295 DATE. 25/07/2021*/ 
                    brstat.tlt.note4    = trim(input fi_bennam3)      /*Kridtiya i. A64-0295 DATE. 25/07/2021*/ 
                    brstat.tlt.agent    = trim(input fi_agentcode)    /*Kridtiya i. A64-0295 DATE. 25/07/2021*/ 
                    brstat.tlt.note1    = trim(input fi_agentth)      /*Kridtiya i. A64-0295 DATE. 25/07/2021*/ 
                    brstat.tlt.note2    = trim(input fi_agenten)      /*Kridtiya i. A64-0295 DATE. 25/07/2021*/ 
                    brstat.tlt.note3    = trim(input fi_sellchannel). /*Kridtiya i. A64-0295 DATE. 25/07/2021*/ 



                   
            END.                                                    
            Apply "Close" to this-procedure.
            Return no-apply.
            /* APPLY "entry" TO fi_branch.
            RETURN NO-APPLY. */
        END.
        WHEN FALSE THEN /* No */          
            DO:   
            APPLY "entry" TO fi_polno.
            RETURN NO-APPLY.
        END.
        /*OTHERWISE /* Cancel */             
        STOP.*/
        END CASE.
Disp  fi_polno with  frame  fr_main.
RELEASE brstat.tlt.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_agent
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_agent C-Win
ON LEAVE OF fi_agent IN FRAME fr_main
DO:
    fi_agent = INPUT fi_agent .
    DISP fi_agent WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_agentcode
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_agentcode C-Win
ON LEAVE OF fi_agentcode IN FRAME fr_main
DO:
    fi_agentcode = INPUT fi_agentcode .
    DISP fi_agentcode WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_agenten
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_agenten C-Win
ON LEAVE OF fi_agenten IN FRAME fr_main
DO:
    fi_agenten = INPUT fi_agenten .
    DISP fi_agenten WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_agentth
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_agentth C-Win
ON LEAVE OF fi_agentth IN FRAME fr_main
DO:
    fi_agentth = INPUT fi_agentth .
    DISP fi_agentth WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_bank
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_bank C-Win
ON LEAVE OF fi_bank IN FRAME fr_main
DO:
    fi_bank = INPUT fi_bank .
    DISP fi_bank WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_bennam
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_bennam C-Win
ON LEAVE OF fi_bennam IN FRAME fr_main
DO:
    fi_bennam = INPUT fi_bennam .
    DISP fi_bennam WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_bennam2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_bennam2 C-Win
ON LEAVE OF fi_bennam2 IN FRAME fr_main
DO:
    fi_bennam2 = INPUT fi_bennam2 .
    DISP fi_bennam2 WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_bennam3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_bennam3 C-Win
ON LEAVE OF fi_bennam3 IN FRAME fr_main
DO:
    fi_bennam3 = INPUT fi_bennam3 .
    DISP fi_bennam3 WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_branch
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_branch C-Win
ON LEAVE OF fi_branch IN FRAME fr_main
DO:
    fi_branch = INPUT fi_branch .
    DISP fi_branch WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_camp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_camp C-Win
ON LEAVE OF fi_camp IN FRAME fr_main
DO:
    fi_camp = INPUT fi_camp .
    DISP fi_camp WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_campnam
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_campnam C-Win
ON LEAVE OF fi_campnam IN FRAME fr_main
DO:
    fi_campnam = INPUT fi_campnam .
    DISP fi_campnam WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_comcod
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_comcod C-Win
ON LEAVE OF fi_comcod IN FRAME fr_main
DO:
    fi_comcod = INPUT fi_comcod .
    DISP fi_comcod WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_comnam
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_comnam C-Win
ON LEAVE OF fi_comnam IN FRAME fr_main
DO:
    fi_comnam = INPUT fi_comnam .
    DISP fi_comnam WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_custcode
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_custcode C-Win
ON LEAVE OF fi_custcode IN FRAME fr_main
DO:
    fi_custcode = INPUT fi_custcode .
    DISP fi_custcode WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_custtyp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_custtyp C-Win
ON LEAVE OF fi_custtyp IN FRAME fr_main
DO:
    fi_custtyp = INPUT fi_custtyp .
    DISP fi_custtyp WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_dridate1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_dridate1 C-Win
ON LEAVE OF fi_dridate1 IN FRAME fr_main
DO:
    fi_dridate1 = INPUT fi_dridate1 .
    DISP fi_dridate1 WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_dridate2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_dridate2 C-Win
ON LEAVE OF fi_dridate2 IN FRAME fr_main
DO:
    fi_dridate2 = INPUT fi_dridate2 .
    DISP fi_dridate2 WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_driid1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_driid1 C-Win
ON LEAVE OF fi_driid1 IN FRAME fr_main
DO:
    fi_driid1 = INPUT fi_driid1 .
    DISP fi_driid1 WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_driid2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_driid2 C-Win
ON LEAVE OF fi_driid2 IN FRAME fr_main
DO:
    fi_driid2 = INPUT fi_driid2 .
    DISP fi_driid2 WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_drinam1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_drinam1 C-Win
ON LEAVE OF fi_drinam1 IN FRAME fr_main
DO:
    fi_drinam1 = INPUT fi_drinam1 .
    DISP fi_drinam1 WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_drinam2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_drinam2 C-Win
ON LEAVE OF fi_drinam2 IN FRAME fr_main
DO:
    fi_drinam2 = INPUT fi_drinam2 .
    DISP fi_drinam2 WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_driocc1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_driocc1 C-Win
ON LEAVE OF fi_driocc1 IN FRAME fr_main
DO:
    fi_driocc1 = INPUT fi_driocc1 .
    DISP fi_driocc1 WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_driocc2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_driocc2 C-Win
ON LEAVE OF fi_driocc2 IN FRAME fr_main
DO:
    fi_driocc2 = INPUT fi_driocc2 .
    DISP fi_driocc2 WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_drisex1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_drisex1 C-Win
ON LEAVE OF fi_drisex1 IN FRAME fr_main
DO:
    fi_drisex1 = INPUT fi_drisex1 .
    DISP fi_drisex1 WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_drisex2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_drisex2 C-Win
ON LEAVE OF fi_drisex2 IN FRAME fr_main
DO:
    fi_drisex2 = INPUT fi_drisex2 .
    DISP fi_drisex2 WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_drisur1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_drisur1 C-Win
ON LEAVE OF fi_drisur1 IN FRAME fr_main
DO:
    fi_drisur1 = INPUT fi_drisur1 .
    DISP fi_drisur1 WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_drisur2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_drisur2 C-Win
ON LEAVE OF fi_drisur2 IN FRAME fr_main
DO:
    fi_drisur2 = INPUT fi_drisur2 .
    DISP fi_drisur2 WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_driver
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_driver C-Win
ON LEAVE OF fi_driver IN FRAME fr_main
DO:
    fi_driver = INPUT fi_driver .
    DISP fi_driver WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_icno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_icno C-Win
ON LEAVE OF fi_icno IN FRAME fr_main
DO:
    fi_icno = INPUT fi_icno .
    DISP fi_icno WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_line
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_line C-Win
ON LEAVE OF fi_line IN FRAME fr_main
DO:
    fi_line = INPUT fi_line .
    DISP fi_line WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_mail
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_mail C-Win
ON LEAVE OF fi_mail IN FRAME fr_main
DO:
    fi_mail = INPUT fi_mail .
    DISP fi_mail WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_nameeng
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_nameeng C-Win
ON LEAVE OF fi_nameeng IN FRAME fr_main
DO:
    fi_nameeng = INPUT fi_nameeng .
    DISP fi_nameeng WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_nameth
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_nameth C-Win
ON LEAVE OF fi_nameth IN FRAME fr_main
DO:
    fi_nameth = INPUT fi_nameth .
    DISP fi_nameth WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_pacg
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_pacg C-Win
ON LEAVE OF fi_pacg IN FRAME fr_main
DO:
    fi_pacg = INPUT fi_pacg .
    DISP fi_pacg WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_pacgnam
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_pacgnam C-Win
ON LEAVE OF fi_pacgnam IN FRAME fr_main
DO:
    fi_pacgnam = INPUT fi_pacgnam .
    DISP fi_pacgnam WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_paidsts
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_paidsts C-Win
ON LEAVE OF fi_paidsts IN FRAME fr_main
DO:
    fi_paidsts = INPUT fi_paidsts .
    DISP fi_paidsts WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_payaddr1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_payaddr1 C-Win
ON LEAVE OF fi_payaddr1 IN FRAME fr_main
DO:
    fi_payaddr1 = INPUT fi_payaddr1 .
    DISP fi_payaddr1 WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_payaddr2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_payaddr2 C-Win
ON LEAVE OF fi_payaddr2 IN FRAME fr_main
DO:
    fi_payaddr2 = INPUT fi_payaddr2 .
    DISP fi_payaddr2 WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_paydat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_paydat C-Win
ON LEAVE OF fi_paydat IN FRAME fr_main
DO:
    fi_paydat = INPUT fi_paydat .
    DISP fi_paydat WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_payic
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_payic C-Win
ON LEAVE OF fi_payic IN FRAME fr_main
DO:
    fi_payic = INPUT fi_payic .
    DISP fi_payic WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_payin
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_payin C-Win
ON LEAVE OF fi_payin IN FRAME fr_main
DO:
    fi_payin = INPUT fi_payin .
    DISP fi_payin WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_paymcod
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_paymcod C-Win
ON LEAVE OF fi_paymcod IN FRAME fr_main
DO:
    fi_paymcod = INPUT fi_paymcod .
    DISP fi_paymcod WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_paymtyp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_paymtyp C-Win
ON LEAVE OF fi_paymtyp IN FRAME fr_main
DO:
    fi_paymtyp = INPUT fi_paymtyp .
    DISP fi_paymtyp WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_paynam
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_paynam C-Win
ON LEAVE OF fi_paynam IN FRAME fr_main
DO:
    fi_paynam = INPUT fi_paynam .
    DISP fi_paynam WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_paysts
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_paysts C-Win
ON LEAVE OF fi_paysts IN FRAME fr_main
DO:
    fi_paysts = INPUT fi_paysts .
    DISP fi_paysts WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_paysur
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_paysur C-Win
ON LEAVE OF fi_paysur IN FRAME fr_main
DO:
    fi_paysur = INPUT fi_paysur .
    DISP fi_paysur WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_paytyp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_paytyp C-Win
ON LEAVE OF fi_paytyp IN FRAME fr_main
DO:
    fi_paytyp = INPUT fi_paytyp .
    DISP fi_paytyp WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_payway
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_payway C-Win
ON LEAVE OF fi_payway IN FRAME fr_main
DO:
    fi_payway = INPUT fi_payway .
    DISP fi_payway WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_poladdr1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_poladdr1 C-Win
ON LEAVE OF fi_poladdr1 IN FRAME fr_main
DO:
    fi_poladdr1 = INPUT fi_poladdr1 .
    DISP fi_poladdr1 WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_poladdr2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_poladdr2 C-Win
ON LEAVE OF fi_poladdr2 IN FRAME fr_main
DO:
    fi_poladdr2 = INPUT fi_poladdr2 .
    DISP fi_poladdr2 WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_polbdate
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_polbdate C-Win
ON LEAVE OF fi_polbdate IN FRAME fr_main
DO:
    fi_polbdate = INPUT fi_polbdate .
    DISP fi_polbdate WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_polno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_polno C-Win
ON LEAVE OF fi_polno IN FRAME fr_main
DO:
    fi_polno = INPUT fi_polno .
    DISP fi_polno WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_polocc
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_polocc C-Win
ON LEAVE OF fi_polocc IN FRAME fr_main
DO:
    fi_polocc = INPUT fi_polocc .
    DISP fi_polocc WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_poltel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_poltel C-Win
ON LEAVE OF fi_poltel IN FRAME fr_main
DO:
    fi_poltel = INPUT fi_poltel .
    DISP fi_poltel WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_produc
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_produc C-Win
ON LEAVE OF fi_produc IN FRAME fr_main
DO:
    fi_produc = INPUT fi_produc .
    DISP fi_produc WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_producer
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_producer C-Win
ON LEAVE OF fi_producer IN FRAME fr_main
DO:
    fi_producer = INPUT fi_producer .
    DISP fi_producer WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_producnam
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_producnam C-Win
ON LEAVE OF fi_producnam IN FRAME fr_main
DO:
    fi_producnam = INPUT fi_producnam .
    DISP fi_producnam WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_refno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_refno C-Win
ON LEAVE OF fi_refno IN FRAME fr_main
DO:
    fi_refno = INPUT fi_refno .
    DISP fi_refno WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_saledat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_saledat C-Win
ON LEAVE OF fi_saledat IN FRAME fr_main
DO:
    fi_saledat = INPUT fi_saledat .
    DISP fi_saledat WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_sellchannel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_sellchannel C-Win
ON LEAVE OF fi_sellchannel IN FRAME fr_main
DO:
    fi_sellchannel = INPUT fi_sellchannel .
    DISP fi_sellchannel WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_senaddr1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_senaddr1 C-Win
ON LEAVE OF fi_senaddr1 IN FRAME fr_main
DO:
    fi_senaddr1 = INPUT fi_senaddr1 .
    DISP fi_senaddr1 WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_senaddr2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_senaddr2 C-Win
ON LEAVE OF fi_senaddr2 IN FRAME fr_main
DO:
    fi_senaddr2 = INPUT fi_senaddr2 .
    DISP fi_senaddr2 WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_sex
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_sex C-Win
ON LEAVE OF fi_sex IN FRAME fr_main
DO:
    fi_sex = INPUT fi_sex .
    DISP fi_sex WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_sureng
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_sureng C-Win
ON LEAVE OF fi_sureng IN FRAME fr_main
DO:
    fi_sureng = INPUT fi_sureng .
    DISP fi_sureng WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_surth
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_surth C-Win
ON LEAVE OF fi_surth IN FRAME fr_main
DO:
    fi_surth = INPUT fi_surth .
    DISP fi_surth WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_waytyp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_waytyp C-Win
ON LEAVE OF fi_waytyp IN FRAME fr_main
DO:
    fi_waytyp = INPUT fi_waytyp .
    DISP fi_waytyp WITH FRAME fr_main.
  
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
  
  gv_prgid = "wgwqscb11".
  gv_prog  = "Query & Update Notify (SCBPT) ".
  RUN  WUT\WUTHEAD ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).

/*********************************************************************/ 
 /*  RUN Wut\WutwiCen ({&WINDOW-NAME}:HANDLE). */ 
  /*CURRENT-WINDOW:WINDOW-STATE = WINDOW-MAXIMIZED.*/
  SESSION:DATA-ENTRY-RETURN = YES.
  
 /* Rect-336:Move-to-top().*/
/*  Rect-337:Move-to-top().
  
  /*Hide    fi_difprm  in frame  {&FRAME-NAME}.*/*/
  
  Find  brstat.tlt  Where   Recid(tlt)  =  nv_recidtlt NO-LOCK NO-ERROR NO-WAIT .
  If  avail  tlt  Then do:
      RUN Proc_assignfi.
      RUN proc_assignfi2.

      DISP 
      fi_polno   fi_poltyp   fi_trandat  fi_time     fi_user     fi_agent        fi_producer      fi_refno       fi_custcode
      fi_comcod  fi_comnam   fi_camp     fi_campnam  fi_produc   fi_producnam    fi_pacg          fi_pacgnam     fi_custtyp
      fi_custdes fi_nameth   fi_surth    fi_nameeng  fi_sureng   fi_icno         fi_sex           fi_polbdate    fi_polocc
      fi_poltel  fi_mail     fi_line     fi_poladdr1 fi_poladdr2 fi_senaddr1     fi_senaddr2      fi_driver      fi_drinam1
      fi_drisur1 fi_driid1   fi_drisex1  fi_driocc1  fi_dridate1 fi_drinam2      fi_drisur2       fi_driid2      fi_drisex2
      fi_driocc2 fi_dridate2 fi_paytyp   fi_branch   fi_paynam   fi_paysur       fi_payic         fi_payaddr1    fi_payaddr2
      fi_bennam  fi_paymcod  fi_paymtyp  fi_payway   fi_waytyp   fi_bank         fi_paydat        fi_paysts      fi_paidsts
      fi_saledat fi_payin    bu_detail1  bu_detail2  bU_save     bu_exit         fi_bennam2       fi_bennam3     fi_agentcode
      fi_agentth fi_agenten  fi_sellchannel  WITH FRAME fr_main.
    bu_detail1:BGCOLOR = 19.
    bu_detail1:FGCOLOR = 6. 
    DISABLE bu_detail1 WITH FRAME fr_main.


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
  DISPLAY fi_custdes fi_comcod fi_comnam fi_camp fi_campnam fi_produc 
          fi_producnam fi_pacg fi_pacgnam fi_custtyp fi_nameth fi_surth 
          fi_nameeng fi_sureng fi_icno fi_sex fi_polbdate fi_polocc fi_poltel 
          fi_mail fi_line fi_poladdr1 fi_poladdr2 fi_senaddr1 fi_senaddr2 
          fi_paytyp fi_branch fi_paynam fi_paysur fi_payic fi_payaddr1 
          fi_payaddr2 fi_bennam fi_paymcod fi_paymtyp fi_payway fi_waytyp 
          fi_bank fi_paydat fi_paidsts fi_saledat fi_payin fi_refno fi_custcode 
          fi_polno fi_poltyp fi_driver fi_drinam1 fi_drisur1 fi_driid1 
          fi_drisex1 fi_driocc1 fi_dridate1 fi_drinam2 fi_drisur2 fi_driid2 
          fi_drisex2 fi_driocc2 fi_dridate2 fi_producer fi_agent fi_trandat 
          fi_user fi_time fi_paysts fi_bennam2 fi_bennam3 fi_agentcode 
          fi_agentth fi_agenten fi_sellchannel 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE bu_detail2 bu_save bu_exit bu_detail1 fi_comcod fi_comnam fi_camp 
         fi_campnam fi_produc fi_producnam fi_pacg fi_pacgnam fi_custtyp 
         fi_nameth fi_surth fi_nameeng fi_sureng fi_icno fi_sex fi_polbdate 
         fi_polocc fi_poltel fi_mail fi_line fi_poladdr1 fi_poladdr2 
         fi_senaddr1 fi_senaddr2 fi_paytyp fi_branch fi_paynam fi_paysur 
         fi_payic fi_payaddr1 fi_payaddr2 fi_bennam fi_paymcod fi_paymtyp 
         fi_payway fi_waytyp fi_bank fi_paydat fi_paidsts fi_saledat fi_payin 
         fi_refno fi_custcode fi_polno fi_poltyp fi_driver fi_drinam1 
         fi_drisur1 fi_driid1 fi_drisex1 fi_driocc1 fi_dridate1 fi_drinam2 
         fi_drisur2 fi_driid2 fi_drisex2 fi_driocc2 fi_dridate2 fi_producer 
         fi_agent fi_trandat fi_user fi_time fi_paysts fi_bennam2 fi_bennam3 
         fi_agentcode fi_agentth fi_agenten fi_sellchannel RECT-462 RECT-464 
         RECT-465 
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
    DEF VAR n_leng AS INT INIT 0.
    DEF VAR n_char AS CHAR FORMAT "x(250)" INIT "" .
    DEF VAR n_bdate AS CHAR INIT "".
    ASSIGN 
        fi_polno     = brstat.tlt.policy
        fi_poltyp    = brstat.tlt.flag
        fi_trandat   = brstat.tlt.entdat
        fi_time      = brstat.tlt.enttim
        fi_user      = brstat.tlt.usrid
        fi_agent     = brstat.tlt.recac
        fi_producer  = brstat.tlt.subins
        fi_refno     = brstat.tlt.nor_noti_ins
        fi_custcode  = brstat.tlt.nor_usr_ins
        /*- campaign product packge ----*/
        fi_campnam   = trim(substr(brstat.tlt.lotno,R-INDEX(tlt.lotno,"CamName:") + 8 ))     /*ชื่อแคมเปญ*/
        n_char       = trim(SUBSTR(brstat.tlt.lotno,1,R-INDEX(tlt.lotno,"CamName:") - 2 ))
        fi_camp      = trim(substr(n_char,R-INDEX(n_char,"CamCode:") + 8))                   /*รหัสแคมเปญ*/
        n_char       = trim(SUBSTR(n_char,1,R-INDEX(n_char,"CamCode:") - 2))
        fi_comnam    = trim(substr(n_char,R-INDEX(n_char,"insname:") + 8))                   /*ชื่อบริษัท */
        n_char       = trim(SUBSTR(n_char,1,R-INDEX(n_char,"insname:") - 2))
        fi_comcod    = trim(substr(n_char,R-INDEX(n_char,"InsCode:") + 8))                   /*รหัสบริษัท*/
        fi_pacg      = TRIM(SUBSTR(brstat.tlt.usrsent,R-INDEX(brstat.tlt.usrsent,"packcod:") + 8))   /*รหัสแพคเกจ    */ 
        n_char       = TRIM(SUBSTR(brstat.tlt.usrsent,1,R-INDEX(tlt.usrsent,"packcod:") - 2))
        fi_pacgnam   = trim(substr(n_char,R-INDEX(n_char,"packnam:") + 8))    /*ชื่อแพคเกจ    */ 
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"packnam:") - 2))
        fi_producnam = trim(substr(n_char,R-INDEX(n_char,"proname:") + 8))    /*ชื่อผลิตภัณฑ์ */ 
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"proname:") - 2))
        fi_produc    = trim(substr(n_char,R-INDEX(n_char,"procode:") + 8))     /*รหัสผลิตภัณฑ์ */ 
        fi_custtyp   = trim(brstat.tlt.imp)                                    /*ประเภท        */ 
        fi_custdes   = IF trim(brstat.tlt.imp) <> "P" THEN "นิติบุคคล" ELSE "บุลคลธรรมดา"
        /*-- ชื่อสกุลลูกค้า ---*/
        n_char       = trim(SUBSTR(brstat.tlt.ins_name,R-INDEX(tlt.ins_name,"nameeng:") + 8 ))
        fi_sureng    = IF n_char <> " " AND TRIM(brstat.tlt.imp) = "P" then trim(SUBSTR(n_char,R-INDEX(n_char," ")))  else ""
        fi_nameeng   = IF n_char <> " " then trim(SUBSTR(n_char,1,R-INDEX(n_char," "))) else "" 
        n_char       = trim(SUBSTR(tlt.ins_name,1,R-INDEX(tlt.ins_name,"nameeng:") - 2))
        fi_surth     = IF trim(n_char) <> "NameTha:" AND TRIM(brstat.tlt.imp) = "P" THEN trim(SUBSTR(n_char,R-INDEX(n_char," ")))  ELSE ""
        n_char       = SUBSTR(n_char,1,LENGTH(n_char) - LENGTH(fi_surth))
        fi_nameth    = IF trim(n_char) <> "NameTha:" THEN trim(SUBSTR(n_char,R-INDEX(n_char,"Nametha:") + 8)) ELSE "" 
        /*-- เลขบัตร วันเกิด เพศ อาขีพ --*/
        fi_polocc    = trim(SUBSTR(brstat.tlt.rec_addr5,R-INDEX(tlt.rec_addr5,"occup:") + 6 ))
        n_char       = TRIM(SUBSTR(brstat.tlt.rec_addr5,1,R-INDEX(tlt.rec_addr5,"Occup:") - 2 ))
        n_bdate      = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Birth:") + 6 ))
        fi_polbdate  = DATE(n_bdate)
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Birth:") - 2 ))
        fi_sex       = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Sex:") + 4 ))
        fi_icno      = TRIM(SUBSTR(n_char,6,R-INDEX(n_char,"Sex:") - 6 )) 
        /*-- เบอร์โทร เมล์ ไลน์ ---*/
        fi_line     = trim(SUBSTR(brstat.tlt.ins_addr5,R-INDEX(brstat.tlt.ins_addr5,"Linid:") + 6 ))
        n_char      = TRIM(SUBSTR(brstat.tlt.ins_addr5,1,R-INDEX(brstat.tlt.ins_addr5,"Linid:") - 2 ))
        fi_mail     = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Email:") + 6 ))
        fi_poltel   = TRIM(SUBSTR(n_char,7,R-INDEX(n_char,"Email:") - 7 )) 
        fi_poladdr1 = trim(brstat.tlt.ins_addr1)
        fi_poladdr2 = trim(brstat.tlt.ins_addr2)
        fi_senaddr1 = trim(brstat.tlt.ins_addr3)
        fi_senaddr2 = trim(brstat.tlt.ins_addr4).
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assignfi2 C-Win 
PROCEDURE proc_assignfi2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO:
    DEF VAR n_leng AS INT INIT 0.
    DEF VAR n_char AS CHAR FORMAT "x(250)" INIT "" .
    DEF VAR n_bdate AS CHAR INIT "".
    ASSIGN 
        /*--ผู้ขับขี่ ---*/
        fi_driver   = brstat.tlt.endcnt 
        fi_driid1   = TRIM(substr(brstat.tlt.dri_name1,R-INDEX(brstat.tlt.dri_name1,"DriID1:") + 7 ))
        n_char      = TRIM(SUBSTR(brstat.tlt.dri_name1,1,R-INDEX(brstat.tlt.dri_name1,"DriID1:") - 2 ))
        fi_drisur1  = IF TRIM(n_char) <> "Drinam1:" THEN trim(SUBSTR(n_char,R-INDEX(n_char," "))) ELSE ""
        n_char      = IF TRIM(n_char) <> "Drinam1:" THEN trim(SUBSTR(n_char,1,R-INDEX(n_char," "))) ELSE n_char
        fi_drinam1  = IF TRIM(n_char) <> "Drinam1:" THEN trim(SUBSTR(n_char,R-INDEX(n_char,"Drinam1:") + 8)) ELSE "" 
        n_bdate     = TRIM(SUBSTR(brstat.tlt.dri_no1,R-INDEX(brstat.tlt.dri_no1,"Dribir1:") + 8 ))
        fi_dridate1 = DATE(n_bdate)
        n_char      = TRIM(SUBSTR(brstat.tlt.dri_no1,1,R-INDEX(brstat.tlt.dri_no1,"Dribir1:") - 2))
        fi_drisex1  = TRIM(SUBSTR(n_char,R-INDEX(n_char,"drisex1:") + 8 ))
        n_char      = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"drisex1:") - 2))
        fi_driocc1  = TRIM(SUBSTR(n_char,R-INDEX(n_char,"DriOcc1:") + 8))
        fi_driid2   = TRIM(substr(brstat.tlt.dri_name2,R-INDEX(brstat.tlt.dri_name2,"DriID2:") + 7 ))     
        n_char      = TRIM(SUBSTR(brstat.tlt.dri_name2,1,R-INDEX(brstat.tlt.dri_name2,"DriID2:") - 2 ))   
        fi_drisur2  = IF TRIM(n_char) <> "Drinam2:" THEN trim(SUBSTR(n_char,R-INDEX(n_char," "))) ELSE ""        
        n_char      = IF TRIM(n_char) <> "Drinam2:" THEN trim(SUBSTR(n_char,1,R-INDEX(n_char," "))) ELSE n_char 
        fi_drinam2  = IF TRIM(n_char) <> "Drinam2:" THEN trim(SUBSTR(n_char,9,R-INDEX(n_char,"Drinam2:") + 8)) ELSE ""  
        n_bdate     = TRIM(SUBSTR(brstat.tlt.dri_no2,R-INDEX(brstat.tlt.dri_no2,"Dribir2:") + 8))
        fi_dridate2 = DATE(n_bdate)
        n_char      = TRIM(SUBSTR(brstat.tlt.dri_no2,1,R-INDEX(brstat.tlt.dri_no2,"Dribir2:") - 2))
        fi_drisex2  = TRIM(SUBSTR(n_char,R-INDEX(n_char,"drisex2:") + 8 ))
        n_char      = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"drisex2:") - 2 ))
        fi_driocc2  = TRIM(SUBSTR(n_char,R-INDEX(n_char,"DriOcc2:") + 8 ))
        /*--การชำระเงิน --*/
        fi_paytyp   = trim(substr(brstat.tlt.EXP,index(brstat.tlt.EXP,"Paytyp:") + 7,R-INDEX(brstat.tlt.EXP,"Branch:") - 9)) 
        fi_branch   = TRIM(SUBSTR(brstat.tlt.EXP,R-INDEX(brstat.tlt.EXP,"Branch:") + 7 ))
        fi_paysur   = TRIM(substr(brstat.tlt.rec_name,R-INDEX(brstat.tlt.rec_name," ")))
        fi_paynam   = trim(substr(brstat.tlt.rec_name,1,LENGTH(brstat.tlt.rec_name) - LENGTH(fi_paysur)))
        fi_payic    = trim(brstat.tlt.comp_sub)
        fi_payaddr1 = trim(brstat.tlt.rec_addr1)
        fi_payaddr2 = trim(brstat.tlt.rec_addr2)
        fi_bennam   = trim(brstat.tlt.safe1) 
        fi_waytyp   = trim(substr(brstat.tlt.safe2,R-INDEX(brstat.tlt.safe2,"Paymentty:") + 10 ))
        n_char      = TRIM(SUBSTR(brstat.tlt.safe2,1,R-INDEX(brstat.tlt.safe2,"Paymentty:") - 2 ))
        fi_payway   = TRIM(SUBSTR(n_char,R-INDEX(n_char,"PaymentTyCd:") + 12 ))
        n_char      = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"PaymentTyCd:") - 2 ))
        fi_paymtyp  = TRIM(SUBSTR(n_char,R-INDEX(n_char,"PaymentMDTy:") + 12 ))
        n_char      = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"PaymentMDTy:") - 2 ))
        fi_paymcod  = TRIM(SUBSTR(n_char,R-INDEX(n_char,"PaymentMD:") + 10 ))
        fi_bank     = TRIM(brstat.tlt.safe3) 
        fi_paidsts  = TRIM(SUBSTR(brstat.tlt.rec_addr4,R-INDEX(brstat.tlt.rec_addr4,"Paid:") + 5 ))
        n_char      = TRIM(SUBSTR(brstat.tlt.rec_addr4,1,R-INDEX(brstat.tlt.rec_addr4,"Paid:") - 2 ))
        fi_paysts   = TRIM(SUBSTR(n_char,R-INDEX(n_char,"paysts:") + 7 ))
        n_char      = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"paysts:") - 2 ))
        n_bdate     = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Paydat:") + 7 ))
        fi_paydat   = DATE(n_bdate)
        fi_saledat  = brstat.tlt.datesent
        fi_payin    = brstat.tlt.dat_ins_noti 
        fi_bennam2     = brstat.tlt.ben83  /*Kridtiya i. A64-0295 DATE. 25/07/2021*/ 
        fi_bennam3     = brstat.tlt.note4  /*Kridtiya i. A64-0295 DATE. 25/07/2021*/  
        fi_agentcode   = brstat.tlt.agent  /*Kridtiya i. A64-0295 DATE. 25/07/2021*/ 
        fi_agentth     = brstat.tlt.note1  /*Kridtiya i. A64-0295 DATE. 25/07/2021*/ 
        fi_agenten     = brstat.tlt.note2  /*Kridtiya i. A64-0295 DATE. 25/07/2021*/ 
        fi_sellchannel = brstat.tlt.note3  /*Kridtiya i. A64-0295 DATE. 25/07/2021*/ .

END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

