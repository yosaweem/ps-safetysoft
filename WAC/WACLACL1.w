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

 Modify By : TANTAWAN C.   02/02/2008   [A500178]
             ปรับ FORMAT branch เพื่อรองรับการขยายสาขา      
                   
ขยาย FORMAT fiacno1- fiacno28 จาก "X(7)" เป็น  Char "X(10)" 
เปลี่ยน loop การ create wfacno
------------------------------------------------------------------------*/
/*          This .W file wAS created with the Progress UIB.             */
/*----------------------------------------------------------------------*/

/* Create an unnamed pool to store all the widgets created 
     by this procedure. This is a good DEFINEault which ASsures
     that this procedure's triggers and INTEErnal procedures 
     will execute in this procedure's storage, and that proper
     cleanup will occur on deletion of the procedure. */
/*Modify by Kridtiya i. A53-0167 04/05/2010 
            ปรับโปรแกรมให้สามารถเรียกรายงานตามวันที่ ทรานเฟอร์ได้และ แปลงเทค
            ไฟล์เป็น เอ็กเซล์ และแปลงเอ็กเซลส์ เป็นเทค  */  
/*Modify by Kridtiya i. A53-0241 16/08/2010 
            ปรับโปรแกรมให้สามารถเรียกรายงานกรมธรรม์ภาคบังคับได้ (v72)      */
/*Modify by Kridtiya i. A53-0241 03/09/2010 
            ปรับเงื่อนไขการแสดง กรมธรรม์ภาคบังคับ กรณีพบมี 70 ไม่ให้แสดง
            72 เดียวๆๆ เดิมแสดงรายงานซ้อน ทั้งแบบ 72 เดี๋ยวและ 72 พ่วง 70  */  
/*Modify by :Kridtiya i. A53-0314 date. 05/10/10 
             ปรับส่วนการคำนวณค่า พรบ.รายเดี๋ยวเนื่องจากรวมเบี้ยซ้ำ 2 ครั้ง*/ 
/*Modify by :Kridtiya i. A53-0394 date. 20/12/10 
             ปรับส่วนการทำงานให้ใช้buffer น้อยลง */ 
/*Modify by :Kridtiya i. A59-0362 date. 10/11/2016 เพิ่มคำสั่งคืนค่าฐานข้อมูล  */

/***************************************************************************/

CREATE WIDGET-POOL.
/************   Program   **************
CREATE BY :  Bunthiya C.        A49-0015
Wac
        -Wactlt1.w
        -Wactlt1.i
Whp
        -Whpbran.w
- ดึง parameter สำหรับคำนวณค่าบริการ มาจาก xmm018
  ภ้ามีการเพิ่ม rate ของ tlt ต้องไปเพิ่มด้วย
  และต้องแก้ไขโปรแกรมด้วย
  
Modify By : Bunthiya C.  A50-0070  15/03/2007
    - ปรับส่วน Find Next ของการหาข้อมูล Sub Insure Code
Modify By : Suthida  T.  A52-0208 11/09/2009
    - ปล่อย Comment ให้สามารถรับค่า  Producer Code จาก Fill-in ได้
***************************************/
/*Modify By Kridtiya i. A53-0167 date . 06/05/2010  
            เพิ่มไฟล์excelและ เรียกรายงาน ตาม trandate */
/*Modify By Kridtiya i. A53-0394 date . 21/12/2010  
            ปรับการเรียกรายงาน ให้ใช้เวลาเร็วขึ้นลดการใช้ buffer and workfile*/
/* Modify By : Porntiwa P. A54-0238  15/08/2011
            : เรียกตาม Grou Producer Code ออกมาไม่ถูกต้อง/ไม่ครบ*/
/* Modify By : Piyachat P. A55-0027  Date 31-01-2012 
             - ขอเพิ่มเงื่อนไขโปรแกรมเรียก Sataement By สินเอเซีย(ICBC)    
               โดยให้เรียก Type A,R,B ออกมา
             - ยกเลิกเงื่อนไข Agtprm_fil.bal > 0  เพื่อดึงข้อมูลเบี้ยลบออกมา*/
/* Modify By : Porntiwa T. A60-0267  Date 14/09/2018
               ปรับขยายเลข Document จาก 7 เป็น 10 หลัก เพื่อนำเข้าระบบให้ถูกต้อง                  */
/* ***************************  Definitions  ************************** */
/* Parameters Definitions ---                                           */
DEFINE     SHARED VAR n_User    AS CHAR.
DEFINE     SHARED VAR n_passwd  AS CHAR.
/* Local Variable Definitions ---                                       */
DEFINE            VAR nv_User   AS CHAR NO-UNDO.
DEFINE            VAR nv_pwd    AS CHAR NO-UNDO.

DEFINE NEW SHARED VAR n_branch      AS CHAR FORMAT "X(2)".
DEFINE NEW SHARED VAR n_branch2     AS CHAR FORMAT "X(2)".
DEFINE            VAR n_asdat       AS DATE FORMAT "99/99/9999".
DEFINE            VAR n_bindate     AS CHAR FORMAT "99/99/9999".
DEFINE            VAR n_binloop     AS CHAR FORMAT "99".
DEFINE            VAR n_OutputFile1 AS CHAR.
DEFINE            VAR n_bdes        AS CHAR FORMAT "X(50)".     /*branch name*/
DEFINE            VAR n_chkBname    AS CHAR FORMAT "X(1)".      /* branch-- chk button 1-2 */
DEFINE            VAR nv_norpol     AS CHAR FORMAT "X(25)".     
DEFINE            VAR nv_pol72      AS CHAR FORMAT "X(16)".     
DEFINE            VAR nv_insure     AS CHAR FORMAT "X(50)".     
DEFINE            VAR nv_job_nr     AS CHAR FORMAT "X(1)".      
DEFINE            VAR nv_subins     AS CHAR FORMAT "X(4)".      
DEFINE            VAR nv_comp_sub   AS CHAR FORMAT "X(4)".      
DEFINE            VAR nv_poltyp70   AS CHAR FORMAT "X(3)".      /* PolType Commission Special */
DEFINE            VAR nv_poltyp72   AS CHAR FORMAT "X(3)".      /* PolType Commission Special */
DEFINE            VAR nv_remark     AS CHAR FORMAT "X(49)".   
DEFINE            VAR nv_comdat70   AS DATE FORMAT "99/99/9999".
DEFINE            VAR nv_expdat70   AS DATE FORMAT "99/99/9999".
DEFINE            VAR nv_comdat72   AS DATE FORMAT "99/99/9999".
DEFINE            VAR nv_expdat72   AS DATE FORMAT "99/99/9999".
DEFINE            VAR nv_nor_si         AS DECI FORMAT "->>,>>>,>>9.99".
DEFINE            VAR nv_comp_si        AS DECI FORMAT "->>,>>>,>>9.99".
DEFINE            VAR nv_grossPrem      AS DECI FORMAT "->>,>>>,>>9.99".
DEFINE            VAR nv_grossPrem_comp AS DECI FORMAT "->>,>>>,>>9.99".
DEFINE            VAR nv_netamount      AS DECI FORMAT "->>,>>>,>>9.99" INIT 0.
DEFINE            VAR nv_totalprm       AS DECI FORMAT "->>,>>>,>>9.99" INIT 0.
DEFINE            VAR nv_tax_per        AS DECI FORMAT "->>9.99" INIT 0.
DEFINE            VAR nv_stamp_per      AS DECI FORMAT "->>9.99" INIT 0.
DEFINE            VAR nv_comm_per70     AS DECI FORMAT ">9.999"  INIT 0.
DEFINE            VAR nv_comm_per72     AS DECI FORMAT ">9.999"  INIT 0.

DEFINE  VAR nv_nor_net      AS DECI FORMAT "->>,>>>,>>9.99" INIT 0.
DEFINE  VAR nv_nor_prm      AS DECI FORMAT "->>,>>>,>>9.99" INIT 0.
DEFINE  VAR nv_nor_com      AS DECI FORMAT "->>,>>>,>>9.99" INIT 0.
DEFINE  VAR nv_stamp70      AS DECI FORMAT "->>,>>>,>>9.99" INIT 0.
DEFINE  VAR nv_vat70        AS DECI FORMAT "->>,>>>,>>9.99" INIT 0.
DEFINE  VAR nv_vat_comm70   AS DECI FORMAT "->>,>>>,>>9.99" INIT 0.
DEFINE  VAR nv_tax3_comm70  AS DECI FORMAT "->>,>>>,>>9.99" INIT 0.

DEFINE  VAR nv_comp_net     AS DECI FORMAT "->>,>>>,>>9.99" INIT 0.
DEFINE  VAR nv_comp_prm     AS DECI FORMAT "->>,>>>,>>9.99" INIT 0.
DEFINE  VAR nv_comp_com     AS DECI FORMAT "->>,>>>,>>9.99" INIT 0.
DEFINE  VAR nv_stamp72      AS DECI FORMAT "->>,>>>,>>9.99" INIT 0.
DEFINE  VAR nv_vat72        AS DECI FORMAT "->>,>>>,>>9.99" INIT 0.
DEFINE  VAR nv_vat_comm72   AS DECI FORMAT "->>,>>>,>>9.99" INIT 0.
DEFINE  VAR nv_tax3_comm72  AS DECI FORMAT "->>,>>>,>>9.99" INIT 0.

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

DEFINE TEMP-TABLE wBill
        /*--- A500178 ---
        FIELD wAcno         AS CHAR FORMAT "X(7)"
        -----*/
    FIELD wAcno           AS CHAR FORMAT "X(10)"
    FIELD wEndno          AS CHAR FORMAT "X(12)"
    FIELD wTrnty1         AS CHAR FORMAT "X"
    FIELD wTrnty2         AS CHAR FORMAT "X"
    FIELD wDocno          AS CHAR FORMAT /*"X(7)"*/  "X(10)" /* Benjaporn J. A60-0267 date 27/06/2017 */
    FIELD wNorpol         AS CHAR FORMAT "X(25)" 
    FIELD wRecordno       AS INTE /*FORMAT "999999"*/
    FIELD wCedPol         AS CHAR FORMAT "X(20)"
    FIELD wInsure         AS CHAR FORMAT "X(60)"
    FIELD wPolicy         AS CHAR FORMAT "X(16)"
    FIELD wPol72          AS CHAR FORMAT "X(25)"
    FIELD wCovtyp         AS CHAR FORMAT "X(2)"
    FIELD wnor_covamt     AS DECI FORMAT "->>>>>>>9.99"  /*"->>,>>>,>>9.99" */
    FIELD wFIThef         AS DECI FORMAT "->>>>>>>9.99"  /*"->>,>>>,>>9.99" */
    FIELD wNor_Comdat     AS DATE FORMAT "99/99/9999"
    FIELD wNor_Expdat     AS DATE FORMAT "99/99/9999"
    FIELD wNetPrem        AS DECI FORMAT "->>>>>>>9.99"  /*"->>,>>>,>>9.99"*/
    FIELD wTotal_prm      AS DECI FORMAT "->>>>>>>9.99"  /*"->>,>>>,>>9.99"*/
    FIELD wCompNetPrem    AS DECI FORMAT "->>>>>>>9.99"  /*"->>,>>>,>>9.99"*/
    FIELD wCompGrossPrem  AS DECI FORMAT "->>>>>>>9.99"  /*"->>,>>>,>>9.99"*/
    FIELD wClass          AS CHAR FORMAT "X(5)"
    FIELD wVehreg         AS CHAR FORMAT "X(15)"
    FIELD wCha_no         AS CHAR FORMAT "X(20)"
    FIELD wBenname        AS CHAR FORMAT "X(50)"
    FIELD wCampPol        AS CHAR FORMAT "X(20)"
    FIELD wInvoice        AS CHAR FORMAT "X(10)"
    FIELD wTransDate      AS DATE FORMAT "99/99/9999"  
    FIELD wComdat72       AS CHAR FORMAT "99/99/9999"
    FIELD wExpdat72       AS CHAR FORMAT "99/99/9999"
    FIELD wEndcnt         AS INTE FORMAT "999"
    FIELD wrencnt         AS INTE FORMAT "99"

      INDEX wBill01  IS UNIQUE PRIMARY
            wAcno wPolicy wEndno wTrnty1 wTrnty2 wDocno ASCENDING
      INDEX wBill02 wRecordno
      INDEX wBill03 wNor_Comdat wNorpol wPol72 .

/*DEFINE TEMP-TABLE wfAcno
    /*--- A500178 ---
    FIELD wAcno    AS CHAR FORMAT "X(7)"
    -----*/
    FIELD wAcno    AS CHAR FORMAT "X(10)"
    INDEX wList01 IS UNIQUE PRIMARY  wAcno ASCENDING.  kridtiya i. A53-0394*/

/* ------------------------------------------------------------------------ */
DEFINE STREAM filebill1.
DEFINE STREAM filebill2.

DEFINE VAR vExpCount1   AS INTE INIT 0.
DEFINE VAR vCountRec    AS INTE INIT 0.   /* A49-0015 */

DEFINE VAR vBackUp      AS CHAR.
DEFINE VAR vAcProc_fil  AS CHAR.

DEFINE VAR n_comdatF    AS DATE FORMAT "99/99/9999".
DEFINE VAR n_comdatT    AS DATE FORMAT "99/99/9999".

/*--- A500178 --- ปรับ format  nv_ac1 - nv_ac30   จากเดิม  FORMAT "X(7)" เป็น FORMAT "X(10)" ---*/
DEFINE NEW SHARED VAR nv_ac1    AS CHAR FORMAT "X(10)".
DEFINE NEW SHARED VAR nv_ac2    AS CHAR FORMAT "X(10)".
DEFINE NEW SHARED VAR nv_ac3    AS CHAR FORMAT "X(10)".
DEFINE NEW SHARED VAR nv_ac4    AS CHAR FORMAT "X(10)".
DEFINE NEW SHARED VAR nv_ac5    AS CHAR FORMAT "X(10)".
DEFINE NEW SHARED VAR nv_ac6    AS CHAR FORMAT "X(10)".
DEFINE NEW SHARED VAR nv_ac7    AS CHAR FORMAT "X(10)".
DEFINE NEW SHARED VAR nv_ac8    AS CHAR FORMAT "X(10)".
DEFINE NEW SHARED VAR nv_ac9    AS CHAR FORMAT "X(10)".
DEFINE NEW SHARED VAR nv_ac10   AS CHAR FORMAT "X(10)".
DEFINE NEW SHARED VAR nv_ac11   AS CHAR FORMAT "X(10)".
DEFINE NEW SHARED VAR nv_ac12   AS CHAR FORMAT "X(10)".
DEFINE NEW SHARED VAR nv_ac13   AS CHAR FORMAT "X(10)".
DEFINE NEW SHARED VAR nv_ac14   AS CHAR FORMAT "X(10)".
DEFINE NEW SHARED VAR nv_ac15   AS CHAR FORMAT "X(10)".
DEFINE NEW SHARED VAR nv_ac16   AS CHAR FORMAT "X(10)".
DEFINE NEW SHARED VAR nv_ac17   AS CHAR FORMAT "X(10)".
DEFINE NEW SHARED VAR nv_ac18   AS CHAR FORMAT "X(10)".
DEFINE NEW SHARED VAR nv_ac19   AS CHAR FORMAT "X(10)".
DEFINE NEW SHARED VAR nv_ac20   AS CHAR FORMAT "X(10)".
DEFINE NEW SHARED VAR nv_ac21   AS CHAR FORMAT "X(10)".
DEFINE NEW SHARED VAR nv_ac22   AS CHAR FORMAT "X(10)".
DEFINE NEW SHARED VAR nv_ac23   AS CHAR FORMAT "X(10)".
DEFINE NEW SHARED VAR nv_ac24   AS CHAR FORMAT "X(10)".
DEFINE NEW SHARED VAR nv_ac25   AS CHAR FORMAT "X(10)".
DEFINE NEW SHARED VAR nv_ac26   AS CHAR FORMAT "X(10)".
DEFINE NEW SHARED VAR nv_ac27   AS CHAR FORMAT "X(10)".
DEFINE NEW SHARED VAR nv_ac28   AS CHAR FORMAT "X(10)".
DEFINE NEW SHARED VAR nv_ac29   AS CHAR FORMAT "X(10)".
DEFINE NEW SHARED VAR nv_ac30   AS CHAR FORMAT "X(10)".

/*DEFINE            VAR nv_acnoAll AS CHAR. kridtiya i. A53-0394*/
/*DEFINE            VAR nv_acnoTLT AS CHAR. kridtiya i. A53-0394*/
DEFINE VAR nv_strdate AS CHAR.
DEFINE VAR nv_enddate AS CHAR.
/*--- A500178 ---
DEFINE            VAR nv_accode  AS CHAR FORMAT "X(7)".
------**/
DEFINE VAR nv_accode  AS CHAR FORMAT "X(10)".
DEFINE VAR nv_sumfile AS CHAR FORMAT "X(100)".

DEFINE VAR nv_sumprem AS DECI FORMAT ">>>,>>>,>>>,>>9.99".
DEFINE VAR nv_sumcomp AS DECI FORMAT ">>>,>>>,>>>,>>9.99".
DEFINE VAR nv_sum     AS DECI FORMAT ">>>,>>>,>>>,>>9.99".

DEFINE VAR nv_fptr    AS RECID.
DEFINE VAR nv_rec100  AS RECID. /*A50-0070*/
DEFINE VAR n_type     AS INTE.
DEFINE VAR nv_grossPrem_com1 AS DECI FORMAT "->>,>>>,>>9.99".  /*kridtiya i. A53-0314*/

DEFINE VAR nv_row     AS INTE  INIT 0.
DEFINE VAR nv_cnt     AS INTE  INIT 0.
DEFINE STREAM  ns2.
DEFINE VAR nv_daily     AS CHARACTER FORMAT "X(2465)"     INITIAL ""  NO-UNDO.
DEFINE NEW SHARED WORKFILE wdetail NO-UNDO
    FIELD head              AS CHAR   FORMAT "X(4)"    
    FIELD n_binloop         AS CHAR   FORMAT "x(2)"    
    FIELD fi_bindate        AS CHAR   FORMAT "x(8)"    
    FIELD wRecordno         AS CHAR   FORMAT "x(6)"    
    FIELD wjob_nr           AS CHAR   FORMAT "X"       
    FIELD wnorpol           AS CHAR   FORMAT "X(25)"   
    FIELD wpol72            AS CHAR   FORMAT "X(25)"   
    FIELD winsure           AS CHAR   FORMAT "X(60)"   
    FIELD wcha_no           AS CHAR   FORMAT "X(20)"   
    FIELD wengine           AS CHAR   FORMAT "X(20)"   
    FIELD wnor_comdat       AS CHAR   FORMAT "x(8)"    
    FIELD wnor_expdat       AS CHAR   FORMAT "x(8)"    
    FIELD wnor_covamt       AS DECI   FORMAT "-9999999999.99"     
    FIELD wcomp_covamt      AS DECI   FORMAT "-9999999999.99"    
    FIELD wNetPrem          AS DECI   FORMAT "-9999999999.99"     
    FIELD wCompNetPrem      AS DECI   FORMAT "-9999999999.99"    
    FIELD wgrossprem        AS DECI   FORMAT "-9999999999.99"    
    FIELD wCompGrossPrem    AS DECI   FORMAT "-9999999999.99"     
    FIELD wtotal_prm        AS DECI   FORMAT "-9999999999.99"   
    FIELD wnor_comm         AS DECI   FORMAT "-9999999999.99"      
    FIELD wcomp_comm        AS DECI   FORMAT "-9999999999.99"  
    FIELD wnor_vat          AS DECI   FORMAT "-9999999999.99"     
    FIELD wcomp_vat         AS DECI   FORMAT "-9999999999.99"    
    FIELD wnor_tax3         AS DECI   FORMAT "-9999999999.99"    
    FIELD wcomp_tax3        AS DECI   FORMAT "-9999999999.99"  
    FIELD wNetPayment       AS DECI   FORMAT "-9999999999.99"  
    FIELD wsubins           AS CHAR   FORMAT "X(4)"    
    FIELD wcomp_sub         AS CHAR   FORMAT "X(4)"    
    FIELD wcomp_comdat      AS CHAR   FORMAT "x(8)"    
    FIELD wcomp_expdat      AS CHAR   FORMAT "x(8)"    
    FIELD wremark           AS CHAR   FORMAT "X(49)"  .
/*add kridtiya i. A53-0167............*/
DEFINE TEMP-TABLE  wagtprm_fil  
    FIELD Policy         AS CHAR  FORMAT "X(16)"
    FIELD trntyp         AS CHAR  FORMAT "x(2)"
    FIELD Docno          AS CHAR  FORMAT "X(10)"
    FIELD Invoice        AS CHAR  FORMAT "X(10)"
    FIELD Vehreg         AS CHAR  FORMAT "X(15)"
    FIELD prem           AS DECI  FORMAT "->>,>>>,>>9.99"
    FIELD grossprm       AS DECI  FORMAT "->>,>>>,>>9.99"
    FIELD prem_comp      AS DECI  FORMAT "->>,>>>,>>9.99"
    FIELD Endno          AS CHAR  FORMAT "X(12)"
    FIELD bal            AS DECI  FORMAT "->>,>>>,>>9.99"
    FIELD Insure         AS CHAR  FORMAT "X(50)"
    FIELD stamp          AS DECI  FORMAT "->>,>>>,>>9.99"
    FIELD tax            AS DECI  FORMAT "->>,>>>,>>9.99"
    FIELD Acno           AS CHAR  FORMAT "X(10)" 
    FIELD Trnty          AS CHAR  FORMAT "X(2)"
    FIELD Comdat         AS DATE  FORMAT "99/99/9999"
    FIELD Poltyp         AS CHAR  FORMAT "X(3)"
    FIELD Trndat         AS DATE  FORMAT "99/99/9999"  
    FIELD ASdat          AS DATE  FORMAT "99/99/9999" 
    FIELD nv_comm_per70  AS DECI  FORMAT ">9.999"  INIT 0 
    FIELD nv_comm_per72  AS DECI  FORMAT ">9.999"  INIT 0  
INDEX wagtprm_fil01  IS UNIQUE PRIMARY Acno Policy Endno Trnty Docno ASCENDING .
/*add kridtiya i.   A53-0394 */
DEFINE VAR  tim01   AS CHAR INIT "".
DEFINE VAR  tim02   AS CHAR INIT "".
DEFINE VAR  n_cha_no LIKE uwm301.cha_no.
DEFINE VAR  n_eng_no LIKE uwm301.eng_no.
DEFINE VAR  n_vehreg LIKE uwm301.vehreg.
DEFINE VAR  tim02_1 AS INTE INIT 0.
DEFINE VAR  tim02_2 AS INTE INIT 0.
DEFINE VAR  tim02_3 AS INTE INIT 0.

DEFINE VAR vProdCod       AS CHAR.
/*DEFINE VAR vProdcodAll  AS CHAR.
DEFINE VAR vCountRec      AS INT.
DEFINE VAR vAcProc_fil    AS CHAR. */
DEFINE VAR vChkFirstAdd   AS INT.
DEFINE VAR n_append       AS CHAR INIT "" .
/*add kridtiya i.   A53-0394 */

/*--- Add Porn ----*/
DEFINE VAR n_ben83   AS CHAR FORMAT "X(50)".
DEFINE VAR n_cedpol  AS CHAR FORMAT "X(20)".
DEFINE VAR n_opnpol  AS CHAR FORMAT "X(30)".
DEFINE VAR n_class   AS CHAR FORMAT "X(5)".
DEFINE VAR n_covcod  AS CHAR FORMAT "X(2)".
DEFINE VAR n_endcnt  AS INTE FORMAT "999".
DEFINE VAR n_rencnt  AS INTE FORMAT "999".
DEFINE VAR n_fithef  AS DECI FORMAT "->>,>>>,>>>,>>>9.99" .
DEFINE VAR n_invoice AS CHAR FORMAT "X(12)"  INIT "".    /*kridtiya i. a54-0180*/        
DEFINE VAR n_invdat  AS CHAR FORMAT "x(10)"  INIT "". 
DEFINE VAR n_trndat  AS DATE FORMAT "99/99/9999".
DEFINE VAR nv_trndat AS DATE FORMAT "99/99/9999".

DEFINE VAR nv_message AS CHAR FORMAT "X(20)".

DEFINE BUFFER bwagtprm_fil FOR  wagtprm_fil.
DEFINE VAR nProdCod AS CHAR.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS fiBranch fiBranch2 fi_producer se_producer ~
bu_add cbAsDat fibdes fi_comdatF fibdes2 fi_comdatT fi_process fi_binloop ~
fi_bindate fiFile-Name1 Btn_OK Btn_Exit buBranch buBranch2 bu_clr bu_del ~
RECT-1 RECT-3 RECT-4 RECT-6 RECT-7 RECT-8 RECT-605 RECT-606 RECT-608 ~
RECT-609 RECT-2 RECT-611 
&Scoped-Define DISPLAYED-OBJECTS fiBranch fiBranch2 fi_producer se_producer ~
cbAsDat fibdes fi_comdatF fibdes2 fi_comdatT fi_process fi_binloop ~
fi_bindate fiFile-Name1 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME


/* ************************  Function Prototypes ********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fuDateToChar C-Win 
FUNCTION fuDateToChar RETURNS CHARACTER
  (vDate AS DATE)  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fuDeciToChar C-Win 
FUNCTION fuDeciToChar RETURNS CHARACTER
  ( vDeci   AS DECIMAL, vCharno AS INTEGER )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fuFindAcno C-Win 
FUNCTION fuFindAcno RETURNS LOGICAL
  ( nv_accode AS CHAR )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fuFindBranch C-Win 
FUNCTION fuFindBranch RETURNS CHARACTER
  ( nv_branch AS CHAR )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fuLeapYear C-Win 
FUNCTION fuLeapYear RETURNS LOGICAL
  ( Y AS INTEGER)  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fuNumYear C-Win 
FUNCTION fuNumYear RETURNS INTEGER
  ( vDate AS DATE )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON Btn_Exit AUTO-END-KEY 
     LABEL "Exit" 
     SIZE 10 BY 1.24
     BGCOLOR 8 FONT 2.

DEFINE BUTTON Btn_OK AUTO-GO 
     LABEL "OK" 
     SIZE 10 BY 1.24
     BGCOLOR 8 FONT 2.

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
     SIZE 6.5 BY 1.

DEFINE BUTTON bu_clr 
     LABEL "CLR" 
     SIZE 6.5 BY 1.

DEFINE BUTTON bu_del 
     LABEL "DEL" 
     SIZE 6.5 BY 1.

DEFINE VARIABLE cbAsDat AS CHARACTER FORMAT "X(256)":U INITIAL ? 
     VIEW-AS COMBO-BOX INNER-LINES 5
     DROP-DOWN-LIST
     SIZE 16 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fibdes AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 50 BY 1
     BGCOLOR 18 FGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fibdes2 AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 50 BY 1
     BGCOLOR 18 FGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiBranch AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fiBranch2 AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fiFile-Name1 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 63 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_bindate AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_binloop AS INTEGER FORMAT "99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 3.5 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_comdatF AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_comdatT AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_process AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 84.5 BY 1.05
     BGCOLOR 172 FGCOLOR 30 FONT 2 NO-UNDO.

DEFINE VARIABLE fi_producer AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 39.67 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 22.5 BY 13.81
     BGCOLOR 32 FGCOLOR 15 .

DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 85 BY 13.81
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-3
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 22.5 BY 1.91
     BGCOLOR 32 .

DEFINE RECTANGLE RECT-4
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 84.67 BY 1.91
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-6
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 12.5 BY 1.86
     BGCOLOR 32 .

DEFINE RECTANGLE RECT-605
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 8.5 BY 1.43
     BGCOLOR 3 .

DEFINE RECTANGLE RECT-606
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 8.5 BY 1.43
     BGCOLOR 11 .

DEFINE RECTANGLE RECT-608
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 8.5 BY 1.43
     BGCOLOR 12 .

DEFINE RECTANGLE RECT-609
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 11.5 BY 3.57.

DEFINE RECTANGLE RECT-611
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 10 BY 3.1
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-7
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 12.67 BY 1.86
     BGCOLOR 155 .

DEFINE RECTANGLE RECT-8
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 42 BY 1.57
     BGCOLOR 19 .

DEFINE VARIABLE se_producer AS CHARACTER 
     VIEW-AS SELECTION-LIST SINGLE SCROLLBAR-VERTICAL 
     SIZE 39.5 BY 3.57
     BGCOLOR 15  NO-UNDO.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     fiBranch AT ROW 3.91 COL 29 COLON-ALIGNED NO-LABEL
     fiBranch2 AT ROW 5.33 COL 29 COLON-ALIGNED NO-LABEL
     fi_producer AT ROW 6.62 COL 28.83 COLON-ALIGNED NO-LABEL
     se_producer AT ROW 7.81 COL 31 NO-LABEL
     bu_add AT ROW 6.67 COL 70.83
     cbAsDat AT ROW 11.48 COL 29.17 COLON-ALIGNED NO-LABEL
     fibdes AT ROW 3.91 COL 37.83 COLON-ALIGNED NO-LABEL
     fi_comdatF AT ROW 12.76 COL 41.17 COLON-ALIGNED NO-LABEL
     fibdes2 AT ROW 5.33 COL 38 COLON-ALIGNED NO-LABEL
     fi_comdatT AT ROW 12.76 COL 66.33 COLON-ALIGNED NO-LABEL
     fi_process AT ROW 19.24 COL 26.17 COLON-ALIGNED NO-LABEL
     fi_binloop AT ROW 14.05 COL 29 COLON-ALIGNED NO-LABEL
     fi_bindate AT ROW 15.43 COL 29 COLON-ALIGNED NO-LABEL
     fiFile-Name1 AT ROW 17.62 COL 28.67 COLON-ALIGNED NO-LABEL
     Btn_OK AT ROW 21.43 COL 71.5
     Btn_Exit AT ROW 21.43 COL 83.83
     buBranch AT ROW 3.91 COL 36.17
     buBranch2 AT ROW 5.33 COL 36.17
     bu_clr AT ROW 8.52 COL 72.83
     bu_del AT ROW 9.76 COL 73
     " รอบของการวางบิล" VIEW-AS TEXT
          SIZE 19.5 BY 1 AT ROW 14.05 COL 6.5
          BGCOLOR 19 FGCOLOR 0 
     " Branch From":25 VIEW-AS TEXT
          SIZE 19.5 BY 1 TOOLTIP "ตั้งแต่สาขา" AT ROW 3.91 COL 6.5
          BGCOLOR 19 FGCOLOR 0 
     "  ส่งข้อมูล Statement สินเอเซีย (Excel File)" VIEW-AS TEXT
          SIZE 39.5 BY 1 AT ROW 1.67 COL 40.17
          BGCOLOR 1 FGCOLOR 7 FONT 6
     " รอบวันของการวางบิล" VIEW-AS TEXT
          SIZE 19.5 BY 1 AT ROW 15.43 COL 6.5
          BGCOLOR 19 FGCOLOR 0 
     " Trans. date" VIEW-AS TEXT
          SIZE 19.5 BY .95 AT ROW 12.76 COL 6.5
          BGCOLOR 19 
     "Date From" VIEW-AS TEXT
          SIZE 11 BY 1 AT ROW 12.76 COL 31.17
          BGCOLOR 19 FGCOLOR 0 
     " Output To TextFile" VIEW-AS TEXT
          SIZE 19.5 BY 1 AT ROW 17.57 COL 6.33
          BGCOLOR 19 FGCOLOR 0 
     "Date To" VIEW-AS TEXT
          SIZE 9 BY 1 AT ROW 12.76 COL 58
          BGCOLOR 19 FGCOLOR 0 
     " Group Producer Code" VIEW-AS TEXT
          SIZE 19.5 BY 1 AT ROW 6.76 COL 6.5
          BGCOLOR 19 FGCOLOR 0 
     " Branch To":10 VIEW-AS TEXT
          SIZE 19.5 BY 1 TOOLTIP "ถึงสาขา" AT ROW 5.33 COL 6.5
          BGCOLOR 19 FGCOLOR 0 
     " As of Date (Statement)":30 VIEW-AS TEXT
          SIZE 19.5 BY .95 TOOLTIP "วันที่ออกรายงาน" AT ROW 11.52 COL 6.5
          BGCOLOR 19 FGCOLOR 0 
     RECT-1 AT ROW 3.29 COL 4.67
     RECT-3 AT ROW 17.14 COL 4.67
     RECT-4 AT ROW 17.19 COL 28
     RECT-6 AT ROW 21.1 COL 70
     RECT-7 AT ROW 21.1 COL 82.5
     RECT-8 AT ROW 1.38 COL 39.17
     RECT-605 AT ROW 6.43 COL 70.83
     RECT-606 AT ROW 8.14 COL 71.83
     RECT-608 AT ROW 9.67 COL 71.83
     RECT-609 AT ROW 7.81 COL 70.33
     RECT-2 AT ROW 3.29 COL 28
     RECT-611 AT ROW 8.05 COL 71.17
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         NO-LABELS SIDE-LABELS THREE-D 
         AT COL 1 ROW 1
         SIZE 116.5 BY 22.86
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
         TITLE              = "waclacl1 - วางบิล สินเอเซีย"
         HEIGHT             = 22.86
         WIDTH              = 116.5
         MAX-HEIGHT         = 22.86
         MAX-WIDTH          = 116.5
         VIRTUAL-HEIGHT     = 22.86
         VIRTUAL-WIDTH      = 116.5
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
/* SETTINGS FOR FRAME fr_main
   FRAME-NAME UNDERLINE Custom                                          */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* waclacl1 - วางบิล สินเอเซีย */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* waclacl1 - วางบิล สินเอเซีย */
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
   /*--- A500178 ---*/   
   ASSIGN
        tim01         = STRING(TIME,"HH:MM:SS")  /*add kridtiya i.   A53-0394 */
        fibranch fibranch
        fibranch2 fibranch2   
        fiFile-Name1 fiFile-Name1
        n_branch       =  fiBranch
        n_branch2      =  fiBranch2
        n_asdat        =  DATE(INPUT cbAsDat)
        n_OutputFile1  =  fiFile-Name1
        n_comdatF      =  fi_comdatF
        n_comdatT      =  fi_comdatT.

   IF fiBranch = "" THEN DO:
       MESSAGE "กรุณาใส่รหัสสาขา" VIEW-AS ALERT-BOX WARNING.
       APPLY "Entry" TO fiBranch.
       RETURN NO-APPLY.
   END.
   IF fiBranch2 = "" THEN DO:
       MESSAGE "กรุณาใส่รหัสสาขา" VIEW-AS ALERT-BOX WARNING.
       APPLY "Entry" TO fiBranch2.
       RETURN NO-APPLY.
   END.
   IF (fiBranch > fiBranch2) THEN DO:
       MESSAGE "ข้อมูลรหัสสาขาผิดพลาด" SKIP
               "รหัสสาขาเริ่มต้นต้องน้อยกว่ารหัสสุดท้าย" VIEW-AS ALERT-BOX WARNING.
       APPLY "Entry" To fibranch.
       RETURN NO-APPLY.
   END.

   IF fi_binloop = 0 THEN DO:
       MESSAGE "กรุณาคีย์จำนวนรอบของการวางบิล" VIEW-AS ALERT-BOX WARNING.
       APPLY "Entry" TO fi_binloop.
       RETURN NO-APPLY.
   END.

   IF fi_bindate = ? THEN DO:
       MESSAGE "กรุณาคีย์รอบวันที่ของการวางบิล" VIEW-AS ALERT-BOX WARNING.
       APPLY "Entry" TO fi_bindate.
       RETURN NO-APPLY.
   END.

   IF n_OutputFile1 = "" THEN DO:
       MESSAGE "กรุณาใส่ชื่อไฟล์" VIEW-AS ALERT-BOX WARNING.
       APPLY "Entry" TO fiFile-Name1.
       RETURN NO-APPLY.
   END.

   /*---- A49-0002 ----*/
   nv_strdate = STRING(TODAY,"99/99/9999") + " (" +
                STRING(TIME ,"HH:MM:SS")   + " น.)".
   
   /*------ Create File ------*/
  /* IF n_type = 1 THEN RUN pdproc.
   ELSE RUN pdproc_2.   /*kridtiya i. A53-0167 06/05/2010 */*/
   RUN PDProc_2.

   /*---- Export File ----*/
   /*RUN pdo3*/ /*--- Put Text & Excel File ---*/
   RUN pdo3_ex.  /*--- Put Excel Only ---*/

   DISPLAY "Export Data Complete...." @ fi_process WITH FRAME {&FRAME-NAME}.

   /*----- Process Time Total Value ----*/
   ASSIGN nv_enddate = STRING(TODAY,"99/99/9999") + " (" +
                       STRING(TIME ,"HH:MM:SS")   + " น.)"
       tim02         = STRING(TIME,"HH:MM:SS")
       tim02_1       = 0
       tim02_2       = 0
       tim02_3       = 0 .
   IF  DECI(SUBSTR(tim02,7,2)) < DECI(SUBSTR(tim01,7,2))  THEN DO:
       ASSIGN tim02_3 =  DECI(SUBSTR(tim02,7,2)) + 60 .
       IF DECI(SUBSTR(tim02,4,2)) < DECI(SUBSTR(tim01,4,2))    THEN DO:
           ASSIGN tim02_2 = DECI(SUBSTR(tim02,4,2)) + 60 - 1
               tim02_1    = DECI(SUBSTR(tim02,1,2)) - 1.
       END.
       ELSE ASSIGN tim02_2 = DECI(SUBSTR(tim02,4,2))  - 1
           tim02_1   =  DECI(SUBSTR(tim02,1,2)) .
   END.
   ELSE DO: 
       IF DECI(SUBSTR(tim02,4,2)) < DECI(SUBSTR(tim01,4,2)) THEN 
           ASSIGN tim02_3 =  DECI(SUBSTR(tim02,7,2))
           tim02_2    = DECI(SUBSTR(tim02,4,2)) + 60 
           tim02_1    = DECI(SUBSTR(tim02,1,2)) - 1.
       ELSE 
           ASSIGN tim02_1   =  DECI(SUBSTR(tim02,1,2))
               tim02_2   =  DECI(SUBSTR(tim02,4,2))
               tim02_3 =  DECI(SUBSTR(tim02,7,2)).
   END.
   tim02 = STRING(tim02_1 - DECI(SUBSTR(tim01,1,2)),"99") + ":" +
           STRING(tim02_2 - DECI(SUBSTR(tim01,4,2)),"99") + ":" + 
           STRING(tim02_3 - DECI(SUBSTR(tim01,7,2)),"99").
   
   MESSAGE "Dump ข้อมูลลง Text File : " fiFile-Name1 SKIP(1)
           "Text File สรุปข้อมูล    : " nv_sumfile   SKIP(1)
           "Satatement จำนวน        : " nv_cnt  " รายการ" SKIP(1)
                                        FILL("=",27) SKIP(1)
           "Start Date : " nv_strdate   SKIP(1)
           "End Date   : " nv_enddate   SKIP(1)
           "Time       : " tim01 STRING(TIME,"HH:MM:SS") tim02  VIEW-AS ALERT-BOX INFORMATION.

   ASSIGN tim01 = "" 
          nv_cnt = 0.
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
       fibranch = n_branch
       fibdes   = n_bdes.

   DISP fibranch fibdes WITH FRAME {&FRAME-NAME}.

   APPLY "ENTRY" TO fibranch IN FRAME {&FRAME-NAME}.
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
        fibranch2 = n_branch2
        fibdes2   = n_bdes.

    DISP fibranch2 fibdes2 WITH FRAME {&FRAME-NAME}.

    APPLY "ENTRY" TO fibranch2 IN FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_add
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_add C-Win
ON CHOOSE OF bu_add IN FRAME fr_main /* ADD */
DO:
    IF fi_producer = "" THEN DO:
        MESSAGE "Not Create Brand..! is empty!!!..." VIEW-AS ALERT-BOX .
        APPLY "ENTRY" TO fi_producer.   
    END.
    ELSE DO:
         FOR EACH xmm600 USE-INDEX xmm60009 WHERE xmm600.gpstmt = fi_producer NO-LOCK:          
             /*---- Comment A54-0238 ----
             IF LOOKUP(fi_producer,vProdcod) <> 0 THEN DO:
                 fi_Producer = "".
                 APPLY "ENTRY" TO fi_Producer IN FRAME fr_main.
                 DISP fi_Producer WITH FRAME fr_main.
             END.
             ELSE DO:
                 vProdCod = /*vProdCod + "," +*/ xmm600.acno + "," + vProdCod.
             END.
             ---- End Comment A54-0238 ----*/
             IF nProdCod = "" THEN nProdCod = xmm600.acno.
             ELSE nProdCod = xmm600.acno + "," + nProdCod.
             
         END.
         /*--- Add A54-0238 ---*/
         DO WITH FRAME  fr_main :
             /*vProdCod = nProdCod.*/      
             se_producer:ADD-FIRST(nProdCod).
             se_producer = se_producer:SCREEN-VALUE .
             vProdCod = se_producer:LIST-ITEMS.
         END.
 
         fi_process = vProdCod .
         DISP fi_process WITH FRAME fr_main.
         nProdCod = "".
         /*--- End Add A54-0238 ---*/
         /*RUN proc_createproducer.*//*-- Comment A54-0238 ---*/
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_clr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_clr C-Win
ON CHOOSE OF bu_clr IN FRAME fr_main /* CLR */
DO:
    ASSIGN 
        fi_producer = ""
        se_producer = se_producer:LIST-ITEMS.

ASSIGN vChkFirstAdd = 2 .
IF vChkFirstAdd = 2 THEN DO:
    DO WITH FRAME  fr_main :
        vProdCod = vProdCod.      
        se_producer:DELETE(se_producer).
        se_producer = se_producer:SCREEN-VALUE .
        vProdCod = "".
    END.

    DISP "" @ fi_producer WITH FRAME fr_main.
    APPLY "ENTRY" TO fi_producer IN FRAME fr_main.
    RETURN NO-APPLY.
END.



/*---
    DO WITH FRAME  fr_main :
        se_producer = se_producer:LIST-ITEMS.
        IF  LOOKUP(se_producer,vProdCod) <> 0 THEN DO:
            IF LOOKUP(se_producer,vProdCod) = 1 THEN 
                vProdCod = SUBSTR(vProdCod,LENGTH(se_producer) + 2).
            ELSE 
                vProdCod = SUBSTR(vProdCod,1,INDEX(vProdCod,se_producer) - 2 ) + 
                    SUBSTR(vProdCod,INDEX(vProdCod,se_producer) + LENGTH(se_producer) ).
        END.
        ASSIGN   
            se_producer.
        se_producer:DELETE(se_producer).
        se_producer = se_producer:SCREEN-VALUE .
    END.
    DISP "" @ fi_producer WITH FRAME fr_main.
---*/
   /* DO WITH FRAME  fr_main :
        
        se_producer = se_producer:SCREEN-VALUE .
        /*IF  LOOKUP(se_producer,vProdCod) <> 0 THEN DO:
            IF LOOKUP(se_producer,vProdCod) = 1 THEN 
                vProdCod = SUBSTR(vProdCod,LENGTH(se_producer) + 2).
            ELSE 
                vProdCod = SUBSTR(vProdCod,1,INDEX(vProdCod,se_producer) - 2 ) + 
                    SUBSTR(vProdCod,INDEX(vProdCod,se_producer) + LENGTH(se_producer) ).
        END.*/
        ASSIGN   
            se_producer.
        se_producer:DELETE(se_producer).
        se_producer = se_producer:SCREEN-VALUE .
    END.
    DISP "" @ fi_producer WITH FRAME fr_main.

    APPLY "ENTRY" TO fi_producer IN FRAME fr_main.
    DISP  fi_producer  WITH FRAME  fr_main.
    */
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_del
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_del C-Win
ON CHOOSE OF bu_del IN FRAME fr_main /* DEL */
DO:
    DO WITH FRAME  fr_main :
        se_producer = se_producer:SCREEN-VALUE .
        IF  LOOKUP(se_producer,vProdCod) <> 0 THEN DO:
            IF LOOKUP(se_producer,vProdCod) = 1 THEN 
                vProdCod = SUBSTR(vProdCod,LENGTH(se_producer) + 2).
            ELSE 
                vProdCod = SUBSTR(vProdCod,1,INDEX(vProdCod,se_producer) - 2 ) + 
                           SUBSTR(vProdCod,INDEX(vProdCod,se_producer) + LENGTH(se_producer) ).
        END.
        ASSIGN   
            se_producer.
        se_producer:DELETE(se_producer).
        se_producer = se_producer:SCREEN-VALUE .
    END.
    DISP "" @ fi_producer WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME cbAsDat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cbAsDat C-Win
ON LEAVE OF cbAsDat IN FRAME fr_main
DO:
    /*p-------------*/
    cbAsDat = INPUT cbAsDat.
    n_asdat = DATE(INPUT cbAsDat).

    IF n_asdat = ? THEN DO:
        MESSAGE "ไม่พบข้อมูล กรุณาตรวจสอบการ Process ข้อมูล" VIEW-AS ALERT-BOX WARNING.
        RETURN NO-APPLY.
    END.
    /*-------------p*/

    APPLY "ENTRY" TO fi_comdatF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cbAsDat C-Win
ON RETURN OF cbAsDat IN FRAME fr_main
DO:
    APPLY "LEAVE" TO cbAsDat.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cbAsDat C-Win
ON VALUE-CHANGED OF cbAsDat IN FRAME fr_main
DO:
    /*p-------------*/
    cbAsDat = INPUT cbAsDat.
    n_asdat = DATE(INPUT cbAsDat).

    IF n_asdat = ? THEN DO:
        MESSAGE "ไม่พบข้อมูล กรุณาตรวจสอบการ Process ข้อมูล" VIEW-AS ALERT-BOX WARNING.
        RETURN NO-APPLY.
    END.
    APPLY "ENTRY" TO fi_comdatF IN FRAME {&FRAME-NAME}.
    RETURN NO-APPLY.
    /*-------------p*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiBranch
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiBranch C-Win
ON LEAVE OF fiBranch IN FRAME fr_main
DO:
    APPLY "RETURN" TO fiBranch.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiBranch C-Win
ON RETURN OF fiBranch IN FRAME fr_main
DO:
    ASSIGN
        fibranch = CAPS(INPUT fibranch)
        n_branch = fibranch.

    fibdes  = fuFindBranch(fibranch).

    IF fibdes = "" THEN DO:
        MESSAGE "ไม่พบข้อมูล" VIEW-AS ALERT-BOX WARNING.
        APPLY "ENTRY" TO fiBranch.
        RETURN NO-APPLY.
    END.

    DISP fibranch fibdes WITH FRAME {&FRAME-NAME}.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiBranch2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiBranch2 C-Win
ON LEAVE OF fiBranch2 IN FRAME fr_main
DO:
    APPLY "RETURN" TO fiBranch2.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiBranch2 C-Win
ON RETURN OF fiBranch2 IN FRAME fr_main
DO:
    ASSIGN
        fibranch2 = INPUT fibranch2
        n_branch2  = fibranch2.

    fibdes2 = fuFindBranch(fibranch2).

    IF fibdes2 = "" THEN DO:
        MESSAGE "ไม่พบข้อมูล" VIEW-AS ALERT-BOX WARNING TITLE "Warning!".
        APPLY "ENTRY" TO fiBranch2.
        RETURN NO-APPLY.
    END.

    DISP fibranch2 fibdes2 WITH FRAME {&FRAME-NAME}.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiFile-Name1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiFile-Name1 C-Win
ON LEAVE OF fiFile-Name1 IN FRAME fr_main
DO:
    APPLY "RETURN" TO fiFile-Name1.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiFile-Name1 C-Win
ON RETURN OF fiFile-Name1 IN FRAME fr_main
DO:
    fiFile-Name1 = TRIM(CAPS(INPUT fiFile-Name1)).

    DISPLAY fiFile-Name1 WITH FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_bindate
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_bindate C-Win
ON LEAVE OF fi_bindate IN FRAME fr_main
DO:
    fi_bindate = INPUT fi_bindate.

    DISPLAY fi_bindate WITH FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_binloop
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_binloop C-Win
ON LEAVE OF fi_binloop IN FRAME fr_main
DO:
    fi_binloop = INPUT fi_binloop.

    DISPLAY fi_binloop WITH FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_comdatF
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_comdatF C-Win
ON LEAVE OF fi_comdatF IN FRAME fr_main
DO:
    fi_comdatF = INPUT fi_comdatF.
    n_comdatF  = fi_comdatF.

    DISPLAY fi_comdatF WITH FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_comdatT
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_comdatT C-Win
ON LEAVE OF fi_comdatT IN FRAME fr_main
DO:
    fi_comdatT = INPUT fi_comdatT.
    n_comdatT  = fi_comdatT.
    IF n_comdatT <> ?  THEN DO:
        APPLY "ENTRY" TO fi_binloop IN FRAME {&FRAME-NAME}.
        RETURN NO-APPLY.
    END.
    DISPLAY fi_comdatT WITH FRAME {&FRAME-NAME}.

    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_producer
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_producer C-Win
ON LEAVE OF fi_producer IN FRAME fr_main
DO:
  fi_producer = INPUT fi_producer.
  DISP fi_producer WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_producer C-Win
ON RETURN OF fi_producer IN FRAME fr_main
DO:
  /*fi_producer = INPUT fi_producer.
  DISP fi_producer WITH FRAM fr_main.

  APPLY "CHOOES" TO bu_add .
  RETURN NO-APPLY.*/
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

  gv_prgid = "WACLACL1".
  gv_prog  = "Statement สินเอเซีย (LACL)".
  RUN  WUT\WUTHEAD (c-win:HANDLE,gv_prgid,gv_prog).
  RUN  WUT\WUTDICEN (c-win:HANDLE).
/*********************************************************************/

   SESSION:DATA-ENTRY-RETURN = YES.
   SESSION:DATE-FORMAT  = "DMY".    /* -d dmy */

  /* RECT-1:MOVE-TO-TOP( ).
   RECT-2:MOVE-TO-TOP( ).
   RECT-3:MOVE-TO-TOP( ).
   RECT-4:MOVE-TO-TOP( ).*/

   ASSIGN
    nv_User = n_user
    nv_pwd  = n_passwd.

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
      fi_binloop    = 90
      fi_bindate    = DATE(MONTH(TODAY),20,YEAR(TODAY))
      n_comdatF     = ?
      n_comdatT     = ?
      n_OutputFile1 = "" 
      /*ra_type       = 2  */     /*kridtiya i. A53-0167*/
      fi_comdatF    = TODAY       /*kridtiya i. A53-0167*/
      fi_comdatT    = TODAY       /*kridtiya i. A53-0167*/
      fiFile-Name1  = "D:\LACL"   /*kridtiya i. A53-0167*/
      tim01         = ""
      tim02         = "" 
      se_producer   = "".

   fibdes  = fuFindBranch(fibranch).
   fibdes2 = fuFindBranch(fibranch2).
   /*RUN proc_createproducer.*//*Porn*/
   DISP fibranch   fibranch2  fibdes fibdes2  /*ra_type*/ fi_comdatF fi_comdatT se_producer
        fi_process fi_binloop fi_bindate fiFile-Name1 WITH FRAME {&FRAME-NAME}.
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
  DISPLAY fiBranch fiBranch2 fi_producer se_producer cbAsDat fibdes fi_comdatF 
          fibdes2 fi_comdatT fi_process fi_binloop fi_bindate fiFile-Name1 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE fiBranch fiBranch2 fi_producer se_producer bu_add cbAsDat fibdes 
         fi_comdatF fibdes2 fi_comdatT fi_process fi_binloop fi_bindate 
         fiFile-Name1 Btn_OK Btn_Exit buBranch buBranch2 bu_clr bu_del RECT-1 
         RECT-3 RECT-4 RECT-6 RECT-7 RECT-8 RECT-605 RECT-606 RECT-608 RECT-609 
         RECT-2 RECT-611 
      WITH FRAME fr_main IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdnopol72 C-Win 
PROCEDURE pdnopol72 :
/*------------------------------------------------------------------------------
  Purpose:             /* copy program : Wactlt1.i : หา Compulsory Policy No.         */  
  Parameters:  <none>  /* Link from : Wactlt1.w                                       */  
  Notes:               /* Create By : kridtiya i. A53-0167    25/05/2010              */  
------------------------------------------------------------------------------*/
DEF BUFFER bwagtprm_fil FOR  wagtprm_fil.

/*---- Class ---*/
FIND FIRST uwm120 USE-INDEX uwm12001  WHERE
           uwm120.policy = uwm100.policy     AND
           uwm120.rencnt = uwm100.rencnt     AND
           uwm120.endcnt = uwm100.endcnt     NO-LOCK NO-ERROR NO-WAIT.
IF NOT AVAILABLE uwm120 THEN NEXT. 
ELSE DO:
    IF SUBSTRING(uwm120.policy,3,2) = "72" THEN n_class = uwm120.class. ELSE n_class = SUBSTRING(uwm120.class,2,3).
END.
    /*n_class = IF LENGTH(uwm120.class) = 4 THEN SUBSTRING(uwm120.class,2,3) ELSE uwm120.class.*/

FIND FIRST uwm301 USE-INDEX uwm30101  WHERE
           uwm301.policy = uwm100.policy     AND
           uwm301.rencnt = uwm100.rencnt     AND
           uwm301.endcnt = uwm100.endcnt     NO-LOCK NO-ERROR NO-WAIT.
IF NOT AVAILABLE uwm301 THEN NEXT.
ELSE DO:
    ASSIGN 
        n_cha_no =  uwm301.cha_no
        n_eng_no =  uwm301.eng_no  
        n_vehreg =  uwm301.vehreg
        n_ben83  =  SUBSTRING(uwm301.mv_ben83,1,50)
        n_covcod =  uwm301.covcod
        n_Endcnt =  uwm301.endcnt
        n_rencnt =  uwm301.rencnt.
END.

FIND xmm020 USE-INDEX xmm02001        WHERE
     xmm020.branch = uwm100.branch     AND
     xmm020.dir_ri = uwm100.dir_ri     NO-LOCK NO-ERROR.
IF AVAILABLE xmm020 THEN
    ASSIGN  
    nv_stamp_per  = xmm020.rvstam
    nv_tax_per    = xmm020.rvtax.

FIND FIRST uwm130 USE-INDEX uwm13001  WHERE
           uwm130.policy = uwm301.policy     AND
           uwm130.rencnt = uwm301.rencnt     AND
           uwm130.endcnt = uwm301.endcnt     AND
           uwm130.riskgp = uwm301.riskgp     AND
           uwm130.riskno = uwm301.riskno     AND
           uwm130.itemno = uwm301.itemno     NO-LOCK NO-ERROR.
IF NOT AVAILABLE uwm130 THEN NEXT.
ELSE DO: 
    ASSIGN
        n_fithef  = uwm130.uom7_v
        nv_nor_si = uwm130.uom6_v.
END.

IF uwm130.uom8_v <> 0 AND uwm130.uom9_v <> 0 THEN DO:     /* 70-Compulsory + Policy */
    ASSIGN  
        nv_pol72     = ""                                 
        nv_pol72     = uwm100.cr_2 /*uwm130.policy*/                     /* Policy of Compulsory */
        nv_comdat72  = wagtprm_fil.comdat              
        nv_expdat72  = uwm100.expdat .                    /* SI of Compulsory */

    IF uwm130.uom8_v = 50000 THEN nv_comp_si = 80000. 
    ELSE nv_comp_si = uwm130.uom8_v.  

    ASSIGN 
        nv_comp_net = wagtprm_fil.prem_comp               /* Premium of Compulsory */
        nv_comp_prm = nv_comp_net
        nv_stamp72  = TRUNCATE(nv_comp_net * nv_stamp_per / 100,0) +   /* Stamp of Compulsory */
                      (IF (nv_comp_net * nv_stamp_per / 100) -
                       TRUNCATE(nv_comp_net * nv_stamp_per / 100,0) > 0
                       THEN 1 ELSE 0).
        /* Tax of Compulsory */
    IF uwm100.gstrat <> 0 AND wagtprm_fil.tax <> 0 THEN
        nv_vat72 = (nv_comp_net + nv_stamp72) * uwm100.gstrat / 100.
    ASSIGN 
        nv_stamp70 = wagtprm_fil.stamp - nv_stamp72      /* Stamp of Policy (70) */
        nv_vat70   = wagtprm_fil.tax   - nv_vat72.       /* Tax of Policy (70) */
    IF nv_stamp70 < 0 THEN nv_stamp70 = 0.
    IF nv_vat70   < 0 THEN nv_vat70   = 0.

END.
ELSE DO:
    IF uwm100.cr_2 = "" THEN DO:      /* Compulsory แยก */
        FOR EACH uwm301 USE-INDEX uwm30102 WHERE
                 uwm301.vehreg                = wagtprm_fil.vehreg  AND 
                 SUBSTRING(uwm301.policy,3,2) =  "72"               NO-LOCK:    /* DM7245123456*/

            FIND FIRST uwm100 USE-INDEX uwm10001 WHERE
                       uwm100.policy = uwm301.policy AND
                       uwm100.rencnt = uwm301.rencnt AND
                       uwm100.endcnt = uwm301.endcnt NO-LOCK NO-ERROR NO-WAIT.
            IF NOT AVAILABLE uwm100 THEN NEXT.

            IF uwm100.expdat >= wagtprm_fil.comdat THEN DO:

                FIND LAST bwagtprm_fil WHERE 
                          bwagtprm_fil.policy = uwm301.policy NO-LOCK NO-WAIT NO-ERROR .
                IF NOT AVAIL bwagtprm_fil  THEN NEXT.

                FIND FIRST vehreg72 WHERE vehreg72.vehreg = uwm301.vehreg NO-ERROR NO-WAIT.
                IF NOT AVAILABLE vehreg72 THEN DO:
                    CREATE vehreg72.
                    ASSIGN  
                        vehreg72.polsta  = uwm100.polsta  /* IF ,RE ,CA */
                        vehreg72.vehreg  = uwm301.vehreg  /* Vehicle Registration No. */
                        vehreg72.comdat  = uwm100.comdat  /* Expiry Date */
                        vehreg72.expdat  = uwm100.expdat  /* Expiry Date */
                        vehreg72.enddat  = uwm100.enddat
                        vehreg72.del_veh = IF uwm301.itmdel = NO THEN "" ELSE "Y"
                        vehreg72.policy  = uwm301.policy
                        vehreg72.rencnt  = uwm301.rencnt
                        vehreg72.endcnt  = uwm301.endcnt
                        vehreg72.riskgp  = uwm301.riskgp
                        vehreg72.riskno  = uwm301.riskno
                        vehreg72.itemno  = uwm301.itemno
                        vehreg72.sticker = uwm301.sckno.
                END.
                ELSE DO:  /*มีอยู่แล้ว */
                    IF vehreg72.expdat <= uwm100.expdat THEN DO:  /*เอาค่าใหม่ ให้ */
                        ASSIGN 
                            vehreg72.polsta  = uwm100.polsta  /* IF ,RE ,CA */
                            vehreg72.vehreg  = uwm301.vehreg  /* Vehicle Registration No. */
                            vehreg72.comdat  = uwm100.comdat  /* Expiry Date */
                            vehreg72.expdat  = uwm100.expdat  /* Expiry Date */
                            vehreg72.enddat  = uwm100.enddat
                            vehreg72.del_veh = IF uwm301.itmdel = NO THEN "" ELSE "Y"
                            vehreg72.policy  = uwm301.policy
                            vehreg72.rencnt  = uwm301.rencnt
                            vehreg72.endcnt  = uwm301.endcnt
                            vehreg72.riskgp  = uwm301.riskgp
                            vehreg72.riskno  = uwm301.riskno
                            vehreg72.itemno  = uwm301.itemno.
                        /*IF uwm301.sckno <> 0 THEN
                            vehreg72.sticker = uwm301.sckno.*/
                    END.
                    ELSE DO:
                        IF vehreg72.expdat  > uwm100.expdat AND
                            vehreg72.policy = uwm100.policy AND
                            vehreg72.endcnt < uwm100.endcnt THEN DO:
                            ASSIGN 
                                vehreg72.polsta  = uwm100.polsta  /* IF ,RE ,CA */
                                vehreg72.vehreg  = uwm301.vehreg  /* Vehicle Registration No. */
                                vehreg72.comdat  = uwm100.comdat  /* Expiry Date */
                                vehreg72.expdat  = uwm100.expdat  /* Expiry Date */
                                vehreg72.enddat  = uwm100.enddat
                                vehreg72.del_veh = IF uwm301.itmdel = NO THEN "" ELSE "Y"
                                vehreg72.policy  = uwm301.policy
                                vehreg72.rencnt  = uwm301.rencnt
                                vehreg72.endcnt  = uwm301.endcnt
                                vehreg72.riskgp  = uwm301.riskgp
                                vehreg72.riskno  = uwm301.riskno
                                vehreg72.itemno  = uwm301.itemno.
                            /*IF uwm301.sckno <> 0 THEN 
                                vehreg72.sticker = uwm301.sckno.*/
                        END.
                    END.  /* else IF vehreg72.expdat <= uwm100.expdat */
                END.   /* not avail vehreg72  */
            END.    /*IF uwm100.expdat >= uwm100.comdat */
        END.     /* for eachBuwm301*/

        FIND FIRST vehreg72 NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL vehreg72 THEN DO:  /*2*/
            FIND FIRST uwm100 USE-INDEX uwm10001 WHERE
                       uwm100.policy = vehreg72.policy  AND
                       uwm100.rencnt = vehreg72.rencnt  AND
                       uwm100.endcnt = vehreg72.endcnt  NO-LOCK NO-ERROR NO-WAIT.
            IF AVAILABLE uwm100 THEN DO:

                ASSIGN  
                    nv_pol72    = uwm100.policy      /* Policy (V72) */
                    nv_comdat72 = uwm100.comdat      /* Comdat (V72) */
                    nv_expdat72 = uwm100.expdat      /* Expdat (V72) */
                    nv_comp_net = uwm100.prem_t      /* Premium of V72 */
                    nv_comp_prm = uwm100.prem_t      
                    nv_stamp72  = uwm100.rstp_t      /* Stamp of V72 */
                    nv_vat72    = uwm100.rtax_t.     /* Tax of V72 */

                FIND FIRST uwm301 USE-INDEX uwm30101 WHERE
                           uwm301.policy = uwm100.policy AND
                           uwm301.rencnt = uwm100.rencnt AND
                           uwm301.endcnt = uwm100.endcnt NO-LOCK NO-ERROR NO-WAIT.
                IF AVAIL uwm301 THEN DO:
                    FIND FIRST uwm130 USE-INDEX uwm13001 WHERE
                               uwm130.policy = uwm301.policy AND
                               uwm130.rencnt = uwm301.rencnt AND
                               uwm130.endcnt = uwm301.endcnt AND
                               uwm130.riskgp = uwm301.riskgp AND
                               uwm130.riskno = uwm301.riskno AND
                               uwm130.itemno = uwm301.itemno NO-LOCK NO-ERROR NO-WAIT.
                    IF AVAIL uwm130 THEN DO:
                        IF uwm130.uom8_v <> 0 AND uwm130.uom9_v <> 0 THEN DO:
                            IF uwm130.uom8_v = 50000 THEN nv_comp_si = 80000.
                            ELSE nv_comp_si = uwm130.uom8_v.
                        END.
                    END.

                END.
            END.
        END.
    END.   /*IF uwm100.cr_2  = ""  */
    ELSE DO:  /* uwm100.cr_2 <> "" */

        FIND LAST bwagtprm_fil WHERE 
                  bwagtprm_fil.policy = uwm100.cr_2  NO-LOCK NO-WAIT NO-ERROR.
        IF NOT AVAIL bwagtprm_fil  THEN NEXT.

        FIND FIRST uwm100 USE-INDEX uwm10001 WHERE
                   uwm100.policy = bwagtprm_fil.policy NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL uwm100 THEN DO:
            ASSIGN  
                nv_pol72    = uwm100.policy    /* Policy (V72) */
                nv_comdat72 = uwm100.comdat    /* Comdat (V72) */
                nv_expdat72 = uwm100.expdat    /* Expdat (V72) */
                nv_comp_net = uwm100.prem_t    /* Premium (V72) */
                nv_comp_prm = uwm100.prem_t
                nv_stamp72  = uwm100.rstp_t    /* Stamp (V72) */
                nv_vat72    = uwm100.rtax_t.    /* Tax (V72) */

            FIND FIRST uwm301 USE-INDEX uwm30101 WHERE
                       uwm301.policy = uwm100.policy  AND
                       uwm301.rencnt = uwm100.rencnt  AND
                       uwm301.endcnt = uwm100.endcnt  NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL  uwm301 THEN DO:
                FIND FIRST  uwm130 USE-INDEX uwm13001 WHERE
                            uwm130.policy = uwm301.policy AND
                            uwm130.rencnt = uwm301.rencnt AND
                            uwm130.endcnt = uwm301.endcnt AND
                            uwm130.riskgp = uwm301.riskgp AND
                            uwm130.riskno = uwm301.riskno AND
                            uwm130.itemno =  uwm301.itemno NO-LOCK NO-ERROR NO-WAIT.
                IF AVAIL  uwm130 THEN DO:
                    IF  uwm130.uom8_v <> 0 AND  uwm130.uom9_v <> 0 THEN DO:
                        IF  uwm130.uom8_v = 50000 THEN nv_comp_si = 80000.
                                                  ELSE nv_comp_si =  uwm130.uom8_v.
                    END.
                END.
            END.
        END.
        ELSE DO:
            FOR EACH uwm301 USE-INDEX uwm30102  WHERE
                     uwm301.vehreg = wagtprm_fil.vehreg    AND
                     SUBSTRING(uwm301.policy,3,2) = "72"   NO-LOCK:      /* DM7245123456*/

                FIND FIRST uwm100 USE-INDEX uwm10001 WHERE
                           uwm100.policy = uwm301.policy AND
                           uwm100.rencnt = uwm301.rencnt AND
                           uwm100.endcnt = uwm301.endcnt NO-LOCK NO-ERROR NO-WAIT.
                IF NOT AVAILABLE uwm100 THEN NEXT.

                IF uwm100.expdat >= wagtprm_fil.comdat THEN DO:

                    FIND LAST bwagtprm_fil WHERE bwagtprm_fil.policy = uwm301.policy NO-LOCK NO-WAIT NO-ERROR.
                    IF NOT AVAIL bwagtprm_fil  THEN NEXT.

                    FIND FIRST vehreg72 WHERE vehreg72.vehreg = uwm301.vehreg NO-ERROR NO-WAIT.
                    IF NOT AVAILABLE vehreg72 THEN DO:
                        CREATE vehreg72.
                        ASSIGN  vehreg72.polsta  = uwm100.polsta  /* IF ,RE ,CA */
                                vehreg72.vehreg  = uwm301.vehreg       /* Vehicle Registration No. */
                                vehreg72.comdat  = uwm100.comdat      /* Expiry Date */
                                vehreg72.expdat  = uwm100.expdat      /* Expiry Date */
                                vehreg72.enddat  = uwm100.enddat
                                vehreg72.del_veh = IF uwm301.itmdel = NO THEN "" ELSE "Y"
                                vehreg72.policy  = uwm301.policy
                                vehreg72.rencnt  = uwm301.rencnt
                                vehreg72.endcnt  = uwm301.endcnt
                                vehreg72.riskgp  = uwm301.riskgp
                                vehreg72.riskno  = uwm301.riskno
                                vehreg72.itemno  = uwm301.itemno
                                vehreg72.sticker = uwm301.sckno.
                    END.
                    ELSE DO:
                        IF vehreg72.expdat <= uwm100.expdat THEN DO:
                            ASSIGN  vehreg72.polsta  = uwm100.polsta  /* IF ,RE ,CA */
                                vehreg72.vehreg  = uwm301.vehreg       /* Vehicle Registration No. */
                                vehreg72.comdat  = uwm100.comdat      /* Expiry Date */
                                vehreg72.expdat  = uwm100.expdat      /* Expiry Date */
                                vehreg72.enddat  = uwm100.enddat
                                vehreg72.del_veh = IF uwm301.itmdel = NO THEN "" ELSE "Y"
                                vehreg72.policy  = uwm301.policy
                                vehreg72.rencnt  = uwm301.rencnt
                                vehreg72.endcnt  = uwm301.endcnt
                                vehreg72.riskgp  = uwm301.riskgp
                                vehreg72.riskno  = uwm301.riskno
                                vehreg72.itemno  = uwm301.itemno.
                            IF uwm301.sckno <> 0 THEN
                                vehreg72.sticker = uwm301.sckno.
                        END.
                        ELSE DO:
                            IF vehreg72.expdat > uwm100.expdat AND
                               vehreg72.policy = uwm100.policy AND
                               vehreg72.endcnt < uwm100.endcnt THEN DO:
                                ASSIGN  
                                    vehreg72.polsta  = uwm100.polsta  /* IF ,RE ,CA */
                                    vehreg72.vehreg  = uwm301.vehreg  /* Vehicle Registration No. */
                                    vehreg72.comdat  = uwm100.comdat  /* Expiry Date */
                                    vehreg72.expdat  = uwm100.expdat  /* Expiry Date */
                                    vehreg72.enddat  = uwm100.enddat
                                    vehreg72.del_veh = IF uwm301.itmdel = NO THEN "" ELSE "Y"
                                    vehreg72.policy  = uwm301.policy
                                    vehreg72.rencnt  = uwm301.rencnt
                                    vehreg72.endcnt  = uwm301.endcnt
                                    vehreg72.riskgp  = uwm301.riskgp
                                    vehreg72.riskno  = uwm301.riskno
                                    vehreg72.itemno  = uwm301.itemno.
                                IF uwm301.sckno <> 0 THEN  vehreg72.sticker =uwm301.sckno.
                            END.
                        END.  /* else IF vehreg72.expdat <= uwm100.expdat */
                    END.  /* not avail vehreg72  */
                END.  /*IF uwm100.expdat >= uwm100.comdat */
            END.   /* for eachBuwm301*/
        
            FIND FIRST vehreg72 NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL vehreg72 THEN DO:    /*2*/   
                FIND FIRST uwm100 WHERE
                           uwm100.policy = vehreg72.policy AND
                           uwm100.rencnt = vehreg72.rencnt AND
                           uwm100.endcnt = vehreg72.endcnt NO-LOCK NO-ERROR NO-WAIT.
                IF AVAILABLE uwm100 THEN DO:
                    ASSIGN  
                        nv_pol72    = uwm100.policy   /* Policy (V72) */
                        nv_comdat72 = uwm100.comdat   /* Comdat (V72) */
                        nv_expdat72 = uwm100.expdat   /* Expdat (V72) */
                        nv_comp_net = uwm100.prem_t   /* Premium (V72) */
                        nv_comp_prm = uwm100.prem_t
                        nv_stamp72  = uwm100.rstp_t   /* Stamp (V72) */
                        nv_vat72    = uwm100.rtax_t.  /* Tax (V72) */
                    FIND FIRST uwm301 WHERE
                               uwm301.policy = uwm100.policy AND
                               uwm301.rencnt = uwm100.rencnt AND
                               uwm301.endcnt = uwm100.endcnt NO-LOCK NO-ERROR NO-WAIT.
                    IF AVAILABLE uwm301 THEN DO:
                        FIND FIRST uwm130 WHERE
                                   uwm130.policy = uwm301.policy AND
                                   uwm130.rencnt = uwm301.rencnt AND
                                   uwm130.endcnt = uwm301.endcnt AND
                                   uwm130.riskgp = uwm301.riskgp AND
                                   uwm130.riskno = uwm301.riskno AND
                                   uwm130.itemno = uwm301.itemno NO-LOCK NO-ERROR NO-WAIT.
                        IF AVAILABLE uwm130 THEN DO:
                            IF uwm130.uom8_v <> 0 AND uwm130.uom9_v <> 0 THEN DO:
                                IF uwm130.uom8_v = 50000 THEN nv_comp_si = 80000.
                                                         ELSE nv_comp_si = uwm130.uom8_v.
                            END.
                        END.
                    END.
                END.   /* IF AVAILABLE uwm100 */
            END.
        END. 
    END.  /* uwm100.opnpol <> "" */
END. 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdnopol7272 C-Win 
PROCEDURE pdnopol7272 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*crate by kridtiya i. A53-0241 เพิ่มกรณีงาน พรบ. รายเดียว ไม่พ่วง กรมธรรม์ภาคสมัครใจ*/

FIND FIRST uwm120 USE-INDEX uwm12001  WHERE
    uwm120.policy = uwm100.policy     AND
    uwm120.rencnt = uwm100.rencnt     AND
    uwm120.endcnt = uwm100.endcnt     NO-LOCK NO-ERROR NO-WAIT.
IF NOT AVAILABLE uwm120 THEN NEXT.
ELSE n_class = uwm120.CLASS.

FIND FIRST uwm301 USE-INDEX uwm30101  WHERE
    uwm301.policy = uwm100.policy     AND
    uwm301.rencnt = uwm100.rencnt     AND
    uwm301.endcnt = uwm100.endcnt     NO-LOCK NO-ERROR NO-WAIT.
IF NOT AVAILABLE uwm301 THEN NEXT.

ASSIGN n_cha_no =  uwm301.cha_no
       n_eng_no =  uwm301.eng_no  
       n_vehreg =  uwm301.vehreg 
       n_ben83  =  SUBSTRING(uwm301.mv_ben83,1,50)
       n_covcod =  uwm301.covcod .

FIND xmm020 USE-INDEX xmm02001        WHERE
    xmm020.branch = uwm100.branch     AND
    xmm020.dir_ri = uwm100.dir_ri     NO-LOCK NO-ERROR NO-WAIT.
IF AVAILABLE xmm020 THEN
    ASSIGN  
        nv_stamp_per  = xmm020.rvstam
        nv_tax_per    = xmm020.rvtax.

FIND FIRST uwm130 USE-INDEX uwm13001  WHERE
    uwm130.policy = uwm301.policy     AND
    uwm130.rencnt = uwm301.rencnt     AND
    uwm130.endcnt = uwm301.endcnt     AND
    uwm130.riskgp = uwm301.riskgp     AND
    uwm130.riskno = uwm301.riskno     AND
    uwm130.itemno = uwm301.itemno     NO-LOCK NO-ERROR NO-WAIT.
IF NOT AVAILABLE uwm130 THEN NEXT.
ELSE DO:
    n_fithef  = uwm130.uom7_v.
    nv_nor_si = uwm130.uom6_v.
END.


FIND FIRST uwm100 USE-INDEX uwm10001 WHERE
    uwm100.policy = wagtprm_fil.policy NO-LOCK NO-ERROR NO-WAIT.
IF AVAIL uwm100 THEN DO:   
     FIND LAST bwagtprm_fil WHERE bwagtprm_fil.policy = uwm100.policy NO-LOCK NO-WAIT NO-ERROR.
     IF NOT AVAIL bwagtprm_fil  THEN NEXT.
 
     ASSIGN  
         nv_pol72    = uwm100.cr_2 /*uwm100.policy*/       /* Policy (V72) */
         nv_comdat72 = uwm100.comdat       /* Comdat (V72) */
         nv_expdat72 = uwm100.expdat       /* Expdat (V72) */
         nv_comp_net = uwm100.prem_t       /* Premium (V72) */
         nv_comp_prm = uwm100.prem_t
         nv_stamp72  = uwm100.rstp_t       /* Stamp (V72) */
         nv_vat72    = uwm100.rtax_t.      /* Tax (V72) */
 
     FIND FIRST uwm301 USE-INDEX uwm30101 WHERE
         uwm301.policy = uwm100.policy AND
         uwm301.rencnt = uwm100.rencnt AND
         uwm301.endcnt = uwm100.endcnt NO-LOCK NO-ERROR NO-WAIT.
     IF AVAIL uwm301 THEN DO:
         FIND FIRST uwm130 USE-INDEX uwm13001 WHERE
            uwm130.policy = uwm301.policy AND
            uwm130.rencnt = uwm301.rencnt AND
            uwm130.endcnt = uwm301.endcnt AND
            uwm130.riskgp = uwm301.riskgp AND
            uwm130.riskno = uwm301.riskno AND
            uwm130.itemno = uwm301.itemno NO-LOCK NO-ERROR NO-WAIT.
         IF AVAIL uwm130 THEN DO:
             IF uwm130.uom8_v <> 0 AND uwm130.uom9_v <> 0 THEN DO:
                 IF uwm130.uom8_v = 50000 THEN nv_comp_si = 80000.
                 ELSE nv_comp_si = uwm130.uom8_v.
             END.
         END.
     END.
END.
/*nv_pol72*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdnopol72_proc C-Win 
PROCEDURE pdnopol72_proc :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*DEF VAR n_append  AS CHAR INIT "" .
FIND FIRST uwm120 USE-INDEX uwm12001 WHERE
    uwm120.policy = uwm100.policy AND
    uwm120.rencnt = uwm100.rencnt AND
    uwm120.endcnt = uwm100.endcnt
    NO-LOCK NO-ERROR NO-WAIT.
IF NOT AVAILABLE uwm120 THEN NEXT.

FIND FIRST uwm301 USE-INDEX uwm30101 WHERE
    uwm301.policy = uwm100.policy AND
    uwm301.rencnt = uwm100.rencnt AND
    uwm301.endcnt = uwm100.endcnt
    NO-LOCK NO-ERROR NO-WAIT.
IF NOT AVAILABLE uwm301 THEN NEXT.

ASSIGN n_cha_no =  uwm301.cha_no
    n_eng_no =  uwm301.eng_no  
    n_vehreg =  uwm301.vehreg  .

FIND FIRST uwm130 USE-INDEX uwm13001 WHERE
    uwm130.policy = uwm301.policy AND
    uwm130.rencnt = uwm301.rencnt AND
    uwm130.endcnt = uwm301.endcnt AND
    uwm130.riskgp = uwm301.riskgp AND
    uwm130.riskno = uwm301.riskno AND
    uwm130.itemno = uwm301.itemno
    NO-LOCK NO-ERROR NO-WAIT.
IF NOT AVAILABLE uwm130 THEN NEXT.

FIND xmm020 USE-INDEX xmm02001 WHERE
    xmm020.branch = uwm100.branch AND
    xmm020.dir_ri = uwm100.dir_ri
    NO-LOCK NO-ERROR NO-WAIT.
IF AVAILABLE xmm020 THEN
    ASSIGN 
        nv_stamp_per  = xmm020.rvstam
        nv_tax_per    = xmm020.rvtax.

nv_nor_si = uwm130.uom6_v.

FOR EACH vehreg72:   
    DELETE  vehreg72.   
END.

IF uwm130.uom8_v <> 0 AND uwm130.uom9_v <> 0 THEN DO:
    ASSIGN nv_pol72 = ''
        nv_pol72    = uwm130.policy    
        nv_comdat72 = agtprm_fil.comdat
        nv_expdat72 = uwm100.expdat .
    IF uwm130.uom8_v = 50000 THEN nv_comp_si = 80000.
    ELSE nv_comp_si = uwm130.uom8_v.
    nv_comp_net = agtprm_fil.prem_comp.
    nv_comp_prm = nv_comp_net.
    nv_stamp72  = TRUNCATE(nv_comp_net * nv_stamp_per / 100,0) +
                  (IF (nv_comp_net * nv_stamp_per / 100) -
                  TRUNCATE(nv_comp_net * nv_stamp_per / 100,0) > 0
                  THEN 1 ELSE 0).
    IF uwm100.gstrat <> 0 AND agtprm_fil.tax <> 0 THEN
        nv_vat72 = (nv_comp_net + nv_stamp72) * uwm100.gstrat / 100.
    nv_stamp70 = agtprm_fil.stamp - nv_stamp72.     /* Stamp of Policy (70) */
    nv_vat70   = agtprm_fil.tax   - nv_vat72.       /* Tax of Policy (70) */
    IF nv_stamp70 < 0 THEN nv_stamp70 = 0.
    IF nv_vat70   < 0 THEN nv_vat70   = 0.
END.
ELSE DO:
    IF n_append = "" THEN DO:   
        FOR EACH uwm301 USE-INDEX uwm30102 WHERE
            uwm301.vehreg = agtprm_fil.vehreg
            NO-LOCK:
            IF SUBSTRING(uwm301.policy,3,2) = "72" THEN DO:
                FIND FIRST uwm100 USE-INDEX uwm10001 WHERE
                           uwm100.policy = uwm301.policy AND
                           uwm100.rencnt = uwm301.rencnt AND
                           uwm100.endcnt = uwm301.endcnt
                NO-LOCK NO-ERROR NO-WAIT.
                IF NOT AVAILABLE uwm100 THEN NEXT.
                IF uwm100.expdat >= agtprm_fil.comdat THEN DO:
                    FIND FIRST vehreg72 WHERE
                               vehreg72.vehreg = uwm301.vehreg
                    NO-ERROR NO-WAIT.
                    IF NOT AVAILABLE vehreg72 THEN DO:
                        CREATE vehreg72.
                        ASSIGN 
                            vehreg72.polsta  = uwm100.polsta  /* IF ,RE ,CA */
                            vehreg72.vehreg  = uwm301.vehreg   /* Vehicle Registration No. */
                            vehreg72.comdat  = uwm100.comdat  /* Expiry Date */
                            vehreg72.expdat  = uwm100.expdat  /* Expiry Date */
                            vehreg72.enddat  = uwm100.enddat
                            vehreg72.del_veh = IF uwm301.itmdel = NO THEN "" ELSE "Y"
                            vehreg72.policy  = uwm301.policy
                            vehreg72.rencnt  = uwm301.rencnt
                            vehreg72.endcnt  = uwm301.endcnt
                            vehreg72.riskgp  = uwm301.riskgp
                            vehreg72.riskno  = uwm301.riskno
                            vehreg72.itemno  = uwm301.itemno
                            vehreg72.sticker = uwm301.sckno.
                    END.
                    ELSE DO:
                        IF vehreg72.expdat <= uwm100.expdat THEN DO:
                            ASSIGN
                                vehreg72.polsta  = uwm100.polsta  /* IF ,RE ,CA */
                                vehreg72.vehreg  = uwm301.vehreg  /* Vehicle Registration No. */
                                vehreg72.comdat  = uwm100.comdat  /* Expiry Date */
                                vehreg72.expdat  = uwm100.expdat  /* Expiry Date */
                                vehreg72.enddat  = uwm100.enddat
                                vehreg72.del_veh = IF uwm301.itmdel = NO THEN "" ELSE "Y"
                                vehreg72.policy  = uwm301.policy
                                vehreg72.rencnt  = uwm301.rencnt
                                vehreg72.endcnt  = uwm301.endcnt
                                vehreg72.riskgp  = uwm301.riskgp
                                vehreg72.riskno  = uwm301.riskno
                                vehreg72.itemno  = uwm301.itemno.
                            IF uwm301.sckno <> 0 THEN
                                vehreg72.sticker = uwm301.sckno.
                        END.
                        ELSE DO:
                            IF vehreg72.expdat > uwm100.expdat AND
                               vehreg72.policy = uwm100.policy AND
                               vehreg72.endcnt < uwm100.endcnt
                            THEN DO:
                                ASSIGN
                                    vehreg72.polsta  = uwm100.polsta  /* IF ,RE ,CA */
                                    vehreg72.vehreg  = uwm301.vehreg  /* Vehicle Registration No. */
                                    vehreg72.comdat  = uwm100.comdat  /* Expiry Date */
                                    vehreg72.expdat  = uwm100.expdat  /* Expiry Date */
                                    vehreg72.enddat  = uwm100.enddat
                                    vehreg72.del_veh = IF uwm301.itmdel = NO THEN "" ELSE "Y"
                                    vehreg72.policy  = uwm301.policy
                                    vehreg72.rencnt  = uwm301.rencnt
                                    vehreg72.endcnt  = uwm301.endcnt
                                    vehreg72.riskgp  = uwm301.riskgp
                                    vehreg72.riskno  = uwm301.riskno
                                    vehreg72.itemno  = uwm301.itemno.

                                IF uwm301.sckno <> 0 THEN
                                    vehreg72.sticker = uwm301.sckno.
                            END.
                        END. /* else IF vehreg72.expdat <= Buwm_v72.expdat */
                    END.  /* not avail vehreg72  */
                END.  /*IF Buwm_v72.expdat >= uwm100.comdat */
            END. /* IF SUBSTRING(Buwm301.policy,3,2) = "72" */
        END. /* for eachBuwm301*/
        FIND FIRST vehreg72 NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL vehreg72 THEN DO: 
            FIND FIRST uwm100 USE-INDEX uwm10001 WHERE
                       uwm100.policy = vehreg72.policy AND
                       uwm100.rencnt = vehreg72.rencnt AND
                       uwm100.endcnt = vehreg72.endcnt
            NO-LOCK NO-ERROR NO-WAIT.
            IF AVAILABLE uwm100 THEN DO:
                ASSIGN
                    nv_pol72    = uwm100.policy   /* Policy (V72) */
                    nv_comdat72 = uwm100.comdat   /* Comdat (V72) */
                    nv_expdat72 = uwm100.expdat   /* Expdat (V72) */
                    nv_comp_net = uwm100.prem_t   /* Premium of V72 */
                    nv_comp_prm = uwm100.prem_t
                    nv_stamp72  = uwm100.rstp_t   /* Stamp of V72 */
                    nv_vat72    = uwm100.rtax_t.  /* Tax of V72 */
                FIND FIRST uwm301 USE-INDEX uwm30101 WHERE
                           uwm301.policy = uwm100.policy AND
                           uwm301.rencnt = uwm100.rencnt AND
                           uwm301.endcnt = uwm100.endcnt
                NO-LOCK NO-ERROR NO-WAIT.
                IF AVAIL uwm301 THEN DO:
                    FIND FIRST uwm130 USE-INDEX uwm13001 WHERE
                               uwm130.policy = uwm301.policy AND
                               uwm130.rencnt = uwm301.rencnt AND
                               uwm130.endcnt = uwm301.endcnt AND
                               uwm130.riskgp = uwm301.riskgp AND
                               uwm130.riskno = uwm301.riskno AND
                               uwm130.itemno = uwm301.itemno
                    NO-LOCK NO-ERROR NO-WAIT.
                    IF AVAIL uwm130 THEN DO:
                        IF uwm130.uom8_v <> 0 AND uwm130.uom9_v <> 0 THEN DO:
                            IF uwm130.uom8_v = 50000 THEN nv_comp_si = 80000.
                                                      ELSE nv_comp_si = uwm130.uom8_v.
                        END.
                    END.
                END.
            END.
        END.
    END. /*IF uwm100.cr_2 = "" */
    ELSE DO:  /* uwm100.cr_2 <> "" */
        FIND FIRST uwm100 USE-INDEX uwm10001 WHERE
                   uwm100.policy = n_append
            NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL uwm100 THEN DO:
            ASSIGN
                nv_pol72    = uwm100.policy   /* Policy (V72) */
                nv_comdat72 = uwm100.comdat   /* Comdat (V72) */
                nv_expdat72 = uwm100.expdat   /* Expdat (V72) */
                nv_comp_net = uwm100.prem_t   /* Premium (V72) */
                nv_comp_prm = uwm100.prem_t
                nv_stamp72  = uwm100.rstp_t   /* Stamp (V72) */
                nv_vat72    = uwm100.rtax_t.  /* Tax (V72) */
            FIND FIRST uwm301 USE-INDEX uwm30101 WHERE
                       uwm301.policy = uwm100.policy AND
                       uwm301.rencnt = uwm100.rencnt AND
                       uwm301.endcnt = uwm100.endcnt
                NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL uwm301 THEN DO:
                FIND FIRST uwm130 USE-INDEX uwm13001 WHERE
                           uwm130.policy = uwm301.policy AND
                           uwm130.rencnt = uwm301.rencnt AND
                           uwm130.endcnt = uwm301.endcnt AND
                           uwm130.riskgp = uwm301.riskgp AND
                           uwm130.riskno = uwm301.riskno AND
                           uwm130.itemno = uwm301.itemno
                NO-LOCK NO-ERROR NO-WAIT.
                IF AVAIL uwm130 THEN DO:
                    IF uwm130.uom8_v <> 0 AND uwm130.uom9_v <> 0 THEN DO:
                        IF uwm130.uom8_v = 50000 THEN nv_comp_si = 80000.
                                                  ELSE nv_comp_si = uwm130.uom8_v.
                    END.
                END.
            END.
        END.
        ELSE DO:
            FOR EACH uwm301 USE-INDEX uwm30102 WHERE
                uwm301.vehreg = agtprm_fil.vehreg
                NO-LOCK:
                /* DM7245123456*/
                IF SUBSTRING(uwm301.policy,3,2) = "72" THEN DO:
                    /* uwm100 */
                    FIND FIRST uwm100 USE-INDEX uwm10001 WHERE
                        uwm100.policy = uwm301.policy AND
                        uwm100.rencnt = uwm301.rencnt AND
                        uwm100.endcnt = uwm301.endcnt
                        NO-LOCK NO-ERROR NO-WAIT.
                    IF NOT AVAILABLE uwm100 THEN NEXT.
                    IF uwm100.expdat >= agtprm_fil.comdat THEN DO:
                        FIND FIRST vehreg72 WHERE
                            vehreg72.vehreg = uwm301.vehreg
                            NO-ERROR NO-WAIT.
                        IF NOT AVAILABLE vehreg72 THEN DO:
                            CREATE vehreg72.
                            ASSIGN
                                vehreg72.polsta  = uwm100.polsta  /* IF ,RE ,CA */
                                vehreg72.vehreg  = uwm301.vehreg   /* Vehicle Registration No. */
                                vehreg72.comdat  = uwm100.comdat  /* Expiry Date */
                                vehreg72.expdat  = uwm100.expdat  /* Expiry Date */
                                vehreg72.enddat  = uwm100.enddat
                                vehreg72.del_veh = IF uwm301.itmdel = NO THEN "" ELSE "Y"
                                vehreg72.policy  = uwm301.policy
                                vehreg72.rencnt  = uwm301.rencnt
                                vehreg72.endcnt  = uwm301.endcnt
                                vehreg72.riskgp  = uwm301.riskgp
                                vehreg72.riskno  = uwm301.riskno
                                vehreg72.itemno  = uwm301.itemno
                                vehreg72.sticker = uwm301.sckno.
                        END.
                        ELSE DO:
                            IF vehreg72.expdat <= uwm100.expdat THEN DO:
                                ASSIGN
                                    vehreg72.polsta  = uwm100.polsta  /* IF ,RE ,CA */
                                    vehreg72.vehreg  = uwm301.vehreg   /* Vehicle Registration No. */
                                    vehreg72.comdat  = uwm100.comdat  /* Expiry Date */
                                    vehreg72.expdat  = uwm100.expdat  /* Expiry Date */
                                    vehreg72.enddat  = uwm100.enddat
                                    vehreg72.del_veh = IF uwm301.itmdel = NO THEN "" ELSE "Y"
                                    vehreg72.policy  = uwm301.policy
                                    vehreg72.rencnt  = uwm301.rencnt
                                    vehreg72.endcnt  = uwm301.endcnt
                                    vehreg72.riskgp  = uwm301.riskgp
                                    vehreg72.riskno  = uwm301.riskno
                                    vehreg72.itemno  = uwm301.itemno.
                                IF uwm301.sckno <> 0 THEN
                                    vehreg72.sticker = uwm301.sckno.
                            END.
                            ELSE DO:
                                IF vehreg72.expdat > uwm100.expdat AND
                                   vehreg72.policy = uwm100.policy AND
                                   vehreg72.endcnt < uwm100.endcnt
                                THEN DO:
                                    ASSIGN
                                        vehreg72.polsta  = uwm100.polsta  /* IF ,RE ,CA */
                                        vehreg72.vehreg  = uwm301.vehreg   /* Vehicle Registration No. */
                                        vehreg72.comdat  = uwm100.comdat  /* Expiry Date */
                                        vehreg72.expdat  = uwm100.expdat  /* Expiry Date */
                                        vehreg72.enddat  = uwm100.enddat
                                        vehreg72.del_veh = IF uwm301.itmdel = NO THEN "" ELSE "Y"
                                        vehreg72.policy  = uwm301.policy
                                        vehreg72.rencnt  = uwm301.rencnt
                                        vehreg72.endcnt  = uwm301.endcnt
                                        vehreg72.riskgp  = uwm301.riskgp
                                        vehreg72.riskno  = uwm301.riskno
                                        vehreg72.itemno  = uwm301.itemno.
                                    IF uwm301.sckno <> 0 THEN
                                        vehreg72.sticker = uwm301.sckno.
                                END.
                            END. /* else IF vehreg72.expdat <= Buwm_v72.expdat */
                        END.  /* not avail vehreg72  */
                    END.  /*IF Buwm_v72.expdat >= uwm100.comdat */
                END. /* IF SUBSTRING(Buwm301.policy,3,2) = "72" */
            END. /* for eachBuwm301*/
            FIND FIRST vehreg72 NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL vehreg72 THEN DO:   
                FIND FIRST uwm100 WHERE
                           uwm100.policy = vehreg72.policy AND
                           uwm100.rencnt = vehreg72.rencnt AND
                           uwm100.endcnt = vehreg72.endcnt
                NO-LOCK NO-ERROR NO-WAIT.
                IF AVAILABLE uwm100 THEN DO:
                    ASSIGN
                        nv_pol72    = uwm100.policy   /* Policy (V72) */
                        nv_comdat72 = uwm100.comdat   /* Comdat (V72) */
                        nv_expdat72 = uwm100.expdat   /* Expdat (V72) */
                        nv_comp_net = uwm100.prem_t   /* Premium (V72) */
                        nv_comp_prm = uwm100.prem_t
                        nv_stamp72  = uwm100.rstp_t   /* Stamp (V72) */
                        nv_vat72    = uwm100.rtax_t.  /* Tax (V72) */
                    FIND FIRST uwm301 WHERE
                               uwm301.policy = uwm100.policy AND
                               uwm301.rencnt = uwm100.rencnt AND
                               uwm301.endcnt = uwm100.endcnt
                    NO-LOCK NO-ERROR NO-WAIT.
                    IF AVAILABLE uwm301 THEN DO:
                        FIND FIRST uwm130 WHERE
                                   uwm130.policy = uwm301.policy AND
                                   uwm130.rencnt = uwm301.rencnt AND
                                   uwm130.endcnt = uwm301.endcnt AND
                                   uwm130.riskgp = uwm301.riskgp AND
                                   uwm130.riskno = uwm301.riskno AND
                                   uwm130.itemno = uwm301.itemno
                        NO-LOCK NO-ERROR NO-WAIT.
                        IF AVAILABLE uwm130 THEN DO:
                            IF uwm130.uom8_v <> 0 AND uwm130.uom9_v <> 0 THEN DO:
                                IF uwm130.uom8_v = 50000 THEN nv_comp_si = 80000.
                                                          ELSE nv_comp_si = uwm130.uom8_v.
                            END.
                        END.
                    END.
                END.  /* IF AVAILABLE Buwm_v72 */
            END.
        END.
    END. /* uwm100.opnpol <> "" */
END.  /* not (uwm130.uom8_v <> 0 AND uwm130.uom9_v <> 0) */*/
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
/*
    /*----------------------------- export to file *** since 01/12/01 file comp ***---------------------------*/
    DEF BUFFER bufwBill FOR wBill.                           /*kridtiya i. A53-0241 */
    DEF VAR n_wRecordno     AS INTE FORMAT "999999" INIT 0.  /*kridtiya i. A53-0241 */
    OUTPUT STREAM filebill1 TO VALUE(fiFile-Name1).

    ASSIGN
        vExpCount1 = 0
        nv_sumprem = 0
        nv_sumcomp = 0
        n_binloop  = ""
        n_bindate  = ""
        n_binloop  = STRING(fi_binloop,"99")
        n_bindate  = STRING(fi_bindate,"99/99/9999").

    /* Detail File Export */
    loop1:
    FOR EACH wBill USE-INDEX wBill02 NO-LOCK
        BREAK BY wBill.wRecordno:
        /*kridtiya i. A53-0241 */
        IF wBill.wnorpol = "" THEN DO:
            FIND FIRST bufwBill WHERE 
                bufwBill.wpol72 = wBill.wpol72  AND 
                bufwBill.wnorpol  <> ""  NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL bufwBill  THEN NEXT loop1.

        END.
        /*kridtiya i. A53-0241 */
        DISPLAY  "Export Data : " + STRING(wBill.wRecordno,">>>>>9") + '  ' + wBill.wpolicy
                           + '  ' + wBill.wtrnty1 + '-' + wBill.wdocno @ fi_Process WITH FRAME {&FRAME-NAME}.
        ASSIGN
            n_wRecordno = n_wRecordno + 1
            vExpCount1 = vExpCount1 + 1
            nv_sumprem = nv_sumprem + wBill.wNetPrem
            nv_sumcomp = nv_sumcomp + wBill.wCompNetPrem .

        PUT STREAM filebill1
            "SAFE"                                  FORMAT "XXXX"       /*  1.   1 -   4 */
            n_binloop                               FORMAT "99"         /*  2.   5 -   6 */
            fuDateToChar(fi_bindate)                FORMAT "99999999"   /*  3.   7 -  14 */
            /*wBill.wRecordno                         FORMAT "999999"     /*  4.  15 -  20 */*//*kridtiya i. A53-0241 */
            n_wRecordno                             FORMAT "999999"                            /*kridtiya i. A53-0241 */
            wBill.wjob_nr                           FORMAT "X"          /*  5.  21 -  21 */
            wBill.wnorpol                           FORMAT "X(25)"      /*  6.  22 -  46 */
            wBill.wpol72                            FORMAT "X(25)"      /*  7.  47 -  71 */
            wBill.winsure                           FORMAT "X(60)"      /*  8.  72 - 131 */
            wBill.wcha_no                           FORMAT "X(20)"      /*  9. 132 - 151 */
            wBill.wengine                           FORMAT "X(20)"      /* 10. 152 - 171 */
            fuDateToChar(wBill.wnor_comdat)         FORMAT "99999999"   /* 11. 172 - 179 */
            fuDateToChar(wBill.wnor_expdat)         FORMAT "99999999"   /* 12. 180 - 187 */

            fuDeciToChar(wBill.wnor_covamt,10)      FORMAT "X(10)"      /* 13. 188 - 197  "9999999999" SI*/
            fuDeciToChar(wBill.wcomp_covamt,10)     FORMAT "X(10)"      /* 14. 198 - 207  "9999999999" CompSI*/
            fuDeciToChar(wBill.wNetPrem,10)         FORMAT "X(10)"      /* 15. 208 - 217  "9999999999" NP*/
            fuDeciToChar(wBill.wCompNetPrem,10)     FORMAT "X(10)"      /* 16. 218 - 227  "9999999999" compNP*/
            fuDeciToChar(wBill.wgrossprem,10)       FORMAT "X(10)"      /* 17. 228 - 237  "9999999999" GP*/
            fuDeciToChar(wBill.wCompGrossPrem,10)   FORMAT "X(10)"      /* 18. 238 - 247  "9999999999" compGP*/
            fuDeciToChar(wBill.wtotal_prm,10)       FORMAT "X(10)"      /* 19. 248 - 257  "9999999999" TotalPrem*/
            fuDeciToChar(wBill.wnor_comm,10)        FORMAT "X(10)"      /* 20. 258 - 267  "9999999999" Comm.*/
            fuDeciToChar(wBill.wcomp_comm,10)       FORMAT "X(10)"      /* 21. 268 - 277  "9999999999" CompComm.*/
            fuDeciToChar(wBill.wnor_vat,10)         FORMAT "X(10)"      /* 22. 278 - 287  "9999999999" Vat*/
            fuDeciToChar(wBill.wcomp_vat,10)        FORMAT "X(10)"      /* 23. 288 - 297  "9999999999" CompVat*/
            fuDeciToChar(wBill.wnor_tax3,10)        FORMAT "X(10)"      /* 24. 298 - 307  "9999999999" Tax3%*/
            fuDeciToChar(wBill.wcomp_tax3,10)       FORMAT "X(10)"      /* 25. 308 - 317  "9999999999" CompTax3%*/
            fuDeciToChar(wBill.wNetPayment,10)      FORMAT "X(10)"      /* 26. 318 - 327  "9999999999" NetAmount*/
            wBill.wsubins                           FORMAT "XXXX"       /* 27. 328 - 331 */
            wBill.wcomp_sub                         FORMAT "XXXX"       /* 28. 332 - 335 */
            fuDateToChar(wBill.wcomp_comdat)        FORMAT "99999999"   /* 29. 336 - 343  "99999999" Start Comp Coverage Date*/
            fuDateToChar(wBill.wcomp_expdat)        FORMAT "99999999"   /* 30. 344 - 351  "99999999" Start Comp Coverage Date*/
            wBill.wremark                           FORMAT "X(49)"      /* 31. 352 - 400 */
            SKIP.

    END.  /* for each wbill */

    nv_sum = nv_sumprem + nv_sumcomp.

    OUTPUT STREAM filebill1 CLOSE.

    nv_sumfile = fiFile-Name1 + "SUM.TXT".
    vBackUp    = fiFile-Name1 + "B".

    DOS SILENT COPY VALUE(fiFile-Name1) VALUE(vBackUP) /Y. /* backup file exports */

    /* Summary File Export */
    OUTPUT STREAM filebill2 TO VALUE(nv_sumfile).

    PUT STREAM filebill2
        SKIP(3)
        'Safety Insurance Public Company Limited'    SKIP
        '      รายละเอียดข้อมูล POLICY รอบวันการวางบิล'
        SPACE(1) n_bindate FORMAT "X(10)" SKIP(1)
        'จำนวนกรมธรรม์ = ' STRING(vExpCount1 ,">>>>>9") ' กรมธรรม์' SKIP
        'จำนวนเบี้ยสุทธิ policy = ' nv_sumprem ' บาท' SKIP
        'จำนวนเบี้ยสุทธิ compulsory = ' nv_sumcomp ' บาท' SKIP
        FILL("-",70) FORMAT "X(70)" SKIP(1)
        'จำนวนเบี้ยสุทธิรวม = ' nv_sum ' บาท' SKIP
        FILL("=",45) FORMAT "X(45)"
        SKIP.

    OUTPUT STREAM filebill2 CLOSE.
    RUN pdo3_ex.
*/
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
IF  SUBSTR(fiFile-Name1,LENGTH(fiFile-Name1) - 3,4) <>  ".SLK"  THEN
    fiFile-Name1  =  TRIM(fiFile-Name1) + ".SLK"  .


OUTPUT TO VALUE(fiFile-Name1).

EXPORT DELIMITER "|"                                                 
   
 " Record No.    "   
 " Leasing No.   "            
 " Customer      "               
 " Policy        "          
 " Compulsory    "      
 " Endorse No.   "   
 " Cover Type    "          
 " Sum Insure    "           
 " FI & THEFT    "      
 " Com. Date     "      
 " Exp. Date     "            
 " Net Prem.     "           
 " Total Prem.   "         
 " CompNetPrem   "          
 " CompGrossPrem "    
 " Class         "                
 " Vehicle Reg.  "       
 " Chassis No.   "            
 " Benefitname   "        
 " Campaign Pol./PROM   "  
 " Invoice No.   "        
 " Trans.Date.   "      
 " Com. Date 72  "           
 " Exp. Date 72  "          SKIP.
                                               
FOR EACH wBill USE-INDEX wBill02 NO-LOCK.
    nv_cnt  =  nv_cnt  + 1.                     
    nv_row  =  nv_row + 1.   
    /*PUT STREAM ns2 */
    EXPORT DELIMITER "|"
     wBill.wRecordno       
     wBill.wCedPol         
     wBill.wInsure         
     wBill.wPolicy         
     wBill.wPol72          
     wBill.wEndno          
     wBill.wCovtyp            
     wBill.wnor_covamt     
     wBill.wFIThef         
     wBill.wNor_Comdat     
     wBill.wNor_Expdat     
     wBill.wNetPrem        
     wBill.wTotal_prm      
     wBill.wCompNetPrem    
     wBill.wCompGrossPrem  
     wBill.wClass          
     wBill.wVehreg         
     wBill.wCha_no         
     wBill.wBenname        
     wBill.wCampPol           
     wBill.wInvoice         
     wBill.wTransDate      
     wBill.wComdat72       
     wBill.wExpdat72       SKIP.
END.

OUTPUT CLOSE.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdo3_ex_back C-Win 
PROCEDURE pdo3_ex_back :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*IF  SUBSTR(fiFile-Name1,LENGTH(fiFile-Name1) - 3,4) <>  ".CSV"  THEN
    fiFile-Name1  =  TRIM(fiFile-Name1) + ".CSV"  .


OUTPUT STREAM ns2 TO VALUE(fiFile-Name1).

PUT STREAM ns2 "ID;PND" SKIP.

nv_row  =  nv_row + 1.                                                  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"' " Record No.           "     '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"' " Leasing No. "              '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"' " Customer "                 '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"  '"' " Policy        "            '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"' " Compulsory        "        '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"  '"' " Endorse Count        "     '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"  '"' " Cover Type    "            '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"  '"' " Sum Insure   "             '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"  '"' " FI & THEFT        "        '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K" '"' " Com. Date         "        '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K" '"' " Exp. Date   "              '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K" '"' " Net Prem.    "             '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K" '"' " Total Prem.    "           '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K" '"' " CompNetPrem   "            '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K" '"' " CompGrossPrem       "      '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K" '"' " Class   "                  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K" '"' " Vehicle Reg.     "         '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K" '"' " Chassis No. "              '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K" '"' " Benefitname     "          '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K" '"' " Campaign Pol./PROM      "  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K" '"' " Invoice No.     "          '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K" '"' " Trans.Date.       "        '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K" '"' " Com. Date 72         "     '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K" '"' " Exp. Date 72  "            '"' SKIP.
                                               
FOR EACH wBill USE-INDEX wBill02 NO-LOCK.
    nv_cnt  =  nv_cnt  + 1.                     
    nv_row  =  nv_row + 1.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"       wBill.wRecordno          SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"       wBill.wCedPol            SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"       wBill.wInsure            SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"       wBill.wPolicy            SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"       wBill.wPol72             SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"       wBill.wEndCnt            SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"       wBill.wCovtyp            SKIP.       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"       wBill.wnor_covamt        SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"       wBill.wFIThef            SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K"      wBill.wNor_Comdat        SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K"      wBill.wNor_Expdat        SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K"      wBill.wNetPrem           SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K"      wBill.wTotal_prm         SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K"      wBill.wCompNetPrem       SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K"      wBill.wCompGrossPrem     SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K"      wBill.wClass             SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K"      wBill.wVehreg            SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K"      wBill.wCha_no            SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K"      wBill.wBenname           SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K"      wBill.wCampPol           SKIP.       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K"  '"' wBill.wInvoice       '"' SKIP.       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K"      wBill.wTransDate         SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K"      wBill.wComdat72          SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K"      wBill.wExpdat72          SKIP.
    
END.
PUT STREAM  ns2  "E"  SKIP.
OUTPUT STREAM ns2 CLOSE.*/
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
/*/*Include File => create record  to table wBill TLT-----------*/
/*p----------------------------------------*/

FIND LAST  AcProc_fil USE-INDEX by_type_asdat WHERE
           AcProc_fil.type  = "09"      AND
           AcProc_fil.asdat = n_asdat   NO-ERROR.  /* n_asdat */
IF NOT AVAIL AcProc_fil THEN
    CREATE AcProc_fil.

ASSIGN AcProc_fil.type     = "09"
       AcProc_fil.typdesc  = "PROCESS STATEMENT BILLING(TLT)"
       AcProc_fil.asdat    = n_asdat        /* วันที่ process statement */
       AcProc_fil.trndatfr = n_comdatF      /* depend on condition on interface */
       AcProc_fil.trndatto = n_comdatT
       AcProc_fil.entdat   = TODAY          /* วันที่ export textfile */
       AcProc_fil.enttim   = STRING(TIME, "HH:MM:SS")   /* เวลา export textfile */
       AcProc_fil.usrid    = n_user .
/*--------------------------------------p*/

FOR EACH wBill:     DELETE wBill.   END.

ASSIGN
    nv_poltyp70  = "SSV70"  /* Special Service Rate of V70 */
    nv_poltyp72  = "SSV72"  /* Special Service Rate of V72 */
    vCountRec    = 0 .
    
   LOOP_MAIN:
    FOR EACH  Agtprm_fil USE-INDEX by_acno            WHERE
              Agtprm_fil.asdat       =  n_asdat       AND
             /* Agtprm_fil.acno        =  wfAcno.wacno  AND*/ /*kridtiya i. A53-0394...*/
              LOOKUP(Agtprm_fil.acno,vProdCod) <> 0   AND     /*kridtiya i. A53-0394...*/
              Agtprm_fil.poltyp      =  "V70"         AND
             (Agtprm_fil.TYPE        =  "01"          OR
              Agtprm_fil.TYPE        =  "05")         AND
              Agtprm_fil.trntyp   BEGINS 'M'          AND
             (Agtprm_fil.polbran    >=  n_branch      AND
              Agtprm_fil.polbran    <=  n_branch2)    AND
     /*p*/   (Agtprm_fil.trndat     >=  n_comdatF     AND
              Agtprm_fil.trndat     <=  n_comdatT)    AND
              Agtprm_fil.bal        >   0
        NO-LOCK:
        /* เบี้ยเป็น 0 แต่ยังค้างค่า comm. (bal <> 0) */
        IF Agtprm_fil.prem + Agtprm_fil.prem_comp = 0 THEN NEXT.
        /*add...kridtiya i. A53-0394...*/
        ASSIGN
            nv_comm_per70  = 0
            nv_comm_per72  = 0.
        /* Find Commission Special */
        FIND LAST xmm018 USE-INDEX xmm01801 WHERE
            xmm018.agent   = Agtprm_fil.acno AND
            xmm018.poltyp  = nv_poltyp70
            /*AND xmm018.datest <= Agtprm_fil.comdat*/
            NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL xmm018 THEN
            nv_comm_per70 = xmm018.commsp.
        FIND LAST xmm018 USE-INDEX xmm01801 WHERE
            xmm018.agent   = Agtprm_fil.acno AND
            xmm018.poltyp  = nv_poltyp72
            /*AND   xmm018.datest <= Agtprm_fil.comdat*/
            NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL xmm018 THEN
            nv_comm_per72 = xmm018.commsp.
        /*end add...  kridtiya i. A53-0394...*/

        /* check policy cancle */
        FIND LAST acm001 USE-INDEX acm00104 WHERE
            acm001.policy = Agtprm_fil.policy NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL acm001 THEN
            IF acm001.trnty1 = "R" AND acm001.trnty2 = "C" THEN NEXT.
        ASSIGN
            nv_pol72      = ""     nv_norpol   = ""
            nv_job_nr     = ""     nv_insure   = ""
            nv_subins     = ""     nv_comp_sub = ""
            nv_remark     = ""     n_cha_no    = ""       /*kridtiya i. A53-0394*/
            n_eng_no    = ""       n_vehreg    = ""       /*kridtiya i. A53-0394*/
            nv_grossPrem   = 0     nv_grossPrem_comp = 0
            nv_nor_si      = 0     nv_comp_si        = 0
            nv_nor_net     = 0     nv_comp_net       = 0
            nv_nor_prm     = 0     nv_comp_prm       = 0
            nv_nor_com     = 0     nv_comp_com       = 0
            nv_stamp_per   = 0     nv_tax_per        = 0
            nv_stamp70     = 0     nv_stamp72        = 0
            nv_vat70       = 0     nv_vat72          = 0
            nv_vat_comm70  = 0     nv_vat_comm72     = 0
            nv_tax3_comm70 = 0     nv_tax3_comm72    = 0
            nv_comdat72    = ?     nv_expdat72       = ?
            nv_fptr        = ?     n_append          = "" .

       DISPLAY  "Process : " + Agtprm_fil.policy + '   ' + Agtprm_fil.trnty
                       + '  ' + Agtprm_fil.docno  @ fi_Process WITH FRAME {&FRAME-NAME} CENTERED.

        ASSIGN
            nv_norpol   = Agtprm_fil.policy
            nv_nor_net  = Agtprm_fil.prem       /* Premium ไม่รวม Compulsory */
            nv_nor_prm  = Agtprm_fil.prem
            nv_stamp70  = Agtprm_fil.stamp      /* Stamp Premium + Compulsory */
            nv_vat70    = Agtprm_fil.tax        /* Tax Premium + Compulsory */
            nv_comp_net = Agtprm_fil.prem_comp  /* Compulsory */
            nv_comp_prm = Agtprm_fil.prem_comp .

        FIND FIRST uwm100 USE-INDEX uwm10001 WHERE
                   uwm100.policy = Agtprm_fil.policy  AND
                   uwm100.endno  = Agtprm_fil.endno   AND
                   uwm100.docno1 = Agtprm_fil.docno   NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL uwm100 THEN DO:

            /* n= new policy, r = renew*/
            IF uwm100.rencnt = 0 AND uwm100.prvpol = "" THEN
                 nv_job_nr = "N".
            ELSE nv_job_nr = "R".

            /* 2 - Customer Name  + " " + TRIM(uwm100.name2)*/
            nv_insure = TRIM(uwm100.ntitle) + " " + TRIM(uwm100.name1).
            IF nv_insure = " " THEN nv_insure = TRIM(Agtprm_fil.insure).

            ASSIGN n_append = uwm100.cr_2  /*kridtiya i. A53-0394*/
                nv_rec100 = RECID(uwm100).    /* A50-0070 */

            /* Find Sub Insuracne Code (Normal & Compulsory) in Policy Memo Text(Uwd102.ltext) of V70 */
            LOOP_FINDTEXT:
            REPEAT:
                nv_fptr = uwm100.fptr02.

                DO WHILE nv_fptr <> 0 AND uwm100.fptr02 <> ? :
                    FIND FIRST uwd102 WHERE RECID(uwd102) = nv_fptr NO-LOCK NO-ERROR NO-WAIT.
                    IF AVAIL uwd102 THEN DO:
                        nv_fptr = uwd102.fptr.

                        /* รหัสย่อยบริษัทประกันภัย (TLT Comment) */
                        IF INDEX(uwd102.ltext, "NCD") <> 0 THEN DO:
                            nv_subins = TRIM(SUBSTR(uwd102.ltext, INDEX(uwd102.ltext,":") + 1 , LENGTH(uwd102.ltext))).
                        END.

                        /* รหัสย่อยบริษัทประกันภัย (TLT Comment) */
                        IF INDEX(uwd102.ltext, "CCD") <> 0 THEN DO:
                            nv_comp_sub = TRIM(SUBSTR(uwd102.ltext, INDEX(uwd102.ltext,":") + 1 , LENGTH(uwd102.ltext))).
                        END.
                    END.
                    ELSE nv_fptr = 0.
                END.    /* End do while */

                IF nv_subins <> "" AND nv_comp_sub <> "" THEN LEAVE loop_findtext.
                ELSE DO:
                    FIND NEXT uwm100 USE-INDEX uwm10001 WHERE
                              uwm100.policy = Agtprm_fil.policy NO-LOCK NO-ERROR NO-WAIT.
                    IF NOT AVAIL  uwm100  THEN LEAVE loop_findtext.

                    IF uwm100.releas = NO THEN LEAVE loop_findtext.
                END.
            END.

            FIND uwm100 WHERE RECID(uwm100) = nv_rec100 NO-LOCK NO-ERROR NO-WAIT.   /*A50-0070*/

            /*{wac\wactlt1.i} kridtiyain.*/  /* หา Compulsory Policy No. (nv_pol72) *//*kridtiya i. A53-0394*/
            RUN pdnopol72_proc.  /*kridtiya i. A53-0394*/  
                
            ASSIGN
                nv_grossPrem_comp = nv_comp_net + nv_stamp72 + nv_vat72
                nv_grossPrem      = nv_nor_net  + nv_stamp70 + nv_vat70

                nv_nor_prm     = nv_nor_prm + nv_stamp70 + nv_vat70
                nv_nor_com     = nv_nor_net * nv_comm_per70 / 100
                nv_vat_comm70  = nv_nor_com * nv_tax_per / 100
                nv_tax3_comm70 = nv_nor_com * 3 / 100

                nv_comp_prm    = nv_comp_prm + nv_stamp72 + nv_vat72
                nv_comp_com    = nv_comp_net * nv_comm_per72 / 100
                nv_vat_comm72  = nv_comp_com * nv_tax_per / 100
                nv_tax3_comm72 = nv_comp_com * 3 / 100

                nv_totalprm    = nv_nor_prm + nv_comp_prm
                nv_netamount   = ( nv_totalprm - (nv_nor_com     + nv_comp_com
                                               +  nv_vat_comm70  + nv_vat_comm72)
                                               + (nv_tax3_comm70 + nv_tax3_comm72) )
                .
           /*------------ create data to table wBill -----------*/
            FIND FIRST wBill USE-INDEX  wBill01     WHERE
                       wBill.wAcno   = Agtprm_fil.acno    AND
                       wBill.wPolicy = Agtprm_fil.policy  AND
                       wBill.wEndno  = Agtprm_fil.endno   AND
                       wBill.wtrnty1 = SUBSTR(Agtprm_fil.trnty,1,1)  AND
                       wBill.wtrnty2 = SUBSTR(Agtprm_fil.trnty,2,1)  AND
                       wBill.wdocno  = Agtprm_fil.docno
            NO-ERROR NO-WAIT.
            IF NOT AVAIL wBill THEN DO:
               vCountRec = vCountRec + 1.
               DISPLAY "Create data to Table wBill ..." @ fi_Process WITH FRAME {&FRAME-NAME}.

               /*----- Pron Add -----*/

            END. /* find first wBill */
        END.  /* avail  uwm100 */
    END.  /* for each Agtprm_fil */
/*END.    /* wfAcno */ /*kridtiya i. A53-0394*/*/

HIDE ALL NO-PAUSE.

IF vCountRec = 0 THEN DO:
    MESSAGE "ไม่พบข้อมูล ที่จะส่งออก" VIEW-AS ALERT-BOX INFORMATION.
    RETURN NO-APPLY.
END.
/*-----------------------------------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------------------------------*/

RELEASE AcProc_fil.
/*=======================End of Include File =============================*/
*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdProc_2 C-Win 
PROCEDURE pdProc_2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*add pdproc_2   .....kridtiya A53-0167........*/
/*comment .... by kridtiya i. A59-0362................
FIND LAST  AcProc_fil USE-INDEX by_type_asdat WHERE
           AcProc_fil.type  = "09"      AND
           AcProc_fil.asdat = n_asdat   NO-ERROR.                 /* n_asdat */
IF NOT AVAIL AcProc_fil THEN DO:  
    CREATE AcProc_fil. 
END.
                                        
ASSIGN 
    AcProc_fil.type     = "09"                          
    AcProc_fil.typdesc  = "PROCESS STATEMENT BILLING(LACL)" 
    AcProc_fil.asdat    = n_asdat                          /* วันที่ process statement */
    AcProc_fil.trndatfr = n_comdatF                        /* depend on condition on interface */
    AcProc_fil.trndatto = n_comdatT                        
    AcProc_fil.entdat   = TODAY                            /* วันที่ export textfile */
    AcProc_fil.enttim   = STRING(TIME, "HH:MM:SS")         /* เวลา export textfile */
    AcProc_fil.usrid    = n_user .
RELEASE AcProc_fil. 
END.... by kridtiya i. A59-0362*/
/*---- Clear Temp-Table ---*/
FOR EACH wBill:     
    DELETE wBill.   
END.
FOR EACH wAgtprm_fil:     
    DELETE wAgtprm_fil.   
END.

ASSIGN
    nv_poltyp70  = "SSV70"       /* Special Service Rate of V70 */
    nv_poltyp72  = "SSV72"       /* Special Service Rate of V72 */

    vCountRec    = 0 .
 
    LOOP_MAIN:
    /*FOR EACH  Agtprm_fil USE-INDEX by_trndat_acno  WHERE
              Agtprm_fil.asdat                      = n_asdat            AND
              Agtprm_fil.trndat                    >= n_comdatF          AND
              Agtprm_fil.trndat                    <= n_comdatT          AND
              LOOKUP(Agtprm_fil.acno,vProdCod)     <> 0                  AND   
              (Agtprm_fil.poltyp = "V70" OR Agtprm_fil.poltyp = "V72" )  AND
              (Agtprm_fil.TYPE = "01" OR Agtprm_fil.TYPE = "05")         AND
              Agtprm_fil.trntyp                BEGINS 'M'                AND
              (Agtprm_fil.polbran >= n_branch AND Agtprm_fil.polbran <= n_branch2) AND
              Agtprm_fil.bal                        > 0                  NO-LOCK:*/
    /*--- Add A54-0238 แก้ Index เนื่องจากโปรแกรมช้า ---*/
    FOR EACH  Agtprm_fil USE-INDEX by_acno  WHERE
              Agtprm_fil.asdat                      = n_asdat            AND
              LOOKUP(Agtprm_fil.acno,vProdCod)     <> 0                  AND   
              (Agtprm_fil.poltyp = "V70" OR Agtprm_fil.poltyp = "V72" )  AND
              /*Agtprm_fil.trndat                    >= n_comdatF          AND  /*Add by kridtiya i. A59-0362*/
              Agtprm_fil.trndat                    <= n_comdatT          AND*/  /*Add by kridtiya i. A59-0362*/
              (Agtprm_fil.TYPE = "01" OR Agtprm_fil.TYPE = "05")         AND
              /*-------------- Comment By Piyachat A55-0027 ----------------
              Agtprm_fil.trntyp                BEGINS 'M'                AND 
              (Agtprm_fil.polbran >= n_branch AND Agtprm_fil.polbran <= n_branch2) AND
              Agtprm_fil.bal                        > 0                  NO-LOCK:
              ------------------------------------------------------------*/
              /*------------------ STR Piyachat A55-0027 -----------------*/
              (Agtprm_fil.trntyp      BEGINS     'M'    OR 
               Agtprm_fil.trntyp      BEGINS     'R'    OR
               Agtprm_fil.trntyp      BEGINS     'A'    OR
               Agtprm_fil.trntyp      BEGINS     'B')                    AND
              (Agtprm_fil.polbran >= n_branch AND 
               Agtprm_fil.polbran <= n_branch2)                          NO-LOCK:
              /*------------------ END Piyachat A55-0027 -----------------*/
    /*--- End Add A54-0238 ---*/

        /* เบี้ยเป็น 0 แต่ยังค้างค่า comm. (bal <> 0) */
        IF ( Agtprm_fil.prem + Agtprm_fil.prem_comp ) = 0 THEN NEXT.
        IF Agtprm_fil.trndat                    < n_comdatF  THEN NEXT. /*Add by kridtiya i. A59-0362*/
        IF Agtprm_fil.trndat                    > n_comdatT  THEN NEXT. /*Add by kridtiya i. A59-0362*/

        /* check policy cancle */
        DISPLAY  "Process : " + Agtprm_fil.policy + '   ' + Agtprm_fil.trnty
            + '  ' + Agtprm_fil.docno FORMAT "X(10)" /* Benjaporn J. A60-0267 date 27/06/2017 */
            @ fi_Process WITH FRAME {&FRAME-NAME} CENTERED.

        /*kridtiya i. A53-0394...*/
        ASSIGN
            nv_comm_per70  = 0
            nv_comm_per72  = 0.

        /* Find Commission Special V70 */
        FIND LAST xmm018 USE-INDEX xmm01801 WHERE
                  xmm018.agent   =  Agtprm_fil.acno AND
                  xmm018.poltyp  =  nv_poltyp70     NO-LOCK NO-ERROR.
        IF AVAIL xmm018 THEN DO:
            nv_comm_per70 = xmm018.commsp.
        END.  
        ELSE nv_comm_per70 = 22.

        /* Find Commission Special V72 */
        FIND LAST xmm018 USE-INDEX xmm01801 WHERE
                  xmm018.agent   = Agtprm_fil.acno AND
                  xmm018.poltyp  = nv_poltyp72     NO-LOCK NO-ERROR.
        IF AVAIL xmm018 THEN  nv_comm_per72 = xmm018.commsp.
        ELSE nv_comm_per72 = 22.

        /*end....kridtiya i. A53-0394..............*/

        FIND LAST acm001 USE-INDEX acm00104 WHERE
                  acm001.policy = Agtprm_fil.policy NO-LOCK NO-ERROR.
        IF AVAIL acm001 THEN DO:
            IF acm001.trnty1 = "R" AND acm001.trnty2 = "C" THEN NEXT.
            /*---- Add Porn ---*/
            FIND LAST vat100 NO-LOCK  USE-INDEX vat10002 WHERE
                vat100.policy = acm001.policy      AND
                vat100.trnty1 = acm001.trnty1      AND
                vat100.refno  = acm001.docno       AND
                vat100.cancel = NO                 NO-ERROR.
            IF AVAIL vat100  THEN
                ASSIGN 
                n_invoice  = vat100.invoice 
                n_invdat   =  STRING(vat100.invdat,"99/99/9999").
            ELSE DO:
                FIND FIRST vat102 NO-LOCK USE-INDEX vat10211 WHERE
                    vat102.trnty1 = acm001.trnty1 AND
                    vat102.refno  = acm001.docno  NO-ERROR.
                IF AVAIL vat102 THEN
                    ASSIGN 
                    n_invoice  = vat102.invoice 
                    n_invdat   =  STRING(vat102.invdat,"99/99/9999").
                ELSE n_invoice = "".
            END.
            /*ELSE  ASSIGN n_invoice  =  " "
                n_invdat   =  " " . --- Comment A54-0238 ---*/
        END.

        FIND FIRST wagtprm_fil USE-INDEX wagtprm_fil01 WHERE 
                   wagtprm_fil.acno      = agtprm_fil.acno    AND
                   wagtprm_fil.policy    = agtprm_fil.policy  AND
                   wagtprm_fil.docno     = agtprm_fil.docno   AND
                   wagtprm_fil.vehreg    = agtprm_fil.vehreg  AND
                   wagtprm_fil.endno     = agtprm_fil.endno   NO-ERROR NO-WAIT.
        IF NOT AVAIL wagtprm_fil THEN DO: 

            CREATE wagtprm_fil.
            
        END.

        ASSIGN 
                wagtprm_fil.policy          = agtprm_fil.policy
                wagtprm_fil.trntyp          = agtprm_fil.trntyp
                wagtprm_fil.docno           = agtprm_fil.docno 
                wagtprm_fil.vehreg          = agtprm_fil.vehreg
                wagtprm_fil.prem            = agtprm_fil.prem
                wagtprm_fil.grossprm        = agtprm_fil.gross
                wagtprm_fil.prem_comp       = agtprm_fil.prem_comp  
                wagtprm_fil.endno           = agtprm_fil.endno 
                wagtprm_fil.bal             = agtprm_fil.bal
                wagtprm_fil.insure          = agtprm_fil.insure
                wagtprm_fil.stamp           = agtprm_fil.stamp
                wagtprm_fil.tax             = agtprm_fil.tax  
                wagtprm_fil.acno            = agtprm_fil.acno              
                wagtprm_fil.trnty           = agtprm_fil.trnty  
                wagtprm_fil.comdat          = agtprm_fil.comdat
                wagtprm_fil.asdat           = agtprm_fil.asdat
                wagtprm_fil.trndat          = agtprm_fil.trndat
                wagtprm_fil.poltyp          = agtprm_fil.poltyp 
                wagtprm_fil.nv_comm_per70   = nv_comm_per70
                wagtprm_fil.nv_comm_per72   = nv_comm_per72
                wagtprm_fil.Invoice         = n_Invoice.

    END.    /*for Agtprm_fil */

/*END.      */ /* wfAcno comment by Kridtiyain. A53-0394    */
/***********************************/
/*FOR EACH wagtprm_fil WHERE wagtprm_fil.poltyp = "v70" NO-LOCK.*//*Kridtiya i. A53-0241  16/08/10 */
vCountRec = 0.
FOR EACH wagtprm_fil  NO-LOCK.                                    /*Kridtiya i. A53-0241  16/08/10 */

    ASSIGN
        nv_pol72       = ""    nv_norpol         = ""
        nv_job_nr      = ""    nv_insure         = ""
        nv_subins      = ""    nv_comp_sub       = ""
        nv_remark      = ""    n_cha_no          = ""       /*kridtiya i. A53-0394*/
        n_eng_no       = ""    n_vehreg          = ""       /*kridtiya i. A53-0394*/
        nv_grossPrem   = 0     nv_grossPrem_comp = 0
        nv_nor_si      = 0     nv_comp_si        = 0
        nv_nor_net     = 0     nv_comp_net       = 0
        nv_nor_prm     = 0     nv_comp_prm       = 0
        nv_nor_com     = 0     nv_comp_com       = 0
        nv_stamp_per   = 0     nv_tax_per        = 0
        nv_stamp70     = 0     nv_stamp72        = 0
        nv_vat70       = 0     nv_vat72          = 0
        nv_vat_comm70  = 0     nv_vat_comm72     = 0
        nv_tax3_comm70 = 0     nv_tax3_comm72    = 0
        nv_comdat72    = ?     nv_expdat72       = ?
        nv_fptr        = ?     nv_grossPrem_com1 = 0 .   /*kridtiya i. A53-0314*/

    DISPLAY  "Process : " + wAgtprm_fil.policy + '   ' + wAgtprm_fil.trnty
            + '  ' + wAgtprm_fil.docno FORMAT "X(10)" /* Benjaporn J. A60-0267 date 27/06/2017 */
            @ fi_Process WITH FRAME {&FRAME-NAME} CENTERED.
        
    ASSIGN
        nv_norpol   = wAgtprm_fil.policy
        nv_nor_net  = wAgtprm_fil.prem        /* Premium ไม่รวม Compulsory */
        nv_nor_prm  = wAgtprm_fil.prem
        nv_stamp70  = wAgtprm_fil.stamp       /* Stamp Premium + Compulsory */
        nv_vat70    = wAgtprm_fil.tax         /* Tax Premium + Compulsory */
        nv_comp_net = wAgtprm_fil.prem_comp   /* Compulsory */
        nv_comp_prm = wAgtprm_fil.prem_comp .

    /*FIND FIRST uwm100 USE-INDEX uwm10001 WHERE*//*Comment Porn*/
    FIND LAST uwm100 USE-INDEX uwm10001 WHERE
        uwm100.policy = wAgtprm_fil.policy  AND
        uwm100.endno  = wAgtprm_fil.endno   AND
        uwm100.docno1 = wAgtprm_fil.docno   NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL uwm100 THEN DO:
        /* n= new policy, r = renew*/
        /*IF uwm100.rencnt = 0 AND uwm100.prvpol = "" THEN
            nv_job_nr = "N".
        ELSE nv_job_nr = "R".*/
        
        /* 2 - Customer Name  + " " + TRIM(uwm100.name2)*/
        nv_insure = TRIM(uwm100.ntitle) + " " + TRIM(uwm100.name1).
        IF nv_insure = " " THEN nv_insure = TRIM(wAgtprm_fil.insure).
        
        nv_rec100 = RECID(uwm100).    /* A50-0070 */

        /*----- Comment By : Porn -----
        /* Find Sub Insuracne Code (Normal & Compulsory) in Policy Memo Text(Uwd102.ltext) of V70 */
        LOOP_FINDTEXT:
        REPEAT:
            nv_fptr = uwm100.fptr02.
            DO WHILE nv_fptr <> 0 AND uwm100.fptr02 <> ? :
                FIND FIRST uwd102 WHERE RECID(uwd102) = nv_fptr NO-LOCK NO-ERROR NO-WAIT.
                IF AVAIL uwd102 THEN DO:
                    nv_fptr = uwd102.fptr.
                    /* รหัสย่อยบริษัทประกันภัย (TLT Comment) */
                    IF INDEX(uwd102.ltext, "NCD") <> 0 THEN DO:
                        nv_subins = TRIM(SUBSTR(uwd102.ltext, INDEX(uwd102.ltext,":") + 1 , LENGTH(uwd102.ltext))).
                    END.

                    /* รหัสย่อยบริษัทประกันภัย (TLT Comment) */
                    IF INDEX(uwd102.ltext, "CCD") <> 0 THEN DO:
                        nv_comp_sub = TRIM(SUBSTR(uwd102.ltext, INDEX(uwd102.ltext,":") + 1 , LENGTH(uwd102.ltext))).
                    END.
                END.
                ELSE nv_fptr = 0.
            END.    /* End do while */

            IF nv_subins <> "" AND nv_comp_sub <> "" THEN LEAVE loop_findtext.
            ELSE DO:
                FIND NEXT uwm100 USE-INDEX uwm10001 WHERE
                          uwm100.policy = wAgtprm_fil.policy NO-LOCK NO-ERROR NO-WAIT.
                IF NOT AVAIL  uwm100  THEN LEAVE loop_findtext.

                IF uwm100.releas = NO THEN LEAVE loop_findtext.
            END.
        END.
        ------ End Comment By : Porn -----*/

        ASSIGN 
            n_cedpol = uwm100.cedpol
            n_opnpol = uwm100.opnpol
            nv_comdat70 = uwm100.comdat 
            nv_expdat70 = uwm100.expdat.
          
        FIND uwm100 WHERE RECID(uwm100) = nv_rec100 NO-LOCK NO-ERROR NO-WAIT.   /*A50-0070*/
 
        /*---- Find Compulsory ----*/
        FOR EACH vehreg72:   
            DELETE  vehreg72.   
        END.
        /*/*kridtiya i. A53-0241*/
        IF wagtprm_fil.poltyp = "v72" THEN RUN PDnopol7272.
        ELSE RUN PDnopol72. 
        /*kridtiya i. A53-0241*/*//*Comment A54-0206*/

        /*--- Add A54-0206 ---*/
        IF wagtprm_fil.poltyp = "V72" THEN DO:
             IF uwm100.cr_2 = "" THEN DO: 
                 RUN PDnopol7272.
                 nv_stamp70 = 0.
                 nv_vat70 = 0.
             END.
             ELSE /*RUN PDnopol72*/ NEXT.
             /*nv_stamp70 = 0.
             nv_vat70 = 0.
             nv_nor_net = 0.*/
        END.
        ELSE RUN PDnopol72.
        /*--- End Add A54-0206 ---*/

        ASSIGN
            nv_grossPrem_comp = nv_comp_net + nv_stamp72 + nv_vat72
            nv_grossPrem      = nv_nor_net  + nv_stamp70 + nv_vat70

            nv_nor_prm        = nv_nor_prm + nv_stamp70 + nv_vat70
            nv_nor_com        = nv_nor_net * wagtprm_fil.nv_comm_per70 / 100
            nv_vat_comm70     = nv_nor_com * nv_tax_per / 100
            nv_tax3_comm70    = nv_nor_com * 3 / 100

            nv_comp_prm       = nv_comp_prm + nv_stamp72 + nv_vat72
            nv_comp_com       = nv_comp_net * wagtprm_fil.nv_comm_per72 / 100
            nv_vat_comm72     = nv_comp_com * nv_tax_per / 100
            nv_tax3_comm72    = nv_comp_com * 3 / 100

            nv_totalprm       = nv_nor_prm + nv_comp_prm
            nv_netamount      = ( nv_totalprm - (nv_nor_com + nv_comp_com + nv_vat_comm70  + nv_vat_comm72) + 
                                (nv_tax3_comm70 + nv_tax3_comm72) ).

        /*Add Kridtiya i. A53-0314*/
        IF (nv_norpol = nv_pol72) AND (wagtprm_fil.poltyp = "v72") THEN DO:
            ASSIGN 
                nv_totalprm       = nv_comp_prm
                nv_grossPrem_com1 = nv_grossPrem_comp 
                nv_netamount      = ( nv_totalprm - (nv_nor_com + nv_comp_com
                                    +  nv_vat_comm70  + nv_vat_comm72)
                                    + (nv_tax3_comm70 + nv_tax3_comm72) )
                nv_grossPrem_com1 = nv_grossPrem_comp .
        END.
        ELSE nv_grossPrem_com1 = nv_grossPrem + nv_grossPrem_comp .
        /*Add Kridtiya i. A53-0314*/

        /*---- Check Trans.Date ----*/
        /*n_trndat = wAgtprm_fil.trndat + 3.*/
        nv_trndat = wAgtprm_fil.trndat. 
             IF WEEKDAY(nv_trndat) = 1 OR WEEKDAY(nv_trndat) = 2 OR WEEKDAY(nv_trndat) = 3 THEN n_trndat = nv_trndat + 3.
        ELSE IF WEEKDAY(nv_trndat) = 4 OR WEEKDAY(nv_trndat) = 5 OR WEEKDAY(nv_trndat) = 6 THEN n_trndat = nv_trndat + 5.
        ELSE IF WEEKDAY(nv_trndat) = 7 THEN n_trndat = nv_trndat + 4.
        ELSE n_trndat = nv_trndat + 3.

        /*---- Create wBill ----*/
        FIND FIRST wBill USE-INDEX wBill01 WHERE
                   wBill.wAcno   = wAgtprm_fil.acno    AND
                   wBill.wPolicy = wAgtprm_fil.policy  AND
                   wBill.wEndno  = wAgtprm_fil.endno   AND
                   wBill.wtrnty1 = SUBSTR(wAgtprm_fil.trnty,1,1)  AND
                   wBill.wtrnty2 = SUBSTR(wAgtprm_fil.trnty,2,1)  AND
                   wBill.wdocno  = wAgtprm_fil.docno              NO-ERROR NO-WAIT. 
        IF NOT AVAIL wBill THEN DO:
            vCountRec = vCountRec + 1.
            DISPLAY "Create data to Table wBill ..." @ fi_Process WITH FRAME {&FRAME-NAME}.

            IF SUBSTRING(wAgtprm_fil.policy,3,2) = "72" THEN nv_pol72 = wAgtprm_fil.policy.

            CREATE wBill.
            ASSIGN
                wBill.wAcno          = wAgtprm_fil.acno     
                wBill.wEndno         = wAgtprm_fil.endno    
                wBill.wTrnty1        = SUBSTR(wAgtprm_fil.trntyp,1,1)     
                wBill.wTrnty2        = SUBSTR(wAgtprm_fil.trntyp,2,1)     
                wBill.wDocno         = wAgtprm_fil.docno     
                wBill.wNorpol        = IF wagtprm_fil.poltyp = "v72" THEN "" ELSE nv_norpol    
                wBill.wRecordno      = vCountRec   
                wBill.wCedPol        = n_cedpol   
                wBill.wInsure        = nv_insure     
                wBill.wPolicy        = IF wAgtprm_fil.poltyp = "V72" THEN "" ELSE wAgtprm_fil.policy    
                wBill.wPol72         = IF wAgtprm_fil.poltyp = "V70" THEN nv_pol72 ELSE wAgtprm_fil.policy
                wBill.wCovtyp        = n_covcod    
                wBill.wnor_covamt    = nv_nor_si 
                wBill.wFIThef        = n_fithef
                wBill.wNor_Comdat    = nv_comdat70 
                wBill.wNor_Expdat    = nv_expdat70  
                wBill.wNetPrem       = IF nv_pol72 = "" THEN wAgtprm_fil.prem + nv_comp_net ELSE wAgtprm_fil.prem
                wBill.wTotal_prm     = IF nv_pol72 = "" THEN nv_grossPrem_com1 ELSE nv_grossPrem 
                wBill.wCompNetPrem   = IF nv_pol72 = "" THEN 0 ELSE nv_comp_net
                wBill.wCompGrossPrem = IF nv_pol72 = "" THEN 0 ELSE nv_comp_prm
                wBill.wClass         = n_class
                wBill.wVehreg        = n_vehreg
                wBill.wCha_no        = n_cha_no 
                wBill.wBenname       = n_ben83
                wBill.wCampPol       = n_opnpol
                wBill.wInvoice       = wAgtprm_fil.Invoice
                wBill.wTransDate     = n_trndat  /** ต้องบวกเพิ่มอีก 3 วัน  จาก TODAY*/
                wBill.wComdat72      = IF nv_pol72 = "" THEN "" ELSE STRING(nv_comdat72)
                wBill.wExpdat72      = IF nv_pol72 = "" THEN "" ELSE STRING(nv_expdat72)
                wBill.wEndcnt        = n_endcnt
                wBill.wRencnt        = n_rencnt.
        END. 
    END.  /* avail  uwm100 */
END.  /* for each Agtprm_fil */

HIDE ALL NO-PAUSE.

IF vCountRec = 0 THEN DO:
    MESSAGE "ไม่พบข้อมูล ที่จะส่งออก" VIEW-AS ALERT-BOX INFORMATION.
    RETURN NO-APPLY.
END.

/*RELEASE AcProc_fil.*/ /*Add by kridtiya i. A59-0362*/
/*=======================End of Include File =============================*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_createproducer C-Win 
PROCEDURE proc_createproducer :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

ASSIGN vChkFirstAdd = 1 .
IF vChkFirstAdd = 1 THEN DO:
    DO WITH FRAME  fr_main :
        vProdCod = vProdCod.      
        se_producer:ADD-FIRST(vProdCod).
        se_producer = se_producer:SCREEN-VALUE .
        vProdCod = se_producer:LIST-ITEMS.
    END.
END. 
 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

/* ************************  Function Implementations ***************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fuDateToChar C-Win 
FUNCTION fuDateToChar RETURNS CHARACTER
  (vDate AS DATE) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/

  DEFINE VAR vBillDate  AS CHAR.

  IF vDate <> ? THEN
       vBillDate = STRING( YEAR(vDate),"9999") +
                   STRING(MONTH(vDate),"99")   +
                   STRING(  DAY(vDate),"99").
  ELSE vBillDate = "".

  RETURN vBillDate.   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fuDeciToChar C-Win 
FUNCTION fuDeciToChar RETURNS CHARACTER
  ( vDeci   AS DECIMAL, vCharno AS INTEGER ) :
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fuFindAcno C-Win 
FUNCTION fuFindAcno RETURNS LOGICAL
  ( nv_accode AS CHAR ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/

    FIND FIRST xmm600 WHERE  xmm600.acno = nv_accode NO-LOCK NO-ERROR NO-WAIT.
    IF NOT AVAIL xmm600 THEN
         RETURN TRUE.   /* Function return value. */

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
       nv_brndes = TRIM(CAPS(xmm023.bdes)).

   RETURN nv_brndes.   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fuLeapYear C-Win 
FUNCTION fuLeapYear RETURNS LOGICAL
  ( Y AS INTEGER) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
    DEFINE VAR vLeapYear  AS LOGICAL.

    vLeapYear = IF (y MOD 4 = 0) AND ((y MOD 100 <> 0) OR (y MOD 400 = 0))
                THEN TRUE ELSE FALSE.

    RETURN vLeapYear.   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fuNumYear C-Win 
FUNCTION fuNumYear RETURNS INTEGER
  ( vDate AS DATE ) :
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

