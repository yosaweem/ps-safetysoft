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
  wuwqtis1.w :  Quey & Update data TISCO.
  Create  by    :  Ranu I. A67-0114
 Connect :  gw_stat ld brstat , gw_safe ld sic_bran ,sic_test ld sicuw sicsyac :not connect stat
 
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
DEF VAR n_Rec_name72  AS CHAR FORMAT "x(150)" INIT "".    /*Start A63-0210*/
DEF VAR n_Rec_add1    AS CHAR FORMAT "x(60)"  INIT "".    
DEF VAR n_Rec_add2    AS CHAR FORMAT "x(60)"  INIT "".    
DEF VAR nv_cutrec     AS CHAR FORMAT "x(200)" INIT "".    /*End A63-0210*/
DEF VAR nv_acc        AS CHAR FORMAT "x(255)" INIT "" . /*A64-0092*/

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS fi_policy fi_eng_no bu_save ra_poltyp ~
bu_exit fi_acctype fi_acccovsum fi_accprem fi_inspect fi_quoteno ~
fi_covcodcd fi_polsystem fi_engcount fi_eng_no3 fi_eng_no2 fi_eng_no5 ~
fi_eng_no4 fi_brand2 fi_typsale fi_bev fi_campaign fi_imginspec bu_car ~
fi_driv1 fi_birth1 fi_driv2 fi_birth2 fi_ID1 fi_occup1 fi_IC1 fi_occup2 ~
fi_driv3 fi_birth3 fi_id3 fi_occup3 fi_ic3 fi_driv4 fi_birth4 fi_id4 ~
fi_occup4 fi_ic4 fi_driv5 fi_birth5 fi_id5 fi_occup5 fi_ic5 fi_receipt ~
fi_receiptid70 fi_receiptidbr fi_receiptid72 fi_receiptidbr72 fi_receipt2 ~
fi_id2 fi_ic2 fi_class72 fi_addr1 fi_addr2 fi_addr3 fi_addr4 RECT-337 ~
RECT-338 RECT-462 RECT-466 
&Scoped-Define DISPLAYED-OBJECTS fi_policy fi_eng_no ra_poltyp fi_acctype ~
fi_acccovsum fi_accprem fi_inspect fi_quoteno fi_covcodcd fi_polsystem ~
fi_trndat fi_userid fi_confirmdate fi_engcount fi_eng_no3 fi_eng_no2 ~
fi_eng_no5 fi_eng_no4 fi_brand2 fi_typsale fi_bev fi_campaign fi_imginspec ~
fi_driv1 fi_birth1 fi_driv2 fi_birth2 fi_ID1 fi_occup1 fi_IC1 fi_occup2 ~
fi_driv3 fi_birth3 fi_id3 fi_occup3 fi_ic3 fi_driv4 fi_birth4 fi_id4 ~
fi_occup4 fi_ic4 fi_driv5 fi_birth5 fi_id5 fi_occup5 fi_ic5 fi_receipt ~
fi_receiptid70 fi_receiptidbr fi_receiptid72 fi_receiptidbr72 fi_receipt2 ~
fi_id2 fi_ic2 fi_class72 fi_addr1 fi_addr2 fi_addr3 fi_addr4 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bu_car 
     LABEL "Page 1" 
     SIZE 14.5 BY 1.14
     BGCOLOR 7 FGCOLOR 4 FONT 6.

DEFINE BUTTON bu_exit 
     LABEL "Exit" 
     SIZE 8 BY .81
     FONT 6.

DEFINE BUTTON bu_save 
     LABEL "Save" 
     SIZE 8 BY .81
     FONT 6.

DEFINE VARIABLE fi_acccovsum AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 15.67 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_accprem AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 11 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_acctype AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 5.33 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_addr1 AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 50 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 1 NO-UNDO.

DEFINE VARIABLE fi_addr2 AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 52.5 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_addr3 AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 50 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 1 NO-UNDO.

DEFINE VARIABLE fi_addr4 AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 52 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_bev AS CHARACTER FORMAT "X(5)":U 
     VIEW-AS FILL-IN 
     SIZE 5.67 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_birth1 AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 13 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_birth2 AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 13 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_birth3 AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 13 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_birth4 AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 13 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_birth5 AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 13 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_brand2 AS CHARACTER FORMAT "X(70)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_campaign AS CHARACTER FORMAT "X(55)":U 
     VIEW-AS FILL-IN 
     SIZE 14.33 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_class72 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 6.33 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_confirmdate AS DATE FORMAT "99/99/9999":U 
     LABEL "CFRM" 
     VIEW-AS FILL-IN 
     SIZE 13 BY .95
     BGCOLOR 10 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_covcodcd AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 14.67 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_driv1 AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 27.5 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_driv2 AS CHARACTER FORMAT "X(150)":U 
     VIEW-AS FILL-IN 
     SIZE 27.5 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_driv3 AS CHARACTER FORMAT "X(150)":U 
     VIEW-AS FILL-IN 
     SIZE 27.5 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_driv4 AS CHARACTER FORMAT "X(150)":U 
     VIEW-AS FILL-IN 
     SIZE 27.5 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_driv5 AS CHARACTER FORMAT "X(150)":U 
     VIEW-AS FILL-IN 
     SIZE 27.5 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_engcount AS INTEGER FORMAT "->>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 5.5 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_eng_no AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 45.67 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_eng_no2 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 42.5 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_eng_no3 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 45.67 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_eng_no4 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 42.5 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_eng_no5 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 43.17 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_IC1 AS CHARACTER FORMAT "X(13)":U 
     VIEW-AS FILL-IN 
     SIZE 16.33 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_ic2 AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 16.33 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_ic3 AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 16.33 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_ic4 AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 16.33 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_ic5 AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 16.33 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_ID1 AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 14.33 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_id2 AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 14.33 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_id3 AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 14.33 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_id4 AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 14.33 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_id5 AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 14.33 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_imginspec AS CHARACTER FORMAT "X(5)":U 
     VIEW-AS FILL-IN 
     SIZE 5.33 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_inspect AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 6.17 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_occup1 AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 19.17 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_occup2 AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 19.17 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_occup3 AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 19.17 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_occup4 AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 19.17 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_occup5 AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 19.17 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_policy AS CHARACTER FORMAT "X(26)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_polsystem AS CHARACTER FORMAT "X(26)":U 
     VIEW-AS FILL-IN 
     SIZE 17 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_quoteno AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 18.83 BY .86
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_receipt AS CHARACTER FORMAT "X(150)":U 
     VIEW-AS FILL-IN 
     SIZE 41.83 BY .86
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_receipt2 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 43.67 BY .86
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_receiptid70 AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 18.5 BY .86
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_receiptid72 AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 18.67 BY .86
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_receiptidbr AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 21.33 BY .86
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_receiptidbr72 AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 21.5 BY .86
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_trndat AS DATE FORMAT "99/99/9999":U 
     LABEL "IMP" 
     VIEW-AS FILL-IN 
     SIZE 14 BY .95
     BGCOLOR 10 FGCOLOR 4 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_typsale AS CHARACTER FORMAT "X(55)":U 
     VIEW-AS FILL-IN 
     SIZE 14.33 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_userid AS CHARACTER FORMAT "X(10)":U 
     LABEL "User" 
     VIEW-AS FILL-IN 
     SIZE 9 BY .95
     BGCOLOR 7 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE ra_poltyp AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "New", 1,
"Renew", 2
     SIZE 19.5 BY .95
     BGCOLOR 10 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-337
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 11.5 BY 1.33
     BGCOLOR 4 .

DEFINE RECTANGLE RECT-338
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 11.17 BY 1.33
     BGCOLOR 2 FGCOLOR 0 .

DEFINE RECTANGLE RECT-462
     EDGE-PIXELS 2 GRAPHIC-EDGE    ROUNDED 
     SIZE 131.33 BY 18.14
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-466
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 17 BY 1.67
     BGCOLOR 5 FGCOLOR 7 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     fi_policy AT ROW 1.62 COL 39.17 COLON-ALIGNED NO-LABEL
     fi_eng_no AT ROW 9.19 COL 16.83 COLON-ALIGNED NO-LABEL
     bu_save AT ROW 21.95 COL 92.83
     ra_poltyp AT ROW 1.57 COL 3 NO-LABEL
     bu_exit AT ROW 21.95 COL 103.5
     fi_acctype AT ROW 11.38 COL 77.5 COLON-ALIGNED NO-LABEL WIDGET-ID 28
     fi_acccovsum AT ROW 12.38 COL 16.83 COLON-ALIGNED NO-LABEL WIDGET-ID 30
     fi_accprem AT ROW 12.43 COL 50.5 COLON-ALIGNED NO-LABEL WIDGET-ID 32
     fi_inspect AT ROW 11.38 COL 105.67 COLON-ALIGNED NO-LABEL WIDGET-ID 34
     fi_quoteno AT ROW 12.48 COL 74 COLON-ALIGNED NO-LABEL WIDGET-ID 36
     fi_covcodcd AT ROW 12.43 COL 113.83 COLON-ALIGNED NO-LABEL WIDGET-ID 38
     fi_polsystem AT ROW 1.62 COL 75.67 COLON-ALIGNED NO-LABEL WIDGET-ID 46
     fi_trndat AT ROW 21.95 COL 11 COLON-ALIGNED WIDGET-ID 52
     fi_userid AT ROW 21.95 COL 57 COLON-ALIGNED WIDGET-ID 54
     fi_confirmdate AT ROW 21.95 COL 35.33 COLON-ALIGNED WIDGET-ID 50
     fi_engcount AT ROW 8.14 COL 70.17 COLON-ALIGNED NO-LABEL WIDGET-ID 56
     fi_eng_no3 AT ROW 10.24 COL 16.83 COLON-ALIGNED NO-LABEL WIDGET-ID 60
     fi_eng_no2 AT ROW 9.24 COL 77.5 COLON-ALIGNED NO-LABEL WIDGET-ID 64
     fi_eng_no5 AT ROW 11.29 COL 16.83 COLON-ALIGNED NO-LABEL WIDGET-ID 72
     fi_eng_no4 AT ROW 10.24 COL 77.5 COLON-ALIGNED NO-LABEL WIDGET-ID 76
     fi_brand2 AT ROW 8.14 COL 17 COLON-ALIGNED NO-LABEL WIDGET-ID 178
     fi_typsale AT ROW 13.43 COL 17 COLON-ALIGNED NO-LABEL WIDGET-ID 184
     fi_bev AT ROW 13.48 COL 52.5 COLON-ALIGNED NO-LABEL WIDGET-ID 188
     fi_campaign AT ROW 13.43 COL 71.5 COLON-ALIGNED NO-LABEL WIDGET-ID 192
     fi_imginspec AT ROW 13.48 COL 120.17 COLON-ALIGNED NO-LABEL WIDGET-ID 196
     bu_car AT ROW 21.91 COL 115.5 WIDGET-ID 210
     fi_driv1 AT ROW 14.62 COL 17.5 COLON-ALIGNED NO-LABEL WIDGET-ID 176
     fi_birth1 AT ROW 14.67 COL 50 COLON-ALIGNED NO-LABEL WIDGET-ID 212
     fi_driv2 AT ROW 15.62 COL 17.5 COLON-ALIGNED NO-LABEL WIDGET-ID 216
     fi_birth2 AT ROW 15.67 COL 50 COLON-ALIGNED NO-LABEL WIDGET-ID 214
     fi_ID1 AT ROW 14.57 COL 94.33 COLON-ALIGNED NO-LABEL WIDGET-ID 88
     fi_occup1 AT ROW 14.57 COL 71.33 COLON-ALIGNED NO-LABEL WIDGET-ID 90
     fi_IC1 AT ROW 14.57 COL 112.67 COLON-ALIGNED NO-LABEL WIDGET-ID 92
     fi_occup2 AT ROW 15.57 COL 71.33 COLON-ALIGNED NO-LABEL WIDGET-ID 104
     fi_driv3 AT ROW 16.62 COL 17.5 COLON-ALIGNED NO-LABEL WIDGET-ID 118
     fi_birth3 AT ROW 16.67 COL 50 COLON-ALIGNED NO-LABEL WIDGET-ID 112
     fi_id3 AT ROW 16.62 COL 94.33 COLON-ALIGNED NO-LABEL WIDGET-ID 114
     fi_occup3 AT ROW 16.62 COL 71.33 COLON-ALIGNED NO-LABEL WIDGET-ID 120
     fi_ic3 AT ROW 16.62 COL 112.67 COLON-ALIGNED NO-LABEL WIDGET-ID 116
     fi_driv4 AT ROW 17.62 COL 17.5 COLON-ALIGNED NO-LABEL WIDGET-ID 138
     fi_birth4 AT ROW 17.67 COL 50 COLON-ALIGNED NO-LABEL WIDGET-ID 132
     fi_id4 AT ROW 17.62 COL 94.33 COLON-ALIGNED NO-LABEL WIDGET-ID 134
     fi_occup4 AT ROW 17.62 COL 71.33 COLON-ALIGNED NO-LABEL WIDGET-ID 140
     fi_ic4 AT ROW 17.62 COL 112.67 COLON-ALIGNED NO-LABEL WIDGET-ID 136
     fi_driv5 AT ROW 18.62 COL 17.5 COLON-ALIGNED NO-LABEL WIDGET-ID 158
     fi_birth5 AT ROW 18.67 COL 50 COLON-ALIGNED NO-LABEL WIDGET-ID 152
     fi_id5 AT ROW 18.62 COL 94.33 COLON-ALIGNED NO-LABEL WIDGET-ID 154
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1.5 ROW 1.1
         SIZE 133 BY 26.19
         BGCOLOR 19 FGCOLOR 1 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     fi_occup5 AT ROW 18.62 COL 71.33 COLON-ALIGNED NO-LABEL WIDGET-ID 160
     fi_ic5 AT ROW 18.62 COL 112.67 COLON-ALIGNED NO-LABEL WIDGET-ID 156
     fi_receipt AT ROW 3.62 COL 18.33 COLON-ALIGNED NO-LABEL WIDGET-ID 226
     fi_receiptid70 AT ROW 3.62 COL 73.83 COLON-ALIGNED NO-LABEL WIDGET-ID 228
     fi_receiptidbr AT ROW 3.62 COL 102.67 COLON-ALIGNED NO-LABEL WIDGET-ID 232
     fi_receiptid72 AT ROW 5.76 COL 73.83 COLON-ALIGNED NO-LABEL WIDGET-ID 230
     fi_receiptidbr72 AT ROW 5.76 COL 103 COLON-ALIGNED NO-LABEL WIDGET-ID 234
     fi_receipt2 AT ROW 5.76 COL 18.33 COLON-ALIGNED NO-LABEL WIDGET-ID 4
     fi_id2 AT ROW 15.62 COL 94.33 COLON-ALIGNED NO-LABEL WIDGET-ID 248
     fi_ic2 AT ROW 15.62 COL 112.67 COLON-ALIGNED NO-LABEL WIDGET-ID 246
     fi_class72 AT ROW 8.19 COL 43.5 COLON-ALIGNED NO-LABEL WIDGET-ID 172
     fi_addr1 AT ROW 4.62 COL 18.33 COLON-ALIGNED NO-LABEL WIDGET-ID 264
     fi_addr2 AT ROW 4.62 COL 77.5 COLON-ALIGNED NO-LABEL WIDGET-ID 266
     fi_addr3 AT ROW 6.76 COL 18.33 COLON-ALIGNED NO-LABEL WIDGET-ID 274
     fi_addr4 AT ROW 6.76 COL 77.5 COLON-ALIGNED NO-LABEL WIDGET-ID 276
     "Birth":30 VIEW-AS TEXT
          SIZE 4.5 BY .95 AT ROW 18.67 COL 47.5 WIDGET-ID 164
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "IC :":30 VIEW-AS TEXT
          SIZE 3.5 BY .95 AT ROW 16.62 COL 110.83 WIDGET-ID 122
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "Driver name4 :":30 VIEW-AS TEXT
          SIZE 14.67 BY .95 AT ROW 17.62 COL 4.5 WIDGET-ID 142
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "Acces. Y/N :":30 VIEW-AS TEXT
          SIZE 12.5 BY .95 AT ROW 11.38 COL 66.5 WIDGET-ID 16
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "รหัส พรบ :":30 VIEW-AS TEXT
          SIZE 10.33 BY .95 AT ROW 8.14 COL 35 WIDGET-ID 174
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "Birth":30 VIEW-AS TEXT
          SIZE 4.5 BY .95 AT ROW 15.67 COL 47.5 WIDGET-ID 222
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "IC :":30 VIEW-AS TEXT
          SIZE 3.5 BY .95 AT ROW 17.62 COL 110.83 WIDGET-ID 150
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " Engine no.4 :":35 VIEW-AS TEXT
          SIZE 13.5 BY .95 AT ROW 10.24 COL 65.67 WIDGET-ID 78
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "IC :":30 VIEW-AS TEXT
          SIZE 3.5 BY .95 AT ROW 14.57 COL 110.83 WIDGET-ID 98
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "Driver name2 :":30 VIEW-AS TEXT
          SIZE 14.67 BY .95 AT ROW 15.62 COL 4.5 WIDGET-ID 220
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "Occup :":30 VIEW-AS TEXT
          SIZE 8 BY .95 AT ROW 17.62 COL 65.33 WIDGET-ID 146
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "Type of Insurance :":30 VIEW-AS TEXT
          SIZE 18.83 BY .95 AT ROW 12.43 COL 96.5 WIDGET-ID 26
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "Occup :":30 VIEW-AS TEXT
          SIZE 8 BY .95 AT ROW 14.57 COL 65.33 WIDGET-ID 94
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "Driver name3 :":30 VIEW-AS TEXT
          SIZE 14.67 BY .95 AT ROW 16.62 COL 4.5 WIDGET-ID 124
          BGCOLOR 19 FGCOLOR 1 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1.5 ROW 1.1
         SIZE 133 BY 26.19
         BGCOLOR 19 FGCOLOR 1 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "Occup :":30 VIEW-AS TEXT
          SIZE 8 BY .95 AT ROW 16.62 COL 65.33 WIDGET-ID 128
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "ส่งรูปแทนการตรวจสภาพ Y/N :":30 VIEW-AS TEXT
          SIZE 27.83 BY .95 AT ROW 13.48 COL 93.83 WIDGET-ID 198
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "ID:":30 VIEW-AS TEXT
          SIZE 3.5 BY .95 AT ROW 17.62 COL 92.67 WIDGET-ID 148
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "ID:":30 VIEW-AS TEXT
          SIZE 3.5 BY .95 AT ROW 14.57 COL 92.67 WIDGET-ID 96
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "ID:":30 VIEW-AS TEXT
          SIZE 3.5 BY .95 AT ROW 16.62 COL 92.67 WIDGET-ID 130
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "Occup :":30 VIEW-AS TEXT
          SIZE 8 BY .95 AT ROW 15.57 COL 65.33 WIDGET-ID 106
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "Receipt Name72 :":30 VIEW-AS TEXT
          SIZE 17 BY .86 AT ROW 5.76 COL 3 WIDGET-ID 6
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " ID72br :":30 VIEW-AS TEXT
          SIZE 9 BY .86 AT ROW 5.76 COL 95.17 WIDGET-ID 240
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " Policy RENEW :":35 VIEW-AS TEXT
          SIZE 17 BY .95 AT ROW 1.62 COL 23.67
          BGCOLOR 2 FGCOLOR 7 FONT 6
     "Addr1_Rec70  :":30 VIEW-AS TEXT
          SIZE 14.83 BY .95 AT ROW 4.62 COL 4.83 WIDGET-ID 268
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "Addr2 :":30 VIEW-AS TEXT
          SIZE 8.17 BY .95 AT ROW 4.62 COL 71.33 WIDGET-ID 270
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "Driver name5 :":30 VIEW-AS TEXT
          SIZE 14.67 BY .95 AT ROW 18.62 COL 4.5 WIDGET-ID 162
          BGCOLOR 19 FGCOLOR 1 FONT 6
     " ID 72 :":30 VIEW-AS TEXT
          SIZE 7 BY .86 AT ROW 5.76 COL 67.5 WIDGET-ID 236
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "ID:":30 VIEW-AS TEXT
          SIZE 3.5 BY .95 AT ROW 15.62 COL 92.67 WIDGET-ID 252
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "Inspection Y/N :":30 VIEW-AS TEXT
          SIZE 16.5 BY .86 AT ROW 11.38 COL 90.83 WIDGET-ID 22
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "Receipt Name70 :":30 VIEW-AS TEXT
          SIZE 17.17 BY .86 AT ROW 3.62 COL 2.33 WIDGET-ID 242
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " ID70br :":30 VIEW-AS TEXT
          SIZE 8.5 BY .86 AT ROW 3.62 COL 95.33 WIDGET-ID 244
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "Addr1_Rec72  :":30 VIEW-AS TEXT
          SIZE 14.83 BY .95 AT ROW 6.76 COL 4.83 WIDGET-ID 278
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "Addr2 :":30 VIEW-AS TEXT
          SIZE 8.17 BY .95 AT ROW 6.76 COL 71.33 WIDGET-ID 280
          BGCOLOR 19 FGCOLOR 1 FONT 6
     " Engine no.5 :":35 VIEW-AS TEXT
          SIZE 13.67 BY .95 AT ROW 11.29 COL 4.83 WIDGET-ID 74
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "IC :":30 VIEW-AS TEXT
          SIZE 3.5 BY .95 AT ROW 18.62 COL 110.83 WIDGET-ID 170
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "ID:":30 VIEW-AS TEXT
          SIZE 3.5 BY .95 AT ROW 18.62 COL 92.67 WIDGET-ID 168
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "IC :":30 VIEW-AS TEXT
          SIZE 3.5 BY .95 AT ROW 15.62 COL 110.83 WIDGET-ID 250
          BGCOLOR 19 FGCOLOR 0 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1.5 ROW 1.1
         SIZE 133 BY 26.19
         BGCOLOR 19 FGCOLOR 1 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "จำนวนเลขเครื่อง :":30 VIEW-AS TEXT
          SIZE 16.5 BY .95 AT ROW 8.14 COL 55.5 WIDGET-ID 58
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " Engine no.3 :":35 VIEW-AS TEXT
          SIZE 14.17 BY 1 AT ROW 10.19 COL 4.83 WIDGET-ID 62
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "Acces. cover :":30 VIEW-AS TEXT
          SIZE 14.17 BY .95 AT ROW 12.33 COL 4.5 WIDGET-ID 18
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "Birth":30 VIEW-AS TEXT
          SIZE 4.5 BY .95 AT ROW 17.67 COL 47.5 WIDGET-ID 144
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " Engine no.2 :":35 VIEW-AS TEXT
          SIZE 13.67 BY .95 AT ROW 9.24 COL 65.5 WIDGET-ID 66
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "ช่องทางการขาย :":30 VIEW-AS TEXT
          SIZE 14.83 BY .95 AT ROW 13.43 COL 4 WIDGET-ID 186
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "รถยนต์ไฟฟ้า Y/N :":30 VIEW-AS TEXT
          SIZE 17.5 BY .95 AT ROW 13.48 COL 36.67 WIDGET-ID 190
          BGCOLOR 19 FGCOLOR 6 FONT 6
     "Birth":30 VIEW-AS TEXT
          SIZE 4.5 BY .95 AT ROW 14.67 COL 47.5 WIDGET-ID 218
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "Birth":30 VIEW-AS TEXT
          SIZE 4.5 BY .95 AT ROW 16.67 COL 47.5 WIDGET-ID 126
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "แคมเปญ :":30 VIEW-AS TEXT
          SIZE 9 BY .95 AT ROW 13.38 COL 64.17 WIDGET-ID 194
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "Driver name1 :":30 VIEW-AS TEXT
          SIZE 14.67 BY .95 AT ROW 14.62 COL 4.5 WIDGET-ID 224
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "Acces. premium :":30 VIEW-AS TEXT
          SIZE 16.33 BY .95 AT ROW 12.43 COL 35.5 WIDGET-ID 20
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "      ID 70  :":30 VIEW-AS TEXT
          SIZE 11.67 BY .86 AT ROW 3.62 COL 63.5 WIDGET-ID 238
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "Quote. no :":30 VIEW-AS TEXT
          SIZE 11 BY .86 AT ROW 12.48 COL 64.5 WIDGET-ID 24
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "Occup :":30 VIEW-AS TEXT
          SIZE 8 BY .95 AT ROW 18.62 COL 65.33 WIDGET-ID 166
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "        Brand :":30 VIEW-AS TEXT
          SIZE 12.33 BY .95 AT ROW 8.29 COL 6
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "         Policy  NEW :":35 VIEW-AS TEXT
          SIZE 19.5 BY .95 AT ROW 1.62 COL 57.17 WIDGET-ID 48
          BGCOLOR 2 FGCOLOR 7 FONT 6
     " Engine no.1 :":35 VIEW-AS TEXT
          SIZE 13.67 BY .95 AT ROW 9.19 COL 5
          BGCOLOR 19 FGCOLOR 2 FONT 6
     RECT-337 AT ROW 21.71 COL 101.67
     RECT-338 AT ROW 21.71 COL 91
     RECT-462 AT ROW 2.86 COL 1.67 WIDGET-ID 262
     RECT-466 AT ROW 21.67 COL 114.17 WIDGET-ID 272
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1.5 ROW 1.1
         SIZE 133 BY 26.19
         BGCOLOR 19 FGCOLOR 1 .


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
         HEIGHT             = 26.71
         WIDTH              = 133.67
         MAX-HEIGHT         = 33.91
         MAX-WIDTH          = 213.33
         VIRTUAL-HEIGHT     = 33.91
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
/* SETTINGS FOR FILL-IN fi_confirmdate IN FRAME fr_main
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


&Scoped-define SELF-NAME bu_car
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_car C-Win
ON CHOOSE OF bu_car IN FRAME fr_main /* Page 1 */
DO:
     nv_recidtlt  =  Recid(tlt).

        {&WINDOW-NAME}:hidden  =  Yes. 
        
        Run  wgw\wgwqtis2(Input  nv_recidtlt).
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
                /* comment by : A67-0114...
                Assign
                    tlt.nor_noti_ins = Input  fi_polsystem
                    tlt.flag         = If  Input  ra_poltyp  =  1  Then  "N" Else  "R"
                    /*tlt.sentcnt      = Input  fi_difprm*/
                   /* tlt.ins_name     = Trim(Input  fi_firstname) + " "  + Trim(Input  fi_lastname)
                    tlt.rec_name     = Trim(Input  fi_title)
                    tlt.ins_addr1    = Input fi_addr1
                    tlt.ins_addr2    = Input fi_addr2
                    tlt.rec_addr3    = INPUT fi_pro_off 
                    tlt.rec_addr4    = INPUT fi_cmrcode
                    tlt.subins       = INPUT fi_ins_comp
                    tlt.nor_noti_tlt = INPUT fi_notno*/
                    tlt.lince2       = INPUT fi_year
                    tlt.colorcod     = INPUT fi_color
                    tlt.nor_coamt    = INPUT fi_sumsi
                    tlt.comp_coamt   = INPUT fi_gross_amt
                    tlt.nor_grprm    = INPUT fi_prem1     
                    tlt.comp_grprm   = INPUT fi_compprm   
                   /* tlt.nor_usr_ins  = INPUT fi_ins_off
                    tlt.nor_usr_tlt  = INPUT fi_not_off  
                    tlt.datesent     = INPUT fi_notdat
                    tlt.gentim       = INPUT fi_nottim
                    tlt.comp_usr_tlt = INPUT fi_notcode 
                    tlt.rec_addr2    = INPUT fi_preinsur 
                    tlt.safe3        = INPUT fi_client  
                    tlt.safe2        = INPUT fi_accno     */ 
                    /*tlt.filler2      = trim(Input fi_remark1) + trim(Input  fi_remark2)*//*kridtiya i. A54-0216*/
                    tlt.filler2      = trim(Input fi_remark1) + 
                                      ( IF trim(Input  fi_remark2) <> "" THEN " r2:" + trim(Input  fi_remark2) ELSE " r2: " )  +  /*kridtiya i. A54-0216*/
                                      ( IF trim(Input  fi_remark3) <> "" THEN " r3:" + trim(Input  fi_remark3) ELSE " r3: " )  +  /*kridtiya i. A56-0323*/
                                      /*( IF trim(Input  fi_remark4) <> "" THEN " r4:" + trim(Input  fi_remark4) ELSE " r4: " )     /*A63-0210*/ */ /*A64-0092*/
                                       " acc:" + TRIM(fi_acc1) + " " + TRIM(fi_acc2)   /*A64-0092*/
                    /*tlt.comp_usr_ins = trim(Input fi_remark4)  /*A63-0210*/*/
                   /* tlt.comp_usr_ins = fi_receipt2   */
                    tlt.filler1      = Input fi_policy  
                    tlt.lince2       = Input fi_year    
                    tlt.eng_no       = Input fi_eng_no  
                    tlt.cha_no       = Input fi_cha_no  
                    tlt.cc_weight    = Input fi_ton     
                    tlt.rencnt       = Input fi_power   
                    tlt.lince1       = Input fi_licence 
                    tlt.stat         = Input fi_garage  
                    tlt.lince3       = Input fi_province
                    tlt.brand        = Input fi_brand 
                    /*tlt.comp_sck     = Input fi_sckno */ /*A60-0095*/
                    tlt.comp_sck     = IF LENGTH(Input fi_sckno) <> 13 THEN "0" + INPUT fi_sckno ELSE INPUT fi_sckno 
                    tlt.endno        = STRING(Input  fi_deduct)
                    tlt.lotno        = STRING(Input  fi_fleetper)
                    tlt.seqno        = Input fi_ncbper 
                    tlt.endcnt       = Input fi_othper 
                    tlt.model        = Input fi_vehuse 
                    tlt.gendat       = Input fi_comdat 
                    tlt.expodat      = Input fi_expdat 
                    /*tlt.rec_name     = Input fi_title   
                    tlt.ins_addr1    = Input fi_addr1   
                    tlt.ins_addr2    = Input fi_addr2   
                    tlt.safe1        = Input fi_benname */
                    /*tlt.model        = INPUT fi_vehuse*/ /*A60-0118*/  
                    tlt.model        = "ISP:" + INPUT fi_inspno /*A60-0118*/  
                    tlt.model        = IF INPUT fi_detailisp <> "" THEN "ISP:" + INPUT fi_inspno + " " + "Detail:" + INPUT fi_detailisp ELSE "ISP:" + INPUT fi_inspno  /*A60-0118*/  
                   /* tlt.recac        = INPUT fi_accno2   */    
                    tlt.EXP          = INPUT fi_branch  /*add Kridtiya i. A54-0061 On   05/04/2011*/
                    tlt.expotim      = Input fi_pack
                    tlt.old_eng      = Input fi_tp1
                    tlt.old_cha      = Input fi_tp2
                    tlt.comp_pol     = Input fi_tp3
                   /* tlt.dri_name1    = INPUT fi_driv1
                    tlt.dri_name2    = INPUT fi_driv2
                    tlt.dri_no1      = string(INPUT fi_birth1,"99/99/9999")
                    tlt.dri_no2      = string(INPUT fi_birth2,"99/99/9999")*/
                    tlt.expousr      = Input fi_covcod 
                   /* tlt.ins_addr3    = INPUT fi_addr70
                    tlt.ins_addr4    = Input fi_addr72*/
                    tlt.sentcnt      = fi_seatnew       /*A57-0017*/ 
                    /*tlt.ins_addr5     = trim(wdetail.apptyp)
                    tlt.comp_noti_tlt = trim(wdetail.appcode) */
                    /*tlt.usrsent       = wdetail.nBLANK */
                   /* tlt.comp_usr_tlt  = "ID70:"    + trim(fi_receiptid70)   + /*A57-0262*/ 
                                        "ID70br:"  + trim(fi_receiptidbr) + /*A57-0262*/
                                        "ID72:"    + trim(fi_receiptid72)   + /*A57-0262*/  
                                        "ID72br:"  + trim(fi_receiptidbr72)   /*A57-0262*/
                    tlt.comp_sub      = INPUT fi_producer           
                    tlt.comp_noti_ins = INPUT fi_agent            
                    tlt.rec_addr1     = INPUT fi_receipt*/
                    /*--- A60-0095 ----*/
                    SUBSTR(tlt.model,51,15) = STRING(INPUT fi_sumfi)  
                    tlt.nor_effdat          = INPUT fi_72comdat    
                    tlt.comp_effdat         = INPUT fi_72expdat 
                    SUBSTR(tlt.expotim,6,3) = STRING(INPUT fi_class )  
                    SUBSTR(tlt.expousr,7,3) = STRING(INPUT fi_caruse) 
                    tlt.usrsent             = INPUT fi_susspect      /*A63-00472*/
                    tlt.covcod   = trim(fi_covcodcd)   /*A65-0356*/ 
                    tlt.note1    = trim(fi_acctype)    /*A65-0356*/ 
                    tlt.note2    = trim(fi_acccovsum)  /*A65-0356*/ 
                    tlt.note3    = trim(fi_accprem)    /*A65-0356*/ 
                    tlt.note4    = trim(fi_inspect)    /*A65-0356*/ 
                    tlt.note5    = trim(fi_quoteno)    /*A65-0356*/ 
                    /*tlt.note6    = trim(fi_policy2yGWM) */ .
                    /*---end A60-0095---*/
                    ....end A67-0114...*/
                Assign
                   tlt.nor_noti_ins = Input  fi_polsystem
                   tlt.flag         = If  Input  ra_poltyp  =  1  Then  "N" Else  "R"
                   tlt.filler1      = trim(Input fi_policy)
                   tlt.rec_addr1    = trim(INPUT fi_receipt)  
                   tlt.comp_usr_ins = trim(INPUT fi_receipt2) + "a1:" + TRIM(fi_addr3) + "a2:" + TRIM(fi_addr4)       
                   tlt.comp_usr_tlt = "ID70:"    + trim(fi_receiptid70)   + 
                                      "ID70br:"  + trim(fi_receiptidbr) +   
                                      "ID72:"    + trim(fi_receiptid72)   + 
                                      "ID72br:"  + trim(fi_receiptidbr72)
                   tlt.ins_addr1 = trim(fi_addr1)   
                   tlt.ins_addr2 = trim(fi_addr2)   
                   tlt.covcod   = trim(fi_covcodcd)  
                   tlt.note1    = trim(fi_acctype)   
                   tlt.note2    = trim(fi_acccovsum) 
                   tlt.note3    = trim(fi_accprem)   
                   tlt.note4    = trim(fi_inspect)   
                   tlt.note5    = trim(fi_quoteno) 
                   tlt.ndeci1   = fi_engcount 
                   tlt.eng_no2  = trim(fi_eng_no2)  
                   tlt.note9    = trim(fi_eng_no3)  
                   tlt.note10   = trim(fi_eng_no4)  
                   tlt.note11   = trim(fi_eng_no5)  
                   tlt.subclass = trim(fi_class72)  
                   tlt.car_type = trim(fi_brand2)   
                   tlt.note7    = trim(fi_typsale)  
                   tlt.note8    = trim(fi_bev)      
                   tlt.campaign = trim(fi_campaign) 
                   tlt.ispflg   = trim(fi_imginspec) 
                   tlt.dri_name1   = trim(INPUT fi_driv1) 
                   tlt.dri_name2   = trim(INPUT fi_driv2) 
                   tlt.dri_name3   = trim(INPUT fi_driv3) 
                   tlt.dri_name4   = trim(INPUT fi_driv4) 
                   tlt.dri_name5   = trim(INPUT fi_driv5) 
                   tlt.dri_no1     = trim(INPUT fi_birth1)
                   tlt.dri_no2     = trim(INPUT fi_birth2)
                   tlt.dri_no3     = trim(INPUT fi_birth3)
                   tlt.dri_no4     = trim(INPUT fi_birth4)
                   tlt.dri_no5     = trim(INPUT fi_birth5)
                   tlt.dir_occ1    = trim(INPUT fi_occup1)
                   tlt.dri_occ2    = trim(INPUT fi_occup2)
                   tlt.dir_occ3    = trim(INPUT fi_occup3)
                   tlt.dri_occ4    = trim(INPUT fi_occup4)
                   tlt.dri_occ5    = trim(INPUT fi_occup5)
                   tlt.dri_lic1    = trim(INPUT fi_id1)   
                   tlt.dri_lic2    = trim(INPUT fi_id2)   
                   tlt.dri_lic3    = trim(INPUT fi_id3)   
                   tlt.dri_lic4    = trim(INPUT fi_id4)   
                   tlt.dri_lic5    = trim(INPUT fi_id5)   
                   tlt.dri_ic1     = trim(INPUT fi_ic1)   
                   tlt.dri_ic2     = trim(INPUT fi_ic2)   
                   tlt.dri_ic3     = trim(INPUT fi_ic3)   
                   tlt.dri_ic4     = trim(INPUT fi_ic4)   
                   tlt.dri_ic5     = trim(INPUT fi_ic5)  . 
                   /*....end A67-0114...*/
            END.                                                    
            Apply "Close" to this-procedure.
            Return no-apply.
            /* APPLY "entry" TO fi_branch.
            RETURN NO-APPLY. */
        END.
        WHEN FALSE THEN /* No */          
            DO:   
            APPLY "entry" TO fi_receipt.
            RETURN NO-APPLY.
        END.
        /*OTHERWISE /* Cancel */             
        STOP.*/
        END CASE.
Disp  fi_receipt with  frame  fr_main.
RELEASE brstat.tlt.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_acccovsum
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_acccovsum C-Win
ON LEAVE OF fi_acccovsum IN FRAME fr_main
DO:
  fi_acccovsum = INPUT fi_acccovsum.
  DISP fi_acccovsum WITH FRAM fr_main.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_accprem
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_accprem C-Win
ON LEAVE OF fi_accprem IN FRAME fr_main
DO:
  fi_accprem = INPUT fi_accprem.
  DISP fi_accprem WITH FRAM fr_main.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_acctype
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_acctype C-Win
ON LEAVE OF fi_acctype IN FRAME fr_main
DO:
  fi_acctype = INPUT fi_acctype.
  DISP fi_acctype WITH FRAM fr_main.

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


&Scoped-define SELF-NAME fi_bev
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_bev C-Win
ON LEAVE OF fi_bev IN FRAME fr_main
DO:
    fi_bev = INPUT fi_bev .
    DISP fi_bev WITH FRAM fr_main.
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


&Scoped-define SELF-NAME fi_birth3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_birth3 C-Win
ON LEAVE OF fi_birth3 IN FRAME fr_main
DO:
  fi_birth3 = INPUT fi_birth3 .
  DISP fi_birth3 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_birth4
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_birth4 C-Win
ON LEAVE OF fi_birth4 IN FRAME fr_main
DO:
  fi_birth4 = INPUT fi_birth4 .
  DISP fi_birth4 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_birth5
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_birth5 C-Win
ON LEAVE OF fi_birth5 IN FRAME fr_main
DO:
  fi_birth5 = INPUT fi_birth5 .
  DISP fi_birth5 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_brand2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_brand2 C-Win
ON LEAVE OF fi_brand2 IN FRAME fr_main
DO:
  fi_brand2 = INPUT fi_brand2 .
  DISP fi_brand2 WITH FRAM fr_main.
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


&Scoped-define SELF-NAME fi_class72
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_class72 C-Win
ON LEAVE OF fi_class72 IN FRAME fr_main
DO:
    fi_class72 = INPUT fi_class72 .
    DISP fi_class72 WITH FRAM fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_covcodcd
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_covcodcd C-Win
ON LEAVE OF fi_covcodcd IN FRAME fr_main
DO:
  fi_covcodcd = INPUT fi_covcodcd.
  DISP fi_covcodcd WITH FRAM fr_main.

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


&Scoped-define SELF-NAME fi_driv3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_driv3 C-Win
ON LEAVE OF fi_driv3 IN FRAME fr_main
DO:
  fi_driv3 = INPUT fi_driv3.
  DISP fi_driv3 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_driv4
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_driv4 C-Win
ON LEAVE OF fi_driv4 IN FRAME fr_main
DO:
  fi_driv4 = INPUT fi_driv4.
  DISP fi_driv4 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_driv5
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_driv5 C-Win
ON LEAVE OF fi_driv5 IN FRAME fr_main
DO:
  fi_driv5 = INPUT fi_driv5.
  DISP fi_driv5 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_engcount
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_engcount C-Win
ON LEAVE OF fi_engcount IN FRAME fr_main
DO:
  fi_engcount =  Input  fi_engcount.
  Disp  fi_engcount with frame  fr_main.
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


&Scoped-define SELF-NAME fi_eng_no2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_eng_no2 C-Win
ON LEAVE OF fi_eng_no2 IN FRAME fr_main
DO:
  fi_eng_no2  =  Input  fi_eng_no2.
  Disp  fi_eng_no2 with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_eng_no3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_eng_no3 C-Win
ON LEAVE OF fi_eng_no3 IN FRAME fr_main
DO:
  fi_eng_no3  =  Input  fi_eng_no3.
  Disp  fi_eng_no3 with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_eng_no4
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_eng_no4 C-Win
ON LEAVE OF fi_eng_no4 IN FRAME fr_main
DO:
  fi_eng_no4  =  Input  fi_eng_no4.
  Disp  fi_eng_no4 with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_eng_no5
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_eng_no5 C-Win
ON LEAVE OF fi_eng_no5 IN FRAME fr_main
DO:
  fi_eng_no5  =  Input  fi_eng_no5.
  Disp  fi_eng_no5 with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_IC1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_IC1 C-Win
ON LEAVE OF fi_IC1 IN FRAME fr_main
DO:
    fi_ic1 = INPUT fi_ic1 .
    DISP fi_ic1 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_ic2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_ic2 C-Win
ON LEAVE OF fi_ic2 IN FRAME fr_main
DO:
    fi_ic2 = INPUT fi_ic2 .
    DISP fi_ic2 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_ic3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_ic3 C-Win
ON LEAVE OF fi_ic3 IN FRAME fr_main
DO:
    fi_ic3 = INPUT fi_ic3 .
    DISP fi_ic3 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_ic4
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_ic4 C-Win
ON LEAVE OF fi_ic4 IN FRAME fr_main
DO:
    fi_ic4 = INPUT fi_ic4 .
    DISP fi_ic4 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_ic5
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_ic5 C-Win
ON LEAVE OF fi_ic5 IN FRAME fr_main
DO:
    fi_ic5 = INPUT fi_ic5 .
    DISP fi_ic5 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_ID1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_ID1 C-Win
ON LEAVE OF fi_ID1 IN FRAME fr_main
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


&Scoped-define SELF-NAME fi_id3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_id3 C-Win
ON LEAVE OF fi_id3 IN FRAME fr_main
DO:
    fi_id3 = INPUT fi_id3 .
    DISP fi_id3 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_id4
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_id4 C-Win
ON LEAVE OF fi_id4 IN FRAME fr_main
DO:
    fi_id4 = INPUT fi_id4 .
    DISP fi_id4 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_id5
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_id5 C-Win
ON LEAVE OF fi_id5 IN FRAME fr_main
DO:
    fi_id5 = INPUT fi_id5 .
    DISP fi_id5 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_imginspec
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_imginspec C-Win
ON LEAVE OF fi_imginspec IN FRAME fr_main
DO:
    fi_imginspec = INPUT fi_imginspec .
    DISP fi_imginspec WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_inspect
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_inspect C-Win
ON LEAVE OF fi_inspect IN FRAME fr_main
DO:
  fi_inspect = INPUT fi_inspect.
  DISP fi_inspect WITH FRAM fr_main.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_occup1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_occup1 C-Win
ON LEAVE OF fi_occup1 IN FRAME fr_main
DO:
    fi_occup1 = INPUT fi_occup1 .
    DISP fi_occup1 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_occup2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_occup2 C-Win
ON LEAVE OF fi_occup2 IN FRAME fr_main
DO:
    fi_occup2 = INPUT fi_occup2 .
    DISP fi_occup2 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_occup3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_occup3 C-Win
ON LEAVE OF fi_occup3 IN FRAME fr_main
DO:
    fi_occup3 = INPUT fi_occup3 .
    DISP fi_occup3 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_occup4
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_occup4 C-Win
ON LEAVE OF fi_occup4 IN FRAME fr_main
DO:
    fi_occup4 = INPUT fi_occup4 .
    DISP fi_occup4 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_occup5
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_occup5 C-Win
ON LEAVE OF fi_occup5 IN FRAME fr_main
DO:
    fi_occup5 = INPUT fi_occup5 .
    DISP fi_occup5 WITH FRAM fr_main.
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


&Scoped-define SELF-NAME fi_quoteno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_quoteno C-Win
ON LEAVE OF fi_quoteno IN FRAME fr_main
DO:
  fi_quoteno = INPUT fi_quoteno.
  DISP fi_quoteno WITH FRAM fr_main.

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


&Scoped-define SELF-NAME fi_receipt2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_receipt2 C-Win
ON LEAVE OF fi_receipt2 IN FRAME fr_main
DO:
  fi_receipt2 = INPUT fi_receipt2 .
  DISP fi_receipt2 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_receiptid70
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_receiptid70 C-Win
ON LEAVE OF fi_receiptid70 IN FRAME fr_main
DO:
  fi_receiptid70 = INPUT fi_receiptid70 .
  DISP fi_receiptid70 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_receiptid72
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_receiptid72 C-Win
ON LEAVE OF fi_receiptid72 IN FRAME fr_main
DO:
  fi_receiptid72 = INPUT fi_receiptid72.
  DISP fi_receiptid72 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_receiptidbr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_receiptidbr C-Win
ON LEAVE OF fi_receiptidbr IN FRAME fr_main
DO:
  fi_receiptidbr = INPUT fi_receiptidbr .
  DISP fi_receiptidbr WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_receiptidbr72
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_receiptidbr72 C-Win
ON LEAVE OF fi_receiptidbr72 IN FRAME fr_main
DO:
  fi_receiptidbr72 = INPUT fi_receiptidbr72 .
  DISP fi_receiptidbr72 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_typsale
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_typsale C-Win
ON LEAVE OF fi_typsale IN FRAME fr_main
DO:
    fi_typsale = INPUT fi_typsale .
    DISP fi_typsale WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ra_poltyp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_poltyp C-Win
ON VALUE-CHANGED OF ra_poltyp IN FRAME fr_main
DO:
  Apply "Entry" to  fi_brand2.
  Return no-apply.
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
 
  gv_prgid = "wgwqtis2".
  gv_prog  = "Query &Update Data  (Tisco  co.,ltd.) ".
  RUN  WUT\WUTHEAD ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).

/*********************************************************************/ 
 /*  RUN Wut\WutwiCen ({&WINDOW-NAME}:HANDLE). */ 
  /*CURRENT-WINDOW:WINDOW-STATE = WINDOW-MAXIMIZED.*/
  SESSION:DATA-ENTRY-RETURN = YES.
  
 /* Rect-336:Move-to-top().*/
  Rect-337:Move-to-top().
  
  /*Hide    fi_difprm  in frame  {&FRAME-NAME}.*/
  
  Find  brstat.tlt  Where   Recid(tlt)  =  nv_recidtlt NO-LOCK NO-ERROR NO-WAIT .
  If  avail  tlt  Then do:
      RUN proc_assignfi.
      /* comment by : A67-0114....
      Assign
          fi_trndat     = tlt.trndat
          fi_policy     = tlt.filler1 
          /*fi_pro_off    = tlt.rec_addr3
          fi_cmrcode    = tlt.rec_addr4
          fi_ins_comp   = tlt.subins
          fi_preinsur   = tlt.rec_addr2
          fi_notno      = tlt.nor_noti_tlt*/
          fi_year       = tlt.lince2
          fi_eng_no     = tlt.eng_no
          fi_cha_no     = tlt.cha_no
          fi_ton        = tlt.cc_weight
          fi_power      = tlt.rencnt
          fi_color      = tlt.colorcod
          fi_licence    = tlt.lince1
          fi_garage     = tlt.stat
          fi_province   = tlt.lince3
          fi_brand      = tlt.brand
          fi_sckno      = tlt.comp_sck
          fi_sumsi      = tlt.nor_coamt
          fi_gross_amt  = tlt.comp_coamt
          fi_prem1      = tlt.nor_grprm
          fi_compprm    = tlt.comp_grprm
          fi_deduct     = Integer(tlt.endno)
          fi_fleetper   = Integer(tlt.lotno)
          fi_ncbper     = tlt.seqno
          fi_othper     = tlt.endcnt
          /*fi_vehuse     = tlt.model*/ /*A60-0118*/
          fi_comdat     = tlt.gendat
          fi_expdat     = tlt.expodat
          /*fi_ins_off    = tlt.nor_usr_ins
          fi_notcode    = tlt.comp_usr_tlt
          fi_not_off    = tlt.nor_usr_tlt
          fi_notdat     = tlt.datesent
          fi_nottim     = tlt.gentim
          fi_title      = tlt.rec_name
          fi_addr1      = tlt.ins_addr1
          fi_addr2      = tlt.ins_addr2
          fi_driv1      = tlt.dri_name1
          fi_driv2      = tlt.dri_name2
          fi_birth1     = date(SUBSTR(tlt.dri_no1,1,10))
          fi_birth2     = date(SUBSTR(tlt.dri_no2,1,10))
          /*fi_agent      =  tlt.recac*/
          fi_client     =  tlt.safe3
          fi_accno      =  tlt.safe2
          fi_accno2     =  tlt.recac
          fi_receipt    =  tlt.rec_addr1
          fi_receipt2   =  IF index(tlt.comp_usr_ins,"a1:") <> 0 THEN SUBSTR(tlt.comp_usr_ins,1,INDEX(tlt.comp_usr_ins,"a1:") - 1) ELSE TRIM(tlt.comp_usr_ins)
          fi_benname    =  tlt.safe1*/
          fi_userid     =  tlt.usrid 
          fi_branch     =  tlt.EXP     /*add Kridtiya i. A54-0061 On   05/04/2011*/
          fi_pack       =  SUBSTR(tlt.expotim,1,5)  
          fi_tp1        =  tlt.old_eng  
          fi_tp2        =  tlt.old_cha  
          fi_tp3        =  tlt.comp_pol 
          fi_covcod     =  tlt.expousr  
          /*fi_addr70     =  tlt.ins_addr3
          fi_addr72     =  tlt.ins_addr4*/
          fi_seatnew    =  tlt.sentcnt     /*A57-0017*/ 
          /*tlt.ins_addr5     = trim(wdetail.apptyp)
          tlt.comp_noti_tlt = trim(wdetail.appcode) */
          /*tlt.usrsent       = wdetail.nBLANK */
          /*fi_pack       =  tlt.expotim    */              
          fi_tp1        =  tlt.old_eng                
          fi_tp2        =  tlt.old_cha                
          fi_tp3        =  tlt.comp_pol               
          fi_covcod     =  tlt.expousr                
          /*fi_producer   =  tlt.comp_sub                 
          fi_agent      =  tlt.comp_noti_ins  */        
          fi_remark1    =  IF index(tlt.filler2,"r2:") <> 0 THEN   Substr(tlt.filler2,1,index(tlt.filler2,"r2:") - 1) ELSE TRIM(tlt.filler2)
          fi_remark2    =  IF index(tlt.filler2,"r2:") <> 0 THEN   Substr(tlt.filler2,index(tlt.filler2,"r2:") + 3 ) ELSE ""
          fi_remark2    =  IF index(fi_remark2,"r3:")  <> 0 THEN   Substr(fi_remark2,1,index(fi_remark2,"r3:") - 1)  ELSE fi_remark2
          fi_remark3    =  IF index(tlt.filler2,"r3:") <> 0 THEN   Substr(tlt.filler2,index(tlt.filler2,"r3:") + 3 ) ELSE ""
          /*fi_remark3    =  IF index(fi_remark3,"r4:")  <> 0 THEN   Substr(fi_remark3,1,index(fi_remark3,"r4:") - 1 ) ELSE fi_remark3   /*A63-0210*/ */ /*A64-0092*/ 
          /*fi_remark4    =  IF index(tlt.filler2,"r4:") <> 0 THEN   Substr(tlt.filler2,index(tlt.filler2,"r4:") + 3 ) ELSE ""         /*A63-0210*/ */ /*A64-0092*/ 
          /* add by : A64-0092 */
          fi_remark3    =  IF index(fi_remark3,"r4:")   <> 0 THEN REPLACE(fi_remark3,"r4:"," ") ELSE fi_remark3   /*A64-0092*/
          fi_remark3    =  IF index(fi_remark3,"acc:")  <> 0 THEN Substr(fi_remark3,1,index(fi_remark3,"acc:") - 1 ) ELSE fi_remark3   
          nv_acc        =  IF index(tlt.filler2,"acc:") <> 0 THEN TRIM(Substr(tlt.filler2,R-INDEX(tlt.filler2,"acc:") + 4 )) 
                           ELSE IF index(tlt.filler2,"คค.") <> 0 THEN TRIM(Substr(tlt.filler2,R-INDEX(tlt.filler2,"คค."))) 
                           ELSE IF index(tlt.filler2,"||")  <> 0 THEN TRIM(Substr(tlt.filler2,R-INDEX(tlt.filler2,"||") + 2))
                           /*ELSE IF index(tlt.filler2," ")   <> 0 THEN TRIM(Substr(tlt.filler2,R-INDEX(tlt.filler2," ") + 1))*/
                           ELSE "" 
          nv_acc        =  IF INDEX(nv_acc,"r2:") <> 0 THEN REPLACE(nv_acc,"r2:","") ELSE nv_acc
          nv_acc        =  IF INDEX(nv_acc,"r3:") <> 0 THEN REPLACE(nv_acc,"r3:","") ELSE nv_acc
          nv_acc        =  IF INDEX(nv_acc,"r4:") <> 0 THEN REPLACE(nv_acc,"r4:","") ELSE nv_acc
          fi_acc1       =  IF LENGTH(nv_acc) > 110 THEN trim(SUBSTR(nv_acc,1,120)) ELSE nv_acc 
          fi_acc2       =  IF LENGTH(nv_acc) > 110 THEN trim(SUBSTR(nv_acc,121,LENGTH(nv_acc))) ELSE ""
          /* end a64-0092 */
          /*nv_index      =  Index(tlt.ins_name," ")
          fi_firstname  = Substr(tlt.ins_name,1,nv_index - 1) 
          fi_lastname   = Substr(tlt.ins_name,nv_index + 1,length(tlt.ins_name)) */
          fi_polsystem  = tlt.nor_noti_ins  
          ra_poltyp     = If tlt.flag  =  "N"  Then  1  Else 2  
          nv_chaidrep   = trim(tlt.comp_usr_tlt)
          /*A60-0118*/ 
          fi_insp       = IF INDEX(brstat.tlt.model,"Detail") <> 0 THEN "YES" ELSE "NO"                           
          fi_inspno     = IF INDEX(brstat.tlt.model,"ISP")  <> 0 AND INDEX(brstat.tlt.model,"Detail") <> 0 THEN 
                          SUBSTR(brstat.tlt.model,5,INDEX(brstat.tlt.model,"Detail") - 6 ) 
                          ELSE IF INDEX(brstat.tlt.model,"ISP")  <> 0 THEN SUBSTR(brstat.tlt.model,5,INDEX(brstat.tlt.model," ")) ELSE ""
          fi_detailisp  = IF INDEX(brstat.tlt.model,"Detail") <> 0 THEN SUBSTR(brstat.tlt.model,INDEX(brstat.tlt.model,"Detail:") + 7,INDEX(brstat.tlt.model," "))
                          ELSE ""
           /*A60-0118*/
           /*- Manop G. -*/
          /*fi_sumfi      =  INT(SUBSTR(tlt.model,51,10))*/ /*A60-0118*/
          fi_sumfi      =  INT(SUBSTR(tlt.model,51,15))     /*A60-0118*/
          fi_72comdat   =  tlt.nor_effdat           /* คุ้มครอง พรบ */    
          fi_72expdat   =  tlt.comp_effdat         /* สิ้นสุด พรบ */
          fi_class      =  SUBSTR(tlt.expotim,6,3)
          fi_caruse     =  SUBSTR(tlt.expousr,7,3)
          fi_susspect   =  tlt.usrsent          /*A63-00472*/
          fi_covcodcd   = trim(tlt.covcod)   /*A65-0356*/ 
          fi_acctype    = trim(tlt.note1)    /*A65-0356*/ 
          fi_acccovsum  = trim(tlt.note2)    /*A65-0356*/ 
          fi_accprem    = trim(tlt.note3)    /*A65-0356*/ 
          fi_inspect    = trim(tlt.note4)    /*A65-0356*/ 
          fi_quoteno    = trim(tlt.note5)   /*A65-0356*/ 
          fi_confirmdate = tlt.ndate1       /*A65-0356*/ 
          /*fi_policy2yGWM = tlt.note6 */.

  /*  ASSIGN fi_receiptidbr72 = IF index(nv_chaidrep,"ID72br:") = 0 THEN "" ELSE  /*A57-0262*/
                          trim(SUBSTR(nv_chaidrep,index(nv_chaidrep,"ID72br:") + 7 )) /*A57-0262*/
       nv_chaidrep      = IF index(nv_chaidrep,"ID72br:") = 0 THEN "" ELSE            /*A57-0262*/
           trim(SUBSTR(nv_chaidrep,1,index(nv_chaidrep,"ID72br:") - 1 )) /*A57-0262*/ 

       fi_receiptid72   = IF index(nv_chaidrep,"ID72:") = 0 THEN "" ELSE                                                           /*A57-0262*/  
                          trim(SUBSTR(nv_chaidrep,index(nv_chaidrep,"ID72:") + 5 ))  /*A57-0262*/

       nv_chaidrep      = IF index(nv_chaidrep,"ID72:") = 0 THEN "" ELSE               /*A57-0262*/
                          trim(SUBSTR(nv_chaidrep,1,index(nv_chaidrep,"ID72:") - 1 ))    /*A57-0262*/

       fi_receiptidbr   = IF index(nv_chaidrep,"ID70br:") = 0 THEN "" ELSE 
                          trim(SUBSTR(nv_chaidrep,index(nv_chaidrep,"ID70br:") + 7 ))  /*A57-0262*/ 
       nv_chaidrep      = IF index(nv_chaidrep,"ID70br:") = 0 THEN "" ELSE             /*A57-0262*/
                          trim( SUBSTR(nv_chaidrep,1,index(nv_chaidrep,"ID70br:") - 1 )) /*A57-0262*/
                          
       fi_receiptid70   = IF index(nv_chaidrep,"ID70:") = 0 THEN "" ELSE 
                             trim(SUBSTR(nv_chaidrep,index(nv_chaidrep,"ID70:") + 5 )).    /*A57-0262*/ */
/*
       ASSIGN 
           n_Rec_name72   = IF index(nv_cutrec,"Rname:") = 0 THEN "" ELSE            /*Start A63-0210*/          
                            trim(SUBSTR(nv_cutrec,index(nv_cutrec,"Rname:") + 6 ))   
           nv_cutrec      = IF index(nv_cutrec,"Rname:") = 0 THEN "" ELSE            
                            trim(SUBSTR(nv_cutrec,1,index(nv_cutrec,"Rname:") - 1 )) 
           n_Rec_add1     = IF index(nv_cutrec,"Radd1:") = 0 THEN "" ELSE            
                            trim(SUBSTR(nv_cutrec,index(nv_cutrec,"Radd1:") + 6 ))   
           nv_cutrec      = IF index(nv_cutrec,"Radd1:") = 0 THEN "" ELSE            
                            trim(SUBSTR(nv_cutrec,1,index(nv_cutrec,"Radd1:") - 1 )) 
           n_Rec_add2     = IF index(nv_cutrec,"Radd2:") = 0 THEN "" ELSE            
                            trim(SUBSTR(nv_cutrec,index(nv_cutrec,"Radd2:") + 6 ))   /*End A63-0210*/

           fi_remark4    =  TRIM(n_Rec_name72) +  TRIM(n_Rec_add1) + TRIM(n_Rec_add2) /*A63-0210*/
                                .*/
            
     Disp     fi_policy        /*fi_pro_off       fi_cmrcode */       fi_covcodcd 
              /*fi_ins_comp      fi_preinsur      fi_notno*/          fi_acctype         
              fi_year          fi_eng_no        fi_cha_no         fi_acccovsum       
              fi_ton           fi_power         fi_color          fi_accprem         
              fi_licence       fi_garage        fi_province       fi_inspect         
              fi_brand         fi_sckno         fi_sumsi          fi_quoteno  
              fi_sumfi         fi_72comdat      fi_72expdat
              fi_class         fi_caruse           /* Manop G. */ 
              fi_gross_amt     fi_prem1         fi_compprm  
              fi_deduct        fi_fleetper      fi_ncbper  
              fi_othper        fi_vehuse        fi_comdat  
              fi_expdat        /*fi_ins_off       fi_notcode*/  fi_confirmdate /*A65-0356*/
              /*fi_not_off       fi_notdat        fi_nottim */  fi_seatnew  /*A57-0017*/ 
              /*fi_title         fi_firstname     fi_lastname fi_addr70 
              fi_addr1         fi_addr2         fi_agent    fi_addr72
              fi_client        fi_accno         fi_receipt  fi_accno2*/ fi_remark3
              /*fi_benname */      fi_remark1       fi_remark2  /*fi_birth1 fi_producer*/
              fi_polsystem     ra_poltyp        fi_trndat   /*fi_birth2 fi_agent */  
              fi_userid        fi_pack          fi_tp1      /*fi_driv1  fi_driv2*/
              /*fi_receiptid70  fi_receiptidbr    fi_receiptid72  fi_receiptidbr72 */   fi_susspect   /*A63-00472*/
              fi_tp2           fi_tp3           fi_covcod   fi_branch   /*add Kridtiya i. A54-0061 On   05/04/2011*/
              fi_insp          fi_inspno        fi_detailisp       /*A60-0118*/ /*fi_remark4 /*A63-0210*/ A64-0092*/  /*fi_receipt2*/
              fi_acc1          fi_acc2         /* fi_policy2yGWM */    /*A64-0092*/
      With frame  fr_main.               
   ...end A67-0114..*/
          
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
  DISPLAY fi_policy fi_eng_no ra_poltyp fi_acctype fi_acccovsum fi_accprem 
          fi_inspect fi_quoteno fi_covcodcd fi_polsystem fi_trndat fi_userid 
          fi_confirmdate fi_engcount fi_eng_no3 fi_eng_no2 fi_eng_no5 fi_eng_no4 
          fi_brand2 fi_typsale fi_bev fi_campaign fi_imginspec fi_driv1 
          fi_birth1 fi_driv2 fi_birth2 fi_ID1 fi_occup1 fi_IC1 fi_occup2 
          fi_driv3 fi_birth3 fi_id3 fi_occup3 fi_ic3 fi_driv4 fi_birth4 fi_id4 
          fi_occup4 fi_ic4 fi_driv5 fi_birth5 fi_id5 fi_occup5 fi_ic5 fi_receipt 
          fi_receiptid70 fi_receiptidbr fi_receiptid72 fi_receiptidbr72 
          fi_receipt2 fi_id2 fi_ic2 fi_class72 fi_addr1 fi_addr2 fi_addr3 
          fi_addr4 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE fi_policy fi_eng_no bu_save ra_poltyp bu_exit fi_acctype fi_acccovsum 
         fi_accprem fi_inspect fi_quoteno fi_covcodcd fi_polsystem fi_engcount 
         fi_eng_no3 fi_eng_no2 fi_eng_no5 fi_eng_no4 fi_brand2 fi_typsale 
         fi_bev fi_campaign fi_imginspec bu_car fi_driv1 fi_birth1 fi_driv2 
         fi_birth2 fi_ID1 fi_occup1 fi_IC1 fi_occup2 fi_driv3 fi_birth3 fi_id3 
         fi_occup3 fi_ic3 fi_driv4 fi_birth4 fi_id4 fi_occup4 fi_ic4 fi_driv5 
         fi_birth5 fi_id5 fi_occup5 fi_ic5 fi_receipt fi_receiptid70 
         fi_receiptidbr fi_receiptid72 fi_receiptidbr72 fi_receipt2 fi_id2 
         fi_ic2 fi_class72 fi_addr1 fi_addr2 fi_addr3 fi_addr4 RECT-337 
         RECT-338 RECT-462 RECT-466 
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
DEF VAR nv_addrec72 AS CHAR FORMAT "x(250)" INIT "" .
DEF VAR nv_addr3 AS CHAR .
DEF VAR nv_addr4 AS CHAR .
DO:
    Assign
          fi_trndat     = tlt.trndat
          fi_policy     = tlt.filler1
          fi_userid     =  tlt.usrid 
          fi_polsystem  = tlt.nor_noti_ins  
          ra_poltyp     = If tlt.flag  =  "N"  Then  1  Else 2  
          nv_chaidrep   = trim(tlt.comp_usr_tlt)
          fi_covcodcd   = trim(tlt.covcod)   /*A65-0356*/ 
          fi_acctype    = trim(tlt.note1)    /*A65-0356*/ 
          fi_acccovsum  = trim(tlt.note2)    /*A65-0356*/ 
          fi_accprem    = trim(tlt.note3)    /*A65-0356*/ 
          fi_inspect    = trim(tlt.note4)    /*A65-0356*/ 
          fi_quoteno    = trim(tlt.note5)   /*A65-0356*/ 
          fi_confirmdate = tlt.ndate1        /*A65-0356*/ 
          fi_engcount  = INTE(tlt.ndeci1) 
          fi_eng_no    = TRIM(tlt.eng_no)
          fi_eng_no2   = trim(tlt.eng_no2)    
          fi_eng_no3   = trim(tlt.note9 )    
          fi_eng_no4   = trim(tlt.note10)    
          fi_eng_no5   = trim(tlt.note11)    
          fi_class72   = trim(tlt.subclass)    
          fi_brand2    = trim(tlt.car_type)    
          fi_typsale   = trim(tlt.note7)    
          fi_bev       = trim(tlt.note8)    
          fi_campaign  = trim(tlt.campaign)    
          fi_imginspec = trim(tlt.ispflg) 
          fi_driv1      = TRIM(brstat.tlt.dri_name1)
          fi_driv2      = TRIM(brstat.tlt.dri_name2)
          fi_driv3      = trim(brstat.tlt.dri_name3) 
          fi_driv4      = trim(brstat.tlt.dri_name4) 
          fi_driv5      = trim(brstat.tlt.dri_name5)
          fi_birth1     = IF (brstat.tlt.dri_no1) <> "" OR (brstat.tlt.dri_no1) <> "?" THEN DATE(brstat.tlt.dri_no1) ELSE ?
          fi_birth2     = IF (brstat.tlt.dri_no2) <> "" OR (brstat.tlt.dri_no2) <> "?" THEN DATE(brstat.tlt.dri_no2) ELSE ?
          fi_birth3     = IF (brstat.tlt.dri_no3) <> "" OR (brstat.tlt.dri_no3) <> "?" THEN DATE(brstat.tlt.dri_no3) ELSE ? 
          fi_birth4     = IF (brstat.tlt.dri_no4) <> "" OR (brstat.tlt.dri_no4) <> "?" THEN DATE(brstat.tlt.dri_no4) ELSE ? 
          fi_birth5     = IF (brstat.tlt.dri_no5) <> "" OR (brstat.tlt.dri_no5) <> "?" THEN DATE(brstat.tlt.dri_no5) ELSE ? 
          fi_occup1     = trim(brstat.tlt.dir_occ1) 
          fi_occup2     = trim(brstat.tlt.dri_occ2) 
          fi_occup3     = trim(brstat.tlt.dir_occ3) 
          fi_occup4     = trim(brstat.tlt.dri_occ4) 
          fi_occup5     = trim(brstat.tlt.dri_occ5) 
          fi_id1        = trim(brstat.tlt.dri_lic1)
          fi_id2        = trim(brstat.tlt.dri_lic2)
          fi_id3        = trim(brstat.tlt.dri_lic3)
          fi_id4        = trim(brstat.tlt.dri_lic4)
          fi_id5        = trim(brstat.tlt.dri_lic5)
          fi_ic1        = trim(brstat.tlt.dri_ic1) 
          fi_ic2        = trim(brstat.tlt.dri_ic2) 
          fi_ic3        = trim(brstat.tlt.dri_ic3) 
          fi_ic4        = trim(brstat.tlt.dri_ic4) 
          fi_ic5        = trim(brstat.tlt.dri_ic5) 
          fi_receipt    =  tlt.rec_addr1
          fi_receipt2   =  IF index(tlt.comp_usr_ins,"a1:") <> 0 THEN SUBSTR(tlt.comp_usr_ins,1,INDEX(tlt.comp_usr_ins,"a1:") - 1) 
                           ELSE TRIM(tlt.comp_usr_ins)
          fi_addr1      = tlt.ins_addr1
          fi_addr2      = tlt.ins_addr2 .

           ASSIGN fi_receiptidbr72 = IF index(nv_chaidrep,"ID72br:") = 0 THEN "" ELSE           
                                     trim(SUBSTR(nv_chaidrep,index(nv_chaidrep,"ID72br:") + 7 ))
                  nv_chaidrep      = IF index(nv_chaidrep,"ID72br:") = 0 THEN "" ELSE           
                                     trim(SUBSTR(nv_chaidrep,1,index(nv_chaidrep,"ID72br:") - 1 )) 
                  fi_receiptid72   = IF index(nv_chaidrep,"ID72:") = 0 THEN "" ELSE                                                           
                                     trim(SUBSTR(nv_chaidrep,index(nv_chaidrep,"ID72:") + 5 ))  
                  nv_chaidrep      = IF index(nv_chaidrep,"ID72:") = 0 THEN "" ELSE            
                                     trim(SUBSTR(nv_chaidrep,1,index(nv_chaidrep,"ID72:") - 1 ))  
                  fi_receiptidbr   = IF index(nv_chaidrep,"ID70br:") = 0 THEN "" ELSE 
                                     trim(SUBSTR(nv_chaidrep,index(nv_chaidrep,"ID70br:") + 7 ))  
                  nv_chaidrep      = IF index(nv_chaidrep,"ID70br:") = 0 THEN "" ELSE             
                                     trim( SUBSTR(nv_chaidrep,1,index(nv_chaidrep,"ID70br:") - 1 )) 
                  fi_receiptid70   = IF index(nv_chaidrep,"ID70:") = 0 THEN "" ELSE 
                                     trim(SUBSTR(nv_chaidrep,index(nv_chaidrep,"ID70:") + 5 )). 


         IF index(tlt.comp_usr_ins,"a1:") <> 0 THEN DO:
           ASSIGN nv_addrec72 = SUBSTR(tlt.comp_usr_ins,R-INDEX(tlt.comp_usr_ins,"a1:"))
                  nv_addr3    = IF INDEX(nv_addrec72,"a1:") <> 0 THEN SUBSTR(nv_addrec72,1,R-INDEX(nv_addrec72,"a2:") - 1) ELSE "" 
                  nv_addr4    = IF INDEX(nv_addrec72,"a2:") <> 0 THEN SUBSTR(nv_addrec72,R-INDEX(nv_addrec72,"a2:")) ELSE ""     .
            IF INDEX(nv_addr3,"a1:") <> 0 THEN ASSIGN nv_addr3 = trim(REPLACE(nv_addr3,"a1:","")) .
            IF INDEX(nv_addr4,"a2:") <> 0 THEN ASSIGN nv_addr4 = TRIM(REPLACE(nv_addr4,"a2:","")).
         END.
         ASSIGN fi_addr3 = nv_addr3
                fi_addr4 = nv_addr4.


     Disp     ra_poltyp        fi_policy        fi_covcodcd      fi_acctype      fi_acccovsum     fi_accprem       fi_inspect         
              fi_quoteno       fi_confirmdate   fi_polsystem     fi_trndat       fi_userid        fi_engcount      fi_eng_no        
              fi_eng_no2       fi_eng_no3       fi_eng_no4       fi_eng_no5      fi_class72       fi_brand2        fi_typsale   
              fi_bev           fi_campaign      fi_imginspec     fi_driv1        fi_driv2         fi_driv3         fi_driv4
              fi_driv5         fi_birth1        fi_birth2        fi_birth3       fi_birth4        fi_birth5        fi_occup1  
              fi_occup2        fi_occup3        fi_occup4        fi_occup5       fi_id1           fi_id2           fi_id3     
              fi_id4           fi_id5           fi_ic1           fi_ic2          fi_ic3           fi_ic4           fi_ic5        
              fi_receipt       fi_receipt2      fi_receiptidbr72 fi_receiptid72  fi_receiptidbr   fi_receiptid70   
              fi_addr1         fi_addr2         fi_addr3      fi_addr4    With frame  fr_main.  
  End.                                                                                                              
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

