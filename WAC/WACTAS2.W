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
/************   Program   **************
/* CREATE BY :  Patcharaporn Y.        y:\develop\sic_test\pat   */
Wac
        -Wactas1.w 
Whp
        -WhpBran.w

/* Modify By : Kanchana C.          A46-0426   15/10/2003
    - เพิ่มช่องใส่ Producer Code เนื่องจาก มี Code เพิ่มขึ้น
    - set default เริ่มต้น code ทั้งหมดของ thai auto sale
      fi_ac1   = 'A000324'
      fi_ac2   = 'A010086'
      fi_ac3   = 'A020116'
      fi_ac4   = 'A030079'
      fi_ac5   = 'A050135'
      fi_ac6   = 'A070118'
      fi_ac7   = 'A080121'
      fi_ac8   = 'A0A0001'
      fi_ac9   = 'A0E0082'
      fi_ac10  = 'A0K0011'
      fi_ac11  = 'A0M2001'
      fi_ac12  = 'A0N0051'
      fi_ac13  = 'A0U0003'
*/

------------------------------------------------------------------------- 
 Modify By : TANTAWAN C.   12/11/2007   [A500178]
             ปรับ format branch เพื่อรองรับการขยายสาขา
             ขยาย format fi_ac1 - fi_ac28 จาก "X(7)" เป็น  Char "X(10)"
             ปิดฟิลด์  fi_ac29 - fi_ac30
-------------------------------------------------------------------------
/* Modify By : Porntiwa T. A60-0267  Date 14/09/2018
               ปรับขยายเลข Document จาก 7 เป็น 10 หลัก เพื่อนำเข้าระบบให้ถูกต้อง                  */
************************************/

/* ***************************  Definitions  ************************** */

/* Parameters Definitions ---                                           */


/* Local Variable Definitions ---                                       */
DEF VAR nv_User AS CHAR NO-UNDO. 
DEF VAR nv_pwd  AS CHAR NO-UNDO.

DEF NEW SHARED VAR n_branch  AS CHAR FORMAT "x(2)".
DEF NEW SHARED VAR n_branch2 AS CHAR FORMAT "x(2)".

DEF VAR n_asdat        AS DATE FORMAT "99/99/9999".
DEF VAR n_OutputFile1  AS Char.
DEF VAR n_OutputFile2  AS Char.
DEF VAR n_OutputFile3  AS Char.
DEF VAR n_OutputFile4  AS Char.

Def Var n_name     AS CHAR FORMAT "x(50)".     /*acno name*/
Def Var n_chkname  AS CHAR FORMAT "x(1)".        /* Acno-- chk button 1-2 */
Def Var n_bdes     AS CHAR FORMAT "x(50)".     /*branch name*/
Def Var n_chkBname AS CHAR FORMAT "x(1)".        /* branch-- chk button 1-2 */
DEF VAR nv_acno    AS CHAR FORMAT 'X(10)'. /*--- A500178 --- ปรับ format จาก  "X(7)" เป็น  "X(10)" */
DEF VAR nv_policy  AS CHAR FORMAT "X(16)".
DEF VAR nv_norpol  AS CHAR FORMAT "X(25)".
DEF VAR nv_pol72   AS CHAR FORMAT "X(16)".
DEF VAR nv_endno   AS CHAR FORMAT "X(12)".
DEF VAR nv_polbran AS CHAR FORMAT "X(2)".
DEF VAR nv_poltyp  AS CHAR FORMAT "X(3)".
DEF VAR nv_trnty1  AS CHAR FORMAT "X(1)".
DEF VAR nv_trnty2  AS CHAR FORMAT "X(1)".
DEF VAR nv_docno   AS CHAR FORMAT /*"X(7)".*/ "X(10)" . /* Benjaporn J. A60-0267 date 27/06/2017 */
DEF VAR nv_trndat  AS DATE FORMAT "99/99/9999".
DEF VAR nv_asdat   AS DATE FORMAT "99/99/9999".
DEF VAR nv_trndat1 AS DATE FORMAT "99/99/9999".
DEF VAR nv_insref  AS CHAR FORMAT "X(10)". /*--- A500178 --- ปรับ format จาก  "X(7)" เป็น  "X(10)" */
DEF VAR nv_insure  AS CHAR FORMAT "X(50)".
DEF VAR nv_engine  AS CHAR FORMAT "X(20)". 
DEF VAR nv_cha_no  AS CHAR FORMAT "X(20)".
DEF VAR nv_opnpol  AS CHAR FORMAT "X(16)".
DEF VAR nv_vehreg  AS CHAR FORMAT "X(15)".
DEF VAR nv_comdat  AS DATE FORMAT "99/99/9999".
DEF VAR nv_expdat  AS DATE FORMAT "99/99/9999".
DEF VAR nv_grossPrem      AS DECI FORMAT "->>,>>>,>>9.99".
DEF VAR nv_grossPrem_comp AS DECI FORMAT "->>,>>>,>>9.99".
DEF VAR nv_netPrem        AS DECI FORMAT "->>,>>>,>>9.99".
DEF VAR nv_netPrem_comp   AS DECI FORMAT "->>,>>>,>>9.99".
DEF VAR nv_tax            AS DECI FORMAT "->>9.99".
DEF VAR nv_netPayment     AS DECI FORMAT "->>,>>>,>>9.99".
DEF VAR nv_rencnt         AS INTE FORMAT ">>9".
DEF VAR nv_endcnt         AS INTE FORMAT "999".
DEF VAR nv_job_nr         AS CHAR FORMAT "X".

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

DEF VAR n_wh1 as deci format "->>9.99".

DEF TEMP-TABLE wBill
    FIELD wRecordno AS INTE FORMAT "999999"
    FIELD wAcno     AS CHAR FORMAT "X(10)" /*--- A500178 --- ปรับ format จาก  "X(7)" เป็น  "X(10)" */
    FIELD wPolicy   AS CHAR FORMAT "X(16)"
    FIELD wNorpol   AS CHAR FORMAT "X(16)"            
    FIELD wPol72    AS CHAR FORMAT "X(16)"
    FIELD wEndno    AS CHAR FORMAT "X(12)"
    FIELD wPolbran  AS CHAR FORMAT "X(2)"
    FIELD wPoltyp   AS CHAR FORMAT "X(3)"
    FIELD wTrnty1   AS CHAR FORMAT "X"
    FIELD wTrnty2   AS CHAR FORMAT "X"
    FIELD wDocno    AS CHAR FORMAT /*"X(7)"*/  "X(10)" /* Benjaporn J. A60-0267 date 27/06/2017 */
    FIELD wTrndat   AS DATE FORMAT "99/99/9999"  /*export date*/
    FIELD wAsdat    AS DATE FORMAT "99/99/9999"
    FIELD wTrndat1  AS DATE FORMAT "99/99/9999"  /* trndat to Acc.*/
    FIELD wInsref   AS CHAR  FORMAT "X(10)" /*--- A500178 --- ปรับ format จาก  "X(7)" เป็น  "X(10)" */
    FIELD wInsure   AS CHAR  FORMAT "X(50)"
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
    FIELD wGPs      AS CHAR FORMAT "X(10)"
    FIELD wCompGPs  AS CHAR FORMAT "X(10)"
    FIELD wNPs      AS CHAR FORMAT "X(10)"
    FIELD wCompNPs  AS CHAR FORMAT "X(10)"
    FIELD wTaxs     AS CHAR FORMAT "X(10)"
    FIELD wNetPays  AS CHAR FORMAT "X(10)"
    FIELD wRencnt   AS INTE FORMAT ">>9"
    FIELD wEndcnt   AS INTE FORMAT "999"

    FIELD wjob_nr      AS CHAR FORMAT "X"
    FIELD wnor_covamt  AS DECI FORMAT "->>,>>>,>>9.99"
    FIELD wcomp_covamt AS DECI FORMAT "->>,>>>,>>9.99"
    FIELD wnor_comm    AS DECI FORMAT "->>,>>>,>>9.99"
    FIELD wcomp_comm   AS DECI FORMAT "->>,>>>,>>9.99"
    FIELD wnor_vat     AS DECI FORMAT "->>,>>>,>>9.99"
    FIELD wcomp_vat    AS DECI FORMAT "->>,>>>,>>9.99"
    FIELD wnor_tax3    AS DECI FORMAT "->>,>>>,>>9.99"
    FIELD wcomp_tax3   AS DECI FORMAT "->>,>>>,>>9.99"
            
    INDEX  wBill01     IS UNIQUE PRIMARY wAcno wPolicy wEndno wTrnty1 wTrnty2 wDocno ASCENDING.

FOR EACH vehreg72:   DELETE  vehreg72.   END.
/* ------------------------------------------------------------------------ */
DEFINE STREAM filebill1.
DEFINE STREAM filebill2.
DEFINE STREAM filebill3.
DEFINE STREAM filebill4.

DEF VAR nv_exportdat AS DATE  FORMAT "99/99/9999".
DEF VAR nv_exporttim AS CHAR FORMAT "X(8)".
DEF VAR nv_exportusr AS CHAR FORMAT "X(8)".

DEF VAR vCount     AS INT INIT 1.
DEF VAR vExpCount1 AS INT INIT 0.
DEF VAR vExpCount2 AS INT INIT 0.
DEF VAR vExpCount3 AS INT INIT 0.
DEF VAR vExpCount4 AS INT INIT 0.

DEF VAR vBackUp1 AS CHAR.
DEF VAR vBackUp2 AS CHAR.
DEF VAR vBackUp3 AS CHAR.
DEF VAR vBackUp4 AS CHAR.

DEF VAR n_netloc AS DECI.
DEF VAR y1       AS DECI.
DEF VAR z1       AS DECI.
DEF VAR p_trnty  AS CHAR FORMAT 'x(2)'.
DEF VAR sum      AS DECI.
DEF VAR p_policy AS CHAR FORMAT 'x(12)'.
/**/
DEF VAR n_veh AS CHAR.
DEF VAR a     AS INTE.
DEF VAR b     AS INTE.
DEF VAR c     AS CHAR FORMAT 'x'.
DEF VAR clist AS CHAR INIT  "1,2,3,4,5,6,7,8,9,0".
DEF VAR bbb   AS INTE.
DEF VAR ccc   AS CHAR FORMAT 'x(20)'.
DEF VAR ddd   AS CHAR FORMAT 'x(20)'.
DEF NEW SHARED VAR  engc as char format 'x(20)'.
DEF VAR vAcProc_fil  AS CHAR.
DEF VAR vAcProc_fil1 AS CHAR.
/**/
DEF VAR nv_eng  AS CHAR FORMAT "X(20)".
DEF VAR nv_char AS CHAR FORMAT "X(20)".
DEF VAR nv_l    AS INT.
DEF VAR nv_spc  AS LOG.
/**/
DEF VAR engine   AS CHAR FORMAT 'x(26)'.
DEF VAR nv_eng1  AS CHAR FORMAT "X(20)".
DEF VAR nv_char1 AS CHAR FORMAT "X(20)".
DEF VAR nv_l1    AS INT.
DEF VAR nv_spc1  AS LOG.
/**/
DEF VAR chas     AS CHAR FORMAT 'x(26)'.
DEF VAR nv_eng2  AS CHAR FORMAT "X(20)".
DEF VAR nv_char2 AS CHAR FORMAT "X(20)".
DEF VAR nv_l2    AS INT.
DEF VAR nv_spc2  AS LOG.
/**/
/*---------------def for tas2.i----------------*/
DEF VAR vStamp      AS DECI.
DEF VAR vVat        AS DECI.
DEF VAR vStamp_comp AS DECI.
DEF VAR vVat_comp   AS DECI.
/*-------------------------------------------------*/
def var  n_pol as char format 'x(16)'.
def var  n_ren as inte format ">9".
def var  n_end as inte format "999".
/*--------------------------excel file-----------------------*/
def var n_cusnam    as char FORMAT 'x(60)'.
def var n_norpol    as char FORMAT 'x(25)'.
def var n_cppol     as char FORMAT 'x(25)'.
def var n_contract  as char FORMAT 'x(10)'.
def var n_stdate    as date FORMAT '99/99/9999'.
def var n_norgrp    as deci FORMAT '->>>,>>>,>>9.99'.
def var n_cpgrp     as deci FORMAT '->>>,>>>,>>9.99'.
def var n_nornetprm as deci FORMAT '->>>,>>>,>>9.99'.
def var n_cpnetprm  as deci FORMAT '->>>,>>>,>>9.99'.
def var n_whtax1    as deci FORMAT '->>>,>>>,>>9.99'.
def var n_netamt    as deci FORMAT '->>>,>>>,>>9.99'.
def var n_row1      as inte FORMAT ">>>>>>9" init 2.
def var n_row2      as inte FORMAT ">>>>>>9" init 2.
def var n_row3      as inte FORMAT ">>>>>>9" init 2.
def var n_row4      as inte FORMAT ">>>>>>9" init 2.
/*-------------------------------------------------------------*/

/*------------A46-0426-----*/
/*--- A500178 --- ปรับ fomat ของ nv_ac1 - nv_ac30  จาก  "X(7)" เป็น  "X(10)" ---*/
DEF NEW SHARED VAR nv_ac1   AS CHAR FORMAT 'X(10)'.
DEF NEW SHARED VAR nv_ac2   AS CHAR FORMAT 'X(10)'.
DEF NEW SHARED VAR nv_ac3   AS CHAR FORMAT 'X(10)'.
DEF NEW SHARED VAR nv_ac4   AS CHAR FORMAT 'X(10)'.
DEF NEW SHARED VAR nv_ac5   AS CHAR FORMAT 'X(10)'.
DEF NEW SHARED VAR nv_ac6   AS CHAR FORMAT 'X(10)'.
DEF NEW SHARED VAR nv_ac7   AS CHAR FORMAT 'X(10)'.
DEF NEW SHARED VAR nv_ac8   AS CHAR FORMAT 'X(10)'.
DEF NEW SHARED VAR nv_ac9   AS CHAR FORMAT 'X(10)'.
DEF NEW SHARED VAR nv_ac10  AS CHAR FORMAT 'X(10)'.
DEF NEW SHARED VAR nv_ac11  AS CHAR FORMAT 'X(10)'.
DEF NEW SHARED VAR nv_ac12  AS CHAR FORMAT 'X(10)'.
DEF NEW SHARED VAR nv_ac13  AS CHAR FORMAT 'X(10)'.
DEF NEW SHARED VAR nv_ac14  AS CHAR FORMAT 'X(10)'.
DEF NEW SHARED VAR nv_ac15  AS CHAR FORMAT 'X(10)'.
DEF NEW SHARED VAR nv_ac16  AS CHAR FORMAT 'X(10)'.
DEF NEW SHARED VAR nv_ac17  AS CHAR FORMAT 'X(10)'.
DEF NEW SHARED VAR nv_ac18  AS CHAR FORMAT 'X(10)'.
DEF NEW SHARED VAR nv_ac19  AS CHAR FORMAT 'X(10)'.
DEF NEW SHARED VAR nv_ac20  AS CHAR FORMAT 'X(10)'.
DEF NEW SHARED VAR nv_ac21  AS CHAR FORMAT 'X(10)'.
DEF NEW SHARED VAR nv_ac22  AS CHAR FORMAT 'X(10)'.
DEF NEW SHARED VAR nv_ac23  AS CHAR FORMAT 'X(10)'.
DEF NEW SHARED VAR nv_ac24  AS CHAR FORMAT 'X(10)'.
DEF NEW SHARED VAR nv_ac25  AS CHAR FORMAT 'X(10)'.
DEF NEW SHARED VAR nv_ac26  AS CHAR FORMAT 'X(10)'.
DEF NEW SHARED VAR nv_ac27  AS CHAR FORMAT 'X(10)'.
DEF NEW SHARED VAR nv_ac28  AS CHAR FORMAT 'X(10)'.
DEF NEW SHARED VAR nv_ac29  AS CHAR FORMAT 'X(10)'.
DEF NEW SHARED VAR nv_ac30  AS CHAR FORMAT 'X(10)'.

DEF VAR nv_acnoAll AS CHAR.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS RECT-6 RECT-2 RECT-5 RECT-3 RECT-8 RECT-10 ~
RECT-9 RECT-4 RECT-7 RECT-1 fiBranch buBranch fiBranch2 buBranch2 fi_ac1 ~
fi_ac2 fi_ac3 fi_ac4 fi_ac5 fi_ac6 fi_ac7 fi_ac8 fi_ac9 fi_ac10 fi_ac11 ~
fi_ac12 fi_ac13 fi_ac14 fi_ac15 fi_ac16 fi_ac17 fi_ac18 fi_ac19 fi_ac20 ~
fi_ac21 fi_ac22 fi_ac23 fi_ac24 fi_ac25 fi_ac26 fi_ac27 fi_ac28 cbAsDat ~
cbExportDat fiFile-Name1 fiFile-Name2 fiFile-Name3 fiFile-Name4 Btn_OK ~
Btn_Exit fibdes fibdes2 fi_process 
&Scoped-Define DISPLAYED-OBJECTS fiBranch fiBranch2 fi_ac1 fi_ac2 fi_ac3 ~
fi_ac4 fi_ac5 fi_ac6 fi_ac7 fi_ac8 fi_ac9 fi_ac10 fi_ac11 fi_ac12 fi_ac13 ~
fi_ac14 fi_ac15 fi_ac16 fi_ac17 fi_ac18 fi_ac19 fi_ac20 fi_ac21 fi_ac22 ~
fi_ac23 fi_ac24 fi_ac25 fi_ac26 fi_ac27 fi_ac28 cbAsDat cbExportDat ~
fiFile-Name1 fiFile-Name2 fiFile-Name3 fiFile-Name4 fibdes fibdes2 ~
fi_process 

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

DEFINE VARIABLE cbAsDat AS CHARACTER FORMAT "X(256)":U INITIAL ? 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEMS "item 1" 
     DROP-DOWN-LIST
     SIZE 16 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE cbExportDat AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEMS "Item 1" 
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
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fiFile-Name3 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 23.5 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fiFile-Name4 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 23.5 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

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

DEFINE VARIABLE fi_process AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 34.5 BY 1.05
     BGCOLOR 173 FGCOLOR 30 FONT 2 NO-UNDO.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 22.5 BY 9.67
     BGCOLOR 32 FGCOLOR 15 .

DEFINE RECTANGLE RECT-10
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 34.5 BY 2.86
     BGCOLOR 55 FGCOLOR 15 .

DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 97.5 BY 9.67
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-3
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 22.5 BY 4.95
     BGCOLOR 32 .

DEFINE RECTANGLE RECT-4
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 93.5 BY 4.95
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-5
     EDGE-PIXELS 5 GRAPHIC-EDGE    
     SIZE 125.5 BY 18.24
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

DEFINE RECTANGLE RECT-9
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 35 BY 4.19
     BGCOLOR 32 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     fiBranch AT ROW 4.38 COL 30.17 COLON-ALIGNED NO-LABEL
     buBranch AT ROW 4.38 COL 37.17
     fiBranch2 AT ROW 5.48 COL 30.17 COLON-ALIGNED NO-LABEL
     buBranch2 AT ROW 5.48 COL 37.17
     fi_ac1 AT ROW 6.71 COL 30.17 COLON-ALIGNED NO-LABEL
     fi_ac2 AT ROW 6.71 COL 42.5 COLON-ALIGNED NO-LABEL
     fi_ac3 AT ROW 6.71 COL 54.83 COLON-ALIGNED NO-LABEL
     fi_ac4 AT ROW 6.71 COL 67.17 COLON-ALIGNED NO-LABEL
     fi_ac5 AT ROW 6.71 COL 79.5 COLON-ALIGNED NO-LABEL
     fi_ac6 AT ROW 6.71 COL 91.83 COLON-ALIGNED NO-LABEL
     fi_ac7 AT ROW 6.71 COL 104.17 COLON-ALIGNED NO-LABEL
     fi_ac8 AT ROW 7.86 COL 30.17 COLON-ALIGNED NO-LABEL
     fi_ac9 AT ROW 7.86 COL 42.5 COLON-ALIGNED NO-LABEL
     fi_ac10 AT ROW 7.86 COL 54.83 COLON-ALIGNED NO-LABEL
     fi_ac11 AT ROW 7.86 COL 67.17 COLON-ALIGNED NO-LABEL
     fi_ac12 AT ROW 7.86 COL 79.5 COLON-ALIGNED NO-LABEL
     fi_ac13 AT ROW 7.86 COL 91.83 COLON-ALIGNED NO-LABEL
     fi_ac14 AT ROW 7.86 COL 104.17 COLON-ALIGNED NO-LABEL
     fi_ac15 AT ROW 8.95 COL 30.17 COLON-ALIGNED NO-LABEL
     fi_ac16 AT ROW 8.95 COL 42.5 COLON-ALIGNED NO-LABEL
     fi_ac17 AT ROW 8.95 COL 54.83 COLON-ALIGNED NO-LABEL
     fi_ac18 AT ROW 8.95 COL 67.17 COLON-ALIGNED NO-LABEL
     fi_ac19 AT ROW 8.95 COL 79.5 COLON-ALIGNED NO-LABEL
     fi_ac20 AT ROW 8.95 COL 91.83 COLON-ALIGNED NO-LABEL
     fi_ac21 AT ROW 8.95 COL 104.17 COLON-ALIGNED NO-LABEL
     fi_ac22 AT ROW 10.05 COL 30.17 COLON-ALIGNED NO-LABEL
     fi_ac23 AT ROW 10.05 COL 42.5 COLON-ALIGNED NO-LABEL
     fi_ac24 AT ROW 10.05 COL 54.83 COLON-ALIGNED NO-LABEL
     fi_ac25 AT ROW 10.05 COL 67.17 COLON-ALIGNED NO-LABEL
     fi_ac26 AT ROW 10.05 COL 79.5 COLON-ALIGNED NO-LABEL
     fi_ac27 AT ROW 10.05 COL 91.83 COLON-ALIGNED NO-LABEL
     fi_ac28 AT ROW 10.1 COL 104.17 COLON-ALIGNED NO-LABEL
     cbAsDat AT ROW 11.33 COL 30.33 COLON-ALIGNED NO-LABEL
     cbExportDat AT ROW 12.57 COL 30.33 COLON-ALIGNED NO-LABEL
     fiFile-Name1 AT ROW 16.38 COL 34.5 COLON-ALIGNED NO-LABEL
     fiFile-Name2 AT ROW 16.38 COL 70 COLON-ALIGNED NO-LABEL
     fiFile-Name3 AT ROW 16.38 COL 96 COLON-ALIGNED NO-LABEL
     fiFile-Name4 AT ROW 17.71 COL 70 COLON-ALIGNED NO-LABEL
     Btn_OK AT ROW 22.48 COL 50.67
     Btn_Exit AT ROW 22.48 COL 75.5
     fibdes AT ROW 4.38 COL 38.67 COLON-ALIGNED NO-LABEL
     fibdes2 AT ROW 5.48 COL 38.67 COLON-ALIGNED NO-LABEL
     fi_process AT ROW 19.76 COL 50.5 COLON-ALIGNED NO-LABEL
     "Bal < 0" VIEW-AS TEXT
          SIZE 6.5 BY .95 AT ROW 17.71 COL 63
          BGCOLOR 19 FGCOLOR 0 
     "Type ~"R~"" VIEW-AS TEXT
          SIZE 9 BY .95 AT ROW 15.1 COL 76
          BGCOLOR 32 FGCOLOR 15 
     "bal เหลือไว้ match ภาษี 1 %" VIEW-AS TEXT
          SIZE 23.5 BY .95 AT ROW 15.1 COL 36.5
          BGCOLOR 32 FGCOLOR 15 
     "Bal >0" VIEW-AS TEXT
          SIZE 6.5 BY .95 AT ROW 16.38 COL 63
          BGCOLOR 19 FGCOLOR 0 
     "Export Date (Billing)" VIEW-AS TEXT
          SIZE 19.5 BY .95 AT ROW 12.48 COL 8
          BGCOLOR 19 FGCOLOR 0 
     "Type ~"M~"  && Bal < 0" VIEW-AS TEXT
          SIZE 23.5 BY .95 AT ROW 15.1 COL 98
          BGCOLOR 32 FGCOLOR 15 
     "Branch From":25 VIEW-AS TEXT
          SIZE 19.5 BY 1 TOOLTIP "ตั้งแต่สาขา" AT ROW 4.48 COL 8
          BGCOLOR 19 FGCOLOR 0 
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 132.83 BY 23.87
         BGCOLOR 3 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME DEFAULT-FRAME
     "Branch To":10 VIEW-AS TEXT
          SIZE 19.5 BY 1 TOOLTIP "ถึงสาขา" AT ROW 5.57 COL 8
          BGCOLOR 19 FGCOLOR 0 
     "   ข้อมูลที่ไม่ได้ส่งไปในการวางบิลเรียกเก็บเงินค่าเบี้ยฯ จาก Thai Auto Sales" VIEW-AS TEXT
          SIZE 59 BY 1 AT ROW 1.52 COL 38
          BGCOLOR 8 FGCOLOR 0 
     "Producer Code" VIEW-AS TEXT
          SIZE 19.5 BY 1 AT ROW 6.76 COL 8
          BGCOLOR 19 FGCOLOR 0 
     " As of Date (Statement)":30 VIEW-AS TEXT
          SIZE 19.5 BY .95 TOOLTIP "วันที่ออกรายงาน" AT ROW 11.33 COL 8
          BGCOLOR 19 FGCOLOR 0 
     "Output To TextFile" VIEW-AS TEXT
          SIZE 19.5 BY .95 AT ROW 16.38 COL 8
          BGCOLOR 19 FGCOLOR 0 
     RECT-6 AT ROW 22.14 COL 49
     RECT-2 AT ROW 4.14 COL 30
     RECT-5 AT ROW 3.1 COL 4.5
     RECT-3 AT ROW 14.57 COL 6.5
     RECT-8 AT ROW 1.24 COL 37
     RECT-10 AT ROW 16.14 COL 62
     RECT-9 AT ROW 15.1 COL 62
     RECT-4 AT ROW 14.57 COL 30
     RECT-7 AT ROW 22.14 COL 74
     RECT-1 AT ROW 4.14 COL 6.5
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 132.83 BY 23.87
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
         TITLE              = "ข้อมูลที่ไม่ได้ส่งไปให้ Thai Auto Sales =>wactas2.w"
         HEIGHT             = 24.05
         WIDTH              = 133.33
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
   FRAME-NAME                                                           */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* ข้อมูลที่ไม่ได้ส่งไปให้ Thai Auto Sales =>wactas2.w */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* ข้อมูลที่ไม่ได้ส่งไปให้ Thai Auto Sales =>wactas2.w */
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
      fibranch fibranch
      fibranch2 fibranch2            
      fiFile-Name1 fiFile-Name2  fiFile-Name3 fiFile-Name4
      n_branch   = fiBranch
      n_branch2  = fiBranch2           
      n_asdat    =  DATE( INPUT cbAsDat)            
      nv_exportdat   = DATE( INPUT cbExportDat)
      n_OutputFile1  = fiFile-Name1
      n_OutputFile2  = fiFile-Name2
      n_OutputFile3  = fiFile-Name3
      n_OutputFile4  = fiFile-Name4

      nv_acnoAll = ""
      nv_acnoAll = IF fi_ac1 <>  "" THEN fi_ac1 ELSE ""
      nv_acnoAll = IF fi_ac2 <>  "" THEN nv_acnoAll + "," + fi_ac2 ELSE nv_acnoAll
      nv_acnoAll = IF fi_ac3 <>  "" THEN nv_acnoAll + "," + fi_ac3 ELSE nv_acnoAll
      nv_acnoAll = IF fi_ac4 <>  "" THEN nv_acnoAll + "," + fi_ac4 ELSE nv_acnoAll
      nv_acnoAll = IF fi_ac5 <>  "" THEN nv_acnoAll + "," + fi_ac5 ELSE nv_acnoAll
      nv_acnoAll = IF fi_ac6 <>  "" THEN nv_acnoAll + "," + fi_ac6 ELSE nv_acnoAll
      nv_acnoAll = IF fi_ac7 <>  "" THEN nv_acnoAll + "," + fi_ac7 ELSE nv_acnoAll
      nv_acnoAll = IF fi_ac8 <>  "" THEN nv_acnoAll + "," + fi_ac8 ELSE nv_acnoAll
      nv_acnoAll = IF fi_ac9 <>  "" THEN nv_acnoAll + "," + fi_ac9 ELSE nv_acnoAll
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
      /*--- A500178 --- ปิดฟิลด์ ---
      nv_acnoAll = IF fi_ac29 <> "" THEN nv_acnoAll + "," + fi_ac29 ELSE nv_acnoAll
      nv_acnoAll = IF fi_ac30 <> "" THEN nv_acnoAll + "," + fi_ac30 ELSE nv_acnoAll
      ------*/
      .

   IF ( n_branch > n_branch2)   THEN DO:
         Message "ข้อมูลรหัสสาขาผิดพลาด" SKIP
                 "รหัสสาขาเริ่มต้นต้องมากกว่ารหัสสุดท้าย" VIEW-AS ALERT-BOX WARNING . 
         Apply "Entry" To fibranch.
         Return No-Apply.       
   END.

   IF  (n_OutputFile1 = "" and  n_OutputFile2 = ""     AND
         n_OutputFile3 = "" and  n_OutputFile4 = "")   THEN DO:
         Message "กรุณาใส่ชื่อไฟล์" VIEW-AS ALERT-BOX WARNING . 
         Apply "Entry" To  fiFile-Name1 .
         Return No-Apply.       
   END.
 
/****************** PRINT ********************/

    IF input fiFile-Name1 <> "" THEN
         run pdexcel1. 
                 
    IF input fiFile-Name2 <> "" THEN 
         run pdexcel2. 
         
    IF input fiFile-Name3 <> "" THEN                 
         run pdexcel3. 
         
    IF input fiFile-Name4 <> "" THEN                 
         run pdexcel4.                   

    IF input fiFile-Name1 <> "" THEN
        MESSAGE  "ทำการ Dump  ข้อมูล ลง Excel File => **กรณี bal เหลือไว้ match ภาษี 1 % ** "  skip
                 fiFile-Name1  
                 " => การส่งออก จำนวน : " vExpCount1  " รายการ" VIEW-AS ALERT-BOX INFORMATION.
    
    IF input fiFile-Name2 <> "" THEN                     
        MESSAGE  "ทำการ Dump  ข้อมูล ลง Excel File => ** กรณี Type R & bal > 0 ** "  skip
                 fiFile-Name2  
                 "=> การส่งออก จำนวน : " vExpCount2  " รายการ" VIEW-AS ALERT-BOX INFORMATION.                  

    IF input fiFile-Name3 <> "" THEN    
        MESSAGE  "ทำการ Dump  ข้อมูล ลง Excel File => ** กรณี Type M & bal < 0 ** "  skip
                 fiFile-Name3  
                 "=> การส่งออก จำนวน : " vExpCount3  " รายการ" VIEW-AS ALERT-BOX INFORMATION.      

    IF input fiFile-Name4 <> "" THEN                                                     
        MESSAGE  "ทำการ Dump  ข้อมูล ลง Excel File => ** กรณี Type R & bal < 0 ** "  skip
                 fiFile-Name4 
                 "=> การส่งออก จำนวน : " vExpCount4  " รายการ" VIEW-AS ALERT-BOX INFORMATION.                                               

    ASSIGN
         n_OutputFile1 = ""
         n_OutputFile2 = ""
         n_OutputFile3 = ""
         n_OutputFile4 = ""      
         fiFile-Name1  = ""
         fiFile-Name2  = ""
         fiFile-Name3  = ""
         fiFile-Name4  = "".
    DISP   fiFile-Name1    fiFile-Name2    fiFile-Name3  fiFile-Name4  
    WITH FRAME {&FRAME-NAME}.
  
    APPLY "ENTRY" TO fiBranch IN FRAME {&frame-name}.                   
    
END. /*DO*/
                    
                 
/*p-----------------*/

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
       APPLY "ENTRY" TO cbExportdat IN FRAME {&FRAME-NAME}.
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


&Scoped-define SELF-NAME cbExportDat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cbExportDat C-Win
ON RETURN OF cbExportDat IN FRAME DEFAULT-FRAME
DO:
/*p-------------*/       
      cbExportDat = input cbExportDat.
      nv_exportdat    =  DATE( INPUT cbExportDat).         
      if nv_exportdat = ? then do:
         MESSAGE "ไม่พบข้อมูล  กรุณาตรวจสอบการ Process ข้อมูล" VIEW-AS ALERT-BOX WARNING.      
         return no-apply.
      end.
/*-------------p*/            
       APPLY "ENTRY" TO fiFile-Name1 IN FRAME {&FRAME-NAME}.
       RETURN NO-APPLY.            
  
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cbExportDat C-Win
ON VALUE-CHANGED OF cbExportDat IN FRAME DEFAULT-FRAME
DO:
/*p-------------*/       
      cbExportDat = input cbExportDat.
      nv_exportdat    =  DATE( INPUT cbExportDat).         
      if nv_exportdat = ? then do:
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
     Assign
         fibranch2 = input fibranch2
         n_branch2  = fibranch2.
    DISP CAPS(fibranch2)@ fibranch2 WITH FRAME {&FRAME-NAME}.         
             
/*     Apply "Entry" To fiAcno1.           */
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
        if input fiFile-Name1 <> "" then do:
           vBackUp1 =  fiFile-Name1 + "B"  + ".slk".
           fiFile-Name1 = fiFile-Name1 + ".slk". 
        end.
        disp fiFile-Name1 with frame {&frame-name}.   

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiFile-Name2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiFile-Name2 C-Win
ON LEAVE OF fiFile-Name2 IN FRAME DEFAULT-FRAME
DO:
        fiFile-Name2 = INPUT fiFile-Name2.
        if input fiFile-Name2 <> "" then do:
           vBackUp2 =  fiFile-Name2 + "B"  + ".slk".
           fiFile-Name2 = fiFile-Name2 + ".slk". 
        end.
        disp fiFile-Name2 with frame {&frame-name}.     
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiFile-Name3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiFile-Name3 C-Win
ON LEAVE OF fiFile-Name3 IN FRAME DEFAULT-FRAME
DO:
        fiFile-Name3 = INPUT fiFile-Name3.
        if input fiFile-Name3 <> "" then do:
           vBackUp3 =  fiFile-Name3 + "B"  + ".slk".
           fiFile-Name3 = fiFile-Name3 + ".slk". 
        end.
        disp fiFile-Name3 with frame {&frame-name}.       
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiFile-Name4
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiFile-Name4 C-Win
ON LEAVE OF fiFile-Name4 IN FRAME DEFAULT-FRAME
DO:
        fiFile-Name4  =  INPUT fiFile-Name4.
        if input fiFile-Name4 <> "" then do:
           vBackUp4 =  fiFile-Name4 + "B"  + ".slk".
           fiFile-Name4 = fiFile-Name4 + ".slk". 
        end.
        disp fiFile-Name4 with frame {&frame-name}.       
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
    fi_ac10= INPUT fi_ac10.
    
/*p---------------------------------------------------*/
   IF fi_ac10<> '' THEN DO:
      FIND FIRST xmm600 WHERE  xmm600.acno = fi_ac10 NO-LOCK NO-ERROR NO-WAIT.
      IF AVAIL xmm600 THEN             
           DISP fi_ac10 WITH FRAME {&FRAME-NAME}.
      ELSE DO:      
          MESSAGE "Producer Code not found".        
          DISP   fi_ac10 WITH FRAME {&FRAME-NAME}.
          APPLY "Entry" To fi_ac10 IN FRAME {&FRAME-NAME}.
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
    fi_ac11 = INPUT fi_ac11.
    
/*p---------------------------------------------------*/
   IF fi_ac11 <> '' THEN DO:
      FIND FIRST xmm600 WHERE  xmm600.acno = fi_ac11 NO-LOCK NO-ERROR NO-WAIT.
      IF AVAIL xmm600 THEN             
           DISP fi_ac11 WITH FRAME {&FRAME-NAME}.
      ELSE DO:      
          MESSAGE "Producer Code not found".        
          DISP   fi_ac11  WITH FRAME {&FRAME-NAME}.
          APPLY "Entry" To fi_ac11 IN FRAME {&FRAME-NAME}.
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
    fi_ac12 = INPUT fi_ac12.
    
/*p---------------------------------------------------*/
   IF fi_ac12 <> '' THEN DO:
      FIND FIRST xmm600 WHERE  xmm600.acno = fi_ac12 NO-LOCK NO-ERROR NO-WAIT.
      IF AVAIL xmm600 THEN             
           DISP fi_ac12 WITH FRAME {&FRAME-NAME}.
      ELSE DO:      
          MESSAGE "Producer Code not found".        
          DISP   fi_ac12  WITH FRAME {&FRAME-NAME}.
          APPLY "Entry" To fi_ac12 IN FRAME {&FRAME-NAME}.
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
     fi_ac13 = INPUT fi_ac13.
    
/*p---------------------------------------------------*/
   IF fi_ac13 <> '' THEN DO:
      FIND FIRST xmm600 WHERE  xmm600.acno = fi_ac13 NO-LOCK NO-ERROR NO-WAIT.
      IF AVAIL xmm600 THEN             
           DISP fi_ac13 WITH FRAME {&FRAME-NAME}.
      ELSE DO:      
          MESSAGE "Producer Code not found".        
          DISP   fi_ac13  WITH FRAME {&FRAME-NAME}.
          APPLY "Entry" To fi_ac13 IN FRAME {&FRAME-NAME}.
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
    fi_ac14 = INPUT fi_ac14.
    
/*p---------------------------------------------------*/
   IF fi_ac14 <> '' THEN DO:
      FIND FIRST xmm600 WHERE  xmm600.acno = fi_ac14 NO-LOCK NO-ERROR NO-WAIT.
      IF AVAIL xmm600 THEN             
           DISP fi_ac14 WITH FRAME {&FRAME-NAME}.
      ELSE DO:      
          MESSAGE "Producer Code not found".        
          DISP   fi_ac14  WITH FRAME {&FRAME-NAME}.
          APPLY "Entry" To fi_ac14 IN FRAME {&FRAME-NAME}.
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
     fi_ac15 = INPUT fi_ac15.
    
/*p---------------------------------------------------*/
   IF fi_ac15 <> '' THEN DO:
      FIND FIRST xmm600 WHERE  xmm600.acno = fi_ac15 NO-LOCK NO-ERROR NO-WAIT.
      IF AVAIL xmm600 THEN             
           DISP fi_ac15 WITH FRAME {&FRAME-NAME}.
      ELSE DO:      
          MESSAGE "Producer Code not found".        
          DISP   fi_ac15  WITH FRAME {&FRAME-NAME}.
          APPLY "Entry" To fi_ac15 IN FRAME {&FRAME-NAME}.
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
     fi_ac16 = INPUT fi_ac16.
    
/*p---------------------------------------------------*/
   IF fi_ac16 <> '' THEN DO:
      FIND FIRST xmm600 WHERE  xmm600.acno = fi_ac16 NO-LOCK NO-ERROR NO-WAIT.
      IF AVAIL xmm600 THEN             
           DISP fi_ac16 WITH FRAME {&FRAME-NAME}.
      ELSE DO:      
          MESSAGE "Producer Code not found".        
          DISP   fi_ac16  WITH FRAME {&FRAME-NAME}.
          APPLY "Entry" To fi_ac16 IN FRAME {&FRAME-NAME}.
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
      fi_ac17 = INPUT fi_ac17.
    
/*p---------------------------------------------------*/
   IF fi_ac17 <> '' THEN DO:
      FIND FIRST xmm600 WHERE  xmm600.acno = fi_ac17 NO-LOCK NO-ERROR NO-WAIT.
      IF AVAIL xmm600 THEN             
           DISP fi_ac17 WITH FRAME {&FRAME-NAME}.
      ELSE DO:      
          MESSAGE "Producer Code not found".        
          DISP   fi_ac17  WITH FRAME {&FRAME-NAME}.
          APPLY "Entry" To fi_ac17 IN FRAME {&FRAME-NAME}.
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
     fi_ac18 = INPUT fi_ac18.
    
/*p---------------------------------------------------*/
   IF fi_ac18 <> '' THEN DO:
      FIND FIRST xmm600 WHERE  xmm600.acno = fi_ac18 NO-LOCK NO-ERROR NO-WAIT.
      IF AVAIL xmm600 THEN             
           DISP fi_ac18 WITH FRAME {&FRAME-NAME}.
      ELSE DO:      
          MESSAGE "Producer Code not found".        
          DISP   fi_ac18  WITH FRAME {&FRAME-NAME}.
          APPLY "Entry" To fi_ac18 IN FRAME {&FRAME-NAME}.
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
     fi_ac19 = INPUT fi_ac19.
    
/*p---------------------------------------------------*/
   IF fi_ac19 <> '' THEN DO:
      FIND FIRST xmm600 WHERE  xmm600.acno = fi_ac19 NO-LOCK NO-ERROR NO-WAIT.
      IF AVAIL xmm600 THEN             
           DISP fi_ac19 WITH FRAME {&FRAME-NAME}.
      ELSE DO:      
          MESSAGE "Producer Code not found".        
          DISP   fi_ac19  WITH FRAME {&FRAME-NAME}.
          APPLY "Entry" To fi_ac19 IN FRAME {&FRAME-NAME}.
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
    fi_ac2 = INPUT fi_ac2.
    
/*p---------------------------------------------------*/
   IF fi_ac2 <> '' THEN DO:
      FIND FIRST xmm600 WHERE  xmm600.acno = fi_ac2 NO-LOCK NO-ERROR NO-WAIT.
      IF AVAIL xmm600 THEN             
           DISP fi_ac2 WITH FRAME {&FRAME-NAME}.
      ELSE DO:      
          MESSAGE "Producer Code not found".        
          DISP   fi_ac2  WITH FRAME {&FRAME-NAME}.
          APPLY "Entry" To fi_ac2 IN FRAME {&FRAME-NAME}.
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
    fi_ac20= INPUT fi_ac20.
    
/*p---------------------------------------------------*/
   IF fi_ac20<> '' THEN DO:
      FIND FIRST xmm600 WHERE  xmm600.acno = fi_ac20 NO-LOCK NO-ERROR NO-WAIT.
      IF AVAIL xmm600 THEN             
           DISP fi_ac20 WITH FRAME {&FRAME-NAME}.
      ELSE DO:      
          MESSAGE "Producer Code not found".        
          DISP   fi_ac20 WITH FRAME {&FRAME-NAME}.
          APPLY "Entry" To fi_ac20 IN FRAME {&FRAME-NAME}.
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
    fi_ac21 = INPUT fi_ac21.
    
/*p---------------------------------------------------*/
   IF fi_ac21 <> '' THEN DO:
      FIND FIRST xmm600 WHERE  xmm600.acno = fi_ac21 NO-LOCK NO-ERROR NO-WAIT.
      IF AVAIL xmm600 THEN             
           DISP fi_ac21 WITH FRAME {&FRAME-NAME}.
      ELSE DO:      
          MESSAGE "Producer Code not found".        
          DISP   fi_ac21  WITH FRAME {&FRAME-NAME}.
          APPLY "Entry" To fi_ac21 IN FRAME {&FRAME-NAME}.
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
    fi_ac22 = INPUT fi_ac22.
    
/*p---------------------------------------------------*/
   IF fi_ac22 <> '' THEN DO:
      FIND FIRST xmm600 WHERE  xmm600.acno = fi_ac22 NO-LOCK NO-ERROR NO-WAIT.
      IF AVAIL xmm600 THEN             
           DISP fi_ac22 WITH FRAME {&FRAME-NAME}.
      ELSE DO:      
          MESSAGE "Producer Code not found".        
          DISP   fi_ac22  WITH FRAME {&FRAME-NAME}.
          APPLY "Entry" To fi_ac22 IN FRAME {&FRAME-NAME}.
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
     fi_ac23 = INPUT fi_ac23.
    
/*p---------------------------------------------------*/
   IF fi_ac23 <> '' THEN DO:
      FIND FIRST xmm600 WHERE  xmm600.acno = fi_ac23 NO-LOCK NO-ERROR NO-WAIT.
      IF AVAIL xmm600 THEN             
           DISP fi_ac23 WITH FRAME {&FRAME-NAME}.
      ELSE DO:      
          MESSAGE "Producer Code not found".        
          DISP   fi_ac23  WITH FRAME {&FRAME-NAME}.
          APPLY "Entry" To fi_ac23 IN FRAME {&FRAME-NAME}.
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
    fi_ac24 = INPUT fi_ac24.
    
/*p---------------------------------------------------*/
   IF fi_ac24 <> '' THEN DO:
      FIND FIRST xmm600 WHERE  xmm600.acno = fi_ac24 NO-LOCK NO-ERROR NO-WAIT.
      IF AVAIL xmm600 THEN             
           DISP fi_ac24 WITH FRAME {&FRAME-NAME}.
      ELSE DO:      
          MESSAGE "Producer Code not found".        
          DISP   fi_ac24  WITH FRAME {&FRAME-NAME}.
          APPLY "Entry" To fi_ac24 IN FRAME {&FRAME-NAME}.
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
     fi_ac25 = INPUT fi_ac25.
    
/*p---------------------------------------------------*/
   IF fi_ac25 <> '' THEN DO:
      FIND FIRST xmm600 WHERE  xmm600.acno = fi_ac25 NO-LOCK NO-ERROR NO-WAIT.
      IF AVAIL xmm600 THEN             
           DISP fi_ac25 WITH FRAME {&FRAME-NAME}.
      ELSE DO:      
          MESSAGE "Producer Code not found".        
          DISP   fi_ac25  WITH FRAME {&FRAME-NAME}.
          APPLY "Entry" To fi_ac25 IN FRAME {&FRAME-NAME}.
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
     fi_ac26 = INPUT fi_ac26.
    
/*p---------------------------------------------------*/
   IF fi_ac26 <> '' THEN DO:
      FIND FIRST xmm600 WHERE  xmm600.acno = fi_ac26 NO-LOCK NO-ERROR NO-WAIT.
      IF AVAIL xmm600 THEN             
           DISP fi_ac26 WITH FRAME {&FRAME-NAME}.
      ELSE DO:      
          MESSAGE "Producer Code not found".        
          DISP   fi_ac26  WITH FRAME {&FRAME-NAME}.
          APPLY "Entry" To fi_ac26 IN FRAME {&FRAME-NAME}.
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
      fi_ac27 = INPUT fi_ac27.
    
/*p---------------------------------------------------*/
   IF fi_ac27 <> '' THEN DO:
      FIND FIRST xmm600 WHERE  xmm600.acno = fi_ac27 NO-LOCK NO-ERROR NO-WAIT.
      IF AVAIL xmm600 THEN             
           DISP fi_ac27 WITH FRAME {&FRAME-NAME}.
      ELSE DO:      
          MESSAGE "Producer Code not found".        
          DISP   fi_ac27  WITH FRAME {&FRAME-NAME}.
          APPLY "Entry" To fi_ac27 IN FRAME {&FRAME-NAME}.
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
     fi_ac28 = INPUT fi_ac28.
    
/*p---------------------------------------------------*/
   IF fi_ac28 <> '' THEN DO:
      FIND FIRST xmm600 WHERE  xmm600.acno = fi_ac28 NO-LOCK NO-ERROR NO-WAIT.
      IF AVAIL xmm600 THEN             
           DISP fi_ac28 WITH FRAME {&FRAME-NAME}.
      ELSE DO:      
          MESSAGE "Producer Code not found".        
          DISP   fi_ac28  WITH FRAME {&FRAME-NAME}.
          APPLY "Entry" To fi_ac28 IN FRAME {&FRAME-NAME}.
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
     fi_ac3 = INPUT fi_ac3.
    
/*p---------------------------------------------------*/
   IF fi_ac3 <> '' THEN DO:
      FIND FIRST xmm600 WHERE  xmm600.acno = fi_ac3 NO-LOCK NO-ERROR NO-WAIT.
      IF AVAIL xmm600 THEN             
           DISP fi_ac3 WITH FRAME {&FRAME-NAME}.
      ELSE DO:      
          MESSAGE "Producer Code not found".        
          DISP   fi_ac3  WITH FRAME {&FRAME-NAME}.
          APPLY "Entry" To fi_ac3 IN FRAME {&FRAME-NAME}.
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
    fi_ac4 = INPUT fi_ac4.
    
/*p---------------------------------------------------*/
   IF fi_ac4 <> '' THEN DO:
      FIND FIRST xmm600 WHERE  xmm600.acno = fi_ac4 NO-LOCK NO-ERROR NO-WAIT.
      IF AVAIL xmm600 THEN             
           DISP fi_ac4 WITH FRAME {&FRAME-NAME}.
      ELSE DO:      
          MESSAGE "Producer Code not found".        
          DISP   fi_ac4  WITH FRAME {&FRAME-NAME}.
          APPLY "Entry" To fi_ac4 IN FRAME {&FRAME-NAME}.
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
     fi_ac5 = INPUT fi_ac5.
    
/*p---------------------------------------------------*/
   IF fi_ac5 <> '' THEN DO:
      FIND FIRST xmm600 WHERE  xmm600.acno = fi_ac5 NO-LOCK NO-ERROR NO-WAIT.
      IF AVAIL xmm600 THEN             
           DISP fi_ac5 WITH FRAME {&FRAME-NAME}.
      ELSE DO:      
          MESSAGE "Producer Code not found".        
          DISP   fi_ac5  WITH FRAME {&FRAME-NAME}.
          APPLY "Entry" To fi_ac5 IN FRAME {&FRAME-NAME}.
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
     fi_ac6 = INPUT fi_ac6.
    
/*p---------------------------------------------------*/
   IF fi_ac6 <> '' THEN DO:
      FIND FIRST xmm600 WHERE  xmm600.acno = fi_ac6 NO-LOCK NO-ERROR NO-WAIT.
      IF AVAIL xmm600 THEN             
           DISP fi_ac6 WITH FRAME {&FRAME-NAME}.
      ELSE DO:      
          MESSAGE "Producer Code not found".        
          DISP   fi_ac6  WITH FRAME {&FRAME-NAME}.
          APPLY "Entry" To fi_ac6 IN FRAME {&FRAME-NAME}.
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
      fi_ac7 = INPUT fi_ac7.
    
/*p---------------------------------------------------*/
   IF fi_ac7 <> '' THEN DO:
      FIND FIRST xmm600 WHERE  xmm600.acno = fi_ac7 NO-LOCK NO-ERROR NO-WAIT.
      IF AVAIL xmm600 THEN             
           DISP fi_ac7 WITH FRAME {&FRAME-NAME}.
      ELSE DO:      
          MESSAGE "Producer Code not found".        
          DISP   fi_ac7  WITH FRAME {&FRAME-NAME}.
          APPLY "Entry" To fi_ac7 IN FRAME {&FRAME-NAME}.
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
     fi_ac8 = INPUT fi_ac8.
    
/*p---------------------------------------------------*/
   IF fi_ac8 <> '' THEN DO:
      FIND FIRST xmm600 WHERE  xmm600.acno = fi_ac8 NO-LOCK NO-ERROR NO-WAIT.
      IF AVAIL xmm600 THEN             
           DISP fi_ac8 WITH FRAME {&FRAME-NAME}.
      ELSE DO:      
          MESSAGE "Producer Code not found".        
          DISP   fi_ac8  WITH FRAME {&FRAME-NAME}.
          APPLY "Entry" To fi_ac8 IN FRAME {&FRAME-NAME}.
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
     fi_ac9 = INPUT fi_ac9.
    
/*p---------------------------------------------------*/
   IF fi_ac9 <> '' THEN DO:
      FIND FIRST xmm600 WHERE  xmm600.acno = fi_ac9 NO-LOCK NO-ERROR NO-WAIT.
      IF AVAIL xmm600 THEN             
           DISP fi_ac9 WITH FRAME {&FRAME-NAME}.
      ELSE DO:      
          MESSAGE "Producer Code not found".        
          DISP   fi_ac9  WITH FRAME {&FRAME-NAME}.
          APPLY "Entry" To fi_ac9 IN FRAME {&FRAME-NAME}.
          RETURN NO-APPLY.             
      END. /*not in xmm600*/      
  END. /*<> */                                                   
/*---------------------------------------------------p*/  
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
  
  gv_prgid = "wactas2".
  gv_prog  = "ข้อมูลที่ไม่ได้ส่งไปให้ Thai Auto Sales =>wactas2.w".
  RUN  WUT\WUTHEAD (c-win:handle,gv_prgid,gv_prog).

/*********************************************************************/  

   RECT-1:move-to-top( ).  
   RECT-2:move-to-top( ).
   RECT-3:move-to-top( ).
   RECT-4:move-to-top( ).
   RECT-10:move-to-top( ).
   
/*------------------------*/
  vAcProc_fil = "" .
  FOR EACH AcProc_fil USE-INDEX by_type_asdat  WHERE AcProc_fil.type = "01"
         BY asdat DESC  :
      ASSIGN
          vAcProc_fil = vAcProc_fil + STRING( AcProc_fil.asdat,"99/99/9999")  + ",".
  END.
   cbAsdat  = vAcProc_fil.  
  ASSIGN
    cbAsDat:List-Items IN FRAME {&FRAME-NAME} = vAcProc_fil
    cbAsDat = ENTRY (1, vAcProc_fil).
/************************/ /***********************/ /*********************/
  vAcProc_fil1 = "" .
  
  FOR EACH AcProc_fil USE-INDEX by_type_asdat  WHERE AcProc_fil.type = "02"
      BY asdat DESC  :

      ASSIGN
          vAcProc_fil1 = vAcProc_fil1 + STRING( AcProc_fil.asdat,"99/99/9999")  + ",".
  END.
   cbExportDat  = vAcProc_fil1.  
 
  ASSIGN
    cbExportDat:List-Items IN FRAME {&FRAME-NAME} = vAcProc_fil1
    cbExportDat = ENTRY (1, vAcProc_fil1).
 
  DISP cbAsDat   cbExportDat  WITH FRAME {&FRAME-NAME} . 
  
/*------------------------*/
  
  SESSION:DATA-ENTRY-RETURN = YES.  
  ASSIGN
      fibranch     = '0'
      fibranch2   = 'z'
      n_branch   = fibranch
      n_branch2 = fibranch2
      fi_process = ""      
      n_OutputFile1 = ""
      n_OutputFile2 = ""
      n_OutputFile3 = ""
      n_OutputFile4 = ""
      fiFile-Name1 = ""
      fiFile-Name2 = ""
      fiFile-Name3 = ""
      fiFile-Name4 = "".

  DISP fibranch fibranch2 fi_process  WITH FRAME {&FRAME-NAME}.

    FIND   xmm023 WHERE xmm023.branch = fibranch  NO-ERROR.
    IF AVAILABLE xmm023 THEN DO:
        ASSIGN
            fibdes = xmm023.bdes.
        DISP
            fibdes WITH FRAME {&FRAME-NAME}.
    END.

    FIND   xmm023 WHERE xmm023.branch = fibranch2  NO-ERROR.
    IF AVAILABLE xmm023 THEN DO:
        ASSIGN
            fibdes2 =  xmm023.bdes.
        DISP
            fibdes2 WITH FRAME {&FRAME-NAME}.
    END.

/****************/
   ASSIGN
      fi_ac1   = 'A000324'
      fi_ac2   = 'A010086'
      fi_ac3   = 'A020116'
      fi_ac4   = 'A030079'
      fi_ac5   = 'A050135'
      fi_ac6   = 'A070118'
      fi_ac7   = 'A080121'
      fi_ac8   = 'A0A0001'
      fi_ac9   = 'A0E0082'
      fi_ac10  = 'A0K0011'
      fi_ac11  = 'A0M2001'
      fi_ac12  = 'A0N0051'
      fi_ac13  = 'A0U0003'
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
      /*--- A500178 --- ปิดฟิลด์ ---
      fi_ac29 = nv_ac29
      fi_ac30 = nv_ac30
      ------*/ .
      DISP fi_ac1    fi_ac2   fi_ac3   fi_ac4   fi_ac5    
           fi_ac6    fi_ac7   fi_ac8   fi_ac9   fi_ac10
           fi_ac11   fi_ac12  fi_ac13  fi_ac14  fi_ac15   
           fi_ac16   fi_ac17  fi_ac18  fi_ac19  fi_ac20
           fi_ac21   fi_ac22  fi_ac23  fi_ac24  fi_ac25   
           fi_ac26   fi_ac27  fi_ac28  /*--- A500178 --- ปิดฟิลด์ --- fi_ac29  fi_ac30 */
      WITH FRAME {&FRAME-NAME}.
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
  DISPLAY fiBranch fiBranch2 fi_ac1 fi_ac2 fi_ac3 fi_ac4 fi_ac5 fi_ac6 fi_ac7 
          fi_ac8 fi_ac9 fi_ac10 fi_ac11 fi_ac12 fi_ac13 fi_ac14 fi_ac15 fi_ac16 
          fi_ac17 fi_ac18 fi_ac19 fi_ac20 fi_ac21 fi_ac22 fi_ac23 fi_ac24 
          fi_ac25 fi_ac26 fi_ac27 fi_ac28 cbAsDat cbExportDat fiFile-Name1 
          fiFile-Name2 fiFile-Name3 fiFile-Name4 fibdes fibdes2 fi_process 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE RECT-6 RECT-2 RECT-5 RECT-3 RECT-8 RECT-10 RECT-9 RECT-4 RECT-7 RECT-1 
         fiBranch buBranch fiBranch2 buBranch2 fi_ac1 fi_ac2 fi_ac3 fi_ac4 
         fi_ac5 fi_ac6 fi_ac7 fi_ac8 fi_ac9 fi_ac10 fi_ac11 fi_ac12 fi_ac13 
         fi_ac14 fi_ac15 fi_ac16 fi_ac17 fi_ac18 fi_ac19 fi_ac20 fi_ac21 
         fi_ac22 fi_ac23 fi_ac24 fi_ac25 fi_ac26 fi_ac27 fi_ac28 cbAsDat 
         cbExportDat fiFile-Name1 fiFile-Name2 fiFile-Name3 fiFile-Name4 Btn_OK 
         Btn_Exit fibdes fibdes2 fi_process 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  VIEW C-Win.
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

    IF SUBSTR(nv_eng2 , 1 , 1)  >= "0" AND SUBSTR(nv_eng2,1 ,1) <= "9"  AND 
       SUBSTR(nv_eng2 , 2 , 1)  >= "a" AND SUBSTR(nv_eng2,2 ,1) <= "z"  THEN DO:
   
        IF SUBSTR(nv_eng2 , 3 , 1) >= "0" AND SUBSTR(nv_eng2,3 ,1) <= "9"  THEN
           nv_char2 = SUBSTR(nv_eng2,1,2) + " " + SUBSTR(nv_eng2 , 3 , LENGTH(nv_eng2)). 
        IF SUBSTR(nv_eng2 , 3 , 1) = "" THEN nv_char2 = nv_eng2.
   
    END.
    ELSE DO:

/***************************/
        nv_l2 = 1.

        REPEAT while nv_l2 <= LENGTH(nv_eng2):

             IF SUBSTR(nv_eng2,nv_l2 ,1) >= "0" AND
                  SUBSTR(nv_eng2,nv_l2 ,1) <= "9"
                  THEN DO:

                  IF nv_spc2 THEN 
                      nv_char2 = TRIM(nv_char2) + " " + SUBSTR(nv_eng2,nv_l2 ,1).
                 ELSE
                      nv_char2 = TRIM(nv_char2) + SUBSTR(nv_eng2,nv_l2 ,1).

                nv_spc2 = NO.
             END.
             ELSE DO:
                IF SUBSTR(nv_eng2,nv_l2 ,1) >= "A" AND
                    SUBSTR(nv_eng2,nv_l2 ,1) <= "Z"
                    THEN DO:

                    IF nv_spc2 = NO THEN
                        nv_char2 = TRIM(nv_char2) + " " + SUBSTR(nv_eng2,nv_l2 ,1).
                    ELSE
                        nv_char2 = TRIM(nv_char2) + SUBSTR(nv_eng2,nv_l2 ,1).

                    nv_spc2 = YES.
                END.
            END.
            nv_l2 = nv_l2 + 1.
        END.
    END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdEng C-Win 
PROCEDURE pdEng :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       engine no.
------------------------------------------------------------------------------*/

/*nv_eng1 = "2-SD332/GG1225".*/

    IF SUBSTR(nv_eng1, 1 , 1) >= "0" AND SUBSTR(nv_eng1,1 ,1) <= "9"  AND 
       SUBSTR(nv_eng1, 2 , 1) >= "a" AND SUBSTR(nv_eng1,2 ,1) <= "z"  THEN DO:
   
       IF SUBSTR(nv_eng1 , 3 , 1)  >= "0" AND SUBSTR(nv_eng1,3 ,1) <= "9"  THEN
           nv_char1 = SUBSTR(nv_eng1,1,2) + " " + SUBSTR(nv_eng1 , 3 , LENGTH(nv_eng1)). 
       IF  SUBSTR(nv_eng1 , 3 , 1)  = "" THEN nv_char1 = nv_eng1.
   
    END.
    ELSE DO:

/***************************/
        nv_l1 = 1.

        REPEAT while nv_l1 <= LENGTH(nv_eng1):

             IF SUBSTR(nv_eng1,nv_l1 ,1) >= "0" AND
                 SUBSTR(nv_eng1,nv_l1 ,1) <= "9"
                 THEN DO:

                 IF nv_spc1 THEN 
                     nv_char1 = TRIM(nv_char1) + " " + SUBSTR(nv_eng1,nv_l1 ,1).
                 ELSE
                     nv_char1 = TRIM(nv_char1) + SUBSTR(nv_eng1,nv_l1 ,1).

                 nv_spc1 = NO.
             END.
             ELSE DO:
                 IF SUBSTR(nv_eng1,nv_l1 ,1) >= "A" AND
                     SUBSTR(nv_eng1,nv_l1 ,1) <= "Z"
                     THEN DO:
                      IF nv_spc1 = NO THEN
                           nv_char1 = TRIM(nv_char1) + " " + SUBSTR(nv_eng1,nv_l1 ,1).
                      ELSE
                           nv_char1 = TRIM(nv_char1) + SUBSTR(nv_eng1,nv_l1 ,1).

                      nv_spc1 = YES.
                END.
             END.  /*ELSE  do*/
             nv_l1 = nv_l1 + 1.

        END.  /*repeat*/
    END.  /*ELSE  do*/
    
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdexcel1 C-Win 
PROCEDURE pdexcel1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       bal เหลือไว้ match ภาษี 1 %
------------------------------------------------------------------------------*/
/*----------------------------- export to excel file  ***---------------------------*/
    OUTPUT STREAM filebill1 TO VALUE(fiFile-Name1).

    PUT  STREAM  filebill1  "ID;PND"  SKIP.

/* 1. Header */
    PUT STREAM filebill1 "C;Y1;X1;K"  '"' "Safety Insurance Public Company Limited " '"' skip.
    PUT STREAM filebill1 "C;Y1;X2;K"  '"' TODAY   '"'                 skip.
    PUT STREAM filebill1 "C;Y1;X3;K"  '"' n_asdat    '"'              skip.
    PUT STREAM filebill1 "C;Y2;X1;K"  '"' "Customer Name " '"'        skip.
    PUT STREAM filebill1 "C;Y2;X2;K"  '"' "Normal Policy Number " '"' skip.
    PUT STREAM filebill1 "C;Y2;X3;K"  '"' "Compulsory Policy Number " '"' skip.
    PUT STREAM filebill1 "C;Y2;X4;K"  '"' "Engine " '"'               skip.
    PUT STREAM filebill1 "C;Y2;X5;K"  '"' "Chassis " '"'              skip.
    PUT STREAM filebill1 "C;Y2;X6;K"  '"' "Contract No. " '"'         skip.
    PUT STREAM filebill1 "C;Y2;X7;K"  '"' "Licence " '"'              skip.
    PUT STREAM filebill1 "C;Y2;X8;K"  '"' "Insured Date " '"'         skip.
    PUT STREAM filebill1 "C;Y2;X9;K"  '"' "Normal Gross Premium " '"' skip.
    PUT STREAM filebill1 "C;Y2;X10;K" '"' "Compulsory Gross Premium " '"' skip.
    PUT STREAM filebill1 "C;Y2;X11;K" '"' "Normal Net Premium " '"'   skip.
    PUT STREAM filebill1 "C;Y2;X12;K" '"' "Compulsory Net Premium " '"' skip.
    PUT STREAM filebill1 "C;Y2;X13;K" '"' "W/H TAX 1% " '"'           skip.
    PUT STREAM filebill1 "C;Y2;X14;K" '"' "Net Payment " '"'          skip.                  
/*p*/

/* 2. detail*/
    vExpCount1= 0.

    loop1:
    FOR EACH billing  USE-INDEX billing02 WHERE 
             billing.trndat = nv_exportdat AND
             billing.asdat  = n_asdat          AND
     (LOOKUP(billing.acno1,nv_acnoAll) <> 0 ) AND  /* A46-0426*/
/*A46-0426---                                 
            (billing.acno1 = fi_ac1           OR
             billing.acno1 = fi_ac2           OR
             billing.acno1 = fi_ac3           OR
             billing.acno1 = fi_ac4           OR
             billing.acno1 = fi_ac5           OR
             billing.acno1 = fi_ac6           OR
             billing.acno1 = fi_ac7           OR
             billing.acno1 = fi_ac8           OR
             billing.acno1 = fi_ac9           OR
             billing.acno1 = fi_ac10  )       AND
---A46-0426*/                                 
            (billing.branch >= fibranch       AND
             billing.branch <= fibranch2)     AND
             billing.error    = 'e' 
    NO-LOCK              
    BREAK BY billing.start_date by  billing.nor_policy:   
/*********************/
   ASSIGN
       n_cusnam     = ''
       n_norpol     = ''
       n_cppol      = ''
       n_contract   = ''
       n_stdate     = ? 
       n_norgrp     = 0 
       n_cpgrp      = 0 
       n_nornetprm  = 0 
       n_cpnetprm   = 0 
       n_whtax1     = 0 
       n_netamt     = 0.
/*p                 
             FIND FIRST agtprm_fil WHERE agtprm_fil.asdat   = n_asdat AND
                        agtprm_fil.acno    = billing.acno1            AND
                        agtprm_fil.policy  = billing.policy           AND
                        agtprm_fil.trnty     = billing.trnty1 + billing.trnty2    AND
                        agtprm_fil.docno = billing.docno          
                    NO-LOCK NO-ERROR NO-WAIT.
             IF AVAIL agtprm_fil THEN DO:
                 n_netamt = agtprm_fil.bal.                                      
p*/
/*p*/    n_netamt = billing.bal.  
                 
/*--------p*/                                             
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

             DISP  billing.policy + ' ' + billing.trnty1 +  ' ' + billing.trnty2 + ' ' +
                   billing.docno FORMAT "X(10)" /* Benjaporn J. A60-0267 date 27/06/2017 */
                   @ fi_process with frame {&frame-name}.
         
/***********************/
             ASSIGN
                 n_cusnam     =  billing.cust_name
                 n_norpol     =  billing.nor_policy
                 n_cppol      =  billing.comp_policy
                 n_contract   =  billing.contract
                 n_stdate     =  billing.start_date
                 n_norgrp     =  billing.nor_grp
                 n_cpgrp      =  billing.comp_grp
                 n_nornetprm  =  billing.nor_netprm
                 n_cpnetprm   =  billing.comp_netprm
                 n_whtax1     =  billing.whtax1
                 n_netamt     =  n_netamt.
/***********************/        
             vExpCount1= vExpCount1 + 1.
             n_row1 = n_row1 + 1.
         
             PUT STREAM  filebill1 "C;Y" string(n_row1)  ";X1;K"   '"' n_cusnam '"'   skip.
             PUT STREAM  filebill1 "C;Y" string(n_row1)  ";X2;K"   '"' n_norpol '"'   skip.
             PUT STREAM  filebill1 "C;Y" string(n_row1)  ";X3;K"   '"' n_cppol '"'    skip.
             PUT STREAM  filebill1 "C;Y" string(n_row1)  ";X4;K"   '"' engine '"'     skip.       
             PUT STREAM  filebill1 "C;Y" string(n_row1)  ";X5;K"   '"' chas '"'       skip.
             PUT STREAM  filebill1 "C;Y" string(n_row1)  ";X6;K"   '"' n_contract '"' skip.
             PUT STREAM  filebill1 "C;Y" string(n_row1)  ";X7;K"   '"' engc '"'       skip.
             PUT STREAM  filebill1 "C;Y" string(n_row1)  ";X8;K"   '"' n_stdate '"'   skip.
             PUT STREAM  filebill1 "C;Y" string(n_row1)  ";X9;K"   '"' n_norgrp '"'   skip.
             PUT STREAM  filebill1 "C;Y" string(n_row1)  ";X10;K"  '"' n_cpgrp '"'    skip.
             PUT STREAM  filebill1 "C;Y" string(n_row1)  ";X11;K"  '"'n_nornetprm '"' skip.
             PUT STREAM  filebill1 "C;Y" string(n_row1)  ";X12;K"  '"'n_cpnetprm '"'  skip.
             PUT STREAM  filebill1 "C;Y" string(n_row1)  ";X13;K"  '"'n_whtax1 '"'    skip.
             PUT STREAM  filebill1 "C;Y" string(n_row1)  ";X14;K"  '"'n_netamt '"'    skip.

/*********************/
                   
             END.  /* for each Billing*/

  
    PUT STREAM  filebill1  "E"  skip.      
         
    OUTPUT STREAM filebill1 CLOSE.
            
/*   vBackUp =  fiFile-Name1 + "B".*/
    
    DOS SILENT  COPY VALUE(fiFile-Name1) VALUE(vBackUP1) /Y  .   /* backup file exports */
             
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdexcel2 C-Win 
PROCEDURE pdexcel2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:   Type "R"    Bal >0 
-----------------------------------------------------------------------------*/
/*----------------------------- export to excel file  ***---------------------------*/

    OUTPUT STREAM filebill2 TO VALUE(fiFile-Name2).
    PUT  STREAM  filebill2  "ID;PND"  SKIP.

/* 1. Header */
    PUT STREAM filebill2 "C;Y1;X1;K"  '"' "Safety Insurance Public Company Limited " '"' skip.
    PUT STREAM filebill2 "C;Y1;X2;K"  '"' TODAY   '"' skip.
    PUT STREAM filebill2 "C;Y1;X3;K"  '"' n_asdat    '"' skip.
    PUT STREAM filebill2 "C;Y1;X3;K"  '"' "Type R  &  Bal >0 "   '"' skip.
    PUT STREAM filebill2 "C;Y2;X1;K"  '"' "Customer Name " '"' skip.
    PUT STREAM filebill2 "C;Y2;X2;K"  '"' "Normal Policy Number " '"' skip.
    PUT STREAM filebill2 "C;Y2;X3;K"  '"' "Compulsory Policy Number " '"' skip.
    PUT STREAM filebill2 "C;Y2;X4;K"  '"' "Engine " '"' skip.
    PUT STREAM filebill2 "C;Y2;X5;K"  '"' "Chassis " '"' skip.
    PUT STREAM filebill2 "C;Y2;X6;K"  '"' "Contract No. " '"' skip.
    PUT STREAM filebill2 "C;Y2;X7;K"  '"' "Licence " '"' skip.
    PUT STREAM filebill2 "C;Y2;X8;K"  '"' "Insured Date " '"' skip.
    PUT STREAM filebill2 "C;Y2;X9;K"  '"' "Normal Gross Premium " '"' skip.
    PUT STREAM filebill2 "C;Y2;X10;K" '"' "Compulsory Gross Premium " '"' skip.
    PUT STREAM filebill2 "C;Y2;X11;K" '"' "Normal Net Premium " '"' skip.
    PUT STREAM filebill2 "C;Y2;X12;K" '"' "Compulsory Net Premium " '"' skip.
    PUT STREAM filebill2 "C;Y2;X13;K" '"' "W/H TAX 1% " '"' skip.
    PUT STREAM filebill2 "C;Y2;X14;K" '"' "Net Payment " '"' skip.         

/* 2. detail*/

    loop1:
    FOR EACH billing  USE-INDEX billing02 WHERE 
             billing.trndat = nv_exportdat    AND
             billing.asdat  = n_asdat          AND
     (LOOKUP(billing.acno1,nv_acnoAll) <> 0 ) AND  /* A46-0426*/
/*A46-0426---                                 
            (billing.acno1 = fi_ac1           OR
             billing.acno1 = fi_ac2           OR
             billing.acno1 = fi_ac3           OR
             billing.acno1 = fi_ac4           OR
             billing.acno1 = fi_ac5           OR
             billing.acno1 = fi_ac6           OR
             billing.acno1 = fi_ac7           OR
             billing.acno1 = fi_ac8           OR
             billing.acno1 = fi_ac9           OR
             billing.acno1 = fi_ac10  )       AND
---A46-0426*/
            (billing.branch >= fibranch       AND
             billing.branch <= fibranch2)  
    NO-LOCK              
    BREAK BY billing.start_date by  billing.nor_policy:   
/*p---------*/    
        ASSIGN
          n_cusnam     = '' 
          n_norpol     = '' 
          n_cppol      = '' 
          n_contract   = '' 
          n_stdate     = ?  
          n_norgrp     = 0  
          n_cpgrp      = 0  
          n_nornetprm  = 0  
          n_cpnetprm   = 0  
          n_whtax1     = 0  
          n_netamt     = 0.             /*vExpCount2 = 0.           */
                 
/*ppp*/ IF billing.trnty1 = 'r'    AND billing.bal > 0 THEN DO:
/*p                 
             FIND FIRST agtprm_fil WHERE agtprm_fil.asdat   = n_asdat                  AND
                        agtprm_fil.acno    = billing.acno1          AND 
                        agtprm_fil.policy  = billing.policy         AND 
                        agtprm_fil.trnty     = 'r' + billing.trnty2 AND 
                        agtprm_fil.docno = billing.docno            AND 
                        agtprm_fil.bal      > 0
                    NO-LOCK NO-ERROR NO-WAIT.
             IF AVAIL agtprm_fil THEN DO:
                 n_netamt = agtprm_fil.bal.                                      
p*/
/*p*/        n_netamt = billing.bal. 
/*--------p*/                                             
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
             
             IF billing.chassis <> "" then do:
                nv_eng2 = billing.chassis.
                RUN pdchas.
                chas = nv_char2.
                nv_char2 = ''.
                nv_eng2 = ''.
             end.         
             else 
                chas = ''.                  
    
             DISP  billing.policy + ' ' + billing.trnty1 +  ' ' + billing.trnty2 + ' ' +
                   billing.docno FORMAT "X(10)" /* Benjaporn J. A60-0267 date 27/06/2017 */
                   @ fi_process with frame {&frame-name}.
         
/***********************/
             ASSIGN
                n_cusnam     =  billing.cust_name
                n_norpol     =  billing.nor_policy
                n_cppol      =  billing.comp_policy
                n_contract   =  billing.contract
                n_stdate     =  billing.start_date
                n_norgrp     =  billing.nor_grp
                n_cpgrp      =  billing.comp_grp
                n_nornetprm  =  billing.nor_netprm
                n_cpnetprm   =  billing.comp_netprm
                n_whtax1     =  billing.whtax1.
/***********************/        
                 vExpCount2 = vExpCount2 + 1.
                 n_row2 = n_row2 + 1.
         
             PUT STREAM  filebill2 "C;Y" string(n_row2)  ";X1;K"   '"' n_cusnam '"' skip.
             PUT STREAM  filebill2 "C;Y" string(n_row2)  ";X2;K"   '"' n_norpol '"' skip.
             PUT STREAM  filebill2 "C;Y" string(n_row2)  ";X3;K"   '"' n_cppol '"' skip.
             PUT STREAM  filebill2 "C;Y" string(n_row2)  ";X4;K"   '"' engine '"' skip.       
             PUT STREAM  filebill2 "C;Y" string(n_row2)  ";X5;K"   '"' chas '"' skip.
             PUT STREAM  filebill2 "C;Y" string(n_row2)  ";X6;K"   '"' n_contract '"' skip.
             PUT STREAM  filebill2 "C;Y" string(n_row2)  ";X7;K"   '"' engc '"' skip.
             PUT STREAM  filebill2 "C;Y" string(n_row2)  ";X8;K"   '"' n_stdate '"' skip.
             PUT STREAM  filebill2 "C;Y" string(n_row2)  ";X9;K"   '"' n_norgrp '"' skip.
             PUT STREAM  filebill2 "C;Y" string(n_row2)  ";X10;K"  '"' n_cpgrp '"' skip.
             PUT STREAM  filebill2 "C;Y" string(n_row2)  ";X11;K"  '"'n_nornetprm '"' skip.
             PUT STREAM  filebill2 "C;Y" string(n_row2)  ";X12;K"  '"'n_cpnetprm '"' skip.
             PUT STREAM  filebill2 "C;Y" string(n_row2)  ";X13;K"  '"'n_whtax1 '"' skip.
             PUT STREAM  filebill2 "C;Y" string(n_row2)  ";X14;K"  '"'n_netamt '"' skip.
                    
           END.  /*R BAL >0*/  
    END.  /* for each Billing*/
/*--------*/     
    PUT STREAM  filebill2  "E"  skip.               
    OUTPUT STREAM filebill2 CLOSE.
            
/*  vBackUp =  fiFile-Name1 + "B".*/
    
    DOS SILENT  COPY VALUE(fiFile-Name2) VALUE(vBackUP2) /Y  .   /* backup file exports */
               
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdexcel3 C-Win 
PROCEDURE pdexcel3 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:   Type "M"    Bal < 0 
-----------------------------------------------------------------------------*/
/*----------------------------- export to excel file  ***---------------------------*/

    OUTPUT STREAM filebill3 TO VALUE(fiFile-Name3).
    PUT  STREAM  filebill3  "ID;PND"  SKIP.

/* 1. Header */
    PUT STREAM filebill3 "C;Y1;X1;K"  '"' "Safety Insurance Public Company Limited " '"' skip.
    PUT STREAM filebill3 "C;Y1;X2;K"  '"' TODAY   '"' skip.
    PUT STREAM filebill3 "C;Y1;X3;K"  '"' n_asdat    '"' skip.
    PUT STREAM filebill3 "C;Y1;X3;K"  '"' "Type M  &  Bal < 0 "   '"' skip.
    PUT STREAM filebill3 "C;Y2;X1;K"  '"' "Customer Name " '"' skip.
    PUT STREAM filebill3 "C;Y2;X2;K"  '"' "Normal Policy Number " '"' skip.
    PUT STREAM filebill3 "C;Y2;X3;K"  '"' "Compulsory Policy Number " '"' skip.
    PUT STREAM filebill3 "C;Y2;X4;K"  '"' "Engine " '"' skip.
    PUT STREAM filebill3 "C;Y2;X5;K"  '"' "Chassis " '"' skip.
    PUT STREAM filebill3 "C;Y2;X6;K"  '"' "Contract No. " '"' skip.
    PUT STREAM filebill3 "C;Y2;X7;K"  '"' "Licence " '"' skip.
    PUT STREAM filebill3 "C;Y2;X8;K"  '"' "Insured Date " '"' skip.
    PUT STREAM filebill3 "C;Y2;X9;K"  '"' "Normal Gross Premium " '"' skip.
    PUT STREAM filebill3 "C;Y2;X10;K" '"' "Compulsory Gross Premium " '"' skip.
    PUT STREAM filebill3 "C;Y2;X11;K" '"' "Normal Net Premium " '"' skip.
    PUT STREAM filebill3 "C;Y2;X12;K" '"' "Compulsory Net Premium " '"' skip.
    PUT STREAM filebill3 "C;Y2;X13;K" '"' "W/H TAX 1% " '"' skip.
    PUT STREAM filebill3 "C;Y2;X14;K" '"' "Net Payment " '"' skip.         

/* 2. detail*/
    loop1:
    FOR EACH billing  USE-INDEX billing02 WHERE 
             billing.trndat = nv_exportdat    AND
             billing.asdat = n_asdat          AND
     (LOOKUP(billing.acno1,nv_acnoAll) <> 0 ) AND  /* A46-0426*/
/*A46-0426---                                 
            (billing.acno1 = fi_ac1           OR
             billing.acno1 = fi_ac2           OR
             billing.acno1 = fi_ac3           OR
             billing.acno1 = fi_ac4           OR
             billing.acno1 = fi_ac5           OR
             billing.acno1 = fi_ac6           OR
             billing.acno1 = fi_ac7           OR
             billing.acno1 = fi_ac8           OR
             billing.acno1 = fi_ac9           OR
             billing.acno1 = fi_ac10  )       AND
---A46-0426*/                                 
            (billing.branch >= fibranch       AND 
             billing.branch <= fibranch2)
    NO-LOCK              
    BREAK BY billing.start_date by  billing.nor_policy:   
/*p---------*/    
        ASSIGN
          n_cusnam     = '' 
          n_norpol     = '' 
          n_cppol      = '' 
          n_contract   = '' 
          n_stdate     = ?  
          n_norgrp     = 0  
          n_cpgrp      = 0  
          n_nornetprm  = 0  
          n_cpnetprm   = 0  
          n_whtax1     = 0  
          n_netamt     = 0.             /*vExpCount3 = 0.           */
/*p                 
             FIND FIRST agtprm_fil WHERE agtprm_fil.asdat   = n_asdat                  AND
                        agtprm_fil.acno    = billing.acno1          AND 
                        agtprm_fil.policy  = billing.policy         AND 
                        agtprm_fil.trnty     = 'm' + billing.trnty2 AND 
                        agtprm_fil.docno = billing.docno            AND 
                        agtprm_fil.bal      < 0
                    NO-LOCK NO-ERROR NO-WAIT.
             IF AVAIL agtprm_fil THEN DO:
                 n_netamt = agtprm_fil.bal.                                      
p*/

          IF billing.trnty1 = 'm' and billing.bal < 0 THEN DO:

/*p*/        n_netamt = billing.bal.    
/*--------p*/                                             
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
             
             IF billing.chassis <> "" then do:
                nv_eng2 = billing.chassis.
                RUN pdchas.
                chas = nv_char2.
                nv_char2 = ''.
                nv_eng2 = ''.
             end.         
             else 
                chas = ''.                  
    
             DISP  billing.policy + ' ' + billing.trnty1 +  ' ' + billing.trnty2 + ' ' +
                   billing.docno FORMAT "X(10)" /* Benjaporn J. A60-0267 date 27/06/2017 */
                   @ fi_process with frame {&frame-name}.
         
/***********************/
             ASSIGN
                n_cusnam    =  billing.cust_name
                n_norpol    =  billing.nor_policy
                n_cppol     =  billing.comp_policy
                n_contract  =  billing.contract
                n_stdate    =  billing.start_date
                n_norgrp    =  billing.nor_grp
                n_cpgrp     =  billing.comp_grp
                n_nornetprm =  billing.nor_netprm
                n_cpnetprm  =  billing.comp_netprm
                n_whtax1    =  billing.whtax1.
/***********************/        
            vExpCount3 = vExpCount3 + 1.
            n_row3 = n_row3 + 1.
         
            PUT STREAM  filebill3 "C;Y" string(n_row3)  ";X1;K"   '"' n_cusnam '"' skip.
            PUT STREAM  filebill3 "C;Y" string(n_row3)  ";X2;K"   '"' n_norpol '"' skip.
            PUT STREAM  filebill3 "C;Y" string(n_row3)  ";X3;K"   '"' n_cppol '"' skip.
            PUT STREAM  filebill3 "C;Y" string(n_row3)  ";X4;K"   '"' engine '"' skip.       
            PUT STREAM  filebill3 "C;Y" string(n_row3)  ";X5;K"   '"' chas '"' skip.
            PUT STREAM  filebill3 "C;Y" string(n_row3)  ";X6;K"   '"' n_contract '"' skip.
            PUT STREAM  filebill3 "C;Y" string(n_row3)  ";X7;K"   '"' engc '"' skip.
            PUT STREAM  filebill3 "C;Y" string(n_row3)  ";X8;K"   '"' n_stdate '"' skip.
            PUT STREAM  filebill3 "C;Y" string(n_row3)  ";X9;K"   '"' n_norgrp '"' skip.
            PUT STREAM  filebill3 "C;Y" string(n_row3)  ";X10;K"  '"' n_cpgrp '"' skip.
            PUT STREAM  filebill3 "C;Y" string(n_row3)  ";X11;K"  '"'n_nornetprm '"' skip.
            PUT STREAM  filebill3 "C;Y" string(n_row3)  ";X12;K"  '"'n_cpnetprm '"' skip.
            PUT STREAM  filebill3 "C;Y" string(n_row3)  ";X13;K"  '"'n_whtax1 '"' skip.
            PUT STREAM  filebill3 "C;Y" string(n_row3)  ";X14;K"  '"'n_netamt '"' skip.
                         
         END.  /*m & bal < 0*/   
    END.  /* for each Billing*/
/*--------*/     
    PUT STREAM  filebill3  "E"  skip.               
    OUTPUT STREAM filebill3 CLOSE.
            
/*  vBackUp =  fiFile-Name1 + "B".*/
    
    DOS SILENT  COPY VALUE(fiFile-Name3) VALUE(vBackUP2) /Y  .   /* backup file exports */
               
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdexcel4 C-Win 
PROCEDURE pdexcel4 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:    Type "R" & Bal < 0   
------------------------------------------------------------------------------*/
/*----------------------------- export to excel file  ***---------------------------*/

OUTPUT STREAM filebill4 TO VALUE(fiFile-Name4).
PUT  STREAM  filebill4  "ID;PND"  SKIP.

/* 1. Header */

    put stream filebill4 "C;Y1;X1;K" '"' "Safety Insurance Public Company Limited " '"' skip.
    put stream filebill4 "C;Y1;X2;K" '"' TODAY   '"' skip.
    put stream filebill4 "C;Y1;X3;K" '"' n_asdat    '"' skip.
    put stream filebill4 "C;Y1;X3;K" '"' "Type R  &  Bal < 0 "   '"' skip.
    put stream filebill4 "C;Y2;X1;K" '"' "Customer Name " '"' skip.
    put stream filebill4 "C;Y2;X2;K" '"' "Normal Policy Number " '"' skip.
    put stream filebill4 "C;Y2;X3;K" '"' "Compulsory Policy Number " '"' skip.
    put stream filebill4 "C;Y2;X4;K" '"' "Engine " '"' skip.
    put stream filebill4 "C;Y2;X5;K" '"' "Chassis " '"' skip.
    put stream filebill4 "C;Y2;X6;K" '"' "Contract No. " '"' skip.
    put stream filebill4 "C;Y2;X7;K" '"' "Licence " '"' skip.
    put stream filebill4 "C;Y2;X8;K" '"' "Insured Date " '"' skip.
    put stream filebill4 "C;Y2;X9;K" '"' "Normal Gross Premium " '"' skip.
    put stream filebill4 "C;Y2;X10;K" '"' "Compulsory Gross Premium " '"' skip.
    put stream filebill4 "C;Y2;X11;K" '"' "Normal Net Premium " '"' skip.
    put stream filebill4 "C;Y2;X12;K" '"' "Compulsory Net Premium " '"' skip.
    put stream filebill4 "C;Y2;X13;K" '"' "W/H TAX 1% " '"' skip.
    put stream filebill4 "C;Y2;X14;K" '"' "Net Payment " '"' skip.         

/* 2. detail*/

vExpCount4 = 0.        

loop1:
FOR EACH billing  USE-INDEX billing02 WHERE 
         billing.trndat = nv_exportdat    AND
         billing.asdat = n_asdat          AND
 (LOOKUP(billing.acno1,nv_acnoAll) <> 0 ) AND  /* A46-0426*/
/*A46-0426---                             
        (billing.acno1 = fi_ac1           OR
         billing.acno1 = fi_ac2           OR
         billing.acno1 = fi_ac3           OR
         billing.acno1 = fi_ac4           OR
         billing.acno1 = fi_ac5           OR
         billing.acno1 = fi_ac6           OR
         billing.acno1 = fi_ac7           OR
         billing.acno1 = fi_ac8           OR
         billing.acno1 = fi_ac9           OR
         billing.acno1 = fi_ac10  )       AND
---A46-0426*/                             
        (billing.branch >= fibranch       AND
         billing.branch <= fibranch2)
    NO-LOCK              
    BREAK BY billing.start_date by  billing.nor_policy:   
                            
/*p---------*/         
        ASSIGN
          n_cusnam     = ''  
          n_norpol     = ''  
          n_cppol      = ''  
          n_contract   = ''  
          n_stdate     = ?   
          n_norgrp     = 0   
          n_cpgrp      = 0   
          n_nornetprm  = 0   
          n_cpnetprm   = 0   
          n_whtax1     = 0   
          n_netamt     = 0.  
/*p                 
         FIND FIRST agtprm_fil WHERE agtprm_fil.asdat   = n_asdat           AND
                    agtprm_fil.acno    = billing.acno1   AND
                    agtprm_fil.policy  = billing.policy          AND
                    agtprm_fil.trnty     = 'r' + billing.trnty2  AND
                    agtprm_fil.docno = billing.docno  and 
                    agtprm_fil.bal      < 0
         NO-LOCK NO-ERROR NO-WAIT.
         IF AVAIL agtprm_fil THEN do:
              n_netamt = agtprm_fil.bal.                                      
p*/
        IF billing.trnty1 = "R" and  billing.Bal < 0  then do:


/*p*/       n_netamt = billing.bal.    
/*--------p*/                                             
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
            
            disp billing.policy + ' ' + billing.trnty1 +  ' ' + billing.trnty2 + ' ' +
                 billing.docno FORMAT "X(10)" /* Benjaporn J. A60-0267 date 27/06/2017 */
                 @  fi_process with frame {&frame-name}.
         
/***********************/
      ASSIGN
         n_cusnam      =  billing.cust_name
         n_norpol      =  billing.nor_policy
         n_cppol       =  billing.comp_policy
         n_contract    =  billing.contract
         n_stdate      =  billing.start_date
         n_norgrp      =  billing.nor_grp
         n_cpgrp       =  billing.comp_grp
         n_nornetprm   =  billing.nor_netprm
         n_cpnetprm    =  billing.comp_netprm
         n_whtax1      =  billing.whtax1.

/***********************/        
         vExpCount4 = vExpCount4 + 1.
         n_row4 = n_row4 + 1.
         
      put stream  filebill4 "C;Y" string(n_row4)  ";X1;K"   '"' n_cusnam '"' skip.
      put stream  filebill4 "C;Y" string(n_row4)  ";X2;K"   '"' n_norpol '"' skip.
      put stream  filebill4 "C;Y" string(n_row4)  ";X3;K"   '"' n_cppol '"' skip.
      put stream  filebill4 "C;Y" string(n_row4)  ";X4;K"   '"' engine '"' skip.       
      put stream  filebill4 "C;Y" string(n_row4)  ";X5;K"   '"' chas '"' skip.
      put stream  filebill4 "C;Y" string(n_row4)  ";X6;K"   '"' n_contract '"' skip.
      put stream  filebill4 "C;Y" string(n_row4)  ";X7;K"   '"' engc '"' skip.
      put stream  filebill4 "C;Y" string(n_row4)  ";X8;K"   '"' n_stdate '"' skip.
      put stream  filebill4 "C;Y" string(n_row4)  ";X9;K"   '"' n_norgrp '"' skip.
      put stream  filebill4 "C;Y" string(n_row4)  ";X10;K"  '"' n_cpgrp '"' skip.
      put stream  filebill4 "C;Y" string(n_row4)  ";X11;K"  '"'n_nornetprm '"' skip.
      put stream  filebill4 "C;Y" string(n_row4)  ";X12;K"  '"'n_cpnetprm '"' skip.
      put stream  filebill4 "C;Y" string(n_row4)  ";X13;K"  '"'n_whtax1 '"' skip.
      put stream  filebill4 "C;Y" string(n_row4)  ";X14;K"  '"'n_netamt '"' skip.
    
   end. /*"R" & Bal < 0  */
   
END.  /* for each Billing*/
/*--------*/
        PUT STREAM  filebill4  "E"  skip.      
         
        OUTPUT STREAM filebill4 CLOSE.
            
/*      vBackUp =  fiFile-Name1 + "B".*/
    
        DOS SILENT  COPY VALUE(fiFile-Name4) VALUE(vBackUP4) /Y  .   /* backup file exports */  
              
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdNewVeh C-Win 
PROCEDURE pdNewVeh :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       new vehicle register => red label 
------------------------------------------------------------------------------*/

/*nv_eng = "2-SD332/GG1225".*/

    IF SUBSTR(nv_eng , 1 , 1)  >= "0" AND SUBSTR(nv_eng,1 ,1) <= "9"  AND 
         SUBSTR(nv_eng , 2 , 1)  >= "a" AND SUBSTR(nv_eng,2 ,1) <= "z"  THEN DO:
   
         IF SUBSTR(nv_eng , 3 , 1)  >= "0" AND SUBSTR(nv_eng,3 ,1) <= "9"  THEN
             nv_char = SUBSTR(nv_eng,1,2) + " " + SUBSTR(nv_eng , 3 , LENGTH(nv_eng)). 
   
          IF  SUBSTR(nv_eng , 3 , 1)  = "" THEN nv_char = nv_eng.
   
    END.

    ELSE DO:
          nv_l = 1.

          REPEAT while nv_l <= LENGTH(nv_eng):
               IF SUBSTR(nv_eng,nv_l ,1) >= "0" AND
                   SUBSTR(nv_eng,nv_l ,1) <= "9"  THEN DO:
 
                   IF nv_spc THEN 
                        nv_char = TRIM(nv_char) + " " + SUBSTR(nv_eng,nv_l ,1).
                   ELSE
                        nv_char = TRIM(nv_char) + SUBSTR(nv_eng,nv_l ,1).

                   nv_spc = NO.
              END.
              ELSE DO:
                   IF SUBSTR(nv_eng,nv_l ,1) >= "A" AND
                       SUBSTR(nv_eng,nv_l ,1) <= "Z"   THEN DO:
 
                       IF nv_spc = NO THEN
                           nv_char = TRIM(nv_char) + " " + SUBSTR(nv_eng,nv_l ,1).
                       ELSE
                            nv_char = TRIM(nv_char) + SUBSTR(nv_eng,nv_l ,1).

                       nv_spc = YES.
                   END.
              END.
              nv_l = nv_l + 1.
          END.   /*repeat*/
    END.  /*else do*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdveh C-Win 
PROCEDURE pdveh :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       vehicle register  change '-' to " "  , cut provice code 
------------------------------------------------------------------------------*/
  IF billing.vehreg <> "" THEN DO:
       c = SUBSTR(billing.vehreg, LENGTH(billing.vehreg)  , 1) .
       IF LOOKUP(c, clist) = 0 THEN DO:
           b = LENGTH(billing.vehreg) - 2.  
            n_veh = SUBSTR(billing.vehreg, 1, b).          
            
            bbb = INDEX(n_veh , "-") .    
            IF bbb <> 0 THEN DO:
               ccc = SUBSTR(n_veh  , 1 , bbb - 1) .
               ddd = SUBSTR( n_veh, INDEX(ch , "-") + 1 ,  (LENGTH(n_veh) - INDEX(n_veh , "-"))).
               engc = ccc + ' ' + ddd.
            END.
            ELSE 
              engc = n_veh.   

       END.  /*ตัวท้ายเป็นตัวเลข*/
       ELSE  DO:
           n_veh = billing.vehreg.   
           
            bbb = INDEX(n_veh , "-") .    
            IF bbb <> 0 THEN DO:
               ccc = SUBSTR(n_veh  , 1 , bbb - 1) .
               ddd = SUBSTR( n_veh, INDEX(n_veh , "-") + 1 ,  (LENGTH(n_veh) - INDEX(n_veh , "-"))).
               engc = ccc + ' ' + ddd.
            END.
            ELSE 
              engc = n_veh.   
       END.              

  END.
  ELSE 
       engc = "".

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

