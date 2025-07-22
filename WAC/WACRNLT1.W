&ANALYZE-SUSPEND _VERSION-NUMBER AB_v10r12 GUI
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

  Created: Porntiwa T.  A59-0406  Date : 05/10/2016
         : Program Reports วางบิลเงินติดล้อ
         
/* Modify By : Benjaporn J. [A60-0267] date 30/09/2017    
             : ขยาย Format Docno. จาก 7 หลักเป็น 10 หลัก    */ 
/* Modify By : Porntiwa T. A60-0267  Date 14/09/2018
               ปรับขยายเลข Document จาก 7 เป็น 10 หลัก เพื่อนำเข้าระบบให้ถูกต้อง                  */             
/*----------------------------------------------------------*/             


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
DEFINE VAR n_user AS CHAR.
DEFINE VAR nv_user AS CHAR.

DEFINE STREAM ns1.
DEFINE STREAM ns2.
DEFINE STREAM ns3.

DEFINE NEW SHARED VAR n_branch      AS CHAR FORMAT "X(2)".
DEFINE NEW SHARED VAR n_branch2     AS CHAR FORMAT "X(2)".
DEFINE            VAR n_bdes        AS CHAR FORMAT "X(50)".     /*branch name*/
DEFINE            VAR n_chkBname    AS CHAR FORMAT "X(1)".
DEFINE VAR vProdCod       AS CHAR.
DEFINE VAR n_ASdat       AS DATE FORMAT "99/99/9999".

DEFINE VAR n_OutputFile1  AS CHAR.
DEFINE VAR n_OutputFile2  AS CHAR.
DEFINE VAR n_OutputFile3  AS CHAR.
DEFINE VAR n_name     AS CHAR FORMAT "X(50)".    
DEFINE VAR n_chkname  AS CHAR FORMAT "X(1)".    
DEFINE VAR nv_acno    AS CHAR FORMAT 'X(10)'. 
DEFINE VAR nv_policy  AS CHAR FORMAT "X(16)".
DEFINE VAR nv_norpol  AS CHAR FORMAT "X(25)".
DEFINE VAR nv_pol72   AS CHAR FORMAT "X(16)".
DEFINE VAR nv_endno   AS CHAR FORMAT "X(12)".
DEFINE VAR nv_polbran AS CHAR FORMAT "X(2)".
DEFINE VAR nv_poltyp  AS CHAR FORMAT "X(3)".
DEFINE VAR nv_trnty1  AS CHAR FORMAT "X(1)".
DEFINE VAR nv_trnty2  AS CHAR FORMAT "X(1)".
DEFINE VAR nv_docno   AS CHAR FORMAT /*"x(7)"*/ "x(10)". /*A60-0267*/ 
DEFINE VAR nv_trndat  AS DATE FORMAT "99/99/9999".
DEFINE VAR nv_ASdat   AS DATE FORMAT "99/99/9999".
DEFINE VAR nv_trndat1 AS DATE FORMAT "99/99/9999".
DEFINE VAR nv_insref  AS CHAR FORMAT "X(10)". 
DEFINE VAR nv_insure  AS CHAR FORMAT "X(50)".
DEFINE VAR nv_engine  AS CHAR FORMAT "X(20)". 
DEFINE VAR nv_cha_no  AS CHAR FORMAT "X(20)".
DEFINE VAR nv_opnpol  AS CHAR FORMAT "X(16)".
DEFINE VAR nv_vehreg  AS CHAR FORMAT "X(15)".
DEFINE VAR nv_comdat  AS DATE FORMAT "99/99/9999".
DEFINE VAR nv_expdat  AS DATE FORMAT "99/99/9999".
DEFINE VAR nv_grossPrem      AS DECI  FORMAT "->>,>>>,>>9.99".
DEFINE VAR nv_grossPrem_comp AS DECI  FORMAT "->>,>>>,>>9.99".
DEFINE VAR nv_netPrem        AS DECI  FORMAT "->>,>>>,>>9.99".
DEFINE VAR nv_netPrem_comp   AS DECI  FORMAT "->>,>>>,>>9.99".
DEFINE VAR nv_tax            AS DECI  FORMAT "->>9.99".
DEFINE VAR nv_netPayment     AS DECI  FORMAT "->>,>>>,>>9.99".
DEFINE VAR nv_rencnt  AS INTE FORMAT ">>9".
DEFINE VAR nv_endcnt  AS INTE FORMAT "999".
DEFINE VAR nv_job_nr  AS CHAR FORMAT "X".
DEFINE VAR nv_nor_si  AS DECI FORMAT "->>,>>>,>>9.99".
DEFINE VAR nv_comp_si AS DECI FORMAT "->>,>>>,>>9.99".
DEFINE VAR nv_net_com AS DECI FORMAT "->>,>>>,>>9.99".
DEFINE VAR nv_covcod  AS CHAR FORMAT "X(5)".
DEFINE BUFFER Buwm_v72 FOR uwm100.
DEFINE BUFFER Buwm301  FOR uwm301.
DEFINE BUFFER Buwm130  FOR uwm130.

DEFINE VAR vChkFirstAdd   AS INT.
DEFINE            VAR n_type     AS INTE.
DEFINE VAR n_comdatF    AS DATE FORMAT "99/99/9999".
DEFINE VAR n_comdatT    AS DATE FORMAT "99/99/9999".
DEFINE VAR n_time       AS CHAR.
DEFINE VAR n_asdate     AS DATE FORMAT "99/99/9999".
DEFINE VAR n_output     AS CHAR.

DEFINE TEMP-TABLE wBill
    FIELD wRecid         AS RECID
    FIELD wPolicy        AS CHAR FORMAT "X(16)"
    FIELD wEndcnt        AS INTE FORMAT ">>9"
    FIELD wcha_no        AS CHAR FORMAT "X(30)"
    FIELD wEndno         AS CHAR FORMAT "X(12)"
    FIELD wDocno         AS CHAR FORMAT /*"x(7)"*/ "x(10)" /*A60-0267*/ 
    FIELD wInsure        AS CHAR FORMAT "X(50)"
    FIELD wComdat        AS DATE FORMAT "99/99/9999"
    FIELD wExpdat        AS DATE FORMAT "99/99/9999"
    FIELD wVehreg        AS CHAR FORMAT "X(15)"
    FIELD wProvin        AS CHAR FORMAT "X(20)"
    FIELD wcovcod        AS CHAR FORMAT "X(5)"
    FIELD wsi            AS DECI FORMAT "->>,>>>,>>9.99"
    FIELD wNetPrem       AS DECI FORMAT "->>,>>>,>>9.99"
    FIELD wStamp         AS DECI FORMAT "->>,>>9.99"
    FIELD wTax           AS DECI FORMAT "->>,>>9.99"
    FIELD wGrossPrem     AS DECI FORMAT "->>,>>>,>>9.99"
    FIELD wComm          AS DECI FORMAT "->>,>>>,>>9.99"
    FIELD wRemark        AS CHAR FORMAT "X(50)"
    FIELD wClass         AS CHAR
INDEX wBill01  IS UNIQUE PRIMARY wPolicy wEndno wDocno ASCENDING
INDEX wBill02 wComdat wPolicy.

   /*---- A49-0002 ----
   FIELD wRecid    AS RECID
   FIELD wRecordno AS INTE  FORMAT "999999"
   FIELD wInsref   AS CHAR  FORMAT "X(7)"
   FIELD wOpnpol   AS CHAR  FORMAT "X(16)"
   FIELD wGPs      AS CHAR FORMAT "X(10)"
   FIELD wCompGPs  AS CHAR FORMAT "X(10)"
   FIELD wNPs      AS CHAR FORMAT "X(10)"
   FIELD wCompNPs  AS CHAR FORMAT "X(10)"
   FIELD wTaxs     AS CHAR FORMAT "X(10)"
   FIELD wNetPays  AS CHAR FORMAT "X(10)"        
   ---- A49-0002 ----*/
 /*  FIELD wAcno     AS CHAR FORMAT "X(10)" /*--- A500178 --- ปรับ format จาก  "X(7)" เป็น  "X(10)" */
   FIELD wPolicy   AS CHAR FORMAT "X(16)"
   FIELD wNorpol   AS CHAR FORMAT "X(16)"            
   FIELD wPol72    AS CHAR FORMAT "X(16)"
   FIELD wEndno    AS CHAR FORMAT "X(12)"
   FIELD wPolbran  AS CHAR FORMAT "X(2)"
   FIELD wPoltyp   AS CHAR FORMAT "X(3)"
   FIELD wTrnty1   AS CHAR FORMAT "X"
   FIELD wTrnty2   AS CHAR FORMAT "X"
   FIELD wDocno    AS CHAR FORMAT "X(7)"
   FIELD wTrndat   AS DATE FORMAT "99/99/9999"  /*export DATE*/
   FIELD wASdat    AS DATE FORMAT "99/99/9999"
   FIELD wTrndat1  AS DATE FORMAT "99/99/9999"  /* trndat to Acc.*/
   FIELD wcontract AS CHAR FORMAT "X(10)"
   FIELD wInsure   AS CHAR FORMAT "X(50)"
   FIELD wEngine   AS CHAR FORMAT "X(20)"
   FIELD wCha_no   AS CHAR FORMAT "X(20)"
   FIELD wVehreg   AS CHAR FORMAT "X(15)"
   FIELD wComdat   AS DATE FORMAT "99/99/9999"
   FIELD wExpdat   AS DATE FORMAT "99/99/9999"
   FIELD wRencnt   AS INTE FORMAT ">>9"
   FIELD wEndcnt   AS INTE FORMAT "999"
   FIELD wGrossPrem     AS DECI  FORMAT "->>,>>>,>>9.99"
   FIELD wCompGrossPrem AS DECI  FORMAT "->>,>>>,>>9.99"
   FIELD wNetPrem       AS DECI  FORMAT "->>,>>>,>>9.99"
   FIELD wCompNetPrem   AS DECI  FORMAT "->>,>>>,>>9.99"
   FIELD wTax           AS DECI  FORMAT "->>9.99"
   FIELD wNetPayment    AS DECI  FORMAT "->>,>>>,>>9.99"
   FIELD wjob_nr        AS CHAR  FORMAT "X"
   FIELD wnor_covamt    AS DECI  FORMAT "->>,>>>,>>9.99"
   FIELD wcomp_covamt   AS DECI  FORMAT "->>,>>>,>>9.99"
   FIELD wnor_comm      AS DECI  FORMAT "->>,>>>,>>9.99"
   FIELD wcomp_comm     AS DECI  FORMAT "->>,>>>,>>9.99"
   FIELD wnor_vat       AS DECI  FORMAT "->>,>>>,>>9.99"
   FIELD wcomp_vat      AS DECI  FORMAT "->>,>>>,>>9.99"
   FIELD wnor_tax3      AS DECI  FORMAT "->>,>>>,>>9.99"
   FIELD wcomp_tax3     AS DECI  FORMAT "->>,>>>,>>9.99"
   FIELD wbal           AS DECI  FORMAT "->>,>>>,>>9.99"
INDEX wBill01  IS UNIQUE PRIMARY wAcno wPolicy wEndno wTrnty1 wTrnty2 wDocno ASCENDING
/*       INDEX wBill02 wtrndat wASdat wacno */
INDEX wBill03 wComdat wNorpol wPol72.*/

DEFINE VAR nv_exportdat AS DATE  FORMAT "99/99/9999".
DEFINE VAR nv_exporttim AS CHAR FORMAT "X(8)".
DEFINE VAR nv_exportusr AS CHAR FORMAT "X(8)".
DEFINE VAR vCount     AS INTE INIT 1.
DEFINE VAR vExpCount1 AS INTE INIT 0.
DEFINE VAR vExpCount2 AS INTE INIT 0.
DEFINE VAR vExpCount3 AS INTE INIT 0.
DEFINE VAR vExpCount4 AS INTE INIT 0.
DEFINE VAR vCountRec  AS INTE INIT 0.   /* lek */
DEFINE VAR vBackUp    AS CHAR.
DEFINE VAR n_netloc   AS DECI.
DEFINE VAR y1 AS DECI.
DEFINE VAR z1 AS DECI.
DEFINE VAR p_trnty AS CHAR FORMAT 'X(2)'.
DEFINE VAR SUM AS DECI.
DEFINE VAR p_policy AS CHAR FORMAT 'X(12)'.

DEFINE TEMP-TABLE wfAcno
    FIELD wAcno    AS CHAR FORMAT "X(10)" 
    INDEX wList01 IS UNIQUE PRIMARY  wAcno ASCENDING.

DEFINE VAR vStamp      AS DECI.
DEFINE VAR vVat        AS DECI.
DEFINE VAR vStamp_comp AS DECI.
DEFINE VAR vVat_comp   AS DECI.

DEFINE VAR n_wh1  AS DECI FORMAT "->>9.99".
DEFINE VAR n_wh1c AS DECI FORMAT "->>9.99".
DEFINE VAR n_pol     AS CHAR FORMAT 'X(16)'.
DEFINE VAR n_ren     AS INTE FORMAT ">9".
DEFINE VAR n_end     AS INTE FORMAT "999".

DEFINE WORKFILE vehreg72 NO-UNDO
  FIELD polsta  AS CHAR FORMAT "X(02)"       /* Policy Status / IF,RE,CA */
  FIELD vehreg  AS CHAR FORMAT "X(10)"       /* Vehicle Registration No. */
  FIELD comdat  AS DATE FORMAT "99/99/9999"
  FIELD expdat  AS DATE FORMAT "99/99/9999"  /* Expiry DATE */
  FIELD enddat  AS DATE FORMAT "99/99/9999"  /* Endorsement DATE */
  FIELD del_veh AS CHAR FORMAT "X"           /* Delete Item / 0," "=No, 1=Yes*/
  FIELD policy  AS CHAR FORMAT "X(12)"
  FIELD rencnt  AS INTE FORMAT "999"
  FIELD endcnt  AS INTE FORMAT "999"
  FIELD riskgp  AS INTE FORMAT "999"
  FIELD riskno  AS INTE FORMAT "999"
  FIELD itemno  AS INTE FORMAT "999"
  FIELD sticker LIKE uwm301.sckno.

DEFINE VAR nv_strdate   AS CHAR.
DEFINE VAR nv_enddate   AS CHAR.
DEFINE VAR vAcProc_fil  AS CHAR.
DEFINE VAR nv_class     AS CHAR.
DEFINE VAR nv_output    AS CHAR.

DEFINE VAR nv_nettotal   AS DECI FORMAT "->>>,>>>,>>>,>>>,>>9.99".
DEFINE VAR nv_stamptotal AS DECI FORMAT "->>>,>>>,>>>,>>>,>>9.99".
DEFINE VAR nv_vattotal   AS DECI FORMAT "->>>,>>>,>>>,>>>,>>9.99".
DEFINE VAR nv_grosstotal AS DECI FORMAT "->>>,>>>,>>>,>>>,>>9.99".
DEFINE VAR nv_commtotal  AS DECI FORMAT "->>>,>>>,>>>,>>>,>>9.99".

DEFINE TEMP-TABLE  wagtprm_fil  
    FIELD Policy      AS CHAR  FORMAT "X(16)"
    FIELD trntyp      AS CHAR  FORMAT "x(2)"
    FIELD Docno       AS CHAR  FORMAT /*"x(7)"*/ "x(10)" /*A60-0267*/ 
    FIELD Vehreg      AS CHAR  FORMAT "X(15)"
    FIELD prem        AS DECI  FORMAT "->>,>>>,>>9.99"
    FIELD prem_comp   AS DECI  FORMAT "->>,>>>,>>9.99"
    FIELD Endno       AS CHAR  FORMAT "X(12)"
    FIELD bal         AS DECI  FORMAT "->>,>>>,>>9.99"
    FIELD Insure      AS CHAR  FORMAT "X(50)"
    FIELD stamp       AS DECI  FORMAT "->>,>>>,>>9.99"
    FIELD tax         AS DECI  FORMAT "->>,>>>,>>9.99"
    FIELD Acno        AS CHAR  FORMAT "X(10)" 
    FIELD Trnty       AS CHAR  FORMAT "X(2)"
    FIELD Comdat      AS DATE  FORMAT "99/99/9999"
    FIELD Poltyp      AS CHAR  FORMAT "X(3)"
    FIELD Trndat      AS DATE  FORMAT "99/99/9999"  
    FIELD ASdat       AS DATE  FORMAT "99/99/9999" 
INDEX wagtprm_fil01  IS UNIQUE PRIMARY Acno Policy Endno Trnty Docno ASCENDING .
def VAR nv_file  as  CHAR FORMAT "x(30)"   init  "".
DEFINE BUFFER Bwagtprm_fil  FOR wagtprm_fil.

DEFINE VAR n_poltyp  AS CHAR.
DEFINE VAR n_provin  AS CHAR FORMAT "X(20)".
DEFINE VAR n_vehreg1 AS CHAR FORMAT "X(15)".
DEFINE VAR n_vehreg2 AS CHAR FORMAT "X(15)".

DEFINE VAR NCount1 AS INTE.
DEFINE VAR NCount2 AS INTE.
DEFINE VAR NCount3 AS INTE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS fibranchfr fibranchto fiproducer bu_add ~
fi_comdatF fi_comdatT fioutput Btn_OK se_producer bu_del cbAsDat ra_type ~
Btn_Exit buBranch fibdes1 buBranch2 fibdes2 fi_process fioutput1 fioutput2 ~
fioutput3 RECT-219 RECT-221 RECT-222 RECT-223 RECT-225 RECT-226 RECT-227 
&Scoped-Define DISPLAYED-OBJECTS fibranchfr fibranchto fiproducer ~
fi_comdatF fi_comdatT fioutput se_producer cbAsDat ra_type fibdes1 fibdes2 ~
fi_process fioutput1 fioutput2 fioutput3 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON Btn_Exit AUTO-END-KEY 
     LABEL "Exit" 
     SIZE 10.5 BY 1.29
     BGCOLOR 8 FONT 6.

DEFINE BUTTON Btn_OK AUTO-GO 
     LABEL "OK" 
     SIZE 10.5 BY 1.29
     BGCOLOR 8 FONT 6.

DEFINE BUTTON buBranch 
     LABEL "..." 
     SIZE 3.5 BY 1 TOOLTIP "รหัสสาขา"
     FONT 6.

DEFINE BUTTON buBranch2 
     LABEL "..." 
     SIZE 3.5 BY 1 TOOLTIP "รหัสสาขา"
     FONT 6.

DEFINE BUTTON bu_add 
     LABEL "ADD" 
     SIZE 6.5 BY 1
     BGCOLOR 3 FONT 6.

DEFINE BUTTON bu_del 
     LABEL "DEL" 
     SIZE 6.5 BY 1
     BGCOLOR 4 FONT 6.

DEFINE VARIABLE cbAsDat AS CHARACTER FORMAT "X(256)":U INITIAL ? 
     VIEW-AS COMBO-BOX INNER-LINES 5
     DROP-DOWN-LIST
     SIZE 16 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fibdes1 AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 54.67 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fibdes2 AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 54.67 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fibranchfr AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 5 BY 1
     BGCOLOR 15 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fibranchto AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 5 BY 1
     BGCOLOR 15 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fioutput AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 43 BY 1
     BGCOLOR 15 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fioutput1 AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 43 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fioutput2 AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 43 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fioutput3 AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 43 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fiproducer AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 40 BY 1
     BGCOLOR 15 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_comdatF AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 15 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_comdatT AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 15 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_process AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 63 BY 1.05
     BGCOLOR 173 FGCOLOR 30 FONT 2 NO-UNDO.

DEFINE VARIABLE ra_type AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "By Comdate", 1,
"By Trandate", 2
     SIZE 45.17 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 2 NO-UNDO.

DEFINE RECTANGLE RECT-219
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 100.33 BY 1.43
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-221
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 12 BY 1.71
     BGCOLOR 1 FGCOLOR 1 .

DEFINE RECTANGLE RECT-222
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 12 BY 1.71
     BGCOLOR 4 .

DEFINE RECTANGLE RECT-223
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 8 BY 1.43
     BGCOLOR 3 .

DEFINE RECTANGLE RECT-225
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 8 BY 1.43
     BGCOLOR 4 .

DEFINE RECTANGLE RECT-226
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 100.33 BY 15.95
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-227
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 100 BY 3.95.

DEFINE VARIABLE se_producer AS CHARACTER 
     VIEW-AS SELECTION-LIST SINGLE SCROLLBAR-VERTICAL 
     SIZE 40 BY 3.57
     BGCOLOR 15 FGCOLOR 2 FONT 6 NO-UNDO.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     fibranchfr AT ROW 3.14 COL 28.67 COLON-ALIGNED NO-LABEL
     fibranchto AT ROW 4.43 COL 28.67 COLON-ALIGNED NO-LABEL
     fiproducer AT ROW 5.71 COL 28.67 COLON-ALIGNED NO-LABEL
     bu_add AT ROW 5.71 COL 73
     fi_comdatF AT ROW 12.1 COL 28.67 COLON-ALIGNED NO-LABEL
     fi_comdatT AT ROW 12.1 COL 57.17 COLON-ALIGNED NO-LABEL
     fioutput AT ROW 13.57 COL 28.67 COLON-ALIGNED NO-LABEL
     Btn_OK AT ROW 19.24 COL 73.5
     se_producer AT ROW 6.95 COL 30.83 NO-LABEL
     bu_del AT ROW 7.14 COL 73
     cbAsDat AT ROW 10.81 COL 28.67 COLON-ALIGNED NO-LABEL
     ra_type AT ROW 10.81 COL 48.67 NO-LABEL
     Btn_Exit AT ROW 19.24 COL 85.5
     buBranch AT ROW 3.14 COL 35.67
     fibdes1 AT ROW 3.14 COL 39 COLON-ALIGNED NO-LABEL
     buBranch2 AT ROW 4.43 COL 35.67
     fibdes2 AT ROW 4.43 COL 39 COLON-ALIGNED NO-LABEL
     fi_process AT ROW 19.38 COL 2.67 COLON-ALIGNED NO-LABEL
     fioutput1 AT ROW 15.05 COL 28.67 COLON-ALIGNED NO-LABEL
     fioutput2 AT ROW 16.24 COL 28.67 COLON-ALIGNED NO-LABEL
     fioutput3 AT ROW 17.43 COL 28.67 COLON-ALIGNED NO-LABEL
     "Output สวัสดิการ พนง. :" VIEW-AS TEXT
          SIZE 22 BY 1 AT ROW 16.24 COL 7.5
          BGCOLOR 8 FONT 6
     "Output รถใหญ่ :" VIEW-AS TEXT
          SIZE 15.67 BY 1 AT ROW 17.43 COL 14.67
          BGCOLOR 8 FONT 6
     "Output รถเล็ก :" VIEW-AS TEXT
          SIZE 14.17 BY 1 AT ROW 15.05 COL 15.5
          BGCOLOR 8 FONT 6
     "Date From :" VIEW-AS TEXT
          SIZE 12 BY 1 AT ROW 12.14 COL 18.17
          BGCOLOR 8 FONT 6
     "Date To :" VIEW-AS TEXT
          SIZE 10.5 BY 1 AT ROW 12.1 COL 48
          BGCOLOR 8 FONT 6
     "As of Date (Statement) :" VIEW-AS TEXT
          SIZE 23.17 BY 1 AT ROW 10.81 COL 6.5
          BGCOLOR 8 FONT 6
     "Branch To :" VIEW-AS TEXT
          SIZE 11.83 BY 1 AT ROW 4.43 COL 18
          BGCOLOR 8 FONT 6
     "Branch From :" VIEW-AS TEXT
          SIZE 13.67 BY 1 AT ROW 3.14 COL 16
          BGCOLOR 8 FONT 6
     "Report Statement NTL (เงินติดล้อ)" VIEW-AS TEXT
          SIZE 32.67 BY 1 AT ROW 1.48 COL 34.83
          BGCOLOR 1 FGCOLOR 7 FONT 6
     "Producer Code :" VIEW-AS TEXT
          SIZE 16 BY 1 AT ROW 5.71 COL 13.83
          BGCOLOR 8 FONT 6
     "Output To File (.CSV) :" VIEW-AS TEXT
          SIZE 22 BY 1 AT ROW 13.57 COL 7.5
          BGCOLOR 8 FONT 6
     RECT-219 AT ROW 1.24 COL 1.67
     RECT-221 AT ROW 19 COL 72.67
     RECT-222 AT ROW 19 COL 84.67
     RECT-223 AT ROW 5.52 COL 72.33
     RECT-225 AT ROW 6.95 COL 72.33
     RECT-226 AT ROW 2.71 COL 1.67
     RECT-227 AT ROW 14.71 COL 2
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 102.33 BY 21.57
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
         TITLE              = "wacrnlt1.w Report Billing"
         HEIGHT             = 20.52
         WIDTH              = 101.67
         MAX-HEIGHT         = 45.81
         MAX-WIDTH          = 213.33
         VIRTUAL-HEIGHT     = 45.81
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
/* SETTINGS FOR FRAME fr_main
   FRAME-NAME Custom                                                    */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* wacrnlt1.w Report Billing */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* wacrnlt1.w Report Billing */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_Exit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_Exit C-Win
ON CHOOSE OF Btn_Exit IN FRAME fr_main /* Exit */
DO:
    APPLY "Close" TO THIS-PROCEDURE.
    RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_OK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_OK C-Win
ON CHOOSE OF Btn_OK IN FRAME fr_main /* OK */
DO:
    /*--
    ASSIGN
        fibranchfr fibranchfr
        fibranchto fibranchto
        cbAsDat    cbAsDat.
    --*/

    ASSIGN
        n_time    =  STRING(TIME,"HH:MM:SS")
        n_branch  =  fibranchfr
        n_branch2 =  fibranchto
        n_asdat   =  DATE(INPUT cbAsDat)
        n_output  =  fioutput
        n_comdatF =  fi_comdatF
        n_comdatT =  fi_comdatT.

    IF fiBranchfr = "" THEN DO:
        MESSAGE "กรุณาใส่รหัสสาขา" VIEW-AS ALERT-BOX WARNING.
        APPLY "Entry" TO fiBranchfr.
        RETURN NO-APPLY.
    END.
    IF fibranchto = "" THEN DO:
        MESSAGE "กรุณาใส่รหัสสาขา" VIEW-AS ALERT-BOX WARNING.
        APPLY "ENTRY" TO fibranchto.
        RETURN NO-APPLY.
    END.
    IF fibranchfr > fibranchto THEN DO:
        MESSAGE "ข้อมูลรหัสสาขาผิดพลาด" SKIP
                "รหัสสาขาเริ่มต้นต้องน้อยกว่ารหัสสุดท้าย" VIEW-AS ALERT-BOX WARNING.
        APPLY "ENTRY" TO fibranchfr.
        RETURN NO-APPLY.
    END.
    IF fioutput = "" THEN DO:
        MESSAGE "กรุณาใส่ชื่อไฟล์" VIEW-AS ALERT-BOX WARNING.
        APPLY "ENTRY" TO fioutput.
        RETURN NO-APPLY.
    END.

    nv_strdate = STRING(TODAY,"99/99/9999") + " " + STRING(TIME, "HH:MM").

    IF n_type = 1 THEN DO:

        RUN PDProcess1.
        RUN PDNL110.
        RUN PDNL210.
        RUN PDNL320.

    END.
    ELSE IF n_type = 2 THEN DO:

        RUN PDProcess2.
        RUN PDNL110.
        RUN PDNL210.
        RUN PDNL320.
    END.

    /*RUN PDProcessEx.*/

    vCountRec = vExpCount1 + vExpCount2 + vExpCount3.

    nv_enddate = STRING(TODAY,"99/99/9999") + " " + STRING(TIME, "HH:MM").

    MESSAGE "การส่งออก จำนวน : " vCountRec  " รายการ"     SKIP(1)

            "ทำการ Dump ข้อมูล ลง Excel File : "  fioutput1  SKIP
            "รถเล็ก จำนวน : " vExpCount1  " รายการ"     SKIP(1)

            "ทำการ Dump ข้อมูล ลง Excel File : "  fioutput2  SKIP
            "รถสวัสดิการ พนง. จำนวน : " vExpCount2  " รายการ"     SKIP(1)

            "ทำการ Dump ข้อมูล ลง Excel File : "  fioutput3  SKIP
            "รถใหญ่ จำนวน : " vExpCount3  " รายการ"     SKIP(1)

            "Start Date : " nv_strdate " น." SKIP
            "  End Date : " nv_enddate " น." VIEW-AS ALERT-BOX INFORMATION.

    APPLY "ENTRY" TO Btn_Exit.

END. /*DO*/

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buBranch
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buBranch C-Win
ON CHOOSE OF buBranch IN FRAME fr_main /* ... */
DO:
    n_chkBName = "1".
    RUN Whp\Whpbran(INPUT-OUTPUT  n_bdes,INPUT-OUTPUT n_chkBName).
    
    ASSIGN
       fibranchfr = n_branch
       fibdes1    = n_bdes.

   DISP fibranchfr fibdes1 WITH FRAME {&FRAME-NAME}.

   APPLY "ENTRY" TO fibranchfr IN FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buBranch2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buBranch2 C-Win
ON CHOOSE OF buBranch2 IN FRAME fr_main /* ... */
DO:
    n_chkBName = "2".
    RUN Whp\Whpbran(INPUT-OUTPUT n_bdes,INPUT-OUTPUT n_chkBName).

    ASSIGN
        fibranchto = n_branch2
        fibdes2    = n_bdes.

    DISP fibranchto fibdes2 WITH FRAME {&FRAME-NAME}.

    APPLY "ENTRY" TO fibranchto IN FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_add
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_add C-Win
ON CHOOSE OF bu_add IN FRAME fr_main /* ADD */
DO:
    IF fiproducer = "" THEN DO:
        MESSAGE "Not Create Brand..! is empty!!!..." VIEW-AS ALERT-BOX.
        APPLY "ENTRY" TO fiproducer.
    END.
    ELSE DO:
        vProdCod = se_producer:LIST-ITEMS.
        vChkFirstAdd = IF vProdCod = ? THEN 1 ELSE 0.

        IF (LOOKUP(fiproducer,vProdCod) <> 0) AND (vProdCod <> ?) THEN DO:
            fiproducer = "".
            MESSAGE "Please Check Brand Code dupplicate!!!" VIEW-AS ALERT-BOX WARNING TITLE "Confirm".
            APPLY "ENTRY" TO fiproducer.
        END.
        ELSE DO:
            IF vProdCod = ? THEN vChkFirstAdd = 1.
            IF vChkFirstAdd = 1 THEN DO:
                DO WITH FRAME fr_main:
                    ASSIGN fiproducer.
                    se_producer:ADD-FIRST(fiproducer).
                    se_producer = se_producer:SCREEN-VALUE.  
                END.

                ASSIGN vProdCod   = vProdCod + "," + fiproducer
                       fiproducer = "".

                APPLY "ENTRY" TO fiproducer IN FRAME fr_main.
                DISP fiproducer WITH FRAME fr_main.
            END.
            ELSE DO:
                IF LOOKUP(fiproducer,vProdCod) <> 0 THEN DO:
                    MESSAGE "Not Create Brand..!" VIEW-AS ALERT-BOX ERROR.
                    APPLY "ENTRY" TO fiproducer.
                END.
                ELSE DO:
                    DO WITH FRAME fr_main:
                        ASSIGN fiproducer.
                        se_producer:ADD-FIRST(fiproducer).
                        se_producer = se_producer:SCREEN-VALUE .
                    END.
                    ASSIGN
                        vProdCod   = vProdCod + "," + fiproducer
                        fiproducer = "".

                    APPLY "ENTRY" TO fiproducer IN FRAME fr_main.
                    DISP fiproducer WITH FRAME fr_main.
                END.
            END.
        END.
    END.

    ASSIGN fiproducer = "".
    APPLY "ENTRY" TO fiproducer IN FRAME fr_main.
    DISP fiproducer WITH FRAME fr_main.
    vProdCod = se_producer:LIST-ITEMS.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_del
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_del C-Win
ON CHOOSE OF bu_del IN FRAME fr_main /* DEL */
DO:
    DO WITH FRAME fr_main:
        se_producer = se_producer:SCREEN-VALUE.

        IF LOOKUP(se_producer,vProdCod) <> 0 THEN DO:
            IF LOOKUP(se_producer,vProdCod) = 1 THEN
                vProdCod = SUBSTR(vProdCod,LENGTH(se_producer) + 2).
            ELSE 
                vProdCod = SUBSTR(vProdCod,1,INDEX(vProdCod,se_producer) - 2 ) + 
                           SUBSTR(vProdCod,INDEX(vProdCod,se_producer) + LENGTH(se_producer) ).
        END.

        ASSIGN se_producer.

        se_producer:DELETE(se_producer).
        se_producer = se_producer:SCREEN-VALUE.

    END.
    DISP "" @ fiproducer WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME cbAsDat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cbAsDat C-Win
ON LEAVE OF cbAsDat IN FRAME fr_main
DO:
  /*  /*p-------------*/
    cbAsDat = INPUT cbAsDat.
    n_asdat = DATE(INPUT cbAsDat).

    IF n_asdat = ? THEN DO:
        MESSAGE "ไม่พบข้อมูล กรุณาตรวจสอบการ Process ข้อมูล" VIEW-AS ALERT-BOX WARNING.
        RETURN NO-APPLY.
    END.
    /*-------------p*/

    APPLY "ENTRY" TO fi_comdatF.*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cbAsDat C-Win
ON RETURN OF cbAsDat IN FRAME fr_main
DO:
      cbAsDat = INPUT cbAsDat.
      n_asdat    =  DATE( INPUT cbAsDat).         
      IF n_asdat = ? THEN DO:
         MESSAGE "ไม่พบข้อมูล  กรุณาตรวจสอบการ Process ข้อมูล" VIEW-AS ALERT-BOX WARNING.      
         RETURN NO-APPLY.
      END.
             
      APPLY "ENTRY" TO fi_comdatF IN FRAME {&FRAME-NAME}.
      RETURN NO-APPLY.          
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cbAsDat C-Win
ON VALUE-CHANGED OF cbAsDat IN FRAME fr_main
DO:
 
    cbAsDat = INPUT cbAsDat.
    n_asdat = DATE(INPUT cbAsDat).

    IF n_asdat = ? THEN DO:
        MESSAGE "ไม่พบข้อมูล กรุณาตรวจสอบการ Process ข้อมูล" VIEW-AS ALERT-BOX WARNING.
        RETURN NO-APPLY.
    END.
    APPLY "ENTRY" TO fi_comdatF IN FRAME {&FRAME-NAME}.
    RETURN NO-APPLY.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fibranchfr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fibranchfr C-Win
ON LEAVE OF fibranchfr IN FRAME fr_main
DO:
  fibranchfr = CAPS(INPUT fibranchfr).
  DISP fibranchfr WITH FRAME fr_main.

  FIND FIRST xmm023 WHERE xmm023.branch = fibranchfr NO-LOCK NO-ERROR.
  IF AVAIL xmm023 THEN DO:
      fibdes1 = xmm023.bdes.
      DISP fibdes1 WITH FRAME fr_main.
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fibranchto
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fibranchto C-Win
ON LEAVE OF fibranchto IN FRAME fr_main
DO:
  fibranchto = CAPS(INPUT fibranchto).
  DISP fibranchto WITH FRAME fr_main.

  FIND FIRST xmm023 WHERE xmm023.branch = fibranchto NO-LOCK NO-ERROR.
  IF AVAIL xmm023 THEN DO:
      fibdes2 = xmm023.bdes.
      DISP fibdes2 WITH FRAME fr_main.
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fioutput
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fioutput C-Win
ON LEAVE OF fioutput IN FRAME fr_main
DO:
  fioutput = INPUT fioutput.

  IF fioutput <> "" THEN DO:
      fioutput1 = fioutput + "_110.CSV".
      fioutput2 = fioutput + "_210.CSV".
      fioutput3 = fioutput + "_320.CSV".
    
      DISP fioutput1 fioutput2 fioutput3 WITH FRAME fr_main.
  END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fioutput1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fioutput1 C-Win
ON LEAVE OF fioutput1 IN FRAME fr_main
DO:
  fioutput = INPUT fioutput.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fioutput2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fioutput2 C-Win
ON LEAVE OF fioutput2 IN FRAME fr_main
DO:
  fioutput = INPUT fioutput.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fioutput3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fioutput3 C-Win
ON LEAVE OF fioutput3 IN FRAME fr_main
DO:
  fioutput = INPUT fioutput.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiproducer
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiproducer C-Win
ON LEAVE OF fiproducer IN FRAME fr_main
DO:
  fiproducer = CAPS(INPUT fiproducer).
  DISPLAY fiproducer WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_comdatF
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_comdatF C-Win
ON LEAVE OF fi_comdatF IN FRAME fr_main
DO:
  fi_comdatF = input fi_comdatF.
  n_comdatF = fi_comdatF.   

  fi_comdatT = fi_comdatF.
  DISP fi_comdatT WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_comdatT
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_comdatT C-Win
ON LEAVE OF fi_comdatT IN FRAME fr_main
DO:
   fi_comdatT = input fi_comdatT.
   n_comdatT = fi_comdatT.
   APPLY "ENTRY" TO fioutput IN FRAME {&FRAME-NAME}.
   RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ra_type
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_type C-Win
ON VALUE-CHANGED OF ra_type IN FRAME fr_main
DO:
    ASSIGN
        ra_type = INPUT ra_type
        n_type  = ra_type.

    IF n_type = 1 THEN DO:
        APPLY "ENTRY" TO fi_comdatF IN FRAME {&FRAME-NAME}.
        RETURN NO-APPLY.
    END.
    ELSE IF n_type = 2 THEN DO:
        APPLY "ENTRY" TO fi_comdatF IN FRAME {&FRAME-NAME}.
        RETURN NO-APPLY.
    END.
    DISP ra_type WITH FRAME {&FRAME-NAME}.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME se_producer
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL se_producer C-Win
ON VALUE-CHANGED OF se_producer IN FRAME fr_main
DO:
  IF (se_producer = ?) OR (se_producer = "")  THEN
      ASSIGN se_producer = "".
  IF vProdCod = ? THEN vProdCod = "".
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
  
  gv_prgid = "wacrnlt1".
  gv_prog  = "การส่งข้อมูล Text File เพื่อวางบิล เงินติดล้อ".
  RUN  WUT\WUTHEAD (c-win:handle,gv_prgid,gv_prog).

  Run Wut\WutDiCen(C-win:handle).
  /*********************************************************************/

  SESSION:DATA-ENTRY-RETURN = YES.

  ASSIGN
      ra_type = 1
      n_type  = ra_type.

  cbAsdat = vAcProc_fil.
  fiproducer = "B3M0040".
  fioutput = "D:\NL\NTL01".

  RUN pdAcproc_fil.

  IF fioutput <> "" THEN DO:
      fioutput1 = fioutput + "_110.CSV".
      fioutput2 = fioutput + "_210.CSV".
      fioutput3 = fioutput + "_320.CSV".
    
      DISP fioutput1 fioutput2 fioutput3 WITH FRAME fr_main.
  END.

  DISP fiproducer fioutput WITH FRAME fr_main.
  APPLY "CHOOSE" TO bu_add IN FRAME fr_main. 

  APPLY "ENTRY" TO fibranchfr IN FRAME fr_main.

  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE BKPDNL110 C-Win 
PROCEDURE BKPDNL110 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE BUFFER bufwBill FOR wBill.
DEFINE VAR n_wRecordno     AS INTE FORMAT "999999" INIT 0. 

ASSIGN
    nv_nettotal   = 0
    nv_stamptotal = 0
    nv_vattotal   = 0
    nv_grosstotal = 0
    nv_commtotal  = 0.

OUTPUT STREAM ns1 TO VALUE(fioutput1).
/*-- Heading --*/
PUT STREAM ns1
    "Agent Code :" "|"
    "74000414 : บริษัท เงินติดล้อ จำกัด" "|"
    "|" "|" "|" "|"
    "ใบแจ้งหนี้ / ใบวางบิล" "|"
    "|" "|" "|" "|" "|" "|" 
    "ส่งกรมธรรม์พร้อมวางบิล" 
    SKIP.

PUT STREAM ns1
    "ที่อยู่จัดส่ง :" "|"
    "เลขที่ 89/170 อาคารจุฑามาศ ชั้น 4 ถนนวิภาวดีรังสิต แขวงตลาดบางเขน เขตหลักสี่ กทม. 10210" "|"
    "|" "|" "|" "|"
    "ประกันภัยรถยนต์ โปรกเกอร์เงินติดล้อ" "|"
    "|" "|" "|" "|" "|" "|"
    "รถยนต์ ขนาดเล็ก"
    SKIP.

PUT STREAM ns1
    "เรียน :" "|"
    "คุณลลินตา สาระศาลิน" "|"
    "เรียน :" "|"
    "คุณชญานุตย์ ศิริวัฒน์ปิติวงษ์" "|"
    "|" "|" "|"
    "งวดระหว่างวันที่"
    "|" "|" "|" "|" "|" "|"
    "วันที่"
    SKIP.

PUT STREAM ns1
    "โทรศัพท์ :" "|"
    "02-792-1888 ต่อ 1547" "|"
    "โทรศัพท์ :" "|"
    "02-792-1888 Ext.1564" "|"
    "|" "|"
    "รวมจำนวน" "|"
    "|"
    "กรมธรรม์"
    SKIP.

PUT STREAM ns1
    "โทรสาร :" "|"
    "02-792-1889" "|"
    "โทรสาร :" "|"
    "02-792-1889" 
    SKIP.

PUT STREAM ns1
    "โทร(มือถือ):" "|" "|"
    "โทร(มือถือ):"
    SKIP.

PUT STREAM ns1
    "E-mail :" "|"
    "lalinta.S@cfg.co.th" "|"
    "E-mail :" "|"
    "Chanphen.N@cfg.co.th"
    SKIP.

PUT STREAM ns1
    "วัตถุประสงค์:" "|"
    "เพื่อนำส่งเอกสาร กรมธรรม์ประกันภัยรถยนต์ และ สำเนาใบเสร็จรับเงิน"
    SKIP.

PUT STREAM ns1
    "รายละเอียดค่าเบี้ยประกันภัยลูกค้า บริษัท เงินติดล้อ จำกัด ที่ต้องชำระ ณ.วันที่"
    SKIP.

PUT STREAM ns1
    "ลำดับ" "|"
    "กรมธรรม์เลขที่/สลักหลัง" "|"
    "เลขที่ใบเสร็จรับเงิน" "|"
    "ชื่อผู้เอาประกันภัย" "|"
    "วันคุ้มครอง" "|"
    "วันสิ้นสุด" "|"
    "ทะเบียน" "|"
    "จังหวัด" "|"
    "ประเภท" "|"
    "ทุนประกัน" "|"
    "เบี้ยสุทธิ" "|"
    "อากร 0.4%" "|"
    "ภาษี 7%" "|"
    "เบี้ยรวม" "|"
    "ส่วนลด 18%" "|"
    "หมายเหตุ" SKIP.

FOR EACH wBill WHERE wBill.wClass = "110" NO-LOCK:
    n_wRecordno = n_wRecordno + 1.

    PUT STREAM ns1
        n_wRecordno      "|"
        wBill.wPolicy    "|"
        wBill.wDocno     "|"
        wBill.wInsure    "|"
        wBill.wComdat    "|"
        wBill.wExpdat    "|"
        wBill.wVehreg    "|"
        wBill.wProvin    "|"
        wBill.wcovcod    "|"
        wBill.wsi        "|"
        wBill.wGrossPrem "|"
        wBill.wStamp     "|"
        wBill.wTax       "|"
        wBill.wNetPrem   "|"
        wBill.wComm      "|"
        wBill.wRemark    SKIP.

    ASSIGN
        nv_grosstotal = nv_grosstotal + wBill.wGrossPrem
        nv_stamptotal = nv_stamptotal + wBill.wStamp
        nv_vattotal   = nv_vattotal   + wBill.wTax  
        nv_nettotal   = nv_nettotal   + wBill.wNetPrem
        nv_commtotal  = nv_commtotal  + wBill.wComm .
END.

PUT STREAM ns1
    "|" "|" "|" "|" "|" "|" "|" "|" "|" "|"
    nv_grosstotal "|"
    nv_stamptotal "|"
    nv_vattotal   "|"
    nv_nettotal   "|"
    nv_commtotal  SKIP.

vExpCount1 = n_wRecordno.

/*-- Footer --*/
PUT STREAM ns1
    SKIP(2)
    "หากมีข้อสงสัยกรุณาติดต่อ" "|"
    "|" "|" "|" "|" "|" "|" "|"
    "Fee of Rebate(ค่านายหน้า) 18%" "|"
    "com 18%"
    SKIP.

PUT STREAM ns1
    "|" "|" "|" "|" "|" "|" "|" "|" "|"
    "+Vat7%"
    SKIP.

PUT STREAM ns1
    "|" "|" "|" "|" "|" "|" "|" "|" "|"
    "-tax3%"
    SKIP.

PUT STREAM ns1
    "** บริษัทฯ ขอให้ท่านช่วยโปรดชำระค่าเบี้ยประกันภัย ตามระเบียบ CBC ซึ่งเป็นกฏระเบียบของ คปภ. โดยให้ตรงตามวันที่กำหนดด้วย***" "|"
    "|" "|" "|" "|" "|" "|" "|" "|"
    "paid" "|" "|" 
    SKIP.

PUT STREAM ns1
    "** บริษัทฯ ขอส่งหนังสือสรุป และขอสอบถามการชำระค่าเบี้ยประกันภัยถึง CFG เพื่อตรวจสอบการชำระเงินของลูกค้า **" SKIP.
PUT STREAM ns1
    "รอบบิล :" "|"
    "ระหว่างวันที่ 1 - 15 ของเดือน ชำระเงินภายในวันที่ 30 ขอเดือนนั้นๆ" SKIP.
PUT STREAM ns1
    "|"
    "ระหว่างวันที่ 16 - 31 ของเดือน ชำระภายในวันที่ 15 ของเดือนถัดไป"
    "|" "|" "|" "|" "|" "|" "|"
    "Fee of Rebate (ค่าบริการประสานงานรับประกันภัย) 5%" "|"
    "com 5%" SKIP.

PUT STREAM ns1
    "|" "|" "|" "|" "|" "|" "|" "|" "|" "+vat7%" SKIP.
PUT STREAM ns1
    "|" "|" "|" "|" "|" "|" "|" "|" "|" "-tax3%" SKIP.

PUT STREAM ns1
    "ผู้วางบิล/ผู้รับกรมธรรม์" "|" "|"
    "ผู้วางบิล" "|" "|"
    "|" "|" "|" "|" "|"
    "paid"
    SKIP(3).

PUT STREAM ns1
    "ลงวันที่" "|" "|"
    "ลงวันที่" "|" "|"
    "|" "|" "|" "|" "|" 
    "-tax1% (กรณีผู้เอาประกันภัยเป็นนิติบุคคล)"
    SKIP.

PUT STREAM ns1
    "|" "|" "|" "|" "|" "|" "|" "|" "|" "รวมหัก tax1%" SKIP(1).

PUT STREAM ns1
    "|" "|" "|" "|" "|" "|" "|" "|" "|" "ยอดหน้าเช็ค" SKIP.
PUT STREAM ns1
    "|" "|" "|" "|" "|" "|" "|" "|" "|" "(ศูนย์บาทถ้วน)" SKIP.


OUTPUT STREAM ns1 CLOSE.



END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE BKPDNL210 C-Win 
PROCEDURE BKPDNL210 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE BUFFER bufwBill FOR wBill.
DEFINE VAR n_wRecordno     AS INTE FORMAT "999999" INIT 0. 

ASSIGN
    nv_nettotal   = 0
    nv_stamptotal = 0
    nv_vattotal   = 0
    nv_grosstotal = 0
    nv_commtotal  = 0.

OUTPUT STREAM ns2 TO VALUE(fioutput2).
/*-- Heading --*/
PUT STREAM ns2
    "Agent Code :" "|"
    "74000414 : บริษัท เงินติดล้อ จำกัด" "|"
    "|" "|" "|" "|"
    "ใบแจ้งหนี้ / ใบวางบิล" "|"
    "|" "|" "|" "|" "|" "|"
    "วันที่"
    SKIP.

PUT STREAM ns2
    "ที่อยู่จัดส่ง :" "|"
    "เลขที่ 89/170 อาคารจุฑามาศ ชั้น 4 ถนนวิภาวดีรังสิต แขวงตลาดบางเขน เขตหลักสี่ กทม. 10210" "|"
    "|" "|" "|" "|"
    "ประกันภัยรถยนต์ โปรกเกอร์เงินติดล้อ" "|"
    SKIP.

PUT STREAM ns2
    "เรียน :" "|"
    "คุณลลินตา สาระศาลิน" "|"
    "เรียน :" "|"
    "คุณชญานุตย์ ศิริวัฒน์ปิติวงษ์" "|"
    "|" "|" "|"
    "งวดระหว่างวันที่"
    SKIP.

PUT STREAM ns2
    "โทรศัพท์ :" "|"
    "02-792-1888 ต่อ 1547" "|"
    "โทรศัพท์ :" "|"
    "02-792-1888 Ext.1564" "|"
    "|" "|"
    "รวมจำนวน" "|"
    "|"
    "กรมธรรม์"
    SKIP.

PUT STREAM ns2
    "โทรสาร :" "|"
    "02-792-1889" "|"
    "โทรสาร :" "|"
    "02-792-1889" 
    SKIP.

PUT STREAM ns2
    "โทร(มือถือ):" "|" "|"
    "โทร(มือถือ):"
    SKIP.

PUT STREAM ns2
    "E-mail :" "|"
    "lalinta.S@cfg.co.th" "|"
    "E-mail :" "|"
    "Chanphen.N@cfg.co.th"
    SKIP.

PUT STREAM ns2
    "วัตถุประสงค์:" "|"
    "เพื่อนำส่งเอกสาร กรมธรรม์ประกันภัยรถยนต์ และ สำเนาใบเสร็จรับเงิน"
    SKIP.

PUT STREAM ns2
    "รายละเอียดค่าเบี้ยประกันภัยลูกค้า บริษัท เงินติดล้อ จำกัด ที่ต้องชำระ ณ.วันที่"
    SKIP.

PUT STREAM ns2
    "ลำดับ" "|"
    "กรมธรรม์เลขที่/สลักหลัง" "|"
    "เลขที่ใบเสร็จรับเงิน" "|"
    "ชื่อผู้เอาประกันภัย" "|"
    "วันคุ้มครอง" "|"
    "วันสิ้นสุด" "|"
    "ทะเบียน" "|"
    "จังหวัด" "|"
    "ประเภท" "|"
    "ทุนประกัน" "|"
    "เบี้ยสุทธิ" "|"
    "อากร 0.4%" "|"
    "ภาษี 7%" "|"
    "เบี้ยรวม" "|"
    "ส่วนลด 18%" "|"
    "หมายเหตุ" SKIP.

FOR EACH wBill WHERE wBill.wClass = "210" NO-LOCK:
    n_wRecordno = n_wRecordno + 1.

    PUT STREAM ns2
        n_wRecordno      "|"
        wBill.wPolicy    "|"
        wBill.wDocno     "|"
        wBill.wInsure    "|"
        wBill.wComdat    "|"
        wBill.wExpdat    "|"
        wBill.wVehreg    "|"
        wBill.wProvin    "|"
        wBill.wcovcod    "|"
        wBill.wsi        "|"
        wBill.wGrossPrem "|"
        wBill.wStamp     "|"
        wBill.wTax       "|"
        wBill.wNetPrem   "|"
        wBill.wComm      "|"
        wBill.wRemark    SKIP.

    ASSIGN
        nv_grosstotal = nv_grosstotal + wBill.wGrossPrem
        nv_stamptotal = nv_stamptotal + wBill.wStamp
        nv_vattotal   = nv_vattotal   + wBill.wTax  
        nv_nettotal   = nv_nettotal   + wBill.wNetPrem
        nv_commtotal  = nv_commtotal  + wBill.wComm .
END.

PUT STREAM ns2
    "|" "|" "|" "|" "|" "|" "|" "|" "|" "|"
    nv_grosstotal "|"
    nv_stamptotal "|"
    nv_vattotal   "|"
    nv_nettotal   "|"
    nv_commtotal  SKIP.

vExpCount2 = n_wRecordno.

/*-- Footer --*/
PUT STREAM ns2
    SKIP(2)
    "หากมีข้อสงสัยกรุณาติดต่อ" "|"
    "|" "|" "|" "|" "|" "|" "|"
    "Fee of Rebate(ค่านายหน้า) 18%" "|"
    "com 18%"
    SKIP.

PUT STREAM ns2
    "|" "|" "|" "|" "|" "|" "|" "|" "|"
    "+Vat7%"
    SKIP.

PUT STREAM ns2
    "|" "|" "|" "|" "|" "|" "|" "|" "|"
    "-tax3%"
    SKIP.

PUT STREAM ns2
    "** บริษัทฯ ขอให้ท่านช่วยโปรดชำระค่าเบี้ยประกันภัย ตามระเบียบ CBC ซึ่งเป็นกฏระเบียบของ คปภ. โดยให้ตรงตามวันที่กำหนดด้วย***" "|"
    "|" "|" "|" "|" "|" "|" "|" "|"
    "paid" "|" "|" 
    SKIP.

PUT STREAM ns2
    "** บริษัทฯ ขอส่งหนังสือสรุป และขอสอบถามการชำระค่าเบี้ยประกันภัยถึง CFG เพื่อตรวจสอบการชำระเงินของลูกค้า **" SKIP.
PUT STREAM ns2
    "รอบบิล :" "|"
    "ระหว่างวันที่ 1 - 15 ของเดือน ชำระเงินภายในวันที่ 30 ขอเดือนนั้นๆ" SKIP.
PUT STREAM ns2
    "|"
    "ระหว่างวันที่ 16 - 31 ของเดือน ชำระภายในวันที่ 15 ของเดือนถัดไป"
    "|" "|" "|" "|" "|" "|" "|"
    "Fee of Rebate (ค่าบริการประสานงานรับประกันภัย) 5%" "|"
    "com 5%" SKIP.

PUT STREAM ns2
    "|" "|" "|" "|" "|" "|" "|" "|" "|" "+vat7%" SKIP.
PUT STREAM ns2
    "|" "|" "|" "|" "|" "|" "|" "|" "|" "-tax3%" SKIP.

PUT STREAM ns2
    "ผู้วางบิล/ผู้รับกรมธรรม์" "|" "|"
    "ผู้วางบิล" "|" "|"
    "|" "|" "|" "|" "|"
    "paid"
    SKIP(3).

PUT STREAM ns2
    "ลงวันที่" "|" "|"
    "ลงวันที่" "|" "|"
    "|" "|" "|" "|" "|" 
    "-tax1% (กรณีผู้เอาประกันภัยเป็นนิติบุคคล)"
    SKIP.

PUT STREAM ns2
    "|" "|" "|" "|" "|" "|" "|" "|" "|" "รวมหัก tax1%" SKIP(1).

PUT STREAM ns2
    "|" "|" "|" "|" "|" "|" "|" "|" "|" "ยอดหน้าเช็ค" SKIP.
PUT STREAM ns2
    "|" "|" "|" "|" "|" "|" "|" "|" "|" "(ศูนย์บาทถ้วน)" SKIP.


OUTPUT STREAM ns2 CLOSE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE BKPDNL302 C-Win 
PROCEDURE BKPDNL302 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE BUFFER bufwBill FOR wBill.
DEFINE VAR n_wRecordno     AS INTE FORMAT "999999" INIT 0. 

ASSIGN
    nv_nettotal   = 0
    nv_stamptotal = 0
    nv_vattotal   = 0
    nv_grosstotal = 0
    nv_commtotal  = 0.

OUTPUT STREAM ns3 TO VALUE(fioutput3).
/*-- Heading --*/

PUT STREAM ns3
    "|" "|" "|" "|" "|" "|" "|" 
    "|" "|" "|" "|" "|" "|"
    "ส่งกรมธรรม์พร้อมวางบิล" SKIP.

PUT STREAM ns3
    "|" "|" "|" "|" "|" "|" "|" 
    "|" "|" "|" "|" "|" "|"
    "รถยนต์ ขนาดใหญ่" SKIP.

PUT STREAM ns3
    "Agent Code :" "|"
    "74000414 : บริษัท เงินติดล้อ จำกัด" "|"
    "|" "|" "|" "|"
    "ใบแจ้งหนี้ / ใบวางบิล" 
    SKIP.

PUT STREAM ns3
    "ที่อยู่จัดส่ง :" "|"
    "เลขที่ 89/170 อาคารจุฑามาศ ชั้น 4 ถนนวิภาวดีรังสิต แขวงตลาดบางเขน เขตหลักสี่ กทม. 10210" "|"
    "|" "|" "|" "|"
    "ประกันภัยรถยนต์ โปรกเกอร์เงินติดล้อ" "|"
    SKIP.

PUT STREAM ns3
    "เรียน :" "|"
    "คุณลลินตา สาระศาลิน" "|"
    "เรียน :" "|"
    "คุณชญานุตย์ ศิริวัฒน์ปิติวงษ์" "|"
    "|" "|" "|"
    "งวดระหว่างวันที่"
    SKIP.

PUT STREAM ns3
    "โทรศัพท์ :" "|"
    "02-792-1888 ต่อ 1547" "|"
    "โทรศัพท์ :" "|"
    "02-792-1888 Ext.1564" "|"
    "|" "|"
    "รวมจำนวน" "|"
    "|"
    "กรมธรรม์"
    SKIP.

PUT STREAM ns3
    "โทรสาร :" "|"
    "02-792-1889" "|"
    "โทรสาร :" "|"
    "02-792-1889" 
    SKIP.

PUT STREAM ns3
    "โทร(มือถือ):" "|" "|"
    "โทร(มือถือ):"
    SKIP.

PUT STREAM ns3
    "E-mail :" "|"
    "lalinta.S@cfg.co.th" "|"
    "E-mail :" "|"
    "Chanphen.N@cfg.co.th"
    SKIP.

PUT STREAM ns3
    "วัตถุประสงค์:" "|"
    "เพื่อนำส่งเอกสาร กรมธรรม์ประกันภัยรถยนต์ และ สำเนาใบเสร็จรับเงิน"
    SKIP.

PUT STREAM ns3
    "รายละเอียดค่าเบี้ยประกันภัยลูกค้า บริษัท เงินติดล้อ จำกัด ที่ต้องชำระ ณ.วันที่"
    SKIP.

PUT STREAM ns3
    "ลำดับ" "|"
    "กรมธรรม์เลขที่/สลักหลัง" "|"
    "เลขที่ใบเสร็จรับเงิน" "|"
    "ชื่อผู้เอาประกันภัย" "|"
    "วันคุ้มครอง" "|"
    "วันสิ้นสุด" "|"
    "ทะเบียน" "|"
    "จังหวัด" "|"
    "ประเภท" "|"
    "ทุนประกัน" "|"
    "เบี้ยสุทธิ" "|"
    "อากร 0.4%" "|"
    "ภาษี 7%" "|"
    "เบี้ยรวม" "|"
   /* "ส่วนลด 18%" "|"*/
    "สังกัด" SKIP.

FOR EACH wBill WHERE wBill.wClass = "320" NO-LOCK:
    n_wRecordno = n_wRecordno + 1.

    PUT STREAM ns3
        n_wRecordno      "|"
        wBill.wPolicy    "|"
        wBill.wDocno     "|"
        wBill.wInsure    "|"
        wBill.wComdat    "|"
        wBill.wExpdat    "|"
        wBill.wVehreg    "|"
        wBill.wProvin    "|"
        wBill.wcovcod    "|"
        wBill.wsi        "|"
        wBill.wGrossPrem "|"
        wBill.wStamp     "|"
        wBill.wTax       "|"
        wBill.wNetPrem   "|"
        wBill.wRemark    SKIP.

    ASSIGN
        nv_grosstotal = nv_grosstotal + wBill.wGrossPrem
        nv_stamptotal = nv_stamptotal + wBill.wStamp
        nv_vattotal   = nv_vattotal   + wBill.wTax  
        nv_nettotal   = nv_nettotal   + wBill.wNetPrem
        nv_commtotal  = nv_commtotal  + wBill.wComm .
END.

PUT STREAM ns3
    "|" "|" "|" "|" "|" "|" "|" "|" "|" "|"
    nv_grosstotal "|"
    nv_stamptotal "|"
    nv_vattotal   "|"
    nv_nettotal   SKIP.

vExpCount3 = n_wRecordno.

/*-- Footer --*/
PUT STREAM ns3
    SKIP(2)
    "หากมีข้อสงสัยกรุณาติดต่อ" "|"
    "|" "|" "|" "|" "|" "|" "|"
    "Fee of Rebate(ค่านายหน้า) 15%" "|"
    "com 15%"
    SKIP.

PUT STREAM ns3
    "|" "|" "|" "|" "|" "|" "|" "|" "|"
    "+Vat7%"
    SKIP.

PUT STREAM ns3
    "|" "|" "|" "|" "|" "|" "|" "|" "|"
    "-tax3%"
    SKIP.

PUT STREAM ns3
    "** บริษัทฯ ขอให้ท่านช่วยโปรดชำระค่าเบี้ยประกันภัย ตามระเบียบ CBC ซึ่งเป็นกฏระเบียบของ คปภ. โดยให้ตรงตามวันที่กำหนดด้วย***" "|"
    "|" "|" "|" "|" "|" "|" "|" "|"
    "paid" "|" "|" 
    SKIP.

PUT STREAM ns3
    "** บริษัทฯ ขอส่งหนังสือสรุป และขอสอบถามการชำระค่าเบี้ยประกันภัยถึง CFG เพื่อตรวจสอบการชำระเงินของลูกค้า **" SKIP.
PUT STREAM ns3
    "รอบบิล :" "|"
    "ระหว่างวันที่ 1 - 15 ของเดือน ชำระเงินภายในวันที่ 30 ขอเดือนนั้นๆ" SKIP.
PUT STREAM ns3
    "|"
    "ระหว่างวันที่ 16 - 31 ของเดือน ชำระภายในวันที่ 15 ของเดือนถัดไป"
    "|" "|" "|" "|" "|" "|" "|"
    "Fee of Rebate (ค่าบริการประสานงานรับประกันภัย) 0%" "|"
    "com 0%" SKIP.

PUT STREAM ns3
    "|" "|" "|" "|" "|" "|" "|" "|" "|" "+vat7%" SKIP.
PUT STREAM ns3
    "|" "|" "|" "|" "|" "|" "|" "|" "|" "-tax3%" SKIP.

PUT STREAM ns3
    "ผู้วางบิล/ผู้รับกรมธรรม์" "|" "|"
    "ผู้วางบิล" "|" "|"
    "|" "|" "|" "|" "|"
    "paid"
    SKIP(3).

PUT STREAM ns3
    "ลงวันที่" "|" "|"
    "ลงวันที่" "|" "|"
    "|" "|" "|" "|" "|" 
    "-tax1% (กรณีผู้เอาประกันภัยเป็นนิติบุคคล)"
    SKIP.

PUT STREAM ns3
    "|" "|" "|" "|" "|" "|" "|" "|" "|" "รวมหัก tax1%" SKIP(1).

PUT STREAM ns3
    "|" "|" "|" "|" "|" "|" "|" "|" "|" "ยอดหน้าเช็ค" SKIP.
PUT STREAM ns3
    "|" "|" "|" "|" "|" "|" "|" "|" "|" "(ศูนย์บาทถ้วน)" SKIP.


OUTPUT STREAM ns3 CLOSE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE BKPDProcessEx C-Win 
PROCEDURE BKPDProcessEx :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:  Export Excel File     
------------------------------------------------------------------------------*/
DEFINE BUFFER bufwBill FOR wBill.
DEFINE VAR n_wRecordno     AS INTE FORMAT "999999" INIT 0. 

ASSIGN
    nv_nettotal   = 0
    nv_stamptotal = 0
    nv_vattotal   = 0
    nv_grosstotal = 0
    nv_commtotal  = 0.

OUTPUT STREAM ns1 TO VALUE(fioutput).
/*-- Heading --*/
PUT STREAM ns1
    "Agent Code :" "|"
    "74000414 : บริษัท เงินติดล้อ จำกัด" "|"
    "|" "|" "|" "|"
    "ใบแจ้งหนี้ / ใบวางบิล" 
    SKIP.

PUT STREAM ns1
    "ที่อยู่จัดส่ง :" "|"
    "เลขที่ 89/170 อาคารจุฑามาศ ชั้น 4 ถนนวิภาวดีรังสิต แขวงตลาดบางเขน เขตหลักสี่ กทม. 10210" "|"
    "|" "|" "|" "|"
    "ประกันภัยรถยนต์ โปรกเกอร์เงินติดล้อ" "|"
    SKIP.

PUT STREAM ns1
    "เรียน :" "|"
    "คุณลลินตา สาระศาลิน" "|"
    "เรียน :" "|"
    "คุณชญานุตย์ ศิริวัฒน์ปิติวงษ์" "|"
    "|" "|" "|"
    "งวดระหว่างวันที่"
    SKIP.

PUT STREAM ns1
    "โทรศัพท์ :" "|"
    "02-792-1888 ต่อ 1547" "|"
    "โทรศัพท์ :" "|"
    "02-792-1888 Ext.1564" "|"
    "|" "|"
    "รวมจำนวน" "|"
    "|"
    "กรมธรรม์"
    SKIP.

PUT STREAM ns1
    "โทรสาร :" "|"
    "02-792-1889" "|"
    "โทรสาร :" "|"
    "02-792-1889" 
    SKIP.

PUT STREAM ns1
    "โทร(มือถือ):" "|" "|"
    "โทร(มือถือ):"
    SKIP.

PUT STREAM ns1
    "E-mail :" "|"
    "lalinta.S@cfg.co.th" "|"
    "E-mail :" "|"
    "Chanphen.N@cfg.co.th"
    SKIP.

PUT STREAM ns1
    "วัตถุประสงค์:" "|"
    "เพื่อนำส่งเอกสาร กรมธรรม์ประกันภัยรถยนต์ และ สำเนาใบเสร็จรับเงิน"
    SKIP.

PUT STREAM ns1
    "รายละเอียดค่าเบี้ยประกันภัยลูกค้า บริษัท เงินติดล้อ จำกัด ที่ต้องชำระ ณ.วันที่"
    SKIP.

PUT STREAM ns1
    "ลำดับ" "|"
    "กรมธรรม์เลขที่/สลักหลัง" "|"
    "เลขที่ใบเสร็จรับเงิน" "|"
    "ชื่อผู้เอาประกันภัย" "|"
    "วันคุ้มครอง" "|"
    "วันสิ้นสุด" "|"
    "ทะเบียน" "|"
    "จังหวัด" "|"
    "ประเภท" "|"
    "ทุนประกัน" "|"
    "เบี้ยสุทธิ" "|"
    "อากร 0.4%" "|"
    "ภาษี 7%" "|"
    "เบี้ยรวม" "|"
    "ส่วนลด 18%" "|"
    "หมายเหตุ" SKIP.

FOR EACH wBill NO-LOCK:
    n_wRecordno = n_wRecordno + 1.

    PUT STREAM ns1
        n_wRecordno      "|"
        wBill.wPolicy    "|"
        wBill.wEndcnt    "|"
        wBill.wCha_no    "|"
        wBill.wDocno     "|"
        wBill.wInsure    "|"
        wBill.wComdat    "|"
        wBill.wExpdat    "|"
        wBill.wVehreg    "|"
        wBill.wProvin    "|"
        wBill.wcovcod    "|"
        wBill.wsi        "|"
        wBill.wNetPrem   "|"
        wBill.wStamp     "|"
        wBill.wTax       "|"
        wBill.wGrossPrem "|"
        wBill.wComm      "|"
        wBill.wRemark    SKIP.

    ASSIGN
        nv_grosstotal = nv_grosstotal + wBill.wGrossPrem
        nv_stamptotal = nv_stamptotal + wBill.wStamp
        nv_vattotal   = nv_vattotal   + wBill.wTax  
        nv_nettotal   = nv_nettotal   + wBill.wNetPrem
        nv_commtotal  = nv_commtotal  + wBill.wComm .
END.

PUT STREAM ns1
    "|" "|" "|" "|" "|" "|" "|" "|" "|" "|"
    nv_grosstotal "|"
    nv_stamptotal "|"
    nv_vattotal   "|"
    nv_nettotal   "|"
    nv_commtotal  SKIP.

vExpCount1 = n_wRecordno.

/*-- Footer --*/
PUT STREAM ns1
    SKIP(2)
    "หากมีข้อสงสัยกรุณาติดต่อ" "|"
    "|" "|" "|" "|" "|" "|" "|"
    "Fee of Rebate(ค่านายหน้า) 18%" "|"
    "com 18%"
    SKIP.

PUT STREAM ns1
    "|" "|" "|" "|" "|" "|" "|" "|" "|"
    "+Vat7%"
    SKIP.

PUT STREAM ns1
    "|" "|" "|" "|" "|" "|" "|" "|" "|"
    "-tax3%"
    SKIP.

PUT STREAM ns1
    "** บริษัทฯ ขอให้ท่านช่วยโปรดชำระค่าเบี้ยประกันภัย ตามระเบียบ CBC ซึ่งเป็นกฏระเบียบของ คปภ. โดยให้ตรงตามวันที่กำหนดด้วย***" "|"
    "|" "|" "|" "|" "|" "|" "|" "|"
    "paid" "|" "|" 
    SKIP.

PUT STREAM ns1
    "** บริษัทฯ ขอส่งหนังสือสรุป และขอสอบถามการชำระค่าเบี้ยประกันภัยถึง CFG เพื่อตรวจสอบการชำระเงินของลูกค้า **" SKIP.
PUT STREAM ns1
    "รอบบิล :" "|"
    "ระหว่างวันที่ 1 - 15 ของเดือน ชำระเงินภายในวันที่ 30 ขอเดือนนั้นๆ" SKIP.
PUT STREAM ns1
    "|"
    "ระหว่างวันที่ 16 - 31 ของเดือน ชำระภายในวันที่ 15 ของเดือนถัดไป"
    "|" "|" "|" "|" "|" "|" "|"
    "Fee of Rebate (ค่าบริการประสานงานรับประกันภัย) 5%" "|"
    "com 5%" SKIP.

PUT STREAM ns1
    "|" "|" "|" "|" "|" "|" "|" "|" "|" "+vat7%" SKIP.
PUT STREAM ns1
    "|" "|" "|" "|" "|" "|" "|" "|" "|" "-tax3%" SKIP.

PUT STREAM ns1
    "ผู้วางบิล/ผู้รับกรมธรรม์" "|" "|"
    "ผู้วางบิล" "|" "|"
    "|" "|" "|" "|" "|"
    "paid"
    SKIP(3).

PUT STREAM ns1
    "ลงวันที่" "|" "|"
    "ลงวันที่" "|" "|"
    "|" "|" "|" "|" "|" 
    "-tax1% (กรณีผู้เอาประกันภัยเป็นนิติบุคคล)"
    SKIP.

PUT STREAM ns1
    "|" "|" "|" "|" "|" "|" "|" "|" "|" "รวมหัก tax1%" SKIP(1).

PUT STREAM ns1
    "|" "|" "|" "|" "|" "|" "|" "|" "|" "ยอดหน้าเช็ค" SKIP.
PUT STREAM ns1
    "|" "|" "|" "|" "|" "|" "|" "|" "|" "(ศูนย์บาทถ้วน)" SKIP.


OUTPUT STREAM ns1 CLOSE.

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
  DISPLAY fibranchfr fibranchto fiproducer fi_comdatF fi_comdatT fioutput 
          se_producer cbAsDat ra_type fibdes1 fibdes2 fi_process fioutput1 
          fioutput2 fioutput3 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE fibranchfr fibranchto fiproducer bu_add fi_comdatF fi_comdatT fioutput 
         Btn_OK se_producer bu_del cbAsDat ra_type Btn_Exit buBranch fibdes1 
         buBranch2 fibdes2 fi_process fioutput1 fioutput2 fioutput3 RECT-219 
         RECT-221 RECT-222 RECT-223 RECT-225 RECT-226 RECT-227 
      WITH FRAME fr_main IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDAcproc_fil C-Win 
PROCEDURE PDAcproc_fil :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO WITH FRAME {&FRAME-NAME}:
    vAcProc_fil = "" .
    
    FOR EACH Acproc_fil  WHERE 
            (acproc_fil.type = "01" OR acproc_fil.type = "05" ) AND
      SUBSTR(acProc_fil.enttim,10,3) <>  "NO"
          BY acproc_fil.asdat DESC.
    
        vAcProc_fil = vAcProc_fil + STRING(AcProc_fil.asdat,"99/99/9999") + ",".
    
    END.
    
    ASSIGN
       cbAsDat:LIST-ITEMS = vAcProc_fil
       cbAsDat = ENTRY(1,vAcProc_fil).
    
    DISPLAY cbAsDat.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDCompul C-Win 
PROCEDURE PDCompul :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FIND FIRST uwm301 USE-INDEX uwm30101 WHERE
           uwm301.policy = uwm100.policy AND
           uwm301.rencnt = uwm100.rencnt AND
           uwm301.endcnt = uwm100.endcnt
NO-LOCK NO-ERROR NO-WAIT.
IF NOT AVAILABLE uwm301 THEN NEXT.
    
FIND FIRST uwm130 USE-INDEX uwm13001 WHERE
           uwm130.policy = uwm301.policy AND
           uwm130.rencnt = uwm301.rencnt AND
           uwm130.endcnt = uwm301.endcnt AND
           uwm130.riskgp = uwm301.riskgp AND
           uwm130.riskno = uwm301.riskno AND
           uwm130.itemno = uwm301.itemno
NO-LOCK NO-ERROR NO-WAIT.
IF NOT AVAILABLE uwm130 THEN NEXT.

ASSIGN
   n_pol = ""
   n_ren = 0
   n_end = 0.

IF uwm130.uom8_v <> 0 AND uwm130.uom9_v <> 0 THEN DO:
    nv_pol72 = "".
    nv_pol72 = uwm130.policy + "(" + uwm100.trty11 + uwm100.docno1 + ")".
END.
ELSE DO:
    IF uwm100.cr_2 = "" THEN DO:
        FOR EACH Buwm301 USE-INDEX uwm30102 WHERE
                 Buwm301.vehreg = uwm301.vehreg NO-LOCK:
            IF SUBSTRING(Buwm301.policy,3,2) = "72" THEN DO:
                FIND FIRST Buwm_v72 USE-INDEX uwm10001 WHERE
                           Buwm_v72.policy = Buwm301.policy AND
                           Buwm_v72.rencnt = Buwm301.rencnt AND
                           Buwm_v72.endcnt = Buwm301.endcnt
                NO-LOCK NO-ERROR NO-WAIT.
                IF NOT AVAILABLE Buwm_v72 THEN NEXT.

                IF Buwm_v72.expdat >= uwm100.comdat THEN DO:
                    FIND FIRST vehreg72 WHERE
                               vehreg72.vehreg = Buwm301.vehreg
                    NO-ERROR NO-WAIT.
                    IF NOT AVAILABLE vehreg72 THEN DO:
                        CREATE vehreg72.
                        ASSIGN 
                            vehreg72.polsta  = Buwm_v72.polsta  /* IF ,RE ,CA */
                            vehreg72.vehreg  = Buwm301.vehreg   /* Vehicle Registration No. */
                            vehreg72.comdat  = Buwm_v72.comdat  /* Expiry Date */
                            vehreg72.expdat  = Buwm_v72.expdat  /* Expiry Date */
                            vehreg72.enddat  = Buwm_v72.enddat
                            vehreg72.del_veh = IF Buwm301.itmdel = NO THEN "" ELSE "Y"
                            vehreg72.policy  = Buwm301.policy
                            vehreg72.rencnt  = Buwm301.rencnt
                            vehreg72.endcnt  = Buwm301.endcnt
                            vehreg72.riskno  = Buwm301.riskno
                            vehreg72.itemno  = Buwm301.itemno
                            vehreg72.sticker = Buwm301.sckno.
                    END.
                    ELSE DO:
                        IF vehreg72.expdat <= Buwm_v72.expdat THEN DO:
                            ASSIGN
                                vehreg72.polsta  = Buwm_v72.polsta  /* IF ,RE ,CA */
                                vehreg72.vehreg  = Buwm301.vehreg   /* Vehicle Registration No. */
                                vehreg72.comdat  = Buwm_v72.comdat  /* Expiry Date */
                                vehreg72.expdat  = Buwm_v72.expdat  /* Expiry Date */
                                vehreg72.enddat  = Buwm_v72.enddat
                                vehreg72.del_veh = IF Buwm301.itmdel = NO THEN "" ELSE "Y"
                                vehreg72.policy  = Buwm301.policy
                                vehreg72.rencnt  = Buwm301.rencnt
                                vehreg72.endcnt  = Buwm301.endcnt
                                vehreg72.riskno  = Buwm301.riskno
                                vehreg72.itemno  = Buwm301.itemno.

                            IF Buwm301.sckno <> 0 THEN
                                vehreg72.sticker = Buwm301.sckno.
                        END.
                        ELSE DO:
                            IF vehreg72.expdat > Buwm_v72.expdat AND
                               vehreg72.policy = Buwm_v72.policy AND
                               vehreg72.endcnt < Buwm_v72.endcnt THEN DO:
                                ASSIGN
                                    vehreg72.polsta  = Buwm_v72.polsta  /* IF ,RE ,CA */
                                    vehreg72.vehreg  = Buwm301.vehreg  /* Vehicle Registration No. */
                                    vehreg72.comdat  = Buwm_v72.comdat  /* Expiry Date */
                                    vehreg72.expdat  = Buwm_v72.expdat  /* Expiry Date */
                                    vehreg72.enddat  = Buwm_v72.enddat
                                    vehreg72.del_veh = IF Buwm301.itmdel = NO THEN "" ELSE "Y"
                                    vehreg72.policy  = Buwm301.policy
                                    vehreg72.rencnt  = Buwm301.rencnt
                                    vehreg72.endcnt  = Buwm301.endcnt
                                    vehreg72.riskno  = Buwm301.riskno
                                    vehreg72.itemno  = Buwm301.itemno.

                                IF Buwm301.sckno <> 0 THEN
                                    vehreg72.sticker = Buwm301.sckno.
                            END.
                        END.
                    END.
                END.

                n_pol = vehreg72.policy.
                n_ren = vehreg72.rencnt.
                n_end = vehreg72.endcnt.

            END.
        END.

        FIND FIRST Buwm_v72 USE-INDEX uwm10001 WHERE
                   Buwm_v72.policy = n_pol AND
                   Buwm_v72.rencnt = n_ren AND
                   Buwm_v72.endcnt = n_end
        NO-LOCK NO-ERROR NO-WAIT.
        IF AVAILABLE Buwm_v72 THEN
            nv_pol72 = Buwm_v72.policy.
    END.  /* cr2 = " "*/
    ELSE DO:
        FIND FIRST Buwm_v72 USE-INDEX uwm10001 WHERE
                   Buwm_v72.policy = uwm100.cr_2 
        NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL Buwm_v72 THEN nv_pol72  = Buwm_v72.policy.
        ELSE DO:
            FOR EACH Buwm301 USE-INDEX uwm30102 WHERE
                     Buwm301.vehreg = uwm301.vehreg
            NO-LOCK:
                IF SUBSTRING(Buwm301.policy,3,2) = "72" THEN DO:
                    FIND FIRST Buwm_v72 USE-INDEX uwm10001 WHERE
                               Buwm_v72.policy = Buwm301.policy AND
                               Buwm_v72.rencnt = Buwm301.rencnt AND
                               Buwm_v72.endcnt = Buwm301.endcnt
                    NO-LOCK NO-ERROR NO-WAIT.
                    IF NOT AVAILABLE Buwm_v72 THEN NEXT.

                    IF Buwm_v72.expdat >= uwm100.comdat THEN DO:
                        FIND FIRST vehreg72 WHERE
                                   vehreg72.vehreg = Buwm301.vehreg
                        NO-ERROR NO-WAIT.
                        IF NOT AVAILABLE vehreg72 THEN DO:
                            CREATE vehreg72.
                            ASSIGN
                                vehreg72.polsta  = Buwm_v72.polsta  /* IF ,RE ,CA */
                                vehreg72.vehreg  = Buwm301.vehreg   /* Vehicle Registration No. */
                                vehreg72.comdat  = Buwm_v72.comdat  /* Expiry Date */
                                vehreg72.expdat  = Buwm_v72.expdat  /* Expiry Date */
                                vehreg72.enddat  = Buwm_v72.enddat
                                vehreg72.del_veh = IF Buwm301.itmdel = NO THEN "" ELSE "Y"
                                vehreg72.policy  = Buwm301.policy
                                vehreg72.rencnt  = Buwm301.rencnt
                                vehreg72.endcnt  = Buwm301.endcnt
                                vehreg72.riskno  = Buwm301.riskno
                                vehreg72.itemno  = Buwm301.itemno
                                vehreg72.sticker = Buwm301.sckno.
                        END.
                        ELSE DO:
                            IF vehreg72.expdat <= Buwm_v72.expdat THEN DO:
                                ASSIGN
                                    vehreg72.polsta  = Buwm_v72.polsta  /* IF ,RE ,CA */
                                    vehreg72.vehreg  = Buwm301.vehreg   /* Vehicle Registration No. */
                                    vehreg72.comdat  = Buwm_v72.comdat  /* Expiry Date */
                                    vehreg72.expdat  = Buwm_v72.expdat  /* Expiry Date */
                                    vehreg72.enddat  = Buwm_v72.enddat
                                    vehreg72.del_veh = IF Buwm301.itmdel = NO THEN "" ELSE "Y"
                                    vehreg72.policy  = Buwm301.policy
                                    vehreg72.rencnt  = Buwm301.rencnt
                                    vehreg72.endcnt  = Buwm301.endcnt
                                    vehreg72.riskno  = Buwm301.riskno
                                    vehreg72.itemno  = Buwm301.itemno.

                                IF Buwm301.sckno <> 0 THEN vehreg72.sticker = Buwm301.sckno.
                            END.
                            ELSE DO:
                                IF vehreg72.expdat > Buwm_v72.expdat AND
                                   vehreg72.policy = Buwm_v72.policy AND
                                   vehreg72.endcnt < Buwm_v72.endcnt THEN DO:
                                    ASSIGN
                                        vehreg72.polsta  = Buwm_v72.polsta  /* IF ,RE ,CA */
                                        vehreg72.vehreg  = Buwm301.vehreg  /* Vehicle Registration No. */
                                        vehreg72.comdat  = Buwm_v72.comdat  /* Expiry Date */
                                        vehreg72.expdat  = Buwm_v72.expdat  /* Expiry Date */
                                        vehreg72.enddat  = Buwm_v72.enddat
                                        vehreg72.del_veh = IF Buwm301.itmdel = NO THEN "" ELSE "Y"
                                        vehreg72.policy  = Buwm301.policy
                                        vehreg72.rencnt  = Buwm301.rencnt
                                        vehreg72.endcnt  = Buwm301.endcnt
                                        vehreg72.riskno  = Buwm301.riskno
                                        vehreg72.itemno  = Buwm301.itemno.
               
                                    IF Buwm301.sckno <> 0 THEN
                                        vehreg72.sticker = Buwm301.sckno.
                                END.
                            END.
                        END.
                    END.
                END. /*SUBSTRING(Buwm301.policy,3,2) = "72"*/
            END.

            FIND FIRST Buwm_v72 WHERE
                       Buwm_v72.policy = vehreg72.policy AND
                       Buwm_v72.rencnt = vehreg72.rencnt AND
                       Buwm_v72.endcnt = vehreg72.endcnt
            NO-LOCK NO-ERROR NO-WAIT.
            IF AVAILABLE Buwm_v72 THEN DO:
                nv_pol72  = Buwm_v72.policy.
            END. 
        END.
    END.  /* cr2 <> " " */
END.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDCompul2 C-Win 
PROCEDURE PDCompul2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH vehreg72:
    DELETE vehreg72.
END.

FIND FIRST uwm301 USE-INDEX uwm30101 WHERE
           uwm301.policy = uwm100.policy AND
           uwm301.rencnt = uwm100.rencnt AND
           uwm301.endcnt = uwm100.endcnt NO-LOCK NO-ERROR NO-WAIT.
IF NOT AVAIL uwm301 THEN NEXT.

FIND FIRST uwm130 USE-INDEX uwm13001 WHERE
           uwm130.policy = uwm301.policy AND
           uwm130.rencnt = uwm301.rencnt AND
           uwm130.endcnt = uwm301.endcnt AND
           uwm130.riskgp = uwm301.riskgp AND
           uwm130.riskno = uwm301.riskno AND
           uwm130.itemno = uwm301.itemno NO-LOCK NO-ERROR NO-WAIT.
IF NOT AVAIL uwm130 THEN NEXT.

ASSIGN
    n_pol = ""
    n_ren = 0
    n_end = 0
    n_poltyp = "".

IF uwm100.poltyp = "V70" THEN n_poltyp = "72".
                         ELSE n_poltyp = "70".

IF uwm130.uom8_v <> 0 AND uwm130.uom9_v <> 0 AND uwm100.poltyp = "V70" THEN DO:
    ASSIGN 
        nv_pol72 = ""
        nv_pol72 = uwm130.policy + "(" + uwm100.trty11 + uwm100.docno1 + ")".
END.
ELSE DO:
    IF uwm100.cr_2 = "" THEN DO:
        FOR EACH buwm301 USE-INDEX uwm30102 WHERE
                 buwm301.policy <> uwm301.policy AND
                 buwm301.vehreg  = uwm301.vehreg ,
            FIRST bwagtprm_fil WHERE bwagtprm_fil.vehreg = uwm301.vehreg NO-LOCK:

            IF SUBSTR(buwm301.policy,3,2) = n_poltyp THEN DO:
                FIND FIRST buwm_v72 USE-INDEX uwm10001 WHERE
                           buwm_v72.policy = buwm301.policy AND
                           buwm_v72.rencnt = buwm301.rencnt AND
                           buwm_v72.endcnt = buwm301.endcnt NO-LOCK NO-ERROR NO-WAIT.
                IF NOT AVAIL buwm_v72 THEN NEXT.

                IF buwm_v72.expdat >= uwm100.comdat THEN DO:
                    FIND FIRST vehreg72 WHERE
                               vehreg72.vehreg = buwm301.vehreg NO-ERROR NO-WAIT.
                    IF NOT AVAIL vehreg72 THEN DO:
                        CREATE vehreg72.
                        ASSIGN 
                            vehreg72.polsta  = Buwm_v72.polsta  /* IF ,RE ,CA */
                            vehreg72.vehreg  = Buwm301.vehreg   /* Vehicle Registration No. */
                            vehreg72.comdat  = Buwm_v72.comdat  /* Expiry Date */
                            vehreg72.expdat  = Buwm_v72.expdat  /* Expiry Date */
                            vehreg72.enddat  = Buwm_v72.enddat
                            vehreg72.del_veh = IF Buwm301.itmdel = NO THEN "" ELSE "Y"
                            vehreg72.policy  = Buwm301.policy
                            vehreg72.rencnt  = Buwm301.rencnt
                            vehreg72.endcnt  = Buwm301.endcnt
                            vehreg72.riskno  = Buwm301.riskno
                            vehreg72.itemno  = Buwm301.itemno
                            vehreg72.sticker = Buwm301.sckno
                            n_pol = Buwm301.policy
                            n_ren = Buwm301.rencnt
                            n_end = Buwm301.endcnt. 
                    END.
                    ELSE DO:
                        IF vehreg72.expdat <= Buwm_v72.expdat THEN DO:
                            ASSIGN
                                vehreg72.polsta  = Buwm_v72.polsta  /* IF ,RE ,CA */
                                vehreg72.vehreg  = Buwm301.vehreg   /* Vehicle Registration No. */
                                vehreg72.comdat  = Buwm_v72.comdat  /* Expiry Date */
                                vehreg72.expdat  = Buwm_v72.expdat  /* Expiry Date */
                                vehreg72.enddat  = Buwm_v72.enddat
                                vehreg72.del_veh = IF Buwm301.itmdel = NO THEN "" ELSE "Y"
                                vehreg72.policy  = Buwm301.policy
                                vehreg72.rencnt  = Buwm301.rencnt
                                vehreg72.endcnt  = Buwm301.endcnt
                                vehreg72.riskno  = Buwm301.riskno
                                vehreg72.itemno  = Buwm301.itemno
                                n_pol = Buwm301.policy
                                n_ren = Buwm301.rencnt
                                n_end = Buwm301.endcnt.  
                            IF Buwm301.sckno <> 0 THEN
                                vehreg72.sticker = Buwm301.sckno.
                        END.
                        ELSE DO:
                            IF vehreg72.expdat > Buwm_v72.expdat AND
                               vehreg72.policy = Buwm_v72.policy AND
                               vehreg72.endcnt < Buwm_v72.endcnt THEN DO:
                                ASSIGN
                                    vehreg72.polsta  = Buwm_v72.polsta  /* IF ,RE ,CA */
                                    vehreg72.vehreg  = Buwm301.vehreg  /* Vehicle Registration No. */
                                    vehreg72.comdat  = Buwm_v72.comdat  /* Expiry Date */
                                    vehreg72.expdat  = Buwm_v72.expdat  /* Expiry Date */
                                    vehreg72.enddat  = Buwm_v72.enddat
                                    vehreg72.del_veh = IF Buwm301.itmdel = NO THEN "" ELSE "Y"
                                    vehreg72.policy  = Buwm301.policy
                                    vehreg72.rencnt  = Buwm301.rencnt
                                    vehreg72.endcnt  = Buwm301.endcnt
                                    vehreg72.riskno  = Buwm301.riskno
                                    vehreg72.itemno  = Buwm301.itemno
                                    n_pol = Buwm301.policy
                                    n_ren = Buwm301.rencnt
                                    n_end = Buwm301.endcnt. 
                                IF Buwm301.sckno <> 0 THEN
                                    vehreg72.sticker = Buwm301.sckno.
                            END.
                        END.
                    END.
                END.
            END.
        END.  /*FOR EACH BUWM301*/
        FIND FIRST Buwm_v72 USE-INDEX uwm10001 WHERE
                   Buwm_v72.policy = n_pol AND
                   Buwm_v72.rencnt = n_ren AND
                   Buwm_v72.endcnt = n_end NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL Buwm_v72 THEN DO:
            FIND LAST bwagtprm_fil WHERE 
                      bwagtprm_fil.policy = Buwm_v72.policy AND
               SUBSTR(bwagtprm_fil.policy,7,1) <> "T" NO-LOCK NO-WAIT NO-ERROR .
            IF NOT AVAIL bwagtprm_fil  THEN nv_pol72  = "".
            ELSE nv_pol72  = bwagtprm_fil.policy. 
        END.
    END.  /*uwm100.cr_2 = ""*/
    ELSE DO:
        FIND FIRST Buwm_v72 USE-INDEX uwm10001 WHERE
             Buwm_v72.policy = uwm100.cr_2
        NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL Buwm_v72 THEN DO:
            FIND LAST bwagtprm_fil WHERE 
                bwagtprm_fil.policy = Buwm_v72.policy AND
                substr(bwagtprm_fil.policy,7,1) <> "T" NO-LOCK NO-WAIT NO-ERROR .
            IF NOT AVAIL bwagtprm_fil  THEN nv_pol72  = "".
            ELSE nv_pol72  = bwagtprm_fil.policy. 
        END.
        ELSE DO:
            FOR EACH buwm301 USE-INDEX uwm30102 WHERE
                     buwm301.policy <> uwm301.policy AND
                     buwm301.vehreg  = uwm301.vehreg NO-LOCK:
                IF SUBSTR(buwm301.policy,3,2) = n_poltyp THEN DO:
                    FIND FIRST buwm_v72 USE-INDEX uwm10001 WHERE
                               buwm_v72.policy = buwm301.policy AND
                               buwm_v72.rencnt = buwm301.rencnt AND
                               buwm_v72.endcnt = buwm301.endcnt NO-LOCK NO-ERROR NO-WAIT.
                    IF NOT AVAIL buwm_v72 THEN NEXT.
                    
                    IF buwm_v72.expdat >= uwm100.comdat THEN DO:
                        FIND FIRST vehreg72 WHERE
                                   vehreg72.vehreg = buwm301.vehreg NO-ERROR NO-WAIT.
                        IF NOT AVAIL vehreg72 THEN DO:
                            CREATE vehreg72.
                            ASSIGN
                                vehreg72.polsta  = Buwm_v72.polsta  /* IF ,RE ,CA */
                                vehreg72.vehreg  = Buwm301.vehreg   /* Vehicle Registration No. */
                                vehreg72.comdat  = Buwm_v72.comdat  /* Expiry Date */
                                vehreg72.expdat  = Buwm_v72.expdat  /* Expiry Date */
                                vehreg72.enddat  = Buwm_v72.enddat
                                vehreg72.del_veh = IF Buwm301.itmdel = NO THEN "" ELSE "Y"
                                vehreg72.policy  = Buwm301.policy
                                vehreg72.rencnt  = Buwm301.rencnt
                                vehreg72.endcnt  = Buwm301.endcnt
                                vehreg72.riskno  = Buwm301.riskno
                                vehreg72.itemno  = Buwm301.itemno
                                vehreg72.sticker = Buwm301.sckno.
                        END.
                        ELSE DO:
                            IF vehreg72.expdat <= Buwm_v72.expdat THEN DO:
                                ASSIGN
                                    vehreg72.polsta  = Buwm_v72.polsta  /* IF ,RE ,CA */
                                    vehreg72.vehreg  = Buwm301.vehreg   /* Vehicle Registration No. */
                                    vehreg72.comdat  = Buwm_v72.comdat  /* Expiry Date */
                                    vehreg72.expdat  = Buwm_v72.expdat  /* Expiry Date */
                                    vehreg72.enddat  = Buwm_v72.enddat
                                    vehreg72.del_veh = IF Buwm301.itmdel = NO THEN "" ELSE "Y"
                                    vehreg72.policy  = Buwm301.policy
                                    vehreg72.rencnt  = Buwm301.rencnt
                                    vehreg72.endcnt  = Buwm301.endcnt
                                    vehreg72.riskno  = Buwm301.riskno
                                    vehreg72.itemno  = Buwm301.itemno.  
                                    IF Buwm301.sckno <> 0 THEN
                                        vehreg72.sticker = Buwm301.sckno.
                            END.
                            ELSE DO:
                                IF vehreg72.expdat > Buwm_v72.expdat AND
                                   vehreg72.policy = Buwm_v72.policy AND
                                   vehreg72.endcnt < Buwm_v72.endcnt THEN DO:
                                    ASSIGN
                                        vehreg72.polsta  = Buwm_v72.polsta  /* IF ,RE ,CA */
                                        vehreg72.vehreg  = Buwm301.vehreg  /* Vehicle Registration No. */
                                        vehreg72.comdat  = Buwm_v72.comdat  /* Expiry Date */
                                        vehreg72.expdat  = Buwm_v72.expdat  /* Expiry Date */
                                        vehreg72.enddat  = Buwm_v72.enddat
                                        vehreg72.del_veh = IF Buwm301.itmdel = NO THEN "" ELSE "Y"
                                        vehreg72.policy  = Buwm301.policy
                                        vehreg72.rencnt  = Buwm301.rencnt
                                        vehreg72.endcnt  = Buwm301.endcnt
                                        vehreg72.riskno  = Buwm301.riskno
                                        vehreg72.itemno  = Buwm301.itemno.   
                                    IF Buwm301.sckno <> 0 THEN
                                        vehreg72.sticker = Buwm301.sckno.
                                END.
                            END.
                        END.
                    END.
                    
                END.
            END.  /*FOR EACH BUWM301*/

            FIND FIRST buwm_v72 WHERE buwm_v72.policy = vehreg72.policy AND
                                      buwm_v72.rencnt = vehreg72.rencnt AND
                                      buwm_v72.endcnt = vehreg72.endcnt NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL buwm_v72 THEN DO:
                FIND LAST bwagtprm_fil WHERE 
                          bwagtprm_fil.policy = buwm_v72.policy  AND
                   SUBSTR(bwagtprm_fil.policy,7,1) <> "T"        NO-LOCK NO-WAIT NO-ERROR.
                IF NOT AVAIL bwagtprm_fil THEN nv_pol72  = "".
                                          ELSE nv_pol72  = bwagtprm_fil.policy.  
            END.
        END.
    END.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDNL110 C-Win 
PROCEDURE PDNL110 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE BUFFER bufwBill FOR wBill.
DEFINE VAR n_wRecordno     AS INTE FORMAT "999999" INIT 0. 

ASSIGN
    nv_nettotal   = 0
    nv_stamptotal = 0
    nv_vattotal   = 0
    nv_grosstotal = 0
    nv_commtotal  = 0.

OUTPUT TO VALUE(fioutput1) NO-ECHO APPEND.

EXPORT DELIMITER ","
    "Agent Code :" 
    "74000414 : บริษัท เงินติดล้อ จำกัด" 
    " " 
    " " 
    " " 
    " "
    "ใบแจ้งหนี้ / ใบวางบิล" .

EXPORT DELIMITER ","
    "ที่อยู่จัดส่ง :" 
    "เลขที่ 89/170 อาคารจุฑามาศ ชั้น 4 ถนนวิภาวดีรังสิต แขวงตลาดบางเขน เขตหลักสี่ กทม. 10210" 
    " " 
    " " 
    " " 
    " "
    "ประกันภัยรถยนต์ โปรกเกอร์เงินติดล้อ"
    " " 
    " " 
    " " 
    " " 
    " " 
    " "
    "รถยนต์ ขนาดเล็ก".

EXPORT DELIMITER ","
    "เรียน :" 
    "คุณลลินตา สาระศาลิน" 
    "เรียน :" 
    "คุณชญานุตย์ ศิริวัฒน์ปิติวงษ์" 
    " " 
    " " 
    "งวดระหว่างวันที่"
    n_comdatF 
    "-" 
    n_comdatT
    " " 
    " " 
    " "
    "วันที่"
    STRING(TODAY,"99/99/9999").

EXPORT DELIMITER ","
    "โทรศัพท์ :" 
    "02-792-1888 ต่อ 1547" 
    "โทรศัพท์ :" 
    "02-792-1888 Ext.1564" 
    " " 
    " "
    "รวมจำนวน" 
    Ncount1
    "กรมธรรม์".

EXPORT DELIMITER ","
    "โทรสาร :" 
    "02-792-1889" 
    "โทรสาร :" 
    "02-792-1889". 

EXPORT DELIMITER ","
    "โทร(มือถือ):"
    " "
    "โทร(มือถือ):".

EXPORT DELIMITER ","
    "E-mail :" 
    "lalinta.S@cfg.co.th" 
    "E-mail :" 
    "Chanphen.N@cfg.co.th".

EXPORT DELIMITER ","
    "วัตถุประสงค์:" 
    "เพื่อนำส่งเอกสาร กรมธรรม์ประกันภัยรถยนต์ และ สำเนาใบเสร็จรับเงิน".

EXPORT DELIMITER ","
    "รายละเอียดค่าเบี้ยประกันภัยลูกค้า บริษัท เงินติดล้อ จำกัด ที่ต้องชำระ ณ.วันที่".

EXPORT DELIMITER ","
    "ลำดับ" 
    "กรมธรรม์เลขที่"
    "สลักหลังเลขที่"
    "สลักหลังครั้งที่"
    "เลขตัวถัง"
    "เลขที่ใบเสร็จรับเงิน" 
    "ชื่อผู้เอาประกันภัย" 
    "วันคุ้มครอง" 
    "วันสิ้นสุด" 
    "ทะเบียน" 
    "จังหวัด"
    "ประเภท" 
    "ทุนประกัน" 
    "เบี้ยสุทธิ" 
    "อากร 0.4%" 
    "ภาษี 7%" 
    "เบี้ยรวม" 
    "ส่วนลด 18%" 
    "หมายเหตุ".

FOR EACH wBill WHERE wBill.wClass = "110" NO-LOCK:
    n_wRecordno = n_wRecordno + 1.

    EXPORT DELIMITER ","
        n_wRecordno      
        wBill.wPolicy  
        wBill.wEndno 
        STRING(wBill.wEndcnt,"999")
        wBill.wCha_no
        wBill.wDocno     
        wBill.wInsure    
        wBill.wComdat    
        wBill.wExpdat    
        wBill.wVehreg    
        wBill.wProvin    
        wBill.wcovcod    
        wBill.wsi 
        wBill.wNetPrem 
        wBill.wStamp     
        wBill.wTax       
        wBill.wGrossPrem   
        wBill.wComm      
        wBill.wRemark .

    ASSIGN
        nv_grosstotal = nv_grosstotal + wBill.wGrossPrem
        nv_stamptotal = nv_stamptotal + wBill.wStamp
        nv_vattotal   = nv_vattotal   + wBill.wTax  
        nv_nettotal   = nv_nettotal   + wBill.wNetPrem
        nv_commtotal  = nv_commtotal  + wBill.wComm .
END.

EXPORT DELIMITER ","
    " " 
    " "
    " " 
    " "
    " " 
    " " 
    " " 
    " " 
    " " 
    " " 
    " " 
    " "
    " "
    nv_nettotal
    nv_stamptotal 
    nv_vattotal 
    nv_grosstotal    
    nv_commtotal. 

EXPORT DELIMITER ","
    " ". 

EXPORT DELIMITER ","
    " ". 

vExpCount1 = n_wRecordno.

RUN PDPrintFooter.

OUTPUT CLOSE.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDNL210 C-Win 
PROCEDURE PDNL210 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE BUFFER bufwBill FOR wBill.
DEFINE VAR n_wRecordno     AS INTE FORMAT "999999" INIT 0. 

ASSIGN
    nv_nettotal   = 0
    nv_stamptotal = 0
    nv_vattotal   = 0
    nv_grosstotal = 0
    nv_commtotal  = 0.

OUTPUT TO VALUE(fioutput2) NO-ECHO APPEND.

EXPORT DELIMITER ","
    "Agent Code :" 
    "74000414 : บริษัท เงินติดล้อ จำกัด" 
    " " 
    " " 
    " " 
    " "
    "ใบแจ้งหนี้ / ใบวางบิล" 
    "" "" "" "" "" ""
    "วันที่"
    STRING(TODAY,"99/99/9999").

EXPORT DELIMITER ","
    "ที่อยู่จัดส่ง :" 
    "เลขที่ 89/170 อาคารจุฑามาศ ชั้น 4 ถนนวิภาวดีรังสิต แขวงตลาดบางเขน เขตหลักสี่ กทม. 10210" 
    " " 
    " " 
    " " 
    " "
    "ประกันภัยรถยนต์ โปรกเกอร์เงินติดล้อ".

EXPORT DELIMITER ","
    "เรียน :" 
    "คุณลลินตา สาระศาลิน" 
    "เรียน :" 
    "คุณชญานุตย์ ศิริวัฒน์ปิติวงษ์" 
    " " 
    " " 
    "งวดระหว่างวันที่"
    n_comdatF 
    "-" 
    n_comdatT.

EXPORT DELIMITER ","
    "โทรศัพท์ :" 
    "02-792-1888 ต่อ 1547" 
    "โทรศัพท์ :" 
    "02-792-1888 Ext.1564" 
    " " 
    " "
    "รวมจำนวน" 
    NCount2
    "กรมธรรม์".

EXPORT DELIMITER ","
    "โทรสาร :" 
    "02-792-1889" 
    "โทรสาร :" 
    "02-792-1889". 

EXPORT DELIMITER ","
    "โทร(มือถือ):"
    " "
    "โทร(มือถือ):".

EXPORT DELIMITER ","
    "E-mail :" 
    "lalinta.S@cfg.co.th" 
    "E-mail :" 
    "Chanphen.N@cfg.co.th".

EXPORT DELIMITER ","
    "วัตถุประสงค์:" 
    "เพื่อนำส่งเอกสาร กรมธรรม์ประกันภัยรถยนต์ และ สำเนาใบเสร็จรับเงิน".

EXPORT DELIMITER ","
    "รายละเอียดค่าเบี้ยประกันภัยลูกค้า บริษัท เงินติดล้อ จำกัด ที่ต้องชำระ ณ.วันที่".

EXPORT DELIMITER ","
    "ลำดับ" 
    "กรมธรรม์เลขที่"
    "สลักหลังเลขที่"
    "สลักหลังครั้งที่"
    "เลขตัวถัง"
    "เลขที่ใบเสร็จรับเงิน" 
    "ชื่อผู้เอาประกันภัย" 
    "วันคุ้มครอง" 
    "วันสิ้นสุด" 
    "ทะเบียน" 
    "จังหวัด"
    "ประเภท" 
    "ทุนประกัน" 
    "เบี้ยสุทธิ" 
    "อากร 0.4%" 
    "ภาษี 7%" 
    "เบี้ยรวม" 
    "ส่วนลด 18%" 
    "หมายเหตุ".

FOR EACH wBill WHERE wBill.wClass = "210" NO-LOCK:
    n_wRecordno = n_wRecordno + 1.

    EXPORT DELIMITER ","
        n_wRecordno      
        wBill.wPolicy  
        wBill.wEndno 
        STRING(wBill.wEndcnt,"999")
        wBill.wCha_no
        wBill.wDocno     
        wBill.wInsure    
        wBill.wComdat    
        wBill.wExpdat    
        wBill.wVehreg    
        wBill.wProvin    
        wBill.wcovcod    
        wBill.wsi 
        wBill.wNetPrem 
        wBill.wStamp     
        wBill.wTax       
        wBill.wGrossPrem   
        wBill.wComm      
        wBill.wRemark .

    ASSIGN
        nv_grosstotal = nv_grosstotal + wBill.wGrossPrem
        nv_stamptotal = nv_stamptotal + wBill.wStamp
        nv_vattotal   = nv_vattotal   + wBill.wTax  
        nv_nettotal   = nv_nettotal   + wBill.wNetPrem
        nv_commtotal  = nv_commtotal  + wBill.wComm .
END.

EXPORT DELIMITER ","
    " " 
    " "
    " " 
    " "
    " " 
    " " 
    " " 
    " " 
    " " 
    " " 
    " " 
    " "
    " "
    nv_nettotal 
    nv_stamptotal 
    nv_vattotal 
    nv_grosstotal   
    nv_commtotal. 

EXPORT DELIMITER ","
    " ". 

EXPORT DELIMITER ","
    " ". 

vExpCount2 = n_wRecordno.

RUN PDPrintFooter.

OUTPUT CLOSE.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDNL320 C-Win 
PROCEDURE PDNL320 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE BUFFER bufwBill FOR wBill.
DEFINE VAR n_wRecordno     AS INTE FORMAT "999999" INIT 0. 

ASSIGN
    nv_nettotal   = 0
    nv_stamptotal = 0
    nv_vattotal   = 0
    nv_grosstotal = 0
    nv_commtotal  = 0.

OUTPUT TO VALUE(fioutput3) NO-ECHO APPEND.

EXPORT DELIMITER ","
    "" "" "" "" "" "" "" 
    "" "" "" "" "" ""
    "ส่งกรมธรรม์พร้อมวางบิล".

EXPORT DELIMITER ","
    "" "" "" "" "" "" "" 
    "" "" "" "" "" ""
    "รถยนต์ ขนาดใหญ่".

EXPORT DELIMITER ","
    "Agent Code :" 
    "74000414 : บริษัท เงินติดล้อ จำกัด" 
    " " 
    " " 
    " " 
    " "
    "ใบแจ้งหนี้ / ใบวางบิล" .

EXPORT DELIMITER ","
    "ที่อยู่จัดส่ง :" 
    "เลขที่ 89/170 อาคารจุฑามาศ ชั้น 4 ถนนวิภาวดีรังสิต แขวงตลาดบางเขน เขตหลักสี่ กทม. 10210" 
    " " 
    " " 
    " " 
    " "
    "ประกันภัยรถยนต์ โปรกเกอร์เงินติดล้อ".

EXPORT DELIMITER ","
    "เรียน :" 
    "คุณลลินตา สาระศาลิน" 
    "เรียน :" 
    "คุณชญานุตย์ ศิริวัฒน์ปิติวงษ์" 
    " " 
    " " 
    "งวดระหว่างวันที่"
    n_comdatF 
    "-" 
    n_comdatT.

EXPORT DELIMITER ","
    "โทรศัพท์ :" 
    "02-792-1888 ต่อ 1547" 
    "โทรศัพท์ :" 
    "02-792-1888 Ext.1564" 
    " " 
    " "
    "รวมจำนวน" 
    NCount3
    "กรมธรรม์".

EXPORT DELIMITER ","
    "โทรสาร :" 
    "02-792-1889" 
    "โทรสาร :" 
    "02-792-1889". 

EXPORT DELIMITER ","
    "โทร(มือถือ):"
    " "
    "โทร(มือถือ):".

EXPORT DELIMITER ","
    "E-mail :" 
    "lalinta.S@cfg.co.th" 
    "E-mail :" 
    "Chanphen.N@cfg.co.th".

EXPORT DELIMITER ","
    "วัตถุประสงค์:" 
    "เพื่อนำส่งเอกสาร กรมธรรม์ประกันภัยรถยนต์ และ สำเนาใบเสร็จรับเงิน".

EXPORT DELIMITER ","
    "รายละเอียดค่าเบี้ยประกันภัยลูกค้า บริษัท เงินติดล้อ จำกัด ที่ต้องชำระ ณ.วันที่".

EXPORT DELIMITER ","
    "ลำดับ" 
    "กรมธรรม์เลขที่"
    "สลักหลังเลขที่"
    "สลักหลังครั้งที่"
    "เลขตัวถัง"
    "เลขที่ใบเสร็จรับเงิน" 
    "ชื่อผู้เอาประกันภัย" 
    "วันคุ้มครอง" 
    "วันสิ้นสุด" 
    "ทะเบียน" 
    "จังหวัด"
    "ประเภท" 
    "ทุนประกัน" 
    "เบี้ยสุทธิ" 
    "อากร 0.4%" 
    "ภาษี 7%" 
    "เบี้ยรวม" 
    /*"ส่วนลด 18%" */
    "หมายเหตุ".

FOR EACH wBill WHERE wBill.wClass = "320" NO-LOCK:
    n_wRecordno = n_wRecordno + 1.

    EXPORT DELIMITER ","
        n_wRecordno      
        wBill.wPolicy  
        wBill.wEndno 
        STRING(wBill.wEndcnt,"999")
        wBill.wCha_no
        wBill.wDocno     
        wBill.wInsure    
        wBill.wComdat    
        wBill.wExpdat    
        wBill.wVehreg    
        wBill.wProvin    
        wBill.wcovcod    
        wBill.wsi 
        wBill.wNetPrem 
        wBill.wStamp     
        wBill.wTax       
        wBill.wGrossPrem   
        /*wBill.wComm */     
        wBill.wRemark .

    ASSIGN
        nv_grosstotal = nv_grosstotal + wBill.wGrossPrem
        nv_stamptotal = nv_stamptotal + wBill.wStamp
        nv_vattotal   = nv_vattotal   + wBill.wTax  
        nv_nettotal   = nv_nettotal   + wBill.wNetPrem
        nv_commtotal  = nv_commtotal  + wBill.wComm .
END.

EXPORT DELIMITER ","
    " " 
    " " 
    " "
    " " 
    " " 
    " " 
    " " 
    " " 
    " " 
    " " 
    " " 
    " "
    " "
    nv_nettotal
    nv_stamptotal 
    nv_vattotal
    nv_grosstotal. 

EXPORT DELIMITER ","
    " ". 

EXPORT DELIMITER ","
    " ". 

vExpCount3 = n_wRecordno.

RUN PDPrintFooter.

OUTPUT CLOSE.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDPrintFooter C-Win 
PROCEDURE PDPrintFooter :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*-- Footer --*/
EXPORT DELIMITER ","
    "หากมีข้อสงสัยกรุณาติดต่อ" 
    " " 
    " " 
    " " 
    " " 
    " " 
    " " 
    " "
    "Fee of Rebate(ค่านายหน้า) 18%" 
    "com 18%".

EXPORT DELIMITER ","
    " "  
    " " 
    " " 
    " " 
    " " 
    " " 
    " " 
    " " 
    " "
    "[+] Vat7%".

EXPORT DELIMITER ","
    " " 
    " " 
    " " 
    " " 
    " " 
    " " 
    " " 
    " " 
    " "
    "[-] tax3%".

EXPORT DELIMITER ","
    "** บริษัทฯ ขอให้ท่านช่วยโปรดชำระค่าเบี้ยประกันภัย ตามระเบียบ CBC ซึ่งเป็นกฏระเบียบของ คปภ. โดยให้ตรงตามวันที่กำหนดด้วย***" 
    " " 
    " " 
    " " 
    " " 
    " " 
    " " 
    " " 
    " "
    "paid". 

EXPORT DELIMITER ","
    "** บริษัทฯ ขอส่งหนังสือสรุป และขอสอบถามการชำระค่าเบี้ยประกันภัยถึง CFG เพื่อตรวจสอบการชำระเงินของลูกค้า **".

EXPORT DELIMITER ","
    "รอบบิล :" 
    "ระหว่างวันที่ 1 - 15 ของเดือน ชำระเงินภายในวันที่ 30 ขอเดือนนั้นๆ".

EXPORT DELIMITER ","
    " "
    "ระหว่างวันที่ 16 - 31 ของเดือน ชำระภายในวันที่ 15 ของเดือนถัดไป"
    " " 
    " " 
    " "
    " " 
    " " 
    " " 
    "Fee of Rebate (ค่าบริการประสานงานรับประกันภัย) 5%" 
    "com 5%".

EXPORT DELIMITER ","
    " " 
    " " 
    " " 
    " " 
    " " 
    " " 
    " " 
    " " 
    " " 
    "[+] vat7%".

EXPORT DELIMITER ","
    "" "" "" "" "" "" "" "" "" "[-] tax3%".

EXPORT DELIMITER ","
    "ผู้วางบิล/ผู้รับกรมธรรม์" "" 
    "ผู้วางบิล" "" ""
    "" "" "" "" 
    "paid".

EXPORT DELIMITER ","
    " ". 

EXPORT DELIMITER ","
    " ". 

EXPORT DELIMITER ","
    "ลงวันที่"  ""
    "ลงวันที่"  ""
    "" "" "" "" "" 
    "[-] tax1% (กรณีผู้เอาประกันภัยเป็นนิติบุคคล)".

EXPORT DELIMITER ","
    "" "" "" "" "" "" "" "" "" "รวมหัก tax1%".

EXPORT DELIMITER ","
    " ". 

EXPORT DELIMITER ","
    "" "" "" "" "" "" "" "" "" "ยอดหน้าเช็ค".

EXPORT DELIMITER ","
    "" "" "" "" "" "" "" "" "" "(ศูนย์บาทถ้วน)".


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDProcess1 C-Win 
PROCEDURE PDProcess1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FIND LAST acProc_fil USE-INDEX BY_type_asdat WHERE
          acProc_fil.TYPE  = "02"    AND
          acProc_fil.asdat = n_asdat NO-ERROR.
IF NOT AVAIL acProc_fil THEN DO:
    CREATE acProc_fil.
    ASSIGN
        acProc_fil.type     = "02"
        acProc_fil.typdesc  = "PROCESS STATEMENT BILLING(NLT)"
        acProc_fil.asdat    = n_asdat       /* วันที่ process statement *//* nv_exportdat  */
        acProc_fil.trndatfr = n_comdatF     /*depend on condition on interface*/
        acProc_fil.trndatto = n_comdatT
        acProc_fil.entdat   = TODAY         /* = nv_exportdat    */
        acProc_fil.enttim   = STRING(TIME, "HH:MM:SS")
        acProc_fil.usrid    = n_user .
END.

FOR EACH wBill: 
    DELETE  wBill. 
END.

ASSIGN
    nv_exportdat = TODAY
    nv_exporttim = STRING(TIME,"HH:MM:SS")
    nv_exportusr = nv_user
    vCountRec    = 0.

    loop_main:
    FOR EACH agtprm_fil USE-INDEX by_acno WHERE
             agtprm_fil.asdat   = n_asdat       AND 
      LOOKUP(agtprm_fil.acno,vProdCod) <> 0     AND
            (agtprm_fil.poltyp  = "V70"         OR  
             agtprm_fil.poltyp  = "V72")        AND 
            (agtprm_fil.TYPE    = "01"          OR  
             agtprm_fil.TYPE    = "05")         AND 
             agtprm_fil.trntyp  BEGINS 'M'      AND
            (agtprm_fil.polbran >= n_branch     AND
             agtprm_fil.polbran <= n_branch2 )  AND
            (agtprm_fil.comdat  >= n_comdatF    AND
             agtprm_fil.comdat  <= n_comdatT)   AND
             agtprm_fil.bal     >  0            NO-LOCK:

        IF agtprm_fil.prem + agtprm_fil.prem_comp = 0 THEN NEXT loop_main.

        FIND LAST acm001 USE-INDEX acm00104 WHERE
                  acm001.policy = agtprm_fil.policy NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL acm001 THEN 
            IF acm001.trnty1 = "R" AND acm001.trnty2 = "C" THEN NEXT loop_main.

        FIND FIRST uwm100 WHERE
                   uwm100.policy = agtprm_fil.policy AND
                   uwm100.endno  = agtprm_fil.endno  AND
                   uwm100.docno1 = agtprm_fil.docno  NO-LOCK NO-ERROR.
        IF AVAIL uwm100 THEN DO:
            FIND FIRST uwm120 USE-INDEX uwm12001 WHERE
                       uwm120.policy = uwm100.policy AND
                       uwm120.rencnt = uwm100.rencnt AND
                       uwm120.endcnt = uwm100.endcnt NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL uwm120 THEN DO:
                /*IF SUBSTR(uwm120.CLASS,2,3) <> "110" THEN NEXT loop_main.*/ 
                nv_class = uwm120.CLASS.
            END.
        END.
         
        ASSIGN
           nv_pol72      = ""     nv_norpol   = ""
           nv_insure     = ""     nv_vehreg   = ""
           nv_engine     = ""     nv_cha_no   = ""
           nv_job_nr     = ""     nv_covcod   = ""
           nv_grossPrem  = 0      nv_grossPrem_comp = 0
           nv_netPrem    = 0      nv_netPrem_comp   = 0
           nv_tax        = 0      nv_netPayment     = 0
           vStamp        = 0      vStamp_comp       = 0
           vVat          = 0      vVat_comp         = 0 
           nv_net_com    = 0      n_provin    = ""
           nv_endcnt     = 0.

        DISPLAY  "Process : " + agtprm_fil.policy + '   ' + agtprm_fil.trnty
                       + '  ' + agtprm_fil.docno + " " +  agtprm_fil.vehreg  @ fi_Process WITH FRAME {&FRAME-NAME}.

        ASSIGN
            nv_norpol   = agtprm_fil.policy + '(' + SUBSTR(agtprm_fil.trntyp,1,1)
                                                 + agtprm_fil.docno + ')'
            nv_vehreg   = agtprm_fil.vehreg
            nv_netPrem  = agtprm_fil.prem
            nv_netPrem_comp = agtprm_fil.prem_comp.

        /*--*/
        IF nv_vehreg <> "" THEN DO:

            n_vehreg1 = TRIM(nv_vehreg).

            n_vehreg2 = TRIM(SUBSTR(n_vehreg1,1,INDEX(n_vehreg1," "))).
            n_vehreg1 = TRIM(SUBSTR(n_vehreg1,LENGTH(n_vehreg2) + 1,LENGTH(n_vehreg1))).

           /* n_vehreg2 = "".
            n_vehreg2 = TRIM(SUBSTR(n_vehreg1,INDEX(n_vehreg1," ") + 1,3)).*/

            n_provin  = TRIM(SUBSTR(n_vehreg1,INDEX(n_vehreg1," ") + 1,3)).
            nv_vehreg = n_vehreg2 + " " + TRIM(SUBSTR(n_vehreg1,1,INDEX(n_vehreg1," "))).

            /*--
            n_vehreg1 = TRIM(nv_vehreg).

            n_vehreg2 = TRIM(SUBSTR(n_vehreg1,1,INDEX(n_vehreg1," "))).
            n_vehreg1 = TRIM(SUBSTR(n_vehreg1,LENGTH(n_vehreg2) + 1,LENGTH(n_vehreg1))).

            FIND FIRST stat.insure WHERE stat.insure.compno = "999"     AND
                                         INDEX(n_vehreg1,stat.insure.lname) <> 0 NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL stat.insure THEN DO:
                n_provin = insure.fname.
            END.
            --*/
        END.
        /*--*/

        FIND FIRST uwm100 USE-INDEX uwm10001 WHERE
                   uwm100.policy = agtprm_fil.policy AND
                   uwm100.endno  = agtprm_fil.endno  AND
                   uwm100.docno1 = agtprm_fil.docno  NO-LOCK NO-ERROR.
        IF AVAIL uwm100 THEN DO:
            ASSIGN
                nv_comdat = uwm100.comdat
                nv_expdat = uwm100.expdat
                nv_endcnt = uwm100.endcnt.

            nv_insure = (uwm100.ntitle) + " " + (uwm100.name1).
            IF nv_insure = "" THEN nv_insure = agtprm_fil.insure.

            /*--
            IF SUBSTR(agtprm_fil.policy,3,2) = "70" THEN DO:
                nv_pol72 = "".
                RUN PDCompul.
            END.
            --*/

            FIND FIRST uwm120 USE-INDEX uwm12001 WHERE
                       uwm120.policy = uwm100.policy AND
                       uwm120.rencnt = uwm100.rencnt AND
                       uwm120.endcnt = uwm100.endcnt NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL uwm120 THEN DO:
                nv_nor_si = uwm120.sigr + uwm120.sico.
            END.

            FIND FIRST uwm301 USE-INDEX uwm30101 WHERE
                       uwm301.policy = uwm100.policy AND
                       uwm301.rencnt = uwm100.rencnt AND
                       uwm301.endcnt = uwm100.endcnt NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL uwm301 THEN DO:
                ASSIGN
                    nv_covcod = uwm301.covcod
                    nv_cha_no = uwm301.cha_no.
            END.
        END.

        /*-- Calculate premium --*/

        IF SUBSTR(agtprm_fil.policy,3,1) = "7" AND nv_pol72 <> "" THEN DO:
            /*-- calculate 0.4/100 = 0.004 , 7/100 = 0.07 --*/
            ASSIGN
                vStamp_comp  = IF (nv_netPrem_comp * 0.004 ) -
                                    TRUNCATE( (nv_netPrem_comp * 0.004 ),0) > 0
                               THEN TRUNCATE( (nv_netPrem_comp * 0.004 ),0) + 1 /* มีทศนิยม  ปัดเศษ + 1 */
                               ELSE TRUNCATE( (nv_netPrem_comp * 0.004 ),0)    /* ไม่มีทศนิยม */
                vVat_comp         = (nv_netPrem_comp + vStamp_comp) * 0.07
                nv_grossPrem_comp = nv_netprem_comp  + vStamp_comp + vVat_comp
                vStamp            = agtprm_fil.stamp - vStamp_comp
                vVat              = agtprm_fil.tax   - vVat_comp
                nv_grossPrem      = nv_netprem + vStamp + vVat
                nv_net_com        = nv_netprem * (18 / 100).
   
        END.
        ELSE DO:
            ASSIGN
                vStamp_comp  = IF (nv_netPrem_comp * 0.004 ) -
                                    TRUNCATE( (nv_netPrem_comp * 0.004 ),0) > 0
                               THEN TRUNCATE( (nv_netPrem_comp * 0.004 ),0) + 1 /* มีทศนิยม  ปัดเศษ + 1 */
                               ELSE TRUNCATE( (nv_netPrem_comp * 0.004 ),0)    /* ไม่มีทศนิยม */
                vVat_comp         = (nv_netPrem_comp + vStamp_comp) * 0.07
                nv_grossPrem_comp = nv_netprem_comp  + vStamp_comp + vVat_comp
                vStamp            = agtprm_fil.stamp - vStamp_comp
                vVat              = agtprm_fil.tax   - vVat_comp
                nv_grossPrem      = nv_netprem + vStamp + vVat
                nv_net_com        = nv_netprem * (18 / 100).
        END.

        IF (SUBSTR(nv_vehreg,1,1) <> "/") THEN DO:
            nv_vehreg = nv_vehreg.
        END.
        ELSE DO:
            IF nv_engine <> "" THEN nv_vehreg = nv_engine.
            ELSE nv_vehreg = SUBSTR(nv_vehreg, 1 ,LENGTH(nv_vehreg)).
        END.

        FIND FIRST wBill USE-INDEX wBill01 WHERE
                   wBill.wPolicy = agtprm_fil.policy  AND
                   wBill.wEndno  = agtprm_fil.endno   AND
                   wBill.wdocno  = agtprm_fil.docno   NO-ERROR NO-WAIT.
        IF NOT AVAIL wBill THEN DO:
            vCountRec = vCountRec + 1.
            DISPLAY "Create data to Table wBill ..."  @ fi_Process  WITH FRAME {&FRAME-NAME}.

            CREATE wBill.
            ASSIGN
                wBill.wRecid     = vCountRec
                wBill.wPolicy    = agtprm_fil.policy 
                wBill.wCha_no    = nv_cha_no
                wBill.wEndcnt    = nv_endcnt
                wBill.wEndno     = agtprm_fil.endno  
                wBill.wDocno     = agtprm_fil.docno  
                wBill.wInsure    = nv_insure
                wBill.wComdat    = nv_comdat
                wBill.wExpdat    = nv_expdat
                wBill.wVehreg    = nv_vehreg
                wBill.wProvin    = n_provin
                wBill.wcovcod    = nv_covcod
                wBill.wsi        = nv_nor_si
                wBill.wGrossPrem = nv_grossPrem 
                wBill.wStamp     = vStamp 
                wBill.wTax       = vVat
                wBill.wNetPrem   = nv_netprem
                wBill.wComm      = nv_net_com 
                wBill.wRemark    = ""
                wBill.wClass     = SUBSTR(nv_class,2,3).

            IF wBill.wClass = "110" THEN NCount1 = NCount1 + 1.
            IF wBill.wClass = "210" THEN NCount2 = NCount2 + 1.
            IF wBill.wClass = "320" THEN NCount3 = NCount3 + 1.

        END.
 
    END.

IF vCountRec = 0 THEN DO:
    MESSAGE "ไม่พบข้อมูล ที่จะส่งออก" VIEW-AS ALERT-BOX INFORMATION.
    RETURN NO-APPLY.
END.

RELEASE acProc_fil.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDProcess2 C-Win 
PROCEDURE PDProcess2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FIND LAST acProc_fil USE-INDEX by_type_asdat WHERE
          acProc_fil.type  = "02"      AND
          acProc_fil.asdat = n_asdat   NO-ERROR.   
IF NOT AVAIL acProc_fil THEN DO:
    CREATE acProc_fil.
    ASSIGN acProc_fil.type  = "02"
        acProc_fil.typdesc  = "PROCESS STATEMENT BILLING(NLT)"
        acProc_fil.asdat    = n_asdat       
        acProc_fil.trndatfr = n_comdatF     
        acProc_fil.trndatto = n_comdatT
        acProc_fil.entdat   = TODAY         
        acProc_fil.enttim   = STRING(TIME, "HH:MM:SS")
        acProc_fil.usrid    = n_user .
END.

FOR EACH wBill :
    DELETE wBill.
END.

ASSIGN
    nv_exportdat = TODAY
    nv_exporttim = STRING(TIME,"HH:MM:SS")
    nv_exportusr = nv_user
    vCountRec    = 0.

loop_main:
FOR EACH agtprm_fil USE-INDEX by_acno WHERE
         agtprm_fil.asdat         = n_asdat     AND
  LOOKUP(agtprm_fil.acno,vProdCod) <> 0         AND
        (agtprm_fil.poltyp       = "V70"        OR  
         agtprm_fil.poltyp       = "V72")       AND
        (agtprm_fil.TYPE         = "01"         OR 
         agtprm_fil.TYPE         = "05")        AND
         agtprm_fil.trntyp     BEGINS "M"       AND
        (agtprm_fil.polbran      >= n_branch    AND
         agtprm_fil.polbran      <= n_branch2 ) AND
         agtprm_fil.trndat       >= n_comdatF   AND  
         agtprm_fil.trndat       <= n_comdatT   AND  
         agtprm_fil.bal          >  0           NO-LOCK:

    IF agtprm_fil.prem + agtprm_fil.prem_comp = 0 THEN NEXT loop_main.

    FIND LAST acm001 USE-INDEX acm00104 WHERE
              acm001.policy = agtprm_fil.policy NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL acm001 THEN
        IF acm001.trnty1 = "R" AND acm001.trnty2 = "C" THEN NEXT loop_main.

    FIND LAST wagtprm_fil USE-INDEX wagtprm_fil01 WHERE
              wagtprm_fil.acno   = agtprm_fil.acno    AND
              wagtprm_fil.policy = agtprm_fil.policy  AND
              wagtprm_fil.docno  = agtprm_fil.docno   AND
              wagtprm_fil.vehreg = agtprm_fil.vehreg  AND
              wagtprm_fil.endno  = agtprm_fil.endno   NO-ERROR NO-WAIT.
    IF NOT AVAIL wagtprm_fil THEN CREATE wagtprm_fil.

    ASSIGN
        wagtprm_fil.policy    = agtprm_fil.policy
        wagtprm_fil.trntyp    = agtprm_fil.trntyp
        wagtprm_fil.docno     = agtprm_fil.docno 
        wagtprm_fil.vehreg    = agtprm_fil.vehreg
        wagtprm_fil.prem      = agtprm_fil.prem
        wagtprm_fil.prem_comp = agtprm_fil.prem_comp  
        wagtprm_fil.endno     = agtprm_fil.endno 
        wagtprm_fil.bal       = agtprm_fil.bal
        wagtprm_fil.insure    = agtprm_fil.insure
        wagtprm_fil.stamp     = agtprm_fil.stamp
        wagtprm_fil.tax       = agtprm_fil.tax  
        wagtprm_fil.acno      = agtprm_fil.acno              
        wagtprm_fil.trnty     = agtprm_fil.trnty  
        wagtprm_fil.comdat    = agtprm_fil.comdat
        wagtprm_fil.asdat     = agtprm_fil.asdat
        wagtprm_fil.trndat    = agtprm_fil.trndat
        wagtprm_fil.poltyp    = agtprm_fil.poltyp .

END.

loop_main2:
FOR EACH wagtprm_fil NO-LOCK:
    ASSIGN
        nv_pol72      = ""     nv_norpol   = ""
        nv_insure     = ""     nv_vehreg   = ""
        nv_engine     = ""     nv_cha_no   = ""
        nv_job_nr     = ""     nv_covcod   = ""
        nv_grossPrem  = 0      nv_grossPrem_comp = 0
        nv_netPrem    = 0      nv_netPrem_comp   = 0
        nv_tax        = 0      nv_netPayment     = 0
        vStamp        = 0      vStamp_comp       = 0
        vVat          = 0      vVat_comp         = 0 
        nv_net_com    = 0      nv_endcnt         = 0
        n_provin      = "".

    DISPLAY  "Process : " + wagtprm_fil.policy + "  " + wagtprm_fil.trnty
             + "  " + wagtprm_fil.docno  @ fi_Process WITH FRAME {&FRAME-NAME}.

    ASSIGN
        nv_norpol   = wagtprm_fil.policy + '(' + SUBSTR(wagtprm_fil.trntyp,1,1)
                      + wagtprm_fil.docno + ')'
        nv_vehreg   = wagtprm_fil.vehreg
        nv_netPrem  = wagtprm_fil.prem
        nv_netPrem_comp = wagtprm_fil.prem_comp .

    /*--
    IF nv_vehreg <> "" THEN DO:
        n_vehreg1 = TRIM(nv_vehreg).

        n_vehreg2 = TRIM(SUBSTR(n_vehreg1,1,INDEX(n_vehreg1," "))).
        n_vehreg1 = TRIM(SUBSTR(n_vehreg1,LENGTH(n_vehreg2) + 1,LENGTH(n_vehreg1))).

        FIND FIRST stat.insure WHERE stat.insure.compno = "999"     AND
                                     INDEX(n_vehreg1,stat.insure.lname) <> 0 NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL stat.insure THEN DO:
            n_provin = insure.fname.
        END.
    END.
    --*/

    /*--*/
    IF nv_vehreg <> "" THEN DO:

        n_vehreg1 = TRIM(nv_vehreg).

        n_vehreg2 = TRIM(SUBSTR(n_vehreg1,1,INDEX(n_vehreg1," "))).
        n_vehreg1 = TRIM(SUBSTR(n_vehreg1,LENGTH(n_vehreg2) + 1,LENGTH(n_vehreg1))).

       /* n_vehreg2 = "".
        n_vehreg2 = TRIM(SUBSTR(n_vehreg1,INDEX(n_vehreg1," ") + 1,3)).*/

        n_provin  = TRIM(SUBSTR(n_vehreg1,INDEX(n_vehreg1," ") + 1,3)).
        nv_vehreg = n_vehreg2 + " " + TRIM(SUBSTR(n_vehreg1,1,INDEX(n_vehreg1," "))).

        /*--
        n_vehreg1 = TRIM(nv_vehreg).

        n_vehreg2 = TRIM(SUBSTR(n_vehreg1,1,INDEX(n_vehreg1," "))).
        n_vehreg1 = TRIM(SUBSTR(n_vehreg1,LENGTH(n_vehreg2) + 1,LENGTH(n_vehreg1))).

        FIND FIRST stat.insure WHERE stat.insure.compno = "999"     AND
                                     INDEX(n_vehreg1,stat.insure.lname) <> 0 NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL stat.insure THEN DO:
            n_provin = insure.fname.
        END.
        --*/
    END.
    /*--*/

    FIND FIRST uwm100 WHERE
               uwm100.policy = wagtprm_fil.policy AND
               uwm100.endno  = wagtprm_fil.endno  AND
               uwm100.docno1 = wagtprm_fil.docno  NO-LOCK NO-ERROR.
    IF AVAIL uwm100 THEN DO:

        ASSIGN
            y1 = 0  
            z1 = 0
            n_wh1 = IF n_wh1 < 0 THEN 0 ELSE n_wh1.

        FOR EACH acd001 USE-INDEX acd00191 WHERE
                 acd001.trnty1 = SUBSTR(wagtprm_fil.trntyp,1,1) AND
                 acd001.docno  = wagtprm_fil.docno              NO-LOCK:
            IF acd001.ctrty1 = 'y' THEN y1 = -(acd001.netloc).
            IF acd001.ctrty1 = 'z' THEN z1 = -(acd001.netloc).
        END.

        IF wagtprm_fil.bal - (y1 + z1) <= n_wh1 THEN NEXT loop_main2.

        /*--
        IF uwm100.rencnt = 0 OR uwm100.prvpol = "" THEN nv_job_nr = "N".
                                                   ELSE nv_job_nr = "R".
        --*/

        ASSIGN
            nv_comdat = uwm100.comdat
            nv_expdat = uwm100.expdat
            nv_endcnt = uwm100.endcnt.

        nv_insure = (uwm100.ntitle) + " " + (uwm100.name1).
        IF nv_insure = " " THEN nv_insure = wagtprm_fil.insure.

        /*--
        nv_pol72 = "".
        IF (wagtprm_fil.poltyp = "v70" ) OR 
           (wagtprm_fil.poltyp = "v72" AND SUBSTR(wagtprm_fil.policy,7,1) <> "t" ) THEN DO:
            RUN PDCompul2.
        END.
        --*/

        FIND FIRST uwm120 USE-INDEX uwm12001 WHERE
                   uwm120.policy = uwm100.policy AND
                   uwm120.rencnt = uwm100.rencnt AND
                   uwm120.endcnt = uwm100.endcnt NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL uwm120 THEN DO:
            nv_nor_si = uwm120.sigr + uwm120.sico.
            nv_class  = uwm120.CLASS.
        END.

        FIND FIRST uwm301 USE-INDEX uwm30101 WHERE
                   uwm301.policy = uwm100.policy AND
                   uwm301.rencnt = uwm100.rencnt AND
                   uwm301.endcnt = uwm100.endcnt NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL uwm301 THEN DO:
            ASSIGN
                nv_engine = uwm301.eng_no
                nv_cha_no = uwm301.cha_no
                nv_covcod = uwm301.covcod.
        END.
        ELSE DO:
            ASSIGN
                nv_engine = ""
                nv_cha_no = ""
                nv_covcod = "".
        END.

        IF (SUBSTR(wagtprm_fil.policy,3,1) = "7" ) AND nv_pol72 <> "" THEN DO:

            /*-- calculate   0.4 / 100 = 0.004   ,  7 / 100 = 0.07 --*/
            ASSIGN
                vStamp_comp      = IF (nv_netPrem_comp * 0.004 ) - TRUNCATE( (nv_netPrem_comp * 0.004 ),0) > 0
                                   THEN TRUNCATE( (nv_netPrem_comp * 0.004 ),0) + 1  /* มีทศนิยม  ปัดเศษ + 1 */
                                   ELSE TRUNCATE( (nv_netPrem_comp * 0.004 ),0)      /* ไม่มีทศนิยม */
                vVat_comp         = (nv_netPrem_comp + vStamp_comp) * 0.07
                nv_grossPrem_comp = nv_netprem_comp  + vStamp_comp + vVat_comp
                vStamp            = wagtprm_fil.stamp - vStamp_comp
                vVat              = wagtprm_fil.tax   - vVat_comp
                nv_grossPrem      = nv_netprem + vStamp + vVat
                nv_net_com        = nv_netprem * (18 / 100).
        END.
        ELSE DO:
            
            /*-- calculate   0.4 / 100 = 0.004   ,  7 / 100 = 0.07 --*/
            ASSIGN
                vStamp_comp       = IF (nv_netPrem_comp * 0.004 ) - TRUNCATE( (nv_netPrem_comp * 0.004 ),0) > 0
                                    THEN TRUNCATE( (nv_netPrem_comp * 0.004 ),0) + 1  /* มีทศนิยม  ปัดเศษ + 1 */
                                    ELSE TRUNCATE( (nv_netPrem_comp * 0.004 ),0)      /* ไม่มีทศนิยม */
                vVat_comp         = (nv_netPrem_comp + vStamp_comp) * 0.07
                nv_grossPrem_comp = nv_netprem_comp  + vStamp_comp + vVat_comp
                vStamp            = wagtprm_fil.stamp - vStamp_comp
                vVat              = wagtprm_fil.tax   - vVat_comp
                nv_grossPrem      = nv_netprem + vStamp + vVat
                nv_net_com        = nv_netprem * (18 / 100).
        END.

        IF (SUBSTR(nv_vehreg,1,1) <> "/") THEN DO:
            nv_vehreg = nv_vehreg.     /* รถเก่า  มีเลขทะเบียน */
        END.
        ELSE DO:   /* SUBSTR(nv_vehreg,1,1) = "/" รถใหม่ ไม่มีทะเบียนรถ */
            IF nv_engine <> "" THEN nv_vehreg = nv_engine.   /* เลขเครื่องยนต์ <> ""  then นำเลขเครื่องยนต์มาใส่ที่ทะเบียนรถ*/
            ELSE nv_vehreg = SUBSTR(nv_vehreg, 1 ,LENGTH(nv_vehreg)).  /* ถ้าเลขเครื่องยนต์ = "" ตัด "/" */
        END. 

        /*-- Create Data to wBill --*/
        FIND FIRST wBill USE-INDEX wBill01 WHERE
                   wBill.wPolicy = agtprm_fil.policy  AND
                   wBill.wEndno  = agtprm_fil.endno   AND
                   wBill.wdocno  = agtprm_fil.docno   NO-ERROR NO-WAIT.
        IF NOT AVAIL wBill THEN DO:
            vCountRec = vCountRec + 1.
            DISPLAY "Create data to Table wBill ..."  @ fi_Process  WITH FRAME {&FRAME-NAME}.

            CREATE wBill.
            ASSIGN
                wBill.wRecid     = vCountRec
                wBill.wPolicy    = wagtprm_fil.policy 
                wBill.wCha_no    = nv_cha_no
                wBill.wEndcnt    = nv_endcnt
                wBill.wEndno     = wagtprm_fil.endno  
                wBill.wDocno     = wagtprm_fil.docno  
                wBill.wInsure    = nv_insure
                wBill.wComdat    = nv_comdat
                wBill.wExpdat    = nv_expdat
                wBill.wVehreg    = nv_vehreg
                wBill.wProvin    = n_provin
                wBill.wcovcod    = nv_covcod
                wBill.wsi        = nv_nor_si
                wBill.wGrossPrem = nv_grossPrem
                wBill.wStamp     = vStamp 
                wBill.wTax       = vVat
                wBill.wNetPrem   = nv_netprem 
                wBill.wComm      = nv_net_com 
                wBill.wRemark    = ""
                wBill.wClass     = SUBSTR(nv_class,2,3).

            IF wBill.wClass = "110" THEN NCount1 = NCount1 + 1.
            IF wBill.wClass = "210" THEN NCount2 = NCount2 + 1.
            IF wBill.wClass = "320" THEN NCount3 = NCount3 + 1.
        END.                           
    END.
END.

IF vCountRec = 0 THEN DO:
    MESSAGE "ไม่พบข้อมูล ที่จะส่งออก" VIEW-AS ALERT-BOX INFORMATION.
    RETURN NO-APPLY.
END.

RELEASE acProc_fil.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDProcessEx C-Win 
PROCEDURE PDProcessEx :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE BUFFER bufwBill FOR wBill.
DEFINE VAR n_wRecordno     AS INTE FORMAT "999999" INIT 0. 

ASSIGN
    nv_nettotal   = 0
    nv_stamptotal = 0
    nv_vattotal   = 0
    nv_grosstotal = 0
    nv_commtotal  = 0.

OUTPUT TO VALUE(fioutput1) NO-ECHO APPEND.

EXPORT DELIMITER ","
    "Agent Code :" 
    "74000414 : บริษัท เงินติดล้อ จำกัด" 
    " " 
    " " 
    " " 
    " "
    "ใบแจ้งหนี้ / ใบวางบิล" .

EXPORT DELIMITER ","
    "ที่อยู่จัดส่ง :" 
    "เลขที่ 89/170 อาคารจุฑามาศ ชั้น 4 ถนนวิภาวดีรังสิต แขวงตลาดบางเขน เขตหลักสี่ กทม. 10210" 
    " " 
    " " 
    " " 
    " "
    "ประกันภัยรถยนต์ โปรกเกอร์เงินติดล้อ"
    " " 
    " " 
    " " 
    " " 
    " " 
    " "
    "รถยนต์ ขนาดเล็ก".

EXPORT DELIMITER ","
    "เรียน :" 
    "คุณลลินตา สาระศาลิน" 
    "เรียน :" 
    "คุณชญานุตย์ ศิริวัฒน์ปิติวงษ์" 
    " " 
    " " 
    "งวดระหว่างวันที่"
    " " 
    " " 
    " " 
    " " 
    " " 
    " "
    "วันที่".

EXPORT DELIMITER ","
    "โทรศัพท์ :" 
    "02-792-1888 ต่อ 1547" 
    "โทรศัพท์ :" 
    "02-792-1888 Ext.1564" 
    " " 
    " "
    "รวมจำนวน" 
    " "
    "กรมธรรม์".

EXPORT DELIMITER ","
    "โทรสาร :" 
    "02-792-1889" 
    "โทรสาร :" 
    "02-792-1889". 

EXPORT DELIMITER ","
    "โทร(มือถือ):"
    " "
    "โทร(มือถือ):".

EXPORT DELIMITER ","
    "E-mail :" 
    "lalinta.S@cfg.co.th" 
    "E-mail :" 
    "Chanphen.N@cfg.co.th".

EXPORT DELIMITER ","
    "วัตถุประสงค์:" 
    "เพื่อนำส่งเอกสาร กรมธรรม์ประกันภัยรถยนต์ และ สำเนาใบเสร็จรับเงิน".

EXPORT DELIMITER ","
    "รายละเอียดค่าเบี้ยประกันภัยลูกค้า บริษัท เงินติดล้อ จำกัด ที่ต้องชำระ ณ.วันที่".

EXPORT DELIMITER ","
    "ลำดับ" 
    "กรมธรรม์เลขที่/สลักหลัง" 
    "เลขที่ใบเสร็จรับเงิน" 
    "ชื่อผู้เอาประกันภัย" 
    "วันคุ้มครอง" 
    "วันสิ้นสุด" 
    "ทะเบียน" 
    "จังหวัด"
    "ประเภท" 
    "ทุนประกัน" 
    "เบี้ยสุทธิ" 
    "อากร 0.4%" 
    "ภาษี 7%" 
    "เบี้ยรวม" 
    "ส่วนลด 18%" 
    "หมายเหตุ".

FOR EACH wBill WHERE wBill.wClass = "110" NO-LOCK:
    n_wRecordno = n_wRecordno + 1.

    EXPORT DELIMITER ","
        n_wRecordno      
        wBill.wPolicy    
        wBill.wDocno     
        wBill.wInsure    
        wBill.wComdat    
        wBill.wExpdat    
        wBill.wVehreg    
        wBill.wProvin    
        wBill.wcovcod    
        wBill.wsi 
        wBill.wNetPrem 
        wBill.wStamp     
        wBill.wTax       
        wBill.wGrossPrem   
        wBill.wComm      
        wBill.wRemark .

    ASSIGN
        nv_grosstotal = nv_grosstotal + wBill.wGrossPrem
        nv_stamptotal = nv_stamptotal + wBill.wStamp
        nv_vattotal   = nv_vattotal   + wBill.wTax  
        nv_nettotal   = nv_nettotal   + wBill.wNetPrem
        nv_commtotal  = nv_commtotal  + wBill.wComm .
END.

EXPORT DELIMITER ","
    " " 
    " " 
    " " 
    " " 
    " " 
    " " 
    " " 
    " " 
    " " 
    " "
    nv_grosstotal 
    nv_stamptotal 
    nv_vattotal   
    nv_nettotal   
    nv_commtotal. 

EXPORT DELIMITER ","
    " ". 

EXPORT DELIMITER ","
    " ". 

vExpCount1 = n_wRecordno.

RUN PDPrintFooter.

OUTPUT CLOSE.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDProceswh1 C-Win 
PROCEDURE PDProceswh1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       tax 1 %
------------------------------------------------------------------------------*/
n_wh1 = 0.

IF uwm100.ntitle       = "บริษัท"             OR
   uwm100.ntitle       = "บ."                 OR
   TRIM(uwm100.ntitle) = "บจก."               OR
   TRIM(uwm100.ntitle) = "หจก."               OR
   TRIM(uwm100.ntitle) = "หสน."               OR
   uwm100.ntitle       = "บรรษัท"             OR
   uwm100.ntitle       = "มูลนิธิ"            OR
   uwm100.ntitle       = "ห้างหุ้นส่วน"       OR
   uwm100.ntitle       = "ห้าง"               OR
   uwm100.ntitle       = "ห้างหุ้นส่วนจำกัด"  OR
   uwm100.ntitle       = "ห้างหุ้นส่วนจำก"    THEN n_wh1 = ((nv_netPrem + nv_netPrem_comp + agtprm_fil.stamp ) * 1) / 100 .  /* 12+13+stamp * 1% */

IF R-INDEX(uwm100.name1,"จก.")               <> 0  OR
   R-INDEX(uwm100.name1,"จำกัด")             <> 0  OR  
   R-INDEX(uwm100.name1,"(มหาชน)")           <> 0  OR
   R-INDEX(uwm100.name1,"INC.")              <> 0  OR
   R-INDEX(uwm100.name1,"CO.")               <> 0  OR
   R-INDEX(uwm100.name1,"LTD.")              <> 0  OR
   R-INDEX(uwm100.name1,"LIMITED")           <> 0  OR
     INDEX(uwm100.name1,"บริษัท")            <> 0  OR
     INDEX(uwm100.name1,"บ.")                <> 0  OR
     INDEX(uwm100.name1,"บจก.")              <> 0  OR
     INDEX(uwm100.name1,"หจก.")              <> 0  OR
     INDEX(uwm100.name1,"หสน.")              <> 0  OR
     INDEX(uwm100.name1,"บรรษัท")            <> 0  OR
     INDEX(uwm100.name1,"มูลนิธิ")           <> 0  OR
     INDEX(uwm100.name1,"ห้าง")              <> 0  OR
     INDEX(uwm100.name1,"ห้างหุ้นส่วน")      <> 0  OR
     INDEX(uwm100.name1,"ห้างหุ้นส่วนจำกัด") <> 0  OR
     INDEX(uwm100.name1,"ห้างหุ้นส่วนจำก")   <> 0  OR
     INDEX(uwm100.name1,"และ/หรือ")          <> 0  THEN n_wh1 = ((nv_netPrem + nv_netPrem_comp + agtprm_fil.stamp ) * 1) / 100 .  /* 12+13+stamp * 1% */


IF LENGTH(uwm100.insref)  = 7 THEN DO:
   IF SUBSTR(uwm100.insref,2,1) = "C" THEN 
      n_wh1 = ((nv_netPrem + nv_netPrem_comp + agtprm_fil.stamp ) * 1) / 100 .
END.
ELSE IF LENGTH(uwm100.insref)  = 10 THEN DO:
    
    IF SUBSTR(uwm100.insref,3,1) = "C" THEN
       n_wh1 = ((nv_netPrem + nv_netPrem_comp + agtprm_fil.stamp ) * 1) / 100 .
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

