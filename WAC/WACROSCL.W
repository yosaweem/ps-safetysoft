&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          sicfn            PROGRESS
*/
&Scoped-define WINDOW-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS C-Win 
/*------------------------------------------------------------------------

  File: WACROSCL.W

  Description: Printing Report for Outstanding Claim

  Input Parameters: 
      - Report for Motor / Non motor
      - Policy Type
      - OS Type : OS > 0, 
                  OS All (> 0, = 0, < 0 but CL Status = blank, O, P)
      - File Output for Motor = 2 Files (Detail, Summary)
                    for Non motor = 1 File
  Output Parameters:
      <none>

  Author: By N.Sayamol A49-0173

  Created: 
  Modify by A51-0102   Sayamol  03/04/2008  
          - Clear Text Before Find Data
  Modify By A51-0126   Sayamol  06/05/2008
          - Summary Compulsory by Nature 
          - xxxc.txt - Compulsory Report
          
  Modify By :  Lukkana M.  Date : 22/07/2010
  Assign No :  A53-0139  เพิ่มคอลัมน์ servey fee , total gross และแก้เงื่อนไข
               ให้แสดงข้อมูลทุก clmant 
          
------------------------------------------------------------------------*/
/*          This .W file was created with the Progress AppBuilder.      */
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

/* Parameters Definitions ---                                           */

/* Local Variable Definitions ---                                       */
DEF VAR nv_chkline AS LOGICAL. 
DEF VAR n_txtbr    AS CHAR  FORMAT "X(20)".
DEF VAR nv_reccnt  AS INT.
DEF VAR nv_reccnt2 AS INT.
DEF VAR nv_next    AS INT.
DEF VAR nv_next2   AS INT.
DEF VAR n_report   AS INT.
DEF VAR poltyp     AS CHAR FORMAT "X(2)".
DEF VAR n_poltyp   AS CHAR FORMAT "X(2)".

/*---A51-0126---*/
DEF VAR nb_cnt   AS INT INIT 0.   
DEF VAR nc_cnt    AS INT INIT 0.   
DEF VAR nct_cnt   AS INT INIT 0.   
DEF VAR nctg_cnt   AS INT INIT 0.   
DEF VAR cnt_comp  AS LOG.   

DEF WORKFILE wfcompcnt 
    FIELD wfcompcnt_br    AS CHAR FORMAT "X(2)"
    FIELD wfcompcnt_res   AS DEC FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wfcompcnt_paid  AS DEC FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wfcompcnt_cnt   AS INT INIT 0.
  

/*---A51-0126---*/

DEF VAR non_poltyp AS INT INIT 0.

DEF VAR n_asdat      AS DATE FORMAT "99/99/9999".
DEF VAR n_trndatto   AS DATE FORMAT "99/99/9999".

DEF VAR nv_datfr     AS DATE FORMAT "99/99/9999".
DEF VAR nv_datto     AS DATE FORMAT "99/99/9999".

DEF VAR nv_branfr    AS CHAR FORMAT "X(2)".
DEF VAR nv_branto    AS CHAR FORMAT "X(2)".

DEF VAR nv_nbran     AS CHAR FORMAT "X(50)".
DEF VAR n_nbran      AS CHAR FORMAT "X(50)".

DEF VAR n_ostyp      AS INT INIT 0.
DEF VAR nv_ntype     AS CHAR FORMAT "X(30)".

DEF VAR n_output     AS CHAR FORMAT "X(25)".
DEF VAR nv_output    AS CHAR FORMAT "X(30)".
DEF VAR nv_output2   AS CHAR FORMAT "X(30)".
DEF VAR nv_Coutput   AS CHAR FORMAT "X(30)".  /*A51-0126*/

DEF VAR nv_claim     AS CHAR FORMAT "X(16)".
DEF VAR nv_clmant    AS INT  FORMAT 999.
DEF VAR nv_clitem    AS INT  FORMAT 999.

DEF VAR nv_poldes    AS CHAR FORMAT "X(50)".
DEF VAR nv_name      AS CHAR FORMAT "X(50)".
DEF VAR nv_acno1     AS CHAR FORMAT "X(30)".
DEF VAR nv_cedclm    AS CHAR FORMAT "X(30)".

DEF VAR nv_prodnam   AS CHAR FORMAT "X(30)".
DEF VAR nv_produc    AS CHAR FORMAT "X(30)".
DEF VAR nv_extcod    AS CHAR FORMAT "X(12)".   /*A51-0102*/ 
DEF VAR nv_extnam    AS CHAR FORMAT "X(30)".
DEF VAR nv_exter     AS CHAR FORMAT "X(30)".
DEF VAR nv_extref    AS CHAR FORMAT "X(30)".
DEF VAR nv_wextref   AS CHAR FORMAT "X(30)".

DEF VAR nv_adjust    AS CHAR FORMAT "X(30)".
DEF VAR nv_adjusna   AS CHAR FORMAT "X(30)".

DEF VAR nv_police    AS CHAR FORMAT "X(30)".
DEF VAR nv_pacod     AS CHAR FORMAT "X(30)".
DEF VAR nv_pades     AS CHAR FORMAT "X(30)".

DEF VAR n_adjusna  AS CHAR FORMAT "X(50)".
DEF VAR n_adjust   AS CHAR FORMAT "X(45)".

DEF VAR n_tos   AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR n_tpaid AS DECI FORMAT "->>,>>>,>>>,>>9.99".
/*DEF VAR n_tamt  AS DECI EXTENT 18 FORMAT "->>,>>>,>>>,>>9.99".  Lukkana M. A53-0139 02/09/2010*/
DEF VAR n_tamt  AS DECI EXTENT 20 FORMAT "->>,>>>,>>>,>>9.99".  /*Lukkana M. A53-0139 02/09/2010*/

DEF VAR nv_bros   AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nv_brpaid AS DECI FORMAT "->>,>>>,>>>,>>9.99".
/*DEF VAR nv_bramt  AS DECI EXTENT 18 FORMAT "->>,>>>,>>>,>>9.99". Lukkana M. A53-0139 02/09/2010*/
DEF VAR nv_bramt  AS DECI EXTENT 20 FORMAT "->>,>>>,>>>,>>9.99".  /*Lukkana M. A53-0139 02/09/2010*/

DEF VAR n_bros   AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR n_brpaid AS DECI FORMAT "->>,>>>,>>>,>>9.99".
/*DEF VAR n_bramt  AS DECI EXTENT 18 FORMAT "->>,>>>,>>>,>>9.99". Lukkana M. A53-0139 02/09/2010*/
DEF VAR n_bramt  AS DECI EXTENT 20 FORMAT "->>,>>>,>>>,>>9.99".  /*Lukkana M. A53-0139 02/09/2010*/

DEF VAR n_gros   AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR n_grpaid AS DECI FORMAT "->>,>>>,>>>,>>9.99".
/*DEF VAR n_gramt  AS DECI EXTENT 18 FORMAT "->>,>>>,>>>,>>9.99". Lukkana M. A53-0139 02/09/2010*/
DEF VAR n_gramt  AS DECI EXTENT 20 FORMAT "->>,>>>,>>>,>>9.99".  /*Lukkana M. A53-0139 02/09/2010*/

DEF VAR n_dos  AS DECI FORMAT "->>,>>>,>>>,>>9.99".
/*DEF VAR n_damt AS DECI EXTENT 18. Lukkana M. A53-0139 02/09/2010*/
DEF VAR n_damt AS DECI EXTENT 20.  /*Lukkana M. A53-0139 02/09/2010*/

DEF VAR n_txt  AS CHAR FORMAT "X(20)".

DEF VAR nv_asdat   AS DATE FORMAT "99/99/999".
DEF VAR nv_event   AS CHAR FORMAT "X(16)".
DEF VAR nv_defau   AS CHAR FORMAT "X(25)".
DEF VAR nv_loss1   LIKE clm100.loss1.
DEF VAR nv_comdat  AS DATE FORMAT "99/99/9999".
DEF VAR nv_expdat  AS DATE FORMAT "99/99/9999".
DEF VAR nv_renpol  AS CHAR FORMAT "X(16)".
DEF VAR nv_covcod  LIKE uwm301.covcod.

DEF VAR nv_insurnam AS CHAR FORMAT "X(50)".
DEF VAR nv_pdcode  LIKE xmm600.acno.
DEF VAR nv_pdname  LIKE XMM600.name.
DEF VAR nv_nacod   AS CHAR FORMAT "X(2)".
DEF VAR nv_nades   AS CHAR FORMAT "X(40)".
DEF VAR nv_paid    AS DECI FORMAT "->>,>>>,>>>,>>9.99".

DEF VAR n_netl_d   LIKE clm130.netl_d.
DEF VAR n_paiddat  LIKE clm130.trndat.

DEFINE WORKFILE WCZM100
    FIELD wfpoltyp AS CHAR FORMAT "X(2)"
    FIELD wfDI     AS CHAR FORMAT "X"
    FIELD wfpoldes AS CHAR FORMAT "X(35)"
    FIELD wfos     AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wfpaid   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    /*FIELD wfamt    AS DECI EXTENT 18 FORMAT "->>,>>>,>>>,>>9.99". Lukkana M. A53-0139 02/09/2010*/
    FIELD wfamt    AS DECI EXTENT 20 FORMAT "->>,>>>,>>>,>>9.99".  /*Lukkana M. A53-0139 02/09/2010*/

DEFINE WORKFILE WLCZM100
    FIELD wlbran   AS CHAR FORMAT "X(2)"
    FIELD wlpoltyp AS CHAR FORMAT "X(2)"
    FIELD wlos     AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    /*FIELD wlamt    AS DECI EXTENT 18 FORMAT "->>,>>>,>>>,>>9.99". Lukkana M. A53-0139 02/09/2010*/
    FIELD wlamt    AS DECI EXTENT 20 FORMAT "->>,>>>,>>>,>>9.99".  /*Lukkana M. A53-0139 02/09/2010*/

DEF WORKFILE wfpoltyp
    FIELD wfpbr     AS CHAR FORMAT "X(2)"
    FIELD wftyp     AS CHAR FORMAT "x(1)"
    FIELD wfline    AS CHAR FORMAT "X(4)"
    FIELD wfpres    AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wfppaid   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    /*FIELD wfpamt    AS DECI EXTENT 18 FORMAT "->>,>>>,>>>,>>9.99" Lukkana M. A53-0139 02/09/2010*/
    FIELD wfpamt    AS DECI EXTENT 20 FORMAT "->>,>>>,>>>,>>9.99"  /*Lukkana M. A53-0139 02/09/2010*/
    FIELD wfcnt     AS INT FORMAT ">>>,>>9".

DEF WORKFILE wfcpoltyp /*Comp*/
    FIELD wfcpbr     AS CHAR FORMAT "X(2)"
    FIELD wfctyp     AS CHAR FORMAT "x(1)"
    FIELD wfcloss    AS CHAR FORMAT "X(2)"    /*A51-0126*/
    FIELD wfcpres    AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wfcppaid   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    /*FIELD wfcpamt    AS DECI EXTENT 18 FORMAT "->>,>>>,>>>,>>9.99" Lukkana M. A53-0139 02/09/2010*/
    FIELD wfcpamt    AS DECI EXTENT 20 FORMAT "->>,>>>,>>>,>>9.99"  /*Lukkana M. A53-0139 02/09/2010*/
    FIELD wfcpcnt    AS INT  FORMAT ">>>,>>9".

DEF WORKFILE wfbranch
    FIELD wfbr     AS CHAR FORMAT "X(2)"
    FIELD wfbline  AS CHAR FORMAT "X(2)"
    FIELD wfbres   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wfbpaid  AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    /*FIELD wfbpamt  AS DECI EXTENT 18 FORMAT "->>,>>>,>>>,>>9.99" Lukkana M. A53-0139 02/09/2010*/
    FIELD wfbpamt  AS DECI EXTENT 20 FORMAT "->>,>>>,>>>,>>9.99"  /*Lukkana M. A53-0139 02/09/2010*/
    FIELD wfbcnt   AS INT  FORMAT ">>,>>9".

DEF WORKFILE wfcbranch /*Comp*/
    FIELD wfcbr     AS CHAR FORMAT "X(2)"
    FIELD wfcbline  AS CHAR FORMAT "X(2)"
    FIELD wfcbres   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wfcbpaid  AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    /*FIELD wfcbpamt   AS DECI EXTENT 18 FORMAT "->>,>>>,>>>,>>9.99" Lukkana M. A53-0139 02/09/2010*/
    FIELD wfcbpamt   AS DECI EXTENT 20 FORMAT "->>,>>>,>>>,>>9.99" /*Lukkana M. A53-0139 02/09/2010*/
    FIELD wfcbcnt   AS INT  FORMAT ">>,>>9".

DEF WORKFILE wftbranch
    FIELD wftbr     AS CHAR FORMAT "X(2)"
    FIELD wftbres   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wftbpaid  AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    /*FIELD wftbpamt    AS DECI EXTENT 18 FORMAT "->>,>>>,>>>,>>9.99" Lukkana M. A53-0139 02/09/2010*/
    FIELD wftbpamt    AS DECI EXTENT 20 FORMAT "->>,>>>,>>>,>>9.99"  /*Lukkana M. A53-0139 02/09/2010*/
    FIELD wftbcnt   AS INT  FORMAT ">>,>>9".
 
DEF WORKFILE wfctbranch /*Comp*/
    FIELD wfctbr     AS CHAR FORMAT "X(2)"
    FIELD wfctbres   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wfctbpaid  AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wfctbamt   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wfctbcnt   AS INT  FORMAT ">>,>>9".

DEF WORKFILE wfnon
    FIELD wfnbran   AS CHAR FORMAT "X(2)"
    FIELD wfnpoltyp AS CHAR FORMAT "X(2)"
    FIELD wfnDI     AS CHAR FORMAT "X"
    FIELD wfnos     AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wfnpaid   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    /*FIELD wfnamt    AS DECI EXTENT 18 FORMAT "->>,>>>,>>>,>>9.99". Lukkana M. A53-0139 02/09/2010*/
    FIELD wfnamt    AS DECI EXTENT 20 FORMAT "->>,>>>,>>>,>>9.99".  /*Lukkana M. A53-0139 02/09/2010*/

DEF WORKFILE wfcnon
    FIELD wfcnbran   AS CHAR FORMAT "X(2)"
    FIELD wfcnpoltyp AS CHAR FORMAT "X(2)"
    FIELD wfcnDI     AS CHAR FORMAT "X"
    FIELD wfcnos     AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wfcnpaid   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    /*FIELD wfcnamt    AS DECI EXTENT 18 FORMAT "->>,>>>,>>>,>>9.99".  Lukkana M. A53-0139 02/09/2010*/
    FIELD wfcnamt    AS DECI EXTENT 20 FORMAT "->>,>>>,>>>,>>9.99".  /*Lukkana M. A53-0139 02/09/2010*/


DEF WORKFILE wfcnt  
    FIELD cntbranch AS CHAR FORMAT "X(2)"
    FIELD reccnt   AS INT  FORMAT ">>>,>>9" INIT 0.

DEF WORKFILE wflcnt  
    FIELD cntline  AS CHAR FORMAT "X(2)"
    FIELD reclcnt   AS INT  FORMAT ">>>,>>9" INIT 0.

DEF WORKFILE wfcntLine 
    FIELD cline  AS CHAR FORMAT "X(2)"
    FIELD reccntline AS INT FORMAT ">>>,>>9" INIT 0.

DEF VAR n_sosres AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR n_spaid  AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR n_bosres AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR n_bpaid  AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR n_bcnt   AS INT FORMAT ">>,>>9".
DEF VAR n_tosres AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR n_gosres AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR n_gpaid  AS DECI FORMAT "->>,>>>,>>>,>>9.99".

DEF VAR nv_sumpaid AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nv_sumos   AS DECI FORMAT "->>,>>>,>>>,>>9.99".

DEF VAR n_os     AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR n_paid   AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR n_cnt     AS   INT   FORMAT ">>,>>9".

DEF VAR n_compos AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR n_comppaid AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR n_compcnt     AS   INT   FORMAT ">>,>>9".

DEF VAR n_cosres AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR n_cpaid AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR n_ccnt   AS INT FORMAT ">>,>>>,>>9".

DEF VAR n_tcosres AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR n_tcpaid AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR n_tcnt   AS INT FORMAT ">>,>>9".

DEF VAR n_gcosres AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR n_gcpaid  AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR n_gccnt   AS INT FORMAT ">>,>>9".

DEF VAR i AS INT INIT 0.

DEF VAR wt_cnt    AS   INT   FORMAT ">>,>>9".
DEF VAR w_cnt     AS   INT   FORMAT ">>,>>9".
DEF VAR wg_cnt    AS   INT   FORMAT ">>>,>>9".
DEF VAR n_claim   AS   CHAR  FORMAT "X(16)".
DEF VAR nt_cnt    AS   INT   FORMAT ">>,>>9".
DEF VAR txtrep    AS CHAR FORMAT "X(15)".
DEF VAR txtpoltyp AS CHAR FORMAT "X(15)".
DEF VAR n_len     AS INT.
DEF VAR n_bdes    LIKE xmm023.bdes.
DEF VAR n_br      AS CHAR FORMAT "X(2)".
DEF VAR n_loss    AS CHAR FORMAT "X(2)".

/*-----------A50-0178----------*/
DEF VAR n_nbrn   AS CHAR FORMAT "X(2)".
DEF VAR n_obrn   AS CHAR FORMAT "X(2)".
/*------------------------------*/
DEF VAR nv_br1 AS CHAR. /*Lukkana M. A53-0139 22/07/2010*/

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define BROWSE-NAME BROWSE-1

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES acproc_fil

/* Definitions for BROWSE BROWSE-1                                      */
&Scoped-define FIELDS-IN-QUERY-BROWSE-1 acproc_fil.asdat acproc_fil.type ~
acproc_fil.typdesc acproc_fil.trndatfr acproc_fil.trndatto ~
acproc_fil.entdat acproc_fil.enttim acproc_fil.usrid 
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-1 
&Scoped-define QUERY-STRING-BROWSE-1 FOR EACH acproc_fil ~
      WHERE acproc_fil.type = "10" NO-LOCK ~
    BY acproc_fil.asdat DESCENDING INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-BROWSE-1 OPEN QUERY BROWSE-1 FOR EACH acproc_fil ~
      WHERE acproc_fil.type = "10" NO-LOCK ~
    BY acproc_fil.asdat DESCENDING INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-BROWSE-1 acproc_fil
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-1 acproc_fil


/* Definitions for FRAME frReport                                       */
&Scoped-define OPEN-BROWSERS-IN-QUERY-frReport ~
    ~{&OPEN-QUERY-BROWSE-1}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS IMAGE-21 IMAGE-23 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE IMAGE IMAGE-21
     FILENAME "wimage/wallpape.bmp":U CONVERT-3D-COLORS
     SIZE 131.5 BY 23.57.

DEFINE IMAGE IMAGE-23
     FILENAME "wimage/bgc01.bmp":U CONVERT-3D-COLORS
     SIZE 117 BY 22.38.

DEFINE BUTTON buCancel 
     LABEL "Cancel" 
     SIZE 18.5 BY 2.1
     FONT 6.

DEFINE BUTTON buOK 
     LABEL "OK" 
     SIZE 18.5 BY 2.1
     FONT 6.

DEFINE VARIABLE fiAsdat AS DATE FORMAT "99/99/9999":U 
      VIEW-AS TEXT 
     SIZE 14 BY .71
     BGCOLOR 3 FGCOLOR 7  NO-UNDO.

DEFINE VARIABLE fiBranFr AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 5 BY .71
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiBranTo AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 5 BY .71
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiOutput AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 35 BY .91
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiPoltyp AS CHARACTER FORMAT "X(3)":U INITIAL "0" 
     VIEW-AS FILL-IN 
     SIZE 6 BY .95
     BGCOLOR 15 FONT 2 NO-UNDO.

DEFINE VARIABLE fiProcessDate AS DATE FORMAT "99/99/9999":U 
      VIEW-AS TEXT 
     SIZE 14 BY .71
     BGCOLOR 3 FGCOLOR 7  NO-UNDO.

DEFINE VARIABLE rsOSTyp AS INTEGER 
     VIEW-AS RADIO-SET VERTICAL
     RADIO-BUTTONS 
          "O/S Claim > 0", 1,
"O/S Claim All", 2
     SIZE 23 BY 2
     BGCOLOR 3 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE rsProcTyp AS INTEGER 
     VIEW-AS RADIO-SET VERTICAL
     RADIO-BUTTONS 
          "MOTOR", 1,
"NON MOTOR", 2
     SIZE 17.5 BY 2.14
     BGCOLOR 8 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE rsProcTypN AS INTEGER 
     VIEW-AS RADIO-SET VERTICAL
     RADIO-BUTTONS 
          "Not Line 30, 01, 04", 1,
"Only Line 30, 01, 04", 2,
"All", 3
     SIZE 25 BY 2.86
     BGCOLOR 3 FGCOLOR 15  NO-UNDO.

DEFINE RECTANGLE RecBrowse
     EDGE-PIXELS 3 GRAPHIC-EDGE  
     SIZE 106.5 BY 6.19
     BGCOLOR 8 .

DEFINE RECTANGLE RecOK
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 49 BY 3.1
     BGCOLOR 1 .

DEFINE RECTANGLE RecOStyp
     EDGE-PIXELS 4 GRAPHIC-EDGE  
     SIZE 25.17 BY 5
     BGCOLOR 8 .

DEFINE RECTANGLE recOutput
     EDGE-PIXELS 4 GRAPHIC-EDGE  
     SIZE 49.5 BY 1.43
     BGCOLOR 8 .

DEFINE RECTANGLE RecProctyp
     EDGE-PIXELS 4 GRAPHIC-EDGE  
     SIZE 19.5 BY 5.95
     BGCOLOR 8 .

DEFINE RECTANGLE RecProctyp-2
     EDGE-PIXELS 4 GRAPHIC-EDGE  
     SIZE 26 BY 5
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-100
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 106 BY 6.91
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-101
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 62 BY .24.

DEFINE RECTANGLE RECT-102
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE .67 BY 6.05.

DEFINE RECTANGLE RECT-104
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 27 BY 4.52.

DEFINE RECTANGLE RECT-105
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 25 BY 4.05.

DEFINE RECTANGLE RECT-108
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 25.5 BY 3.1.

DEFINE RECTANGLE RECT-110
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 26 BY 3.1.

DEFINE RECTANGLE RECT-99
     EDGE-PIXELS 4 GRAPHIC-EDGE  
     SIZE 24.17 BY 4.95
     BGCOLOR 8 .

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY BROWSE-1 FOR 
      acproc_fil SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE BROWSE-1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-1 C-Win _STRUCTURED
  QUERY BROWSE-1 NO-LOCK DISPLAY
      acproc_fil.asdat FORMAT "99/99/9999":U
      acproc_fil.type COLUMN-LABEL "Type" FORMAT "X(2)":U WIDTH 3.5
      acproc_fil.typdesc COLUMN-LABEL "Process Desc." FORMAT "X(35)":U
            WIDTH 23.33
      acproc_fil.trndatfr COLUMN-LABEL "Trans.Date From" FORMAT "99/99/9999":U
            WIDTH 14.83
      acproc_fil.trndatto COLUMN-LABEL "Trans.Date To" FORMAT "99/99/9999":U
            WIDTH 14.33
      acproc_fil.entdat FORMAT "99/99/9999":U WIDTH 9.33
      acproc_fil.enttim FORMAT "X(8)":U
      acproc_fil.usrid FORMAT "X(6)":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 102.83 BY 4.05
         BGCOLOR 15  EXPANDABLE.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     IMAGE-21 AT ROW 1.1 COL 1
     IMAGE-23 AT ROW 1.95 COL 8.5
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 131.83 BY 23.71.

DEFINE FRAME frReport
     BROWSE-1 AT ROW 4 COL 4
     rsProcTyp AT ROW 11.38 COL 16.67 NO-LABEL
     fiPoltyp AT ROW 11.71 COL 57.5 COLON-ALIGNED NO-LABEL
     rsProcTypN AT ROW 11.1 COL 79 NO-LABEL
     rsOSTyp AT ROW 18 COL 4.5 NO-LABEL
     fiBranFr AT ROW 18.1 COL 45.83 COLON-ALIGNED NO-LABEL
     fiBranTo AT ROW 19.1 COL 45.83 COLON-ALIGNED NO-LABEL
     fiOutput AT ROW 16.86 COL 71 COLON-ALIGNED NO-LABEL
     buOK AT ROW 18.86 COL 63
     buCancel AT ROW 18.86 COL 87.5
     fiAsdat AT ROW 2.86 COL 37 COLON-ALIGNED NO-LABEL
     fiProcessDate AT ROW 2.86 COL 69.5 COLON-ALIGNED NO-LABEL
     " BRANCH" VIEW-AS TEXT
          SIZE 23.5 BY .76 AT ROW 17.05 COL 31.33
          BGCOLOR 1 FGCOLOR 7 FONT 6
     " REPORT" VIEW-AS TEXT
          SIZE 40.17 BY .71 AT ROW 9.1 COL 3.83
          BGCOLOR 1 FGCOLOR 7 FONT 6
     " As of Date" VIEW-AS TEXT
          SIZE 11.5 BY .71 AT ROW 2.86 COL 27
          BGCOLOR 1 FGCOLOR 7 FONT 6
     "                                                   REPORT FOR  OUTSTANDING CLAIM" VIEW-AS TEXT
          SIZE 110 BY .95 AT ROW 1 COL 1
          BGCOLOR 1 FGCOLOR 15 FONT 6
     " [70, 72, 73, 74, ALL]" VIEW-AS TEXT
          SIZE 22 BY .71 AT ROW 13.1 COL 49
          FONT 6
     "Branch From" VIEW-AS TEXT
          SIZE 13 BY .71 AT ROW 18.1 COL 32.33
          BGCOLOR 1 FGCOLOR 7 FONT 6
     "File Name" VIEW-AS TEXT
          SIZE 10.5 BY .91 AT ROW 16.86 COL 61
          BGCOLOR 1 FGCOLOR 7 FONT 6
     " O/S TYPE" VIEW-AS TEXT
          SIZE 24 BY .76 AT ROW 17 COL 4
          BGCOLOR 1 FGCOLOR 7 FONT 6
     " Process Date" VIEW-AS TEXT
          SIZE 14 BY .71 AT ROW 2.86 COL 57
          BGCOLOR 1 FGCOLOR 7 FONT 6
     "Branch To" VIEW-AS TEXT
          SIZE 13 BY .71 AT ROW 19.1 COL 32.33
          BGCOLOR 1 FGCOLOR 7 FONT 6
     " MOTOR" VIEW-AS TEXT
          SIZE 24.67 BY .71 AT ROW 10.05 COL 47.5
          BGCOLOR 1 FGCOLOR 7 FONT 6
     "Line:  V" VIEW-AS TEXT
          SIZE 11 BY .95 AT ROW 11.71 COL 48
          FONT 2
     "" VIEW-AS TEXT
          SIZE 23 BY .76 AT ROW 20.14 COL 31.5
          BGCOLOR 1 FGCOLOR 7 FONT 6
     " CL.Status = Blank, O, P" VIEW-AS TEXT
          SIZE 24 BY .76 AT ROW 20.29 COL 4
          BGCOLOR 1 FGCOLOR 7 
     " NON MOTOR" VIEW-AS TEXT
          SIZE 25 BY .71 AT ROW 10.05 COL 79
          BGCOLOR 1 FGCOLOR 7 FONT 6
     RecBrowse AT ROW 2.29 COL 2.67
     RecProctyp AT ROW 8.95 COL 56.83
     recOutput AT ROW 16.57 COL 59.5
     RecOStyp AT ROW 16.48 COL 3.33
     RecOK AT ROW 18.33 COL 59.83
     RECT-99 AT ROW 16.48 COL 30.83
     RecProctyp-2 AT ROW 8.86 COL 81.5
     RECT-100 AT ROW 8.86 COL 3
     RECT-101 AT ROW 9.33 COL 45.5
     RECT-102 AT ROW 9.52 COL 75.17
     RECT-104 AT ROW 10.29 COL 11
     RECT-105 AT ROW 10.52 COL 12
     RECT-108 AT ROW 11 COL 47
     RECT-110 AT ROW 11 COL 78.5
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 12 ROW 2.76
         SIZE 110.5 BY 20.95
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
  CREATE WINDOW C-Win ASSIGN
         HIDDEN             = YES
         TITLE              = "<insert window title>"
         HEIGHT             = 23.71
         WIDTH              = 131.83
         MAX-HEIGHT         = 35.33
         MAX-WIDTH          = 170.67
         VIRTUAL-HEIGHT     = 35.33
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
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW C-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* REPARENT FRAME */
ASSIGN FRAME frReport:FRAME = FRAME DEFAULT-FRAME:HANDLE.

/* SETTINGS FOR FRAME DEFAULT-FRAME
                                                                        */
/* SETTINGS FOR FRAME frReport
   Custom                                                               */
/* BROWSE-TAB BROWSE-1 1 frReport */
/* SETTINGS FOR RADIO-SET rsProcTypN IN FRAME frReport
   NO-DISPLAY NO-ENABLE                                                 */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-1
/* Query rebuild information for BROWSE BROWSE-1
     _TblList          = "sicfn.acproc_fil"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _OrdList          = "sicfn.acproc_fil.asdat|no"
     _Where[1]         = "sicfn.acproc_fil.type = ""10"""
     _FldNameList[1]   = sicfn.acproc_fil.asdat
     _FldNameList[2]   > sicfn.acproc_fil.type
"acproc_fil.type" "Type" ? "character" ? ? ? ? ? ? no ? no no "3.5" yes no no "U" "" ""
     _FldNameList[3]   > sicfn.acproc_fil.typdesc
"acproc_fil.typdesc" "Process Desc." ? "character" ? ? ? ? ? ? no ? no no "23.33" yes no no "U" "" ""
     _FldNameList[4]   > sicfn.acproc_fil.trndatfr
"acproc_fil.trndatfr" "Trans.Date From" ? "date" ? ? ? ? ? ? no ? no no "14.83" yes no no "U" "" ""
     _FldNameList[5]   > sicfn.acproc_fil.trndatto
"acproc_fil.trndatto" "Trans.Date To" ? "date" ? ? ? ? ? ? no ? no no "14.33" yes no no "U" "" ""
     _FldNameList[6]   > sicfn.acproc_fil.entdat
"acproc_fil.entdat" ? ? "date" ? ? ? ? ? ? no ? no no "9.33" yes no no "U" "" ""
     _FldNameList[7]   = sicfn.acproc_fil.enttim
     _FldNameList[8]   = sicfn.acproc_fil.usrid
     _Query            is OPENED
*/  /* BROWSE BROWSE-1 */
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


&Scoped-define BROWSE-NAME BROWSE-1
&Scoped-define FRAME-NAME frReport
&Scoped-define SELF-NAME BROWSE-1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BROWSE-1 C-Win
ON VALUE-CHANGED OF BROWSE-1 IN FRAME frReport
DO:
  
  DO WITH FRAME frReport:
    IF NOT CAN-FIND(FIRST acproc_fil WHERE acproc_fil.type = "10") THEN DO:
        ASSIGN
            fiasdat = ?
            fiProcessdate = ?
            n_trndatto = ?
            n_asdat = fiasdat.
        DISP fiasdat fiProcessdate.
    END.
    ELSE DO:
        FIND CURRENT acproc_fil NO-LOCK.
        ASSIGN
            fiasdat = acproc_fil.asdat
            fiProcessdate = acproc_fil.entdat
            n_trndatto = acproc_fil.trndatto
            n_asdat = fiasdat
            nv_datfr = acproc_fil.trndatfr
            nv_datto = acproc_fil.trndatto.
        DISP fiasdat fiProcessdate .
    END.
  END. 

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buCancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buCancel C-Win
ON CHOOSE OF buCancel IN FRAME frReport /* Cancel */
DO:
    RUN wac\wacdisc9.
    APPLY "CLOSE" TO THIS-PROCEDURE.
    RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buOK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buOK C-Win
ON CHOOSE OF buOK IN FRAME frReport /* OK */
DO:
  
  IF nv_branfr = "" THEN DO:
     MESSAGE "Please Enter Branch From..." VIEW-AS ALERT-BOX.
     APPLY "ENTRY" TO fiBranFr.
     RETURN NO-APPLY.
  END.

  IF nv_branto = "" THEN DO:
     MESSAGE "Please Enter Branch To..." VIEW-AS ALERT-BOX.
     APPLY "ENTRY" TO fiBranTo.
     RETURN NO-APPLY.
  END.
  
  ASSIGN nv_output = n_output + ".txt"
         nv_output2 = n_output + "s" + ".txt"
         nv_Coutput = n_output + "c" + ".txt".   /*A51-0126*/

  MESSAGE "ทำการออกรายงาน ! " SKIP (1)
          "PROCESS OUTSTANDING CLAIM " SKIP(1)
           txtrep " " "(" txtpoltyp ")" SKIP(1)
          "วันที่ประมวลผลข้อมูล  : " STRING(n_asdat,"99/99/9999")  SKIP (1)
          "กรมธรรม์ตั้งแต่วันที่ : " STRING(nv_datfr,"99/99/9999") " ถึง " 
           STRING(nv_datto,"99/99/9999") SKIP (1)
          "ตั้งแต่สาขา : " nv_branfr "ถึงสาขา: " nv_branto 
  VIEW-AS ALERT-BOX QUESTION  BUTTONS YES-NO
  UPDATE CHOICE AS LOGICAL.
  CASE CHOICE:
       WHEN TRUE THEN DO:
         RUN pdHeader.
        
         MESSAGE "Printing Complete" VIEW-AS ALERT-BOX.
      
       END.
       WHEN FALSE THEN DO:

         RETURN NO-APPLY.

       END.
  END CASE.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiBranFr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiBranFr C-Win
ON LEAVE OF fiBranFr IN FRAME frReport
DO:
  ASSIGN nv_branfr = CAPS (INPUT fiBranfr).
  DISP nv_branfr @ fiBranfr WITH FRAME frReport.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiBranTo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiBranTo C-Win
ON LEAVE OF fiBranTo IN FRAME frReport
DO:
  ASSIGN nv_branto = CAPS (INPUT fiBranTo).
  DISP nv_branto @ fiBranTo WITH FRAME frReport.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiOutput
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiOutput C-Win
ON LEAVE OF fiOutput IN FRAME frReport
DO:
  ASSIGN n_output = INPUT fiOutput.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiPoltyp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiPoltyp C-Win
ON LEAVE OF fiPoltyp IN FRAME frReport
DO:

  ASSIGN n_poltyp = INPUT fiPoltyp.
         txtpoltyp = "".
  
  IF INPUT fiPoltyp <> "" THEN DO:
     ASSIGN n_poltyp = INPUT fiPoltyp.
     
     IF  LOOKUP(n_poltyp, "70,72,73,74,all") = 0 THEN DO:
         MESSAGE "This Line is not Motor" SKIP
                 "Please enter [70], [72], [73], [74] or [All] for Motor" 
         VIEW-AS ALERT-BOX.
         APPLY "ENTRY" TO fiPoltyp.
         RETURN NO-APPLY.
     END.
     txtpoltyp = INPUT fipoltyp.
  END.
  ELSE DO:
     IF INPUT fipoltyp = "" THEN DO:
        MESSAGE "Please enter Policy Type (70, 72, 73,74 or ALL)"
        VIEW-AS ALERT-BOX.
        APPLY "ENTRY" TO fipoltyp.
        RETURN NO-APPLY.
     END.
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME rsOSTyp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL rsOSTyp C-Win
ON VALUE-CHANGED OF rsOSTyp IN FRAME frReport
DO:
  ASSIGN n_ostyp = INPUT rsOSTyp.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME rsProcTyp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL rsProcTyp C-Win
ON VALUE-CHANGED OF rsProcTyp IN FRAME frReport
DO:
  ASSIGN n_report = INPUT rsProcTyp.
  IF n_report = 2 THEN DO:
     fipoltyp = "".
     DISP fipoltyp WITH FRAME frReport.
     DISABLE fiPoltyp WITH FRAME frReport.
     ENABLE rsProcTypN WITH FRAME frReport.
     txtrep = "Non Motor".
     APPLY "VALUE-CHANGED" TO rsProcTypN. 
  END.
  ELSE IF n_report = 1 THEN DO:
     DISABLE rsProcTypN WITH FRAME frReport.
     ENABLE fiPoltyp WITH FRAME frReport.
     txtrep = "Motor".
     APPLY "ENTRY" TO fipoltyp.
     RETURN NO-APPLY.
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME rsProcTypN
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL rsProcTypN C-Win
ON VALUE-CHANGED OF rsProcTypN IN FRAME frReport
DO:
    ASSIGN non_poltyp = INPUT rsProcTypN.
           txtpoltyp = INPUT rsProcTypN.

    IF non_poltyp = 1 THEN txtpoltyp = "Not Line 30, 01, 04".
    ELSE IF non_poltyp = 2 THEN txtpoltyp = "Only Line 30, 01, 04".
    ELSE txtpoltyp = "ALL".


END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME DEFAULT-FRAME
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

  SESSION:DATA-ENTRY-RETURN = YES.

  ASSIGN   fiasdat = acproc_fil.asdat
           fiPoltyp = "70"
           fiProcessdate = acproc_fil.entdat
           n_trndatto = acproc_fil.trndatto
           n_asdat = fiasdat
           nv_datfr = acproc_fil.trndatfr
           nv_datto = acproc_fil.trndatto
           n_report = 1
           n_poltyp = "70"
           non_poltyp = 1
           n_ostyp  = 1
           txtrep   = "Motor" 
           txtpoltyp = "70".

  DISP fiasdat fiPoltyp fiProcessdate WITH FRAME frReport.

  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE ChkLineExcel C-Win 
PROCEDURE ChkLineExcel :
/*------------------------------------------------------------------------------
Purpose:   Count  record เพื่อแยกไฟล์  หากเกิน  65500  limit ของ Excel    
Parameters:  <none>
Notes: Copy Program From: wacr0604.i    
------------------------------------------------------------------------------*/
DEF VAR cntop AS INT.

IF nv_reccnt > 65500 THEN  DO:
    ASSIGN
      cntop     = LENGTH(nv_output) - 4  /*-- ตัดชื่อ ==> XXXX1.txt --*/
      nv_next   = nv_next + 1
      nv_output = SUBSTR(nv_output,1,cntop) + STRING(nv_next) + ".txt"
      nv_reccnt = 0.

    IF n_report = 1  THEN DO:     /*---Motor---*/
       RUN pdPrnHeadermotor.
       nv_reccnt = nv_reccnt + 3.
    END.
    ELSE IF n_report = 2 THEN DO:   /*---Non Motor---*/
       RUN pdPrnHeaderNon.
       nv_reccnt = nv_reccnt + 3.
    END.

END.  

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE ChkLineExcel2 C-Win 
PROCEDURE ChkLineExcel2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR cntop2 AS INT.

IF nv_reccnt2 > 65500 THEN  DO:
    ASSIGN
      cntop2     = LENGTH(nv_output2) - 4  /*-- ตัดชื่อ ==> XXXX1.txt --*/
      nv_next2   = nv_next2 + 1
      nv_output2 = SUBSTR(nv_output2,1,cntop2) + STRING(nv_next2) + ".txt"
      nv_reccnt2 = 0.

    IF n_report = 1  THEN DO:     /*---Motor---*/
       RUN pdPrnHeadermotorS.
       nv_reccnt2 = nv_reccnt2 + 3.
    END.
    ELSE IF n_report = 2 THEN DO:   /*---Non Motor---*/
       RUN pdPrnHeaderNon.
       nv_reccnt2 = nv_reccnt2 + 3.
    END.

END.  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

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
  ENABLE IMAGE-21 IMAGE-23 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  DISPLAY rsProcTyp fiPoltyp rsOSTyp fiBranFr fiBranTo fiOutput fiAsdat 
          fiProcessDate 
      WITH FRAME frReport IN WINDOW C-Win.
  ENABLE BROWSE-1 rsProcTyp fiPoltyp rsOSTyp fiBranFr fiBranTo fiOutput buOK 
         buCancel fiAsdat fiProcessDate RecBrowse RecProctyp recOutput RecOStyp 
         RecOK RECT-99 RecProctyp-2 RECT-100 RECT-101 RECT-102 RECT-104 
         RECT-105 RECT-108 RECT-110 
      WITH FRAME frReport IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-frReport}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PdBdes C-Win 
PROCEDURE PdBdes :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*---
FIND FIRST xmm023 USE-INDEX xmm02301 WHERE n_br = xmm023.branch .
IF AVAIL xmm023 THEN DO:
   n_bdes = xmm023.bdes.
END.
Lukkana M. A53-0139 21/07/2010--*/

/*--Lukkana M. A53-0139 21/07/2010--*/
FIND FIRST xmm023 USE-INDEX xmm02301 WHERE xmm023.branch = n_br NO-LOCK NO-ERROR.
IF AVAIL xmm023 THEN DO:
   n_bdes = xmm023.bdes.
END.
/*--Lukkana M. A53-0139 21/07/2010--*/


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdClrValue C-Win 
PROCEDURE pdClrValue :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN nv_poldes  =  " "
       nv_name    =  " "
       nv_acno1   =  " "
       nv_cedclm  =  " "
       nv_prodnam =  " "
       nv_produc  =  " "
       nv_extnam  =  " "
       nv_exter   =  " "
       nv_extref  =  " "
       nv_wextref =  " "
                 
       nv_adjust  =  " "
       nv_adjusna =  " "
                 
       nv_police  =  " "
       nv_pacod   =  " ".

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdfindACNO C-Win 
PROCEDURE pdfindACNO :
/*------------------------------------------------------------------------------
  Purpose:   Find Account No., Adjustor, Cedding Claim, Default By, Comm.Date,
             Expire.Date, Insure Name, Cause of Loss, Notify No., Int.&Ext.Surveyor  
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN  nv_acno1    = ""
        nv_cedclm   = ""
        /*----A51-0102---*/
        nv_pacod    = ""
        nv_pades    = ""
        nv_pdcode   = ""
        nv_pdname   = "".
       /*---  A51-0102 ---*/
       

FIND FIRST clm100 USE-INDEX clm10001 WHERE
           clm100.claim = czm100.CLAIM NO-LOCK NO-ERROR NO-WAIT.
IF AVAIL  clm100 THEN DO:
   ASSIGN nv_acno1   = clm100.acno1        
          nv_police  = clm100.police
          nv_cedclm  = clm100.cedclm
          nv_name    = TRIM (Clm100.ntitle) + TRIM (Clm100.name1)
          nv_event   = clm100.event
          nv_defau   = clm100.defau
          nv_comdat  = clm100.comdat
          nv_expdat  = clm100.expdat
          nv_insurnam = TRIM(TRIM(clm100.ntitle) + " " + TRIM(clm100.name1))
          nv_loss1   = clm100.loss1.
   
    IF INDEX(nv_loss1,CHR(13)) <> 0 THEN DO:
        nv_loss1  = (SUBSTR(clm100.loss1,1,INDEX(clm100.loss1,CHR(13)))).
        nv_loss1  = SUBSTR(nv_loss1,1,LENGTH(nv_loss1) - 1).
    END.

    /*  claim paid text  */
    IF clm100.busreg <> "" THEN DO:
       FIND FIRST sym100 USE-INDEX sym10001 WHERE
                  sym100.tabcod = "U070"    AND
                  sym100.itmcod = clm100.busreg NO-LOCK NO-ERROR NO-WAIT.
       IF AVAIL sym100 THEN  DO:
          nv_pacod = sym100.itmcod.
          nv_pades = sym100.itmdes.
       END.
    END.
    /*--------------------*/
    
    IF clm100.agent <> "" THEN DO:
       FIND FIRST xmm600 USE-INDEX xmm60001  WHERE
                  xmm600.acno = clm100.agent NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL xmm600 THEN DO:
               nv_pdcode = xmm600.acno.
               nv_pdname = xmm600.name.
            END.
            ELSE DO:
               FIND FIRST xtm600 USE-INDEX xtm60001  WHERE
                          xtm600.acno = clm100.agent NO-LOCK NO-ERROR NO-WAIT.
               IF AVAIL xtm600 THEN DO:
                  nv_pdcode = xtm600.acno.
                  nv_pdname = xtm600.name.
               END.
            END.
    END.
END.

ASSIGN  nv_prodnam  = ""
        nv_produc   = ""
        nv_extcod   = ""
        nv_extnam   = ""           /*A51-0102*/
        nv_exter    = ""
        nv_wextref  = "".

FIND FIRST xtm600 USE-INDEX xtm60001 WHERE
           xtm600.acno = nv_acno1    NO-LOCK NO-ERROR NO-WAIT.
IF AVAIL xtm600 THEN DO:
   ASSIGN 
      nv_prodnam = TRIM(TRIM(xtm600.ntitle) + " " + TRIM(xtm600.name))
      nv_produc  = TRIM(TRIM(xtm600.ntitle) + " " + TRIM(xtm600.name)).
END.
ELSE DO:
   FIND FIRST xmm600 USE-INDEX xmm60001 WHERE xmm600.acno = nv_acno1
   NO-LOCK NO-ERROR NO-WAIT.
   IF AVAIL xmm600 THEN DO:
      ASSIGN 
         nv_prodnam = TRIM(TRIM(xmm600.ntitle) + " " + TRIM(xmm600.name))
         nv_produc  = TRIM(TRIM(xmm600.ntitle) + " " + TRIM(xmm600.name)).
         
   END.
   ELSE DO:
      ASSIGN  nv_prodnam  = ""
              nv_produc   = "".
   END.
END.

FIND FIRST clm120 USE-INDEX clm12001    WHERE
           clm120.claim = czm100.CLAIM  NO-LOCK NO-ERROR NO-WAIT.
IF AVAIL clm120 THEN DO:
   
   nv_wextref = clm120.extref.

   FIND FIRST xtm600 USE-INDEX xtm60001 WHERE
              xtm600.acno = nv_wextref  NO-LOCK NO-ERROR NO-WAIT.
   IF AVAIL xtm600 THEN DO:
      ASSIGN
         nv_extnam  = TRIM(TRIM(xtm600.ntitle) + " " + TRIM(xtm600.name))
         nv_exter   = TRIM(TRIM(xtm600.ntitle) + " " + TRIM(xtm600.name))
         nv_extcod = xtm600.acno.    /*A51-0102*/
   END.
   ELSE DO:
      FIND FIRST xmm600 USE-INDEX xmm60001 WHERE
                 xmm600.acno = nv_wextref  NO-LOCK NO-ERROR NO-WAIT.
      IF AVAIL xmm600 THEN DO:
         ASSIGN nv_extnam  = TRIM(TRIM(xmm600.ntitle) + " " + TRIM(xmm600.name))
                nv_exter   = TRIM(TRIM(xmm600.ntitle) + " " + TRIM(xmm600.name))
                nv_extcod = xmm600.acno.   /*A51-0102*/
      END.
      ELSE DO:
         ASSIGN  nv_extnam  = ""
                 nv_exter   = ""
                 nv_extcod  = "".   /*A51-0102*/
      END.

   END.

END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdfindCovcod C-Win 
PROCEDURE pdfindCovcod :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
  nv_covcod  = "".   /* A51-0102 */
  FIND FIRST uwm301  WHERE uwm301.policy = clm100.policy  AND
                           uwm301.rencnt = clm100.rencnt  AND
                           uwm301.endcnt = clm100.endcnt  AND
                           uwm301.riskno = clm100.riskno  AND
                           uwm301.itemno = clm100.itemno
     NO-LOCK NO-ERROR NO-WAIT.
     IF AVAIL uwm301 THEN   
        ASSIGN nv_covcod  =  uwm301.covcod.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdfindLoss C-Win 
PROCEDURE pdfindLoss :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
n_loss = "".

FIND clm120 USE-INDEX clm12001 WHERE clm120.claim  = czd101.claim  AND
                                     clm120.clmant = czd101.clmant AND
                                     clm120.clitem = czd101.clitem NO-ERROR.  /*เพิ่ม no-error Lukkana M. A53-0139 02/09/2010*/
IF AVAIL clm120 THEN DO:
        IF SUBSTR(czd101.claim,3,1) = "7" THEN n_loss = clm120.loss.
            /*IF CLM120.LOSS <> 'FE'  AND CLM120.LOSS  <>  'EX' THEN DO: Lukkana M. A53-0139 02/09/2010*/
               n_loss = clm120.loss.
            /*END. /* "FE" & "EX" */*/
        /*---A51-0126---*/
        IF SUBSTR(czd101.claim,3,2) = "70" AND 
           (n_loss = "IC" OR n_loss = "LC" OR
            n_loss = "LL" OR n_loss = "DB") THEN DO:

             ASSIGN cnt_comp = YES.
            
            OUTPUT TO VALUE (nv_Coutput) APPEND NO-ECHO.
            EXPORT DELIMITER ";"
             ""
             czm100.Branch    czm100.POLTYP    nv_poldes
             czm100.GRPTYP    czm100.CLAIM     nv_event
             czm100.POLICY    
             /*---
             czm100.VEHREG
             comment by Chaiyong W. A54-0112 12/12/2012*/
             czm100.VEHREG FORMAT "X(11)" /*---add by Chaiyong W. A54-0112 12/12/2012*/   
             nv_insurnam      nv_pdcode        nv_pdname 
             nv_comdat        nv_expdat        nv_renpol
             nv_covcod        nv_defau         nv_loss1
             n_loss           czd101.clmant    czd101.clitem 
             czm100.ENTDAT    czm100.LOSDAT    czm100.NOTDAT  
             czm100.ENTDAT    czd101.osres     
             ""               ""               nv_nacod
             nv_nades         nv_pacod         nv_pades
             czd101.paidamt   czd101.paiddat   nv_police  
             nv_adjusna       nv_extcod        nv_extnam        
             nv_cedclm        czm100.DOCST. 
          OUTPUT CLOSE.

          
             /*FIND FIRST wfcpoltyp WHERE wfcpoltyp.wfcpbr = SUBSTR(czd101.claim,2,1) AND Lukkana M. A53-0139 22/07/2010*/
             FIND FIRST wfcpoltyp WHERE wfcpoltyp.wfcpbr = nv_br1 AND /*Lukkana M. A53-0139 22/07/2010*/
                                        wfcpoltyp.wfctyp = substr(czd101.claim,1,1) NO-ERROR.
             IF NOT AVAIL wfcpoltyp THEN 
             CREATE wfcpoltyp.
             /*ASSIGN wfcpoltyp.wfcpbr = SUBSTR(czd101.claim,2,1) Lukkana M. A53-0139 22/07/2010*/
             ASSIGN wfcpoltyp.wfcpbr = nv_br1 /*Lukkana M. A53-0139 22/07/2010*/
                    wfcpoltyp.wfctyp = SUBSTR(czd101.claim,1,1)
                    wfcpoltyp.wfcpres  = wfcpoltyp.wfcpres + czd101.osres
                    wfcpoltyp.wfcppaid = wfcpoltyp.wfcppaid + czd101.paidamt.
                   /* wfcpoltyp.wfcpcnt  = wfcpoltyp.wfcpcnt + 1.*/
         
          
          END.
          /*--end A51-0126---*/
        
END.   /* clm120*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdfindRenpol C-Win 
PROCEDURE pdfindRenpol :
/*------------------------------------------------------------------------------
  Purpose: Find Renew Policy    
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
  nv_renpol = "" .    /* A51-0102 */
  FIND FIRST uwm100  WHERE uwm100.policy = clm100.policy  AND
                           uwm100.rencnt = clm100.rencnt  AND
                           uwm100.endcnt = clm100.endcnt
  NO-LOCK NO-ERROR NO-WAIT.
  IF AVAIL uwm100  THEN  nv_renpol  =  uwm100.renpol.
     
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdHeader C-Win 
PROCEDURE pdHeader :
/*------------------------------------------------------------------------------
  Purpose: Check Report Type (Motor/Non motor)     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
IF n_report = 1 THEN DO:
   IF n_poltyp <> "ALL" THEN DO:
      ASSIGN poltyp = n_poltyp.
      RUN pdPrnHeaderComp.    /*A51-0126*/
      RUN pdPrnHeaderMotor.
      RUN pdPrnHeaderMotorS.
      nv_reccnt = nv_reccnt + 3.
      RUN pdPrnMotor. 
   END.
   ELSE DO:
      RUN pdPrnHeaderComp.    /*A51-0126*/
      RUN pdPrnHeaderMotor.
      RUN pdPrnHeaderMotorS.
      nv_reccnt = nv_reccnt + 3.
      RUN pdPrnAllMotor.
   END.
END.
ELSE DO:
        RUN pdPrnHeaderNon. 
        nv_reccnt = nv_reccnt + 3.
        RUN pdPrnNonmotor.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdItemCode C-Win 
PROCEDURE pdItemCode :
/*------------------------------------------------------------------------------
  Purpose: Find Text Code Claim   
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*--- A51-0102 ---*/
ASSIGN nv_nacod  = ""
       nv_nades  = "".
/*-------------------*/

FOR EACH clm120 USE-INDEX clm12001     WHERE
         clm120.claim  = clm100.claim  AND 
         clm120.clmant = czd101.clmant AND 
         clm120.clitem = czd101.clitem NO-LOCK 
BREAK BY clm120.claim BY clm120.clmant BY clm120.clitem:

    IF clm120.bencod <> "" THEN DO:
          FIND FIRST sym100 USE-INDEX sym10001 WHERE
                     sym100.tabcod = "U070"    AND
                     sym100.itmcod = clm120.bencod NO-LOCK NO-ERROR.
          IF AVAIL sym100 THEN DO:
             nv_nacod = sym100.itmcod.
             nv_nades = sym100.itmdes.
          END.
    END.
    
END. /* Loop2 clm120 */


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdPrnAllMotor C-Win 
PROCEDURE pdPrnAllMotor :
/*------------------------------------------------------------------------------
  Purpose:   Print Report Motor - All (70, 72, 73, 74)  
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH wfpoltyp NO-LOCK:
    DELETE wfpoltyp.
END.
FOR EACH wfbranch NO-LOCK:
    DELETE wfbranch.
END.
FOR EACH wftbranch NO-LOCK:
    DELETE wftbranch.
END.
FOR EACH wfcpoltyp NO-LOCK:
    DELETE wfcpoltyp.
END.
FOR EACH wfcbranch NO-LOCK:
    DELETE wfcbranch.
END.
FOR EACH wfctbranch NO-LOCK:
    DELETE wfctbranch.
END.
FOR EACH wfcnt NO-LOCK:
    DELETE wfcnt.
END.
DEF VAR nv_amt19  AS DECI. /*Lukkana M. A53-0139 03/09/2010*/
DEF VAR nv_amt20  AS DECI. /*Lukkana M. A53-0139 03/09/2010*/

ASSIGN nv_reccnt = 0       nv_reccnt2 = 0
       nv_next   = 1       nv_next2   = 1
       wt_cnt    = 0       wg_cnt     = 0.

loop_czm100:
  FOR EACH czm100  USE-INDEX czm10002 WHERE 
           czm100.ASDAT = n_asdat     AND 
           czm100.BRANCH >= nv_branfr AND
           czm100.BRANCH <= nv_branto AND 
           SUBSTR(czm100.POLTYP,2,1) = "7" NO-LOCK
  BREAK BY czm100.BRANCH                   BY SUBSTR(czm100.POLTYP,2,2)
        BY SUBSTR(czm100.CLAIM,1,1)        BY czm100.CLAIM : 

        DISP czm100.claim WITH NO-LABEL TITLE "Printing Report..."
        FRAME a VIEW-AS DIALOG-BOX.
        
        RUN pdfindRenpol.   /*Find RenPol*/
        RUN pdfindCovcod.   /*Find CovCod*/
       
        IF FIRST-OF (czm100.BRANCH) THEN DO:
           nv_nbran = czm100.BRANCH.
           RUN pd_nbran.
        END.

        IF FIRST-OF (SUBSTRING (czm100.poltyp,2,2)) THEN DO:
           FIND Xmm031 USE-INDEX Xmm03101 WHERE 
                Xmm031.poltyp = czm100.POLTYP NO-LOCK NO-ERROR.
           nv_ntype = IF AVAILABLE Xmm031 THEN Xmm031.poldes
                      ELSE "!!! Not found (" + TRIM (czm100.POLTYP) + ")".
        END. /*--- FIRST-OF (czm100.poltyp) ---*/
       
        IF czm100.POLTYP  = " " THEN NEXT loop_czm100.
       
        FIND XMM031 USE-INDEX XMM03101 WHERE 
             XMM031.POLTYP = czm100.POLTYP NO-LOCK NO-ERROR.
             nv_poldes = IF AVAILABLE XMM031 THEN XMM031.POLDES
                         ELSE "!!! Not found (" + TRIM (czm100.POLTYP) + ")".

        FIND Xmm600 USE-INDEX Xmm60001 WHERE
             Xmm600.acno = czm100.INTREF NO-LOCK NO-ERROR NO-WAIT.
        IF AVAILABLE xmm600 THEN 
           ASSIGN nv_adjust = TRIM(Xmm600.ntitle) + TRIM(Xmm600.name)
                  nv_adjusna = TRIM(TRIM(Xmm600.ntitle) + TRIM(Xmm600.name)).  
        ELSE ASSIGN  nv_adjust = ""
                     nv_adjusna = "".

        RUN pdFindACNO.
        
        IF n_ostyp = 1 THEN DO:
           IF czm100.OS <= 0 THEN NEXT loop_czm100.
        END.
        ELSE DO:
            IF czm100.OS < 0 THEN NEXT loop_czm100. /*Lukkana M. A53-0139 03/09/2010 OS ติดลบไม่ต้องแสดงออกมา*/
        END.
       
        FOR EACH czd101 USE-INDEX czd10101  WHERE
                 czd101.asdat = czm100.asdat AND
                 czd101.claim = czm100.claim NO-LOCK
        BREAK BY SUBSTR(czd101.claim,1,1) BY SUBSTR(czd101.claim,2,1)
              BY SUBSTR(czd101.claim,3,2) BY czd101.claim:

              /*-Lukkana M. A53-0139 21/07/2010--*/
              nv_br1 = "".
              IF SUBSTR(czd101.claim,1,2) >= "10" AND
                 SUBSTR(czd101.claim,1,2) <= "99" THEN nv_br1 = SUBSTR(czd101.claim,1,2).
              ELSE nv_br1 = SUBSTR(czd101.claim,2,1).
              
              /*--Lukkana M. A53-0139 21/07/2010--*/
              
              RUN pdItemCode.     /*Find ItemCode*/

              /* A51-0102 */
              RUN pdfindLoss.     /*Find Nature of Loss*/ 

              /*--
              IF n_ostyp = 1 THEN DO:
                 IF czd101.osres <= 0 THEN NEXT.
              END.
              Lukkana m. A53-0139 03/09/2010*/

              /*-Lukkana M. A53-0139 21/07/2010--*/
              IF n_ostyp = 1 THEN DO:
                  IF n_loss <> 'FE'  AND n_loss  <>  'EX' THEN IF czd101.osres  <= 0 THEN NEXT .   
              END.
              /*-Lukkana M. A53-0139 21/07/2010--*/
              
              IF FIRST-OF (czd101.claim) THEN DO: 
                 ASSIGN wt_cnt     =  wt_cnt + 1   /*Claim Count*/
                        wg_cnt     =  wg_cnt + 1.  /*Grand Claim Count*/

                 /*---A51-0126---*/
                 IF SUBSTR(czd101.claim,3,2) = "70" AND cnt_comp = YES THEN DO:
                    ASSIGN nc_cnt = nc_cnt + 1.
                    
                 /*FIND FIRST wfcompcnt WHERE wfcompcnt.wfcompcnt_br = SUBSTR(czd101.claim,2,1) NO-ERROR. Lukkana M. A53-0139 21/07/2010--*/
                 FIND FIRST wfcompcnt WHERE wfcompcnt.wfcompcnt_br = nv_br1 NO-ERROR. /*Lukkana M. A53-0139 21/07/2010--*/
                   IF NOT AVAIL wfcompcnt THEN DO:
                      CREATE wfcompcnt.
                      /*ASSIGN wfcompcnt.wfcompcnt_br = SUBSTR(czd101.claim,2,1). Lukkana M. A53-0139 21/07/2010--*/
                      ASSIGN wfcompcnt.wfcompcnt_br = nv_br1. /*Lukkana M. A53-0139 21/07/2010--*/
                   END.
                   ASSIGN wfcompcnt.wfcompcnt_cnt = wfcompcnt.wfcompcnt_cnt + 1
                          wfcompcnt.wfcompcnt_res = wfcompcnt.wfcompcnt_res + czd101.osres
                          wfcompcnt.wfcompcnt_paid = wfcompcnt.wfcompcnt_paid + czd101.paidamt.
                 END.
                    cnt_comp = NO.
                 /*------------*/
                 /*Lukkana M. A53-0139 03/09/2010*/
                 IF n_loss <> 'FE'  AND n_loss  <>  'EX' THEN  
                     ASSIGN  nv_amt19  = 0
                             nv_amt20  = czd101.osres .
                 ELSE ASSIGN nv_amt19  = czm100.amt[19] 
                             nv_amt20  = czm100.amt[19].
                 /*Lukkana M. A53-0139 03/09/2010*/

                 RUN ChkLineExcel.
                 OUTPUT TO VALUE (nv_output) APPEND NO-ECHO.
                 EXPORT DELIMITER ";"
                     wt_cnt
                     czm100.Branch    czm100.POLTYP    nv_poldes
                     czm100.GRPTYP    czm100.CLAIM     nv_event
                     czm100.POLICY    
                     /*---
                     czm100.VEHREG 
                     comment by Chaiyong W. A54-0112 12/12/2012*/
                     czm100.VEHREG FORMAT "X(11)" /*---add by Chaiyong W. A54-0112 12/12/2012*/  
                     nv_insurnam      nv_pdcode        nv_pdname 
                     nv_comdat        nv_expdat        nv_renpol
                     nv_covcod        nv_defau         nv_loss1
                     czm100.LOSS      czd101.clmant    czd101.clitem 
                     czm100.ENTDAT    czm100.LOSDAT    czm100.NOTDAT  
                     czm100.ENTDAT    czd101.osres
                     nv_AMT19         nv_AMT20   /*Lukkana M. A53-0139 30/08/2010*/
                     ""               ""               nv_nacod
                     nv_nades         nv_pacod         nv_pades
                     czd101.paidamt   czd101.paiddat   nv_police  
                     nv_adjusna       nv_extnam        nv_cedclm
                     czm100.DOCST. 
                 OUTPUT CLOSE.
                 nv_reccnt = nv_reccnt + 1.

                 /*--- By Branch ---*/
                 /*FIND FIRST wfcnt WHERE wfcnt.cntbranch = SUBSTR(czd101.claim,2,1) NO-ERROR. Lukkana M. A53-0139 21/07/2010--*/
                 FIND FIRST wfcnt WHERE wfcnt.cntbranch = nv_br1 NO-ERROR. /*Lukkana M. A53-0139 21/07/2010--*/
                 IF NOT AVAIL wfcnt THEN CREATE wfcnt.
                 
                 /*ASSIGN wfcnt.cntbranch = SUBSTR(czd101.claim,2,1) Lukkana M. A53-0139 21/07/2010--*/
                 ASSIGN wfcnt.cntbranch = nv_br1  /*Lukkana M. A53-0139 21/07/2010--*/
                        wfcnt.reccnt    = wfcnt.reccnt + 1.
                 
                 /*----------------*/

              END.    /*First-of czd101.claim for count record*/
              ELSE DO:
                 /*Lukkana M. A53-0139 03/09/2010*/
                 IF n_loss <> 'FE'  AND n_loss  <>  'EX' THEN  
                     ASSIGN  nv_amt19  = 0
                             nv_amt20  = czd101.osres .
                 ELSE ASSIGN nv_amt19  = czm100.amt[19] 
                             nv_amt20  = czm100.amt[19].
                 /*Lukkana M. A53-0139 03/09/2010*/

                 RUN ChkLineExcel.
                 OUTPUT TO VALUE (nv_output) APPEND NO-ECHO.
                 EXPORT DELIMITER ";"
                     "" 
                     czm100.Branch    czm100.POLTYP    nv_poldes
                     czm100.GRPTYP    czm100.CLAIM     nv_event
                     czm100.POLICY    
                     /*----
                     czm100.VEHREG
                     comment by Chaiyong W. A54-0112 12/12/2012*/
                     czm100.VEHREG FORMAT "X(11)" /*---add by Chaiyong W. A54-0112 12/12/2012*/   
                     nv_insurnam      nv_pdcode        nv_pdname 
                     nv_comdat        nv_expdat        nv_renpol
                     nv_covcod        nv_defau         nv_loss1
                     czm100.LOSS      czd101.clmant    czd101.clitem 
                     czm100.ENTDAT    czm100.LOSDAT    czm100.NOTDAT  
                     czm100.ENTDAT    czd101.osres 
                     nv_AMT19         nv_AMT20   /*Lukkana M. A53-0139 30/08/2010*/
                     ""               ""               nv_nacod
                     nv_nades         nv_pacod         nv_pades
                     czd101.paidamt   czd101.paiddat   nv_police  
                     nv_adjusna       nv_extnam        nv_cedclm
                     czm100.DOCST. 
                 OUTPUT CLOSE.
                 nv_reccnt = nv_reccnt + 1.
              END. /*else do:*/

              CREATE wfpoltyp.    
              /*ASSIGN wfpoltyp.wfpbr = SUBSTR(czd101.claim,2,1) Lukkana M. A53-0139 21/07/2010--*/
              ASSIGN wfpoltyp.wfpbr = nv_br1 /*Lukkana M. A53-0139 21/07/2010--*/
                     wfpoltyp.wftyp = SUBSTR(czd101.claim,1,1)
                     wfpoltyp.wfline = SUBSTR(czd101.claim,3,2)
                     wfpoltyp.wfpres  = wfpoltyp.wfpres + czd101.osres
                     wfpoltyp.wfppaid = wfpoltyp.wfppaid + czd101.paidamt.

              ASSIGN nv_sumos   = nv_sumos + czd101.osres
                     nv_sumpaid = nv_sumpaid + czd101.paidamt.

             
        END. /*Each czd101*/

        IF LAST-OF (czm100.branch) THEN DO:
           wt_cnt = 0.
        END.

        RUN pdPrnSMotor.

        RUN pdClrValue.
  END. /* Each czm100 */
  
  /*--Detail--*/  
  RUN ChkLineExcel.
  OUTPUT TO VALUE (nv_output) APPEND NO-ECHO.
  EXPORT DELIMITER ";" "".
  EXPORT DELIMITER ";"
        "Total By D/I" 
        "" "" "" "" "" "" "" "" "" "" "" ""
        "" "" "" "" "" "" "" "" "" "" "" ""  
        "O/S Claim" "" "" "" "" "" "" "" ""
        "Paid Amount".
  OUTPUT CLOSE.
  nv_reccnt = nv_reccnt + 2.
  /*--Sum--*/
  RUN ChkLineExcel2.
  OUTPUT TO VALUE (nv_output2) APPEND NO-ECHO.
  EXPORT DELIMITER ";" "".
  EXPORT DELIMITER ";"
        "Total By D/I" 
        "" "" "" "" "" "" "" "" "" "" 
        "" "" "" "" "" "" "" "" "" "" 
        "O/S Claim" "" "" "" "" "" "" "" ""
        "Paid Amount".
  OUTPUT CLOSE. 
  nv_reccnt2 = nv_reccnt2 + 2.

  FOR EACH wfpoltyp BREAK BY wfpoltyp.wftyp BY wfpoltyp.wfpbr  BY wfpoltyp.wfline :
       /*--Detail--*/
       ASSIGN n_os = n_os + wfpoltyp.wfpres
              n_paid = n_paid + wfpoltyp.wfppaid.

      /* IF LAST-OF (wfpoltyp.wftyp)  THEN DO:*/
       IF LAST-OF (wfpoltyp.wfline)  THEN DO:
          n_br = wfpoltyp.wfpbr.
          RUN pdbdes.
          RUN ChkLineExcel.
          OUTPUT TO VALUE (nv_output) APPEND NO-ECHO. 
          EXPORT DELIMITER ";"
              ""
              wfpoltyp.wftyp + " - " + wfpoltyp.wfpbr + " - " + wfpoltyp.wfline
              n_bdes "" "" "" "" "" "" "" "" "" ""
              "" "" "" "" "" "" "" "" "" "" "" ""
              n_os  "" "" "" "" "" "" "" ""
              n_paid.
          OUTPUT CLOSE.
          nv_reccnt = nv_reccnt + 1.
          /*--Sum--*/
          RUN ChkLineExcel2.
          OUTPUT TO VALUE (nv_output2) APPEND NO-ECHO. 
          EXPORT DELIMITER ";"
              "" 
              wfpoltyp.wftyp + " - " + wfpoltyp.wfpbr + " - " + wfpoltyp.wfline
              n_bdes "" "" "" "" "" "" "" "" "" 
              "" "" "" "" "" "" "" "" ""
              n_os  "" "" "" "" "" "" "" ""
              n_paid.
          OUTPUT CLOSE.
          nv_reccnt2 = + nv_reccnt2 + 1.
          
          ASSIGN n_bosres = n_bosres + n_os
                 n_bpaid  = n_bpaid + n_paid
                 n_os     = 0
                 n_paid   = 0.
       END.

       IF LAST-OF (wfpoltyp.wfline) THEN DO:
           CREATE wfbranch.
           ASSIGN wfbranch.wfbr = wfpoltyp.wfpbr
                  wfbranch.wfbline = wfpoltyp.wfline
                  wfbranch.wfbres =  n_bosres
                  wfbranch.wfbpaid = n_bpaid
                  n_bosres = 0
                  n_bpaid  = 0.
       END.

  END.

  FOR EACH wfbranch BREAK BY wfbranch.wfbr BY wfbranch.wfbline:

    ASSIGN n_tosres = n_tosres + wfbranch.wfbres
           n_tpaid  = n_tpaid + wfbranch.wfbpaid. 

    IF LAST-OF (wfbranch.wfbr) THEN DO:
       CREATE wftbranch.
       ASSIGN wftbranch.wftbr = wfbranch.wfbr
              wftbranch.wftbres = n_tosres
              wftbranch.wftbpaid = n_tpaid
              n_tosres = 0
              n_tpaid = 0. 
    END.
  END.
  
  /*--Detail--*/ 
  RUN ChkLineExcel.
  OUTPUT TO VALUE (nv_output) APPEND NO-ECHO. 
  EXPORT DELIMITER ";"
      "".
  EXPORT DELIMITER ";"
  "Total By Branch" "" "" "" "" "" "" "" "" ""
  "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" 
  "O/S Claim" "" "" "" "" "" "" "" "" 
  "Paid Amount".
  OUTPUT CLOSE.
  nv_reccnt = nv_reccnt + 2.
  /*--Sum--*/
  RUN ChkLineExcel2.
  OUTPUT TO VALUE (nv_output2) APPEND NO-ECHO. 
  EXPORT DELIMITER ";"
      "".
  EXPORT DELIMITER ";"
  "Total By Branch" ""
  "" "" "" "" "" "" "" "" "" ""  
  "" "" "" "" "" "" "" "" ""
  "O/S Claim" "" "" "" "" "" "" "" ""
  "Paid Amount".
  OUTPUT CLOSE.
  nv_reccnt2 = nv_reccnt2 + 2.

  FOR EACH wftbranch BREAK BY wftbranch.wftbr:
      n_br = wftbranch.wftbr.
      RUN pdbdes.
      /*--Detail--*/
      RUN ChkLineExcel.
      OUTPUT TO VALUE (nv_output) APPEND NO-ECHO. 
      EXPORT DELIMITER ";"
        "" 
        "Total Branch: " + wftbranch.wftbr  
        n_bdes "" "" "" "" "" "" "" "" "" ""
        "" "" "" "" "" "" "" "" "" "" "" ""
        wftbranch.wftbres "" "" "" "" "" "" "" ""
        wftbranch.wftbpaid.
      OUTPUT CLOSE.
      nv_reccnt = nv_reccnt + 1.
      /*--Sum--*/
      RUN ChkLineExcel2.
      OUTPUT TO VALUE (nv_output2) APPEND NO-ECHO. 
      EXPORT DELIMITER ";"
        "" 
        "Total Branch: " + wftbranch.wftbr 
        n_bdes "" "" "" "" "" "" "" "" ""  
        "" "" "" "" "" "" "" "" ""
        wftbranch.wftbres "" "" "" "" "" "" "" ""
        wftbranch.wftbpaid.
      OUTPUT CLOSE.
      nv_reccnt2 = nv_reccnt2 + 1.
      ASSIGN n_gosres = n_gosres + wftbranch.wftbres
             n_gpaid  = n_gpaid  + wftbranch.wftbpaid.
  END.
  /*--Detail--*/
  RUN ChkLineExcel.
  OUTPUT TO VALUE (nv_output) APPEND NO-ECHO. 
  EXPORT DELIMITER ";"
    "".
  EXPORT DELIMITER ";"
    "GrandTotal By Branch" "" ""
    "" "" "" "" "" "" "" "" "" "" ""
    "" "" "" "" "" "" "" "" "" "" "" 
    n_gosres "" "" "" "" "" "" "" ""
    n_gpaid.
  OUTPUT CLOSE.
  nv_reccnt = nv_reccnt + 2.
  /*--Sum--*/
  RUN ChkLineExcel2.
  OUTPUT TO VALUE (nv_output2) APPEND NO-ECHO. 
  EXPORT DELIMITER ";"
    "".
  EXPORT DELIMITER ";"
    "GrandTotal By Branch" 
    "" "" "" "" "" "" "" "" "" ""
    "" "" "" "" "" "" "" "" "" ""
    n_gosres "" "" "" "" "" "" "" ""
    n_gpaid.
  OUTPUT CLOSE.
  nv_reccnt2 = nv_reccnt2 + 2.

  ASSIGN n_gosres = 0
         n_gpaid  = 0.
  /*Detail*/
  RUN ChkLineExcel.
  OUTPUT TO VALUE (nv_output) APPEND NO-ECHO. 
  EXPORT DELIMITER ";"
    "".
  EXPORT DELIMITER ";" 
    "Count By Branch:" "" 
    "Count Claim".
    OUTPUT CLOSE.
  nv_reccnt = nv_reccnt + 2.
  /*Summary*/
  RUN ChkLineExcel2.
  OUTPUT TO VALUE (nv_output2) APPEND NO-ECHO. 
  EXPORT DELIMITER ";"
    "".
  EXPORT DELIMITER ";" 
    "Count By Branch:" ""
    "Count Claim".
    OUTPUT CLOSE.
  nv_reccnt2 = nv_reccnt2 + 2.

  FOR EACH wfcnt NO-LOCK:
      n_br = wfcnt.cntbranch.
      RUN pdbdes.
      /*Detail*/
      RUN ChkLineExcel.
      OUTPUT TO VALUE (nv_output) APPEND NO-ECHO. 
      EXPORT DELIMITER ";"
        "Branch: " + wfcnt.cntbranch 
        n_bdes
        wfcnt.reccnt.
      OUTPUT CLOSE.
      nv_reccnt = nv_reccnt + 1.
      /*Summary*/
      RUN ChkLineExcel2.
      OUTPUT TO VALUE (nv_output2) APPEND NO-ECHO. 
      EXPORT DELIMITER ";"
        "Branch: " + wfcnt.cntbranch 
        n_bdes
        wfcnt.reccnt.
      OUTPUT CLOSE.
      nv_reccnt2 = nv_reccnt2 + 1.
  END.
  /*Detail*/
  RUN ChkLineExcel.
  OUTPUT TO VALUE (nv_output) APPEND NO-ECHO. 
  EXPORT DELIMITER ";" 
    "Total Claim: " "" 
    wg_cnt.
  OUTPUT CLOSE.
  nv_reccnt = nv_reccnt + 1.
  /*Summary*/
  RUN ChkLineExcel2.
  OUTPUT TO VALUE (nv_output2) APPEND NO-ECHO. 
  EXPORT DELIMITER ";" 
    "Total Claim: " "" 
    wg_cnt.
  OUTPUT CLOSE.
  nv_reccnt2 = nv_reccnt2 + 1.

RUN pdPrnComp.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdPrnComp C-Win 
PROCEDURE pdPrnComp :
/*------------------------------------------------------------------------------
  Purpose:  Print Report for Motor V70 and Nature = IC, LC, LL, DB   
  Parameters:  <none>
  Notes:       Coutput  = Compulsory File  xxxC.txt
                output2 = Summary File xxxS.txt
------------------------------------------------------------------------------*/
RUN ChkLineExcel.
/*Detail*/
/*---A51-0126
OUTPUT TO VALUE (nv_output) APPEND NO-ECHO. 
---end A51-0126*/

/*----------------By A51-0126  Header-------------*/
OUTPUT TO VALUE (nv_Coutput) APPEND NO-ECHO. 
EXPORT DELIMITER ";"
  "".
EXPORT DELIMITER ";"
  "COMPULSARY (Nature of Loss for Line 70 = IC, LC, LL, DB)"
  "" "" "" "" "" "" "" "" "" "" "" "" 
  "" "" "" "" "" 
  "" "" "" "" "" "" ""  "O/S Claim"
  "" "" "" "" "" "" "Paid Amount".
OUTPUT CLOSE.
nv_reccnt = nv_reccnt + 2.

/*Sum*/
RUN ChkLineExcel2.
OUTPUT TO VALUE (nv_output2) APPEND NO-ECHO. 
EXPORT DELIMITER ";"
  "".
EXPORT DELIMITER ";"
  "COMPULSARY (Nature of Loss for Line 70 = IC, LC, LL, DB)" "" ""
  "" "" "" "" "" "" "" "" ""
  "" "" "" "" "" "" "" "" ""
  "O/S Claim"  
  "" "" "" "" "" ""
  "Paid Amount".
OUTPUT CLOSE.
nv_reccnt2 = nv_reccnt2 + 2.
/*------end Header Summary ---------------------*/
    
FOR EACH wfcpoltyp BREAK BY wfcpoltyp.wfcpbr BY wfcpoltyp.wfctyp:
    n_br = wfcpoltyp.wfcpbr.
    RUN pdbdes.
    /*--Detail--*/
    RUN ChkLineExcel.
    /*---A51-0126
    OUTPUT TO VALUE (nv_output) APPEND NO-ECHO. 
    -----*/
    /*---A51-0126---*/
    /*nb_cnt = nb_cnt + nc_cnt.*/
   

    OUTPUT TO VALUE (nv_Coutput) APPEND NO-ECHO. 
    EXPORT DELIMITER ";"
       "Total Comp Branch: " + wfcpoltyp.wfctyp + "-" + wfcpoltyp.wfcpbr 
       n_bdes
       ""
       "" "" "" "" "" "" "" "" "" "" ""
       "" "" "" "" "" "" "" "" "" "" ""
       wfcpoltyp.wfcpres
       "" "" "" "" "" ""
       wfcpoltyp.wfcppaid.
    OUTPUT CLOSE.
    nct_cnt = nct_cnt + nc_cnt.
    nv_reccnt = nv_reccnt + 1.

    /*--Sum--*/
    RUN ChkLineExcel2.
    OUTPUT TO VALUE (nv_output2) APPEND NO-ECHO. 
    EXPORT DELIMITER ";"
       "Total Comp Branch: " + wfcpoltyp.wfctyp + "-" + wfcpoltyp.wfcpbr
       n_bdes
       ""
       "" "" "" "" "" "" "" "" ""
       "" "" "" "" "" "" "" "" ""
       wfcpoltyp.wfcpres  
       "" "" "" "" "" ""
       wfcpoltyp.wfcppaid.
    OUTPUT CLOSE.
    nv_reccnt2 = nv_reccnt2 + 1.

    ASSIGN n_cosres = n_cosres + wfcpoltyp.wfcpres
           n_cpaid  = n_cpaid + wfcpoltyp.wfcppaid.
    
END.

/*---A51-0126
OUTPUT TO VALUE (nv_output) APPEND NO-ECHO. 
---*/
/*---A51-0126---*/
OUTPUT TO VALUE (nv_Coutput) APPEND NO-ECHO. 
RUN ChkLineExcel.
/*Detail*/
EXPORT DELIMITER ";"
   "".
EXPORT DELIMITER ";"
   "Grand Total Compulsary : " "" 
   "" "" "" "" "" "" "" "" "" "" "" 
   ""  "" "" "" "" "" "" "" "" "" "" "" 
   n_cosres  
   "" "" "" "" "" ""
   n_cpaid.
OUTPUT CLOSE.
nv_reccnt = nv_reccnt + 2.
/*Sum*/
RUN ChkLineExcel2.
OUTPUT TO VALUE (nv_output2) APPEND NO-ECHO. 
EXPORT DELIMITER ";"
   "".
EXPORT DELIMITER ";"
   "Grand Total Compulsary : " "" 
    "" "" "" "" "" "" "" "" ""
   "" ""  "" "" "" "" "" "" "" "" 
   n_cosres "" "" "" "" "" ""
   n_cpaid.
OUTPUT CLOSE.
nv_reccnt2 = nv_reccnt2 + 2.

OUTPUT TO VALUE (nv_Coutput) APPEND NO-ECHO.
    EXPORT DELIMITER ";" "".
    EXPORT DELIMITER ";" "Count Claims".
OUTPUT CLOSE.

OUTPUT TO VALUE (nv_output2) APPEND NO-ECHO.
    EXPORT DELIMITER ";" "".
    EXPORT DELIMITER ";" "Count Claims".
OUTPUT CLOSE.

FOR EACH wfcompcnt BREAK BY wfcompcnt_br.
    OUTPUT TO VALUE (nv_Coutput) APPEND NO-ECHO. 
    EXPORT DELIMITER ";"
        "Count Claim Branch: " + wfcompcnt_br
        wfcompcnt_cnt.
    OUTPUT CLOSE.

    OUTPUT TO VALUE (nv_output2) APPEND NO-ECHO. 
    EXPORT DELIMITER ";"
        "Count Claim Branch: " + wfcompcnt_br
        wfcompcnt_cnt.
        OUTPUT CLOSE.
        nct_cnt  = wfcompcnt.wfcompcnt_cnt.
        nctg_cnt = nctg_cnt + nct_cnt.
        nct_cnt = 0.
END.


OUTPUT TO VALUE (nv_Coutput) APPEND NO-ECHO. 
RUN ChkLineExcel.
/*Detail*/
EXPORT DELIMITER ";"
   "".
EXPORT DELIMITER ";"
   "CountTotal Claim-Compulsary : " 
    nctg_cnt.
OUTPUT CLOSE.

OUTPUT TO VALUE (nv_output2) APPEND NO-ECHO. 
RUN ChkLineExcel.
/*Detail*/
EXPORT DELIMITER ";"
   "".
EXPORT DELIMITER ";"
   "CountTotal Claim-Compulsary : " 
    nctg_cnt.
OUTPUT CLOSE.

ASSIGN  n_cosres = 0     n_cpaid = 0    n_ccnt = 0  nc_cnt = 0. 
nct_cnt = 0.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdPrnHeaderComp C-Win 
PROCEDURE pdPrnHeaderComp :
/*------------------------------------------------------------------------------
  Purpose:  Print Header For Report Motor (Detail and Summary)   
  Parameters:  <none>
  Notes:        A51-0126 
------------------------------------------------------------------------------*/

/*--- Detail Report ---*/
OUTPUT TO VALUE (nv_Coutput) APPEND NO-ECHO.
EXPORT DELIMITER ";"
            "As of Date:  " 
            n_asdat FORMAT "99/99/9999"
            "" "" ""
            "Safety Insurance Public Company Limited"
            "" "" ""
            STRING(TIME,"HH:MM:SS").
 EXPORT DELIMITER ";"
            "RUNNING OF ENTRY DATE FROM : " nv_datfr FORMAT "99/99/9999" 
            " TO " nv_datto FORMAT "99/99/9999"
            ""
            "LIST OF OUTSTANDING CLAIM - MOTOR <DETAIL> " 
            "Line " + n_poltyp
            "(SYS : WACROSCL.W)"  
            "" "".
 EXPORT DELIMITER ";"
            "Count"
            "BRANCH"       
            "Policy Type"    
            "Policy Desc"
            "Group"             
            "Claim No." 
            "Notify No."
            "Policy No."
            "License"
            "Insure Name"
            "Producer Code"
            "Producer Name"
            "Comm. Date"
            "Expiry Date"
            "Renew Policy"
            "Cover Type"
            "Default By"
            "Cause of Loss"
            "Nature of Loss"
            "Clmant"
            "Clitem"
            "Entry Date"
            "Loss Date"         
            "Notify Date"
            "Open Date"        
            "O/S Claim"
            "Fac RI."
            "RET."
            "Text Code N."
            "Nature Comment"
            "Text Code Claim"  
            "Claim Comment"
            "Paid Amount"
            "Paid Date"
            "Accept By" 
            "Internal Surveyor"
            "External Code"       /*A51-0102*/
            "External Surveyor"
            "Ceding Claim No."
            "Document Status".
 OUTPUT CLOSE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdPrnHeaderMotor C-Win 
PROCEDURE pdPrnHeaderMotor :
/*------------------------------------------------------------------------------
  Purpose:  Print Header For Report Motor (Detail and Summary)   
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*--- Detail Report ---*/
OUTPUT TO VALUE (nv_output) APPEND NO-ECHO.
EXPORT DELIMITER ";"
            "As of Date:  " 
            n_asdat FORMAT "99/99/9999"
            "" "" ""
            "Safety Insurance Public Company Limited"
            "" "" ""
            STRING(TIME,"HH:MM:SS").
 EXPORT DELIMITER ";"
            "RUNNING OF ENTRY DATE FROM : " nv_datfr FORMAT "99/99/9999" 
            " TO " nv_datto FORMAT "99/99/9999"
            ""
            "LIST OF OUTSTANDING CLAIM - MOTOR <DETAIL> " 
            "Line " + n_poltyp
            "(SYS : WACROSCL.W)"  
            "" "".
 EXPORT DELIMITER ";"
            "Count"
            "BRANCH"       
            "Policy Type"    
            "Policy Desc"
            "Group"             
            "Claim No." 
            "Notify No."
            "Policy No."
            "License"
            "Insure Name"
            "Producer Code"
            "Producer Name"
            "Comm. Date"
            "Expiry Date"
            "Renew Policy"
            "Cover Type"
            "Default By"
            "Cause of Loss"
            "Nature of Loss"
            "Clmant"
            "Clitem"
            "Entry Date"
            "Loss Date"         
            "Notify Date"
            "Open Date"        
            "O/S Claim"
            "Survey Fee"    /*Lukkana M. A53-0139 30/08/2010*/
            "Total Gross"   /*Lukkana M. A53-0139 30/08/2010*/
            "Fac RI."
            "RET."
            "Text Code N."
            "Nature Comment"
            "Text Code Claim"  
            "Claim Comment"
            "Paid Amount"
            "Paid Date"
            "Accept By" 
            "Internal Surveyor"
            "External Code"       /*A51-0102*/
            "External Surveyor"
            "Ceding Claim No."
            "Document Status".
 OUTPUT CLOSE.

 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdPrnHeaderMotorS C-Win 
PROCEDURE pdPrnHeaderMotorS :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*--- Summary Report ---*/
 OUTPUT TO VALUE (nv_output2) APPEND NO-ECHO.
 EXPORT DELIMITER ";"
            "As of Date:  " 
            n_asdat FORMAT "99/99/9999"
            "" "" ""
            "Safety Insurance Public Company Limited"
            "" "" ""
            STRING(TIME,"HH:MM:SS").
 EXPORT DELIMITER ";"
            "<SUMMARY>"
            "LIST OF OUTSTANDING CLAIM - MOTOR"
            "Line " + n_poltyp
            "(SYS : WACROSCL.W)"  
            "" ""
            "RUNNING OF ENTRY DATE FROM : " nv_datfr FORMAT "99/99/9999" 
            " TO " nv_datto FORMAT "99/99/9999".
 EXPORT DELIMITER ";"
            "BRANCH"       
            "Policy Type"    
            "Policy Desc"
            "Group"             
            "Claim No." 
            "Notify No."
            "Policy No."
            "License"
            "Insure Name"
            "Producer Code"
            "Producer Name"
            "Comm. Date"
            "Expiry Date"
            "Renew Policy"
            "Cover Type"
            "Default By"
            "Cause of Loss"
            "Entry Date"
            "Loss Date"         
            "Notify Date"
            "Open Date"        
            "O/S Claim"
            "Survey Fee"    /*Lukkana M. A53-0139 30/08/2010*/
            "Total Gross"   /*Lukkana M. A53-0139 30/08/2010*/ 
            "Fac RI."
            "RET."
            "Text Code N."
            "Nature Comment"
            "Text Code Claim"  
            "Claim Comment"
            "Paid Amount"
            "Accept By" 
            "Internal Surveyor"
            "External Surveyor"
            "Ceding Claim No."
            "Document Status".
 OUTPUT CLOSE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdPrnHeaderNon C-Win 
PROCEDURE pdPrnHeaderNon :
/*------------------------------------------------------------------------------
  Purpose:  check Non motor Report and Print Header for Non Motor    
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
IF non_poltyp = 5 THEN n_txt = "NOT 30, 01, 04".
ELSE IF non_poltyp = 6 THEN n_txt = "ONLY 30, 01, 04".
ELSE IF non_poltyp = 7 THEN n_txt = "All".

 OUTPUT TO VALUE (nv_output) APPEND NO-ECHO.
 EXPORT DELIMITER ";"
        "As of Date:  " 
        n_asdat FORMAT "99/99/9999"
        "" "" ""
        "Safety Insurance Public Company Limited"
        "" "" ""
        STRING(TIME,"HH:MM:SS").

 EXPORT DELIMITER ";"
        "RUNNING OF ENTRY DATE FROM : " nv_datfr FORMAT "99/99/9999" 
        " TO " nv_datto FORMAT "99/99/9999"
        ""
        "LIST OF OUTSTANDING CLAIM - NON MOTOR " 
        n_txt 
        "(SYS : WACROSCL.W)". 

 EXPORT DELIMITER ";"
        "BRANCH"       
        "Line"    
        "Type" 
        "Group"             
        "Claim No."    
        "Entry Date"        
        "Notify Date"       
        "Loss Date"         
        "Open Date"         
        "Policy No."
        "Insure Name"  
        "Nature of Loss" 
        "O/S Claim"  
        "Survey Fee"    /*Lukkana M. A53-0139 30/08/2010*/
        "Total Gross"   /*Lukkana M. A53-0139 30/08/2010*/
        "1st.TREATY"   
        "2nd.TREATY"      
        "FAC.RI."      
        "Q.S.5%"       
        "TFP"          
        "MPS" 
        "ENG.FAC."     
        "MARINE O/P"   
        "R.Q."         
        "BTR"          
        "OTR"          
        "FTR"
        "F/O I"        
        "F/O II"       
        "F/O III"      
        "F/O IV"
        "GROSS RET."   
        "XOL"          
        "CO%"          
        "CO SI"        
        "Adjustor"   
        "Int. Surveyor Name" 
        "Ext. Surveyor Name" 
        "Producer Name"
        "Ceding Claim no."   
        "Text code Claim"  
        "Claim comment "
        "Document Status".
 OUTPUT CLOSE.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PdPrnMotor C-Win 
PROCEDURE PdPrnMotor :
/*------------------------------------------------------------------------------
  Purpose:  Print Report for Motor   
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH wfpoltyp NO-LOCK:
    DELETE wfpoltyp.
END.
FOR EACH wfbranch NO-LOCK:
    DELETE wfbranch.
END.
FOR EACH wftbranch NO-LOCK:
    DELETE wftbranch.
END.
FOR EACH wfcpoltyp NO-LOCK:
    DELETE wfcpoltyp.
END.
FOR EACH wfcbranch NO-LOCK:
    DELETE wfcbranch.
END.
FOR EACH wfctbranch NO-LOCK:
    DELETE wfctbranch.
END.
FOR EACH wfcnt NO-LOCK:
    DELETE wfcnt.
END.
DEF VAR nv_amt19  AS DECI. /*Lukkana M. A53-0139 03/09/2010*/
DEF VAR nv_amt20  AS DECI. /*Lukkana M. A53-0139 03/09/2010*/

ASSIGN nv_reccnt = 0       nv_reccnt2 = 0
       nv_next   = 1       nv_next2   = 1
       wt_cnt    = 0       wg_cnt     = 0.

loop_czm100:
  FOR EACH czm100  USE-INDEX czm10002 WHERE 
           czm100.ASDAT = n_asdat     AND 
           czm100.BRANCH >= nv_branfr AND
           czm100.BRANCH <= nv_branto AND 
           SUBSTR(czm100.POLTYP,2,2) = poltyp NO-LOCK
  BREAK BY czm100.BRANCH                   BY SUBSTR(czm100.POLTYP,2,2)
        BY SUBSTR(czm100.CLAIM,1,1)        BY czm100.CLAIM : 

        DISP czm100.claim WITH NO-LABEL TITLE "Printing Report..."
        FRAME a VIEW-AS DIALOG-BOX.
        
        RUN pdfindRenpol.   /*Find RenPol*/
        RUN pdfindCovcod.   /*Find CovCod*/ 
        
        IF FIRST-OF (czm100.BRANCH) THEN DO:
           wt_cnt = 0.
           nv_nbran = czm100.BRANCH.
           RUN pd_nbran.
        END.

        IF FIRST-OF (SUBSTRING (czm100.poltyp,2,2)) THEN DO:
           FIND Xmm031 USE-INDEX Xmm03101 WHERE 
                Xmm031.poltyp = czm100.POLTYP NO-LOCK NO-ERROR.
           nv_ntype = IF AVAILABLE Xmm031 THEN Xmm031.poldes
                      ELSE "!!! Not found (" + TRIM (czm100.POLTYP) + ")".
        END. /*--- FIRST-OF (czm100.poltyp) ---*/
       
        IF czm100.POLTYP  = " " THEN NEXT loop_czm100.
       
        FIND XMM031 USE-INDEX XMM03101 WHERE 
             XMM031.POLTYP = czm100.POLTYP NO-LOCK NO-ERROR.
             nv_poldes = IF AVAILABLE XMM031 THEN XMM031.POLDES
                         ELSE "!!! Not found (" + TRIM (czm100.POLTYP) + ")".

        FIND Xmm600 USE-INDEX Xmm60001 WHERE
             Xmm600.acno = czm100.INTREF NO-LOCK NO-ERROR NO-WAIT.
        IF AVAILABLE xmm600 THEN 
           ASSIGN nv_adjust = TRIM(Xmm600.ntitle) + TRIM(Xmm600.name)
                  nv_adjusna = TRIM(TRIM(Xmm600.ntitle) + TRIM(Xmm600.name)).  
        ELSE ASSIGN  nv_adjust = ""
                     nv_adjusna = "".

        RUN pdFindACNO.
        
        IF n_ostyp = 1 THEN DO:
           IF czm100.OS <= 0 THEN NEXT loop_czm100.
        END.
        ELSE DO:
            IF czm100.OS < 0 THEN NEXT loop_czm100. /*Lukkana M. A53-0139 03/09/2010 OS ติดลบไม่ต้องแสดงออกมา*/
        END.
        
        FOR EACH czd101 USE-INDEX czd10101  WHERE
                 czd101.asdat = czm100.asdat AND
                 czd101.claim = czm100.claim NO-LOCK
        BREAK BY SUBSTR(czd101.claim,1,1) BY SUBSTR(czd101.claim,2,1)
              BY SUBSTR(czd101.claim,3,2) BY czd101.claim:

             /*---
             IF czd101.osres = 0 THEN NEXT loop_czm100.    /* A51-0102 */
             Lukkana M. A53-0139 21/07/2010--*/

             nv_br1 = "".
             IF SUBSTR(czd101.claim,1,2) >= "10" AND
                SUBSTR(czd101.claim,1,2) <= "99" THEN nv_br1 = SUBSTR(czd101.claim,1,2).
             ELSE nv_br1 = SUBSTR(czd101.claim,2,1).
             /*--Lukkana M. A53-0139 21/07/2010--*/

             RUN pdItemCode.     /*Find ItemCode*/

             /* A51-0102 */
             RUN pdfindLoss.     /*Find Nature of Loss*/  

             IF n_loss <> 'FE'  AND n_loss  <>  'EX' THEN IF czd101.osres = 0 THEN NEXT .   /*-Lukkana M. A53-0139 21/07/2010--*/
             
            /*-------72,73,74 Nature ต้องเป็น DB,IC,LC,LL,SF เท่านั้น -------*/
             IF LOOKUP(SUBSTR(czd101.claim,3,2),"72,73,74") <> 0  THEN DO:
                IF LOOKUP(n_loss,"DB,IC,LC,LL,SF") = 0 THEN DO:
                   IF czd101.osres <= 0 THEN NEXT.
                END.
             END.
             /*----end A51-0102------*/
             
             IF FIRST-OF (czd101.claim) THEN DO: 
                 ASSIGN wt_cnt  =  wt_cnt + 1   /*Claim Count*/
                        wg_cnt  =  wg_cnt + 1.  /*Grand Claim Count*/
                 
                 /*---A51-0126---*/
                 IF SUBSTR(czd101.claim,3,2) = "70" AND cnt_comp = YES THEN DO:
                    ASSIGN nc_cnt = nc_cnt + 1.
                    
                 /*FIND FIRST wfcompcnt WHERE wfcompcnt.wfcompcnt_br = SUBSTR(czd101.claim,2,1) NO-ERROR. Lukkana M. A53-0139 22/07/2010*/
                   FIND FIRST wfcompcnt WHERE wfcompcnt.wfcompcnt_br = nv_br1 NO-ERROR. /*-Lukkana M. A53-0139 22/07/2010*/
                   IF NOT AVAIL wfcompcnt THEN DO:
                      CREATE wfcompcnt.
                      /*ASSIGN wfcompcnt.wfcompcnt_br = SUBSTR(czd101.claim,2,1). Lukkana M. A53-0139 22/07/2010*/
                      ASSIGN wfcompcnt.wfcompcnt_br = nv_br1 . /*Lukkana M. A53-0139 22/07/2010*/
                   END.
                   ASSIGN wfcompcnt.wfcompcnt_cnt = wfcompcnt.wfcompcnt_cnt + 1
                          wfcompcnt.wfcompcnt_res = wfcompcnt.wfcompcnt_res + czd101.osres
                          wfcompcnt.wfcompcnt_paid = wfcompcnt.wfcompcnt_paid + czd101.paidamt.
                   
                 END.
                    cnt_comp = NO.
                 /*------------*/
                 /*Lukkana M. A53-0139 03/09/2010*/
                 IF n_loss <> 'FE'  AND n_loss  <>  'EX' THEN  
                     ASSIGN  nv_amt19  = 0
                             nv_amt20  = czd101.osres .
                 ELSE ASSIGN nv_amt19  = czm100.amt[19] 
                             nv_amt20  = czm100.amt[19].
                 /*Lukkana M. A53-0139 03/09/2010*/

                 RUN ChkLineExcel.
                 OUTPUT TO VALUE (nv_output) APPEND NO-ECHO.
                 EXPORT DELIMITER ";"
                     wt_cnt
                     czm100.Branch    czm100.POLTYP    nv_poldes
                     czm100.GRPTYP    czm100.CLAIM     nv_event
                     czm100.POLICY    
                     /*---
                     czm100.VEHREG
                     comment by Chaiyong W. A54-0112 12/12/2012*/
                     czm100.VEHREG FORMAT "X(11)" /*---add by Chaiyong W. A54-0112 12/12/2012*/   
                     nv_insurnam      nv_pdcode        nv_pdname 
                     nv_comdat        nv_expdat        nv_renpol
                     nv_covcod        nv_defau         nv_loss1
                     /*czm100.LOSS---A51-0102---*/
                     n_loss           czd101.clmant    czd101.clitem 
                     czm100.ENTDAT    czm100.LOSDAT    czm100.NOTDAT  
                     czm100.ENTDAT    czd101.osres     
                     nv_AMT19         nv_AMT20   /*Lukkana M. A53-0139 30/08/2010*/
                     ""               ""               nv_nacod
                     nv_nades         nv_pacod         nv_pades
                     czd101.paidamt   czd101.paiddat   nv_police  
                     nv_adjusna       nv_extcod        nv_extnam        
                     nv_cedclm        czm100.DOCST. 
                 OUTPUT CLOSE.
                 nv_reccnt = nv_reccnt + 1.

                 /*--- By Branch ---*/
                 /*FIND FIRST wfcnt WHERE wfcnt.cntbranch = SUBSTR(czd101.claim,2,1) NO-ERROR. Lukkana M. A53-0139 22/07/2010*/
                 FIND FIRST wfcnt WHERE wfcnt.cntbranch = nv_br1 NO-ERROR. /*Lukkana M. A53-0139 22/07/2010*/
                 IF NOT AVAIL wfcnt THEN DO: 
                    CREATE wfcnt.
                    /*ASSIGN  wfcnt.cntbranch = SUBSTR(czd101.claim,2,1). Lukkana M. A53-0139 22/07/2010*/
                    ASSIGN  wfcnt.cntbranch = nv_br1. /*Lukkana M. A53-0139 22/07/2010*/
                 END.
                 ASSIGN  wfcnt.reccnt    = wfcnt.reccnt + 1.
                 /*----------------*/
                    

              END.    /*First-of czd101.claim for count record*/
              ELSE DO:
                 /*Lukkana M. A53-0139 03/09/2010*/
                 IF n_loss <> 'FE'  AND n_loss  <>  'EX' THEN  
                     ASSIGN  nv_amt19  = 0
                             nv_amt20  = czd101.osres .
                 ELSE ASSIGN nv_amt19  = czm100.amt[19] 
                             nv_amt20  = czm100.amt[19].
                 /*Lukkana M. A53-0139 03/09/2010*/

                 RUN ChkLineExcel.
                 OUTPUT TO VALUE (nv_output) APPEND NO-ECHO.
                 EXPORT DELIMITER ";"
                     "" 
                     czm100.Branch    czm100.POLTYP    nv_poldes
                     czm100.GRPTYP    czm100.CLAIM     nv_event
                     czm100.POLICY    
                     /*---
                     czm100.VEHREG
                     comment by Chaiyong W. A54-0112 12/12/2012*/
                     czm100.VEHREG FORMAT "X(11)" /*---add by Chaiyong W. A54-0112 12/12/2012*/
                        
                     nv_insurnam      nv_pdcode        nv_pdname 
                     nv_comdat        nv_expdat        nv_renpol
                     nv_covcod        nv_defau         nv_loss1
                     /*czm100.LOSS  ---A51-0102---*/
                     n_loss           czd101.clmant    czd101.clitem 
                     czm100.ENTDAT    czm100.LOSDAT    czm100.NOTDAT  
                     czm100.ENTDAT    czd101.osres     
                     nv_AMT19         nv_AMT20   /*Lukkana M. A53-0139 30/08/2010*/
                     ""               ""               nv_nacod
                     nv_nades         nv_pacod         nv_pades
                     czd101.paidamt   czd101.paiddat   nv_police  
                     nv_adjusna       nv_extcod        nv_extnam        
                     nv_cedclm        czm100.DOCST. 
                 OUTPUT CLOSE.
                 nv_reccnt = nv_reccnt + 1.
              END. /*else do:*/
             

              CREATE wfpoltyp.    
              ASSIGN /*wfpoltyp.wfpbr = SUBSTR(czd101.claim,2,1) Lukkana M. A53-0139 22/07/2010*/
                     wfpoltyp.wfpbr = nv_br1 /*Lukkana M. A53-0139 22/07/2010*/
                     wfpoltyp.wftyp = SUBSTR(czd101.claim,1,1)
                     wfpoltyp.wfline = SUBSTR(czd101.claim,3,2)
                     wfpoltyp.wfpres  = wfpoltyp.wfpres + czd101.osres
                     wfpoltyp.wfppaid = wfpoltyp.wfppaid + czd101.paidamt.
              
              ASSIGN nv_sumos   = nv_sumos + czd101.osres
                     nv_sumpaid = nv_sumpaid + czd101.paidamt.
              
        END. /*Each czd101*/

        IF LAST-OF (czm100.branch) THEN DO:
           wt_cnt = 0.
        END.

        RUN pdPrnSMotor.

        RUN pdClrValue.
  END. /* Each czm100 */
  
  /*--Detail--*/  
  RUN ChkLineExcel.
  OUTPUT TO VALUE (nv_output) APPEND NO-ECHO.
  EXPORT DELIMITER ";" "".
  EXPORT DELIMITER ";"
        "Total By D/I" 
        "" "" "" "" "" "" "" "" "" "" "" ""
        "" "" "" "" "" "" "" "" "" "" "" ""  
        "O/S Claim" "" "" "" "" "" "" "" "" 
        "Paid Amount".
  OUTPUT CLOSE.
  nv_reccnt = nv_reccnt + 2.
  /*--Sum--*/
  RUN ChkLineExcel2.
  OUTPUT TO VALUE (nv_output2) APPEND NO-ECHO.
  EXPORT DELIMITER ";" "".
  EXPORT DELIMITER ";"
        "Total By D/I" 
        "" "" "" "" "" "" "" "" "" "" 
        "" "" "" "" "" "" "" "" "" "" 
        "O/S Claim" "" "" "" "" "" "" "" ""
        "Paid Amount".
  OUTPUT CLOSE. 
  nv_reccnt2 = nv_reccnt2 + 2.

  FOR EACH wfpoltyp BREAK BY wfpoltyp.wftyp BY wfpoltyp.wfpbr  BY wfpoltyp.wfline :
       /*--Detail--*/
       ASSIGN n_os = n_os + wfpoltyp.wfpres
              n_paid = n_paid + wfpoltyp.wfppaid.

      /* IF LAST-OF (wfpoltyp.wftyp)  THEN DO:*/
       IF LAST-OF (wfpoltyp.wfline)  THEN DO:
          n_br = wfpoltyp.wfpbr.
          RUN pdbdes.
          RUN ChkLineExcel.
          OUTPUT TO VALUE (nv_output) APPEND NO-ECHO. 
          EXPORT DELIMITER ";"
              ""
              wfpoltyp.wftyp + " - " + wfpoltyp.wfpbr + " - " + wfpoltyp.wfline
              n_bdes "" "" "" "" "" "" "" "" "" ""
              "" "" "" "" "" "" "" "" "" "" "" ""
              n_os  "" "" "" "" "" "" "" ""
              n_paid.
          OUTPUT CLOSE.
          nv_reccnt = nv_reccnt + 1.
          /*--Sum--*/
          RUN ChkLineExcel2.
          OUTPUT TO VALUE (nv_output2) APPEND NO-ECHO. 
          EXPORT DELIMITER ";"
              "" 
              wfpoltyp.wftyp + " - " + wfpoltyp.wfpbr + " - " + wfpoltyp.wfline
              n_bdes "" "" "" "" "" "" "" "" "" 
              "" "" "" "" "" "" "" "" ""
              n_os  "" "" "" "" "" "" "" ""
              n_paid.
          OUTPUT CLOSE.
          nv_reccnt2 = + nv_reccnt2 + 1.
          
          ASSIGN n_bosres = n_bosres + n_os
                 n_bpaid  = n_bpaid + n_paid
                 n_os     = 0
                 n_paid   = 0.
       END.

       IF LAST-OF (wfpoltyp.wfline) THEN DO:
           CREATE wfbranch.
           ASSIGN wfbranch.wfbr = wfpoltyp.wfpbr
                  wfbranch.wfbline = wfpoltyp.wfline
                  wfbranch.wfbres =  n_bosres
                  wfbranch.wfbpaid = n_bpaid
                  n_bosres = 0
                  n_bpaid  = 0.
       END.

  END.

  FOR EACH wfbranch BREAK BY wfbranch.wfbr BY wfbranch.wfbline:

    ASSIGN n_tosres = n_tosres + wfbranch.wfbres
           n_tpaid  = n_tpaid + wfbranch.wfbpaid. 

    IF LAST-OF (wfbranch.wfbr) THEN DO:
       CREATE wftbranch.
       ASSIGN wftbranch.wftbr = wfbranch.wfbr
              wftbranch.wftbres = n_tosres
              wftbranch.wftbpaid = n_tpaid
              n_tosres = 0
              n_tpaid = 0. 
    END.
  END.
  
  /*--Detail--*/ 
  RUN ChkLineExcel.
  OUTPUT TO VALUE (nv_output) APPEND NO-ECHO. 
  EXPORT DELIMITER ";"
      "".
  EXPORT DELIMITER ";"
  "Total By Branch" "" "" "" "" "" "" "" "" ""
  "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" 
  "O/S Claim" "" "" "" "" "" "" "" "" 
  "Paid Amount".
  OUTPUT CLOSE.
  nv_reccnt = nv_reccnt + 2.
  /*--Sum--*/
  RUN ChkLineExcel2.
  OUTPUT TO VALUE (nv_output2) APPEND NO-ECHO. 
  EXPORT DELIMITER ";"
      "".
  EXPORT DELIMITER ";"
  "Total By Branch" ""
  "" "" "" "" "" "" "" "" "" ""  
  "" "" "" "" "" "" "" "" ""
  "O/S Claim" "" "" "" "" "" "" "" ""
  "Paid Amount".
  OUTPUT CLOSE.
  nv_reccnt2 = nv_reccnt2 + 2.

  FOR EACH wftbranch BREAK BY wftbranch.wftbr:
      n_br = wftbranch.wftbr.
      RUN pdbdes.
      /*--Detail--*/
      RUN ChkLineExcel.
      OUTPUT TO VALUE (nv_output) APPEND NO-ECHO. 
      EXPORT DELIMITER ";"
        "" 
        "Total Branch: " + wftbranch.wftbr  
        n_bdes "" "" "" "" "" "" "" "" "" ""
        "" "" "" "" "" "" "" "" "" "" "" ""
        wftbranch.wftbres "" "" "" "" "" "" "" "" 
        wftbranch.wftbpaid.
      OUTPUT CLOSE.
      nv_reccnt = nv_reccnt + 1.
      /*--Sum--*/
      RUN ChkLineExcel2.
      OUTPUT TO VALUE (nv_output2) APPEND NO-ECHO. 
      EXPORT DELIMITER ";"
        "" 
        "Total Branch: " + wftbranch.wftbr 
        n_bdes "" "" "" "" "" "" "" "" ""  
        "" "" "" "" "" "" "" "" ""
        wftbranch.wftbres "" "" "" "" "" "" "" ""
        wftbranch.wftbpaid.
      OUTPUT CLOSE.
      nv_reccnt2 = nv_reccnt2 + 1.
      ASSIGN n_gosres = n_gosres + wftbranch.wftbres
             n_gpaid  = n_gpaid  + wftbranch.wftbpaid.
  END.
  /*--Detail--*/
  RUN ChkLineExcel.
  OUTPUT TO VALUE (nv_output) APPEND NO-ECHO. 
  EXPORT DELIMITER ";"
    "".
  EXPORT DELIMITER ";"
    "GrandTotal By Branch" "" ""
    "" "" "" "" "" "" "" "" "" "" ""
    "" "" "" "" "" "" "" "" "" "" "" 
    n_gosres "" "" "" "" "" "" "" ""
    n_gpaid.
  OUTPUT CLOSE.
  nv_reccnt = nv_reccnt + 2.
  /*--Sum--*/
  RUN ChkLineExcel2.
  OUTPUT TO VALUE (nv_output2) APPEND NO-ECHO. 
  EXPORT DELIMITER ";"
    "".
  EXPORT DELIMITER ";"
    "GrandTotal By Branch" 
    "" "" "" "" "" "" "" "" "" ""
    "" "" "" "" "" "" "" "" "" ""
    n_gosres "" "" "" "" "" "" "" "" 
    n_gpaid.
  OUTPUT CLOSE.
  nv_reccnt2 = nv_reccnt2 + 2.

  ASSIGN n_gosres = 0
         n_gpaid  = 0.
  /*Detail*/
  RUN ChkLineExcel.
  OUTPUT TO VALUE (nv_output) APPEND NO-ECHO. 
  EXPORT DELIMITER ";"
    "".
  EXPORT DELIMITER ";" 
    "Count By Branch:" "" 
    "Count Claim".
    OUTPUT CLOSE.
  nv_reccnt = nv_reccnt + 2.
  /*Summary*/
  RUN ChkLineExcel2.
  OUTPUT TO VALUE (nv_output2) APPEND NO-ECHO. 
  EXPORT DELIMITER ";"
    "".
  EXPORT DELIMITER ";" 
    "Count By Branch:" ""
    "Count Claim".
    OUTPUT CLOSE.
  nv_reccnt2 = nv_reccnt2 + 2.

  FOR EACH wfcnt NO-LOCK:
      n_br = wfcnt.cntbranch.
      RUN pdbdes.
      /*Detail*/
      RUN ChkLineExcel.
      OUTPUT TO VALUE (nv_output) APPEND NO-ECHO. 
      EXPORT DELIMITER ";"
        "Branch: " + wfcnt.cntbranch 
        n_bdes
        wfcnt.reccnt.
      OUTPUT CLOSE.
      nv_reccnt = nv_reccnt + 1.
      /*Summary*/
      RUN ChkLineExcel2.
      OUTPUT TO VALUE (nv_output2) APPEND NO-ECHO. 
      EXPORT DELIMITER ";"
        "Branch: " + wfcnt.cntbranch 
        n_bdes
        wfcnt.reccnt.
      OUTPUT CLOSE.
      nv_reccnt2 = nv_reccnt2 + 1.
  END.
  /*Detail*/
  RUN ChkLineExcel.
  OUTPUT TO VALUE (nv_output) APPEND NO-ECHO. 
  EXPORT DELIMITER ";" 
    "Total Claim: " "" 
    wg_cnt.
  OUTPUT CLOSE.
  nv_reccnt = nv_reccnt + 1.
  /*Summary*/
  RUN ChkLineExcel2.
  OUTPUT TO VALUE (nv_output2) APPEND NO-ECHO. 
  EXPORT DELIMITER ";" 
    "Total Claim: " "" 
    wg_cnt.
  OUTPUT CLOSE.
  nv_reccnt2 = nv_reccnt2 + 1.

RUN pdPrnComp.
  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdPrnNonMotor C-Win 
PROCEDURE pdPrnNonMotor :
/*------------------------------------------------------------------------------
  Purpose: Print Non Motor Report     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

ASSIGN nv_reccnt = 0
       nv_next   = 1.
loop_czm100:
FOR EACH CZM100  USE-INDEX CZM10002 WHERE 
         CZM100.ASDAT = n_asdat     AND 
         CZM100.BRANCH >= nv_branfr AND
         CZM100.BRANCH <= nv_branto NO-LOCK
BREAK BY CZM100.BRANCH 
      BY SUBSTR(CZM100.POLTYP,2,2)
      BY SUBSTR(CZM100.CLAIM,1,1)
      BY CZM100.CLAIM:

      ASSIGN nv_asdat  = CZM100.ASDAT
             nv_claim  = CZM100.CLAIM
             nv_chkLine = NO.

      IF non_poltyp = 1 THEN DO: /*Non-Motor All But Not 30,01,04*/
         IF (SUBSTR(czm100.POLTYP,2,1) = "7"  OR   
             czm100.POLTYP  = "M30"  OR  /*CMIP*/
             czm100.POLTYP  = "M01"  OR  /*CMIP*/
             czm100.POLTYP  = "M04"  OR  /*CMIP*/
             czm100.POLTYP  = "  ") THEN NEXT loop_czm100.
      END.
      ELSE IF non_poltyp = 2 THEN DO:  /*30,01,04 Only*/
          IF (czm100.POLTYP  <>  "M01"  AND
              czm100.POLTYP  <>  "M04"  AND
              czm100.POLTYP  <>  "M30") THEN NEXT loop_czm100.
      END.
      ELSE IF non_poltyp = 3 THEN DO:
          IF (SUBSTR(czm100.POLTYP,2,1) = "7" OR /*Non-motor all*/
              czm100.POLTYP  = " ") THEN NEXT loop_czm100.
      END.
      ELSE DO:
          IF czm100.POLTYP  = "" THEN NEXT loop_czm100.
      END.
       
      DISP czm100.claim WITH NO-LABEL TITLE "Printing Report..."
      FRAME a VIEW-AS DIALOG-BOX.

      IF FIRST-OF (CZM100.BRANCH) THEN DO:
         nv_nbran = CZM100.BRANCH.
         RUN pd_nbran.
      END.

      IF FIRST-OF (SUBSTR(CZM100.POLTYP,2,2)) THEN DO:
         FIND XMM031 USE-INDEX XMM03101 WHERE XMM031.POLTYP = CZM100.POLTYP  
         NO-LOCK NO-ERROR.
         nv_ntype = IF AVAIL XMM031 THEN XMM031.POLDES
                    ELSE "!!! Not found (" + TRIM(CZM100.POLTYP) + ")".
      END. /*FIRST-OF (CZM100.POLTYP)*/
    
      IF FIRST-OF (SUBSTR(CZM100.CLAIM,1,1)) THEN DO:
        FIND FIRST WCZM100 WHERE WCZM100.WFPOLTYP = SUBSTR(CZM100.POLTYP,2,2) AND
                   WCZM100.WFDI = SUBSTR(CZM100.CLAIM,1,1)
        NO-LOCK NO-ERROR.
        IF NOT AVAIL WCZM100 THEN DO:
           CREATE WCZM100.
           ASSIGN WCZM100.WFPOLTYP = SUBSTR(czm100.POLTYP,2,2)
                  WCZM100.WFPOLDES = nv_ntype
                  WCZM100.WFDI     = SUBSTR (czm100.CLAIM,1,1).
        END. /*NOT AVAIL*/
      END. /*FIRST-OF (SUBSTR(czm100.claim,1,1))*/

      FIND Xmm600 USE-INDEX Xmm60001 WHERE
           Xmm600.acno = czm100.INTREF NO-LOCK NO-ERROR NO-WAIT.
      IF AVAIL xmm600 THEN 
         ASSIGN nv_adjust = TRIM(Xmm600.ntitle) + TRIM(Xmm600.name)
                nv_adjusna = TRIM(TRIM(Xmm600.ntitle) + TRIM(Xmm600.name)).  
      ELSE ASSIGN  nv_adjust = ""
                   nv_adjusna = "".

      RUN pdFindACNO.
      
      IF n_ostyp = 1 THEN DO:
         IF czm100.OS <= 0 THEN NEXT loop_czm100.
      END.
      ELSE DO:
          IF czm100.OS <= 0 THEN NEXT loop_czm100. /*Lukkana M. A53-0139 03/09/2010 OS ติดลบไม่ต้องแสดงออกมา*/
      END.

      FOR EACH CZD101 USE-INDEX CZD10101 WHERE
               CZD101.ASDAT = nv_asdat AND
               CZD101.CLAIM = nv_claim NO-LOCK 
      BREAK BY CZD101.ASDAT BY CZD101.CLAIM BY CZD101.CLMANT BY CZD101.CLITEM:

        /*-Lukkana M. A53-0139 21/07/2010--*/
        nv_br1 = "".
        IF SUBSTR(czd101.claim,1,2) >= "10" AND
           SUBSTR(czd101.claim,1,2) <= "99" THEN nv_br1 = SUBSTR(czd101.claim,1,2).
        ELSE nv_br1 = SUBSTR(czd101.claim,2,1).
        /*--Lukkana M. A53-0139 21/07/2010--*/
        
        IF LAST-OF (CZD101.CLAIM) THEN DO:  
           OUTPUT TO VALUE (nv_output) APPEND NO-ECHO.
           RUN ChkLineExcel.
           EXPORT DELIMITER ";"
             czm100.Branch  SUBSTR(czm100.POLTYP,2,2)  SUBSTR(czm100.claim,1,1)
             czm100.GRPTYP  czm100.CLAIM   czm100.ENTDAT
             czm100.NOTDAT  czm100.LOSDAT  czm100.ENTDAT
             czm100.POLICY  nv_name               
             czm100.LOSS    czm100.OS    
             czm100.amt[19] czm100.amt[20] /*Lukkana M. A53-0139 01/09/2010*/
             czm100.AMT[1]  czm100.AMT[2]  czm100.AMT[3]  
             czm100.AMT[4]  czm100.AMT[5]  czm100.AMT[6]
             czm100.AMT[7]  czm100.AMT[8]  czm100.AMT[9]
             czm100.AMT[10] czm100.AMT[11] czm100.AMT[12]
             czm100.AMT[13] czm100.AMT[14] czm100.AMT[15]
             czm100.AMT[16] czm100.AMT[17] czm100.AMT[18]
             czm100.COPER   czm100.SICO    
             nv_police      nv_adjusna     nv_extnam
             nv_prodnam     nv_cedclm      nv_pacod
             nv_pades       czm100.DOCST.
           OUTPUT CLOSE.
            
           nv_reccnt = nv_reccnt + 1.
           ASSIGN nv_police = ""
                  nv_pacod = ""
                  nv_pades = "".
           
           FIND FIRST wfnon WHERE wfnon.wfnDI = substr(czm100.claim,1,1) AND 
                                  /*wfnon.wfnbran = SUBSTR(czm100.claim,2,1) AND Lukkana M. A53-0139 22/07/2010*/
                                  wfnon.wfnbran = nv_br1 AND /*Lukkana M. A53-0139 22/07/2010*/
                                  wfnon.wfnpoltyp = substr(czm100.poltyp,2,2) NO-ERROR.
           IF NOT AVAIL wfnon THEN
           CREATE wfnon.
           /*ASSIGN wfnbran = SUBSTR(czm100.claim,2,1) Lukkana M. A53-0139 22/07/2010*/
           ASSIGN wfnbran = nv_br1 /*Lukkana M. A53-0139 22/07/2010*/
                  wfnpoltyp = SUBSTR(czm100.poltyp,2,2)
                  wfnDI   = SUBSTR(czm100.claim,1,1) 
                  wfnos   = wfnos + czm100.OS 
                  i = 1.
                  /*DO i = 1 TO 18: Lukkana M. A53-0139 02/09/2010*/
                  DO i = 1 TO 20: /*Lukkana M. A53-0139 02/09/2010*/
                     wfnamt[i] = wfnamt[i] + czm100.amt[i].
                  END.
        END.
      END.

      RUN pdClrvalue.
END. /* Each czm100 */
RUN ChkLineExcel.
OUTPUT TO VALUE (nv_output) APPEND NO-ECHO.
EXPORT DELIMITER ";"
    "".
EXPORT DELIMITER ";" 
    "".
EXPORT DELIMITER ";"
    "Total : " "" "" "" "" "" "" "" "" "" "" ""
    "O/S Claim"   
    "Survey Fee"    /*Lukkana M. A53-0139 30/08/2010*/
    "Total Gross"   /*Lukkana M. A53-0139 30/08/2010*/
    "1st.TREATY"   
    "2nd.TREATY"      
    "FAC.RI."      
    "Q.S.5%"       
    "TFP"          
    "MPS" 
    "ENG.FAC."     
    "MARINE O/P"   
    "R.Q."         
    "BTR"          
    "OTR"          
    "FTR"
    "F/O I"        
    "F/O II"       
    "F/O III"      
    "F/O IV"
    "GROSS RET."   
    "XOL" . 
OUTPUT CLOSE.
nv_reccnt = nv_reccnt + 3.

FOR EACH wfnon NO-LOCK BREAK BY wfnon.wfnDI BY wfnon.wfnbran  BY wfnpoltyp :
    IF n_ostyp = 1 THEN DO:
       IF wfnon.wfnos <= 0 THEN NEXT.
    END.
    
    RUN ChkLineExcel.
    OUTPUT TO VALUE (nv_output) APPEND NO-ECHO.
    EXPORT DELIMITER ";"
    "" 
    wfnon.wfnDI + " - " + wfnon.wfnbran + " - " + wfnon.wfnpoltyp
    "" "" "" "" "" "" "" "" "" "" 
    wfnon.wfnos 
    wfnon.wfnamt[19]  wfnon.wfnamt[20] /*Lukkana M. A53-0139 02/09/2010*/
    wfnon.wfnamt[1]   wfnon.wfnamt[2]   wfnon.wfnamt[3]
    wfnon.wfnamt[4]   wfnon.wfnamt[5]   wfnon.wfnamt[6]
    wfnon.wfnamt[7]   wfnon.wfnamt[8]   wfnon.wfnamt[9]
    wfnon.wfnamt[10]  wfnon.wfnamt[11]  wfnon.wfnamt[12]
    wfnon.wfnamt[13]  wfnon.wfnamt[14]  wfnon.wfnamt[15]
    wfnon.wfnamt[16]  wfnon.wfnamt[17]  wfnon.wfnamt[18].
    OUTPUT CLOSE.
    nv_reccnt = nv_reccnt + 1.

    ASSIGN n_tos      = n_tos + wfnon.wfnos
           i = 1.
    /*DO i = 1 TO 18: Lukkana M. A53-0139 02/09/2010*/
    DO i = 1 TO 20:  /*Lukkana M. A53-0139 02/09/2010*/
       ASSIGN n_tamt[i]  = n_tamt[i]  + wfnon.wfnamt[i].
    END.
   
    FIND FIRST Wczm100 WHERE Wczm100.wfpoltyp = wfnon.wfnpoltyp AND
                             Wczm100.wfDI  = wfnon.wfnDI NO-LOCK NO-ERROR.
    IF NOT AVAIL Wczm100 THEN 
       CREATE wczm100.
       ASSIGN wczm100.wfpoltyp = wfnon.wfnpoltyp
              wczm100.wfDI     = wfnon.wfnDI
              wczm100.wfos     = wczm100.wfos + wfnon.wfnos
              i    = 1.
            /*DO i = 1 TO 18: Lukkana M. A53-0139 02/09/2010*/
            DO i = 1 TO 20:  /*Lukkana M. A53-0139 02/09/2010*/
               ASSIGN wfamt[i] = wfamt[i] + wfnon.wfnamt[i].
            END.

    ASSIGN n_bros      = n_bros +   wfnon.wfnos
           i = 1.
    /*DO i = 1 TO 18: Lukkana M. A53-0139 02/09/2010*/
    DO i = 1 TO 20:   /*Lukkana M. A53-0139 02/09/2010*/
       ASSIGN n_bramt[i]  = n_bramt[i]  + wfnon.wfnamt[i].
    END.
    
    IF LAST-OF (wfnon.wfnbran) THEN DO:
       n_br = wfnon.wfnbran.
       RUN pdbdes.
       RUN ChkLineExcel.
       OUTPUT TO VALUE (nv_output) APPEND NO-ECHO.
       EXPORT DELIMITER ";"
       "Total: " + wfnon.wfnDI + " - " + wfnon.wfnbran + " ::"
       n_bdes "" "" "" "" ""
       "" "" "" "" "" 
       n_bros  
       n_bramt[19]  n_bramt[20]  /*Lukkana M. A53-0139 02/09/2010*/
       n_bramt[1]   n_bramt[2]   n_bramt[3]
       n_bramt[4]   n_bramt[5]   n_bramt[6]
       n_bramt[7]   n_bramt[8]   n_bramt[9]
       n_bramt[10]  n_bramt[11]  n_bramt[12]  
       n_bramt[13]  n_bramt[14]  n_bramt[15]  
       n_bramt[16]  n_bramt[17]  n_bramt[18].
       OUTPUT CLOSE.
       nv_reccnt = nv_reccnt + 1.
       ASSIGN n_bros = 0    n_bramt = 0.
    END.
    
END.
RUN pdSum_AllBr.
RUN pdSum_DI.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdPrnSMotor C-Win 
PROCEDURE pdPrnSMotor :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
RUN ChkLineExcel2.
OUTPUT TO VALUE (nv_output2) APPEND NO-ECHO.
EXPORT DELIMITER ";"
    czm100.Branch    czm100.POLTYP   nv_poldes
    czm100.GRPTYP    czm100.CLAIM    nv_event
    czm100.POLICY    
    /*
    czm100.VEHREG
    comment by Chaiyong W. A54-0112 12/12/2012*/
    czm100.VEHREG FORMAT "X(11)" /*---add by Chaiyong W. A54-0112 12/12/2012*/
    nv_insurnam      nv_pdcode       nv_pdname 
    nv_comdat        nv_expdat       nv_renpol
    nv_covcod        nv_defau        nv_loss1      
    czm100.ENTDAT    czm100.LOSDAT   czm100.NOTDAT  
    czm100.ENTDAT    nv_sumos
    czm100.amt[19]   czm100.amt[20]  /*Lukkana M. A53-0139 03/09/2010*/
    czm100.amt[3]    czm100.amt[17]  nv_nacod
    nv_nades         nv_pacod        nv_pades
    nv_sumpaid       nv_police  
    nv_adjusna       nv_extnam       nv_cedclm
    czm100.DOCST. 
OUTPUT CLOSE.
nv_reccnt2 = nv_reccnt2 + 1.

ASSIGN nv_sumos  = 0
       nv_sumpaid = 0.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdSum_AllBr C-Win 
PROCEDURE pdSum_AllBr :
/*------------------------------------------------------------------------------
  Purpose:  Summary By Branch for Non motor    
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
RUN ChkLineExcel. 
OUTPUT TO VALUE (nv_output) APPEND NO-ECHO.
EXPORT DELIMITER ";" "".
EXPORT DELIMITER ";"
     "Grand Total All Branch: "
     "" "" "" "" "" 
     "" "" "" "" "" "" 
     n_tos        
     n_tamt[19]   n_tamt[20]  /*Lukkana M. A53-0139 02/09/2010*/
     n_tamt[1]    n_tamt[2]       n_tamt[3] 
     n_tamt[4]    n_tamt[5]       n_tamt[6]       n_tamt[7] 
     n_tamt[8]    n_tamt[9]       n_tamt[10]      n_tamt[11]
     n_tamt[12]   n_tamt[13]      n_tamt[14]      n_tamt[15]
     n_tamt[16]   n_tamt[17]      n_tamt[18].
OUTPUT CLOSE. 
 nv_reccnt = nv_reccnt + 2.

ASSIGN
     n_tos      = 0   n_tamt[1] = 0       n_tamt[2]  = 0      n_tamt[3]  = 0 
     n_tamt[4]  = 0   n_tamt[5] = 0       n_tamt[6]  = 0      n_tamt[7]  = 0
     n_tamt[8]  = 0   n_tamt[9] = 0       n_tamt[10] = 0      n_tamt[11] = 0
     n_tamt[12] = 0  n_tamt[13] = 0       n_tamt[14] = 0      n_tamt[15] = 0
     n_tamt[16] = 0  n_tamt[17] = 0       n_tamt[18] = 0      
     n_tamt[19] = 0  n_tamt[20] = 0.  /*Lukkana M. A53-0139 02/09/2010*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdSum_DI C-Win 
PROCEDURE pdSum_DI :
/*------------------------------------------------------------------------------
  Purpose: Summary By D/I for Non motor    
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
loop_sumDI:
FOR EACH Wczm100 BREAK BY Wczm100.wfDI BY Wczm100.wfpoltyp:
    IF n_ostyp = 1 THEN DO:
       IF wczm100.wfos <= 0 THEN NEXT.
    END.
    ASSIGN n_gros = n_gros + wczm100.wfos
           i = 0.

    /*DO i = 1 TO 18: Lukkana M. A53-0139 02/09/2010*/
    DO i = 1 TO 20:  /*Lukkana M. A53-0139 02/09/2010*/
       n_gramt[i] = n_gramt[i] + wczm100.wfamt[i].
    END.
        
    IF FIRST-OF (Wczm100.wfDI) THEN DO:
       RUN ChkLineExcel. 
       OUTPUT TO VALUE (nv_output) APPEND NO-ECHO.
       EXPORT DELIMITER ";" "".
       EXPORT DELIMITER ";"
       "Summary of " + CAPS (Wczm100.wfDI) 
       "" "" "" "" "" "" "" "" "" "" ""
       "O/S Claim"  
       "Survey Fee"   /*Lukkana M. A53-0139 02/09/2010*/
       "Total Gross"  /*Lukkana M. A53-0139 02/09/2010*/
        "1st.TREATY"   
        "2nd.TREATY"      
        "FAC.RI."      
        "Q.S.5%"       
        "TFP"          
        "MPS" 
        "ENG.FAC."     
        "MARINE O/P"   
        "R.Q."         
        "BTR"          
        "OTR"          
        "FTR"
        "F/O I"        
        "F/O II"       
        "F/O III"      
        "F/O IV"
        "GROSS RET."   
        "XOL".
       OUTPUT CLOSE.
       nv_reccnt = nv_reccnt + 2.
    END.

    IF FIRST-OF (Wczm100.wfpoltyp) THEN DO:
       RUN ChkLineExcel.
       OUTPUT TO VALUE (nv_output) APPEND NO-ECHO.
       EXPORT DELIMITER ";".
       EXPORT DELIMITER ";"
       "" 
       Wczm100.wfpoltyp
       Wczm100.wfpoldes 
       "" "" "" "" "" "" "" "" "" 
       wfos        
       wfamt[19]   wfamt[20]   /*Lukkana M. A53-0139 02/09/2010*/
       wfamt[1]    wfamt[2]       wfamt[3]
       wfamt[4]    wfamt[5]       wfamt[6]       wfamt[7]
       wfamt[8]    wfamt[9]       wfamt[10]      wfamt[11]
       wfamt[12]   wfamt[13]      wfamt[14]      wfamt[15]
       wfamt[16]   wfamt[17]      wfamt[18].
       OUTPUT CLOSE.
       nv_reccnt = nv_reccnt + 2.
    END.

    IF LAST-OF (wczm100.wfDI) THEN DO:
       RUN ChkLineExcel.
       OUTPUT TO VALUE (nv_output) APPEND NO-ECHO.
       EXPORT DELIMITER ";".
       EXPORT DELIMITER ";"
       "Summary of " + wczm100.wfDI + " = "
       "" "" "" "" "" "" "" "" "" "" "" 
       n_gros      
       n_gramt[19] n_gramt[20]   /*Lukkana M. A53-0139 02/09/2010*/
       n_gramt[1]  n_gramt[2]     n_gramt[3]
       n_gramt[4]  n_gramt[5]     n_gramt[6]     n_gramt[7]
       n_gramt[8]  n_gramt[9]     n_gramt[10]    n_gramt[11]
       n_gramt[12] n_gramt[13]    n_gramt[14]    n_gramt[15]
       n_gramt[16] n_gramt[17]    n_gramt[18].   
       OUTPUT CLOSE.
       ASSIGN nv_reccnt = nv_reccnt + 2
              n_gros = 0.
    END.
END. /* DI */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_nbran C-Win 
PROCEDURE pd_nbran :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

n_nbran = "".    /* A51-0102 */
/*--- Find n_nbran ---
 FIND Xmm023 USE-INDEX Xmm02301 WHERE Xmm023.branch = nv_nbran
 NO-LOCK NO-ERROR.
 n_nbran = IF AVAILABLE Xmm023 THEN Xmm023.bdes
           ELSE "". 
 Lukkana M. A53-0139 21/07/2010----*/


/*-- Lukkana M. A53-0139 21/07/2010----*/
FIND FIRST xmm023 USE-INDEX xmm02301 WHERE xmm023.branch = nv_nbran NO-LOCK NO-ERROR.
IF AVAIL xmm023 THEN n_nbran = xmm023.bdes.
ELSE n_nbran = "".
/*-- Lukkana M. A53-0139 21/07/2010----*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

