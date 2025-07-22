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
/*          This .W file wAS created with the Progress UIB.             */
/*----------------------------------------------------------------------*/

/* Create an unnamed pool to store all the widgets created 
     by this procedure. This is a good DEFINEault which ASsures
     that this procedure's triggers and INTEErnal procedures 
     will execute in this procedure's storage, and that proper
     cleanup will occur on deletion of the procedure. */

CREATE WIDGET-POOL.
/************   Program   **************
/* CREATE BY :  PatCHARaporn Y.        y:\develop\sic_test\pat   */
Wac
        -WactAS1.w 
Whp
        -WhpBran.w

/* Modify By : Kanchana C.             A46-0090    19/02/2003 
    แก้ procedure  pdo3  
        - กรณี  policy  70  แถม พรบ. 72is  ให้ไปดึงค่าที่ policy  72is  มาแสดงใน rec เดียวกัน
        - เบี้ยเป็น 0 แต่ยังค้างค่า comm. bal <> 0 ไม่แสดง  */

/* Modify By : Kanchana C.          A46-0426   15/10/2003
    - เพิ่มช่องใส่ Producer Code เนื่องจาก มี Code เพิ่มขึ้น
    - set DEFINEault เริ่มต้น code ทั้งหมดของ thai auto sale
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
/* Modify By : Kanchana C.          A47-0235  29/06/2004
1. แก้ไขให้ดึงข้อมูล เกี่ยวกับ  policy   ที่ uwm100.policy +  uwm100.endno + uwm100.docno
แทนรูปแบบเดิม (uwm100.trty11 + uwm100.docno1)  ที่อาจดึงข้อมูลมาผิดได้

*/
/* Modify By : Kanchana C.          A47-0263  15/07/2004
    pdo2  ออกทุก line   ยกเว้น 72
    เพิ่ม  acno = 'A0C0006'
*/

/* Modify By : Kanchana C.          A48-0586  14/12/2005
    ตรวจสอบค่า
1.  Net Payment
2.  ภาษี 1 % สำหรับ insure ที่ชื่อมี  และ/หรือ

*/

/* Modify By : Bunthiya C.          A49-  22/12/2005
1. ให้ทำการดึงข้อมูลจาก Agtprm_fil โดยกรองข้อมูลที่จะส่งแล้วนำลง Text File เลย
*/

------------------------------------------------------------------------- 
 Modify By : TANTAWAN C.   12/11/2007   [A500178]
             ปรับ format branch เพื่อรองรับการขยายสาขา
             ขยาย format fi_ac1 - fi_ac28 จาก "X(7)" เป็น  Char "X(10)"
             ปิดฟิลด์  fi_ac29 - fi_ac30
-------------------------------------------------------------------------

------------------------------------------------------------------------- 
 Modify By : Suthida  T. 12/11/2009  [A520299]
             - เพิ่มให้แสดงข้อมูลงาน 72 อย่างเดียว
             - เพิ่มโค้ด "A0M0083"
-------------------------------------------------------------------------
************************************/
/*Modify by Kridtiya i. A53-0167 04/05/2010 
            ปรับโปรแกรมให้สามารถเรียกรายงานตามวันที่ ทรานเฟอร์ได้และ แปลงเทค
            ไฟล์เป็น เอ็กเซล์ และแปลงเอ็กเซลส์ เป็นเทค และรับ กรมธรรม์กรณียกเลิก(cancel)  */

/* ***************************  DEFINEinitions  ************************** 

------------------------------------------------------------------------- 
 Modify By : Suthida  T. 02-04-2012  [A55-0064]
             -  ปรับโปรแกรม ให้ Insure ดึงรายงานได้ทั้ง Branch 1 หลัก
               และ 2 หลักค่ะ
------------------------------------------------------------------------- */
/*modify BY : kridtiya i. date. 05/03/2015 add producer code : B3M0034 */
/*------------------------------------------------------------------------*/
/*modify BY : Sarinya c. date. 10/08/2016 add ปรับformat เพื่อให้สามารถส่งเข้า
งานตรีเพชรได้ และเปลี่ยนรูปแบบไฟล์เป็น CSV และเพิ่ม code : B3M0031 : A59-0362 */
/*Modify by :Kridtiya i. A59-0362 date. 10/11/2016 เพิ่มคำสั่งคืนค่าฐานข้อมูล  */

/* Parameters DEFINEinitions ---                                           */
DEFINE SHARED VAR n_User    AS CHAR.
DEFINE SHARED VAR n_PASswd  AS CHAR.  

/* Local VARiable DEFINEinitions ---                                       */
DEFINE VAR nv_User   AS CHAR NO-UNDO. 
DEFINE VAR nv_pwd    AS CHAR NO-UNDO.

ASSIGN
    nv_User = n_user
    nv_pwd  = n_pASswd.

DEFINE NEW SHARED VAR n_branch      AS CHAR FORMAT "X(2)".
DEFINE NEW SHARED VAR n_branch2     AS CHAR FORMAT "X(2)".
DEFINE            VAR n_ASdat       AS DATE FORMAT "99/99/9999".

DEFINE VAR n_OutputFile1  AS CHAR.
DEFINE VAR n_OutputFile2  AS CHAR.
DEFINE VAR n_OutputFile3  AS CHAR. /* --- Suthida T. A52-0299 ---*/
DEFINE VAR n_name      AS CHAR  FORMAT "X(50)".  /*acno name*/
DEFINE VAR n_chkname   AS CHAR  FORMAT "X(1)".   /* Acno-- chk button 1-2 */
DEFINE VAR n_bdes      AS CHAR  FORMAT "X(50)".  /*branch name*/
DEFINE VAR n_chkBname  AS CHAR  FORMAT "X(1)".   /* branch-- chk button 1-2 */
DEFINE VAR nv_acno     AS CHAR  FORMAT 'X(10)'.  /*--- A500178 --- ปรับ format จาก  "X(7)" เป็น  "X(10)" */
DEFINE VAR nv_policy   AS CHAR  FORMAT "X(16)".
DEFINE VAR nv_norpol   AS CHAR  FORMAT "X(25)".
DEFINE VAR nv_pol72    AS CHAR  FORMAT "X(16)".
DEFINE VAR nv_cedpol   AS CHAR  FORMAT "x(20)".  /* Sarinya c. A59-0362 */
DEFINE VAR nv_name2    AS CHAR  FORMAT "X(80)".  /* Sarinya c. A59-0362 */
DEFINE VAR nv_vatcode  AS CHAR  FORMAT "X(10)".  /* Sarinya c. A59-0362 */
DEFINE VAR nv_newpol70 AS CHAR  FORMAT "X(10)".  /* Sarinya c. A59-0362 */
DEFINE VAR nv_newpol72 AS CHAR  FORMAT "X(10)".  /* Sarinya c. A59-0362 */


DEFINE VAR nv_endno   AS CHAR FORMAT "X(12)".
DEFINE VAR nv_polbran AS CHAR FORMAT "X(2)".
DEFINE VAR nv_poltyp  AS CHAR FORMAT "X(3)".
DEFINE VAR nv_trnty1  AS CHAR FORMAT "X(1)".
DEFINE VAR nv_trnty2  AS CHAR FORMAT "X(1)".
DEFINE VAR nv_docno   AS CHAR FORMAT /*"X(7)".*/ "X(10)" . /* Benjaporn J. A60-0267 date 27/06/2017 */
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
DEFINE VAR nv_job_nr  AS CHAR FORMAT "X".
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
DEFINE VAR n_wh1c AS DECI FORMAT "->>9.99".    /*A49-0002*/
DEFINE TEMP-TABLE wBill
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
   FIELD wTrndat   AS DATE FORMAT "99/99/9999"  /*export DATE*/
   FIELD wASdat    AS DATE FORMAT "99/99/9999"
   FIELD wTrndat1  AS DATE FORMAT "99/99/9999"  /* trndat to Acc.*/
   FIELD wcontract AS CHAR FORMAT "X(20)"   /* FORMAT "X(10)" */
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
   FIELD wname2         AS CHAR  FORMAT "X(80)"  /* A59-0362 export และ/หรือ */
   FIELD wvatcode       AS CHAR  FORMAT "X(10)"  /* A59-0362 export vatcode  */
   FIELD wbrandmodel     AS CHAR FORMAT "X(60)" 
INDEX wBill01  IS UNIQUE PRIMARY wAcno wPolicy wEndno wTrnty1 wTrnty2 wDocno ASCENDING
/*       INDEX wBill02 wtrndat wASdat wacno */
INDEX wBill03 wComdat wNorpol wPol72.

FOR EACH vehreg72:   DELETE  vehreg72.   END.
/*-- A49-0002 --*/
DEFINE TEMP-TABLE wfAcno
    FIELD wAcno    AS CHAR FORMAT "X(10)" /*--- A500178 --- ปรับ format จาก  "X(7)" เป็น  "X(10)" */
    INDEX wList01 IS UNIQUE PRIMARY  wAcno ASCENDING.
/*-- A49-0002 --*/
/* ------------------------------------------------------------------------ */
DEFINE STREAM filebill1.
DEFINE STREAM filebill2.
DEFINE STREAM filebill3. /* --- Suthida T. A52-0299 ----*/
/*DEFINE STREAM filebill4.*/

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
DEFINE VAR engine   AS CHAR FORMAT 'X(26)'.
DEFINE VAR nv_eng1  AS CHAR FORMAT "X(20)".
DEFINE VAR nv_char1 AS CHAR FORMAT "X(20)".
DEFINE VAR nv_l1    AS INTE.
DEFINE VAR nv_spc1  AS LOG.
/**/
DEFINE VAR chas     AS CHAR FORMAT 'X(26)'.
DEFINE VAR nv_eng2  AS CHAR FORMAT "X(20)".
DEFINE VAR nv_char2 AS CHAR FORMAT "X(20)".
DEFINE VAR nv_l2    AS INTE.
DEFINE VAR nv_spc2  AS LOG.
/**/
/*---------------DEFINE for tAS2.i----------------*/
DEFINE VAR vStamp      AS DECI.
DEFINE VAR vVat        AS DECI.
DEFINE VAR vStamp_comp AS DECI.
DEFINE VAR vVat_comp   AS DECI.
/*-------------------------------------------------*/
DEFINE VAR n_poltype    AS CHAR FORMAT 'X(3)'.
DEFINE VAR n_pol     AS CHAR FORMAT 'X(16)'.
DEFINE VAR n_ren     AS INTE FORMAT ">9".
DEFINE VAR n_end     AS INTE FORMAT "999".
DEFINE VAR n_comdatF AS DATE FORMAT "99/99/9999".
DEFINE VAR n_comdatT AS DATE FORMAT "99/99/9999".
DEFINE VAR nv_bal    AS DECI FORMAT "->>,>>>,>>9.99".
DEFINE VAR n_recid   AS RECID.
DEFINE VAR n_recid2  AS RECID.
DEFINE VAR n_row1    AS INTE FORMAT ">>>>>>9" init 2.
DEFINE STREAM  frstat.
/*------------A46-0426-----*/
/*--- A500178 --- ปรับ fomat ของ nv_ac1 - nv_ac30  จาก  "X(7)" เป็น  "X(10)" ---*/
DEFINE NEW SHARED VAR nv_ac1   AS CHAR FORMAT 'X(10)'.
DEFINE NEW SHARED VAR nv_ac2   AS CHAR FORMAT 'X(10)'.
DEFINE NEW SHARED VAR nv_ac3   AS CHAR FORMAT 'X(10)'.
DEFINE NEW SHARED VAR nv_ac4   AS CHAR FORMAT 'X(10)'.
DEFINE NEW SHARED VAR nv_ac5   AS CHAR FORMAT 'X(10)'.
DEFINE NEW SHARED VAR nv_ac6   AS CHAR FORMAT 'X(10)'.
DEFINE NEW SHARED VAR nv_ac7   AS CHAR FORMAT 'X(10)'.
DEFINE NEW SHARED VAR nv_ac8   AS CHAR FORMAT 'X(10)'.
DEFINE NEW SHARED VAR nv_ac9   AS CHAR FORMAT 'X(10)'.
DEFINE NEW SHARED VAR nv_ac10  AS CHAR FORMAT 'X(10)'.
DEFINE NEW SHARED VAR nv_ac11  AS CHAR FORMAT 'X(10)'.
DEFINE NEW SHARED VAR nv_ac12  AS CHAR FORMAT 'X(10)'.
DEFINE NEW SHARED VAR nv_ac13  AS CHAR FORMAT 'X(10)'.
DEFINE NEW SHARED VAR nv_ac14  AS CHAR FORMAT 'X(10)'.
DEFINE NEW SHARED VAR nv_ac15  AS CHAR FORMAT 'X(10)'.
DEFINE NEW SHARED VAR nv_ac16  AS CHAR FORMAT 'X(10)'.
DEFINE NEW SHARED VAR nv_ac17  AS CHAR FORMAT 'X(10)'.
DEFINE NEW SHARED VAR nv_ac18  AS CHAR FORMAT 'X(10)'.
DEFINE NEW SHARED VAR nv_ac19  AS CHAR FORMAT 'X(10)'.
DEFINE NEW SHARED VAR nv_ac20  AS CHAR FORMAT 'X(10)'.
DEFINE NEW SHARED VAR nv_ac21  AS CHAR FORMAT 'X(10)'.
DEFINE NEW SHARED VAR nv_ac22  AS CHAR FORMAT 'X(10)'.
DEFINE NEW SHARED VAR nv_ac23  AS CHAR FORMAT 'X(10)'.
DEFINE NEW SHARED VAR nv_ac24  AS CHAR FORMAT 'X(10)'.
DEFINE NEW SHARED VAR nv_ac25  AS CHAR FORMAT 'X(10)'.
DEFINE NEW SHARED VAR nv_ac26  AS CHAR FORMAT 'X(10)'.
DEFINE NEW SHARED VAR nv_ac27  AS CHAR FORMAT 'X(10)'.
DEFINE NEW SHARED VAR nv_ac28  AS CHAR FORMAT 'X(10)'.
DEFINE NEW SHARED VAR nv_ac29  AS CHAR FORMAT 'X(10)'.
DEFINE NEW SHARED VAR nv_ac30  AS CHAR FORMAT 'X(10)'.

DEFINE VAR nv_acnoAll AS CHAR.
/*-- A49-0002 --*/
DEFINE VAR nv_acnoTLT AS CHAR.
DEFINE VAR nv_strdate AS CHAR.
DEFINE VAR nv_enddate AS CHAR.
/*-- A49-0002 --*/
/*kridtiya i. A53-0167*/
DEF VAR n_type AS INTE FORMAT "9" .  
/*DEFINE VAR n_trandatfr AS DATE FORMAT "99/99/9999".
DEFINE VAR n_trandatto AS DATE FORMAT "99/99/9999".*/
def var nv_row   as  int  init 0.
def var nv_cnt   as  int  init  0.
def  stream  ns2.
DEFINE VAR nv_daily     AS CHARACTER FORMAT "X(2465)"     INITIAL ""  NO-UNDO.
DEFINE TEMP-TABLE wdetail NO-UNDO
    FIELD head            AS CHAR FORMAT "X"          INIT ""       /*เลขที่ใบคำขอ*/
    FIELD insure          AS CHAR FORMAT "X(60)"      INIT ""       /*วันที่ใบคำขอ*/
    FIELD policy_Main     AS CHAR FORMAT "X(26)"      INIT ""       /*เลขที่รับแจ้ง*/
    FIELD policy          AS CHAR FORMAT "X(26)"      INIT ""       /*เลขที่รับแจ้ง*/
    FIELD polcomp         AS CHAR FORMAT "X(26)"      INIT ""       /*วันที่เริ่มคุ้มครอง*/
    FIELD engine          AS CHAR FORMAT 'x(26)'      INIT ""       /*วันที่สิ้นสุด*/
    FIELD chass           AS CHAR FORMAT 'x(26)'      INIT ""       /*รหัสบริษัทประกันภัย*/  
    FIELD contract        AS CHAR FORMAT "X(20)"      INIT ""  /* FORMAT "X(10)" */     /*ประเภทรถ*/ 
    FIELD engc            AS CHAR FORMAT 'x(12)'      INIT ""       /*ประเภทการขาย*/
    FIELD comdat          AS CHAR FORMAT 'x(8)'       INIT ""  /*ประเภทแคมเปญ*/
    FIELD grossprem       AS DECI FORMAT "->>>>>>>9.99" INIT 0     /*จำนวนเงินให้ฟรี*/
    FIELD CompGrossPrem   AS DECI FORMAT "->>>>>>>9.99" INIT 0    /*ประเภทความคุ้มครอง*/
    FIELD NetPrem         AS DECI FORMAT "->>>>>>>9.99" INIT 0        /*ประเภทประกัน*/
    FIELD CompNetPrem     AS DECI FORMAT "->>>>>>>9.99" INIT 0       /*ประเภทการซ่อม*/
    FIELD tax             AS DECI FORMAT "->>>>>>>9.99" INIT 0       /*ผู้บันทึก*/
    FIELD NetPayment      AS DECI FORMAT "->>>>>>>9.99" INIT 0        /*คำนำหน้า*/
    FIELD wname2          AS CHAR FORMAT "X(80)"  /* A59-0362 export และ/หรือ */
    FIELD wvatcode        AS CHAR FORMAT "X(10)"   /* A59-0362 export vatcode  */
    FIELD wacno           AS CHAR FORMAT "X(10)" 
    FIELD wbrandmodel     AS CHAR FORMAT "X(60)"  .
DEFINE TEMP-TABLE  wagtprm_fil  
    FIELD Policy      AS CHAR  FORMAT "X(16)"
    FIELD trntyp      AS CHAR  FORMAT "x(2)"
    FIELD Docno       AS CHAR  FORMAT /*"X(7)"*/  "X(10)" /* Benjaporn J. A60-0267 date 27/06/2017 */
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
DEF VAR nv_brandmol AS CHAR  FORMAT "X(60)"  .

/*INDEX wBill03 wComdat wNorpol wPol72*/   
/*kridtiya i. A53-0167*/

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
fi_ac2 fi_ac3 fi_ac4 fi_ac5 fi_ac6 fi_ac7 fi_ac8 fi_ac9 fi_ac10 fi_ac11 ~
fi_ac12 fi_ac13 fi_ac14 fi_ac15 fi_ac16 fi_ac17 fi_ac18 fi_ac19 fi_ac20 ~
fi_ac21 fi_ac22 fi_ac23 fi_ac24 fi_ac25 fi_ac26 fi_ac27 fi_ac28 cbAsDat ~
ra_type fi_comdatF fi_comdatT fiFile-Name1 fiFile-Name2 fiFile-Name3 Btn_OK ~
Btn_Exit Btn_convert fibdes fibdes2 fi_process RECT-1 RECT-2 RECT-3 RECT-4 ~
RECT-5 RECT-6 RECT-7 RECT-8 RECT-9 
&Scoped-Define DISPLAYED-OBJECTS fiBranch fiBranch2 fi_ac1 fi_ac2 fi_ac3 ~
fi_ac4 fi_ac5 fi_ac6 fi_ac7 fi_ac8 fi_ac9 fi_ac10 fi_ac11 fi_ac12 fi_ac13 ~
fi_ac14 fi_ac15 fi_ac16 fi_ac17 fi_ac18 fi_ac19 fi_ac20 fi_ac21 fi_ac22 ~
fi_ac23 fi_ac24 fi_ac25 fi_ac26 fi_ac27 fi_ac28 cbAsDat ra_type fi_comdatF ~
fi_comdatT fiFile-Name1 fiFile-Name2 fiFile-Name3 fibdes fibdes2 fi_process 

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
     SIZE 28 BY 1.76
     BGCOLOR 8 FONT 6.

DEFINE BUTTON Btn_Exit AUTO-END-KEY 
     LABEL "Exit" 
     SIZE 13 BY 1.76
     BGCOLOR 8 FONT 6.

DEFINE BUTTON Btn_OK AUTO-GO 
     LABEL "OK" 
     SIZE 13 BY 1.76
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
     SIZE 28 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fiFile-Name2 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 28 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fiFile-Name3 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 28 BY 1
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

DEFINE VARIABLE fi_comdatF AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 15 FONT 1 NO-UNDO.

DEFINE VARIABLE fi_comdatT AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 15 FONT 1 NO-UNDO.

DEFINE VARIABLE fi_process AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 63 BY 1.05
     BGCOLOR 173 FGCOLOR 30 FONT 2 NO-UNDO.

DEFINE VARIABLE ra_type AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "By Comdate", 1,
"By Trandate", 2,
"By Trandate_New", 3
     SIZE 65.5 BY 1.19
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
     SIZE 93.5 BY 3.24
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-5
     EDGE-PIXELS 5 GRAPHIC-EDGE  
     SIZE 126.5 BY 18.29
     BGCOLOR 173 FGCOLOR 0 .

DEFINE RECTANGLE RECT-6
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 16 BY 2.33
     BGCOLOR 76 .

DEFINE RECTANGLE RECT-7
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 16 BY 2.33
     BGCOLOR 154 FGCOLOR 0 .

DEFINE RECTANGLE RECT-8
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 61.5 BY 1.57
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
     fi_ac2 AT ROW 6.76 COL 41.83 COLON-ALIGNED NO-LABEL
     fi_ac3 AT ROW 6.76 COL 54.17 COLON-ALIGNED NO-LABEL
     fi_ac4 AT ROW 6.76 COL 66.5 COLON-ALIGNED NO-LABEL
     fi_ac5 AT ROW 6.76 COL 78.83 COLON-ALIGNED NO-LABEL
     fi_ac6 AT ROW 6.76 COL 91.17 COLON-ALIGNED NO-LABEL
     fi_ac7 AT ROW 6.76 COL 103.5 COLON-ALIGNED NO-LABEL
     fi_ac8 AT ROW 7.86 COL 29.5 COLON-ALIGNED NO-LABEL
     fi_ac9 AT ROW 7.86 COL 41.83 COLON-ALIGNED NO-LABEL
     fi_ac10 AT ROW 7.86 COL 54.17 COLON-ALIGNED NO-LABEL
     fi_ac11 AT ROW 7.86 COL 66.5 COLON-ALIGNED NO-LABEL
     fi_ac12 AT ROW 7.86 COL 78.83 COLON-ALIGNED NO-LABEL
     fi_ac13 AT ROW 7.86 COL 91.17 COLON-ALIGNED NO-LABEL
     fi_ac14 AT ROW 7.86 COL 103.5 COLON-ALIGNED NO-LABEL
     fi_ac15 AT ROW 8.95 COL 29.5 COLON-ALIGNED NO-LABEL
     fi_ac16 AT ROW 8.95 COL 41.83 COLON-ALIGNED NO-LABEL
     fi_ac17 AT ROW 8.95 COL 54.17 COLON-ALIGNED NO-LABEL
     fi_ac18 AT ROW 8.95 COL 66.5 COLON-ALIGNED NO-LABEL
     fi_ac19 AT ROW 8.95 COL 78.83 COLON-ALIGNED NO-LABEL
     fi_ac20 AT ROW 8.95 COL 91.17 COLON-ALIGNED NO-LABEL
     fi_ac21 AT ROW 8.95 COL 103.5 COLON-ALIGNED NO-LABEL
     fi_ac22 AT ROW 10.05 COL 29.5 COLON-ALIGNED NO-LABEL
     fi_ac23 AT ROW 10.05 COL 41.83 COLON-ALIGNED NO-LABEL
     fi_ac24 AT ROW 10.05 COL 54.17 COLON-ALIGNED NO-LABEL
     fi_ac25 AT ROW 10.05 COL 66.5 COLON-ALIGNED NO-LABEL
     fi_ac26 AT ROW 10.05 COL 78.83 COLON-ALIGNED NO-LABEL
     fi_ac27 AT ROW 10.05 COL 91.17 COLON-ALIGNED NO-LABEL
     fi_ac28 AT ROW 10.1 COL 103.5 COLON-ALIGNED NO-LABEL
     cbAsDat AT ROW 11.48 COL 29.5 COLON-ALIGNED NO-LABEL
     ra_type AT ROW 11.48 COL 49.5 NO-LABEL
     fi_comdatF AT ROW 13.33 COL 53.83 COLON-ALIGNED NO-LABEL
     fi_comdatT AT ROW 13.33 COL 83.83 COLON-ALIGNED NO-LABEL
     fiFile-Name1 AT ROW 18.1 COL 29.83 COLON-ALIGNED NO-LABEL
     fiFile-Name2 AT ROW 18.1 COL 60.17 COLON-ALIGNED NO-LABEL
     fiFile-Name3 AT ROW 18.1 COL 90 COLON-ALIGNED NO-LABEL
     Btn_OK AT ROW 22.19 COL 67
     Btn_Exit AT ROW 22.14 COL 116.17
     Btn_convert AT ROW 22.14 COL 84
     fibdes AT ROW 4.14 COL 38 COLON-ALIGNED NO-LABEL
     fibdes2 AT ROW 5.33 COL 38 COLON-ALIGNED NO-LABEL
     fi_process AT ROW 19.76 COL 30.67 COLON-ALIGNED NO-LABEL
     "   พรบ." VIEW-AS TEXT
          SIZE 8 BY 1.14 AT ROW 16.71 COL 93
          BGCOLOR 34 FGCOLOR 1 
     "Branch To":10 VIEW-AS TEXT
          SIZE 19.5 BY 1 TOOLTIP "ถึงสาขา" AT ROW 5.43 COL 8
          BGCOLOR 19 FGCOLOR 0 
     "Branch From":25 VIEW-AS TEXT
          SIZE 19.5 BY 1 TOOLTIP "ตั้งแต่สาขา" AT ROW 4.24 COL 8
          BGCOLOR 19 FGCOLOR 0 
     "Producer Code" VIEW-AS TEXT
          SIZE 19.5 BY 1 AT ROW 7 COL 8
          BGCOLOR 19 FGCOLOR 0 
     "Date To" VIEW-AS TEXT
          SIZE 12.33 BY 1 AT ROW 13.33 COL 71.5
          BGCOLOR 19 FGCOLOR 0 
     "Output To TextFile" VIEW-AS TEXT
          SIZE 19 BY 1 AT ROW 16.76 COL 8.5
          BGCOLOR 19 FGCOLOR 0 
     "          เบี้ยใหญ่ +  พรบ." VIEW-AS TEXT
          SIZE 23.5 BY 1 AT ROW 16.76 COL 31.83
          BGCOLOR 34 FGCOLOR 1 
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133.33 BY 23.71
         BGCOLOR 3 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME DEFAULT-FRAME
     "Date From" VIEW-AS TEXT
          SIZE 20 BY 1 AT ROW 13.33 COL 32.33
          BGCOLOR 19 FGCOLOR 0 
     " การส่งข้อมูล Text File เพื่อวางบิลเรียกเก็บเงินค่าเบี้ยฯ จาก Thai Auto Sales" VIEW-AS TEXT
          SIZE 59 BY 1 AT ROW 1.52 COL 38.17
          BGCOLOR 1 FGCOLOR 7 
     "เบี้ยใหญ่ (กรณีจ่าย พรบ.แล้ว)" VIEW-AS TEXT
          SIZE 23.5 BY 1.14 AT ROW 16.76 COL 62.33
          BGCOLOR 34 FGCOLOR 1 
     " As of Date (Statement)":30 VIEW-AS TEXT
          SIZE 19.5 BY .95 TOOLTIP "วันที่ออกรายงาน" AT ROW 11.57 COL 8
          BGCOLOR 19 FGCOLOR 0 
     RECT-1 AT ROW 3.86 COL 6.5
     RECT-2 AT ROW 3.86 COL 29.5
     RECT-3 AT ROW 16.24 COL 6.5
     RECT-4 AT ROW 16.24 COL 29.5
     RECT-5 AT ROW 3.19 COL 4.5
     RECT-6 AT ROW 21.86 COL 65.5
     RECT-7 AT ROW 21.86 COL 114.5
     RECT-8 AT ROW 1.24 COL 37
     RECT-9 AT ROW 21.86 COL 82
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133.33 BY 23.71
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
         TITLE              = "wactas1 - การส่งข้อมูล Text File เพื่อวางบิล Thai Auto Sales"
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
ON END-ERROR OF C-Win /* wactas1 - การส่งข้อมูล Text File เพื่อวางบิล Thai Auto Sales */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* wactas1 - การส่งข้อมูล Text File เพื่อวางบิล Thai Auto Sales */
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
    RUN wac\wactas5.
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
        fiFile-Name1 fiFile-Name1
        n_branch       =  fiBranch
        n_branch2      =  fiBranch2
        n_asdat        =  DATE(INPUT cbAsDat)
        n_OutputFile1  =  fiFile-Name1
        n_OutputFile2  =  fiFile-Name2
        n_OutputFile3  =  fiFile-Name3 /* --- Suthida T. A52-0299 ----*/
        n_comdatF      =  fi_comdatF
        n_comdatT      =  fi_comdatT
   
        nv_acnoAll = ""
        nv_acnoAll = IF fi_ac1  <> "" THEN INPUT fi_ac1 ELSE ""
        nv_acnoAll = IF fi_ac2  <> "" THEN nv_acnoAll + "," + INPUT fi_ac2 ELSE nv_acnoAll
        nv_acnoAll = IF fi_ac3  <> "" THEN nv_acnoAll + "," + INPUT fi_ac3 ELSE nv_acnoAll
        nv_acnoAll = IF fi_ac4  <> "" THEN nv_acnoAll + "," + INPUT fi_ac4 ELSE nv_acnoAll
        nv_acnoAll = IF fi_ac5  <> "" THEN nv_acnoAll + "," + INPUT fi_ac5 ELSE nv_acnoAll
        nv_acnoAll = IF fi_ac6  <> "" THEN nv_acnoAll + "," + INPUT fi_ac6 ELSE nv_acnoAll
        nv_acnoAll = IF fi_ac7  <> "" THEN nv_acnoAll + "," + INPUT fi_ac7 ELSE nv_acnoAll
        nv_acnoAll = IF fi_ac8  <> "" THEN nv_acnoAll + "," + INPUT fi_ac8 ELSE nv_acnoAll
        nv_acnoAll = IF fi_ac9  <> "" THEN nv_acnoAll + "," + INPUT fi_ac9 ELSE nv_acnoAll
        nv_acnoAll = IF fi_ac10 <> "" THEN nv_acnoAll + "," + INPUT fi_ac10 ELSE nv_acnoAll
        nv_acnoAll = IF fi_ac11 <> "" THEN nv_acnoAll + "," + INPUT fi_ac11 ELSE nv_acnoAll
        nv_acnoAll = IF fi_ac12 <> "" THEN nv_acnoAll + "," + INPUT fi_ac12 ELSE nv_acnoAll
        nv_acnoAll = IF fi_ac13 <> "" THEN nv_acnoAll + "," + INPUT fi_ac13 ELSE nv_acnoAll
        nv_acnoAll = IF fi_ac14 <> "" THEN nv_acnoAll + "," + INPUT fi_ac14 ELSE nv_acnoAll
        nv_acnoAll = IF fi_ac15 <> "" THEN nv_acnoAll + "," + INPUT fi_ac15 ELSE nv_acnoAll
        nv_acnoAll = IF fi_ac16 <> "" THEN nv_acnoAll + "," + INPUT fi_ac16 ELSE nv_acnoAll
        nv_acnoAll = IF fi_ac17 <> "" THEN nv_acnoAll + "," + INPUT fi_ac17 ELSE nv_acnoAll
        nv_acnoAll = IF fi_ac18 <> "" THEN nv_acnoAll + "," + INPUT fi_ac18 ELSE nv_acnoAll
        nv_acnoAll = IF fi_ac19 <> "" THEN nv_acnoAll + "," + INPUT fi_ac19 ELSE nv_acnoAll
        nv_acnoAll = IF fi_ac20 <> "" THEN nv_acnoAll + "," + INPUT fi_ac20 ELSE nv_acnoAll
        nv_acnoAll = IF fi_ac21 <> "" THEN nv_acnoAll + "," + INPUT fi_ac21 ELSE nv_acnoAll
        nv_acnoAll = IF fi_ac22 <> "" THEN nv_acnoAll + "," + INPUT fi_ac22 ELSE nv_acnoAll
        nv_acnoAll = IF fi_ac23 <> "" THEN nv_acnoAll + "," + INPUT fi_ac23 ELSE nv_acnoAll
        nv_acnoAll = IF fi_ac24 <> "" THEN nv_acnoAll + "," + INPUT fi_ac24 ELSE nv_acnoAll
        nv_acnoAll = IF fi_ac25 <> "" THEN nv_acnoAll + "," + INPUT fi_ac25 ELSE nv_acnoAll
        nv_acnoAll = IF fi_ac26 <> "" THEN nv_acnoAll + "," + INPUT fi_ac26 ELSE nv_acnoAll
        nv_acnoAll = IF fi_ac27 <> "" THEN nv_acnoAll + "," + INPUT fi_ac27 ELSE nv_acnoAll
        nv_acnoAll = IF fi_ac28 <> "" THEN nv_acnoAll + "," + INPUT fi_ac28 ELSE nv_acnoAll
        /*--- A500178 ---
        nv_acnoAll = IF fi_ac29 <> "" THEN nv_acnoAll + "," + fi_ac29 ELSE nv_acnoAll
        nv_acnoAll = IF fi_ac30 <> "" THEN nv_acnoAll + "," + fi_ac30 ELSE nv_acnoAll
        ------*/
        .

   IF (n_branch > n_branch2)   THEN DO:
       MESSAGE "ข้อมูลรหัสสาขาผิดพลาด" SKIP
               "รหัสสาขาเริ่มต้นต้องน้อยกว่ารหัสสุดท้าย" VIEW-AS ALERT-BOX WARNING . 
       APPLY "Entry" To fibranch.
       RETURN NO-APPLY.
   END.

   IF (n_comdatF > n_comdatT)   THEN DO:
       MESSAGE "ข้อมูลวันที่คุ้มครองผิดพลาด" SKIP
               "วันที่คุ้มครองเริ่มต้นต้องน้อยกว่าวันที่คุ้มครองสุดท้าย" VIEW-AS ALERT-BOX WARNING.
       APPLY "Entry" TO fi_comdatF.
       RETURN NO-APPLY.
   END.

   IF n_OutputFile1 = "" AND n_OutputFile2 = "" AND n_OutputFile3 = ""  THEN DO:
       MESSAGE "กรุณาใส่ชื่อไฟล์" VIEW-AS ALERT-BOX WARNING.
       APPLY "Entry" TO fiFile-Name1.
       RETURN NO-APPLY.
   END.
   
   /*---- A49-0002 ----*/
   nv_strdate = STRING(TODAY,"99/99/9999") + STRING(TIME, "HH:MM AM").
   /*---comment by Sarinya c. A59-0362---
   DO WHILE nv_acnoAll <> "":
       nv_acnoTLT = SUBSTR(nv_acnoAll,1,7).
       IF INDEX(nv_acnoAll,",") <> 0 THEN
            nv_acnoAll = SUBSTR(nv_acnoAll,INDEX(nv_acnoAll,",") + 1,LENGTH(nv_acnoAll) - INDEX(nv_acnoAll,",")).
       ELSE nv_acnoAll = "".

       FIND FIRST wfAcno USE-INDEX wList01 WHERE
                  wfAcno.wacno = nv_acnoTLT NO-ERROR.
       IF NOT AVAIL wfAcno THEN DO:
           CREATE wfAcno.
           wfAcno.wacno = nv_acnoTLT.
       END.
   END.
   /*---- A49-0002 ----*/
   ----- end by Sarinya c. A59-0362----------*/

   /****************** OUTPUT TEXT ********************/
   /*---- A49-0002 ----
   FIND FIRST  billing  USE-INDEX billing02      WHERE
               billing.trndat     <> ?             AND     /* = nv_exportdat   */
               billing.asdat       = n_asdat       AND     /* = n_asdat   */
       (LOOKUP(billing.acno1,nv_acnoAll) <> 0 )    AND /* A46-0426*/
              (billing.branch     >= fiBranch      AND
               billing.branch     <= fiBranch2)    AND
              (billing.start_date >= n_comdatF     AND
               billing.start_date <= n_comdatT)    NO-LOCK NO-ERROR NO-WAIT.
   IF AVAIL billing THEN DO:

       MESSAGE "ข้อมูล         : " STRING(n_asdat,"99/99/9999") SKIP(1)
               "ส่งออกไปแล้ว ณ วันที่ : " STRING(billing.trndat,"99/99/9999")  SKIP(1)
               "คุณต้องการที่จะ process ใหม่หรือไม่ ถ้า => Yes คือ จะ ลบข้อมูลเก่าแล้ว จึง process ใหม่" SKIP
               "                                => No  คือ ไม่ทำการ process ใดๆ"
       VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO TITLE "Confirm"
       UPDATE CHOICE AS LOGICAL.
       CASE CHOICE:
           WHEN FALSE THEN DO:
                RETURN NO-APPLY.
           END.
           WHEN TRUE THEN DO:
               DISPLAY "Delete old data ..." @ fi_Process WITH FRAME {&FRAME-NAME}.

               FOR EACH billing  USE-INDEX billing02 WHERE
                        billing.trndat      <>  ?          AND  /* = nv_exportdat */
                        billing.asdat        =  n_asdat    AND  /* = n_asdat */
                (LOOKUP(billing.acno1,nv_acnoAll) <> 0 )   AND  /* A46-0426 */
                       (billing.branch      >=  fiBranch   AND
                        billing.branch      <=  fiBranch2) AND
                       (billing.start_date  >=  n_comdatF  AND
                        billing.start_date  <=  n_comdatT)
                   :
                     DELETE billing.
               END.   /*billing*/

               RUN pdproc.   /* process */

               IF INPUT fiFile-Name1 <> "" THEN DO:
                   IF n_comdatT < 12/01/01 THEN    /* billing.start_date < 12/01/01 */
                        RUN pdo1.
                   ELSE RUN pdo3.   /* 70 + 72 */
               END.

               IF INPUT fiFile-Name2 <> "" THEN
                   RUN pdo2.   /* 70 */

/*kan---
                     ELSE RUN pdo3.
                  END.     

                  IF INPUT fiFile-Name2 <> "" THEN DO:
                      IF (billing.start_date >= 12/01/01) AND (billing.start_date <= 07/31/02) THEN
                          RUN pdo2.
                      ELSE IF billing.start_date >= 08/01/02 THEN RUN pdo3.
                  END.
---kan*/

               MESSAGE  "ทำการ Dump ข้อมูล ลง Text File : "  fiFile-Name1  SKIP(1)
                        "การส่งออก จำนวน : " vExpCount1  " รายการ" VIEW-AS ALERT-BOX INFORMATION.

               MESSAGE  "ทำการ Dump ข้อมูล ลง Text File : "  fiFile-Name2  SKIP(1)
                        "การส่งออก จำนวน : " vExpCount2  " รายการ" VIEW-AS ALERT-BOX INFORMATION.

           END.  /*true*/
       END CASE.
   END.  /*avail billing*/
   ELSE DO:
   -- End A49-0002 --*/
        /*comment by Kridtiya i. A53-0167 .....
        RUN pdproc.
        IF INPUT fiFile-Name1 <> "" THEN DO:
            IF n_comdatT < 12/01/01 THEN  /* billing.start_date <    12/01/01 */
                 RUN pdo1.
            ELSE RUN pdo3.
        END.
                     
        IF INPUT fiFile-Name2 <> "" THEN
            RUN pdo2.
        /* -- Suthida T. A52-0299  "V72"----*/
        IF INPUT fiFile-Name3 <> "" THEN DO:
              RUN pdo4.
        END.
        /* -- Suthida T. A52-0299  "V72"----*/
        end .....Kridtiya i. A53-0167..........................*/
        /*Add    Kridtiya i. A53-0167  ........................*/
        IF n_type = 1 THEN DO: 
            RUN pdproc.        /*by as fo date */
            IF INPUT fiFile-Name1 <> "" THEN DO:
                IF n_comdatT < 12/01/01 THEN  
                    RUN pdo1.
                ELSE RUN pdo3.
            END.
            IF INPUT fiFile-Name2 <> "" THEN
                RUN pdo2.
            IF INPUT fiFile-Name3 <> "" THEN DO:
                RUN pdo4.
            END.
        END.
        ELSE IF n_type = 2 THEN DO: 
            RUN pdproc2.                /* By trandate  */
            IF INPUT fiFile-Name1 <> "" THEN DO:
                IF n_comdatT < 12/01/01 THEN  
                    RUN pdo1.
                ELSE RUN pdo3_2.
            END.
            IF INPUT fiFile-Name2 <> "" THEN
                RUN pdo2_2.
            IF INPUT fiFile-Name3 <> "" THEN DO:
                RUN pdo4_2.
                RUN pdo5_2.
            END.
        END.
        ELSE DO: /*case 3 by test kridtiya i. 22/08/2016 */
            RUN pdproc3.
            RUN pdo3_expNew.

        END.
        /*Kridtiya i. A53-0167  */

        nv_enddate = STRING(TODAY,"99/99/9999") + STRING(TIME, "HH:MM AM").

        /*--- A500178 ---  รวมเป็น message เดียวกัน ---
        MESSAGE  "ทำการ Dump ข้อมูล ลง Text File : "  fiFile-Name1  SKIP(1)
                 "การส่งออก จำนวน : " vExpCount1  " รายการ" VIEW-AS ALERT-BOX INFORMATION.

        MESSAGE  "ทำการ Dump ข้อมูล ลง Text File : "  fiFile-Name2  SKIP(1)
                 "การส่งออก จำนวน : " vExpCount2  " รายการ" VIEW-AS ALERT-BOX INFORMATION.

        MESSAGE "Start Date : " nv_strdate "น." SKIP(1)
                "  End Date : " nv_enddate "น." VIEW-AS ALERT-BOX INFORMATION.
        ------ END A500178 ------*/

        MESSAGE  "ทำการ Dump ข้อมูล ลง Text File : "  fiFile-Name1  SKIP
                 "การส่งออก จำนวน : " vExpCount1  " รายการ"         SKIP(1)

                 "ทำการ Dump ข้อมูล ลง Text File : "  fiFile-Name2  SKIP
                 "การส่งออก จำนวน : " vExpCount2  " รายการ"         SKIP(1)
                 /* ---- Suthida T. A52-0299 ----*/ 
                 "ทำการ Dump ข้อมูล ลง Text File : "  fiFile-Name3  SKIP
                 "การส่งออก จำนวน : " vExpCount3  " รายการ"         SKIP(1)
                /* ---- Suthida T. A52-0299 ----*/ 
                 "Start Date : " nv_strdate "น." SKIP
                 "  End Date : " nv_enddate "น." VIEW-AS ALERT-BOX INFORMATION.

        APPLY "ENTRY" TO Btn_Exit.

    /*---- A49-0002 ----
    END. /*else*/
    -- End A49-0002 --*/
END. /*DO*/

/******************************************************* 
/*46-0426  เงื่อไขเดิม ทุกครั้งที่ทำการ find*/
   FIND FIRST  billing  USE-INDEX billing02          WHERE
                    billing.trndat      = nv_exportdat   AND
                    billing.asdat       = n_asdat        AND
                   (billing.acno1       = fi_ac1         OR 
                    billing.acno1       = fi_ac2         OR 
                    billing.acno1       = fi_ac3         OR 
                    billing.acno1       = fi_ac4         OR 
                    billing.acno1       = fi_ac5         OR 
                    billing.acno1       = fi_ac6         OR 
                    billing.acno1       = fi_ac7         OR 
                    billing.acno1       = fi_ac8         OR 
                    billing.acno1       = fi_ac9         OR 
                    billing.acno1       = fi_ac10  )     AND
                   (billing.branch     >= fiBranch       AND
                    billing.branch     <= fiBranch2)     AND
                   (billing.start_date >= n_comdatF      AND
                    billing.start_date <= n_comdatT)     NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL billing THEN DO:

*******************************************************/

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
       APPLY "ENTRY" TO fi_comdatF IN FRAME {&FRAME-NAME}.
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

    /*-- A49-0002 --
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
  -- end A49-0002 --*/

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

/*     Apply "Entry" To fiAcno1.           */
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
  
    /*--- A49-0002 ---
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
  --- end A49-0002 ---*/

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiFile-Name1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiFile-Name1 C-Win
ON LEAVE OF fiFile-Name1 IN FRAME DEFAULT-FRAME
DO:
    fiFile-Name1 = INPUT fiFile-Name1.
  
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
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiFile-Name2 C-Win
ON RETURN OF fiFile-Name2 IN FRAME DEFAULT-FRAME
DO:
          APPLY "ENTRY" TO fiFile-Name3 IN FRAME {&FRAME-NAME}.
          RETURN NO-APPLY.         
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiFile-Name3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiFile-Name3 C-Win
ON LEAVE OF fiFile-Name3 IN FRAME DEFAULT-FRAME
DO:
    fiFile-Name3 = INPUT fiFile-Name3.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiFile-Name3 C-Win
ON RETURN OF fiFile-Name3 IN FRAME DEFAULT-FRAME
DO:
          APPLY "ENTRY" TO Btn_OK IN FRAME {&FRAME-NAME}.
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


&Scoped-define SELF-NAME fi_comdatF
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_comdatF C-Win
ON LEAVE OF fi_comdatF IN FRAME DEFAULT-FRAME
DO:
        fi_comdatF = input fi_comdatF.
        n_comdatF = fi_comdatF.
          
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_comdatT
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_comdatT C-Win
ON LEAVE OF fi_comdatT IN FRAME DEFAULT-FRAME
DO:
      fi_comdatT = input fi_comdatT.
      n_comdatT = fi_comdatT.
      APPLY "ENTRY" TO fiFile-Name1 IN FRAME {&FRAME-NAME}.
      RETURN NO-APPLY.
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
        APPLY "ENTRY" TO fi_comdatF IN FRAME {&FRAME-NAME}.
        RETURN NO-APPLY.
    END.
    ELSE IF n_type = 2 THEN DO:
        APPLY "ENTRY" TO fi_comdatF IN FRAME {&FRAME-NAME}.
        RETURN NO-APPLY.
    END.
    ELSE DO:
        APPLY "ENTRY" TO fi_comdatF IN FRAME {&FRAME-NAME}.
        RETURN NO-APPLY.
    END.
    DISP ra_type WITH FRAME {&FRAME-NAME}.

       /* APPLY "ENTRY" TO fi_ac1 IN FRAME {&FRAME-NAME}.
        RETURN NO-APPLY.*/

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
  
  gv_prgid = "wactas1".
  gv_prog  = "การส่งข้อมูล Text File เพื่อวางบิล Thai Auto Sales".
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
      n_comdatF     = ?
      n_comdatT     = ?
      n_OutputFile1 = ""
      n_OutputFile2 = ""
      n_OutputFile3 = ""  /* --- Suthida T. A52-0299 ---*/
      nv_exportdat  = TODAY
      fi_comdatF    = TODAY      /*kridtiya i. A53-0167 */ 
      fi_comdatT    = TODAY      /*kridtiya i. A53-0167 */ 
      ra_type      = 1           /*kridtiya i. A53-0167 */ 
      fiFile-Name1 = "d:\tas7072"   /*kridtiya i. A53-0167 */ 
      fiFile-Name2 = "d:\tas70"     /*kridtiya i. A53-0167 */ 
      fiFile-Name3 = "d:\tas72t"    /*kridtiya i. A53-0167 */ 
      n_asdat    =  DATE(cbAsdat). 

   fibdes  = fuFindBranch(fibranch).
   fibdes2 = fuFindBranch(fibranch2).

   DISP fibranch fibranch2 fibdes fibdes2 fi_process fi_comdatF fi_comdatT
        fiFile-Name1  fiFile-Name2  fiFile-Name3     
       WITH FRAME {&FRAME-NAME}.

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
      fi_ac14  = 'A0C0006'  /* nv_ac14   A47-0263  */
      fi_ac15  = 'A0M0083'  /* nv_ac15   A52-0299  */
      fi_ac16  = 'A040374'  /* nv_ac16   A52-0299  */
      fi_ac17  = 'A060112'  /* nv_ac17   A52-0299  */
      fi_ac18  = 'A040424'  /*kridtiya i. A53-0167 */
      fi_ac19  = 'A010113'  /*kridtiya i. A53-0167 */
      fi_ac20  = 'B3M0018'  /*kridtiya i. A53-0167 */
      /*fi_ac21  = nv_ac21*/
      fi_ac21  = "B3M0034"  /*A58-0094 */
      /*fi_ac22  = nv_ac22*/
      fi_ac22  = "B3M0031" /*Sarinya C. A59-0362*/
      fi_ac23  = nv_ac23
      fi_ac24  = nv_ac24
      fi_ac25  = nv_ac25
      fi_ac26  = nv_ac26
      fi_ac27  = nv_ac27
      fi_ac28  = nv_ac28
      /*--- A500178 ---
      fi_ac29  = nv_ac29
      fi_ac30  = nv_ac30
      ------*/ 
      
       .

   DISP fi_ac1   fi_ac2   fi_ac3   fi_ac4   fi_ac5
        fi_ac6   fi_ac7   fi_ac8   fi_ac9   fi_ac10
        fi_ac11  fi_ac12  fi_ac13  fi_ac14  fi_ac15
        fi_ac16  fi_ac17  fi_ac18  fi_ac19  fi_ac20
        fi_ac21  fi_ac22  fi_ac23  fi_ac24  fi_ac25
        fi_ac26  fi_ac27  fi_ac28       /*--- A500178 fi_ac29  fi_ac30 -----*/
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
          fi_ac25 fi_ac26 fi_ac27 fi_ac28 cbAsDat ra_type fi_comdatF fi_comdatT 
          fiFile-Name1 fiFile-Name2 fiFile-Name3 fibdes fibdes2 fi_process 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE fiBranch buBranch fiBranch2 buBranch2 fi_ac1 fi_ac2 fi_ac3 fi_ac4 
         fi_ac5 fi_ac6 fi_ac7 fi_ac8 fi_ac9 fi_ac10 fi_ac11 fi_ac12 fi_ac13 
         fi_ac14 fi_ac15 fi_ac16 fi_ac17 fi_ac18 fi_ac19 fi_ac20 fi_ac21 
         fi_ac22 fi_ac23 fi_ac24 fi_ac25 fi_ac26 fi_ac27 fi_ac28 cbAsDat 
         ra_type fi_comdatF fi_comdatT fiFile-Name1 fiFile-Name2 fiFile-Name3 
         Btn_OK Btn_Exit Btn_convert fibdes fibdes2 fi_process RECT-1 RECT-2 
         RECT-3 RECT-4 RECT-5 RECT-6 RECT-7 RECT-8 RECT-9 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd7070-Lek C-Win 
PROCEDURE pd7070-Lek :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       use condition comdat >= 01/08/02  and policy 70 comp_policy 70
------------------------------------------------------------------------------*/

/*------ lek -----

/*----------------------------- export to file *** since 01/12/01 file comp ***---------------------------*/
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
                                            billing.acno1 = fi_ac10  )       AND 

                                         ((billing.comp_policy <> "")      OR
                                          (billing.comp_policy  = ''         AND
                                           billing.poltyp             = 'v72')) AND               
                                          (billing.start_date     >= n_comdatF and
                                           billing.start_date     <= n_comdatT)             
                                           
                             BREAK BY billing.start_date by  billing.nor_policy:   
                             
        if substr(billing.policy, 7,2) = 'is'  then  next loop1.   /*free compulsory dm7245isxxxx*/
     if substr(billing.policy, 3,2) = '70' and substr(billing.comp_policy, 3,2) = '70'  then do:
        
         n_netloc = 0.      y1 = 0.         z1 = 0.     sum = 0.
         p_trnty    = ''.      p_policy = ''.

         FOR EACH acd001 USE-INDEX acd00191 WHERE 
                             acd001.trnty1  = billing.trnty1      AND
                             acd001.docno = billing.docno  NO-LOCK.
                             
                  n_netloc =  n_netloc + acd001.netloc.
                  IF acd001.ctrty1 = 'y' THEN   y1 = -(acd001.netloc).
                  IF acd001.ctrty1 = 'z' THEN   z1 = -(acd001.netloc).
                  sum         = y1 + z1.                         
                  p_trnty    = billing.trnty1 + billing.trnty2.          
/*                  p_policy = substr(billing.policy,1,12).*/
         END.      /*acd001*/          

             
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
         
         FIND FIRST agtprm_fil WHERE agtprm_fil.asdat   = n_asdat           AND
                                                                agtprm_fil.acno    = billing.acno1   AND
                                                                agtprm_fil.policy  = billing.policy          AND
                                                                agtprm_fil.trnty     = billing.trnty1 + billing.trnty2  AND
                                                                agtprm_fil.docno = billing.docno
                    NO-LOCK NO-ERROR NO-WAIT.
         IF AVAIL agtprm_fil THEN DO:                    
             if  substr(trntyp , 1 , 1) = 'r' and agtprm_fil.bal <> 0 then next loop1.
             if  substr(trntyp , 1 , 1) = 'm' and agtprm_fil.bal < 0 then next loop1.         
         end.        
        
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
        end. /*7070*/
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

---- end lek ----*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd7072-Lek C-Win 
PROCEDURE pd7072-Lek :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:   use condition comdat >= 01/08/02  and policy 70 comp_policy 72    
------------------------------------------------------------------------------*/

/*------ lek -----

/*----------------------------- export to file *** since 01/12/01 file comp ***---------------------------*/
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
                                            billing.acno1 = fi_ac10  )       AND 

                                         ((billing.comp_policy <> "")      OR
                                          (billing.comp_policy  = ''         AND
                                           billing.poltyp             = 'v72')) AND               
                                          (billing.start_date     >= n_comdatF and
                                           billing.start_date     <= n_comdatT)             
                                           
                             BREAK BY billing.start_date by  billing.nor_policy:   
                             
        if substr(billing.policy, 7,2) = 'is'  then  next loop1.   /*free compulsory dm7245isxxxx*/
     if substr(billing.policy, 3,2) = '70' and substr(billing.comp_policy, 3,2) = '72'  then do:
        
         n_netloc = 0.      y1 = 0.         z1 = 0.     sum = 0.
         p_trnty    = ''.      p_policy = ''.

         FOR EACH acd001 USE-INDEX acd00191 WHERE 
                             acd001.trnty1  = billing.trnty1      AND
                             acd001.docno = billing.docno  NO-LOCK.
                             
                  n_netloc =  n_netloc + acd001.netloc.
                  IF acd001.ctrty1 = 'y' THEN   y1 = -(acd001.netloc).
                  IF acd001.ctrty1 = 'z' THEN   z1 = -(acd001.netloc).
                  sum         = y1 + z1.                         
                  p_trnty    = billing.trnty1 + billing.trnty2.          
/*                  p_policy = substr(billing.policy,1,12).*/
         END.      /*acd001*/          

             
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
         
         FIND FIRST agtprm_fil WHERE agtprm_fil.asdat   = n_asdat           AND
                                                                agtprm_fil.acno    = billing.acno1   AND
                                                                agtprm_fil.policy  = billing.policy          AND
                                                                agtprm_fil.trnty     = billing.trnty1 + billing.trnty2  AND
                                                                agtprm_fil.docno = billing.docno
                    NO-LOCK NO-ERROR NO-WAIT.
         IF AVAIL agtprm_fil THEN DO:                    
             if  substr(trntyp , 1 , 1) = 'r' and agtprm_fil.bal <> 0 then next loop1.
             if  substr(trntyp , 1 , 1) = 'm' and agtprm_fil.bal < 0 then next loop1.         
         end.        
        
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
                  
        PUT STREAM  filebill1
       
            "D"          FORMAT "X"          /* 1.  1 -   1 */
            billing.cust_name    FORMAT "X(60)"      /* 2.  2 - 61 */
            billing.nor_policy     FORMAT "X(26)"      /* 3. 62 - 87 */
/*            billing.comp_policy FORMAT "X(26)"      /* 4. 88 - 113 */                */
               FILL(" ", 26) format 'x(26)'
                  
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
        end. /*7070*/
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

--- end lek ----*/
                
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

/****************************************************************/
/* kan ---  
  vAcProc_fil = "" .
  FOR EACH AcProc_fil USE-INDEX by_type_asdat  WHERE AcProc_fil.type = "01"
                                         BY AcProc_fil.asdat DESC  :
        ASSIGN
            vAcProc_fil = vAcProc_fil + STRING( AcProc_fil.asdat,"99/99/9999")  + ",".
  END.

  ASSIGN
    cbAsDat:List-Items IN FRAME {&FRAME-NAME} = vAcProc_fil
    cbAsDat = ENTRY (1, vAcProc_fil).
    
  DISP cbAsDat WITH FRAME {&FRAME-NAME} .
-----kan*/

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdChas C-Win 
PROCEDURE pdChas :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       chassi no.
------------------------------------------------------------------------------*/

/*nv_eng2 = "2-SD332/GG1225".*/
    
    IF SUBSTR(nv_eng2,1,1) >= "0" AND SUBSTR(nv_eng2,1,1) <= "9"  AND
       SUBSTR(nv_eng2,2,1) >= "a" AND SUBSTR(nv_eng2,2,1) <= "z"  THEN DO:

        IF SUBSTR(nv_eng2,3,1) >= "0" AND SUBSTR(nv_eng2,3,1) <= "9"  THEN
            nv_char2 = SUBSTR(nv_eng2,1,2) + " " + SUBSTR(nv_eng2,3,LENGTH(nv_eng2)).

        IF SUBSTR(nv_eng2,3,1) = "" THEN nv_char2 = nv_eng2.

    END.
    ELSE DO:
/***************************/
        nv_l2 = 1.

        REPEAT WHILE nv_l2 <= LENGTH(nv_eng2):

            IF SUBSTR(nv_eng2,nv_l2 ,1) >= "0" AND
               SUBSTR(nv_eng2,nv_l2 ,1) <= "9" THEN DO:
                IF nv_spc2 THEN
                     nv_char2 = TRIM(nv_char2) + " " + SUBSTR(nv_eng2,nv_l2,1).
                ELSE nv_char2 = TRIM(nv_char2) + SUBSTR(nv_eng2,nv_l2,1).

                nv_spc2 = NO.
            END.
            ELSE DO:
                IF SUBSTR(nv_eng2,nv_l2 ,1) >= "A" AND
                   SUBSTR(nv_eng2,nv_l2 ,1) <= "Z" THEN DO:
                    IF nv_spc2 = NO THEN
                         nv_char2 = TRIM(nv_char2) + " " + SUBSTR(nv_eng2,nv_l2,1).
                    ELSE nv_char2 = TRIM(nv_char2) + SUBSTR(nv_eng2,nv_l2,1).

                    nv_spc2 = YES.
                END.
            END.
            nv_l2 = nv_l2 + 1.
        END.
    END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdCreateBilling-A490002 C-Win 
PROCEDURE pdCreateBilling-A490002 :
/*------------------------------------------------------------------------------
  Purpose:      /*k*/    RUN pdCreateBilling (OUTPUT n_recid2). /* Create Transaction*/
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

/*------ lek -----

    DEF OUTPUT PARAMETER  n_recid2 AS RECID.

    DO TRANSACTION :
        CREATE Billing.
    END.
    
    n_recid2 = RECID(Billing).

---- end lek ----*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdCreateWbill-A490002 C-Win 
PROCEDURE pdCreateWbill-A490002 :
/*------------------------------------------------------------------------------
  Purpose:     /*k*/    RUN pdCreateWbill (OUTPUT n_recid). /* Create Transaction*/
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

/*------ lek -----
    DEF OUTPUT PARAMETER  n_recid AS RECID.

    DO TRANSACTION :
        CREATE wBill.
    END.
    
    n_recid = RECID(wBill).
---- end lek ----*/

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
    
    IF SUBSTR(nv_eng1,1,1) >= "0" AND SUBSTR(nv_eng1,1,1) <= "9"  AND
       SUBSTR(nv_eng1,2,1) >= "a" AND SUBSTR(nv_eng1,2,1) <= "z"  THEN DO:

        IF SUBSTR(nv_eng1,3,1) >= "0" AND SUBSTR(nv_eng1,3 ,1) <= "9" THEN
            nv_char1 = SUBSTR(nv_eng1,1,2) + " " + SUBSTR(nv_eng1,3,LENGTH(nv_eng1)).
   
        IF SUBSTR(nv_eng1,3,1) = "" THEN nv_char1 = nv_eng1.
   
    END.
    ELSE DO:
/***************************/
        nv_l1 = 1.

        REPEAT while nv_l1 <= LENGTH(nv_eng1):
            
            IF SUBSTR(nv_eng1,nv_l1 ,1) >= "0" AND
               SUBSTR(nv_eng1,nv_l1 ,1) <= "9" THEN DO:
                IF nv_spc1 THEN 
                     nv_char1 = TRIM(nv_char1) + " " + SUBSTR(nv_eng1,nv_l1,1).
                ELSE nv_char1 = TRIM(nv_char1) + SUBSTR(nv_eng1,nv_l1,1).

                nv_spc1 = NO.
            END.
            ELSE DO:
                IF SUBSTR(nv_eng1,nv_l1 ,1) >= "A" AND
                   SUBSTR(nv_eng1,nv_l1 ,1) <= "Z" THEN DO:
                    IF nv_spc1 = NO THEN
                         nv_char1 = TRIM(nv_char1) + " " + SUBSTR(nv_eng1,nv_l1,1).
                    ELSE nv_char1 = TRIM(nv_char1) + SUBSTR(nv_eng1,nv_l1,1).

                    nv_spc1 = YES.
                END.
            END.  /*ELSE  do*/

            nv_l1 = nv_l1 + 1.

        END.  /*repeat*/
    END.  /*ELSE  do*/
    
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdInitData-A490002 C-Win 
PROCEDURE pdInitData-A490002 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

/*------ lek -----
    FIND FIRST  xmm023 NO-ERROR.
    IF AVAIL xmm023  THEN  DO:

        DO WITH FRAME frST :
            ASSIGN
                fiBranch = xmm023.branch
                fibdes   = xmm023.bdes.
            DISP fiBranch fibdes.
        END.
    END.     

    FIND Last  xmm023 NO-ERROR.
    IF AVAIL xmm023  THEN  DO:
        ASSIGN
            fiBranch2 = xmm023.branch
            fibdes2   = xmm023.bdes.
        DISP fiBranch2 fibdes2 .
    END.
---- end lek ----*/

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
    
    IF SUBSTR(nv_eng,1,1) >= "0" AND SUBSTR(nv_eng,1,1) <= "9"  AND
       SUBSTR(nv_eng,2,1) >= "a" AND SUBSTR(nv_eng,2,1) <= "z"  THEN DO:
   
        IF SUBSTR(nv_eng,3,1) >= "0" AND SUBSTR(nv_eng,3 ,1) <= "9"  THEN
            nv_char = SUBSTR(nv_eng,1,2) + " " + SUBSTR(nv_eng , 3 , LENGTH(nv_eng)).
   
        IF SUBSTR(nv_eng,3,1)  = "" THEN nv_char = nv_eng.
   
    END.
    ELSE DO:

        nv_l = 1.
        REPEAT WHILE nv_l <= LENGTH(nv_eng) :
            IF SUBSTR(nv_eng,nv_l ,1) >= "0"  AND
               SUBSTR(nv_eng,nv_l ,1) <= "9"  THEN DO:
                IF nv_spc THEN 
                     nv_char = TRIM(nv_char) + " " + SUBSTR(nv_eng,nv_l,1).
                ELSE nv_char = TRIM(nv_char) + SUBSTR(nv_eng,nv_l,1).

                nv_spc = NO.
            END.
            ELSE DO:
                IF SUBSTR(nv_eng,nv_l ,1) >= "A"  AND
                   SUBSTR(nv_eng,nv_l ,1) <= "Z"  THEN DO:
                    
                    IF nv_spc = NO THEN
                         nv_char = TRIM(nv_char) + " " + SUBSTR(nv_eng,nv_l ,1).
                    ELSE nv_char = TRIM(nv_char) + SUBSTR(nv_eng,nv_l ,1).

                    nv_spc = YES.
                END.
            END.
            nv_l = nv_l + 1.
        END.   /*repeat*/
    END.  /*else do*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdo1 C-Win 
PROCEDURE pdo1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

/* A47-0325*/
/*----------------------------- export to file *** before 30/11/01 file comp ***---------------------------*/
OUTPUT STREAM filebill1 TO VALUE(fiFile-Name1).

/* 1. Header */
PUT STREAM filebill1
    "H"                                        FORMAT "X"       /* 1 -  1 */
    "Safety Insurance Public Company Limited"  FORMAT "X(40)"   /* 2 - 41 */
    STRING(TODAY,"99999999")                   FORMAT "X(8)"    /* 42 - 49 */
    STRING(n_asdat,"99999999")                 FORMAT "X(12)"   /* 50 - 61 */
    SKIP.

vExpCount1= 0.

/*------ A49-0002 ------
loop1:
FOR EACH wbill  USE-INDEX wbill02 WHERE
         wbill.wtrndat  = nv_exportdat  AND /* wBill.trndat = Today */
         wbill.wasdat   = n_asdat       AND
 (LOOKUP(wbill.wacno,nv_acnoAll) <> 0)  AND  /* A46-0426*/
      ( (wbill.wpol72  <> "")   OR         /* ได้ 7070, 7072, 72 เบี้ยใหญ่ +  พรบ.  */
        (wbill.wpol72   = ''    AND
         wbill.wpoltyp  = 'v72') )      AND
        (wbill.wcomdat >= n_comdatF     AND
         wbill.wcomdat <= n_comdatT)

    BREAK BY wbill.wcomdat
          BY wbill.wNorpol :
------ END A49-0002 ------*/

/* 2. detail*/
loop1:
FOR EACH wBill  USE-INDEX wBill03 WHERE
         wBill.wcomdat >= n_comdatF       /*A59-0362*/ /* AND 
         wBill.wnorpol <> " "       AND
         wBill.wpol72  <> " "          */ /*End Sarinya C. A59-0362*/
        /*---
       ((wBill.comp_policy <> " ") OR     /* ได้ 7070, 7072, 72 เบี้ยใหญ่ + พรบ. */
        (wBill.comp_policy  = " "  AND
         wBill.poltyp       = "V72"))
         ---*/
    BREAK BY wBill.wcomdat
          BY wBill.wnorpol : 

        /*------ A49-0002 ------
    FIND wBill WHERE RECID(wBill) = wbill.wrecid NO-ERROR.
    IF AVAIL wBill THEN DO:
        
        IF wBill.nor_netprm + wBill.comp_netprm = 0 THEN NEXT loop1.  /* เบี้ยเป็น 0 แต่ยังค้างค่า comm. bal <> 0*/        
        
        ASSIGN
            n_netloc = 0      y1 = 0         z1 = 0     sum = 0
            p_trnty  = ''     p_policy = ''.

        FOR EACH acd001 USE-INDEX acd00191 WHERE
                 acd001.trnty1  = wBill.trnty1    AND
                 acd001.docno = wBill.docno       NO-LOCK:
                            
          /*      n_netloc =  n_netloc + acd001.netloc.*/
            IF acd001.ctrty1 = 'y' THEN y1 = -(acd001.netloc).
            IF acd001.ctrty1 = 'z' THEN z1 = -(acd001.netloc).

            sum     = y1 + z1.
            p_trnty = wBill.trnty1 + wBill.trnty2.
        END.      /*acd001*/
        ------ END A49-0002 ------*/

/*p-----------------------------------------
         FIND FIRST agtprm_fil WHERE agtprm_fil.asdat   = n_asdat           AND
                                                                agtprm_fil.acno    = wBill.acno1   AND
                                                                agtprm_fil.policy  = wBill.policy          AND
                                                                agtprm_fil.trnty     = p_trnty             AND
                                                                agtprm_fil.docno = wBill.docno
                    NO-LOCK NO-ERROR NO-WAIT.
         IF AVAIL agtprm_fil THEN DO:             
             IF agtprm_fil.bal - (y1 + z1) <= wBill.whtax1 THEN DO:
                  wBill.error = "E".
                  NEXT loop1.
             END.                 
         END.   
         
         FIND FIRST agtprm_fil WHERE agtprm_fil.asdat   = n_asdat           AND
                                                                agtprm_fil.acno    = wBill.acno1   AND
                                                                agtprm_fil.policy  = wBill.policy          AND
                                                                agtprm_fil.trnty     = wBill.trnty1 + wBill.trnty2  AND
                                                                agtprm_fil.docno = wBill.docno
                    NO-LOCK NO-ERROR NO-WAIT.
         IF AVAIL agtprm_fil THEN DO:                    
             if  substr(trntyp , 1 , 1) = 'r' and agtprm_fil.bal <> 0 then next loop1.
             if  substr(trntyp , 1 , 1) = 'm' and agtprm_fil.bal < 0 then next loop1.         
         end.        
------------------------------------------------p*/

        /*------ A49-0002 ------
/*p--------------*/
        IF wBill.bal - (y1 + z1) <= wBill.whtax1 THEN DO:
      /* bal  -  (รายการทีตัดเบี้ยไปแล้วเหลือ <= ภาษี 1 % ไม่ตัดทิ้งแต่จะเก็บไว้ match ตอน ออกภาษ๊หัก ณ ที่จ่าย )  */
            wBill.error = "E".
            NEXT loop1.
        END. 

        IF wBill.trnty1 = 'r' AND wBill.bal <> 0 THEN NEXT loop1.
        IF wBill.trnty1 = 'm' AND wBill.bal  < 0 THEN NEXT loop1.
/*--------------p*/
        ------ END A49-0002 ------*/
                                            
        n_veh = "".                          
        n_veh = wBill.wVehreg.

        IF SUBSTR(wBill.wVehreg,1,1) <> '/' THEN DO:
            RUN pdveh.
        END.
        ELSE DO:
            IF wBill.wVehreg <> '' THEN DO:
                nv_eng  = SUBSTR(wBill.wVehreg,2,LENGTH(wBill.wVehreg)).
                RUN pdNewVeh.
                engc    = nv_char.
                nv_eng  = ''.
                nv_char = ''.
            END.
            ELSE engc = ''.
        END.
          
        IF wBill.wengine <> "" THEN DO:
            nv_eng1  = wBill.wengine.
            RUN pdeng.
            engine   = nv_char1.
            nv_char1 = ''.
            nv_eng1  = ''.
        END.
        ELSE engine = ''.
            
        IF wBill.wcha_no <> "" THEN DO:
            nv_eng2  = wBill.wcha_no.
            RUN pdchas.
            chas     = nv_char2.
            nv_char2 = ''.
            nv_eng2  = ''.
        END.
        ELSE chas = ''.
        
        DISPLAY
            wBill.wacno  wBill.wcomdat  wBill.wpolicy  wBill.wtrnty1 wBill.wdocno
        WITH COLOR BLACK/WHITE  NO-LABEL FRAME frpdo1 VIEW-AS DIALOG-BOX TITLE "Process ... ".

        PUT STREAM  filebill1
            "D"             FORMAT "X"          /* 1.  1 -   1 */
            wBill.winsure   FORMAT "X(60)"      /* 2.  2 - 61 */
            wBill.wnorpol   FORMAT "X(26)"      /* 3. 62 - 87 */
            wBill.wpol72    FORMAT "X(26)"      /* 4. 88 - 113 */
            engine          FORMAT "X(26)"
            chas            FORMAT "X(26)"
            wBill.wcontract FORMAT "X(20)"     /* FORMAT "X(10)" */  /* 7. 166 - 175   opnpol*/
            engc            FORMAT "X(12)"
            wBill.wcomdat   FORMAT "99999999"   /* 9. 188 - 195 comdat*/

            fuDeciToChar(wBill.wGrossPrem,10)     FORMAT "X(10)"   /* 10. 196 - 205  "9999999999" GP*/
            fuDeciToChar(wBill.wCompGrossPrem,10) FORMAT "X(10)"   /* 11. 206 - 215  compGP*/
            fuDeciToChar(wBill.wNetPrem,10)       FORMAT "X(10)"   /* 12. 216 - 225  NP*/
            fuDeciToChar(wBill.wCompNetPrem,10)   FORMAT "X(10)"   /* 13. 226 - 235  compNP*/
            fuDeciToChar(wBill.wtax,10)           FORMAT "X(10)"   /* 14. 236 - 245  12+13+stamp * 1% */
            fuDeciToChar(wBill.wNetPayment,10)    FORMAT "X(10)"   /* 15. 246 - 255  10-11-14 */
            SKIP.

        vExpCount1= vExpCount1 + 1.

END.  /* for each wbill */
/*--------*/

/* 3. Trailer */          
PUT STREAM filebill1
    "T"      FORMAT "X"                         /* 1 - 1 */
    STRING(vExpCount1,"99999")  FORMAT "X(5)"   /* 2 - 6 */
    SKIP.

OUTPUT STREAM filebill1 CLOSE.
    
vBackUp =  fiFile-Name1 + "B".

DOS SILENT COPY VALUE(fiFile-Name1) VALUE(vBackUP) /Y.  /* backup file exports */
         
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdo1-A470235 C-Win 
PROCEDURE pdo1-A470235 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*
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
                                (LOOKUP(billing.acno1,nv_acnoAll) <> 0 ) AND  /* A46-0426*/
                            /* A46-0426---
                               (billing.acno1 = fi_ac1              OR
                                billing.acno1 = fi_ac2              OR
                                billing.acno1 = fi_ac3              OR
                                billing.acno1 = fi_ac4              OR
                                billing.acno1 = fi_ac5              OR
                                billing.acno1 = fi_ac6              OR
                                billing.acno1 = fi_ac7              OR
                                billing.acno1 = fi_ac8              OR
                                billing.acno1 = fi_ac9              OR
                                billing.acno1 = fi_ac10  )       AND 
                            ---A46-0426*/

                             ((billing.comp_policy <> "")      OR               /*  ได้ 7070 , 7072 ,  72 */
                              (billing.comp_policy  = ''         AND
                               billing.poltyp             = 'v72')) AND
                              (billing.start_date     >= n_comdatF and
                               billing.start_date     <= n_comdatT) 

    BREAK BY billing.start_date
                BY  billing.nor_policy :

        IF billing.nor_netprm + billing.comp_netprm = 0 THEN NEXT loop1.  /* เบี้ยเป็น 0 แต่ยังค้างค่า comm. bal <> 0*/
        
         n_netloc = 0.      y1 = 0.         z1 = 0.     sum = 0.
         p_trnty    = ''.      p_policy = ''.

         FOR EACH acd001 USE-INDEX acd00191 WHERE 
                             acd001.trnty1  = billing.trnty1      AND
                             acd001.docno = billing.docno  NO-LOCK.
                             
          /*      n_netloc =  n_netloc + acd001.netloc.*/
                  IF acd001.ctrty1 = 'y' THEN   y1 = -(acd001.netloc).
                  IF acd001.ctrty1 = 'z' THEN   z1 = -(acd001.netloc).
                  sum         = y1 + z1.                         
                  p_trnty    = billing.trnty1 + billing.trnty2.          
         END.      /*acd001*/

/*p-----------------------------------------
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
         
         FIND FIRST agtprm_fil WHERE agtprm_fil.asdat   = n_asdat           AND
                                                                agtprm_fil.acno    = billing.acno1   AND
                                                                agtprm_fil.policy  = billing.policy          AND
                                                                agtprm_fil.trnty     = billing.trnty1 + billing.trnty2  AND
                                                                agtprm_fil.docno = billing.docno
                    NO-LOCK NO-ERROR NO-WAIT.
         IF AVAIL agtprm_fil THEN DO:                    
             if  substr(trntyp , 1 , 1) = 'r' and agtprm_fil.bal <> 0 then next loop1.
             if  substr(trntyp , 1 , 1) = 'm' and agtprm_fil.bal < 0 then next loop1.         
         end.        
------------------------------------------------p*/
/*p--------------*/
             IF billing.bal - (y1 + z1) <= billing.whtax1 THEN DO:  
      /* bal  -  (รายการทีตัดเบี้ยไปแล้วเหลือ <= ภาษี 1 % ไม่ตัดทิ้งแต่จะเก็บไว้ match ตอน ออกภาษ๊หัก ณ ที่จ่าย )  */
                  billing.error = "E".
                  NEXT loop1.
             END. 

             if  billing.trnty1 =  'r'   and billing.bal <> 0 then next loop1.
             if  billing.trnty1 =  'm' and billing.bal < 0   then next loop1.        
/*--------------p*/
                                            
         n_veh = "".                          
         n_veh = billing.vehreg.
         IF SUBSTR(billing.vehreg,1,1) <> '/' THEN DO:        
             RUN pdveh.
         END.                          
         ELSE DO:
             IF billing.vehreg <> '' THEN DO:
                 nv_eng   = substr(billing.vehreg  , 2 , length(billing.vehreg)).                                 
                 RUN pdNewVeh.                   
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


        DISP
            billing.acno  billing.start_date  billing.policy  billing.trnty1 billing.docno
        WITH COLOR BLACK/WHITE  NO-LABEL  FRAME frpdo1 VIEW-AS DIALOG-BOX  TITLE "Process ... " . 

        PUT STREAM  filebill1
       
            "D"          FORMAT "X"          /* 1.  1 -   1 */
            billing.cust_name    FORMAT "X(60)"      /* 2.  2 - 61 */
            billing.nor_policy     FORMAT "X(26)"      /* 3. 62 - 87 */
            billing.comp_policy FORMAT "X(26)"      /* 4. 88 - 113 */                
                  
            engine                       format 'x(26)'
            chas                          format 'x(26)'
            billing.contract         FORMAT "X(10)"       /* 7. 166 - 175   opnpol*/
            engc                          format 'x(12)'
                 
            billing.start_date      FORMAT "99999999" /* 9. 188 - 195 comdat*/

            fuDeciToChar(billing.nor_grp,10)            FORMAT "X(10)"   /* 10. 196 - 205  "9999999999" GP*/
            fuDeciToChar(billing.comp_grp,10)        FORMAT "X(10)"   /* 11. 206 - 215 compGP*/
            fuDeciToChar(billing.nor_netprm,10)      FORMAT "X(10)"   /* 12. 216 - 225  NP*/
            fuDeciToChar(billing.comp_netprm,10)  FORMAT "X(10)"   /* 13. 226 - 235  compNP*/
            fuDeciToChar(billing.whtax1,10)              FORMAT "X(10)"   /* 14. 236 - 245       12+13+stamp * 1% */
            fuDeciToChar(billing.net_amount,10)      FORMAT "X(10)"   /* 15. 246 - 255      10-11-14 */
                  
            SKIP.
               
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
*/                 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdo1-A490002 C-Win 
PROCEDURE pdo1-A490002 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*---- A49-0002 ----
/* A47-0325*/
/*----------------------------- export to file *** before 30/11/01 file comp ***---------------------------*/
OUTPUT STREAM filebill1 TO VALUE(fiFile-Name1).

/* 1. Header */
PUT STREAM filebill1
    "H"                                        FORMAT "X"       /* 1 -  1 */
    "Safety Insurance Public Company Limited"  FORMAT "X(40)"   /* 2 - 41 */
    STRING(TODAY,"99999999")                   FORMAT "X(8)"    /* 42 - 49 */
    STRING(n_asdat,"99999999")                 FORMAT "X(12)"   /* 50 - 61 */
    SKIP.

vExpCount1= 0.

/*------ A49-0002 ------
loop1:
FOR EACH wbill  USE-INDEX wbill02 WHERE
         wbill.wtrndat  = nv_exportdat  AND /* billing.trndat = Today */
         wbill.wasdat   = n_asdat       AND
 (LOOKUP(wbill.wacno,nv_acnoAll) <> 0)  AND  /* A46-0426*/
      ( (wbill.wpol72  <> "")   OR         /* ได้ 7070, 7072, 72 เบี้ยใหญ่ +  พรบ.  */
        (wbill.wpol72   = ''    AND
         wbill.wpoltyp  = 'v72') )      AND
        (wbill.wcomdat >= n_comdatF     AND
         wbill.wcomdat <= n_comdatT)

    BREAK BY wbill.wcomdat
          BY wbill.wNorpol :
------ END A49-0002 ------*/

/* 2. detail*/
loop1:
FOR EACH billing  USE-INDEX billing02 WHERE
         billing.trndat  = nv_exportdat AND /* Today */
         billing.asdat   = n_asdat      AND /* Asdate Statement */
         billing.comp_policy <> " "     /* A49-0002 */
        /*---
       ((billing.comp_policy <> " ") OR     /* ได้ 7070, 7072, 72 เบี้ยใหญ่ + พรบ. */
        (billing.comp_policy  = " "  AND
         billing.poltyp       = "V72"))
         ---*/

    BREAK BY billing.start_date /* comdat */
          BY billing.nor_policy :

        /*------ A49-0002 ------
    FIND billing WHERE RECID(billing) = wbill.wrecid NO-ERROR.
    IF AVAIL billing THEN DO:
        
        IF billing.nor_netprm + billing.comp_netprm = 0 THEN NEXT loop1.  /* เบี้ยเป็น 0 แต่ยังค้างค่า comm. bal <> 0*/        
        
        ASSIGN
            n_netloc = 0      y1 = 0         z1 = 0     sum = 0
            p_trnty  = ''     p_policy = ''.

        FOR EACH acd001 USE-INDEX acd00191 WHERE
                 acd001.trnty1  = billing.trnty1    AND
                 acd001.docno = billing.docno       NO-LOCK:
                            
          /*      n_netloc =  n_netloc + acd001.netloc.*/
            IF acd001.ctrty1 = 'y' THEN y1 = -(acd001.netloc).
            IF acd001.ctrty1 = 'z' THEN z1 = -(acd001.netloc).

            sum     = y1 + z1.
            p_trnty = billing.trnty1 + billing.trnty2.
        END.      /*acd001*/
        ------ END A49-0002 ------*/

/*p-----------------------------------------
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
         
         FIND FIRST agtprm_fil WHERE agtprm_fil.asdat   = n_asdat           AND
                                                                agtprm_fil.acno    = billing.acno1   AND
                                                                agtprm_fil.policy  = billing.policy          AND
                                                                agtprm_fil.trnty     = billing.trnty1 + billing.trnty2  AND
                                                                agtprm_fil.docno = billing.docno
                    NO-LOCK NO-ERROR NO-WAIT.
         IF AVAIL agtprm_fil THEN DO:                    
             if  substr(trntyp , 1 , 1) = 'r' and agtprm_fil.bal <> 0 then next loop1.
             if  substr(trntyp , 1 , 1) = 'm' and agtprm_fil.bal < 0 then next loop1.         
         end.        
------------------------------------------------p*/

        /*------ A49-0002 ------
/*p--------------*/
        IF billing.bal - (y1 + z1) <= billing.whtax1 THEN DO:
      /* bal  -  (รายการทีตัดเบี้ยไปแล้วเหลือ <= ภาษี 1 % ไม่ตัดทิ้งแต่จะเก็บไว้ match ตอน ออกภาษ๊หัก ณ ที่จ่าย )  */
            billing.error = "E".
            NEXT loop1.
        END. 

        IF billing.trnty1 = 'r' AND billing.bal <> 0 THEN NEXT loop1.
        IF billing.trnty1 = 'm' AND billing.bal  < 0 THEN NEXT loop1.
/*--------------p*/
        ------ END A49-0002 ------*/
                                            
        n_veh = "".                          
        n_veh = billing.vehreg.

        IF SUBSTR(billing.vehreg,1,1) <> '/' THEN DO:
            RUN pdveh.
        END.
        ELSE DO:
            IF billing.vehreg <> '' THEN DO:
                nv_eng  = SUBSTR(billing.vehreg,2,LENGTH(billing.vehreg)).
                RUN pdNewVeh.
                engc    = nv_char.
                nv_eng  = ''.
                nv_char = ''.
            END.
            ELSE engc = ''.
        END.
          
        IF billing.engine <> "" THEN DO:
            nv_eng1  = billing.engine.
            RUN pdeng.
            engine   = nv_char1.
            nv_char1 = ''.
            nv_eng1  = ''.
        END.
        ELSE engine = ''.
            
        IF billing.chassis <> "" THEN DO:
            nv_eng2  = billing.chassis.
            RUN pdchas.
            chas     = nv_char2.
            nv_char2 = ''.
            nv_eng2  = ''.
        END.
        ELSE chas = ''.
        
        DISPLAY
            billing.acno  billing.start_date  billing.policy  billing.trnty1 billing.docno
        WITH COLOR BLACK/WHITE  NO-LABEL FRAME frpdo1 VIEW-AS DIALOG-BOX TITLE "Process ... ".

        PUT STREAM  filebill1
            "D"                 FORMAT "X"          /* 1.  1 -   1 */
            billing.cust_name   FORMAT "X(60)"      /* 2.  2 - 61 */
            billing.nor_policy  FORMAT "X(26)"      /* 3. 62 - 87 */
            billing.comp_policy FORMAT "X(26)"      /* 4. 88 - 113 */

            engine              FORMAT 'x(26)'
            chas                FORMAT 'x(26)'
            billing.contract    FORMAT "X(10)"      /* 7. 166 - 175   opnpol*/
            engc                FORMAT 'x(12)'

            billing.start_date  FORMAT "99999999"   /* 9. 188 - 195 comdat*/

            fuDeciToChar(billing.nor_grp,10)      FORMAT "X(10)"   /* 10. 196 - 205  "9999999999" GP*/
            fuDeciToChar(billing.comp_grp,10)     FORMAT "X(10)"   /* 11. 206 - 215  compGP*/
            fuDeciToChar(billing.nor_netprm,10)   FORMAT "X(10)"   /* 12. 216 - 225  NP*/
            fuDeciToChar(billing.comp_netprm,10)  FORMAT "X(10)"   /* 13. 226 - 235  compNP*/
            fuDeciToChar(billing.whtax1,10)       FORMAT "X(10)"   /* 14. 236 - 245  12+13+stamp * 1% */
            fuDeciToChar(billing.net_amount,10)   FORMAT "X(10)"   /* 15. 246 - 255  10-11-14 */
            SKIP.

        vExpCount1= vExpCount1 + 1.

END.  /* for each wbill */
/*--------*/

/* 3. Trailer */          
PUT STREAM filebill1
    "T"      FORMAT "X"                         /* 1 - 1 */
    STRING(vExpCount1,"99999")  FORMAT "X(5)"   /* 2 - 6 */
    SKIP.

OUTPUT STREAM filebill1 CLOSE.
    
vBackUp =  fiFile-Name1 + "B".

DOS SILENT COPY VALUE(fiFile-Name1) VALUE(vBackUP) /Y.  /* backup file exports */
---- A49-0002 ----*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdo1-A490002-old C-Win 
PROCEDURE pdo1-A490002-old :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*------------ A49-0002 -------------
/* A47-0325*/
/*----------------------------- export to file *** before 30/11/01 file comp ***---------------------------*/
OUTPUT STREAM filebill1 TO VALUE(fiFile-Name1).
/* 1. Header */
PUT STREAM filebill1
    "H"                                        FORMAT "X"       /* 1 -  1 */
    "Safety Insurance Public Company Limited"  FORMAT "X(40)"   /* 2 - 41 */
    STRING(TODAY,"99999999")                   FORMAT "X(8)"    /* 42 - 49 */
    STRING(n_asdat,"99999999")                 FORMAT "X(12)"   /* 50 - 61 */
    SKIP.

vExpCount1= 0.

/* 2. detail*/
loop1:
FOR EACH wbill  USE-INDEX wbill02 WHERE
         wbill.wtrndat  = nv_exportdat  AND /* billing.trndat = Today */
         wbill.wasdat   = n_asdat       AND
 (LOOKUP(wbill.wacno,nv_acnoAll) <> 0)  AND  /* A46-0426*/
      ( (wbill.wpol72  <> "")   OR         /* ได้ 7070, 7072, 72 เบี้ยใหญ่ +  พรบ.  */
        (wbill.wpol72   = ''    AND
         wbill.wpoltyp  = 'v72') )      AND
        (wbill.wcomdat >= n_comdatF     AND
         wbill.wcomdat <= n_comdatT)

    BREAK BY wbill.wcomdat
          BY wbill.wNorpol :

    FIND billing WHERE RECID(billing) = wbill.wrecid NO-ERROR.
    IF AVAIL billing THEN DO:
        
        IF billing.nor_netprm + billing.comp_netprm = 0 THEN NEXT loop1.  /* เบี้ยเป็น 0 แต่ยังค้างค่า comm. bal <> 0*/

        ASSIGN
            n_netloc = 0      y1 = 0         z1 = 0     sum = 0
            p_trnty  = ''     p_policy = ''.

        FOR EACH acd001 USE-INDEX acd00191 WHERE
                 acd001.trnty1  = billing.trnty1    AND
                 acd001.docno = billing.docno       NO-LOCK:
                            
          /*      n_netloc =  n_netloc + acd001.netloc.*/
            IF acd001.ctrty1 = 'y' THEN y1 = -(acd001.netloc).
            IF acd001.ctrty1 = 'z' THEN z1 = -(acd001.netloc).

            sum     = y1 + z1.
            p_trnty = billing.trnty1 + billing.trnty2.
        END.      /*acd001*/

/*p-----------------------------------------
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
         
         FIND FIRST agtprm_fil WHERE agtprm_fil.asdat   = n_asdat           AND
                                                                agtprm_fil.acno    = billing.acno1   AND
                                                                agtprm_fil.policy  = billing.policy          AND
                                                                agtprm_fil.trnty     = billing.trnty1 + billing.trnty2  AND
                                                                agtprm_fil.docno = billing.docno
                    NO-LOCK NO-ERROR NO-WAIT.
         IF AVAIL agtprm_fil THEN DO:                    
             if  substr(trntyp , 1 , 1) = 'r' and agtprm_fil.bal <> 0 then next loop1.
             if  substr(trntyp , 1 , 1) = 'm' and agtprm_fil.bal < 0 then next loop1.         
         end.        
------------------------------------------------p*/
/*p--------------*/
        IF billing.bal - (y1 + z1) <= billing.whtax1 THEN DO:
      /* bal  -  (รายการทีตัดเบี้ยไปแล้วเหลือ <= ภาษี 1 % ไม่ตัดทิ้งแต่จะเก็บไว้ match ตอน ออกภาษ๊หัก ณ ที่จ่าย )  */
            billing.error = "E".
            NEXT loop1.
        END. 

        IF billing.trnty1 = 'r' AND billing.bal <> 0 THEN NEXT loop1.
        IF billing.trnty1 = 'm' AND billing.bal  < 0 THEN NEXT loop1.
/*--------------p*/
                                            
        n_veh = "".                          
        n_veh = billing.vehreg.

        IF SUBSTR(billing.vehreg,1,1) <> '/' THEN DO:
            RUN pdveh.
        END.
        ELSE DO:
            IF billing.vehreg <> '' THEN DO:
                nv_eng  = SUBSTR(billing.vehreg,2,LENGTH(billing.vehreg)).
                RUN pdNewVeh.
                engc    = nv_char.
                nv_eng  = ''.
                nv_char = ''.
            END.
            ELSE engc = ''.
        END.
          
        IF billing.engine <> "" THEN DO:
            nv_eng1  = billing.engine.
            RUN pdeng.
            engine   = nv_char1.
            nv_char1 = ''.
            nv_eng1  = ''.
        END.
        ELSE engine = ''.
            
        IF billing.chassis <> "" THEN DO:
            nv_eng2  = billing.chassis.
            RUN pdchas.
            chas     = nv_char2.
            nv_char2 = ''.
            nv_eng2  = ''.
        END.
        ELSE chas = ''.
        
        DISPLAY
            billing.acno  billing.start_date  billing.policy  billing.trnty1 billing.docno
        WITH COLOR BLACK/WHITE  NO-LABEL FRAME frpdo1 VIEW-AS DIALOG-BOX TITLE "Process ... ".

        PUT STREAM  filebill1
            "D"                 FORMAT "X"          /* 1.  1 -   1 */
            billing.cust_name   FORMAT "X(60)"      /* 2.  2 - 61 */
            billing.nor_policy  FORMAT "X(26)"      /* 3. 62 - 87 */
            billing.comp_policy FORMAT "X(26)"      /* 4. 88 - 113 */

            engine              FORMAT 'x(26)'
            chas                FORMAT 'x(26)'
            billing.contract    FORMAT "X(10)"      /* 7. 166 - 175   opnpol*/
            engc                FORMAT 'x(12)'

            billing.start_date  FORMAT "99999999"   /* 9. 188 - 195 comdat*/

            fuDeciToChar(billing.nor_grp,10)      FORMAT "X(10)"   /* 10. 196 - 205  "9999999999" GP*/
            fuDeciToChar(billing.comp_grp,10)     FORMAT "X(10)"   /* 11. 206 - 215  compGP*/
            fuDeciToChar(billing.nor_netprm,10)   FORMAT "X(10)"   /* 12. 216 - 225  NP*/
            fuDeciToChar(billing.comp_netprm,10)  FORMAT "X(10)"   /* 13. 226 - 235  compNP*/
            fuDeciToChar(billing.whtax1,10)       FORMAT "X(10)"   /* 14. 236 - 245  12+13+stamp * 1% */
            fuDeciToChar(billing.net_amount,10)   FORMAT "X(10)"   /* 15. 246 - 255  10-11-14 */
            SKIP.

        vExpCount1= vExpCount1 + 1.

    END. /* IF AVAIL billing */
END.  /* for each wbill */
/*--------*/

/* 3. Trailer */          
PUT STREAM filebill1
    "T"      FORMAT "X"                         /* 1 - 1 */
    STRING(vExpCount1,"99999")  FORMAT "X(5)"   /* 2 - 6 */
    SKIP.

OUTPUT STREAM filebill1 CLOSE.
    
vBackUp =  fiFile-Name1 + "B".

DOS SILENT COPY VALUE(fiFile-Name1) VALUE(vBackUP) /Y.  /* backup file exports */
------------ A49-0002 -------------*/
         
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdo1-temp C-Win 
PROCEDURE pdo1-temp :
/*
/* A47-9999*/
/*----------------------------- export to file *** before 30/11/01 file comp ***---------------------------*/
OUTPUT STREAM filebill1 TO VALUE(fiFile-Name1).
/* 1. Header */
       PUT STREAM filebill1
              "H" FORMAT "X"                                                                              /* 1 -   1 */
              "Safety Insurance Public Company Limited"  FORMAT "X(40)"  /* 2 - 41 */
              STRING(TODAY,"99999999")                           FORMAT "X(8)"    /* 42 - 49 */
              STRING(n_asdat,"99999999")                          FORMAT "X(12)"   /* 50 - 61 */
              SKIP.
vExpCount1= 0.


/* 2. detail*/
loop1:
FOR EACH wbill  USE-INDEX wbill02 WHERE 
                wbill.wtrndat = nv_exportdat AND
                wbill.wasdat = n_asdat       AND
                (LOOKUP(wbill.wacno,nv_acnoAll) <> 0 ) AND  /* A46-0426*/
                ((wbill.wpol72 <> "")    OR         /* ได้ 7070, 7072, 72 เบี้ยใหญ่ +  พรบ.  */
                 (wbill.wpol72  = ''     AND
                  wbill.wpoltyp  = 'v72')
                )   AND
                (wbill.wcomdat >= n_comdatF AND
                wbill.wcomdat  <= n_comdatT) 
        BREAK BY wbill.wcomdat
              BY wbill.wNorpol  :

/*     FIND billing WHERE RECID(billing) = wbill.wrecid NO-ERROR. */
/*     IF AVAIL billing THEN DO:                                  */
    
        IF wbill.wNetPrem + wbill.wCompNetPrem = 0 THEN NEXT loop1.  /* เบี้ยเป็น 0 แต่ยังค้างค่า comm. bal <> 0*/
         ASSIGN
         n_netloc = 0      y1 = 0         z1 = 0     sum = 0
         p_trnty    = ''      p_policy = ''.

         FOR EACH acd001 USE-INDEX acd00191 WHERE 
                             acd001.trnty1 = wbill.wtrnty1      AND
                             acd001.docno  = wbill.wdocno  NO-LOCK.
                             
          /*      n_netloc =  n_netloc + acd001.netloc.*/
                  IF acd001.ctrty1 = 'y' THEN   y1 = -(acd001.netloc).
                  IF acd001.ctrty1 = 'z' THEN   z1 = -(acd001.netloc).
                  sum         = y1 + z1.                         
                  p_trnty    = wbill.wtrnty1 + wbill.wtrnty2.          
         END.      /*acd001*/

/*p-----------------------------------------
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
         
         FIND FIRST agtprm_fil WHERE agtprm_fil.asdat   = n_asdat           AND
                                                                agtprm_fil.acno    = billing.acno1   AND
                                                                agtprm_fil.policy  = billing.policy          AND
                                                                agtprm_fil.trnty     = billing.trnty1 + billing.trnty2  AND
                                                                agtprm_fil.docno = billing.docno
                    NO-LOCK NO-ERROR NO-WAIT.
         IF AVAIL agtprm_fil THEN DO:                    
             if  substr(trntyp , 1 , 1) = 'r' and agtprm_fil.bal <> 0 then next loop1.
             if  substr(trntyp , 1 , 1) = 'm' and agtprm_fil.bal < 0 then next loop1.         
         end.        
------------------------------------------------p*/
/*p--------------*/
             IF wbill.wbal - (y1 + z1) <= wbill.whtax1 THEN DO:  
      /* bal  -  (รายการทีตัดเบี้ยไปแล้วเหลือ <= ภาษี 1 % ไม่ตัดทิ้งแต่จะเก็บไว้ match ตอน ออกภาษ๊หัก ณ ที่จ่าย )  */
                  wbill.error = "E".
                  NEXT loop1.
             END. 

             if  wbill.trnty1 =  'r'   and wbill.bal <> 0 then next loop1.
             if  wbill.trnty1 =  'm' and wbill.bal < 0   then next loop1.        
/*--------------p*/
                                            
         n_veh = "".                          
         n_veh = wbill.vehreg.
         IF SUBSTR(wbill.vehreg,1,1) <> '/' THEN DO:        
             RUN pdveh.
         END.                          
         ELSE DO:
             IF wbill.vehreg <> '' THEN DO:
                 nv_eng   = substr(wbill.vehreg  , 2 , length(wbill.vehreg)).                                 
                 RUN pdNewVeh.                   
                 engc      = nv_char.
                 nv_eng  = ''.
                 nv_char = ''.
             END.        
             ELSE 
                 engc = ''.
         END. 
          
         IF wbill.engine <> "" THEN DO:
             nv_eng1 = wbill.engine.
             RUN pdeng. 
             engine = nv_char1.
             nv_char1 = ''.
             nv_eng1 = ''.
         END.         
         ELSE 
             engine = ''.
             
         if wbill.chassis <> "" then do:
            nv_eng2 = wbill.chassis.
            RUN pdchas.
            chas = nv_char2.
            nv_char2 = ''.
            nv_eng2 = ''.
         end.         
         else 
            chas = ''.


        DISP
            wbill.acno  wbill.start_date  wbill.policy  wbill.trnty1 wbill.docno
        WITH COLOR BLACK/WHITE  NO-LABEL  FRAME frpdo1 VIEW-AS DIALOG-BOX  TITLE "Process ... " . 

        PUT STREAM  filebill1
       
            "D"          FORMAT "X"          /* 1.  1 -   1 */
            wbill.cust_name    FORMAT "X(60)"      /* 2.  2 - 61 */
            wbill.nor_policy     FORMAT "X(26)"      /* 3. 62 - 87 */
            wbill.comp_policy FORMAT "X(26)"      /* 4. 88 - 113 */                
                  
            engine                       format 'x(26)'
            chas                          format 'x(26)'
            wbill.contract         FORMAT "X(10)"       /* 7. 166 - 175   opnpol*/
            engc                          format 'x(12)'
                 
            wbill.start_date      FORMAT "99999999" /* 9. 188 - 195 comdat*/

            fuDeciToChar(wbill.nor_grp,10)            FORMAT "X(10)"   /* 10. 196 - 205  "9999999999" GP*/
            fuDeciToChar(wbill.comp_grp,10)        FORMAT "X(10)"   /* 11. 206 - 215 compGP*/
            fuDeciToChar(wbill.nor_netprm,10)      FORMAT "X(10)"   /* 12. 216 - 225  NP*/
            fuDeciToChar(wbill.comp_netprm,10)  FORMAT "X(10)"   /* 13. 226 - 235  compNP*/
            fuDeciToChar(wbill.whtax1,10)              FORMAT "X(10)"   /* 14. 236 - 245       12+13+stamp * 1% */
            fuDeciToChar(wbill.net_amount,10)      FORMAT "X(10)"   /* 15. 246 - 255      10-11-14 */
                  
            SKIP.
               
            vExpCount1= vExpCount1 + 1.

/*     END. /* IF AVAIL billing */ */

END.  /* for each wbill */
/*--------*/
 
   
       /* 3. Trailer */          
       PUT STREAM filebill1
               "T"      FORMAT "X"           /* 1 - 1 */
               STRING(vExpCount1 ,"99999")    FORMAT "X(5)" /* 2 - 6 */

               SKIP.
        OUTPUT STREAM filebill1 CLOSE.
            
        vBackUp =  fiFile-Name1 + "B".
    
        DOS SILENT  COPY VALUE(fiFile-Name1) VALUE(vBackUP) /Y  .   /* backup file exports */
*/                 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdo2 C-Win 
PROCEDURE pdo2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

/* A47-0325*/
/*------------------------- export to file *** before 30/11/01 file not comp ***-------------------------*/
OUTPUT STREAM filebill2 TO VALUE(fiFile-Name2).

/* 1. Header */
PUT STREAM filebill2
    "H" FORMAT "X"                                              /* 1 - 1 */
    "Safety Insurance Public Company Limited"  FORMAT "X(40)"   /* 2 - 41 */
    STRING(TODAY,"99999999")                   FORMAT "X(8)"    /* 42 - 49 */
    STRING(n_asdat,"99999999")                 FORMAT "X(12)"   /* 50 - 61 */
    SKIP.

vExpCount2 = 0.

/*------ A49-0002 ------*/
/* 2. detail*/
loop1:
FOR EACH wBill  USE-INDEX wBill03 WHERE
         wBill.wcomdat >= n_comdatF AND
         wBill.wnorpol <> " "       AND
        (wBill.wpol72   = " "       AND
         wBill.wpoltyp  = "V70")
        /*---
       ((wBill.comp_policy <> " ") OR     /* ได้ 7070, 7072, 72 เบี้ยใหญ่ + พรบ. */
        (wBill.comp_policy  = " "  AND
         wBill.poltyp       = "V72"))
         ---*/
    BREAK BY wBill.wcomdat
          BY wBill.wnorpol :
/*------ END A49-0002 ------*/
/*------ A49-0002 ------
/* 2. detail*/
loop1:
FOR EACH wbill USE-INDEX wbill02 WHERE
         wbill.wtrndat  = nv_exportdat  AND
         wbill.wasdat   = n_asdat       AND
 (LOOKUP(wbill.wacno,nv_acnoAll) <> 0 ) AND /* A46-0426*/
       ((wbill.wpol72   = ''            AND /*  ได้ 70 เบี้ยใหญ่ */
         wbill.wpoltyp <> "V72"))       AND /*  A47-0263 */
        (wbill.wcomdat >= n_comdatF     AND
         wbill.wcomdat <= n_comdatT)

    BREAK BY wbill.wcomdat
          BY wbill.wNorpol :

    FIND billing WHERE RECID(billing) = wbill.wrecid NO-ERROR.
    IF AVAIL billing THEN DO:

        IF wBill.wnor_netprm + wBill.wcomp_netprm = 0 THEN NEXT loop1.  /* เบี้ยเป็น 0 แต่ยังค้างค่า comm. bal <> 0*/
        ASSIGN
            n_netloc = 0      y1 = 0         z1 = 0     sum = 0
            p_trnty  = ''     p_policy = ''.

        FOR EACH acd001 USE-INDEX acd00191 WHERE
                 acd001.trnty1 = wBill.wtrnty1 AND
                 acd001.docno  = wBill.wdocno  NO-LOCK:
            
            IF acd001.ctrty1 = 'y' THEN y1 = -(acd001.netloc).
            IF acd001.ctrty1 = 'z' THEN z1 = -(acd001.netloc).

            sum      = y1 + z1.
            n_netloc = n_netloc + acd001.netloc.
            p_trnty  = wBill.wtrnty1 + wBill.wtrnty2.

        END.      /*acd001*/
------ END A49-0002 ------*/
/*p---              
         FIND FIRST agtprm_fil WHERE agtprm_fil.asdat   = n_asdat           AND
                                                                agtprm_fil.acno    = wBill.wacno1   AND
                                                                agtprm_fil.policy  = wBill.wpolicy          AND
                                                                agtprm_fil.trnty     = p_trnty             AND
                                                                agtprm_fil.docno = wBill.wdocno
                    NO-LOCK NO-ERROR NO-WAIT.
         IF AVAIL agtprm_fil THEN DO:             
             IF agtprm_fil.bal - (y1 + z1) <= wBill.wwhtax1 THEN DO:
                  wBill.werror = "E".
                  NEXT loop1.
             END.            
         END.   
      
         FIND FIRST agtprm_fil WHERE agtprm_fil.asdat   = n_asdat           AND
                                                                agtprm_fil.acno    = wBill.wacno1   AND
                                                                agtprm_fil.policy  = wBill.wpolicy          AND
                                                                agtprm_fil.trnty     = wBill.wtrnty1 + wBill.wtrnty2  AND
                                                                agtprm_fil.docno = wBill.wdocno
                    NO-LOCK NO-ERROR NO-WAIT.
         IF AVAIL agtprm_fil THEN DO:                    
             if  substr(trntyp , 1 , 1) = 'r' and agtprm_fil.bal <> 0 then next loop1.
             if  substr(trntyp , 1 , 1) = 'm' and agtprm_fil.bal < 0 then next loop1.         
         end.            
---p*/
        /*------ A49-0002 ------
/*p--------------*/
        IF wBill.wbal - (y1 + z1) <= wBill.wwhtax1 THEN DO:
            wBill.werror = "E".
            NEXT loop1.
        END.
        IF wBill.wtrnty1 = 'r' AND wBill.wbal <> 0 THEN NEXT loop1.
        IF wBill.wtrnty1 = 'm' AND wBill.wbal  < 0 THEN NEXT loop1.
/*--------------p*/
        ------ END A49-0002 ------*/
         
        n_veh = "".                          
        n_veh = wBill.wVehreg.

        IF SUBSTR(wBill.wVehreg,1,1) <> '/' THEN DO:
            RUN pdveh.
        END.
        ELSE DO:
            IF wBill.wVehreg <> '' THEN DO:
                nv_eng  = SUBSTR(wBill.wVehreg , 2 , LENGTH(wBill.wVehreg)).
                RUN pdNewVeh.
                engc    = nv_char.
                nv_eng  = ''.
                nv_char = ''.
            END.
            ELSE engc = ''.
        END.
          
        IF wBill.wengine <> "" THEN DO:
            nv_eng1 = wBill.wengine.
            RUN pdeng.
            engine   = nv_char1.
            nv_char1 = ''.
            nv_eng1  = ''.
        END.
        ELSE engine = ''.
             
        IF wBill.wcha_no <> "" THEN DO:
            nv_eng2  = wBill.wcha_no.
            RUN pdchas.
            chas = nv_char2.
            nv_char2 = ''.
            nv_eng2  = ''.
        END.
        ELSE chas = ''.
                  
        DISPLAY wBill.wacno  wBill.wcomdat  wBill.wpolicy  wBill.wtrnty1 wBill.wdocno FORMAT "X(10)" /* Benjaporn J. A60-0267 date 27/06/2017 */
            WITH COLOR BLACK/WHITE NO-LABEL FRAME frpdo2 VIEW-AS DIALOG-BOX TITLE "Process ... ".

        PUT STREAM  filebill2
            "D"             FORMAT "X"          /* 1.  1 -   1 */
            wBill.winsure   FORMAT "X(60)"      /* 2.  2 - 61 */
            wBill.wnorpol   FORMAT "X(26)"      /* 3. 62 - 87 */
            wBill.wpol72    FORMAT "X(26)"      /* 4. 88 - 113 */
            engine          FORMAT 'x(26)'
            chas            FORMAT 'x(26)'
            wBill.wcontract FORMAT "X(10)"       /* 7. 166 - 175   opnpol*/
            engc            FORMAT 'x(12)'
            wBill.wcomdat   FORMAT "99999999" /* 9. 188 - 195 comdat*/

            fuDeciToChar(wBill.wGrossPrem,10)     FORMAT "X(10)"   /* 10. 196 - 205  "9999999999" GP*/
            fuDeciToChar(wBill.wCompGrossPrem,10) FORMAT "X(10)"   /* 11. 206 - 215  compGP*/
            fuDeciToChar(wBill.wNetPrem,10)       FORMAT "X(10)"   /* 12. 216 - 225  NP*/
            fuDeciToChar(wBill.wCompNetPrem,10)   FORMAT "X(10)"   /* 13. 226 - 235  compNP*/
            fuDeciToChar(wBill.wtax,10)           FORMAT "X(10)"   /* 14. 236 - 245  12+13+stamp * 1% */
            fuDeciToChar(wBill.wNetPayment,10)    FORMAT "X(10)"   /* 15. 246 - 255  10-11-14 */
            SKIP.

        vExpCount2= vExpCount2 + 1.

    /*--- A49-0002 ---
    END. /* IF AVAIL billing */
    -- end a49-002 --*/
END.  /* for each wbill */
/*--------*/

/* 3. Trailer */
PUT STREAM filebill2
    "T"                        FORMAT "X"       /* 1 - 1 */
    STRING(vExpCount2,"99999") FORMAT "X(5)"    /* 2 - 6 */
    SKIP.

OUTPUT STREAM filebill2 CLOSE.

vBackUp =  fiFile-Name2 + "B".

DOS SILENT COPY VALUE(fiFile-Name2) VALUE(vBackUP) /Y .    /* backup file exports */
RUN pdo2_ex.  /*kridtiya i. A53-0167*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdo2-A470235 C-Win 
PROCEDURE pdo2-A470235 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*

/*------------------------- export to file *** before 30/11/01 file not comp ***-------------------------*/
OUTPUT STREAM filebill2 TO VALUE(fiFile-Name2).
/* 1. Header */
       PUT STREAM filebill2
              "H" FORMAT "X"                                                                              /* 1 -   1 */
              "Safety Insurance Public Company Limited"  FORMAT "X(40)"  /* 2 - 41 */
              STRING(TODAY,"99999999")                           FORMAT "X(8)"    /* 42 - 49 */
              STRING(n_asdat,"99999999")                          FORMAT "X(12)"   /* 50 - 61 */
              SKIP.
              
vExpCount2= 0.


/* 2. detail*/
loop1:
FOR EACH billing  USE-INDEX billing02 WHERE 
                                billing.trndat = nv_exportdat AND
                                billing.asdat = n_asdat          AND
                                (LOOKUP(billing.acno1,nv_acnoAll) <> 0 ) AND  /* A46-0426*/
                            /* A46-0426---
                               (billing.acno1 = fi_ac1              OR
                                billing.acno1 = fi_ac2              OR
                                billing.acno1 = fi_ac3              OR
                                billing.acno1 = fi_ac4              OR
                                billing.acno1 = fi_ac5              OR
                                billing.acno1 = fi_ac6              OR
                                billing.acno1 = fi_ac7              OR
                                billing.acno1 = fi_ac8              OR
                                billing.acno1 = fi_ac9              OR
                                billing.acno1 = fi_ac10  )       AND 
                            ---A46-0426*/
                        
                             ((billing.comp_policy  = ''         AND       /*  ได้ 70  ไม่มี พรบ. (comp_policy)  */
                               billing.poltyp            <> 'v72')) AND               
                              (billing.start_date     >= n_comdatF and
                               billing.start_date     <= n_comdatT)

    BREAK BY billing.start_date 
                BY  billing.nor_policy :

                                           
        IF billing.nor_netprm + billing.comp_netprm = 0 THEN NEXT loop1.  /* เบี้ยเป็น 0 แต่ยังค้างค่า comm. bal <> 0*/
    
         n_netloc = 0.      y1 = 0.         z1 = 0.     sum = 0.
         p_trnty    = ''.      p_policy = ''.

         FOR EACH acd001 USE-INDEX acd00191 WHERE 
                             acd001.trnty1  = billing.trnty1      AND
                             acd001.docno = billing.docno  NO-LOCK.
                             
                  n_netloc =  n_netloc + acd001.netloc.
                  IF acd001.ctrty1 = 'y' THEN   y1 = -(acd001.netloc).
                  IF acd001.ctrty1 = 'z' THEN   z1 = -(acd001.netloc).
                  sum         = y1 + z1.                         
                  p_trnty    = billing.trnty1 + billing.trnty2.          
         END.      /*acd001*/          
/*p---              
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
      
         FIND FIRST agtprm_fil WHERE agtprm_fil.asdat   = n_asdat           AND
                                                                agtprm_fil.acno    = billing.acno1   AND
                                                                agtprm_fil.policy  = billing.policy          AND
                                                                agtprm_fil.trnty     = billing.trnty1 + billing.trnty2  AND
                                                                agtprm_fil.docno = billing.docno
                    NO-LOCK NO-ERROR NO-WAIT.
         IF AVAIL agtprm_fil THEN DO:                    
             if  substr(trntyp , 1 , 1) = 'r' and agtprm_fil.bal <> 0 then next loop1.
             if  substr(trntyp , 1 , 1) = 'm' and agtprm_fil.bal < 0 then next loop1.         
         end.            
---p*/
/*p--------------*/
             IF billing.bal - (y1 + z1) <= billing.whtax1 THEN DO:
                  billing.error = "E".
                  NEXT loop1.
             END. 
             if  billing.trnty1 =  'r'   and billing.bal <> 0 then next loop1.
             if  billing.trnty1 =  'm' and billing.bal < 0   then next loop1.        
/*--------------p*/
         
         n_veh = "".                          
         n_veh = billing.vehreg.
         IF SUBSTR(billing.vehreg,1,1) <> '/' THEN DO:        
              RUN pdveh.
         END.                          
         ELSE DO:
             IF billing.vehreg <> '' THEN DO:
                 nv_eng   = substr(billing.vehreg  , 2 , length(billing.vehreg)).                                 
                 RUN pdNewVeh.                   
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
                  
        DISP
            billing.acno  billing.start_date  billing.policy  billing.trnty1 billing.docno
        WITH COLOR BLACK/WHITE  NO-LABEL  FRAME frpdo2 VIEW-AS DIALOG-BOX  TITLE "Process ... " . 


        PUT STREAM  filebill2
       
            "D"          FORMAT "X"          /* 1.  1 -   1 */
            billing.cust_name    FORMAT "X(60)"      /* 2.  2 - 61 */
            billing.nor_policy     FORMAT "X(26)"      /* 3. 62 - 87 */
            billing.comp_policy FORMAT "X(26)"      /* 4. 88 - 113 */                
                  
            engine                       format 'x(26)'
            chas                          format 'x(26)'
            billing.contract         FORMAT "X(10)"       /* 7. 166 - 175   opnpol*/
            engc                          format 'x(12)'
                 
            billing.start_date      FORMAT "99999999" /* 9. 188 - 195 comdat*/

            fuDeciToChar(billing.nor_grp,10)            FORMAT "X(10)"   /* 10. 196 - 205  "9999999999" GP*/
            fuDeciToChar(billing.comp_grp,10)        FORMAT "X(10)"   /* 11. 206 - 215 compGP*/
            fuDeciToChar(billing.nor_netprm,10)      FORMAT "X(10)"   /* 12. 216 - 225  NP*/
            fuDeciToChar(billing.comp_netprm,10)  FORMAT "X(10)"   /* 13. 226 - 235  compNP*/
            fuDeciToChar(billing.whtax1,10)              FORMAT "X(10)"   /* 14. 236 - 245       12+13+stamp * 1% */
            fuDeciToChar(billing.net_amount,10)      FORMAT "X(10)"   /* 15. 246 - 255      10-11-14 */
                  
            SKIP.
                
             vExpCount2= vExpCount2 + 1.

END.  /* for each Billing*/
/*--------*/
 
   
       /* 3. Trailer */          
       PUT STREAM filebill2
               "T"      FORMAT "X"           /* 1 - 1 */
               STRING(vExpCount2 , "99999")    FORMAT "X(5)" /* 2 - 6 */

               SKIP.
        OUTPUT STREAM filebill2 CLOSE.
            
        vBackUp =  fiFile-Name2 + "B".
    
        DOS SILENT  COPY VALUE(fiFile-Name2) VALUE(vBackUP) /Y  .   /* backup file exports */
*/
              
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdo2-A490002 C-Win 
PROCEDURE pdo2-A490002 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

/*---- A49-0002 ----
/* A47-0325*/
/*------------------------- export to file *** before 30/11/01 file not comp ***-------------------------*/
OUTPUT STREAM filebill2 TO VALUE(fiFile-Name2).

/* 1. Header */
PUT STREAM filebill2
    "H" FORMAT "X"                                              /* 1 - 1 */
    "Safety Insurance Public Company Limited"  FORMAT "X(40)"   /* 2 - 41 */
    STRING(TODAY,"99999999")                   FORMAT "X(8)"    /* 42 - 49 */
    STRING(n_asdat,"99999999")                 FORMAT "X(12)"   /* 50 - 61 */
    SKIP.

vExpCount2 = 0.

/*------ A49-0002 ------*/
/* 2. detail*/
loop1:
FOR EACH billing  USE-INDEX billing02 WHERE
         billing.trndat  = nv_exportdat AND /* Today */
         billing.asdat   = n_asdat      AND /* Asdate Statement */
        (billing.comp_policy  = ''      AND /*  ได้ 70 เบี้ยใหญ่ */
         billing.poltyp       = "V70")

    BREAK BY billing.start_date /* comdat */
          BY billing.nor_policy :
/*------ END A49-0002 ------*/
/*------ A49-0002 ------
/* 2. detail*/
loop1:
FOR EACH wbill USE-INDEX wbill02 WHERE
         wbill.wtrndat  = nv_exportdat  AND
         wbill.wasdat   = n_asdat       AND
 (LOOKUP(wbill.wacno,nv_acnoAll) <> 0 ) AND /* A46-0426*/
       ((wbill.wpol72   = ''            AND /*  ได้ 70 เบี้ยใหญ่ */
         wbill.wpoltyp <> "V72"))       AND /*  A47-0263 */
        (wbill.wcomdat >= n_comdatF     AND
         wbill.wcomdat <= n_comdatT)

    BREAK BY wbill.wcomdat
          BY wbill.wNorpol :

    FIND billing WHERE RECID(billing) = wbill.wrecid NO-ERROR.
    IF AVAIL billing THEN DO:

        IF billing.nor_netprm + billing.comp_netprm = 0 THEN NEXT loop1.  /* เบี้ยเป็น 0 แต่ยังค้างค่า comm. bal <> 0*/
        ASSIGN
            n_netloc = 0      y1 = 0         z1 = 0     sum = 0
            p_trnty  = ''     p_policy = ''.

        FOR EACH acd001 USE-INDEX acd00191 WHERE
                 acd001.trnty1 = billing.trnty1 AND
                 acd001.docno  = billing.docno  NO-LOCK:
            
            IF acd001.ctrty1 = 'y' THEN y1 = -(acd001.netloc).
            IF acd001.ctrty1 = 'z' THEN z1 = -(acd001.netloc).

            sum      = y1 + z1.
            n_netloc = n_netloc + acd001.netloc.
            p_trnty  = billing.trnty1 + billing.trnty2.

        END.      /*acd001*/
------ END A49-0002 ------*/
/*p---              
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
      
         FIND FIRST agtprm_fil WHERE agtprm_fil.asdat   = n_asdat           AND
                                                                agtprm_fil.acno    = billing.acno1   AND
                                                                agtprm_fil.policy  = billing.policy          AND
                                                                agtprm_fil.trnty     = billing.trnty1 + billing.trnty2  AND
                                                                agtprm_fil.docno = billing.docno
                    NO-LOCK NO-ERROR NO-WAIT.
         IF AVAIL agtprm_fil THEN DO:                    
             if  substr(trntyp , 1 , 1) = 'r' and agtprm_fil.bal <> 0 then next loop1.
             if  substr(trntyp , 1 , 1) = 'm' and agtprm_fil.bal < 0 then next loop1.         
         end.            
---p*/
        /*------ A49-0002 ------
/*p--------------*/
        IF billing.bal - (y1 + z1) <= billing.whtax1 THEN DO:
            billing.error = "E".
            NEXT loop1.
        END.
        IF billing.trnty1 = 'r' AND billing.bal <> 0 THEN NEXT loop1.
        IF billing.trnty1 = 'm' AND billing.bal  < 0 THEN NEXT loop1.
/*--------------p*/
        ------ END A49-0002 ------*/
         
        n_veh = "".                          
        n_veh = billing.vehreg.

        IF SUBSTR(billing.vehreg,1,1) <> '/' THEN DO:
            RUN pdveh.
        END.
        ELSE DO:
            IF billing.vehreg <> '' THEN DO:
                nv_eng  = SUBSTR(billing.vehreg , 2 , LENGTH(billing.vehreg)).
                RUN pdNewVeh.
                engc    = nv_char.
                nv_eng  = ''.
                nv_char = ''.
            END.
            ELSE engc = ''.
        END.
          
        IF billing.engine <> "" THEN DO:
            nv_eng1 = billing.engine.
            RUN pdeng.
            engine   = nv_char1.
            nv_char1 = ''.
            nv_eng1  = ''.
        END.
        ELSE engine = ''.
             
        IF billing.chassis <> "" THEN DO:
            nv_eng2  = billing.chassis.
            RUN pdchas.
            chas = nv_char2.
            nv_char2 = ''.
            nv_eng2  = ''.
        END.
        ELSE chas = ''.
                  
        DISPLAY billing.acno  billing.start_date  billing.policy  billing.trnty1 billing.docno
            WITH COLOR BLACK/WHITE NO-LABEL FRAME frpdo2 VIEW-AS DIALOG-BOX TITLE "Process ... ".

        PUT STREAM  filebill2
            "D"                 FORMAT "X"          /* 1.  1 -   1 */
            billing.cust_name   FORMAT "X(60)"      /* 2.  2 - 61 */
            billing.nor_policy  FORMAT "X(26)"      /* 3. 62 - 87 */
            billing.comp_policy FORMAT "X(26)"      /* 4. 88 - 113 */

            engine              FORMAT 'x(26)'
            chas                FORMAT 'x(26)'
            billing.contract    FORMAT "X(10)"       /* 7. 166 - 175   opnpol*/
            engc                FORMAT 'x(12)'
                 
            billing.start_date  FORMAT "99999999" /* 9. 188 - 195 comdat*/

            fuDeciToChar(billing.nor_grp,10)      FORMAT "X(10)"   /* 10. 196 - 205  "9999999999" GP*/
            fuDeciToChar(billing.comp_grp,10)     FORMAT "X(10)"   /* 11. 206 - 215  compGP*/
            fuDeciToChar(billing.nor_netprm,10)   FORMAT "X(10)"   /* 12. 216 - 225  NP*/
            fuDeciToChar(billing.comp_netprm,10)  FORMAT "X(10)"   /* 13. 226 - 235  compNP*/
            fuDeciToChar(billing.whtax1,10)       FORMAT "X(10)"   /* 14. 236 - 245  12+13+stamp * 1% */
            fuDeciToChar(billing.net_amount,10)   FORMAT "X(10)"   /* 15. 246 - 255  10-11-14 */
            SKIP.

        vExpCount2= vExpCount2 + 1.

    /*--- A49-0002 ---
    END. /* IF AVAIL billing */
    -- end a49-002 --*/
END.  /* for each wbill */
/*--------*/

/* 3. Trailer */
PUT STREAM filebill2
    "T"                        FORMAT "X"       /* 1 - 1 */
    STRING(vExpCount2,"99999") FORMAT "X(5)"    /* 2 - 6 */
    SKIP.

OUTPUT STREAM filebill2 CLOSE.

vBackUp =  fiFile-Name2 + "B".

DOS SILENT COPY VALUE(fiFile-Name2) VALUE(vBackUP) /Y .    /* backup file exports */
---- A49-0002 ----*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdo2-A490002-old C-Win 
PROCEDURE pdo2-A490002-old :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

/*----- A49-0002 ------
/* A47-0325*/
/*------------------------- export to file *** before 30/11/01 file not comp ***-------------------------*/
OUTPUT STREAM filebill2 TO VALUE(fiFile-Name2).

/* 1. Header */
PUT STREAM filebill2
    "H" FORMAT "X"                                              /* 1 - 1 */
    "Safety Insurance Public Company Limited"  FORMAT "X(40)"   /* 2 - 41 */
    STRING(TODAY,"99999999")                   FORMAT "X(8)"    /* 42 - 49 */
    STRING(n_asdat,"99999999")                 FORMAT "X(12)"   /* 50 - 61 */
    SKIP.

vExpCount2 = 0.

/* 2. detail*/
loop1:
FOR EACH wbill USE-INDEX wbill02 WHERE
         wbill.wtrndat  = nv_exportdat  AND
         wbill.wasdat   = n_asdat       AND
 (LOOKUP(wbill.wacno,nv_acnoAll) <> 0 ) AND /* A46-0426*/
       ((wbill.wpol72   = ''            AND /*  ได้ 70 เบี้ยใหญ่ */
         wbill.wpoltyp <> "v72"))       AND /*  A47-0263 */
        (wbill.wcomdat >= n_comdatF     AND
         wbill.wcomdat <= n_comdatT)

    BREAK BY wbill.wcomdat
          BY wbill.wNorpol :

    FIND billing WHERE RECID(billing) = wbill.wrecid NO-ERROR.
    IF AVAIL billing THEN DO:

        IF billing.nor_netprm + billing.comp_netprm = 0 THEN NEXT loop1.  /* เบี้ยเป็น 0 แต่ยังค้างค่า comm. bal <> 0*/
        ASSIGN
            n_netloc = 0      y1 = 0         z1 = 0     sum = 0
            p_trnty  = ''     p_policy = ''.

        FOR EACH acd001 USE-INDEX acd00191 WHERE
                 acd001.trnty1 = billing.trnty1 AND
                 acd001.docno  = billing.docno  NO-LOCK:
            
            IF acd001.ctrty1 = 'y' THEN y1 = -(acd001.netloc).
            IF acd001.ctrty1 = 'z' THEN z1 = -(acd001.netloc).

            sum      = y1 + z1.
            n_netloc = n_netloc + acd001.netloc.
            p_trnty  = billing.trnty1 + billing.trnty2.

        END.      /*acd001*/
/*p---              
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
      
         FIND FIRST agtprm_fil WHERE agtprm_fil.asdat   = n_asdat           AND
                                                                agtprm_fil.acno    = billing.acno1   AND
                                                                agtprm_fil.policy  = billing.policy          AND
                                                                agtprm_fil.trnty     = billing.trnty1 + billing.trnty2  AND
                                                                agtprm_fil.docno = billing.docno
                    NO-LOCK NO-ERROR NO-WAIT.
         IF AVAIL agtprm_fil THEN DO:                    
             if  substr(trntyp , 1 , 1) = 'r' and agtprm_fil.bal <> 0 then next loop1.
             if  substr(trntyp , 1 , 1) = 'm' and agtprm_fil.bal < 0 then next loop1.         
         end.            
---p*/
/*p--------------*/
        IF billing.bal - (y1 + z1) <= billing.whtax1 THEN DO:
            billing.error = "E".
            NEXT loop1.
        END.
        IF billing.trnty1 = 'r' AND billing.bal <> 0 THEN NEXT loop1.
        IF billing.trnty1 = 'm' AND billing.bal  < 0 THEN NEXT loop1.
/*--------------p*/
         
        n_veh = "".                          
        n_veh = billing.vehreg.

        IF SUBSTR(billing.vehreg,1,1) <> '/' THEN DO:
            RUN pdveh.
        END.
        ELSE DO:
            IF billing.vehreg <> '' THEN DO:
                nv_eng  = SUBSTR(billing.vehreg , 2 , LENGTH(billing.vehreg)).
                RUN pdNewVeh.
                engc    = nv_char.
                nv_eng  = ''.
                nv_char = ''.
            END.
            ELSE engc = ''.
        END.
          
        IF billing.engine <> "" THEN DO:
            nv_eng1 = billing.engine.
            RUN pdeng.
            engine   = nv_char1.
            nv_char1 = ''.
            nv_eng1  = ''.
        END.
        ELSE engine = ''.
             
        IF billing.chassis <> "" THEN DO:
            nv_eng2  = billing.chassis.
            RUN pdchas.
            chas = nv_char2.
            nv_char2 = ''.
            nv_eng2  = ''.
        END.
        ELSE chas = ''.
                  
        DISPLAY billing.acno  billing.start_date  billing.policy  billing.trnty1 billing.docno
            WITH COLOR BLACK/WHITE NO-LABEL FRAME frpdo2 VIEW-AS DIALOG-BOX TITLE "Process ... ".

        PUT STREAM  filebill2
            "D"                 FORMAT "X"          /* 1.  1 -   1 */
            billing.cust_name   FORMAT "X(60)"      /* 2.  2 - 61 */
            billing.nor_policy  FORMAT "X(26)"      /* 3. 62 - 87 */
            billing.comp_policy FORMAT "X(26)"      /* 4. 88 - 113 */

            engine              FORMAT 'x(26)'
            chas                FORMAT 'x(26)'
            billing.contract    FORMAT "X(10)"       /* 7. 166 - 175   opnpol*/
            engc                FORMAT 'x(12)'
                 
            billing.start_date  FORMAT "99999999" /* 9. 188 - 195 comdat*/

            fuDeciToChar(billing.nor_grp,10)      FORMAT "X(10)"   /* 10. 196 - 205  "9999999999" GP*/
            fuDeciToChar(billing.comp_grp,10)     FORMAT "X(10)"   /* 11. 206 - 215  compGP*/
            fuDeciToChar(billing.nor_netprm,10)   FORMAT "X(10)"   /* 12. 216 - 225  NP*/
            fuDeciToChar(billing.comp_netprm,10)  FORMAT "X(10)"   /* 13. 226 - 235  compNP*/
            fuDeciToChar(billing.whtax1,10)       FORMAT "X(10)"   /* 14. 236 - 245  12+13+stamp * 1% */
            fuDeciToChar(billing.net_amount,10)   FORMAT "X(10)"   /* 15. 246 - 255  10-11-14 */
            SKIP.

        vExpCount2= vExpCount2 + 1.

    END. /* IF AVAIL billing */
END.  /* for each wbill */
/*--------*/

/* 3. Trailer */
PUT STREAM filebill2
    "T"                        FORMAT "X"       /* 1 - 1 */
    STRING(vExpCount2,"99999") FORMAT "X(5)"    /* 2 - 6 */
    SKIP.

OUTPUT STREAM filebill2 CLOSE.

vBackUp =  fiFile-Name2 + "B".

DOS SILENT COPY VALUE(fiFile-Name2) VALUE(vBackUP) /Y .    /* backup file exports */
----- A49-0002 ------*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdo2_2 C-Win 
PROCEDURE pdo2_2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*------------------------- export to file *** before 30/11/01 file not comp ***-------------------------*/
OUTPUT STREAM filebill2 TO VALUE(fiFile-Name2).
/* 1. Header */
PUT STREAM filebill2
    "H" FORMAT "X"                                              /* 1 - 1 */
    "Safety Insurance Public Company Limited"  FORMAT "X(40)"   /* 2 - 41 */
    STRING(TODAY,"99999999")                   FORMAT "X(8)"    /* 42 - 49 */
    STRING(n_asdat,"99999999")                 FORMAT "X(12)"   /* 50 - 61 */
    SKIP.
vExpCount2 = 0.
/* 2. detail*/
loop1:
FOR EACH wBill  USE-INDEX wBill03 WHERE
         wBill.wtrndat1  >= n_comdatF AND
         wBill.wnorpol   <> " "         AND
        (wBill.wpol72    = " "          AND
         wBill.wpoltyp   = "V70")
    BREAK BY wBill.wcomdat
          BY wBill.wnorpol :
    n_veh = "".                          
    n_veh = wBill.wVehreg.
    IF SUBSTR(wBill.wVehreg,1,1) <> '/' THEN DO:
        RUN pdveh.
    END.
    ELSE DO:
        IF wBill.wVehreg <> '' THEN DO:
            nv_eng  = SUBSTR(wBill.wVehreg , 2 , LENGTH(wBill.wVehreg)).
            RUN pdNewVeh.
            engc    = nv_char.
            nv_eng  = ''.
            nv_char = ''.
        END.
        ELSE engc = ''.
    END.
    IF wBill.wengine <> "" THEN DO:
        nv_eng1 = wBill.wengine.
        RUN pdeng.
        engine   = nv_char1.
        nv_char1 = ''.
        nv_eng1  = ''.
    END.
    ELSE engine = ''.
    IF wBill.wcha_no <> "" THEN DO:
        nv_eng2  = wBill.wcha_no.
        RUN pdchas.
        chas = nv_char2.
        nv_char2 = ''.
        nv_eng2  = ''.
    END.
    ELSE chas = ''.
    DISPLAY wBill.wacno  wBill.wcomdat  wBill.wpolicy  wBill.wtrnty1 wBill.wdocno FORMAT "X(10)" /* Benjaporn J. A60-0267 date 27/06/2017 */
        WITH COLOR BLACK/WHITE NO-LABEL FRAME frpdo2 VIEW-AS DIALOG-BOX TITLE "Process ... ".
    PUT STREAM  filebill2
        "D"             FORMAT "X"          /* 1.  1 -   1 */
        wBill.winsure   FORMAT "X(60)"      /* 2.  2 - 61 */
        wBill.wnorpol   FORMAT "X(26)"      /* 3. 62 - 87 */
        wBill.wpol72    FORMAT "X(26)"      /* 4. 88 - 113 */
        engine          FORMAT 'x(26)'
        chas            FORMAT 'x(26)'
        wBill.wcontract FORMAT "X(10)"       /* 7. 166 - 175   opnpol*/
        engc            FORMAT 'x(12)'
        wBill.wcomdat   FORMAT "99999999" /* 9. 188 - 195 comdat*/
        
        fuDeciToChar(wBill.wGrossPrem,10)     FORMAT "X(10)"   /* 10. 196 - 205  "9999999999" GP*/
        fuDeciToChar(wBill.wCompGrossPrem,10) FORMAT "X(10)"   /* 11. 206 - 215  compGP*/
        fuDeciToChar(wBill.wNetPrem,10)       FORMAT "X(10)"   /* 12. 216 - 225  NP*/
        fuDeciToChar(wBill.wCompNetPrem,10)   FORMAT "X(10)"   /* 13. 226 - 235  compNP*/
        fuDeciToChar(wBill.wtax,10)           FORMAT "X(10)"   /* 14. 236 - 245  12+13+stamp * 1% */
        fuDeciToChar(wBill.wNetPayment,10)    FORMAT "X(10)"   /* 15. 246 - 255  10-11-14 */
        SKIP.
    vExpCount2= vExpCount2 + 1.
END.  /* for each wbill */
/* 3. Trailer */
PUT STREAM filebill2
    "T"                        FORMAT "X"       /* 1 - 1 */
    STRING(vExpCount2,"99999") FORMAT "X(5)"    /* 2 - 6 */
    SKIP.

OUTPUT STREAM filebill2 CLOSE.

vBackUp =  fiFile-Name2 + "B".

DOS SILENT COPY VALUE(fiFile-Name2) VALUE(vBackUP) /Y .    /* backup file exports */
RUN pdo2_ex.  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdo2_ex C-Win 
PROCEDURE pdo2_ex :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

For each  wdetail:
    DELETE  wdetail.
END.
INPUT FROM VALUE (fiFile-Name2) .  /*create in TEMP-TABLE wImport*/
REPEAT:   
    IMPORT UNFORMATTED nv_daily.
    CREATE  wdetail.
    IF TRIM(SUBSTRING(nv_daily,1,1)) = "H" THEN 
        ASSIGN
        wdetail.head          = TRIM(SUBSTRING(nv_daily,1,1))     /*1*/           
        wdetail.insure        = TRIM(SUBSTRING(nv_daily,2,40))    /*2*/                        
        wdetail.policy        = TRIM(SUBSTRING(nv_daily,42,8))   /*3*/            
        wdetail.polcomp       = TRIM(SUBSTRING(nv_daily,50,12)) .  /*4*/   
    ELSE 
    ASSIGN
        wdetail.head          = TRIM(SUBSTRING(nv_daily,1,1))     /*1*/           
        wdetail.insure        = TRIM(SUBSTRING(nv_daily,2,60))    /*2*/                        
        wdetail.policy        = TRIM(SUBSTRING(nv_daily,62,26))   /*3*/            
        wdetail.polcomp       = TRIM(SUBSTRING(nv_daily,88,26))   /*4*/         
        wdetail.engine        = TRIM(SUBSTRING(nv_daily,114,26))  /*5*/         
        wdetail.chass         = TRIM(SUBSTRING(nv_daily,140,26))  /*6*/         
        wdetail.contract      = TRIM(SUBSTRING(nv_daily,166,10))  /*7*/         
        wdetail.engc          = TRIM(SUBSTRING(nv_daily,176,12))  /*8*/         
        wdetail.comdat        = string(TRIM(SUBSTRING(nv_daily,188,8)),"99999999")  /*9*/  
        wdetail.grossprem     = deci(TRIM(SUBSTRING(nv_daily,196,10))) / 100    /*10*/        
        wdetail.CompGrossPrem = deci(TRIM(SUBSTRING(nv_daily,206,10))) / 100      /*11*/        
        wdetail.NetPrem       = deci(TRIM(SUBSTRING(nv_daily,216,10))) / 100      /*12*/        
        wdetail.CompNetPrem   = deci(TRIM(SUBSTRING(nv_daily,226,10))) / 100      /*13*/        
        wdetail.tax           = deci(TRIM(SUBSTRING(nv_daily,236,10))) / 100      /*14*/        
        wdetail.NetPayment    = deci(TRIM(SUBSTRING(nv_daily,246,10))) / 100 .     /*15*/  
        
END.
If  substr(fiFile-Name2,length(fiFile-Name2) - 3,4) <>  ".csv"  Then
    fiFile-Name2  =  Trim(fiFile-Name2) + ".csv"  .

nv_cnt  =   0.
nv_row  =  1.

/*---- start A59-0362-----*/
/* OUTPUT STREAM ns2 TO VALUE(fiFile-Name2).  */
/*
PUT STREAM ns2 "ID;PND" SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"' " "   '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"' "TEXT FILE FROM HCT"   '"' SKIP.
nv_row  =  nv_row + 1.                                                  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"' "head         "  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"' "Insure Name  "  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"' "Policy       "  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"  '"' "Policy(V72)  "  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"' "Engine       "  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"  '"' "Chassis      "  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"  '"' "contract     "  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"  '"' "Engcc        "  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"  '"' "Comdat       "  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K" '"' "grossprem    "  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K" '"' "CompGrossPrem"  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K" '"' "NetPrem      "  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K" '"' "CompNetPrem  "  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K" '"' "Tax          "  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K" '"' "NetPayment   "  '"' SKIP.
for each wdetail  no-lock.  
    nv_cnt  =  nv_cnt  + 1.                     
    nv_row  =  nv_row + 1.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"'  wdetail.head            '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"'  wdetail.insure          '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"'  wdetail.policy          '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"  '"'  wdetail.polcomp         '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"'  wdetail.engine          '"' SKIP.       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"  '"'  wdetail.chass           '"' SKIP.       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"  '"'  wdetail.contract        '"' SKIP.       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"  '"'  wdetail.engc            '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"  '"'  wdetail.comdat          '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K"  '"' wdetail.grossprem       '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K"  '"' wdetail.CompGrossPrem   '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K"  '"' wdetail.NetPrem         '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K"  '"' wdetail.CompNetPrem     '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K"  '"' wdetail.tax             '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K"  '"' wdetail.NetPayment      '"' SKIP.
END.
PUT STREAM ns2 "E".*/
/*PUT STREAM ns2
 "head         "  ","    
 "Insure Name  "  ","    
 "Policy       "  ","    
 "Policy(V72)  "  ","    
 "Engine       "  ","    
 "Chassis      "  ","    
 "contract     "  ","    
 "Engcc        "  ","    
 "Comdat       "  ","    
 "grossprem    "  ","    
 "CompGrossPrem"  ","    
 "NetPrem      "  ","    
 "CompNetPrem  "  ","    
 "Tax          "  ","    
 "NetPayment   "  SKIP.
FOR each wdetail  no-lock.  
    nv_cnt  =  nv_cnt  + 1.                     
    nv_row  =  nv_row + 1.   
    PUT STREAM ns2  
    wdetail.head            ","
    wdetail.insure          ","
    wdetail.policy          ","
    wdetail.polcomp         ","
    wdetail.engine          "," 
    wdetail.chass           "," 
    wdetail.contract        "," 
    wdetail.engc            "," 
    wdetail.comdat          "," 
    wdetail.grossprem       "," 
    wdetail.CompGrossPrem   "," 
    wdetail.NetPrem         "," 
    wdetail.CompNetPrem     ","  
    wdetail.tax             ","  
    wdetail.NetPayment      SKIP.    
END.*/
/*-----End A59-0362-----*//*comment by Sarinya c.*/

/*--add by sarinya c. A59-0362*/
OUTPUT  TO VALUE(fiFile-Name2).
  EXPORT DELIMITER ","
   /* "head"  
    "Insure Name" 
    "Policy" 
    "Policy(V72)" 
    "Engine" 
    "Chassis" 
    "contract" 
    "Engcc" 
    "Comdat" 
    "grossprem" 
    "CompGrossPrem" 
    "NetPrem" 
    "CompNetPrem" 
    "Tax" 
    "NetPayment" .*/
    "Customer Name"
    "Voluntary Policy Number"
    "Compulsory Policy Number"
    "Engine"
    "Chassis"
    "TPIS Contract No."
    "Licence"
    "Effective Date"
    "Voluntary Gross Premium"
    "Compulsory Gross Premium"
    "Voluntary Net Premium"
    "Compulsory Net Premium"
    "W/H TAX 1%"
    "Net Payment"
    "Status" .
  FOR each wdetail  no-lock.  
      EXPORT DELIMITER ","
     
    /*wdetail.head  */          
    wdetail.insure          
    wdetail.policy          
    wdetail.polcomp         
    wdetail.engine          
    wdetail.chass           
    wdetail.contract        
    wdetail.engc            
    wdetail.comdat          
    wdetail.grossprem       
    wdetail.CompGrossPrem   
    wdetail.NetPrem         
    wdetail.CompNetPrem     
    wdetail.tax             
    wdetail.NetPayment  .   
END.
OUTPUT CLOSE.
/*add by sarinya c. A59-0362*/

OUTPUT STREAM ns2 CLOSE.

/*message "Export File  Complete"  view-as alert-box.*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdo3 C-Win 
PROCEDURE pdo3 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

/* A47-0235 ---*/
DEF BUFFER bfwBill FOR wBill.
DEF VAR v_comp_grp      AS DECI  FORMAT "->>,>>>,>>9.99".
DEF VAR v_comp_netprm   AS DECI  FORMAT "->>,>>>,>>9.99".
DEF VAR v_whtax1        AS DECI  FORMAT "->>,>>>,>>9.99".
DEF VAR v_net_amount    AS DECI  FORMAT "->>,>>>,>>9.99".

/*----------------------------- export to file *** since 01/12/01 file comp ***---------------------------*/
OUTPUT STREAM filebill1 TO VALUE(fiFile-Name1).

/* 1. Header */
PUT STREAM filebill1
    "H"                                        FORMAT "X"       /* 1 -  1 */
    "Safety Insurance Public Company Limited"  FORMAT "X(40)"   /* 2 - 41 */
    STRING(TODAY,"99999999")                   FORMAT "X(8)"    /* 42 - 49 */
    STRING(n_asdat,"99999999")                 FORMAT "X(12)"   /* 50 - 61 */
    SKIP.

vExpCount1= 0.
/*------ A49-0002 ------
loop1:
FOR EACH wbill  USE-INDEX wbill02 WHERE
         wbill.wtrndat  = nv_exportdat  AND
         wbill.wasdat   = n_asdat       AND                /* วันที่เรียกงาน */
 (LOOKUP(wbill.wacno,nv_acnoAll) <> 0 ) AND  /* A46-0426*/
      ( (wbill.wpol72  <> "")    OR                 /*  ได้ 7070, 7072,  72 เบี้ยใหญ่ +  พรบ.*/
        (wbill.wpol72   = ''     AND
         wbill.wpoltyp  = 'v72') )      AND
        (wbill.wcomdat >= n_comdatF     AND
         wbill.wcomdat <= n_comdatT)

    BREAK BY wbill.wcomdat
          BY wbill.wNorpol :
------ END A49-0002 ------*/

/* 2. detail*/

loop1:
FOR EACH wBill  USE-INDEX wBill03 WHERE
         wBill.wcomdat >= n_comdatF         /*A59-0362*/ /* AND  
         wBill.wnorpol <> " "       AND
         wBill.wpol72  <> " "           */ /* End Sarinya C. A59-0362*/
        /*---
       ((wBill.comp_policy <> " ") OR     /* ได้ 7070, 7072, 72 เบี้ยใหญ่ + พรบ. */
        (wBill.comp_policy  = " "  AND
         wBill.poltyp       = "V72"))
         ---*/
    BREAK BY wBill.wcomdat 
          BY wBill.wnorpol :  

    /*------ A49-0002 ------
/*     FIND wBill WHERE RECID(wBill) = wbill.wrecid NO-ERROR.  */   /* A48-0586 */
    FIND FIRST wBill USE-INDEX wBill02 WHERE
               wBill.trndat      = wbill.wtrndat AND
               wBill.policy      = wbill.wpolicy AND
               wBill.comp_policy = wbill.wpol72  NO-ERROR.
    IF AVAIL wBill THEN DO:

        IF SUBSTR(wBill.policy,7,2) = 'is' THEN NEXT loop1.    /*free compulsory dm7245isxxxx*/
        IF wBill.nor_netprm + wBill.comp_netprm = 0 THEN NEXT loop1.  /* เบี้ยเป็น 0 แต่ยังค้างค่า comm. bal <> 0*/
    
        ASSIGN
            n_netloc = 0      y1 = 0         z1 = 0     sum = 0
            p_trnty  = ''     p_policy = ''
    
        ASSIGN v_comp_grp     = 0
               v_comp_netprm  = 0
               v_whtax1       = 0
               v_net_amount   = 0
    ------ END A49-0002 ------*/
        
        /*------ A49-0002 ------
        FOR EACH acd001 USE-INDEX acd00191 WHERE
                 acd001.trnty1  = wBill.trnty1 AND
                 acd001.docno = wBill.docno    NO-LOCK:
            
            IF acd001.ctrty1 = 'y' THEN   y1 = -(acd001.netloc).
            IF acd001.ctrty1 = 'z' THEN   z1 = -(acd001.netloc).

            sum      = y1 + z1.
            n_netloc = n_netloc + acd001.netloc.
            p_trnty  = wBill.trnty1 + wBill.trnty2.
/*          p_policy = substr(wBill.policy,1,12).*/
        END.      /*acd001*/
        ------ END A49-0002 ------*/
/*p---
         FIND FIRST agtprm_fil WHERE agtprm_fil.asdat   = n_asdat           AND
                                                                agtprm_fil.acno    = wBill.acno1   AND
                                                                agtprm_fil.policy  = wBill.policy          AND
                                                                agtprm_fil.trnty     = p_trnty             AND
                                                                agtprm_fil.docno = wBill.docno
                    NO-LOCK NO-ERROR NO-WAIT.
         IF AVAIL agtprm_fil THEN DO:             
             IF agtprm_fil.bal - (y1 + z1) <= wBill.whtax1 THEN DO:
                  wBill.error = "E".
                  NEXT loop1.
             END.                 
         END.   

         FIND FIRST agtprm_fil WHERE agtprm_fil.asdat   = n_asdat           AND
                                                                agtprm_fil.acno    = wBill.acno1   AND
                                                                agtprm_fil.policy  = wBill.policy          AND
                                                                agtprm_fil.trnty     = wBill.trnty1 + wBill.trnty2  AND
                                                                agtprm_fil.docno = wBill.docno
                    NO-LOCK NO-ERROR NO-WAIT.
         IF AVAIL agtprm_fil THEN DO:                    
             if  substr(trntyp , 1 , 1) = 'r' and agtprm_fil.bal <> 0 then next loop1.
             if  substr(trntyp , 1 , 1) = 'm' and agtprm_fil.bal < 0 then next loop1.         
         end.               
---p*/                  
/*p--------------*/
        /*------ A49-0002 ------
        IF wBill.bal - (y1 + z1) <= wBill.whtax1 THEN DO:
            wBill.error = "E".
            NEXT loop1.
        END. 
/*              if  wBill.trnty1 =  'r' and wBill.bal <> 0 then next loop1. */
        IF wBill.trnty1 = 'r' THEN NEXT loop1.
        IF wBill.trnty1 = 'm' AND wBill.bal <= 0 THEN NEXT loop1.    /* ค้างค่า comm. */
        ------ END A49-0002 ------*/
/*--------------p*/
/* A46-0090 หา ก/ธ 72is 
        IF SUBSTR(wBill.comp_policy, 7,2) = 'is'   THEN DO:
            FIND FIRST bfwBill USE-INDEX wBill02 WHERE 
                                bfwBill.trndat    = nv_exportdat  AND
                                bfwBill.asdat     = wBill.asdat  AND
                                bfwBill.acno1     = wBill.acno1  AND 
                                bfwBill.policy    = SUBSTR(wBill.comp_policy,1,12) 
                    NO-LOCK NO-ERROR.
            IF AVAIL bfwBill THEN DO:
                ASSIGN
                    v_comp_grp     = bfwBill.comp_grp     + wBill.comp_grp
                    v_comp_netprm  = bfwBill.comp_netprm  + wBill.comp_netprm
                    v_whtax1       = bfwBill.whtax1       + wBill.whtax1
                    v_net_amount   = bfwBill.net_amount   + wBill.net_amount.
            END.
        END.
        ELSE DO:
            ASSIGN
                v_comp_grp     = wBill.comp_grp
                v_comp_netprm  = wBill.comp_netprm
                v_whtax1       = wBill.whtax1
                v_net_amount   = wBill.net_amount.
        END. /* if SUBSTR(wBill.comp_policy, 7,2) = 'is' */
A46-0090 -----*/
/* A46-0090 หา ก/ธ 72is ---*/
/*         IF SUBSTR(wBill.comp_policy,7,2) = "IS" THEN DO: */ /* A49-0002 */
            /* lek   -------------------------*/
            n_wh1c = 0.

            FIND FIRST agtprm_fil USE-INDEX by_acno WHERE
                       agtprm_fil.asdat  = wBill.wasdat AND  /* วันที่ statement process */
                       agtprm_fil.acno   = wBill.wacno  AND
                       agtprm_fil.poltyp = "V72"        AND
                       agtprm_fil.policy = SUBSTR(wBill.wpol72,1,12) 
            NO-LOCK NO-ERROR.
            IF AVAIL agtprm_fil THEN DO:
                ASSIGN
                    /*---- A49-0002 ----
                    v_comp_grp    = wBill.comp_grp    + agtprm_fil.gross
                    v_comp_netprm = wBill.comp_netprm + agtprm_fil.prem_comp
                    -- End A49-0002 --*/
                    /*-- A49-0002 --*/
                    wBill.wCompGrossPrem = wBill.wCompGrossPrem + agtprm_fil.gross.
                  /*  wBill.wCompNetPrem   = wBill.wCompNetPrem   + agtprm_fil.prem_comp.*/ /*Sarinya c. A59-0362*/
                    
                    /* End A49-0002 */

                IF wBill.wtax <> 0 THEN DO:
                    n_wh1c = (agtprm_fil.prem_comp + agtprm_fil.stamp) * 0.01.
                    wBill.wtax = wBill.wtax + n_wh1c.
                END.

                /*-- A49-0002 --
                v_net_amount = wBill.net_amount  + (agtprm_fil.gross - n_wh1c).   /* ยอดจ่ายรวม */
                - End A49-0002 -*/
                /*---- A49-0002 ----*/
/*                 wBill.total_prm  = wBill.total_prm  +  agtprm_fil.gross. */
                wBill.wnetpayment = wBill.wnetpayment + (agtprm_fil.gross - n_wh1c). /* ยอดจ่ายรวม */
                /*-- End A49-0002 --*/
            END.
            /* lek  end  ----------------------*/
/*         END.    /* if SUBSTR(wBill.comp_policy, 7,2) = 'is' */ */ /* A49-0002 */
        /*---- A49-0002 ----
        ELSE DO:
            ASSIGN
                v_comp_grp     = wBill.comp_grp
                v_comp_netprm  = wBill.comp_netprm
                v_whtax1       = wBill.whtax1
                v_net_amount   = wBill.net_amount.
        END.    /* if SUBSTR(wBill.comp_policy, 7,2) <>= 'is' */
        --- end A49-0002 ---*/
/*--- A46-0090 */

        n_veh = "".
        n_veh = wBill.wVehreg.

        IF SUBSTR(wBill.wVehreg,1,1) <> '/' THEN DO:
            RUN pdveh.
        END.
        ELSE DO:
            IF wBill.wVehreg <> '' THEN DO:
                nv_eng  = SUBSTR(wBill.wVehreg,2,LENGTH(wBill.wVehreg)).
                RUN pdNewVeh.
                /*engc = substr(wBill.vehreg,2,1) + nv_char.*/
                engc    = nv_char.
                nv_eng  = ''.
                nv_char = ''.
            END.
            ELSE engc   = ''.
        END.
          
        IF wBill.wengine <> "" THEN DO:
            nv_eng1 = wBill.wengine.
            RUN pdeng.
            engine = nv_char1.
            nv_char1 = ''.
            nv_eng1  = ''.
        END.         
        ELSE engine  = ''.

        IF wBill.wcha_no <> "" THEN DO:
            nv_eng2 = wBill.wcha_no.
            RUN pdchas.
            chas = nv_char2.
            nv_char2 = ''.
            nv_eng2  = ''.
        END.
        ELSE chas    = ''.

        DISPLAY
            wBill.wacno  wBill.wcomdat  wBill.wpolicy  wBill.wtrnty1 wBill.wdocno FORMAT "X(10)" /* Benjaporn J. A60-0267 date 27/06/2017 */
        WITH COLOR BLACK/WHITE  NO-LABEL  FRAME frpdo1 VIEW-AS DIALOG-BOX  TITLE "Process ... ".

        PUT STREAM  filebill1
/*            wbill.wrecid
 *             RECID(wBill)*/
            
            "D"             FORMAT "X"        /* 1.  1 -   1 */
            wBill.winsure   FORMAT "X(60)"    /* 2.  2 - 61 */
            wBill.wnorpol   FORMAT "X(26)"    /* 3. 62 - 87 */
            wBill.wpol72    FORMAT "X(26)"    /* 4. 88 - 113 */
            engine          FORMAT 'x(26)'    /* 5. 114 - 139 */         /* wBill.engine   FORMAT "X(26)" */
            chas            FORMAT 'x(26)'    /* 6. 140 - 165   cha_no*/ /* wBill.chassis  FORMAT "X(26)" */
            wBill.wcontract FORMAT "X(20)"    /* 7. 166 - 175   opnpol*/ /* FORMAT "X(10)" */
            engc            FORMAT 'x(12)'    /* 8. 166 - 175 */         /* wBill.vehreg   FORMAT "X(12)" */
            wBill.wcomdat   FORMAT "99999999" /* 9. 188 - 195 comdat*/

            fuDeciToChar(wBill.wgrossprem,10)     FORMAT "X(10)"   /* 10. 196 - 205  "9999999999" GP*/
            fuDeciToChar(wBill.wCompGrossPrem,10) FORMAT "X(10)"   /* 11. 206 - 215  compGP*/  /* wBill.comp_grp */
            fuDeciToChar(wBill.wNetPrem,10)       FORMAT "X(10)"   /* 12. 216 - 225  NP*/
            fuDeciToChar(wBill.wCompNetPrem,10)   FORMAT "X(10)"   /* 13. 226 - 235  compNP*/ /* wBill.comp_netprm*/
            fuDeciToChar(wBill.wtax,10)           FORMAT "X(10)"   /* 14. 236 - 245  12+13+stamp * 1% */  /* wBill.whtax1 */
            fuDeciToChar(wBill.wNetPayment,10)    FORMAT "X(10)"   /* 15. 246 - 255  10-11-14 */  /* wBill.net_amount */
            wBill.wname2    FORMAT "X(60)"   /* A59-0362 Sarinya c.*/  
            wBill.wvatcode  FORMAT "X(10)"  /* A59-0362 Sarinya c.*/  
                  
            SKIP.
/*p       vExpCount = wBill.recordno.  p*/
        vExpCount1= vExpCount1 + 1.

    /*---- A49-0002 ----
    END. /* IF AVAIL wBill */
    -- END A49-0002 --*/
END.  /* for each wbill */
/*--------*/

/* 3. Trailer */
PUT STREAM filebill1
    "T"                         FORMAT "X"      /* 1 - 1 */
    STRING(vExpCount1 ,"99999") FORMAT "X(5)"   /* 2 - 6 */
    SKIP.

OUTPUT STREAM filebill1 CLOSE.

vBackUp =  fiFile-Name1 + "B".

DOS SILENT COPY VALUE(fiFile-Name1) VALUE(vBackUP) /Y. /* backup file exports */
RUN pdo3_ex.   /*kridtiya i. A53-0167*/
                 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdo3-A460090 C-Win 
PROCEDURE pdo3-A460090 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

/* A47-0235 ---*/
DEF BUFFER bfbilling FOR billing.
DEF VAR v_comp_grp      AS DECI  FORMAT "->>,>>>,>>9.99".
DEF VAR v_comp_netprm   AS DECI  FORMAT "->>,>>>,>>9.99".
DEF VAR v_whtax1        AS DECI  FORMAT "->>,>>>,>>9.99".
DEF VAR v_net_amount    AS DECI  FORMAT "->>,>>>,>>9.99".

/*----------------------------- export to file *** since 01/12/01 file comp ***---------------------------*/
OUTPUT STREAM filebill1 TO VALUE(fiFile-Name1).

/* 1. Header */
PUT STREAM filebill1
    "H"                                        FORMAT "X"       /* 1 -  1 */
    "Safety Insurance Public Company Limited"  FORMAT "X(40)"   /* 2 - 41 */
    STRING(TODAY,"99999999")                   FORMAT "X(8)"    /* 42 - 49 */
    STRING(n_asdat,"99999999")                 FORMAT "X(12)"   /* 50 - 61 */
    SKIP.

vExpCount1= 0.
/*------ A49-0002 ------
loop1:
FOR EACH wbill  USE-INDEX wbill02 WHERE
         wbill.wtrndat  = nv_exportdat  AND
         wbill.wasdat   = n_asdat       AND                /* วันที่เรียกงาน */
 (LOOKUP(wbill.wacno,nv_acnoAll) <> 0 ) AND  /* A46-0426*/
      ( (wbill.wpol72  <> "")    OR                 /*  ได้ 7070, 7072,  72 เบี้ยใหญ่ +  พรบ.*/
        (wbill.wpol72   = ''     AND
         wbill.wpoltyp  = 'v72') )      AND
        (wbill.wcomdat >= n_comdatF     AND
         wbill.wcomdat <= n_comdatT)

    BREAK BY wbill.wcomdat
          BY wbill.wNorpol :
------ END A49-0002 ------*/

/* 2. detail*/
loop1:
FOR EACH billing  USE-INDEX billing02 WHERE
         billing.trndat  = nv_exportdat AND /* Today */
         billing.asdat   = n_asdat      AND /* Asdate Statement */
         billing.comp_policy <> " "     /* A49-0002 */
        /*---
       ((billing.comp_policy <> " ") OR     /* ได้ 7070, 7072, 72 เบี้ยใหญ่ + พรบ. */
        (billing.comp_policy  = " "  AND
         billing.poltyp       = "V72"))
         ---*/

    BREAK BY billing.start_date /* comdat */
          BY billing.nor_policy :

    /*------ A49-0002 ------
/*     FIND billing WHERE RECID(billing) = wbill.wrecid NO-ERROR.  */   /* A48-0586 */
    FIND FIRST billing USE-INDEX billing02 WHERE
               billing.trndat      = wbill.wtrndat AND
               billing.policy      = wbill.wpolicy AND
               billing.comp_policy = wbill.wpol72  NO-ERROR.
    IF AVAIL billing THEN DO:

        IF SUBSTR(billing.policy,7,2) = 'is' THEN NEXT loop1.    /*free compulsory dm7245isxxxx*/
        IF billing.nor_netprm + billing.comp_netprm = 0 THEN NEXT loop1.  /* เบี้ยเป็น 0 แต่ยังค้างค่า comm. bal <> 0*/
    
        ASSIGN
            n_netloc = 0      y1 = 0         z1 = 0     sum = 0
            p_trnty  = ''     p_policy = ''
    
        ASSIGN v_comp_grp     = 0
               v_comp_netprm  = 0
               v_whtax1       = 0
               v_net_amount   = 0
    ------ END A49-0002 ------*/
        
        /*------ A49-0002 ------
        FOR EACH acd001 USE-INDEX acd00191 WHERE
                 acd001.trnty1  = billing.trnty1 AND
                 acd001.docno = billing.docno    NO-LOCK:
            
            IF acd001.ctrty1 = 'y' THEN   y1 = -(acd001.netloc).
            IF acd001.ctrty1 = 'z' THEN   z1 = -(acd001.netloc).

            sum      = y1 + z1.
            n_netloc = n_netloc + acd001.netloc.
            p_trnty  = billing.trnty1 + billing.trnty2.
/*          p_policy = substr(billing.policy,1,12).*/
        END.      /*acd001*/
        ------ END A49-0002 ------*/
/*p---
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

         FIND FIRST agtprm_fil WHERE agtprm_fil.asdat   = n_asdat           AND
                                                                agtprm_fil.acno    = billing.acno1   AND
                                                                agtprm_fil.policy  = billing.policy          AND
                                                                agtprm_fil.trnty     = billing.trnty1 + billing.trnty2  AND
                                                                agtprm_fil.docno = billing.docno
                    NO-LOCK NO-ERROR NO-WAIT.
         IF AVAIL agtprm_fil THEN DO:                    
             if  substr(trntyp , 1 , 1) = 'r' and agtprm_fil.bal <> 0 then next loop1.
             if  substr(trntyp , 1 , 1) = 'm' and agtprm_fil.bal < 0 then next loop1.         
         end.               
---p*/                  
/*p--------------*/
        /*------ A49-0002 ------
        IF billing.bal - (y1 + z1) <= billing.whtax1 THEN DO:
            billing.error = "E".
            NEXT loop1.
        END. 
/*              if  billing.trnty1 =  'r' and billing.bal <> 0 then next loop1. */
        IF billing.trnty1 = 'r' THEN NEXT loop1.
        IF billing.trnty1 = 'm' AND billing.bal <= 0 THEN NEXT loop1.    /* ค้างค่า comm. */
        ------ END A49-0002 ------*/
/*--------------p*/
/* A46-0090 หา ก/ธ 72is 
        IF SUBSTR(billing.comp_policy, 7,2) = 'is'   THEN DO:
            FIND FIRST bfbilling USE-INDEX billing02 WHERE 
                                bfbilling.trndat    = nv_exportdat  AND
                                bfbilling.asdat     = billing.asdat  AND
                                bfbilling.acno1     = billing.acno1  AND 
                                bfbilling.policy    = SUBSTR(billing.comp_policy,1,12) 
                    NO-LOCK NO-ERROR.
            IF AVAIL bfbilling THEN DO:
                ASSIGN
                    v_comp_grp     = bfbilling.comp_grp     + billing.comp_grp
                    v_comp_netprm  = bfbilling.comp_netprm  + billing.comp_netprm
                    v_whtax1       = bfbilling.whtax1       + billing.whtax1
                    v_net_amount   = bfbilling.net_amount   + billing.net_amount.
            END.
        END.
        ELSE DO:
            ASSIGN
                v_comp_grp     = billing.comp_grp
                v_comp_netprm  = billing.comp_netprm
                v_whtax1       = billing.whtax1
                v_net_amount   = billing.net_amount.
        END. /* if SUBSTR(billing.comp_policy, 7,2) = 'is' */
A46-0090 -----*/
/* A46-0090 หา ก/ธ 72is ---*/
/*         IF SUBSTR(billing.comp_policy,7,2) = "IS" THEN DO: */ /* A49-0002 */
            /* lek   -------------------------*/
            n_wh1c = 0.

            FIND FIRST agtprm_fil USE-INDEX by_acno WHERE
                       agtprm_fil.asdat  = billing.asdat AND  /* วันที่ statement process */
                       agtprm_fil.acno   = billing.acno  AND
                       agtprm_fil.poltyp = "V72"         AND
                       agtprm_fil.policy = SUBSTR(billing.comp_policy,1,12) 
            NO-LOCK NO-ERROR.
            IF AVAIL agtprm_fil THEN DO:
                ASSIGN
                    /*---- A49-0002 ----
                    v_comp_grp    = billing.comp_grp    + agtprm_fil.gross
                    v_comp_netprm = billing.comp_netprm + agtprm_fil.prem_comp
                    -- End A49-0002 --*/
                    /*-- A49-0002 --*/
                    billing.comp_grp    = billing.comp_grp    + agtprm_fil.gross.
                    billing.comp_netprm = billing.comp_netprm + agtprm_fil.prem_comp.
                    /* End A49-0002 */

                IF billing.whtax1 <> 0 THEN DO:
                    n_wh1c = (agtprm_fil.prem_comp + agtprm_fil.stamp) * 0.01.
                    billing.whtax1 = billing.whtax1 + n_wh1c.
                END.

                /*-- A49-0002 --
                v_net_amount = billing.net_amount  + (agtprm_fil.gross - n_wh1c).   /* ยอดจ่ายรวม */
                - End A49-0002 -*/
                /*---- A49-0002 ----*/
                billing.total_prm  = billing.total_prm  +  agtprm_fil.gross.
                billing.net_amount = billing.net_amount + (agtprm_fil.gross - n_wh1c). /* ยอดจ่ายรวม */
                /*-- End A49-0002 --*/
            END.
            /* lek  end  ----------------------*/
/*         END.    /* if SUBSTR(billing.comp_policy, 7,2) = 'is' */ */ /* A49-0002 */
        /*---- A49-0002 ----
        ELSE DO:
            ASSIGN
                v_comp_grp     = billing.comp_grp
                v_comp_netprm  = billing.comp_netprm
                v_whtax1       = billing.whtax1
                v_net_amount   = billing.net_amount.
        END.    /* if SUBSTR(billing.comp_policy, 7,2) <>= 'is' */
        --- end A49-0002 ---*/
/*--- A46-0090 */

        n_veh = "".
        n_veh = billing.vehreg.

        IF SUBSTR(billing.vehreg,1,1) <> '/' THEN DO:
            RUN pdveh.      
        END.                          
        ELSE DO:
            IF billing.vehreg <> '' THEN DO:
                nv_eng  = SUBSTR(billing.vehreg,2,LENGTH(billing.vehreg)).
                RUN pdNewVeh.
                /*engc = substr(billing.vehreg,2,1) + nv_char.*/
                engc    = nv_char.
                nv_eng  = ''.
                nv_char = ''.
            END.
            ELSE engc   = ''.
        END.
          
        IF billing.engine <> "" THEN DO:
            nv_eng1 = billing.engine.
            RUN pdeng.
            engine = nv_char1.
            nv_char1 = ''.
            nv_eng1  = ''.
        END.         
        ELSE engine  = ''.

        IF billing.chassis <> "" THEN DO:
            nv_eng2 = billing.chassis.
            RUN pdchas.
            chas = nv_char2.
            nv_char2 = ''.
            nv_eng2  = ''.
        END.
        ELSE chas    = ''.

        DISPLAY
            billing.acno  billing.start_date  billing.policy  billing.trnty1 billing.docno FORMAT "X(10)" /* Benjaporn J. A60-0267 date 27/06/2017 */
        WITH COLOR BLACK/WHITE  NO-LABEL  FRAME frpdo1 VIEW-AS DIALOG-BOX  TITLE "Process ... ".

        PUT STREAM  filebill1
/*            wbill.wrecid
 *             RECID(billing)*/
            
            "D"                 FORMAT "X"          /* 1.  1 -   1 */
            billing.cust_name   FORMAT "X(60)"      /* 2.  2 - 61 */
            billing.nor_policy  FORMAT "X(26)"      /* 3. 62 - 87 */
            billing.comp_policy FORMAT "X(26)"      /* 4. 88 - 113 */
                                                    
            engine              FORMAT 'x(26)'      /* 5. 114 - 139 */         /* billing.engine   FORMAT "X(26)" */
            chas                FORMAT 'x(26)'      /* 6. 140 - 165   cha_no*/ /* billing.chassis  FORMAT "X(26)" */
                                                    
            billing.contract    FORMAT "X(10)"      /* 7. 166 - 175   opnpol*/
            engc                FORMAT 'x(12)'      /* 8. 166 - 175 */         /* billing.vehreg   FORMAT "X(12)" */
                                                    
            billing.start_date  FORMAT "99999999"   /* 9. 188 - 195 comdat*/

            fuDeciToChar(billing.nor_grp,10)     FORMAT "X(10)"   /* 10. 196 - 205  "9999999999" GP*/
            fuDeciToChar(billing.comp_grp,10)    FORMAT "X(10)"   /* 11. 206 - 215  compGP*/  /* billing.comp_grp */
            fuDeciToChar(billing.nor_netprm,10)  FORMAT "X(10)"   /* 12. 216 - 225  NP*/
            fuDeciToChar(billing.comp_netprm,10) FORMAT "X(10)"   /* 13. 226 - 235  compNP*/ /* billing.comp_netprm*/
            fuDeciToChar(billing.whtax1,10)      FORMAT "X(10)"   /* 14. 236 - 245  12+13+stamp * 1% */  /* billing.whtax1 */
            fuDeciToChar(billing.net_amount,10)  FORMAT "X(10)"   /* 15. 246 - 255  10-11-14 */  /* billing.net_amount */
                  
            SKIP.
/*p       vExpCount = billing.recordno.  p*/
        vExpCount1= vExpCount1 + 1.

    /*---- A49-0002 ----
    END. /* IF AVAIL billing */
    -- END A49-0002 --*/
END.  /* for each wbill */
/*--------*/

/* 3. Trailer */
PUT STREAM filebill1
    "T"                         FORMAT "X"      /* 1 - 1 */
    STRING(vExpCount1 ,"99999") FORMAT "X(5)"   /* 2 - 6 */
    SKIP.

OUTPUT STREAM filebill1 CLOSE.

vBackUp =  fiFile-Name1 + "B".

DOS SILENT COPY VALUE(fiFile-Name1) VALUE(vBackUP) /Y. /* backup file exports */
                 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdo3-A460090-old C-Win 
PROCEDURE pdo3-A460090-old :
/*------------------------------------------------------------------------------
  Purpose:     ย้ายการ find ข้อมูล จาก bill  ไปหาที่ wbill
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*
/* A46-0090 ---*/
DEF BUFFER bfbilling FOR  billing.
DEF VAR v_comp_grp  AS DECI  FORMAT "->>,>>>,>>9.99".
DEF VAR v_comp_netprm  AS DECI  FORMAT "->>,>>>,>>9.99".
DEF VAR v_whtax1        AS DECI  FORMAT "->>,>>>,>>9.99".
DEF VAR v_net_amount    AS DECI  FORMAT "->>,>>>,>>9.99".

/*----------------------------- export to file *** since 01/12/01 file comp ***---------------------------*/
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
                                            billing.acno1 = fi_ac10  )       AND 

                                         ((billing.comp_policy <> "")      OR            /*  ได้ 7070 , 72 */
                                          (billing.comp_policy  = ''         AND
                                           billing.poltyp             = 'v72')) AND
                                          (billing.start_date     >= n_comdatF and
                                           billing.start_date     <= n_comdatT)
                                           
                             BREAK BY billing.start_date by  billing.nor_policy:   
                           
        IF SUBSTR(billing.policy, 7,2) = 'is'  THEN  NEXT loop1.    /*free compulsory dm7245isxxxx*/
        IF billing.nor_netprm + billing.comp_netprm = 0 THEN NEXT loop1.  /* เบี้ยเป็น 0 แต่ยังค้างค่า comm. bal <> 0*/

         n_netloc = 0.      y1 = 0.         z1 = 0.     sum = 0.
         p_trnty    = ''.      p_policy = ''.

         FOR EACH acd001 USE-INDEX acd00191 WHERE 
                             acd001.trnty1  = billing.trnty1      AND
                             acd001.docno = billing.docno  NO-LOCK.
                             
                  n_netloc =  n_netloc + acd001.netloc.
                  IF acd001.ctrty1 = 'y' THEN   y1 = -(acd001.netloc).
                  IF acd001.ctrty1 = 'z' THEN   z1 = -(acd001.netloc).
                  sum         = y1 + z1.                         
                  p_trnty    = billing.trnty1 + billing.trnty2.          
/*                  p_policy = substr(billing.policy,1,12).*/
         END.      /*acd001*/          

/*p---
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

         FIND FIRST agtprm_fil WHERE agtprm_fil.asdat   = n_asdat           AND
                                                                agtprm_fil.acno    = billing.acno1   AND
                                                                agtprm_fil.policy  = billing.policy          AND
                                                                agtprm_fil.trnty     = billing.trnty1 + billing.trnty2  AND
                                                                agtprm_fil.docno = billing.docno
                    NO-LOCK NO-ERROR NO-WAIT.
         IF AVAIL agtprm_fil THEN DO:                    
             if  substr(trntyp , 1 , 1) = 'r' and agtprm_fil.bal <> 0 then next loop1.
             if  substr(trntyp , 1 , 1) = 'm' and agtprm_fil.bal < 0 then next loop1.         
         end.               
---p*/                  

/*p--------------*/             
            IF billing.bal - (y1 + z1) <= billing.whtax1 THEN DO:
                  billing.error = "E".
                  NEXT loop1.
             END. 
             if  billing.trnty1 =  'r'   and billing.bal <> 0 then next loop1.
             if  billing.trnty1 =  'm' and billing.bal < 0   then next loop1.        
/*--------------p*/
/* A46-0090 หา ก/ธ 72is ---*/
        IF SUBSTR(billing.comp_policy, 7,2) = 'is'   THEN DO:
            FIND FIRST bfbilling WHERE 
                                                bfbilling.trndat = nv_exportdat  AND
                                                bfbilling.asdat = billing.asdat    AND
                                                bfbilling.acno1 = billing.acno1   AND 
                                                bfbilling.policy  = SUBSTR(billing.comp_policy,1,12) 
                    NO-LOCK NO-ERROR.
            IF AVAIL bfbilling THEN DO:
                ASSIGN
                    v_comp_grp        = bfbilling.comp_grp + billing.comp_grp
                    v_comp_netprm  = bfbilling.comp_netprm + billing.comp_netprm
                    v_whtax1            = bfbilling.whtax1 + billing.whtax1
                    v_net_amount    = bfbilling.net_amount + billing.net_amount.
                    
            END.
        END.
        ELSE DO:
            ASSIGN
                v_comp_grp        = billing.comp_grp
                v_comp_netprm  = billing.comp_netprm
                v_whtax1         = billing.whtax1
                v_net_amount = billing.net_amount.
        
        END. /* if SUBSTR(billing.comp_policy, 7,2) = 'is' */
        
/*--- A46-0090 */

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
                  
            engine                       format 'x(26)'            /* 5. 114 - 139 */               /* billing.engine            FORMAT "X(26)" */
            chas                          format 'x(26)'            /* 6. 140 - 165   cha_no*/ /* billing.chassis          FORMAT "X(26)" */

            billing.contract         FORMAT "X(10)"     /* 7. 166 - 175   opnpol*/
            engc                          format 'x(12)'            /* 8. 166 - 175 */               /* billing.vehreg           FORMAT "X(12)" */
                
            billing.start_date      FORMAT "99999999" /* 9. 188 - 195 comdat*/

            fuDeciToChar(billing.nor_grp,10)         FORMAT "X(10)"   /* 10. 196 - 205  "9999999999" GP*/
            fuDeciToChar(v_comp_grp,10)             FORMAT "X(10)"   /* 11. 206 - 215 compGP*/  /* billing.comp_grp */
            fuDeciToChar(billing.nor_netprm,10)   FORMAT "X(10)"   /* 12. 216 - 225  NP*/
            fuDeciToChar(v_comp_netprm,10)       FORMAT "X(10)"   /* 13. 226 - 235  compNP*/ /* billing.comp_netprm*/
            fuDeciToChar(v_whtax1,10)                   FORMAT "X(10)"   /* 14. 236 - 245       12+13+stamp * 1% */  /* billing.whtax1 */
            fuDeciToChar(v_net_amount,10)           FORMAT "X(10)"   /* 15. 246 - 255      10-11-14 */  /* billing.net_amount */
                  
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
*/
                 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdo3-A470235 C-Win 
PROCEDURE pdo3-A470235 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*

/* A46-0090 ---*/
DEF BUFFER bfbilling FOR  billing.
DEF VAR v_comp_grp  AS DECI  FORMAT "->>,>>>,>>9.99".
DEF VAR v_comp_netprm  AS DECI  FORMAT "->>,>>>,>>9.99".
DEF VAR v_whtax1        AS DECI  FORMAT "->>,>>>,>>9.99".
DEF VAR v_net_amount    AS DECI  FORMAT "->>,>>>,>>9.99".

/*----------------------------- export to file *** since 01/12/01 file comp ***---------------------------*/
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
FOR EACH wbill  USE-INDEX wbill02  WHERE
                                wbill.wtrndat = nv_exportdat AND
                                wbill.wasdat = n_asdat          AND
                                (LOOKUP(wbill.wacno,nv_acnoAll) <> 0 ) AND  /* A46-0426*/
                            /* A46-0426---
                               (wbill.acno = fi_ac1              OR
                                wbill.acno = fi_ac2              OR
                                wbill.acno = fi_ac3              OR
                                wbill.acno = fi_ac4              OR
                                wbill.acno = fi_ac5              OR
                                wbill.acno = fi_ac6              OR
                                wbill.acno = fi_ac7              OR
                                wbill.acno = fi_ac8              OR
                                wbill.acno = fi_ac9              OR
                                wbill.acno = fi_ac10  )       AND 
                            ---A46-0426*/

                                ((wbill.wPol72 <> "")      OR            /*  ได้ 7070 , 72 */
                                 (wbill.wPol72  = ''         AND
                                  wbill.wpoltyp             = 'v72')) AND
                                 (wbill.wComdat     >= n_comdatF and
                                  wbill.wComdat     <= n_comdatT)

    BREAK  BY wbill.wComdat
                    BY wbill.wNorpol :

    FIND billing WHERE RECID(billing) = wbill.wrecid NO-ERROR.
    IF AVAIL billing THEN DO:
                      
        IF SUBSTR(billing.policy, 7,2) = 'is'  THEN  NEXT loop1.    /*free compulsory dm7245isxxxx*/
        IF billing.nor_netprm + billing.comp_netprm = 0 THEN NEXT loop1.  /* เบี้ยเป็น 0 แต่ยังค้างค่า comm. bal <> 0*/

         n_netloc = 0.      y1 = 0.         z1 = 0.     sum = 0.
         p_trnty    = ''.      p_policy = ''.

         FOR EACH acd001 USE-INDEX acd00191 WHERE 
                             acd001.trnty1  = billing.trnty1      AND
                             acd001.docno = billing.docno  NO-LOCK.
                             
                  n_netloc =  n_netloc + acd001.netloc.
                  IF acd001.ctrty1 = 'y' THEN   y1 = -(acd001.netloc).
                  IF acd001.ctrty1 = 'z' THEN   z1 = -(acd001.netloc).
                  sum         = y1 + z1.                         
                  p_trnty    = billing.trnty1 + billing.trnty2.          
/*                  p_policy = substr(billing.policy,1,12).*/
         END.      /*acd001*/

/*p---
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

         FIND FIRST agtprm_fil WHERE agtprm_fil.asdat   = n_asdat           AND
                                                                agtprm_fil.acno    = billing.acno1   AND
                                                                agtprm_fil.policy  = billing.policy          AND
                                                                agtprm_fil.trnty     = billing.trnty1 + billing.trnty2  AND
                                                                agtprm_fil.docno = billing.docno
                    NO-LOCK NO-ERROR NO-WAIT.
         IF AVAIL agtprm_fil THEN DO:                    
             if  substr(trntyp , 1 , 1) = 'r' and agtprm_fil.bal <> 0 then next loop1.
             if  substr(trntyp , 1 , 1) = 'm' and agtprm_fil.bal < 0 then next loop1.         
         end.               
---p*/                  

/*p--------------*/             
            IF billing.bal - (y1 + z1) <= billing.whtax1 THEN DO:
                  billing.error = "E".
                  NEXT loop1.
             END. 
             if  billing.trnty1 =  'r'   and billing.bal <> 0 then next loop1.
             if  billing.trnty1 =  'm' and billing.bal < 0   then next loop1.        
/*--------------p*/
/* A46-0090 หา ก/ธ 72is ---*/
        IF SUBSTR(billing.comp_policy, 7,2) = 'is'   THEN DO:
            FIND FIRST bfbilling USE-INDEX billing02 WHERE 
                                                bfbilling.trndat = nv_exportdat  AND
                                                bfbilling.asdat = billing.asdat    AND
                                                bfbilling.acno1 = billing.acno1   AND 
                                                bfbilling.policy  = SUBSTR(billing.comp_policy,1,12) 
                    NO-LOCK NO-ERROR.
            IF AVAIL bfbilling THEN DO:
                ASSIGN
                    v_comp_grp        = bfbilling.comp_grp + billing.comp_grp
                    v_comp_netprm  = bfbilling.comp_netprm + billing.comp_netprm
                    v_whtax1            = bfbilling.whtax1 + billing.whtax1
                    v_net_amount    = bfbilling.net_amount + billing.net_amount.
                    
            END.
        END.
        ELSE DO:
            ASSIGN
                v_comp_grp        = billing.comp_grp
                v_comp_netprm  = billing.comp_netprm
                v_whtax1         = billing.whtax1
                v_net_amount = billing.net_amount.
        
        END. /* if SUBSTR(billing.comp_policy, 7,2) = 'is' */
        
/*--- A46-0090 */

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

        DISP
            billing.acno  billing.start_date  billing.policy  billing.trnty1 billing.docno
        WITH COLOR BLACK/WHITE  NO-LABEL  FRAME frpdo1 VIEW-AS DIALOG-BOX  TITLE "Process ... " . 

        PUT STREAM  filebill1
/*            wbill.wrecid
 *             RECID(billing)*/
            
            "D"          FORMAT "X"          /* 1.  1 -   1 */
            billing.cust_name    FORMAT "X(60)"      /* 2.  2 - 61 */
            billing.nor_policy     FORMAT "X(26)"      /* 3. 62 - 87 */
            billing.comp_policy FORMAT "X(26)"      /* 4. 88 - 113 */                
                  
            engine                       format 'x(26)'            /* 5. 114 - 139 */               /* billing.engine            FORMAT "X(26)" */
            chas                          format 'x(26)'            /* 6. 140 - 165   cha_no*/ /* billing.chassis          FORMAT "X(26)" */

            billing.contract         FORMAT "X(10)"     /* 7. 166 - 175   opnpol*/
            engc                          format 'x(12)'            /* 8. 166 - 175 */               /* billing.vehreg           FORMAT "X(12)" */
                
            billing.start_date      FORMAT "99999999" /* 9. 188 - 195 comdat*/

            fuDeciToChar(billing.nor_grp,10)         FORMAT "X(10)"   /* 10. 196 - 205  "9999999999" GP*/
            fuDeciToChar(v_comp_grp,10)             FORMAT "X(10)"   /* 11. 206 - 215 compGP*/  /* billing.comp_grp */
            fuDeciToChar(billing.nor_netprm,10)   FORMAT "X(10)"   /* 12. 216 - 225  NP*/
            fuDeciToChar(v_comp_netprm,10)       FORMAT "X(10)"   /* 13. 226 - 235  compNP*/ /* billing.comp_netprm*/
            fuDeciToChar(v_whtax1,10)                   FORMAT "X(10)"   /* 14. 236 - 245       12+13+stamp * 1% */  /* billing.whtax1 */
            fuDeciToChar(v_net_amount,10)           FORMAT "X(10)"   /* 15. 246 - 255      10-11-14 */  /* billing.net_amount */
                  
            SKIP.
                
/*p       vExpCount = billing.recordno.  p*/
             vExpCount1= vExpCount1 + 1.

    END. /* IF AVAIL billing */
/*    RELEASE billing.*/

END.  /* for each wbill */
/*--------*/
 
   
       /* 3. Trailer */          
       PUT STREAM filebill1
               "T"      FORMAT "X"           /* 1 - 1 */
               STRING(vExpCount1 ,"99999")    FORMAT "X(5)" /* 2 - 6 */

               SKIP.
        OUTPUT STREAM filebill1 CLOSE.
            
        vBackUp =  fiFile-Name1 + "B".
    
        DOS SILENT  COPY VALUE(fiFile-Name1) VALUE(vBackUP) /Y  .   /* backup file exports */
*/
             
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdo3-A490002 C-Win 
PROCEDURE pdo3-A490002 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

/*---- A49-0002 ----
/* A47-0235 ---*/
DEF BUFFER bfbilling FOR billing.
DEF VAR v_comp_grp      AS DECI  FORMAT "->>,>>>,>>9.99".
DEF VAR v_comp_netprm   AS DECI  FORMAT "->>,>>>,>>9.99".
DEF VAR v_whtax1        AS DECI  FORMAT "->>,>>>,>>9.99".
DEF VAR v_net_amount    AS DECI  FORMAT "->>,>>>,>>9.99".

/*----------------------------- export to file *** since 01/12/01 file comp ***---------------------------*/
OUTPUT STREAM filebill1 TO VALUE(fiFile-Name1).

/* 1. Header */
PUT STREAM filebill1
    "H"                                        FORMAT "X"       /* 1 -  1 */
    "Safety Insurance Public Company Limited"  FORMAT "X(40)"   /* 2 - 41 */
    STRING(TODAY,"99999999")                   FORMAT "X(8)"    /* 42 - 49 */
    STRING(n_asdat,"99999999")                 FORMAT "X(12)"   /* 50 - 61 */
    SKIP.

vExpCount1= 0.

/* 2. detail*/
loop1:
FOR EACH wbill  USE-INDEX wbill02 WHERE
         wbill.wtrndat  = nv_exportdat  AND
         wbill.wasdat   = n_asdat       AND                /* วันที่เรียกงาน */
 (LOOKUP(wbill.wacno,nv_acnoAll) <> 0 ) AND  /* A46-0426*/
      ( (wbill.wpol72  <> "")    OR                 /*  ได้ 7070, 7072,  72 เบี้ยใหญ่ +  พรบ.*/
        (wbill.wpol72   = ''     AND
         wbill.wpoltyp  = 'v72') )      AND
        (wbill.wcomdat >= n_comdatF     AND
         wbill.wcomdat <= n_comdatT)

    BREAK BY wbill.wcomdat
          BY wbill.wNorpol :

/*     FIND billing WHERE RECID(billing) = wbill.wrecid NO-ERROR.  */   /* A48-0586 */
    FIND FIRST billing USE-INDEX billing02 WHERE
               billing.trndat      = wbill.wtrndat AND
               billing.policy      = wbill.wpolicy AND
               billing.comp_policy = wbill.wpol72  NO-ERROR.
    IF AVAIL billing THEN DO:
        
        IF SUBSTR(billing.policy,7,2) = 'is' THEN NEXT loop1.    /*free compulsory dm7245isxxxx*/
        IF billing.nor_netprm + billing.comp_netprm = 0 THEN NEXT loop1.  /* เบี้ยเป็น 0 แต่ยังค้างค่า comm. bal <> 0*/

        ASSIGN
            n_netloc = 0      y1 = 0         z1 = 0     sum = 0
            p_trnty  = ''     p_policy = ''
            v_comp_grp     = 0
            v_comp_netprm  = 0
            v_whtax1       = 0
            v_net_amount   = 0 .
        
        FOR EACH acd001 USE-INDEX acd00191 WHERE
                 acd001.trnty1  = billing.trnty1 AND
                 acd001.docno = billing.docno    NO-LOCK:
            
            IF acd001.ctrty1 = 'y' THEN   y1 = -(acd001.netloc).
            IF acd001.ctrty1 = 'z' THEN   z1 = -(acd001.netloc).

            sum      = y1 + z1.
            n_netloc = n_netloc + acd001.netloc.
            p_trnty  = billing.trnty1 + billing.trnty2.
/*          p_policy = substr(billing.policy,1,12).*/
        END.      /*acd001*/

/*p---
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

         FIND FIRST agtprm_fil WHERE agtprm_fil.asdat   = n_asdat           AND
                                                                agtprm_fil.acno    = billing.acno1   AND
                                                                agtprm_fil.policy  = billing.policy          AND
                                                                agtprm_fil.trnty     = billing.trnty1 + billing.trnty2  AND
                                                                agtprm_fil.docno = billing.docno
                    NO-LOCK NO-ERROR NO-WAIT.
         IF AVAIL agtprm_fil THEN DO:                    
             if  substr(trntyp , 1 , 1) = 'r' and agtprm_fil.bal <> 0 then next loop1.
             if  substr(trntyp , 1 , 1) = 'm' and agtprm_fil.bal < 0 then next loop1.         
         end.               
---p*/                  

/*p--------------*/             
        IF billing.bal - (y1 + z1) <= billing.whtax1 THEN DO:
            billing.error = "E".
            NEXT loop1.
        END. 
/*              if  billing.trnty1 =  'r' and billing.bal <> 0 then next loop1. */
        IF billing.trnty1 = 'r' THEN NEXT loop1.
        IF billing.trnty1 = 'm' AND billing.bal <= 0 THEN NEXT loop1.    /* ค้างค่า comm. */
/*--------------p*/
/* A46-0090 หา ก/ธ 72is 
        IF SUBSTR(billing.comp_policy, 7,2) = 'is'   THEN DO:
            FIND FIRST bfbilling USE-INDEX billing02 WHERE 
                                bfbilling.trndat    = nv_exportdat  AND
                                bfbilling.asdat     = billing.asdat  AND
                                bfbilling.acno1     = billing.acno1  AND 
                                bfbilling.policy    = SUBSTR(billing.comp_policy,1,12) 
                    NO-LOCK NO-ERROR.
            IF AVAIL bfbilling THEN DO:
                ASSIGN
                    v_comp_grp     = bfbilling.comp_grp     + billing.comp_grp
                    v_comp_netprm  = bfbilling.comp_netprm  + billing.comp_netprm
                    v_whtax1       = bfbilling.whtax1       + billing.whtax1
                    v_net_amount   = bfbilling.net_amount   + billing.net_amount.
            END.
        END.
        ELSE DO:
            ASSIGN
                v_comp_grp     = billing.comp_grp
                v_comp_netprm  = billing.comp_netprm
                v_whtax1       = billing.whtax1
                v_net_amount   = billing.net_amount.
        END. /* if SUBSTR(billing.comp_policy, 7,2) = 'is' */
A46-0090 -----*/
/* A46-0090 หา ก/ธ 72is ---*/
        IF SUBSTR(billing.comp_policy,7,2) = 'is' THEN DO:
            /* lek   -------------------------*/
            FIND FIRST agtprm_fil USE-INDEX by_acno WHERE
                       agtprm_fil.asdat  = billing.asdat AND  /* วันที่ statement process */
                       agtprm_fil.acno   = billing.acno  AND
                       agtprm_fil.poltyp = "V72"         AND
                       agtprm_fil.policy = SUBSTR(billing.comp_policy,1,12) 
            NO-LOCK NO-ERROR.
            IF AVAIL agtprm_fil THEN DO:
                ASSIGN
                    v_comp_grp    = billing.comp_grp    + agtprm_fil.gross       
                    v_comp_netprm = billing.comp_netprm + agtprm_fil.prem_comp
                    v_net_amount  = billing.net_amount  + agtprm_fil.gross.   /* ยอดจ่ายรวม */

                IF billing.whtax1 <> 0 THEN
                    v_whtax1      = billing.whtax1      + (agtprm_fil.prem_comp + agtprm_fil.stamp) * 0.01.
            END.
            /* lek  end  ----------------------*/
        END.
        ELSE DO:
            ASSIGN
                v_comp_grp     = billing.comp_grp
                v_comp_netprm  = billing.comp_netprm
                v_whtax1       = billing.whtax1
                v_net_amount   = billing.net_amount.
        END. /* if SUBSTR(billing.comp_policy, 7,2) = 'is' */
/*--- A46-0090 */
        
        n_veh = "".                          
        n_veh = billing.vehreg.

        IF SUBSTR(billing.vehreg,1,1) <> '/' THEN DO:
            RUN pdveh.      
        END.                          
        ELSE DO:
            IF billing.vehreg <> '' THEN DO:
                nv_eng  = SUBSTR(billing.vehreg,2,LENGTH(billing.vehreg)).
                RUN pdNewVeh.
                /*engc = substr(billing.vehreg,2,1) + nv_char.*/
                engc    = nv_char.
                nv_eng  = ''.
                nv_char = ''.
            END.
            ELSE engc = ''.
        END.
          
        IF billing.engine <> "" THEN DO:
            nv_eng1 = billing.engine.
            RUN pdeng.
            engine = nv_char1.
            nv_char1 = ''.
            nv_eng1 = ''.
        END.         
        ELSE engine = ''.

        IF billing.chassis <> "" THEN DO:
            nv_eng2 = billing.chassis.
            RUN pdchas.
            chas = nv_char2.
            nv_char2 = ''.
            nv_eng2 = ''.
        END.
        ELSE chas = ''.

        DISPLAY
            billing.acno  billing.start_date  billing.policy  billing.trnty1 billing.docno
        WITH COLOR BLACK/WHITE  NO-LABEL  FRAME frpdo1 VIEW-AS DIALOG-BOX  TITLE "Process ... ".

        PUT STREAM  filebill1
/*            wbill.wrecid
 *             RECID(billing)*/
            
            "D"                 FORMAT "X"          /* 1.  1 -   1 */
            billing.cust_name   FORMAT "X(60)"      /* 2.  2 - 61 */
            billing.nor_policy  FORMAT "X(26)"      /* 3. 62 - 87 */
            billing.comp_policy FORMAT "X(26)"      /* 4. 88 - 113 */
                                                    
            engine              FORMAT 'x(26)'      /* 5. 114 - 139 */         /* billing.engine   FORMAT "X(26)" */
            chas                FORMAT 'x(26)'      /* 6. 140 - 165   cha_no*/ /* billing.chassis  FORMAT "X(26)" */
                                                    
            billing.contract    FORMAT "X(10)"      /* 7. 166 - 175   opnpol*/
            engc                FORMAT 'x(12)'      /* 8. 166 - 175 */         /* billing.vehreg   FORMAT "X(12)" */
                                                    
            billing.start_date  FORMAT "99999999"   /* 9. 188 - 195 comdat*/

            fuDeciToChar(billing.nor_grp,10)     FORMAT "X(10)"   /* 10. 196 - 205  "9999999999" GP*/
            fuDeciToChar(v_comp_grp,10)          FORMAT "X(10)"   /* 11. 206 - 215  compGP*/  /* billing.comp_grp */
            fuDeciToChar(billing.nor_netprm,10)  FORMAT "X(10)"   /* 12. 216 - 225  NP*/
            fuDeciToChar(v_comp_netprm,10)       FORMAT "X(10)"   /* 13. 226 - 235  compNP*/ /* billing.comp_netprm*/
            fuDeciToChar(v_whtax1,10)            FORMAT "X(10)"   /* 14. 236 - 245  12+13+stamp * 1% */  /* billing.whtax1 */
            fuDeciToChar(v_net_amount,10)        FORMAT "X(10)"   /* 15. 246 - 255  10-11-14 */  /* billing.net_amount */
                  
            SKIP.

/*p       vExpCount = billing.recordno.  p*/
        vExpCount1= vExpCount1 + 1.

    END. /* IF AVAIL billing */
/*    RELEASE billing.*/
END.  /* for each wbill */
/*--------*/

/* 3. Trailer */
PUT STREAM filebill1
    "T"                         FORMAT "X"      /* 1 - 1 */
    STRING(vExpCount1 ,"99999") FORMAT "X(5)"   /* 2 - 6 */
    SKIP.

OUTPUT STREAM filebill1 CLOSE.

vBackUp =  fiFile-Name1 + "B".

DOS SILENT COPY VALUE(fiFile-Name1) VALUE(vBackUP) /Y. /* backup file exports */
---- A49-0002 ----*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdo3_2 C-Win 
PROCEDURE pdo3_2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF BUFFER bfwBill FOR wBill.
DEF VAR v_comp_grp      AS DECI  FORMAT "->>,>>>,>>9.99".
DEF VAR v_comp_netprm   AS DECI  FORMAT "->>,>>>,>>9.99".
DEF VAR v_whtax1        AS DECI  FORMAT "->>,>>>,>>9.99".
DEF VAR v_net_amount    AS DECI  FORMAT "->>,>>>,>>9.99".
OUTPUT STREAM filebill1 TO VALUE(fiFile-Name1).
/* 1. Header */
PUT STREAM filebill1
    "H"                                        FORMAT "X"       /* 1 -  1 */
    "Safety Insurance Public Company Limited"  FORMAT "X(40)"   /* 2 - 41 */
    STRING(TODAY,"99999999")                   FORMAT "X(8)"    /* 42 - 49 */
    STRING(n_asdat,"99999999")                 FORMAT "X(12)"   /* 50 - 61 */
    SKIP.

vExpCount1= 0.
/* 2. detail*/
loop1:
FOR EACH wBill  USE-INDEX wBill03 WHERE
         wBill.wtrndat1  >= n_comdatF   /*A59-0362*/ /*AND
         wBill.wnorpol   <> " "         AND
         wBill.wpol72    <> " "         AND
         wBill.wpoltyp   = "V70"*/     /*end sarinya c.A59-0362*/

    BREAK BY wBill.wcomdat
          BY wBill.wnorpol :
    n_wh1c = 0.
    FIND FIRST agtprm_fil USE-INDEX by_acno WHERE
        agtprm_fil.asdat  = wBill.wasdat AND      /* วันที่ statement process */
        /*agtprm_fil.acno   = wBill.wacno  AND*/  /*Kridtiya i. A53-0167 ......*/
        agtprm_fil.poltyp = "V72"        AND
        agtprm_fil.policy = SUBSTR(wBill.wpol72,1,12) 
        NO-LOCK NO-ERROR.
    IF AVAIL agtprm_fil THEN DO:
        ASSIGN
            wBill.wCompGrossPrem = wBill.wCompGrossPrem + agtprm_fil.gross.
            /*wBill.wCompNetPrem   = wBill.wCompNetPrem   + agtprm_fil.prem_comp.*/ /*Sarinya c. A59-0362*/
        IF wBill.wtax <> 0 THEN DO:
            n_wh1c = (agtprm_fil.prem_comp + agtprm_fil.stamp) * 0.01.
            wBill.wtax = wBill.wtax + n_wh1c.
        END.
        wBill.wnetpayment = wBill.wnetpayment + (agtprm_fil.gross - n_wh1c). /* ยอดจ่ายรวม */
    END.
    n_veh = "".
    n_veh = wBill.wVehreg.
    IF SUBSTR(wBill.wVehreg,1,1) <> '/' THEN DO:
        RUN pdveh.
    END.
    ELSE DO:
        IF wBill.wVehreg <> '' THEN DO:
            nv_eng  = SUBSTR(wBill.wVehreg,2,LENGTH(wBill.wVehreg)).
            RUN pdNewVeh.
            engc    = nv_char.
            nv_eng  = ''.
            nv_char = ''.
        END.
        ELSE engc   = ''.
    END.
    IF wBill.wengine <> "" THEN DO:
        nv_eng1 = wBill.wengine.
        RUN pdeng.
        engine = nv_char1.
        nv_char1 = ''.
        nv_eng1  = ''.
    END.
    ELSE engine  = ''.
    IF wBill.wcha_no <> "" THEN DO:
        nv_eng2 = wBill.wcha_no.
        RUN pdchas.
        chas = nv_char2.
        nv_char2 = ''.
        nv_eng2  = ''.
    END.
    ELSE chas    = ''.
    DISPLAY
        wBill.wacno  wBill.wcomdat  wBill.wpolicy  wBill.wtrnty1 wBill.wdocno FORMAT "X(10)" /* Benjaporn J. A60-0267 date 27/06/2017 */
        WITH COLOR BLACK/WHITE  NO-LABEL  FRAME frpdo1 VIEW-AS DIALOG-BOX  TITLE "Process ... ".
    PUT STREAM  filebill1
        "D"             FORMAT "X"        /* 1.  1 -   1 */
        wBill.winsure   FORMAT "X(60)"    /* 2.  2 - 61 */
        wBill.wnorpol   FORMAT "X(26)"    /* 3. 62 - 87 */
        wBill.wpol72    FORMAT "X(26)"    /* 4. 88 - 113 */
        engine          FORMAT 'x(26)'    /* 5. 114 - 139 */         /* wBill.engine   FORMAT "X(26)" */
        chas            FORMAT 'x(26)'    /* 6. 140 - 165   cha_no*/ /* wBill.chassis  FORMAT "X(26)" */
        wBill.wcontract FORMAT "X(20)"    /* 7. 166 - 175   opnpol*/ /* FORMAT "X(10)" */
        engc            FORMAT 'x(12)'    /* 8. 166 - 175 */         /* wBill.vehreg   FORMAT "X(12)" */
        wBill.wcomdat   FORMAT "99999999" /* 9. 188 - 195 comdat*/
        fuDeciToChar(wBill.wgrossprem,10)     FORMAT "X(10)"   /* 10. 196 - 205  "9999999999" GP*/
        fuDeciToChar(wBill.wCompGrossPrem,10) FORMAT "X(10)"   /* 11. 206 - 215  compGP*/  /* wBill.comp_grp */
        fuDeciToChar(wBill.wNetPrem,10)       FORMAT "X(10)"   /* 12. 216 - 225  NP*/
        fuDeciToChar(wBill.wCompNetPrem,10)   FORMAT "X(10)"   /* 13. 226 - 235  compNP*/ /* wBill.comp_netprm*/
        fuDeciToChar(wBill.wtax,10)           FORMAT "X(10)"   /* 14. 236 - 245  12+13+stamp * 1% */  /* wBill.whtax1 */
        fuDeciToChar(wBill.wNetPayment,10)    FORMAT "X(10)"   /* 15. 246 - 255  10-11-14 */  /* wBill.net_amount */
        wBill.wname2    FORMAT "X(60)" 
        wBill.wvatcode  FORMAT "X(10)" 

        SKIP.
    vExpCount1= vExpCount1 + 1.
END.  /* for each wbill */
PUT STREAM filebill1
    "T"                         FORMAT "X"      
    STRING(vExpCount1 ,"99999") FORMAT "X(5)"   
    SKIP.
OUTPUT STREAM filebill1 CLOSE.

vBackUp =  fiFile-Name1 + "B".
DOS SILENT COPY VALUE(fiFile-Name1) VALUE(vBackUP) /Y.  /* backup file exports */
RUN pdo3_ex.  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdo3_ex C-Win 
PROCEDURE pdo3_ex :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
For each  wdetail:
    DELETE  wdetail.
END.
INPUT FROM VALUE (fiFile-Name1) .  /*create in TEMP-TABLE wImport*/
REPEAT:   
    IMPORT UNFORMATTED nv_daily.
    CREATE  wdetail.
    IF TRIM(SUBSTRING(nv_daily,1,1)) = "H" THEN 
        ASSIGN
        wdetail.head          = TRIM(SUBSTRING(nv_daily,1,1))     /*1*/           
        wdetail.insure        = TRIM(SUBSTRING(nv_daily,2,40))    /*2*/                        
        wdetail.policy        = TRIM(SUBSTRING(nv_daily,42,8))   /*3*/            
        wdetail.polcomp       = TRIM(SUBSTRING(nv_daily,50,12)) .  /*4*/   
    ELSE 
    ASSIGN
        wdetail.head          = TRIM(SUBSTRING(nv_daily,1,1))     /*1*/           
        wdetail.insure        = TRIM(SUBSTRING(nv_daily,2,60))    /*2*/                        
        wdetail.policy        = TRIM(SUBSTRING(nv_daily,62,26))   /*3*/            
        wdetail.polcomp       = TRIM(SUBSTRING(nv_daily,88,26))   /*4*/         
        wdetail.engine        = TRIM(SUBSTRING(nv_daily,114,26))  /*5*/         
        wdetail.chass         = TRIM(SUBSTRING(nv_daily,140,26))  /*6*/         
        wdetail.contract      = TRIM(SUBSTRING(nv_daily,166,10))  /*7*/         
        wdetail.engc          = TRIM(SUBSTRING(nv_daily,176,12))  /*8*/         
        wdetail.comdat        = string(TRIM(SUBSTRING(nv_daily,188,8)),"99999999") /*9*/    
        wdetail.grossprem     = deci(TRIM(SUBSTRING(nv_daily,196,10))) / 100   /*10*/        
        wdetail.CompGrossPrem = deci(TRIM(SUBSTRING(nv_daily,206,10))) / 100   /*11*/        
        wdetail.NetPrem       = deci(TRIM(SUBSTRING(nv_daily,216,10))) / 100   /*12*/        
        wdetail.CompNetPrem   = deci(TRIM(SUBSTRING(nv_daily,226,10))) / 100   /*13*/        
        wdetail.tax           = deci(TRIM(SUBSTRING(nv_daily,236,10))) / 100   /*14*/        
        wdetail.NetPayment    = deci(TRIM(SUBSTRING(nv_daily,246,10))) / 100   /*15*/  
        wdetail.wname2        = TRIM(SUBSTRING(nv_daily,256,60))      /* A59-0362 Sarinya c.*/  
        wdetail.wvatcode      = TRIM(SUBSTRING(nv_daily,316,10)) .   /* A59-0362 Sarinya c.*/  
END.
If  substr(fiFile-Name1,length(fiFile-Name1) - 3,4) <>  ".csv"  Then
    fiFile-Name1  =  Trim(fiFile-Name1) + ".csv"  .

nv_cnt  =   0.
nv_row  =  1.


/*-----start A59-0362----*/
/* OUTPUT STREAM ns2 TO VALUE(fiFile-Name1).  */
/*
PUT STREAM ns2 "ID;PND" SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"' " "   '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"' "TEXT FILE FROM HCT"   '"' SKIP.
nv_row  =  nv_row + 1.                                                  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"' "head         "  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"' "Insure Name  "  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"' "Policy       "  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"  '"' "Policy(V72)  "  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"' "Engine       "  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"  '"' "Chassis      "  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"  '"' "contract     "  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"  '"' "Engcc        "  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"  '"' "Comdat       "  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K" '"' "grossprem    "  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K" '"' "CompGrossPrem"  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K" '"' "NetPrem      "  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K" '"' "CompNetPrem  "  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K" '"' "Tax          "  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K" '"' "NetPayment   "  '"' SKIP.
FOR each wdetail  no-lock.  
    nv_cnt  =  nv_cnt  + 1.                     
    nv_row  =  nv_row + 1.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"'  wdetail.head            '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"'  wdetail.insure          '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"'  wdetail.policy          '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"  '"'  wdetail.polcomp         '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"'  wdetail.engine          '"' SKIP.       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"  '"'  wdetail.chass           '"' SKIP.       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"  '"'  wdetail.contract        '"' SKIP.       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"  '"'  wdetail.engc            '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"  '"'  wdetail.comdat          '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K"  '"' wdetail.grossprem       '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K"  '"' wdetail.CompGrossPrem   '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K"  '"' wdetail.NetPrem         '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K"  '"' wdetail.CompNetPrem     '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K"  '"' wdetail.tax             '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K"  '"' wdetail.NetPayment      '"' SKIP.
END.*/

/*PUT STREAM ns2
 "head         "  ","     
 "Insure Name  "  ","     
 "Policy       "  ","     
 "Policy(V72)  "  ","     
 "Engine       "  ","     
 "Chassis      "  ","     
 "contract     "  ","     
 "Engcc        "  ","     
 "Comdat       "  ","     
 "grossprem    "  ","     
 "CompGrossPrem"  ","     
 "NetPrem      "  ","     
 "CompNetPrem  "  ","     
 "Tax          "  ","     
 "NetPayment   "  SKIP.
FOR each wdetail  no-lock.  
    nv_cnt  =  nv_cnt  + 1.                     
    nv_row  =  nv_row + 1.   
    PUT STREAM ns2  
    wdetail.head            "," 
    wdetail.insure          "," 
    wdetail.policy          "," 
    wdetail.polcomp         "," 
    wdetail.engine          "," 
    wdetail.chass           "," 
    wdetail.contract        "," 
    wdetail.engc            "," 
    wdetail.comdat          "," 
    wdetail.grossprem       "," 
    wdetail.CompGrossPrem   "," 
    wdetail.NetPrem         "," 
    wdetail.CompNetPrem     "," 
    wdetail.tax             "," 
    wdetail.NetPayment      SKIP.    
END.*/
/*----end A59-0362-----*/

/* add by sarinya c. A59-0362*/
OUTPUT  TO VALUE(fiFile-Name1).
  EXPORT DELIMITER ","
    "head"  
    "Insure Name" 
    "Policy" 
    "Policy(V72)" 
    "Engine" 
    "Chassis" 
    "contract" 
    "Engcc" 
    "Comdat" 
    "grossprem" 
    "CompGrossPrem" 
    "NetPrem" 
    "CompNetPrem" 
    "Tax" 
    "NetPayment" .
  /*  "Customer Name"
    "Voluntary Policy Number"
    "Compulsory Policy Number"
    "Engine"
    "Chassis"
    "TPIS Contract No."
    "Licence"
    "Effective Date"
    "Voluntary Gross Premium"
    "Compulsory Gross Premium"
    "Voluntary Net Premium"
    "Compulsory Net Premium"
    "W/H TAX 1%"
    "Net Payment"
    "Status" .*/


  FOR each wdetail  no-lock.  
      EXPORT DELIMITER ","
          
          wdetail.head         
          wdetail.insure          
          wdetail.policy          
          wdetail.polcomp         
          wdetail.engine          
          wdetail.chass           
          wdetail.contract        
          wdetail.engc            
          wdetail.comdat          
          wdetail.grossprem       
          wdetail.CompGrossPrem   
          wdetail.NetPrem         
          wdetail.CompNetPrem     
          wdetail.tax             
          wdetail.NetPayment
          ""  
          wdetail.wname2    
          wdetail.wvatcode    .   
END.


OUTPUT CLOSE.
/*add by sarinya c. A59-0362*/
OUTPUT STREAM ns2 CLOSE.

/*message "Export File  Complete"  view-as alert-box.*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdo3_expNew C-Win 
PROCEDURE pdo3_expNew :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF BUFFER bfwBill FOR wBill.
DEF VAR v_comp_grp      AS DECI  FORMAT "->>,>>>,>>9.99".
DEF VAR v_comp_netprm   AS DECI  FORMAT "->>,>>>,>>9.99".
DEF VAR v_whtax1        AS DECI  FORMAT "->>,>>>,>>9.99".
DEF VAR v_net_amount    AS DECI  FORMAT "->>,>>>,>>9.99".
OUTPUT STREAM filebill1 TO VALUE(fiFile-Name1).
/* 1. Header */
PUT STREAM filebill1
    "H"                                        FORMAT "X"      
    "Safety Insurance Public Company Limited"  FORMAT "X(40)"  
    STRING(TODAY,"99999999")                   FORMAT "X(8)"   
    STRING(n_asdat,"99999999")                 FORMAT "X(12)"  
    SKIP.

vExpCount1= 0.
loop1:
FOR EACH wBill  USE-INDEX wBill03 NO-LOCK WHERE
         wBill.wcomdat >= n_comdatF   
    BREAK BY wBill.wcomdat 
          BY wBill.wnorpol :  
            n_wh1c = 0.

            IF SUBSTR(wBill.wpolicy,3,2) = "70" THEN DO:
            

                FIND FIRST agtprm_fil USE-INDEX by_acno WHERE
                           agtprm_fil.asdat  = wBill.wasdat AND  /* วันที่ statement process */
                           agtprm_fil.acno   = wBill.wacno  AND
                           agtprm_fil.poltyp = "V72"        AND
                           agtprm_fil.policy = SUBSTR(wBill.wpol72,1,12) 
                NO-LOCK NO-ERROR.
                IF AVAIL agtprm_fil THEN DO:
                    ASSIGN
                        wBill.wCompGrossPrem = wBill.wCompGrossPrem + agtprm_fil.gross.
                    /*    wBill.wCompNetPrem   = wBill.wCompNetPrem   + agtprm_fil.prem_comp.*/  /*Sarinya c. A59-0362*/
                        /* End A49-0002 */
                
                    IF wBill.wtax <> 0 THEN DO:
                        n_wh1c = (agtprm_fil.prem_comp + agtprm_fil.stamp) * 0.01.
                        wBill.wtax = wBill.wtax + n_wh1c.
                    END.
                END.
            END.
            
        n_veh = "".
        n_veh = wBill.wVehreg.

        IF SUBSTR(wBill.wVehreg,1,1) <> '/' THEN DO:
            RUN pdveh.
        END.
        ELSE DO:
            IF wBill.wVehreg <> '' THEN DO:
                nv_eng  = SUBSTR(wBill.wVehreg,2,LENGTH(wBill.wVehreg)).
                RUN pdNewVeh.
                engc    = nv_char.
                nv_eng  = ''.
                nv_char = ''.
            END.
            ELSE engc   = ''.
        END.
       
     /*   IF wBill.wengine <> "" THEN DO:
            nv_eng1 = wBill.wengine.
            RUN pdeng.
            engine = nv_char1.
            nv_char1 = ''.
            nv_eng1  = ''.
        END.         
        ELSE engine  = ''.

       IF wBill.wcha_no <> "" THEN DO:
            nv_eng2 = wBill.wcha_no.
            RUN pdchas.
            chas = nv_char2.
            nv_char2 = ''.
            nv_eng2  = ''.
        END.
        ELSE chas    = ''. */

        DISPLAY
            wBill.wacno  wBill.wcomdat  wBill.wpolicy  wBill.wtrnty1 wBill.wdocno FORMAT "X(10)" /* Benjaporn J. A60-0267 date 27/06/2017 */
        WITH COLOR BLACK/WHITE  NO-LABEL  FRAME frpdo1 VIEW-AS DIALOG-BOX  TITLE "Process ... ".

        PUT STREAM  filebill1
            "D"             FORMAT "X"            /* 1.  1 -   1 */
            wBill.winsure   FORMAT "X(60)"        /* 2.  2 - 61 */
            wBill.wpolicy   FORMAT "X(26)"        
            wBill.wnorpol   FORMAT "X(26)"        /* 3. 62 - 87 */
            wBill.wpol72    FORMAT "X(26)"        /* 4. 88 - 113 */
            wBill.wengine   FORMAT 'x(30)'        /* 5. 114 - 139 */         /* wBill.engine   FORMAT "X(26)" */
            wBill.wcha_no   FORMAT 'x(30)'        /* 6. 140 - 165   cha_no*/ /* wBill.chassis  FORMAT "X(26)" */
            wBill.wcontract FORMAT "X(20)"        /* 7. 166 - 175   opnpol*/
            engc            FORMAT 'x(12)'        /* 8. 166 - 175 */         /* wBill.vehreg   FORMAT "X(12)" */
            wBill.wcomdat   FORMAT "99999999"     /* 9. 188 - 195 comdat*/
            fuDeciToChar(wBill.wgrossprem,10)     FORMAT "X(10)"   /* 10. 196 - 205  "9999999999" GP*/
            fuDeciToChar(wBill.wCompGrossPrem,10) FORMAT "X(10)"   /* 11. 206 - 215  compGP*/  /* wBill.comp_grp */
            fuDeciToChar(wBill.wNetPrem,10)       FORMAT "X(10)"   /* 12. 216 - 225  NP*/
            fuDeciToChar(wBill.wCompNetPrem,10)   FORMAT "X(10)"   /* 13. 226 - 235  compNP*/ /* wBill.comp_netprm*/
            fuDeciToChar(wBill.wtax,10)           FORMAT "X(10)"   /* 14. 236 - 245  12+13+stamp * 1% */  /* wBill.whtax1 */
            fuDeciToChar(wBill.wNetPayment,10)    FORMAT "X(10)"   /* 15. 246 - 255  10-11-14 */  /* wBill.net_amount */
            wBill.wname2      FORMAT "X(80)"           /* A59-0362 Sarinya c.*/  
            wBill.wvatcode    FORMAT "X(10)"          /* A59-0362 Sarinya c.*/  
            wBill.wacno       FORMAT "X(10)"
            wBill.wbrandmodel FORMAT "X(60)"
                  
            SKIP.
        vExpCount1= vExpCount1 + 1.

END.  /* for each wbill */
/*--------*/

/* 3. Trailer */
PUT STREAM filebill1
    "T"                         FORMAT "X"      /* 1 - 1 */
    STRING(vExpCount1 ,"99999") FORMAT "X(5)"   /* 2 - 6 */
    SKIP.

OUTPUT STREAM filebill1 CLOSE.

vBackUp =  fiFile-Name1 + "B".

DOS SILENT COPY VALUE(fiFile-Name1) VALUE(vBackUP) /Y. /* backup file exports */
RUN pdo3_ex_2.   
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdo3_ex_2 C-Win 
PROCEDURE pdo3_ex_2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
For each  wdetail:
    DELETE  wdetail.
END.
INPUT FROM VALUE (fiFile-Name1) .  /*create in TEMP-TABLE wImport*/
REPEAT:   
    IMPORT UNFORMATTED nv_daily.
    CREATE  wdetail.
    IF TRIM(SUBSTRING(nv_daily,1,1)) = "H" THEN 
        ASSIGN
        wdetail.head          = TRIM(SUBSTRING(nv_daily,1,1))     /*1*/           
        wdetail.insure        = TRIM(SUBSTRING(nv_daily,2,40))    /*2*/                        
        wdetail.policy        = TRIM(SUBSTRING(nv_daily,42,8))   /*3*/            
        wdetail.polcomp       = TRIM(SUBSTRING(nv_daily,50,12)) .  /*4*/   
    ELSE 
    ASSIGN
        wdetail.head          = TRIM(SUBSTRING(nv_daily,1,1))     /*1*/                                           
        wdetail.insure        = TRIM(SUBSTRING(nv_daily,2,60))    /*2*/                                           
        wdetail.policy_Main   = TRIM(SUBSTRING(nv_daily,62,26))    /*2*/                                          
                                                                                                                  
        wdetail.policy        = TRIM(SUBSTRING(nv_daily,88,26))   /*3*/                                           
        wdetail.polcomp       = TRIM(SUBSTRING(nv_daily,114,26))   /*4*/   

        wdetail.engine        = TRIM(SUBSTRING(nv_daily,140,30))  /*5*/                                           
        wdetail.chass         = TRIM(SUBSTRING(nv_daily,170,30))  /*6*/                                           
                                                                                                                  
        wdetail.contract      = TRIM(SUBSTRING(nv_daily,200,20))  /*7*/                                           
        wdetail.engc          = TRIM(SUBSTRING(nv_daily,220,12))  /*8*/                                           
        wdetail.comdat        = string(TRIM(SUBSTRING(nv_daily,232,8)),"99999999") /*9*/                       
        wdetail.grossprem     = deci(TRIM(SUBSTRING(nv_daily,240,10))) / 100   /*10*/                             
        wdetail.CompGrossPrem = deci(TRIM(SUBSTRING(nv_daily,250,10))) / 100   /*11*/                             
        wdetail.NetPrem       = deci(TRIM(SUBSTRING(nv_daily,260,10))) / 100   /*12*/                             
        wdetail.CompNetPrem   = deci(TRIM(SUBSTRING(nv_daily,270,10))) / 100   /*13*/                             
        wdetail.tax           = deci(TRIM(SUBSTRING(nv_daily,280,10))) / 100   /*14*/                                          
        wdetail.NetPayment    = deci(TRIM(SUBSTRING(nv_daily,290,10))) / 100   /*15*/  
        wdetail.wname2        = TRIM(SUBSTRING(nv_daily,300,80))      /* A59-0362 Sarinya c.*/  
        wdetail.wvatcode      = TRIM(SUBSTRING(nv_daily,380,10))     /* A59-0362 Sarinya c.*/ 
        wdetail.wacno         = TRIM(SUBSTRING(nv_daily,390,10)) 
        wdetail.wbrandmodel   = TRIM(SUBSTRING(nv_daily,400,60)) .
         
END.
If  substr(fiFile-Name1,length(fiFile-Name1) - 3,4) <>  ".csv"  Then
    fiFile-Name1  =  Trim(fiFile-Name1) + ".csv"  .

nv_cnt  =   0.
nv_row  =  1.

/* add by sarinya c. A59-0362*/
OUTPUT  TO VALUE(fiFile-Name1).
  EXPORT DELIMITER "|"
    "head"                                   
    "Insure_Name"                            
    "Policy_Main"                            
    "Policy"                                 
    "Policy(V72)"                            
    "Engine"                                 
    "Chassis"                                
    "contract"                               
    "Engcc"                                  
    "Comdat"                                 
    "grossprem"                              
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
                                                         
  FOR each wdetail  no-lock.  
      EXPORT DELIMITER "|"
          
          wdetail.head                       
          wdetail.insure                     
          wdetail.policy_Main                                                   
          wdetail.policy                     
          wdetail.polcomp                    
          wdetail.engine                     
          wdetail.chass                      
          wdetail.contract                   
          wdetail.engc                       
          wdetail.comdat                     
          wdetail.grossprem                  
          wdetail.CompGrossPrem              
          wdetail.NetPrem                    
          wdetail.CompNetPrem                
          wdetail.tax                        
          wdetail.NetPayment     
          ""                      
          wdetail.wname2           
          wdetail.wvatcode        
          wdetail.wacno          
          wdetail.wbrandmodel    
          .   
END.
OUTPUT CLOSE.
OUTPUT STREAM ns2 CLOSE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdo4 C-Win 
PROCEDURE pdo4 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

/*------------------------- export to file *** before 30/11/01 file not comp ***-------------------------*/

OUTPUT STREAM filebill3 TO VALUE(fiFile-Name3).

/* 1. Header */
PUT STREAM filebill3
    "H" FORMAT "X"                                              /* 1 - 1 */
    "Safety Insurance Public Company Limited"  FORMAT "X(40)"   /* 2 - 41 */
    STRING(TODAY,"99999999")                   FORMAT "X(8)"    /* 42 - 49 */
    STRING(n_asdat,"99999999")                 FORMAT "X(12)"   /* 50 - 61 */
    SKIP.

vExpCount3 = 0.

loop1:
FOR EACH wBill  USE-INDEX wBill03 WHERE
         wBill.wcomdat >= n_comdatF AND
         wBill.wnorpol <> " "       AND
        (wBill.wpol72   = " "       AND
         wBill.wpoltyp  = "V72")
    BREAK BY wBill.wcomdat
          BY wBill.wnorpol :
         
        n_veh = "".                          
        n_veh = wBill.wVehreg.

        IF SUBSTR(wBill.wVehreg,1,1) <> '/' THEN DO:
            RUN pdveh.
        END.
        ELSE DO:
            IF wBill.wVehreg <> '' THEN DO:
                nv_eng  = SUBSTR(wBill.wVehreg , 2 , LENGTH(wBill.wVehreg)).
                RUN pdNewVeh.
                engc    = nv_char.
                nv_eng  = ''.
                nv_char = ''.
            END.
            ELSE engc = ''.
        END.
          
        IF wBill.wengine <> "" THEN DO:
            nv_eng1 = wBill.wengine.
            RUN pdeng.
            engine   = nv_char1.
            nv_char1 = ''.
            nv_eng1  = ''.
        END.
        ELSE engine = ''.
             
        IF wBill.wcha_no <> "" THEN DO:
            nv_eng2  = wBill.wcha_no.
            RUN pdchas.
            chas = nv_char2.
            nv_char2 = ''.
            nv_eng2  = ''.
        END.
        ELSE chas = ''.
                  
        DISPLAY wBill.wacno  wBill.wcomdat  wBill.wpolicy  wBill.wtrnty1 wBill.wdocno FORMAT "X(10)" /* Benjaporn J. A60-0267 date 27/06/2017 */
            WITH COLOR BLACK/WHITE NO-LABEL FRAME frpdo3 VIEW-AS DIALOG-BOX TITLE "Process ... ".

        PUT STREAM  filebill3
            "D"             FORMAT "X"          /* 1.  1 -   1 */
            wBill.winsure   FORMAT "X(60)"      /* 2.  2 - 61 */
            wBill.wnorpol   FORMAT "X(26)"      /* 3. 62 - 87 */
            wBill.wpol72    FORMAT "X(26)"      /* 4. 88 - 113 */
            engine          FORMAT 'x(26)'
            chas            FORMAT 'x(26)'
            wBill.wcontract FORMAT "X(10)"       /* 7. 166 - 175   opnpol*/
            engc            FORMAT 'x(12)'
            wBill.wcomdat   FORMAT "99999999" /* 9. 188 - 195 comdat*/

            fuDeciToChar(wBill.wGrossPrem,10)     FORMAT "X(10)"   /* 10. 196 - 205  "9999999999" GP*/
            fuDeciToChar(wBill.wCompGrossPrem,10) FORMAT "X(10)"   /* 11. 206 - 215  compGP*/
            fuDeciToChar(wBill.wNetPrem,10)       FORMAT "X(10)"   /* 12. 216 - 225  NP*/
            fuDeciToChar(wBill.wCompNetPrem,10)   FORMAT "X(10)"   /* 13. 226 - 235  compNP*/
            fuDeciToChar(wBill.wtax,10)           FORMAT "X(10)"   /* 14. 236 - 245  12+13+stamp * 1% */
            fuDeciToChar(wBill.wNetPayment,10)    FORMAT "X(10)"   /* 15. 246 - 255  10-11-14 */
            SKIP.

        vExpCount3= vExpCount3 + 1.

END.  /* for each wbill */
/*--------*/

/* 3. Trailer */
PUT STREAM filebill3
    "T"                        FORMAT "X"       /* 1 - 1 */
    STRING(vExpCount3,"99999") FORMAT "X(5)"    /* 2 - 6 */
    SKIP.

OUTPUT STREAM filebill3 CLOSE.

vBackUp =  fiFile-Name3 + "B".

DOS SILENT COPY VALUE(fiFile-Name3) VALUE(vBackUP) /Y .    /* backup file exports */
RUN pdo4_ex.  /*kridtiya i. A53-0167*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdo4_2 C-Win 
PROCEDURE pdo4_2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*------------------------- export to file *** before 30/11/01 file not comp ***-------------------------*/
ASSIGN nv_file = fiFile-Name3 + "_IS".
OUTPUT STREAM filebill3 TO VALUE(fiFile-Name3).
/* 1. Header */
PUT STREAM filebill3
    "H" FORMAT "X"                                              /* 1 - 1 */
    "Safety Insurance Public Company Limited"  FORMAT "X(40)"   /* 2 - 41 */
    STRING(TODAY,"99999999")                   FORMAT "X(8)"    /* 42 - 49 */
    STRING(n_asdat,"99999999")                 FORMAT "X(12)"   /* 50 - 61 */
    SKIP.
vExpCount3 = 0.

loop1:
FOR EACH wBill  USE-INDEX wBill03 WHERE
         wBill.wtrndat1  >= n_comdatF AND
         wBill.wnorpol   <> " "         AND
         substr(wBill.wnorpol,7,1)   = "T"  AND
         wBill.wpol72   =  " "          AND
         wBill.wpoltyp  = "V72"
    BREAK BY wBill.wcomdat
          BY wBill.wnorpol :
    n_veh = "".                          
    n_veh = wBill.wVehreg.
    IF SUBSTR(wBill.wVehreg,1,1) <> '/' THEN DO:
        RUN pdveh.
    END.
    ELSE DO:
        IF wBill.wVehreg <> '' THEN DO:
            nv_eng  = SUBSTR(wBill.wVehreg , 2 , LENGTH(wBill.wVehreg)).
            RUN pdNewVeh.
            engc    = nv_char.
            nv_eng  = ''.
            nv_char = ''.
        END.
        ELSE engc = ''.
    END.
    IF wBill.wengine <> "" THEN DO:
        nv_eng1 = wBill.wengine.
        RUN pdeng.
        engine   = nv_char1.
        nv_char1 = ''.
        nv_eng1  = ''.
    END.
    ELSE engine = ''.
    IF wBill.wcha_no <> "" THEN DO:
        nv_eng2  = wBill.wcha_no.
        RUN pdchas.
        chas = nv_char2.
        nv_char2 = ''.
        nv_eng2  = ''.
    END.
    ELSE chas = ''.
    DISPLAY wBill.wacno  wBill.wcomdat  wBill.wpolicy  wBill.wtrnty1 wBill.wdocno FORMAT "X(10)" /* Benjaporn J. A60-0267 date 27/06/2017 */
        WITH COLOR BLACK/WHITE NO-LABEL FRAME frpdo3 VIEW-AS DIALOG-BOX TITLE "Process ... ".
    PUT STREAM  filebill3
        "D"             FORMAT "X"          /* 1.  1 -   1 */
        wBill.winsure   FORMAT "X(60)"      /* 2.  2 - 61 */
        wBill.wnorpol   FORMAT "X(26)"      /* 3. 62 - 87 */
        wBill.wpol72    FORMAT "X(26)"      /* 4. 88 - 113 */
        engine          FORMAT 'x(26)'
        chas            FORMAT 'x(26)'
        wBill.wcontract FORMAT "X(10)"       /* 7. 166 - 175   opnpol*/
        engc            FORMAT 'x(12)'
        wBill.wcomdat   FORMAT "99999999" /* 9. 188 - 195 comdat*/
        
        fuDeciToChar(wBill.wGrossPrem,10)     FORMAT "X(10)"   /* 10. 196 - 205  "9999999999" GP*/
        fuDeciToChar(wBill.wCompGrossPrem,10) FORMAT "X(10)"   /* 11. 206 - 215  compGP*/
        fuDeciToChar(wBill.wNetPrem,10)       FORMAT "X(10)"   /* 12. 216 - 225  NP*/
        fuDeciToChar(wBill.wCompNetPrem,10)   FORMAT "X(10)"   /* 13. 226 - 235  compNP*/
        fuDeciToChar(wBill.wtax,10)           FORMAT "X(10)"   /* 14. 236 - 245  12+13+stamp * 1% */
        fuDeciToChar(wBill.wNetPayment,10)    FORMAT "X(10)"   /* 15. 246 - 255  10-11-14 */
        SKIP.
    vExpCount3= vExpCount3 + 1.
END.  /* for each wbill */
/*--------*/
/* 3. Trailer */
PUT STREAM filebill3
    "T"                        FORMAT "X"       /* 1 - 1 */
    STRING(vExpCount3,"99999") FORMAT "X(5)"    /* 2 - 6 */
    SKIP.

OUTPUT STREAM filebill3 CLOSE.

vBackUp =  fiFile-Name3 + "B".

DOS SILENT COPY VALUE(fiFile-Name3) VALUE(vBackUP) /Y .    /* backup file exports */
RUN pdo4_ex.  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdo4_ex C-Win 
PROCEDURE pdo4_ex :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

For each  wdetail:
    DELETE  wdetail.
END.
INPUT FROM VALUE (fiFile-Name3) .  /*create in TEMP-TABLE wImport*/
REPEAT:   
    IMPORT UNFORMATTED nv_daily.
    CREATE  wdetail.
    IF TRIM(SUBSTRING(nv_daily,1,1)) = "H" THEN 
        ASSIGN
        wdetail.head          = TRIM(SUBSTRING(nv_daily,1,1))     /*1*/           
        wdetail.insure        = TRIM(SUBSTRING(nv_daily,2,40))    /*2*/                        
        wdetail.policy        = TRIM(SUBSTRING(nv_daily,42,8))   /*3*/            
        wdetail.polcomp       = TRIM(SUBSTRING(nv_daily,50,12)) .  /*4*/   
    ELSE 
    ASSIGN
        wdetail.head          = TRIM(SUBSTRING(nv_daily,1,1))     /*1*/           
        wdetail.insure        = TRIM(SUBSTRING(nv_daily,2,60))    /*2*/                        
        wdetail.policy        = TRIM(SUBSTRING(nv_daily,62,26))   /*3*/            
        wdetail.polcomp       = TRIM(SUBSTRING(nv_daily,88,26))   /*4*/         
        wdetail.engine        = TRIM(SUBSTRING(nv_daily,114,26))  /*5*/         
        wdetail.chass         = TRIM(SUBSTRING(nv_daily,140,26))  /*6*/         
        wdetail.contract      = TRIM(SUBSTRING(nv_daily,166,10))  /*7*/         
        wdetail.engc          = TRIM(SUBSTRING(nv_daily,176,12))  /*8*/         
        wdetail.comdat        = string(TRIM(SUBSTRING(nv_daily,188,8)),"99999999")   /*9*/
        wdetail.grossprem     = deci(TRIM(SUBSTRING(nv_daily,196,10))) / 100    /*10*/        
        wdetail.CompGrossPrem = deci(TRIM(SUBSTRING(nv_daily,206,10))) / 100    /*11*/        
        wdetail.NetPrem       = deci(TRIM(SUBSTRING(nv_daily,216,10))) / 100    /*12*/        
        wdetail.CompNetPrem   = deci(TRIM(SUBSTRING(nv_daily,226,10))) / 100    /*13*/        
        wdetail.tax           = deci(TRIM(SUBSTRING(nv_daily,236,10))) / 100    /*14*/        
        wdetail.NetPayment    = deci(TRIM(SUBSTRING(nv_daily,246,10))) / 100    /*15*/  
        .
END.
If  substr(fiFile-Name3,length(fiFile-Name3) - 3,4) <>  ".csv"  Then
    fiFile-Name3  =  Trim(fiFile-Name3) + ".csv"  .

nv_cnt  =   0.
nv_row  =  1.
OUTPUT STREAM ns2 TO VALUE(fiFile-Name3).
/*
PUT STREAM ns2 "ID;PND" SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"' " "   '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"' "TEXT FILE FROM HCT"   '"' SKIP.
nv_row  =  nv_row + 1.                                                  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"' "head         "  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"' "Insure Name  "  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"' "Policy       "  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"  '"' "Policy(V72)  "  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"' "Engine       "  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"  '"' "Chassis      "  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"  '"' "contract     "  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"  '"' "Engcc        "  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"  '"' "Comdat       "  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K" '"' "grossprem    "  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K" '"' "CompGrossPrem"  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K" '"' "NetPrem      "  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K" '"' "CompNetPrem  "  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K" '"' "Tax          "  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K" '"' "NetPayment   "  '"' SKIP.
FOR each wdetail  no-lock.  
    nv_cnt  =  nv_cnt  + 1.                     
    nv_row  =  nv_row + 1.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"'  wdetail.head            '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"'  wdetail.insure          '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"'  wdetail.policy          '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"  '"'  wdetail.polcomp         '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"'  wdetail.engine          '"' SKIP.       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"  '"'  wdetail.chass           '"' SKIP.       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"  '"'  wdetail.contract        '"' SKIP.       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"  '"'  wdetail.engc            '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"  '"'  wdetail.comdat          '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K"  '"' wdetail.grossprem       '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K"  '"' wdetail.CompGrossPrem   '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K"  '"' wdetail.NetPrem         '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K"  '"' wdetail.CompNetPrem     '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K"  '"' wdetail.tax             '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K"  '"' wdetail.NetPayment      '"' SKIP.
END.
PUT STREAM ns2 "E".*/
PUT STREAM ns2
 "head         "  ","     
 "Insure Name  "  ","     
 "Policy       "  ","     
 "Policy(V72)  "  ","     
 "Engine       "  ","     
 "Chassis      "  ","     
 "contract     "  ","     
 "Engcc        "  ","     
 "Comdat       "  ","     
 "grossprem    "  ","     
 "CompGrossPrem"  ","     
 "NetPrem      "  ","     
 "CompNetPrem  "  ","     
 "Tax          "  ","     
 "NetPayment   "  SKIP.
FOR each wdetail  no-lock.  
    nv_cnt  =  nv_cnt  + 1.                     
    nv_row  =  nv_row + 1.   
    PUT STREAM ns2  
    wdetail.head            "," 
    wdetail.insure          "," 
    wdetail.policy          "," 
    wdetail.polcomp         "," 
    wdetail.engine          ","  
    wdetail.chass           ","  
    wdetail.contract        ","  
    wdetail.engc            ","  
    wdetail.comdat          ","  
    wdetail.grossprem       ","  
    wdetail.CompGrossPrem   ","  
    wdetail.NetPrem         ","  
    wdetail.CompNetPrem     ","   
    wdetail.tax             ","   
    wdetail.NetPayment      SKIP.    
END.


OUTPUT STREAM ns2 CLOSE.

/*message "Export File  Complete"  view-as alert-box.*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdo5_2 C-Win 
PROCEDURE pdo5_2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

/*------------------------- export to file *** before 30/11/01 file not comp ***-------------------------*/
OUTPUT STREAM filebill3 TO VALUE(nv_file).
/* 1. Header */
PUT STREAM filebill3
    "H" FORMAT "X"                                              /* 1 - 1 */
    "Safety Insurance Public Company Limited"  FORMAT "X(40)"   /* 2 - 41 */
    STRING(TODAY,"99999999")                   FORMAT "X(8)"    /* 42 - 49 */
    STRING(n_asdat,"99999999")                 FORMAT "X(12)"   /* 50 - 61 */
    SKIP.
vExpCount3 = 0.

loop1:
FOR EACH wBill  USE-INDEX wBill03 WHERE
         wBill.wtrndat1  >= n_comdatF AND
         wBill.wnorpol   <> " "       AND
         substr(wBill.wnorpol,7,1)  <> "T"  AND
         wBill.wpol72   =  " "          AND
         wBill.wpoltyp  = "V72"
    BREAK BY wBill.wcomdat
          BY wBill.wnorpol :
    n_veh = "".                          
    n_veh = wBill.wVehreg.
    IF SUBSTR(wBill.wVehreg,1,1) <> '/' THEN DO:
        RUN pdveh.
    END.
    ELSE DO:
        IF wBill.wVehreg <> '' THEN DO:
            nv_eng  = SUBSTR(wBill.wVehreg , 2 , LENGTH(wBill.wVehreg)).
            RUN pdNewVeh.
            engc    = nv_char.
            nv_eng  = ''.
            nv_char = ''.
        END.
        ELSE engc = ''.
    END.
    IF wBill.wengine <> "" THEN DO:
        nv_eng1 = wBill.wengine.
        RUN pdeng.
        engine   = nv_char1.
        nv_char1 = ''.
        nv_eng1  = ''.
    END.
    ELSE engine = ''.
    IF wBill.wcha_no <> "" THEN DO:
        nv_eng2  = wBill.wcha_no.
        RUN pdchas.
        chas = nv_char2.
        nv_char2 = ''.
        nv_eng2  = ''.
    END.
    ELSE chas = ''.
    DISPLAY wBill.wacno  wBill.wcomdat  wBill.wpolicy  wBill.wtrnty1 wBill.wdocno FORMAT "X(10)" /* Benjaporn J. A60-0267 date 27/06/2017 */
        WITH COLOR BLACK/WHITE NO-LABEL FRAME frpdo3 VIEW-AS DIALOG-BOX TITLE "Process ... ".
    PUT STREAM  filebill3
        "D"             FORMAT "X"          /* 1.  1 -   1 */
        wBill.winsure   FORMAT "X(60)"      /* 2.  2 - 61 */
        wBill.wnorpol   FORMAT "X(26)"      /* 3. 62 - 87 */
        wBill.wpol72    FORMAT "X(26)"      /* 4. 88 - 113 */
        engine          FORMAT 'x(26)'
        chas            FORMAT 'x(26)'
        wBill.wcontract FORMAT "X(10)"       /* 7. 166 - 175   opnpol*/
        engc            FORMAT 'x(12)'
        wBill.wcomdat   FORMAT "99999999" /* 9. 188 - 195 comdat*/
        
        fuDeciToChar(wBill.wGrossPrem,10)     FORMAT "X(10)"   /* 10. 196 - 205  "9999999999" GP*/
        fuDeciToChar(wBill.wCompGrossPrem,10) FORMAT "X(10)"   /* 11. 206 - 215  compGP*/
        fuDeciToChar(wBill.wNetPrem,10)       FORMAT "X(10)"   /* 12. 216 - 225  NP*/
        fuDeciToChar(wBill.wCompNetPrem,10)   FORMAT "X(10)"   /* 13. 226 - 235  compNP*/
        fuDeciToChar(wBill.wtax,10)           FORMAT "X(10)"   /* 14. 236 - 245  12+13+stamp * 1% */
        fuDeciToChar(wBill.wNetPayment,10)    FORMAT "X(10)"   /* 15. 246 - 255  10-11-14 */
        SKIP.
    vExpCount3= vExpCount3 + 1.
END.  /* for each wbill */
/*--------*/
/* 3. Trailer */
PUT STREAM filebill3
    "T"                        FORMAT "X"       /* 1 - 1 */
    STRING(vExpCount3,"99999") FORMAT "X(5)"    /* 2 - 6 */
    SKIP.

OUTPUT STREAM filebill3 CLOSE.
RUN pdo5_ex.  

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdo5_ex C-Win 
PROCEDURE pdo5_ex :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
For each  wdetail:
    DELETE  wdetail.
END.
INPUT FROM VALUE (nv_file) .  /*create in TEMP-TABLE wImport*/
REPEAT:   
    IMPORT UNFORMATTED nv_daily.
    CREATE  wdetail.
    IF TRIM(SUBSTRING(nv_daily,1,1)) = "H" THEN 
        ASSIGN
        wdetail.head          = TRIM(SUBSTRING(nv_daily,1,1))     /*1*/           
        wdetail.insure        = TRIM(SUBSTRING(nv_daily,2,40))    /*2*/                        
        wdetail.policy        = TRIM(SUBSTRING(nv_daily,42,8))   /*3*/            
        wdetail.polcomp       = TRIM(SUBSTRING(nv_daily,50,12)) .  /*4*/   
    ELSE 
    ASSIGN
        wdetail.head          = TRIM(SUBSTRING(nv_daily,1,1))     /*1*/           
        wdetail.insure        = TRIM(SUBSTRING(nv_daily,2,60))    /*2*/                        
        wdetail.policy        = TRIM(SUBSTRING(nv_daily,62,26))   /*3*/            
        wdetail.polcomp       = TRIM(SUBSTRING(nv_daily,88,26))   /*4*/         
        wdetail.engine        = TRIM(SUBSTRING(nv_daily,114,26))  /*5*/         
        wdetail.chass         = TRIM(SUBSTRING(nv_daily,140,26))  /*6*/         
        wdetail.contract      = TRIM(SUBSTRING(nv_daily,166,10))  /*7*/         
        wdetail.engc          = TRIM(SUBSTRING(nv_daily,176,12))  /*8*/         
        wdetail.comdat        = string(TRIM(SUBSTRING(nv_daily,188,8)),"99999999")   /*9*/
        wdetail.grossprem     = deci(TRIM(SUBSTRING(nv_daily,196,10))) / 100    /*10*/        
        wdetail.CompGrossPrem = deci(TRIM(SUBSTRING(nv_daily,206,10))) / 100    /*11*/        
        wdetail.NetPrem       = deci(TRIM(SUBSTRING(nv_daily,216,10))) / 100    /*12*/        
        wdetail.CompNetPrem   = deci(TRIM(SUBSTRING(nv_daily,226,10))) / 100    /*13*/        
        wdetail.tax           = deci(TRIM(SUBSTRING(nv_daily,236,10))) / 100    /*14*/        
        wdetail.NetPayment    = deci(TRIM(SUBSTRING(nv_daily,246,10))) / 100    /*15*/  
        .
END.
If  substr(nv_file,length(nv_file) - 3,4) <>  ".csv"  Then
    nv_file  =  Trim(nv_file) + ".csv"  .

nv_cnt  =   0.
nv_row  =  1.
OUTPUT STREAM ns2 TO VALUE(nv_file).
/*
PUT STREAM ns2 "ID;PND" SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"' " "   '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"' "TEXT FILE FROM HCT"   '"' SKIP.
nv_row  =  nv_row + 1.                                                  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"' "head         "  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"' "Insure Name  "  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"' "Policy       "  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"  '"' "Policy(V72)  "  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"' "Engine       "  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"  '"' "Chassis      "  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"  '"' "contract     "  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"  '"' "Engcc        "  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"  '"' "Comdat       "  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K" '"' "grossprem    "  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K" '"' "CompGrossPrem"  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K" '"' "NetPrem      "  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K" '"' "CompNetPrem  "  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K" '"' "Tax          "  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K" '"' "NetPayment   "  '"' SKIP.
FOR each wdetail  no-lock.  
    nv_cnt  =  nv_cnt  + 1.                     
    nv_row  =  nv_row + 1.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"'  wdetail.head            '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"'  wdetail.insure          '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"'  wdetail.policy          '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"  '"'  wdetail.polcomp         '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"'  wdetail.engine          '"' SKIP.       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"  '"'  wdetail.chass           '"' SKIP.       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"  '"'  wdetail.contract        '"' SKIP.       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"  '"'  wdetail.engc            '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"  '"'  wdetail.comdat          '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K"  '"' wdetail.grossprem       '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K"  '"' wdetail.CompGrossPrem   '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K"  '"' wdetail.NetPrem         '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K"  '"' wdetail.CompNetPrem     '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K"  '"' wdetail.tax             '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K"  '"' wdetail.NetPayment      '"' SKIP.
END.
PUT STREAM ns2 "E".*/
PUT STREAM ns2
 "head         "  ","     
 "Insure Name  "  ","     
 "Policy       "  ","     
 "Policy(V72)  "  ","     
 "Engine       "  ","     
 "Chassis      "  ","     
 "contract     "  ","     
 "Engcc        "  ","     
 "Comdat       "  ","     
 "grossprem    "  ","     
 "CompGrossPrem"  ","     
 "NetPrem      "  ","     
 "CompNetPrem  "  ","     
 "Tax          "  ","     
 "NetPayment   "  SKIP.
FOR each wdetail  no-lock.  
    nv_cnt  =  nv_cnt  + 1.                     
    nv_row  =  nv_row + 1.   
    PUT STREAM ns2  
    wdetail.head            "," 
    wdetail.insure          "," 
    wdetail.policy          "," 
    wdetail.polcomp         "," 
    wdetail.engine          ","  
    wdetail.chass           ","  
    wdetail.contract        ","  
    wdetail.engc            ","  
    wdetail.comdat          ","  
    wdetail.grossprem       ","  
    wdetail.CompGrossPrem   ","  
    wdetail.NetPrem         ","  
    wdetail.CompNetPrem     ","   
    wdetail.tax             ","   
    wdetail.NetPayment      SKIP.    
END.


OUTPUT STREAM ns2 CLOSE.

/*message "Export File  Complete"  view-as alert-box.*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdProc C-Win 
PROCEDURE pdProc :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*Include File => create record  to table wBill tas-----------*/
/*p----------------------------------------*/

FIND LAST  acProc_fil USE-INDEX by_type_asdat WHERE
           acProc_fil.type  = "02"      AND
           acProc_fil.asdat = n_asdat NO-LOCK  NO-ERROR.  /* n_asdat */
IF NOT AVAIL acProc_fil THEN DO:
    CREATE acProc_fil.
    ASSIGN acProc_fil.type     = "02"
           acProc_fil.typdesc  = "PROCESS STATEMENT BILLING(TAS)"
           acProc_fil.asdat    = n_asdat       /* วันที่ process statement *//* nv_exportdat  */
           acProc_fil.trndatfr = n_comdatF     /*depend on condition on interface*/
           acProc_fil.trndatto = n_comdatT
           acProc_fil.entdat   = TODAY         /* = nv_exportdat    */
           acProc_fil.enttim   = STRING(TIME, "HH:MM:SS")
           acProc_fil.usrid    = n_user .
END.
RELEASE acProc_fil. /*Sarinya C. A59-0362*/
/*--------------------------------------p*/

FOR EACH wBill: DELETE  wBill. END.

ASSIGN
  nv_exportdat = TODAY
  nv_exporttim = STRING(TIME,"HH:MM:SS")
  nv_exportusr = nv_user
  vCountRec    = 0.
/*p-------------------------------------------------------------------*/
/*--------------------------------------------------------------------p*/

FOR EACH wfAcno USE-INDEX wList01 NO-LOCK:

    LOOP_MAIN:
    FOR EACH  agtprm_fil USE-INDEX by_acno            WHERE
              agtprm_fil.asdat         = n_asdat       AND
       (LOOKUP(agtprm_fil.acno,nv_acnoAll) <> 0 )       AND  /* A46-0426 */ 
              /*--agtprm_fil.acno          = wfAcno.wacno  AND  /* A49-0002 */----Sarinya c. A59-0362---*/
              (agtprm_fil.poltyp       = "V70"         OR  /* A49-0002 */
              agtprm_fil.poltyp        = "V72")        AND  /* --- Suthida T. A52-0299 --- */
            /*----- A49-0002 ------
             (agtprm_fil.poltyp        = "V70"  OR
              agtprm_fil.poltyp        = "V72")        AND
       SUBSTR(agtprm_fil.policy,7,2)  <> "IS"          AND  /*free compulsory dm7245isxxxx*/
            --- end A49-0002 ---*/
              /* A49-0002 */
             (agtprm_fil.TYPE          = "01"          OR
              agtprm_fil.TYPE          = "05")         AND
              agtprm_fil.trntyp     BEGINS 'M'         AND
              /* END A49-0002 */
    /* A46-0426---
             (agtprm_fil.acno          = fi_ac1         OR
              agtprm_fil.acno          = fi_ac2         OR
              agtprm_fil.acno          = fi_ac3         OR
              agtprm_fil.acno          = fi_ac4         OR
              agtprm_fil.acno          = fi_ac5         OR
              agtprm_fil.acno          = fi_ac6         OR
              agtprm_fil.acno          = fi_ac7         OR
              agtprm_fil.acno          = fi_ac8         OR
              agtprm_fil.acno          = fi_ac9         OR
              agtprm_fil.acno          = fi_ac10  )    AND
    ---A46-0426 */
             (agtprm_fil.polbran      >= n_branch      AND
              agtprm_fil.polbran      <= n_branch2 )   AND
    /* A49-0002 ----
         (NOT(agtprm_fil.trntyp     BEGINS 'Y')        AND
          NOT(agtprm_fil.trntyp     BEGINS 'Z') )      AND
    ---- A49-0002 */      
     /*  (agtprm_fil.comdat       >= n_comdatF     AND  
              agtprm_fil.comdat       <= n_comdatT)    AND */  /*---by Sarinya c. A59-0362---*/
              agtprm_fil.bal          >  0                  /* A49-0002 */
    /*           agtprm_fil.bal          <> 0 */
        NO-LOCK:
        /*--------- Sarinya c. A59-0362 --*/
        IF agtprm_fil.comdat       < n_comdatF     THEN NEXT loop_main.
        IF agtprm_fil.comdat       > n_comdatT    THEN NEXT loop_main.
        /*-----end Sarinya c. A59-0362----*/
        IF agtprm_fil.prem + agtprm_fil.prem_comp = 0 THEN NEXT loop_main.  /* เบี้ยเป็น 0 แต่ยังค้างค่า comm. bal <> 0*/
        
        /* A49-0002 : check policy cancle */
        FIND LAST acm001 USE-INDEX acm00104 WHERE
                  acm001.policy = agtprm_fil.policy NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL acm001 THEN
            IF acm001.trnty1 = "R" AND acm001.trnty2 = "C" THEN NEXT loop_main.
        /* END A49-0002 */
        
    
        ASSIGN
           nv_pol72      = ""     nv_norpol   = ""
           nv_insure     = ""     nv_vehreg   = ""
           nv_engine     = ""     nv_cha_no   = ""
           nv_job_nr     = ""  /* nv_opnpol   = "" */
           nv_grossPrem  = 0      nv_grossPrem_comp = 0
           nv_netPrem    = 0      nv_netPrem_comp   = 0
           nv_tax        = 0      nv_netPayment     = 0
           vStamp        = 0      vStamp_comp       = 0
           vVat          = 0      vVat_comp         = 0 
           nv_cedpol     = ""  
           nv_name2      = "" 
           nv_vatcode    = "" .
    
        DISPLAY  "Process : " + agtprm_fil.policy + '   ' + agtprm_fil.trnty
                       + '  ' + agtprm_fil.docno FORMAT "X(10)" /* Benjaporn J. A60-0267 date 27/06/2017 */
             @ fi_Process WITH FRAME {&FRAME-NAME}.
        PAUSE 0.
    
        ASSIGN
           
          /* nv_norpol   = agtprm_fil.policy + '(' + SUBSTR(agtprm_fil.trntyp,1,1)
                                                 + agtprm_fil.docno + ')'*/
    /*        nv_opnpol   = agtprm_fil.opnpol */
           nv_vehreg   = agtprm_fil.vehreg
           nv_netPrem  = agtprm_fil.prem
           nv_netPrem_comp = agtprm_fil.prem_comp .

       /* nv_norpol  70
          nv_pol72   72*/
        IF (SUBSTR(agtprm_fil.policy,3,2) = "70" ) THEN  
            nv_norpol = agtprm_fil.policy + '(' + SUBSTR(agtprm_fil.trntyp,1,1)
                        + agtprm_fil.docno + ')'.
        ELSE   nv_pol72 = agtprm_fil.policy + '(' + SUBSTR(agtprm_fil.trntyp,1,1)
                        + agtprm_fil.docno + ')'.


    
        /*------------------*/
        /*A47-0235--- 
        FIND FIRST uwm100  use-index uwm10090 WHERE
                   uwm100.trty11 = substr(agtprm_fil.trnty, 1 , 1)  AND
                   uwm100.docno1 = agtprm_fil.docno
             NO-LOCK NO-ERROR.
        ---A47-0235*/
    
        FIND FIRST uwm100 USE-INDEX uwm10001 WHERE
                   uwm100.policy = agtprm_fil.policy  /*AND
                   uwm100.endno  = agtprm_fil.endno   AND
                   uwm100.docno1 = agtprm_fil.docno*/   NO-LOCK NO-ERROR.
        IF AVAIL uwm100 THEN DO:
            IF uwm100.endno  <> agtprm_fil.endno AND  uwm100.docno1 <> agtprm_fil.docno THEN NEXT.
            ASSIGN nv_cedpol   = uwm100.cedpol
                   nv_name2    = uwm100.name2    /* A59-0362 */ 
                   nv_vatcode  = uwm100.bs_cd.   /* A59-0362 */  
             
           /* A49-0002 */
           RUN pdwh1.   /* calculate tax 1% of V70 (หา n_wh1) */
    
           ASSIGN
               y1    = 0
               z1    = 0
               n_wh1 = IF n_wh1 < 0 THEN 0 ELSE n_wh1.
    
           FOR EACH acd001 USE-INDEX acd00191 WHERE
                    acd001.trnty1 = SUBSTR(agtprm_fil.trntyp,1,1) AND
                    acd001.docno  = agtprm_fil.docno
           NO-LOCK:
               IF acd001.ctrty1 = 'y' THEN y1 = -(acd001.netloc).
               IF acd001.ctrty1 = 'z' THEN z1 = -(acd001.netloc).
           END.
                     /* bal  -  (รายการทีตัดเบี้ยไปแล้วเหลือ <= ภาษี 1 % */
           IF agtprm_fil.bal - (y1 + z1) <= n_wh1 THEN NEXT loop_main.
           /* END A49-0002 */
    
           /* n= new policy, r = renew*/
           IF uwm100.rencnt = 0 OR uwm100.prvpol = "" THEN
                nv_job_nr = "N".
           ELSE nv_job_nr = "R".
              
                       /* 2 - Customer Name  + " " + TRIM(uwm100.name2)*/
           nv_insure = (uwm100.ntitle) + " " + (uwm100.name1).
    
           IF nv_insure = " " THEN nv_insure = agtprm_fil.insure.
    
           /*i*/
           IF (SUBSTR(agtprm_fil.policy,3,2) = "70" ) THEN DO:
              nv_pol72 = "".
              /* {wac\wactas1.i}   /* หา  Compulsory  Policy No.  nv_pol72*/*//*Test*/
              RUN pd_nvpol72_2. 

           END.
           /*end i*/
           
           IF (SUBSTR(agtprm_fil.policy,3,1) = "7" ) AND nv_pol72 <> "" THEN DO:
              FIND FIRST uwm301 USE-INDEX uwm30101      WHERE
                         uwm301.policy = uwm100.policy   AND
                         uwm301.rencnt = uwm100.rencnt   AND
                         uwm301.endcnt = uwm100.endcnt  NO-LOCK NO-ERROR NO-WAIT.
              IF AVAIL uwm301 THEN DO:
                 ASSIGN
                    nv_engine = uwm301.eng_no      /* 5 - 6*/
                    nv_cha_no = uwm301.cha_no.
              END. /*uwm301*/
              ELSE DO:
                 ASSIGN
                    nv_engine = ""
                    nv_cha_no = "".
              END. /* avail uwm301 */
    
              /*-- calculate   0.4 / 100 = 0.004   ,  7 / 100 = 0.07 --*/
              ASSIGN
                 vStamp_comp  = IF (nv_netPrem_comp * 0.004 ) -
                                     TRUNCATE( (nv_netPrem_comp * 0.004 ),0) > 0
                                THEN TRUNCATE( (nv_netPrem_comp * 0.004 ),0) + 1 /* มีทศนิยม  ปัดเศษ + 1 */
                                ELSE TRUNCATE( (nv_netPrem_comp * 0.004 ),0)    /* ไม่มีทศนิยม */
                 vVat_comp         = (nv_netPrem_comp + vStamp_comp) * 0.07
                 nv_grossPrem_comp = nv_netprem_comp  + vStamp_comp + vVat_comp
                 vStamp            = agtprm_fil.stamp - vStamp_comp
                 vVat              = agtprm_fil.tax   - vVat_comp
                 nv_grossPrem      = nv_netprem + vStamp + vVat.
           END.  /* 70 , 72, 73*/
           ELSE DO: /* ---- Suthida T. A52-0299 -----*/
               FIND FIRST uwm301 USE-INDEX uwm30101      WHERE
                          uwm301.policy = uwm100.policy   AND
                          uwm301.rencnt = uwm100.rencnt   AND
                          uwm301.endcnt = uwm100.endcnt  NO-LOCK NO-ERROR NO-WAIT.
               IF AVAIL uwm301 THEN DO:
                  ASSIGN
                     nv_engine = uwm301.eng_no      /* 5 - 6*/
                     nv_cha_no = uwm301.cha_no.
               END. /*uwm301*/
               ELSE DO:
                  ASSIGN
                     nv_engine = ""
                     nv_cha_no = "".
               END. /* avail uwm301 */

               /*-- calculate   0.4 / 100 = 0.004   ,  7 / 100 = 0.07 --*/
               ASSIGN
                  vStamp_comp  = IF (nv_netPrem_comp * 0.004 ) -
                                      TRUNCATE( (nv_netPrem_comp * 0.004 ),0) > 0
                                 THEN TRUNCATE( (nv_netPrem_comp * 0.004 ),0) + 1 /* มีทศนิยม  ปัดเศษ + 1 */
                                 ELSE TRUNCATE( (nv_netPrem_comp * 0.004 ),0)    /* ไม่มีทศนิยม */
                  vVat_comp         = (nv_netPrem_comp + vStamp_comp) * 0.07
                  nv_grossPrem_comp = nv_netprem_comp  + vStamp_comp + vVat_comp
                  vStamp            = agtprm_fil.stamp - vStamp_comp
                  vVat              = agtprm_fil.tax   - vVat_comp
                  nv_grossPrem      = nv_netprem + vStamp + vVat.
           END. /* ---- Suthida T. A52-0299 -----*/
           /*---- A49-0002 ----
           ELSE DO:
              ASSIGN
                 nv_netprem_comp   = 0
                 nv_grossPrem_comp = 0
                 nv_netprem        = agtprm_fil.prem
                 nv_grossPrem      = agtprm_fil.prem + agtprm_fil.stamp + agtprm_fil.tax.
           END. /* <> 70,72,73*/
           -- end A49-0002 --*/
    
           IF (SUBSTR(nv_vehreg,1,1) <> "/") THEN DO:
               nv_vehreg = nv_vehreg.     /* รถเก่า  มีเลขทะเบียน */
           END.
           ELSE DO:   /* SUBSTR(nv_vehreg,1,1) = "/" รถใหม่ ไม่มีทะเบียนรถ */
              IF nv_engine <> "" THEN nv_vehreg = nv_engine.   /* เลขเครื่องยนต์ <> ""  then นำเลขเครื่องยนต์มาใส่ที่ทะเบียนรถ*/
              ELSE nv_vehreg = SUBSTR(nv_vehreg, 1 ,LENGTH(nv_vehreg)).  /* ถ้าเลขเครื่องยนต์ = "" ตัด "/" */
           END.
           /*------------ create data to table wBill -----------*/

           FIND FIRST wBill USE-INDEX  wBill01     WHERE
                      wBill.wAcno   = agtprm_fil.acno    AND
                      wBill.wPolicy = agtprm_fil.policy  AND
                      wBill.wEndno  = agtprm_fil.endno   AND
                      wBill.wtrnty1 = SUBSTR(agtprm_fil.trnty,1,1)  AND
                      wBill.wtrnty2 = SUBSTR(agtprm_fil.trnty,2,1)  AND
                      wBill.wdocno  = agtprm_fil.docno   NO-LOCK NO-ERROR NO-WAIT.
           IF NOT AVAIL wBill THEN DO:
           
               vCountRec = vCountRec + 1.
               DISPLAY "Create data to Table wBill ..."  @ fi_Process  WITH FRAME {&FRAME-NAME}.
               PAUSE 0.
               
               CREATE wBill.
               ASSIGN wBill.wpolicy      = agtprm_fil.policy   /*Policy No.    char   x(16)  */
                      wBill.wacno        = agtprm_fil.acno /*Account Code  char   x(7)   */
                      wBill.wnorpol      = nv_norpol   /*6  Normal Policy no.    char   x(25)   */
                      wBill.wpol72       = nv_pol72    /*7  Compulsory Policy n  char   x(25) */
                      wBill.winsure      = nv_insure   /*8  Customer name        char   x(60) */
                      wBill.wcha_no      = nv_cha_no   /*9  หมายเลขตัวถังรถ      char   x(20)      */
                      wBill.wengine      = nv_engine   /*10 หมายเลขเครื่องยนต์   char   x(20)     */
                      wBill.wVehreg      = nv_vehreg   /*10 หมายเลขทะเบียน       char   x(20)     */
                      wBill.wcomdat      = agtprm_fil.comdat   /*11 Start date yyyymmdd  date   99/99/9999 */
               /*----- A49-0002 -----
               ASSIGN wBill.wtrndat      = nv_exportdat    /*Export Dat    date   99/99/9999  */
                      wBill.wtrntim      = nv_exporttim    /*Trn.Time      char   x(8)   */
                      wBill.wtrnusr      = nv_exportusr    /*Trn.UsrId     char   x(8)   */
                      wBill.wrencnt      = uwm100.rencnt   /*rencnt        inte   >>9    */
                      wBill.wendcnt      = uwm100.endcnt   /*endcnt        inte   999    */
                      wBill.wCompanyCode = "SAFE"          /*1 Insurance's Company  char   x(04)  */
                      wBill.wloop_bill   = "1"  /*2 รอบของการวางบิล      char   x(02)          */
                      wBill.wdate_bill   = STRING(YEAR(TODAY),"9999")
                                         + STRING(MONTH(TODAY),"99")
                                         + STRING(DAY(TODAY),"99")  /*3  รอบวันที่ของการวางบ  char   x(08)        */
                      wBill.wrecordno    = vCountRec   /*4  Record no. 999999    inte   999999  */
                      wBill.wjob_nr      = nv_job_nr   /*5  JOB ('N'=NEW, 'R'=R  char   x        */
                      wBill.effdat      = uwm100.expdat   /*12 yyyymmdd Effective   date   99/99/9999  */
                      wBill.branch      = agtprm_fil.polbran
                      /* ----- */
                      wBill.nor_covamt  = 0   /*13 ทุนประกันเบี้ยหลัก   deci-2 >>,>>>,>>9.99-*/
                      wBill.comp_covamt = 0  /*14 ทุนประกันพรบ.Compl.  deci-2 >>,>>>,>>9.99-*/
                      /* ----- */
                      /* = 0 */
                      wBill.nor_comm    = 0   /*20 Commission amt.(เบี  deci-2 >>,>>>,>>9.99-*/
                      wBill.comp_comm   = 0  /*21 Commission amt.(พรบ  deci-2 >>,>>>,>>9.99-*/
                      wBill.nor_vat     = 0    /*22 VAT Commission(เบี้  deci-2 >>,>>>,>>9.99-*/
                      wBill.comp_vat    = 0   /*23 VAT Commission(พรบ.  deci-2 >>,>>>,>>9.99-*/
                      wBill.nor_tax3    = 0   /*24 With Holding Tax3%   deci-2 >>,>>>,>>9.99-*/
                      wBill.comp_tax3   = 0  /*25 With Holding Tax3%   deci-2 >>,>>>,>>9.99-*/
                      /*---*/
                      wBill.subinscod   = ""  /*27 Sub insurance code(  char   x(04)  */
                      wBill.comp_sub    = ""  /*28 Sub insurance code(  char   x(04)  */
                      wBill.tlt_remark  = ""  /*29 TLT. Remark          char   x(65)       */
                      
                      wBill.total_prm   = nv_grossPrem + nv_grossPrem_comp   /*19 Total Premium (17+1  deci-2 >>,>>>,>>9.99-*/
                                                                             /* (17+18)  GROSS Prem  = nor + comp*/
                ----- A49-0002 -----*/
           
                      wBill.wnetprem       = nv_NetPrem
                                           /*15 Net Premium เบี้ยหลัก = เบี้ยรวม - VAT - Stamp  deci-2 >>,>>>,>>9.99-*/
                      wBill.wcompnetprem   = nv_netPrem_comp                 /*16 Net Premium พรบ.     deci-2 >>,>>>,>>9.99-*/
                                           /*16 Net Premium พรบ. = เบี้ยรวมพรบ. - VAT - Stamp  deci-2 >>,>>>,>>9.99-*/
                      wBill.wgrossprem     = nv_grossPrem
                                           /*17 Normal Gross Premiu = เบี้ย70 + VAT + STAMP  deci-2 >>,>>>,>>9.99-*/
                      wBill.wcompgrossprem = nv_grossPrem_comp
                                           /*18 Compulsory Gross Pr = เบี้ย72 + VAT + STAMP deci-2 >>,>>>,>>9.99-*/
                      wBill.wtax           = n_wh1 /* w/h Tax1%    (15 + 16 + stamp รวม ) *  1%   ถ้าเป็นการ คือเงิน  w/h = 0*/
                      wBill.wNetPayment    = nv_grossPrem + nv_grossPrem_comp - n_wh1
                                                /*26 [ 19 - w/h Tax 1 %  deci-2 >>,>>>,>>9.99-*/
                      wBill.wasdat         = agtprm_fil.asdat
                      wBill.wtrnty1        = SUBSTR(agtprm_fil.trntyp,1,1)
                      wBill.wtrnty2        = SUBSTR(agtprm_fil.trntyp,2,1)
                      wBill.wdocno         = agtprm_fil.docno
                      wBill.wendno         = agtprm_fil.endno
                      wBill.wtrndat1       = agtprm_fil.trndat
                      wBill.wpoltyp        = agtprm_fil.poltyp
                      wBill.wbal           = agtprm_fil.bal
                      /*wBill.wcontract      = "" */
                      wBill.wcontract      = nv_cedpol 
                      wBill.wname2         = nv_name2  /* A59-0362 */
                      wBill.wvatcode       = nv_vatcode. /* A59-0362 */
           
           END. /* find first wBill */
   
        END.  /* avail  uwm100 */
    END.  /* for each agtprm_fil */
END.    /* wfAcno */

IF vCountRec = 0 THEN DO:
    MESSAGE "ไม่พบข้อมูล ที่จะส่งออก" VIEW-AS ALERT-BOX INFORMATION.
    RETURN NO-APPLY.
END.
/*-----------------------------------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------------------------------*/

/* RELEASE Billing. */
RELEASE acProc_fil.
/*=======================End of Include File =============================*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdProc-A490002 C-Win 
PROCEDURE pdProc-A490002 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/


/*------- A49-0002 --------
/*Include File => create record  to table billing tas-----------*/
/*p----------------------------------------*/
FIND LAST  acProc_fil USE-INDEX by_type_asdat WHERE
           acProc_fil.type  = "02"      AND
           acProc_fil.asdat = n_asdat   NO-ERROR.  /* n_asdat */
IF NOT AVAIL acProc_fil THEN DO:
    CREATE acProc_fil.
    ASSIGN acProc_fil.type     = "02"
           acProc_fil.typdesc  = "PROCESS STATEMENT BILLING(TAS)"
           acProc_fil.asdat    = n_asdat       /* วันที่ process statement *//* nv_exportdat  */
           acProc_fil.trndatfr = n_comdatF     /*depend on condition on interface*/
           acProc_fil.trndatto = n_comdatT
           acProc_fil.entdat   = TODAY         /* = nv_exportdat    */
           acProc_fil.enttim   = STRING(TIME, "HH:MM:SS")
           acProc_fil.usrid    = n_user .
END.
/*--------------------------------------p*/

ASSIGN
  nv_exportdat = TODAY
  nv_exporttim = STRING(TIME,"HH:MM:SS")
  nv_exportusr = nv_user
  vCountRec    = 0.
/*p-------------------------------------------------------------------*/
/*--------------------------------------------------------------------p*/
LOOP_MAIN:
FOR EACH  agtprm_fil USE-INDEX by_acno            WHERE
          agtprm_fil.asdat         = n_asdat       AND
  (LOOKUP(agtprm_fil.acno,nv_acnoAll) <> 0 )       AND  /* A46-0426 */
          agtprm_fil.poltyp        = "V70"         AND  /* A49-0002 */
        /*----- A49-0002 ------
         (agtprm_fil.poltyp        = "V70"  OR
          agtprm_fil.poltyp        = "V72")        AND
   SUBSTR(agtprm_fil.policy,7,2)  <> "IS"          AND  /*free compulsory dm7245isxxxx*/
        --- end A49-0002 ---*/
          /* A49-0002 */
         (agtprm_fil.TYPE          = "01"          OR
          agtprm_fil.TYPE          = "05")         AND
          agtprm_fil.trntyp     BEGINS 'M'         AND
          /* END A49-0002 */
/* A46-0426---
         (agtprm_fil.acno          = fi_ac1         OR
          agtprm_fil.acno          = fi_ac2         OR
          agtprm_fil.acno          = fi_ac3         OR
          agtprm_fil.acno          = fi_ac4         OR
          agtprm_fil.acno          = fi_ac5         OR
          agtprm_fil.acno          = fi_ac6         OR
          agtprm_fil.acno          = fi_ac7         OR
          agtprm_fil.acno          = fi_ac8         OR
          agtprm_fil.acno          = fi_ac9         OR
          agtprm_fil.acno          = fi_ac10  )    AND
---A46-0426 */
         (agtprm_fil.polbran      >= n_branch      AND
          agtprm_fil.polbran      <= n_branch2 )   AND
/* A49-0002 ----
     (NOT(agtprm_fil.trntyp     BEGINS 'Y')        AND
      NOT(agtprm_fil.trntyp     BEGINS 'Z') )      AND
---- A49-0002 */      
 /*p*/   (agtprm_fil.comdat       >= n_comdatF     AND
          agtprm_fil.comdat       <= n_comdatT)    AND
          agtprm_fil.bal           > 0                  /* A49-0002 */
/*           agtprm_fil.bal          <> 0 */
    NO-LOCK:
    
    IF agtprm_fil.prem + agtprm_fil.prem_comp = 0 THEN NEXT loop_main.  /* เบี้ยเป็น 0 แต่ยังค้างค่า comm. bal <> 0*/

    /* A49-0002 : check policy cancle */
    FIND LAST acm001 USE-INDEX acm00104 WHERE
              acm001.policy = agtprm_fil.policy NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL acm001 THEN
        IF acm001.trnty1 = "R" AND acm001.trnty2 = "C" THEN NEXT loop_main.
    /* END A49-0002 */

    ASSIGN
       nv_pol72      = ""     nv_norpol   = ""
       nv_insure     = ""     nv_vehreg   = ""
       nv_engine     = ""     nv_cha_no   = ""
       nv_job_nr     = ""  /* nv_opnpol   = "" */
       nv_grossPrem  = 0      nv_grossPrem_comp = 0
       nv_netPrem    = 0      nv_netPrem_comp   = 0
       nv_tax        = 0      nv_netPayment     = 0
       vStamp        = 0      vStamp_comp       = 0
       vVat          = 0      vVat_comp         = 0 .

    DISPLAY  "Process : " + agtprm_fil.policy + '   ' + agtprm_fil.trnty
                   + '  ' + agtprm_fil.docno  @ fi_Process WITH FRAME {&FRAME-NAME}.

    ASSIGN
       nv_norpol   = agtprm_fil.policy + '(' + SUBSTR(agtprm_fil.trntyp,1,1)
                                             + agtprm_fil.docno + ')'
/*        nv_opnpol   = agtprm_fil.opnpol */
       nv_vehreg   = agtprm_fil.vehreg
       nv_netPrem  = agtprm_fil.prem
       nv_netPrem_comp = agtprm_fil.prem_comp .

    /*------------------*/
    /*A47-0235--- 
    FIND FIRST uwm100  use-index uwm10090 WHERE
               uwm100.trty11 = substr(agtprm_fil.trnty, 1 , 1)  AND
               uwm100.docno1 = agtprm_fil.docno
         NO-LOCK NO-ERROR.
    ---A47-0235*/

    FIND FIRST uwm100 USE-INDEX uwm10001 WHERE
               uwm100.policy = agtprm_fil.policy  AND
               uwm100.endno  = agtprm_fil.endno   AND
               uwm100.docno1 = agtprm_fil.docno   NO-LOCK NO-ERROR.
    IF AVAIL uwm100 THEN DO:

       /* A49-0002 */
       RUN pdwh1.   /* calculate tax 1% of V70 (หา n_wh1) */

       ASSIGN
           y1    = 0
           z1    = 0
           n_wh1 = IF n_wh1 < 0 THEN 0 ELSE n_wh1.

       FOR EACH acd001 USE-INDEX acd00191 WHERE
                acd001.trnty1 = SUBSTR(agtprm_fil.trntyp,1,1) AND
                acd001.docno  = agtprm_fil.docno
       NO-LOCK:
           IF acd001.ctrty1 = 'y' THEN y1 = -(acd001.netloc).
           IF acd001.ctrty1 = 'z' THEN z1 = -(acd001.netloc).
       END.
                 /* bal  -  (รายการทีตัดเบี้ยไปแล้วเหลือ <= ภาษี 1 % */
       IF agtprm_fil.bal - (y1 + z1) <= n_wh1 THEN NEXT loop_main.
       /* END A49-0002 */

       /* n= new policy, r = renew*/
       IF uwm100.rencnt = 0 OR uwm100.prvpol = "" THEN
            nv_job_nr = "N".
       ELSE nv_job_nr = "R".
          
                   /* 2 - Customer Name  + " " + TRIM(uwm100.name2)*/
       nv_insure = (uwm100.ntitle) + " " + (uwm100.name1).

       IF nv_insure = " " THEN nv_insure = agtprm_fil.insure.

       /*i*/
       IF (SUBSTR(agtprm_fil.policy,3,2) = "70" ) THEN DO:
          nv_pol72 = "".
          {wac\wactas1.i}   /* หา  Compulsory  Policy No.  nv_pol72*/
       END.
       /*end i*/

       IF (SUBSTR(agtprm_fil.policy,3,1) = "7" ) THEN DO:
          FIND FIRST uwm301 USE-INDEX uwm30101      WHERE
                     uwm301.policy = uwm100.policy   AND
                     uwm301.rencnt = uwm100.rencnt   AND
                     uwm301.endcnt = uwm100.endcnt  NO-LOCK NO-ERROR NO-WAIT.
          IF AVAIL uwm301 THEN DO:
             ASSIGN
                nv_engine = uwm301.eng_no      /* 5 - 6*/
                nv_cha_no = uwm301.cha_no.
          END. /*uwm301*/
          ELSE DO:
             ASSIGN
                nv_engine = ""
                nv_cha_no = "".
          END. /* avail uwm301 */

          /*-- calculate   0.4 / 100 = 0.004   ,  7 / 100 = 0.07 --*/
          ASSIGN
             vStamp_comp  = IF (nv_netPrem_comp * 0.004 ) -
                                 TRUNCATE( (nv_netPrem_comp * 0.004 ),0) > 0
                            THEN TRUNCATE( (nv_netPrem_comp * 0.004 ),0) + 1 /* มีทศนิยม  ปัดเศษ + 1 */
                            ELSE TRUNCATE( (nv_netPrem_comp * 0.004 ),0)    /* ไม่มีทศนิยม */
             vVat_comp         = (nv_netPrem_comp + vStamp_comp) * 0.07
             nv_grossPrem_comp = nv_netprem_comp + vStamp_comp + vVat_comp
             vStamp            = agtprm_fil.stamp - vStamp_comp
             vVat              = agtprm_fil.tax   - vVat_comp
             nv_grossPrem      = nv_netprem + vStamp + vVat.
       END.  /* 70 , 72, 73*/
       /*---- A49-0002 ----
       ELSE DO:
          ASSIGN
             nv_netprem_comp   = 0
             nv_grossPrem_comp = 0
             nv_netprem        = agtprm_fil.prem
             nv_grossPrem      = agtprm_fil.prem + agtprm_fil.stamp + agtprm_fil.tax.
       END. /* <> 70,72,73*/
       -- end A49-0002 --*/

       IF (SUBSTR(nv_vehreg,1,1) <> "/") THEN DO:
           nv_vehreg = nv_vehreg.     /* รถเก่า  มีเลขทะเบียน */
       END.
       ELSE DO:   /* SUBSTR(nv_vehreg,1,1) = "/" รถใหม่ ไม่มีทะเบียนรถ */
          IF nv_engine <> "" THEN nv_vehreg = nv_engine.   /* เลขเครื่องยนต์ <> ""  then นำเลขเครื่องยนต์มาใส่ที่ทะเบียนรถ*/
          ELSE nv_vehreg = SUBSTR(nv_vehreg, 1 ,LENGTH(nv_vehreg)).  /* ถ้าเลขเครื่องยนต์ = "" ตัด "/" */
       END.

       /*------------ create data to table billing -----------*/
       FIND FIRST billing USE-INDEX  billing04     WHERE
                  billing.Asdat  = agtprm_fil.asdat   AND
                  billing.Acno1  = agtprm_fil.acno    AND
                  billing.Poltyp = agtprm_fil.poltyp  AND
                  billing.Policy = agtprm_fil.policy  AND
                  billing.Endno  = agtprm_fil.endno   AND
                  billing.trndat = nv_exportdat       AND
                  billing.trnty1 = SUBSTR(agtprm_fil.trnty,1,1)  AND
                  billing.trnty2 = SUBSTR(agtprm_fil.trnty,2,1)  AND
                  billing.docno  = agtprm_fil.docno   NO-ERROR NO-WAIT.
       IF NOT AVAIL billing THEN DO:

           vCountRec = vCountRec + 1.
           DISPLAY "Create data to Table billing ..."  @ fi_Process  WITH FRAME {&FRAME-NAME}.
           
           CREATE billing.
           ASSIGN billing.trndat      = nv_exportdat    /*Export Dat    date   99/99/9999  */
                  billing.trntim      = nv_exporttim    /*Trn.Time      char   x(8)   */
                  billing.trnusr      = nv_exportusr    /*Trn.UsrId     char   x(8)   */
                  billing.policy      = agtprm_fil.policy   /*Policy No.    char   x(16)  */

                  billing.rencnt      = uwm100.rencnt   /*rencnt        inte   >>9    */
                  billing.endcnt      = uwm100.endcnt   /*endcnt        inte   999    */
                  billing.acno1       = agtprm_fil.acno /*Account Code  char   x(7)   */
                  billing.CompanyCode = "SAFE"          /*1 Insurance's Company  char   x(04)  */
                  billing.loop_bill   = "1"  /*2 รอบของการวางบิล      char   x(02)          */
                  billing.date_bill   = STRING(YEAR(TODAY),"9999")
                                      + STRING(MONTH(TODAY),"99")
                                      + STRING(DAY(TODAY),"99")  /*3  รอบวันที่ของการวางบ  char   x(08)        */
                  billing.recordno    = vCountRec   /*4  Record no. 999999    inte   999999  */
                  billing.job_nr      = nv_job_nr   /*5  JOB ('N'=NEW, 'R'=R  char   x        */
                  billing.nor_policy  = nv_norpol   /*6  Normal Policy no.    char   x(25)   */
                  billing.comp_policy = nv_pol72    /*7  Compulsory Policy n  char   x(25) */
                  billing.cust_name   = nv_insure   /*8  Customer name        char   x(60) */
                  billing.chassis     = nv_cha_no   /*9  หมายเลขตัวถังรถ      char   x(20)      */
                  billing.engine      = nv_engine   /*10 หมายเลขเครื่องยนต์   char   x(20)     */
                  billing.vehreg      = nv_vehreg   /*10 หมายเลขทะเบียน       char   x(20)     */
                  billing.start_date  = agtprm_fil.comdat   /*11 Start date yyyymmdd  date   99/99/9999 */
                  billing.effdat      = uwm100.expdat   /*12 yyyymmdd Effective   date   99/99/9999  */
                  /* ----- */
                  billing.nor_covamt  = 0   /*13 ทุนประกันเบี้ยหลัก   deci-2 >>,>>>,>>9.99-*/
                  billing.comp_covamt = 0  /*14 ทุนประกันพรบ.Compl.  deci-2 >>,>>>,>>9.99-*/
                  /* ----- */
                  billing.nor_netprm  = nv_NetPrem
                                        /*15 Net Premium เบี้ยหลัก = เบี้ยรวม - VAT - Stamp  deci-2 >>,>>>,>>9.99-*/
                  billing.comp_netprm = nv_netPrem_comp                 /*16 Net Premium พรบ.     deci-2 >>,>>>,>>9.99-*/
                                        /*16 Net Premium พรบ. = เบี้ยรวมพรบ. - VAT - Stamp  deci-2 >>,>>>,>>9.99-*/
                  billing.nor_grp     = nv_grossPrem
                                        /*17 Normal Gross Premiu = เบี้ย70 + VAT + STAMP  deci-2 >>,>>>,>>9.99-*/
                  billing.comp_grp    = nv_grossPrem_comp
                                        /*18 Compulsory Gross Pr = เบี้ย72 + VAT + STAMP deci-2 >>,>>>,>>9.99-*/
                  billing.total_prm   = nv_grossPrem + nv_grossPrem_comp   /*19 Total Premium (17+1  deci-2 >>,>>>,>>9.99-*/
                                                                         /* (17+18)  GROSS Prem  = nor + comp*/
                  /* = 0 */
                  billing.nor_comm    = 0   /*20 Commission amt.(เบี  deci-2 >>,>>>,>>9.99-*/
                  billing.comp_comm   = 0  /*21 Commission amt.(พรบ  deci-2 >>,>>>,>>9.99-*/
                  billing.nor_vat     = 0    /*22 VAT Commission(เบี้  deci-2 >>,>>>,>>9.99-*/
                  billing.comp_vat    = 0   /*23 VAT Commission(พรบ.  deci-2 >>,>>>,>>9.99-*/
                  billing.nor_tax3    = 0   /*24 With Holding Tax3%   deci-2 >>,>>>,>>9.99-*/
                  billing.comp_tax3   = 0  /*25 With Holding Tax3%   deci-2 >>,>>>,>>9.99-*/
                  /*---*/

                  billing.whtax1      = n_wh1 /* w/h Tax1%    (15 + 16 + stamp รวม ) *  1%   ถ้าเป็นการ คือเงิน  w/h = 0*/
                  billing.net_amount  = nv_grossPrem + nv_grossPrem_comp - n_wh1
                                            /*26 [ 19 - w/h Tax 1 %  deci-2 >>,>>>,>>9.99-*/

                  billing.subinscod   = ""  /*27 Sub insurance code(  char   x(04)  */
                  billing.comp_sub    = ""  /*28 Sub insurance code(  char   x(04)  */
                  billing.tlt_remark  = ""  /*29 TLT. Remark          char   x(65)       */

                  billing.branch      = agtprm_fil.polbran
                  billing.asdat       = agtprm_fil.asdat
                  billing.trnty1      = SUBSTR(agtprm_fil.trntyp,1,1)
                  billing.trnty2      = SUBSTR(agtprm_fil.trntyp,2,1)
                  billing.docno       = agtprm_fil.docno
                  billing.endno       = agtprm_fil.endno
                  billing.trndat1     = agtprm_fil.trndat
                  billing.poltyp      = agtprm_fil.poltyp
                  billing.bal         = agtprm_fil.bal .

       END. /* find first billing */

    END.  /* avail  uwm100 */
END.  /* for each agtprm_fil */

IF vCountRec = 0 THEN DO:
    MESSAGE "ไม่พบข้อมูล ที่จะส่งออก" VIEW-AS ALERT-BOX INFORMATION.
    RETURN NO-APPLY.
END.
/*-----------------------------------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------------------------------*/

RELEASE billing.
RELEASE acProc_fil.
/*=======================End of Include File =============================*/
------- A49-0002 --------*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdProc-A490002-old C-Win 
PROCEDURE pdProc-A490002-old :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

/*------ A49-0002 ------
/*Include File => create record  to table billing tas-----------*/
/*p----------------------------------------*/ 
FIND LAST  acProc_fil USE-INDEX by_type_asdat WHERE
           acProc_fil.type  = "02"      AND
           acProc_fil.asdat = n_asdat   NO-ERROR.  /* n_asdat */
IF NOT AVAIL acProc_fil THEN DO:
    CREATE acProc_fil.
    ASSIGN acProc_fil.type     = "02"
           acProc_fil.typdesc  = "PROCESS STATEMENT BILLING(TAS)"
           acProc_fil.asdat    = n_asdat       /* วันที่ process statement *//* nv_exportdat  */
           acProc_fil.trndatfr = n_comdatF  /*depend on condition on interface*/
           acProc_fil.trndatto = n_comdatT
           acProc_fil.entdat   = TODAY         /* = nv_exportdat    */
           acProc_fil.enttim   = STRING (TIME, "HH:MM:SS")
           acProc_fil.usrid    = n_user .
END.
/*--------------------------------------p*/

FOR EACH wBill: DELETE  wBill. END.
/*p-------------------------------------------------------------------*/
/*--------------------------------------------------------------------p*/
FOR EACH  agtprm_fil USE-INDEX by_acno            WHERE
          agtprm_fil.asdat         = n_asdat       AND
  (LOOKUP(agtprm.acno,nv_acnoAll) <> 0 )           AND  /* A46-0426*/
/* A46-0426---
         (agtprm_fil.acno          = fi_ac1         OR
          agtprm_fil.acno          = fi_ac2         OR
          agtprm_fil.acno          = fi_ac3         OR
          agtprm_fil.acno          = fi_ac4         OR
          agtprm_fil.acno          = fi_ac5         OR
          agtprm_fil.acno          = fi_ac6         OR
          agtprm_fil.acno          = fi_ac7         OR
          agtprm_fil.acno          = fi_ac8         OR
          agtprm_fil.acno          = fi_ac9         OR
          agtprm_fil.acno          = fi_ac10  )    AND
---A46-0426 */
         (agtprm_fil.polbran      >= n_branch      AND
          agtprm_fil.polbran      <= n_branch2 )   AND
     (NOT(agtprm_fil.trntyp     BEGINS 'Y')        AND
      NOT(agtprm_fil.trntyp     BEGINS 'Z') )      AND
 /*p*/   (agtprm_fil.comdat       >= n_comdatF     AND
          agtprm_fil.comdat       <= n_comdatT)    AND
          agtprm_fil.bal          <> 0             NO-LOCK:

    ASSIGN
       nv_acno       = ""
       nv_policy     = ""     nv_pol72    = ""   nv_norpol = ""
       nv_endno      = ""
       nv_polbran    = ""     nv_poltyp   = ""
       nv_trnty1     = ""     nv_trnty2   = ""   nv_docno  = ""
       nv_asdat      = ?      nv_trndat1  = ?
       nv_insref     = ""     nv_insure   = ""
       nv_engine     = ""     nv_cha_no   = ""
       nv_opnpol     = ""     nv_vehreg   = ""
       nv_comdat     = ?      nv_expdat   = ?
       nv_grossPrem  = 0      nv_grossPrem_comp = 0
       nv_netPrem    = 0      nv_netPrem_comp   = 0
       nv_tax        = 0      nv_netPayment     = 0
       nv_rencnt     = 0      nv_endcnt         = 0
       nv_job_nr     = ""
       vStamp        = 0      vVat = 0
       vStamp_comp   = 0      vVat_comp = 0   nv_bal = 0.
     /**/
    ASSIGN
       nv_acno     = agtprm_fil.acno
       nv_norpol   = agtprm_fil.policy + '(' + SUBSTR(agtprm_fil.trntyp, 1 , 1) +
                     agtprm_fil.docno + ')'
       nv_policy   = agtprm_fil.policy
       nv_endno    = agtprm_fil.endno
       nv_polbran  = agtprm_fil.polbran
       nv_trnty1   = SUBSTR(agtprm_fil.trntyp,1,1)
       nv_trnty2   = SUBSTR(agtprm_fil.trntyp,2,1)
       nv_docno    = agtprm_fil.docno
       nv_asdat    = agtprm_fil.asdat
       nv_trndat1  = agtprm_fil.trndat
       nv_opnpol   = agtprm_fil.opnpol
       nv_vehreg   = agtprm_fil.vehreg
       nv_comdat   = agtprm_fil.comdat
       nv_netPrem  = agtprm_fil.prem
       nv_netPrem_comp = agtprm_fil.prem_comp
       nv_poltyp   = agtprm_fil.poltyp
       nv_bal      = agtprm_fil.bal.
    /*------------------*/
    /*A47-0235--- 
    FIND FIRST uwm100  use-index uwm10090 WHERE
               uwm100.trty11 = substr(agtprm_fil.trnty, 1 , 1)  AND
               uwm100.docno1 = agtprm_fil.docno
         NO-LOCK NO-ERROR.
    ---A47-0235*/

    FIND FIRST uwm100 WHERE
               uwm100.policy = agtprm_fil.policy  AND
               uwm100.endno  = agtprm_fil.endno   AND
               uwm100.docno1 = agtprm_fil.docno   NO-LOCK NO-ERROR.
    IF AVAIL uwm100 THEN DO:
       ASSIGN
          nv_expdat = uwm100.expdat
          nv_rencnt = uwm100.rencnt
          nv_endcnt = uwm100.endcnt
   /*p*/  nv_insure = (uwm100.ntitle) + " " + (uwm100.name1)    /* 2 - Customer Name  + " " + TRIM(uwm100.name2)*/
          
          nv_job_nr = IF uwm100.rencnt = 0  THEN "N" ELSE "R".  /* n= new policy, r = renew*/
          nv_job_nr = IF uwm100.prvpol = "" THEN "N" ELSE "R".
   /*i*/
       IF (SUBSTR(agtprm_fil.policy,3,2) = "70" ) THEN DO:
          nv_pol72 = "".
          {wac\wactas1.i}        /* หา  Compulsory  Policy No.  nv_pol72*/
       END.
   /*end i*/

       IF (SUBSTR(agtprm_fil.policy,3,1) = "7" ) THEN DO:
          FIND FIRST uwm301 USE-INDEX uwm30101      WHERE
                     uwm301.policy = uwm100.policy   AND
                     uwm301.rencnt = uwm100.rencnt   AND
                     uwm301.endcnt = uwm100.endcnt  NO-LOCK NO-ERROR NO-WAIT.
          IF AVAIL uwm301 THEN DO:
             ASSIGN
                nv_engine = uwm301.eng_no      /* 5 - 6*/
                nv_cha_no = uwm301.cha_no.
          END. /*uwm301*/
          ELSE DO:
             ASSIGN
                nv_engine = ""
                nv_cha_no = "".
          END. /* avail uwm301 */

          /*-- calculate   0.4 / 100 = 0.004   ,  7 / 100 = 0.07 --*/
          ASSIGN
             vStamp_comp  = IF (nv_netPrem_comp * 0.004 ) -
                               TRUNCATE((nv_netPrem_comp * 0.004 ),0) > 0
                            THEN TRUNCATE( (nv_netPrem_comp * 0.004),0) + 1 /* มีทศนิยม  ปัดเศษ + 1 */
                            ELSE TRUNCATE( (nv_netPrem_comp * 0.004 ),0)    /* ไม่มีทศนิยม */
             vVat_comp         = (nv_netPrem_comp + vStamp_comp) * 0.07
             nv_grossPrem_comp = nv_netprem_comp + vStamp_comp + vVat_comp
             vStamp            = agtprm_fil.stamp - vStamp_comp
             vVat              = agtprm_fil.tax   - vVat_comp
             nv_grossPrem      = nv_netprem + vStamp + vVat.
       END.  /* 70 , 72, 73*/
       ELSE DO:
          ASSIGN
             nv_netprem_comp   = 0
             nv_grossPrem_comp = 0
             nv_netprem        = agtprm_fil.prem
             nv_grossPrem      = agtprm_fil.prem + agtprm_fil.stamp + agtprm_fil.tax.
       END. /* <> 70,72,73*/

       IF nv_insure = " " THEN nv_insure = agtprm_fil.insure.

       IF (SUBSTR(nv_vehreg,1,1) <> "/") THEN DO:
           nv_vehreg = nv_vehreg.     /* รถเก่า  มีเลขทะเบียน */
       END.
       ELSE DO:   /* SUBSTR(nv_vehreg,1,1) = "/" รถใหม่ ไม่มีทะเบียนรถ */
          IF nv_engine <> "" THEN nv_vehreg = nv_engine.   /* เลขเครื่องยนต์ <> ""  then นำเลขเครื่องยนต์มาใส่ที่ทะเบียนรถ*/
          ELSE nv_vehreg = SUBSTR(nv_vehreg, 1 ,LENGTH(nv_vehreg)).  /* ถ้าเลขเครื่องยนต์ = "" ตัด "/" */
       END.

       RUN pdwh1.   /* tax 1 % */

       /*------------ create  data to   table billing &  temp-table wBill -----------*/
    
       DISP  "Process : " + agtprm_fil.policy + '   ' + agtprm_fil.trnty + '  ' + agtprm_fil.docno  @ fi_Process
       WITH FRAME {&FRAME-NAME} .

       FIND FIRST wbill USE-INDEX   wBill01 WHERE
                  wbill.wAcno   = agtprm_fil.acno                  AND
                  wbill.wPolicy = agtprm_fil.policy                AND
                  wbill.wEndno  = agtprm_fil.endno                 AND
                  wbill.wTrnty1 = SUBSTR(agtprm_fil.trnty , 1 , 1) AND
                  wbill.wTrnty2 = SUBSTR(agtprm_fil.trnty , 2 , 1) AND
                  wbill.wDocno  = agtprm_fil.docno        NO-ERROR NO-WAIT.
       IF NOT AVAIL wbill THEN
           CREATE wBill.
       
       ASSIGN
         /*wRecordno = vCount*/
           wpoltyp        = nv_poltyp
           wAcno          = nv_acno
           wPolicy        = nv_policy
           wNorpol        = nv_norpol
           wPol72         = nv_pol72
           wEndno         = nv_endno
           wPolbran       = nv_polbran
           wTrnty1        = nv_trnty1
           wTrnty2        = nv_trnty2
           wDocno         = nv_docno
           wTrndat        = TODAY
           wAsdat         = nv_asdat
           wTrndat1       = nv_trndat1
           wInsref        = nv_Insref
           wInsure        = nv_Insure
           wEngine        = nv_engine
           wCha_no        = nv_cha_no
           wOpnpol        = nv_opnpol
           wVehreg        = nv_vehreg
           wComdat        = nv_comdat
           wRencnt        = nv_rencnt /**/
           wEndcnt        = nv_endcnt
           wGrossPrem     = nv_grossPrem             /* 10*/
           wCompGrossPrem = nv_grossPrem_comp        /* 11 */
           wNetPrem       = nv_netPrem               /* 12 */
           wCompNetPrem   = nv_netPrem_comp          /* 13 */
/*p
           wTax = ((nv_netPrem + nv_netPrem_comp + agtprm_fil.stamp ) * 1) / 100   /* 12+13+stamp * 1% */
p*/
           wTax        = n_wh1
           wTax        = IF wTax < 0 THEN 0 ELSE wTax    /* ถัาเป็น ค่า ลบ  จะไม่มีภาษีนี้*/

     /*p*/ wNetPayment = (nv_grossPrem + nv_grossPrem_comp - wTax)  /* 10+11-14 */

           wjob_nr     = nv_job_nr

           wnor_covamt = 0  wcomp_covamt = 0  /* si*/

           wnor_comm = 0      wcomp_comm = 0
           wnor_vat  = 0      wcomp_vat  = 0
           wnor_tax3 = 0      wcomp_tax3 = 0.
           wbal = nv_bal.

       ASSIGN
           wGPs     = fuDeciToChar(wGrossPrem,10)   /*  func: fuDeciToChar(source,จำนวนตัวอักษร) */
           wcompGPs = fuDeciToChar(wCompGrossPrem,10)
           wNPs     = fuDeciToChar(wNetPrem,10)
           wcompNPs = fuDeciToChar(wCompNetPrem,10)
           wTaxs    = fuDeciToChar(wTax,10)
           wNetPays = fuDeciToChar(wNetPayment,10).

         /*vCount = vCount + 1.*/
         /*-----------*/
    END.  /* avail  uwm100 */
END.  /* for each agtprm_fil */

/*-----------------------------------------------------------------------------------------------------*/
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
      nv_exportusr = nv_user .
/*       vCount = 1 . */
   DISP  "Create data to Table billing ..."  @ fi_Process  WITH FRAME {&frame-name} .

   FOR EACH wBill USE-INDEX wBill01 :
      FIND FIRST billing USE-INDEX  billing05     WHERE
                 billing.Acno     = wbill.wacno    AND
                 billing.Policy   = wbill.wpolicy  AND
                 billing.Endno    = wbill.wendno   AND
/*                 billing.trndat1 = wbill.wtrndat   and*/
                 billing.trndat = nv_exportdat     AND
                 billing.trnty1  = wbill.wtrnty1   AND
                 billing.trnty2  = wbill.wtrnty2   AND
                 billing.docno   = wbill.wdocno   NO-ERROR NO-WAIT.
      IF NOT AVAIL billing THEN DO:

         CREATE billing.
         ASSIGN billing.trndat      = nv_exportdat    /*Export Dat    date   99/99/9999  */
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
                billing.cust_name   = wbill.wInsure   /*8  Customer name        char   x(60) */
                billing.chassis     = wbill.wCha_no   /*9  หมายเลขตัวถังรถ      char   x(20)      */
                billing.engine      = wbill.wEngine   /*10 หมายเลขเครื่องยนต์   char   x(20)     */
                billing.vehreg      = wbill.wVehreg   /*10 หมายเลขทะเบียน       char   x(20)     */
                billing.start_date  = wbill.wComdat   /*11 Start date yyyymmdd  date   99/99/9999 */
                billing.effdat      = wbill.wExpdat   /*12 yyyymmdd Effective   date   99/99/9999  */
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
                billing.trndat1     = wbill.wtrndat1
                billing.poltyp      = wbill.wpoltyp
                billing.bal         = wbill.wbal.

/*    vCount = vCount + 1.*/
    
    /* เก็บ recid ของ billing   ลงใน work-table  wbill   เพื่อนำไปใช้ใน pdo3 */
/*         wbill.wrecid = RECID(billing).  */

      END.  /*  if not avail  billing*/
   END.  /* for each wBill */
END. /* IF AVAIL wBill */

RELEASE billing.
RELEASE acProc_fil.
/*=======================End of Include File =============================*/
------ A49-0002 ------*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdproc2 C-Win 
PROCEDURE pdproc2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FIND LAST  acProc_fil USE-INDEX by_type_asdat WHERE
    acProc_fil.type  = "02"      AND
    acProc_fil.asdat = n_asdat   NO-ERROR.   /* n_asdat */
IF NOT AVAIL acProc_fil THEN DO:
    CREATE acProc_fil.
    ASSIGN acProc_fil.type  = "02"
        acProc_fil.typdesc  = "PROCESS STATEMENT BILLING(TAS)"
        acProc_fil.asdat    = n_asdat       /* วันที่ process statement *//* nv_exportdat  */
        acProc_fil.trndatfr = n_comdatF     /*depend on condition on interface*/
        acProc_fil.trndatto = n_comdatT
        acProc_fil.entdat   = TODAY         /* = nv_exportdat    */
        acProc_fil.enttim   = STRING(TIME, "HH:MM:SS")
        acProc_fil.usrid    = n_user .
END.
RELEASE acProc_fil. /*Sarinya C. A59-0362*/  

FOR EACH wBill: DELETE  wBill. END.
FOR EACH wagtprm_fil: DELETE  wagtprm_fil. END.
ASSIGN
    nv_exportdat = TODAY
    nv_exporttim = STRING(TIME,"HH:MM:SS")
    nv_exportusr = nv_user
    vCountRec    = 0.

FOR EACH wfAcno USE-INDEX wList01 NO-LOCK:
    LOOP_MAIN:
    FOR EACH  agtprm_fil USE-INDEX by_acno            WHERE
        agtprm_fil.asdat         = n_asdat       AND
        agtprm_fil.trndat       >= n_comdatF     AND  
        agtprm_fil.trndat       <= n_comdatT     AND
        agtprm_fil.acno          = wfAcno.wacno  AND  
        (agtprm_fil.poltyp       = "V70"         OR  
         agtprm_fil.poltyp       = "V72")        AND  
        (agtprm_fil.TYPE         = "01"          OR 
         agtprm_fil.TYPE         = "05")         AND
        agtprm_fil.trntyp     BEGINS 'M'         AND
        (agtprm_fil.polbran      >= n_branch     AND
         agtprm_fil.polbran      <= n_branch2 )  AND
        agtprm_fil.bal           >  0            NO-LOCK:
        IF agtprm_fil.prem + agtprm_fil.prem_comp = 0 THEN NEXT loop_main.  /* เบี้ยเป็น 0 แต่ยังค้างค่า comm. bal <> 0*/
        /*  : check policy cancle */
        FIND LAST acm001 USE-INDEX acm00104 WHERE
            acm001.policy = agtprm_fil.policy NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL acm001 THEN
            IF acm001.trnty1 = "R" AND acm001.trnty2 = "C" THEN NEXT loop_main.
        FIND FIRST wagtprm_fil USE-INDEX wagtprm_fil01 WHERE 
            wagtprm_fil.acno      = agtprm_fil.acno    AND
            wagtprm_fil.policy    = agtprm_fil.policy  AND
            wagtprm_fil.docno     = agtprm_fil.docno   AND
            wagtprm_fil.vehreg    = agtprm_fil.vehreg  AND
            wagtprm_fil.endno     = agtprm_fil.endno   NO-ERROR NO-WAIT.
        IF NOT AVAIL wagtprm_fil THEN CREATE wagtprm_fil.
        ASSIGN wagtprm_fil.policy = agtprm_fil.policy
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
        
    END.   /* for each agtprm_fil */  
END.       /* wfAcno */ 

loop_main2:
FOR EACH wagtprm_fil  NO-LOCK.
    ASSIGN
        nv_pol72      = ""     nv_norpol   = ""
        nv_insure     = ""     nv_vehreg   = ""
        nv_engine     = ""     nv_cha_no   = ""
        nv_job_nr     = ""  /* nv_opnpol   = "" */
        nv_grossPrem  = 0      nv_grossPrem_comp = 0
        nv_netPrem    = 0      nv_netPrem_comp   = 0
        nv_tax        = 0      nv_netPayment     = 0
        vStamp        = 0      vStamp_comp       = 0
        vVat          = 0      vVat_comp         = 0
        nv_cedpol     = ""   
        nv_name2      = "" 
        nv_vatcode    = "" . 
         
    DISPLAY  "Process : " + wagtprm_fil.policy + '   ' + wagtprm_fil.trnty
                  + '  ' + wagtprm_fil.docno FORMAT "X(10)" /* Benjaporn J. A60-0267 date 27/06/2017 */
          @ fi_Process WITH FRAME {&FRAME-NAME}.

   ASSIGN

     /* nv_norpol   = agtprm_fil.policy + '(' + SUBSTR(agtprm_fil.trntyp,1,1)
                                            + agtprm_fil.docno + ')'*/
/*        nv_opnpol   = agtprm_fil.opnpol */
      nv_vehreg   = wagtprm_fil.vehreg
      nv_netPrem  = wagtprm_fil.prem
      nv_netPrem_comp = wagtprm_fil.prem_comp .

  /* nv_norpol  70
     nv_pol72   72*/
   IF (SUBSTR(wagtprm_fil.policy,3,2) = "70" ) THEN  
          nv_norpol = wagtprm_fil.policy + '(' + SUBSTR(wagtprm_fil.trntyp,1,1)
                   + wagtprm_fil.docno + ')'.
   ELSE   nv_pol72 = wagtprm_fil.policy + '(' + SUBSTR(wagtprm_fil.trntyp,1,1)
                   + wagtprm_fil.docno + ')'.



   /*------------------*/
   /*A47-0235--- 
   FIND FIRST uwm100  use-index uwm10090 WHERE
              uwm100.trty11 = substr(agtprm_fil.trnty, 1 , 1)  AND
              uwm100.docno1 = agtprm_fil.docno
        NO-LOCK NO-ERROR.
   ---A47-0235*/

   FIND FIRST uwm100 USE-INDEX uwm10001 WHERE
              uwm100.policy = wagtprm_fil.policy  AND
              uwm100.endno  = wagtprm_fil.endno   AND
              uwm100.docno1 = wagtprm_fil.docno   NO-LOCK NO-ERROR.
   IF AVAIL uwm100 THEN DO:
       ASSIGN nv_cedpol   = uwm100.cedpol
              nv_name2    = uwm100.name2    /* A59-0362 */ 
              nv_vatcode  = uwm100.bs_cd.   /* A59-0362 */  
 
        
        RUN pdwh1_2.   /* calculate tax 1% of V70 (หา n_wh1) */

        ASSIGN  y1    = 0
            z1    = 0
            n_wh1 = IF n_wh1 < 0 THEN 0 ELSE n_wh1.
        FOR EACH acd001 USE-INDEX acd00191 WHERE
            acd001.trnty1 = SUBSTR(wagtprm_fil.trntyp,1,1)  AND     
            acd001.docno  = wagtprm_fil.docno               NO-LOCK:    
            IF acd001.ctrty1 = 'y' THEN y1 = -(acd001.netloc).
            IF acd001.ctrty1 = 'z' THEN z1 = -(acd001.netloc).
        END.   /* bal  -  (รายการทีตัดเบี้ยไปแล้วเหลือ <= ภาษี 1 % */
        IF wagtprm_fil.bal - (y1 + z1) <= n_wh1 THEN NEXT loop_main2.   
        /* n= new policy, r = renew*/
        IF uwm100.rencnt = 0 OR uwm100.prvpol = "" THEN
            nv_job_nr = "N".
        ELSE nv_job_nr = "R".
             /* 2 - Customer Name  + " " + TRIM(uwm100.name2)*/
        nv_insure = (uwm100.ntitle) + " " + (uwm100.name1).
        IF nv_insure = " " THEN nv_insure = wagtprm_fil.insure.    
        /*i*/
        nv_pol72 = "".
        IF (wagtprm_fil.poltyp = "v70" ) OR  
            (wagtprm_fil.poltyp = "v72" AND SUBSTR(wagtprm_fil.policy,7,1) <> "t" ) THEN  
             /* {wac\wactas2.i} */
           RUN pd_nvpol72_2. 
        
            
        IF (SUBSTR(wagtprm_fil.policy,3,1) = "7" ) AND nv_pol72 <> "" THEN DO: 
            FIND FIRST uwm301 USE-INDEX uwm30101      WHERE
                uwm301.policy = uwm100.policy   AND
                uwm301.rencnt = uwm100.rencnt   AND
                uwm301.endcnt = uwm100.endcnt  NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL uwm301 THEN DO:
                ASSIGN  nv_engine = uwm301.eng_no      /* 5 - 6*/
                    nv_cha_no = uwm301.cha_no.
            END. /*uwm301*/
            ELSE DO:
                ASSIGN
                    nv_engine = ""
                    nv_cha_no = "".
            END.  /* avail uwm301 */
            /*-- calculate   0.4 / 100 = 0.004   ,  7 / 100 = 0.07 --*/
            ASSIGN  vStamp_comp  = IF (nv_netPrem_comp * 0.004 ) - TRUNCATE( (nv_netPrem_comp * 0.004 ),0) > 0
                                   THEN TRUNCATE( (nv_netPrem_comp * 0.004 ),0) + 1  /* มีทศนิยม  ปัดเศษ + 1 */
                                   ELSE TRUNCATE( (nv_netPrem_comp * 0.004 ),0)      /* ไม่มีทศนิยม */
                vVat_comp         = (nv_netPrem_comp + vStamp_comp) * 0.07
                nv_grossPrem_comp = nv_netprem_comp  + vStamp_comp + vVat_comp
                vStamp            = wagtprm_fil.stamp - vStamp_comp 
                vVat              = wagtprm_fil.tax   - vVat_comp 
                nv_grossPrem      = nv_netprem + vStamp + vVat.
        END.   /* 70 , 72, 73*/
        ELSE DO: /* ---- Suthida T. A52-0299 -----*/
            FIND FIRST uwm301 USE-INDEX uwm30101      WHERE
                uwm301.policy = uwm100.policy   AND
                uwm301.rencnt = uwm100.rencnt   AND
                uwm301.endcnt = uwm100.endcnt  NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL uwm301 THEN DO:
                ASSIGN  nv_engine = uwm301.eng_no      /* 5 - 6*/
                    nv_cha_no = uwm301.cha_no.
            END.  /*uwm301*/
            ELSE DO:
                ASSIGN
                    nv_engine = ""
                    nv_cha_no = "".
            END. /* avail uwm301 */
            /*-- calculate   0.4 / 100 = 0.004   ,  7 / 100 = 0.07 --*/
            ASSIGN
                vStamp_comp  = IF (nv_netPrem_comp * 0.004 ) - TRUNCATE( (nv_netPrem_comp * 0.004 ),0) > 0
                               THEN TRUNCATE( (nv_netPrem_comp * 0.004 ),0) + 1  /* มีทศนิยม  ปัดเศษ + 1 */
                               ELSE TRUNCATE( (nv_netPrem_comp * 0.004 ),0)      /* ไม่มีทศนิยม */
                vVat_comp    = (nv_netPrem_comp + vStamp_comp) * 0.07
                nv_grossPrem_comp = nv_netprem_comp  + vStamp_comp + vVat_comp
                vStamp            = wagtprm_fil.stamp - vStamp_comp
                vVat              = wagtprm_fil.tax   - vVat_comp
                nv_grossPrem      = nv_netprem + vStamp + vVat.
        END.
        IF (SUBSTR(nv_vehreg,1,1) <> "/") THEN DO:
            nv_vehreg = nv_vehreg.     /* รถเก่า  มีเลขทะเบียน */
        END.
        ELSE DO:   /* SUBSTR(nv_vehreg,1,1) = "/" รถใหม่ ไม่มีทะเบียนรถ */
            IF nv_engine <> "" THEN nv_vehreg = nv_engine.   /* เลขเครื่องยนต์ <> ""  then นำเลขเครื่องยนต์มาใส่ที่ทะเบียนรถ*/
            ELSE nv_vehreg = SUBSTR(nv_vehreg, 1 ,LENGTH(nv_vehreg)).  /* ถ้าเลขเครื่องยนต์ = "" ตัด "/" */
        END. 
        /*------------ create data to table wBill -----------*/
       IF nv_pol72 <> ""  THEN DO:
            FIND LAST Bwagtprm_fil WHERE Bwagtprm_fil.policy = nv_pol72 NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL Bwagtprm_fil THEN DO:
                nv_pol72 = wagtprm_fil.policy + '(' + SUBSTR(wagtprm_fil.trntyp,1,1) 
                             + wagtprm_fil.docno + ')'.      
            END.  

       END.
        IF (SUBSTR(wagtprm_fil.policy,3,2) = "70" ) THEN   
            ASSIGN nv_newpol70 = nv_norpol 
                   nv_newpol72 = nv_pol72.
             
        ELSE    
            ASSIGN nv_newpol70 = nv_pol72
                   nv_newpol72 = nv_norpol. 


       
      


        FIND FIRST wBill USE-INDEX  wBill01     WHERE
         /* wBill.wAcno   = wagtprm_fil.acno    AND
            wBill.wPolicy = wagtprm_fil.policy  AND
            wBill.wEndno  = wagtprm_fil.endno   AND
            wBill.wtrnty1 = SUBSTR(wagtprm_fil.trnty,1,1)  AND
            wBill.wtrnty2 = SUBSTR(wagtprm_fil.trnty,2,1)  AND
            wBill.wdocno  = wagtprm_fil.docno */  
            wBill.wnorpol      = nv_newpol70  AND
            wBill.wpol72       = nv_newpol72 
            NO-ERROR NO-WAIT.
        IF NOT AVAIL wBill THEN DO:
            vCountRec = vCountRec + 1.
            DISPLAY "Create data to Table wBill ..."  @ fi_Process  WITH FRAME {&FRAME-NAME}.
            CREATE wBill.
            ASSIGN wBill.wpolicy   = wagtprm_fil.policy    /*Policy No.    char   x(16)  */
                wBill.wacno        = wagtprm_fil.acno      /*Account Code  char   x(7)   */
                wBill.wnorpol      = nv_newpol70             /*6  Normal Policy no.    char   x(25)   */
                wBill.wpol72       = nv_newpol72             /*7  Compulsory Policy n  char   x(25) */
                wBill.winsure      = nv_insure             /*8  Customer name        char   x(60) */
                wBill.wcha_no      = nv_cha_no             /*9  หมายเลขตัวถังรถ      char   x(20)      */
                wBill.wengine      = nv_engine             /*10 หมายเลขเครื่องยนต์   char   x(20)     */
                wBill.wVehreg      = nv_vehreg             /*10 หมายเลขทะเบียน       char   x(20)     */
                wBill.wcomdat      = wagtprm_fil.comdat    /*11 Start date yyyymmdd  date   99/99/9999 */
                wBill.wnetprem       = nv_NetPrem          
                wBill.wcompnetprem   = nv_netPrem_comp     /*16 Net Premium พรบ.     deci-2 >>,>>>,>>9.99-*/
                wBill.wgrossprem     = nv_grossPrem        
                wBill.wcompgrossprem = nv_grossPrem_comp   
                wBill.wtax           = n_wh1               /* w/h Tax1%    (15 + 16 + stamp รวม ) *  1%   ถ้าเป็นการ คือเงิน  w/h = 0*/
                wBill.wNetPayment    = nv_grossPrem + nv_grossPrem_comp - n_wh1
                wBill.wasdat         = wagtprm_fil.asdat
                wBill.wtrnty1        = SUBSTR(wagtprm_fil.trntyp,1,1)
                wBill.wtrnty2        = SUBSTR(wagtprm_fil.trntyp,2,1)
                wBill.wdocno         = wagtprm_fil.docno
                wBill.wendno         = wagtprm_fil.endno
                wBill.wtrndat1       = wagtprm_fil.trndat
                wBill.wpoltyp        = wagtprm_fil.poltyp
                wBill.wbal           = wagtprm_fil.bal
                wBill.wcontract      = nv_cedpol
                wBill.wname2         = nv_name2     /* A59-0362 */     
                wBill.wvatcode       = nv_vatcode.  /* A59-0362 */    
                 
        END. /* find first wBill */
    END.      /* avail  uwm100 */
/*END.  */            /* wfAcno */ 
END.    /* wagtprm_fil */

IF vCountRec = 0 THEN DO:
    MESSAGE "ไม่พบข้อมูล ที่จะส่งออก" VIEW-AS ALERT-BOX INFORMATION.
    RETURN NO-APPLY.
END.
/*-----------------------------------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------------------------------*/

/* RELEASE Billing. */
 RELEASE acProc_fil.
/*=======================End of Include File =============================*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdproc3 C-Win 
PROCEDURE pdproc3 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*comment  by :Kridtiya i. A59-0362 ........
FIND LAST  acProc_fil USE-INDEX by_type_asdat WHERE
  acProc_fil.type  = "02"      AND
  acProc_fil.asdat = n_asdat NO-LOCK  NO-ERROR.  /* n_asdat */
IF NOT AVAIL acProc_fil THEN DO:
  CREATE acProc_fil.
  ASSIGN acProc_fil.type = "02"
    acProc_fil.typdesc   = "PROCESS STATEMENT BILLING(TAS)"
    acProc_fil.asdat     = n_asdat       /* วันที่ process statement *//* nv_exportdat  */
    acProc_fil.trndatfr  = n_comdatF     /*depend on condition on interface*/
    acProc_fil.trndatto  = n_comdatT
    acProc_fil.entdat    = TODAY         /* = nv_exportdat    */
    acProc_fil.enttim    = STRING(TIME, "HH:MM:SS")
    acProc_fil.usrid     = n_user .
END.
RELEASE acProc_fil. 
end..
Kridtiya i. A59-0362 ........A59-0362*/
/*--------------------------------------p*/
FOR EACH wBill: DELETE  wBill. END.
ASSIGN
  nv_exportdat = TODAY
  nv_exporttim = STRING(TIME,"HH:MM:SS")
  nv_exportusr = nv_user
  vCountRec    = 0.

/*FOR EACH wfAcno USE-INDEX wList01 NO-LOCK:*/
/* MESSAGE nv_acnoAll VIEW-AS ALERT-BOX. */
LOOP_MAIN:
FOR EACH  agtprm_fil USE-INDEX by_acno       WHERE
    agtprm_fil.asdat         = n_asdat       AND
    (LOOKUP(agtprm_fil.acno,nv_acnoAll) <> 0 )       AND  /* A46-0426 */ 
    /*--agtprm_fil.acno          = wfAcno.wacno  AND  /* A49-0002 */----Sarinya c. A59-0362---*/
    (agtprm_fil.poltyp       = "V70"         OR  /* A49-0002 */
    agtprm_fil.poltyp        = "V72")        AND  /* --- Suthida T. A52-0299 --- */
    /*----- A49-0002 ------
    (agtprm_fil.poltyp        = "V70"  OR
    agtprm_fil.poltyp        = "V72")        AND
    SUBSTR(agtprm_fil.policy,7,2)  <> "IS"          AND  /*free compulsory dm7245isxxxx*/
    --- end A49-0002 ---*/
    /* A49-0002 */
    (agtprm_fil.TYPE          = "01"         OR
    agtprm_fil.TYPE          = "05")         AND
    agtprm_fil.trntyp     BEGINS 'M'         AND
    /* END A49-0002 */
    /* A46-0426---
    (agtprm_fil.acno          = fi_ac1         OR
    agtprm_fil.acno          = fi_ac2         OR
    agtprm_fil.acno          = fi_ac3         OR
    agtprm_fil.acno          = fi_ac4         OR
    agtprm_fil.acno          = fi_ac5         OR
    agtprm_fil.acno          = fi_ac6         OR
    agtprm_fil.acno          = fi_ac7         OR
    agtprm_fil.acno          = fi_ac8         OR
    agtprm_fil.acno          = fi_ac9         OR
    agtprm_fil.acno          = fi_ac10  )    AND
    ---A46-0426 */
    (agtprm_fil.polbran      >= n_branch     AND
    agtprm_fil.polbran      <= n_branch2 )   AND
    /* A49-0002 ----
    (NOT(agtprm_fil.trntyp     BEGINS 'Y')        AND
    NOT(agtprm_fil.trntyp     BEGINS 'Z') )      AND
    ---- A49-0002 */      
    /*   (agtprm_fil.comdat       >= n_comdatF     AND
    agtprm_fil.comdat       <= n_comdatT)    AND */ /*--- Sarinya c. A59-0362---- */
    agtprm_fil.bal          >  0                  /* A49-0002 */
    /*           agtprm_fil.bal          <> 0 */
    NO-LOCK:
    /*--------- Sarinya c. A59-0362--*/
    IF agtprm_fil.trndat       < n_comdatF     THEN NEXT loop_main.
    IF agtprm_fil.trndat       > n_comdatT     THEN NEXT loop_main.
    /*-----by Sarinya c. A59-0362----*/
    IF agtprm_fil.prem + agtprm_fil.prem_comp = 0 THEN NEXT loop_main.  /* เบี้ยเป็น 0 แต่ยังค้างค่า comm. bal <> 0*/
    /* A49-0002 : check policy cancle */
    FIND LAST acm001 USE-INDEX acm00104 WHERE
        acm001.policy = agtprm_fil.policy NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL acm001 THEN
        IF acm001.trnty1 = "R" AND acm001.trnty2 = "C" THEN NEXT loop_main.
        /* END A49-0002 */
    ASSIGN
      nv_pol72      = ""     nv_norpol   = ""
      nv_insure     = ""     nv_vehreg   = ""
      nv_engine     = ""     nv_cha_no   = ""
      nv_job_nr     = ""  /* nv_opnpol   = "" */
      nv_grossPrem  = 0      nv_grossPrem_comp = 0
      nv_netPrem    = 0      nv_netPrem_comp   = 0
      nv_tax        = 0      nv_netPayment     = 0
      vStamp        = 0      vStamp_comp       = 0
      vVat          = 0      vVat_comp         = 0 
      nv_cedpol     = ""  
      nv_name2      = "" 
      nv_vatcode    = ""
      nv_brandmol   = "" .
    DISPLAY  "Process : " + agtprm_fil.policy + '   ' + agtprm_fil.trnty
        + '  ' + agtprm_fil.docno FORMAT "X(10)" /* Benjaporn J. A60-0267 date 27/06/2017 */
         @ fi_Process WITH FRAME {&FRAME-NAME}.
    PAUSE 0.
    ASSIGN
        /* nv_norpol   = agtprm_fil.policy + '(' + SUBSTR(agtprm_fil.trntyp,1,1)
        + agtprm_fil.docno + ')'*/
        /*        nv_opnpol   = agtprm_fil.opnpol */
        nv_vehreg       = agtprm_fil.vehreg
        nv_netPrem      = agtprm_fil.prem
        nv_netPrem_comp = agtprm_fil.prem_comp .
    /* nv_norpol  70
    nv_pol72   72*/
    IF (SUBSTR(agtprm_fil.policy,3,2) = "70" ) THEN  
           nv_norpol = agtprm_fil.policy + '(' + SUBSTR(agtprm_fil.trntyp,1,1)
                     + agtprm_fil.docno + ')'.
    ELSE   nv_pol72  = agtprm_fil.policy + '(' + SUBSTR(agtprm_fil.trntyp,1,1)
                     + agtprm_fil.docno + ')'.
           /*------------------*/
           /*A47-0235--- 
           FIND FIRST uwm100  use-index uwm10090 WHERE
           uwm100.trty11 = substr(agtprm_fil.trnty, 1 , 1)  AND
           uwm100.docno1 = agtprm_fil.docno
           NO-LOCK NO-ERROR.
           ---A47-0235*/
           /* comment by Kridtiya i. 
           FIND FIRST uwm100 USE-INDEX uwm10001 WHERE
           uwm100.policy = agtprm_fil.policy  /*AND
                   uwm100.endno  = agtprm_fil.endno   AND
                   uwm100.docno1 = agtprm_fil.docno*/   NO-LOCK NO-ERROR.*/ /*comment by Kridtiya i. */
    FIND FIRST uwm100 USE-INDEX uwm10001 WHERE  /*Add by Kridtiya i. */
        uwm100.policy = agtprm_fil.policy  AND  /*Add by Kridtiya i. */
        uwm100.endno  = agtprm_fil.endno   AND  /*Add by Kridtiya i. */
        uwm100.docno1 = agtprm_fil.docno    NO-LOCK NO-ERROR.
    IF AVAIL uwm100 THEN DO:
        IF uwm100.endno  <> agtprm_fil.endno AND  uwm100.docno1 <> agtprm_fil.docno THEN NEXT.
        ASSIGN nv_cedpol = uwm100.cedpol
            nv_name2     = uwm100.name2    /* A59-0362 */ 
            nv_vatcode   = uwm100.bs_cd.   /* A59-0362 */  
        /* A49-0002 */
        RUN pdwh1.   /* calculate tax 1% of V70 (หา n_wh1) */
        ASSIGN
            y1    = 0
            z1    = 0
            n_wh1 = IF n_wh1 < 0 THEN 0 ELSE n_wh1.
        FOR EACH acd001 USE-INDEX acd00191 WHERE
          acd001.trnty1 = SUBSTR(agtprm_fil.trntyp,1,1) AND
          acd001.docno  = agtprm_fil.docno              NO-LOCK:
            IF acd001.ctrty1 = 'y' THEN y1 = -(acd001.netloc).
            IF acd001.ctrty1 = 'z' THEN z1 = -(acd001.netloc).
        END.
        /* bal  -  (รายการทีตัดเบี้ยไปแล้วเหลือ <= ภาษี 1 % */
        IF agtprm_fil.bal - (y1 + z1) <= n_wh1 THEN NEXT loop_main.
        /* END A49-0002 */
        /* n= new policy, r = renew*/
        IF uwm100.rencnt = 0 OR uwm100.prvpol = "" THEN
            nv_job_nr = "N".
        ELSE nv_job_nr = "R".
        /* 2 - Customer Name  + " " + TRIM(uwm100.name2)*/
        nv_insure = (uwm100.ntitle) + " " + (uwm100.name1).
        IF nv_insure = " " THEN nv_insure = agtprm_fil.insure.
        /*i*/
        IF (SUBSTR(agtprm_fil.policy,3,2) = "70" ) THEN DO:
            nv_pol72 = "".
            /* {wac\wactas1.i}   /* หา  Compulsory  Policy No.  nv_pol72*/*//*Test*/
            RUN pd_nvpol72_2. 
        END.
        /*end i*/
        IF (SUBSTR(agtprm_fil.policy,3,1) = "7" ) AND nv_pol72 <> "" THEN DO:
            FIND FIRST uwm301 USE-INDEX uwm30101      WHERE
                uwm301.policy = uwm100.policy   AND
                uwm301.rencnt = uwm100.rencnt   AND
                uwm301.endcnt = uwm100.endcnt  NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL uwm301 THEN DO:
                ASSIGN
                    nv_engine   = uwm301.eng_no      /* 5 - 6*/
                    nv_cha_no   = uwm301.cha_no
                    nv_brandmol = uwm301.moddes .
            END.  /*uwm301*/
            ELSE DO:
                ASSIGN
                    nv_engine = ""
                    nv_cha_no = ""
                    nv_brandmol = "".
            END.  /* avail uwm301 */
            /*-- calculate   0.4 / 100 = 0.004   ,  7 / 100 = 0.07 --*/
            ASSIGN
                vStamp_comp  = IF (nv_netPrem_comp * 0.004 ) - TRUNCATE( (nv_netPrem_comp * 0.004 ),0) > 0
                               THEN TRUNCATE( (nv_netPrem_comp * 0.004 ),0) + 1 /* มีทศนิยม  ปัดเศษ + 1 */
                               ELSE TRUNCATE( (nv_netPrem_comp * 0.004 ),0)    /* ไม่มีทศนิยม */
                vVat_comp         = (nv_netPrem_comp + vStamp_comp) * 0.07
                nv_grossPrem_comp = nv_netprem_comp  + vStamp_comp + vVat_comp
                vStamp            = agtprm_fil.stamp - vStamp_comp
                vVat              = agtprm_fil.tax   - vVat_comp
                nv_grossPrem      = nv_netprem + vStamp + vVat.
        END.   /* 70 , 72, 73*/
        ELSE DO:  /* ---- Suthida T. A52-0299 -----*/
            FIND FIRST uwm301 USE-INDEX uwm30101  WHERE
                uwm301.policy = uwm100.policy     AND
                uwm301.rencnt = uwm100.rencnt     AND
                uwm301.endcnt = uwm100.endcnt     NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL uwm301 THEN DO:
                ASSIGN
                    nv_engine = uwm301.eng_no      /* 5 - 6*/
                    nv_cha_no = uwm301.cha_no
                    nv_brandmol = uwm301.moddes.
            END.  /*uwm301*/
            ELSE DO:
                ASSIGN
                    nv_engine = ""
                    nv_cha_no = ""
                    nv_brandmol = "" .
            END.   /* avail uwm301 */
            /*-- calculate   0.4 / 100 = 0.004   ,  7 / 100 = 0.07 --*/
            ASSIGN
                vStamp_comp  = IF (nv_netPrem_comp * 0.004 ) - TRUNCATE( (nv_netPrem_comp * 0.004 ),0) > 0
                               THEN TRUNCATE( (nv_netPrem_comp * 0.004 ),0) + 1 /* มีทศนิยม  ปัดเศษ + 1 */
                               ELSE TRUNCATE( (nv_netPrem_comp * 0.004 ),0)    /* ไม่มีทศนิยม */
                vVat_comp         = (nv_netPrem_comp + vStamp_comp) * 0.07
                nv_grossPrem_comp = nv_netprem_comp  + vStamp_comp + vVat_comp
                vStamp            = agtprm_fil.stamp - vStamp_comp
                vVat              = agtprm_fil.tax   - vVat_comp
                nv_grossPrem      = nv_netprem + vStamp + vVat.
        END.  /* ---- Suthida T. A52-0299 -----*/
        /*---- A49-0002 ----
        ELSE DO:
        ASSIGN
                 nv_netprem_comp   = 0
                 nv_grossPrem_comp = 0
                 nv_netprem        = agtprm_fil.prem
                 nv_grossPrem      = agtprm_fil.prem + agtprm_fil.stamp + agtprm_fil.tax.
           END. /* <> 70,72,73*/
           -- end A49-0002 --*/
        IF (SUBSTR(nv_vehreg,1,1) <> "/") THEN DO:
            nv_vehreg = nv_vehreg.     /* รถเก่า  มีเลขทะเบียน */
        END.
        ELSE DO:   /* SUBSTR(nv_vehreg,1,1) = "/" รถใหม่ ไม่มีทะเบียนรถ */
            IF nv_engine <> "" THEN nv_vehreg = nv_engine.   /* เลขเครื่องยนต์ <> ""  then นำเลขเครื่องยนต์มาใส่ที่ทะเบียนรถ*/
            ELSE nv_vehreg = SUBSTR(nv_vehreg, 1 ,LENGTH(nv_vehreg)).  /* ถ้าเลขเครื่องยนต์ = "" ตัด "/" */
        END.
        /*------------ create data to table wBill -----------*/
        FIND FIRST wBill USE-INDEX  wBill01     WHERE
            wBill.wAcno   = agtprm_fil.acno    AND
            wBill.wPolicy = agtprm_fil.policy  AND
            wBill.wEndno  = agtprm_fil.endno   AND
            wBill.wtrnty1 = SUBSTR(agtprm_fil.trnty,1,1)  AND
            wBill.wtrnty2 = SUBSTR(agtprm_fil.trnty,2,1)  AND
            wBill.wdocno  = agtprm_fil.docno   NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL wBill THEN DO:
            vCountRec = vCountRec + 1.
            DISPLAY "Create data to Table wBill ..."  @ fi_Process  WITH FRAME {&FRAME-NAME}.
            PAUSE 0.
            CREATE wBill.
            ASSIGN wBill.wpolicy   = agtprm_fil.policy   /*Policy No.    char   x(16)  */
                wBill.wacno        = agtprm_fil.acno    /*Account Code  char   x(7)   */
                wBill.wnorpol      = nv_norpol         /*6  Normal Policy no.    char   x(25)   */
                wBill.wpol72       = nv_pol72          /*7  Compulsory Policy n  char   x(25) */
                wBill.winsure      = nv_insure         /*8  Customer name        char   x(60) */
                wBill.wcha_no      = nv_cha_no         /*9  หมายเลขตัวถังรถ      char   x(20)      */
                wBill.wengine      = nv_engine         /*10 หมายเลขเครื่องยนต์   char   x(20)     */
                wBill.wVehreg      = nv_vehreg         /*10 หมายเลขทะเบียน       char   x(20)     */
                wBill.wbrandmodel  = nv_brandmol
                wBill.wcomdat      = agtprm_fil.comdat   /*11 Start date yyyymmdd  date   99/99/9999 */
               /*----- A49-0002 -----
               ASSIGN wBill.wtrndat      = nv_exportdat    /*Export Dat    date   99/99/9999  */
                      wBill.wtrntim      = nv_exporttim    /*Trn.Time      char   x(8)   */
                      wBill.wtrnusr      = nv_exportusr    /*Trn.UsrId     char   x(8)   */
                      wBill.wrencnt      = uwm100.rencnt   /*rencnt        inte   >>9    */
                      wBill.wendcnt      = uwm100.endcnt   /*endcnt        inte   999    */
                      wBill.wCompanyCode = "SAFE"          /*1 Insurance's Company  char   x(04)  */
                      wBill.wloop_bill   = "1"  /*2 รอบของการวางบิล      char   x(02)          */
                      wBill.wdate_bill   = STRING(YEAR(TODAY),"9999")
                                         + STRING(MONTH(TODAY),"99")
                                         + STRING(DAY(TODAY),"99")  /*3  รอบวันที่ของการวางบ  char   x(08)        */
                      wBill.wrecordno    = vCountRec   /*4  Record no. 999999    inte   999999  */
                      wBill.wjob_nr      = nv_job_nr   /*5  JOB ('N'=NEW, 'R'=R  char   x        */
                      wBill.effdat      = uwm100.expdat   /*12 yyyymmdd Effective   date   99/99/9999  */
                      wBill.branch      = agtprm_fil.polbran
                      /* ----- */
                      wBill.nor_covamt  = 0   /*13 ทุนประกันเบี้ยหลัก   deci-2 >>,>>>,>>9.99-*/
                      wBill.comp_covamt = 0  /*14 ทุนประกันพรบ.Compl.  deci-2 >>,>>>,>>9.99-*/
                      /* ----- */
                      /* = 0 */
                      wBill.nor_comm    = 0   /*20 Commission amt.(เบี  deci-2 >>,>>>,>>9.99-*/
                      wBill.comp_comm   = 0  /*21 Commission amt.(พรบ  deci-2 >>,>>>,>>9.99-*/
                      wBill.nor_vat     = 0    /*22 VAT Commission(เบี้  deci-2 >>,>>>,>>9.99-*/
                      wBill.comp_vat    = 0   /*23 VAT Commission(พรบ.  deci-2 >>,>>>,>>9.99-*/
                      wBill.nor_tax3    = 0   /*24 With Holding Tax3%   deci-2 >>,>>>,>>9.99-*/
                      wBill.comp_tax3   = 0  /*25 With Holding Tax3%   deci-2 >>,>>>,>>9.99-*/
                      /*---*/
                      wBill.subinscod   = ""  /*27 Sub insurance code(  char   x(04)  */
                      wBill.comp_sub    = ""  /*28 Sub insurance code(  char   x(04)  */
                      wBill.tlt_remark  = ""  /*29 TLT. Remark          char   x(65)       */
                      
                      wBill.total_prm   = nv_grossPrem + nv_grossPrem_comp   /*19 Total Premium (17+1  deci-2 >>,>>>,>>9.99-*/
                                                                             /* (17+18)  GROSS Prem  = nor + comp*/
                ----- A49-0002 -----*/
                wBill.wnetprem       = nv_NetPrem  /*15 Net Premium เบี้ยหลัก = เบี้ยรวม - VAT - Stamp  deci-2 >>,>>>,>>9.99-*/
                wBill.wcompnetprem   = nv_netPrem_comp   /*16 Net Premium พรบ.     deci-2 >>,>>>,>>9.99-*//*16 Net Premium พรบ. = เบี้ยรวมพรบ. - VAT - Stamp  deci-2 >>,>>>,>>9.99-*/
                wBill.wgrossprem     = nv_grossPrem      /*17 Normal Gross Premiu = เบี้ย70 + VAT + STAMP  deci-2 >>,>>>,>>9.99-*/
                wBill.wcompgrossprem = nv_grossPrem_comp  /*18 Compulsory Gross Pr = เบี้ย72 + VAT + STAMP deci-2 >>,>>>,>>9.99-*/
                wBill.wtax           = n_wh1 /* w/h Tax1%    (15 + 16 + stamp รวม ) *  1%   ถ้าเป็นการ คือเงิน  w/h = 0*/
                wBill.wNetPayment    = nv_grossPrem + nv_grossPrem_comp - n_wh1  /*26 [ 19 - w/h Tax 1 %  deci-2 >>,>>>,>>9.99-*/
                wBill.wasdat         = agtprm_fil.asdat
                wBill.wtrnty1        = SUBSTR(agtprm_fil.trntyp,1,1)
                wBill.wtrnty2        = SUBSTR(agtprm_fil.trntyp,2,1)
                wBill.wdocno         = agtprm_fil.docno
                wBill.wendno         = agtprm_fil.endno
                wBill.wtrndat1       = agtprm_fil.trndat
                wBill.wpoltyp        = agtprm_fil.poltyp
                wBill.wbal           = agtprm_fil.bal
                /*wBill.wcontract      = "" */
                wBill.wcontract      = nv_cedpol 
                wBill.wname2         = nv_name2  /* A59-0362 */
                wBill.wvatcode       = nv_vatcode. /* A59-0362 */
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdveh C-Win 
PROCEDURE pdveh :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       vehicle register  change '-' to " "  , cut provice code 
------------------------------------------------------------------------------*/

  IF wBill.wVehreg <> "" THEN DO:

       c = SUBSTR(wBill.wVehreg , LENGTH(wBill.wVehreg) , 1) .
       IF LOOKUP(c, clist) = 0 THEN DO:
            b = LENGTH(wBill.wVehreg) - 2.
            n_veh = SUBSTR(wBill.wVehreg, 1, b).
            
            bbb = INDEX(n_veh , "-") .    
            IF bbb <> 0 THEN DO:
               ccc = SUBSTR(n_veh  , 1 , bbb - 1) .
/*                ddd = SUBSTR( n_veh, INDEX(ch , "-") + 1 ,  (LENGTH(n_veh) - INDEX(n_veh , "-"))). */
               ddd = SUBSTR( n_veh, INDEX(wbill.wvehreg , "-") + 1 ,  (LENGTH(n_veh) - INDEX(n_veh , "-"))).
               engc = ccc + ' ' + ddd.
            END.
            ELSE engc = n_veh.

       END.  /*ตัวท้ายเป็นตัวเลข*/
       ELSE  DO:

            n_veh = wbill.wvehreg. 
           
            bbb = INDEX(n_veh , "-").
            IF bbb <> 0 THEN DO:
               ccc = SUBSTR(n_veh  , 1 , bbb - 1) .
               ddd = SUBSTR( n_veh, INDEX(n_veh , "-") + 1 ,  (LENGTH(n_veh) - INDEX(n_veh , "-"))).
               engc = ccc + ' ' + ddd.
            END.
            ELSE engc = n_veh.
       END.
  END.
  ELSE engc = "".

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
       uwm100.ntitle       = "ห้างหุ้นส่วนจำก"    THEN
        n_wh1 = ((nv_netPrem + nv_netPrem_comp + agtprm_fil.stamp ) * 1) / 100 .  /* 12+13+stamp * 1% */

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
         INDEX(uwm100.name1,"และ/หรือ")          <> 0     THEN    /* A48-0586 */
        n_wh1 = ((nv_netPrem + nv_netPrem_comp + agtprm_fil.stamp ) * 1) / 100 .  /* 12+13+stamp * 1% */

    /*  ------------------------- Suthida T. A55-0064 ----------------------------------
    IF SUBSTR(uwm100.insref,2,1) = "c" THEN
        n_wh1 = ((nv_netPrem + nv_netPrem_comp + agtprm_fil.stamp ) * 1) / 100 .  /* 12+13+stamp * 1% */
    ------------------------- Suthida T. A55-0064 ----------------------------------*/
    /* ------------------------- Suthida T. A55-0064 ---------------------------------- */
    IF LENGTH(uwm100.insref)  = 7 THEN DO:
       IF SUBSTR(uwm100.insref,2,1) = "C" THEN 
          n_wh1 = ((nv_netPrem + nv_netPrem_comp + agtprm_fil.stamp ) * 1) / 100 .
    END.
    ELSE IF LENGTH(uwm100.insref)  = 10 THEN DO:
        
        IF SUBSTR(uwm100.insref,3,1) = "C" THEN
           n_wh1 = ((nv_netPrem + nv_netPrem_comp + agtprm_fil.stamp ) * 1) / 100 .
    END.
    /* ------------------------- Suthida T. A55-0064 ----------------------------------*/
  

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdwh1_2 C-Win 
PROCEDURE pdwh1_2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
n_wh1 = 0.
IF uwm100.ntitle       = "บริษัท"              OR
    uwm100.ntitle       = "บ."                 OR
    TRIM(uwm100.ntitle) = "บจก."               OR
    TRIM(uwm100.ntitle) = "หจก."               OR
    TRIM(uwm100.ntitle) = "หสน."               OR
    uwm100.ntitle       = "บรรษัท"             OR
    uwm100.ntitle       = "มูลนิธิ"            OR
    uwm100.ntitle       = "ห้างหุ้นส่วน"       OR
    uwm100.ntitle       = "ห้าง"               OR
    uwm100.ntitle       = "ห้างหุ้นส่วนจำกัด"  OR
    uwm100.ntitle       = "ห้างหุ้นส่วนจำก"    THEN
    n_wh1 = ((nv_netPrem + nv_netPrem_comp + wagtprm_fil.stamp ) * 1) / 100 .  /* 12+13+stamp * 1% */
IF R-INDEX(uwm100.name1,"จก.")              <> 0     OR
    R-INDEX(uwm100.name1,"จำกัด")           <> 0     OR  
    R-INDEX(uwm100.name1,"(มหาชน)")         <> 0     OR
    R-INDEX(uwm100.name1,"INC.")            <> 0     OR
    R-INDEX(uwm100.name1,"CO.")             <> 0     OR
    R-INDEX(uwm100.name1,"LTD.")            <> 0     OR
    R-INDEX(uwm100.name1,"LIMITED")         <> 0     OR
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
    INDEX(uwm100.name1,"และ/หรือ")          <> 0     THEN    /* A48-0586 */
    n_wh1 = ((nv_netPrem + nv_netPrem_comp + wagtprm_fil.stamp ) * 1) / 100 .  /* 12+13+stamp * 1% */

/* ------------------------- Suthida T. A55-0064 ---------------------------------- 
IF SUBSTR(uwm100.insref,2,1) = "c" THEN
    n_wh1 = ((nv_netPrem + nv_netPrem_comp + wagtprm_fil.stamp ) * 1) / 100 .  /* 12+13+stamp * 1% */
------------------------- Suthida T. A55-0064 ---------------------------------- */
/* ------------------------- Suthida T. A55-0064 ---------------------------------- */
IF LENGTH(uwm100.insref)  = 7 THEN DO:
   IF SUBSTR(uwm100.insref,2,1) = "C" THEN 
      n_wh1 = ((nv_netPrem + nv_netPrem_comp + wagtprm_fil.stamp ) * 1) / 100 .
END.
ELSE IF LENGTH(uwm100.insref)  = 10 THEN DO:
    
    IF SUBSTR(uwm100.insref,3,1) = "C" THEN
       n_wh1 = ((nv_netPrem + nv_netPrem_comp + wagtprm_fil.stamp ) * 1) / 100 .
END.
/* ------------------------- Suthida T. A55-0064 ----------------------------------*/



END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_nvpol72 C-Win 
PROCEDURE pd_nvpol72 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*//*
/* modify  by  Kridtiya i. A53-0167 . : 12/05/2010 */
/* หา  Compulsory  Policy No. ที่ 70 พ่วง 72  */
/* duplicate wactas1.i ปรับส่วนของการ หา 72 เอาเฉพาะ พ่วง 70  */
DEF BUFFER bwagtprm_fil FOR  wagtprm_fil.
DEF VAR n_poltyp AS CHAR FORMAT "x(3)".

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

ASSIGN  n_pol = ''
    n_ren = 0
    n_end = 0.
IF uwm130.uom8_v <> 0 AND uwm130.uom9_v <> 0 AND uwm100.poltyp = "v70" THEN DO:   /* Compulsory ในตัว 70 */
    nv_pol72 = ''.
    nv_pol72 = uwm130.policy + '(' + uwm100.trty11 + uwm100.docno1 + ')'.
END.

ELSE DO:  /* Compulsory แยก พ่วง 72 */



    IF (uwm100.poltyp = "v72") AND (substr(uwm100.policy,7,1) = "t") THEN DO: 
        ASSIGN nv_pol72  = "".
        NEXT.
    END.


    IF uwm100.cr_2 = "" THEN DO: 
        ASSIGN nv_pol72  = ""
            n_poltyp = "" .

        IF uwm100.poltyp = "V70" THEN n_poltyp = "V72".
        ELSE n_poltyp = "V70".

        loop_buwm301:
/*         FOR EACH Buwm301 USE-INDEX uwm30102 WHERE                                         */
/*             Buwm301.policy <>  uwm301.policy   AND                                        */
/*             Buwm301.vehreg =   uwm301.vehreg   NO-LOCK:           /* DM7245123456*/       */
/*                                                                                           */
/*             IF SUBSTRING(Buwm301.policy,3,2) = n_poltyp THEN DO:  /* uwm100 */            */
/*                                                                                           */
/*                 FIND LAST bwagtprm_fil WHERE bwagtprm_fil.policy = Buwm301.policy AND     */
/*                     substr(bwagtprm_fil.policy,7,1) <> "T" NO-LOCK NO-WAIT NO-ERROR .     */
/*                 IF AVAIL bwagtprm_fil  THEN DO:                                           */
/*                                                                                           */
/*                     FIND FIRST Buwm_v72 USE-INDEX uwm10001 WHERE                          */
/*                         Buwm_v72.policy = Buwm301.policy AND                              */
/*                         Buwm_v72.rencnt = Buwm301.rencnt AND                              */
/*                         Buwm_v72.endcnt = Buwm301.endcnt NO-LOCK NO-ERROR NO-WAIT.        */
/*                     IF NOT AVAILABLE Buwm_v72 THEN NEXT.                                  */
/*                     IF Buwm_v72.expdat >= uwm100.comdat THEN nv_pol72  = Buwm_v72.policy. */
/*                     ELSE nv_pol72  = "".                                                  */
/*                 END.                                                                      */
/*             END.                                                                          */
/*         END.    /* for eachBuwm301*/                                                      */



        FOR EACH Buwm301 USE-INDEX uwm30102 WHERE
                 Buwm301.policy <>  uwm301.policy   AND
                 Buwm301.vehreg =   uwm301.vehreg  ,
            LAST uwm100.sta <> NO  AND
                 uwm100.poltyp = n_poltyp NO-LOCK:           /* DM7245123456*/

            IF SUBSTRING(Buwm301.policy,3,2) = n_poltyp THEN DO:  /* uwm100 */

                FIND LAST bwagtprm_fil WHERE bwagtprm_fil.policy = Buwm301.policy AND
                    substr(bwagtprm_fil.policy,7,1) <> "T" NO-LOCK NO-WAIT NO-ERROR .
                IF AVAIL bwagtprm_fil  THEN DO:

                    FIND FIRST Buwm_v72 USE-INDEX uwm10001 WHERE
                        Buwm_v72.policy = Buwm301.policy AND
                        Buwm_v72.rencnt = Buwm301.rencnt AND
                        Buwm_v72.endcnt = Buwm301.endcnt NO-LOCK NO-ERROR NO-WAIT.
                    IF NOT AVAILABLE Buwm_v72 THEN NEXT. 
                    IF Buwm_v72.expdat >= uwm100.comdat THEN nv_pol72  = Buwm_v72.policy.
                    ELSE nv_pol72  = "".
                END.
            END. 
        END.    /* for eachBuwm301*/

    END.       /*************************************************** */
    ELSE DO:  /* uwm100.cr_2  <> "" */
        FIND FIRST Buwm_v72 USE-INDEX uwm10001 WHERE
             Buwm_v72.policy = uwm100.cr_2     NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL Buwm_v72 THEN DO:
            FIND LAST bwagtprm_fil WHERE 
                bwagtprm_fil.policy = Buwm_v72.policy AND
                substr(bwagtprm_fil.policy,7,1) <> "T" NO-LOCK NO-WAIT NO-ERROR .
            IF NOT AVAIL bwagtprm_fil  THEN nv_pol72  = "".
            ELSE nv_pol72  = bwagtprm_fil.policy.
        END.
        ELSE  nv_pol72  = "".
    END.  /* uwm100.opnpol <> "" */
END.      /* not (uwm130.uom8_v <> 0 AND uwm130.uom9_v <> 0) */*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_nvpol72_2 C-Win 
PROCEDURE pd_nvpol72_2 :
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
ASSIGN  n_pol = ""
   n_ren = 0
   n_end = 0
   n_poltype = "".
IF uwm100.poltyp = "v70" THEN n_poltype = "72".
ELSE n_poltype = "70".
IF uwm130.uom8_v <> 0 AND uwm130.uom9_v <> 0 AND uwm100.poltyp = "v70" THEN DO:
    ASSIGN 
    nv_pol72 = ''
    nv_pol72 = uwm130.policy + '(' + uwm100.trty11 + uwm100.docno1 + ')'.
END.
ELSE DO:
    IF uwm100.cr_2 = "" THEN DO:
        FOR EACH Buwm301 USE-INDEX uwm30102 WHERE
                 buwm301.policy <> uwm301.policy AND
                 Buwm301.vehreg  = uwm301.vehreg, 
            FIRST bwagtprm_fil WHERE bwagtprm_fil.vehreg = uwm301.vehreg 
            NO-LOCK:           /* DM7245123456*/

            IF SUBSTRING(Buwm301.policy,3,2) = n_poltype THEN DO:  /* uwm100 */
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
        FIND FIRST Buwm_v72 USE-INDEX uwm10001 WHERE
                   Buwm_v72.policy = n_pol AND
                   Buwm_v72.rencnt = n_ren AND
                   Buwm_v72.endcnt = n_end
        NO-LOCK NO-ERROR NO-WAIT.
        IF AVAILABLE Buwm_v72 THEN DO:
            FIND LAST bwagtprm_fil WHERE 
                bwagtprm_fil.policy = Buwm_v72.policy AND
                substr(bwagtprm_fil.policy,7,1) <> "T" NO-LOCK NO-WAIT NO-ERROR .
            IF NOT AVAIL bwagtprm_fil  THEN nv_pol72  = "".
            ELSE nv_pol72  = bwagtprm_fil.policy. 
        END.
    END.      /*IF uwm100.cr_2 = "" */
    ELSE DO:  /* uwm100.cr_2 <> ""  */
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
            FOR EACH Buwm301 USE-INDEX uwm30102 WHERE
                     Buwm301.policy <> uwm301.policy   AND
                     Buwm301.vehreg = uwm301.vehreg    NO-LOCK:          /* DM7245123456*/
                IF SUBSTRING(Buwm301.policy,3,2) = n_poltype THEN DO:    /* uwm100 */
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
                            END.  /* else IF vehreg72.expdat <= Buwm_v72.expdat */
                        END.  /* not avail vehreg72  */
                    END.  /*IF Buwm_v72.expdat >= uwm100.comdat */
                END.  /* IF SUBSTRING(Buwm301.policy,3,2) = "72" */
            END.  /* for eachBuwm301*/  /*2*/
            FIND FIRST Buwm_v72 WHERE
                       Buwm_v72.policy = vehreg72.policy AND
                       Buwm_v72.rencnt = vehreg72.rencnt AND
                       Buwm_v72.endcnt = vehreg72.endcnt
            NO-LOCK NO-ERROR NO-WAIT.
            IF AVAILABLE Buwm_v72 THEN DO:
                FIND LAST bwagtprm_fil WHERE 
                    bwagtprm_fil.policy = Buwm_v72.policy  AND
                    substr(bwagtprm_fil.policy,7,1) <> "T" NO-LOCK NO-WAIT NO-ERROR .
                IF NOT AVAIL bwagtprm_fil  THEN nv_pol72  = "".
                ELSE nv_pol72  = bwagtprm_fil.policy. 
            END.   /* IF AVAILABLE Buwm_v72 */  
        END.
    END.  /* uwm100.opnpol <> "" */
END.      /* not (uwm130.uom8_v <> 0 AND uwm130.uom9_v <> 0) */
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

/*
    vChar = SUBSTR(STRING(vDeci,"99999999.99"),1,INDEX(STRING(vDeci,"99999999.99"),".") - 1) +
                  SUBSTR(STRING(vDeci,"99999999.99"),INDEX(STRING(vDeci,"99999999.99"),".") + 1,2).
*/

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

