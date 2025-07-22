&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          sicfn            PROGRESS
*/
&Scoped-define WINDOW-NAME wacr2001
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS wacr2001 
/*------------------------------------------------------------------------
  File:                                                                   
  Description:                                                            
  Input Parameters:
      <none>
  Output Parameters:
      <none>
  Author:   
  Created: 
  Modify By A500178   Sayamol
              - ขยาย Branch 2 หลัก
  Modify By A50-0218  Sayamol 11/2007
            - ปรับ Aging Report 
            - เพิ่ม Output to Screen for .pdf file (Acrobat) Statement Report
  Modify By A51-0124  Sayamol  เช็ค Process & Report & Branch
  Modify By: Lukkana M. Date 24/09/2009
  Assign No: A52-0241  เพิ่มคอลัมน์ 1 year , 2 years , 3 years , over 3 years
             ในรายงานที่ออกเป็น net 
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
/* CREATE BY :  Bunthiya C.        A47-0261  */
Wac
        -Wacr1001.w            /*Aging Detail Report  */
Whp
        -WhpBran.w
        -WhpAcno.w
        -WhpClico.w
Wut
        -WutDiCen.p
        -WutWiCen.p                            
        มีรายละเอียด ดังนี้
        1. ใช้ข้อมูลจากการ  Process Statement Claim Fac.
        2. หน้าจอเปิดให้ระบุ Asdate เพื่อระบุวันที่ที่ใช้ในการคำนวน    (Aging = วันที่วันสุดท้ายของเดือน/ Statement = วันที่ ณ วันที่ Process)
        ซึ่ง Report ทั้ง 2 นี้ จะเรียกข้อมูลออกตาม By Acno 
        3. คิด overdue จากวัน Entry Date เทียบกับ As Date แล้วแยกเป็นช่วงทุกเดิอน 12 เดือน
        4. output  ที่ได้  เป็น text file ที่มี ";"  คั่นอยู่  เพื่อนำไปเข้าใน  Excel  คำนวน และทำการ print ได้จาก excel
                เมื่อเรียกรายงานออกมา  จะสร้างไฟล์ออกมา 2 ไฟล์  คือ
                1. ไฟล์ detail    
                2. ไฟล์ summary
------------------------------------------------------------------------- 
 Modify By : TANTAWAN C.   12/11/2007   [A500178]
             ปรับ format branch เพื่อรองรับการขยายสาขา
             ขยาย format fiacno1 จาก "X(7)" เป็น  Char "X(10)"
                         fiacno2 จาก "X(7)" เป็น  Char "X(10)"
Modify By A50-0218  Sayamol.N  29/08/2007
        - เพิ่มรายงานที่เอาเฉพาะยอด Net ของแต่ละ Insured   
        - เพิ่ม Report Statement                                
Modify By A51-0186  AMPARAT C. 
       Outward Fac ทั้ง Premium และ Claim ไม่มีข้อมูลบนโปรแกรม Safety Soft หลังการ Process  
Modify By: Lukkana M.  Date: 30/10/2009
Assign No: A52-0241  รายละเอียดในการแก้ไข 
            ไฟล์detail 
             -  เพิ่มคอลัมน์ sum insure-reinsurance , net amount(prem-comm+vat) , net paid (prem-comm+vat-tax-reserve) , 
                over 24 month , over 36 month , over 48 month
             -  ตรวจสอบข้อมูลช่อง vat , tax เนื่องจากคำนวณไม่ถูกต้อง
             -  line 61,62,63,64,67 ไม่คิด vat , tax นอกนั้นคิดหมด
             -  code ขึ้นต้นด้วย "0F" ไม่คิด vat , tax
             -  แก้ไขผลรวมของช่อง premium คำนวณไม่ถูกต้อง
             ไฟล์Net
             -  เพิ่มคอลัมน์ over 24 month , over 36 month , over 48 month
             -  แสดงค่า ratting ในคอลัมน์ remark
             -  net balance คำนวณจาก reinsurancepremium-discount
             ไฟล์ summary
             -  เพิ่มคอลัมน์ Producer code , producer name 
             -  เรียงลำดับข้อมูลใหม่เป็น premium , commission bal o/s , vat , tax
             -  เพิ่มคอลัมน์ over 24 month , over 36 month , over 48 month
             -  แสดงค่า ratting ในคอลัมน์ remark  
Modify by: Phaiboon W. [A59-0125] 05/04/2016
             เพิ่ม File Nzi โดยมี format เหมือน ไฟล์ Net แ่เปลี่ยน วิธีคำนวณ Aging ให้ตรงกับ Column
Modify by: Phaiboon W. [A59-0164] 11/05/2016
             เพิ่ม Report Aviva       
*************************/
/*----------------------------------------------------------------------
     Modify By: Saharat S.  A62-0279  29/01/2020
      -เปลี่ยนหัว เป็น TMSTH
----------------------------------------------------------------------*/
/*************************  Definitions  *************************/
DEF  SHARED VAR n_User           AS CHAR.
DEF  SHARED VAR n_Passwd         AS CHAR.
DEF  VAR  nv_User  AS CHAR NO-UNDO.
DEF  VAR  nv_pwd   LIKE _password NO-UNDO.
DEF  VAR vFirstTime  AS CHAR INIT "".
DEF  VAR vLastTime   AS CHAR INIT "".     
/* Definitons  Report ------- */
/* Parameters Definitions --- */
/*--- A500178 ---
DEF NEW SHARED VAR n_agent1   AS CHAR FORMAT "x(7)".
DEF NEW SHARED VAR n_agent2   AS CHAR FORMAT "x(7)". ------*/
DEF NEW SHARED VAR n_agent1   AS CHAR FORMAT "x(10)".
DEF NEW SHARED VAR n_agent2   AS CHAR FORMAT "x(10)".
DEF NEW SHARED VAR n_branch   AS CHAR FORMAT "x(2)".
DEF NEW SHARED VAR n_branch2  AS CHAR FORMAT "x(2)".
DEF NEW SHARED VAR n_tabcod   AS CHAR FORMAT "X(4)"  INIT "U021". /* Table-Code  sym100*/
DEF NEW SHARED VAR n_itmcod   AS CHAR FORMAT "X(4)".
DEF NEW SHARED VAR n_poltyp   AS CHAR FORMAT "X(4)". 
DEF VAR n_name       AS CHAR FORMAT "x(50)". /*acno*/
DEF VAR n_chkname    AS CHAR FORMAT "x(1)".  /* Acno-- chk button 1-2 */
DEF VAR n_bdes       AS CHAR FORMAT "x(50)". /*branch name*/
DEF VAR n_chkBname   AS CHAR FORMAT "x(1)".  /* branch-- chk button 1-2 */
DEF VAR n_itmdes     AS CHAR FORMAT "x(40)". /*Table-Code Description*/
DEF VAR  n_poldes    AS CHAR FORMAT "X(35)". /* policy des*/
/* Local Variable Definitions --- */
DEF VAR n_asdat     AS DATE FORMAT "99/99/9999".
DEF VAR n_frbr      AS CHAR FORMAT "x(2)".
DEF VAR n_tobr      AS CHAR FORMAT "x(2)".
/*--- A500178 ---
DEF VAR n_frac      AS CHAR FORMAT "x(7)".
DEF VAR n_toac      AS CHAR FORMAT "x(7)".------*/
DEF VAR n_frac      AS CHAR FORMAT "x(10)".
DEF VAR n_toac      AS CHAR FORMAT "x(10)".
DEF VAR n_typ       AS CHAR FORMAT "X".
DEF VAR n_typ1      AS CHAR FORMAT "X".
DEF VAR n_trndatfr  AS DATE FORMAT "99/99/9999".
DEF VAR n_trndatto  AS DATE FORMAT "99/99/9999".
DEF VAR n_OutputTo      AS INTEGER.
DEF VAR n_OutputFile    AS CHAR.  /* DETAIL file*/
DEF VAR n_OutputFileSum AS CHAR.  /* SUMMARY file*/
/*-By A50-0218-*/
DEF VAR n_OutputFileNet AS CHAR.  /* NetAging file*/    
DEF VAR n_OutputFileST  AS CHAR.  /* NetStatement file*/    
DEF VAR n_OutputFileNzi AS CHAR.  /* NetAging NZI file */ /* add by Phaiboon W. [A59-0125] 01/04/2016 */
DEF VAR n_OutputFileAvi AS CHAR.  /* Form Aviva */ /* add by Phaiboon W. [A59-0164] 11/05/2016 */
/*-------------*/
DEF VAR n_odat1         AS DATE FORMAT "99/99/9999".
/***************************************/
DEF VAR nv_ProcessDate  AS DATE FORMAT "99/99/9999".
DEF VAR nv_asdatAging   AS DATE FORMAT "99/99/9999".
/*---------------------- A46-0142 -------------------*/
/*** เพิ่มช่องที่ระบุ type ***/
DEF VAR nv_Trntyp1  AS CHAR INIT "O , T , U , P".
DEF VAR nv_typ1     AS CHAR.
DEF VAR nv_typ2     AS CHAR.
DEF VAR nv_typ3     AS CHAR.
DEF VAR nv_typ4     AS CHAR.
DEF VAR nv_typ5     AS CHAR.
DEF VAR nv_typ6     AS CHAR.
DEF VAR nv_typ7     AS CHAR.
DEF VAR nv_typ8     AS CHAR.
DEF VAR nv_typ9     AS CHAR.
DEF VAR nv_typ10    AS CHAR.
DEF VAR nv_typ11    AS CHAR.
DEF VAR nv_typ12    AS CHAR.
DEF VAR nv_typ13    AS CHAR.
DEF VAR nv_typ14    AS CHAR.
DEF VAR nv_typ15    AS CHAR.
/*** แยก Report ***/
DEF VAR nv_RptTyp   AS CHAR.
DEF VAR nv_RptName  AS CHAR.
DEF VAR nv_RptName2 AS CHAR.
DEF VAR nv_poltypFr AS CHAR.
DEF VAR nv_poltypTo AS CHAR.
/*** คำนวนวัน ***/
DEF VAR n_due       AS DATE FORMAT "99/99/9999".
DEF VAR n_day       AS INTE FORMAT ">>>>9".
DEF VAR i           AS INTE INIT 0.
/***------------ ตัวแปรที่รับค่า  แล้วนำไป Export file Detail --------------***/
DEF  VAR nv_premCB  AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_commCB  AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_totalCB AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_net     AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_premA   AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_taxA    AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_vatA    AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_sbtA    AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_stampA  AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_totalA  AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_commA   AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_netA    AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_retcA   AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_suspA   AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_balA    AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_netarA  AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_netothA AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
/***--------------------- "Summary of : " -------------------***/
/***------------------- "G R A N D  T O T A L" -----------------***/
DEF VAR nv_blankH   AS CHAR INIT " " EXTENT 20.
DEF VAR nv-1        AS CHAR.
DEF VAR nv-2        AS CHAR.
DEF VAR nv-3        AS CHAR.
DEF VAR nv_bdes     AS CHAR.
DEF VAR nv_Linedes  AS CHAR.
DEF VAR nv_acname   AS CHAR.
/* ตัวแปร display ใน report summary */
DEF VAR nv_RptTyp1  AS CHAR INIT "".
DEF VAR nv_RptTyp2  AS CHAR INIT "".
DEF VAR n_trnty1    AS CHAR FORMAT "X" .
DEF VAR n_trnty2    AS CHAR FORMAT "X" .
DEF VAR nv_prm      LIKE ACM001.PREM .  /* Net Premium */
DEF VAR nv_com      LIKE ACM001.PREM .
DEF VAR nv_sup      LIKE ACM001.PREM .
DEF VAR nv_pprm     LIKE Acm001.Prem.  /* Prem Amount before TAX, STAMP */
DEF VAR nv_stamp    LIKE Acm001.Stamp. 
DEF VAR nv_tax      LIKE Acm001.TAX.   /* < 4% of Prem is SBT Else Vat */
DEF VAR nv_netamt   LIKE ACM001.PREM.
DEF VAR nv_sumsup   LIKE ACM001.PREM.
DEF VAR nv_sumprm   LIKE ACM001.PREM.
DEF VAR nv_sumcom   LIKE ACM001.PREM.
DEF VAR nv_spcp     LIKE ACM001.PREM.
DEF VAR nv_DetSum       AS CHAR.
DEF VAR n_processdate   AS DATE.
/* A47-0261 */
/*--- A50-0218
DEF VAR  nv_blankF  AS CHAR  INIT " " EXTENT 20.
DEF VAR  nv_blankX  AS CHAR  INIT " " EXTENT 20.
------------*/
/*--A50-0218--*/
DEF VAR  nv_blankF  AS CHAR  INIT " " EXTENT 25.   
DEF VAR  nv_blankX  AS CHAR  INIT " " EXTENT 25.
/*------------*/
DEF VAR  nv_gtotal   AS DECI  FORMAT "->>,>>>,>>>,>>9.99" INIT 0 EXTENT 18. /*13.*/
DEF VAR  nv_fgtotal  AS DECI  FORMAT "->>,>>>,>>>,>>9.99" INIT 0 EXTENT 18. /*13.*/
DEF VAR  nv_sgtotal  AS DECI  FORMAT "->>,>>>,>>>,>>9.99" INIT 0 EXTENT 18. /*13.*/                                                                         
DEF VAR  nv_gprem   AS DECI  FORMAT "->>,>>>,>>>,>>9.99" INIT 0.         
DEF VAR  nv_gcomm   AS DECI  FORMAT "->>,>>>,>>>,>>9.99" INIT 0.         
DEF VAR  nv_gnet    AS DECI  FORMAT "->>,>>>,>>>,>>9.99" INIT 0.         
DEF VAR  nv_gres    AS DECI  FORMAT "->>,>>>,>>>,>>9.99" INIT 0.    /*A48-0113*/
DEF VAR  nv_gbal    AS DECI  FORMAT "->>,>>>,>>>,>>9.99" INIT 0.    /*A48-0113*/
/*----A50-0218----*/
DEF VAR  nv_gbalos  AS DECI  FORMAT "->>,>>>,>>>,>>9.99" INIT 0.    
DEF VAR  nv_gvat    AS DECI  FORMAT "->>,>>>,>>>,>>9.99" INIT 0.    
DEF VAR  nv_gtax    AS DECI  FORMAT "->>,>>>,>>>,>>9.99" INIT 0.    
DEF VAR  nv_gnetpd  AS DECI  FORMAT "->>,>>>,>>>,>>9.99" INIT 0.    
/*-------------------*/
DEF VAR  nv_sgprem  AS DECI  FORMAT "->>,>>>,>>>,>>9.99" INIT 0 EXTENT 18. /*13.*/
DEF VAR  nv_sgcomm  AS DECI  FORMAT "->>,>>>,>>>,>>9.99" INIT 0 EXTENT 18. /*13.*/
DEF VAR  nv_sgnet   AS DECI  FORMAT "->>,>>>,>>>,>>9.99" INIT 0 EXTENT 18. /*13.*/
DEF VAR  nv_sgres   AS DECI  FORMAT "->>,>>>,>>>,>>9.99" INIT 0 EXTENT 18. /*13.*/    /*A48-0113*/
DEF VAR  nv_sgbal   AS DECI  FORMAT "->>,>>>,>>>,>>9.99" INIT 0 EXTENT 18. /*13.*/    /*A48-0113*/
/*----A50-0218----*/
DEF VAR  nv_sgbalos AS DECI  FORMAT "->>,>>>,>>>,>>9.99" INIT 0 EXTENT 18. /*13.*/   
DEF VAR  nv_sgvat   AS DECI  FORMAT "->>,>>>,>>>,>>9.99" INIT 0 EXTENT 18. /*13.*/
DEF VAR  nv_sgtax   AS DECI  FORMAT "->>,>>>,>>>,>>9.99" INIT 0 EXTENT 18. /*13.*/
DEF VAR  nv_sgnetpd AS DECI  FORMAT "->>,>>>,>>>,>>9.99" INIT 0 EXTENT 18. /*13.*/
/*-------------*/                                                       
DEF VAR  nv_reptyp  AS CHAR  FORMAT "X(2)".         /* A48-0113 */
DEF VAR  nv_repdes  AS CHAR.                        /* A48-0113 */
/* A48-0113 */
DEF VAR  nv_racodep AS DECI  FORMAT "->>,>>>,>>>,>>9.99" INIT 0 EXTENT 18. /*14.*/
DEF VAR  nv_racodec AS DECI  FORMAT "->>,>>>,>>>,>>9.99" INIT 0 EXTENT 18. /*14.*/
DEF VAR  nv_racoden AS DECI  FORMAT "->>,>>>,>>>,>>9.99" INIT 0 EXTENT 18. /*14.*/
DEF VAR  nv_racoder AS DECI  FORMAT "->>,>>>,>>>,>>9.99" INIT 0 EXTENT 18. /*14.*/
DEF VAR  nv_racodeb AS DECI  FORMAT "->>,>>>,>>>,>>9.99" INIT 0 EXTENT 18. /*14.*/ 
/*----
DEF VAR  nv_rbcodep AS DECI  FORMAT "->>,>>>,>>>,>>9.99" INIT 0 EXTENT 14.
DEF VAR  nv_rbcodec AS DECI  FORMAT "->>,>>>,>>>,>>9.99" INIT 0 EXTENT 14.
DEF VAR  nv_rbcoden AS DECI  FORMAT "->>,>>>,>>>,>>9.99" INIT 0 EXTENT 14.
DEF VAR  nv_rbcoder AS DECI  FORMAT "->>,>>>,>>>,>>9.99" INIT 0 EXTENT 14.
DEF VAR  nv_rbcodeb AS DECI  FORMAT "->>,>>>,>>>,>>9.99" INIT 0 EXTENT 14. ----*/
DEF VAR  nv_rdcodep AS DECI  FORMAT "->>,>>>,>>>,>>9.99" INIT 0 EXTENT 18. /*14.*/  
DEF VAR  nv_rdcodec AS DECI  FORMAT "->>,>>>,>>>,>>9.99" INIT 0 EXTENT 18. /*14.*/  
DEF VAR  nv_rdcoden AS DECI  FORMAT "->>,>>>,>>>,>>9.99" INIT 0 EXTENT 18. /*14.*/  
DEF VAR  nv_rdcoder AS DECI  FORMAT "->>,>>>,>>>,>>9.99" INIT 0 EXTENT 18. /*14.*/  
DEF VAR  nv_rdcodeb AS DECI  FORMAT "->>,>>>,>>>,>>9.99" INIT 0 EXTENT 18. /*14.*/  

DEF VAR  nv_rfcodep AS DECI  FORMAT "->>,>>>,>>>,>>9.99" INIT 0 EXTENT 18. /*14.*/  
DEF VAR  nv_rfcodec AS DECI  FORMAT "->>,>>>,>>>,>>9.99" INIT 0 EXTENT 18. /*14.*/  
DEF VAR  nv_rfcoden AS DECI  FORMAT "->>,>>>,>>>,>>9.99" INIT 0 EXTENT 18. /*14.*/  
DEF VAR  nv_rfcoder AS DECI  FORMAT "->>,>>>,>>>,>>9.99" INIT 0 EXTENT 18. /*14.*/  
DEF VAR  nv_rfcodeb AS DECI  FORMAT "->>,>>>,>>>,>>9.99" INIT 0 EXTENT 18. /*14.*/  
/* A48-0113 */
DEF VAR nv_relate AS CHAR FORMAT "X(7)".

/*---A50-0218---*/
DEF NEW SHARED VAR p_acno   AS CHAR.   
DEF NEW SHARED VAR p_acname AS CHAR. 
DEF NEW SHARED VAR p_trndat AS CHAR. 
DEF NEW SHARED VAR p_policy AS CHAR. 
DEF NEW SHARED VAR p_endno  AS CHAR.  
DEF NEW SHARED VAR p_comdat AS CHAR. 
DEF NEW SHARED VAR p_docno  AS CHAR FORMAT "x(10)" . /* Benjaporn J. A60-0267 date 27/06/2017 */
DEF NEW SHARED VAR p_insure AS CHAR. 
DEF NEW SHARED VAR p_prem   AS CHAR.
DEF NEW SHARED VAR p_stamp  AS CHAR.
DEF NEW SHARED VAR p_tax    AS CHAR.
DEF NEW SHARED VAR p_comm   AS CHAR.
DEF NEW SHARED VAR p_bal    AS CHAR.
DEF NEW SHARED VAR p_duedat AS CHAR. 
DEF NEW SHARED VAR p_cedpol AS CHAR. 
DEF NEW SHARED VAR nv_stos  AS CHAR. 
DEF NEW SHARED VAR nv_tstos AS CHAR.
DEF NEW SHARED VAR nv_gstos AS CHAR.
DEF NEW SHARED VAR nv_ostyp AS CHAR.
DEF NEW SHARED VAR nv_ostyp1  AS CHAR.
DEF NEW SHARED VAR nv_ostyp2  AS CHAR.
DEF NEW SHARED VAR nv_ostyp3  AS CHAR.
DEF NEW SHARED VAR nv_poltyp  AS CHAR.
DEF NEW SHARED VAR nv_pa      AS CHAR INIT "60,61,62,63,64,67".
DEF VAR  nv_balos  AS DECI FORMAT "->>,>>>,>>>,>>9.99".    
DEF VAR  nv_vat    AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR  nv_netpd  AS DECI FORMAT "->>,>>>,>>>,>>9.99".
/*-------------------*/
/* Definitons  Report -------   */
DEF NEW SHARED VAR report-library AS CHAR INIT "wAC/wprl/wac_sm01A.prl".
DEF NEW SHARED VAR report-name  AS CHAR INIT "Statement Inward FAC".
DEF NEW SHARED VAR RB-DB-CONNECTION AS CHAR INIT "".
DEF NEW SHARED VAR RB-INCLUDE-RECORDS AS CHAR INIT "O". /*Can Override Filter*/
DEF NEW SHARED VAR RB-FILTER AS CHAR INIT "".
DEF NEW SHARED VAR RB-MEMO-FILE AS CHAR INIT "".
DEF NEW SHARED VAR RB-PRINT-DESTINATION AS CHAR INIT "?". /*Direct to Screen*/
DEF NEW SHARED VAR RB-PRINTER-NAME AS CHAR INIT "".
DEF NEW SHARED VAR RB-PRINTER-PORT AS CHAR INIT "".
DEF NEW SHARED VAR RB-OUTPUT-FILE AS CHAR INIT "".
DEF NEW SHARED VAR RB-NUMBER-COPIES AS INTE INIT 1.
DEF NEW SHARED VAR RB-BEGIN-PAGE AS INTE INIT 0.
DEF NEW SHARED VAR RB-END-PAGE AS INTE INIT 0.
DEF NEW SHARED VAR RB-TEST-PATTERN AS LOG INIT no.
DEF NEW SHARED VAR RB-WINDOW-TITLE AS CHAR INIT "".
DEF NEW SHARED VAR RB-DISPLAY-ERRORS AS LOG INIT yes.
DEF NEW SHARED VAR RB-DISPLAY-STATUS AS LOG INIT yes.
DEF NEW SHARED VAR RB-NO-WAIT AS LOG INIT no.
DEF NEW SHARED VAR RB-OTHER-PARAMETERS AS CHAR INIT "".
DEF VAR nv_filter1  AS CHAR INIT "".
DEF VAR nv_filter2  AS CHAR INIT "".
/*--------------*/
DEF VAR nv_i1           AS INTE INIT 0.
DEF VAR nv_i2           AS INTE INIT 0.
DEF VAR nv_i3           AS INTE INIT 0.
/*-- Lukkana M. A52-0241 28/09/2009 --*/
DEF VAR  nv_gap     AS INT INIT 0.
DEF VAR  nv_col     AS INT INIT 0.
DEF VAR  nv_row     AS INT INIT 0.
/*DEF VAR  nv_prem    AS DECI FORMAT "->>,>>>,>>>,>>9.99".*/
DEF VAR  nv_ffield  AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 18. /*13.*/
DEF VAR  nv_sfield  AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 18. /*13.*/
/*DEF VAR  nv_sprem   AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 18. /*14.*/
DEF VAR  nv_scomm   AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 18. /*14.*/*/
DEF VAR  nv_snet    AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 18. /*14.*/    /*A48-0113*/
DEF VAR  nv_sres    AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 18. /*14.*/    /*A48-0113*/
/*DEF VAR  nv_sbal    AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 18. /*14.*/ */

/*---A50-0218---*/
DEF VAR  nv_sbalos  AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 18. /*14.*/     
/*DEF VAR  nv_svat    AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 18. /*14.*/    
DEF VAR  nv_stax    AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 18. /*14.*/    */
DEF VAR  nv_snetpd  AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 18. /*14.*/    
/*---------------*/
DEF VAR  nv_ftotal  AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 18. /*13.*/
DEF VAR  nv_stotal  AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 18. /*13.*/
DEF VAR  nv_tprem   AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR  nv_tcomm   AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR  nv_tnet    AS DECI FORMAT "->>,>>>,>>>,>>9.99".    /*A48-0113*/
DEF VAR  nv_tres    AS DECI FORMAT "->>,>>>,>>>,>>9.99".    /*A48-0113*/
DEF VAR  nv_tbal    AS DECI FORMAT "->>,>>>,>>>,>>9.99".

/*----A50-0218----*/
DEF VAR  nv_tbalos AS DECI FORMAT "->>,>>>,>>>,>>9.99".   
DEF VAR  nv_tvat   AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR  nv_ttax   AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR  nv_tnetpd AS DECI FORMAT "->>,>>>,>>>,>>9.99".
/*----------------*/

DEF VAR  nv_premres AS DECI FORMAT "->>,>>>,>>>,>>9.99".    /*A48-0113*/
DEF VAR  nv_netbal  AS DECI FORMAT "->>,>>>,>>>,>>9.99".    /*A48-0113*/
DEF VAR  nv_prod    AS CHAR.
DEF VAR  nv_appe    AS CHAR. /* add by Phaiboon W. [A59-0164] 11/05/2016 */
DEF VAR  nv_comm    AS DECI.
DEF VAR  nv_fron    AS INT.
DEF VAR  nv_vat7    AS DECI.
DEF VAR  nv_rese    AS DECI.
DEF VAR  nv_yous    AS DECI.
DEF VAR  nv_tvat7   AS DECI.
DEF VAR  nv_trese   AS DECI.
DEF VAR  nv_tyous   AS DECI.
DEF VAR  nv_gvat7   AS DECI.
DEF VAR  nv_grese   AS DECI.
DEF VAR  nv_gyous   AS DECI.
/*ADD Saharat S. A62-0279*/
{wuw\wuwppic00a.i NEW}. 
{wuw\wuwppic01a.i}
{wuw\wuwppic02a.i}
/*END Saharat S. A62-0279*/
/*DEF VAR  nv_gap     AS INT INIT 0.
DEF VAR  nv_num     AS INT INIT 0.
DEF VAR  nv_col     AS INT INIT 0.
DEF VAR  nv_row     AS INT INIT 0.
DEF VAR  nv_tprem   AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR  nv_tcomm   AS DECI FORMAT "->>,>>>,>>>,>>9.99".
/*---A50-0218---*/
DEF VAR  nv_tvat   AS DECI FORMAT "->>,>>>,>>>,>>9.99". 
DEF VAR  nv_ttax   AS DECI FORMAT "->>,>>>,>>>,>>9.99".   
/*--------------*/
DEF VAR  nv_tbal    AS DECI FORMAT "->>,>>>,>>>,>>9.99". */

{wac\wacrvar.i} 
/*-- Lukkana M. A52-0241 28/09/2009 --*/

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME frMain
&Scoped-define BROWSE-NAME brAcproc_fil

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES acproc_fil

/* Definitions for BROWSE brAcproc_fil                                  */
&Scoped-define FIELDS-IN-QUERY-brAcproc_fil acproc_fil.asdat ~
acproc_fil.type acproc_fil.entdat acproc_fil.enttim ~
SUBSTRING (acproc_fil.enttim,10,3) acproc_fil.trndatfr acproc_fil.trndatto ~
acproc_fil.typdesc 
&Scoped-define ENABLED-FIELDS-IN-QUERY-brAcproc_fil 
&Scoped-define QUERY-STRING-brAcproc_fil FOR EACH acproc_fil NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-brAcproc_fil OPEN QUERY brAcproc_fil FOR EACH acproc_fil NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-brAcproc_fil acproc_fil
&Scoped-define FIRST-TABLE-IN-QUERY-brAcproc_fil acproc_fil


/* Definitions for FRAME frST                                           */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS RECT-405 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME


/* ************************  Function Prototypes ********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fuLeapYear wacr2001 
FUNCTION fuLeapYear RETURNS LOGICAL
  ( /* parameter-definitions */ y AS int)  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fuMaxDay wacr2001 
FUNCTION fuMaxDay RETURNS INTEGER
  (INPUT vDate AS DATE )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fuNumMonth wacr2001 
FUNCTION fuNumMonth RETURNS INTEGER
  (INPUT vMonth AS INT ,vDate AS DATE )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fuNumYear wacr2001 
FUNCTION fuNumYear RETURNS INTEGER
  (INPUT vDate AS DATE )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR wacr2001 AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE RECTANGLE RECT-405
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 131 BY 1.52
     BGCOLOR 3 .

DEFINE BUTTON Btn_Cancel AUTO-END-KEY 
     LABEL "CANCEL" 
     SIZE 16 BY 1.29
     BGCOLOR 8 FONT 6.

DEFINE BUTTON Btn_OK AUTO-GO 
     LABEL "OK" 
     SIZE 16 BY 1.29
     BGCOLOR 8 FONT 6.

DEFINE RECTANGLE RECT-3
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 19.5 BY 2.52
     BGCOLOR 4 .

DEFINE RECTANGLE RECT2
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 19.5 BY 2.52
     BGCOLOR 1 .

DEFINE VARIABLE cbPrtList AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 10
     LIST-ITEMS "cbPrtList" 
     DROP-DOWN-LIST
     SIZE 40 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fiFile-Name AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 40 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE ra_balos AS INTEGER 
     VIEW-AS RADIO-SET VERTICAL
     RADIO-BUTTONS 
          "O/S > 0", 1,
"O/S = 0", 2,
"O/S <= 0", 3,
"All", 4
     SIZE 20 BY 4.29
     BGCOLOR 19 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE rsOutput AS INTEGER 
     VIEW-AS RADIO-SET VERTICAL
     RADIO-BUTTONS 
          "SCREEN FOR STATEMENT", 1,
"PRINTER", 2,
"FILE FOR AGING", 3
     SIZE 27.5 BY 4.05
     BGCOLOR 3 FGCOLOR 15  NO-UNDO.

DEFINE RECTANGLE RECT-306
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 32.5 BY 4.52
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-406
     EDGE-PIXELS 1 GRAPHIC-EDGE    
     SIZE 72.5 BY 4.52
     BGCOLOR 3 .

DEFINE VARIABLE to_aviva AS LOGICAL INITIAL no 
     LABEL "Statement AVIVA" 
     VIEW-AS TOGGLE-BOX
     SIZE 21 BY .81
     BGCOLOR 3 FGCOLOR 15  NO-UNDO.

DEFINE BUTTON buAcno1 
     LABEL "..." 
     SIZE 3 BY .95 TOOLTIP "รหัส Producer"
     FONT 6.

DEFINE BUTTON buAcno2 
     LABEL "..." 
     SIZE 3 BY .95 TOOLTIP "รหัส Producer"
     FONT 6.

DEFINE BUTTON buBranch 
     LABEL "..." 
     SIZE 3 BY .95 TOOLTIP "รหัสสาขา"
     FONT 6.

DEFINE BUTTON buBranch2 
     LABEL "..." 
     SIZE 3 BY .95 TOOLTIP "รหัสสาขา"
     FONT 6.

DEFINE BUTTON buPoltypFr 
     LABEL "..." 
     SIZE 3 BY .95 TOOLTIP "ประเภทกรมธรรม์"
     FONT 6.

DEFINE BUTTON buPoltypTo 
     LABEL "..." 
     SIZE 3 BY .95 TOOLTIP "ประเภทกรมธรรม์"
     FONT 6.

DEFINE BUTTON but_Search 
     LABEL "Query by As Date Process" 
     SIZE 36.5 BY 1.14
     FONT 6.

DEFINE VARIABLE coRptTyp AS CHARACTER FORMAT "X(256)":U 
     LABEL "Combo 1" 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEMS "Item 1" 
     DROP-DOWN-LIST
     SIZE 25.5 BY 1
     BGCOLOR 15 FGCOLOR 1 FONT 2 NO-UNDO.

DEFINE VARIABLE fiacno1 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fiacno2 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fiAsdat AS DATE FORMAT "99/99/9999":U 
     LABEL "Fill 1" 
      VIEW-AS TEXT 
     SIZE 14 BY 1
     BGCOLOR 3 FGCOLOR 7  NO-UNDO.

DEFINE VARIABLE fiasdatAging AS DATE FORMAT "99/99/9999":U 
     LABEL "Fill 1" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 1 NO-UNDO.

DEFINE VARIABLE fibdes AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 54.5 BY 1
     BGCOLOR 8 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fibdes2 AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 54.5 BY 1
     BGCOLOR 8 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fiBranch AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 6 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fiBranch2 AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 6 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fiInclude AS CHARACTER FORMAT "X(256)":U 
     LABEL "Fill 1" 
      VIEW-AS TEXT 
     SIZE 18 BY 1
     BGCOLOR 1 FGCOLOR 7 FONT 1 NO-UNDO.

DEFINE VARIABLE finame1 AS CHARACTER FORMAT "X(256)":U 
     LABEL "" 
      VIEW-AS TEXT 
     SIZE 45.67 BY 1
     BGCOLOR 8 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE finame2 AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 45.67 BY 1
     BGCOLOR 8 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fiPoldesFr AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 54.5 BY 1
     BGCOLOR 8 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fiPoldesTo AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 54.5 BY 1
     BGCOLOR 8 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fiPolTypFr AS CHARACTER FORMAT "X(4)":U 
     VIEW-AS FILL-IN 
     SIZE 6 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fiPolTypTo AS CHARACTER FORMAT "X(4)":U 
     VIEW-AS FILL-IN 
     SIZE 6 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fiProcess AS CHARACTER FORMAT "X(256)":U 
     LABEL "fiProcess" 
      VIEW-AS TEXT 
     SIZE 34 BY .95
     BGCOLOR 8 FGCOLOR 0 FONT 1 NO-UNDO.

DEFINE VARIABLE fiProcessDate AS DATE FORMAT "99/99/9999":U 
      VIEW-AS TEXT 
     SIZE 15.5 BY 1
     BGCOLOR 3 FGCOLOR 7 FONT 1 NO-UNDO.

DEFINE VARIABLE fiTyp1 AS CHARACTER FORMAT "X(1)":U 
     VIEW-AS FILL-IN 
     SIZE 4 BY 1
     BGCOLOR 15 FONT 2 NO-UNDO.

DEFINE VARIABLE fiTyp10 AS CHARACTER FORMAT "X(1)":U 
     VIEW-AS FILL-IN 
     SIZE 4 BY 1
     BGCOLOR 15 FONT 2 NO-UNDO.

DEFINE VARIABLE fiTyp11 AS CHARACTER FORMAT "X(1)":U 
     VIEW-AS FILL-IN 
     SIZE 4 BY 1
     BGCOLOR 15 FONT 2 NO-UNDO.

DEFINE VARIABLE fiTyp12 AS CHARACTER FORMAT "X(1)":U 
     VIEW-AS FILL-IN 
     SIZE 4 BY 1
     BGCOLOR 15 FONT 2 NO-UNDO.

DEFINE VARIABLE fiTyp13 AS CHARACTER FORMAT "X(1)":U 
     VIEW-AS FILL-IN 
     SIZE 4 BY 1
     BGCOLOR 15 FONT 2 NO-UNDO.

DEFINE VARIABLE fiTyp14 AS CHARACTER FORMAT "X(1)":U 
     VIEW-AS FILL-IN 
     SIZE 4 BY 1
     BGCOLOR 15 FONT 2 NO-UNDO.

DEFINE VARIABLE fiTyp15 AS CHARACTER FORMAT "X(1)":U 
     VIEW-AS FILL-IN 
     SIZE 4 BY 1
     BGCOLOR 15 FONT 2 NO-UNDO.

DEFINE VARIABLE fiTyp2 AS CHARACTER FORMAT "X(1)":U 
     VIEW-AS FILL-IN 
     SIZE 4 BY 1
     BGCOLOR 15 FONT 2 NO-UNDO.

DEFINE VARIABLE fiTyp3 AS CHARACTER FORMAT "X(1)":U 
     VIEW-AS FILL-IN 
     SIZE 4 BY 1
     BGCOLOR 15 FONT 2 NO-UNDO.

DEFINE VARIABLE fiTyp4 AS CHARACTER FORMAT "X(1)":U 
     VIEW-AS FILL-IN 
     SIZE 4 BY 1
     BGCOLOR 15 FONT 2 NO-UNDO.

DEFINE VARIABLE fiTyp5 AS CHARACTER FORMAT "X(1)":U 
     VIEW-AS FILL-IN 
     SIZE 4 BY 1
     BGCOLOR 15 FONT 2 NO-UNDO.

DEFINE VARIABLE fiTyp6 AS CHARACTER FORMAT "X(1)":U 
     VIEW-AS FILL-IN 
     SIZE 4 BY 1
     BGCOLOR 15 FONT 2 NO-UNDO.

DEFINE VARIABLE fiTyp7 AS CHARACTER FORMAT "X(1)":U 
     VIEW-AS FILL-IN 
     SIZE 4 BY 1
     BGCOLOR 15 FONT 2 NO-UNDO.

DEFINE VARIABLE fiTyp8 AS CHARACTER FORMAT "X(1)":U 
     VIEW-AS FILL-IN 
     SIZE 4 BY 1
     BGCOLOR 15 FONT 2 NO-UNDO.

DEFINE VARIABLE fiTyp9 AS CHARACTER FORMAT "X(1)":U 
     VIEW-AS FILL-IN 
     SIZE 4 BY 1
     BGCOLOR 15 FONT 2 NO-UNDO.

DEFINE VARIABLE raDetSum AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "Item 1", 1,
"Item 2", 2,
"Item 3", 3
     SIZE 35 BY 1.57
     BGCOLOR 19 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE RECTANGLE re11
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 86.5 BY 7.19
     BGCOLOR 8 FGCOLOR 0 .

DEFINE RECTANGLE re12
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 39.5 BY 6.43
     BGCOLOR 8 .

DEFINE RECTANGLE re13
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 86.5 BY 7.81
     BGCOLOR 8 .

DEFINE RECTANGLE re14
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 39.5 BY 6.52
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-407
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 39.5 BY 2.19
     BGCOLOR 8 .

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY brAcproc_fil FOR 
      acproc_fil SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE brAcproc_fil
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS brAcproc_fil wacr2001 _STRUCTURED
  QUERY brAcproc_fil NO-LOCK DISPLAY
      acproc_fil.asdat FORMAT "99/99/9999":U COLUMN-FONT 1 LABEL-FONT 1
      acproc_fil.type COLUMN-LABEL "Ty" FORMAT "X(2)":U
      acproc_fil.entdat COLUMN-LABEL "Process Date" FORMAT "99/99/9999":U
      acproc_fil.enttim COLUMN-LABEL "Time" FORMAT "X(8)":U
      SUBSTRING (acproc_fil.enttim,10,3) COLUMN-LABEL "Sta" FORMAT "X(1)":U
      acproc_fil.trndatfr COLUMN-LABEL "TranDate Fr" FORMAT "99/99/9999":U
      acproc_fil.trndatto COLUMN-LABEL "TranDate To" FORMAT "99/99/9999":U
      acproc_fil.typdesc FORMAT "X(60)":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 84.5 BY 5
         BGCOLOR 15 FGCOLOR 0 FONT 1.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_Command
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 24
         BGCOLOR 19 .

DEFINE FRAME frMain
     "AGING REPORT FOR INWARD / OUTWARD":210 VIEW-AS TEXT
          SIZE 57.5 BY .95 AT ROW 1.33 COL 42.5
          BGCOLOR 3 FGCOLOR 7 FONT 23
     RECT-405 AT ROW 1 COL 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         NO-LABELS SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 2 ROW 1.14
         SIZE 131 BY 23.67
         BGCOLOR 3 .

DEFINE FRAME frOutput
     rsOutput AT ROW 2.19 COL 2.83 NO-LABEL
     ra_balos AT ROW 2.19 COL 83.5 NO-LABEL
     to_aviva AT ROW 2.43 COL 31
     cbPrtList AT ROW 3.86 COL 29 COLON-ALIGNED NO-LABEL
     fiFile-Name AT ROW 5.05 COL 29 COLON-ALIGNED NO-LABEL
     " BALANCE O/S FOR OUTWARD" VIEW-AS TEXT
          SIZE 32.5 BY 1 AT ROW 1 COL 75.5
          BGCOLOR 1 FGCOLOR 15 FONT 6
     " OUTPUT TO:":40 VIEW-AS TEXT
          SIZE 72.5 BY 1 TOOLTIP "การแสดงผล" AT ROW 1 COL 2
          BGCOLOR 1 FGCOLOR 15 FONT 6
     RECT-306 AT ROW 2.05 COL 75.5
     RECT-406 AT ROW 2.05 COL 2
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE 
         AT COL 2 ROW 18.62
         SIZE 107 BY 5.71
         BGCOLOR 19 .

DEFINE FRAME frOK
     Btn_OK AT ROW 1.91 COL 3.5
     Btn_Cancel AT ROW 4.52 COL 3.67
     RECT-3 AT ROW 3.86 COL 1.67
     RECT2 AT ROW 1.24 COL 1.67
    WITH DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 110 ROW 18.62
         SIZE 21 BY 5.67
         BGCOLOR 19 .

DEFINE FRAME frST
     but_Search AT ROW 14.81 COL 91
     fiBranch AT ROW 1.57 COL 20.5 COLON-ALIGNED NO-LABEL
     fiBranch2 AT ROW 2.62 COL 20.5 COLON-ALIGNED NO-LABEL
     fiPolTypFr AT ROW 3.86 COL 20.5 COLON-ALIGNED NO-LABEL
     fiPolTypTo AT ROW 4.91 COL 20.5 COLON-ALIGNED NO-LABEL
     fiacno1 AT ROW 6.1 COL 20.5 COLON-ALIGNED NO-LABEL
     fiacno2 AT ROW 7.14 COL 20.5 COLON-ALIGNED NO-LABEL
     fiasdatAging AT ROW 9.86 COL 20.5 COLON-ALIGNED
     buBranch AT ROW 1.62 COL 28.67
     buBranch2 AT ROW 2.67 COL 28.67
     buPoltypFr AT ROW 3.91 COL 28.67
     buPoltypTo AT ROW 5 COL 28.67
     buAcno2 AT ROW 7.19 COL 37.83
     coRptTyp AT ROW 2.71 COL 95.33 COLON-ALIGNED
     raDetSum AT ROW 5.57 COL 91.33 NO-LABEL
     brAcproc_fil AT ROW 11.1 COL 3.5
     fiTyp1 AT ROW 9.14 COL 95.33 COLON-ALIGNED NO-LABEL
     fiTyp2 AT ROW 9.14 COL 100.33 COLON-ALIGNED NO-LABEL
     fiTyp3 AT ROW 9.14 COL 105.33 COLON-ALIGNED NO-LABEL
     fiTyp4 AT ROW 9.14 COL 110.33 COLON-ALIGNED NO-LABEL
     fiTyp5 AT ROW 9.14 COL 115.33 COLON-ALIGNED NO-LABEL
     fiTyp6 AT ROW 10.43 COL 95.33 COLON-ALIGNED NO-LABEL
     fiTyp7 AT ROW 10.43 COL 100.33 COLON-ALIGNED NO-LABEL
     fiTyp8 AT ROW 10.43 COL 105.33 COLON-ALIGNED NO-LABEL
     fiTyp9 AT ROW 10.43 COL 110.33 COLON-ALIGNED NO-LABEL
     fiTyp10 AT ROW 10.43 COL 115.33 COLON-ALIGNED NO-LABEL
     fiTyp11 AT ROW 11.76 COL 95.33 COLON-ALIGNED NO-LABEL
     fiTyp12 AT ROW 11.76 COL 100.33 COLON-ALIGNED NO-LABEL
     fiTyp13 AT ROW 11.76 COL 105.33 COLON-ALIGNED NO-LABEL
     fiTyp14 AT ROW 11.76 COL 110.33 COLON-ALIGNED NO-LABEL
     fiTyp15 AT ROW 11.76 COL 115.33 COLON-ALIGNED NO-LABEL
     buAcno1 AT ROW 6.14 COL 37.83
     fibdes AT ROW 1.62 COL 31 COLON-ALIGNED NO-LABEL
     fibdes2 AT ROW 2.67 COL 31 COLON-ALIGNED NO-LABEL
     fiPoldesFr AT ROW 3.86 COL 31 COLON-ALIGNED NO-LABEL
     fiPoldesTo AT ROW 5.1 COL 31 COLON-ALIGNED NO-LABEL
     finame1 AT ROW 6.14 COL 40 COLON-ALIGNED
     finame2 AT ROW 7.19 COL 40 COLON-ALIGNED NO-LABEL
     fiInclude AT ROW 7.91 COL 108.17 COLON-ALIGNED
     fiAsdat AT ROW 8.76 COL 20.5 COLON-ALIGNED
     fiProcessDate AT ROW 8.76 COL 51.5 COLON-ALIGNED NO-LABEL
     fiProcess AT ROW 13.05 COL 92.33
     "PRODUCER FROM":100 VIEW-AS TEXT
          SIZE 18.33 BY .95 TOOLTIP "Account No. From" AT ROW 6.1 COL 3.67
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "  TYPE OF REPORTS" VIEW-AS TEXT
          SIZE 38 BY 1 AT ROW 4.33 COL 90.17
          BGCOLOR 1 FGCOLOR 7 
     "BY" VIEW-AS TEXT
          SIZE 3.5 BY 1 AT ROW 2.71 COL 93.33
          BGCOLOR 8 FGCOLOR 1 FONT 6
     " ASDATE PROCESS":30 VIEW-AS TEXT
          SIZE 19.5 BY 1 AT ROW 8.76 COL 3
          BGCOLOR 1 FGCOLOR 7 
     " ASDATE OF CAL.":30 VIEW-AS TEXT
          SIZE 19.5 BY 1 AT ROW 9.86 COL 3
          BGCOLOR 1 FGCOLOR 7 
     " INCLUDE TYPE ALL":50 VIEW-AS TEXT
          SIZE 19.83 BY 1 AT ROW 7.91 COL 90.33
          BGCOLOR 1 FGCOLOR 7 
     " PROCESS DATA":30 VIEW-AS TEXT
          SIZE 16.5 BY 1 TOOLTIP "วันที่ออกรายงาน" AT ROW 8.76 COL 36.83
          BGCOLOR 1 FGCOLOR 7 
     "POL. TYPE FROM":50 VIEW-AS TEXT
          SIZE 18.5 BY .95 TOOLTIP "ตั้งแต่สาขา" AT ROW 3.76 COL 4
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "TO":20 VIEW-AS TEXT
          SIZE 3.33 BY .95 TOOLTIP "รหัสตัวแทนถึง" AT ROW 7.29 COL 18.67
          BGCOLOR 8 FGCOLOR 1 FONT 6
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         NO-LABELS SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1.83 ROW 2.67
         SIZE 129.67 BY 15.81
         BGCOLOR 19 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME frST
     "  TYPE OF SEARCH":50 VIEW-AS TEXT
          SIZE 37.83 BY 1 AT ROW 1.43 COL 90.17
          BGCOLOR 1 FGCOLOR 7 
     "Ageing = 31/01/YYYY, Statement = Process Date" VIEW-AS TEXT
          SIZE 48 BY 1 TOOLTIP "Ageing = วันที่วันสุดท้ายของเดือน/ Statement = วันที่ ณ วันที่ Process data" AT ROW 9.81 COL 37.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "BRANCH FROM":30 VIEW-AS TEXT
          SIZE 16.5 BY .95 TOOLTIP "ตั้งแต่สาขา" AT ROW 1.67 COL 6
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "TO":10 VIEW-AS TEXT
          SIZE 4 BY .95 TOOLTIP "ถึงสาขา" AT ROW 2.62 COL 18
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "TO":10 VIEW-AS TEXT
          SIZE 4 BY .95 TOOLTIP "ถึงสาขา" AT ROW 4.91 COL 18.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     re11 AT ROW 1.29 COL 2.33
     re12 AT ROW 1.24 COL 89.67
     re13 AT ROW 8.62 COL 2.33
     re14 AT ROW 7.67 COL 89.67
     RECT-407 AT ROW 14.24 COL 89.67
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         NO-LABELS SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1.83 ROW 2.67
         SIZE 129.67 BY 15.81
         BGCOLOR 19 .


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
  CREATE WINDOW wacr2001 ASSIGN
         HIDDEN             = YES
         TITLE              = "wacr2001 - Aging Report For Inward & Outward"
         HEIGHT             = 24
         WIDTH              = 133.5
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
IF NOT wacr2001:LOAD-ICON("wimage/safety.ico":U) THEN
    MESSAGE "Unable to load icon: wimage/safety.ico"
            VIEW-AS ALERT-BOX WARNING BUTTONS OK.
&ENDIF
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW wacr2001
  VISIBLE,,RUN-PERSISTENT                                               */
/* REPARENT FRAME */
ASSIGN FRAME frMain:FRAME = FRAME fr_Command:HANDLE
       FRAME frOK:FRAME = FRAME frMain:HANDLE
       FRAME frOutput:FRAME = FRAME frMain:HANDLE
       FRAME frST:FRAME = FRAME frMain:HANDLE.

/* SETTINGS FOR FRAME frMain
   FRAME-NAME Custom                                                    */

DEFINE VARIABLE XXTABVALXX AS LOGICAL NO-UNDO.

ASSIGN XXTABVALXX = FRAME frOutput:MOVE-BEFORE-TAB-ITEM (FRAME frST:HANDLE)
/* END-ASSIGN-TABS */.

/* SETTINGS FOR FRAME frOK
                                                                        */
ASSIGN 
       FRAME frOK:SCROLLABLE       = FALSE.

/* SETTINGS FOR FRAME frOutput
                                                                        */
/* SETTINGS FOR FRAME frST
   Custom                                                               */
/* BROWSE-TAB brAcproc_fil raDetSum frST */
/* SETTINGS FOR COMBO-BOX coRptTyp IN FRAME frST
   LABEL "Combo 1:"                                                     */
/* SETTINGS FOR FILL-IN fiAsdat IN FRAME frST
   LABEL "Fill 1:"                                                      */
/* SETTINGS FOR FILL-IN fiasdatAging IN FRAME frST
   LABEL "Fill 1:"                                                      */
/* SETTINGS FOR FILL-IN fiInclude IN FRAME frST
   LABEL "Fill 1:"                                                      */
/* SETTINGS FOR FILL-IN finame1 IN FRAME frST
   LABEL ":"                                                            */
/* SETTINGS FOR FILL-IN fiProcess IN FRAME frST
   ALIGN-L LABEL "fiProcess:"                                           */
ASSIGN 
       fiProcess:HIDDEN IN FRAME frST           = TRUE.

/* SETTINGS FOR FRAME fr_Command
                                                                        */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(wacr2001)
THEN wacr2001:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE brAcproc_fil
/* Query rebuild information for BROWSE brAcproc_fil
     _TblList          = "sicfn.acproc_fil"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _FldNameList[1]   > sicfn.acproc_fil.asdat
"acproc_fil.asdat" ? ? "date" ? ? 1 ? ? 1 no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[2]   > sicfn.acproc_fil.type
"acproc_fil.type" "Ty" ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   > sicfn.acproc_fil.entdat
"acproc_fil.entdat" "Process Date" ? "date" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   > sicfn.acproc_fil.enttim
"acproc_fil.enttim" "Time" ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   > "_<CALC>"
"SUBSTRING (acproc_fil.enttim,10,3)" "Sta" "X(1)" ? ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[6]   > sicfn.acproc_fil.trndatfr
"acproc_fil.trndatfr" "TranDate Fr" ? "date" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[7]   > sicfn.acproc_fil.trndatto
"acproc_fil.trndatto" "TranDate To" ? "date" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[8]   > sicfn.acproc_fil.typdesc
"acproc_fil.typdesc" ? "X(60)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _Query            is NOT OPENED
*/  /* BROWSE brAcproc_fil */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME wacr2001
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wacr2001 wacr2001
ON END-ERROR OF wacr2001 /* wacr2001 - Aging Report For Inward  Outward */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wacr2001 wacr2001
ON WINDOW-CLOSE OF wacr2001 /* wacr2001 - Aging Report For Inward  Outward */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME brAcproc_fil
&Scoped-define FRAME-NAME frST
&Scoped-define SELF-NAME brAcproc_fil
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brAcproc_fil wacr2001
ON MOUSE-SELECT-CLICK OF brAcproc_fil IN FRAME frST
DO:
   DO WITH FRAME frST:
        IF NOT CAN-FIND(FIRST acproc_fil WHERE (acproc_fil.type = "07")  OR
                                               (acproc_fil.TYPE = "08")) THEN DO:
            ASSIGN
                fiasdat       = ?
                fiProcessdate = ?
                n_trndatfr    = ?
                n_trndatto    = ?
                n_processdate = ?
                n_asdat       = fiasdat
                nv_reptyp     = "" .
            DISP fiasdat fiProcessdate.
        END.
        ELSE DO:
            FIND CURRENT acproc_fil NO-LOCK.
            ASSIGN
                fiasdat       = acproc_fil.asdat
                fiProcessdate = acproc_fil.entdat
                n_trndatfr    = acproc_fil.trndatfr
                n_trndatto    = acproc_fil.trndatto
                n_processdate = acproc_fil.entdat                
                n_asdat       = fiasdat
                nv_reptyp     = acproc_fil.TYPE.

            DISP fiasdat fiProcessdate.
            /*---A50-0218---*/
            IF acproc_fil.TYPE = "07" THEN DO :
                DISABLE ra_balos WITH FRAME frOutput.
                /*---A51-0124---*/
                ASSIGN fiTyp1 = "O"
                       fiTyp2 = "T"
                       fiTyp3= ""
                       fiTyp4 = "".
                DISP fiTyp1 fiTyp2 fiTyp3 fiTyp4 WITH FRAME frST.
                /*--------------*/
            END.
            ELSE DO: 
                IF to_aviva = NO THEN ENABLE ra_balos WITH FRAME frOutput.
                /*---A51-0124---*/
                ASSIGN fiTyp1 = "U"
                       fiTyp2 = "P"
                       fiTyp3 = ""
                       fiTyp4 = "".
                DISP fiTyp1 fiTyp2 fiTyp3 fiTyp4 WITH FRAME frST.
                /*--------------*/
            END.
            APPLY "ENTRY" TO fiasdatAging IN FRAME {&FRAME-NAME}.
            /*--------------*/
        END.
    END. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brAcproc_fil wacr2001
ON RETURN OF brAcproc_fil IN FRAME frST
DO:
    APPLY "VALUE-CHANGED" TO brAcproc_fil.
    APPLY "ENTRY" TO fiasdatAging IN FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brAcproc_fil wacr2001
ON VALUE-CHANGED OF brAcproc_fil IN FRAME frST
DO:
       IF n_frac  = "" THEN n_frac = "0D00000".   /*A51-0124*/
       IF n_toac  = "" THEN n_toac = "0FZZZZZZZZ".
    DO WITH FRAME frST:
        IF NOT CAN-FIND(FIRST acproc_fil WHERE (acproc_fil.type = "07")  OR
                                               (acproc_fil.TYPE = "08")) THEN DO:
            ASSIGN
                fiasdat       = ?
                fiProcessdate = ?
                n_trndatfr    = ?
                n_trndatto    = ?
                n_processdate = ?
                n_asdat       = fiasdat
                nv_reptyp     = "" .
            DISP fiasdat fiProcessdate.
        END.
        ELSE DO:
            IF acproc_fil.TYPE = "07" THEN  nv_trntyp1 = "O,T".
            IF acproc_fil.TYPE = "08" THEN  nv_trntyp1 = "U,P".
            FIND CURRENT acproc_fil NO-LOCK.
            ASSIGN
                fiasdat       = acproc_fil.asdat
                fiProcessdate = acproc_fil.entdat
                n_trndatfr    = acproc_fil.trndatfr
                n_trndatto    = acproc_fil.trndatto
                n_processdate = acproc_fil.entdat                
                n_asdat       = fiasdat
                nv_reptyp     = acproc_fil.TYPE.
             /*i = 0.                                        */
             nv_i1 = 0.
             nv_i2 = 0.
             nv_i3 = 0.            
             IF acproc_fil.TYPE = "08" THEN DO:
                 FOR EACH  agtprm_fil USE-INDEX by_acno WHERE
                           agtprm_fil.asdat  =  acproc_fil.asdat AND
                           agtprm_fil.poldes <> ""   AND
                          (LOOKUP(SUBSTR(agtprm_fil.trntyp,1,1) , nv_trntyp1) <> 0 ).
                           IF agtprm_fil.poldes  = "O/S = 0" THEN nv_i1  = nv_i1 + 1.
                           IF agtprm_fil.poldes  = "O/S < 0" THEN nv_i2  = nv_i2 + 1.
                           IF agtprm_fil.poldes  = "O/S > 0" THEN nv_i3  = nv_i3 + 1.
                 END.
             END.    
            DISP fiasdat fiProcessdate.
            /*---A50-0218---*/
            IF acproc_fil.TYPE = "07" THEN DO :
                DISABLE ra_balos WITH FRAME frOutput.
                /*---A51-0124---*/
                ASSIGN fiTyp1 = "O"
                       fiTyp2 = "T"
                       fiTyp3 = ""
                       fiTyp4 = "".
                DISP fiTyp1 fiTyp2 fiTyp3 fiTyp4 WITH FRAME frST.
                /*--------------*/
            END.
            ELSE DO:   
                ENABLE ra_balos WITH FRAME frOutput.
                /*---A51-0124---*/
                ASSIGN fiTyp1 = "U"
                       fiTyp2 = "P"
                       fiTyp3 = ""
                       fiTyp4 = "".
                DISP fiTyp1 fiTyp2 fiTyp3 fiTyp4 WITH FRAME frST.
                /*--------------*/
            END.
            APPLY "ENTRY" TO fiasdatAging IN FRAME {&FRAME-NAME}.
            /*--------------*/
        END.
    END. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frOK
&Scoped-define SELF-NAME Btn_Cancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_Cancel wacr2001
ON CHOOSE OF Btn_Cancel IN FRAME frOK /* CANCEL */
DO:
    Apply "Close" To This-Procedure.
    Return No-Apply.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_OK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_OK wacr2001
ON CHOOSE OF Btn_OK IN FRAME frOK /* OK */
DO:
/*-----------A50-0218
    DEF VAR nv_filter1  AS CHAR INIT "".
    DEF VAR nv_filter2  AS CHAR INIT "".
----------------------*/
DEF VAR vAcno       AS CHAR INIT "".
   DO WITH FRAME {&FRAME-NAME} :
      ASSIGN  
            FRAME frST fibranch     fibranch
            FRAME frST fibranch2    fibranch2
            FRAME frST fiacno1      fiacno1
            FRAME frST fiacno2      fiacno2
            FRAME frST fipoltypFr   fipoltypFr
            FRAME frST fipoltypTo   fipoltypTo
            FRAME frST coRptTyp     coRptTyp

            FRAME frST fiAsdat      fiAsdat
            FRAME frST fityp1       fityp1
            FRAME frST fityp2       fityp2
            FRAME frST fityp3       fityp3
            FRAME frST fityp4       fityp4
            FRAME frST fityp5       fityp5
            FRAME frST fityp6       fityp6
            FRAME frST fityp7       fityp7
            FRAME frST fityp8       fityp8
            FRAME frST fityp9       fityp9
            FRAME frST fityp10      fityp10
            FRAME frST fityp11      fityp11
            FRAME frST fityp12      fityp12
            FRAME frST fityp13      fityp13
            FRAME frST fityp14      fityp14
            FRAME frST fityp15      fityp15
            
            FRAME frOutput rsOutput    rsOutput
            FRAME frOutput fiFile-Name fiFile-Name
            FRAME frOutput cbPrtList cbPrtList /*--Lukkana M. A52-0241 26/10/2009--*/

            n_branch   =  fiBranch
            n_branch2  =  fiBranch2
            n_frac     =  fiAcno1
            n_toac     =  fiAcno2 
            n_asdat    =  fiasdat /* DATE( INPUT cbAsDat) */
            
            n_OutputTo      =  rsOutput
            n_OutputFile    =  INPUT fiFile-Name
            n_OutputFileSum =  n_OutputFile + "Sum"
            n_OutputFileNet =  n_OutputFile + "Net"   /*A50-0218*/
            n_OutputFileNzi =  n_Outputfile + "NZI"   /* add by Phaiboon W. [A59-0125] 01/04/2016 */
            n_OutputFileAvi =  n_OutputFile + "Avi"   /* add by Phaiboon W. [A59-0164] 11/05/2016 */

            RB-PRINTER-NAME =   Input  cbPrtList /*Lukkana M. A52-0241 26/10/2009*/
             
            nv_poltypFr =  fipoltypFr
            nv_poltypTo =  fipoltypTo
            nv_RptName  =  coRptTyp
                          
            nv_typ1     =  fityp1
            nv_typ2     =  fityp2
            nv_typ3     =  fityp3
            nv_typ4     =  fityp4
            nv_typ5     =  fityp5
            nv_typ6     =  fityp6
            nv_typ7     =  fityp7
            nv_typ8     =  fityp8
            nv_typ9     =  fityp9
            nv_typ10    =  fityp10
            nv_typ11    =  fityp11
            nv_typ12    =  fityp12
            nv_typ13    =  fityp13
            nv_typ14    =  fityp14
            nv_typ15    =  fityp15

        /*--- disp trntyp ที่ระบุ ---*/
            nv_trntyp1 = IF fityp1 <> "" THEN fityp1 ELSE ""
            nv_trntyp1 = IF fityp2 <> "" THEN nv_trntyp1 + "," + fityp2 ELSE nv_trntyp1
            nv_trntyp1 = IF fityp3 <> "" THEN nv_trntyp1 + "," + fityp3 ELSE nv_trntyp1
            nv_trntyp1 = IF fityp4 <> "" THEN nv_trntyp1 + "," + fityp4 ELSE nv_trntyp1
            nv_trntyp1 = IF fityp5 <> "" THEN nv_trntyp1 + "," + fityp5 ELSE nv_trntyp1
            nv_trntyp1 = IF fityp6 <> "" THEN nv_trntyp1 + "," + fityp6 ELSE nv_trntyp1
            nv_trntyp1 = IF fityp7 <> "" THEN nv_trntyp1 + "," + fityp7 ELSE nv_trntyp1
            nv_trntyp1 = IF fityp8 <> "" THEN nv_trntyp1 + "," + fityp8 ELSE nv_trntyp1
            nv_trntyp1 = IF fityp9 <> "" THEN nv_trntyp1 + "," + fityp9 ELSE nv_trntyp1
            nv_trntyp1 = IF fityp10 <> "" THEN nv_trntyp1 + "," + fityp10 ELSE nv_trntyp1
            nv_trntyp1 = IF fityp11 <> "" THEN nv_trntyp1 + "," + fityp11 ELSE nv_trntyp1
            nv_trntyp1 = IF fityp12 <> "" THEN nv_trntyp1 + "," + fityp12 ELSE nv_trntyp1
            nv_trntyp1 = IF fityp13 <> "" THEN nv_trntyp1 + "," + fityp13 ELSE nv_trntyp1
            nv_trntyp1 = IF fityp14 <> "" THEN nv_trntyp1 + "," + fityp14 ELSE nv_trntyp1
            nv_trntyp1 = IF fityp15 <> "" THEN nv_trntyp1 + "," + fityp15 ELSE nv_trntyp1.           

        ASSIGN  /* เงื่อนไขที่ไว้ดึงข้อมูล*/
            nv_filter1 = IF fityp1 <> "" THEN "(agtprm_fil.trntyp BEGINS '" + fityp1 + "') "  ELSE ""
            nv_filter1 = IF fityp2 <> "" THEN nv_filter1 + " OR (agtprm_fil.trntyp BEGINS '" + fityp2 + "') "  ELSE nv_filter1
            nv_filter1 = IF fityp3 <> "" THEN nv_filter1 + " OR (agtprm_fil.trntyp BEGINS '" + fityp3 + "') "  ELSE nv_filter1
            nv_filter1 = IF fityp4 <> "" THEN nv_filter1 + " OR (agtprm_fil.trntyp BEGINS '" + fityp4 + "') "  ELSE nv_filter1
            nv_filter1 = IF fityp5 <> "" THEN nv_filter1 + " OR (agtprm_fil.trntyp BEGINS '" + fityp5 + "') "  ELSE nv_filter1
            nv_filter1 = IF fityp6 <> "" THEN nv_filter1 + " OR (agtprm_fil.trntyp BEGINS '" + fityp6 + "') "  ELSE nv_filter1
            nv_filter1 = IF fityp7 <> "" THEN nv_filter1 + " OR (agtprm_fil.trntyp BEGINS '" + fityp7 + "') "  ELSE nv_filter1
            nv_filter1 = IF fityp8 <> "" THEN nv_filter1 + " OR (agtprm_fil.trntyp BEGINS '" + fityp8 + "') "  ELSE nv_filter1
            nv_filter1 = IF fityp9 <> "" THEN nv_filter1 + " OR (agtprm_fil.trntyp BEGINS '" + fityp9 + "') "  ELSE nv_filter1
            nv_filter1 = IF fityp10 <> "" THEN nv_filter1 + " OR (agtprm_fil.trntyp BEGINS '" + fityp10 + "') "  ELSE nv_filter1
            nv_filter1 = IF fityp11 <> "" THEN nv_filter1 + " OR (agtprm_fil.trntyp BEGINS '" + fityp11 + "') "  ELSE nv_filter1
            nv_filter1 = IF fityp12 <> "" THEN nv_filter1 + " OR (agtprm_fil.trntyp BEGINS '" + fityp12 + "') "  ELSE nv_filter1
            nv_filter1 = IF fityp13 <> "" THEN nv_filter1 + " OR (agtprm_fil.trntyp BEGINS '" + fityp13 + "') "  ELSE nv_filter1
            nv_filter1 = IF fityp14 <> "" THEN nv_filter1 + " OR (agtprm_fil.trntyp BEGINS '" + fityp14 + "') "  ELSE nv_filter1
            nv_filter1 = IF fityp15 <> "" THEN nv_filter1 + " OR (agtprm_fil.trntyp BEGINS '" + fityp15 + "') "  ELSE nv_filter1.
    
   END.
       
/*    IF  n_frac = "" THEN  n_frac = "0D00000". */
/*    IF  n_toac = "" THEN  n_toac = "BZZZZZZ". */
   
   nv_poltypFr  = IF nv_poltypFr = "" THEN ""   ELSE SUBSTR(nv_poltypFr,2,2).
   nv_poltypTo  = IF nv_poltypTo = "" THEN "99" ELSE SUBSTR(nv_poltypTo,2,2).

   /*------ A48-0113 ------*/
   IF nv_reptyp = "07" THEN DO:
       ASSIGN nv_repdes  = "Inward"
              nv_trntyp1 = "O,T".
       IF n_frac  = "" THEN n_frac = "0D00000" .   /*A51-0124*/
       IF n_toac  = "" THEN n_toac = "0FZZZZZZZZ" .
       /*--- A500178 ----------------
       /*-----A48-0241-----*/
       IF n_frac  = "" THEN n_frac = "0D00000".
       IF n_toac  = "" THEN n_toac = "AZZZZZZ".
       /*-----A48-0241-----*/     
       ----------- END A500178 ----*/
       /*-----A48-0241-----
       n_frac    = "A000000".   /*-- A48-0168 --*/
       n_toac    = "BZZZZZZ".
       -----A48-0241-----*/
   END.
   ELSE DO:
       ASSIGN nv_repdes  = "Outward"
              nv_trntyp1 = "U,P".
       IF n_frac  = "" THEN n_frac = "0D00000".   /*A51-0124*/
       IF n_toac  = "" THEN n_toac = "0FZZZZZZZZ".
       /*--- A500178 ---
       IF n_frac  = "" THEN n_frac = "0D00000".
       IF n_toac  = "" THEN n_toac = "0FZZZZZ".
       ------*/
   END.
   /*---- END A48-0113 ----*/
   IF (n_branch > n_branch2)  THEN DO:
         MESSAGE "ข้อมูลรหัสสาขาผิดพลาด" SKIP
                 "รหัสสาขาเริ่มต้นต้องมากกว่ารหัสสุดท้าย" VIEW-AS ALERT-BOX WARNING . 
         APPLY "Entry" TO fibranch.
         RETURN NO-APPLY.       
   END.
   IF (n_frac > n_toac)   THEN DO:
         MESSAGE "ข้อมูลตัวแทนผิดพลาด" SKIP
                 "รหัสตัวแทนเริ่มต้นต้องมากกว่ารหัสสุดท้าย" VIEW-AS ALERT-BOX WARNING . 
         APPLY "Entry" TO fiacno1  .
         RETURN NO-APPLY.       
   END.
   IF nv_asdatAging = ? THEN DO:
         MESSAGE  "กรุณาใส่ Asdate for Aging "  SKIP (1)
                  "Asdate for Aging  <=  Process Date " VIEW-AS ALERT-BOX ERROR.
         APPLY "Entry" TO  fiasdatAging .
         RETURN NO-APPLY.
   END.
   IF n_asdat = ?   THEN DO:
         MESSAGE "ไม่พบข้อมูล  กรุณาตรวจสอบการ Process ข้อมูล" VIEW-AS ALERT-BOX WARNING.
   END.
   ELSE DO:
        MESSAGE "สาขา                      : "  n_Branch " ถึง " n_Branch2 SKIP(1)
                 "ตัวแทน/นายหน้า   : "  n_frac " ถึง " n_toac  SKIP(1)
                 "Policy Type           : " nv_poltypFr " ถึง " nv_poltypTo SKIP(1)
                 "Report Type           : " nv_repdes "(" nv_reptyp ")"  SKIP(1)
                 "Include Type         : " nv_trntyp1 SKIP(1)
                 "Asdate for ST(A4)  : " STRING(n_asdat,"99/99/9999") SKIP(1)
                 "Asdate for Aging    : "  STRING(nv_asdatAging,"99/99/9999") SKIP(1)
                 "Report Name          : " nv_RptName + " " + nv_RptName2
                 "   (" + nv_DetSum + ")"
        VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO
        TITLE "Confirm"   UPDATE CHOICE AS LOGICAL.
        CASE CHOICE:
        WHEN TRUE THEN DO:             
            /*-----By A50-0218-----*/
            ASSIGN  nv_user   =   n_user
                    nv_pwd    =   n_passwd
                    vFirstTime =  STRING(TIME, "HH:MM AM").
            IF rsOutput = 3 THEN DO:   /* to excel  for FN*/  
                IF n_OutputFile = ""    THEN DO:  /* n_OutputTo = 3 And */                    
                    MESSAGE "กรุณาใส่ชื่อไฟล์" VIEW-AS ALERT-BOX WARNING . 
                    APPLY "Entry" TO  fiFile-Name .
                    RETURN NO-APPLY.
                END.                                          
                IF nv_RptName  = "Acno" THEN DO:
                    IF to_aviva = YES THEN  /* add by Phaiboon W. [A59-0164] 11/05/2016 */
                        RUN pdAviva.
                    ELSE DO:             
                        IF nv_reptyp = "07" THEN  /* AgingInward */
                              RUN pdAcnoDet07.
                        ELSE DO: 
                             IF nv_ostyp = "O/S > 0" THEN 
                                RUN pdAcnoDet081.      /* AgingOutward O/S > 0*/
                            ELSE IF nv_ostyp = "O/S = 0" THEN 
                                RUN pdAcnoDet082.      /* AgingOutward O/S = 0*/
                            ELSE IF nv_ostyp = "O/S <= 0" THEN 
                                RUN pdAcnoDet083.      /* AgingOutward O/S < 0*/
                            ELSE 
                                RUN pdAcnoDet08.      /* AgingOutward O/S All */
                         END.
                     END.
                END.
            END.
            ELSE DO:                    /* to Report Builder or Printer */
                IF nv_RptName  = "Acno" THEN DO:
                    IF nv_reptyp = "07" THEN DO:
                       IF rsOutput = 1 THEN DO: 
                          RUN ProcRBInward.
                          /*RUN rbAcnoDet07.*/
                       END.
                       /*ELSE RUN pdAcnoDet07. Lukkana M. A52-0241 26/10/2009*/
                       ELSE RUN ProcRBInward. /*Lukkana M. A52-0241 26/10/2009 แก้ไขให้ปริ้นได้*/
                    END.
                    ELSE DO: /*--Outword--*/
                       IF rsOutput = 1 THEN DO: 
                          RUN ProcRBOutward.
                       END.
                       /*ELSE RUN pdAcnoDet08.  Lukkana M. A52-0241 26/10/2009*/
                       ELSE RUN ProcRBOutward. /*Lukkana M. A52-0241 26/10/2009 แก้ไขให้ปริ้นได้*/
                    END.
                END.
            END.
            /*IF rsOutput = 3 THEN DO:   /* to excel  for FN*/
                 IF n_OutputFile = ""    THEN DO:  /* n_OutputTo = 3 And */
                    MESSAGE "กรุณาใส่ชื่อไฟล์" VIEW-AS ALERT-BOX WARNING . 
                    APPLY "Entry" TO  fiFile-Name .
                    RETURN NO-APPLY.
                 END.
                 IF nv_RptName  = "Acno" THEN DO:
                     IF nv_reptyp = "07" THEN
                          RUN pdAcnoDet07.
                     ELSE RUN pdAcnoDet08.
                 END.*/

            DISP "" @ fiProcess WITH FRAME  frST.
            vLastTime =  STRING(TIME, "HH:MM AM").

            MESSAGE "As of Date     : " STRING(n_asdat,"99/99/9999")  SKIP (1)
                    "ตัวแทน          : "  n_frac " ถึง " n_toac SKIP (1)
                    "เวลา  " vFirstTime "  -  " vLastTime   VIEW-AS ALERT-BOX INFORMATION.
        END.
        WHEN FALSE THEN DO:
             RETURN NO-APPLY.
        END.
        END CASE.
        /*-----By A50-0218-----*/        
   END.   /* IF  asdat  <> ? */
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frST
&Scoped-define SELF-NAME buAcno1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buAcno1 wacr2001
ON CHOOSE OF buAcno1 IN FRAME frST /* ... */
DO:
  n_chkname = "1". 
  RUN Whp\WhpAcno(INPUT-OUTPUT  n_name,INPUT-OUTPUT n_chkname).
  
  ASSIGN    
        fiacno1 = n_agent1
        finame1 = n_name.
       
  DISP fiacno1 finame1  WITH FRAME {&FRAME-NAME}.
 
  n_agent1 =  fiacno1.

  RETURN NO-APPLY.
 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buAcno2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buAcno2 wacr2001
ON CHOOSE OF buAcno2 IN FRAME frST /* ... */
DO:
  n_chkname = "2". 
  RUN Whp\WhpAcno(INPUT-OUTPUT  n_name,INPUT-OUTPUT n_chkname).
  
  ASSIGN    
        fiacno2 = n_agent2
        finame2 = n_name.
       
  DISP fiacno2 finame2 WITH FRAME {&FRAME-NAME}      .
   
  n_agent2 =  fiacno2 .
  
  RETURN NO-APPLY.
 
 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buBranch
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buBranch wacr2001
ON CHOOSE OF buBranch IN FRAME frST /* ... */
DO:
   n_chkBName = "1". 
  RUN Whp\Whpbran(INPUT-OUTPUT  n_bdes,INPUT-OUTPUT n_chkBName).
  
  ASSIGN    
        fibranch = n_branch
        fibdes   = n_bdes.
       
  DISP fibranch fibdes  WITH FRAME {&FRAME-NAME}      .
 
  n_branch =  fibranch .

  RETURN NO-APPLY.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buBranch2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buBranch2 wacr2001
ON CHOOSE OF buBranch2 IN FRAME frST /* ... */
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


&Scoped-define SELF-NAME buPoltypFr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buPoltypFr wacr2001
ON CHOOSE OF buPoltypFr IN FRAME frST /* ... */
DO:

  RUN Whp\WhpPolTy(INPUT-OUTPUT  n_poldes).
  
  ASSIGN    
        fipoltypFr = n_poltyp
        fipoldesFr = n_poldes.
       
  DISP fiPoltypFr fipoldesFr WITH FRAME {&Frame-Name}      .
 
  RETURN NO-APPLY.


END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buPoltypTo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buPoltypTo wacr2001
ON CHOOSE OF buPoltypTo IN FRAME frST /* ... */
DO:

  RUN Whp\WhpPolTy(INPUT-OUTPUT  n_poldes).
  
  ASSIGN    
        fipoltypTo = n_poltyp
        fipoldesTo = n_poldes.
       
  DISP fiPoltypTo fipoldesTo WITH FRAME {&Frame-Name}      .
 
  RETURN NO-APPLY.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME but_Search
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL but_Search wacr2001
ON CHOOSE OF but_Search IN FRAME frST /* Query by As Date Process */
DO:  
  RUN WAC\WACQ2001(n_asdat,nv_reptyp).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME coRptTyp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL coRptTyp wacr2001
ON RETURN OF coRptTyp IN FRAME frST /* Combo 1 */
DO:

    APPLY "ENTRY" TO raDetSum IN FRAME {&FRAME-NAME}.
    RETURN NO-APPLY.
       
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL coRptTyp wacr2001
ON VALUE-CHANGED OF coRptTyp IN FRAME frST /* Combo 1 */
DO:
    coRptTyp = INPUT coRptTyp.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiacno1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiacno1 wacr2001
ON LEAVE OF fiacno1 IN FRAME frST
DO:
    Assign
        fiacno1  = input fiacno1
        n_agent1 = fiacno1.
    
    DISP CAPS(fiacno1) @ fiacno1 WITH FRAME frST.
            
    IF Input  FiAcno1 <> "" Then Do :        
        FIND   xmm600 WHERE xmm600.acno = n_agent1  NO-ERROR.
        IF AVAILABLE xmm600 THEN DO:
              finame1:Screen-value IN FRAME {&FRAME-NAME} = xmm600.name.
        END.        
        ELSE DO:
              fiAcno1 = "".
              finame1:Screen-value IN FRAME {&FRAME-NAME} = "Not Found !".
              MESSAGE "ไม่พบข้อมูล" VIEW-AS ALERT-BOX  warning TITLE "Confirm" .
        END.
    End.    
    DISP CAPS (fiAcno1) @ fiAcno1 WITH FRAME frST.
    DISP CAPS (fiAcno1) @ fiAcno2 WITH FRAME frST.
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiacno1 wacr2001
ON RETURN OF fiacno1 IN FRAME frST
DO:
/*    Assign
 *   fiacno1 = input fiacno1
 *   n_agent1  = fiacno1.
 *   
 *     FIND   xmm600 WHERE xmm600.acno = n_agent1  NO-ERROR.
 *   IF AVAILABLE xmm600 THEN DO:
 *           fiabname1:Screen-value IN FRAME {&FRAME-NAME} = xmm600.abname.
 *   END.        
 *   ELSE DO:
 *           fiabname1:Screen-value IN FRAME {&FRAME-NAME} = "Not Found !".
 *           MESSAGE "ไม่พบข้อมูล" VIEW-AS ALERT-BOX  warning TITLE "Confirm" .
 *   END.*/

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiacno2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiacno2 wacr2001
ON LEAVE OF fiacno2 IN FRAME frST
DO:
    Assign
        fiacno2 = input fiacno2
        n_agent2  = fiacno2.

    DISP CAPS(fiacno2) @ fiacno2 WITH FRAME frST.        
        
    IF Input  FiAcno2 <> "" Then Do :        
        FIND   xmm600 WHERE xmm600.acno = n_agent2  NO-ERROR.
        IF AVAILABLE xmm600 THEN DO:
              finame2:Screen-value IN FRAME {&FRAME-NAME} = xmm600.name.
        END.        
        ELSE DO:
            ASSIGN fiAcno2 = ""
                   finame2:Screen-value IN FRAME {&FRAME-NAME} = "Not Found !".
            MESSAGE "ไม่พบข้อมูล" VIEW-AS ALERT-BOX  warning TITLE "Confirm" .
        END.
    END.
    DISP CAPS (fiAcno2) @ fiAcno2 WITH FRAME frST.
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiacno2 wacr2001
ON RETURN OF fiacno2 IN FRAME frST
DO:
/*      Assign
 *   fiacno2 = input fiacno2
 *   n_agent2  = fiacno2.
 *   
 *     FIND   xmm600 WHERE xmm600.acno = n_agent2  NO-ERROR.
 *   IF AVAILABLE xmm600 THEN DO:
 *           fiabname2:Screen-value IN FRAME {&FRAME-NAME} = xmm600.abname.
 *   END.        
 *   ELSE DO:
 *           fiabname2:Screen-value IN FRAME {&FRAME-NAME} = "Not Found !".
 *           MESSAGE "ไม่พบข้อมูล" VIEW-AS ALERT-BOX  warning TITLE "Confirm" .
 *   END.*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiasdatAging
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiasdatAging wacr2001
ON LEAVE OF fiasdatAging IN FRAME frST /* Fill 1 */
DO:
    fiasdatAging = INPUT fiasdatAging.
    nv_asdatAging = fiasdatAging.

    IF nv_asdatAging <> ? THEN DO:
        IF nv_asdatAging <= fiProcessdate THEN nv_asdatAging = fiasdatAging.
        ELSE DO:
            MESSAGE  "Invaild data ! "  SKIP (1)
                     "Asdate for Aging  > Process Date " VIEW-AS ALERT-BOX ERROR.
            ASSIGN
                nv_asdatAging =  ?
                fiasdatAging  = ?.
            DISP fiasdatAging WITH FRAME frST.
        END.
        
        /* Begin by Phaiboon W. [A59-0125] 05/014/2016 ---
        APPLY "ENTRY" TO coRptTyp IN FRAME {&FRAME-NAME}.
        RETURN NO-APPLY.    
        --- End by Phaiboon W. [A59-0125] 05/04/2016 */
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiasdatAging wacr2001
ON RETURN OF fiasdatAging IN FRAME frST /* Fill 1 */
DO:
      APPLY "ENTRY" TO fiFile-Name IN FRAME froutput.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiBranch
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiBranch wacr2001
ON LEAVE OF fiBranch IN FRAME frST
DO:
  ASSIGN
         fibranch = input fibranch
         n_branch = CAPS(fibranch).

    DISP n_branch @ fibranch WITH FRAME frST.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiBranch wacr2001
ON RETURN OF fiBranch IN FRAME frST
DO:
  Assign
    fibranch = input fibranch
    n_branch  = fibranch.
  
  FIND   xmm023 WHERE xmm023.branch = n_branch  NO-ERROR.
  IF AVAILABLE xmm023 THEN DO:
          fibdes:Screen-value IN FRAME {&FRAME-NAME} = xmm023.bdes.
  END.        
  ELSE DO:
          fibdes:Screen-value IN FRAME {&FRAME-NAME} = "Not Found !".
          MESSAGE "ไม่พบข้อมูล" VIEW-AS ALERT-BOX  warning TITLE "Confirm" .
  END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiBranch2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiBranch2 wacr2001
ON LEAVE OF fiBranch2 IN FRAME frST
DO:
     ASSIGN
         fibranch2 = input fibranch2
         n_branch2 = CAPS(fibranch2).
         
    DISP n_branch2 @ fibranch2 WITH FRAME frST.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiBranch2 wacr2001
ON RETURN OF fiBranch2 IN FRAME frST
DO:
  Assign
     fibranch2 = input fibranch2
     n_branch2  = fibranch2.
  
  FIND   xmm023 WHERE xmm023.branch = n_branch2  NO-ERROR.
  IF AVAILABLE xmm023 THEN DO:
          fibdes2:Screen-value IN FRAME {&FRAME-NAME} = xmm023.bdes.
  END.        
  ELSE DO:
          fibdes2:Screen-value IN FRAME {&FRAME-NAME} = "Not Found !".
          MESSAGE "ไม่พบข้อมูล" VIEW-AS ALERT-BOX  warning TITLE "Confirm" .
  END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frOutput
&Scoped-define SELF-NAME fiFile-Name
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiFile-Name wacr2001
ON RETURN OF fiFile-Name IN FRAME frOutput
DO:
          APPLY "ENTRY" TO btn_OK IN FRAME frOK.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frST
&Scoped-define SELF-NAME fiPolTypFr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiPolTypFr wacr2001
ON LEAVE OF fiPolTypFr IN FRAME frST
DO:

    ASSIGN
        fiPolTypFr = INPUT fiPolTypFr
        n_poltyp   = CAPS(fiPolTypFr).
        nv_poltypFr = n_poltyp.
    
    DISP n_poltyp @ fiPoltypFr n_poltyp @ fiPolTypTo WITH FRAME frST.
   
    IF n_PolTyp <> ""  THEN DO :
        FIND   xmm031 WHERE xmm031.poltyp = n_poltyp  NO-ERROR.
        IF AVAILABLE xmm031 THEN DO:
              fipoldesFr:Screen-value IN FRAME {&FRAME-NAME} = xmm031.poldes.
        END.        
        ELSE DO:
              fipoldesFr:Screen-value IN FRAME {&FRAME-NAME} = "Not Found !".
              MESSAGE "ไม่พบข้อมูล" VIEW-AS ALERT-BOX  warning TITLE "Confirm" .
        END.
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiPolTypTo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiPolTypTo wacr2001
ON LEAVE OF fiPolTypTo IN FRAME frST
DO:

    ASSIGN
        fiPolTypTo = INPUT fiPolTypTo
        n_poltyp   = CAPS(fiPolTypTo).
        nv_poltypto = n_poltyp.

    DISP n_poltyp @ fiPoltypTo  WITH FRAME frST. 
   
    IF n_PolTyp <> ""  THEN DO :
        FIND   xmm031 WHERE xmm031.poltyp = n_poltyp  NO-ERROR.
        IF AVAILABLE xmm031 THEN DO:
              fipoldesTo:Screen-value IN FRAME {&FRAME-NAME} = xmm031.poldes.
        END.        
        ELSE DO:
              fipoldesTo:Screen-value IN FRAME {&FRAME-NAME} = "Not Found !".
              MESSAGE "ไม่พบข้อมูล" VIEW-AS ALERT-BOX  warning TITLE "Confirm".
        END.
    END.
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiTyp1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiTyp1 wacr2001
ON LEAVE OF fiTyp1 IN FRAME frST
DO:
    fiTyp1 = CAPS(INPUT fiTyp1).
    DISP fiTyp1 WITH FRAME frST.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiTyp10
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiTyp10 wacr2001
ON LEAVE OF fiTyp10 IN FRAME frST
DO:
    fiTyp10 = CAPS(INPUT fiTyp10).
    DISP fiTyp10 WITH FRAME frST.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiTyp11
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiTyp11 wacr2001
ON LEAVE OF fiTyp11 IN FRAME frST
DO:
    fiTyp11 = CAPS(INPUT fiTyp11).
    DISP fiTyp11 WITH FRAME frST.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiTyp12
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiTyp12 wacr2001
ON LEAVE OF fiTyp12 IN FRAME frST
DO:
    fiTyp12 = CAPS(INPUT fiTyp12).
    DISP fiTyp12 WITH FRAME frST.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiTyp13
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiTyp13 wacr2001
ON LEAVE OF fiTyp13 IN FRAME frST
DO:
    fiTyp13 = CAPS(INPUT fiTyp13).
    DISP fiTyp13 WITH FRAME frST.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiTyp14
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiTyp14 wacr2001
ON LEAVE OF fiTyp14 IN FRAME frST
DO:
    fiTyp14 = CAPS(INPUT fiTyp14).
    DISP fiTyp14 WITH FRAME frST.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiTyp15
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiTyp15 wacr2001
ON LEAVE OF fiTyp15 IN FRAME frST
DO:
    fiTyp15 = CAPS(INPUT fiTyp15).
    DISP fiTyp15 WITH FRAME frST.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiTyp2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiTyp2 wacr2001
ON LEAVE OF fiTyp2 IN FRAME frST
DO:
    fiTyp2 = CAPS(INPUT fiTyp2).
    DISP fiTyp2 WITH FRAME frST.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiTyp3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiTyp3 wacr2001
ON LEAVE OF fiTyp3 IN FRAME frST
DO:
    fiTyp3 = CAPS(INPUT fiTyp3).
    DISP fiTyp3 WITH FRAME frST.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiTyp4
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiTyp4 wacr2001
ON LEAVE OF fiTyp4 IN FRAME frST
DO:
    fiTyp4 = CAPS(INPUT fiTyp4).
    DISP fiTyp4 WITH FRAME frST.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiTyp5
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiTyp5 wacr2001
ON LEAVE OF fiTyp5 IN FRAME frST
DO:
    fiTyp5 = CAPS(INPUT fiTyp5).
    DISP fiTyp5 WITH FRAME frST.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiTyp6
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiTyp6 wacr2001
ON LEAVE OF fiTyp6 IN FRAME frST
DO:
    fiTyp6 = CAPS(INPUT fiTyp6).
    DISP fiTyp6 WITH FRAME frST.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiTyp7
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiTyp7 wacr2001
ON LEAVE OF fiTyp7 IN FRAME frST
DO:
    fiTyp7 = CAPS(INPUT fiTyp7).
    DISP fiTyp7 WITH FRAME frST.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiTyp8
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiTyp8 wacr2001
ON LEAVE OF fiTyp8 IN FRAME frST
DO:
    fiTyp8 = CAPS(INPUT fiTyp8).
    DISP fiTyp8 WITH FRAME frST.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiTyp9
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiTyp9 wacr2001
ON LEAVE OF fiTyp9 IN FRAME frST
DO:
    fiTyp9 = CAPS(INPUT fiTyp9).
    DISP fiTyp9 WITH FRAME frST.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME raDetSum
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL raDetSum wacr2001
ON VALUE-CHANGED OF raDetSum IN FRAME frST
DO:
    raDetSum = INPUT raDetSum.
    nv_DetSum = IF raDetSum = 1 THEN "Detail" 
                                ELSE IF raDetSum =  2 THEN "Summary"
                                ELSE "All".
    APPLY "Entry" TO fiTyp1 IN FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frOutput
&Scoped-define SELF-NAME ra_balos
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_balos wacr2001
ON VALUE-CHANGED OF ra_balos IN FRAME frOutput
DO:
    ra_balos = INPUT ra_balos.
    nv_ostyp = IF ra_balos = 1 THEN "O/S > 0" 
               ELSE IF ra_balos =  2 THEN "O/S = 0"
               ELSE IF ra_balos =  3 THEN "O/S <= 0"
               ELSE "All".
    APPLY "entry" TO btn_OK IN FRAME frOK.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME rsOutput
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL rsOutput wacr2001
ON VALUE-CHANGED OF rsOutput IN FRAME frOutput
DO:
  ASSIGN {&SELF-NAME}.
  
  CASE rsOutput:
        WHEN 1 THEN  /* Screen */
          ASSIGN
           cbPrtList:SENSITIVE   = No
           fiFile-Name:SENSITIVE = No.
        WHEN 2 THEN  /* Printer */
          ASSIGN
           cbPrtList:SENSITIVE   = Yes
           fiFile-Name:SENSITIVE = No.
        WHEN 3 THEN  /* File */ 
        DO:
          ASSIGN
            cbPrtList:SENSITIVE   = No
            fiFile-Name:SENSITIVE = Yes.
          APPLY "ENTRY" TO fiFile-Name.
        END.
  END CASE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME to_aviva
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL to_aviva wacr2001
ON VALUE-CHANGED OF to_aviva IN FRAME frOutput /* Statement AVIVA */
DO:
    to_aviva = INPUT to_aviva.
    
    IF to_aviva = YES THEN DO:             
        fiacno1  = "0FAVI".
        fiacno2  = "0FAVI".
        rsOutput = 3.

        DISP fiacno1 fiacno2 WITH FRAME frST.
        DISP rsOutput WITH FRAME frOutput.
        ENABLE fiFile-Name WITH FRAME frOutput.
        DISABLE fiacno1 fiacno2 buAcno1 buAcno2 raDetSum WITH FRAME frSt.
        DISABLE rsOutput cbPrtList WITH FRAME frOutput.
        APPLY "Entry" TO fiFile-Name.
    END.
    ELSE DO:
        fiacno1 = "".
        fiacno2 = "".
        DISP fiacno1 fiacno2 WITH FRAME frST.      
        ENABLE fiacno1 fiacno2 buAcno1 buAcno2 raDetSum WITH FRAME frSt.
        ENABLE rsOutput cbPrtList WITH FRAME frOutput.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frMain
&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK wacr2001 


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
  
  gv_prgid = "wacr2001".
  gv_prog  = "Aging Report For Inward & Outward".
  
  RUN  WUT\WUTHEAD (wacr2001:handle,gv_prgid,gv_prog).
/*********************************************************************/  
  RUN  WUT\WUTWICEN (wacr2001:handle). 

  CURRENT-WINDOW:WINDOW-STATE = WINDOW-MAXIMIZED.
  SESSION:DATA-ENTRY-RETURN = YES.
    
    DO WITH FRAME frST :        
        re11:MOVE-TO-TOP().
        re12:MOVE-TO-TOP().
        re13:MOVE-TO-TOP().
        re14:MOVE-TO-TOP().
    
/*  RUN ProcGetRptList.
    RUN ProcGetPrtList.  */
 RUN ProcGetPrtList.
        ASSIGN   
            fiacno1       = ""
            fiacno2       = ""
            fiPoltypFr    = "M01"   /*F10*/
            fiPoltypTo    = "C92"   /*C90*/
            fiProcess     = ""
            nv_asdatAging = ?
            fiInclude     =  nv_Trntyp1
            fityp1 = "O"
            fityp2 = "T"
            fityp3 = "U"
            fityp4 = "P"
            /*----------
            fityp5 = "C"
            fityp6 = "Y"
            fityp7 = "Z"
            -----------*/

/*             nv_RptTyp = "Acno,Branch,Line" */
            nv_RptTyp = "Acno"
            coRptTyp:List-Items = nv_RptTyp
            coRptTyp = ENTRY(1,nv_RptTyp)
            raDetSum:radio-buttons = "Detail,1,Summary,2,All,3"
            raDetSum  = 1
            nv_DetSum = IF raDetSum =  1 THEN "Detail" 
                        ELSE IF raDetSum =  2 THEN "Summary"
                                              ELSE "All".
            /*----A50-0218----*/
            ASSIGN
            ra_balos = 3
            nv_ostyp = IF ra_balos = 1 THEN "O/S > 0" 
                       ELSE IF ra_balos =  2 THEN "O/S = 0"
                       ELSE IF ra_balos =  3 THEN "O/S <= 0"
                       ELSE "All".
            /*-----------------*/        
        DISPLAY  fiacno1 fiacno2  fiasdat
                 fiInclude   fityp1  fityp2  fityp3  fityp4  fityp5  fityp6  fityp7
                 fiPoltypFr fiPoltypTo  coRptTyp raDetSum.

        RUN pdInitData.
        RUN pdUpdateQ.

        APPLY "ENTRY" TO fiBranch IN FRAME frST.
    END.

    DO WITH FRAME frTranDate:
       ASSIGN  
         /*rsOutput:Radio-Buttons = "Screen for Statement, 1, Printer, 2, File for Aging, 3" */
         rsOutput = 1
         cbPrtList:SENSITIVE    = YES  /*Lukkana M. A52-0241 21/10/2009*/
         fiFile-Name:SENSITIVE  = No.  /*Lukkana M. A52-0241 21/10/2009*/

      DISPLAY rsOutput ra_balos WITH FRAME frOutput.
    END.

    APPLY "VALUE-CHANGED" TO brAcproc_fil IN FRAME frst.

    IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI wacr2001  _DEFAULT-DISABLE
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
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(wacr2001)
  THEN DELETE WIDGET wacr2001.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI wacr2001  _DEFAULT-ENABLE
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
  VIEW FRAME fr_Command IN WINDOW wacr2001.
  {&OPEN-BROWSERS-IN-QUERY-fr_Command}
  ENABLE RECT-405 
      WITH FRAME frMain IN WINDOW wacr2001.
  {&OPEN-BROWSERS-IN-QUERY-frMain}
  DISPLAY fiBranch fiBranch2 fiPolTypFr fiPolTypTo fiacno1 fiacno2 fiasdatAging 
          coRptTyp raDetSum fiTyp1 fiTyp2 fiTyp3 fiTyp4 fiTyp5 fiTyp6 fiTyp7 
          fiTyp8 fiTyp9 fiTyp10 fiTyp11 fiTyp12 fiTyp13 fiTyp14 fiTyp15 fibdes 
          fibdes2 fiPoldesFr fiPoldesTo finame1 finame2 fiInclude fiAsdat 
          fiProcessDate fiProcess 
      WITH FRAME frST IN WINDOW wacr2001.
  ENABLE but_Search fiBranch fiBranch2 fiPolTypFr fiPolTypTo fiacno1 fiacno2 
         fiasdatAging buBranch buBranch2 buPoltypFr buPoltypTo buAcno2 coRptTyp 
         raDetSum brAcproc_fil fiTyp1 fiTyp2 fiTyp3 fiTyp4 fiTyp5 fiTyp6 fiTyp7 
         fiTyp8 fiTyp9 fiTyp10 fiTyp11 fiTyp12 fiTyp13 fiTyp14 fiTyp15 buAcno1 
         fibdes fibdes2 fiPoldesFr fiPoldesTo finame1 finame2 fiInclude fiAsdat 
         fiProcessDate fiProcess re11 re12 re13 re14 RECT-407 
      WITH FRAME frST IN WINDOW wacr2001.
  {&OPEN-BROWSERS-IN-QUERY-frST}
  DISPLAY rsOutput ra_balos to_aviva cbPrtList fiFile-Name 
      WITH FRAME frOutput IN WINDOW wacr2001.
  ENABLE RECT-306 RECT-406 rsOutput ra_balos to_aviva cbPrtList fiFile-Name 
      WITH FRAME frOutput IN WINDOW wacr2001.
  {&OPEN-BROWSERS-IN-QUERY-frOutput}
  ENABLE RECT-3 RECT2 Btn_OK Btn_Cancel 
      WITH FRAME frOK IN WINDOW wacr2001.
  {&OPEN-BROWSERS-IN-QUERY-frOK}
  VIEW wacr2001.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdAcnoDet07 wacr2001 
PROCEDURE pdAcnoDet07 :
/*------------------------------------------------------------------------------
  Purpose: Aging Detail  By Acno  [Inward]
------------------------------------------------------------------------------*/
FOR EACH tnzi.   /* add by Phaiboon W. [A59-0125] 21/04/2016 */
    DELETE tnzi. 
END.
nv_blankX = FILL(" ",8).
    /********************** Page Header *********************/
RUN pdpagehead. /* ย้ายไปอยู่ใน pdpagehead Lukkana M. A52-0241 15/10/2009*/
IF MONTH(fiasdat) = MONTH(fiasdatAging) THEN  ASSIGN nv_gap = 12 - MONTH(fiasdatAging).
ELSE ASSIGN nv_gap = 12 - MONTH(fiasdatAging) + 1 .
FOR EACH  agtprm_fil USE-INDEX by_acno WHERE
          agtprm_fil.asdat        =  n_asdat      AND
         (agtprm_fil.acno        >=  n_frac       AND
          agtprm_fil.acno        <=  n_toac )     AND
 ( SUBSTR(agtprm_fil.policy,3,2) >=  nv_poltypFr  AND
   SUBSTR(agtprm_fil.policy,3,2) <=  nv_poltypTo) AND
         (agtprm_fil.polbran     >=  n_branch     AND 
          agtprm_fil.polbran     <=  n_branch2)   AND
  (LOOKUP(SUBSTR(agtprm_fil.trntyp,1,1) , nv_trntyp1) <> 0 )
NO-LOCK BREAK BY agtprm_fil.acno BY agtprm_fil.trndat.     /* Trans. Date */
    /*        BY SUBSTR(agtprm_fil.policy,3,2)
              BY agtprm_fil.policy
              BY agtprm_fil.endno.      -- A48-0241--*/
    /*    NO-LOCK BREAK BY agtprm_fil.acno BY agtprm_fil.polbran BY agtprm_fil.trndat. */
   DISP  /*agtprm_fil.acno --- A500178 ---*/
       agtprm_fil.acno FORMAT "X(10)"
       agtprm_fil.trndat agtprm_fil.policy agtprm_fil.endno agtprm_fil.trntyp 
       agtprm_fil.docno FORMAT "x(10)"  /* Benjaporn J. A60-0267 date 27/06/2017 */
   WITH COLOR BLACK/WHITE NO-LABEL FRAME frProcess VIEW-AS DIALOG-BOX
   TITLE  "  Processing...  ".
   n_asdat = IF nv_asdatAging = ? THEN n_asdat ELSE nv_asdatAging.
   /* Begin */
   /********************** Group Header *********************/
   IF FIRST-OF(agtprm_fil.acno)  THEN DO:
      nv_acname = "".
    /*nv_credit = 0 . */
      FIND xmm600 USE-INDEX xmm60001 WHERE
           xmm600.acno = agtprm_fil.acno NO-LOCK NO-ERROR.
      IF AVAIL xmm600 THEN
         ASSIGN nv_acname = TRIM(xmm600.ntitle) + " " + TRIM(xmm600.name)  
           nv_relate = xmm600.agtreg  /*A50-0218*/
           nv_notes1 = xmm600.notes1 . /*--Lukkana M. A52-0241 08/10/2009--*/
      ELSE ASSIGN nv_acname = ""   nv_relate = "" 
                  nv_notes1 = "" . /*--Lukkana M. A52-0241 08/10/2009--*/
     /*nv_credit = 0 . */ 
      /*--- DISPLAY DETAIL ---*/
      IF (nv_DetSum = "Detail")  OR (nv_DetSum = "All") THEN DO:
          OUTPUT TO VALUE (STRING(n_OutputFile ) ) APPEND NO-ECHO.
          EXPORT DELIMITER ";" " ".
          EXPORT DELIMITER ";"
                 agtprm_fil.acno + " - " + nv_acname + "   <" +
                 agtprm_fil.acno_clicod  + ">" .
          OUTPUT CLOSE.
      END.  /*  (nv_DetSum = "Detail") OR (nv_DetSum = "All") */
       /*--- DISPLAY SUMMARY ---*/
      IF (nv_DetSum = "Summary") OR (nv_DetSum = "All") THEN DO:
          /*nv_row = nv_row + 1. */
          OUTPUT TO VALUE (n_OutputFileSum) APPEND NO-ECHO.  /* SUMMARY */
          EXPORT DELIMITER ";" " ".
          /*EXPORT DELIMITER ";" agtprm_fil.acno + " - " + nv_acname . Lukkana M. A52-0241 19/10/09*/
          OUTPUT CLOSE.
      END.  /* (nv_DetSum = "Summary")  OR (nv_DetSum = "All")  */
   END.  /* first-of(agtprm_fil.acno) */
   ASSIGN
       nv_num    = 0      nv_prem   =  0
       nv_netpa  = 0      nv_vatt   =  0  /*Lukkana M. A52-0241 15/10/2009*/
       nv_prem   = agtprm_fil.prem /*+ agtprm_fil.prem_comp + agtprm_fil.tax  + agtprm_fil.stamp 
       nv_num    = MONTH(agtprm_fil.asdat) - MONTH(agtprm_fil.trndat) + 1 Lukkana M.A52-0241 06/11/09*/
       /*----A50-0218----*/
       nv_vat    = 0
       nv_tax    = 0 nv_poltyp = SUBSTR(agtprm_fil.policy,3,2).
   RUN pdmonth.
   /*-- Lukkana M. A52-0241 30/09/2009 --*/
   nv_vatt  = agtprm_fil.prem + agtprm_fil.comm.
   IF SUBSTR(agtprm_fil.acno,1,2) = "0F" OR SUBSTR(agtprm_fil.acno,1,2) = "0A" THEN DO: /*งานต่างประเทศไม่คิด vat , tax*/
       ASSIGN  nv_vat = 0   nv_tax = 0.
   END.
   ELSE DO: 
       nv_poltyp = SUBSTR(agtprm_fil.policy,3,2). 
       IF LOOKUP(nv_poltyp,nv_pa) <> 0 THEN  /* line 60,61,62,63,64,67 ไม่คิด vat , tax */
          ASSIGN nv_vat = 0  nv_tax = 0.
       ELSE  ASSIGN nv_vat  = ROUND(nv_vatt * 0.07,2) /*งานinwardมีการคีย์*/
                    nv_tax  = ROUND(nv_vatt * 0.01,2).
   END.
   nv_netpa = nv_vatt + nv_vat - nv_tax. /*- agtprm_fil.odue*/ 
   nv_totnetpa = nv_totnetpa + nv_netpa. 
   /*-- Lukkana M. A52-0241 30/09/2009 --*/
       /*IF LOOKUP(nv_poltyp,nv_pa) <> 0 THEN 
          ASSIGN nv_vat = 0
                 nv_tax = 0.
       ELSE ASSIGN nv_vat  = ROUND(agtprm_fil.gross * 0.07,2)
                   nv_tax    = ROUND(agtprm_fil.gross * 0.01,2). Lukkana M. A52-0241 15/10/09*/
       /*----------------*/
   IF nv_num > 0 THEN DO:
       IF YEAR(agtprm_fil.asdat) = YEAR(agtprm_fil.trndat) THEN DO:
          ASSIGN
             nv_dfield[nv_num]  =  nv_prem
             nv_total[nv_num]   =  nv_total[nv_num]   +  nv_prem
             nv_gtotal[nv_num]  =  nv_gtotal[nv_num]  +  nv_prem
             nv_sprem[nv_num]   =  nv_sprem[nv_num]   +  nv_prem
             /*---A50-0218---*/
             nv_svat[nv_num]   =  nv_svat[nv_num]   +  nv_vat
             nv_stax[nv_num]   =  nv_stax[nv_num]   +  nv_tax
             /*--------*/
             nv_scomm[nv_num]   =  nv_scomm[nv_num]   +  agtprm_fil.comm
             nv_sbal[nv_num]    =  nv_sbal[nv_num]    +  agtprm_fil.bal 
             nv_sbal1[nv_num]   =  nv_sbal1[nv_num]   +  agtprm_fil.gross /*Lukkana M. A52-0241 19/10/2009*/
             nv_sgprem[nv_num]  =  nv_sgprem[nv_num]  +  nv_prem
             nv_sgcomm[nv_num]  =  nv_sgcomm[nv_num]  +  agtprm_fil.comm
             nv_sgbal[nv_num]   =  nv_sgbal[nv_num]   +  agtprm_fil.bal
             nv_nzibal[nv_num]  =  nv_nzibal[nv_num]  +  agtprm_fil.gross. /* add by Phaiboon W. [A59-0125] 27/04/2016 */
           /*--- lek ---
           CASE agtprm_fil.acno_clicod:
               WHEN "RA" THEN nv_racode[nv_num] = nv_racode[nv_num] + agtprm_fil.prem .
               WHEN "RB" THEN nv_rbcode[nv_num] = nv_rbcode[nv_num] + agtprm_fil.prem .
               WHEN "RD" THEN nv_rdcode[nv_num] = nv_rdcode[nv_num] + agtprm_fil.prem .
               WHEN "RF" THEN nv_rfcode[nv_num] = nv_rfcode[nv_num] + agtprm_fil.prem .
           END CASE.
           --- end lek ---*/
       END.
       ELSE DO:           /* over 12 month */
           RUN pdoveryear . /*-- Lukkana M. A52-0241 28/09/2009 --*/
          
       END.
   END.
   ELSE DO:
     RUN pdProcess07. /*Lukkana M. A52-0241 28/09/200*/
    
   END.
   
   ASSIGN
     /*nv_tprem      = nv_tprem + nv_prem Lukkana M. A52-0241 15/10/09 รวมค่าผิด */
     nv_tprem  = nv_tprem + agtprm_fil.prem  /*Lukkana M. A52-0241 15/10/09*/
     /*nv_todue  = nv_todue + agtprm_fil.odue /*Lukkana M. A52-0241 26/10/09*/*/
     nv_tsumins = nv_tsumins + agtprm_fil.comm_comp /*Lukkana M. A52-0241 26/10/09*/
     nv_totnetam = nv_totnetam + agtprm_fil.gross
     /*---A50-0218---*/
     nv_tvat   = nv_tvat + nv_vat
     nv_ttax   = nv_ttax + nv_tax
     /*--------------*/
     nv_tcomm  = nv_tcomm + agtprm_fil.comm
     nv_tbal   = nv_tbal  + agtprm_fil.bal
     nv_sprem[14]  = nv_sprem[14]  + nv_prem 
     nv_scomm[14]  = nv_scomm[14]  + agtprm_fil.comm
     nv_sbal[14]   = nv_sbal[14]   + agtprm_fil.bal 
     /*Lukkana M. A52-0241 06/11/2009*/
     nv_svat[14] = nv_svat[14] + nv_vat  
     nv_stax[14] = nv_stax[14] + nv_tax  
     nv_sbal1[14]  = nv_sbal1[14]  + agtprm_fil.gross
     nv_nettol     = nv_nettol     + agtprm_fil.gross. /* add by Phaiboon W. [A59-0125] 21/04/2016 */
     /*Lukkana M. A52-0241 06/11/2009*/
      
   RUN pdBodyNzi. /* add by Phaiboon W. [A59-0125] 21/04/2016 */
   
   /*--- DISPLAY DETAIL  ---*/
   IF (nv_DetSum = "Detail")  OR (nv_DetSum = "All") THEN DO:
       /*Lukkana M. A52-0241 21/10/2009*/
       IF agtprm_fil.trndat = ? THEN nv_trndat = "".
       ELSE nv_trndat = STRING(agtprm_fil.trndat).
       IF agtprm_fil.comdat = ? THEN nv_comdat = "".
       ELSE nv_comdat = STRING(agtprm_fil.comdat).
       /*Lukkana M. A52-0241 21/10/2009*/
       
       OUTPUT TO VALUE (STRING(n_OutputFile ) ) APPEND NO-ECHO.
       EXPORT DELIMITER ";"
         /*agtprm_fil.acno --- A500178 ---*/
         agtprm_fil.acno FORMAT "X(10)"
         nv_acname
         /*agtprm_fil.trndat Lukkana M. A52-0241 21/10/2009*/
         nv_trndat /*Lukkana M. A52-0241 21/10/2009*/
         agtprm_fil.policy
         agtprm_fil.endno
         /*agtprm_fil.comdat Lukkana M. A52-0241 21/10/2009*/
         nv_comdat /*Lukkana M. A52-0241 21/10/2009*/
         agtprm_fil.trntyp
         "'" + agtprm_fil.docno FORMAT "x(10)"  /* Benjaporn J. A60-0267 date 27/06/2017 */
         agtprm_fil.insure
         agtprm_fil.comm_comp /*-Lukkana M. A52-0241 08/10/2009-*/
         agtprm_fil.prem 
         /*- A50-0218 -*/
         nv_vat
         agtprm_fil.comm
         agtprm_fil.gross /*-Lukkana M. A52-0241 08/10/2009-*/
         nv_tax
         /*agtprm_fil.odue /*Lukkkana M. A52-0241 21/10/2009*/*/
         nv_netpa /*-Lukkana M. A52-0241 08/10/2009-*/
         /*------------*/
         agtprm_fil.bal
         agtprm_fil.duedat
         agtprm_fil.cedpol
         nv_dfield[18]
         nv_dfield[1] nv_dfield[2] nv_dfield[3] nv_dfield[4]  nv_dfield[5]  nv_dfield[6] 
         nv_dfield[7] nv_dfield[8] nv_dfield[9] nv_dfield[10] nv_dfield[11] nv_dfield[12] nv_dfield[13]
         nv_dfield[15] nv_dfield[16] nv_dfield[17]. /*Lukkana M. A52-0241 15/10/09*/
       OUTPUT CLOSE.
   END.    /* (nv_DetSum = "Detail")  OR (nv_DetSum = "All") */

   IF LAST-OF(agtprm_fil.acno) THEN DO:
       /*--- DISPLAY DETAIL  ---*/
       IF (nv_DetSum = "Detail")  OR (nv_DetSum = "All") THEN DO:
           OUTPUT TO VALUE (STRING(n_OutputFile ) ) APPEND NO-ECHO.
           EXPORT DELIMITER ";"
               "Total : " + agtprm_fil.acno
               nv_blankX[1 FOR 8] 
               nv_tsumins /*Lukkana M. A52-0241 08/10/2009*/
               nv_tprem
               /*- A50-0218 -*/
               nv_tvat
               nv_tcomm
               nv_totnetam /*-Lukkana M. A52-0241 08/10/2009-*/
               nv_ttax
               /*nv_todue /*-Lukkana M. A52-0241 26/10/2009-*/*/
               nv_totnetpa /*-Lukkana M. A52-0241 08/10/2009-*/
               /*------------*/
               nv_tbal
               nv_blankX[1 FOR 2]
               nv_total[18] nv_total[1] nv_total[2] nv_total[3]  nv_total[4]  nv_total[5]  nv_total[6]  nv_total[7]
               nv_total[8] nv_total[9] nv_total[10] nv_total[11] nv_total[12] nv_total[13]
               nv_total[15] nv_total[16] nv_total[17]. /*Lukkana M. A52-0241 15/10/09*/
           OUTPUT CLOSE.

           ASSIGN
              nv_tprem = 0 nv_tcomm = 0 nv_tbal  = 0 nv_total = 0 
              nv_tvat  = 0 nv_ttax  = 0 nv_totnetam = 0 nv_totnetpa = 0 nv_todue = 0 nv_tsumins = 0. /*Lukkana M. A52-0241 15/10/09*/
               /*---A50-0218---*/
               /*--------------*/
       END.    /* (nv_DetSum = "Detail")  OR (nv_DetSum = "All") */
       /*--- DISPLAY SUMMARY  ---*/
       IF (nv_DetSum = "Summary") OR (nv_DetSum = "All") THEN DO:
         OUTPUT TO VALUE (STRING(n_OutputFileSum) ) APPEND NO-ECHO.
         EXPORT DELIMITER ";" agtprm_fil.acno + " - " + nv_acname /*lukkana M. A52-0241 19/10/09*/ 
                          "Premium"    nv_sprem[14] nv_sprem[18] nv_sprem[1 FOR 13] nv_sprem[15] nv_sprem[16] nv_sprem[17] nv_notes1.
         EXPORT DELIMITER ";" agtprm_fil.acno + " - " + nv_acname /*lukkana M. A52-0241 19/10/09*/ 
                          "Vat"    nv_svat[14] nv_svat[18] nv_svat[1 FOR 13] nv_svat[15] nv_svat[16] nv_svat[17] nv_notes1.
         EXPORT DELIMITER ";" agtprm_fil.acno + " - " + nv_acname /*lukkana M. A52-0241 19/10/09*/ 
                          "Commission" nv_scomm[14] nv_scomm[18] nv_scomm[1 FOR 13] nv_scomm[15] nv_scomm[16] nv_scomm[17] nv_notes1.
         EXPORT DELIMITER ";" agtprm_fil.acno + " - " + nv_acname /*lukkana M. A52-0241 19/10/09*/ 
                          "Bal O/S"    nv_sbal[14]  nv_sbal[18] nv_sbal[1 FOR 13] nv_sbal[15] nv_sbal[16] nv_sbal[17] nv_notes1. 
         /*- A50-0218 -*/ 
         EXPORT DELIMITER ";" agtprm_fil.acno + " - " + nv_acname /*lukkana M. A52-0241 19/10/09*/ 
                          "Tax"    nv_stax[14] nv_stax[18] nv_stax[1 FOR 13] nv_stax[15] nv_stax[16] nv_stax[17] nv_notes1.
         /*------------*/
         OUTPUT CLOSE.
         /*--- A50-0218 ---*/
         OUTPUT TO VALUE (STRING(n_OutputFileNet)) APPEND NO-ECHO.
         EXPORT DELIMITER ";" nv_relate  agtprm_fil.acno  nv_acname  nv_sbal1[14]  nv_sbal1[18] nv_sbal1[1 FOR 13] 
                nv_sbal1[15] nv_sbal1[16] nv_sbal1[17] nv_notes1. /*-- Lukkana M. A52-0241 28/09/2009 --*/
         OUTPUT CLOSE.

         ASSIGN
           nv_sprem  = 0
           nv_scomm  = 0
           nv_sbal   = 0 
           nv_sbal1  = 0 /*Lukkana M. A52-0241 19/10/09*/
           /*---A50-0218---*/
           nv_svat   = 0
           nv_stax   = 0.
           /*--------------*/          
       END.  /* (nv_DetSum = "Summary")  OR (nv_DetSum = "All") */
   END.   /* IF LAST-OF(agtprm_fil.acno) */

   nv_dfield = 0.
   ACCUMULATE 
     agtprm_fil.prem      (TOTAL)
     agtprm_fil.prem_comp (TOTAL)
     agtprm_fil.tax       (TOTAL)
     agtprm_fil.stamp     (TOTAL)
     agtprm_fil.comm      (TOTAL)
     agtprm_fil.bal       (TOTAL) 
     /*---A50-0218---*/
     nv_vat               (TOTAL)
     nv_tax               (TOTAL)
     agtprm_fil.comm_comp (TOTAL) /*Lukkana A52-0241*/
     /*agtprm_fil.odue      (TOTAL) /*Lukkana A52-0241*/*/
     nv_netpa             (TOTAL)  /*Lukkana A52-0241*/
     agtprm_fil.gross     (TOTAL). /*Lukkana A52-0241*/
     /*--------------*/     
   /********************** Page Footer *********************/
   /*** export ข้อมูลลง DETAIL FILE บรรทัด Grand Total  และ  
                        SUMMARY FILE บรรทัด Grand Total ***/
   IF LAST(agtprm_fil.acno) THEN DO:
     IF (nv_DetSum = "Detail")  OR (nv_DetSum = "All") THEN DO:
       OUTPUT TO VALUE (n_OutputFile ) APPEND NO-ECHO.
       ASSIGN
         nv_gprem   = (ACCUM TOTAL agtprm_fil.prem) /*+ 
                      (ACCUM TOTAL agtprm_fil.prem_comp) +
                      (ACCUM TOTAL agtprm_fil.tax) + (ACCUM TOTAL agtprm_fil.stamp) Lukkana M. A52-0241 06/11/2006*/
         nv_gsumins = (ACCUM TOTAL agtprm_fil.comm_comp) /*Lukkana A52-0241*/
         nv_gnetam = (ACCUM TOTAL agtprm_fil.gross) /*Lukkana A52-0241*/
         /*nv_godue  = (ACCUM TOTAL agtprm_fil.odue) /*Lukkana A52-0241*/*/
         nv_gnetpa = (ACCUM TOTAL nv_netpa) /*Lukana A52-0241*/
         /*---A50-0218---*/
         nv_gvat    = (ACCUM TOTAL nv_vat)
         nv_gtax    = (ACCUM TOTAL nv_tax)
         /*--------------*/
         nv_gcomm   = (ACCUM TOTAL agtprm_fil.comm)
         nv_gbal    = (ACCUM TOTAL agtprm_fil.bal) . 
       RUN pdFooterDet.
       OUTPUT CLOSE.
     END.  /* (nv_DetSum = "Detail")  OR (nv_DetSum = "All") */

     IF (nv_DetSum = "Summary")  OR (nv_DetSum = "All") THEN DO:
        OUTPUT TO VALUE (n_OutputFileSum ) APPEND NO-ECHO.
        ASSIGN
          nv_gprem   = (ACCUM TOTAL agtprm_fil.prem) /*+
                       (ACCUM TOTAL agtprm_fil.prem_comp) +
                       (ACCUM TOTAL agtprm_fil.tax) +
                       (ACCUM TOTAL agtprm_fil.stamp) Lukkana M. A52-0241 06/11/2006*/
          /*---A50-0218---*/
          nv_gvat    = (ACCUM TOTAL nv_vat)
          nv_gtax    = (ACCUM TOTAL nv_tax)
          /*--------------*/
          nv_gcomm   = (ACCUM TOTAL agtprm_fil.comm)
          nv_gbal    = (ACCUM TOTAL agtprm_fil.bal) .
        RUN pdFooterSum.
        OUTPUT CLOSE.
        /*---------A50-0218-----------*/
        OUTPUT TO VALUE (n_OutputFileNet) APPEND NO-ECHO.
        ASSIGN nv_gbal    = (ACCUM TOTAL agtprm_fil.bal) .
        RUN pdFooterNet.
        OUTPUT CLOSE.
        /*----------------------------*/

        /* Begin by Phaiboon W. [A59-0125] 05/04/2016 */    
        OUTPUT TO VALUE (n_OutputFileNzi) APPEND NO-ECHO.
        FOR EACH tnzi NO-LOCK BREAK BY tchkno
                                    BY tacno.            
            IF FIRST-OF(tnzi.tchkno) THEN DO:
                EXPORT DELIMITER ";" tnzi.tbran.
            END.            

            DO nv_nzino = 1 TO 9:
                nv_nzitol[nv_nzino] = nv_nzitol[nv_nzino] + tnzi.tnzibal[nv_nzino].
            END.

            EXPORT DELIMITER ";" "" tnzi.trelate tnzi.tacno tnzi.tacname tnzi.tnzibal[1 FOR 9] tnzi.tnotes.
            IF LAST-OF(tnzi.tchkno) THEN DO:
                RUN pdFooterNzi.                
            END.            
        END.        
        
        EXPORT DELIMITER ";" "" "" "Grand Net Total" "" nv_grantol[1 FOR 9].
        OUTPUT CLOSE.                  
        /* End by Phaiboon W. [A59-0125] 05/04/2016 */
     END.  /* (nv_DetSum = "Summary")  OR (nv_DetSum = "All") */
     RUN pdInitDataG.    /* clear data */                       
   END. /* if last(agtprm_fil.acno) then */
END. /* for each agtprm_fil*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdAcnoDet08 wacr2001 
PROCEDURE pdAcnoDet08 :
/*------------------------------------------------------------------------------
  Purpose: Aging Detail  By Acno  [Outward O/S All]
------------------------------------------------------------------------------*/
    ASSIGN nv_blankX = FILL(" ",8)
           nv_stotal = 0.

    /********************** Page Header *********************/
    /*--- DISPLAY DETAIL  ---*/
    IF (nv_DetSum = "Detail")  OR (nv_DetSum = "All") THEN DO:
        OUTPUT TO VALUE (n_OutputFile ) NO-ECHO.
            RUN pdTitleDet.   
            RUN pdPageHeadDet.
        OUTPUT CLOSE.
    END.  /* (nv_DetSum = "Detail")  OR (nv_DetSum = "All") */
    
    /*** DISPLAY SUMMARY FILE & SUMMARY GRAND TOTAL***/
    IF (nv_DetSum = "Summary")  OR (nv_DetSum = "All") THEN DO:
        OUTPUT TO VALUE (n_OutputFileSum) NO-ECHO.  /* SUMMARY */
            RUN pdTitleSum.
            RUN pdPageHeadSum.
        OUTPUT CLOSE.

        /*---By A50-0218----*/
        OUTPUT TO VALUE (n_OutputFileNet) NO-ECHO.  /* NETBAL */
            RUN pdTitleNet.
            RUN pdPageHeadNet.
        OUTPUT CLOSE.
        /*------------------*/        
    END.  /* (nv_DetSum = "Summary")  OR (nv_DetSum = "All")  */   

    /*--Lukkana M. A52-0241 08/10/2009--*/
    IF MONTH(fiasdat) = MONTH(fiasdatAging) THEN 
        ASSIGN nv_gap = 12 - MONTH(fiasdatAging).
    ELSE ASSIGN nv_gap = 12 - MONTH(fiasdatAging) + 1 .
    /*--Lukkana M. A52-0241 08/10/2009--*/
    /*ASSIGN nv_gap = 12 - MONTH(fiasdatAging). --Lukkana M. A52-0241 08/10/2009--*/
    i = 0.
    
    FOR EACH  agtprm_fil USE-INDEX by_acno WHERE
              agtprm_fil.asdat        =  n_asdat        AND
             (agtprm_fil.acno        >=  n_frac         AND
              agtprm_fil.acno        <=  n_toac )       AND
     ( SUBSTR(agtprm_fil.policy,3,2) >=  nv_poltypFr    AND
       SUBSTR(agtprm_fil.policy,3,2) <=  nv_poltypTo)   AND
             (agtprm_fil.polbran     >=  n_branch       AND 
              agtprm_fil.polbran     <=  n_branch2)     AND
              /*agtprm_fil.poldes      <> ""             AND*/
      (LOOKUP(SUBSTR(agtprm_fil.trntyp,1,1) , nv_trntyp1) <> 0 )
    NO-LOCK BREAK BY agtprm_fil.acno
                  BY agtprm_fil.trndat
                  BY SUBSTR(agtprm_fil.policy,3,2)
                  BY agtprm_fil.policy
                  BY agtprm_fil.endno.
     i = i + 1.
        /*    NO-LOCK BREAK BY agtprm_fil.acno BY agtprm_fil.polbran BY agtprm_fil.trndat. */

        DISP  /*agtprm_fil.acno --- A500178 ---*/ 
              i
              agtprm_fil.acno FORMAT "X(10)"
              agtprm_fil.trndat     /* Trans. Date */
              agtprm_fil.policy
              agtprm_fil.endno
              agtprm_fil.trntyp
              agtprm_fil.docno FORMAT "x(10)"  /* Benjaporn J. A60-0267 date 27/06/2017 */
        WITH COLOR BLACK/WHITE NO-LABEL FRAME frProcess VIEW-AS DIALOG-BOX
        TITLE  "  Processing...  ".

        n_asdat = IF nv_asdatAging = ? THEN n_asdat ELSE nv_asdatAging.

        /* Begin */
        /********************** Group Header *********************/
            
        IF FIRST-OF(agtprm_fil.acno)  THEN DO:
            nv_acname = "".
            FIND xmm600 USE-INDEX xmm60001 WHERE
                 xmm600.acno = agtprm_fil.acno NO-LOCK NO-ERROR.
            IF AVAIL xmm600 THEN
               ASSIGN  nv_acname = TRIM(xmm600.ntitle) + " " + TRIM(xmm600.name) 
                       nv_relate = xmm600.agtreg   /*A50-0218*/
                       nv_notes1 = xmm600.notes1 . /*--Lukkana M. A52-0241 08/10/2009--*/
            ELSE ASSIGN nv_acname = " " 
                        nv_relate = ""
                        nv_notes1 = "" . /*--Lukkana M. A52-0241 08/10/2009--*/
 
            /*--- DISPLAY DETAIL ---*/
            IF (nv_DetSum = "Detail")  OR (nv_DetSum = "All") THEN DO:
                OUTPUT TO VALUE (STRING(n_OutputFile ) ) APPEND NO-ECHO.
                    EXPORT DELIMITER ";" " ".
                    EXPORT DELIMITER ";"
                        agtprm_fil.acno + " - " + nv_acname + "   <" +
                        agtprm_fil.acno_clicod  + ">" .
                OUTPUT CLOSE.
            END.  /*  (nv_DetSum = "Detail") OR (nv_DetSum = "All") */
            
            /*--- DISPLAY SUMMARY ---*/
            IF (nv_DetSum = "Summary") OR (nv_DetSum = "All") THEN DO:
                OUTPUT TO VALUE (n_OutputFileSum) APPEND NO-ECHO.  /* SUMMARY */
                    EXPORT DELIMITER ";" " ".
                    /*-- 
                    EXPORT DELIMITER ";"
                        agtprm_fil.acno + " - " + nv_acname .
                    Lukkana M. A52-0241 08/10/2009--*/
                OUTPUT CLOSE.
            END.  /* (nv_DetSum = "Summary")  OR (nv_DetSum = "All")  */
        
        END.  /* first-of(agtprm_fil.acno) */
        
        ASSIGN 
            nv_num    = 0
            nv_netbal = 0
            /*--
            nv_num    = MONTH(agtprm_fil.asdat) - MONTH(agtprm_fil.trndat) + 1 
            nv_netbal = agtprm_fil.gross - agtprm_fil.odue 
            Lukkana M. a52-0241 05/10/2009---*/
            
            nv_netbal = agtprm_fil.gross  /*--Lukkana M. a52-0241 05/10/2009---*/

            /*----A50-0218----*/
            nv_balos  = 0       
            nv_vat    = 0
            nv_tax    = 0
            nv_netpd  = 0
            nv_netpaid = 0 /*Lukkana M. A52-0241 21/10/2009*/
            nv_vatt   = 0 /*Lukkana M. A52-0241 21/10/2009*/
            nv_balos  = agtprm_fil.bal   . 
        RUN pdmonth. /*--Lukkana M. A52-0241 08/10/2009--*/
            /*nv_netpd  = ROUND(agtprm_fil.gross + nv_vat + nv_tax,2).*/
           
            /*-----A50-0218
            IF nv_balos > 0 THEN nv_stos = "O/S > 0".
            ELSE IF nv_balos = 0 THEN nv_stos = "O/S = 0".
            ELSE nv_stos = "O/S < 0".
            ---------------*/

            /*-- Lukkana M. A52-0241 30/09/2009 --*/
            nv_vatt  = agtprm_fil.prem + agtprm_fil.comm.
            IF SUBSTR(agtprm_fil.acno,1,2) = "0F" OR SUBSTR(agtprm_fil.acno,1,2) = "0A"  THEN DO: /*งานต่างประเทศไม่คิด vat , tax*/
                ASSIGN nv_vat = 0
                       nv_tax = 0.
            END.
            ELSE DO: 
                nv_poltyp = SUBSTR(agtprm_fil.policy,3,2). 
                IF LOOKUP(nv_poltyp,nv_pa) <> 0 THEN  /* line 60,61,62,63,64,67 ไม่คิด vat , tax */
                   ASSIGN nv_vat = 0
                          nv_tax = 0.
                ELSE 
                    ASSIGN nv_vat  = ROUND(nv_vatt * 0.07,2)
                           nv_tax  = ROUND(nv_vatt * 0.01,2).
            END.
            ASSIGN nv_netpd  = ROUND(nv_netbal + nv_vat - nv_tax,2)
                   nv_netpaid  = ROUND(nv_vatt + nv_vat - nv_tax /*- agtprm_fil.odue*/ ,2). /*prem-comm+vat-tax Lukkana M. A52-0241 21/10/2009*/

            nv_gnetpaid = nv_gnetpaid + nv_netpaid. /*Lukkana M. A52-0241 21/10/2009*/

            /*-- Lukkana M. A52-0241 30/09/2009 --*/

            /*-- Lukkana M. A52-0241 30/09/2009 --
            nv_poltyp = SUBSTR(agtprm_fil.policy,3,2).
            IF LOOKUP(nv_poltyp,nv_pa) <> 0 THEN 
               ASSIGN nv_vat = 0
                      nv_tax = 0.
            ELSE 
                ASSIGN nv_vat  = ROUND(agtprm_fil.gross * 0.07,2)
                       nv_tax  = ROUND(agtprm_fil.gross * 0.01,2).

            nv_netpd  = ROUND(nv_netbal + nv_vat - nv_tax,2).
            /*----------------*/
            
        {Wac/Wacr2001.i} -- Lukkana M. A52-0241 30/09/2009 --*/
        
        RUN pdRunwacr.   /*--Lukkana M. A52-0241 08/10/2009--*/
        {wac/wacr2004.i} /*--Lukkana M. A52-0241 08/10/2009--*/
        ACCUMULATE
            agtprm_fil.prem      (TOTAL)
            agtprm_fil.comm      (TOTAL)
            agtprm_fil.gross     (TOTAL)
            /*agtprm_fil.odue      (TOTAL) Lukkana M. A52-0241 21/10/2009*/
            /*----A50-0218*----*/
            agtprm_fil.bal       (TOTAL)
            nv_vat               (TOTAL)
            nv_tax               (TOTAL)   
            nv_netpd             (TOTAL)  
            nv_netpaid           (TOTAL)  /*Lukkana M. A52-0241 21/10/2009*/
            agtprm_fil.comm_comp (total). /*Lukkana M. A52-0241 21/10/2009*/
                
            /*-----------------*/

        /********************** Page Footer *********************/
        /*** export ข้อมูลลง DETAIL FILE บรรทัด Grand Total  และ  
                             SUMMARY FILE บรรทัด Grand Total ***/
        IF LAST(agtprm_fil.acno) THEN DO:
            IF (nv_DetSum = "Detail")  OR (nv_DetSum = "All") THEN DO:
                OUTPUT TO VALUE (n_OutputFile ) APPEND NO-ECHO.
                 ASSIGN
                    nv_gsumin  = (ACCUM TOTAL agtprm_fil.comm_comp) /*--Lukkana M. A52-0241 05/10/2009---*/    
                    nv_gprem   = (ACCUM TOTAL agtprm_fil.prem)
                    nv_gcomm   = (ACCUM TOTAL agtprm_fil.comm)
                    nv_gnet    = (ACCUM TOTAL agtprm_fil.gross)
                     /*--A50-0218---*/
                    nv_gvat     = (ACCUM TOTAL nv_vat)
                    nv_gtax     = (ACCUM TOTAL nv_tax)
                    nv_gnetpd   = (ACCUM TOTAL nv_netpd)
                    /*-------------*/
                    /*nv_gres    = (ACCUM TOTAL agtprm_fil.odue) Lukkana M. A52-0241 28/10/2009*/
                    nv_gbalos  = (ACCUM TOTAL agtprm_fil.bal)
                    /*---
                    nv_gbal    = (ACCUM TOTAL agtprm_fil.gross) - 
                                 (ACCUM TOTAL agtprm_fil.odue) .
                    Lukkana M. A52-0241 05/10/2009---*/
                    
                    nv_gbal    = (ACCUM TOTAL agtprm_fil.gross) .     /*--Lukkana M. A52-0241 05/10/2009---*/

                   /*----A50-0218----
                   IF nv_gbalos > 0 THEN nv_gstos = "O/S > 0".
                   ELSE IF nv_gbalos = 0 THEN nv_gstos = "O/S = 0".
                   ELSE nv_gstos = "O/S < 0".
                   ----------------*/
                RUN pdFooterDet.
                OUTPUT CLOSE.
            END.  /* (nv_DetSum = "Detail")  OR (nv_DetSum = "All") */

            IF (nv_DetSum = "Summary")  OR (nv_DetSum = "All") THEN DO:
                OUTPUT TO VALUE (n_OutputFileSum ) APPEND NO-ECHO.
                ASSIGN
                    nv_gprem   = (ACCUM TOTAL agtprm_fil.prem)
                    nv_gcomm   = (ACCUM TOTAL agtprm_fil.comm)
                    nv_gnet    = (ACCUM TOTAL agtprm_fil.gross)
                    /*nv_gres    = (ACCUM TOTAL agtprm_fil.odue) A52-0241 28/10/2009*/
                    /*--
                    nv_gbal    = (ACCUM TOTAL agtprm_fil.gross) - 
                                 (ACCUM TOTAL agtprm_fil.odue) .
                    Lukkana M. A52-0241 05/10/2009---*/

                    nv_gbal    = (ACCUM TOTAL agtprm_fil.gross)  /*--Lukkana M. A52-0241 05/10/2009---*/
                    nv_ngbal   = (ACCUM TOTAL agtprm_fil.gross). /*- (ACCUM TOTAL agtprm_fil.odue)*/  /*--Lukkana M. A52-0241 05/10/2009---*/
                RUN pdFooterSum.
                OUTPUT CLOSE.
                /*---------A50-0218-----------*/
                OUTPUT TO VALUE (n_OutputFileNet ) APPEND NO-ECHO.
                ASSIGN
                    nv_gprem   = (ACCUM TOTAL agtprm_fil.prem)
                    nv_gcomm   = (ACCUM TOTAL agtprm_fil.comm)
                    nv_gnet    = (ACCUM TOTAL agtprm_fil.gross)
                    /*nv_gres    = (ACCUM TOTAL agtprm_fil.odue) Lukkana M. A52-0241 28/10/2009*/
                    /*--
                    nv_gbal    = (ACCUM TOTAL agtprm_fil.gross) - 
                                 (ACCUM TOTAL agtprm_fil.odue) .
                    Lukkana M. A52-0241 05/10/2009--*/
                    nv_gbal    = (ACCUM TOTAL agtprm_fil.gross) . /*--Lukkana M. A52-0241 05/10/2009--*/
                RUN pdFooterNet.
                OUTPUT CLOSE.
                /*----------------------------*/                
            END.  /* (nv_DetSum = "Summary")  OR (nv_DetSum = "All") */
            RUN pdInitDataG.    /* clear data */
        END. /* if last(agtprm_fil.acno) then */
    END. /* for each agtprm_fil*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdAcnoDet081 wacr2001 
PROCEDURE pdAcnoDet081 :
/*------------------------------------------------------------------------------
  Purpose: Aging Detail  By Acno  [Outward O/S > 0]  A50-0218
------------------------------------------------------------------------------*/
    
    /*-----------------*/
    ASSIGN nv_blankX = FILL(" ",8)
           nv_stotal = 0.    

    /********************** Page Header *********************/
    /*--- DISPLAY DETAIL  ---*/
    IF (nv_DetSum = "Detail")  OR (nv_DetSum = "All") THEN DO:
        OUTPUT TO VALUE (n_OutputFile ) NO-ECHO.
            RUN pdTitleDet.   
            RUN pdPageHeadDet.
        OUTPUT CLOSE.
    END.  /* (nv_DetSum = "Detail")  OR (nv_DetSum = "All") */
    
    /*** DISPLAY SUMMARY FILE & SUMMARY GRAND TOTAL***/
    IF (nv_DetSum = "Summary")  OR (nv_DetSum = "All") THEN DO:
        OUTPUT TO VALUE (n_OutputFileSum) NO-ECHO.  /* SUMMARY */
            RUN pdTitleSum.
            RUN pdPageHeadSum.
        OUTPUT CLOSE.

        /*---By A50-0218----*/
        OUTPUT TO VALUE (n_OutputFileNet) NO-ECHO.  /* NETBAL */
            RUN pdTitleNet.
            RUN pdPageHeadNet.
        OUTPUT CLOSE.
        /*------------------*/        
    END.  /* (nv_DetSum = "Summary")  OR (nv_DetSum = "All")  */   

    /*-- Lukkana M. A52-0241 30/09/2009 --*/
    IF MONTH(fiasdat) = MONTH(fiasdatAging) THEN 
        ASSIGN nv_gap = 12 - MONTH(fiasdatAging).
    ELSE ASSIGN nv_gap = 12 - MONTH(fiasdatAging) + 1 .
    /*-- Lukkana M. A52-0241 30/09/2009 --*/
    /*ASSIGN nv_gap = 12 - MONTH(fiasdatAging). -- Lukkana M. A52-0241 30/09/2009 --*/

    FOR EACH  agtprm_fil USE-INDEX by_acno WHERE
              agtprm_fil.asdat        =  n_asdat        AND
             (agtprm_fil.acno        >=  n_frac         AND
              agtprm_fil.acno        <=  n_toac )       AND
     ( SUBSTR(agtprm_fil.policy,3,2) >=  nv_poltypFr    AND
       SUBSTR(agtprm_fil.policy,3,2) <=  nv_poltypTo)   AND
             (agtprm_fil.polbran     >=  n_branch       AND 
              agtprm_fil.polbran     <=  n_branch2)     AND
      (LOOKUP(SUBSTR(agtprm_fil.trntyp,1,1) , nv_trntyp1) <> 0 ) AND
              agtprm_fil.poldes    = "O/S > 0"         
    NO-LOCK BREAK BY agtprm_fil.acno
                  BY agtprm_fil.trndat
                  BY SUBSTR(agtprm_fil.policy,3,2)
                  BY agtprm_fil.policy
                  BY agtprm_fil.endno.
        /*    NO-LOCK BREAK BY agtprm_fil.acno BY agtprm_fil.polbran BY agtprm_fil.trndat. */

        DISP  /*agtprm_fil.acno --- A500178 ---*/  
              agtprm_fil.acno FORMAT "X(10)"
              agtprm_fil.trndat     /* Trans. Date */
              agtprm_fil.policy
              agtprm_fil.endno
              agtprm_fil.trntyp
              agtprm_fil.docno FORMAT "x(10)"  /* Benjaporn J. A60-0267 date 27/06/2017 */
        WITH COLOR BLACK/WHITE NO-LABEL FRAME frProcess VIEW-AS DIALOG-BOX
        TITLE  "  Processing...  ".

        n_asdat = IF nv_asdatAging = ? THEN n_asdat ELSE nv_asdatAging.

        /* Begin */
        /********************** Group Header *********************/
            
        IF FIRST-OF(agtprm_fil.acno)  THEN DO:
            nv_acname = "".
            FIND xmm600 USE-INDEX xmm60001 WHERE
                 xmm600.acno = agtprm_fil.acno NO-LOCK NO-ERROR.
            IF AVAIL xmm600 THEN
               ASSIGN  nv_acname = TRIM(xmm600.ntitle) + " " + TRIM(xmm600.name) 
                       nv_relate = xmm600.agtreg   /*A50-0218*/
                       nv_notes1 = xmm600.notes1 . /*--Lukkana M. A52-0241 08/10/2009--*/
            ELSE ASSIGN nv_acname = " " 
                        nv_relate = ""
                        nv_notes1 = "" . /*--Lukkana M. A52-0241 08/10/2009--*/
 
            /*--- DISPLAY DETAIL ---*/
            IF (nv_DetSum = "Detail")  OR (nv_DetSum = "All") THEN DO:
                OUTPUT TO VALUE (STRING(n_OutputFile ) ) APPEND NO-ECHO.
                    EXPORT DELIMITER ";" " ".
                    EXPORT DELIMITER ";"
                        agtprm_fil.acno + " - " + nv_acname + "   <" +
                        agtprm_fil.acno_clicod  + ">" .
                OUTPUT CLOSE.
            END.  /*  (nv_DetSum = "Detail") OR (nv_DetSum = "All") */
            
            /*--- DISPLAY SUMMARY ---*/
            IF (nv_DetSum = "Summary") OR (nv_DetSum = "All") THEN DO:
                OUTPUT TO VALUE (n_OutputFileSum) APPEND NO-ECHO.  /* SUMMARY */
                    EXPORT DELIMITER ";" " ".
                    /*--
                    EXPORT DELIMITER ";"
                        agtprm_fil.acno + " - " + nv_acname .
                    Lukkana M. A52-0241 08/10/2009--*/
                OUTPUT CLOSE.
            END.  /* (nv_DetSum = "Summary")  OR (nv_DetSum = "All")  */
        END.  /* first-of(agtprm_fil.acno) */

        ASSIGN 
            nv_num    = 0
            nv_netbal = 0
            /*--
            nv_num    = MONTH(agtprm_fil.asdat) - MONTH(agtprm_fil.trndat) + 1
            nv_netbal = agtprm_fil.gross - agtprm_fil.odue 
            Lukkana M. a52-0241 05/10/2009---*/
            
            nv_netbal = agtprm_fil.gross  /*--Lukkana M. a52-0241 05/10/2009---*/

            /*----A50-0218----*/
            nv_balos  = 0       
            nv_vat    = 0
            nv_tax    = 0
            nv_netpd  = 0
            nv_netpaid = 0 /*Lukkana M. A52-0241 21/10/2009*/
            nv_balos  = agtprm_fil.bal .
        RUN pdmonth. /*-- Lukkana M. A52-0241 30/09/2009 --*/
            /*nv_netpd  = ROUND(agtprm_fil.gross + nv_vat + nv_tax,2).*/
            /*-----A50-0218 
            IF nv_balos > 0 THEN nv_stos = "O/S > 0".
            ELSE IF nv_balos = 0 THEN nv_stos = "O/S = 0".
            ELSE nv_stos = "O/S < 0".
            --------------*/

            /*-- Lukkana M. A52-0241 30/09/2009 --*/
            IF SUBSTR(agtprm_fil.acno,1,2) = "0F" OR SUBSTR(agtprm_fil.acno,1,2) = "0A" THEN DO: /*งานต่างประเทศไม่คิด vat , tax*/
                ASSIGN nv_vat = 0
                       nv_tax = 0.
            END.
            ELSE DO: 
                nv_poltyp = SUBSTR(agtprm_fil.policy,3,2). 
                IF LOOKUP(nv_poltyp,nv_pa) <> 0 THEN  /* line 60,61,62,63,64,67 ไม่คิด vat , tax */
                   ASSIGN nv_vat = 0
                          nv_tax = 0.
                ELSE 
                    ASSIGN nv_vat  = ROUND(agtprm_fil.gross * 0.07,2)
                           nv_tax  = ROUND(agtprm_fil.gross * 0.01,2).
            END.
            ASSIGN nv_netpd    = ROUND(nv_netbal + nv_vat - nv_tax,2)
                   nv_netpaid  = ROUND(nv_netbal + nv_vat - nv_tax /*- agtprm_fil.odue*/ ,2). /*prem-comm+vat-tax-reserve Lukkana M. A52-0241 21/10/2009*/
            nv_gnetpaid = nv_gnetpaid + nv_netpaid . /*Lukkana M. A52-0241 21/10/2009*/
            /*-- Lukkana M. A52-0241 30/09/2009 --*/

            /*-- Lukkana M. A52-0241 30/09/2009 --
            nv_poltyp = SUBSTR(agtprm_fil.policy,3,2).
            IF LOOKUP(nv_poltyp,nv_pa) <> 0 THEN 
               ASSIGN nv_vat = 0
                      nv_tax = 0.
            ELSE 
                ASSIGN nv_vat  = ROUND(agtprm_fil.gross * 0.07,2)
                       nv_tax    = ROUND(agtprm_fil.gross * 0.01,2).

            nv_netpd  = ROUND(nv_netbal + nv_vat - nv_tax,2).
            /*----------------*/
        {Wac/Wacr2001.i}
        -- Lukkana M. A52-0241 30/09/2009 --*/
        RUN pdRunwacr . /*-- Lukkana M. A52-0241 30/09/2009 --*/
        {wac/wacr2004.i} /*-- Lukkana M. A52-0241 30/09/2009 --*/

        ACCUMULATE
            agtprm_fil.prem      (TOTAL)
            agtprm_fil.comm      (TOTAL)
            agtprm_fil.gross     (TOTAL)
            /*agtprm_fil.odue      (TOTAL) */
            /*----A50-0218*----*/
            agtprm_fil.bal       (TOTAL)
            nv_vat               (TOTAL)
            nv_tax               (TOTAL)   
            nv_netpd             (TOTAL)  
            nv_netpaid           (TOTAL)  /*Lukkana M. A52-0241 21/10/2009*/
            agtprm_fil.comm_comp (TOTAL). /*Lukkana M. A52-0241 21/10/2009*/
            /*-----------------*/

        /********************** Page Footer *********************/
        /*** export ข้อมูลลง DETAIL FILE บรรทัด Grand Total  และ  
                             SUMMARY FILE บรรทัด Grand Total ***/
        IF LAST(agtprm_fil.acno) THEN DO:
            IF (nv_DetSum = "Detail")  OR (nv_DetSum = "All") THEN DO:
                OUTPUT TO VALUE (n_OutputFile ) APPEND NO-ECHO.
                ASSIGN
                    nv_gprem   = (ACCUM TOTAL agtprm_fil.prem)
                    nv_gcomm   = (ACCUM TOTAL agtprm_fil.comm)
                    nv_gnet    = (ACCUM TOTAL agtprm_fil.gross)
                     /*--A50-0218---*/
                    nv_gvat    = (ACCUM TOTAL nv_vat)
                    nv_gtax    = (ACCUM TOTAL nv_tax)
                    nv_gnetpd   = (ACCUM TOTAL nv_netpd)
                    /*-------------*/
                    /*nv_gres    = (ACCUM TOTAL agtprm_fil.odue)*/
                    nv_gbalos  = (ACCUM TOTAL agtprm_fil.bal)
                    /*---
                    nv_gbal    = (ACCUM TOTAL agtprm_fil.gross) - 
                                 (ACCUM TOTAL agtprm_fil.odue) .
                    Lukkana M. A52-0241 05/10/2009---*/
                    
                    nv_gbal    = (ACCUM TOTAL agtprm_fil.gross)  /*--Lukkana M. A52-0241 05/10/2009---*/
                    nv_gsumin  = (ACCUM TOTAL agtprm_fil.comm_comp). /*--Lukkana M. A52-0241 05/10/2009---*/
                   /*----A50-0218----
                   IF nv_gbalos > 0 THEN nv_gstos = "O/S > 0".
                   ELSE IF nv_gbalos = 0 THEN nv_gstos = "O/S = 0".
                   ELSE nv_gstos = "O/S < 0".
                   ----------------*/
                RUN pdFooterDet.
                OUTPUT CLOSE.
            END.  /* (nv_DetSum = "Detail")  OR (nv_DetSum = "All") */

            IF (nv_DetSum = "Summary")  OR (nv_DetSum = "All") THEN DO:
                OUTPUT TO VALUE (n_OutputFileSum ) APPEND NO-ECHO.
                ASSIGN
                    nv_gprem   = (ACCUM TOTAL agtprm_fil.prem)
                    nv_gcomm   = (ACCUM TOTAL agtprm_fil.comm)
                    nv_gnet    = (ACCUM TOTAL agtprm_fil.gross)
                    /*nv_gres    = (ACCUM TOTAL agtprm_fil.odue)*/
                    /*--
                    nv_gbal    = (ACCUM TOTAL agtprm_fil.gross) - 
                                 (ACCUM TOTAL agtprm_fil.odue) .
                    Lukkana M. A52-0241 05/10/2009---*/
                    nv_gbal    = (ACCUM TOTAL agtprm_fil.gross)  /*--Lukkana M. A52-0241 05/10/2009---*/
                    nv_ngbal   = (ACCUM TOTAL agtprm_fil.gross) /*-(ACCUM TOTAL agtprm_fil.odue)*/ . /*--Lukkana M. A52-0241 05/10/2009---*/
                RUN pdFooterSum.
                OUTPUT CLOSE.
                /*---------A50-0218-----------*/
                OUTPUT TO VALUE (n_OutputFileNet ) APPEND NO-ECHO.
                ASSIGN
                    nv_gprem   = (ACCUM TOTAL agtprm_fil.prem)
                    nv_gcomm   = (ACCUM TOTAL agtprm_fil.comm)
                    nv_gnet    = (ACCUM TOTAL agtprm_fil.gross)
                    /*nv_gres    = (ACCUM TOTAL agtprm_fil.odue)*/
                    /*--
                    nv_gbal    = (ACCUM TOTAL agtprm_fil.gross) - 
                                 (ACCUM TOTAL agtprm_fil.odue) .
                    Lukkana M. A52-0241 05/10/2009--*/
                    nv_gbal    = (ACCUM TOTAL agtprm_fil.gross) . /*--Lukkana M. A52-0241 05/10/2009--*/
                RUN pdFooterNet.
                OUTPUT CLOSE.
                /*----------------------------*/               
            END.  /* (nv_DetSum = "Summary")  OR (nv_DetSum = "All") */
            RUN pdInitDataG.    /* clear data */
        END. /* if last(agtprm_fil.acno) then */
    END. /* for each agtprm_fil*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdAcnoDet082 wacr2001 
PROCEDURE pdAcnoDet082 :
/*------------------------------------------------------------------------------
  Purpose: Aging Detail  By Acno  [Outward O/S = 0]  A50-0218
------------------------------------------------------------------------------*/
    
    /*-----------------*/
    ASSIGN nv_blankX = FILL(" ",8)
           nv_stotal = 0.
    
    /********************** Page Header *********************/        
    /*--- DISPLAY DETAIL  ---*/
    IF (nv_DetSum = "Detail")  OR (nv_DetSum = "All") THEN DO:
        OUTPUT TO VALUE (n_OutputFile ) NO-ECHO.
            RUN pdTitleDet.   
            RUN pdPageHeadDet.
        OUTPUT CLOSE.
    END.  /* (nv_DetSum = "Detail")  OR (nv_DetSum = "All") */
    
    /*** DISPLAY SUMMARY FILE & SUMMARY GRAND TOTAL***/
    IF (nv_DetSum = "Summary")  OR (nv_DetSum = "All") THEN DO:
        OUTPUT TO VALUE (n_OutputFileSum) NO-ECHO.  /* SUMMARY */
            RUN pdTitleSum.
            RUN pdPageHeadSum.
        OUTPUT CLOSE.

        /*---By A50-0218----*/
        OUTPUT TO VALUE (n_OutputFileNet) NO-ECHO.  /* NETBAL */
            RUN pdTitleNet.
            RUN pdPageHeadNet.
        OUTPUT CLOSE.
        /*------------------*/        
    END.  /* (nv_DetSum = "Summary")  OR (nv_DetSum = "All")  */    

    /*-- Lukkana M. A52-0241 30/09/2009 --*/
    IF MONTH(fiasdat) = MONTH(fiasdatAging) THEN 
        ASSIGN nv_gap = 12 - MONTH(fiasdatAging).
    ELSE ASSIGN nv_gap = 12 - MONTH(fiasdatAging) + 1 .
    /*-- Lukkana M. A52-0241 30/09/2009 --*/
    /*ASSIGN nv_gap = 12 - MONTH(fiasdatAging). -- Lukkana M. A52-0241 30/09/2009 --*/

    FOR EACH  agtprm_fil USE-INDEX by_acno WHERE
              agtprm_fil.asdat        =  n_asdat        AND
             (agtprm_fil.acno        >=  n_frac         AND
              agtprm_fil.acno        <=  n_toac )       AND
     ( SUBSTR(agtprm_fil.policy,3,2) >=  nv_poltypFr    AND
       SUBSTR(agtprm_fil.policy,3,2) <=  nv_poltypTo)   AND
             (agtprm_fil.polbran     >=  n_branch       AND 
              agtprm_fil.polbran     <=  n_branch2)     AND
      (LOOKUP(SUBSTR(agtprm_fil.trntyp,1,1) , nv_trntyp1) <> 0 ) AND
              agtprm_fil.poldes       = "O/S = 0"         
    NO-LOCK BREAK BY agtprm_fil.acno
                  BY agtprm_fil.trndat
                  BY SUBSTR(agtprm_fil.policy,3,2)
                  BY agtprm_fil.policy
                  BY agtprm_fil.endno.
        /*    NO-LOCK BREAK BY agtprm_fil.acno BY agtprm_fil.polbran BY agtprm_fil.trndat. */

        DISP  /*agtprm_fil.acno --- A500178 ---*/  
              agtprm_fil.acno FORMAT "X(10)"
              agtprm_fil.trndat     /* Trans. Date */
              agtprm_fil.policy
              agtprm_fil.endno
              agtprm_fil.trntyp
              agtprm_fil.docno  FORMAT "x(10)"  /* Benjaporn J. A60-0267 date 27/06/2017 */
        WITH COLOR BLACK/WHITE NO-LABEL FRAME frProcess VIEW-AS DIALOG-BOX
        TITLE  "  Processing...  ".

        n_asdat = IF nv_asdatAging = ? THEN n_asdat ELSE nv_asdatAging.

        /* Begin */
        /********************** Group Header *********************/
            
        IF FIRST-OF(agtprm_fil.acno)  THEN DO:
            nv_acname = "".
            FIND xmm600 USE-INDEX xmm60001 WHERE
                 xmm600.acno = agtprm_fil.acno NO-LOCK NO-ERROR.
            IF AVAIL xmm600 THEN
               ASSIGN  nv_acname = TRIM(xmm600.ntitle) + " " + TRIM(xmm600.name) 
                       nv_relate = xmm600.agtreg   /*A50-0218*/
                       nv_notes1 = xmm600.notes1 . /*--Lukkana M. A52-0241 08/10/2009--*/
            ELSE ASSIGN nv_acname = " " 
                        nv_relate = ""
                        nv_notes1 = "" . /*--Lukkana M. A52-0241 08/10/2009--*/
            /*--- DISPLAY DETAIL ---*/
            IF (nv_DetSum = "Detail")  OR (nv_DetSum = "All") THEN DO:
                OUTPUT TO VALUE (STRING(n_OutputFile ) ) APPEND NO-ECHO.
                    EXPORT DELIMITER ";" " ".
                    EXPORT DELIMITER ";"
                        agtprm_fil.acno + " - " + nv_acname + "   <" +
                        agtprm_fil.acno_clicod  + ">" .
                OUTPUT CLOSE.
            END.  /*  (nv_DetSum = "Detail") OR (nv_DetSum = "All") */
            /*--- DISPLAY SUMMARY ---*/
            IF (nv_DetSum = "Summary") OR (nv_DetSum = "All") THEN DO:
                OUTPUT TO VALUE (n_OutputFileSum) APPEND NO-ECHO.  /* SUMMARY */
                    EXPORT DELIMITER ";" " ".
                    /*--
                    EXPORT DELIMITER ";"
                        agtprm_fil.acno + " - " + nv_acname .
                    Lukkana M. A52-0241 08/10/2009--*/
                OUTPUT CLOSE.
            END.  /* (nv_DetSum = "Summary")  OR (nv_DetSum = "All")  */
        END.  /* first-of(agtprm_fil.acno) */
        ASSIGN 
            nv_num    = 0
            nv_netbal = 0
            /*--
            nv_num    = MONTH(agtprm_fil.asdat) - MONTH(agtprm_fil.trndat) + 1
            nv_netbal = agtprm_fil.gross - agtprm_fil.odue 
            Lukkana M. a52-0241 05/10/2009---*/
            
            nv_netbal = agtprm_fil.gross  /*--Lukkana M. a52-0241 05/10/2009---*/
            /*----A50-0218----*/
            nv_balos  = 0       
            nv_vat    = 0
            nv_tax    = 0
            nv_netpd  = 0
            nv_netpaid  = 0 /*Lukkana M. A52-0241 21/10/2009*/
            nv_balos  = agtprm_fil.bal.   
        RUN pdmonth. /*-- Lukkana M. A52-0241 30/09/2009 --*/
            /*nv_netpd  = ROUND(agtprm_fil.gross + nv_vat + nv_tax,2).*/
            /*----A50-0218
            IF nv_balos > 0 THEN nv_stos = "O/S > 0".
            ELSE IF nv_balos = 0 THEN nv_stos = "O/S = 0".
            ELSE nv_stos = "O/S < 0".
            ------------*/
            /*-- Lukkana M. A52-0241 30/09/2009 --*/
            IF SUBSTR(agtprm_fil.acno,1,2) = "0F" OR SUBSTR(agtprm_fil.acno,1,2) = "0A" THEN DO: /*งานต่างประเทศไม่คิด vat , tax*/
                ASSIGN nv_vat = 0
                       nv_tax = 0.
            END.
            ELSE DO: 
                nv_poltyp = SUBSTR(agtprm_fil.policy,3,2). 
                IF LOOKUP(nv_poltyp,nv_pa) <> 0 THEN  /* line 60,61,62,63,64,67 ไม่คิด vat , tax */
                   ASSIGN nv_vat = 0
                          nv_tax = 0.
                ELSE 
                    ASSIGN nv_vat  = ROUND(agtprm_fil.gross * 0.07,2)
                           nv_tax  = ROUND(agtprm_fil.gross * 0.01,2).
            END.
            ASSIGN nv_netpd    = ROUND(nv_netbal + nv_vat - nv_tax,2)
                   nv_netpaid  = ROUND(nv_netbal + nv_vat - nv_tax /*- agtprm_fil.odue*/ ,2). /*Lukkana M. A52-0241 21/10/2009*/
            nv_gnetpaid = nv_gnetpaid + nv_netpaid . /*Lukkana M. A52-0241 21/10/2009*/
            /*-- Lukkana M. A52-0241 30/09/2009 --*/

            /*-- Lukkana M. A52-0241 30/09/2009 --
            nv_poltyp = SUBSTR(agtprm_fil.policy,3,2).
            IF LOOKUP(nv_poltyp,nv_pa) <> 0 THEN 
               ASSIGN nv_vat = 0
                      nv_tax = 0.
            ELSE 
                ASSIGN nv_vat  = ROUND(agtprm_fil.gross * 0.07,2)
                       nv_tax    = ROUND(agtprm_fil.gross * 0.01,2).

            nv_netpd  = ROUND(nv_netbal + nv_vat - nv_tax,2).
            /*----------------*/
            
        {Wac/Wacr2001.i}  
        -- Lukkana M. A52-0241 30/09/2009 --*/
        RUN pdRunwacr. /*-- Lukkana M. A52-0241 30/09/2009 --*/
        {wac/wacr2004.i} /*-- Lukkana M. A52-0241 30/09/2009 --*/
        
        ACCUMULATE
            agtprm_fil.prem      (TOTAL)
            agtprm_fil.comm      (TOTAL)
            agtprm_fil.gross     (TOTAL)
            /*agtprm_fil.odue      (TOTAL) */
            /*----A50-0218*----*/
            agtprm_fil.bal       (TOTAL)
            nv_vat               (TOTAL)
            nv_tax               (TOTAL)   
            nv_netpd             (TOTAL)  
            nv_netpaid           (TOTAL)   /*Lukkana M. A52-0241 21/10/2009*/
            agtprm_fil.comm_comp (TOTAL). /*Lukkana M. A52-0241 21/10/2009*/
                
            /*-----------------*/
        /********************** Page Footer *********************/
        /*** export ข้อมูลลง DETAIL FILE บรรทัด Grand Total  และ  
                             SUMMARY FILE บรรทัด Grand Total ***/
        IF LAST(agtprm_fil.acno) THEN DO:
            IF (nv_DetSum = "Detail")  OR (nv_DetSum = "All") THEN DO:
                OUTPUT TO VALUE (n_OutputFile ) APPEND NO-ECHO.
                ASSIGN
                    nv_gprem   = (ACCUM TOTAL agtprm_fil.prem)
                    nv_gcomm   = (ACCUM TOTAL agtprm_fil.comm)
                    nv_gnet    = (ACCUM TOTAL agtprm_fil.gross)
                     /*--A50-0218---*/
                    nv_gvat    = (ACCUM TOTAL nv_vat)
                    nv_gtax    = (ACCUM TOTAL nv_tax)
                    nv_gnetpd    = (ACCUM TOTAL nv_netpd)
                    
                    /*-------------*/
                    /*nv_gres    = (ACCUM TOTAL agtprm_fil.odue)*/
                    nv_gbalos  = (ACCUM TOTAL agtprm_fil.bal)
                    /*---
                    nv_gbal    = (ACCUM TOTAL agtprm_fil.gross) - 
                                 (ACCUM TOTAL agtprm_fil.odue) .
                    Lukkana M. A52-0241 05/10/2009---*/
                    
                    nv_gbal    = (ACCUM TOTAL agtprm_fil.gross)  /*--Lukkana M. A52-0241 05/10/2009---*/
                    nv_gsumin  = (ACCUM TOTAL agtprm_fil.comm_comp). /*--Lukkana M. A52-0241 05/10/2009---*/            
                   /*----A50-0218----
                   IF nv_gbalos > 0 THEN nv_gstos = "O/S > 0".
                   ELSE IF nv_gbalos = 0 THEN nv_gstos = "O/S = 0".
                   ELSE nv_gstos = "O/S < 0".
                   ----------------*/
                RUN pdFooterDet.
                OUTPUT CLOSE.
            END.  /* (nv_DetSum = "Detail")  OR (nv_DetSum = "All") */

            IF (nv_DetSum = "Summary")  OR (nv_DetSum = "All") THEN DO:
                OUTPUT TO VALUE (n_OutputFileSum ) APPEND NO-ECHO.
                ASSIGN
                    nv_gprem   = (ACCUM TOTAL agtprm_fil.prem)
                    nv_gcomm   = (ACCUM TOTAL agtprm_fil.comm)
                    nv_gnet    = (ACCUM TOTAL agtprm_fil.gross)
                    /*nv_gres    = (ACCUM TOTAL agtprm_fil.odue)*/
                    /*--
                    nv_gbal    = (ACCUM TOTAL agtprm_fil.gross) - 
                                 (ACCUM TOTAL agtprm_fil.odue) .
                    Lukkana M. A52-0241 05/10/2009---*/

                    nv_gbal    = (ACCUM TOTAL agtprm_fil.gross)  /*--Lukkana M. A52-0241 05/10/2009---*/
                    nv_ngbal   = (ACCUM TOTAL agtprm_fil.gross) /*-(ACCUM TOTAL agtprm_fil.odue)*/ . /*--Lukkana M. A52-0241 05/10/2009---*/
                
                RUN pdFooterSum.
                OUTPUT CLOSE.
                /*---------A50-0218-----------*/
                OUTPUT TO VALUE (n_OutputFileNet ) APPEND NO-ECHO.
                ASSIGN
                    nv_gprem   = (ACCUM TOTAL agtprm_fil.prem)
                    nv_gcomm   = (ACCUM TOTAL agtprm_fil.comm)
                    nv_gnet    = (ACCUM TOTAL agtprm_fil.gross)
                    /*nv_gres    = (ACCUM TOTAL agtprm_fil.odue)*/
                    /*--
                    nv_gbal    = (ACCUM TOTAL agtprm_fil.gross) - 
                                 (ACCUM TOTAL agtprm_fil.odue) .
                    Lukkana M. A52-0241 05/10/2009--*/

                    nv_gbal    = (ACCUM TOTAL agtprm_fil.gross) . /*--Lukkana M. A52-0241 05/10/2009--*/

                RUN pdFooterNet.
                OUTPUT CLOSE.
                /*----------------------------*/                
            END.  /* (nv_DetSum = "Summary")  OR (nv_DetSum = "All") */
            RUN pdInitDataG.    /* clear data */
        END. /* if last(agtprm_fil.acno) then */
    END. /* for each agtprm_fil*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdAcnoDet083 wacr2001 
PROCEDURE pdAcnoDet083 :
/*------------------------------------------------------------------------------
  Purpose: Aging Detail  By Acno  [Outward O/S <= 0]  A50-0218
------------------------------------------------------------------------------*/

    /*-----------------*/
    ASSIGN nv_blankX = FILL(" ",8)
           nv_stotal = 0.
    /********************** Page Header *********************/    
    /*--- DISPLAY DETAIL  ---*/
    IF (nv_DetSum = "Detail")  OR (nv_DetSum = "All") THEN DO:
        OUTPUT TO VALUE (n_OutputFile ) NO-ECHO.
            RUN pdTitleDet.   
            RUN pdPageHeadDet.
        OUTPUT CLOSE.
    END.  /* (nv_DetSum = "Detail")  OR (nv_DetSum = "All") */
    
    /*** DISPLAY SUMMARY FILE & SUMMARY GRAND TOTAL***/
    IF (nv_DetSum = "Summary")  OR (nv_DetSum = "All") THEN DO:
        OUTPUT TO VALUE (n_OutputFileSum) NO-ECHO.  /* SUMMARY */
            RUN pdTitleSum.
            RUN pdPageHeadSum.
        OUTPUT CLOSE.

        /*---By A50-0218----*/
        OUTPUT TO VALUE (n_OutputFileNet) NO-ECHO.  /* NETBAL */
            RUN pdTitleNet.
            RUN pdPageHeadNet.
        OUTPUT CLOSE.
        /*------------------*/        
    END.  /* (nv_DetSum = "Summary")  OR (nv_DetSum = "All")  */
    
    /*-- Lukkana M. A52-0241 30/09/2009 --*/
    IF MONTH(fiasdat) = MONTH(fiasdatAging) THEN 
        ASSIGN nv_gap = 12 - MONTH(fiasdatAging).
    ELSE ASSIGN nv_gap = 12 - MONTH(fiasdatAging) + 1 .
    /*-- Lukkana M. A52-0241 30/09/2009 --*/
    /* ASSIGN nv_gap = 12 - MONTH(fiasdatAging). -- Lukkana M. A52-0241 30/09/2009 --*/

    FOR EACH  agtprm_fil USE-INDEX by_acno WHERE
              agtprm_fil.asdat        =  n_asdat        AND
             (agtprm_fil.acno        >=  n_frac         AND
              agtprm_fil.acno        <=  n_toac )       AND
     ( SUBSTR(agtprm_fil.policy,3,2) >=  nv_poltypFr    AND
       SUBSTR(agtprm_fil.policy,3,2) <=  nv_poltypTo)   AND
             (agtprm_fil.polbran     >=  n_branch       AND 
              agtprm_fil.polbran     <=  n_branch2)     AND
      (LOOKUP(SUBSTR(agtprm_fil.trntyp,1,1) , nv_trntyp1) <> 0 ) AND
              (agtprm_fil.poldes         =  "O/S = 0"   OR
               agtprm_fil.poldes         =  "O/S < 0")      
    NO-LOCK BREAK BY agtprm_fil.acno
                  BY agtprm_fil.trndat
                  BY SUBSTR(agtprm_fil.policy,3,2)
                  BY agtprm_fil.policy
                  BY agtprm_fil.endno.
        /*    NO-LOCK BREAK BY agtprm_fil.acno BY agtprm_fil.polbran BY agtprm_fil.trndat. */

        DISP  /*agtprm_fil.acno --- A500178 ---*/  
              agtprm_fil.acno FORMAT "X(10)"
              agtprm_fil.trndat     /* Trans. Date */
              agtprm_fil.policy
              agtprm_fil.endno
              agtprm_fil.trntyp
              agtprm_fil.docno FORMAT "x(10)" /* Benjaporn J. A60-0267 date 27/06/2017 */
        WITH COLOR BLACK/WHITE NO-LABEL FRAME frProcess VIEW-AS DIALOG-BOX
        TITLE  "  Processing...  ".

        n_asdat = IF nv_asdatAging = ? THEN n_asdat ELSE nv_asdatAging.

        /* Begin */
        /********************** Group Header *********************/
            
        IF FIRST-OF(agtprm_fil.acno)  THEN DO:
            nv_acname = "".
            FIND xmm600 USE-INDEX xmm60001 WHERE
                 xmm600.acno = agtprm_fil.acno NO-LOCK NO-ERROR.
            IF AVAIL xmm600 THEN
               ASSIGN  nv_acname = TRIM(xmm600.ntitle) + " " + TRIM(xmm600.name) 
                       nv_relate = xmm600.agtreg   /*A50-0218*/
                       nv_notes1 = xmm600.notes1 . /*--Lukkana M. A52-0241 08/10/2009--*/
            ELSE ASSIGN nv_acname = " " 
                        nv_relate = ""
                        nv_notes1 = "" . /*--Lukkana M. A52-0241 08/10/2009--*/
            /*--- DISPLAY DETAIL ---*/
            IF (nv_DetSum = "Detail")  OR (nv_DetSum = "All") THEN DO:
                OUTPUT TO VALUE (STRING(n_OutputFile ) ) APPEND NO-ECHO.
                    EXPORT DELIMITER ";" " ".
                    EXPORT DELIMITER ";"
                        agtprm_fil.acno + " - " + nv_acname + "   <" +
                        agtprm_fil.acno_clicod  + ">" .
                OUTPUT CLOSE.
            END.  /*  (nv_DetSum = "Detail") OR (nv_DetSum = "All") */
            
            /*--- DISPLAY SUMMARY ---*/
            IF (nv_DetSum = "Summary") OR (nv_DetSum = "All") THEN DO:
                OUTPUT TO VALUE (n_OutputFileSum) APPEND NO-ECHO.  /* SUMMARY */
                    EXPORT DELIMITER ";" " ".
                    /*--
                    EXPORT DELIMITER ";"
                        agtprm_fil.acno + " - " + nv_acname .
                    Lukkana M. A52-0241 08/10/2009--*/    
                OUTPUT CLOSE.
            END.  /* (nv_DetSum = "Summary")  OR (nv_DetSum = "All")  */
        END.  /* first-of(agtprm_fil.acno) */
        ASSIGN 
            nv_num    = 0
            nv_netbal = 0
            /*---
            nv_num    = MONTH(agtprm_fil.asdat) - MONTH(agtprm_fil.trndat) + 1
            nv_netbal = agtprm_fil.gross - agtprm_fil.odue 
            Lukkana M. a52-0241 05/10/2009---*/
            
            nv_netbal = agtprm_fil.gross  /*--Lukkana M. a52-0241 05/10/2009---*/
            /*----A50-0218----*/
            nv_balos  = 0       
            nv_vat    = 0
            nv_tax    = 0
            nv_netpd  = 0
            nv_netpaid = 0 /*Lukkana M. A52-0241 21/10/2009*/
            nv_balos  = agtprm_fil.bal . 
        RUN pdmonth. /*-- Lukkana M. A52-0241 30/09/2009 --*/
            /*nv_netpd  = ROUND(agtprm_fil.gross + nv_vat + nv_tax,2).*/
            /*-----A50-0218
            IF nv_balos > 0 THEN nv_stos = "O/S > 0".
            ELSE IF nv_balos = 0 THEN nv_stos = "O/S = 0".
            ELSE nv_stos = "O/S < 0".
            --------------*/
            /*-- Lukkana M. A52-0241 30/09/2009 --*/
            IF SUBSTR(agtprm_fil.acno,1,2) = "0F" OR SUBSTR(agtprm_fil.acno,1,2) = "0A" THEN DO: /*งานต่างประเทศไม่คิด vat , tax*/
                ASSIGN nv_vat = 0
                       nv_tax = 0.
            END.
            ELSE DO: 
                nv_poltyp = SUBSTR(agtprm_fil.policy,3,2). 
                IF LOOKUP(nv_poltyp,nv_pa) <> 0 THEN  /* line 60,61,62,63,64,67 ไม่คิด vat , tax */
                   ASSIGN nv_vat = 0
                          nv_tax = 0.
                ELSE 
                    ASSIGN nv_vat  = ROUND(agtprm_fil.gross * 0.07,2)
                           nv_tax  = ROUND(agtprm_fil.gross * 0.01,2).
            END.
            ASSIGN nv_netpd    = ROUND(nv_netbal + nv_vat - nv_tax,2)
                   nv_netpaid  = ROUND(nv_netbal + nv_vat - nv_tax /*- agtprm_fil.odue*/ ,2). /*prem-comm+vat-tax-reserve Lukkana M. A52-0241 21/10/2009*/
            nv_gnetpaid = nv_gnetpaid + nv_netpaid . /*Lukkana M. A52-0241 21/10/2009*/
            /*-- Lukkana M. A52-0241 30/09/2009 --*/
            /*-- Lukkana M. A52-0241 30/09/2009 --
            nv_poltyp = SUBSTR(agtprm_fil.policy,3,2).
            IF LOOKUP(nv_poltyp,nv_pa) <> 0 THEN 
               ASSIGN nv_vat = 0
                      nv_tax = 0.
            ELSE 
                ASSIGN nv_vat  = ROUND(agtprm_fil.gross * 0.07,2)
                       nv_tax    = ROUND(agtprm_fil.gross * 0.01,2).
            
            nv_netpd  = ROUND(nv_netbal + nv_vat - nv_tax,2).
            /*----------------*/
        
        {Wac/Wacr2001.i}
        -- Lukkana M. A52-0241 30/09/2009 --*/
        RUN pdRunwacr . /*-- Lukkana M. A52-0241 30/09/2009 --*/
        {wac/wacr2004.i} /*-- Lukkana M. A52-0241 30/09/2009 --*/
        ACCUMULATE
            agtprm_fil.prem      (TOTAL)
            agtprm_fil.comm      (TOTAL)
            agtprm_fil.gross     (TOTAL)
            /*agtprm_fil.odue      (TOTAL) */
            /*----A50-0218*----*/
            agtprm_fil.bal       (TOTAL)
            nv_vat               (TOTAL)
            nv_tax               (TOTAL)   
            nv_netpd             (TOTAL)  
            nv_netpaid           (TOTAL)  /*Lukkana M. A52-0241 21/10/2009*/
            agtprm_fil.comm_comp (TOTAL). /*Lukkana M. A52-0241 21/10/2009*/
            /*-----------------*/
        /********************** Page Footer *********************/
        /*** export ข้อมูลลง DETAIL FILE บรรทัด Grand Total  และ  
                             SUMMARY FILE บรรทัด Grand Total ***/
        IF LAST(agtprm_fil.acno) THEN DO:
            IF (nv_DetSum = "Detail")  OR (nv_DetSum = "All") THEN DO:
                OUTPUT TO VALUE (n_OutputFile ) APPEND NO-ECHO.
                ASSIGN
                    nv_gprem   = (ACCUM TOTAL agtprm_fil.prem)
                    nv_gcomm   = (ACCUM TOTAL agtprm_fil.comm)
                    nv_gnet    = (ACCUM TOTAL agtprm_fil.gross)
                     /*--A50-0218---*/
                    nv_gvat    = (ACCUM TOTAL nv_vat)
                    nv_gtax    = (ACCUM TOTAL nv_tax)
                    nv_gnetpd    = (ACCUM TOTAL nv_netpd)
                    /*-------------*/
                    /*nv_gres    = (ACCUM TOTAL agtprm_fil.odue)*/
                    nv_gbalos  = (ACCUM TOTAL agtprm_fil.bal)
                    /*---
                    nv_gbal    = (ACCUM TOTAL agtprm_fil.gross) - 
                                 (ACCUM TOTAL agtprm_fil.odue) .
                    Lukkana M. A52-0241 05/10/2009---*/
                    nv_gbal    = (ACCUM TOTAL agtprm_fil.gross)  /*--Lukkana M. A52-0241 05/10/2009---*/
                    nv_gsumin  = (ACCUM TOTAL agtprm_fil.comm_comp). /*--Lukkana M. A52-0241 05/10/2009---*/   
                   /*----A50-0218----
                   IF nv_gbalos > 0 THEN nv_gstos = "O/S > 0".
                   ELSE IF nv_gbalos = 0 THEN nv_gstos = "O/S = 0".
                   ELSE nv_gstos = "O/S < 0".
                   ----------------*/
                RUN pdFooterDet.
                OUTPUT CLOSE.
            END.  /* (nv_DetSum = "Detail")  OR (nv_DetSum = "All") */
            IF (nv_DetSum = "Summary")  OR (nv_DetSum = "All") THEN DO:
                OUTPUT TO VALUE (n_OutputFileSum ) APPEND NO-ECHO.
                ASSIGN
                    nv_gprem   = (ACCUM TOTAL agtprm_fil.prem)
                    nv_gcomm   = (ACCUM TOTAL agtprm_fil.comm)
                    nv_gnet    = (ACCUM TOTAL agtprm_fil.gross)
                    /*nv_gres    = (ACCUM TOTAL agtprm_fil.odue)*/
                    /*--
                    nv_gbal    = (ACCUM TOTAL agtprm_fil.gross) - 
                                 (ACCUM TOTAL agtprm_fil.odue) .
                    Lukkana M. A52-0241 05/10/2009---*/
                    nv_gbal    = (ACCUM TOTAL agtprm_fil.gross)  /*--Lukkana M. A52-0241 05/10/2009---*/
                    nv_ngbal   = (ACCUM TOTAL agtprm_fil.gross) /*-(ACCUM TOTAL agtprm_fil.odue)*/ . /*--Lukkana M. A52-0241 05/10/2009---*/
                RUN pdFooterSum.
                OUTPUT CLOSE.
                /*---------A50-0218-----------*/
                OUTPUT TO VALUE (n_OutputFileNet ) APPEND NO-ECHO.
                ASSIGN
                    nv_gprem   = (ACCUM TOTAL agtprm_fil.prem)
                    nv_gcomm   = (ACCUM TOTAL agtprm_fil.comm)
                    nv_gnet    = (ACCUM TOTAL agtprm_fil.gross)
                    /*nv_gres    = (ACCUM TOTAL agtprm_fil.odue)*/
                    /*--
                    nv_gbal    = (ACCUM TOTAL agtprm_fil.gross) - 
                                 (ACCUM TOTAL agtprm_fil.odue) .
                    Lukkana M. A52-0241 05/10/2009--*/
                    nv_gbal    = (ACCUM TOTAL agtprm_fil.gross) . /*--Lukkana M. A52-0241 05/10/2009--*/
                RUN pdFooterNet.
                OUTPUT CLOSE.
                /*----------------------------*/               

            END.  /* (nv_DetSum = "Summary")  OR (nv_DetSum = "All") */
            RUN pdInitDataG.    /* clear data */
        END. /* if last(agtprm_fil.acno) then */
    END. /* for each agtprm_fil*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdAsgRB wacr2001 
PROCEDURE pdAsgRB :
/*------------------------------------------------------------------------------
  Purpose:     By A50-0218
  Parameters:  <none>
  Notes:     Assign for RB Parameter  
------------------------------------------------------------------------------*/
RB-OTHER-PARAMETERS  = 
          "~nrb_policy    = "    + p_policy      + 
          "~nrb_trndat    = "    + p_trndat      +  
          "~nrb_acno      = "    + p_acno        +  
          "~nrb_acname    = "    + p_acname      +
          "~nrb_endno     = "    + p_endno       +
          "~nrb_comdat    = "    + p_comdat      +
          "~nrb_docno     = "    + p_docno       +
          "~nrb_insure    = "    + p_insure      +
          "~nrb_prem      = "    + p_prem        +
          "~nrb_stamp     = "    + p_stamp       +
          "~nrb_tax       = "    + p_tax         +
          "~nrb_comm      = "    + p_comm        +
          "~nrb_bal       = "    + p_bal         +
          "~nrb_duedat    = "    + p_duedat      +
          "~nrb_cedpol    = "    + p_cedpol      +
          "~nrb_pich      = "    + nv_a4a_07      . /*ADD Saharat S. A62-0279*/

    
   RUN pdRunRB.
     

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdAviva wacr2001 
PROCEDURE pdAviva :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
OUTPUT TO VALUE (n_OutputFileAvi) NO-ECHO.
    RUN pdTitleAvi.   
    RUN pdPageHeadAvi.
OUTPUT CLOSE.

/* Aviva Inward  */
IF nv_reptyp = "07" THEN DO:  
    RUN pdIwAvi.    
END.

/* Aviva Outward */
ELSE DO:               
    IF      nv_ostyp = "O/S > 0" THEN RUN pdOwAvi081.    
    ELSE IF nv_ostyp = "O/S = 0" THEN RUN pdOwAvi082.
    ELSE IF nv_ostyp = "O/S <= 0" THEN RUN pdOwAvi083.
    ELSE RUN pdOwAvi08.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdBodyNzi wacr2001 
PROCEDURE pdBodyNzi :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
    IF      SUBSTR(agtprm_fil.policy,1,2) = "I1" THEN DO:
        nv_chkno   = 1. 
        nv_nzibran = "I1 MM".
    END.
    ELSE IF SUBSTR(agtprm_fil.policy,1,2) = "I2" THEN DO: 
        nv_chkno   = 2.
        nv_nzibran = "I2 PI".
    END.
    ELSE IF SUBSTR(agtprm_fil.policy,1,2) = "I7" THEN DO:
        nv_chkno   = 3.
        nv_nzibran = "I7 MM".
    END.
    ELSE IF SUBSTR(agtprm_fil.policy,1,2) = "I3" OR SUBSTR(agtprm_fil.policy,1,2) = "I4" OR
            SUBSTR(agtprm_fil.policy,1,2) = "I5" OR SUBSTR(agtprm_fil.policy,1,2) = "I6" OR 
            SUBSTR(agtprm_fil.policy,1,2) = "I8" THEN DO:
        nv_chkno   = 4. 
        nv_nzibran = "Other".
    END.
    ELSE DO:
        nv_chkno   = 5.
        nv_nzibran = "Safety".
    END.

    FIND FIRST tnzi WHERE tnzi.tacno = agtprm_fil.acno AND tnzi.tchkno = nv_chkno NO-LOCK NO-ERROR.
    IF AVAIL tnzi THEN DO:
        ASSIGN                      
            tnzi.tnzibal[1] = tnzi.tnzibal[1] + agtprm_fil.gross
            tnzi.tnzibal[2] = tnzi.tnzibal[2] + nv_nzibal[18]
            tnzi.tnzibal[3] = tnzi.tnzibal[3] + nv_nzibal[1]
            tnzi.tnzibal[4] = tnzi.tnzibal[4] + nv_nzibal[2]
            tnzi.tnzibal[5] = tnzi.tnzibal[5] + nv_nzibal[3]
            tnzi.tnzibal[6] = tnzi.tnzibal[6] + (nv_nzibal[4]  + nv_nzibal[5]  + nv_nzibal[6])
            tnzi.tnzibal[7] = tnzi.tnzibal[7] + (nv_nzibal[7]  + nv_nzibal[8]  + nv_nzibal[9])
            tnzi.tnzibal[8] = tnzi.tnzibal[8] + (nv_nzibal[10] + nv_nzibal[11] + nv_nzibal[12])
            tnzi.tnzibal[9] = tnzi.tnzibal[9] + (nv_nzibal[13] + nv_nzibal[15] + nv_nzibal[16] + nv_nzibal[17]).
    END.
    ELSE DO:
        CREATE tnzi.
        ASSIGN       
            tnzi.tbran      = nv_nzibran
            tnzi.trelate    = nv_relate
            tnzi.tacno      = agtprm_fil.acno
            tnzi.tacname    = nv_acname            
            tnzi.tchkno     = nv_chkno
            tnzi.tnotes     = nv_notes1
            tnzi.tnzibal[1] = agtprm_fil.gross
            tnzi.tnzibal[2] = nv_nzibal[18]                                                   
            tnzi.tnzibal[3] = nv_nzibal[1]                                                    
            tnzi.tnzibal[4] = nv_nzibal[2]                                                    
            tnzi.tnzibal[5] = nv_nzibal[3]                                                    
            tnzi.tnzibal[6] = (nv_nzibal[4]  + nv_nzibal[5]  + nv_nzibal[6])                    
            tnzi.tnzibal[7] = (nv_nzibal[7]  + nv_nzibal[8]  + nv_nzibal[9])                    
            tnzi.tnzibal[8] = (nv_nzibal[10] + nv_nzibal[11] + nv_nzibal[12])                 
            tnzi.tnzibal[9] = (nv_nzibal[13] + nv_nzibal[15] + nv_nzibal[16] + nv_nzibal[17]).
    END.  

    nv_nzibal = 0.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdFooterAvi wacr2001 
PROCEDURE pdFooterAvi :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
nv_blankF = FILL(" " , 15).

/********************** Page Footer *********************/

IF nv_reptyp = "07" THEN 
    EXPORT DELIMITER ";"
        "Grand Total"
        nv_blankF[1 FOR 12]       
        nv_gsumins
        nv_gprem
        nv_gcomm
        nv_blankF[1 FOR 2]
        nv_gnetam              
        nv_gvat7
        nv_grese
        nv_gyous
        nv_blankX[1 FOR 2] 
        nv_gbal.
            
ELSE EXPORT DELIMITER ";"
        "Grand Total"
        nv_blankF[1 FOR 12]   
        nv_gsumin
        nv_gprem
        nv_gcomm
        nv_blankX[1 FOR 2]
        nv_gnet         
        nv_gvat7
        nv_grese
        nv_gyous
        nv_blankX[1 FOR 2]
        nv_gbalos.     
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdFooterDet wacr2001 
PROCEDURE pdFooterDet :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
nv_blankF = FILL(" " , 15).

/********************** Page Footer *********************/

EXPORT DELIMITER ";"
    " ".
IF nv_reptyp = "07" THEN 
    EXPORT DELIMITER ";"
        "Grand Total"
       
        nv_blankF[1 FOR 8]       /* ใส่ ช่องว่าง  8 ช่อง */ 
        nv_gsumins /*Lukkana M. A52-0241 15/10/2009*/
        nv_gprem
        /*---A50-0218---*/
        nv_gvat
        nv_gcomm
        nv_gnetam /*Lukkana M. A52-0241 15/10/2009*/
        nv_gtax  
        /*nv_godue /*Lukkana M. A52-0241 21/10/2009*/*/
        nv_gnetpa /*Lukkana M. A52-0241 15/10/2009*/
        
        /*--------------*/
        
        nv_gbal
       
/*         nv_gcomp  */
/*         nv_gstamp */
/*         nv_gtax   */
/*         nv_ggross */
/*         nv_gnetamt */
       
        nv_blankH[1 FOR 2]       /* ใส่ ช่องว่าง  2 ช่อง */

        nv_gtotal[18] /*-- Lukkana M. A52-0241 30/09/2009 --*/
        nv_gtotal[1]
        nv_gtotal[2]
        nv_gtotal[3]
        nv_gtotal[4]
        nv_gtotal[5]
        nv_gtotal[6]
        nv_gtotal[7]
        nv_gtotal[8]
        nv_gtotal[9]
        nv_gtotal[10]
        nv_gtotal[11]
        nv_gtotal[12]
        nv_gtotal[13]
        /*--Lukkana M. A52-0241 16/10/2009--*/
        nv_gtotal[15]
        nv_gtotal[16]
        nv_gtotal[17].
        /*--Lukkana M. A52-0241 16/10/2009--*/
ELSE EXPORT DELIMITER ";"
        "Grand Total"
        nv_blankF[1 FOR 11]       /* ใส่ ช่องว่าง  11 ช่อง */ 
        nv_gsumin /*-- Lukkana M. A52-0241 02/10/2009 --*/
        nv_gprem
        nv_gcomm
        nv_gnet /*-- สลับที่กันเนื่องจากขอเดิมผิด Lukkana M. A52-0241 02/10/2009 --*/
        /*---A50-0218---*/
        nv_gvat
        nv_gtax
        /*---------------*/
        /*nv_gnet -- Lukkana M. A52-0241 02/10/2009 --*/
        /*nv_gres*/
        /*nv_gbal  A50-028*/
        /*---A50-0218---*/
        /*nv_gnetpd Lukkana M. A52-0241 21/10/2009*/
        nv_gnetpaid /*Lukkana M. A52-0241 21/10/2009*/
        nv_gbalos 
        /*--------------*/
       
/*         nv_gcomp  */
/*         nv_gstamp */
/*         nv_gtax   */
/*         nv_ggross */
/*         nv_gnetamt */
       
/*         nv_blankH[1 FOR 2]       /* ใส่ ช่องว่าง  2 ช่อง */ */

        /*--Lukkana M. a52-0241 02/10/2009
        nv_fgtotal[1]
        nv_sgtotal[1]
        nv_fgtotal[2]
        nv_sgtotal[2]
        nv_fgtotal[3]
        nv_sgtotal[3]
        nv_fgtotal[4]
        nv_sgtotal[4]
        nv_fgtotal[5]
        nv_sgtotal[5]
        nv_fgtotal[6]
        nv_sgtotal[6]
        nv_fgtotal[7]
        nv_sgtotal[7]
        nv_fgtotal[8]
        nv_sgtotal[8]
        nv_fgtotal[9]
        nv_sgtotal[9]
        nv_fgtotal[10]
        nv_sgtotal[10]
        nv_fgtotal[11]
        nv_sgtotal[11]
        nv_fgtotal[12]
        nv_sgtotal[12]
        nv_fgtotal[13]
        nv_sgtotal[13]
        Lukkana M. a52-0241 02/10/2009--*/

        /*--Lukkana M. A52-0241 02/10/2009--*/
        nv_stotbal[18]
        nv_stotbal[1]
        nv_stotbal[2]
        nv_stotbal[3]
        nv_stotbal[4]
        nv_stotbal[5]
        nv_stotbal[6]
        nv_stotbal[7]
        nv_stotbal[8]
        nv_stotbal[9]
        nv_stotbal[10]
        nv_stotbal[11]
        nv_stotbal[12]
        nv_stotbal[13]
        nv_stotbal[15] 
        nv_stotbal[16] 
        nv_stotbal[17] 
        /*--Lukkana M. A52-0241 02/10/2009--*/
        nv_gstos  .           /*A50-0218*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdFooterNet wacr2001 
PROCEDURE pdFooterNet :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
nv_blankF = FILL(" " , 15).

/********************** Page Footer *********************/
    EXPORT DELIMITER ";" " ".
    EXPORT DELIMITER ";" " ".                             
    IF nv_reptyp = "07" THEN DO:                          
        EXPORT DELIMITER ";" "" "Grand Net Balance" "" /*nv_gbal*/ nv_nettol nv_sgbal[18] nv_sgbal[1 FOR 13]  /* comment by Phaiboon W. [A59-0125] 20/04/2016 */
                                                                             nv_sgbal[15] nv_sgbal[16] nv_sgbal[17]. /*--Lukkana M. A52-0241 24/09/2009--*/   
        EXPORT DELIMITER ";" "".
        EXPORT DELIMITER ";" "".
        /*EXPORT DELIMITER ";" "" "* Net Balance = Reinsurance Premium - Discount - Reserve". Lukkana M. A52-0241 21/10/2009*/
        EXPORT DELIMITER ";" "" "* Net Balance = Reinsurance Premium - Discount". /*Lukkana M. A52-0241 21/10/2009*/
    END.
    ELSE DO:
        EXPORT DELIMITER ";" "" "Grand Net Balance" "" nv_gbal   nv_sgbal[18] nv_sgbal[1 FOR 13]
                                                                 nv_sgbal[15] nv_sgbal[16] nv_sgbal[17]. /*--Lukkana M. A52-0241 24/09/2009--*/
        EXPORT DELIMITER ";" " ".
        EXPORT DELIMITER ";" " ".
        EXPORT DELIMITER ";" "" "Net Balance By Region".
        EXPORT DELIMITER ";" "" "  *** Reinsurance Asian (RA) ***" "" nv_racodeb[14]  nv_racodeb[18] nv_racodeb[1 FOR 13]
                                                                                      nv_racodeb[15] nv_racodeb[16] nv_racodeb[17]. /*--Lukkana M. A52-0241 24/09/2009--*/
        EXPORT DELIMITER ";".    
        EXPORT DELIMITER ";" "" "  *** Insurance Domesic (RD) ***" "" nv_rdcodeb[14]  nv_rdcodeb[18] nv_rdcodeb[1 FOR 13] 
                                                                                      nv_rdcodeb[15] nv_rdcodeb[16] nv_rdcodeb[17]. /*--Lukkana M. A52-0241 24/09/2009--*/
        EXPORT DELIMITER ";".    
        EXPORT DELIMITER ";" "" "  *** Insurance Foreign (RF) & Reinsurance Broker (RB) ***" "" nv_rfcodeb[14]  nv_rfcodeb[18] nv_rfcodeb[1 FOR 13]
                                                                                                                nv_rfcodeb[15] nv_rfcodeb[16] nv_rfcodeb[17] . /*--Lukkana M. A52-0241 24/09/2009--*/
        EXPORT DELIMITER ";".    
        EXPORT DELIMITER ";" " ".
        /*EXPORT DELIMITER ";" "" "* Net Balance = Reinsurance Premium - Discount - Reserve". Lukkana M. A52-0241 21/10/2009*/
        EXPORT DELIMITER ";" "" "* Net Balance = Reinsurance Premium - Discount". /*Lukkana M. A52-0241 21/10/2009*/
    END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdFooterNzi wacr2001 
PROCEDURE pdFooterNzi :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
EXPORT DELIMITER ";".
EXPORT DELIMITER ";" "" "" "Grand Net Balance" "" nv_nzitol[1] nv_nzitol[2] nv_nzitol[3] nv_nzitol[4]
                                                  nv_nzitol[5] nv_nzitol[6] nv_nzitol[7] nv_nzitol[8] nv_nzitol[9].
EXPORT DELIMITER ";" "".

DO nv_granno = 1 TO 9:
    nv_grantol[nv_granno] = nv_grantol[nv_granno] + nv_nzitol[nv_granno].
END.

nv_nzitol = 0.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdFooterSum wacr2001 
PROCEDURE pdFooterSum :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
nv_blankF = FILL(" " , 15).

/********************** Page Footer *********************/

    EXPORT DELIMITER ";" " ".
    EXPORT DELIMITER ";" " ".

    IF nv_reptyp = "07" THEN DO:
        EXPORT DELIMITER ";" " " /*Lukkana M. A52-0241 19/10/2009*/
                             "GRAND TOTAL".
        EXPORT DELIMITER ";" " " /*Lukkana M. A52-0241 19/10/2009*/ 
                             "Grand Premium"     nv_gprem  nv_sgprem[18] nv_sgprem[1 FOR 13] 
                                                           nv_sgprem[15] nv_sgprem[16] nv_sgprem[17]. /*-- Lukkana M. a52-0241 28/09/2009--*/
        EXPORT DELIMITER ";" " " /*Lukkana M. A52-0241 19/10/2009*/ 
                             "Grand Commission"  nv_gcomm  nv_sgcomm[18] nv_sgcomm[1 FOR 13]
                                                           nv_sgcomm[15] nv_sgcomm[16] nv_sgcomm[17] . /*-- Lukkana M. a52-0241 28/09/2009--*/
        EXPORT DELIMITER ";" " " /*Lukkana M. A52-0241 19/10/2009*/ 
                             "Grand Bal O/S"     nv_gbal   nv_sgbal[18] nv_sgbal[1 FOR 13]
                                                           nv_sgbal[15] nv_sgbal[16] nv_sgbal[17] . /*-- Lukkana M. a52-0241 28/09/2009--*/
    END.
    ELSE DO:

        EXPORT DELIMITER ";" " " /*-- Lukkana M. A52-0241 08/10/2009 เพิ่มคอลัมน์ที่เป็นค่าว่าง--*/
                             "GRAND TOTAL".
        EXPORT DELIMITER ";" " "  /*-- Lukkana M. A52-0241 08/10/2009 เพิ่มคอลัมน์ที่เป็นค่าว่าง--*/
                             "Grand Gross Premium"    nv_gprem  nv_sgprem[18] nv_sgprem[1 FOR 13]
                                                      nv_sgprem[15] nv_sgprem[16] nv_sgprem[17]. /*-- Lukkana M. a52-0241 28/09/2009--*/ 
        EXPORT DELIMITER ";" " " /*-- Lukkana M. A52-0241 08/10/2009 เพิ่มคอลัมน์ที่เป็นค่าว่าง--*/
                             "Grand Commission"       nv_gcomm  nv_sgcomm[18] nv_sgcomm[1 FOR 13]
                                                      nv_sgcomm[15] nv_sgcomm[16] nv_sgcomm[17]. /*-- Lukkana M. a52-0241 28/09/2009--*/
        EXPORT DELIMITER ";" " " /*-- Lukkana M. A52-0241 08/10/2009 เพิ่มคอลัมน์ที่เป็นค่าว่าง--*/
                             "Grand Net Amount"       nv_gnet nv_sgnet[18]  nv_sgnet[1 FOR 13]
                                                      nv_sgnet[15] nv_sgnet[16] nv_sgnet[17]. /*-- Lukkana M. a52-0241 28/09/2009--*/
        /*
        EXPORT DELIMITER ";" " " 
                             "Grand Reserve"  nv_gres nv_sgres[1 FOR 13]
                                                      nv_sgres[15] nv_sgres[16] nv_sgres[17]. 
        -- Lukkana M. a52-0241 28/09/2009--*/
        EXPORT DELIMITER ";" " " /*-- Lukkana M. A52-0241 08/10/2009 เพิ่มคอลัมน์ที่เป็นค่าว่าง--*/
                             "Grand Net Balance"      nv_gbal nv_sgbal[18]  nv_sgbal[1 FOR 13]
                                                      nv_sgbal[15] nv_sgbal[16] nv_sgbal[17]. 
                                                      /*nv_ngbal   nv_nsgbal[1 FOR 13]
                                                      nv_nsgbal[15] nv_nsgbal[16] nv_nsgbal[17]. -- Lukkana M. a52-0241 28/09/2009--*/ 

        EXPORT DELIMITER ";" " " " ". /*-- Lukkana M. A52-0241 08/10/2009 เพิ่มคอลัมน์ที่เป็นค่าว่าง--*/
        EXPORT DELIMITER ";" " " " ". /*-- Lukkana M. A52-0241 08/10/2009 เพิ่มคอลัมน์ที่เป็นค่าว่าง--*/
       
        EXPORT DELIMITER ";" " " /*-- Lukkana M. A52-0241 08/10/2009 เพิ่มคอลัมน์ที่เป็นค่าว่าง--*/
                             "*** Reinsurance Asian (RA) ***".
        EXPORT DELIMITER ";" " " /*-- Lukkana M. A52-0241 08/10/2009 เพิ่มคอลัมน์ที่เป็นค่าว่าง--*/
                             "Gross Premium"    nv_racodep[14] nv_racodep[18] nv_racodep[1 FOR 13]
                                                                nv_racodep[15] nv_racodep[16] nv_racodep[17]. /*-- Lukkana M. a52-0241 28/09/2009--*/ 
        EXPORT DELIMITER ";" " " /*-- Lukkana M. A52-0241 08/10/2009 เพิ่มคอลัมน์ที่เป็นค่าว่าง--*/
                             "Commission"       nv_racodec[14] nv_racodec[18] nv_racodec[1 FOR 13]
                                                                nv_racodec[15] nv_racodec[16] nv_racodec[17]. /*-- Lukkana M. a52-0241 28/09/2009--*/ 
        EXPORT DELIMITER ";" " " /*-- Lukkana M. A52-0241 08/10/2009 เพิ่มคอลัมน์ที่เป็นค่าว่าง--*/
                             "Net Amount"       nv_racoden[14] nv_racoden[18] nv_racoden[1 FOR 13]
                                                                nv_racoden[15] nv_racoden[16] nv_racoden[17]. /*-- Lukkana M. a52-0241 28/09/2009--*/ 
        /*--
        EXPORT DELIMITER ";" " " 
                             "Reserve"  nv_racoder[14]  nv_racoder[1 FOR 13]
                                                        nv_racoder[15] nv_racoder[16] nv_racoder[17]. 
        -- Lukkana M. a52-0241 28/09/2009--*/   
        EXPORT DELIMITER ";" " " /*-- Lukkana M. A52-0241 08/10/2009 เพิ่มคอลัมน์ที่เป็นค่าว่าง--*/
                             "Net Balance"      nv_racodeb[14] nv_racodeb[18] nv_racodeb[1 FOR 13]
                                                                nv_racodeb[15] nv_racodeb[16] nv_racodeb[17]. 
                                                /*nv_nracodeb[14]  nv_nracodeb[1 FOR 13]
                                                                 nv_nracodeb[15] nv_nracodeb[16] nv_nracodeb[17]. -- Lukkana M. a52-0241 28/09/2009--*/ 
        /*-----    
        EXPORT DELIMITER ";" "*** Reinsurance Broker (RB) ***".
        EXPORT DELIMITER ";" "Gross Premium"    nv_rbcodep[14]  nv_rbcodep[1 FOR 13].
        EXPORT DELIMITER ";" "Commission"       nv_rbcodec[14]  nv_rbcodec[1 FOR 13].
        EXPORT DELIMITER ";" "Net Amount"       nv_rbcoden[14]  nv_rbcoden[1 FOR 13]. 
        EXPORT DELIMITER ";" "Premium Reserve"  nv_rbcoder[14]  nv_rbcoder[1 FOR 13]. 
        EXPORT DELIMITER ";" "Net Balance"      nv_rbcodeb[14]  nv_rbcodeb[1 FOR 13].   
       ------*/
        EXPORT DELIMITER ";" " " /*-- Lukkana M. A52-0241 08/10/2009 เพิ่มคอลัมน์ที่เป็นค่าว่าง--*/
                             "*** Insurance Domesic (RD) ***".
        EXPORT DELIMITER ";" " " /*-- Lukkana M. A52-0241 08/10/2009 เพิ่มคอลัมน์ที่เป็นค่าว่าง--*/
                             "Gross Premium"    nv_rdcodep[14] nv_rdcodep[18] nv_rdcodep[1 FOR 13]
                                                                nv_rdcodep[15] nv_rdcodep[16] nv_rdcodep[17]. /*-- Lukkana M. a52-0241 28/09/2009--*/ 
        EXPORT DELIMITER ";" " " /*-- Lukkana M. A52-0241 08/10/2009 เพิ่มคอลัมน์ที่เป็นค่าว่าง--*/
                             "Commission"       nv_rdcodec[14] nv_rdcodec[18] nv_rdcodec[1 FOR 13]
                                                                nv_rdcodec[15] nv_rdcodec[16] nv_rdcodec[17]. /*-- Lukkana M. a52-0241 28/09/2009--*/ 
        EXPORT DELIMITER ";" " " /*-- Lukkana M. A52-0241 08/10/2009 เพิ่มคอลัมน์ที่เป็นค่าว่าง--*/
                             "Net Amount"       nv_rdcoden[14] nv_rdcoden[18] nv_rdcoden[1 FOR 13]
                                                                nv_rdcoden[15] nv_rdcoden[16] nv_rdcoden[17]. /*-- Lukkana M. a52-0241 28/09/2009--*/ 
        /*---
        EXPORT DELIMITER ";" " " 
                             "Premium Reserve"  nv_rdcoder[14]  nv_rdcoder[1 FOR 13]
                                                                nv_rdcoder[15] nv_rdcoder[16] nv_rdcoder[17]. 
        -- Lukkana M. a52-0241 28/09/2009--*/ 
        EXPORT DELIMITER ";" " " /*-- Lukkana M. A52-0241 08/10/2009 เพิ่มคอลัมน์ที่เป็นค่าว่าง--*/
                             "Net Balance"      nv_rdcodeb[14] nv_rdcodeb[18] nv_rdcodeb[1 FOR 13]
                                                                nv_rdcodeb[15] nv_rdcodeb[16] nv_rdcodeb[17]. 
                                                /*nv_nrdcodeb[14]  nv_nrdcodeb[1 FOR 13]
                                                                 nv_nrdcodeb[15] nv_nrdcodeb[16] nv_nrdcodeb[17]. -- Lukkana M. a52-0241 28/09/2009--*/ 
       
        EXPORT DELIMITER ";" " " /*-- Lukkana M. A52-0241 08/10/2009 เพิ่มคอลัมน์ที่เป็นค่าว่าง--*/
                             "*** Insurance Foreign (RF) & Reinsurance Broker (RB) ***".
        EXPORT DELIMITER ";" " " /*-- Lukkana M. A52-0241 08/10/2009 เพิ่มคอลัมน์ที่เป็นค่าว่าง--*/
                             "Gross Premium"    nv_rfcodep[14] nv_rfcodep[18] nv_rfcodep[1 FOR 13]
                                                                nv_rfcodep[15] nv_rfcodep[16] nv_rfcodep[17]. /*-- Lukkana M. a52-0241 28/09/2009--*/ 
        EXPORT DELIMITER ";" " " /*-- Lukkana M. A52-0241 08/10/2009 เพิ่มคอลัมน์ที่เป็นค่าว่าง--*/
                             "Commission"       nv_rfcodec[14] nv_rfcodec[18] nv_rfcodec[1 FOR 13]
                                                                nv_rfcodec[15] nv_rfcodec[16] nv_rfcodec[17]. /*-- Lukkana M. a52-0241 28/09/2009--*/ 
        EXPORT DELIMITER ";" " " /*-- Lukkana M. A52-0241 08/10/2009 เพิ่มคอลัมน์ที่เป็นค่าว่าง--*/
                             "Net Amount"       nv_rfcoden[14] nv_rfcoden[18] nv_rfcoden[1 FOR 13]
                                                                nv_rfcoden[15] nv_rfcoden[16] nv_rfcoden[17]. /*-- Lukkana M. a52-0241 28/09/2009--*/ 
        /*-----
        EXPORT DELIMITER ";" " " 
                             "Premium Reserve"  nv_rfcoder[14]  nv_rfcoder[1 FOR 13]
                                                                nv_rfcoder[15] nv_rfcoder[16] nv_rfcoder[17]. 
        -- Lukkana M. a52-0241 28/09/2009--*/ 
        EXPORT DELIMITER ";" " " /*-- Lukkana M. A52-0241 08/10/2009 เพิ่มคอลัมน์ที่เป็นค่าว่าง--*/
                             "Net Balance"      nv_rfcodeb[14] nv_rfcodeb[18] nv_rfcodeb[1 FOR 13]
                                                                nv_rfcodeb[15] nv_rfcodeb[16] nv_rfcodeb[17]. 
                                                /*nv_nrfcodeb[14]  nv_nrfcodeb[1 FOR 13]
                                                                 nv_nrfcodeb[15] nv_nrfcodeb[16] nv_nrfcodeb[17]. -- Lukkana M. a52-0241 28/09/2009--*/ 

    END.

    /*---- lek ----
    EXPORT DELIMITER ";" "Grand Compulsory"  nv_gcomp  nv_sgcomp[1 FOR 13].
    EXPORT DELIMITER ";" "Grand Stamp"       nv_gstamp nv_sgstamp[1 FOR 13].
    EXPORT DELIMITER ";" "Grand Tax"         nv_gtax   nv_sgtax[1 FOR 13].
    --- end lek ---*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdInitData wacr2001 
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
                fiBranch = xmm023.branch
                fibdes   = xmm023.bdes.
             DISP fiBranch fibdes .
         END.
    END.     

FIND LAST  xmm023 NO-ERROR.
    IF AVAIL xmm023  THEN  DO:
        DO WITH FRAME frST :
            ASSIGN 
                fiBranch2 = xmm023.branch
                fibdes2   = xmm023.bdes.
             DISP fiBranch2 fibdes2 .
         END.
    END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdInitDataG wacr2001 
PROCEDURE pdInitDataG :
/*------------------------------------------------------------------------------
  Purpose:      use in Procedure pdAcnoDet, pdBranchDet, pdLineDet :
  Parameters:  <none>
  Notes:       clear ค่า grand total
------------------------------------------------------------------------------*/

            ASSIGN
                nv_gtotal     = 0
                nv_fgtotal    = 0
                nv_sgtotal    = 0
                nv_gprem      = 0
                nv_gcomm      = 0
                nv_gnet       = 0    /*A48-0113*/
                nv_gres       = 0    /*A48-0113*/
                nv_gbal       = 0
                nv_sgprem     = 0
                nv_sgcomm     = 0
                nv_sgnet      = 0    /*A48-0113*/
                nv_sgres      = 0    /*A48-0113*/
                nv_sgbal      = 0
                nv_stotbal    = 0    /*Lukkana M. A52-241 02/10/2009*/
                /*---A50-0218---*/
                nv_gvat       = 0
                nv_gtax       = 0
                /*--------------*/
                
                /*---- lek ----
                nv_gcomp      = 0
                nv_gstamp     = 0
                nv_gtax       = 0
                nv_ggross     = 0
                nv_gnetamt    = 0
                nv_sgcomp     = 0
                nv_sgstamp    = 0
                nv_sgtax      = 0
                --- end lek ---*/

                nv_racodep = 0
                nv_racodec = 0
                nv_racoden = 0
                nv_racoder = 0
                nv_racodeb = 0

                /*--- 
                nv_rbcodep = 0
                nv_rbcodec = 0
                nv_rbcoden = 0
                nv_rbcoder = 0
                nv_rbcodeb = 0
                ----*/

                nv_rdcodep = 0
                nv_rdcodec = 0
                nv_rdcoden = 0
                nv_rdcoder = 0
                nv_rdcodeb = 0
                
                nv_rfcodep = 0
                nv_rfcodec = 0
                nv_rfcoden = 0
                nv_rfcoder = 0
                nv_rfcodeb = 0
                nv_nettol  = 0 /* add by Phaiboon W. [A59-0125] 20/04/2016 */
                nv_grantol = 0
                nv_gvat7   = 0 /* add by Phaiboon W. [A59-0164] 11/05/2016 */
                nv_grese   = 0 /* add by Phaiboon W. [A59-0164] 11/05/2016 */
                nv_gyous   = 0. /* add by Phaiboon W. [A59-0164] 11/05/2016 */
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdIwAvi wacr2001 
PROCEDURE pdIwAvi :
nv_blankX = FILL(" ",8).
    
IF MONTH(fiasdat) = MONTH(fiasdatAging) THEN  ASSIGN nv_gap = 12 - MONTH(fiasdatAging).
ELSE ASSIGN nv_gap = 12 - MONTH(fiasdatAging) + 1 .
FOR EACH  agtprm_fil USE-INDEX by_acno WHERE
          agtprm_fil.asdat        =  n_asdat      AND
         (agtprm_fil.acno        >=  n_frac       AND
          agtprm_fil.acno        <=  n_toac )     AND
 ( SUBSTR(agtprm_fil.policy,3,2) >=  nv_poltypFr  AND
   SUBSTR(agtprm_fil.policy,3,2) <=  nv_poltypTo) AND
         (agtprm_fil.polbran     >=  n_branch     AND 
          agtprm_fil.polbran     <=  n_branch2)   AND
  (LOOKUP(SUBSTR(agtprm_fil.trntyp,1,1) , nv_trntyp1) <> 0 )
NO-LOCK BREAK BY agtprm_fil.acno BY agtprm_fil.trndat.     /* Trans. Date */
   
   DISP agtprm_fil.acno FORMAT "X(10)"
        agtprm_fil.trndat agtprm_fil.policy agtprm_fil.endno agtprm_fil.trntyp 
        agtprm_fil.docno FORMAT "x(10)"  /* Benjaporn J. A60-0267 date 27/06/2017 */
   WITH COLOR BLACK/WHITE NO-LABEL FRAME frProcess VIEW-AS DIALOG-BOX
   TITLE  "  Processing...  ".
   n_asdat = IF nv_asdatAging = ? THEN n_asdat ELSE nv_asdatAging.
   /* Begin */
   /********************** Group Header *********************/
   IF FIRST-OF(agtprm_fil.acno)  THEN DO:
      nv_acname = "".
    /*nv_credit = 0 . */
      FIND xmm600 USE-INDEX xmm60001 WHERE
           xmm600.acno = agtprm_fil.acno NO-LOCK NO-ERROR.
      IF AVAIL xmm600 THEN
         ASSIGN nv_acname = TRIM(xmm600.ntitle) + " " + TRIM(xmm600.name)  
           nv_relate = xmm600.agtreg  /*A50-0218*/
           nv_notes1 = xmm600.notes1 . /*--Lukkana M. A52-0241 08/10/2009--*/
      ELSE ASSIGN nv_acname = ""   nv_relate = "" 
                  nv_notes1 = "" . /*--Lukkana M. A52-0241 08/10/2009--*/
     /*nv_credit = 0 . */ 
      /*--- DISPLAY DETAIL ---*/                              /*
      OUTPUT TO VALUE (STRING(n_OutputFileAvi)) APPEND NO-ECHO.      
      EXPORT DELIMITER ";" " ".
      EXPORT DELIMITER ";"
             agtprm_fil.acno + " - " + nv_acname + "   <" +
             agtprm_fil.acno_clicod  + ">" .
      OUTPUT CLOSE.                                           */
   END.  /* first-of(agtprm_fil.acno) */
   ASSIGN
       nv_num    = 0      nv_prem   =  0
       nv_netpa  = 0      nv_vatt   =  0  /*Lukkana M. A52-0241 15/10/2009*/
       nv_prem   = agtprm_fil.prem /*+ agtprm_fil.prem_comp + agtprm_fil.tax  + agtprm_fil.stamp 
       nv_num    = MONTH(agtprm_fil.asdat) - MONTH(agtprm_fil.trndat) + 1 Lukkana M.A52-0241 06/11/09*/
       /*----A50-0218----*/
       nv_vat    = 0
       nv_tax    = 0 nv_poltyp = SUBSTR(agtprm_fil.policy,3,2).
   RUN pdmonth.
   /*-- Lukkana M. A52-0241 30/09/2009 --*/
   nv_vatt  = agtprm_fil.prem + agtprm_fil.comm.
   IF SUBSTR(agtprm_fil.acno,1,2) = "0F" OR SUBSTR(agtprm_fil.acno,1,2) = "0A" THEN DO: /*งานต่างประเทศไม่คิด vat , tax*/
       ASSIGN  nv_vat = 0   nv_tax = 0.
   END.
   ELSE DO: 
       nv_poltyp = SUBSTR(agtprm_fil.policy,3,2). 
       IF LOOKUP(nv_poltyp,nv_pa) <> 0 THEN  /* line 60,61,62,63,64,67 ไม่คิด vat , tax */
          ASSIGN nv_vat = 0  nv_tax = 0.
       ELSE  ASSIGN nv_vat  = ROUND(nv_vatt * 0.07,2) /*งานinwardมีการคีย์*/
                    nv_tax  = ROUND(nv_vatt * 0.01,2).
   END.
   nv_netpa = nv_vatt + nv_vat - nv_tax. /*- agtprm_fil.odue*/ 
   nv_totnetpa = nv_totnetpa + nv_netpa. 
   /*-- Lukkana M. A52-0241 30/09/2009 --*/
       /*IF LOOKUP(nv_poltyp,nv_pa) <> 0 THEN 
          ASSIGN nv_vat = 0
                 nv_tax = 0.
       ELSE ASSIGN nv_vat  = ROUND(agtprm_fil.gross * 0.07,2)
                   nv_tax    = ROUND(agtprm_fil.gross * 0.01,2). Lukkana M. A52-0241 15/10/09*/
       /*----------------*/
   IF nv_num > 0 THEN DO:
       IF YEAR(agtprm_fil.asdat) = YEAR(agtprm_fil.trndat) THEN DO:
          ASSIGN
             nv_dfield[nv_num]  =  nv_prem
             nv_total[nv_num]   =  nv_total[nv_num]   +  nv_prem
             nv_gtotal[nv_num]  =  nv_gtotal[nv_num]  +  nv_prem
             nv_sprem[nv_num]   =  nv_sprem[nv_num]   +  nv_prem            
             nv_svat[nv_num]    =  nv_svat[nv_num]    +  nv_vat
             nv_stax[nv_num]    =  nv_stax[nv_num]    +  nv_tax            
             nv_scomm[nv_num]   =  nv_scomm[nv_num]   +  agtprm_fil.comm
             nv_sbal[nv_num]    =  nv_sbal[nv_num]    +  agtprm_fil.bal 
             nv_sbal1[nv_num]   =  nv_sbal1[nv_num]   +  agtprm_fil.gross /*Lukkana M. A52-0241 19/10/2009*/
             nv_sgprem[nv_num]  =  nv_sgprem[nv_num]  +  nv_prem
             nv_sgcomm[nv_num]  =  nv_sgcomm[nv_num]  +  agtprm_fil.comm
             nv_sgbal[nv_num]   =  nv_sgbal[nv_num]   +  agtprm_fil.bal
             nv_nzibal[nv_num]  =  nv_nzibal[nv_num]  +  agtprm_fil.gross. /* add by Phaiboon W. [A59-0125] 27/04/2016 */           
       END.
       ELSE DO:           /* over 12 month */
           RUN pdoveryear . /*-- Lukkana M. A52-0241 28/09/2009 --*/          
       END.
   END.
   ELSE DO:
     RUN pdProcess07. /*Lukkana M. A52-0241 28/09/200*/    
   END.

   ASSIGN     
     nv_tprem  = nv_tprem + agtprm_fil.prem       
     nv_tsumins = nv_tsumins + agtprm_fil.comm_comp 
     nv_totnetam = nv_totnetam + agtprm_fil.gross    
     nv_tvat   = nv_tvat + nv_vat
     nv_ttax   = nv_ttax + nv_tax    
     nv_tcomm  = nv_tcomm + agtprm_fil.comm
     nv_tbal   = nv_tbal  + agtprm_fil.bal
     nv_sprem[14]  = nv_sprem[14]  + nv_prem 
     nv_scomm[14]  = nv_scomm[14]  + agtprm_fil.comm
     nv_sbal[14]   = nv_sbal[14]   + agtprm_fil.bal     
     nv_svat[14] = nv_svat[14] + nv_vat  
     nv_stax[14] = nv_stax[14] + nv_tax  
     nv_sbal1[14]  = nv_sbal1[14]  + agtprm_fil.gross
     nv_nettol     = nv_nettol     + agtprm_fil.gross.        
   /*--- DISPLAY DETAIL  ---*/
  
       /*Lukkana M. A52-0241 21/10/2009*/
   IF   agtprm_fil.trndat = ? THEN nv_trndat = "".
   ELSE nv_trndat = STRING(agtprm_fil.trndat).
   IF   agtprm_fil.comdat = ? THEN nv_comdat = "".
   ELSE nv_comdat = STRING(agtprm_fil.comdat).
       /*Lukkana M. A52-0241 21/10/2009*/
       
   IF      INDEX(agtprm_fil.policy,"PM") > 0    THEN nv_fron = 3.
   ELSE IF SUBSTR(agtprm_fil.policy,3,2) = "61" THEN nv_fron = 5. /* Column : % Fronting Fee */
   ELSE IF SUBSTR(agtprm_fil.policy,3,2) = "65" THEN nv_fron = 3.
   ELSE    nv_fron = 0. 

   FIND FIRST uwm100 WHERE uwm100.policy = agtprm_fil.policy
                       AND uwm100.endno  = agtprm_fil.endno NO-LOCK NO-ERROR.
        
    IF AVAIL uwm100 THEN DO:
        ASSIGN  
            nv_prod = uwm100.cr_1  /* Column : Payment Term */
            nv_appe = uwm100.cr_2. /* Column : Aviva Policy Number / Unique ID Number */
                
        FIND FIRST uwm120 USE-INDEX uwm12001 WHERE uwm120.policy = uwm100.policy
                                               AND uwm120.rencnt = uwm100.rencnt
                                               AND uwm120.endcnt = uwm100.endcnt NO-LOCK NO-ERROR.

        IF AVAIL uwm120 THEN nv_comm = uwm120.com1p. /* Column : % Comm */            
        
        FIND FIRST uwm200 USE-INDEX uwm20001 WHERE uwm200.policy = uwm100.policy
                                               AND uwm200.rencnt = uwm100.rencnt
                                               AND uwm200.endcnt = uwm100.endcnt
                                               AND uwm200.csftq  = "F"
                                               AND uwm200.rico   = "0FAVI" NO-LOCK NO-ERROR.

        IF AVAIL uwm200 THEN nv_comm = uwm200.rip1 - nv_fron.        
    END.
    
    nv_vat7  = (agtprm_fil.prem - agtprm_fil.comm) * 0.07. /* Column : Vat 7% ((RI Premiun - RI Comm) * 7%)  */
    nv_tvat7 = nv_tvat7 + nv_vat7.

    nv_rese  = agtprm_fil.prem * 0.40. /* Column : Reserve (40% RI Premiun)  */
    nv_trese = nv_trese + nv_rese.

    nv_yous  = agtprm_fil.gross - nv_rese.  /* Column : Your Share (Net Amount - Reserve) */
    nv_tyous = nv_tyous + nv_yous.

   OUTPUT TO VALUE (STRING(n_OutputFileAvi)) APPEND NO-ECHO.
   EXPORT DELIMITER ";"    
       agtprm_fil.acno FORMAT "X(10)"
       nv_acname    
       nv_trndat 
       nv_comdat
       agtprm_fil.trntyp
       "'" + agtprm_fil.docno FORMAT "x(10)"  /* Benjaporn J. A60-0267 date 27/06/2017 */
       agtprm_fil.policy
       nv_appe
       agtprm_fil.endno                
       agtprm_fil.insure
       nv_prod
       agtprm_fil.opnpol
       agtprm_fil.prvpol     
       agtprm_fil.comm_comp        
       agtprm_fil.prem
       agtprm_fil.comm
       STRING(nv_comm) + "%"
       STRING(nv_fron) + "%"
       agtprm_fil.gross       
       nv_vat7
       nv_rese
       nv_yous
       nv_blankX[1 FOR 2]       
       agtprm_fil.bal.      
   OUTPUT CLOSE.
  
   IF LAST-OF(agtprm_fil.acno) THEN DO:
       /*--- DISPLAY DETAIL  ---*/       
       OUTPUT TO VALUE (STRING(n_OutputFileAvi)) APPEND NO-ECHO.
       EXPORT DELIMITER ";"
           "Total : " + agtprm_fil.acno
           nv_blankX[1 FOR 12] 
           nv_tsumins
           nv_tprem         
           nv_tcomm
           nv_blankX[1 FOR 2]                      
           nv_totnetam
           nv_tvat7
           nv_trese        
           nv_tyous
           nv_blankX[1 FOR 2]   
           nv_tbal.
       EXPORT DELIMITER ";" "".
       OUTPUT CLOSE.
       ASSIGN
          nv_gvat7 = nv_gvat7 + nv_tvat7
          nv_grese = nv_grese + nv_trese
          nv_gyous = nv_gyous + nv_tyous

          nv_tprem = 0
          nv_tcomm = 0 
          nv_tbal  = 0 
          nv_total = 0 
          nv_tvat  = 0 
          nv_totnetam = 0 
          nv_tsumins = 0
          nv_tvat7 = 0
          nv_trese = 0      
          nv_tyous = 0.
   END.   /* IF LAST-OF(agtprm_fil.acno) */

   nv_dfield = 0.
   ACCUMULATE 
     agtprm_fil.prem      (TOTAL)
     agtprm_fil.prem_comp (TOTAL)
     agtprm_fil.tax       (TOTAL)
     agtprm_fil.stamp     (TOTAL)
     agtprm_fil.comm      (TOTAL)
     agtprm_fil.bal       (TOTAL) 
     /*---A50-0218---*/
     nv_vat               (TOTAL)
     nv_tax               (TOTAL)
     agtprm_fil.comm_comp (TOTAL) /*Lukkana A52-0241*/
     /*agtprm_fil.odue      (TOTAL) /*Lukkana A52-0241*/*/
     nv_netpa             (TOTAL)  /*Lukkana A52-0241*/
     agtprm_fil.gross     (TOTAL). /*Lukkana A52-0241*/
     /*--------------*/     
   /********************** Page Footer *********************/
   /*** export ข้อมูลลง DETAIL FILE บรรทัด Grand Total  และ  
                        SUMMARY FILE บรรทัด Grand Total ***/
   IF LAST(agtprm_fil.acno) THEN DO:
     
     OUTPUT TO VALUE (n_OutputFileAvi) APPEND NO-ECHO.
     ASSIGN      
       nv_gsumins = (ACCUM TOTAL agtprm_fil.comm_comp) 
       nv_gnetam  = (ACCUM TOTAL agtprm_fil.gross)       
       nv_gvat    = (ACCUM TOTAL nv_vat)       
       nv_gprem   = (ACCUM TOTAL agtprm_fil.prem)
       nv_gcomm   = (ACCUM TOTAL agtprm_fil.comm)
       nv_gbal    = (ACCUM TOTAL agtprm_fil.bal) . 
     RUN pdFooterAvi.
     OUTPUT CLOSE.

     RUN pdInitDataG.    /* clear data */                       
   END. /* if last(agtprm_fil.acno) then */
END. /* for each agtprm_fil*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdmonth wacr2001 
PROCEDURE pdmonth :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*-- Lukkana M. A52-0241 30/09/2009 --*/
IF MONTH(agtprm_fil.asdat) = MONTH(TODAY) THEN DO:  /*เรียก asdat=เดือนปัจจุบัน*/
    nv_num  = MONTH(agtprm_fil.asdat)  -  MONTH(agtprm_fil.trndat) -  1 .
END.
ELSE DO: 
    nv_num  = MONTH(agtprm_fil.asdat)  -  MONTH(agtprm_fil.trndat).
END.
/*-- Lukkana M. A52-0241 30/09/2009 --*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdoveryear wacr2001 
PROCEDURE pdoveryear :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*--  Lukkana M. A52-0241 28/09/2009  --*/
IF YEAR(agtprm_fil.asdat) - YEAR(agtprm_fil.trndat) = 1 THEN DO: /* 1 year */
    ASSIGN
        nv_dfield[13]  =  nv_prem
        nv_total[13]   =  nv_total[13]   +  nv_prem
        nv_gtotal[13]  =  nv_gtotal[13]  +  nv_prem
        nv_sprem[13]   =  nv_sprem[13]   +  nv_prem
        /*---A50-0218---*/
        nv_svat[13]   =  nv_svat[13]   +  nv_vat
        nv_stax[13]   =  nv_stax[13]   +  nv_tax
        /*--------*/
        nv_scomm[13]   =  nv_scomm[13]   +  agtprm_fil.comm
        nv_sbal[13]    =  nv_sbal[13]    +  agtprm_fil.bal 
        nv_sbal1[13]   =  nv_sbal1[13]   +  agtprm_fil.gross /*Lukkana M. A52-0241 19/10/2009*/
        nv_sgprem[13]  =  nv_sgprem[13]  +  nv_prem
        nv_sgcomm[13]  =  nv_sgcomm[13]  +  agtprm_fil.comm
        nv_sgbal[13]   =  nv_sgbal[13]   +  agtprm_fil.bal
        nv_nzibal[13]  =  nv_nzibal[13]  +  agtprm_fil.gross. /* add by Phaiboon W. [A59-0125] 27/04/2016 */
                                   
END.                                                                                                                                        
ELSE IF YEAR(agtprm_fil.asdat) - YEAR(agtprm_fil.trndat) = 2 THEN DO: /* 2 years */
    ASSIGN
        nv_dfield[15]  =  nv_prem
        nv_total[15]   =  nv_total[15]   +  nv_prem
        nv_gtotal[15]  =  nv_gtotal[15]  +  nv_prem
        nv_sprem[15]   =  nv_sprem[15]   +  nv_prem
        /*---A50-0218---*/
        nv_svat[15]   =  nv_svat[15]   +  nv_vat
        nv_stax[15]   =  nv_stax[15]   +  nv_tax
        /*--------*/
        nv_scomm[15]   =  nv_scomm[15]   +  agtprm_fil.comm
        nv_sbal[15]    =  nv_sbal[15]    +  agtprm_fil.bal 
        nv_sbal1[15]   =  nv_sbal1[15]   +  agtprm_fil.gross /*Lukkana M. A52-0241 19/10/2009*/
        nv_sgprem[15]  =  nv_sgprem[15]  +  nv_prem
        nv_sgcomm[15]  =  nv_sgcomm[15]  +  agtprm_fil.comm
        nv_sgbal[15]   =  nv_sgbal[15]   +  agtprm_fil.bal
        nv_nzibal[15]  =  nv_nzibal[15]  +  agtprm_fil.gross. /* add by Phaiboon W. [A59-0125] 27/04/2016 */
END.
ELSE IF YEAR(agtprm_fil.asdat) - YEAR(agtprm_fil.trndat) = 3 THEN DO: /* 3 years */
    ASSIGN
        nv_dfield[16]  =  nv_prem
        nv_total[16]   =  nv_total[16]   +  nv_prem
        nv_gtotal[16]  =  nv_gtotal[16]  +  nv_prem
        nv_sprem[16]   =  nv_sprem[16]   +  nv_prem
        /*---A50-0218---*/
        nv_svat[16]   =  nv_svat[16]   +  nv_vat
        nv_stax[16]   =  nv_stax[16]   +  nv_tax
        /*--------*/
        nv_scomm[16]   =  nv_scomm[16]   +  agtprm_fil.comm
        nv_sbal[16]    =  nv_sbal[16]    +  agtprm_fil.bal 
        nv_sbal1[16]   =  nv_sbal1[16]   +  agtprm_fil.gross /*Lukkana M. A52-0241 19/10/2009*/
        nv_sgprem[16]  =  nv_sgprem[16]  +  nv_prem
        nv_sgcomm[16]  =  nv_sgcomm[16]  +  agtprm_fil.comm
        nv_sgbal[16]   =  nv_sgbal[16]   +  agtprm_fil.bal
        nv_nzibal[16]  =  nv_nzibal[16]  +  agtprm_fil.gross. /* add by Phaiboon W. [A59-0125] 27/04/2016 */
END.
ELSE IF YEAR(agtprm_fil.asdat) - YEAR(agtprm_fil.trndat) > 3 THEN DO: /* over 3 years */
    ASSIGN
        nv_dfield[17]  =  nv_prem
        nv_total[17]   =  nv_total[17]   +  nv_prem
        nv_gtotal[17]  =  nv_gtotal[17]  +  nv_prem
        nv_sprem[17]   =  nv_sprem[17]   +  nv_prem
        /*---A50-0218---*/
        nv_svat[17]   =  nv_svat[17]   +  nv_vat
        nv_stax[17]   =  nv_stax[17]   +  nv_tax
        /*--------*/
        nv_scomm[17]   =  nv_scomm[17]   +  agtprm_fil.comm
        nv_sbal[17]    =  nv_sbal[17]    +  agtprm_fil.bal 
        nv_sbal1[17]   =  nv_sbal1[17]   +  agtprm_fil.gross /*Lukkana M. A52-0241 19/10/2009*/
        nv_sgprem[17]  =  nv_sgprem[17]  +  nv_prem
        nv_sgcomm[17]  =  nv_sgcomm[17]  +  agtprm_fil.comm
        nv_sgbal[17]   =  nv_sgbal[17]   +  agtprm_fil.bal
        nv_nzibal[17]  =  nv_nzibal[17]  +  agtprm_fil.gross. /* add by Phaiboon W. [A59-0125] 27/04/2016 */
END.                
/*--  Lukkana M. A52-0241 28/09/2009  --*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdOwAvi08 wacr2001 
PROCEDURE pdOwAvi08 :
ASSIGN nv_blankX = FILL(" ",8)
       nv_stotal = 0.

IF MONTH(fiasdat) = MONTH(fiasdatAging) THEN 
    ASSIGN nv_gap = 12 - MONTH(fiasdatAging).
ELSE ASSIGN nv_gap = 12 - MONTH(fiasdatAging) + 1 .
i = 0.

FOR EACH  agtprm_fil USE-INDEX by_acno WHERE
          agtprm_fil.asdat        =  n_asdat        AND
         (agtprm_fil.acno        >=  n_frac         AND
          agtprm_fil.acno        <=  n_toac )       AND
 ( SUBSTR(agtprm_fil.policy,3,2) >=  nv_poltypFr    AND
   SUBSTR(agtprm_fil.policy,3,2) <=  nv_poltypTo)   AND
         (agtprm_fil.polbran     >=  n_branch       AND 
          agtprm_fil.polbran     <=  n_branch2)     AND
          /*agtprm_fil.poldes      <> ""             AND*/
  (LOOKUP(SUBSTR(agtprm_fil.trntyp,1,1) , nv_trntyp1) <> 0 )
NO-LOCK BREAK BY agtprm_fil.acno
              BY agtprm_fil.trndat
              BY SUBSTR(agtprm_fil.policy,3,2)
              BY agtprm_fil.policy
              BY agtprm_fil.endno.
                                 
 i = i + 1.
    /*    NO-LOCK BREAK BY agtprm_fil.acno BY agtprm_fil.polbran BY agtprm_fil.trndat. */

    DISP  /*agtprm_fil.acno --- A500178 ---*/ 
          i
          agtprm_fil.acno FORMAT "X(10)"
          agtprm_fil.trndat     /* Trans. Date */
          agtprm_fil.policy
          agtprm_fil.endno
          agtprm_fil.trntyp
          agtprm_fil.docno FORMAT "x(10)"  /* Benjaporn J. A60-0267 date 27/06/2017 */
    WITH COLOR BLACK/WHITE NO-LABEL FRAME frProcess VIEW-AS DIALOG-BOX
    TITLE  "  Processing...  ".

    n_asdat = IF nv_asdatAging = ? THEN n_asdat ELSE nv_asdatAging.

    /* Begin */
    /********************** Group Header *********************/
        
    IF FIRST-OF(agtprm_fil.acno)  THEN DO:
        nv_acname = "".
        FIND xmm600 USE-INDEX xmm60001 WHERE
             xmm600.acno = agtprm_fil.acno NO-LOCK NO-ERROR.
        IF AVAIL xmm600 THEN
           ASSIGN  nv_acname = TRIM(xmm600.ntitle) + " " + TRIM(xmm600.name) 
                   nv_relate = xmm600.agtreg   /*A50-0218*/
                   nv_notes1 = xmm600.notes1 . /*--Lukkana M. A52-0241 08/10/2009--*/
        ELSE ASSIGN nv_acname = " " 
                    nv_relate = ""
                    nv_notes1 = "" . /*--Lukkana M. A52-0241 08/10/2009--*/

        /*--- DISPLAY DETAIL ---*/        
       /* OUTPUT TO VALUE (STRING(n_OutputFileAvi)) APPEND NO-ECHO.
            EXPORT DELIMITER ";" " ".
            EXPORT DELIMITER ";"
                agtprm_fil.acno + " - " + nv_acname + "   <" +
                agtprm_fil.acno_clicod  + ">" .
        OUTPUT CLOSE.  */
    END.  /* first-of(agtprm_fil.acno) */
    
    ASSIGN 
        nv_num    = 0
        nv_netbal = 0           
        nv_netbal = agtprm_fil.gross  /*--Lukkana M. a52-0241 05/10/2009---*/

        /*----A50-0218----*/
        nv_balos  = 0       
        nv_vat    = 0
        nv_tax    = 0
        nv_netpd  = 0
        nv_netpaid = 0 /*Lukkana M. A52-0241 21/10/2009*/
        nv_vatt   = 0 /*Lukkana M. A52-0241 21/10/2009*/
        nv_balos  = agtprm_fil.bal   . 
    RUN pdmonth. /*--Lukkana M. A52-0241 08/10/2009--*/
        
      /*-- Lukkana M. A52-0241 30/09/2009 --*/
      nv_vatt  = agtprm_fil.prem + agtprm_fil.comm.
      IF SUBSTR(agtprm_fil.acno,1,2) = "0F" OR SUBSTR(agtprm_fil.acno,1,2) = "0A"  THEN DO: /*งานต่างประเทศไม่คิด vat , tax*/
          ASSIGN nv_vat = 0
                 nv_tax = 0.
      END.
      ELSE DO: 
          nv_poltyp = SUBSTR(agtprm_fil.policy,3,2). 
          IF LOOKUP(nv_poltyp,nv_pa) <> 0 THEN  /* line 60,61,62,63,64,67 ไม่คิด vat , tax */
             ASSIGN nv_vat = 0
                    nv_tax = 0.
          ELSE 
              ASSIGN nv_vat  = ROUND(nv_vatt * 0.07,2)
                     nv_tax  = ROUND(nv_vatt * 0.01,2).
      END.
      ASSIGN nv_netpd  = ROUND(nv_netbal + nv_vat - nv_tax,2)
             nv_netpaid  = ROUND(nv_vatt + nv_vat - nv_tax /*- agtprm_fil.odue*/ ,2). /*prem-comm+vat-tax Lukkana M. A52-0241 21/10/2009*/

      nv_gnetpaid = nv_gnetpaid + nv_netpaid. /*Lukkana M. A52-0241 21/10/2009*/   
    
    RUN pdRunwacr.   /*--Lukkana M. A52-0241 08/10/2009--*/
  /*  {wac/wacr2004.i} /*--Lukkana M. A52-0241 08/10/2009--*/*/

    ASSIGN
        nv_tsumin     = nv_tsumin + agtprm_fil.comm_comp /*Lukkana M. A52-0241 21/10/2009*/
        nv_tprem      = nv_tprem + agtprm_fil.prem
        nv_tcomm      = nv_tcomm + agtprm_fil.comm
        /*----- A48-0113 -----*/
        nv_tnet       = nv_tnet  + agtprm_fil.gross
        nv_tres       = nv_tres  + agtprm_fil.odue
        nv_tbal       = nv_tbal  + nv_netbal
        /*--- END A48-0113 ---*/
        /*----A50-0218----*/
        nv_tbalos   = nv_tbalos + agtprm_fil.bal         
        nv_tvat     = nv_tvat + nv_vat  
        nv_ttax     = nv_ttax + nv_tax
        nv_tnetpd   = nv_tnetpd + nv_netpd
        nv_tnetpaid   = nv_tnetpaid + nv_netpaid /*Lukkana M. A52-0241 21/10/2009*/
        /*----------------*/
        nv_sprem[14]  = nv_sprem[14]  + agtprm_fil.prem
        nv_scomm[14]  = nv_scomm[14]  + agtprm_fil.comm
        /*----- A48-0113 -----*/
        nv_snet[14]   = nv_snet[14]   + agtprm_fil.gross
        nv_sres[14]   = nv_sres[14]   + agtprm_fil.odue
        nv_nsbal[14]  = nv_nsbal[14] +  agtprm_fil.gross - agtprm_fil.odue /*Lukkana M. A52-0241 22/10/2009*/
        nv_sbal[14]   = nv_sbal[14]   + nv_netbal
        /*--- END A48-0113 ---*/
        /*----A50-0218----*/
        nv_sbalos[14] = nv_sbalos[14]   + agtprm_fil.bal   
        nv_svat[14] = nv_svat[14]   + nv_vat    
        nv_stax[14] = nv_stax[14]   + nv_tax
        nv_snetpd[14] = nv_snetpd[14]   + nv_netpd
        nv_snetpaid[14] = nv_snetpaid[14]   + nv_netpaid /*Lukkana M. A52-0241 21/10/2009*/.

    CASE agtprm_fil.acno_clicod:
    WHEN "RA" THEN
        ASSIGN
            nv_racodep[14]  = nv_racodep[14]  + agtprm_fil.prem
            nv_racodec[14]  = nv_racodec[14]  + agtprm_fil.comm
            nv_racoden[14]  = nv_racoden[14]  + agtprm_fil.gross
            nv_racoder[14]  = nv_racoder[14]  + agtprm_fil.odue
            nv_racodeb[14]  = nv_racodeb[14]  + nv_netbal
            nv_nracodeb[14] = nv_nracodeb[14] + agtprm_fil.gross - agtprm_fil.odue. /*Lukkana M. A52-0241 21/10/2009*/        
    WHEN "RD" THEN 
        ASSIGN
            nv_rdcodep[14]  = nv_rdcodep[14]  + agtprm_fil.prem
            nv_rdcodec[14]  = nv_rdcodec[14]  + agtprm_fil.comm 
            nv_rdcoden[14]  = nv_rdcoden[14]  + agtprm_fil.gross
            nv_rdcoder[14]  = nv_rdcoder[14]  + agtprm_fil.odue 
            nv_rdcodeb[14]  = nv_rdcodeb[14]  + nv_netbal
            nv_nrdcodeb[14] = nv_nrdcodeb[14] + agtprm_fil.gross - agtprm_fil.odue. /*Lukkana M. A52-0241 21/10/2009*/
    WHEN "RF" OR WHEN "RB" THEN
        ASSIGN
            nv_rfcodep[14]  = nv_rfcodep[14]  + agtprm_fil.prem
            nv_rfcodec[14]  = nv_rfcodec[14]  + agtprm_fil.comm 
            nv_rfcoden[14]  = nv_rfcoden[14]  + agtprm_fil.gross
            nv_rfcoder[14]  = nv_rfcoder[14]  + agtprm_fil.odue 
            nv_rfcodeb[14]  = nv_rfcodeb[14]  + nv_netbal
            nv_nrfcodeb[14] = nv_nrfcodeb[14] + agtprm_fil.gross - agtprm_fil.odue. /*Lukkana M. A52-0241 21/10/2009*/
    END CASE. 

    IF agtprm_fil.odue = agtprm_fil.bal THEN 
        ASSIGN  nv_netpd   = 0
                nv_netpaid = 0. /*Lukkana M. A52-0241 21/10/2009*/

    IF agtprm_fil.trndat = ? THEN nv_trndat = "".
    ELSE nv_trndat = STRING(agtprm_fil.trndat).
    IF agtprm_fil.comdat = ? THEN nv_comdat = "".
    ELSE nv_comdat = STRING(agtprm_fil.comdat).    
    
    IF      INDEX(agtprm_fil.policy,"PM") > 0    THEN nv_fron = 3.
    ELSE IF SUBSTR(agtprm_fil.policy,3,2) = "61" THEN nv_fron = 5. /* Column : % Fronting Fee */
    ELSE IF SUBSTR(agtprm_fil.policy,3,2) = "65" THEN nv_fron = 3.
    ELSE    nv_fron = 0. 

    FIND FIRST uwm100 WHERE uwm100.policy = agtprm_fil.policy
                       AND uwm100.endno  = agtprm_fil.endno NO-LOCK NO-ERROR.
        
    IF AVAIL uwm100 THEN DO:
        ASSIGN  
            nv_prod = uwm100.cr_1  /* Column : Payment Term */
            nv_appe = uwm100.cr_2. /* Column : Aviva Policy Number / Unique ID Number */
                
        FIND FIRST uwm120 USE-INDEX uwm12001 WHERE uwm120.policy = uwm100.policy
                                               AND uwm120.rencnt = uwm100.rencnt
                                               AND uwm120.endcnt = uwm100.endcnt NO-LOCK NO-ERROR.

        IF AVAIL uwm120 THEN nv_comm = uwm120.com1p. /* Column : % Comm */            
        
        FIND FIRST uwm200 USE-INDEX uwm20001 WHERE uwm200.policy = uwm100.policy
                                               AND uwm200.rencnt = uwm100.rencnt
                                               AND uwm200.endcnt = uwm100.endcnt
                                               AND uwm200.csftq  = "F"
                                               AND uwm200.rico   = "0FAVI" NO-LOCK NO-ERROR.

        IF AVAIL uwm200 THEN nv_comm = uwm200.rip1 - nv_fron.        
    END.

    nv_vat7  = (agtprm_fil.prem - agtprm_fil.comm) * 0.07. /* Column : Vat 7% ((RI Premiun - RI Comm) * 7%)  */
    nv_tvat7 = nv_tvat7 + nv_vat7.

    nv_rese  = agtprm_fil.prem * 0.40. /* Column : Reserve (40% RI Premiun)  */
    nv_trese = nv_trese + nv_rese.

    nv_yous  = agtprm_fil.gross - nv_rese.  /* Column : Your Share (Net Amount - Reserve) */
    nv_tyous = nv_tyous + nv_yous.

    OUTPUT TO VALUE (STRING(n_OutputFileAvi)) APPEND NO-ECHO.
        EXPORT DELIMITER ";"
            agtprm_fil.acno
            nv_acname            
            nv_trndat  /*-Lukkana M. A52-0241 30/10/2009*/
            nv_comdat
            agtprm_fil.trntyp
            "'" + agtprm_fil.docno FORMAT "x(10)"  /* Benjaporn J. A60-0267 date 27/06/2017 */
            agtprm_fil.policy
            nv_appe
            agtprm_fil.endno                                                         
            agtprm_fil.insure
            nv_prod
            agtprm_fil.opnpol
            agtprm_fil.prvpol
            agtprm_fil.comm_comp /*-- sum insured Lukkana M. A52-0241 07/10/2009--*/
            agtprm_fil.prem
            agtprm_fil.comm
            STRING(nv_comm) + "%"
            STRING(nv_fron) + "%"
            agtprm_fil.gross           
            nv_vat7
            nv_rese                    
            nv_yous
            nv_blankX[1 FOR 2]
            agtprm_fil.bal                         
            agtprm_fil.poldes.         /* A50-0218 */           
    OUTPUT CLOSE.

    ASSIGN
        nv_ffield     = 0
        nv_sfield     = 0
        nv_fieldbal   = 0. 

    IF LAST-OF(agtprm_fil.acno) THEN DO:        
        OUTPUT TO VALUE (STRING(n_OutputFileAvi)) APPEND NO-ECHO.
        EXPORT DELIMITER ";"
            "Total : " + agtprm_fil.acno
            nv_blankX[1 FOR 12] 
            nv_tsumin  /*--Lukkana M. A52-0241 30/09/2009--*/
            nv_tprem            
            nv_tcomm
            nv_blankX[1 FOR 2]
            nv_tnet     /* A48-0113 */           
            nv_tvat7
            nv_trese
            nv_tyous
            nv_blankX[1 FOR 2]
            nv_tbalos. 
        EXPORT DELIMITER ";" "".
        OUTPUT CLOSE.        
        
        ASSIGN            
            nv_gvat7  = nv_gvat7 + nv_tvat7
            nv_grese  = nv_grese + nv_trese
            nv_gyous  = nv_gyous + nv_tyous
            nv_tprem  = 0 
            nv_tcomm  = 0 
            nv_tnet   = 0 
            nv_tres   = 0 
            nv_tbal   = 0 
            nv_tbalos = 0 
            nv_tvat   = 0 
            nv_ttax   = 0 
            nv_tnetpd = 0 
            nv_tsumin = 0 
            nv_tnetpaid = 0        
            nv_ftotal = 0 
            nv_stotal = 0 
            nv_totbal = 0
            nv_tvat7  = 0
            nv_trese  = 0
            nv_tyous  = 0.
    END.

    ACCUMULATE
        agtprm_fil.prem      (TOTAL)
        agtprm_fil.comm      (TOTAL)
        agtprm_fil.gross     (TOTAL)        
        agtprm_fil.bal       (TOTAL)
        nv_vat               (TOTAL)
        nv_tax               (TOTAL)   
        nv_netpd             (TOTAL)  
        nv_netpaid           (TOTAL)  /*Lukkana M. A52-0241 21/10/2009*/
        agtprm_fil.comm_comp (total). /*Lukkana M. A52-0241 21/10/2009*/

    /********************** Page Footer *********************/
    /*** export ข้อมูลลง DETAIL FILE บรรทัด Grand Total  และ  
                         SUMMARY FILE บรรทัด Grand Total ***/
    IF LAST(agtprm_fil.acno) THEN DO:       
        OUTPUT TO VALUE (n_OutputFileAvi) APPEND NO-ECHO.
         ASSIGN
            nv_gsumin  = (ACCUM TOTAL agtprm_fil.comm_comp) /*--Lukkana M. A52-0241 05/10/2009---*/    
            nv_gprem   = (ACCUM TOTAL agtprm_fil.prem)
            nv_gcomm   = (ACCUM TOTAL agtprm_fil.comm)
            nv_gnet    = (ACCUM TOTAL agtprm_fil.gross)
             /*--A50-0218---*/
            nv_gvat     = (ACCUM TOTAL nv_vat)
            nv_gtax     = (ACCUM TOTAL nv_tax)
            nv_gnetpd   = (ACCUM TOTAL nv_netpd)
            /*-------------*/
            /*nv_gres    = (ACCUM TOTAL agtprm_fil.odue) Lukkana M. A52-0241 28/10/2009*/
            nv_gbalos  = (ACCUM TOTAL agtprm_fil.bal)                        
            nv_gbal    = (ACCUM TOTAL agtprm_fil.gross) .     /*--Lukkana M. A52-0241 05/10/2009---*/          
        RUN pdFooterAvi.
        OUTPUT CLOSE.
               
        RUN pdInitDataG.    /* clear data */
    END. /* if last(agtprm_fil.acno) then */
END. /* for each agtprm_fil*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdOwAvi081 wacr2001 
PROCEDURE pdOwAvi081 :
ASSIGN nv_blankX = FILL(" ",8)
       nv_stotal = 0.

IF MONTH(fiasdat) = MONTH(fiasdatAging) THEN 
    ASSIGN nv_gap = 12 - MONTH(fiasdatAging).
ELSE ASSIGN nv_gap = 12 - MONTH(fiasdatAging) + 1 .
i = 0.

FOR EACH  agtprm_fil USE-INDEX by_acno WHERE
          agtprm_fil.asdat        =  n_asdat        AND
         (agtprm_fil.acno        >=  n_frac         AND
          agtprm_fil.acno        <=  n_toac )       AND
 ( SUBSTR(agtprm_fil.policy,3,2) >=  nv_poltypFr    AND
   SUBSTR(agtprm_fil.policy,3,2) <=  nv_poltypTo)   AND
         (agtprm_fil.polbran     >=  n_branch       AND 
          agtprm_fil.polbran     <=  n_branch2)     AND
          /*agtprm_fil.poldes      <> ""             AND*/
  (LOOKUP(SUBSTR(agtprm_fil.trntyp,1,1) , nv_trntyp1) <> 0 ) AND
          agtprm_fil.poldes = "O/S > 0"
NO-LOCK BREAK BY agtprm_fil.acno
              BY agtprm_fil.trndat
              BY SUBSTR(agtprm_fil.policy,3,2)
              BY agtprm_fil.policy
              BY agtprm_fil.endno.
                                 
 i = i + 1.
    /*    NO-LOCK BREAK BY agtprm_fil.acno BY agtprm_fil.polbran BY agtprm_fil.trndat. */

    DISP  /*agtprm_fil.acno --- A500178 ---*/ 
          i
          agtprm_fil.acno FORMAT "X(10)"
          agtprm_fil.trndat     /* Trans. Date */
          agtprm_fil.policy
          agtprm_fil.endno
          agtprm_fil.trntyp
          agtprm_fil.docno FORMAT "x(10)"  /* Benjaporn J. A60-0267 date 27/06/2017 */
    WITH COLOR BLACK/WHITE NO-LABEL FRAME frProcess VIEW-AS DIALOG-BOX
    TITLE  "  Processing...  ".

    n_asdat = IF nv_asdatAging = ? THEN n_asdat ELSE nv_asdatAging.

    /* Begin */
    /********************** Group Header *********************/
        
    IF FIRST-OF(agtprm_fil.acno)  THEN DO:
        nv_acname = "".
        FIND xmm600 USE-INDEX xmm60001 WHERE
             xmm600.acno = agtprm_fil.acno NO-LOCK NO-ERROR.
        IF AVAIL xmm600 THEN
           ASSIGN  nv_acname = TRIM(xmm600.ntitle) + " " + TRIM(xmm600.name) 
                   nv_relate = xmm600.agtreg   /*A50-0218*/
                   nv_notes1 = xmm600.notes1 . /*--Lukkana M. A52-0241 08/10/2009--*/
        ELSE ASSIGN nv_acname = " " 
                    nv_relate = ""
                    nv_notes1 = "" . /*--Lukkana M. A52-0241 08/10/2009--*/

        /*--- DISPLAY DETAIL ---*/        
       /* OUTPUT TO VALUE (STRING(n_OutputFileAvi)) APPEND NO-ECHO.
            EXPORT DELIMITER ";" " ".
            EXPORT DELIMITER ";"
                agtprm_fil.acno + " - " + nv_acname + "   <" +
                agtprm_fil.acno_clicod  + ">" .
        OUTPUT CLOSE.  */
    END.  /* first-of(agtprm_fil.acno) */
    
    ASSIGN 
        nv_num    = 0
        nv_netbal = 0           
        nv_netbal = agtprm_fil.gross  /*--Lukkana M. a52-0241 05/10/2009---*/

        /*----A50-0218----*/
        nv_balos  = 0       
        nv_vat    = 0
        nv_tax    = 0
        nv_netpd  = 0
        nv_netpaid = 0 /*Lukkana M. A52-0241 21/10/2009*/
        nv_vatt   = 0 /*Lukkana M. A52-0241 21/10/2009*/
        nv_balos  = agtprm_fil.bal   . 
    RUN pdmonth. /*--Lukkana M. A52-0241 08/10/2009--*/
        
      /*-- Lukkana M. A52-0241 30/09/2009 --*/
      nv_vatt  = agtprm_fil.prem + agtprm_fil.comm.
      IF SUBSTR(agtprm_fil.acno,1,2) = "0F" OR SUBSTR(agtprm_fil.acno,1,2) = "0A"  THEN DO: /*งานต่างประเทศไม่คิด vat , tax*/
          ASSIGN nv_vat = 0
                 nv_tax = 0.
      END.
      ELSE DO: 
          nv_poltyp = SUBSTR(agtprm_fil.policy,3,2). 
          IF LOOKUP(nv_poltyp,nv_pa) <> 0 THEN  /* line 60,61,62,63,64,67 ไม่คิด vat , tax */
             ASSIGN nv_vat = 0
                    nv_tax = 0.
          ELSE 
              ASSIGN nv_vat  = ROUND(nv_vatt * 0.07,2)
                     nv_tax  = ROUND(nv_vatt * 0.01,2).
      END.
      ASSIGN nv_netpd  = ROUND(nv_netbal + nv_vat - nv_tax,2)
             nv_netpaid  = ROUND(nv_vatt + nv_vat - nv_tax /*- agtprm_fil.odue*/ ,2). /*prem-comm+vat-tax Lukkana M. A52-0241 21/10/2009*/

      nv_gnetpaid = nv_gnetpaid + nv_netpaid. /*Lukkana M. A52-0241 21/10/2009*/   
    
    RUN pdRunwacr.   /*--Lukkana M. A52-0241 08/10/2009--*/
  /*  {wac/wacr2004.i} /*--Lukkana M. A52-0241 08/10/2009--*/*/

    ASSIGN
        nv_tsumin     = nv_tsumin + agtprm_fil.comm_comp /*Lukkana M. A52-0241 21/10/2009*/
        nv_tprem      = nv_tprem + agtprm_fil.prem
        nv_tcomm      = nv_tcomm + agtprm_fil.comm
        /*----- A48-0113 -----*/
        nv_tnet       = nv_tnet  + agtprm_fil.gross
        nv_tres       = nv_tres  + agtprm_fil.odue
        nv_tbal       = nv_tbal  + nv_netbal
        /*--- END A48-0113 ---*/
        /*----A50-0218----*/
        nv_tbalos   = nv_tbalos + agtprm_fil.bal         
        nv_tvat     = nv_tvat + nv_vat  
        nv_ttax     = nv_ttax + nv_tax
        nv_tnetpd   = nv_tnetpd + nv_netpd
        nv_tnetpaid   = nv_tnetpaid + nv_netpaid /*Lukkana M. A52-0241 21/10/2009*/
        /*----------------*/
        nv_sprem[14]  = nv_sprem[14]  + agtprm_fil.prem
        nv_scomm[14]  = nv_scomm[14]  + agtprm_fil.comm
        /*----- A48-0113 -----*/
        nv_snet[14]   = nv_snet[14]   + agtprm_fil.gross
        nv_sres[14]   = nv_sres[14]   + agtprm_fil.odue
        nv_nsbal[14]  = nv_nsbal[14] +  agtprm_fil.gross - agtprm_fil.odue /*Lukkana M. A52-0241 22/10/2009*/
        nv_sbal[14]   = nv_sbal[14]   + nv_netbal
        /*--- END A48-0113 ---*/
        /*----A50-0218----*/
        nv_sbalos[14] = nv_sbalos[14]   + agtprm_fil.bal   
        nv_svat[14] = nv_svat[14]   + nv_vat    
        nv_stax[14] = nv_stax[14]   + nv_tax
        nv_snetpd[14] = nv_snetpd[14]   + nv_netpd
        nv_snetpaid[14] = nv_snetpaid[14]   + nv_netpaid /*Lukkana M. A52-0241 21/10/2009*/.

    CASE agtprm_fil.acno_clicod:
    WHEN "RA" THEN
        ASSIGN
            nv_racodep[14]  = nv_racodep[14]  + agtprm_fil.prem
            nv_racodec[14]  = nv_racodec[14]  + agtprm_fil.comm
            nv_racoden[14]  = nv_racoden[14]  + agtprm_fil.gross
            nv_racoder[14]  = nv_racoder[14]  + agtprm_fil.odue
            nv_racodeb[14]  = nv_racodeb[14]  + nv_netbal
            nv_nracodeb[14] = nv_nracodeb[14] + agtprm_fil.gross - agtprm_fil.odue. /*Lukkana M. A52-0241 21/10/2009*/        
    WHEN "RD" THEN 
        ASSIGN
            nv_rdcodep[14]  = nv_rdcodep[14]  + agtprm_fil.prem
            nv_rdcodec[14]  = nv_rdcodec[14]  + agtprm_fil.comm 
            nv_rdcoden[14]  = nv_rdcoden[14]  + agtprm_fil.gross
            nv_rdcoder[14]  = nv_rdcoder[14]  + agtprm_fil.odue 
            nv_rdcodeb[14]  = nv_rdcodeb[14]  + nv_netbal
            nv_nrdcodeb[14] = nv_nrdcodeb[14] + agtprm_fil.gross - agtprm_fil.odue. /*Lukkana M. A52-0241 21/10/2009*/
    WHEN "RF" OR WHEN "RB" THEN
        ASSIGN
            nv_rfcodep[14]  = nv_rfcodep[14]  + agtprm_fil.prem
            nv_rfcodec[14]  = nv_rfcodec[14]  + agtprm_fil.comm 
            nv_rfcoden[14]  = nv_rfcoden[14]  + agtprm_fil.gross
            nv_rfcoder[14]  = nv_rfcoder[14]  + agtprm_fil.odue 
            nv_rfcodeb[14]  = nv_rfcodeb[14]  + nv_netbal
            nv_nrfcodeb[14] = nv_nrfcodeb[14] + agtprm_fil.gross - agtprm_fil.odue. /*Lukkana M. A52-0241 21/10/2009*/
    END CASE. 

    IF agtprm_fil.odue = agtprm_fil.bal THEN 
        ASSIGN  nv_netpd   = 0
                nv_netpaid = 0. /*Lukkana M. A52-0241 21/10/2009*/

    IF agtprm_fil.trndat = ? THEN nv_trndat = "".
    ELSE nv_trndat = STRING(agtprm_fil.trndat).
    IF agtprm_fil.comdat = ? THEN nv_comdat = "".
    ELSE nv_comdat = STRING(agtprm_fil.comdat).    
    
    IF      INDEX(agtprm_fil.policy,"PM") > 0    THEN nv_fron = 3.
    ELSE IF SUBSTR(agtprm_fil.policy,3,2) = "61" THEN nv_fron = 5. /* Column : % Fronting Fee */
    ELSE IF SUBSTR(agtprm_fil.policy,3,2) = "65" THEN nv_fron = 3.
    ELSE    nv_fron = 0. 

    FIND FIRST uwm100 WHERE uwm100.policy = agtprm_fil.policy
                       AND uwm100.endno  = agtprm_fil.endno NO-LOCK NO-ERROR.
        
    IF AVAIL uwm100 THEN DO:
        ASSIGN  
            nv_prod = uwm100.cr_1  /* Column : Payment Term */
            nv_appe = uwm100.cr_2. /* Column : Aviva Policy Number / Unique ID Number */
                
        FIND FIRST uwm120 USE-INDEX uwm12001 WHERE uwm120.policy = uwm100.policy
                                               AND uwm120.rencnt = uwm100.rencnt
                                               AND uwm120.endcnt = uwm100.endcnt NO-LOCK NO-ERROR.

        IF AVAIL uwm120 THEN nv_comm = uwm120.com1p. /* Column : % Comm */            
        
        FIND FIRST uwm200 USE-INDEX uwm20001 WHERE uwm200.policy = uwm100.policy
                                               AND uwm200.rencnt = uwm100.rencnt
                                               AND uwm200.endcnt = uwm100.endcnt
                                               AND uwm200.csftq  = "F"
                                               AND uwm200.rico   = "0FAVI" NO-LOCK NO-ERROR.

        IF AVAIL uwm200 THEN nv_comm = uwm200.rip1 - nv_fron.        
    END.

    nv_vat7  = (agtprm_fil.prem - agtprm_fil.comm) * 0.07. /* Column : Vat 7% ((RI Premiun - RI Comm) * 7%)  */
    nv_tvat7 = nv_tvat7 + nv_vat7.

    nv_rese  = agtprm_fil.prem * 0.40. /* Column : Reserve (40% RI Premiun)  */
    nv_trese = nv_trese + nv_rese.

    nv_yous  = agtprm_fil.gross - nv_rese.  /* Column : Your Share (Net Amount - Reserve) */
    nv_tyous = nv_tyous + nv_yous.

    OUTPUT TO VALUE (STRING(n_OutputFileAvi)) APPEND NO-ECHO.
        EXPORT DELIMITER ";"
            agtprm_fil.acno
            nv_acname            
            nv_trndat  /*-Lukkana M. A52-0241 30/10/2009*/
            nv_comdat
            agtprm_fil.trntyp
            "'" + agtprm_fil.docno FORMAT "x(10)"  /* Benjaporn J. A60-0267 date 27/06/2017 */
            agtprm_fil.policy
            nv_appe
            agtprm_fil.endno                                                         
            agtprm_fil.insure
            nv_prod
            agtprm_fil.opnpol
            agtprm_fil.prvpol
            agtprm_fil.comm_comp /*-- sum insured Lukkana M. A52-0241 07/10/2009--*/
            agtprm_fil.prem
            agtprm_fil.comm
            STRING(nv_comm) + "%"
            STRING(nv_fron) + "%"
            agtprm_fil.gross           
            nv_vat7
            nv_rese                    
            nv_yous
            nv_blankX[1 FOR 2]
            agtprm_fil.bal                         
            agtprm_fil.poldes.         /* A50-0218 */           
    OUTPUT CLOSE.

    ASSIGN
        nv_ffield     = 0
        nv_sfield     = 0
        nv_fieldbal   = 0. 

    IF LAST-OF(agtprm_fil.acno) THEN DO:        
        OUTPUT TO VALUE (STRING(n_OutputFileAvi)) APPEND NO-ECHO.
        EXPORT DELIMITER ";"
            "Total : " + agtprm_fil.acno
            nv_blankX[1 FOR 12] 
            nv_tsumin  /*--Lukkana M. A52-0241 30/09/2009--*/
            nv_tprem            
            nv_tcomm
            nv_blankX[1 FOR 2]
            nv_tnet     /* A48-0113 */           
            nv_tvat7
            nv_trese
            nv_tyous
            nv_blankX[1 FOR 2]
            nv_tbalos. 
        EXPORT DELIMITER ";" "".
        OUTPUT CLOSE.        
        
        ASSIGN            
            nv_gvat7  = nv_gvat7 + nv_tvat7
            nv_grese  = nv_grese + nv_trese
            nv_gyous  = nv_gyous + nv_tyous
            nv_tprem  = 0 
            nv_tcomm  = 0 
            nv_tnet   = 0 
            nv_tres   = 0 
            nv_tbal   = 0 
            nv_tbalos = 0 
            nv_tvat   = 0 
            nv_ttax   = 0 
            nv_tnetpd = 0 
            nv_tsumin = 0 
            nv_tnetpaid = 0        
            nv_ftotal = 0 
            nv_stotal = 0 
            nv_totbal = 0
            nv_tvat7  = 0
            nv_trese  = 0
            nv_tyous  = 0.
    END.

    ACCUMULATE
        agtprm_fil.prem      (TOTAL)
        agtprm_fil.comm      (TOTAL)
        agtprm_fil.gross     (TOTAL)        
        agtprm_fil.bal       (TOTAL)
        nv_vat               (TOTAL)
        nv_tax               (TOTAL)   
        nv_netpd             (TOTAL)  
        nv_netpaid           (TOTAL)  /*Lukkana M. A52-0241 21/10/2009*/
        agtprm_fil.comm_comp (total). /*Lukkana M. A52-0241 21/10/2009*/

    /********************** Page Footer *********************/
    /*** export ข้อมูลลง DETAIL FILE บรรทัด Grand Total  และ  
                         SUMMARY FILE บรรทัด Grand Total ***/
    IF LAST(agtprm_fil.acno) THEN DO:       
        OUTPUT TO VALUE (n_OutputFileAvi) APPEND NO-ECHO.
         ASSIGN
            nv_gsumin  = (ACCUM TOTAL agtprm_fil.comm_comp) /*--Lukkana M. A52-0241 05/10/2009---*/    
            nv_gprem   = (ACCUM TOTAL agtprm_fil.prem)
            nv_gcomm   = (ACCUM TOTAL agtprm_fil.comm)
            nv_gnet    = (ACCUM TOTAL agtprm_fil.gross)
             /*--A50-0218---*/
            nv_gvat     = (ACCUM TOTAL nv_vat)
            nv_gtax     = (ACCUM TOTAL nv_tax)
            nv_gnetpd   = (ACCUM TOTAL nv_netpd)
            /*-------------*/
            /*nv_gres    = (ACCUM TOTAL agtprm_fil.odue) Lukkana M. A52-0241 28/10/2009*/
            nv_gbalos  = (ACCUM TOTAL agtprm_fil.bal)                        
            nv_gbal    = (ACCUM TOTAL agtprm_fil.gross) .     /*--Lukkana M. A52-0241 05/10/2009---*/          
        RUN pdFooterAvi.
        OUTPUT CLOSE.
               
        RUN pdInitDataG.    /* clear data */
    END. /* if last(agtprm_fil.acno) then */
END. /* for each agtprm_fil*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdOwAvi082 wacr2001 
PROCEDURE pdOwAvi082 :
ASSIGN nv_blankX = FILL(" ",8)
       nv_stotal = 0.

IF MONTH(fiasdat) = MONTH(fiasdatAging) THEN 
    ASSIGN nv_gap = 12 - MONTH(fiasdatAging).
ELSE ASSIGN nv_gap = 12 - MONTH(fiasdatAging) + 1 .
i = 0.

FOR EACH  agtprm_fil USE-INDEX by_acno WHERE
          agtprm_fil.asdat        =  n_asdat        AND
         (agtprm_fil.acno        >=  n_frac         AND
          agtprm_fil.acno        <=  n_toac )       AND
 ( SUBSTR(agtprm_fil.policy,3,2) >=  nv_poltypFr    AND
   SUBSTR(agtprm_fil.policy,3,2) <=  nv_poltypTo)   AND
         (agtprm_fil.polbran     >=  n_branch       AND 
          agtprm_fil.polbran     <=  n_branch2)     AND
          /*agtprm_fil.poldes      <> ""             AND*/
  (LOOKUP(SUBSTR(agtprm_fil.trntyp,1,1) , nv_trntyp1) <> 0 )AND
          agtprm_fil.poldes = "O/S = 0"
NO-LOCK BREAK BY agtprm_fil.acno
              BY agtprm_fil.trndat
              BY SUBSTR(agtprm_fil.policy,3,2)
              BY agtprm_fil.policy
              BY agtprm_fil.endno.
                                 
 i = i + 1.
    /*    NO-LOCK BREAK BY agtprm_fil.acno BY agtprm_fil.polbran BY agtprm_fil.trndat. */

    DISP  /*agtprm_fil.acno --- A500178 ---*/ 
          i
          agtprm_fil.acno FORMAT "X(10)"
          agtprm_fil.trndat     /* Trans. Date */
          agtprm_fil.policy
          agtprm_fil.endno
          agtprm_fil.trntyp
          agtprm_fil.docno FORMAT "x(10)"  /* Benjaporn J. A60-0267 date 27/06/2017 */
    WITH COLOR BLACK/WHITE NO-LABEL FRAME frProcess VIEW-AS DIALOG-BOX
    TITLE  "  Processing...  ".

    n_asdat = IF nv_asdatAging = ? THEN n_asdat ELSE nv_asdatAging.

    /* Begin */
    /********************** Group Header *********************/
        
    IF FIRST-OF(agtprm_fil.acno)  THEN DO:
        nv_acname = "".
        FIND xmm600 USE-INDEX xmm60001 WHERE
             xmm600.acno = agtprm_fil.acno NO-LOCK NO-ERROR.
        IF AVAIL xmm600 THEN
           ASSIGN  nv_acname = TRIM(xmm600.ntitle) + " " + TRIM(xmm600.name) 
                   nv_relate = xmm600.agtreg   /*A50-0218*/
                   nv_notes1 = xmm600.notes1 . /*--Lukkana M. A52-0241 08/10/2009--*/
        ELSE ASSIGN nv_acname = " " 
                    nv_relate = ""
                    nv_notes1 = "" . /*--Lukkana M. A52-0241 08/10/2009--*/

        /*--- DISPLAY DETAIL ---*/        
       /* OUTPUT TO VALUE (STRING(n_OutputFileAvi)) APPEND NO-ECHO.
            EXPORT DELIMITER ";" " ".
            EXPORT DELIMITER ";"
                agtprm_fil.acno + " - " + nv_acname + "   <" +
                agtprm_fil.acno_clicod  + ">" .
        OUTPUT CLOSE.  */
    END.  /* first-of(agtprm_fil.acno) */
    
    ASSIGN 
        nv_num    = 0
        nv_netbal = 0           
        nv_netbal = agtprm_fil.gross  /*--Lukkana M. a52-0241 05/10/2009---*/

        /*----A50-0218----*/
        nv_balos  = 0       
        nv_vat    = 0
        nv_tax    = 0
        nv_netpd  = 0
        nv_netpaid = 0 /*Lukkana M. A52-0241 21/10/2009*/
        nv_vatt   = 0 /*Lukkana M. A52-0241 21/10/2009*/
        nv_balos  = agtprm_fil.bal   . 
    RUN pdmonth. /*--Lukkana M. A52-0241 08/10/2009--*/
        
      /*-- Lukkana M. A52-0241 30/09/2009 --*/
      nv_vatt  = agtprm_fil.prem + agtprm_fil.comm.
      IF SUBSTR(agtprm_fil.acno,1,2) = "0F" OR SUBSTR(agtprm_fil.acno,1,2) = "0A"  THEN DO: /*งานต่างประเทศไม่คิด vat , tax*/
          ASSIGN nv_vat = 0
                 nv_tax = 0.
      END.
      ELSE DO: 
          nv_poltyp = SUBSTR(agtprm_fil.policy,3,2). 
          IF LOOKUP(nv_poltyp,nv_pa) <> 0 THEN  /* line 60,61,62,63,64,67 ไม่คิด vat , tax */
             ASSIGN nv_vat = 0
                    nv_tax = 0.
          ELSE 
              ASSIGN nv_vat  = ROUND(nv_vatt * 0.07,2)
                     nv_tax  = ROUND(nv_vatt * 0.01,2).
      END.
      ASSIGN nv_netpd  = ROUND(nv_netbal + nv_vat - nv_tax,2)
             nv_netpaid  = ROUND(nv_vatt + nv_vat - nv_tax /*- agtprm_fil.odue*/ ,2). /*prem-comm+vat-tax Lukkana M. A52-0241 21/10/2009*/

      nv_gnetpaid = nv_gnetpaid + nv_netpaid. /*Lukkana M. A52-0241 21/10/2009*/   
    
    RUN pdRunwacr.   /*--Lukkana M. A52-0241 08/10/2009--*/
  /*  {wac/wacr2004.i} /*--Lukkana M. A52-0241 08/10/2009--*/*/

    ASSIGN
        nv_tsumin     = nv_tsumin + agtprm_fil.comm_comp /*Lukkana M. A52-0241 21/10/2009*/
        nv_tprem      = nv_tprem + agtprm_fil.prem
        nv_tcomm      = nv_tcomm + agtprm_fil.comm
        /*----- A48-0113 -----*/
        nv_tnet       = nv_tnet  + agtprm_fil.gross
        nv_tres       = nv_tres  + agtprm_fil.odue
        nv_tbal       = nv_tbal  + nv_netbal
        /*--- END A48-0113 ---*/
        /*----A50-0218----*/
        nv_tbalos   = nv_tbalos + agtprm_fil.bal         
        nv_tvat     = nv_tvat + nv_vat  
        nv_ttax     = nv_ttax + nv_tax
        nv_tnetpd   = nv_tnetpd + nv_netpd
        nv_tnetpaid   = nv_tnetpaid + nv_netpaid /*Lukkana M. A52-0241 21/10/2009*/
        /*----------------*/
        nv_sprem[14]  = nv_sprem[14]  + agtprm_fil.prem
        nv_scomm[14]  = nv_scomm[14]  + agtprm_fil.comm
        /*----- A48-0113 -----*/
        nv_snet[14]   = nv_snet[14]   + agtprm_fil.gross
        nv_sres[14]   = nv_sres[14]   + agtprm_fil.odue
        nv_nsbal[14]  = nv_nsbal[14] +  agtprm_fil.gross - agtprm_fil.odue /*Lukkana M. A52-0241 22/10/2009*/
        nv_sbal[14]   = nv_sbal[14]   + nv_netbal
        /*--- END A48-0113 ---*/
        /*----A50-0218----*/
        nv_sbalos[14] = nv_sbalos[14]   + agtprm_fil.bal   
        nv_svat[14] = nv_svat[14]   + nv_vat    
        nv_stax[14] = nv_stax[14]   + nv_tax
        nv_snetpd[14] = nv_snetpd[14]   + nv_netpd
        nv_snetpaid[14] = nv_snetpaid[14]   + nv_netpaid /*Lukkana M. A52-0241 21/10/2009*/.

    CASE agtprm_fil.acno_clicod:
    WHEN "RA" THEN
        ASSIGN
            nv_racodep[14]  = nv_racodep[14]  + agtprm_fil.prem
            nv_racodec[14]  = nv_racodec[14]  + agtprm_fil.comm
            nv_racoden[14]  = nv_racoden[14]  + agtprm_fil.gross
            nv_racoder[14]  = nv_racoder[14]  + agtprm_fil.odue
            nv_racodeb[14]  = nv_racodeb[14]  + nv_netbal
            nv_nracodeb[14] = nv_nracodeb[14] + agtprm_fil.gross - agtprm_fil.odue. /*Lukkana M. A52-0241 21/10/2009*/        
    WHEN "RD" THEN 
        ASSIGN
            nv_rdcodep[14]  = nv_rdcodep[14]  + agtprm_fil.prem
            nv_rdcodec[14]  = nv_rdcodec[14]  + agtprm_fil.comm 
            nv_rdcoden[14]  = nv_rdcoden[14]  + agtprm_fil.gross
            nv_rdcoder[14]  = nv_rdcoder[14]  + agtprm_fil.odue 
            nv_rdcodeb[14]  = nv_rdcodeb[14]  + nv_netbal
            nv_nrdcodeb[14] = nv_nrdcodeb[14] + agtprm_fil.gross - agtprm_fil.odue. /*Lukkana M. A52-0241 21/10/2009*/
    WHEN "RF" OR WHEN "RB" THEN
        ASSIGN
            nv_rfcodep[14]  = nv_rfcodep[14]  + agtprm_fil.prem
            nv_rfcodec[14]  = nv_rfcodec[14]  + agtprm_fil.comm 
            nv_rfcoden[14]  = nv_rfcoden[14]  + agtprm_fil.gross
            nv_rfcoder[14]  = nv_rfcoder[14]  + agtprm_fil.odue 
            nv_rfcodeb[14]  = nv_rfcodeb[14]  + nv_netbal
            nv_nrfcodeb[14] = nv_nrfcodeb[14] + agtprm_fil.gross - agtprm_fil.odue. /*Lukkana M. A52-0241 21/10/2009*/
    END CASE. 

    IF agtprm_fil.odue = agtprm_fil.bal THEN 
        ASSIGN  nv_netpd   = 0
                nv_netpaid = 0. /*Lukkana M. A52-0241 21/10/2009*/

    IF agtprm_fil.trndat = ? THEN nv_trndat = "".
    ELSE nv_trndat = STRING(agtprm_fil.trndat).
    IF agtprm_fil.comdat = ? THEN nv_comdat = "".
    ELSE nv_comdat = STRING(agtprm_fil.comdat).    
    
    IF      INDEX(agtprm_fil.policy,"PM") > 0    THEN nv_fron = 3.
    ELSE IF SUBSTR(agtprm_fil.policy,3,2) = "61" THEN nv_fron = 5. /* Column : % Fronting Fee */
    ELSE IF SUBSTR(agtprm_fil.policy,3,2) = "65" THEN nv_fron = 3.
    ELSE    nv_fron = 0. 

    FIND FIRST uwm100 WHERE uwm100.policy = agtprm_fil.policy
                       AND uwm100.endno  = agtprm_fil.endno NO-LOCK NO-ERROR.
        
    IF AVAIL uwm100 THEN DO:
        ASSIGN  
            nv_prod = uwm100.cr_1  /* Column : Payment Term */
            nv_appe = uwm100.cr_2. /* Column : Aviva Policy Number / Unique ID Number */
                
        FIND FIRST uwm120 USE-INDEX uwm12001 WHERE uwm120.policy = uwm100.policy
                                               AND uwm120.rencnt = uwm100.rencnt
                                               AND uwm120.endcnt = uwm100.endcnt NO-LOCK NO-ERROR.

        IF AVAIL uwm120 THEN nv_comm = uwm120.com1p. /* Column : % Comm */            
        
        FIND FIRST uwm200 USE-INDEX uwm20001 WHERE uwm200.policy = uwm100.policy
                                               AND uwm200.rencnt = uwm100.rencnt
                                               AND uwm200.endcnt = uwm100.endcnt
                                               AND uwm200.csftq  = "F"
                                               AND uwm200.rico   = "0FAVI" NO-LOCK NO-ERROR.

        IF AVAIL uwm200 THEN nv_comm = uwm200.rip1 - nv_fron.        
    END.

    nv_vat7  = (agtprm_fil.prem - agtprm_fil.comm) * 0.07. /* Column : Vat 7% ((RI Premiun - RI Comm) * 7%)  */
    nv_tvat7 = nv_tvat7 + nv_vat7.

    nv_rese  = agtprm_fil.prem * 0.40. /* Column : Reserve (40% RI Premiun)  */
    nv_trese = nv_trese + nv_rese.

    nv_yous  = agtprm_fil.gross - nv_rese.  /* Column : Your Share (Net Amount - Reserve) */
    nv_tyous = nv_tyous + nv_yous.

    OUTPUT TO VALUE (STRING(n_OutputFileAvi)) APPEND NO-ECHO.
        EXPORT DELIMITER ";"
            agtprm_fil.acno
            nv_acname            
            nv_trndat  /*-Lukkana M. A52-0241 30/10/2009*/
            nv_comdat
            agtprm_fil.trntyp
            "'" + agtprm_fil.docno FORMAT "x(10)"  /* Benjaporn J. A60-0267 date 27/06/2017 */
            agtprm_fil.policy
            nv_appe
            agtprm_fil.endno                                                         
            agtprm_fil.insure
            nv_prod
            agtprm_fil.opnpol
            agtprm_fil.prvpol
            agtprm_fil.comm_comp /*-- sum insured Lukkana M. A52-0241 07/10/2009--*/
            agtprm_fil.prem
            agtprm_fil.comm
            STRING(nv_comm) + "%"
            STRING(nv_fron) + "%"
            agtprm_fil.gross           
            nv_vat7
            nv_rese                    
            nv_yous
            nv_blankX[1 FOR 2]
            agtprm_fil.bal                         
            agtprm_fil.poldes.         /* A50-0218 */           
    OUTPUT CLOSE.

    ASSIGN
        nv_ffield     = 0
        nv_sfield     = 0
        nv_fieldbal   = 0. 

    IF LAST-OF(agtprm_fil.acno) THEN DO:        
        OUTPUT TO VALUE (STRING(n_OutputFileAvi)) APPEND NO-ECHO.
        EXPORT DELIMITER ";"
            "Total : " + agtprm_fil.acno
            nv_blankX[1 FOR 12] 
            nv_tsumin  /*--Lukkana M. A52-0241 30/09/2009--*/
            nv_tprem            
            nv_tcomm
            nv_blankX[1 FOR 2]
            nv_tnet     /* A48-0113 */           
            nv_tvat7
            nv_trese
            nv_tyous
            nv_blankX[1 FOR 2]
            nv_tbalos. 
        EXPORT DELIMITER ";" "".
        OUTPUT CLOSE.        
        
        ASSIGN            
            nv_gvat7  = nv_gvat7 + nv_tvat7
            nv_grese  = nv_grese + nv_trese
            nv_gyous  = nv_gyous + nv_tyous
            nv_tprem  = 0 
            nv_tcomm  = 0 
            nv_tnet   = 0 
            nv_tres   = 0 
            nv_tbal   = 0 
            nv_tbalos = 0 
            nv_tvat   = 0 
            nv_ttax   = 0 
            nv_tnetpd = 0 
            nv_tsumin = 0 
            nv_tnetpaid = 0        
            nv_ftotal = 0 
            nv_stotal = 0 
            nv_totbal = 0
            nv_tvat7  = 0
            nv_trese  = 0
            nv_tyous  = 0.
    END.

    ACCUMULATE
        agtprm_fil.prem      (TOTAL)
        agtprm_fil.comm      (TOTAL)
        agtprm_fil.gross     (TOTAL)        
        agtprm_fil.bal       (TOTAL)
        nv_vat               (TOTAL)
        nv_tax               (TOTAL)   
        nv_netpd             (TOTAL)  
        nv_netpaid           (TOTAL)  /*Lukkana M. A52-0241 21/10/2009*/
        agtprm_fil.comm_comp (total). /*Lukkana M. A52-0241 21/10/2009*/

    /********************** Page Footer *********************/
    /*** export ข้อมูลลง DETAIL FILE บรรทัด Grand Total  และ  
                         SUMMARY FILE บรรทัด Grand Total ***/
    IF LAST(agtprm_fil.acno) THEN DO:       
        OUTPUT TO VALUE (n_OutputFileAvi) APPEND NO-ECHO.
         ASSIGN
            nv_gsumin  = (ACCUM TOTAL agtprm_fil.comm_comp) /*--Lukkana M. A52-0241 05/10/2009---*/    
            nv_gprem   = (ACCUM TOTAL agtprm_fil.prem)
            nv_gcomm   = (ACCUM TOTAL agtprm_fil.comm)
            nv_gnet    = (ACCUM TOTAL agtprm_fil.gross)
             /*--A50-0218---*/
            nv_gvat     = (ACCUM TOTAL nv_vat)
            nv_gtax     = (ACCUM TOTAL nv_tax)
            nv_gnetpd   = (ACCUM TOTAL nv_netpd)
            /*-------------*/
            /*nv_gres    = (ACCUM TOTAL agtprm_fil.odue) Lukkana M. A52-0241 28/10/2009*/
            nv_gbalos  = (ACCUM TOTAL agtprm_fil.bal)                        
            nv_gbal    = (ACCUM TOTAL agtprm_fil.gross) .     /*--Lukkana M. A52-0241 05/10/2009---*/          
        RUN pdFooterAvi.
        OUTPUT CLOSE.
               
        RUN pdInitDataG.    /* clear data */
    END. /* if last(agtprm_fil.acno) then */
END. /* for each agtprm_fil*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdOwAvi083 wacr2001 
PROCEDURE pdOwAvi083 :
ASSIGN nv_blankX = FILL(" ",8)
       nv_stotal = 0.

IF MONTH(fiasdat) = MONTH(fiasdatAging) THEN 
    ASSIGN nv_gap = 12 - MONTH(fiasdatAging).
ELSE ASSIGN nv_gap = 12 - MONTH(fiasdatAging) + 1 .
i = 0.

FOR EACH  agtprm_fil USE-INDEX by_acno WHERE
          agtprm_fil.asdat        =  n_asdat        AND
         (agtprm_fil.acno        >=  n_frac         AND
          agtprm_fil.acno        <=  n_toac )       AND
 ( SUBSTR(agtprm_fil.policy,3,2) >=  nv_poltypFr    AND
   SUBSTR(agtprm_fil.policy,3,2) <=  nv_poltypTo)   AND
         (agtprm_fil.polbran     >=  n_branch       AND 
          agtprm_fil.polbran     <=  n_branch2)     AND
          /*agtprm_fil.poldes      <> ""             AND*/
  (LOOKUP(SUBSTR(agtprm_fil.trntyp,1,1) , nv_trntyp1) <> 0 ) AND
              (agtprm_fil.poldes         =  "O/S = 0"   OR
               agtprm_fil.poldes         =  "O/S < 0")      
NO-LOCK BREAK BY agtprm_fil.acno
              BY agtprm_fil.trndat
              BY SUBSTR(agtprm_fil.policy,3,2)
              BY agtprm_fil.policy
              BY agtprm_fil.endno.
                                 
 i = i + 1.
    /*    NO-LOCK BREAK BY agtprm_fil.acno BY agtprm_fil.polbran BY agtprm_fil.trndat. */

    DISP  /*agtprm_fil.acno --- A500178 ---*/ 
          i
          agtprm_fil.acno FORMAT "X(10)"
          agtprm_fil.trndat     /* Trans. Date */
          agtprm_fil.policy
          agtprm_fil.endno
          agtprm_fil.trntyp
          agtprm_fil.docno FORMAT "x(10)"  /* Benjaporn J. A60-0267 date 27/06/2017 */
    WITH COLOR BLACK/WHITE NO-LABEL FRAME frProcess VIEW-AS DIALOG-BOX
    TITLE  "  Processing...  ".

    n_asdat = IF nv_asdatAging = ? THEN n_asdat ELSE nv_asdatAging.

    /* Begin */
    /********************** Group Header *********************/
        
    IF FIRST-OF(agtprm_fil.acno)  THEN DO:
        nv_acname = "".
        FIND xmm600 USE-INDEX xmm60001 WHERE
             xmm600.acno = agtprm_fil.acno NO-LOCK NO-ERROR.
        IF AVAIL xmm600 THEN
           ASSIGN  nv_acname = TRIM(xmm600.ntitle) + " " + TRIM(xmm600.name) 
                   nv_relate = xmm600.agtreg   /*A50-0218*/
                   nv_notes1 = xmm600.notes1 . /*--Lukkana M. A52-0241 08/10/2009--*/
        ELSE ASSIGN nv_acname = " " 
                    nv_relate = ""
                    nv_notes1 = "" . /*--Lukkana M. A52-0241 08/10/2009--*/

        /*--- DISPLAY DETAIL ---*/        
       /* OUTPUT TO VALUE (STRING(n_OutputFileAvi)) APPEND NO-ECHO.
            EXPORT DELIMITER ";" " ".
            EXPORT DELIMITER ";"
                agtprm_fil.acno + " - " + nv_acname + "   <" +
                agtprm_fil.acno_clicod  + ">" .
        OUTPUT CLOSE.  */
    END.  /* first-of(agtprm_fil.acno) */
    
    ASSIGN 
        nv_num    = 0
        nv_netbal = 0           
        nv_netbal = agtprm_fil.gross  /*--Lukkana M. a52-0241 05/10/2009---*/

        /*----A50-0218----*/
        nv_balos  = 0       
        nv_vat    = 0
        nv_tax    = 0
        nv_netpd  = 0
        nv_netpaid = 0 /*Lukkana M. A52-0241 21/10/2009*/
        nv_vatt   = 0 /*Lukkana M. A52-0241 21/10/2009*/
        nv_balos  = agtprm_fil.bal   . 
    RUN pdmonth. /*--Lukkana M. A52-0241 08/10/2009--*/
        
      /*-- Lukkana M. A52-0241 30/09/2009 --*/
      nv_vatt  = agtprm_fil.prem + agtprm_fil.comm.
      IF SUBSTR(agtprm_fil.acno,1,2) = "0F" OR SUBSTR(agtprm_fil.acno,1,2) = "0A"  THEN DO: /*งานต่างประเทศไม่คิด vat , tax*/
          ASSIGN nv_vat = 0
                 nv_tax = 0.
      END.
      ELSE DO: 
          nv_poltyp = SUBSTR(agtprm_fil.policy,3,2). 
          IF LOOKUP(nv_poltyp,nv_pa) <> 0 THEN  /* line 60,61,62,63,64,67 ไม่คิด vat , tax */
             ASSIGN nv_vat = 0
                    nv_tax = 0.
          ELSE 
              ASSIGN nv_vat  = ROUND(nv_vatt * 0.07,2)
                     nv_tax  = ROUND(nv_vatt * 0.01,2).
      END.
      ASSIGN nv_netpd  = ROUND(nv_netbal + nv_vat - nv_tax,2)
             nv_netpaid  = ROUND(nv_vatt + nv_vat - nv_tax /*- agtprm_fil.odue*/ ,2). /*prem-comm+vat-tax Lukkana M. A52-0241 21/10/2009*/

      nv_gnetpaid = nv_gnetpaid + nv_netpaid. /*Lukkana M. A52-0241 21/10/2009*/   
    
    RUN pdRunwacr.   /*--Lukkana M. A52-0241 08/10/2009--*/
  /*  {wac/wacr2004.i} /*--Lukkana M. A52-0241 08/10/2009--*/*/

    ASSIGN
        nv_tsumin     = nv_tsumin + agtprm_fil.comm_comp /*Lukkana M. A52-0241 21/10/2009*/
        nv_tprem      = nv_tprem + agtprm_fil.prem
        nv_tcomm      = nv_tcomm + agtprm_fil.comm
        /*----- A48-0113 -----*/
        nv_tnet       = nv_tnet  + agtprm_fil.gross
        nv_tres       = nv_tres  + agtprm_fil.odue
        nv_tbal       = nv_tbal  + nv_netbal
        /*--- END A48-0113 ---*/
        /*----A50-0218----*/
        nv_tbalos   = nv_tbalos + agtprm_fil.bal         
        nv_tvat     = nv_tvat + nv_vat  
        nv_ttax     = nv_ttax + nv_tax
        nv_tnetpd   = nv_tnetpd + nv_netpd
        nv_tnetpaid   = nv_tnetpaid + nv_netpaid /*Lukkana M. A52-0241 21/10/2009*/
        /*----------------*/
        nv_sprem[14]  = nv_sprem[14]  + agtprm_fil.prem
        nv_scomm[14]  = nv_scomm[14]  + agtprm_fil.comm
        /*----- A48-0113 -----*/
        nv_snet[14]   = nv_snet[14]   + agtprm_fil.gross
        nv_sres[14]   = nv_sres[14]   + agtprm_fil.odue
        nv_nsbal[14]  = nv_nsbal[14] +  agtprm_fil.gross - agtprm_fil.odue /*Lukkana M. A52-0241 22/10/2009*/
        nv_sbal[14]   = nv_sbal[14]   + nv_netbal
        /*--- END A48-0113 ---*/
        /*----A50-0218----*/
        nv_sbalos[14] = nv_sbalos[14]   + agtprm_fil.bal   
        nv_svat[14] = nv_svat[14]   + nv_vat    
        nv_stax[14] = nv_stax[14]   + nv_tax
        nv_snetpd[14] = nv_snetpd[14]   + nv_netpd
        nv_snetpaid[14] = nv_snetpaid[14]   + nv_netpaid /*Lukkana M. A52-0241 21/10/2009*/.

    CASE agtprm_fil.acno_clicod:
    WHEN "RA" THEN
        ASSIGN
            nv_racodep[14]  = nv_racodep[14]  + agtprm_fil.prem
            nv_racodec[14]  = nv_racodec[14]  + agtprm_fil.comm
            nv_racoden[14]  = nv_racoden[14]  + agtprm_fil.gross
            nv_racoder[14]  = nv_racoder[14]  + agtprm_fil.odue
            nv_racodeb[14]  = nv_racodeb[14]  + nv_netbal
            nv_nracodeb[14] = nv_nracodeb[14] + agtprm_fil.gross - agtprm_fil.odue. /*Lukkana M. A52-0241 21/10/2009*/        
    WHEN "RD" THEN 
        ASSIGN
            nv_rdcodep[14]  = nv_rdcodep[14]  + agtprm_fil.prem
            nv_rdcodec[14]  = nv_rdcodec[14]  + agtprm_fil.comm 
            nv_rdcoden[14]  = nv_rdcoden[14]  + agtprm_fil.gross
            nv_rdcoder[14]  = nv_rdcoder[14]  + agtprm_fil.odue 
            nv_rdcodeb[14]  = nv_rdcodeb[14]  + nv_netbal
            nv_nrdcodeb[14] = nv_nrdcodeb[14] + agtprm_fil.gross - agtprm_fil.odue. /*Lukkana M. A52-0241 21/10/2009*/
    WHEN "RF" OR WHEN "RB" THEN
        ASSIGN
            nv_rfcodep[14]  = nv_rfcodep[14]  + agtprm_fil.prem
            nv_rfcodec[14]  = nv_rfcodec[14]  + agtprm_fil.comm 
            nv_rfcoden[14]  = nv_rfcoden[14]  + agtprm_fil.gross
            nv_rfcoder[14]  = nv_rfcoder[14]  + agtprm_fil.odue 
            nv_rfcodeb[14]  = nv_rfcodeb[14]  + nv_netbal
            nv_nrfcodeb[14] = nv_nrfcodeb[14] + agtprm_fil.gross - agtprm_fil.odue. /*Lukkana M. A52-0241 21/10/2009*/
    END CASE. 

    IF agtprm_fil.odue = agtprm_fil.bal THEN 
        ASSIGN  nv_netpd   = 0
                nv_netpaid = 0. /*Lukkana M. A52-0241 21/10/2009*/

    IF agtprm_fil.trndat = ? THEN nv_trndat = "".
    ELSE nv_trndat = STRING(agtprm_fil.trndat).
    IF agtprm_fil.comdat = ? THEN nv_comdat = "".
    ELSE nv_comdat = STRING(agtprm_fil.comdat).    
    
    IF      INDEX(agtprm_fil.policy,"PM") > 0    THEN nv_fron = 3.
    ELSE IF SUBSTR(agtprm_fil.policy,3,2) = "61" THEN nv_fron = 5. /* Column : % Fronting Fee */
    ELSE IF SUBSTR(agtprm_fil.policy,3,2) = "65" THEN nv_fron = 3.
    ELSE    nv_fron = 0. 

    FIND FIRST uwm100 WHERE uwm100.policy = agtprm_fil.policy
                       AND uwm100.endno  = agtprm_fil.endno NO-LOCK NO-ERROR.
        
    IF AVAIL uwm100 THEN DO:
        ASSIGN  
            nv_prod = uwm100.cr_1  /* Column : Payment Term */
            nv_appe = uwm100.cr_2. /* Column : Aviva Policy Number / Unique ID Number */
                
        FIND FIRST uwm120 USE-INDEX uwm12001 WHERE uwm120.policy = uwm100.policy
                                               AND uwm120.rencnt = uwm100.rencnt
                                               AND uwm120.endcnt = uwm100.endcnt NO-LOCK NO-ERROR.

        IF AVAIL uwm120 THEN nv_comm = uwm120.com1p. /* Column : % Comm */            
        
        FIND FIRST uwm200 USE-INDEX uwm20001 WHERE uwm200.policy = uwm100.policy
                                               AND uwm200.rencnt = uwm100.rencnt
                                               AND uwm200.endcnt = uwm100.endcnt
                                               AND uwm200.csftq  = "F"
                                               AND uwm200.rico   = "0FAVI" NO-LOCK NO-ERROR.

        IF AVAIL uwm200 THEN nv_comm = uwm200.rip1 - nv_fron.        
    END.

    nv_vat7  = (agtprm_fil.prem - agtprm_fil.comm) * 0.07. /* Column : Vat 7% ((RI Premiun - RI Comm) * 7%)  */
    nv_tvat7 = nv_tvat7 + nv_vat7.

    nv_rese  = agtprm_fil.prem * 0.40. /* Column : Reserve (40% RI Premiun)  */
    nv_trese = nv_trese + nv_rese.

    nv_yous  = agtprm_fil.gross - nv_rese.  /* Column : Your Share (Net Amount - Reserve) */
    nv_tyous = nv_tyous + nv_yous.

    OUTPUT TO VALUE (STRING(n_OutputFileAvi)) APPEND NO-ECHO.
        EXPORT DELIMITER ";"
            agtprm_fil.acno
            nv_acname            
            nv_trndat  /*-Lukkana M. A52-0241 30/10/2009*/
            nv_comdat
            agtprm_fil.trntyp
            "'" + agtprm_fil.docno FORMAT "x(10)"  /* Benjaporn J. A60-0267 date 27/06/2017 */
            agtprm_fil.policy
            nv_appe
            agtprm_fil.endno                                                         
            agtprm_fil.insure
            nv_prod
            agtprm_fil.opnpol
            agtprm_fil.prvpol
            agtprm_fil.comm_comp /*-- sum insured Lukkana M. A52-0241 07/10/2009--*/
            agtprm_fil.prem
            agtprm_fil.comm
            STRING(nv_comm) + "%"
            STRING(nv_fron) + "%"
            agtprm_fil.gross           
            nv_vat7
            nv_rese                    
            nv_yous
            nv_blankX[1 FOR 2]
            agtprm_fil.bal                         
            agtprm_fil.poldes.         /* A50-0218 */           
    OUTPUT CLOSE.

    ASSIGN
        nv_ffield     = 0
        nv_sfield     = 0
        nv_fieldbal   = 0. 

    IF LAST-OF(agtprm_fil.acno) THEN DO:        
        OUTPUT TO VALUE (STRING(n_OutputFileAvi)) APPEND NO-ECHO.
        EXPORT DELIMITER ";"
            "Total : " + agtprm_fil.acno
            nv_blankX[1 FOR 12] 
            nv_tsumin  /*--Lukkana M. A52-0241 30/09/2009--*/
            nv_tprem            
            nv_tcomm
            nv_blankX[1 FOR 2]
            nv_tnet     /* A48-0113 */           
            nv_tvat7
            nv_trese
            nv_tyous
            nv_blankX[1 FOR 2]
            nv_tbalos. 
        EXPORT DELIMITER ";" "".
        OUTPUT CLOSE.        
        
        ASSIGN            
            nv_gvat7  = nv_gvat7 + nv_tvat7
            nv_grese  = nv_grese + nv_trese
            nv_gyous  = nv_gyous + nv_tyous
            nv_tprem  = 0 
            nv_tcomm  = 0 
            nv_tnet   = 0 
            nv_tres   = 0 
            nv_tbal   = 0 
            nv_tbalos = 0 
            nv_tvat   = 0 
            nv_ttax   = 0 
            nv_tnetpd = 0 
            nv_tsumin = 0 
            nv_tnetpaid = 0        
            nv_ftotal = 0 
            nv_stotal = 0 
            nv_totbal = 0
            nv_tvat7  = 0
            nv_trese  = 0
            nv_tyous  = 0.
    END.

    ACCUMULATE
        agtprm_fil.prem      (TOTAL)
        agtprm_fil.comm      (TOTAL)
        agtprm_fil.gross     (TOTAL)        
        agtprm_fil.bal       (TOTAL)
        nv_vat               (TOTAL)
        nv_tax               (TOTAL)   
        nv_netpd             (TOTAL)  
        nv_netpaid           (TOTAL)  /*Lukkana M. A52-0241 21/10/2009*/
        agtprm_fil.comm_comp (total). /*Lukkana M. A52-0241 21/10/2009*/

    /********************** Page Footer *********************/
    /*** export ข้อมูลลง DETAIL FILE บรรทัด Grand Total  และ  
                         SUMMARY FILE บรรทัด Grand Total ***/
    IF LAST(agtprm_fil.acno) THEN DO:       
        OUTPUT TO VALUE (n_OutputFileAvi) APPEND NO-ECHO.
         ASSIGN
            nv_gsumin  = (ACCUM TOTAL agtprm_fil.comm_comp) /*--Lukkana M. A52-0241 05/10/2009---*/    
            nv_gprem   = (ACCUM TOTAL agtprm_fil.prem)
            nv_gcomm   = (ACCUM TOTAL agtprm_fil.comm)
            nv_gnet    = (ACCUM TOTAL agtprm_fil.gross)
             /*--A50-0218---*/
            nv_gvat     = (ACCUM TOTAL nv_vat)
            nv_gtax     = (ACCUM TOTAL nv_tax)
            nv_gnetpd   = (ACCUM TOTAL nv_netpd)
            /*-------------*/
            /*nv_gres    = (ACCUM TOTAL agtprm_fil.odue) Lukkana M. A52-0241 28/10/2009*/
            nv_gbalos  = (ACCUM TOTAL agtprm_fil.bal)                        
            nv_gbal    = (ACCUM TOTAL agtprm_fil.gross) .     /*--Lukkana M. A52-0241 05/10/2009---*/          
        RUN pdFooterAvi.
        OUTPUT CLOSE.
               
        RUN pdInitDataG.    /* clear data */
    END. /* if last(agtprm_fil.acno) then */
END. /* for each agtprm_fil*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdpagehead wacr2001 
PROCEDURE pdpagehead :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*--Lukkana M. A52-0241 15/10/2009--*/
/********************** Page Header *********************/
    /*--- DISPLAY DETAIL  ---*/
    IF (nv_DetSum = "Detail")  OR (nv_DetSum = "All") THEN DO:
        OUTPUT TO VALUE (n_OutputFile ) NO-ECHO.
            RUN pdTitleDet.   
            RUN pdPageHeadDet.
        OUTPUT CLOSE.
    END.  /* (nv_DetSum = "Detail")  OR (nv_DetSum = "All") */
    /*** DISPLAY SUMMARY FILE & SUMMARY GRAND TOTAL***/
    IF (nv_DetSum = "Summary")  OR (nv_DetSum = "All") THEN DO:
        OUTPUT TO VALUE (n_OutputFileSum) NO-ECHO.  /* SUMMARY */
            RUN pdTitleSum.
            RUN pdPageHeadSum.
        OUTPUT CLOSE.
        /*---By A50-0218----*/
        OUTPUT TO VALUE (n_OutputFileNet) NO-ECHO.  /* NETBAL */
            RUN pdTitleNet.
            RUN pdPageHeadNet.
        OUTPUT CLOSE.
        /*------------------*/

        /* Begin by Phaiboon W. [A59-0125] 01/04/2016 */        
        OUTPUT TO VALUE (n_OutputFileNzi) NO-ECHO. /* NZI */
            RUN pdTitleNzi.
            RUN pdPageHeadNzi.
        OUTPUT CLOSE.
        /* End by Phaiboon W. [A59-0125] 01/04/2016 */

    END.  /* (nv_DetSum = "Summary")  OR (nv_DetSum = "All")  */
    /*--Lukkana M. A52-0241 15/10/2009--*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdPageHeadAvi wacr2001 
PROCEDURE pdPageHeadAvi :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
IF nv_reptyp = "07" THEN DO:
    EXPORT DELIMITER ";"        
        "Producer"
        "Producer Name"
        "Trans. Date"
        "Comm. Date"
        "Tran. Type"
        "Doc. No."
        "Policy No."
        "Aviva Policy Number / Unique ID Number"
        "Endt. No."
        "Insured Name"   
        "Payment Term"
        "R/I Appl No."
        "Alteration"   
        "Sum Insure - Reinsurance"
        "RI Premium"
        "RI Comm." 
        "% Comm"
        "% Fronting Fee"
        "Net Amount"
        "Vat 7%"
        "Reserve"
        "Your Share"
        "Remark STY"
        "Remark AVIVA"
        "Bal O/S".
END.
ELSE DO:
    EXPORT DELIMITER ";"        
        "Producer"
        "Producer Name"
        "Trans. Date"
        "Comm. Date"
        "Tran. Type"
        "Doc. No."
        "Policy No."
        "Aviva Policy Number / Unique ID Number"
        "Endt. No."
        "Insured Name"   
        "Payment Term"
        "R/I Appl No."
        "Alteration"   
        "Sum Insure - Reinsurance"
        "RI Premium"
        "RI Comm." 
        "% Comm"
        "% Fronting Fee"
        "Net Amount"
        "Vat 7%"
        "Reserve"
        "Your Share"
        "Remark STY"
        "Remark AVIVA"
        "Bal O/S"
        "Status O/S".
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdPageHeadDet wacr2001 
PROCEDURE pdPageHeadDet :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

nv_blankF = FILL(" " , 15).

IF nv_reptyp = "07" THEN DO:

    EXPORT DELIMITER ";"

        "Producer"
        "Producer Name"
        "Trans. Date"
        "Policy No."
        "Endt. No."
        "Comm. Date"
        "Tran. Type"
        "Doc. No."
        "Customer"
        "Sum Insure - Reinsurance" /*--Lukkana M. A52-0241 08/10/2009--*/
        "Premium"
        /*- A50-0218 -*/
        "VAT 7%"
        "Commission"
        "Net Amount"  /*--Lukkana M. A52-0241 08/10/2009--*/
        "TAX 1%"
        /*"Reserve"  --Lukkana M. A52-0241 08/10/2009--*/
        "Net Paid" /*--Lukkana M. A52-0241 08/10/2009--*/
        /*------------*/
        "Balance O/S"
        "Expiry Date"
        "Leasing No."
        "< 1 months" /*-- Lukkana M. A52-0241 30/09/2009 --*/
        "1 months"
        "2 months"
        "3 months"
        "4 months"
        "5 months"
        "6 months"
        "7 months"
        "8 months"
        "9 months"
        "10 months"
        "11 months"
        "12 months"
        "over 12 months"
        /*--Lukkana M. A52-0241 08/10/2009--*/
        "over 24 months"
        "over 36 months"
        "over 48 months"
        /*--Lukkana M. A52-0241 08/10/2009--*/
        .
END.
ELSE DO:
    /*------ A48-0113 ------*/
    EXPORT DELIMITER ";"

        "Producer"
        "Producer Name"
        "Trans. Date"
        "Policy No."
        "Endt. No."
        "Comm. Date"
        "Expiry Date"
        "Tran. Type"
        "Doc. No."
        "Insured Name"
        "R/I Appl No."
        "Alteration"
        "Sum Insure - Reinsurance" /*--Lukkana M. a52-0241 30/09/2009--*/
        "Gross Premium"
        "Commission"
        "Net Amount"
        /*---A50-0218---*/
        "Vat 7%" 
        "Tax 1%"
        /*"Reserve"*/
        /*---------------*/
        /*--- A50-0218
        "Reserve"  
        "Net Balance" 
        --------*/
        "Net Paid"       /*Net Amount + vat - tax-reserve*/
        "Bal O/S"        /*A50-0218*/

        /*---Lukkana M. A52-0241 30/09/2009
        "1 months"              "1 months"
        "2 months"              "2 months"
        "3 months"              "3 months"
        "4 months"              "4 months"
        "5 months"              "5 months"
        "6 months"              "6 months" 
        "7 months"              "7 months" 
        "8 months"              "8 months" 
        "9 months"              "9 months" 
        "10 months"             "10 months" 
        "11 months"             "11 months"
        "12 months"             "12 months"
        "over 12 months"        "over 12 months"
        Lukkana M. A52-0241 30/09/2009---*/

        /*--Lukkana M. A52-0241 30/09/2009--*/
        "< 1 month" 
        "1 months"              
        "2 months"              
        "3 months"              
        "4 months"              
        "5 months"              
        "6 months"              
        "7 months"              
        "8 months"              
        "9 months"              
        "10 months"             
        "11 months"             
        "12 months"             
        "over 12 months"      
        "over 24 months" 
        "over 36 months"
        "over 48 months"
        /*--Lukkana M. A52-0241 30/09/2009--*/

        "Status O/S" .         /*A50-0218*/
            
    /*--Lukkana M. A52-0241 30/09/2009--
    EXPORT DELIMITER ";"
        /*nv_blankF[1 FOR 17]       /* ใส่ ช่องว่าง  17 ช่อง */ A50-0218*/
        nv_blankF[1 FOR 21]       /* ใส่ ช่องว่าง  21 ช่อง      A50-0218*/
        "Net Amount"       "Prem.Reserve"
        "Net Amount"       "Prem.Reserve"
        "Net Amount"       "Prem.Reserve"
        "Net Amount"       "Prem.Reserve"
        "Net Amount"       "Prem.Reserve"
        "Net Amount"       "Prem.Reserve"
        "Net Amount"       "Prem.Reserve"
        "Net Amount"       "Prem.Reserve"
        "Net Amount"       "Prem.Reserve"
        "Net Amount"       "Prem.Reserve"
        "Net Amount"       "Prem.Reserve"
        "Net Amount"       "Prem.Reserve"
        "Net Amount"       "Prem.Reserve"
        .
    --Lukkana M. A52-0241 30/09/2009--*/

    /*---- END A48-0113 ----*/
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdPageHeadNet wacr2001 
PROCEDURE pdPageHeadNet :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:  Add Report File (Net) --- A50-0218        
------------------------------------------------------------------------------*/

EXPORT DELIMITER ";"
    "DOI Code"
    "Code"
    "Name"
    "Net Balance"
    "< 1 month" /*-- Lukkana M. A52-0241 30/09/2009 --*/
    "1 months"
    "2 months"
    "3 months"
    "4 months"
    "5 months"
    "6 months"
    "7 months"
    "8 months"
    "9 months"
    "10 months"
    "11 months"
    "12 months"
    "over 12 months" 
    /*--Lukkana M. A52-0241 08/10/2009--*/
    "over 24 months"
    "over 36 months"
    "over 48 months"
    /*-- Lukkana M. A52-0241 08/10/2009 --*/

    "Remark" .

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdPageHeadNzi wacr2001 
PROCEDURE pdPageHeadNzi :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

EXPORT DELIMITER ";"
    "Branch"
    "DOI Code"
    "Code"
    "Name"
    "Net Balance"
    "< 1 month"
    "1 months"
    "2 months"
    "3 months"
    "4-6 months"   
    "7-9 months"
    "10-12 months"
    ">12 months"   
    "Remark" .
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdPageHeadSum wacr2001 
PROCEDURE pdPageHeadSum :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

EXPORT DELIMITER ";"
    /*
    "Summary Type"
    "Total"
    "Within"
    "Due amount"
    */

    "Reinsurance" /*-- Lukkana M. A52-0241 08/10/2009 --*/
    "Summary Type"
    "Total" 
 
    "< 1 month" /*-- Lukkana M. A52-0241 30/09/2009 --*/
    "1 months"
    "2 months"
    "3 months"
    "4 months"
    "5 months"
    "6 months"
    "7 months"
    "8 months"
    "9 months"
    "10 months"
    "11 months"
    "12 months"
    "over 12 months" 
    /*--Lukkana M. A52-0241 08/10/2009--*/
    "over 24 months"
    "over 36 months"
    "over 48 months"
    /*--Lukkana M. A52-0241 08/10/2009--*/
    
    "Remark" .

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdProcess07 wacr2001 
PROCEDURE pdProcess07 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*-- Lukkana M. A52-0241 30/09/2009 --*/
IF nv_num = 0 THEN DO: /*น้อยกว่า 1 เดือน*/
    IF YEAR(agtprm_fil.asdat) = YEAR(agtprm_fil.trndat) THEN DO: /*ปีเดียวกัน*/
        ASSIGN
            nv_dfield[18]  =  nv_prem
            nv_total[18]   =  nv_total[18]   +  nv_prem
            nv_gtotal[18]  =  nv_gtotal[18]  +  nv_prem
            nv_sprem[18]   =  nv_sprem[18]   +  nv_prem
            /*---A50-0218---*/
            nv_svat[18]   =  nv_svat[18]   +  nv_vat
            nv_stax[18]   =  nv_stax[18]   +  nv_tax
            /*--------*/
            nv_scomm[18]   =  nv_scomm[18]   +  agtprm_fil.comm
            nv_sbal[18]    =  nv_sbal[18]    +  agtprm_fil.bal 
            nv_sbal1[18]   =  nv_sbal1[18]   +  agtprm_fil.gross /*Lukkana M. A52-0241 19/10/2009*/
            nv_sgprem[18]  =  nv_sgprem[18]  +  nv_prem
            nv_sgcomm[18]  =  nv_sgcomm[18]  +  agtprm_fil.comm
            nv_sgbal[18]   =  nv_sgbal[18]   +  agtprm_fil.bal
            nv_nzibal[18]  =  nv_nzibal[18]  +  agtprm_fil.gross. /* add by Phaiboon W. [A59-0125] 27/04/2016 */
    END.
    ELSE DO:
        IF YEAR(agtprm_fil.asdat) - YEAR(agtprm_fil.trndat) = 1 THEN DO:

           ASSIGN  
             nv_col             =  (nv_gap + nv_num)  +  MONTH(agtprm_fil.asdat).
           IF nv_col = 0 THEN nv_col = 18. /*กรณีที่เดือน=0 แสดงว่าน้อยกว่า 1 เดือน*/

           ASSIGN
             nv_dfield[nv_col]  =  nv_prem
             nv_total[nv_col]   =  nv_total[nv_col]   +  nv_prem
             nv_gtotal[nv_col]  =  nv_gtotal[nv_col]  +  nv_prem
             nv_sprem[nv_col]   =  nv_sprem[nv_col]   +  nv_prem
            /*---A50-0218---*/
             nv_svat[nv_col]   =  nv_svat[nv_col]   +  nv_vat
             nv_stax[nv_col]   =  nv_stax[nv_col]   +  nv_tax
            /*--------*/
             nv_scomm[nv_col]   =  nv_scomm[nv_col]   +  agtprm_fil.comm
             nv_sbal[nv_col]    =  nv_sbal[nv_col]    +  agtprm_fil.bal 
             nv_sbal1[nv_col]   =  nv_sbal1[nv_col]   +  agtprm_fil.gross /*Lukkana M. A52-0241 19/10/2009*/
             nv_sgprem[nv_col]  =  nv_sgprem[nv_col]  +  nv_prem
             nv_sgcomm[nv_col]  =  nv_sgcomm[nv_col]  +  agtprm_fil.comm
             nv_sgbal[nv_col]   =  nv_sgbal[nv_col]   +  agtprm_fil.bal
             nv_nzibal[nv_col]  =  nv_nzibal[nv_col]  +  agtprm_fil.gross. /* add by Phaiboon W. [A59-0125] 27/04/2016 */
             /*--- lek ---
             CASE agtprm_fil.acno_clicod:
                 WHEN "RA" THEN nv_racode[nv_col] = nv_racode[nv_col] + agtprm_fil.prem .
                 WHEN "RB" THEN nv_rbcode[nv_col] = nv_rbcode[nv_col] + agtprm_fil.prem .
                 WHEN "RD" THEN nv_rdcode[nv_col] = nv_rdcode[nv_col] + agtprm_fil.prem .
                 WHEN "RF" THEN nv_rfcode[nv_col] = nv_rfcode[nv_col] + agtprm_fil.prem .
             END CASE.
             --- end lek ---*/
        END.
        ELSE DO:
            IF YEAR(agtprm_fil.asdat) - YEAR(agtprm_fil.trndat) = 1 THEN DO: /* 1 year */
                ASSIGN
                    nv_dfield[13]  =  nv_prem
                    nv_total[13]   =  nv_total[13]   +  nv_prem
                    nv_gtotal[13]  =  nv_gtotal[13]  +  nv_prem
                    nv_sprem[13]   =  nv_sprem[13]   +  nv_prem
                    /*---A50-0218---*/
                    nv_svat[13]   =  nv_svat[13]   +  nv_vat
                    nv_stax[13]   =  nv_stax[13]   +  nv_tax
                    /*--------*/
                    nv_scomm[13]   =  nv_scomm[13]   +  agtprm_fil.comm
                    nv_sbal[13]    =  nv_sbal[13]    +  agtprm_fil.bal 
                    nv_sbal1[13]   =  nv_sbal1[13]   +  agtprm_fil.gross /*Lukkana M. A52-0241 19/10/2009*/
                    nv_sgprem[13]  =  nv_sgprem[13]  +  nv_prem
                    nv_sgcomm[13]  =  nv_sgcomm[13]  +  agtprm_fil.comm
                    nv_sgbal[13]   =  nv_sgbal[13]   +  agtprm_fil.bal
                    nv_nzibal[13]  =  nv_nzibal[13]  +  agtprm_fil.gross. /* add by Phaiboon W. [A59-0125] 27/04/2016 */
            END.                                                                                                                                        
            ELSE IF YEAR(agtprm_fil.asdat) - YEAR(agtprm_fil.trndat) = 2 THEN DO: /* 2 years */
                ASSIGN
                    nv_dfield[15]  =  nv_prem
                    nv_total[15]   =  nv_total[15]   +  nv_prem
                    nv_gtotal[15]  =  nv_gtotal[15]  +  nv_prem
                    nv_sprem[15]   =  nv_sprem[15]   +  nv_prem
                    /*---A50-0218---*/
                    nv_svat[15]   =  nv_svat[15]   +  nv_vat
                    nv_stax[15]   =  nv_stax[15]   +  nv_tax
                    /*--------*/
                    nv_scomm[15]   =  nv_scomm[15]   +  agtprm_fil.comm
                    nv_sbal[15]    =  nv_sbal[15]    +  agtprm_fil.bal 
                    nv_sbal1[15]   =  nv_sbal1[15]   +  agtprm_fil.gross /*Lukkana M. A52-0241 19/10/2009*/
                    nv_sgprem[15]  =  nv_sgprem[15]  +  nv_prem
                    nv_sgcomm[15]  =  nv_sgcomm[15]  +  agtprm_fil.comm
                    nv_sgbal[15]   =  nv_sgbal[15]   +  agtprm_fil.bal
                    nv_nzibal[15]  =  nv_nzibal[15]  +  agtprm_fil.gross. /* add by Phaiboon W. [A59-0125] 27/04/2016 */
            END.
            ELSE IF YEAR(agtprm_fil.asdat) - YEAR(agtprm_fil.trndat) = 3 THEN DO: /* 3 years */
                ASSIGN
                    nv_dfield[16]  =  nv_prem
                    nv_total[16]   =  nv_total[16]   +  nv_prem
                    nv_gtotal[16]  =  nv_gtotal[16]  +  nv_prem
                    nv_sprem[16]   =  nv_sprem[16]   +  nv_prem
                    /*---A50-0218---*/
                    nv_svat[16]   =  nv_svat[16]   +  nv_vat
                    nv_stax[16]   =  nv_stax[16]   +  nv_tax
                    /*--------*/
                    nv_scomm[16]   =  nv_scomm[16]   +  agtprm_fil.comm
                    nv_sbal[16]    =  nv_sbal[16]    +  agtprm_fil.bal 
                    nv_sbal1[16]   =  nv_sbal1[16]   +  agtprm_fil.gross /*Lukkana M. A52-0241 19/10/2009*/
                    nv_sgprem[16]  =  nv_sgprem[16]  +  nv_prem
                    nv_sgcomm[16]  =  nv_sgcomm[16]  +  agtprm_fil.comm
                    nv_sgbal[16]   =  nv_sgbal[16]   +  agtprm_fil.bal
                    nv_nzibal[16]  =  nv_nzibal[16]  +  agtprm_fil.gross. /* add by Phaiboon W. [A59-0125] 27/04/2016 */
            END.
            ELSE IF YEAR(agtprm_fil.asdat) - YEAR(agtprm_fil.trndat) > 3 THEN DO: /* over 3 years */
                ASSIGN
                    nv_dfield[17]  =  nv_prem
                    nv_total[17]   =  nv_total[17]   +  nv_prem
                    nv_gtotal[17]  =  nv_gtotal[17]  +  nv_prem
                    nv_sprem[17]   =  nv_sprem[17]   +  nv_prem
                    /*---A50-0218---*/
                    nv_svat[17]   =  nv_svat[17]   +  nv_vat
                    nv_stax[17]   =  nv_stax[17]   +  nv_tax
                    /*--------*/
                    nv_scomm[17]   =  nv_scomm[17]   +  agtprm_fil.comm
                    nv_sbal[17]    =  nv_sbal[17]    +  agtprm_fil.bal 
                    nv_sbal1[17]   =  nv_sbal1[17]   +  agtprm_fil.gross /*Lukkana M. A52-0241 19/10/2009*/
                    nv_sgprem[17]  =  nv_sgprem[17]  +  nv_prem
                    nv_sgcomm[17]  =  nv_sgcomm[17]  +  agtprm_fil.comm
                    nv_sgbal[17]   =  nv_sgbal[17]   +  agtprm_fil.bal
                    nv_nzibal[17]  =  nv_nzibal[17]  +  agtprm_fil.gross. /* add by Phaiboon W. [A59-0125] 27/04/2016 */
            END.
        END.

    END.
END.
ELSE DO:
    IF YEAR(agtprm_fil.asdat) - YEAR(agtprm_fil.trndat) = 1 THEN DO:

       ASSIGN   
             nv_col             =  (nv_gap + nv_num)  +  MONTH(agtprm_fil.asdat).
       IF nv_col = 0 THEN nv_col = 18. /*กรณีที่เดือน=0 แสดงว่าน้อยกว่า 1 เดือน*/

       ASSIGN
             nv_dfield[nv_col]  =  nv_prem
             nv_total[nv_col]   =  nv_total[nv_col]   +  nv_prem
             nv_gtotal[nv_col]  =  nv_gtotal[nv_col]  +  nv_prem
             nv_sprem[nv_col]   =  nv_sprem[nv_col]   +  nv_prem
            /*---A50-0218---*/
             nv_svat[nv_col]   =  nv_svat[nv_col]   +  nv_vat
             nv_stax[nv_col]   =  nv_stax[nv_col]   +  nv_tax
            /*--------*/
             nv_scomm[nv_col]   =  nv_scomm[nv_col]   +  agtprm_fil.comm
             nv_sbal[nv_col]    =  nv_sbal[nv_col]    +  agtprm_fil.bal 
             nv_sbal1[nv_col]   =  nv_sbal1[nv_col]   +  agtprm_fil.gross /*Lukkana M. A52-0241 19/10/2009*/
             nv_sgprem[nv_col]  =  nv_sgprem[nv_col]  +  nv_prem
             nv_sgcomm[nv_col]  =  nv_sgcomm[nv_col]  +  agtprm_fil.comm
             nv_sgbal[nv_col]   =  nv_sgbal[nv_col]   +  agtprm_fil.bal
             nv_nzibal[nv_col]  =  nv_nzibal[nv_col]  +  agtprm_fil.gross. /* add by Phaiboon W. [A59-0125] 27/04/2016 */
         /*--- lek ---
         CASE agtprm_fil.acno_clicod:
             WHEN "RA" THEN nv_racode[nv_col] = nv_racode[nv_col] + agtprm_fil.prem .
             WHEN "RB" THEN nv_rbcode[nv_col] = nv_rbcode[nv_col] + agtprm_fil.prem .
             WHEN "RD" THEN nv_rdcode[nv_col] = nv_rdcode[nv_col] + agtprm_fil.prem .
             WHEN "RF" THEN nv_rfcode[nv_col] = nv_rfcode[nv_col] + agtprm_fil.prem .
         END CASE.
         --- end lek ---*/
    END.
    ELSE DO:     /* over 12 month */
         RUN pdoveryear . /*-- Lukkana M. A52-0241 28/09/2009 --*/
         /*--- Lukkana M. A52-0241 28/09/2009
         ASSIGN
             nv_dfield[13]  =  nv_prem
             nv_total[13]   =  nv_total[13]   +  nv_prem
             nv_gtotal[13]  =  nv_gtotal[13]  +  nv_prem
             nv_sprem[13]   =  nv_sprem[13]   +  nv_prem
             /*---A50218---*/
             nv_svat[13]   =  nv_svat[13]   +  nv_vat
             nv_stax[13]   =  nv_stax[13]   +  nv_tax
             /*------------*/
             nv_scomm[13]   =  nv_scomm[13]   +  agtprm_fil.comm
             nv_sbal[13]    =  nv_sbal[13]    +  agtprm_fil.bal
             nv_sgprem[13]  =  nv_sgprem[13]  +  nv_prem
             nv_sgcomm[13]  =  nv_sgcomm[13]  +  agtprm_fil.comm
             nv_sgbal[13]   =  nv_sgbal[13]   +  agtprm_fil.bal.
         Lukkana M. A52-0241 28/09/2009    ------*/
    END.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdRunRB wacr2001 
PROCEDURE pdRunRB :
/*------------------------------------------------------------------------------
  Purpose:   Add by A50-0218  
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
 RUN aderb\_printrb(report-library, 
                           report-name,
                           RB-DB-CONNECTION,
                           RB-INCLUDE-RECORDS,
                           RB-FILTER,
                           RB-MEMO-FILE,
                           RB-PRINT-DESTINATION,
                           RB-PRINTER-NAME,
                           RB-PRINTER-PORT,
                           RB-OUTPUT-FILE,
                           RB-NUMBER-COPIES,
                           RB-BEGIN-PAGE,
                           RB-END-PAGE,
                           RB-TEST-PATTERN,
                           RB-WINDOW-TITLE,
                           RB-DISPLAY-ERRORS,
                           RB-DISPLAY-STATUS,
                           RB-NO-WAIT,
                           RB-OTHER-PARAMETERS).
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdRunwacr wacr2001 
PROCEDURE pdRunwacr :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*-- Lukkana M. A52-0241 30/09/2009 --*/
IF nv_num > 0 THEN {Wac/Wacr2002.i}
ELSE {Wac/Wacr2003.i}
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdTitleAvi wacr2001 
PROCEDURE pdTitleAvi :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* Line 1 */
EXPORT DELIMITER ";"
    "From : " + n_frac + " To " + n_toac
     nv_blankH[1 FOR 8] 
    "SAFETY INSURANCE PUBLIC COMPANY LIMITED"
     nv_blankH[1 FOR 8]
    "Run Date : " + STRING(TODAY,"99/99/9999") + "  " + "Run Time : " + STRING(TIME,"HH:MM:SS").

/* Line 2 */
EXPORT DELIMITER ";"
    "Branch : " + n_Branch + " To " + n_Branch2
     nv_blankH[1 FOR 8]
    "Aging Report " + nv_repdes + " By " + nv_RptName + "   " + "[Detail]"
     nv_blankH[1 FOR 8]
    "Include Type : " + nv_trntyp1.

/* Line 3*/
EXPORT DELIMITER ";"
    "Tran. Date : " + STRING(n_trndatfr,"99/99/9999") + " To " + STRING(n_trndatto,"99/99/9999")
     nv_blankH[1 FOR 8]
    "As Of  Date : " + STRING(nv_asdatAging,"99/99/9999")
     nv_blankH[1 FOR 8]
    "Program Name : wacr2001.w".

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdTitleDet wacr2001 
PROCEDURE pdTitleDet :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*nv_blankH = FILL(" " , 15).*/
/********************** Page Header *********************/
/* ส่วนหัวเอกสาร ลง file : Detail */

/* line 1*/
EXPORT DELIMITER ";"
    "From : " + n_frac + " To " + n_toac
    nv_blankH[1 FOR 12]       /* ใส่ ช่องว่าง  14 ช่อง*/
    "SAFETY INSURANCE PUBLIC COMPANY LIMITED"
    nv_blankH[1 FOR 12]
    "Run Date : " + STRING(TODAY,"99/99/9999") + "  " + "Run Time : " + STRING(TIME,"HH:MM:SS").

/* line 2*/
EXPORT DELIMITER ";"
    "Branch : " + n_Branch + " To " + n_Branch2
     nv_blankH[1 FOR 12]
    "Aging Report " + nv_repdes + " By " + nv_RptName + "   " + "[Detail]"       /* nv_RptName2 */
     nv_blankH[1 FOR 12]
    "Include Type : " + nv_trntyp1.

/* line 3*/
EXPORT DELIMITER ";"
    "Tran. Date : " + STRING(n_trndatfr,"99/99/9999") + " To " + STRING(n_trndatto,"99/99/9999")
     nv_blankH[1 FOR 12]
    "As Of  Date : " + STRING(nv_asdatAging,"99/99/9999")
     nv_blankH[1 FOR 12]
    "Program Name : wacr2001.w".

IF nv_reptyp = "08"  THEN DO:
EXPORT DELIMITER ";"
    "Type of Report : " nv_ostyp. 
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdTitleNet wacr2001 
PROCEDURE pdTitleNet :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:   A50-0218    
------------------------------------------------------------------------------*/

/*nv_blankH = FILL(" " , 15).*/

/********************** Page Header *********************/
/* ส่วนหัวเอกสาร ลง file : Detail */

    /* line 1*/
EXPORT DELIMITER ";"
    "As Of  Date : " + STRING(nv_asdatAging,"99/99/9999").
EXPORT DELIMITER ";" "".
    

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdTitleNzi wacr2001 
PROCEDURE pdTitleNzi :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/********************** Page Header *********************/
/* ส่วนหัวเอกสาร ลง file : Detail */

    /* line 1*/
EXPORT DELIMITER ";"
    "As Of  Date : " + STRING(nv_asdatAging,"99/99/9999").
EXPORT DELIMITER ";" "".

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdTitleSum wacr2001 
PROCEDURE pdTitleSum :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

/*nv_blankH = FILL(" " , 15).*/

/********************** Page Header *********************/
/* ส่วนหัวเอกสาร ลง file : Detail */

    /* line 1*/
EXPORT DELIMITER ";"
    "From : " + n_frac + " To " + n_toac
    nv_blankH[1 FOR 6]       /* ใส่ ช่องว่าง  5 ช่อง*/
    "SAFETY INSURANCE PUBLIC COMPANY LIMITED"
    nv_blankH[1 FOR 7]
    "Run Date : " + STRING(TODAY,"99/99/9999") + "  " + "Run Time : " + STRING(TIME,"HH:MM:SS").

    /* line 2*/
EXPORT DELIMITER ";"
    "Branch : " + n_Branch + " To " + n_Branch2
     nv_blankH[1 FOR 6]
    "Aging Report " + nv_repdes + " By " + nv_RptName + "   " + "[Summary]"      /* nv_RptName2 */
     nv_blankH[1 FOR 7]
    "Include Type : " + nv_trntyp1.

    /* line 3*/
EXPORT DELIMITER ";"
    "Tran. Date : " + STRING(n_trndatfr,"99/99/9999") + " To " + STRING(n_trndatto,"99/99/9999")
     nv_blankH[1 FOR 6]
    "As Of  Date : " + STRING(nv_asdatAging,"99/99/9999")
     nv_blankH[1 FOR 7]
    "Program Name : wacr2001.w".

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdUpdateQ wacr2001 
PROCEDURE pdUpdateQ :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

OPEN QUERY brAcproc_fil
    FOR EACH Acproc_fil WHERE
            (Acproc_fil.TYPE = "07"  OR
             Acproc_fil.TYPE = "08") AND
      SUBSTR(AcProc_fil.enttim,10,3) <>  "NO"
    BY acproc_fil.asdat DESC.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE ProcGetPrtList wacr2001 
PROCEDURE ProcGetPrtList :
/*------------------------------------------------------------------------------
  Purpose:     Add by A50-0218
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
  def var printer-list  as character no-undo.
  def var port-list     as character no-undo.
  def var printer-count as integer no-undo.
  def var printer       as character no-undo format "x(32)".
  def var port          as character no-undo format "x(20)".

  run aderb/_prlist.p (output printer-list, output port-list,
                 output printer-count).

  ASSIGN
    cbPrtList:List-Items IN FRAME frOutput = printer-list
    cbPrtList = ENTRY (1, printer-list).
    
  DISP cbPrtList WITH FRAME frOutput.
  RB-PRINTER-NAME = cbPrtList:SCREEN-VALUE.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE ProcRBInward wacr2001 
PROCEDURE ProcRBInward :
/*------------------------------------------------------------------------------
  Purpose:      For Statement Inward FAC Report  A50-0218
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*----Lukkana M. A52-0241 30/10/2009----*/
/*--เช็คว่าถ้า Connect formtmp แสดงว่า run Program ที่สาขา ให้ออก Report ที่ formtmp ----*/
    IF CONNECTED ("formtmp") THEN DO:   /*-----Branch---*/
        FIND FIRST dbtable WHERE dbtable.phyname = "form"
                            NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL dbtable THEN DO:
           RB-DB-CONNECTION = dbtable.unixpara +  " -U ? -P  ? ".
        END.
        ELSE MESSAGE "Can't connect formtmp" VIEW-AS ALERT-BOX.
    END.   /*------ IF CONNECTED ("formtmp") -------*/
    /*-- ถ้าไม่ได้ Connect formtmp แสดงว่าRun program ที่สำนักงานใหญ่ ให้ออก Report ที่ sicfn --*/
    ELSE DO:       /*---HO---*/
        FIND FIRST dbtable WHERE dbtable.phyname = "sicfn"
                              NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL dbtable THEN DO:
            RB-DB-CONNECTION = dbtable.unixpara +  " -U " + n_User + " -P " + n_Passwd. /*--A49-0139--*/
        END.
        ELSE MESSAGE "Can't connect sicfn" VIEW-AS ALERT-BOX.      
    END.
/*----Lukkana M. A52-0241 30/10/2009----*/

/*-- Lukkana M. A52-0241 30/10/2009
/* kan connect sicfn ---*/

      FIND FIRST dbtable WHERE dbtable.phyname = "form"  OR dbtable.phyname = "sicfn"
                                            NO-LOCK NO-ERROR NO-WAIT.
      IF AVAIL dbtable THEN DO:
          IF dbtable.phyname = "form" THEN DO:
                 ASSIGN
                     nv_User  = "?"
                     nv_pwd = "?".
                     RB-DB-CONNECTION  = dbtable.unixpara +  " -U " + nv_user + " -P " + nv_pwd.
          END.
          ELSE DO:
                     RB-DB-CONNECTION  = dbtable.unixpara.
          END.
      END.
/*---kan*/
Lukkana M. A52-0241 30/10/2009 ---*/

    IF n_asdat = ?   THEN DO:
            MESSAGE "ไม่พบข้อมูล  กรุณาตรวจสอบการ Process ข้อมูล" VIEW-AS ALERT-BOX WARNING.
    END.
    ELSE DO:
        MESSAGE "สาขา                      : "  n_Branch " ถึง " n_Branch2 SKIP(1)
                            "ตัวแทน/นายหน้า  : "  n_frac " ถึง " n_toac  SKIP(1)
                            "ข้อมูลวันที่             : " STRING(n_asdat,"99/99/9999") SKIP(1)
                            "Include Type       : " nv_trntyp1 SKIP(1)
                            "พิมพ์รายงาน        : Statement Inward FAC"  VIEW-AS ALERT-BOX QUESTION
        BUTTONS YES-NO
        TITLE "Confirm"    UPDATE CHOICE AS LOGICAL.
        CASE CHOICE:
        WHEN TRUE THEN    DO:
            ASSIGN
                    nv_User   =   n_user
                    nv_pwd    =   n_passwd

                    /*report-name     =   "Statement Inward FAC" Lukkana M. A52-0241 26/10/2009*/
                    report-name     =   "Statement Inward FAC1" /*Lukkana M. A52-0241 26/10/2009*/
                    report-library  =   "wac/wprl/wac_sm01A.prl"

                    vFirstTime =  STRING(TIME, "HH:MM AM").
           
            /******************/
            IF rsOutput = 1 OR  rsOutput = 2 THEN DO:     /* report builder */
            
                    IF rsOutput = 1 OR  rsOutput = 2 OR  rsOutput = 3 THEN DO:
                       
                        RB-FILTER    = 'agtprm_fil.asdat = ' + 
                                        STRING (MONTH (n_asdat)) + "/" + 
                                        STRING (DAY (n_asdat)) + "/" + 
                                        STRING (YEAR (n_asdat)) + " AND " + 
                                        "agtprm_fil.acno >= '" + n_frac + "'" + " AND " + 
                                        "agtprm_fil.acno <= '" + n_toac + "'" + " AND " +
                                        "agtprm_fil.polbran >= '" + n_branch + "'" + " AND " + 
                                        "agtprm_fil.polbran <= '" + n_branch2 + "'" + " AND " + 
                                        "(" + nv_filter1 + ")".   /*A51-0024*/
                            
                    END.
                    /*ELSE DO:  /* ALL*/
                        RB-FILTER    = 'agtprm_fil.asdat = ' + 
                                        STRING (MONTH (n_asdat)) + "/" + 
                                        STRING (DAY (n_asdat)) + "/" + 
                                        STRING (YEAR (n_asdat)) + 
                                        " AND " + 
                                        "agtprm_fil.acno >= '" + n_frac + "'" + " AND " + 
                                        "agtprm_fil.acno <= '" + n_toac + "'" +
                                        " AND " +
                                        "agtprm_fil.polbran >= '" + n_branch   + "'" + " AND " + 
                                        "agtprm_fil.polbran <= '" + n_branch2 + "'" +
                                        " AND ( " + nv_filter1 + " )".
                    END.
                    */
                    
                    ASSIGN
                        /* RB-DB-CONNECTION  = "-H alpha4 -S stat" +  " -U " + nv_user + " -P " + nv_pwd */
                         /*RB-DB-CONNECTION  = "-H brpy -S stattest" +  " -U " + nv_user + " -P " + nv_pwd */
                        
                        RB-INCLUDE-RECORDS = "O"
        
                        RB-PRINT-DESTINATION = SUBSTR ("D A", rsOutput, 1)
                        RB-PRINTER-NAME   = IF rsOutput = 2 THEN cbPrtList ELSE " "
                        RB-OUTPUT-FILE       = IF rsOutput = 3 THEN fiFile-Name ELSE " "
                        RB-NO-WAIT               = No
                        RB-OTHER-PARAMETERS =  "rb_n_trndatto  = " + STRING(n_trndatto,"99/99/9999") + CHR(10) + 
                                               "rb_pich   = " + nv_a4a_07 . /*ADD Saharat S. A62-0279*/
                                               
                   /*     RB-OTHER-PARAMETERS = "rb_taxdespr = " + nv_taxdespr +
                         "~nrb_grptyp = " + nv_grptyp   +
                         "~nrb_taxtyp = " + n_taxtyp    +
                         "~nrb_branch = " + n_branch    +
                         "~nrb_taxyr  = " + nv_taxyr    +
                         "~nrb_taxmntfr = " + nv_taxmntfr +
                         "~nrb_taxmntto = " + nv_taxmntto   .
                    */

                        RUN pdRunRB.
                        
                   
            END.
            
        END.
        WHEN FALSE THEN    DO:
                RETURN NO-APPLY.
        END.
        END CASE.
        
    END.   /* IF  asdat  <> ? */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE ProcRBOutward wacr2001 
PROCEDURE ProcRBOutward :
/*------------------------------------------------------------------------------
  Purpose:     For Statement Outward FAC  A50-0218
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*----Lukkana M. A52-0241 30/10/2009----*/
/*--เช็คว่าถ้า Connect formtmp แสดงว่า run Program ที่สาขา ให้ออก Report ที่ formtmp ----*/
    IF CONNECTED ("formtmp") THEN DO:   /*-----Branch---*/
        FIND FIRST dbtable WHERE dbtable.phyname = "form"
                            NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL dbtable THEN DO:
           RB-DB-CONNECTION = dbtable.unixpara +  " -U ? -P  ? ".
        END.
        ELSE MESSAGE "Can't connect formtmp" VIEW-AS ALERT-BOX.
    END.   /*------ IF CONNECTED ("formtmp") -------*/
    /*-- ถ้าไม่ได้ Connect formtmp แสดงว่าRun program ที่สำนักงานใหญ่ ให้ออก Report ที่ sicfn --*/
    ELSE DO:       /*---HO---*/
        FIND FIRST dbtable WHERE dbtable.phyname = "sicfn"
                              NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL dbtable THEN DO:
            RB-DB-CONNECTION = dbtable.unixpara +  " -U " + n_User + " -P " + n_Passwd. /*--A49-0139--*/
        END.
        ELSE MESSAGE "Can't connect sicfn" VIEW-AS ALERT-BOX.      
    END.
/*----Lukkana M. A52-0241 30/10/2009----*/


/*----Lukkana M. A52-0241 30/10/2009
/* kan connect sicfn ---*/
  FIND FIRST dbtable WHERE 
             dbtable.phyname = "form"  OR 
             dbtable.phyname = "sicfn" NO-LOCK NO-ERROR NO-WAIT.
  IF AVAIL dbtable THEN DO:
      IF dbtable.phyname = "form" THEN DO:
             ASSIGN
                 nv_User  = "?"
                 nv_pwd = "?".
                 RB-DB-CONNECTION  = dbtable.unixpara +  " -U " + nv_user + " -P " + nv_pwd.
      END.
      ELSE DO:
                 RB-DB-CONNECTION  = dbtable.unixpara.
      END.
  END.
/*---kan*/
Lukkana M. A52-0241 30/10/2009----*/

  IF n_asdat = ?   THEN DO:
     MESSAGE "ไม่พบข้อมูล  กรุณาตรวจสอบการ Process ข้อมูล" VIEW-AS ALERT-BOX WARNING.
  END.
  ELSE DO:
     MESSAGE "สาขา                      : "  n_Branch " ถึง " n_Branch2 SKIP(1)
             "ตัวแทน/นายหน้า  : "  n_frac " ถึง " n_toac  SKIP(1)
             "ข้อมูลวันที่             : " STRING(n_asdat,"99/99/9999") SKIP(1)
             "Include Type       : " nv_trntyp1 SKIP(1)
             "พิมพ์รายงาน        : Statement Outward FAC"  VIEW-AS ALERT-BOX QUESTION
     BUTTONS YES-NO
     TITLE "Confirm"    UPDATE CHOICE AS LOGICAL.
     CASE CHOICE:
        WHEN TRUE THEN    DO:
            ASSIGN
                nv_User   =   n_user
                nv_pwd    =   n_passwd
                /*report-name     =   "Statement Outward FAC"  Lukkana M. A52-0241 26/10/2009*/
                report-name     =   "Statement Outward FAC1" /*Lukkana M. A52-0241 26/10/2009*/
                report-library  =   "wac/wprl/wac_sm01A.prl"
                vFirstTime =  STRING(TIME, "HH:MM AM").
 
            /******************/            
            /*
            /*Aor*/
            K = 0.
            IF nv_ostyp = "ALL" THEN DO:
               ASSIGN 
                 nv_ostyp1 = "O/S < 0"
                 nv_ostyp2 = "O/S = 0"
                 nv_ostyp3 = "O/S > 0".               
               FOR EACH agtprm_fil WHERE
                        agtprm_fil.asdat    = n_asdat        AND 
                        agtprm_fil.polbran >=  n_branch      AND 
                        agtprm_fil.polbran <=  n_branch2     AND 
                        agtprm_fil.acno    >=  n_frac        AND 
                        agtprm_fil.acno    <=  n_toac        AND 
                       (agtprm_fil.poldes   = nv_ostyp1     OR 
                        agtprm_fil.poldes   = nv_ostyp2     OR 
                        agtprm_fil.poldes   = nv_ostyp3)    NO-LOCK.
                k = k + 1.

              END.
            END.
            ELSE DO:
              FOR EACH agtprm_fil WHERE
                       agtprm_fil.asdat    = n_asdat     AND
                       agtprm_fil.polbran >=  n_branch   AND
                       agtprm_fil.polbran <=  n_branch2  AND
                       agtprm_fil.acno    >=  n_frac     AND
                       agtprm_fil.acno    <=  n_toac     AND
                       agtprm_fil.poldes   = nv_ostyp    NO-LOCK.
                k = k + 1.
              END.
            END.

            IF K = 0  THEN DO:
                IF nv_ostyp = "ALL" THEN DO:
                    MESSAGE "ไม่พบข้อมูลตามเงื่อนไข : " SKIP
                            nv_ostyp1 " / " nv_ostyp2  " / " nv_ostyp3
                            ",กรุณาตรวจสอบข้อมูล ...!" VIEW-AS ALERT-BOX.
                    RETURN NO-APPLY.
                END.
                ELSE DO:
                    MESSAGE "ไม่พบข้อมูลตามเงื่อนไข : " nv_ostyp
                            ",กรุณาตรวจสอบข้อมูล ...!" VIEW-AS ALERT-BOX.
                    RETURN NO-APPLY.
                END.
            END.
            ELSE DO:
            /*aor*/
            */

            /*
             FOR EACH  agtprm_fil USE-INDEX by_acno WHERE
                              agtprm_fil.asdat        =  n_asdat        AND
                             (agtprm_fil.acno        >=  n_frac         AND
                              agtprm_fil.acno        <=  n_toac )       AND
                     ( SUBSTR(agtprm_fil.policy,3,2) >=  nv_poltypFr    AND
                       SUBSTR(agtprm_fil.policy,3,2) <=  nv_poltypTo)   AND
                             (agtprm_fil.polbran     >=  n_branch       AND 
                              agtprm_fil.polbran     <=  n_branch2)     AND
                      (LOOKUP(SUBSTR(agtprm_fil.trntyp,1,1) , nv_trntyp1) <> 0 )
                    NO-LOCK BREAK BY agtprm_fil.acno
                                  BY agtprm_fil.trndat
                                  BY SUBSTR(agtprm_fil.policy,3,2)
                                  BY agtprm_fil.policy
                                  BY agtprm_fil.endno.
*/


                IF rsOutput = 1 OR  rsOutput = 2 THEN DO:     /* report builder */               
                   IF nv_ostyp = "O/S > 0" OR 
                      nv_ostyp = "O/S = 0" THEN DO:
                      RB-FILTER    = 'agtprm_fil.asdat = ' + 
                                      STRING (MONTH (n_asdat)) + "/" + 
                                      STRING (DAY (n_asdat)) + "/" + 
                                      STRING (YEAR (n_asdat)) + " AND " + 
                                      "agtprm_fil.polbran >= '" + n_branch   + "'" + " AND " + 
                                      "agtprm_fil.polbran <= '" + n_branch2 + "'" + " AND " + 
                                      "agtprm_fil.acno    >= '" + n_frac    + "'" + " AND " +       
                                      "agtprm_fil.acno    <= '" + n_toac + "'" + " AND " + 
                                      "agtprm_fil.poldes  = '" + nv_ostyp + "'" + " AND " + 
                                      "(" + nv_filter1 + ")".
                   END.
                   ELSE IF nv_ostyp = "O/S <= 0" THEN DO:
                       ASSIGN nv_ostyp1 = "O/S < 0"
                              nv_ostyp2 = "O/S = 0".
                       RB-FILTER    = 'agtprm_fil.asdat = ' + 
                                       STRING (MONTH (n_asdat)) + "/" + 
                                       STRING (DAY (n_asdat)) + "/" + 
                                       STRING (YEAR (n_asdat)) + " AND " + 
                                       "agtprm_fil.polbran >= '" + n_branch   + "'" + " AND " + 
                                       "agtprm_fil.polbran <= '" + n_branch2 + "'" + " AND " + 
                                       "agtprm_fil.acno    >= '" + n_frac    + "'" + " AND " +       
                                       "agtprm_fil.acno    <= '" + n_toac + "'" + " AND " +  
                                       '(' + "agtprm_fil.poldes  = '" +  nv_ostyp1 + "'"   + " OR " +
                                       "agtprm_fil.poldes  = '" +  nv_ostyp2 + "'" + ')' + " AND " +  
                                        "(" + nv_filter1 + ")".
                   END. 
                   ELSE IF nv_ostyp = "All" THEN DO:
                       ASSIGN nv_ostyp1 = "O/S < 0"
                              nv_ostyp2 = "O/S = 0"
                              nv_ostyp3 = "O/S > 0".
                       RB-FILTER    = 'agtprm_fil.asdat = ' + 
                                       STRING (MONTH (n_asdat)) + "/" + 
                                       STRING (DAY (n_asdat)) + "/" + 
                                       STRING (YEAR (n_asdat)) + " AND " + 
                                       "agtprm_fil.polbran >= '" + n_branch   + "'" + " AND " + 
                                       "agtprm_fil.polbran <= '" + n_branch2 + "'" + " AND " + 
                                       "agtprm_fil.acno    >= '" + n_frac    + "'" + " AND " +       
                                       "agtprm_fil.acno    <= '" + n_toac + "'" + " AND " +                                        
                                       '(' + "agtprm_fil.poldes  = '" +  nv_ostyp1 + "'" + " OR " +
                                       "agtprm_fil.poldes  = '" +  nv_ostyp2 + "'" + " OR " +
                                       "agtprm_fil.poldes  = '" +  nv_ostyp3 + "'" + ')' +  " AND " + 
                                        "(" + nv_filter1 + ")".    
                   END. 
                   /*MESSAGE rb-filter.*/
                        ASSIGN
                            RB-INCLUDE-RECORDS = "O"
                            RB-PRINT-DESTINATION = SUBSTR ("D A", rsOutput, 1)
                            RB-PRINTER-NAME   = IF rsOutput = 2 THEN cbPrtList ELSE " "
                            RB-OUTPUT-FILE       = IF rsOutput = 3 THEN fiFile-Name ELSE " "
                            RB-NO-WAIT               = No
                            RB-OTHER-PARAMETERS =  "rb_n_trndatto  = " + STRING(n_trndatto,"99/99/9999") + CHR(10) +
                                                   "rb_pich   = " + nv_a4a_07 . /*ADD Saharat S. A62-0279*/
                        RUN pdRunRB.
                END. 
        END.
        WHEN FALSE THEN    DO:
                RETURN NO-APPLY.
        END.
        END CASE.
        
  END.   /* IF  asdat  <> ? */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE rbAcnodet07 wacr2001 
PROCEDURE rbAcnodet07 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

/*------------------------------------------------------------------------------
  Purpose: Aging Detail  By Acno  [Inward]
------------------------------------------------------------------------------*/

DEF VAR  nv_gap     AS INT INIT 0.
DEF VAR  nv_num     AS INT INIT 0.
DEF VAR  nv_col     AS INT INIT 0.
DEF VAR  nv_row     AS INT INIT 0.
DEF VAR  nv_prem    AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR  nv_dfield  AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 13.
DEF VAR  nv_sprem   AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 14.
DEF VAR  nv_scomm   AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 14.
DEF VAR  nv_sbal    AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 14.
DEF VAR  nv_total   AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 13.
DEF VAR  nv_tprem   AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR  nv_tcomm   AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR  nv_tbal    AS DECI FORMAT "->>,>>>,>>>,>>9.99".
    

    nv_gap = 12 - MONTH(fiasdatAging).

    FOR EACH  agtprm_fil USE-INDEX by_acno WHERE
              agtprm_fil.asdat        =  n_asdat        AND
             (agtprm_fil.acno        >=  n_frac         AND
              agtprm_fil.acno        <=  n_toac )       AND
     ( SUBSTR(agtprm_fil.policy,3,2) >=  nv_poltypFr    AND
       SUBSTR(agtprm_fil.policy,3,2) <=  nv_poltypTo)   AND
             (agtprm_fil.polbran     >=  n_branch       AND 
              agtprm_fil.polbran     <=  n_branch2)     AND
      (LOOKUP(SUBSTR(agtprm_fil.trntyp,1,1) , nv_trntyp1) <> 0 )
    NO-LOCK BREAK BY agtprm_fil.acno
                  BY agtprm_fil.trndat.     /* Trans. Date */

       DISP  /*agtprm_fil.acno --- A500178 ---*/
              agtprm_fil.acno FORMAT "X(10)"
              agtprm_fil.trndat     
              agtprm_fil.policy
              agtprm_fil.endno
              agtprm_fil.trntyp
              agtprm_fil.docno FORMAT "x(10)"  /* Benjaporn J. A60-0267 date 27/06/2017 */
        WITH COLOR BLACK/WHITE NO-LABEL FRAME frProcess VIEW-AS DIALOG-BOX
        TITLE  "  Processing...  ".

        n_asdat = IF nv_asdatAging = ? THEN n_asdat ELSE nv_asdatAging.

        /* Begin */
        /********************** Group Header *********************/
        IF FIRST-OF(agtprm_fil.acno)  THEN DO:
            nv_acname = "".
/*          nv_credit = 0 . */
            FIND xmm600 USE-INDEX xmm60001 WHERE
                 xmm600.acno = agtprm_fil.acno NO-LOCK NO-ERROR.
            IF AVAIL xmm600 THEN
               ASSIGN
                 nv_acname = TRIM(xmm600.ntitle) + " " + TRIM(xmm600.name) 
                 nv_relate = xmm600.agtreg.   /*A50-0218*/
            ELSE ASSIGN nv_acname = " " 
                        nv_relate = "".
/*                     nv_credit = 0 . */
 
            /*--- DISPLAY DETAIL ---*/
            IF (nv_DetSum = "Detail")  OR (nv_DetSum = "All") THEN DO:
                OUTPUT TO VALUE (STRING(n_OutputFile ) ) APPEND NO-ECHO.
                    EXPORT DELIMITER ";" " ".
                    EXPORT DELIMITER ";"
                        agtprm_fil.acno + " - " + nv_acname + "   <" +
                        agtprm_fil.acno_clicod  + ">" .

                OUTPUT CLOSE.

            END.  /*  (nv_DetSum = "Detail") OR (nv_DetSum = "All") */
            
            /*--- DISPLAY SUMMARY ---*/
            IF (nv_DetSum = "Summary") OR (nv_DetSum = "All") THEN DO:
/*                 nv_row = nv_row + 1. */

                OUTPUT TO VALUE (n_OutputFileSum) APPEND NO-ECHO.  /* SUMMARY */
                    EXPORT DELIMITER ";" " ".
                    EXPORT DELIMITER ";"
                        agtprm_fil.acno + " - " + nv_acname .

                OUTPUT CLOSE.
                
            END.  /* (nv_DetSum = "Summary")  OR (nv_DetSum = "All")  */

        END.  /* first-of(agtprm_fil.acno) */

        ASSIGN
            nv_num    =  0
            nv_prem   =  0
            nv_prem   =  agtprm_fil.prem + agtprm_fil.prem_comp +
                         agtprm_fil.tax  + agtprm_fil.stamp
            nv_num    =  MONTH(agtprm_fil.asdat) - MONTH(agtprm_fil.trndat) + 1 .

        IF nv_num > 0 THEN DO:
            IF YEAR(agtprm_fil.asdat) = YEAR(agtprm_fil.trndat) THEN DO:
               ASSIGN
                  nv_dfield[nv_num]  =  nv_prem
                  nv_total[nv_num]   =  nv_total[nv_num]   +  nv_prem
                  nv_gtotal[nv_num]  =  nv_gtotal[nv_num]  +  nv_prem
                  nv_sprem[nv_num]   =  nv_sprem[nv_num]   +  nv_prem
                  nv_scomm[nv_num]   =  nv_scomm[nv_num]   +  agtprm_fil.comm
                  nv_sbal[nv_num]    =  nv_sbal[nv_num]    +  agtprm_fil.bal
                  nv_sgprem[nv_num]  =  nv_sgprem[nv_num]  +  nv_prem
                  nv_sgcomm[nv_num]  =  nv_sgcomm[nv_num]  +  agtprm_fil.comm
                  nv_sgbal[nv_num]   =  nv_sgbal[nv_num]   +  agtprm_fil.bal.
                
            END.
            ELSE DO:           /* over 12 month */
                ASSIGN
                    nv_dfield[13]  =  nv_prem
                    nv_total[13]   =  nv_total[13]   +  nv_prem
                    nv_gtotal[13]  =  nv_gtotal[13]  +  nv_prem
                    nv_sprem[13]   =  nv_sprem[13]   +  nv_prem
                    nv_scomm[13]   =  nv_scomm[13]   +  agtprm_fil.comm
                    nv_sbal[13]    =  nv_sbal[13]    +  agtprm_fil.bal
                    nv_sgprem[13]  =  nv_sgprem[13]  +  nv_prem
                    nv_sgcomm[13]  =  nv_sgcomm[13]  +  agtprm_fil.comm
                    nv_sgbal[13]   =  nv_sgbal[13]   +  agtprm_fil.bal.
            END.
        END.
        ELSE DO:
            IF YEAR(agtprm_fil.asdat) - YEAR(agtprm_fil.trndat) = 1 THEN DO:
                ASSIGN
                    nv_col             =  (nv_gap + nv_num)  +  MONTH(agtprm_fil.asdat)
                    nv_dfield[nv_col]  =  nv_prem              
                    nv_total[nv_col]   =  nv_total[nv_col]   +  nv_prem
                    nv_gtotal[nv_col]  =  nv_gtotal[nv_col]  +  nv_prem
                    nv_sprem[nv_col]   =  nv_sprem[nv_col]   +  nv_prem
                    nv_scomm[nv_col]   =  nv_scomm[nv_col]   +  agtprm_fil.comm
                    nv_sbal[nv_col]    =  nv_sbal[nv_col]    +  agtprm_fil.bal
                    nv_sgprem[nv_col]  =  nv_sgprem[nv_col]  +  nv_prem
                    nv_sgcomm[nv_col]  =  nv_sgcomm[nv_col]  +  agtprm_fil.comm
                    nv_sgbal[nv_col]   =  nv_sgbal[nv_col]   +  agtprm_fil.bal.
                
            END.
            ELSE DO:                                              /* over 12 month */
                ASSIGN
                    nv_dfield[13]  =  nv_prem
                    nv_total[13]   =  nv_total[13]   +  nv_prem
                    nv_gtotal[13]  =  nv_gtotal[13]  +  nv_prem
                    nv_sprem[13]   =  nv_sprem[13]   +  nv_prem
                    nv_scomm[13]   =  nv_scomm[13]   +  agtprm_fil.comm
                    nv_sbal[13]    =  nv_sbal[13]    +  agtprm_fil.bal
                    nv_sgprem[13]  =  nv_sgprem[13]  +  nv_prem
                    nv_sgcomm[13]  =  nv_sgcomm[13]  +  agtprm_fil.comm
                    nv_sgbal[13]   =  nv_sgbal[13]   +  agtprm_fil.bal.
                     
            END.
        END.

        ASSIGN
            nv_tprem      = nv_tprem + nv_prem
            nv_tcomm      = nv_tcomm + agtprm_fil.comm
            nv_tbal       = nv_tbal  + agtprm_fil.bal
            nv_sprem[14]  = nv_sprem[14]  + nv_prem
            nv_scomm[14]  = nv_scomm[14]  + agtprm_fil.comm
            nv_sbal[14]   = nv_sbal[14]   + agtprm_fil.bal .

       
/*-------------------------
        /*--- DISPLAY DETAIL  ---*/
        IF (nv_DetSum = "Detail")  OR (nv_DetSum = "All") THEN DO:
            OUTPUT TO VALUE (STRING(n_OutputFile ) ) APPEND NO-ECHO.
                EXPORT DELIMITER ";"
                    agtprm_fil.acno
                    nv_acname
                    agtprm_fil.trndat
                    agtprm_fil.policy
                    agtprm_fil.endno
                    agtprm_fil.comdat
                    agtprm_fil.trntyp
                    "'" + agtprm_fil.docno
                    agtprm_fil.insure
                    agtprm_fil.prem
                    agtprm_fil.comm
                    agtprm_fil.bal
                    agtprm_fil.duedat
                    agtprm_fil.cedpol
                    nv_dfield[1]
                    nv_dfield[2]
                    nv_dfield[3]
                    nv_dfield[4]
                    nv_dfield[5]
                    nv_dfield[6]
                    nv_dfield[7]
                    nv_dfield[8]
                    nv_dfield[9]
                    nv_dfield[10]
                    nv_dfield[11]
                    nv_dfield[12]
                    nv_dfield[13].
            OUTPUT CLOSE.

        END.    /* (nv_DetSum = "Detail")  OR (nv_DetSum = "All") */
--------End Aom---------------*/
/*----------------------Aom
        IF LAST-OF(agtprm_fil.acno) THEN DO:

            /*--- DISPLAY DETAIL  ---*/
            IF (nv_DetSum = "Detail")  OR (nv_DetSum = "All") THEN DO:

                OUTPUT TO VALUE (STRING(n_OutputFile ) ) APPEND NO-ECHO.
                    EXPORT DELIMITER ";"
                        "Total : " + agtprm_fil.acno
                        nv_blankX[1 FOR 8]
                        nv_tprem
                        nv_tcomm
                        nv_tbal
                        nv_blankX[1 FOR 2]
                        nv_total[1]
                        nv_total[2]
                        nv_total[3]
                        nv_total[4]
                        nv_total[5]
                        nv_total[6]
                        nv_total[7]
                        nv_total[8]
                        nv_total[9]
                        nv_total[10]
                        nv_total[11]
                        nv_total[12]
                        nv_total[13].
           
                OUTPUT CLOSE.

                ASSIGN
                    nv_tprem = 0
                    nv_tcomm = 0
                    nv_tbal  = 0 
                    nv_total = 0 .

            END.    /* (nv_DetSum = "Detail")  OR (nv_DetSum = "All") */
            
            /*--- DISPLAY SUMMARY  ---*/
            IF (nv_DetSum = "Summary") OR (nv_DetSum = "All") THEN DO:

                OUTPUT TO VALUE (STRING(n_OutputFileSum) ) APPEND NO-ECHO.
                    EXPORT DELIMITER ";" "Premium"    nv_sprem[14]  nv_sprem[1 FOR 13].
                    EXPORT DELIMITER ";" "Commission" nv_scomm[14]  nv_scomm[1 FOR 13].
                    EXPORT DELIMITER ";" "Bal O/S"    nv_sbal[14]   nv_sbal[1 FOR 13]. 

                OUTPUT CLOSE.

                /*--- A50-0218 ---*/
                OUTPUT TO VALUE (STRING(n_OutputFileNet) ) APPEND NO-ECHO.
                    EXPORT DELIMITER ";" nv_relate  agtprm_fil.acno  nv_acname  nv_sbal[14]   nv_sbal[1 FOR 13]. 
                OUTPUT CLOSE.
                /*----------------*/

/*                 DO j = 1 TO 14: */
/*                     nv_racode[j] = nv_racode[j] + nv_sfield[j]. */
/*                     nv_rbcode[j] = nv_rbcode[j] + nv_sfield[j]. */
/*                     nv_rdcode[j] = nv_rdcode[j] + nv_sfield[j]. */
/*                     nv_rfcode[j] = nv_rfcode[j] + nv_sfield[j]. */
/*                 END. */

                ASSIGN
                    nv_sprem  = 0
                    nv_scomm  = 0
                    nv_sbal   = 0 .

            END.    /* (nv_DetSum = "Summary")  OR (nv_DetSum = "All") */
        END.   /* IF LAST-OF(agtprm_fil.acno) */

        nv_dfield = 0.

        ACCUMULATE 
            agtprm_fil.prem      (TOTAL)
            agtprm_fil.prem_comp (TOTAL)
            agtprm_fil.tax       (TOTAL)
            agtprm_fil.stamp     (TOTAL)
            agtprm_fil.comm      (TOTAL)
            agtprm_fil.bal       (TOTAL) .

        /********************** Page Footer *********************/
        /*** export ข้อมูลลง DETAIL FILE บรรทัด Grand Total  และ  
                             SUMMARY FILE บรรทัด Grand Total ***/
        IF LAST(agtprm_fil.acno) THEN DO:
            IF (nv_DetSum = "Detail")  OR (nv_DetSum = "All") THEN DO:
                OUTPUT TO VALUE (n_OutputFile ) APPEND NO-ECHO.
                ASSIGN
                    nv_gprem   = (ACCUM TOTAL agtprm_fil.prem) + 
                                 (ACCUM TOTAL agtprm_fil.prem_comp) +
                                 (ACCUM TOTAL agtprm_fil.tax) +
                                 (ACCUM TOTAL agtprm_fil.stamp)
                    nv_gcomm   = (ACCUM TOTAL agtprm_fil.comm)
                    nv_gbal    = (ACCUM TOTAL agtprm_fil.bal) . 

                RUN pdFooterDet.
                OUTPUT CLOSE.
            END.  /* (nv_DetSum = "Detail")  OR (nv_DetSum = "All") */

            IF (nv_DetSum = "Summary")  OR (nv_DetSum = "All") THEN DO:
                OUTPUT TO VALUE (n_OutputFileSum ) APPEND NO-ECHO.
                ASSIGN
                    nv_gprem   = (ACCUM TOTAL agtprm_fil.prem) +
                                 (ACCUM TOTAL agtprm_fil.prem_comp) +
                                 (ACCUM TOTAL agtprm_fil.tax) +
                                 (ACCUM TOTAL agtprm_fil.stamp)
                    nv_gcomm   = (ACCUM TOTAL agtprm_fil.comm)
                    nv_gbal    = (ACCUM TOTAL agtprm_fil.bal) .

                RUN pdFooterSum.
                OUTPUT CLOSE.

                /*---------A50-0218-----------*/
                OUTPUT TO VALUE (n_OutputFileNet ) APPEND NO-ECHO.
                ASSIGN
                    nv_gbal    = (ACCUM TOTAL agtprm_fil.bal) .
                RUN pdFooterNet.
                OUTPUT CLOSE.
                /*----------------------------*/

            END.  /* (nv_DetSum = "Summary")  OR (nv_DetSum = "All") */

            RUN pdInitDataG.    /* clear data */

        END. /* if last(agtprm_fil.acno) then */
-------End Aom------*/
    END. /* for each agtprm_fil*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

/* ************************  Function Implementations ***************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fuLeapYear wacr2001 
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fuMaxDay wacr2001 
FUNCTION fuMaxDay RETURNS INTEGER
  (INPUT vDate AS DATE ) :
/*------------------------------------------------------------------------------
  Purpose:  fuMaxDay
    Notes:  
------------------------------------------------------------------------------*/
DEF VAR tday        AS INT FORMAT "99".
DEF VAR tmon       AS INT FORMAT "99".
DEF VAR tyear      AS INT FORMAT "9999".
DEF VAR maxday AS INT FORMAT "99".
  
ASSIGN 
                tday = DAY(vDate)
               tmon = MONTH(vDate)
               tyear = YEAR(vDate).
               /*  ให้ค่าวันที่สูงสุดของเดือนแก่ตัวแปร*/
               maxday = DAY(     DATE(tmon,28,tyear) + 4  - DAY(DATE(tmon,28,tyear) + 4)    ).
               
               
  RETURN maxday .   /* Function return value.  MaxDay*/

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fuNumMonth wacr2001 
FUNCTION fuNumMonth RETURNS INTEGER
  (INPUT vMonth AS INT ,vDate AS DATE ) :
/*------------------------------------------------------------------------------
  Purpose:  fuNumMonth
    Notes:  
------------------------------------------------------------------------------*/
  DEF VAR vNum AS INT.
  ASSIGN  vNum = 0.
  
    IF vMonth = 1   OR  vMonth = 3    OR
        vMonth = 5   OR  vMonth = 7    OR
        vMonth = 8   OR  vMonth = 10   OR
        vMonth = 12 THEN DO:
        ASSIGN
            vNum = 31.       
        
   END.
   
    IF  vMonth = 4   OR  vMonth = 6    OR
         vMonth = 9   OR  vMonth = 11   THEN DO:
        ASSIGN
            vNum = 30.          
   
   END.     
   
   IF  vMonth = 2 THEN DO:
        IF fuLeapYear(YEAR(vDate)) = TRUE THEN vNum = 29. ELSE vNum = 28. 
   END.

  RETURN vNum .   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fuNumYear wacr2001 
FUNCTION fuNumYear RETURNS INTEGER
  (INPUT vDate AS DATE ) :
/*------------------------------------------------------------------------------
  Purpose:  fuNumYear
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

