&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          sicfn            PROGRESS
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

/************   Program   **************
/* CREATE BY :  Kanchana C.     A47-0406    13/10/2004  */
ปรับจากโปรแกรม wacr06.w ต่างกันแค่เงื่อนไขที่ดึงข้อมูลเท่านั้น

Wac
        -Wacr05.w            /*Aging Detail Report  */
        wacr0501.i
        wacr0502.i
        wacr0503.i

Whp
        -WhpBran.w
        -WhpAcno.w
        -WhpClico.w
Wut
        -WutDiCen.p
        -WutWiCen.p

รายละเอียด ดูจาก    wacr06.w 

- ระบุ trndat from-to ของข้อมูล

------------------------------------------------------------------------- 
 Modify By : TANTAWAN C.   09/11/2007   [A500178]
             ปรับ format branch เพื่อรองรับการขยายสาขา
             ยขยาย format fiacno1 จาก "X(7)" เป็น  Char "X(10)"
                          fiacno2 จาก "X(7)" เป็น  Char "X(10)"
-------------------------------------------------------------------------

*************************/


/*************************  Definitions  *************************/
DEF SHARED VAR n_User   AS CHAR.
DEF SHARED VAR n_Passwd AS CHAR.
DEF VAR nv_User  AS CHAR NO-UNDO.
DEF VAR nv_pwd   LIKE _password NO-UNDO.

/* Definitons  Report -------                                               */

/* Parameters Definitions ---                                           */
/*--- A500178 ---
DEF NEW SHARED VAR n_agent1   AS CHAR FORMAT "x(7)".
DEF NEW SHARED VAR n_agent2   AS CHAR FORMAT "x(7)".
------*/
DEF NEW SHARED VAR n_agent1   AS CHAR FORMAT "x(10)".
DEF NEW SHARED VAR n_agent2   AS CHAR FORMAT "x(10)".
DEF NEW SHARED VAR n_branch   AS CHAR FORMAT "x(2)".
DEF NEW SHARED VAR n_branch2  AS CHAR FORMAT "x(2)".
DEF NEW SHARED VAR n_tabcod   AS CHAR FORMAT "X(4)"  INIT "U021". /* Table-Code  sym100*/
DEF NEW SHARED VAR n_itmcod   AS CHAR FORMAT "X(4)".
DEF NEW SHARED VAR n_poltyp   AS CHAR FORMAT "X(4)". 

DEF            VAR n_name     AS CHAR FORMAT "x(50)". /*acno*/
DEF            VAR n_chkname  AS CHAR FORMAT "x(1)".  /* Acno-- chk button 1-2 */
DEF            VAR n_bdes     AS CHAR FORMAT "x(50)". /*branch name*/
DEF            VAR n_chkBname AS CHAR FORMAT "x(1)".  /* branch-- chk button 1-2 */
DEF            VAR n_itmdes   AS CHAR FORMAT "x(40)". /*Table-Code Description*/
DEF            VAR n_poldes   AS CHAR FORMAT "X(35)". /* policy des*/

/* Local Variable Definitions ---                                       */

DEF VAR n_asdat    AS DATE FORMAT "99/99/9999".
DEF VAR n_frbr     AS CHAR FORMAT "x(2)".
DEF VAR n_tobr     AS CHAR FORMAT "x(2)".
/*--- A500178 ---
DEF VAR n_frac  AS CHAR FORMAT "x(7)".
DEF VAR n_toac  AS CHAR FORMAT "x(7)".
------*/
DEF VAR n_frac     AS CHAR FORMAT "x(10)".
DEF VAR n_toac     AS CHAR FORMAT "x(10)".
DEF VAR n_typ      AS CHAR FORMAT "X".
DEF VAR n_typ1     AS CHAR FORMAT "X".
DEF VAR n_trndatfr AS DATE FORMAT "99/99/9999".
DEF VAR n_trndatto AS DATE FORMAT "99/99/9999".

DEF VAR n_OutputTo      AS INTEGER.
DEF VAR n_OutputFile    AS CHAR.  /* DETAIL file*/
DEF VAR n_OutputFileSum AS CHAR.  /* SUMMARY file*/

DEF VAR n_odat1 AS  DATE FORMAT "99/99/9999".
/***************************************/
/* TOTAL */
DEF VAR nv_tot_prem      AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_tot_prem_comp AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_tot_stamp     AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_tot_tax       AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_tot_gross     AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_tot_comm      AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_tot_comm_comp AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_tot_net       AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_tot_bal       AS DECI FORMAT ">>,>>>,>>>,>>9.99-".

/*A47-0076---*/
DEF VAR nv_tot_retc   AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_tot_susp   AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_tot_netar  AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_tot_netoth AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
/*---A47-0076*/

DEF VAR nv_tot_wcr    AS  DECI FORMAT ">>,>>>,>>>,>>9.99-".  /*with in credit*/
DEF VAR nv_tot_damt   AS  DECI FORMAT ">>,>>>,>>>,>>9.99-".  /*due amount */
DEF VAR nv_tot_odue   AS  DECI FORMAT ">>,>>>,>>>,>>9.99-".  /*overdue*/
DEF VAR nv_tot_odue1  AS  DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_tot_odue2  AS  DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_tot_odue3  AS  DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_tot_odue4  AS  DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_tot_odue5  AS  DECI FORMAT ">>,>>>,>>>,>>9.99-".
/* GRAND TOTAL */
DEF VAR nv_gtot_prem      AS DECI  FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_gtot_prem_comp AS DECI  FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_gtot_stamp     AS DECI  FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_gtot_tax       AS DECI  FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_gtot_gross     AS DECI  FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_gtot_comm      AS DECI  FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_gtot_comm_comp AS DECI  FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_gtot_net       AS DECI  FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_gtot_bal       AS DECI  FORMAT ">>,>>>,>>>,>>9.99-".
/*A47-0076---*/
DEF  VAR nv_gtot_retc   AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_gtot_susp   AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_gtot_netar  AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_gtot_netoth AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
/*---A47-0076*/

DEF  VAR nv_gtot_wcr    AS DECI FORMAT ">>,>>>,>>>,>>9.99-". /*with in credit*/
DEF  VAR nv_gtot_damt   AS DECI FORMAT ">>,>>>,>>>,>>9.99-". /*due amount */
DEF  VAR nv_gtot_odue   AS DECI FORMAT ">>,>>>,>>>,>>9.99-".  /*overdue*/
DEF  VAR nv_gtot_odue1  AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_gtot_odue2  AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_gtot_odue3  AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_gtot_odue4  AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_gtot_odue5  AS DECI FORMAT ">>,>>>,>>>,>>9.99-".

DEF VAR nv_ProcessDate AS DATE FORMAT "99/99/9999".
DEF VAR nv_asdatAging  AS DATE FORMAT "99/99/9999".

/*---------------------- A46-0142 -------------------*/
/*** เพิ่มช่องที่ระบุ type ***/
DEF VAR nv_Trntyp1  AS CHAR INIT "M,R,A,B,C,Y,Z,O,T".

DEF VAR nv_typ1  AS CHAR.
DEF VAR nv_typ2  AS CHAR.
DEF VAR nv_typ3  AS CHAR.
DEF VAR nv_typ4  AS CHAR.
DEF VAR nv_typ5  AS CHAR.
DEF VAR nv_typ6  AS CHAR.
DEF VAR nv_typ7  AS CHAR.
DEF VAR nv_typ8  AS CHAR.
DEF VAR nv_typ9  AS CHAR.
DEF VAR nv_typ10  AS CHAR.
DEF VAR nv_typ11  AS CHAR.
DEF VAR nv_typ12  AS CHAR.
DEF VAR nv_typ13  AS CHAR.
DEF VAR nv_typ14  AS CHAR.
DEF VAR nv_typ15  AS CHAR.

/*** แยก Report ***/
DEF VAR nv_RptTyp    AS CHAR .
DEF VAR nv_RptName   AS CHAR.
DEF VAR nv_RptName2  AS CHAR.

DEF VAR nv_poltypFr AS CHAR.
DEF VAR nv_poltypTo AS CHAR.

/*** คำนวนวัน ***/
DEF VAR n_due AS DATE FORMAT "99/99/9999".
DEF VAR n_day AS INTE FORMAT ">>>>9".

DEF VAR i    AS INTE INIT 0.
DEF VAR lip  AS INTE INIT 0.  /* Period */

DEF VAR ntax% AS DECI FORMAT "->>9.99" INIT 0.

DEF VAR nv_YZ       AS CHAR INIT "YS,ZS". /* ดึงยอด bal อย่างเดียว */
DEF VAR nv_CB       AS CHAR INIT "C,B".
DEF VAR nv_MR       AS CHAR INIT "M,R".
/***---  (within, due date) = current ,1 m = เกินกำหนดมา 1 เดือน, ... , 12, 12 เดือนขึ้นไป รวม 15 ช่อง แต่หาเกินไปเป็น  16  ---***/
DEF VAR n_odmonth   AS INT EXTENT 16.   /*month  not over  12   เดือนที่ (เดือน มค. = 01 มี 31 วัน )  เพื่อนำไปหาจำนวนวันในแต่ละเดือน */
DEF VAR n_odDay     AS INT EXTENT 16.   /*count num day in over due จำนวนวัน ที่เกิน ระยะเวลาให้ credit 0 ถึง +12  เดือน */
DEF VAR n_odat      AS DATE FORMAT "99/99/9999" EXTENT 16. /* วันที่ ที่เกินจากระยะเวลาให้ credit  เกินไป 0 ถึง +12  เดือน*/
DEF VAR n_odatInday AS DATE FORMAT "99/99/9999".

DEF VAR nv_balDet      AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 15.
DEF VAR nv_tot_balDet  AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 15.
DEF VAR nv_gtot_balDet AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 15.

/***------------ ตัวแปรที่รับค่า  แล้วนำไป Export file Detail --------------***/
DEF VAR nv_premCB  AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_commCB  AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_totalCB AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_net     AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_premA   AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_taxA    AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_vatA    AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_sbtA    AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_stampA  AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_totalA  AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_commA   AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_netA    AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_retcA   AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_suspA   AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_balA    AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_netarA  AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_netothA AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
/***--------------------- "Summary of : " -------------------***/
/* ช่อง 1 - 15  column 2 - 16 */
DEF VAR nv_Tprem    AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 15.
DEF VAR nv_Ttax     AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 15.
DEF VAR nv_Tvat     AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 15.
DEF VAR nv_Tsbt     AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 15.
DEF VAR nv_Tstamp   AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 15.
DEF VAR nv_Ttotal   AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 15.
DEF VAR nv_Tcomm    AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 15.
DEF VAR nv_Tnet     AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 15.
DEF VAR nv_Tretc    AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 15.
DEF VAR nv_Tsusp    AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 15.
DEF VAR nv_Tbal     AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 15.
DEF VAR nv_Tnetar   AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 15.
DEF VAR nv_Tnetoth  AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 15.

/*ผลรวม 15 ช่อง  column 1 */
DEF VAR nv_TTprem   AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nv_TTtax    AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nv_TTvat    AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nv_TTsbt    AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nv_TTstamp  AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nv_TTtotal  AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nv_TTcomm   AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nv_TTnet    AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nv_TTretc   AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nv_TTsusp   AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nv_TTbal    AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nv_TTnetar  AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nv_TTnetoth AS DECI FORMAT "->>,>>>,>>>,>>9.99".

/***------------------- "G R A N D  T O T A L" -----------------***/
/* ช่อง 1 - 15 column 2 -16 */
DEF VAR nv_GTprem   AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 15.
DEF VAR nv_GTtax    AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 15.
DEF VAR nv_GTvat    AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 15.
DEF VAR nv_GTsbt    AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 15.
DEF VAR nv_GTstamp  AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 15.
DEF VAR nv_GTtotal  AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 15.
DEF VAR nv_GTcomm   AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 15.
DEF VAR nv_GTnet    AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 15.
DEF VAR nv_GTretc   AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 15.
DEF VAR nv_GTsusp   AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 15.
DEF VAR nv_GTbal    AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 15.
DEF VAR nv_GTnetar  AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 15.
DEF VAR nv_GTnetoth AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 15.

/*ผลรวม 15 ช่อง column 1 */
DEF VAR nv_GTTprem    AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nv_GTTtax     AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nv_GTTvat     AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nv_GTTsbt     AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nv_GTTstamp   AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nv_GTTtotal   AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nv_GTTcomm    AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nv_GTTnet     AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nv_GTTretc    AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nv_GTTsusp    AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nv_GTTbal     AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nv_GTTnetar   AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nv_GTTnetoth  AS DECI FORMAT "->>,>>>,>>>,>>9.99".
/***--------------------------------------------------------***/

DEF VAR nv_blankH AS CHAR INIT " " EXTENT 20.
DEF VAR nv-1    AS CHAR.
DEF VAR nv-2    AS CHAR.
DEF VAR nv-3    AS CHAR.
DEF VAR nv_bdes AS CHAR.
DEF VAR nv_Linedes AS CHAR.
DEF VAR nv_acname  AS CHAR.

/* SUB TOTAL */
DEF VAR nv_sub_prem      AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_sub_prem_comp AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_sub_stamp     AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_sub_tax       AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_sub_gross     AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_sub_comm      AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_sub_comm_comp AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_sub_net       AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_sub_bal       AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_sub_baldet    AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 15.

DEF VAR nv_sub_retc   AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nv_sub_susp   AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nv_sub_netar  AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_sub_netoth AS DECI FORMAT ">>,>>>,>>>,>>9.99-".

/*------ group table for grpcode in acno  ---*/
DEF  TEMP-TABLE  wtGrpCode          /* workfile รายชื่อ group code ของแต่ละตัวแทน  ชื่อไฟล์ + "G" */
    FIELD wtgpage   AS CHAR FORMAT "X(10)" /*--- A500178 --- เพิ่ม format "X(10)"--*/
    FIELD wtgpName  AS CHAR
    FIELD wtacno    AS CHAR FORMAT "X(10)" /*--- A500178 --- เพิ่ม format "X(10)"--*/
    FIELD wtname    AS CHAR
INDEX  wtGrpCode1 IS UNIQUE PRIMARY wtgpage wtacno  ASCENDING
INDEX  wtGrpCode2  wtacno.

DEF  TEMP-TABLE wtGrpSum          /* workfile สำหรับ ไฟล์ group code  ชื่อไฟล์ + "Gp" */
    FIELD wtGTrptname   AS CHAR
    FIELD wtGTgpcode    AS CHAR FORMAT "X(10)" /*--- A500178 --- เพิ่ม format "X(10)"--*/
    FIELD wtGTgpname    AS CHAR
    FIELD wtGTacno      AS CHAR FORMAT "X(10)" /*--- A500178 --- เพิ่ม format "X(10)"--*/
    FIELD wtGTacname    AS CHAR
    FIELD wtGTprem      AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 15
    FIELD wtGTtax       AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 15
    FIELD wtGTvat       AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 15
    FIELD wtGTsbt       AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 15
    FIELD wtGTstamp     AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 15
    FIELD wtGTtotal     AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 15
    FIELD wtGTcomm      AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 15
    FIELD wtGTnet       AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 15
    FIELD wtGTretc      AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 15
    FIELD wtGTsusp      AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 15
    FIELD wtGTnetar     AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 15
    FIELD wtGTbal       AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 15
    FIELD wtGTnetoth    AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 15
/**/
    FIELD wtGTTprem     AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wtGTTtax      AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wtGTTvat      AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wtGTTsbt      AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wtGTTstamp    AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wtGTTtotal    AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wtGTTcomm     AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wtGTTnet      AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wtGTTretc     AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wtGTTsusp     AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wtGTTnetar    AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wtGTTbal      AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wtGTTnetoth   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
INDEX wtGrpSum1 IS UNIQUE PRIMARY  wtGTacno
INDEX wtGrpSum2  wtGTgpcode.

/* ตัวแปร display ใน report summary */
DEF VAR nv_RptTyp1 AS CHAR INIT "".
DEF VAR nv_RptTyp2 AS CHAR INIT "".

DEF VAR n_trnty1  AS CHAR  FORMAT "X" .
DEF VAR n_trnty2  AS CHAR  FORMAT "X" .
DEF VAR nv_prm    LIKE ACM001.PREM.  /* Net Premium */
DEF VAR nv_com    LIKE ACM001.PREM.
DEF VAR nv_sup    LIKE ACM001.PREM.
DEF VAR nv_pprm   LIKE Acm001.Prem.  /* Prem Amount before TAX, STAMP */
DEF VAR nv_stamp  LIKE Acm001.Stamp. 
DEF VAR nv_tax    LIKE Acm001.TAX.   /* < 4% of Prem is SBT Else Vat */
DEF VAR nv_netamt LIKE ACM001.PREM.
DEF VAR nv_sumsup LIKE ACM001.PREM.
DEF VAR nv_sumprm LIKE ACM001.PREM.
DEF VAR nv_sumcom LIKE ACM001.PREM.
DEF VAR nv_spcp   LIKE ACM001.PREM.

DEF VAR nv_DetSum AS CHAR .
DEF VAR n_processdate  AS DATE.

/* A47-0264 */
DEF VAR nv_reccnt AS INT.
DEF VAR nv_next   AS INT.

/* A47-0406 */
DEF VAR n_trndatfrOld AS DATE FORMAT "99/99/9999".
DEF VAR n_trndattoOld AS DATE FORMAT "99/99/9999".

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define BROWSE-NAME brAcproc_fil

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES acproc_fil

/* Definitions for BROWSE brAcproc_fil                                  */
&Scoped-define FIELDS-IN-QUERY-brAcproc_fil acproc_fil.asdat ~
acproc_fil.type IF (acproc_fil.type = "01") THEN ("Monthly") ELSE ("Daily") ~
acproc_fil.entdat acproc_fil.enttim SUBSTRING (acproc_fil.enttim,10,3) ~
acproc_fil.trndatfr acproc_fil.trndatto acproc_fil.typdesc 
&Scoped-define ENABLED-FIELDS-IN-QUERY-brAcproc_fil 
&Scoped-define QUERY-STRING-brAcproc_fil FOR EACH acproc_fil NO-LOCK
&Scoped-define OPEN-QUERY-brAcproc_fil OPEN QUERY brAcproc_fil FOR EACH acproc_fil NO-LOCK.
&Scoped-define TABLES-IN-QUERY-brAcproc_fil acproc_fil
&Scoped-define FIRST-TABLE-IN-QUERY-brAcproc_fil acproc_fil


/* Definitions for FRAME frST                                           */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS IMAGE-21 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME


/* ************************  Function Prototypes ********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fuLeapYear C-Win 
FUNCTION fuLeapYear RETURNS LOGICAL
  ( /* parameter-definitions */ y AS int)  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fuMaxDay C-Win 
FUNCTION fuMaxDay RETURNS INTEGER
  (INPUT vDate AS DATE )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fuNumMonth C-Win 
FUNCTION fuNumMonth RETURNS INTEGER
  (INPUT vMonth AS INT ,vDate AS DATE )  FORWARD.

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
DEFINE IMAGE IMAGE-21
     FILENAME "wimage/bgc01.bmp":U CONVERT-3D-COLORS
     SIZE 132.5 BY 24.

DEFINE IMAGE IMAGE-22
     FILENAME "wimage/bgc01.bmp":U CONVERT-3D-COLORS
     SIZE 126 BY 23.76.

DEFINE BUTTON Btn_Cancel AUTO-END-KEY 
     LABEL "Cancel" 
     SIZE 13 BY 1.76
     BGCOLOR 8 FONT 6.

DEFINE BUTTON Btn_OK AUTO-GO 
     LABEL "OK" 
     SIZE 13 BY 1.76
     BGCOLOR 8 FONT 6.

DEFINE RECTANGLE RECT2
     EDGE-PIXELS 3 GRAPHIC-EDGE  
     SIZE 18.5 BY 4.71
     BGCOLOR 19 .

DEFINE VARIABLE fiFile-Name AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 21.5 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE rsOutput AS INTEGER 
     VIEW-AS RADIO-SET VERTICAL
     RADIO-BUTTONS 
          "Item 1", 1
     SIZE 12.5 BY 1
     BGCOLOR 19 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-5
     EDGE-PIXELS 4 GRAPHIC-EDGE  
     SIZE 47.5 BY 4.19
     BGCOLOR 8 .

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

DEFINE VARIABLE coRptTyp AS CHARACTER FORMAT "X(256)":U 
     LABEL "Combo 1" 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEMS "Item 1" 
     DROP-DOWN-LIST
     SIZE 22 BY 1
     BGCOLOR 15 FONT 2 NO-UNDO.

DEFINE VARIABLE fiacno1 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 12 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fiacno2 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 12 BY .95
     BGCOLOR 15  NO-UNDO.

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
     SIZE 25 BY .95
     BGCOLOR 19 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fibdes2 AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 25 BY .95
     BGCOLOR 19 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fiBranch AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 5 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fiBranch2 AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 5 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fiInclude AS CHARACTER FORMAT "X(256)":U 
     LABEL "Fill 1" 
      VIEW-AS TEXT 
     SIZE 19 BY 1
     BGCOLOR 1 FGCOLOR 7 FONT 1 NO-UNDO.

DEFINE VARIABLE finame1 AS CHARACTER FORMAT "X(256)":U 
     LABEL "" 
      VIEW-AS TEXT 
     SIZE 45.5 BY .95
     BGCOLOR 19 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE finame2 AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 45.5 BY .95
     BGCOLOR 19 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fiPoldesFr AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 40 BY .95
     BGCOLOR 19 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fiPoldesTo AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 40 BY .95
     BGCOLOR 19 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fiPolTypFr AS CHARACTER FORMAT "X(4)":U 
     VIEW-AS FILL-IN 
     SIZE 5 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fiPolTypTo AS CHARACTER FORMAT "X(4)":U 
     VIEW-AS FILL-IN 
     SIZE 5 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fiProcess AS CHARACTER FORMAT "X(256)":U 
     LABEL "fiProcess" 
      VIEW-AS TEXT 
     SIZE 34 BY .95
     BGCOLOR 8 FGCOLOR 0 FONT 1 NO-UNDO.

DEFINE VARIABLE fiProcessDate AS DATE FORMAT "99/99/9999":U 
      VIEW-AS TEXT 
     SIZE 11.5 BY 1
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
     BGCOLOR 19 FONT 6 NO-UNDO.

DEFINE VARIABLE raReport AS INTEGER 
     VIEW-AS RADIO-SET VERTICAL
     RADIO-BUTTONS 
          "Item1", 1,
"Item2", 2
     SIZE 28.5 BY 2
     BGCOLOR 19 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE RECTANGLE re1
     EDGE-PIXELS 4 GRAPHIC-EDGE  
     SIZE 118.5 BY 16.19
     BGCOLOR 19 .

DEFINE RECTANGLE re11
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 77.5 BY 7.76
     BGCOLOR 8 FGCOLOR 0 .

DEFINE RECTANGLE re12
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 38 BY 7.76
     BGCOLOR 8 .

DEFINE RECTANGLE re13
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 77.5 BY 7.57
     BGCOLOR 8 .

DEFINE RECTANGLE re14
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 38 BY 7.57
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-302
     EDGE-PIXELS 0  
     SIZE 5.5 BY .95
     BGCOLOR 1 .

DEFINE VARIABLE fiTrndatFr AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 3 FGCOLOR 7 FONT 1 NO-UNDO.

DEFINE VARIABLE fiTrndatTo AS DATE FORMAT "99/99/9999":U 
     LABEL "Fill 2" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 3 FGCOLOR 7 FONT 1 NO-UNDO.

DEFINE VARIABLE raAllbal AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "All", 1,
"Partial", 2
     SIZE 25.5 BY 1.05
     BGCOLOR 1 FGCOLOR 7 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-303
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 42 BY 3.91
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-305
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 40 BY 3.38
     BGCOLOR 8 .

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY brAcproc_fil FOR 
      acproc_fil SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE brAcproc_fil
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS brAcproc_fil C-Win _STRUCTURED
  QUERY brAcproc_fil DISPLAY
      acproc_fil.asdat FORMAT "99/99/9999":U COLUMN-FONT 1 LABEL-FONT 1
      acproc_fil.type COLUMN-LABEL "Ty" FORMAT "X(2)":U
      IF (acproc_fil.type = "01") THEN ("Monthly") ELSE ("Daily") COLUMN-LABEL "Detail"
      acproc_fil.entdat COLUMN-LABEL "Process Date" FORMAT "99/99/9999":U
      acproc_fil.enttim COLUMN-LABEL "Time" FORMAT "X(8)":U
      SUBSTRING (acproc_fil.enttim,10,3) COLUMN-LABEL "Sta" FORMAT "X(1)":U
      acproc_fil.trndatfr COLUMN-LABEL "TranDate Fr" FORMAT "99/99/9999":U
      acproc_fil.trndatto COLUMN-LABEL "TranDate To" FORMAT "99/99/9999":U
      acproc_fil.typdesc FORMAT "X(60)":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 75.5 BY 4.38
         BGCOLOR 15 FGCOLOR 0 FONT 1.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     IMAGE-21 AT ROW 1 COL 1.5
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 24.04
         BGCOLOR 18 .

DEFINE FRAME frMain
     IMAGE-22 AT ROW 1 COL 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         NO-LABELS SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 5 ROW 1
         SIZE 126 BY 23.74
         BGCOLOR 20 .

DEFINE FRAME frTrndat
     raAllbal AT ROW 1 COL 19 NO-LABEL
     fiTrndatFr AT ROW 2.81 COL 18 COLON-ALIGNED NO-LABEL
     fiTrndatTo AT ROW 4.14 COL 18 COLON-ALIGNED
     "            To" VIEW-AS TEXT
          SIZE 11.5 BY 1 AT ROW 4.14 COL 8
          FGCOLOR 7 
     " Bal. Filter    ==>":20 VIEW-AS TEXT
          SIZE 18 BY 1.05 AT ROW 1 COL 1
          BGCOLOR 1 FGCOLOR 15 FONT 6
     "Trndat From" VIEW-AS TEXT
          SIZE 11.5 BY 1 AT ROW 2.81 COL 8
          FGCOLOR 7 
     RECT-303 AT ROW 2.05 COL 2
     RECT-305 AT ROW 2.29 COL 3
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         NO-LABELS SIDE-LABELS THREE-D 
         AT COL 54.5 ROW 19
         SIZE 44 BY 5.39
         BGCOLOR 1 .

DEFINE FRAME frOutput
     rsOutput AT ROW 3.33 COL 5.5 NO-LABEL
     fiFile-Name AT ROW 3.33 COL 17 COLON-ALIGNED NO-LABEL
     " Output To":40 VIEW-AS TEXT
          SIZE 48.67 BY .95 TOOLTIP "การแสดงผล" AT ROW 1 COL 1
          BGCOLOR 1 FGCOLOR 15 FONT 6
     RECT-5 AT ROW 2.05 COL 1.5
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 4 ROW 19
         SIZE 49 BY 5.48
         BGCOLOR 1 .

DEFINE FRAME frOK
     Btn_OK AT ROW 1.71 COL 5.5
     Btn_Cancel AT ROW 3.62 COL 5.5
     RECT2 AT ROW 1.24 COL 2.5
    WITH DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 102 ROW 19
         SIZE 22 BY 5.22
         BGCOLOR 1 .

DEFINE FRAME frST
     fiBranch AT ROW 2.81 COL 15 COLON-ALIGNED NO-LABEL
     fiBranch2 AT ROW 3.86 COL 15 COLON-ALIGNED NO-LABEL
     fiPolTypFr AT ROW 5.19 COL 15 COLON-ALIGNED NO-LABEL
     fiPolTypTo AT ROW 6.24 COL 15 COLON-ALIGNED NO-LABEL
     fiacno1 AT ROW 7.52 COL 15 COLON-ALIGNED NO-LABEL
     fiacno2 AT ROW 8.52 COL 15 COLON-ALIGNED NO-LABEL
     fiasdatAging AT ROW 12.24 COL 17 COLON-ALIGNED
     buBranch AT ROW 2.81 COL 22
     buBranch2 AT ROW 3.86 COL 22
     buPoltypFr AT ROW 5.19 COL 22
     buPoltypTo AT ROW 6.24 COL 22
     buAcno2 AT ROW 8.52 COL 29
     coRptTyp AT ROW 4.14 COL 88 COLON-ALIGNED
     raReport AT ROW 5.71 COL 86 NO-LABEL
     raDetSum AT ROW 8.05 COL 83 NO-LABEL
     brAcproc_fil AT ROW 13.52 COL 3.5
     fiTyp1 AT ROW 12.48 COL 86 COLON-ALIGNED NO-LABEL
     fiTyp2 AT ROW 12.48 COL 91 COLON-ALIGNED NO-LABEL
     fiTyp3 AT ROW 12.48 COL 96 COLON-ALIGNED NO-LABEL
     fiTyp4 AT ROW 12.48 COL 101 COLON-ALIGNED NO-LABEL
     fiTyp5 AT ROW 12.48 COL 106 COLON-ALIGNED NO-LABEL
     fiTyp6 AT ROW 13.76 COL 86 COLON-ALIGNED NO-LABEL
     fiTyp7 AT ROW 13.76 COL 91 COLON-ALIGNED NO-LABEL
     fiTyp8 AT ROW 13.76 COL 96 COLON-ALIGNED NO-LABEL
     fiTyp9 AT ROW 13.76 COL 101 COLON-ALIGNED NO-LABEL
     fiTyp10 AT ROW 13.76 COL 106 COLON-ALIGNED NO-LABEL
     fiTyp11 AT ROW 15.1 COL 86 COLON-ALIGNED NO-LABEL
     fiTyp12 AT ROW 15.1 COL 91 COLON-ALIGNED NO-LABEL
     fiTyp13 AT ROW 15.1 COL 96 COLON-ALIGNED NO-LABEL
     fiTyp14 AT ROW 15.1 COL 101 COLON-ALIGNED NO-LABEL
     fiTyp15 AT ROW 15.1 COL 106 COLON-ALIGNED NO-LABEL
     buAcno1 AT ROW 7.52 COL 29
     fibdes AT ROW 2.81 COL 23.5 COLON-ALIGNED NO-LABEL
     fibdes2 AT ROW 3.86 COL 23.5 COLON-ALIGNED NO-LABEL
     fiPoldesFr AT ROW 5.19 COL 23.5 COLON-ALIGNED NO-LABEL
     fiPoldesTo AT ROW 6.24 COL 23.5 COLON-ALIGNED NO-LABEL
     finame1 AT ROW 7.52 COL 30.5 COLON-ALIGNED
     finame2 AT ROW 8.52 COL 30.5 COLON-ALIGNED NO-LABEL
     fiInclude AT ROW 10.67 COL 97 COLON-ALIGNED
     fiAsdat AT ROW 10.91 COL 17 COLON-ALIGNED
     fiProcessDate AT ROW 10.91 COL 49 COLON-ALIGNED NO-LABEL
     fiProcess AT ROW 16.38 COL 82.83
     "Branch From":30 VIEW-AS TEXT
          SIZE 12 BY .95 TOOLTIP "ตั้งแต่สาขา" AT ROW 2.81 COL 4
          BGCOLOR 8 FGCOLOR 0 
     "                                                       Ageing Report By Trandate":210 VIEW-AS TEXT
          SIZE 114.5 BY .95 AT ROW 1 COL 6
          BGCOLOR 1 FGCOLOR 15 FONT 6
     "To":20 VIEW-AS TEXT
          SIZE 12 BY .95 TOOLTIP "รหัสตัวแทนถึง" AT ROW 8.52 COL 4
          BGCOLOR 8 FGCOLOR 0 
     " Type Of Reports":50 VIEW-AS TEXT
          SIZE 36.5 BY 1 AT ROW 2.57 COL 82
          BGCOLOR 1 FGCOLOR 7 
     "Ageing = 31/01/YYYY, Statement = Process Date" VIEW-AS TEXT
          SIZE 44 BY 1 TOOLTIP "Ageing = วันที่วันสุดท้ายของเดือน/ Statement = วันที่ ณ วันที่ Process data" AT ROW 12.24 COL 34
          BGCOLOR 19 
     " Asdate Process":30 VIEW-AS TEXT
          SIZE 14.5 BY .95 AT ROW 10.91 COL 4.5
          BGCOLOR 1 FGCOLOR 7 
     " Asdate for Cal.":30 VIEW-AS TEXT
          SIZE 14.5 BY 1 AT ROW 12.24 COL 4.5
          BGCOLOR 1 FGCOLOR 7 
     "Pol. Type From":50 VIEW-AS TEXT
          SIZE 12 BY .95 TOOLTIP "ตั้งแต่สาขา" AT ROW 5.19 COL 4
          BGCOLOR 8 FGCOLOR 0 
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         NO-LABELS SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 4 ROW 1.3
         SIZE 120 BY 17.44
         BGCOLOR 1 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME frST
     " Include Type All":50 VIEW-AS TEXT
          SIZE 17 BY 1 AT ROW 10.67 COL 82
          BGCOLOR 1 FGCOLOR 7 
     " Process Date":30 VIEW-AS TEXT
          SIZE 16 BY 1 TOOLTIP "วันที่ออกรายงาน" AT ROW 10.91 COL 34.5
          BGCOLOR 1 FGCOLOR 7 
     "To":10 VIEW-AS TEXT
          SIZE 12 BY .95 TOOLTIP "ถึงสาขา" AT ROW 3.86 COL 4
          BGCOLOR 8 FGCOLOR 0 
     "Producer From":100 VIEW-AS TEXT
          SIZE 12 BY .95 TOOLTIP "Account No. From" AT ROW 7.52 COL 4
          BGCOLOR 8 FGCOLOR 0 
     "To":10 VIEW-AS TEXT
          SIZE 12 BY .95 TOOLTIP "ถึงสาขา" AT ROW 6.24 COL 4
          BGCOLOR 8 FGCOLOR 0 
     "By" VIEW-AS TEXT
          SIZE 3.5 BY 1 AT ROW 4.14 COL 86
          BGCOLOR 8 FONT 6
     re1 AT ROW 2.05 COL 1.5
     re11 AT ROW 2.29 COL 2.5
     re12 AT ROW 2.29 COL 81
     re13 AT ROW 10.38 COL 2.5
     re14 AT ROW 10.38 COL 81
     RECT-302 AT ROW 1 COL 1
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         NO-LABELS SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 4 ROW 1.3
         SIZE 120 BY 17.44
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
         TITLE              = "wacr05 - Ageing Report By Trandate"
         HEIGHT             = 23.62
         WIDTH              = 131.67
         MAX-HEIGHT         = 31.33
         MAX-WIDTH          = 170.67
         VIRTUAL-HEIGHT     = 31.33
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
/* REPARENT FRAME */
ASSIGN FRAME frMain:FRAME = FRAME DEFAULT-FRAME:HANDLE
       FRAME frOK:FRAME = FRAME frMain:HANDLE
       FRAME frOutput:FRAME = FRAME frMain:HANDLE
       FRAME frST:FRAME = FRAME frMain:HANDLE
       FRAME frTrndat:FRAME = FRAME frMain:HANDLE.

/* SETTINGS FOR FRAME DEFAULT-FRAME
                                                                        */
/* SETTINGS FOR FRAME frMain
                                                                        */
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

/* SETTINGS FOR FRAME frTrndat
   UNDERLINE                                                            */
/* SETTINGS FOR FILL-IN fiTrndatTo IN FRAME frTrndat
   LABEL "Fill 2:"                                                      */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE brAcproc_fil
/* Query rebuild information for BROWSE brAcproc_fil
     _TblList          = "sicfn.acproc_fil"
     _FldNameList[1]   > sicfn.acproc_fil.asdat
"acproc_fil.asdat" ? ? "date" ? ? 1 ? ? 1 no ? no no ? yes no no "U" "" ""
     _FldNameList[2]   > sicfn.acproc_fil.type
"acproc_fil.type" "Ty" ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[3]   > "_<CALC>"
"IF (acproc_fil.type = ""01"") THEN (""Monthly"") ELSE (""Daily"")" "Detail" ? ? ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[4]   > sicfn.acproc_fil.entdat
"acproc_fil.entdat" "Process Date" ? "date" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[5]   > sicfn.acproc_fil.enttim
"acproc_fil.enttim" "Time" ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[6]   > "_<CALC>"
"SUBSTRING (acproc_fil.enttim,10,3)" "Sta" "X(1)" ? ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[7]   > sicfn.acproc_fil.trndatfr
"acproc_fil.trndatfr" "TranDate Fr" ? "date" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[8]   > sicfn.acproc_fil.trndatto
"acproc_fil.trndatto" "TranDate To" ? "date" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[9]   > sicfn.acproc_fil.typdesc
"acproc_fil.typdesc" ? "X(60)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _Query            is NOT OPENED
*/  /* BROWSE brAcproc_fil */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* wacr05 - Ageing Report By Trandate */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* wacr05 - Ageing Report By Trandate */
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
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brAcproc_fil C-Win
ON RETURN OF brAcproc_fil IN FRAME frST
DO:
    APPLY "VALUE-CHANGED" TO brAcproc_fil.
    APPLY "ENTRY" TO fiasdatAging IN FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brAcproc_fil C-Win
ON VALUE-CHANGED OF brAcproc_fil IN FRAME frST
DO:

    IF NOT CAN-FIND(FIRST acproc_fil WHERE (acproc_fil.type = "01" OR acproc_fil.type = "05" )) THEN DO:
        DO WITH FRAME frST:
            ASSIGN
                fiasdat       = ?
                fiProcessdate = ?
                n_trndatfr    = ?
                n_trndatto    = ?
                n_asdat       = fiasdat
                n_processdate = ?
                n_trndatfrold = ?
                n_trndattoold = ?
                .
            
            DISP fiasdat fiProcessdate.
        END. /**/

        DO WITH FRAME frTrndat:
            ASSIGN
                fitrndatFr = ?
                fitrndatTo = ?
                .

            DISP fitrndatFr   fitrndatTo.
        END.
    END.
    ELSE DO:
        FIND CURRENT acproc_fil NO-LOCK.
        DO WITH FRAME frST:

            ASSIGN
                fiasdat        = acproc_fil.asdat
                fiProcessdate  = acproc_fil.entdat
                n_trndatfr     = acproc_fil.trndatfr
                n_trndatto     = acproc_fil.trndatto
                n_asdat        = fiasdat
                n_processdate  = acproc_fil.entdat
                n_trndatfrold  = acproc_fil.trndatfr
                n_trndattoold  = acproc_fil.trndatto
                .
            DISP fiasdat fiProcessdate .
        END. /**/

        DO WITH FRAME frTrndat:
            ASSIGN
                fitrndatFr = n_trndatfr
                fitrndatTo = n_trndatTo.

            DISP fitrndatFr   fitrndatTo.
        END.

    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frOK
&Scoped-define SELF-NAME Btn_Cancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_Cancel C-Win
ON CHOOSE OF Btn_Cancel IN FRAME frOK /* Cancel */
DO:
    Apply "Close" To This-Procedure.
    Return No-Apply.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_OK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_OK C-Win
ON CHOOSE OF Btn_OK IN FRAME frOK /* OK */
DO:
DEF VAR vFirstTime AS CHAR INIT "".
DEF VAR vLastTime  AS CHAR INIT "".
DEF VAR nv_filter1 AS CHAR INIT "".
DEF VAR nv_filter2 AS CHAR INIT "".

DEF VAR vAcno AS CHAR INIT "".

   DO WITH FRAME {&FRAME-NAME} :
        ASSIGN  
            FRAME frST fibranch fibranch
            FRAME frST fibranch2 fibranch2
            FRAME frST fiacno1 fiacno1
            FRAME frST fiacno2 fiacno2
            FRAME frST fipoltypFr  fipoltypFr
            FRAME frST fipoltypTo fipoltypTo
            FRAME frST coRptTyp coRptTyp
            FRAME frST raReport raReport

            FRAME frST fiAsdat fiAsdat
            FRAME frST fityp1   fityp1
            FRAME frST fityp2   fityp2
            FRAME frST fityp3   fityp3
            FRAME frST fityp4   fityp4
            FRAME frST fityp5   fityp5
            FRAME frST fityp6   fityp6
            FRAME frST fityp7   fityp7
            FRAME frST fityp8   fityp8
            FRAME frST fityp9   fityp9
            FRAME frST fityp10 fityp10
            FRAME frST fityp11 fityp11
            FRAME frST fityp12 fityp12
            FRAME frST fityp13 fityp13
            FRAME frST fityp14 fityp14
            FRAME frST fityp15 fityp15
/*             FRAME frST toprnIns  toPrnIns */
            
            FRAME frOutput rsOutput rsOutput
            FRAME frOutput fiFile-Name fiFile-Name
            /*A47-02364*/
            FRAME frTrndat raAllbal raAllbal
            FRAME frTrndat fitrndatfr fitrndatTo
            FRAME frtrndat fitrndatto fitrndatTo

            /*A47-02364*/

            n_branch  = fiBranch
            n_branch2 = fiBranch2
            n_frac    =  fiAcno1
            n_toac    =  fiAcno2 
            n_asdat   = fiasdat /*DATE( INPUT cbAsDat) */
            
            n_OutputTo    =  rsOutput
            n_OutputFile  =  fiFile-Name
            n_OutputFileSum = n_OutputFile + "Sum"
             
            nv_poltypFr = fipoltypFr
            nv_poltypTo = fipoltypTo
            nv_RptName  = coRptTyp
            nv_RptName2 = IF raReport = 1 THEN "With Credit Term"  ELSE  "By Transaction Date"

            nv_typ1  = fityp1
            nv_typ2  = fityp2
            nv_typ3  = fityp3
            nv_typ4  = fityp4
            nv_typ5  = fityp5
            nv_typ6  = fityp6
            nv_typ7  = fityp7
            nv_typ8  = fityp8
            nv_typ9  = fityp9
            nv_typ10 = fityp10
            nv_typ11 = fityp11
            nv_typ12 = fityp12
            nv_typ13 = fityp13
            nv_typ14 = fityp14
            nv_typ15 = fityp15

/*             nv_prninslog = toprnIns */
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
            nv_trntyp1 = IF fityp15 <> "" THEN nv_trntyp1 + "," + fityp15 ELSE nv_trntyp1.            /* nv_trntyp1 = REPLACE(nv_trntyp1,", ","")*/        

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

   /*A47-02364*/
   IF raAllbal = 1 THEN DO:

   END.
   /*A47-02364*/
        

    /*--- A500178 ---
    IF  n_frac = "" THEN  n_frac = "A000000".
    IF  n_toac = "" THEN  n_toac = "B999999". 
    ------*/
    IF  n_frac = "" THEN  n_frac = "A000000".
    IF  n_toac = "" THEN  n_toac = "B999999999". 
    
    nv_poltypFr  = IF nv_poltypFr = "" THEN "" ELSE SUBSTR(nv_poltypFr,2,2).
    nv_poltypTo  = IF nv_poltypTo = "" THEN "99" ELSE SUBSTR(nv_poltypTo,2,2).


   IF ( n_branch > n_branch2)   THEN DO:
         MESSAGE  "ข้อมูลรหัสสาขาผิดพลาด" SKIP
                          "รหัสสาขาเริ่มต้นต้องมากกว่ารหัสสุดท้าย" VIEW-AS ALERT-BOX WARNING . 
         APPLY  "Entry" TO  fibranch.
         RETURN  NO-APPLY .       
   END.
   IF ( n_frac > n_toac)   THEN DO:
         MESSAGE  "ข้อมูลตัวแทนผิดพลาด" SKIP
                          "รหัสตัวแทนเริ่มต้นต้องมากกว่ารหัสสุดท้าย" VIEW-AS ALERT-BOX WARNING . 
         APPLY  "Entry" TO  fiacno1  .
         RETURN  NO-APPLY .       
   END.
   IF  n_OutputFile = ""    THEN DO:  /* n_OutputTo = 3 And */
         Message "กรุณาใส่ชื่อไฟล์" VIEW-AS ALERT-BOX WARNING . 
         APPLY  "Entry" TO   fiFile-Name .
         RETURN  NO-APPLY .
   END.
   IF nv_asdatAging = ? THEN DO:
        MESSAGE  "กรุณาใส่ Asdate for Aging "  SKIP (1)
                            "Asdate for Aging  <=  Process Date " VIEW-AS ALERT-BOX ERROR.
         APPLY "Entry" TO fiasdatAging .
         RETURN NO-APPLY .
    END.

/*     IF  raAllbal = 2 AND                                              */
/*         ((towcr = FALSE) AND                                          */
/*          (todamt = FALSE) AND                                         */
/*          (toodue1 = FALSE) AND                                        */
/*          (toodue2 = FALSE) AND                                        */
/*          (toodue3 = FALSE) AND                                        */
/*          (toodue4 = FALSE) AND                                        */
/*          (toodue5 = FALSE))  THEN DO:                                 */
/*          MESSAGE  "กรุณาระบุ Bal. Filter" VIEW-AS ALERT-BOX WARNING . */
/*          RETURN  NO-APPLY .                                           */
/*    END.                                                               */

    IF n_asdat = ?   THEN DO:
            MESSAGE "ไม่พบข้อมูล  กรุณาตรวจสอบการ Process ข้อมูล" VIEW-AS ALERT-BOX WARNING.
    END.
    ELSE DO:
        MESSAGE "สาขา                      : "  n_Branch " ถึง " n_Branch2 SKIP(1)
                "ตัวแทน/นายหน้า   : "  n_frac " ถึง " n_toac  SKIP(1)
                "Tran. date             : " n_trndatfr " ถึง " n_trndatto SKIP(1)
                "Policy Type           : " nv_poltypFr " ถึง " nv_poltypTo SKIP(1)
                "Include Type         : " nv_trntyp1 SKIP(1)
                "Asdate for ST(A4)  : " STRING(n_asdat,"99/99/9999") SKIP(1)
                "Asdate for Aging    : "  STRING(nv_asdatAging,"99/99/9999") SKIP(1)
                "Report Name          : " nv_RptName + " " + nv_RptName2
                "   (" + nv_DetSum + ")"
                VIEW-AS ALERT-BOX QUESTION
        BUTTONS YES-NO
        TITLE "Confirm"    UPDATE CHOICE AS LOGICAL.
        CASE CHOICE:
        WHEN TRUE THEN    DO:
             
            vFirstTime =  STRING(TIME, "HH:MM AM").

            IF nv_RptName  = "Acno" THEN DO:
                    RUN pdAcnoDet.   
            END.
            ELSE IF nv_RptName = "Branch" THEN DO:
                    RUN pdBranchDet.
            END.
            ELSE IF nv_RptName = "Line" THEN DO:
                    RUN pdLineDet.
            END.
            
            RELEASE agtprm_fil.
 
            vLastTime =  STRING(TIME, "HH:MM AM").

            MESSAGE "As of Date      : " STRING(n_asdat,"99/99/9999")  SKIP (1)
                    "ตัวแทน            : "  n_frac " ถึง " n_toac SKIP (1)
                    "เวลา  " vFirstTime "  -  " vLastTime   VIEW-AS ALERT-BOX INFORMATION.
         
        END.
        WHEN FALSE THEN    DO:
        
                RETURN NO-APPLY. 
        END.
        END CASE.    
        
    END.   /* IF  asdat  <> ? */
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frST
&Scoped-define SELF-NAME buAcno1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buAcno1 C-Win
ON CHOOSE OF buAcno1 IN FRAME frST /* ... */
DO:
   n_chkname = "1". 
  RUN Whp\WhpAcno(input-output  n_name,input-output n_chkname).
  
  Assign    
        fiacno1 = n_agent1
        finame1 = n_name.
       
  Disp fiacno1 finame1  with Frame {&Frame-Name}      .
 
 n_agent1 =  fiacno1 .

  Return NO-APPLY.
 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buAcno2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buAcno2 C-Win
ON CHOOSE OF buAcno2 IN FRAME frST /* ... */
DO:
  n_chkname = "2". 
  run Whp\WhpAcno(input-output  n_name,input-output n_chkname).
  
  Assign    
        fiacno2 = n_agent2
        finame2 = n_name.
       
  Disp fiacno2 finame2 with Frame {&Frame-Name}      .
   
  n_agent2 =  fiacno2 .
  
  Return NO-APPLY.
 
 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buBranch
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buBranch C-Win
ON CHOOSE OF buBranch IN FRAME frST /* ... */
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
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buPoltypFr C-Win
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
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buPoltypTo C-Win
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


&Scoped-define SELF-NAME coRptTyp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL coRptTyp C-Win
ON RETURN OF coRptTyp IN FRAME frST /* Combo 1 */
DO:

    APPLY "ENTRY" TO raReport IN FRAME {&FRAME-NAME}.
    RETURN NO-APPLY.
       
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL coRptTyp C-Win
ON VALUE-CHANGED OF coRptTyp IN FRAME frST /* Combo 1 */
DO:
    coRptTyp = INPUT coRptTyp.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiacno1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiacno1 C-Win
ON LEAVE OF fiacno1 IN FRAME frST
DO:
    Assign
        fiacno1 = input fiacno1
        n_agent1  = fiacno1.
    
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


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiacno1 C-Win
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
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiacno2 C-Win
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
              fiAcno2 = "".
              finame2:Screen-value IN FRAME {&FRAME-NAME} = "Not Found !".
              MESSAGE "ไม่พบข้อมูล" VIEW-AS ALERT-BOX  warning TITLE "Confirm" .
        END.
    END.
    DISP CAPS (fiAcno2) @ fiAcno2 WITH FRAME frST.
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiacno2 C-Win
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
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiasdatAging C-Win
ON LEAVE OF fiasdatAging IN FRAME frST /* Fill 1 */
DO:
    fiasdatAging = INPUT fiasdatAging.
    
    nv_asdatAging = fiasdatAging.
    
    IF nv_asdatAging <= fiProcessdate THEN nv_asdatAging = fiasdatAging.
    ELSE DO:
        MESSAGE  "Invaild data ! "  SKIP (1)
                            "Asdate for Aging  > Process Date " VIEW-AS ALERT-BOX ERROR.
        ASSIGN
            nv_asdatAging =  ?
            fiasdatAging  = ?.
        DISP fiasdatAging WITH FRAME frST.
    END.
    
    APPLY "ENTRY" TO coRptTyp IN FRAME {&FRAME-NAME}.
    RETURN NO-APPLY.    


END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiasdatAging C-Win
ON RETURN OF fiasdatAging IN FRAME frST /* Fill 1 */
DO:
      APPLY "ENTRY" TO fiFile-Name IN FRAME froutput.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiBranch
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiBranch C-Win
ON LEAVE OF fiBranch IN FRAME frST
DO:
  ASSIGN
         fibranch = input fibranch
         n_branch = CAPS(fibranch).

    DISP n_branch @ fibranch WITH FRAME frST.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiBranch C-Win
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
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiBranch2 C-Win
ON LEAVE OF fiBranch2 IN FRAME frST
DO:
     ASSIGN
         fibranch2 = input fibranch2
         n_branch2  = CAPS(fibranch2).
         
    DISP n_branch2 @ fibranch2 WITH FRAME frST.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiBranch2 C-Win
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
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiFile-Name C-Win
ON RETURN OF fiFile-Name IN FRAME frOutput
DO:
          APPLY "ENTRY" TO btn_OK IN FRAME frOK.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frST
&Scoped-define SELF-NAME fiPolTypFr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiPolTypFr C-Win
ON LEAVE OF fiPolTypFr IN FRAME frST
DO:

    ASSIGN
        fiPolTypFr = INPUT fiPolTypFr
        n_poltyp  = CAPS(fiPolTypFr).
        
    DISP 
        n_poltyp @ fiPoltypFr
        n_poltyp @ fiPolTypTo WITH FRAME frST.
   
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
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiPolTypTo C-Win
ON LEAVE OF fiPolTypTo IN FRAME frST
DO:

    ASSIGN
        fiPolTypTo = INPUT fiPolTypTo
        n_poltyp  = CAPS(fiPolTypTo).
        
    DISP 
        n_poltyp @ fiPoltypTo  WITH FRAME frST. 
   
    IF n_PolTyp <> ""  THEN DO :
        FIND   xmm031 WHERE xmm031.poltyp = n_poltyp  NO-ERROR.
        IF AVAILABLE xmm031 THEN DO:
              fipoldesTo:Screen-value IN FRAME {&FRAME-NAME} = xmm031.poldes.
        END.        
        ELSE DO:
              fipoldesTo:Screen-value IN FRAME {&FRAME-NAME} = "Not Found !".
              MESSAGE "ไม่พบข้อมูล" VIEW-AS ALERT-BOX  warning TITLE "Confirm" .
        END.
    END.
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frTrndat
&Scoped-define SELF-NAME fiTrndatFr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiTrndatFr C-Win
ON LEAVE OF fiTrndatFr IN FRAME frTrndat
DO:
  fiTrndatfr = INPUT fiTrndatfr.

  n_trndatfr = fitrndatfr.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiTrndatTo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiTrndatTo C-Win
ON LEAVE OF fiTrndatTo IN FRAME frTrndat /* Fill 2 */
DO:
    fiTrndatTo = INPUT fiTrndatTo.
    
    n_trndatTo = fitrndatto.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frST
&Scoped-define SELF-NAME fiTyp1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiTyp1 C-Win
ON LEAVE OF fiTyp1 IN FRAME frST
DO:
    fiTyp1 = CAPS(INPUT fiTyp1).
    DISP fiTyp1 WITH FRAME frST.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiTyp10
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiTyp10 C-Win
ON LEAVE OF fiTyp10 IN FRAME frST
DO:
    fiTyp10 = CAPS(INPUT fiTyp10).
    DISP fiTyp10 WITH FRAME frST.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiTyp11
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiTyp11 C-Win
ON LEAVE OF fiTyp11 IN FRAME frST
DO:
    fiTyp11 = CAPS(INPUT fiTyp11).
    DISP fiTyp11 WITH FRAME frST.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiTyp12
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiTyp12 C-Win
ON LEAVE OF fiTyp12 IN FRAME frST
DO:
    fiTyp12 = CAPS(INPUT fiTyp12).
    DISP fiTyp12 WITH FRAME frST.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiTyp13
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiTyp13 C-Win
ON LEAVE OF fiTyp13 IN FRAME frST
DO:
    fiTyp13 = CAPS(INPUT fiTyp13).
    DISP fiTyp13 WITH FRAME frST.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiTyp14
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiTyp14 C-Win
ON LEAVE OF fiTyp14 IN FRAME frST
DO:
    fiTyp14 = CAPS(INPUT fiTyp14).
    DISP fiTyp14 WITH FRAME frST.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiTyp15
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiTyp15 C-Win
ON LEAVE OF fiTyp15 IN FRAME frST
DO:
    fiTyp15 = CAPS(INPUT fiTyp15).
    DISP fiTyp15 WITH FRAME frST.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiTyp2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiTyp2 C-Win
ON LEAVE OF fiTyp2 IN FRAME frST
DO:
    fiTyp2 = CAPS(INPUT fiTyp2).
    DISP fiTyp2 WITH FRAME frST.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiTyp3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiTyp3 C-Win
ON LEAVE OF fiTyp3 IN FRAME frST
DO:
    fiTyp3 = CAPS(INPUT fiTyp3).
    DISP fiTyp3 WITH FRAME frST.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiTyp4
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiTyp4 C-Win
ON LEAVE OF fiTyp4 IN FRAME frST
DO:
    fiTyp4 = CAPS(INPUT fiTyp4).
    DISP fiTyp4 WITH FRAME frST.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiTyp5
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiTyp5 C-Win
ON LEAVE OF fiTyp5 IN FRAME frST
DO:
    fiTyp5 = CAPS(INPUT fiTyp5).
    DISP fiTyp5 WITH FRAME frST.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiTyp6
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiTyp6 C-Win
ON LEAVE OF fiTyp6 IN FRAME frST
DO:
    fiTyp6 = CAPS(INPUT fiTyp6).
    DISP fiTyp6 WITH FRAME frST.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiTyp7
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiTyp7 C-Win
ON LEAVE OF fiTyp7 IN FRAME frST
DO:
    fiTyp7 = CAPS(INPUT fiTyp7).
    DISP fiTyp7 WITH FRAME frST.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiTyp8
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiTyp8 C-Win
ON LEAVE OF fiTyp8 IN FRAME frST
DO:
    fiTyp8 = CAPS(INPUT fiTyp8).
    DISP fiTyp8 WITH FRAME frST.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiTyp9
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiTyp9 C-Win
ON LEAVE OF fiTyp9 IN FRAME frST
DO:
    fiTyp9 = CAPS(INPUT fiTyp9).
    DISP fiTyp9 WITH FRAME frST.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frTrndat
&Scoped-define SELF-NAME raAllbal
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL raAllbal C-Win
ON VALUE-CHANGED OF raAllbal IN FRAME frTrndat
DO:
  
DO WITH FRAME frTrndat.

    raAllbal  = INPUT raAllbal .
    

    IF raAllbal = 1 THEN  DO:   /* all  bal */

        DISABLE ALL EXCEPT raAllbal .

        ASSIGN
        n_trndatfr = n_trndatfrold
        n_trndatto = n_trndattoold
        
        fiTrndatfr = n_trndatfr
        fiTrndatto = n_trndatto.

        DISP fiTrndatfr fiTrndatto .

    END.
    ELSE DO:                            /* partial bal */
        ENABLE ALL .

    END.
    
    

END.
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frST
&Scoped-define SELF-NAME raDetSum
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL raDetSum C-Win
ON VALUE-CHANGED OF raDetSum IN FRAME frST
DO:

    raDetSum = INPUT raDetSum.
    
    nv_DetSum = IF raDetSum =  1 THEN "Detail" 
                            ELSE IF raDetSum =  2 THEN "Summary"
                            ELSE "All".
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME raReport
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL raReport C-Win
ON RETURN OF raReport IN FRAME frST
DO:
    APPLY "ENTRY" TO fityp1  IN FRAME frST.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL raReport C-Win
ON VALUE-CHANGED OF raReport IN FRAME frST
DO:

    DO WITH FRAME frST:
        ASSIGN
            raReport= INPUT raReport
            fiasdatAging = INPUT fiasdatAging.

        DISP fiasdatAging.  
    END.
    
END.

/*        IF raChoice = 1 THEN DO: 
 *             DISABLE fiasdatAging. 
 *             ASSIGN
 *                 fiasdatAging = ?
 *                 nv_asdatAging = ?.
 *         END.
 *         ELSE DO:
 *             ENABLE fiasdatAging.
 *             nv_asdatAging = fiasdatAging.
 *         END.*/

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frOutput
&Scoped-define SELF-NAME rsOutput
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL rsOutput C-Win
ON VALUE-CHANGED OF rsOutput IN FRAME frOutput
DO:
  ASSIGN {&SELF-NAME}.
  
    fiFile-Name:SENSITIVE = Yes. 
    APPLY "ENTRY" TO fiFile-Name.

  
/*  CASE rsOutput:
 *         WHEN 1 THEN  /* Screen */
 *           ASSIGN
 *            cbPrtList:SENSITIVE   = No
 *            fiFile-Name:SENSITIVE = No.
 *         WHEN 2 THEN  /* Printer */
 *           ASSIGN
 *            cbPrtList:SENSITIVE   = Yes
 *            fiFile-Name:SENSITIVE = No.
 *         WHEN 3 THEN  /* File */ 
 *         DO:
 *           ASSIGN
 *             cbPrtList:SENSITIVE   = No
 *             fiFile-Name:SENSITIVE = Yes. 
 *           APPLY "ENTRY" TO fiFile-Name.
 *         END.
 *   END CASE.*/
  
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

/********************  T I T L E   F O R  C - W I N  ****************/
  DEF  VAR  gv_prgid   AS   CHAR.
  DEF  VAR  gv_prog    AS   CHAR.
  
  gv_prgid = "wacr05".
  gv_prog  = "Ageing Report By Trandate".
  RUN  WUT\WUTHEAD (c-win:handle,gv_prgid,gv_prog).

/*********************************************************************/  

/*   CURRENT-WINDOW:WINDOW-STATE = WINDOW-MAXIMIZED. */
/*    RUN Wut\Wutwicen.p (C-Win:HANDLE).*/

  SESSION:DATA-ENTRY-RETURN = YES.
  
    DO WITH FRAME frST :
        re1:MOVE-TO-TOP().
        re11:MOVE-TO-TOP().
        re12:MOVE-TO-TOP().
        re13:MOVE-TO-TOP().
        re14:MOVE-TO-TOP().
    
/*  RUN ProcGetRptList.
 *   RUN ProcGetPrtList.  */

        ASSIGN   
             fiacno1    = ""
             fiacno2    = ""
             fiPoltypFr = ""   /*F10*/
             fiPoltypTo = ""   /*C90*/
             nv_asdatAging = ?
             fiProcess = ""

             fiInclude =  nv_Trntyp1
             fityp1 = "M"
             fityp2 = "R"
             fityp3 = "A"
             fityp4 = "B"
             fityp5 = "C"
             fityp6 = "Y"
             fityp7 = "Z"

            nv_RptTyp = "Acno,Branch,Line"
   
            coRptTyp:List-Items = nv_RptTyp
            coRptTyp = ENTRY(1,nv_RptTyp)
            raReport:Radio-Buttons = "With Credit Term, 1,Transaction Date, 2"
            raReport = 1
            
            raDetSum:radio-buttons = "Detail,1,Summary,2,All,3"
            raDetSum = 1
            nv_DetSum = IF raDetSum =  1 THEN "Detail" 
                        ELSE IF raDetSum =  2 THEN "Summary"
                        ELSE "All".

        DISPLAY  fiacno1 fiacno2  fiasdat
                         fiInclude   fityp1  fityp2  fityp3  fityp4  fityp5  fityp6  fityp7
                         fiPoltypFr fiPoltypTo
                         coRptTyp
                         raReport
                         raDetSum.
        
    RUN pdInitData.
    RUN pdUpdateQ.

    APPLY "ENTRY" TO fiBranch IN FRAME frST.
  END.    
  DO WITH FRAME frTranDate:
       ASSIGN  
         rsOutput:Radio-Buttons = "File, 1" /*"หน้าจอ, 1,เครื่องพิมพ์, 2, File, 3" */
         rsOutput = 1.
      DISPLAY rsOutput WITH FRAME frOutput .    

  END.

    DO WITH FRAME frTrndat :
        raAllbal = 1.
        DISABLE ALL EXCEPT raAllbal  WITH FRAME frTrndat .
    END.

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
  ENABLE IMAGE-21 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  ENABLE IMAGE-22 
      WITH FRAME frMain IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-frMain}
  DISPLAY fiBranch fiBranch2 fiPolTypFr fiPolTypTo fiacno1 fiacno2 fiasdatAging 
          coRptTyp raReport raDetSum fiTyp1 fiTyp2 fiTyp3 fiTyp4 fiTyp5 fiTyp6 
          fiTyp7 fiTyp8 fiTyp9 fiTyp10 fiTyp11 fiTyp12 fiTyp13 fiTyp14 fiTyp15 
          fibdes fibdes2 fiPoldesFr fiPoldesTo finame1 finame2 fiInclude fiAsdat 
          fiProcessDate fiProcess 
      WITH FRAME frST IN WINDOW C-Win.
  ENABLE fiBranch fiBranch2 fiPolTypFr fiPolTypTo fiacno1 fiacno2 fiasdatAging 
         buBranch buBranch2 buPoltypFr buPoltypTo buAcno2 coRptTyp raReport 
         raDetSum brAcproc_fil fiTyp1 fiTyp2 fiTyp3 fiTyp4 fiTyp5 fiTyp6 fiTyp7 
         fiTyp8 fiTyp9 fiTyp10 fiTyp11 fiTyp12 fiTyp13 fiTyp14 fiTyp15 buAcno1 
         fibdes fibdes2 fiPoldesFr fiPoldesTo finame1 finame2 fiInclude fiAsdat 
         fiProcessDate fiProcess re1 re11 re12 re13 re14 RECT-302 
      WITH FRAME frST IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-frST}
  DISPLAY rsOutput fiFile-Name 
      WITH FRAME frOutput IN WINDOW C-Win.
  ENABLE RECT-5 rsOutput fiFile-Name 
      WITH FRAME frOutput IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-frOutput}
  DISPLAY raAllbal fiTrndatFr fiTrndatTo 
      WITH FRAME frTrndat IN WINDOW C-Win.
  ENABLE raAllbal RECT-303 RECT-305 fiTrndatFr fiTrndatTo 
      WITH FRAME frTrndat IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-frTrndat}
  ENABLE RECT2 Btn_OK Btn_Cancel 
      WITH FRAME frOK IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-frOK}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdAcnoDet C-Win 
PROCEDURE pdAcnoDet :
/*------------------------------------------------------------------------------
  Purpose: Ageing Detail  By Acno
------------------------------------------------------------------------------*/
                
DEF VAR  vCount AS INT INIT 0.
DEF VAR  i AS INT.

nv-1 = FILL(" ",5).

/* delete  work-table */
FOR EACH wtGrpCode: DELETE wtGrpCode. END.
FOR EACH wtGrpSum:  DELETE wtGrpSum.  END.

    /*RUN pdForGrpCode. /* หา Group code */*/
    RUN pdInitDataG. /* clear ค่า GRAND TOTAL ทั้ง file detail, summary */

    ASSIGN
        nv_reccnt = 0
        nv_next   = 1
        n_OutputFile = n_OutputFile + STRING(nv_next).      
    /********************** Page Header *********************/
    
/*--- DISPLAY DETAIL  ---*/
    IF (nv_DetSum = "Detail")  OR (nv_DetSum = "All") THEN DO:
        OUTPUT TO VALUE (n_OutputFile ) NO-ECHO.
            RUN pdTitleDet.    /*3 row */ /*RUN pdPageHead.*/
            RUN pdPageHeadDet. /*1*/
        OUTPUT CLOSE.

        nv_reccnt = nv_reccnt + 4 . /*A47-0263 */
    END.  /* (nv_DetSum = "Detail")  OR (nv_DetSum = "All") */
    

/*** DISPLAY SUMMARY FILE & SUMMARY GRAND TOTAL***/
    IF (nv_DetSum = "Summary")  OR (nv_DetSum = "All") THEN DO:
        OUTPUT TO VALUE (n_OutputFileSum) NO-ECHO.  /* SUMMARY */
            RUN pdTitleSum.
            RUN pdPageHeadSum.
        OUTPUT CLOSE.
        
        /* A47-0264 */
        OUTPUT TO VALUE (n_OutputFileSum + "OS") NO-ECHO.  /* SUMMARY */
            RUN pdTitleSumOS.
            EXPORT DELIMITER ";"
                nv_RptName
                "Premium "
                "Comm"
                /* A47-9999 */
                "Bal. O/S (Prem + Comm)"
                "Cheque Return"
                "Suspense"
                "Net. A/r (Bal. O/S + Cheque Ret. + Sus. )"
                "Net. Other (ex. 'YP')"
                .
        OUTPUT CLOSE.
        /* end A47-0264 */

    END.  /* (nv_DetSum = "Summary")  OR (nv_DetSum = "All")  */

    loop_ac :

    FOR EACH  agtprm_fil WHERE /* use-index by_acno */
              agtprm_fil.asdat    = n_asdat    AND
             (agtprm_fil.acno    >= n_frac     AND agtprm_fil.acno    <= n_toac  )   AND
             (agtprm_fil.trndat  >= n_trndatFr AND agtprm_fil.trndat  <= n_trndatTo) AND
             (agtprm_fil.polbran >= n_branch   AND agtprm_fil.polbran <= n_branch2)  AND
      (SUBSTR(agtprm_fil.policy,3,2) >= nv_poltypFr   AND 
       SUBSTR(agtprm_fil.policy,3,2) <= nv_poltypTo)  AND
      (LOOKUP(SUBSTRING(agtprm_fil.trntyp,1,1) , nv_trntyp1) <> 0 )

    NO-LOCK BREAK  BY agtprm_fil.acno 
                   BY agtprm_fil.trndat
                   BY agtprm_fil.policy
                   BY agtprm_fil.endno. /*    NO-LOCK BREAK BY agtprm_fil.acno BY agtprm_fil.polbran BY agtprm_fil.trndat. */

            DISP /* agtprm_fil.acno  --- A500178 ---*/
                 agtprm_fil.acno FORMAT "X(10)"
                 agtprm_fil.trndat
                 agtprm_fil.policy
                 agtprm_fil.trntyp
                 agtprm_fil.docno
            WITH COLOR BLACK/WHITE NO-LABEL FRAME frProcess VIEW-AS DIALOG-BOX
            TITLE  "  Processing ...".
        
        n_asdat = IF nv_asdatAging = ? THEN n_asdat ELSE nv_asdatAging.
    /* Begin */
          /********************** Group Header *********************/
            
        IF FIRST-OF(agtprm_fil.acno)  THEN DO:  /**/
            nv_acname = "".
            FIND  xmm600 USE-INDEX xmm60001 WHERE
                  xmm600.acno  = agtprm_fil.acno NO-LOCK NO-ERROR.
            IF AVAIL xmm600 THEN nv_acname = TRIM(xmm600.ntitle) + " " + TRIM(xmm600.name).
                                            ELSE nv_acname = agtprm_fil.ac_name.

            /*--- DISPLAY DETAIL  ---*/
            IF (nv_DetSum = "Detail")  OR (nv_DetSum = "All") THEN DO:
                
                /* A47-0264 */
                    {wac\wacr0604.i}
                /* end A47-0264 */

                OUTPUT TO VALUE (STRING(n_OutputFile ) ) APPEND NO-ECHO.
                    EXPORT DELIMITER ";"
                        "Acno : " + agtprm_fil.acno + " - " +  nv_acname  + "  " +
                        "Credit Limit " + STRING(agtprm_fil.odue6,"->>>,>>>,>>>,>>9.99") + "  " +    /*xmm600.ltamt   Credit Limit*/
                        agtprm_fil.acno_clicod  + "  " +
                        "Type : " + agtprm_fil.type.
                OUTPUT CLOSE.
            
            END.  /*  (nv_DetSum = "Detail")  OR (nv_DetSum = "All") */


            RUN pdInitDataTot.  /* clear data in group*/
         
        END.  /* first-of(agtprm_fil.acno) */

        /****** คำนวน รายละเอียดค่า และ display ใน File Detail   ใน dot i*****/
            {wac\wacr0601.i}


        /********************** Group Footer *********************/
          IF LAST-OF(agtprm_fil.acno)  THEN DO:  /**/
            nv_acname = "".
            FIND  xmm600 USE-INDEX xmm60001 WHERE
                       xmm600.acno  = agtprm_fil.acno NO-LOCK NO-ERROR.
            IF AVAIL xmm600 THEN nv_acname = TRIM(xmm600.ntitle) + " " + TRIM(xmm600.name).
                                            ELSE nv_acname = agtprm_fil.ac_name.
          
            ASSIGN
                nv_RptTyp1 = ""
                nv_RptTyp2 = ""
                nv_RptTyp1 = agtprm_fil.acno  /* เปลี่ยนไปตาม ชนิดของ report */
                nv_RptTyp2 = nv_acname.

            /*** คำนวนผลรวม group, export ข้อมูลลง SUMMARY FILE และ  คำนวน SUMMARY GRAND TOTAL***/
                {wac\wacr0602.i}

        /*** CREATE  WORK-TABLE for file SUMMARY GROUP CODE***/
             DO TRANSACTION:
                CREATE wtGrpSum.
                ASSIGN
                    wtGTrptName = nv_RptName
                    wtGTgpcode  = xmm600.gpage  /* ageing Group Code*/
                    wtGTacno    = agtprm_fil.acno
                    wtGTacname  = nv_acname

                    wtGTTPrem   = nv_TTprem
                    wtGTTcomm   = nv_TTcomm
                    wtGTTbal    = nv_TTbal

                    wtGTTretc   = nv_TTretc
                    wtGTTsusp   = nv_TTsusp
                    wtGTTnetar  = nv_TTnetar
                    wtGTTnetoth = nv_TTnetoth.
   
                 i = 1.
                 DO i = 1 to 15 :
                    ASSIGN
                        wtGTPrem[i] = nv_Tprem[i]
                        wtGTcomm[i] = nv_Tcomm[i]
                        wtGTbal[i]  = nv_Tbal[i]

                        wtGTretc[i] = nv_Tretc[i]
                        wtGTsusp[i] = nv_Tsusp[i]
                        wtGTnetar[i]  = nv_Tnetar[i]
                        wtGTnetoth[i] = nv_Tnetoth[i]
                        .
                 END.
              END. /*transaction*/


          END. /*  LAST-OF(agtprm_fil.acno) */
        vCount = vCount + 1.
    END. /* for each agtprm_fil*/

        /********************** Page Footer *********************/

        /*** export ข้อมูลลง DETAIL FILE บรรทัด Grand Total  และ  
                                    SUMMARY FILE บรรทัด Grand Total ***/
            {wac\wacr0603.i}

    RELEASE agtprm_fil.

    IF (nv_DetSum = "Summary")  OR (nv_DetSum = "All") THEN DO:
        RUN pdAcnoGp.  /* แยก group code ออกมาอีก 1 file */
    END.

END PROCEDURE.


/*----**********************************************
/*** CREATE  WORK-TABLE for file SUMMARY GROUP CODE***/
     DO TRANSACTION:
        CREATE wtGrpSum.
        ASSIGN
            wtGTrptName = nv_RptName
            wtGTgpcode = xmm600.gpage  /* ageing Group Code*/
            wtGTacno    = agtprm_fil.acno
            wtGTacname = nv_acname
            wtGTTPrem = nv_TTprem
            wtGTTtax = nv_TTtax
            wtGTTvat = nv_TTvat
            wtGTTsbt = nv_TTsbt
            wtGTTstamp = nv_TTstamp
            wtGTTtotal = nv_TTtotal
            wtGTTcomm = nv_TTcomm
            wtGTTnet = nv_TTnet
            wtGTTretc = nv_TTretc
            wtGTTsusp = nv_TTsusp
            wtGTTnetar = nv_TTnetar
            wtGTTnetar = nv_TTnetoth
            wtGTTbal = nv_TTbal.
   
         i = 1.
         DO i = 1 to 15 :
            ASSIGN
                wtGTPrem[i] = nv_Tprem[i]
                wtGTtax[i] = nv_Ttax[i]
                wtGTvat[i] = nv_Tvat[i]
                wtGTsbt[i] = nv_Tsbt[i]
                wtGTstamp[i] = nv_Tstamp[i]
                wtGTtotal[i] = nv_Ttotal[i]
                wtGTcomm[i] = nv_Tcomm[i]
                wtGTnet[i] = nv_Tnet[i]
                wtGTretc[i] = nv_Tretc[i]
                wtGTsusp[i] = nv_Tsusp[i]
                wtGTnetar[i] = nv_Tnetar[i]
                wtGTnetoth[i] = nv_Tnetoth[i]

                wtGTbal[i] = nv_Tbal[i].
   
         END.
      END. /*transaction*/


---*/

/*         /* A47-0264 */                                            */
/*         IF  raAllbal = 2  THEN DO:      /* ดึงข้อมูลบางส่วน */    */
/*             IF     ( (agtprm_fil.wcr NE 0) AND towcr = TRUE )     */
/*                 OR ( (agtprm_fil.damt  NE 0) AND todamt = TRUE )  */
/*                 OR ( (agtprm_fil.odue1 NE 0) AND toodue1 = TRUE ) */
/*                 OR ( (agtprm_fil.odue2 NE 0) AND toodue2 = TRUE ) */
/*                 OR ( (agtprm_fil.odue3 NE 0) AND toodue3 = TRUE ) */
/*                 OR ( (agtprm_fil.odue4 NE 0) AND toodue4 = TRUE ) */
/*                 OR ( (agtprm_fil.odue5 NE 0) AND toodue5 = TRUE ) */
/*             THEN                                                  */
/*                 raAllbal = 2.                                     */
/*             ELSE                                                  */
/*                 NEXT loop_ac .                                    */
/*         END.                                                      */
/*         /* end A47-0264 */                                        */

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdAcnoGp C-Win 
PROCEDURE pdAcnoGp :
/*------------------------------------------------------------------------------
  Purpose:     แยกไฟล์ summary  BREAK BY group code
  Parameters:  <none>
  Notes:        field  xmm600.gpage
------------------------------------------------------------------------------*/
DEF VAR vgpname AS CHAR.

    OUTPUT TO VALUE (n_OutputFile + "Gp") NO-ECHO.  /* SUMMARY */
        RUN pdTitleSum.
        RUN pdPageHeadSum.

        FOR EACH wtGrpSum USE-INDEX wtGrpSum2
                            BREAK BY wtGTgpcode BY wtGTacno :

            IF FIRST-OF(wtGTgpcode) THEN DO:
                FIND FIRST xmm600 USE-INDEX xmm60001 WHERE
                           xmm600.acno = wtGTgpcode NO-LOCK NO-ERROR.
                IF AVAIL xmm600 THEN vgpname = xmm600.name.  /* ชื่อ พนักงาน การเงิน */
                                ELSE vgpname = "".
                    
                EXPORT DELIMITER ";" "".
                EXPORT DELIMITER ";" "GROUP CODE : " + wtGTgpcode + " - " +  vgpname.
                EXPORT DELIMITER ";" FILL("-",100).
            END.

/*                EXPORT DELIMITER ";" "".*/
                EXPORT DELIMITER ";"  "Summary of : " + wtGTrptname + " " + wtGTacno + " - " + wtGTacname.
/*---
                EXPORT DELIMITER ";"  wtGTrptname + " Premium"          wtGTTprem   wtGTprem[1 FOR 15]. 
                EXPORT DELIMITER ";"  wtGTrptname + " Tax"                   wtGTTtax      wtGTtax[1 FOR 15].
                EXPORT DELIMITER ";"  "  - " + wtGTrptname + " [VAT]"    wtGTTvat      wtGTvat[1 FOR 15]. /* FILL(" ",LENGTH(nv_RptName)) */
                EXPORT DELIMITER ";"  "  - " + wtGTrptname + " [SBT]"    wtGTTsbt      wtGTsbt[1 FOR 15].
                EXPORT DELIMITER ";"  wtGTrptname + " Stamp"               wtGTTstamp wtGTstamp[1 FOR 15].
                EXPORT DELIMITER ";"  wtGTrptname + " Total Premium" wtGTTtotal    wtGTtotal[1 FOR 15].
                EXPORT DELIMITER ";"  wtGTrptname + " Commission"     wtGTTcomm wtGTcomm[1 FOR 15].
                EXPORT DELIMITER ";"  wtGTrptname + " Net Premium"   wtGTTnet       wtGTnet[1 FOR 15].
                 EXPORT DELIMITER ";" wtGTrptname + " Cheque Returned" wtGTTretc  wtGTretc[1 FOR 15].
                EXPORT DELIMITER ";"  wtGTrptname + " Suspense"       wtGTTsusp    wtGTsusp[1 FOR 15].
                EXPORT DELIMITER ";"  wtGTrptname + " Net. A/R"         wtGTTnetar       wtGTnetar[1 FOR 15].
                EXPORT DELIMITER ";"  wtGTrptname + " Bal. O/S"         wtGTTbal       wtGTbal[1 FOR 15].
---*/

                EXPORT DELIMITER ";"  wtGTrptname + " Premium"          wtGTTprem   wtGTprem[1 FOR 15]. 
                EXPORT DELIMITER ";"  wtGTrptname + " Commission"     wtGTTcomm wtGTcomm[1 FOR 15].
                EXPORT DELIMITER ";"  wtGTrptname + " Bal. O/S"         wtGTTbal       wtGTbal[1 FOR 15].
                EXPORT DELIMITER ";"  wtGTrptname + " Cheque Returned" wtGTTretc  wtGTretc[1 FOR 15].
                EXPORT DELIMITER ";"  wtGTrptname + " Suspense"       wtGTTsusp    wtGTsusp[1 FOR 15].
                EXPORT DELIMITER ";"  wtGTrptname + " Net. A/R"         wtGTTnetar    wtGTnetar[1 FOR 15].
                EXPORT DELIMITER ";"  wtGTrptname + " Net. OTHER"   wtGTTnetoth  wtGTnetoth[1 FOR 15].

            
                EXPORT DELIMITER ";" "Summary of : " + wtGTrptname + " " + wtGTacno
                    "Current = " + STRING(wtGTbal[1] + wtGTbal[2] ,">>,>>>,>>>,>>9.99-") + nv-1 +
                    "Over 1-3 = " + STRING(wtGTbal[3] + wtGTbal[4] + wtGTbal[5],">>,>>>,>>>,>>9.99-") + nv-1 +
                    "Over 3-6 = " + STRING(wtGTbal[6] + wtGTbal[7] + wtGTbal[8],">>,>>>,>>>,>>9.99-") + nv-1 +
                    "Over 6-9 = " + STRING(wtGTbal[9] + wtGTbal[10] + wtGTbal[11] ,">>,>>>,>>>,>>9.99-") + nv-1 +
                    "Over 9-12 = " + STRING(wtGTbal[12] + wtGTbal[13] + wtGTbal[14] ,">>,>>>,>>>,>>9.99-") + nv-1 +
                    "Over 12 = " + STRING(wtGTbal[15] ,">>,>>>,>>>,>>9.99-").
        
        END.  /* first-of(wtGTgpcode) */
        
        EXPORT DELIMITER ";"  "".
        EXPORT DELIMITER ";"  "".
        EXPORT DELIMITER ";"  "G R A N D  T O T A L".
/*---
        EXPORT DELIMITER ";"  "Grand Premium"           nv_GTTprem   nv_GTprem[1 FOR 15].
        EXPORT DELIMITER ";"  "Grand Tax"                   nv_GTTtax        nv_GTtax[1 FOR 15].
        EXPORT DELIMITER ";"  "  - Grand [VAT]"            nv_GTTvat       nv_GTvat[1 FOR 15].
        EXPORT DELIMITER ";"  "  - Grand [SBT]"            nv_GTTsbt       nv_GTsbt[1 FOR 15].
        EXPORT DELIMITER ";"  "Grand Stamp"                nv_GTTstamp nv_GTstamp[1 FOR 15].
        EXPORT DELIMITER ";"  "Grand Total Premium" nv_GTTtotal     nv_GTtotal[1 FOR 15].
        EXPORT DELIMITER ";"  "Grand Commission"     nv_GTTcomm  nv_GTcomm[1 FOR 15].
        EXPORT DELIMITER ";"  "Grand Net Premium"    nv_GTTnet      nv_GTnet[1 FOR 15].
        EXPORT DELIMITER ";"  "Grand Cheque Returned" nv_GTTretc   nv_GTretc[1 FOR 15].
        EXPORT DELIMITER ";"  "Grand Suspense"         nv_GTTsusp   nv_GTsusp[1 FOR 15].
        EXPORT DELIMITER ";"  "Grand Net. A/R"            nv_GTTnetar      nv_GTnetar[1 FOR 15].
        EXPORT DELIMITER ";"  "Grand Bal. O/S"           nv_GTTbal      nv_GTbal[1 FOR 15].
---*/

        EXPORT DELIMITER ";"  "Grand Premium"           nv_GTTprem   nv_GTprem[1 FOR 15].
        EXPORT DELIMITER ";"  "Grand Commission"     nv_GTTcomm  nv_GTcomm[1 FOR 15].
        EXPORT DELIMITER ";"  "Grand Bal. O/S"           nv_GTTbal      nv_GTbal[1 FOR 15].
        EXPORT DELIMITER ";"  "Grand Cheque Returned" nv_GTTretc   nv_GTretc[1 FOR 15].
        EXPORT DELIMITER ";"  "Grand Suspense"         nv_GTTsusp   nv_GTsusp[1 FOR 15].
        EXPORT DELIMITER ";"  "Grand Net. A/R"           nv_GTTnetar      nv_GTnetar[1 FOR 15].
        EXPORT DELIMITER ";"  "Grand Net. OTHER"     nv_GTTnetoth    nv_GTnetoth[1 FOR 15].

        EXPORT DELIMITER ";"  "".
        EXPORT DELIMITER ";" "G R A N D  T O T A L"
            "Current = " + STRING(nv_GTbal[1] + nv_GTbal[2] ,">>,>>>,>>>,>>9.99-") + nv-1 +
            "Over 1-3 = " + STRING(nv_GTbal[3] + nv_GTbal[4] + nv_GTbal[5],">>,>>>,>>>,>>9.99-") + nv-1 +
            "Over 3-6 = " + STRING(nv_GTbal[6] + nv_GTbal[7] + nv_GTbal[8],">>,>>>,>>>,>>9.99-") + nv-1 +
            "Over 6-9 = " + STRING(nv_GTbal[9] + nv_GTbal[10] + nv_GTbal[11] ,">>,>>>,>>>,>>9.99-") + nv-1 +
            "Over 9-12 = " + STRING(nv_GTbal[12] + nv_GTbal[13] + nv_GTbal[14] ,">>,>>>,>>>,>>9.99-") + nv-1 +
            "Over 12 = " + STRING(nv_GTbal[15] ,">>,>>>,>>>,>>9.99-").

    OUTPUT CLOSE.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdBranchDet C-Win 
PROCEDURE pdBranchDet :
/*------------------------------------------------------------------------------
  Purpose: Ageing Detail  By Branch
------------------------------------------------------------------------------*/

DEF VAR vCount AS INT INIT 0.
DEF VAR i AS INT.

nv-1 = FILL(" ",5).

/* delete  work-table */
FOR EACH wtGrpCode: DELETE wtGrpCode. END.
FOR EACH wtGrpSum:   DELETE wtGrpSum.  END.

    RUN pdInitDataG.  /* clear ค่า GRAND TOTAL ทั้ง file detail, summary */

    ASSIGN
        nv_reccnt = 0
        nv_next   = 1
        n_OutputFile = n_OutputFile + STRING(nv_next).

      /****** Page Header ******/
/*--- DISPLAY DETAIL  ---*/
    IF (nv_DetSum = "Detail")  OR (nv_DetSum = "All") THEN DO:
        OUTPUT TO VALUE (n_OutputFile ) NO-ECHO.
            RUN pdTitleDet.     /*RUN pdPageHead.*/
            RUN pdPageHeadDet.
        OUTPUT CLOSE.

            nv_reccnt = nv_reccnt + 5 . 
    END.  /* (nv_DetSum = "Detail")  OR (nv_DetSum = "All") */
    

/*** DISPLAY SUMMARY FILE & SUMMARY GRAND TOTAL***/
    IF (nv_DetSum = "Summary")  OR (nv_DetSum = "All") THEN DO:
        OUTPUT TO VALUE (n_OutputFileSum) NO-ECHO.  /* SUMMARY */
            RUN pdTitleSum.
            RUN pdPageHeadSum.
        OUTPUT CLOSE.
        /* A47-0264 */
        OUTPUT TO VALUE (n_OutputFileSum + "OS") NO-ECHO.  /* SUMMARY */
            RUN pdTitleSumOS.
            EXPORT DELIMITER ";"
                nv_RptName
                "Premium "
                "Comm"
                /* A47-9999 */
                "Bal. O/S (Prem + Comm)"
                "Cheque Return"
                "Suspense"
                "Net. A/r (Bal. O/S + Cheque Ret. + Sus. )"
                "Net. Other (ex. 'YP')"

                .
        OUTPUT CLOSE.
        /* end A47-0264 */
    END.  /* (nv_DetSum = "Summary")  OR (nv_DetSum = "All")  */


    loop_br:
    FOR EACH  agtprm_fil WHERE /* use-index by_acno */
              agtprm_fil.asdat    = n_asdat    AND
             (agtprm_fil.acno    >= n_frac     AND agtprm_fil.acno    <= n_toac  )   AND
             (agtprm_fil.trndat  >= n_trndatFr AND agtprm_fil.trndat  <= n_trndatTo) AND
             (agtprm_fil.polbran >= n_branch   AND agtprm_fil.polbran <= n_branch2)  AND
      (SUBSTR(agtprm_fil.policy,3,2) >= nv_poltypFr AND
      SUBSTR(agtprm_fil.policy,3,2)  <= nv_poltypTo)  AND
      ( LOOKUP (SUBSTRING(agtprm_fil.trntyp,1,1) , nv_trntyp1) <> 0 )
                        /* A47-0264 */
    NO-LOCK BREAK BY agtprm_fil.polbran 
                  BY agtprm_fil.acno
                  BY agtprm_fil.trndat
                  BY agtprm_fil.policy
                  BY agtprm_fil.endno. /*     NO-LOCK BREAK BY agtprm_fil.polbran  BY agtprm_fil.acno BY agtprm_fil.trndat. */

            DISP  agtprm_fil.polbran
                  /* agtprm_fil.acno  --- A500178 ---*/
                  agtprm_fil.acno FORMAT "X(10)"
                  agtprm_fil.trndat
                  agtprm_fil.policy
                  agtprm_fil.trntyp
                  agtprm_fil.docno
            WITH COLOR BLACK/WHITE NO-LABEL FRAME frProcess VIEW-AS DIALOG-BOX
            TITLE  "  Processing ...".

            n_asdat = IF nv_asdatAging = ? THEN n_asdat ELSE nv_asdatAging.

        /* Begin */
          /********************** Group Header *********************/
            IF FIRST-OF(agtprm_fil.polbran)  THEN DO:  /**/
                nv_bdes = "".
                FIND xmm023 WHERE xmm023.branch = agtprm_fil.polbran  NO-LOCK NO-ERROR.
                IF AVAIL xmm023 THEN nv_bdes = xmm023.bdes.

                /*--- DISPLAY DETAIL  ---*/
                IF (nv_DetSum = "Detail")  OR (nv_DetSum = "All") THEN DO:
                    /* A47-0264 */
                        {wac\wacr0604.i}
        
                        nv_reccnt = nv_reccnt + 1 .
                    /* end A47-0264 */

                    OUTPUT TO VALUE (STRING(n_OutputFile ) ) APPEND NO-ECHO.
                        EXPORT DELIMITER ";" "".
                        EXPORT DELIMITER ";"
                            "Branch  : " + agtprm_fil.polbran + " - " + nv_bdes + "  " +
                            "Type : " + agtprm_fil.type.
                    OUTPUT CLOSE.

                END.  /*  (nv_DetSum = "Detail")  OR (nv_DetSum = "All") */
    
                RUN pdInitDataTot.  /* clear data in group*/

            END. /* first-of(agtprm_fil.polbran) */

            IF FIRST-OF(agtprm_fil.acno)  THEN DO:  /**/
                nv_acname = "".
                FIND  xmm600 USE-INDEX xmm60001 WHERE
                      xmm600.acno  = agtprm_fil.acno NO-LOCK NO-ERROR.
                IF AVAIL xmm600 THEN nv_acname = TRIM(xmm600.ntitle) + " " + TRIM(xmm600.name).
                                ELSE nv_acname = agtprm_fil.ac_name.

                /*--- DISPLAY DETAIL  ---*/
                IF (nv_DetSum = "Detail")  OR (nv_DetSum = "All") THEN DO:

                    /* A47-0264 */
                        {wac\wacr0604.i}
                    /* end A47-0264 */
                    
                    OUTPUT TO VALUE (STRING(n_OutputFile ) ) APPEND NO-ECHO.
                        EXPORT DELIMITER ";"
                            "Sub Total Acno : " + agtprm_fil.acno + " - " +  nv_acname.
                    OUTPUT CLOSE.

                END.  /*  (nv_DetSum = "Detail")  OR (nv_DetSum = "All") */

                /* sub tot */
                    ASSIGN
                    /*---
                        nv_sub_prem  = 0
                        nv_sub_prem_comp =  0
                        nv_sub_stamp = 0
                        nv_sub_tax      = 0
                        nv_sub_gross = 0
                        nv_sub_comm = 0
                        nv_sub_comm_comp =  0
                        nv_sub_net  = 0
                        nv_sub_bal  = 0
                        nv_sub_netar  = 0
                        nv_sub_balDet = 0.
                     ---*/

                        nv_sub_prem  = 0
                        nv_sub_comm  = 0
                        nv_sub_bal   = 0
                     
                        nv_sub_retc   = 0
                        nv_sub_susp   = 0
                        nv_sub_netar  = 0
                        nv_sub_netoth = 0
                        
                        nv_sub_balDet = 0
                        .
                     
            END. /* first-of(agtprm_fil.acno) */


        /****** คำนวน รายละเอียดค่า และ display ใน File Detail   ใน dot i*****/
            {wac\wacr0601.i}

            ASSIGN
/*---
                nv_sub_balDet[lip] = nv_sub_balDet[lip] + nv_balA

                nv_sub_prem             = nv_sub_prem + nv_premCB      /*agtprm_fil.prem*/
                nv_sub_prem_comp =  nv_sub_prem_comp + agtprm_fil.prem_comp
                nv_sub_stamp            = nv_sub_stamp + agtprm_fil.stamp
                nv_sub_tax                 = nv_sub_tax + agtprm_fil.tax
                nv_sub_gross            = nv_sub_gross + nv_totalCB     /*agtprm_fil.gross*/
                nv_sub_comm           = nv_sub_comm +  agtprm_fil.comm
                nv_sub_comm_comp =  nv_sub_comm_comp + agtprm_fil.comm_comp
                nv_sub_net                = nv_sub_net + nv_net 
                nv_sub_bal                = nv_sub_bal + agtprm_fil.bal.
---*/
                nv_sub_prem   = nv_sub_prem + nv_premA
                nv_sub_comm   = nv_sub_comm + nv_commA
                nv_sub_bal    = nv_sub_bal  + nv_balA
                nv_sub_retc   = nv_sub_retc + nv_retcA
                nv_sub_susp   = nv_sub_susp + nv_suspA
                nv_sub_netar  = nv_sub_netar  + nv_netarA
                nv_sub_netoth = nv_sub_netoth + nv_netothA
                nv_sub_balDet[lip] = nv_sub_balDet[lip] + nv_netarA
                .

            /* Sub Total*/
            IF LAST-OF(agtprm_fil.acno)  THEN DO:  /**/
                /*--- DISPLAY DETAIL  ---*/
                IF (nv_DetSum = "Detail")  OR (nv_DetSum = "All") THEN DO:
                    /* A47-0264 */
                        {wac\wacr0604.i}
                    /* end A47-0264 */

                    OUTPUT TO VALUE (STRING(n_OutputFile ) ) APPEND NO-ECHO.  /* DISPLAY DETAIL */
                       EXPORT DELIMITER ";"  "Sub Total Acno : " + agtprm_fil.acno nv_blankH[1 FOR 9] /*10*/
                            /*---
                            nv_sub_prem
                            nv_sub_prem_comp
                            nv_sub_stamp 
                            nv_sub_tax
                            nv_sub_gross
                            nv_sub_comm 
                            nv_sub_comm_comp
                            nv_sub_net
                            nv_sub_bal
                            nv_sub_balDet[1 FOR 15].
                            ---*/
                            
                            nv_sub_prem
                            nv_sub_comm 
                            nv_sub_bal
                            nv_sub_retc
                            nv_sub_susp
                            nv_sub_netar
                            nv_sub_netoth
                            nv_sub_balDet[1 FOR 15]
                            .
                            
                    OUTPUT CLOSE.
                END.  /*  (nv_DetSum = "Detail")  OR (nv_DetSum = "All") */
                
            END.  /* last-of(agtprm_fil.acno) */

        /********************** Group Footer *********************/
          IF LAST-OF(agtprm_fil.polbran)  THEN DO:  /**/
            ASSIGN
                nv_RptTyp1 = ""
                nv_RptTyp2 = ""
                nv_RptTyp1 = agtprm_fil.polbran 
                nv_RptTyp2 = nv_bdes.

                /*** คำนวนผลรวม group,    export ข้อมูลลง SUMMARY FILE และ  คำนวน SUMMARY GRAND TOTAL***/
                    {wac\wacr0602.i}

         END. /*  LAST-OF(agtprm_fil.polbran) */
        vCount = vCount + 1.
    END. /* for each agtprm_fil*/

        /********************** Page Footer *********************/

        /*** export ข้อมูลลง DETAIL FILE บรรทัด Grand Total  และ  
                                    SUMMARY FILE บรรทัด Grand Total ***/
            {wac\wacr0603.i}

/*     RELEASE agtprm_fil. */


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdExportOld C-Win 
PROCEDURE pdExportOld :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*
DEF VAR  vCount AS INT INIT 0.
DEF VAR  i AS INT.

    ASSIGN
        nv_gtot_prem = 0
        nv_gtot_prem_comp = 0
        nv_gtot_stamp = 0
        nv_gtot_tax = 0
        nv_gtot_gross = 0
        nv_gtot_comm = 0
        nv_gtot_comm_comp = 0
        nv_gtot_bal = 0
        
        nv_gtot_wcr = 0
        nv_gtot_damt = 0
        nv_gtot_odue = 0

        nv_gtot_odue1 = 0
        nv_gtot_odue2 = 0
        nv_gtot_odue3 = 0
        nv_gtot_odue4 = 0
        nv_gtot_odue5 = 0.

    FOR EACH  agtprm_fil USE-INDEX by_acno            WHERE
              agtprm_fil.asdat       = n_asdat   AND
             (agtprm_fil.acno      >= n_frac    AND agtprm_fil.acno     <= n_toac  )      AND
             (agtprm_fil.polbran >= n_branch AND agtprm_fil.polbran <= n_branch2 ) AND
             ( LOOKUP (SUBSTRING(agtprm_fil.trntyp,1,1) , nv_trntyp1) <> 0 )
    NO-LOCK BREAK BY agtprm_fil.acno:
                                  
       DISP  agtprm_fil.acno + "  " + agtprm_fil.policy + "  " + agtprm_fil.trntyp + "  " +
                  agtprm_fil.docno  @ fiProcess  WITH FRAME  frST .
                  
        n_asdat = IF nv_asdatAging = ? THEN n_asdat ELSE nv_asdatAging.

        ASSIGN
            n_wcr  = 0
            n_damt = 0
            n_odue = 0
            n_odue1 = 0
            n_odue2 = 0
            n_odue3 = 0
            n_odue4 = 0
            n_odue5 = 0

            n_odmonth1  = 0   n_odmonth2  = 0  n_odmonth3  = 0 n_odmonth4  = 0
            n_odDay1    = 0    n_odDay2    = 0   n_odDay3    = 0   n_odDay4    = 0
            n_odat1        = ?   n_odat2        = ?  n_odat3       = ?   n_odat4         = ?.

      /*------------------ หาจำนวนวันใน 3 , 6 , 9 , 12 เดือน --------------------*/
           i = 0. 
           DO i = 0  TO 2  :   /* over due 1 - 3*/
                 n_odmonth1 = IF (MONTH(agtprm_fil.duedat ) + i )   MOD 12 = 0 THEN 1 ELSE (MONTH(agtprm_fil.duedat ) + i )   MOD 12.
                 n_odDay1 =  n_odDay1 + fuNumMonth(n_odmonth1, agtprm_fil.duedat ).
           END.
           i = 0.      
           DO i = 0  TO 5  :   /* over due 3 - 6*/
                 n_odmonth2  =  IF (MONTH(agtprm_fil.duedat ) + i )   MOD 12 = 0 THEN 1 ELSE (MONTH(agtprm_fil.duedat ) + i )   MOD 12.
                 n_odDay2 =  n_odDay2 + fuNumMonth(n_odmonth2, agtprm_fil.duedat ).
           END.
           i = 0.      
           DO i = 0  TO 8  :   /* over due 6 - 9*/
                 n_odmonth3  =  IF (MONTH(agtprm_fil.duedat ) + i )   MOD 12 = 0 THEN 1 ELSE (MONTH(agtprm_fil.duedat ) + i )   MOD 12.
                 n_odDay3 =  n_odDay3 + fuNumMonth(n_odmonth3, agtprm_fil.duedat ).
           END. 
           i = 0.
           DO i = 0  TO 11  :   /* over due 9 - 12*/
                 n_odmonth4  =  IF (MONTH(agtprm_fil.duedat ) + i )   MOD 12 = 0 THEN 1 ELSE (MONTH(agtprm_fil.duedat ) + i )   MOD 12.
                 n_odDay4 =  n_odDay4 + fuNumMonth(n_odmonth4, agtprm_fil.duedat ).
           END.
     /*-------------- duedat + จำนวนวันใน 3 , 6 , 9 , 12 เดือน   --------------*/
     ASSIGN
           n_odat1 =   agtprm_fil.duedat  +  n_odDay1  /* ได้วันที่วันสุดท้ายในช่วง*/
           n_odat2 =   agtprm_fil.duedat  + n_odDay2
           n_odat3 =   agtprm_fil.duedat  + n_odDay3
           n_odat4 =   agtprm_fil.duedat  + n_odDay4 .
     /*================== เปรียบเทียบวันที่ As Date กับ duedat & odat1-4 (over due date) ===*/
            IF /*n_day <> 0  AND*/ n_asdat <= (agtprm_fil.duedat - fuMaxDay(agtprm_fil.duedat)) THEN DO:  /* เทียบ asdate กับ  วันทีสุดท้าย  ก่อนเดือนสุดท้าย*/
                n_wcr = n_wcr + agtprm_fil.bal .                  /* with in credit  ไม่ครบกำหนดชำระ */
            END.
            IF n_asdat > (agtprm_fil.duedat - fuMaxDay(agtprm_fil.duedat)) AND n_asdat <= agtprm_fil.duedat THEN DO:   /*เทียบ asdate กับวันที่ในช่วงเดือนสุดท้าย*/
                n_damt = n_damt + agtprm_fil.bal .             /* due Amout  ครบกำหนดชำระ*/
            END.
           /*-------------------------------*/ 
            IF n_asdat > agtprm_fil.duedat AND n_asdat <= n_odat1 THEN DO:
                    n_odue1 = n_odue1 +  agtprm_fil.bal.         /*  overdue 1- 3 months*/
            END.
            IF n_asdat > n_odat1 AND n_asdat <= n_odat2 THEN DO:
                    n_odue2 = n_odue2 +  agtprm_fil.bal.         /*  overdue 3 - 6 months*/
            END.
            IF n_asdat > n_odat2 AND n_asdat <= n_odat3 THEN DO:
                    n_odue3 = n_odue3 +  agtprm_fil.bal.         /*  overdue 6 - 9 months*/
            END.
            IF n_asdat > n_odat3 AND n_asdat <= n_odat4 THEN DO:
                    n_odue4 = n_odue4 +  agtprm_fil.bal.         /*  overdue 9 - 12 months*/
            END.
            IF n_asdat > n_odat4 THEN DO:
                    n_odue5 = n_odue5 +  agtprm_fil.bal.        /*  over 12  months*/
            END.
            
            n_odue = n_odue1 + n_odue2 + n_odue3 + n_odue4 + n_odue5 .
            

        OUTPUT TO VALUE (STRING(fiFile-Name) ) APPEND NO-ECHO.
/********************** Page Header *********************/    
            IF vCount = 0 THEN DO:
                EXPORT DELIMITER ";"
                    "asdate"
                    n_asdat
                    "Aging Detail Reports By Acno"  /* "Statement A4 Reports By Acno"  */
                    "Include Type : " +  nv_trntyp1.

                EXPORT DELIMITER ";"
                    "รหัสตัวแทน"    "ชื่อ" "เครดิต" "วันที่  " "วันครบกำหนด" "เลขที่ใบแจ้งหนี้ " "กรมธรรม์" "สลักหลัง" "วันเริ่มคุ้มครอง" "ชื่อผู้เอาประกัน "
                    "เบี้ยประกัน"  "พ.ร.บ. "   "อากร"  "ภาษี"   "รวม"  "ค่านายหน้า"  "ค่านายหน้า พรบ." "ยอดค้างชำระ"  
                    "ยอดไม่ครบกำหนด" "ครบกำหนด" "รวมยอดค้างชำระเกินกำหนด" "ค้าง 1-3 เดือน "  "ค้าง 3-6 เดือน"  "ค้าง 6-9 เดือน"   "ค้าง 9-12 เดือน"  "ค้าง เกิน 12 เดือน".
                    
                EXPORT DELIMITER ";"
                     "Account No."  " name  " "credit"  "Tran Date" "duedate" " Invoice No."  " Policy No."  " Endt No."  " Com. Date "  " Insured Name "  
                     " Premium  "  " Compulsory"  " Stamp"  "Tax"  "Total"  "comm"  " comm_comp"  "Balance (Baht)"  
                     " Within"  "Due amount " "Overdue" "1 - 3 months"  "3 - 6 months"  "6 - 9 months"  " 9 - 12 months"  "over 12 months".
            END.

/********************** Group Header *********************/    
             IF FIRST-OF(agtprm_fil.acno)  THEN DO:  /**/
                EXPORT DELIMITER ";"
                    "Acno : " + agtprm_fil.acno
                    agtprm_fil.ac_name
                    agtprm_fil.credit
                    "Credit Limit " + STRING(agtprm_fil.odue6,"->>>,>>>,>>>,>>9.99").    /*xmm600.ltamt   Credit Limit*/

                ASSIGN
                    nv_tot_prem = 0
                    nv_tot_prem_comp = 0
                    nv_tot_stamp = 0
                    nv_tot_tax = 0
                    nv_tot_gross = 0
                    nv_tot_comm = 0
                    nv_tot_comm_comp = 0
                    nv_tot_bal = 0

                    nv_tot_wcr = 0
                    nv_tot_damt = 0
                    nv_tot_odue = 0

                    nv_tot_odue1 = 0
                    nv_tot_odue2 = 0
                    nv_tot_odue3 = 0
                    nv_tot_odue4 = 0
                    nv_tot_odue5 = 0.
             END.
             
/********************** DETAIL *********************/    
                EXPORT DELIMITER ";"
                    agtprm_fil.acno
                    agtprm_fil.ac_name
                    agtprm_fil.credit
                    agtprm_fil.trndat
                    agtprm_fil.duedat
                    agtprm_fil.trntyp + " " +  agtprm_fil.docno
                    agtprm_fil.policy
                    agtprm_fil.endno
                    agtprm_fil.comdat
                    agtprm_fil.insure
                    agtprm_fil.prem
                    agtprm_fil.prem_comp
                    agtprm_fil.stamp
                    agtprm_fil.tax
                    agtprm_fil.gross
                    agtprm_fil.comm
                    agtprm_fil.comm_comp
                    agtprm_fil.bal
                    n_wcr
                    n_damt
                    n_odue
                    n_odue1
                    n_odue2 
                    n_odue3
                    n_odue4
                    n_odue5.

/********************** Group Footer *********************/    
                ASSIGN
                /* TOTAL */
                    nv_tot_prem             = nv_tot_prem + agtprm_fil.prem
                    nv_tot_prem_comp =  nv_tot_prem_comp + agtprm_fil.prem_comp
                    nv_tot_stamp            = nv_tot_stamp + agtprm_fil.stamp
                    nv_tot_tax                 = nv_tot_tax + agtprm_fil.tax
                    nv_tot_gross            = nv_tot_gross + agtprm_fil.gross
                    nv_tot_comm           = nv_tot_comm +  agtprm_fil.comm
                    nv_tot_comm_comp =  nv_tot_comm_comp + agtprm_fil.comm_comp
                    nv_tot_bal                = nv_tot_bal + agtprm_fil.bal

                    nv_tot_wcr          = nv_tot_wcr + n_wcr
                    nv_tot_damt       = nv_tot_damt + n_damt
                    nv_tot_odue     = nv_tot_odue + n_odue
                                        
                    nv_tot_odue1     = nv_tot_odue1 + n_odue1
                    nv_tot_odue2      = nv_tot_odue2 + n_odue2
                    nv_tot_odue3      = nv_tot_odue3 + n_odue3
                    nv_tot_odue4     = nv_tot_odue4 + n_odue4
                    nv_tot_odue5     = nv_tot_odue5 + n_odue5.

             IF LAST-OF(agtprm_fil.acno)  THEN DO:  /**/
                EXPORT DELIMITER ";"
                    "TOTAL : " + agtprm_fil.acno
                    " "    " "   " "     " " 
                    " "    " "    " "   " "   " "
                    nv_tot_prem
                    nv_tot_prem_comp
                    nv_tot_stamp
                    nv_tot_tax
                    nv_tot_gross
                    nv_tot_comm
                    nv_tot_comm_comp
                    nv_tot_bal

                    nv_tot_wcr
                    nv_tot_damt
                    nv_tot_odue

                    nv_tot_odue1
                    nv_tot_odue2
                    nv_tot_odue3
                    nv_tot_odue4
                    nv_tot_odue5.

               /* GRAND TOTAL*/
               ASSIGN
                    nv_gtot_prem             = nv_gtot_prem +  nv_tot_prem
                    nv_gtot_prem_comp =  nv_gtot_prem_comp + nv_tot_prem_comp
                    nv_gtot_stamp            = nv_gtot_stamp + nv_tot_stamp
                    nv_gtot_tax                 = nv_gtot_tax + nv_tot_tax
                    nv_gtot_gross            = nv_gtot_gross + nv_tot_gross
                    nv_gtot_comm           = nv_gtot_comm + nv_tot_comm
                    nv_gtot_comm_comp =  nv_gtot_comm_comp + nv_tot_comm_comp
                    nv_gtot_bal                = nv_gtot_bal + nv_tot_bal

                    nv_gtot_wcr          = nv_gtot_wcr + nv_tot_wcr
                    nv_gtot_damt       = nv_gtot_damt + nv_tot_damt
                    nv_gtot_odue     = nv_gtot_odue + nv_tot_odue

                    nv_gtot_odue1     = nv_gtot_odue1 + nv_tot_odue1
                    nv_gtot_odue2      = nv_gtot_odue2 + nv_tot_odue2
                    nv_gtot_odue3      = nv_gtot_odue3 + nv_tot_odue3
                    nv_gtot_odue4     = nv_gtot_odue4 + nv_tot_odue4
                    nv_gtot_odue5     = nv_gtot_odue5 + nv_tot_odue5.

             END.

                    vCount = vCount + 1.

        OUTPUT CLOSE.

    END. /* for each agtprm_fil*/

    OUTPUT TO VALUE (STRING(fiFile-Name) ) APPEND NO-ECHO.
            EXPORT DELIMITER ";"
                "GRAND TOTAL : " + agtprm_fil.acno
                " "    " "   " "     " " 
                " "    " "    " "   " "   " "
                nv_gtot_prem
                nv_gtot_prem_comp
                nv_gtot_stamp
                nv_gtot_tax
                nv_gtot_gross
                nv_gtot_comm
                nv_gtot_comm_comp
                nv_gtot_bal

                nv_gtot_wcr
                nv_gtot_damt
                nv_gtot_odue
                
                nv_gtot_odue1
                nv_gtot_odue2
                nv_gtot_odue3
                nv_gtot_odue4
                nv_gtot_odue5.
    OUTPUT CLOSE.

*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdForGrpCode C-Win 
PROCEDURE pdForGrpCode :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

DEF BUFFER bxmm600 FOR xmm600.
DEF VAR vgpname AS CHAR.

    FOR EACH wtGrpCode: DELETE wtGrpCode. END.

    FOR EACH xmm600 USE-INDEX xmm60001 
      WHERE (xmm600.acno >= n_frac) AND (xmm600.acno <= n_toac) AND
            (xmm600.acccod = "AG")  OR (xmm600.acccod  = "BR"  )
    NO-LOCK:
    
        FIND FIRST bxmm600 USE-INDEX xmm60001 
             WHERE bxmm600.acno = xmm600.gpage NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL bxmm600 THEN vgpname = bxmm600.name.  /* ชื่อ พนักงาน การเงิน */
                         ELSE vgpname = "".
                    
        CREATE wtGrpCode.
        ASSIGN
            wtGrpCode.wtGpage  = xmm600.gpage
            wtGrpCode.wtGpname = vgpname
            wtGrpCode.wtacno   = xmm600.acno
            wtGrpCode.wtname   = xmm600.name.

    END.  /* for each xmm600*/


    OUTPUT TO VALUE (n_OutputFile + "G") .

        EXPORT DELIMITER ";"
            "Group Code" "Name" "Acno" "Ac. Name".

        FOR EACH wtGrpCode USE-INDEX wtGrpCode1 :
            EXPORT DELIMITER ";" wtGrpCode.
        END.

    OUTPUT CLOSE.

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
        DO WITH FRAME frST :
            ASSIGN 
                fiBranch2  = xmm023.branch
                fibdes2     = xmm023.bdes.
             DISP fiBranch2 fibdes2 .
         END.
    END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdInitDataG C-Win 
PROCEDURE pdInitDataG :
/*------------------------------------------------------------------------------
  Purpose:      use in Procedure pdAcnoDet, pdBranchDet, pdLineDet :
  Parameters:  <none>
  Notes:       clear ค่า grand total
------------------------------------------------------------------------------*/

    ASSIGN
/*--- In File Detail ---*/
        nv_gtot_prem = 0
        nv_gtot_prem_comp = 0
        nv_gtot_stamp = 0
        nv_gtot_tax   = 0
        nv_gtot_gross = 0
        nv_gtot_comm  = 0
        nv_gtot_comm_comp = 0
        nv_gtot_net   = 0
        nv_gtot_netar = 0
        nv_gtot_bal   = 0
        
        nv_gtot_wcr   = 0
        nv_gtot_damt  = 0
        nv_gtot_odue1 = 0
        nv_gtot_odue2 = 0
        nv_gtot_odue3 = 0
        nv_gtot_odue4 = 0
        nv_gtot_odue5 = 0

        nv_gtot_balDet = 0
        
        nv_gtot_retc   = 0
        nv_gtot_susp   = 0
        nv_gtot_netoth = 0

/*--- In File Summary ---*/     /*---  Initial Value array [i] ---*/
        nv_GTprem  = 0
        nv_GTtax   = 0
        nv_GTvat   = 0
        nv_GTsbt   = 0
        nv_GTstamp = 0
        nv_GTtotal = 0
        nv_GTcomm  = 0
        nv_GTnet   = 0
        nv_GTbal   = 0

        nv_GTretc  = 0
        nv_GTsusp  = 0
        nv_GTnetar = 0
        nv_GTnetoth = 0

        nv_GTTprem   = 0
        nv_GTTtax    = 0
        nv_GTTvat    = 0
        nv_GTTsbt    = 0
        nv_GTTstamp  = 0
        nv_GTTtotal  = 0
        nv_GTTcomm   = 0
        nv_GTTnet    = 0
        nv_GTTbal    = 0

        nv_GTTretc   = 0
        nv_GTTsusp   = 0
        nv_GTTnetar  = 0
        nv_GTTnetoth = 0
        .

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdInitDataTot C-Win 
PROCEDURE pdInitDataTot :
/*------------------------------------------------------------------------------
  Purpose:      use in Procedure pdAcnoDet, pdBranchDet, pdLineDet :
  Parameters:  <none>
  Notes:       clear ค่า summary
------------------------------------------------------------------------------*/
        ASSIGN
     /*---  Initial Value total ใน  file summary   ---*/
        nv_tot_prem      = 0
        nv_tot_prem_comp = 0
        nv_tot_stamp     = 0
        nv_tot_tax       = 0 
        nv_tot_gross     = 0 
        nv_tot_comm      = 0 
        nv_tot_comm_comp = 0
        nv_tot_net       = 0
        nv_tot_bal       = 0
        nv_tot_retc      = 0 
        nv_tot_susp      = 0 
        nv_tot_netar     = 0 
        nv_tot_netoth    = 0
        nv_tot_balDet    = 0
             
     /*---  Initial Value array [i] ผลรวมใน file summary    "Summary of : " ---*/
        nv_Tprem         = 0
        nv_Ttax          = 0
        nv_Tvat          = 0
        nv_Tsbt          = 0
        nv_Tstamp        = 0
        nv_Ttotal        = 0
        nv_Tcomm         = 0
        nv_Tnet          = 0
        nv_Tbal          = 0
        nv_Tretc         = 0
        nv_Tsusp         = 0
        nv_Tnetar        = 0
        nv_Tnetoth       = 0
        nv_TTprem        = 0
        nv_TTtax         = 0
        nv_TTvat         = 0
        nv_TTsbt         = 0
        nv_TTstamp       = 0
        nv_TTtotal       = 0
        nv_TTcomm        = 0
        nv_TTnet         = 0
        nv_TTbal         = 0
        nv_TTretc        = 0
        nv_TTsusp        = 0
        nv_TTnetar       = 0
        nv_TTnetoth      = 0
        .


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdLineDet C-Win 
PROCEDURE pdLineDet :
/*------------------------------------------------------------------------------
  Purpose: Ageing Detail  By Line
------------------------------------------------------------------------------*/

DEF VAR  vCount AS INT INIT 0.
DEF VAR  i AS INT.

nv-1 = FILL(" ",5).

/* delete  work-table */
FOR EACH wtGrpCode: DELETE wtGrpCode. END.
FOR EACH wtGrpSum:   DELETE wtGrpSum.  END.

    RUN pdInitDataG.  /* clear ค่า GRAND TOTAL ทั้ง file detail ,  summary */

    ASSIGN
        nv_reccnt = 0
        nv_next   = 1
        n_OutputFile = n_OutputFile + STRING(nv_next).

      /**************** Page Header ***********/
/*--- DISPLAY DETAIL  ---*/
    IF (nv_DetSum = "Detail")  OR (nv_DetSum = "All") THEN DO:
        OUTPUT TO VALUE (n_OutputFile ) NO-ECHO.
            RUN pdTitleDet.     /*RUN pdPageHead.*/
            RUN pdPageHeadDet.
        OUTPUT CLOSE.
            nv_reccnt = nv_reccnt + 5 .
    END.  /* (nv_DetSum = "Detail")  OR (nv_DetSum = "All") */
    

/*** DISPLAY SUMMARY FILE & SUMMARY GRAND TOTAL***/
    IF (nv_DetSum = "Summary")  OR (nv_DetSum = "All") THEN DO:
        OUTPUT TO VALUE (n_OutputFileSum) NO-ECHO.  /* SUMMARY */
            RUN pdTitleSum.
            RUN pdPageHeadSum.
        OUTPUT CLOSE.

        /* A47-0264 */
        OUTPUT TO VALUE (n_OutputFileSum + "OS") NO-ECHO.  /* SUMMARY */
            RUN pdTitleSumOS.
            EXPORT DELIMITER ";"
                nv_RptName
                "Premium "
                "Comm"
                /* A47-9999 */
                "Bal. O/S (Prem + Comm)"
                "Cheque Return"
                "Suspense"
                "Net. A/r (Bal. O/S + Cheque Ret. + Sus. )"
                "Net. Other (ex. 'YP')"
                .

                .
        OUTPUT CLOSE.
        /* end A47-0264 */

    END.  /* (nv_DetSum = "Summary")  OR (nv_DetSum = "All")  */

    loop_li :
    FOR EACH  agtprm_fil WHERE /* use-index by_acno */
              agtprm_fil.asdat    = n_asdat    AND
             (agtprm_fil.acno    >= n_frac     AND agtprm_fil.acno    <= n_toac  )   AND
             (agtprm_fil.trndat  >= n_trndatFr AND agtprm_fil.trndat  <= n_trndatTo) AND
             (agtprm_fil.polbran >= n_branch   AND agtprm_fil.polbran <= n_branch2)  AND
      (SUBSTR(agtprm_fil.policy,3,2) >= nv_poltypFr  AND
       SUBSTR(agtprm_fil.policy,3,2) <= nv_poltypTo) AND
      (LOOKUP (SUBSTRING(agtprm_fil.trntyp,1,1) , nv_trntyp1) <> 0 )
                        /* A47-0264 */
    NO-LOCK BREAK BY SUBSTRING(agtprm_fil.policy,3,2)
                  BY agtprm_fil.trndat
                  BY agtprm_fil.policy.

            DISP  SUBSTRING(agtprm_fil.policy,3,2) 
                  /* agtprm_fil.acno  --- A500178 ---*/
                  agtprm_fil.acno FORMAT "X(10)"
                  agtprm_fil.trndat
                  agtprm_fil.policy
                  agtprm_fil.trntyp
                  agtprm_fil.docno
             WITH COLOR BLACK/WHITE NO-LABEL FRAME frProcess VIEW-AS DIALOG-BOX
             TITLE  "  Processing ...".

             n_asdat = IF nv_asdatAging = ? THEN n_asdat ELSE nv_asdatAging.


            /* Begin */
           /********************** Group Header *********************/
             IF FIRST-OF(SUBSTRING(agtprm_fil.policy,3,2))  THEN DO:  /**/

                nv_Linedes = "".
                FIND xmm031 WHERE SUBSTR(xmm031.poltyp,2,2) = SUBSTRING(agtprm_fil.policy,3,2) NO-LOCK NO-ERROR.
                IF AVAIL xmm031 THEN nv_LineDes = TRIM(xmm031.poldes).

                /*--- DISPLAY DETAIL  ---*/
                IF (nv_DetSum = "Detail")  OR (nv_DetSum = "All") THEN DO:

                    /* A47-0264 */
                        {wac\wacr0604.i}
        
                        nv_reccnt = nv_reccnt + 1 .
                    /* end A47-0264 */

                    OUTPUT TO VALUE (STRING(n_OutputFile ) ) APPEND NO-ECHO.
                        EXPORT DELIMITER ";" "".
                        EXPORT DELIMITER ";"
                            "Line : " + SUBSTRING(agtprm_fil.policy,3,2) + " - " + nv_Linedes + "  " +
                            "Type : " + agtprm_fil.type.
                    OUTPUT CLOSE.
    
                END.  /*  (nv_DetSum = "Detail")  OR (nv_DetSum = "All") */

                RUN pdInitDataTot.  /* clear data in group*/

             END.  /* first-of(SUBSTRING(agtprm_fil.policy,3,2)) */

        /****** คำนวน รายละเอียดค่า และ display ใน File Detail   ใน dot i*****/
            {wac\wacr0601.i}
.

        /********************** Group Footer *********************/
         IF LAST-OF(SUBSTRING(agtprm_fil.policy,3,2))  THEN DO:  /**/
            ASSIGN
                nv_RptTyp1 = ""
                nv_RptTyp2 = ""
                nv_RptTyp1 = SUBSTRING(agtprm_fil.policy,3,2)  /* เปลี่ยนไปตาม ชนิดของ report */
                nv_RptTyp2 = nv_Linedes.

                /*** คำนวนผลรวม group, export ข้อมูลลง SUMMARY FILE และ  คำนวน SUMMARY GRAND TOTAL***/
                    {wac\wacr0602.i}
        
         END. /*  LAST-OF(SUBSTRING(agtprm_fil.policy,3,2)) */

            vCount = vCount + 1.
    END. /* for each agtprm_fil*/

        /********************** Page Footer *********************/

        /*** export ข้อมูลลง DETAIL FILE บรรทัด Grand Total  และ  
                                    SUMMARY FILE บรรทัด Grand Total ***/
            {wac\wacr0603.i}

    RELEASE agtprm_fil.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdPageHead C-Win 
PROCEDURE pdPageHead :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

nv_blankH = FILL(" " , 15).

/********************** Page Header *********************/
/* ส่วนหัวเอกสาร ลง file : Detail */

    /* line 1*/
EXPORT DELIMITER ";"
    "From : " + n_frac + " To " + n_toac
    nv_blankH[1 FOR 14]       /* ใส่ ช่องว่าง  14 ช่อง*/
    "SAFETY INSURANCE PUBLIC COMPANY LIMITED"
    nv_blankH[1 FOR 14]
    "RUN DATE : " + STRING(TODAY,"99/99/9999").

    /* line 2*/
EXPORT DELIMITER ";"
    "Branch : " + n_Branch + " To " + n_Branch2
     nv_blankH[1 FOR 14]
    "Ageing Report By " + nv_RptName + " " + nv_RptName2
     nv_blankH[1 FOR 14]
    "RUN TIME : " + STRING(TIME,"HH:MM:SS").
    
    /* line 3*/
EXPORT DELIMITER ";"
    "Tran. Date : " + STRING(n_trndatfr,"99/99/9999") + " To " + STRING(n_trndatto,"99/99/9999")
     nv_blankH[1 FOR 14]
    "As Of  Date : " + STRING(n_asdat,"99/99/9999")
     nv_blankH[1 FOR 14]
    "Program Name : wacr05.w".

END PROCEDURE.





/*------------------------------------------------------------------------------- Old */
/*



nv-1 = FILL(" ", 202).
nv_blankH = FILL(" " , 15).

/********************** Page Header *********************/
/* ส่วนหัวเอกสาร ลง file : Detail */

    /* line 1*/
EXPORT DELIMITER ";"
    "From : " + n_frac + " To " + n_toac
    nv-1  /*       nv_blankH[1 FOR 14]       /* ใส่ ช่องว่าง  14 ช่อง*/*/
    "SAFETY INSURANCE PUBLIC COMPANY LIMITED"
    nv-1
    "RUN DATE : " + STRING(TODAY,"99/99/9999").


    /* line 2*/
EXPORT DELIMITER ";"
    "Branch : " + n_Branch + " To " + n_Branch2
     nv-1
    "Ageing Report By " + nv_RptName + " " + nv_RptName2
     nv-1
    "RUN TIME : " + STRING(TIME,"HH:MM:SS").
    
    /* line 3*/
EXPORT DELIMITER ";"
    "Tran. Date : " + STRING(n_trndatfr,"99/99/9999") + " To " + STRING(n_trndatto,"99/99/9999")
     nv-1
    "As Of  Date : " + STRING(n_asdat,"99/99/9999")
     nv-1
    "Program Name : wacr05.w".
    

*/

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdPageHeadDet C-Win 
PROCEDURE pdPageHeadDet :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

EXPORT DELIMITER ";"
    "Account No."  "Account Name  " "Branch" "Credit Term"  "Tran Date" "Due Date" " Invoice No."  " Policy No."  " Endt No."  " Com. Date "  /*" Insured Name "*/  
/*    "Premium  "  " Compulsory"  " Stamp"  "Tax"  "Total"  "Comm."  " Comm_comp" "Net amount"  "Balance (Baht)"*/

     "Premium  "   "Comm."  "Balance (Baht)"
     "Cheque Returned"   "Suspense"  "Net A/R" "Net Other" 
    "Within"  "Due amount"
    "1 month"
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
    "over 12 months".

END PROCEDURE.


/*
    "1 - 3 months"  "3 - 6 months"  "6 - 9 months"  " 9 - 12 months"  "over 12 months".


*/

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdPageHeadSum C-Win 
PROCEDURE pdPageHeadSum :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

EXPORT DELIMITER ";"
    "Summary Type"
    "Total"
    "Within"
    "Due amount"
    
    "1 month"
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
    "over 12 months".

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdTitleDet C-Win 
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
    nv_blankH[1 FOR 14]       /* ใส่ ช่องว่าง  14 ช่อง*/
    "SAFETY INSURANCE PUBLIC COMPANY LIMITED"
    nv_blankH[1 FOR 14]
    "Run Date : " + STRING(TODAY,"99/99/9999") + "  " + "Run Time : " + STRING(TIME,"HH:MM:SS").

    /* line 2*/
EXPORT DELIMITER ";"
    "Branch : " + n_Branch + " To " + n_Branch2
     nv_blankH[1 FOR 14]
    "Ageing Report By " + nv_RptName + " " + nv_RptName2
     nv_blankH[1 FOR 14]
    "Include Type : " + nv_trntyp1.
    
    /* line 3*/
EXPORT DELIMITER ";"
    "Tran. Date : " + STRING(n_trndatfr,"99/99/9999") + " To " + STRING(n_trndatto,"99/99/9999")
     nv_blankH[1 FOR 14]
    "As Of  Date : " + STRING(nv_asdatAging,"99/99/9999")
     nv_blankH[1 FOR 14]
    "Program Name : wacr05.w".

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdTitleSum C-Win 
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
    nv_blankH[1 FOR 5]       /* ใส่ ช่องว่าง  5 ช่อง*/
    "SAFETY INSURANCE PUBLIC COMPANY LIMITED"
    nv_blankH[1 FOR 6]
    "Run Date : " + STRING(TODAY,"99/99/9999") + "  " + "Run Time : " + STRING(TIME,"HH:MM:SS").

    /* line 2*/
EXPORT DELIMITER ";"
    "Branch : " + n_Branch + " To " + n_Branch2
     nv_blankH[1 FOR 5]
    "Ageing Report By " + nv_RptName + " " + nv_RptName2
     nv_blankH[1 FOR 6]
    "Include Type : " + nv_trntyp1.    

    /* line 3*/
EXPORT DELIMITER ";"
    "Tran. Date : " + STRING(n_trndatfr,"99/99/9999") + " To " + STRING(n_trndatto,"99/99/9999")
     nv_blankH[1 FOR 5]
    "As Of  Date : " + STRING(nv_asdatAging,"99/99/9999")
     nv_blankH[1 FOR 6]
    "Program Name : wacr05.w".

END PROCEDURE.

/*
            EXPORT DELIMITER ";" "Grand"
                "Current = " + STRING(nv_GTbal[1] + nv_GTbal[2] ,">>,>>>,>>>,>>9.99-") + nv-1 +
                "Over 1-3 = " + STRING(nv_GTbal[3] + nv_GTbal[4] + nv_GTbal[5],">>,>>>,>>>,>>9.99-") + nv-1 +
                "Over 3-6 = " + STRING(nv_GTbal[6] + nv_GTbal[7] + nv_GTbal[8],">>,>>>,>>>,>>9.99-") + nv-1 +
                "Over 6-9 = " + STRING(nv_GTbal[9] + nv_GTbal[10] + nv_GTbal[11] ,">>,>>>,>>>,>>9.99-") + nv-1 +
                "Over 9-12 = " + STRING(nv_GTbal[12] + nv_GTbal[13] + nv_GTbal[14] ,">>,>>>,>>>,>>9.99-") + nv-1 +
                "Over 12 = " + STRING(nv_GTbal[15] ,">>,>>>,>>>,>>9.99-").
*/

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdTitleSumOS C-Win 
PROCEDURE pdTitleSumOS :
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
    "SAFETY INSURANCE PUBLIC COMPANY LIMITED"
    "Run Date : " + STRING(TODAY,"99/99/9999") + "  " + "Run Time : " + STRING(TIME,"HH:MM:SS").

    /* line 2*/
EXPORT DELIMITER ";"
    "Branch : " + n_Branch + " To " + n_Branch2
    "Ageing Report By " + nv_RptName + " " + nv_RptName2
    "Include Type : " + nv_trntyp1.    

    /* line 3*/
EXPORT DELIMITER ";"
    "Tran. Date : " + STRING(n_trndatfr,"99/99/9999") + " To " + STRING(n_trndatto,"99/99/9999")
    "As Of  Date : " + STRING(nv_asdatAging,"99/99/9999")
    "Program Name : wacr05.w".

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdUpdateQ C-Win 
PROCEDURE pdUpdateQ :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

OPEN QUERY brAcproc_fil
    FOR EACH Acproc_fil  WHERE (acproc_fil.type = "01" OR acproc_fil.type = "05" ) AND
      SUBSTRING(acProc_fil.enttim,10,3) <>  "NO"
             BY acproc_fil.asdat DESC  .

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE ProcGetPrtList C-Win 
PROCEDURE ProcGetPrtList :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*
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

*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE ProcGetRptList C-Win 
PROCEDURE ProcGetRptList :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*
DEF VAR report-list   AS CHARACTER.
DEF VAR report-count  AS INTEGER.
DEF VAR report-number AS INTEGER.

  RUN _getname (SEARCH (report-library), OUTPUT report-list,        /* aderb/_getname.p */
    OUTPUT report-count).
  
  IF report-count = 0 THEN RETURN NO-APPLY.

  DO WITH FRAME frST :
        ASSIGN
          cbRptList:List-Items = report-list
          report-number = LOOKUP (report-name,report-list)
          cbRptList     = IF report-number > 0 THEN ENTRY (report-number,report-list)
                                  ELSE ENTRY (1, report-list).    
  
       DISP cbRptList . 
  END.
 
*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

/* ************************  Function Implementations ***************** */

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fuMaxDay C-Win 
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fuNumMonth C-Win 
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fuNumYear C-Win 
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

