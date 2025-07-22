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
/* modify by : Ranu I. A65-0115 เพิ่มช่อง Dealer code สาขา TMSTH  */
/*Modify by   : Ranu I. A67-0162 เพิ่มการเก็บข้อมูลรถไฟฟ้า    */
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
&Scoped-Define ENABLED-OBJECTS fi_engtyp bu_detail2 bu_save bu_exit ~
bu_detail1 fi_comcod fi_camp fi_campnam fi_producnam fi_nameth fi_surth ~
fi_icno fi_sex fi_polbdate fi_poltel fi_senaddr1 fi_senaddr2 fi_paynam ~
fi_paysur fi_payic fi_payaddr1 fi_payaddr2 fi_bennam fi_paymtyp fi_waytyp ~
fi_saledat fi_refno fi_custcode fi_polno fi_poltyp fi_driver fi_drinam1 ~
fi_drisur1 fi_driid1 fi_dridate1 fi_drinam2 fi_drisur2 fi_driid2 ~
fi_dridate2 fi_producer fi_agent fi_trandat fi_user fi_time fi_oldpol ~
fi_notdat fi_userup fi_contract fi_bray fi_produc fi_payin fi_dealer ~
fi_brtms fi_drilicen1 fi_licenexp1 fi_drilicen2 fi_licenexp2 fi_drinam3 ~
fi_drisur3 fi_driid3 fi_drisex3 fi_driocc3 fi_dridate3 fi_drilicen3 ~
fi_licenexp3 fi_drinam4 fi_drisur4 fi_driid4 fi_drisex4 fi_driocc4 ~
fi_dridate4 fi_drilicen4 fi_licenexp4 fi_drinam5 fi_drisur5 fi_driid5 ~
fi_drisex5 fi_driocc5 fi_dridate5 fi_drilicen5 fi_licenexp5 fi_mctyp ~
fi_drisex1 fi_driocc1 fi_drisex2 fi_driocc2 RECT-462 RECT-464 RECT-465 ~
RECT-502 
&Scoped-Define DISPLAYED-OBJECTS fi_engtyp fi_comcod fi_camp fi_campnam ~
fi_producnam fi_nameth fi_surth fi_icno fi_sex fi_polbdate fi_poltel ~
fi_senaddr1 fi_senaddr2 fi_paynam fi_paysur fi_payic fi_payaddr1 ~
fi_payaddr2 fi_bennam fi_paymtyp fi_waytyp fi_saledat fi_refno fi_custcode ~
fi_polno fi_poltyp fi_driver fi_drinam1 fi_drisur1 fi_driid1 fi_dridate1 ~
fi_drinam2 fi_drisur2 fi_driid2 fi_dridate2 fi_producer fi_agent fi_trandat ~
fi_user fi_time fi_oldpol fi_notdat fi_userup fi_contract fi_bray fi_produc ~
fi_payin fi_dealer fi_brtms fi_drilicen1 fi_licenexp1 fi_drilicen2 ~
fi_licenexp2 fi_drinam3 fi_drisur3 fi_driid3 fi_drisex3 fi_driocc3 ~
fi_dridate3 fi_drilicen3 fi_licenexp3 fi_drinam4 fi_drisur4 fi_driid4 ~
fi_drisex4 fi_driocc4 fi_dridate4 fi_drilicen4 fi_licenexp4 fi_drinam5 ~
fi_drisur5 fi_driid5 fi_drisex5 fi_driocc5 fi_dridate5 fi_drilicen5 ~
fi_licenexp5 fi_mctyp fi_drisex1 fi_driocc1 fi_drisex2 fi_driocc2 

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
     SIZE 27.17 BY 1.52
     BGCOLOR 7 FGCOLOR 2 FONT 6.

DEFINE BUTTON bu_detail2 
     LABEL "ข้อมูลรถและความคุ้มครอง" 
     SIZE 28 BY 1.52
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
     SIZE 17.5 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_bennam AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 34.67 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_bray AS CHARACTER FORMAT "X(3)":U 
     VIEW-AS FILL-IN 
     SIZE 5.5 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_brtms AS CHARACTER FORMAT "X(3)":U 
     VIEW-AS FILL-IN 
     SIZE 5.5 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_camp AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 15.5 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_campnam AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 23.33 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_comcod AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 6.83 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_contract AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 11.67 BY 1
     BGCOLOR 15 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_custcode AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 16.17 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_dealer AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 14.67 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_dridate1 AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 12.83 BY .91
     BGCOLOR 15 FGCOLOR 0 FONT 0 NO-UNDO.

DEFINE VARIABLE fi_dridate2 AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 12.83 BY .91
     BGCOLOR 15 FGCOLOR 0 FONT 0 NO-UNDO.

DEFINE VARIABLE fi_dridate3 AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 12.83 BY .91
     BGCOLOR 15 FGCOLOR 0 FONT 0 NO-UNDO.

DEFINE VARIABLE fi_dridate4 AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 12.83 BY .91
     BGCOLOR 15 FGCOLOR 0 FONT 0 NO-UNDO.

DEFINE VARIABLE fi_dridate5 AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 12.83 BY .91
     BGCOLOR 15 FGCOLOR 0 FONT 0 NO-UNDO.

DEFINE VARIABLE fi_driid1 AS CHARACTER FORMAT "X(13)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_driid2 AS CHARACTER FORMAT "X(13)":U 
     VIEW-AS FILL-IN 
     SIZE 15.17 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_driid3 AS CHARACTER FORMAT "X(13)":U 
     VIEW-AS FILL-IN 
     SIZE 15.33 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_driid4 AS CHARACTER FORMAT "X(13)":U 
     VIEW-AS FILL-IN 
     SIZE 15.33 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_driid5 AS CHARACTER FORMAT "X(13)":U 
     VIEW-AS FILL-IN 
     SIZE 15.17 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_drilicen1 AS CHARACTER FORMAT "X(13)":U 
     VIEW-AS FILL-IN 
     SIZE 15.33 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_drilicen2 AS CHARACTER FORMAT "X(13)":U 
     VIEW-AS FILL-IN 
     SIZE 15.33 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_drilicen3 AS CHARACTER FORMAT "X(13)":U 
     VIEW-AS FILL-IN 
     SIZE 15.33 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_drilicen4 AS CHARACTER FORMAT "X(13)":U 
     VIEW-AS FILL-IN 
     SIZE 15.33 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_drilicen5 AS CHARACTER FORMAT "X(13)":U 
     VIEW-AS FILL-IN 
     SIZE 15.33 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_drinam1 AS CHARACTER FORMAT "X(60)":U 
     VIEW-AS FILL-IN 
     SIZE 22.17 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_drinam2 AS CHARACTER FORMAT "X(60)":U 
     VIEW-AS FILL-IN 
     SIZE 22.17 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_drinam3 AS CHARACTER FORMAT "X(60)":U 
     VIEW-AS FILL-IN 
     SIZE 22.33 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_drinam4 AS CHARACTER FORMAT "X(60)":U 
     VIEW-AS FILL-IN 
     SIZE 22.33 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_drinam5 AS CHARACTER FORMAT "X(60)":U 
     VIEW-AS FILL-IN 
     SIZE 22.17 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_driocc1 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 15.33 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_driocc2 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 15.33 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_driocc3 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 15.33 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_driocc4 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 15.33 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_driocc5 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 15.33 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_drisex1 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 8.5 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_drisex2 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 8.5 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_drisex3 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 8.5 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_drisex4 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 8.5 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_drisex5 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 8.5 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_drisur1 AS CHARACTER FORMAT "X(60)":U 
     VIEW-AS FILL-IN 
     SIZE 20.17 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_drisur2 AS CHARACTER FORMAT "X(60)":U 
     VIEW-AS FILL-IN 
     SIZE 20.17 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_drisur3 AS CHARACTER FORMAT "X(60)":U 
     VIEW-AS FILL-IN 
     SIZE 20.33 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_drisur4 AS CHARACTER FORMAT "X(60)":U 
     VIEW-AS FILL-IN 
     SIZE 20.33 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_drisur5 AS CHARACTER FORMAT "X(60)":U 
     VIEW-AS FILL-IN 
     SIZE 20.17 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_driver AS INTEGER FORMAT ">9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 6 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_engtyp AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 30 BY .91
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_icno AS CHARACTER FORMAT "X(13)":U 
     VIEW-AS FILL-IN 
     SIZE 16.33 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_licenexp1 AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 13.5 BY .91
     BGCOLOR 15 FGCOLOR 0 FONT 0 NO-UNDO.

DEFINE VARIABLE fi_licenexp2 AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 13.5 BY .91
     BGCOLOR 15 FGCOLOR 0 FONT 0 NO-UNDO.

DEFINE VARIABLE fi_licenexp3 AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 13.33 BY .91
     BGCOLOR 15 FGCOLOR 0 FONT 0 NO-UNDO.

DEFINE VARIABLE fi_licenexp4 AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 13.33 BY .91
     BGCOLOR 15 FGCOLOR 0 FONT 0 NO-UNDO.

DEFINE VARIABLE fi_licenexp5 AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 13.5 BY .91
     BGCOLOR 15 FGCOLOR 0 FONT 0 NO-UNDO.

DEFINE VARIABLE fi_mctyp AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 21.67 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_nameth AS CHARACTER FORMAT "X(60)":U 
     VIEW-AS FILL-IN 
     SIZE 31.17 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_notdat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 13.67 BY 1
     BGCOLOR 19 FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE fi_oldpol AS CHARACTER FORMAT "X(13)":U 
     VIEW-AS FILL-IN 
     SIZE 16.5 BY 1
     BGCOLOR 15 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_payaddr1 AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 49.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_payaddr2 AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 51.83 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_payic AS CHARACTER FORMAT "X(13)":U 
     VIEW-AS FILL-IN 
     SIZE 17.67 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_payin AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 13.67 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_paymtyp AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 24.33 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_paynam AS CHARACTER FORMAT "X(60)":U 
     VIEW-AS FILL-IN 
     SIZE 31.33 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_paysur AS CHARACTER FORMAT "X(60)":U 
     VIEW-AS FILL-IN 
     SIZE 30.67 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_polbdate AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 13.83 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_polno AS CHARACTER FORMAT "X(13)":U 
     VIEW-AS FILL-IN 
     SIZE 16.67 BY 1
     BGCOLOR 15 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_poltel AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 17.17 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_poltyp AS CHARACTER FORMAT "X(3)":U 
     VIEW-AS FILL-IN 
     SIZE 5.5 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_produc AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 31.67 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_producer AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 14.67 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_producnam AS CHARACTER FORMAT "X(60)":U 
     VIEW-AS FILL-IN 
     SIZE 32.33 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_refno AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 18.83 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_saledat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 13.67 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_senaddr1 AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 55.67 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_senaddr2 AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 50.33 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_sex AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 9 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_surth AS CHARACTER FORMAT "X(60)":U 
     VIEW-AS FILL-IN 
     SIZE 27.17 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_time AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 9.5 BY 1
     BGCOLOR 8 FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE fi_trandat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 13.67 BY 1
     BGCOLOR 8 FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE fi_user AS CHARACTER FORMAT "X(13)":U 
     VIEW-AS FILL-IN 
     SIZE 10.17 BY 1
     BGCOLOR 8 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_userup AS CHARACTER FORMAT "X(13)":U 
     VIEW-AS FILL-IN 
     SIZE 10.17 BY 1
     BGCOLOR 19 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_waytyp AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 27.17 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE RECTANGLE RECT-462
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132.5 BY 22.76
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-464
     EDGE-PIXELS 2 GRAPHIC-EDGE    ROUNDED 
     SIZE 130.5 BY 5.19
     BGCOLOR 19 FGCOLOR 12 .

DEFINE RECTANGLE RECT-465
     EDGE-PIXELS 2 GRAPHIC-EDGE    ROUNDED 
     SIZE 130.5 BY 13.81
     BGCOLOR 19 FGCOLOR 12 .

DEFINE RECTANGLE RECT-502
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 23 BY 1.43
     BGCOLOR 21 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     fi_engtyp AT ROW 6.14 COL 61 COLON-ALIGNED NO-LABEL WIDGET-ID 108
     bu_detail2 AT ROW 1.1 COL 29.17
     bu_save AT ROW 25.52 COL 112.5
     bu_exit AT ROW 25.52 COL 123.33
     bu_detail1 AT ROW 1.14 COL 1.83
     fi_comcod AT ROW 7.24 COL 12.5 COLON-ALIGNED NO-LABEL
     fi_camp AT ROW 7.24 COL 32 COLON-ALIGNED NO-LABEL
     fi_campnam AT ROW 7.24 COL 60.67 COLON-ALIGNED NO-LABEL
     fi_producnam AT ROW 7.24 COL 96.5 COLON-ALIGNED NO-LABEL
     fi_nameth AT ROW 8.24 COL 52.33 COLON-ALIGNED NO-LABEL
     fi_surth AT ROW 8.24 COL 95.83 COLON-ALIGNED NO-LABEL
     fi_icno AT ROW 9.19 COL 12.5 COLON-ALIGNED NO-LABEL
     fi_sex AT ROW 9.24 COL 34.17 COLON-ALIGNED NO-LABEL
     fi_polbdate AT ROW 9.24 COL 55.83 COLON-ALIGNED NO-LABEL
     fi_poltel AT ROW 9.24 COL 79.33 COLON-ALIGNED NO-LABEL
     fi_senaddr1 AT ROW 10.19 COL 12.33 COLON-ALIGNED NO-LABEL
     fi_senaddr2 AT ROW 10.24 COL 79 COLON-ALIGNED NO-LABEL
     fi_paynam AT ROW 19.71 COL 15.5 COLON-ALIGNED NO-LABEL
     fi_paysur AT ROW 19.71 COL 55.67 COLON-ALIGNED NO-LABEL
     fi_payic AT ROW 19.71 COL 98.67 COLON-ALIGNED NO-LABEL
     fi_payaddr1 AT ROW 20.81 COL 15.5 COLON-ALIGNED NO-LABEL
     fi_payaddr2 AT ROW 20.81 COL 78 COLON-ALIGNED NO-LABEL
     fi_bennam AT ROW 21.91 COL 15.33 COLON-ALIGNED NO-LABEL
     fi_paymtyp AT ROW 21.91 COL 64.17 COLON-ALIGNED NO-LABEL
     fi_waytyp AT ROW 21.91 COL 102.5 COLON-ALIGNED NO-LABEL
     fi_saledat AT ROW 23.05 COL 15.5 COLON-ALIGNED NO-LABEL
     fi_refno AT ROW 5.14 COL 66.67 COLON-ALIGNED NO-LABEL
     fi_custcode AT ROW 5.05 COL 95.83 COLON-ALIGNED NO-LABEL
     fi_polno AT ROW 3.14 COL 88.67 COLON-ALIGNED NO-LABEL
     fi_poltyp AT ROW 3.14 COL 72 COLON-ALIGNED NO-LABEL
     fi_driver AT ROW 9.24 COL 108.17 COLON-ALIGNED NO-LABEL
     fi_drinam1 AT ROW 12.19 COL 3.17 COLON-ALIGNED NO-LABEL
     fi_drisur1 AT ROW 12.19 COL 25.83 COLON-ALIGNED NO-LABEL
     fi_driid1 AT ROW 12.19 COL 46.67 COLON-ALIGNED NO-LABEL
     fi_dridate1 AT ROW 12.19 COL 102.67 COLON-ALIGNED NO-LABEL
     fi_drinam2 AT ROW 13.24 COL 3.17 COLON-ALIGNED NO-LABEL
     fi_drisur2 AT ROW 13.24 COL 25.83 COLON-ALIGNED NO-LABEL
     fi_driid2 AT ROW 13.24 COL 46.67 COLON-ALIGNED NO-LABEL
     fi_dridate2 AT ROW 13.29 COL 102.67 COLON-ALIGNED NO-LABEL
     fi_producer AT ROW 5.24 COL 12.67 COLON-ALIGNED NO-LABEL
     fi_agent AT ROW 5.19 COL 37.17 COLON-ALIGNED NO-LABEL
     fi_trandat AT ROW 25.52 COL 13.17 COLON-ALIGNED NO-LABEL
     fi_user AT ROW 25.52 COL 47.83 COLON-ALIGNED NO-LABEL
     fi_time AT ROW 25.52 COL 32.33 COLON-ALIGNED NO-LABEL
     fi_oldpol AT ROW 3.14 COL 55.33 COLON-ALIGNED NO-LABEL WIDGET-ID 2
     fi_notdat AT ROW 3.14 COL 116.83 COLON-ALIGNED NO-LABEL WIDGET-ID 6
     fi_userup AT ROW 25.52 COL 81 COLON-ALIGNED NO-LABEL WIDGET-ID 10
     fi_contract AT ROW 3.14 COL 32.83 COLON-ALIGNED NO-LABEL WIDGET-ID 14
     fi_bray AT ROW 5.14 COL 122.17 COLON-ALIGNED NO-LABEL WIDGET-ID 18
     fi_produc AT ROW 8.24 COL 12.5 COLON-ALIGNED NO-LABEL WIDGET-ID 24
     fi_payin AT ROW 23.05 COL 44.67 COLON-ALIGNED NO-LABEL WIDGET-ID 28
     fi_dealer AT ROW 6.19 COL 12.67 COLON-ALIGNED NO-LABEL WIDGET-ID 32
     fi_brtms AT ROW 6.19 COL 42.5 COLON-ALIGNED NO-LABEL WIDGET-ID 36
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1.17 ROW 1.05
         SIZE 133.67 BY 25.95
         BGCOLOR 31 FGCOLOR 2 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     fi_drilicen1 AT ROW 12.19 COL 62.33 COLON-ALIGNED NO-LABEL WIDGET-ID 40
     fi_licenexp1 AT ROW 12.19 COL 115.83 COLON-ALIGNED NO-LABEL WIDGET-ID 44
     fi_drilicen2 AT ROW 13.29 COL 62.33 COLON-ALIGNED NO-LABEL WIDGET-ID 50
     fi_licenexp2 AT ROW 13.29 COL 115.83 COLON-ALIGNED NO-LABEL WIDGET-ID 52
     fi_drinam3 AT ROW 14.33 COL 3 COLON-ALIGNED NO-LABEL WIDGET-ID 60
     fi_drisur3 AT ROW 14.33 COL 25.67 COLON-ALIGNED NO-LABEL WIDGET-ID 66
     fi_driid3 AT ROW 14.33 COL 46.5 COLON-ALIGNED NO-LABEL WIDGET-ID 56
     fi_drisex3 AT ROW 14.38 COL 93.67 COLON-ALIGNED NO-LABEL WIDGET-ID 64
     fi_driocc3 AT ROW 14.38 COL 78 COLON-ALIGNED NO-LABEL WIDGET-ID 62
     fi_dridate3 AT ROW 14.38 COL 102.67 COLON-ALIGNED NO-LABEL WIDGET-ID 54
     fi_drilicen3 AT ROW 14.38 COL 62.17 COLON-ALIGNED NO-LABEL WIDGET-ID 58
     fi_licenexp3 AT ROW 14.38 COL 115.83 COLON-ALIGNED NO-LABEL WIDGET-ID 68
     fi_drinam4 AT ROW 15.43 COL 3 COLON-ALIGNED NO-LABEL WIDGET-ID 78
     fi_drisur4 AT ROW 15.43 COL 25.67 COLON-ALIGNED NO-LABEL WIDGET-ID 84
     fi_driid4 AT ROW 15.43 COL 46.5 COLON-ALIGNED NO-LABEL WIDGET-ID 74
     fi_drisex4 AT ROW 15.48 COL 93.67 COLON-ALIGNED NO-LABEL WIDGET-ID 82
     fi_driocc4 AT ROW 15.48 COL 78 COLON-ALIGNED NO-LABEL WIDGET-ID 80
     fi_dridate4 AT ROW 15.48 COL 102.67 COLON-ALIGNED NO-LABEL WIDGET-ID 72
     fi_drilicen4 AT ROW 15.48 COL 62.17 COLON-ALIGNED NO-LABEL WIDGET-ID 76
     fi_licenexp4 AT ROW 15.48 COL 115.83 COLON-ALIGNED NO-LABEL WIDGET-ID 86
     fi_drinam5 AT ROW 16.52 COL 3.17 COLON-ALIGNED NO-LABEL WIDGET-ID 96
     fi_drisur5 AT ROW 16.52 COL 25.83 COLON-ALIGNED NO-LABEL WIDGET-ID 102
     fi_driid5 AT ROW 16.52 COL 46.67 COLON-ALIGNED NO-LABEL WIDGET-ID 92
     fi_drisex5 AT ROW 16.57 COL 93.83 COLON-ALIGNED NO-LABEL WIDGET-ID 100
     fi_driocc5 AT ROW 16.57 COL 78.17 COLON-ALIGNED NO-LABEL WIDGET-ID 98
     fi_dridate5 AT ROW 16.57 COL 102.67 COLON-ALIGNED NO-LABEL WIDGET-ID 90
     fi_drilicen5 AT ROW 16.57 COL 62.33 COLON-ALIGNED NO-LABEL WIDGET-ID 94
     fi_licenexp5 AT ROW 16.57 COL 115.83 COLON-ALIGNED NO-LABEL WIDGET-ID 104
     fi_mctyp AT ROW 6.19 COL 106 COLON-ALIGNED NO-LABEL WIDGET-ID 110
     fi_drisex1 AT ROW 12.19 COL 93.67 COLON-ALIGNED NO-LABEL WIDGET-ID 118
     fi_driocc1 AT ROW 12.19 COL 78 COLON-ALIGNED NO-LABEL WIDGET-ID 116
     fi_drisex2 AT ROW 13.29 COL 93.67 COLON-ALIGNED NO-LABEL WIDGET-ID 122
     fi_driocc2 AT ROW 13.29 COL 78 COLON-ALIGNED NO-LABEL WIDGET-ID 120
     "User:" VIEW-AS TEXT
          SIZE 5.33 BY .91 AT ROW 25.57 COL 44
          FGCOLOR 7 FONT 6
     "ที่อยู่จัดส่ง1:" VIEW-AS TEXT
          SIZE 9 BY .91 AT ROW 10.24 COL 5
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "5." VIEW-AS TEXT
          SIZE 1.83 BY .91 AT ROW 16.52 COL 2.83 WIDGET-ID 106
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "เลขใบขับขี่:" VIEW-AS TEXT
          SIZE 9 BY .71 AT ROW 11.48 COL 64.83 WIDGET-ID 42
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "ผู้รับผลประโยชน์:" VIEW-AS TEXT
          SIZE 13.5 BY .91 AT ROW 22 COL 3.5
          BGCOLOR 19 FGCOLOR 0 FONT 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1.17 ROW 1.05
         SIZE 133.67 BY 25.95
         BGCOLOR 31 FGCOLOR 2 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "ที่อยู่จัดส่ง 2:" VIEW-AS TEXT
          SIZE 9.5 BY .91 AT ROW 10.24 COL 71
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "รหัสบริษัท:" VIEW-AS TEXT
          SIZE 9 BY .91 AT ROW 7.29 COL 5.17
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "ประเภทการจ่าย:" VIEW-AS TEXT
          SIZE 13 BY .91 AT ROW 21.95 COL 52.83
          BGCOLOR 19 FGCOLOR 0 FONT 1
     "ที่อยู่ใบเสร็จ:" VIEW-AS TEXT
          SIZE 9.83 BY .91 AT ROW 20.91 COL 7
          BGCOLOR 19 FGCOLOR 0 FONT 1
     "เลขบัตร ปชช:" VIEW-AS TEXT
          SIZE 11 BY .91 AT ROW 19.76 COL 89
          BGCOLOR 19 FGCOLOR 0 FONT 1
     "Engine Group :" VIEW-AS TEXT
          SIZE 12.33 BY .91 AT ROW 6.14 COL 50.83 WIDGET-ID 112
          BGCOLOR 19 FGCOLOR 2 
     "เลขบัตรประชาชน:" VIEW-AS TEXT
          SIZE 14.5 BY .71 AT ROW 11.43 COL 49.17
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "MC Type Group :" VIEW-AS TEXT
          SIZE 13.83 BY .91 AT ROW 6.14 COL 93.67 WIDGET-ID 114
          BGCOLOR 19 FGCOLOR 2 
     "New Policy :" VIEW-AS TEXT
          SIZE 10.17 BY .91 AT ROW 3.19 COL 80.17
          BGCOLOR 18 FGCOLOR 7 
     "ชื่อผลิตภัณฑ์:" VIEW-AS TEXT
          SIZE 11 BY .91 AT ROW 7.24 COL 86.83
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "ใบขับขี่หมดอายุ" VIEW-AS TEXT
          SIZE 12 BY .71 AT ROW 11.48 COL 119.17 WIDGET-ID 46
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "วันเดือนปีเกิด:" VIEW-AS TEXT
          SIZE 11.5 BY .91 AT ROW 9.24 COL 46.17
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "Prospect ID:" VIEW-AS TEXT
          SIZE 10.5 BY .91 AT ROW 8.24 COL 3.33 WIDGET-ID 26
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "เลขบัตร ปชช:" VIEW-AS TEXT
          SIZE 11 BY .91 AT ROW 9.19 COL 3
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "  ข้อมูลการชำระเงิน" VIEW-AS TEXT
          SIZE 19 BY .71 AT ROW 18.86 COL 5
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "วันที่ขาย:" VIEW-AS TEXT
          SIZE 7.5 BY .91 AT ROW 23.1 COL 9.17
          BGCOLOR 19 FGCOLOR 0 FONT 1
     "ว/ด/ป เกิด:" VIEW-AS TEXT
          SIZE 9.83 BY .71 AT ROW 11.48 COL 106.33
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "วันที่แจ้งงาน:" VIEW-AS TEXT
          SIZE 10.5 BY .91 AT ROW 3.19 COL 108.17 WIDGET-ID 8
          BGCOLOR 18 FGCOLOR 7 FONT 1
     "นามสกุล:" VIEW-AS TEXT
          SIZE 7.33 BY .91 AT ROW 19.76 COL 50.17
          BGCOLOR 19 FGCOLOR 0 FONT 1
     "ช่องทางการจ่าย:" VIEW-AS TEXT
          SIZE 13 BY .91 AT ROW 21.95 COL 91.33
          BGCOLOR 19 FGCOLOR 0 FONT 1
     "วันที่รับชำระเงิน :" VIEW-AS TEXT
          SIZE 13.5 BY .91 AT ROW 23.1 COL 32.5 WIDGET-ID 30
          BGCOLOR 19 FGCOLOR 0 FONT 1
     "เวลา:" VIEW-AS TEXT
          SIZE 4.5 BY .91 AT ROW 25.57 COL 29.5
          FGCOLOR 7 FONT 1
     "สาขา TMSTH :" VIEW-AS TEXT
          SIZE 13.5 BY .91 AT ROW 6.19 COL 30.5 WIDGET-ID 38
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "ระบุผู้ขับขี่:" VIEW-AS TEXT
          SIZE 9.5 BY .91 AT ROW 9.29 COL 100.5
          BGCOLOR 19 FGCOLOR 6 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1.17 ROW 1.05
         SIZE 133.67 BY 25.95
         BGCOLOR 31 FGCOLOR 2 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "Update By :" VIEW-AS TEXT
          SIZE 11.5 BY .91 AT ROW 25.57 COL 70.83 WIDGET-ID 12
          FGCOLOR 15 FONT 6
     "Old Policy :" VIEW-AS TEXT
          SIZE 10.17 BY .91 AT ROW 3.19 COL 47.17 WIDGET-ID 4
          BGCOLOR 18 FGCOLOR 7 FONT 1
     "ชื่อผู้จ่าย:" VIEW-AS TEXT
          SIZE 7.5 BY .91 AT ROW 19.71 COL 9.83
          BGCOLOR 19 FGCOLOR 0 FONT 1
     "ที่อยู่ใบเสร็จ2:" VIEW-AS TEXT
          SIZE 11.17 BY .91 AT ROW 20.86 COL 68.83
          BGCOLOR 19 FGCOLOR 0 FONT 1
     "ชื่อแคมเปญ:" VIEW-AS TEXT
          SIZE 10.67 BY .91 AT ROW 7.29 COL 51.83
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "วันที่โหลดงาน:" VIEW-AS TEXT
          SIZE 11.5 BY .91 AT ROW 25.57 COL 3.5
          FGCOLOR 7 FONT 1
     "Dealer :" VIEW-AS TEXT
          SIZE 9 BY .91 AT ROW 6.24 COL 5 WIDGET-ID 34
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "นามสกุลไทย:" VIEW-AS TEXT
          SIZE 11.17 BY .91 AT ROW 8.29 COL 86.67
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "  ข้อมูลลูกค้า" VIEW-AS TEXT
          SIZE 12.17 BY .91 AT ROW 4.05 COL 4
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "2." VIEW-AS TEXT
          SIZE 1.83 BY .91 AT ROW 13.24 COL 2.83
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "1." VIEW-AS TEXT
          SIZE 1.83 BY .91 AT ROW 12.19 COL 2.83 WIDGET-ID 48
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "เลขที่อ้างอิง:" VIEW-AS TEXT
          SIZE 10.83 BY .91 AT ROW 5.19 COL 57.5
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "Producer :" VIEW-AS TEXT
          SIZE 10.83 BY .91 AT ROW 5.24 COL 3.17
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "ชื่อไทย:" VIEW-AS TEXT
          SIZE 6.5 BY .91 AT ROW 8.24 COL 47.5
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "นามสกุล:" VIEW-AS TEXT
          SIZE 7.33 BY .71 AT ROW 11.48 COL 28.83
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "3." VIEW-AS TEXT
          SIZE 1.83 BY .91 AT ROW 14.33 COL 2.67 WIDGET-ID 70
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "สาขา AY :" VIEW-AS TEXT
          SIZE 9 BY .91 AT ROW 5.14 COL 115 WIDGET-ID 20
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "อาชีพผู้ขับขี่:" VIEW-AS TEXT
          SIZE 10 BY .71 AT ROW 11.48 COL 80.5
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "  ข้อมูลลูกค้าและการชำระเงิน" VIEW-AS TEXT
          SIZE 25.5 BY .91 AT ROW 1.19 COL 108.5
          FGCOLOR 7 FONT 6
     "เพศ:" VIEW-AS TEXT
          SIZE 4.5 BY .71 AT ROW 11.48 COL 96.17
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "เพศ:" VIEW-AS TEXT
          SIZE 4.5 BY .91 AT ROW 9.29 COL 31.67
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "ชื่อผู้ขับขี่:" VIEW-AS TEXT
          SIZE 8.5 BY .71 AT ROW 11.48 COL 12.17
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "รหัสแคมเปญ:" VIEW-AS TEXT
          SIZE 11 BY .91 AT ROW 7.33 COL 22.83
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "รหัสลูกค้า:" VIEW-AS TEXT
          SIZE 9 BY .91 AT ROW 5.14 COL 88.5
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "Contract :" VIEW-AS TEXT
          SIZE 8.5 BY .91 AT ROW 3.19 COL 26 WIDGET-ID 16
          BGCOLOR 18 FGCOLOR 7 FONT 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1.17 ROW 1.05
         SIZE 133.67 BY 25.95
         BGCOLOR 31 FGCOLOR 2 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "เบอร์โทร :" VIEW-AS TEXT
          SIZE 8.5 BY .91 AT ROW 9.29 COL 72.5
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "Agent :" VIEW-AS TEXT
          SIZE 7.67 BY .91 AT ROW 5.24 COL 30.83
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "4." VIEW-AS TEXT
          SIZE 1.83 BY .91 AT ROW 15.43 COL 2.67 WIDGET-ID 88
          BGCOLOR 19 FGCOLOR 2 FONT 1
     RECT-462 AT ROW 2.52 COL 1.33
     RECT-464 AT ROW 19.14 COL 3
     RECT-465 AT ROW 4.57 COL 1.83
     RECT-502 AT ROW 25.38 COL 110.33 WIDGET-ID 22
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1.17 ROW 1.05
         SIZE 133.67 BY 25.95
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
         HEIGHT             = 26.1
         WIDTH              = 134.17
         MAX-HEIGHT         = 26.52
         MAX-WIDTH          = 135
         VIRTUAL-HEIGHT     = 26.52
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
       fi_bray:READ-ONLY IN FRAME fr_main        = TRUE.

ASSIGN 
       fi_brtms:READ-ONLY IN FRAME fr_main        = TRUE.

ASSIGN 
       fi_contract:READ-ONLY IN FRAME fr_main        = TRUE.

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


&Scoped-define SELF-NAME bu_detail2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_detail2 C-Win
ON CHOOSE OF bu_detail2 IN FRAME fr_main /* ข้อมูลรถและความคุ้มครอง */
DO:
    /*Get Current br_tlt.*/
        nv_recidtlt  =  Recid(tlt).

        {&WINDOW-NAME}:hidden  =  Yes. 
        
        Run  wgw\wgwqay12(Input  nv_recidtlt).
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
                                              /* "InsName:" + trim(fi_comnam)  + " " + */   /*ชื่อบริษัทประกันภัย */                                             
                                               "CamCode:" + trim(fi_camp)    + " " +    /*รหัสแคมเปญ    */                                                   
                                               "CamName:" + trim(fi_campnam)            /*ชื่อแคมเปญ    */                                                   
                    brstat.tlt.usrsent       = /*"ProCode:" + trim(fi_produc) + " " + */    /*รหัสผลิตภัณฑ์ */                                                  
                                               "ProName:" + trim(fi_producnam) + " " +   /*ชื่อผลิตภัณฑ์ */                                                  
                                               /*"PackNam:" + trim(fi_pacgnam) + " " +  */  /*ชื่อแพคเกจ    */                                                  
                                              "PackCod:" + trim(fi_produc)        /*รหัสแพคเกจ    */                                                  
                    brstat.tlt.imp           = /*"TYP:" + TRIM(fi_custtyp) + " " + */       /*ประเภท        */ 
                                               "Pol:" + TRIM(fi_oldpol)                 /*เบอร์เดิม */
                    brstat.tlt.ins_name      = "NameTha:" + trim(fi_nameth)  + " "      /*ชื่อผู้เอาประกัน  */                                               
                                                          + trim(fi_surth)              /*นามสกุลผู้เอาประกัน */                                               
                                              /* "NameEng:" + trim(fi_nameeng) + " "      /*ชื่อภาษา อังกฤษ   */                                         
                                                          + trim(fi_sureng)    */         /*นามสกุลภาษา อังกฤษ*/                                         
                    brstat.tlt.rec_addr5     = "ICNo:"  + trim(fi_icno)  + " " +        /*เลขที่บัตรประชาชน/เลขที่ผูเสียภาษี   */                           
                                               "Sex:"   + trim(fi_sex)   + " " +        /*เพศ                          */                                   
                                               "Birth:" + trim(STRING(fi_polbdate),"99/99/9999")    /*วันเดือนปีเกิด ( DD/MM/YYYY) */                                   
                                               /*"Occup:" + trim(fi_polocc)   */             /*อาชีพ  */                                   
                    brstat.tlt.ins_addr5     = "Phone:" + TRIM(fi_poltel)         /*เบอร์โทร */
                                              /* "Email:" + TRIM(fi_mail)   + " " +        /*email   */                                    
                                               "Linid:" + TRIM(fi_line)  */                /*Line_ID */                                    
                   /* brstat.tlt.ins_addr1     = trim(fi_poladdr1)                         /*ที่อยูลูกค้า*/                                                   
                    brstat.tlt.ins_addr2     = trim(fi_poladdr2)  */                                             
                    brstat.tlt.ins_addr3     = trim(fi_senaddr1)                         /*ที่อยูจัดส่ง*/ 
                    brstat.tlt.ins_addr4     = trim(fi_senaddr2)                         
                    /*brstat.tlt.exp           = "PayTyp:" + TRIM(fi_paytyp) + " " +       /*ประเภท ผู้จ่ายเงิน*/                       
                                               "Branch:" + TRIM(fi_branch) */              /*สาขา*/                                        
                    brstat.tlt.rec_name      = trim(fi_paynam) + " " + trim(fi_paysur)   /* ชื่อ - สกุล ผู้จ่ายเงิน*/   
                    brstat.tlt.comp_sub      = trim(fi_payic)                            /* เลขบัตร ปปช. ผู้จ่ายเงิน*/  
                    brstat.tlt.rec_addr1     = trim(fi_payaddr1)                         /*ที่อยู่ออกใบเสร็จ */                                            
                    brstat.tlt.rec_addr2     = trim(fi_payaddr2)                         
                    brstat.tlt.safe1         = trim(fi_bennam)                           /*ชื่อ - สกุล ผู้รับผลประโยชน์*/ 
                    brstat.tlt.safe2         = /*"PaymentMD:"   + trim(fi_paymcod) + " " +*/  /*รหัสประเภทการชำระเบี้ยประกัน*/                                      
                                               "PaymentMDTy:" + TRIM(fi_paymtyp) + " " + /*ประเภทการชำระเบี้ยประกัน    */                                   
                                               /*"PaymentTyCd:" + trim(fi_payway)  + " " +*/ /*รหัสช่องทางที่ชำระเบี้ย*/                                        
                                               "Paymentty:"   + trim(fi_waytyp)          /*ช่องทางที่ชำระค่าเบี้ย */                                        
                    /*brstat.tlt.safe3         = TRIM(fi_bank)    */                         /*ธนาคารที่ชำระเบี้ย*/                                                
                    /*brstat.tlt.rec_addr4     = "Paydat:" + trim(string(fi_paydat),"99/99/9999") + " " +       /*วันที่ชำระค่าเบี้ย*/                                                
                                               "PaySts:" + trim(fi_paysts )  + " " +    /*สถานะการชำระเบี้ย */                                                
                                               "Paid:"   + trim(fi_paidsts) */            /*สถานะการจ่ายเงิน*/                                                  
                    brstat.tlt.datesent      = date(fi_saledat)                         /*วันที่ขาย       */                                                  
                    brstat.tlt.dat_ins_noti  = date(fi_payin)                          /*วันที่รับชำระเงิน */                                                
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
                                               "DriBir2:" + trim(STRING(fi_dridate2),"99/99/9999")     /*วันเดือนปีเกิดผู้ขับขี่ 2 */ 
                    brstat.tlt.usrid         = IF index(brstat.tlt.usrid,"/") <> 0 THEN SUBSTR(brstat.tlt.usrid,1,INDEX(tlt.usrid,"/")) + USERID(LDBNAME(1)) 
                                               ELSE brstat.tlt.usrid + "/" + USERID(LDBNAME(1)) 
                    brstat.tlt.dealer        = trim(fi_dealer)    /*A65-0115*/
                    brstat.tlt.ins_addr1     = trim(fi_brtms)    /*A65-0115*/
                    /* Add by : A67-0162 */
                    brstat.tlt.dri_lic1      = trim(fi_drilicen1)       
                    brstat.tlt.dri_licenexp1 = STRING(fi_licenexp1)
                    brstat.tlt.dri_lic2      = TRIM(fi_drilicen2)     
                    brstat.tlt.dri_licenexp2 = STRING(fi_licenexp2)
                    brstat.tlt.dri_title3    = IF TRIM(fi_drinam3) <> "" THEN SUBSTR(fi_drinam3,1,INDEX(fi_drinam3," ")) ELSE ""   
                    brstat.tlt.dri_fname3    = IF TRIM(fi_drinam3) <> "" AND INDEX(TRIM(fi_drinam3)," ") <> 0  THEN SUBSTR(fi_drinam3,R-INDEX(fi_drinam3," ")) ELSE "" 
                    brstat.tlt.dri_lname3     = trim(fi_drisur3)   
                    brstat.tlt.dri_birth3     = string(fi_dridate3)        
                    brstat.tlt.dri_gender3    = trim(fi_drisex3)   
                    brstat.tlt.dri_no3        = trim(fi_driid3)        
                    brstat.tlt.dri_lic3       = trim(fi_drilicen3) 
                    brstat.tlt.dri_licenexp3  = STRING(fi_licenexp3) 
                    brstat.tlt.dir_occ3       = trim(fi_driocc3)    
                    brstat.tlt.dri_title4     = IF TRIM(fi_drinam4) <> "" THEN SUBSTR(fi_drinam4,1,INDEX(fi_drinam4," ")) ELSE ""                                          
                    brstat.tlt.dri_fname4     = IF TRIM(fi_drinam4) <> "" AND INDEX(TRIM(fi_drinam4)," ") <> 0  THEN SUBSTR(fi_drinam4,R-INDEX(fi_drinam4," ")) ELSE "" 
                    brstat.tlt.dri_lname4     = trim(fi_drisur4)  
                    brstat.tlt.dri_birth4     = STRING(fi_dridate4) 
                    brstat.tlt.dri_gender4    = trim(fi_drisex4)  
                    brstat.tlt.dri_no4        = trim(fi_driid4)      
                    brstat.tlt.dri_lic4       = trim(fi_drilicen4)
                    brstat.tlt.dri_licenexp4  = STRING(fi_licenexp4)
                    brstat.tlt.dri_occ4       = trim(fi_driocc4)  
                    brstat.tlt.dri_title5     = IF TRIM(fi_drinam5) <> "" THEN SUBSTR(fi_drinam5,1,INDEX(fi_drinam5," ")) ELSE ""                                       
                    brstat.tlt.dri_fname5     = IF TRIM(fi_drinam5) <> "" AND INDEX(TRIM(fi_drinam5)," ") <> 0  THEN SUBSTR(fi_drinam5,R-INDEX(fi_drinam5," ")) ELSE "" 
                    brstat.tlt.dri_lname5     = trim(fi_drisur5)  
                    brstat.tlt.dri_birth5     = STRING(fi_dridate5) 
                    brstat.tlt.dri_gender5    = trim(fi_drisex5)  
                    brstat.tlt.dri_no5        = trim(fi_driid5)      
                    brstat.tlt.dri_lic5       = trim(fi_drilicen5)
                    brstat.tlt.dri_licenexp5  = STRING(fi_licenexp5)
                    brstat.tlt.dri_occ5       = trim(fi_driocc5)  
                    brstat.tlt.note2          = trim(fi_engtyp)   
                    brstat.tlt.note3          = trim(fi_Mctyp) .
                    /* end : A67-0162 */
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


&Scoped-define SELF-NAME fi_bennam
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_bennam C-Win
ON LEAVE OF fi_bennam IN FRAME fr_main
DO:
    fi_bennam = INPUT fi_bennam .
    DISP fi_bennam WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_bray
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_bray C-Win
ON LEAVE OF fi_bray IN FRAME fr_main
DO:
    fi_bray = INPUT fi_bray .
    DISP fi_bray WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_brtms
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_brtms C-Win
ON LEAVE OF fi_brtms IN FRAME fr_main
DO:
    fi_brtms = INPUT fi_brtms .
    DISP fi_brtms WITH FRAME fr_main.
  
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


&Scoped-define SELF-NAME fi_contract
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_contract C-Win
ON LEAVE OF fi_contract IN FRAME fr_main
DO:
    fi_contract = INPUT fi_contract .
    DISP fi_contract WITH FRAME fr_main.
  
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


&Scoped-define SELF-NAME fi_dealer
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_dealer C-Win
ON LEAVE OF fi_dealer IN FRAME fr_main
DO:
    fi_dealer = INPUT fi_dealer .
    DISP fi_dealer WITH FRAME fr_main.
  
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


&Scoped-define SELF-NAME fi_dridate3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_dridate3 C-Win
ON LEAVE OF fi_dridate3 IN FRAME fr_main
DO:
    fi_dridate3 = INPUT fi_dridate3 .
    DISP fi_dridate3 WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_dridate4
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_dridate4 C-Win
ON LEAVE OF fi_dridate4 IN FRAME fr_main
DO:
    fi_dridate4 = INPUT fi_dridate4 .
    DISP fi_dridate4 WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_dridate5
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_dridate5 C-Win
ON LEAVE OF fi_dridate5 IN FRAME fr_main
DO:
    fi_dridate5 = INPUT fi_dridate5 .
    DISP fi_dridate5 WITH FRAME fr_main.
  
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


&Scoped-define SELF-NAME fi_driid3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_driid3 C-Win
ON LEAVE OF fi_driid3 IN FRAME fr_main
DO:
    fi_driid3 = INPUT fi_driid3 .
    DISP fi_driid3 WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_driid4
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_driid4 C-Win
ON LEAVE OF fi_driid4 IN FRAME fr_main
DO:
    fi_driid4 = INPUT fi_driid4 .
    DISP fi_driid4 WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_driid5
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_driid5 C-Win
ON LEAVE OF fi_driid5 IN FRAME fr_main
DO:
    fi_driid5 = INPUT fi_driid5 .
    DISP fi_driid5 WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_drilicen1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_drilicen1 C-Win
ON LEAVE OF fi_drilicen1 IN FRAME fr_main
DO:
    fi_drilicen1 = INPUT fi_drilicen1 .
    DISP fi_drilicen1 WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_drilicen2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_drilicen2 C-Win
ON LEAVE OF fi_drilicen2 IN FRAME fr_main
DO:
    fi_drilicen2 = INPUT fi_drilicen2 .
    DISP fi_drilicen2 WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_drilicen3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_drilicen3 C-Win
ON LEAVE OF fi_drilicen3 IN FRAME fr_main
DO:
    fi_drilicen3 = INPUT fi_drilicen3 .
    DISP fi_drilicen3 WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_drilicen4
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_drilicen4 C-Win
ON LEAVE OF fi_drilicen4 IN FRAME fr_main
DO:
    fi_drilicen4 = INPUT fi_drilicen4 .
    DISP fi_drilicen4 WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_drilicen5
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_drilicen5 C-Win
ON LEAVE OF fi_drilicen5 IN FRAME fr_main
DO:
    fi_drilicen5 = INPUT fi_drilicen5 .
    DISP fi_drilicen5 WITH FRAME fr_main.
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


&Scoped-define SELF-NAME fi_drinam3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_drinam3 C-Win
ON LEAVE OF fi_drinam3 IN FRAME fr_main
DO:
    fi_drinam3 = INPUT fi_drinam3 .
    DISP fi_drinam3 WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_drinam4
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_drinam4 C-Win
ON LEAVE OF fi_drinam4 IN FRAME fr_main
DO:
    fi_drinam4 = INPUT fi_drinam4 .
    DISP fi_drinam4 WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_drinam5
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_drinam5 C-Win
ON LEAVE OF fi_drinam5 IN FRAME fr_main
DO:
    fi_drinam5 = INPUT fi_drinam5 .
    DISP fi_drinam5 WITH FRAME fr_main.
  
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


&Scoped-define SELF-NAME fi_driocc3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_driocc3 C-Win
ON LEAVE OF fi_driocc3 IN FRAME fr_main
DO:
    fi_driocc3 = INPUT fi_driocc3 .
    DISP fi_driocc3 WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_driocc4
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_driocc4 C-Win
ON LEAVE OF fi_driocc4 IN FRAME fr_main
DO:
    fi_driocc4 = INPUT fi_driocc4 .
    DISP fi_driocc4 WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_driocc5
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_driocc5 C-Win
ON LEAVE OF fi_driocc5 IN FRAME fr_main
DO:
    fi_driocc5 = INPUT fi_driocc5 .
    DISP fi_driocc5 WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_drisex1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_drisex1 C-Win
ON LEAVE OF fi_drisex1 IN FRAME fr_main
DO:
    fi_drisex3 = INPUT fi_drisex3 .
    DISP fi_drisex3 WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_drisex2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_drisex2 C-Win
ON LEAVE OF fi_drisex2 IN FRAME fr_main
DO:
    fi_drisex3 = INPUT fi_drisex3 .
    DISP fi_drisex3 WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_drisex3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_drisex3 C-Win
ON LEAVE OF fi_drisex3 IN FRAME fr_main
DO:
    fi_drisex3 = INPUT fi_drisex3 .
    DISP fi_drisex3 WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_drisex4
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_drisex4 C-Win
ON LEAVE OF fi_drisex4 IN FRAME fr_main
DO:
    fi_drisex4 = INPUT fi_drisex4 .
    DISP fi_drisex4 WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_drisex5
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_drisex5 C-Win
ON LEAVE OF fi_drisex5 IN FRAME fr_main
DO:
    fi_drisex5 = INPUT fi_drisex5 .
    DISP fi_drisex5 WITH FRAME fr_main.
  
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


&Scoped-define SELF-NAME fi_drisur3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_drisur3 C-Win
ON LEAVE OF fi_drisur3 IN FRAME fr_main
DO:
    fi_drisur3 = INPUT fi_drisur3 .
    DISP fi_drisur3 WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_drisur4
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_drisur4 C-Win
ON LEAVE OF fi_drisur4 IN FRAME fr_main
DO:
    fi_drisur4 = INPUT fi_drisur4 .
    DISP fi_drisur4 WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_drisur5
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_drisur5 C-Win
ON LEAVE OF fi_drisur5 IN FRAME fr_main
DO:
    fi_drisur5 = INPUT fi_drisur5 .
    DISP fi_drisur5 WITH FRAME fr_main.
  
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


&Scoped-define SELF-NAME fi_engtyp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_engtyp C-Win
ON LEAVE OF fi_engtyp IN FRAME fr_main
DO:
    fi_engtyp = INPUT fi_engtyp .
    DISP fi_engtyp WITH FRAME fr_main.
  
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


&Scoped-define SELF-NAME fi_licenexp1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_licenexp1 C-Win
ON LEAVE OF fi_licenexp1 IN FRAME fr_main
DO:
    fi_licenexp1 = INPUT fi_licenexp1 .
    DISP fi_licenexp1 WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_licenexp2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_licenexp2 C-Win
ON LEAVE OF fi_licenexp2 IN FRAME fr_main
DO:
    fi_licenexp2 = INPUT fi_licenexp2 .
    DISP fi_licenexp2 WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_licenexp3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_licenexp3 C-Win
ON LEAVE OF fi_licenexp3 IN FRAME fr_main
DO:
    fi_licenexp3 = INPUT fi_licenexp3 .
    DISP fi_licenexp3 WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_licenexp4
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_licenexp4 C-Win
ON LEAVE OF fi_licenexp4 IN FRAME fr_main
DO:
    fi_licenexp4 = INPUT fi_licenexp4 .
    DISP fi_licenexp4 WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_licenexp5
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_licenexp5 C-Win
ON LEAVE OF fi_licenexp5 IN FRAME fr_main
DO:
    fi_licenexp5 = INPUT fi_licenexp5 .
    DISP fi_licenexp5 WITH FRAME fr_main.
  
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


&Scoped-define SELF-NAME fi_oldpol
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_oldpol C-Win
ON LEAVE OF fi_oldpol IN FRAME fr_main
DO:
    fi_oldpol = INPUT fi_oldpol .
    DISP fi_oldpol WITH FRAME fr_main.
  
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


&Scoped-define SELF-NAME fi_paysur
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_paysur C-Win
ON LEAVE OF fi_paysur IN FRAME fr_main
DO:
    fi_paysur = INPUT fi_paysur .
    DISP fi_paysur WITH FRAME fr_main.
  
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
  
  gv_prgid = "wgwqay11".
  gv_prog  = "Query & Update Notify (AYCAL) ".
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
      fi_polno   fi_poltyp   fi_trandat  fi_time       fi_user     
      fi_agent   fi_producer fi_refno    fi_custcode
      fi_comcod  fi_camp     fi_campnam  fi_producnam  fi_produc           
      fi_nameth  fi_surth    fi_icno     fi_sex        fi_polbdate    
      fi_poltel  fi_senaddr1 fi_senaddr2 fi_driver     fi_drinam1
      fi_drisur1 fi_driid1   fi_drisex1  fi_driocc1    fi_dridate1 
      fi_drinam2 fi_drisur2  fi_driid2   fi_drisex2
      fi_driocc2 fi_dridate2 fi_paynam   fi_paysur       fi_payic         
      fi_payaddr1  fi_payaddr2  fi_bennam  fi_paymtyp    fi_waytyp   
      fi_payin   fi_saledat  fi_oldpol   fi_userup      fi_notdat   
      fi_contract  fi_bray   fi_dealer   fi_brtms /*A65-0115*/
      /* A67-0162 */ 
      fi_engtyp     fi_drilicen3  fi_drinam5     
      fi_Mctyp      fi_licenexp3  fi_drisur5     
      fi_drilicen1  fi_driocc3    fi_dridate5    
      fi_licenexp1  fi_drinam4    fi_drisex5     
      fi_drilicen2  fi_drisur4    fi_driid5      
      fi_licenexp2  fi_dridate4   fi_drilicen5   
      fi_drinam3    fi_drisex4    fi_licenexp5   
      fi_drisur3    fi_driid4     fi_driocc5     
      fi_dridate3   fi_drilicen4 
      fi_drisex3    fi_licenexp4 
      fi_driid3     fi_driocc4   
      /* end : A67-0162 */  
      bu_detail1  bu_detail2  bU_save  bu_exit WITH FRAME fr_main.
    bu_detail1:BGCOLOR = 19.
    bu_detail1:FGCOLOR = 6. 
   /* DISABLE bu_detail1 WITH FRAME fr_main.*/


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
  DISPLAY fi_engtyp fi_comcod fi_camp fi_campnam fi_producnam fi_nameth fi_surth 
          fi_icno fi_sex fi_polbdate fi_poltel fi_senaddr1 fi_senaddr2 fi_paynam 
          fi_paysur fi_payic fi_payaddr1 fi_payaddr2 fi_bennam fi_paymtyp 
          fi_waytyp fi_saledat fi_refno fi_custcode fi_polno fi_poltyp fi_driver 
          fi_drinam1 fi_drisur1 fi_driid1 fi_dridate1 fi_drinam2 fi_drisur2 
          fi_driid2 fi_dridate2 fi_producer fi_agent fi_trandat fi_user fi_time 
          fi_oldpol fi_notdat fi_userup fi_contract fi_bray fi_produc fi_payin 
          fi_dealer fi_brtms fi_drilicen1 fi_licenexp1 fi_drilicen2 fi_licenexp2 
          fi_drinam3 fi_drisur3 fi_driid3 fi_drisex3 fi_driocc3 fi_dridate3 
          fi_drilicen3 fi_licenexp3 fi_drinam4 fi_drisur4 fi_driid4 fi_drisex4 
          fi_driocc4 fi_dridate4 fi_drilicen4 fi_licenexp4 fi_drinam5 fi_drisur5 
          fi_driid5 fi_drisex5 fi_driocc5 fi_dridate5 fi_drilicen5 fi_licenexp5 
          fi_mctyp fi_drisex1 fi_driocc1 fi_drisex2 fi_driocc2 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE fi_engtyp bu_detail2 bu_save bu_exit bu_detail1 fi_comcod fi_camp 
         fi_campnam fi_producnam fi_nameth fi_surth fi_icno fi_sex fi_polbdate 
         fi_poltel fi_senaddr1 fi_senaddr2 fi_paynam fi_paysur fi_payic 
         fi_payaddr1 fi_payaddr2 fi_bennam fi_paymtyp fi_waytyp fi_saledat 
         fi_refno fi_custcode fi_polno fi_poltyp fi_driver fi_drinam1 
         fi_drisur1 fi_driid1 fi_dridate1 fi_drinam2 fi_drisur2 fi_driid2 
         fi_dridate2 fi_producer fi_agent fi_trandat fi_user fi_time fi_oldpol 
         fi_notdat fi_userup fi_contract fi_bray fi_produc fi_payin fi_dealer 
         fi_brtms fi_drilicen1 fi_licenexp1 fi_drilicen2 fi_licenexp2 
         fi_drinam3 fi_drisur3 fi_driid3 fi_drisex3 fi_driocc3 fi_dridate3 
         fi_drilicen3 fi_licenexp3 fi_drinam4 fi_drisur4 fi_driid4 fi_drisex4 
         fi_driocc4 fi_dridate4 fi_drilicen4 fi_licenexp4 fi_drinam5 fi_drisur5 
         fi_driid5 fi_drisex5 fi_driocc5 fi_dridate5 fi_drilicen5 fi_licenexp5 
         fi_mctyp fi_drisex1 fi_driocc1 fi_drisex2 fi_driocc2 RECT-462 RECT-464 
         RECT-465 RECT-502 
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
        fi_notdat    = brstat.tlt.trndat
        fi_time      = brstat.tlt.enttim
        fi_user      = IF index(brstat.tlt.usrid,"/") <> 0 THEN SUBSTR(brstat.tlt.usrid,1,INDEX(tlt.usrid,"/") - 1) ELSE brstat.tlt.usrid
        fi_userup    = IF index(brstat.tlt.usrid,"/") <> 0 THEN SUBSTR(brstat.tlt.usrid,r-INDEX(tlt.usrid,"/") + 1) ELSE ""
        fi_agent     = brstat.tlt.recac
        fi_producer  = brstat.tlt.subins
        fi_refno     = brstat.tlt.nor_noti_ins
        fi_custcode  = brstat.tlt.nor_usr_ins
        fi_contract  = IF trim(brstat.tlt.colorcod) = "" THEN "" ELSE SUBSTR(brstat.tlt.colorcod,5,INDEX(brstat.tlt.colorcod,"BR:") - 5)
        fi_bray      = IF trim(brstat.tlt.colorcod) = "" THEN "" ELSE SUBSTR(brstat.tlt.colorcod,R-INDEX(brstat.tlt.colorcod,"BR:") + 3)   
        /*- campaign product packge ----*/
        fi_campnam   = trim(substr(brstat.tlt.lotno,R-INDEX(tlt.lotno,"CamName:") + 8 ))     /*ชื่อแคมเปญ*/
        n_char       = trim(SUBSTR(brstat.tlt.lotno,1,R-INDEX(tlt.lotno,"CamName:") - 2 ))
        fi_camp      = trim(substr(n_char,R-INDEX(n_char,"CamCode:") + 8))                   /*รหัสแคมเปญ*/
        n_char       = trim(SUBSTR(n_char,1,R-INDEX(n_char,"CamCode:") - 2))
        fi_comcod    = trim(substr(n_char,R-INDEX(n_char,"InsCode:") + 8))                   /*รหัสบริษัท*/

        fi_produc    = trim(substr(brstat.tlt.usrsent,R-INDEX(brstat.tlt.usrsent,"PackCod:") + 8))     /*รหัสผลิตภัณฑ์ */ 
        n_char       = trim(SUBSTR(brstat.tlt.usrsent,1,R-INDEX(brstat.tlt.usrsent,"PackCod:") - 2 ))
        fi_producnam = TRIM(SUBSTR(n_char,R-INDEX(n_char,"proname:") + 8))
        
        fi_oldpol    = TRIM(SUBSTR(brstat.tlt.imp,R-INDEX(brstat.tlt.imp,"Pol:") + 4))     /*เบอร์กรมเดิม */

        n_char       = trim(tlt.ins_name)
        fi_surth     = trim(SUBSTR(n_char,R-INDEX(n_char," ")))
        n_char       = SUBSTR(n_char,1,LENGTH(n_char) - LENGTH(fi_surth))
        fi_nameth    = IF trim(n_char) <> "NameTha:" THEN trim(SUBSTR(n_char,R-INDEX(n_char,"Nametha:") + 8)) ELSE "" 
        /*-- เลขบัตร วันเกิด เพศ อาขีพ --*/
        n_char      = TRIM(brstat.tlt.rec_addr5)
        n_bdate      = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Birth:") + 6 ))
        fi_polbdate  = DATE(n_bdate)
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Birth:") - 2 ))
        fi_sex       = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Sex:") + 4 ))
        fi_icno      = TRIM(SUBSTR(n_char,6,R-INDEX(n_char,"Sex:") - 6 )) 
        /*-- เบอร์โทร เมล์ ไลน์ ---*/
        fi_poltel   = TRIM(SUBSTR(brstat.tlt.ins_addr5,7))
        fi_senaddr1 = trim(brstat.tlt.ins_addr3)
        fi_senaddr2 = trim(brstat.tlt.ins_addr4)
        fi_dealer   = TRIM(brstat.tlt.dealer)      /*A65-0115*/
        fi_brtms    = TRIM(brstat.tlt.ins_addr1) . /*A65-0115*/
        
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
    DEF VAR n_leng AS INT INIT 0.
    DEF VAR n_char AS CHAR FORMAT "x(250)" INIT "" .
    DEF VAR n_bdate AS CHAR INIT "".
    ASSIGN 
        fi_polno     = brstat.tlt.policy
        fi_poltyp    = brstat.tlt.flag
        fi_trandat   = brstat.tlt.entdat
        fi_notdat    = brstat.tlt.trndat
        fi_time      = brstat.tlt.enttim
        fi_user      = IF index(brstat.tlt.usrid,"/") <> 0 THEN SUBSTR(brstat.tlt.usrid,1,INDEX(tlt.usrid,"/") - 1) ELSE brstat.tlt.usrid
        fi_userup    = IF index(brstat.tlt.usrid,"/") <> 0 THEN SUBSTR(brstat.tlt.usrid,r-INDEX(tlt.usrid,"/") + 1) ELSE ""
        fi_agent     = brstat.tlt.recac
        fi_producer  = brstat.tlt.subins
        fi_refno     = brstat.tlt.nor_noti_ins
        fi_custcode  = brstat.tlt.nor_usr_ins
        fi_contract  = IF trim(brstat.tlt.colorcod) = "" THEN "" ELSE SUBSTR(brstat.tlt.colorcod,5,INDEX(brstat.tlt.colorcod,"BR:") - 5)
        fi_bray      = IF trim(brstat.tlt.colorcod) = "" THEN "" ELSE SUBSTR(brstat.tlt.colorcod,R-INDEX(brstat.tlt.colorcod,"BR:") + 3)   
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
        fi_custtyp   = trim(substr(brstat.tlt.imp,5,INDEX(brstat.tlt.imp,"Pol:") - 4))     /*ประเภท        */ 
        fi_oldpol    = TRIM(SUBSTR(brstat.tlt.imp,R-INDEX(brstat.tlt.imp,"Pol:") + 4))     /*เบอร์กรมเดิม */
        fi_custdes   = IF index(brstat.tlt.imp,"TYP:P") = 0 THEN "นิติบุคคล" ELSE "บุลคลธรรมดา"
        /*-- ชื่อสกุลลูกค้า ---*/
        n_char       = trim(SUBSTR(brstat.tlt.ins_name,R-INDEX(tlt.ins_name,"nameeng:") + 8 ))
        fi_sureng    = IF n_char <> " " AND index(brstat.tlt.imp,"TYP:P") <> 0 then trim(SUBSTR(n_char,R-INDEX(n_char," ")))  else ""
        fi_nameeng   = IF n_char <> " " then trim(SUBSTR(n_char,1,R-INDEX(n_char," "))) else "" 
        n_char       = trim(SUBSTR(tlt.ins_name,1,R-INDEX(tlt.ins_name,"nameeng:") - 2))
        fi_surth     = IF trim(n_char) <> "NameTha:" AND index(brstat.tlt.imp,"TYP:P") <> 0 THEN trim(SUBSTR(n_char,R-INDEX(n_char," ")))  ELSE ""
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
END.*/
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
        /*fi_paytyp   = trim(substr(brstat.tlt.EXP,index(brstat.tlt.EXP,"Paytyp:") + 7,R-INDEX(brstat.tlt.EXP,"Branch:") - 9)) 
        fi_branch   = TRIM(SUBSTR(brstat.tlt.EXP,R-INDEX(brstat.tlt.EXP,"Branch:") + 7 ))*/
        fi_paysur   = TRIM(substr(brstat.tlt.rec_name,R-INDEX(brstat.tlt.rec_name," ")))
        fi_paynam   = trim(substr(brstat.tlt.rec_name,1,LENGTH(brstat.tlt.rec_name) - LENGTH(fi_paysur)))
        fi_payic    = trim(brstat.tlt.comp_sub)
        fi_payaddr1 = trim(brstat.tlt.rec_addr1)
        fi_payaddr2 = trim(brstat.tlt.rec_addr2)
        fi_bennam   = trim(brstat.tlt.safe1) 
        fi_waytyp   = trim(substr(brstat.tlt.safe2,R-INDEX(brstat.tlt.safe2,"Paymentty:") + 10 ))
        n_char      = TRIM(SUBSTR(brstat.tlt.safe2,1,R-INDEX(brstat.tlt.safe2,"Paymentty:") - 2 ))
        /*fi_payway   = TRIM(SUBSTR(n_char,R-INDEX(n_char,"PaymentTyCd:") + 12 ))
        n_char      = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"PaymentTyCd:") - 2 ))*/
        fi_paymtyp  = TRIM(SUBSTR(n_char,R-INDEX(n_char,"PaymentMDTy:") + 12 ))
       /* n_char      = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"PaymentMDTy:") - 2 ))
        fi_paymcod  = TRIM(SUBSTR(n_char,R-INDEX(n_char,"PaymentMD:") + 10 ))
        fi_bank     = TRIM(brstat.tlt.safe3) */
        /*fi_paidsts  = TRIM(SUBSTR(brstat.tlt.rec_addr4,R-INDEX(brstat.tlt.rec_addr4,"Paid:") + 5 ))
        n_char      = TRIM(SUBSTR(brstat.tlt.rec_addr4,1,R-INDEX(brstat.tlt.rec_addr4,"Paid:") - 2 ))
        fi_paysts   = TRIM(SUBSTR(n_char,R-INDEX(n_char,"paysts:") + 7 ))
        n_char      = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"paysts:") - 2 ))
        n_bdate     = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Paydat:") + 7 ))
        fi_paydat   = DATE(n_bdate)*/
        fi_saledat  = brstat.tlt.datesent 
        fi_payin    = brstat.tlt.dat_ins_noti 
        /* A67-0162 */
        fi_drilicen1  = TRIM(brstat.tlt.dri_lic1)      
        fi_licenexp1  = DATE(brstat.tlt.dri_licenexp1)  
        fi_drilicen2  = TRIM(brstat.tlt.dri_lic2)      
        fi_licenexp2  = DATE(brstat.tlt.dri_licenexp2)     
        fi_drinam3    = TRIM(brstat.tlt.dri_title3) + " " + TRIM(dri_fname3)       
        fi_drisur3    = TRIM(dri_lname3)            
        fi_dridate3   = DATE(dri_birth3)            
        fi_drisex3    = TRIM(dri_gender3) 
        fi_driid3     = TRIM(dri_no3)           
        fi_drilicen3  = TRIM(dri_lic3)      
        fi_licenexp3  = DATE(dri_licenexp3)     
        fi_driocc3    = TRIM(dir_occ3)      
        fi_drinam4    = TRIM(dri_title4) + " " + TRIM(dri_fname4)       
        fi_drisur4    = TRIM(dri_lname4)            
        fi_dridate4   = DATE(dri_birth4)            
        fi_drisex4    = TRIM(dri_gender4)  
        fi_driid4     = TRIM(dri_no4)           
        fi_drilicen4  = TRIM(dri_lic4)      
        fi_licenexp4  = DATE(dri_licenexp4)     
        fi_driocc4    = TRIM(dri_occ4)      
        fi_drinam5    = TRIM(dri_title5) + " " + TRIM(dri_fname5)           
        fi_drisur5    = TRIM(dri_lname5)            
        fi_dridate5   = DATE(dri_birth5)            
        fi_drisex5    = TRIM(dri_gender5)
        fi_driid5     = TRIM(dri_no5)           
        fi_drilicen5  = TRIM(dri_lic5)      
        fi_licenexp5  = DATE(dri_licenexp5)     
        fi_driocc5    = TRIM(dri_occ5)
        fi_engtyp     = TRIM(note2)
        fi_Mctyp      = TRIM(note3) . 
        /* end : A67-0162 */
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assignfi2-bp C-Win 
PROCEDURE proc_assignfi2-bp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*DO:
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
        fi_payin    = brstat.tlt.dat_ins_noti . 
END.*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

