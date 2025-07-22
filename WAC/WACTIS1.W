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

Modify By : TANTAWAN C.   26/01/2008   [A500178]
             ปรับ FORMAT branch เพื่อรองรับการขยายสาขา
    ขยาย FORMAT fi_ac1 - fi_ac28 จาก "X(7)" เป็น  Char "X(10)"          
                ปิดฟิลด์  fi_ac29 , fi_ac30  
------------------------------------------------------------------------*/
/*          This .W file was created with the Progress UIB.             */
/*----------------------------------------------------------------------*/

/* Create an unnamed pool to store all the widgets created 
     by this procedure. This is a good default which assures
     that this procedure's triggers and internal procedures 
     will execute in this procedure's storage, and that proper
     cleanup will occur on deletion of the procedure. */

CREATE WIDGET-POOL.

/************   Program   **************
/* CREATE BY :  Patcharaporn Y.        y:\develop\sic_test\pat   */
Wac
        -Wactis1.w 
Whp
        -WhpBran.w

/* Modify By : Kanchana C.             A46-0463    27/11/2003 */
    {wac\wactis01.i}   /* หาชื่อใน xmm600, xtm600 */

/*dot i สำหรับ v70   */
    {wac\wactis02.i}   /* head excel*/
    {wac\wactis03.i}   /* detail excel*/
    {wac\wactis06.i}   /* detail text file*/


/*dot i สำหรับ v72   */
    {wac\wactis04.i}   /* head excel*/
    {wac\wactis05.i}   /* detail excel*/
    {wac\wactis07.i}   /* detail text file*/

Procedure
    pd70       - due date
    pd70out  - over due
    pd70wcr  - winin

    pd72       - due date
    pd72out  - over due
    pd72wcr  - winin

/* Modify By : Kanchana C.             A47-0096    08/02/2004 */
รวม ไฟล์ ของรายการ ข้อมูลวางบิล(*DUE*) และข้อมูลที่ยังไม่ครบกำหนด(*WITH IN*) เป็นไฟล์เดียว
ทั้ง กรมธรรม์ ประเภท 70 และ 72

Procedure
    pd70       - due date + winin
    pd70out  - over due

    pd72       - due date +winin
    pd72out  - over due

/* Modify By : Kanchana C.          A47-0235  29/06/2004
1. แก้ไขให้ดึงข้อมูล เกี่ยวกับ  policy   ที่ uwm100.policy +  uwm100.endno + uwm100.docno
แทนรูปแบบเดิม (uwm100.trty11 + uwm100.docno1)  ที่อาจดึงข้อมูลมาผิดได้

*/
************************************/

/* ***************************  Definitions  ************************** */

/* Parameters Definitions ---                                           */
DEF SHARED VAR n_User   AS CHAR.
DEF SHARED VAR n_Passwd AS CHAR.  

/* Local Variable Definitions ---                                       */
DEF VAR   nv_User AS CHAR NO-UNDO. 
DEF VAR   nv_pwd  as char NO-UNDO.

ASSIGN
    nv_User = n_user
    nv_pwd  = n_passwd.

DEF NEW SHARED VAR n_branch  AS CHAR FORMAT "x(2)".
DEF NEW SHARED VAR n_branch2 AS CHAR FORMAT "x(2)".
DEF VAR n_asdat  AS DATE FORMAT "99/99/9999".

DEF VAR n_OutputFile1  AS Char.
DEF VAR n_OutputFile2  AS Char.
DEF VAR n_OutputFile3  AS Char.
DEF VAR n_OutputFile4  AS Char.

Def Var n_name      As Char Format "x(50)".     /*acno name*/
Def Var n_chkname   As Char format "x(1)".        /* Acno-- chk button 1-2 */
Def Var n_bdes      As Char Format "x(50)".     /*branch name*/
Def Var n_chkBname  As Char format "x(1)".        /* branch-- chk button 1-2 */
/*--- A500178 ---
DEF VAR nv_acno     AS CHAR FORMAT 'X(7)'.
-------*/
DEF VAR nv_acno     AS CHAR FORMAT 'X(10)'.
DEF VAR nv_policy   AS CHAR FORMAT "X(16)".
DEF VAR nv_norpol   AS CHAR FORMAT "X(25)".
DEF VAR nv_pol72    AS CHAR FORMAT "X(16)".
DEF VAR nv_endno    AS CHAR FORMAT "X(12)".
DEF VAR nv_polbran  AS CHAR FORMAT "X(2)".
DEF VAR nv_poltyp   AS CHAR FORMAT "X(3)".
DEF VAR nv_trnty1   AS CHAR FORMAT "X(1)".
DEF VAR nv_trnty2   AS CHAR FORMAT "X(1)".
/*DEF VAR nv_docno    AS CHAR FORMAT "X(7)".*/
DEF VAR nv_docno    AS CHAR FORMAT "X(10)". /*A60-0267*/
DEF VAR nv_trndat   AS DATE  FORMAT "99/99/9999".
DEF VAR nv_asdat    AS DATE  FORMAT "99/99/9999".
DEF VAR nv_trndat1  AS DATE  FORMAT "99/99/9999".
/*--- A500178 ---
DEF VAR nv_insref   AS CHAR FORMAT "X(7)".
------*/
DEF VAR nv_insref   AS CHAR FORMAT "X(10)".
DEF VAR nv_engine  AS CHAR  FORMAT "X(20)". 
DEF VAR nv_cha_no  AS CHAR  FORMAT "X(20)".
DEF VAR nv_opnpol  AS CHAR  FORMAT "X(16)".
DEF VAR nv_vehreg  AS CHAR  FORMAT "X(15)".
DEF VAR nv_comdat  AS DATE  FORMAT "99/99/9999".
DEF VAR nv_expdat  AS DATE  FORMAT "99/99/9999".
DEF VAR nv_grossPrem      AS DECI  FORMAT "->>,>>>,>>9.99".
DEF VAR nv_grossPrem_comp AS DECI  FORMAT "->>,>>>,>>9.99".
DEF VAR nv_netPrem        AS DECI  FORMAT "->>,>>>,>>9.99".
DEF VAR nv_netPrem_comp   AS DECI  FORMAT "->>,>>>,>>9.99".
DEF VAR nv_tax            AS DECI  FORMAT "->>9.99".
DEF VAR nv_netPayment     AS DECI  FORMAT "->>,>>>,>>9.99".
DEF VAR nv_rencnt  AS INT FORMAT ">>9".
DEF VAR nv_endcnt  AS INT FORMAT "999".
DEF VAR nv_job_nr  AS CHAR FORMAT "X".
DEF VAR nv_nor_si  AS DECI  FORMAT "->>,>>>,>>9.99".
DEF VAR nv_comp_si AS DECI  FORMAT "->>,>>>,>>9.99".

DEF BUFFER Buwm_v72 FOR uwm100.
DEF BUFFER Buwm301  FOR uwm301.
DEF BUFFER Buwm130  FOR uwm130.

DEF WORKFILE vehreg72 NO-UNDO
  FIELD polsta  AS CHAR FORMAT "X(02)"       /* Policy Status / IF,RE,CA */
  FIELD vehreg  AS CHAR FORMAT "X(10)"       /* Vehicle Registration No. */
  FIELD comdat  AS DATE FORMAT "99/99/9999"
  FIELD expdat  AS DATE FORMAT "99/99/9999"  /* Expiry Date */
  FIELD enddat  AS DATE FORMAT "99/99/9999"  /* Endorsement Date */
  FIELD del_veh AS CHAR FORMAT "X"           /* Delete Item / 0," "=No, 1=Yes*/
  FIELD policy  AS CHAR FORMAT "X(12)"
  FIELD rencnt  AS INTE FORMAT "999"
  FIELD endcnt  AS INTE FORMAT "999"
  FIELD riskgp  AS INTE FORMAT "999"
  FIELD riskno  AS INTE FORMAT "999"
  FIELD itemno  AS INTE FORMAT "999"
  FIELD sticker LIKE uwm301.sckno.


def var n_wh1 as deci format "->>9.99".

/* work-file  สำหรับ เก็บข้อมูลไว้ตอน export data ออกมา  */
    DEF TEMP-TABLE wBill
        FIELD wRecid  AS RECID
         
        FIELD wRecordno AS INT  FORMAT "999999"
        /*--- A500178 ---
        FIELD wAcno     AS CHAR  FORMAT "X(7)"
        FIELD wInsref   AS CHAR  FORMAT "X(7)"
        ------*/
        FIELD wAcno     AS CHAR  FORMAT "X(10)"
        FIELD wInsref   AS CHAR  FORMAT "X(10)"
        FIELD wPolicy   AS CHAR  FORMAT "X(16)"
        FIELD wNorpol   AS CHAR  FORMAT "X(16)"            
        FIELD wPol72    AS CHAR  FORMAT "X(16)"
        FIELD wEndno    AS CHAR  FORMAT "X(12)"
        FIELD wPolbran  AS CHAR  FORMAT "X(2)"
        FIELD wPoltyp   AS CHAR  FORMAT "X(3)"
        FIELD wTrnty1   AS CHAR  FORMAT "X"
        FIELD wTrnty2   AS CHAR  FORMAT "X"
       /* FIELD wDocno    AS CHAR  FORMAT "X(7)"*/
        FIELD wDocno    AS CHAR  FORMAT "X(10)" /*A60-0267*/
        FIELD wTrndat   AS DATE  FORMAT "99/99/9999"  /*export date*/
        FIELD wAsdat    AS DATE  FORMAT "99/99/9999"
        FIELD wTrndat1  AS DATE  FORMAT "99/99/9999"  /* trndat to Acc.*/
        FIELD wInstitle AS CHAR  FORMAT "X(30)"
        FIELD wInsnam   AS CHAR  FORMAT "X(50)"
        FIELD wEngine   AS CHAR  FORMAT "X(20)"
        FIELD wCha_no   AS CHAR  FORMAT "X(20)"
        FIELD wOpnpol   AS CHAR  FORMAT "X(16)"
        FIELD wVehreg   AS CHAR  FORMAT "X(15)"
        FIELD wComdat   AS DATE  FORMAT "99/99/9999"
        FIELD wExpdat   AS DATE  FORMAT "99/99/9999"
        FIELD wGrossPrem     AS DECI  FORMAT "->>,>>>,>>9.99"
        FIELD wCompGrossPrem AS DECI  FORMAT "->>,>>>,>>9.99"
        FIELD wNetPrem       AS DECI  FORMAT "->>,>>>,>>9.99"
        FIELD wCompNetPrem   AS DECI  FORMAT "->>,>>>,>>9.99"
        FIELD wTax           AS DECI  FORMAT "->>9.99"
        FIELD wNetPayment    AS DECI  FORMAT "->>,>>>,>>9.99"

        FIELD wGPs     AS CHAR FORMAT "X(10)"
        FIELD wCompGPs AS CHAR FORMAT "X(10)"
        FIELD wNPs     AS CHAR FORMAT "X(10)"
        FIELD wCompNPs AS CHAR FORMAT "X(10)"
        FIELD wTaxs    AS CHAR FORMAT "X(10)"
        FIELD wNetPays AS CHAR FORMAT "X(10)"
        FIELD wRencnt  AS INT FORMAT ">>9"
        FIELD wEndcnt  AS INT FORMAT "999"

        FIELD wjob_nr      AS CHAR FORMAT "X"
        FIELD wnor_covamt  AS DECI  FORMAT "->>,>>>,>>9.99"
        FIELD wcomp_covamt AS DECI  FORMAT "->>,>>>,>>9.99"
        FIELD wnor_comm    AS DECI  FORMAT "->>,>>>,>>9.99"
        FIELD wcomp_comm   AS DECI  FORMAT "->>,>>>,>>9.99"
        FIELD wnor_vat     AS DECI  FORMAT "->>,>>>,>>9.99"
        FIELD wcomp_vat    AS DECI  FORMAT "->>,>>>,>>9.99"
        FIELD wnor_tax3    AS DECI  FORMAT "->>,>>>,>>9.99"
        FIELD wcomp_tax3   AS DECI  FORMAT "->>,>>>,>>9.99"
        FIELD wcredit      AS INTE  FORMAT ">>9"
        FIELD wWcr         AS DECI  FORMAT "->>,>>>,>>9.99"
        FIELD wDamt        AS  DECI  FORMAT "->>,>>>,>>9.99"
        FIELD wOdue        AS DECI  FORMAT "->>,>>>,>>9.99"
        FIELD wBal         AS DECI  FORMAT "->>,>>>,>>9.99"
        FIELD wModdes      AS CHAR  FORMAT "X(30)"            
        FIELD wBen83       AS CHAR  FORMAT "X(50)"
        FIELD wRemark      AS CHAR  FORMAT "X(25)"

      INDEX wBill01  IS UNIQUE PRIMARY wAcno wPolicy wEndno wTrnty1 wTrnty2 wDocno ASCENDING
      INDEX wBill02 wtrndat wasdat wacno
      INDEX wBill03 wComdat  wNorpol
      .

FOR EACH vehreg72:   DELETE  vehreg72.   END.
/* ------------------------------------------------------------------------ */
DEFINE STREAM filebill1.
DEFINE STREAM filebill2.

DEFINE STREAM filebill1ex.
DEFINE STREAM filebill2ex.


DEF  VAR nv_exportdat  AS DATE  FORMAT "99/99/9999".
DEF  VAR nv_exporttim   AS CHAR FORMAT "X(8)".
DEF  VAR nv_exportusr   AS CHAR FORMAT "X(8)".

DEF VAR vCount AS INT INIT 1.
DEF VAR vExpCount1 AS INT INIT 0.
DEF VAR vExpCount2 AS INT INIT 0.
DEF VAR vExpCount3 AS INT INIT 0.
DEF VAR vExpCount4 AS INT INIT 0.

DEF VAR vBackUp AS CHAR.
def var n_netloc as deci.
def var y1 as deci.
def var z1 as deci.
def var p_trnty as char format 'x(2)'.
def var sum as deci.
def var p_policy as char format 'x(12)'.

/**/
def var n_veh as char.
def var a as int.
def var b as int.
def var c as char format 'x'.
def var clist as char init "1,2,3,4,5,6,7,8,9,0".
def var bbb as int.
def var ccc as char format 'x(20)'.
def var ddd as char format 'x(20)'.
/**/

def new shared var engc as char format 'x(20)'.
DEF VAR vAcProc_fil  AS CHAR.

/**/
DEF VAR nv_eng  AS CHAR FORMAT "X(20)".
DEF VAR nv_char AS CHAR FORMAT "X(20)".
DEF VAR nv_l    AS INT.

/**/
def var engine  as char format 'x(26)'.
DEF VAR nv_eng1 AS CHAR FORMAT "X(20)".
DEF VAR nv_char1 AS CHAR FORMAT "X(20)".
DEF VAR nv_l1    AS INT.

/**/
def var chas as char format 'x(26)'.
DEF VAR nv_eng2 AS CHAR FORMAT "X(20)".
DEF VAR nv_char2 AS CHAR FORMAT "X(20)".
DEF VAR nv_l2    AS INT.

/**/
/*---------------def for tas2.i----------------*/
DEF VAR vStamp      AS DECI.
DEF VAR vVat        AS DECI. 
DEF VAR vStamp_comp AS DECI.
DEF VAR vVat_comp   AS DECI.
/*-------------------------------------------------*/
def var  n_pol as char format 'x(16)'.
def var  n_ren as inte  format ">9".
def var  n_end as inte  format "999".

def var n_trndatF   as date format "99/99/9999".
def var n_trndatT   as date format "99/99/9999".
def var nv_credit   as inte  format ">>9".
def var nv_wcr      as deci format "->>>,>>>,>>9.99".
def var nv_damt     as deci format "->>>,>>>,>>9.99".
def var nv_odue     as deci format "->>>,>>>,>>9.99".
def var n_veh1      as char format 'x(10)'.
def var nv_chas     as char format 'x(25)'.
def var t_comdat    as char format "x(8)".   /*yyyymmdd*/
def var t_expdat    as char format "x(8)".   /*yyyymmdd*/
def var t_today     as char format "x(8)".   /*yyyymmdd*/


def var t_asdat     as char format 'x(8)'.
def var nv_institle as char format 'x(30)'.  
DEF VAR nv_infnam   AS CHAR FORMAT "X(50)".  /*fname*/
DEF VAR nv_inlnam   AS CHAR FORMAT "X(50)".  /*lname*/
DEF VAR nv_insnam   AS CHAR FORMAT "X(100)".  /*fname + lname*/
def var nv_moddes   AS CHAR FORMAT "X(30)".  /*make-model*/
def var nv_ben83    AS CHAR FORMAT "X(50)".  /*beneficiary*/
def var nv_notiOf   as char.
def var nv_remark   as char format 'x(25)'.    /*etext*/
def var nv_bal      AS DECI  FORMAT "->>,>>>,>>9.99".

/*--- A500178 --- ขยาย FORMAT ของ nv_ac1 - nv_ac30 จากเดิม "X(7)" เป็น "X(10)" */
DEF  NEW SHARED VAR nv_ac1   as char format 'X(10)'.
DEF  NEW SHARED VAR nv_ac2   as char format 'X(10)'.
DEF  NEW SHARED VAR nv_ac3   as char format 'X(10)'.
DEF  NEW SHARED VAR nv_ac4   as char format 'X(10)'.
DEF  NEW SHARED VAR nv_ac5   as char format 'X(10)'.
DEF  NEW SHARED VAR nv_ac6   as char format 'X(10)'.
DEF  NEW SHARED VAR nv_ac7   as char format 'X(10)'.
DEF  NEW SHARED VAR nv_ac8   as char format 'X(10)'.
DEF  NEW SHARED VAR nv_ac9   as char format 'X(10)'.
DEF  NEW SHARED VAR nv_ac10  as char format 'X(10)'.
DEF  NEW SHARED VAR nv_ac11  as char format 'X(10)'.
DEF  NEW SHARED VAR nv_ac12  as char format 'X(10)'.
DEF  NEW SHARED VAR nv_ac13  as char format 'X(10)'.
DEF  NEW SHARED VAR nv_ac14  as char format 'X(10)'.
DEF  NEW SHARED VAR nv_ac15  as char format 'X(10)'.
DEF  NEW SHARED VAR nv_ac16  as char format 'X(10)'.
DEF  NEW SHARED VAR nv_ac17  as char format 'X(10)'.
DEF  NEW SHARED VAR nv_ac18  as char format 'X(10)'.
DEF  NEW SHARED VAR nv_ac19  as char format 'X(10)'.
DEF  NEW SHARED VAR nv_ac20  as char format 'X(10)'.
DEF  NEW SHARED VAR nv_ac21  as char format 'X(10)'.
DEF  NEW SHARED VAR nv_ac22  as char format 'X(10)'.
DEF  NEW SHARED VAR nv_ac23  as char format 'X(10)'.
DEF  NEW SHARED VAR nv_ac24  as char format 'X(10)'.
DEF  NEW SHARED VAR nv_ac25  as char format 'X(10)'.
DEF  NEW SHARED VAR nv_ac26  as char format 'X(10)'.
DEF  NEW SHARED VAR nv_ac27  as char format 'X(10)'.
DEF  NEW SHARED VAR nv_ac28  as char format 'X(10)'.
DEF  NEW SHARED VAR nv_ac29  as char format 'X(10)'.
DEF  NEW SHARED VAR nv_ac30  as char format 'X(10)'.

DEF VAR nv_sumins as deci format "->>,>>>,>>9.99".

DEF VAR n_recid AS RECID.
DEF VAR n_recid2 AS RECID.
def var n_row1   as inte format ">>>>>>9" init 2.

DEF NEW SHARED VAR nv_acnoAll AS CHAR.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS fiBranch fiBranch2 cbAsDat fi_trndatF ~
fi_trndatT fiFile-Name1 fiFile-Name2 Btn_OK Btn_Exit buBranch buBranch2 ~
bu_acno fibdes fibdes2 fi_process fi_print fi_ac1 fi_ac2 fi_ac3 fi_ac4 ~
fi_ac5 fi_ac6 fi_ac7 fi_ac8 fi_ac9 fi_ac10 fi_ac11 fi_ac12 fi_ac13 fi_ac14 ~
fi_ac15 fi_ac16 fi_ac17 fi_ac18 fi_ac19 fi_ac20 fi_ac21 fi_ac22 fi_ac23 ~
fi_ac24 fi_ac25 fi_ac26 fi_ac27 fi_ac28 RECT-1 RECT-2 RECT-3 RECT-4 RECT-5 ~
RECT-6 RECT-7 RECT-8 
&Scoped-Define DISPLAYED-OBJECTS fiBranch fiBranch2 cbAsDat ra_credit ~
fi_trndatF fi_trndatT fiFile-Name1 fiFile-Name2 fibdes fibdes2 fi_process ~
fi_print fi_ac1 fi_ac2 fi_ac3 fi_ac4 fi_ac5 fi_ac6 fi_ac7 fi_ac8 fi_ac9 ~
fi_ac10 fi_ac11 fi_ac12 fi_ac13 fi_ac14 fi_ac15 fi_ac16 fi_ac17 fi_ac18 ~
fi_ac19 fi_ac20 fi_ac21 fi_ac22 fi_ac23 fi_ac24 fi_ac25 fi_ac26 fi_ac27 ~
fi_ac28 

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
DEFINE BUTTON Btn_Exit AUTO-END-KEY 
     LABEL "Exit" 
     SIZE 13 BY 1.76
     BGCOLOR 8 FONT 2.

DEFINE BUTTON Btn_OK AUTO-GO 
     LABEL "OK" 
     SIZE 13 BY 1.76
     BGCOLOR 8 FONT 2.

DEFINE BUTTON buBranch 
     LABEL "..." 
     SIZE 3 BY .95 TOOLTIP "รหัสสาขา"
     FONT 6.

DEFINE BUTTON buBranch2 
     LABEL "..." 
     SIZE 3 BY .95 TOOLTIP "รหัสสาขา"
     FONT 6.

DEFINE BUTTON bu_acno 
     LABEL "..." 
     SIZE 3 BY 1.14
     FONT 2.

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
     SIZE 23.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fiFile-Name2 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 23.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_ac1 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 12 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_ac10 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 12 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_ac11 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 12 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_ac12 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 12 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_ac13 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 12 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_ac14 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 12 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_ac15 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 12 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_ac16 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 12 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_ac17 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 12 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_ac18 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 12 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_ac19 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 12 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_ac2 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 12 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_ac20 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 12 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_ac21 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 12 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_ac22 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 12 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_ac23 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 12 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_ac24 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 12 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_ac25 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 12 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_ac26 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 12 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_ac27 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 12 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_ac28 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 12 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_ac3 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 12 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_ac4 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 12 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_ac5 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 12 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_ac6 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 12 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_ac7 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 12 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_ac8 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 12 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_ac9 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 12 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_print AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 52.5 BY 1.05
     BGCOLOR 173 FGCOLOR 30  NO-UNDO.

DEFINE VARIABLE fi_process AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 52.5 BY 1.05
     BGCOLOR 1 FGCOLOR 7 FONT 2 NO-UNDO.

DEFINE VARIABLE fi_trndatF AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 15 FONT 1 NO-UNDO.

DEFINE VARIABLE fi_trndatT AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 15 FONT 1 NO-UNDO.

DEFINE VARIABLE ra_credit AS INTEGER 
     VIEW-AS RADIO-SET VERTICAL
     RADIO-BUTTONS 
          "Credit Term (Due)", 1,
"Over Due", 2
     SIZE 18.5 BY 2.62
     BGCOLOR 19 FGCOLOR 0  NO-UNDO.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 23.5 BY 11.48
     BGCOLOR 32 FGCOLOR 15 .

DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 97.5 BY 11.48
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-3
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 39 BY 3.24
     BGCOLOR 32 .

DEFINE RECTANGLE RECT-4
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 81.5 BY 3.24
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-5
     EDGE-PIXELS 5 GRAPHIC-EDGE  
     SIZE 125 BY 17.95
     BGCOLOR 173 FGCOLOR 0 .

DEFINE RECTANGLE RECT-6
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 16 BY 2.33
     BGCOLOR 32 .

DEFINE RECTANGLE RECT-7
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 16 BY 2.33
     BGCOLOR 32 .

DEFINE RECTANGLE RECT-8
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 61.5 BY 1.57
     BGCOLOR 19 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     fiBranch AT ROW 4 COL 29.5 COLON-ALIGNED NO-LABEL
     fiBranch2 AT ROW 4.95 COL 29.5 COLON-ALIGNED NO-LABEL
     cbAsDat AT ROW 11.48 COL 29.5 COLON-ALIGNED NO-LABEL
     ra_credit AT ROW 11.57 COL 81.83 NO-LABEL
     fi_trndatF AT ROW 12.76 COL 29.5 COLON-ALIGNED NO-LABEL
     fi_trndatT AT ROW 13.81 COL 29.5 COLON-ALIGNED NO-LABEL
     fiFile-Name1 AT ROW 17.43 COL 46.5 COLON-ALIGNED NO-LABEL
     fiFile-Name2 AT ROW 17.43 COL 72 COLON-ALIGNED NO-LABEL
     Btn_OK AT ROW 21.91 COL 43
     Btn_Exit AT ROW 21.91 COL 68
     buBranch AT ROW 4 COL 36.5
     buBranch2 AT ROW 4.95 COL 36.5
     bu_acno AT ROW 6.48 COL 24.5
     fibdes AT ROW 4 COL 38 COLON-ALIGNED NO-LABEL
     fibdes2 AT ROW 4.95 COL 38 COLON-ALIGNED NO-LABEL
     fi_process AT ROW 19.24 COL 6.5 COLON-ALIGNED NO-LABEL
     fi_print AT ROW 19.24 COL 64 COLON-ALIGNED NO-LABEL
     fi_ac1 AT ROW 6.57 COL 29.5 COLON-ALIGNED NO-LABEL
     fi_ac2 AT ROW 6.57 COL 42 COLON-ALIGNED NO-LABEL
     fi_ac3 AT ROW 6.57 COL 54.5 COLON-ALIGNED NO-LABEL
     fi_ac4 AT ROW 6.52 COL 67 COLON-ALIGNED NO-LABEL
     fi_ac5 AT ROW 6.52 COL 79.5 COLON-ALIGNED NO-LABEL
     fi_ac6 AT ROW 6.52 COL 92 COLON-ALIGNED NO-LABEL
     fi_ac7 AT ROW 6.52 COL 104.67 COLON-ALIGNED NO-LABEL
     fi_ac8 AT ROW 7.76 COL 29.5 COLON-ALIGNED NO-LABEL
     fi_ac9 AT ROW 7.76 COL 42 COLON-ALIGNED NO-LABEL
     fi_ac10 AT ROW 7.76 COL 54.5 COLON-ALIGNED NO-LABEL
     fi_ac11 AT ROW 7.71 COL 67 COLON-ALIGNED NO-LABEL
     fi_ac12 AT ROW 7.71 COL 79.5 COLON-ALIGNED NO-LABEL
     fi_ac13 AT ROW 7.71 COL 92 COLON-ALIGNED NO-LABEL
     fi_ac14 AT ROW 7.71 COL 104.67 COLON-ALIGNED NO-LABEL
     fi_ac15 AT ROW 8.95 COL 29.5 COLON-ALIGNED NO-LABEL
     fi_ac16 AT ROW 8.95 COL 42 COLON-ALIGNED NO-LABEL
     fi_ac17 AT ROW 8.95 COL 54.5 COLON-ALIGNED NO-LABEL
     fi_ac18 AT ROW 8.91 COL 67 COLON-ALIGNED NO-LABEL
     fi_ac19 AT ROW 8.91 COL 79.5 COLON-ALIGNED NO-LABEL
     fi_ac20 AT ROW 8.91 COL 92 COLON-ALIGNED NO-LABEL
     fi_ac21 AT ROW 8.91 COL 104.67 COLON-ALIGNED NO-LABEL
     fi_ac22 AT ROW 10.14 COL 29.5 COLON-ALIGNED NO-LABEL
     fi_ac23 AT ROW 10.14 COL 42 COLON-ALIGNED NO-LABEL
     fi_ac24 AT ROW 10.14 COL 54.5 COLON-ALIGNED NO-LABEL
     fi_ac25 AT ROW 10.1 COL 67 COLON-ALIGNED NO-LABEL
     fi_ac26 AT ROW 10.1 COL 79.5 COLON-ALIGNED NO-LABEL
     fi_ac27 AT ROW 10.1 COL 92 COLON-ALIGNED NO-LABEL
     fi_ac28 AT ROW 10.1 COL 104.67 COLON-ALIGNED NO-LABEL
     "  การส่งข้อมูล Text File เพื่อวางบิลเรียกเก็บเงินค่าเบี้ยฯ จาก Tisco Leasing" VIEW-AS TEXT
          SIZE 59 BY 1 AT ROW 1.52 COL 38
          BGCOLOR 1 FGCOLOR 7 
     "Branch From":25 VIEW-AS TEXT
          SIZE 19.5 BY 1 TOOLTIP "ตั้งแต่สาขา" AT ROW 4 COL 8
          BGCOLOR 19 FGCOLOR 0 
     "Output To TextFile" VIEW-AS TEXT
          SIZE 23 BY 1 AT ROW 16.14 COL 7.5
          BGCOLOR 19 FGCOLOR 0 
     "Transaction Date To" VIEW-AS TEXT
          SIZE 19.5 BY .95 AT ROW 13.81 COL 8
          BGCOLOR 19 FGCOLOR 0 
     " As of Date (Statement)":30 VIEW-AS TEXT
          SIZE 19.5 BY .95 TOOLTIP "วันที่ออกรายงาน" AT ROW 11.48 COL 8
          BGCOLOR 19 FGCOLOR 0 
     "Producer Code" VIEW-AS TEXT
          SIZE 16 BY 1 AT ROW 6.48 COL 8
          BGCOLOR 19 FGCOLOR 0 
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133.17 BY 24.04
         BGCOLOR 3 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME DEFAULT-FRAME
     "          เบี้ยใหญ่ +  พรบ." VIEW-AS TEXT
          SIZE 23.5 BY 1 AT ROW 16.14 COL 48.5
          BGCOLOR 34 FGCOLOR 1 
     "Branch To":10 VIEW-AS TEXT
          SIZE 19.5 BY 1 TOOLTIP "ถึงสาขา" AT ROW 4.95 COL 8
          BGCOLOR 19 FGCOLOR 0 
     "เบี้ยใหญ่ (กรณีจ่าย พรบ.แล้ว)" VIEW-AS TEXT
          SIZE 23.5 BY 1.14 AT ROW 16.14 COL 74
          BGCOLOR 34 FGCOLOR 1 
     "Transaction Date From" VIEW-AS TEXT
          SIZE 19.5 BY 1.05 AT ROW 12.76 COL 8
          BGCOLOR 19 FGCOLOR 0 
     RECT-1 AT ROW 3.62 COL 6
     RECT-2 AT ROW 3.62 COL 30
     RECT-3 AT ROW 15.62 COL 6
     RECT-4 AT ROW 15.62 COL 46
     RECT-5 AT ROW 3.14 COL 4.5
     RECT-6 AT ROW 21.62 COL 41.5
     RECT-7 AT ROW 21.62 COL 66.5
     RECT-8 AT ROW 1.24 COL 37
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133.17 BY 24.04
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
         TITLE              = "wactis1 - การส่งข้อมูล Text File เพื่อวางบิล Tisco Lesing"
         HEIGHT             = 23.62
         WIDTH              = 131.67
         MAX-HEIGHT         = 24.05
         MAX-WIDTH          = 133.33
         VIRTUAL-HEIGHT     = 24.05
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
/* SETTINGS FOR RADIO-SET ra_credit IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* wactis1 - การส่งข้อมูล Text File เพื่อวางบิล Tisco Lesing */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* wactis1 - การส่งข้อมูล Text File เพื่อวางบิล Tisco Lesing */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
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
        fibranch     = INPUT fibranch
        fibranch2    = INPUT fibranch2
        fiFile-Name1 = INPUT fiFile-Name1
        fiFile-Name2 = INPUT fiFile-Name2

        n_branch      = fiBranch
        n_branch2     = fiBranch2
        n_asdat       =  DATE( INPUT cbAsDat)
        n_OutputFile1 =  fiFile-Name1
        n_OutputFile2 =  fiFile-Name2

        n_trndatF     =  fi_trndatF
        n_trndatT     =   fi_trndatT.

    RUN pdAddAcno.
            
   IF ( n_branch > n_branch2)   THEN DO:
         MESSAGE "ข้อมูลรหัสสาขาผิดพลาด" SKIP
                          "รหัสสาขาเริ่มต้นต้องมากกว่ารหัสสุดท้าย" VIEW-AS ALERT-BOX WARNING . 
         APPLY "Entry" To fibranch.
         RETURN NO-APPLY.       
   END.

   IF  n_OutputFile1 = "" OR n_OutputFile2 = ""   THEN DO:
         MESSAGE "กรุณาใส่ชื่อไฟล์" VIEW-AS ALERT-BOX WARNING . 
         APPLY "Entry" To  fiFile-Name1 .
         RETURN NO-APPLY.       
   END.
 
    IF ( n_trndatF = ? ) OR ( n_trndatT = ? )   THEN DO:
         MESSAGE "กรุณาใส่ข้อมูล Transaction Date" VIEW-AS ALERT-BOX WARNING . 
         APPLY "Entry" To fi_trndatF.
         RETURN NO-APPLY. 
   END.

    IF ( n_trndatF > n_trndatT)   THEN DO:
         MESSAGE "ข้อมูลวันที่คุ้มครองผิดพลาด" SKIP
                          "วันที่คุ้มครองเริ่มต้นต้องน้อยกว่าวันที่คุ้มครองสุดท้าย" VIEW-AS ALERT-BOX WARNING . 
         APPLY "Entry" To fi_trndatF.
         RETURN NO-APPLY. 
   END.
 
/****************** PRINT ********************/
    FOR EACH wBill: DELETE  wBill. END.   /* DELETE WORK-TABLE */

    FIND FIRST  billing  USE-INDEX billing02                 WHERE
                    billing.trndat           <> ?          AND    /*= nv_exportdat  */
                    billing.asdat        = n_asdat   AND   /* = n_asdat */
                   (LOOKUP(billing.acno1,nv_acnoAll) <> 0 ) AND  /* A46-0463*/ 
                   (billing.branch       >= fiBranch                 AND
                    billing.branch       <= fiBranch2)              AND
                   (billing.start_date   >= n_trndatF               AND
                    billing.start_date   <= n_trndatT)             AND
        /*k*/   (billing.trndat1         >= n_trndatF   AND    billing.trndat1       <= n_trndatT)
                    /*billing.credit            = nv_credit   */ /* A46-0463*/          
                   
                    NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL billing THEN DO:  /* พบข้อมูล  เนื่องจากเคย process แล้ว ต้องลบข้อมูลเก่าก่อน*/
         MESSAGE  "ข้อมูล         : " STRING(n_asdat,"99/99/9999") SKIP(1)
                "ส่งออกไปแล้ว ณ วันที่ : " STRING(billing.trndat,"99/99/9999")  SKIP(1)
                "คุณต้องการที่จะ process ใหม่หรือไม่ "  SKIP(1)
                " ถ้า => Yes  คือ จะ ลบข้อมูลเก่าแล้ว จึง process ใหม่" SKIP
                "      => No   คือ ไม่ทำการ process ใดๆ"
       VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO
       TITLE "Confirm"    UPDATE CHOICE AS LOGICAL.
       CASE CHOICE:
            WHEN FALSE THEN DO:
                 RETURN NO-APPLY.
            END.
            WHEN TRUE THEN DO:
                /*--- ลบข้อมูลเก่า  กรณี เรียกงาน ที่ process วันเดียวกัน ---*/
                 FOR EACH billing  USE-INDEX billing02              WHERE
                                    billing.trndat       <> ?          AND    /*= nv_exportdat  */
                                    billing.asdat         = n_asdat  AND   /* = n_asdat */
                                    (LOOKUP(billing.acno1,nv_acnoAll) <> 0 ) AND  /* A46-0463*/
                                   (billing.branch        >= fiBranch          AND
                                    billing.branch        <= fiBranch2)     AND
                        /*k*/      (billing.trndat1       >= n_trndatF   AND    billing.trndat1       <= n_trndatT) :
                                    /*billing.credit            = nv_credit.*/ /* A46-0463*/

                    DISP 
                        "Delete : " +  STRING(billing.asdat,"99/99/9999") + "   " +  billing.policy + "   " + billing.endno  @ fi_process
                        WITH FRAME {&FRAME-NAME}.

                    DELETE billing.

                 END.   /*billing*/
    
                MESSAGE  "Begin Process Time :  "   STRING(TIME, "HH:MM AM") VIEW-AS ALERT-BOX.
    
                RUN pdDel.
                RUN pdProc.   /*create record at billing*/
    
                MESSAGE "End Process Time :   "  STRING(TIME, "HH:MM AM") VIEW-AS ALERT-BOX.
    
                ra_credit = 1.
                IF ra_credit = 1 THEN DO:  /* credit term + with in credit  */
                        RUN pdFileName.
                        RUN pd70.
                        RUN pd72.
            
                    MESSAGE  "ทำการ Dump ข้อมูล ลง Text File : "  fiFile-Name1  SKIP(1)
                               "การส่งออก จำนวน : " vExpCount1  " รายการ" VIEW-AS ALERT-BOX INFORMATION.
    
                    MESSAGE  "ทำการ Dump ข้อมูล ลง Text File : "  fiFile-Name2  SKIP(1)
                               "การส่งออก จำนวน : " vExpCount2  " รายการ" VIEW-AS ALERT-BOX INFORMATION.
    
                    ra_credit = 2.
                END.      /*1 => credit */
                IF ra_credit = 2 THEN DO :                   /* over due  2*/
                      RUN pdFileName.
                      RUN pd70out.
                      RUN pd72out.
                      
                    MESSAGE  "ทำการ Dump ข้อมูล ลง Text File : "  fiFile-Name1  SKIP(1)
                               "การส่งออก จำนวน : " vExpCount1  " รายการ" VIEW-AS ALERT-BOX INFORMATION.
    
                    MESSAGE  "ทำการ Dump ข้อมูล ลง Text File : "  fiFile-Name2  SKIP(1)
                               "การส่งออก จำนวน : " vExpCount2  " รายการ" VIEW-AS ALERT-BOX INFORMATION.
                  ra_credit = 3.
                END.      /*2 => over due */

            /*--- A47-0096
                IF ra_credit = 3 THEN DO :                   /*  with in credit 3 */
                      RUN pdFileName.
                      RUN pd70wcr.
                      RUN pd72wcr.
                      
                    MESSAGE  "ทำการ Dump ข้อมูล ลง Text File : "  fiFile-Name1  SKIP(1)
                               "การส่งออก จำนวน : " vExpCount1  " รายการ" VIEW-AS ALERT-BOX INFORMATION.
    
                    MESSAGE  "ทำการ Dump ข้อมูล ลง Text File : "  fiFile-Name2  SKIP(1)
                               "การส่งออก จำนวน : " vExpCount2  " รายการ" VIEW-AS ALERT-BOX INFORMATION.
                END.      /*3 => with in credit */
            A47-0096 ---*/
    
            MESSAGE  "Export ข้อมูล เสร็จสิ้น "  VIEW-AS ALERT-BOX INFORMATION.
                               
            END.  /*true*/
       END CASE.
       
    END.  /*avail billing*/
    ELSE DO:
    
                MESSAGE  "Begin Time :  "   STRING(TIME, "HH:MM AM") VIEW-AS ALERT-BOX.
    
                RUN pdDel.
                RUN pdProc.   /*create record at billing*/
    
                MESSAGE "End Time :   "  STRING(TIME, "HH:MM AM") VIEW-AS ALERT-BOX.
    
                ra_credit = 1.
                IF ra_credit = 1 THEN DO:  /* credit term + with in credit   */
                        RUN pdFileName.
                        RUN pd70.
                        RUN pd72.
            
                    MESSAGE  "ทำการ Dump ข้อมูล ลง Text File : "  fiFile-Name1  SKIP(1)
                               "การส่งออก จำนวน : " vExpCount1  " รายการ" VIEW-AS ALERT-BOX INFORMATION.
    
                    MESSAGE  "ทำการ Dump ข้อมูล ลง Text File : "  fiFile-Name2  SKIP(1)
                               "การส่งออก จำนวน : " vExpCount2  " รายการ" VIEW-AS ALERT-BOX INFORMATION.
    
                    ra_credit = 2.
                END.      /*1 => credit */
                IF ra_credit = 2 THEN DO :                   /* over due  2*/
                      RUN pdFileName.
                      RUN pd70out.
                      RUN pd72out.
                      
                    MESSAGE  "ทำการ Dump ข้อมูล ลง Text File : "  fiFile-Name1  SKIP(1)
                               "การส่งออก จำนวน : " vExpCount1  " รายการ" VIEW-AS ALERT-BOX INFORMATION.
    
                    MESSAGE  "ทำการ Dump ข้อมูล ลง Text File : "  fiFile-Name2  SKIP(1)
                               "การส่งออก จำนวน : " vExpCount2  " รายการ" VIEW-AS ALERT-BOX INFORMATION.
                  ra_credit = 3.
                END.      /*2 => over due */
    
            /*--- A47-0096
                IF ra_credit = 3 THEN DO :                   /*  with in credit 3 */
                      RUN pdFileName.
                      RUN pd70wcr.
                      RUN pd72wcr.
                      
                    MESSAGE  "ทำการ Dump ข้อมูล ลง Text File : "  fiFile-Name1  SKIP(1)
                               "การส่งออก จำนวน : " vExpCount1  " รายการ" VIEW-AS ALERT-BOX INFORMATION.
    
                    MESSAGE  "ทำการ Dump ข้อมูล ลง Text File : "  fiFile-Name2  SKIP(1)
                               "การส่งออก จำนวน : " vExpCount2  " รายการ" VIEW-AS ALERT-BOX INFORMATION.
                END.      /*3 => with in credit */
            A47-0096 ---*/
    
            MESSAGE  "Export ข้อมูล เสร็จสิ้น "  VIEW-AS ALERT-BOX INFORMATION.
    END. /*else*/


APPLY "ENTRY" TO fiBranch IN FRAME {&FRAME-NAME}.

END. /*DO*/
                    
                 
/*p-----------------*/

/******************************************************* 
/*46-9999  เงื่อไขเดิม ทุกครั้งที่ทำการ find*/
             FOR EACH billing  USE-INDEX billing02              WHERE
                                billing.trndat               = nv_exportdat    AND
                                billing.asdat               = n_asdat             AND
                               (billing.acno1              = fi_ac1                 OR
                                billing.acno1              = fi_ac2                 OR
                                billing.acno1              = fi_ac3                 OR
                                billing.acno1              = fi_ac4                 OR
                                billing.acno1              = fi_ac5                 OR
                                billing.acno1              = fi_ac6                 OR
                                billing.acno1              = fi_ac7                 OR
                                billing.acno1              = fi_ac8                 OR
                                billing.acno1              = fi_ac9                 OR
                                billing.acno1              = fi_ac10               OR
                                billing.acno1              = fi_ac11               OR
                                billing.acno1              = fi_ac12               OR
                                billing.acno1              = fi_ac13               OR
                                billing.acno1              = fi_ac14               OR
                                billing.acno1              = fi_ac15               OR
                                billing.acno1              = fi_ac16               OR
                                billing.acno1              = fi_ac17               OR
                                billing.acno1              = fi_ac18               OR
                                billing.acno1              = fi_ac19               OR
                                billing.acno1              = fi_ac20               OR
                                billing.acno1              = fi_ac21               OR
                                billing.acno1              = fi_ac22               OR
                                billing.acno1              = fi_ac23               OR
                                billing.acno1              = fi_ac24               OR
                                billing.acno1              = fi_ac25               OR
                                billing.acno1              = fi_ac26               OR
                                billing.acno1              = fi_ac27               OR        
                                billing.acno1              = fi_ac28               OR
                                billing.acno1              = fi_ac29               OR
                                billing.acno1              = fi_ac30 )          AND
                               (billing.branch           >= fiBranch          AND
                                billing.branch           <= fiBranch2)     AND
                    /*k*/   (billing.trndat1       >= n_trndatF   AND    billing.trndat1       <= n_trndatT)    AND
/*k---                       (billing.start_date     >= n_trndatF  and 
                                 billing.start_date     <= n_trndatT) and
---k*/
                                billing.credit            = nv_credit  .
                      DELETE billing.
             END.   /*billing*/

*******************************************************/

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buBranch
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buBranch C-Win
ON CHOOSE OF buBranch IN FRAME DEFAULT-FRAME /* ... */
DO:

   n_chkBName = "1". 
  RUN Whp\Whpbran(input-output  n_bdes,input-output n_chkBName).
  
  Assign    
        fibranch = n_branch
        fibdes   = n_bdes.
       
  Disp fibranch fibdes  with Frame {&Frame-Name}      .
 
 n_branch =  fibranch .

  Return NO-APPLY.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buBranch2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buBranch2 C-Win
ON CHOOSE OF buBranch2 IN FRAME DEFAULT-FRAME /* ... */
DO:
   n_chkBName = "2". 
  RUN Whp\Whpbran(input-output  n_bdes,input-output n_chkBName).
  
  Assign    
        fibranch2 = n_branch2
        fibdes2   = n_bdes.
       
  Disp fibranch2 fibdes2  with Frame {&Frame-Name}      .
 
 n_branch2 =  fibranch2.

  Return NO-APPLY.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_acno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_acno C-Win
ON CHOOSE OF bu_acno IN FRAME DEFAULT-FRAME /* ... */
DO:
      run wac\wactis2.
      ASSIGN
      fi_ac1   = nv_ac1
      fi_ac2   = nv_ac2
      fi_ac3   = nv_ac3
      fi_ac4   = nv_ac4
      fi_ac5   = nv_ac5
      fi_ac6   = nv_ac6
      fi_ac7   = nv_ac7
      fi_ac8   = nv_ac8
      fi_ac9   = nv_ac9
      fi_ac10 = nv_ac10
      fi_ac11 = nv_ac11     
      fi_ac12 = nv_ac12
      fi_ac13 = nv_ac13     
      fi_ac14 = nv_ac14
      fi_ac15 = nv_ac15
      fi_ac16 = nv_ac16
      fi_ac17 = nv_ac17
      fi_ac18 = nv_ac18
      fi_ac19 = nv_ac19
      fi_ac20 = nv_ac20
      fi_ac21 = nv_ac21
      fi_ac22 = nv_ac22
      fi_ac23 = nv_ac23
      fi_ac24 = nv_ac24
      fi_ac25 = nv_ac25
      fi_ac26 = nv_ac26
      fi_ac27 = nv_ac27
      fi_ac28 = nv_ac28
      /*--- A500178 ---
      fi_ac27 = nv_ac29
      fi_ac28 = nv_ac30
      ------*/
          .
      DISP fi_ac1    fi_ac2   fi_ac3   fi_ac4    fi_ac5    
           fi_ac6    fi_ac7   fi_ac8   fi_ac9    fi_ac10
           fi_ac11   fi_ac12  fi_ac13  fi_ac14  fi_ac15   
           fi_ac16   fi_ac17  fi_ac18  fi_ac19  fi_ac20
           fi_ac21   fi_ac22  fi_ac23  fi_ac24  fi_ac25   
           fi_ac26   fi_ac27  fi_ac28  /*fi_ac29  fi_ac30---A500178 ---*/
      WITH FRAME {&FRAME-NAME}.
      

/*
      n_chkBName = "1". 
      RUN Whp\Whpbran(input-output  n_bdes,input-output n_chkBName).
  
      Assign    
          fibranch = n_branch
          fibdes   = n_bdes.
       
      Disp fibranch fibdes  with Frame {&Frame-Name}      .
      n_branch =  fibranch .
     Return NO-APPLY.    
*/

       APPLY "ENTRY" TO fi_ac1 IN FRAME {&FRAME-NAME}.
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
       APPLY "ENTRY" TO ra_credit IN FRAME {&FRAME-NAME}.
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
/*-------------p*/              

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiBranch
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiBranch C-Win
ON LEAVE OF fiBranch IN FRAME DEFAULT-FRAME
DO:
  Assign
         fibranch = input fibranch
         n_branch = fibranch.

    DISP CAPS(fibranch) @ fibranch WITH FRAME {&FRAME-NAME}.
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiBranch C-Win
ON RETURN OF fiBranch IN FRAME DEFAULT-FRAME
DO:
  Assign
    fibranch = input fibranch
    n_branch  = fibranch.
  
    FIND   xmm023 WHERE xmm023.branch = n_branch  NO-ERROR.
  IF AVAILABLE xmm023 THEN DO:
          fibdes:Screen-value IN FRAME {&FRAME-NAME} = xmm023.bdes.

          APPLY "ENTRY" TO fibranch2 IN FRAME {&FRAME-NAME}.
          RETURN NO-APPLY.                           
          
  END.        
  ELSE DO:
          fibdes:Screen-value IN FRAME {&FRAME-NAME} = "Not Found !".
          MESSAGE "ไม่พบข้อมูล" VIEW-AS ALERT-BOX  warning TITLE "Confirm" .
  END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiBranch2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiBranch2 C-Win
ON LEAVE OF fiBranch2 IN FRAME DEFAULT-FRAME
DO:

    DO WITH FRAME {&FRAME-NAME}:
        Assign
            fibranch2 = input fibranch2
            n_branch2  = fibranch2.
       DISP CAPS(fibranch2)@ fibranch2 .         
                
        APPLY "ENTRY" TO fi_ac1.
    END.
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiBranch2 C-Win
ON RETURN OF fiBranch2 IN FRAME DEFAULT-FRAME
DO:
  Assign
  fibranch2 = input fibranch2
  n_branch2  = fibranch2.
  
    FIND   xmm023 WHERE xmm023.branch = n_branch2  NO-ERROR.
  IF AVAILABLE xmm023 THEN DO:
        fibdes2:Screen-value IN FRAME {&FRAME-NAME} = xmm023.bdes.
        APPLY "ENTRY" TO fi_ac1 IN FRAME {&FRAME-NAME}.
        RETURN NO-APPLY.               
  END.        
  ELSE DO:
          fibdes2:Screen-value IN FRAME {&FRAME-NAME} = "Not Found !".
          MESSAGE "ไม่พบข้อมูล" VIEW-AS ALERT-BOX  warning TITLE "Confirm" .
  END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiFile-Name1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiFile-Name1 C-Win
ON LEAVE OF fiFile-Name1 IN FRAME DEFAULT-FRAME
DO:

        fiFile-Name1 = INPUT fiFile-Name1.
        n_OutputFile1  =  fiFile-Name1.

  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiFile-Name1 C-Win
ON RETURN OF fiFile-Name1 IN FRAME DEFAULT-FRAME
DO:
          APPLY "ENTRY" TO fiFile-Name2 IN FRAME {&FRAME-NAME}.
          RETURN NO-APPLY.         
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiFile-Name2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiFile-Name2 C-Win
ON LEAVE OF fiFile-Name2 IN FRAME DEFAULT-FRAME
DO:

        fiFile-Name2 = INPUT fiFile-Name2.
       n_OutputFile2  =  fiFile-Name2.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiFile-Name2 C-Win
ON RETURN OF fiFile-Name2 IN FRAME DEFAULT-FRAME
DO:
          APPLY "ENTRY" TO btn_ok IN FRAME {&FRAME-NAME}.
          RETURN NO-APPLY.         
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_ac1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_ac1 C-Win
ON LEAVE OF fi_ac1 IN FRAME DEFAULT-FRAME
DO:
    fi_ac1 = INPUT fi_ac1.
    
/*p---------------------------------------------------*/
   IF fi_ac1 <> '' THEN DO:
      FIND FIRST xmm600 WHERE  xmm600.acno = fi_ac1 NO-LOCK NO-ERROR NO-WAIT.
      IF AVAIL xmm600 THEN             
           DISP fi_ac1 WITH FRAME {&FRAME-NAME}.
      ELSE DO:      
          MESSAGE "Producer Code not found".        
          DISP   fi_ac1  WITH FRAME {&FRAME-NAME}.
          APPLY "Entry" To fi_ac1 IN FRAME {&FRAME-NAME}.
          RETURN NO-APPLY.             
      END. /*not in xmm600*/      
  END. /*<> */                                                   
/*---------------------------------------------------p*/

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_ac10
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_ac10 C-Win
ON LEAVE OF fi_ac10 IN FRAME DEFAULT-FRAME
DO:
    fi_ac1 = INPUT fi_ac1.
    
/*p---------------------------------------------------*/
   IF fi_ac1 <> '' THEN DO:
      FIND FIRST xmm600 WHERE  xmm600.acno = fi_ac1 NO-LOCK NO-ERROR NO-WAIT.
      IF AVAIL xmm600 THEN             
           DISP fi_ac1 WITH FRAME {&FRAME-NAME}.
      ELSE DO:      
          MESSAGE "Producer Code not found".        
          DISP   fi_ac1  WITH FRAME {&FRAME-NAME}.
          APPLY "Entry" To fi_ac1 IN FRAME {&FRAME-NAME}.
          RETURN NO-APPLY.             
      END. /*not in xmm600*/      
  END. /*<> */                                                   
/*---------------------------------------------------p*/

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_ac11
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_ac11 C-Win
ON LEAVE OF fi_ac11 IN FRAME DEFAULT-FRAME
DO:
    fi_ac1 = INPUT fi_ac1.
    
/*p---------------------------------------------------*/
   IF fi_ac1 <> '' THEN DO:
      FIND FIRST xmm600 WHERE  xmm600.acno = fi_ac1 NO-LOCK NO-ERROR NO-WAIT.
      IF AVAIL xmm600 THEN             
           DISP fi_ac1 WITH FRAME {&FRAME-NAME}.
      ELSE DO:      
          MESSAGE "Producer Code not found".        
          DISP   fi_ac1  WITH FRAME {&FRAME-NAME}.
          APPLY "Entry" To fi_ac1 IN FRAME {&FRAME-NAME}.
          RETURN NO-APPLY.             
      END. /*not in xmm600*/      
  END. /*<> */                                                   
/*---------------------------------------------------p*/

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_ac12
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_ac12 C-Win
ON LEAVE OF fi_ac12 IN FRAME DEFAULT-FRAME
DO:
    fi_ac1 = INPUT fi_ac1.
    
/*p---------------------------------------------------*/
   IF fi_ac1 <> '' THEN DO:
      FIND FIRST xmm600 WHERE  xmm600.acno = fi_ac1 NO-LOCK NO-ERROR NO-WAIT.
      IF AVAIL xmm600 THEN             
           DISP fi_ac1 WITH FRAME {&FRAME-NAME}.
      ELSE DO:      
          MESSAGE "Producer Code not found".        
          DISP   fi_ac1  WITH FRAME {&FRAME-NAME}.
          APPLY "Entry" To fi_ac1 IN FRAME {&FRAME-NAME}.
          RETURN NO-APPLY.             
      END. /*not in xmm600*/      
  END. /*<> */                                                   
/*---------------------------------------------------p*/

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_ac13
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_ac13 C-Win
ON LEAVE OF fi_ac13 IN FRAME DEFAULT-FRAME
DO:
    fi_ac1 = INPUT fi_ac1.
    
/*p---------------------------------------------------*/
   IF fi_ac1 <> '' THEN DO:
      FIND FIRST xmm600 WHERE  xmm600.acno = fi_ac1 NO-LOCK NO-ERROR NO-WAIT.
      IF AVAIL xmm600 THEN             
           DISP fi_ac1 WITH FRAME {&FRAME-NAME}.
      ELSE DO:      
          MESSAGE "Producer Code not found".        
          DISP   fi_ac1  WITH FRAME {&FRAME-NAME}.
          APPLY "Entry" To fi_ac1 IN FRAME {&FRAME-NAME}.
          RETURN NO-APPLY.             
      END. /*not in xmm600*/      
  END. /*<> */                                                   
/*---------------------------------------------------p*/

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_ac14
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_ac14 C-Win
ON LEAVE OF fi_ac14 IN FRAME DEFAULT-FRAME
DO:
    fi_ac1 = INPUT fi_ac1.
    
/*p---------------------------------------------------*/
   IF fi_ac1 <> '' THEN DO:
      FIND FIRST xmm600 WHERE  xmm600.acno = fi_ac1 NO-LOCK NO-ERROR NO-WAIT.
      IF AVAIL xmm600 THEN             
           DISP fi_ac1 WITH FRAME {&FRAME-NAME}.
      ELSE DO:      
          MESSAGE "Producer Code not found".        
          DISP   fi_ac1  WITH FRAME {&FRAME-NAME}.
          APPLY "Entry" To fi_ac1 IN FRAME {&FRAME-NAME}.
          RETURN NO-APPLY.             
      END. /*not in xmm600*/      
  END. /*<> */                                                   
/*---------------------------------------------------p*/

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_ac15
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_ac15 C-Win
ON LEAVE OF fi_ac15 IN FRAME DEFAULT-FRAME
DO:
    fi_ac1 = INPUT fi_ac1.
    
/*p---------------------------------------------------*/
   IF fi_ac1 <> '' THEN DO:
      FIND FIRST xmm600 WHERE  xmm600.acno = fi_ac1 NO-LOCK NO-ERROR NO-WAIT.
      IF AVAIL xmm600 THEN             
           DISP fi_ac1 WITH FRAME {&FRAME-NAME}.
      ELSE DO:      
          MESSAGE "Producer Code not found".        
          DISP   fi_ac1  WITH FRAME {&FRAME-NAME}.
          APPLY "Entry" To fi_ac1 IN FRAME {&FRAME-NAME}.
          RETURN NO-APPLY.             
      END. /*not in xmm600*/      
  END. /*<> */                                                   
/*---------------------------------------------------p*/

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_ac16
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_ac16 C-Win
ON LEAVE OF fi_ac16 IN FRAME DEFAULT-FRAME
DO:
    fi_ac1 = INPUT fi_ac1.
    
/*p---------------------------------------------------*/
   IF fi_ac1 <> '' THEN DO:
      FIND FIRST xmm600 WHERE  xmm600.acno = fi_ac1 NO-LOCK NO-ERROR NO-WAIT.
      IF AVAIL xmm600 THEN             
           DISP fi_ac1 WITH FRAME {&FRAME-NAME}.
      ELSE DO:      
          MESSAGE "Producer Code not found".        
          DISP   fi_ac1  WITH FRAME {&FRAME-NAME}.
          APPLY "Entry" To fi_ac1 IN FRAME {&FRAME-NAME}.
          RETURN NO-APPLY.             
      END. /*not in xmm600*/      
  END. /*<> */                                                   
/*---------------------------------------------------p*/

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_ac17
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_ac17 C-Win
ON LEAVE OF fi_ac17 IN FRAME DEFAULT-FRAME
DO:
    fi_ac1 = INPUT fi_ac1.
    
/*p---------------------------------------------------*/
   IF fi_ac1 <> '' THEN DO:
      FIND FIRST xmm600 WHERE  xmm600.acno = fi_ac1 NO-LOCK NO-ERROR NO-WAIT.
      IF AVAIL xmm600 THEN             
           DISP fi_ac1 WITH FRAME {&FRAME-NAME}.
      ELSE DO:      
          MESSAGE "Producer Code not found".        
          DISP   fi_ac1  WITH FRAME {&FRAME-NAME}.
          APPLY "Entry" To fi_ac1 IN FRAME {&FRAME-NAME}.
          RETURN NO-APPLY.             
      END. /*not in xmm600*/      
  END. /*<> */                                                   
/*---------------------------------------------------p*/

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_ac18
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_ac18 C-Win
ON LEAVE OF fi_ac18 IN FRAME DEFAULT-FRAME
DO:
    fi_ac1 = INPUT fi_ac1.
    
/*p---------------------------------------------------*/
   IF fi_ac1 <> '' THEN DO:
      FIND FIRST xmm600 WHERE  xmm600.acno = fi_ac1 NO-LOCK NO-ERROR NO-WAIT.
      IF AVAIL xmm600 THEN             
           DISP fi_ac1 WITH FRAME {&FRAME-NAME}.
      ELSE DO:      
          MESSAGE "Producer Code not found".        
          DISP   fi_ac1  WITH FRAME {&FRAME-NAME}.
          APPLY "Entry" To fi_ac1 IN FRAME {&FRAME-NAME}.
          RETURN NO-APPLY.             
      END. /*not in xmm600*/      
  END. /*<> */                                                   
/*---------------------------------------------------p*/

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_ac19
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_ac19 C-Win
ON LEAVE OF fi_ac19 IN FRAME DEFAULT-FRAME
DO:
    fi_ac1 = INPUT fi_ac1.
    
/*p---------------------------------------------------*/
   IF fi_ac1 <> '' THEN DO:
      FIND FIRST xmm600 WHERE  xmm600.acno = fi_ac1 NO-LOCK NO-ERROR NO-WAIT.
      IF AVAIL xmm600 THEN             
           DISP fi_ac1 WITH FRAME {&FRAME-NAME}.
      ELSE DO:      
          MESSAGE "Producer Code not found".        
          DISP   fi_ac1  WITH FRAME {&FRAME-NAME}.
          APPLY "Entry" To fi_ac1 IN FRAME {&FRAME-NAME}.
          RETURN NO-APPLY.             
      END. /*not in xmm600*/      
  END. /*<> */                                                   
/*---------------------------------------------------p*/

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_ac2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_ac2 C-Win
ON LEAVE OF fi_ac2 IN FRAME DEFAULT-FRAME
DO:
    fi_ac1 = INPUT fi_ac1.
    
/*p---------------------------------------------------*/
   IF fi_ac1 <> '' THEN DO:
      FIND FIRST xmm600 WHERE  xmm600.acno = fi_ac1 NO-LOCK NO-ERROR NO-WAIT.
      IF AVAIL xmm600 THEN             
           DISP fi_ac1 WITH FRAME {&FRAME-NAME}.
      ELSE DO:      
          MESSAGE "Producer Code not found".        
          DISP   fi_ac1  WITH FRAME {&FRAME-NAME}.
          APPLY "Entry" To fi_ac1 IN FRAME {&FRAME-NAME}.
          RETURN NO-APPLY.             
      END. /*not in xmm600*/      
  END. /*<> */                                                   
/*---------------------------------------------------p*/

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_ac20
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_ac20 C-Win
ON LEAVE OF fi_ac20 IN FRAME DEFAULT-FRAME
DO:
    fi_ac1 = INPUT fi_ac1.
    
/*p---------------------------------------------------*/
   IF fi_ac1 <> '' THEN DO:
      FIND FIRST xmm600 WHERE  xmm600.acno = fi_ac1 NO-LOCK NO-ERROR NO-WAIT.
      IF AVAIL xmm600 THEN             
           DISP fi_ac1 WITH FRAME {&FRAME-NAME}.
      ELSE DO:      
          MESSAGE "Producer Code not found".        
          DISP   fi_ac1  WITH FRAME {&FRAME-NAME}.
          APPLY "Entry" To fi_ac1 IN FRAME {&FRAME-NAME}.
          RETURN NO-APPLY.             
      END. /*not in xmm600*/      
  END. /*<> */                                                   
/*---------------------------------------------------p*/

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_ac21
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_ac21 C-Win
ON LEAVE OF fi_ac21 IN FRAME DEFAULT-FRAME
DO:
    fi_ac1 = INPUT fi_ac1.
    
/*p---------------------------------------------------*/
   IF fi_ac1 <> '' THEN DO:
      FIND FIRST xmm600 WHERE  xmm600.acno = fi_ac1 NO-LOCK NO-ERROR NO-WAIT.
      IF AVAIL xmm600 THEN             
           DISP fi_ac1 WITH FRAME {&FRAME-NAME}.
      ELSE DO:      
          MESSAGE "Producer Code not found".        
          DISP   fi_ac1  WITH FRAME {&FRAME-NAME}.
          APPLY "Entry" To fi_ac1 IN FRAME {&FRAME-NAME}.
          RETURN NO-APPLY.             
      END. /*not in xmm600*/      
  END. /*<> */                                                   
/*---------------------------------------------------p*/

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_ac22
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_ac22 C-Win
ON LEAVE OF fi_ac22 IN FRAME DEFAULT-FRAME
DO:
    fi_ac1 = INPUT fi_ac1.
    
/*p---------------------------------------------------*/
   IF fi_ac1 <> '' THEN DO:
      FIND FIRST xmm600 WHERE  xmm600.acno = fi_ac1 NO-LOCK NO-ERROR NO-WAIT.
      IF AVAIL xmm600 THEN             
           DISP fi_ac1 WITH FRAME {&FRAME-NAME}.
      ELSE DO:      
          MESSAGE "Producer Code not found".        
          DISP   fi_ac1  WITH FRAME {&FRAME-NAME}.
          APPLY "Entry" To fi_ac1 IN FRAME {&FRAME-NAME}.
          RETURN NO-APPLY.             
      END. /*not in xmm600*/      
  END. /*<> */                                                   
/*---------------------------------------------------p*/

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_ac23
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_ac23 C-Win
ON LEAVE OF fi_ac23 IN FRAME DEFAULT-FRAME
DO:
    fi_ac1 = INPUT fi_ac1.
    
/*p---------------------------------------------------*/
   IF fi_ac1 <> '' THEN DO:
      FIND FIRST xmm600 WHERE  xmm600.acno = fi_ac1 NO-LOCK NO-ERROR NO-WAIT.
      IF AVAIL xmm600 THEN             
           DISP fi_ac1 WITH FRAME {&FRAME-NAME}.
      ELSE DO:      
          MESSAGE "Producer Code not found".        
          DISP   fi_ac1  WITH FRAME {&FRAME-NAME}.
          APPLY "Entry" To fi_ac1 IN FRAME {&FRAME-NAME}.
          RETURN NO-APPLY.             
      END. /*not in xmm600*/      
  END. /*<> */                                                   
/*---------------------------------------------------p*/

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_ac24
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_ac24 C-Win
ON LEAVE OF fi_ac24 IN FRAME DEFAULT-FRAME
DO:
    fi_ac1 = INPUT fi_ac1.
    
/*p---------------------------------------------------*/
   IF fi_ac1 <> '' THEN DO:
      FIND FIRST xmm600 WHERE  xmm600.acno = fi_ac1 NO-LOCK NO-ERROR NO-WAIT.
      IF AVAIL xmm600 THEN             
           DISP fi_ac1 WITH FRAME {&FRAME-NAME}.
      ELSE DO:      
          MESSAGE "Producer Code not found".        
          DISP   fi_ac1  WITH FRAME {&FRAME-NAME}.
          APPLY "Entry" To fi_ac1 IN FRAME {&FRAME-NAME}.
          RETURN NO-APPLY.             
      END. /*not in xmm600*/      
  END. /*<> */                                                   
/*---------------------------------------------------p*/

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_ac25
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_ac25 C-Win
ON LEAVE OF fi_ac25 IN FRAME DEFAULT-FRAME
DO:
    fi_ac1 = INPUT fi_ac1.
    
/*p---------------------------------------------------*/
   IF fi_ac1 <> '' THEN DO:
      FIND FIRST xmm600 WHERE  xmm600.acno = fi_ac1 NO-LOCK NO-ERROR NO-WAIT.
      IF AVAIL xmm600 THEN             
           DISP fi_ac1 WITH FRAME {&FRAME-NAME}.
      ELSE DO:      
          MESSAGE "Producer Code not found".        
          DISP   fi_ac1  WITH FRAME {&FRAME-NAME}.
          APPLY "Entry" To fi_ac1 IN FRAME {&FRAME-NAME}.
          RETURN NO-APPLY.             
      END. /*not in xmm600*/      
  END. /*<> */                                                   
/*---------------------------------------------------p*/

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_ac26
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_ac26 C-Win
ON LEAVE OF fi_ac26 IN FRAME DEFAULT-FRAME
DO:
    fi_ac1 = INPUT fi_ac1.
    
/*p---------------------------------------------------*/
   IF fi_ac1 <> '' THEN DO:
      FIND FIRST xmm600 WHERE  xmm600.acno = fi_ac1 NO-LOCK NO-ERROR NO-WAIT.
      IF AVAIL xmm600 THEN             
           DISP fi_ac1 WITH FRAME {&FRAME-NAME}.
      ELSE DO:      
          MESSAGE "Producer Code not found".        
          DISP   fi_ac1  WITH FRAME {&FRAME-NAME}.
          APPLY "Entry" To fi_ac1 IN FRAME {&FRAME-NAME}.
          RETURN NO-APPLY.             
      END. /*not in xmm600*/      
  END. /*<> */                                                   
/*---------------------------------------------------p*/

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_ac27
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_ac27 C-Win
ON LEAVE OF fi_ac27 IN FRAME DEFAULT-FRAME
DO:
    fi_ac1 = INPUT fi_ac1.
    
/*p---------------------------------------------------*/
   IF fi_ac1 <> '' THEN DO:
      FIND FIRST xmm600 WHERE  xmm600.acno = fi_ac1 NO-LOCK NO-ERROR NO-WAIT.
      IF AVAIL xmm600 THEN             
           DISP fi_ac1 WITH FRAME {&FRAME-NAME}.
      ELSE DO:      
          MESSAGE "Producer Code not found".        
          DISP   fi_ac1  WITH FRAME {&FRAME-NAME}.
          APPLY "Entry" To fi_ac1 IN FRAME {&FRAME-NAME}.
          RETURN NO-APPLY.             
      END. /*not in xmm600*/      
  END. /*<> */                                                   
/*---------------------------------------------------p*/

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_ac28
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_ac28 C-Win
ON LEAVE OF fi_ac28 IN FRAME DEFAULT-FRAME
DO:
    fi_ac1 = INPUT fi_ac1.
    
/*p---------------------------------------------------*/
   IF fi_ac1 <> '' THEN DO:
      FIND FIRST xmm600 WHERE  xmm600.acno = fi_ac1 NO-LOCK NO-ERROR NO-WAIT.
      IF AVAIL xmm600 THEN             
           DISP fi_ac1 WITH FRAME {&FRAME-NAME}.
      ELSE DO:      
          MESSAGE "Producer Code not found".        
          DISP   fi_ac1  WITH FRAME {&FRAME-NAME}.
          APPLY "Entry" To fi_ac1 IN FRAME {&FRAME-NAME}.
          RETURN NO-APPLY.             
      END. /*not in xmm600*/      
  END. /*<> */                                                   
/*---------------------------------------------------p*/

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_ac3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_ac3 C-Win
ON LEAVE OF fi_ac3 IN FRAME DEFAULT-FRAME
DO:
    fi_ac1 = INPUT fi_ac1.
    
/*p---------------------------------------------------*/
   IF fi_ac1 <> '' THEN DO:
      FIND FIRST xmm600 WHERE  xmm600.acno = fi_ac1 NO-LOCK NO-ERROR NO-WAIT.
      IF AVAIL xmm600 THEN             
           DISP fi_ac1 WITH FRAME {&FRAME-NAME}.
      ELSE DO:      
          MESSAGE "Producer Code not found".        
          DISP   fi_ac1  WITH FRAME {&FRAME-NAME}.
          APPLY "Entry" To fi_ac1 IN FRAME {&FRAME-NAME}.
          RETURN NO-APPLY.             
      END. /*not in xmm600*/      
  END. /*<> */                                                   
/*---------------------------------------------------p*/

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_ac4
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_ac4 C-Win
ON LEAVE OF fi_ac4 IN FRAME DEFAULT-FRAME
DO:
    fi_ac1 = INPUT fi_ac1.
    
/*p---------------------------------------------------*/
   IF fi_ac1 <> '' THEN DO:
      FIND FIRST xmm600 WHERE  xmm600.acno = fi_ac1 NO-LOCK NO-ERROR NO-WAIT.
      IF AVAIL xmm600 THEN             
           DISP fi_ac1 WITH FRAME {&FRAME-NAME}.
      ELSE DO:      
          MESSAGE "Producer Code not found".        
          DISP   fi_ac1  WITH FRAME {&FRAME-NAME}.
          APPLY "Entry" To fi_ac1 IN FRAME {&FRAME-NAME}.
          RETURN NO-APPLY.             
      END. /*not in xmm600*/      
  END. /*<> */                                                   
/*---------------------------------------------------p*/

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_ac5
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_ac5 C-Win
ON LEAVE OF fi_ac5 IN FRAME DEFAULT-FRAME
DO:
    fi_ac1 = INPUT fi_ac1.
    
/*p---------------------------------------------------*/
   IF fi_ac1 <> '' THEN DO:
      FIND FIRST xmm600 WHERE  xmm600.acno = fi_ac1 NO-LOCK NO-ERROR NO-WAIT.
      IF AVAIL xmm600 THEN             
           DISP fi_ac1 WITH FRAME {&FRAME-NAME}.
      ELSE DO:      
          MESSAGE "Producer Code not found".        
          DISP   fi_ac1  WITH FRAME {&FRAME-NAME}.
          APPLY "Entry" To fi_ac1 IN FRAME {&FRAME-NAME}.
          RETURN NO-APPLY.             
      END. /*not in xmm600*/      
  END. /*<> */                                                   
/*---------------------------------------------------p*/

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_ac6
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_ac6 C-Win
ON LEAVE OF fi_ac6 IN FRAME DEFAULT-FRAME
DO:
    fi_ac1 = INPUT fi_ac1.
    
/*p---------------------------------------------------*/
   IF fi_ac1 <> '' THEN DO:
      FIND FIRST xmm600 WHERE  xmm600.acno = fi_ac1 NO-LOCK NO-ERROR NO-WAIT.
      IF AVAIL xmm600 THEN             
           DISP fi_ac1 WITH FRAME {&FRAME-NAME}.
      ELSE DO:      
          MESSAGE "Producer Code not found".        
          DISP   fi_ac1  WITH FRAME {&FRAME-NAME}.
          APPLY "Entry" To fi_ac1 IN FRAME {&FRAME-NAME}.
          RETURN NO-APPLY.             
      END. /*not in xmm600*/      
  END. /*<> */                                                   
/*---------------------------------------------------p*/

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_ac7
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_ac7 C-Win
ON LEAVE OF fi_ac7 IN FRAME DEFAULT-FRAME
DO:
    fi_ac1 = INPUT fi_ac1.
    
/*p---------------------------------------------------*/
   IF fi_ac1 <> '' THEN DO:
      FIND FIRST xmm600 WHERE  xmm600.acno = fi_ac1 NO-LOCK NO-ERROR NO-WAIT.
      IF AVAIL xmm600 THEN             
           DISP fi_ac1 WITH FRAME {&FRAME-NAME}.
      ELSE DO:      
          MESSAGE "Producer Code not found".        
          DISP   fi_ac1  WITH FRAME {&FRAME-NAME}.
          APPLY "Entry" To fi_ac1 IN FRAME {&FRAME-NAME}.
          RETURN NO-APPLY.             
      END. /*not in xmm600*/      
  END. /*<> */                                                   
/*---------------------------------------------------p*/

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_ac8
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_ac8 C-Win
ON LEAVE OF fi_ac8 IN FRAME DEFAULT-FRAME
DO:
    fi_ac1 = INPUT fi_ac1.
    
/*p---------------------------------------------------*/
   IF fi_ac1 <> '' THEN DO:
      FIND FIRST xmm600 WHERE  xmm600.acno = fi_ac1 NO-LOCK NO-ERROR NO-WAIT.
      IF AVAIL xmm600 THEN             
           DISP fi_ac1 WITH FRAME {&FRAME-NAME}.
      ELSE DO:      
          MESSAGE "Producer Code not found".        
          DISP   fi_ac1  WITH FRAME {&FRAME-NAME}.
          APPLY "Entry" To fi_ac1 IN FRAME {&FRAME-NAME}.
          RETURN NO-APPLY.             
      END. /*not in xmm600*/      
  END. /*<> */                                                   
/*---------------------------------------------------p*/

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_ac9
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_ac9 C-Win
ON LEAVE OF fi_ac9 IN FRAME DEFAULT-FRAME
DO:
    fi_ac1 = INPUT fi_ac1.
    
/*p---------------------------------------------------*/
   IF fi_ac1 <> '' THEN DO:
      FIND FIRST xmm600 WHERE  xmm600.acno = fi_ac1 NO-LOCK NO-ERROR NO-WAIT.
      IF AVAIL xmm600 THEN             
           DISP fi_ac1 WITH FRAME {&FRAME-NAME}.
      ELSE DO:      
          MESSAGE "Producer Code not found".        
          DISP   fi_ac1  WITH FRAME {&FRAME-NAME}.
          APPLY "Entry" To fi_ac1 IN FRAME {&FRAME-NAME}.
          RETURN NO-APPLY.             
      END. /*not in xmm600*/      
  END. /*<> */                                                   
/*---------------------------------------------------p*/

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_trndatF
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_trndatF C-Win
ON LEAVE OF fi_trndatF IN FRAME DEFAULT-FRAME
DO:
      fi_trndatF = input fi_trndatF.
      n_trndatF = fi_trndatF.      
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_trndatT
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_trndatT C-Win
ON LEAVE OF fi_trndatT IN FRAME DEFAULT-FRAME
DO:
      fi_trndatT = INPUT fi_trndatT.
      n_trndatT = fi_trndatT.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_trndatT C-Win
ON RETURN OF fi_trndatT IN FRAME DEFAULT-FRAME
DO:
       APPLY "ENTRY" TO fiFile-Name1 IN FRAME {&FRAME-NAME}.
       RETURN NO-APPLY.          
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ra_credit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_credit C-Win
ON VALUE-CHANGED OF ra_credit IN FRAME DEFAULT-FRAME
DO:

    DO WITH FRAME {&FRAME-NAME}:

        ra_credit = INPUT ra_credit.
/*        IF ra_credit = 1 THEN DO:
 * 
 *             fi_credit = 60.
 *             ENABLE fi_credit .
 *     
 *         END.  /*1*/
 *         ELSE DO:
 *             DISABLE fi_credit .
 *             fi_credit = 0.
 *     
 *         END.
 *      
 *         DISP fi_credit.*/

    END.

    RUN pdFileName.


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
  
  gv_prgid = "wactis1".
  gv_prog  = "การส่งข้อมูล Text File เพื่อวางบิล Tisco Leasing".
  RUN  WUT\WUTHEAD (c-win:handle,gv_prgid,gv_prog).
  RUN  WUT\WUTDICEN (c-win:HANDLE).

/*********************************************************************/ 
    SESSION:DATA-ENTRY-RETURN = YES.

   RECT-1:move-to-top( ).  
   RECT-2:move-to-top( ).
   RECT-3:move-to-top( ).
   RECT-4:move-to-top( ).
   
   cbAsdat  = vAcProc_fil.   

/*------------------------*/
    RUN pdAcproc_fil.
/*------------------------*/  

/*kan    A46-0463 ---
/*  vAcProc_fil = "" .
 *   FOR EACH AcProc_fil USE-INDEX by_type_asdat  WHERE AcProc_fil.type = "01"
 *                                          BY AcProc_fil.asdat DESC  :
 *         ASSIGN
 *             vAcProc_fil = vAcProc_fil + STRING( AcProc_fil.asdat,"99/99/9999")  + ",".
 *   END.
 * 
 *   ASSIGN
 *     cbAsDat:List-Items IN FRAME {&FRAME-NAME} = vAcProc_fil
 *     cbAsDat = ENTRY (1, vAcProc_fil).
 *     
 *   DISP cbAsDat WITH FRAME {&FRAME-NAME} .*/
---kan*/
  
  SESSION:DATA-ENTRY-RETURN = YES.  
  ASSIGN
      fibranch     = '0'
      fibranch2   = 'z'
      n_branch   = fibranch
      n_branch2 = fibranch2
      fi_process = ""
      n_trndatF = ?
      n_trndatT = ?
      n_OutputFile1 = ""
      n_OutputFile2 = ""
      nv_exportdat = today
      nv_credit  = 60
      ra_credit  = 1.

    RUN pdFileName.

/*****************/

/*kan--
   ASSIGN 
      nv_ac1   = 'A000506'
      nv_ac2   = 'A000616'
      nv_ac3   = 'A000621'
      nv_ac4   = 'A000622'
      nv_ac5   = 'A010001'
      nv_ac6   = 'A020002'
      nv_ac7   = 'A030013'
      nv_ac8   = 'A040093'
      nv_ac9   = 'A040276'
      nv_ac10 = 'A060025'
      nv_ac11 = 'A060039'
      nv_ac12 = 'A070099'
      nv_ac13 = 'A080029'
      nv_ac14 = 'A0E0081'
      nv_ac15 = 'A0M1009'
      nv_ac16 = 'A0M2012'
      nv_ac17 = 'A0M2013'
      nv_ac18 = 'A0M2014'
      nv_ac19 = 'A0M2015'
      nv_ac20 = 'A0N0042'
      nv_ac21 = 'A0S0014'
---kan*/
    ASSIGN
        nv_ac1  = "A000621"
        nv_ac2  = "A000622"
        nv_ac3  = "A000630"
        nv_ac4  = "A000645"
        nv_ac5  = "A010001"
        nv_ac6  = "A020002"
        nv_ac7  = "A030013"
        nv_ac8  = "A040093"
        nv_ac9  = "A060025"
        nv_ac10 = "A070099"
        nv_ac11 = "A080029"
        nv_ac12 = "A0C0004"
        nv_ac13 = "A0E0081"
        nv_ac14 = "A0J0092"
        nv_ac15 = "A0M0013"
        nv_ac16 = "A0M1009"
        nv_ac17 = "A0M1046"
        nv_ac18 = "A0M2008"
        nv_ac19 = "A0M2011"
        nv_ac20 = "A0M2012"
        nv_ac21 = "A0M2014"
        nv_ac22 = "A0M2017"
        nv_ac23 = "A0N0042"
        nv_ac24 = "B020002"

        nv_ac25 = ""
        nv_ac26 = ""
        nv_ac27 = ""
        nv_ac28 = ""
        nv_ac29 = ""
        nv_ac30 = ""

        fi_ac1  = nv_ac1
        fi_ac2  = nv_ac2
        fi_ac3  = nv_ac3
        fi_ac4  = nv_ac4
        fi_ac5  = nv_ac5
        fi_ac6  = nv_ac6
        fi_ac7  = nv_ac7
        fi_ac8  = nv_ac8
        fi_ac9  = nv_ac9
        fi_ac10 = nv_ac10
        fi_ac11 = nv_ac11
        fi_ac12 = nv_ac12
        fi_ac13 = nv_ac13
        fi_ac14 = nv_ac14
        fi_ac15 = nv_ac15
        fi_ac16 = nv_ac16
        fi_ac17 = nv_ac17
        fi_ac18 = nv_ac18
        fi_ac19 = nv_ac19
        fi_ac20 = nv_ac20
        fi_ac21 = nv_ac21
        fi_ac22 = nv_ac22
        fi_ac23 = nv_ac23
        fi_ac24 = nv_ac24
        fi_ac25 = nv_ac25
        fi_ac26 = nv_ac26
        fi_ac27 = nv_ac27
        fi_ac28 = nv_ac28
        /*--- A500178 ---
        fi_ac27 = nv_ac29
        fi_ac28 = nv_ac30
        ------*/
        .
      DISP fi_ac1     fi_ac2    fi_ac3    fi_ac4    fi_ac5    
                fi_ac6     fi_ac7    fi_ac8    fi_ac9    fi_ac10
                fi_ac11   fi_ac12  fi_ac13  fi_ac14  fi_ac15   
                fi_ac16   fi_ac17  fi_ac18  fi_ac19  fi_ac20
                fi_ac21   fi_ac22  fi_ac23  fi_ac24  fi_ac25   
                fi_ac26   fi_ac27  fi_ac28  /*fi_ac29  fi_ac30 --- A500178 ---*/
      WITH FRAME {&FRAME-NAME}.
      
/*****************/

    RUN pdAddAcno.

  DISP fibranch fibranch2 fi_process /*fi_credit */ ra_credit WITH FRAME {&FRAME-NAME}.
  
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
  DISPLAY fiBranch fiBranch2 cbAsDat ra_credit fi_trndatF fi_trndatT 
          fiFile-Name1 fiFile-Name2 fibdes fibdes2 fi_process fi_print fi_ac1 
          fi_ac2 fi_ac3 fi_ac4 fi_ac5 fi_ac6 fi_ac7 fi_ac8 fi_ac9 fi_ac10 
          fi_ac11 fi_ac12 fi_ac13 fi_ac14 fi_ac15 fi_ac16 fi_ac17 fi_ac18 
          fi_ac19 fi_ac20 fi_ac21 fi_ac22 fi_ac23 fi_ac24 fi_ac25 fi_ac26 
          fi_ac27 fi_ac28 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE fiBranch fiBranch2 cbAsDat fi_trndatF fi_trndatT fiFile-Name1 
         fiFile-Name2 Btn_OK Btn_Exit buBranch buBranch2 bu_acno fibdes fibdes2 
         fi_process fi_print fi_ac1 fi_ac2 fi_ac3 fi_ac4 fi_ac5 fi_ac6 fi_ac7 
         fi_ac8 fi_ac9 fi_ac10 fi_ac11 fi_ac12 fi_ac13 fi_ac14 fi_ac15 fi_ac16 
         fi_ac17 fi_ac18 fi_ac19 fi_ac20 fi_ac21 fi_ac22 fi_ac23 fi_ac24 
         fi_ac25 fi_ac26 fi_ac27 fi_ac28 RECT-1 RECT-2 RECT-3 RECT-4 RECT-5 
         RECT-6 RECT-7 RECT-8 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd70 C-Win 
PROCEDURE pd70 :
/*------------------------------------------------------------------------------
  Purpose:     /*due + wcr */
  Parameters:  
  Notes:             volunteer (70)   
------------------------------------------------------------------------------*/
vExpCount1= 0.

OUTPUT STREAM filebill1 TO VALUE(fiFile-Name1).
OUTPUT STREAM filebill1 CLOSE.

OUTPUT STREAM filebill1ex TO VALUE(STRING( fiFile-Name1 )+ "X").
    {wac\wactis02.i}   /* head excel*/
OUTPUT STREAM filebill1ex CLOSE.

    n_row1 = 2.
    
/*----------------------------*/           
IF ra_credit = 1 THEN DO:  /* over due*/
    loop1:
    FOR EACH wbill  USE-INDEX wbill02  WHERE
                                wbill.wtrndat = nv_exportdat AND
                                wbill.wasdat = n_asdat          AND
                                (LOOKUP(wbill.wacno,nv_acnoAll) <> 0 ) AND  /* A46-0426*/
                                wbill.wpoltyp      = 'v70'   AND
                               (wbill.wtrndat1   >= n_trndatF   AND wbill.wtrndat1  <= n_trndatT) AND
                               (wbill.wdamt   > 0  OR wbill.wwcr   > 0 )            /*--- A47-0096  wbill.wdamt      > 0 ---*/

                              BREAK BY wbill.wtrndat1  BY wbill.wpolicy  BY wbill.wendno: 
    
        FIND billing WHERE RECID(billing) = wbill.wrecid NO-ERROR.
        IF AVAIL billing THEN DO:

            DISP
                billing.acno  billing.start_date  billing.policy  billing.trnty1 billing.docno  FORMAT "X(10)" /* Benjaporn J. A60-0267 date 27/06/2017 */
            WITH COLOR BLACK/WHITE  NO-LABEL  FRAME fr70 VIEW-AS DIALOG-BOX  TITLE "Process ... " . 

            OUTPUT STREAM filebill1 TO VALUE(fiFile-Name1) APPEND .
                {wac\wactis06.i }   /* detail text file*/
            OUTPUT STREAM filebill1 CLOSE.
                        
            /* text to tisco excel*/
            OUTPUT STREAM filebill1ex TO VALUE(STRING( fiFile-Name1 )+ "X") APPEND.
                {wac\wactis03.i}   /* detail excel*/
            OUTPUT STREAM filebill1ex CLOSE.
            
            DISP "Print : " + billing.policy  @ fi_print
            WITH FRAME {&FRAME-NAME}.

                vExpCount1= vExpCount1 + 1.
        
        END. /* IF AVAIL billing */
    
    END.  /* for each wbill */
    
    OUTPUT STREAM filebill1ex TO VALUE(STRING( fiFile-Name1 )+ "X") APPEND.
        PUT STREAM  filebill1ex  "E"  skip.      
    OUTPUT STREAM filebill1ex CLOSE.

END.

/*----------------------------*/


/*--- kan comment file backup
    vBackUp =  fiFile-Name1 + "B".
    DOS SILENT  COPY VALUE(fiFile-Name1) VALUE(vBackUP) /Y  .   /* backup file exports */
end ---*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd70out C-Win 
PROCEDURE pd70out :
/*------------------------------------------------------------------------------
  Purpose:     /* over due*/
  Parameters:  
  Notes:            volunteer (70)   
------------------------------------------------------------------------------*/
vExpCount1= 0.

OUTPUT STREAM filebill1 TO VALUE(fiFile-Name1).
OUTPUT STREAM filebill1 CLOSE.

OUTPUT STREAM filebill1ex TO VALUE(STRING( fiFile-Name1 )+ "X").
    {wac\wactis02.i}   /* head excel*/
OUTPUT STREAM filebill1ex CLOSE.

    n_row1 = 2.
    
/*----------------------------*/           
IF ra_credit = 2 THEN DO:  /* over due*/
    loop1:
    FOR EACH wbill  USE-INDEX wbill02  WHERE
                                wbill.wtrndat = nv_exportdat AND
                                wbill.wasdat = n_asdat          AND
                                (LOOKUP(wbill.wacno,nv_acnoAll) <> 0 ) AND  /* A46-0426*/
                                wbill.wpoltyp      = 'v70'   AND
                               (wbill.wtrndat1   >= n_trndatF   AND    wbill.wtrndat1  <= n_trndatT) AND
                                wbill.wodue      > 0
                              BREAK BY wbill.wtrndat1  BY wbill.wpolicy BY wbill.wendno: 
    
        FIND billing WHERE RECID(billing) = wbill.wrecid NO-ERROR.
        IF AVAIL billing THEN DO:

            DISP
                billing.acno  billing.start_date  billing.policy  billing.trnty1 billing.docno  FORMAT "X(10)" /* Benjaporn J. A60-0267 date 27/06/2017 */
            WITH COLOR BLACK/WHITE  NO-LABEL  FRAME fr70out VIEW-AS DIALOG-BOX  TITLE "Process ... " . 

            OUTPUT STREAM filebill1 TO VALUE(fiFile-Name1) APPEND .
                {wac\wactis06.i }   /* detail text file*/
            OUTPUT STREAM filebill1 CLOSE.

            /* text to tisco excel*/
            OUTPUT STREAM filebill1ex TO VALUE(STRING( fiFile-Name1 )+ "X") APPEND.
                {wac\wactis03.i}   /* detail excel*/
            OUTPUT STREAM filebill1ex CLOSE.

            DISP "Print : " + billing.policy  @ fi_print
            WITH FRAME {&FRAME-NAME}.
       
                vExpCount1= vExpCount1 + 1.
        
        END. /* IF AVAIL billing */
    
    END.  /* for each wbill */

    OUTPUT STREAM filebill1ex TO VALUE(STRING( fiFile-Name1 )+ "X") APPEND.
        PUT STREAM  filebill1ex  "E"  skip.      
    OUTPUT STREAM filebill1ex CLOSE.

END.

/*----------------------------*/

    
/*--- kan comment file backup
    vBackUp =  fiFile-Name1 + "B".
    DOS SILENT  COPY VALUE(fiFile-Name1) VALUE(vBackUP) /Y  .   /* backup file exports */
end ---*/
           
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd70wcr C-Win 
PROCEDURE pd70wcr :
/*--- A47-9999
/*------------------------------------------------------------------------------
  Purpose:     /* with in  credit */
  Parameters: 
  Notes:            volunteer (70)   
------------------------------------------------------------------------------*/
vExpCount1= 0.

OUTPUT STREAM filebill1 TO VALUE(fiFile-Name1).
OUTPUT STREAM filebill1 CLOSE.

OUTPUT STREAM filebill1ex TO VALUE(STRING( fiFile-Name1 )+ "X").
    {wac\wactis02.i}   /* head excel*/
OUTPUT STREAM filebill1ex CLOSE.

    n_row1 = 2.
    
/*----------------------------*/           
IF ra_credit = 3 THEN DO:  /* with in */
    loop1:
    FOR EACH wbill  USE-INDEX wbill02  WHERE
                                wbill.wtrndat = nv_exportdat AND
                                wbill.wasdat = n_asdat          AND
                                (LOOKUP(wbill.wacno,nv_acnoAll) <> 0 ) AND  /* A46-0426*/
                                wbill.wpoltyp      = 'v70'   AND
                               (wbill.wtrndat1   >= n_trndatF   AND    wbill.wtrndat1  <= n_trndatT) AND
                                wbill.wwcr      > 0
                              BREAK BY wbill.wtrndat1  BY wbill.wpolicy  BY wbill.wendno: 
    
        FIND billing WHERE RECID(billing) = wbill.wrecid NO-ERROR.
        IF AVAIL billing THEN DO:
        
            OUTPUT STREAM filebill1 TO VALUE(fiFile-Name1) APPEND.
                {wac\wactis06.i}   /* detail text file*/
            OUTPUT STREAM filebill1 CLOSE.
            
            /* text to tisco excel*/
            OUTPUT STREAM filebill1ex TO VALUE(STRING( fiFile-Name1 )+ "X") APPEND.
                {wac\wactis03.i}   /* detail excel*/
            OUTPUT STREAM filebill1ex CLOSE.
        
            vExpCount1= vExpCount1 + 1.
        
        END. /* IF AVAIL billing */
    
    END.  /* for each wbill */
END.

/*----------------------------*/
    OUTPUT STREAM filebill1ex TO VALUE(STRING( fiFile-Name1 )+ "X") APPEND.
        PUT STREAM  filebill1ex  "E"  skip.      
    OUTPUT STREAM filebill1ex CLOSE.

/*--- kan comment file backup
    vBackUp =  fiFile-Name1 + "B".
    DOS SILENT  COPY VALUE(fiFile-Name1) VALUE(vBackUP) /Y  .   /* backup file exports */
end ---*/
       
---*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd72 C-Win 
PROCEDURE pd72 :
/*------------------------------------------------------------------------------
  Purpose:     /* due + wcr */
  Parameters:  
  Notes:            compulsory (72)    
------------------------------------------------------------------------------*/

vExpCount2= 0.

OUTPUT STREAM filebill2 TO VALUE(fiFile-Name2).
OUTPUT STREAM filebill2 CLOSE.

OUTPUT STREAM filebill2ex TO VALUE(STRING( fiFile-Name2 )+ "X").
    {wac\wactis04.i}   /* 02,04  head excel*/
OUTPUT STREAM filebill2ex CLOSE.

    n_row1 = 2.

/*----------------------------*/
IF ra_credit = 1 THEN DO:  /* due*/
    loop1:
    FOR EACH wbill  USE-INDEX wbill02  WHERE
                                wbill.wtrndat = nv_exportdat AND
                                wbill.wasdat = n_asdat          AND
                                (LOOKUP(wbill.wacno,nv_acnoAll) <> 0 ) AND  /* A46-0426*/

                                wbill.wpoltyp     = 'v72'   AND
                               (wbill.wtrndat1   >= n_trndatF   AND    wbill.wtrndat1  <= n_trndatT) AND
                               (wbill.wdamt   > 0  OR wbill.wwcr   > 0 )              /*--- A47-0096  wbill.wdamt      > 0 ---*/
                              BREAK BY wbill.wtrndat1  BY wbill.wpolicy BY wbill.wendno:
    
        FIND billing WHERE RECID(billing) = wbill.wrecid NO-ERROR.
        IF AVAIL billing THEN DO:
        
            DISP
                billing.acno  billing.start_date  billing.policy  billing.trnty1 billing.docno  FORMAT "X(10)" /* Benjaporn J. A60-0267 date 27/06/2017 */
            WITH COLOR BLACK/WHITE  NO-LABEL  FRAME fr72 VIEW-AS DIALOG-BOX  TITLE "Process ... " . 
        
            OUTPUT STREAM filebill2 TO VALUE(fiFile-Name2) APPEND .
                {wac\wactis07.i}   /* detail text file*/
            OUTPUT STREAM filebill2 CLOSE.

            /* text to tisco excel*/
            OUTPUT STREAM filebill2ex TO VALUE(STRING( fiFile-Name2 )+ "X") APPEND.
                {wac\wactis05.i}   /* detail excel*/
            OUTPUT STREAM filebill2ex CLOSE.

            DISP "Print : " + billing.policy  @ fi_print
            WITH FRAME {&FRAME-NAME}.

                vExpCount2= vExpCount2 + 1.
        
        END. /* IF AVAIL billing */
    END.  /* for each wbill */

    OUTPUT STREAM filebill2ex TO VALUE(STRING( fiFile-Name2 )+ "X") APPEND.
        PUT STREAM  filebill2ex  "E"  skip.      
    OUTPUT STREAM filebill2ex CLOSE.

END.

/*----------------------------*/



/*--- kan comment file backup
    vBackUp =  fiFile-Name2 + "B".
    DOS SILENT  COPY VALUE(fiFile-Name2) VALUE(vBackUP) /Y  .   /* backup file exports */
end ---*/
          
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd72out C-Win 
PROCEDURE pd72out :
/*------------------------------------------------------------------------------
  Purpose:     /* overdue */
  Parameters:  
  Notes:            compulsory (72)    
------------------------------------------------------------------------------*/
vExpCount2= 0.

OUTPUT STREAM filebill2 TO VALUE(fiFile-Name2).
OUTPUT STREAM filebill2 CLOSE.

OUTPUT STREAM filebill2ex TO VALUE(STRING( fiFile-Name2 )+ "X").
    {wac\wactis04.i}   /* 02,04  head excel*/
OUTPUT STREAM filebill2ex CLOSE.

    n_row1 = 2.

/*----------------------------*/
IF ra_credit = 2 THEN DO:  /* over due*/
    loop1:
    FOR EACH wbill  USE-INDEX wbill02  WHERE
                                wbill.wtrndat = nv_exportdat AND
                                wbill.wasdat = n_asdat          AND
                                (LOOKUP(wbill.wacno,nv_acnoAll) <> 0 ) AND  /* A46-0426*/

                                wbill.wpoltyp     = 'v72'   AND
                               (wbill.wtrndat1   >= n_trndatF   AND    wbill.wtrndat1  <= n_trndatT) AND
                                wbill.wodue      > 0
                              BREAK BY wbill.wtrndat1  BY wbill.wpolicy  BY wbill.wendno: 
    
        FIND billing WHERE RECID(billing) = wbill.wrecid NO-ERROR.
        IF AVAIL billing THEN DO:

            DISP
                billing.acno  billing.start_date  billing.policy  billing.trnty1 billing.docno  FORMAT "X(10)" /* Benjaporn J. A60-0267 date 27/06/2017 */
            WITH COLOR BLACK/WHITE  NO-LABEL  FRAME fr72out VIEW-AS DIALOG-BOX  TITLE "Process ... " . 

            OUTPUT STREAM filebill2 TO VALUE(fiFile-Name2) APPEND .
                {wac\wactis07.i}   /* detail text file*/
            OUTPUT STREAM filebill2 CLOSE.

            /* text to tisco excel*/
            OUTPUT STREAM filebill2ex TO VALUE(STRING( fiFile-Name2 )+ "X") APPEND.
                {wac\wactis05.i}   /* detail excel*/
            OUTPUT STREAM filebill2ex CLOSE.
    
            DISP "Print : " + billing.policy  @ fi_print
            WITH FRAME {&FRAME-NAME}.

                vExpCount2= vExpCount2 + 1.
        
        END. /* IF AVAIL billing */
    END.  /* for each wbill */

    OUTPUT STREAM filebill2ex TO VALUE(STRING( fiFile-Name2 )+ "X") APPEND.
        PUT STREAM  filebill2ex  "E"  skip.      
    OUTPUT STREAM filebill2ex CLOSE.

END.

/*----------------------------*/


/*--- kan comment file backup
    vBackUp =  fiFile-Name2 + "B".
    DOS SILENT  COPY VALUE(fiFile-Name2) VALUE(vBackUP) /Y  .   /* backup file exports */
end ---*/
      
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd72wcr C-Win 
PROCEDURE pd72wcr :
/*--- A47-9999
/*------------------------------------------------------------------------------
  Purpose:     /* with in  credit */
  Parameters:  
  Notes:            compulsory (72)    
------------------------------------------------------------------------------*/
vExpCount2= 0.

OUTPUT STREAM filebill2 TO VALUE(fiFile-Name2).
OUTPUT STREAM filebill2 CLOSE.

OUTPUT STREAM filebill2ex TO VALUE(STRING( fiFile-Name2 )+ "X").
    {wac\wactis04.i}   /* 02,04  head excel*/
OUTPUT STREAM filebill2ex CLOSE.

    n_row1 = 2.

/*----------------------------*/
IF ra_credit = 3 THEN DO:    /* with in */
    loop1:
    FOR EACH wbill  USE-INDEX wbill02  WHERE
                                wbill.wtrndat = nv_exportdat AND
                                wbill.wasdat = n_asdat          AND
                                (LOOKUP(wbill.wacno,nv_acnoAll) <> 0 ) AND  /* A46-0426*/
                                
                                wbill.wpoltyp      = 'v72'   AND
                                (wbill.wtrndat1  >= n_trndatF   AND    wbill.wtrndat1  <= n_trndatT) AND
                                wbill.wwcr         > 0
                              BREAK BY wbill.wtrndat1  BY wbill.wpolicy BY wbill.wendno: 
    
        FIND billing WHERE RECID(billing) = wbill.wrecid NO-ERROR.
        IF AVAIL billing THEN DO:
        
        
            OUTPUT STREAM filebill2 TO VALUE(fiFile-Name2) APPEND .
                {wac\wactis07.i}   /* detail text file*/
            OUTPUT STREAM filebill2 CLOSE.

            /* text to tisco excel*/
            OUTPUT STREAM filebill2ex TO VALUE(STRING( fiFile-Name2 )+ "X") APPEND.
                {wac\wactis05.i}   /* detail excel*/
            OUTPUT STREAM filebill2ex CLOSE.
            
                    vExpCount2= vExpCount2 + 1.
        
        END. /* IF AVAIL billing */
    END.  /* for each wbill */
END.

/*----------------------------*/

    OUTPUT STREAM filebill2ex TO VALUE(STRING( fiFile-Name2 )+ "X") APPEND.
        PUT STREAM  filebill2ex  "E"  skip.      
    OUTPUT STREAM filebill2ex CLOSE.

/*--- kan comment file backup
    vBackUp =  fiFile-Name2 + "B".
    DOS SILENT  COPY VALUE(fiFile-Name2) VALUE(vBackUP) /Y  .   /* backup file exports */
end ---*/

 A47-9999---*/
           
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdAcproc_fil C-Win 
PROCEDURE pdAcproc_fil :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

DO WITH FRAME {&FRAME-NAME} :
  ASSIGN
    vAcProc_fil = "" .
    
    FOR EACH Acproc_fil  WHERE (acproc_fil.type = "01" OR acproc_fil.type = "05" ) AND
                                                            SUBSTRING(acProc_fil.enttim,10,3) <>  "NO"
                                                          BY acproc_fil.asdat DESC  .
        ASSIGN
            vAcProc_fil = vAcProc_fil + STRING( AcProc_fil.asdat,"99/99/9999")  + ",".
    END.

  ASSIGN
    cbAsDat:List-Items  = vAcProc_fil
    cbAsDat = ENTRY (1, vAcProc_fil).
    
  DISP cbAsDat .

END.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdAddAcno C-Win 
PROCEDURE pdAddAcno :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
    DO WITH FRAME {&FRAME-NAME}:
    ASSIGN
        nv_acnoAll    = ""
        nv_acnoAll = IF fi_ac1 <> "" THEN fi_ac1 ELSE ""
        nv_acnoAll = IF fi_ac2 <> "" THEN nv_acnoAll + "," + fi_ac2 ELSE nv_acnoAll
        nv_acnoAll = IF fi_ac3 <> "" THEN nv_acnoAll + "," + fi_ac3 ELSE nv_acnoAll
        nv_acnoAll = IF fi_ac4 <> "" THEN nv_acnoAll + "," + fi_ac4 ELSE nv_acnoAll
        nv_acnoAll = IF fi_ac5 <> "" THEN nv_acnoAll + "," + fi_ac5 ELSE nv_acnoAll
        nv_acnoAll = IF fi_ac6 <> "" THEN nv_acnoAll + "," + fi_ac6 ELSE nv_acnoAll
        nv_acnoAll = IF fi_ac7 <> "" THEN nv_acnoAll + "," + fi_ac7 ELSE nv_acnoAll
        nv_acnoAll = IF fi_ac8 <> "" THEN nv_acnoAll + "," + fi_ac8 ELSE nv_acnoAll
        nv_acnoAll = IF fi_ac9 <> "" THEN nv_acnoAll + "," + fi_ac9 ELSE nv_acnoAll
        nv_acnoAll = IF fi_ac10 <> "" THEN nv_acnoAll + "," + fi_ac10 ELSE nv_acnoAll
        nv_acnoAll = IF fi_ac11 <> "" THEN nv_acnoAll + "," + fi_ac11 ELSE nv_acnoAll
        nv_acnoAll = IF fi_ac12 <> "" THEN nv_acnoAll + "," + fi_ac12 ELSE nv_acnoAll
        nv_acnoAll = IF fi_ac13 <> "" THEN nv_acnoAll + "," + fi_ac13 ELSE nv_acnoAll
        nv_acnoAll = IF fi_ac14 <> "" THEN nv_acnoAll + "," + fi_ac14 ELSE nv_acnoAll
        nv_acnoAll = IF fi_ac15 <> "" THEN nv_acnoAll + "," + fi_ac15 ELSE nv_acnoAll
        nv_acnoAll = IF fi_ac16 <> "" THEN nv_acnoAll + "," + fi_ac16 ELSE nv_acnoAll
        nv_acnoAll = IF fi_ac17 <> "" THEN nv_acnoAll + "," + fi_ac17 ELSE nv_acnoAll
        nv_acnoAll = IF fi_ac18 <> "" THEN nv_acnoAll + "," + fi_ac18 ELSE nv_acnoAll
        nv_acnoAll = IF fi_ac19 <> "" THEN nv_acnoAll + "," + fi_ac19 ELSE nv_acnoAll
        nv_acnoAll = IF fi_ac20 <> "" THEN nv_acnoAll + "," + fi_ac20 ELSE nv_acnoAll
        nv_acnoAll = IF fi_ac21 <> "" THEN nv_acnoAll + "," + fi_ac21 ELSE nv_acnoAll
        nv_acnoAll = IF fi_ac22 <> "" THEN nv_acnoAll + "," + fi_ac22 ELSE nv_acnoAll
        nv_acnoAll = IF fi_ac23 <> "" THEN nv_acnoAll + "," + fi_ac23 ELSE nv_acnoAll
        nv_acnoAll = IF fi_ac24 <> "" THEN nv_acnoAll + "," + fi_ac24 ELSE nv_acnoAll
        nv_acnoAll = IF fi_ac25 <> "" THEN nv_acnoAll + "," + fi_ac25 ELSE nv_acnoAll
        nv_acnoAll = IF fi_ac26 <> "" THEN nv_acnoAll + "," + fi_ac26 ELSE nv_acnoAll
        nv_acnoAll = IF fi_ac27 <> "" THEN nv_acnoAll + "," + fi_ac27 ELSE nv_acnoAll
        nv_acnoAll = IF fi_ac28 <> "" THEN nv_acnoAll + "," + fi_ac28 ELSE nv_acnoAll
        /*--- A500178 ---
        nv_acnoAll = IF fi_ac29 <> "" THEN nv_acnoAll + "," + fi_ac29 ELSE nv_acnoAll
        nv_acnoAll = IF fi_ac30 <> "" THEN nv_acnoAll + "," + fi_ac30 ELSE nv_acnoAll
        ------*/
            .
    
    END.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdCacproc_fil C-Win 
PROCEDURE pdCacproc_fil :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

/*Include File => create record  to table billing tis-----------*/
FIND LAST  acProc_fil  USE-INDEX by_type_asdat  WHERE
                                        acProc_fil.type = "03"  AND acProc_fil.asdat = nv_exportdat NO-ERROR.
    IF NOT AVAIL acProc_fil THEN DO:
            CREATE acProc_fil.
            ASSIGN
                acProc_fil.type     = "03"
                acProc_fil.typdesc = "PROCESS STATEMENT BILLING(TISCO)"
                acProc_fil.asdat   = nv_exportdat         
                acProc_fil.trndatfr = n_trndatF  /*depend on condition on interface*/
                acProc_fil.trndatto = n_trndatT
                acProc_fil.entdat = TODAY
                acProc_fil.enttim = STRING (TIME, "HH:MM:SS")
                acProc_fil.usrid   = n_user .
    END.
/*--------------------------------------*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdchas C-Win 
PROCEDURE pdchas :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       chassi no.
------------------------------------------------------------------------------*/

/*nv_eng2 = "2-SD332/GG1225".*/

/***************************/
        nv_l2 = 1.

        REPEAT while nv_l2 <= LENGTH(nv_eng2):

             IF SUBSTR(nv_eng2,nv_l2 ,1) >= "0" AND
                  SUBSTR(nv_eng2,nv_l2 ,1) <= "9"  THEN                  
                   nv_char2 = TRIM(nv_char2) + SUBSTR(nv_eng2,nv_l2 ,1).

             ELSE DO:
                IF SUBSTR(nv_eng2,nv_l2 ,1) >= "A" AND
                    SUBSTR(nv_eng2,nv_l2 ,1) <= "Z"  THEN 
                    nv_char2 = TRIM(nv_char2) + SUBSTR(nv_eng2,nv_l2 ,1).
            END.
            nv_l2 = nv_l2 + 1.
        END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdCreateBilling C-Win 
PROCEDURE pdCreateBilling :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF OUTPUT PARAMETER  n_recid2 AS RECID.

    DO TRANSACTION :
            CREATE Billing.
    END.
    
n_recid2 =  RECID(Billing).

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdCreateWbill C-Win 
PROCEDURE pdCreateWbill :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF OUTPUT PARAMETER  n_recid AS RECID.

    DO TRANSACTION :
            CREATE wBill.
    END.
    
n_recid =  RECID(wBill).

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdDel C-Win 
PROCEDURE pdDel :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH wBill: DELETE  wBill. END.

IF ra_credit = 1 THEN DO:
    FIND LAST  acProc_fil  USE-INDEX by_type_asdat  WHERE
               acProc_fil.type  = "03"               AND
               acProc_fil.asdat = nv_exportdat     NO-ERROR.
    IF NOT AVAIL acProc_fil THEN DO:
        CREATE acProc_fil.
    END.
        Assign
           acProc_fil.type     = "03"
           acProc_fil.typdesc = "PROCESS STATEMENT BILLING(TISCO) IN CREDIT 60"
           acProc_fil.asdat   = nv_exportdat
           acProc_fil.trndatfr = n_trndatF  /*depend on condition on interface*/
           acProc_fil.trndatto = n_trndatT
           acProc_fil.entdat = TODAY
           acProc_fil.enttim = STRING (TIME, "HH:MM:SS")
           acProc_fil.usrid   = n_user .

END. /*1*/
ELSE DO:
    FIND LAST  acProc_fil  USE-INDEX by_type_asdat  WHERE
               acProc_fil.type  = "04"               AND
               acProc_fil.asdat = nv_exportdat     NO-ERROR.
    IF NOT AVAIL acProc_fil THEN DO:
        CREATE acProc_fil.
    END.
        Assign
             acProc_fil.type     = "04"
             acProc_fil.typdesc = "PROCESS STATEMENT BILLING(TISCO) OUTSTRANDING"
             acProc_fil.asdat   = nv_exportdat
             acProc_fil.trndatfr = n_trndatF  /*depend on condition on interface*/
             acProc_fil.trndatto = n_trndatT
             acProc_fil.entdat = TODAY
             acProc_fil.enttim = STRING (TIME, "HH:MM:SS")
             acProc_fil.usrid   = n_user .

END.  /*2*/


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdeng C-Win 
PROCEDURE pdeng :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       engine no.
------------------------------------------------------------------------------*/

/*nv_eng1 = "2-SD332/GG1225".*/

/***************************/
        nv_l1 = 1.

        REPEAT while nv_l1 <= LENGTH(nv_eng1):

             IF SUBSTR(nv_eng1,nv_l1 ,1) >= "0"  AND
                 SUBSTR(nv_eng1,nv_l1 ,1) <= "9"  THEN 
                     nv_char1 = TRIM(nv_char1) + SUBSTR(nv_eng1,nv_l1 ,1).

             ELSE DO:
                 IF SUBSTR(nv_eng1,nv_l1 ,1) >= "A" AND
                     SUBSTR(nv_eng1,nv_l1 ,1) <= "Z"  THEN
                           nv_char1 = TRIM(nv_char1) + SUBSTR(nv_eng1,nv_l1 ,1).
             END.  /*ELSE  do*/
             nv_l1 = nv_l1 + 1.

        END.  /*repeat*/

    
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdFileName C-Win 
PROCEDURE pdFileName :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
    DO WITH FRAME {&FRAME-NAME}:

        IF ra_credit = 1  THEN DO:  /* DUE CREDIT 60 */
            ASSIGN
                fiFile-name1 = "010VOLDUE.TXT"
                fiFile-name2 = "010COMDUE.TXT".
        END.
        ELSE IF ra_credit = 2  THEN DO:   /* OVER DUE */
            ASSIGN
                fiFile-name1 = "010VOLOUT.TXT"
                fiFile-name2 = "010COMOUT.TXT".
        END.

/*--- A47-9999
        ELSE DO:                                        /* WITH IN*/
            ASSIGN
                fiFile-name1 = "010VOLWIN.TXT"
                fiFile-name2 = "010COMWIN.TXT".
        END.
A47-9999 --*/

        DISP fiFile-name1 fiFile-name2.

    END.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdInDue C-Win 
PROCEDURE pdInDue :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       in due
------------------------------------------------------------------------------*/

/*----------------------------- export to file *** before 30/11/01 file comp ***---------------------------*/
OUTPUT STREAM filebill1 TO VALUE(fiFile-Name1).
/* 1. Header */
       PUT STREAM filebill1
              "H" FORMAT "X"                                                                              /* 1 -   1 */
              "Safety Insurance Public Company Limited"  FORMAT "X(40)"  /* 2 - 41 */
              STRING(TODAY,"99999999")                           FORMAT "X(8)"    /* 42 - 49 */
              STRING(n_asdat,"99999999")                          FORMAT "X(12)"   /* 50 - 61 */
              SKIP.

/* 2. detail*/
vExpCount1= 0.


loop1:
FOR EACH billing  USE-INDEX billing02 WHERE 
                                            billing.trndat = nv_exportdat AND
                                            billing.asdat = n_asdat          AND
                                           (billing.acno1 = fi_ac1              OR
                                            billing.acno1 = fi_ac2              OR
                                            billing.acno1 = fi_ac3              OR
                                            billing.acno1 = fi_ac4              OR
                                            billing.acno1 = fi_ac5              OR
                                            billing.acno1 = fi_ac6              OR
                                            billing.acno1 = fi_ac7              OR
                                            billing.acno1 = fi_ac8              OR
                                            billing.acno1 = fi_ac9              OR                                            
                                            billing.acno1 = fi_ac10            OR
                                            billing.acno1 = fi_ac11            OR
                                            billing.acno1 = fi_ac12            OR
                                            billing.acno1 = fi_ac13            OR
                                            billing.acno1 = fi_ac14            OR
                                            billing.acno1 = fi_ac15            OR
                                            billing.acno1 = fi_ac16            OR
                                            billing.acno1 = fi_ac17            OR
                                            billing.acno1 = fi_ac18            OR
                                            billing.acno1 = fi_ac19            OR
                                            billing.acno1 = fi_ac20            OR
                                            billing.acno1 = fi_ac21            OR
                                            billing.acno1 = fi_ac22            OR
                                            billing.acno1 = fi_ac23            OR
                                            billing.acno1 = fi_ac24            OR
                                            billing.acno1 = fi_ac25            OR
                                            billing.acno1 = fi_ac26            OR
                                            billing.acno1 = fi_ac27            OR
                                            billing.acno1 = fi_ac28            
                                            /*--- A500178 ---
                                            billing.acno1 = fi_ac29            OR
                                            billing.acno1 = fi_ac30  
                                            ------*/ )         AND 

                                         ((billing.comp_policy <> "")      OR
                                          (billing.comp_policy  = ''         AND
                                           billing.poltyp             = 'v72')) AND               
                                          (billing.start_date     >= n_trndatF and
                                           billing.start_date     <= n_trndatT  )                 
                                           
                             BREAK BY billing.start_date by  billing.nor_policy:   



         n_netloc = 0.      y1 = 0.         z1 = 0.     sum = 0.
         p_trnty    = ''.      p_policy = ''.

         FOR EACH acd001 USE-INDEX acd00191 WHERE 
                  acd001.trnty1  = billing.trnty1  AND
                  acd001.docno   = billing.docno   NO-LOCK.
                             
                  n_netloc =  n_netloc + acd001.netloc.
                  IF acd001.ctrty1 = 'y' THEN   y1 = -(acd001.netloc).
                  IF acd001.ctrty1 = 'z' THEN   z1 = -(acd001.netloc).
                  sum         = y1 + z1.                         
                  p_trnty    = billing.trnty1 + billing.trnty2.          
/*                  p_policy = substr(billing.policy,1,12).*/
         END.      /*acd001*/          
/*p                
         FIND FIRST agtprm_fil WHERE agtprm_fil.asdat   = n_asdat           AND
                                                                agtprm_fil.acno    = billing.acno1   AND
                                                                agtprm_fil.policy  = billing.policy          AND
                                                                agtprm_fil.trnty     = p_trnty             AND
                                                                agtprm_fil.docno = billing.docno
                    NO-LOCK NO-ERROR NO-WAIT.
         IF AVAIL agtprm_fil THEN DO:             
             IF agtprm_fil.bal - (y1 + z1) <= billing.whtax1 THEN DO:
                  billing.error = "E".
                  NEXT loop1.
             END.                 
         END.   
p*/        
        
/*--------p*/       
         IF billing.bal - (y1 + z1) <= billing.whtax1 THEN DO:
              billing.error = "E".
              NEXT loop1.
         END.    
                                      
         n_veh = "".                          
         n_veh = billing.vehreg.
         IF SUBSTR(billing.vehreg,1,1) <> '/' THEN DO:        
             RUN pdveh.
         END.                          
         ELSE DO:
             IF billing.vehreg <> '' THEN DO:
                 nv_eng   = substr(billing.vehreg  , 2 , length(billing.vehreg)).                                 
                 RUN pdNewVeh.
                  
                 /*engc = substr(billing.vehreg,2,1) + nv_char.*/
                 engc      = nv_char.
                 nv_eng  = ''.
                 nv_char = ''.
             END.        
             ELSE 
                 engc = ''.
         END. 
          
         IF billing.engine <> "" THEN DO:
             nv_eng1 = billing.engine.
             RUN pdeng.
             engine = nv_char1.
             nv_char1 = ''.
             nv_eng1 = ''.
         END.         
         ELSE 
             engine = ''.
             
         if billing.chassis <> "" then do:
            nv_eng2 = billing.chassis.
            RUN pdchas.
            chas = nv_char2.
            nv_char2 = ''.
            nv_eng2 = ''.
         end.         
         else 
            chas = ''.       
                  
        PUT STREAM  filebill1
       
            "D"          FORMAT "X"          /* 1.  1 -   1 */
            billing.cust_name    FORMAT "X(60)"      /* 2.  2 - 61 */
            billing.nor_policy     FORMAT "X(26)"      /* 3. 62 - 87 */
            billing.comp_policy FORMAT "X(26)"      /* 4. 88 - 113 */                
                  
/*         billing.engine            FORMAT "X(26)"   */   /* 5. 114 - 139 */
            engine                       format 'x(26)'
/*
            billing.chassis          FORMAT "X(26)"       /* 6. 140 - 165   cha_no*/
   */
            chas                          format 'x(26)'
            billing.contract         FORMAT "X(10)"       /* 7. 166 - 175   opnpol*/
/*p
            billing.vehreg           FORMAT "X(12)"       /* 8. 166 - 175 */
   p*/               
            engc                          format 'x(12)'
                 
            billing.start_date      FORMAT "99999999" /* 9. 188 - 195 comdat*/

            fuDeciToChar(billing.nor_grp,10)            FORMAT "X(10)"   /* 10. 196 - 205  "9999999999" GP*/
            fuDeciToChar(billing.comp_grp,10)        FORMAT "X(10)"   /* 11. 206 - 215 compGP*/
            fuDeciToChar(billing.nor_netprm,10)      FORMAT "X(10)"   /* 12. 216 - 225  NP*/
            fuDeciToChar(billing.comp_netprm,10)  FORMAT "X(10)"   /* 13. 226 - 235  compNP*/
            fuDeciToChar(billing.whtax1,10)              FORMAT "X(10)"   /* 14. 236 - 245       12+13+stamp * 1% */
            fuDeciToChar(billing.net_amount,10)      FORMAT "X(10)"   /* 15. 246 - 255      10-11-14 */
                  
            SKIP.
                
/*p       vExpCount = billing.recordno.  p*/
             vExpCount1= vExpCount1 + 1.

END.  /* for each Billing*/
/*--------*/
 
   
       /* 3. Trailer */          
       PUT STREAM filebill1
               "T"      FORMAT "X"           /* 1 - 1 */
               STRING(vExpCount1 ,"99999")    FORMAT "X(5)" /* 2 - 6 */

               SKIP.
        OUTPUT STREAM filebill1 CLOSE.
            
        vBackUp =  fiFile-Name1 + "B".
    
        DOS SILENT  COPY VALUE(fiFile-Name1) VALUE(vBackUP) /Y  .   /* backup file exports */
                 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdInitData C-Win 
PROCEDURE pdInitData :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FIND FIRST  xmm023 NO-ERROR.
    IF AVAIL xmm023  THEN  DO:
        DO WITH FRAME frST :
            ASSIGN 
                fiBranch  = xmm023.branch
                fibdes     = xmm023.bdes.
             DISP fiBranch fibdes .
         END.
    END.     

FIND Last  xmm023 NO-ERROR.
    IF AVAIL xmm023  THEN  DO:
            ASSIGN 
                fiBranch2  = xmm023.branch
                fibdes2     = xmm023.bdes.
             DISP fiBranch2 fibdes2 .
     END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdnam111 C-Win 
PROCEDURE pdnam111 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:  separate  fname and lname from billing.cust_name
------------------------------------------------------------------------------*/
def var a as        char format 'x(20)'.
def var n_fr as    char format 'x(20)'.
def var n_bk as  char format 'x(20)'.
def var n_bk1 as char format 'x(20)'.
def var d       as char format 'x'.
def var r as inte.
def var r1 as inte  .
def var nv_notiOf as char format 'x(20)'.


   
         IF billing.title1           <> "บริษัท"            AND 
            billing.title1          <> "บ."                 AND
            trim(billing.title1)    <> "หจก."               AND
            trim(billing.title1)    <> "หสน."               AND 
            billing.title1          <> "บรรษัท"             AND
            billing.title1          <> "มูลนิธิ"            AND
            billing.title1          <> "ห้างหุ้นส่วน"       AND
            billing.title1          <> "ห้าง"               AND
            billing.title1          <> "ห้างหุ้นส่วนจำกัด"  AND
            billing.title1          <> "ห้างหุ้นส่วนจำก"    THEN DO:
                 /*            
               IF R-INDEX(billing.cust_name," ") <> 0     then do:
                   assign
                        nv_infnam = substr(billing.cust_name , 1 , R-INDEX(billing.cust_name," ") - 1)   /*nv_infname*/
                        nv_inlnam = substr(billing.cust_name , (R-INDEX(billing.cust_name," ")) , (length(billing.cust_name) -  R-INDEX(billing.cust_name ," ") + 1)).       /*lname*/
                        */
/********************************************************************************************************************/
                    r = R-INDEX(billing.cust_name," ").
             
                     IF r <> 0     then do:          
                          n_fr = substr(billing.cust_name , 1 , r - 1).   /*front*/              
                          n_bk = substr(billing.cust_name , r  , length(billing.cust_name) - r + 1).   /*n_bkk*/              
                          d = substr(billing.cust_name , r + 1  , 1).    /*1st n_bkk*/            
                      
                          if  d >= '0'  and d <= '9' then  do:
                              r1 = r-index( n_fr , " ").
                          
                              if  r1 <> 0  then do:
                                   nv_inlnam = substr(billing.cust_name , r1 , length(n_fr) - r1 + 1). 
                                   nv_infnam =  substr(billing.cust_name , 1 , r1).                                                             
                                   nv_notiOf    = n_bk.
                              end.  /*r1<>0*/                  
                          end.     /*0-9*/
              
                          else do:
                                nv_infnam  =  n_fr.
                                nv_inlnam  =  n_bk.
                                nv_notiOf    = "".
                          end.  /*<>0-9*/
                     end.   /*a*/
                         
/***********************************************************************************************************/
         END. 
         ELSE DO:
                nv_infnam = billing.cust_name.
                nv_inlnam = "".
                nv_notiOf  = "".
         END.

                             
         IF R-INDEX(billing.cust_name,"จก.")                <> 0     AND 
             R-INDEX(billing.cust_name,"จำกัด")              <> 0     AND 
             R-INDEX(billing.cust_name,"(มหาชน)")         <> 0     AND 
             R-INDEX(billing.cust_name,"INC.")              <> 0     AND
             R-INDEX(billing.cust_name,"CO.")               <> 0     AND
             R-INDEX(billing.cust_name,"LTD.")             <> 0     AND
             R-INDEX(billing.cust_name,"LIMITED")       <> 0    AND
             INDEX(billing.cust_name,"บริษัท")                 <> 0    AND
             INDEX(billing.cust_name,"บ.")                      <> 0     AND
             INDEX(billing.cust_name,"หจก.")                  <> 0     AND
             INDEX(billing.cust_name,"หสน.")                  <> 0     AND
             INDEX(billing.cust_name,"บรรษัท")               <> 0     AND
             INDEX(billing.cust_name,"มูลนิธิ")                 <> 0     AND
             INDEX(billing.cust_name,"ห้าง")                   <> 0     AND
             INDEX(billing.cust_name,"ห้างหุ้นส่วน")        <> 0     AND
             INDEX(billing.cust_name,"ห้างหุ้นส่วนจำกัด") <> 0     AND
             INDEX(billing.cust_name,"ห้างหุ้นส่วนจำก")   <> 0     THEN DO:
                             
              r = R-INDEX(billing.cust_name," ").
             
                     IF r <> 0     then do:          
                          n_fr = substr(billing.cust_name , 1 , r - 1).   /*front*/              
                          n_bk = substr(billing.cust_name , r  , length(billing.cust_name) - r + 1).   /*n_bkk*/              
                          d = substr(billing.cust_name , r + 1  , 1).    /*1st n_bkk*/            
                      
                          if  d >= '0'  and d <= '9' then  do:
                              r1 = r-index( n_fr , " ").
                          
                              if  r1 <> 0  then do:
                                   nv_inlnam = substr(billing.cust_name , r1 , length(n_fr) - r1 + 1). 
                                   nv_infnam =  substr(billing.cust_name , 1 , r1).                                                             
                                   nv_notiOf    = n_bk.
                              end.  /*r1<>0*/                  
                          end.     /*0-9*/
              
                          else do:
                                nv_infnam  =  n_fr.
                                nv_inlnam  =  n_bk.
                                nv_notiOf    = "".
                          end.  /*<>0-9*/
                     end.   /*a*/

                        
                        
         END.      /* R-INDEX(billing.cust_name,"จก.")<> 0   */    
         ELSE DO:
                nv_infnam = billing.cust_name.
                nv_inlnam = "".
                nv_notiOf  = "".               
         END.




END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdName C-Win 
PROCEDURE pdName :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:  separate  fname and lname from billing.cust_name
------------------------------------------------------------------------------*/
def var a as        char format 'x(20)'.
def var n_fr as    char format 'x(20)'.
def var n_bk as  char format 'x(20)'.
def var n_bk1 as char format 'x(20)'.
def var d       as char format 'x'.
def var r as inte.
def var r1 as inte  .

nv_infnam = TRIM( billing.cust_name ).  /* กรณีไม่มีช่องว่าง  เช่น "คลีนิคทันตรักษ์"
                                                                               ไม่มีวงเล็บ*/

r = R-INDEX(billing.cust_name,"(").
     
     IF r <> 0     then do:          /*have notify officer code (xxxx) */
         n_fr   = substr(billing.cust_name , 1 , r - 1).   /*front*/              
         n_bk = substr(billing.cust_name , r  , length(billing.cust_name) - r + 1).   /*n_bkk*/              
         d       = substr(billing.cust_name , r + 1  , 1).    /*1st n_bkk*/            

         if  d >= '0'  and d <= '9' then  do:        /* ถ้าตัวแรกเป็น ตัวเลข  ให้ แสดงว่ามีรหัสผู้แจ้ง notiOf */
             r1 = index( n_fr , " ").
                          
             if  r1 <> 0  then do:
                 IF billing.title1          <> "บริษัท"             AND 
                    billing.title1          <> "บ."                 AND
                    trim(billing.title1)    <> "หจก."               AND 
                    trim(billing.title1)    <> "หสน."               AND 
                    billing.title1          <> "บรรษัท"             AND 
                    billing.title1          <> "มูลนิธิ"            AND
                    billing.title1          <> "ห้างหุ้นส่วน"       AND 
                    billing.title1          <> "ห้าง"               AND
                    billing.title1          <> "ห้างหุ้นส่วนจำกัด"  AND 
                    billing.title1          <> "ห้างหุ้นส่วนจำก"    THEN DO:                                                           
                              
                     nv_inlnam = TRIM( substr(billing.cust_name , r1 + 1 , length(n_fr) - r1) ). 
                     nv_infnam = TRIM( substr(billing.cust_name , 1 , r1) ).                     
                     nv_notiOf  = TRIM( substr(n_bk , 2 , 4 ) ).
                 end. /*คน*/
                 else do:
                     nv_inlnam = "".
                     nv_infnam = TRIM( substr(billing.cust_name , 1 , r - 1 ) ).
                     nv_notiOf  =  TRIM( substr(n_bk , 2 , 4 ) ).
                 end.  /*company*/                   
             end.  /*r1<>0*/
         end.     /*0-9*/

     end.   /*r <> 0*/

     else do:       /* don't have notify officer code (xxxx) ไม่มีรหัสผู้แจ้ง*/               
        r1 = INDEX(billing.cust_name," ").          
         n_fr = billing.cust_name.   /*front*/              
            
        IF r1 <> 0 THEN do:                             /* หากมีช่องว่างต้องตัด fname lname*/
             IF billing.title1          <> "บริษัท"             AND 
                billing.title1          <> "บ."                 AND
                trim(billing.title1)    <> "หจก."               AND 
                trim(billing.title1)    <> "หสน."               AND 
                billing.title1          <> "บรรษัท"             AND 
                billing.title1          <> "มูลนิธิ"            AND
                billing.title1          <> "ห้างหุ้นส่วน"       AND 
                billing.title1          <> "ห้าง"               AND
                billing.title1          <> "ห้างหุ้นส่วนจำกัด"  AND 
                billing.title1          <> "ห้างหุ้นส่วนจำก"    THEN DO:
                              
                     nv_inlnam = TRIM( substr(billing.cust_name , r1 + 1 , length(n_fr) - r1) ).
                     nv_infnam = TRIM( substr(billing.cust_name , 1 , r1) ).
                     nv_notiOf  = "".
             end. /*คน*/
    
             else do:
                     nv_inlnam = "".
                     nv_infnam = TRIM( billing.cust_name ).
/*                 nv_infnam  = substr(billing.cust_name , 1 , r - 1 ).   */
                     nv_notiOf    = "".      
             end.  /*company*/
 
        END. /*r1 <> 0 */     

     end.  /*r = 0*/

     

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdProc C-Win 
PROCEDURE pdProc :
/*------------------------------------------------------------------------------
  Notes:       create record  to table billing tis
------------------------------------------------------------------------------*/

RUN pdCacproc_fil.  /* create record   acproc_fil */

/*p-------------------------------------------------------------------*/

FOR EACH  agtprm_fil USE-INDEX by_acno            WHERE
                                agtprm_fil.asdat         = n_asdat       AND
                                (LOOKUP(agtprm_fil.acno,nv_acnoAll) <> 0 ) AND  /* A46-0463*/
                                (agtprm_fil.polbran      >= n_branch      AND
                                agtprm_fil.polbran      <= n_branch2 )   AND
                                (NOT(agtprm_fil.trntyp BEGINS 'Y')        AND
                                NOT(agtprm_fil.trntyp BEGINS 'Z' ) )     AND
                    /*p*/   (agtprm_fil.trndat       >= n_trndatF     AND
                                agtprm_fil.trndat       <= n_trndatT)    AND
                                agtprm_fil.bal          <> 0            NO-LOCK.

    ASSIGN
       nv_acno       = ""     nv_policy     = ""   nv_pol72    = ""   nv_norpol   = ""  nv_endno    = ""
       nv_polbran    = ""     nv_poltyp     = ""   nv_trnty1   = ""   nv_trnty2   = ""  nv_docno    = ""
       nv_asdat      = ?      nv_trndat1    = ?    nv_insref   = ""   nv_institle = ""  nv_insnam   = ""
       nv_engine     = ""     nv_cha_no     = ""   nv_opnpol   = ""   nv_vehreg   = ""  nv_comdat   = ?      
       nv_expdat     = ?      nv_grossPrem  = 0    nv_grossPrem_comp = 0                nv_netPrem    = 0      
       nv_netPrem_comp   = 0  nv_tax        = 0    nv_netPayment     = 0                nv_rencnt     = 0      
       nv_endcnt     = 0      nv_job_nr     = ""   vStamp      = 0    vVat        = 0   vStamp_comp   = 0      
       vVat_comp     = 0      nv_credit     = 0
       nv_wcr        = 0      nv_damt       = 0    nv_odue     = 0    nv_moddes   = ""  nv_ben83 = ""
       nv_remark     = ""     nv_bal        = 0.

    ASSIGN
       nv_acno         = agtprm_fil.acno
       nv_norpol       = agtprm_fil.policy + '(' + substr(agtprm_fil.trntyp, 1 , 1) +  agtprm_fil.docno + ')'
       nv_policy       = agtprm_fil.policy
       nv_endno        = agtprm_fil.endno
       nv_polbran      = agtprm_fil.polbran
       nv_trnty1       = SUBSTR(agtprm_fil.trntyp,1,1)
       nv_trnty2       = SUBSTR(agtprm_fil.trntyp,2,1)
       nv_docno        = agtprm_fil.docno
       nv_asdat        = agtprm_fil.asdat
       nv_trndat1      = agtprm_fil.trndat
       nv_opnpol       = agtprm_fil.opnpol
       nv_vehreg       = agtprm_fil.vehreg
       nv_comdat       = agtprm_fil.comdat
       nv_netPrem      = agtprm_fil.prem
       nv_netPrem_comp = agtprm_fil.prem_comp
       nv_poltyp       = agtprm_fil.poltyp
       nv_credit       = agtprm_fil.credit
       nv_wcr          = agtprm_fil.wcr 
       nv_damt         = agtprm_fil.damt
       nv_odue         = agtprm_fil.odue
       nv_bal          = agtprm_fil.bal.

/*A47-0235--- 
    FIND FIRST uwm100  use-index uwm10090 WHERE
               uwm100.trty11 = substr(agtprm_fil.trnty, 1 , 1)  AND
               uwm100.docno1 = agtprm_fil.docno
         NO-LOCK NO-ERROR.
---A47-0235*/

    FIND FIRST uwm100 WHERE uwm100.policy = agtprm_fil.policy AND
              uwm100.endno   = agtprm_fil.endno AND
              uwm100.docno1 = agtprm_fil.docno
        NO-LOCK NO-ERROR.
    IF AVAIL uwm100 THEN DO:
        ASSIGN
          nv_expdat = uwm100.expdat
          nv_rencnt = uwm100.rencnt
          nv_endcnt = uwm100.endcnt
          nv_institle  = TRIM(uwm100.ntitle)       /* 2 - Customer Title Name*/
          nv_insnam = TRIM(uwm100.name1)    /* 2 - Customer Name name*/ 

          nv_job_nr = IF uwm100.rencnt = 0  THEN "N" ELSE "R"   /* n= new policy, r = renew*/
          nv_job_nr = IF uwm100.prvpol = "" THEN "N" ELSE "R".
/*i*/
            IF nv_insnam = "" THEN DO:
                {wac\wactis01.i}        /* หา  ntitle name  ใน xmm600, xtm600 */
            END.
/*i end*/

        FIND FIRST uwd104 WHERE RECID(uwd104) = uwm100.fptr05 NO-LOCK NO-ERROR.
        IF AVAIL uwd104 THEN 
            nv_remark  = uwd104.ltext.
        ELSE 
            nv_remark = "".    
/*-------------------------------sum insure-----------------------------------*/

       nv_sumins = 0.
        FOR EACH uwm120   where uwm120.policy = uwm100.policy and
                                                        uwm120.rencnt = uwm100.rencnt and
                                                        uwm120.endcnt = uwm100.endcnt NO-LOCK.
              nv_sumins = nv_sumins + uwm120.sigr.
        END.                                                           

/*i*/
       IF (SUBSTR(agtprm_fil.policy,3,2) = "70" ) THEN DO:
          nv_pol72 = "".
/* A46-0463         {wac\wacr0202.i}        /* หา  Compulsory  Policy No.  nv_pol72*/*/

          {wac\wactas1.i}        /* หา  Compulsory  Policy No.  nv_pol72*/
       END.
/*i end*/
       IF (SUBSTR(agtprm_fil.policy,3,1) = "7" ) THEN DO:
          FIND FIRST uwm301 USE-INDEX uwm30101      WHERE
                     uwm301.policy = uwm100.policy   AND
                     uwm301.rencnt = uwm100.rencnt   AND
                     uwm301.endcnt = uwm100.endcnt
               NO-LOCK NO-ERROR NO-WAIT.
          IF AVAIL uwm301 THEN
             ASSIGN
                nv_engine    = uwm301.eng_no      /* 5 - 6*/
                nv_cha_no   = uwm301.cha_no
                nv_moddes = uwm301.moddes
                nv_ben83     = uwm301.mv_ben83. /*uwm301*/
          ELSE
             ASSIGN
                nv_engine  = ""
                nv_cha_no = ""
                nv_moddes = ""
                nv_ben83    = "".

          /*-- calculate   0.4 / 100 = 0.004   ,  7 / 100 = 0.07 --*/
          ASSIGN
             vStamp_comp  = IF (nv_netPrem_comp * 0.004 ) -
                               TRUNCATE((nv_netPrem_comp * 0.004 ),0) > 0  THEN
                               TRUNCATE( (nv_netPrem_comp * 0.004),0) + 1        /* มีทศนิยม  ปัดเศษ + 1 */
                            ELSE TRUNCATE( (nv_netPrem_comp * 0.004 ),0)         /* ไม่มีทศนิยม */
             vVat_comp         = (nv_netPrem_comp + vStamp_comp) * 0.07
             nv_grossPrem_comp = nv_netprem_comp + vStamp_comp + vVat_comp
             vStamp            = agtprm_fil.stamp - vStamp_comp
             vVat              = agtprm_fil.tax - vVat_comp
             nv_grossPrem = nv_netprem + vStamp + vVat.
       END.  /* 70 , 72, 73*/
       ELSE  
         ASSIGN
             nv_netprem_comp   = 0
             nv_grossPrem_comp = 0
             nv_netprem        = agtprm_fil.prem
             nv_grossPrem   = agtprm_fil.prem + agtprm_fil.stamp + agtprm_fil.tax
             .
             /* <> 70,72,73*/

       IF nv_insnam  = " "  THEN nv_insnam = agtprm_fil.insure.

       IF (SUBSTR(nv_vehreg,1,1) <> "/") THEN
          nv_vehreg = nv_vehreg.     /* รถเก่า  มีเลขทะเบียน */
       ELSE         /* SUBSTR(nv_vehreg,1,1) = "/" รถใหม่ ไม่มีทะเบียนรถ */
          IF nv_engine <> "" THEN nv_vehreg = nv_engine.   /* เลขเครื่องยนต์ <> ""  then นำเลขเครื่องยนต์มาใส่ที่ทะเบียนรถ*/
                                            ELSE  nv_vehreg = SUBSTR(nv_vehreg, 1 ,LENGTH(nv_vehreg)).  /* ถ้าเลขเครื่องยนต์ = "" ตัด "/" */

       RUN pdwh1.

       /*------------ create  data to   table billing &  temp-table wBill -----------*/
       DISP "Process : " + agtprm_fil.policy + '   ' +
                           agtprm_fil.trnty  + '  ' +
                           agtprm_fil.docno FORMAT "X(10)" /* Benjaporn J. A60-0267 date 27/06/2017 */ @ fi_process
       WITH FRAME {&FRAME-NAME}.

       FIND FIRST wbill use-index   wBill01 where
                  wbill.wAcno   = agtprm_fil.acno                  and
                  wbill.wPolicy = agtprm_fil.policy                and
                  wbill.wEndno  = agtprm_fil.endno                 and
                  wbill.wTrnty1 = substr(agtprm_fil.trnty , 1 , 1) and
                  wbill.wTrnty2 = substr(agtprm_fil.trnty , 2 , 1) and
                  wbill.wDocno  = agtprm_fil.docno        no-error no-wait.

       IF NOT AVAIL wbill THEN

        CREATE wBill.

       ASSIGN
         /*wRecordno = vCount*/
           wpoltyp    = nv_poltyp
           wAcno      = nv_acno
           wPolicy    = nv_policy
           wNorpol    = nv_norpol
           wPol72     = nv_pol72
           wEndno     = nv_endno
           wPolbran   = nv_polbran
           wTrnty1    = nv_trnty1
           wTrnty2    = nv_trnty2
           wDocno     = nv_docno
           wTrndat    = TODAY
           wAsdat     = nv_asdat
           wTrndat1   = nv_trndat1
           wInsref    = nv_Insref
           wInstitle  = nv_Institle
           wInsnam    = nv_Insnam           
           wEngine    = nv_engine
           wCha_no    = nv_cha_no
           wModdes    = nv_moddes
           wBen83     = nv_ben83
           wOpnpol    = nv_opnpol
           wVehreg    = nv_vehreg
           wComdat    = nv_comdat
           wRencnt    = nv_rencnt 
           wEndcnt    = nv_endcnt
           wCredit    = nv_credit 
           wWcr       = nv_wcr
           wDamt      = nv_damt
           wBal       = nv_bal
           wOdue      = nv_odue
           wRemark    = nv_remark
           wExpdat    = nv_expdat

           wGrossPrem = nv_grossPrem                 /* 10*/
           wCompGrossPrem = nv_grossPrem_comp        /* 11 */
           wNetPrem       = nv_netPrem               /* 12 */
           wCompNetPrem   = nv_netPrem_comp          /* 13 */
/*p     wTax = ((nv_netPrem + nv_netPrem_comp + agtprm_fil.stamp ) * 1) / 100   /* 12+13+stamp * 1% */    p*/
           wTax = n_wh1
           wTax = IF wTax < 0 THEN 0 ELSE wTax          /* ถัาเป็น ค่า ลบ  จะไม่มีภาษีนี้*/
 /*p*/ wNetPayment = (nv_grossPrem + nv_grossPrem_comp - wTax)                 /* 10+11-14 */

           wjob_nr = nv_job_nr
           wnor_covamt     = IF SUBSTR(nv_policy,3,2) = "72" THEN 0 ELSE nv_nor_si  /* ถ้า เป็น ก/ธ 72  wnor_covamt = 0*/
           wcomp_covamt = IF wCompGrossPrem = 0  THEN 0 ELSE  nv_comp_si   /* ก/ธ 70 แล้วไม่มี 72 wcomp_covamt = 0 */
           .
/*p
           wnor_comm = 0  wcomp_comm = 0
           wnor_vat  = 0      wcomp_vat  = 0
           wnor_tax3 = 0     wcomp_tax3 = 0.
           ASSIGN
              wGPs     = fuDeciToChar(wGrossPrem,10)   /*  func: fuDeciToChar(source,จำนวนตัวอักษร) */
              wcompGPs = fuDeciToChar(wCompGrossPrem,10)
              wNPs     = fuDeciToChar(wNetPrem,10)
              wcompNPs = fuDeciToChar(wCompNetPrem,10)
              wTaxs    = fuDeciToChar(wTax,10)
              wNetPays = fuDeciToChar(wNetPayment,10).
p*/              
           
         /*vCount = vCount + 1.*/
         /*-----------*/
    END.  /* avail  uwm100 */
END.  /* for each agtprm_fil */

/*----------------------------------------------------------------------------------------------------*/
FIND FIRST wBill NO-LOCK NO-ERROR.
IF NOT AVAIL wBill THEN DO:
   MESSAGE "ไม่พบข้อมูล ที่จะส่งออก"  VIEW-AS ALERT-BOX INFORMATION.
   RETURN NO-APPLY.
END.
ELSE DO:
   /*--- create to Table : billing ---*/
   ASSIGN
      nv_exportdat = TODAY
      nv_exporttim = STRING(TIME,"HH:MM:SS")
      nv_exportusr = nv_user
/*    vCount = 1*/ .

   FOR EACH wBill  USE-INDEX wBill01  NO-LOCK :

      FIND FIRST billing USE-INDEX  billing02     where
                 /*billing.trndat1 = wbill.wtrndat   and*/  /* A46-0463 */
                    billing.trndat  = nv_exportdat    AND 
                    billing.Acno    = wbill.wacno     AND 
                    billing.Policy  = wbill.wpolicy   AND 
                    billing.Endno   = wbill.wendno    AND  
                    billing.trnty1  = wbill.wtrnty1   AND 
                    billing.trnty2  = wbill.wtrnty2   AND 
                    billing.docno   = wbill.wdocno    NO-ERROR NO-WAIT.
      IF NOT AVAIL billing THEN
        CREATE billing.

      ASSIGN
         billing.trndat      = nv_exportdat    /*Export Dat    date   99/99/9999  */
         billing.trntim      = nv_exporttim    /*Trn.Time      char   x(8)   */
         billing.trnusr      = nv_exportusr    /*Trn.UsrId     char   x(8)   */
         billing.policy      = wbill.wPolicy   /*Policy No.    char   x(16)  */

         billing.rencnt      = wbill.wRencnt   /*rencnt        inte   >>9    */
         billing.endcnt      = wbill.wEndcnt   /*endcnt        inte   999    */
         billing.acno1       = wbill.wAcno     /*Account Code  char   x(7)   */
         billing.CompanyCode = "SAFE"          /*1 Insurance's Company  char   x(04)  */
         billing.loop_bill   = "1"             /*2 รอบของการวางบิล      char   x(02)          */
         billing.date_bill   = STRING(YEAR(TODAY),"9999")
                             + STRING(MONTH(TODAY),"99")
                             + STRING(DAY(TODAY),"99")  /*3  รอบวันที่ของการวางบ  char   x(08)        */
         billing.recordno    = vCount          /*4  Record no. 999999    inte   999999  */
         billing.job_nr      = wbill.wjob_nr   /*5  JOB ('N'=NEW, 'R'=R  char   x        */
         billing.nor_policy  = wbill.wNorpol   /*6  Normal Policy no.    char   x(25)   */
         billing.comp_policy = wbill.wPol72    /*7  Compulsory Policy n  char   x(25) */
         
         billing.cust_name   = wbill.wInsnam   /*8  Customer name        char   x(50) */         
         billing.title1      = wbill.wInstitle   /*8  Customer name        char   x(30) */
         
         billing.chassis     = wbill.wCha_no   /*9  หมายเลขตัวถังรถ      char   x(20)      */
         billing.engine      = wbill.wEngine   /*10 หมายเลขเครื่องยนต์   char   x(20)     */
         billing.vehreg      = wbill.wVehreg   /*10 หมายเลขทะเบียน       char   x(20)     */
         billing.start_date  = wbill.wComdat   /*11 Start date yyyymmdd  date   99/99/9999 */
         billing.expdat      = wbill.wExpdat   /*12 yyyymmdd Effective   date   99/99/9999  */
         /* ----- */
         billing.nor_covamt  = wbill.wnor_covamt   /*13 ทุนประกันเบี้ยหลัก   deci-2 >>,>>>,>>9.99-*/
         billing.comp_covamt = wbill.wcomp_covamt  /*14 ทุนประกันพรบ.Compl.  deci-2 >>,>>>,>>9.99-*/
         /* ----- */
         billing.nor_netprm  = wbill.wNetPrem
                               /*15 Net Premium เบี้ยหลัก = เบี้ยรวม - VAT - Stamp  deci-2 >>,>>>,>>9.99-*/
         billing.comp_netprm = wbill.wCompNetPrem                 /*16 Net Premium พรบ.     deci-2 >>,>>>,>>9.99-*/
                               /*16 Net Premium พรบ. = เบี้ยรวมพรบ. - VAT - Stamp  deci-2 >>,>>>,>>9.99-*/
         billing.nor_grp     = wbill.wGrossPrem
                               /*17 Normal Gross Premiu = เบี้ย70 + VAT + STAMP  deci-2 >>,>>>,>>9.99-*/
         billing.comp_grp    = wbill.wCompGrossPrem
                               /*18 Compulsory Gross Pr = เบี้ย72 + VAT + STAMP deci-2 >>,>>>,>>9.99-*/
         billing.total_prm   = wbill.wGrossPrem + wbill.wCompGrossPrem   /*19 Total Premium (17+1  deci-2 >>,>>>,>>9.99-*/
                                                                /* (17+18)  GROSS Prem  = nor + comp*/
         /* = 0 */
         billing.nor_comm    = wbill.wnor_comm   /*20 Commission amt.(เบี  deci-2 >>,>>>,>>9.99-*/
         billing.comp_comm   = wbill.wcomp_comm  /*21 Commission amt.(พรบ  deci-2 >>,>>>,>>9.99-*/
         billing.nor_vat     = wbill.wnor_vat    /*22 VAT Commission(เบี้  deci-2 >>,>>>,>>9.99-*/
         billing.comp_vat    = wbill.wcomp_vat   /*23 VAT Commission(พรบ.  deci-2 >>,>>>,>>9.99-*/
         billing.nor_tax3    = wbill.wnor_tax3   /*24 With Holding Tax3%   deci-2 >>,>>>,>>9.99-*/
         billing.comp_tax3   = wbill.wcomp_tax3  /*25 With Holding Tax3%   deci-2 >>,>>>,>>9.99-*/
         /*---*/

         billing.whtax1      = wbill.wTax        /* w/h Tax1%    (15 + 16 + stamp รวม ) *  1%   ถ้าเป็นการ คือเงิน  w/h = 0*/
         billing.net_amount  = wbill.wNetPayment /*26 [ 19 - w/h Tax 1 %  deci-2 >>,>>>,>>9.99-*/

         billing.subinscod   = ""  /*27 Sub insurance code(  char   x(04)  */
         billing.comp_sub    = ""  /*28 Sub insurance code(  char   x(04)  */
         billing.tlt_remark  = ""  /*29 TLT. Remark          char   x(65)       */

         billing.branch      = wbill.wPolbran
         billing.asdat       = wbill.wasdat
         billing.trnty1      = wbill.wtrnty1
         billing.trnty2      = wbill.wtrnty2
         billing.docno       = wbill.wdocno
         billing.endno       = wbill.wendno
         billing.trndat1     = wbill.wtrndat1  /* trndate from agtprm_fil.trndat*/
         billing.poltyp      = wbill.wpoltyp
         billing.credit      = wbill.wcredit
         billing.wcr         = wbill.wwcr
         billing.damt        = wbill.wdamt
         billing.bal         = wbill.Wbal
                             
         billing.odue        = wbill.wodue
         billing.model       = wbill.wmoddes
         billing.ben         = wbill.wben83
         billing.tlt_remark  = wbill.wRemark .

/*    vCount = vCount + 1.*/

    /* เก็บ recid ของ billing   ลงใน work-table  wbill   เพื่อนำไปใช้ใน pdo3 */
        wbill.wrecid = RECID(billing).


   END.  /* for each wBill */
END. /*ELSE DO*/

RELEASE billing.
RELEASE acProc_fil.
/*=======================End of Include File =============================*/


END PROCEDURE.

/*

/*k*/    RUN pdCreateWbill (OUTPUT n_recid). /* Create Transaction*/
/*k*/    RUN pdCreateBilling (OUTPUT n_recid2). /* Create Transaction*/


*/

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdveh C-Win 
PROCEDURE pdveh :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       vehicle register  change '-' to " "  , cut provice code 
------------------------------------------------------------------------------*/


    
/***************************/
    ASSIGN
      nv_l1 = 1
      n_veh1 = ''.

      REPEAT while nv_l1 <= LENGTH(n_veh):
 
           IF (SUBSTR(n_veh,nv_l1 ,1) >= "A"   AND
              SUBSTR(n_veh,nv_l1 ,1)  <= "Z")  OR 
              (SUBSTR(n_veh,nv_l1 ,1) >= "0"   AND
              SUBSTR(n_veh,nv_l1 ,1)  <= "9")  OR 
              (SUBSTR(n_veh,nv_l1 ,1) >= "ก"   AND
              SUBSTR(n_veh,nv_l1 ,1)  <= "ฮ")  THEN 
                      
                n_veh1 = TRIM(n_veh1) + SUBSTR(n_veh,nv_l1 ,1).                 

           nv_l1 = nv_l1 + 1. 
      END.    /*repeat*/

      if substr(n_veh1 , length(n_veh1) , 1) >= 'ก'  AND  
         substr(n_veh1 , length(n_veh1) , 1) <= 'ฮ'  THEN 
         n_veh1 = substr(n_veh1 , 1 , length(n_veh1) - 2 ).     
      ELSE  
         n_veh1 = n_veh1.
     
         
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdwh1 C-Win 
PROCEDURE pdwh1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
n_wh1 = 0.
   
         IF uwm100.ntitle = "บริษัท"  OR  
            uwm100.ntitle = "บ."      OR 
            trim(uwm100.ntitle) = "บจก."   OR 
            trim(uwm100.ntitle) = "หจก."   OR 
            trim(uwm100.ntitle) = "หสน."   OR  
            uwm100.ntitle = "บรรษัท"       OR  
            uwm100.ntitle = "มูลนิธิ"      OR  
            uwm100.ntitle = "ห้างหุ้นส่วน" OR  
            uwm100.ntitle = "ห้าง"         OR  
            uwm100.ntitle = "ห้างหุ้นส่วนจำกัด" OR  
            uwm100.ntitle = "ห้างหุ้นส่วนจำก"   THEN
                             
            n_wh1 = ((nv_netPrem + nv_netPrem_comp + agtprm_fil.stamp ) * 1) / 100 .  /* 12+13+stamp * 1% */

         
            IF R-INDEX(uwm100.name1,"จก.")     <> 0  OR  
               R-INDEX(uwm100.name1,"จำกัด")   <> 0  OR  
               R-INDEX(uwm100.name1,"(มหาชน)") <> 0  OR  
               R-INDEX(uwm100.name1,"INC.")    <> 0  OR 
               R-INDEX(uwm100.name1,"CO.")     <> 0  OR 
               R-INDEX(uwm100.name1,"LTD.")    <> 0  OR 
               R-INDEX(uwm100.name1,"LIMITED") <> 0  OR 
               INDEX(uwm100.name1,"บริษัท")    <> 0  OR 
               INDEX(uwm100.name1,"บ.")        <> 0  OR
               INDEX(uwm100.name1,"บจก.")      <> 0  OR
               INDEX(uwm100.name1,"หจก.")      <> 0  OR
               INDEX(uwm100.name1,"หสน.")      <> 0  OR
               INDEX(uwm100.name1,"บรรษัท")    <> 0  OR 
               INDEX(uwm100.name1,"มูลนิธิ")   <> 0  OR 
               INDEX(uwm100.name1,"ห้าง")      <> 0  OR
               INDEX(uwm100.name1,"ห้างหุ้นส่วน") <> 0   OR
               INDEX(uwm100.name1,"ห้างหุ้นส่วนจำกัด") <> 0 OR
               INDEX(uwm100.name1,"ห้างหุ้นส่วนจำก")   <> 0 THEN
                             
               n_wh1 = ((nv_netPrem + nv_netPrem_comp + agtprm_fil.stamp ) * 1) / 100 .  /* 12+13+stamp * 1% */

        IF SUBSTR(uwm100.insref,2,1) = "c" THEN
        n_wh1 = ((nv_netPrem + nv_netPrem_comp + agtprm_fil.stamp ) * 1) / 100 .  /* 12+13+stamp * 1% */

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
DEF VAR vChar AS CHAR.

DEF VAR c AS CHAR.
DEF VAR c2 AS CHAR.
DEF VAR c3 AS CHAR.



c = TRIM(STRING(vDeci,"->>>>>>>>>>9.99")).  /* จำนวนตัวเลขรวมจุด เครื่องหมายลบ*/
c2 = SUBSTR(c,1, LENGTH(c) - 3 ).  /* เครื่องหมายลบ รวม ตัวเลข */
c3 = SUBSTR(c, LENGTH(c) - 1, 2 ).  /* ตัวเลขหลัง จุดทศนิยม  2 ตำแหน่ง*/


vChar =  FILL("0",vCharNo - LENGTH(c) + 1 ) + c2 + c3.
              


/*
    vChar = SUBSTR(STRING(vDeci,"99999999.99"),1,INDEX(STRING(vDeci,"99999999.99"),".") - 1) +
                  SUBSTR(STRING(vDeci,"99999999.99"),INDEX(STRING(vDeci,"99999999.99"),".") + 1,2).

*/
    



  RETURN vChar.   /* Function return value. */

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
DEF VAR vLeapYear  AS LOGICAL.

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
  DEF VAR vNum AS INT.
  ASSIGN  vNum = 0.
  
    IF  MONTH(vDate) = 1   OR  MONTH(vDate) = 3    OR
        MONTH(vDate) = 5   OR  MONTH(vDate) = 7    OR
        MONTH(vDate) = 8   OR  MONTH(vDate) = 10   OR
        MONTH(vDate) = 12 THEN DO:
        ASSIGN
            vNum = 31.       
        
   END.
   
    IF  MONTH(vDate) = 4   OR  MONTH(vDate) = 6    OR
         MONTH(vDate) = 9   OR  MONTH(vDate) = 11   THEN DO:
        ASSIGN
            vNum = 30.          
   
   END.     
   
   IF  MONTH(vDate) = 2 THEN DO:
        IF fuLeapYear(YEAR(vDate)) = TRUE THEN vNum = 29. ELSE vNum = 28. 
   END.

  RETURN vNum .   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

