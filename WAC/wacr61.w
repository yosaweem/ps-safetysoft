&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
*/
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
 Create By  : Nattanicha K.  A63-0159   Date 04/2020
              Dupplicate from wacr60.w
               - 1,000,000 for New file 
               - Motor คำนวณ UPR โดยนำ Policy Status CA มาคิด
               - Motor กรณีกรมธรรม์เกินปีให้คำนวณ 1 ปี
               
------------------------------------------------------------------------*/
/*          This .W file was created with the Progress AppBuilder.      */
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
{wac/wacr60.i}
DEF VAR n_pacod    AS logic. 
DEF VAR nv_COM1P   LIKE UWM120.COM1P.
DEF VAR nv_COM2P   LIKE UWM120.COM2P.
DEF VAR n_branch   LIKE uwm100.branch.
DEF VAR n_bdes     LIKE xmm023.bdes.
DEF VAR nv_prstp   LIKE uwm100.pstp.
DEF VAR nv_prtax   LIKE uwm100.ptax.
DEF VAR n_prmcom   LIKE uwm100.prem_t.
DEF VAR n_stp      LIKE uwm100.pstp.
DEF VAR nv_sumpts  LIKE uwm100.ptax.
DEF VAR n_tstpcom  LIKE uwm100.pstp.
DEF VAR n_sumprm   LIKE uwm100.prem_t.
DEF VAR n_taxcom   LIKE uwm100.ptax.
DEF VAR n_sumstp   LIKE uwm100.pstp.
DEF VAR n_stptrunc LIKE uwm100.pstp.
DEF VAR n_sumtax   LIKE uwm100.ptax.
DEF VAR n_stpcom   LIKE uwm100.pstp.
DEF VAR nv_sum     LIKE uwm120.sigr INIT 0.

DEF VAR nu_tax     LIKE uwm100.ptax.
DEF VAR nu_prm     LIKE uwm100.prem_t.
DEF VAR nu_vat     LIKE uwm100.ptax.
DEF VAR nu_vat_t   LIKE uwm100.ptax.
DEF VAR nu_sbt_t   LIKE uwm100.pstp.

DEF VAR n_ttaxcom  LIKE uwm100.ptax.
DEF VAR n_paprm    LIKE uwm100.prem_t.
DEF VAR n_stppa    LIKE uwm100.pstp.
DEF VAR n_tstppa   LIKE uwm100.pstp.
DEF VAR n_an       LIKE UWM120.SIGR.
DEF VAR n_taxpa    LIKE uwm100.ptax.

DEF VAR n_sum1     LIKE uwm120.sigr    INIT 0.
DEF VAR n_sum2     LIKE uwm100.prem_t  INIT 0.
DEF VAR n_sum3     like uwm100.ptax    INIT 0.
DEF VAR n_sum4     LIKE uwm100.pstp    INIT 0.
DEF VAR n_sum5     LIKE uwm100.prem_t  INIT 0.
DEF VAR n_sum6     LIKE uwm100.com1_t  INIT 0.
def var n_sum7     like uwm100.prem_t.
def var n_sum8     like uwm100.ptax.
def var n_sum9     like uwm100.pstp.

DEF VAR nv_sum1p   AS DECI FORMAT "->>,>>>,>>>,>>9.99" INIT 0.
DEF VAR nv_sum2p   AS DECI FORMAT "->>,>>>,>>>,>>9.99" INIT 0.
DEF VAR nv_sum3p   AS DECI FORMAT "->>,>>>,>>>,>>9.99" INIT 0.
DEF VAR nv_sum4p   AS DECI FORMAT "->>,>>>,>>>,>>9.99" INIT 0.
DEF VAR nv_sum5p   AS DECI FORMAT "->>,>>>,>>>,>>9.99" INIT 0.
DEF VAR nv_sum6p   AS DECI FORMAT "->>,>>>,>>>,>>9.99" INIT 0.
DEF VAR nv_sum7p   AS DECI FORMAT "->>,>>>,>>>,>>9.99" INIT 0.
DEF VAR nv_sum8p   AS DECI FORMAT "->>,>>>,>>>,>>9.99" INIT 0.
DEF VAR nv_sum9p   AS DECI FORMAT "->>,>>>,>>>,>>9.99" INIT 0.
DEF VAR nv_sum10p  AS DECI FORMAT "->>,>>>,>>>,>>9.99" INIT 0.
DEF VAR nv_sumfeep AS DECI FORMAT "->>,>>>,>>>,>>9.99" INIT 0.   

DEF VAR n_sum1b    LIKE uwm120.sigr    INIT 0.
DEF VAR n_sum2b    LIKE uwm100.prem_t  INIT 0.
DEF VAR n_sum3b    LIKE uwm100.ptax    INIT 0.
DEF VAR n_sum4b    LIKE uwm100.pstp    INIT 0.
DEF VAR n_sum5b    LIKE uwm100.prem_t  INIT 0.
DEF VAR n_sum6b    LIKE uwm100.com1_t  INIT 0.
DEF VAR n_sum7b    LIKE uwm100.prem_t.
DEF VAR n_sum8b    LIKE uwm100.ptax.
DEF VAR n_sum9b    LIKE uwm100.pstp.
DEF VAR n_sum10b   LIKE uwm100.com1_t  INIT 0.
DEF VAR n_sumfeeb  LIKE uwm100.rfee_t  INIT 0.
DEF VAR n_sumfee   LIKE uwm100.rfee_t  INIT 0.

DEF VAR n_count    AS INTE INIT 0.  
DEF VAR n_count1   AS INTE INIT 0.     /*A56-0092*/
DEF VAR n_text     AS CHAR FORMAT "X(25)".
DEF VAR nv_bran    AS CHAR FORMAT "X(15)" INIT "".
DEF VAR n_agent    AS CHAR FORMAT "x(60)".
DEF VAR n_agent1   AS CHAR . 
DEF VAR n_agtreg   AS CHAR FORMAT  "X(80)".

DEF VAR n_compa_t  LIKE uwm100.com1_t.
DEF VAR n_com1_t   LIKE uwm100.com1_t.
DEF VAR WV_COM1P   AS CHAR FORMAT "X(7)".
DEF VAR WV_COM2P   AS CHAR FORMAT "X(7)".
DEF VAR n_percen   AS CHAR FORMAT "X".
DEF VAR n_number   AS INT INIT 0 .    
DEF VAR nu_sbt     LIKE uwm100.pstp.
DEF VAR nv_output  AS CHAR FORMAT "X(25)".
DEF VAR nv_output1 AS CHAR FORMAT "X(25)".
DEF VAR nv_output2 AS CHAR FORMAT "X(30)".    /*A56-0092*/
DEF VAR nv_row     AS INTE INIT 0.
DEF VAR nv_today   AS DATE FORMAT "99/99/9999".
DEF VAR nv_count   AS INTE INIT 0.
DEF VAR n_rec      AS INTE INIT 0.
DEF VAR n_rec1     AS INTE INIT 0.
DEF VAR n_rec2     AS INTE INIT 0.   /*A56-0092*/
DEF VAR nv_dir     AS CHAR FORMAT "X(2)".
DEF VAR nv_poltyp  AS CHAR FORMAT "X(50)" .
DEF VAR nv_expdat  AS INTE.
DEF VAR nv_datecal AS INTE.
DEF VAR nv_earn    AS DECI.
DEF VAR nv_uearn   AS DECI.
DEF VAR nv_earn1   AS DECI.
DEF VAR nv_uearn1  AS DECI.
/*DEF VAR nv_earn2   AS DECI.
DEF VAR nv_uearn2  AS DECI.*/

DEF NEW SHARED WORKFILE wrk0f
    FIELD  policy AS CHAR
    FIELD  rico   AS CHAR FORMAT "X(10)"
    FIELD  cess   AS INTE FORMAT "9999999"
    FIELD  pf     AS DECI FORMAT ">>9.99"
    FIELD  sumf   AS DECI FORMAT "->>,>>>,>>9.99"
    FIELD  prmf   AS DECI FORMAT "->,>>>,>>9.99".

DEF  VAR nv_s8_si   AS DEC FORMAT "->>>>>>>>>9.99" INIT 0.
DEF  VAR nv_s8_pr   AS DEC FORMAT "->>>>>>>>>9.99" INIT 0.
DEF  VAR n_sums8    AS DEC FORMAT "->>>>>>>>>9.99" INIT 0.
DEF  VAR n_prms8    AS DEC FORMAT "->>>>>>>>>9.99" INIT 0.
DEF  VAR p_s8       AS DEC FORMAT ">>9.99"         INIT 0.
DEF  VAR pv_s8_si   AS DEC FORMAT "->>>>>>>>>9.99" INIT 0.
DEF  VAR pv_s8_pr   AS DEC FORMAT "->>>>>>>>>9.99" INIT 0.
DEF  VAR iv_s8_si   AS DEC FORMAT "->>>>>>>>>9.99" INIT 0.
DEF  VAR iv_s8_pr   AS DEC FORMAT "->>>>>>>>>9.99" INIT 0.
DEF  VAR pv_s8_sib  AS DEC FORMAT "->>>>>>>>>9.99" INIT 0.
DEF  VAR pv_s8_prb  AS DEC FORMAT "->>>>>>>>>9.99" INIT 0.
DEF  VAR iv_s8_sib  AS DEC FORMAT "->>>>>>>>>9.99" INIT 0.
DEF  VAR iv_s8_prb  AS DEC FORMAT "->>>>>>>>>9.99" INIT 0.
DEF  VAR nv_s8_sib  AS DEC FORMAT "->>>>>>>>>9.99" INIT 0.
DEF  VAR nv_s8_prb  AS DEC FORMAT "->>>>>>>>>9.99" INIT 0.
DEF  VAR br_0f_sib    LIKE   nv_0f_sib.
DEF  VAR br_0f_prb    LIKE   nv_0f_prb.
DEF  VAR nv_prmtre AS DEC FORMAT "->>>>>>>>>9.99".
DEF VAR  nv_brdes  AS CHAR FORMAT "X(2)".
DEF VAR  nv_brdes1 AS CHAR FORMAT "X(2)".
DEF VAR  n_bran    AS CHAR FORMAT "X(2)".
DEF VAR  nv_brn_fr AS INTE.
DEF VAR  nv_brn_to AS INTE.
DEF VAR  i         AS INTE.
DEF VAR  n_cnt1    AS INTE.

DEFINE BUFFER buwd200 FOR uwd200.
DEF VAR  nv_totprmcom AS DEC FORMAT "->>>>>>>>>9.99" INIT 0.
DEF VAR  nv_totsumprm AS DEC FORMAT "->>>>>>>>>9.99" INIT 0.
DEF VAR  nv_totearn   AS DEC FORMAT "->>>>>>>>>9.99" INIT 0.
DEF VAR  nv_totuearn  AS DEC FORMAT "->>>>>>>>>9.99" INIT 0.
DEF VAR  nv_totearn1  AS DEC FORMAT "->>>>>>>>>9.99" INIT 0.
DEF VAR  nv_totuearn1 AS DEC FORMAT "->>>>>>>>>9.99" INIT 0.
/* comment by Benjaporn J. A58-0242
DEF VAR  nv_totprmtre AS DEC FORMAT "->>>>>>>>>9.99" INIT 0.
DEF VAR  nv_totearn2  AS DEC FORMAT "->>>>>>>>>9.99" INIT 0.
DEF VAR  nv_totuearn2 AS DEC FORMAT "->>>>>>>>>9.99" INIT 0.*/
/* start A58-0242 Benjaporn J. 13/07/2015 */
DEF VAR  nv_totprmtrt   AS DEC FORMAT "->>>>>>>>>9.99" INIT 0.
DEF VAR  nv_totearntrt  AS DEC FORMAT "->>>>>>>>>9.99" INIT 0.
DEF VAR  nv_totuearntrt AS DEC FORMAT "->>>>>>>>>9.99" INIT 0.
DEF VAR  nv_totprmfac   AS DEC FORMAT "->>>>>>>>>9.99" INIT 0.
DEF VAR  nv_totearnfac  AS DEC FORMAT "->>>>>>>>>9.99" INIT 0.
DEF VAR  nv_totuearnfac AS DEC FORMAT "->>>>>>>>>9.99" INIT 0.  /* end A58-0242 Benjaporn J. 13/07/2015 */

DEF WORKFILE wtotal
    FIELD branch    AS CHAR FORMAT "X(2)"
    FIELD poltyp    AS CHAR FORMAT "X(3)"
    FIELD totprmcom AS DEC FORMAT "->>>>>>>>>9.99"
    FIELD totsumprm AS DEC FORMAT "->>>>>>>>>9.99"
    FIELD totearn   AS DEC FORMAT "->>>>>>>>>9.99"
    FIELD totuearn  AS DEC FORMAT "->>>>>>>>>9.99"
    FIELD totearn1  AS DEC FORMAT "->>>>>>>>>9.99"
    FIELD totuearn1 AS DEC FORMAT "->>>>>>>>>9.99"
    /* comment by Benjaporn J. A58-0242
    FIELD totprmtre AS DEC FORMAT "->>>>>>>>>9.99"
    FIELD totearn2  AS DEC FORMAT "->>>>>>>>>9.99"
    FIELD totuearn2 AS DEC FORMAT "->>>>>>>>>9.99" */
     /* start A58-0242 Benjaporn J. 13/07/2015 */
    FIELD totprmtrt   AS DEC FORMAT "->>>>>>>>>9.99"
    FIELD totearntrt  AS DEC FORMAT "->>>>>>>>>9.99"                   
    FIELD totuearntrt AS DEC FORMAT "->>>>>>>>>9.99"
    FIELD totprmfac   AS DEC FORMAT "->>>>>>>>>9.99"
    FIELD totearnfac  AS DEC FORMAT "->>>>>>>>>9.99"                   
    FIELD totuearnfac AS DEC FORMAT "->>>>>>>>>9.99".  /* end A58-0242 Benjaporn J. 13/07/2015 */

DEF VAR nv_reptyp   AS INTE . /*Lukkana M. A55-0144 23/04/2012*/
DEF VAR nv_text     AS CHAR FORMAT "X(40)" . /*Lukkana M. A55-0144 23/04/2012*/
DEF VAR nv_text1    AS CHAR FORMAT "X(40)" . /*Lukkana M. A55-0144 23/04/2012*/
DEF VAR nv_text2    AS CHAR FORMAT "X(40)" . /*A56-0092*/
DEF VAR nv_stime    AS CHAR FORMAT "X(8)"  INITIAL "". /*Lukkana M. A55-0144 23/04/2012*/
DEF VAR nv_etime    AS CHAR FORMAT "X(8)"  INITIAL "". /*Lukkana M. A55-0144 23/04/2012*/

DEF STREAM ns1.
DEF STREAM ns2.
/*---By A56-0092---*/
DEF STREAM ns3.  
DEF BUFFER buwm100 FOR uwm100.   
DEF WORKFILE wtotal_c    /*Summary of Cancel-File*/
    FIELD branch    AS CHAR FORMAT "X(2)"
    FIELD poltyp    AS CHAR FORMAT "X(3)"
    FIELD totprmcom AS DEC FORMAT "->>>>>>>>>9.99"
    FIELD totsumprm AS DEC FORMAT "->>>>>>>>>9.99"
    FIELD totearn   AS DEC FORMAT "->>>>>>>>>9.99"
    FIELD totuearn  AS DEC FORMAT "->>>>>>>>>9.99"
    FIELD totearn1  AS DEC FORMAT "->>>>>>>>>9.99"
    FIELD totuearn1 AS DEC FORMAT "->>>>>>>>>9.99"
    /* comment by Benjaporn J. A58-0242
    FIELD totprmtre AS DEC FORMAT "->>>>>>>>>9.99"
    FIELD totearn2  AS DEC FORMAT "->>>>>>>>>9.99"
    FIELD totuearn2 AS DEC FORMAT "->>>>>>>>>9.99"  */
    /* start A58-0242 Benjaporn J. 13/07/2015 */
    FIELD totprmtrt    AS DEC FORMAT "->>>>>>>>>9.99"
    FIELD totearntrt   AS DEC FORMAT "->>>>>>>>>9.99"
    FIELD totuearntrt  AS DEC FORMAT "->>>>>>>>>9.99"
    FIELD totprmfac    AS DEC FORMAT "->>>>>>>>>9.99"
    FIELD totearnfac   AS DEC FORMAT "->>>>>>>>>9.99"
    FIELD totuearnfac  AS DEC FORMAT "->>>>>>>>>9.99".  /* end A58-0242 Benjaporn J. 13/07/2015 */
DEF VAR  nv_ctotprmcom AS DEC FORMAT "->>>>>>>>>9.99" INIT 0.
DEF VAR  nv_ctotsumprm AS DEC FORMAT "->>>>>>>>>9.99" INIT 0.
DEF VAR  nv_ctotearn   AS DEC FORMAT "->>>>>>>>>9.99" INIT 0.
DEF VAR  nv_ctotuearn  AS DEC FORMAT "->>>>>>>>>9.99" INIT 0.
DEF VAR  nv_ctotearn1  AS DEC FORMAT "->>>>>>>>>9.99" INIT 0.
DEF VAR  nv_ctotuearn1 AS DEC FORMAT "->>>>>>>>>9.99" INIT 0.
/* comment by Benjaporn J. A58-0242
DEF VAR  nv_ctotprmtre AS DEC FORMAT "->>>>>>>>>9.99" INIT 0.
DEF VAR  nv_ctotearn2  AS DEC FORMAT "->>>>>>>>>9.99" INIT 0.
DEF VAR  nv_ctotuearn2 AS DEC FORMAT "->>>>>>>>>9.99" INIT 0.*/
/* start A58-0242 Benjaporn J. 13/07/2015 */
DEF VAR  nv_ctotprmtrt   AS DEC FORMAT "->>>>>>>>>9.99" INIT 0.
DEF VAR  nv_ctotearntrt  AS DEC FORMAT "->>>>>>>>>9.99" INIT 0.
DEF VAR  nv_ctotuearntrt AS DEC FORMAT "->>>>>>>>>9.99" INIT 0.
DEF VAR  nv_ctotprmfac   AS DEC FORMAT "->>>>>>>>>9.99" INIT 0.
DEF VAR  nv_ctotearnfac  AS DEC FORMAT "->>>>>>>>>9.99" INIT 0.
DEF VAR  nv_ctotuearnfac AS DEC FORMAT "->>>>>>>>>9.99" INIT 0.  /* end A58-0242 Benjaporn J. 13/07/2015 */
/*---end A56-0092*/
DEF VAR  nv_releas   AS LOGICAL .   /*A58-0180*/
DEFINE  WORKFILE wfline NO-UNDO
/*1*/  FIELD nline   AS CHARACTER FORMAT "X(10)"   INITIAL "".
/* start A58-0242 Benjaporn J.13/07/2015 */
DEF VAR nv_prmtrt    AS DEC FORMAT "->>>>>>>>>9.99".
DEF VAR nv_earntrt   AS DECI.
DEF VAR nv_uearntrt  AS DECI. 
DEF VAR nv_prmfac    AS DEC FORMAT "->>>>>>>>>9.99".
DEF VAR nv_earnfac   AS DECI.
DEF VAR nv_uearnfac  AS DECI.  /* end A58-0242 Benjaporn J. 13/07/2015 */
/*-----A63-0159-----*/
DEF VAR nv_comdat    AS DATE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main
&Scoped-define BROWSE-NAME br_exline

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES wfline

/* Definitions for BROWSE br_exline                                     */
&Scoped-define FIELDS-IN-QUERY-br_exline wfline.nline   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_exline   
&Scoped-define SELF-NAME br_exline
&Scoped-define QUERY-STRING-br_exline FOR EACH wfline
&Scoped-define OPEN-QUERY-br_exline OPEN QUERY br_exline FOR EACH wfline.
&Scoped-define TABLES-IN-QUERY-br_exline wfline
&Scoped-define FIRST-TABLE-IN-QUERY-br_exline wfline


/* Definitions for FRAME fr_main                                        */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS RECT-111 RECT-112 RECT-113 fi_poltyp ~
fi_nline bu_add bu_del br_exline fi_asdate ra_reptyp fi_trndat fi_trndatto ~
fi_agentfr fi_agentto fi_releas fi_branchfr fi_branchto fi_output Bu_OK ~
Bu_Exit fi_brndes_fr fi_brndes_to fi_stime fi_etime 
&Scoped-Define DISPLAYED-OBJECTS fi_poltyp fi_nline fi_asdate ra_reptyp ~
fi_trndat fi_trndatto fi_agentfr fi_agentto fi_releas fi_branchfr ~
fi_branchto fi_output fi_brndes_fr fi_brndes_to fi_stime fi_etime 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bu_add 
     LABEL "ADD" 
     SIZE 6 BY 1.

DEFINE BUTTON bu_del 
     LABEL "DEL" 
     SIZE 6 BY 1.

DEFINE BUTTON Bu_Exit 
     LABEL "Exit" 
     SIZE 15 BY 1.24
     FONT 6.

DEFINE BUTTON Bu_OK 
     LABEL "OK" 
     SIZE 15 BY 1.24
     FONT 6.

DEFINE VARIABLE fi_agentfr AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 16.5 BY 1 NO-UNDO.

DEFINE VARIABLE fi_agentto AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 16.5 BY 1 NO-UNDO.

DEFINE VARIABLE fi_asdate AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 16.5 BY 1 NO-UNDO.

DEFINE VARIABLE fi_branchfr AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 6.5 BY 1 NO-UNDO.

DEFINE VARIABLE fi_branchto AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 6.5 BY 1 NO-UNDO.

DEFINE VARIABLE fi_brndes_fr AS CHARACTER FORMAT "X(30)":U 
      VIEW-AS TEXT 
     SIZE 50 BY 1
     BGCOLOR 3 FGCOLOR 7 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_brndes_to AS CHARACTER FORMAT "X(30)":U 
      VIEW-AS TEXT 
     SIZE 50 BY 1
     BGCOLOR 3 FGCOLOR 7 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_etime AS CHARACTER FORMAT "X(8)":U 
      VIEW-AS TEXT 
     SIZE 8 BY 1
     BGCOLOR 3 FGCOLOR 7  NO-UNDO.

DEFINE VARIABLE fi_nline AS CHARACTER FORMAT "X(5)":U 
     VIEW-AS FILL-IN 
     SIZE 11 BY 1 NO-UNDO.

DEFINE VARIABLE fi_output AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 60 BY 1 NO-UNDO.

DEFINE VARIABLE fi_poltyp AS CHARACTER FORMAT "X(1)":U 
     VIEW-AS FILL-IN 
     SIZE 5 BY 1 NO-UNDO.

DEFINE VARIABLE fi_releas AS CHARACTER FORMAT "X(1)":U 
     VIEW-AS FILL-IN 
     SIZE 6.5 BY 1 NO-UNDO.

DEFINE VARIABLE fi_stime AS CHARACTER FORMAT "X(8)":U 
      VIEW-AS TEXT 
     SIZE 9.83 BY 1
     BGCOLOR 3 FGCOLOR 7  NO-UNDO.

DEFINE VARIABLE fi_trndat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 16.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_trndatto AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 16.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE ra_reptyp AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "Earn", 1,
"Unearn", 2
     SIZE 27 BY 1
     BGCOLOR 3 FGCOLOR 7 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-111
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 120 BY 2.24
     BGCOLOR 3 .

DEFINE RECTANGLE RECT-112
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 120 BY 21.29
     BGCOLOR 3 .

DEFINE RECTANGLE RECT-113
     EDGE-PIXELS 3 GRAPHIC-EDGE  NO-FILL   
     SIZE 48 BY 1.76.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_exline FOR 
      wfline SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_exline
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_exline C-Win _FREEFORM
  QUERY br_exline DISPLAY
      wfline.nline    COLUMN-LABEL "Line"   FORMAT "x(10)"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 27 BY 5.52 ROW-HEIGHT-CHARS .57 FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     fi_poltyp AT ROW 3.52 COL 55.5 COLON-ALIGNED NO-LABEL
     fi_nline AT ROW 4.67 COL 68.83 COLON-ALIGNED NO-LABEL
     bu_add AT ROW 4.67 COL 82.83
     bu_del AT ROW 4.67 COL 89.33
     br_exline AT ROW 5.76 COL 57.5
     fi_asdate AT ROW 11.38 COL 55.5 COLON-ALIGNED NO-LABEL
     ra_reptyp AT ROW 12.52 COL 57.17 NO-LABEL
     fi_trndat AT ROW 13.62 COL 55.5 COLON-ALIGNED NO-LABEL
     fi_trndatto AT ROW 14.71 COL 55.5 COLON-ALIGNED NO-LABEL
     fi_agentfr AT ROW 15.81 COL 55.5 COLON-ALIGNED NO-LABEL
     fi_agentto AT ROW 16.91 COL 55.5 COLON-ALIGNED NO-LABEL
     fi_releas AT ROW 18 COL 55.5 COLON-ALIGNED NO-LABEL
     fi_branchfr AT ROW 19.1 COL 55.5 COLON-ALIGNED NO-LABEL
     fi_branchto AT ROW 20.19 COL 55.5 COLON-ALIGNED NO-LABEL
     fi_output AT ROW 21.29 COL 55.5 COLON-ALIGNED NO-LABEL
     Bu_OK AT ROW 22.71 COL 51.33
     Bu_Exit AT ROW 22.71 COL 70.83
     fi_brndes_fr AT ROW 19.1 COL 65.33 COLON-ALIGNED NO-LABEL
     fi_brndes_to AT ROW 20.19 COL 65.33 COLON-ALIGNED NO-LABEL
     fi_stime AT ROW 22.67 COL 97.5 COLON-ALIGNED NO-LABEL
     fi_etime AT ROW 22.67 COL 113.5 COLON-ALIGNED NO-LABEL
     "End :" VIEW-AS TEXT
          SIZE 5 BY 1 AT ROW 22.67 COL 110
          BGCOLOR 3 FGCOLOR 7 
     "As of Date :" VIEW-AS TEXT
          SIZE 12.67 BY 1 AT ROW 11.38 COL 39.5
          BGCOLOR 3 FONT 6
     "Releas Flag :" VIEW-AS TEXT
          SIZE 14.17 BY 1 AT ROW 18 COL 38.33
          BGCOLOR 3 FONT 6
     "Policy Type :" VIEW-AS TEXT
          SIZE 14.17 BY 1 AT ROW 3.52 COL 38.33
          BGCOLOR 3 FONT 6
     "Start :" VIEW-AS TEXT
          SIZE 5.67 BY 1 AT ROW 22.67 COL 93.33
          BGCOLOR 3 FGCOLOR 7 
     "Y = Yes , N = No , A = All" VIEW-AS TEXT
          SIZE 50 BY 1 AT ROW 18 COL 67.33
          BGCOLOR 3 FGCOLOR 7 FONT 6
     "Report Type :" VIEW-AS TEXT
          SIZE 12.67 BY 1 AT ROW 12.52 COL 38.17
          BGCOLOR 3 FONT 6
     "Output To :" VIEW-AS TEXT
          SIZE 12.17 BY 1 AT ROW 21.29 COL 40
          BGCOLOR 3 FONT 6
     "Branch Form :" VIEW-AS TEXT
          SIZE 14 BY 1 AT ROW 19.1 COL 37.67
          BGCOLOR 3 FONT 6
     "BranchTo :" VIEW-AS TEXT
          SIZE 13 BY 1 AT ROW 20.19 COL 40.33
          BGCOLOR 3 FONT 6
     "Insert Line :" VIEW-AS TEXT
          SIZE 12.5 BY 1 AT ROW 4.67 COL 57.83
          BGCOLOR 3 FONT 6
     "Agent From :" VIEW-AS TEXT
          SIZE 12.67 BY 1 AT ROW 15.81 COL 38.83
          BGCOLOR 3 FONT 6
     "AgentTo :" VIEW-AS TEXT
          SIZE 10.5 BY 1 AT ROW 16.91 COL 41.5
          BGCOLOR 3 FONT 6
     "Earn / Unearn Premium Report - Motor Include Policy Status ~"CA~"" VIEW-AS TEXT
          SIZE 68.5 BY 1.24 AT ROW 1.57 COL 33
          BGCOLOR 3 FGCOLOR 7 FONT 6
     "Transaction Date To :" VIEW-AS TEXT
          SIZE 23 BY 1 AT ROW 14.71 COL 30
          BGCOLOR 3 FONT 6
     "Transaction Date Form :" VIEW-AS TEXT
          SIZE 25 BY 1 AT ROW 13.62 COL 28
          BGCOLOR 3 FONT 6
     "1 = Motor ,  2 = Non-Motor" VIEW-AS TEXT
          SIZE 40.5 BY 1 AT ROW 3.52 COL 65.67
          BGCOLOR 3 FGCOLOR 7 FONT 6
     "Exclude Line :" VIEW-AS TEXT
          SIZE 15.33 BY 1 AT ROW 4.67 COL 37.17
          BGCOLOR 3 FONT 6
     RECT-111 AT ROW 1 COL 7
     RECT-112 AT ROW 3.29 COL 7
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 23.57.

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     RECT-113 AT ROW 22.43 COL 44.5
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 23.57.


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
         TITLE              = "<insert window title>"
         HEIGHT             = 23.57
         WIDTH              = 133
         MAX-HEIGHT         = 24
         MAX-WIDTH          = 133
         VIRTUAL-HEIGHT     = 24
         VIRTUAL-WIDTH      = 133
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
IF NOT C-Win:LOAD-ICON("I:/Safety/Walp11/WIMAGE/safety.ico":U) THEN
    MESSAGE "Unable to load icon: I:/Safety/Walp11/WIMAGE/safety.ico"
            VIEW-AS ALERT-BOX WARNING BUTTONS OK.
&ENDIF
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW C-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME fr_main
   FRAME-NAME                                                           */
/* BROWSE-TAB br_exline bu_del fr_main */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_exline
/* Query rebuild information for BROWSE br_exline
     _START_FREEFORM
OPEN QUERY br_exline FOR EACH wfline.
     _END_FREEFORM
     _Query            is NOT OPENED
*/  /* BROWSE br_exline */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* <insert window title> */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* <insert window title> */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br_exline
&Scoped-define SELF-NAME br_exline
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_exline C-Win
ON ROW-DISPLAY OF br_exline IN FRAME fr_main
DO:
    DEF VAR z AS INTE  INIT 0.
    DEF VAR s AS INTE  INIT 0.
    s = 1.
    z = 26.
    wfline.nline:BGCOLOR IN BROWSE  br_exline = z NO-ERROR.   

    wfline.nline:FGCOLOR IN BROWSE br_exline = s NO-ERROR.   
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_add
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_add C-Win
ON CHOOSE OF bu_add IN FRAME fr_main /* ADD */
DO:
    IF fi_nline = "" THEN DO:
        APPLY "ENTRY" TO fi_nline .
        disp fi_nline  with frame  fr_main.
    END.
    ELSE DO:
        FIND LAST wfline WHERE wfline.nline = trim(fi_nline) NO-ERROR NO-WAIT.
        IF NOT AVAIL wfline THEN DO:
            CREATE wfline.
            ASSIGN 
                wfline.nline   = trim(fi_nline)
                fi_nline      = "" .
        END.
    END.
    OPEN QUERY br_exline FOR EACH wfline.
    APPLY "ENTRY" TO fi_nline  .
    disp  fi_nline  with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_del
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_del C-Win
ON CHOOSE OF bu_del IN FRAME fr_main /* DEL */
DO:
    GET CURRENT br_exline EXCLUSIVE-LOCK.
    DELETE wfline .
    
    OPEN QUERY br_exline FOR EACH wfline.
        APPLY "ENTRY" TO fi_nline IN FRAME fr_main.
        disp  fi_nline with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Bu_Exit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Bu_Exit C-Win
ON CHOOSE OF Bu_Exit IN FRAME fr_main /* Exit */
DO:
  APPLY "CLOSE" TO THIS-PROCEDURE.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Bu_OK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Bu_OK C-Win
ON CHOOSE OF Bu_OK IN FRAME fr_main /* OK */
DO:
    ASSIGN nv_output  = fi_output 
           nv_output1 = fi_output + "_error"
           nv_output2 = fi_output + "_can"   /*A56-0092*/
           nv_text    =  ""   /*Lukkana M. A55-0144 23/04/2012*/
           nv_text1   =  ""   /*Lukkana M. A55-0144 23/04/2012*/
           nv_text2   =  ""   /*A56-0092*/
           fi_stime   = STRING(TIME,"HH:MM:SS"). /*Lukkana M. A55-0144 23/04/2012*/
    
    FIND FIRST sym100 USE-INDEX sym10001 WHERE 
               sym100.tabcod = "00"      NO-LOCK NO-ERROR. 
    IF AVAIL sym100 THEN DO:
        IF sym100.itmdes = "STY" THEN DO: /*เช็คถ้าเป็นของ STY ให้แยก loop เช็ค branch*/
            IF nv_reptyp = 1 THEN DO: /*Lukkana M. A55-0144 23/04/2012*/
                ASSIGN nv_text  = "Earn Premium Report"
                       nv_text1 = "Transaction Date : " + INPUT fi_trndat
                       nv_text2 = "Earn Premium Report - Cancel".   /*A56-0092*/
                IF fi_poltyp = '1' THEN DO:
                    RUN Pd_HeaderMotor.
                    RUN Pd_HeaderMotorerror.
                    RUN Pd_HeaderMotorCan.  /*A56-0092*/
                    RUN Pd_Motor_earn.
                    MESSAGE "Complete.." VIEW-AS ALERT-BOX.
                END.
                ELSE IF fi_poltyp = '2' THEN DO:
                    RUN Pd_HeaderNon.
                    RUN Pd_HeaderNonerror.
                    RUN Pd_HeaderNonCan.    /*A56-0092*/
                    RUN Pd_non_earn.
                    MESSAGE "Complete.." VIEW-AS ALERT-BOX.
                END.
            END.
            ELSE DO:  
                ASSIGN nv_text  = "Unearn Premium Report (Expiry Date)"
                       nv_text1 = ""                                 /*Lukkana M. A55-0144 23/04/2012*/
                       nv_text2 = "Unearn Premium Report - Cancel".  /*A56-0092*/
                IF fi_poltyp = '1' THEN DO:
                    RUN Pd_HeaderMotor.
                    RUN Pd_HeaderMotorerror.
                    RUN Pd_HeaderMotorCan.    /*A56-0092*/
                    /*RUN Pd_Motor.*/                            /*A58-0180  Motor  */
                    IF      fi_releas = "Y" THEN DO:
                        ASSIGN nv_releas = YES.
                        RUN Pd_Motor.                            /*A58-0180  by yes */
                    END.
                    ELSE IF fi_releas = "N" THEN DO:
                        ASSIGN nv_releas = NO.
                        RUN Pd_Motor.                            /*A58-0180  by no  */
                    END.
                    ELSE RUN Pd_Motor01.                         /*A58-0180  by All */
                    MESSAGE "Complete.. " VIEW-AS ALERT-BOX.
                END.
                ELSE IF fi_poltyp = '2' THEN DO:
                    RUN Pd_HeaderNon.
                    RUN Pd_HeaderNonerror.
                    RUN Pd_HeaderNonCan.      /*A56-0092*/
                    /*RUN Pd_Nonmotor.*/                            /*A58-0180  Motor  */
                    IF      fi_releas = "Y" THEN DO:
                        ASSIGN nv_releas = YES.
                        RUN Pd_Nonmotor.                            /*A58-0180  by yes */
                    END.
                    ELSE IF fi_releas = "N" THEN DO:
                        ASSIGN nv_releas = NO.
                        RUN Pd_Nonmotor.     /*A58-0180  by no  */
                    END.
                    ELSE RUN Pd_Nonmotor01.   /*A58-0180  by All */
                    MESSAGE "Complete.. " VIEW-AS ALERT-BOX.
                END.
            END.
        END.
        ELSE IF sym100.itmdes = "IAG" THEN DO: /*แยก loop เช็ค branch*/
            IF nv_reptyp = 1 THEN DO: /*Lukkana M. A55-0144 23/04/2012*/
                ASSIGN nv_text  = "Earn Premium Report"
                       nv_text1 = "Transaction Date : " + INPUT fi_trndat 
                       nv_text2 = "Earn Premium Report - Cancel".   /*A56-0092*/
                IF fi_poltyp = '1' THEN DO:
                    RUN Pd_HeaderMotor.
                    RUN Pd_HeaderMotorerror.
                    RUN Pd_HeaderMotorCan.     /*A56-0092*/
                    RUN Pd_Motor_earnNZI.
                    MESSAGE "Complete.." VIEW-AS ALERT-BOX.
                END.
                ELSE IF fi_poltyp = '2' THEN DO:
                    RUN Pd_HeaderNon.
                    RUN Pd_HeaderNonerror.
                    RUN Pd_HeaderNonCan.      /*A56-0092*/
                    RUN Pd_non_earnNZI.
                    MESSAGE "Complete.." VIEW-AS ALERT-BOX.
                END.
            END.
            ELSE DO:  
                ASSIGN nv_text  = "Unearn Premium Report (Expiry Date)"
                       nv_text1 = "" /*Lukkana M. A55-0144 23/04/2012*/
                       nv_text2 = "Unearn Premium Report - Cancel".  /*A56-0092*/
                IF fi_poltyp = '1' THEN DO:
                    RUN Pd_HeaderMotor.
                    RUN Pd_HeaderMotorerror.
                    RUN Pd_HeaderMotorCan.         /*A56-0092*/
                    /*RUN Pd_MotorNZI.*/
                    IF      fi_releas = "Y" THEN DO:
                         ASSIGN nv_releas = YES.
                         RUN Pd_MotorNZI.                       /*A58-0180  by yes */
                    END.
                    ELSE IF fi_releas = "N" THEN DO:
                         ASSIGN nv_releas = NO.
                         RUN Pd_MotorNZI.                       /*A58-0180  by no  */
                    END.
                    ELSE RUN Pd_MotorNZI01.                     /*A58-0180  by All */
                    MESSAGE "Complete.. " VIEW-AS ALERT-BOX.
                END.
                ELSE IF fi_poltyp = '2' THEN DO:
                    RUN Pd_HeaderNon.
                    RUN Pd_HeaderNonerror.
                    RUN Pd_HeaderNonCan.          /*A56-0092*/
                    /*RUN Pd_NonmotorNZI.*/                            /*A58-0180         */
                    IF      fi_releas = "Y" THEN DO: 
                        ASSIGN nv_releas = YES.
                        RUN Pd_NonmotorNZI.                            /*A58-0180  by yes */
                    END.
                    ELSE IF fi_releas = "N" THEN DO:
                        ASSIGN nv_releas = NO.
                        RUN Pd_NonmotorNZI.                            /*A58-0180  by no */
                    END.
                    ELSE RUN Pd_NonmotorNZI01.                         /*A58-0180  by All */

                    MESSAGE "Complete.. " VIEW-AS ALERT-BOX.
                END.
            END.
        END.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_agentfr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_agentfr C-Win
ON LEAVE OF fi_agentfr IN FRAME fr_main
DO:
  fi_agentfr = CAPS(INPUT fi_agentfr).
  /*IF fi_agentfr <> "" THEN DO:
      IF fi_agentfr <> "A000000000" THEN DO:

          FIND FIRST xmm600 USE-INDEX xmm60001 WHERE xmm600.acno =  fi_agentfr NO-LOCK NO-ERROR.
          IF AVAIL xmm600 THEN
              ASSIGN
                 fi_acnodes_fr     = TRIM(xmm600.ntitle) + " " + TRIM(xmm600.name).
          ELSE DO:
              ASSIGN 
                  fi_agentfr      = ""
                  fi_acnodes_fr   = "".
                  
              MESSAGE "Not on Name & Address Master File xmm600" VIEW-AS ALERT-BOX
              WARNING TITLE "Confirm".
          END.

      END.
      DISP fi_agentfr fi_acnodes_fr WITH FRAME fr_main.
  END.
  ELSE DO:
      MESSAGE "From account no. can not empty." VIEW-AS ALERT-BOX
      WARNING TITLE "Confirm".
      fi_agentfr     =  "".
      fi_acnodes_fr  =  "".
      DISPLAY  fi_agentfr  fi_acnodes_fr  WITH FRAME fr_main.
  END.*/
  DISP fi_agentfr WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_agentto
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_agentto C-Win
ON LEAVE OF fi_agentto IN FRAME fr_main
DO:
  fi_agentto = CAPS(INPUT fi_agentto).
  /*IF fi_agentto <> "" THEN DO:

      IF fi_agentto < fi_agentfr THEN DO:
          MESSAGE 'Last Account No. must >= First Account No.' VIEW-AS ALERT-BOX
          WARNING TITLE "Confirm".
          APPLY "ENTRY" TO fi_agentto.
          RETURN NO-APPLY.
      END.  

      IF fi_agentto <> "B999999999" THEN DO:

          FIND FIRST xmm600 USE-INDEX xmm60001 WHERE xmm600.acno =  fi_agentto NO-LOCK NO-ERROR.
          IF AVAIL xmm600 THEN
              ASSIGN
                 fi_acnodes_to     = TRIM(xmm600.ntitle) + " " + TRIM(xmm600.name).
          ELSE DO:
              ASSIGN 
                  fi_agentto      = ""
                  fi_acnodes_to   = "".
              MESSAGE "Not on Name & Address Master File xmm600" VIEW-AS ALERT-BOX
              WARNING TITLE "Confirm".
          END.
      END.
      ELSE fi_acnodes_to = "".

      DISP fi_agentto fi_acnodes_to WITH FRAME fr_main.
  END.
  ELSE DO:
      MESSAGE "From account no. can not empty." VIEW-AS ALERT-BOX
      WARNING TITLE "Confirm".
      fi_agentto  =  "".
      fi_acnodes_to  =  "".
      DISPLAY  fi_agentto  fi_acnodes_to  WITH FRAME fr_main.
  END.*/
  DISP fi_agentto WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_asdate
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_asdate C-Win
ON LEAVE OF fi_asdate IN FRAME fr_main
DO:
  fi_asdate = INPUT fi_asdate.
  DISP fi_asdate WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_asdate C-Win
ON RETURN OF fi_asdate IN FRAME fr_main
DO:
  APPLY "ENTRY" TO ra_reptyp.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_branchfr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_branchfr C-Win
ON LEAVE OF fi_branchfr IN FRAME fr_main
DO:
  fi_branchfr = CAPS(INPUT fi_branchfr).
  /*IF fi_branchfr <> "" THEN DO:
      FIND FIRST xmm023 WHERE xmm023.branch = INPUT fi_branchfr NO-LOCK  NO-ERROR.
      IF AVAIL xmm023 THEN DO :
          fi_brndes_fr = CAPS(xmm023.bdes).
          DISPLAY  fi_branchfr  fi_brndes_fr WITH FRAME fr_main. 
      END.
      ELSE DO:
          MESSAGE "Branch is not found ! " VIEW-AS  ALERT-BOX  
          WARNING TITLE "Confirm".
          fi_branchfr  =  "".
          fi_brndes_fr  =  "".
          DISPLAY  fi_branchfr  fi_brndes_fr  WITH FRAME fr_main.
      END.
  END.
  ELSE DO:
      MESSAGE "Branch is not found ! " VIEW-AS  ALERT-BOX  
      WARNING TITLE "Confirm".
      fi_branchfr  =  "".
      fi_brndes_fr  =  "".
      DISPLAY  fi_branchfr  fi_brndes_fr  WITH FRAME fr_main.

  END.*/
  DISPLAY  fi_branchfr  WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_branchto
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_branchto C-Win
ON LEAVE OF fi_branchto IN FRAME fr_main
DO:
  fi_branchto = CAPS(INPUT fi_branchto).
  /*IF fi_branchto <> "" THEN DO:
  
      IF fi_branchto < fi_branchfr THEN DO:
          MESSAGE 'Last Branch must >= First Branch.' VIEW-AS ALERT-BOX
          WARNING TITLE "Confirm".
          APPLY "ENTRY" TO fi_branchto.
          RETURN NO-APPLY.
      END.
    
      FIND FIRST xmm023 WHERE xmm023.branch = INPUT fi_branchto NO-LOCK  NO-ERROR.
      IF AVAIL xmm023 THEN DO :
          fi_brndes_to = CAPS(xmm023.bdes).
          DISPLAY  fi_branchto  fi_brndes_to WITH FRAME fr_main. 
      END.
      ELSE DO:
          MESSAGE "Branch is not found ! " VIEW-AS  ALERT-BOX  
          WARNING TITLE "Confirm".
          fi_branchto  =  "".
          fi_brndes_to  =  "".
          DISPLAY  fi_branchto  fi_brndes_to  WITH FRAME fr_main.
      END.
  END.
  ELSE DO:
      MESSAGE "Branch is not found ! " VIEW-AS  ALERT-BOX  
      WARNING TITLE "Confirm".
      fi_branchto  =  "".
      fi_brndes_to  =  "".
      DISPLAY  fi_branchto  fi_brndes_to  WITH FRAME fr_main.
  END.*/
  DISPLAY  fi_branchto  WITH FRAME fr_main.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_etime
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_etime C-Win
ON LEAVE OF fi_etime IN FRAME fr_main
DO:
  fi_etime = INPUT fi_etime.
  DISP fi_etime WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_nline
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_nline C-Win
ON LEAVE OF fi_nline IN FRAME fr_main
DO:
  fi_nline = CAPS(TRIM( INPUT fi_nline)).
  DISP fi_nline WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_output
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_output C-Win
ON LEAVE OF fi_output IN FRAME fr_main
DO:
  fi_output = INPUT fi_output.

  IF fi_output = "" THEN DO:
      MESSAGE 'Output To file Name' VIEW-AS ALERT-BOX ERROR.
      APPLY "ENTRY" TO fi_output.
      
  END.
  DISP fi_output WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_poltyp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_poltyp C-Win
ON LEAVE OF fi_poltyp IN FRAME fr_main
DO:
  fi_poltyp = INPUT fi_poltyp.

  IF fi_poltyp <> '1' AND fi_poltyp <> '2' THEN DO:
      MESSAGE "Policy Type = 1 OR 2" VIEW-AS ALERT-BOX ERROR.
      APPLY "ENTRY" TO fi_poltyp.
      RETURN NO-APPLY.
  END.
  /*ASSIGN
      fi_exc1   = ""    fi_exc2   = ""
      fi_exc3   = ""    fi_exc4   = ""
      fi_exc5   = ""    fi_exc6   = ""
      fi_exc7   = ""    fi_exc8   = ""
      fi_exc9   = ""    fi_exc10  = ""
      fi_exc11  = ""    fi_exc12  = ""
      fi_exc13  = ""    fi_exc14  = ""
      fi_exc15  = ""    fi_exc16  = ""
      fi_exc17  = ""    fi_exc18  = ""
      fi_exc19  = ""    fi_exc20  = "".*/

  DISP fi_poltyp 
       /*fi_exc1 fi_exc2  fi_exc3  fi_exc4 
       fi_exc5  fi_exc6  fi_exc7  fi_exc8  fi_exc9 
       fi_exc10 fi_exc11 fi_exc12 fi_exc13 fi_exc14 
       fi_exc15 fi_exc16 fi_exc17 fi_exc18 fi_exc19 fi_exc20 */
      WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_releas
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_releas C-Win
ON LEAVE OF fi_releas IN FRAME fr_main
DO:
    fi_releas = Caps(INPUT fi_releas) .
    IF fi_releas <> "Y" AND fi_releas <> "N" AND fi_releas <> "A"  THEN DO:
        MESSAGE "Releas Flag = Y  OR  N  OR  A " VIEW-AS ALERT-BOX ERROR.
        APPLY "ENTRY" TO fi_releas.
        RETURN NO-APPLY.
    END.

  DISP fi_releas WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_stime
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_stime C-Win
ON LEAVE OF fi_stime IN FRAME fr_main
DO:
  fi_stime = INPUT fi_stime.
  DISP fi_stime WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_trndat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_trndat C-Win
ON LEAVE OF fi_trndat IN FRAME fr_main
DO:
  fi_trndat = INPUT fi_trndat.
  DISP fi_trndat WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_trndat C-Win
ON RETURN OF fi_trndat IN FRAME fr_main
DO:
  APPLY "ENTRY" TO fi_agentfr.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_trndatto
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_trndatto C-Win
ON LEAVE OF fi_trndatto IN FRAME fr_main
DO:
  fi_trndatto = INPUT fi_trndatto.
    IF fi_trndatto <> ? THEN DO:
        IF   fi_trndatto <  fi_trndat THEN DO:
            MESSAGE "Transdat To must be lest than TransdatForm !!!" VIEW-AS ALERT-BOX.
            APPLY "ENTRY" TO fi_trndatto.
            RETURN NO-APPLY.
        END.
    END.
    DISP fi_trndatto fi_trndat WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_trndatto C-Win
ON RETURN OF fi_trndatto IN FRAME fr_main
DO:
  APPLY "ENTRY" TO fi_agentfr.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ra_reptyp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_reptyp C-Win
ON enter OF ra_reptyp IN FRAME fr_main
DO:
  /*Lukkana M. A55-0144 23/04/2012*/
  IF  ra_reptyp = 1 THEN DO: 
      ENABLE fi_trndat WITH FRAME fr_main.
      APPLY "ENTRY" TO fi_trndat.
  END.
  ELSE DO: 
      APPLY "ENTRY" TO fi_agentfr.
      fi_trndat = ?.
      DISP fi_trndat WITH FRAME fr_main.
  END.
  /*Lukkana M. A55-0144 23/04/2012*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_reptyp C-Win
ON return OF ra_reptyp IN FRAME fr_main
DO:
  /*Lukkana M. A55-0144 23/04/2012*/
  IF  ra_reptyp = 1 THEN DO: 
      ENABLE fi_trndat WITH FRAME fr_main.
      APPLY "ENTRY" TO fi_trndat.
  END.
  ELSE DO: 
      APPLY "ENTRY" TO fi_agentfr.
      fi_trndat = ?.
      DISP fi_trndat WITH FRAME fr_main.
  END.
  /*Lukkana M. A55-0144 23/04/2012*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_reptyp C-Win
ON VALUE-CHANGED OF ra_reptyp IN FRAME fr_main
DO:
  /*Lukkana M. A55-0144 23/04/2012*/
    ra_reptyp = INPUT ra_reptyp .
    IF INPUT ra_reptyp = 1 THEN DO: 
        ASSIGN 
            fi_trndatto  = ?
            nv_reptyp    = 1.
      /*  ENABLE  fi_trndat   WITH FRAME fr_main .
     DISABLE fi_trndatto WITH FRAME fr_main. /*A58-0180*/  */
        ENABLE  fi_trndat fi_trndatto WITH FRAME fr_main . /* A58-0242 Benjaporn J. 13/07/2015 */
        DISP fi_trndat fi_trndatto    WITH FRAME fr_main . /*kridtiya i. a58-0180*/
        APPLY "ENTRY" TO fi_trndat .
    END.
    ELSE IF INPUT ra_reptyp = 2  THEN DO: 
        ASSIGN 
            nv_reptyp    = 2
            fi_trndatto  = TODAY.
        /*fi_trndat = ?.*/
        ENABLE fi_trndat fi_trndatto WITH FRAME fr_main . /*kridtiya i. a58-0180*/
        DISP fi_trndat fi_trndatto   WITH FRAME fr_main . /*kridtiya i. a58-0180*/
        APPLY "ENTRY" TO fi_trndat .                      /*kridtiya i. a58-0180*/
        /*DISABLE fi_trndat WITH FRAME fr_main.*/ /*kridtiya i. a58-0180*/
    END.
  /*Lukkana M. A55-0144 23/04/2012*/
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
  DEF  VAR  gv_prgid   AS   CHAR  FORMAT "X(8)"   NO-UNDO.
  DEF  VAR  gv_prog    AS   CHAR  FORMAT "X(40)" NO-UNDO.
  
  gv_prgid = "WACR61".
  gv_prog  = "Earn/Unearn Premium Report Include (CA)".
  RUN  WUT\WUTHEAD (c-win:HANDLE,gv_prgid,gv_prog).

/*********************************************************************/  

  RUN  WUT\WUTWICEN (c-win:HANDLE).  
  SESSION:DATA-ENTRY-RETURN = YES.  

  ASSIGN
      fi_poltyp    = '1'
      fi_asdate    = TODAY
      fi_trndat    = TODAY
      /*fi_trndatto  = TODAY*/
      fi_agentfr   = 'A000000000'
      fi_agentto   = 'B999999999'
      fi_releas    = 'Y'
      fi_branchfr  = '0'
      fi_branchto  = 'Z' 
      ra_reptyp    = 1 .  /*Lukkana M. A55-0144 23/04/2012*/
  FOR EACH wfline.
        DELETE wfline.
  END.
  IF      INPUT ra_reptyp = 1 THEN nv_reptyp = 1.  /*Lukkana M. A55-0144 23/04/2012*/
  ELSE IF INPUT ra_reptyp = 2 THEN nv_reptyp = 2.  /*Lukkana M. A55-0144 23/04/2012*/

  DISP fi_poltyp fi_asdate fi_agentfr fi_agentto fi_releas fi_branchfr fi_branchto
       fi_trndat  fi_trndatto  ra_reptyp  WITH FRAME fr_main.
  /*DISABLE fi_trndat WITH FRAME fr_main. /*Lukkana M. A55-0144 23/04/2012*/*/
  /*DISABLE fi_trndatto WITH FRAME fr_main. /*A58-0180*/*/
  ENABLE fi_trndatto WITH FRAME fr_main. /* A58-0242 Benjaporn J. 13/07/2015 */

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
  DISPLAY fi_poltyp fi_nline fi_asdate ra_reptyp fi_trndat fi_trndatto 
          fi_agentfr fi_agentto fi_releas fi_branchfr fi_branchto fi_output 
          fi_brndes_fr fi_brndes_to fi_stime fi_etime 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE RECT-111 RECT-112 RECT-113 fi_poltyp fi_nline bu_add bu_del br_exline 
         fi_asdate ra_reptyp fi_trndat fi_trndatto fi_agentfr fi_agentto 
         fi_releas fi_branchfr fi_branchto fi_output Bu_OK Bu_Exit fi_brndes_fr 
         fi_brndes_to fi_stime fi_etime 
      WITH FRAME fr_main IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pd_Checkbranch C-Win 
PROCEDURE Pd_Checkbranch :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
nv_brdes  = "".
nv_brn_fr = 0.
nv_brn_to = 0.
i = 0.
IF INDEX("ABCDEFGHIJKLMNOPQRSTUVWXYZ" , fi_branchto) <> 0 THEN DO: /*branch เป็นตัวอักษร*/
    
    loop1:
    FOR EACH xmm023 USE-INDEX xmm02301  WHERE 
             xmm023.branch >= fi_branchfr AND
             xmm023.branch <= fi_branchto NO-LOCK: /*BREAK BY branch: Lukkana M. A55-0144 25/04/2012*/
        IF xmm023.branch < fi_branchfr OR xmm023.branch > fi_branchto THEN NEXT loop1.
        
        IF LENGTH(xmm023.branch) = 1 THEN DO:
            nv_brdes = nv_brdes + "," + xmm023.branch.
        END.
        ELSE DO:
            IF SUBSTR(xmm023.branch,1,1) = "9" AND SUBSTR(xmm023.branch,2,1) <> "0" THEN DO:
                nv_brdes  = nv_brdes + "," + substr(xmm023.branch,2,1).
                nv_brdes  = nv_brdes + "," + xmm023.branch.
                nv_brdes1 = nv_brdes1 + "," + xmm023.branch.
            END.
            ELSE nv_brdes = nv_brdes + "," + xmm023.branch.
        END.

    END.
END.
ELSE DO: /*แสดงว่าเป็นตัวเลข*/
    nv_brn_fr = INTE(fi_branchfr).
    nv_brn_to = INTE(fi_branchto).

    loop2:
    FOR EACH xmm023 USE-INDEX xmm02301  WHERE 
             xmm023.branch >= fi_branchfr AND
             xmm023.branch <= fi_branchto NO-LOCK:  /*BREAK BY branch: Lukkana M. A55-0144 25/04/2012*/
 
        IF LENGTH(xmm023.branch) = 1 THEN DO:
           nv_brdes = nv_brdes + "," + xmm023.branch.
        END.
        ELSE DO:
            IF SUBSTR(xmm023.branch,1,1) = "9" AND SUBSTR(xmm023.branch,2,1) <> "0" THEN DO:
                nv_brdes  = nv_brdes + "," + substr(xmm023.branch,2,1).
                nv_brdes  = nv_brdes + "," + xmm023.branch.
                nv_brdes1 = nv_brdes1 + "," + xmm023.branch.
            END.
            ELSE nv_brdes = nv_brdes + "," + xmm023.branch.
            
            IF LENGTH(fi_branchfr) = 1 AND LENGTH(fi_branchto) = 2 THEN DO: /*วนค่าในกรณีที่เรียกbranch form-to 1-10*/
                DO i = nv_brn_fr TO nv_brn_to:
                    nv_brdes = nv_brdes + "," + STRING(i).
                END.
            END.
        END.
    END.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pd_Cleartreaty C-Win 
PROCEDURE Pd_Cleartreaty :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

ASSIGN
    nv_0t_sib   = 0      nv_incsib    = 0         nv_decsib    = 0
    nv_0t_prb   = 0      nv_incpremb  = 0         nv_decpremb = 0      
    nv_0s_sib   = 0      pv_f1_sib    = 0         iv_f1_sib    = 0
    nv_0s_prb   = 0      pv_f1_prb    = 0         iv_f1_prb    = 0
    nv_stat_sib = 0      pv_f2_sib    = 0         iv_f2_sib    = 0
    nv_stat_prb = 0      pv_f2_prb    = 0         iv_f2_prb    = 0
    nv_0q_sib   = 0      pv_0t_sib    = 0         iv_0t_sib    = 0
    nv_0q_prb   = 0      pv_0t_prb    = 0         iv_0t_prb    = 0
    nv_0rq_sib  = 0      pv_0s_sib    = 0         iv_0s_sib    = 0
    nv_0rq_prb  = 0      pv_0s_prb    = 0         iv_0s_prb    = 0
    nv_totsib   = 0      pv_stat_sib  = 0         iv_stat_sib  = 0
    nv_totpremb = 0
    pv_stat_prb = 0      iv_stat_prb  = 0
    nv_f1_sib   = 0      pv_0q_sib    = 0         iv_0q_sib    = 0
    nv_f1_prb   = 0      pv_0q_prb    = 0         iv_0q_prb    = 0
    nv_f2_sib   = 0      pv_0rq_sib   = 0         iv_0rq_sib   = 0
    nv_f2_prb   = 0      pv_0rq_prb   = 0         iv_0rq_prb   = 0
    nv_ret_sib  = 0      pv_ret_sib   = 0         iv_ret_sib   = 0
    nv_ret_prb  = 0      pv_ret_prb   = 0         iv_ret_prb   = 0
    nv_0f_sib   = 0      pv_0f_sib    = 0         iv_0f_sib    = 0
    nv_0f_prb   = 0      pv_0f_prb    = 0         iv_0f_prb    = 0
    
    nv_0ps_sib  = 0      pv_0ps_sib   = 0         iv_0ps_sib   = 0
    nv_0ps_prb  = 0      pv_0ps_prb   = 0         iv_0ps_prb   = 0
    
    nv_btr_sib  = 0      pv_btr_sib   = 0         iv_btr_sib   = 0
    nv_btr_prb  = 0      pv_btr_prb   = 0         iv_btr_prb   = 0
    nv_otr_sib  = 0      pv_otr_sib   = 0         iv_otr_sib   = 0
    nv_otr_prb  = 0      pv_otr_prb   = 0         iv_otr_prb   = 0

    nv_s8_sib   = 0      pv_s8_sib    = 0         iv_s8_sib    = 0
    nv_s8_prb   = 0      pv_s8_prb    = 0         iv_s8_prb    = 0

    nv_f4_sib   = 0      pv_f4_sib    = 0         iv_f4_sib    = 0
    nv_f4_prb   = 0      pv_f4_prb    = 0         iv_f4_prb    = 0
    nv_ftr_sib  = 0      pv_ftr_sib   = 0         iv_ftr_sib   = 0
    nv_ftr_prb  = 0      pv_ftr_prb   = 0         iv_ftr_prb   = 0.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pd_DetailMotor C-Win 
PROCEDURE Pd_DetailMotor :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       /* A63-0159 */
------------------------------------------------------------------------------*/
RUN pd_initdata.
IF  nv_expdat <> ? AND nv_expdat >= 0 AND nv_expdat <= 3650 THEN DO: 
       
        IF nv_expdat > 367 THEN nv_expdat = 366.   

        nv_count  = nv_count + 1 .
    
        IF fi_asdate - uwm100.comdat >= 0 THEN nv_datecal = fi_asdate - uwm100.comdat + 1.
        ELSE nv_datecal = 0.
    
        IF nv_datecal >= nv_expdat THEN nv_earn = n_prmcom.
        ELSE nv_earn = (n_prmcom / nv_expdat) * nv_datecal.
        nv_uearn = n_prmcom - nv_earn.   /*-- Earn , Uearn พรบ.---*/
        
        IF nv_datecal >= nv_expdat THEN nv_earn1 = n_sumprm.
        ELSE nv_earn1 = (n_sumprm / nv_expdat) * nv_datecal.
        nv_uearn1 = n_sumprm - nv_earn1.  /*-- Earn , Uearn รถยนต์---*/

        FIND LAST buwm100 NO-LOCK USE-INDEX uwm10001 WHERE buwm100.policy = uwm100.policy
                                                       AND buwm100.endcnt > uwm100.endcnt
                                                       AND buwm100.polsta = "CA"  NO-ERROR.
        IF AVAIL buwm100 THEN DO:
           nv_uearn = 0.
           nv_uearn1 = 0.
        END.
        ELSE DO:
           nv_uearn = nv_uearn.
           nv_uearn1 = nv_uearn1.
        END.
        
        PUT STREAM ns1 nv_dir                                                 "|"
                       n_branch                                               "|"   
                       uwm100.poltyp                                          "|"    
                       uwm100.trndat FORMAT "99/99/9999"                      "|"   
                       uwm100.policy                                          "|"  
                       uwm100.endno  FORMAT "X(10)"                           "|"
                       uwm100.comdat     FORMAT "99/99/9999"                      "|"    
                       uwm100.expdat FORMAT "99/99/9999"                      "|" 
                       nv_expdat     FORMAT ">>>>>>9"                         "|"
                       nv_datecal    FORMAT ">>>>>>9"                         "|"
                       n_prmcom      FORMAT "->>,>>>,>>>,>>>.99"              "|" 
                       n_sumprm      FORMAT "->>,>>>,>>>,>>>.99"              "|" 
                       nv_earn       FORMAT "->>,>>>,>>>,>>>.99"              "|" 
                       nv_uearn      FORMAT "->>,>>>,>>>,>>>.99"              "|"
                       nv_earn1      FORMAT "->>,>>>,>>>,>>>.99"              "|"
                       nv_uearn1     FORMAT "->>,>>>,>>>,>>>.99"              "|".
        
        FOR EACH wrk0f:
          FIND xmm600 WHERE xmm600.acno = wrk0f.rico NO-LOCK NO-ERROR.
          IF AVAILABLE xmm600 THEN DO:
            IF (xmm600.clicod = "RD") OR (xmm600.clicod = "RB") THEN
              ASSIGN
                 n_rb_pf   = n_rb_pf  + wrk0f.pf
                 n_rb_sum  = n_rb_sum + wrk0f.sumf
                 n_rb_prm  = n_rb_prm + (wrk0f.prmf * (-1)) .
            ELSE IF (xmm600.clicod = "RF") OR 
                    (xmm600.clicod = "RA") THEN  
         ASSIGN  n_rf_pf   = n_rf_pf  + wrk0f.pf
                 n_rf_sum  = n_rf_sum + wrk0f.sumf
                 n_rf_prm  = n_rf_prm + (wrk0f.prmf * (-1)) .
          END.      
        END. /* END FOR EACH wrk0f */
             /* start A58-0242 Benjaporn J. 13/07/2015 */
             /*---Treaty---*/
            nv_prmtrt = n_prmf1 + n_prmf2 + n_prmt + n_prms + n_prmq + n_prmtfp +
                        n_prmps + n_prmbtr + n_prmotr + n_prms8 + n_prmf4 + n_prmftr + n_prmrq.    

            IF   nv_datecal >= nv_expdat THEN nv_earntrt = nv_prmtrt.
            ELSE nv_earntrt = (nv_prmtrt / nv_expdat) * nv_datecal.
            nv_uearntrt = nv_prmtrt - nv_earntrt.
             /*---FAC---*/
            nv_prmfac = n_rf_prm + n_rb_prm .                   
            
            IF   nv_datecal >= nv_expdat THEN nv_earnfac = nv_prmfac.
            ELSE nv_earnfac = (nv_prmfac / nv_expdat) * nv_datecal.
            nv_uearnfac = nv_prmfac - nv_earnfac. /* end A58-0242 Benjaporn J. 13/07/2015 */
        
            ASSIGN /*Grand total*/
            nv_totprmcom   = nv_totprmcom   + n_prmcom    
            nv_totsumprm   = nv_totsumprm   + n_sumprm    
            nv_totearn     = nv_totearn     + nv_earn     
            nv_totuearn    = nv_totuearn    + nv_uearn    
            nv_totearn1    = nv_totearn1    + nv_earn1    
            nv_totuearn1   = nv_totuearn1   + nv_uearn1 
               /* start A58-0242 Benjaporn J. 13/07/2015 */
            nv_totprmtrt   = nv_totprmtrt   + nv_prmtrt
            nv_totearntrt  = nv_totearntrt  + nv_earntrt 
            nv_totuearntrt = nv_totuearntrt + nv_uearntrt
            nv_totprmfac   = nv_totprmfac   + nv_prmfac
            nv_totearnfac  = nv_totearnfac  + nv_earnfac 
            nv_totuearnfac = nv_totuearnfac + nv_uearnfac.

            PUT STREAM ns1
                nv_prmtrt   FORMAT "->>,>>>,>>>,>>>.99" "|" 
                nv_earntrt  FORMAT "->>,>>>,>>>,>>>.99" "|" 
                nv_uearntrt FORMAT "->>,>>>,>>>,>>>.99" "|"
                nv_prmfac   FORMAT "->>,>>>,>>>,>>>.99" "|" 
                nv_earnfac  FORMAT "->>,>>>,>>>,>>>.99" "|" 
                nv_uearnfac FORMAT "->>,>>>,>>>,>>>.99" "|"  /* end A58-0242 Benjaporn J. 13/07/2015 */
                uwm100.polsta SKIP.      /*A56-0092*/

            FOR EACH wrk0f:    DELETE wrk0f.   END.

            ASSIGN n_rb_pf     = 0     n_rb_sum    = 0
                   n_rb_prm    = 0     nv_prmtre   = 0
                   n_prmf1     = 0     n_prmf2     = 0 
                   n_prmt      = 0     n_prms      = 0 
                   n_prmq      = 0     n_prmtfp    = 0
                   n_prmps     = 0     n_prmbtr    = 0
                   n_prmotr    = 0     n_prms8     = 0 
                   n_prmf4     = 0     n_prmftr    = 0.
 END.
 ELSE DO:
        n_count = n_count + 1.
        IF fi_asdate - uwm100.comdat >= 0 THEN nv_datecal = fi_asdate - uwm100.comdat + 1.
        ELSE nv_datecal = 0.
     
        IF nv_datecal >= nv_expdat THEN nv_earn = n_prmcom.
        ELSE nv_earn = (n_prmcom / nv_expdat) * nv_datecal.
        nv_uearn = n_prmcom - nv_earn.    /*-- Earn , Uearn พรบ.---*/
      
        IF nv_datecal >= nv_expdat THEN nv_earn1 = n_sumprm.
        ELSE nv_earn1 = (n_sumprm / nv_expdat) * nv_datecal.
        nv_uearn1 = n_sumprm - nv_earn1.  /*-- Earn , Uearn รถยนต์---*/

        FIND LAST buwm100 NO-LOCK USE-INDEX uwm10001 WHERE buwm100.policy = uwm100.policy
                                                       AND buwm100.endcnt > uwm100.endcnt
                                                       AND buwm100.polsta = "CA"  NO-ERROR.
        IF AVAIL buwm100 THEN DO:
           nv_uearn = 0.
           nv_uearn1 = 0.
        END.
        ELSE DO:
           nv_uearn = nv_uearn.
           nv_uearn1 = nv_uearn1.
        END.
        
        PUT STREAM ns2 nv_dir                                                 "|"
                       n_branch                                               "|"   
                       uwm100.poltyp                                          "|"    
                       uwm100.trndat FORMAT "99/99/9999"                      "|"   
                       uwm100.policy                                          "|"  
                       uwm100.endno  FORMAT "X(10)"                           "|"
                       uwm100.comdat FORMAT "99/99/9999"                      "|"    
                       uwm100.expdat FORMAT "99/99/9999"                      "|" 
                       nv_expdat     FORMAT "->>>>>>9"                        "|"
                       nv_datecal    FORMAT "->>>>>>9"                        "|"
                       n_prmcom      FORMAT "->>,>>>,>>>,>>>.99"              "|" 
                       n_sumprm      FORMAT "->>,>>>,>>>,>>>.99"              "|" 
                       nv_earn       FORMAT "->>,>>>,>>>,>>>.99"              "|" 
                       nv_uearn      FORMAT "->>,>>>,>>>,>>>.99"              "|"
                       nv_earn1      FORMAT "->>,>>>,>>>,>>>.99"              "|"
                       nv_uearn1     FORMAT "->>,>>>,>>>,>>>.99"              "|" .
  FOR EACH wrk0f:
          FIND xmm600 WHERE xmm600.acno = wrk0f.rico NO-LOCK NO-ERROR.
          IF AVAILABLE xmm600 THEN DO:
            IF (xmm600.clicod = "RD") OR (xmm600.clicod = "RB") THEN
              ASSIGN
                 n_rb_pf   = n_rb_pf  + wrk0f.pf
                 n_rb_sum  = n_rb_sum + wrk0f.sumf
                 n_rb_prm  = n_rb_prm + (wrk0f.prmf * (-1)) .
            ELSE IF (xmm600.clicod = "RF") OR 
                    (xmm600.clicod = "RA") THEN  
                   ASSIGN
                      n_rf_pf   = n_rf_pf  + wrk0f.pf
                      n_rf_sum  = n_rf_sum + wrk0f.sumf
                      n_rf_prm  = n_rf_prm + (wrk0f.prmf * (-1)) .
          END.      
        END. /* END FOR EACH wrk0f */
       /* start A58-0242 Benjaporn J. 13/07/2015 */
             /*---Treaty---*/
            nv_prmtrt = n_prmf1 + n_prmf2 + n_prmt + n_prms + n_prmq + n_prmtfp +
                        n_prmps + n_prmbtr + n_prmotr + n_prms8 + n_prmf4 + n_prmftr + n_prmrq.    

            IF   nv_datecal >= nv_expdat THEN nv_earntrt = nv_prmtrt.
            ELSE nv_earntrt = (nv_prmtrt / nv_expdat) * nv_datecal.
            nv_uearntrt = nv_prmtrt - nv_earntrt.
             /*---FAC---*/
            nv_prmfac = n_rf_prm + n_rb_prm .                   
            
            IF   nv_datecal >= nv_expdat THEN nv_earnfac = nv_prmfac.
            ELSE nv_earnfac = (nv_prmfac / nv_expdat) * nv_datecal.
            nv_uearnfac = nv_prmfac - nv_earnfac. 
   PUT STREAM ns2 
                nv_prmtrt   FORMAT "->>,>>>,>>>,>>>.99" "|" 
                nv_earntrt  FORMAT "->>,>>>,>>>,>>>.99" "|" 
                nv_uearntrt FORMAT "->>,>>>,>>>,>>>.99" "|"
                nv_prmfac   FORMAT "->>,>>>,>>>,>>>.99" "|" 
                nv_earnfac  FORMAT "->>,>>>,>>>,>>>.99" "|" 
                nv_uearnfac FORMAT "->>,>>>,>>>,>>>.99" "|" /* end A58-0242 Benjaporn J. 13/07/2015 */
                uwm100.polsta SKIP.      /*A56-0092*/

        FOR EACH wrk0f:  DELETE wrk0f.  END.

        ASSIGN n_rb_pf     = 0       n_rb_sum    = 0
               n_rb_prm    = 0      
               n_prmf1     = 0       n_prmf2     = 0 
               n_prmt      = 0       n_prms      = 0 
               n_prmq      = 0       n_prmtfp    = 0
               n_prmps     = 0       n_prmbtr    = 0
               n_prmotr    = 0       n_prms8     = 0 
               n_prmf4     = 0       n_prmftr    = 0.
    END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pd_DetailMotor_Backup C-Win 
PROCEDURE Pd_DetailMotor_Backup :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
RUN pd_initdata.
FIND LAST buwm100 USE-INDEX uwm10001 WHERE 
          buwm100.policy = uwm100.policy AND
          buwm100.polsta = "CA"          AND 
          buwm100.RELEAS = YES NO-LOCK NO-ERROR.
IF AVAIL  buwm100  THEN DO:

   IF nv_expdat <> ? AND nv_expdat >= 0 AND nv_expdat <= 3650 THEN DO: 
       nv_count  = nv_count + 1.
       n_count1  = n_count1 + 1.   /*A56-0092*/
   
       IF fi_asdate - uwm100.comdat >= 0 THEN nv_datecal = fi_asdate - uwm100.comdat + 1.
       ELSE nv_datecal = 0.
       /*-- Earn , Uearn พรบ.---*/
       IF nv_datecal >= nv_expdat THEN nv_earn = n_prmcom.
       ELSE nv_earn = (n_prmcom / nv_expdat) * nv_datecal.
       nv_uearn = n_prmcom - nv_earn. 
  
       IF nv_datecal >= nv_expdat THEN nv_earn1 = n_sumprm.
       ELSE nv_earn1 = (n_sumprm / nv_expdat) * nv_datecal.
       nv_uearn1 = n_sumprm - nv_earn1. 

   PUT STREAM ns3
               nv_dir                                                 "|"
               n_branch                                               "|"   
               uwm100.poltyp                                          "|"    
               uwm100.trndat FORMAT "99/99/9999"                      "|"   
               uwm100.policy                                          "|"  
               uwm100.endno  FORMAT "X(10)"                           "|"
               uwm100.comdat FORMAT "99/99/9999"                      "|"    
               uwm100.expdat FORMAT "99/99/9999"                      "|" 
               nv_expdat     FORMAT ">>>>>>9"                         "|"
               nv_datecal    FORMAT ">>>>>>9"                         "|"
               n_prmcom      FORMAT "->>,>>>,>>>,>>>.99"              "|" 
               n_sumprm      FORMAT "->>,>>>,>>>,>>>.99"              "|" 
               nv_earn       FORMAT "->>,>>>,>>>,>>>.99"              "|" 
               nv_uearn      FORMAT "->>,>>>,>>>,>>>.99"              "|"
               nv_earn1      FORMAT "->>,>>>,>>>,>>>.99"              "|"
               nv_uearn1     FORMAT "->>,>>>,>>>,>>>.99"              "|".
 FOR EACH wrk0f:
       FIND xmm600 WHERE xmm600.acno = wrk0f.rico NO-LOCK NO-ERROR.
       IF AVAILABLE xmm600 THEN DO:
          IF (xmm600.clicod = "RD") OR (xmm600.clicod = "RB") THEN
             ASSIGN  n_rb_pf   = n_rb_pf  + wrk0f.pf
                     n_rb_sum  = n_rb_sum + wrk0f.sumf
                     n_rb_prm  = n_rb_prm + (wrk0f.prmf * (-1)) .
          ELSE IF (xmm600.clicod = "RF") OR 
                  (xmm600.clicod = "RA") THEN  
             ASSIGN  n_rf_pf   = n_rf_pf  + wrk0f.pf
                     n_rf_sum  = n_rf_sum + wrk0f.sumf
                     n_rf_prm  = n_rf_prm + (wrk0f.prmf * (-1)) .
       END.      
   END. /* END FOR EACH wrk0f */
       /* start A58-0242 Benjaporn J. 13/07/2015 */
             /*---Treaty---*/
            nv_prmtrt = n_prmf1 + n_prmf2 + n_prmt + n_prms + n_prmq + n_prmtfp +
                        n_prmps + n_prmbtr + n_prmotr + n_prms8 + n_prmf4 + n_prmftr + n_prmrq.    

            IF   nv_datecal >= nv_expdat THEN nv_earntrt = nv_prmtrt.
            ELSE nv_earntrt = (nv_prmtrt / nv_expdat) * nv_datecal.
            nv_uearntrt = nv_prmtrt - nv_earntrt.
             /*---FAC---*/
            nv_prmfac = n_rf_prm + n_rb_prm .                   
            
            IF   nv_datecal >= nv_expdat THEN nv_earnfac = nv_prmfac.
            ELSE nv_earnfac = (nv_prmfac / nv_expdat) * nv_datecal.
            nv_uearnfac = nv_prmfac - nv_earnfac. /* end A58-0242 Benjaporn J. 13/07/2015 */
  ASSIGN /*Grand total*/
       nv_ctotprmcom   = nv_ctotprmcom   + n_prmcom    
       nv_ctotsumprm   = nv_ctotsumprm   + n_sumprm    
       nv_ctotearn     = nv_ctotearn     + nv_earn     
       nv_ctotuearn    = nv_ctotuearn    + nv_uearn    
       nv_ctotearn1    = nv_ctotearn1    + nv_earn1    
       nv_ctotuearn1   = nv_ctotuearn1   + nv_uearn1 
      /* start A58-0242 Benjaporn J. 13/07/2015 */
       nv_ctotprmtrt   = nv_ctotprmtrt   + nv_prmtrt
       nv_ctotearntrt  = nv_ctotearntrt  + nv_earntrt 
       nv_ctotuearntrt = nv_ctotuearntrt + nv_uearntrt
       nv_ctotprmfac   = nv_ctotprmfac   + nv_prmfac 
       nv_ctotearnfac  = nv_ctotearnfac  + nv_earnfac 
       nv_ctotuearnfac = nv_ctotuearnfac + nv_uearnfac.

PUT STREAM ns3  
       nv_prmtrt   FORMAT "->>,>>>,>>>,>>>.99" "|" 
       nv_earntrt  FORMAT "->>,>>>,>>>,>>>.99" "|" 
       nv_uearntrt FORMAT "->>,>>>,>>>,>>>.99" "|"
       nv_prmfac   FORMAT "->>,>>>,>>>,>>>.99" "|" 
       nv_earnfac  FORMAT "->>,>>>,>>>,>>>.99" "|" 
       nv_uearnfac FORMAT "->>,>>>,>>>,>>>.99" "|" /* end A58-0242 Benjaporn J. 13/07/2015 */
       uwm100.polsta SKIP.
       
   FOR EACH wrk0f: DELETE wrk0f.  END.
   ASSIGN n_rb_pf     = 0     n_rb_sum    = 0
          n_rb_prm    = 0     nv_prmtre   = 0
          n_prmf1     = 0     
          n_prmf2     = 0     
          n_prmt      = 0     n_prms      = 0 
          n_prmq      = 0     n_prmtfp    = 0
          n_prmps     = 0     n_prmbtr    = 0
          n_prmotr    = 0     n_prms8     = 0 
          n_prmf4     = 0     n_prmftr    = 0 .
   END.
   ELSE DO:
        n_count = n_count + 1.
        IF fi_asdate - uwm100.comdat >= 0 THEN nv_datecal = fi_asdate - uwm100.comdat + 1.
        ELSE nv_datecal = 0.
      
        IF nv_datecal >= nv_expdat THEN nv_earn = n_prmcom.
        ELSE nv_earn = (n_prmcom / nv_expdat) * nv_datecal.
        nv_uearn = n_prmcom - nv_earn.   /*-- Earn , Uearn พรบ.---*/
        
        IF nv_datecal >= nv_expdat THEN nv_earn1 = n_sumprm.
        ELSE nv_earn1 = (n_sumprm / nv_expdat) * nv_datecal.
        nv_uearn1 = n_sumprm - nv_earn1.   /*-- Earn , Uearn รถยนต์---*/
        
        PUT STREAM ns2 nv_dir                                                 "|"
                       n_branch                                               "|"   
                       uwm100.poltyp                                          "|"    
                       uwm100.trndat FORMAT "99/99/9999"                      "|"   
                       uwm100.policy                                          "|"  
                       uwm100.endno  FORMAT "X(10)"                           "|"
                       uwm100.comdat FORMAT "99/99/9999"                      "|"    
                       uwm100.expdat FORMAT "99/99/9999"                      "|" 
                       nv_expdat     FORMAT "->>>>>>9"                        "|"
                       nv_datecal    FORMAT "->>>>>>9"                        "|"
                       n_prmcom      FORMAT "->>,>>>,>>>,>>>.99"              "|" 
                       n_sumprm      FORMAT "->>,>>>,>>>,>>>.99"              "|" 
                       nv_earn       FORMAT "->>,>>>,>>>,>>>.99"              "|" 
                       nv_uearn      FORMAT "->>,>>>,>>>,>>>.99"              "|"
                       nv_earn1      FORMAT "->>,>>>,>>>,>>>.99"              "|"
                       nv_uearn1     FORMAT "->>,>>>,>>>,>>>.99"              "|" .
   FOR EACH wrk0f:
          FIND xmm600 WHERE xmm600.acno = wrk0f.rico NO-LOCK NO-ERROR.
          IF AVAILABLE xmm600 THEN DO:
            IF (xmm600.clicod = "RD") OR (xmm600.clicod = "RB") THEN
              ASSIGN
                 n_rb_pf   = n_rb_pf  + wrk0f.pf
                 n_rb_sum  = n_rb_sum + wrk0f.sumf
                 n_rb_prm  = n_rb_prm + (wrk0f.prmf * (-1)) .
            ELSE IF (xmm600.clicod = "RF") OR 
                    (xmm600.clicod = "RA") THEN  
                   ASSIGN
                      n_rf_pf   = n_rf_pf  + wrk0f.pf
                      n_rf_sum  = n_rf_sum + wrk0f.sumf
                      n_rf_prm  = n_rf_prm + (wrk0f.prmf * (-1)) .
          END.      
        END. /* END FOR EACH wrk0f */
         /* start A58-0242 Benjaporn J. 13/07/2015 */
             /*---Treaty---*/
            nv_prmtrt = n_prmf1 + n_prmf2 + n_prmt + n_prms + n_prmq + n_prmtfp +
                        n_prmps + n_prmbtr + n_prmotr + n_prms8 + n_prmf4 + n_prmftr + n_prmrq.    

            IF   nv_datecal >= nv_expdat THEN nv_earntrt = nv_prmtrt.
            ELSE nv_earntrt = (nv_prmtrt / nv_expdat) * nv_datecal.
            nv_uearntrt = nv_prmtrt - nv_earntrt.
             /*---FAC---*/
            nv_prmfac = n_rf_prm + n_rb_prm .                   
            
            IF   nv_datecal >= nv_expdat THEN nv_earnfac = nv_prmfac.
            ELSE nv_earnfac = (nv_prmfac / nv_expdat) * nv_datecal.
            nv_uearnfac = nv_prmfac - nv_earnfac. 
        
        PUT STREAM ns2 
                nv_prmtrt   FORMAT "->>,>>>,>>>,>>>.99" "|" 
                nv_earntrt  FORMAT "->>,>>>,>>>,>>>.99" "|" 
                nv_uearntrt FORMAT "->>,>>>,>>>,>>>.99" "|"
                nv_prmfac   FORMAT "->>,>>>,>>>,>>>.99" "|" 
                nv_earnfac  FORMAT "->>,>>>,>>>,>>>.99" "|" 
                nv_uearnfac FORMAT "->>,>>>,>>>,>>>.99" "|" /* end A58-0242 Benjaporn J. 13/07/2015 */
                uwm100.polsta SKIP.      /*A56-0092*/
            
        FOR EACH wrk0f:  DELETE wrk0f.  END.
        ASSIGN n_rb_pf     = 0      n_rb_sum    = 0
               n_rb_prm    = 0      
               n_prmf1     = 0      n_prmf2     = 0 
               n_prmt      = 0      n_prms      = 0 
               n_prmq      = 0      n_prmtfp    = 0
               n_prmps     = 0      n_prmbtr    = 0
               n_prmotr    = 0      n_prms8     = 0 
               n_prmf4     = 0      n_prmftr    = 0.
    END.
END.  /*---end Add A56-0092---*/
ELSE DO:        /*---For not Cancel---*/
 IF  nv_expdat <> ? AND nv_expdat >= 0 AND nv_expdat <= 3650 THEN DO: 
        nv_count  = nv_count + 1 .
    
        IF fi_asdate - uwm100.comdat >= 0 THEN nv_datecal = fi_asdate - uwm100.comdat + 1.
        ELSE nv_datecal = 0.
    
        IF nv_datecal >= nv_expdat THEN nv_earn = n_prmcom.
        ELSE nv_earn = (n_prmcom / nv_expdat) * nv_datecal.
        nv_uearn = n_prmcom - nv_earn.   /*-- Earn , Uearn พรบ.---*/
        
        IF nv_datecal >= nv_expdat THEN nv_earn1 = n_sumprm.
        ELSE nv_earn1 = (n_sumprm / nv_expdat) * nv_datecal.
        nv_uearn1 = n_sumprm - nv_earn1.  /*-- Earn , Uearn รถยนต์---*/
        
        PUT STREAM ns1 nv_dir                                                 "|"
                       n_branch                                               "|"   
                       uwm100.poltyp                                          "|"    
                       uwm100.trndat FORMAT "99/99/9999"                      "|"   
                       uwm100.policy                                          "|"  
                       uwm100.endno  FORMAT "X(10)"                           "|"
                       uwm100.comdat FORMAT "99/99/9999"                      "|"    
                       uwm100.expdat FORMAT "99/99/9999"                      "|" 
                       nv_expdat     FORMAT ">>>>>>9"                         "|"
                       nv_datecal    FORMAT ">>>>>>9"                         "|"
                       n_prmcom      FORMAT "->>,>>>,>>>,>>>.99"              "|" 
                       n_sumprm      FORMAT "->>,>>>,>>>,>>>.99"              "|" 
                       nv_earn       FORMAT "->>,>>>,>>>,>>>.99"              "|" 
                       nv_uearn      FORMAT "->>,>>>,>>>,>>>.99"              "|"
                       nv_earn1      FORMAT "->>,>>>,>>>,>>>.99"              "|"
                       nv_uearn1     FORMAT "->>,>>>,>>>,>>>.99"              "|".
        
        FOR EACH wrk0f:
          FIND xmm600 WHERE xmm600.acno = wrk0f.rico NO-LOCK NO-ERROR.
          IF AVAILABLE xmm600 THEN DO:
            IF (xmm600.clicod = "RD") OR (xmm600.clicod = "RB") THEN
              ASSIGN
                 n_rb_pf   = n_rb_pf  + wrk0f.pf
                 n_rb_sum  = n_rb_sum + wrk0f.sumf
                 n_rb_prm  = n_rb_prm + (wrk0f.prmf * (-1)) .
            ELSE IF (xmm600.clicod = "RF") OR 
                    (xmm600.clicod = "RA") THEN  
         ASSIGN  n_rf_pf   = n_rf_pf  + wrk0f.pf
                 n_rf_sum  = n_rf_sum + wrk0f.sumf
                 n_rf_prm  = n_rf_prm + (wrk0f.prmf * (-1)) .
          END.      
        END. /* END FOR EACH wrk0f */
             /* start A58-0242 Benjaporn J. 13/07/2015 */
             /*---Treaty---*/
            nv_prmtrt = n_prmf1 + n_prmf2 + n_prmt + n_prms + n_prmq + n_prmtfp +
                        n_prmps + n_prmbtr + n_prmotr + n_prms8 + n_prmf4 + n_prmftr + n_prmrq.    

            IF   nv_datecal >= nv_expdat THEN nv_earntrt = nv_prmtrt.
            ELSE nv_earntrt = (nv_prmtrt / nv_expdat) * nv_datecal.
            nv_uearntrt = nv_prmtrt - nv_earntrt.
             /*---FAC---*/
            nv_prmfac = n_rf_prm + n_rb_prm .                   
            
            IF   nv_datecal >= nv_expdat THEN nv_earnfac = nv_prmfac.
            ELSE nv_earnfac = (nv_prmfac / nv_expdat) * nv_datecal.
            nv_uearnfac = nv_prmfac - nv_earnfac. /* end A58-0242 Benjaporn J. 13/07/2015 */
        
            ASSIGN /*Grand total*/
            nv_totprmcom   = nv_totprmcom   + n_prmcom    
            nv_totsumprm   = nv_totsumprm   + n_sumprm    
            nv_totearn     = nv_totearn     + nv_earn     
            nv_totuearn    = nv_totuearn    + nv_uearn    
            nv_totearn1    = nv_totearn1    + nv_earn1    
            nv_totuearn1   = nv_totuearn1   + nv_uearn1 
               /* start A58-0242 Benjaporn J. 13/07/2015 */
            nv_totprmtrt   = nv_totprmtrt   + nv_prmtrt
            nv_totearntrt  = nv_totearntrt  + nv_earntrt 
            nv_totuearntrt = nv_totuearntrt + nv_uearntrt
            nv_totprmfac   = nv_totprmfac   + nv_prmfac
            nv_totearnfac  = nv_totearnfac  + nv_earnfac 
            nv_totuearnfac = nv_totuearnfac + nv_uearnfac.

            PUT STREAM ns1
                nv_prmtrt   FORMAT "->>,>>>,>>>,>>>.99" "|" 
                nv_earntrt  FORMAT "->>,>>>,>>>,>>>.99" "|" 
                nv_uearntrt FORMAT "->>,>>>,>>>,>>>.99" "|"
                nv_prmfac   FORMAT "->>,>>>,>>>,>>>.99" "|" 
                nv_earnfac  FORMAT "->>,>>>,>>>,>>>.99" "|" 
                nv_uearnfac FORMAT "->>,>>>,>>>,>>>.99" "|"  /* end A58-0242 Benjaporn J. 13/07/2015 */
                uwm100.polsta SKIP.      /*A56-0092*/

            FOR EACH wrk0f:    DELETE wrk0f.   END.

            ASSIGN n_rb_pf     = 0     n_rb_sum    = 0
                   n_rb_prm    = 0     nv_prmtre   = 0
                   n_prmf1     = 0     n_prmf2     = 0 
                   n_prmt      = 0     n_prms      = 0 
                   n_prmq      = 0     n_prmtfp    = 0
                   n_prmps     = 0     n_prmbtr    = 0
                   n_prmotr    = 0     n_prms8     = 0 
                   n_prmf4     = 0     n_prmftr    = 0.
 END.
 ELSE DO:
        n_count = n_count + 1.
        IF fi_asdate - uwm100.comdat >= 0 THEN nv_datecal = fi_asdate - uwm100.comdat + 1.
        ELSE nv_datecal = 0.
     
        IF nv_datecal >= nv_expdat THEN nv_earn = n_prmcom.
        ELSE nv_earn = (n_prmcom / nv_expdat) * nv_datecal.
        nv_uearn = n_prmcom - nv_earn.    /*-- Earn , Uearn พรบ.---*/
      
        IF nv_datecal >= nv_expdat THEN nv_earn1 = n_sumprm.
        ELSE nv_earn1 = (n_sumprm / nv_expdat) * nv_datecal.
        nv_uearn1 = n_sumprm - nv_earn1.  /*-- Earn , Uearn รถยนต์---*/
        
        PUT STREAM ns2 nv_dir                                                 "|"
                       n_branch                                               "|"   
                       uwm100.poltyp                                          "|"    
                       uwm100.trndat FORMAT "99/99/9999"                      "|"   
                       uwm100.policy                                          "|"  
                       uwm100.endno  FORMAT "X(10)"                           "|"
                       uwm100.comdat FORMAT "99/99/9999"                      "|"    
                       uwm100.expdat FORMAT "99/99/9999"                      "|" 
                       nv_expdat     FORMAT "->>>>>>9"                        "|"
                       nv_datecal    FORMAT "->>>>>>9"                        "|"
                       n_prmcom      FORMAT "->>,>>>,>>>,>>>.99"              "|" 
                       n_sumprm      FORMAT "->>,>>>,>>>,>>>.99"              "|" 
                       nv_earn       FORMAT "->>,>>>,>>>,>>>.99"              "|" 
                       nv_uearn      FORMAT "->>,>>>,>>>,>>>.99"              "|"
                       nv_earn1      FORMAT "->>,>>>,>>>,>>>.99"              "|"
                       nv_uearn1     FORMAT "->>,>>>,>>>,>>>.99"              "|" .
  FOR EACH wrk0f:
          FIND xmm600 WHERE xmm600.acno = wrk0f.rico NO-LOCK NO-ERROR.
          IF AVAILABLE xmm600 THEN DO:
            IF (xmm600.clicod = "RD") OR (xmm600.clicod = "RB") THEN
              ASSIGN
                 n_rb_pf   = n_rb_pf  + wrk0f.pf
                 n_rb_sum  = n_rb_sum + wrk0f.sumf
                 n_rb_prm  = n_rb_prm + (wrk0f.prmf * (-1)) .
            ELSE IF (xmm600.clicod = "RF") OR 
                    (xmm600.clicod = "RA") THEN  
                   ASSIGN
                      n_rf_pf   = n_rf_pf  + wrk0f.pf
                      n_rf_sum  = n_rf_sum + wrk0f.sumf
                      n_rf_prm  = n_rf_prm + (wrk0f.prmf * (-1)) .
          END.      
        END. /* END FOR EACH wrk0f */
       /* start A58-0242 Benjaporn J. 13/07/2015 */
             /*---Treaty---*/
            nv_prmtrt = n_prmf1 + n_prmf2 + n_prmt + n_prms + n_prmq + n_prmtfp +
                        n_prmps + n_prmbtr + n_prmotr + n_prms8 + n_prmf4 + n_prmftr + n_prmrq.    

            IF   nv_datecal >= nv_expdat THEN nv_earntrt = nv_prmtrt.
            ELSE nv_earntrt = (nv_prmtrt / nv_expdat) * nv_datecal.
            nv_uearntrt = nv_prmtrt - nv_earntrt.
             /*---FAC---*/
            nv_prmfac = n_rf_prm + n_rb_prm .                   
            
            IF   nv_datecal >= nv_expdat THEN nv_earnfac = nv_prmfac.
            ELSE nv_earnfac = (nv_prmfac / nv_expdat) * nv_datecal.
            nv_uearnfac = nv_prmfac - nv_earnfac. 
   PUT STREAM ns2 
                nv_prmtrt   FORMAT "->>,>>>,>>>,>>>.99" "|" 
                nv_earntrt  FORMAT "->>,>>>,>>>,>>>.99" "|" 
                nv_uearntrt FORMAT "->>,>>>,>>>,>>>.99" "|"
                nv_prmfac   FORMAT "->>,>>>,>>>,>>>.99" "|" 
                nv_earnfac  FORMAT "->>,>>>,>>>,>>>.99" "|" 
                nv_uearnfac FORMAT "->>,>>>,>>>,>>>.99" "|" /* end A58-0242 Benjaporn J. 13/07/2015 */
                uwm100.polsta SKIP.      /*A56-0092*/

        FOR EACH wrk0f:  DELETE wrk0f.  END.

        ASSIGN n_rb_pf     = 0       n_rb_sum    = 0
               n_rb_prm    = 0      
               n_prmf1     = 0       n_prmf2     = 0 
               n_prmt      = 0       n_prms      = 0 
               n_prmq      = 0       n_prmtfp    = 0
               n_prmps     = 0       n_prmbtr    = 0
               n_prmotr    = 0       n_prms8     = 0 
               n_prmf4     = 0       n_prmftr    = 0.
    END.
END.    /*end Else do:   for cancel*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_detailmotor_old C-Win 
PROCEDURE pd_detailmotor_old :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:    comment by Benjaporn J. A58-0242 13/07/2015
------------------------------------------------------------------------------*/
/* ASSIGN nv_prstp   =  uwm100.pstp + uwm100.rstp
       nv_prtax   =  uwm100.ptax + uwm100.rtax
       nv_sumpts  =  uwm100.prem_t + nv_prstp + nv_prtax - n_paprm - n_tstppa - n_taxpa
       n_sumprm   =  uwm100.prem_t - n_prmcom - n_paprm
       n_sumstp   =  nv_prstp - n_tstpcom - n_tstppa
       n_sumtax   =  nv_prtax
       n_compa_t  =  - n_paprm * nv_com1p / 100
       nu_tax = n_sumtax - n_taxpa
       nu_prm = n_prmcom + n_sumprm + n_tstpcom + n_sumstp
       nu_vat = nu_tax.

ASSIGN nv_expdat  = 0        nv_datecal = 0
    nv_earn    = 0        nv_uearn   = 0
    nv_earn1   = 0        nv_uearn1  = 0
    /*nv_earn2   = 0        nv_uearn2  = 0*/
    nv_prmtre  = 0.

nv_expdat  = uwm100.expdat - uwm100.comdat + 1.
/*------------------------------------------------By A56-0092--------------------------------------------------*/
/*---Add By A56-0092---*/
FIND LAST buwm100 USE-INDEX uwm10001 WHERE 
         buwm100.policy = uwm100.policy AND
         buwm100.polsta = "CA"          AND 
         buwm100.RELEAS = YES NO-LOCK NO-ERROR.
IF AVAIL buwm100  THEN DO:

   IF nv_expdat <> ? AND nv_expdat >= 0 AND nv_expdat <= 3650 THEN DO: /*เช็คเงื่อนไขเพื่อแยกข้อมูล error ออกเป็นอีกไฟล์*/
       nv_count  = nv_count + 1.
       n_count1  = n_count1 + 1.   /*A56-0092*/
   
       IF fi_asdate - uwm100.comdat > 0 THEN nv_datecal = fi_asdate - uwm100.comdat + 1.
       ELSE nv_datecal = 0.
       
       /*-- Earn , Uearn พรบ.---*/
       IF nv_datecal >= nv_expdat THEN nv_earn = n_prmcom.
       ELSE nv_earn = (n_prmcom / nv_expdat) * nv_datecal.
       
       nv_uearn = n_prmcom - nv_earn.
       /*-- Earn , Uearn พรบ.---*/
       
       /*-- Earn , Uearn รถยนต์---*/
       IF nv_datecal >= nv_expdat THEN nv_earn1 = n_sumprm.
       ELSE nv_earn1 = (n_sumprm / nv_expdat) * nv_datecal.
       
       nv_uearn1 = n_sumprm - nv_earn1.
       /*-- Earn , Uearn รถยนต์---*/

   PUT STREAM ns3
               nv_dir                                                 "|"
               n_branch                                               "|"   
               uwm100.poltyp                                          "|"    
               uwm100.trndat FORMAT "99/99/9999"                      "|"   
               uwm100.policy                                          "|"  
               uwm100.endno  FORMAT "X(10)"                           "|"
               uwm100.comdat FORMAT "99/99/9999"                      "|"    
               uwm100.expdat FORMAT "99/99/9999"                      "|" 
               nv_expdat     FORMAT ">>>>>>9"                         "|"
               nv_datecal    FORMAT ">>>>>>9"                         "|"
               n_prmcom      FORMAT "->>,>>>,>>>,>>>.99"              "|" 
               n_sumprm      FORMAT "->>,>>>,>>>,>>>.99"              "|" 
               nv_earn       FORMAT "->>,>>>,>>>,>>>.99"              "|" 
               nv_uearn      FORMAT "->>,>>>,>>>,>>>.99"              "|"
               nv_earn1      FORMAT "->>,>>>,>>>,>>>.99"              "|"
               nv_uearn1     FORMAT "->>,>>>,>>>,>>>.99"              "|".

   FOR EACH wrk0f:
       FIND xmm600 WHERE xmm600.acno = wrk0f.rico NO-LOCK NO-ERROR.
       IF AVAILABLE xmm600 THEN DO:
          IF (xmm600.clicod = "RD") OR (xmm600.clicod = "RB") THEN
             ASSIGN  n_rb_pf   = n_rb_pf  + wrk0f.pf
                     n_rb_sum  = n_rb_sum + wrk0f.sumf
                     n_rb_prm  = n_rb_prm + (wrk0f.prmf * (-1)) .
          ELSE IF (xmm600.clicod = "RF") OR 
                  (xmm600.clicod = "RA") THEN  
             ASSIGN  n_rf_pf   = n_rf_pf  + wrk0f.pf
                     n_rf_sum  = n_rf_sum + wrk0f.sumf
                     n_rf_prm  = n_rf_prm + (wrk0f.prmf * (-1)) .
       END.      
   END. /* END FOR EACH wrk0f */
        
   /*nv_prmtre = n_prmf1 + n_prmf2 + n_prmt + n_prms + n_prmq + n_prmtfp +
               n_prmps + n_prmbtr + n_prmotr + n_prms8 + n_prmf4 + n_prmftr + 
               n_rf_prm + n_rb_prm + n_prmrq . /*Lukkana M. A55-0357 20/11/2012*/
        
   /*-- Earn , Uearn เบี้ย ceded---*/
   IF nv_datecal >= nv_expdat THEN nv_earn2 = nv_prmtre.
   ELSE nv_earn2 = (nv_prmtre / nv_expdat) * nv_datecal.
   
   nv_uearn2 = nv_prmtre - nv_earn2.
   /*-- Earn , Uearn เบี้ย ceded---*/*/
        
   ASSIGN /*Grand total*/
       nv_ctotprmcom = nv_ctotprmcom + n_prmcom    
       nv_ctotsumprm = nv_ctotsumprm + n_sumprm    
       nv_ctotearn   = nv_ctotearn   + nv_earn     
       nv_ctotuearn  = nv_ctotuearn  + nv_uearn    
       nv_ctotearn1  = nv_ctotearn1  + nv_earn1    
       nv_ctotuearn1 = nv_ctotuearn1 + nv_uearn1   
       /*nv_ctotprmtre = nv_ctotprmtre + nv_prmtre
       nv_ctotearn2  = nv_ctotearn2  + nv_earn2 
       nv_ctotuearn2 = nv_ctotuearn2 + nv_uearn2.*/
   
   PUT STREAM ns3
     /*  nv_prmtre FORMAT "->>,>>>,>>>,>>>.99" "|" 
       nv_earn2  FORMAT "->>,>>>,>>>,>>>.99" "|" 
       nv_uearn2 FORMAT "->>,>>>,>>>,>>>.99" "|" */
       uwm100.polsta SKIP.      /*A56-0092*/
            
   FOR EACH wrk0f:
       DELETE wrk0f.
   END.
          
   ASSIGN n_rb_pf     = 0     n_rb_sum    = 0
          n_rb_prm    = 0     nv_prmtre   = 0
          n_prmf1     = 0     n_prmf2     = 0 
          n_prmt      = 0     n_prms      = 0 
          n_prmq      = 0     n_prmtfp    = 0
          n_prmps     = 0     n_prmbtr    = 0
          n_prmotr    = 0     n_prms8     = 0 
          n_prmf4     = 0     n_prmftr    = 0.
   END.
   ELSE DO: /*ถ้าช่อง Date มีค่าเป็น ? หรือ ติดลบ ให้แยกมาออกอีกรายงานนึง*/
        n_count = n_count + 1.
    
        IF fi_asdate - uwm100.comdat > 0 THEN nv_datecal = fi_asdate - uwm100.comdat + 1.
        ELSE nv_datecal = 0.
        
        /*-- Earn , Uearn พรบ.---*/
        IF nv_datecal >= nv_expdat THEN nv_earn = n_prmcom.
        ELSE nv_earn = (n_prmcom / nv_expdat) * nv_datecal.
        nv_uearn = n_prmcom - nv_earn.   /*-- Earn , Uearn พรบ.---*/
        
        /*-- Earn , Uearn รถยนต์---*/
        IF nv_datecal >= nv_expdat THEN nv_earn1 = n_sumprm.
        ELSE nv_earn1 = (n_sumprm / nv_expdat) * nv_datecal.
        nv_uearn1 = n_sumprm - nv_earn1.   /*-- Earn , Uearn รถยนต์---*/
        
        PUT STREAM ns2 nv_dir                                                 "|"
                       n_branch                                               "|"   
                       uwm100.poltyp                                          "|"    
                       uwm100.trndat FORMAT "99/99/9999"                      "|"   
                       uwm100.policy                                          "|"  
                       uwm100.endno  FORMAT "X(10)"                           "|"
                       uwm100.comdat FORMAT "99/99/9999"                      "|"    
                       uwm100.expdat FORMAT "99/99/9999"                      "|" 
                       nv_expdat     FORMAT "->>>>>>9"                        "|"
                       nv_datecal    FORMAT "->>>>>>9"                        "|"
                       n_prmcom      FORMAT "->>,>>>,>>>,>>>.99"              "|" 
                       n_sumprm      FORMAT "->>,>>>,>>>,>>>.99"              "|" 
                       nv_earn       FORMAT "->>,>>>,>>>,>>>.99"              "|" 
                       nv_uearn      FORMAT "->>,>>>,>>>,>>>.99"              "|"
                       nv_earn1      FORMAT "->>,>>>,>>>,>>>.99"              "|"
                       nv_uearn1     FORMAT "->>,>>>,>>>,>>>.99"              "|" .
        
        FOR EACH wrk0f:
          FIND xmm600 WHERE xmm600.acno = wrk0f.rico NO-LOCK NO-ERROR.
          IF AVAILABLE xmm600 THEN DO:
            IF (xmm600.clicod = "RD") OR (xmm600.clicod = "RB") THEN
              ASSIGN
                 n_rb_pf   = n_rb_pf  + wrk0f.pf
                 n_rb_sum  = n_rb_sum + wrk0f.sumf
                 n_rb_prm  = n_rb_prm + (wrk0f.prmf * (-1)) .
            ELSE IF (xmm600.clicod = "RF") OR 
                    (xmm600.clicod = "RA") THEN  
                   ASSIGN
                      n_rf_pf   = n_rf_pf  + wrk0f.pf
                      n_rf_sum  = n_rf_sum + wrk0f.sumf
                      n_rf_prm  = n_rf_prm + (wrk0f.prmf * (-1)) .
          END.      
        END. /* END FOR EACH wrk0f */
        
        nv_prmtre = n_prmf1 + n_prmf2 + n_prmt + n_prms + n_prmq + n_prmtfp +
                    n_prmps + n_prmbtr + n_prmotr + n_prms8 + n_prmf4 + n_prmftr + 
                    n_rf_prm + n_rb_prm + n_prmrq . /*Lukkana M. A55-0357 20/11/2012*/
        
        /*-- Earn , Uearn เบี้ย ceded---*/
        IF nv_datecal >= nv_expdat THEN nv_earn2 = nv_prmtre.
        ELSE nv_earn2 = (nv_prmtre / nv_expdat) * nv_datecal.
        nv_uearn2 = nv_prmtre - nv_earn2.  /*-- Earn , Uearn เบี้ย ceded---*/
        
        PUT STREAM ns2 
            nv_prmtre FORMAT "->>,>>>,>>>,>>>.99" "|" 
            nv_earn2  FORMAT "->>,>>>,>>>,>>>.99" "|" 
            nv_uearn2 FORMAT "->>,>>>,>>>,>>>.99" "|"
            uwm100.polsta SKIP.      /*A56-0092*/
            
        FOR EACH wrk0f:
            DELETE wrk0f.
        END.
        
        ASSIGN n_rb_pf     = 0      n_rb_sum    = 0
            n_rb_prm    = 0      nv_prmtre   = 0
            n_prmf1     = 0      n_prmf2     = 0 
            n_prmt      = 0      n_prms      = 0 
            n_prmq      = 0      n_prmtfp    = 0
            n_prmps     = 0      n_prmbtr    = 0
            n_prmotr    = 0      n_prms8     = 0 
            n_prmf4     = 0      n_prmftr    = 0.
    END.
END.  /*---end Add A56-0092---*/
ELSE DO:        /*---For not Cancel---*/

    IF nv_expdat <> ? AND nv_expdat >= 0 AND nv_expdat <= 3650 THEN DO: /*เช็คเงื่อนไขเพื่อแยกข้อมูล error ออกเป็นอีกไฟล์*/
        nv_count  = nv_count + 1 .
    
        IF fi_asdate - uwm100.comdat > 0 THEN nv_datecal = fi_asdate - uwm100.comdat + 1.
        ELSE nv_datecal = 0.
        
        /*-- Earn , Uearn พรบ.---*/
        IF nv_datecal >= nv_expdat THEN nv_earn = n_prmcom.
        ELSE nv_earn = (n_prmcom / nv_expdat) * nv_datecal.
        nv_uearn = n_prmcom - nv_earn.   /*-- Earn , Uearn พรบ.---*/
        
        /*-- Earn , Uearn รถยนต์---*/
        IF nv_datecal >= nv_expdat THEN nv_earn1 = n_sumprm.
        ELSE nv_earn1 = (n_sumprm / nv_expdat) * nv_datecal.
        nv_uearn1 = n_sumprm - nv_earn1.  /*-- Earn , Uearn รถยนต์---*/
        
        PUT STREAM ns1 nv_dir                                                 "|"
                       n_branch                                               "|"   
                       uwm100.poltyp                                          "|"    
                       uwm100.trndat FORMAT "99/99/9999"                      "|"   
                       uwm100.policy                                          "|"  
                       uwm100.endno  FORMAT "X(10)"                           "|"
                       uwm100.comdat FORMAT "99/99/9999"                      "|"    
                       uwm100.expdat FORMAT "99/99/9999"                      "|" 
                       nv_expdat     FORMAT ">>>>>>9"                         "|"
                       nv_datecal    FORMAT ">>>>>>9"                         "|"
                       n_prmcom      FORMAT "->>,>>>,>>>,>>>.99"              "|" 
                       n_sumprm      FORMAT "->>,>>>,>>>,>>>.99"              "|" 
                       nv_earn       FORMAT "->>,>>>,>>>,>>>.99"              "|" 
                       nv_uearn      FORMAT "->>,>>>,>>>,>>>.99"              "|"
                       nv_earn1      FORMAT "->>,>>>,>>>,>>>.99"              "|"
                       nv_uearn1     FORMAT "->>,>>>,>>>,>>>.99"              "|".
        
        FOR EACH wrk0f:
          FIND xmm600 WHERE xmm600.acno = wrk0f.rico NO-LOCK NO-ERROR.
          IF AVAILABLE xmm600 THEN DO:
            IF (xmm600.clicod = "RD") OR (xmm600.clicod = "RB") THEN
              ASSIGN
                 n_rb_pf   = n_rb_pf  + wrk0f.pf
                 n_rb_sum  = n_rb_sum + wrk0f.sumf
                 n_rb_prm  = n_rb_prm + (wrk0f.prmf * (-1)) .
            ELSE IF (xmm600.clicod = "RF") OR 
                    (xmm600.clicod = "RA") THEN  
                   ASSIGN
                      n_rf_pf   = n_rf_pf  + wrk0f.pf
                      n_rf_sum  = n_rf_sum + wrk0f.sumf
                      n_rf_prm  = n_rf_prm + (wrk0f.prmf * (-1)) .
          END.      
        END. /* END FOR EACH wrk0f */
        
        nv_prmtre = n_prmf1 + n_prmf2 + n_prmt + n_prms + n_prmq + n_prmtfp +
                    n_prmps + n_prmbtr + n_prmotr + n_prms8 + n_prmf4 + n_prmftr + 
                    n_rf_prm + n_rb_prm + n_prmrq . /*Lukkana M. A55-0357 20/11/2012*/
        
        /*-- Earn , Uearn เบี้ย ceded---*/
        IF nv_datecal >= nv_expdat THEN nv_earn2 = nv_prmtre.
        ELSE nv_earn2 = (nv_prmtre / nv_expdat) * nv_datecal.
        nv_uearn2 = nv_prmtre - nv_earn2. /*-- Earn , Uearn เบี้ย ceded-*/    

        
            ASSIGN /*Grand total*/
            nv_totprmcom = nv_totprmcom + n_prmcom    
            nv_totsumprm = nv_totsumprm + n_sumprm    
            nv_totearn   = nv_totearn   + nv_earn     
            nv_totuearn  = nv_totuearn  + nv_uearn    
            nv_totearn1  = nv_totearn1  + nv_earn1    
            nv_totuearn1 = nv_totuearn1 + nv_uearn1   
            nv_totprmtre = nv_totprmtre + nv_prmtre
            nv_totearn2  = nv_totearn2  + nv_earn2 
            nv_totuearn2 = nv_totuearn2  + nv_uearn2.
        
        PUT STREAM ns1
            /* comment by Benjaporn 
            nv_prmtre FORMAT "->>,>>>,>>>,>>>.99" "|" 
            nv_earn2  FORMAT "->>,>>>,>>>,>>>.99" "|" 
            nv_uearn2 FORMAT "->>,>>>,>>>,>>>.99" "|"  */
            uwm100.polsta SKIP.      /*A56-0092*/
            
        FOR EACH wrk0f:
            DELETE wrk0f.
        END.
        
        ASSIGN
            n_rb_pf     = 0     n_rb_sum    = 0
            n_rb_prm    = 0     nv_prmtre   = 0
            n_prmf1     = 0     n_prmf2     = 0 
            n_prmt      = 0     n_prms      = 0 
            n_prmq      = 0     n_prmtfp    = 0
            n_prmps     = 0     n_prmbtr    = 0
            n_prmotr    = 0     n_prms8     = 0 
            n_prmf4     = 0     n_prmftr    = 0.
    END.
    ELSE DO: /*ถ้าช่อง Date มีค่าเป็น ? หรือ ติดลบ ให้แยกมาออกอีกรายงานนึง*/
        n_count = n_count + 1.
    
        IF fi_asdate - uwm100.comdat > 0 THEN nv_datecal = fi_asdate - uwm100.comdat + 1.
        ELSE nv_datecal = 0.
        
        /*-- Earn , Uearn พรบ.---*/
        IF nv_datecal >= nv_expdat THEN nv_earn = n_prmcom.
        ELSE nv_earn = (n_prmcom / nv_expdat) * nv_datecal.
        nv_uearn = n_prmcom - nv_earn.    /*-- Earn , Uearn พรบ.---*/
        
        /*-- Earn , Uearn รถยนต์---*/
        IF nv_datecal >= nv_expdat THEN nv_earn1 = n_sumprm.
        ELSE nv_earn1 = (n_sumprm / nv_expdat) * nv_datecal.
        nv_uearn1 = n_sumprm - nv_earn1.  /*-- Earn , Uearn รถยนต์---*/
        
        PUT STREAM ns2 nv_dir                                                 "|"
                       n_branch                                               "|"   
                       uwm100.poltyp                                          "|"    
                       uwm100.trndat FORMAT "99/99/9999"                      "|"   
                       uwm100.policy                                          "|"  
                       uwm100.endno  FORMAT "X(10)"                           "|"
                       uwm100.comdat FORMAT "99/99/9999"                      "|"    
                       uwm100.expdat FORMAT "99/99/9999"                      "|" 
                       nv_expdat     FORMAT "->>>>>>9"                        "|"
                       nv_datecal    FORMAT "->>>>>>9"                        "|"
                       n_prmcom      FORMAT "->>,>>>,>>>,>>>.99"              "|" 
                       n_sumprm      FORMAT "->>,>>>,>>>,>>>.99"              "|" 
                       nv_earn       FORMAT "->>,>>>,>>>,>>>.99"              "|" 
                       nv_uearn      FORMAT "->>,>>>,>>>,>>>.99"              "|"
                       nv_earn1      FORMAT "->>,>>>,>>>,>>>.99"              "|"
                       nv_uearn1     FORMAT "->>,>>>,>>>,>>>.99"              "|" .
        
        FOR EACH wrk0f:
          FIND xmm600 WHERE xmm600.acno = wrk0f.rico NO-LOCK NO-ERROR.
          IF AVAILABLE xmm600 THEN DO:
            IF (xmm600.clicod = "RD") OR (xmm600.clicod = "RB") THEN
              ASSIGN
                 n_rb_pf   = n_rb_pf  + wrk0f.pf
                 n_rb_sum  = n_rb_sum + wrk0f.sumf
                 n_rb_prm  = n_rb_prm + (wrk0f.prmf * (-1)) .
            ELSE IF (xmm600.clicod = "RF") OR 
                    (xmm600.clicod = "RA") THEN  
                   ASSIGN
                      n_rf_pf   = n_rf_pf  + wrk0f.pf
                      n_rf_sum  = n_rf_sum + wrk0f.sumf
                      n_rf_prm  = n_rf_prm + (wrk0f.prmf * (-1)) .
          END.      
        END. /* END FOR EACH wrk0f */
        
        nv_prmtre = n_prmf1 + n_prmf2 + n_prmt + n_prms + n_prmq + n_prmtfp +
                    n_prmps + n_prmbtr + n_prmotr + n_prms8 + n_prmf4 + n_prmftr + 
                    n_rf_prm + n_rb_prm + n_prmrq . /*Lukkana M. A55-0357 20/11/2012*/
        
        /*-- Earn , Uearn เบี้ย ceded---*/
        IF nv_datecal >= nv_expdat THEN nv_earn2 = nv_prmtre.
        ELSE nv_earn2 = (nv_prmtre / nv_expdat) * nv_datecal.
        nv_uearn2 = nv_prmtre - nv_earn2.   /*-- Earn , Uearn เบี้ย ceded---*/

        PUT STREAM ns2 
            nv_prmtre FORMAT "->>,>>>,>>>,>>>.99" "|" 
            nv_earn2  FORMAT "->>,>>>,>>>,>>>.99" "|" 
            nv_uearn2 FORMAT "->>,>>>,>>>,>>>.99" "|"
            uwm100.polsta SKIP.      /*A56-0092*/
            
        FOR EACH wrk0f:
            DELETE wrk0f.
        END.
        
        ASSIGN n_rb_pf     = 0       n_rb_sum    = 0
               n_rb_prm    = 0       nv_prmtre   = 0
               n_prmf1     = 0       n_prmf2     = 0 
               n_prmt      = 0       n_prms      = 0 
               n_prmq      = 0       n_prmtfp    = 0
               n_prmps     = 0       n_prmbtr    = 0
               n_prmotr    = 0       n_prms8     = 0 
               n_prmf4     = 0       n_prmftr    = 0.
    END.

END.    /*end Else do:   for cancel*/
/*---------------------------------------end A56-0092--------------------------------------------*/
*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pd_detailnon C-Win 
PROCEDURE Pd_detailnon :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       /*---A58-0242---By Benjaporn J.*/
------------------------------------------------------------------------------*/
RUN pd_initdata.

FIND LAST buwm100 USE-INDEX uwm10001 WHERE 
          buwm100.policy = uwm100.policy AND
          buwm100.polsta = "CA"          AND
          buwm100.releas = YES  NO-LOCK NO-ERROR.
IF AVAIL buwm100 THEN DO:
   IF nv_expdat <> ? AND nv_expdat >= 0 AND nv_expdat <= 3650 THEN DO:
            
            ASSIGN nv_count  = nv_count + 1
                   n_count1  = n_count1 + 1.  
        
            IF fi_asdate - uwm100.comdat >= 0 THEN nv_datecal = fi_asdate - uwm100.comdat + 1.
            ELSE nv_datecal = 0.
             /*-- Earn , Uearn เบี้ยประกัน---*/
            IF nv_datecal >= nv_expdat THEN nv_earn =  uwm100.prem_t.
            ELSE nv_earn = ( uwm100.prem_t / nv_expdat) * nv_datecal.
            nv_uearn =  uwm100.prem_t - nv_earn.
           
            PUT STREAM ns3 nv_dir                                                 "|"
                           n_branch                                               "|"   
                           uwm100.poltyp                                          "|"    
                           uwm100.trndat FORMAT "99/99/9999"                      "|"   
                           uwm100.policy                                          "|"  
                           uwm100.endno  FORMAT "X(10)"                           "|"
                           uwm100.comdat FORMAT "99/99/9999"                      "|"    
                           uwm100.expdat FORMAT "99/99/9999"                      "|" 
                           nv_expdat     FORMAT ">>>>>>9"                         "|"
                           nv_datecal    FORMAT ">>>>>>9"                         "|"
                           uwm100.prem_t FORMAT "->>,>>>,>>>,>>>.99"              "|"   
                           nv_earn       FORMAT "->>,>>>,>>>,>>>.99"              "|" 
                           nv_uearn      FORMAT "->>,>>>,>>>,>>>.99"              "|".
             FOR EACH wrk0f:
            
              FIND xmm600 WHERE xmm600.acno = wrk0f.rico NO-LOCK NO-ERROR.
              IF AVAILABLE xmm600 THEN DO:
                IF (xmm600.clicod = "RD") OR (xmm600.clicod = "RB") THEN
                  ASSIGN
                     n_rb_pf   = n_rb_pf  + wrk0f.pf
                     n_rb_sum  = n_rb_sum + wrk0f.sumf
                     n_rb_prm  = n_rb_prm + (wrk0f.prmf * (-1)) .
            
                ELSE IF (xmm600.clicod = "RF") OR 
                        (xmm600.clicod = "RA") THEN  
                       ASSIGN
                          n_rf_pf   = n_rf_pf  + wrk0f.pf
                          n_rf_sum  = n_rf_sum + wrk0f.sumf
                          n_rf_prm  = n_rf_prm + (wrk0f.prmf * (-1)) .
              END.
            END. /* END FOR EACH wrk0f */
            /*  A58-0242 Benjaporn J. 13/07/2015 */
            /*Treaty*/
            nv_prmtrt = n_prmf1 + n_prmf2 + n_prmt + n_prms + n_prmq + n_prmtfp +
                        n_prmps + n_prmbtr + n_prmotr + n_prms8 + n_prmf4 + n_prmftr + n_prmrq.  
            IF   nv_datecal >= nv_expdat THEN nv_earntrt = nv_prmtrt.
            ELSE nv_earntrt = (nv_prmtrt / nv_expdat) * nv_datecal.
            nv_uearntrt = nv_prmtrt - nv_earntrt.
            /*FAC*/
            nv_prmfac = n_rf_prm + n_rb_prm.
            IF   nv_datecal >= nv_expdat THEN nv_earnfac = nv_prmfac.
            ELSE nv_earnfac = (nv_prmfac / nv_expdat) * nv_datecal.
            nv_uearnfac = nv_prmfac - nv_earnfac. /*end A58-0242 Benjaporn J. 13/07/2015 */
            
            ASSIGN nv_ctotprmcom   = nv_ctotprmcom   + uwm100.prem_t    
                   nv_ctotearn     = nv_ctotearn     + nv_earn     
                   nv_ctotuearn    = nv_ctotuearn    + nv_uearn 
                /* start A58-0242 Benjaporn J. 13/07/2015 */
                   nv_ctotprmtrt   = nv_ctotprmtrt   + nv_prmtrt
                   nv_ctotearntrt  = nv_ctotearntrt  + nv_earntrt 
                   nv_ctotuearntrt = nv_ctotuearntrt + nv_uearntrt
                   nv_ctotprmfac   = nv_ctotprmfac   + nv_prmfac
                   nv_ctotearnfac  = nv_ctotearnfac  + nv_earnfac 
                   nv_ctotuearnfac = nv_ctotuearnfac + nv_uearnfac .   /*001*/
           
            PUT STREAM ns3
                nv_prmtrt   FORMAT "->>,>>>,>>>,>>>.99" "|" 
                nv_earntrt  FORMAT "->>,>>>,>>>,>>>.99" "|" 
                nv_uearntrt FORMAT "->>,>>>,>>>,>>>.99" "|"
                nv_prmfac   FORMAT "->>,>>>,>>>,>>>.99" "|" 
                nv_earnfac  FORMAT "->>,>>>,>>>,>>>.99" "|" 
                nv_uearnfac FORMAT "->>,>>>,>>>,>>>.99" "|" /*end A58-0242 Benjaporn J. 13/07/2015 */
                uwm100.polsta SKIP.      /*A56-0092*/
            FOR EACH wrk0f:  DELETE wrk0f.  END.
            
            ASSIGN n_rb_pf     = 0      n_rb_sum    = 0
                   n_rb_prm    = 0      nv_prmtre   = 0
                   n_prmf1     = 0      n_prmf2     = 0 
                   n_prmt      = 0      n_prms      = 0 
                   n_prmq      = 0      n_prmtfp    = 0
                   n_prmps     = 0      n_prmbtr    = 0
                   n_prmotr    = 0      n_prms8     = 0 
                   n_prmf4     = 0      n_prmftr    = 0.

        END.     
        ELSE DO: 
            n_count  = n_count + 1 .
            
            IF fi_asdate - uwm100.comdat >= 0 THEN nv_datecal = fi_asdate - uwm100.comdat + 1.
            ELSE nv_datecal = 0.
            /*-- Earn , Uearn เบี้ยประกัน---*/
            IF nv_datecal >= nv_expdat THEN nv_earn =  uwm100.prem_t.
            ELSE nv_earn = ( uwm100.prem_t / nv_expdat) * nv_datecal.
            nv_uearn =  uwm100.prem_t - nv_earn.
            
            PUT STREAM ns2 nv_dir                                                 "|"
                           n_branch                                               "|"   
                           uwm100.poltyp                                          "|"    
                           uwm100.trndat FORMAT "99/99/9999"                      "|"   
                           uwm100.policy                                          "|"  
                           uwm100.endno  FORMAT "X(10)"                           "|"
                           uwm100.comdat FORMAT "99/99/9999"                      "|"    
                           uwm100.expdat FORMAT "99/99/9999"                      "|" 
                           nv_expdat     FORMAT "->>>>>>9"                        "|"
                           nv_datecal    FORMAT "->>>>>>9"                        "|"
                           uwm100.prem_t FORMAT "->>,>>>,>>>,>>>.99"              "|"    
                           nv_earn       FORMAT "->>,>>>,>>>,>>>.99"              "|" 
                           nv_uearn      FORMAT "->>,>>>,>>>,>>>.99"              "|".
            
            FOR EACH wrk0f:
              FIND xmm600 WHERE xmm600.acno = wrk0f.rico NO-LOCK NO-ERROR.
              IF AVAILABLE xmm600 THEN DO:
                IF (xmm600.clicod = "RD") OR (xmm600.clicod = "RB") THEN
                  ASSIGN
                     n_rb_pf   = n_rb_pf  + wrk0f.pf
                     n_rb_sum  = n_rb_sum + wrk0f.sumf
                     n_rb_prm  = n_rb_prm + (wrk0f.prmf * (-1)) .
                ELSE IF (xmm600.clicod = "RF") OR 
                        (xmm600.clicod = "RA") THEN  
                       ASSIGN
                          n_rf_pf   = n_rf_pf  + wrk0f.pf
                          n_rf_sum  = n_rf_sum + wrk0f.sumf
                          n_rf_prm  = n_rf_prm + (wrk0f.prmf * (-1)) .
               END.
            END. /* END FOR EACH wrk0f */
            /*  A58-0242 Benjaporn J. 13/07/2015 */
            /*Treaty*/
            nv_prmtrt = n_prmf1 + n_prmf2 + n_prmt + n_prms + n_prmq + n_prmtfp +
                        n_prmps + n_prmbtr + n_prmotr + n_prms8 + n_prmf4 + n_prmftr + n_prmrq.  
            IF   nv_datecal >= nv_expdat THEN nv_earntrt = nv_prmtrt.
            ELSE nv_earntrt = (nv_prmtrt / nv_expdat) * nv_datecal.
            nv_uearntrt = nv_prmtrt - nv_earntrt.
            /*FAC*/
            nv_prmfac = n_rf_prm + n_rb_prm.
            IF   nv_datecal >= nv_expdat THEN nv_earnfac = nv_prmfac.
            ELSE nv_earnfac = (nv_prmfac / nv_expdat) * nv_datecal.
            nv_uearnfac = nv_prmfac - nv_earnfac. 
          
            PUT STREAM ns2
                nv_prmtrt   FORMAT "->>,>>>,>>>,>>>.99" "|" 
                nv_earntrt  FORMAT "->>,>>>,>>>,>>>.99" "|" 
                nv_uearntrt FORMAT "->>,>>>,>>>,>>>.99" "|"
                nv_prmfac   FORMAT "->>,>>>,>>>,>>>.99" "|" 
                nv_earnfac  FORMAT "->>,>>>,>>>,>>>.99" "|" 
                nv_uearnfac FORMAT "->>,>>>,>>>,>>>.99" "|" /*end A58-0242 Benjaporn J. 13/07/2015 */
                uwm100.polsta SKIP.      /*A56-0092*/     
                
            FOR EACH wrk0f:  DELETE wrk0f.  END.
            ASSIGN n_rb_pf     = 0     n_rb_sum    = 0
                   n_rb_prm    = 0     nv_prmtre   = 0
                   n_prmf1     = 0     
                   n_prmf2     = 0     
                   n_prmt      = 0     n_prms      = 0 
                   n_prmq      = 0     n_prmtfp    = 0
                   n_prmps     = 0     n_prmbtr    = 0
                   n_prmotr    = 0     n_prms8     = 0 
                   n_prmf4     = 0     n_prmftr    = 0. 
        END.
END.
ELSE DO:   /*---For not Cancel---*/
 IF nv_expdat <> ? AND nv_expdat >= 0 AND nv_expdat <= 3650 THEN DO: 
        
            nv_count  = nv_count + 1 .
        
            IF fi_asdate - nv_comdat >= 0 THEN nv_datecal = fi_asdate - nv_comdat + 1.
            ELSE nv_datecal = 0.
            
            /*-- Earn , Uearn เบี้ยประกัน---*/
            IF nv_datecal >= nv_expdat THEN nv_earn =  uwm100.prem_t.
            ELSE nv_earn = ( uwm100.prem_t / nv_expdat) * nv_datecal.
            nv_uearn =  uwm100.prem_t - nv_earn.  /*- Earn , Uearn เบี้ยประกัน---*/
            
            PUT STREAM ns1 nv_dir                                                 "|"
                           n_branch                                               "|"   
                           uwm100.poltyp                                          "|"    
                           uwm100.trndat FORMAT "99/99/9999"                      "|"   
                           uwm100.policy                                          "|"  
                           uwm100.endno  FORMAT "X(10)"                           "|"
                           uwm100.comdat FORMAT "99/99/9999"                      "|"    
                           uwm100.expdat FORMAT "99/99/9999"                      "|" 
                           nv_expdat     FORMAT ">>>>>>9"                         "|"
                           nv_datecal    FORMAT ">>>>>>9"                         "|"
                           uwm100.prem_t FORMAT "->>,>>>,>>>,>>>.99"              "|"    
                           nv_earn       FORMAT "->>,>>>,>>>,>>>.99"              "|" 
                           nv_uearn      FORMAT "->>,>>>,>>>,>>>.99"              "|".
            
            FOR EACH wrk0f:
            
              FIND xmm600 WHERE xmm600.acno = wrk0f.rico NO-LOCK NO-ERROR.
              IF AVAILABLE xmm600 THEN DO:
                IF (xmm600.clicod = "RD") OR (xmm600.clicod = "RB") THEN
                  ASSIGN
                     n_rb_pf   = n_rb_pf  + wrk0f.pf
                     n_rb_sum  = n_rb_sum + wrk0f.sumf
                     n_rb_prm  = n_rb_prm + (wrk0f.prmf * (-1)) .
            
                ELSE IF (xmm600.clicod = "RF") OR 
                        (xmm600.clicod = "RA") THEN  
                       ASSIGN
                          n_rf_pf   = n_rf_pf  + wrk0f.pf
                          n_rf_sum  = n_rf_sum + wrk0f.sumf
                          n_rf_prm  = n_rf_prm + (wrk0f.prmf * (-1)) .
              END.
       END. /* END FOR EACH wrk0f */
            /* start A58-0242 Benjaporn J. 13/07/2015 */
            /*Treaty*/
            nv_prmtrt = n_prmf1 + n_prmf2 + n_prmt + n_prms + n_prmq + n_prmtfp +
                        n_prmps + n_prmbtr + n_prmotr + n_prms8 + n_prmf4 + n_prmftr + n_prmrq.  
            
            IF   nv_datecal >= nv_expdat THEN nv_earntrt = nv_prmtrt.
            ELSE nv_earntrt = (nv_prmtrt / nv_expdat) * nv_datecal.
            nv_uearntrt = nv_prmtrt - nv_earntrt.
            /*FAC*/
            nv_prmfac = n_rf_prm + n_rb_prm.
            IF   nv_datecal >= nv_expdat THEN nv_earnfac = nv_prmfac.
            ELSE nv_earnfac = (nv_prmfac / nv_expdat) * nv_datecal.
            nv_uearnfac = nv_prmfac - nv_earnfac. /*end A58-0242 Benjaporn J. 13/07/2015 */
            
         ASSIGN nv_totprmcom   = nv_totprmcom   + uwm100.prem_t    
                nv_totearn     = nv_totearn     + nv_earn     
                nv_totuearn    = nv_totuearn    + nv_uearn    
               /* start A58-0242 Benjaporn J. 13/07/2015 */     
                nv_totprmtrt   = nv_totprmtrt   + nv_prmtrt
                nv_totearntrt  = nv_totearntrt  + nv_earntrt 
                nv_totuearntrt = nv_totuearntrt + nv_uearntrt
                nv_totprmfac   = nv_totprmfac   + nv_prmfac
                nv_totearnfac  = nv_totearnfac  + nv_earnfac 
                nv_totuearnfac = nv_totuearnfac + nv_uearnfac. 
         
         PUT STREAM ns1
                nv_prmtrt   FORMAT "->>,>>>,>>>,>>>.99" "|" 
                nv_earntrt  FORMAT "->>,>>>,>>>,>>>.99" "|" 
                nv_uearntrt FORMAT "->>,>>>,>>>,>>>.99" "|"
                nv_prmfac   FORMAT "->>,>>>,>>>,>>>.99" "|" 
                nv_earnfac  FORMAT "->>,>>>,>>>,>>>.99" "|" 
                nv_uearnfac FORMAT "->>,>>>,>>>,>>>.99" "|" /*end A58-0242 Benjaporn J. 13/07/2015 */
                uwm100.polsta SKIP. 

            FOR EACH wrk0f:  DELETE wrk0f. END.
            
            ASSIGN n_rb_pf     = 0      n_rb_sum    = 0
                   n_rb_prm    = 0      nv_prmtre   = 0
                   n_prmf1     = 0      n_prmf2     = 0 
                   n_prmt      = 0      n_prms      = 0 
                   n_prmq      = 0      n_prmtfp    = 0
                   n_prmps     = 0      n_prmbtr    = 0
                   n_prmotr    = 0      n_prms8     = 0 
                   n_prmf4     = 0      n_prmftr    = 0. 
        END.
        ELSE DO: 
            n_count  = n_count + 1 .
            IF fi_asdate - nv_comdat >= 0 THEN nv_datecal = fi_asdate - nv_comdat + 1.
            ELSE nv_datecal = 0.
            /*-- Earn , Uearn เบี้ยประกัน---*/
            IF nv_datecal >= nv_expdat THEN nv_earn =  uwm100.prem_t.
            ELSE nv_earn = ( uwm100.prem_t / nv_expdat) * nv_datecal.
            nv_uearn =  uwm100.prem_t - nv_earn.
            
            PUT STREAM ns2 nv_dir                                                 "|"
                           n_branch                                               "|"   
                           uwm100.poltyp                                          "|"    
                           uwm100.trndat FORMAT "99/99/9999"                      "|"   
                           uwm100.policy                                          "|"  
                           uwm100.endno  FORMAT "X(10)"                           "|"
                           uwm100.comdat FORMAT "99/99/9999"                      "|"    
                           uwm100.expdat FORMAT "99/99/9999"                      "|" 
                           nv_expdat     FORMAT "->>>>>>9"                        "|"
                           nv_datecal    FORMAT "->>>>>>9"                        "|"
                           uwm100.prem_t FORMAT "->>,>>>,>>>,>>>.99"              "|"   
                           nv_earn       FORMAT "->>,>>>,>>>,>>>.99"              "|" 
                           nv_uearn      FORMAT "->>,>>>,>>>,>>>.99"              "|".
            
            FOR EACH wrk0f:
              FIND xmm600 WHERE xmm600.acno = wrk0f.rico NO-LOCK NO-ERROR.
              IF AVAILABLE xmm600 THEN DO:
                IF (xmm600.clicod = "RD") OR (xmm600.clicod = "RB") THEN
                  ASSIGN
                     n_rb_pf   = n_rb_pf  + wrk0f.pf
                     n_rb_sum  = n_rb_sum + wrk0f.sumf
                     n_rb_prm  = n_rb_prm + (wrk0f.prmf * (-1)) .
                ELSE IF (xmm600.clicod = "RF") OR 
                        (xmm600.clicod = "RA") THEN  
                       ASSIGN
                          n_rf_pf   = n_rf_pf  + wrk0f.pf
                          n_rf_sum  = n_rf_sum + wrk0f.sumf
                          n_rf_prm  = n_rf_prm + (wrk0f.prmf * (-1)) .
              END.
            END. /* END FOR EACH wrk0f */
            /*  start  A58-0242 Benjaporn J. 13/07/2015 */
            /*Treaty*/
            nv_prmtrt = n_prmf1 + n_prmf2 + n_prmt + n_prms + n_prmq + n_prmtfp +
                        n_prmps + n_prmbtr + n_prmotr + n_prms8 + n_prmf4 + n_prmftr + n_prmrq.  
            IF   nv_datecal >= nv_expdat THEN nv_earntrt = nv_prmtrt.
            ELSE nv_earntrt = (nv_prmtrt / nv_expdat) * nv_datecal.
            nv_uearntrt = nv_prmtrt - nv_earntrt.
            /*FAC*/
            nv_prmfac = n_rf_prm + n_rb_prm.
            IF   nv_datecal >= nv_expdat THEN nv_earnfac = nv_prmfac.
            ELSE nv_earnfac = (nv_prmfac / nv_expdat) * nv_datecal.
            nv_uearnfac = nv_prmfac - nv_earnfac. 
            
            PUT STREAM ns2
                
                nv_prmtrt   FORMAT "->>,>>>,>>>,>>>.99" "|" 
                nv_earntrt  FORMAT "->>,>>>,>>>,>>>.99" "|" 
                nv_uearntrt FORMAT "->>,>>>,>>>,>>>.99" "|"
                nv_prmfac   FORMAT "->>,>>>,>>>,>>>.99" "|" 
                nv_earnfac  FORMAT "->>,>>>,>>>,>>>.99" "|" 
                nv_uearnfac FORMAT "->>,>>>,>>>,>>>.99" "|" /*end A58-0242 Benjaporn J. 13/07/2015 */
                uwm100.polsta SKIP.      /*A56-0092*/  

            FOR EACH wrk0f:   DELETE wrk0f.  END.
            ASSIGN
                n_rb_pf     = 0     n_rb_sum    = 0
                n_rb_prm    = 0     nv_prmtre   = 0
                n_prmf1     = 0     n_prmf2     = 0 
                n_prmt      = 0     n_prms      = 0 
                n_prmq      = 0     n_prmtfp    = 0
                n_prmps     = 0     n_prmbtr    = 0
                n_prmotr    = 0     n_prms8     = 0 
                n_prmf4     = 0     n_prmftr    = 0.

        END.
END.   
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_detailnon_old C-Win 
PROCEDURE pd_detailnon_old :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:    comment by Benjaporn J. A58-0242 13/07/2015    
------------------------------------------------------------------------------*/
/* ASSIGN nv_prstp   =  uwm100.pstp + uwm100.rstp
       nv_prtax   =  uwm100.ptax + uwm100.rtax
       nv_sumpts  =  uwm100.prem_t + nv_prstp + nv_prtax - n_paprm - n_tstppa - n_taxpa
       n_sumprm   =  uwm100.prem_t - n_prmcom - n_paprm
       n_sumstp   =  nv_prstp - n_tstpcom - n_tstppa
       n_sumtax   =  nv_prtax
       n_compa_t  =  - n_paprm * nv_com1p / 100
       nu_tax     = n_sumtax - n_taxpa
       nu_prm     = n_prmcom + n_sumprm + n_tstpcom + n_sumstp
       nu_vat     = nu_tax.

ASSIGN
    nv_expdat  = 0    nv_datecal = 0
    nv_earn    = 0    nv_uearn   = 0
    nv_earn1   = 0    nv_uearn1  = 0
    nv_earn2   = 0    nv_uearn2  = 0
    nv_prmtre  = 0.

nv_expdat  = uwm100.expdat - uwm100.comdat + 1.

/*------------------------------------------------------By A56-0092-----------------------------------------------------------*/
/*---Add By A56-0092----*/
FIND LAST buwm100 USE-INDEX uwm10001 WHERE 
          buwm100.policy = uwm100.policy AND
          buwm100.polsta = "CA"          AND
          buwm100.releas = YES  NO-LOCK NO-ERROR.
IF AVAIL buwm100 THEN DO:
   IF nv_expdat <> ? AND nv_expdat >= 0 AND nv_expdat <= 3650 THEN DO: /*เช็คเงื่อนไขเพื่อแยกข้อมูล error ออกเป็นอีกไฟล์*/
        
            nv_count  = nv_count + 1.
            n_count1  = n_count1 + 1.   /*A56-0092*/
        
            IF fi_asdate - uwm100.comdat > 0 THEN nv_datecal = fi_asdate - uwm100.comdat + 1.
            ELSE nv_datecal = 0.
            
            /*-- Earn , Uearn เบี้ยประกัน---*/
            IF nv_datecal >= nv_expdat THEN nv_earn =  uwm100.prem_t.
            ELSE nv_earn = ( uwm100.prem_t / nv_expdat) * nv_datecal.
            
            nv_uearn =  uwm100.prem_t - nv_earn.
            /*-- Earn , Uearn เบี้ยประกัน---*/
            
            PUT STREAM ns3 nv_dir                                                 "|"
                           n_branch                                               "|"   
                           uwm100.poltyp                                          "|"    
                           uwm100.trndat FORMAT "99/99/9999"                      "|"   
                           uwm100.policy                                          "|"  
                           uwm100.endno  FORMAT "X(10)"                           "|"
                           uwm100.comdat FORMAT "99/99/9999"                      "|"    
                           uwm100.expdat FORMAT "99/99/9999"                      "|" 
                           nv_expdat     FORMAT ">>>>>>9"                         "|"
                           nv_datecal    FORMAT ">>>>>>9"                         "|"
                           uwm100.prem_t FORMAT "->>,>>>,>>>,>>>.99"              "|"    /*เบี้ยประกัน*/
                           nv_earn       FORMAT "->>,>>>,>>>,>>>.99"              "|" 
                           nv_uearn      FORMAT "->>,>>>,>>>,>>>.99"              "|".
            
            FOR EACH wrk0f:
            
              FIND xmm600 WHERE xmm600.acno = wrk0f.rico NO-LOCK NO-ERROR.
              IF AVAILABLE xmm600 THEN DO:
                IF (xmm600.clicod = "RD") OR (xmm600.clicod = "RB") THEN
                  ASSIGN
                     n_rb_pf   = n_rb_pf  + wrk0f.pf
                     n_rb_sum  = n_rb_sum + wrk0f.sumf
                     n_rb_prm  = n_rb_prm + (wrk0f.prmf * (-1)) .
            
                ELSE IF (xmm600.clicod = "RF") OR 
                        (xmm600.clicod = "RA") THEN  
                       ASSIGN
                          n_rf_pf   = n_rf_pf  + wrk0f.pf
                          n_rf_sum  = n_rf_sum + wrk0f.sumf
                          n_rf_prm  = n_rf_prm + (wrk0f.prmf * (-1)) .
              END.
            
            END. /* END FOR EACH wrk0f */
            /*--- comment by Benjaporn J.
            nv_prmtre = n_prmf1 + n_prmf2 + n_prmt + n_prms + n_prmq + n_prmtfp +
                        n_prmps + n_prmbtr + n_prmotr + n_prms8 + n_prmf4 + n_prmftr + 
                        n_rf_prm + n_rb_prm + n_prmrq . /*Lukkana M. A55-0357 20/11/2012*/
               
            /*-- Earn , Uearn เบี้ย ceded---*/
            IF nv_datecal >= nv_expdat THEN nv_earn2 = nv_prmtre.
            ELSE nv_earn2 = (nv_prmtre / nv_expdat) * nv_datecal.
            
            nv_uearn2 = nv_prmtre - nv_earn2. /*-- Earn , Uearn เบี้ย ceded---*/   end comment by Benjaporn J.--- */ 
            
            ASSIGN /*Grand total*/
                nv_ctotprmcom = nv_ctotprmcom + uwm100.prem_t    
                nv_ctotearn   = nv_ctotearn   + nv_earn     
                nv_ctotuearn  = nv_ctotuearn  + nv_uearn         
                /*--- comment by Benjaporn J.
                nv_ctotprmtre = nv_ctotprmtre + nv_prmtre
                nv_ctotearn2  = nv_ctotearn2  + nv_earn2 
                nv_ctotuearn2 = nv_ctotuearn2 + nv_uearn2.  
            
            PUT STREAM ns3
                nv_prmtre FORMAT "->>,>>>,>>>,>>>.99" "|" 
                nv_earn2  FORMAT "->>,>>>,>>>,>>>.99" "|" 
                nv_uearn2 FORMAT "->>,>>>,>>>,>>>.99" "|"  end comment by Benjaporn J.--- */ 
                uwm100.polsta SKIP.      /*A56-0092*/ .
                
            FOR EACH wrk0f:
                DELETE wrk0f.
            END.
            
            ASSIGN
                n_rb_pf     = 0      n_rb_sum    = 0
                n_rb_prm    = 0      nv_prmtre   = 0
                n_prmf1     = 0      n_prmf2     = 0 
                n_prmt      = 0      n_prms      = 0 
                n_prmq      = 0      n_prmtfp    = 0
                n_prmps     = 0      n_prmbtr    = 0
                n_prmotr    = 0      n_prms8     = 0 
                n_prmf4     = 0      n_prmftr    = 0. 
        END.
        ELSE DO: /*ถ้าช่อง Date มีค่าเป็น ? หรือ ติดลบ ให้แยกมาออกอีกรายงานนึง*/
        
            n_count  = n_count + 1 .
            
            IF fi_asdate - uwm100.comdat > 0 THEN nv_datecal = fi_asdate - uwm100.comdat + 1.
            ELSE nv_datecal = 0.
            
            /*-- Earn , Uearn เบี้ยประกัน---*/
            IF nv_datecal >= nv_expdat THEN nv_earn =  uwm100.prem_t.
            ELSE nv_earn = ( uwm100.prem_t / nv_expdat) * nv_datecal.
            
            nv_uearn =  uwm100.prem_t - nv_earn.
            /*-- Earn , Uearn เบี้ยประกัน---*/
            
            PUT STREAM ns2 nv_dir                                                 "|"
                           n_branch                                               "|"   
                           uwm100.poltyp                                          "|"    
                           uwm100.trndat FORMAT "99/99/9999"                      "|"   
                           uwm100.policy                                          "|"  
                           uwm100.endno  FORMAT "X(10)"                           "|"
                           uwm100.comdat FORMAT "99/99/9999"                      "|"    
                           uwm100.expdat FORMAT "99/99/9999"                      "|" 
                           nv_expdat     FORMAT "->>>>>>9"                        "|"
                           nv_datecal    FORMAT "->>>>>>9"                        "|"
                           uwm100.prem_t FORMAT "->>,>>>,>>>,>>>.99"              "|"    /*เบี้ยประกัน*/
                           nv_earn       FORMAT "->>,>>>,>>>,>>>.99"              "|" 
                           nv_uearn      FORMAT "->>,>>>,>>>,>>>.99"              "|".
            
            FOR EACH wrk0f:
            
              FIND xmm600 WHERE xmm600.acno = wrk0f.rico NO-LOCK NO-ERROR.
              IF AVAILABLE xmm600 THEN DO:
                IF (xmm600.clicod = "RD") OR (xmm600.clicod = "RB") THEN
                  ASSIGN
                     n_rb_pf   = n_rb_pf  + wrk0f.pf
                     n_rb_sum  = n_rb_sum + wrk0f.sumf
                     n_rb_prm  = n_rb_prm + (wrk0f.prmf * (-1)) .
                ELSE IF (xmm600.clicod = "RF") OR 
                        (xmm600.clicod = "RA") THEN  
                       ASSIGN
                          n_rf_pf   = n_rf_pf  + wrk0f.pf
                          n_rf_sum  = n_rf_sum + wrk0f.sumf
                          n_rf_prm  = n_rf_prm + (wrk0f.prmf * (-1)) .
              END.
            
            END. /* END FOR EACH wrk0f */
            
            nv_prmtre = n_prmf1 + n_prmf2 + n_prmt + n_prms + n_prmq + n_prmtfp +
                        n_prmps + n_prmbtr + n_prmotr + n_prms8 + n_prmf4 + n_prmftr + n_prmrq.
                        n_rf_prm + n_rb_prm . /*Lukkana M. A55-0357 20/11/2012*/ 
            
            /*-- Earn , Uearn เบี้ย ceded---*/
            IF nv_datecal >= nv_expdat THEN nv_earn2 = nv_prmtre.
            ELSE nv_earn2 = (nv_prmtre / nv_expdat) * nv_datecal.
            
            nv_uearn2 = nv_prmtre - nv_earn2.
            /*-- Earn , Uearn เบี้ย ceded---*/ 

            PUT STREAM ns2
                nv_prmtre FORMAT "->>,>>>,>>>,>>>.99" "|" 
                nv_earn2  FORMAT "->>,>>>,>>>,>>>.99" "|" 
                nv_uearn2 FORMAT "->>,>>>,>>>,>>>.99" "|"
                uwm100.polsta SKIP.      /*A56-0092*/.
                
            FOR EACH wrk0f:
                DELETE wrk0f.
            END.
            
            ASSIGN
                n_rb_pf     = 0     n_rb_sum    = 0
                n_rb_prm    = 0     nv_prmtre   = 0
                n_prmf1     = 0     n_prmf2     = 0 
                n_prmt      = 0     n_prms      = 0 
                n_prmq      = 0     n_prmtfp    = 0
                n_prmps     = 0     n_prmbtr    = 0
                n_prmotr    = 0     n_prms8     = 0 
                n_prmf4     = 0     n_prmftr    = 0. 
        
        END.

END.
ELSE DO:   /*---For not Cancel---*/

        IF nv_expdat <> ? AND nv_expdat >= 0 AND nv_expdat <= 3650 THEN DO: /*เช็คเงื่อนไขเพื่อแยกข้อมูล error ออกเป็นอีกไฟล์*/
        
            nv_count  = nv_count + 1 .
        
            IF fi_asdate - uwm100.comdat > 0 THEN nv_datecal = fi_asdate - uwm100.comdat + 1.
            ELSE nv_datecal = 0.
            
            /*-- Earn , Uearn เบี้ยประกัน---*/
            IF nv_datecal >= nv_expdat THEN nv_earn =  uwm100.prem_t.
            ELSE nv_earn = ( uwm100.prem_t / nv_expdat) * nv_datecal.
            
            nv_uearn =  uwm100.prem_t - nv_earn.
            /*-- Earn , Uearn เบี้ยประกัน---*/
            
            PUT STREAM ns1 nv_dir                                                 "|"
                           n_branch                                               "|"   
                           uwm100.poltyp                                          "|"    
                           uwm100.trndat FORMAT "99/99/9999"                      "|"   
                           uwm100.policy                                          "|"  
                           uwm100.endno  FORMAT "X(10)"                           "|"
                           uwm100.comdat FORMAT "99/99/9999"                      "|"    
                           uwm100.expdat FORMAT "99/99/9999"                      "|" 
                           nv_expdat     FORMAT ">>>>>>9"                         "|"
                           nv_datecal    FORMAT ">>>>>>9"                         "|"
                           uwm100.prem_t FORMAT "->>,>>>,>>>,>>>.99"              "|"    /*เบี้ยประกัน*/
                           nv_earn       FORMAT "->>,>>>,>>>,>>>.99"              "|" 
                           nv_uearn      FORMAT "->>,>>>,>>>,>>>.99"              "|".
            
            FOR EACH wrk0f:
            
              FIND xmm600 WHERE xmm600.acno = wrk0f.rico NO-LOCK NO-ERROR.
              IF AVAILABLE xmm600 THEN DO:
                IF (xmm600.clicod = "RD") OR (xmm600.clicod = "RB") THEN
                  ASSIGN
                     n_rb_pf   = n_rb_pf  + wrk0f.pf
                     n_rb_sum  = n_rb_sum + wrk0f.sumf
                     n_rb_prm  = n_rb_prm + (wrk0f.prmf * (-1)) .
            
                ELSE IF (xmm600.clicod = "RF") OR 
                        (xmm600.clicod = "RA") THEN  
                       ASSIGN
                          n_rf_pf   = n_rf_pf  + wrk0f.pf
                          n_rf_sum  = n_rf_sum + wrk0f.sumf
                          n_rf_prm  = n_rf_prm + (wrk0f.prmf * (-1)) .
              END.
            
            END. /* END FOR EACH wrk0f */
            /*----- comment by Benjaporn J.
            nv_prmtre = n_prmf1 + n_prmf2 + n_prmt + n_prms + n_prmq + n_prmtfp +
                        n_prmps + n_prmbtr + n_prmotr + n_prms8 + n_prmf4 + n_prmftr + 
                        n_rf_prm + n_rb_prm + n_prmrq . /*Lukkana M. A55-0357 20/11/2012*/
               
            /*-- Earn , Uearn เบี้ย ceded---*/
            IF nv_datecal >= nv_expdat THEN nv_earn2 = nv_prmtre.
            ELSE nv_earn2 = (nv_prmtre / nv_expdat) * nv_datecal.
            
            nv_uearn2 = nv_prmtre - nv_earn2.
            /*-- Earn , Uearn เบี้ย ceded---*/     end comment by Benjaporn J.--- */ 
   
            /* start A58-0242 Benjaporn J. 13/07/2015 */
            /*---Treaty---*/
            nv_prmtrt = n_prmf1 + n_prmf2 + n_prmt + n_prms + n_prmq + n_prmtfp +
                        n_prmps + n_prmbtr + n_prmotr + n_prms8 + n_prmf4 + n_prmftr + n_prmrq.    

            IF   nv_datecal >= nv_expdat THEN nv_earntrt = nv_prmtrt.
            ELSE nv_earntrt = (nv_prmtrt / nv_expdat) * nv_datecal.
            nv_uearntrt = nv_prmtrt - nv_earntrt.

            /*---FAC---*/
            nv_prmfac = n_rf_prm + n_rb_prm .                   
            
            IF   nv_datecal >= nv_expdat THEN nv_earnfac = nv_prmfac.
            ELSE nv_earnfac = (nv_prmfac / nv_expdat) * nv_datecal.
            
            nv_uearnfac = nv_prmfac - nv_earnfac. /* end A58-0242 Benjaporn J. 13/07/2015 */
            
             ASSIGN /*Grand total*/
                nv_totprmcom = nv_totprmcom + uwm100.prem_t    
                nv_totearn   = nv_totearn   + nv_earn     
                nv_totuearn  = nv_totuearn  + nv_uearn         
                nv_totprmtre = nv_totprmtre + nv_prmtre
                nv_totearn2  = nv_totearn2  + nv_earn2 
                nv_totuearn2 = nv_totuearn2 + nv_uearn2.
            
            PUT STREAM ns1

             /* comment by Benjaporn J.
                nv_prmtre FORMAT "->>,>>>,>>>,>>>.99" "|" 
                nv_earn2  FORMAT "->>,>>>,>>>,>>>.99" "|" 
                nv_uearn2 FORMAT "->>,>>>,>>>,>>>.99" "|"  */
                uwm100.polsta SKIP.      /*A56-0092*/ .
                
            FOR EACH wrk0f:
                DELETE wrk0f.
            END.
            
            ASSIGN
                n_rb_pf     = 0      n_rb_sum    = 0
                n_rb_prm    = 0      nv_prmtre   = 0
                n_prmf1     = 0      n_prmf2     = 0 
                n_prmt      = 0      n_prms      = 0 
                n_prmq      = 0      n_prmtfp    = 0
                n_prmps     = 0      n_prmbtr    = 0
                n_prmotr    = 0      n_prms8     = 0 
                n_prmf4     = 0      n_prmftr    = 0. 
        END.
        ELSE DO: /*ถ้าช่อง Date มีค่าเป็น ? หรือ ติดลบ ให้แยกมาออกอีกรายงานนึง*/
        
            n_count  = n_count + 1 .
            
            IF fi_asdate - uwm100.comdat > 0 THEN nv_datecal = fi_asdate - uwm100.comdat + 1.
            ELSE nv_datecal = 0.
            
            /*-- Earn , Uearn เบี้ยประกัน---*/
            IF nv_datecal >= nv_expdat THEN nv_earn =  uwm100.prem_t.
            ELSE nv_earn = ( uwm100.prem_t / nv_expdat) * nv_datecal.
            
            nv_uearn =  uwm100.prem_t - nv_earn.
            /*-- Earn , Uearn เบี้ยประกัน---*/
            
            PUT STREAM ns2 nv_dir                                                 "|"
                           n_branch                                               "|"   
                           uwm100.poltyp                                          "|"    
                           uwm100.trndat FORMAT "99/99/9999"                      "|"   
                           uwm100.policy                                          "|"  
                           uwm100.endno  FORMAT "X(10)"                           "|"
                           uwm100.comdat FORMAT "99/99/9999"                      "|"    
                           uwm100.expdat FORMAT "99/99/9999"                      "|" 
                           nv_expdat     FORMAT "->>>>>>9"                        "|"
                           nv_datecal    FORMAT "->>>>>>9"                        "|"
                           uwm100.prem_t FORMAT "->>,>>>,>>>,>>>.99"              "|"    /*เบี้ยประกัน*/
                           nv_earn       FORMAT "->>,>>>,>>>,>>>.99"              "|" 
                           nv_uearn      FORMAT "->>,>>>,>>>,>>>.99"              "|".
            
            FOR EACH wrk0f:
            
              FIND xmm600 WHERE xmm600.acno = wrk0f.rico NO-LOCK NO-ERROR.
              IF AVAILABLE xmm600 THEN DO:
                IF (xmm600.clicod = "RD") OR (xmm600.clicod = "RB") THEN
                  ASSIGN
                     n_rb_pf   = n_rb_pf  + wrk0f.pf
                     n_rb_sum  = n_rb_sum + wrk0f.sumf
                     n_rb_prm  = n_rb_prm + (wrk0f.prmf * (-1)) .
                ELSE IF (xmm600.clicod = "RF") OR 
                        (xmm600.clicod = "RA") THEN  
                       ASSIGN
                          n_rf_pf   = n_rf_pf  + wrk0f.pf
                          n_rf_sum  = n_rf_sum + wrk0f.sumf
                          n_rf_prm  = n_rf_prm + (wrk0f.prmf * (-1)) .
              END.
            
            END. /* END FOR EACH wrk0f */
            
            nv_prmtre = n_prmf1 + n_prmf2 + n_prmt + n_prms + n_prmq + n_prmtfp +
                        n_prmps + n_prmbtr + n_prmotr + n_prms8 + n_prmf4 + n_prmftr + 
                        n_rf_prm + n_rb_prm + n_prmrq . /*Lukkana M. A55-0357 20/11/2012*/
            
            /*-- Earn , Uearn เบี้ย ceded---*/
            IF nv_datecal >= nv_expdat THEN nv_earn2 = nv_prmtre.
            ELSE nv_earn2 = (nv_prmtre / nv_expdat) * nv_datecal.
            
            nv_uearn2 = nv_prmtre - nv_earn2.
            /*-- Earn , Uearn เบี้ย ceded---*/
            
            PUT STREAM ns2
                nv_prmtre FORMAT "->>,>>>,>>>,>>>.99" "|" 
                nv_earn2  FORMAT "->>,>>>,>>>,>>>.99" "|" 
                nv_uearn2 FORMAT "->>,>>>,>>>,>>>.99" "|"
                uwm100.polsta SKIP.      /*A56-0092*/.
                
            FOR EACH wrk0f:
                DELETE wrk0f.
            END.
            
            ASSIGN
                n_rb_pf     = 0     n_rb_sum    = 0
                n_rb_prm    = 0     nv_prmtre   = 0
                n_prmf1     = 0     n_prmf2     = 0 
                n_prmt      = 0     n_prms      = 0 
                n_prmq      = 0     n_prmtfp    = 0
                n_prmps     = 0     n_prmbtr    = 0
                n_prmotr    = 0     n_prms8     = 0 
                n_prmf4     = 0     n_prmftr    = 0. 
        
        END.
END. */  

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pd_HeaderMotor C-Win 
PROCEDURE Pd_HeaderMotor :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN
    nv_today  =  TODAY
    nv_row    =  1.

OUTPUT STREAM ns1 TO VALUE(nv_output).
/*PUT STREAM ns1  "Unearn Premium Report (Expiry Date)" "|" SKIP Lukkana M. A55-0144 23/04/2012*/
PUT STREAM ns1  nv_text                         "|"       SKIP /*Lukkana M. A55-0144 23/04/2012*/
                "Branch From : "  fi_branchfr   "|"
                "To : "  fi_branchto            "|"
                "Releas Flag : "  fi_releas     "|"       SKIP
                "Agent From : "   fi_agentfr    "|"
                "To : "           fi_agentto    "|"  
                "Policy Type : "  fi_poltyp " = Motor"     "|"
                "Transection Date : "  fi_trndat " to " fi_trndatto  "|" SKIP  /*  A58-0242 Benjaporn J. 28/07/2015 */
                /*nv_text1                        "|"       SKIP /*Lukkana M. A55-0144 23/04/2012*/ comment A58-0242 */
                "As Of Date : "  fi_asdate      "|"
                "Report Date:  " nv_today       "|"       
                fi_stime "  [WACR60]"  SKIP . 

PUT STREAM ns1  "D/I"                   "|"
                "สาขา"                  "|"
                "ประเภทกรมธรรม์"        "|"
                "วันทำสัญญา"            "|"
                "เลขที่กรมธรรม์"        "|"
                "เลขที่สลักหลัง"        "|"
                "วันที่เริ่มต้น"        "|"
                "วันที่สิ้นสุด"         "|"
                "Date"                  "|"
                "Date Cal"              "|"
                "เบี้ยพรบ."             "|"
                "เบี้ยรถยนต์"           "|"
                "Earn พรบ."             "|"
                "Unearn พรบ."           "|" 
                "Earn รถยนต์"           "|"
                "Unearn รถยนต์"         "|"
     /* comment by Benjaporn J.            
                "เบี้ย Ceded"           "|"
                "Earn Ceded"            "|"
                "Unearn Ceded"          "|"  end comment by Benjaporn J.*/
     /* start A58-0242 Benjaporn J. 13/07/2015 */ 
                "เบี้ย treaty"          "|"
                "Earn treaty"           "|"
                "Unearn treaty"         "|" 
                "เบี้ย Fac"             "|"
                "Earn Fac"              "|"
                "Unearn Fac"            "|"  /* end A58-0242 Benjaporn J. 13/07/2015 */
                "Status"  SKIP.    /*A56-0092*/




END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pd_HeaderMotorCan C-Win 
PROCEDURE Pd_HeaderMotorCan :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       By A56-0092  
------------------------------------------------------------------------------*/

ASSIGN
    nv_today  =  TODAY
    nv_row    =  1.

/*-- Header Cancel--*/
OUTPUT STREAM ns3 TO VALUE(nv_output2). 
PUT STREAM ns3  nv_text2                        "|"       SKIP   /*Lukkana M. A55-0144 23/04/2012*/
                "Branch From : "  fi_branchfr   "|"
                "To : "  fi_branchto            "|"
                "Releas Flag : "  fi_releas     "|"       SKIP
                "Agent From : "   fi_agentfr    "|"
                "To : "           fi_agentto    "|"  
                "Policy Type : "  fi_poltyp " = Motor" "|" 
                "Transection Date : "  fi_trndat " to " fi_trndatto  "|" SKIP  /*  A58-0242 Benjaporn J. 28/07/2015 */
                /*nv_text1                        "|"       SKIP /*Lukkana M. A55-0144 23/04/2012*/ comment A58-0242 */
                "As Of Date : " fi_asdate       "|" 
                "Report Date:  " nv_today       "|"
                fi_stime  "  [WACR60]"  SKIP . 

PUT STREAM ns3  "D/I"                   "|"
                "สาขา"                  "|"
                "ประเภทกรมธรรม์"        "|"
                "วันทำสัญญา"            "|"
                "เลขที่กรมธรรม์"        "|"
                "เลขที่สลักหลัง"        "|"
                "วันที่เริ่มต้น"        "|"
                "วันที่สิ้นสุด"         "|"
                "Date"                  "|"
                "Date Cal"              "|"
                "เบี้ยพรบ."             "|"
                "เบี้ยรถยนต์"           "|"
                "Earn พรบ."             "|"
                "Unearn พรบ."           "|" 
                "Earnร ถยนต์"           "|"
                "Unearn รถยนต์"         "|"
     /* comment by Benjaporn J.
                "เบี้ย Ceded"           "|"
                "Earn Ceded"            "|"
                "Unearn Ceded"          "|"   end comment by Benjaporn J.*/
     /* start A58-0242 Benjaporn J. 13/07/2015 */ 
                "เบี้ย treaty"          "|"
                "Earn treaty"           "|"
                "Unearn treaty"         "|" 
                "เบี้ย Fac"             "|"
                "Earn Fac"              "|"
                "Unearn Fac"            "|"  /* end A58-0242 Benjaporn J. 13/07/2015 */
                "Status"  SKIP.   /*A56-0092*/


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pd_HeaderMotorerror C-Win 
PROCEDURE Pd_HeaderMotorerror :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

ASSIGN
    nv_today  =  TODAY
    nv_row    =  1.

/*-- Header Error--*/
OUTPUT STREAM ns2 TO VALUE(nv_output1). 
/*PUT STREAM ns2  "Unearn Premium Report (Expiry Date)" "|" SKIP Lukkana M. A55-0144 23/04/2012*/
PUT STREAM ns2  nv_text                         "|"       SKIP   /*Lukkana M. A55-0144 23/04/2012*/
                "Branch From : "  fi_branchfr   "|"
                "To : "  fi_branchto            "|"
                "Releas Flag : "  fi_releas     "|"       SKIP
                "Agent From : "   fi_agentfr    "|"
                "To : "           fi_agentto    "|"  
                "Policy Type : "  fi_poltyp " = Motor" "|" 
                "Transection Date : "  fi_trndat " to " fi_trndatto  "|"  SKIP /*  A58-0242 Benjaporn J. 28/07/2015 */
               /* nv_text1                        "|"       SKIP /*Lukkana M. A55-0144 23/04/2012*/ comment A58-0242 */
                "As Of Date : " fi_asdate       "|" 
                "Report Date:  " nv_today       "|"
                fi_stime  "  [WACR60]"  SKIP . 

PUT STREAM ns2  "D/I"                   "|"
                "สาขา"                  "|"
                "ประเภทกรมธรรม์"        "|"
                "วันทำสัญญา"            "|"
                "เลขที่กรมธรรม์"        "|"
                "เลขที่สลักหลัง"        "|"
                "วันที่เริ่มต้น"        "|"
                "วันที่สิ้นสุด"         "|"
                "Date"                  "|"
                "Date Cal"              "|"
                "เบี้ยพรบ."             "|"
                "เบี้ยรถยนต์"           "|"
                "Earn พรบ."             "|"
                "Unearn พรบ."           "|" 
                "Earn รถยนต์"           "|"
                "Unearn รถยนต์"         "|"
     /* comment by Benjaporn J.
                "เบี้ย Ceded"           "|"
                "Earn Ceded"            "|"
                "Unearn Ceded"          "|"  end comment by Benjaporn J.*/
     /* start A58-0242 Benjaporn J. 13/07/2015 */ 
                "เบี้ย treaty"          "|"
                "Earn treaty"           "|"
                "Unearn treaty"         "|" 
                "เบี้ย Fac"             "|"
                "Earn Fac"              "|"
                "Unearn Fac"            "|"  /* end A58-0242 Benjaporn J. 13/07/2015 */
                "Status" SKIP.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pd_HeaderNon C-Win 
PROCEDURE Pd_HeaderNon :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN
    nv_today  =  TODAY
    nv_row    =  1.

OUTPUT STREAM ns1 TO VALUE(nv_output).
/*PUT STREAM ns1  "Unearn Premium Report (Expiry Date)" "|" SKIP Lukkana M. A55-0144 23/04/2012*/    
PUT STREAM ns1  nv_text                         "|"       SKIP /*Lukkana M. A55-0144 23/04/2012*/    
                "Branch From : "  fi_branchfr   "|"
                "To : "  fi_branchto            "|"
                "Releas Flag : "  fi_releas     "|"       SKIP
                "Agent From : "   fi_agentfr    "|"
                "To : "           fi_agentto    "|"  
                "Policy Type : "  fi_poltyp " = Non Motor"  "|"
                "Transection Date : "  fi_trndat " to " fi_trndatto  "|" SKIP  /*  A58-0242 Benjaporn J. 28/07/2015 */
             /*   nv_text1                        "|"       SKIP /*Lukkana M. A55-0144 23/04/2012*/  comment A58-0242 */
                "As Of Date : "  fi_asdate      "|"
                "Report Date:  " nv_today       "|"  
                fi_stime "  [WACR60]"  SKIP . 

PUT STREAM ns1  "D/I"                           "|"
                "สาขา"                          "|"
                "ประเภทกรมธรรม์"                "|"
                "วันทำสัญญา"                    "|"
                "เลขที่กรมธรรม์"                "|"
                "เลขที่ใบสลักหลังกรมธรรม์"      "|"
                "วันที่เริ่มต้น"                "|"
                "วันที่สิ้นสุด"                 "|"
                "Date"                          "|"
                "Date Cal"                      "|"
                "เบี้ยประกัน"                   "|"
                "Earn เบี้ยประกัน"              "|"
                "Unearn เบี้ยประกัน"            "|" 
     /* comment by Benjaporn J.
                "เบี้ย Ceded"                   "|"
                "Earn Ceded"                    "|"
                "Unearn Ceded"                  "|"   end comment by Benjaporn J.*/
     /* start A58-0242 Benjaporn J. 13/07/2015 */ 
                "เบี้ย treaty"                  "|"
                "Earn treaty"                   "|"
                "Unearn treaty"                 "|" 
                "เบี้ย Fac"                     "|"
                "Earn Fac"                      "|"
                "Unearn Fac"                    "|"  /* end A58-0242 Benjaporn J. 13/07/2015 */
                "Status"  SKIP.



END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pd_HeaderNonCan C-Win 
PROCEDURE Pd_HeaderNonCan :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       A56-0092
------------------------------------------------------------------------------*/
ASSIGN
    nv_today  =  TODAY
    nv_row    =  1.

/*-- Header Cancel--*/
OUTPUT STREAM ns3 TO VALUE(nv_output2).
PUT STREAM ns3  nv_text "|" SKIP /*Lukkana M. A55-0144 23/04/2012*/
                "Branch From : "  fi_branchfr   "|"
                "To : "  fi_branchto            "|"
                "Releas Flag : "  fi_releas     "|"       SKIP
                "Agent From : "   fi_agentfr    "|"
                "To : "           fi_agentto    "|"  
                "Policy Type : "  fi_poltyp " = Non Motor" "|"
                "Transection Date : "  fi_trndat " to " fi_trndatto  "|" SKIP  /*  A58-0242 Benjaporn J. 28/07/2015 */
             /*   nv_text1                        "|"       SKIP /*Lukkana M. A55-0144 23/04/2012*/ comment A58-0242 */
                "As Of Date : "   fi_asdate     "|"
                "Report Date:  " nv_today       "|"
                fi_stime "  [WACR60]"  SKIP . 

PUT STREAM ns3  "D/I"                           "|"
                "สาขา"                          "|"
                "ประเภทกรมธรรม์"                "|"
                "วันทำสัญญา"                    "|"
                "เลขที่กรมธรรม์"                "|"
                "เลขที่ใบสลักหลังกรมธรรม์"      "|"
                "วันที่เริ่มต้น"                "|"
                "วันที่สิ้นสุด"                 "|"
                "Date"                          "|"
                "Date Cal"                      "|"
                "เบี้ยประกัน"                   "|"
                "Earn เบี้ยประกัน"              "|"
                "Unearn เบี้ยประกัน"             "|" 
             /* comment by Benjaporn J.           
                "เบี้ย Ceded"                   "|"
                "Earn Ceded"                    "|"
                "Unearn Ceded"                  "|"  end comment by Benjaporn J.*/
             /* start A58-0242 Benjaporn J. 13/07/2015 */ 
                "เบี้ย treaty"                  "|"
                "Earn treaty"                   "|"
                "Unearn treaty"                 "|" 
                "เบี้ย Fac"                     "|"
                "Earn Fac"                      "|"
                "Unearn Fac"                    "|"  /* end A58-0242 Benjaporn J. 13/07/2015 */
                "Status"  SKIP.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pd_HeaderNonerror C-Win 
PROCEDURE Pd_HeaderNonerror :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN
    nv_today  =  TODAY
    nv_row    =  1.

/*-- Header Error--*/
OUTPUT STREAM ns2 TO VALUE(nv_output1).
/*PUT STREAM ns2  "Unearn Premium Report (Expiry Date)" "|" SKIP Lukkana M. A55-0144 23/04/2012*/
PUT STREAM ns2  nv_text "|" SKIP /*Lukkana M. A55-0144 23/04/2012*/
                "Branch From : "  fi_branchfr   "|"
                "To : "  fi_branchto            "|"
                "Releas Flag : "  fi_releas     "|"       SKIP
                "Agent From : "   fi_agentfr    "|"
                "To : "           fi_agentto    "|"  
                "Policy Type : "  fi_poltyp " = Non Motor" "|"
                "Transection Date : "  fi_trndat " to " fi_trndatto  "|" SKIP /*  A58-0242 Benjaporn J. 28/07/2015 */
             /*  nv_text1                        "|"       SKIP /*Lukkana M. A55-0144 23/04/2012*/ comment A58-0242 */
                "As Of Date : "   fi_asdate     "|"
                "Report Date:  " nv_today       "|"
                fi_stime "  [WACR60]"  SKIP . 

PUT STREAM ns2  "D/I"                           "|"
                "สาขา"                          "|"
                "ประเภทกรมธรรม์"                "|"
                "วันทำสัญญา"                    "|"
                "เลขที่กรมธรรม์"                "|"
                "เลขที่ใบสลักหลังกรมธรรม์"      "|"
                "วันที่เริ่มต้น"                "|"
                "วันที่สิ้นสุด"                 "|"
                "Date"                          "|"
                "Date Cal"                      "|"
                "เบี้ยประกัน"                   "|"
                "Earn เบี้ยประกัน"              "|"
                "Unearn เบี้ยประกัน"             "|" 
    /* comment by Benjaporn J.
                "เบี้ย Ceded"                   "|"
                "Earn Ceded"                    "|"
                "Unearn Ceded"                  "|"  end comment by Benjaporn J.*/
     /* start A58-0242 Benjaporn J. 13/07/2015 */ 
                "เบี้ย treaty"                  "|"
                "Earn treaty"                   "|"
                "Unearn treaty"                 "|" 
                "เบี้ย Fac"                     "|"
                "Earn Fac"                      "|"
                "Unearn Fac"                    "|"  /* end A58-0242 Benjaporn J. 13/07/2015 */
                "Status"  SKIP.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_initData C-Win 
PROCEDURE pd_initData :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       A58-0242 Benjaporn J. 13/07/2015
------------------------------------------------------------------------------*/
ASSIGN nv_prstp   =  uwm100.pstp + uwm100.rstp
       nv_prtax   =  uwm100.ptax + uwm100.rtax
       nv_sumpts  =  uwm100.prem_t + nv_prstp + nv_prtax - n_paprm - n_tstppa - n_taxpa
       n_sumprm   =  uwm100.prem_t - n_prmcom - n_paprm
       n_sumstp   =  nv_prstp - n_tstpcom - n_tstppa
       n_sumtax   =  nv_prtax
       n_compa_t  =  - n_paprm * nv_com1p / 100
       nu_tax = n_sumtax - n_taxpa
       nu_prm = n_prmcom + n_sumprm + n_tstpcom + n_sumstp
       nu_vat = nu_tax.

ASSIGN nv_expdat  = 0        nv_datecal = 0
       nv_earn    = 0        nv_uearn   = 0
       nv_earn1   = 0        nv_uearn1  = 0
     /*nv_earn2   = 0        nv_uearn2  = 0*/
       nv_prmtre  = 0.                          

/*----- A63-0159 ----*/
/*------ nv_expdat  = uwm100.expdat - uwm100.comdat + 1.  ----*/

IF uwm100.comdat <> ? THEN nv_comdat  = uwm100.comdat.
ELSE nv_comdat = uwm100.trndat.
        
nv_expdat  = uwm100.expdat - nv_comdat + 1. 

IF fi_poltyp = "1" THEN DO:

   IF uwm100.polsta = "CA" THEN DO:
      ASSIGN nv_expdat = uwm100.expdat - uwm100.trndat + 1.
      nv_comdat = uwm100.trndat.
   END.

END.
/*-------end A63-0159------------*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pd_Motor C-Win 
PROCEDURE Pd_Motor :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH wrk0f.
    DELETE wrk0f.
END.
FOR EACH wtotal.
    DELETE wtotal.
END.
RUN Pd_Checkbranch.

ASSIGN
    n_rec    = 1
    n_rec1   = 1
    n_rec2   = 1   /*A56-0092*/
    nv_count = 0
    n_count  = 0
    n_count1 = 0    /*A56-0092*/
    nv_poltyp = "" .
FOR EACH wfline NO-LOCK.
    ASSIGN nv_poltyp = trim(nv_poltyp +  "," + wfline.nline) .
END.
/*comment by Kridtiya i. A58-0180 .....
loopmain:
FOR EACH uwm100 NO-LOCK USE-INDEX uwm10092 WHERE 
         uwm100.expdat  >=  fi_asdate               AND 
         uwm100.agent   >=  fi_agentfr              AND
         uwm100.agent   <=  fi_agentto              AND
         uwm100.trndat  <=  fi_asdate               AND
  INDEX( nv_brdes, "," + TRIM(uwm100.branch)) <> 0  AND
      (( fi_releas = "Y"  AND UWM100.RELEAS = YES ) OR
       ( fi_releas = "N"  AND UWM100.RELEAS = NO  ) OR
       ( fi_releas = "A"))  BREAK BY uwm100.poltyp 
                                  /*BY uwm100.branch */
                                  BY uwm100.policy
                                  /*BY uwm100.endno
                                  BY uwm100.trndat
                                  BY uwm100.tranty*/ .
   end...comment by kridtiya i. A58-0180 */
/*Add by Kridtiya i. A58-0180 */
loopmain:
FOR EACH uwm100 NO-LOCK USE-INDEX uwm10008 WHERE 
    uwm100.trndat  >=  fi_trndat      AND
    uwm100.trndat  <=  fi_trndatto    AND
    uwm100.expdat  >=  fi_asdate      AND 
    uwm100.agent   >=  fi_agentfr     AND
    uwm100.agent   <=  fi_agentto     AND
    uwm100.branch  >=  fi_branchfr    AND
    uwm100.branch  <=  fi_branchto    AND
    UWM100.RELEAS   = nv_releas
    BREAK BY uwm100.poltyp 
          BY uwm100.policy  .
/*Add by Kridtiya i. A58-0180*/
   fi_etime = STRING(TIME,"HH:MM:SS"). /*Lukkana M. A55-0144 25/04/2012*/
   n_bran   = "".
   n_bran   = uwm100.branch.
   DISP fi_stime fi_etime WITH FRAME fr_main. /*Lukkana M. A55-0144 25/04/2012*/
   
   IF SUBSTR(uwm100.policy,1,1) = "I" THEN DO:

         IF nv_brdes1 = ""  THEN NEXT loopmain.
         IF INDEX(nv_brdes1,",9" + SUBSTRING(uwm100.policy,2,1)) <> 0 THEN 
             n_bran = "9" + SUBSTRING(uwm100.policy,2,1). 
   END.
   ELSE  DO:    
         IF INDEX("ABCDEFGHIJKLMNOPQRSTUVWXYZ" , fi_branchto) <> 0  THEN DO: /*พบตัวอักษรในbranch*/
            IF uwm100.branch < fi_branchfr OR uwm100.branch > fi_branchto THEN NEXT loopmain.
         END.
         ELSE DO:
            IF INTEGER(uwm100.branch) < nv_brn_fr OR INTEGER(uwm100.branch) > nv_brn_to THEN NEXT loopmain.
         END.
   END.  
/*ASSIGN
       nv_poltyp = "" 
       nv_poltyp = fi_exc1  + "," + fi_exc2  + "," + fi_exc3  + "," + fi_exc4  + "," + fi_exc5  + "," +
                   fi_exc6  + "," + fi_exc7  + "," + fi_exc8  + "," + fi_exc9  + "," + fi_exc10 + "," +
                   fi_exc11 + "," + fi_exc12 + "," + fi_exc13 + "," + fi_exc14 + "," + fi_exc15 + "," +
                   fi_exc16 + "," + fi_exc17 + "," + fi_exc18 + "," + fi_exc19 + "," + fi_exc20.*/
   

   FIND xmm031 USE-INDEX xmm03101       WHERE 
        xmm031.poltyp = uwm100.poltyp   NO-LOCK NO-ERROR.
   IF AVAIL xmm031 THEN DO:
       IF xmm031.dept <> "G" AND xmm031.dept <> "M" THEN NEXT loopmain.
       IF LOOKUP(xmm031.poltyp,nv_poltyp) <> 0  THEN NEXT loopmain.
   END.
   /*nv_count  = nv_count + 1 .*/
   /*------A63-0159----Change from 65000 to 1000000 --*/
   IF nv_count > 1000000 THEN DO:
       nv_output  = (fi_output  + "_" + STRING(n_rec)) .
       RUN Pd_HeaderMotor.
       n_rec = n_rec + 1.
       nv_count = 0.
   END.

   IF n_count > 1000000 THEN DO:
       nv_output1 = (fi_output +  "_error" + "_" + STRING(n_rec1)) .
       RUN Pd_HeaderMotorerror.
       n_rec1 = n_rec1 + 1.
       n_count = 0.
   END.
   
   IF n_count1 > 1000000 THEN DO:
       nv_output2 = (fi_output +  "_can" + "_" + STRING(n_rec2)) .
       RUN Pd_HeaderMotorCan.
       n_rec2 = n_rec2 + 1.
       n_count1 = 0.
   END.
   /*------------A63-0159--------*/

   IF FIRST-OF(uwm100.poltyp)   THEN do: 
       RUN Pd_Cleartreaty.
   END.         

   DISPLAY  uwm100.trndat  uwm100.policy  WITH NO-LABEL TITLE "Process Report..."
       FRAME a1 VIEW-AS DIALOG-BOX.

   FIND xmm023 USE-INDEX xmm02301 WHERE
        xmm023.branch = n_bran    NO-LOCK NO-ERROR.
   IF NOT AVAIL xmm023 THEN NEXT loopmain.
   n_branch = n_bran.
   n_bdes   = xmm023.bdes.

   IF uwm100.DIR_ri = YES THEN nv_dir = 'D'.
   ELSE nv_dir = 'I'.

   n_endcnt = uwm100.endcnt - 1.

   ASSIGN
       nv_prstp  = 0       n_prmcom   = 0
       nv_prtax  = 0       n_stp      = 0
       nv_sumpts = 0       n_tstpcom  = 0
       n_sumprm  = 0       n_taxcom   = 0
       n_sumstp  = 0       n_stptrunc = 0
       n_sumtax  = 0       n_stpcom   = 0
       nu_tax    = 0       n_ttaxcom  = 0
       nu_prm    = 0       n_paprm    = 0
       nu_vat    = 0       n_stppa    = 0
       nv_sum    = 0       n_tstppa   = 0
       n_an      = 0       n_taxpa    = 0
       nvexch    = 1       
       nv_prmtre = 0.      

   FIND FIRST uwm130 USE-INDEX uwm13001   WHERE
              uwm130.policy = uwm100.policy AND
              uwm130.rencnt = uwm100.rencnt AND
              uwm130.endcnt = uwm100.endcnt 
   NO-LOCK NO-ERROR.
   REPEAT WHILE avail uwm130:
        IF    uwm100.poltyp  = "V70"  THEN
              nv_sum  = nv_sum + uwm130.uom6_v.
        ELSE  nv_sum  = nv_sum + uwm130.uom9_v.
        
        FIND NEXT uwm130 USE-INDEX uwm13001   WHERE
                  uwm130.policy = uwm100.policy AND
                  uwm130.rencnt = uwm100.rencnt AND
                  uwm130.endcnt = uwm100.endcnt 
        NO-LOCK NO-ERROR.
   END.
   
   FIND FIRST uwm200 USE-INDEX uwm20001 WHERE
              uwm200.policy = UWM100.POLICY  AND
              uwm200.rencnt = uwm100.rencnt  AND
              uwm200.endcnt = uwm100.endcnt  AND
              uwm200.csftq  <> "C"
   NO-LOCK NO-ERROR.
   
   FIND FIRST uwm120 USE-INDEX uwm12001 WHERE
              uwm120.policy = uwm100.policy  AND
              uwm120.rencnt = uwm100.rencnt  AND
              uwm120.endcnt = uwm100.endcnt
   NO-LOCK NO-ERROR.
      nvexch = 1.

   IF AVAIL uwm120 THEN DO:
     IF SUBSTRING(uwm120.policy,3,2) = "90" THEN nvexch = 1.
     ELSE nvexch = uwm120.siexch.
   END.
    n_an = nv_sum * nvexch.
   FIND FIRST uwd132 USE-INDEX uwd13290   WHERE
              uwd132.policy = uwm100.policy AND
              uwd132.rencnt = uwm100.rencnt AND
              uwd132.endcnt = uwm100.endcnt 
   NO-LOCK NO-ERROR.
   
   REPEAT WHILE avail uwd132:
        IF uwd132.bencod = 'COMP' OR uwd132.bencod = 'COMG' OR
           uwd132.bencod = 'COMH'  THEN DO:
           n_prmcom   =  n_prmcom + uwd132.prem_c.
 
           n_stp      =  (uwd132.prem_c  *  0.4) / 100.
   
           IF n_stp - TRUNCATE(n_stp,0)  <> 0 then n_stp = TRUNCATE(n_stp,0) + 1.
           n_tstpcom  =  n_tstpcom + n_stp.
           n_taxcom   =  (n_prmcom + n_tstpcom) * uwm100.gstrat / 100.
        END.
        IF uwd132.bencod = "PA" THEN DO:
           n_paprm = n_paprm + uwd132.prem_c.
           n_stppa = (uwd132.prem_c  *  0.4) / 100.
   
           IF n_stppa - TRUNCATE(n_stppa,0)  <> 0 then n_stppa = TRUNCATE(n_stppa,0) + 1.
           n_tstppa = n_tstppa + n_stppa.
           n_taxpa = (n_paprm + n_tstppa) * uwm100.gstrat / 100.
        END.
        
        FIND NEXT uwd132 USE-INDEX uwd13290   WHERE
                  uwd132.policy = uwm100.policy AND
                  uwd132.rencnt = uwm100.rencnt AND
                  uwd132.endcnt = uwm100.endcnt   NO-LOCK NO-ERROR.
   END.
   
   ASSIGN
       n_prmt    = 0        n_prms    = 0
       n_prmq    = 0        n_prmtfp  = 0
       n_prmrq   = 0        n_prmf1   = 0
       n_prmf2   = 0        n_prmr    = 0
       n_prmps   = 0        n_prmbtr  = 0
       n_prmotr  = 0        n_prms8   = 0
       n_prmf4   = 0        n_prmftr  = 0.

   LOOPB:
   REPEAT:
      n_cnt1  = n_cnt1 + 1.
      s_recid = RECID(uwm200).
      ASSIGN
          n_prmt    = 0         n_prms    = 0 
          n_prmq    = 0         n_prmtfp  = 0 
          n_prmrq   = 0         n_prmf1   = 0 
          n_prmf2   = 0         n_prmr    = 0 
          n_prmps   = 0         n_prmbtr  = 0 
          n_prmotr  = 0         n_prms8   = 0
          n_prmf4   = 0         n_prmftr  = 0 .

      IF UWM100.TRANTY <> "C" THEN DO:
         RUN Pd_Process1.
      END.
      ELSE DO:
         RUN Pd_Process2.
      END.

      FIND NEXT uwm200  USE-INDEX  uwm20001  WHERE
                uwm200.policy = uwm100.policy  AND
                uwm200.rencnt = uwm100.rencnt  AND
                uwm200.endcnt = uwm100.endcnt
                NO-LOCK NO-ERROR.
      IF NOT AVAIL uwm200 THEN LEAVE loopb.
   END.   /* loopb */
   ASSIGN
        n_prmf1      =   n_prmf1     * (-1)
        n_prmf2      =   n_prmf2     * (-1)
        n_prmt       =   n_prmt      * (-1)
        n_prms       =   n_prms      * (-1)
        n_prmq       =   n_prmq      * (-1)
        n_prmtfp     =   n_prmtfp    * (-1)
        n_prmrq      =   n_prmrq     * (-1)
        n_prmps      =   n_prmps     * (-1)  
        n_prmbtr     =   n_prmbtr    * (-1)  
        n_prmotr     =   n_prmotr    * (-1)  
        n_prms8      =   n_prms8     * (-1)  

        n_prmf4      =   n_prmf4     * (-1)  
        n_prmftr     =   n_prmftr    * (-1).
   
   RUN Pd_detailMotor.
   
   ASSIGN
        nv_sum    = 0 
        p_t       = 000  n_sumt     = 0   n_prmt    = 0
        p_s       = 000  n_sums     = 0   n_prms    = 0
        p_q       = 000  n_sumq     = 0   n_prmq    = 0
        p_tfp     = 000  n_sumtfp   = 0   n_prmtfp  = 0
        p_rq      = 000  n_sumrq    = 0   n_prmrq   = 0
        p_f1      = 000  n_sumf1    = 0   n_prmf1   = 0
        p_f2      = 000  n_sumf2    = 0   n_prmf2   = 0
        p_r       = 000  n_sumr     = 0   n_prmr    = 0
        p_ps      = 000  n_sumps    = 0   n_prmps   = 0  
        p_btr     = 000  n_sumbtr   = 0   n_prmbtr  = 0  
        p_otr     = 000  n_sumotr   = 0   n_prmotr  = 0  
        p_s8      = 000  n_sums8    = 0   n_prms8   = 0  
        p_f4      = 000  n_sumf4    = 0   n_prmf4   = 0
        p_ftr     = 000  n_sumftr   = 0   n_prmftr  = 0
        n_rb_pf   = 000  n_rb_sum   = 0   n_rb_prm  = 0
        n_rf_pf   = 000  n_rf_sum   = 0   n_rf_prm  = 0
        nv_prmtre = 0.

   IF LAST-OF(uwm100.poltyp) THEN DO:
        
       ASSIGN
          pv_f1_prb   = pv_f1_prb   * (-1)      iv_f1_prb   = iv_f1_prb   * (-1)
          pv_f2_prb   = pv_f2_prb   * (-1)      iv_f2_prb   = iv_f2_prb   * (-1)
          pv_0t_prb   = pv_0t_prb   * (-1)      iv_0t_prb   = iv_0t_prb   * (-1)
          pv_0s_prb   = pv_0s_prb   * (-1)      iv_0s_prb   = iv_0s_prb   * (-1)
          pv_stat_prb = pv_stat_prb * (-1)      iv_stat_prb = iv_stat_prb * (-1)
          pv_0q_prb   = pv_0q_prb   * (-1)      iv_0q_prb   = iv_0q_prb   * (-1)
          pv_0rq_prb  = pv_0rq_prb  * (-1)      iv_0rq_prb  = iv_0rq_prb  * (-1)
          pv_0f_prb   = pv_0f_prb   * (-1)      iv_0f_prb   = iv_0f_prb   * (-1)
          nv_f1_prb   = nv_f1_prb   * (-1)      nv_f2_prb   = nv_f2_prb   * (-1)
          nv_0t_prb   = nv_0t_prb   * (-1)      nv_0s_prb   = nv_0s_prb   * (-1)
          nv_stat_prb = nv_stat_prb * (-1)      nv_0q_prb   = nv_0q_prb   * (-1)
          nv_0rq_prb  = nv_0rq_prb  * (-1)      nv_0f_prb   = nv_0f_prb   * (-1)
          pv_s8_prb   = pv_s8_prb   * (-1)      iv_s8_prb   = iv_s8_prb   * (-1)

          nv_0ps_prb  = nv_0ps_prb  * (-1)
          pv_0ps_prb  = pv_0ps_prb  * (-1)      iv_0ps_prb   = iv_0ps_prb   * (-1)
          
          nv_btr_prb  = nv_btr_prb  * (-1)
          pv_btr_prb  = pv_btr_prb  * (-1)      iv_btr_prb   = iv_btr_prb   * (-1)
          nv_otr_prb  = nv_otr_prb  * (-1)
          pv_otr_prb  = pv_otr_prb  * (-1)      iv_otr_prb   = iv_otr_prb   * (-1)

          nv_f4_prb   = nv_f4_prb   * (-1)
          pv_f4_prb   = pv_f4_prb   * (-1)      iv_f4_prb    = iv_f4_prb    * (-1)
          nv_ftr_prb  = nv_ftr_prb  * (-1)
          pv_ftr_prb  = pv_ftr_prb  * (-1)      iv_ftr_prb   = iv_ftr_prb   * (-1).
          
       
          FIND FIRST wtotal WHERE wtotal.poltyp = SUBSTR(uwm100.poltyp,2,2) NO-LOCK NO-ERROR.
          IF NOT AVAIL wtotal THEN DO:
              CREATE wtotal.
              ASSIGN 
                  wtotal.poltyp    = SUBSTR(uwm100.poltyp,2,2)
                  wtotal.totprmcom = nv_totprmcom 
                  wtotal.totsumprm = nv_totsumprm 
                  wtotal.totearn   = nv_totearn   
                  wtotal.totuearn  = nv_totuearn  
                  wtotal.totearn1  = nv_totearn1  
                  wtotal.totuearn1 = nv_totuearn1
                  /* comment by Benjaporn J. A58-0242 
                  wtotal.totprmtre = nv_totprmtre 
                  wtotal.totearn2  = nv_totearn2  
                  wtotal.totuearn2 = nv_totuearn2  */
                  /* start A58-0242 Benjaporn J. 13/07/2015 */
                  wtotal.totprmtrt   = nv_totprmtrt 
                  wtotal.totearntrt  = nv_totearntrt  
                  wtotal.totuearntrt = nv_totuearntrt
                  wtotal.totprmfac   = nv_totprmfac
                  wtotal.totearnfac  = nv_totearnfac  
                  wtotal.totuearnfac = nv_totuearnfac. /* end A58-0242 Benjaporn J. 13/07/2015 */ 
          END.

          ASSIGN
              nv_totprmcom    = 0    nv_totsumprm = 0
              nv_totearn      = 0    nv_totuearn  = 0
              nv_totearn1     = 0    nv_totuearn1 = 0
              nv_totprmtrt    = 0 
              nv_totearntrt   = 0 
              nv_totuearntrt  = 0 
              nv_totprmfac    = 0 
              nv_totearnfac   = 0 
              nv_totuearnfac  = 0  .
              /* comment by Benjaporn J. A58-0242 
              nv_totprmtre = 0    nv_totearn2  = 0
              nv_totuearn2 = 0 */
          END.
END.

PUT STREAM ns1
    "Grand Total"   SKIP.

loopmain1:
FOR EACH wtotal BREAK BY wtotal.poltyp.

    FIND xmm031 USE-INDEX xmm03101       WHERE 
         xmm031.poltyp = wtotal.poltyp   NO-LOCK NO-ERROR.
    IF AVAIL xmm031 THEN DO:

       IF xmm031.dept <> "G" AND xmm031.dept <> "M" THEN NEXT loopmain1.
       IF LOOKUP(xmm031.poltyp,nv_poltyp) <> 0  THEN NEXT loopmain1.

    END.
    
    IF wtotal.totprmcom = 0 AND wtotal.totsumprm = 0 AND
       wtotal.totearn   = 0 AND wtotal.totuearn  = 0 AND
       wtotal.totearn1  = 0 AND wtotal.totuearn1 = 0 AND
        /* comment by Benjaporn J. A58-0242
       wtotal.totearn2  = 0 AND wtotal.totuearn2 = 0 THEN DO: */
        /* start A58-0242 Benjaporn J. 13/07/2015 */
       wtotal.totearntrt  = 0 AND wtotal.totuearntrt = 0 AND 
       wtotal.totearnfac  = 0 AND wtotal.totuearnfac = 0 THEN DO: /* end A58-0242 Benjaporn J. 13/07/2015 */

    END.
    ELSE DO:
        PUT STREAM ns1
            "Line  " wtotal.poltyp "|" "|" "|" "|" "|" "|" "|" "|" "|" "|"
            wtotal.totprmcom "|"
            wtotal.totsumprm "|"
            wtotal.totearn   "|"
            wtotal.totuearn  "|"
            wtotal.totearn1  "|"
            wtotal.totuearn1 "|"
       /* comment by Benjaporn J. A58-0242
            wtotal.totprmtre "|"
            wtotal.totearn2  "|"
            wtotal.totuearn2 "|"  */
       /* start A58-0242 Benjaporn J. 13/07/2015 */
            wtotal.totprmtrt   "|"
            wtotal.totearntrt  "|"
            wtotal.totuearntrt "|"
            wtotal.totprmfac   "|"
            wtotal.totearnfac  "|"
            wtotal.totuearnfac SKIP. /* end A58-0242 Benjaporn J. 13/07/2015 */
    END.
END.  /*---A56-0092---*/

PUT STREAM ns3
    "Cancel - Grand Total"  "|" "|" "|" "|" "|" "|" "|" "|" "|" "|"
    nv_ctotprmcom "|" 
    nv_ctotsumprm "|" 
    nv_ctotearn   "|" 
    nv_ctotuearn  "|" 
    nv_ctotearn1  "|" 
    nv_ctotuearn1 "|" 
    /* comment by Benjaporn J. A58-0242
    nv_ctotprmtre "|" 
    nv_ctotearn2  "|" 
    nv_ctotuearn2 "|"  */
     /* start A58-0242 Benjaporn J. 13/07/2015 */
    nv_ctotprmtrt   "|" 
    nv_ctotearntrt  "|" 
    nv_ctotuearntrt "|" 
    nv_ctotprmfac   "|" 
    nv_ctotearnfac  "|" 
    nv_ctotuearnfac SKIP. /* end A58-0242 Benjaporn J. 13/07/2015 */

/*--end A56-0092---*/

OUTPUT STREAM ns1 CLOSE.
OUTPUT STREAM ns2 CLOSE.
OUTPUT STREAM ns3 CLOSE.    /*A56-0092*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pd_Motor01 C-Win 
PROCEDURE Pd_Motor01 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*create by Kridtiya i. date. 29/05/2015 by UWM100.RELEAS = all */
FOR EACH wrk0f.
    DELETE wrk0f.
END.
FOR EACH wtotal.
    DELETE wtotal.
END.
RUN Pd_Checkbranch.
ASSIGN
    n_rec    = 1
    n_rec1   = 1
    n_rec2   = 1    
    nv_count = 0
    n_count  = 0
    n_count1 = 0 
    nv_poltyp = "" .
FOR EACH wfline NO-LOCK.
    ASSIGN nv_poltyp = trim(nv_poltyp +  "," + wfline.nline) .
END.
loopmain:
FOR EACH uwm100 NO-LOCK USE-INDEX uwm10008 WHERE 
    uwm100.trndat  >=  fi_trndat      AND
    uwm100.trndat  <=  fi_trndatto    AND
    uwm100.expdat  >=  fi_asdate      AND 
    uwm100.agent   >=  fi_agentfr     AND
    uwm100.agent   <=  fi_agentto     AND
    uwm100.branch  >=  fi_branchfr    AND
    uwm100.branch  <=  fi_branchto     
    BREAK BY uwm100.poltyp 
          BY uwm100.policy  .
    fi_etime = STRING(TIME,"HH:MM:SS").  
    n_bran   = "".
    n_bran   = uwm100.branch.
    DISP fi_stime fi_etime WITH FRAME fr_main.  
    
    IF SUBSTR(uwm100.policy,1,1) = "I" THEN DO:
        IF nv_brdes1 = ""  THEN NEXT loopmain.
        IF INDEX(nv_brdes1,",9" + SUBSTRING(uwm100.policy,2,1)) <> 0 THEN 
            n_bran = "9" + SUBSTRING(uwm100.policy,2,1). 
   END.
   ELSE  DO:    
         IF INDEX("ABCDEFGHIJKLMNOPQRSTUVWXYZ" , fi_branchto) <> 0  THEN DO: /*พบตัวอักษรในbranch*/
            IF uwm100.branch < fi_branchfr OR uwm100.branch > fi_branchto THEN NEXT loopmain.
         END.
         ELSE DO:
            IF INTEGER(uwm100.branch) < nv_brn_fr OR INTEGER(uwm100.branch) > nv_brn_to THEN NEXT loopmain.
         END.
   END.  
   /*comment by Kridtiya i. A58-0180
   ASSIGN
       nv_poltyp = ""
       nv_poltyp = fi_exc1  + "," + fi_exc2  + "," + fi_exc3  + "," + fi_exc4  + "," + fi_exc5  + "," +
                   fi_exc6  + "," + fi_exc7  + "," + fi_exc8  + "," + fi_exc9  + "," + fi_exc10 + "," +
                   fi_exc11 + "," + fi_exc12 + "," + fi_exc13 + "," + fi_exc14 + "," + fi_exc15 + "," +
                   fi_exc16 + "," + fi_exc17 + "," + fi_exc18 + "," + fi_exc19 + "," + fi_exc20.
   end...comment by Kridtiya i. A58-0180*/

   FIND xmm031 USE-INDEX xmm03101       WHERE 
        xmm031.poltyp = uwm100.poltyp   NO-LOCK NO-ERROR.
   IF AVAIL xmm031 THEN DO:
       IF xmm031.dept <> "G" AND xmm031.dept <> "M" THEN NEXT loopmain.
       IF LOOKUP(xmm031.poltyp,nv_poltyp) <> 0  THEN NEXT loopmain.
   END.
   /*nv_count  = nv_count + 1 .*/

   /*------A63-0159----Change from 65000 to 1000000 --*/
   IF nv_count > 1000000 THEN DO:
       nv_output  = (fi_output  + "_" + STRING(n_rec)) .
       RUN Pd_HeaderMotor.
       n_rec = n_rec + 1.
       nv_count = 0.
   END.
   IF n_count > 1000000 THEN DO:
       nv_output1 = (fi_output +  "_error" + "_" + STRING(n_rec1)) .
       RUN Pd_HeaderMotorerror.
       n_rec1 = n_rec1 + 1.
       n_count = 0.
   END.
   IF n_count1 > 1000000 THEN DO:
       nv_output2 = (fi_output +  "_can" + "_" + STRING(n_rec2)) .
       RUN Pd_HeaderMotorCan.
       n_rec2 = n_rec2 + 1.
       n_count1 = 0.
   END.
   /*-------A63-0159------*/
   IF FIRST-OF(uwm100.poltyp)   THEN do: 
       
       RUN Pd_Cleartreaty.
   END.
   DISPLAY  uwm100.trndat  uwm100.policy  WITH NO-LABEL TITLE "Process Report..."
       FRAME a1 VIEW-AS DIALOG-BOX.
   FIND xmm023 USE-INDEX xmm02301 WHERE
        xmm023.branch = n_bran    NO-LOCK NO-ERROR.
   IF NOT AVAIL xmm023 THEN NEXT loopmain.
   n_branch = n_bran.
   n_bdes   = xmm023.bdes.
   
   IF uwm100.DIR_ri = YES THEN nv_dir = 'D'.
   ELSE nv_dir = 'I'.
   n_endcnt = uwm100.endcnt - 1.
   
   ASSIGN
       nv_prstp  = 0       n_prmcom   = 0
       nv_prtax  = 0       n_stp      = 0
       nv_sumpts = 0       n_tstpcom  = 0
       n_sumprm  = 0       n_taxcom   = 0
       n_sumstp  = 0       n_stptrunc = 0
       n_sumtax  = 0       n_stpcom   = 0
       nu_tax    = 0       n_ttaxcom  = 0
       nu_prm    = 0       n_paprm    = 0
       nu_vat    = 0       n_stppa    = 0
       nv_sum    = 0       n_tstppa   = 0
       n_an      = 0       n_taxpa    = 0
       nvexch    = 1       
       nv_prmtre = 0  .  
   FIND FIRST uwm130 USE-INDEX uwm13001   WHERE
              uwm130.policy = uwm100.policy AND
              uwm130.rencnt = uwm100.rencnt AND
              uwm130.endcnt = uwm100.endcnt  NO-LOCK NO-ERROR.
   
   REPEAT WHILE avail uwm130:
        IF    uwm100.poltyp  = "V70"  THEN
              nv_sum  = nv_sum + uwm130.uom6_v.
        ELSE  nv_sum  = nv_sum + uwm130.uom9_v.
        FIND NEXT uwm130 USE-INDEX uwm13001   WHERE
                  uwm130.policy = uwm100.policy AND
                  uwm130.rencnt = uwm100.rencnt AND
                  uwm130.endcnt = uwm100.endcnt   NO-LOCK NO-ERROR.
   END.
   FIND FIRST uwm200 USE-INDEX uwm20001 WHERE
              uwm200.policy = UWM100.POLICY  AND
              uwm200.rencnt = uwm100.rencnt  AND
              uwm200.endcnt = uwm100.endcnt  AND
              uwm200.csftq  <> "C" NO-LOCK NO-ERROR.
   
   FIND FIRST uwm120 USE-INDEX uwm12001 WHERE
              uwm120.policy = uwm100.policy  AND
              uwm120.rencnt = uwm100.rencnt  AND
              uwm120.endcnt = uwm100.endcnt  NO-LOCK NO-ERROR.
      nvexch = 1.
   IF AVAIL uwm120 THEN DO:
     IF SUBSTRING(uwm120.policy,3,2) = "90" THEN nvexch = 1.
     ELSE nvexch = uwm120.siexch.
   END.
   n_an = nv_sum * nvexch.
   FIND FIRST uwd132 USE-INDEX uwd13290   WHERE
              uwd132.policy = uwm100.policy AND
              uwd132.rencnt = uwm100.rencnt AND
              uwd132.endcnt = uwm100.endcnt 
   NO-LOCK NO-ERROR.
   REPEAT WHILE avail uwd132:
        IF uwd132.bencod = 'COMP' OR uwd132.bencod = 'COMG' OR
           uwd132.bencod = 'COMH'  THEN DO:
           n_prmcom   =  n_prmcom + uwd132.prem_c.
           n_stp      =  (uwd132.prem_c  *  0.4) / 100.
           IF n_stp - TRUNCATE(n_stp,0)  <> 0 then n_stp = TRUNCATE(n_stp,0) + 1.
           n_tstpcom  =  n_tstpcom + n_stp.
           n_taxcom   =  (n_prmcom + n_tstpcom) * uwm100.gstrat / 100.
        END.
        IF uwd132.bencod = "PA" THEN DO:
           n_paprm = n_paprm + uwd132.prem_c.
           n_stppa = (uwd132.prem_c  *  0.4) / 100.
           IF n_stppa - TRUNCATE(n_stppa,0)  <> 0 then n_stppa = TRUNCATE(n_stppa,0) + 1.
           n_tstppa = n_tstppa + n_stppa.
           n_taxpa = (n_paprm + n_tstppa) * uwm100.gstrat / 100.
        END.
        FIND NEXT uwd132 USE-INDEX uwd13290   WHERE
                  uwd132.policy = uwm100.policy AND
                  uwd132.rencnt = uwm100.rencnt AND
                  uwd132.endcnt = uwm100.endcnt 
        NO-LOCK NO-ERROR.
   END.
   ASSIGN
       n_prmt    = 0        n_prms    = 0
       n_prmq    = 0        n_prmtfp  = 0
       n_prmrq   = 0        n_prmf1   = 0
       n_prmf2   = 0        n_prmr    = 0
       n_prmps   = 0        n_prmbtr  = 0
       n_prmotr  = 0        n_prms8   = 0
       n_prmf4   = 0        n_prmftr  = 0.
   LOOPB:
   REPEAT:
      n_cnt1  = n_cnt1 + 1.
      s_recid = RECID(uwm200).
      ASSIGN
          n_prmt    = 0     n_prms    = 0 
          n_prmq    = 0     n_prmtfp  = 0 
          n_prmrq   = 0     n_prmf1   = 0 
          n_prmf2   = 0     n_prmr    = 0 
          n_prmps   = 0     n_prmbtr  = 0
          n_prmotr  = 0     n_prms8   = 0
          n_prmf4   = 0     n_prmftr  = 0 .

      IF UWM100.TRANTY <> "C" THEN DO:
         RUN Pd_Process1.
      END.
      ELSE DO:
         RUN Pd_Process2.
      END.
      FIND NEXT uwm200  USE-INDEX  uwm20001  WHERE
                uwm200.policy = uwm100.policy  AND
                uwm200.rencnt = uwm100.rencnt  AND
                uwm200.endcnt = uwm100.endcnt  NO-LOCK NO-ERROR.

      IF NOT AVAIL uwm200 THEN LEAVE loopb.
   END.   /* loopb */
   
   ASSIGN
        n_prmf1      =   n_prmf1     * (-1)
        n_prmf2      =   n_prmf2     * (-1)
        n_prmt       =   n_prmt      * (-1)
        n_prms       =   n_prms      * (-1)
        n_prmq       =   n_prmq      * (-1)
        n_prmtfp     =   n_prmtfp    * (-1)
        n_prmrq      =   n_prmrq     * (-1)
        n_prmps      =   n_prmps     * (-1)  
        n_prmbtr     =   n_prmbtr    * (-1)  
        n_prmotr     =   n_prmotr    * (-1)  
        n_prms8      =   n_prms8     * (-1)  
        n_prmf4      =   n_prmf4     * (-1)  
        n_prmftr     =   n_prmftr    * (-1).

   RUN Pd_detailMotor.

   ASSIGN
        nv_sum    = 0 
        p_t       = 000  n_sumt     = 0   n_prmt    = 0
        p_s       = 000  n_sums     = 0   n_prms    = 0
        p_q       = 000  n_sumq     = 0   n_prmq    = 0
        p_tfp     = 000  n_sumtfp   = 0   n_prmtfp  = 0
        p_rq      = 000  n_sumrq    = 0   n_prmrq   = 0
        p_f1      = 000  n_sumf1    = 0   n_prmf1   = 0
        p_f2      = 000  n_sumf2    = 0   n_prmf2   = 0
        p_r       = 000  n_sumr     = 0   n_prmr    = 0
        p_ps      = 000  n_sumps    = 0   n_prmps   = 0  
        p_btr     = 000  n_sumbtr   = 0   n_prmbtr  = 0  
        p_otr     = 000  n_sumotr   = 0   n_prmotr  = 0  
        p_s8      = 000  n_sums8    = 0   n_prms8   = 0  
        p_f4      = 000  n_sumf4    = 0   n_prmf4   = 0
        p_ftr     = 000  n_sumftr   = 0   n_prmftr  = 0
        n_rb_pf   = 000  n_rb_sum   = 0   n_rb_prm  = 0
        n_rf_pf   = 000  n_rf_sum   = 0   n_rf_prm  = 0
        nv_prmtre = 0.

   IF LAST-OF(uwm100.poltyp) THEN DO:

       ASSIGN
          pv_f1_prb   = pv_f1_prb   * (-1)      iv_f1_prb   = iv_f1_prb   * (-1)
          pv_f2_prb   = pv_f2_prb   * (-1)      iv_f2_prb   = iv_f2_prb   * (-1)
          pv_0t_prb   = pv_0t_prb   * (-1)      iv_0t_prb   = iv_0t_prb   * (-1)
          pv_0s_prb   = pv_0s_prb   * (-1)      iv_0s_prb   = iv_0s_prb   * (-1)
          pv_stat_prb = pv_stat_prb * (-1)      iv_stat_prb = iv_stat_prb * (-1)
          pv_0q_prb   = pv_0q_prb   * (-1)      iv_0q_prb   = iv_0q_prb   * (-1)
          pv_0rq_prb  = pv_0rq_prb  * (-1)      iv_0rq_prb  = iv_0rq_prb  * (-1)
          pv_0f_prb   = pv_0f_prb   * (-1)      iv_0f_prb   = iv_0f_prb   * (-1)
          nv_f1_prb   = nv_f1_prb   * (-1)      nv_f2_prb   = nv_f2_prb   * (-1)
          nv_0t_prb   = nv_0t_prb   * (-1)      nv_0s_prb   = nv_0s_prb   * (-1)
          nv_stat_prb = nv_stat_prb * (-1)      nv_0q_prb   = nv_0q_prb   * (-1)
          nv_0rq_prb  = nv_0rq_prb  * (-1)      nv_0f_prb   = nv_0f_prb   * (-1)
          pv_s8_prb   = pv_s8_prb   * (-1)      iv_s8_prb   = iv_s8_prb   * (-1)
          nv_0ps_prb  = nv_0ps_prb  * (-1)
          pv_0ps_prb  = pv_0ps_prb  * (-1)      iv_0ps_prb   = iv_0ps_prb   * (-1)
          nv_btr_prb  = nv_btr_prb  * (-1)
          pv_btr_prb  = pv_btr_prb  * (-1)      iv_btr_prb   = iv_btr_prb   * (-1)
          nv_otr_prb  = nv_otr_prb  * (-1)
          pv_otr_prb  = pv_otr_prb  * (-1)      iv_otr_prb   = iv_otr_prb   * (-1)
          nv_f4_prb   = nv_f4_prb   * (-1)
          pv_f4_prb   = pv_f4_prb   * (-1)      iv_f4_prb    = iv_f4_prb    * (-1)
          nv_ftr_prb  = nv_ftr_prb  * (-1)
          pv_ftr_prb  = pv_ftr_prb  * (-1)      iv_ftr_prb   = iv_ftr_prb   * (-1).
          
       FIND FIRST wtotal WHERE wtotal.poltyp = SUBSTR(uwm100.poltyp,2,2) NO-LOCK NO-ERROR.
          IF NOT AVAIL wtotal THEN DO:
              CREATE wtotal.
              ASSIGN 
                  wtotal.poltyp    = SUBSTR(uwm100.poltyp,2,2)
                  wtotal.totprmcom = nv_totprmcom 
                  wtotal.totsumprm = nv_totsumprm 
                  wtotal.totearn   = nv_totearn   
                  wtotal.totuearn  = nv_totuearn  
                  wtotal.totearn1  = nv_totearn1  
                  wtotal.totuearn1 = nv_totuearn1 
                  /*comment by Benjaporn J. A58-0242 
                  wtotal.totprmtre = nv_totprmtre 
                  wtotal.totearn2  = nv_totearn2  
                  wtotal.totuearn2 = nv_totuearn2  */
                   /* start A58-0242 Benjaporn J. 13/07/2015 */
                  wtotal.totprmtrt   = nv_totprmtrt 
                  wtotal.totearntrt  = nv_totearntrt  
                  wtotal.totuearntrt = nv_totuearntrt
                  wtotal.totprmfac   = nv_totprmfac
                  wtotal.totearnfac  = nv_totearnfac  
                  wtotal.totuearnfac = nv_totuearnfac.  /* end A58-0242 Benjaporn J. 13/07/2015 */
          END.
          ASSIGN
              nv_totprmcom    = 0    nv_totsumprm = 0
              nv_totearn      = 0    nv_totuearn  = 0
              nv_totearn1     = 0    nv_totuearn1 = 0
              nv_totprmtrt    = 0 
              nv_totearntrt   = 0 
              nv_totuearntrt  = 0 
              nv_totprmfac    = 0 
              nv_totearnfac   = 0 
              nv_totuearnfac  = 0  .
          /* comment by Benjaporn J. A58-0242 
              nv_totprmtre = 0    nv_totearn2  = 0
              nv_totuearn2 = 0  */
            END.
END.
PUT STREAM ns1
    "Grand Total"   SKIP.
loopmain1:
FOR EACH wtotal BREAK BY wtotal.poltyp.
    FIND xmm031 USE-INDEX xmm03101       WHERE 
         xmm031.poltyp = wtotal.poltyp   NO-LOCK NO-ERROR.
    IF AVAIL xmm031 THEN DO:
       IF xmm031.dept <> "G" AND xmm031.dept <> "M" THEN NEXT loopmain1.
       IF LOOKUP(xmm031.poltyp,nv_poltyp) <> 0  THEN NEXT loopmain1.
    END.
    IF wtotal.totprmcom = 0 AND wtotal.totsumprm = 0 AND
       wtotal.totearn   = 0 AND wtotal.totuearn  = 0 AND
       wtotal.totearn1  = 0 AND wtotal.totuearn1 = 0 AND
         /* comment by Benjaporn J. A58-0242
       wtotal.totearn2  = 0 AND wtotal.totuearn2 = 0 THEN DO:  */
        /* start A58-0242 Benjaporn J. 13/07/2015 */
       wtotal.totearntrt  = 0 AND wtotal.totuearntrt = 0 AND
       wtotal.totearnfac  = 0 AND wtotal.totuearnfac = 0 THEN DO: /* end A58-0242 Benjaporn J. 13/07/2015 */
    END.
    ELSE DO:
        PUT STREAM ns1
            "Line  " wtotal.poltyp "|" "|" "|" "|" "|" "|" "|" "|" "|" "|"
            wtotal.totprmcom "|"
            wtotal.totsumprm "|"
            wtotal.totearn   "|"
            wtotal.totuearn  "|"
            wtotal.totearn1  "|"
            wtotal.totuearn1 "|"
             /* comment by Benjaporn J. A58-0242
            wtotal.totprmtre "|"
            wtotal.totearn2  "|"
            wtotal.totuearn2 "|"  */
            /* start A58-0242 Benjaporn J. 13/07/2015 */
            wtotal.totprmtrt   "|"
            wtotal.totearntrt  "|"
            wtotal.totuearntrt "|"
            wtotal.totprmfac   "|"
            wtotal.totearnfac  "|"
            wtotal.totuearnfac SKIP. /* end A58-0242 Benjaporn J. 13/07/2015 */
         END.
END.
PUT STREAM ns3
    "Cancel - Grand Total"  "|" "|" "|" "|" "|" "|" "|" "|" "|" "|"
    nv_ctotprmcom "|" 
    nv_ctotsumprm "|" 
    nv_ctotearn   "|" 
    nv_ctotuearn  "|" 
    nv_ctotearn1  "|" 
    nv_ctotuearn1 "|" 
     /* comment by Benjaporn J. A58-0242
    nv_ctotprmtre "|" 
    nv_ctotearn2  "|" 
    nv_ctotuearn2 "|"  */
    /* start A58-0242 Benjaporn J. 13/07/2015 */
    nv_ctotprmtrt   "|" 
    nv_ctotearntrt  "|" 
    nv_ctotuearntrt "|" 
    nv_ctotprmfac   "|" 
    nv_ctotearnfac  "|" 
    nv_ctotuearnfac SKIP. /* end A58-0242 Benjaporn J. 13/07/2015 */

OUTPUT STREAM ns1 CLOSE.
OUTPUT STREAM ns2 CLOSE.
OUTPUT STREAM ns3 CLOSE.   
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pd_motorNZI C-Win 
PROCEDURE Pd_motorNZI :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH wrk0f.
    DELETE wrk0f.
END.
FOR EACH wtotal.
    DELETE wtotal.
END.

ASSIGN
    n_rec    = 1
    n_rec1   = 1
    n_rec2   = 1   /*A56-0092*/
    nv_count = 0
    n_count  = 0
    n_count1 = 0    /*A56-0092*/
    nv_poltyp = "" .
FOR EACH wfline NO-LOCK.
    ASSIGN nv_poltyp = trim(nv_poltyp +  "," + wfline.nline) .
END.

/* comment by kridtiya i. A58-0180.....
loopmain:
FOR EACH uwm100 NO-LOCK USE-INDEX uwm10092 WHERE 
         uwm100.expdat  >=  fi_asdate               AND 
         uwm100.agent   >=  fi_agentfr              AND
         uwm100.agent   <=  fi_agentto              AND
         uwm100.trndat  <=  fi_asdate               AND
         uwm100.branch  >=  fi_branchfr             AND
         uwm100.branch  <=  fi_branchto             AND
      (( fi_releas = "Y"  AND UWM100.RELEAS = YES ) OR
       ( fi_releas = "N"  AND UWM100.RELEAS = NO  ) OR
       ( fi_releas = "A"))  BREAK BY uwm100.poltyp 
                                  /*BY uwm100.branch */
                                  BY uwm100.policy
                                  /*BY uwm100.endno
                                  BY uwm100.trndat
                                  BY uwm100.tranty*/ .
  end.comment by kridtiya i. A58-0180 ...*/
/*Add kridtiya i. A58-0180 */
loopmain:
FOR EACH  uwm100 NO-LOCK USE-INDEX uwm10008 WHERE 
    uwm100.trndat  >=  fi_trndat      AND
    uwm100.trndat  <=  fi_trndatto    AND
    uwm100.expdat  >=  fi_asdate      AND 
    uwm100.agent   >=  fi_agentfr     AND
    uwm100.agent   <=  fi_agentto     AND
    uwm100.branch  >=  fi_branchfr    AND
    uwm100.branch  <=  fi_branchto    AND
    UWM100.RELEAS   =  nv_releas 
    BREAK BY uwm100.poltyp 
          BY uwm100.policy  .
/*Add kridtiya i. A58-0180 */

   fi_etime = STRING(TIME,"HH:MM:SS"). /*Lukkana M. A55-0144 25/04/2012*/
   n_bran   = "".
   n_bran   = uwm100.branch.
   DISP fi_stime fi_etime WITH FRAME fr_main. /*Lukkana M. A55-0144 25/04/2012*/
   /*A58-0180
   ASSIGN
       nv_poltyp = ""
       nv_poltyp = fi_exc1  + "," + fi_exc2  + "," + fi_exc3  + "," + fi_exc4  + "," + fi_exc5  + "," +
                   fi_exc6  + "," + fi_exc7  + "," + fi_exc8  + "," + fi_exc9  + "," + fi_exc10 + "," +
                   fi_exc11 + "," + fi_exc12 + "," + fi_exc13 + "," + fi_exc14 + "," + fi_exc15 + "," +
                   fi_exc16 + "," + fi_exc17 + "," + fi_exc18 + "," + fi_exc19 + "," + fi_exc20.
                   A58-0180 .........*/

   FIND xmm031 USE-INDEX xmm03101       WHERE 
        xmm031.poltyp = uwm100.poltyp   NO-LOCK NO-ERROR.
   IF AVAIL xmm031 THEN DO:
       IF xmm031.dept <> "G" AND xmm031.dept <> "M" THEN NEXT loopmain.
       IF LOOKUP(xmm031.poltyp,nv_poltyp) <> 0  THEN NEXT loopmain.
   END.
   
   /*nv_count  = nv_count + 1 .*/

   /*------A63-0159----Change from 65000 to 1000000 --*/
   IF nv_count > 1000000 THEN DO:
       nv_output  = (fi_output  + "_" + STRING(n_rec)) .
       RUN Pd_HeaderMotor.
       n_rec = n_rec + 1.
       nv_count = 0.
   END.

   IF n_count > 1000000 THEN DO:
       nv_output1 = (fi_output +  "_error" + "_" + STRING(n_rec1)) .
       RUN Pd_HeaderMotorerror.
       n_rec1 = n_rec1 + 1.
       n_count = 0.
   END.

   IF n_count1 > 1000000 THEN DO:
       nv_output2 = (fi_output +  "_can" + "_" + STRING(n_rec2)) .
       RUN Pd_HeaderMotorCan.
       n_rec2 = n_rec2 + 1.
       n_count1 = 0.
   END.
   /*-------A63-0159------*/
   
   IF FIRST-OF(uwm100.poltyp)   THEN do: 
       RUN Pd_Cleartreaty.
   END.         

   DISPLAY  uwm100.trndat  uwm100.policy  WITH NO-LABEL TITLE "Process Report..."
       FRAME a1 VIEW-AS DIALOG-BOX.

   FIND xmm023 USE-INDEX xmm02301 WHERE
        xmm023.branch = n_bran    NO-LOCK NO-ERROR.
   IF NOT AVAIL xmm023 THEN NEXT loopmain.
   n_branch = n_bran.
   n_bdes   = xmm023.bdes.

   IF uwm100.DIR_ri = YES THEN nv_dir = 'D'.
   ELSE nv_dir = 'I'.

   n_endcnt = uwm100.endcnt - 1.

   ASSIGN
       nv_prstp  = 0       n_prmcom   = 0
       nv_prtax  = 0       n_stp      = 0
       nv_sumpts = 0       n_tstpcom  = 0
       n_sumprm  = 0       n_taxcom   = 0
       n_sumstp  = 0       n_stptrunc = 0
       n_sumtax  = 0       n_stpcom   = 0
       nu_tax    = 0       n_ttaxcom  = 0
       nu_prm    = 0       n_paprm    = 0
       nu_vat    = 0       n_stppa    = 0
       nv_sum    = 0       n_tstppa   = 0
       n_an      = 0       n_taxpa    = 0
       nvexch    = 1       nv_prmtre  = 0 .

    FIND FIRST uwm130 USE-INDEX uwm13001   WHERE
              uwm130.policy = uwm100.policy AND
              uwm130.rencnt = uwm100.rencnt AND
              uwm130.endcnt = uwm100.endcnt 
   NO-LOCK NO-ERROR.
   REPEAT WHILE avail uwm130:
        IF    uwm100.poltyp  = "V70"  THEN
              nv_sum  = nv_sum + uwm130.uom6_v.
        ELSE  nv_sum  = nv_sum + uwm130.uom9_v.
        
        FIND NEXT uwm130 USE-INDEX uwm13001   WHERE
                  uwm130.policy = uwm100.policy AND
                  uwm130.rencnt = uwm100.rencnt AND
                  uwm130.endcnt = uwm100.endcnt 
        NO-LOCK NO-ERROR.
   END.
   
   FIND FIRST uwm200 USE-INDEX uwm20001 WHERE
              uwm200.policy = UWM100.POLICY  AND
              uwm200.rencnt = uwm100.rencnt  AND
              uwm200.endcnt = uwm100.endcnt  AND
              uwm200.csftq  <> "C"
   NO-LOCK NO-ERROR.
   
   FIND FIRST uwm120 USE-INDEX uwm12001 WHERE
              uwm120.policy = uwm100.policy  AND
              uwm120.rencnt = uwm100.rencnt  AND
              uwm120.endcnt = uwm100.endcnt
   NO-LOCK NO-ERROR.
      nvexch = 1.

   IF AVAIL uwm120 THEN DO:
     IF SUBSTRING(uwm120.policy,3,2) = "90" THEN nvexch = 1.
     ELSE nvexch = uwm120.siexch.
   END.
   
   
   n_an = nv_sum * nvexch.
   FIND FIRST uwd132 USE-INDEX uwd13290   WHERE
              uwd132.policy = uwm100.policy AND
              uwd132.rencnt = uwm100.rencnt AND
              uwd132.endcnt = uwm100.endcnt 
   NO-LOCK NO-ERROR.
   REPEAT WHILE avail uwd132:
        IF uwd132.bencod = 'COMP' OR uwd132.bencod = 'COMG' OR
           uwd132.bencod = 'COMH'  THEN DO:
           n_prmcom   =  n_prmcom + uwd132.prem_c.
 
           n_stp      =  (uwd132.prem_c  *  0.4) / 100.
   
           IF n_stp - TRUNCATE(n_stp,0)  <> 0 then n_stp = TRUNCATE(n_stp,0) + 1.
           n_tstpcom  =  n_tstpcom + n_stp.
           n_taxcom   =  (n_prmcom + n_tstpcom) * uwm100.gstrat / 100.
        END.
        IF uwd132.bencod = "PA" THEN DO:
           n_paprm = n_paprm + uwd132.prem_c.
           n_stppa = (uwd132.prem_c  *  0.4) / 100.
   
           IF n_stppa - TRUNCATE(n_stppa,0)  <> 0 then n_stppa = TRUNCATE(n_stppa,0) + 1.
           n_tstppa = n_tstppa + n_stppa.
           n_taxpa = (n_paprm + n_tstppa) * uwm100.gstrat / 100.
        END.
        
        FIND NEXT uwd132 USE-INDEX uwd13290   WHERE
                  uwd132.policy = uwm100.policy AND
                  uwd132.rencnt = uwm100.rencnt AND
                  uwd132.endcnt = uwm100.endcnt 
        NO-LOCK NO-ERROR.
   END.
   
   ASSIGN
       n_prmt    = 0
       n_prms    = 0
       n_prmq    = 0
       n_prmtfp  = 0
       n_prmrq   = 0
       n_prmf1   = 0
       n_prmf2   = 0
       n_prmr    = 0
       n_prmps   = 0
       n_prmbtr  = 0
       n_prmotr  = 0
       n_prms8   = 0
       n_prmf4   = 0
       n_prmftr  = 0.

   LOOPB:
   REPEAT:
      n_cnt1  = n_cnt1 + 1.
      s_recid = RECID(uwm200).
      ASSIGN
          n_prmt    = 0 
          n_prms    = 0 
          n_prmq    = 0 
          n_prmtfp  = 0 
          n_prmrq   = 0 
          n_prmf1   = 0 
          n_prmf2   = 0 
          n_prmr    = 0 
          n_prmps   = 0 
          n_prmbtr  = 0 
          n_prmotr  = 0 
          n_prms8   = 0
          n_prmf4   = 0 
          n_prmftr  = 0 .

      IF UWM100.TRANTY <> "C" THEN DO:
         RUN Pd_Process1.
      END.
      ELSE DO:
         RUN Pd_Process2.
      END.

      FIND NEXT uwm200  USE-INDEX  uwm20001  WHERE
                uwm200.policy = uwm100.policy  AND
                uwm200.rencnt = uwm100.rencnt  AND
                uwm200.endcnt = uwm100.endcnt
                NO-LOCK NO-ERROR.
      IF NOT AVAIL uwm200 THEN LEAVE loopb.
   END.   /* loopb */
   ASSIGN
        n_prmf1      =   n_prmf1     * (-1)
        n_prmf2      =   n_prmf2     * (-1)
        n_prmt       =   n_prmt      * (-1)
        n_prms       =   n_prms      * (-1)
        n_prmq       =   n_prmq      * (-1)
        n_prmtfp     =   n_prmtfp    * (-1)
        n_prmrq      =   n_prmrq     * (-1)
        n_prmps      =   n_prmps     * (-1)  
        n_prmbtr     =   n_prmbtr    * (-1)  
        n_prmotr     =   n_prmotr    * (-1)  
        n_prms8      =   n_prms8     * (-1)  

        n_prmf4      =   n_prmf4     * (-1)  
        n_prmftr     =   n_prmftr    * (-1).
   
   RUN Pd_detailMotor.
   
   ASSIGN
        nv_sum    = 0 
        p_t       = 000  n_sumt     = 0   n_prmt    = 0
        p_s       = 000  n_sums     = 0   n_prms    = 0
        p_q       = 000  n_sumq     = 0   n_prmq    = 0
        p_tfp     = 000  n_sumtfp   = 0   n_prmtfp  = 0
        p_rq      = 000  n_sumrq    = 0   n_prmrq   = 0
        p_f1      = 000  n_sumf1    = 0   n_prmf1   = 0
        p_f2      = 000  n_sumf2    = 0   n_prmf2   = 0
        p_r       = 000  n_sumr     = 0   n_prmr    = 0
        p_ps      = 000  n_sumps    = 0   n_prmps   = 0  
        p_btr     = 000  n_sumbtr   = 0   n_prmbtr  = 0  
        p_otr     = 000  n_sumotr   = 0   n_prmotr  = 0  
        p_s8      = 000  n_sums8    = 0   n_prms8   = 0  
                                    
        p_f4      = 000  n_sumf4    = 0   n_prmf4   = 0
        p_ftr     = 000  n_sumftr   = 0   n_prmftr  = 0
        n_rb_pf   = 000  n_rb_sum   = 0   n_rb_prm  = 0
        n_rf_pf   = 000  n_rf_sum   = 0   n_rf_prm  = 0
        nv_prmtre = 0.

   IF LAST-OF(uwm100.poltyp) THEN DO:
        
       ASSIGN
          pv_f1_prb   = pv_f1_prb   * (-1)      iv_f1_prb   = iv_f1_prb   * (-1)
          pv_f2_prb   = pv_f2_prb   * (-1)      iv_f2_prb   = iv_f2_prb   * (-1)
          pv_0t_prb   = pv_0t_prb   * (-1)      iv_0t_prb   = iv_0t_prb   * (-1)
          pv_0s_prb   = pv_0s_prb   * (-1)      iv_0s_prb   = iv_0s_prb   * (-1)
          pv_stat_prb = pv_stat_prb * (-1)      iv_stat_prb = iv_stat_prb * (-1)
          pv_0q_prb   = pv_0q_prb   * (-1)      iv_0q_prb   = iv_0q_prb   * (-1)
          pv_0rq_prb  = pv_0rq_prb  * (-1)      iv_0rq_prb  = iv_0rq_prb  * (-1)
          pv_0f_prb   = pv_0f_prb   * (-1)      iv_0f_prb   = iv_0f_prb   * (-1)
          nv_f1_prb   = nv_f1_prb   * (-1)      nv_f2_prb   = nv_f2_prb   * (-1)
          nv_0t_prb   = nv_0t_prb   * (-1)      nv_0s_prb   = nv_0s_prb   * (-1)
          nv_stat_prb = nv_stat_prb * (-1)      nv_0q_prb   = nv_0q_prb   * (-1)
          nv_0rq_prb  = nv_0rq_prb  * (-1)      nv_0f_prb   = nv_0f_prb   * (-1)
          pv_s8_prb   = pv_s8_prb   * (-1)      iv_s8_prb   = iv_s8_prb   * (-1)

          
          nv_0ps_prb  = nv_0ps_prb  * (-1)
          pv_0ps_prb  = pv_0ps_prb  * (-1)      iv_0ps_prb   = iv_0ps_prb   * (-1)
          
          nv_btr_prb  = nv_btr_prb  * (-1)
          pv_btr_prb  = pv_btr_prb  * (-1)      iv_btr_prb   = iv_btr_prb   * (-1)
          nv_otr_prb  = nv_otr_prb  * (-1)
          pv_otr_prb  = pv_otr_prb  * (-1)      iv_otr_prb   = iv_otr_prb   * (-1)

          
          nv_f4_prb   = nv_f4_prb   * (-1)
          pv_f4_prb   = pv_f4_prb   * (-1)      iv_f4_prb    = iv_f4_prb    * (-1)
          nv_ftr_prb  = nv_ftr_prb  * (-1)
          pv_ftr_prb  = pv_ftr_prb  * (-1)      iv_ftr_prb   = iv_ftr_prb   * (-1).
          
       FIND FIRST wtotal WHERE wtotal.poltyp = SUBSTR(uwm100.poltyp,2,2) NO-LOCK NO-ERROR.
          IF NOT AVAIL wtotal THEN DO:
              CREATE wtotal.
              ASSIGN 
                  wtotal.poltyp    = SUBSTR(uwm100.poltyp,2,2)
                  wtotal.totprmcom = nv_totprmcom 
                  wtotal.totsumprm = nv_totsumprm 
                  wtotal.totearn   = nv_totearn   
                  wtotal.totuearn  = nv_totuearn  
                  wtotal.totearn1  = nv_totearn1  
                  wtotal.totuearn1 = nv_totuearn1 
                  /* comment by Benjaporn J. A58-0242
                  wtotal.totprmtre = nv_totprmtre 
                  wtotal.totearn2  = nv_totearn2  
                  wtotal.totuearn2 = nv_totuearn2 */
                  /* start A58-0242 Benjaporn J. 13/07/2015 */
                  wtotal.totprmtrt   = nv_totprmtrt 
                  wtotal.totearntrt  = nv_totearntrt  
                  wtotal.totuearntrt = nv_totuearntrt
                  wtotal.totprmfac   = nv_totprmfac
                  wtotal.totearnfac  = nv_totearnfac  
                  wtotal.totuearnfac = nv_totuearnfac. /* end A58-0242 Benjaporn J. 13/07/2015 */
          END.

          ASSIGN
              nv_totprmcom      = 0    nv_totsumprm = 0
              nv_totearn        = 0    nv_totuearn  = 0
              nv_totearn1       = 0    nv_totuearn1 = 0
              nv_totprmtrt      = 0 
              nv_totearntrt     = 0 
              nv_totuearntrt    = 0 
              nv_totprmfac      = 0 
              nv_totearnfac     = 0 
              nv_totuearnfac    = 0  .
          /* comment by Benjaporn J. A58-0242
              nv_totprmtre = 0    nv_totearn2  = 0
              nv_totuearn2 = 0 */
   END.
END.

PUT STREAM ns1
    "Grand Total"   SKIP.

loopmain1:
FOR EACH wtotal BREAK BY wtotal.poltyp.

    FIND xmm031 USE-INDEX xmm03101       WHERE 
         xmm031.poltyp = wtotal.poltyp   NO-LOCK NO-ERROR.
    IF AVAIL xmm031 THEN DO:

       IF xmm031.dept <> "G" AND xmm031.dept <> "M" THEN NEXT loopmain1.
       IF LOOKUP(xmm031.poltyp,nv_poltyp) <> 0  THEN NEXT loopmain1.
       
  END.       
    
    IF wtotal.totprmcom = 0 AND wtotal.totsumprm = 0 AND
       wtotal.totearn   = 0 AND wtotal.totuearn  = 0 AND
       wtotal.totearn1  = 0 AND wtotal.totuearn1 = 0 AND
        /* comment by Benjaporn J. A58-0242
       wtotal.totearn2  = 0 AND wtotal.totuearn2 = 0 THEN DO: */
        /* start A58-0242 Benjaporn J. 13/07/2015 */
       wtotal.totearntrt  = 0 AND wtotal.totuearntrt = 0 AND
       wtotal.totearnfac  = 0 AND wtotal.totuearnfac = 0 THEN DO: /* end A58-0242 Benjaporn J. 13/07/2015 */

    END.
    ELSE DO:
        PUT STREAM ns1
            "Line  " wtotal.poltyp "|" "|" "|" "|" "|" "|" "|" "|" "|" "|"
            wtotal.totprmcom "|"
            wtotal.totsumprm "|"
            wtotal.totearn   "|"
            wtotal.totuearn  "|"
            wtotal.totearn1  "|"
            wtotal.totuearn1 "|"
            /* comment by Benjaporn J. A58-0242
            wtotal.totprmtre "|"
            wtotal.totearn2  "|"
            wtotal.totuearn2 "|" */
            /* start A58-0242 Benjaporn J. 13/07/2015 */
            wtotal.totprmtrt   "|"
            wtotal.totearntrt  "|"
            wtotal.totuearntrt "|"
            wtotal.totprmfac   "|"
            wtotal.totearnfac  "|"
            wtotal.totuearnfac SKIP. /* end A58-0242 Benjaporn J. 13/07/2015 */
    END.
END.

/*---A56-0092---*/
PUT STREAM ns3
    "Cancel - Grand Total"  "|" "|" "|" "|" "|" "|" "|" "|" "|" "|"
    nv_ctotprmcom "|" 
    nv_ctotsumprm "|" 
    nv_ctotearn   "|" 
    nv_ctotuearn  "|" 
    nv_ctotearn1  "|" 
    nv_ctotuearn1 "|" 
    /* comment by Benjaporn J. A58-0242
    nv_ctotprmtre "|" 
    nv_ctotearn2  "|" 
    nv_ctotuearn2 "|"  */
    /* start A58-0242 Benjaporn J. 13/07/2015 */
    nv_ctotprmtrt   "|" 
    nv_ctotearntrt  "|" 
    nv_ctotuearntrt "|" 
    nv_ctotprmfac   "|" 
    nv_ctotearnfac  "|" 
    nv_ctotuearnfac SKIP. /*--end A56-0092---*/   /* end A58-0242 Benjaporn J. 13/07/2015 */

OUTPUT STREAM ns1 CLOSE.
OUTPUT STREAM ns2 CLOSE.
OUTPUT STREAM ns3 CLOSE.    /*A56-0092*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pd_MotorNZI01 C-Win 
PROCEDURE Pd_MotorNZI01 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH wrk0f.
    DELETE wrk0f.
END.
FOR EACH wtotal.
    DELETE wtotal.
END.
ASSIGN
    n_rec    = 1
    n_rec1   = 1
    n_rec2   = 1   
    nv_count = 0
    n_count  = 0
    n_count1 = 0
    nv_poltyp = "" .
FOR EACH wfline NO-LOCK.
    ASSIGN nv_poltyp = trim(nv_poltyp +  "," + wfline.nline) .
END.

loopmain:
FOR EACH  uwm100 NO-LOCK USE-INDEX uwm10008 WHERE 
    uwm100.trndat  >=  fi_trndat      AND
    uwm100.trndat  <=  fi_trndatto    AND
    uwm100.expdat  >=  fi_asdate      AND 
    uwm100.agent   >=  fi_agentfr     AND
    uwm100.agent   <=  fi_agentto     AND
    uwm100.branch  >=  fi_branchfr    AND
    uwm100.branch  <=  fi_branchto   
    BREAK BY uwm100.poltyp 
          BY uwm100.policy  .
   ASSIGN fi_etime = STRING(TIME,"HH:MM:SS") 
   n_bran   = ""
   n_bran   = uwm100.branch.
   DISP fi_stime fi_etime WITH FRAME fr_main.  
   /*A58-0180.....
   ASSIGN
       nv_poltyp = ""
       nv_poltyp = fi_exc1  + "," + fi_exc2  + "," + fi_exc3  + "," + fi_exc4  + "," + fi_exc5  + "," +
                   fi_exc6  + "," + fi_exc7  + "," + fi_exc8  + "," + fi_exc9  + "," + fi_exc10 + "," +
                   fi_exc11 + "," + fi_exc12 + "," + fi_exc13 + "," + fi_exc14 + "," + fi_exc15 + "," +
                   fi_exc16 + "," + fi_exc17 + "," + fi_exc18 + "," + fi_exc19 + "," + fi_exc20.
   A58-0180*/
   FIND xmm031 USE-INDEX xmm03101       WHERE 
        xmm031.poltyp = uwm100.poltyp   NO-LOCK NO-ERROR.
   IF AVAIL xmm031 THEN DO:
       IF xmm031.dept <> "G" AND xmm031.dept <> "M" THEN NEXT loopmain.
       IF LOOKUP(xmm031.poltyp,nv_poltyp) <> 0  THEN NEXT loopmain.
   END.
   /*nv_count  = nv_count + 1 .*/

   /*------A63-0159----Change from 65000 to 1000000 --*/
   IF nv_count > 1000000 THEN DO:
       nv_output  = (fi_output  + "_" + STRING(n_rec)) .
       RUN Pd_HeaderMotor.
       n_rec = n_rec + 1.
       nv_count = 0.
   END.
   IF n_count > 100000 THEN DO:
       nv_output1 = (fi_output +  "_error" + "_" + STRING(n_rec1)) .
       RUN Pd_HeaderMotorerror.
       n_rec1 = n_rec1 + 1.
       n_count = 0.
   END.
   IF n_count1 > 1000000 THEN DO:
       nv_output2 = (fi_output +  "_can" + "_" + STRING(n_rec2)) .
       RUN Pd_HeaderMotorCan.
       n_rec2 = n_rec2 + 1.
       n_count1 = 0.
   END.
   /*-------A63-0159------*/
   IF FIRST-OF(uwm100.poltyp)   THEN do: 
       RUN Pd_Cleartreaty.
   END.
   DISPLAY  uwm100.trndat  uwm100.policy  WITH NO-LABEL TITLE "Process Report..."
       FRAME a1 VIEW-AS DIALOG-BOX.
   FIND xmm023 USE-INDEX xmm02301 WHERE
        xmm023.branch = n_bran    NO-LOCK NO-ERROR.
   IF NOT AVAIL xmm023 THEN NEXT loopmain.
   n_branch = n_bran.
   n_bdes   = xmm023.bdes.
   IF uwm100.DIR_ri = YES THEN nv_dir = 'D'.
   ELSE nv_dir = 'I'.
   n_endcnt = uwm100.endcnt - 1.

   ASSIGN
       nv_prstp  = 0       n_prmcom   = 0
       nv_prtax  = 0       n_stp      = 0
       nv_sumpts = 0       n_tstpcom  = 0
       n_sumprm  = 0       n_taxcom   = 0
       n_sumstp  = 0       n_stptrunc = 0
       n_sumtax  = 0       n_stpcom   = 0
       nu_tax    = 0       n_ttaxcom  = 0
       nu_prm    = 0       n_paprm    = 0
       nu_vat    = 0       n_stppa    = 0
       nv_sum    = 0       n_tstppa   = 0
       n_an      = 0       n_taxpa    = 0
       nvexch    = 1       nv_prmtre  = 0 .  

   FIND FIRST uwm130 USE-INDEX uwm13001   WHERE
              uwm130.policy = uwm100.policy AND
              uwm130.rencnt = uwm100.rencnt AND
              uwm130.endcnt = uwm100.endcnt 
   NO-LOCK NO-ERROR.
   REPEAT WHILE avail uwm130:
        IF    uwm100.poltyp  = "V70"  THEN
              nv_sum  = nv_sum + uwm130.uom6_v.
        ELSE  nv_sum  = nv_sum + uwm130.uom9_v.
        
        FIND NEXT uwm130 USE-INDEX uwm13001   WHERE
                  uwm130.policy = uwm100.policy AND
                  uwm130.rencnt = uwm100.rencnt AND
                  uwm130.endcnt = uwm100.endcnt 
        NO-LOCK NO-ERROR.
   END.
   FIND FIRST uwm200 USE-INDEX uwm20001 WHERE
              uwm200.policy = UWM100.POLICY  AND
              uwm200.rencnt = uwm100.rencnt  AND
              uwm200.endcnt = uwm100.endcnt  AND
              uwm200.csftq  <> "C"
   NO-LOCK NO-ERROR.
   FIND FIRST uwm120 USE-INDEX uwm12001 WHERE
              uwm120.policy = uwm100.policy  AND
              uwm120.rencnt = uwm100.rencnt  AND
              uwm120.endcnt = uwm100.endcnt
   NO-LOCK NO-ERROR.
      nvexch = 1.
   IF AVAIL uwm120 THEN DO:
     IF SUBSTRING(uwm120.policy,3,2) = "90" THEN nvexch = 1.
     ELSE nvexch = uwm120.siexch.
   END.
   n_an = nv_sum * nvexch.
   FIND FIRST uwd132 USE-INDEX uwd13290   WHERE
              uwd132.policy = uwm100.policy AND
              uwd132.rencnt = uwm100.rencnt AND
              uwd132.endcnt = uwm100.endcnt 
   NO-LOCK NO-ERROR.
   REPEAT WHILE avail uwd132:
        IF uwd132.bencod = 'COMP' OR uwd132.bencod = 'COMG' OR
           uwd132.bencod = 'COMH'  THEN DO:
           n_prmcom   =  n_prmcom + uwd132.prem_c.
           n_stp      =  (uwd132.prem_c  *  0.4) / 100.
           IF n_stp - TRUNCATE(n_stp,0)  <> 0 then n_stp = TRUNCATE(n_stp,0) + 1.
           n_tstpcom  =  n_tstpcom + n_stp.
           n_taxcom   =  (n_prmcom + n_tstpcom) * uwm100.gstrat / 100.
        END.
        IF uwd132.bencod = "PA" THEN DO:
           n_paprm = n_paprm + uwd132.prem_c.
           n_stppa = (uwd132.prem_c  *  0.4) / 100.
           IF n_stppa - TRUNCATE(n_stppa,0)  <> 0 then n_stppa = TRUNCATE(n_stppa,0) + 1.
           n_tstppa = n_tstppa + n_stppa.
           n_taxpa = (n_paprm + n_tstppa) * uwm100.gstrat / 100.
        END.
        FIND NEXT uwd132 USE-INDEX uwd13290   WHERE
                  uwd132.policy = uwm100.policy AND
                  uwd132.rencnt = uwm100.rencnt AND
                  uwd132.endcnt = uwm100.endcnt NO-LOCK NO-ERROR.
   END.
   ASSIGN
       n_prmt    = 0        n_prms    = 0
       n_prmq    = 0        n_prmtfp  = 0
       n_prmrq   = 0        n_prmf1   = 0
       n_prmf2   = 0        n_prmr    = 0
       n_prmps   = 0        n_prmbtr  = 0
       n_prmotr  = 0        n_prms8   = 0
       n_prmf4   = 0        n_prmftr  = 0.
   LOOPB:
   REPEAT:
      n_cnt1  = n_cnt1 + 1.
      s_recid = RECID(uwm200).
      ASSIGN
          n_prmt    = 0         n_prms    = 0 
          n_prmq    = 0         n_prmtfp  = 0 
          n_prmrq   = 0         n_prmf1   = 0 
          n_prmf2   = 0         n_prmr    = 0 
          n_prmps   = 0         n_prmbtr  = 0 
          n_prmotr  = 0         n_prms8   = 0
          n_prmf4   = 0         n_prmftr  = 0 .

      IF UWM100.TRANTY <> "C" THEN DO:
         RUN Pd_Process1.
      END.
      ELSE DO:
         RUN Pd_Process2.
      END.
      FIND NEXT uwm200  USE-INDEX  uwm20001  WHERE
                uwm200.policy = uwm100.policy  AND
                uwm200.rencnt = uwm100.rencnt  AND
                uwm200.endcnt = uwm100.endcnt  NO-LOCK NO-ERROR.

      IF NOT AVAIL uwm200 THEN LEAVE loopb.
   END.   /* loopb */
   ASSIGN
        n_prmf1      =   n_prmf1     * (-1)
        n_prmf2      =   n_prmf2     * (-1)
        n_prmt       =   n_prmt      * (-1)
        n_prms       =   n_prms      * (-1)
        n_prmq       =   n_prmq      * (-1)
        n_prmtfp     =   n_prmtfp    * (-1)
        n_prmrq      =   n_prmrq     * (-1)
        n_prmps      =   n_prmps     * (-1)  
        n_prmbtr     =   n_prmbtr    * (-1)  
        n_prmotr     =   n_prmotr    * (-1)  
        n_prms8      =   n_prms8     * (-1)  
        n_prmf4      =   n_prmf4     * (-1)  
        n_prmftr     =   n_prmftr    * (-1).

   RUN Pd_detailMotor.

   ASSIGN
        nv_sum    = 0 
        p_t       = 000  n_sumt     = 0   n_prmt    = 0
        p_s       = 000  n_sums     = 0   n_prms    = 0
        p_q       = 000  n_sumq     = 0   n_prmq    = 0
        p_tfp     = 000  n_sumtfp   = 0   n_prmtfp  = 0
        p_rq      = 000  n_sumrq    = 0   n_prmrq   = 0
        p_f1      = 000  n_sumf1    = 0   n_prmf1   = 0
        p_f2      = 000  n_sumf2    = 0   n_prmf2   = 0
        p_r       = 000  n_sumr     = 0   n_prmr    = 0
        p_ps      = 000  n_sumps    = 0   n_prmps   = 0  
        p_btr     = 000  n_sumbtr   = 0   n_prmbtr  = 0  
        p_otr     = 000  n_sumotr   = 0   n_prmotr  = 0  
        p_s8      = 000  n_sums8    = 0   n_prms8   = 0 
        p_f4      = 000  n_sumf4    = 0   n_prmf4   = 0
        p_ftr     = 000  n_sumftr   = 0   n_prmftr  = 0
        n_rb_pf   = 000  n_rb_sum   = 0   n_rb_prm  = 0
        n_rf_pf   = 000  n_rf_sum   = 0   n_rf_prm  = 0
        nv_prmtre = 0 .

   IF LAST-OF(uwm100.poltyp) THEN DO:

       ASSIGN
          pv_f1_prb   = pv_f1_prb   * (-1)      iv_f1_prb   = iv_f1_prb   * (-1)
          pv_f2_prb   = pv_f2_prb   * (-1)      iv_f2_prb   = iv_f2_prb   * (-1)
          pv_0t_prb   = pv_0t_prb   * (-1)      iv_0t_prb   = iv_0t_prb   * (-1)
          pv_0s_prb   = pv_0s_prb   * (-1)      iv_0s_prb   = iv_0s_prb   * (-1)
          pv_stat_prb = pv_stat_prb * (-1)      iv_stat_prb = iv_stat_prb * (-1)
          pv_0q_prb   = pv_0q_prb   * (-1)      iv_0q_prb   = iv_0q_prb   * (-1)
          pv_0rq_prb  = pv_0rq_prb  * (-1)      iv_0rq_prb  = iv_0rq_prb  * (-1)
          pv_0f_prb   = pv_0f_prb   * (-1)      iv_0f_prb   = iv_0f_prb   * (-1)
          nv_f1_prb   = nv_f1_prb   * (-1)      nv_f2_prb   = nv_f2_prb   * (-1)
          nv_0t_prb   = nv_0t_prb   * (-1)      nv_0s_prb   = nv_0s_prb   * (-1)
          nv_stat_prb = nv_stat_prb * (-1)      nv_0q_prb   = nv_0q_prb   * (-1)
          nv_0rq_prb  = nv_0rq_prb  * (-1)      nv_0f_prb   = nv_0f_prb   * (-1)
          pv_s8_prb   = pv_s8_prb   * (-1)      iv_s8_prb   = iv_s8_prb   * (-1)
          nv_0ps_prb  = nv_0ps_prb  * (-1)
          pv_0ps_prb  = pv_0ps_prb  * (-1)      iv_0ps_prb   = iv_0ps_prb   * (-1)
          nv_btr_prb  = nv_btr_prb  * (-1)
          pv_btr_prb  = pv_btr_prb  * (-1)      iv_btr_prb   = iv_btr_prb   * (-1)
          nv_otr_prb  = nv_otr_prb  * (-1)
          pv_otr_prb  = pv_otr_prb  * (-1)      iv_otr_prb   = iv_otr_prb   * (-1)
          nv_f4_prb   = nv_f4_prb   * (-1)
          pv_f4_prb   = pv_f4_prb   * (-1)      iv_f4_prb    = iv_f4_prb    * (-1)
          nv_ftr_prb  = nv_ftr_prb  * (-1)
          pv_ftr_prb  = pv_ftr_prb  * (-1)      iv_ftr_prb   = iv_ftr_prb   * (-1).

          FIND FIRST wtotal WHERE wtotal.poltyp = SUBSTR(uwm100.poltyp,2,2) NO-LOCK NO-ERROR.
          IF NOT AVAIL wtotal THEN DO:
              CREATE wtotal.
              ASSIGN 
                  wtotal.poltyp    = SUBSTR(uwm100.poltyp,2,2)
                  wtotal.totprmcom = nv_totprmcom 
                  wtotal.totsumprm = nv_totsumprm 
                  wtotal.totearn   = nv_totearn   
                  wtotal.totuearn  = nv_totuearn  
                  wtotal.totearn1  = nv_totearn1  
                  wtotal.totuearn1 = nv_totuearn1 
                  /* comment by Benjaporn J. A58-0242
                  wtotal.totprmtre = nv_totprmtre 
                  wtotal.totearn2  = nv_totearn2  
                  wtotal.totuearn2 = nv_totuearn2  */
                  /* start A58-0242 Benjaporn J. 13/07/2015 */
                  wtotal.totprmtrt   = nv_totprmtrt 
                  wtotal.totearntrt  = nv_totearntrt  
                  wtotal.totuearntrt = nv_totuearntrt
                  wtotal.totprmfac   = nv_totprmfac
                  wtotal.totearnfac  = nv_totearnfac  
                  wtotal.totuearnfac = nv_totuearnfac. /* end A58-0242 Benjaporn J. 13/07/2015 */
          END.
          ASSIGN
              nv_totprmcom    = 0    nv_totsumprm = 0
              nv_totearn      = 0    nv_totuearn  = 0
              nv_totearn1     = 0    nv_totuearn1 = 0
              nv_totprmtrt    = 0 
              nv_totearntrt   = 0 
              nv_totuearntrt  = 0 
              nv_totprmfac    = 0 
              nv_totearnfac   = 0 
              nv_totuearnfac  = 0  .
          /* comment by Benjaporn J. A58-0242
              nv_totprmtre = 0   nv_totearn2   = 0
              nv_totuearn2 = 0  */
   END.
END.
PUT STREAM ns1
    "Grand Total"   SKIP.
loopmain1:
FOR EACH wtotal BREAK BY wtotal.poltyp.
    FIND xmm031 USE-INDEX xmm03101       WHERE 
         xmm031.poltyp = wtotal.poltyp   NO-LOCK NO-ERROR.
    IF AVAIL xmm031 THEN DO:
       IF xmm031.dept <> "G" AND xmm031.dept <> "M" THEN NEXT loopmain1.
       IF LOOKUP(xmm031.poltyp,nv_poltyp) <> 0  THEN NEXT loopmain1.
    END.
    IF wtotal.totprmcom = 0 AND wtotal.totsumprm = 0 AND
       wtotal.totearn   = 0 AND wtotal.totuearn  = 0 AND
       wtotal.totearn1  = 0 AND wtotal.totuearn1 = 0 AND
         /* comment by Benjaporn J. A58-0242
       wtotal.totearn2  = 0 AND wtotal.totuearn2 = 0 THEN DO:  */
        /* start A58-0242 Benjaporn J. 13/07/2015 */
       wtotal.totearntrt  = 0 AND wtotal.totuearntrt = 0 AND
       wtotal.totearnfac  = 0 AND wtotal.totuearnfac = 0 THEN DO: /* end A58-0242 Benjaporn J. 13/07/2015 */
    END.
    ELSE DO:
        PUT STREAM ns1
            "Line  " wtotal.poltyp "|" "|" "|" "|" "|" "|" "|" "|" "|" "|"
            wtotal.totprmcom "|"
            wtotal.totsumprm "|"
            wtotal.totearn   "|"
            wtotal.totuearn  "|"
            wtotal.totearn1  "|"
            wtotal.totuearn1 "|"
             /* comment by Benjaporn J. A58-0242
            wtotal.totprmtre "|"
            wtotal.totearn2  "|"
            wtotal.totuearn2 "|" */
            /* start A58-0242 Benjaporn J. 13/07/2015 */
            wtotal.totprmtrt   "|"
            wtotal.totearntrt  "|"
            wtotal.totuearntrt "|"
            wtotal.totprmfac   "|"
            wtotal.totearnfac  "|"
            wtotal.totuearnfac SKIP. /* end A58-0242 Benjaporn J. 13/07/2015 */
    END.
END.
PUT STREAM ns3
    "Cancel - Grand Total"  "|" "|" "|" "|" "|" "|" "|" "|" "|" "|"
    nv_ctotprmcom "|" 
    nv_ctotsumprm "|" 
    nv_ctotearn   "|" 
    nv_ctotuearn  "|" 
    nv_ctotearn1  "|" 
    nv_ctotuearn1 "|" 
     /* comment by Benjaporn J. A58-0242
    nv_ctotprmtre "|" 
    nv_ctotearn2  "|" 
    nv_ctotuearn2 "|"  */
    /* start A58-0242 Benjaporn J. 13/07/2015 */
    nv_ctotprmtrt   "|" 
    nv_ctotearntrt  "|" 
    nv_ctotuearntrt "|" 
    nv_ctotprmfac   "|" 
    nv_ctotearnfac  "|" 
    nv_ctotuearnfac SKIP. /* end A58-0242 Benjaporn J. 13/07/2015 */

OUTPUT STREAM ns1 CLOSE.
OUTPUT STREAM ns2 CLOSE.
OUTPUT STREAM ns3 CLOSE.    
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pd_Motor_earn C-Win 
PROCEDURE Pd_Motor_earn :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH wrk0f.
    DELETE wrk0f.
END.
FOR EACH wtotal.
    DELETE wtotal.
END.
RUN Pd_Checkbranch.

ASSIGN
    n_rec    = 1
    n_rec1   = 1
    n_rec2   = 1   /*A56-0092*/
    nv_count = 0
    n_count  = 0
    n_count1 = 0   /*A56-0092*/
    nv_poltyp = "" .
FOR EACH wfline NO-LOCK.
    ASSIGN nv_poltyp = trim(nv_poltyp +  "," + wfline.nline) .
END.

loopmain:
FOR EACH uwm100 NO-LOCK USE-INDEX uwm10008 WHERE
         uwm100.trndat  >=  fi_trndat               AND
      /* uwm100.trndat  <=  fi_asdate               AND*/
         uwm100.trndat  <=  fi_trndatto             AND   /* A58-0242 Benjaporn J. 13/07/2015 */
         uwm100.expdat  <   fi_asdate               AND 
         uwm100.agent   >=  fi_agentfr              AND
         uwm100.agent   <=  fi_agentto              AND
  INDEX( nv_brdes, "," + TRIM(uwm100.branch)) <> 0  AND
      (( fi_releas = "Y"  AND UWM100.RELEAS = YES ) OR
       ( fi_releas = "N"  AND UWM100.RELEAS = NO  ) OR
       ( fi_releas = "A"))  BREAK BY uwm100.poltyp 
                                  /*BY uwm100.branch */
                                  BY uwm100.policy
                                  /*BY uwm100.endno
                                  BY uwm100.trndat
                                  BY uwm100.tranty*/ .

   fi_etime = STRING(TIME,"HH:MM:SS"). /*Lukkana M. A55-0144 25/04/2012*/
   n_bran   = "".
   n_bran   = uwm100.branch.
   DISP fi_stime fi_etime WITH FRAME fr_main. /*Lukkana M. A55-0144 25/04/2012*/
   
   IF SUBSTR(uwm100.policy,1,1) = "I" THEN DO:

         IF nv_brdes1 = ""  THEN NEXT loopmain.
         IF INDEX(nv_brdes1,",9" + SUBSTRING(uwm100.policy,2,1)) <> 0 THEN 
             n_bran = "9" + SUBSTRING(uwm100.policy,2,1). 
   END.
   ELSE  DO:    
         IF INDEX("ABCDEFGHIJKLMNOPQRSTUVWXYZ" , fi_branchto) <> 0  THEN DO: /*พบตัวอักษรในbranch*/
            IF uwm100.branch < fi_branchfr OR uwm100.branch > fi_branchto THEN NEXT loopmain.
         END.
         ELSE DO:
            IF INTEGER(uwm100.branch) < nv_brn_fr OR INTEGER(uwm100.branch) > nv_brn_to THEN NEXT loopmain.
         END.
   END.  
   /*A58-0180....
   ASSIGN
       nv_poltyp = ""
       nv_poltyp = fi_exc1  + "," + fi_exc2  + "," + fi_exc3  + "," + fi_exc4  + "," + fi_exc5  + "," +
                   fi_exc6  + "," + fi_exc7  + "," + fi_exc8  + "," + fi_exc9  + "," + fi_exc10 + "," +
                   fi_exc11 + "," + fi_exc12 + "," + fi_exc13 + "," + fi_exc14 + "," + fi_exc15 + "," +
                   fi_exc16 + "," + fi_exc17 + "," + fi_exc18 + "," + fi_exc19 + "," + fi_exc20.
   A58-0180....*/

   FIND xmm031 USE-INDEX xmm03101       WHERE 
        xmm031.poltyp = uwm100.poltyp   NO-LOCK NO-ERROR.
   IF AVAIL xmm031 THEN DO:
       IF xmm031.dept <> "G" AND xmm031.dept <> "M" THEN NEXT loopmain.
       IF LOOKUP(xmm031.poltyp,nv_poltyp) <> 0  THEN NEXT loopmain.
   END.
   
   /*nv_count  = nv_count + 1 .*/

   /*------A63-0159----Change from 65000 to 1000000 --*/
   IF nv_count > 1000000 THEN DO:
       nv_output  = (fi_output  + "_" + STRING(n_rec)) .
       RUN Pd_HeaderMotor.
       n_rec = n_rec + 1.
       nv_count = 0.
   END.

   IF n_count > 1000000 THEN DO:
       nv_output1 = (fi_output +  "_error" + "_" + STRING(n_rec1)) .
       RUN Pd_HeaderMotorerror.
       n_rec1 = n_rec1 + 1.
       n_count = 0.
   END.

   IF n_count1 > 1000000 THEN DO:
       nv_output2 = (fi_output +  "_can" + "_" + STRING(n_rec2)) .
       RUN Pd_HeaderMotorCan.
       n_rec2 = n_rec2 + 1.
       n_count1 = 0.
   END.
   /*-------A63-0159------*/
   
   IF FIRST-OF(uwm100.poltyp)   THEN do: 
       RUN Pd_Cleartreaty.
   END.         

   DISPLAY  uwm100.trndat  uwm100.policy  WITH NO-LABEL TITLE "Process Report..."
       FRAME a1 VIEW-AS DIALOG-BOX.

   FIND xmm023 USE-INDEX xmm02301 WHERE
        xmm023.branch = n_bran    NO-LOCK NO-ERROR.
   IF NOT AVAIL xmm023 THEN NEXT loopmain.
   n_branch = n_bran.
   n_bdes   = xmm023.bdes.

   IF uwm100.DIR_ri = YES THEN nv_dir = 'D'.
   ELSE nv_dir = 'I'.

   n_endcnt = uwm100.endcnt - 1.

   ASSIGN
       nv_prstp  = 0       n_prmcom   = 0
       nv_prtax  = 0       n_stp      = 0
       nv_sumpts = 0       n_tstpcom  = 0
       n_sumprm  = 0       n_taxcom   = 0
       n_sumstp  = 0       n_stptrunc = 0
       n_sumtax  = 0       n_stpcom   = 0
       nu_tax    = 0       n_ttaxcom  = 0
       nu_prm    = 0       n_paprm    = 0
       nu_vat    = 0       n_stppa    = 0
       nv_sum    = 0       n_tstppa   = 0
       n_an      = 0       n_taxpa    = 0
       nvexch    = 1       nv_prmtre  = 0 .
  
   FIND FIRST uwm130 USE-INDEX uwm13001   WHERE
              uwm130.policy = uwm100.policy AND
              uwm130.rencnt = uwm100.rencnt AND
              uwm130.endcnt = uwm100.endcnt 
   NO-LOCK NO-ERROR.
   REPEAT WHILE avail uwm130:
        IF    uwm100.poltyp  = "V70"  THEN
              nv_sum  = nv_sum + uwm130.uom6_v.
        ELSE  nv_sum  = nv_sum + uwm130.uom9_v.
        
        FIND NEXT uwm130 USE-INDEX uwm13001   WHERE
                  uwm130.policy = uwm100.policy AND
                  uwm130.rencnt = uwm100.rencnt AND
                  uwm130.endcnt = uwm100.endcnt 
        NO-LOCK NO-ERROR.
   END.
   
   FIND FIRST uwm200 USE-INDEX uwm20001 WHERE
              uwm200.policy = UWM100.POLICY  AND
              uwm200.rencnt = uwm100.rencnt  AND
              uwm200.endcnt = uwm100.endcnt  AND
              uwm200.csftq  <> "C"
   NO-LOCK NO-ERROR.
   
   FIND FIRST uwm120 USE-INDEX uwm12001 WHERE
              uwm120.policy = uwm100.policy  AND
              uwm120.rencnt = uwm100.rencnt  AND
              uwm120.endcnt = uwm100.endcnt
   NO-LOCK NO-ERROR.
      nvexch = 1.

   IF AVAIL uwm120 THEN DO:
     IF SUBSTRING(uwm120.policy,3,2) = "90" THEN nvexch = 1.
     ELSE nvexch = uwm120.siexch.
   END.
   
   
   n_an = nv_sum * nvexch.
   FIND FIRST uwd132 USE-INDEX uwd13290   WHERE
              uwd132.policy = uwm100.policy AND
              uwd132.rencnt = uwm100.rencnt AND
              uwd132.endcnt = uwm100.endcnt 
   NO-LOCK NO-ERROR.
   REPEAT WHILE avail uwd132:
        IF uwd132.bencod = 'COMP' OR uwd132.bencod = 'COMG' OR
           uwd132.bencod = 'COMH'  THEN DO:
           n_prmcom   =  n_prmcom + uwd132.prem_c.
 
           n_stp      =  (uwd132.prem_c  *  0.4) / 100.
   
           IF n_stp - TRUNCATE(n_stp,0)  <> 0 then n_stp = TRUNCATE(n_stp,0) + 1.
           n_tstpcom  =  n_tstpcom + n_stp.
           n_taxcom   =  (n_prmcom + n_tstpcom) * uwm100.gstrat / 100.
        END.
        IF uwd132.bencod = "PA" THEN DO:
           n_paprm = n_paprm + uwd132.prem_c.
           n_stppa = (uwd132.prem_c  *  0.4) / 100.
   
           IF n_stppa - TRUNCATE(n_stppa,0)  <> 0 then n_stppa = TRUNCATE(n_stppa,0) + 1.
           n_tstppa = n_tstppa + n_stppa.
           n_taxpa = (n_paprm + n_tstppa) * uwm100.gstrat / 100.
        END.
        
        FIND NEXT uwd132 USE-INDEX uwd13290   WHERE
                  uwd132.policy = uwm100.policy AND
                  uwd132.rencnt = uwm100.rencnt AND
                  uwd132.endcnt = uwm100.endcnt  NO-LOCK NO-ERROR.
   END.
   
   ASSIGN
       n_prmt    = 0          n_prms    = 0
       n_prmq    = 0          n_prmtfp  = 0
       n_prmrq   = 0          n_prmf1   = 0
       n_prmf2   = 0          n_prmr    = 0
       n_prmps   = 0          n_prmbtr  = 0
       n_prmotr  = 0          n_prms8   = 0
       n_prmf4   = 0          n_prmftr  = 0.

   LOOPB:
   REPEAT:
      n_cnt1  = n_cnt1 + 1.
      s_recid = RECID(uwm200).
      ASSIGN
          n_prmt    = 0        n_prms    = 0 
          n_prmq    = 0        n_prmtfp  = 0 
          n_prmrq   = 0        n_prmf1   = 0 
          n_prmf2   = 0        n_prmr    = 0 
          n_prmps   = 0        n_prmbtr  = 0 
          n_prmotr  = 0        n_prms8   = 0
          n_prmf4   = 0        n_prmftr  = 0 .

      IF UWM100.TRANTY <> "C" THEN DO:
         RUN Pd_Process1.
      END.
      ELSE DO:
         RUN Pd_Process2.
      END.

      FIND NEXT uwm200  USE-INDEX  uwm20001  WHERE
                uwm200.policy = uwm100.policy  AND
                uwm200.rencnt = uwm100.rencnt  AND
                uwm200.endcnt = uwm100.endcnt  NO-LOCK NO-ERROR.

      IF NOT AVAIL uwm200 THEN LEAVE loopb.
   END.   /* loopb */
   ASSIGN
        n_prmf1      =   n_prmf1     * (-1)
        n_prmf2      =   n_prmf2     * (-1)
        n_prmt       =   n_prmt      * (-1)
        n_prms       =   n_prms      * (-1)
        n_prmq       =   n_prmq      * (-1)
        n_prmtfp     =   n_prmtfp    * (-1)
        n_prmrq      =   n_prmrq     * (-1)
        n_prmps      =   n_prmps     * (-1)  
        n_prmbtr     =   n_prmbtr    * (-1)  
        n_prmotr     =   n_prmotr    * (-1)  
        n_prms8      =   n_prms8     * (-1)  
        n_prmf4      =   n_prmf4     * (-1)  
        n_prmftr     =   n_prmftr    * (-1).
   
   RUN Pd_detailMotor.
   
   ASSIGN
        nv_sum    = 0 
        p_t       = 000  n_sumt     = 0   n_prmt    = 0
        p_s       = 000  n_sums     = 0   n_prms    = 0
        p_q       = 000  n_sumq     = 0   n_prmq    = 0
        p_tfp     = 000  n_sumtfp   = 0   n_prmtfp  = 0
        p_rq      = 000  n_sumrq    = 0   n_prmrq   = 0
        p_f1      = 000  n_sumf1    = 0   n_prmf1   = 0
        p_f2      = 000  n_sumf2    = 0   n_prmf2   = 0
        p_r       = 000  n_sumr     = 0   n_prmr    = 0
        p_ps      = 000  n_sumps    = 0   n_prmps   = 0  
        p_btr     = 000  n_sumbtr   = 0   n_prmbtr  = 0  
        p_otr     = 000  n_sumotr   = 0   n_prmotr  = 0  
        p_s8      = 000  n_sums8    = 0   n_prms8   = 0  
                                     
        p_f4      = 000  n_sumf4    = 0   n_prmf4   = 0
        p_ftr     = 000  n_sumftr   = 0   n_prmftr  = 0
        n_rb_pf   = 000  n_rb_sum   = 0   n_rb_prm  = 0
        n_rf_pf   = 000  n_rf_sum   = 0   n_rf_prm  = 0
        nv_prmtre = 0.

 IF LAST-OF(uwm100.poltyp) THEN DO:
        
       ASSIGN
          pv_f1_prb   = pv_f1_prb   * (-1)      iv_f1_prb   = iv_f1_prb   * (-1)
          pv_f2_prb   = pv_f2_prb   * (-1)      iv_f2_prb   = iv_f2_prb   * (-1)
          pv_0t_prb   = pv_0t_prb   * (-1)      iv_0t_prb   = iv_0t_prb   * (-1)
          pv_0s_prb   = pv_0s_prb   * (-1)      iv_0s_prb   = iv_0s_prb   * (-1)
          pv_stat_prb = pv_stat_prb * (-1)      iv_stat_prb = iv_stat_prb * (-1)
          pv_0q_prb   = pv_0q_prb   * (-1)      iv_0q_prb   = iv_0q_prb   * (-1)
          pv_0rq_prb  = pv_0rq_prb  * (-1)      iv_0rq_prb  = iv_0rq_prb  * (-1)
          pv_0f_prb   = pv_0f_prb   * (-1)      iv_0f_prb   = iv_0f_prb   * (-1)
          nv_f1_prb   = nv_f1_prb   * (-1)      nv_f2_prb   = nv_f2_prb   * (-1)
          nv_0t_prb   = nv_0t_prb   * (-1)      nv_0s_prb   = nv_0s_prb   * (-1)
          nv_stat_prb = nv_stat_prb * (-1)      nv_0q_prb   = nv_0q_prb   * (-1)
          nv_0rq_prb  = nv_0rq_prb  * (-1)      nv_0f_prb   = nv_0f_prb   * (-1)
          pv_s8_prb   = pv_s8_prb   * (-1)      iv_s8_prb   = iv_s8_prb   * (-1)

          nv_0ps_prb  = nv_0ps_prb  * (-1)
          pv_0ps_prb  = pv_0ps_prb  * (-1)      iv_0ps_prb   = iv_0ps_prb   * (-1)
          
          nv_btr_prb  = nv_btr_prb  * (-1)
          pv_btr_prb  = pv_btr_prb  * (-1)      iv_btr_prb   = iv_btr_prb   * (-1)
          nv_otr_prb  = nv_otr_prb  * (-1)
          pv_otr_prb  = pv_otr_prb  * (-1)      iv_otr_prb   = iv_otr_prb   * (-1)

          nv_f4_prb   = nv_f4_prb   * (-1)
          pv_f4_prb   = pv_f4_prb   * (-1)      iv_f4_prb    = iv_f4_prb    * (-1)
          nv_ftr_prb  = nv_ftr_prb  * (-1)
          pv_ftr_prb  = pv_ftr_prb  * (-1)      iv_ftr_prb   = iv_ftr_prb   * (-1).
          
       
          FIND FIRST wtotal WHERE wtotal.poltyp = SUBSTR(uwm100.poltyp,2,2) NO-LOCK NO-ERROR.
          IF NOT AVAIL wtotal THEN DO:
              CREATE wtotal.
              ASSIGN 
                  wtotal.poltyp    = SUBSTR(uwm100.poltyp,2,2)
                  wtotal.totprmcom = nv_totprmcom 
                  wtotal.totsumprm = nv_totsumprm 
                  wtotal.totearn   = nv_totearn   
                  wtotal.totuearn  = nv_totuearn  
                  wtotal.totearn1  = nv_totearn1  
                  wtotal.totuearn1 = nv_totuearn1 
                   /* comment by Benjaporn J. A58-0242
                  wtotal.totprmtre = nv_totprmtre 
                  wtotal.totearn2  = nv_totearn2  
                  wtotal.totuearn2 = nv_totuearn2*/
                  /* start A58-0242 Benjaporn J. 13/07/2015 */
                  wtotal.totprmtrt   = nv_totprmtrt 
                  wtotal.totearntrt  = nv_totearntrt  
                  wtotal.totuearntrt = nv_totuearntrt
                  wtotal.totprmfac   = nv_totprmfac
                  wtotal.totearnfac  = nv_totearnfac  
                  wtotal.totuearnfac = nv_totuearnfac. /* end A58-0242 Benjaporn J. 13/07/2015 */
          END.
ASSIGN
              nv_totprmcom    = 0    nv_totsumprm = 0
              nv_totearn      = 0    nv_totuearn  = 0
              nv_totearn1     = 0    nv_totuearn1 = 0
              nv_totprmtrt    = 0 
              nv_totearntrt   = 0 
              nv_totuearntrt  = 0 
              nv_totprmfac    = 0 
              nv_totearnfac   = 0 
              nv_totuearnfac  = 0  .
             /* comment by Benjaporn J. A58-0242
            nv_totprmtre = 0    nv_totearn2  = 0
            nv_totuearn2 = 0  */
   END.
END.

PUT STREAM ns1
    "Grand Total"   SKIP.

loopmain1:
FOR EACH wtotal BREAK BY wtotal.poltyp.

    FIND xmm031 USE-INDEX xmm03101       WHERE 
         xmm031.poltyp = wtotal.poltyp   NO-LOCK NO-ERROR.
    IF AVAIL xmm031 THEN DO:

       IF xmm031.dept <> "G" AND xmm031.dept <> "M" THEN NEXT loopmain1.
       IF LOOKUP(xmm031.poltyp,nv_poltyp) <> 0  THEN NEXT loopmain1.
 END.
     IF wtotal.totprmcom = 0 AND wtotal.totsumprm = 0 AND
        wtotal.totearn   = 0 AND wtotal.totuearn  = 0 AND
        wtotal.totearn1  = 0 AND wtotal.totuearn1 = 0 AND
          /* comment by Benjaporn J. A58-0242
       wtotal.totearn2  = 0 AND wtotal.totuearn2 = 0 THEN DO: */
         /* start A58-0242 Benjaporn J. 13/07/2015 */
       wtotal.totearntrt  = 0 AND wtotal.totuearntrt = 0 AND
       wtotal.totearnfac  = 0 AND wtotal.totuearnfac = 0 THEN DO: /* end A58-0242 Benjaporn J. 13/07/2015 */
END.
    ELSE DO:
        PUT STREAM ns1
            "Line  " wtotal.poltyp "|" "|" "|" "|" "|" "|" "|" "|" "|" "|"
            wtotal.totprmcom "|"
            wtotal.totsumprm "|"
            wtotal.totearn   "|"
            wtotal.totuearn  "|"
            wtotal.totearn1  "|"
            wtotal.totuearn1 "|"
             /* comment by Benjaporn J. A58-0242
            wtotal.totprmtre "|"
            wtotal.totearn2  "|"
            wtotal.totuearn2 "|" */
            /* start A58-0242 Benjaporn J. 13/07/2015 */
            wtotal.totprmtrt   "|"
            wtotal.totearntrt  "|"
            wtotal.totuearntrt "|"
            wtotal.totprmfac   "|"
            wtotal.totearnfac  "|"
            wtotal.totuearnfac SKIP. /* end A58-0242 Benjaporn J. 13/07/2015 */
    END.
END.    /*---A56-0092---*/
PUT STREAM ns3
    "Cancel - Grand Total"  "|" "|" "|" "|" "|" "|" "|" "|" "|" "|"
    nv_ctotprmcom "|" 
    nv_ctotsumprm "|" 
    nv_ctotearn   "|" 
    nv_ctotuearn  "|" 
    nv_ctotearn1  "|" 
    nv_ctotuearn1 "|"
     /* comment by Benjaporn J. A58-0242
    nv_ctotprmtre "|" 
    nv_ctotearn2  "|" 
    nv_ctotuearn2 "|"  */
    /* start A58-0242 Benjaporn J. 13/07/2015 */
    nv_ctotprmtrt   "|" 
    nv_ctotearntrt  "|" 
    nv_ctotuearntrt "|" 
    nv_ctotprmfac   "|" 
    nv_ctotearnfac  "|" 
    nv_ctotuearnfac SKIP.   /*--end A56-0092---*/  /* end A58-0242 Benjaporn J. 13/07/2015 */

OUTPUT STREAM ns1 CLOSE.
OUTPUT STREAM ns2 CLOSE.
OUTPUT STREAM ns3 CLOSE.    /*A56-0092*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pd_Motor_earnNZI C-Win 
PROCEDURE Pd_Motor_earnNZI :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH wrk0f.
    DELETE wrk0f.
END.
FOR EACH wtotal.
    DELETE wtotal.
END.

ASSIGN
    n_rec    = 1
    n_rec1   = 1
    n_rec2   = 1    /*A56-0092*/
    nv_count = 0
    n_count  = 0
    n_count1 = 0    /*A56-0092*/
    nv_poltyp = "" .
FOR EACH wfline NO-LOCK.
    ASSIGN nv_poltyp = trim(nv_poltyp +  "," + wfline.nline) .
END.

loopmain:
FOR EACH uwm100 NO-LOCK USE-INDEX uwm10008 WHERE
         uwm100.trndat  >=  fi_trndat               AND
     /*  uwm100.trndat  <=  fi_asdate               AND  */
         uwm100.trndat  <=  fi_trndatto             AND   /* A58-0242 Benjaporn J. 13/07/2015 */
         uwm100.expdat  <   fi_asdate               AND 
         uwm100.agent   >=  fi_agentfr              AND
         uwm100.agent   <=  fi_agentto              AND
         uwm100.branch  >=  fi_branchfr             AND
         uwm100.branch  <=  fi_branchto             AND
      (( fi_releas = "Y"  AND UWM100.RELEAS = YES ) OR
       ( fi_releas = "N"  AND UWM100.RELEAS = NO  ) OR
       ( fi_releas = "A"))  BREAK BY uwm100.poltyp 
                                  /*BY uwm100.branch */
                                  BY uwm100.policy
                                  /*BY uwm100.endno
                                  BY uwm100.trndat
                                  BY uwm100.tranty*/ .

   fi_etime = STRING(TIME,"HH:MM:SS"). /*Lukkana M. A55-0144 25/04/2012*/
   n_bran   = "".
   n_bran   = uwm100.branch.
   DISP fi_stime fi_etime WITH FRAME fr_main. /*Lukkana M. A55-0144 25/04/2012*/
   
   /*A58-0180
   ASSIGN
       nv_poltyp = ""
       nv_poltyp = fi_exc1  + "," + fi_exc2  + "," + fi_exc3  + "," + fi_exc4  + "," + fi_exc5  + "," +
                   fi_exc6  + "," + fi_exc7  + "," + fi_exc8  + "," + fi_exc9  + "," + fi_exc10 + "," +
                   fi_exc11 + "," + fi_exc12 + "," + fi_exc13 + "," + fi_exc14 + "," + fi_exc15 + "," +
                   fi_exc16 + "," + fi_exc17 + "," + fi_exc18 + "," + fi_exc19 + "," + fi_exc20.
   A58-0180*/

   FIND xmm031 USE-INDEX xmm03101       WHERE 
        xmm031.poltyp = uwm100.poltyp   NO-LOCK NO-ERROR.
   IF AVAIL xmm031 THEN DO:
       IF xmm031.dept <> "G" AND xmm031.dept <> "M" THEN NEXT loopmain.
       IF LOOKUP(xmm031.poltyp,nv_poltyp) <> 0  THEN NEXT loopmain.
   END.
   
   /*nv_count  = nv_count + 1 .*/

   /*------A63-0159----Change from 65000 to 1000000 --*/
   IF nv_count > 1000000 THEN DO:
       nv_output  = (fi_output  + "_" + STRING(n_rec)) .
       RUN Pd_HeaderMotor.
       n_rec = n_rec + 1.
       nv_count = 0.
   END.

   IF n_count > 1000000 THEN DO:
       nv_output1 = (fi_output +  "_error" + "_" + STRING(n_rec1)) .

       RUN Pd_HeaderMotorerror.

       n_rec1 = n_rec1 + 1.
       n_count = 0.
   END.

   IF n_count1 > 1000000 THEN DO:
       nv_output2 = (fi_output +  "_can" + "_" + STRING(n_rec2)) .

       RUN Pd_HeaderMotorCan.

       n_rec2 = n_rec2 + 1.
       n_count1 = 0.
   END.
   /*-------A63-0159------*/
   
   IF FIRST-OF(uwm100.poltyp)   THEN do: 
       RUN Pd_Cleartreaty.
   END.         

   DISPLAY  uwm100.trndat  uwm100.policy  WITH NO-LABEL TITLE "Process Report..."
       FRAME a1 VIEW-AS DIALOG-BOX.

   FIND xmm023 USE-INDEX xmm02301 WHERE
        xmm023.branch = n_bran    NO-LOCK NO-ERROR.
   IF NOT AVAIL xmm023 THEN NEXT loopmain.
   n_branch = n_bran.
   n_bdes   = xmm023.bdes.

   IF uwm100.DIR_ri = YES THEN nv_dir = 'D'.
   ELSE nv_dir = 'I'.

   n_endcnt = uwm100.endcnt - 1.

   ASSIGN
       nv_prstp  = 0       n_prmcom   = 0
       nv_prtax  = 0       n_stp      = 0
       nv_sumpts = 0       n_tstpcom  = 0
       n_sumprm  = 0       n_taxcom   = 0
       n_sumstp  = 0       n_stptrunc = 0
       n_sumtax  = 0       n_stpcom   = 0
       nu_tax    = 0       n_ttaxcom  = 0
       nu_prm    = 0       n_paprm    = 0
       nu_vat    = 0       n_stppa    = 0
       nv_sum    = 0       n_tstppa   = 0
       n_an      = 0       n_taxpa    = 0
       nvexch    = 1       nv_prmtre  = 0 .

 FIND FIRST uwm130 USE-INDEX uwm13001   WHERE
              uwm130.policy = uwm100.policy AND
              uwm130.rencnt = uwm100.rencnt AND
              uwm130.endcnt = uwm100.endcnt 
   NO-LOCK NO-ERROR.
   REPEAT WHILE avail uwm130:
        IF    uwm100.poltyp  = "V70"  THEN
              nv_sum  = nv_sum + uwm130.uom6_v.
        ELSE  nv_sum  = nv_sum + uwm130.uom9_v.
        
        FIND NEXT uwm130 USE-INDEX uwm13001   WHERE
                  uwm130.policy = uwm100.policy AND
                  uwm130.rencnt = uwm100.rencnt AND
                  uwm130.endcnt = uwm100.endcnt 
        NO-LOCK NO-ERROR.
   END.
   
   FIND FIRST uwm200 USE-INDEX uwm20001 WHERE
              uwm200.policy = UWM100.POLICY  AND
              uwm200.rencnt = uwm100.rencnt  AND
              uwm200.endcnt = uwm100.endcnt  AND
              uwm200.csftq  <> "C"
   NO-LOCK NO-ERROR.
   
   FIND FIRST uwm120 USE-INDEX uwm12001 WHERE
              uwm120.policy = uwm100.policy  AND
              uwm120.rencnt = uwm100.rencnt  AND
              uwm120.endcnt = uwm100.endcnt
   NO-LOCK NO-ERROR.
      nvexch = 1.

   IF AVAIL uwm120 THEN DO:
     IF SUBSTRING(uwm120.policy,3,2) = "90" THEN nvexch = 1.
     ELSE nvexch = uwm120.siexch.
   END.
   
   n_an = nv_sum * nvexch.
   FIND FIRST uwd132 USE-INDEX uwd13290   WHERE
              uwd132.policy = uwm100.policy AND
              uwd132.rencnt = uwm100.rencnt AND
              uwd132.endcnt = uwm100.endcnt 
   NO-LOCK NO-ERROR.
   REPEAT WHILE avail uwd132:
        IF uwd132.bencod = 'COMP' OR uwd132.bencod = 'COMG' OR
           uwd132.bencod = 'COMH'  THEN DO:
           n_prmcom   =  n_prmcom + uwd132.prem_c.
 
           n_stp      =  (uwd132.prem_c  *  0.4) / 100.
   
           IF n_stp - TRUNCATE(n_stp,0)  <> 0 then n_stp = TRUNCATE(n_stp,0) + 1.
           n_tstpcom  =  n_tstpcom + n_stp.
           n_taxcom   =  (n_prmcom + n_tstpcom) * uwm100.gstrat / 100.
        END.
        IF uwd132.bencod = "PA" THEN DO:
           n_paprm = n_paprm + uwd132.prem_c.
           n_stppa = (uwd132.prem_c  *  0.4) / 100.
   
           IF n_stppa - TRUNCATE(n_stppa,0)  <> 0 then n_stppa = TRUNCATE(n_stppa,0) + 1.
           n_tstppa = n_tstppa + n_stppa.
           n_taxpa = (n_paprm + n_tstppa) * uwm100.gstrat / 100.
        END.
        
        FIND NEXT uwd132 USE-INDEX uwd13290   WHERE
                  uwd132.policy = uwm100.policy AND
                  uwd132.rencnt = uwm100.rencnt AND
                  uwd132.endcnt = uwm100.endcnt 
        NO-LOCK NO-ERROR.
   END.
   
   ASSIGN
       n_prmt    = 0        n_prms    = 0
       n_prmq    = 0        n_prmtfp  = 0
       n_prmrq   = 0        n_prmf1   = 0
       n_prmf2   = 0        n_prmr    = 0
       n_prmps   = 0        n_prmbtr  = 0
       n_prmotr  = 0        n_prms8   = 0
       n_prmf4   = 0        n_prmftr  = 0.

   LOOPB:
   REPEAT:
      n_cnt1  = n_cnt1 + 1.
      s_recid = RECID(uwm200).
      ASSIGN
          n_prmt    = 0        n_prms    = 0 
          n_prmq    = 0        n_prmtfp  = 0 
          n_prmrq   = 0        n_prmf1   = 0 
          n_prmf2   = 0        n_prmr    = 0 
          n_prmps   = 0        n_prmbtr  = 0 
          n_prmotr  = 0        n_prms8   = 0
          n_prmf4   = 0        n_prmftr  = 0 .

      IF UWM100.TRANTY <> "C" THEN DO:
         RUN Pd_Process1.
      END.
      ELSE DO:
         RUN Pd_Process2.
      END.

      FIND NEXT uwm200  USE-INDEX  uwm20001  WHERE
                uwm200.policy = uwm100.policy  AND
                uwm200.rencnt = uwm100.rencnt  AND
                uwm200.endcnt = uwm100.endcnt  NO-LOCK NO-ERROR.

      IF NOT AVAIL uwm200 THEN LEAVE loopb.
   END.   /* loopb */
   ASSIGN
        n_prmf1      =   n_prmf1     * (-1)
        n_prmf2      =   n_prmf2     * (-1)
        n_prmt       =   n_prmt      * (-1)
        n_prms       =   n_prms      * (-1)
        n_prmq       =   n_prmq      * (-1)
        n_prmtfp     =   n_prmtfp    * (-1)
        n_prmrq      =   n_prmrq     * (-1)
        n_prmps      =   n_prmps     * (-1)  
        n_prmbtr     =   n_prmbtr    * (-1)  
        n_prmotr     =   n_prmotr    * (-1)  
        n_prms8      =   n_prms8     * (-1)  

        n_prmf4      =   n_prmf4     * (-1)  
        n_prmftr     =   n_prmftr    * (-1).
   
   RUN Pd_detailMotor.
   
   ASSIGN
        nv_sum    = 0 
        p_t       = 000  n_sumt     = 0   n_prmt    = 0
        p_s       = 000  n_sums     = 0   n_prms    = 0
        p_q       = 000  n_sumq     = 0   n_prmq    = 0
        p_tfp     = 000  n_sumtfp   = 0   n_prmtfp  = 0
        p_rq      = 000  n_sumrq    = 0   n_prmrq   = 0
        p_f1      = 000  n_sumf1    = 0   n_prmf1   = 0
        p_f2      = 000  n_sumf2    = 0   n_prmf2   = 0
        p_r       = 000  n_sumr     = 0   n_prmr    = 0
        p_ps      = 000  n_sumps    = 0   n_prmps   = 0  
        p_btr     = 000  n_sumbtr   = 0   n_prmbtr  = 0  
        p_otr     = 000  n_sumotr   = 0   n_prmotr  = 0  
        p_s8      = 000  n_sums8    = 0   n_prms8   = 0  
                                    
        p_f4      = 000  n_sumf4    = 0   n_prmf4   = 0
        p_ftr     = 000  n_sumftr   = 0   n_prmftr  = 0
        n_rb_pf   = 000  n_rb_sum   = 0   n_rb_prm  = 0
        n_rf_pf   = 000  n_rf_sum   = 0   n_rf_prm  = 0
        nv_prmtre = 0 .

IF LAST-OF(uwm100.poltyp) THEN DO:
        
       ASSIGN
          pv_f1_prb   = pv_f1_prb   * (-1)      iv_f1_prb   = iv_f1_prb   * (-1)
          pv_f2_prb   = pv_f2_prb   * (-1)      iv_f2_prb   = iv_f2_prb   * (-1)
          pv_0t_prb   = pv_0t_prb   * (-1)      iv_0t_prb   = iv_0t_prb   * (-1)
          pv_0s_prb   = pv_0s_prb   * (-1)      iv_0s_prb   = iv_0s_prb   * (-1)
          pv_stat_prb = pv_stat_prb * (-1)      iv_stat_prb = iv_stat_prb * (-1)
          pv_0q_prb   = pv_0q_prb   * (-1)      iv_0q_prb   = iv_0q_prb   * (-1)
          pv_0rq_prb  = pv_0rq_prb  * (-1)      iv_0rq_prb  = iv_0rq_prb  * (-1)
          pv_0f_prb   = pv_0f_prb   * (-1)      iv_0f_prb   = iv_0f_prb   * (-1)
          nv_f1_prb   = nv_f1_prb   * (-1)      nv_f2_prb   = nv_f2_prb   * (-1)
          nv_0t_prb   = nv_0t_prb   * (-1)      nv_0s_prb   = nv_0s_prb   * (-1)
          nv_stat_prb = nv_stat_prb * (-1)      nv_0q_prb   = nv_0q_prb   * (-1)
          nv_0rq_prb  = nv_0rq_prb  * (-1)      nv_0f_prb   = nv_0f_prb   * (-1)
          pv_s8_prb   = pv_s8_prb   * (-1)      iv_s8_prb   = iv_s8_prb   * (-1)

          nv_0ps_prb  = nv_0ps_prb  * (-1)
          pv_0ps_prb  = pv_0ps_prb  * (-1)      iv_0ps_prb   = iv_0ps_prb   * (-1)
          
          nv_btr_prb  = nv_btr_prb  * (-1)
          pv_btr_prb  = pv_btr_prb  * (-1)      iv_btr_prb   = iv_btr_prb   * (-1)
          nv_otr_prb  = nv_otr_prb  * (-1)
          pv_otr_prb  = pv_otr_prb  * (-1)      iv_otr_prb   = iv_otr_prb   * (-1)

          nv_f4_prb   = nv_f4_prb   * (-1)
          pv_f4_prb   = pv_f4_prb   * (-1)      iv_f4_prb    = iv_f4_prb    * (-1)
          nv_ftr_prb  = nv_ftr_prb  * (-1)
          pv_ftr_prb  = pv_ftr_prb  * (-1)      iv_ftr_prb   = iv_ftr_prb   * (-1).
          
     FIND FIRST wtotal WHERE wtotal.poltyp = SUBSTR(uwm100.poltyp,2,2) NO-LOCK NO-ERROR.
          IF NOT AVAIL wtotal THEN DO:
              CREATE wtotal.
              ASSIGN 
                  wtotal.poltyp    = SUBSTR(uwm100.poltyp,2,2)
                  wtotal.totprmcom = nv_totprmcom 
                  wtotal.totsumprm = nv_totsumprm 
                  wtotal.totearn   = nv_totearn   
                  wtotal.totuearn  = nv_totuearn  
                  wtotal.totearn1  = nv_totearn1  
                  wtotal.totuearn1 = nv_totuearn1 
                   /* comment by Benjaporn J. A58-0242
                  wtotal.totprmtre = nv_totprmtre 
                  wtotal.totearn2  = nv_totearn2  
                  wtotal.totuearn2 = nv_totuearn2 */
                  /* start A58-0242 Benjaporn J. 13/07/2015 */
                  wtotal.totprmtrt   = nv_totprmtrt 
                  wtotal.totearntrt  = nv_totearntrt  
                  wtotal.totuearntrt = nv_totuearntrt
                  wtotal.totprmfac   = nv_totprmfac
                  wtotal.totearnfac  = nv_totearnfac  
                  wtotal.totuearnfac = nv_totuearnfac. /* end A58-0242 Benjaporn J. 13/07/2015 */
          END.

          ASSIGN
              nv_totprmcom    = 0    nv_totsumprm = 0
              nv_totearn      = 0    nv_totuearn  = 0
              nv_totearn1     = 0    nv_totuearn1 = 0
              nv_totprmtrt    = 0 
              nv_totearntrt   = 0 
              nv_totuearntrt  = 0 
              nv_totprmfac    = 0 
              nv_totearnfac   = 0 
              nv_totuearnfac  = 0  .
           /* comment by Benjaporn J. A58-0242
              nv_totprmtre = 0    nv_totearn2  = 0
              nv_totuearn2 = 0 */
   END.
END.

PUT STREAM ns1
    "Grand Total"   SKIP.

loopmain1:
FOR EACH wtotal BREAK BY wtotal.poltyp.

    FIND xmm031 USE-INDEX xmm03101       WHERE 
         xmm031.poltyp = wtotal.poltyp   NO-LOCK NO-ERROR.
    IF AVAIL xmm031 THEN DO:

       IF xmm031.dept <> "G" AND xmm031.dept <> "M" THEN NEXT loopmain1.
       IF LOOKUP(xmm031.poltyp,nv_poltyp) <> 0  THEN NEXT loopmain1.

    END.
    
    IF wtotal.totprmcom = 0 AND wtotal.totsumprm = 0 AND
       wtotal.totearn   = 0 AND wtotal.totuearn  = 0 AND
       wtotal.totearn1  = 0 AND wtotal.totuearn1 = 0 AND
         /* comment by Benjaporn J. A58-0242
       wtotal.totearn2  = 0 AND wtotal.totuearn2 = 0 THEN DO: */
        /* start A58-0242 Benjaporn J. 13/07/2015 */
       wtotal.totearntrt  = 0 AND wtotal.totuearntrt = 0 AND 
       wtotal.totearnfac  = 0 AND wtotal.totuearnfac = 0 THEN DO: /* end A58-0242 Benjaporn J. 13/07/2015 */

    END.
    ELSE DO:
        PUT STREAM ns1
            "Line  " wtotal.poltyp "|" "|" "|" "|" "|" "|" "|" "|" "|" "|"
            wtotal.totprmcom "|"
            wtotal.totsumprm "|"
            wtotal.totearn   "|"
            wtotal.totuearn  "|"
            wtotal.totearn1  "|"
            wtotal.totuearn1 "|"
             /* comment by Benjaporn J. A58-0242
            wtotal.totprmtre "|"
            wtotal.totearn2  "|"
            wtotal.totuearn2 "|"  */
            /* start A58-0242 Benjaporn J. 13/07/2015 */
            wtotal.totprmtrt   "|"
            wtotal.totearntrt  "|"
            wtotal.totuearntrt "|"
            wtotal.totprmfac   "|"
            wtotal.totearnfac  "|"
            wtotal.totuearnfac SKIP. /* end A58-0242 Benjaporn J. 13/07/2015 */
    END.
END.
/*---A56-0092---*/
PUT STREAM ns3
    "Cancel - Grand Total"  "|" "|" "|" "|" "|" "|" "|" "|" "|" "|"
    nv_ctotprmcom "|" 
    nv_ctotsumprm "|" 
    nv_ctotearn   "|" 
    nv_ctotuearn  "|" 
    nv_ctotearn1  "|" 
    nv_ctotuearn1 "|"
     /* comment by Benjaporn J. A58-0242
    nv_ctotprmtre "|" 
    nv_ctotearn2  "|" 
    nv_ctotuearn2 "|" */
    /* start A58-0242 Benjaporn J. 13/07/2015 */
    nv_ctotprmtrt   "|" 
    nv_ctotearntrt  "|" 
    nv_ctotuearntrt "|" 
    nv_ctotprmfac   "|" 
    nv_ctotearnfac  "|" 
    nv_ctotuearnfac SKIP. /*--end A56-0092---*/    /* end A58-0242 Benjaporn J. 13/07/2015 */

OUTPUT STREAM ns1 CLOSE.
OUTPUT STREAM ns2 CLOSE.
OUTPUT STREAM ns3 CLOSE.    /*A56-0092*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pd_Nonmotor C-Win 
PROCEDURE Pd_Nonmotor :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH wrk0f.
    DELETE wrk0f.
END.
FOR EACH wtotal.
    DELETE wtotal.
END.
RUN Pd_Checkbranch.

ASSIGN
    n_rec    = 1
    n_rec1   = 1
    n_rec2   = 1   /*A56-0092*/
    nv_count = 0
    n_count  = 0
    n_count1 = 0   /*A56-0092*/
    nv_poltyp = "" .
FOR EACH wfline NO-LOCK.
    ASSIGN nv_poltyp = trim(nv_poltyp +  "," + wfline.nline) .
END.

/*   loopmain:
FOR EACH uwm100 NO-LOCK USE-INDEX uwm10092 WHERE 
         uwm100.expdat  >=  fi_asdate               AND  
         uwm100.agent   >=  fi_agentfr              AND
         uwm100.agent   <=  fi_agentto              AND
         uwm100.trndat  <=  fi_asdate               AND 
  INDEX( nv_brdes, "," + TRIM(uwm100.branch)) <> 0  AND
      (( fi_releas = "Y"  AND UWM100.RELEAS = YES ) OR
       ( fi_releas = "N"  AND UWM100.RELEAS = NO  ) OR
       ( fi_releas = "A"))  BREAK BY uwm100.poltyp 
                                  /*BY uwm100.branch */
                                  BY uwm100.policy
                                  /*BY uwm100.endno
                                  BY uwm100.trndat
                                  BY uwm100.tranty*/ .   */
loopmain:
FOR EACH uwm100 NO-LOCK USE-INDEX uwm10008 WHERE 
    uwm100.trndat  >=  fi_trndat      AND
    uwm100.trndat  <=  fi_trndatto    AND
    uwm100.expdat  >=  fi_asdate      AND 
    uwm100.agent   >=  fi_agentfr     AND
    uwm100.agent   <=  fi_agentto     AND
    uwm100.branch  >=  fi_branchfr    AND
    uwm100.branch  <=  fi_branchto    AND
    UWM100.RELEAS   =  nv_releas
    BREAK BY uwm100.poltyp 
          BY uwm100.policy  .

   fi_etime = STRING(TIME,"HH:MM:SS"). /*Lukkana M. A55-0144 25/04/2012*/
   n_bran   = "".
   n_bran   = uwm100.branch.
   DISP fi_stime fi_etime WITH FRAME fr_main. /*Lukkana M. A55-0144 25/04/2012*/
   
   IF SUBSTR(uwm100.policy,1,1) = "I" THEN DO:

         IF nv_brdes1 = ""  THEN NEXT loopmain.
         IF INDEX(nv_brdes1,",9" + SUBSTRING(uwm100.policy,2,1)) <> 0 THEN 
             n_bran = "9" + SUBSTRING(uwm100.policy,2,1). 
   END.
   ELSE  DO:    
         IF INDEX("ABCDEFGHIJKLMNOPQRSTUVWXYZ" , fi_branchto) <> 0  THEN DO: /*พบตัวอักษรในbranch*/
            IF uwm100.branch < fi_branchfr OR uwm100.branch > fi_branchto THEN NEXT loopmain.
         END.
         ELSE DO:
            IF INTEGER(uwm100.branch) < nv_brn_fr OR INTEGER(uwm100.branch) > nv_brn_to THEN NEXT loopmain.
         END.
   END.  

   /*A58-0180     ASSIGN
       nv_poltyp = ""
       nv_poltyp = fi_exc1  + "," + fi_exc2  + "," + fi_exc3  + "," + fi_exc4  + "," + fi_exc5  + "," +
                   fi_exc6  + "," + fi_exc7  + "," + fi_exc8  + "," + fi_exc9  + "," + fi_exc10 + "," +
                   fi_exc11 + "," + fi_exc12 + "," + fi_exc13 + "," + fi_exc14 + "," + fi_exc15 + "," +
                   fi_exc16 + "," + fi_exc17 + "," + fi_exc18 + "," + fi_exc19 + "," + fi_exc20.    A58-0180*/

   FIND xmm031 USE-INDEX xmm03101       WHERE 
        xmm031.poltyp = uwm100.poltyp   NO-LOCK NO-ERROR.
   IF AVAIL xmm031 THEN DO:
       IF xmm031.dept = "G" OR xmm031.dept = "M" THEN NEXT loopmain.
       IF LOOKUP(xmm031.poltyp,nv_poltyp) <> 0  THEN NEXT loopmain.
   END.
   
   /*nv_count  = nv_count + 1 .*/
   //*------A63-0159----Change from 65000 to 1000000 --*/ 
   IF nv_count > 1000000 THEN DO:
       nv_output = (fi_output  + "_" + STRING(n_rec)) .
       RUN Pd_HeaderNon.
       n_rec = n_rec + 1.
       nv_count = 0.
   END.

   IF n_count > 1000000 THEN DO:
       nv_output1 = (fi_output  + "_error" + "_" + STRING(n_rec1)) .
       RUN Pd_HeaderNonerror.
       n_rec1 = n_rec1 + 1.
       n_count = 0.
   END.

   IF n_count1 > 1000000 THEN DO:
       nv_output2 = (fi_output  + "_can" + "_" + STRING(n_rec2)) .
       RUN Pd_HeaderNonCan.
       n_rec2 = n_rec2 + 1.
       n_count1 = 0.
   END.
   /*-------------A63-0159---------*/
   
   IF FIRST-OF(uwm100.poltyp)   THEN do: 
       
       RUN Pd_Cleartreaty.
   END.         

   DISPLAY  uwm100.trndat  uwm100.policy  WITH NO-LABEL TITLE "Process Report..."
       FRAME a1 VIEW-AS DIALOG-BOX.

   FIND xmm023 USE-INDEX xmm02301 WHERE
        xmm023.branch = n_bran    NO-LOCK NO-ERROR.
   IF NOT AVAIL xmm023 THEN NEXT loopmain.
   n_branch = n_bran.
   n_bdes   = xmm023.bdes.

   IF uwm100.DIR_ri = YES THEN nv_dir = 'D'.
   ELSE nv_dir = 'I'.

   n_endcnt = uwm100.endcnt - 1.

   ASSIGN
       nv_prstp  = 0       n_prmcom   = 0
       nv_prtax  = 0       n_stp      = 0
       nv_sumpts = 0       n_tstpcom  = 0
       n_sumprm  = 0       n_taxcom   = 0
       n_sumstp  = 0       n_stptrunc = 0
       n_sumtax  = 0       n_stpcom   = 0
       nu_tax    = 0       n_ttaxcom  = 0
       nu_prm    = 0       n_paprm    = 0
       nu_vat    = 0       n_stppa    = 0
       nv_sum    = 0       n_tstppa   = 0
       n_an      = 0       n_taxpa    = 0
       nvexch    = 1       nv_prmtre  = 0 .

   FIND FIRST uwm130 USE-INDEX uwm13001   WHERE
              uwm130.policy = uwm100.policy AND
              uwm130.rencnt = uwm100.rencnt AND
              uwm130.endcnt = uwm100.endcnt 
   NO-LOCK NO-ERROR.
   REPEAT WHILE avail uwm130:
        IF    uwm100.poltyp  = "V70"  THEN
              nv_sum  = nv_sum + uwm130.uom6_v.
        ELSE  nv_sum  = nv_sum + uwm130.uom9_v.
        FIND NEXT uwm130 USE-INDEX uwm13001   WHERE
                  uwm130.policy = uwm100.policy AND
                  uwm130.rencnt = uwm100.rencnt AND
                  uwm130.endcnt = uwm100.endcnt    NO-LOCK NO-ERROR.
   END. 

   FIND FIRST uwm200 USE-INDEX uwm20001 WHERE
              uwm200.policy = UWM100.POLICY  AND
              uwm200.rencnt = uwm100.rencnt  AND
              uwm200.endcnt = uwm100.endcnt  AND
              uwm200.csftq  <> "C"       NO-LOCK NO-ERROR.
   
   FIND FIRST uwm120 USE-INDEX uwm12001 WHERE
              uwm120.policy = uwm100.policy  AND
              uwm120.rencnt = uwm100.rencnt  AND
              uwm120.endcnt = uwm100.endcnt   NO-LOCK NO-ERROR.
        nvexch = 1.
   IF AVAIL uwm120 THEN DO:
     IF SUBSTRING(uwm120.policy,3,2) = "90" THEN nvexch = 1.
     ELSE nvexch = uwm120.siexch.
   END.
   
   n_an = nv_sum * nvexch.
   FIND FIRST uwd132 USE-INDEX uwd13290   WHERE
              uwd132.policy = uwm100.policy AND
              uwd132.rencnt = uwm100.rencnt AND
              uwd132.endcnt = uwm100.endcnt
   NO-LOCK NO-ERROR.
   REPEAT WHILE avail uwd132:
        IF uwd132.bencod = 'COMP' OR uwd132.bencod = 'COMG' OR
           uwd132.bencod = 'COMH'  THEN DO:
           n_prmcom   =  n_prmcom + uwd132.prem_c.
 
           n_stp      =  (uwd132.prem_c  *  0.4) / 100.
   
           IF n_stp - TRUNCATE(n_stp,0)  <> 0 then n_stp = TRUNCATE(n_stp,0) + 1.
           n_tstpcom  =  n_tstpcom + n_stp.
           n_taxcom   =  (n_prmcom + n_tstpcom) * uwm100.gstrat / 100.
        END.
        IF uwd132.bencod = "PA" THEN DO:
           n_paprm = n_paprm + uwd132.prem_c.
           n_stppa = (uwd132.prem_c  *  0.4) / 100.
   
           IF n_stppa - TRUNCATE(n_stppa,0)  <> 0 then n_stppa = TRUNCATE(n_stppa,0) + 1.
           n_tstppa = n_tstppa + n_stppa.
           n_taxpa = (n_paprm + n_tstppa) * uwm100.gstrat / 100.
        END.
        
        FIND NEXT uwd132 USE-INDEX uwd13290   WHERE
                  uwd132.policy = uwm100.policy AND
                  uwd132.rencnt = uwm100.rencnt AND
                  uwd132.endcnt = uwm100.endcnt  NO-LOCK NO-ERROR.
   END.
   
   ASSIGN
       n_prmt    = 0        n_prms    = 0
       n_prmq    = 0        n_prmtfp  = 0
       n_prmrq   = 0        n_prmf1   = 0
       n_prmf2   = 0        n_prmr    = 0
       n_prmps   = 0        n_prmbtr  = 0
       n_prmotr  = 0        n_prms8   = 0
       n_prmf4   = 0        n_prmftr  = 0.

   LOOPB:
   REPEAT:
      n_cnt1  = n_cnt1 + 1.
      s_recid = RECID(uwm200).

      IF UWM100.TRANTY <> "C" THEN DO:
         RUN Pd_Process1.
      END.
      ELSE DO:
         RUN Pd_Process2.
      END.

      FIND NEXT uwm200  USE-INDEX  uwm20001  WHERE
                uwm200.policy = uwm100.policy  AND
                uwm200.rencnt = uwm100.rencnt  AND
                uwm200.endcnt = uwm100.endcnt
                NO-LOCK NO-ERROR.
      IF NOT AVAIL uwm200 THEN LEAVE loopb.
   END.   /* loopb */
   
   ASSIGN
        n_prmf1      =   n_prmf1     * (-1)
        n_prmf2      =   n_prmf2     * (-1)
        n_prmt       =   n_prmt      * (-1)
        n_prms       =   n_prms      * (-1)
        n_prmq       =   n_prmq      * (-1)
        n_prmtfp     =   n_prmtfp    * (-1)
        n_prmrq      =   n_prmrq     * (-1)
        n_prmps      =   n_prmps     * (-1)                
        n_prmbtr     =   n_prmbtr    * (-1)                
        n_prmotr     =   n_prmotr    * (-1)                
        n_prms8      =   n_prms8     * (-1)             
        n_prmf4      =   n_prmf4     * (-1)                
        n_prmftr     =   n_prmftr    * (-1).
   
   RUN Pd_detailNon.
   
   ASSIGN
        nv_sum    = 0 
        p_t       = 000  n_sumt     = 0   n_prmt    = 0
        p_s       = 000  n_sums     = 0   n_prms    = 0
        p_q       = 000  n_sumq     = 0   n_prmq    = 0
        p_tfp     = 000  n_sumtfp   = 0   n_prmtfp  = 0
        p_rq      = 000  n_sumrq    = 0   n_prmrq   = 0
        p_f1      = 000  n_sumf1    = 0   n_prmf1   = 0
        p_f2      = 000  n_sumf2    = 0   n_prmf2   = 0
        p_r       = 000  n_sumr     = 0   n_prmr    = 0
        p_ps      = 000  n_sumps    = 0   n_prmps   = 0 
        p_btr     = 000  n_sumbtr   = 0   n_prmbtr  = 0 
        p_otr     = 000  n_sumotr   = 0   n_prmotr  = 0 
        p_s8      = 000  n_sums8    = 0   n_prms8   = 0 
        p_f4      = 000  n_sumf4    = 0   n_prmf4   = 0
        p_ftr     = 000  n_sumftr   = 0   n_prmftr  = 0
        n_rb_pf   = 000  n_rb_sum   = 0   n_rb_prm  = 0
        n_rf_pf   = 000  n_rf_sum   = 0   n_rf_prm  = 0
        nv_prmtre = 0.

IF LAST-OF(uwm100.poltyp) THEN DO:
       
       ASSIGN
          pv_f1_prb   = pv_f1_prb   * (-1)      iv_f1_prb   = iv_f1_prb   * (-1)
          pv_f2_prb   = pv_f2_prb   * (-1)      iv_f2_prb   = iv_f2_prb   * (-1)
          pv_0t_prb   = pv_0t_prb   * (-1)      iv_0t_prb   = iv_0t_prb   * (-1)
          pv_0s_prb   = pv_0s_prb   * (-1)      iv_0s_prb   = iv_0s_prb   * (-1)
          pv_stat_prb = pv_stat_prb * (-1)      iv_stat_prb = iv_stat_prb * (-1)
          pv_0q_prb   = pv_0q_prb   * (-1)      iv_0q_prb   = iv_0q_prb   * (-1)
          pv_0rq_prb  = pv_0rq_prb  * (-1)      iv_0rq_prb  = iv_0rq_prb  * (-1)
          pv_0f_prb   = pv_0f_prb   * (-1)      iv_0f_prb   = iv_0f_prb   * (-1)
          nv_f1_prb   = nv_f1_prb   * (-1)      nv_f2_prb   = nv_f2_prb   * (-1)
          nv_0t_prb   = nv_0t_prb   * (-1)      nv_0s_prb   = nv_0s_prb   * (-1)
          nv_stat_prb = nv_stat_prb * (-1)      nv_0q_prb   = nv_0q_prb   * (-1)
          nv_0rq_prb  = nv_0rq_prb  * (-1)      nv_0f_prb   = nv_0f_prb   * (-1)
          pv_s8_prb   = pv_s8_prb   * (-1)      iv_s8_prb   = iv_s8_prb   * (-1) 

          nv_0ps_prb  = nv_0ps_prb  * (-1)
          pv_0ps_prb  = pv_0ps_prb  * (-1)      iv_0ps_prb   = iv_0ps_prb   * (-1)
          
          nv_btr_prb  = nv_btr_prb  * (-1)
          pv_btr_prb  = pv_btr_prb  * (-1)      iv_btr_prb   = iv_btr_prb   * (-1)
          nv_otr_prb  = nv_otr_prb  * (-1)
          pv_otr_prb  = pv_otr_prb  * (-1)      iv_otr_prb   = iv_otr_prb   * (-1)

          nv_f4_prb   = nv_f4_prb   * (-1)
          pv_f4_prb   = pv_f4_prb   * (-1)      iv_f4_prb    = iv_f4_prb    * (-1)
          nv_ftr_prb  = nv_ftr_prb  * (-1)
          pv_ftr_prb  = pv_ftr_prb  * (-1)      iv_ftr_prb   = iv_ftr_prb   * (-1).
       
          FIND FIRST wtotal WHERE wtotal.poltyp = SUBSTR(uwm100.poltyp,2,2) NO-LOCK NO-ERROR.
          IF NOT AVAIL wtotal THEN DO:
              CREATE wtotal.
              ASSIGN 
                  wtotal.poltyp    = SUBSTR(uwm100.poltyp,2,2)
                  wtotal.totprmcom = nv_totprmcom 
                  wtotal.totearn   = nv_totearn   
                  wtotal.totuearn  = nv_totuearn
                  /* comment by Benjaporn J. A58-0242
                  wtotal.totprmtre = nv_totprmtre 
                  wtotal.totearn2  = nv_totearn2  
                  wtotal.totuearn2 = nv_totuearn2 */
                  /* start A58-0242 Benjaporn J. 13/07/2015 */
                  wtotal.totprmtrt   = nv_totprmtrt 
                  wtotal.totearntrt  = nv_totearntrt  
                  wtotal.totuearntrt = nv_totuearntrt
                  wtotal.totprmfac   = nv_totprmfac
                  wtotal.totearnfac  = nv_totearnfac  
                  wtotal.totuearnfac = nv_totuearnfac.  /* end A58-0242 Benjaporn J. 13/07/2015 */
          END.
          ASSIGN
              nv_totprmcom   = 0    
              nv_totearn     = 0    
              nv_totuearn    = 0
              nv_totprmtrt   = 0      
              nv_totearntrt  = 0     
              nv_totuearntrt = 0     
              nv_totprmfac   = 0     
              nv_totearnfac  = 0     
              nv_totuearnfac = 0    . 
          /* comment by Benjaporn J. A58-0242
              nv_totprmtre = 0    nv_totearn2  = 0
              nv_totuearn2 = 0 */ 
   END.
END.

PUT STREAM ns1
    "Grand Total"   SKIP.
loopmain1:
FOR EACH wtotal BREAK BY wtotal.poltyp.

    FIND xmm031 USE-INDEX xmm03101       WHERE 
         xmm031.poltyp = wtotal.poltyp   NO-LOCK NO-ERROR.
    IF AVAIL xmm031 THEN DO:

       IF xmm031.dept = "G" OR xmm031.dept = "M" THEN NEXT loopmain1.
       IF LOOKUP(xmm031.poltyp,nv_poltyp) <> 0  THEN NEXT loopmain1.
END.
    
    IF wtotal.totprmcom = 0 AND wtotal.totsumprm = 0 AND
       wtotal.totearn   = 0 AND wtotal.totuearn  = 0 AND
        /* comment by Benjaporn J. A58-0242
       wtotal.totearn2  = 0 AND wtotal.totuearn2 = 0 THEN DO: */
        /* start A58-0242 Benjaporn J. 13/07/2015 */
       wtotal.totearntrt  = 0 AND wtotal.totuearntrt = 0 AND
       wtotal.totearnfac  = 0 AND wtotal.totuearnfac = 0 THEN DO: /* end A58-0242 Benjaporn J. 13/07/2015 */

    END.
    ELSE DO:
        PUT STREAM ns1
            "Line  " wtotal.poltyp "|" "|" "|" "|" "|" "|" "|" "|" "|" "|"
            wtotal.totprmcom "|"
            wtotal.totearn   "|"
            wtotal.totuearn  "|"
            /* comment by Benjaporn J. A58-0242
            wtotal.totprmtre "|"
            wtotal.totearn2  "|"
            wtotal.totuearn2 "|"*/
            /* start A58-0242 Benjaporn J. 13/07/2015 */
            wtotal.totprmtrt   "|"
            wtotal.totearntrt  "|"
            wtotal.totuearntrt "|"
            wtotal.totprmfac   "|"
            wtotal.totearnfac  "|"
            wtotal.totuearnfac SKIP. /* end A58-0242 Benjaporn J. 13/07/2015 */
        END.
END.    /*---A56-0092---*/
PUT STREAM ns3
    "Cancel - Grand Total"  "|" "|" "|" "|" "|" "|" "|" "|" "|" "|"
    nv_ctotprmcom "|" 
    nv_ctotearn   "|" 
    nv_ctotuearn  "|" 
    /* comment by Benjaporn J. A58-0242
    nv_ctotprmtre "|" 
    nv_ctotearn2  "|" 
    nv_ctotuearn2 "|" */
    /* start A58-0242 Benjaporn J. 13/07/2015 */
    nv_ctotprmtrt   "|" 
    nv_ctotearntrt  "|" 
    nv_ctotuearntrt "|" 
    nv_ctotprmfac   "|" 
    nv_ctotearnfac  "|" 
    nv_ctotuearnfac SKIP.    /*--end A56-0092---*/    /* end A58-0242 Benjaporn J. 13/07/2015 */

OUTPUT STREAM ns1 CLOSE.
OUTPUT STREAM ns2 CLOSE.
OUTPUT STREAM ns3 CLOSE.    /*A56-0092*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pd_Nonmotor01 C-Win 
PROCEDURE Pd_Nonmotor01 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH wrk0f.
    DELETE wrk0f.
END.
FOR EACH wtotal.
    DELETE wtotal.
END.
RUN Pd_Checkbranch.
ASSIGN
    n_rec    = 1
    n_rec1   = 1
    n_rec2   = 1   
    nv_count = 0
    n_count  = 0
    n_count1 = 0
    nv_poltyp = "" .
FOR EACH wfline NO-LOCK.
    ASSIGN nv_poltyp = trim(nv_poltyp +  "," + wfline.nline) .
END.

loopmain:
FOR EACH uwm100 NO-LOCK USE-INDEX uwm10008 WHERE 
    uwm100.trndat  >=  fi_trndat      AND
    uwm100.trndat  <=  fi_trndatto    AND
    uwm100.expdat  >=  fi_asdate      AND 
    uwm100.agent   >=  fi_agentfr     AND
    uwm100.agent   <=  fi_agentto     AND
    uwm100.branch  >=  fi_branchfr    AND
    uwm100.branch  <=  fi_branchto    
    BREAK BY uwm100.poltyp 
          BY uwm100.policy  .
   ASSIGN fi_etime = STRING(TIME,"HH:MM:SS")   
       n_bran   = ""
       n_bran   = uwm100.branch.
   DISP fi_stime fi_etime WITH FRAME fr_main.  
   IF SUBSTR(uwm100.policy,1,1) = "I" THEN DO:
         IF nv_brdes1 = ""  THEN NEXT loopmain.
         IF INDEX(nv_brdes1,",9" + SUBSTRING(uwm100.policy,2,1)) <> 0 THEN 
             n_bran = "9" + SUBSTRING(uwm100.policy,2,1). 
   END.
   ELSE  DO:    
         IF INDEX("ABCDEFGHIJKLMNOPQRSTUVWXYZ" , fi_branchto) <> 0  THEN DO: /*พบตัวอักษรในbranch*/
            IF uwm100.branch < fi_branchfr OR uwm100.branch > fi_branchto THEN NEXT loopmain.
         END.
         ELSE DO:
            IF INTEGER(uwm100.branch) < nv_brn_fr OR INTEGER(uwm100.branch) > nv_brn_to THEN NEXT loopmain.
         END.
   END. 
   /*A58-0180
   ASSIGN
       nv_poltyp = ""
       nv_poltyp = fi_exc1  + "," + fi_exc2  + "," + fi_exc3  + "," + fi_exc4  + "," + fi_exc5  + "," +
                   fi_exc6  + "," + fi_exc7  + "," + fi_exc8  + "," + fi_exc9  + "," + fi_exc10 + "," +
                   fi_exc11 + "," + fi_exc12 + "," + fi_exc13 + "," + fi_exc14 + "," + fi_exc15 + "," +
                   fi_exc16 + "," + fi_exc17 + "," + fi_exc18 + "," + fi_exc19 + "," + fi_exc20.
   A58-0180*/

   FIND xmm031 USE-INDEX xmm03101       WHERE 
        xmm031.poltyp = uwm100.poltyp   NO-LOCK NO-ERROR.
   IF AVAIL xmm031 THEN DO:
       IF xmm031.dept = "G" OR xmm031.dept = "M" THEN NEXT loopmain.
       IF LOOKUP(xmm031.poltyp,nv_poltyp) <> 0  THEN NEXT loopmain.
   END.
   /*nv_count  = nv_count + 1 .*/
   /*------A63-0159----Change from 65000 to 1000000 --*/
   IF nv_count > 1000000 THEN DO:
       nv_output = (fi_output  + "_" + STRING(n_rec)) .
       RUN Pd_HeaderNon.
       n_rec = n_rec + 1.
       nv_count = 0.
   END.
   IF n_count > 1000000 THEN DO:
       nv_output1 = (fi_output  + "_error" + "_" + STRING(n_rec1)) .
       RUN Pd_HeaderNonerror.
       n_rec1 = n_rec1 + 1.
       n_count = 0.
   END.
   IF n_count1 > 1000000 THEN DO:
       nv_output2 = (fi_output  + "_can" + "_" + STRING(n_rec2)) .
       RUN Pd_HeaderNonCan.
       n_rec2 = n_rec2 + 1.
       n_count1 = 0.
   END.
   /*--------A63-0159--------*/

   IF FIRST-OF(uwm100.poltyp)   THEN do: 
       RUN Pd_Cleartreaty.
   END. 
   DISPLAY  uwm100.trndat  uwm100.policy  WITH NO-LABEL TITLE "Process Report..."
       FRAME a1 VIEW-AS DIALOG-BOX.
   FIND xmm023 USE-INDEX xmm02301 WHERE
        xmm023.branch = n_bran    NO-LOCK NO-ERROR.
   IF NOT AVAIL xmm023 THEN NEXT loopmain.
   n_branch = n_bran.
   n_bdes   = xmm023.bdes.
   IF uwm100.DIR_ri = YES THEN nv_dir = 'D'.
   ELSE nv_dir = 'I'.
   n_endcnt = uwm100.endcnt - 1.
   ASSIGN
       nv_prstp  = 0       n_prmcom   = 0
       nv_prtax  = 0       n_stp      = 0
       nv_sumpts = 0       n_tstpcom  = 0
       n_sumprm  = 0       n_taxcom   = 0
       n_sumstp  = 0       n_stptrunc = 0
       n_sumtax  = 0       n_stpcom   = 0
       nu_tax    = 0       n_ttaxcom  = 0
       nu_prm    = 0       n_paprm    = 0
       nu_vat    = 0       n_stppa    = 0
       nv_sum    = 0       n_tstppa   = 0
       n_an      = 0       n_taxpa    = 0
       nvexch    = 1       nv_prmtre  = 0 .
 
   FIND FIRST uwm130 USE-INDEX uwm13001   WHERE
              uwm130.policy = uwm100.policy  AND
              uwm130.rencnt = uwm100.rencnt  AND
              uwm130.endcnt = uwm100.endcnt  NO-LOCK NO-ERROR.
   REPEAT WHILE avail uwm130:
        IF    uwm100.poltyp  = "V70"  THEN
              nv_sum  = nv_sum + uwm130.uom6_v.
        ELSE  nv_sum  = nv_sum + uwm130.uom9_v.
        FIND NEXT uwm130 USE-INDEX uwm13001   WHERE
                  uwm130.policy = uwm100.policy AND
                  uwm130.rencnt = uwm100.rencnt AND
                  uwm130.endcnt = uwm100.endcnt 
        NO-LOCK NO-ERROR.
   END. 
   FIND FIRST uwm200 USE-INDEX uwm20001 WHERE
              uwm200.policy = UWM100.POLICY  AND
              uwm200.rencnt = uwm100.rencnt  AND
              uwm200.endcnt = uwm100.endcnt  AND
              uwm200.csftq  <> "C"           NO-LOCK NO-ERROR.
   FIND FIRST uwm120 USE-INDEX uwm12001 WHERE
              uwm120.policy = uwm100.policy  AND
              uwm120.rencnt = uwm100.rencnt  AND
              uwm120.endcnt = uwm100.endcnt  NO-LOCK NO-ERROR.
        nvexch = 1.
   IF AVAIL uwm120 THEN DO:
     IF SUBSTRING(uwm120.policy,3,2) = "90" THEN nvexch = 1.
     ELSE nvexch = uwm120.siexch.
   END.
   n_an = nv_sum * nvexch.
   FIND FIRST uwd132 USE-INDEX uwd13290   WHERE
              uwd132.policy = uwm100.policy  AND
              uwd132.rencnt = uwm100.rencnt  AND
              uwd132.endcnt = uwm100.endcnt  NO-LOCK NO-ERROR.
   REPEAT WHILE avail uwd132:
        IF uwd132.bencod = 'COMP' OR uwd132.bencod = 'COMG' OR
           uwd132.bencod = 'COMH'  THEN DO:
           n_prmcom   =  n_prmcom + uwd132.prem_c.
           n_stp      =  (uwd132.prem_c  *  0.4) / 100.
           IF n_stp - TRUNCATE(n_stp,0)  <> 0 then n_stp = TRUNCATE(n_stp,0) + 1.
           n_tstpcom  =  n_tstpcom + n_stp.
           n_taxcom   =  (n_prmcom + n_tstpcom) * uwm100.gstrat / 100.
        END.
        IF uwd132.bencod = "PA" THEN DO:
           n_paprm = n_paprm + uwd132.prem_c.
           n_stppa = (uwd132.prem_c  *  0.4) / 100.
           IF n_stppa - TRUNCATE(n_stppa,0)  <> 0 then n_stppa = TRUNCATE(n_stppa,0) + 1.
           n_tstppa = n_tstppa + n_stppa.
           n_taxpa = (n_paprm + n_tstppa) * uwm100.gstrat / 100.
        END.
        FIND NEXT uwd132 USE-INDEX uwd13290   WHERE
                  uwd132.policy = uwm100.policy AND
                  uwd132.rencnt = uwm100.rencnt AND
                  uwd132.endcnt = uwm100.endcnt NO-LOCK NO-ERROR.
   END.
   ASSIGN
       n_prmt    = 0        n_prms    = 0
       n_prmq    = 0        n_prmtfp  = 0
       n_prmrq   = 0        n_prmf1   = 0
       n_prmf2   = 0        n_prmr    = 0
       n_prmps   = 0        n_prmbtr  = 0
       n_prmotr  = 0        n_prms8   = 0
       n_prmf4   = 0        n_prmftr  = 0.
   LOOPB:
   REPEAT:
      n_cnt1  = n_cnt1 + 1.
      s_recid = RECID(uwm200).
      IF UWM100.TRANTY <> "C" THEN DO:
         RUN Pd_Process1.
      END.
      ELSE DO:
         RUN Pd_Process2.
      END.
      FIND NEXT uwm200  USE-INDEX  uwm20001  WHERE
                uwm200.policy = uwm100.policy  AND
                uwm200.rencnt = uwm100.rencnt  AND
                uwm200.endcnt = uwm100.endcnt  NO-LOCK NO-ERROR.
      IF NOT AVAIL uwm200 THEN LEAVE loopb.
   END.   /* loopb */
   ASSIGN
        n_prmf1      =   n_prmf1     * (-1)
        n_prmf2      =   n_prmf2     * (-1)
        n_prmt       =   n_prmt      * (-1)
        n_prms       =   n_prms      * (-1)
        n_prmq       =   n_prmq      * (-1)
        n_prmtfp     =   n_prmtfp    * (-1)
        n_prmrq      =   n_prmrq     * (-1)
        n_prmps      =   n_prmps     * (-1)                
        n_prmbtr     =   n_prmbtr    * (-1)                
        n_prmotr     =   n_prmotr    * (-1)                
        n_prms8      =   n_prms8     * (-1)             
        n_prmf4      =   n_prmf4     * (-1)                
        n_prmftr     =   n_prmftr    * (-1).

   RUN Pd_detailNon.

   ASSIGN
        nv_sum    = 0 
        p_t       = 000  n_sumt     = 0   n_prmt    = 0
        p_s       = 000  n_sums     = 0   n_prms    = 0
        p_q       = 000  n_sumq     = 0   n_prmq    = 0
        p_tfp     = 000  n_sumtfp   = 0   n_prmtfp  = 0
        p_rq      = 000  n_sumrq    = 0   n_prmrq   = 0
        p_f1      = 000  n_sumf1    = 0   n_prmf1   = 0
        p_f2      = 000  n_sumf2    = 0   n_prmf2   = 0
        p_r       = 000  n_sumr     = 0   n_prmr    = 0
        p_ps      = 000  n_sumps    = 0   n_prmps   = 0 
        p_btr     = 000  n_sumbtr   = 0   n_prmbtr  = 0 
        p_otr     = 000  n_sumotr   = 0   n_prmotr  = 0 
        p_s8      = 000  n_sums8    = 0   n_prms8   = 0 
        p_f4      = 000  n_sumf4    = 0   n_prmf4   = 0
        p_ftr     = 000  n_sumftr   = 0   n_prmftr  = 0
        n_rb_pf   = 000  n_rb_sum   = 0   n_rb_prm  = 0
        n_rf_pf   = 000  n_rf_sum   = 0   n_rf_prm  = 0
        nv_prmtre = 0 .

   IF LAST-OF(uwm100.poltyp) THEN DO:
       ASSIGN
          pv_f1_prb   = pv_f1_prb   * (-1)      iv_f1_prb   = iv_f1_prb   * (-1)
          pv_f2_prb   = pv_f2_prb   * (-1)      iv_f2_prb   = iv_f2_prb   * (-1)
          pv_0t_prb   = pv_0t_prb   * (-1)      iv_0t_prb   = iv_0t_prb   * (-1)
          pv_0s_prb   = pv_0s_prb   * (-1)      iv_0s_prb   = iv_0s_prb   * (-1)
          pv_stat_prb = pv_stat_prb * (-1)      iv_stat_prb = iv_stat_prb * (-1)
          pv_0q_prb   = pv_0q_prb   * (-1)      iv_0q_prb   = iv_0q_prb   * (-1)
          pv_0rq_prb  = pv_0rq_prb  * (-1)      iv_0rq_prb  = iv_0rq_prb  * (-1)
          pv_0f_prb   = pv_0f_prb   * (-1)      iv_0f_prb   = iv_0f_prb   * (-1)
          nv_f1_prb   = nv_f1_prb   * (-1)      nv_f2_prb   = nv_f2_prb   * (-1)
          nv_0t_prb   = nv_0t_prb   * (-1)      nv_0s_prb   = nv_0s_prb   * (-1)
          nv_stat_prb = nv_stat_prb * (-1)      nv_0q_prb   = nv_0q_prb   * (-1)
          nv_0rq_prb  = nv_0rq_prb  * (-1)      nv_0f_prb   = nv_0f_prb   * (-1)
          pv_s8_prb   = pv_s8_prb   * (-1)      iv_s8_prb   = iv_s8_prb   * (-1) 
          nv_0ps_prb  = nv_0ps_prb  * (-1)
          pv_0ps_prb  = pv_0ps_prb  * (-1)      iv_0ps_prb   = iv_0ps_prb   * (-1)
          nv_btr_prb  = nv_btr_prb  * (-1)
          pv_btr_prb  = pv_btr_prb  * (-1)      iv_btr_prb   = iv_btr_prb   * (-1)
          nv_otr_prb  = nv_otr_prb  * (-1)
          pv_otr_prb  = pv_otr_prb  * (-1)      iv_otr_prb   = iv_otr_prb   * (-1)
          nv_f4_prb   = nv_f4_prb   * (-1)
          pv_f4_prb   = pv_f4_prb   * (-1)      iv_f4_prb    = iv_f4_prb    * (-1)
          nv_ftr_prb  = nv_ftr_prb  * (-1)
          pv_ftr_prb  = pv_ftr_prb  * (-1)      iv_ftr_prb   = iv_ftr_prb   * (-1).
          
       FIND FIRST wtotal WHERE wtotal.poltyp = SUBSTR(uwm100.poltyp,2,2) NO-LOCK NO-ERROR.
          IF NOT AVAIL wtotal THEN DO:
              CREATE wtotal.
              ASSIGN  wtotal.poltyp    = SUBSTR(uwm100.poltyp,2,2)
                      wtotal.totprmcom = nv_totprmcom 
                      wtotal.totearn   = nv_totearn   
                      wtotal.totuearn  = nv_totuearn 
                  /* comment by Benjaporn J. A58-0242
                      wtotal.totprmtre = nv_totprmtre 
                      wtotal.totearn2  = nv_totearn2  
                      wtotal.totuearn2 = nv_totuearn2 */
                  /* start A58-0242 Benjaporn J. 13/07/2015 */
                      wtotal.totprmtrt   = nv_totprmtrt 
                      wtotal.totearntrt  = nv_totearntrt  
                      wtotal.totuearntrt = nv_totuearntrt
                      wtotal.totprmfac   = nv_totprmfac
                      wtotal.totearnfac  = nv_totearnfac  
                      wtotal.totuearnfac = nv_totuearnfac. /* end A58-0242 Benjaporn J. 13/07/2015 */
             END.
         ASSIGN
              nv_totprmcom   = 0    
              nv_totearn     = 0    
              nv_totuearn    = 0
              nv_totprmtrt   = 0      
              nv_totearntrt  = 0     
              nv_totuearntrt = 0     
              nv_totprmfac   = 0     
              nv_totearnfac  = 0     
              nv_totuearnfac = 0 . 
          /* comment by Benjaporn J. A58-0242
              nv_totprmtre = 0    nv_totearn2  = 0
              nv_totuearn2 = 0  */
   END.
END.
PUT STREAM ns1
    "Grand Total"   SKIP.
loopmain1:
FOR EACH wtotal BREAK BY wtotal.poltyp.
    FIND xmm031 USE-INDEX xmm03101       WHERE 
         xmm031.poltyp = wtotal.poltyp   NO-LOCK NO-ERROR.
    IF AVAIL xmm031 THEN DO:
       IF xmm031.dept = "G" OR xmm031.dept = "M" THEN NEXT loopmain1.
       IF LOOKUP(xmm031.poltyp,nv_poltyp) <> 0   THEN NEXT loopmain1.
    END.
    IF wtotal.totprmcom = 0 AND wtotal.totsumprm = 0 AND
       wtotal.totearn   = 0 AND wtotal.totuearn  = 0 AND
        /* comment by Benjaporn J. A58-0242
       wtotal.totearn2  = 0 AND wtotal.totuearn2 = 0 THEN DO: */
        /* start A58-0242 Benjaporn J. 13/07/2015 */
       wtotal.totearntrt  = 0 AND wtotal.totuearntrt = 0 AND
       wtotal.totearnfac  = 0 AND wtotal.totuearnfac = 0 THEN DO: /* end A58-0242 Benjaporn J. 13/07/2015 */
    END.
    ELSE DO:
        PUT STREAM ns1
            "Line  " wtotal.poltyp "|" "|" "|" "|" "|" "|" "|" "|" "|" "|"
            wtotal.totprmcom "|"
            wtotal.totearn   "|"
            wtotal.totuearn  "|"
            /* comment by Benjaporn J. A58-0242
            wtotal.totprmtre "|"
            wtotal.totearn2  "|"
            wtotal.totuearn2 "|" */
            /* start A58-0242 Benjaporn J. 13/07/2015 */
            wtotal.totprmtrt   "|"
            wtotal.totearntrt  "|"
            wtotal.totuearntrt "|"
            wtotal.totprmfac   "|"
            wtotal.totearnfac  "|"
            wtotal.totuearnfac SKIP. /* end A58-0242 Benjaporn J. 13/07/2015 */
    END.
END.  
PUT STREAM ns3
    "Cancel - Grand Total"  "|" "|" "|" "|" "|" "|" "|" "|" "|" "|"
    nv_ctotprmcom "|" 
    nv_ctotearn   "|" 
    nv_ctotuearn  "|" 
    /* comment by Benjaporn J. A58-0242
    nv_ctotprmtre "|" 
    nv_ctotearn2  "|" 
    nv_ctotuearn2 "|" */
    /* start A58-0242 Benjaporn J. 13/07/2015 */
    nv_ctotprmtrt   "|" 
    nv_ctotearntrt  "|" 
    nv_ctotuearntrt "|" 
    nv_ctotprmfac   "|" 
    nv_ctotearnfac  "|" 
    nv_ctotuearnfac SKIP.  /* end A58-0242 Benjaporn J. 13/07/2015 */

OUTPUT STREAM ns1 CLOSE.
OUTPUT STREAM ns2 CLOSE.
OUTPUT STREAM ns3 CLOSE.   
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pd_NonmotorNZI C-Win 
PROCEDURE Pd_NonmotorNZI :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH wrk0f.
    DELETE wrk0f.
END.
FOR EACH wtotal.
    DELETE wtotal.
END.

ASSIGN
    n_rec    = 1
    n_rec1   = 1
    n_rec2   = 1   /*A56-0092*/
    nv_count = 0
    n_count  = 0
    n_count1 = 0   /*A56-0092*/
    nv_poltyp = "" .
FOR EACH wfline NO-LOCK.
    ASSIGN nv_poltyp = trim(nv_poltyp +  "," + wfline.nline) .
END.

loopmain:
FOR EACH uwm100 NO-LOCK USE-INDEX uwm10092 WHERE 
         uwm100.expdat  >=  fi_asdate               AND  
         uwm100.agent   >=  fi_agentfr              AND
         uwm100.agent   <=  fi_agentto              AND
       /*uwm100.trndat  <=  fi_asdate               AND */
         uwm100.trndat  <=  fi_trndatto             AND    /* A58-0242 Benjaporn J. 13/07/2015 */
         uwm100.branch  >=  fi_branchfr             AND
         uwm100.branch  <=  fi_branchto             AND
      (( fi_releas = "Y"  AND UWM100.RELEAS = YES ) OR
       ( fi_releas = "N"  AND UWM100.RELEAS = NO  ) OR
       ( fi_releas = "A"))  BREAK BY uwm100.poltyp 
                                  /*BY uwm100.branch */
                                  BY uwm100.policy
                                  /*BY uwm100.endno
                                  BY uwm100.trndat
                                  BY uwm100.tranty*/ .

   fi_etime = STRING(TIME,"HH:MM:SS"). /*Lukkana M. A55-0144 25/04/2012*/
   n_bran   = "".
   n_bran   = uwm100.branch.
   DISP fi_stime fi_etime WITH FRAME fr_main. /*Lukkana M. A55-0144 25/04/2012*/
   
   /*a58-0180
   ASSIGN
       nv_poltyp = ""
       nv_poltyp = fi_exc1  + "," + fi_exc2  + "," + fi_exc3  + "," + fi_exc4  + "," + fi_exc5  + "," +
                   fi_exc6  + "," + fi_exc7  + "," + fi_exc8  + "," + fi_exc9  + "," + fi_exc10 + "," +
                   fi_exc11 + "," + fi_exc12 + "," + fi_exc13 + "," + fi_exc14 + "," + fi_exc15 + "," +
                   fi_exc16 + "," + fi_exc17 + "," + fi_exc18 + "," + fi_exc19 + "," + fi_exc20.
   A58-0180*/

   FIND xmm031 USE-INDEX xmm03101       WHERE 
        xmm031.poltyp = uwm100.poltyp   NO-LOCK NO-ERROR.
   IF AVAIL xmm031 THEN DO:
       IF xmm031.dept = "G" OR xmm031.dept = "M" THEN NEXT loopmain.
       IF LOOKUP(xmm031.poltyp,nv_poltyp) <> 0  THEN NEXT loopmain.
   END.
   /*nv_count  = nv_count + 1 .*/
       
   /*------A63-0159----Change from 65000 to 1000000 --*/
   IF nv_count > 1000000 THEN DO:
       nv_output = (fi_output  + "_" + STRING(n_rec)) .
       RUN Pd_HeaderNon.
       n_rec = n_rec + 1.
       nv_count = 0.
   END.

   IF n_count > 1000000 THEN DO:
       nv_output1 = (fi_output  + "_error" + "_" + STRING(n_rec1)) .
       RUN Pd_HeaderNonerror.
       n_rec1 = n_rec1 + 1.
       n_count = 0.
   END.

    IF n_count1 > 1000000 THEN DO:
       nv_output2 = (fi_output  + "_can" + "_" + STRING(n_rec2)) .
       RUN Pd_HeaderNonCan.
       n_rec2 = n_rec2 + 1.
       n_count1 = 0.
   END.
   /*-------A63-0159------*/

   IF FIRST-OF(uwm100.poltyp)   THEN do: 
       
       RUN Pd_Cleartreaty.
   END.         

   DISPLAY  uwm100.trndat  uwm100.policy  WITH NO-LABEL TITLE "Process Report..."
       FRAME a1 VIEW-AS DIALOG-BOX.

   FIND xmm023 USE-INDEX xmm02301 WHERE
        xmm023.branch = n_bran    NO-LOCK NO-ERROR.
   IF NOT AVAIL xmm023 THEN NEXT loopmain.
   n_branch = n_bran.
   n_bdes   = xmm023.bdes.

   IF uwm100.DIR_ri = YES THEN nv_dir = 'D'.
   ELSE nv_dir = 'I'.

   n_endcnt = uwm100.endcnt - 1.

   ASSIGN nv_prstp  = 0       n_prmcom   = 0
          nv_prtax  = 0       n_stp      = 0
          nv_sumpts = 0       n_tstpcom  = 0
          n_sumprm  = 0       n_taxcom   = 0
          n_sumstp  = 0       n_stptrunc = 0
          n_sumtax  = 0       n_stpcom   = 0
          nu_tax    = 0       n_ttaxcom  = 0
          nu_prm    = 0       n_paprm    = 0
          nu_vat    = 0       n_stppa    = 0
          nv_sum    = 0       n_tstppa   = 0
          n_an      = 0       n_taxpa    = 0
          nvexch    = 1       nv_prmtre  = 0.

   FIND FIRST uwm130 USE-INDEX uwm13001   WHERE
              uwm130.policy = uwm100.policy AND
              uwm130.rencnt = uwm100.rencnt AND
              uwm130.endcnt = uwm100.endcnt 
   NO-LOCK NO-ERROR.
   REPEAT WHILE avail uwm130:
        IF    uwm100.poltyp  = "V70"  THEN
              nv_sum  = nv_sum + uwm130.uom6_v.
        ELSE  nv_sum  = nv_sum + uwm130.uom9_v.
        FIND NEXT uwm130 USE-INDEX uwm13001   WHERE
                  uwm130.policy = uwm100.policy AND
                  uwm130.rencnt = uwm100.rencnt AND
                  uwm130.endcnt = uwm100.endcnt 
        NO-LOCK NO-ERROR.
   END. 

   FIND FIRST uwm200 USE-INDEX uwm20001 WHERE
              uwm200.policy = UWM100.POLICY  AND
              uwm200.rencnt = uwm100.rencnt  AND
              uwm200.endcnt = uwm100.endcnt  AND
              uwm200.csftq  <> "C"
   NO-LOCK NO-ERROR.
   
   FIND FIRST uwm120 USE-INDEX uwm12001 WHERE
              uwm120.policy = uwm100.policy  AND
              uwm120.rencnt = uwm100.rencnt  AND
              uwm120.endcnt = uwm100.endcnt
   NO-LOCK NO-ERROR.
        nvexch = 1.
   IF AVAIL uwm120 THEN DO:
     IF SUBSTRING(uwm120.policy,3,2) = "90" THEN nvexch = 1.
     ELSE nvexch = uwm120.siexch.
   END.
   
   n_an = nv_sum * nvexch.
   FIND FIRST uwd132 USE-INDEX uwd13290   WHERE
              uwd132.policy = uwm100.policy AND
              uwd132.rencnt = uwm100.rencnt AND
              uwd132.endcnt = uwm100.endcnt NO-LOCK NO-ERROR.
   REPEAT WHILE avail uwd132:
        IF uwd132.bencod = 'COMP' OR uwd132.bencod = 'COMG' OR
           uwd132.bencod = 'COMH'  THEN DO:
           n_prmcom   =  n_prmcom + uwd132.prem_c.
 
           n_stp      =  (uwd132.prem_c  *  0.4) / 100.
   
           IF n_stp - TRUNCATE(n_stp,0)  <> 0 then n_stp = TRUNCATE(n_stp,0) + 1.
           n_tstpcom  =  n_tstpcom + n_stp.
           n_taxcom   =  (n_prmcom + n_tstpcom) * uwm100.gstrat / 100.
        END.
        IF uwd132.bencod = "PA" THEN DO:
           n_paprm = n_paprm + uwd132.prem_c.
           n_stppa = (uwd132.prem_c  *  0.4) / 100.
   
           IF n_stppa - TRUNCATE(n_stppa,0)  <> 0 then n_stppa = TRUNCATE(n_stppa,0) + 1.
           n_tstppa = n_tstppa + n_stppa.
           n_taxpa = (n_paprm + n_tstppa) * uwm100.gstrat / 100.
        END.
        
        FIND NEXT uwd132 USE-INDEX uwd13290   WHERE
                  uwd132.policy = uwm100.policy AND
                  uwd132.rencnt = uwm100.rencnt AND
                  uwd132.endcnt = uwm100.endcnt   NO-LOCK NO-ERROR.
   END.
   
   ASSIGN n_prmt    = 0     n_prms    = 0
          n_prmq    = 0     n_prmtfp  = 0
          n_prmrq   = 0     n_prmf1   = 0
          n_prmf2   = 0     n_prmr    = 0
          n_prmps   = 0     n_prmbtr  = 0
          n_prmotr  = 0     n_prms8   = 0
          n_prmf4   = 0     n_prmftr  = 0.

   LOOPB:
   REPEAT:
      n_cnt1  = n_cnt1 + 1.
      s_recid = RECID(uwm200).

      IF UWM100.TRANTY <> "C" THEN DO:
         RUN Pd_Process1.
      END.
      ELSE DO:
         RUN Pd_Process2.
      END.

      FIND NEXT uwm200  USE-INDEX  uwm20001  WHERE
                uwm200.policy = uwm100.policy  AND
                uwm200.rencnt = uwm100.rencnt  AND
                uwm200.endcnt = uwm100.endcnt
                NO-LOCK NO-ERROR.
      IF NOT AVAIL uwm200 THEN LEAVE loopb.
   END.   /* loopb */
   
   ASSIGN n_prmf1      =   n_prmf1     * (-1)
          n_prmf2      =   n_prmf2     * (-1)
          n_prmt       =   n_prmt      * (-1)
          n_prms       =   n_prms      * (-1)
          n_prmq       =   n_prmq      * (-1)
          n_prmtfp     =   n_prmtfp    * (-1)
          n_prmrq      =   n_prmrq     * (-1)
          n_prmps      =   n_prmps     * (-1)                
          n_prmbtr     =   n_prmbtr    * (-1)                
          n_prmotr     =   n_prmotr    * (-1)                
          n_prms8      =   n_prms8     * (-1)             
          n_prmf4      =   n_prmf4     * (-1)                
          n_prmftr     =   n_prmftr    * (-1).
   
   RUN Pd_detailNon.
   
   ASSIGN  nv_sum    = 0 
           p_t       = 000  n_sumt     = 0   n_prmt    = 0
           p_s       = 000  n_sums     = 0   n_prms    = 0
           p_q       = 000  n_sumq     = 0   n_prmq    = 0
           p_tfp     = 000  n_sumtfp   = 0   n_prmtfp  = 0
           p_rq      = 000  n_sumrq    = 0   n_prmrq   = 0
           p_f1      = 000  n_sumf1    = 0   n_prmf1   = 0
           p_f2      = 000  n_sumf2    = 0   n_prmf2   = 0
           p_r       = 000  n_sumr     = 0   n_prmr    = 0
           p_ps      = 000  n_sumps    = 0   n_prmps   = 0 
           p_btr     = 000  n_sumbtr   = 0   n_prmbtr  = 0 
           p_otr     = 000  n_sumotr   = 0   n_prmotr  = 0 
           p_s8      = 000  n_sums8    = 0   n_prms8   = 0 
           p_f4      = 000  n_sumf4    = 0   n_prmf4   = 0
           p_ftr     = 000  n_sumftr   = 0   n_prmftr  = 0
           n_rb_pf   = 000  n_rb_sum   = 0   n_rb_prm  = 0
           n_rf_pf   = 000  n_rf_sum   = 0   n_rf_prm  = 0
           nv_prmtre = 0.

   IF LAST-OF(uwm100.poltyp) THEN DO:
       
       ASSIGN    pv_f1_prb   = pv_f1_prb   * (-1)      iv_f1_prb   = iv_f1_prb   * (-1)
                 pv_f2_prb   = pv_f2_prb   * (-1)      iv_f2_prb   = iv_f2_prb   * (-1)
                 pv_0t_prb   = pv_0t_prb   * (-1)      iv_0t_prb   = iv_0t_prb   * (-1)
                 pv_0s_prb   = pv_0s_prb   * (-1)      iv_0s_prb   = iv_0s_prb   * (-1)
                 pv_stat_prb = pv_stat_prb * (-1)      iv_stat_prb = iv_stat_prb * (-1)
                 pv_0q_prb   = pv_0q_prb   * (-1)      iv_0q_prb   = iv_0q_prb   * (-1)
                 pv_0rq_prb  = pv_0rq_prb  * (-1)      iv_0rq_prb  = iv_0rq_prb  * (-1)
                 pv_0f_prb   = pv_0f_prb   * (-1)      iv_0f_prb   = iv_0f_prb   * (-1)
                 nv_f1_prb   = nv_f1_prb   * (-1)      nv_f2_prb   = nv_f2_prb   * (-1)
                 nv_0t_prb   = nv_0t_prb   * (-1)      nv_0s_prb   = nv_0s_prb   * (-1)
                 nv_stat_prb = nv_stat_prb * (-1)      nv_0q_prb   = nv_0q_prb   * (-1)
                 nv_0rq_prb  = nv_0rq_prb  * (-1)      nv_0f_prb   = nv_0f_prb   * (-1)
                 pv_s8_prb   = pv_s8_prb   * (-1)      iv_s8_prb   = iv_s8_prb   * (-1) 
               
                 nv_0ps_prb  = nv_0ps_prb  * (-1)
                 pv_0ps_prb  = pv_0ps_prb  * (-1)      iv_0ps_prb   = iv_0ps_prb   * (-1)
                 
                 nv_btr_prb  = nv_btr_prb  * (-1)
                 pv_btr_prb  = pv_btr_prb  * (-1)      iv_btr_prb   = iv_btr_prb   * (-1)
                 nv_otr_prb  = nv_otr_prb  * (-1)
                 pv_otr_prb  = pv_otr_prb  * (-1)      iv_otr_prb   = iv_otr_prb   * (-1)
               
                 nv_f4_prb   = nv_f4_prb   * (-1)
                 pv_f4_prb   = pv_f4_prb   * (-1)      iv_f4_prb    = iv_f4_prb    * (-1)
                 nv_ftr_prb  = nv_ftr_prb  * (-1)
                 pv_ftr_prb  = pv_ftr_prb  * (-1)      iv_ftr_prb   = iv_ftr_prb   * (-1).
       
          FIND FIRST wtotal WHERE wtotal.poltyp = SUBSTR(uwm100.poltyp,2,2) NO-LOCK NO-ERROR.
          IF NOT AVAIL wtotal THEN DO:
              CREATE wtotal.
              ASSIGN   wtotal.poltyp    = SUBSTR(uwm100.poltyp,2,2)
                       wtotal.totprmcom = nv_totprmcom 
                       wtotal.totearn   = nv_totearn   
                       wtotal.totuearn  = nv_totuearn  
                  /* comment by Benjaporn J. A58-0242
                       wtotal.totprmtre = nv_totprmtre 
                       wtotal.totearn2  = nv_totearn2  
                       wtotal.totuearn2 = nv_totuearn2 */
                  /* start A58-0242 Benjaporn J. 13/07/2015 */
                       wtotal.totprmtrt   = nv_totprmtrt 
                       wtotal.totearntrt  = nv_totearntrt  
                       wtotal.totuearntrt = nv_totuearntrt
                       wtotal.totprmfac   = nv_totprmfac
                       wtotal.totearnfac  = nv_totearnfac  
                       wtotal.totuearnfac = nv_totuearnfac. /* end A58-0242 Benjaporn J. 13/07/2015 */
          END.                   
          ASSIGN  nv_totprmcom    = 0    
                  nv_totearn      = 0    
                  nv_totuearn     = 0
                  nv_totprmtrt    = 0 
                  nv_totearntrt   = 0 
                  nv_totuearntrt  = 0 
                  nv_totprmfac    = 0 
                  nv_totearnfac   = 0 
                  nv_totuearnfac  = 0  .
          /* comment by Benjaporn J. A58-0242
                  nv_totprmtre = 0    nv_totearn2  = 0
                  nv_totuearn2 = 0  */
   END.
END.

PUT STREAM ns1
    "Grand Total"   SKIP.

loopmain1:
FOR EACH wtotal BREAK BY wtotal.poltyp.

    FIND xmm031 USE-INDEX xmm03101       WHERE 
         xmm031.poltyp = wtotal.poltyp   NO-LOCK NO-ERROR.
    IF AVAIL xmm031 THEN DO:

       IF xmm031.dept = "G" OR xmm031.dept = "M" THEN NEXT loopmain1.
       IF LOOKUP(xmm031.poltyp,nv_poltyp) <> 0  THEN NEXT loopmain1.
    END.
    
    IF wtotal.totprmcom = 0 AND wtotal.totsumprm = 0 AND
       wtotal.totearn   = 0 AND wtotal.totuearn  = 0 AND
        /* comment by Benjaporn J. A58-0242
       wtotal.totearn2  = 0 AND wtotal.totuearn2 = 0 THEN DO: */
        /* start A58-0242 Benjaporn J. 13/07/2015 */
       wtotal.totearntrt  = 0 AND wtotal.totuearntrt = 0 AND
       wtotal.totearnfac  = 0 AND wtotal.totuearnfac = 0 THEN DO: /* end A58-0242 Benjaporn J. 13/07/2015 */
    END.
    ELSE DO:
        PUT STREAM ns1
            "Line  " wtotal.poltyp "|" "|" "|" "|" "|" "|" "|" "|" "|" "|"
            wtotal.totprmcom "|"
            wtotal.totearn   "|"
            wtotal.totuearn  "|"
            /* comment by Benjaporn J. A58-0242
            wtotal.totprmtre "|"
            wtotal.totearn2  "|"
            wtotal.totuearn2 "|" */
            /* start A58-0242 Benjaporn J. 13/07/2015 */
            wtotal.totprmtrt   "|"
            wtotal.totearntrt  "|"
            wtotal.totuearntrt "|"
            wtotal.totprmfac   "|"
            wtotal.totearnfac  "|"
            wtotal.totuearnfac SKIP. /* end A58-0242 Benjaporn J. 13/07/2015 */
    END.
END.   
/*---A56-0092---*/
PUT STREAM ns3
    "Cancel - Grand Total"  "|" "|" "|" "|" "|" "|" "|" "|" "|" "|"
    nv_ctotprmcom "|" 
    nv_ctotearn   "|" 
    nv_ctotuearn  "|"
    /* comment by Benjaporn J. A58-0242
    nv_ctotprmtre "|" 
    nv_ctotearn2  "|" 
    nv_ctotuearn2 "|" */
    /* start A58-0242 Benjaporn J. 13/07/2015 */
    nv_ctotprmtrt   "|" 
    nv_ctotearntrt  "|" 
    nv_ctotuearntrt "|" 
    nv_ctotprmfac   "|" 
    nv_ctotearnfac  "|" 
    nv_ctotuearnfac SKIP.  /*--end A56-0092---*/ /* end A58-0242 Benjaporn J. 13/07/2015 */

OUTPUT STREAM ns1 CLOSE.
OUTPUT STREAM ns2 CLOSE.
OUTPUT STREAM ns3 CLOSE.    /*A56-0092*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pd_NonmotorNZI01 C-Win 
PROCEDURE Pd_NonmotorNZI01 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH wrk0f.
    DELETE wrk0f.
END.
FOR EACH wtotal.
    DELETE wtotal.
END.
ASSIGN n_rec = 1
    n_rec1   = 1
    n_rec2   = 1   
    nv_count = 0
    n_count  = 0
    n_count1 = 0
    nv_poltyp = "" .
FOR EACH wfline NO-LOCK.
    ASSIGN nv_poltyp = trim(nv_poltyp +  "," + wfline.nline) .
END.

loopmain:
FOR EACH uwm100 NO-LOCK USE-INDEX uwm10008 WHERE 
    uwm100.trndat  >=  fi_trndat      AND
    uwm100.trndat  <=  fi_trndatto    AND
    uwm100.expdat  >=  fi_asdate      AND 
    uwm100.agent   >=  fi_agentfr     AND
    uwm100.agent   <=  fi_agentto     AND
    uwm100.branch  >=  fi_branchfr    AND
    uwm100.branch  <=  fi_branchto    
    BREAK BY uwm100.poltyp 
          BY uwm100.policy  .
    ASSIGN fi_etime = STRING(TIME,"HH:MM:SS")
        n_bran   = ""
        n_bran   = uwm100.branch.
    DISP fi_stime fi_etime WITH FRAME fr_main. 
    /*A58-0180....
    ASSIGN
        nv_poltyp = ""
        nv_poltyp = fi_exc1  + "," + fi_exc2  + "," + fi_exc3  + "," + fi_exc4  + "," + fi_exc5  + "," +
                    fi_exc6  + "," + fi_exc7  + "," + fi_exc8  + "," + fi_exc9  + "," + fi_exc10 + "," +
                    fi_exc11 + "," + fi_exc12 + "," + fi_exc13 + "," + fi_exc14 + "," + fi_exc15 + "," +
                    fi_exc16 + "," + fi_exc17 + "," + fi_exc18 + "," + fi_exc19 + "," + fi_exc20.
    A58-0180......*/

    FIND xmm031 USE-INDEX xmm03101 WHERE xmm031.poltyp = uwm100.poltyp   NO-LOCK NO-ERROR.
    IF AVAIL xmm031 THEN DO:
        IF xmm031.dept = "G" OR xmm031.dept = "M" THEN NEXT loopmain.
        IF LOOKUP(xmm031.poltyp,nv_poltyp) <> 0  THEN NEXT loopmain.
    END.
    /*nv_count  = nv_count + 1 .*/
    /*------A63-0159----Change from 65000 to 1000000 --*/
    IF nv_count > 1000000 THEN DO:
        nv_output = (fi_output  + "_" + STRING(n_rec)) .
        RUN Pd_HeaderNon.
        n_rec = n_rec + 1.
        nv_count = 0.
    END.
    IF n_count > 1000000 THEN DO:
        nv_output1 = (fi_output  + "_error" + "_" + STRING(n_rec1)) .
        RUN Pd_HeaderNonerror.
        n_rec1 = n_rec1 + 1.
        n_count = 0.
    END.
    IF n_count1 > 1000000 THEN DO:
        nv_output2 = (fi_output  + "_can" + "_" + STRING(n_rec2)) .
        RUN Pd_HeaderNonCan.
        n_rec2 = n_rec2 + 1.
        n_count1 = 0.
    END.
    /*-------A63-0159------*/
    IF FIRST-OF(uwm100.poltyp)   THEN do: 
        RUN Pd_Cleartreaty.
    END.
    DISPLAY  uwm100.trndat  uwm100.policy  WITH NO-LABEL TITLE "Process Report..." FRAME a1 VIEW-AS DIALOG-BOX.
    FIND xmm023 USE-INDEX xmm02301 WHERE xmm023.branch = n_bran    NO-LOCK NO-ERROR.
    IF NOT AVAIL xmm023 THEN NEXT loopmain.
    n_branch = n_bran.
    n_bdes   = xmm023.bdes.
    IF uwm100.DIR_ri = YES THEN nv_dir = 'D'.
    ELSE nv_dir = 'I'.
    n_endcnt = uwm100.endcnt - 1.
    ASSIGN   nv_prstp  = 0       n_prmcom   = 0
             nv_prtax  = 0       n_stp      = 0
             nv_sumpts = 0       n_tstpcom  = 0
             n_sumprm  = 0       n_taxcom   = 0
             n_sumstp  = 0       n_stptrunc = 0
             n_sumtax  = 0       n_stpcom   = 0
             nu_tax    = 0       n_ttaxcom  = 0
             nu_prm    = 0       n_paprm    = 0
             nu_vat    = 0       n_stppa    = 0
             nv_sum    = 0       n_tstppa   = 0
             n_an      = 0       n_taxpa    = 0
             nvexch    = 1       nv_prmtre  = 0.

    FIND FIRST uwm130 USE-INDEX uwm13001   WHERE
        uwm130.policy = uwm100.policy  AND
        uwm130.rencnt = uwm100.rencnt  AND
        uwm130.endcnt = uwm100.endcnt  NO-LOCK NO-ERROR.
    REPEAT WHILE avail uwm130:
        IF    uwm100.poltyp  = "V70"  THEN
            nv_sum  = nv_sum + uwm130.uom6_v.
        ELSE  nv_sum  = nv_sum + uwm130.uom9_v.
        FIND NEXT uwm130 USE-INDEX uwm13001   WHERE
            uwm130.policy = uwm100.policy     AND
            uwm130.rencnt = uwm100.rencnt     AND
            uwm130.endcnt = uwm100.endcnt     NO-LOCK NO-ERROR.
    END.
    FIND FIRST uwm200 USE-INDEX uwm20001 WHERE
        uwm200.policy = UWM100.POLICY  AND
        uwm200.rencnt = uwm100.rencnt  AND
        uwm200.endcnt = uwm100.endcnt  AND
        uwm200.csftq  <> "C"   NO-LOCK NO-ERROR.
    FIND FIRST uwm120 USE-INDEX uwm12001 WHERE
        uwm120.policy = uwm100.policy  AND
        uwm120.rencnt = uwm100.rencnt  AND
        uwm120.endcnt = uwm100.endcnt  NO-LOCK NO-ERROR.
    nvexch = 1.
    IF AVAIL uwm120 THEN DO:
        IF SUBSTRING(uwm120.policy,3,2) = "90" THEN nvexch = 1.
        ELSE nvexch = uwm120.siexch.
    END.
    n_an = nv_sum * nvexch.
    FIND FIRST uwd132 USE-INDEX uwd13290   WHERE
        uwd132.policy = uwm100.policy    AND
        uwd132.rencnt = uwm100.rencnt    AND
        uwd132.endcnt = uwm100.endcnt    NO-LOCK NO-ERROR.
    REPEAT WHILE avail uwd132:
        IF uwd132.bencod = 'COMP' OR uwd132.bencod = 'COMG' OR
           uwd132.bencod = 'COMH'  THEN DO:
           n_prmcom   =  n_prmcom + uwd132.prem_c.
           n_stp      =  (uwd132.prem_c  *  0.4) / 100.
           IF n_stp - TRUNCATE(n_stp,0)  <> 0 then n_stp = TRUNCATE(n_stp,0) + 1.
           n_tstpcom  =  n_tstpcom + n_stp.
           n_taxcom   =  (n_prmcom + n_tstpcom) * uwm100.gstrat / 100.
        END.
        IF uwd132.bencod = "PA" THEN DO:
            n_paprm = n_paprm + uwd132.prem_c.
            n_stppa = (uwd132.prem_c  *  0.4) / 100.
            IF n_stppa - TRUNCATE(n_stppa,0)  <> 0 then n_stppa = TRUNCATE(n_stppa,0) + 1.
            n_tstppa = n_tstppa + n_stppa.
            n_taxpa = (n_paprm + n_tstppa) * uwm100.gstrat / 100.
        END.
        FIND NEXT uwd132 USE-INDEX uwd13290   WHERE
            uwd132.policy = uwm100.policy     AND
            uwd132.rencnt = uwm100.rencnt     AND
            uwd132.endcnt = uwm100.endcnt     NO-LOCK NO-ERROR.
    END.
    ASSIGN n_prmt    = 0            n_prms    = 0
           n_prmq    = 0            n_prmtfp  = 0
           n_prmrq   = 0            n_prmf1   = 0
           n_prmf2   = 0            n_prmr    = 0
           n_prmps   = 0            n_prmbtr  = 0
           n_prmotr  = 0            n_prms8   = 0
           n_prmf4   = 0            n_prmftr  = 0.

    LOOPB:
    REPEAT:
        n_cnt1  = n_cnt1 + 1.
        s_recid = RECID(uwm200).
        IF UWM100.TRANTY <> "C" THEN DO:
            RUN Pd_Process1.
        END.
        ELSE DO:
            RUN Pd_Process2.
        END.
        FIND NEXT uwm200  USE-INDEX  uwm20001  WHERE
            uwm200.policy = uwm100.policy  AND
            uwm200.rencnt = uwm100.rencnt  AND
            uwm200.endcnt = uwm100.endcnt  NO-LOCK NO-ERROR.
        IF NOT AVAIL uwm200 THEN LEAVE loopb.
    END.    /* loopb */
    ASSIGN   n_prmf1      =   n_prmf1     * (-1)
             n_prmf2      =   n_prmf2     * (-1)
             n_prmt       =   n_prmt      * (-1)
             n_prms       =   n_prms      * (-1)
             n_prmq       =   n_prmq      * (-1)
             n_prmtfp     =   n_prmtfp    * (-1)
             n_prmrq      =   n_prmrq     * (-1)
             n_prmps      =   n_prmps     * (-1)                
             n_prmbtr     =   n_prmbtr    * (-1)                
             n_prmotr     =   n_prmotr    * (-1)                
             n_prms8      =   n_prms8     * (-1)             
             n_prmf4      =   n_prmf4     * (-1)                
             n_prmftr     =   n_prmftr    * (-1).

   RUN Pd_detailNon.
   ASSIGN    nv_sum    = 0 
             p_t       = 000  n_sumt     = 0   n_prmt    = 0
             p_s       = 000  n_sums     = 0   n_prms    = 0
             p_q       = 000  n_sumq     = 0   n_prmq    = 0
             p_tfp     = 000  n_sumtfp   = 0   n_prmtfp  = 0
             p_rq      = 000  n_sumrq    = 0   n_prmrq   = 0
             p_f1      = 000  n_sumf1    = 0   n_prmf1   = 0
             p_f2      = 000  n_sumf2    = 0   n_prmf2   = 0
             p_r       = 000  n_sumr     = 0   n_prmr    = 0
             p_ps      = 000  n_sumps    = 0   n_prmps   = 0 
             p_btr     = 000  n_sumbtr   = 0   n_prmbtr  = 0 
             p_otr     = 000  n_sumotr   = 0   n_prmotr  = 0 
             p_s8      = 000  n_sums8    = 0   n_prms8   = 0 
             p_f4      = 000  n_sumf4    = 0   n_prmf4   = 0
             p_ftr     = 000  n_sumftr   = 0   n_prmftr  = 0
             n_rb_pf   = 000  n_rb_sum   = 0   n_rb_prm  = 0
             n_rf_pf   = 000  n_rf_sum   = 0   n_rf_prm  = 0
             nv_prmtre = 0 .

   IF LAST-OF(uwm100.poltyp) THEN DO:
       ASSIGN   pv_f1_prb   = pv_f1_prb   * (-1)      iv_f1_prb   = iv_f1_prb   * (-1)
                pv_f2_prb   = pv_f2_prb   * (-1)      iv_f2_prb   = iv_f2_prb   * (-1)
                pv_0t_prb   = pv_0t_prb   * (-1)      iv_0t_prb   = iv_0t_prb   * (-1)
                pv_0s_prb   = pv_0s_prb   * (-1)      iv_0s_prb   = iv_0s_prb   * (-1)
                pv_stat_prb = pv_stat_prb * (-1)      iv_stat_prb = iv_stat_prb * (-1)
                pv_0q_prb   = pv_0q_prb   * (-1)      iv_0q_prb   = iv_0q_prb   * (-1)
                pv_0rq_prb  = pv_0rq_prb  * (-1)      iv_0rq_prb  = iv_0rq_prb  * (-1)
                pv_0f_prb   = pv_0f_prb   * (-1)      iv_0f_prb   = iv_0f_prb   * (-1)
                nv_f1_prb   = nv_f1_prb   * (-1)      nv_f2_prb   = nv_f2_prb   * (-1)
                nv_0t_prb   = nv_0t_prb   * (-1)      nv_0s_prb   = nv_0s_prb   * (-1)
                nv_stat_prb = nv_stat_prb * (-1)      nv_0q_prb   = nv_0q_prb   * (-1)
                nv_0rq_prb  = nv_0rq_prb  * (-1)      nv_0f_prb   = nv_0f_prb   * (-1)
                pv_s8_prb   = pv_s8_prb   * (-1)      iv_s8_prb   = iv_s8_prb   * (-1) 
                nv_0ps_prb  = nv_0ps_prb  * (-1)
                pv_0ps_prb  = pv_0ps_prb  * (-1)      iv_0ps_prb   = iv_0ps_prb   * (-1)
                nv_btr_prb  = nv_btr_prb  * (-1)
                pv_btr_prb  = pv_btr_prb  * (-1)      iv_btr_prb   = iv_btr_prb   * (-1)
                nv_otr_prb  = nv_otr_prb  * (-1)
                pv_otr_prb  = pv_otr_prb  * (-1)      iv_otr_prb   = iv_otr_prb   * (-1)
                nv_f4_prb   = nv_f4_prb   * (-1)
                pv_f4_prb   = pv_f4_prb   * (-1)      iv_f4_prb    = iv_f4_prb    * (-1)
                nv_ftr_prb  = nv_ftr_prb  * (-1)
                pv_ftr_prb  = pv_ftr_prb  * (-1)      iv_ftr_prb   = iv_ftr_prb   * (-1).

          FIND FIRST wtotal WHERE wtotal.poltyp = SUBSTR(uwm100.poltyp,2,2) NO-LOCK NO-ERROR.
          IF NOT AVAIL wtotal THEN DO:
              CREATE wtotal.
              ASSIGN   wtotal.poltyp    = SUBSTR(uwm100.poltyp,2,2)
                       wtotal.totprmcom = nv_totprmcom 
                       wtotal.totearn   = nv_totearn   
                       wtotal.totuearn  = nv_totuearn 
                  /* comment by Benjaporn J. A58-0242
                       wtotal.totprmtre = nv_totprmtre 
                       wtotal.totearn2  = nv_totearn2  
                       wtotal.totuearn2 = nv_totuearn2 */
                   /* start A58-0242 Benjaporn J. 13/07/2015 */
                       wtotal.totprmtrt   = nv_totprmtrt 
                       wtotal.totearntrt  = nv_totearntrt  
                       wtotal.totuearntrt = nv_totuearntrt
                       wtotal.totprmfac   = nv_totprmfac
                       wtotal.totearnfac  = nv_totearnfac  
                       wtotal.totuearnfac = nv_totuearnfac. /* end A58-0242 Benjaporn J. 13/07/2015 */
          END.
          ASSIGN   nv_totprmcom    = 0    
                   nv_totearn      = 0    
                   nv_totuearn     = 0
                   nv_totprmtrt    = 0 
                   nv_totearntrt   = 0 
                   nv_totuearntrt  = 0 
                   nv_totprmfac    = 0 
                   nv_totearnfac   = 0 
                   nv_totuearnfac  = 0  .
          /* comment by Benjaporn J. A58-0242
                   nv_totprmtre = 0    nv_totearn2  = 0
                   nv_totuearn2 = 0 */
   END.
END.
PUT STREAM ns1
    "Grand Total"   SKIP.
loopmain1:
FOR EACH wtotal BREAK BY wtotal.poltyp.
    FIND xmm031 USE-INDEX xmm03101       WHERE 
         xmm031.poltyp = wtotal.poltyp   NO-LOCK NO-ERROR.
    IF AVAIL xmm031 THEN DO:
       IF xmm031.dept = "G" OR xmm031.dept = "M" THEN NEXT loopmain1.
       IF LOOKUP(xmm031.poltyp,nv_poltyp) <> 0   THEN NEXT loopmain1.
    END.
    IF wtotal.totprmcom = 0 AND wtotal.totsumprm = 0 AND
       wtotal.totearn   = 0 AND wtotal.totuearn  = 0 AND
        /* comment by Benjaporn J. A58-0242
       wtotal.totearn2  = 0 AND wtotal.totuearn2 = 0 THEN DO:  */
         /* start A58-0242 Benjaporn J. 13/07/2015 */
       wtotal.totearntrt  = 0 AND wtotal.totuearntrt = 0 AND
       wtotal.totearnfac  = 0 AND wtotal.totuearnfac = 0 THEN DO: /* end A58-0242 Benjaporn J. 13/07/2015 */
    END.
    ELSE DO:
        PUT STREAM ns1
            "Line  " wtotal.poltyp "|" "|" "|" "|" "|" "|" "|" "|" "|" "|"
            wtotal.totprmcom "|"
            wtotal.totearn   "|"
            wtotal.totuearn  "|"
            /* comment by Benjaporn J. A58-0242
            wtotal.totprmtre "|"
            wtotal.totearn2  "|"
            wtotal.totuearn2 "|" */
             /* start A58-0242 Benjaporn J. 13/07/2015 */
            wtotal.totprmtrt   "|"
            wtotal.totearntrt  "|"
            wtotal.totuearntrt "|"
            wtotal.totprmfac   "|"
            wtotal.totearnfac  "|"
            wtotal.totuearnfac SKIP. /* end A58-0242 Benjaporn J. 13/07/2015 */
    END.
END. 
PUT STREAM ns3
    "Cancel - Grand Total"  "|" "|" "|" "|" "|" "|" "|" "|" "|" "|"
    nv_ctotprmcom "|" 
    nv_ctotearn   "|" 
    nv_ctotuearn  "|" 
    /* comment by Benjaporn J. A58-0242
    nv_ctotprmtre "|" 
    nv_ctotearn2  "|" 
    nv_ctotuearn2 "|" */
     /* start A58-0242 Benjaporn J. 13/07/2015 */
    nv_ctotprmtrt   "|" 
    nv_ctotearntrt  "|" 
    nv_ctotuearntrt "|" 
    nv_ctotprmfac   "|" 
    nv_ctotearnfac  "|" 
    nv_ctotuearnfac SKIP. /* end A58-0242 Benjaporn J. 13/07/2015 */

OUTPUT STREAM ns1 CLOSE.
OUTPUT STREAM ns2 CLOSE.
OUTPUT STREAM ns3 CLOSE.   
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pd_non_earn C-Win 
PROCEDURE Pd_non_earn :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH wrk0f.
    DELETE wrk0f.
END.
FOR EACH wtotal.
    DELETE wtotal.
END.
RUN Pd_Checkbranch.

ASSIGN
    n_rec    = 1
    n_rec1   = 1
    n_rec2   = 1
    nv_count = 0
    n_count  = 0
    n_count1 = 0
    nv_poltyp = "" .
FOR EACH wfline NO-LOCK.
    ASSIGN nv_poltyp = trim(nv_poltyp +  "," + wfline.nline) .
END.

loopmain:
FOR EACH uwm100 NO-LOCK USE-INDEX uwm10008 WHERE
         uwm100.trndat  >=  fi_trndat               AND
       /*uwm100.trndat  <=  fi_asdate               AND */
         uwm100.trndat  <=  fi_trndatto             AND   /* A58-0242 Benjaporn J. 13/07/2015 */
         uwm100.expdat  <   fi_asdate               AND 
         uwm100.agent   >=  fi_agentfr              AND
         uwm100.agent   <=  fi_agentto              AND
  INDEX( nv_brdes, "," + TRIM(uwm100.branch)) <> 0  AND
      (( fi_releas = "Y"  AND UWM100.RELEAS = YES ) OR
       ( fi_releas = "N"  AND UWM100.RELEAS = NO  ) OR
       ( fi_releas = "A"))  BREAK BY uwm100.poltyp 
                                  /*BY uwm100.branch */
                                  BY uwm100.policy
                                  /*BY uwm100.endno
                                  BY uwm100.trndat
                                  BY uwm100.tranty*/ .

   fi_etime = STRING(TIME,"HH:MM:SS"). /*Lukkana M. A55-0144 25/04/2012*/
   n_bran   = "".
   n_bran   = uwm100.branch.
   DISP fi_stime fi_etime WITH FRAME fr_main. /*Lukkana M. A55-0144 25/04/2012*/
   
   IF SUBSTR(uwm100.policy,1,1) = "I" THEN DO:

         IF nv_brdes1 = ""  THEN NEXT loopmain.
         IF INDEX(nv_brdes1,",9" + SUBSTRING(uwm100.policy,2,1)) <> 0 THEN 
             n_bran = "9" + SUBSTRING(uwm100.policy,2,1). 
   END.
   ELSE  DO:    
         IF INDEX("ABCDEFGHIJKLMNOPQRSTUVWXYZ" , fi_branchto) <> 0  THEN DO: /*พบตัวอักษรในbranch*/
            IF uwm100.branch < fi_branchfr OR uwm100.branch > fi_branchto THEN NEXT loopmain.
         END.
         ELSE DO:
            IF INTEGER(uwm100.branch) < nv_brn_fr OR INTEGER(uwm100.branch) > nv_brn_to THEN NEXT loopmain.
         END.
   END.  

   /*A58-0180.......
   ASSIGN
       nv_poltyp = ""
       nv_poltyp = fi_exc1  + "," + fi_exc2  + "," + fi_exc3  + "," + fi_exc4  + "," + fi_exc5  + "," +
                   fi_exc6  + "," + fi_exc7  + "," + fi_exc8  + "," + fi_exc9  + "," + fi_exc10 + "," +
                   fi_exc11 + "," + fi_exc12 + "," + fi_exc13 + "," + fi_exc14 + "," + fi_exc15 + "," +
                   fi_exc16 + "," + fi_exc17 + "," + fi_exc18 + "," + fi_exc19 + "," + fi_exc20.
   A58-0180......*/

   FIND xmm031 USE-INDEX xmm03101       WHERE 
        xmm031.poltyp = uwm100.poltyp   NO-LOCK NO-ERROR.
   IF AVAIL xmm031 THEN DO:
       IF xmm031.dept = "G" OR xmm031.dept = "M" THEN NEXT loopmain.
       IF LOOKUP(xmm031.poltyp,nv_poltyp) <> 0  THEN NEXT loopmain.
   END.
   
   /*nv_count  = nv_count + 1 .*/

   /*---A63-0159 ----Change from 65000 to 1000000 --*/
   IF nv_count > 1000000 THEN DO:
       nv_output = (fi_output  + "_" + STRING(n_rec)) .
       RUN Pd_HeaderNon.
       n_rec = n_rec + 1.
       nv_count = 0.
   END.

   IF n_count > 1000000 THEN DO:
       nv_output1 = (fi_output  + "_error" + "_" + STRING(n_rec1)) .
       RUN Pd_HeaderNonerror.
       n_rec1 = n_rec1 + 1.
       n_count = 0.
   END.

   IF n_count1 > 1000000 THEN DO:
       nv_output2 = (fi_output  + "_can" + "_" + STRING(n_rec2)) .
       RUN Pd_HeaderNonCan.
       n_rec2 = n_rec2 + 1.
       n_count1 = 0.
   END.
   /*----A63-0159---*/
   
   IF FIRST-OF(uwm100.poltyp)   THEN do: 
       
       RUN Pd_Cleartreaty.
   END.         

   DISPLAY  uwm100.trndat  uwm100.policy  WITH NO-LABEL TITLE "Process Report..."
       FRAME a1 VIEW-AS DIALOG-BOX.

   FIND xmm023 USE-INDEX xmm02301 WHERE
        xmm023.branch = n_bran    NO-LOCK NO-ERROR.
   IF NOT AVAIL xmm023 THEN NEXT loopmain.
   n_branch = n_bran.
   n_bdes   = xmm023.bdes.

   IF uwm100.DIR_ri = YES THEN nv_dir = 'D'.
   ELSE nv_dir = 'I'.

   n_endcnt = uwm100.endcnt - 1.

   ASSIGN
       nv_prstp  = 0       n_prmcom   = 0
       nv_prtax  = 0       n_stp      = 0
       nv_sumpts = 0       n_tstpcom  = 0
       n_sumprm  = 0       n_taxcom   = 0
       n_sumstp  = 0       n_stptrunc = 0
       n_sumtax  = 0       n_stpcom   = 0
       nu_tax    = 0       n_ttaxcom  = 0
       nu_prm    = 0       n_paprm    = 0
       nu_vat    = 0       n_stppa    = 0
       nv_sum    = 0       n_tstppa   = 0
       n_an      = 0       n_taxpa    = 0
       nvexch    = 1       
       nv_prmtre = 0 .  

   FIND FIRST uwm130 USE-INDEX uwm13001   WHERE
              uwm130.policy = uwm100.policy AND
              uwm130.rencnt = uwm100.rencnt AND
              uwm130.endcnt = uwm100.endcnt 
   NO-LOCK NO-ERROR.
   REPEAT WHILE avail uwm130:
        IF    uwm100.poltyp  = "V70"  THEN
              nv_sum  = nv_sum + uwm130.uom6_v.
        ELSE  nv_sum  = nv_sum + uwm130.uom9_v.
        FIND NEXT uwm130 USE-INDEX uwm13001   WHERE
                  uwm130.policy = uwm100.policy AND
                  uwm130.rencnt = uwm100.rencnt AND
                  uwm130.endcnt = uwm100.endcnt 
        NO-LOCK NO-ERROR.
   END. 

   FIND FIRST uwm200 USE-INDEX uwm20001 WHERE
              uwm200.policy = UWM100.POLICY  AND
              uwm200.rencnt = uwm100.rencnt  AND
              uwm200.endcnt = uwm100.endcnt  AND
              uwm200.csftq  <> "C"
   NO-LOCK NO-ERROR.
   
   FIND FIRST uwm120 USE-INDEX uwm12001 WHERE
              uwm120.policy = uwm100.policy  AND
              uwm120.rencnt = uwm100.rencnt  AND
              uwm120.endcnt = uwm100.endcnt
   NO-LOCK NO-ERROR.
        nvexch = 1.
   IF AVAIL uwm120 THEN DO:
     IF SUBSTRING(uwm120.policy,3,2) = "90" THEN nvexch = 1.
     ELSE nvexch = uwm120.siexch.
   END.
   
   n_an = nv_sum * nvexch.
   FIND FIRST uwd132 USE-INDEX uwd13290   WHERE
              uwd132.policy = uwm100.policy AND
              uwd132.rencnt = uwm100.rencnt AND
              uwd132.endcnt = uwm100.endcnt
   NO-LOCK NO-ERROR.
   REPEAT WHILE avail uwd132:
        IF uwd132.bencod = 'COMP' OR uwd132.bencod = 'COMG' OR
           uwd132.bencod = 'COMH'  THEN DO:
           n_prmcom   =  n_prmcom + uwd132.prem_c.
 
           n_stp      =  (uwd132.prem_c  *  0.4) / 100.
   
           IF n_stp - TRUNCATE(n_stp,0)  <> 0 then n_stp = TRUNCATE(n_stp,0) + 1.
           n_tstpcom  =  n_tstpcom + n_stp.
           n_taxcom   =  (n_prmcom + n_tstpcom) * uwm100.gstrat / 100.
        END.
        IF uwd132.bencod = "PA" THEN DO:
           n_paprm = n_paprm + uwd132.prem_c.
           n_stppa = (uwd132.prem_c  *  0.4) / 100.
   
           IF n_stppa - TRUNCATE(n_stppa,0)  <> 0 then n_stppa = TRUNCATE(n_stppa,0) + 1.
           n_tstppa = n_tstppa + n_stppa.
           n_taxpa = (n_paprm + n_tstppa) * uwm100.gstrat / 100.
        END.
        
        FIND NEXT uwd132 USE-INDEX uwd13290   WHERE
                  uwd132.policy = uwm100.policy AND
                  uwd132.rencnt = uwm100.rencnt AND
                  uwd132.endcnt = uwm100.endcnt 
        NO-LOCK NO-ERROR.
   END.
   
   ASSIGN
       n_prmt    = 0         n_prms    = 0
       n_prmq    = 0         n_prmtfp  = 0
       n_prmrq   = 0         n_prmf1   = 0
       n_prmf2   = 0         n_prmr    = 0
       n_prmps   = 0         n_prmbtr  = 0
       n_prmotr  = 0         n_prms8   = 0
       n_prmf4   = 0         n_prmftr  = 0.

   LOOPB:
   REPEAT:
      n_cnt1  = n_cnt1 + 1.
      s_recid = RECID(uwm200).

      IF UWM100.TRANTY <> "C" THEN DO:
         RUN Pd_Process1.
      END.
      ELSE DO:
         RUN Pd_Process2.
      END.

      FIND NEXT uwm200  USE-INDEX  uwm20001  WHERE
                uwm200.policy = uwm100.policy  AND
                uwm200.rencnt = uwm100.rencnt  AND
                uwm200.endcnt = uwm100.endcnt
                NO-LOCK NO-ERROR.
      IF NOT AVAIL uwm200 THEN LEAVE loopb.
   END.   /* loopb */
   
   ASSIGN
        n_prmf1      =   n_prmf1     * (-1)
        n_prmf2      =   n_prmf2     * (-1)
        n_prmt       =   n_prmt      * (-1)
        n_prms       =   n_prms      * (-1)
        n_prmq       =   n_prmq      * (-1)
        n_prmtfp     =   n_prmtfp    * (-1)
        n_prmrq      =   n_prmrq     * (-1)
        n_prmps      =   n_prmps     * (-1)                
        n_prmbtr     =   n_prmbtr    * (-1)                
        n_prmotr     =   n_prmotr    * (-1)                
        n_prms8      =   n_prms8     * (-1)             
        n_prmf4      =   n_prmf4     * (-1)                
        n_prmftr     =   n_prmftr    * (-1).
   
   RUN Pd_detailNon.
   
   ASSIGN
        nv_sum    = 0 
        p_t       = 000  n_sumt     = 0   n_prmt    = 0
        p_s       = 000  n_sums     = 0   n_prms    = 0
        p_q       = 000  n_sumq     = 0   n_prmq    = 0
        p_tfp     = 000  n_sumtfp   = 0   n_prmtfp  = 0
        p_rq      = 000  n_sumrq    = 0   n_prmrq   = 0
        p_f1      = 000  n_sumf1    = 0   n_prmf1   = 0
        p_f2      = 000  n_sumf2    = 0   n_prmf2   = 0
        p_r       = 000  n_sumr     = 0   n_prmr    = 0
        p_ps      = 000  n_sumps    = 0   n_prmps   = 0 
        p_btr     = 000  n_sumbtr   = 0   n_prmbtr  = 0 
        p_otr     = 000  n_sumotr   = 0   n_prmotr  = 0 
        p_s8      = 000  n_sums8    = 0   n_prms8   = 0 
        p_f4      = 000  n_sumf4    = 0   n_prmf4   = 0
        p_ftr     = 000  n_sumftr   = 0   n_prmftr  = 0
        n_rb_pf   = 000  n_rb_sum   = 0   n_rb_prm  = 0
        n_rf_pf   = 000  n_rf_sum   = 0   n_rf_prm  = 0
        nv_prmtre = 0 .

IF LAST-OF(uwm100.poltyp) THEN DO:
       
       ASSIGN
          pv_f1_prb   = pv_f1_prb   * (-1)      iv_f1_prb   = iv_f1_prb   * (-1)
          pv_f2_prb   = pv_f2_prb   * (-1)      iv_f2_prb   = iv_f2_prb   * (-1)
          pv_0t_prb   = pv_0t_prb   * (-1)      iv_0t_prb   = iv_0t_prb   * (-1)
          pv_0s_prb   = pv_0s_prb   * (-1)      iv_0s_prb   = iv_0s_prb   * (-1)
          pv_stat_prb = pv_stat_prb * (-1)      iv_stat_prb = iv_stat_prb * (-1)
          pv_0q_prb   = pv_0q_prb   * (-1)      iv_0q_prb   = iv_0q_prb   * (-1)
          pv_0rq_prb  = pv_0rq_prb  * (-1)      iv_0rq_prb  = iv_0rq_prb  * (-1)
          pv_0f_prb   = pv_0f_prb   * (-1)      iv_0f_prb   = iv_0f_prb   * (-1)
          nv_f1_prb   = nv_f1_prb   * (-1)      nv_f2_prb   = nv_f2_prb   * (-1)
          nv_0t_prb   = nv_0t_prb   * (-1)      nv_0s_prb   = nv_0s_prb   * (-1)
          nv_stat_prb = nv_stat_prb * (-1)      nv_0q_prb   = nv_0q_prb   * (-1)
          nv_0rq_prb  = nv_0rq_prb  * (-1)      nv_0f_prb   = nv_0f_prb   * (-1)
          pv_s8_prb   = pv_s8_prb   * (-1)      iv_s8_prb   = iv_s8_prb   * (-1) 

          nv_0ps_prb  = nv_0ps_prb  * (-1)
          pv_0ps_prb  = pv_0ps_prb  * (-1)      iv_0ps_prb   = iv_0ps_prb   * (-1)
          
          nv_btr_prb  = nv_btr_prb  * (-1)
          pv_btr_prb  = pv_btr_prb  * (-1)      iv_btr_prb   = iv_btr_prb   * (-1)
          nv_otr_prb  = nv_otr_prb  * (-1)
          pv_otr_prb  = pv_otr_prb  * (-1)      iv_otr_prb   = iv_otr_prb   * (-1)

          nv_f4_prb   = nv_f4_prb   * (-1)
          pv_f4_prb   = pv_f4_prb   * (-1)      iv_f4_prb    = iv_f4_prb    * (-1)
          nv_ftr_prb  = nv_ftr_prb  * (-1)
          pv_ftr_prb  = pv_ftr_prb  * (-1)      iv_ftr_prb   = iv_ftr_prb   * (-1).
       
          FIND FIRST wtotal WHERE wtotal.poltyp = SUBSTR(uwm100.poltyp,2,2) NO-LOCK NO-ERROR.
          IF NOT AVAIL wtotal THEN DO:
              CREATE wtotal.
              ASSIGN 
                  wtotal.poltyp    = SUBSTR(uwm100.poltyp,2,2)
                  wtotal.totprmcom = nv_totprmcom 
                  wtotal.totearn   = nv_totearn   
                  wtotal.totuearn  = nv_totuearn 
                  /* comment by Benjaporn J. A58-0242
                  wtotal.totprmtre = nv_totprmtre 
                  wtotal.totearn2  = nv_totearn2  
                  wtotal.totuearn2 = nv_totuearn2 */
                  /* start A58-0242 Benjaporn J. 13/07/2015 */
                  wtotal.totprmtrt   = nv_totprmtrt 
                  wtotal.totearntrt  = nv_totearntrt  
                  wtotal.totuearntrt = nv_totuearntrt
                  wtotal.totprmfac   = nv_totprmfac
                  wtotal.totearnfac  = nv_totearnfac  
                  wtotal.totuearnfac = nv_totuearnfac. /* end A58-0242 Benjaporn J. 13/07/2015 */
          END.
          ASSIGN
              nv_totprmcom    = 0    
              nv_totearn      = 0    
              nv_totuearn     = 0
              nv_totprmtrt    = 0 
              nv_totearntrt   = 0 
              nv_totuearntrt  = 0 
              nv_totprmfac    = 0 
              nv_totearnfac   = 0 
              nv_totuearnfac  = 0  .
          /* comment by Benjaporn J. A58-0242
              nv_totprmtre = 0    nv_totearn2  = 0
              nv_totuearn2 = 0  */
      END.
END.

PUT STREAM ns1
    "Grand Total"   SKIP.

loopmain1:
FOR EACH wtotal BREAK BY wtotal.poltyp.

    FIND xmm031 USE-INDEX xmm03101       WHERE 
         xmm031.poltyp = wtotal.poltyp   NO-LOCK NO-ERROR.
    IF AVAIL xmm031 THEN DO:

       IF xmm031.dept = "G" OR xmm031.dept = "M" THEN NEXT loopmain1.
       IF LOOKUP(xmm031.poltyp,nv_poltyp) <> 0  THEN NEXT loopmain1.
    END.
    
    IF wtotal.totprmcom = 0 AND wtotal.totsumprm = 0 AND
       wtotal.totearn   = 0 AND wtotal.totuearn  = 0 AND
        /* comment by Benjaporn J. A58-0242
       wtotal.totearn2  = 0 AND wtotal.totuearn2 = 0 THEN DO: */
        /* start A58-0242 Benjaporn J. 13/07/2015 */
       wtotal.totearntrt  = 0 AND wtotal.totuearntrt = 0 AND
       wtotal.totearnfac  = 0 AND wtotal.totuearnfac = 0 THEN DO: /* end A58-0242 Benjaporn J. 13/07/2015 */

    END.
    ELSE DO:
        PUT STREAM ns1
            "Line  " wtotal.poltyp "|" "|" "|" "|" "|" "|" "|" "|" "|" "|"
            wtotal.totprmcom "|"
            wtotal.totearn   "|"
            wtotal.totuearn  "|"
            /* comment by Benjaporn J. A58-0242
            wtotal.totprmtre "|"
            wtotal.totearn2  "|"
            wtotal.totuearn2 "|" */
            /* start A58-0242 Benjaporn J. 13/07/2015 */
            wtotal.totprmtrt   "|"
            wtotal.totearntrt  "|"
            wtotal.totuearntrt "|"
            wtotal.totprmfac   "|"
            wtotal.totearnfac  "|"
            wtotal.totuearnfac SKIP. /* end A58-0242 Benjaporn J. 13/07/2015 */
    END.
END.   
/*---A56-0092---*/
PUT STREAM ns3
    "Cancel - Grand Total"  "|" "|" "|" "|" "|" "|" "|" "|" "|" "|"
    nv_ctotprmcom "|" 
    nv_ctotearn   "|" 
    nv_ctotuearn  "|"
    /* comment by Benjaporn J. A58-0242
    nv_ctotprmtre "|" 
    nv_ctotearn2  "|" 
    nv_ctotuearn2 "|" */
/* start A58-0242 Benjaporn J. 13/07/2015 */
    nv_ctotprmtrt   "|" 
    nv_ctotearntrt  "|" 
    nv_ctotuearntrt "|" 
    nv_ctotprmfac   "|" 
    nv_ctotearnfac  "|" 
    nv_ctotuearnfac SKIP.  /*--end A56-0092---*/  /* end A58-0242 Benjaporn J. 13/07/2015 */

OUTPUT STREAM ns1 CLOSE.
OUTPUT STREAM ns2 CLOSE.
OUTPUT STREAM ns3 CLOSE.    /*A56-0092*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pd_non_earnNZI C-Win 
PROCEDURE Pd_non_earnNZI :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH wrk0f.
    DELETE wrk0f.
END.
FOR EACH wtotal.
    DELETE wtotal.
END.

ASSIGN
    n_rec    = 1
    n_rec1   = 1
    n_rec2   = 1   /*A56-0092*/
    nv_count = 0
    n_count  = 0
    n_count1 = 0   /*A56-0092*/
    nv_poltyp = "" .
FOR EACH wfline NO-LOCK.
    ASSIGN nv_poltyp = trim(nv_poltyp +  "," + wfline.nline) .
END.

loopmain:
FOR EACH uwm100 NO-LOCK USE-INDEX uwm10008 WHERE
         uwm100.trndat  >=  fi_trndat               AND
    /*   uwm100.trndat  <=  fi_asdate               AND */
         uwm100.trndat  <=  fi_trndatto             AND   /* A58-0242 Benjaporn J. 13/07/2015 */
         uwm100.expdat  <   fi_asdate               AND 
         uwm100.agent   >=  fi_agentfr              AND
         uwm100.agent   <=  fi_agentto              AND
         uwm100.branch  >=  fi_branchfr             AND
         uwm100.branch  <=  fi_branchto             AND
      (( fi_releas = "Y"  AND UWM100.RELEAS = YES ) OR
       ( fi_releas = "N"  AND UWM100.RELEAS = NO  ) OR
       ( fi_releas = "A"))  BREAK BY uwm100.poltyp 
                                  /*BY uwm100.branch */
                                  BY uwm100.policy
                                  /*BY uwm100.endno
                                  BY uwm100.trndat
                                  BY uwm100.tranty*/ .

   fi_etime = STRING(TIME,"HH:MM:SS"). /*Lukkana M. A55-0144 25/04/2012*/
   n_bran   = "".
   n_bran   = uwm100.branch.
   DISP fi_stime fi_etime WITH FRAME fr_main. /*Lukkana M. A55-0144 25/04/2012*/
   
   /*A58-0180....
   ASSIGN
       nv_poltyp = ""
       nv_poltyp = fi_exc1  + "," + fi_exc2  + "," + fi_exc3  + "," + fi_exc4  + "," + fi_exc5  + "," +
                   fi_exc6  + "," + fi_exc7  + "," + fi_exc8  + "," + fi_exc9  + "," + fi_exc10 + "," +
                   fi_exc11 + "," + fi_exc12 + "," + fi_exc13 + "," + fi_exc14 + "," + fi_exc15 + "," +
                   fi_exc16 + "," + fi_exc17 + "," + fi_exc18 + "," + fi_exc19 + "," + fi_exc20.
   A58-0180.......*/

   FIND xmm031 USE-INDEX xmm03101       WHERE 
        xmm031.poltyp = uwm100.poltyp   NO-LOCK NO-ERROR.
   IF AVAIL xmm031 THEN DO:
       IF xmm031.dept = "G" OR xmm031.dept = "M" THEN NEXT loopmain.
       IF LOOKUP(xmm031.poltyp,nv_poltyp) <> 0  THEN NEXT loopmain.
   END.
   
   /*nv_count  = nv_count + 1 .*/

   /*---A63-0159----Change from 65000 to 1000000 --*/
   IF nv_count > 1000000 THEN DO:
       nv_output = (fi_output  + "_" + STRING(n_rec)) .
       RUN Pd_HeaderNon.
       n_rec = n_rec + 1.
       nv_count = 0.
   END.

   IF n_count > 1000000 THEN DO:
       nv_output1 = (fi_output  + "_error" + "_" + STRING(n_rec1)) .
       RUN Pd_HeaderNonerror.
       n_rec1 = n_rec1 + 1.
       n_count = 0.
   END.

   IF n_count1 > 1000000 THEN DO:
       nv_output2 = (fi_output  + "_can" + "_" + STRING(n_rec2)) .
       RUN Pd_HeaderNonCan.
       n_rec2 = n_rec2 + 1.
       n_count1 = 0.
   END.
   /*-------A63-0159------*/
   
   IF FIRST-OF(uwm100.poltyp)   THEN do: 
       
       RUN Pd_Cleartreaty.
   END.         

   DISPLAY  uwm100.trndat  uwm100.policy  WITH NO-LABEL TITLE "Process Report..."
       FRAME a1 VIEW-AS DIALOG-BOX.

   FIND xmm023 USE-INDEX xmm02301 WHERE
        xmm023.branch = n_bran    NO-LOCK NO-ERROR.
   IF NOT AVAIL xmm023 THEN NEXT loopmain.
   n_branch = n_bran.
   n_bdes   = xmm023.bdes.

   IF uwm100.DIR_ri = YES THEN nv_dir = 'D'.
   ELSE nv_dir = 'I'.

   n_endcnt = uwm100.endcnt - 1.

   ASSIGN
       nv_prstp  = 0       n_prmcom   = 0
       nv_prtax  = 0       n_stp      = 0
       nv_sumpts = 0       n_tstpcom  = 0
       n_sumprm  = 0       n_taxcom   = 0
       n_sumstp  = 0       n_stptrunc = 0
       n_sumtax  = 0       n_stpcom   = 0
       nu_tax    = 0       n_ttaxcom  = 0
       nu_prm    = 0       n_paprm    = 0
       nu_vat    = 0       n_stppa    = 0
       nv_sum    = 0       n_tstppa   = 0
       n_an      = 0       n_taxpa    = 0
       nvexch    = 1       nv_prmtre  = 0 .
    

FIND FIRST uwm130 USE-INDEX uwm13001   WHERE
              uwm130.policy = uwm100.policy AND
              uwm130.rencnt = uwm100.rencnt AND
              uwm130.endcnt = uwm100.endcnt 
   NO-LOCK NO-ERROR.
   REPEAT WHILE avail uwm130:
        IF    uwm100.poltyp  = "V70"  THEN
              nv_sum  = nv_sum + uwm130.uom6_v.
        ELSE  nv_sum  = nv_sum + uwm130.uom9_v.
        FIND NEXT uwm130 USE-INDEX uwm13001   WHERE
                  uwm130.policy = uwm100.policy AND
                  uwm130.rencnt = uwm100.rencnt AND
                  uwm130.endcnt = uwm100.endcnt 
        NO-LOCK NO-ERROR.
   END. 

   FIND FIRST uwm200 USE-INDEX uwm20001 WHERE
              uwm200.policy = UWM100.POLICY  AND
              uwm200.rencnt = uwm100.rencnt  AND
              uwm200.endcnt = uwm100.endcnt  AND
              uwm200.csftq  <> "C"
   NO-LOCK NO-ERROR.
   
   FIND FIRST uwm120 USE-INDEX uwm12001 WHERE
              uwm120.policy = uwm100.policy  AND
              uwm120.rencnt = uwm100.rencnt  AND
              uwm120.endcnt = uwm100.endcnt
   NO-LOCK NO-ERROR.
        nvexch = 1.
   IF AVAIL uwm120 THEN DO:
     IF SUBSTRING(uwm120.policy,3,2) = "90" THEN nvexch = 1.
     ELSE nvexch = uwm120.siexch.
   END.
   
   n_an = nv_sum * nvexch.
   FIND FIRST uwd132 USE-INDEX uwd13290   WHERE
              uwd132.policy = uwm100.policy AND
              uwd132.rencnt = uwm100.rencnt AND
              uwd132.endcnt = uwm100.endcnt
   NO-LOCK NO-ERROR.
   REPEAT WHILE avail uwd132:
        IF uwd132.bencod = 'COMP' OR uwd132.bencod = 'COMG' OR
           uwd132.bencod = 'COMH'  THEN DO:
           n_prmcom   =  n_prmcom + uwd132.prem_c.
 
           n_stp      =  (uwd132.prem_c  *  0.4) / 100.
   
           IF n_stp - TRUNCATE(n_stp,0)  <> 0 then n_stp = TRUNCATE(n_stp,0) + 1.
           n_tstpcom  =  n_tstpcom + n_stp.
           n_taxcom   =  (n_prmcom + n_tstpcom) * uwm100.gstrat / 100.
        END.
        IF uwd132.bencod = "PA" THEN DO:
           n_paprm = n_paprm + uwd132.prem_c.
           n_stppa = (uwd132.prem_c  *  0.4) / 100.
   
           IF n_stppa - TRUNCATE(n_stppa,0)  <> 0 then n_stppa = TRUNCATE(n_stppa,0) + 1.
           n_tstppa = n_tstppa + n_stppa.
           n_taxpa = (n_paprm + n_tstppa) * uwm100.gstrat / 100.
        END.
        
        FIND NEXT uwd132 USE-INDEX uwd13290   WHERE
                  uwd132.policy = uwm100.policy AND
                  uwd132.rencnt = uwm100.rencnt AND
                  uwd132.endcnt = uwm100.endcnt NO-LOCK NO-ERROR.
   END.
   
   ASSIGN
       n_prmt    = 0        n_prms    = 0
       n_prmq    = 0        n_prmtfp  = 0
       n_prmrq   = 0        n_prmf1   = 0
       n_prmf2   = 0        n_prmr    = 0
       n_prmps   = 0        n_prmbtr  = 0
       n_prmotr  = 0        n_prms8   = 0
       n_prmf4   = 0        n_prmftr  = 0.

   LOOPB:
   REPEAT:
      n_cnt1  = n_cnt1 + 1.
      s_recid = RECID(uwm200).

      IF UWM100.TRANTY <> "C" THEN DO:
         RUN Pd_Process1.
      END.
      ELSE DO:
         RUN Pd_Process2.
      END.

      FIND NEXT uwm200  USE-INDEX  uwm20001  WHERE
                uwm200.policy = uwm100.policy  AND
                uwm200.rencnt = uwm100.rencnt  AND
                uwm200.endcnt = uwm100.endcnt
                NO-LOCK NO-ERROR.
      IF NOT AVAIL uwm200 THEN LEAVE loopb.
   END.   /* loopb */
   
   ASSIGN
        n_prmf1      =   n_prmf1     * (-1)
        n_prmf2      =   n_prmf2     * (-1)
        n_prmt       =   n_prmt      * (-1)
        n_prms       =   n_prms      * (-1)
        n_prmq       =   n_prmq      * (-1)
        n_prmtfp     =   n_prmtfp    * (-1)
        n_prmrq      =   n_prmrq     * (-1)
        n_prmps      =   n_prmps     * (-1)                
        n_prmbtr     =   n_prmbtr    * (-1)                
        n_prmotr     =   n_prmotr    * (-1)                
        n_prms8      =   n_prms8     * (-1)             
        n_prmf4      =   n_prmf4     * (-1)                
        n_prmftr     =   n_prmftr    * (-1).
   
   RUN Pd_detailNon.
   
   ASSIGN
        nv_sum    = 0 
        p_t       = 000  n_sumt     = 0   n_prmt    = 0
        p_s       = 000  n_sums     = 0   n_prms    = 0
        p_q       = 000  n_sumq     = 0   n_prmq    = 0
        p_tfp     = 000  n_sumtfp   = 0   n_prmtfp  = 0
        p_rq      = 000  n_sumrq    = 0   n_prmrq   = 0
        p_f1      = 000  n_sumf1    = 0   n_prmf1   = 0
        p_f2      = 000  n_sumf2    = 0   n_prmf2   = 0
        p_r       = 000  n_sumr     = 0   n_prmr    = 0
        p_ps      = 000  n_sumps    = 0   n_prmps   = 0 
        p_btr     = 000  n_sumbtr   = 0   n_prmbtr  = 0 
        p_otr     = 000  n_sumotr   = 0   n_prmotr  = 0 
        p_s8      = 000  n_sums8    = 0   n_prms8   = 0 
        p_f4      = 000  n_sumf4    = 0   n_prmf4   = 0
        p_ftr     = 000  n_sumftr   = 0   n_prmftr  = 0
        n_rb_pf   = 000  n_rb_sum   = 0   n_rb_prm  = 0
        n_rf_pf   = 000  n_rf_sum   = 0   n_rf_prm  = 0
        nv_prmtre = 0 . 

IF LAST-OF(uwm100.poltyp) THEN DO:
       
       ASSIGN
          pv_f1_prb   = pv_f1_prb   * (-1)      iv_f1_prb   = iv_f1_prb   * (-1)
          pv_f2_prb   = pv_f2_prb   * (-1)      iv_f2_prb   = iv_f2_prb   * (-1)
          pv_0t_prb   = pv_0t_prb   * (-1)      iv_0t_prb   = iv_0t_prb   * (-1)
          pv_0s_prb   = pv_0s_prb   * (-1)      iv_0s_prb   = iv_0s_prb   * (-1)
          pv_stat_prb = pv_stat_prb * (-1)      iv_stat_prb = iv_stat_prb * (-1)
          pv_0q_prb   = pv_0q_prb   * (-1)      iv_0q_prb   = iv_0q_prb   * (-1)
          pv_0rq_prb  = pv_0rq_prb  * (-1)      iv_0rq_prb  = iv_0rq_prb  * (-1)
          pv_0f_prb   = pv_0f_prb   * (-1)      iv_0f_prb   = iv_0f_prb   * (-1)
          nv_f1_prb   = nv_f1_prb   * (-1)      nv_f2_prb   = nv_f2_prb   * (-1)
          nv_0t_prb   = nv_0t_prb   * (-1)      nv_0s_prb   = nv_0s_prb   * (-1)
          nv_stat_prb = nv_stat_prb * (-1)      nv_0q_prb   = nv_0q_prb   * (-1)
          nv_0rq_prb  = nv_0rq_prb  * (-1)      nv_0f_prb   = nv_0f_prb   * (-1)
          pv_s8_prb   = pv_s8_prb   * (-1)      iv_s8_prb   = iv_s8_prb   * (-1) 

          nv_0ps_prb  = nv_0ps_prb  * (-1)
          pv_0ps_prb  = pv_0ps_prb  * (-1)      iv_0ps_prb   = iv_0ps_prb   * (-1)
          
          nv_btr_prb  = nv_btr_prb  * (-1)
          pv_btr_prb  = pv_btr_prb  * (-1)      iv_btr_prb   = iv_btr_prb   * (-1)
          nv_otr_prb  = nv_otr_prb  * (-1)
          pv_otr_prb  = pv_otr_prb  * (-1)      iv_otr_prb   = iv_otr_prb   * (-1)

          nv_f4_prb   = nv_f4_prb   * (-1)
          pv_f4_prb   = pv_f4_prb   * (-1)      iv_f4_prb    = iv_f4_prb    * (-1)
          nv_ftr_prb  = nv_ftr_prb  * (-1)
          pv_ftr_prb  = pv_ftr_prb  * (-1)      iv_ftr_prb   = iv_ftr_prb   * (-1).
       
          FIND FIRST wtotal WHERE wtotal.poltyp = SUBSTR(uwm100.poltyp,2,2) NO-LOCK NO-ERROR.
          IF NOT AVAIL wtotal THEN DO:
              CREATE wtotal.
              ASSIGN 
                  wtotal.poltyp    = SUBSTR(uwm100.poltyp,2,2)
                  wtotal.totprmcom = nv_totprmcom 
                  wtotal.totearn   = nv_totearn   
                  wtotal.totuearn  = nv_totuearn
                  /* comment by Benjaporn J. A58-0242
                  wtotal.totprmtre = nv_totprmtre 
                  wtotal.totearn2  = nv_totearn2  
                  wtotal.totuearn2 = nv_totuearn2 */
                  /* start A58-0242 Benjaporn J. 13/07/2015 */
                  wtotal.totprmtrt   = nv_totprmtrt 
                  wtotal.totearntrt  = nv_totearntrt  
                  wtotal.totuearntrt = nv_totuearntrt
                  wtotal.totprmfac   = nv_totprmfac
                  wtotal.totearnfac  = nv_totearnfac  
                  wtotal.totuearnfac = nv_totuearnfac.  /* end A58-0242 Benjaporn J. 13/07/2015 */
          END.
          ASSIGN
              nv_totprmcom    = 0    
              nv_totearn      = 0    
              nv_totuearn     = 0
              nv_totprmtrt    = 0 
              nv_totearntrt   = 0 
              nv_totuearntrt  = 0 
              nv_totprmfac    = 0 
              nv_totearnfac   = 0 
              nv_totuearnfac  = 0  .
          /* comment by Benjaporn J. A58-0242
              nv_totprmtre = 0    nv_totearn2  = 0
              nv_totuearn2 = 0  */
   END.
END.

PUT STREAM ns1
    "Grand Total"   SKIP.

loopmain1:
FOR EACH wtotal BREAK BY wtotal.poltyp.

    FIND xmm031 USE-INDEX xmm03101       WHERE 
         xmm031.poltyp = wtotal.poltyp   NO-LOCK NO-ERROR.
    IF AVAIL xmm031 THEN DO:

       IF xmm031.dept = "G" OR xmm031.dept = "M" THEN NEXT loopmain1.
       IF LOOKUP(xmm031.poltyp,nv_poltyp) <> 0  THEN NEXT loopmain1.
    END.
    
    IF wtotal.totprmcom = 0 AND wtotal.totsumprm = 0 AND
       wtotal.totearn   = 0 AND wtotal.totuearn  = 0 AND
        /* comment by Benjaporn J. A58-0242
       wtotal.totearn2  = 0 AND wtotal.totuearn2 = 0 THEN DO:  */
        /* start A58-0242 Benjaporn J. 13/07/2015 */
       wtotal.totearntrt  = 0 AND wtotal.totuearntrt = 0 AND
       wtotal.totearnfac  = 0 AND wtotal.totuearnfac = 0 THEN DO:  /* end A58-0242 Benjaporn J. 13/07/2015 */

    END.
    ELSE DO:
        PUT STREAM ns1
            "Line  " wtotal.poltyp "|" "|" "|" "|" "|" "|" "|" "|" "|" "|"
            wtotal.totprmcom "|"
            wtotal.totearn   "|"
            wtotal.totuearn  "|"
            /* comment by Benjaporn J. A58-0242
            wtotal.totprmtre "|"
            wtotal.totearn2  "|"
            wtotal.totuearn2 "|" */
            /* start A58-0242 Benjaporn J. 13/07/2015 */
            wtotal.totprmtrt   "|"
            wtotal.totearntrt  "|"
            wtotal.totuearntrt "|"
            wtotal.totprmfac   "|"
            wtotal.totearnfac  "|"
            wtotal.totuearnfac SKIP.  /* end A58-0242 Benjaporn J. 13/07/2015 */
    END.
END.    
/*---A56-0092---*/
PUT STREAM ns3
    "Cancel - Grand Total"  "|" "|" "|" "|" "|" "|" "|" "|" "|" "|"
    nv_ctotprmcom "|" 
    nv_ctotearn   "|" 
    nv_ctotuearn  "|"
    /* comment by Benjaporn J. A58-0242
    nv_ctotprmtre "|" 
    nv_ctotearn2  "|" 
    nv_ctotuearn2 SKIP.  */
    /* start A58-0242 Benjaporn J. 13/07/2015 */
    nv_ctotprmtrt   "|" 
    nv_ctotearntrt  "|" 
    nv_ctotuearntrt "|" 
    nv_ctotprmfac   "|" 
    nv_ctotearnfac  "|" 
    nv_ctotuearnfac SKIP. /*--end A56-0092---*/   /* end A58-0242 Benjaporn J. 13/07/2015 */

OUTPUT STREAM ns1 CLOSE.
OUTPUT STREAM ns2 CLOSE.
OUTPUT STREAM ns3 CLOSE.    /*A56-0092*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pd_Process1 C-Win 
PROCEDURE Pd_Process1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FIND FIRST xmm024 NO-LOCK NO-ERROR.
FIND uwm200 WHERE RECID(uwm200) = s_recid NO-WAIT NO-ERROR .
FIND FIRST uwd200 USE-INDEX uwd20001 WHERE  uwd200.policy = uwm200.policy AND
                                            uwd200.rencnt = uwm200.rencnt AND
                                            uwd200.endcnt = uwm200.endcnt AND
                                            uwd200.c_enct = uwm200.c_enct AND
                                            uwd200.csftq  = uwm200.csftq  AND
                                            uwd200.rico   = uwm200.rico
                                            NO-LOCK NO-ERROR.
IF NOT AVAIL uwd200 THEN DO:
  /* display  "*** uwd200 invalid ***".    */
END.
ELSE DO:
   REPEAT:
      wrk_si  = 0.     bwrk_si = 0.
      FIND FIRST buwd200 WHERE buwd200.policy = uwm200.policy AND
                         buwd200.rencnt = uwm200.rencnt AND
                         buwd200.endcnt = n_endcnt      AND
                         buwd200.c_enct = uwm200.c_enct AND
                         buwd200.csftq  = uwm200.csftq  AND
                         buwd200.rico   = uwm200.rico   AND
                         buwd200.riskgp = uwd200.riskgp AND
                         buwd200.riskno = uwd200.riskno
      NO-LOCK NO-ERROR.
      IF NOT AVAIL buwd200 THEN DO:
        wrk_si  = uwd200.risi.
      END.
      ELSE DO:
        bwrk_si = buwd200.risi.
        wrk_si  = uwd200.risi - bwrk_si.
      END.

      FIND FIRST uwm120 USE-INDEX uwm12001     WHERE
                 uwm120.policy = uwd200.policy  AND
                 uwm120.rencnt = uwd200.rencnt  AND
                 uwm120.endcnt = uwd200.endcnt  AND
                 uwm120.riskgp = uwd200.riskgp AND
                 uwm120.riskno = uwd200.riskno
      NO-LOCK NO-ERROR.
      IF AVAIL uwm120 THEN DO:
          IF SUBSTRING(uwm120.policy,3,2) = "90" THEN nvexch = 1.
                                                 ELSE nvexch = uwm120.siexch.
      END.

      IF uwd200.rico = "STAT"  THEN DO:
        ASSIGN
          nv_stat_si  = nv_stat_si  + ((uwd200.risi - bwrk_si) * nvexch )
          nv_stat_pr  = nv_stat_pr  + (uwd200.ripr)
          nv_stat_sib = nv_stat_sib + ((uwd200.risi - bwrk_si) * nvexch )
          nv_stat_prb = nv_stat_prb + (uwd200.ripr)
          n_sumq      = n_sumq      + ((uwd200.risi - bwrk_si) * nvexch )
          n_prmq      = n_prmq      + (uwd200.ripr)
          p_q         = uwd200.risi_p.
        /*มีเบี้ย ต้องจ่ายออก*/
        IF uwd200.ripr < 0  THEN  DO:
          
          ASSIGN
            pv_stat_si   = pv_stat_si  + ((uwd200.risi - bwrk_si) * nvexch )
            pv_stat_pr   = pv_stat_pr  + (uwd200.ripr)
            pv_stat_sib  = pv_stat_sib + ((uwd200.risi - bwrk_si) * nvexch )
            pv_stat_prb  = pv_stat_prb + (uwd200.ripr).
        END.
        ELSE DO:
          ASSIGN
            iv_stat_si   = iv_stat_si  + ((uwd200.risi - bwrk_si) * nvexch )
            iv_stat_pr   = iv_stat_pr  + (uwd200.ripr)
            iv_stat_sib  = iv_stat_sib + ((uwd200.risi - bwrk_si) * nvexch )
            iv_stat_prb  = iv_stat_prb + (uwd200.ripr).
         END.
      END.
      IF SUBSTRING(uwd200.rico,1,3) = "0RQ"  THEN DO:
        ASSIGN
          nv_0rq_si  = nv_0rq_si  + ((uwd200.risi - bwrk_si) * nvexch )
          nv_0rq_pr  = nv_0rq_pr  + (uwd200.ripr)
          nv_0rq_sib = nv_0rq_sib + ((uwd200.risi - bwrk_si) * nvexch )
          nv_0rq_prb = nv_0rq_prb + (uwd200.ripr)
          n_sumrq    = n_sumrq    + ((uwd200.risi - bwrk_si) * nvexch )
          n_prmrq    = n_prmrq    + (uwd200.ripr)
          p_rq       = uwd200.risi_p.

        IF uwd200.ripr < 0  THEN  DO:
          ASSIGN
            pv_0rq_si   = pv_0rq_si  + ((uwd200.risi - bwrk_si) * nvexch )
            pv_0rq_pr   = pv_0rq_pr  + (uwd200.ripr)
            pv_0rq_sib  = pv_0rq_sib + ((uwd200.risi - bwrk_si) * nvexch )
            pv_0rq_prb  = pv_0rq_prb + (uwd200.ripr).
        END.
        ELSE DO:
          ASSIGN
            iv_0rq_si   = iv_0rq_si  + ((uwd200.risi - bwrk_si) * nvexch )
            iv_0rq_pr   = iv_0rq_pr  + (uwd200.ripr)
            iv_0rq_sib  = iv_0rq_sib + ((uwd200.risi - bwrk_si) * nvexch )
            iv_0rq_prb  = iv_0rq_prb + (uwd200.ripr).
        END.
      END.

      IF SUBSTRING(uwd200.rico,1,2) = "0Q" THEN DO:
        ASSIGN
          nv_0q_si  = nv_0q_si  + ((uwd200.risi - bwrk_si) * nvexch )
          nv_0q_pr  = nv_0q_pr  + (uwd200.ripr)
          nv_0q_sib = nv_0q_sib + ((uwd200.risi - bwrk_si) * nvexch )
          nv_0q_prb = nv_0q_prb + (uwd200.ripr)
          n_sumtfp  = n_sumtfp  + ((uwd200.risi - bwrk_si) * nvexch )
          n_prmtfp  = n_prmtfp  + (uwd200.ripr)
          p_tfp     = uwd200.risi_p.

        IF uwd200.ripr < 0  THEN  DO:
          ASSIGN
            pv_0q_si   = pv_0q_si  + ((uwd200.risi - bwrk_si) * nvexch )
            pv_0q_pr   = pv_0q_pr  + (uwd200.ripr)
            pv_0q_sib  = pv_0q_sib + ((uwd200.risi - bwrk_si) * nvexch )
            pv_0q_prb  = pv_0q_prb + (uwd200.ripr).
        END.
        ELSE DO:
          ASSIGN
            iv_0q_si   = iv_0q_si  + ((uwd200.risi - bwrk_si) * nvexch )
            iv_0q_pr   = iv_0q_pr  + (uwd200.ripr)
            iv_0q_sib  = iv_0q_sib + ((uwd200.risi - bwrk_si) * nvexch )
            iv_0q_prb  = iv_0q_prb + (uwd200.ripr).
        END.
      END.

      IF SUBSTRING(uwd200.rico,1,2) = "0T"  AND
         SUBSTRING(uwd200.rico,6,2) = "01"  THEN DO:
        ASSIGN
          nv_0t_si  = nv_0t_si  + ((uwd200.risi - bwrk_si) * nvexch )
          nv_0t_pr  = nv_0t_pr  + (uwd200.ripr)
          nv_0t_sib = nv_0t_sib + ((uwd200.risi - bwrk_si) * nvexch )
          nv_0t_prb = nv_0t_prb + (uwd200.ripr)
          n_sumt    = n_sumt    + ((uwd200.risi - bwrk_si) * nvexch )
          n_prmt    = n_prmt    + (uwd200.ripr)
          p_t       = uwd200.risi_p.
                                        /* สลักหลังเบี้ย เพิ่ม */
        IF uwd200.ripr < 0  THEN  DO:
          ASSIGN
            pv_0t_si   = pv_0t_si  + ((uwd200.risi - bwrk_si) * nvexch )
            pv_0t_pr   = pv_0t_pr  + (uwd200.ripr)
            pv_0t_sib  = pv_0t_sib + ((uwd200.risi - bwrk_si) * nvexch )
            pv_0t_prb  = pv_0t_prb + (uwd200.ripr).

        END.
        ELSE DO:
          ASSIGN
            iv_0t_si   = iv_0t_si  + ((uwd200.risi - bwrk_si) * nvexch )
            iv_0t_pr   = iv_0t_pr  + (uwd200.ripr)
            iv_0t_sib  = iv_0t_sib + ((uwd200.risi - bwrk_si) * nvexch )
            iv_0t_prb  = iv_0t_prb + (uwd200.ripr).
        END.
      END.
      /*----
      IF SUBSTRING(uwd200.rico,1,2) = "0T"  AND
         SUBSTRING(uwd200.rico,6,2) = "02"  THEN DO:
        ASSIGN
          nv_0s_si  = nv_0s_si  + ((uwd200.risi - bwrk_si) * nvexch )
          nv_0s_pr  = nv_0s_pr  + (uwd200.ripr)
          nv_0s_sib = nv_0s_sib + ((uwd200.risi - bwrk_si) * nvexch )
          nv_0s_prb = nv_0s_prb + (uwd200.ripr)
          n_sums    = n_sums    + ((uwd200.risi - bwrk_si) * nvexch )
          n_prms    = n_prms    + (uwd200.ripr)
          p_s       = uwd200.risi_p.

        IF uwd200.ripr < 0  THEN  DO:

          ASSIGN
            pv_0s_si   = pv_0s_si  + ((uwd200.risi - bwrk_si) * nvexch )
            pv_0s_pr   = pv_0s_pr  + (uwd200.ripr)
            pv_0s_sib  = pv_0s_sib + ((uwd200.risi - bwrk_si) * nvexch )
            pv_0s_prb  = pv_0s_prb + (uwd200.ripr).
        END.
        ELSE DO:
          ASSIGN
            iv_0s_si   = iv_0s_si  + ((uwd200.risi - bwrk_si) * nvexch )
            iv_0s_pr   = iv_0s_pr  + (uwd200.ripr)
            iv_0s_sib  = iv_0s_sib + ((uwd200.risi - bwrk_si) * nvexch )
            iv_0s_prb  = iv_0s_prb + (uwd200.ripr).
        END.
      END.
      Lukkana M. A55-0239 18/07/2012---*/

      IF SUBSTRING(uwd200.rico,1,2) = "0T"  AND
         SUBSTRING(uwd200.rico,6,2) = "f1"  THEN DO:

        ASSIGN
          nv_f1_si  = nv_f1_si  + ((uwd200.risi - bwrk_si) * nvexch )
          nv_f1_pr  = nv_f1_pr  + (uwd200.ripr)
          nv_f1_sib = nv_f1_sib + ((uwd200.risi - bwrk_si) * nvexch )
          nv_f1_prb = nv_f1_prb + (uwd200.ripr)
          n_sumf1   = n_sumf1   + ((uwd200.risi - bwrk_si) * nvexch )
          n_prmf1   = n_prmf1   + (uwd200.ripr)
          p_f1      = uwd200.risi_p.

        IF uwd200.ripr < 0  THEN  DO:

          ASSIGN
            pv_f1_si   = pv_f1_si  + ((uwd200.risi - bwrk_si) * nvexch )
            pv_f1_pr   = pv_f1_pr  + (uwd200.ripr)
            pv_f1_sib  = pv_f1_sib + ((uwd200.risi - bwrk_si) * nvexch )
            pv_f1_prb  = pv_f1_prb + (uwd200.ripr).
        END.
        ELSE DO:
          ASSIGN
            iv_f1_si   = iv_f1_si  + ((uwd200.risi - bwrk_si) * nvexch )
            iv_f1_pr   = iv_f1_pr  + (uwd200.ripr)
            iv_f1_sib  = iv_f1_sib + ((uwd200.risi - bwrk_si) * nvexch )
            iv_f1_prb  = iv_f1_prb + (uwd200.ripr).
        END.
      END.

      IF SUBSTRING(uwd200.rico,1,2) = "0T"  AND
         SUBSTRING(uwd200.rico,6,2) = "f2"  THEN DO:

        ASSIGN
          nv_f2_si  = nv_f2_si  + ((uwd200.risi - bwrk_si) * nvexch )
          nv_f2_pr  = nv_f2_pr  + (uwd200.ripr)
          nv_f2_sib = nv_f2_sib + ((uwd200.risi - bwrk_si) * nvexch )
          nv_f2_prb = nv_f2_prb + (uwd200.ripr)
          n_sumf2   = n_sumf2   + ((uwd200.risi - bwrk_si) * nvexch )
          n_prmf2   = n_prmf2   + (uwd200.ripr)
          p_f2      = uwd200.risi_p.

        IF uwd200.ripr < 0  THEN  DO:

          ASSIGN
            pv_f2_si   = pv_f2_si  + ((uwd200.risi - bwrk_si) * nvexch )
            pv_f2_pr   = pv_f2_pr  + (uwd200.ripr)
            pv_f2_sib  = pv_f2_sib + ((uwd200.risi - bwrk_si) * nvexch )
            pv_f2_prb  = pv_f2_prb + (uwd200.ripr).
        END.
        ELSE DO:

          ASSIGN
            iv_f2_si   = iv_f2_si  + ((uwd200.risi - bwrk_si) * nvexch )
            iv_f2_pr   = iv_f2_pr  + (uwd200.ripr)
            iv_f2_sib  = iv_f2_sib + ((uwd200.risi - bwrk_si) * nvexch )
            iv_f2_prb  = iv_f2_prb + (uwd200.ripr).
        END.
      END.
      IF SUBSTRING(uwd200.rico,1,3) = "0PS" THEN DO:

        ASSIGN
          nv_0ps_si  = nv_0ps_si  + ((uwd200.risi - bwrk_si) * nvexch )
          nv_0ps_pr  = nv_0ps_pr  + (uwd200.ripr)
          nv_0ps_sib = nv_0ps_sib + ((uwd200.risi - bwrk_si) * nvexch )
          nv_0ps_prb = nv_0ps_prb + (uwd200.ripr)
          n_sumps    = n_sumps    + ((uwd200.risi - bwrk_si) * nvexch )
          n_prmps    = n_prmps    + (uwd200.ripr)
          p_ps       = uwd200.risi_p.

        IF uwd200.ripr < 0  THEN  DO:
       ASSIGN
            pv_0ps_si   = pv_0ps_si  + ((uwd200.risi - bwrk_si) * nvexch )
            pv_0ps_pr   = pv_0ps_pr  + (uwd200.ripr)
            pv_0ps_sib  = pv_0ps_sib + ((uwd200.risi - bwrk_si) * nvexch )
            pv_0ps_prb  = pv_0ps_prb + (uwd200.ripr).
        END.
        ELSE DO:

          ASSIGN
            iv_0ps_si   = iv_0ps_si  + ((uwd200.risi - bwrk_si) * nvexch )
            iv_0ps_pr   = iv_0ps_pr  + (uwd200.ripr)
            iv_0ps_sib  = iv_0ps_sib + ((uwd200.risi - bwrk_si) * nvexch )
            iv_0ps_prb  = iv_0ps_prb + (uwd200.ripr).
        END.
      END.

      IF SUBSTRING(uwd200.rico,1,3) = "0TF" AND
         SUBSTRING(uwd200.rico,6,2) = "FB"  THEN DO:

        ASSIGN
          nv_btr_si  = nv_btr_si  + ((uwd200.risi - bwrk_si) * nvexch )
          nv_btr_pr  = nv_btr_pr  + (uwd200.ripr)
          nv_btr_sib = nv_btr_sib + ((uwd200.risi - bwrk_si) * nvexch )
          nv_btr_prb = nv_btr_prb + (uwd200.ripr)
          n_sumbtr   = n_sumbtr   + ((uwd200.risi - bwrk_si) * nvexch )
          n_prmbtr   = n_prmbtr   + (uwd200.ripr)
          p_btr      = uwd200.risi_p.

        IF uwd200.ripr < 0  THEN  DO:

          ASSIGN
            pv_btr_si   = pv_btr_si  + ((uwd200.risi - bwrk_si) * nvexch )
            pv_btr_pr   = pv_btr_pr  + (uwd200.ripr)
            pv_btr_sib  = pv_btr_sib + ((uwd200.risi - bwrk_si) * nvexch )
            pv_btr_prb  = pv_btr_prb + (uwd200.ripr).
        END.
        ELSE DO:

          ASSIGN
            iv_btr_si   = iv_btr_si  + ((uwd200.risi - bwrk_si) * nvexch )
            iv_btr_pr   = iv_btr_pr  + (uwd200.ripr)
            iv_btr_sib  = iv_btr_sib + ((uwd200.risi - bwrk_si) * nvexch )
            iv_btr_prb  = iv_btr_prb + (uwd200.ripr).
        END.
      END.

      IF SUBSTRING(uwd200.rico,1,3) = "0TF" AND
         SUBSTRING(uwd200.rico,6,2) = "FO"  THEN DO:

        ASSIGN
          nv_otr_si  = nv_otr_si  + ((uwd200.risi - bwrk_si) * nvexch )
          nv_otr_pr  = nv_otr_pr  + (uwd200.ripr)
          nv_otr_sib = nv_otr_sib + ((uwd200.risi - bwrk_si) * nvexch )
          nv_otr_prb = nv_otr_prb + (uwd200.ripr)
          n_sumotr    = n_sumotr  + ((uwd200.risi - bwrk_si) * nvexch )
          n_prmotr    = n_prmotr  + (uwd200.ripr)
          p_otr       = uwd200.risi_p.

        IF uwd200.ripr < 0  THEN  DO:

          ASSIGN
            pv_otr_si   = pv_otr_si  + ((uwd200.risi - bwrk_si) * nvexch )
            pv_otr_pr   = pv_otr_pr  + (uwd200.ripr)
            pv_otr_sib  = pv_otr_sib + ((uwd200.risi - bwrk_si) * nvexch )
            pv_otr_prb  = pv_otr_prb + (uwd200.ripr).
        END.
        ELSE DO:

          ASSIGN
            iv_otr_si   = iv_otr_si  + ((uwd200.risi - bwrk_si) * nvexch )
            iv_otr_pr   = iv_otr_pr  + (uwd200.ripr)
            iv_otr_sib  = iv_otr_sib + ((uwd200.risi - bwrk_si) * nvexch )
            iv_otr_prb  = iv_otr_prb + (uwd200.ripr).
        END.
      END.
         
      /*---
      IF (SUBSTRING(uwd200.rico,1,4) = "0TA8" AND
          SUBSTRING(uwd200.rico,7,1) = "2")    OR
         (SUBSTRING(uwd200.rico,1,2) = "0T"   AND
          SUBSTRING(uwd200.rico,6,2) = "F3")  THEN DO:  
      Lukkana M. A55-0239 18/07/2012--*/
      IF (SUBSTRING(uwd200.rico,1,2) = "0T"   AND
          SUBSTRING(uwd200.rico,6,2) = "02")   OR /*Lukkana M. A55-0239 18/07/2012*/
         (SUBSTRING(uwd200.rico,1,4) = "0TA8" AND
          SUBSTRING(uwd200.rico,7,1) = "2")    OR
         (SUBSTRING(uwd200.rico,1,2) = "0T"   AND
          SUBSTRING(uwd200.rico,6,2) = "F3")  THEN DO:  

        ASSIGN
          nv_s8_si  = nv_s8_si  + ((uwd200.risi - bwrk_si) * nvexch )
          nv_s8_pr  = nv_s8_pr  + (uwd200.ripr)
          nv_s8_sib = nv_s8_sib + ((uwd200.risi - bwrk_si) * nvexch )
          nv_s8_prb = nv_s8_prb + (uwd200.ripr)
          n_sums8   = n_sums8   + ((uwd200.risi - bwrk_si) * nvexch )
          n_prms8   = n_prms8   + (uwd200.ripr)
          p_s8      = uwd200.risi_p.

        IF uwd200.ripr < 0  THEN  DO:
      
          ASSIGN
            pv_s8_si   = pv_s8_si  + ((uwd200.risi - bwrk_si) * nvexch )
            pv_s8_pr   = pv_s8_pr  + (uwd200.ripr)
            pv_s8_sib  = pv_s8_sib + ((uwd200.risi - bwrk_si) * nvexch )
            pv_s8_prb  = pv_s8_prb + (uwd200.ripr).
        END.
        ELSE DO:
          ASSIGN
            iv_s8_si   = iv_s8_si  + ((uwd200.risi - bwrk_si) * nvexch )
            iv_s8_pr   = iv_s8_pr  + (uwd200.ripr)
            iv_s8_sib  = iv_s8_sib + ((uwd200.risi - bwrk_si) * nvexch )
            iv_s8_prb  = iv_s8_prb + (uwd200.ripr).
        END.
      END.
      IF SUBSTRING(uwd200.rico,1,2) = "0T"  AND
         SUBSTRING(uwd200.rico,6,2) = "F4"  THEN DO:
        ASSIGN
          nv_f4_si  = nv_f4_si  + ((uwd200.risi - bwrk_si) * nvexch )
          nv_f4_pr  = nv_f4_pr  + (uwd200.ripr)
          nv_f4_sib = nv_f4_sib + ((uwd200.risi - bwrk_si) * nvexch )
          nv_f4_prb = nv_f4_prb + (uwd200.ripr)
          n_sumf4   = n_sumf4   + ((uwd200.risi - bwrk_si) * nvexch )
          n_prmf4   = n_prmf4   + (uwd200.ripr)
          p_f4      = uwd200.risi_p.

        IF uwd200.ripr < 0  THEN  DO:

          ASSIGN
            pv_f4_si   = pv_f4_si  + ((uwd200.risi - bwrk_si) * nvexch )
            pv_f4_pr   = pv_f4_pr  + (uwd200.ripr)
            pv_f4_sib  = pv_f4_sib + ((uwd200.risi - bwrk_si) * nvexch )
            pv_f4_prb  = pv_f4_prb + (uwd200.ripr).
        END.
        ELSE DO:
          ASSIGN
            iv_f4_si   = iv_f4_si  + ((uwd200.risi - bwrk_si) * nvexch )
            iv_f4_pr   = iv_f4_pr  + (uwd200.ripr)
            iv_f4_sib  = iv_f4_sib + ((uwd200.risi - bwrk_si) * nvexch )
            iv_f4_prb  = iv_f4_prb + (uwd200.ripr).
        END.
      END.
      
      IF SUBSTRING(uwd200.rico,1,2) = "0T"  AND
         SUBSTRING(uwd200.rico,6,2) = "FT"  THEN DO:
        ASSIGN
          nv_ftr_si  = nv_ftr_si  + ((uwd200.risi - bwrk_si) * nvexch )
          nv_ftr_pr  = nv_ftr_pr  + (uwd200.ripr)
          nv_ftr_sib = nv_ftr_sib + ((uwd200.risi - bwrk_si) * nvexch )
          nv_ftr_prb = nv_ftr_prb + (uwd200.ripr)
          n_sumftr   = n_sumftr   + ((uwd200.risi - bwrk_si) * nvexch )
          n_prmftr   = n_prmftr   + (uwd200.ripr)
          p_ftr      = uwd200.risi_p.

        IF uwd200.ripr < 0  THEN  DO:

          ASSIGN
            pv_ftr_si   = pv_ftr_si  + ((uwd200.risi - bwrk_si) * nvexch )
            pv_ftr_pr   = pv_ftr_pr  + (uwd200.ripr)
            pv_ftr_sib  = pv_ftr_sib + ((uwd200.risi - bwrk_si) * nvexch )
            pv_ftr_prb  = pv_ftr_prb + (uwd200.ripr).
        END.
        ELSE DO:
          ASSIGN
            iv_ftr_si   = iv_ftr_si  + ((uwd200.risi - bwrk_si) * nvexch )
            iv_ftr_pr   = iv_ftr_pr  + (uwd200.ripr)
            iv_ftr_sib  = iv_ftr_sib + ((uwd200.risi - bwrk_si) * nvexch )
            iv_ftr_prb  = iv_ftr_prb + (uwd200.ripr).
        END.
      END.

      IF SUBSTRING(uwd200.rico,1,2) = "0D" OR
         SUBSTRING(uwd200.rico,1,2) = "0F"  THEN DO:
          nv_0f_sib  = nv_0f_sib  + ROUND(((uwd200.risi - bwrk_si) * nvexch),2).
          nv_0f_prb  = nv_0f_prb  + ROUND((uwd200.ripr),2).

        IF uwd200.ripr < 0  THEN  DO:

            pv_0f_sib  = pv_0f_sib + ROUND(((uwd200.risi - bwrk_si) * nvexch),2).
            pv_0f_prb  = pv_0f_prb + ROUND((uwd200.ripr),2).
        END.
        ELSE DO:

            iv_0f_sib  = iv_0f_sib + ROUND(((uwd200.risi - bwrk_si) * nvexch),2).
            iv_0f_prb  = iv_0f_prb + ROUND((uwd200.ripr),2).
        END.

        FIND FIRST wrk0f WHERE wrk0f.rico = uwd200.rico NO-ERROR.
        IF AVAILABLE wrk0f THEN DO:
            wrk0f.sumf = wrk0f.sumf + ROUND(((uwd200.risi - bwrk_si) * nvexch),2).
            wrk0f.prmf = wrk0f.prmf + ROUND((uwd200.ripr),2).
        END.
        ELSE DO:
            CREATE   wrk0f.
            ASSIGN
               wrk0f.sumf   = ROUND(((uwd200.risi - bwrk_si) * nvexch),2)
               wrk0f.prmf   = ROUND((uwd200.ripr),2)
               wrk0f.pf     = uwd200.risi_p
               wrk0f.rico   = uwd200.rico
               wrk0f.cess   = uwm200.c_enno.
        END.
      END.

      FIND NEXT uwd200 USE-INDEX uwd20001     WHERE
                uwd200.policy = uwm200.policy  AND
                uwd200.rencnt = uwm200.rencnt  AND
                uwd200.endcnt = uwm200.endcnt  AND
                uwd200.c_enct = uwm200.c_enct  AND
                uwd200.csftq  = uwm200.csftq   AND
                uwd200.rico   = uwm200.rico    NO-LOCK NO-ERROR.
      IF NOT AVAIL uwd200 THEN LEAVE.

   END. /* repeat */
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pd_Process2 C-Win 
PROCEDURE Pd_Process2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

FIND FIRST xmm024 NO-LOCK NO-ERROR.
FIND uwm200 WHERE RECID(uwm200) = s_recid NO-WAIT NO-ERROR .
FIND FIRST uwd200 USE-INDEX uwd20001 WHERE uwd200.policy = uwm200.policy AND
                                           uwd200.rencnt = uwm200.rencnt AND
                                           uwd200.endcnt = uwm200.endcnt AND
                                           uwd200.c_enct = uwm200.c_enct AND
                                           uwd200.csftq  = uwm200.csftq  AND
                                           uwd200.rico   = uwm200.rico
                                           NO-LOCK NO-ERROR.
   IF NOT AVAIL uwd200 THEN DO:
    /*  DISPLAY  " *** UWD200 INVALID *** "  .  */
   END.
   ELSE DO:
     REPEAT:

       FIND FIRST uwm120 USE-INDEX uwm12001 WHERE uwm120.policy = uwd200.policy AND
                                                  uwm120.rencnt = uwd200.rencnt AND
                                                  uwm120.endcnt = uwd200.endcnt AND
                                                  uwm120.riskgp = uwd200.riskgp AND
                                                  uwm120.riskno = uwd200.riskno
                                                  NO-LOCK NO-ERROR.
       IF AVAIL uwm120 THEN DO:
           IF SUBSTRING(uwm120.policy,3,2) = "90" THEN nvexch = 1.
           ELSE nvexch = uwm120.siexch.
       END.

       IF uwd200.rico  = "STAT"  THEN DO:
          ASSIGN
          nv_stat_si   = nv_stat_si  + ((uwd200.risi * -1) * nvexch )
          nv_stat_pr   = nv_stat_pr  + (uwd200.ripr)
          nv_stat_sib  = nv_stat_sib + ((uwd200.risi * -1) * nvexch )
          nv_stat_prb  = nv_stat_prb + (uwd200.ripr)
          iv_stat_si   = iv_stat_si  + ((uwd200.risi * -1) * nvexch )
          iv_stat_pr   = iv_stat_pr  + (uwd200.ripr)
          iv_stat_sib  = iv_stat_sib + ((uwd200.risi * -1) * nvexch )
          iv_stat_prb  = iv_stat_prb + (uwd200.ripr)
          n_sumq       = n_sumq      + ((uwd200.risi * -1) * nvexch )
          n_prmq       = n_prmq      + (uwd200.ripr)
          p_q          = uwd200.risi_p.
       END.
       IF SUBSTRING(uwd200.rico,1,3) = "0RQ"  THEN DO:
          ASSIGN
          nv_0rq_si   = nv_0rq_si  + ((uwd200.risi * -1) * nvexch )
          nv_0rq_pr   = nv_0rq_pr  + (uwd200.ripr)
          nv_0rq_sib  = nv_0rq_sib + ((uwd200.risi * -1) * nvexch )
          nv_0rq_prb  = nv_0rq_prb + (uwd200.ripr)
          iv_0rq_si   = iv_0rq_si  + ((uwd200.risi * -1) * nvexch )
          iv_0rq_pr   = iv_0rq_pr  + (uwd200.ripr)
          iv_0rq_sib  = iv_0rq_sib + ((uwd200.risi * -1) * nvexch )
          iv_0rq_prb  = iv_0rq_prb + (uwd200.ripr)
          n_sumrq     = n_sumrq    + ((uwd200.risi * -1) * nvexch )
          n_prmrq     = n_prmrq    + (uwd200.ripr)
          p_rq        = uwd200.risi_p.
       END.

       IF SUBSTRING(uwd200.rico,1,2) = "0Q"  THEN DO:
         ASSIGN
         nv_0q_si   = nv_0q_si  + ((uwd200.risi * -1) * nvexch )
         nv_0q_pr   = nv_0q_pr  + (uwd200.ripr)
         nv_0q_sib  = nv_0q_sib + ((uwd200.risi * -1) * nvexch )
         nv_0q_prb  = nv_0q_prb + (uwd200.ripr)
         iv_0q_si   = iv_0q_si  + ((uwd200.risi * -1) * nvexch )
         iv_0q_pr   = iv_0q_pr  + (uwd200.ripr)
         iv_0q_sib  = iv_0q_sib + ((uwd200.risi * -1) * nvexch )
         iv_0q_prb  = iv_0q_prb + (uwd200.ripr)
         n_sumtfp   = n_sumtfp  + ((uwd200.risi * -1) * nvexch )
         n_prmtfp   = n_prmtfp  + (uwd200.ripr)
         p_tfp      = uwd200.risi_p.
       END.

       IF SUBSTRING(uwd200.rico,1,2) = "0T"
          AND SUBSTRING(uwd200.rico,6,2) = "01"  THEN DO:
          ASSIGN
          nv_0t_si   = nv_0t_si  + ((uwd200.risi * -1) * nvexch )
          nv_0t_pr   = nv_0t_pr  + (uwd200.ripr)
          nv_0t_sib  = nv_0t_sib + ((uwd200.risi * -1) * nvexch )
          nv_0t_prb  = nv_0t_prb + (uwd200.ripr)
          iv_0t_si   = iv_0t_si  + ((uwd200.risi * -1) * nvexch )
          iv_0t_pr   = iv_0t_pr  + (uwd200.ripr)
          iv_0t_sib  = iv_0t_sib + ((uwd200.risi * -1) * nvexch )
          iv_0t_prb  = iv_0t_prb + (uwd200.ripr)
          n_sumt     = n_sumt    + ((uwd200.risi * -1) * nvexch )
          n_prmt     = n_prmt    + (uwd200.ripr)
          p_t        = uwd200.risi_p.
       END.
       /*--
       IF SUBSTRING(uwd200.rico,1,2) = "0T"
          AND SUBSTRING(uwd200.rico,6,2) = "02"  THEN DO:
          ASSIGN
          nv_0s_si  = nv_0s_si  + ((uwd200.risi * -1) * nvexch )
          nv_0s_pr  = nv_0s_pr  + (uwd200.ripr)
          nv_0s_sib = nv_0s_sib + ((uwd200.risi * -1) * nvexch )
          nv_0s_prb = nv_0s_prb + (uwd200.ripr)
          iv_0s_si  = iv_0s_si  + ((uwd200.risi * -1) * nvexch )
          iv_0s_pr  = iv_0s_pr  + (uwd200.ripr)
          iv_0s_sib = iv_0s_sib + ((uwd200.risi * -1) * nvexch )
          iv_0s_prb = iv_0s_prb + (uwd200.ripr)
          n_sums    = n_sums    + ((uwd200.risi * -1) * nvexch )
          n_prms    = n_prms    + (uwd200.ripr)
          p_s       = uwd200.risi_p.
       END.
       Lukkana M. A55-0239 18/07/2012--*/

       IF SUBSTRING(uwd200.rico,1,2) = "0T"
          AND SUBSTRING(uwd200.rico,6,2) = "F1"  THEN DO:
          ASSIGN
          nv_f1_si  = nv_f1_si  + ((uwd200.risi * -1) * nvexch )
          nv_f1_pr  = nv_f1_pr  + (uwd200.ripr)
          nv_f1_sib = nv_f1_sib + ((uwd200.risi * -1) * nvexch )
          nv_f1_prb = nv_f1_prb + (uwd200.ripr)
          iv_f1_si  = iv_f1_si  + ((uwd200.risi * -1) * nvexch )
          iv_f1_pr  = iv_f1_pr  + (uwd200.ripr)
          iv_f1_sib = iv_f1_sib + ((uwd200.risi * -1) * nvexch )
          iv_f1_prb = iv_f1_prb + (uwd200.ripr)
          n_sumf1   = n_sumf1   + ((uwd200.risi * -1) * nvexch )
          n_prmf1   = n_prmf1   + (uwd200.ripr)
          p_f1      = uwd200.risi_p.
       END.

       IF SUBSTRING(uwd200.rico,1,2) = "0T"
          AND SUBSTRING(uwd200.rico,6,2) = "F2"  THEN DO:
          ASSIGN
          nv_f2_si  = nv_f2_si  + ((uwd200.risi * -1) * nvexch )
          nv_f2_pr  = nv_f2_pr  + (uwd200.ripr)
          nv_f2_sib = nv_f2_sib + ((uwd200.risi * -1) * nvexch )
          nv_f2_prb = nv_f2_prb + (uwd200.ripr)
          iv_f2_si  = iv_f2_si  + ((uwd200.risi * -1) * nvexch )
          iv_f2_pr  = iv_f2_pr  + (uwd200.ripr)
          iv_f2_sib = iv_f2_sib + ((uwd200.risi * -1) * nvexch )
          iv_f2_prb = iv_f2_prb + (uwd200.ripr)
          n_sumf2   = n_sumf2   + ((uwd200.risi * -1) * nvexch )
          n_prmf2   = n_prmf2   + (uwd200.ripr)
          p_f2      = uwd200.risi_p.
       END.
       
       IF SUBSTRING(uwd200.rico,1,3) = "0PS"  THEN DO:
          ASSIGN
          nv_0ps_si   = nv_0ps_si  + ((uwd200.risi * -1) * nvexch )
          nv_0ps_pr   = nv_0ps_pr  + (uwd200.ripr)
          nv_0ps_sib  = nv_0ps_sib + ((uwd200.risi * -1) * nvexch )
          nv_0ps_prb  = nv_0ps_prb + (uwd200.ripr)
          iv_0ps_si   = iv_0ps_si  + ((uwd200.risi * -1) * nvexch )
          iv_0ps_pr   = iv_0ps_pr  + (uwd200.ripr)
          iv_0ps_sib  = iv_0ps_sib + ((uwd200.risi * -1) * nvexch )
          iv_0ps_prb  = iv_0ps_prb + (uwd200.ripr)
          n_sumps     = n_sumps    + ((uwd200.risi * -1) * nvexch )
          n_prmps     = n_prmps    + (uwd200.ripr)
          p_ps        = uwd200.risi_p.
       END.
       IF SUBSTRING(uwd200.rico,1,3) = "0TF" AND
          SUBSTRING(uwd200.rico,6,2) = "FB"  THEN DO:
          ASSIGN
          nv_btr_si   = nv_btr_si  + ((uwd200.risi * -1) * nvexch )
          nv_btr_pr   = nv_btr_pr  + (uwd200.ripr)
          nv_btr_sib  = nv_btr_sib + ((uwd200.risi * -1) * nvexch )
          nv_btr_prb  = nv_btr_prb + (uwd200.ripr)
          iv_btr_si   = iv_btr_si  + ((uwd200.risi * -1) * nvexch )
          iv_btr_pr   = iv_btr_pr  + (uwd200.ripr)
          iv_btr_sib  = iv_btr_sib + ((uwd200.risi * -1) * nvexch )
          iv_btr_prb  = iv_btr_prb + (uwd200.ripr)
          n_sumbtr    = n_sumbtr   + ((uwd200.risi * -1) * nvexch )
          n_prmbtr    = n_prmbtr   + (uwd200.ripr)
          p_btr       = uwd200.risi_p.
       END.

       IF SUBSTRING(uwd200.rico,1,3) = "0TF" AND
          SUBSTRING(uwd200.rico,6,2) = "FO"  THEN DO:   
          ASSIGN
          nv_otr_si   = nv_otr_si  + ((uwd200.risi * -1) * nvexch )
          nv_otr_pr   = nv_otr_pr  + (uwd200.ripr)
          nv_otr_sib  = nv_otr_sib + ((uwd200.risi * -1) * nvexch )
          nv_otr_prb  = nv_otr_prb + (uwd200.ripr)
          iv_otr_si   = iv_otr_si  + ((uwd200.risi * -1) * nvexch )
          iv_otr_pr   = iv_otr_pr  + (uwd200.ripr)
          iv_otr_sib  = iv_otr_sib + ((uwd200.risi * -1) * nvexch )
          iv_otr_prb  = iv_otr_prb + (uwd200.ripr)
          n_sumotr    = n_sumotr   + ((uwd200.risi * -1) * nvexch )
          n_prmotr    = n_prmotr   + (uwd200.ripr)
          p_otr       = uwd200.risi_p.
       END.

       /*--
       IF (SUBSTRING(uwd200.rico,1,4) = "0TA8" AND SUBSTRING(uwd200.rico,7,1) = "2" ) OR
          (SUBSTRING(uwd200.rico,1,2) = "0T"   AND SUBSTRING(uwd200.rico,6,2) = "F3")  
          THEN DO:   
       Lukkana M. A55-0239 18/07/2012--*/
       IF (SUBSTRING(uwd200.rico,1,2) = "0T"   AND SUBSTRING(uwd200.rico,6,2) = "02") OR /*Lukkana M. A55-0239 18/07/2012*/
          (SUBSTRING(uwd200.rico,1,4) = "0TA8" AND SUBSTRING(uwd200.rico,7,1) = "2" ) OR
          (SUBSTRING(uwd200.rico,1,2) = "0T"   AND SUBSTRING(uwd200.rico,6,2) = "F3")  
          THEN DO:   

          ASSIGN
          nv_s8_si  = nv_s8_si  + ((uwd200.risi * -1) * nvexch )
          nv_s8_pr  = nv_s8_pr  + (uwd200.ripr)
          nv_s8_sib = nv_s8_sib + ((uwd200.risi * -1) * nvexch )
          nv_s8_prb = nv_s8_prb + (uwd200.ripr)
          iv_s8_si  = iv_s8_si  + ((uwd200.risi * -1) * nvexch )
          iv_s8_pr  = iv_s8_pr  + (uwd200.ripr)
          iv_s8_sib = iv_s8_sib + ((uwd200.risi * -1) * nvexch )
          iv_s8_prb = iv_s8_prb + (uwd200.ripr)
          n_sums8   = n_sums8   + ((uwd200.risi * -1) * nvexch )
          n_prms8   = n_prms8   + (uwd200.ripr)
          p_s8      = uwd200.risi_p.
       END.
       
       IF SUBSTRING(uwd200.rico,1,2) = "0T"
          AND SUBSTRING(uwd200.rico,6,2) = "F4"  THEN DO:
          ASSIGN
          nv_f4_si  = nv_f4_si  + ((uwd200.risi * -1) * nvexch )
          nv_f4_pr  = nv_f4_pr  + (uwd200.ripr)
          nv_f4_sib = nv_f4_sib + ((uwd200.risi * -1) * nvexch )
          nv_f4_prb = nv_f4_prb + (uwd200.ripr)
          iv_f4_si  = iv_f4_si  + ((uwd200.risi * -1) * nvexch )
          iv_f4_pr  = iv_f4_pr  + (uwd200.ripr)
          iv_f4_sib = iv_f4_sib + ((uwd200.risi * -1) * nvexch )
          iv_f4_prb = iv_f4_prb + (uwd200.ripr)
          n_sumf4   = n_sumf4   + ((uwd200.risi * -1) * nvexch )
          n_prmf4   = n_prmf4   + (uwd200.ripr)
          p_f4      = uwd200.risi_p.
       END.
       IF SUBSTRING(uwd200.rico,1,2) = "0T"
          AND SUBSTRING(uwd200.rico,6,2) = "FT"  THEN DO:
          ASSIGN
          nv_ftr_si  = nv_ftr_si  + ((uwd200.risi * -1) * nvexch )
          nv_ftr_pr  = nv_ftr_pr  + (uwd200.ripr)
          nv_ftr_sib = nv_ftr_sib + ((uwd200.risi * -1) * nvexch )
          nv_ftr_prb = nv_ftr_prb + (uwd200.ripr)
          iv_ftr_si  = iv_ftr_si  + ((uwd200.risi * -1) * nvexch )
          iv_ftr_pr  = iv_ftr_pr  + (uwd200.ripr)
          iv_ftr_sib = iv_ftr_sib + ((uwd200.risi * -1) * nvexch )
          iv_ftr_prb = iv_ftr_prb + (uwd200.ripr)
          n_sumftr   = n_sumftr   + ((uwd200.risi * -1) * nvexch )
          n_prmftr   = n_prmftr   + (uwd200.ripr)
          p_ftr      = uwd200.risi_p.
       END.

       IF SUBSTRING(uwd200.rico,1,2) = "0D" OR
          SUBSTRING(uwd200.rico,1,2) = "0F"  THEN DO:
          ASSIGN
          nv_0f_sib  = nv_0f_sib + ROUND(((uwd200.risi * -1) * nvexch ),2)
          nv_0f_prb  = nv_0f_prb + ROUND((uwd200.ripr),2)
          iv_0f_sib  = iv_0f_sib + ROUND(((uwd200.risi * -1) * nvexch ),2)
          iv_0f_prb  = iv_0f_prb + ROUND((uwd200.ripr),2).

         FIND FIRST wrk0f WHERE wrk0f.rico = uwd200.rico NO-ERROR.
         IF AVAILABLE wrk0f THEN DO:
            wrk0f.sumf = wrk0f.sumf + ROUND(((uwd200.risi * -1) * nvexch ),2).
            wrk0f.prmf = wrk0f.prmf + ROUND((uwd200.ripr),2).
         END.
         ELSE DO:
            CREATE   wrk0f.
            ASSIGN
               wrk0f.sumf   = ROUND(((uwd200.risi * -1) * nvexch ),2)
               wrk0f.prmf   = ROUND((uwd200.ripr),2)
               wrk0f.pf     = uwd200.risi_p
               wrk0f.rico   = uwd200.rico
               wrk0f.cess   = uwm200.c_enno.
         END.
       END.

       FIND NEXT uwd200 USE-INDEX uwd20001 WHERE uwd200.policy = uwm200.policy AND
                                                 uwd200.rencnt = uwm200.rencnt AND
                                                 uwd200.endcnt = uwm200.endcnt AND
                                                 uwd200.c_enct = uwm200.c_enct AND
                                                 uwd200.csftq  = uwm200.csftq  AND
                                                 uwd200.rico   = uwm200.rico
                                                 NO-LOCK NO-ERROR.
      IF NOT AVAIL uwd200 THEN  LEAVE.
     END. /* repeat */
   END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

