&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
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
  CHonlatis J. A59-0603 11/01/2017

-------------------------------------------D07059000239-----------------------------*/
/*          This .W file was created with the Progress AppBuilder.      */
/*----------------------------------------------------------------------*/

/* Create an unnamed pool to store all the widgets created 
     by this procedure. This is a good default which assures
     that this procedure's triggers and internal procedures 
     will execute in this procedure's storage, and that proper
     cleanup will occur on deletion of the procedure. */
/*AZR00407*/
DEFINE NEW SHARED VAR n_frmdat    LIKE ACM002.TRNDAT INIT TODAY.
DEFINE NEW SHARED VAR n_todat     LIKE ACM002.ENTDAT INIT TODAY.
/*--- A500178 ---
DEFINE NEW SHARED VAR n_branfr    AS CHAR FORMAT "X(1)".
DEFINE NEW SHARED VAR n_branto    AS CHAR FORMAT "X(1)".
------*/
DEFINE NEW SHARED VAR n_branfr    AS CHAR FORMAT "X(2)".
DEFINE NEW SHARED VAR n_branto    AS CHAR FORMAT "X(2)".
/*--- A500178 ---*/
DEFINE NEW SHARED VAR n_dattyp    AS INTE FORMAT "9" INITIAL 1.
/*--- A500178 ---
/*----- A47-0176 -----*/
DEFINE NEW SHARED VAR n_acno      AS CHAR FORMAT "X(7)".
------*/
DEFINE NEW SHARED VAR n_acno      AS CHAR FORMAT "X(10)".
/*--- A500178 ---*/
DEFINE NEW SHARED VAR n_vchtyf    AS CHAR FORMAT "X(52)" INITIAL "".
DEFINE NEW SHARED VAR n_vchtyt    AS CHAR FORMAT "X(52)" INITIAL "".  /*A47-0187*/
/*--- END A47-0176 ---*/
DEFINE NEW SHARED VAR n_kfktyp    AS INTE FORMAT "9" INITIAL 2.
DEFINE NEW SHARED VAR n_kfkdet    AS CHAR FORMAT "X(15)" EXTENT 2
                                  INITIAL ["Knock For Knock","ALL"].
DEFINE NEW SHARED VAR n_suspen    AS INTE FORMAT "9" INITIAL 2.
DEFINE NEW SHARED VAR n_susdet    AS CHAR FORMAT "X(14)" EXTENT 2
                                  INITIAL ["Exclude Inward","ALL"].
DEFINE NEW SHARED VAR n_reptyp    AS INTE FORMAT "9" INITIAL 1.
DEFINE NEW SHARED VAR n_lintyp    AS INTE FORMAT "9" INITIAL 1. 
DEFINE NEW SHARED VAR n_type      AS INTE FORMAT "9" INITIAL 1.
DEFINE NEW SHARED VAR n_write1    AS CHAR FORMAT "X(25)".
DEFINE NEW SHARED VAR n_write3    AS CHAR FORMAT "X(25)".
DEFINE NEW SHARED VAR n_output    AS INTE FORMAT "9" INITIAL 1.

DEFINE NEW SHARED VAR n_write     AS CHAR FORMAT "X(25)" INITIAL ["PRINTER"].
DEFINE            VAR n_head      AS CHAR FORMAT "X(22)"
                                  INITIAL ["เรียกตาม Type(Y,B,Z,C)"].
/*end AZR00407*/
/*AZR00409*/
CREATE WIDGET-POOL.
DEFINE NEW SHARED STREAM ns1.  /* Output to Printer & Text */
DEFINE NEW SHARED STREAM ns2.  /* Output to Excel */


/*--- A500178 ---
DEFINE SHARED VAR n_branfr  AS CHAR FORMAT "X(1)".
DEFINE SHARED VAR n_branto  AS CHAR FORMAT "X(1)".
DEFINE SHARED VAR n_acno    AS CHAR FORMAT "X(7)".      /*A47-0176*/
------*/



/*--- A500178 ---*/

/*DEFINE VAR today       AS DATE FORMAT "99/99/9999".*/ /*Comment A51-0187*/
DEFINE NEW SHARED VAR nvtoday       AS DATE FORMAT "99/99/9999". /*Change A51-0187*/
DEFINE VAR line_cnt      AS INTE INITIAL [0].
DEFINE VAR n_page        AS INTE FORMAT ">>>9"         INITIAL[1].
DEFINE VAR n_cnt         AS INTE FORMAT ">>>,>>>,>>9"  INITIAL[0].
DEFINE NEW SHARED VAR n_stime       AS INTE.
DEFINE NEW SHARED VAR n_etime       AS INTE.
/*DEFINE VAR nvtime        AS CHAR.*/ /*Comment A51-0187*/
DEFINE NEW SHARED VAR nvtime        AS CHAR. /*Change A51-0187*/
DEFINE VAR nvtitle       AS CHAR.
/*DEFINE VAR nvll          AS CHAR FORMAT "X(198)". 
DEFINE VAR nvll1         AS CHAR FORMAT "X(198)".*/ /*A51-0187*/
DEFINE VAR nvll          AS CHAR FORMAT "X(210)". /*A51-0187*/
DEFINE VAR nvll1         AS CHAR FORMAT "X(210)". /*A51-0187*/
DEFINE VAR n_dtime       AS CHAR FORMAT "X(8)".
DEFINE VAR n_flag        AS CHAR FORMAT "X" INITIAL["y"].

DEFINE VAR w_etime       AS CHAR FORMAT "X(8)".
DEFINE VAR w_condat      AS CHAR FORMAT "X(10)". /* A4500208 */
DEFINE VAR w_entdat      AS CHAR FORMAT "X(10)". /*Porn A51-0187*/
DEFINE VAR w_docno       LIKE acm001.docno  FORMAT "X(10)" . /* Benjaporn J. A60-0267 date 27/06/2017 */
DEFINE VAR w_trnty1      LIKE acm001.trnty1 INITIAL[""].
DEFINE VAR w_name        LIKE xmm101.name   INITIAL[""].
DEFINE VAR w_tdeb        LIKE Acm001.prem   INITIAL[0].
DEFINE VAR w_tdebl       LIKE Acm001.prem   INITIAL[0].
DEFINE VAR w_tndeb       LIKE Acm001.prem   INITIAL[0].
DEFINE VAR w_tndebl      LIKE Acm001.prem   INITIAL[0].
DEFINE VAR w_gtot        LIKE Acm001.prem   INITIAL[0].
DEFINE VAR w_gtotl       LIKE Acm001.prem   INITIAL[0].
DEFINE VAR dspt          LIKE Acm001.prem   INITIAL[0].
DEFINE VAR dsptl         LIKE Acm001.prem   INITIAL[0].
DEFINE VAR dsnpt         LIKE Acm001.prem   INITIAL[0].
DEFINE VAR dsnptl        LIKE Acm001.prem   INITIAL[0].
DEFINE VAR ndspt         LIKE Acm001.prem   INITIAL[0].
DEFINE VAR ndsptl        LIKE Acm001.prem   INITIAL[0].
DEFINE VAR ndsnpt        LIKE Acm001.prem   INITIAL[0].
DEFINE VAR ndsnptl       LIKE Acm001.prem   INITIAL[0].

/* Variables for printing program */
DEFINE VAR n_ptrid       LIKE sym027.ptrid.
DEFINE VAR n_frmno       LIKE sym027.frmno.
DEFINE VAR n_ptrtyp      LIKE sym025.ptrtyp.
DEFINE VAR n_i           AS INTEGER.
DEFINE VAR nv_prtno      AS CHAR FORMAT "X".
DEFINE VAR nv_num        AS CHAR FORMAT "X(3)".
DEFINE VAR nv_refSub     AS INT.
DEFINE VAR nvoutput      AS CHAR FORMAT "X(12)".

/*  ADD BY CHUCHI  MODIFY BY UBOL 21/06/93 */
DEFINE VAR n_usrid       LIKE Acm001.USRID.
DEFINE VAR n_totprem     LIKE Acm001.PREM.
DEFINE VAR w_tprem       LIKE Acm001.PREM.
DEFINE VAR w_tcomm       LIKE Acm001.COMM.
DEFINE VAR w_tstamp      LIKE Acm001.STAMP.
DEFINE VAR w_tfee        LIKE Acm001.FEE.
DEFINE VAR w_ttax        LIKE Acm001.TAX.

DEFINE VAR w_tnprem      LIKE Acm001.PREM.
DEFINE VAR w_tncomm      LIKE Acm001.COMM.
DEFINE VAR w_tnstamp     LIKE Acm001.STAMP.
DEFINE VAR w_tnfee       LIKE Acm001.FEE.
DEFINE VAR w_tntax       LIKE Acm001.TAX.

DEFINE VAR w_gprem       LIKE Acm001.PREM.
DEFINE VAR w_gcomm       LIKE Acm001.COMM.
DEFINE VAR w_gstamp      LIKE Acm001.STAMP.
DEFINE VAR w_gfee        LIKE Acm001.FEE.
DEFINE VAR w_gtax        LIKE Acm001.TAX.

/*--- A450208 08/2002  D.Sansom ----------------------------------------------*/
DEFINE VAR nvtype        AS CHAR  FORMAT "!!"             INITIAL "".
DEFINE VAR nvamt         AS DECI  FORMAT "->>,>>>,>>>,>>9.99" INITIAL 0.

/*lek---
DEFINE WORKFILE wList
       FIELD wbranch AS CHAR FORMAT "X"
       FIELD wConDat AS CHAR FORMAT "X(10)"
       FIELD wAcno   AS CHAR
       FIELD wType   AS CHAR FORMAT "!!"
       FIELD wDocno  AS CHAR
       FIELD wPolicy AS CHAR FORMAT "X-X-XX-XX/XXXXXXXXXX"
       FIELD wPrem   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
       FIELD wComm   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
       FIELD wNet    AS DECI FORMAT "->>,>>>,>>>,>>9.99"
       /*-------------------- A47-0213 -----------------*/
       FIELD wPremc  AS DECI FORMAT "->>,>>>,>>>,>>9.99"
       FIELD wPremb  AS DECI FORMAT "->>,>>>,>>>,>>9.99"
       FIELD wPremys AS DECI FORMAT "->>,>>>,>>>,>>9.99"
       FIELD wPremzs AS DECI FORMAT "->>,>>>,>>>,>>9.99"
       /*----------------- END A47-0213 ----------------*/
       FIELD wRefno  AS CHAR
       FIELD wUsrid  AS CHAR
       FIELD wcheck  AS INTE FORMAT "9" INITIAL 0.
       .
---lek*/

/*lek---*/
DEFINE NEW SHARED TEMP-TABLE wList
       FIELD wbranch AS CHAR FORMAT "X(2)"  /*-- ปรับจาก "X" เป็น  "X(2)" A500178 --*/
       FIELD wConDat AS CHAR FORMAT "X(10)"
       FIELD wAcno   AS CHAR FORMAT "X(10)" /*-- เพิ่ม  "X(10)" A500178 --*/
       FIELD wType   AS CHAR FORMAT "!!"
       FIELD wDocno  AS CHAR FORMAT "X(10)"  /* Benjaporn J. A60-0267 date 27/06/2017 */
       FIELD wPolicy AS CHAR FORMAT "XX-XX-XX/XXXXXXXXXX"  /*เปลี่ยน FORMAT DISPLAY ของ  Policy จาก  X-X-XX-XX/XXXXXX เป็น  XX-XX-XX/XXXXXX -- A500178 --*/
       /*FIELD wEndno  AS CHAR FORMAT "X(8)"                  /* A48-0448 */*//*Comment A53-0039*/
       FIELD wEndno  AS CHAR FORMAT "X(9)"                  /* A48-0448 *//*A53-0039*/
       FIELD wTrndat AS CHAR FORMAT "X(10)"                 /* A48-0531 */
       FIELD wPrem   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
       FIELD wComm   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
       FIELD wNet    AS DECI FORMAT "->>,>>>,>>>,>>9.99"
       FIELD wPremx  AS DECI FORMAT "->>,>>>,>>>,>>9.99"    /* A48-0448 */
       FIELD wPremw  AS DECI FORMAT "->>,>>>,>>>,>>9.99"    /* A48-0448 */
       /*-------------------- A47-0213 -----------------*/
       FIELD wPremc  AS DECI FORMAT "->>,>>>,>>>,>>9.99"
       FIELD wPremb  AS DECI FORMAT "->>,>>>,>>>,>>9.99"
       FIELD wPremys AS DECI FORMAT "->>,>>>,>>>,>>9.99"
       FIELD wPremzs AS DECI FORMAT "->>,>>>,>>>,>>9.99"
       /*----------------- END A47-0213 ----------------*/
       FIELD wRefno  AS CHAR
       FIELD wRefRV  AS CHAR 
       FIELD wRefDoc AS CHAR FORMAT "X(10)"  /* Benjaporn J. A60-0267 date 27/06/2017 */
       FIELD wUsrid  AS CHAR FORMAT "X(7)"
       FIELD wEntDat AS CHAR FORMAT "X(10)" /*-- Add Column Entry Date A51-0187 --*/
       /*--    Add by Narin L A58-0046--*/
       FIELD wName      AS CHAR FORMAT "X(70)"   
       FIELD wStamp     AS DECI FORMAT "->>,>>>,>>>,>>9.99"
       FIELD wPremstm   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
       FIELD wTAXone    AS DECI FORMAT "->>,>>>,>>>,>>9.99"
       FIELD wTaxno     AS CHAR 
       /*--End Add by Narin L A58-0046--*/

       FIELD wcheck  AS INTE FORMAT "9" INITIAL 0
       INDEX ind01 IS PRIMARY wbranch ASCENDING
                              wConDat ASCENDING
                              wType   ASCENDING
                              wRefno  ASCENDING
                              wPolicy ASCENDING

       INDEX ind02            wType   ASCENDING
                              wDocno  ASCENDING.
/*---lek*/

DEFINE BUFFER bw FOR wList.

DEFINE BUFFER bAcm001 FOR acm001.   /*A49-0136*/
/*----------------------------------------------------------------------------*/
  
DEFINE VAR nvzp  AS DECI FORMAT "->>,>>>,>>>,>>9.99" INIT 0.
DEFINE VAR nvyp  AS DECI FORMAT "->>,>>>,>>>,>>9.99" INIT 0.
DEFINE VAR nvzc  AS DECI FORMAT "->>,>>>,>>>,>>9.99" INIT 0.
DEFINE VAR nvyc  AS DECI FORMAT "->>,>>>,>>>,>>9.99" INIT 0.
DEFINE VAR nvzs  AS DECI FORMAT "->>,>>>,>>>,>>9.99" INIT 0.
DEFINE VAR nvys  AS DECI FORMAT "->>,>>>,>>>,>>9.99" INIT 0.
DEFINE VAR nvc   AS DECI FORMAT "->>,>>>,>>>,>>9.99" INIT 0.
DEFINE VAR nvb   AS DECI FORMAT "->>,>>>,>>>,>>9.99" INIT 0.
DEFINE VAR nvzx  AS DECI FORMAT "->>,>>>,>>>,>>9.99" INIT 0.
DEFINE VAR nvyw  AS DECI FORMAT "->>,>>>,>>>,>>9.99" INIT 0.

/*------------------ A46-0074 -----------------*/
DEFINE BUFFER bwlist FOR wList.
DEFINE VAR nys          AS DECI FORMAT "->>,>>>,>>>,>>9.99" INIT 0.
DEFINE VAR nzs          AS DECI FORMAT "->>,>>>,>>>,>>9.99" INIT 0.
DEFINE VAR cozp         AS DECI FORMAT "->>,>>>,>>>,>>9.99" INIT 0.
DEFINE VAR coyp         AS DECI FORMAT "->>,>>>,>>>,>>9.99" INIT 0.
DEFINE VAR nv_prem      AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEFINE VAR nv_comm      AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEFINE VAR nv_totnet    AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEFINE VAR nv_refno     AS INTE FORMAT "99" INITIAL 0.
DEFINE VAR n_condat     AS CHAR FORMAT "X(10)".
DEFINE VAR nv_ref       AS CHAR FORMAT "X(60)".
DEFINE VAR nv_refRV     AS CHAR FORMAT "X(10)".
DEFINE VAR nv_refDoc    AS CHAR FORMAT "X(10)".
DEFINE VAR n_write2     AS CHAR FORMAT "X(25)".
DEFINE VAR n_chk  AS CHAR FORMAT "X(10)".
/*DEFINE VAR n_repdet     AS CHAR FORMAT "X(07)".*/ /*Comment A51-0187*/
DEFINE NEW SHARED VAR n_repdet     AS CHAR FORMAT "X(07)". /*Change A51-0187*/
DEFINE VAR n_suschk     AS LOGICAL INITIAL NO.
/*---------------- END A46-0074 ---------------*/

DEFINE VAR nvbr  AS CHAR INIT "".

/*------------------ A47-0213 -----------------*/
DEFINE VAR nv_premc     AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEFINE VAR nv_premb     AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEFINE VAR nv_premys    AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEFINE VAR nv_premzs    AS DECI FORMAT "->>,>>>,>>>,>>9.99".
/*---------------- END A47-0213 ---------------*/

/*------------------ A48-0448 -----------------*/
DEFINE VAR nv_premx     AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEFINE VAR nv_premw         AS DECI FORMAT "->>,>>>,>>>,>>9.99".
/*---------------- END A48-0448 ---------------*/

DEFINE VAR nv_posit     AS INTE.                /*A47-0252*/
DEFINE VAR nv_vouch     AS CHAR FORMAT "X(10)"
                           INITIAL["RV,PV,JV"].  /*A47-0252*/

/*-------------08/10/2002 -------------------*/
DEFINE VAR nv_output   AS CHAR.
DEFINE VAR nv_output2  AS CHAR.
/*------------- END MIAW --------------------*/

/* kan A47-0298 */
/*DEF VAR nv_acname AS CHAR FORMAT "x(65)".*/ /*Comment A51-0187*/
DEF NEW SHARED VAR nv_acname AS CHAR FORMAT "x(65)". /*Change A51-0187*/
/**/

/*------------- Porn A51-0187 -----------------*/
DEFINE VAR nvzpa      AS DECI FORMAT "->>,>>>,>>>,>>9.99" INIT 0.
DEFINE VAR nvypa      AS DECI FORMAT "->>,>>>,>>>,>>9.99" INIT 0.
DEFINE VAR nvzp1      AS DECI FORMAT "->>,>>>,>>>,>>9.99" INIT 0.
DEFINE VAR nvyp1      AS DECI FORMAT "->>,>>>,>>>,>>9.99" INIT 0.
DEFINE VAR nvzc1      AS DECI FORMAT "->>,>>>,>>>,>>9.99" INIT 0.
DEFINE VAR nvyc1      AS DECI FORMAT "->>,>>>,>>>,>>9.99" INIT 0.
DEFINE VAR nvzs1      AS DECI FORMAT "->>,>>>,>>>,>>9.99" INIT 0.
DEFINE VAR nvys1      AS DECI FORMAT "->>,>>>,>>>,>>9.99" INIT 0.
DEFINE VAR nvc1       AS DECI FORMAT "->>,>>>,>>>,>>9.99" INIT 0.
DEFINE VAR nvb1       AS DECI FORMAT "->>,>>>,>>>,>>9.99" INIT 0.
DEFINE VAR nvzx1      AS DECI FORMAT "->>,>>>,>>>,>>9.99" INIT 0.
DEFINE VAR nvyw1      AS DECI FORMAT "->>,>>>,>>>,>>9.99" INIT 0.
DEFINE VAR nvzpa1     AS DECI FORMAT "->>,>>>,>>>,>>9.99" INIT 0.
DEFINE VAR nvypa1     AS DECI FORMAT "->>,>>>,>>>,>>9.99" INIT 0.
DEFINE VAR coyp1      AS DECI FORMAT "->>,>>>,>>>,>>9.99" INIT 0.
DEFINE VAR cozp1      AS DECI FORMAT "->>,>>>,>>>,>>9.99" INIT 0.

DEFINE VAR nvprem      AS DECI FORMAT "->>,>>>,>>>,>>9.99" INIT 0.
DEFINE VAR nvcomm      AS DECI FORMAT "->>,>>>,>>>,>>9.99" INIT 0.
DEFINE VAR nvnet       AS DECI FORMAT "->>,>>>,>>>,>>9.99" INIT 0.
DEFINE VAR nvpremx     AS DECI FORMAT "->>,>>>,>>>,>>9.99" INIT 0.
DEFINE VAR nvpremw     AS DECI FORMAT "->>,>>>,>>>,>>9.99" INIT 0.
DEFINE VAR nvpremzs    AS DECI FORMAT "->>,>>>,>>>,>>9.99" INIT 0.
DEFINE VAR nvpremys    AS DECI FORMAT "->>,>>>,>>>,>>9.99" INIT 0.
DEFINE VAR nvpremc     AS DECI FORMAT "->>,>>>,>>>,>>9.99" INIT 0.
DEFINE VAR nvpremb     AS DECI FORMAT "->>,>>>,>>>,>>9.99" INIT 0.
DEFINE VAR nv_pv      AS CHAR FORMAT "X(2)". 
DEFINE VAR nv_rv      AS CHAR FORMAT "X(2)".
DEFINE VAR nv_jv      AS CHAR FORMAT "X(2)".
DEFINE VAR n_branch   AS CHAR FORMAT "X(2)".
DEFINE VAR n_num      AS INTE INIT 59900.
DEFINE VAR n_cut      AS INTE .
/*---     Add A58-0046 ----*/
DEFINE VAR nv_name      AS CHAR FORMAT "X(70)" INIT "" .
DEFINE VAR nv_stamp     AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEFINE VAR nv_Premstm   AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEFINE VAR nv_TAXONE    AS DECI FORMAT "->>,>>>,>>>,>>9.99".


/*--- End Add A58-0046 ----*/

DEFINE VAR w_branch   AS CHAR FORMAT "X(2)".
/*end AZR00409*/


DEFINE VAR n_pname       AS CHAR FORMAT "X(10)".



DEF VAR nv_rvrefsum    AS CHAR INIT "".

DEF VAR nv_sumstamp AS  DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nv_Tax1     AS DECI FORMAT "->>,>>>,>>>,>>9.99".

DEF VAR nv_taxno AS CHAR INIT "".


DEFINE NEW SHARED TEMP-TABLE wSum
       FIELD w_RV       AS CHAR FORMAT "X(6)"
       FIELD w_RVdoc    AS CHAR FORMAT "X(15)"
       FIELD w_Sumstamp AS DECI FORMAT "->>,>>>,>>>,>>9.99"
       FIELD w_Tax1     AS DECI FORMAT "->>,>>>,>>>,>>9.99".
       




/* ***************************  Definitions  ************************** */

/* Parameters Definitions ---                                           */

/* Local Variable Definitions ---                                       */

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fe_form

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS EXIT 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON EXIT 
     LABEL "EXIT" 
     SIZE 15 BY 1.14.

DEFINE BUTTON BUTTON-1 
     LABEL "OK" 
     SIZE 15 BY 1.14.

DEFINE BUTTON BUTTON-2 
     LABEL "CANCEL" 
     SIZE 15 BY 1.14.

DEFINE VARIABLE fi_branchF AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 4.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_branchT AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 4.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_condate AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_condateT AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_outputto AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 27 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_poline AS INTEGER FORMAT "-9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 4.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 69.5 BY 12.62
     BGCOLOR 8 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fe_form
     EXIT AT ROW 17 COL 56.33
     "          LIST OF WITHHOLDING" VIEW-AS TEXT
          SIZE 51 BY 1.67 AT ROW 1.48 COL 16
          BGCOLOR 8 FONT 2
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 79.17 BY 18.05
         BGCOLOR 3 .

DEFINE FRAME FRAME-B
     fi_condate AT ROW 2.52 COL 26.17 COLON-ALIGNED NO-LABEL
     fi_condateT AT ROW 4.14 COL 26.17 COLON-ALIGNED NO-LABEL
     fi_branchF AT ROW 5.71 COL 26.17 COLON-ALIGNED NO-LABEL
     fi_branchT AT ROW 7.24 COL 26.17 COLON-ALIGNED NO-LABEL
     fi_poline AT ROW 8.76 COL 26.17 COLON-ALIGNED NO-LABEL
     fi_outputto AT ROW 10.33 COL 26.17 COLON-ALIGNED NO-LABEL
     BUTTON-1 AT ROW 11.95 COL 17.5
     BUTTON-2 AT ROW 11.95 COL 35.5
     "[1 = All   2 = All Exp. Pa/เบี้ย]   3 = PA Only" VIEW-AS TEXT
          SIZE 35 BY .62 AT ROW 9.05 COL 34
          BGCOLOR 8 
     "TO :" VIEW-AS TEXT
          SIZE 4 BY .62 AT ROW 4.33 COL 20.83
          BGCOLOR 8 
     "TO :" VIEW-AS TEXT
          SIZE 4 BY .62 AT ROW 7.43 COL 20.83
          BGCOLOR 8 
     "Branch From :" VIEW-AS TEXT
          SIZE 12 BY .62 AT ROW 5.91 COL 13.17
          BGCOLOR 8 
     "Policy Type :" VIEW-AS TEXT
          SIZE 12 BY .62 AT ROW 8.95 COL 14.5
          BGCOLOR 8 
     "Contra Date From :" VIEW-AS TEXT
          SIZE 15 BY .62 AT ROW 2.71 COL 9.67
          BGCOLOR 8 
     "Output To :" VIEW-AS TEXT
          SIZE 11 BY .62 AT ROW 10.52 COL 15.67
          BGCOLOR 8 
     RECT-1 AT ROW 1.14 COL 1.5
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS THREE-D 
         AT COL 5 ROW 3.52
         SIZE 71 BY 12.95.


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
         TITLE              = "LIST OF Withhloding TAX - 01%"
         HEIGHT             = 18.05
         WIDTH              = 79.17
         MAX-HEIGHT         = 45.76
         MAX-WIDTH          = 213.33
         VIRTUAL-HEIGHT     = 45.76
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
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW C-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* REPARENT FRAME */
ASSIGN FRAME FRAME-B:FRAME = FRAME fe_form:HANDLE.

/* SETTINGS FOR FRAME fe_form
   FRAME-NAME                                                           */
/* SETTINGS FOR FRAME FRAME-B
   UNDERLINE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* LIST OF Withhloding TAX - 01% */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* LIST OF Withhloding TAX - 01% */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME FRAME-B
&Scoped-define SELF-NAME BUTTON-1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BUTTON-1 C-Win
ON CHOOSE OF BUTTON-1 IN FRAME FRAME-B /* OK */
DO:
   IF fi_condate = ? OR
       fi_condateT = ? OR
       fi_branchF = "" OR
       fi_branchT = "" OR
       (fi_poline = 0 OR fi_poline > 3) OR
       fi_outputto = "" THEN DO:
        MESSAGE "กรุณาใส่ข้อมูลให้ครบ" VIEW-AS ALERT-BOX.
        APPLY "ENTRY" TO fi_condate IN FRAM FRAME-B.
        RETURN NO-APPLY.
    END.
    IF fi_condateT < fi_condate THEN DO:
        MESSAGE "กรุณาตรวจสอบวันที่" VIEW-AS ALERT-BOX.
        APPLY "ENTRY" TO fi_condate IN FRAM FRAME-B.
        RETURN NO-APPLY.
    END.
    IF fi_branchT < fi_branchF THEN DO:
        MESSAGE "กรุณาตรวจสอบ Branch" VIEW-AS ALERT-BOX.
        APPLY "ENTRY" TO fi_condate IN FRAM FRAME-B.
        RETURN NO-APPLY.
    END.

    ASSIGN
     n_page   = 1
     n_cnt    = 0
     line_cnt = 0
     n_flag   = "y"
     n_stime  = TIME
     nvtoday  = TODAY
     nvtime   = STRING (TIME,"HH:MM:SS")
     /*nvll     = FILL ("_", 248) /*A51-0187*/
     nvll1    = FILL ("_", 248) /*A51-0187*/*/
     nvll     = FILL ("_", 200) /*A51-0187*/ 
     nvll1    = FILL ("_", 200) /*A51-0187*/
     n_write3 = INPUT fi_outputto
     .
  /* Begin 0833 */
     ASSIGN
        w_gprem   = 0
        w_gstamp  = 0
        w_gtot    = 0
        w_gcomm   = 0
        w_gfee    = 0
        w_gtotl   = 0
        w_gtax    = 0.
     /* End 0833 */
      PAUSE 0.
    nv_prtno = "1".
   IF n_output = 3 THEN DO:
        /* kan A47-0298 ---*/
        nv_acname = "".
        nv_output = n_write3 + "_".
        FIND  xmm600 USE-INDEX xmm60001 WHERE
              xmm600.acno  = n_acno NO-LOCK NO-ERROR.
        IF AVAIL xmm600 THEN DO:
            FIND xtm600 USE-INDEX xtm60001 
                        WHERE xtm600.acno = xmm600.acno NO-LOCK NO-ERROR.
            nv_acname = IF AVAIL Xtm600 THEN TRIM(xtm600.ntitle + " " + xtm600.name) 
                                        ELSE TRIM(xmm600.ntitle + " " + xmm600.name). 
        END.
    END.
    FIND FIRST Xmm024 NO-LOCK NO-ERROR.
    IF NOT AVAILABLE xmm024 THEN DO:
      MESSAGE "Record Not Found".
      PAUSE 0.
      RETURN.
    END.
    FIND FIRST Xmm101 NO-LOCK NO-ERROR.
    IF AVAILABLE Xmm101 THEN w_name = xmm101.left50.   /* xmm101.name */
    IF Xmm024.trman = TRUE THEN DO:
        FOR EACH wList :
            DELETE wList.
        END.

    RUN PDacm001(INPUT n_frmdat, 
                       n_todat , 
                       n_branfr,
                       n_branto).

    
    
    /*-IF n_output = 3 THEN DO:-*/
        RUN PDAZR00413 (INPUT n_write3, 
                              n_frmdat, 
                              n_todat,  
                              n_acno, 
                              n_dattyp, 
                              n_reptyp, 
                              n_suspen, 
                              n_lintyp ).
    /*-END.-*/
END. /*---  IF Xmm024.trman = TRUE ---*//*
    ASSIGN
      nvzp = 0
      nvyp = 0
      nvzc = 0
      nvyc = 0
      nvzs = 0
      nvys = 0
      nvc  = 0
      nvb  = 0
      nvzx = 0
      nvyw = 0
      /* A46-0074 */
      nys  = 0
      nzs  = 0
      cozp = 0
      coyp = 0
      /* A46-0074 */
      n_cnt = 0.
    
    /*RUN pdwList1.*/
    nvzc = nvzc + coyp.     /* A46-0074 */
    nvyc = nvyc + cozp.     /* A46-0074 */
   
    ASSIGN
      nvzp = 0
      nvyp = 0
      nvzc = 0
      nvyc = 0
      nvzs = 0
      nvys = 0
      nvc  = 0
      nvb  = 0
      nvzx = 0
      nvyw = 0
      /* A46-0074 */
      nys  = 0
      nzs  = 0
      cozp = 0
      coyp = 0
      n_num = 0.
    ASSIGN
    nvzc1 = nvzc1 + coyp1
    nvyc1 = nvyc1 + cozp1.

    ASSIGN        
     nvprem   = 0
     nvcomm   = 0
     nvnet    = 0
     nvpremx  = 0
     nvpremw  = 0
     nvpremys = 0
     nvpremzs = 0
     nvpremc  = 0
     nvpremb  = 0
     n_cut    = 0.


    FOR EACH wlist BREAK BY wbranch:
     IF FIRST-OF (wlist.wbranch) THEN DO:
         IF LINE-COUNTER (ns1) > 30 THEN PAGE STREAM ns1.

         PUT STREAM ns1
             nvll             AT 1
             "branch (Pol)"   AT 2 SKIP 
             "สรุปยอด Sum RV PV JV"  AT  2 
             "Preimum"     AT  60  
             "commision"   AT  76  
             "Net"         AT  91 
             "การตัดเคลม(X)"         AT  107 
             "การตัดเคลม(W)"         AT  123 
             "บัญชีพักขาด(ZS)"        AT  139 
             "บัญชีพักเกิน(YS)"        AT  155 
             "ตั้งเช็คคืน(C-DR)"      AT  171 
             "เคลียร์เช็คคืน(B-CR)"      AT  197 SKIP 
             nvll1         AT 1 SKIP(1).
         n_cut = n_cut + 2.
             
         PUT STREAM ns1
             "Branch : " TO 2 wlist.wbranch TO 15 SKIP.
         n_cut = n_cut + 1.
         FOR EACH bwlist WHERE bwlist.wbranch = wlist.wbranch BREAK BY bwlist.wrefno BY bwlist.wcheck:

             ACCUMULATE
                bwList.wprem   (TOTAL BY bwList.wRefno)
                bwList.wcomm   (TOTAL BY bwList.wRefno)
                bwList.wnet    (TOTAL BY bwList.wRefno)
                bwList.wpremx  (TOTAL BY bwList.wRefno)
                bwList.wpremw  (TOTAL BY bwList.wRefno)
                bwList.wpremzs (TOTAL BY bwList.wRefno)
                bwList.wpremys (TOTAL BY bwList.wRefno)
                bwList.wpremc  (TOTAL BY bwList.wRefno)
                bwList.wpremb  (TOTAL BY bwList.wRefno).

            IF LAST-OF (bwList.wRefno) THEN DO:
                 PUT STREAM ns1
                     bwlist.wrefno FORMAT "X(55)" TO 2 
                     ACCUM TOTAL BY bwList.wRefno bwlist.wprem   FORMAT "->>>,>>>,>>9.99" TO 70
                     ACCUM TOTAL BY bwList.wRefno bwlist.wcomm   FORMAT "->>>,>>>,>>9.99" TO 86
                     ACCUM TOTAL BY bwList.wRefno bwlist.wnet     FORMAT "->>>,>>>,>>9.99" TO 101
                     ACCUM TOTAL BY bwList.wRefno bwlist.wpremx  FORMAT "->>>,>>>,>>9.99" TO 117
                     ACCUM TOTAL BY bwList.wRefno bwlist.wpremw  FORMAT "->>>,>>>,>>9.99" TO 133
                     ACCUM TOTAL BY bwList.wRefno bwlist.wpremzs FORMAT "->>>,>>>,>>9.99" TO 149
                     ACCUM TOTAL BY bwList.wRefno bwlist.wpremys FORMAT "->>>,>>>,>>9.99" TO 165
                     ACCUM TOTAL BY bwList.wRefno bwlist.wpremc  FORMAT "->>>,>>>,>>9.99" TO 181
                     ACCUM TOTAL BY bwList.wRefno bwlist.wpremb  FORMAT "->>>,>>>,>>9.99" TO 197
                     SKIP.
                 n_cut = n_cut + 1.
                
                ASSIGN                                                               
                    nvprem   = nvprem   + (ACCUM TOTAL BY bwList.wRefno bwlist.wprem)       
                    nvcomm   = nvcomm   + (ACCUM TOTAL BY bwList.wRefno bwlist.wcomm)       
                    nvnet    = nvnet    + (ACCUM TOTAL BY bwList.wRefno bwlist.wnet)        
                    nvpremx  = nvpremx  + (ACCUM TOTAL BY bwList.wRefno bwlist.wpremx)      
                    nvpremw  = nvpremw  + (ACCUM TOTAL BY bwList.wRefno bwlist.wpremw)      
                    nvpremzs = nvpremzs + (ACCUM TOTAL BY bwList.wRefno bwlist.wpremzs)     
                    nvpremys = nvpremys + (ACCUM TOTAL BY bwList.wRefno bwlist.wpremys)     
                    nvpremc  = nvpremc  + (ACCUM TOTAL BY bwList.wRefno bwlist.wpremc)      
                    nvpremb  = nvpremb  + (ACCUM TOTAL BY bwList.wRefno bwlist.wpremb).   

            END.    /* IF LAST-OF (bwList.wRefno) */

         END.
         
     END.
     ACCUMULATE
        wList.wprem   (TOTAL BY wList.wBranch)
        wList.wcomm   (TOTAL BY wList.wBranch)
        wList.wnet    (TOTAL BY wList.wBranch)
        wList.wpremx  (TOTAL BY wList.wBranch)   
        wList.wpremw  (TOTAL BY wList.wBranch)   
        wList.wpremzs (TOTAL BY wList.wBranch)
        wList.wpremys (TOTAL BY wList.wBranch)
        wList.wpremc  (TOTAL BY wList.wBranch)
        wList.wpremb  (TOTAL BY wList.wBranch).
    
     IF LAST-OF (wList.wbranch) THEN DO:
        
        PUT STREAM ns1
            SKIP 
            "Total Branch : " TO 2  wlist.wbranch TO 20 
            ACCUM TOTAL BY wList.wBranch wList.wprem   FORMAT "->>>,>>>,>>9.99" TO 70  
            ACCUM TOTAL BY wList.wBranch wList.wcomm   FORMAT "->>>,>>>,>>9.99" TO 86  
            ACCUM TOTAL BY wList.wBranch wList.wnet    FORMAT "->>>,>>>,>>9.99" TO 101 
            ACCUM TOTAL BY wList.wBranch wList.wpremx  FORMAT "->>>,>>>,>>9.99" TO 117 
            ACCUM TOTAL BY wList.wBranch wList.wpremw  FORMAT "->>>,>>>,>>9.99" TO 133 
            ACCUM TOTAL BY wList.wBranch wList.wpremzs FORMAT "->>>,>>>,>>9.99" TO 149 
            ACCUM TOTAL BY wList.wBranch wList.wpremys FORMAT "->>>,>>>,>>9.99" TO 165 
            ACCUM TOTAL BY wList.wBranch wList.wpremc  FORMAT "->>>,>>>,>>9.99" TO 181 
            ACCUM TOTAL BY wList.wBranch wList.wpremb  FORMAT "->>>,>>>,>>9.99" TO 197 
            SKIP.
        n_cut = n_cut + 2.
        IF n_output <> 3 THEN  PAGE STREAM ns1.
     END.
     
 END.

             PUT STREAM ns1
                 "Grand Total :" TO 2
                 nvprem   FORMAT "->>>,>>>,>>9.99" TO 70     
                 nvcomm   FORMAT "->>>,>>>,>>9.99" TO 86     
                 nvnet    FORMAT "->>>,>>>,>>9.99" TO 101    
                 nvpremx  FORMAT "->>>,>>>,>>9.99" TO 117   
                 nvpremw  FORMAT "->>>,>>>,>>9.99" TO 133   
                 nvpremzs FORMAT "->>>,>>>,>>9.99" TO 149   
                 nvpremys FORMAT "->>>,>>>,>>9.99" TO 165   
                 nvpremc  FORMAT "->>>,>>>,>>9.99" TO 181   
                 nvpremb  FORMAT "->>>,>>>,>>9.99" TO 197   SKIP.
            
            /*----------------- END A51-0187 ----------------------*/
            
            ASSIGN
              n_etime = TIME
              w_etime = STRING (n_etime,"HH:MM:SS")
              n_dtime = STRING (n_etime - n_stime,"HH:MM:SS").
            
            
            

            DISPLAY  w_etime  n_dtime  WITH FRAME nf20.
            PAUSE 0.
            
            
        
            
            /*------------------------------------------
            {xm/xms00502.i &displist = "w_etime n_dtime"
                       &fname    = "nf20"
                       &dispstat = "nvstatus"
                       &dispseco = "nvsecond"}
            -------------------------------------------*/
            
     */     
            
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BUTTON-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BUTTON-2 C-Win
ON CHOOSE OF BUTTON-2 IN FRAME FRAME-B /* CANCEL */
DO:
    ASSIGN
      fi_condate = ?
      fi_condateT = ?
      fi_branchF = ""
      fi_branchT = ""
      fi_poline = 1
      fi_outputto = "".

    DISP  fi_condate 
          fi_condateT
          fi_branchF 
          fi_branchT 
          fi_poline 
          fi_outputto  WITH FRAME FRAME-B.


END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fe_form
&Scoped-define SELF-NAME EXIT
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL EXIT C-Win
ON CHOOSE OF EXIT IN FRAME fe_form /* EXIT */
DO:
     APPLY "CLOSE" TO THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME FRAME-B
&Scoped-define SELF-NAME fi_branchF
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_branchF C-Win
ON LEAVE OF fi_branchF IN FRAME FRAME-B
DO:
  n_branfr = INPUT fi_branchF.
  fi_branchF = INPUT fi_branchF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_branchT
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_branchT C-Win
ON LEAVE OF fi_branchT IN FRAME FRAME-B
DO:
  n_branto = INPUT fi_branchT.
  fi_branchT= INPUT fi_branchT.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_condate
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_condate C-Win
ON LEAVE OF fi_condate IN FRAME FRAME-B
DO:
    n_frmdat = INPUT fi_condate.
    fi_condate = INPUT fi_condate.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_condateT
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_condateT C-Win
ON LEAVE OF fi_condateT IN FRAME FRAME-B
DO:
  n_todat = INPUT fi_condateT.
  fi_condateT = INPUT fi_condateT.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_outputto
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_outputto C-Win
ON LEAVE OF fi_outputto IN FRAME FRAME-B
DO:
  n_write3 = INPUT fi_outputto. 
  fi_outputto = INPUT fi_outputto. 
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_poline
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_poline C-Win
ON LEAVE OF fi_poline IN FRAME FRAME-B
DO:
  n_lintyp = INPUT fi_poline.
  fi_poline = INPUT fi_poline.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fe_form
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
   ASSIGN 

       n_dattyp = 2
       n_kfktyp = 2
       n_type = 1
       n_reptyp = 1
       n_output = 3.
   fi_poline = 1.
   DISP fi_poline  WITH FRAME FRAME-B.


  RUN enable_UI.

    SESSION:DATA-ENTRY-RETURN = YES. 

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
  ENABLE EXIT 
      WITH FRAME fe_form IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fe_form}
  DISPLAY fi_condate fi_condateT fi_branchF fi_branchT fi_poline fi_outputto 
      WITH FRAME FRAME-B IN WINDOW C-Win.
  ENABLE RECT-1 fi_condate fi_condateT fi_branchF fi_branchT fi_poline 
         fi_outputto BUTTON-1 BUTTON-2 
      WITH FRAME FRAME-B IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-FRAME-B}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDacm001 C-Win 
PROCEDURE PDacm001 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE INPUT PARAMETER n_frmdat  AS DATE FORMAT "99/99/9999".
DEFINE INPUT PARAMETER n_todat   AS DATE FORMAT "99/99/9999".
DEFINE INPUT PARAMETER n_branfr  AS CHAR FORMAT "X(2)".
DEFINE INPUT PARAMETER n_branto  AS CHAR FORMAT "X(2)".

LOOP_ACD001:
    FOR EACH Acd001 USE-INDEX Acd00192  NO-LOCK  WHERE 
             Acd001.cjodat >= n_frmdat  AND
             Acd001.cjodat <= n_todat   AND
             Acd001.ctrty1  = "Y"       OR
             Acd001.ctrty1  = "Z"       /*OR
             Acd001.ctrty1  = "C"       OR
             Acd001.ctrty1  = "B" */    ,
       FIRST Acm001 USE-INDEX Acm00101  NO-LOCK WHERE
             Acm001.trnty1  = Acd001.ctrty1 AND
             Acm001.docno   = Acd001.cdocno AND
             Acm001.branch >= n_branfr      AND
             Acm001.branch <= n_branto      AND
           ( Acm001.trnty2  = "P"           OR
             Acm001.trnty2  = "C"           OR
             Acm001.trnty2  = "S"           OR
             Acm001.trnty2  = "X"           OR
             Acm001.trnty2  = " "           OR
             Acm001.trnty2  = "W" )
    BREAK BY Acm001.branch BY Acd001.cjodat
          BY Acm001.policy BY Acm001.usrid
    :   
        
     /*Add A49-0136*/
       IF acd001.trnty1 = acd001.ctrty1  AND
          acd001.docno  = acd001.cdocno  THEN NEXT loop_acd001.
       /*End A49-0136*/
       IF Acm001.trnty1 = "Y"  THEN DO:
               IF Acm001.trnty2  <> "P"  AND
                  Acm001.trnty2  <> "C"  AND
                  Acm001.trnty2  <> "S"  AND
                  Acm001.trnty2  <> "X"  AND
                  Acm001.trnty2  <> "W"  THEN NEXT loop_acd001.
       
       END.
        ELSE DO:
            IF Acm001.trnty1 = "C" OR Acm001.trnty1  = "B" THEN DO:
                IF Acm001.trnty2  <>  " "  THEN NEXT loop_acd001.
            END.
            ELSE NEXT loop_acd001.
            /*------------- Check Type Porn A51-0187 --------------*/
            /*IF n_type = 2 THEN DO:
                IF n_lintyp = 2 THEN DO:
                    IF Acm001.trnty2 <> "P" AND Acm001.trnty2 <> "C" THEN NEXT loop_acd001.
                END.
                ELSE DO:
                    IF Acm001.trnty2 <> "P" AND Acm001.trnty2 <> "C" AND
                       Acm001.trnty2 <> "S" THEN NEXT loop_acd001.
                END.
            END.
            IF n_type = 3 THEN DO:
                IF Acm001.trnty2 <> "X" AND acm001.trnty2 <> "W" THEN NEXT loop_acd001.
            END.
            IF n_type = 4 THEN DO:
                IF Acm001.trnty1 <> "C" AND Acm001.trnty1 <> "B" THEN NEXT loop_acd001.
            END.*/
            /*------------- End A51-0187 ---------------*/
        END.
        nv_refno = 0.
        nv_ref   = "".

        IF n_vchtyf = "" AND n_vchtyt = "" THEN DO:
           IF INDEX(Acm001.ref, "CASH") = 0 THEN nv_refno = 1.
           ELSE     
           nv_refno = INDEX(Acm001.ref, "CASH") + 5.
        
           nv_ref = CAPS(TRIM(SUBSTRING(Acm001.ref,nv_refno,60))).
            
           IF INDEX(nv_ref, nv_vouch) = 14 THEN
              nv_ref = CAPS(TRIM(SUBSTR(Acm001.ref,14,60)) + " " +
                            TRIM(SUBSTR(Acm001.ref,1,5))   + " " +
                            TRIM(SUBSTR(Acm001.ref,7,7)) ). 
        END.
        nvtype = TRIM(Acm001.trnty1 + Acm001.trnty2).
        n_cnt = n_cnt + 1.

        ASSIGN  nv_prem    =  0
                nv_comm    =  0
                nv_totnet  =  0
                nv_premx   =  0   /* A48-0448 */
                nv_premw   =  0   /* A48-0448 */
                /* A47-0213 */
                nv_premc   =  0
                nv_premb   =  0
                nv_premys  =  0
                nv_premzs  =  0 
                
                nv_name    =  ""  /* A58-0046  by Narin*/
                nv_stamp   =  0   /* A58-0046  by Narin*/
                nv_Premstm =  0   /* A58-0046  by Narin*/ 
                nv_TAXONE  =  0.  /* A58-0046  by Narin*/

        FIND bAcm001 USE-INDEX acm00101    WHERE
             bAcm001.trnty1 = "m" /*Acd001.trnty1*/  AND
             bAcm001.docno  = Acd001.docno
        NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL  bAcm001 THEN NEXT loop_Acd001.
        IF AVAIL bAcm001 THEN DO:
            /*--    Add by Narin A58-0046--*/
            IF (LENGTH(bAcm001.insref) = 7  AND SUBSTR(bAcm001.insref,2,1) = "C")  OR 
               (LENGTH(bAcm001.insref) = 10 AND SUBSTR(bAcm001.insref,3,1) = "C")  THEN DO:
                ASSIGN 
                   nv_name    = SUBSTRING(bacm001.ref,LENGTH(bacm001.vehreg) + 1,
                                         (LENGTH(bacm001.ref) - LENGTH(bacm001.vehreg))).  /*bAcm001.dname bacm001.ref*/
            END.
            ELSE DO:
                NEXT loop_Acd001.
            END.
                ASSIGN     
                   nv_Stamp   =  bAcm001.stamp
                   nv_Premstm =  bAcm001.prem  + bAcm001.stamp 
                   nv_TAXONE  =  nv_Premstm  * 1 / 100 . 
                
            /*--End Add by Narin A58-0046--*/
            IF n_lintyp = 2 THEN DO:
                IF SUBSTR(bAcm001.policy,3,2) = "60" OR SUBSTR(bAcm001.policy,3,2) = "61" OR 
                   SUBSTR(bAcm001.policy,3,2) = "62" OR SUBSTR(bAcm001.policy,3,2) = "63" OR 
                   SUBSTR(bAcm001.policy,3,2) = "64" OR SUBSTR(bAcm001.policy,3,2) = "67" THEN DO:   /*edit and เป้น OR*/
                    NEXT loop_Acd001.
                   
                END.
            END.

             IF n_lintyp = 3 THEN DO:
                    IF SUBSTR(bAcm001.policy,3,2) <> "60" AND SUBSTR(bAcm001.policy,3,2) <> "61" AND 
                       SUBSTR(bAcm001.policy,3,2) <> "62" AND SUBSTR(bAcm001.policy,3,2) <> "63" AND 
                       SUBSTR(bAcm001.policy,3,2) <> "64" AND SUBSTR(bAcm001.policy,3,2) <> "67" THEN DO:   /*edit and เป้น OR*/
                       NEXT loop_Acd001.
                       
                END.
            END.
        END.

        w_condat  = STRING(Acd001.cjodat ,"99/99/9999") .
        w_entdat  = STRING(Acm001.entdat ,"99/99/9999") . /*- A51-0187 -*/
        n_totprem = bAcm001.prem + bAcm001.stamp + bAcm001.fee + bAcm001.tax.
        nvamt  = n_totprem.

        IF nvtype = "YP" OR nvtype = "ZP" THEN DO:
            IF bAcm001.baloc = 0 AND (Acd001.netamt * (-1) = bAcm001.netamt)
            THEN DO:
                ASSIGN
                   nv_prem   =  nvamt
                   nv_comm   =  bAcm001.comm
                   nv_totnet =  nv_prem + nv_comm .              /* Net */
            END.
            ELSE DO:
                IF bAcm001.baloc = 0 THEN DO:
                    IF Acd001.netamt * (-1) = bAcm001.netamt THEN
                        ASSIGN
                           nv_prem       =  Acd001.netamt * (-1)
                           nv_comm       =  bAcm001.comm
                           nv_totnet =  nv_prem + nv_comm .          /* Net */
                    ELSE
                        ASSIGN
                           nv_prem       =  Acd001.netamt * (-1)
                           nv_comm       =  0
                           nv_totnet =  nv_prem + nv_comm .          /* Gross */
                END.
                ELSE DO:
                    ASSIGN
                        nv_prem   =  Acd001.netamt * (-1)
                        nv_comm   =  0
                        nv_totnet =  nv_prem + nv_comm .                 /* Gross */
                END.
            END.
        END.
        ELSE DO:
            IF nvtype = "YC" OR nvtype = "ZC" THEN DO:
                ASSIGN
                   nv_prem   =  0
                   nv_comm   =  Acd001.netamt * (-1)
                   nv_totnet =  nv_prem + nv_comm .
            END.
            ELSE DO:
                /*---------------- A48-0448 --------------*/
                ASSIGN
                   nv_prem   = 0
                   nv_comm   = 0
                   nv_totnet = 0.
    
                CASE nvtype:
                    WHEN "C"  THEN nv_premc  = Acd001.netamt.
                    WHEN "B"  THEN nv_premb  = Acd001.netamt.
                    WHEN "YS" THEN nv_premys = Acd001.netamt * (-1).
                    WHEN "ZS" THEN nv_premzs = Acd001.netamt * (-1).
                    WHEN "ZX" THEN nv_premx  = Acd001.netamt * (-1).
                    WHEN "YW" THEN nv_premw  = Acd001.netamt * (-1).
                END CASE.
            END.
        END.
        IF SUBSTR(bAcm001.policy,1,1) = "D"  OR
           SUBSTR(bAcm001.policy,1,1) = "I"  THEN DO: 
                 w_branch = SUBSTR(bAcm001.policy,2,1).  
            END.
            ELSE IF SUBSTR(bAcm001.policy,1,2) >= "10" AND
                    SUBSTR(bAcm001.policy,1,2) <= "99" THEN   w_branch = SUBSTR(bAcm001.policy,1,2). 
         /*add by chonlatis J.*/

          IF SUBSTRING(nv_ref,LENGTH(nv_ref),1) = "A" THEN DO:
              nv_refSub = (LENGTH(nv_ref) - 9).
               nv_refRV  = SUBSTR(nv_ref,1,nv_refSub).
               nv_refDoc = SUBSTR(nv_ref, (nv_refsub + 1) , 9).
          END.
          ELSE DO:
               nv_refSub = (LENGTH(nv_ref) - 8).
               nv_refRV = SUBSTR(nv_ref,1,nv_refSub).
               nv_refDoc = SUBSTR(nv_ref, (nv_refsub + 1) , 8).
          END.
        

        FOR EACH xmm600 WHERE xmm600.acno = bacm001.insref NO-LOCK.
         nv_taxno = xmm600.taxno.
        END.
         
             
        CREATE wList.
        ASSIGN
            /* IF AVAIL Acd002 THEN Acd002.cjodat ELSE Acm002.trndat */
            /*------- A46-0074 ------
            wPolicy = Acm002.policy
            wPrem   = Acm002.prem
            wComm   = Acm002.comm
            wNet    = Acm002.netamt
            wRef    = Acm002.ref
            ------- END A46-0074 -----*/
            
            /*wBranch = Acm001.branch  */
            /*wBranch = SUBSTRING()*/  /*- Manop G. A58-0345 -*/
            wBranch = SUBSTRING(bAcm001.policy,1,2) /*aaaa*/
            wCondat = w_condat
            wAcno   = Acm001.acno
            wEntdat = w_entdat /*Porn A51-0187*/
            
            wType   = nvtype
            wDocno  = Acm001.docno
            wUsrID  = Acm001.usrid
            
            /*------ A46-0074 ------*/
            wPolicy = bAcm001.policy
            /*wEndno  = IF LENGTH(bAcm001.recno) = 8 THEN bAcm001.recno ELSE ""     /* A48-0448 */*//*Comment A53-0039*/
            wEndno  = IF LENGTH(bAcm001.recno) = 8 OR LENGTH(bAcm001.recno) = 9 THEN bAcm001.recno ELSE ""     /* A48-0448 *//*A53-0039*/
            wTrndat = STRING(bAcm001.trndat,"99/99/9999")  /* A48-0531 */
            wPrem   = nv_prem
            wComm   = nv_comm
            wNet    = nv_totnet
            wRefno  = nv_ref
            wRefRV  = nv_refRV
            wRefdoc =nv_refDoc
            
            wCheck  = 0
            /*---- END A46-0074 ----*/
            
            /*----- A47-0213 -----*/
            wPremc  = nv_premc
            wPremb  = nv_premb
            wPremys = nv_premys
            wPremzs = nv_premzs
            /*--- END A47-0213 ---*/
            wTaxno = nv_taxno
            /*--     Add by Narin A58-0046 --*/
            wName    = nv_name
            wStamp   = nv_stamp
            wPremstm = nv_Premstm
            WTAXONE  = nv_taxone
           /*-- End Add by Narin A58-0046 --*/
            
            wPremx  = nv_premx      /* A48-0448 */
            wPremw  = nv_premw      /* A48-0448 */
            n_num   = n_num + 1.    /*A51-0187*/

        
         
           
        


        
        /*---------------------- A47-0213 ----------------------*/
        nvtype = TRIM(bAcm001.trnty1 + bAcm001.trnty2).
        /*
        IF nvtype = "C" OR nvtype = "B" THEN DO:
           FIND FIRST wList USE-INDEX ind02 WHERE
                      wList.wType  = bAcm001.trnty1 AND
                      wList.wDocno = bAcm001.docno  NO-ERROR NO-WAIT.
           IF NOT AVAIL wList THEN DO: 
              CREATE wList.
              ASSIGN
                wPolicy = bAcm001.policy
                /*wEndno  = IF LENGTH(bAcm001.recno) = 8 THEN bAcm001.recno ELSE ""     /* A48-0448 */*//*Comment A53-0039*/
                wEndno  = IF LENGTH(bAcm001.recno) = 8 OR LENGTH(bAcm001.recno) = 9 THEN bAcm001.recno ELSE ""     /* A48-0448 *//*A53-0039*/
                wTrndat = STRING(bAcm001.trndat,"99/99/9999")  /* A48-0531 */
                wPrem   = 0
                wComm   = 0
          /*    wNet    = Acm001.netamt     --A47-0213--*/
        
                /*----- A47-0213 -----*/
                wNet    = 0
                wPremc  = IF nvtype = "C" THEN bAcm001.netamt ELSE 0
                wPremb  = IF nvtype = "B" THEN bAcm001.netamt ELSE 0
                wPremys = 0
                wPremzs = 0
                /*--- END A47-0213 ---*/

                wPremx  = 0     /* A48-0448 */
                wPremw  = 0     /* A48-0448 */
        
                wRefno  = nv_ref
                /*wBranch = Acm001.branch*/
                wBranch = w_branch      /*-Manop G, A58-0345-*/
                wCondat = STRING(bAcm001.trndat,"99/99/9999")
                wEntdat = STRING(bAcm001.trndat,"99/99/9999") /*Porn A51-0187*/
                wAcno   = bAcm001.acno
                wType   = TRIM(bAcm001.trnty1 + bAcm001.trnty2)
                wDocno  = bAcm001.docno
                wUsrID  = bAcm001.usrid
                /*--     Add by Narin A58-0046 --*/
                wName    = nv_name
                wStamp   = nv_stamp
                wPremstm = nv_Premstm
                WTAXONE  = nv_taxone
                /*-- End Add by Narin A58-0046 --*/

                wCheck  = 0
                n_num   = n_num + 1.  /*A51-0187*/
               
           END.    /* end if avail wlist */

           n_cnt = n_cnt + 1.
         

        END.        /* end acm001.trnty1 = "C","B" */
         */
        /*IF n_suspen = 2 THEN DO:
          IF nvtype = "YS" OR  nvtype = "ZS" THEN DO:
            FIND FIRST bAcm001 USE-INDEX Acm00101 WHERE
                       bAcm001.trnty1 = Acd001.trnty1 AND
                       bAcm001.docno  = Acd001.docno  NO-LOCK NO-ERROR.
            IF AVAIL bAcm001 THEN DO:
        
                /*--    Add by Narin A58-0046--*/
                IF (LENGTH(bAcm001.insref) = 7  AND SUBSTR(bAcm001.insref,2,1) = "C")  OR 
                   (LENGTH(bAcm001.insref) = 10 AND SUBSTR(bAcm001.insref,3,1) = "C")  THEN DO:
                     
                    ASSIGN 
                       nv_name    =  bAcm001.ref.
                END.
                
                   
                 
                
                    ASSIGN     
                       nv_Stamp   =  bAcm001.stamp
                       nv_Premstm =  bAcm001.prem  + bAcm001.stamp 
                       nv_TAXONE  =  nv_Premstm  * 1 / 100 . 

                /*--End Add by Narin A58-0046--*/
              /*-------------- Check PA A51-0187 ----------------*/
              IF n_lintyp = 2 THEN DO:
                IF SUBSTR(bAcm001.policy,3,2) <> "60" AND SUBSTR(bAcm001.policy,3,2) <> "61" AND 
                   SUBSTR(bAcm001.policy,3,2) <> "62" AND SUBSTR(bAcm001.policy,3,2) <> "63" AND 
                   SUBSTR(bAcm001.policy,3,2) <> "64" AND SUBSTR(bAcm001.policy,3,2) <> "67" THEN DO:
                    NEXT loop_Acd001.
                END.
              END.
              /*----------- End Check PA A51-0187 ---------------*/
              
              CREATE wList.
              ASSIGN
                 wPolicy = bAcm001.policy
                 /*wEndno  = IF LENGTH(bAcm001.recno) = 8 THEN bAcm001.recno ELSE ""     /* A48-0448 */*//*Comment A53-0039*/
                 wEndno  = IF LENGTH(bAcm001.recno) = 8 OR LENGTH(bAcm001.recno) = 9 THEN bAcm001.recno ELSE ""     /* A48-0448 *//*A53-0039*/
                 wTrndat = STRING(bAcm001.trndat,"99/99/9999")  /* A48-0531 */
                 wPrem   = bAcm001.prem
                 wComm   = bAcm001.comm
           /*    wNet    = Acm001.netamt * (-1)    --A47-0213--*/
        
                 /*----- A47-0213 -----*/
                 wNet    = Acm001.prem + Acm001.comm
                 wPremc  = 0
                 wPremb  = 0
                 wPremys = IF nvtype = "YS" THEN bAcm001.netamt * (-1) ELSE 0
                 wPremzs = IF nvtype = "ZS" THEN bAcm001.netamt * (-1) ELSE 0
                 /*--- END A47-0213 ---*/
                 wPremx  = 0     /* A48-0448 */
                 wPremw  = 0     /* A48-0448 */
                /*    wRefno  = nv_ref            --A47-0265--*/
                 /*wBranch = Acm001.branch*/
                 wBranch = w_branch  /*-Manop G. A58-0345-*/
                 wCondat = STRING(bAcm001.trndat,"99/99/9999")
                 wEntdat = STRING(bAcm001.trndat,"99/99/9999") /*Porn A51-0187*/
                 wAcno   = bAcm001.acno
                 wType   = TRIM(bAcm001.trnty1 + bAcm001.trnty2)
                 wDocno  = bAcm001.docno
                 wUsrID  = bAcm001.usrid
                 /*--     Add by Narin A58-0046 --*/
                 wName    = nv_name
                 wStamp   = nv_stamp
                 wPremstm = nv_Premstm
                 WTAXONE  = nv_taxone
                 /*-- End Add by Narin A58-0046 --*/
                 wCheck  = 1                 /* wCheck : 1=Inward */
                 n_num   = n_num + 1. /*A51-0187*/
              /*-------------- A47-0265 -------------*/
              nv_refno = 0.
              nv_ref   = "".

              IF INDEX(bAcm001.ref, "CASH") = 0 THEN nv_refno = 1.
              ELSE     
              nv_refno = INDEX(bAcm001.ref, "CASH") + 5.
              nv_ref  =  CAPS(TRIM(SUBSTRING(bAcm001.ref,nv_refno,60))).
        
              IF INDEX(nv_ref, nv_vouch) = 14 THEN
                   nv_ref = CAPS(TRIM(SUBSTR(bAcm001.ref,14,60)) + " " +
                                 TRIM(SUBSTR(bAcm001.ref,1,5))   + " " +
                                 TRIM(SUBSTR(bAcm001.ref,7,7)) ).
              wRefno  =  nv_ref .
              /*------------ END A47-0265 -----------*/
            END.
            n_cnt = n_cnt + 1.           
            END.

        END.*/
    
  END. /*For each ACM001*/
            
        
        /*
        IF n_num >= 60000  THEN DO : 
             IF n_output = 3 THEN DO:
             RUN az\azr00413.p (INPUT n_write3, INPUT n_frmdat, INPUT n_todat, 
                                   INPUT n_acno,   INPUT n_dattyp,
                                   INPUT n_reptyp, INPUT n_suspen, INPUT n_lintyp).
                n_num = 0.
                n_i = n_i + 1.
                n_write3 = "".
                n_write3 = nv_output  + STRING(n_i).
                FOR EACH wlist:
                    DELETE wlist.
                END.
            END.
         END. */

    

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDAZR00413 C-Win 
PROCEDURE PDAZR00413 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE INPUT PARAMETER n_write3  AS CHAR FORMAT "X(30)".
DEFINE INPUT PARAMETER n_frmdat  AS DATE FORMAT "99/99/9999".
DEFINE INPUT PARAMETER n_todat   AS DATE FORMAT "99/99/9999".
DEFINE INPUT PARAMETER n_acno    AS CHAR FORMAT "X(25)".
DEFINE INPUT PARAMETER n_dattyp  AS INTE FORMAT "9".
DEFINE INPUT PARAMETER n_reptyp  AS INTE FORMAT "9".
DEFINE INPUT PARAMETER n_suspen  AS INTE FORMAT "9".
DEFINE INPUT PARAMETER n_lintyp  AS INTE FORMAT "9".


DEF VAR n_reccnt AS INTE INIT 0.
DEF VAR n_next AS INTE INIT 0.
DEF VAR n_sumcnt AS INTE.
        n_pname = "[WACRTAX01]".
   


    n_write3 = n_write3 + ".PRN".

    ASSIGN
      nvzp = 0
      nvyp = 0
      nvzc = 0
      nvyc = 0
      nvzs = 0
      nvys = 0
      nvc  = 0
      nvb  = 0
      nvzx = 0
      nvyw = 0
      nys  = 0
      nzs  = 0
      cozp = 0
      coyp = 0
      .
    FOR EACH wList USE-INDEX ind01 NO-LOCK
        BREAK BY wBranch
              BY wCondat
              BY wType
              By wRefno
              By SUBSTRING(wPolicy,3,2) 
              By wPolicy                    
        :
        IF n_reccnt = 0 THEN DO:
       
    OUTPUT STREAM ns2 TO VALUE (n_write3) /*PAGE-SIZE 10*/ .  /* Output to Excel */

    PUT STREAM ns2 
          "List of Accounts Transactions" "   (" n_repdet ")"  SKIP
          "Contra Date From : " n_frmdat
                          " - " n_todat     SKIP
                "Agent Code : " n_acno ";" nv_acname        SKIP 
          "Report Date " nvtoday "  " nvtime "    " n_pname  SKIP
        
           /* แยก Column Contra Date A51-0187 */
          "Contra Date"         ";"
          "A/C No."             ";"
          "Type"                ";"
          "Doc.No."             ";"
          "Policy No."          ";"
          "Endorse No."         ";"
          "Branch."             ";"
          "type RV PV JV"       ";"
          "Doc No.เลขที่เอกสาร" ";"
          "เลขที่ผู้เสียภาษี"   ";"
          /*"Trans. Date"         ";"  
          "Premium"             ";"
          "Commission"          ";"
          "Net"                 ";"
          "X"                   ";" 
          "W"                   ";" 
          "YS"                  ";"
          "ZS"                  ";"
          "ตั้งเช็คคืน Type C"  ";"
          "เคลียร์เช็คคืน B"    ";"
          "Ref.No."             ";"*/
          
          /*--    Add by Narin A58-0046--*/
          "ชื่อผู้เอาประกัน"    ";"
          "ค่าเบี้ยประกันภัย + เบี้ยอากร"   ";"
          "ภาษี 1%"             ";" 
          "User ID."            ";"   
          "Entry Date"             FORMAT "X(500)"  /* เพิ่ม Entry Date A51-0187 */
          /*--End Add by Narin A58-0046--*/
          SKIP .
     n_reccnt = n_reccnt + 5.
    END.
        IF FIRST-OF (wList.wBranch) THEN DO:

            FIND Xmm023 WHERE Xmm023.branch = wList.wbranch NO-LOCK NO-ERROR.
            nvbr = IF AVAIL Xmm023 THEN Xmm023.bdes ELSE "".
            /* PUT STREAM ns2 "Branch : " wList.wbranch " - " nvbr FORMAT "X(60)" SKIP . *//*Comment By. Chonlatis J.A59-0603 11/01/2017*/
        END. /* IF FIRST-OF (wBranch) */

        IF n_reptyp = 1 THEN DO:    /* Detail */


                PUT STREAM ns2
                    /* แยก Column Contra Date Porn A51-0187 */
                    wcondat      FORMAT "X(10)"              ";"
                    wacno        FORMAT "X(10)"              ";" 
                    wType    FORMAT "XX"                     ";"
                    wdocno   FORMAT "X(10)"                  ";" /* Benjaporn J. A60-0267 date 27/06/2017 */                                
                    wpolicy  FORMAT "XX-XX-XX/XXXXXXXXXX"    ";"  
                    /*wendno   FORMAT "X(8)"                   ";" *//*Comment A53-0039*/
                    wendno   FORMAT "X(9)"                   ";" /*A53-0039*/
                    wbranch  FORMAT "x(2)"                   ";"
                    /*wtrndat                                  ";" 
                    wprem    FORMAT "->>,>>>,>>>,>>9.99"     ";"
                    wcomm    FORMAT "->>,>>>,>>>,>>9.99"     ";"
                    wnet     FORMAT "->>,>>>,>>>,>>9.99"     ";"
                    wpremx   FORMAT "->>,>>>,>>>,>>9.99"     ";"  
                    wpremw   FORMAT "->>,>>>,>>>,>>9.99"     ";"  
                    wpremys  FORMAT "->>,>>>,>>>,>>9.99"     ";"
                    wpremzs  FORMAT "->>,>>>,>>>,>>9.99"     ";"
                    wpremc   FORMAT "->>,>>>,>>>,>>9.99"     ";"
                    wpremb   FORMAT "->>,>>>,>>>,>>9.99"     ";"
                    wrefno   FORMAT "X(60)"                  ";"*/
                    wrefRv   FORMAT "X(5)"                   ";" 
                    wrefDoc  FORMAT "X(10)"                  ";"
                    wtaxno   FORMAT "X(18)"                  ";"
             
                    /*--------------- A58-0046 ---------------*/
                    wName      FORMAT "X(70)"                ";"
                    wPremstm   FORMAT "->>,>>>,>>>,>>9.99"   ";"   
                    wTAXONE    FORMAT "->>,>>>,>>>,>>9.99"   ";"
                    wusrid   FORMAT "X(7)"                   ";" 
                    wentdat  FORMAT "X(10)"                    /*--- Porn A51-0187 --*/
                    /*--------------- A58-0046 ---------------*/
                    SKIP. 
           n_reccnt = n_reccnt + 1.
            ACCUMULATE
                wList.wprem   (TOTAL BY SUBSTRING(wList.wPolicy,3,2))
                wList.wcomm   (TOTAL BY SUBSTRING(wList.wPolicy,3,2))
                wList.wnet    (TOTAL BY SUBSTRING(wList.wPolicy,3,2))
                wList.wpremx  (TOTAL BY SUBSTRING(wList.wPolicy,3,2))  
                wList.wpremw  (TOTAL BY SUBSTRING(wList.wPolicy,3,2))  
                wList.wpremys (TOTAL BY SUBSTRING(wList.wPolicy,3,2))
                wList.wpremzs (TOTAL BY SUBSTRING(wList.wPolicy,3,2))
                wList.wpremc  (TOTAL BY SUBSTRING(wList.wPolicy,3,2))
                wList.wpremb  (TOTAL BY SUBSTRING(wList.wPolicy,3,2)).

            IF LAST-OF (SUBSTRING(wList.wPolicy,3,2)) THEN DO:

                   /* PUT STREAM ns2
                        "Total Line :  " SUBSTRING(wList.wPolicy,3,2)
                        ";" ";" ";" ";" ";" ";" ";" ";" ";" /*Comment by.Chonlatis J. A59-0603 11/01/2017*/ /* A51-0187 เพิ่ม ";" */
                        ACCUM TOTAL BY SUBSTRING(wList.wPolicy,3,2) wprem   FORMAT "->>,>>>,>>>,>>9.99" ";"
                        ACCUM TOTAL BY SUBSTRING(wList.wPolicy,3,2) wcomm   FORMAT "->>,>>>,>>>,>>9.99" ";"
                        ACCUM TOTAL BY SUBSTRING(wList.wPolicy,3,2) wnet    FORMAT "->>,>>>,>>>,>>9.99" ";"
                        ACCUM TOTAL BY SUBSTRING(wList.wPolicy,3,2) wpremx  FORMAT "->>,>>>,>>>,>>9.99" ";" 
                        ACCUM TOTAL BY SUBSTRING(wList.wPolicy,3,2) wpremw  FORMAT "->>,>>>,>>>,>>9.99" ";" 
                        ACCUM TOTAL BY SUBSTRING(wList.wPolicy,3,2) wpremys FORMAT "->>,>>>,>>>,>>9.99" ";"
                        ACCUM TOTAL BY SUBSTRING(wList.wPolicy,3,2) wpremzs FORMAT "->>,>>>,>>>,>>9.99" ";"
                        ACCUM TOTAL BY SUBSTRING(wList.wPolicy,3,2) wpremc  FORMAT "->>,>>>,>>>,>>9.99" ";"
                        ACCUM TOTAL BY SUBSTRING(wList.wPolicy,3,2) wpremb  FORMAT "->>,>>>,>>>,>>9.99" ";"
                        SKIP.
                        */

            END.    /* IF LAST-OF (SUBSTRING(wList.wPolicy,3,2)) */

            ACCUMULATE
                wList.wpremstm   (TOTAL BY wList.wRefno)
                wList.wtaxone   (TOTAL BY wList.wRefno)
               /* wList.wprem   (TOTAL BY wList.wRefno)
                wList.wcomm   (TOTAL BY wList.wRefno)
                wList.wnet    (TOTAL BY wList.wRefno)
                wList.wpremx  (TOTAL BY wList.wRefno) 
                wList.wpremw  (TOTAL BY wList.wRefno) 
                wList.wpremys (TOTAL BY wList.wRefno)
                wList.wpremzs (TOTAL BY wList.wRefno)
                wList.wpremc  (TOTAL BY wList.wRefno)
                wList.wpremb  (TOTAL BY wList.wRefno)*/.

            IF LAST-OF (wList.wRefno) THEN DO:
                   /* PUT STREAM ns2
                        "Sub Total : " ";" ";" ";" ";" ";" ";" ";" ";" "," /*Comment by.Chonlatis J. A59-0603 11/01/2017*//* A51-0187 เพิ่ม ";" */
                        ACCUM TOTAL BY wList.wRefno wprem   FORMAT "->>,>>>,>>>,>>9.99" ";"
                        ACCUM TOTAL BY wList.wRefno wcomm   FORMAT "->>,>>>,>>>,>>9.99" ";"
                        ACCUM TOTAL BY wList.wRefno wnet    FORMAT "->>,>>>,>>>,>>9.99" ";"
                        ACCUM TOTAL BY wList.wRefno wpremx  FORMAT "->>,>>>,>>>,>>9.99" ";" 
                        ACCUM TOTAL BY wList.wRefno wpremw  FORMAT "->>,>>>,>>>,>>9.99" ";" 
                        ACCUM TOTAL BY wList.wRefno wpremys FORMAT "->>,>>>,>>>,>>9.99" ";"
                        ACCUM TOTAL BY wList.wRefno wpremzs FORMAT "->>,>>>,>>>,>>9.99" ";"
                        ACCUM TOTAL BY wList.wRefno wpremc  FORMAT "->>,>>>,>>>,>>9.99" ";"
                        ACCUM TOTAL BY wList.wRefno wpremb  FORMAT "->>,>>>,>>>,>>9.99" ";"
                        SKIP.
                        */
            END.    /* IF LAST-OF (wList.wRefno) */

        END. /* n_reptyp = 1 */

    IF LAST-OF (wList.wCondat)  THEN DO:

        IF NOT((n_frmdat = n_todat) AND (n_reptyp = 1)) THEN DO:
            ACCUMULATE
              wList.wprem   (TOTAL BY wList.wCondat)   
              wList.wcomm   (TOTAL BY wList.wCondat)   
              wList.wnet    (TOTAL BY wList.wCondat)   
              wList.wpremx  (TOTAL BY wList.wCondat)   
              wList.wpremw  (TOTAL BY wList.wCondat)   
              wList.wpremys (TOTAL BY wList.wCondat)   
              wList.wpremzs (TOTAL BY wList.wCondat)   
              wList.wpremc  (TOTAL BY wList.wCondat)   
              wList.wpremb  (TOTAL BY wList.wCondat).  

                   /* PUT STREAM ns2
                    "Total Date : " n_condat FORMAT "X(10)" ";" ";" ";" ";" ";" ";" ";" ";" /* A51-0187 เพิ่ม ";" */
                    ACCUM TOTAL BY wList.wCondat wprem   FORMAT "->>,>>>,>>>,>>9.99" ";"
                    ACCUM TOTAL BY wList.wCondat wcomm   FORMAT "->>,>>>,>>>,>>9.99" ";"
                    ACCUM TOTAL BY wList.wCondat wnet    FORMAT "->>,>>>,>>>,>>9.99" ";"
                    ACCUM TOTAL BY wList.wCondat wpremx  FORMAT "->>,>>>,>>>,>>9.99" ";"  
                    ACCUM TOTAL BY wList.wCondat wpremw  FORMAT "->>,>>>,>>>,>>9.99" ";"  
                    ACCUM TOTAL BY wList.wCondat wpremys FORMAT "->>,>>>,>>>,>>9.99" ";"
                    ACCUM TOTAL BY wList.wCondat wpremzs FORMAT "->>,>>>,>>>,>>9.99" ";"
                    ACCUM TOTAL BY wList.wCondat wpremc  FORMAT "->>,>>>,>>>,>>9.99" ";"
                    ACCUM TOTAL BY wList.wCondat wpremb  FORMAT "->>,>>>,>>>,>>9.99" ";"

                    SKIP.
                    */
        END.
    END.    /* IF LAST-OF (wList.wCondat) */




        ACCUMULATE
            wList.wprem   (TOTAL BY wList.wBranch)
            wList.wcomm   (TOTAL BY wList.wBranch)
            wList.wnet    (TOTAL BY wList.wBranch)
            wList.wpremx  (TOTAL BY wList.wBranch)   
            wList.wpremw  (TOTAL BY wList.wBranch)   
            wList.wpremys (TOTAL BY wList.wBranch)
            wList.wpremzs (TOTAL BY wList.wBranch)
            wList.wpremc  (TOTAL BY wList.wBranch)
            wList.wpremb  (TOTAL BY wList.wBranch).

        IF LAST-OF (wList.wbranch) THEN DO:
  /*             PUT STREAM ns2
                    SKIP(1) 
                    "Grand Total : " ";" ";" ";" ";" ";" ";" ";" ";" /* A51-0187 เพิ่ม ";" */
                    ACCUM TOTAL BY wList.wBranch wprem   FORMAT "->>,>>>,>>>,>>9.99" ";"
                    ACCUM TOTAL BY wList.wBranch wcomm   FORMAT "->>,>>>,>>>,>>9.99" ";"
                    ACCUM TOTAL BY wList.wBranch wnet    FORMAT "->>,>>>,>>>,>>9.99" ";"
                    ACCUM TOTAL BY wList.wBranch wpremx  FORMAT "->>,>>>,>>>,>>9.99" ";"  
                    ACCUM TOTAL BY wList.wBranch wpremw  FORMAT "->>,>>>,>>>,>>9.99" ";"  
                    ACCUM TOTAL BY wList.wBranch wpremys FORMAT "->>,>>>,>>>,>>9.99" ";"
                    ACCUM TOTAL BY wList.wBranch wpremzs FORMAT "->>,>>>,>>>,>>9.99" ";"
                    ACCUM TOTAL BY wList.wBranch wpremc  FORMAT "->>,>>>,>>>,>>9.99" ";"
                    ACCUM TOTAL BY wList.wBranch wpremb  FORMAT "->>,>>>,>>>,>>9.99" ";"
                    SKIP.
                   

                PUT STREAM ns2
                    "Total Branch : " wList.wbranch "  " nvbr FORMAT "X(40)" SKIP.
                    
*/
            FOR EACH bw NO-LOCK WHERE
                bw.wbranch = wList.wbranch 
            BREAK BY bw.wtype BY bw.wcheck:

                ACCUMULATE
                    bw.wprem   (TOTAL BY bw.wtype BY bw.wcheck)
                    bw.wcomm   (TOTAL BY bw.wtype BY bw.wcheck)
                    bw.wnet    (TOTAL BY bw.wtype BY bw.wcheck)
                    bw.wpremx  (TOTAL BY bw.wtype BY bw.wcheck) 
                    bw.wpremw  (TOTAL BY bw.wtype BY bw.wcheck) 
                    bw.wpremys (TOTAL BY bw.wtype BY bw.wcheck)
                    bw.wpremzs (TOTAL BY bw.wtype BY bw.wcheck)
                    bw.wpremc  (TOTAL BY bw.wtype BY bw.wcheck)
                    bw.wpremb  (TOTAL BY bw.wtype BY bw.wcheck).

                
                IF LAST-OF (bw.wtype) OR LAST-OF (bw.wcheck) THEN DO:

                    IF bw.wcheck = 1 THEN n_chk = "ยอดตั้ง".
                                     ELSE n_chk = "".
                          /*                
                        PUT STREAM ns2
                            ";" ";" ";" ";" ";" ";" ";" /* A51-0187 เพิ่ม ";" */
                            bw.wtype "  " n_chk ";"
                            ACCUM SUB-TOTAL BY bw.wcheck bw.wprem   FORMAT "->>,>>>,>>>,>>9.99" ";"
                            ACCUM SUB-TOTAL BY bw.wcheck bw.wcomm   FORMAT "->>,>>>,>>>,>>9.99" ";"
                            ACCUM SUB-TOTAL BY bw.wcheck bw.wnet    FORMAT "->>,>>>,>>>,>>9.99" ";"
                            ACCUM SUB-TOTAL BY bw.wcheck bw.wpremx  FORMAT "->>,>>>,>>>,>>9.99" ";" 
                            ACCUM SUB-TOTAL BY bw.wcheck bw.wpremw  FORMAT "->>,>>>,>>>,>>9.99" ";" 
                            ACCUM SUB-TOTAL BY bw.wcheck bw.wpremys FORMAT "->>,>>>,>>>,>>9.99" ";"
                            ACCUM SUB-TOTAL BY bw.wcheck bw.wpremzs FORMAT "->>,>>>,>>>,>>9.99" ";"
                            ACCUM SUB-TOTAL BY bw.wcheck bw.wpremc  FORMAT "->>,>>>,>>>,>>9.99" ";"
                            ACCUM SUB-TOTAL BY bw.wcheck bw.wpremb  FORMAT "->>,>>>,>>>,>>9.99" ";"
                            SKIP.

                                          
                    CASE bw.wType:
                        WHEN "ZC" THEN nvzc = nvzc + (ACCUM TOTAL BY bw.wType bw.wNet).
                        WHEN "YC" THEN nvyc = nvyc + (ACCUM TOTAL BY bw.wType bw.wNet).
                        WHEN "ZP" THEN DO:
                                    nvzp = nvzp + (ACCUM TOTAL BY bw.wType bw.wPrem).
                                    cozp = cozp + (ACCUM TOTAL BY bw.wType bw.wComm).
                                  END.
                        WHEN "YP" THEN DO:
                                    nvyp = nvyp + (ACCUM TOTAL BY bw.wType bw.wPrem).
                                    coyp = coyp + (ACCUM TOTAL BY bw.wType bw.wComm).
                                  END.
                        WHEN "ZS" THEN IF bw.wcheck = 0 THEN
                                            nvzs = nvzs + (ACCUM SUB-TOTAL BY bw.wcheck bw.wPremzs).
                                       ELSE nzs  = nzs  + (ACCUM SUB-TOTAL BY bw.wcheck bw.wPremzs).
                        WHEN "YS" THEN IF bw.wcheck = 0 THEN
                                            nvys = nvys + (ACCUM SUB-TOTAL BY bw.wcheck bw.wPremys).
                                       ELSE nys  = nys  + (ACCUM SUB-TOTAL BY bw.wcheck bw.wPremys).
                        WHEN "C"  THEN nvc  = nvc  + (ACCUM TOTAL BY bw.wType bw.wPremc).
                        WHEN "B"  THEN nvb  = nvb  + (ACCUM TOTAL BY bw.wType bw.wPremb).
                        WHEN "ZX" THEN nvzx = nvzx + (ACCUM TOTAL BY bw.wType bw.wPremx). 
                        WHEN "YW" THEN nvyw = nvyw + (ACCUM TOTAL BY bw.wType bw.wPremw). 
                    END . /* CASE wType */
                    */

                END. /* IF LAST-OF (bw.wtype) */
                
                


            END. /* FOR EACH bw */
        END.  /* IF LAST-OF (wList.wbranch) */
     

       IF n_reccnt > 65500 THEN DO:
           OUTPUT STREAM ns2 CLOSE.
           n_reccnt = 0.
           n_next = n_next + 1.
           n_write3 = SUBSTR(n_write3,1,LENGTH(n_write3) - 4).
           IF INDEX(n_write3,"(con") > 0 THEN DO:
             n_write3 = SUBSTR(n_write3,1,INDEX(n_write3,"(con") - 1)+ "(Con" + STRING(n_next) + ")" + ".PRN".
           END.
           ELSE DO:
             n_write3 = n_write3 + "(Con" + STRING(n_next) + ")" + ".PRN".
           END.
       END.
    END. /* FOR EACH wList */


    n_sumcnt = n_reccnt.
          
    FOR EACH wList USE-INDEX ind01 NO-LOCK

        BREAK By wlist.wRefno
        :
                nv_sumstamp = nv_sumstamp + wlist.wpremstm. 
                nv_tax1     = nv_tax1 + wlist.wtaxone.
             IF LAST-OF(wlist.wrefno)THEN DO:
               CREATE wSum.
               ASSIGN 
                    w_RV        = wlist.wrefrv    
                    w_RVdoc     = wlist.wrefdoc  
                    w_Sumstamp  = nv_sumstamp
                    w_Tax1      = nv_tax1.
                    nv_sumstamp = 0.
                    nv_tax1 = 0.    
             END.
    END.

    FOR EACH wSum NO-LOCK
       BREAK BY w_RV    
             BY w_RVdoc :
        IF n_reccnt > 65500  THEN DO:
         OUTPUT STREAM ns2 CLOSE.
         n_reccnt = 0.
         n_next = n_next + 1.
         n_write3 = SUBSTR(n_write3,1,LENGTH(n_write3) - 4).
         IF INDEX(n_write3,"(con") > 0 THEN DO:
         n_write3 = SUBSTR(n_write3,1,INDEX(n_write3,"(con") - 1)+ "(Con" + STRING(n_next) + ")" + ".PRN".
         END.
         ELSE DO:
         n_write3 = n_write3 + "(Con" + STRING(n_next) + ")" + ".PRN".
         END.
         OUTPUT STREAM ns2 TO VALUE (n_write3).
        END.  

        IF n_sumcnt = n_reccnt OR n_reccnt = 0 THEN DO:
        PUT STREAM ns2
          SKIP (2) 
          "Type RV PV JV"                     ";"
          "Doc No. เลขที่เอกสาร"              ";"
          "Sum of ค้าเบี้ยประกันภัย + อากร"   ";"
          "Sum of  ภาษี 1%"                   SKIP.
          n_reccnt = n_reccnt + 3.
        END.
       PUT STREAM ns2
          w_RV        FORMAT "X(6)"                 ";"
          w_RVdoc     FORMAT "X(15)"                ";"
          w_Sumstamp  FORMAT "->>,>>>,>>>,>>9.99"   ";"
          w_Tax1      FORMAT "->>,>>>,>>>,>>9.99" SKIP.
          n_reccnt = n_reccnt + 1.

          


    END.

   FOR EACH wSum.
       DELETE wSum.
   END.
    
    
    

    OUTPUT STREAM ns2 CLOSE.
   MESSAGE "COMPLETE" VIEW-AS ALERT-BOX.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDwList1 C-Win 
PROCEDURE PDwList1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

loop_main1:
FOR EACH wList USE-INDEX ind01 NO-LOCK
    BREAK BY wBranch
          BY wCondat
          BY wType
          By wRefno
          By SUBSTRING(wPolicy,3,2)  /*A47-0176*/
          By wPolicy                 /*A47-0187*/
    :
    IF n_output = 3 THEN NEXT loop_main1. /*Porn A51-0187*/

    n_cnt = n_cnt + 1.
    DISPLAY n_cnt WITH FRAME nf3.
    PAUSE 0.

    IF FIRST-OF (wList.wBranch) THEN DO:

        FIND Xmm023 WHERE Xmm023.branch = wList.wbranch NO-LOCK NO-ERROR.
        nvbr = IF AVAIL Xmm023 THEN Xmm023.bdes ELSE "".

        IF n_output = 3 THEN DO:     /* A46-0074 */
            /* PUT STREAM ns2 "Branch : " wList.wbranch " - " nvbr FORMAT "X(60)" SKIP .
             n_cut = n_cut + 1.*/ /*-- Comment By Porn A51-0187 --*/
            NEXT.
        END.
        ELSE DO: 
            PUT STREAM ns1 "Branch : " wList.wbranch  ";"  nvbr FORMAT "X(60)" SKIP .
            n_cut = n_cut + 1. /*Porn A51-0187*/
        END.

    END. /* IF FIRST-OF (wBranch) */

    IF n_reptyp = 1 THEN DO:    /* Detail */

        IF n_output = 3 THEN DO:   /* A46-0074 */
               
            NEXT.

        END.
        ELSE DO:
                PUT STREAM ns1
                wcondat                              AT 2  
                wacno    FORMAT "X(10)"  AT 16 /*--- A500178 --- เพิ่ม format เป็น  "X(10)" ---*/ 
                wType    FORMAT "XX/"    AT 26 /*A51-0187AT 28--> AT 26 */
                wdocno   FORMAT "X(10)"  /* Benjaporn J. A60-0267 date 27/06/2017 */ AT 29 /*A51-0187AT 34--> AT 29 */
                /*--- A500178 ---
                wpolicy  FORMAT "X-X-XX-XX/XXXXXXXXXX" AT  44
                ------*/
                wpolicy  FORMAT "XX-XX-XX/XXXXXXXXXX"  AT 38  /*-- A500178 --*/ /*A51-0187 AT 44--> AT 38*/
                wprem    FORMAT "->>,>>>,>>>,>>9.99"   TO 78  /*A51-0187 AT 84--> AT 78 */
                wcomm    FORMAT "->>,>>>,>>>,>>9.99"   TO 98  /*A51-0187 AT 104--> AT 98 */
                wnet     FORMAT "->>,>>>,>>>,>>9.99"   TO 118  /*A51-0187 AT 124--> AT 188*/
                wrefno   FORMAT "X(60)"                AT 122  /*A51-0187 AT 128--> AT 122*/
                wusrid   FORMAT "X(7)"                         AT 182  /*--- A500178 --- เพิ่ม format เป็น  "X(7)" ---*/ /*A51-0187 AT 192--> AT 182 */
                wentdat  FORMAT "X(10)"                AT 189  /*--- A51-0187 เพิ่ม Entry Date AT 189 ----*/
                /*--------------- A58-0046 ---------------*/
                wName      FORMAT "X(70)"                AT 206
                wPremstm   FORMAT "->>,>>>,>>>,>>9.99"   AT 278   
                wTAXONE    FORMAT "->>,>>>,>>>,>>9.99"   AT 305
                /*--------------- A58-0046 ---------------*/
                SKIP.
            n_cut = n_cut + 1. /*Porn A51-0187*/
        END.

        /*---------------------------------
    
        .
        ----------------------------------*/
        
        /*---------------------------- A47-0176 -----------------------------*/
        ACCUMULATE
            wList.wprem   (TOTAL BY SUBSTRING(wList.wPolicy,3,2))
            wList.wcomm   (TOTAL BY SUBSTRING(wList.wPolicy,3,2))
            wList.wnet    (TOTAL BY SUBSTRING(wList.wPolicy,3,2))
            wList.wpremx  (TOTAL BY SUBSTRING(wList.wPolicy,3,2))   /* A48-0448 */
            wList.wpremw  (TOTAL BY SUBSTRING(wList.wPolicy,3,2))   /* A48-0448 */
            /*--------------- A47-0213 ---------------*/
            wList.wpremys (TOTAL BY SUBSTRING(wList.wPolicy,3,2))
            wList.wpremzs (TOTAL BY SUBSTRING(wList.wPolicy,3,2))
            wList.wpremc  (TOTAL BY SUBSTRING(wList.wPolicy,3,2))
            wList.wpremb  (TOTAL BY SUBSTRING(wList.wPolicy,3,2)).
            /*------------- END A47-0213 -------------*/

        IF LAST-OF (SUBSTRING(wList.wPolicy,3,2)) THEN DO:

            IF n_output = 3 THEN DO :
              
                NEXT.
            END.
            ELSE DO:
                PUT STREAM ns1
                    "Total Line :  " SUBSTRING(wList.wPolicy,3,2) AT  1
                    ACCUM TOTAL BY SUBSTRING(wList.wPolicy,3,2) wprem FORMAT "->>,>>>,>>>,>>9.99" TO 78  /*A51-0187*/
                    ACCUM TOTAL BY SUBSTRING(wList.wPolicy,3,2) wcomm FORMAT "->>,>>>,>>>,>>9.99" TO 98  /*A51-0187*/
                    ACCUM TOTAL BY SUBSTRING(wList.wPolicy,3,2) wnet  FORMAT "->>,>>>,>>>,>>9.99" TO 118 /*A51-0187*/
                    SKIP.
                n_cut = n_cut + 1. /*Porn A51-0187*/
            END.
        END.    /* IF LAST-OF (SUBSTRING(wList.wPolicy,3,2)) */
        /*-------------------------- END A47-0176 ---------------------------*/

        /*---------------------------- A46-0074 -----------------------------*/
        ACCUMULATE
            wList.wprem   (TOTAL BY wList.wRefno)
            wList.wcomm   (TOTAL BY wList.wRefno)
            wList.wnet    (TOTAL BY wList.wRefno)
            wList.wpremx  (TOTAL BY wList.wRefno)   /* A48-0448 */
            wList.wpremw  (TOTAL BY wList.wRefno)   /* A48-0448 */
            /*--------------- A47-0213 ---------------*/
            wList.wpremys (TOTAL BY wList.wRefno)
            wList.wpremzs (TOTAL BY wList.wRefno)
            wList.wpremc  (TOTAL BY wList.wRefno)
            wList.wpremb  (TOTAL BY wList.wRefno).
            /*------------- END A47-0213 -------------*/

        IF LAST-OF (wList.wRefno) THEN DO:
                IF n_output = 3 THEN DO:
                  
                NEXT.
            END.
        END.    /* IF LAST-OF (wList.wRefno) */

    END. /* n_reptyp = 1 */

    ACCUMULATE
        wList.wprem   (TOTAL BY wList.wCondat)
        wList.wcomm   (TOTAL BY wList.wCondat)
        wList.wnet    (TOTAL BY wList.wCondat)
        wList.wpremx  (TOTAL BY wList.wCondat)    /* A48-0448 */
        wList.wpremw  (TOTAL BY wList.wCondat)    /* A48-0448 */
        /*--------------- A47-0213 ---------------*/
        wList.wpremys (TOTAL BY wList.wCondat)
        wList.wpremzs (TOTAL BY wList.wCondat)
        wList.wpremc  (TOTAL BY wList.wCondat)
        wList.wpremb  (TOTAL BY wList.wCondat).
        /*------------- END A47-0213 -------------*/


    ACCUMULATE
        wList.wprem   (TOTAL BY wList.wBranch)
        wList.wcomm   (TOTAL BY wList.wBranch)
        wList.wnet    (TOTAL BY wList.wBranch)
        wList.wpremx  (TOTAL BY wList.wBranch)      /* A48-0448 */
        wList.wpremw  (TOTAL BY wList.wBranch)      /* A48-0448 */
        /*--------------- A47-0213 ---------------*/
        wList.wpremys (TOTAL BY wList.wBranch)
        wList.wpremzs (TOTAL BY wList.wBranch)
        wList.wpremc  (TOTAL BY wList.wBranch)
        wList.wpremb  (TOTAL BY wList.wBranch).
        /*------------- END A47-0213 -------------*/ 
    /*------------------------- END A46-0074 ----------------------------*/
    IF LAST-OF (wList.wbranch) THEN DO:
        IF n_output = 3 THEN DO:           /* A46-0074 */
            
            NEXT.
        END.
        

        FOR EACH bw NO-LOCK WHERE
                    bw.wbranch = wList.wbranch 
        BREAK BY bw.wtype BY bw.wcheck:

            ACCUMULATE
                bw.wprem   (TOTAL BY bw.wtype BY bw.wcheck)
                bw.wcomm   (TOTAL BY bw.wtype BY bw.wcheck)
                bw.wnet    (TOTAL BY bw.wtype BY bw.wcheck)
                bw.wpremx  (TOTAL BY bw.wtype BY bw.wcheck)     /* A48-0448 */
                bw.wpremw  (TOTAL BY bw.wtype BY bw.wcheck)     /* A48-0448 */
                /*--------------- A47-0213 ---------------*/
                bw.wpremys (TOTAL BY bw.wtype BY bw.wcheck)
                bw.wpremzs (TOTAL BY bw.wtype BY bw.wcheck)
                bw.wpremc  (TOTAL BY bw.wtype BY bw.wcheck)
                bw.wpremb  (TOTAL BY bw.wtype BY bw.wcheck).
                /*------------- END A47-0213 -------------*/

            IF LAST-OF (bw.wtype) OR LAST-OF (bw.wcheck) THEN DO:

                IF bw.wcheck = 1 THEN n_chk = "ยอดตั้ง".
                                 ELSE n_chk = "".

                    IF n_output = 3 THEN DO:        /* A46-0074 */
                        
                    NEXT.
                END.
                    

                CASE bw.wType:
                    
                    WHEN "ZC" THEN nvzc = nvzc + (ACCUM TOTAL BY bw.wType bw.wNet).
                    WHEN "YC" THEN nvyc = nvyc + (ACCUM TOTAL BY bw.wType bw.wNet).
                    /*------------------------ A46-0074 ---------------------------*/
                    WHEN "ZP" THEN DO:
                                nvzp = nvzp + (ACCUM TOTAL BY bw.wType bw.wPrem).
                                cozp = cozp + (ACCUM TOTAL BY bw.wType bw.wComm).
                              END.
                    WHEN "YP" THEN DO:
                                nvyp = nvyp + (ACCUM TOTAL BY bw.wType bw.wPrem).
                                coyp = coyp + (ACCUM TOTAL BY bw.wType bw.wComm).
                              END.
                  
                    WHEN "ZS" THEN IF bw.wcheck = 0 THEN
                                        nvzs = nvzs + (ACCUM SUB-TOTAL BY bw.wcheck bw.wPremzs).
                                   ELSE nzs  = nzs  + (ACCUM SUB-TOTAL BY bw.wcheck bw.wPremzs).
                    WHEN "YS" THEN IF bw.wcheck = 0 THEN
                                        nvys = nvys + (ACCUM SUB-TOTAL BY bw.wcheck bw.wPremys).
                                   ELSE nys  = nys  + (ACCUM SUB-TOTAL BY bw.wcheck bw.wPremys).
                    /*------------- END A47-0213 -------------*/
                    /*----------------------- END A46-0074 ------------------------*/
                    /*------------- A47-0213 ----------------
                    WHEN "C"  THEN nvc  = nvc  + (ACCUM TOTAL BY wType wNet).
                    WHEN "B"  THEN nvb  = nvb  + (ACCUM TOTAL BY wType wNet).
                    ------------- END A47-0213 -------------*/
                    /*--------------- A47-0213 ---------------*/
                    WHEN "C"  THEN nvc  = nvc  + (ACCUM TOTAL BY bw.wType bw.wPremc).
                    WHEN "B"  THEN nvb  = nvb  + (ACCUM TOTAL BY bw.wType bw.wPremb).
                    /*------------- END A47-0213 -------------*/
                    /*------------- END A47-0213 -------------*/
                    WHEN "ZX" THEN nvzx = nvzx + (ACCUM TOTAL BY bw.wType bw.wPremx).   /* A48-0448 */
                    WHEN "YW" THEN nvyw = nvyw + (ACCUM TOTAL BY bw.wType bw.wPremw).   /* A48-0448 */
                    /*------------- A48-0448 ----------------
                    WHEN "ZX" THEN nvzx = nvzx + (ACCUM TOTAL BY wType wNet).
                    WHEN "YW" THEN nvyw = nvyw + (ACCUM TOTAL BY wType wNet).
                    ------------- END A48-0448 -------------*/
                END CASE. /* CASE wType */

                END. /* IF LAST-OF (bw.wtype) */

        END. /* FOR EACH bw */
     

    END.  /* IF LAST-OF (wList.wbranch) */
    /*------------ Add By Porn A51-0187 -------------------*/
    IF n_cut > 26 THEN DO:
            PUT STREAM ns1 
               w_name           AT 1           
               "          List of Accounts Transactions  " AT 74
               nvtoday          AT 176 
               "Page"           AT 188  PAGE-NUMBER(ns1) FORMAT ">>>9"
               SKIP
            
               "Report Type : " AT 1  n_repdet  AT 15
               "    Contra Date From : " +  STRING (n_frmdat,"99/99/9999") + " - " +
                 STRING (n_todat,"99/99/9999")  FORMAT "X(100)" AT 74 
               nvtime           AT 176   "AZR00409"       AT 188 
               SKIP
               
               nvll             AT 1
               "Contra Date" AT 2 
               "A/C No."     AT 16
               "Type / No."  AT 26
               "Policy No."  AT 40
               "Premium"     AT 68 
               "Commission"  AT 85 
               "Net"         AT 111 
               "Ref.No."     AT 128 
               "User ID."    AT 179  
               "Entry Date"  AT 188  SKIP 
               nvll1         AT 1     SKIP(1).
            n_cut = 0.
    END.
    /*-------------- End Add By Porn A51-0187 -----------------*/
    
END. /* FOR EACH wList */
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

