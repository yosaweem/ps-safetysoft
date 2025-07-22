&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          sic_test         PROGRESS
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

/*****************************************
/* CREATE BY :  Kanchana C.        A46-0478  */
War
        -wace1001.w   โปรแกรม query  match เบี้ย DR & CR Matching
        -wace1002.w                 หน้าจอ ขณะ  match เบี้ย  (ใช้โปรแกรมเดิม)  /**/
        wace1001.i
    Program In Premium  ใช้โปรแกรมเดิม
        wac01102.i         modify from  ACO01102.I 
        wac01104.p                              ACO01104.P

โปรแกรมจะ 
1. ดึงรายการที่ แต่ละ record policy ที่ต่าง endose กัน  และจับคู่กัน  
2.แล้วสามารถตัดเบี้ยได้ทั้ง เบี้ย +   เบี้ย  -   แล้วให้ bal ทั้ง 2 record = 0 

/*------------------------------------------------------------------
 Modify By : TANTAWAN C.   29/04/2008   [A500178]
             ปรับ FORMAT branch เพื่อรองรับการขยายสาขา
             ขยาย FORMAT ของ acno, agent จากเดิม "X(7)" เป็น "X(10)"
--------------------------------------------------------------------*/

Modify By : Lukkana M.  15/08/2012 A55-0243
            แก้ไขการประกาศค่าตัวแปรของ temp-table wacm001_m,wacm001_r ใหม่

******************************************/
/*Modify By: Chaiyong W. A54-0112 02/01/2013*/
/*          Change format vehreg 10 to 11   */
/*-----------------------------------------------------------------------*/
/* Modify By : Benjaporn J. A60-0267 date 31/08/2017          
               เปลี่ยน format docno จาก 7 หลัก เป็น 10 หลัก              */  
/* Modify By : Porntiwa T. A60-0267  Date 14/09/2018
               ปรับขยายเลข Document จาก 7 เป็น 10 หลัก เพื่อนำเข้าระบบให้ถูกต้อง                  */
/* ***************************  Definitions  ************************** */
/* 19/10/2004 */
DEF     SHARED VAR n_User           AS CHAR.
DEF     SHARED VAR n_Passwd         AS CHAR.  

/* Parameters Definitions ---                                           */
/*-------A46-0478-------*/
/**  variables created in   wac\wace1001.w        **/
DEF     SHARED TEMP-TABLE wacm001_m  /*LIKE acm001. Lukkana M. A55-0243 15/08/2012*/
    /*Lukkana M. A55-0243 14/08/2012 เพิ่มเนื่องจากมีการปรับโครงสร้าง table acm001*/
    FIELD policy_m LIKE acm001.policy
    FIELD recno_m  LIKE acm001.recno
    FIELD trnty1_m LIKE acm001.trnty1
    FIELD trnty2_m LIKE acm001.trnty2
    FIELD docno_m  LIKE acm001.docno FORMAT "x(10)" /*A60-0267*/
    FIELD baloc_m  LIKE acm001.baloc
    FIELD prem_m   LIKE acm001.prem
    FIELD comm_m   LIKE acm001.comm
    FIELD stamp_m  LIKE acm001.stamp
    FIELD tax_m    LIKE acm001.tax
    FIELD fee_m    LIKE acm001.fee
    FIELD netamt_m LIKE acm001.netamt
    FIELD bal_m    LIKE acm001.bal
    FIELD trndat_m LIKE acm001.trndat
    FIELD ref_m    LIKE acm001.ref
    FIELD comdat_m LIKE acm001.comdat
    FIELD acno_m   LIKE acm001.acno
    FIELD agent_m  LIKE acm001.agent
    FIELD curcod_m LIKE acm001.curcod
    FIELD branch_m LIKE acm001.branch
    FIELD netloc_m LIKE acm001.netloc
    FIELD poltyp_m LIKE acm001.poltyp
    FIELD vehreg_m LIKE acm001.vehreg
    FIELD insno_m  LIKE acm001.insno
    FIELD instot_m LIKE acm001.instot
    FIELD dociln_m LIKE acm001.dociln
    FIELD disput_m LIKE acm001.disput
INDEX wacm00101_m trnty1_m docno_m
INDEX wacm00104_m policy_m recno_m.
    /*Lukkana M. A55-0243 14/08/2012 เพิ่มเนื่องจากมีการปรับโครงสร้าง table acm001*/
DEF     SHARED TEMP-TABLE wacm001_r  /*LIKE acm001.Lukkana M. A55-0243 15/08/2012*/
    /*Lukkana M. A55-0243 14/08/2012 เพิ่มเนื่องจากมีการปรับโครงสร้าง table acm001*/
    FIELD policy_r LIKE acm001.policy
    FIELD recno_r  LIKE acm001.recno
    FIELD trnty1_r LIKE acm001.trnty1
    FIELD trnty2_r LIKE acm001.trnty2
    /*FIELD docno_r  LIKE acm001.docno*/
    FIELD docno_r  LIKE acm001.docno FORMAT "x(10)" /*A60-0267*/
    FIELD baloc_r  LIKE acm001.baloc
    FIELD prem_r   LIKE acm001.prem
    FIELD comm_r   LIKE acm001.comm
    FIELD stamp_r  LIKE acm001.stamp
    FIELD tax_r    LIKE acm001.tax
    FIELD fee_r    LIKE acm001.fee
    FIELD netamt_r LIKE acm001.netamt
    FIELD bal_r    LIKE acm001.bal
    FIELD trndat_r LIKE acm001.trndat
    FIELD ref_r    LIKE acm001.ref
    FIELD comdat_r LIKE acm001.comdat
    FIELD acno_r   LIKE acm001.acno
    FIELD agent_r  LIKE acm001.agent
    FIELD curcod_r LIKE acm001.curcod
    FIELD branch_r LIKE acm001.branch
    FIELD netloc_r LIKE acm001.netloc
    FIELD poltyp_r LIKE acm001.poltyp
    FIELD vehreg_r LIKE acm001.vehreg
    FIELD insno_r  LIKE acm001.insno
    FIELD instot_r LIKE acm001.instot
    FIELD dociln_r LIKE acm001.dociln
    FIELD disput_r LIKE acm001.disput
INDEX wacm00101_r trnty1_r docno_r
INDEX wacm00104_r policy_r recno_r .
    /*Lukkana M. A55-0243 14/08/2012 เพิ่มเนื่องจากมีการปรับโครงสร้าง table acm001*/

DEF  SHARED VAR  s_policy_m AS CHAR.
DEF  SHARED VAR  s_recno_m AS CHAR.
DEF  SHARED VAR  s_policy_r AS CHAR.
DEF  SHARED VAR  s_recno_r AS CHAR.
DEF  SHARED VAR  s_latdat    AS DATE.

DEF INPUT-OUTPUT PARAMETER n_chkmatch AS LOGIC.   /* ถ้า match สำเร็จ  จะให้ค่าเป็น  YES */


/* Local Variable Definitions ---                                       */
DEFINE NEW SHARED VAR s_prgind    AS   CHAR  FORMAT "xx" INITIAL["00"] NO-UNDO.
DEFINE NEW SHARED VAR s_prog      LIKE acm001.prog                     NO-UNDO.
                                                              /* RecId-acm001*/
DEFINE NEW SHARED VAR s_recid2    AS   RECID INITIAL[0]                NO-UNDO. 
DEFINE NEW SHARED VAR s_module    AS   CHAR  FORMAT "x"                NO-UNDO.

DEFINE NEW SHARED VAR s_trntyp    AS   CHAR  FORMAT "x(2)"             NO-UNDO.
DEFINE NEW SHARED VAR s_trnty1    LIKE acm001.trnty1                   NO-UNDO.
/*DEFINE NEW SHARED VAR s_docno     LIKE acm001.docno                    NO-UNDO. */
DEFINE NEW SHARED VAR s_docno     LIKE acm001.docno FORMAT "x(10)"     NO-UNDO. /*A60-0267*/
DEFINE NEW SHARED VAR s_acno      LIKE acm001.acno                     NO-UNDO.
DEFINE NEW SHARED VAR s_curcod    LIKE acm001.curcod                   NO-UNDO.
DEFINE NEW SHARED VAR s_trndat    LIKE acm001.trndat                   NO-UNDO.
DEFINE NEW SHARED VAR s_netamt    LIKE acm001.netamt                   NO-UNDO.
DEFINE NEW SHARED VAR s_netloc    LIKE acm001.netloc                   NO-UNDO.
DEFINE NEW SHARED VAR s_agent     LIKE acm001.agent                    NO-UNDO. /*--- A500178 ---*/

/* ACO03101 */
DEFINE NEW SHARED VAR s_bal       LIKE acm001.bal      NO-UNDO.
DEFINE NEW SHARED VAR s_balsgn    AS   CHAR FORMAT "x" NO-UNDO.
/* -------- */

/*DEFINE            VAR n_docno    LIKE acx001.docno.*/
DEFINE            VAR n_docno    LIKE acm001.docno FORMAT "x(10)". /*A60-0267*/
DEFINE            VAR n_bal      LIKE acm001.bal        INITIAL[0].
DEFINE            VAR n_baloc    LIKE acm001.baloc      INITIAL[0].

/* ACO03102 */
DEFINE NEW SHARED VAR s_auto     AS   LOGICAL FORMAT "Y/N"        NO-UNDO.
DEFINE NEW SHARED VAR s_comdat   AS   DATE    FORMAT "99/99/9999" NO-UNDO.
DEFINE NEW SHARED VAR s_defaul   AS   CHAR    FORMAT "x"          NO-UNDO.
DEFINE NEW SHARED VAR s_zero     AS   LOGICAL FORMAT "Y/N"        NO-UNDO.
DEFINE NEW SHARED VAR s_fptr02   AS   RECID   NO-UNDO. /* fptr for acm002 */
DEFINE NEW SHARED VAR s_bptr02   AS   RECID   NO-UNDO. /* bptr for acm002 */
DEFINE NEW SHARED VAR s_mchtot   LIKE acm001.netamt INITIAL[0]    NO-UNDO.
                                  /* total amt matched */
DEFINE NEW SHARED VAR s_mchdat   AS DATE FORMAT "99/99/9999" NO-UNDO.

DEFINE NEW SHARED WORKFILE w_acd002
  FIELD w_trnty1  LIKE acd002.trnty1
 /* FIELD w_docno   LIKE acd002.docno*/
  FIELD w_docno   LIKE acd002.docno FORMAT "x(10)" /*A60-0267*/
  FIELD w_ctrty1  LIKE acd002.ctrty1
  /*--- Comment A60-0267
  FIELD w_cdocno  LIKE acd002.cdocno
  FIELD w_cjono   LIKE acd002.cjono   -----*/
  FIELD w_cdocno  LIKE acd002.cdocno FORMAT "x(10)"
  FIELD w_cjono   LIKE acd002.cjono  FORMAT "x(10)"
  /*------- A60-0267 ---------*/
  FIELD w_cjodat  LIKE acd002.cjodat
  FIELD w_netamt  LIKE acd002.netamt.


/* aco01105.p */

DEFINE            VAR n_trnty1    LIKE acm001.trnty1.
/*
DEFINE            VAR n_docno     AS INTEGER INITIAL[0] FORMAT "9999999".
*/
DEFINE            VAR n_match     LIKE acd002.netamt.
DEFINE            VAR n_trndat    LIKE acm001.trndat.
DEFINE            VAR n_curcod    LIKE acm001.curcod.
DEFINE            VAR n_netamt    LIKE acm001.netamt.
DEFINE            VAR n_prem      LIKE acm001.prem.
DEFINE            VAR n_comm      LIKE acm001.comm.
DEFINE            VAR n_other     LIKE acm001.comm.
DEFINE            VAR n_policy    LIKE acm001.policy.
DEFINE            VAR n_recno     LIKE acm001.recno.
DEFINE            VAR n_ref      AS CHAR FORMAT "x(45)" INITIAL[""].
/*
DEFINE            VAR n_ref1      AS CHAR FORMAT "x(45)" INITIAL[""].
DEFINE            VAR n_ref2      AS CHAR FORMAT "x(13)" INITIAL[""].
*/
DEFINE            VAR n_befnet    LIKE acd002.netamt.
DEFINE            VAR n_aftnet    LIKE acd002.netamt.
DEFINE            VAR n_pmatch    LIKE acd002.netamt.
DEFINE            VAR n_exrate    LIKE xmm012.rate.
DEFINE            VAR n_entflg    AS CHAR FORMAT "X" INITIAL["N"].
DEFINE NEW SHARED VAR n_pbal      LIKE acm001.bal NO-UNDO.
DEFINE            VAR n_title     AS CHAR.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME nf1

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES acm001

/* Definitions for FRAME nf1                                            */
&Scoped-define FIELDS-IN-QUERY-nf1 acm001.branch acm001.dociln acm001.ref ~
acm001.prem acm001.fee acm001.comm acm001.tax acm001.stamp acm001.curcod ~
acm001.trndat acm001.vehreg acm001.insno acm001.instot acm001.comdat ~
acm001.policy acm001.recno 
&Scoped-define ENABLED-FIELDS-IN-QUERY-nf1 acm001.branch acm001.dociln ~
acm001.ref acm001.prem acm001.fee acm001.comm acm001.tax acm001.stamp ~
acm001.curcod acm001.trndat acm001.vehreg acm001.insno acm001.instot ~
acm001.comdat acm001.policy acm001.recno 
&Scoped-define ENABLED-TABLES-IN-QUERY-nf1 acm001
&Scoped-define FIRST-ENABLED-TABLE-IN-QUERY-nf1 acm001
&Scoped-define QUERY-STRING-nf1 FOR EACH acm001 SHARE-LOCK
&Scoped-define OPEN-QUERY-nf1 OPEN QUERY nf1 FOR EACH acm001 SHARE-LOCK.
&Scoped-define TABLES-IN-QUERY-nf1 acm001
&Scoped-define FIRST-TABLE-IN-QUERY-nf1 acm001


/* Standard List Definitions                                            */
&Scoped-Define ENABLED-FIELDS acm001.branch acm001.dociln acm001.ref ~
acm001.prem acm001.fee acm001.comm acm001.tax acm001.stamp acm001.curcod ~
acm001.trndat acm001.vehreg acm001.insno acm001.instot acm001.comdat ~
acm001.policy acm001.recno 
&Scoped-define ENABLED-TABLES acm001
&Scoped-define FIRST-ENABLED-TABLE acm001
&Scoped-Define ENABLED-OBJECTS reMain reTypeM reTypeR fis_trntyp fis_docno ~
fin_brndes fi_acno fin_acname fin_bal fis_curdec fin_baloc fis_mchdat ~
fin_trnty1 fin_docno fin_policy fi_agent fin_recno fin_trndat fin_match ~
fin_ref fin_netamt fin_aftnet fin_prem fin_befnet fin_comm fin_other ~
fis_bal buConfirm buExit 
&Scoped-Define DISPLAYED-FIELDS acm001.branch acm001.dociln acm001.ref ~
acm001.prem acm001.fee acm001.comm acm001.tax acm001.stamp acm001.curcod ~
acm001.trndat acm001.vehreg acm001.insno acm001.instot acm001.comdat ~
acm001.policy acm001.recno 
&Scoped-define DISPLAYED-TABLES acm001
&Scoped-define FIRST-DISPLAYED-TABLE acm001
&Scoped-Define DISPLAYED-OBJECTS fis_trntyp fis_docno fin_brndes fi_acno ~
fin_acname fin_bal fis_curdec fin_baloc fis_mchdat fin_trnty1 fin_docno ~
fin_policy fi_agent fin_recno fin_trndat fin_match fin_ref fin_netamt ~
fin_aftnet fin_prem fin_befnet fin_comm fin_other fis_bal 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON buConfirm 
     LABEL "Confirm" 
     SIZE 13 BY 1.14
     BGCOLOR 1 FGCOLOR 7 FONT 2.

DEFINE BUTTON buExit 
     LABEL "Exit" 
     SIZE 13 BY 1.14
     FONT 2.

DEFINE VARIABLE fin_acname AS CHARACTER FORMAT "x(100)" 
     VIEW-AS FILL-IN 
     SIZE 47 BY 1
     FONT 1.

DEFINE VARIABLE fin_aftnet AS DECIMAL FORMAT ">>>,>>>,>>9.99-":U INITIAL 0 
     LABEL "After Match" 
     VIEW-AS FILL-IN 
     SIZE 16 BY 1
     BGCOLOR 3 FGCOLOR 7 FONT 2 NO-UNDO.

DEFINE VARIABLE fin_bal AS DECIMAL FORMAT ">>>,>>>,>>9.99-" INITIAL 0 
     LABEL "Amt O/S" 
     VIEW-AS FILL-IN 
     SIZE 20 BY 1
     BGCOLOR 10 FGCOLOR 0 FONT 2.

DEFINE VARIABLE fin_baloc AS DECIMAL FORMAT ">>>,>>>,>>9.99-" INITIAL 0 
     LABEL "Amt.(Local)" 
     VIEW-AS FILL-IN 
     SIZE 20 BY 1
     BGCOLOR 10 FGCOLOR 0 FONT 2.

DEFINE VARIABLE fin_befnet AS DECIMAL FORMAT ">>>,>>>,>>9.99-":U INITIAL 0 
     LABEL "Before Match" 
     VIEW-AS FILL-IN 
     SIZE 16 BY 1
     BGCOLOR 3 FGCOLOR 7 FONT 2 NO-UNDO.

DEFINE VARIABLE fin_brndes AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 30.5 BY 1
     FONT 1 NO-UNDO.

DEFINE VARIABLE fin_comm AS DECIMAL FORMAT ">>>,>>>,>>9.99-":U INITIAL 0 
     LABEL "Commission" 
     VIEW-AS FILL-IN 
     SIZE 16 BY 1
     FONT 1 NO-UNDO.

DEFINE VARIABLE fin_docno AS CHARACTER FORMAT "X(10)":U INITIAL "0" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     FONT 6 NO-UNDO.

DEFINE VARIABLE fin_match AS DECIMAL FORMAT ">>>,>>>,>>9.99-":U INITIAL 0 
     LABEL "Amount Matched" 
     VIEW-AS FILL-IN 
     SIZE 16 BY 1
     FONT 1 NO-UNDO.

DEFINE VARIABLE fin_netamt AS DECIMAL FORMAT ">>,>>9.99-" INITIAL 0 
     LABEL "Original-Net Amount" 
     VIEW-AS FILL-IN 
     SIZE 20 BY 1
     BGCOLOR 3 FGCOLOR 7 FONT 2.

DEFINE VARIABLE fin_other AS DECIMAL FORMAT ">>>,>>>,>>9.99-":U INITIAL 0 
     LABEL "Stamp + Fee +Tax" 
     VIEW-AS FILL-IN 
     SIZE 16 BY 1
     FONT 1 NO-UNDO.

DEFINE VARIABLE fin_policy AS CHARACTER FORMAT "X(256)":U 
     LABEL "Process Match Pol. No." 
     VIEW-AS FILL-IN 
     SIZE 20 BY 1
     BGCOLOR 3 FGCOLOR 7 FONT 6 NO-UNDO.

DEFINE VARIABLE fin_prem AS DECIMAL FORMAT ">>>,>>>,>>9.99-":U INITIAL 0 
     LABEL "Premium" 
     VIEW-AS FILL-IN 
     SIZE 16 BY 1
     FONT 1 NO-UNDO.

DEFINE VARIABLE fin_recno AS CHARACTER FORMAT "X(256)":U 
     LABEL "Ren/End/Claim No." 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 3 FGCOLOR 7 FONT 6 NO-UNDO.

DEFINE VARIABLE fin_ref AS CHARACTER FORMAT "X(256)":U 
     LABEL "Reference" 
     VIEW-AS FILL-IN 
     SIZE 73 BY 1
     FONT 1 NO-UNDO.

DEFINE VARIABLE fin_trndat AS CHARACTER FORMAT "X(256)":U 
     LABEL "Trans. Date(UW)" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     FONT 1 NO-UNDO.

DEFINE VARIABLE fin_trnty1 AS CHARACTER FORMAT "X(256)":U 
     LABEL "Tran.(1)/DocNo" 
     VIEW-AS FILL-IN 
     SIZE 5 BY 1
     FONT 6 NO-UNDO.

DEFINE VARIABLE fis_bal AS DECIMAL FORMAT ">>>,>>>,>>9.99-":U INITIAL 0 
     LABEL "Unapplied Balance" 
     VIEW-AS FILL-IN 
     SIZE 16 BY 1
     BGCOLOR 3 FGCOLOR 7 FONT 2 NO-UNDO.

DEFINE VARIABLE fis_curdec AS CHARACTER FORMAT "x(25)" 
     VIEW-AS FILL-IN 
     SIZE 31 BY 1.

DEFINE VARIABLE fis_docno AS CHARACTER FORMAT "x(10)":U 
     LABEL "DR Note No." 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1
     FONT 6 NO-UNDO.

DEFINE VARIABLE fis_mchdat AS DATE FORMAT "99/99/9999":U 
     LABEL "Date of Matched" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     FONT 6 NO-UNDO.

DEFINE VARIABLE fis_trntyp AS CHARACTER FORMAT "X(2)" 
     LABEL "Transaction type" 
     VIEW-AS FILL-IN 
     SIZE 5.5 BY 1
     FONT 6.

DEFINE VARIABLE fi_acno AS CHARACTER FORMAT "X(10)":U 
     LABEL "Account No." 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1 NO-UNDO.

DEFINE VARIABLE fi_agent AS CHARACTER FORMAT "X(256)":U 
     LABEL "Agent's Ref. No." 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1 NO-UNDO.

DEFINE RECTANGLE reMain
     EDGE-PIXELS 4 GRAPHIC-EDGE  NO-FILL   
     SIZE 105 BY 22.43
     BGCOLOR 19 .

DEFINE RECTANGLE reTypeM
     EDGE-PIXELS 3 GRAPHIC-EDGE  NO-FILL   
     SIZE 102 BY 11
     BGCOLOR 8 .

DEFINE RECTANGLE reTypeR
     EDGE-PIXELS 3 GRAPHIC-EDGE  NO-FILL   
     SIZE 102 BY 9.38.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY nf1 FOR 
      acm001 SCROLLING.
&ANALYZE-RESUME

/* ************************  Frame Definitions  *********************** */

DEFINE FRAME nf1
     fis_trntyp AT ROW 2.05 COL 19 COLON-ALIGNED
     fis_docno AT ROW 2.05 COL 37.33 COLON-ALIGNED
     acm001.branch AT ROW 2.05 COL 65 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 5.5 BY 1
          FONT 1
     fin_brndes AT ROW 2.05 COL 71 COLON-ALIGNED NO-LABEL
     fi_acno AT ROW 3.05 COL 18.83 COLON-ALIGNED
     fin_acname AT ROW 3.1 COL 33 COLON-ALIGNED NO-LABEL
     acm001.dociln AT ROW 3.1 COL 97.5 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 4 BY 1
          FONT 6
     acm001.ref AT ROW 4.14 COL 19 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 74 BY 1
          FONT 1
     acm001.prem AT ROW 5.19 COL 36 RIGHT-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 16 BY 1
          FONT 1
     acm001.fee AT ROW 5.19 COL 77 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 16 BY 1
          FONT 1
     acm001.comm AT ROW 6.24 COL 19 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 16 BY 1
          FONT 1
     acm001.tax AT ROW 6.24 COL 77 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 16 BY 1
          FONT 1
     acm001.stamp AT ROW 7.24 COL 19 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 16 BY 1
          FONT 1
     fin_bal AT ROW 7.24 COL 77 COLON-ALIGNED
     acm001.curcod AT ROW 8.29 COL 19 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 7.5 BY 1
          FONT 1
     fis_curdec AT ROW 8.29 COL 27 COLON-ALIGNED NO-LABEL
     fin_baloc AT ROW 8.29 COL 77 COLON-ALIGNED
     acm001.trndat AT ROW 9.33 COL 19 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 14 BY 1
          FONT 1
     acm001.vehreg AT ROW 9.33 COL 44 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 14 BY 1
          FONT 1
     acm001.insno AT ROW 9.33 COL 77 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 5 BY 1
          FONT 1
     acm001.instot AT ROW 9.33 COL 86 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 5 BY 1
          FONT 1
     acm001.comdat AT ROW 10.38 COL 19 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 14 BY 1
          FONT 1
     acm001.policy AT ROW 10.38 COL 77 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 20 BY 1
          BGCOLOR 10 FGCOLOR 0 FONT 6
     fis_mchdat AT ROW 11.43 COL 19 COLON-ALIGNED
     acm001.recno AT ROW 11.43 COL 77 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 14 BY 1
          BGCOLOR 10 FGCOLOR 0 FONT 6
     fin_trnty1 AT ROW 13.24 COL 19 COLON-ALIGNED
     fin_docno AT ROW 13.24 COL 26.5 COLON-ALIGNED NO-LABEL
     fin_policy AT ROW 13.24 COL 77 COLON-ALIGNED
     fi_agent AT ROW 14.29 COL 19 COLON-ALIGNED
     fin_recno AT ROW 14.29 COL 77 COLON-ALIGNED
     fin_trndat AT ROW 15.33 COL 19 COLON-ALIGNED
     fin_match AT ROW 15.33 COL 77 COLON-ALIGNED
     fin_ref AT ROW 16.38 COL 19 COLON-ALIGNED
     fin_netamt AT ROW 17.43 COL 19 COLON-ALIGNED
     fin_aftnet AT ROW 17.43 COL 77 COLON-ALIGNED
     fin_prem AT ROW 18.48 COL 19 COLON-ALIGNED
     fin_befnet AT ROW 18.48 COL 77 COLON-ALIGNED
     fin_comm AT ROW 19.52 COL 19 COLON-ALIGNED
     fin_other AT ROW 20.57 COL 19 COLON-ALIGNED
     fis_bal AT ROW 20.57 COL 77 COLON-ALIGNED
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 121.5 BY 23.57.

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME nf1
     buConfirm AT ROW 22.38 COL 78.5
     buExit AT ROW 22.38 COL 92
     "Veh reg no :" VIEW-AS TEXT
          SIZE 10 BY .76 AT ROW 9.33 COL 35.5
     "Comm. Date :" VIEW-AS TEXT
          SIZE 11 BY 1 AT ROW 10.38 COL 10
     "Reference :" VIEW-AS TEXT
          SIZE 9.5 BY 1 AT ROW 4.14 COL 11
     "Prt Imm./Later/No :" VIEW-AS TEXT
          SIZE 15.5 BY 1 AT ROW 3.1 COL 83.5
     "Branch :" VIEW-AS TEXT
          SIZE 6.5 BY 1 AT ROW 2.05 COL 60
     "of" VIEW-AS TEXT
          SIZE 3 BY .76 AT ROW 9.52 COL 84.67
     "-" VIEW-AS TEXT
          SIZE 2 BY 1 AT ROW 13.24 COL 26.5
          FONT 2
     "Ren/End/Claim No. :" VIEW-AS TEXT
          SIZE 17 BY .95 AT ROW 11.43 COL 62
     reMain AT ROW 1.24 COL 2
     reTypeM AT ROW 1.71 COL 3.5
     reTypeR AT ROW 12.76 COL 3.5
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 121.5 BY 23.57.


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
         TITLE              = "wace1002.w - DEBIT & CREDIT MATCHING ENTRY"
         HEIGHT             = 22.81
         WIDTH              = 107
         MAX-HEIGHT         = 24.24
         MAX-WIDTH          = 133.33
         VIRTUAL-HEIGHT     = 24.24
         VIRTUAL-WIDTH      = 133.33
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
/* SETTINGS FOR FRAME nf1
   FRAME-NAME                                                           */
/* SETTINGS FOR FILL-IN acm001.prem IN FRAME nf1
   ALIGN-R                                                              */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK FRAME nf1
/* Query rebuild information for FRAME nf1
     _TblList          = "sic_test.acm001"
     _Query            is NOT OPENED
*/  /* FRAME nf1 */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* wace1002.w - DEBIT  CREDIT MATCHING ENTRY */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* wace1002.w - DEBIT  CREDIT MATCHING ENTRY */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buConfirm
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buConfirm C-Win
ON CHOOSE OF buConfirm IN FRAME nf1 /* Confirm */
DO:

    RUN pdDrCr.  /* process match M R */
  
    DISABLE buConfirm  WITH FRAME nf1.

    
    APPLY "CLOSE" TO THIS-PROCEDURE.  
    RETURN.
  
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buExit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buExit C-Win
ON CHOOSE OF buExit IN FRAME nf1 /* Exit */
DO:
  
  APPLY "CLOSE" TO THIS-PROCEDURE.
  
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
  
  gv_prgid = "wace1002".
  gv_prog  = "DEBIT & CREDIT MATCHING ENTRY".
  RUN  WUT\WUTHEAD (c-win:handle,gv_prgid,gv_prog).

/*********************************************************************/  


    RUN Wut\WutwiCen (C-Win:HANDLE).
    
    DISABLE ALL EXCEPT buConfirm buExit  WITH FRAME nf1.

    reTypeM:MOVE-TO-TOP().
    reTypeR:MOVE-TO-TOP().


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
  DISPLAY fis_trntyp fis_docno fin_brndes fi_acno fin_acname fin_bal fis_curdec 
          fin_baloc fis_mchdat fin_trnty1 fin_docno fin_policy fi_agent 
          fin_recno fin_trndat fin_match fin_ref fin_netamt fin_aftnet fin_prem 
          fin_befnet fin_comm fin_other fis_bal 
      WITH FRAME nf1 IN WINDOW C-Win.
  IF AVAILABLE acm001 THEN 
    DISPLAY acm001.branch acm001.dociln acm001.ref acm001.prem acm001.fee 
          acm001.comm acm001.tax acm001.stamp acm001.curcod acm001.trndat 
          acm001.vehreg acm001.insno acm001.instot acm001.comdat acm001.policy 
          acm001.recno 
      WITH FRAME nf1 IN WINDOW C-Win.
  ENABLE reMain reTypeM reTypeR fis_trntyp fis_docno acm001.branch fin_brndes 
         fi_acno fin_acname acm001.dociln acm001.ref acm001.prem acm001.fee 
         acm001.comm acm001.tax acm001.stamp fin_bal acm001.curcod fis_curdec 
         fin_baloc acm001.trndat acm001.vehreg acm001.insno acm001.instot 
         acm001.comdat acm001.policy fis_mchdat acm001.recno fin_trnty1 
         fin_docno fin_policy fi_agent fin_recno fin_trndat fin_match fin_ref 
         fin_netamt fin_aftnet fin_prem fin_befnet fin_comm fin_other fis_bal 
         buConfirm buExit 
      WITH FRAME nf1 IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-nf1}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdDisp C-Win 
PROCEDURE pdDisp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

DO WITH FRAME nf1 :
    
    FIND FIRST wacm001_m USE-INDEX wacm00104_m 
         WHERE wacm001_m.policy_m = s_policy_m AND
               wacm001_m.recno_m  = s_recno_m NO-LOCK.
    IF AVAIL wacm001_m THEN DO:
        DISP
            wacm001_m.trnty1_m + wacm001_m.trnty2_m  @ fis_trntyp
            wacm001_m.docno_m  @ fis_docno
            wacm001_m.branch_m @ acm001.branch
            /*--- A500178 ---
            wacm001_m.acno   @ acm001.acno     
            ------*/
            wacm001_m.acno_m   @ fi_acno     /*-- A500178 ---*/

            wacm001_m.dociln_m  @ acm001.dociln
            wacm001_m.ref_m   @ acm001.ref
            wacm001_m.prem_m  @ acm001.prem    wacm001_m.fee_m   @ acm001.fee
            wacm001_m.comm_m  @ acm001.comm    wacm001_m.tax_m   @  acm001.tax
            wacm001_m.stamp_m @ acm001.stamp   wacm001_m.bal_m   @  fin_bal
            wacm001_m.curcod_m @ acm001.curcod wacm001_m.baloc_m @ fin_baloc
            wacm001_m.trndat_m @ acm001.trndat wacm001_m.insno_m @ acm001.insno      wacm001_m.instot_m @ acm001.instot
            s_latdat         @ fis_mchdat    wacm001_m.comdat_m @ acm001.comdat
            wacm001_m.policy_m @ acm001.policy wacm001_m.recno_m  @ acm001.recno
            .
            
            IF wacm001_m.acno_m <> "" THEN DO:
               FIND xmm600 USE-INDEX xmm60001 WHERE xmm600.acno = wacm001_m.acno_m
                 NO-LOCK NO-ERROR.
               IF AVAILABLE xmm600 THEN DO:
                 DISPLAY xmm600.name @ fin_acname WITH FRAME nf1.
               END.
            END.
        
            IF wacm001_m.branch_m <> "" THEN DO:
               FIND xmm023 WHERE xmm023.branch = wacm001_m.branch_m NO-LOCK NO-ERROR.
               IF AVAILABLE xmm023 THEN fin_brndes = xmm023.bdes.
                                   ELSE fin_brndes = "".

               DISPLAY fin_brndes WITH FRAME nf1.
            END.
            
    END.
    
    FIND FIRST wacm001_r USE-INDEX wacm00104_r
         WHERE wacm001_r.policy_r = s_policy_r AND
               wacm001_r.recno_r  = s_recno_r NO-LOCK.
    IF AVAIL wacm001_r THEN DO:
        DISP
            wacm001_r.trnty1_r  + wacm001_r.trnty2_r   @ fin_trnty1
            wacm001_r.docno_r  @ fin_docno    wacm001_r.policy_r    @ fin_policy
            wacm001_r.bal_r       @ fin_match     wacm001_r.recno_r     @ fin_recno
            wacm001_r.trndat_r    @ fin_trndat    /* wacm001_r.agent     @ acm001.agent --- A500178 ---*/ wacm001_r.agent_r     @ fi_agent /*--- A500178 ---*/
            wacm001_r.ref_r       @ fin_ref
            wacm001_r.netamt_r  @ fin_netamt      "" @ fin_aftnet
            wacm001_r.prem_r  @ fin_prem          wacm001_r.bal_r   @ fin_befnet
            wacm001_r.comm_r  @ fin_comm
            wacm001_r.stamp_r + wacm001_r.fee_r + wacm001_r.tax_r @ fin_other         "" @ fis_bal
            .

    END.

END.

        
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdDrCr C-Win 
PROCEDURE pdDrCr :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF BUFFER bufacm001_r FOR acm001.
DEF VAR nv_filename AS CHAR.

nv_filename = "c:\temp\"  +
              STRING(YEAR(TODAY),"9999") +
              STRING(MONTH(TODAY),"99") +
              STRING(DAY(TODAY),"99") +
              ".DR" .
OUTPUT TO VALUE (nv_filename) APPEND  NO-ECHO.
    EXPORT DELIMITER ";" "".
    EXPORT DELIMITER ";" 
        "wace1002.w - DEBIT & CREDIT MATCHING ENTRY" 
        STRING(TODAY,"99/99/9999")
        STRING(TIME,"HH:MM:SS")
        "Contra date : " + STRING(s_latdat,"99/99/9999").
OUTPUT CLOSE.
    
/******************* ข้อมูลพร้อมที่จะทำการ match ****************/
DO WITH FRAME nf1 :

FOR  EACH wacm001_m WHERE wacm001_m.disput_m = YES,            /*เฉพาะ policy ที่มีการ mark ค่าไว้ */ /*USE-INDEX acm00103 */
     FIRST wacm001_r USE-INDEX wacm00104_r
           WHERE wacm001_r.policy_r    =   wacm001_m.policy_m    AND
                 wacm001_r.recno_r    <>   " "                   AND
                 wacm001_r.acno_r      =   wacm001_m.acno_m      AND    /* ตัดเบี้ย ต้อง acno code เดียวกัน เท่านั้น*/
                 wacm001_r.trnty1_r    =   "R"                   AND 
                 wacm001_r.prem_r      =   wacm001_m.prem_m * -1 AND 
                 wacm001_r.comm_r      =   wacm001_m.comm_m * -1 AND 
                 wacm001_r.tax_r       =   wacm001_m.tax_m  * -1 AND 
                 wacm001_r.stamp_r     =   wacm001_m.stamp_m *  -1 AND
                 wacm001_r.netamt_r    =   wacm001_m.netamt_m * -1 AND
                 wacm001_r.bal_r       =   wacm001_m.bal_m    * -1
     NO-LOCK BREAK BY  wacm001_m.acno_m :

     FOR EACH w_acd002:  DELETE w_acd002.  END.  /* DELETE WORKFILE  ตอน create acd002  หากไม่ลบจะมีจำนวน rec ใน acd002 เพิ่ม */

DO TRANSACTION :    /* ต้องทำให้เสร็จใน loop นี้  */

n_aftnet = 0.        n_befnet = 0.     /* จำนวนค่าที่ match สำหรับ acd002 */

s_prog   = "WACE1002".
s_module = "D".
s_mchtot  = 0.

/*----  MATCHING  "M"  ----*/
  s_prgind = "01".

  s_trnty1 =  wacm001_m.trnty1_m.        /* "M" ??????? */
  s_docno  = wacm001_m.docno_m.       /* "1642227" ??????? */


  FIND acm001 USE-INDEX acm00101  WHERE     /* "M"  */
       acm001.trnty1 = wacm001_m.trnty1_m   AND    /* s_trnty1*/
       acm001.docno  = wacm001_m.docno_m           /* s_docno*/
  NO-WAIT NO-ERROR.

  IF NOT AVAILABLE acm001 THEN DO:
     IF LOCKED acm001 THEN MESSAGE "Record is locked".
                      ELSE MESSAGE "Not on Accounts master file".

     /*LEAVE main.*/
     NEXT.
  END.
    ASSIGN
    s_recid2 = RECID(acm001)
    s_trntyp = acm001.trnty1 + acm001.trnty2
    s_acno   = acm001.acno
    s_agent  = acm001.agent
    s_curcod = acm001.curcod
    s_trndat = acm001.trndat
    s_netamt = acm001.netamt
    s_netloc = acm001.netloc
    s_prgind = "01".

/*   HIDE FRAME nf1 NO-PAUSE. kan*/

  s_bal    = 0.
  s_balsgn = "".

    loop_crt:
    DO TRANSACTION:

    FIND acm001 WHERE RECID(acm001) = s_recid2.
    s_prgind = "00".
    
/**/
/*---
    IF acm001.acno <> "" THEN DO:
       FIND xmm600 USE-INDEX xmm60001 WHERE xmm600.acno = acm001.acno
         NO-LOCK NO-ERROR.
       IF AVAILABLE xmm600 THEN DO:
         /*COLOR DISPLAY INPUT xmm600.name WITH FRAME nf1. */  /* kan */
         DISPLAY xmm600.name @ fin_acname WITH FRAME nf1.
       END.
    END.
    IF acm001.curcod <> "" THEN DO:
       FIND xmm012 USE-INDEX xmm01201 WHERE xmm012.curcod = acm001.curcod
         NO-LOCK NO-ERROR.
       IF AVAILABLE xmm012 THEN DO:
         /* COLOR DISPLAY INPUT xmm012.curdec WITH FRAME nf1. */   /*kan*/
         DISPLAY xmm012.curdec @ fis_curdec  WITH FRAME nf1.
       END.
    END.
    IF acm001.branch <> "" THEN DO:
       FIND xmm023 WHERE xmm023.branch = acm001.branch NO-LOCK NO-ERROR.
       IF AVAILABLE xmm023 THEN fin_brndes = xmm023.bdes.
                           ELSE fin_brndes = "".
       /* COLOR DISPLAY INPUT n_brndes WITH FRAME nf1. */  /*kan*/
       DISPLAY fin_brndes WITH FRAME nf1.
    END.
---*/
/**/
    ASSIGN
    n_bal    = acm001.bal
    n_baloc  = acm001.baloc.

    DISPLAY
      acm001.trnty1 + acm001.trnty2 @  fis_trntyp
      acm001.docno  @ fis_docno
      acm001.branch   acm001.dociln
      /*--- A500178 ---
      acm001.acno     
      -----*/
      acm001.acno   @ fi_acno     /*--- A500178 ---*/
      acm001.ref
      acm001.prem   acm001.comm
      acm001.stamp  acm001.fee
      acm001.tax    
      acm001.bal    @ fin_bal
      acm001.curcod acm001.trndat
      acm001.baloc  @ fin_baloc

      acm001.vehreg
      acm001.insno    acm001.instot
    WITH FRAME nf1.

    s_bal    = - acm001.bal.
    IF s_bal > 0 THEN s_balsgn = "+".
                ELSE s_balsgn = "-".

    ASSIGN
    s_auto   = NO
    s_comdat = ?
    s_defaul = "N"
    s_zero   = NO.

    s_fptr02 = 0.
    s_bptr02 = 0.

    IF s_auto THEN s_prgind = "04".
                ELSE s_prgind = "05".

    ASSIGN
    n_aftnet = 0
    n_entflg = "n"
    n_trnty1 = ""
    /*n_docno  = 0 */     n_docno  = "" /*A60-0267*/
    n_match  = 0
    n_pmatch = 0
    n_pbal   = s_bal.

/*----  MATCHING  "R"  ----*/

    s_mchdat = s_latdat.           /* TODAY ??????? */

    n_trnty1  =  wacm001_r.trnty1_r .          /* "R" ??????? */
    /*n_docno = INT(wacm001_r.docno_r) .         /* 1000064 ??????? */*/
    n_docno = wacm001_r.docno_r. /*A60-0267*/

    DISPLAY
      s_mchdat      @ fis_mchdat
      acm001.policy
      acm001.comdat
      acm001.recno
      n_trnty1      @ fin_trnty1 
      n_docno       @ fin_docno
    WITH FRAME nf1.

            /* ------------------- */

            FIND FIRST  w_acd002 WHERE
                        w_acd002.w_ctrty1 = s_trnty1  AND
                        w_acd002.w_cdocno = s_docno   AND
                        w_acd002.w_trnty1 = n_trnty1  AND
                        /*w_acd002.w_docno  = STRING(n_docno, "9999999") */
                        w_acd002.w_docno  =  n_docno /*A60-0267*/
            NO-WAIT NO-ERROR.
            IF AVAILABLE acd002 THEN DO:
               MESSAGE "Record already exist".
                ASSIGN
                s_bal    = s_bal + n_match
                n_aftnet = 0
                n_entflg = "n"
                n_trnty1 = ""
                /*n_docno  = 0 */ n_docno  = "" /*A60-0267*/
                n_match  = 0.

               NEXT.
            END.

            FIND  acm001 USE-INDEX acm00101  WHERE
                  acm001.trnty1 = n_trnty1   AND
                  /*acm001.docno  = STRING(n_docno, "9999999") */
                  acm001.docno  = n_docno /*A60-0267*/
            NO-WAIT NO-ERROR.
            IF NOT AVAILABLE acm001 THEN DO:
               MESSAGE "Transaction Type/Document No. not on A/C master file".

            END.
            ELSE DO:
               IF acm001.acno <> s_acno THEN DO:
                  MESSAGE "Transaction is in different account " acm001.acno.

                  NEXT.
               END.
               IF acm001.curcod <> s_curcod THEN DO:
                  MESSAGE
                    "All transaction matched must be of the same currency".
                  NEXT.
               END.
            ASSIGN                
               n_trndat   = acm001.trndat     n_curcod   = acm001.curcod
               n_netamt   = acm001.netamt     n_prem     = acm001.prem
               n_comm     = acm001.comm       n_policy   = acm001.policy
               n_recno    = acm001.recno
               n_ref         = acm001.ref
/*               n_ref1     = SUBSTR(acm001.ref,1,45)
               n_ref2     = SUBSTR(acm001.ref,46,13)
*/
               n_befnet   = acm001.bal
               n_other    = acm001.stamp + acm001.tax + acm001.fee.

               IF n_pmatch = 0 THEN DO:
                  IF s_defaul = "Z" THEN n_match = 0.
                  IF s_defaul = "N" THEN n_match = acm001.bal.
                  IF s_defaul = "G" THEN DO :
                     IF acm001.bal > 0 THEN n_match = acm001.bal - acm001.comm.
                     ELSE IF acm001.bal < 0 THEN
                          n_match = acm001.bal - acm001.comm.
                     ELSE n_match = acm001.comm.
                  END.
               END.

               n_entflg = "Y".
            END.

            DISPLAY
              /* n_curcod*/
                 n_trnty1   @ fin_trnty1
                 n_docno    @ fin_docno
                 n_policy   @ fin_policy
                 n_match    @ fin_match
                 n_recno    @ fin_recno
                 n_trndat   @ fin_trndat
                 /*--- A500178 ---
                 acm001.agent
                 ------*/
                 s_agent    @ fi_agent /*--- A500178 ---*/
                 n_ref      @ fin_ref
                 n_netamt   @ fin_netamt
                 n_aftnet   @ fin_aftnet
                 n_prem     @ fin_prem
                 n_befnet   @ fin_befnet
                 n_comm     @ fin_comm
                 n_other    @ fin_other
                 s_bal      @ fis_bal
            WITH FRAME nf1.

            /* ------------------- */

            n_aftnet = n_befnet + n_pmatch - n_match.
            IF s_zero AND n_aftnet <> 0 THEN DO:
               MESSAGE "Must be zero after matching".
               NEXT.
            END.
            IF s_balsgn = "-" THEN DO:
               IF (s_bal + n_pmatch - n_match) > 0 THEN DO:
                  MESSAGE "Amount matched exceeds unapplied balance".
                  NEXT.
               END.
            END.
            ELSE DO:
               IF (s_bal + n_pmatch - n_match) < 0 THEN DO:
                  MESSAGE "Amount matched exceeds unapplied balance".
                  NEXT.
               END.
            END.
            s_bal = s_bal + n_pmatch - n_match.

            DISPLAY n_aftnet @ fin_aftnet
                            s_bal      @ fis_bal 
            WITH FRAME nf1.

            IF n_pmatch <> n_match THEN DO:
               n_entflg = "y".
            END.
            n_pmatch = n_match.


        /*    PAUSE MESSAGE "ก่อน PAGE-DOWN".*/
      /*
      IF LASTKEY = KEYCODE("PAGE-DOWN") THEN DO:
      */
         n_aftnet = n_befnet - n_match.
         IF s_zero AND n_aftnet <> 0 THEN DO:
            MESSAGE "Must be zero after matching".
            NEXT.
         END.
         IF s_balsgn = "-" THEN DO:
            IF (s_bal + n_pmatch - n_match) > 0 THEN DO:
               MESSAGE "Amount matched exceeds unapplied balance".
               NEXT.
            END.
         END.
         ELSE DO:
            IF (s_bal + n_pmatch - n_match) < 0 THEN DO:
               MESSAGE "Amount matched exceeds unapplied balance".
               NEXT.
            END.
         END.
         s_bal = s_bal + n_pmatch - n_match.

        DISPLAY  n_aftnet @ fin_aftnet  
                 s_bal    @ fis_bal
        WITH FRAME nf1.

         /*PAUSE 0.*/


/*pause message "sadsfdfasdasfd".*/

         IF n_match <> 0 THEN DO:

            FIND acm001 USE-INDEX acm00101 WHERE 
                 acm001.trnty1 = n_trnty1  AND 
                 /*acm001.docno  = STRING(n_docno, "9999999")  */
                 acm001.docno  = n_docno /*A60-0267*/

            NO-WAIT NO-ERROR.

            FIND FIRST w_acd002 WHERE 
                       w_acd002.w_ctrty1 = s_trnty1  AND
                       w_acd002.w_cdocno = s_docno   AND
                       w_acd002.w_trnty1 = n_trnty1  AND
                       /*w_acd002.w_docno  = STRING(n_docno, "9999999") */
                       w_acd002.w_docno  = n_docno /*A60-0267*/
            NO-WAIT NO-ERROR.
            IF NOT AVAILABLE acd002 THEN DO:
        
               {wac/wac01102.i}             /* {ac/aco01102.i} */  /* kan */

                ASSIGN
                n_aftnet = 0     n_entflg = "n"
                n_trnty1 = ""    /*n_docno  = 0   */   n_docno  = ""  /*A60-0267*/
                n_match  = 0     n_pmatch = 0
                n_pbal   = s_bal.

            END.
            ELSE DO:
               MESSAGE "Already matched - Use F9 to mofidy".
               ASSIGN
               s_bal    = s_bal + n_match
               n_aftnet = 0 
               n_entflg = "n"
               n_trnty1 = ""   
               /*n_docno  = 0 */   n_docno  = ""  /*A60-0267*/
               n_match  = 0
               n_pmatch = 0.

            END.
         END.  /** n_match <> 0 **/

            DISPLAY
              /* n_curcod*/
                 n_trnty1   @ fin_trnty1
                 n_docno    @ fin_docno
                 n_policy   @ fin_policy
                 n_match    @ fin_match
                 n_recno    @ fin_recno
                 n_trndat   @ fin_trndat
                 acm001.agent
                 n_ref      @ fin_ref
                 n_netamt   @ fin_netamt
                 n_aftnet   @ fin_aftnet
                 n_prem     @ fin_prem
                 n_befnet   @ fin_befnet
                 n_comm     @ fin_comm
                 n_other    @ fin_other
                 s_bal      @ fis_bal
            WITH FRAME nf1.
/*kan
    HIDE MESSAGE NO-PAUSE.
    MESSAGE "ก่อน  F1" s_fptr02.
    PAUSE.
*/
         IF n_trnty1 <> "" THEN
            FIND acm001 USE-INDEX acm00101 WHERE 
                 acm001.trnty1 = n_trnty1  AND 
                 /*acm001.docno  = STRING(n_docno, "9999999")  */
                 acm001.docno  = n_docno /*A60-0267*/ 
            NO-WAIT NO-ERROR.

         n_aftnet = n_befnet - n_match.

         IF s_zero AND n_aftnet <> 0 THEN DO:
            MESSAGE "Must be zero after matching".
            NEXT.
         END.
         IF s_balsgn = "-" THEN DO:
            IF (s_bal + n_pmatch - n_match) > 0 THEN DO:
               MESSAGE "Amount matched exceeds unapplied balance".
               NEXT.
            END.
         END.
         ELSE DO:
            IF (s_bal + n_pmatch - n_match) < 0 THEN DO:
               MESSAGE "Amount matched exceeds unapplied balance".
               NEXT.
            END.
         END.
         s_bal = s_bal + n_pmatch - n_match.

         DISPLAY s_bal  @ fis_bal  WITH FRAME nf1.
         /* PAUSE 0. */


         IF n_match <> 0 THEN DO:
            FIND FIRST w_acd002 WHERE 
                       w_acd002.w_ctrty1 = s_trnty1  AND
                       w_acd002.w_cdocno = s_docno   AND
                       w_acd002.w_trnty1 = n_trnty1  AND
                       /*w_acd002.w_docno  = STRING(n_docno, "9999999") */
                       w_acd002.w_docno  = n_docno /*A60-0267*/
            NO-WAIT NO-ERROR.
            IF NOT AVAILABLE acd002 THEN DO:

               {wac/wac01102.i}             /* {ac/aco01102.i} */  /* kan */

            END.
         END.

         /**  Update Balance Outstanding  **/
        FIND acm001 WHERE RECID(acm001) = s_recid2.
        ASSIGN
         acm001.bal   = - s_bal
         acm001.baloc = (acm001.netloc / acm001.netamt) * s_bal
         acm001.baloc = - acm001.baloc.

         s_prgind = "01".


        IF s_prgind = "01" AND s_fptr02 <> 0 THEN  DO:
 
       
            RUN wac/wac01104.              /* create acd002 -> RUN  ac/aco01104. */ /* kan */
        
            n_chkmatch = YES.
    
            /* mark ข้อมูลที่ทำการ match ไปแล้ว  */
            ASSIGN
                wacm001_m.disput_m     = YES
                wacm001_r.disput_r     = YES.

        OUTPUT TO VALUE (nv_filename) APPEND NO-ECHO.   /* export file ที่ match ทั้งหมด*/

            EXPORT DELIMITER ";"
                wacm001_m.policy_m wacm001_m.recno_m  wacm001_m.trnty1_m + wacm001_m.trnty2_m   wacm001_m.docno_m
                
                wacm001_r.policy_r wacm001_r.recno_r  wacm001_r.trnty1_r + wacm001_r.trnty2_r   wacm001_r.docno_r
                
                wacm001_m.prem_m
                wacm001_m.comm_m
                wacm001_m.stamp_m
                wacm001_m.tax_m
                wacm001_m.netamt_m
                wacm001_m.bal_m
                STRING(TODAY,"99/99/9999")
                STRING(TIME,"HH:MM:SS").
        OUTPUT CLOSE.
            
            DELETE wacm001_m.           /* delete datat in temp-table */
            DELETE wacm001_r.

        END.
        ELSE DO:

            ASSIGN
                wacm001_m.disput_m   = NO
                wacm001_r.disput_r   = NO.
        END.

/*    PAUSE.*/


  END.
  

END. /* DO TRANSACTION */

END.  /* FOR EACH จาก temp-table*/  


END. /* DO WITH FRAME nf1 */
/**/

OUTPUT CLOSE.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdDrCrOld C-Win 
PROCEDURE pdDrCrOld :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*kan---
n_aftnet = 0.        n_befnet = 0.

s_prog   = "".
s_module = "D".

/**/

main:
REPEAT:

  CLEAR FRAME nf1 ALL NO-PAUSE.
  STATUS DEFAULT "F4=Menu                F13=Undo all".
  PAUSE 0.

  s_prgind = "01".

  s_trnty1  = "M".             /* ??????? */
  s_docno   = "1642227".       /* ??????? */


  FIND acm001 USE-INDEX acm00101  WHERE
       acm001.trnty1 = s_trnty1   AND
       acm001.docno  = s_docno
  NO-WAIT NO-ERROR.

  IF NOT AVAILABLE acm001 THEN DO:
     IF LOCKED acm001 THEN MESSAGE "Record is locked".
                      ELSE MESSAGE "Not on Accounts master file".

     LEAVE main.
     NEXT.
  END.
    ASSIGN
    s_recid2 = RECID(acm001)
    s_trntyp = acm001.trnty1 + acm001.trnty2
    s_acno   = acm001.acno
    s_curcod = acm001.curcod
    s_trndat = acm001.trndat
    s_netamt = acm001.netamt
    s_netloc = acm001.netloc
    s_prgind = "01".

  HIDE FRAME nf1 NO-PAUSE.

  s_bal    = 0.
  s_balsgn = "".

    loop_crt:
    DO TRANSACTION:

    FIND acm001 WHERE RECID(acm001) = s_recid2.
    s_prgind = "00".

    IF acm001.acno <> "" THEN DO:
       FIND xmm600 USE-INDEX xmm60001 WHERE xmm600.acno = acm001.acno
         NO-LOCK NO-ERROR.
       IF AVAILABLE xmm600 THEN DO:
         COLOR DISPLAY INPUT xmm600.name WITH FRAME nf1.
         DISPLAY xmm600.name WITH FRAME nf1.
       END.
    END.
    IF acm001.dept <> "" THEN DO:
       FIND sym100 WHERE sym100.tabcod = "U079" AND
         sym100.itmcod = acm001.dept NO-LOCK NO-ERROR.
       IF AVAILABLE sym100 THEN n_dptdes = sym100.itmdes.
                           ELSE n_dptdes = "".
    END.
    IF acm001.curcod <> "" THEN DO:
       FIND xmm012 USE-INDEX xmm01201 WHERE xmm012.curcod = acm001.curcod
         NO-LOCK NO-ERROR.
       IF AVAILABLE xmm012 THEN DO:
         COLOR DISPLAY INPUT xmm012.curdec WITH FRAME nf1.
         DISPLAY xmm012.curdec WITH FRAME nf1.
       END.
    END.
    IF acm001.branch <> "" THEN DO:
       FIND xmm023 WHERE xmm023.branch = acm001.branch NO-LOCK NO-ERROR.
       IF AVAILABLE xmm023 THEN n_brndes = xmm023.bdes.
                           ELSE n_brndes = "".
       COLOR DISPLAY INPUT n_brndes WITH FRAME nf1.
       DISPLAY n_brndes WITH FRAME nf1.
    END.
    IF acm001.ac1 <> "" THEN DO:
       FIND xmm201 USE-INDEX xmm20101 WHERE xmm201.glacno = acm001.ac1
         NO-LOCK NO-ERROR.
       IF AVAILABLE xmm201 THEN n_acdes1 = xmm201.gldes.
    END.
    IF acm001.ac2 <> "" THEN DO:
       FIND xmm201 USE-INDEX xmm20101 WHERE xmm201.glacno = acm001.ac2
         NO-LOCK NO-ERROR.
       IF AVAILABLE xmm201 THEN n_acdes2 = xmm201.gldes.
    END.
    IF acm001.ac3 <> "" THEN DO:
       FIND xmm201 USE-INDEX xmm20101 WHERE xmm201.glacno = acm001.ac3
         NO-LOCK NO-ERROR.
       IF AVAILABLE xmm201 THEN n_acdes3 = xmm201.gldes.
    END.
    IF acm001.ac4 <> "" THEN DO:
       FIND xmm201 USE-INDEX xmm20101 WHERE xmm201.glacno = acm001.ac4
         NO-LOCK NO-ERROR.
       IF AVAILABLE xmm201 THEN n_acdes4 = xmm201.gldes.
    END.
    IF acm001.ac5 <> "" THEN DO:
       FIND xmm201 USE-INDEX xmm20101 WHERE xmm201.glacno = acm001.ac5
         NO-LOCK NO-ERROR.
       IF AVAILABLE xmm201 THEN n_acdes5 = xmm201.gldes.
    END.
    IF acm001.ac6 <> "" THEN DO:
       FIND xmm201 USE-INDEX xmm20101 WHERE xmm201.glacno = acm001.ac6
         NO-LOCK NO-ERROR.
       IF AVAILABLE xmm201 THEN n_acdes6 = xmm201.gldes.
    END.
    ASSIGN
    n_bal    = acm001.bal
    n_baloc  = acm001.baloc
    n_acamt1 = acm001.amt1
    n_acamt2 = acm001.amt2
    n_acamt3 = acm001.amt3
    n_acamt4 = acm001.amt4
    n_acamt5 = acm001.amt5
    n_acamt6 = acm001.amt6.

    COLOR DISPLAY INPUT
      s_trntyp        s_docno
      acm001.branch   acm001.dociln
      acm001.acno     acm001.ref
      acm001.prem     acm001.comm
      acm001.stamp    acm001.fee
      acm001.tax      n_bal
      acm001.curcod   acm001.trndat
      n_baloc

      acm001.vehreg
      acm001.insno    acm001.instot
    WITH FRAME nf1.

    DISPLAY
      s_trntyp        s_docno
      acm001.branch   acm001.dociln
      acm001.acno     acm001.ref
      acm001.prem     acm001.comm
      acm001.stamp    acm001.fee
      acm001.tax      n_bal
      acm001.curcod   acm001.trndat
      n_baloc

      acm001.vehreg
      acm001.insno    acm001.instot
    WITH FRAME nf1.

    s_bal    = - acm001.bal.
    IF s_bal > 0 THEN s_balsgn = "+".
                 ELSE s_balsgn = "-".

/*kan---
    s_auto   = NO.
    s_comdat = ?.
    s_defaul = "N".
    s_zero   = NO.

    s_fptr02 = 0.
    s_bptr02 = 0.

    IF s_auto THEN s_prgind = "04".
              ELSE s_prgind = "05".

    n_aftnet = 0.    
    n_entflg = "n".
    n_trnty1 = "". 
    n_docno  = 0.
    n_match  = 0.
    n_pmatch = 0.
    n_pbal   = s_bal.


    s_mchdat = TODAY.           /* ??????? */

    n_trnty1 = "R".             /* ??????? */
    n_docno  = 1000064.         /* ??????? */


    COLOR DISPLAY INPUT
      s_mchdat
      acm001.policy
      acm001.comdat
      acm001.recno
    WITH FRAME nf1.

    DISPLAY
      s_mchdat
      acm001.policy
      acm001.comdat
      acm001.recno
    WITH FRAME nf1.



            /* ------------------- */

            FIND FIRST  w_acd002 WHERE
                        w_acd002.w_ctrty1 = s_trnty1  AND
                        w_acd002.w_cdocno = s_docno   AND
                        w_acd002.w_trnty1 = n_trnty1  AND
                        w_acd002.w_docno  = STRING(n_docno, "9999999")
            NO-WAIT NO-ERROR.
            IF AVAILABLE acd002 THEN DO:
               MESSAGE "Record already exist".

               s_bal    = s_bal + n_match.
               n_aftnet = 0.     
               n_entflg = "n".
               n_trnty1 = "". 
               n_docno  = 0. 
               n_match  = 0.

               LEAVE main.
               NEXT.
            END.

            FIND  acm001 USE-INDEX acm00101  WHERE
                  acm001.trnty1 = n_trnty1   AND
                  acm001.docno  = STRING(n_docno, "9999999")
            NO-WAIT NO-ERROR.
            IF NOT AVAILABLE acm001 THEN DO:
               MESSAGE "Transaction Type/Document No. not on A/C master file".

               LEAVE main.

            END.
            ELSE DO:
               IF acm001.acno <> s_acno THEN DO:
                  MESSAGE "Transaction is in different account " acm001.acno.

                  LEAVE main.
                  NEXT.
               END.
               IF acm001.curcod <> s_curcod THEN DO:
                  MESSAGE
                    "All transaction matched must be of the same currency".

                  LEAVE main.
                  NEXT.
               END.
            ASSIGN                
               n_trndat   = acm001.trndat     n_curcod   = acm001.curcod
               n_netamt   = acm001.netamt     n_prem     = acm001.prem
               n_comm     = acm001.comm       n_policy   = acm001.policy
               n_recno    = acm001.recno
               n_ref1     = SUBSTR(acm001.ref,1,45)
               n_ref2     = SUBSTR(acm001.ref,46,13)
               n_befnet   = acm001.bal
               n_other    = acm001.stamp + acm001.tax + acm001.fee.

               IF n_pmatch = 0 THEN DO:
                  IF s_defaul = "Z" THEN n_match = 0.
                  IF s_defaul = "N" THEN n_match = acm001.bal.
                  IF s_defaul = "G" THEN DO :
                     IF acm001.bal > 0 THEN n_match = acm001.bal - acm001.comm.
                     ELSE IF acm001.bal < 0 THEN
                          n_match = acm001.bal - acm001.comm.
                     ELSE n_match = acm001.comm.
                  END.
               END.

               n_entflg = "Y".
            END.

            DISPLAY
              /* n_curcod*/
                 n_trnty1   n_docno   n_policy
                 n_match    n_recno
                 n_trndat   acm001.agent
                 n_ref1     n_ref2
                 n_netamt   n_aftnet
                 n_prem     n_befnet
                 n_comm     n_other
                 s_bal
            WITH FRAME nf1.

            /* ------------------- */

            n_aftnet = n_befnet + n_pmatch - n_match.
            IF s_zero AND n_aftnet <> 0 THEN DO:
               MESSAGE "Must be zero after matching".

               LEAVE main.
               NEXT.
            END.
            IF s_balsgn = "-" THEN DO:
               IF (s_bal + n_pmatch - n_match) > 0 THEN DO:
                  MESSAGE "Amount matched exceeds unapplied balance".

                  LEAVE main.
                  NEXT.
               END.
            END.
            ELSE DO:
               IF (s_bal + n_pmatch - n_match) < 0 THEN DO:
                  MESSAGE "Amount matched exceeds unapplied balance".

                  LEAVE main.
                  NEXT.
               END.
            END.
            s_bal = s_bal + n_pmatch - n_match.

            DISPLAY n_aftnet s_bal WITH FRAME nf1.

            IF n_pmatch <> n_match THEN DO:
               n_entflg = "y".
            END.
            n_pmatch = n_match.


    PAUSE MESSAGE "ก่อน PAGE-DOWN".
      /*
      IF LASTKEY = KEYCODE("PAGE-DOWN") THEN DO:
      */
         n_aftnet = n_befnet - n_match.
         IF s_zero AND n_aftnet <> 0 THEN DO:
            MESSAGE "Must be zero after matching".

            LEAVE main.
            NEXT.
         END.
         IF s_balsgn = "-" THEN DO:
            IF (s_bal + n_pmatch - n_match) > 0 THEN DO:
               MESSAGE "Amount matched exceeds unapplied balance".

               LEAVE main.
               NEXT.
            END.
         END.
         ELSE DO:
            IF (s_bal + n_pmatch - n_match) < 0 THEN DO:
               MESSAGE "Amount matched exceeds unapplied balance".

               LEAVE main.
               NEXT.
            END.
         END.
         s_bal = s_bal + n_pmatch - n_match.

         DISPLAY  n_aftnet  s_bal  WITH FRAME nf1.
         PAUSE 0.


pause message "sadsfdfasdasfd".

         IF n_match <> 0 THEN DO:

            FIND acm001 USE-INDEX acm00101 WHERE 
                 acm001.trnty1 = n_trnty1  AND 
                 acm001.docno  = STRING(n_docno, "9999999") 
            NO-WAIT NO-ERROR.

            FIND FIRST w_acd002 WHERE 
                       w_acd002.w_ctrty1 = s_trnty1  AND
                       w_acd002.w_cdocno = s_docno   AND
                       w_acd002.w_trnty1 = n_trnty1  AND
                       w_acd002.w_docno  = STRING(n_docno, "9999999")
            NO-WAIT NO-ERROR.
            IF NOT AVAILABLE acd002 THEN DO:

               {ac/aco01102.i}
                ASSIGN
                n_aftnet = 0     n_entflg = "n"
                n_trnty1 = ""    n_docno  = 0  
                n_match  = 0     n_pmatch = 0
                n_pbal   = s_bal.

            END.
            ELSE DO:
               MESSAGE "Already matched - Use F9 to mofidy".
               ASSIGN
               s_bal    = s_bal + n_match
               n_aftnet = 0 
               n_entflg = "n"
               n_trnty1 = ""   
               n_docno  = 0
               n_match  = 0
               n_pmatch = 0.

               CLEAR FRAME nf1 ALL NO-PAUSE.

               LEAVE main.

            END.
         END.  /** n_match <> 0 **/

            DISPLAY
              /* n_curcod*/
                 n_trnty1   n_docno   n_policy
                 n_match  n_recno
                 n_trndat   acm001.agent
                 n_ref1      n_ref2
                 n_netamt  n_aftnet
                 n_prem    n_befnet
                 n_comm   n_other
                 s_bal
            WITH FRAME nf1.

    HIDE MESSAGE NO-PAUSE.
    MESSAGE "ก่อน  F1" s_fptr02.
    PAUSE.

         IF n_trnty1 <> "" THEN
            FIND acm001 USE-INDEX acm00101 WHERE 
                 acm001.trnty1 = n_trnty1  AND 
                 acm001.docno  = STRING(n_docno, "9999999") 
            NO-WAIT NO-ERROR.

         n_aftnet = n_befnet - n_match.

         IF s_zero AND n_aftnet <> 0 THEN DO:
            MESSAGE "Must be zero after matching".

            LEAVE main.
            NEXT.
         END.
         IF s_balsgn = "-" THEN DO:
            IF (s_bal + n_pmatch - n_match) > 0 THEN DO:
               MESSAGE "Amount matched exceeds unapplied balance".

               LEAVE main.
               NEXT.
            END.
         END.
         ELSE DO:
            IF (s_bal + n_pmatch - n_match) < 0 THEN DO:
               MESSAGE "Amount matched exceeds unapplied balance".

               LEAVE main.
               NEXT.
            END.
         END.
         s_bal = s_bal + n_pmatch - n_match.

         DISPLAY s_bal WITH FRAME nf1.
         PAUSE 0.

         IF n_match <> 0 THEN DO:
            FIND FIRST w_acd002 WHERE 
                       w_acd002.w_ctrty1 = s_trnty1  AND
                       w_acd002.w_cdocno = s_docno   AND
                       w_acd002.w_trnty1 = n_trnty1  AND
                       w_acd002.w_docno  = STRING(n_docno, "9999999")
            NO-WAIT NO-ERROR.
            IF NOT AVAILABLE acd002 THEN DO:

               {ac/aco01102.i}
            END.
         END.

         /**  Update Balance Outstanding  **/
        FIND acm001 WHERE RECID(acm001) = s_recid2.
        ASSIGN
         acm001.bal   = - s_bal
         acm001.baloc = (acm001.netloc / acm001.netamt) * s_bal
         acm001.baloc = - acm001.baloc.

         s_prgind = "01".

      IF s_prgind = "01" AND s_fptr02 <> 0 THEN
 
         RUN  ac/aco01104.


    PAUSE.


---kan*/

  END.
  

  LEAVE main.

  HIDE FRAME nf1 NO-PAUSE.
END.  /** repeat : main **/



/**/
kan---*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdDrCrold2 C-Win 
PROCEDURE pdDrCrold2 :
/*------------------------------------------------------------------------------
  Purpose:     ตัดทีละ 1 รายการ
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF BUFFER bufacm001_r FOR acm001.

n_aftnet = 0.        n_befnet = 0.

s_prog   = "WACE1002".
s_module = "D".


/*-------- เช็คว่า 2 record ต้องมีค่า เท่ากัน  ยังไม่ match  bal <> 0 -----------*/
    FIND acm001 USE-INDEX acm00101  WHERE     /* "M"  */
                acm001.trnty1 = wacm001_m.trnty1_m   AND    /* s_trnty1*/
                acm001.docno  = wacm001_m.docno_m           /* s_docno*/
    NO-WAIT NO-ERROR.
    IF NOT AVAILABLE acm001 THEN DO:    /*ถ้าไม่เจอ*/
        IF LOCKED acm001 THEN MESSAGE "Record is locked".
                                            ELSE MESSAGE "Not on Accounts master file".
        RETURN NO-APPLY.
    END.
    ELSE DO:    /* ถ้าเจอ */

        FIND bufacm001_r USE-INDEX acm00101  WHERE     /* "R"  */
                  bufacm001_r.trnty1 = wacm001_r.trnty1_r   AND    /* n_trnty1*/
                  bufacm001_r.docno  = wacm001_r.docno_r           /* _docno*/
        NO-WAIT NO-ERROR.
        IF NOT AVAILABLE bufacm001_r THEN DO:    /*ถ้าไม่เจอ*/
            IF LOCKED bufacm001_r THEN MESSAGE "Record is locked".
                                                        ELSE MESSAGE "Not on Accounts master file".
            RETURN NO-APPLY.
        END.
        ELSE DO:
            IF (acm001.bal <> - bufacm001_r.bal  ) OR (acm001.bal = 0 )   THEN DO:   /* ถ้า bal ไม่เท่ากัน  หรือ bal = 0 */
                MESSAGE "Policy  dose not matching  (bal = 0) "  VIEW-AS ALERT-BOX  ERROR.
                RETURN NO-APPLY.
            END.
        END.
    
    END.
    
/******************* ข้อมูลพร้อมที่จะทำการ match ****************/

main:
REPEAT:

/*kan
  CLEAR FRAME nf1 ALL NO-PAUSE.
  STATUS DEFAULT "F4=Menu                F13=Undo all".
  PAUSE 0.
*/

/*----  MATCHING  "M"  ----*/
  s_prgind = "01".

  s_trnty1   =  wacm001_m.trnty1_m.        /* "M" ??????? */
  s_docno  = wacm001_m.docno_m.       /* "1642227" ??????? */


  FIND acm001 USE-INDEX acm00101  WHERE     /* "M"  */
      acm001.trnty1 = wacm001_m.trnty1_m   AND    /* s_trnty1*/
      acm001.docno  = wacm001_m.docno_m           /* s_docno*/
  NO-WAIT NO-ERROR.

  IF NOT AVAILABLE acm001 THEN DO:
     IF LOCKED acm001 THEN MESSAGE "Record is locked".
                      ELSE MESSAGE "Not on Accounts master file".

     LEAVE main.
     NEXT.
  END.
    ASSIGN
    s_recid2 = RECID(acm001)
    s_trntyp = acm001.trnty1 + acm001.trnty2
    s_acno   = acm001.acno
    s_curcod = acm001.curcod
    s_trndat = acm001.trndat
    s_netamt = acm001.netamt
    s_netloc = acm001.netloc
    s_prgind = "01".

/*   HIDE FRAME nf1 NO-PAUSE. kan*/

  s_bal    = 0.
  s_balsgn = "".

    loop_crt:
    DO TRANSACTION:

    FIND acm001 WHERE RECID(acm001) = s_recid2.
    s_prgind = "00".
    
/*
    IF acm001.acno <> "" THEN DO:
       FIND xmm600 USE-INDEX xmm60001 WHERE xmm600.acno = acm001.acno
         NO-LOCK NO-ERROR.
       IF AVAILABLE xmm600 THEN DO:
         /*COLOR DISPLAY INPUT xmm600.name WITH FRAME nf1. */  /* kan */
         DISPLAY xmm600.name @ fin_acname WITH FRAME nf1.
       END.
    END.
    IF acm001.curcod <> "" THEN DO:
       FIND xmm012 USE-INDEX xmm01201 WHERE xmm012.curcod = acm001.curcod
         NO-LOCK NO-ERROR.
       IF AVAILABLE xmm012 THEN DO:
         /* COLOR DISPLAY INPUT xmm012.curdec WITH FRAME nf1. */   /*kan*/
         DISPLAY xmm012.curdec @ fis_curdec  WITH FRAME nf1.
       END.
    END.
    IF acm001.branch <> "" THEN DO:
       FIND xmm023 WHERE xmm023.branch = acm001.branch NO-LOCK NO-ERROR.
       IF AVAILABLE xmm023 THEN fin_brndes = xmm023.bdes.
                           ELSE fin_brndes = "".
       /* COLOR DISPLAY INPUT n_brndes WITH FRAME nf1. */  /*kan*/
       DISPLAY fin_brndes WITH FRAME nf1.
    END.

    IF acm001.ac1 <> "" THEN DO:
       FIND xmm201 USE-INDEX xmm20101 WHERE xmm201.glacno = acm001.ac1
         NO-LOCK NO-ERROR.
       IF AVAILABLE xmm201 THEN n_acdes1 = xmm201.gldes.
    END.
    IF acm001.ac2 <> "" THEN DO:
       FIND xmm201 USE-INDEX xmm20101 WHERE xmm201.glacno = acm001.ac2
         NO-LOCK NO-ERROR.
       IF AVAILABLE xmm201 THEN n_acdes2 = xmm201.gldes.
    END.
    IF acm001.ac3 <> "" THEN DO:
       FIND xmm201 USE-INDEX xmm20101 WHERE xmm201.glacno = acm001.ac3
         NO-LOCK NO-ERROR.
       IF AVAILABLE xmm201 THEN n_acdes3 = xmm201.gldes.
    END.
    IF acm001.ac4 <> "" THEN DO:
       FIND xmm201 USE-INDEX xmm20101 WHERE xmm201.glacno = acm001.ac4
         NO-LOCK NO-ERROR.
       IF AVAILABLE xmm201 THEN n_acdes4 = xmm201.gldes.
    END.
    IF acm001.ac5 <> "" THEN DO:
       FIND xmm201 USE-INDEX xmm20101 WHERE xmm201.glacno = acm001.ac5
         NO-LOCK NO-ERROR.
       IF AVAILABLE xmm201 THEN n_acdes5 = xmm201.gldes.
    END.
    IF acm001.ac6 <> "" THEN DO:
       FIND xmm201 USE-INDEX xmm20101 WHERE xmm201.glacno = acm001.ac6
         NO-LOCK NO-ERROR.
       IF AVAILABLE xmm201 THEN n_acdes6 = xmm201.gldes.
    END.
*/
    ASSIGN
    n_bal    = acm001.bal
    n_baloc  = acm001.baloc.
/*    n_acamt1 = acm001.amt1
 *     n_acamt2 = acm001.amt2
 *     n_acamt3 = acm001.amt3
 *     n_acamt4 = acm001.amt4
 *     n_acamt5 = acm001.amt5
 *     n_acamt6 = acm001.amt6.*/

    DISPLAY
      acm001.trnty1 + acm001.trnty2 @  fis_trntyp
      acm001.docno  @ fis_docno
      acm001.branch acm001.dociln
      /*--- A500178 ---
      acm001.acno   
      ------*/
      acm001.acno @ fi_acno /*--- A500178 ---*/
      acm001.ref
      acm001.prem   acm001.comm
      acm001.stamp  acm001.fee
      acm001.tax    
      acm001.bal    @ fin_bal
      acm001.curcod acm001.trndat
      acm001.baloc  @ fin_baloc

      acm001.vehreg
      acm001.insno    acm001.instot
    WITH FRAME nf1.

    s_bal    = - acm001.bal.
    IF s_bal > 0 THEN s_balsgn = "+".
                        ELSE s_balsgn = "-".

    ASSIGN
    s_auto   = NO
    s_comdat = ?
    s_defaul = "N"
    s_zero   = NO.

    s_fptr02 = 0.
    s_bptr02 = 0.

    IF s_auto THEN s_prgind = "04".
                    ELSE s_prgind = "05".

    ASSIGN
    n_aftnet = 0
    n_entflg = "n"
    n_trnty1 = ""
    /*n_docno  = 0 */ n_docno  = "" /*A60-0267*/
    n_match  = 0
    n_pmatch = 0
    n_pbal   = s_bal.

/*----  MATCHING  "R"  ----*/ 
    s_mchdat = s_latdat.           /* TODAY ??????? */

    n_trnty1  =  wacm001_r.trnty1_r .     /* "R" ??????? */
    /*n_docno = INT(wacm001_r.docno_r) .  /* 1000064 ??????? */ */
    n_docno = wacm001_r.docno_r .         /* A60-0267*/

    DISPLAY
      s_mchdat  @ fis_mchdat
      acm001.policy
      acm001.comdat
      acm001.recno
    WITH FRAME nf1.

            /* ------------------- */

            FIND FIRST  w_acd002 WHERE
                        w_acd002.w_ctrty1 = s_trnty1  AND
                        w_acd002.w_cdocno = s_docno   AND
                        w_acd002.w_trnty1 = n_trnty1  AND
                        /*w_acd002.w_docno  = STRING(n_docno, "9999999") */
                        w_acd002.w_docno  = n_docno /*A60-0267*/
            NO-WAIT NO-ERROR.
            IF AVAILABLE acd002 THEN DO:
               MESSAGE "Record already exist".
                ASSIGN
                s_bal    = s_bal + n_match
                n_aftnet = 0
                n_entflg = "n"
                n_trnty1 = ""
                /*n_docno  = 0 */  n_docno  = "" /*A60-0267*/
                n_match  = 0.

               LEAVE main.
               NEXT.
            END.

            FIND  acm001 USE-INDEX acm00101  WHERE
                  acm001.trnty1 = n_trnty1   AND
                  /*acm001.docno  = STRING(n_docno, "9999999") */
                  acm001.docno  = n_docno /*A60-0267*/
            NO-WAIT NO-ERROR.
            IF NOT AVAILABLE acm001 THEN DO:
               MESSAGE "Transaction Type/Document No. not on A/C master file".

               LEAVE main.

            END.
            ELSE DO:
               IF acm001.acno <> s_acno THEN DO:
                  MESSAGE "Transaction is in different account " acm001.acno.

                  LEAVE main.
                  NEXT.
               END.
               IF acm001.curcod <> s_curcod THEN DO:
                  MESSAGE
                    "All transaction matched must be of the same currency".

                  LEAVE main.
                  NEXT.
               END.
            ASSIGN                
               n_trndat   = acm001.trndat     n_curcod   = acm001.curcod
               n_netamt   = acm001.netamt     n_prem     = acm001.prem
               n_comm     = acm001.comm       n_policy   = acm001.policy
               n_recno    = acm001.recno
               n_ref         = acm001.ref
/*               n_ref1     = SUBSTR(acm001.ref,1,45)
               n_ref2     = SUBSTR(acm001.ref,46,13)
*/
               n_befnet   = acm001.bal
               n_other    = acm001.stamp + acm001.tax + acm001.fee.

               IF n_pmatch = 0 THEN DO:
                  IF s_defaul = "Z" THEN n_match = 0.
                  IF s_defaul = "N" THEN n_match = acm001.bal.
                  IF s_defaul = "G" THEN DO :
                     IF acm001.bal > 0 THEN n_match = acm001.bal - acm001.comm.
                     ELSE IF acm001.bal < 0 THEN
                          n_match = acm001.bal - acm001.comm.
                     ELSE n_match = acm001.comm.
                  END.
               END.

               n_entflg = "Y".
            END.

            DISPLAY
              /* n_curcod*/
                 n_trnty1 @ fin_trnty1
                 n_docno  @ fin_docno
                 n_policy @ fin_policy
                 n_match  @ fin_match
                 n_recno  @ fin_recno
                 n_trndat @ fin_trndat
                 /*--- A500178 ---
                 acm001.agent
                 ------*/
                 s_agent  @ fi_agent
                 n_ref    @ fin_ref
                 n_netamt @ fin_netamt
                 n_aftnet @ fin_aftnet
                 n_prem   @ fin_prem
                 n_befnet @ fin_befnet
                 n_comm   @ fin_comm
                 n_other  @ fin_other
                 s_bal    @ fis_bal
            WITH FRAME nf1.

            /* ------------------- */

            n_aftnet = n_befnet + n_pmatch - n_match.
            IF s_zero AND n_aftnet <> 0 THEN DO:
               MESSAGE "Must be zero after matching".

               LEAVE main.
               NEXT.
            END.
            IF s_balsgn = "-" THEN DO:
               IF (s_bal + n_pmatch - n_match) > 0 THEN DO:
                  MESSAGE "Amount matched exceeds unapplied balance".

                  LEAVE main.
                  NEXT.
               END.
            END.
            ELSE DO:
               IF (s_bal + n_pmatch - n_match) < 0 THEN DO:
                  MESSAGE "Amount matched exceeds unapplied balance".

                  LEAVE main.
                  NEXT.
               END.
            END.
            s_bal = s_bal + n_pmatch - n_match.

            DISPLAY n_aftnet @ fin_aftnet
                            s_bal      @ fis_bal 
            WITH FRAME nf1.

            IF n_pmatch <> n_match THEN DO:
               n_entflg = "y".
            END.
            n_pmatch = n_match.


        /*    PAUSE MESSAGE "ก่อน PAGE-DOWN".*/
      /*
      IF LASTKEY = KEYCODE("PAGE-DOWN") THEN DO:
      */
         n_aftnet = n_befnet - n_match.
         IF s_zero AND n_aftnet <> 0 THEN DO:
            MESSAGE "Must be zero after matching".

            LEAVE main.
            NEXT.
         END.
         IF s_balsgn = "-" THEN DO:
            IF (s_bal + n_pmatch - n_match) > 0 THEN DO:
               MESSAGE "Amount matched exceeds unapplied balance".

               LEAVE main.
               NEXT.
            END.
         END.
         ELSE DO:
            IF (s_bal + n_pmatch - n_match) < 0 THEN DO:
               MESSAGE "Amount matched exceeds unapplied balance".

               LEAVE main.
               NEXT.
            END.
         END.
         s_bal = s_bal + n_pmatch - n_match.

        DISPLAY  n_aftnet @ fin_aftnet  
                          s_bal     @ fis_bal
        WITH FRAME nf1.

         /*PAUSE 0.*/


/*pause message "sadsfdfasdasfd".*/

         IF n_match <> 0 THEN DO:

            FIND acm001 USE-INDEX acm00101 WHERE 
                 acm001.trnty1 = n_trnty1  AND 
                 /*acm001.docno  = STRING(n_docno, "9999999")  */
                 acm001.docno  = n_docno /*A60-0267*/
            NO-WAIT NO-ERROR.

            FIND FIRST w_acd002 WHERE 
                       w_acd002.w_ctrty1 = s_trnty1  AND
                       w_acd002.w_cdocno = s_docno   AND
                       w_acd002.w_trnty1 = n_trnty1  AND
                       /*w_acd002.w_docno  = STRING(n_docno, "9999999") */
                       w_acd002.w_docno  = n_docno /*A60-0267*/

            NO-WAIT NO-ERROR.
            IF NOT AVAILABLE acd002 THEN DO:
        
               {wac/wac01102.i}             /* {ac/aco01102.i} */  /* kan */

                ASSIGN
                n_aftnet = 0     n_entflg = "n"
                n_trnty1 = ""    /*n_docno  = 0   */  n_docno  = "" /*A60-0267*/
                n_match  = 0     n_pmatch = 0
                n_pbal   = s_bal.

            END.
            ELSE DO:
               MESSAGE "Already matched - Use F9 to mofidy".
               ASSIGN
               s_bal    = s_bal + n_match
               n_aftnet = 0 
               n_entflg = "n"
               n_trnty1 = ""   
               /*n_docno  = 0 */   n_docno  = "" /*A60-0267*/
               n_match  = 0
               n_pmatch = 0.

               /* CLEAR FRAME nf1 ALL NO-PAUSE. kan*/

               LEAVE main.

            END.
         END.  /** n_match <> 0 **/

            DISPLAY
              /* n_curcod*/
               n_trnty1 @ fin_trnty1
               n_docno  @ fin_docno
               n_policy @ fin_policy
               n_match  @ fin_match
               n_recno  @ fin_recno
               n_trndat @ fin_trndat
               /*--- A500178 ---
               acm001.agent
               ------*/
               s_agent  @ fi_agent
               n_ref    @ fin_ref
               n_netamt @ fin_netamt
               n_aftnet @ fin_aftnet
               n_prem   @ fin_prem
               n_befnet @ fin_befnet
               n_comm   @ fin_comm
               n_other  @ fin_other
               s_bal    @ fis_bal
            WITH FRAME nf1.
/*kan
    HIDE MESSAGE NO-PAUSE.
    MESSAGE "ก่อน  F1" s_fptr02.
    PAUSE.
*/
         IF n_trnty1 <> "" THEN
            FIND acm001 USE-INDEX acm00101 WHERE 
                 acm001.trnty1 = n_trnty1  AND 
                 /*acm001.docno  = STRING(n_docno, "9999999")  */
                 acm001.docno  = n_docno /*A60-0267*/ 
            NO-WAIT NO-ERROR.

         n_aftnet = n_befnet - n_match.

         IF s_zero AND n_aftnet <> 0 THEN DO:
            MESSAGE "Must be zero after matching".

            LEAVE main.
            NEXT.
         END.
         IF s_balsgn = "-" THEN DO:
            IF (s_bal + n_pmatch - n_match) > 0 THEN DO:
               MESSAGE "Amount matched exceeds unapplied balance".

               LEAVE main.
               NEXT.
            END.
         END.
         ELSE DO:
            IF (s_bal + n_pmatch - n_match) < 0 THEN DO:
               MESSAGE "Amount matched exceeds unapplied balance".

               LEAVE main.
               NEXT.
            END.
         END.
         s_bal = s_bal + n_pmatch - n_match.

         DISPLAY s_bal  @ fis_bal  WITH FRAME nf1.
         PAUSE 0.

         IF n_match <> 0 THEN DO:
            FIND FIRST w_acd002 WHERE 
                       w_acd002.w_ctrty1 = s_trnty1  AND
                       w_acd002.w_cdocno = s_docno   AND
                       w_acd002.w_trnty1 = n_trnty1  AND
                       /*w_acd002.w_docno  = STRING(n_docno, "9999999") */
                       w_acd002.w_docno  = n_docno /*A60-0267*/
            NO-WAIT NO-ERROR.
            IF NOT AVAILABLE acd002 THEN DO:

               {wac/wac01102.i}             /* {ac/aco01102.i} */  /* kan */

            END.
         END.

         /**  Update Balance Outstanding  **/
        FIND acm001 WHERE RECID(acm001) = s_recid2.
        ASSIGN
         acm001.bal   = - s_bal
         acm001.baloc = (acm001.netloc / acm001.netamt) * s_bal
         acm001.baloc = - acm001.baloc.

         s_prgind = "01".


      IF s_prgind = "01" AND s_fptr02 <> 0 THEN  DO:
 
         RUN wac/wac01104.              /* create acd002 -> RUN  ac/aco01104. */ /* kan */

        n_chkmatch = YES.
      END.

/*    PAUSE.*/


  END.
  

  LEAVE main.

/*  HIDE FRAME nf1 NO-PAUSE. kan*/

END.  /** repeat : main **/



/**/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

