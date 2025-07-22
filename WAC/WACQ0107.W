&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
&Scoped-define WINDOW-NAME Win-wacq0107
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS Win-wacq0107 
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
/*Modify by:  Chaiyong W. A54-0112 12/11/2012         */
/*            chage format vehreg 10 to 11            */      

CREATE WIDGET-POOL.

/* ***************************  Definitions  ************************** */

/* Local Variable Definitions ---                                       */

DEFINE INPUT  PARAMETER n_recid   AS   RECID   NO-UNDO.

DEFINE            VAR n_trntyp    AS CHAR FORMAT "x(2)".
DEFINE            VAR n_crper     AS INTEGER FORMAT ">>9" INITIAL  0.
DEFINE            VAR n_acamt1    LIKE acm002.amt1.
DEFINE            VAR n_acamt2    LIKE acm002.amt2.
DEFINE            VAR n_acamt3    LIKE acm002.amt3.
DEFINE            VAR n_acamt4    LIKE acm002.amt4.
DEFINE            VAR n_acamt5    LIKE acm002.amt5.
DEFINE            VAR n_acamt6    LIKE acm002.amt6.
DEFINE            VAR n_acdes1    AS CHAR FORMAT "x(20)" INITIAL[""].
DEFINE            VAR n_acdes2    AS CHAR FORMAT "x(20)" INITIAL[""].
DEFINE            VAR n_acdes3    AS CHAR FORMAT "x(20)" INITIAL[""].
DEFINE            VAR n_acdes4    AS CHAR FORMAT "x(20)" INITIAL[""].
DEFINE            VAR n_acdes5    AS CHAR FORMAT "x(20)" INITIAL[""].
DEFINE            VAR n_acdes6    AS CHAR FORMAT "x(20)" INITIAL[""].
DEFINE            VAR n_bal       LIKE acm001.bal        INITIAL[0].
DEFINE            VAR n_baloc     LIKE acm001.baloc      INITIAL[0].

DEF VAR nv_inc_date    AS DATE.
DEF VAR nv_inc_mon     AS INT.
DEF VAR nv_inc_yar       AS INT.
DEF VAR n_ovddat         AS DATE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS bu_next bu_exit fi_text RECT-15 RECT-16 ~
RECT-233 RECT-234 RECT-264 
&Scoped-Define DISPLAYED-OBJECTS fi_instot fi_ac2 fi_ac3 fi_ac4 fi_ac5 ~
fi_ac6 fi_acamt1 fi_acamt2 fi_acamt3 fi_acamt4 fi_acamt5 fi_acamt6 ~
fi_acdes1 fi_acdes2 fi_acdes3 fi_acdes4 fi_acdes5 fi_acdes6 fi_bnkdes ~
fi_brndes fi_curdec fi_dptdes fi_namagt fi_name fi_acno fi_agent fi_baloc ~
fi_bal fi_bankno fi_branch fi_cheque fi_comm fi_cn_no fi_crper fi_Curcod ~
fi_dept fi_docno fi_ovddat fi_fee fi_ac1 fi_insno fi_netloc fi_netamt ~
fi_prem fi_dociln fi_ref fi_stamp fi_tax fi_trndat fi_trntyp fi_vehreg ~
fi_text 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR Win-wacq0107 AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bu_exit 
     LABEL "<< Back" 
     SIZE 12.5 BY 1.14
     FONT 6.

DEFINE BUTTON bu_next 
     LABEL "Next >>" 
     SIZE 12.5 BY 1.14
     FONT 6.

DEFINE VARIABLE fi_ac1 AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 23 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_ac2 AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 23 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_ac3 AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 23 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_ac4 AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 23 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_ac5 AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 23 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_ac6 AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 23 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_acamt1 AS DECIMAL FORMAT "zzz,zzz,zzz,zz9.99-":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_acamt2 AS DECIMAL FORMAT "zzz,zzz,zzz,zz9.99-":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_acamt3 AS DECIMAL FORMAT "zzz,zzz,zzz,zz9.99-":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_acamt4 AS DECIMAL FORMAT "zzz,zzz,zzz,zz9.99-":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_acamt5 AS DECIMAL FORMAT "zzz,zzz,zzz,zz9.99-":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_acamt6 AS DECIMAL FORMAT "zzz,zzz,zzz,zz9.99-":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_acdes1 AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 32 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_acdes2 AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 32 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_acdes3 AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 32 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_acdes4 AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 32 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_acdes5 AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 32 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_acdes6 AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 32 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_acno AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 13.5 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_agent AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 13.5 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_bal AS DECIMAL FORMAT "zzz,zzz,zzz,zz9.99-":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_baloc AS DECIMAL FORMAT "zzz,zzz,zzz,zz9.99-":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_bankno AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 6.5 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_bnkdes AS CHARACTER FORMAT "x(20)":U 
     VIEW-AS FILL-IN 
     SIZE 33 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_branch AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 6 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_brndes AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 36.5 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_cheque AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_cn_no AS INTEGER FORMAT ">>>>>>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_comm AS DECIMAL FORMAT ">>,>>>,>>>,>>9.99-":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 34.5 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_crper AS INTEGER FORMAT "zz9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 6 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_Curcod AS CHARACTER FORMAT "X(3)":U 
     VIEW-AS FILL-IN 
     SIZE 7.5 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_curdec AS CHARACTER FORMAT "X(3)":U 
     VIEW-AS FILL-IN 
     SIZE 7 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_dept AS CHARACTER FORMAT "X(1)":U 
     VIEW-AS FILL-IN 
     SIZE 4.5 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_dociln AS CHARACTER FORMAT "X(1)":U 
     VIEW-AS FILL-IN 
     SIZE 4 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_docno AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_dptdes AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 34.83 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_fee AS DECIMAL FORMAT "zzz,zzz,zzz,zz9.99-":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_insno AS DECIMAL FORMAT ">9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 4.5 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_instot AS DECIMAL FORMAT ">9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 4.5 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_namagt AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 32 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_name AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 29 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_netamt AS DECIMAL FORMAT "zzz,zzz,zzz,zz9.99-":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_netloc AS DECIMAL FORMAT "zzz,zzz,zzz,zz9.99-":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_ovddat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_prem AS DECIMAL FORMAT ">>,>>>,>>>,>>9.99-":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 34.5 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_ref AS CHARACTER FORMAT "X(58)":U 
     VIEW-AS FILL-IN 
     SIZE 48 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_stamp AS DECIMAL FORMAT ">,>>>,>>9.99-":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 34.5 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_tax AS DECIMAL FORMAT "zzz,zzz,zzz,zz9.99-":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_text AS CHARACTER FORMAT "X(256)":U INITIAL "     TRANSECTION DETAIL (1)" 
      VIEW-AS TEXT 
     SIZE 125.5 BY 1.05
     BGCOLOR 3 FGCOLOR 15 FONT 2 NO-UNDO.

DEFINE VARIABLE fi_trndat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_trntyp AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 6 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_vehreg AS CHARACTER FORMAT "X(11)":U 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-15
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 131.5 BY 23.48
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-16
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 128.5 BY 1.57
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-233
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 14.5 BY 1.67
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-234
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 14.5 BY 1.67
     BGCOLOR 1 FGCOLOR 1 .

DEFINE RECTANGLE RECT-264
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 128.5 BY 21.14
     BGCOLOR 18 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     bu_next AT ROW 20.05 COL 116.5
     fi_instot AT ROW 15.86 COL 35 COLON-ALIGNED NO-LABEL
     fi_ac2 AT ROW 17.95 COL 25.5 COLON-ALIGNED NO-LABEL
     fi_ac3 AT ROW 19 COL 25.5 COLON-ALIGNED NO-LABEL
     fi_ac4 AT ROW 20.05 COL 25.5 COLON-ALIGNED NO-LABEL
     fi_ac5 AT ROW 21.1 COL 25.5 COLON-ALIGNED NO-LABEL
     fi_ac6 AT ROW 22.14 COL 25.5 COLON-ALIGNED NO-LABEL
     fi_acamt1 AT ROW 16.91 COL 80.5 COLON-ALIGNED NO-LABEL
     fi_acamt2 AT ROW 17.95 COL 80.5 COLON-ALIGNED NO-LABEL
     fi_acamt3 AT ROW 19 COL 80.5 COLON-ALIGNED NO-LABEL
     fi_acamt4 AT ROW 20.05 COL 80.5 COLON-ALIGNED NO-LABEL
     fi_acamt5 AT ROW 21.1 COL 80.5 COLON-ALIGNED NO-LABEL
     fi_acamt6 AT ROW 22.14 COL 80.5 COLON-ALIGNED NO-LABEL
     fi_acdes1 AT ROW 16.91 COL 48.5 COLON-ALIGNED NO-LABEL
     fi_acdes2 AT ROW 17.95 COL 48.5 COLON-ALIGNED NO-LABEL
     fi_acdes3 AT ROW 19 COL 48.5 COLON-ALIGNED NO-LABEL
     fi_acdes4 AT ROW 20.05 COL 48.5 COLON-ALIGNED NO-LABEL
     fi_acdes5 AT ROW 21.1 COL 48.5 COLON-ALIGNED NO-LABEL
     fi_acdes6 AT ROW 22.14 COL 48.5 COLON-ALIGNED NO-LABEL
     fi_bnkdes AT ROW 13.76 COL 32 COLON-ALIGNED NO-LABEL
     fi_brndes AT ROW 4.38 COL 31.5 COLON-ALIGNED NO-LABEL
     fi_curdec AT ROW 10.67 COL 33 COLON-ALIGNED NO-LABEL
     fi_dptdes AT ROW 12.76 COL 30 COLON-ALIGNED NO-LABEL
     fi_namagt AT ROW 5.43 COL 94 COLON-ALIGNED NO-LABEL
     fi_name AT ROW 5.43 COL 39 COLON-ALIGNED NO-LABEL
     bu_exit AT ROW 22.38 COL 116.5
     fi_acno AT ROW 5.43 COL 25.5 COLON-ALIGNED NO-LABEL
     fi_agent AT ROW 5.43 COL 80.5 COLON-ALIGNED NO-LABEL
     fi_baloc AT ROW 12.76 COL 80.5 COLON-ALIGNED NO-LABEL
     fi_bal AT ROW 11.71 COL 80.5 COLON-ALIGNED NO-LABEL
     fi_bankno AT ROW 13.76 COL 25.5 COLON-ALIGNED NO-LABEL
     fi_branch AT ROW 4.38 COL 25.5 COLON-ALIGNED NO-LABEL
     fi_cheque AT ROW 13.76 COL 80.5 COLON-ALIGNED NO-LABEL
     fi_comm AT ROW 8.57 COL 25.5 COLON-ALIGNED NO-LABEL
     fi_cn_no AT ROW 14.81 COL 25.5 COLON-ALIGNED NO-LABEL
     fi_crper AT ROW 15.86 COL 80.5 COLON-ALIGNED NO-LABEL
     fi_Curcod AT ROW 10.67 COL 25.5 COLON-ALIGNED NO-LABEL
     fi_dept AT ROW 12.76 COL 25.5 COLON-ALIGNED NO-LABEL
     fi_docno AT ROW 3.33 COL 80.5 COLON-ALIGNED NO-LABEL
     fi_ovddat AT ROW 15.86 COL 52 COLON-ALIGNED NO-LABEL
     fi_fee AT ROW 7.52 COL 80.5 COLON-ALIGNED NO-LABEL
     fi_ac1 AT ROW 16.91 COL 25.5 COLON-ALIGNED NO-LABEL
     fi_insno AT ROW 15.86 COL 25.5 COLON-ALIGNED NO-LABEL
     fi_netloc AT ROW 10.67 COL 80.5 COLON-ALIGNED NO-LABEL
     fi_netamt AT ROW 9.62 COL 80.5 COLON-ALIGNED NO-LABEL
     fi_prem AT ROW 7.52 COL 25.5 COLON-ALIGNED NO-LABEL
     fi_dociln AT ROW 4.38 COL 80.5 COLON-ALIGNED NO-LABEL
     fi_ref AT ROW 6.48 COL 25.5 COLON-ALIGNED NO-LABEL
     fi_stamp AT ROW 9.62 COL 25.5 COLON-ALIGNED NO-LABEL
     fi_tax AT ROW 8.57 COL 80.5 COLON-ALIGNED NO-LABEL
     fi_trndat AT ROW 11.71 COL 25.5 COLON-ALIGNED NO-LABEL
     fi_trntyp AT ROW 3.33 COL 25.5 COLON-ALIGNED NO-LABEL
     fi_vehreg AT ROW 14.81 COL 80.5 COLON-ALIGNED NO-LABEL
     fi_text AT ROW 1.76 COL 3 COLON-ALIGNED NO-LABEL
     "Transaction type" VIEW-AS TEXT
          SIZE 17 BY .62 AT ROW 3.62 COL 10
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Department" VIEW-AS TEXT
          SIZE 11 BY .62 AT ROW 13 COL 14.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133.33 BY 24.04
         BGCOLOR 3 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "Account no" VIEW-AS TEXT
          SIZE 12 BY .62 AT ROW 5.71 COL 14.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "GL postings" VIEW-AS TEXT
          SIZE 12 BY .62 AT ROW 17.19 COL 14
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Doc no." VIEW-AS TEXT
          SIZE 8 BY .62 AT ROW 3.62 COL 73
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Premium" VIEW-AS TEXT
          SIZE 8 BY .62 AT ROW 7.76 COL 17.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Agent no." VIEW-AS TEXT
          SIZE 9.5 BY .62 AT ROW 5.71 COL 71.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Currency Code" VIEW-AS TEXT
          SIZE 15 BY .62 AT ROW 10.91 COL 12
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Branch" VIEW-AS TEXT
          SIZE 8 BY .62 AT ROW 4.67 COL 18.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Fee" VIEW-AS TEXT
          SIZE 5 BY .62 AT ROW 7.76 COL 76.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Bank number" VIEW-AS TEXT
          SIZE 13 BY .62 AT ROW 14.05 COL 12.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "of" VIEW-AS TEXT
          SIZE 3.5 BY .62 AT ROW 16.14 COL 33
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Days" VIEW-AS TEXT
          SIZE 8 BY .62 AT ROW 16.14 COL 90.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Instalment no." VIEW-AS TEXT
          SIZE 13 BY .62 AT ROW 16.14 COL 12
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Bal O/S" VIEW-AS TEXT
          SIZE 8 BY .62 AT ROW 11.95 COL 72.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Prt Doc" VIEW-AS TEXT
          SIZE 8 BY .62 AT ROW 4.67 COL 72.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Cheque no." VIEW-AS TEXT
          SIZE 11 BY .62 AT ROW 14.05 COL 69.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Veh reg no" VIEW-AS TEXT
          SIZE 11.5 BY .62 AT ROW 15.1 COL 70
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Tax" VIEW-AS TEXT
          SIZE 5.5 BY .62 AT ROW 8.81 COL 76
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Due Date" VIEW-AS TEXT
          SIZE 9.5 BY .62 AT ROW 16.14 COL 43.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Net Amt" VIEW-AS TEXT
          SIZE 8 BY .62 AT ROW 9.86 COL 72
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Reference" VIEW-AS TEXT
          SIZE 10.5 BY .62 AT ROW 6.76 COL 15
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Net (local)" VIEW-AS TEXT
          SIZE 11 BY .62 AT ROW 10.91 COL 69.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Commission" VIEW-AS TEXT
          SIZE 11.5 BY .62 AT ROW 8.81 COL 14.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Stamp" VIEW-AS TEXT
          SIZE 7.5 BY .62 AT ROW 9.86 COL 19.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Bal (local)" VIEW-AS TEXT
          SIZE 10 BY .62 AT ROW 13 COL 70.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Transaction date" VIEW-AS TEXT
          SIZE 16.5 BY .62 AT ROW 11.95 COL 9.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Credit Term" VIEW-AS TEXT
          SIZE 12 BY .62 AT ROW 16.14 COL 69
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Cover note no." VIEW-AS TEXT
          SIZE 15 BY .62 AT ROW 15.1 COL 11.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133.33 BY 24.04
         BGCOLOR 3 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     RECT-15 AT ROW 1.24 COL 2
     RECT-16 AT ROW 1.52 COL 3.5
     RECT-233 AT ROW 22.14 COL 115.5
     RECT-234 AT ROW 19.76 COL 115.5
     RECT-264 AT ROW 3.1 COL 3.5
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133.33 BY 24.04
         BGCOLOR 3 .


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
  CREATE WINDOW Win-wacq0107 ASSIGN
         HIDDEN             = YES
         TITLE              = "Wacq0107 : Transaction Detail (1)"
         HEIGHT             = 24.05
         WIDTH              = 133.33
         MAX-HEIGHT         = 24.05
         MAX-WIDTH          = 133.33
         VIRTUAL-HEIGHT     = 24.05
         VIRTUAL-WIDTH      = 133.33
         RESIZE             = no
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
IF NOT Win-wacq0107:LOAD-ICON("WIMAGE\safety":U) THEN
    MESSAGE "Unable to load icon: WIMAGE\safety"
            VIEW-AS ALERT-BOX WARNING BUTTONS OK.
&ENDIF
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW Win-wacq0107
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME fr_main
   FRAME-NAME Custom                                                    */
/* SETTINGS FOR FILL-IN fi_ac1 IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_ac2 IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_ac3 IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_ac4 IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_ac5 IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_ac6 IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_acamt1 IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_acamt2 IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_acamt3 IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_acamt4 IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_acamt5 IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_acamt6 IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_acdes1 IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_acdes2 IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_acdes3 IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_acdes4 IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_acdes5 IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_acdes6 IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_acno IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_agent IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_bal IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_baloc IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_bankno IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_bnkdes IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_branch IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_brndes IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_cheque IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_cn_no IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_comm IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_crper IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_Curcod IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_curdec IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_dept IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_dociln IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_docno IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_dptdes IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_fee IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_insno IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_instot IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_namagt IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_name IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_netamt IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_netloc IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_ovddat IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_prem IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_ref IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_stamp IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_tax IN FRAME fr_main
   NO-ENABLE                                                            */
ASSIGN 
       fi_text:RESIZABLE IN FRAME fr_main        = TRUE.

/* SETTINGS FOR FILL-IN fi_trndat IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_trntyp IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_vehreg IN FRAME fr_main
   NO-ENABLE                                                            */
ASSIGN 
       RECT-16:HIDDEN IN FRAME fr_main           = TRUE.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(Win-wacq0107)
THEN Win-wacq0107:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME Win-wacq0107
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Win-wacq0107 Win-wacq0107
ON END-ERROR OF Win-wacq0107 /* Wacq0107 : Transaction Detail (1) */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Win-wacq0107 Win-wacq0107
ON WINDOW-CLOSE OF Win-wacq0107 /* Wacq0107 : Transaction Detail (1) */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_exit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_exit Win-wacq0107
ON CHOOSE OF bu_exit IN FRAME fr_main /* << Back */
DO:
    APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_next
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_next Win-wacq0107
ON CHOOSE OF bu_next IN FRAME fr_main /* Next >> */
DO:
  Win-wacq0107:Hidden = Yes.       
  Run wac/wacq0108 (Input n_recid).                                                                      
  Win-wacq0107:Hidden = No.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK Win-wacq0107 


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
  DEF  VAR  gv_prgid   AS   CHAR  FORMAT "X(8)"   NO-UNDO.
  DEF  VAR  gv_prog    AS   CHAR  FORMAT "X(40)" NO-UNDO.
  
  gv_prgid = "wacq0107".
  gv_prog  = "Transaction Detail(1)".
  RUN  WUT\WUTHEAD (Win-wacq0107:handle,gv_prgid,gv_prog).
  RUN  WUT\WUTWICEN (Win-wacq0107:handle). 

/*********************************************************************/                                     
Run Check_data.
                                  
  IF NOT THIS-PROCEDURE:PERSISTENT THEN
       WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Check_data Win-wacq0107 
PROCEDURE Check_data :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
n_trntyp = "".
 
Find acm001 WHERE Recid(acm001) = n_recid.
n_trntyp = acm001.trnty1 + acm001.trnty2.
      
If acm001.acno <> "" Then Do:
   Find xmm600 Use-Index xmm60001 Where xmm600.acno = acm001.acno
     No-Lock No-Error.

   n_crper = 0.  
   If Available xmm600 Then  Do:
      n_crper =  xmm600.crper.
      Assign fi_name = xmm600.name.
      Disp fi_name With Frame fr_main.
   End.
End.

If acm001.agent <> "" Then Do:
   Find xmm600 Use-Index xmm60001 Where xmm600.acno = acm001.agent
     No-Lock No-Error.
   If Available xmm600 Then Do:
      Assign fi_namagt = xmm600.name.
      Disp fi_namagt With Frame fr_main.
     End.
End.

If acm001.dept <> "" Then Do:
     Find sym100 Where sym100.tabcod = "U079" And sym100.itmcod = acm001.dept
       No-Lock No-Error.
     If Available sym100 Then Assign fi_dptdes = sym100.itmdes.
                         Else fi_dptdes = "".
     Disp fi_dptdes With Frame fr_main.
End.
 
If acm001.curcod <> "" Then Do:
    Find xmm012 Use-Index xmm01201 Where xmm012.curcod = acm001.curcod
      No-Lock No-Error.
        If Available xmm012 Then Do:
             Assign fi_curdec = xmm012.curdec.
             Disp fi_curdec With Frame fr_main.
        End.
End.

If acm001.branch <> "" Then Do:
   Find xmm023 Where xmm023.branch = acm001.branch
     No-Lock No-Error.
   If Available xmm023 Then fi_brndes = xmm023.bdes.
                       Else fi_brndes = "".
   Disp fi_brndes With Frame fr_main.
End.
 
If acm001.bankno <> "" Then Do:
   Find xmm081 Use-Index xmm08101 Where xmm081.bankno = acm001.bankno
     No-Lock No-Error.
   If Available xmm081 Then fi_bnkdes = xmm081.bankna.
                       Else fi_bnkdes = "".
   Disp fi_bnkdes With Frame fr_main.
End.
 
If acm001.ac1 <> "" Then Do:
   Find xmm201 Use-Index xmm20101 Where xmm201.glacno = acm001.ac1
     No-Lock No-Error.
   If Available xmm201 Then n_acdes1 = xmm201.gldes.
End.
 
If acm001.ac2 <> "" Then Do:
   Find xmm201 Use-Index xmm20101 Where xmm201.glacno = acm001.ac2
     No-Lock NO-Error.
   If Available xmm201 Then n_acdes2 = xmm201.gldes.
End.
 
If acm001.ac3 <> "" Then Do:
   Find xmm201 Use-Index xmm20101 Where xmm201.glacno = acm001.ac3
     No-Lock No-Error.
   If Available xmm201 Then n_acdes3 = xmm201.gldes.
End.
 
If acm001.ac4 <> "" Then Do:
   Find xmm201 Use-Index xmm20101 Where xmm201.glacno = acm001.ac4
     No-Lock No-Error.
   If Available xmm201 Then n_acdes4 = xmm201.gldes.
End.

If acm001.ac5 <> "" Then Do:
   Find xmm201 Use-Index xmm20101 Where xmm201.glacno = acm001.ac5
     No-Lock No-Error.
   If Available xmm201 Then n_acdes5 = xmm201.gldes.
End.

If acm001.ac6 <> "" Then Do:
   Find xmm201 Use-Index xmm20101 Where xmm201.glacno = acm001.ac6
     No-Lock No-Error.
   If Available xmm201 THEN n_acdes6 = xmm201.gldes.
End.
  
n_bal    = acm001.bal.
n_baloc  = acm001.baloc.
n_acamt1 = acm001.amt1.
n_acamt2 = acm001.amt2.
n_acamt3 = acm001.amt3.
n_acamt4 = acm001.amt4.
n_acamt5 = acm001.amt5.
n_acamt6 = acm001.amt6.

Assign
    fi_acdes1 = n_acdes1 
    fi_acdes2 = n_acdes2 
    fi_acdes3 = n_acdes3 
    fi_acdes4 = n_acdes4 
    fi_acdes5 = n_acdes5 
    fi_acdes6 = n_acdes6.

Disp
    fi_acdes1 fi_acdes2  fi_acdes3  fi_acdes4  fi_acdes5  fi_acdes6 With Frame fr_main.

If month(acm001.trndat) =  12 then do.
  nv_inc_mon    =  01.
  nv_inc_yar    =  year(acm001.trndat) + 1.
End.
Else Do.
  nv_inc_mon    =  month(acm001.trndat) + 1.
  nv_inc_yar    =  year(acm001.trndat).
End.
  nv_inc_date      =  date(nv_inc_mon,01,nv_inc_yar).
  n_ovddat        =   nv_inc_date  +   n_crper.

Assign fi_ovddat = n_ovddat.
Disp   fi_ovddat  With Frame fr_main.  

Run Show_data.
  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI Win-wacq0107  _DEFAULT-DISABLE
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
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(Win-wacq0107)
  THEN DELETE WIDGET Win-wacq0107.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI Win-wacq0107  _DEFAULT-ENABLE
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
  DISPLAY fi_instot fi_ac2 fi_ac3 fi_ac4 fi_ac5 fi_ac6 fi_acamt1 fi_acamt2 
          fi_acamt3 fi_acamt4 fi_acamt5 fi_acamt6 fi_acdes1 fi_acdes2 fi_acdes3 
          fi_acdes4 fi_acdes5 fi_acdes6 fi_bnkdes fi_brndes fi_curdec fi_dptdes 
          fi_namagt fi_name fi_acno fi_agent fi_baloc fi_bal fi_bankno fi_branch 
          fi_cheque fi_comm fi_cn_no fi_crper fi_Curcod fi_dept fi_docno 
          fi_ovddat fi_fee fi_ac1 fi_insno fi_netloc fi_netamt fi_prem fi_dociln 
          fi_ref fi_stamp fi_tax fi_trndat fi_trntyp fi_vehreg fi_text 
      WITH FRAME fr_main IN WINDOW Win-wacq0107.
  ENABLE bu_next bu_exit fi_text RECT-15 RECT-16 RECT-233 RECT-234 RECT-264 
      WITH FRAME fr_main IN WINDOW Win-wacq0107.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW Win-wacq0107.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Show_data Win-wacq0107 
PROCEDURE Show_data :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN  
        fi_trntyp  = n_trntyp 
        fi_docno   = acm001.docno 
        fi_branch  = acm001.branch
        fi_dociln  = acm001.dociln 
        fi_acno    = acm001.acno 
        fi_agent   = acm001.agent
        fi_ref     = acm001.ref 
        fi_prem    = acm001.prem 
        fi_comm    = acm001.comm 
        fi_stamp   = acm001.stamp
        fi_fee     = acm001.fee 
        fi_tax     = acm001.tax
        fi_bal     = n_bal
        fi_curcod  = acm001.curcod 
        fi_trndat  = acm001.trndat 
        fi_baloc   = n_baloc
        fi_dept    = acm001.dept
        fi_ac1     = acm001.ac1 
        fi_acamt1  = n_acamt1
        fi_ac2     = acm001.ac2 
        fi_acamt2  = n_acamt2
        fi_ac3     = acm001.ac3
        fi_acamt3  = n_acamt3 
        fi_ac4     = acm001.ac4 
        fi_acamt4  = n_acamt4 
        fi_ac5     = acm001.ac5
        fi_acamt5  = n_acamt5 
        fi_ac6     = acm001.ac6 
        fi_acamt6  = n_acamt6 
        fi_cn_no   = acm001.cn_no 
        fi_vehreg  = acm001.vehreg 
        fi_insno   = acm001.insno
        fi_instot  = acm001.instot    
        fi_ovddat  = n_ovddat    
        fi_crper   = n_crper
        fi_netamt  = acm001.netamt 
        fi_netloc  = acm001.netloc 
        fi_bankno  = acm001.bankno 
        fi_cheque  = acm001.cheque.

DISP 
        fi_trntyp  fi_docno  FORMAT "x(10)" /* Benjaporn J. A60-0267 date 27/06/2017 */
        fi_branch  fi_dociln  fi_acno    fi_agent
        fi_ref     fi_prem    fi_comm    fi_stamp   fi_fee     fi_tax
        fi_bal     fi_curcod  fi_trndat  fi_baloc   fi_dept    fi_ac1 
        fi_acamt1  fi_ac2     fi_acamt2  fi_ac3     fi_acamt3  fi_ac4 
        fi_acamt4  fi_ac5     fi_acamt5  fi_ac6     fi_acamt6  fi_cn_no 
        fi_vehreg  fi_insno   fi_instot  fi_ovddat  fi_crper   fi_netamt 
        fi_netloc  fi_bankno  fi_cheque   WITH FRAME fr_main.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

