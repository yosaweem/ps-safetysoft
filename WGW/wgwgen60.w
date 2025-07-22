&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
*/
&Scoped-define WINDOW-NAME c-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS c-Win 
/*------------------------------------------------------------------------
/* Connected Databases 
sic_test         PROGRESS  */
File: 
Description: 
Input Parameters:
<none>
Output Parameters:
<none>
Author: 
Created: 
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
/*******************************/                                       
/*programid   : wgwgen60.w                                             */ 
/*programname : load text file PA60 PMIB      */ 
/* Copyright  : Safety Insurance Public Company Limited                 */
/*copy write  : wgwatcgen.w                                             */ 
/*              บริษัท ประกันคุ้มภัย จำกัด (มหาชน)                      */
/*create by   : Ranu I. A61-0024 Date : 12/01/2018             
                โปรแกรมนำเข้า text file PA60 PMIB to GW system    */
DEF VAR n_firstdat AS CHAR FORMAT "x(15)" INIT "".
DEF VAR n_index    AS INTE  INIT 0.
def  buffer bfuwm100 FOR sicuw.uwm100.
def  buffer bfuwm120 FOR sicuw.uwm120.
def  buffer bfuwm130 FOR sicuw.uwm130.
def  buffer bfuwm307 FOR sicuw.uwm307.
def  buffer bfuwd132 FOR sicuw.uwd132.
def  buffer bfuwm200 FOR sicuw.uwm200.
def  buffer bfuwd200 FOR sicuw.uwd200.

DEF VAR  NO_CLASS AS CHAR INIT "".
DEF NEW SHARED VAR nv_sclass  AS CHAR FORMAT "x(3)".
DEF VAR no_tariff AS CHAR INIT "".
DEF NEW SHARED VAR nv_riskno   Like  sicuw.uwm301.riskgp.
DEF NEW SHARED VAR nv_itemno   Like  sicuw.uwm301.itemno. 
DEFINE STREAM  ns1. 
DEFINE STREAM  ns2.
DEFINE STREAM  ns3.
DEF VAR chkred    AS logi INIT NO.
DEF SHARED Var   n_User    As CHAR .
DEF SHARED Var   n_PassWd  As CHAR .    
DEF NEW SHARED VAR nv_totsi  AS DECIMAL FORMAT ">>,>>>,>>9.99-".
DEF NEW SHARED VAR nv_polday AS INTE    FORMAT ">>9".
def var nv_chk as  logic.
DEF VAR nv_ncbyrs AS INTE.    
def  New  shared var  nv_poltyp   as   char   init  "".
def new shared var s_recid1       as RECID .     /* sic_bran.uwm100  */
def new shared var s_recid2       as recid .     /* sic_bran.uwm120  */
def new shared var s_recid3       as recid .     /* sic_bran.uwm130  */  
def new shared var s_recid4       as recid .     /* sic_bran.uwm307  */ 
DEF new shared var s_recid5       AS RECID .     /* sic_bran.uwm200 */
DEF VAR nv_lnumber AS   INTE INIT 0.
DEF VAR nv_provi   AS   CHAR INIT "".
DEF VAR n_rencnt   LIKE sicuw.uwm100.rencnt INITIAL "".
def var nv_index   as   int  init  0. 
DEF VAR n_endcnt   LIKE sicuw.uwm100.endcnt INITIAL "".
def var n_comdat   LIKE sicuw.uwm100.comdat  NO-UNDO.
def var n_policy   LIKE sicuw.uwm100.policy  INITIAL "" .
DEF VAR nv_daily     AS CHARACTER FORMAT "X(1024)"     INITIAL ""  NO-UNDO.
DEF VAR nv_reccnt   AS  INT  INIT  0.          /*all load record*/
DEF VAR nv_completecnt    AS   INT   INIT  0.  /*complete record */
DEF NEW SHARED VAR chr_sticker AS CHAR FORMAT "9999999999999" INIT "".  /*amparat c. a51-0253*/
def NEW SHARED  var nv_modulo    as int  format "9".
def var s_riskgp    AS INTE FORMAT ">9".
def var s_riskno    AS INTE FORMAT "999".
def var s_itemno    AS INTE FORMAT "999". 
def var nv_dept     as char format  "X(1)".
def NEW SHARED var  nv_branch  AS CHAR FORMAT "x(3)" .  
def var nv_undyr    as    char  init  ""    format   "X(4)".
def var n_newpol    Like  sicuw.uwm100.policy  init  "".
def var n_curbil    LIKE  sicuw.uwm100.curbil  NO-UNDO.
def New shared  var      nv_makdes    as   char    .
def New shared  var      nv_moddes    as   char.
DEF Var nv_lastno As       Int.
Def Var nv_seqno  As       Int.
DEF VAR sv_xmm600 AS       RECID.
DEF VAR nv_stm_per  AS DECIMAL FORMAT ">9.99" INITIAL 0 NO-UNDO.
DEF VAR nv_tax_per  AS DECIMAL FORMAT ">9.99" INITIAL 0 NO-UNDO.
DEF VAR nv_com1_per AS DECIMAL FORMAT ">9.99" INITIAL 0 NO-UNDO.
DEF VAR nv_com1_prm AS DECIMAL FORMAT ">>>>>9.99-"      NO-UNDO.
DEF VAR s_130bp1    AS RECID                            NO-UNDO.
DEF VAR s_130fp1    AS RECID                            NO-UNDO.
DEF VAR nvffptr     AS RECID                            NO-UNDO.
DEF VAR n_rd132     AS RECID                            NO-UNDO.
DEF VAR nv_gap      AS DECIMAL                          NO-UNDO.
DEF VAR nv_fptr     AS RECID.
DEF VAR nv_bptr     AS RECID.
DEF VAR nv_nptr     AS RECID.
DEF VAR nv_gap2     AS DECIMAL                          NO-UNDO.
DEF VAR nv_prem2    AS DECIMAL                          NO-UNDO.
DEF VAR nv_rstp     AS DECIMAL                          NO-UNDO.
DEF VAR nv_rtax     AS DECIMAL                          NO-UNDO.
DEF VAR nv_key_a    AS DECIMAL INITIAL 0                NO-UNDO.
DEF VAR nv_rec100   AS RECID .
DEF VAR nv_rec120   AS RECID .
DEF VAR nv_rec130   AS RECID .
DEF VAR nv_rec301   AS RECID .
{wgw\wgwgen60.i}      /*ประกาศตัวแปร*/
DEFINE  WORKFILE wuppertxt NO-UNDO
/*1*/  FIELD line     AS INTEGER   FORMAT ">>9"
/*2*/  FIELD txt      AS CHARACTER FORMAT "X(78)"   INITIAL "".
DEFINE  WORKFILE wuppertxt3 NO-UNDO
/*1*/  FIELD line     AS INTEGER   FORMAT ">>9"
/*2*/  FIELD txt      AS CHARACTER FORMAT "X(78)"   INITIAL "".
DEF  VAR n_taxae    AS LOGICAL .
DEF  VAR n_stmpae   AS LOGICAL .
DEF  VAR n_com2ae   AS LOGICAL .
DEF  VAR n_com1ae   AS LOGICAL .
DEF  VAR nv_fi_com2_t    AS DECI INIT 0.00.
DEF  VAR nv_fi_rstp_t    AS INTE INIT 0.
DEF  VAR nv_fi_rtax_t    AS DECI INIT 0.00 .
DEF  VAR gv_id AS CHAR FORMAT "X(8)" NO-UNDO.
DEF VAR nv_pwd AS CHAR NO-UNDO.
DEF VAR nv_simat   AS DECI.    /* A57-0193 */
DEF VAR nv_simat1  AS DECI.    /* A57-0193 */
DEF VAR n_check AS CHAR FORMAT "x(20)" INIT "".
DEF VAR nv_insref AS CHAR FORMAT "x(15)" INIT "".
DEF VAR nv_typ AS CHAR FORMAT "x(5)" INIT "".
DEF VAR nv_name   AS CHAR FORMAT "x(80)" init "".
DEF VAR nv_lname  AS CHAR FORMAT "x(80)" init "".
DEF VAR nv_product AS CHAR FORMAT "x(500)" INIT "" .
DEF VAR nv_mail AS CHAR FORMAT "x(100)" INIT "".

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main
&Scoped-define BROWSE-NAME br_wdetail

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES wdetail wxpara49

/* Definitions for BROWSE br_wdetail                                    */
&Scoped-define FIELDS-IN-QUERY-br_wdetail wdetail.policy wdetail.cndat wdetail.comdat wdetail.expdat wdetail.covcod wdetail.tiname wdetail.insnam wdetail.n_addr1 wdetail.n_addr2 wdetail.n_addr3 wdetail.n_addr4   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_wdetail   
&Scoped-define SELF-NAME br_wdetail
&Scoped-define QUERY-STRING-br_wdetail FOR EACH wdetail WHERE wdetail.pass = "y"
&Scoped-define OPEN-QUERY-br_wdetail OPEN QUERY br_query FOR EACH wdetail WHERE wdetail.pass = "y".
&Scoped-define TABLES-IN-QUERY-br_wdetail wdetail
&Scoped-define FIRST-TABLE-IN-QUERY-br_wdetail wdetail


/* Definitions for BROWSE br_xpara                                      */
&Scoped-define FIELDS-IN-QUERY-br_xpara wxpara49.para1 /*product: CNSS60S001 */ wxpara49.para10 /*polmas : DY6060UW0004 */ wxpara49.prem_c /* prem */ wxpara49.para3 /*poltype: M60 */ wxpara49.para7 /*detail : SafeSafe 1 (ส่วนลด 10%*/   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_xpara   
&Scoped-define SELF-NAME br_xpara
&Scoped-define QUERY-STRING-br_xpara FOR EACH wxpara49
&Scoped-define OPEN-QUERY-br_xpara OPEN QUERY {&SELF-NAME} FOR EACH wxpara49.
&Scoped-define TABLES-IN-QUERY-br_xpara wxpara49
&Scoped-define FIRST-TABLE-IN-QUERY-br_xpara wxpara49


/* Definitions for FRAME fr_main                                        */
&Scoped-define OPEN-BROWSERS-IN-QUERY-fr_main ~
    ~{&OPEN-QUERY-br_xpara}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS br_xpara cb_pdtype fi_loaddat fi_branch ~
fi_producer fi_bchno fi_agent fi_vatcod fi_prevbat fi_bchyr fi_filename ~
bu_file fi_output1 fi_output2 fi_output3 fi_usrcnt fi_usrprem buok bu_exit ~
br_wdetail bu_hpbrn bu_hpacno1 bu_hpagent fi_process RECT-370 RECT-372 ~
RECT-373 RECT-374 RECT-375 RECT-376 RECT-377 RECT-378 
&Scoped-Define DISPLAYED-OBJECTS cb_pdtype fi_loaddat fi_branch fi_producer ~
fi_bchno fi_agent fi_vatcod fi_prevbat fi_bchyr fi_filename fi_output1 ~
fi_output2 fi_output3 fi_usrcnt fi_usrprem fi_brndes fi_proname fi_agtname ~
fi_impcnt fi_process fi_completecnt fi_premtot fi_premsuc 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR c-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON buok 
     LABEL "OK" 
     SIZE 10 BY 1
     FONT 6.

DEFINE BUTTON bu_exit 
     LABEL "EXIT" 
     SIZE 10 BY 1
     FONT 6.

DEFINE BUTTON bu_file 
     LABEL "..." 
     SIZE 3.5 BY .95.

DEFINE BUTTON bu_hpacno1 
     IMAGE-UP FILE "wimage/help.bmp":U
     LABEL "" 
     SIZE 4 BY .95.

DEFINE BUTTON bu_hpagent 
     IMAGE-UP FILE "wimage/help.bmp":U
     LABEL "" 
     SIZE 4 BY .95.

DEFINE BUTTON bu_hpbrn 
     IMAGE-UP FILE "wimage/help.bmp":U
     LABEL "" 
     SIZE 3.5 BY .95.

DEFINE VARIABLE cb_pdtype AS CHARACTER 
     VIEW-AS COMBO-BOX INNER-LINES 5
     DROP-DOWN
     SIZE 17 BY 1
     BGCOLOR 15 FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE fi_agent AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 16 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_agtname AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 46.17 BY .95
     BGCOLOR 19 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_bchno AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 23.5 BY 1
     BGCOLOR 19 FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE fi_bchyr AS INTEGER FORMAT "9999":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 7 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_branch AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 5 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_brndes AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 37 BY .95
     BGCOLOR 19 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_completecnt AS INTEGER FORMAT ">,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 11.5 BY 1.05
     BGCOLOR 19 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_filename AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 60 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_impcnt AS INTEGER FORMAT ">,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 11.5 BY 1.05
     BGCOLOR 19 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_loaddat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 16 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_output1 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 60 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_output2 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 60 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_output3 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 60 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_premsuc AS DECIMAL FORMAT "->,>>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1.05
     BGCOLOR 19 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_premtot AS DECIMAL FORMAT "->,>>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1.05
     BGCOLOR 19 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_prevbat AS CHARACTER FORMAT "X(16)":U 
     VIEW-AS FILL-IN 
     SIZE 22.67 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_process AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 62 BY .95
     BGCOLOR 10 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_producer AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 16 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_proname AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 46.17 BY .95
     BGCOLOR 19 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_usrcnt AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 11.5 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_usrprem AS DECIMAL FORMAT "->,>>>,>>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 19 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_vatcod AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 16 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE RECTANGLE RECT-370
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132.5 BY 1.57
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-372
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132.5 BY 13
     BGCOLOR 8 FGCOLOR 1 .

DEFINE RECTANGLE RECT-373
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132.5 BY 5.62
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-374
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132.5 BY 3.52
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-375
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 130 BY 3.1
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-376
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 119 BY 2.52
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-377
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 13 BY 1.67
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-378
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 13 BY 1.67
     BGCOLOR 6 .

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_wdetail FOR 
      wdetail SCROLLING.

DEFINE QUERY br_xpara FOR 
      wxpara49 SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_wdetail
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_wdetail c-Win _FREEFORM
  QUERY br_wdetail DISPLAY
      wdetail.policy        COLUMN-LABEL "Policy No."
      wdetail.cndat         COLUMN-LABEL "CN date."
      wdetail.comdat        COLUMN-LABEL "comdate."   
      wdetail.expdat        COLUMN-LABEL "expidate." 
      wdetail.covcod        COLUMN-LABEL "covcod  "
      wdetail.tiname        COLUMN-LABEL "tiname  "
      wdetail.insnam        COLUMN-LABEL "insnam  "
      wdetail.n_addr1       COLUMN-LABEL "addr1 "
      wdetail.n_addr2       COLUMN-LABEL "addr2 "
      wdetail.n_addr3       COLUMN-LABEL "addr3 "
      wdetail.n_addr4       COLUMN-LABEL "addr4 "
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 130 BY 4.95
         BGCOLOR 15 FONT 6 ROW-HEIGHT-CHARS .52.

DEFINE BROWSE br_xpara
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_xpara c-Win _FREEFORM
  QUERY br_xpara DISPLAY
      wxpara49.para1  column-label "Product"   FORMAT "x(12)"            /*product: CNSS60S001 */
 wxpara49.para10 column-label "Policy Master" FORMAT "x(14)"        /*polmas : DY6060UW0004 */
 wxpara49.prem_c column-label "Premium total" FORMAT ">>>>>>9.99"  /* prem */
 wxpara49.para3  column-label "Poltype"   FORMAT "x(3)"             /*poltype: M60 */
 wxpara49.para7  column-label "Detail"    FORMAT "x(30)"            /*detail : SafeSafe 1 (ส่วนลด 10%*/
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 43.83 BY 5.71
         BGCOLOR 15 FGCOLOR 1 FONT 6 FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     br_xpara AT ROW 2.91 COL 88
     cb_pdtype AT ROW 2.76 COL 51.5 COLON-ALIGNED NO-LABEL
     fi_loaddat AT ROW 2.81 COL 17 COLON-ALIGNED NO-LABEL
     fi_branch AT ROW 3.86 COL 16.67 COLON-ALIGNED NO-LABEL
     fi_producer AT ROW 4.91 COL 17 COLON-ALIGNED NO-LABEL
     fi_bchno AT ROW 22.62 COL 15 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     fi_agent AT ROW 5.95 COL 17 COLON-ALIGNED NO-LABEL
     fi_vatcod AT ROW 7 COL 17 COLON-ALIGNED NO-LABEL
     fi_prevbat AT ROW 8.05 COL 24.33 COLON-ALIGNED NO-LABEL
     fi_bchyr AT ROW 8.05 COL 60 COLON-ALIGNED NO-LABEL
     fi_filename AT ROW 9.1 COL 24 COLON-ALIGNED NO-LABEL
     bu_file AT ROW 9.1 COL 86.67
     fi_output1 AT ROW 10.14 COL 24 COLON-ALIGNED NO-LABEL
     fi_output2 AT ROW 11.19 COL 24 COLON-ALIGNED NO-LABEL
     fi_output3 AT ROW 12.24 COL 24 COLON-ALIGNED NO-LABEL
     fi_usrcnt AT ROW 13.29 COL 24 COLON-ALIGNED NO-LABEL
     fi_usrprem AT ROW 13.29 COL 63.17 NO-LABEL
     buok AT ROW 11.81 COL 94.5
     bu_exit AT ROW 13.67 COL 94.67
     fi_brndes AT ROW 3.86 COL 25.83 COLON-ALIGNED NO-LABEL
     br_wdetail AT ROW 15.95 COL 2.17
     bu_hpbrn AT ROW 3.86 COL 24
     bu_hpacno1 AT ROW 4.91 COL 35.5
     bu_hpagent AT ROW 5.95 COL 35.5
     fi_proname AT ROW 4.91 COL 37.83 COLON-ALIGNED NO-LABEL
     fi_agtname AT ROW 5.95 COL 37.83 COLON-ALIGNED NO-LABEL
     fi_impcnt AT ROW 22.05 COL 59.17 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     fi_process AT ROW 14.38 COL 24 COLON-ALIGNED NO-LABEL
     fi_completecnt AT ROW 23.05 COL 59.17 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     fi_premtot AT ROW 22.05 COL 97 NO-LABEL NO-TAB-STOP 
     fi_premsuc AT ROW 23.1 COL 95 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     "Branch :" VIEW-AS TEXT
          SIZE 8 BY .95 AT ROW 3.86 COL 10.33
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Batch No. :" VIEW-AS TEXT
          SIZE 11.5 BY .95 AT ROW 22.62 COL 5.33
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "BHT.":60 VIEW-AS TEXT
          SIZE 6 BY 1.05 AT ROW 22.05 COL 116
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "        Batch File Name :" VIEW-AS TEXT
          SIZE 22.5 BY .95 AT ROW 12.24 COL 2.5
          BGCOLOR 8 FGCOLOR 1 
     "BHT.":60 VIEW-AS TEXT
          SIZE 5 BY .95 AT ROW 13.29 COL 82.67
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "    Agent Code  :" VIEW-AS TEXT
          SIZE 16 BY .95 AT ROW 5.95 COL 2.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "BHT.":60 VIEW-AS TEXT
          SIZE 6 BY 1.05 AT ROW 23.05 COL 116
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "        Vat code  :" VIEW-AS TEXT
          SIZE 16 BY .95 AT ROW 7 COL 2.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "     Policy Import Total :":60 VIEW-AS TEXT
          SIZE 22.5 BY .95 AT ROW 13.29 COL 24 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Output Data Not Load :" VIEW-AS TEXT
          SIZE 22.5 BY .95 AT ROW 11.19 COL 2.5
          BGCOLOR 8 FGCOLOR 1 
     "     Total Record :":60 VIEW-AS TEXT
          SIZE 17.5 BY 1.05 AT ROW 22.29 COL 57.5 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Batch Year :" VIEW-AS TEXT
          SIZE 12 BY .95 AT ROW 8.05 COL 60.33 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Total Net Premium Imp  :":60 VIEW-AS TEXT
          SIZE 25 BY .95 AT ROW 13.29 COL 61.83 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 24
         BGCOLOR 19 FONT 6.

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "     IMPORT TEXT FILE PA Line M60" VIEW-AS TEXT
          SIZE 130 BY .95 AT ROW 1.29 COL 2.33
          BGCOLOR 1 FGCOLOR 7 FONT 6
     " Input File Name Load :" VIEW-AS TEXT
          SIZE 22.5 BY .95 AT ROW 9.1 COL 2.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "       Load Date :":35 VIEW-AS TEXT
          SIZE 16 BY .95 AT ROW 2.81 COL 2.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     " Product Type :":35 VIEW-AS TEXT
          SIZE 16 BY .95 AT ROW 2.81 COL 37.33
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Success Net Premium :" VIEW-AS TEXT
          SIZE 22.33 BY 1.05 AT ROW 23.05 COL 94.83 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Producer Code :" VIEW-AS TEXT
          SIZE 16 BY .95 AT ROW 4.91 COL 2.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "   Total Net Premium  :" VIEW-AS TEXT
          SIZE 21.5 BY 1.05 AT ROW 22.05 COL 94.67 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Previous Batch No.:" VIEW-AS TEXT
          SIZE 19.5 BY .95 AT ROW 8.05 COL 5.33
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Success Record :" VIEW-AS TEXT
          SIZE 17.5 BY 1.05 AT ROW 23.05 COL 57.67 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "      Output Data Load :" VIEW-AS TEXT
          SIZE 22.5 BY .95 AT ROW 10.14 COL 2.5
          BGCOLOR 8 FGCOLOR 1 
     RECT-370 AT ROW 1 COL 1
     RECT-372 AT ROW 2.48 COL 1.17
     RECT-373 AT ROW 15.67 COL 1
     RECT-374 AT ROW 21.33 COL 1
     RECT-375 AT ROW 21.62 COL 2
     RECT-376 AT ROW 21.95 COL 4.33
     RECT-377 AT ROW 11.48 COL 92.83
     RECT-378 AT ROW 13.33 COL 93
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 24
         BGCOLOR 19 FONT 6.


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
  CREATE WINDOW c-Win ASSIGN
         HIDDEN             = YES
         TITLE              = "Import Text file PA60"
         HEIGHT             = 23.95
         WIDTH              = 133
         MAX-HEIGHT         = 24
         MAX-WIDTH          = 133
         VIRTUAL-HEIGHT     = 24
         VIRTUAL-WIDTH      = 133
         RESIZE             = yes
         SCROLL-BARS        = no
         STATUS-AREA        = no
         BGCOLOR            = 139
         FGCOLOR            = 133
         KEEP-FRAME-Z-ORDER = yes
         THREE-D            = yes
         MESSAGE-AREA       = no
         SENSITIVE          = yes.
ELSE {&WINDOW-NAME} = CURRENT-WINDOW.

&IF '{&WINDOW-SYSTEM}' NE 'TTY' &THEN
IF NOT c-Win:LOAD-ICON("wimage/safety.ico":U) THEN
    MESSAGE "Unable to load icon: wimage/safety.ico"
            VIEW-AS ALERT-BOX WARNING BUTTONS OK.
&ENDIF
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW c-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME fr_main
   FRAME-NAME Custom                                                    */
/* BROWSE-TAB br_xpara 1 fr_main */
/* BROWSE-TAB br_wdetail fi_brndes fr_main */
ASSIGN 
       br_wdetail:COLUMN-RESIZABLE IN FRAME fr_main       = TRUE.

ASSIGN 
       br_xpara:SEPARATOR-FGCOLOR IN FRAME fr_main      = 8.

ASSIGN 
       bu_file:AUTO-RESIZE IN FRAME fr_main      = TRUE.

/* SETTINGS FOR FILL-IN fi_agtname IN FRAME fr_main
   NO-ENABLE                                                            */
ASSIGN 
       fi_bchno:READ-ONLY IN FRAME fr_main        = TRUE.

/* SETTINGS FOR FILL-IN fi_brndes IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_completecnt IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_impcnt IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_premsuc IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_premtot IN FRAME fr_main
   NO-ENABLE ALIGN-L                                                    */
/* SETTINGS FOR FILL-IN fi_proname IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_usrprem IN FRAME fr_main
   ALIGN-L                                                              */
/* SETTINGS FOR TEXT-LITERAL "Batch Year :"
          SIZE 12 BY .95 AT ROW 8.05 COL 60.33 RIGHT-ALIGNED            */

/* SETTINGS FOR TEXT-LITERAL "     Policy Import Total :"
          SIZE 22.5 BY .95 AT ROW 13.29 COL 24 RIGHT-ALIGNED            */

/* SETTINGS FOR TEXT-LITERAL "Total Net Premium Imp  :"
          SIZE 25 BY .95 AT ROW 13.29 COL 61.83 RIGHT-ALIGNED           */

/* SETTINGS FOR TEXT-LITERAL "   Total Net Premium  :"
          SIZE 21.5 BY 1.05 AT ROW 22.05 COL 94.67 RIGHT-ALIGNED        */

/* SETTINGS FOR TEXT-LITERAL "     Total Record :"
          SIZE 17.5 BY 1.05 AT ROW 22.29 COL 57.5 RIGHT-ALIGNED         */

/* SETTINGS FOR TEXT-LITERAL "Success Record :"
          SIZE 17.5 BY 1.05 AT ROW 23.05 COL 57.67 RIGHT-ALIGNED        */

/* SETTINGS FOR TEXT-LITERAL "Success Net Premium :"
          SIZE 22.33 BY 1.05 AT ROW 23.05 COL 94.83 RIGHT-ALIGNED       */

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(c-Win)
THEN c-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_wdetail
/* Query rebuild information for BROWSE br_wdetail
     _START_FREEFORM
OPEN QUERY br_query FOR EACH wdetail WHERE wdetail.pass = "y".
     _END_FREEFORM
     _Query            is NOT OPENED
*/  /* BROWSE br_wdetail */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_xpara
/* Query rebuild information for BROWSE br_xpara
     _START_FREEFORM
OPEN QUERY {&SELF-NAME} FOR EACH wxpara49.
     _END_FREEFORM
     _Query            is OPENED
*/  /* BROWSE br_xpara */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME c-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c-Win c-Win
ON END-ERROR OF c-Win /* Import Text file PA60 */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c-Win c-Win
ON WINDOW-CLOSE OF c-Win /* Import Text file PA60 */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br_wdetail
&Scoped-define SELF-NAME br_wdetail
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_wdetail c-Win
ON ROW-DISPLAY OF br_wdetail IN FRAME fr_main
DO:
    DEF VAR z AS INTE  INIT 0.
    DEF VAR s AS INTE  INIT 0.
    s = 1.
    z = 26.
    IF WDETAIL.WARNING <> "" THEN DO:
        wdetail.policy       :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
        wdetail.cndat        :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
        wdetail.comdat       :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
        wdetail.expdat       :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
        wdetail.covcod       :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.   
        wdetail.tiname       :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.   
        wdetail.insnam       :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.
        wdetail.n_addr1      :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.   
        wdetail.n_addr2      :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.   
        wdetail.n_addr3      :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.   
        wdetail.n_addr4      :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.   
        
        wdetail.policy:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
        wdetail.cndat        :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
        wdetail.comdat       :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
        wdetail.expdat       :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
        wdetail.covcod       :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
        wdetail.tiname       :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
        wdetail.insnam       :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
        wdetail.n_addr1      :BGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.   
        wdetail.n_addr2      :BGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.   
        wdetail.n_addr3      :BGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.   
        wdetail.n_addr4      :BGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
         
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buok c-Win
ON CHOOSE OF buok IN FRAME fr_main /* OK */
DO:
    ASSIGN
        nv_batprev  = INPUT fi_prevbat
        fi_process  = "Load Text file SIAM Carrent Group "
        fi_completecnt:FGCOLOR = 2
        fi_premsuc:FGCOLOR     = 2 
        fi_bchno:FGCOLOR       = 2
        fi_completecnt         = 0
        fi_premsuc             = 0
        fi_bchno               = ""
        fi_premtot             = 0
        fi_impcnt              = 0.
    DISP fi_process fi_impcnt fi_completecnt fi_premtot fi_premsuc fi_impcnt fi_premtot WITH FRAME fr_main.
    IF fi_branch = " " THEN DO: 
        MESSAGE "Branch Code is Mandatory" VIEW-AS ALERT-BOX .
        APPLY "entry" TO fi_branch.
        RETURN NO-APPLY.
    END.
    IF fi_producer = " " THEN DO:
        MESSAGE "Producer code is Mandatory" VIEW-AS ALERT-BOX .
        APPLY "entry" TO fi_producer.
        RETURN NO-APPLY.
    END.
    IF fi_agent = " " THEN DO:
        MESSAGE "Agent code is Mandatory" VIEW-AS ALERT-BOX .
        APPLY "entry" TO fi_Agent.
        RETURN NO-APPLY.
    END.
    IF fi_loaddat = ? THEN DO:
        MESSAGE "Load Date Is Mandatory" VIEW-AS ALERT-BOX .
        APPLY "entry" to fi_loaddat.
        RETURN NO-APPLY.
    END.
    IF fi_bchyr <= 0 THEN DO:
        MESSAGE "Batch Year Can't be 0" VIEW-AS ALERT-BOX.
        APPLY "entry" to fi_bchyr.
        RETURN NO-APPLY.
    END.
    ASSIGN
        fi_output1 = INPUT fi_output1
        fi_output2 = INPUT fi_output2
        fi_output3 = INPUT fi_output3.
    IF fi_output1 = "" THEN DO:
        MESSAGE "Plese Input File Data Load...!!!" VIEW-AS ALERT-BOX ERROR.
        APPLY "Entry" TO fi_output1.
        RETURN NO-APPLY.
    END.
    IF fi_output2 = "" THEN DO:
        MESSAGE "Plese Input File Data Not Load...!!!" VIEW-AS ALERT-BOX ERROR.
        APPLY "Entry" TO fi_output2.
        RETURN NO-APPLY.
    END.
    IF fi_output3 = "" THEN DO:
        MESSAGE "Plese Input Batch File Name...!!!" VIEW-AS ALERT-BOX ERROR.
        APPLY "Entry" TO fi_output3.
        RETURN NO-APPLY.
    END.
    nv_batchyr = INPUT fi_bchyr.
    IF nv_batprev = "" THEN DO:  
        FIND LAST uzm700 USE-INDEX uzm70001    WHERE 
            uzm700.bchyr   = nv_batchyr        AND
            uzm700.branch  = TRIM(nv_batbrn)   AND
            uzm700.acno    = TRIM(fi_producer) NO-LOCK NO-ERROR .
        IF AVAIL uzm700 THEN DO:  
            ASSIGN nv_batrunno = uzm700.runno.
            FIND LAST uzm701 USE-INDEX uzm70102 WHERE
                uzm701.bchyr  = nv_batchyr        AND
                uzm701.bchno  = trim(fi_producer) + TRIM(nv_batbrn) + string(nv_batrunno,"9999") NO-LOCK NO-ERROR.
            IF AVAIL uzm701 THEN DO:
                nv_batcnt   = uzm701.bchcnt .
                nv_batrunno = nv_batrunno + 1.
            END.
        END.
        ELSE DO:  
            ASSIGN
                nv_batcnt   = 1
                nv_batrunno = 1.
        END.
        nv_batchno = CAPS(fi_producer) + CAPS(nv_batbrn) + STRING(nv_batrunno,"9999").
    END.
    ELSE DO:  
        nv_batprev = INPUT fi_prevbat.
        FIND LAST uzm701 USE-INDEX uzm70102 WHERE
            uzm701.bchyr   = nv_batchyr        AND
            uzm701.bchno   = CAPS(nv_batprev)  NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL uzm701 THEN DO:
            MESSAGE "Not found Batch File Master : " + CAPS (nv_batprev)
                + " on file uzm701" .
            APPLY "entry" TO fi_prevbat.
            RETURN NO-APPLY.
        END.
        IF AVAIL uzm701 THEN DO:
            nv_batcnt  = uzm701.bchcnt + 1.
            nv_batchno = CAPS(TRIM(nv_batprev)).
        END.
    END.
    ASSIGN
        fi_loaddat   = INPUT fi_loaddat     fi_branch       = INPUT fi_branch
        fi_producer  = INPUT fi_producer    fi_agent        = INPUT fi_agent 
        fi_bchyr     = INPUT fi_bchyr       fi_prevbat      = INPUT fi_prevbat
        fi_usrcnt    = INPUT fi_usrcnt      fi_usrprem      = INPUT fi_usrprem
        nv_imppol    = fi_usrcnt            nv_impprem      = fi_usrprem 
        nv_tmppolrun = 0                    nv_daily        = ""
        nv_reccnt    = 0                    nv_completecnt  = 0
        nv_netprm_t  = 0                    nv_netprm_s     = 0
        nv_batbrn    = fi_branch .
    For each  wdetail :
        DELETE  wdetail.
    END.
    
    RUN proc_assign. 
    FOR EACH wdetail :
        IF wdetail.poltyp   = "M60" THEN DO:
            ASSIGN nv_reccnt   =  nv_reccnt   + 1
                nv_netprm_t    =  nv_netprm_t + decimal(wdetail.premt)
                wdetail.pass   = "Y". 
        END.
        ELSE DELETE WDETAIL.
    END.
    IF  nv_reccnt = 0 THEN DO: 
        MESSAGE "No Record Can Gen " VIEW-AS ALERT-BOX.       
        RETURN NO-APPLY.
    END.
    RUN wgw\wgwbatch.p    (INPUT            fi_loaddat ,     /* DATE  */
                           INPUT            nv_batchyr ,     /* INT   */
                           INPUT            fi_producer,     /* CHAR  */ 
                           INPUT            nv_batbrn  ,     /* CHAR  */
                           INPUT            fi_prevbat ,     /* CHAR  */ /*Previous Batch*/
                           INPUT            "WGWGEN60" ,     /* CHAR  */
                           INPUT-OUTPUT     nv_batchno ,     /* CHAR  */
                           INPUT-OUTPUT     nv_batcnt  ,     /* INT   */
                           INPUT            nv_imppol  ,     /* INT   */
                           INPUT            nv_impprem ).
    ASSIGN
        fi_bchno = CAPS(nv_batchno + "." + STRING(nv_batcnt,"99")).
    DISP  fi_bchno   WITH FRAME fr_main.
    RUN proc_chktest1.  
    FOR EACH wdetail WHERE wdetail.pass = "y" :
        ASSIGN
            nv_completecnt = nv_completecnt + 1
            nv_netprm_s    = nv_netprm_s    + decimal(wdetail.premt). 
    END.
    nv_rectot = nv_reccnt.      
    nv_recsuc = nv_completecnt. 
    IF nv_rectot <> nv_recsuc   THEN nv_batflg = NO.
    IF  nv_netprm_t <> nv_netprm_s THEN nv_batflg = NO.
    ELSE nv_batflg = YES.
    FIND LAST uzm701 USE-INDEX uzm70102 WHERE
        uzm701.bchyr   = nv_batchyr     AND
        uzm701.bchno   = nv_batchno     AND
        uzm701.bchcnt  = nv_batcnt      NO-ERROR.
    IF AVAIL uzm701 THEN DO:
        ASSIGN
            uzm701.recsuc      = nv_recsuc     
            uzm701.premsuc     = nv_netprm_s   
            uzm701.rectot      = nv_rectot     
            uzm701.premtot     = nv_netprm_t   
            uzm701.impflg      = nv_batflg    
            uzm701.cnfflg      = nv_batflg .   
    END.
    ASSIGN
        fi_impcnt      = nv_rectot
        fi_premtot     = nv_netprm_t
        fi_completecnt = nv_recsuc
        fi_premsuc     = nv_netprm_s .
    IF nv_rectot <> nv_recsuc  THEN nv_txtmsg = " have record error..!! ".
    ELSE nv_txtmsg = "      have batch file error..!! ".
    IF nv_batflg = NO THEN DO:  
        ASSIGN
            fi_completecnt:FGCOLOR = 6
            fi_premsuc    :FGCOLOR = 6 
            fi_bchno      :FGCOLOR = 6. 
        DISP fi_completecnt fi_premsuc WITH FRAME fr_main.
        MESSAGE "Batch Year  : " STRING(nv_batchyr)     SKIP
            "Batch No.   : " nv_batchno             SKIP
            "Batch Count : " STRING(nv_batcnt,"99") SKIP(1)
            TRIM(nv_txtmsg)                         SKIP
            "Please check Data again."      
            VIEW-AS ALERT-BOX ERROR TITLE "WARNING MESSAGE".        
    END.
    ELSE IF nv_batflg = YES THEN DO: 
        ASSIGN
            fi_completecnt:FGCOLOR = 2
            fi_premsuc:FGCOLOR     = 2 
            fi_bchno:FGCOLOR       = 2.
        FOR EACH wdetail WHERE wdetail.number <> "" NO-LOCK.
             FIND LAST brstat.tlt WHERE brstat.tlt.rec_addr1     = trim(wdetail.nv_icno)  AND
                                        brstat.tlt.nor_noti_ins  = trim(wdetail.number)   AND
                                        brstat.tlt.genusr        = "PMIB"  NO-ERROR NO-WAIT.
             IF AVAIL brstat.tlt THEN DO:
               ASSIGN  brstat.tlt.releas   = IF INDEX(brstat.tlt.releas,"CANCEL") <> 0 THEN  "CANCEL/YES" ELSE "YES"   /* ออกงานแล้ว */
                       brstat.tlt.entdat   = TODAY    /*วันที่ Load file to GW , วันที่ match cancel*/
                       brstat.tlt.usrsent  = n_User . /* user ที่ยกเลิก / user Load */
             END.
        END.
        MESSAGE "Process Complete" VIEW-AS ALERT-BOX INFORMATION TITLE "INFORMATION".
    END.
    RUN   proc_open.    
    DISP  fi_impcnt fi_completecnt fi_premtot fi_premsuc WITH FRAME fr_main.
    RUN proc_report1 .   
    RUN PROC_REPORT2 .
    RUN proc_screen  .   
    RELEASE uzm700.
    RELEASE uzm701.
    RELEASE sicsyac.xcpara49.
    RELEASE brstat.tlt.
    RELEASE sic_bran.uwm100.
    RELEASE sic_bran.uwd100.
    RELEASE sic_bran.uwd102.
    RELEASE sic_bran.uwd105.
    RELEASE sic_bran.uwm120.
    RELEASE sic_bran.uwd120.
    RELEASE sic_bran.uwd121.
    RELEASE sic_bran.uwd123.
    RELEASE sic_bran.uwd125.
    RELEASE sic_bran.uwm130.
    RELEASE sic_bran.uwd130.
    RELEASE sic_bran.uwd131.
    RELEASE sic_bran.uwd132.
    RELEASE sic_bran.uwm307.
    RELEASE sic_bran.uwm200.
    RELEASE sic_bran.uwd200.
    RELEASE sic_bran.uwd201.
    RELEASE brstat.detaitem.
    RELEASE sicsyac.xzm056.
    RELEASE sicsyac.xmm600.
    RELEASE sicsyac.xtm600.
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_exit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_exit c-Win
ON CHOOSE OF bu_exit IN FRAME fr_main /* EXIT */
DO:
  APPLY "close" TO THIS-PROCEDURE.
      RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_file
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_file c-Win
ON CHOOSE OF bu_file IN FRAME fr_main /* ... */
DO:
    DEFINE VARIABLE cvData        AS CHARACTER NO-UNDO.
    DEFINE VARIABLE OKpressed AS LOGICAL INITIAL TRUE.

    DEF VAR no_add AS CHAR FORMAT "x(8)" . /*08/11/2006*/

   SYSTEM-DIALOG GET-FILE cvData
        TITLE      "Choose Data File to Import ..."
       
       FILTERS    /* "Text Documents" "*.csv"*/
       "CSV (Comma Delimited)"   "*.csv"   /*,
                            "Data Files (*.dat)"     "*.dat",
                    "Text Files (*.txt)" "*.txt"*/
                    
                            
        MUST-EXIST
        USE-FILENAME
        UPDATE OKpressed.
      
    IF OKpressed = TRUE THEN DO:
         /***--- 08/11/2006 ---***/
         no_add =           STRING(MONTH(TODAY),"99")    + 
                            STRING(DAY(TODAY),"99")      + 
                  SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) + 
                  SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2) .

         /***---a490166 ---***/
         ASSIGN
            fi_filename  = cvData
            fi_output1 = SUBSTRING(cvData,1,(LENGTH(fi_filename) - 4))  /* + "_SUCCESS" */ + no_add + ".fuw" /*.csv*/
            fi_output2 = SUBSTRING(cvData,1,(LENGTH(fi_filename) - 4))  /* + "_ERROR"   */ + no_add + ".err"
            fi_output3 = SUBSTRING(cvData,1,(LENGTH(fi_filename) - 4))  /* + "_SCREEN"  */ + no_add + ".sce". /*txt*/

         DISP fi_filename fi_output1 fi_output2 fi_output3  WITH FRAME {&FRAME-NAME}. 
         APPLY "Entry" TO fi_output3.
         RETURN NO-APPLY.
    END.

    

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_hpacno1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_hpacno1 c-Win
ON CHOOSE OF bu_hpacno1 IN FRAME fr_main
DO:
   Def   var     n_acno       As  Char.
   Def   var     n_agent      As  Char.    
     
   Run whp\whpacno1(output  n_acno, /*a490166 note modi*/ /*28/11/2006*/
                    output  n_agent).
                                          
     If  n_acno  <>  ""  Then  fi_producer =  n_acno.
     
     disp  fi_producer  with frame  fr_main.

     Apply "Entry"  to  fi_producer.
     Return no-apply.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_hpagent
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_hpagent c-Win
ON CHOOSE OF bu_hpagent IN FRAME fr_main
DO:
   Def   var     n_acno       As  Char.
   Def   var     n_agent      As  Char.    
     
   Run whp\whpacno1(output  n_acno,   /*a490166 note modi*/
                    output  n_agent). 
                                          
     If  n_acno  <>  ""  Then  fi_agent =  n_acno.
     
     disp  fi_agent  with frame  fr_main.

     Apply "Entry"  to  fi_agent.
     Return no-apply.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_hpbrn
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_hpbrn c-Win
ON CHOOSE OF bu_hpbrn IN FRAME fr_main
DO:
    Run  whp\whpbrn01(Input-output  fi_branch,   
                      Input-output  fi_brndes).
    Disp  fi_branch  fi_brndes  with frame  fr_main.                                     
    Apply "Entry"  To  fi_producer.
    Return no-apply.                            
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME cb_pdtype
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cb_pdtype c-Win
ON LEAVE OF cb_pdtype IN FRAME fr_main
DO:
   /* cb_pdtype = INPUT cb_pdtype.
    RUN proc_xpara49.
    DISP cb_pdtype br_xpara WITH FRAME fr_main.*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cb_pdtype c-Win
ON VALUE-CHANGED OF cb_pdtype IN FRAME fr_main
DO:
    cb_pdtype = INPUT cb_pdtype.
    RUN proc_brxpara.
    DISP cb_pdtype br_xpara WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_agent
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_agent c-Win
ON LEAVE OF fi_agent IN FRAME fr_main
DO:
    fi_agent = INPUT fi_agent.
    IF fi_agent <> ""    THEN DO:
        FIND sicsyac.xmm600 USE-INDEX xmm60001      WHERE
            sicsyac.xmm600.acno  =  Input fi_agent  NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL sicsyac.xmm600 THEN DO:
            Message  "Not on Name & Address Master File xmm600.."  View-as alert-box.
            Apply "Entry" To  fi_agent.
            RETURN NO-APPLY.  
        END.
        ELSE   
            ASSIGN  
                fi_agtname =  TRIM(sicsyac.xmm600.ntitle) + "  "  + TRIM(sicsyac.xmm600.name)
                fi_agent   =  caps(INPUT  fi_agent) .   
    END.
    Disp  fi_agent  fi_agtname  WITH Frame  fr_main.                 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_bchyr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_bchyr c-Win
ON LEAVE OF fi_bchyr IN FRAME fr_main
DO:
        nv_batchyr = INPUT fi_bchyr.
        IF nv_batchyr <= 0 THEN DO:
           MESSAGE "Batch Year Error...!!!".
           APPLY "entry" TO fi_bchyr.
           RETURN NO-APPLY.
        END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_branch
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_branch c-Win
ON LEAVE OF fi_branch IN FRAME fr_main
DO:
    fi_branch = caps(INPUT fi_branch) .
    IF  Input fi_branch  =  ""  Then do:
        Message "กรุณาระบุ Branch Code ." View-as alert-box.
        Apply "Entry"  To  fi_branch.
    END.
    Else do:
        FIND sicsyac.xmm023  USE-INDEX xmm02301      WHERE
            sicsyac.xmm023.branch   = TRIM(Input fi_branch)  NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL  sicsyac.xmm023 THEN DO:
            Message  "Not on Description Master File xmm023" View-as alert-box.
            Apply "Entry"  To  fi_branch.
            RETURN NO-APPLY.
        END.
        ELSE 
            ASSIGN fi_branch  =  CAPS(Input fi_branch) 
            fi_brndes  =  sicsyac.xmm023.bdes.
    END.    /*else do:*/
    Disp fi_branch  fi_brndes  With Frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_loaddat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_loaddat c-Win
ON LEAVE OF fi_loaddat IN FRAME fr_main
DO:
    fi_loaddat  =  Input  fi_loaddat.
    Disp  fi_loaddat  with  frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_prevbat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_prevbat c-Win
ON LEAVE OF fi_prevbat IN FRAME fr_main
DO:
    fi_prevbat = caps(INPUT fi_prevbat).
    nv_batprev = fi_prevbat.
    IF nv_batprev <> " "  THEN DO:
        IF LENGTH(nv_batprev) > 16 THEN DO:
            MESSAGE "Length Of Batch no. Must Be 16 Character " SKIP
                    "Please Check Batch No. Again             " view-as alert-box.
            APPLY "entry" TO fi_prevbat.
            RETURN NO-APPLY.
        END.
    END.     /*nv_batprev <> " "*/
    DISPLAY fi_prevbat WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_producer
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_producer c-Win
ON LEAVE OF fi_producer IN FRAME fr_main
DO:
    fi_producer = INPUT fi_producer.
    IF  fi_producer <> " " THEN DO:
        FIND sicsyac.xmm600 USE-INDEX xmm60001          WHERE
            sicsyac.xmm600.acno  =  Input fi_producer   NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL sicsyac.xmm600 THEN DO:
            Message  "Not on Name & Address Master File xmm600"  View-as alert-box.
            Apply "Entry" To  fi_producer.
            RETURN NO-APPLY.    /*note add on 10/11/2005*/
        END.
        ELSE 
            ASSIGN
                fi_proname  =  TRIM(sicsyac.xmm600.ntitle) + "  "  + TRIM(sicsyac.xmm600.name)
                fi_producer =  caps(INPUT  fi_producer)  /*note modi 08/11/05*/
                /*nv_producer = fi_producer*/    .       /*note add  08/11/05*/
         
    END.
    Disp  fi_producer  fi_proname  WITH Frame  fr_main.   
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_usrcnt
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_usrcnt c-Win
ON LEAVE OF fi_usrcnt IN FRAME fr_main
DO:
  fi_usrcnt = INPUT fi_usrcnt.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_usrprem
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_usrprem c-Win
ON LEAVE OF fi_usrprem IN FRAME fr_main
DO:
  fi_usrprem = INPUT fi_usrprem.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_vatcod
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_vatcod c-Win
ON LEAVE OF fi_vatcod IN FRAME fr_main
DO:
    fi_vatcod = INPUT fi_vatcod.
    IF fi_vatcod <> ""    THEN DO:
        FIND sicsyac.xmm600 USE-INDEX xmm60001       WHERE
            sicsyac.xmm600.acno  =  Input fi_vatcod  NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL sicsyac.xmm600 THEN DO:
            Message  "Not on Name & Address Master File xmm600" View-as alert-box.
            Apply "Entry" To  fi_vatcod.
            RETURN NO-APPLY.  
        END.
        ELSE  
            ASSIGN fi_vatcod   =  caps(INPUT  fi_vatcod). 
    END. 
    Disp  fi_vatcod   WITH Frame  fr_main.                 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK c-Win 


/* ***************************  Main Block  *************************** */

/* Set CURRENT-WINDOW: this will parent dialog-boxes and frames.        */
ASSIGN CURRENT-WINDOW                = {&WINDOW-NAME} 
       THIS-PROCEDURE:CURRENT-WINDOW = {&WINDOW-NAME}.

/* The CLOSE event can be used from inside or outside the procedure to  */
/* terminate it.                                                        */
ON CLOSE OF THIS-PROCEDURE 
   RUN disable_UI.
  
/* (NOTE: handle ERROR and END-KEY so cleanup code will always fire.    */
MAIN-BLOCK:
DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
   ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:
  RUN enable_UI.


/********************  T I T L E   F O R  C - W I N  ****************/
  DEF  VAR  gv_prgid   AS   CHAR  FORMAT "X(8)"   NO-UNDO.
  DEF  VAR  gv_prog    AS   CHAR  FORMAT "X(40)" NO-UNDO.
  
  gv_prgid = "Wgwgen60.w".
  gv_prog  = "Load Text & Generate PA M60".
  fi_loaddat = TODAY.
  DISP fi_loaddat WITH FRAME fr_main.
  RUN  WUT\WUTHEAD (c-win:handle,gv_prgid,gv_prog). /*28/11/2006*/
  RUN proc_xpara49.
  ASSIGN
      fi_branch   = "M" 
      fi_vatcod   = ""
      fi_producer = ""
      fi_agent    = ""
      fi_bchyr    = YEAR(TODAY)
      fi_process  = "Load Text file M60" 

      cb_pdtype:LIST-ITEMS   = nv_product
      cb_pdtype = ENTRY(1,nv_product) .

  /*RUN proc_brxpara.*/
  DISP fi_process fi_branch fi_vatcod  fi_producer fi_agent fi_bchyr cb_pdtype WITH FRAME fr_main.
/*********************************************************************/  
  RUN  WUT\WUTWICEN (c-win:handle).  
  Session:data-Entry-Return = Yes.

  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI c-Win  _DEFAULT-DISABLE
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
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(c-Win)
  THEN DELETE WIDGET c-Win.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI c-Win  _DEFAULT-ENABLE
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
  DISPLAY cb_pdtype fi_loaddat fi_branch fi_producer fi_bchno fi_agent fi_vatcod 
          fi_prevbat fi_bchyr fi_filename fi_output1 fi_output2 fi_output3 
          fi_usrcnt fi_usrprem fi_brndes fi_proname fi_agtname fi_impcnt 
          fi_process fi_completecnt fi_premtot fi_premsuc 
      WITH FRAME fr_main IN WINDOW c-Win.
  ENABLE br_xpara cb_pdtype fi_loaddat fi_branch fi_producer fi_bchno fi_agent 
         fi_vatcod fi_prevbat fi_bchyr fi_filename bu_file fi_output1 
         fi_output2 fi_output3 fi_usrcnt fi_usrprem buok bu_exit br_wdetail 
         bu_hpbrn bu_hpacno1 bu_hpagent fi_process RECT-370 RECT-372 RECT-373 
         RECT-374 RECT-375 RECT-376 RECT-377 RECT-378 
      WITH FRAME fr_main IN WINDOW c-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW c-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_addr c-Win 
PROCEDURE proc_addr :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR n_comp     AS CHAR FORMAT "x(50)" .
DEF VAR n_ban     AS CHAR FORMAT "x(50)" init "".
DEF VAR n_moo     AS CHAR FORMAT "x(50)" init "".
DEF VAR n_soi     AS CHAR FORMAT "x(50)" init "".
DEF VAR n_road    AS CHAR FORMAT "x(50)" init "".
DEF VAR n_subdis  AS CHAR FORMAT "x(50)" init "".
DEF VAR n_day   AS int init 0.  
DEF VAR n_month AS int init 0.  
DEF VAR n_year  AS int init 0.  
DEF VAR n_length AS INT .
DO:
    ASSIGN n_comdat = ?     n_ban    = ""                
           n_day    = 0     n_moo    = ""
           n_month  = 0     n_soi    = ""
           n_year   = 0     n_road   = ""
           nv_name   = ""   n_subdis = ""
           nv_lname  = "".

    IF trim(n_title) = "นาย"         THEN n_title = "คุณ".
    ELSE IF trim(n_title) = "นางสาว" THEN n_title = "คุณ".
    ELSE IF trim(n_title) = "นาง"    THEN n_title = "คุณ".
    ELSE IF trim(n_title) = "น.ส."   THEN n_title = "คุณ".

    IF n_effdat <> ""  THEN DO:
        n_comdat = DATE(n_effdat).
        IF YEAR(n_comdat) > YEAR(TODAY) THEN DO:
           ASSIGN n_day      = DAY(n_comdat)
                  n_month    = MONTH(n_comdat)
                  n_year     = (YEAR(n_comdat) - 543)
                  n_effdat   = STRING(n_day,"99") + "/" +
                               STRING(n_month,"99") + "/" +
                               STRING(n_year,"9999")
                  n_expdat   = STRING(n_day,"99") + "/" +
                               STRING(n_month,"99") + "/" +
                               STRING(n_year + 1,"9999")
                  n_firstdat = n_effdat .
        END.
    END.
    IF n_bdate <> ""  THEN DO:
        ASSIGN  n_day    = 0
                n_month  = 0
                n_year   = 0
                n_day    = DAY(DATE(n_bdate)) 
                n_month  = MONTH(DATE(n_bdate)) 
                n_year   = (YEAR(DATE(n_bdate)) - 543 )
                n_bdate  = STRING(n_day,"99") + "/" +
                           STRING(n_month,"99") + "/" +
                           STRING(n_year,"9999").
    END.
    /*---- check Address --------------*/
    IF INDEX(n_addr1,"ส่งถึง") <> 0 THEN DO:
        IF INDEX(n_addr1,"(")  <> 0 THEN n_addr1  = trim(REPLACE(n_addr1,"("," ")).
        IF INDEX(n_addr1,")")  <> 0 THEN n_addr1  = trim(REPLACE(n_addr1,")"," ")).
        IF INDEX(n_addr1,"  ") <> 0 THEN n_addr1 = trim(REPLACE(n_addr1,"  "," ")).
        
        ASSIGN  nv_name  = trim(SUBSTR(n_addr1,1,INDEX(n_addr1," ")))
                n_length = LENGTH(nv_name) + 1
                n_addr1  = trim(SUBSTR(n_addr1,n_length,LENGTH(n_addr1)))  
                nv_lname = trim(SUBSTR(n_addr1,1,INDEX(n_addr1," ")))
                n_length = LENGTH(nv_lname) + 1 
                n_addr1  = trim(SUBSTR(n_addr1,n_length,LENGTH(n_addr1))) .
    END.

    IF trim(n_addr3) <> ""  THEN DO:
        IF (index(n_addr3,"กทม") <> 0 ) OR (index(n_addr3,"กรุงเทพ") <> 0 ) THEN 
            ASSIGN 
            n_addr2   = "เขต" + trim(n_addr2)
            n_addr3   = trim(n_addr3) 
            n_addr4   = TRIM(n_addr4) .
            
        ELSE ASSIGN 
            n_addr2   = "อ." + trim(n_addr2)
            n_addr3   = "จ." + trim(n_addr3) + " " + trim(n_addr4)  
            n_addr4   = "" .
    END.

    /*--- ใส่ตัวย่อ -----------*/
    DO WHILE INDEX(n_addr1,"บริษัท") <> 0 AND INDEX(n_addr1,"จำกัด") <> 0 :
        ASSIGN n_addr1 = trim(REPLACE(n_addr1,"บริษัท","บจก."))
               n_addr1 = trim(REPLACE(n_addr1,"จำกัด","")).
    END.
    DO WHILE INDEX(n_addr1,"หมู่บ้าน/อาคาร") <> 0 :
        ASSIGN n_addr1 = trim(REPLACE(n_addr1,"หมู่บ้าน/อาคาร","")).
    END.
    DO WHILE INDEX(n_addr1,"หมู่ที่") <> 0 :
        ASSIGN n_addr1 = trim(REPLACE(n_addr1,"หมู่ที่","ม.")).
    END.
    DO WHILE INDEX(n_addr1,"หมู่") <> 0 :
        ASSIGN n_addr1 = trim(REPLACE(n_addr1,"หมู่","ม.")).
    END.
    DO WHILE INDEX(n_addr1,"ถนน") <> 0 :
        ASSIGN n_addr1 = trim(REPLACE(n_addr1,"ถนน","ถ.")).
    END.
    DO WHILE INDEX(n_addr1,"ซอย") <> 0 :
        ASSIGN n_addr1 = trim(REPLACE(n_addr1,"ซอย","ซ.")).
    END.
    DO WHILE INDEX(n_addr1,"ตำบล") <> 0 :
        ASSIGN n_addr1 = trim(REPLACE(n_addr1,"ตำบล","ต.")).
    END.
    DO WHILE INDEX(n_addr3,"กรุงเทพมหานคร") <> 0 :
        ASSIGN n_addr3 = trim(REPLACE(n_addr3,"กรุงเทพมหานคร","กรุงเทพฯ")).
    END.

    /*----- แยกข้อมูลของ n_addr1 --------------------*/
    IF INDEX(n_addr1,"แขวง") <> 0 THEN DO:
        ASSIGN n_subdis = SUBSTR(n_addr1,R-INDEX(n_addr1,"แขวง"))
               n_addr1  = SUBSTR(n_addr1,1,R-INDEX(n_addr1,"แขวง") - 1).
    END.
    ELSE IF INDEX(n_addr1,"ต.") <> 0 THEN DO:
        ASSIGN n_subdis = SUBSTR(n_addr1,R-INDEX(n_addr1,"ต."))
               n_addr1  = SUBSTR(n_addr1,1,R-INDEX(n_addr1,"ต.") - 1).
    END.

    IF INDEX(n_addr1,"ถ.") <> 0 THEN DO:
        ASSIGN n_road   = SUBSTR(n_addr1,R-INDEX(n_addr1,"ถ."))
               n_addr1  = SUBSTR(n_addr1,1,R-INDEX(n_addr1,"ถ.") - 1).
    END.

    IF INDEX(n_addr1,"ซ.") <> 0 THEN DO:
        ASSIGN n_soi    = SUBSTR(n_addr1,R-INDEX(n_addr1,"ซ."))
               n_addr1  = SUBSTR(n_addr1,1,R-INDEX(n_addr1,"ซ.") - 1).
    END.

    IF INDEX(n_addr1,"ม.") <> 0 THEN DO:
        ASSIGN n_moo   = SUBSTR(n_addr1,R-INDEX(n_addr1,"ม."))
               n_addr1  = SUBSTR(n_addr1,1,R-INDEX(n_addr1,"ม.") - 1).
    END.

    IF INDEX(n_addr1,"บ้านเลขที่") <> 0 THEN DO:
        ASSIGN n_ban    = SUBSTR(n_addr1,R-INDEX(n_addr1,"บ้านเลขที่"))
               n_addr1  = SUBSTR(n_addr1,1,R-INDEX(n_addr1,"บ้านเลขที่") - 1)
               n_ban    = REPLACE(n_ban,"บ้านเลขที่","").
    END.
    ELSE IF INDEX(n_addr1,"เลขที่") <> 0 THEN DO:
        ASSIGN n_ban    = SUBSTR(n_addr1,R-INDEX(n_addr1,"เลขที่"))
               n_addr1  = SUBSTR(n_addr1,1,R-INDEX(n_addr1,"เลขที่") - 1).
    END.

    IF INDEX(n_addr1,"นิคมอุตสาหกรรม") <> 0 THEN DO:
        ASSIGN n_comp    = SUBSTR(n_addr1,R-INDEX(n_addr1,"นิคมอุตสาหกรรม"))
               n_addr1  = SUBSTR(n_addr1,1,R-INDEX(n_addr1,"นิคมอุตสาหกรรม") - 1).
        IF INDEX(n_comp," ") <> 0 THEN ASSIGN n_comp = trim(REPLACE(n_comp," ","")).
    END.
    ELSE IF INDEX(n_addr1,"โรงงาน") <> 0 THEN DO:
        ASSIGN n_comp    = SUBSTR(n_addr1,R-INDEX(n_addr1,"โรงงาน"))
               n_addr1  = SUBSTR(n_addr1,1,R-INDEX(n_addr1,"โรงงาน") - 1).
        IF INDEX(n_comp," ") <> 0 THEN ASSIGN n_comp = trim(REPLACE(n_comp," ","")).
    END.

    DO WHILE INDEX(n_addr1,"  ") <> 0 :
        ASSIGN n_addr1 = trim(REPLACE(n_addr1,"  "," ")).
    END.
    DO WHILE INDEX(n_addr1," ") <> 0 :
        ASSIGN n_addr1 = trim(REPLACE(n_addr1," ","")).
    END.

    /*------------------- รวมข้อมูล n_addr1 ----------------*/
    ASSIGN n_addr1 = n_addr1 + " " + TRIM(n_comp) + " " + TRIM(n_ban) + " " +  
                     trim(n_moo) + " " + TRIM(n_soi) + " " + TRIM(n_road) + " " + TRIM(n_subdis) .

    /*---------- check length > 35 ---------------------*/
    IF LENGTH(n_addr1) > 35  THEN DO:
      loop_add01:
      DO WHILE LENGTH(n_addr1) > 35 :
          IF r-INDEX(n_addr1," ") <> 0 THEN DO:
              ASSIGN 
                  n_addr2  = trim(SUBSTR(n_addr1,r-INDEX(n_addr1," "))) + " " + TRIM(n_addr2) 
                  n_addr1  = trim(SUBSTR(n_addr1,1,r-INDEX(n_addr1," "))).
          END.
          ELSE LEAVE loop_add01.
      END.
      loop_add02:
      DO WHILE LENGTH(n_addr2) > 35 :
          IF r-INDEX(n_addr2," ") <> 0 THEN DO:
              ASSIGN 
                  n_addr3  = trim(SUBSTR(n_addr2,r-INDEX(n_addr2," "))) + " " + TRIM(n_addr3) 
                  n_addr2  = trim(SUBSTR(n_addr2,1,r-INDEX(n_addr2," "))).
          END.
          ELSE LEAVE loop_add02.
      END.
      loop_add03:
      DO WHILE LENGTH(n_addr3) > 35 :
          IF r-INDEX(n_addr3," ") <> 0 THEN DO:
              ASSIGN 
                  n_addr4  = trim(SUBSTR(n_addr3,r-INDEX(n_addr3," "))) + " " + TRIM(n_addr4)
                  n_addr3  = trim(SUBSTR(n_addr3,1,r-INDEX(n_addr3," "))).
          END.
          ELSE LEAVE loop_add03.
      END.
    END.

END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assign c-Win 
PROCEDURE proc_assign :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
-------------------------------------------------------------------------------*/
DO:
    For each  wdetail :
        DELETE  wdetail.
    END.
    
    INPUT FROM VALUE(fi_FileName).
    REPEAT:
        IMPORT DELIMITER "|" 
            n_idno          /*No.             */ 
            n_datesend      /*วันที่ส่งข้อมูล */ 
            n_refno         /*APPLICATION_ID  */ 
            n_title         /*TITLE_NAME      */ 
            n_name          /*INSURED_NAME    */ 
            n_lname         /*INSURED_LASTNAME*/ 
            n_icno          /*CUSTOMER_ID     */ 
            n_bdate         /*BIRDTE          */ 
            n_age           /*AGE             */ 
            n_plan          /*Plan            */ 
            n_siins         /*Sum Insurance   */ 
            n_prem          /*ค่าเบี้ย PA     */ 
            n_addr1         /*ADDR1           */ 
            n_addr2         /*AMPHUR          */ 
            n_addr3         /*PROVINCE_TH     */ 
            n_addr4         /*POST_CODE       */ 
            n_mobile        /*MOBILE_NUMBER   */ 
            n_phone         /*PHONE_NUMBER    */ 
            n_effdat .       /*Eff.Date        */
        IF INDEX(n_idno,"Mail") <> 0 THEN DO:
            ASSIGN nv_mail = TRIM(n_idno) + ": " + trim(n_datesend).
            NEXT.
        END.
        ELSE IF index(n_idno,"No") <> 0  THEN NEXT.
        ELSE IF n_idno = ""  THEN NEXT.
        ELSE DO:
            RUN proc_addr.
            RUN proc_create60.
            RUN proc_initdata.
        END.
    END.                  /* repeat   */
    FOR EACH wdetail.
        ASSIGN fi_process  = "check data policy master... " + wdetail.policy.
        DISP fi_process  WITH FRAME fr_main.
        IF deci(wdetail.premt) <> 0 THEN DO:
            FIND LAST wxpara49 WHERE wxpara49.prem_c = deci(wdetail.premt) NO-LOCK NO-ERROR.
                IF AVAIL wxpara49 THEN
                    ASSIGN  wdetail.polmaster   = wxpara49.para10
                            wdetail.cr_1        = wxpara49.para1
                            wdetail.class       = wxpara49.para11.
        END.
    END.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_brxpara c-Win 
PROCEDURE proc_brxpara :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
OPEN QUERY br_xpara FOR EACH wxpara49 WHERE index(wxpara49.para12,cb_pdtype) <> 0 NO-LOCK.
    DISP br_xpara WITH FRAME fr_main.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chktest0 c-Win 
PROCEDURE proc_chktest0 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
 ASSIGN fi_process  = "Check data...." + wdetail.policy.
DISP fi_process  WITH FRAME fr_main.

IF wdetail.cancel = "ca"  THEN  
    ASSIGN wdetail.pass    = "N"  
    wdetail.comment = wdetail.comment + "| cancel"
    wdetail.OK_GEN  = "N".
IF wdetail.insnam = " " THEN 
    ASSIGN wdetail.comment = wdetail.comment + "| ชื่อผู้เอาประกันเป็นค่าว่างกรูณาใส่ชื่อผู้เอาประกัน"
    wdetail.pass    = "N"     
    wdetail.OK_GEN  = "N".
IF wdetail.class = " " THEN  
    ASSIGN wdetail.comment = wdetail.comment + "| sub class เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
    wdetail.pass    = "N"  
    wdetail.OK_GEN  = "N".
IF wdetail.si = "" THEN
    ASSIGN wdetail.comment = wdetail.comment + "| ทุนประกันภัยเป็นค่าว่าง"
    wdetail.pass    = "N"  
    wdetail.OK_GEN  = "N".
IF wdetail.comdat = "" OR wdetail.comdat = "?" THEN
    ASSIGN wdetail.comment = wdetail.comment + "| วันที่คุ้มครองเป็นค่าว่าง"
    wdetail.pass    = "N"  
    wdetail.OK_GEN  = "N".
IF wdetail.expdat = "" OR wdetail.expdat = "?" THEN
    ASSIGN wdetail.comment = wdetail.comment + "| วันที่หมดอายุเป็นค่าว่าง"
    wdetail.pass    = "N"  
    wdetail.OK_GEN  = "N".
IF wdetail.premt = "" THEN
    ASSIGN wdetail.comment = wdetail.comment + "| เบี้ยประกันภัยเป็นค่าว่าง"
    wdetail.pass    = "N"  
    wdetail.OK_GEN  = "N".

ASSIGN 
    NO_CLASS  = trim(wdetail.class) 
    nv_poltyp = trim(wdetail.poltyp).
If no_class  <>  " " Then do:
    FIND FIRST  sicsyac.xmd031 USE-INDEX xmd03101 WHERE
        sicsyac.xmd031.poltyp =   nv_poltyp       AND
        sicsyac.xmd031.class  =   no_class        NO-LOCK NO-ERROR NO-WAIT.
    IF NOT AVAILABLE sicsyac.xmd031 THEN 
        ASSIGN  wdetail.comment = wdetail.comment + "| Not On Business Class xmd031" 
        wdetail.pass    = "N"   
        wdetail.OK_GEN  = "N".
    FIND sicsyac.xmm016 USE-INDEX xmm01601 WHERE 
        sicsyac.xmm016.class =    no_class  NO-LOCK NO-ERROR.
    IF NOT AVAILABLE sicsyac.xmm016 THEN 
        ASSIGN  wdetail.comment = wdetail.comment + "| Not on Business class on xmm016"
        wdetail.pass    = "N"    
        wdetail.OK_GEN  = "N".
    ELSE 
        ASSIGN  wdetail.tariff =   sicsyac.xmm016.tardef
            no_class           =   sicsyac.xmm016.class
            nv_sclass          =   Substr(no_class,2,3).
END.

RELEASE sicsyac.xmd031.
RELEASE sicsyac.xmm016.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chktest1 c-Win 
PROCEDURE proc_chktest1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
-----------------------------------------------------------------------------*/
RUN proc_var.
LOOP_WDETAIL:
FOR EACH wdetail :
    /*------------------  new ---------------------*/
    IF wdetail.policy = "" THEN RUN proc_temppolicy.
    ASSIGN 
        n_rencnt      =  0  
        n_Endcnt      =  0
        wdetail.n_rencnt = 0
        wdetail.n_endcnt = 0
        wdetail.pass     = "Y".
        IF wdetail.polmaster <> "" THEN DO:
            RUN proc_chktest0.
            ASSIGN fi_process  = "Check data and Create data to sic_bran.... " + wdetail.policy.
            DISP fi_process  WITH FRAME fr_main.
            FIND LAST sicuw.uwm100  USE-INDEX uwm10002 WHERE sicuw.uwm100.cedpol = trim(wdetail.number) AND 
                                                             sicuw.uwm100.poltyp = TRIM(wdetail.poltyp) NO-LOCK NO-ERROR NO-WAIT.
                IF AVAIL sicuw.uwm100 THEN DO:
                    IF sicuw.uwm100.name1 <> "" AND sicuw.uwm100.comdat = DATE(wdetail.comdat) /*AND sicuw.uwm100.releas = YES*/ THEN DO:
                        ASSIGN  wdetail.pass    = "N"
                                wdetail.comment = wdetail.comment + "| เลขรับแจ้งนี้ได้ถูกใช้ไปแล้ว "
                                wdetail.warning = "Program Running Policy No. ให้ชั่วคราว".
                    END.
                    IF wdetail.policy = "" THEN DO:
                        RUN proc_temppolicy.
                        ASSIGN wdetail.policy  = nv_tmppol.
                    END.
                END.
            IF wdetail.pass = "Y" THEN RUN Proc_uwm100.  
        END.
        ELSE DO:
            ASSIGN wdetail.comment = wdetail.comment + "| Policy Master เป็นค่าว่างไม่สามารถสร้างข้อมูลได้ กรุณาตรวจสอบเบี้ยอีกครั้ง"
            wdetail.pass    = "N"  
            wdetail.OK_GEN  = "N".
        END.
            
END.        /*for each*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_create60 c-Win 
PROCEDURE proc_create60 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nn_prmtxt     AS CHAR FORMAT "x(600)" INIT "" .
FIND FIRST wdetail WHERE wdetail.policy = "M60" + substr(n_refno,5,LENGTH(n_refno))  NO-ERROR NO-WAIT.
IF NOT AVAIL wdetail THEN DO:
    CREATE wdetail.
    ASSIGN 
        wdetail.number      = trim(n_refno) 
        wdetail.polmaster   = ""
        wdetail.cr_1        = ""
        wdetail.policy      = trim("M60" + substr(n_refno,5,LENGTH(n_refno)))
        wdetail.poltyp      = "M60"
        wdetail.branch      = trim(fi_branch) 
        wdetail.tiname      = trim(n_title)
        wdetail.insnam      = trim(n_name) + " " + trim(n_lname) 
        wdetail.name2       = TRIM(nv_name) + " " + TRIM(nv_lname)
        wdetail.nv_icno     = TRIM(n_icno)
        wdetail.bdate       = trim(n_bdate)
        wdetail.age         = trim(n_age)
        wdetail.n_addr1     = TRIM(n_addr1)
        wdetail.n_addr2     = TRIM(n_addr2)
        wdetail.n_addr3     = TRIM(n_addr3)
        wdetail.n_addr4     = TRIM(n_addr4)
        wdetail.covcod      = trim(n_plan)            
        wdetail.si          = trim(n_siins)  
        wdetail.premt       = TRIM(n_prem)           
        wdetail.class       = "" 
        wdetail.phone       = TRIM(n_phone)
        wdetail.mobile      = TRIM(n_mobile)
        wdetail.mail        = TRIM(nv_mail)
        wdetail.notidate    = TRIM(n_datesend)
        wdetail.comdat      = trim(n_effdat)
        wdetail.expdat      = trim(n_expdat)
        wdetail.firstdat    = trim(n_firstdat)
        wdetail.benname     = trim(n_title) + " " + trim(n_name) + " " + trim(n_lname)  
        wdetail.pass        = "y"
        wdetail.producer    = trim(fi_producer)
        wdetail.agent       = trim(fi_agent)
        wdetail.vatcode     = trim(fi_vatcod)
        wdetail.promo       = TRIM(cb_pdtype).
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_createins c-Win 
PROCEDURE proc_createins :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_name     AS CHAR.
DEF VAR nv_transfer AS LOGICAL.
DEF VAR n_insref    AS CHARACTER FORMAT "X(10)".
DEF VAR putchr      AS CHAR      FORMAT "X(200)" INIT "" NO-UNDO.
DEF VAR putchr1     AS CHAR      FORMAT "X(100)" INIT "" NO-UNDO.
DEF VAR nv_usrid    AS CHARACTER FORMAT "X(08)".

DO:
    ASSIGN fi_process = "Create insured code..." + wdetail.policy .
    DISP fi_process WITH FRAM fr_main.

    nv_name = wdetail.tiname + wdetail.insnam .
    
    nv_usrid    = SUBSTRING(USERID(LDBNAME(1)),3,4).
    nv_transfer = YES.
    
    FIND LAST sicsyac.xmm600 USE-INDEX  xmm60002 WHERE
              sicsyac.xmm600.NAME = wdetail.insnam
    NO-ERROR NO-WAIT.
    IF NOT AVAILABLE sicsyac.xmm600 THEN DO:
      IF LOCKED sicsyac.xmm600 THEN DO:
        nv_transfer = NO.
        n_insref = sicsyac.xmm600.acno.
        RETURN.
      END.
      ELSE DO:
        n_check   = "".
        nv_insref = "".
       
        IF R-INDEX(nv_name,"จก.")             <> 0  OR              
           R-INDEX(nv_name,"จำกัด")           <> 0  OR  
           R-INDEX(nv_name,"(มหาชน)")         <> 0  OR  
           R-INDEX(nv_name,"INC.")            <> 0  OR 
           R-INDEX(nv_name,"CO.")             <> 0  OR 
           R-INDEX(nv_name,"LTD.")            <> 0  OR 
           R-INDEX(nv_name,"LIMITED")         <> 0  OR 
           INDEX(nv_name,"บริษัท")            <> 0  OR 
           INDEX(nv_name,"บ.")                <> 0  OR 
           INDEX(nv_name,"บจก.")              <> 0  OR 
           INDEX(nv_name,"หจก.")              <> 0  OR 
           INDEX(nv_name,"หสน.")              <> 0  OR 
           INDEX(nv_name,"บรรษัท")            <> 0  OR 
           INDEX(nv_name,"มูลนิธิ")           <> 0  OR 
           INDEX(nv_name,"ห้าง")              <> 0  OR 
           INDEX(nv_name,"ห้างหุ้นส่วน")      <> 0  OR 
           INDEX(nv_name,"ห้างหุ้นส่วนจำกัด") <> 0  OR
           INDEX(nv_name,"ห้างหุ้นส่วนจำก")   <> 0  THEN nv_typ = "Cs".
        ELSE nv_typ = "0s".  /*0s= บุคคลธรรมดา Cs = นิติบุคคล*/
    
        RUN Proc_Insno. 
                  
        IF n_check <> "" THEN DO:
            ASSIGN
                putchr  = ""
                putchr1 = ""
                putchr1 = "Error Running Insured Code."
                putchr  = "Policy No. : " + TRIM(sic_bran.uwm100.policy)         +               
                          " R/E "         + STRING(sic_bran.uwm100.rencnt,"99")  +
                          "/"             + STRING(sic_bran.uwm100.endcnt,"999") +
                          " "             + TRIM(putchr1).
            /*--Suthida T. A55-0064--*/
            MESSAGE putchr1 SKIP putchr
            VIEW-AS ALERT-BOX.
            /*-- Suthida T. A55-0064 --*/
            nv_message  = putchr1.
            nv_transfer = NO.
            nv_insref   = "".
            RETURN.
        END.
    
        loop_runningins: /*Check Insured*/
        REPEAT:
          FIND sicsyac.xmm600 USE-INDEX xmm60001 WHERE
               sicsyac.xmm600.acno = CAPS(nv_insref)  NO-LOCK NO-ERROR NO-WAIT.
          IF AVAIL sicsyac.xmm600 THEN DO:
              RUN Proc_Insno. 
              IF  n_check <> ""  THEN DO:   
                  ASSIGN
                      putchr  = ""
                      putchr1 = ""
                      putchr1 = "Error Running Insured Code."
                      putchr  = "Policy No. : " + TRIM(sic_bran.uwm100.policy)         +               
                                " R/E "         + STRING(sic_bran.uwm100.rencnt,"99")  +
                                "/"             + STRING(sic_bran.uwm100.endcnt,"999") +
                                " "             + TRIM(putchr1).
                  /*--Suthida T. A55-0064--*/
                  MESSAGE putchr1 SKIP putchr
                  VIEW-AS ALERT-BOX.
                  /*-- Suthida T. A55-0064 --*/
                  nv_message  = putchr1.
                  nv_transfer = NO.
                  nv_insref   = "".
                  RETURN.
              END.
          END.  
          ELSE LEAVE loop_runningins.
        END.
        
        CREATE sicsyac.xmm600.
      END.
      n_insref = nv_insref.
    END.
    ELSE DO:
      nv_insref = sicsyac.xmm600.acno.
      ASSIGN
        sicsyac.xmm600.ntitle   = trim(wdetail.tiname)     /*Title for Name Mr/Mrs/etc*/
        sicsyac.xmm600.fname    = ""                        /*First Name*/
        sicsyac.xmm600.name     = trim(wdetail.insnam)      /*Name Line 1*/     
        sicsyac.xmm600.abname   = trim(wdetail.insnam)      /*Abbreviated Name*/
        sicsyac.xmm600.icno     = trim(wdetail.nv_icno)     /*IC No.*/          
        sicsyac.xmm600.addr1    = trim(wdetail.n_addr1)     /*Address line 1*/
        sicsyac.xmm600.addr2    = trim(wdetail.n_addr2)     /*Address line 2*/
        sicsyac.xmm600.addr3    = trim(wdetail.n_addr3)     /*Address line 3*/
        sicsyac.xmm600.addr4    = trim(wdetail.n_addr4)     /*Address line 4*/
        sicsyac.xmm600.homebr   = trim(wdetail.branch)      /*Home branch*/
        sicsyac.xmm600.entdat   = TODAY                     /*Entry date*/
        sicsyac.xmm600.enttim   = STRING(TIME,"HH:MM:SS")   /*Entry time*/
        sicsyac.xmm600.usrid    = nv_usrid .                 /*Userid*/
      n_insref  = nv_insref.
      nv_transfer = NO. /*-- Add chutikarn A50-0072 --*/
     /* RETURN.*/
    END.
    IF nv_transfer = YES THEN DO:
      ASSIGN
        sicsyac.xmm600.acno     = nv_insref                 /*Account no*/
        sicsyac.xmm600.gpstcs   = nv_insref                 /*Group A/C for statistics*/
        sicsyac.xmm600.gpage    = ""                        /*Group A/C for ageing*/
        sicsyac.xmm600.gpstmt   = ""                        /*Group A/C for Statement*/
        sicsyac.xmm600.or1ref   = ""                        /*OR Agent 1 Ref. No.*/
        sicsyac.xmm600.or2ref   = ""                        /*OR Agent 2 Ref. No.*/
        sicsyac.xmm600.or1com   = 0                         /*OR Agent 1 Comm. %*/
        sicsyac.xmm600.or2com   = 0                         /*OR Agent 2 Comm. %*/
        sicsyac.xmm600.or1gn    = "G"                       /*OR Agent 1 Gross/Net*/
        sicsyac.xmm600.or2gn    = "G"                       /*OR Agent 2 Gross/Net*/
        sicsyac.xmm600.ntitle   = trim(wdetail.tiname)     /*Title for Name Mr/Mrs/etc*/
        sicsyac.xmm600.fname    = ""                        /*First Name*/
        sicsyac.xmm600.name     = trim(wdetail.insnam)      /*Name Line 1*/     
        sicsyac.xmm600.abname   = trim(wdetail.insnam)      /*Abbreviated Name*/
        sicsyac.xmm600.icno     = trim(wdetail.nv_icno)     /*IC No.*/          
        sicsyac.xmm600.addr1    = trim(wdetail.n_addr1)     /*Address line 1*/
        sicsyac.xmm600.addr2    = trim(wdetail.n_addr2)     /*Address line 2*/
        sicsyac.xmm600.addr3    = trim(wdetail.n_addr3)     /*Address line 3*/
        sicsyac.xmm600.addr4    = trim(wdetail.n_addr4)     /*Address line 4*/
        sicsyac.xmm600.postcd   = ""                        /*Postal Code*/
        sicsyac.xmm600.clicod   = "IN"                      /*Client Type Code*/
        sicsyac.xmm600.acccod   = "IN"                      /*Account type code*/
        sicsyac.xmm600.relate   = ""                        /*Related A/C for RI Claims*/
        sicsyac.xmm600.notes1   = ""                        /*Notes line 1*/
        sicsyac.xmm600.notes2   = ""                        /*Notes line 2*/
        sicsyac.xmm600.homebr   = trim(wdetail.branch)      /*Home branch*/
        sicsyac.xmm600.opened   = TODAY                      /*Date A/C opened*/
        sicsyac.xmm600.prindr   = 1                         /*No. to print Dr/Cr N., default*/
        sicsyac.xmm600.langug   = ""                        /*Language Code*/
        sicsyac.xmm600.cshdat   = ?                         /*Cash terms wef date*/
        sicsyac.xmm600.legal    = ""                        /*Legal action pending/closed*/
        sicsyac.xmm600.stattp   = "I"                       /*Statement type I/B/N*/
        sicsyac.xmm600.autoap   = NO                        /*Automatic cash matching*/
        sicsyac.xmm600.ltcurr   = "BHT"                     /*Credit limit currency*/
        sicsyac.xmm600.ltamt    = 0                         /*Credit limit amount*/
        sicsyac.xmm600.exec     = ""                        /*Executive responsible*/
        sicsyac.xmm600.cntry    = "TH"                      /*Country code*/
        sicsyac.xmm600.phone    = ""                        /*Phone no.*/
        sicsyac.xmm600.closed   = ?                         /*Date A/C closed*/
        sicsyac.xmm600.crper    = 0                         /*Credit period*/
        sicsyac.xmm600.pvfeq    = 0                         /*PV frequency/Type code*/
        sicsyac.xmm600.comtab   = 1                         /*Commission table no*/
        sicsyac.xmm600.chgpol   = YES                       /*Allow N & A change on pol.Y/N*/
        sicsyac.xmm600.entdat   = TODAY                     /*Entry date*/
        sicsyac.xmm600.enttim   = STRING(TIME,"HH:MM:SS")   /*Entry time*/
        sicsyac.xmm600.usrid    = nv_usrid                  /*Userid*/
        sicsyac.xmm600.regagt   = ""                        /*Registered agent code*/
        sicsyac.xmm600.agtreg   = ""                        /*Agents Registration/Licence No*/
        sicsyac.xmm600.debtyn   = YES                       /*Permit debtor trans Y/N*/
        sicsyac.xmm600.crcon    = NO                        /*Credit Control Report*/
        sicsyac.xmm600.muldeb   = NO                        /*Multiple Debtors Acc.*/
        sicsyac.xmm600.styp20   = ""                        /*Statistic Type Codes (4 x 20)*/
        sicsyac.xmm600.sval20   = ""                        /*Statistic Value Codes (4 x 20)*/
        sicsyac.xmm600.dtyp20   = ""                        /*Type of Date Codes (2 X 20)*/
        sicsyac.xmm600.dval20   = ""                        /*Date Values (8 X 20)*/
        sicsyac.xmm600.iblack   = ""                        /*Insured Black List Code*/
        sicsyac.xmm600.oldic    = ""                        /*Old IC No.*/
        sicsyac.xmm600.cardno   = ""                        /*Credit Card Account No.*/
        sicsyac.xmm600.cshcrd   = ""                        /*Cash(C)/Credit(R) Agent*/
        sicsyac.xmm600.naddr1   = ""                        /*New address line 1*/
        sicsyac.xmm600.gstreg   = ""                        /*GST Registration No.*/
        sicsyac.xmm600.naddr2   = ""                        /*New address line 2*/
        sicsyac.xmm600.fax      = ""                        /*Fax No.*/
        sicsyac.xmm600.naddr3   = ""                        /*New address line 3*/
        sicsyac.xmm600.telex    = ""                        /*Telex No.*/
        sicsyac.xmm600.naddr4   = ""                        /*New address line 4*/
        sicsyac.xmm600.name2    = ""                        /*Name Line 2*/
        sicsyac.xmm600.npostcd  = ""                        /*New postal code*/
        sicsyac.xmm600.name3    = ""                        /*Name Line 3*/
        sicsyac.xmm600.nphone   = ""                        /*New phone no.*/    
        sicsyac.xmm600.nachg    = YES                       /*Change N&A on Renewal/Endt*/
        sicsyac.xmm600.regdate  = ?                         /*Agents registration Date*/
        sicsyac.xmm600.alevel   = 0                         /*Agency Level*/
        sicsyac.xmm600.taxno    = ""                        /*Agent tax no.*/
        sicsyac.xmm600.anlyc1   = ""                        /*Analysis Code 1*/
        sicsyac.xmm600.taxdate  = ?                         /*Agent tax date*/
        sicsyac.xmm600.anlyc5   =  "" .                     /*Analysis Code 5*/
    END.
    nv_insref = sicsyac.xmm600.acno.
    nv_transfer = YES.
    
    FIND sicsyac.xtm600 USE-INDEX xtm60001 WHERE sicsyac.xtm600.acno  = nv_insref NO-ERROR NO-WAIT.
    IF NOT AVAILABLE sicsyac.xtm600 THEN DO:
      IF LOCKED sicsyac.xtm600 THEN DO:
        nv_transfer = NO.
        RETURN.
      END.
      ELSE DO:
        CREATE sicsyac.xtm600.
      END.
    END.
    ELSE DO:
      ASSIGN 
        sicsyac.xtm600.name    = trim(wdetail.insnam)      /*Name of Insured Line 1*/  /*A60-0545*/
        sicsyac.xtm600.abname  = trim(wdetail.insnam)      /*Abbreviated Name*/        /*A60-0545*/
        sicsyac.xtm600.addr1   = trim(wdetail.n_addr1)     /*address line 1*/
        sicsyac.xtm600.addr2   = trim(wdetail.n_addr2)     /*address line 2*/
        sicsyac.xtm600.addr3   = trim(wdetail.n_addr3)     /*address line 3*/
        sicsyac.xtm600.addr4   = trim(wdetail.n_addr4)     /*address line 4*/
        sicsyac.xtm600.name2   = ""                        /*Name of Insured Line 2*/
        sicsyac.xtm600.ntitle  = trim(wdetail.tiname) .    /*Title*/
    END.
    
    IF nv_transfer = YES THEN DO:
      ASSIGN
        sicsyac.xtm600.acno    = nv_insref                 /*Account no.*/
        sicsyac.xtm600.name    = trim(wdetail.insnam)      /*Name of Insured Line 1*/  /*A60-0545*/
        sicsyac.xtm600.abname  = trim(wdetail.insnam)      /*Abbreviated Name*/        /*A60-0545*/
        sicsyac.xtm600.addr1   = trim(wdetail.n_addr1)     /*address line 1*/
        sicsyac.xtm600.addr2   = trim(wdetail.n_addr2)     /*address line 2*/
        sicsyac.xtm600.addr3   = trim(wdetail.n_addr3)     /*address line 3*/
        sicsyac.xtm600.addr4   = trim(wdetail.n_addr4)     /*address line 4*/
        sicsyac.xtm600.name2   = ""                        /*Name of Insured Line 2*/
        sicsyac.xtm600.ntitle  = trim(wdetail.tiname)      /*Title*/
        sicsyac.xtm600.name3   = ""                        /*Name of Insured Line 3*/
        sicsyac.xtm600.fname   = "" .                      /*First Name*/
    END.
    RETURN.
    HIDE MESSAGE NO-PAUSE.
END.
    
RELEASE sicsyac.xmm600.
RELEASE sicsyac.xtm600.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_initdata c-Win 
PROCEDURE proc_initdata :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

ASSIGN 
    n_idno    = ""
    n_datesend = ""
    n_refno   = ""
    n_title   = ""  
    n_name    = ""  
    n_lname   = ""  
    n_icno    = ""
    n_bdate   = ""  
    n_age     = ""  
    n_plan    = ""  
    n_siins   = ""  
    n_prem    = "" 
    n_addr1   = ""  
    n_addr2   = ""  
    n_addr3   = ""  
    n_addr4   = ""  
    n_mobile  = ""  
    n_phone   = ""  
    n_effdat  = ""  
    n_expdat  = ""
    n_firstdat = "".
   

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_insno c-Win 
PROCEDURE proc_insno :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

DEF VAR nv_lastno   AS INT. 
DEF VAR nv_seqno    AS INT.
DEF VAR n_search    AS LOGICAL. 

DO:
    n_search = YES.
    
    FIND LAST sicsyac.xzm056 USE-INDEX xzm05601 WHERE 
              sicsyac.xzm056.seqtyp  =  nv_typ      AND
              sicsyac.xzm056.branch  =  wdetail.branch  NO-LOCK NO-ERROR .
    IF NOT AVAIL xzm056 THEN DO :
      IF n_search = YES THEN DO:
          CREATE xzm056.
          ASSIGN
               sicsyac.xzm056.seqtyp   =  nv_typ
               sicsyac.xzm056.branch   =  wdetail.branch 
               sicsyac.xzm056.des      =  "Personal/Start"
               sicsyac.xzm056.lastno   =  1.                   
      END.
      ELSE DO:
          ASSIGN
              nv_insref  =    wdetail.branch + STRING(1,"999999").
              nv_lastno  =    1.
          RETURN.
      END.
    END. /*not avail xzm056*/       
    
    /*---- Begin 21/11/2006 Chutikarn ----*/
    ASSIGN
       nv_lastno = sicsyac.xzm056.lastno
       nv_seqno  = sicsyac.xzm056.seqno. 
    
    IF n_check = "YES" THEN DO:       
        IF nv_typ = "0s" THEN DO: 
           IF LENGTH(TRIM(wdetail.branch)) = 1 THEN DO:
                IF sicsyac.xzm056.lastno > 99999 THEN DO:
                    IF wdetail.branch = "A" OR wdetail.branch = "B" THEN DO:
                        nv_insref = "7" + wdetail.branch + STRING(sicsyac.xzm056.lastno,"99999999").
                    END.
                    ELSE nv_insref = "0" + wdetail.branch + STRING(sicsyac.xzm056.lastno,"99999999").
                END.
                ELSE DO: 
                    IF wdetail.branch = "A" OR wdetail.branch = "B" THEN DO:
                        nv_insref = "7" + wdetail.branch + STRING(sicsyac.xzm056.lastno,"99999999").
                    END.
                    ELSE nv_insref =      wdetail.branch + STRING(sicsyac.xzm056.lastno,"999999").
                END.
           END.
               
           ELSE  nv_insref = wdetail.branch + STRING(sicsyac.xzm056.lastno + 1 ,"99999999").
           
           CREATE sicsyac.xzm056.
           ASSIGN
              sicsyac.xzm056.seqtyp    =  nv_typ
              sicsyac.xzm056.branch    =  wdetail.branch 
              sicsyac.xzm056.des       =  "Personal/Start"
              sicsyac.xzm056.lastno    =  nv_lastno + 1
              sicsyac.xzm056.seqno     =  nv_seqno.   
        END.
        ELSE IF nv_typ = "Cs" THEN DO:
           IF LENGTH(TRIM(wdetail.branch)) = 1 THEN DO:
               IF sicsyac.xzm056.lastno > 99999 THEN DO:
                   IF wdetail.branch = "A" OR wdetail.branch = "B" THEN DO:
                       nv_insref = "7" + wdetail.branch + "C" + STRING(sicsyac.xzm056.lastno,"9999999").
                   END.
                   ELSE nv_insref = "0" + wdetail.branch + "C" + STRING(sicsyac.xzm056.lastno,"9999999").
               END.
               ELSE DO:
                   IF wdetail.branch = "A" OR wdetail.branch = "B" THEN DO:
                       nv_insref = "7" + wdetail.branch + "C" + STRING(sicsyac.xzm056.lastno,"9999999").
                   END.
                   ELSE nv_insref =      wdetail.branch + "C" + STRING(sicsyac.xzm056.lastno,"99999").
               END.
               /*--- END Add A56-0171 ---*/
           END.
           ELSE nv_insref = wdetail.branch + "C" + STRING(sicsyac.xzm056.lastno + 1 ,"9999999").
           /*-- End Add A54-0076 --*/
           CREATE sicsyac.xzm056.
           ASSIGN
              sicsyac.xzm056.seqtyp    =  nv_typ
              sicsyac.xzm056.branch    =  wdetail.branch 
              sicsyac.xzm056.des       =  "Company/Start"
              sicsyac.xzm056.lastno    =  nv_lastno + 1
              sicsyac.xzm056.seqno     =  nv_seqno. 
        END.
        n_check = "".
    END.
    ELSE DO:
        
        IF LENGTH(TRIM(wdetail.branch)) = 1 THEN DO:
                  IF   nv_typ = "0s" THEN DO:
                      IF sicsyac.xzm056.lastno > 99999 THEN DO:
                          IF wdetail.branch = "A" OR wdetail.branch = "B" THEN DO:
                              nv_insref = "7" + wdetail.branch + STRING(sicsyac.xzm056.lastno,"99999999").
                          END.
                          ELSE nv_insref = "0" + wdetail.branch + STRING(sicsyac.xzm056.lastno,"99999999").
                      END.
                      ELSE DO: 
                          IF wdetail.branch = "A" OR wdetail.branch = "B" THEN DO:
                              nv_insref = "7" + wdetail.branch + STRING(sicsyac.xzm056.lastno,"99999999").
                          END.
                          ELSE nv_insref =      wdetail.branch + STRING(sicsyac.xzm056.lastno,"999999").
                      END.
                      /*---- END Add A56-0171 ----*/
                  END. 
                  ELSE IF nv_typ = "Cs" THEN DO:
                       IF sicsyac.xzm056.lastno > 99999 THEN DO:
                           IF wdetail.branch = "A" OR wdetail.branch = "B" THEN DO:
                               nv_insref = "7" + wdetail.branch + "C" + STRING(sicsyac.xzm056.lastno,"9999999").
                           END.
                           ELSE nv_insref = "0" + wdetail.branch + "C" + STRING(sicsyac.xzm056.lastno,"9999999").
                       END.
                       ELSE DO:
                           IF wdetail.branch = "A" OR wdetail.branch = "B" THEN DO:
                               nv_insref = "7" + wdetail.branch + "C" + STRING(sicsyac.xzm056.lastno,"9999999").
                           END.
                           ELSE nv_insref =      wdetail.branch + "C" + STRING(sicsyac.xzm056.lastno,"99999").
                       END.
                       /*--- END Add A56-0171 ---*/
                  END.
            /*   -------------------------------- Suthida t. A55-0064 -------------------------------------------- */
        END.
        ELSE DO:
            IF      nv_typ = "0s" THEN nv_insref = wdetail.branch + STRING(sicsyac.xzm056.lastno,"99999999").
            ELSE IF nv_typ = "Cs" THEN nv_insref = wdetail.branch + "C" + STRING(sicsyac.xzm056.lastno,"9999999").
        END.
        /*-- End Add A54-0076 --*/
    END.
    /*---- End 21/11/2006 Chutikarn ----*/
    
    IF sicsyac.xzm056.lastno >  sicsyac.xzm056.seqno THEN DO :
      MESSAGE  "Running Code = Last No. / Please, Update Insured Running Code." SKIP
               "รหัสลูกค้า ถึงหมายเลขสุดท้ายแล้ว / ยกเลิกการทำงานชั่วคราว"      SKIP
               "แล้วติดต่อผู้ตั้ง Code"  VIEW-AS ALERT-BOX. 
      n_check = "ERROR".
      RETURN.                
    END. /*lastno > seqno*/                       
    ELSE DO :   /*lastno <= seqno */
       IF nv_typ = "0s" THEN DO:
           IF n_search = YES THEN DO:
               CREATE sicsyac.xzm056.
               ASSIGN
                     sicsyac.xzm056.seqtyp    =  nv_typ
                     sicsyac.xzm056.branch    =  wdetail.branch 
                     sicsyac.xzm056.des       =  "Personal/Start"
                     sicsyac.xzm056.lastno    =  nv_lastno + 1
                     sicsyac.xzm056.seqno     =  nv_seqno.   
           END.
       END.
       ELSE IF nv_typ = "Cs" THEN DO:
           IF n_search = YES THEN DO:
               CREATE sicsyac.xzm056.
               ASSIGN
                     sicsyac.xzm056.seqtyp    =  nv_typ
                     sicsyac.xzm056.branch    =  wdetail.branch 
                     sicsyac.xzm056.des       =  "Company/Start"
                     sicsyac.xzm056.lastno    =  nv_lastno + 1
                     sicsyac.xzm056.seqno     =  nv_seqno. 
           END.
       END.  
    
    END.   /*lastno <= seqno */ 
END.

RELEASE sicsyac.xzm056 .

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_open c-Win 
PROCEDURE proc_open :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
OPEN QUERY br_wdetail FOR EACH wdetail WHERE wdetail.pass = "y".

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_report1 c-Win 
PROCEDURE proc_report1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*nv_row  =  1.*/
DEF VAR a AS CHAR FORMAT "x(100)" INIT "".
DEF VAR b AS CHAR FORMAT "x(100)" INIT "".
DEF VAR c AS INTE INIT 0.
DEF VAR NOT_pass AS INTE INIT 0.
FOR EACH wdetail  WHERE wdetail.PASS <> "Y"  NO-LOCK :
         NOT_pass = NOT_pass + 1.
    
END.
IF NOT_pass > 0 THEN DO:
OUTPUT STREAM ns1 TO value(fi_output2).
PUT STREAM ns1
    "branch  "  ","
    "policy  "  ","                                      
    "cndat   "  ","
    "comdat  "  ","
    "expdat  "  ","
    "covcod  "  ","
    "tiname  "  ","
    "insnam  "  ","
    "vehuse  "  ","
    "si      "  ","
    "premt   "  ","
    "benname "  ","
    "pass    "  ","
    "comment "  ","
    "WARNING "   SKIP.

FOR EACH  wdetail  WHERE wdetail.PASS <> "Y" NO-LOCK:   
    PUT STREAM ns1 
        wdetail.branch    "," 
        wdetail.policy    ","
        wdetail.cndat     ","
        wdetail.comdat    ","
        wdetail.expdat    ","
        wdetail.covcod    ","
        wdetail.tiname    ","
        wdetail.insnam    ","
        wdetail.vehuse    "," 
        wdetail.si        "," 
        wdetail.premt     "," 
        wdetail.benname   ","   
        wdetail.pass      ","     
        wdetail.comment   ","
        wdetail.WARNING  SKIP.  
    
    END.
END.                                                                                    
OUTPUT STREAM ns1 CLOSE.                                                       
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PROC_REPORT2 c-Win 
PROCEDURE PROC_REPORT2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR HEAD AS CHAR INIT "Y".
/*nv_row  =  1.*/
DEF VAR a AS CHAR FORMAT "x(20)" INIT "".
DEF VAR b AS CHAR FORMAT "x(20)" INIT "".
DEF VAR c AS INTE INIT 0.
DEF VAR d AS INTE INIT 0.
DEF VAR f AS CHAR FORMAT "x(20)" INIT "".
DEF VAR pass AS INTE INIT 0.
FOR EACH  wdetail  WHERE wdetail.PASS = "Y"  NO-LOCK:
        pass = pass + 1.
END.

IF pass > 0 THEN DO:
OUTPUT STREAM ns2 TO value(fi_output1).
PUT STREAM NS2
    "branch "   ","
    "policy "   ","
    "cndat  "   ","
    "comdat "   ","
    "expdat "   ","
    "covcod "   ","
    "tiname "   ","
    "insnam "   ","
    "vehuse "   ","
    "si     "   ","
    "premt  "   ","
    "benname"   ","
    "pass   "   ","
    "comment"   ","
    "WARNING"  SKIP.

FOR EACH  wdetail  WHERE wdetail.PASS = "Y"  NO-LOCK:
        PUT STREAM ns2
        wdetail.branch    "," 
        wdetail.policy    ","
        wdetail.cndat     ","
        wdetail.comdat    ","
        wdetail.expdat    ","
        wdetail.covcod    ","
        wdetail.tiname    ","
        wdetail.insnam    ","
        wdetail.vehuse    "," 
        wdetail.si        "," 
        wdetail.premt     "," 
        wdetail.benname   ","   
        wdetail.pass      ","     
        wdetail.comment   ","
        wdetail.WARNING  SKIP.  
  END.
OUTPUT STREAM ns2 CLOSE.                                                           
END. /*pass > 0*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_screen c-Win 
PROCEDURE proc_screen :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
OUTPUT STREAM ns3 TO value(fi_output3).
PUT STREAM NS3   
"IMPORT TEXT FILE TISCO " SKIP
"             Loaddat : " fi_loaddat    SKIP
"              Branch : " fi_branch     SKIP
"       Producer Code : " fi_producer   SKIP
"          Agent Code : " fi_agent      SKIP
"  Previous Batch No. : " fi_prevbat   " Batch Year : " fi_bchyr  SKIP
"Input File Name Load : " fi_filename   SKIP
"    Output Data Load : " fi_output1    SKIP
"Output Data Not Load : " fi_output1    SKIP
"     Batch File Name : " fi_output1    SKIP
" policy Import Total : " fi_usrcnt    "Total Net Premium Imp : " fi_usrprem " BHT." SKIP
SKIP
SKIP
SKIP
"                             Total Record : " fi_impcnt      "   Total Net Premium : " fi_premtot " BHT." SKIP
"Batch No. : " fi_bchno  SKIP
"                           Success Record : " fi_completecnt " Success Net Premium : " fi_premsuc " BHT." .


OUTPUT STREAM ns3 CLOSE.                                                           
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_TempPolicy c-Win 
PROCEDURE proc_TempPolicy :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN
nv_tmppol    = ""
nv_tmppolrun = nv_tmppolrun + 1
nv_tmppol    = nv_batchno + string(nv_tmppolrun, "999") .
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_uwd132 c-Win 
PROCEDURE proc_uwd132 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF BUFFER wf_uwd132 FOR sic_bran.uwd132.
DO:
    FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_recid1 NO-ERROR NO-WAIT.
    FIND sic_bran.uwm130 WHERE RECID(sic_bran.uwm130) = s_recid3 NO-ERROR NO-WAIT.

    ASSIGN nv_bptr = 0.

    FOR EACH bfuwd132 USE-INDEX uwd13290 WHERE bfuwd132.policy = TRIM(wdetail.polmaster) NO-LOCK.
    /*IF AVAIL bfuwd132 THEN DO:*/
        FIND sic_bran.uwd132  USE-INDEX uwd13201 WHERE
             sic_bran.uwd132.policy = sic_bran.uwm100.policy AND
             sic_bran.uwd132.rencnt = sic_bran.uwm100.rencnt AND
             sic_bran.uwd132.endcnt = sic_bran.uwm100.endcnt AND
             sic_bran.uwd132.riskgp = sic_bran.uwm130.riskgp AND
             sic_bran.uwd132.riskno = sic_bran.uwm130.riskno AND
             sic_bran.uwd132.itemno = sic_bran.uwm130.itemno AND
             sic_bran.uwd132.bchyr  = nv_batchyr             AND
             sic_bran.uwd132.bchno  = nv_batchno             AND
             sic_bran.uwd132.bchcnt = nv_batcnt              NO-ERROR NO-WAIT.

        IF NOT AVAILABLE sic_bran.uwd132 THEN DO:
            IF LOCKED sic_bran.uwd132 THEN DO:
                MESSAGE "พบกำลังใช้งาน Insured (UWD132)" wdetail.policy
                    "ไม่สามารถ Generage ข้อมูลได้".
                NEXT.
            END.

            CREATE sic_bran.uwd132.
            ASSIGN fi_process = "Create data to sic_bran.uwd132  ..." + wdetail.policy .
            DISP fi_process WITH FRAM fr_main. 
            ASSIGN
               sic_bran.uwd132.bencod  =  bfuwd132.bencod 
               sic_bran.uwd132.benvar  =  bfuwd132.benvar 
               sic_bran.uwd132.rate    =  bfuwd132.rate                     
               sic_bran.uwd132.gap_ae  =  bfuwd132.gap_ae                   
               sic_bran.uwd132.gap_c   =  bfuwd132.gap_c                    
               sic_bran.uwd132.dl1_c   =  bfuwd132.dl1_c                    
               sic_bran.uwd132.dl2_c   =  bfuwd132.dl2_c                    
               sic_bran.uwd132.dl3_c   =  bfuwd132.dl3_c                    
               sic_bran.uwd132.pd_aep  =  bfuwd132.pd_aep                   
               sic_bran.uwd132.prem_c  =  bfuwd132.prem_c                   
               sic_bran.uwd132.fptr    =  0                   
               sic_bran.uwd132.bptr    =  nv_bptr                   
               sic_bran.uwd132.policy  =  sic_bran.uwm100.policy 
               sic_bran.uwd132.rencnt  =  sic_bran.uwm100.rencnt                    
               sic_bran.uwd132.endcnt  =  sic_bran.uwm100.endcnt                    
               sic_bran.uwd132.riskgp  =  sic_bran.uwm130.riskgp                 
               sic_bran.uwd132.riskno  =  sic_bran.uwm130.riskno                 
               sic_bran.uwd132.itemno  =  sic_bran.uwm130.itemno                 
               sic_bran.uwd132.rateae  =  bfuwd132.rateae                  
               sic_bran.uwd132.bchyr   =  nv_batchyr                   
               sic_bran.uwd132.bchno   =  nv_batchno 
               sic_bran.uwd132.bchcnt  =  nv_batcnt.
            
            IF nv_bptr <> 0 THEN DO:
                FIND wf_uwd132 WHERE RECID(wf_uwd132) = nv_bptr.
                    wf_uwd132.fptr = RECID(sic_bran.uwd132).
            END.
            IF nv_bptr = 0 THEN sic_bran.uwm130.fptr03  =  RECID(sic_bran.uwd132).
            nv_bptr = RECID(sic_bran.uwd132).
        END.
    END.
    sic_bran.uwm130.bptr03  =  nv_bptr. 

    RELEASE sicuw.uwd132.
    RELEASE sic_bran.uwd132.
    RELEASE sic_bran.uwm100.
    RELEASE sic_bran.uwm130.

END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_uwd200 c-Win 
PROCEDURE proc_uwd200 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF BUFFER wf_uwd200 FOR sic_bran.uwd200.
DO:
    FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_recid1 NO-ERROR NO-WAIT.
    FIND sic_bran.uwm120 WHERE RECID(sic_bran.uwm120) = s_recid2 NO-ERROR NO-WAIT.
    FIND sic_bran.uwm200 WHERE RECID(sic_bran.uwm200) = s_recid5 NO-ERROR NO-WAIT.

    ASSIGN nv_bptr = 0.
    FIND bfuwd200 USE-INDEX uwd20001 WHERE 
         bfuwd200.policy = bfuwm200.policy        AND  
         bfuwd200.rico   = sic_bran.uwm200.rico   AND
         bfuwd200.riskgp = sic_bran.uwm120.riskgp and 
         bfuwd200.riskno = sic_bran.uwm120.riskno NO-LOCK.

        FIND sic_bran.uwd200 USE-INDEX uwd20001 WHERE 
             sic_bran.uwd200.policy = sic_bran.uwm120.policy AND
             sic_bran.uwd200.rencnt = sic_bran.uwm120.rencnt AND
             sic_bran.uwd200.endcnt = sic_bran.uwm120.endcnt AND
             sic_bran.uwd200.csftq  = bfuwd200.csftq         AND
             sic_bran.uwd200.rico   = bfuwd200.rico          and  
             sic_bran.uwd200.riskgp = sic_bran.uwm120.riskgp and    
             sic_bran.uwd200.riskno = sic_bran.uwm120.riskno and
             sic_bran.uwd200.bchyr  = sic_bran.uwm120.bchyr  and 
             sic_bran.uwd200.bchno  = sic_bran.uwm120.bchno  and 
             sic_bran.uwd200.bchcnt = sic_bran.uwm120.bchcnt NO-ERROR NO-WAIT .

        IF NOT AVAIL sic_bran.uwd200 THEN DO:

            CREATE sic_bran.uwd200.
            ASSIGN fi_process = "Create data to sic_bran.uwd200  ..." + wdetail.policy .
            DISP fi_process WITH FRAM fr_main.

            ASSIGN 
                sic_bran.uwd200.policy   =  sic_bran.uwm120.policy     
                sic_bran.uwd200.rencnt   =  sic_bran.uwm120.rencnt 
                sic_bran.uwd200.endcnt   =  sic_bran.uwm120.endcnt 
                sic_bran.uwd200.c_enct   =  0  
                sic_bran.uwd200.csftq    =  sic_bran.uwm200.csftq   
                sic_bran.uwd200.rico     =  sic_bran.uwm200.rico    
                sic_bran.uwd200.riskgp   =  sic_bran.uwm120.riskgp  
                sic_bran.uwd200.riskno   =  sic_bran.uwm120.riskno  
                sic_bran.uwd200.risiae   =  bfuwd200.risiae  
                sic_bran.uwd200.risi     =  bfuwd200.risi    
                sic_bran.uwd200.risiid   =  bfuwd200.risiid  
                sic_bran.uwd200.risi_p   =  bfuwd200.risi_p  
                sic_bran.uwd200.ripsae   =  bfuwd200.ripsae  
                sic_bran.uwd200.ripr     =  bfuwd200.ripr    
                sic_bran.uwd200.ric1ae   =  bfuwd200.ric1ae     
                sic_bran.uwd200.ric2ae   =  bfuwd200.ric2ae     
                sic_bran.uwd200.ric1     =  bfuwd200.ric1    
                sic_bran.uwd200.ric2     =  bfuwd200.ric2    
                sic_bran.uwd200.fptr     =  0   
                sic_bran.uwd200.bptr     =  nv_bptr  
                sic_bran.uwd200.sicurr   =  bfuwd200.sicurr  
                sic_bran.uwd200.bchyr    =  sic_bran.uwm120.bchyr                         
                sic_bran.uwd200.bchno    =  sic_bran.uwm120.bchno                          
                sic_bran.uwd200.bchcnt   =  sic_bran.uwm120.bchcnt.
                
                IF nv_bptr <> 0 THEN DO:
                    FIND wf_uwd200 WHERE RECID(wf_uwd200) = nv_bptr.
                    wf_uwd200.fptr = RECID(sic_bran.uwd200).
                END.
                
                IF nv_bptr = 0 THEN sic_bran.uwm200.fptr01 = RECID(sic_bran.uwd200).
                nv_bptr = RECID(sic_bran.uwd200).
        END.
        sic_bran.uwm200.bptr01   =  nv_bptr.

       RELEASE sic_bran.uwd200.
      /* release sic_bran.uwm100.
       release sic_bran.uwm120.
       release sic_bran.uwm200.*/
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_uwm100 c-Win 
PROCEDURE proc_uwm100 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO:
    FIND LAST bfuwm100 USE-INDEX uwm10001 WHERE bfuwm100.policy = trim(wdetail.polmaster) NO-LOCK NO-ERROR.
    IF AVAIL bfuwm100 THEN DO:
        FIND sic_bran.uwm100 USE-INDEX uwm10001 
            WHERE sic_bran.uwm100.policy = trim(wdetail.policy) AND
                  sic_bran.uwm100.rencnt = n_rencnt             AND
                  sic_bran.uwm100.endcnt = n_endcnt             AND
                  sic_bran.uwm100.bchyr  = nv_batchyr           and
                  sic_bran.uwm100.bchno  = nv_batchno           and
                  sic_bran.uwm100.bchcnt = nv_batcnt            NO-ERROR NO-WAIT.

        IF NOT AVAIL sic_bran.uwm100 THEN DO:

            IF trim(wdetail.insnam) <> "" THEN RUN proc_createins.

            CREATE sic_bran.uwm100.
            ASSIGN fi_process = "Create data to sic_bran.uwm100  ..." + wdetail.policy .
            DISP fi_process WITH FRAM fr_main.

            ASSIGN sic_bran.uwm100.policy   = trim(wdetail.policy)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
                   sic_bran.uwm100.rencnt   = n_rencnt   
                   sic_bran.uwm100.renno    = ""       
                   sic_bran.uwm100.endcnt   = n_Endcnt
                   sic_bran.uwm100.bchyr    = nv_batchyr 
                   sic_bran.uwm100.bchno    = nv_batchno 
                   sic_bran.uwm100.bchcnt   = nv_batcnt 
                   sic_bran.uwm100.curbil   = bfuwm100.curbil                          
                   sic_bran.uwm100.curate   = bfuwm100.curate                          
                   sic_bran.uwm100.branch   = TRIM(wdetail.branch)                          
                   sic_bran.uwm100.dir_ri   = bfuwm100.dir_ri                          
                   sic_bran.uwm100.dept     = bfuwm100.dept 
                   sic_bran.uwm100.endno    = ""                           
                   sic_bran.uwm100.cntry    = bfuwm100.cntry                           
                   sic_bran.uwm100.agent    = TRIM(wdetail.agent)                           
                   sic_bran.uwm100.poltyp   = bfuwm100.poltyp                          
                   sic_bran.uwm100.insref   = trim(nv_insref)                         
                   sic_bran.uwm100.opnpol   = bfuwm100.opnpol                          
                   sic_bran.uwm100.prvpol   = bfuwm100.prvpol                          
                   sic_bran.uwm100.ntitle   = trim(wdetail.tiname)                           
                   sic_bran.uwm100.fname    = ""                      
                   sic_bran.uwm100.name1    = trim(wdetail.insnam)                            
                   sic_bran.uwm100.name2    = TRIM(wdetail.name2)                          
                   sic_bran.uwm100.name3    = ""                          
                   sic_bran.uwm100.addr1    = trim(wdetail.n_addr1)                             
                   sic_bran.uwm100.addr2    = trim(wdetail.n_addr2)                             
                   sic_bran.uwm100.addr3    = trim(wdetail.n_addr3)                             
                   sic_bran.uwm100.addr4    = trim(wdetail.n_addr4)                             
                   sic_bran.uwm100.postcd   = ""                          
                   sic_bran.uwm100.occupn   = ""                          
                   sic_bran.uwm100.comdat   = DATE(wdetail.comdat)                          
                   sic_bran.uwm100.expdat   = DATE(wdetail.expdat)                          
                   sic_bran.uwm100.enddat   = TODAY                          
                   sic_bran.uwm100.accdat   = TODAY                          
                   sic_bran.uwm100.trndat   = TODAY                          
                   sic_bran.uwm100.rendat   = ?                          
                   sic_bran.uwm100.terdat   = ?                          
                   sic_bran.uwm100.fstdat   = DATE(wdetail.firstdat)                          
                   sic_bran.uwm100.cn_dat   = ?                          
                   sic_bran.uwm100.cn_no    = bfuwm100.cn_no                           
                   sic_bran.uwm100.tranty   = "N"                          
                   sic_bran.uwm100.undyr    = STRING(YEAR(TODAY),"9999")                           
                   sic_bran.uwm100.acno1    = trim(wdetail.producer)                           
                   sic_bran.uwm100.acno2    = ""                         
                   sic_bran.uwm100.acno3    = ""                         
                   sic_bran.uwm100.instot   = bfuwm100.instot                          
                   sic_bran.uwm100.pstp     = bfuwm100.pstp                            
                   sic_bran.uwm100.pfee     = bfuwm100.pfee                            
                   sic_bran.uwm100.ptax     = bfuwm100.ptax                            
                   sic_bran.uwm100.rstp_t   = bfuwm100.rstp_t                          
                   sic_bran.uwm100.rfee_t   = bfuwm100.rfee_t                          
                   sic_bran.uwm100.rtax_t   = bfuwm100.rtax_t                          
                   sic_bran.uwm100.prem_t   = bfuwm100.prem_t                          
                   sic_bran.uwm100.pdco_t   = bfuwm100.pdco_t                          
                   sic_bran.uwm100.pdst_t   = bfuwm100.pdst_t                          
                   sic_bran.uwm100.pdfa_t   = bfuwm100.pdfa_t                          
                   sic_bran.uwm100.pdty_t   = bfuwm100.pdty_t                          
                   sic_bran.uwm100.pdqs_t   = bfuwm100.pdqs_t                          
                   sic_bran.uwm100.com1_t   = bfuwm100.com1_t                          
                   sic_bran.uwm100.com2_t   = bfuwm100.com2_t                          
                   sic_bran.uwm100.com3_t   = bfuwm100.com3_t                          
                   sic_bran.uwm100.com4_t   = bfuwm100.com4_t                          
                   sic_bran.uwm100.coco_t   = bfuwm100.coco_t                          
                   sic_bran.uwm100.cost_t   = bfuwm100.cost_t                          
                   sic_bran.uwm100.cofa_t   = bfuwm100.cofa_t                          
                   sic_bran.uwm100.coty_t   = bfuwm100.coty_t                          
                   sic_bran.uwm100.coqs_t   = bfuwm100.coqs_t                          
                   sic_bran.uwm100.reduc1   = bfuwm100.reduc1                          
                   sic_bran.uwm100.reduc2   = bfuwm100.reduc2                          
                   sic_bran.uwm100.reduc3   = bfuwm100.reduc3                          
                   sic_bran.uwm100.gap_p    = bfuwm100.gap_p                           
                   sic_bran.uwm100.dl1_p    = bfuwm100.dl1_p                           
                   sic_bran.uwm100.dl2_p    = bfuwm100.dl2_p                           
                   sic_bran.uwm100.dl3_p    = bfuwm100.dl3_p                           
                   sic_bran.uwm100.dl2red   = bfuwm100.dl2red                          
                   sic_bran.uwm100.dl3red   = bfuwm100.dl3red                          
                   sic_bran.uwm100.dl1sch   = bfuwm100.dl1sch                          
                   sic_bran.uwm100.dl2sch   = bfuwm100.dl2sch                          
                   sic_bran.uwm100.dl3sch   = bfuwm100.dl3sch                          
                   sic_bran.uwm100.drnoae   = bfuwm100.drnoae                          
                   sic_bran.uwm100.insddr   = bfuwm100.insddr                          
                   sic_bran.uwm100.trty11   = "M"                         
                   sic_bran.uwm100.trty12   = bfuwm100.trty12                          
                   sic_bran.uwm100.trty13   = bfuwm100.trty13                          
                   sic_bran.uwm100.docno1   = ""                          
                   sic_bran.uwm100.docno2   = ""                      
                   sic_bran.uwm100.docno3   = ""                      
                   sic_bran.uwm100.no_sch   = bfuwm100.no_sch /*0*/                          
                   sic_bran.uwm100.no_dr    = bfuwm100.no_dr  /*1*/                           
                   sic_bran.uwm100.no_ri    = bfuwm100.no_ri                           
                   sic_bran.uwm100.no_cer   = bfuwm100.no_cer                          
                   sic_bran.uwm100.li_sch   = bfuwm100.li_sch                          
                   sic_bran.uwm100.li_dr    = bfuwm100.li_dr                           
                   sic_bran.uwm100.li_ri    = bfuwm100.li_ri                           
                   sic_bran.uwm100.li_cer   = bfuwm100.li_cer                          
                   sic_bran.uwm100.scform   = bfuwm100.scform                          
                   sic_bran.uwm100.enform   = bfuwm100.enform                          
                   sic_bran.uwm100.apptax   = bfuwm100.apptax                          
                   sic_bran.uwm100.dl1cod   = bfuwm100.dl1cod                          
                   sic_bran.uwm100.dl2cod   = bfuwm100.dl2cod                          
                   sic_bran.uwm100.dl3cod   = bfuwm100.dl3cod                          
                   sic_bran.uwm100.styp20   = bfuwm100.styp20                          
                   sic_bran.uwm100.sval20   = bfuwm100.sval20                          
                   sic_bran.uwm100.finint   = ""                         
                   sic_bran.uwm100.cedco    = bfuwm100.cedco                           
                   sic_bran.uwm100.cedsi    = bfuwm100.cedsi                           
                   sic_bran.uwm100.cedpol   = trim(wdetail.number)                          
                   sic_bran.uwm100.cedces   = bfuwm100.cedces                          
                   sic_bran.uwm100.recip    = bfuwm100.recip                           
                   sic_bran.uwm100.short    = bfuwm100.short                           
                   sic_bran.uwm100.receit   = bfuwm100.receit                          
                   sic_bran.uwm100.fptr01   = 0  /*bfuwm100.fptr01*/                          
                   sic_bran.uwm100.bptr01   = 0  /*bfuwm100.bptr01*/                          
                   sic_bran.uwm100.fptr02   = 0  /*bfuwm100.fptr02*/                          
                   sic_bran.uwm100.bptr02   = 0  /*bfuwm100.bptr02*/                          
                   sic_bran.uwm100.fptr03   = 0  /*bfuwm100.fptr03*/                          
                   sic_bran.uwm100.bptr03   = 0  /*bfuwm100.bptr03*/                          
                   sic_bran.uwm100.fptr04   = 0  /*bfuwm100.fptr04*/                          
                   sic_bran.uwm100.bptr04   = 0  /*bfuwm100.bptr04*/                          
                   sic_bran.uwm100.fptr05   = 0  /*bfuwm100.fptr05*/                          
                   sic_bran.uwm100.bptr05   = 0  /*bfuwm100.bptr05*/                          
                   sic_bran.uwm100.fptr06   = 0  /*bfuwm100.fptr06*/                          
                   sic_bran.uwm100.bptr06   = 0  /*bfuwm100.bptr06*/                          
                   sic_bran.uwm100.coins    = bfuwm100.coins                           
                   sic_bran.uwm100.billco   = bfuwm100.billco                          
                   sic_bran.uwm100.pmhead   = bfuwm100.pmhead                          
                   sic_bran.uwm100.usrid    = USERID(LDBNAME(1))                          
                   sic_bran.uwm100.entdat   = TODAY                          
                   sic_bran.uwm100.enttim   = STRING(TIME,"HH:MM:SS")                          
                   sic_bran.uwm100.prog     = "WGWGEN60"                           
                   sic_bran.uwm100.usridr   = bfuwm100.usridr                          
                   sic_bran.uwm100.reldat   = ?                          
                   sic_bran.uwm100.reltim   = ""                          
                   sic_bran.uwm100.polsta   = IF wdetail.cancel = "CA" THEN "CA" ELSE "IF"                        
                   sic_bran.uwm100.rilate   = bfuwm100.rilate                          
                   sic_bran.uwm100.releas   = NO                          
                   sic_bran.uwm100.sch_p    = NO                         
                   sic_bran.uwm100.drn_p    = NO                       
                   sic_bran.uwm100.ri_p     = bfuwm100.ri_p                            
                   sic_bran.uwm100.cert_p   = bfuwm100.cert_p                          
                   sic_bran.uwm100.dreg_p   = bfuwm100.dreg_p                          
                   sic_bran.uwm100.langug   = bfuwm100.langug                          
                   sic_bran.uwm100.sigr_p   = DECI(wdetail.si)                          
                   sic_bran.uwm100.sico_p   = bfuwm100.sico_p                          
                   sic_bran.uwm100.sist_p   = bfuwm100.sist_p                         
                   sic_bran.uwm100.sifa_p   = bfuwm100.sifa_p                        
                   sic_bran.uwm100.sity_p   = bfuwm100.sity_p                        
                   sic_bran.uwm100.siqs_p   = bfuwm100.siqs_p                        
                   sic_bran.uwm100.renpol   = ""                          
                   sic_bran.uwm100.co_per   = bfuwm100.co_per                          
                   sic_bran.uwm100.acctim   = bfuwm100.acctim                          
                   sic_bran.uwm100.agtref   = bfuwm100.agtref                          
                   sic_bran.uwm100.sckno    = bfuwm100.sckno                           
                   sic_bran.uwm100.anam1    = bfuwm100.anam1                           
                   sic_bran.uwm100.sirt_p   = bfuwm100.sirt_p                          
                   sic_bran.uwm100.anam2    = trim(wdetail.nv_icno)                           
                   sic_bran.uwm100.gstrat   = bfuwm100.gstrat                          
                   sic_bran.uwm100.prem_g   = bfuwm100.prem_g                          
                   sic_bran.uwm100.com1_g   = bfuwm100.com1_g                          
                   sic_bran.uwm100.com3_g   = bfuwm100.com3_g                          
                   sic_bran.uwm100.com4_g   = bfuwm100.com4_g                          
                   sic_bran.uwm100.gstae    = bfuwm100.gstae                           
                   sic_bran.uwm100.nr_pol   = bfuwm100.nr_pol                          
                   sic_bran.uwm100.issdat   = TODAY                          
                   sic_bran.uwm100.cr_1     = bfuwm100.cr_1                            
                   sic_bran.uwm100.cr_2     = bfuwm100.cr_2                            
                   sic_bran.uwm100.cr_3     = bfuwm100.cr_3                            
                   sic_bran.uwm100.bs_cd    = TRIM(wdetail.vatcode)                           
                   sic_bran.uwm100.rt_er    = bfuwm100.rt_er                           
                   sic_bran.uwm100.endern   = bfuwm100.endern                          
                   sic_bran.uwm100.impusrid = "" /*bfuwm100.impusrid*/                        
                   sic_bran.uwm100.impdat   = ?  /*bfuwm100.impdat  */                        
                   sic_bran.uwm100.imptim   = "" /*bfuwm100.imptim  */                        
                   sic_bran.uwm100.imperr   = "" /*bfuwm100.imperr  */                        
                   sic_bran.uwm100.impflg   = IF wdetail.pass = "Y" THEN YES ELSE NO                        
                   sic_bran.uwm100.revflg   = NO /*bfuwm100.revflg  */                        
                   sic_bran.uwm100.revtxt   = "" /*bfuwm100.revtxt  */                        
                   sic_bran.uwm100.trfusrid = "" /*bfuwm100.trfusrid*/                        
                   sic_bran.uwm100.trfdat   = ? /*bfuwm100.trfdat  */                        
                   sic_bran.uwm100.trftim   = "" /*bfuwm100.trftim  */                        
                   sic_bran.uwm100.trferr   = "" /*bfuwm100.trferr  */                        
                   sic_bran.uwm100.trfflg   = NO  /*bfuwm100.trfflg  */ 
                   s_recid1                 = RECID(sic_bran.uwm100) .
        END.
        RELEASE sic_bran.uwm100.
        RUN proc_uwm120.
        RUN proc_uwm307.
        RUN proc_uwm130.
        RUN proc_uwd132.
        RUN proc_uwm200.
        RUN proc_uwm100_text.
        RUN proc_uwm120_text.
        RUN proc_uwm200_text.
    END.
    RELEASE sicuw.uwm100.
    RELEASE sic_bran.uwm100.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_uwm100_text c-Win 
PROCEDURE proc_uwm100_text :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF BUFFER wf_uwd100 FOR sic_bran.uwd100.
DEF BUFFER wf_uwd102 FOR sic_bran.uwd102.
DEF BUFFER wf_uwd105 FOR sic_bran.uwd105.
DEF BUFFER bfuwd100  FOR sicuw.uwd100.
DEF BUFFER bfuwd102  FOR sicuw.uwd102.
DEF BUFFER bfuwd105  FOR sicuw.uwd105.
DEF VAR nv_line1 AS INT INIT 0.
DEF VAR nv_txt1  as char format "x(50)" init "".
def var nv_txt2  as char format "x(50)" init "".
def var nv_txt3  as char format "x(50)" init "".
def var nv_txt4  as char format "x(50)" init "".

DO:
    FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_recid1 NO-ERROR NO-WAIT.
    /*-----------uwd100 Policy UPPER Text -----------------*/
        IF bfuwm100.fptr01 <> ? AND bfuwm100.fptr01 <> 0 THEN DO:
           /* ADD NEW DATA */
            nv_fptr = bfuwm100.fptr01.
            nv_bptr = 0.
            DO WHILE nv_fptr <> 0 AND nv_fptr <> ? :
        
              FIND bfuwd100 WHERE RECID(bfuwd100) = nv_fptr NO-LOCK NO-ERROR.
              IF AVAILABLE bfuwd100 THEN DO:
                 nv_fptr = bfuwd100.fptr.
     
                 CREATE sic_bran.uwd100.
                 ASSIGN sic_bran.uwd100.policy  = sic_bran.uwm100.Policy 
                        sic_bran.uwd100.rencnt  = sic_bran.uwm100.rencnt
                        sic_bran.uwd100.endcnt  = sic_bran.uwm100.endcnt
                        sic_bran.uwd100.ltext   = bfuwd100.ltext
                        sic_bran.uwd100.fptr    = 0
                        sic_bran.uwd100.bptr    = nv_bptr.
                 
                 IF nv_bptr <> 0 THEN DO:
                    FIND wf_uwd100 WHERE RECID(wf_uwd100) = nv_bptr NO-ERROR.
                    wf_uwd100.fptr = RECID(sic_bran.uwd100).
                 END.
                 
                 IF nv_bptr = 0 THEN  sic_bran.uwm100.fptr01 = RECID(sic_bran.uwd100).
                 
                 nv_bptr = RECID(sic_bran.uwd100).
              END. /*IF AVAILABLE sic_Bran.uwd100 THEN DO:*/
            END.  /*DO WHILE nv_fptr <> 0 AND nv_fptr <> ? :*/
            sic_bran.uwm100.bptr01 = nv_bptr. 
        END.
        
        /*----------------------- uwd102 Policy Memo -----------------------*/
        IF bfuwm100.fptr02 <> ? AND bfuwm100.fptr02 <> 0 THEN DO:
        /* ADD NEW DATA */
            nv_fptr = bfuwm100.fptr02.
            nv_bptr = 0.
            
            DO WHILE nv_fptr <> 0 AND nv_fptr <> ? :
              FIND bfuwd102 WHERE RECID(bfuwd102) = nv_fptr NO-LOCK NO-ERROR.
              IF AVAILABLE bfuwd102 THEN DO:
                 nv_fptr = bfuwd102.fptr.
                 CREATE sic_bran.uwd102.
                 ASSIGN sic_bran.uwd102.policy  = sic_bran.uwm100.Policy 
                        sic_bran.uwd102.rencnt  = sic_bran.uwm100.rencnt
                        sic_bran.uwd102.endcnt  = sic_bran.uwm100.endcnt
                        sic_bran.uwd102.ltext   = bfuwd102.ltext
                        sic_bran.uwd102.fptr    = 0
                        sic_bran.uwd102.bptr    = nv_bptr.
                 
                 IF nv_bptr <> 0 THEN DO:
                    FIND wf_uwd102 WHERE RECID(wf_uwd102) = nv_bptr NO-ERROR.
                    wf_uwd102.fptr = RECID(sic_bran.uwd102).
                 END.
                 
                 IF nv_bptr = 0 THEN  sic_bran.uwm100.fptr02 = RECID(sic_bran.uwd102).
                 
                 nv_bptr = RECID(sic_bran.uwd102).
              END. /*IF AVAILABLE sic_Bran.uwd100 THEN DO:*/
            END.  /*DO WHILE nv_fptr <> 0 AND nv_fptr <> ? :*/
            sic_bran.uwm100.bptr02 = nv_bptr.            
        END.
        /*----------- Memo จากไฟล์ -----------*/
        IF wdetail.mail <> "" OR wdetail.notidate <> ""  THEN DO:

            FOR EACH wuppertxt.
                DELETE wuppertxt.
            END.
            ASSIGN 
                nv_bptr  = 0        nv_fptr  = 0
                nv_line1 = 1        nv_txt1  = ""  
                nv_txt2  = ""       nv_txt3  = "" 
                nv_txt4  = "" 
                nv_txt1  = "Mail : " + trim(wdetail.mail) 
                nv_txt2  = "วันที่ส่งข้อมูล : " + wdetail.notidate + " เบอร์โทร : " + trim(wdetail.phone) 
                           + " / " + trim(wdetail.mobile) .
            DO WHILE nv_line1 <= 8:
                CREATE wuppertxt.
                wuppertxt.line = nv_line1.
                IF nv_line1 = 1  THEN wuppertxt.txt = nv_txt1.
                IF nv_line1 = 2  THEN wuppertxt.txt = nv_txt2.
                nv_line1 = nv_line1 + 1.
            END.

            IF sic_bran.uwm100.fptr02 <> ? AND sic_bran.uwm100.fptr02 <> 0 THEN DO:
                nv_fptr = sic_bran.uwm100.fptr02.
                nv_bptr = sic_bran.uwm100.bptr02.
            END.
            ELSE DO:
                nv_fptr = 0.
                nv_bptr = 0.
            END.
            
            FIND sic_bran.uwd102 WHERE RECID(sic_bran.uwd102) = nv_fptr NO-LOCK NO-ERROR.
            IF AVAILABLE sic_bran.uwd102 THEN DO:
                nv_fptr = sic_bran.uwd102.fptr.
                FOR EACH wuppertxt BREAK BY wuppertxt.LINE :
                  CREATE sic_bran.uwd102.
                  ASSIGN 
                    sic_bran.uwd102.policy  = sic_bran.uwm100.Policy 
                    sic_bran.uwd102.rencnt  = sic_bran.uwm100.rencnt
                    sic_bran.uwd102.endcnt  = sic_bran.uwm100.endcnt
                    sic_bran.uwd102.ltext   = wuppertxt.txt
                    sic_bran.uwd102.fptr    = 0 
                    sic_bran.uwd100.bptr    = nv_bptr.
                    
                    IF nv_bptr <> 0 THEN DO:
                       FIND wf_uwd102 WHERE RECID(wf_uwd102) = nv_bptr NO-ERROR.
                       wf_uwd102.fptr = RECID(sic_bran.uwd102).
                    END.
                    
                    IF nv_bptr = 0 THEN  sic_bran.uwm100.fptr02 = RECID(sic_bran.uwd102).
                    nv_bptr = RECID(sic_bran.uwd102).
                END.
                sic_bran.uwm100.bptr02 = nv_bptr.
            END.
            ELSE DO:
                FOR EACH wuppertxt BREAK BY wuppertxt.LINE :
                  CREATE sic_bran.uwd102.
                  ASSIGN 
                    sic_bran.uwd102.policy  = sic_bran.uwm100.Policy 
                    sic_bran.uwd102.rencnt  = sic_bran.uwm100.rencnt
                    sic_bran.uwd102.endcnt  = sic_bran.uwm100.endcnt
                    sic_bran.uwd102.ltext   = wuppertxt.txt
                    sic_bran.uwd102.fptr    = 0 
                    sic_bran.uwd100.bptr    = nv_bptr.
                    
                    IF nv_bptr <> 0 THEN DO:
                       FIND wf_uwd102 WHERE RECID(wf_uwd102) = nv_bptr NO-ERROR.
                       wf_uwd102.fptr = RECID(sic_bran.uwd102).
                    END.
                    
                    IF nv_bptr = 0 THEN  sic_bran.uwm100.fptr02 = RECID(sic_bran.uwd102).
                    nv_bptr = RECID(sic_bran.uwd102).
                END.
                sic_bran.uwm100.bptr02 = nv_bptr.
            END.
        END.
        /*---------------- end uwd102 ----------------------*/
        /*----------------------- uwd105 Policy Clause -----------------------*/
        IF bfuwm100.fptr03 <> ? AND bfuwm100.fptr03 <> 0 THEN DO:
        /* ADD NEW DATA */
            nv_fptr = bfuwm100.fptr03.
            nv_bptr = 0.
            
            DO WHILE nv_fptr <> 0 AND nv_fptr <> ? :
              FIND bfuwd105 WHERE RECID(bfuwd105) = nv_fptr NO-LOCK NO-ERROR.
              IF AVAILABLE bfuwd105 THEN DO:
                 nv_fptr = bfuwd105.fptr.
                 
                 CREATE sic_bran.uwd105.
                 ASSIGN sic_bran.uwd105.policy  = sic_bran.uwm100.Policy 
                        sic_bran.uwd105.rencnt  = sic_bran.uwm100.rencnt
                        sic_bran.uwd105.endcnt  = sic_bran.uwm100.endcnt
                        sic_bran.uwd105.clause  = bfuwd105.clause
                        sic_bran.uwd105.fptr    = 0
                        sic_bran.uwd105.bptr    = nv_bptr.
                 
                 IF nv_bptr <> 0 THEN DO:
                    FIND wf_uwd105 WHERE RECID(wf_uwd105) = nv_bptr NO-ERROR.
                    wf_uwd105.fptr = RECID(sic_bran.uwd105).
                 END.
                 
                 IF nv_bptr = 0 THEN  sic_bran.uwm100.fptr03 = RECID(sic_bran.uwd105).
                 
                 nv_bptr = RECID(sic_bran.uwd105).
              END. /*IF AVAILABLE sic_Bran.uwd100 THEN DO:*/
            END.  /*DO WHILE nv_fptr <> 0 AND nv_fptr <> ? :*/
            sic_bran.uwm100.bptr03 = nv_bptr.            
        END.

        RELEASE sic_bran.uwd100.
        RELEASE sic_bran.uwd102.
        RELEASE sic_bran.uwd105.
        release sicuw.uwd100.  
        release sicuw.uwd102.  
        release sicuw.uwd105. 
END.                
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_uwm120 c-Win 
PROCEDURE proc_uwm120 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO:
    FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_recid1 NO-ERROR NO-WAIT.
    FOR EACH bfuwm120 USE-INDEX uwm12001 WHERE bfuwm120.policy = TRIM(wdetail.polmaster) NO-LOCK.
        FIND sic_bran.uwm120 USE-INDEX uwm12001
             WHERE sic_bran.uwm120.policy = sic_bran.uwm100.policy AND
                   sic_bran.uwm120.rencnt = sic_bran.uwm100.rencnt AND
                   sic_bran.uwm120.endcnt = sic_bran.uwm100.endcnt AND
                   sic_bran.uwm120.riskgp = bfuwm120.riskgp        and
                   sic_bran.uwm120.riskno = bfuwm120.riskno        and
                   sic_bran.uwm120.bchyr  = sic_bran.uwm100.bchyr  and 
                   sic_bran.uwm120.bchno  = sic_bran.uwm100.bchno  and 
                   sic_bran.uwm120.bchcnt = sic_bran.uwm100.bchcnt NO-ERROR NO-WAIT .
        IF NOT AVAIL  sic_bran.uwm120 THEN DO:

            CREATE sic_bran.uwm120.
            ASSIGN fi_process = "Create data to sic_bran.uwm120  ..." + wdetail.policy .
            DISP fi_process WITH FRAM fr_main.
            
            ASSIGN 
                sic_bran.uwm120.policy    =  sic_bran.uwm100.policy                      
                sic_bran.uwm120.rencnt    =  sic_bran.uwm100.rencnt           
                sic_bran.uwm120.endcnt    =  sic_bran.uwm100.endcnt                 
                sic_bran.uwm120.riskgp    =  bfuwm120.riskgp                        
                sic_bran.uwm120.riskno    =  bfuwm120.riskno                        
                sic_bran.uwm120.fptr01    =  0  /*bfuwm120.fptr01*/    /*  First uwd120 Risk Uppe     */                      
                sic_bran.uwm120.bptr01    =  0  /*bfuwm120.bptr01*/    /*  Last  uwd120 Risk Uppe     */                      
                sic_bran.uwm120.fptr02    =  0  /*bfuwm120.fptr02*/    /*  First uwd121 Risk Lowe ?   */                      
                sic_bran.uwm120.bptr02    =  0  /*bfuwm120.bptr02*/    /*  Last  uwd121 Risk Lowe ?   */                      
                sic_bran.uwm120.fptr03    =  0  /*bfuwm120.fptr03*/    /*  First uwd123 Borderau  ?   */                      
                sic_bran.uwm120.bptr03    =  0  /*bfuwm120.bptr03*/    /*  Last  uwd123 Borderau  ?   */                      
                sic_bran.uwm120.fptr04    =  0  /*bfuwm120.fptr04*/    /*  First uwd125 Risk Clau ?   */                      
                sic_bran.uwm120.bptr04    =  0  /*bfuwm120.bptr04*/    /*  Last  uwd125 Risk Clau ?   */                      
                sic_bran.uwm120.fptr08    =  0  /*bfuwm120.fptr08*/    /*  First uwd124 Risk Endt ?   */                      
                sic_bran.uwm120.bptr08    =  0  /*bfuwm120.bptr08*/    /*  Last uwd124 Risk Endt. ?   */                      
                sic_bran.uwm120.fptr09    =  0  /*bfuwm120.fptr09*/    /*  First uwd126 Risk Endt ?   */                      
                sic_bran.uwm120.bptr09    =  0  /*bfuwm120.bptr09*/    /*  Last uwd126 Risk Endt. ?   */                      
                sic_bran.uwm120.class     =  bfuwm120.class                         
                sic_bran.uwm120.sicurr    =  bfuwm120.sicurr                        
                sic_bran.uwm120.siexch    =  bfuwm120.siexch                        
                sic_bran.uwm120.r_text    =  bfuwm120.r_text                        
                sic_bran.uwm120.rskdel    =  bfuwm120.rskdel                        
                sic_bran.uwm120.styp20    =  bfuwm120.styp20                        
                sic_bran.uwm120.sval20    =  bfuwm120.sval20                        
                sic_bran.uwm120.gap_r     =  bfuwm120.gap_r                         
                sic_bran.uwm120.dl1_r     =  bfuwm120.dl1_r                         
                sic_bran.uwm120.dl2_r     =  bfuwm120.dl2_r                         
                sic_bran.uwm120.dl3_r     =  bfuwm120.dl3_r                         
                sic_bran.uwm120.rstp_r    =  bfuwm120.rstp_r                        
                sic_bran.uwm120.rfee_r    =  bfuwm120.rfee_r                        
                sic_bran.uwm120.rtax_r    =  bfuwm120.rtax_r                        
                sic_bran.uwm120.prem_r    =  bfuwm120.prem_r                        
                sic_bran.uwm120.com1_r    =  bfuwm120.com1_r                        
                sic_bran.uwm120.com2_r    =  bfuwm120.com2_r                        
                sic_bran.uwm120.com3_r    =  bfuwm120.com3_r                        
                sic_bran.uwm120.com4_r    =  bfuwm120.com4_r                        
                sic_bran.uwm120.com1p     =  bfuwm120.com1p                         
                sic_bran.uwm120.com2p     =  bfuwm120.com2p                         
                sic_bran.uwm120.com3p     =  bfuwm120.com3p                         
                sic_bran.uwm120.com4p     =  bfuwm120.com4p                         
                sic_bran.uwm120.com1ae    =  bfuwm120.com1ae                        
                sic_bran.uwm120.com2ae    =  bfuwm120.com2ae                        
                sic_bran.uwm120.com3ae    =  bfuwm120.com3ae                        
                sic_bran.uwm120.com4ae    =  bfuwm120.com4ae                        
                sic_bran.uwm120.rilate    =  bfuwm120.rilate                        
                sic_bran.uwm120.sigr      =  bfuwm120.sigr                          
                sic_bran.uwm120.sico      =  bfuwm120.sico                          
                sic_bran.uwm120.sist      =  bfuwm120.sist                          
                sic_bran.uwm120.sifac     =  bfuwm120.sifac                         
                sic_bran.uwm120.sitty     =  bfuwm120.sitty                         
                sic_bran.uwm120.siqs      =  bfuwm120.siqs                          
                sic_bran.uwm120.pdco      =  bfuwm120.pdco                          
                sic_bran.uwm120.pdst      =  bfuwm120.pdst                       
                sic_bran.uwm120.pdfac     =  bfuwm120.pdfac                      
                sic_bran.uwm120.pdtty     =  bfuwm120.pdtty                      
                sic_bran.uwm120.pdqs      =  bfuwm120.pdqs                          
                sic_bran.uwm120.comco     =  bfuwm120.comco                         
                sic_bran.uwm120.comst     =  bfuwm120.comst                       
                sic_bran.uwm120.comfac    =  bfuwm120.comfac                      
                sic_bran.uwm120.comtty    =  bfuwm120.comtty                      
                sic_bran.uwm120.comqs     =  bfuwm120.comqs                         
                sic_bran.uwm120.stmpae    =  bfuwm120.stmpae                        
                sic_bran.uwm120.feeae     =  bfuwm120.feeae                         
                sic_bran.uwm120.taxae     =  bfuwm120.taxae                         
                sic_bran.uwm120.siret     =  bfuwm120.siret                         
                sic_bran.uwm120.premr_ae  =  bfuwm120.premr_ae                      
                sic_bran.uwm120.bchyr     =  sic_bran.uwm100.bchyr                         
                sic_bran.uwm120.bchno     =  sic_bran.uwm100.bchno                          
                sic_bran.uwm120.bchcnt    =  sic_bran.uwm100.bchcnt     
                s_recid2                  = RECID(sic_bran.uwm120) .
        END.
    END.
    RELEASE sic_bran.uwm120.
    RELEASE sicuw.uwm120.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_uwm120_text c-Win 
PROCEDURE proc_uwm120_text :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF BUFFER wf_uwd120 FOR sic_bran.uwd120.
DEF BUFFER wf_uwd121 FOR sic_bran.uwd121.
DEF BUFFER wf_uwd123 FOR sic_bran.uwd123.
DEF BUFFER wf_uwd125 FOR sic_bran.uwd125.
DEF BUFFER bfuwd120  FOR sicuw.uwd120.
DEF BUFFER bfuwd121  FOR sicuw.uwd121.
DEF BUFFER bfuwd123  FOR sicuw.uwd123.
DEF BUFFER bfuwd125  FOR sicuw.uwd125.
DO:
    FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_recid1 NO-ERROR NO-WAIT.
    FIND sic_bran.uwm120 WHERE RECID(sic_bran.uwm120) = s_recid2 NO-ERROR NO-WAIT.

    FOR EACH bfuwm120 WHERE bfuwm120.policy = TRIM(wdetail.polmaster) NO-LOCK.
        /*-----------uwd120 Risk UPPER Text -----------------*/
        IF bfuwm120.fptr01 <> ? AND bfuwm120.fptr01 <> 0 THEN DO:
           /* ADD NEW DATA */
            nv_fptr = bfuwm120.fptr01.
            nv_bptr = 0.

            DO WHILE nv_fptr <> 0 AND nv_fptr <> ? :
        
              FIND bfuwd120 WHERE RECID(bfuwd120) = nv_fptr NO-LOCK NO-ERROR.
              IF AVAILABLE bfuwd120 THEN DO:
                 nv_fptr = bfuwd120.fptr.
     
                 CREATE sic_bran.uwd120.
                 ASSIGN sic_bran.uwd120.policy  = sic_bran.uwm120.Policy 
                        sic_bran.uwd120.rencnt  = sic_bran.uwm120.rencnt
                        sic_bran.uwd120.endcnt  = sic_bran.uwm120.endcnt
                        sic_bran.uwd120.riskgp  = sic_bran.uwm120.riskgp
                        sic_bran.uwd120.riskno  = sic_bran.uwm120.riskno
                        sic_bran.uwd120.ltext   = bfuwd120.ltext
                        sic_bran.uwd120.fptr    = 0
                        sic_bran.uwd120.bptr    = nv_bptr.
                 
                 IF nv_bptr <> 0 THEN DO:
                    FIND wf_uwd120 WHERE RECID(wf_uwd120) = nv_bptr NO-ERROR.
                    wf_uwd120.fptr = RECID(sic_bran.uwd120).
                 END.
                 
                 IF nv_bptr = 0 THEN  sic_bran.uwm120.fptr01 = RECID(sic_bran.uwd120).
                 
                 nv_bptr = RECID(sic_bran.uwd120).
              END. /*IF AVAILABLE sic_Bran.uwd100 THEN DO:*/
            END.  /*DO WHILE nv_fptr <> 0 AND nv_fptr <> ? :*/
            sic_bran.uwm120.bptr01 = nv_bptr. 
        END.
        
        /*----------------------- uwd121 Risk Lower -----------------------*/
        IF bfuwm120.fptr02 <> ? AND bfuwm120.fptr02 <> 0 THEN DO:
        /* ADD NEW DATA */
            nv_fptr = bfuwm120.fptr02.
            nv_bptr = 0.
            
            DO WHILE nv_fptr <> 0 AND nv_fptr <> ? :
              FIND bfuwd121 WHERE RECID(bfuwd121) = nv_fptr NO-LOCK NO-ERROR.
              IF AVAILABLE bfuwd121 THEN DO:
                 nv_fptr = bfuwd121.fptr.
                 
                 CREATE sic_bran.uwd121.
                 ASSIGN sic_bran.uwd121.policy  = sic_bran.uwm120.Policy 
                        sic_bran.uwd121.rencnt  = sic_bran.uwm120.rencnt
                        sic_bran.uwd121.endcnt  = sic_bran.uwm120.endcnt
                        sic_bran.uwd121.riskgp  = sic_bran.uwm120.riskgp
                        sic_bran.uwd121.riskno  = sic_bran.uwm120.riskno
                        sic_bran.uwd121.ltext   = bfuwd121.ltext
                        sic_bran.uwd121.fptr    = 0
                        sic_bran.uwd121.bptr    = nv_bptr.
                 
                 IF nv_bptr <> 0 THEN DO:
                    FIND wf_uwd121 WHERE RECID(wf_uwd121) = nv_bptr NO-ERROR.
                    wf_uwd121.fptr = RECID(sic_bran.uwd121).
                 END.
                 
                 IF nv_bptr = 0 THEN  sic_bran.uwm120.fptr02 = RECID(sic_bran.uwd121).
                 
                 nv_bptr = RECID(sic_bran.uwd121).
              END. /*IF AVAILABLE sic_Bran.uwd100 THEN DO:*/
            END.  /*DO WHILE nv_fptr <> 0 AND nv_fptr <> ? :*/
            sic_bran.uwm120.bptr02 = nv_bptr. 
        END.
        
        /*----------------------- uwd123 Borderau-----------------------*/
        IF bfuwm120.fptr03 <> ? AND bfuwm120.fptr03 <> 0 THEN DO:
        /* ADD NEW DATA */
            nv_fptr = bfuwm120.fptr03.
            nv_bptr = 0.
            
            DO WHILE nv_fptr <> 0 AND nv_fptr <> ? :
              FIND bfuwd123 WHERE RECID(bfuwd123) = nv_fptr NO-LOCK NO-ERROR.
              IF AVAILABLE bfuwd123 THEN DO:
                 nv_fptr = bfuwd123.fptr.
                 
                 CREATE sic_bran.uwd123.
                 ASSIGN sic_bran.uwd123.policy  = sic_bran.uwm120.Policy 
                        sic_bran.uwd123.rencnt  = sic_bran.uwm120.rencnt
                        sic_bran.uwd123.endcnt  = sic_bran.uwm120.endcnt
                        sic_bran.uwd123.riskgp  = sic_bran.uwm120.riskgp
                        sic_bran.uwd123.riskno  = sic_bran.uwm120.riskno
                        sic_bran.uwd123.ltext   = bfuwd123.ltext
                        sic_bran.uwd123.fptr    = 0
                        sic_bran.uwd123.bptr    = nv_bptr.
                 
                 IF nv_bptr <> 0 THEN DO:
                    FIND wf_uwd123 WHERE RECID(wf_uwd123) = nv_bptr NO-ERROR.
                    wf_uwd123.fptr = RECID(sic_bran.uwd123).
                 END.
                 
                 IF nv_bptr = 0 THEN  sic_bran.uwm120.fptr03 = RECID(sic_bran.uwd123).
                 
                 nv_bptr = RECID(sic_bran.uwd123).
              END. /*IF AVAILABLE sic_Bran.uwd100 THEN DO:*/
            END.  /*DO WHILE nv_fptr <> 0 AND nv_fptr <> ? :*/
            sic_bran.uwm120.bptr03 = nv_bptr. 
            
        END.
        
        /*----------------------- uwd125 clause -----------------------*/
        IF bfuwm120.fptr04 <> ? AND bfuwm120.fptr04 <> 0 THEN DO:
        /* ADD NEW DATA */
            nv_fptr = bfuwm120.fptr04.
            nv_bptr = 0.
            
            DO WHILE nv_fptr <> 0 AND nv_fptr <> ? :
              FIND bfuwd125 WHERE RECID(bfuwd125) = nv_fptr NO-LOCK NO-ERROR.
              IF AVAILABLE bfuwd125 THEN DO:
                 nv_fptr = bfuwd125.fptr.
                 
                 CREATE sic_bran.uwd125.
                 ASSIGN sic_bran.uwd125.policy  = sic_bran.uwm100.Policy 
                        sic_bran.uwd125.rencnt  = sic_bran.uwm100.rencnt
                        sic_bran.uwd125.endcnt  = sic_bran.uwm100.endcnt
                        sic_bran.uwd125.clause  = bfuwd125.clause
                        sic_bran.uwd125.fptr    = 0
                        sic_bran.uwd125.bptr    = nv_bptr.
                 
                 IF nv_bptr <> 0 THEN DO:
                    FIND wf_uwd125 WHERE RECID(wf_uwd125) = nv_bptr NO-ERROR.
                    wf_uwd125.fptr = RECID(sic_bran.uwd125).
                 END.
                 
                 IF nv_bptr = 0 THEN  sic_bran.uwm120.fptr04 = RECID(sic_bran.uwd125).
                 
                 nv_bptr = RECID(sic_bran.uwd125).
              END. /*IF AVAILABLE sic_Bran.uwd100 THEN DO:*/
            END.  /*DO WHILE nv_fptr <> 0 AND nv_fptr <> ? :*/
            sic_bran.uwm120.bptr04 = nv_bptr. 
            
        END.
        
    END.
    RELEASE sicuw.uwd120.
    RELEASE sicuw.uwd121.
    RELEASE sicuw.uwd123.
    RELEASE sicuw.uwd125.
    RELEASE sic_bran.uwd120.
    RELEASE sic_bran.uwd121.
    RELEASE sic_bran.uwd123.
    RELEASE sic_bran.uwd125.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_uwm130 c-Win 
PROCEDURE proc_uwm130 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO:
    FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_recid1 NO-ERROR NO-WAIT.
    FIND sic_bran.uwm120 WHERE RECID(sic_bran.uwm120) = s_recid2 NO-ERROR NO-WAIT.
    FOR EACH bfuwm130 USE-INDEX uwm13001 WHERE bfuwm130.policy = TRIM(wdetail.polmaster) NO-LOCK.
    /* IF AVAIL bfuwm130 THEN DO:*/
        FIND sic_bran.uwm130 USE-INDEX uwm13001 WHERE
            sic_bran.uwm130.policy = sic_bran.uwm100.policy AND
            sic_bran.uwm130.rencnt = sic_bran.uwm100.rencnt AND
            sic_bran.uwm130.endcnt = sic_bran.uwm100.endcnt AND
            sic_bran.uwm130.riskgp = sic_bran.uwm120.riskgp AND  /*0*/
            sic_bran.uwm130.riskno = sic_bran.uwm120.riskno AND  /*1*/
            sic_bran.uwm130.itemno = bfuwm130.itemno        AND  /*1*/
            sic_bran.uwm130.bchyr  = sic_bran.uwm100.bchyr  AND 
            sic_bran.uwm130.bchno  = sic_bran.uwm100.bchno  AND 
            sic_bran.uwm130.bchcnt = sic_bran.uwm100.bchcnt NO-WAIT NO-ERROR.

       IF NOT AVAIL  sic_bran.uwm130 THEN DO:
           ASSIGN fi_process = "Create data to sic_bran.uwm130  ..." + wdetail.policy .
           DISP fi_process WITH FRAM fr_main.
           CREATE sic_bran.uwm130.
           ASSIGN 
               sic_bran.uwm130.policy    = sic_bran.uwm100.policy   
               sic_bran.uwm130.rencnt    = sic_bran.uwm100.rencnt           
               sic_bran.uwm130.endcnt    = sic_bran.uwm100.endcnt           
               sic_bran.uwm130.riskgp    = sic_bran.uwm120.riskgp                       
               sic_bran.uwm130.riskno    = sic_bran.uwm120.riskno                       
               sic_bran.uwm130.itemno    = bfuwm130.itemno                       
               sic_bran.uwm130.i_text    = bfuwm130.i_text   
               sic_bran.uwm130.uom1_c    = bfuwm130.uom1_c   
               sic_bran.uwm130.uom2_c    = bfuwm130.uom2_c   
               sic_bran.uwm130.uom3_c    = bfuwm130.uom3_c   
               sic_bran.uwm130.uom4_c    = bfuwm130.uom4_c   
               sic_bran.uwm130.uom5_c    = bfuwm130.uom5_c   
               sic_bran.uwm130.uom6_c    = bfuwm130.uom6_c   
               sic_bran.uwm130.uom7_c    = bfuwm130.uom7_c   
               sic_bran.uwm130.uom1_v    = bfuwm130.uom1_v                       
               sic_bran.uwm130.uom2_v    = bfuwm130.uom2_v                       
               sic_bran.uwm130.uom3_v    = bfuwm130.uom3_v                       
               sic_bran.uwm130.uom4_v    = bfuwm130.uom4_v                       
               sic_bran.uwm130.uom5_v    = bfuwm130.uom5_v                       
               sic_bran.uwm130.uom6_v    = bfuwm130.uom6_v                       
               sic_bran.uwm130.uom7_v    = bfuwm130.uom7_v                       
               sic_bran.uwm130.uom1_u    = bfuwm130.uom1_u   
               sic_bran.uwm130.uom2_u    = bfuwm130.uom2_u   
               sic_bran.uwm130.uom3_u    = bfuwm130.uom3_u   
               sic_bran.uwm130.uom4_u    = bfuwm130.uom4_u   
               sic_bran.uwm130.uom5_u    = bfuwm130.uom5_u   
               sic_bran.uwm130.uom6_u    = bfuwm130.uom6_u   
               sic_bran.uwm130.uom7_u    = bfuwm130.uom7_u   
               sic_bran.uwm130.dl1per    = bfuwm130.dl1per                       
               sic_bran.uwm130.dl2per    = bfuwm130.dl2per                       
               sic_bran.uwm130.dl3per    = bfuwm130.dl3per                       
               sic_bran.uwm130.fptr01    = 0 /*bfuwm130.fptr01*/                       
               sic_bran.uwm130.bptr01    = 0 /*bfuwm130.bptr01*/                       
               sic_bran.uwm130.fptr02    = 0 /*bfuwm130.fptr02*/                       
               sic_bran.uwm130.bptr02    = 0 /*bfuwm130.bptr02*/                       
               sic_bran.uwm130.fptr03    = 0                       
               sic_bran.uwm130.bptr03    = 0 /*bfuwm130.bptr03*/                       
               sic_bran.uwm130.fptr04    = 0 /*bfuwm130.fptr04*/                       
               sic_bran.uwm130.bptr04    = 0 /*bfuwm130.bptr04*/                       
               sic_bran.uwm130.fptr05    = 0 /*bfuwm130.fptr05*/                       
               sic_bran.uwm130.bptr05    = 0 /*bfuwm130.bptr05*/                       
               sic_bran.uwm130.styp20    = bfuwm130.styp20   
               sic_bran.uwm130.sval20    = bfuwm130.sval20   
               sic_bran.uwm130.itmdel    = bfuwm130.itmdel                       
               sic_bran.uwm130.uom8_c    = bfuwm130.uom8_c   
               sic_bran.uwm130.uom8_v    = bfuwm130.uom8_v                       
               sic_bran.uwm130.uom9_c    = bfuwm130.uom9_c   
               sic_bran.uwm130.uom9_v    = bfuwm130.uom9_v                       
               sic_bran.uwm130.prem_item = bfuwm130.prem_item                    
               sic_bran.uwm130.bchyr     = sic_bran.uwm100.bchyr                       
               sic_bran.uwm130.bchno     = sic_bran.uwm100.bchno   
               sic_bran.uwm130.bchcnt    = sic_bran.uwm100.bchcnt . 
               s_recid3 = RECID(sic_bran.uwm130) .
       END.
    END.
    RELEASE sic_bran.uwm130.
    RELEASE sicuw.uwm130.
    RELEASE bfuwm130.
    release sic_bran.uwm100 .
    release sic_bran.uwm120 .

END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_uwm130_text c-Win 
PROCEDURE proc_uwm130_text :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF BUFFER wf_uwd130 FOR sic_bran.uwd130.
DEF BUFFER wf_uwd131 FOR sic_bran.uwd131.
DEF BUFFER bfuwd130  FOR sicuw.uwd130.
DEF BUFFER bfuwd131  FOR sicuw.uwd131.
DO:
    FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_recid1 NO-ERROR NO-WAIT.
    FIND sic_bran.uwm130 WHERE RECID(sic_bran.uwm130) = s_recid3 NO-ERROR NO-WAIT.

    FOR EACH bfuwm130 WHERE bfuwm130.policy = TRIM(wdetail.polmaster) NO-LOCK.
        /*----------- uwd130 Item UPPER Text -----------------*/
        IF bfuwm130.fptr01 <> ? AND bfuwm130.fptr01 <> 0 THEN DO:
           /* ADD NEW DATA */
            nv_fptr = bfuwm130.fptr01.
            nv_bptr = 0.
            DO WHILE nv_fptr <> 0 AND nv_fptr <> ? :
        
              FIND bfuwd130 WHERE RECID(bfuwd130) = nv_fptr NO-LOCK NO-ERROR.
              IF AVAILABLE bfuwd130 THEN DO:
                 nv_fptr = bfuwd130.fptr.
     
                 CREATE sic_bran.uwd130.
                 ASSIGN sic_bran.uwd130.policy  = sic_bran.uwm130.Policy 
                        sic_bran.uwd130.rencnt  = sic_bran.uwm130.rencnt
                        sic_bran.uwd130.endcnt  = sic_bran.uwm130.endcnt
                        sic_bran.uwd130.riskgp  = sic_bran.uwm130.riskgp
                        sic_bran.uwd130.riskno  = sic_bran.uwm130.riskno
                        sic_bran.uwd130.itemno  = sic_bran.uwm130.itemno
                        sic_bran.uwd130.ltext   = bfuwd130.ltext
                        sic_bran.uwd130.fptr    = 0
                        sic_bran.uwd130.bptr    = nv_bptr.
                 
                 IF nv_bptr <> 0 THEN DO:
                    FIND wf_uwd130 WHERE RECID(wf_uwd130) = nv_bptr NO-ERROR.
                    wf_uwd130.fptr = RECID(sic_bran.uwd130).
                 END.
                 
                 IF nv_bptr = 0 THEN  sic_bran.uwm130.fptr01 = RECID(sic_bran.uwd130).
                 
                 nv_bptr = RECID(sic_bran.uwd130).
              END. /*IF AVAILABLE sic_Bran.uwd100 THEN DO:*/
            END.  /*DO WHILE nv_fptr <> 0 AND nv_fptr <> ? :*/
            sic_bran.uwm130.bptr01 = nv_bptr. 
        END.
        
        /*----------------------- uwd131 Item Lower text -----------------------*/
        IF bfuwm130.fptr02 <> ? AND bfuwm130.fptr02 <> 0 THEN DO:
        /* ADD NEW DATA */
            nv_fptr = bfuwm130.fptr02.
            nv_bptr = 0.
            
            DO WHILE nv_fptr <> 0 AND nv_fptr <> ? :
              FIND bfuwd131 WHERE RECID(bfuwd131) = nv_fptr NO-LOCK NO-ERROR.
              IF AVAILABLE bfuwd131 THEN DO:
                 nv_fptr = bfuwd131.fptr.
                 
                 CREATE sic_bran.uwd131.
                 ASSIGN sic_bran.uwd131.policy  = sic_bran.uwm130.Policy 
                        sic_bran.uwd131.rencnt  = sic_bran.uwm130.rencnt
                        sic_bran.uwd131.endcnt  = sic_bran.uwm130.endcnt
                        sic_bran.uwd131.riskgp  = sic_bran.uwm130.riskgp
                        sic_bran.uwd131.riskno  = sic_bran.uwm130.riskno
                        sic_bran.uwd131.itemno  = sic_bran.uwm130.itemno
                        sic_bran.uwd131.ltext   = bfuwd131.ltext
                        sic_bran.uwd131.fptr    = 0
                        sic_bran.uwd131.bptr    = nv_bptr.
                 
                 IF nv_bptr <> 0 THEN DO:
                    FIND wf_uwd131 WHERE RECID(wf_uwd131) = nv_bptr NO-ERROR.
                    wf_uwd131.fptr = RECID(sic_bran.uwd131).
                 END.
                 
                 IF nv_bptr = 0 THEN  sic_bran.uwm130.fptr02 = RECID(sic_bran.uwd131).
                 
                 nv_bptr = RECID(sic_bran.uwd131).
              END. /*IF AVAILABLE sic_Bran.uwd100 THEN DO:*/
            END.  /*DO WHILE nv_fptr <> 0 AND nv_fptr <> ? :*/
            sic_bran.uwm130.bptr02 = nv_bptr.            
        END.
    END.
    
    RELEASE bfuwm130.
    release sic_bran.uwd130.  
    release sic_bran.uwd131.
    RELEASE sic_bran.uwm130.
    release sicuw.uwd130.     
    release sicuw.uwd131. 
    RELEASE sicuw.uwm130.


END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_uwm200 c-Win 
PROCEDURE proc_uwm200 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO:
    FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_recid1 NO-ERROR NO-WAIT.
    FIND sic_bran.uwm120 WHERE RECID(sic_bran.uwm120) = s_recid2 NO-ERROR NO-WAIT.

    FOR EACH bfuwm200 USE-INDEX uwm20001 WHERE bfuwm200.policy = TRIM(wdetail.polmaster) NO-LOCK.

        FIND sic_bran.uwm200 USE-INDEX uwm20001  WHERE 
             sic_bran.uwm200.policy = sic_bran.uwm120.policy AND
             sic_bran.uwm200.rencnt = sic_bran.uwm120.rencnt AND
             sic_bran.uwm200.endcnt = sic_bran.uwm120.endcnt AND
             sic_bran.uwm200.csftq  = bfuwm200.csftq         AND 
             sic_bran.uwm200.rico   = bfuwm200.rico          AND 
             sic_bran.uwm200.bchyr  = sic_bran.uwm120.bchyr  and 
             sic_bran.uwm200.bchno  = sic_bran.uwm120.bchno  and 
             sic_bran.uwm200.bchcnt = sic_bran.uwm120.bchcnt NO-ERROR NO-WAIT .
        IF NOT AVAIL sic_bran.uwm200 THEN DO:

            CREATE sic_bran.uwm200.
            ASSIGN fi_process = "Create data to sic_bran.uwm200  ..." + wdetail.policy .
            DISP fi_process WITH FRAM fr_main.
            ASSIGN 
                sic_bran.uwm200.policy    =  sic_bran.uwm120.policy     
                sic_bran.uwm200.rencnt    =  sic_bran.uwm120.rencnt 
                sic_bran.uwm200.endcnt    =  sic_bran.uwm120.endcnt 
                sic_bran.uwm200.c_enct    =  0 
                sic_bran.uwm200.csftq     =  bfuwm200.csftq  
                sic_bran.uwm200.rico      =  bfuwm200.rico         
                sic_bran.uwm200.dept      =  sic_bran.uwm100.dept        
                sic_bran.uwm200.c_no      =  bfuwm200.c_no         
                sic_bran.uwm200.c_enno    =  bfuwm200.c_enno       
                sic_bran.uwm200.rip1ae    =  bfuwm200.rip1ae       
                sic_bran.uwm200.rip2ae    =  bfuwm200.rip2ae       
                sic_bran.uwm200.rip1      =  bfuwm200.rip1         
                sic_bran.uwm200.rip2      =  bfuwm200.rip2         
                sic_bran.uwm200.recip     =  bfuwm200.recip        
                sic_bran.uwm200.ricomm    =  sic_bran.uwm100.comdat    
                sic_bran.uwm200.riexp     =  sic_bran.uwm100.comdat    
                sic_bran.uwm200.trndat    =  sic_bran.uwm100.trndat      
                sic_bran.uwm200.com2gn    =  bfuwm200.com2gn 
                sic_bran.uwm200.ristmp    =  bfuwm200.ristmp 
                sic_bran.uwm200.prntri    =  bfuwm200.prntri 
                sic_bran.uwm200.thpol     =  bfuwm200.thpol  
                sic_bran.uwm200.c_year    =  YEAR(TODAY)
                sic_bran.uwm200.trtyri    =  bfuwm200.trtyri 
                sic_bran.uwm200.docri     =  bfuwm200.docri  
                sic_bran.uwm200.fptr01    =  0 /*bfuwm200.fptr01*/ 
                sic_bran.uwm200.bptr01    =  0 /*bfuwm200.bptr01*/ 
                sic_bran.uwm200.fptr02    =  0 /*bfuwm200.fptr02*/ 
                sic_bran.uwm200.bptr02    =  0 /*bfuwm200.bptr02*/ 
                sic_bran.uwm200.fptr03    =  0 /*bfuwm200.fptr03*/ 
                sic_bran.uwm200.bptr03    =  0 /*bfuwm200.bptr03*/ 
                sic_bran.uwm200.dreg_p    =  bfuwm200.dreg_p 
                sic_bran.uwm200.curbil    =  sic_bran.uwm100.curbil 
                sic_bran.uwm200.reg_no    =  bfuwm200.reg_no 
                sic_bran.uwm200.bordno    =  bfuwm200.bordno 
                sic_bran.uwm200.panel     =  bfuwm200.panel  
                sic_bran.uwm200.riendt    =  bfuwm200.riendt 
                sic_bran.uwm200.bchyr     =  sic_bran.uwm100.bchyr                         
                sic_bran.uwm200.bchno     =  sic_bran.uwm100.bchno                          
                sic_bran.uwm200.bchcnt    =  sic_bran.uwm100.bchcnt    
                s_recid5                  =  RECID(sic_bran.uwm200) .
        END.
        RUN proc_uwd200. 
    END.
    RELEASE sicuw.uwm200.
    RELEASE sic_bran.uwm100.
    RELEASE sic_bran.uwm120.
    RELEASE sic_bran.uwm200.
    RELEASE sic_bran.uwd200.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_uwm200_text c-Win 
PROCEDURE proc_uwm200_text :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF BUFFER wf_uwd201 FOR sic_bran.uwd201.
DEF BUFFER bfuwd201  FOR sicuw.uwd201.
DO:
    FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_recid1 NO-ERROR NO-WAIT.
    FIND sic_bran.uwm200 WHERE RECID(sic_bran.uwm200) = s_recid5 NO-ERROR NO-WAIT.

    FOR EACH bfuwm200 USE-INDEX uwm20001 WHERE bfuwm200.policy = TRIM(wdetail.polmaster) NO-LOCK.
        /*----------- uwd201 Item UPPER Text -----------------*/
        IF bfuwm200.fptr02 <> ? AND bfuwm200.fptr02 <> 0 THEN DO:
           /* ADD NEW DATA */
            nv_fptr = bfuwm200.fptr02.
            nv_bptr = 0.
            DO WHILE nv_fptr <> 0 AND nv_fptr <> ? :
        
              FIND bfuwd201 WHERE RECID(bfuwd201) = nv_fptr NO-LOCK NO-ERROR.
              IF AVAILABLE bfuwd201 THEN DO:
                 nv_fptr = bfuwd201.fptr.
     
                 CREATE sic_bran.uwd201.
                 ASSIGN sic_bran.uwd201.policy  = sic_bran.uwm200.Policy 
                        sic_bran.uwd201.rencnt  = sic_bran.uwm200.rencnt
                        sic_bran.uwd201.endcnt  = sic_bran.uwm200.endcnt
                        sic_bran.uwd201.c_enct  = sic_bran.uwm200.c_enct 
                        sic_bran.uwd201.csftq   = sic_bran.uwm200.csftq  
                        sic_bran.uwd201.rico    = sic_bran.uwm200.rico   
                        sic_bran.uwd201.ltext   = bfuwd201.ltext
                        sic_bran.uwd201.fptr    = 0
                        sic_bran.uwd201.bptr    = nv_bptr.
                 
                 IF nv_bptr <> 0 THEN DO:
                    FIND wf_uwd201 WHERE RECID(wf_uwd201) = nv_bptr NO-ERROR.
                        wf_uwd201.fptr = RECID(sic_bran.uwd201).
                 END.
                 
                 IF nv_bptr = 0 THEN  sic_bran.uwm200.fptr02 = RECID(sic_bran.uwd201).
                 
                 nv_bptr = RECID(sic_bran.uwd201).
              END. /*IF AVAILABLE sic_Bran.uwd100 THEN DO:*/
            END.  /*DO WHILE nv_fptr <> 0 AND nv_fptr <> ? :*/
            sic_bran.uwm200.bptr02 = nv_bptr. 
        END.
    END.
    release bfuwd201.
    release sicuw.uwm200.
    release sicuw.uwd201.
    RELEASE sic_bran.uwm100.
    release sic_bran.uwm200.
    release sic_bran.uwd201.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_uwm307 c-Win 
PROCEDURE proc_uwm307 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO:
    FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_recid1 NO-ERROR NO-WAIT.
    FIND sic_bran.uwm120 WHERE RECID(sic_bran.uwm120) = s_recid2 NO-ERROR NO-WAIT.

    FOR EACH bfuwm307 USE-INDEX uwm30701 WHERE bfuwm307.policy = TRIM(wdetail.polmaster) NO-LOCK .

    FIND sic_bran.uwm307 USE-INDEX uwm30701  WHERE 
         sic_bran.uwm307.policy = sic_bran.uwm100.policy AND
         sic_bran.uwm307.rencnt = sic_bran.uwm100.rencnt AND
         sic_bran.uwm307.endcnt = sic_bran.uwm100.endcnt AND
         sic_bran.uwm307.riskgp = sic_bran.uwm120.riskgp and
         sic_bran.uwm307.riskno = sic_bran.uwm120.riskno and
         sic_bran.uwm307.itemno = bfuwm307.itemno        and
         sic_bran.uwm307.bchyr  = sic_bran.uwm100.bchyr  AND
         sic_bran.uwm307.bchno  = sic_bran.uwm100.bchno  AND
         sic_bran.uwm307.bchcnt = sic_bran.uwm100.bchcnt NO-ERROR NO-WAIT .

        IF NOT AVAIL sic_bran.uwm307 THEN DO:
            ASSIGN fi_process = "Create data to sic_bran.uwm307  ..." + wdetail.policy .
            DISP fi_process WITH FRAM fr_main.
            CREATE sic_bran.uwm307.
            ASSIGN 
                sic_bran.uwm307.policy   = sic_bran.uwm100.policy   
                sic_bran.uwm307.rencnt   = sic_bran.uwm100.rencnt                          
                sic_bran.uwm307.endcnt   = sic_bran.uwm100.endcnt                          
                sic_bran.uwm307.riskgp   = sic_bran.uwm120.riskgp                         
                sic_bran.uwm307.riskno   = sic_bran.uwm120.riskno                         
                sic_bran.uwm307.itemno   = bfuwm307.itemno                         
                sic_bran.uwm307.iref     = bfuwm307.iref    
                sic_bran.uwm307.ifirst   = TRIM(wdetail.tiname)
                sic_bran.uwm307.iname    = TRIM(wdetail.insnam)
                sic_bran.uwm307.iyob     = 0                           
                sic_bran.uwm307.idob     = DATE(wdetail.bdate)                               
                sic_bran.uwm307.iocc     = IF TRIM(wdetail.occup) <> "" THEN TRIM(wdetail.occup) ELSE "-"                                
                sic_bran.uwm307.iocct    = bfuwm307.iocct                          
                sic_bran.uwm307.ioccs    = bfuwm307.ioccs   
                sic_bran.uwm307.bname1   = bfuwm307.bname1 /*TRIM(wdetail.insnam) */
                sic_bran.uwm307.bname2   = bfuwm307.bname2  
                sic_bran.uwm307.badd1    = bfuwm307.badd1   
                sic_bran.uwm307.badd2    = bfuwm307.badd2   
                sic_bran.uwm307.reship   = bfuwm307.reship  
                sic_bran.uwm307.endatt   = bfuwm307.endatt  
                sic_bran.uwm307.ldcd     = bfuwm307.ldcd    
                sic_bran.uwm307.ldae     = bfuwm307.ldae                           
                sic_bran.uwm307.ldrate   = bfuwm307.ldrate                         
                sic_bran.uwm307.mbsi     = bfuwm307.mbsi                           
                sic_bran.uwm307.mbr_ae   = bfuwm307.mbr_ae                         
                sic_bran.uwm307.mbrate   = bfuwm307.mbrate                         
                sic_bran.uwm307.mbapae   = bfuwm307.mbapae                         
                sic_bran.uwm307.mbap     = bfuwm307.mbap                           
                sic_bran.uwm307.mbpdae   = bfuwm307.mbpdae                         
                sic_bran.uwm307.mbpd     = bfuwm307.mbpd                           
                sic_bran.uwm307.mb4wks   = bfuwm307.mb4wks                         
                sic_bran.uwm307.mb5wks   = bfuwm307.mb5wks                         
                sic_bran.uwm307.mb4ded   = bfuwm307.mb4ded                         
                sic_bran.uwm307.mb5ded   = bfuwm307.mb5ded                         
                sic_bran.uwm307.mb6ded   = bfuwm307.mb6ded                         
                sic_bran.uwm307.abcd     = bfuwm307.abcd    
                sic_bran.uwm307.abrtae   = bfuwm307.abrtae                         
                sic_bran.uwm307.abrt     = bfuwm307.abrt                           
                sic_bran.uwm307.abapae   = bfuwm307.abapae                         
                sic_bran.uwm307.abap     = bfuwm307.abap                           
                sic_bran.uwm307.abpdae   = bfuwm307.abpdae                         
                sic_bran.uwm307.abpd     = bfuwm307.abpd                           
                sic_bran.uwm307.tariff   = bfuwm307.tariff  
                sic_bran.uwm307.icno     = TRIM(wdetail.nv_icno)     
                sic_bran.uwm307.bname3   = bfuwm307.bname3  
                sic_bran.uwm307.mb1day   = bfuwm307.mb1day                         
                sic_bran.uwm307.mb6day   = bfuwm307.mb6day                         
                sic_bran.uwm307.mb7day   = bfuwm307.mb7day                         
                sic_bran.uwm307.mb8day   = bfuwm307.mb8day                         
                sic_bran.uwm307.bchyr    = sic_bran.uwm100.bchyr                       
                sic_bran.uwm307.bchno    = sic_bran.uwm100.bchno  
                sic_bran.uwm307.bchcnt   = sic_bran.uwm100.bchcnt. 
                s_recid4 = RECID(sic_bran.uwm307).
        END.
    END.
    release bfuwm307.
    release sicuw.uwm307.
    release sic_bran.uwm307.
    release sic_bran.uwm100.
    release sic_bran.uwm120.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_var c-Win 
PROCEDURE proc_var :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN
    /* nv_camptyp =  "NORM"*/
    s_riskgp   =   0                     s_riskno       =  1
    s_itemno   =   1                     nv_undyr       =  String(Year(today),"9999")   
    n_rencnt   =   0                     n_endcnt       =  0.
    
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_xpara49 c-Win 
PROCEDURE proc_xpara49 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO:
    FOR EACH wxpara49.
        DELETE wxpara49.
    END.
    FOR EACH sicsyac.xcpara49 WHERE xcpara49.type[3] = "M60" NO-LOCK.
        IF xcpara49.TYPE[12] = " "  THEN NEXT.
        
        FIND LAST wplan WHERE wplan.para12 = xcpara49.TYPE[12]  NO-ERROR NO-WAIT.
        IF NOT AVAIL wplan THEN DO:
            CREATE wplan.
            ASSIGN 
                wplan.para3  = xcpara49.type[3]    /*poltype: M60 */
                wplan.para12 = xcpara49.TYPE[12]  . /* plan */
                nv_product = nv_product + " ," + xcpara49.TYPE[12].
        END.

        FIND LAST wxpara49 WHERE wxpara49.para1 = xcpara49.type[1]  NO-LOCK NO-ERROR.
        IF NOT AVAIL wxpara49 THEN DO:
            CREATE wxpara49.
            ASSIGN wxpara49.para1  = xcpara49.type[1]    /*product: CNSS60S001 */
                   wxpara49.para3  = xcpara49.type[3]    /*poltype: M60 */
                   wxpara49.para7  = xcpara49.type[7]    /*detail : SafeSafe 1 (ส่วนลด 10%*/
                   wxpara49.para9  = xcpara49.type[9]    /*description : PA.SafeSafe1 */
                   wxpara49.para10 = xcpara49.type[10]   /*polmas : DY6060UW0004 */
                   wxpara49.para11 = xcpara49.type[11]   /*class : P101 */
                   wxpara49.para12 = xcpara49.TYPE[12]
                   wxpara49.prem_c = 0 .                 /* prem */
            FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE uwm100.policy = xcpara49.type[10] NO-LOCK NO-ERROR.
            IF AVAIL sicuw.uwm100 THEN DO:
                ASSIGN wxpara49.prem_c = (uwm100.prem_t + uwm100.rstp_t + uwm100.rtax_t).
            END.
        END.
    END.
 
    RELEASE sicsyac.xcpara49.
    RELEASE sicuw.uwm100.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

