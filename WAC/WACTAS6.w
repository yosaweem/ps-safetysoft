&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
&Scoped-define WINDOW-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS C-Win 
/*------------------------------------------------------------------------

  File: WacTAS6.W    Statement Text File Thai Auto Sales by Group Statement

  Description:       Dup. program from WacTAS1.W
                     - เรียกข้อมูลตาม Group Statement ที่ระบุจากหน้าจอ  โดยดึงมาทุก Producer code 
                     - โดย Sum ยอด Premium by Policy No. (New Policy , Endorement , Renew)  Export เป็น 1 ไฟล์
                     - โดย Sum ยอด Premium by Chassis Export เป็น 1 ไฟล์
                     - สุดท้าย Sum ยอด Premium by Contract Export เป็น 1 ไฟล์
  Input Parameters:
      <none>

  Output Parameters:
      <none>

  Author:   Tantawan Ch. 

  Created:   A60-0379    @20/09/2017 
------------------------------------------------------------------------*
 Modify by  : Tantawan Ch.  
 ASSIGN     : A61-0001    Date : 4/1/2018
            : 1. เพิ่มให้ put data แต่ละเรคคอร์ดก่อนที่จะ group รวมเป็น 1 เรคคอร์ด
              to text file เพื่อใช้สำหรับเช็คข้อมูล กรณีมีสลักหลังที่ไม่เป็นไปตามเงื่อนไข
------------------------------------------------------------------------*
 Modify by  : Tantawan Ch.  
 ASSIGN     : A65-0021    DATE : 08/02/2022
            : Fix bug error >  ** No xmm600 record is available.(91)
              ปรับการ find เอา no-wait ออก
------------------------------------------------------------------------
 Modify By : TANTAWAN CH. ASSIGN : A65-0335   DATE : 04/11/2022
             Fix Bug  ไม่ต้องค่า nv_cnt ตอนเรียกข้อมูลเสร็จแล้ว
------------------------------------------------------------------------
 Modify By : TANTAWAN CH. ASSIGN : F67-0004   DATE : 13/05/2024
             Fix Bug  ไม่ต้องค่า nv_cnt ตอนเรียกข้อมูลเสร็จแล้ว
------------------------------------------------------------------------*/
/*          This .W file wAS created with the Progress UIB.             */
/*----------------------------------------------------------------------*/

/* Create an unnamed pool to store all the widgets created 
     by this procedure. This is a good DEFINEault which ASsures
     that this procedure's triggers and INTEErnal procedures 
     will execute in this procedure's storage, and that proper
     cleanup will occur on deletion of the procedure. */

CREATE WIDGET-POOL.
/* Parameters DEFINEinitions ---                                           */

/* Local VARiable DEFINEinitions ---                                       */
DEFINE NEW SHARED VAR n_branch      AS CHAR FORMAT "X(2)".
DEFINE NEW SHARED VAR n_branch2     AS CHAR FORMAT "X(2)".
DEFINE            VAR n_ASdat       AS DATE FORMAT "99/99/9999".

DEFINE VAR n_OutputFile1  AS CHAR.
DEFINE VAR n_name     AS CHAR FORMAT "X(50)". /* acno name*/
DEFINE VAR n_bdes     AS CHAR FORMAT "X(50)". /* branch name*/
DEFINE VAR n_chkBname AS CHAR FORMAT "X(1)".  /* branch-- chk button 1-2 */
DEFINE VAR nv_acno    AS CHAR FORMAT 'X(10)'. /*--- A500178 --- ปรับ format จาก  "X(7)" เป็น  "X(10)" */
DEFINE VAR nv_policy  AS CHAR FORMAT "X(16)".
DEFINE VAR nv_norpol  AS CHAR FORMAT "X(25)".
DEFINE VAR nv_pol72   AS CHAR FORMAT "X(16)".
DEFINE VAR nv_cedpol  AS CHAR FORMAT "x(20)".   /* Sarinya c. A59-0362 */
DEFINE VAR nv_name2   AS CHAR  FORMAT "X(80)".  /* Sarinya c. A59-0362 */
DEFINE VAR nv_vatcode AS CHAR  FORMAT "X(10)".  /* Sarinya c. A59-0362 */

DEFINE VAR nv_endno   AS CHAR FORMAT "X(12)".
DEFINE VAR nv_polbran AS CHAR FORMAT "X(2)".
DEFINE VAR nv_poltyp  AS CHAR FORMAT "X(3)".
DEFINE VAR nv_trnty1  AS CHAR FORMAT "X(1)".
DEFINE VAR nv_trnty2  AS CHAR FORMAT "X(1)".
DEFINE VAR nv_docno   AS CHAR FORMAT "X(10)".
DEFINE VAR nv_trndat  AS DATE FORMAT "99/99/9999".
DEFINE VAR nv_ASdat   AS DATE FORMAT "99/99/9999".
DEFINE VAR nv_trndat1 AS DATE FORMAT "99/99/9999".
DEFINE VAR nv_insref  AS CHAR FORMAT "X(10)". /*--- A500178 --- ปรับ format จาก  "X(7)" เป็น  "X(10)" */
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
DEFINE VAR nv_nor_si  AS DECI FORMAT "->>,>>>,>>9.99".
DEFINE VAR nv_comp_si AS DECI FORMAT "->>,>>>,>>9.99".

DEFINE BUFFER Buwm_v72 FOR uwm100.
DEFINE BUFFER Buwm301  FOR uwm301.
DEFINE BUFFER Buwm130  FOR uwm130.

DEFINE TEMP-TABLE vehreg72 NO-UNDO
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

DEFINE VAR n_wh1  AS DECI FORMAT "->>9.99".
DEFINE VAR n_wh1c AS DECI FORMAT "->>9.99".

DEFINE TEMP-TABLE wBill
   FIELD wAcno          AS CHAR FORMAT "X(10)"
   FIELD wPolicy        AS CHAR FORMAT "X(16)"
   FIELD wNorpol        AS CHAR FORMAT "X(16)"            
   FIELD wPol72         AS CHAR FORMAT "X(16)"
   FIELD wEndno         AS CHAR FORMAT "X(12)"
   FIELD wPolbran       AS CHAR FORMAT "X(2)"
   FIELD wPoltyp        AS CHAR FORMAT "X(3)"
   FIELD wTrnty1        AS CHAR FORMAT "X"
   FIELD wTrnty2        AS CHAR FORMAT "X"
   FIELD wDocno         AS CHAR FORMAT "X(10)"
   FIELD wTrndat        AS DATE FORMAT "99/99/9999"   /*export DATE*/
   FIELD wASdat         AS DATE FORMAT "99/99/9999"   
   FIELD wTrndat1       AS DATE FORMAT "99/99/9999"   /* trndat to Acc.*/
   FIELD wcontract      AS CHAR FORMAT "X(20)"        /* FORMAT "X(10)" */
   FIELD wInsure        AS CHAR FORMAT "X(50)"
   FIELD wEngine        AS CHAR FORMAT "X(20)"
   FIELD wCha_no        AS CHAR FORMAT "X(20)"
   FIELD wVehreg        AS CHAR FORMAT "X(15)"
   FIELD wComdat        AS DATE FORMAT "99/99/9999"
   FIELD wGrossPrem     AS DECI  FORMAT "->>,>>>,>>9.99"
   FIELD wCompGrossPrem AS DECI  FORMAT "->>,>>>,>>9.99"
   FIELD wNetPrem       AS DECI  FORMAT "->>,>>>,>>9.99"
   FIELD wCompNetPrem   AS DECI  FORMAT "->>,>>>,>>9.99"
   FIELD wTax           AS DECI  FORMAT "->>9.99"
   FIELD wNetPayment    AS DECI  FORMAT "->>,>>>,>>9.99"
   FIELD wbal           AS DECI  FORMAT "->>,>>>,>>9.99"
   FIELD wname2         AS CHAR  FORMAT "X(80)"  /* A59-0362 export และ/หรือ */
   FIELD wvatcode       AS CHAR  FORMAT "X(10)"  /* A59-0362 export vatcode  */
   FIELD wbrandmodel     AS CHAR FORMAT "X(60)" 
INDEX wBill01  IS UNIQUE PRIMARY wAcno wPolicy wEndno wTrnty1 wTrnty2 wDocno ASCENDING
INDEX wBill02 wPolicy wEndno  wNorpol .

FOR EACH vehreg72:   DELETE  vehreg72.   END.

DEFINE TEMP-TABLE  wagtprm_fil  
    FIELD Policy      AS CHAR  FORMAT "X(16)"
    FIELD trntyp      AS CHAR  FORMAT "x(2)"
    FIELD Docno       AS CHAR  FORMAT "X(10)"
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
DEFINE BUFFER Bwagtprm_fil  FOR wagtprm_fil.


DEFINE VAR nv_exportdat AS DATE  FORMAT "99/99/9999".
DEFINE VAR nv_exporttim AS CHAR FORMAT "X(8)".
DEFINE VAR nv_exportusr AS CHAR FORMAT "X(8)".

DEFINE VAR vCountRec  AS INTE INIT 0.   /* lek */

DEFINE VAR n_netloc   AS DECI.
DEFINE VAR y1 AS DECI.
DEFINE VAR z1 AS DECI.
/**/
DEFINE VAR n_veh AS CHAR.
DEFINE VAR a     AS INTE.
DEFINE VAR b     AS INTE.
DEFINE VAR c     AS CHAR FORMAT 'X'.
DEFINE VAR clist AS CHAR init "1,2,3,4,5,6,7,8,9,0".
DEFINE VAR bbb   AS INTE.
DEFINE VAR ccc   AS CHAR FORMAT 'X(20)'.
DEFINE VAR ddd   AS CHAR FORMAT 'X(20)'.
/**/
DEFINE NEW SHARED VAR engc AS CHAR FORMAT 'X(20)'.
DEFINE VAR vAcProc_fil  AS CHAR.
/**/
DEFINE VAR nv_eng   AS CHAR FORMAT "X(20)".
DEFINE VAR nv_char  AS CHAR FORMAT "X(20)".
DEFINE VAR nv_l     AS INTE.
DEFINE VAR nv_spc   AS LOG.
/**/
DEFINE VAR n_poltype    AS CHAR FORMAT 'X(3)'.
DEFINE VAR n_pol     AS CHAR FORMAT 'X(16)'.
DEFINE VAR n_ren     AS INTE FORMAT ">9".
DEFINE VAR n_end     AS INTE FORMAT "999".
DEFINE VAR n_TrnDatF AS DATE FORMAT "99/99/9999".
DEFINE VAR n_TrnDatT AS DATE FORMAT "99/99/9999".
/*---------------DEFINE for tAS2.i----------------*/
DEFINE VAR vStamp      AS DECI.
DEFINE VAR vVat        AS DECI.
DEFINE VAR vStamp_comp AS DECI.
DEFINE VAR vVat_comp   AS DECI.
/*-------------------------------------------------*/

DEFINE VAR nv_acnoAll AS CHAR.
DEFINE VAR nv_strdate AS CHAR.
DEFINE VAR nv_enddate AS CHAR.
DEF VAR n_type AS INTE FORMAT "9" .  
DEF VAR nv_cnt AS INT  init  0.

DEF VAR nv_brandmol AS CHAR FORMAT "X(60)"  .
DEFINE BUFFER Bagtprm_fil FOR agtprm_fil.

DEF VAR nv_PutPol   AS CHAR.
DEF VAR nv_PutChas  AS CHAR.
DEF VAR nv_PutCont  AS CHAR.

DEFINE TEMP-TABLE w2Bill
   FIELD wAcno          AS CHAR FORMAT "X(10)" 
   FIELD wPolicy        AS CHAR FORMAT "X(16)"
   FIELD wNorpol        AS CHAR FORMAT "X(16)"            
   FIELD wPol72         AS CHAR FORMAT "X(16)"
   FIELD wEndno         AS CHAR FORMAT "X(12)"
   FIELD wPolbran       AS CHAR FORMAT "X(2)"
   FIELD wPoltyp        AS CHAR FORMAT "X(3)"
   FIELD wTrnty1        AS CHAR FORMAT "X"
   FIELD wTrnty2        AS CHAR FORMAT "X"
   FIELD wDocno         AS CHAR FORMAT "X(10)"
   FIELD wTrndat        AS DATE FORMAT "99/99/9999"   /*export DATE*/
   FIELD wASdat         AS DATE FORMAT "99/99/9999"   
   FIELD wTrndat1       AS DATE FORMAT "99/99/9999"   /* trndat to Acc.*/
   FIELD wcontract      AS CHAR FORMAT "X(20)"        /* FORMAT "X(10)" */
   FIELD wInsure        AS CHAR FORMAT "X(50)"
   FIELD wEngine        AS CHAR FORMAT "X(20)"
   FIELD wCha_no        AS CHAR FORMAT "X(20)"
   FIELD wVehreg        AS CHAR FORMAT "X(15)"
   FIELD wComdat        AS DATE FORMAT "99/99/9999"
   FIELD wGrossPrem     AS DECI  FORMAT "->>,>>>,>>9.99"
   FIELD wCompGrossPrem AS DECI  FORMAT "->>,>>>,>>9.99"
   FIELD wNetPrem       AS DECI  FORMAT "->>,>>>,>>9.99"
   FIELD wCompNetPrem   AS DECI  FORMAT "->>,>>>,>>9.99"
   FIELD wTax           AS DECI  FORMAT "->>9.99"
   FIELD wNetPayment    AS DECI  FORMAT "->>,>>>,>>9.99"
   FIELD wbal           AS DECI  FORMAT "->>,>>>,>>9.99"
   FIELD wname2         AS CHAR  FORMAT "X(80)"  /* A59-0362 export และ/หรือ */
   FIELD wvatcode       AS CHAR  FORMAT "X(10)"  /* A59-0362 export vatcode  */
   FIELD wbrandmodel     AS CHAR FORMAT "X(60)" 
INDEX w2Bill01 IS UNIQUE PRIMARY wAcno wPolicy wEndno wTrnty1 wTrnty2 wDocno ASCENDING
INDEX w2Bill02 wCha_no wComdat wPolicy wNorpol .

DEFINE TEMP-TABLE w3Bill
   FIELD wAcno          AS CHAR FORMAT "X(10)" 
   FIELD wPolicy        AS CHAR FORMAT "X(16)"
   FIELD wNorpol        AS CHAR FORMAT "X(16)"            
   FIELD wPol72         AS CHAR FORMAT "X(16)"
   FIELD wEndno         AS CHAR FORMAT "X(12)"
   FIELD wPolbran       AS CHAR FORMAT "X(2)"
   FIELD wPoltyp        AS CHAR FORMAT "X(3)"
   FIELD wTrnty1        AS CHAR FORMAT "X"
   FIELD wTrnty2        AS CHAR FORMAT "X"
   FIELD wDocno         AS CHAR FORMAT "X(10)"
   FIELD wTrndat        AS DATE FORMAT "99/99/9999"   /*export DATE*/
   FIELD wASdat         AS DATE FORMAT "99/99/9999"   
   FIELD wTrndat1       AS DATE FORMAT "99/99/9999"   /* trndat to Acc.*/
   FIELD wcontract      AS CHAR FORMAT "X(20)"        /* FORMAT "X(10)" */
   FIELD wInsure        AS CHAR FORMAT "X(50)"
   FIELD wEngine        AS CHAR FORMAT "X(20)"
   FIELD wCha_no        AS CHAR FORMAT "X(20)"
   FIELD wVehreg        AS CHAR FORMAT "X(15)"
   FIELD wComdat        AS DATE FORMAT "99/99/9999"
   FIELD wGrossPrem     AS DECI  FORMAT "->>,>>>,>>9.99"
   FIELD wCompGrossPrem AS DECI  FORMAT "->>,>>>,>>9.99"
   FIELD wNetPrem       AS DECI  FORMAT "->>,>>>,>>9.99"
   FIELD wCompNetPrem   AS DECI  FORMAT "->>,>>>,>>9.99"
   FIELD wTax           AS DECI  FORMAT "->>9.99"
   FIELD wNetPayment    AS DECI  FORMAT "->>,>>>,>>9.99"
   FIELD wbal           AS DECI  FORMAT "->>,>>>,>>9.99"
   FIELD wname2         AS CHAR  FORMAT "X(80)"  /* A59-0362 export และ/หรือ */
   FIELD wvatcode       AS CHAR  FORMAT "X(10)"  /* A59-0362 export vatcode  */
   FIELD wbrandmodel     AS CHAR FORMAT "X(60)" 
INDEX w3Bill01 IS UNIQUE PRIMARY wAcno wPolicy wEndno wTrnty1 wTrnty2 wDocno ASCENDING
INDEX w3Bill02 wContract wComDat wNorpol wPol72 .

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS fiBranch buBranch fiBranch2 buBranch2 fi_ac1 ~
cbAsDat ra_type fi_TrnDatF fi_TrnDatT fiFile-Name1 Btn_OK Btn_Exit ~
Btn_convert fibdes fibdes2 fi_process fi_GrpDesc RECT-1 RECT-2 RECT-3 ~
RECT-4 RECT-5 RECT-6 RECT-7 RECT-8 RECT-9 
&Scoped-Define DISPLAYED-OBJECTS fiBranch fiBranch2 fi_ac1 cbAsDat ra_type ~
fi_TrnDatF fi_TrnDatT fiFile-Name1 fibdes fibdes2 fi_process fi_GrpDesc 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME


/* ************************  Function Prototypes ********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fuDeciToChar C-Win 
FUNCTION fuDeciToChar RETURNS CHARACTER
  ( vDeci   AS decimal,     vCharno AS integer )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fuFindBranch C-Win 
FUNCTION fuFindBranch RETURNS CHARACTER
  ( nv_branch AS CHAR )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fuLeapYear C-Win 
FUNCTION fuLeapYear RETURNS LOGICAL
  ( /* parameter-definitions */ y AS int)  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fuNumYear C-Win 
FUNCTION fuNumYear RETURNS INTEGER
  (INPUT vDate AS DATE )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON Btn_convert AUTO-END-KEY 
     LABEL "CONVERT=>EXCEL=>TEXT" 
     SIZE 28 BY 1.52
     BGCOLOR 8 FONT 6.

DEFINE BUTTON Btn_Exit AUTO-END-KEY 
     LABEL "Exit" 
     SIZE 13 BY 1.52
     BGCOLOR 8 FONT 6.

DEFINE BUTTON Btn_OK AUTO-GO 
     LABEL "OK" 
     SIZE 13 BY 1.52
     BGCOLOR 8 FONT 6.

DEFINE BUTTON buBranch 
     LABEL "..." 
     SIZE 3 BY .95 TOOLTIP "รหัสสาขา"
     FONT 6.

DEFINE BUTTON buBranch2 
     LABEL "..." 
     SIZE 3 BY .95 TOOLTIP "รหัสสาขา"
     FONT 6.

DEFINE VARIABLE cbAsDat AS CHARACTER FORMAT "X(256)":U INITIAL ? 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEMS "item 1" 
     DROP-DOWN-LIST
     SIZE 16 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fibdes AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 29.5 BY .95
     BGCOLOR 18 FGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fibdes2 AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 29.5 BY .95
     BGCOLOR 18 FGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiBranch AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 5 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fiBranch2 AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 5 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fiFile-Name1 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 51.17 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_ac1 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 12 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_GrpDesc AS CHARACTER FORMAT "X(10)":U 
      VIEW-AS TEXT 
     SIZE 48.83 BY .95
     BGCOLOR 15 FGCOLOR 1 FONT 2 NO-UNDO.

DEFINE VARIABLE fi_process AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 63 BY 1
     BGCOLOR 173 FGCOLOR 30 FONT 2 NO-UNDO.

DEFINE VARIABLE fi_TrnDatF AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 15 FONT 1 NO-UNDO.

DEFINE VARIABLE fi_TrnDatT AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 15 FONT 1 NO-UNDO.

DEFINE VARIABLE ra_type AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "By Transaction Date", 1
     SIZE 30.5 BY .95
     BGCOLOR 3 FONT 2 NO-UNDO.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 22.5 BY 11.48
     BGCOLOR 32 FGCOLOR 15 .

DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 98.5 BY 11.48
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-3
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 22.5 BY 3.24
     BGCOLOR 32 .

DEFINE RECTANGLE RECT-4
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 98.5 BY 3.24
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-5
     EDGE-PIXELS 5 GRAPHIC-EDGE    
     SIZE 126.5 BY 18.29
     BGCOLOR 173 FGCOLOR 0 .

DEFINE RECTANGLE RECT-6
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 16 BY 2.33
     BGCOLOR 5 .

DEFINE RECTANGLE RECT-7
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 16 BY 2.33
     BGCOLOR 154 FGCOLOR 0 .

DEFINE RECTANGLE RECT-8
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 68.33 BY 1.57
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-9
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 32 BY 2.33
     BGCOLOR 146 FGCOLOR 0 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     fiBranch AT ROW 4.14 COL 29.5 COLON-ALIGNED NO-LABEL
     buBranch AT ROW 4.14 COL 36.5
     fiBranch2 AT ROW 5.33 COL 29.5 COLON-ALIGNED NO-LABEL
     buBranch2 AT ROW 5.33 COL 36.5
     fi_ac1 AT ROW 6.76 COL 29.5 COLON-ALIGNED NO-LABEL
     cbAsDat AT ROW 11.48 COL 29.5 COLON-ALIGNED NO-LABEL
     ra_type AT ROW 11.48 COL 49.5 NO-LABEL
     fi_TrnDatF AT ROW 13.33 COL 40.83 COLON-ALIGNED NO-LABEL
     fi_TrnDatT AT ROW 13.33 COL 66.67 COLON-ALIGNED NO-LABEL
     fiFile-Name1 AT ROW 16.52 COL 29.33 COLON-ALIGNED NO-LABEL
     Btn_OK AT ROW 22.29 COL 67
     Btn_Exit AT ROW 22.24 COL 116.17
     Btn_convert AT ROW 22.29 COL 84
     fibdes AT ROW 4.14 COL 38 COLON-ALIGNED NO-LABEL
     fibdes2 AT ROW 5.33 COL 38 COLON-ALIGNED NO-LABEL
     fi_process AT ROW 19.48 COL 29.5 COLON-ALIGNED NO-LABEL
     fi_GrpDesc AT ROW 6.76 COL 43.17 COLON-ALIGNED NO-LABEL
     "Date From :" VIEW-AS TEXT
          SIZE 10.33 BY 1 AT ROW 13.33 COL 31.67
          BGCOLOR 19 FGCOLOR 0 
     "* Export Data to file by Contract" VIEW-AS TEXT
          SIZE 25 BY .95 AT ROW 18.33 COL 85
          BGCOLOR 19 FGCOLOR 2 
     " As of Date (Statement)":30 VIEW-AS TEXT
          SIZE 19.5 BY .95 TOOLTIP "วันที่ออกรายงาน" AT ROW 11.57 COL 8
          BGCOLOR 19 FGCOLOR 0 
     "Branch To":10 VIEW-AS TEXT
          SIZE 19.5 BY 1 TOOLTIP "ถึงสาขา" AT ROW 5.43 COL 8
          BGCOLOR 19 FGCOLOR 0 
     "Branch From":25 VIEW-AS TEXT
          SIZE 19.5 BY 1 TOOLTIP "ตั้งแต่สาขา" AT ROW 4.24 COL 8
          BGCOLOR 19 FGCOLOR 0 
     "Group Statement" VIEW-AS TEXT
          SIZE 19.5 BY 1 AT ROW 7 COL 8
          BGCOLOR 19 FGCOLOR 0 
     "To :" VIEW-AS TEXT
          SIZE 5 BY 1 AT ROW 13.33 COL 63
          BGCOLOR 19 FGCOLOR 0 
     "Output To Text File" VIEW-AS TEXT
          SIZE 16 BY 1 AT ROW 16.57 COL 11.83
          BGCOLOR 19 FGCOLOR 0 
     "V. 1.40" VIEW-AS TEXT
          SIZE 8 BY 1 AT ROW 2.05 COL 122.83 WIDGET-ID 4
          BGCOLOR 1 FGCOLOR 7 FONT 6
     "           >> Statement Group by Policy No and Chassis and Contract No. <<" VIEW-AS TEXT
          SIZE 62.5 BY 1 AT ROW 8.05 COL 31.5
          BGCOLOR 19 FGCOLOR 2 
     " Statement Thai Auto Sales (Sum Total Premium by Policy No >Chassis > Contract)" VIEW-AS TEXT
          SIZE 66.17 BY 1 AT ROW 1.52 COL 34.83
          BGCOLOR 1 FGCOLOR 7 
     "* Export Data to file by Policy" VIEW-AS TEXT
          SIZE 25 BY .95 AT ROW 16.48 COL 85
          BGCOLOR 19 FGCOLOR 2 
     " ** ข้อมูลก่อน group รวมสามารถดูได้ที่ D:~\Temp~\WACTAS6.TXT" VIEW-AS TEXT
          SIZE 52 BY .71 AT ROW 20.52 COL 6 WIDGET-ID 2
          FGCOLOR 7 
     "* Export Data to file by Chassis" VIEW-AS TEXT
          SIZE 25 BY .95 AT ROW 17.38 COL 85
          BGCOLOR 19 FGCOLOR 2 
     RECT-1 AT ROW 3.86 COL 6.5
     RECT-2 AT ROW 3.86 COL 29.5
     RECT-3 AT ROW 16.24 COL 6.5
     RECT-4 AT ROW 16.24 COL 29.5
     RECT-5 AT ROW 3.19 COL 4.5
     RECT-6 AT ROW 21.86 COL 65.5
     RECT-7 AT ROW 21.86 COL 114.5
     RECT-8 AT ROW 1.24 COL 33.67
     RECT-9 AT ROW 21.86 COL 82
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133.33 BY 23.71
         BGCOLOR 1 .


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
         TITLE              = "WacTAS6 - Statement Thai Auto Sales"
         HEIGHT             = 23.67
         WIDTH              = 133.33
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

&IF '{&WINDOW-SYSTEM}' NE 'TTY' &THEN
IF NOT C-Win:LOAD-ICON("wimage/safety.ico":U) THEN
    MESSAGE "Unable to load icon: wimage/safety.ico"
            VIEW-AS ALERT-BOX WARNING BUTTONS OK.
&ENDIF
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW C-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME DEFAULT-FRAME
   FRAME-NAME Custom                                                    */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* WacTAS6 - Statement Thai Auto Sales */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* WacTAS6 - Statement Thai Auto Sales */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_convert
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_convert C-Win
ON CHOOSE OF Btn_convert IN FRAME DEFAULT-FRAME /* CONVERT=>EXCEL=>TEXT */
DO:
    RUN Wac\WacTAS66.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_Exit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_Exit C-Win
ON CHOOSE OF Btn_Exit IN FRAME DEFAULT-FRAME /* Exit */
DO:
    Apply "Close" To This-Procedure.
    Return No-Apply.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_OK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_OK C-Win
ON CHOOSE OF Btn_OK IN FRAME DEFAULT-FRAME /* OK */
DO:
    ASSIGN
        fibranch      /* fibranch       */
        fibranch2     /* fibranch2      */
        fiFile-Name1  /* fiFile-Name1   */

        n_branch       =  fiBranch
        n_branch2      =  fiBranch2
        n_asdat        =  DATE(INPUT cbAsDat)
        n_OutputFile1  =  fiFile-Name1
        n_TrnDatF      =  fi_TrnDatF
        n_TrnDatT      =  fi_TrnDatT
        nv_acnoAll     =  "".

   IF (n_branch > n_branch2)   THEN DO:
       MESSAGE "ข้อมูลรหัสสาขาผิดพลาด" SKIP
               "รหัสสาขาเริ่มต้นต้องน้อยกว่ารหัสสุดท้าย" VIEW-AS ALERT-BOX WARNING . 
       APPLY "Entry" To fibranch.
       RETURN NO-APPLY.
   END.

   IF (n_TrnDatF > n_TrnDatT)   THEN DO:
       MESSAGE "ข้อมูลวันที่คุ้มครองผิดพลาด" SKIP
               "วันที่คุ้มครองเริ่มต้นต้องน้อยกว่าวันที่คุ้มครองสุดท้าย" VIEW-AS ALERT-BOX WARNING.
       APPLY "Entry" TO fi_TrnDatF.
       RETURN NO-APPLY.
   END.

   IF n_OutputFile1 = "" THEN DO:
       MESSAGE "กรุณาใส่ชื่อไฟล์" VIEW-AS ALERT-BOX WARNING.
       APPLY "Entry" TO fiFile-Name1.
       RETURN NO-APPLY.
   END.

   IF fi_ac1 <> "" THEN DO: 

       FOR EACH xmm600 WHERE xmm600.gpstmt = fi_ac1 NO-LOCK .
           IF xmm600.acno <> "" THEN  /* A65-0021 */ nv_acnoAll = nv_acnoAll + TRIM(CAPS(xmm600.acno)) + ",".
       END.
   END.

   IF nv_acnoAll = "" THEN DO:
       MESSAGE "Not found Account Code on Group Statement " +  TRIM(CAPS(fi_ac1)) VIEW-AS ALERT-BOX WARNING.
       APPLY "ENTRY" TO fi_ac1.
       RETURN NO-APPLY.
   END.
   ELSE DO:
       MESSAGE "All Producer Code on Group Statement : " fi_ac1 SKIP
                nv_acnoAll VIEW-AS ALERT-BOX INFORMATION 
        TITLE "All Producer Code on Group Statement".
   END.

   nv_strdate = STRING(TODAY,"99/99/9999") + STRING(TIME, "HH:MM AM").
   
   IF n_type = 1 THEN DO: 

       RUN pdProc1.

       RUN pdOutPrmByPolNo.
       RUN pdProcChissis.
       RUN pdProcContract.
       
   END.

   nv_enddate = STRING(TODAY,"99/99/9999") + STRING(TIME, "HH:MM AM").

   MESSAGE  "ทำการ Dump ข้อมูล ลง Text File : "  fiFile-Name1  SKIP
            "จำนวน Transection : "  vCountRec  " รายการ" SKIP(1)
            "จำนวนเรคคอร์ด : " nv_cnt  " รายการ"  SKIP(1)  /*--F67-0004 --*/
            "Start Date : " nv_strdate "น." SKIP
            "  End Date : " nv_enddate "น." VIEW-AS ALERT-BOX INFORMATION.
   APPLY "ENTRY" TO Btn_Exit.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buBranch
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buBranch C-Win
ON CHOOSE OF buBranch IN FRAME DEFAULT-FRAME /* ... */
DO:

   n_chkBName = "1".
   RUN Whp\Whpbran(INPUT-OUTPUT  n_bdes,INPUT-OUTPUT n_chkBName).
  
   ASSIGN
       fibranch = n_branch
       fibdes   = n_bdes.
/*        n_branch = fibranch. */
       
   DISP fibranch fibdes WITH FRAME {&FRAME-NAME}.

   RETURN NO-APPLY.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buBranch2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buBranch2 C-Win
ON CHOOSE OF buBranch2 IN FRAME DEFAULT-FRAME /* ... */
DO:

    n_chkBName = "2". 
    RUN Whp\Whpbran(INPUT-OUTPUT n_bdes,INPUT-OUTPUT n_chkBName).
  
    ASSIGN
        fibranch2 = n_branch2
        fibdes2   = n_bdes.

    DISP fibranch2 fibdes2 WITH FRAME {&FRAME-NAME}.
 
/*     n_branch2 =  fibranch2. */

    RETURN NO-APPLY.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME cbAsDat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cbAsDat C-Win
ON RETURN OF cbAsDat IN FRAME DEFAULT-FRAME
DO:
/*p-------------*/       
      cbAsDat = input cbAsDat.
      n_asdat    =  DATE( INPUT cbAsDat).         
      if n_asdat = ? then do:
         MESSAGE "ไม่พบข้อมูล  กรุณาตรวจสอบการ Process ข้อมูล" VIEW-AS ALERT-BOX WARNING.      
         return no-apply.
      end.
/*-------------p*/              
       APPLY "ENTRY" TO fi_TrnDatF IN FRAME {&FRAME-NAME}.
       RETURN NO-APPLY.          
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cbAsDat C-Win
ON VALUE-CHANGED OF cbAsDat IN FRAME DEFAULT-FRAME
DO:
/*p-------------*/       
      cbAsDat = input cbAsDat.
      n_asdat    =  DATE( INPUT cbAsDat).         
      if n_asdat = ? then do:
         MESSAGE "ไม่พบข้อมูล  กรุณาตรวจสอบการ Process ข้อมูล" VIEW-AS ALERT-BOX WARNING.      
         return no-apply.
      end.
      APPLY "ENTRY" TO ra_type IN FRAME {&FRAME-NAME}.
      RETURN NO-APPLY.
/*-------------p*/              

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiBranch
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiBranch C-Win
ON LEAVE OF fiBranch IN FRAME DEFAULT-FRAME
DO:
    ASSIGN
        fibranch = CAPS(INPUT fibranch)
        n_branch = fibranch.

    DISP fibranch fibdes WITH FRAME {&FRAME-NAME}.

    APPLY "ENTRY" TO fibranch2 IN FRAME {&FRAME-NAME}.
    RETURN NO-APPLY.
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiBranch C-Win
ON RETURN OF fiBranch IN FRAME DEFAULT-FRAME
DO:
    ASSIGN
        fibranch = INPUT fibranch
        n_branch = fibranch.
    
    fibdes  = fuFindBranch(fibranch).

    IF fibdes = "" THEN DO:
        MESSAGE "ไม่พบข้อมูล" VIEW-AS ALERT-BOX WARNING TITLE "Confirm".
        APPLY "ENTRY" TO fiBranch.
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiBranch2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiBranch2 C-Win
ON LEAVE OF fiBranch2 IN FRAME DEFAULT-FRAME
DO:

    ASSIGN
        fibranch2 = CAPS(INPUT fibranch2)
        n_branch2 = fibranch2.

    DISP fibranch2 fibdes2 WITH FRAME {&FRAME-NAME}.

    APPLY "ENTRY" TO fi_ac1 IN FRAME {&FRAME-NAME}.
    RETURN NO-APPLY.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiBranch2 C-Win
ON RETURN OF fiBranch2 IN FRAME DEFAULT-FRAME
DO:
    ASSIGN
        fibranch2 = INPUT fibranch2
        n_branch2  = fibranch2.

    fibdes2 = fuFindBranch(fibranch2).

    IF fibdes2 = "" THEN DO:
        MESSAGE "ไม่พบข้อมูล" VIEW-AS ALERT-BOX WARNING TITLE "Confirm".
        APPLY "ENTRY" TO fiBranch2.
    END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiFile-Name1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiFile-Name1 C-Win
ON LEAVE OF fiFile-Name1 IN FRAME DEFAULT-FRAME
DO:
    
    fiFile-Name1 = INPUT fiFile-Name1.

    nv_PutPol  = "".
    nv_PutPol  = fiFile-Name1 + "-byPolNo" +  ".Txt".
    nv_PutChas = "".
    nv_PutChas = fiFile-Name1 + "-byChassis" +  ".Txt".

    nv_PutCont = "".
    nv_PutCont = fiFile-Name1 + "-byContract" +  ".Txt".
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_ac1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_ac1 C-Win
ON LEAVE OF fi_ac1 IN FRAME DEFAULT-FRAME
DO:
    fi_ac1 = INPUT fi_ac1.
    
/*p---------------------------------------------------*/
 IF fi_ac1 <> "" THEN DO:
      FIND /*FIRST*/ xmm600 WHERE xmm600.acno = fi_ac1 NO-LOCK NO-ERROR.  /*NO-WAIT.--- A65-0021 ---*/
      IF AVAIL xmm600 THEN DISP fi_ac1 xmm600.NAME @ fi_GrpDesc WITH FRAME {&FRAME-NAME}.
      ELSE DO:      
          MESSAGE "Group Statement Code not found in Master file XMM600".
          DISP   fi_ac1 "Not found Group Statement" @ fi_GrpDesc WITH FRAME {&FRAME-NAME}.
          APPLY "Entry" To fi_ac1 IN FRAME {&FRAME-NAME}.
          RETURN NO-APPLY.             
      END. /*not in xmm600*/      
  END. /*<> */                                                   
/*---------------------------------------------------p*/

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_GrpDesc
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_GrpDesc C-Win
ON LEAVE OF fi_GrpDesc IN FRAME DEFAULT-FRAME
DO:
    fi_ac1 = INPUT fi_ac1.
    
/*p---------------------------------------------------*/
 IF fi_ac1 <> '' THEN DO:
      FIND /*FIRST*/ xmm600 WHERE  xmm600.acno = fi_ac1 NO-LOCK NO-ERROR. /* NO-WAIT. --- A65-0021 ---*/
      IF AVAIL xmm600 THEN DISP fi_ac1 WITH FRAME {&FRAME-NAME}.
      ELSE DO:      
          MESSAGE "Group Statement Code not found in Master file XMM600".
          DISP   fi_ac1  WITH FRAME {&FRAME-NAME}.
          APPLY "Entry" To fi_ac1 IN FRAME {&FRAME-NAME}.
          RETURN NO-APPLY.             
      END. /*not in xmm600*/      
  END. /*<> */                                                   
/*---------------------------------------------------p*/

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_TrnDatF
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_TrnDatF C-Win
ON LEAVE OF fi_TrnDatF IN FRAME DEFAULT-FRAME
DO:
    fi_TrnDatF = input fi_TrnDatF.
    n_TrnDatF = fi_TrnDatF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_TrnDatT
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_TrnDatT C-Win
ON LEAVE OF fi_TrnDatT IN FRAME DEFAULT-FRAME
DO:
   fi_TrnDatT = input fi_TrnDatT.
   n_TrnDatT = fi_TrnDatT.
   
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ra_type
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_type C-Win
ON VALUE-CHANGED OF ra_type IN FRAME DEFAULT-FRAME
DO:
    ASSIGN
        ra_type = INPUT ra_type
        n_type = ra_type.

    IF n_type = 1 THEN DO:
        APPLY "ENTRY" TO fi_TrnDatF IN FRAME {&FRAME-NAME}.
        RETURN NO-APPLY.
    END.

    DISP ra_type WITH FRAME {&FRAME-NAME}.

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
  
  gv_prgid = "WacTAS6".
  gv_prog  = "Statement Thai Auto Sales".
  RUN  WUT\WUTHEAD (c-win:handle,gv_prgid,gv_prog).
/*********************************************************************/

   SESSION:DATA-ENTRY-RETURN = YES.
   RECT-1:MOVE-TO-TOP( ).  
   RECT-2:MOVE-TO-TOP( ).
   RECT-3:MOVE-TO-TOP( ).
   RECT-4:MOVE-TO-TOP( ).
   
   cbAsdat = vAcProc_fil.

   /*------------------------*/
   RUN pdAcproc_fil.
   /*------------------------*/
   
   ASSIGN
      fibranch      = "0"
      fibranch2     = "Z"
      n_branch      = fibranch
      n_branch2     = fibranch2
      fi_process    = ""
      n_TrnDatF     = ?
      n_TrnDatT     = ?
      n_OutputFile1 = ""
      nv_exportdat  = TODAY
      fi_TrnDatF    = TODAY  
      fi_TrnDatT    = TODAY  
      ra_type       = 1      
      n_type        = 1
      fiFile-Name1  = "D:\TEMP\StatmentTAS"
      n_asdat       =  DATE(cbAsdat). 

   fibdes  = fuFindBranch(fibranch).
   fibdes2 = fuFindBranch(fibranch2).

   DISP fibranch fibranch2 fibdes fibdes2 fi_process fi_TrnDatF fi_TrnDatT fiFile-Name1  WITH FRAME {&FRAME-NAME}.

   /****************/

   fi_ac1   = 'A0M2001'.
   DISP fi_ac1 WITH FRAME {&FRAME-NAME}.
      
/****************/

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
  DISPLAY fiBranch fiBranch2 fi_ac1 cbAsDat ra_type fi_TrnDatF fi_TrnDatT 
          fiFile-Name1 fibdes fibdes2 fi_process fi_GrpDesc 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE fiBranch buBranch fiBranch2 buBranch2 fi_ac1 cbAsDat ra_type 
         fi_TrnDatF fi_TrnDatT fiFile-Name1 Btn_OK Btn_Exit Btn_convert fibdes 
         fibdes2 fi_process fi_GrpDesc RECT-1 RECT-2 RECT-3 RECT-4 RECT-5 
         RECT-6 RECT-7 RECT-8 RECT-9 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdAcproc_fil C-Win 
PROCEDURE pdAcproc_fil :
/*------------------------------------------------------------------------------
  Purpose:     pdAcproc_fil
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    DO WITH FRAME {&FRAME-NAME} :
        
        vAcProc_fil = "" .
        
        FOR EACH Acproc_fil NO-LOCK WHERE 
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdAppendComp C-Win 
PROCEDURE pdAppendComp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* modify  by   : Kridtiya i. :  01/06/2010 */
/* copy program : wac\wactas1.i  หา  append or Compulsory  Policy No. */
    FOR EACH vehreg72:   DELETE  vehreg72.   END.
    
    FIND FIRST uwm301 USE-INDEX uwm30101 WHERE
               uwm301.policy = uwm100.policy AND
               uwm301.rencnt = uwm100.rencnt AND
               uwm301.endcnt = uwm100.endcnt NO-LOCK NO-ERROR NO-WAIT.
    IF NOT AVAILABLE uwm301 THEN NEXT.
    
    FIND /*FIRST*/ uwm130 USE-INDEX uwm13001 WHERE
               uwm130.policy = uwm301.policy AND
               uwm130.rencnt = uwm301.rencnt AND
               uwm130.endcnt = uwm301.endcnt AND
               uwm130.riskgp = uwm301.riskgp AND
               uwm130.riskno = uwm301.riskno AND
               uwm130.itemno = uwm301.itemno NO-LOCK NO-ERROR NO-WAIT.
    IF NOT AVAILABLE uwm130 THEN NEXT.
    
    ASSIGN n_pol = ""
           n_ren = 0
           n_end = 0
           n_poltype = "".
    
    IF uwm100.poltyp = "V70" THEN n_poltype = "72".
                             ELSE n_poltype = "70".
    
    IF uwm130.uom8_v <> 0 AND uwm130.uom9_v <> 0 AND uwm100.poltyp = "V70" THEN DO:
        ASSIGN 
        nv_pol72 = ''
        nv_pol72 = uwm130.policy + '(' + uwm100.trty11 + uwm100.docno1 + ')'.
    END.
    ELSE DO:
        IF uwm100.cr_2 = "" THEN DO:
    
            FOR EACH Buwm301 USE-INDEX uwm30102 WHERE
                     Buwm301.policy <> uwm301.policy AND
                     Buwm301.vehreg  = uwm301.vehreg, 
                FIRST bwagtprm_fil WHERE bwagtprm_fil.vehreg = uwm301.vehreg NO-LOCK:           /* DM7245123456*/
    
                IF SUBSTRING(Buwm301.policy,3,2) = n_poltype THEN DO:  /* uwm100 */
    
                    FIND /*FIRST*/ Buwm_v72 USE-INDEX uwm10001 WHERE
                               Buwm_v72.policy = Buwm301.policy AND
                               Buwm_v72.rencnt = Buwm301.rencnt AND
                               Buwm_v72.endcnt = Buwm301.endcnt NO-LOCK NO-ERROR NO-WAIT.
                    IF NOT AVAILABLE Buwm_v72 THEN NEXT. 
    
                    IF Buwm_v72.expdat >= uwm100.comdat THEN DO:
    
                        FIND FIRST vehreg72 WHERE
                                   vehreg72.vehreg = Buwm301.vehreg NO-ERROR NO-WAIT.
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
                                vehreg72.sticker = Buwm301.sckno
                                n_pol = Buwm301.policy
                                n_ren = Buwm301.rencnt
                                n_end = Buwm301.endcnt. 
                        END.
                        ELSE DO:  /* ONLY BY 72
                                  72comdat = 01/01/2001  72expdat = 01/01/2002
                                  72comdat = 01/01/2001  72expdat = 01/01/2002 */
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
                            END. /* else IF vehreg72.expdat <= Buwm_v72.expdat */
                        END.  /* not avail vehreg72  */
                    END.  /*IF Buwm_v72.expdat >= uwm100.comdat */
                END. /* IF SUBSTRING(Buwm301.policy,3,2) = "72" */
            END. /* for eachBuwm301*/   /*2*/
    
            FIND /*FIRST*/ Buwm_v72 USE-INDEX uwm10001 WHERE
                       Buwm_v72.policy = n_pol AND
                       Buwm_v72.rencnt = n_ren AND
                       Buwm_v72.endcnt = n_end NO-LOCK NO-ERROR NO-WAIT.
            IF AVAILABLE Buwm_v72 THEN DO:
    
                FIND LAST bwagtprm_fil WHERE 
                          bwagtprm_fil.policy = Buwm_v72.policy AND
                   SUBSTR(bwagtprm_fil.policy,7,1) <> "T" NO-LOCK NO-WAIT NO-ERROR .
                IF NOT AVAIL bwagtprm_fil  THEN nv_pol72  = "".
                                           ELSE nv_pol72  = bwagtprm_fil.policy. 
            END.
        END.      /*IF uwm100.cr_2 = "" */
        ELSE DO:  /* uwm100.cr_2 <> ""  */
    
            FIND FIRST Buwm_v72 USE-INDEX uwm10001 WHERE Buwm_v72.policy = uwm100.cr_2 NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL Buwm_v72 THEN DO:
                FIND LAST bwagtprm_fil WHERE 
                          bwagtprm_fil.policy = Buwm_v72.policy AND
                   SUBSTR(bwagtprm_fil.policy,7,1) <> "T" NO-LOCK NO-WAIT NO-ERROR .
                IF NOT AVAIL bwagtprm_fil  THEN nv_pol72  = "".
                                           ELSE nv_pol72  = bwagtprm_fil.policy. 
            END.
            ELSE DO:
    
               FOR EACH Buwm301 USE-INDEX uwm30102 WHERE
                        Buwm301.policy <> uwm301.policy   AND
                        Buwm301.vehreg = uwm301.vehreg    NO-LOCK:          /* DM7245123456*/
                  IF SUBSTRING(Buwm301.policy,3,2) = n_poltype THEN DO:    /* uwm100 */
                     FIND /*FIRST*/ Buwm_v72 USE-INDEX uwm10001 WHERE
                                Buwm_v72.policy = Buwm301.policy AND
                                Buwm_v72.rencnt = Buwm301.rencnt AND
                                Buwm_v72.endcnt = Buwm301.endcnt NO-LOCK NO-ERROR NO-WAIT.
                     IF NOT AVAILABLE Buwm_v72 THEN NEXT.  
                     IF Buwm_v72.expdat >= uwm100.comdat THEN DO:   
                         FIND FIRST vehreg72 WHERE
                                    vehreg72.vehreg = Buwm301.vehreg NO-ERROR NO-WAIT.
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
                         ELSE DO:  /*  ONLY BY 72
                                 72comdat = 01/01/2001  72expdat = 01/01/2002
                                 72comdat = 01/01/2001  72expdat = 01/01/2002  */
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

                                   IF Buwm301.sckno <> 0 THEN vehreg72.sticker = Buwm301.sckno.
                               END.
                            END.  /* else IF vehreg72.expdat <= Buwm_v72.expdat */
                         END.  /* not avail vehreg72  */
                     END.  /*IF Buwm_v72.expdat >= uwm100.comdat */
                  END.  /* IF SUBSTRING(Buwm301.policy,3,2) = "72" */
               END.  /* for eachBuwm301*/  /*2*/
               FIND /*FIRST*/ Buwm_v72 WHERE
                          Buwm_v72.policy = vehreg72.policy AND
                          Buwm_v72.rencnt = vehreg72.rencnt AND
                          Buwm_v72.endcnt = vehreg72.endcnt NO-LOCK NO-ERROR NO-WAIT.
               IF AVAILABLE Buwm_v72 THEN DO:
                   FIND LAST bwagtprm_fil WHERE 
                             bwagtprm_fil.policy = Buwm_v72.policy  AND
                      SUBSTR(bwagtprm_fil.policy,7,1) <> "T" NO-LOCK NO-WAIT NO-ERROR .
                   IF NOT AVAIL bwagtprm_fil  THEN nv_pol72  = "".
                                              ELSE nv_pol72  = bwagtprm_fil.policy. 
               END.   /* IF AVAILABLE Buwm_v72 */  
            END.
        END.  /* uwm100.opnpol <> "" */
    END.      /* not (uwm130.uom8_v <> 0 AND uwm130.uom9_v <> 0) */
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdOutPrmByPolNo C-Win 
PROCEDURE pdOutPrmByPolNo :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
def var nv_wgrossprem      as deci.
def var nv_wCompGrossPrem  as deci.
def var nv_wNetPrem        as deci.
def var nv_wCompNetPrem    as deci.
def var nv_wtax            as deci.
def var nv_wNetPayment     as deci.

OUTPUT  TO VALUE(nv_PutPol).
    EXPORT DELIMITER "|"
        /*"Safety Insurance Public Company Limited "*/
        "Tokio Marine Safety Insurance (Thailand) Public Company Limited"
        STRING(TODAY,"99999999") 
        STRING(n_asdat,"99999999") SKIP.

    EXPORT DELIMITER "|"
        "head"                                   
        "Insure_Name"
        "TransectionDate"
        "Policy_Main"
        "EndorsementNo"
        "Policy"
        "Policy(V72)"
        "Engine"
        "Chassis"                                
        "Contract"                               
        "Engcc"                                  
        "Comdat"                                 
        "Grossprem"                              
        "CompGrossPrem"                          
        "NetPrem"                                
        "CompNetPrem"                            
        "Tax"                                    
        "NetPayment"
        "Status"
        "Vat_Name"
        "Vat_Code"
        "Producer"                                    
        "Brand_Model"  . 

    nv_cnt = 0.

    loop1:     
    FOR EACH wBill  USE-INDEX wBill02 NO-LOCK WHERE
             wBill.wcomdat >= n_TrnDatF   
        BREAK BY wBill.wPolicy :  

        /* Calculate Total Premium by Policy No. */
        IF FIRST-OF (wBill.wPolicy) THEN DO:
            ASSIGN
              nv_wgrossprem     = 0
              nv_wCompGrossPrem = 0
              nv_wNetPrem       = 0
              nv_wCompNetPrem   = 0
              nv_wtax           = 0
              nv_wNetPayment    = 0.

            ASSIGN
              nv_wgrossprem     =  nv_wgrossprem     + wBill.wgrossprem     
              nv_wCompGrossPrem =  nv_wCompGrossPrem + wBill.wCompGrossPrem 
              nv_wNetPrem       =  nv_wNetPrem       + wBill.wNetPrem       
              nv_wCompNetPrem   =  nv_wCompNetPrem   + wBill.wCompNetPrem   
              nv_wtax           =  nv_wtax           + wBill.wtax           
              nv_wNetPayment    =  nv_wNetPayment    + wBill.wNetPayment  .
        END.
        ELSE DO:
            ASSIGN
              nv_wgrossprem     =  nv_wgrossprem     + wBill.wgrossprem     
              nv_wCompGrossPrem =  nv_wCompGrossPrem + wBill.wCompGrossPrem 
              nv_wNetPrem       =  nv_wNetPrem       + wBill.wNetPrem       
              nv_wCompNetPrem   =  nv_wCompNetPrem   + wBill.wCompNetPrem   
              nv_wtax           =  nv_wtax           + wBill.wtax           
              nv_wNetPayment    =  nv_wNetPayment    + wBill.wNetPayment  .
        END.

        /* ถึง record สุดท้ายของแต่ละ Policy No. ให้ Create */
        IF LAST-OF (wBill.wPolicy) THEN DO:

            nv_cnt = nv_cnt + 1.

            /*------------ create data to table wBill -----------*/
            FIND FIRST w2Bill USE-INDEX  w2Bill01     WHERE
                       w2Bill.wAcno   = wBill.wAcno    AND
                       w2Bill.wPolicy = wBill.wPolicy  AND
                       w2Bill.wEndno  = wBill.wEndno   AND
                       w2Bill.wtrnty1 = wBill.wtrnty1  AND
                       w2Bill.wtrnty2 = wBill.wtrnty2  AND
                       w2Bill.wdocno  = wBill.wdocno   NO-LOCK NO-ERROR NO-WAIT.
            IF NOT AVAIL w2Bill THEN DO:
            
                CREATE w2Bill.                    
                ASSIGN 
                  w2Bill.wpolicy        = wBill.wpolicy       
                  w2Bill.wacno          = wBill.wacno         
                  w2Bill.wnorpol        = wBill.wnorpol       
                  w2Bill.wpol72         = wBill.wpol72        
                  w2Bill.winsure        = wBill.winsure       
                  w2Bill.wcha_no        = wBill.wcha_no       
                  w2Bill.wengine        = wBill.wengine       
                  w2Bill.wVehreg        = wBill.wVehreg       
                  w2Bill.wbrandmodel    = wBill.wbrandmodel   
                  w2Bill.wcomdat        = wBill.wcomdat       
                  w2Bill.wGrossPrem     = nv_wGrossPrem     
                  w2Bill.wCompGrossPrem = nv_wCompGrossPrem 
                  w2Bill.wNetPrem       = nv_wNetPrem       
                  w2Bill.wCompNetPrem   = nv_wCompNetPrem   
                  w2Bill.wTax           = nv_wTax           
                  w2Bill.wNetPayment    = nv_wNetPayment    
                  w2Bill.wasdat         = wBill.wasdat      
                  w2Bill.wtrnty1        = wBill.wtrnty1       
                  w2Bill.wtrnty2        = wBill.wtrnty2       
                  w2Bill.wdocno         = wBill.wdocno        
                  w2Bill.wendno         = wBill.wendno        
                  w2Bill.wtrndat1       = wBill.wtrndat1      
                  w2Bill.wpoltyp        = wBill.wpoltyp       
                  w2Bill.wbal           = wBill.wbal          
                  w2Bill.wcontract      = wBill.wcontract     
                  w2Bill.wname2         = wBill.wname2        
                  w2Bill.wvatcode       = wBill.wvatcode . 

            EXPORT DELIMITER "|"
                "D"                                   
                wBill.winsure   
                wBill.wTrndat1
                wBill.wpolicy 
                wBill.wendno
                wBill.wnorpol 
                wBill.wpol72
                wBill.wengine
                wBill.wcha_no 
                wBill.wcontract
                wBill.wVehreg  
                wBill.wcomdat                         
                nv_wgrossprem       /*fuDeciToChar(nv_wgrossprem,10)     */
                nv_wCompGrossPrem   /*fuDeciToChar(nv_wCompGrossPrem,10) */
                nv_wNetPrem         /*fuDeciToChar(nv_wNetPrem,10)       */
                nv_wCompNetPrem     /*fuDeciToChar(nv_wCompNetPrem,10)   */
                nv_wtax             /*fuDeciToChar(nv_wtax,10)           */
                nv_wNetPayment      /*fuDeciToChar(nv_wNetPayment,10)    */
                ""
                wBill.wname2     
                wBill.wvatcode   
                wBill.wacno       
                wBill.wbrandmodel.
            END.
        END.
    END.  /* for each wbill */

    EXPORT DELIMITER "|"
        "T"    
        nv_cnt
        "Record"
        vCountRec
        "Transection".

OUTPUT CLOSE.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdProc1 C-Win 
PROCEDURE pdProc1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

FOR EACH wBill: DELETE  wBill. END.

ASSIGN
  nv_exportdat = TODAY
  nv_exporttim = STRING(TIME,"HH:MM:SS")
  vCountRec    = 0.

OUTPUT TO D:\TEMP\WACTAS6.TXT .
      PUT TODAY FORMAT "99/99/9999" " " STRING(TIME,"HH:MM:SS") SKIP
          "asdat|acno|policy|norpol|pol72|insure|cha_no|comdat|netprem|compnetprem|grossprem|compgrossprem|tax|NetPayment|
           trnty1|trnty2|docno|endno|trndat|poltyp|bal|contract|name2|vatcode|engine|Vehreg|brandmodel" 
      SKIP.
OUTPUT CLOSE.

LOOP_MAIN:
FOR EACH  agtprm_fil USE-INDEX by_acno       WHERE
          agtprm_fil.asdat        = n_asdat                                             AND
  (LOOKUP(agtprm_fil.acno,nv_acnoAll) <> 0 )                                            AND
         (agtprm_fil.poltyp       = "V70"    OR  agtprm_fil.poltyp        = "V72")      AND 
         (agtprm_fil.TYPE         = "01"     OR  agtprm_fil.TYPE          = "05")       AND /* 01 = Monthly , 05 = Daily */
         (agtprm_fil.trntyp  BEGINS 'M'      OR  agtprm_fil.trntyp   BEGINS "R")        AND /* M = เบี้ย + , R = เบี้ย - */
         (agtprm_fil.polbran     >= n_branch AND agtprm_fil.polbran      <= n_branch2 ) AND 
          agtprm_fil.bal         <>  0       /* ทั้งเบี้ย + และ - */ NO-LOCK:
    
    IF agtprm_fil.trndat       < n_TrnDatF     THEN NEXT loop_main.
    IF agtprm_fil.trndat       > n_TrnDatT     THEN NEXT loop_main.
    
    IF agtprm_fil.prem + agtprm_fil.prem_comp = 0 THEN NEXT loop_main.  /* เบี้ยเป็น 0 แต่ยังค้างค่า comm. bal <> 0 */
    
    ASSIGN
      nv_pol72      = ""     nv_norpol   = ""
      nv_insure     = ""     nv_vehreg   = ""
      nv_engine     = ""     nv_cha_no   = ""
      nv_grossPrem  = 0      nv_grossPrem_comp = 0  nv_cedpol     = ""
      nv_netPrem    = 0      nv_netPrem_comp   = 0  nv_name2      = ""
      nv_tax        = 0      nv_netPayment     = 0  nv_vatcode    = ""
      vStamp        = 0      vStamp_comp       = 0  nv_brandmol   = ""
      vVat          = 0      vVat_comp         = 0  nv_endno      = "".

    DISPLAY  "Process : " + agtprm_fil.policy + '   ' + agtprm_fil.trntyp + '  ' + agtprm_fil.docno  @ fi_Process WITH FRAME {&FRAME-NAME}.
    PAUSE 0.

    ASSIGN
        nv_netPrem      = agtprm_fil.prem
        nv_netPrem_comp = agtprm_fil.prem_comp .

    IF (SUBSTR(agtprm_fil.policy,3,2) = "70" ) THEN  nv_norpol = agtprm_fil.policy + '(' + SUBSTR(agtprm_fil.trntyp,1,1) + agtprm_fil.docno + ')'.
                                               ELSE  nv_pol72  = agtprm_fil.policy + '(' + SUBSTR(agtprm_fil.trntyp,1,1) + agtprm_fil.docno + ')'.

    FIND FIRST uwm100 USE-INDEX uwm10001 WHERE         
               uwm100.policy = agtprm_fil.policy  AND  
               uwm100.endno  = agtprm_fil.endno   AND  
               uwm100.docno1 = agtprm_fil.docno   NO-LOCK NO-ERROR.
    IF AVAIL uwm100 THEN DO:

        RUN pdwh1.   /* calculate tax 1% of V70 (หา n_wh1) */

        n_wh1 = IF n_wh1 < 0 THEN 0 ELSE n_wh1. 

        y1    = 0.
        z1    = 0.
        FOR EACH acd001 USE-INDEX acd00191 WHERE
                 acd001.trnty1 = SUBSTR(agtprm_fil.trntyp,1,1) AND
                 acd001.docno  = agtprm_fil.docno              NO-LOCK:

            IF acd001.ctrty1 = 'y' THEN y1 = - (acd001.netloc).
            IF acd001.ctrty1 = 'z' THEN z1 = - (acd001.netloc).
        END.

        /* bal  -  (รายการที่ตัดเบี้ยไปแล้วเหลือ <= ภาษี 1 % */
        IF agtprm_fil.bal - (y1 + z1) <= n_wh1 THEN NEXT loop_main.

        /* เบี้ย 70 รวม พรบ.(72) -- ต้องถอยหา Stamp , Tax ของเบี้ย พรบ. */
        IF (nv_netPrem <> 0   AND nv_netPrem_comp <> 0 ) THEN DO:
            ASSIGN
               vStamp_comp       = IF (nv_netPrem_comp * 0.004 ) - TRUNCATE( (nv_netPrem_comp * 0.004 ),0) > 0 THEN TRUNCATE( (nv_netPrem_comp * 0.004 ),0) + 1 /* มีทศนิยม  ปัดเศษ + 1 */
                                                                                                               ELSE TRUNCATE( (nv_netPrem_comp * 0.004 ),0)    /* ไม่มีทศนิยม */
               vVat_comp         = (nv_netPrem_comp + vStamp_comp) * 0.07
               vStamp            = agtprm_fil.stamp - vStamp_comp
               vVat              = agtprm_fil.tax   - vVat_comp.
        END.
        ELSE DO: /* กรณีที่คีย์ 70 และ 72 แยกกัน  , 
                   เบี้ยก็จะแยกกัน -- ไม่ต้องคำนวณใหม่ ใช้ Stamp , Tax จากข้อมูล agtprm_fil ได้เลย*/
            /* เบี้ย 70 */
            IF nv_netPrem <> 0 THEN 
                ASSIGN
                  vStamp            = agtprm_fil.stamp
                  vVat              = agtprm_fil.tax.  
            /* เบี้ย พรบ.(72) */
            ELSE 
               ASSIGN
                  vStamp_comp       = agtprm_fil.stamp
                  vVat_comp         = agtprm_fil.tax.  
        END.

        ASSIGN
            nv_grossPrem_comp = nv_netprem_comp + vStamp_comp  + vVat_comp
            nv_grossPrem      = nv_netprem + vStamp + vVat.

        /*i*/
        IF (SUBSTR(agtprm_fil.policy,3,2) = "70" ) THEN DO:
            nv_pol72 = "".

            RUN pdAppendComp.   
            
            FIND FIRST Bagtprm_fil USE-INDEX by_acno WHERE
                       Bagtprm_fil.asdat  = agtprm_fil.asdat AND  /* วันที่ statement process */
                       Bagtprm_fil.acno   = agtprm_fil.acno  AND
                       Bagtprm_fil.poltyp = "V72"        AND
                       Bagtprm_fil.policy = SUBSTR(nv_pol72,1,12) NO-LOCK NO-ERROR.
            IF AVAIL Bagtprm_fil THEN DO:

                nv_grossPrem_comp = nv_grossPrem_comp + agtprm_fil.gross.
            
                IF n_wh1 <> 0 THEN n_wh1 = n_wh1 + (agtprm_fil.prem_comp + agtprm_fil.stamp) * 0.01.
                
            END.
        END.
        /*end i*/

        /* ii */
        /* อ้างอิงข้อมูลสลักหลังล่าสุดที่ release = Yes */
        FIND LAST uwm100 USE-INDEX uwm10001 WHERE         
                  uwm100.policy = agtprm_fil.policy  AND
                  uwm100.relea  = YES    NO-LOCK NO-ERROR.
        IF AVAIL  uwm100 THEN 
            ASSIGN 
                nv_endno   =  uwm100.endno
                nv_comdat  =  uwm100.comdat
                nv_cedpol  =  uwm100.cedpol
                nv_name2   =  uwm100.name2  
                nv_vatcode =  uwm100.bs_cd
                nv_insure  = (uwm100.ntitle) + " " + (uwm100.name1).

        FIND FIRST uwm301 USE-INDEX uwm30101      WHERE
                   uwm301.policy = uwm100.policy  AND
                   uwm301.rencnt = uwm100.rencnt  AND
                   uwm301.endcnt = uwm100.endcnt  NO-LOCK NO-ERROR. /* NO-WAIT. -- A65-0021 --*/
        IF AVAIL uwm301 THEN DO:
            ASSIGN        
                nv_vehreg   = uwm301.vehreg
                nv_engine   = uwm301.eng_no
                nv_cha_no   = uwm301.cha_no  
                nv_brandmol = uwm301.moddes .
        END.

        IF nv_insure = "" THEN nv_insure = agtprm_fil.insure.
        IF nv_vehreg = "" THEN nv_vehreg = agtprm_fil.vehreg.
        /* end ii */
        
        IF (SUBSTR(nv_vehreg,1,1) <> "/") THEN nv_vehreg = nv_vehreg.     /* รถเก่า  มีเลขทะเบียน */
        ELSE DO:   /* รถใหม่ ไม่มีทะเบียนรถ */
            IF nv_engine <> "" THEN nv_vehreg = nv_engine.   /* เลขเครื่องยนต์ <> ""  then นำเลขเครื่องยนต์มาใส่ที่ทะเบียนรถ*/
            ELSE nv_vehreg = SUBSTR(nv_vehreg, 1 ,LENGTH(nv_vehreg)).  /* ถ้าเลขเครื่องยนต์ = "" ตัด "/" */
        END.

        IF SUBSTR(nv_vehreg,1,1) <> '/' THEN DO:
            RUN pdveh (INPUT-OUTPUT nv_vehreg ,
                       INPUT-OUTPUT engc).
        END.
        ELSE DO:
            IF nv_vehreg <> '' THEN DO:
                nv_eng  = SUBSTR(nv_vehreg,2,LENGTH(nv_vehreg)).
                RUN pdVehNew (INPUT-OUTPUT nv_eng,
                              INPUT-OUTPUT nv_char).
                engc    = nv_char.
                nv_eng  = ''.
                nv_char = ''.
            END.
            ELSE engc   = ''.
        END.

        /*------------ create data to table wBill -----------*/
        FIND FIRST wBill USE-INDEX  wBill01     WHERE
                   wBill.wAcno   =        agtprm_fil.acno        AND
                   wBill.wPolicy =        agtprm_fil.policy      AND
                   wBill.wEndno  =        agtprm_fil.endno       AND
                   wBill.wtrnty1 = SUBSTR(agtprm_fil.trnty,1,1)  AND
                   wBill.wtrnty2 = SUBSTR(agtprm_fil.trnty,2,1)  AND
                   wBill.wdocno  =        agtprm_fil.docno       NO-LOCK NO-ERROR. /* NO-WAIT.-- A65-0021 -*/
        IF NOT AVAIL wBill THEN DO:

            vCountRec = vCountRec + 1.
            
            DISPLAY "Create data to Table wBill ..."  @ fi_Process  WITH FRAME {&FRAME-NAME}.
            PAUSE 0.

            CREATE wBill.
            ASSIGN wBill.wacno          = agtprm_fil.acno   /*Account Code      */  
                   wBill.wpolicy        = agtprm_fil.policy /*Policy No.        */  
                   wBill.wnorpol        = nv_norpol         /*Normal Policy no. */  
                   wBill.wpol72         = nv_pol72          /*Compulsory Policy */  
                   wBill.winsure        = nv_insure         /*Customer name     */  
                   wBill.wcha_no        = nv_cha_no         /*หมายเลขตัวถังรถ   */  
                   wBill.wengine        = nv_engine         /*หมายเลขเครื่องยนต์*/  
                   wBill.wVehreg        = engc              /*หมายเลขทะเบียน    */  
                   wBill.wbrandmodel    = nv_brandmol
                   wBill.wcomdat        = nv_comdat         /*agtprm_fil.comdat */
                   wBill.wnetprem       = nv_NetPrem        /*Net Premium เบี้ยหลัก    = เบี้ยรวม - VAT - Stamp      deci-2 >>,>>>,>>9.99-*/
                   wBill.wcompnetprem   = nv_NetPrem_comp   /*Net Premium พรบ.         = เบี้ยรวมพรบ. - VAT - Stamp  deci-2 >>,>>>,>>9.99-*/
                   wBill.wgrossprem     = nv_GrossPrem      /*Normal Gross Premium     = เบี้ย70 + VAT + STAMP       deci-2 >>,>>>,>>9.99-*/
                   wBill.wcompgrossprem = nv_GrossPrem_comp /*Compulsory Gross Premium = เบี้ย72 + VAT + STAMP       deci-2 >>,>>>,>>9.99-*/
                   wBill.wtax           = n_wh1             /*w/h Tax1%    (NetPrem + NetPrem_comp + stamp รวม) * 1% ถ้าเป็นการ คืนเงิน  w/h = 0*/
                   wBill.wNetPayment    = nv_GrossPrem + nv_GrossPrem_comp - n_wh1  /*26 [ 19 - w/h Tax 1 %  deci-2 >>,>>>,>>9.99-*/
                   wBill.wasdat         = agtprm_fil.asdat
                   wBill.wtrnty1        = SUBSTR(agtprm_fil.trntyp,1,1)
                   wBill.wtrnty2        = SUBSTR(agtprm_fil.trntyp,2,1)
                   wBill.wdocno         = agtprm_fil.docno
                   wBill.wendno         = nv_endno                          /*agtprm_fil.endno*/
                   wBill.wtrndat1       = agtprm_fil.trndat
                   wBill.wpoltyp        = agtprm_fil.poltyp
                   wBill.wbal           = agtprm_fil.bal
                   wBill.wcontract      = nv_cedpol 
                   wBill.wname2         = nv_name2    /* A59-0362 */
                   wBill.wvatcode       = nv_vatcode. /* A59-0362 */


      /* A65-0021 ----------
        OUTPUT TO c:\temp\WACTAS6.TXT APPEND.
        PUT   STRING(wBill.wasdat)         "|"
              wBill.wacno                  "|"
              wBill.wpolicy    FORMAT "X(20)"     "|"
              wBill.wnorpol    FORMAT "X(20)"     "|"
              wBill.wpol72     FORMAT "X(20)"     "|"
              wBill.winsure                "|"
              wBill.wcha_no                "|"
              STRING(wBill.wcomdat)        "|"
              STRING(wBill.wnetprem)       "|"
              STRING(wBill.wcompnetprem)   "|"
              STRING(wBill.wgrossprem)     "|"
              STRING(wBill.wcompgrossprem) "|"
              STRING(wBill.wtax)           "|"
              STRING(wBill.wNetPayment)    "|"
              wBill.wtrnty1                "|"
              wBill.wtrnty2                "|"
              wBill.wdocno                 "|"
              wBill.wendno                 "|"
              STRING(wBill.wtrndat1)       "|"
              wBill.wpoltyp                "|"
              STRING(wBill.wbal)           "|"
              wBill.wcontract              "|"
              wBill.wname2                 "|"
              wBill.wvatcode               "|" 
              wBill.wengine                "|"
              wBill.wVehreg                "|"
              wBill.wbrandmodel            "|"     
        SKIP.                           
        OUTPUT CLOSE.*/ 
            
            OUTPUT TO D:\TEMP\WACTAS6.TXT APPEND.
            PUT   STRING(agtprm_fil.asdat)         "|"
                  agtprm_fil.acno                  "|"
                  agtprm_fil.policy FORMAT "X(20)" "|"
                  nv_norpol         FORMAT "X(20)" "|"
                  nv_pol72          FORMAT "X(20)" "|"
                  nv_insure                     "|"
                  nv_cha_no                     "|"
                  STRING(nv_comdat)             "|"
                  STRING(nv_NetPrem )           "|" 
                  STRING(nv_NetPrem_comp  )     "|" 
                  STRING(nv_GrossPrem     )     "|" 
                  STRING(nv_GrossPrem_comp)     "|" 
                  STRING(n_wh1)                 "|"
                  STRING(nv_GrossPrem + nv_GrossPrem_comp - n_wh1 )    "|"
                  SUBSTR(agtprm_fil.trntyp,1,1) "|" 
                  SUBSTR(agtprm_fil.trntyp,2,1) "|" 
                  agtprm_fil.docno   "|" 
                  nv_endno           "|" 
                  agtprm_fil.trndat  "|"
                  agtprm_fil.poltyp  "|"
                  agtprm_fil.bal     "|"
                  nv_cedpol          "|"
                  nv_name2           "|"
                  nv_vatcode         "|" 
                  nv_engine          "|"
                  engc               "|"
                  nv_brandmol        "|"     
            SKIP.                           
            OUTPUT CLOSE.
            /* A65-0021 */

            DISPLAY "-"  @ fi_Process  WITH FRAME {&FRAME-NAME}.
            PAUSE 0.

        END.  /* find first wBill */
    END.   /* avail  uwm100 */
END.   /* for each agtprm_fil */
/*END.    /* wfAcno */*/

IF vCountRec = 0 THEN DO:
    MESSAGE "ไม่พบข้อมูล ที่จะส่งออก" VIEW-AS ALERT-BOX INFORMATION.
    RETURN NO-APPLY.
END.
/* RELEASE Billing. */
RELEASE acProc_fil.
/*=======================End of Include File =============================*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdProcChissis C-Win 
PROCEDURE pdProcChissis :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
def var nv_wgrossprem      as deci.
def var nv_wCompGrossPrem  as deci.
def var nv_wNetPrem        as deci.
def var nv_wCompNetPrem    as deci.
def var nv_wtax            as deci.
def var nv_wNetPayment     as deci.
DEF VAR nv_policy70        AS CHAR.
DEF VAR nv_policy72        AS CHAR.

OUTPUT  TO VALUE(nv_PutChas).
    EXPORT DELIMITER "|"
        "head"                                   
        "Insure_Name"
        "TransectionDate"
        "Policy_Main"
        "EndorsementNo"
        "Policy"
        "Policy(V72)"
        "Engine"
        "Chassis"                                
        "Contract"                               
        "Engcc"                                  
        "ComDat"                                 
        "GrossPrem"                              
        "CompGrossPrem"                          
        "NetPrem"                                
        "CompNetPrem"                            
        "Tax"                                    
        "NetPayment"
        "Status"
        "Vat_Name"
        "Vat_Code"
        "Producer"                                    
        "Brand_Model"  . 

    nv_cnt = 0.
    nv_policy70 = "".
    nv_policy72 = "".

    loop1:     
    FOR EACH w2Bill  USE-INDEX w2Bill02 NO-LOCK WHERE
             w2Bill.wcomdat >= n_TrnDatF   
        BREAK BY w2Bill.wCha_no   /* Chassis **/
              BY w2Bill.wComDat   /* ใช้ ComDat ล่าสุด */ 
              BY w2Bill.wPolicy : 

        /* Calculate Total Premium by Chassis */
        IF FIRST-OF (w2Bill.wCha_no) THEN DO:
            ASSIGN
              nv_wgrossprem     = 0
              nv_wCompGrossPrem = 0
              nv_wNetPrem       = 0
              nv_wCompNetPrem   = 0
              nv_wtax           = 0
              nv_wNetPayment    = 0.

            ASSIGN
              nv_wgrossprem     =  nv_wgrossprem     + w2Bill.wgrossprem     
              nv_wNetPrem       =  nv_wNetPrem       + w2Bill.wNetPrem   

              nv_wCompGrossPrem =  nv_wCompGrossPrem + w2Bill.wCompGrossPrem 
              nv_wCompNetPrem   =  nv_wCompNetPrem   + w2Bill.wCompNetPrem   

              nv_wtax           =  nv_wtax           + w2Bill.wtax           
              nv_wNetPayment    =  nv_wNetPayment    + w2Bill.wNetPayment  .
        END.
        ELSE DO:
            ASSIGN
              nv_wgrossprem     =  nv_wgrossprem     + w2Bill.wgrossprem     
              nv_wCompGrossPrem =  nv_wCompGrossPrem + w2Bill.wCompGrossPrem 
              nv_wNetPrem       =  nv_wNetPrem       + w2Bill.wNetPrem       
              nv_wCompNetPrem   =  nv_wCompNetPrem   + w2Bill.wCompNetPrem   
              nv_wtax           =  nv_wtax           + w2Bill.wtax           
              nv_wNetPayment    =  nv_wNetPayment    + w2Bill.wNetPayment  .
        END.

        /* ถ้าเบี้ย V70 = 0 ไม่ต้องแสดงเบอร์กรมธรรม์ 70 */
        IF w2Bill.wNetPrem    <> 0  AND 
           w2Bill.wGrossprem  <> 0  THEN nv_policy70 = w2Bill.wNorPol.
                                        
        /* ถ้าเบี้ย V72 = 0 ไม่ต้องแสดงเบอร์กรมธรรม์ 72 */
        IF w2Bill.wCompNetPrem   <> 0  AND 
           w2Bill.wCompGrossPrem <> 0  THEN nv_policy72 = w2Bill.wpol72.

        /* ถึง record สุดท้ายของแต่ละ Chassis ให้ Create */
        IF LAST-OF (w2Bill.wCha_no) THEN DO:

            nv_cnt = nv_cnt + 1.
            /*------------ create data to table wBill -----------*/
            FIND FIRST w3Bill USE-INDEX  w3Bill01     WHERE
                       w3Bill.wAcno   = w2Bill.wAcno    AND
                       w3Bill.wPolicy = w2Bill.wPolicy  AND
                       w3Bill.wEndno  = w2Bill.wEndno   AND
                       w3Bill.wtrnty1 = w2Bill.wtrnty1  AND
                       w3Bill.wtrnty2 = w2Bill.wtrnty2  AND
                       w3Bill.wdocno  = w2Bill.wdocno   NO-LOCK NO-ERROR NO-WAIT.
            IF NOT AVAIL w3Bill THEN DO:
                CREATE w3Bill.                    
                ASSIGN 
                  w3Bill.wpolicy        = w2Bill.wpolicy       
                  w3Bill.wacno          = w2Bill.wacno         
                  w3Bill.wnorpol        = nv_policy70       
                  w3Bill.wpol72         = nv_policy72       
                  w3Bill.winsure        = w2Bill.winsure       
                  w3Bill.wcha_no        = w2Bill.wcha_no       
                  w3Bill.wengine        = w2Bill.wengine       
                  w3Bill.wVehreg        = w2Bill.wVehreg       
                  w3Bill.wbrandmodel    = w2Bill.wbrandmodel   
                  w3Bill.wcomdat        = w2Bill.wcomdat       
                  w3Bill.wGrossPrem     = nv_wGrossprem    
                  w3Bill.wCompGrossPrem = nv_wCompGrossPrem
                  w3Bill.wNetPrem       = nv_wNetPrem      
                  w3Bill.wCompNetPrem   = nv_wCompNetPrem  
                  w3Bill.wTax           = nv_wTax          
                  w3Bill.wNetPayment    = nv_wNetPayment   
                  w3Bill.wasdat         = w2Bill.wasdat        
                  w3Bill.wtrnty1        = w2Bill.wtrnty1       
                  w3Bill.wtrnty2        = w2Bill.wtrnty2       
                  w3Bill.wdocno         = w2Bill.wdocno        
                  w3Bill.wendno         = w2Bill.wendno        
                  w3Bill.wtrndat1       = w2Bill.wtrndat1      
                  w3Bill.wpoltyp        = w2Bill.wpoltyp       
                  w3Bill.wbal           = w2Bill.wbal          
                  w3Bill.wcontract      = w2Bill.wcontract     
                  w3Bill.wname2         = w2Bill.wname2        
                  w3Bill.wvatcode       = w2Bill.wvatcode . 
            
                EXPORT DELIMITER "|"
                 "D"                                   
                 w2Bill.winsure   
                 w2Bill.wTrndat1
                 w2Bill.wpolicy 
                 w2Bill.wendno
                 nv_policy70      
                 nv_policy72      
                 w2Bill.wengine
                 w2Bill.wcha_no 
                 w2Bill.wcontract
                 w2Bill.wVehreg  
                 w2Bill.wcomdat   
                 nv_wgrossprem    
                 nv_wCompGrossPrem
                 nv_wNetPrem      
                 nv_wCompNetPrem  
                 nv_wtax          
                 nv_wNetPayment   
                 ""
                 w2Bill.wname2     
                 w2Bill.wvatcode   
                 w2Bill.wacno       
                 w2Bill.wbrandmodel.

                /* put data แล้ว clear */
                nv_policy70 = "".
                nv_policy72 = "".
            END.
        END.

    END.  /* for each wbill */
    EXPORT DELIMITER "|"
        "T"    
        nv_cnt
        "Record"
        vCountRec
        "Transection".

OUTPUT CLOSE.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdProcContract C-Win 
PROCEDURE pdProcContract :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
def var nv_wgrossprem      as deci.
def var nv_wCompGrossPrem  as deci.
def var nv_wNetPrem        as deci.
def var nv_wCompNetPrem    as deci.
def var nv_wtax            as deci.
def var nv_wNetPayment     as deci.
DEF VAR nv_policy70        AS CHAR.
DEF VAR nv_policy72        AS CHAR.

OUTPUT  TO VALUE(nv_PutCont).
    EXPORT DELIMITER "|"
       "head"                                   
       "Insure_Name"
       "Policy_Main"
       "Policy"
       "Policy(V72)"
       "Engine"
       "Chassis"                                
       "Contract"                               
       "Engcc"                                  
       "ComDat"                                 
       "GrossPrem"                              
       "CompGrossPrem"                          
       "NetPrem"                                
       "CompNetPrem"                            
       "Tax"                                    
       "NetPayment"
       "Status"
       "Vat_Name"
       "Vat_Code"
       "Producer"                                    
       "Brand_Model"  . 

    nv_cnt = 0.
    nv_policy70 = "".
    nv_policy72 = "".

    loop1:     
    FOR EACH w3Bill  USE-INDEX w3Bill02 NO-LOCK WHERE
             w3Bill.wcomdat >= n_TrnDatF   
        BREAK BY w3Bill.wcontract   /* Contract No */
              BY w3Bill.wComDat : /* ใช้ ComDat ล่าสุด */ 

        IF w3Bill.wcontract = "" THEN DO:  /* ถ้า Contract เป็น Blank ให้ Put Data to File เลย */

            nv_cnt = nv_cnt + 1.
    
            EXPORT DELIMITER "|"
                "D"                                   
                w3Bill.winsure
                w3Bill.wPolicy
                w3Bill.wNorPol
                w3Bill.wpol72
                w3Bill.wengine
                w3Bill.wcha_no 
                w3Bill.wcontract
                w3Bill.wVehreg  
                w3Bill.wcomdat                         
                w3Bill.wGrossprem     
                w3Bill.wCompGrossPrem 
                w3Bill.wNetPrem       
                w3Bill.wCompNetPrem   
                w3Bill.wTax           
                w3Bill.wNetPayment    
                ""
                w3Bill.wname2     
                w3Bill.wvatcode   
                w3Bill.wacno       
                w3Bill.wbrandmodel.

        END.
        ELSE DO:
            /* Calculate Total Premium by Contract No. */
            IF FIRST-OF (w3Bill.wContract) THEN DO:
                ASSIGN
                  nv_wgrossprem     = 0
                  nv_wCompGrossPrem = 0
                  nv_wNetPrem       = 0
                  nv_wCompNetPrem   = 0
                  nv_wtax           = 0
                  nv_wNetPayment    = 0.
    
                ASSIGN
                  nv_wgrossprem     =  nv_wgrossprem     + w3Bill.wgrossprem     
                  nv_wCompGrossPrem =  nv_wCompGrossPrem + w3Bill.wCompGrossPrem 
                  nv_wNetPrem       =  nv_wNetPrem       + w3Bill.wNetPrem       
                  nv_wCompNetPrem   =  nv_wCompNetPrem   + w3Bill.wCompNetPrem   
                  nv_wtax           =  nv_wtax           + w3Bill.wtax           
                  nv_wNetPayment    =  nv_wNetPayment    + w3Bill.wNetPayment  .
            END.
            ELSE DO:
                ASSIGN
                  nv_wgrossprem     =  nv_wgrossprem     + w3Bill.wgrossprem     
                  nv_wCompGrossPrem =  nv_wCompGrossPrem + w3Bill.wCompGrossPrem 
                  nv_wNetPrem       =  nv_wNetPrem       + w3Bill.wNetPrem       
                  nv_wCompNetPrem   =  nv_wCompNetPrem   + w3Bill.wCompNetPrem   
                  nv_wtax           =  nv_wtax           + w3Bill.wtax           
                  nv_wNetPayment    =  nv_wNetPayment    + w3Bill.wNetPayment  .
            END.
    
            /* ถ้าเบี้ย V70 = 0 ไม่ต้องแสดงเบอร์กรมธรรม์ 70 */
            IF w3Bill.wNetPrem    <> 0  AND 
               w3Bill.wGrossprem  <> 0  THEN nv_policy70 = w3Bill.wNorPol.

            /* ถ้าเบี้ย V72 = 0 ไม่ต้องแสดงเบอร์กรมธรรม์ 72 */
            IF w3Bill.wCompNetPrem   <> 0  AND 
               w3Bill.wCompGrossPrem <> 0  THEN nv_policy72 = w3Bill.wpol72.

            /* ถึง record สุดท้ายของแต่ละ Contract ให้ Create */
            IF LAST-OF (w3Bill.wContract) THEN DO:
    
                nv_cnt = nv_cnt + 1.
    
                EXPORT DELIMITER "|"
                   "D"                                   
                   w3Bill.winsure
                   w3Bill.wPolicy
                   nv_policy70
                   nv_policy72
                   w3Bill.wengine
                   w3Bill.wcha_no 
                   w3Bill.wcontract
                   w3Bill.wVehreg  
                   w3Bill.wcomdat                         
                   nv_wgrossprem    
                   nv_wCompGrossPrem
                   nv_wNetPrem      
                   nv_wCompNetPrem  
                   nv_wtax          
                   nv_wNetPayment   
                   ""
                   w3Bill.wname2     
                   w3Bill.wvatcode   
                   w3Bill.wacno       
                   w3Bill.wbrandmodel.
    
                /* put data แล้ว clear */
                nv_policy70 = "".
                nv_policy72 = "".
            END.
        END.
    END.  /* for each wbill */
    EXPORT DELIMITER "|"
        "T"    
        nv_cnt
        "Record"
        vCountRec
        "Transection".

OUTPUT CLOSE.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdVeh C-Win 
PROCEDURE pdVeh :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       vehicle register  change '-' to " "  , cut provice code 
------------------------------------------------------------------------------*/
  DEF INPUT-OUTPUT PARAMETER pv_vehreg AS CHAR.
  DEF INPUT-OUTPUT PARAMETER pv_engc   AS CHAR.

  IF pv_vehreg <> "" THEN DO:

       c = SUBSTR(pv_vehreg , LENGTH(pv_vehreg) , 1) .
       IF LOOKUP(c, clist) = 0 THEN DO:

                b = LENGTH(pv_vehreg) - 2.
            n_veh = SUBSTR(pv_vehreg,1,b).
            
            bbb = INDEX(n_veh , "-") .    
            IF bbb <> 0 THEN DO:
               ccc  = SUBSTR(n_veh,1,bbb - 1) .
               ddd  = SUBSTR(n_veh,INDEX(pv_vehreg,"-") + 1,(LENGTH(n_veh) - INDEX(n_veh,"-"))).
               pv_engc = ccc + ' ' + ddd.
            END.
            ELSE pv_engc = n_veh.

       END.  /*ตัวท้ายเป็นตัวเลข*/
       ELSE  DO:

            n_veh = pv_vehreg. 
           
            bbb = INDEX(n_veh , "-").

            IF bbb <> 0 THEN DO:
               ccc = SUBSTR(n_veh,1,bbb - 1) .
               ddd = SUBSTR(n_veh,INDEX(n_veh,"-") + 1 ,  (LENGTH(n_veh) - INDEX(n_veh,"-"))).
               pv_engc = ccc + ' ' + ddd.
            END.
            ELSE pv_engc = n_veh.
       END.
  END.
  ELSE pv_engc = "".


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdVehNew C-Win 
PROCEDURE pdVehNew :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       new vehicle register => red label 
------------------------------------------------------------------------------*/
/*nv_eng = "2-SD332/GG1225".*/
DEF INPUT-OUTPUT PARAMETER pv_eng  AS CHAR.
DEF INPUT-OUTPUT PARAMETER pv_char AS CHAR.

    pv_char = "".

    IF SUBSTR(pv_eng,1,1) >= "0" AND SUBSTR(pv_eng,1,1) <= "9"  AND
       SUBSTR(pv_eng,2,1) >= "a" AND SUBSTR(pv_eng,2,1) <= "z"  THEN DO:

        IF SUBSTR(pv_eng,3,1) >= "0" AND SUBSTR(pv_eng,3 ,1) <= "9"  THEN
            pv_char = SUBSTR(pv_eng,1,2) + " " + SUBSTR(pv_eng , 3 , LENGTH(pv_eng)).

        IF SUBSTR(pv_eng,3,1)  = "" THEN pv_char = pv_eng.

    END.
    ELSE DO:

        nv_l = 1.
        REPEAT WHILE nv_l <= LENGTH(pv_eng) :
            IF SUBSTR(pv_eng,nv_l ,1) >= "0"  AND
               SUBSTR(pv_eng,nv_l ,1) <= "9"  THEN DO:
                IF nv_spc THEN 
                     pv_char = TRIM(pv_char) + " " + SUBSTR(pv_eng,nv_l,1).
                ELSE pv_char = TRIM(pv_char) + SUBSTR(pv_eng,nv_l,1).

                nv_spc = NO.
            END.
            ELSE DO:
                IF SUBSTR(pv_eng,nv_l ,1) >= "A"  AND
                   SUBSTR(pv_eng,nv_l ,1) <= "Z"  THEN DO:

                    IF nv_spc = NO THEN
                         pv_char = TRIM(pv_char) + " " + SUBSTR(pv_eng,nv_l ,1).
                    ELSE pv_char = TRIM(pv_char) + SUBSTR(pv_eng,nv_l ,1).

                    nv_spc = YES.
                END.
            END.
            nv_l = nv_l + 1.
        END.   /*repeat*/
    END.  /*else do*/


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdwh1 C-Win 
PROCEDURE pdwh1 :
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

    IF R-INDEX(uwm100.name1,"จก.")               <> 0     OR
       R-INDEX(uwm100.name1,"จำกัด")             <> 0     OR  
       R-INDEX(uwm100.name1,"(มหาชน)")           <> 0     OR
       R-INDEX(uwm100.name1,"INC.")              <> 0     OR
       R-INDEX(uwm100.name1,"CO.")               <> 0     OR
       R-INDEX(uwm100.name1,"LTD.")              <> 0     OR
       R-INDEX(uwm100.name1,"LIMITED")           <> 0     OR
         INDEX(uwm100.name1,"บริษัท")            <> 0     OR
         INDEX(uwm100.name1,"บ.")                <> 0     OR
         INDEX(uwm100.name1,"บจก.")              <> 0     OR
         INDEX(uwm100.name1,"หจก.")              <> 0     OR
         INDEX(uwm100.name1,"หสน.")              <> 0     OR
         INDEX(uwm100.name1,"บรรษัท")            <> 0     OR
         INDEX(uwm100.name1,"มูลนิธิ")           <> 0     OR
         INDEX(uwm100.name1,"ห้าง")              <> 0     OR
         INDEX(uwm100.name1,"ห้างหุ้นส่วน")      <> 0     OR
         INDEX(uwm100.name1,"ห้างหุ้นส่วนจำกัด") <> 0     OR
         INDEX(uwm100.name1,"ห้างหุ้นส่วนจำก")   <> 0     OR
         INDEX(uwm100.name1,"และ/หรือ")          <> 0     THEN  n_wh1 = ((nv_netPrem + nv_netPrem_comp + agtprm_fil.stamp ) * 1) / 100 .  /* 12+13+stamp * 1% */

   /* A60-0379 @ 27/09/2017 */
   IF INDEX(uwm100.name2,"และ/หรือ") <> 0 THEN n_wh1 = ((nv_netPrem + nv_netPrem_comp + agtprm_fil.stamp ) * 1) / 100 .  /* เบี้ย 70 + เบี้ย 72 + stamp * 1% */

   /* A60-0379 @ 27/09/2017 */
   /* ถ้ามีการผูก VAT ให้ถือว่าออกใบกำกับภาษีในนามนิติบุคคล ให้คิด TAX ด้วย*/
   IF uwm100.bs_cd <> "" THEN n_wh1 = ((nv_netPrem + nv_netPrem_comp + agtprm_fil.stamp ) * 1) / 100 . /* เบี้ย 70 + เบี้ย 72 + stamp * 1% */

    /* ------------------------- Suthida T. A55-0064 ---------------------------------- */
    IF LENGTH(uwm100.insref)  = 7 THEN DO:
       IF SUBSTR(uwm100.insref,2,1) = "C" THEN n_wh1 = ((nv_netPrem + nv_netPrem_comp + agtprm_fil.stamp ) * 1) / 100 .
    END.
    ELSE IF LENGTH(uwm100.insref)  = 10 THEN DO:
        
        IF SUBSTR(uwm100.insref,3,1) = "C" THEN n_wh1 = ((nv_netPrem + nv_netPrem_comp + agtprm_fil.stamp ) * 1) / 100 .
    END.
    /* ------------------------- Suthida T. A55-0064 ----------------------------------*/
  

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

/* ************************  Function Implementations ***************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fuDeciToChar C-Win 
FUNCTION fuDeciToChar RETURNS CHARACTER
  ( vDeci   AS decimal,     vCharno AS integer ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/

DEFINE VAR vChar AS CHAR.
DEFINE VAR c     AS CHAR.
DEFINE VAR c2    AS CHAR.
DEFINE VAR c3    AS CHAR.

c  = TRIM(STRING(vDeci,"->>>>>>>>>>9.99")).  /* จำนวนตัวเลขรวมจุด เครื่องหมายลบ*/
c2 = SUBSTR(c,1, LENGTH(c) - 3 ).  /* เครื่องหมายลบ รวม ตัวเลข */
c3 = SUBSTR(c, LENGTH(c) - 1, 2 ).  /* ตัวเลขหลัง จุดทศนิยม  2 ตำแหน่ง*/

vChar = FILL("0",vCharNo - LENGTH(c) + 1 ) + c2 + c3.

RETURN vChar.   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fuFindBranch C-Win 
FUNCTION fuFindBranch RETURNS CHARACTER
  ( nv_branch AS CHAR ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/

   DEFINE VAR nv_brndes AS CHAR INIT "".

   FIND xmm023 WHERE xmm023.branch = nv_branch NO-LOCK NO-ERROR NO-WAIT.
   IF AVAILABLE xmm023 THEN
       nv_brndes = xmm023.bdes.

   RETURN nv_brndes.   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fuLeapYear C-Win 
FUNCTION fuLeapYear RETURNS LOGICAL
  ( /* parameter-definitions */ y AS int) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
    DEFINE VAR vLeapYear  AS LOGICAL.

    vLeapYear = IF (y MOD 4 = 0) AND ((y MOD 100 <> 0) OR (y MOD 400 = 0)) 
                THEN True ELSE False.

    RETURN vLeapYear.   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fuNumYear C-Win 
FUNCTION fuNumYear RETURNS INTEGER
  (INPUT vDate AS DATE ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/

    DEFINE VAR vNum AS INTE INITIAL 0.
  
    IF MONTH(vDate) = 1   OR  MONTH(vDate) = 3    OR
       MONTH(vDate) = 5   OR  MONTH(vDate) = 7    OR
       MONTH(vDate) = 8   OR  MONTH(vDate) = 10   OR
       MONTH(vDate) = 12 THEN DO:

        vNum = 31.
    END.
   
    IF MONTH(vDate) = 4   OR  MONTH(vDate) = 6    OR
       MONTH(vDate) = 9   OR  MONTH(vDate) = 11   THEN DO:

        vNum = 30.
    END.
   
    IF MONTH(vDate) = 2 THEN DO:
        IF fuLeapYear(YEAR(vDate)) = TRUE THEN 
             vNum = 29. 
        ELSE vNum = 28.
    END.

    RETURN vNum .   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

