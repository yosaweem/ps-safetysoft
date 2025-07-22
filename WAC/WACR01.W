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
/*  Notes: หลักการนับยอดที่อยู่ในเครดิต และ ค้างชำระ STATEMENT (A4)
              -  นำ Tran Date มา  ยึดวันที่ 1 ของเดือนถัดไป เริ่มนับระยะเวลาให้ credit 
              - นำ  วันที่ 1 ของเดือนถัดไป  +  credit term( 30 วัน = 1 เดือน )   แล้วจะได้ระยะเวลาสิ้นสุด การให้  credit
                ข่อง within Credit คือ กรมธรรม์ที่อยู่ก่อน เดือนครบกำหนดชำระ
                       due Amount คือ กรมธรรม์ของเดือนครบกำหนดชำระ
                       overdue   คือ กรมธรรม์ที่เกินกำหนด
                 กรณี credit Term =  0  กรมธรรม์จะ overdue
              -  จากนั้นนำวันที่สิ้นสุดการให้  credit  ไปหา วันที่ช่วงระยะเวลาการค้างชำระ  ทุกช่วง
              - ได้วันที่ในแต่ละช่วงแล้วจึงนำ   As date มาเทียบ  จากนั้นจึงนำไปเก็บ ในตัวแปรต่าง ๆ  แล้วแสดงผลต่อไป*/

/* CREATE BY :  Kanchana C.        A44-0233*/
/* Modify By : Kanchana C.             A44-0233  
    03/07/2002 "ห้ามแก้ asdate " 
    08/07/2002 "แก้ ตอนลบข้อมูลกรณี asdat เดียวกัน จาก by_trndat_acno  ไปเป็น by_acno */
/* Modify By : Kanchana C.             04/11/2002 
    - เพิ่ม process date เก็บลง entrdat */
/* Modify By : Kanchana C.             A46-0015    09/01/2003
    - เพิ่ม Process  trnty1  = "O", "T"     (Inward Policy)
        ชื่อโปรแกรม  เดิม     wacr01.w     - "PROCESS PREMIUM STATEMENT (A4)"
        แยกโปรแกรมออกเป็น wacr0101.w - "PROCESS PREMIUM STATEMENT (A4) DAILY"
    - เก็บ process complete   ที่  SUBSTRING(acProc_fil.enttim,10,3)  = "YES" 
*/
/* Modify By : KuK         A46-0130     18/04/2003 
    เพิ่ม Title ให้ชื่อ agtprm_fil.ac_name ในการ Process */
/* Modify : Kanchana C.  07/05/2003    Assign No.  :   A46-0142
    2. ปรับข้อมูล     การคิด บ/ช พัก     type YS, ZS   และ ลูกหนี้ เช็คคืน  type C, B      ไม่มีการคิด credit term
        duedat = trandat  (แก้ในส่วนโปรแกรม process statement a4    program name : wacr01.w , wacr0101.w)
*/      
/* Modify : Kanchana C.  23/03/2004    Assign No.  :   A47-0108
    - Fix เงื่อนไขไว้ในโปรแกรม ถ้า วันที่ Contra date  มีปี ที่เริ่มต้นมากกว่า 2  และ Bal = 0 แล้วแล้ว ไม่ต้องดึงรายออกมา  (อาจมีการระบุ contra date เกินจริง)*/
/* Modify : Kanchana C.  21/04/2004    Assign No.  :   A47-0142
    - ปรับ Process Statement  A4 
    1. กรณีที่ไม่มีหมายเลข ก/ธ  ไม่ต้อง  ไปหาค่าทางฝั่ง uw   (เนื่องจาก ทางฝั่ง  UW  มีข้อมูลที่  ก/ธ  เป็นช่องว่าง   ซึ่งมี Br.  ที่ ก/ธ  เป็น Br.  0)
    2. ใช้ client type code   ตาม   xmm600.clicod
*/

/* Modify : Kanchana C.         23/09/2004  ASSIGN NO : A47-0370
    แก้การหา Branch  ถ้า field policy มีค่า  จะไปหาที่ substring(uwm100.policy,2,1)
                                      ถ้าไม่มี      agtprm_fil.polbran = acm001.branch

*/

/* โปรแกรมที่ใช่ร่วมกัน*/
Wac
        -Wacr01.w             /* PROCESS PREMIUM STATEMENT (A4) */
                                       /*  ใช้ Warc02.w สั่ง print  PRINT PREMIUM STATEMENT (A4)*/
Whp
        -WhpAcno.w
Wut
        -WutDiCen.p
        -WutWiCen.p
------------------------------------------------------------------------- 
 Modify By : TANTAWAN C.   08/11/2007   [A500178]
             ปรับ format branch เพื่อรองรับการขยายสาขา
             ยขยาย format fiacno1 จาก "X(7)" เป็น  Char "X(10)"  
                          fiacno2 จาก "X(7)" เป็น  Char "X(10)" 
             เปลี่ยนมาใช้ branch ที่ฟิลด์ uwm100.branch ไม่ต้อง substring                          

Modify By : Sayamol N.   23/04/2010   (A53-0159)
           1) แยก Motor / Non Motor
           2) Motor Credit Term ให้นับตาม CBC 
           3) Non-Motor  Credit Term  ตามระบบโดยนับตาม Comdate              
Modify By : Sayamol N. 15/10/10  (A53-0159)
          - ดึงข้อมูล Endt.Date จาก acm001.ac7[14]   
Modify By : Nattanicha N. 12/12/2013 [A56-0047]
          - ปรับ loop การ Create Data ที่ agtprm_fil , acproc_fil
          - เพิ่มคำสั่ง Release Table
Modify By : Nattanicha N.  15/06/2015  (A57-0401)
          - Calc by Trndat for NZI (Br. 90-98)  
Modify By : Nattanicha, Benjaporn [A59-0153] 09/06/2016
          - เพิ่มเงื่อนไขระบบป้องกันหนี้ค้างเกินวงเงิน (Credit limit)    
Modify By : Nattanicha, Chonlatis [A60-0358]  13/11/2017
          - Set Transaction Date From  01/01/2011   จากเดิม ปี 1988  
          - ปรับ Loop Process ให้เร็วขึ้น  
Modify By : Nattanicha K. [A61-0158]  15/03/2018
          -  กรณีสลักหลัง ให้เอาวัน trans.date มาคำนวณ 
Modify by : Ranu I. A61-0035 24/08/2018  ปรับหน้าจอ Update code 
Modify by : Chaiyong W. A67-0066 31/01/2025 Change index to Correct 
-------------------------------------------------------------------------
*****************************************/    
/* ***************************  Definitions  ************************** */
DEF  SHARED VAR n_User    AS CHAR.
DEF  SHARED VAR n_Passwd  AS CHAR.  
/*DEF      VAR   nv_User     AS CHAR NO-UNDO. 
 * DEF      VAR   nv_pwd    LIKE _password NO-UNDO.*/

/* Definitons  Report -------                                               */
DEF  VAR report-library AS CHAR INIT "wAC/wprl/wac_sm01.prl".
DEF  VAR report-name    AS CHAR INIT "Statement of Account By Trandate".

DEF  VAR RB-DB-CONNECTION     AS CHAR INIT "".
DEF  VAR RB-INCLUDE-RECORDS   AS CHAR INIT "O". /*Can Override Filter*/
DEF  VAR RB-FILTER            AS CHAR INIT "".
DEF  VAR RB-MEMO-FILE         AS CHAR INIT "".
DEF  VAR RB-PRINT-DESTINATION AS CHAR INIT "?". /*Direct to Screen*/
DEF  VAR RB-PRINTER-NAME      AS CHAR INIT "".
DEF  VAR RB-PRINTER-PORT      AS CHAR INIT "".
DEF  VAR RB-OUTPUT-FILE       AS CHAR INIT "".
DEF  VAR RB-NUMBER-COPIES     AS INTE INIT 1.
DEF  VAR RB-BEGIN-PAGE        AS INTE INIT 0.
DEF  VAR RB-END-PAGE          AS INTE INIT 0.
DEF  VAR RB-TEST-PATTERN      AS LOG INIT no.
DEF  VAR RB-WINDOW-TITLE      AS CHAR INIT "".
DEF  VAR RB-DISPLAY-ERRORS    AS LOG INIT yes.
DEF  VAR RB-DISPLAY-STATUS    AS LOG INIT yes.
DEF  VAR RB-NO-WAIT           AS LOG INIT no.
DEF  VAR RB-OTHER-PARAMETERS  AS CHAR INIT "".

/* Parameters Definitions ---                                           */
DEF NEW SHARED VAR n_agent1   AS CHAR FORMAT "x(7)".
DEF NEW SHARED VAR n_agent2   AS CHAR FORMAT "x(7)".
DEF NEW SHARED VAR n_branch   AS CHAR FORMAT "x(2)".
DEF NEW SHARED VAR n_branch2  AS CHAR FORMAT "x(2)".

DEF VAR n_name      AS CHAR FORMAT "x(50)".     /*acno name*/
DEF VAR n_chkname   AS CHAR FORMAT "x(1)".        /* Acno-- chk button 1-2 */
DEF VAR n_bdes      AS CHAR FORMAT "x(50)".     /*branch name*/
DEF VAR n_chkBname  AS CHAR FORMAT "x(1)".        /* branch-- chk button 1-2 */

/* Local Variable Definitions ---        */

DEF VAR nv_asmth    AS INTE INIT 0.
DEF VAR nv_frmth    AS INTE INIT 0.
DEF VAR nv_tomth    AS INTE INIT 0.
DEF VAR cv_mthListT AS CHAR INIT "มกราคม,กุมภาพันธ์,มีนาคม,เมษายน,พฤษภาคม,มิถุนายน,กรกฎาคม,สิงหาคม,กันยายน,ตุลาคม,พฤศจิกายน,ธันวาคม".
DEF VAR cv_mthListE AS CHAR INIT " January, February, March, April, May, June, July, August, September, October, November, December".

DEF VAR n_frdate    AS DATE FORMAT "99/99/9999".
DEF VAR n_todate    AS DATE FORMAT "99/99/9999".
DEF VAR n_asdat     AS DATE FORMAT "99/99/9999".
DEF VAR n_trndatto  AS DATE FORMAT "99/99/9999".

/*DEF VAR n_y        AS   CHAR   FORMAT "X".*/

DEF VAR n_chkCopy     AS INTEGER.
DEF VAR n_OutputTo    AS INTEGER.
DEF VAR n_OutputFile  AS CHAR .

DEF VAR vCliCod       AS CHAR.
DEF VAR vCliCodAll    AS CHAR.
DEF VAR vCountRec     AS INT.

/* --------------------- Define Var use in process ---------------------------*/
DEF VAR n_frbr    AS   CHAR   FORMAT "x(2)".
DEF VAR n_tobr    AS   CHAR   FORMAT "x(2)".
DEF VAR n_frac    AS   CHAR   FORMAT "x(7)".
DEF VAR n_toac    AS   CHAR   FORMAT "x(7)".
DEF VAR n_typ     AS   CHAR   FORMAT "X".
DEF VAR n_typ1    AS   CHAR   FORMAT "X".
DEF VAR n_day     AS   INTE   FORMAT ">>9".
DEF VAR n_wcr     AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  /*with in credit*/
DEF VAR n_damt    AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  /*due amount */
DEF VAR n_odue    AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  /*overdue*/

DEF VAR nt_tdat    AS   CHAR   FORMAT "X(10)".
DEF VAR nt_asdat   AS   CHAR   FORMAT "X(10)".
DEF VAR n_xtm600   LIKE xtm600.name.
DEF VAR n_acc      LIKE acm001.acno.
DEF VAR n_add1     LIKE xtm600.addr1.
DEF VAR n_add2     LIKE xtm600.addr2.
DEF VAR n_add3     LIKE xtm600.addr3.
DEF VAR n_add4     LIKE xtm600.addr4.
DEF VAR n_ltamt    LIKE xmm600.ltamt.
DEF VAR n_insur    AS   CHAR   FORMAT "x(35)".
DEF VAR n_trntyp   AS   CHAR   FORMAT "x(11)".
DEF VAR n_mocom    LIKE acm001.stamp.
DEF VAR n_prem     LIKE acm001.netamt.
DEF VAR n_comp     AS   DECI   FORMAT "->>,>>9.99".
DEF VAR n_gross    LIKE acm001.netamt.

DEF VAR n_year     AS INTE FORMAT ">>9".
DEF VAR n_polyear  AS CHAR FORMAT "X(4)".
DEF VAR n_cedpol   AS CHAR FORMAT "X(16)".
DEF VAR n_opnpol   AS CHAR FORMAT "X(16)".
DEF VAR n_prvpol   AS CHAR FORMAT "X(16)".
DEF VAR n_startdat AS DATE FORMAT "99/99/9999".
DEF VAR n_duedat   AS DATE FORMAT "99/99/9999".
DEF VAR n_poldes   AS CHAR FORMAT "X(35)".
DEF VAR n_polbrn   AS CHAR FORMAT "X(2)".
DEF VAR n_comdat   AS DATE FORMAT "99/99/9999".

DEF VAR vCountDay   AS INT.
DEF VAR n_comm      AS DECI FORMAT "->>,>>9.99".
DEF VAR n_comm_comp AS DECI FORMAT "->>,>>9.99".
DEF VAR n_odue1     AS DECI FORMAT ">>,>>>,>>9.99-".  /*overdue 1-3 months Change to 1-15 days*/
DEF VAR n_odue2     AS DECI FORMAT ">>,>>>,>>9.99-".  /*overdue 3-6 months Change to 16-30 days*/
DEF VAR n_odue3     AS DECI FORMAT ">>,>>>,>>9.99-".  /*overdue 6-9 months Change to 31-45 days*/
DEF VAR n_odue4     AS DECI FORMAT ">>,>>>,>>9.99-".  /*overdue 9-12 months Change to 46-90 days*/
DEF VAR n_odue5     AS DECI FORMAT ">>,>>>,>>9.99-".  /*overdue over 12 months Change to 91-365 days*/
DEF VAR n_odue6     AS DECI FORMAT ">>,>>>,>>9.99-".  /*overdue 365 days  ---By A53-0159---*/   

/* pdprocess2 */
DEF VAR n_day1 AS INT.
DEF VAR n_day2 AS INT.

DEF VAR v_trntyp12 AS CHAR init "".

/*  work table */
/*  DEF  TEMP-TABLE  wacm001
 * /*  DEF  workfile  wacm001*/
 * 
 *  FIELD  acno     LIKE acm001.acno
 *  FIELD  agent     LIKE acm001.agent
 *  FIELD  trndat    LIKE acm001.trndat
 *  FIELD  trnty1     LIKE acm001.trnty1
 *  FIELD  trnty2     LIKE acm001.trnty2
 *  FIELD  docno     LIKE acm001.docno
 *  FIELD  insno     LIKE acm001.insno
 *  FIELD  clicod     LIKE acm001.clicod
 *  FIELD  prem     LIKE acm001.prem
 *  FIELD  comm     LIKE acm001.comm
 *  FIELD  stamp     LIKE acm001.stamp
 *  FIELD  tax     LIKE acm001.tax
 *  FIELD  bal     LIKE acm001.bal
 *  FIELD  policy     LIKE acm001.policy
 *  FIELD  rencnt     LIKE acm001.rencnt
 *  FIELD  endcnt     LIKE acm001.endcnt
 *  FIELD  recno     LIKE acm001.recno
 *  FIELD  poltyp     LIKE acm001.poltyp
 *  FIELD  vehreg    LIKE acm001.vehreg
 *  FIELD  latdat     LIKE acm001.latdat
 *  FIELD  comdat  LIKE acm001.comdat
 *  FIELD  ref     LIKE acm001.ref
 *  INDEX  wacm001 IS UNIQUE PRIMARY acno trndat policy 
 *  trnty1 trnty2 docno recno ASCENDING.*/

DEF VAR n_recid      AS RECID.
DEF VAR nv_type      AS CHAR INIT "01".  /* "PROCESS PREMIUM STATEMENT (A4) MONTHLY" */
DEF VAR n_chkprocess AS LOGIC INIT NO.

/**/
DEF VAR nv_acm001    AS INT.
DEF VAR nv_acm001F   AS INT.
DEF VAR nv_acm001L   AS INT.

DEF VAR nv_findXmm   AS INT.
DEF VAR nv_findXmmF  AS INT.
DEF VAR nv_findXmmL  AS INT.

DEF VAR nv_finduwm   AS INT.
DEF VAR nv_finduwmF  AS INT.
DEF VAR nv_finduwmL  AS INT.

DEF VAR nv_create    AS INT.
DEF VAR nv_createF   AS INT.
DEF VAR nv_createL   AS INT.

DEF VAR nv_File-Name AS CHAR INIT "C:\temp\proc1".
DEF VAR vBackUp      AS CHAR.

DEF VAR nv_YZCB      AS CHAR INIT "YS,ZS,C,B". /* type นี้ ไม่คิด credit term*/  /*A46-0142*/

DEF VAR n_sdmonth    AS INT. /*start date*/
DEF VAR n_sdyear     AS INT.

/* หาวันที่เริ่มต้น  ต้องเป็นวันที่วันสุดท้ายของเดือนนั้น ๆ*/
DEF VAR vYear        AS INT.
DEF VAR vMonth       AS INT.
DEF VAR vDay         AS INT.
DEF VAR vdueDAY      AS INT.
DEF VAR vdueMONTH    AS INT.
DEF VAR vdueYEAR     AS INT.
DEF VAR vcrperMod    AS INT.
DEF VAR vcrperTrun   AS INT.
DEF VAR vcrperRound  AS INT.
/**/                 
DEF VAR n_odmonth1   AS INT. /*month  not over  12   เดือนที่  เพื่อนำไปหาจำนวนวันในแต่ละเดือน */
DEF VAR n_odmonth2   AS INT.
DEF VAR n_odmonth3   AS INT.
DEF VAR n_odmonth4   AS INT.
DEF VAR n_odDay1     AS INT. /*count num day in over due 1 - 3   จำนวนวัน ที่เกิน ระยะเวลาให้ credit  3 เดือน */
DEF VAR n_odDay2     AS INT.
DEF VAR n_odDay3     AS INT.
DEF VAR n_odDay4     AS INT.

DEF VAR n_odat1      AS DATE FORMAT "99/99/9999". /* วันที่ ที่เกินจากระยะเวลาให้ credit  เกินไป 3 เดือน*/
DEF VAR n_odat2      AS DATE FORMAT "99/99/9999".
DEF VAR n_odat3      AS DATE FORMAT "99/99/9999".
DEF VAR n_odat4      AS DATE FORMAT "99/99/9999".
DEF VAR n_odat5      AS DATE FORMAT "99/99/9999".
DEF VAR n_type       AS CHAR FORMAT "X(2)".

DEF VAR i AS INT.
DEF VAR vcom1_t  AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR vcom2_t  AS DECI FORMAT ">>,>>>,>>>,>>9.99-".

/**/
DEF VAR n_clicod AS CHAR.
/*--- A53-0159 ---*/
DEF VAR nv_cntaging AS INT  FORMAT 9999999 INIT 0.
DEF VAR nv_duedate  AS INT  FORMAT 9999999 INIT 0.
DEF VAR nv_dueday   AS CHAR FORMAT "X(2)" .
DEF VAR nv_effdat   AS DATE FORMAT "99/99/9999".
DEF VAR nv_duedate1 AS CHAR FORMAT "X(10)".
DEF VAR nv_duedate2 AS INT  FORMAT 99999999 INIT 0.
DEF VAR nv_insref   AS CHAR FORMAT "X(10)".
DEF VAR nn_dept     LIKE xmm031.dept.

/*-- Nattanicha Benjaporn [A59-0153] 09/06/2016 --*/

DEF VAR nv_acno  LIKE xmm600.acno.

DEF TEMP-TABLE tagtprm 
    FIELD asdat  LIKE agtprm_fil.asdat
    FIELD gpstmt LIKE xmm600.gpstmt
    FIELD acno   LIKE agtprm_fil.acno
    FIELD nameac LIKE xmm600.NAME
    FIELD bal    LIKE agtprm_fil.bal
    FIELD limit  AS DECI FORMAT ">,>>>,>>>,>>9.99-"
    FIELD iblack AS CHAR FORMAT "X(10)"
    FIELD crcon  LIKE xmm600.crcon.

DEF TEMP-TABLE tgrpacno
    FIELD gpstmt LIKE xmm600.gpstmt
    FIELD acno   LIKE agtprm_fil.acno.

DEF VAR nv_output1 AS CHAR FORMAT "X(50)".
DEF VAR nv_output2 AS CHAR FORMAT "X(50)".

DEF VAR nv_asdat AS DATE FORMAT "99/99/9999".
/* ------- End [A59-0153] -------*/

/*A60-0358*/
DEF VAR nv_trnty1  AS CHAR FORMAT "X(256)" INIT "". 
DEF VAR nv_bencod  AS CHAR FORMAT "X(256)" init "".
DEF TEMP-TABLE tgrpstm
    FIELD gpstmt LIKE xmm600.gpstmt
    FIELD acno   LIKE agtprm_fil.acno
    FIELD amt    LIKE agtprm_fil.bal
    FIELD grpamt  LIKE agtprm_fil.bal.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fuNumDay C-Win 
FUNCTION fuNumDay RETURNS INTEGER
  (INPUT vDate AS DATE )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fuNumMonth C-Win 
FUNCTION fuNumMonth RETURNS INTEGER
  (INPUT vMonth AS INT ,vDate AS DATE )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE IMAGE IMAGE-21
     FILENAME "wimage/wallpape.bmp":U CONVERT-3D-COLORS
     SIZE 132.5 BY 24.

DEFINE IMAGE IMAGE-23
     FILENAME "wimage/bgc01.bmp":U CONVERT-3D-COLORS
     SIZE 96 BY 19.57.

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
     SIZE 18.5 BY 4.43
     BGCOLOR 1 .

DEFINE BUTTON buAcno1 
     IMAGE-UP FILE "wimage/help.bmp":U
     LABEL "..." 
     SIZE 3 BY .95 TOOLTIP "รหัส Producer"
     FONT 6.

DEFINE BUTTON buAcno2 
     IMAGE-UP FILE "wimage/help.bmp":U
     LABEL "..." 
     SIZE 3 BY .95 TOOLTIP "รหัส Producer"
     FONT 6.

DEFINE VARIABLE cbAsMth AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEMS "Item 1" 
     DROP-DOWN-LIST
     SIZE 13.5 BY 1
     BGCOLOR 15 FONT 1 NO-UNDO.

DEFINE VARIABLE fiacno1 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 12 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fiacno2 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 12 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fiAsDay AS INTEGER FORMAT ">9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 3.5 BY .95
     BGCOLOR 15 FONT 1 NO-UNDO.

DEFINE VARIABLE fiAsYear AS INTEGER FORMAT "9999":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 6.5 BY .95
     BGCOLOR 15 FONT 1 NO-UNDO.

DEFINE VARIABLE fiCount AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 29.5 BY 1
     FGCOLOR 15 FONT 1 NO-UNDO.

DEFINE VARIABLE finame1 AS CHARACTER FORMAT "X(256)":U 
     LABEL "" 
      VIEW-AS TEXT 
     SIZE 51 BY .95
     BGCOLOR 8 FONT 6 NO-UNDO.

DEFINE VARIABLE finame2 AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 51 BY .95
     BGCOLOR 8 FONT 6 NO-UNDO.

DEFINE VARIABLE fiProcess AS CHARACTER FORMAT "X(256)":U 
     LABEL "fiProcess" 
      VIEW-AS TEXT 
     SIZE 59.5 BY .95
     FGCOLOR 15 FONT 1 NO-UNDO.

DEFINE VARIABLE fiProcessDate AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 12 BY 1
     BGCOLOR 15 FONT 1 NO-UNDO.

DEFINE RECTANGLE reAsdate
     EDGE-PIXELS 4 GRAPHIC-EDGE  NO-FILL   
     SIZE 82 BY 4.24
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-94
     EDGE-PIXELS 4 GRAPHIC-EDGE  NO-FILL   
     SIZE 87.5 BY 11.57.

DEFINE RECTANGLE RECT11
     EDGE-PIXELS 4 GRAPHIC-EDGE    
     SIZE 82 BY 4.24
     BGCOLOR 8 .

DEFINE VARIABLE cbFrMth AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEMS "Item 1" 
     DROP-DOWN-LIST
     SIZE 13.5 BY 1
     BGCOLOR 15 FONT 1 NO-UNDO.

DEFINE VARIABLE cbToMth AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEMS "Item 1" 
     DROP-DOWN-LIST
     SIZE 13.5 BY 1
     BGCOLOR 15 FONT 1 NO-UNDO.

DEFINE VARIABLE fiFrDay AS INTEGER FORMAT ">9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 3.5 BY .95
     BGCOLOR 15 FONT 1 NO-UNDO.

DEFINE VARIABLE fiFrYear AS INTEGER FORMAT "9999":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 6.5 BY .95
     BGCOLOR 15 FONT 1 NO-UNDO.

DEFINE VARIABLE fiToDay AS INTEGER FORMAT ">9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 3.5 BY .95
     BGCOLOR 15 FONT 1 NO-UNDO.

DEFINE VARIABLE fiToYear AS INTEGER FORMAT "9999":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 6.5 BY .95
     BGCOLOR 15 FONT 1 NO-UNDO.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     IMAGE-21 AT ROW 1 COL 1.5
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 24.04
         BGCOLOR 18 .

DEFINE FRAME frMain
     IMAGE-23 AT ROW 1 COL 1
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         NO-LABELS SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 19 ROW 3.5
         SIZE 96.5 BY 19.7.

DEFINE FRAME frST
     buAcno1 AT ROW 3.86 COL 27.5
     fiacno1 AT ROW 3.91 COL 13.5 COLON-ALIGNED NO-LABEL
     fiacno2 AT ROW 4.91 COL 13.5 COLON-ALIGNED NO-LABEL
     buAcno2 AT ROW 4.91 COL 27.5
     fiAsDay AT ROW 7.76 COL 24 COLON-ALIGNED NO-LABEL
     cbAsMth AT ROW 7.76 COL 27.5 COLON-ALIGNED NO-LABEL
     fiAsYear AT ROW 7.76 COL 41.5 COLON-ALIGNED NO-LABEL
     fiCount AT ROW 7.76 COL 53 COLON-ALIGNED NO-LABEL
     fiProcessDate AT ROW 9.33 COL 24 COLON-ALIGNED NO-LABEL
     finame1 AT ROW 3.86 COL 29 COLON-ALIGNED
     finame2 AT ROW 4.91 COL 29 COLON-ALIGNED NO-LABEL
     fiProcess AT ROW 11.95 COL 17.5
     " Process Date":30 VIEW-AS TEXT
          SIZE 15 BY .95 TOOLTIP "วันที่ออกรายงาน" AT ROW 9.33 COL 9
          BGCOLOR 1 FGCOLOR 7 
     " As of Date":30 VIEW-AS TEXT
          SIZE 15 BY .95 AT ROW 7.76 COL 9
          BGCOLOR 1 FGCOLOR 7 
     " Producer Code":40 VIEW-AS TEXT
          SIZE 15 BY .76 TOOLTIP "รหัสตัวแทน" AT ROW 2.62 COL 4
          BGCOLOR 1 FGCOLOR 7 FONT 1
     "To":20 VIEW-AS TEXT
          SIZE 5 BY .95 TOOLTIP "รหัสตัวแทนถึง" AT ROW 4.95 COL 9
          BGCOLOR 8 
     "From":40 VIEW-AS TEXT
          SIZE 6.5 BY .95 TOOLTIP "รหัสตัวแทนเริ่มตั้งแต่" AT ROW 3.91 COL 9
          BGCOLOR 8 
     "                            PROCESS PREMIUM STATEMENT (CBC) MONTHLY":120 VIEW-AS TEXT
          SIZE 87.5 BY .95 AT ROW 1 COL 1
          BGCOLOR 1 FGCOLOR 7 FONT 6
     reAsdate AT ROW 6.95 COL 4
     RECT-94 AT ROW 2.05 COL 1
     RECT11 AT ROW 2.57 COL 4
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         NO-LABELS SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 5 ROW 1.52
         SIZE 88 BY 12.78
         BGCOLOR 3 .

DEFINE FRAME frOK
     Btn_OK AT ROW 1.71 COL 5.5
     Btn_Cancel AT ROW 3.62 COL 5.5
     RECT2 AT ROW 1.24 COL 2.5
    WITH DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 71 ROW 15.09
         SIZE 21.5 BY 4.96
         BGCOLOR 3 .

DEFINE FRAME frTranDate
     fiFrDay AT ROW 2.57 COL 10 COLON-ALIGNED NO-LABEL
     cbFrMth AT ROW 2.57 COL 13.5 COLON-ALIGNED NO-LABEL
     fiFrYear AT ROW 2.57 COL 27.5 COLON-ALIGNED NO-LABEL
     fiToDay AT ROW 3.86 COL 10 COLON-ALIGNED NO-LABEL
     cbToMth AT ROW 3.86 COL 13.5 COLON-ALIGNED NO-LABEL
     fiToYear AT ROW 3.86 COL 27.5 COLON-ALIGNED NO-LABEL
     " Transaction Date":40 VIEW-AS TEXT
          SIZE 47.5 BY .95 TOOLTIP "วันที่ทำกรมธรรม์" AT ROW 1 COL 1
          BGCOLOR 1 FGCOLOR 15 FONT 6
     "From":10 VIEW-AS TEXT
          SIZE 5.5 BY .95 TOOLTIP "ตั้งแต่" AT ROW 2.57 COL 4.5
          BGCOLOR 3 FGCOLOR 15 
     "To":5 VIEW-AS TEXT
          SIZE 7 BY .95 TOOLTIP "ถึง" AT ROW 3.86 COL 4.5
          BGCOLOR 3 FGCOLOR 15 
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 5 ROW 15.09
         SIZE 48 BY 4.96
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
         TITLE              = "wacr01 - PROCESS PREMIUM STATEMENT (CBC)"
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
/* REPARENT FRAME */
ASSIGN FRAME frMain:FRAME = FRAME DEFAULT-FRAME:HANDLE
       FRAME frOK:FRAME = FRAME frMain:HANDLE
       FRAME frST:FRAME = FRAME frMain:HANDLE
       FRAME frTranDate:FRAME = FRAME frMain:HANDLE.

/* SETTINGS FOR FRAME DEFAULT-FRAME
   FRAME-NAME                                                           */
/* SETTINGS FOR FRAME frMain
                                                                        */
/* SETTINGS FOR FRAME frOK
                                                                        */
ASSIGN 
       FRAME frOK:SCROLLABLE       = FALSE.

/* SETTINGS FOR FRAME frST
                                                                        */
/* SETTINGS FOR FILL-IN finame1 IN FRAME frST
   LABEL ":"                                                            */
/* SETTINGS FOR FILL-IN fiProcess IN FRAME frST
   ALIGN-L LABEL "fiProcess:"                                           */
ASSIGN 
       fiProcess:HIDDEN IN FRAME frST           = TRUE.

/* SETTINGS FOR FRAME frTranDate
                                                                        */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* wacr01 - PROCESS PREMIUM STATEMENT (CBC) */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* wacr01 - PROCESS PREMIUM STATEMENT (CBC) */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frOK
&Scoped-define SELF-NAME Btn_Cancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_Cancel C-Win
ON CHOOSE OF Btn_Cancel IN FRAME frOK /* Cancel */
DO:
    APPLY "CLOSE" TO THIS-PROCEDURE.
    RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_OK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_OK C-Win
ON CHOOSE OF Btn_OK IN FRAME frOK /* OK */
DO:
DEF VAR vAcno      AS CHAR INIT "".
DEF VAR vFirstTime AS CHAR INIT "".
DEF VAR vLastTime  AS CHAR INIT "".

   DO WITH FRAME {&FRAME-NAME} :
        ASSIGN  
            FRAME frST fiacno1  fiacno1
            FRAME frST fiacno2  fiacno2
            FRAME frST fiAsDay  fiAsDay
            FRAME frST cbAsMth  cbAsMth
            FRAME frST fiAsYear fiAsYear

            FRAME frTranDate fiFrDay  fiFrDay
            FRAME frTranDate cbFrMth  cbFrMth
            FRAME frTranDate fiFrYear fiFrYear
            FRAME frTranDate fiToDay  fiToDay
            FRAME frTranDate cbToMth  cbToMth
            FRAME frTranDate fiToYear fiToYear
       
            nv_asmth  =  LOOKUP (cbasMth, cv_mthlistE)
            nv_frmth  =  LOOKUP (cbFrMth, cv_mthlistE)  
            nv_tomth  =  LOOKUP (cbToMth, cv_mthlistE)

            n_asdat   =  DATE (nv_asmth, fiasDay, fiasYear)
            n_frdate  =  DATE (nv_Frmth, fiFrDay, fiFrYear)
            
            n_todate  =  DATE (nv_Tomth, fiToDay, fiToYear)
            n_frac    =  fiacno1
            n_toac    =  fiacno2 .
  
   END.

   /*--- A500178 ---   
   If  n_frac = "" Then  n_frac = "A000000".     
   If  n_toac = "" Then  n_toac = "B999999".  
   ------*/
   IF   n_frac = "" THEN   n_frac = "A000000".
   IF   n_toac = "" THEN   n_toac = "B999999999".
  
   IF ( n_frac > n_toac)   THEN DO:
         MESSAGE  "ข้อมูลตัวแทนผิดพลาด" SKIP
         "รหัสตัวแทนเริ่มต้นต้องมากกว่ารหัสสุดท้าย" VIEW-AS ALERT-BOX WARNING . 
         APPLY  "Entry" To fiacno1  .
         RETURN  NO-APPLY .       
   END.
     
   IF ( n_frdate > n_todate) OR n_frdate  = ? OR n_todate = ?   THEN DO:
         MESSAGE  "ข้อมูลวันที่ทำกรมธรรม์ผิดพลาด" SKIP 
         "วันที่เริ่มต้นต้องมากกว่าวันที่สุดท้าย" VIEW-AS ALERT-BOX WARNING . 
         Apply "Entry" To  fiFrDay .
         RETURN NO-APPLY .       
   END.

    MESSAGE "ทำการประมวลผลข้อมูล ! " SKIP (1)
            "ตัวแทน/นายหน้า     : " n_frac     " ถึง " n_toac  SKIP (1)
            "วันที่ออกรายงาน       : " STRING(n_asdat,"99/99/9999")  SKIP (1)
            "กรมธรรม์ตั้งแต่วันที่ : " STRING(n_frdate,"99/99/9999") " ถึง " STRING(n_todate,"99/99/9999") SKIP (1)
            "Type                        : " nv_Type + " - " + "PROCESS PREMIUM STATEMENT (A4) "
    VIEW-AS ALERT-BOX QUESTION  BUTTONS YES-NO
    UPDATE CHOICE AS LOGICAL. 
    CASE CHOICE:
        WHEN TRUE THEN DO:

            DOS SILENT del value(nv_file-name)  .   /* delete  file exports */
            RUN pdChkProcess01.  /* ตรวจสอบว่า เคยมีการ process ใน type  05 ไหม  ถ้าซ้ำ  จะไม่ process ให้ */
            
            IF n_chkprocess = YES THEN DO:
                vFirstTime =  STRING(TODAY,"99/99/9999") +  STRING(TIME, "HH:MM AM") + " " + STRING(ETIME).
                    RUN pdProcess.  
                    RUN pdProcessYes.        /* ถ้า process เสร็จให้ Process complete = YES  elapsed*/
                    RUN pdProc_agtprm001.    /*A57-0401*/
                   /* RUN pdCheckOverLimit.    /* Nattanicha , Benjaporn [A59-0153] 09/06/2016 */*/
                vLastTime =  STRING(TODAY,"99/99/9999") +  STRING(TIME, "HH:MM AM") + " " + STRING(ETIME).
               
               /* kan. 08/07/2002---*/
               fiCount = fiCount + "  N = " + STRING(vCountRec).
               DISP fiCount WITH FRAME frST.
               /*--- kan.*/
               /*---A61-0158---
                MESSAGE "วันที่ออกรายงาน : " STRING(n_asdat,"99/99/9999")  SKIP (1)
                                   "ตัวแทน              : "  n_frac " ถึง " n_toac SKIP (1)
                                   "ประมวลผลพบข้อมูลทั้งสิ้น  " vCountRec   " รายการ"  SKIP (1)
                                   "เวลา  " SUBSTR(vFirstTime,1,18) "  -  " 
                                                SUBSTR(vLastTime,1,18) " น."
                                    VIEW-AS ALERT-BOX INFORMATION.
               ----------end A61-0158---*/
               /*---- A61-0158----*/
               OUTPUT TO VALUE ("D:\TEMP\ProcSTM_Sts.slk") NO-ECHO.
               EXPORT DELIMITER ";"
                   "วันที่ออกรายงาน : "  STRING(n_asdat,"99/99/9999").
               EXPORT DELIMITER ";"
                   "ตัวแทน              : "  n_frac " ถึง " n_toac.
               EXPORT DELIMITER ";"
                   "ประมวลผลพบข้อมูลทั้งสิ้น  " vCountRec   " รายการ"  .
               EXPORT DELIMITER ";"
                   "เวลา  " SUBSTR(vFirstTime,1,20) "  -  " 
                                SUBSTR(vLastTime,1,20) " น.".
               OUTPUT CLOSE.
               /*-----------------*/

            END.
            ELSE DO:
                /*---A61-0158----
                MESSAGE "ไม่สามารถ Process ได้ เนื่องจาก"  SKIP (1)
                                   "มีการ Process ใน As date นี้แล้ว"  /*n_chkprocess*/  VIEW-AS ALERT-BOX ERROR.
                RETURN NO-APPLY.
                -----------------*/
                OUTPUT TO VALUE ("D:\TEMP\LogProcStmt.slk") NO-ECHO.
                EXPORT DELIMITER ";"
                    "ไม่สามารถ Process ได้ เนื่องจากมีการ Process ใน As date นี้แล้ว" .
                OUTPUT CLOSE.
            END. /*  n_chkprocess = yes*/
        END.
        WHEN FALSE THEN DO:
                    RETURN NO-APPLY.    
        END.
    END CASE.

        OUTPUT TO VALUE (STRING(nv_File-Name)) APPEND NO-ECHO.
                EXPORT DELIMITER ";"
                    "Count : " vCountRec
                    "" ""
                    "nv_acm001 : " nv_acm001
                    ""
                    "nv_findXmm : " nv_findXmm
                    ""
                    "nv_finduwm : " nv_finduwm
                    ""
                    "nv_cerate : " nv_create
                    ""
                    vFirstTime
                    vLastTime
                    .
        OUTPUT CLOSE.

        vBackUP =  nv_File-Name + "B".
    
        DOS SILENT  COPY VALUE(nv_File-Name) VALUE(vBackUP) /Y  .   /* backup file exports */
        
/* เซตค่า เริ่มต้นใหม่กรณี  เปิดโปรแกรมข้ามวัน */
    DO WITH FRAME frST:
       ASSIGN   
           fiacno1       = ""
           fiacno2       = ""       
           cbAsMth:List-Items = cv_mthlistE
           fiAsDay       = DAY(TODAY)
           cbAsMth       = ENTRY(MONTH(TODAY), cv_mthlistE) 
           fiAsYear      = YEAR(TODAY)
           fiProcessDate = TODAY.
        DISPLAY fiacno1 fiacno2 fiAsDay cbAsMth fiAsYear fiProcessDate.  
                         
    END.
/* ประมวลผลเสร็จออกจากโปรแกรมทันที*/
    /*-----A61-0158----
    MESSAGE "ประมวลผลเรียบร้อย"  VIEW-AS ALERT-BOX INFORMATION.
    APPLY "CHOOSE" TO btn_cancel.
    ---------------*/

    DISP "*** ประมวลผลเรียบร้อย ***" 
         "สามารถดู Log File for Process ที่ D:\TEMP\LogProcStmt.slk" WITH 1 COLUMN 1 DOWN TITLE "Process Complete".
   
    RUN wac\wacr0111.

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


&Scoped-define FRAME-NAME frTranDate
&Scoped-define SELF-NAME cbToMth
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cbToMth C-Win
ON VALUE-CHANGED OF cbToMth IN FRAME frTranDate
DO:
      ASSIGN cbToMth.
  
     cbToMth  = INPUT cbToMth.
   DISP cbToMth WITH FRAME frTranDate.
   
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frST
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


&Scoped-define SELF-NAME fiAsDay
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiAsDay C-Win
ON LEAVE OF fiAsDay IN FRAME frST
DO:
  ASSIGN fiAsDay.

   
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frTranDate
&Scoped-define SELF-NAME fiFrDay
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiFrDay C-Win
ON LEAVE OF fiFrDay IN FRAME frTranDate
DO:
  ASSIGN fiFrDay.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiToDay
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiToDay C-Win
ON LEAVE OF fiToDay IN FRAME frTranDate
DO:
  ASSIGN fiToDay.
  
     fiToDay  = INPUT fiToDay.
   DISP fiToDay WITH FRAME frTranDate.
   
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiToYear
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiToYear C-Win
ON LEAVE OF fiToYear IN FRAME frTranDate
DO:
    ASSIGN fiToYear.
  
/*     fiAsYear  =  fiToYear.
 *    DISP fiAsYear WITH FRAME frST.*/
   
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
  
  gv_prgid = "wacr01".
  gv_prog  = "PROCESS STATEMENT CBC (Monthly)".
  RUN  WUT\WUTHEAD (c-win:handle,gv_prgid,gv_prog).

/*********************************************************************/  
 
  CURRENT-WINDOW:WINDOW-STATE = WINDOW-MAXIMIZED.  
/*    RUN Wut\Wutwicen.p (C-Win:HANDLE).*/
  
  SESSION:DATA-ENTRY-RETURN = YES.
  APPLY "ENTRY" TO fiToDay.

DISABLE ALL /*EXCEPT fiAsDay cbAsMth fiAsYear*/ WITH FRAME frST.    

    DO WITH FRAME frST:
        /*reProducer:MOVE-TO-TOP() .   */ 
       ASSIGN   
           fiacno1  = ""
           fiacno2  = ""       
           cbAsMth:List-Items = cv_mthlistE
           fiAsDay  = DAY(TODAY)  /*fuNumDay(TODAY) */
           
           cbAsMth  = ENTRY(MONTH (TODAY), cv_mthlistE) 
           fiAsYear = YEAR (TODAY)
           
/* kan--- 04/11/2002*/
           fiProcessDate = TODAY. 
/* ---kan*/

        DISPLAY fiacno1 fiacno2 fiAsDay cbAsMth fiAsYear fiProcessDate. 
                         
    END.    
      
    DO WITH FRAME frTranDate:
        ASSIGN  
          cbFrMth:List-Items  = cv_mthlistE 
          cbToMth:LIST-ITEMS  = cv_mthlistE 
          
          /*fiFrDay = 1           cbFrMth = ENTRY(1, cv_mthlistE) fiFrYear = 1988 ----A60-0358---*/
            fiFrDay = 1           cbFrMth = ENTRY(1, cv_mthlistE) fiFrYear = 2011
          fiToDay = DAY (TODAY) cbToMth = ENTRY(MONTH (TODAY), cv_mthlistE) fiToYear = YEAR (TODAY).

         DISPLAY 
            fiFrDay cbFrMth fiFrYear
            fiToDay cbToMth fiToYear
          WITH FRAME frTranDate .
    
    END.
    
  IF NOT THIS-PROCEDURE:PERSISTENT THEN
  WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE ChkDate C-Win 
PROCEDURE ChkDate :
/*------------------------------------------------------------------------------
  Purpose:        Check วันที่สิ้นเดือน
  Parameters:  <none>
  Notes:        A53-0159
------------------------------------------------------------------------------*/
IF MONTH(nv_effdat) = 1 OR MONTH(nv_effdat) = 3 OR
   MONTH(nv_effdat) = 5 OR MONTH(nv_effdat) = 7 OR
   MONTH(nv_effdat) = 8 OR MONTH(nv_effdat) = 10 OR
   MONTH(nv_effdat) = 12  THEN DO:
   ASSIGN nv_dueday = "31".
END.
ELSE DO:
   IF MONTH(nv_effdat) <> 2 THEN ASSIGN nv_dueday = "30".
END.

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
  ENABLE IMAGE-21 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  DISPLAY fiacno1 fiacno2 fiAsDay cbAsMth fiAsYear fiCount fiProcessDate finame1 
          finame2 fiProcess 
      WITH FRAME frST IN WINDOW C-Win.
  ENABLE reAsdate RECT-94 RECT11 buAcno1 fiacno1 fiacno2 buAcno2 fiAsDay 
         cbAsMth fiAsYear fiCount fiProcessDate finame1 finame2 fiProcess 
      WITH FRAME frST IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-frST}
  ENABLE IMAGE-23 
      WITH FRAME frMain IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-frMain}
  DISPLAY fiFrDay cbFrMth fiFrYear fiToDay cbToMth fiToYear 
      WITH FRAME frTranDate IN WINDOW C-Win.
  ENABLE fiFrDay cbFrMth fiFrYear fiToDay cbToMth fiToYear 
      WITH FRAME frTranDate IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-frTranDate}
  ENABLE RECT2 Btn_OK Btn_Cancel 
      WITH FRAME frOK IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-frOK}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdBroker_C C-Win 
PROCEDURE pdBroker_C :
/*------------------------------------------------------------------------------
  Purpose:     CBC-Condition - งาน Broker Coperate Credit = 30 วัน
  Parameters:  <none>
  Notes:      A53-0159
------------------------------------------------------------------------------*/
n_day = 30.

IF DAY(nv_effdat) >= 1 AND DAY(nv_effdat) <= 15  THEN DO:

   IF MONTH(nv_effdat) = 12 THEN DO:
      ASSIGN nv_duedate  =  YEAR(nv_effdat) + 1
             nv_duedate1 = "15" + "01" +  STRING(nv_duedate,"9999").
   END.
   ELSE DO:
      ASSIGN nv_duedate   =  MONTH(nv_effdat) + 1
             nv_duedate1  = "15"  +  
                            STRING(nv_duedate,"99") + 
                            STRING(YEAR(nv_effdat),"9999").
   END.

END.
ELSE IF DAY(nv_effdat) >= 16  THEN DO:
     IF MONTH(nv_effdat)  = 12 THEN DO:
        ASSIGN nv_duedate  =  YEAR(nv_effdat) + 1
               nv_duedate1 = "31" + "01" +  STRING(nv_duedate,"9999").
     END.
     ELSE DO:
        nv_duedate2 =  MONTH(nv_effdat) + 1.

        IF nv_duedate2 = 2  THEN DO:
           ASSIGN nv_duedate   = DAY(DATE(3, 1, YEAR(nv_effdat)) - 1)
                  nv_duedate1  = STRING(nv_duedate)  +  
                                 STRING(nv_duedate2,"99") + 
                                 STRING(YEAR(nv_effdat),"9999").
        END.
        ELSE DO:
            IF nv_duedate2 = 1 OR nv_duedate2 = 3  OR
               nv_duedate2 = 5 OR nv_duedate2 = 7  OR
               nv_duedate2 = 8 OR nv_duedate2 = 10 OR
               nv_duedate2 = 12  THEN DO:
               ASSIGN nv_dueday = "31".
           END.
           ELSE DO:
              IF nv_duedate2 <> 2 THEN ASSIGN nv_dueday = "30".
           END.
            
            nv_duedate1  = nv_dueday +  
                           STRING(nv_duedate2,"99") + 
                           STRING(YEAR(nv_effdat),"9999").

        END.
     END. /* ELSE IF DAY(tb1.comdat) >= 16 */
END. /* IF DAY(tb1.comdat) >= 1 */
       
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdBroker_P C-Win 
PROCEDURE pdBroker_P :
/*------------------------------------------------------------------------------
  Purpose:     CBC Condition - งาน Broker Coperate Credit = 15 วัน
  Parameters:  <none>
  Notes:    A53-0159
------------------------------------------------------------------------------*/
n_day = 15.

IF DAY(nv_effdat) >= 1 AND DAY(nv_effdat) <= 15  THEN DO:
   IF MONTH(nv_effdat) = 2  THEN DO:    /*เดือน 2*/
      ASSIGN nv_duedate   = DAY(DATE(3, 1, YEAR(nv_effdat)) - 1)
             nv_duedate1  = STRING(nv_duedate)  +  
                            STRING(MONTH(nv_effdat),"99") + 
                            STRING(YEAR(nv_effdat),"9999").
   END.
   ELSE DO:    
       RUN chkDate.   /* A52-0199 */
       nv_duedate1  = nv_dueday  +  STRING(MONTH(nv_effdat),"99") + STRING(YEAR(nv_effdat),"9999").
   END.
END.
ELSE IF DAY(nv_effdat) >= 16  THEN DO:

    IF MONTH(nv_effdat)  = 12 THEN DO:
        nv_duedate  =  YEAR(nv_effdat) + 1.
        nv_duedate1 = "15" + "01" +  STRING(nv_duedate,"9999").
    END.
    ELSE DO:
        nv_duedate   =  MONTH(nv_effdat) + 1.
        nv_duedate1  = "15"  +  STRING(nv_duedate,"99") + STRING(YEAR(nv_effdat),"9999").
    END.
END. 
 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdCheckOverLimit C-Win 
PROCEDURE pdCheckOverLimit :
/*------------------------------------------------------------------------------
  Purpose:     Check Agent/Broker for Over Credit Limit
  Parameters:  <none>
  Notes:      Nattanicha Benjaporn [A59-0153] 09/06/2016
------------------------------------------------------------------------------*/

FOR EACH tagtprm . 
    DELETE tagtprm.
END.

ASSIGN nv_output1 = "c:\temp\agdet.slk"
       nv_output2 = "c:\temp\agovd.slk".

OUTPUT TO VALUE (nv_output1) NO-ECHO.
EXPORT DELIMITER ";" 
       "Asdat"
       "Group "
       "Producer"
       "Bal"
       "Cr.Limit" 
       "Status"
       "Credit Control". 
OUTPUT CLOSE.

OUTPUT TO VALUE (nv_output2) NO-ECHO.
EXPORT DELIMITER ";" 
       "Asdat"
       "Group "
       "Bal"
       "Cr.Limit" 
       "Status"
       "Credit Control".
OUTPUT CLOSE.

DISP  "Start Time" STRING (TIME, "HH:MM:SS").

FOR EACH agtprm_fil NO-LOCK WHERE  agtprm_fil.asdat = 1/10/2000  /*02/05/2016*/
                              AND (agtprm_fil.policy  >= "A"
                              AND  agtprm_fil.policy  <= "Bzzzzzzzzz") .

    /*--
    FIND xmm600 USE-INDEX xmm6001 WHERE xmm600.acno   = agtprm_fil.policy AND
    comment by Chaiyong W. A67-0066 31/01/2025*/
    FIND xmm600 USE-INDEX xmm60001 WHERE xmm600.acno   = agtprm_fil.policy AND /*--add by Chaiyong W. A67-0066 31/01/2025*/ 
                                         xmm600.crcon  = YES               AND 
                                         xmm600.iblack = "OverCredit"      NO-LOCK NO-ERROR.
    IF AVAIL xmm600 THEN DO:

       FIND FIRST tagtprm WHERE tagtprm.gpstmt = xmm600.gpstmt  NO-LOCK NO-ERROR.
       IF NOT AVAIL tagtprm  THEN DO:
          CREATE tagtprm.
          ASSIGN tagtprm.asdat   = agtprm_fil.asdat
                 tagtprm.gpstmt  = xmm600.gpstmt
                 tagtprm.bal     = agtprm_fil.bal
                 tagtprm.limit   = xmm600.ltamt
                 tagtprm.crcon   = xmm600.crcon.

          IF tagtprm.bal > tagtprm.limit AND 
             tagtprm.crcon = YES         THEN
                ASSIGN tagtprm.iblack = "OverCredit".

          ELSE  ASSIGN tagtprm.iblack = "".
          
          OUTPUT TO VALUE (nv_output1) APPEND NO-ECHO.
          EXPORT DELIMITER ";" 
              tagtprm.asdat
              tagtprm.gpstmt
              agtprm_fil.policy
              tagtprm.bal
              tagtprm.limit 
              tagtprm.iblack
              tagtprm.crcon.
              
          OUTPUT CLOSE.
          PAUSE 0.
       END.
       ELSE DO:
           ASSIGN tagtprm.bal   = tagtprm.bal + agtprm_fil.bal
                  tagtprm.limit = tagtprm.limit + xmm600.ltamt.

           OUTPUT TO VALUE (nv_output1) APPEND NO-ECHO.
           EXPORT DELIMITER ";" 
              tagtprm.asdat
              tagtprm.gpstmt
              agtprm_fil.policy
              tagtprm.bal
              tagtprm.limit 
              tagtprm.iblack
              tagtprm.crcon.
           OUTPUT CLOSE.
       END.

       FIND FIRST tgrpacno WHERE tgrpacno.gpstmt = xmm600.gpstmt AND
                                 tgrpacno.acno   = xmm600.acno   NO-LOCK NO-ERROR.
       IF NOT AVAIL tgrpacno THEN  DO:
          CREATE tgrpacno.
          ASSIGN tgrpacno.gpstmt = xmm600.gpstmt
                 tgrpacno.acno   = xmm600.acno.  
       END.
    END.
END.

FOR EACH tagtprm NO-LOCK 
    BREAK BY  tagtprm.acno.
    OUTPUT TO VALUE (nv_output2) APPEND NO-ECHO.
    EXPORT DELIMITER ";" 
      tagtprm.asdat
      tagtprm.gpstmt
      tagtprm.bal
      tagtprm.limit 
      tagtprm.iblack
      tagtprm.crcon.

    OUTPUT CLOSE.
    IF  tagtprm.crcon  = YES  AND
        tagtprm.iblack = "OverCredit" THEN DO:
       FOR EACH tgrpacno NO-LOCK WHERE tgrpacno.gpstmt = tagtprm.gpstmt.
            FIND FIRST xmm600 USE-INDEX xmm60009 WHERE xmm600.acno = tgrpacno.acno NO-ERROR.
            IF AVAIL xmm600 THEN DO:
               ASSIGN xmm600.iblack = tagtprm.iblack. 
            END.

       END.
    END.
END.

DISP  "End Time" STRING(TIME,"HH:MM:SS").



END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdChkComdat C-Win 
PROCEDURE pdChkComdat :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       Check from Comdate for calc DueDate
------------------------------------------------------------------------------*/
/*---a53-0159---
ASSIGN
  n_sdmonth = MONTH(acm001.comdat)
  n_sdyear  = YEAR(acm001.comdat)
  n_startdat = IF n_sdmonth = 12 THEN DATE (1,1,n_sdyear + 1)
               ELSE DATE(n_sdmonth + 1,1,n_sdyear).  /*วันที่เริ่มนับ credit*/
----*/

 /*--- เนื่องจากอาจมี Docno. ทางฝั่ง U/W และ A/C ไม่ตรงกันจึงเปลี่ยนมาใช้ index UWM10001 แทน
FIND FIRST uwm100 USE-INDEX uwm10090 WHERE uwm100.trty11 = acm001.trnty1 AND
           uwm100.docno1  = acm001.docno NO-ERROR.
           ------*/
           
/*---A53-0159----
   กรณีเป็น Endorse ให้ใช้ค่าจาก acm001.ac7[14] 
   หากไม่มีค่า ให้ใช้ uwm100.enddat 
------------------*/              
           
/*---A53-0159--- Endorse  ---*/           
IF acm001.endcnt > 000 THEN DO:
   nv_effdat = acm001.trndat.  /*A61-0158*/
   /*------------A61-0158---
   IF acm001.ac7[14] <> "" THEN DO:
      nv_effdat = DATE(acm001.ac7[14]).
   END.
   ELSE DO:
       IF nv_effdat = ? THEN DO:
          FIND FIRST uwm100 USE-INDEX uwm10001 WHERE 
                     uwm100.policy = acm001.policy AND
                     uwm100.rencnt = acm001.rencnt AND
                     uwm100.endcnt = acm001.endcnt NO-LOCK NO-ERROR.
          IF AVAIL uwm100 THEN DO:
             IF uwm100.endcnt  > 000 THEN nv_effdat = uwm100.enddat.
             ELSE nv_effdat = uwm100.comdat. 
          END.
          ELSE DO:
             FIND FIRST uwm100 USE-INDEX uwm10090 WHERE 
                   uwm100.trty11 = acm001.trnty1 AND
                   uwm100.docno1 = acm001.docno  AND 
                   uwm100.policy = acm001.policy NO-LOCK NO-ERROR.
             IF AVAIL uwm100 THEN DO:
                 IF uwm100.endcnt > 000 THEN nv_effdat = uwm100.enddat.
                 ELSE nv_effdat = uwm100.comdat. 
             END.
          END.
          
          IF nv_effdat = ? THEN DO:
             IF acm001.comdat <> ? THEN nv_effdat = acm001.comdat.
             ELSE nv_effdat = acm001.trndat.
          END.
       END.
   END. 
   -----end A61-0158------*/
END.      /*end Endorse */
ELSE DO:   /* Policy */

    nv_effdat = acm001.comdat.

    IF nv_effdat = ? THEN DO:
       nv_effdat = acm001.trndat.
    END.

END.    /*--- end Policy ---*/


/*---A53-0159---
 FIND FIRST uwm100 USE-INDEX uwm10001 WHERE 
               uwm100.policy = acm001.policy AND
               uwm100.rencnt = acm001.rencnt AND
               uwm100.endcnt = acm001.endcnt NO-LOCK NO-ERROR.
    IF AVAIL uwm100 THEN DO:
       IF uwm100.endcnt > 000 THEN nv_effdat = uwm100.enddat.
       ELSE nv_effdat = uwm100.comdat. 
    END.
    ELSE DO:
       FIND FIRST uwm100 USE-INDEX uwm10090 WHERE 
             uwm100.trty11 = acm001.trnty1 AND
             uwm100.docno1 = acm001.docno AND 
             uwm100.policy = acm001.policy NO-LOCK NO-ERROR.
       IF AVAIL uwm100 THEN DO:
           IF uwm100.endcnt > 000 THEN nv_effdat = uwm100.enddat.
           ELSE nv_effdat = uwm100.comdat. 
       END.
    END.

    IF nv_effdat = ? THEN DO:
       IF acm001.comdat <> ? THEN nv_effdat = acm001.comdat.
       ELSE nv_effdat = acm001.trndat.
    END.
---end A53-0159------------*/

/*-- กรณีที่มีหลาย Installment หาก Find หาข้อมูลที่ UWM100 ด้วย Trntyp และ Docno
   จะหาไม่เจอต้อง find หาที่ UWM101  --*/


ASSIGN
  n_sdmonth  = MONTH(nv_effdat)
  n_sdyear   = YEAR(nv_effdat)
  n_startdat = IF n_sdmonth = 12 THEN DATE (1,1,n_sdyear + 1)
               ELSE DATE(n_sdmonth + 1,1,n_sdyear).      /*วันที่เริ่มนับ credit*/

  /*---nv_effdat = acm001.comdat.---*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdChkComdatNZI C-Win 
PROCEDURE pdChkComdatNZI :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

IF (acm001.branch >= "90" AND acm001.branch <= "98") OR
   (SUBSTR(acm001.policy,1,2) >= "I1" AND 
    SUBSTR(acm001.policy,1,2) <= "I9")  THEN DO:
    nv_effdat = acm001.trndat.
END.



END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdChkProcess01 C-Win 
PROCEDURE pdChkProcess01 :
/*------------------------------------------------------------------------------
  Purpose:     2.  ปรับโปรแกรม Process Statement เดือนละครั้ง (Monthly)
                    และเช็คก่อนว่า
                    1.ถ้ามี As date ตรงกับที่ กำลังเรียก, Type = "01",  process complete = YES   จะไม่ให้ Process
                    2.ถ้ามี As date ตรงกับที่ กำลังเรียก, Type = "05"   จะไม่ให้ Process
                    
                    หากไม่ตรงกับเงื่อนไขข้างต้น  แสดงว่า Process ได้  
                    เพระฉนั้น จะ process  ได้  เมื่อ
                    1. ไม่มี As date ตรงกับที่ กำลังเรียก ทั้ง Type = "01" and "05"   
                        (โปรแกรมจะ create ทุกอย่างใหม่ )
                    
                    2. ถ้ามี As date ตรงกับที่ กำลังเรียก, Type = "01",  process complete =  NO
                    ก่อน Pocess -
                         ทำการ ลบข้อมูลเดิม เฉพาะที่ As date ตรงกับที่ กำลังเรียก และ Record ที่เป็น "01"  ทิ้งก่อน
                         เนื่องจาก  process complete = NO  จากนั้นจึง process  ให้   
                    ได้ Record เป็น "01"
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
    n_chkprocess = NO.

    FIND LAST  acProc_fil  USE-INDEX by_type_asdat  WHERE
              (acProc_fil.asdat = n_asdat AND acProc_fil.type = "05") OR
              (acProc_fil.asdat = n_asdat AND acProc_fil.type = "01" AND
     SUBSTRING(acProc_fil.enttim,10,3)  = "YES") NO-ERROR.
    IF AVAIL acProc_fil THEN DO:
        n_chkprocess = NO.  /* พบ  ใน 05  ไม่สามารถ process  หรือ 
                                                 พบใน 01 แล้ว process complete = "YES" */
    END.
    ELSE DO:
        n_chkprocess = YES.  /* ไม่พบ ใน  05  สามารถ process ได้*/
    END.

    RELEASE acproc_fil.   /*A56-0047*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdChkProcess05 C-Win 
PROCEDURE pdChkProcess05 :
/*------------------------------------------------------------------------------
  Purpose:     1. ทำโปรแกรม Process Statement ทุกวัน  (Daily Process Statement)
                            และเช็คก่อนว่าถ้ามี  As date  ตรงกับที่ กำลังเรียก, Type = "01"   จะไม่ให้ Process
                            หากไม่ตรงกับเงื่อนไขข้างต้น  แสดงว่า Process ได้
                            
                            ก่อน Pocess - 
                                 ทำการ ลบข้อมูลเดิม เฉพาะที่ Record ที่เป็น "05"  ทิ้งก่อน   เพื่อเช็คเบี้ยค้างได้ทุกวัน จากนั้นจึง process  ให้
                            ได้ Record เป็น "05"
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
    n_chkprocess = NO.

    FIND LAST  acProc_fil  USE-INDEX by_type_asdat  WHERE
              (acProc_fil.asdat = n_asdat AND acProc_fil.type = "01" ) NO-ERROR.
    IF AVAIL acProc_fil THEN DO:
        n_chkprocess = NO.  /* พบ  ใน 01  ไม่สามารถ process  */
    END.
    ELSE DO:
        n_chkprocess = YES.  /* ไม่พบ ใน  01  สามารถ process ได้*/
    END.

    RELEASE acProc_fil.   /*A56-0047*/


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdCreate C-Win 
PROCEDURE pdCreate :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       A56-0047
------------------------------------------------------------------------------*/
 CREATE agtprm_fil .
 ASSIGN 
        agtprm_fil.asdat     = n_asdat
        agtprm_fil.acno      = acm001.acno
        agtprm_fil.agent     = acm001.agent
        agtprm_fil.poltyp    = acm001.poltyp
        agtprm_fil.polbran   = n_polbrn
        agtprm_fil.polyear   = n_polyear
        agtprm_fil.policy    = acm001.policy
        agtprm_fil.endno     = acm001.recno
        agtprm_fil.cedpol    = n_cedpol
        agtprm_fil.insur     = n_insur
        agtprm_fil.prem      = n_prem
        agtprm_fil.prem_comp = n_comp
        agtprm_fil.tax       = acm001.tax
        agtprm_fil.stamp     = acm001.stamp
        agtprm_fil.gross     = n_gross
        agtprm_fil.comm      = n_comm        
        agtprm_fil.comm_comp = n_comm_comp
        agtprm_fil.bal       = acm001.bal
        agtprm_fil.trndat    = acm001.trndat
        agtprm_fil.credit    = n_day
        agtprm_fil.trntyp    = n_trntyp
        agtprm_fil.docno     = acm001.docno
        agtprm_fil.acno_clicod =  n_clicod   /* A47-0142  acm001.clicod*/

        agtprm_fil.vehreg    = acm001.vehreg
        agtprm_fil.opnpol    = n_opnpol
        agtprm_fil.prvpol    = n_prvpol
        agtprm_fil.latdat    = acm001.latdat
        agtprm_fil.ac_name   = n_xtm600
        agtprm_fil.addr1     = n_add1
        agtprm_fil.addr2     = n_add2
        agtprm_fil.addr3     = n_add3
        agtprm_fil.addr4     = n_add4
        agtprm_fil.odue6     = n_ltamt   /* credit Limit*/
        agtprm_fil.wcr       = n_wcr
        agtprm_fil.damt      = n_damt  /* 3 ช่อง */
        agtprm_fil.odue      = n_odue  /* 3 ช่อง*/

        agtprm_fil.odue1     = n_odue1
        agtprm_fil.odue2     = n_odue2
        agtprm_fil.odue3     = n_odue3
        agtprm_fil.odue4     = n_odue4
        agtprm_fil.odue5     = n_odue5

        agtprm_fil.startdat  = n_startdat
        /*---A53-0159---
        agtprm_fil.duedat  = IF LOOKUP(n_trntyp,nv_YZCB) = 0 THEN n_duedat ELSE acm001.trndat  /*A46-0142  acm001.trndat */
        ------------*/
        agtprm_fil.duedat    = n_duedat
        agtprm_fil.poldes    = n_poldes
        agtprm_fil.type      = n_type
        agtprm_fil.comdat    = n_comdat.
   
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdCreateold C-Win 
PROCEDURE pdCreateold :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*-----A56-0047---
DEF OUTPUT PARAMETER  n_recid AS RECID.

    DO TRANSACTION :
            CREATE agtprm_fil .
    END.
    
n_recid =  RECID(agtprm_fil).
end A56-0047---------------*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdDel01 C-Win 
PROCEDURE pdDel01 :
/*------------------------------------------------------------------------------
  Purpose:     ถ้า process ซ้ำ กับ asdate เดิม  ใน acproc_fil.type = "01"  แล้ว
                      Delete ข้อมูลเก่าก่อน
                      จากนั้น จึง create  ลงไปใหม่
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR vCountOld AS INT.

/*------------- kan. 08/07/2002
FOR  EACH  agtprm_fil USE-INDEX by_trndat_acno WHERE
           agtprm_fil.trndat >=  n_frdate AND
           agtprm_fil.trndat <=  n_todate AND
           agtprm_fil.acno   >=  n_frac  AND
           agtprm_fil.acno   <=  n_toac AND
           agtprm_fil.asdat   =  n_asdat.
    DELETE agtprm_fil.
END.
-------------*/
/* kan. 08/07/2002---*/
FOR  EACH  agtprm_fil USE-INDEX by_acno WHERE
           agtprm_fil.asdat   =  n_asdat  AND
           agtprm_fil.acno   >=  n_frac   AND
           agtprm_fil.acno   <=  n_toac   AND
           agtprm_fil.trndat >=  n_frdate AND
           agtprm_fil.trndat <=  n_todate.
           
    ACCUM  1 (count).
    
       DISP  "DELETE : " + STRING(agtprm_fil.asdat) + " " + 
                  agtprm_fil.acno + "  " +  agtprm_fil.policy + "  " + agtprm_fil.trntyp + "  " +
                  agtprm_fil.docno + " " + STRING(agtprm_fil.trndat)   @ fiProcess  WITH FRAME  frST .

    DELETE agtprm_fil.
    
END.
/*--- kan.*/

    fiCount = "O = " +  STRING(ACCUM count 1 ) .
    DISP fiCount WITH FRAME frST.

    FIND LAST  acProc_fil  USE-INDEX by_type_asdat  WHERE
               acProc_fil.type = "01"  AND acProc_fil.asdat = n_asdat NO-ERROR.
    IF NOT AVAIL acProc_fil THEN DO:
            CREATE acProc_fil.
            ASSIGN
                acProc_fil.type     = "01"
                acProc_fil.typdesc  = "PROCESS PREMIUM STATEMENT (A4)"
                acProc_fil.asdat    = n_asdat
                acProc_fil.trndatfr = n_frdate
                acProc_fil.trndatto = n_todate
                acProc_fil.entdat   = TODAY
                acProc_fil.enttim   = STRING (TIME, "HH:MM:SS") + ":NO"
                acProc_fil.usrid    = n_user.
    END.
    IF AVAIL acProc_fil THEN DO:
            ASSIGN
                acProc_fil.type     = "01"
                acProc_fil.typdesc  = "PROCESS PREMIUM STATEMENT (A4)"
                acProc_fil.asdat    = n_asdat
                acProc_fil.trndatfr = n_frdate
                acProc_fil.trndatto = n_todate
                acProc_fil.entdat   = TODAY
                acProc_fil.enttim   = STRING (TIME, "HH:MM:SS") + ":NO"
                acProc_fil.usrid    = n_user.
    END. 

/*A56-0047*/
RELEASE acProc_fil.  
RELEASE agtprm_fil.
/*----------*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdDel05 C-Win 
PROCEDURE pdDel05 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* check ข้อมูล 05 เคยมีไหม  ถ้ามีให้ลบ */
    FIND LAST  acProc_fil  USE-INDEX by_type_asdat  WHERE
                                            acProc_fil.type = nv_type NO-ERROR.
    IF AVAIL acProc_fil THEN DO:
        FOR  EACH  agtprm_fil WHERE agtprm_fil.asdat = acProc_fil.asdat AND agtprm_fil.type = nv_type:
            ACCUM  1 (count).
               DISP  "DELETE : " + STRING(agtprm_fil.asdat) + " " + 
                          agtprm_fil.acno + "  " +  agtprm_fil.policy + "  " + agtprm_fil.trntyp + "  " +
                          agtprm_fil.docno + " " + STRING(agtprm_fil.trndat)   @ fiProcess  WITH FRAME  frST .
            DELETE agtprm_fil.
        END.
    END.  /* avail acproc_fil */
    
    fiCount = "O = " +  STRING(ACCUM count 1 ) .
    DISP fiCount WITH FRAME frST.


/* create , update ที่ acproc_fil  เป็น type และ status สำหรับการ process */
    FIND LAST  acProc_fil  USE-INDEX by_type_asdat  WHERE
               acProc_fil.type = nv_type NO-ERROR.
    IF NOT AVAIL acProc_fil THEN DO:
            CREATE acProc_fil.
    END.
    
    ASSIGN
        acProc_fil.type     = nv_type
        acProc_fil.typdesc  = "PROCESS PREMIUM STATEMENT (A4) EVERY DAY"
        acProc_fil.asdat    = n_asdat
        acProc_fil.trndatfr = n_frdate
        acProc_fil.trndatto = n_todate
        acProc_fil.entdat   = TODAY
        acProc_fil.enttim   = STRING (TIME, "HH:MM:SS") + ":NO"
        acProc_fil.usrid    = n_user.

/*A56-0047*/
RELEASE acProc_fil.
RELEASE agtprm_fil.
/*--------*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdDirect_C C-Win 
PROCEDURE pdDirect_C :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:     งาน  Direct Coperate Credit = 15 วัน
------------------------------------------------------------------------------*/
DEF VAR dc_duedate AS DATE FORMAT "99/99/9999".

ASSIGN
   n_day        = 15
   dc_duedate   = nv_effdat + 15
  
   nv_duedate1  = STRING(DAY(dc_duedate),"99")  +  
                  STRING(MONTH(dc_duedate),"99") + 
                  STRING(YEAR(dc_duedate),"9999").
   /*tb1.custyp = "DI".*/
   
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdDirect_P C-Win 
PROCEDURE pdDirect_P :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       งาน  Direct Personal Credit = 0 วัน
------------------------------------------------------------------------------*/
n_day = 0.
nv_duedate1 = STRING(DAY(nv_effdat),"99")  +  
              STRING(MONTH(nv_effdat),"99") + 
              STRING(YEAR(nv_effdat),"9999").
/*tb1.custyp = "DI".*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdFindDuedate C-Win 
PROCEDURE pdFindDuedate :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:    A53-0159   ย้ายมาใส่เป็น Procedure เนื่องจากเกิน Limit Sourcecode
------------------------------------------------------------------------------*/
IF nn_dept = "G"  OR nn_dept = "M" THEN DO: 
           
     IF  SUBSTRI((acm001.insref),2,1) = "C" OR 
         SUBSTRI((acm001.insref),3,1) = "C" THEN
          nv_insref = "C".   /*Customer Type = Corperate */
     ELSE nv_insref = "P".   /*Customer Type = Personal */
   
     FIND FIRST xmm600 USE-INDEX xmm60001      WHERE 
               xmm600.acno   =  acm001.agent  NO-LOCK  NO-ERROR  NO-WAIT.
     IF NOT AVAIL xmm600 THEN NEXT.
     ELSE DO:
          ASSIGN nv_duedate1 = "".
        /*--- หา Aging Day ---*/
        IF xmm600.autoap = YES THEN DO:     /*ง าน Direct */
 
           IF nv_insref = "P" THEN RUN pdDirect_P.   /* CBC-บุคคลธรรมดา*/
           ELSE RUN pdDirect_C.                       /* นิติบุคคล*/
 
           nv_cntaging = 0.
           nv_cntaging = n_asdat - nv_effdat.
          
        END.
        ELSE DO:                           /* งาน Broker */
 
            IF nv_insref = "P" THEN RUN pdBroker_P.   /* บุคคลธรรมดา*/
            ELSE RUN pdBroker_C.                       /* นิติบุคคล*/       
 
        END.
         
     END.   /*end find first*/
    
     n_duedat = DATE(nv_duedate1).

END.   /* End "G","M" */
ELSE DO:   /*--งาน Non Motor ---*/
          
     ASSIGN
       vdueDAY   = 0   vdueMONTH   = 0    vdueYEAR = 0
       vcrperMod = 0   vcrperRound = 0.
   
     ASSIGN
       vdueDAY     = DAY(n_startdat) 
       vdueMONTH   = MONTH(n_startdat)
       vdueYEAR    = YEAR(n_startdat)
       
       vcrperMod   = n_day mod 30            /* ได้จำนวนวัน*/
       vcrperRound = Round( n_day / 30 , 0). /* ได้จำนวนเดือน  ปัดเศษขึ้น*/

     IF n_day = 0 THEN DO:       /* กรณี credit term เป็น 0 */
      
      IF acm001.poltyp = "C90" THEN n_duedat = acm001.trndat.
      ELSE DO: 
          IF acm001.endcnt > 000 THEN DO:
              n_duedat = acm001.trndat.  /*A61-0158*/
             /*-----A61-0158-----
             IF acm001.ac7[14] <> "" THEN DO:
                 n_duedat = DATE(acm001.ac7[14]).
             END.
             ELSE DO:
                 IF n_duedat = ? THEN DO:
                    FIND FIRST uwm100 USE-INDEX uwm10001 WHERE 
                              uwm100.policy = acm001.policy AND
                              uwm100.rencnt = acm001.rencnt AND
                              uwm100.endcnt = acm001.endcnt NO-LOCK NO-ERROR.
                    IF AVAIL uwm100 THEN DO:
                       IF uwm100.endcnt > 000 THEN n_duedat = uwm100.enddat.
                       ELSE n_duedat = uwm100.comdat. 
                    END.
                 END.
             END.
             ------END A61-0158---*/
             
          END.   /* end acm001.rencnt > 000 */
          ELSE DO:   /*---Policy---*/
              n_duedat = acm001.comdat.

              IF n_duedat = ? THEN DO:
                 n_duedat = acm001.trndat.
              END.
          END.    /*end else do Policy */
      END.
     END.
     ELSE IF n_day <> 0 THEN DO:

        IF n_day mod 30  = 0 THEN DO:   /* เต็มเดือน จะได้วันที่มากสุดของเดือนนั้น */
           IF vdueMONTH + vcrperRound - 1  > 12 THEN DO:  /* ข้ามปี  - 1 ลบเดือนตัวเองด้วย */
               ASSIGN
                   vYear   = vdueYear + 1
                   vMonth  = (vdueMONTH +  vcrperRound - 1 ) - 12
                   vDay    = fuMaxDay(DATE(vMonth,1,vYear)).
           END.
           ELSE DO:    /* ปีเดียวกัน*/
               ASSIGN
                  vYear   = vdueYear
                  vMonth  = (vdueMONTH +  vcrperRound - 1 )
                  vDay    = fuMaxDay(DATE(vMonth,1,vYear)).
           END.
        END.  /*end if n_day mod 30 = 0 */
        ELSE DO:   /*ไม่เต็มเดือนจะได้วันที่ 15 ของเดือนนั้น*/
           IF vdueMONTH + vcrperRound - 1  > 12 THEN DO: /* ข้ามปี */
               ASSIGN
                   vYear   = vdueYear + 1
                   vMonth  = (vdueMONTH +  vcrperRound - 1  ) - 12
                   vDay    = 15.
           END.
           ELSE DO:    /* ปีเดียวกัน*/
                  ASSIGN
                      vYear   = vdueYear
                      vMonth  = (vdueMONTH +  vcrperRound - 1 )
                      vDay    = 15.
           END.
        END.  /* end else do*/

        n_duedat = DATE(vMonth,vDay,vYear). /*ASSIGN ค่าให้วันที่วันสุดท้าย*/

     END.  /* end else if n_day <> 0 */

END.  /*--- end else do non motor ---*/

i = 0. 
DO i = 0  TO 2 :   /* over due 1 - 3*/
ASSIGN
     n_odmonth1 = IF (MONTH(n_duedat ) + i )   MOD 12 = 0 THEN 1 ELSE (MONTH(n_duedat ) + i )   MOD 12
     n_odDay1   =  n_odDay1 + fuNumMonth(n_odmonth1, n_duedat ).
END.
i = 0.
DO i = 0  TO 5 :   /* over due 3 - 6*/
ASSIGN
     n_odmonth2 = IF (MONTH(n_duedat ) + i )   MOD 12 = 0 THEN 1 ELSE (MONTH(n_duedat ) + i )   MOD 12
     n_odDay2   = n_odDay2 + fuNumMonth(n_odmonth2, n_duedat ).
END.
i = 0.
DO i = 0  TO 8 :   /* over due 6 - 9*/
ASSIGN
     n_odmonth3 =  IF (MONTH(n_duedat ) + i )   MOD 12 = 0 THEN 1 ELSE (MONTH(n_duedat ) + i )   MOD 12
     n_odDay3   =  n_odDay3 + fuNumMonth(n_odmonth3, n_duedat ).
END.
i = 0.
DO i = 0  TO 11 :   /* over due 9 - 12*/
ASSIGN
     n_odmonth4 =  IF (MONTH(n_duedat ) + i )   MOD 12 = 0 THEN 1 ELSE (MONTH(n_duedat ) + i )   MOD 12
     n_odDay4   =  n_odDay4 + fuNumMonth(n_odmonth4, n_duedat ).
END.
/*-------------- duedat + จำนวนวันใน 3 , 6 , 9 , 12 เดือน   --------------*/
ASSIGN
n_odat1 =  n_duedat  + n_odDay1  /* ได้วันที่วันสุดท้ายในช่วง*/
n_odat2 =  n_duedat  + n_odDay2
n_odat3 =  n_duedat  + n_odDay3
n_odat4 =  n_duedat  + n_odDay4.

/*================== เปรียบเทียบวันที่ As Date กับ duedat & odat1-4 (over due date) ===*/
IF /*n_day <> 0  AND*/ n_asdat <= (n_duedat - fuMaxDay(n_duedat)) THEN DO:  /* เทียบ asdate กับ  วันทีสุดท้าย  ก่อนเดือนสุดท้าย*/
    n_wcr = n_wcr + acm001.bal.        /* with in credit  ไม่ครบกำหนดชำระ */
END.
IF n_asdat > (n_duedat - fuMaxDay(n_duedat)) AND n_asdat <= n_duedat THEN DO:   /*เทียบ asdate กับวันที่ในช่วงเดือนสุดท้าย*/
    n_damt = n_damt + acm001.bal.   /* due Amout  ครบกำหนดชำระ*/
END.
/*-------------------------------*/
IF n_asdat > n_duedat AND n_asdat <= n_odat1 THEN DO:
        n_odue1 = n_odue1 +  acm001.bal.    /*  overdue 1- 3 months*/
END.
IF n_asdat > n_odat1 AND n_asdat <= n_odat2 THEN DO:
        n_odue2 = n_odue2 +  acm001.bal.    /*  overdue 3 - 6 months*/
END.
IF n_asdat > n_odat2 AND n_asdat <= n_odat3 THEN DO:
        n_odue3 = n_odue3 +  acm001.bal.    /*  overdue 6 - 9 months*/
END.
IF n_asdat > n_odat3 AND n_asdat <= n_odat4 THEN DO:
        n_odue4 = n_odue4 +  acm001.bal.    /*  overdue 9 - 12 months*/
END.
IF n_asdat > n_odat4 THEN DO:
        n_odue5 = n_odue5 +  acm001.bal.    /*  over 12  months*/
END.

n_odue = n_odue1 + n_odue2 + n_odue3 + n_odue4 + n_odue5.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdFindDueDateNZI C-Win 
PROCEDURE pdFindDueDateNZI :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:    A53-0159   ย้ายมาใส่เป็น Procedure เนื่องจากเกิน Limit Sourcecode
------------------------------------------------------------------------------*/

IF nn_dept = "G"  OR nn_dept = "M" THEN DO: 
       
       IF  SUBSTRI((acm001.insref),2,1) = "C" OR 
           SUBSTRI((acm001.insref),3,1) = "C" THEN
            nv_insref = "C".   /*Customer Type = Corperate */
       ELSE nv_insref = "P".   /*Customer Type = Personal */
    
       FIND FIRST xmm600 USE-INDEX xmm60001      WHERE 
                  xmm600.acno   =  acm001.agent  NO-LOCK  NO-ERROR  NO-WAIT.
       IF NOT AVAIL xmm600 THEN NEXT.
       ELSE DO:
           nv_duedate1 = "".
           /*--- หา Aging Day ---*/
           IF xmm600.autoap = YES THEN DO:     /*ง าน Direct */
   
              IF nv_insref = "P" THEN RUN pdDirect_P.   /* CBC-บุคคลธรรมดา*/
              ELSE RUN pdDirect_C.                       /* นิติบุคคล*/
    
              nv_cntaging = 0.
              nv_cntaging = n_asdat - nv_effdat.
             
           END.
           ELSE DO:                           /* งาน Broker */
    
               IF nv_insref = "P" THEN RUN pdBroker_P.   /* บุคคลธรรมดา*/
               ELSE RUN pdBroker_C.                      /* นิติบุคคล*/   
           END.
       END.   /*end find first*/

       n_duedat = DATE(nv_duedate1).
END.   /* motor "G","M" */
ELSE DO:   /*--งาน Non Motor ---*/

  
      ASSIGN
      vdueDAY   = 0   vdueMONTH   = 0   vdueYEAR = 0
      vcrperMod = 0   vcrperRound = 0.

      ASSIGN
        vdueDAY     = DAY(n_startdat) 
        vdueMONTH   = MONTH(n_startdat)
        vdueYEAR    = YEAR(n_startdat)
     
        vcrperMod   = n_day mod 30                 /* ได้จำนวนวัน*/
        vcrperRound = Round( n_day / 30 , 0). /* ได้จำนวนเดือน  ปัดเศษขึ้น*/
     

        IF n_day = 0 THEN DO:       /* กรณี credit term เป็น 0 */
          
           n_duedat = acm001.trndat.  /* DATE(MONTH(acm001.trndat) ,fuMaxDay(acm001.trndat) , YEAR(acm001.trndat)) */
           
        END.
        ELSE IF n_day <> 0 THEN DO:
            
            n_duedat = nv_effdat + n_day.
        END.   /*n_day <> 0 */
  END.  /*--- end do else non motor ---*/


i = 0. 
DO i = 0  TO 2 :   /* over due 1 - 3*/
ASSIGN
     n_odmonth1 = IF (MONTH(n_duedat ) + i )   MOD 12 = 0 THEN 1 ELSE (MONTH(n_duedat ) + i )   MOD 12
     n_odDay1   =  n_odDay1 + fuNumMonth(n_odmonth1, n_duedat ).
END.
i = 0.
DO i = 0  TO 5 :   /* over due 3 - 6*/
ASSIGN
     n_odmonth2 = IF (MONTH(n_duedat ) + i )   MOD 12 = 0 THEN 1 ELSE (MONTH(n_duedat ) + i )   MOD 12
     n_odDay2   = n_odDay2 + fuNumMonth(n_odmonth2, n_duedat ).
END.
i = 0.
DO i = 0  TO 8 :   /* over due 6 - 9*/
ASSIGN
     n_odmonth3 =  IF (MONTH(n_duedat ) + i )   MOD 12 = 0 THEN 1 ELSE (MONTH(n_duedat ) + i )   MOD 12
     n_odDay3   =  n_odDay3 + fuNumMonth(n_odmonth3, n_duedat ).
END.
i = 0.
DO i = 0  TO 11 :   /* over due 9 - 12*/
ASSIGN
     n_odmonth4 =  IF (MONTH(n_duedat ) + i )   MOD 12 = 0 THEN 1 ELSE (MONTH(n_duedat ) + i )   MOD 12
     n_odDay4   =  n_odDay4 + fuNumMonth(n_odmonth4, n_duedat ).
END.
/*-------------- duedat + จำนวนวันใน 3 , 6 , 9 , 12 เดือน   --------------*/
ASSIGN
n_odat1 =  n_duedat  + n_odDay1  /* ได้วันที่วันสุดท้ายในช่วง*/
n_odat2 =  n_duedat  + n_odDay2
n_odat3 =  n_duedat  + n_odDay3
n_odat4 =  n_duedat  + n_odDay4.

/*================== เปรียบเทียบวันที่ As Date กับ duedat & odat1-4 (over due date) ===*/
IF n_asdat <= (n_duedat - fuMaxDay(n_duedat)) THEN DO:  /* เทียบ asdate กับ  วันทีสุดท้าย  ก่อนเดือนสุดท้าย*/
    n_wcr = n_wcr + acm001.bal.        /* with in credit  ไม่ครบกำหนดชำระ */
END.
IF n_asdat > (n_duedat - fuMaxDay(n_duedat)) AND n_asdat <= n_duedat THEN DO:   /*เทียบ asdate กับวันที่ในช่วงเดือนสุดท้าย*/
    n_damt = n_damt + acm001.bal.   /* due Amout  ครบกำหนดชำระ*/
END.
/*-------------------------------*/
IF n_asdat > n_duedat AND n_asdat <= n_odat1 THEN DO:
        n_odue1 = n_odue1 +  acm001.bal.    /*  overdue 1- 3 months*/
END.
IF n_asdat > n_odat1 AND n_asdat <= n_odat2 THEN DO:
        n_odue2 = n_odue2 +  acm001.bal.    /*  overdue 3 - 6 months*/
END.
IF n_asdat > n_odat2 AND n_asdat <= n_odat3 THEN DO:
        n_odue3 = n_odue3 +  acm001.bal.    /*  overdue 6 - 9 months*/
END.
IF n_asdat > n_odat3 AND n_asdat <= n_odat4 THEN DO:
        n_odue4 = n_odue4 +  acm001.bal.    /*  overdue 9 - 12 months*/
END.
IF n_asdat > n_odat4 THEN DO:
        n_odue5 = n_odue5 +  acm001.bal.    /*  over 12  months*/
END.

n_odue = n_odue1 + n_odue2 + n_odue3 + n_odue4 + n_odue5.
                

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdFindDueDateNZI_bck C-Win 
PROCEDURE pdFindDueDateNZI_bck :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:    A53-0159   ย้ายมาใส่เป็น Procedure เนื่องจากเกิน Limit Sourcecode
------------------------------------------------------------------------------*/
 /*--A53-0159--*/
/*--- งาน Motor ---
IF acm001.poltyp = "V70" OR acm001.poltyp = "V72" OR
   acm001.poltyp = "V73" OR acm001.poltyp = "V74" THEN DO:  
   ---------------*/
   
FOR EACH xmm031 USE-INDEX xmm03101 NO-LOCK. 

  IF xmm031.dept = "G"  OR xmm031.dept = "M" THEN DO: 
     
   IF xmm031.poltyp = acm001.poltyp THEN DO:
       
       IF  SUBSTRI((acm001.insref),2,1) = "C" OR 
           SUBSTRI((acm001.insref),3,1) = "C" THEN
            nv_insref = "C".   /*Customer Type = Corperate */
       ELSE nv_insref = "P".   /*Customer Type = Personal */
    
       FIND FIRST xmm600 USE-INDEX xmm60001      WHERE 
                  xmm600.acno   =  acm001.agent  NO-LOCK  NO-ERROR  NO-WAIT.
       IF NOT AVAIL xmm600 THEN NEXT.
       ELSE DO:
           nv_duedate1 = "".
           /*--- หา Aging Day ---*/
           IF xmm600.autoap = YES THEN DO:     /*ง าน Direct */
   
              IF nv_insref = "P" THEN RUN pdDirect_P.   /* CBC-บุคคลธรรมดา*/
              ELSE RUN pdDirect_C.                       /* นิติบุคคล*/
    
              nv_cntaging = 0.
              nv_cntaging = n_asdat - nv_effdat.
             
           END.
           ELSE DO:                           /* งาน Broker */
    
               IF nv_insref = "P" THEN RUN pdBroker_P.   /* บุคคลธรรมดา*/
               ELSE RUN pdBroker_C.                      /* นิติบุคคล*/   
           END.
       END.   /*end find first*/

       n_duedat = DATE(nv_duedate1).
   END.

  END.   /* motor "G","M" */
  ELSE DO:   /*--งาน Non Motor ---*/

      IF xmm031.poltyp = acm001.poltyp THEN DO:

         ASSIGN
         vdueDAY   = 0   vdueMONTH   = 0   vdueYEAR = 0
         vcrperMod = 0   vcrperRound = 0.

         ASSIGN
            vdueDAY     = DAY(n_startdat) 
            vdueMONTH   = MONTH(n_startdat)
            vdueYEAR    = YEAR(n_startdat)
         
            vcrperMod   = n_day mod 30                 /* ได้จำนวนวัน*/
            vcrperRound = Round( n_day / 30 , 0). /* ได้จำนวนเดือน  ปัดเศษขึ้น*/
         
    
            IF n_day = 0 THEN DO:       /* กรณี credit term เป็น 0 */
              
               n_duedat = acm001.trndat.  /* DATE(MONTH(acm001.trndat) ,fuMaxDay(acm001.trndat) , YEAR(acm001.trndat)) */
               
            END.
            ELSE IF n_day <> 0 THEN DO:
                
                n_duedat = nv_effdat + n_day.
            END.   /*n_day <> 0 */
      END.    /*xmm031*/
  END.  /*--- end do else non motor ---*/
END.   /*end each xmm031 */
    /*---end A53-0159---*/
    
    /**/
    /*         n_duedat  = n_startdat + n_day - 1.     /*วันที่สุดท้าย  credit  (นับวันแรกด้วย) */*/
    /*------------------ หาจำนวนวันใน 3 , 6 , 9 , 12 เดือน --------------------*/
    /*        n_odmonth1  =  IF (MONTH(n_duedat) + 3 )   MOD 12 = 0 THEN 1 ELSE (MONTH(n_duedat ) + 3 )   MOD 12.
    *         n_odmonth2  =  IF (MONTH(n_duedat ) + 6 )   MOD 12 = 0 THEN 1 ELSE (MONTH(n_duedat ) + 6 )   MOD 12.
    *         n_odmonth3  =  IF (MONTH(n_duedat ) + 9 )   MOD 12 = 0 THEN 1 ELSE (MONTH(n_duedat ) + 9 )   MOD 12.
    *         n_odmonth4  =  IF (MONTH(n_duedat ) + 12 ) MOD 12 = 0 THEN 1 ELSE (MONTH(n_duedat ) + 12 ) MOD 12.*/
    
               i = 0. 
               DO i = 0  TO 2 :   /* over due 1 - 3*/
                ASSIGN
                     n_odmonth1 = IF (MONTH(n_duedat ) + i )   MOD 12 = 0 THEN 1 ELSE (MONTH(n_duedat ) + i )   MOD 12
                     n_odDay1   =  n_odDay1 + fuNumMonth(n_odmonth1, n_duedat ).
               END.
               i = 0.
               DO i = 0  TO 5 :   /* over due 3 - 6*/
                ASSIGN
                     n_odmonth2 = IF (MONTH(n_duedat ) + i )   MOD 12 = 0 THEN 1 ELSE (MONTH(n_duedat ) + i )   MOD 12
                     n_odDay2   = n_odDay2 + fuNumMonth(n_odmonth2, n_duedat ).
               END.
               i = 0.
               DO i = 0  TO 8 :   /* over due 6 - 9*/
                ASSIGN
                     n_odmonth3 =  IF (MONTH(n_duedat ) + i )   MOD 12 = 0 THEN 1 ELSE (MONTH(n_duedat ) + i )   MOD 12
                     n_odDay3   =  n_odDay3 + fuNumMonth(n_odmonth3, n_duedat ).
               END.
               i = 0.
               DO i = 0  TO 11 :   /* over due 9 - 12*/
                ASSIGN
                     n_odmonth4 =  IF (MONTH(n_duedat ) + i )   MOD 12 = 0 THEN 1 ELSE (MONTH(n_duedat ) + i )   MOD 12
                     n_odDay4   =  n_odDay4 + fuNumMonth(n_odmonth4, n_duedat ).
               END.
         /*-------------- duedat + จำนวนวันใน 3 , 6 , 9 , 12 เดือน   --------------*/
        ASSIGN
               n_odat1 =  n_duedat  + n_odDay1  /* ได้วันที่วันสุดท้ายในช่วง*/
               n_odat2 =  n_duedat  + n_odDay2
               n_odat3 =  n_duedat  + n_odDay3
               n_odat4 =  n_duedat  + n_odDay4.
        
         /*================== เปรียบเทียบวันที่ As Date กับ duedat & odat1-4 (over due date) ===*/
                IF /*n_day <> 0  AND*/ n_asdat <= (n_duedat - fuMaxDay(n_duedat)) THEN DO:  /* เทียบ asdate กับ  วันทีสุดท้าย  ก่อนเดือนสุดท้าย*/
                    n_wcr = n_wcr + acm001.bal.        /* with in credit  ไม่ครบกำหนดชำระ */
                END.
                IF n_asdat > (n_duedat - fuMaxDay(n_duedat)) AND n_asdat <= n_duedat THEN DO:   /*เทียบ asdate กับวันที่ในช่วงเดือนสุดท้าย*/
                    n_damt = n_damt + acm001.bal.   /* due Amout  ครบกำหนดชำระ*/
                END.
               /*-------------------------------*/
                IF n_asdat > n_duedat AND n_asdat <= n_odat1 THEN DO:
                        n_odue1 = n_odue1 +  acm001.bal.    /*  overdue 1- 3 months*/
                END.
                IF n_asdat > n_odat1 AND n_asdat <= n_odat2 THEN DO:
                        n_odue2 = n_odue2 +  acm001.bal.    /*  overdue 3 - 6 months*/
                END.
                IF n_asdat > n_odat2 AND n_asdat <= n_odat3 THEN DO:
                        n_odue3 = n_odue3 +  acm001.bal.    /*  overdue 6 - 9 months*/
                END.
                IF n_asdat > n_odat3 AND n_asdat <= n_odat4 THEN DO:
                        n_odue4 = n_odue4 +  acm001.bal.    /*  overdue 9 - 12 months*/
                END.
                IF n_asdat > n_odat4 THEN DO:
                        n_odue5 = n_odue5 +  acm001.bal.    /*  over 12  months*/
                END.
                
                n_odue = n_odue1 + n_odue2 + n_odue3 + n_odue4 + n_odue5.
                
                
    
                

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdFindDuedate_bck C-Win 
PROCEDURE pdFindDuedate_bck :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:    A53-0159   ย้ายมาใส่เป็น Procedure เนื่องจากเกิน Limit Sourcecode
------------------------------------------------------------------------------*/
 /*--A53-0159--*/
FOR EACH xmm031 USE-INDEX xmm03101 NO-LOCK. 

    IF xmm031.dept = "G"  OR xmm031.dept = "M" THEN DO: 

           IF xmm031.poltyp = acm001.poltyp THEN DO:
           
              IF  SUBSTRI((acm001.insref),2,1) = "C" OR 
                  SUBSTRI((acm001.insref),3,1) = "C" THEN
                   nv_insref = "C".   /*Customer Type = Corperate */
              ELSE nv_insref = "P".   /*Customer Type = Personal */
            
              FIND FIRST xmm600 USE-INDEX xmm60001      WHERE 
                        xmm600.acno   =  acm001.agent  NO-LOCK  NO-ERROR  NO-WAIT.
              IF NOT AVAIL xmm600 THEN NEXT.
              ELSE DO:
                   ASSIGN nv_duedate1 = "".
                 /*--- หา Aging Day ---*/
                 IF xmm600.autoap = YES THEN DO:     /*ง าน Direct */
          
                    IF nv_insref = "P" THEN RUN pdDirect_P.   /* CBC-บุคคลธรรมดา*/
                    ELSE RUN pdDirect_C.                       /* นิติบุคคล*/
          
                    nv_cntaging = 0.
                    nv_cntaging = n_asdat - nv_effdat.
                   
                 END.
                 ELSE DO:                           /* งาน Broker */
          
                     IF nv_insref = "P" THEN RUN pdBroker_P.   /* บุคคลธรรมดา*/
                     ELSE RUN pdBroker_C.                       /* นิติบุคคล*/       
          
                 END.
                  
              END.   /*end find first*/
             
              n_duedat = DATE(nv_duedate1).

           END.  /*end of poltyp*/
    END.   /* End "G","M" */
    ELSE DO:   /*--งาน Non Motor ---*/
         IF xmm031.poltyp = acm001.poltyp THEN DO:
          
            ASSIGN
                vdueDAY   = 0   vdueMONTH   = 0    vdueYEAR = 0
                vcrperMod = 0   vcrperRound = 0.
            
            ASSIGN
                vdueDAY     = DAY(n_startdat) 
                vdueMONTH   = MONTH(n_startdat)
                vdueYEAR    = YEAR(n_startdat)
                
                vcrperMod   = n_day mod 30            /* ได้จำนวนวัน*/
                vcrperRound = Round( n_day / 30 , 0). /* ได้จำนวนเดือน  ปัดเศษขึ้น*/

            IF n_day = 0 THEN DO:       /* กรณี credit term เป็น 0 */
               /*---A53-0159---
               n_duedat = acm001.trndat.  /* DATE(MONTH(acm001.trndat) ,fuMaxDay(acm001.trndat) , YEAR(acm001.trndat)) */
               --------------*/
               /*---A53-0159---*/
               IF acm001.poltyp = "C90" THEN n_duedat = acm001.trndat.
               ELSE DO: 
                   IF acm001.endcnt > 000 THEN DO:
                      IF acm001.ac7[14] <> "" THEN DO:
                          n_duedat = DATE(acm001.ac7[14]).
                      END.
                      ELSE DO:
                          IF n_duedat = ? THEN DO:
                             FIND FIRST uwm100 USE-INDEX uwm10001 WHERE 
                                       uwm100.policy = acm001.policy AND
                                       uwm100.rencnt = acm001.rencnt AND
                                       uwm100.endcnt = acm001.endcnt NO-LOCK NO-ERROR.
                             IF AVAIL uwm100 THEN DO:
                                IF uwm100.endcnt > 000 THEN n_duedat = uwm100.enddat.
                                ELSE n_duedat = uwm100.comdat. 
                             END.
                          END.
                      END.
                      
                   END.   /* end acm001.rencnt > 000 */
                   ELSE DO:   /*---Policy---*/
                       n_duedat = acm001.comdat.

                       IF n_duedat = ? THEN DO:
                          n_duedat = acm001.trndat.
                       END.
                   END.    /*end else do Policy */
               END.
            END.
            ELSE IF n_day <> 0 THEN DO:

                 IF n_day mod 30  = 0 THEN DO:   /* เต็มเดือน จะได้วันที่มากสุดของเดือนนั้น */
                    IF vdueMONTH + vcrperRound - 1  > 12 THEN DO:  /* ข้ามปี  - 1 ลบเดือนตัวเองด้วย */
                        ASSIGN
                            vYear   = vdueYear + 1
                            vMonth  = (vdueMONTH +  vcrperRound - 1 ) - 12
                            vDay    = fuMaxDay(DATE(vMonth,1,vYear)).
                    END.
                    ELSE DO:    /* ปีเดียวกัน*/
                        ASSIGN
                           vYear   = vdueYear
                           vMonth  = (vdueMONTH +  vcrperRound - 1 )
                           vDay    = fuMaxDay(DATE(vMonth,1,vYear)).
                    END.
                 END.  /*end if n_day mod 30 = 0 */
                 ELSE DO:   /*ไม่เต็มเดือนจะได้วันที่ 15 ของเดือนนั้น*/
                    IF vdueMONTH + vcrperRound - 1  > 12 THEN DO: /* ข้ามปี */
                        ASSIGN
                            vYear   = vdueYear + 1
                            vMonth  = (vdueMONTH +  vcrperRound - 1  ) - 12
                            vDay    = 15.
                    END.
                    ELSE DO:    /* ปีเดียวกัน*/
                           ASSIGN
                               vYear   = vdueYear
                               vMonth  = (vdueMONTH +  vcrperRound - 1 )
                               vDay    = 15.
                    END.
                 END.  /* end else do*/
        
                 n_duedat = DATE(vMonth,vDay,vYear). /*ASSIGN ค่าให้วันที่วันสุดท้าย*/

            END.  /* end else if n_day <> 0 */

         END.  /*end if poltyp */

  END.  /*--- end else do non motor ---*/

END.   /*for each xmm031 */
/*---end A53-0159---*/
    
    /**/
    /*         n_duedat  = n_startdat + n_day - 1.     /*วันที่สุดท้าย  credit  (นับวันแรกด้วย) */*/
    /*------------------ หาจำนวนวันใน 3 , 6 , 9 , 12 เดือน --------------------*/
    /*        n_odmonth1  =  IF (MONTH(n_duedat) + 3 )   MOD 12 = 0 THEN 1 ELSE (MONTH(n_duedat ) + 3 )   MOD 12.
    *         n_odmonth2  =  IF (MONTH(n_duedat ) + 6 )   MOD 12 = 0 THEN 1 ELSE (MONTH(n_duedat ) + 6 )   MOD 12.
    *         n_odmonth3  =  IF (MONTH(n_duedat ) + 9 )   MOD 12 = 0 THEN 1 ELSE (MONTH(n_duedat ) + 9 )   MOD 12.
    *         n_odmonth4  =  IF (MONTH(n_duedat ) + 12 ) MOD 12 = 0 THEN 1 ELSE (MONTH(n_duedat ) + 12 ) MOD 12.*/
    
               i = 0. 
               DO i = 0  TO 2 :   /* over due 1 - 3*/
                ASSIGN
                     n_odmonth1 = IF (MONTH(n_duedat ) + i )   MOD 12 = 0 THEN 1 ELSE (MONTH(n_duedat ) + i )   MOD 12
                     n_odDay1   =  n_odDay1 + fuNumMonth(n_odmonth1, n_duedat ).
               END.
               i = 0.
               DO i = 0  TO 5 :   /* over due 3 - 6*/
                ASSIGN
                     n_odmonth2 = IF (MONTH(n_duedat ) + i )   MOD 12 = 0 THEN 1 ELSE (MONTH(n_duedat ) + i )   MOD 12
                     n_odDay2   = n_odDay2 + fuNumMonth(n_odmonth2, n_duedat ).
               END.
               i = 0.
               DO i = 0  TO 8 :   /* over due 6 - 9*/
                ASSIGN
                     n_odmonth3 =  IF (MONTH(n_duedat ) + i )   MOD 12 = 0 THEN 1 ELSE (MONTH(n_duedat ) + i )   MOD 12
                     n_odDay3   =  n_odDay3 + fuNumMonth(n_odmonth3, n_duedat ).
               END.
               i = 0.
               DO i = 0  TO 11 :   /* over due 9 - 12*/
                ASSIGN
                     n_odmonth4 =  IF (MONTH(n_duedat ) + i )   MOD 12 = 0 THEN 1 ELSE (MONTH(n_duedat ) + i )   MOD 12
                     n_odDay4   =  n_odDay4 + fuNumMonth(n_odmonth4, n_duedat ).
               END.
         /*-------------- duedat + จำนวนวันใน 3 , 6 , 9 , 12 เดือน   --------------*/
        ASSIGN
               n_odat1 =  n_duedat  + n_odDay1  /* ได้วันที่วันสุดท้ายในช่วง*/
               n_odat2 =  n_duedat  + n_odDay2
               n_odat3 =  n_duedat  + n_odDay3
               n_odat4 =  n_duedat  + n_odDay4.
        
         /*================== เปรียบเทียบวันที่ As Date กับ duedat & odat1-4 (over due date) ===*/
                IF /*n_day <> 0  AND*/ n_asdat <= (n_duedat - fuMaxDay(n_duedat)) THEN DO:  /* เทียบ asdate กับ  วันทีสุดท้าย  ก่อนเดือนสุดท้าย*/
                    n_wcr = n_wcr + acm001.bal.        /* with in credit  ไม่ครบกำหนดชำระ */
                END.
                IF n_asdat > (n_duedat - fuMaxDay(n_duedat)) AND n_asdat <= n_duedat THEN DO:   /*เทียบ asdate กับวันที่ในช่วงเดือนสุดท้าย*/
                    n_damt = n_damt + acm001.bal.   /* due Amout  ครบกำหนดชำระ*/
                END.
               /*-------------------------------*/
                IF n_asdat > n_duedat AND n_asdat <= n_odat1 THEN DO:
                        n_odue1 = n_odue1 +  acm001.bal.    /*  overdue 1- 3 months*/
                END.
                IF n_asdat > n_odat1 AND n_asdat <= n_odat2 THEN DO:
                        n_odue2 = n_odue2 +  acm001.bal.    /*  overdue 3 - 6 months*/
                END.
                IF n_asdat > n_odat2 AND n_asdat <= n_odat3 THEN DO:
                        n_odue3 = n_odue3 +  acm001.bal.    /*  overdue 6 - 9 months*/
                END.
                IF n_asdat > n_odat3 AND n_asdat <= n_odat4 THEN DO:
                        n_odue4 = n_odue4 +  acm001.bal.    /*  overdue 9 - 12 months*/
                END.
                IF n_asdat > n_odat4 THEN DO:
                        n_odue5 = n_odue5 +  acm001.bal.    /*  over 12  months*/
                END.
                
                n_odue = n_odue1 + n_odue2 + n_odue3 + n_odue4 + n_odue5.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdProcess C-Win 
PROCEDURE pdProcess :
/*---- A60-0358  Change index Loop For Each acm001 ให้เร็วขึ้น-----*/
ASSIGN
    vCountRec = 0
    n_type = nv_type
    nv_trnty1 = "M,R,A,B,Y,Z,C,O,T"
    nv_bencod = "COMP,COMG,COMH".

RUN pdDel01.  /* "01" Delete agtprm_fil  &  Create acproc_fil "05"  */ 

RELEASE acproc_fil.   
RELEASE agtprm_fil.

loop_acm001:
FOR EACH  acm001 USE-INDEX acm00191  NO-LOCK WHERE
          acm001.trndat  >=  n_frdate AND
          acm001.trndat  <=  n_todate AND
    INDEX(nv_trnty1,acm001.trnty1) <> 0 AND
          acm001.acno    >=  n_frac   AND
          acm001.acno    <=  n_toac   AND
          acm001.curcod   = "BHT"     AND
         (acm001.bal     <>  0  OR
         (acm001.bal      =  0  AND
          acm001.latdat   >  n_asdat)) :

    IF ( YEAR(acm001.latdat) > 2999 ) AND (acm001.bal = 0)  THEN NEXT  loop_acm001.   


    DISP acm001.trndat
        acm001.trnty1 + 
        acm001.trnty2 
        acm001.docno FORMAT "9999999999"
        acm001.acno  FORMAT "X(10)"
        acm001.policy  
     WITH COLOR BLACK/WHITE NO-LABEL TITLE "Process monthly ..." FRAME frProcess VIEW-AS DIALOG-BOX.

    ASSIGN
        n_day     =  0
        nt_tdat   =  ""     nt_asdat   =  ""    n_xtm600 = ""   n_clicod = ""
        n_acc     =  ""     n_add1     =  ""    n_add2   = ""
        n_add3    =  ""     n_add4     =  ""    n_insur  = ""
        n_trntyp  =  ""     n_mocom    =  0     n_prem   = 0
        n_comp    =  0      n_gross    =  0     n_year   = 0
        n_polyear =  ""     n_cedpol   =  ""    n_opnpol = ""
        n_prvpol  =  ""     n_polbrn   =  ""    n_comdat = ?

        n_comm_comp = 0     n_comm   = 0
        vcom1_t     = 0     vcom2_t  = 0
        n_startdat  = ?     n_duedat = ?
        n_sdmonth   = 0     n_sdyear = 0
        n_poldes    = ""

        n_wcr   = 0
        n_damt  = 0
        n_odue  = 0
        n_odue1 = 0
        n_odue2 = 0
        n_odue3 = 0
        n_odue4 = 0
        n_odue5 = 0
        n_odue6 = 0   
        nn_dept = "" .

    FIND  xmm031 WHERE xmm031.poltyp = acm001.poltyp NO-LOCK NO-ERROR.
    IF AVAIL xmm031 THEN ASSIGN n_poldes = xmm031.poldes
                                nn_dept  = xmm031.dept.


    FIND  xmm600 USE-INDEX xmm60001 WHERE xmm600.acno  = acm001.acno NO-LOCK NO-ERROR.
    IF NOT AVAIL xmm600 THEN NEXT.
    IF xmm600.acccod <> "AG"  THEN DO:
        IF  xmm600.acccod <> "BR" THEN NEXT.
    END.

    ASSIGN n_acc    = xmm600.acno
           n_ltamt  = xmm600.ltamt
           n_clicod = xmm600.clicod. 

   IF nn_dept <> "G" OR nn_dept <> "M" THEN n_day = xmm600.crper.   
   ELSE n_day = 0.

    FIND xtm600 USE-INDEX xtm60001 WHERE
              xtm600.acno = xmm600.acno NO-LOCK NO-ERROR.
    IF AVAIL xtm600  THEN DO:
       n_xtm600  = TRIM(xtm600.ntitle + " " + xtm600.name).
       IF xtm600.addr1 <> "" THEN
          ASSIGN 
             n_add1 = xtm600.addr1
             n_add2 = xtm600.addr2
             n_add3 = xtm600.addr3
             n_add4 = xtm600.addr4.
       ELSE
          ASSIGN
             n_add1 = xmm600.addr1
             n_add2 = xmm600.addr2
             n_add3 = xmm600.addr3
             n_add4 = xmm600.addr4.

    END.
    ELSE
       ASSIGN
          n_xtm600 = TRIM(xmm600.ntitle + " " + xmm600.name) 
          n_add1 = xmm600.addr1
          n_add2 = xmm600.addr2
          n_add3 = xmm600.addr3
          n_add4 = xmm600.addr4.

       ASSIGN
          n_polyear = ""
          n_cedpol  = ""
          n_opnpol  = ""
          n_prvpol  = ""
          n_polbrn  = acm001.branch
          n_comdat  = acm001.comdat.

    n_mocom = 0.

    /* A47-0142 - หาข้อมูลเฉพาะ รายการที่มีการระบุเบอร์ ก/ธ  M, R */
    IF acm001.policy  <> ""  THEN DO:   
        IF  SUBSTR(acm001.policy,3,2) = "70"  THEN DO:
            FIND FIRST uwm100  USE-INDEX  uwm10001 WHERE
                       uwm100.policy = acm001.policy AND
                       uwm100.endno  = acm001.recno
            NO-LOCK  NO-ERROR.
            IF AVAIL uwm100  THEN DO:
                ASSIGN
                    n_polyear = uwm100.undyr
                    n_cedpol  = uwm100.cedpol
                    n_opnpol  = uwm100.opnpol
                    n_prvpol  = uwm100.prvpol
                    vcom1_t   = uwm100.com1_t
                    n_polbrn  = uwm100.branch
                    n_comdat  = uwm100.comdat
                    vcom2_t   = uwm100.com2_t.

                FOR EACH uwd132  WHERE
                         uwd132.policy  = uwm100.policy AND
                         uwd132.rencnt  = uwm100.rencnt AND
                         uwd132.endcnt  = uwm100.endcnt AND 
                         INDEX(nv_bencod,uwd132.bencod)  <> 0 NO-LOCK .

                    n_mocom = n_mocom + uwd132.prem_c.       /* prem_c  เบี้ย พรบ.*/

                END.
             END. /* IF AVAIL uwm100 */
             ELSE DO:
                n_mocom = 0.
             END. /* IF NOT AVAIL uwm100*/

             ASSIGN
                n_prem      = acm001.prem  -  n_mocom /*Prem  หักเบี้ย พรบ. แล้ว*/
                n_comp      = n_mocom                 /*             เบี้ย พรบ. */
                n_comm_comp = vcom2_t                 /*commission  พรบ. */ /*uwm100.com2_t*/
                n_comm      = acm001.comm -  vcom2_t. /*commission  =  uwm100.com1_t*/ /*uwm100.com2_t*/

         END. /* 70 */
         ELSE DO:
             FIND  uwm100 USE-INDEX uwm10001 WHERE
                   uwm100.policy = acm001.policy  AND
                   uwm100.rencnt = acm001.rencnt  AND
                   uwm100.endcnt = acm001.endcnt  NO-LOCK NO-ERROR.
             IF AVAIL uwm100 THEN
                 ASSIGN
                  n_polyear = uwm100.undyr
                  n_cedpol  = uwm100.cedpol
                  n_opnpol  = uwm100.opnpol
                  n_prvpol  = uwm100.prvpol
                  vcom1_t   = uwm100.com1_t
                  n_polbrn  = uwm100.branch
                  n_comdat  = uwm100.comdat.

             IF   (SUBSTR(acm001.policy,3,2) = "72" OR
                   SUBSTR(acm001.policy,3,2) = "73" OR 
                   SUBSTR(acm001.policy,3,2) = "74" )
             THEN DO:
                ASSIGN
                  n_prem      = 0
                  n_comp      = acm001.prem  /*                 เบี้ย พรบ.*/ 
                  n_comm_comp = acm001.comm  /* commission  พรบ.*/ /*uwm100.com1_t */
                  n_comm      = 0.
             END.
             ELSE DO:      /* ทุก Line ยกเว้น 70 , 72 ,73 */
                ASSIGN
                  n_prem      = acm001.prem
                  n_comp      = 0   
                  n_comm_comp = 0  
                  n_comm      = acm001.comm.
             END.

         END.  /* loop หาเบี้ย ในแต่ละ line pol */

     END.   /* หาข้อมูลเฉพาะ รายการที่มีการระบุเบอร์ ก/ธ  M, R    A47-0142 */

 ASSIGN
     n_gross    = n_prem + n_comp + acm001.stamp + acm001.tax
     n_insur    = SUBSTR(acm001.ref,1,35)
     n_trntyp   = acm001.trnty1 + acm001.trnty2.
     
       IF (acm001.branch >= "90" AND acm001.branch <= "98") OR
        (SUBSTR(acm001.policy,1,2) >= "I1" AND 
         SUBSTR(acm001.policy,1,2) <= "I9")  THEN DO:
           nv_effdat = acm001.trndat. 
           RUN pdFindDueDateNZI.
       END.
       ELSE DO:
             RUN pdChkcomdat. 
             RUN pdFindDueDate.  
       END.
       /*-----------*/

 v_trntyp12 = acm001.trnty1 + acm001.trnty2.
 /*--------------------------------------------------------------------*/

    FIND  FIRST agtprm_fil USE-INDEX by_trndat_acno   WHERE
          agtprm_fil.trndat = acm001.trndat  AND
          agtprm_fil.acno   = acm001.acno    AND
          agtprm_fil.poltyp = acm001.poltyp  AND
          agtprm_fil.policy = acm001.policy  AND
          agtprm_fil.endno  = acm001.recno   AND
          agtprm_fil.trntyp = v_trntyp12     AND
          agtprm_fil.docno  = acm001.docno   AND
          agtprm_fil.asdat  = n_asdat
    NO-LOCK NO-ERROR.
    IF NOT AVAIL agtprm_fil THEN DO:

        RUN pdCreate.    /*A56-0047*/

     END. /* IF NOTAVAIL agtprm_fil*/

     RELEASE agtprm_fil.  /*A56-0047*/

    ASSIGN
         n_odmonth1  = 0  n_odmonth2 = 0  n_odmonth3 = 0  n_odmonth4  = 0
         n_odDay1    = 0  n_odDay2   = 0  n_odDay3   = 0  n_odDay4    = 0
         n_odat1     = ?  n_odat2    = ?  n_odat3    = ?  n_odat4     = ?

         nt_tdat  = STRING(n_todate,"99/99/9999")
         nt_asdat = STRING(n_asdat,"99/99/9999").

     vCountRec = vCountRec + 1 .

 RELEASE agtprm_fil.
 /*release acm001.*/

 END.  /*acm001*/

 END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdProcessOld C-Win 
PROCEDURE pdProcessOld :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: คำนวน แบบเดิมของเก่า  
             - เช็คจากวันที่  Trandate  + credit term    
                Trandate ต้อง อยู่ภายในช่วงระยะดังกล่าว
------------------------------------------------------------------------------*/

DEF VAR n_startdat AS  DATE FORMAT "99/99/9999".
DEF VAR n_duedat   AS  DATE FORMAT "99/99/9999".
DEF VAR n_sdmonth  AS  INT.
DEF VAR n_sdyear   AS  INT .

DEF VAR n_odmonth1 AS INT.   /* check month  not over  12   เดือนที่  เพื่อนำไปหาจำนวนวันในแต่ละเดือน */
DEF VAR n_odmonth2 AS INT.
DEF VAR n_odmonth3 AS INT.
DEF VAR n_odmonth4 AS INT.

DEF VAR n_odDay1   AS INT.   /*  count num day in over due 1 - 3   จำนวนวัน ที่เกิน ระยะเวลาให้ credit  3 เดือน */
DEF VAR n_odDay2   AS INT.
DEF VAR n_odDay3   AS INT.
DEF VAR n_odDay4   AS INT.

DEF VAR n_odat1    AS DATE FORMAT "99/99/9999". /* วันที่ ที่เกินจากระยะเวลาให้ credit  เกินไป 3 เดือน*/
DEF VAR n_odat2    AS DATE FORMAT "99/99/9999".
DEF VAR n_odat3    AS DATE FORMAT "99/99/9999".
DEF VAR n_odat4    AS DATE FORMAT "99/99/9999".
DEF VAR n_odat5    AS DATE FORMAT "99/99/9999".

DEF VAR n_type     AS CHAR FORMAT "X(2)".

DEF VAR i AS INT.
vCountRec =  0 .
n_type = "01".

FOR  EACH  agtprm_fil USE-INDEX by_trndat_acno WHERE
           agtprm_fil.trndat >=  n_frdate    AND
           agtprm_fil.trndat <=  n_todate    AND
           agtprm_fil.acno   >=  n_frac      AND
           agtprm_fil.acno   <=  n_toac      AND
           agtprm_fil.asdat   =  n_asdat.

    DELETE agtprm_fil.
    
END.

FIND LAST  acProc_fil  USE-INDEX by_type_asdat   WHERE
                                        acProc_fil.type   = "01"  AND
                                        acProc_fil.asdat  = n_asdat NO-ERROR.
    IF NOT AVAIL acProc_fil THEN DO:       
            CREATE acProc_fil.
            ASSIGN 
                acProc_fil.type      = "01"
                acProc_fil.typdesc   = "PROCESS PREMIUM STATEMENT (A4)"
                acProc_fil.asdat     =  n_asdat
                acProc_fil.trndatfr  =  n_frdate
                acProc_fil.trndatto  =  n_todate
                acProc_fil.entdat    =  TODAY
                acProc_fil.enttim    =  STRING (TIME, "HH:MM:SS")
                acProc_fil.usrid     =  n_user.
    END.    
    IF AVAIL acProc_fil THEN DO:       
            ASSIGN 
                acProc_fil.type      = "01"
                acProc_fil.typdesc   = "PROCESS PREMIUM STATEMENT (A4)"
                acProc_fil.asdat     =  n_asdat
                acProc_fil.trndatfr  =  n_frdate
                acProc_fil.trndatto  =  n_todate
                acProc_fil.entdat    =  TODAY
                acProc_fil.enttim    =  STRING (TIME, "HH:MM:SS")
                acProc_fil.usrid     =  n_user.
    END. 

ASSIGN
    n_wcr   = 0
    n_odue1 = 0
    n_odue2 = 0
    n_odue3 = 0
    n_odue4 = 0
    n_odue5 = 0.

loop_acm001:
FOR EACH  acm001 USE-INDEX acm00103    WHERE
          acm001.acno    >=  n_frac     AND
          acm001.acno    <=  n_toac     AND
          acm001.trndat  >=  n_frdate   AND
          acm001.trndat  <=  n_todate   AND

         (acm001.trnty1   =  "M"        OR
          acm001.trnty1   =  "A"        OR
          acm001.trnty1   =  "R"        OR
          acm001.trnty1   =  "B"        OR
          acm001.trnty1   =  "Y"        OR
          acm001.trnty1   =  "Z"        OR
          acm001.trnty1   =  "C" )      AND

         (acm001.bal     <>  0          OR
         (acm001.bal      =  0          AND
          acm001.latdat   >  n_asdat))  NO-LOCK 

          BREAK  BY acm001.acno
                        BY YEAR(acm001.trndat)
                        BY acm001.trndat
                        BY acm001.policy
                        BY acm001.trnty1 .
    
       DISP  acm001.acno + "  " + acm001.policy + "  " + acm001.trnty1 + "  " + 
                  acm001.trnty2 + "  " + acm001.docno  @ fiProcess  WITH FRAME  frST .

/*  IF Lookup(acm001.clicod,vCliCod) <> 0 OR vCliCod <> "" THEN DO:    /* -----check Client Type Code ----- */*/

        ASSIGN
            n_day      =  0 
            nt_tdat    =  ""    nt_asdat  =  ""    n_xtm600   =  ""
            n_acc      =  ""    n_add1    =  ""    n_add2     =  ""
            n_add3     =  ""    n_add4    =  ""    n_insur    =  ""
            n_trntyp   =  ""    n_mocom   =  0     n_prem     =  0
            n_comp     =  0     n_gross   =  0     n_year     =  0
            n_polyear  =  ""    n_cedpol  =  ""    n_opnpol   =  ""
            n_prvpol   =  ""
           
            n_comm_comp = 0     n_comm    = 0
            n_startdat  = ?     n_duedat  = ?
            n_sdmonth   = 0     n_sdyear  = 0
            n_poldes    = "" .
            
        FIND FIRST xmm031 WHERE xmm031.poltyp = acm001.poltyp NO-LOCK NO-ERROR.
        IF AVAIL xmm031 THEN DO:
                n_poldes = xmm031.poldes.
        END.

        FIND  xmm600 USE-INDEX xmm60001    WHERE
                   xmm600.acno  = acm001.acno  AND 
                  (xmm600.acccod = "AG" OR  xmm600.acccod = "BR") NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL xmm600 THEN NEXT.    
        n_acc     = xmm600.acno.
        n_day     = xmm600.crper.
    
        FIND xtm600 USE-INDEX xtm60001  WHERE
                  xtm600.acno = xmm600.acno NO-LOCK NO-ERROR.
        IF AVAIL xtm600  THEN DO:
           n_xtm600  = xtm600.name.
           IF xtm600.addr1 <> "" THEN
              ASSIGN
                 n_add1    = xtm600.addr1
                 n_add2    = xtm600.addr2
                 n_add3    = xtm600.addr3
                 n_add4    = xtm600.addr4.
           ELSE
              ASSIGN
                 n_add1    = xmm600.addr1
                 n_add2    = xmm600.addr2
                 n_add3    = xmm600.addr3
                 n_add4    = xmm600.addr4 .
        END.
        ELSE 
           ASSIGN
              n_xtm600  = xmm600.name
              n_add1    = xmm600.addr1
              n_add2    = xmm600.addr2
              n_add3    = xmm600.addr3
              n_add4    = xmm600.addr4 .

        FIND FIRST uwm100 USE-INDEX uwm10001   WHERE
                   uwm100.policy  = acm001.policy AND
                   uwm100.rencnt  = acm001.rencnt AND
                   uwm100.endcnt  = acm001.endcnt  NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL uwm100 THEN
           ASSIGN
              n_polyear   =  uwm100.undyr
              n_cedpol    =  uwm100.cedpol
              n_opnpol    =  uwm100.opnpol
              n_prvpol    =  uwm100.prvpol.

        ELSE
           ASSIGN
              n_polyear   =  ""
              n_cedpol    =  ""
              n_opnpol    =  ""
              n_prvpol    =  "".
              
              n_mocom    =  0.
    
        IF  SUBSTR(acm001.policy,3,2)  =  "70"   THEN DO:
    
            FIND FIRST uwm100  USE-INDEX  uwm10001     WHERE
                       uwm100.policy = acm001.policy   AND
                       uwm100.endno  = acm001.recno    NO-LOCK  NO-ERROR.
            IF AVAIL uwm100  THEN  DO:
               FOR EACH uwd132 WHERE
                        uwd132.policy  = uwm100.policy  AND
                        uwd132.rencnt  = uwm100.rencnt  AND
                        uwd132.endcnt  = uwm100.endcnt  NO-LOCK .
    
                   IF uwd132.bencod = "COMP"    OR 
                      uwd132.bencod = "COMG"    OR 
                      uwd132.bencod = "COMH"    THEN
                      
                      n_mocom = n_mocom + uwd132.prem_c.       /* prem_c  เบี้ย พรบ.*/
               END.
            END.
            ELSE DO:
               n_mocom  =   0.
            END.
               
             ASSIGN    
                n_prem      = acm001.prem  -  n_mocom         /* Prem  หักเบี้ย พรบ. แล้ว */
                n_comp      = n_mocom                                       /*                 เบี้ย พรบ.       */ 
                n_comm_comp = uwm100.com2_t                   /* commission  พรบ.      */
                n_comm      = acm001.comm -  uwm100.com2_t .   /* commission  =  uwm100.com1_t          */

        END.
        ELSE IF  SUBSTR(acm001.policy,3,2)  =  "72"   THEN DO:
            ASSIGN
                n_prem      = 0
                n_comp      = acm001.prem                                     /*                 เบี้ย พรบ.       */ 
                n_comm_comp = uwm100.com1_t                        /* commission  พรบ.      */
                n_comm      = 0 .
        END.
        ELSE DO:      /* ทุก Line ยกเว้น 70 , 72 */
            ASSIGN
                n_prem      = acm001.prem
                n_comp      = 0
                n_comm_comp = 0
                n_comm      = acm001.comm.
        END.
        
        n_gross    = n_prem +  n_comp  +  acm001.stamp + acm001.tax.
        
    
        IF acm001.agent = " " THEN
           n_insur    =  acm001.agent +  SUBSTR(acm001.ref,1,35).
        ELSE
           n_insur    =  "[" + acm001.agent + "]" + SUBSTR(acm001.ref,1,35).
    
        n_trntyp   = acm001.trnty1 + acm001.trnty2.

/**/
/*========================== MONTH => KOM ============================*/
    IF  MONTH(n_todate) = 1   OR  MONTH(n_todate) = 3    OR
        MONTH(n_todate) = 5   OR  MONTH(n_todate) = 7    OR
        MONTH(n_todate) = 8   OR  MONTH(n_todate) = 10   OR
        MONTH(n_todate) = 12 THEN DO:

        IF n_day mod 30 = 0 THEN DO:
           n_day1 = n_day / 30.
           n_day2 = 31.
        END.
        ELSE DO:
           IF n_day > 30 AND n_day < 60 THEN DO:
              n_day1 = (n_day / 30).
              n_day2 = n_day mod 30.
           END.
           ELSE IF n_day > 60 THEN DO:
              n_day1 = (n_day / 30) + 1.
              n_day2 = n_day mod 30.
           END.
           ELSE IF n_day < 30 THEN DO:
              n_day1 = 1.
              n_day2 = n_day.
           END.
        END.
    END.  /* kom */
/*====================== MONTH => YON ==============================*/
    IF  MONTH(n_todate) = 4   OR  MONTH(n_todate) = 6    OR
        MONTH(n_todate) = 9   OR  MONTH(n_todate) = 11   THEN DO:

        IF n_day mod 30 = 0 THEN DO:
           n_day1 = n_day / 30.
           n_day2 = 30.
        END.
        ELSE DO:
           IF n_day > 30 AND n_day < 60 THEN DO:
              n_day1 = (n_day / 30).
              n_day2 = n_day mod 30.
           END.
           ELSE IF n_day > 60 THEN DO:
              n_day1 = (n_day / 30) + 1.
              n_day2 = n_day mod 30.
           END.
           ELSE IF n_day < 30 THEN DO:
              n_day1 = 1.
              n_day2 = n_day.
           END.
        END.
    END.  /* yon */

/*============================MONTH => FEB.==========================*/
    IF  MONTH(n_todate) = 2  AND   YEAR(n_todate) mod 4 = 0 THEN DO:
        IF n_day mod 30 = 0 THEN DO:
           n_day1 = n_day / 30.
           n_day2 = 29.
        END.
    END.

    ELSE IF  MONTH(n_todate) = 2  AND   YEAR(n_todate) mod 4 <> 0 THEN DO:
        IF n_day mod 30 = 0 THEN DO:
           n_day1 = n_day / 30.
           n_day2 = 28.
        END.
    END.
/*===================== TRNDAT_YEAR = TODAT_YEAR ========================*/
    IF YEAR(acm001.trndat) = YEAR(n_todate) THEN DO:
        IF (MONTH(n_todate) < MONTH(acm001.trndat) + n_day1)    OR

           (MONTH(n_todate) = MONTH(acm001.trndat) + n_day1     AND
            DAY(n_todate)   < n_day2)                           THEN
           n_wcr  = n_wcr  + acm001.bal.

       IF  MONTH(n_todate) = MONTH(acm001.trndat) + n_day1   AND
           DAY(n_todate)   = n_day2                       THEN
           n_damt = n_damt + acm001.bal.

       IF (MONTH(n_todate) > MONTH(acm001.trndat) + n_day1   AND
          (DAY(n_todate)   < n_day2                       OR
           DAY(n_todate)   = n_day2))                     OR

          (MONTH(n_todate) >= MONTH(acm001.trndat) + n_day1  AND
           DAY(n_todate)   > n_day2)                      THEN
           n_odue = n_odue + acm001.bal.
    END.   /*from = to*/

    ELSE IF YEAR(acm001.trndat) < YEAR(n_todate) THEN DO:
       n_year = (YEAR(n_todate) - YEAR(acm001.trndat)) * 12.
/*=======================================================*/

       IF (MONTH(n_todate) + n_year < MONTH(acm001.trndat) + n_day1)    OR

          (MONTH(n_todate) + n_year = MONTH(acm001.trndat) + n_day1     AND
           DAY(n_todate)   < n_day2)                           THEN
           n_wcr = n_wcr + acm001.bal.

       IF  MONTH(n_todate) = (MONTH(acm001.trndat) + n_day1) - n_year   AND
           DAY(n_todate)   = n_day2                                THEN
           n_damt = n_damt + acm001.bal.

       IF  MONTH(n_todate) > (MONTH(acm001.trndat) + n_day1) - n_year   OR
           (MONTH(n_todate) >=  (MONTH(acm001.trndat) + n_day1) - n_year   AND
           DAY(n_todate)   > n_day2)                               THEN
           n_odue = n_odue + acm001.bal.

    END.   /*from <> to*/

/*--------------------------------------------------------------------*/
/*--------------------------------------------------------------------*/
        FIND agtprm_fil USE-INDEX by_trndat_acno   WHERE
             agtprm_fil.trndat  = acm001.trndat      AND
             agtprm_fil.acno    = acm001.acno        AND
             agtprm_fil.policy  = acm001.policy      AND
             agtprm_fil.trntyp  = acm001.trnty1 + acm001.trnty2  AND
             agtprm_fil.docno   = acm001.docno       AND
             agtprm_fil.asdat   = n_asdat
            NO-ERROR NO-WAIT.
        IF NOT AVAIL agtprm_fil THEN DO:
           CREATE agtprm_fil.
    
        ASSIGN
           agtprm_fil.asdat     =   n_asdat
           agtprm_fil.acno      =   acm001.acno
           agtprm_fil.agent     =   acm001.agent
           agtprm_fil.poltyp    =   acm001.poltyp
           agtprm_fil.polbran   =   SUBSTR(acm001.policy,2,1)
           agtprm_fil.polyear   =   n_polyear
           agtprm_fil.policy    =   acm001.policy
           agtprm_fil.endno     =   acm001.recno
           agtprm_fil.cedpol    =   n_cedpol
           agtprm_fil.insur     =   n_insur
           agtprm_fil.prem      =   n_prem
           agtprm_fil.prem_comp =   n_comp
           agtprm_fil.tax       =   acm001.tax
           agtprm_fil.stamp     =   acm001.stamp
           agtprm_fil.gross     =   n_gross
           agtprm_fil.comm      =   n_comm            
           agtprm_fil.comm_comp =   n_comm_comp
           agtprm_fil.bal       =   acm001.bal
           agtprm_fil.trndat    =   acm001.trndat
           agtprm_fil.credit    =   n_day
           agtprm_fil.trntyp    =   n_trntyp
           agtprm_fil.docno     =   acm001.docno
           agtprm_fil.acno_clicod =  acm001.clicod
           agtprm_fil.vehreg    =   acm001.vehreg
           agtprm_fil.opnpol    =   n_opnpol
           agtprm_fil.prvpol    =   n_prvpol
           agtprm_fil.latdat    =   acm001.latdat
           agtprm_fil.ac_name   =   n_xtm600
           agtprm_fil.addr1     =   n_add1
           agtprm_fil.addr2     =   n_add2
           agtprm_fil.addr3     =   n_add3
           agtprm_fil.addr4     =   n_add4
           agtprm_fil.wcr       =   n_wcr
           agtprm_fil.damt      =   n_damt                 /* 3 ช่อง*/
           agtprm_fil.odue      =   n_odue                  /* 3 ช่อง*/ 
                                    
           agtprm_fil.odue1     =   n_odue1
           agtprm_fil.odue2     =   n_odue2
           agtprm_fil.odue3     =   n_odue3
           agtprm_fil.odue4     =   n_odue4
           agtprm_fil.odue5     =   n_odue5
           agtprm_fil.startdat  =   n_startdat
           agtprm_fil.duedat    =   n_duedat
           agtprm_fil.poldes    =   n_poldes
           agtprm_fil.type      =   n_type.
                                            
       ASSIGN   
            n_odmonth1 = 0  n_odmonth2 = 0  n_odmonth3 = 0  n_odmonth4 = 0
            n_odDay1   = 0  n_odDay2   = 0  n_odDay3   = 0  n_odDay4   = 0
            n_odat1    = ?  n_odat2    = ?  n_odat3    = ?  n_odat4    = ?
            
            n_wcr   = 0
            n_odue1 = 0
            n_odue2 = 0
            n_odue3 = 0
            n_odue4 = 0
            n_odue5 = 0.

        ASSIGN
            nt_tdat  = STRING(n_todate,"99/99/9999")
            nt_asdat = STRING(n_asdat,"99/99/9999").
        
        vCountRec = vCountRec + 1 .
      END. /* CREATE */  

/*    END.    /* vClicode */   */
   
END.  /*acm001*/


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdProcessOld2 C-Win 
PROCEDURE pdProcessOld2 :
/*  Notes: หลักการนับยอดที่อยู่ในเครดิต และ ค้างชำระ STATEMENT (A4)
              -  นำ Tran Date มา  ยึดวันที่ 1 ของเดือนถัดไป เริ่มนับระยะเวลาให้ credit 
              - นำ  วันที่ 1 ของเดือนถัดไป  +  credit term( 30 วัน = 1 เดือน )   แล้วจะได้ระยะเวลาสิ้นสุด การให้  credit
                ข่อง within Credit คือ กรมธรรม์ที่อยู่ก่อน เดือนครบกำหนดชำระ
                       due Amount คือ กรมธรรม์ของเดือนครบกำหนดชำระ
                       overdue   คือ กรมธรรม์ที่เกินกำหนด
                 กรณี credit Term =  0  กรมธรรม์จะ overdue
              -  จากนั้นนำวันที่สิ้นสุดการให้  credit  ไปหา วันที่ช่วงระยะเวลาการค้างชำระ  ทุกช่วง
              - ได้วันที่ในแต่ละช่วงแล้วจึงนำ   As date มาเทียบ  จากนั้นจึงนำไปเก็บ ในตัวแปรต่าง ๆ  แล้วแสดงผลต่อไป*/
/*
DEF VAR n_startdat  AS DATE FORMAT "99/99/9999".
DEF VAR n_duedat   AS DATE FORMAT "99/99/9999".
DEF VAR n_sdmonth AS INT. /*start date*/
DEF VAR n_sdyear AS INT.
/* หาวันที่เริ่มต้น  ต้องเป็นวันที่วันสุดท้ายของเดือนนั้น ๆ*/
DEF VAR vYear AS INT.
DEF VAR vMonth AS INT.
DEF VAR vDay  AS INT.
DEF VAR vdueDAY  AS INT.
DEF VAR vdueMONTH AS INT.
DEF VAR vdueYEAR AS INT.
DEF VAR vcrperMod AS INT.
DEF VAR vcrperTrun AS INT.
DEF VAR vcrperRound AS INT.
/**/
DEF VAR n_odmonth1 AS INT. /*month  not over  12   เดือนที่  เพื่อนำไปหาจำนวนวันในแต่ละเดือน */
DEF VAR n_odmonth2 AS INT.
DEF VAR n_odmonth3 AS INT.
DEF VAR n_odmonth4 AS INT.
DEF VAR n_odDay1  AS INT. /*count num day in over due 1 - 3   จำนวนวัน ที่เกิน ระยะเวลาให้ credit  3 เดือน */
DEF VAR n_odDay2  AS INT.
DEF VAR n_odDay3  AS INT.
DEF VAR n_odDay4  AS INT.

DEF VAR n_odat1 AS  DATE FORMAT "99/99/9999". /* วันที่ ที่เกินจากระยะเวลาให้ credit  เกินไป 3 เดือน*/
DEF VAR n_odat2 AS  DATE FORMAT "99/99/9999".
DEF VAR n_odat3 AS  DATE FORMAT "99/99/9999".
DEF VAR n_odat4 AS  DATE FORMAT "99/99/9999".
DEF VAR n_odat5 AS  DATE FORMAT "99/99/9999".
DEF VAR n_type AS CHAR FORMAT "X(2)".

DEF VAR i AS INT.
DEF VAR vcom1_t  AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR vcom2_t  AS DECI FORMAT ">>,>>>,>>>,>>9.99-".

vCountRec = 0 .
n_type = nv_type.  

    RUN pdDel01.  /* "01" Delete agtprm_fil  &  Create acproc_fil
                                   "05"  */ 
    
loop_acm001:
FOR EACH  acm001 USE-INDEX acm00103  NO-LOCK WHERE
          acm001.acno    >=  n_frac  AND
          acm001.acno    <=  n_toac AND
          acm001.curcod  = "BHT" AND    /**/
          acm001.trndat  >=  n_frdate AND
          acm001.trndat  <=  n_todate AND
          /* kan. A46-0015   เพิ่ม type = O, T---*/
         (acm001.trnty1   = "M" OR
          acm001.trnty1   = "R" OR
          acm001.trnty1   = "A" OR
          acm001.trnty1   = "B" OR
          acm001.trnty1   = "Y" OR
          acm001.trnty1   = "Z" OR
          acm001.trnty1   = "C" OR
          acm001.trnty1   = "O" OR
          acm001.trnty1   = "T" )  AND
          /*--- kan.*/
         (acm001.bal     <> 0  OR
         (acm001.bal      =  0  AND
          acm001.latdat   >  n_asdat)) :
         
/*          BREAK  BY acm001.acno
 *                         BY YEAR(acm001.trndat)
 *                         BY acm001.trndat
 *                         BY acm001.policy
 *                         BY acm001.trnty1 :*/
    
       DISP  "PROCESS : " + acm001.acno + "  " + acm001.policy + "  " + acm001.trnty1 + "  " +
                  acm001.trnty2 + "  " + acm001.docno  @ fiProcess  WITH FRAME  frST .
        ASSIGN
            n_day      =  0
            nt_tdat    =  ""        nt_asdat   =  ""      n_xtm600   =  ""
            n_acc      =  ""       n_add1     =  ""      n_add2     =  ""
            n_add3    =  ""      n_add4     =  ""      n_insur    =  ""
            n_trntyp   =  ""      n_mocom    =  0     n_prem     =  0
            n_comp   =  0       n_gross    =  0       n_year     =  0
            n_polyear  =  ""   n_cedpol   =  ""    n_opnpol   =  ""
            n_prvpol   =  ""    n_polbrn = ""        n_comdat =?
           
            n_comm_comp = 0   n_comm = 0
            vcom1_t = 0        vcom2_t = 0
            n_startdat = ?     n_duedat = ?
            n_sdmonth = 0    n_sdyear = 0
            n_poldes    = ""
        
            n_wcr  = 0
            n_damt = 0
            n_odue = 0
            n_odue1 = 0
            n_odue2 = 0
            n_odue3 = 0
            n_odue4 = 0
            n_odue5 = 0. 


        FIND FIRST xmm031 WHERE xmm031.poltyp = acm001.poltyp NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL xmm031 THEN DO:
                n_poldes = xmm031.poldes.
        END.

        FIND FIRST xmm600 USE-INDEX xmm60001 WHERE
                   xmm600.acno  = acm001.acno AND 
                  (xmm600.acccod = "AG" OR  xmm600.acccod = "BR") NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL xmm600 THEN NEXT.
        ASSIGN
            n_acc  = xmm600.acno
            n_day  = xmm600.crper
            n_ltamt = xmm600.ltamt.
    
        FIND FIRST xtm600 USE-INDEX xtm60001 WHERE
                  xtm600.acno = xmm600.acno NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL xtm600  THEN DO:
           n_xtm600  = xtm600.name.
           IF xtm600.addr1 <> "" THEN
              ASSIGN
                 n_add1 = xtm600.addr1
                 n_add2 = xtm600.addr2
                 n_add3 = xtm600.addr3
                 n_add4 = xtm600.addr4.
           ELSE
              ASSIGN
                 n_add1 = xmm600.addr1
                 n_add2 = xmm600.addr2
                 n_add3 = xmm600.addr3
                 n_add4 = xmm600.addr4 .
        END.
        ELSE 
           ASSIGN
              n_xtm600 = xmm600.name
              n_add1 = xmm600.addr1
              n_add2 = xmm600.addr2
              n_add3 = xmm600.addr3
              n_add4 = xmm600.addr4 .

        FIND FIRST uwm100 USE-INDEX uwm10001 WHERE
                   uwm100.policy  = acm001.policy AND
                   uwm100.rencnt  = acm001.rencnt AND
                   uwm100.endcnt  = acm001.endcnt  NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL uwm100 THEN
           ASSIGN
              n_polyear = uwm100.undyr
              n_cedpol  = uwm100.cedpol
              n_opnpol  = uwm100.opnpol
              n_prvpol   = uwm100.prvpol
              vcom1_t   = uwm100.com1_t
              n_polbrn  = uwm100.branch
              n_comdat = uwm100.comdat.
        ELSE
           ASSIGN
              n_polyear = ""
              n_cedpol = ""
              n_opnpol = ""
              n_prvpol = ""
              n_polbrn = acm001.branch
              n_comdat = acm001.comdat.

              n_mocom    =  0.

        IF  SUBSTR(acm001.policy,3,2) = "70"  THEN DO:
            FIND FIRST uwm100  USE-INDEX  uwm10001 WHERE
                       uwm100.policy = acm001.policy  AND
                       uwm100.endno  = acm001.recno NO-LOCK  NO-ERROR NO-WAIT.
            IF AVAIL uwm100  THEN  DO:
                vcom2_t = uwm100.com2_t.
               FOR EACH uwd132  WHERE
                        uwd132.policy  = uwm100.policy  AND
                        uwd132.rencnt  = uwm100.rencnt  AND
                        uwd132.endcnt  = uwm100.endcnt NO-LOCK .

                   IF uwd132.bencod = "COMP"     OR
                      uwd132.bencod = "COMG"     OR
                      uwd132.bencod = "COMH"    THEN

                      n_mocom = n_mocom + uwd132.prem_c.       /* prem_c  เบี้ย พรบ.*/
               END.
            END.
            ELSE DO:
               n_mocom  =   0.
            END.

             ASSIGN    
                n_prem    = acm001.prem  -  n_mocom            /*Prem  หักเบี้ย พรบ. แล้ว*/
                n_comp    = n_mocom                                       /*               เบี้ย พรบ. */ 
                n_comm_comp = vcom2_t                                /*commission  พรบ. */ /*uwm100.com2_t*/
                n_comm   = acm001.comm -  vcom2_t . /*commission  =  uwm100.com1_t*/ /*uwm100.com2_t*/
                
        END.
        ELSE IF   (SUBSTR(acm001.policy,3,2)  =  "72"   OR
                         SUBSTR(acm001.policy,3,2)   =  "73" )  
                        THEN DO:
            ASSIGN
                n_prem    =  0
                n_comp    = acm001.prem                       /*                 เบี้ย พรบ.*/ 
                n_comm_comp = acm001.comm                      /* commission  พรบ.*/ /*uwm100.com1_t */
                n_comm   = 0 .
        END.
        ELSE DO:      /* ทุก Line ยกเว้น 70 , 72 ,73 */
            ASSIGN
                n_prem    = acm001.prem
                n_comp    = 0
                n_comm_comp =  0
                n_comm   = acm001.comm.
        END.
        
        n_gross    = n_prem +  n_comp  +  acm001.stamp + acm001.tax.

        n_insur = SUBSTR(acm001.ref,1,35) .   
        n_trntyp   = acm001.trnty1 + acm001.trnty2.
    /*=========== CHECK TRNDAT with in & over due ==========*/
            n_sdmonth = MONTH(acm001.trndat).
            n_sdyear  = YEAR(acm001.trndat).
            n_startdat = IF n_sdmonth = 12 THEN DATE (1,1,n_sdyear + 1 )
                                                                   ELSE DATE(n_sdmonth + 1,1,n_sdyear).  /*วันที่เริ่มนับ credit*/
/* หา  n_duedat วันที่สุดท้ายที่อยู่ใน credit*/
ASSIGN
    vdueDAY = 0   vdueMONTH = 0   vdueYEAR = 0
    vcrperMod = 0 vcrperRound = 0 .

         ASSIGN
            vdueDAY = DAY(n_startdat) 
            vdueMONTH = MONTH(n_startdat)
            vdueYEAR    = YEAR(n_startdat)

            vcrperMod    = n_day mod 30                       /* ได้จำนวนวัน  */
            vcrperRound = Round( n_day / 30 , 0) .      /* ได้จำนวนเดือน  ปัดเศษขึ้น*/
            
    IF n_day = 0 THEN DO:       /* กรณี credit term เป็น 0 */
        n_duedat = acm001.trndat.  /* DATE(MONTH(acm001.trndat) ,fuMaxDay(acm001.trndat) , YEAR(acm001.trndat)) */
    END.
    ELSE IF n_day <> 0 THEN DO: 
        IF n_day mod 30  = 0 THEN DO:   /* เต็มเดือน จะได้วันที่มากสุดของเดือนนั้น */
            IF vdueMONTH + vcrperRound - 1  > 12 THEN DO:   /* ข้ามปี  - 1 ลบเดือนตัวเองด้วย */
                ASSIGN
                    vYear   = vdueYear + 1 
                    vMonth = (vdueMONTH +  vcrperRound - 1 ) - 12.
                    vDay    = fuMaxDay(DATE(vMonth,1,vYear)).
            END.
            ELSE DO:               /* ปีเดียวกัน*/
                ASSIGN
                    vYear   = vdueYear 
                    vMonth = (vdueMONTH +  vcrperRound - 1 ) .
                    vDay    = fuMaxDay(DATE(vMonth,1,vYear)).
            END.
        END.
        ELSE DO:                 /*ไม่เต็มเดือนจะได้วันที่ 15 ของเดือนนั้น*/
            IF vdueMONTH + vcrperRound - 1  > 12 THEN DO:   /* ข้ามปี */
                ASSIGN
                    vYear   = vdueYear + 1 
                    vMonth = (vdueMONTH +  vcrperRound - 1  ) - 12.
                    vDay    = 15.
            END.
            ELSE DO:            /* ปีเดียวกัน*/
                ASSIGN
                    vYear   = vdueYear 
                    vMonth = (vdueMONTH +  vcrperRound - 1  ) .
                    vDay    = 15.
            END.
        END.
            
            n_duedat = DATE(vMonth,vDay,vYear). /*ASSIGN ค่าให้วันที่วันสุดท้าย*/
       END.
/**/  
/*            n_duedat  = n_startdat + n_day - 1 .         /*วันที่สุดท้าย  credit  (นับวันแรกด้วย) */*/
      /*------------------ หาจำนวนวันใน 3 , 6 , 9 , 12 เดือน --------------------*/
/*           n_odmonth1  =  IF (MONTH(n_duedat) + 3 )   MOD 12 = 0 THEN 1 ELSE (MONTH(n_duedat ) + 3 )   MOD 12.
 *            n_odmonth2  =  IF (MONTH(n_duedat ) + 6 )   MOD 12 = 0 THEN 1 ELSE (MONTH(n_duedat ) + 6 )   MOD 12.
 *            n_odmonth3  =  IF (MONTH(n_duedat ) + 9 )   MOD 12 = 0 THEN 1 ELSE (MONTH(n_duedat ) + 9 )   MOD 12.
 *            n_odmonth4  =  IF (MONTH(n_duedat ) + 12 ) MOD 12 = 0 THEN 1 ELSE (MONTH(n_duedat ) + 12 ) MOD 12.*/
           i = 0. 
           DO i = 0  TO 2  :   /* over due 1 - 3*/
                 n_odmonth1 = IF (MONTH(n_duedat ) + i )   MOD 12 = 0 THEN 1 ELSE (MONTH(n_duedat ) + i )   MOD 12.
                 n_odDay1 =  n_odDay1 + fuNumMonth(n_odmonth1, n_duedat ).
           END.
           i = 0.      
           DO i = 0  TO 5  :   /* over due 3 - 6*/
                 n_odmonth2  =  IF (MONTH(n_duedat ) + i )   MOD 12 = 0 THEN 1 ELSE (MONTH(n_duedat ) + i )   MOD 12.
                 n_odDay2 =  n_odDay2 + fuNumMonth(n_odmonth2, n_duedat ).
           END.
           i = 0.      
           DO i = 0  TO 8  :   /* over due 6 - 9*/
                 n_odmonth3  =  IF (MONTH(n_duedat ) + i )   MOD 12 = 0 THEN 1 ELSE (MONTH(n_duedat ) + i )   MOD 12.
                 n_odDay3 =  n_odDay3 + fuNumMonth(n_odmonth3, n_duedat ).
           END. 
           i = 0.
           DO i = 0  TO 11  :   /* over due 9 - 12*/
                 n_odmonth4  =  IF (MONTH(n_duedat ) + i )   MOD 12 = 0 THEN 1 ELSE (MONTH(n_duedat ) + i )   MOD 12.
                 n_odDay4 =  n_odDay4 + fuNumMonth(n_odmonth4, n_duedat ).
           END.
     /*-------------- duedat + จำนวนวันใน 3 , 6 , 9 , 12 เดือน   --------------*/
     ASSIGN
           n_odat1 =   n_duedat  +  n_odDay1  /* ได้วันที่วันสุดท้ายในช่วง*/
           n_odat2 =   n_duedat  + n_odDay2
           n_odat3 =   n_duedat  + n_odDay3
           n_odat4 =   n_duedat  + n_odDay4 .
     /*================== เปรียบเทียบวันที่ As Date กับ duedat & odat1-4 (over due date) ===*/
            IF /*n_day <> 0  AND*/ n_asdat <= (n_duedat - fuMaxDay(n_duedat)) THEN DO:  /* เทียบ asdate กับ  วันทีสุดท้าย  ก่อนเดือนสุดท้าย*/
                n_wcr = n_wcr + acm001.bal .                  /* with in credit  ไม่ครบกำหนดชำระ */
            END.
            IF n_asdat > (n_duedat - fuMaxDay(n_duedat)) AND n_asdat <= n_duedat THEN DO:   /*เทียบ asdate กับวันที่ในช่วงเดือนสุดท้าย*/
                n_damt = n_damt + acm001.bal .             /* due Amout  ครบกำหนดชำระ*/
            END.
           /*-------------------------------*/ 
            IF n_asdat > n_duedat AND n_asdat <= n_odat1 THEN DO:
                    n_odue1 = n_odue1 +  acm001.bal.         /*  overdue 1- 3 months*/
            END.
            IF n_asdat > n_odat1 AND n_asdat <= n_odat2 THEN DO:
                    n_odue2 = n_odue2 +  acm001.bal.         /*  overdue 3 - 6 months*/
            END.
            IF n_asdat > n_odat2 AND n_asdat <= n_odat3 THEN DO:
                    n_odue3 = n_odue3 +  acm001.bal.         /*  overdue 6 - 9 months*/
            END.
            IF n_asdat > n_odat3 AND n_asdat <= n_odat4 THEN DO:
                    n_odue4 = n_odue4 +  acm001.bal.         /*  overdue 9 - 12 months*/
            END.
            IF n_asdat > n_odat4 THEN DO:
                    n_odue5 = n_odue5 +  acm001.bal.        /*  over 12  months*/
            END.
            
            n_odue = n_odue1 + n_odue2 + n_odue3 + n_odue4 + n_odue5 .

    v_trntyp12 = acm001.trnty1 + acm001.trnty2 .
   /*--------------------------------------------------------------------*/
  
  
       FIND  First agtprm_fil USE-INDEX by_trndat_acno   WHERE
             agtprm_fil.trndat = acm001.trndat   AND
             agtprm_fil.acno  = acm001.acno     AND
             agtprm_fil.policy = acm001.policy   AND
             agtprm_fil.trntyp = v_trntyp12 AND
             agtprm_fil.docno = acm001.docno AND
             agtprm_fil.asdat = n_asdat   NO-ERROR NO-WAIT.
       IF NOT AVAIL agtprm_fil THEN DO:
      
       RUN pdCreate (OUTPUT n_recid). /* Create Transaction*/
       
        FIND FIRST  agtprm_fil where recid(agtprm_fil)  = n_recid NO-ERROR .
        IF  AVAIL agtprm_fil  THEN DO:
         ASSIGN
             agtprm_fil.asdat  =  n_asdat
             agtprm_fil.acno   =  acm001.acno
             agtprm_fil.agent  =  acm001.agent
             agtprm_fil.poltyp =  acm001.poltyp
             agtprm_fil.polbran = n_polbrn
             agtprm_fil.polyear =  n_polyear
             agtprm_fil.policy  =  acm001.policy
             agtprm_fil.endno  =  acm001.recno
             agtprm_fil.cedpol =  n_cedpol
             agtprm_fil.insur  =  n_insur
             agtprm_fil.prem  =  n_prem
             agtprm_fil.prem_comp = n_comp
             agtprm_fil.tax     =  acm001.tax
             agtprm_fil.stamp = acm001.stamp
             agtprm_fil.gross = n_gross
             agtprm_fil.comm =  n_comm         agtprm_fil.comm_comp     =  n_comm_comp
             agtprm_fil.bal     =  acm001.bal
             agtprm_fil.trndat =  acm001.trndat
             agtprm_fil.credit =  n_day
             agtprm_fil.trntyp =  n_trntyp
             agtprm_fil.docno =  acm001.docno
             agtprm_fil.acno_clicod =  acm001.clicod
  
             agtprm_fil.vehreg =  acm001.vehreg
             agtprm_fil.opnpol =  n_opnpol
             agtprm_fil.prvpol  =  n_prvpol
             agtprm_fil.latdat   =  acm001.latdat
             agtprm_fil.ac_name =  n_xtm600
             agtprm_fil.addr1 =  n_add1
             agtprm_fil.addr2 =  n_add2
             agtprm_fil.addr3 =  n_add3
             agtprm_fil.addr4 =  n_add4
             agtprm_fil.odue6 = n_ltamt   /* credit Limit*/
             agtprm_fil.wcr    = n_wcr
             agtprm_fil.damt = n_damt  /* 3 ช่อง */
             agtprm_fil.odue = n_odue  /* 3 ช่อง*/
  
             agtprm_fil.odue1 = n_odue1
             agtprm_fil.odue2 = n_odue2
             agtprm_fil.odue3 = n_odue3
             agtprm_fil.odue4 = n_odue4
             agtprm_fil.odue5 = n_odue5 
  
             agtprm_fil.startdat = n_startdat
             agtprm_fil.duedat  = n_duedat
             agtprm_fil.poldes  = n_poldes
             agtprm_fil.type      = n_type
             agtprm_fil.comdat = n_comdat  .
         END.
         
        END. /* IF NOTAVAIL agtprm_fil*/

       ASSIGN
            n_odmonth1  = 0   n_odmonth2  = 0  n_odmonth3  = 0 n_odmonth4  = 0
            n_odDay1    = 0    n_odDay2    = 0   n_odDay3    = 0   n_odDay4    = 0
            n_odat1        = ?   n_odat2        = ?  n_odat3       = ?   n_odat4         = ?.

        ASSIGN
            nt_tdat  = STRING(n_todate,"99/99/9999")
            nt_asdat = STRING(n_asdat,"99/99/9999").

        vCountRec = vCountRec + 1 .
release agtprm_fil.
release acm001.

END.  /*acm001*/

*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdProcessOld3 C-Win 
PROCEDURE pdProcessOld3 :
/*  Notes: หลักการนับยอดที่อยู่ในเครดิต และ ค้างชำระ STATEMENT (A4)
              -  นำ Tran Date มา  ยึดวันที่ 1 ของเดือนถัดไป เริ่มนับระยะเวลาให้ credit 
              - นำ  วันที่ 1 ของเดือนถัดไป  +  credit term( 30 วัน = 1 เดือน )   แล้วจะได้ระยะเวลาสิ้นสุด การให้  credit
                ข่อง within Credit คือ กรมธรรม์ที่อยู่ก่อน เดือนครบกำหนดชำระ
                       due Amount คือ กรมธรรม์ของเดือนครบกำหนดชำระ
                       overdue   คือ กรมธรรม์ที่เกินกำหนด
                 กรณี credit Term =  0  กรมธรรม์จะ overdue
              -  จากนั้นนำวันที่สิ้นสุดการให้  credit  ไปหา วันที่ช่วงระยะเวลาการค้างชำระ  ทุกช่วง
              - ได้วันที่ในแต่ละช่วงแล้วจึงนำ   As date มาเทียบ  จากนั้นจึงนำไปเก็บ ในตัวแปรต่าง ๆ  แล้วแสดงผลต่อไป*/

DEF VAR n_startdat  AS DATE FORMAT "99/99/9999".
DEF VAR n_duedat   AS DATE FORMAT "99/99/9999".
DEF VAR n_sdmonth AS INT. /*start date*/
DEF VAR n_sdyear AS INT.
/* หาวันที่เริ่มต้น  ต้องเป็นวันที่วันสุดท้ายของเดือนนั้น ๆ*/
DEF VAR vYear AS INT.
DEF VAR vMonth AS INT.
DEF VAR vDay  AS INT.
DEF VAR vdueDAY  AS INT.
DEF VAR vdueMONTH AS INT.
DEF VAR vdueYEAR AS INT.
DEF VAR vcrperMod AS INT.
DEF VAR vcrperTrun AS INT.
DEF VAR vcrperRound AS INT.
/**/
DEF VAR n_odmonth1 AS INT. /*month  not over  12   เดือนที่  เพื่อนำไปหาจำนวนวันในแต่ละเดือน */
DEF VAR n_odmonth2 AS INT.
DEF VAR n_odmonth3 AS INT.
DEF VAR n_odmonth4 AS INT.
DEF VAR n_odDay1  AS INT. /*count num day in over due 1 - 3   จำนวนวัน ที่เกิน ระยะเวลาให้ credit  3 เดือน */
DEF VAR n_odDay2  AS INT.
DEF VAR n_odDay3  AS INT.
DEF VAR n_odDay4  AS INT.

DEF VAR n_odat1 AS  DATE FORMAT "99/99/9999". /* วันที่ ที่เกินจากระยะเวลาให้ credit  เกินไป 3 เดือน*/
DEF VAR n_odat2 AS  DATE FORMAT "99/99/9999".
DEF VAR n_odat3 AS  DATE FORMAT "99/99/9999".
DEF VAR n_odat4 AS  DATE FORMAT "99/99/9999".
DEF VAR n_odat5 AS  DATE FORMAT "99/99/9999".
DEF VAR n_type AS CHAR FORMAT "X(2)".

DEF VAR i AS INT.
DEF VAR vcom1_t  AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR vcom2_t  AS DECI FORMAT ">>,>>>,>>>,>>9.99-".

vCountRec = 0 .
n_type = nv_type.  

    RUN pdDel01.  /* "01" Delete agtprm_fil  &  Create acproc_fil
                                   "05"  */ 

loop_acm001:
FOR EACH  acm001 USE-INDEX acm00103  NO-LOCK WHERE
          acm001.acno    >=  n_frac    AND
          acm001.acno    <=  n_toac   AND
          acm001.curcod  = "BHT"     AND
          acm001.trndat  >=  n_frdate AND
          acm001.trndat  <=  n_todate AND
          /* kan. A46-0015   เพิ่ม type = O, T---*/
         (acm001.trnty1   = "M" OR
          acm001.trnty1   = "R" OR
          acm001.trnty1   = "A" OR
          acm001.trnty1   = "B" OR
          acm001.trnty1   = "Y" OR
          acm001.trnty1   = "Z" OR
          acm001.trnty1   = "C" OR
          acm001.trnty1   = "O" OR
          acm001.trnty1   = "T" ) AND
          /*--- kan.*/
         (acm001.bal     <> 0  OR
         (acm001.bal      =  0  AND
          acm001.latdat   >  n_asdat))  
:

/*          BREAK  BY acm001.acno
 *                         BY YEAR(acm001.trndat)
 *                         BY acm001.trndat
 *                         BY acm001.policy
 *                         BY acm001.trnty1 :*/

       DISP  "PROCESS : " + acm001.acno + "  " + acm001.policy + "  " + acm001.trnty1 + "  " +
                  acm001.trnty2 + "  " + acm001.docno  @ fiProcess  WITH FRAME  frST .
        ASSIGN
            n_day       =  0    
            nt_tdat     =  ""   nt_asdat   =  ""   n_xtm600   =  ""
            n_acc       =  ""   n_add1     =  ""   n_add2     =  ""
            n_add3      =  ""   n_add4     =  ""   n_insur    =  ""
            n_trntyp    =  ""   n_mocom    =  0    n_prem     =  0
            n_comp      =  0    n_gross    =  0    n_year     =  0
            n_polyear   =  ""   n_cedpol   =  ""   n_opnpol   =  ""
            n_prvpol    =  ""   n_polbrn = ""      n_comdat =?

            n_comm_comp = 0   n_comm = 0
            vcom1_t = 0        vcom2_t = 0
            n_startdat = ?     n_duedat = ?
            n_sdmonth = 0    n_sdyear = 0
            n_poldes    = ""

            n_wcr  = 0
            n_damt = 0
            n_odue = 0
            n_odue1 = 0
            n_odue2 = 0
            n_odue3 = 0
            n_odue4 = 0
            n_odue5 = 0. 

        FIND  xmm031 WHERE xmm031.poltyp = acm001.poltyp
        NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL xmm031 THEN  n_poldes = xmm031.poldes.

        FIND  xmm600 USE-INDEX xmm60001 WHERE
                   xmm600.acno  = acm001.acno            
              /* (xmm600.acccod = "AG" OR  xmm600.acccod = "BR") */
        NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL xmm600 THEN NEXT.
        IF xmm600.acccod <> "AG"  THEN  DO:
            IF  xmm600.acccod <> "BR" THEN NEXT.
        END.

        ASSIGN
            n_acc  = xmm600.acno
            n_day  = xmm600.crper
            n_ltamt = xmm600.ltamt.

        FIND xtm600 USE-INDEX xtm60001 WHERE
                  xtm600.acno = xmm600.acno NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL xtm600  THEN DO:
           n_xtm600  = xtm600.name.
           IF xtm600.addr1 <> "" THEN
              ASSIGN
                 n_add1 = xtm600.addr1
                 n_add2 = xtm600.addr2
                 n_add3 = xtm600.addr3
                 n_add4 = xtm600.addr4.
           ELSE
              ASSIGN
                 n_add1 = xmm600.addr1
                 n_add2 = xmm600.addr2
                 n_add3 = xmm600.addr3
                 n_add4 = xmm600.addr4 .
        END.
        ELSE 
           ASSIGN
              n_xtm600 = xmm600.name
              n_add1 = xmm600.addr1
              n_add2 = xmm600.addr2
              n_add3 = xmm600.addr3
              n_add4 = xmm600.addr4 .
        /*
        FIND  uwm100 USE-INDEX uwm10001 WHERE
                   uwm100.policy  = acm001.policy AND
                   uwm100.rencnt  = acm001.rencnt AND
                   uwm100.endcnt = acm001.endcnt  NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL uwm100 THEN
           ASSIGN
              n_polyear = uwm100.undyr
              n_cedpol  = uwm100.cedpol
              n_opnpol  = uwm100.opnpol
              n_prvpol   = uwm100.prvpol
              vcom1_t   = uwm100.com1_t
              n_polbrn  = uwm100.branch
              n_comdat = uwm100.comdat.
        ELSE
            ASSIGN
              n_polyear = ""
              n_cedpol = ""
              n_opnpol = ""
              n_prvpol = ""
              n_polbrn = acm001.branch
              n_comdat = acm001.comdat.
          */

           ASSIGN
              n_polyear = ""
              n_cedpol = ""
              n_opnpol = ""
              n_prvpol = ""
              n_polbrn = acm001.branch
              n_comdat = acm001.comdat.

        n_mocom    =  0.

        IF  SUBSTR(acm001.policy,3,2) = "70"  THEN DO:
            FIND FIRST uwm100  USE-INDEX  uwm10001 WHERE
                       uwm100.policy = acm001.policy  AND
                       uwm100.endno  = acm001.recno 
            NO-LOCK  NO-ERROR NO-WAIT.
            IF AVAIL uwm100  THEN  DO:
                ASSIGN
                    n_polyear = uwm100.undyr
                    n_cedpol  = uwm100.cedpol
                    n_opnpol  = uwm100.opnpol
                    n_prvpol   = uwm100.prvpol
                    vcom1_t    = uwm100.com1_t
                    n_polbrn   = uwm100.branch
                    n_comdat = uwm100.comdat.

                vcom2_t = uwm100.com2_t.
               FOR EACH uwd132  WHERE
                        uwd132.policy  = uwm100.policy  AND
                        uwd132.rencnt  = uwm100.rencnt  AND
                        uwd132.endcnt  = uwm100.endcnt NO-LOCK .

                   IF uwd132.bencod = "COMP"     OR
                      uwd132.bencod = "COMG"     OR
                      uwd132.bencod = "COMH"    THEN
                      n_mocom = n_mocom + uwd132.prem_c.       /* prem_c  เบี้ย พรบ.*/

               END.
            END. /* IF AVAIL uwm100 */
            ELSE DO:
               n_mocom  =   0.
            END. /* IF NOT AVAIL uwm100*/

            ASSIGN
               n_prem    = acm001.prem  -  n_mocom            /*Prem  หักเบี้ย พรบ. แล้ว*/
               n_comp    = n_mocom                                       /*               เบี้ย พรบ. */ 
               n_comm_comp = vcom2_t                                /*commission  พรบ. */ /*uwm100.com2_t*/
               n_comm   = acm001.comm -  vcom2_t . /*commission  =  uwm100.com1_t*/ /*uwm100.com2_t*/

        END. /* 70 */
        ELSE DO:
            FIND  uwm100 USE-INDEX uwm10001 WHERE
                   uwm100.policy  = acm001.policy   AND
                   uwm100.rencnt  = acm001.rencnt   AND
                   uwm100.endcnt = acm001.endcnt  NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL uwm100 THEN
                ASSIGN
                 n_polyear = uwm100.undyr
                 n_cedpol  = uwm100.cedpol
                 n_opnpol  = uwm100.opnpol
                 n_prvpol   = uwm100.prvpol
                 vcom1_t    = uwm100.com1_t
                 n_polbrn   = uwm100.branch
                 n_comdat  = uwm100.comdat.

            IF   (SUBSTR(acm001.policy,3,2)  =  "72"   OR
                    SUBSTR(acm001.policy,3,2)   =  "73" )  
            THEN DO:
                ASSIGN
                  n_prem    =  0
                  n_comp    = acm001.prem               /*                 เบี้ย พรบ.*/ 
                  n_comm_comp = acm001.comm    /* commission  พรบ.*/ /*uwm100.com1_t */
                  n_comm   = 0.
             END.
             ELSE DO:      /* ทุก Line ยกเว้น 70 , 72 ,73 */
                ASSIGN
                  n_prem    = acm001.prem
                  n_comp    = 0
                  n_comm_comp =  0
                  n_comm   = acm001.comm.
             END.
        END.

        n_gross    = n_prem +  n_comp  +  acm001.stamp + acm001.tax.

        n_insur = SUBSTR(acm001.ref,1,35).
        n_trntyp   = acm001.trnty1 + acm001.trnty2.
    /*=========== CHECK TRNDAT with in & over due ==========*/
            n_sdmonth = MONTH(acm001.trndat).
            n_sdyear  = YEAR(acm001.trndat).
            n_startdat = IF n_sdmonth = 12 THEN DATE (1,1,n_sdyear + 1 )
                                                                   ELSE DATE(n_sdmonth + 1,1,n_sdyear).  /*วันที่เริ่มนับ credit*/
/* หา  n_duedat วันที่สุดท้ายที่อยู่ใน credit*/
ASSIGN
    vdueDAY = 0   vdueMONTH = 0   vdueYEAR = 0
    vcrperMod = 0 vcrperRound = 0.

         ASSIGN
            vdueDAY = DAY(n_startdat) 
            vdueMONTH = MONTH(n_startdat)
            vdueYEAR    = YEAR(n_startdat)

            vcrperMod    = n_day mod 30                   /* ได้จำนวนวัน  */
            vcrperRound = Round( n_day / 30 , 0) .  /* ได้จำนวนเดือน  ปัดเศษขึ้น*/

    IF n_day = 0 THEN DO:       /* กรณี credit term เป็น 0 */
        n_duedat = acm001.trndat.  /* DATE(MONTH(acm001.trndat) ,fuMaxDay(acm001.trndat) , YEAR(acm001.trndat)) */
    END.
    ELSE IF n_day <> 0 THEN DO:
        IF n_day mod 30  = 0 THEN DO:   /* เต็มเดือน จะได้วันที่มากสุดของเดือนนั้น */
            IF vdueMONTH + vcrperRound - 1  > 12 THEN DO:   /* ข้ามปี  - 1 ลบเดือนตัวเองด้วย */
                ASSIGN
                    vYear   = vdueYear + 1
                    vMonth = (vdueMONTH +  vcrperRound - 1 ) - 12
                    vDay    = fuMaxDay(DATE(vMonth,1,vYear)).
            END.
            ELSE DO:          /* ปีเดียวกัน*/
                ASSIGN
                    vYear   = vdueYear
                    vMonth = (vdueMONTH +  vcrperRound - 1 )
                    vDay    = fuMaxDay(DATE(vMonth,1,vYear)).
            END.
        END.
        ELSE DO:              /*ไม่เต็มเดือนจะได้วันที่ 15 ของเดือนนั้น*/
            IF vdueMONTH + vcrperRound - 1  > 12 THEN DO:   /* ข้ามปี */
                ASSIGN
                    vYear   = vdueYear + 1
                    vMonth = (vdueMONTH +  vcrperRound - 1  ) - 12
                    vDay    = 15.
            END.
            ELSE DO:          /* ปีเดียวกัน*/
                ASSIGN
                    vYear   = vdueYear
                    vMonth = (vdueMONTH +  vcrperRound - 1 )
                    vDay    = 15.
            END.
        END.

            n_duedat = DATE(vMonth,vDay,vYear). /*ASSIGN ค่าให้วันที่วันสุดท้าย*/
       END.
/**/
/*            n_duedat  = n_startdat + n_day - 1.     /*วันที่สุดท้าย  credit  (นับวันแรกด้วย) */*/
      /*------------------ หาจำนวนวันใน 3 , 6 , 9 , 12 เดือน --------------------*/
/*           n_odmonth1  =  IF (MONTH(n_duedat) + 3 )   MOD 12 = 0 THEN 1 ELSE (MONTH(n_duedat ) + 3 )   MOD 12.
 *            n_odmonth2  =  IF (MONTH(n_duedat ) + 6 )   MOD 12 = 0 THEN 1 ELSE (MONTH(n_duedat ) + 6 )   MOD 12.
 *            n_odmonth3  =  IF (MONTH(n_duedat ) + 9 )   MOD 12 = 0 THEN 1 ELSE (MONTH(n_duedat ) + 9 )   MOD 12.
 *            n_odmonth4  =  IF (MONTH(n_duedat ) + 12 ) MOD 12 = 0 THEN 1 ELSE (MONTH(n_duedat ) + 12 ) MOD 12.*/
           i = 0. 
           DO i = 0  TO 2  :   /* over due 1 - 3*/
            ASSIGN
                 n_odmonth1 = IF (MONTH(n_duedat ) + i )   MOD 12 = 0 THEN 1 ELSE (MONTH(n_duedat ) + i )   MOD 12
                 n_odDay1 =  n_odDay1 + fuNumMonth(n_odmonth1, n_duedat ).
           END.
           i = 0.
           DO i = 0  TO 5  :   /* over due 3 - 6*/
            ASSIGN
                 n_odmonth2  =  IF (MONTH(n_duedat ) + i )   MOD 12 = 0 THEN 1 ELSE (MONTH(n_duedat ) + i )   MOD 12
                 n_odDay2 =  n_odDay2 + fuNumMonth(n_odmonth2, n_duedat ).
           END.
           i = 0.
           DO i = 0  TO 8  :   /* over due 6 - 9*/
            ASSIGN
                 n_odmonth3  =  IF (MONTH(n_duedat ) + i )   MOD 12 = 0 THEN 1 ELSE (MONTH(n_duedat ) + i )   MOD 12
                 n_odDay3 =  n_odDay3 + fuNumMonth(n_odmonth3, n_duedat ).
           END.
           i = 0.
           DO i = 0  TO 11 :   /* over due 9 - 12*/
            ASSIGN
                 n_odmonth4  =  IF (MONTH(n_duedat ) + i )   MOD 12 = 0 THEN 1 ELSE (MONTH(n_duedat ) + i )   MOD 12
                 n_odDay4 =  n_odDay4 + fuNumMonth(n_odmonth4, n_duedat ).
           END.
     /*-------------- duedat + จำนวนวันใน 3 , 6 , 9 , 12 เดือน   --------------*/
     ASSIGN
           n_odat1 =  n_duedat  +  n_odDay1  /* ได้วันที่วันสุดท้ายในช่วง*/
           n_odat2 =  n_duedat  + n_odDay2
           n_odat3 =  n_duedat  + n_odDay3
           n_odat4 =  n_duedat  + n_odDay4 .
     /*================== เปรียบเทียบวันที่ As Date กับ duedat & odat1-4 (over due date) ===*/
            IF /*n_day <> 0  AND*/ n_asdat <= (n_duedat - fuMaxDay(n_duedat)) THEN DO:  /* เทียบ asdate กับ  วันทีสุดท้าย  ก่อนเดือนสุดท้าย*/
                n_wcr = n_wcr + acm001.bal .            /* with in credit  ไม่ครบกำหนดชำระ */
            END.
            IF n_asdat > (n_duedat - fuMaxDay(n_duedat)) AND n_asdat <= n_duedat THEN DO:   /*เทียบ asdate กับวันที่ในช่วงเดือนสุดท้าย*/
                n_damt = n_damt + acm001.bal .       /* due Amout  ครบกำหนดชำระ*/
            END.
           /*-------------------------------*/
            IF n_asdat > n_duedat AND n_asdat <= n_odat1 THEN DO:
                    n_odue1 = n_odue1 +  acm001.bal.       /*  overdue 1- 3 months*/
            END.
            IF n_asdat > n_odat1 AND n_asdat <= n_odat2 THEN DO:
                    n_odue2 = n_odue2 +  acm001.bal.       /*  overdue 3 - 6 months*/
            END.
            IF n_asdat > n_odat2 AND n_asdat <= n_odat3 THEN DO:
                    n_odue3 = n_odue3 +  acm001.bal.       /*  overdue 6 - 9 months*/
            END.
            IF n_asdat > n_odat3 AND n_asdat <= n_odat4 THEN DO:
                    n_odue4 = n_odue4 +  acm001.bal.      /*  overdue 9 - 12 months*/
            END.
            IF n_asdat > n_odat4 THEN DO:
                    n_odue5 = n_odue5 +  acm001.bal.      /*  over 12  months*/
            END.

            n_odue = n_odue1 + n_odue2 + n_odue3 + n_odue4 + n_odue5 .

    v_trntyp12 = acm001.trnty1 + acm001.trnty2 .
   /*--------------------------------------------------------------------*/

       FIND  First agtprm_fil USE-INDEX by_trndat_acno   WHERE
             agtprm_fil.trndat = acm001.trndat   AND
             agtprm_fil.acno  = acm001.acno     AND
             agtprm_fil.poltyp = acm001.poltyp  AND 
             agtprm_fil.policy = acm001.policy   AND
             agtprm_fil.endno =  acm001.recno  AND
             agtprm_fil.trntyp = v_trntyp12           AND
             agtprm_fil.docno = acm001.docno  AND
             agtprm_fil.asdat = n_asdat
       NO-LOCK NO-ERROR NO-WAIT.
       IF NOT AVAIL agtprm_fil THEN DO:

          RUN pdCreate (OUTPUT n_recid). /* Create Transaction*/  

          FIND agtprm_fil where recid(agtprm_fil)  = n_recid NO-ERROR .
          IF  AVAIL agtprm_fil  THEN DO:
           ASSIGN
             agtprm_fil.asdat  =  n_asdat
             agtprm_fil.acno   =  acm001.acno
             agtprm_fil.agent  =  acm001.agent
             agtprm_fil.poltyp =  acm001.poltyp
             agtprm_fil.polbran = n_polbrn
             agtprm_fil.polyear =  n_polyear
             agtprm_fil.policy  =  acm001.policy
             agtprm_fil.endno  =  acm001.recno
             agtprm_fil.cedpol =  n_cedpol
             agtprm_fil.insur  =  n_insur
             agtprm_fil.prem  =  n_prem
             agtprm_fil.prem_comp = n_comp
             agtprm_fil.tax     =  acm001.tax
             agtprm_fil.stamp = acm001.stamp
             agtprm_fil.gross = n_gross
             agtprm_fil.comm =  n_comm         agtprm_fil.comm_comp     =  n_comm_comp
             agtprm_fil.bal     =  acm001.bal
             agtprm_fil.trndat =  acm001.trndat
             agtprm_fil.credit =  n_day
             agtprm_fil.trntyp =  n_trntyp
             agtprm_fil.docno =  acm001.docno
             agtprm_fil.acno_clicod =  acm001.clicod

             agtprm_fil.vehreg =  acm001.vehreg
             agtprm_fil.opnpol =  n_opnpol
             agtprm_fil.prvpol  =  n_prvpol
             agtprm_fil.latdat   =  acm001.latdat
             agtprm_fil.ac_name =  n_xtm600
             agtprm_fil.addr1 =  n_add1
             agtprm_fil.addr2 =  n_add2
             agtprm_fil.addr3 =  n_add3
             agtprm_fil.addr4 =  n_add4
             agtprm_fil.odue6 = n_ltamt   /* credit Limit*/
             agtprm_fil.wcr    = n_wcr
             agtprm_fil.damt = n_damt  /* 3 ช่อง */
             agtprm_fil.odue = n_odue  /* 3 ช่อง*/

             agtprm_fil.odue1 = n_odue1
             agtprm_fil.odue2 = n_odue2
             agtprm_fil.odue3 = n_odue3
             agtprm_fil.odue4 = n_odue4
             agtprm_fil.odue5 = n_odue5 

             agtprm_fil.startdat = n_startdat
             agtprm_fil.duedat  = n_duedat
             agtprm_fil.poldes  = n_poldes
             agtprm_fil.type      = n_type
             agtprm_fil.comdat = n_comdat .
          END.

        END. /* IF NOTAVAIL agtprm_fil*/

       ASSIGN
            n_odmonth1  = 0   n_odmonth2  = 0  n_odmonth3  = 0 n_odmonth4  = 0
            n_odDay1    = 0    n_odDay2    = 0   n_odDay3    = 0   n_odDay4    = 0
            n_odat1        = ?   n_odat2        = ?  n_odat3       = ?   n_odat4         = ?.

        ASSIGN
            nt_tdat  = STRING(n_todate,"99/99/9999")
            nt_asdat = STRING(n_asdat,"99/99/9999").

        vCountRec = vCountRec + 1 .

release agtprm_fil.

/*release acm001.*/

END.  /*acm001*/


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdProcessWF C-Win 
PROCEDURE pdProcessWF :
/*/*  work table */

DEF VAR n_startdat  AS DATE FORMAT "99/99/9999".
DEF VAR n_duedat   AS DATE FORMAT "99/99/9999".
DEF VAR n_sdmonth AS INT. /*start date*/
DEF VAR n_sdyear AS INT.
/*หาวันที่เริ่มต้น  ต้องเป็นวันที่สุดท้ายของเดือนนั้น ๆ*/
DEF VAR vYear AS INT.
DEF VAR vMonth AS INT.
DEF VAR vDay  AS INT.
DEF VAR vdueDAY  AS INT.
DEF VAR vdueMONTH AS INT.
DEF VAR vdueYEAR AS INT.
DEF VAR vcrperMod AS INT.
DEF VAR vcrperTrun AS INT.
DEF VAR vcrperRound AS INT.
/**/
DEF VAR n_odmonth1 AS INT. /*month not over 12 เดือนที่  หาจำนวนวันในแต่ละเดือน */
DEF VAR n_odmonth2 AS INT.
DEF VAR n_odmonth3 AS INT.
DEF VAR n_odmonth4 AS INT.
DEF VAR n_odDay1  AS INT. /*count num day in over due 1 - 3   จำนวนวัน ที่เกิน ระยะเวลาให้ credit  3 เดือน*/
DEF VAR n_odDay2  AS INT.
DEF VAR n_odDay3  AS INT.
DEF VAR n_odDay4  AS INT.

DEF VAR n_odat1 AS  DATE FORMAT "99/99/9999". /* วันที่ ที่เกินจากระยะเวลาให้ credit  เกินไป 3 เดือน*/
DEF VAR n_odat2 AS  DATE FORMAT "99/99/9999".
DEF VAR n_odat3 AS  DATE FORMAT "99/99/9999".
DEF VAR n_odat4 AS  DATE FORMAT "99/99/9999".
DEF VAR n_odat5 AS  DATE FORMAT "99/99/9999".
DEF VAR n_type AS CHAR FORMAT "X(2)".

DEF VAR i AS INT.
DEF VAR vcom1_t  AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR vcom2_t  AS DECI FORMAT ">>,>>>,>>>,>>9.99-".

vCountRec = 0 .
n_type = "01".

    RUN pdDel.  /* Delete agtprm_fil  &  Create acproc_fil*/ 
    
/**/
FOR EACH  acm001 USE-INDEX acm00103  NO-LOCK WHERE
          acm001.acno    >=  n_frac  AND
          acm001.acno    <=  n_toac AND
          acm001.trndat  >=  n_frdate AND
          acm001.trndat  <=  n_todate AND
         (acm001.trnty1   = "M" OR
          acm001.trnty1   = "A" OR
          acm001.trnty1   = "R" OR
          acm001.trnty1   = "B" OR
          acm001.trnty1   = "Y" OR
          acm001.trnty1   = "Z" OR
          acm001.trnty1   = "C")  AND
         (acm001.bal     <> 0  OR
         (acm001.bal      =  0  AND
          acm001.latdat   >  n_asdat)) :
/*          BREAK  BY acm001.acno
 *                         BY YEAR(acm001.trndat)
 *                         BY acm001.trndat
 *                         BY acm001.policy
 *                         BY acm001.trnty1:*/

        FIND LAST wacm001 WHERE wacm001.acno = acm001.acno AND
                wacm001.trndat = acm001.trndat AND
                wacm001.trnty1 = acm001.trnty1 AND
                wacm001.trnty2 = acm001.trnty2 AND
                wacm001.docno = acm001.docno AND
                wacm001.policy = acm001.policy AND
                wacm001.comdat = acm001.comdat NO-LOCK NO-ERROR.
        IF AVAIL wacm001 THEN NEXT.
        IF NOT AVAIL wacm001 THEN DO:
            CREATE wacm001 NO-ERROR.
            ASSIGN
                wacm001.acno = acm001.acno
                wacm001.agent = acm001.agent
                wacm001.trndat = acm001.trndat
                wacm001.trnty1 = acm001.trnty1
                wacm001.trnty2 = acm001.trnty2
                wacm001.docno = acm001.docno
                wacm001.clicod = acm001.clicod
                wacm001.prem = acm001.prem
                wacm001.comm = acm001.comm
                wacm001.stamp = acm001.stamp
                wacm001.tax = acm001.tax
                wacm001.bal = acm001.bal
                wacm001.policy = acm001.policy
                wacm001.rencnt = acm001.rencnt
                wacm001.endcnt = acm001.endcnt
                wacm001.recno = acm001.recno
                wacm001.poltyp = acm001.poltyp
                wacm001.vehreg = acm001.vehreg
                wacm001.latdat = acm001.latdat
                wacm001.comdat = acm001.comdat
                wacm001.ref = acm001.ref.
        END.
END. /*create temp-table*/
/* */
loop_wacm001:
FOR EACH  wacm001 USE-INDEX wacm001 NO-LOCK
          BREAK  BY wacm001.acno
                        BY YEAR(wacm001.trndat)
                        BY wacm001.trndat
                        BY wacm001.policy
                        BY wacm001.trnty1:
                        
       DISP  wacm001.acno + "  " + wacm001.policy + "  " + wacm001.trnty1 + "  " +
                  wacm001.trnty2 + "  " + wacm001.docno  @ fiProcess  WITH FRAME  frST .
        ASSIGN
            n_day = 0
            nt_tdat  = ""  nt_asdat = ""  n_xtm600 = ""
            n_acc   = ""  n_add1   = ""  n_add2 = ""
            n_add3 = ""  n_add4  = ""  n_insur  = ""
            n_trntyp = "" n_mocom = 0 n_prem = 0
            n_comp =  0  n_gross  = 0  n_year  = 0
            n_polyear =  ""   n_cedpol =  ""    n_opnpol =  ""
            n_prvpol =  ""
 
            n_comm_comp = 0 n_comm = 0
            vcom1_t = 0     vcom2_t = 0
            n_startdat = ?  n_duedat = ?
            n_sdmonth = 0 n_sdyear = 0
            n_poldes    = ""

            n_wcr  = 0
            n_damt = 0
            n_odue = 0
            n_odue1 = 0 n_odue2 = 0 n_odue3 = 0 n_odue4 = 0 n_odue5 = 0. 

        FIND FIRST xmm031 WHERE xmm031.poltyp = wacm001.poltyp NO-LOCK NO-ERROR.
        IF AVAIL xmm031 THEN DO:
                n_poldes = xmm031.poldes.
        END.

        FIND FIRST xmm600 USE-INDEX xmm60001 WHERE
                   xmm600.acno  = wacm001.acno AND 
                  (xmm600.acccod = "AG" OR  xmm600.acccod = "BR") NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL xmm600 THEN NEXT.
        ASSIGN
            n_acc  = xmm600.acno
            n_day  = xmm600.crper
            n_ltamt = xmm600.ltamt.
    
        FIND FIRST xtm600 USE-INDEX xtm60001 WHERE
                  xtm600.acno = xmm600.acno NO-LOCK NO-ERROR.
        IF AVAIL xtm600  THEN DO:
           n_xtm600  = xtm600.name.
           IF xtm600.addr1 <> "" THEN
              ASSIGN
                 n_add1 = xtm600.addr1
                 n_add2 = xtm600.addr2
                 n_add3 = xtm600.addr3
                 n_add4 = xtm600.addr4.
           ELSE
              ASSIGN
                 n_add1 = xmm600.addr1
                 n_add2 = xmm600.addr2
                 n_add3 = xmm600.addr3
                 n_add4 = xmm600.addr4 .
        END.
        ELSE 
           ASSIGN
              n_xtm600 = xmm600.name
              n_add1 = xmm600.addr1
              n_add2 = xmm600.addr2
              n_add3 = xmm600.addr3
              n_add4 = xmm600.addr4 .

        FIND FIRST uwm100 USE-INDEX uwm10001 WHERE
                   uwm100.policy  = wacm001.policy AND
                   uwm100.rencnt  = wacm001.rencnt AND
                   uwm100.endcnt  = wacm001.endcnt  NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL uwm100 THEN
           ASSIGN
              n_polyear = uwm100.undyr
              n_cedpol  = uwm100.cedpol
              n_opnpol  = uwm100.opnpol
              n_prvpol   = uwm100.prvpol
              vcom1_t   = uwm100.com1_t.

        ELSE
           ASSIGN
              n_polyear = ""
              n_cedpol = ""
              n_opnpol = ""
              n_prvpol = "".

              n_mocom    =  0.

        IF  SUBSTR(wacm001.policy,3,2) = "70"  THEN DO:
            FIND FIRST uwm100  USE-INDEX  uwm10001 WHERE
                       uwm100.policy = wacm001.policy  AND
                       uwm100.endno  = wacm001.recno NO-LOCK  NO-ERROR NO-WAIT.
            IF AVAIL uwm100  THEN  DO:
                vcom2_t = uwm100.com2_t.
               FOR EACH uwd132  WHERE
                        uwd132.policy  = uwm100.policy  AND
                        uwd132.rencnt  = uwm100.rencnt  AND
                        uwd132.endcnt  = uwm100.endcnt NO-LOCK .

                   IF uwd132.bencod = "COMP" OR
                      uwd132.bencod = "COMG"  OR
                      uwd132.bencod = "COMH"  THEN
                      n_mocom = n_mocom + uwd132.prem_c.       /* prem_c  เบี้ย พรบ.*/
               END.
            END.
            ELSE DO:
               n_mocom  =   0.
            END.

             ASSIGN    
                n_prem  = wacm001.prem  -  n_mocom  /*Prem  หักเบี้ย พรบ. แล้ว*/
                n_comp = n_mocom                                 /*               เบี้ย พรบ. */ 
                n_comm_comp = vcom2_t                       /*commission  พรบ. */ /*uwm100.com2_t*/
                n_comm = wacm001.comm -  vcom2_t . /*commission  =  uwm100.com1_t*/ /*uwm100.com2_t*/

        END.
        ELSE IF  SUBSTR(wacm001.policy,3,2)  =  "72"   THEN DO:
            ASSIGN
                n_prem  =  0
                n_comp = wacm001.prem                       /* เบี้ย พรบ.*/
                n_comm_comp = vcom1_t                      /* commission  พรบ.*/ /*uwm100.com1_t */
                n_comm = 0 .
        END.
        ELSE DO:      /*ทุก Line ยกเว้น 70 , 72 */
            ASSIGN
                n_prem  = wacm001.prem
                n_comp = 0
                n_comm_comp = 0
                n_comm = wacm001.comm.
        END.

        n_gross = n_prem + n_comp + wacm001.stamp + wacm001.tax.

        n_insur = SUBSTR(wacm001.ref,1,35).
        n_trntyp   = wacm001.trnty1 + wacm001.trnty2.
    /*=== CHECK TRNDAT with in & over due ===*/
    ASSIGN
            n_sdmonth = MONTH(wacm001.trndat)
            n_sdyear  = YEAR(wacm001.trndat)
            n_startdat = IF n_sdmonth = 12 THEN DATE (1,1,n_sdyear + 1 )
                                                                   ELSE DATE(n_sdmonth + 1,1,n_sdyear).  /*วันที่เริ่มนับ credit*/
/* หา  n_duedat วันที่สุดท้ายที่อยู่ใน credit*/
ASSIGN
    vdueDAY = 0   vdueMONTH = 0 vdueYEAR = 0
    vcrperMod = 0 vcrperRound = 0.

         ASSIGN
            vdueDAY = DAY(n_startdat) 
            vdueMONTH = MONTH(n_startdat)
            vdueYEAR    = YEAR(n_startdat)

            vcrperMod    = n_day mod 30               /* ได้จำนวนวัน  */
            vcrperRound = Round( n_day / 30,0). /* ได้จำนวนเดือน  ปัดเศษขึ้น*/

    IF n_day = 0 THEN DO:    /* กรณี credit term เป็น 0 */
        n_duedat = wacm001.trndat. /* DATE(MONTH(wacm001.trndat) ,fuMaxDay(wacm001.trndat) , YEAR(wacm001.trndat)) */
    END.
    ELSE IF n_day <> 0 THEN DO: 
        IF n_day mod 30  = 0 THEN DO:  /* เต็มเดือน จะได้วันที่มากสุดของเดือนนั้น */
            IF vdueMONTH + vcrperRound - 1  > 12 THEN DO:  /* ข้ามปี  - 1 ลบเดือนตัวเองด้วย */
                ASSIGN
                    vYear   = vdueYear + 1
                    vMonth = (vdueMONTH + vcrperRound - 1 ) - 12.
                    vDay    = fuMaxDay(DATE(vMonth,1,vYear)).
            END.
            ELSE DO:    /* ปีเดียวกัน*/
                ASSIGN
                    vYear   = vdueYear
                    vMonth = (vdueMONTH + vcrperRound - 1 ).
                    vDay    = fuMaxDay(DATE(vMonth,1,vYear)).
            END.
        END.
        ELSE DO:       /*ไม่เต็มเดือนจะได้วันที่ 15 ของเดือนนั้น*/
            IF vdueMONTH + vcrperRound - 1  > 12 THEN DO:   /* ข้ามปี */
                ASSIGN
                    vYear   = vdueYear + 1
                    vMonth = (vdueMONTH + vcrperRound - 1  ) - 12.
                    vDay    = 15.
            END.
            ELSE DO:            /* ปีเดียวกัน*/
                ASSIGN
                    vYear   = vdueYear 
                    vMonth = (vdueMONTH + vcrperRound - 1  ) .
                    vDay    = 15.
            END.
        END.
            n_duedat = DATE(vMonth,vDay,vYear). /*ASSIGN ค่าให้วันที่วันสุดท้าย*/
       END.
/**/
      /*---- หาจำนวนวันใน 3 , 6 , 9 , 12 เดือน ----*/
           n_odmonth1 =  IF (MONTH(n_duedat) + 3 )  MOD 12 = 0 THEN 1 ELSE (MONTH(n_duedat ) + 3 ) MOD 12.
           n_odmonth2 =  IF (MONTH(n_duedat ) + 6 ) MOD 12 = 0 THEN 1 ELSE (MONTH(n_duedat ) + 6 ) MOD 12.
           n_odmonth3 =  IF (MONTH(n_duedat ) + 9 ) MOD 12 = 0 THEN 1 ELSE (MONTH(n_duedat ) + 9 ) MOD 12.
           n_odmonth4 =  IF (MONTH(n_duedat ) + 12 ) MOD 12 = 0 THEN 1 ELSE (MONTH(n_duedat ) + 12 ) MOD 12.
           i = 0. 
           DO i = 0  TO 2:   /*over due 1 - 3*/
                 n_odmonth1 = IF (MONTH(n_duedat ) + i ) MOD 12 = 0 THEN 1 ELSE (MONTH(n_duedat ) + i ) MOD 12.
                 n_odDay1 =  n_odDay1 + fuNumMonth(n_odmonth1, n_duedat ).
           END.
           i = 0.
           DO i = 0  TO 5:   /*over due 3 - 6*/
                 n_odmonth2  =  IF (MONTH(n_duedat ) + i ) MOD 12 = 0 THEN 1 ELSE (MONTH(n_duedat ) + i ) MOD 12.
                 n_odDay2 =  n_odDay2 + fuNumMonth(n_odmonth2, n_duedat ).
           END.
           i = 0.      
           DO i = 0  TO 8:   /*over due 6 - 9*/
                 n_odmonth3  =  IF (MONTH(n_duedat ) + i ) MOD 12 = 0 THEN 1 ELSE (MONTH(n_duedat ) + i ) MOD 12.
                 n_odDay3 =  n_odDay3 + fuNumMonth(n_odmonth3, n_duedat ).
           END. 
           i = 0.
           DO i = 0  TO 11:   /*over due 9 - 12*/
                 n_odmonth4  =  IF (MONTH(n_duedat ) + i ) MOD 12 = 0 THEN 1 ELSE (MONTH(n_duedat ) + i ) MOD 12.
                 n_odDay4 =  n_odDay4 + fuNumMonth(n_odmonth4, n_duedat ).
           END.
     /*----- duedat + จำนวนวันใน 3 , 6 , 9 , 12 เดือน ------*/
     ASSIGN
           n_odat1 = n_duedat + n_odDay1 /*ได้วันที่วันสุดท้ายในช่วง*/
           n_odat2 = n_duedat + n_odDay2
           n_odat3 = n_duedat + n_odDay3
           n_odat4 = n_duedat + n_odDay4 .
     /*======== เปรียบเทียบวันที่ As Date กับ duedat & odat1-4 (over due date) ===*/
            IF /*n_day <> 0  AND*/ n_asdat <= (n_duedat - fuMaxDay(n_duedat)) THEN DO:  /* เทียบ asdate กับ  วันทีสุดท้าย  ก่อนเดือนสุดท้าย*/
                n_wcr = n_wcr + wacm001.bal .          /* with in credit  ไม่ครบกำหนดชำระ */
            END.
            IF n_asdat > (n_duedat - fuMaxDay(n_duedat)) AND n_asdat <= n_duedat THEN DO:   /*เทียบ asdate กับวันที่ในช่วงเดือนสุดท้าย*/
                n_damt = n_damt + wacm001.bal .    /* due Amout  ครบกำหนดชำระ*/
            END.
           /*-----------*/ 
            IF n_asdat > n_duedat AND n_asdat <= n_odat1 THEN DO:
                    n_odue1 = n_odue1 +  wacm001.bal.   /*overdue 1- 3 months*/
            END.
            IF n_asdat > n_odat1 AND n_asdat <= n_odat2 THEN DO:
                    n_odue2 = n_odue2 +  wacm001.bal.   /*overdue 3 - 6 months*/
            END.
            IF n_asdat > n_odat2 AND n_asdat <= n_odat3 THEN DO:
                    n_odue3 = n_odue3 +  wacm001.bal.   /*overdue 6 - 9 months*/
            END.
            IF n_asdat > n_odat3 AND n_asdat <= n_odat4 THEN DO:
                    n_odue4 = n_odue4 +  wacm001.bal.   /*overdue 9 - 12 months*/
            END.
            IF n_asdat > n_odat4 THEN DO:
                    n_odue5 = n_odue5 +  wacm001.bal.   /*over 12  months*/
            END.
      n_odue = n_odue1 + n_odue2 + n_odue3 + n_odue4 + n_odue5 .
      /*------------------*/
       v_trntyp12 = wacm001.trnty1 + wacm001.trnty2.
       
       FIND  First agtprm_fil USE-INDEX by_trndat_acno   WHERE
             agtprm_fil.trndat = wacm001.trndat   AND
             agtprm_fil.acno  = wacm001.acno     AND
             agtprm_fil.policy = wacm001.policy   AND
             agtprm_fil.trntyp  = v_trntyp12 AND
             agtprm_fil.docno = wacm001.docno AND
             agtprm_fil.asdat = n_asdat   NO-ERROR NO-WAIT.
       IF NOT AVAIL agtprm_fil THEN DO:
      
            RUN pdCreate (OUTPUT n_recid). /* Create Transaction*/
            
             FIND FIRST  agtprm_fil where recid(agtprm_fil)  = n_recid NO-ERROR .
             IF  AVAIL agtprm_fil  THEN DO:
              ASSIGN
                  agtprm_fil.asdat  =  n_asdat
                  agtprm_fil.acno   =  wacm001.acno
                  agtprm_fil.agent  =  wacm001.agent
                  agtprm_fil.poltyp =  wacm001.poltyp
                  agtprm_fil.polbran =  SUBSTR(wacm001.policy,2,1)
                  agtprm_fil.polyear =  n_polyear
                  agtprm_fil.policy  = wacm001.policy
                  agtprm_fil.endno  = wacm001.recno
                  agtprm_fil.cedpol =  n_cedpol
                  agtprm_fil.insur  =  n_insur
                  agtprm_fil.prem  =  n_prem
                  agtprm_fil.prem_comp = n_comp
                  agtprm_fil.tax     = wacm001.tax
                  agtprm_fil.stamp = wacm001.stamp
                  agtprm_fil.gross = n_gross
                  agtprm_fil.comm =  n_comm         agtprm_fil.comm_comp     =  n_comm_comp
                  agtprm_fil.bal     =  wacm001.bal
                  agtprm_fil.trndat =  wacm001.trndat
                  agtprm_fil.credit =  n_day
                  agtprm_fil.trntyp =  n_trntyp
                  agtprm_fil.docno = wacm001.docno
                  agtprm_fil.acno_clicod = wacm001.clicod
       
                  agtprm_fil.vehreg = wacm001.vehreg
                  agtprm_fil.opnpol = n_opnpol
                  agtprm_fil.prvpol  = n_prvpol
                  agtprm_fil.latdat   = wacm001.latdat
                  agtprm_fil.ac_name =  n_xtm600
                  agtprm_fil.addr1 =  n_add1
                  agtprm_fil.addr2 =  n_add2
                  agtprm_fil.addr3 =  n_add3
                  agtprm_fil.addr4 =  n_add4
                  agtprm_fil.odue6 = n_ltamt   /* credit Limit*/
                  agtprm_fil.wcr    = n_wcr
                  agtprm_fil.damt = n_damt  /* 3 ช่อง */
                  agtprm_fil.odue = n_odue  /* 3 ช่อง*/
       
                  agtprm_fil.odue1 = n_odue1
                  agtprm_fil.odue2 = n_odue2
                  agtprm_fil.odue3 = n_odue3
                  agtprm_fil.odue4 = n_odue4
                  agtprm_fil.odue5 = n_odue5 
       
                  agtprm_fil.startdat = n_startdat
                  agtprm_fil.duedat  = n_duedat
                  agtprm_fil.poldes  = n_poldes
                  agtprm_fil.type      = n_type
                  agtprm_fil.comdat = wacm001.comdat  .
              END.
         
        END. /* IF NOTAVAIL agtprm_fil*/

       ASSIGN
            n_odmonth1  = 0   n_odmonth2  = 0  n_odmonth3  = 0 n_odmonth4  = 0
            n_odDay1    = 0    n_odDay2    = 0   n_odDay3    = 0   n_odDay4    = 0
            n_odat1        = ?   n_odat2        = ?  n_odat3       = ?   n_odat4         = ?.

        ASSIGN
            nt_tdat  = STRING(n_todate,"99/99/9999")
            nt_asdat = STRING(n_asdat,"99/99/9999").

        vCountRec = vCountRec + 1 .
release agtprm_fil.
release wacm001.

END.  /*wacm001*/
/*END  work table */
*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdProcessYes C-Win 
PROCEDURE pdProcessYes :
/*------------------------------------------------------------------------------
  Purpose:     ถ้า process เสร็จให้ Process complete = YES
  Parameters:  <none>  
  Notes:       
------------------------------------------------------------------------------*/

    FIND LAST acProc_fil  USE-INDEX by_type_asdat  WHERE
              acProc_fil.asdat = n_asdat  AND
              acProc_fil.type  = nv_type  NO-ERROR.
    IF AVAIL acProc_fil THEN DO:
        ASSIGN
/*            acProc_fil.type    = "01"*/
            SUBSTRING(acProc_fil.enttim,10,3)  = "YES".
    END. 


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdProcess_bck C-Win 
PROCEDURE pdProcess_bck :
ASSIGN vCountRec = 0
       n_type = nv_type.

RUN pdDel01.  /* "01" Delete agtprm_fil  &  Create acproc_fil "05"  */ 

/*--A56-0047--*/
RELEASE acproc_fil.   
RELEASE agtprm_fil.
/*--end A56-0047--*/

loop_acm001:
FOR EACH  acm001 USE-INDEX acm00103  NO-LOCK WHERE
          acm001.acno    >=  n_frac   AND
          acm001.acno    <=  n_toac   AND
          acm001.curcod  = "BHT"      AND
          acm001.trndat  >=  n_frdate AND
          acm001.trndat  <=  n_todate AND
          /* kan. A46-0015   เพิ่ม type = O, T---*/
         (acm001.trnty1   = "M" OR
          acm001.trnty1   = "R" OR
          acm001.trnty1   = "A" OR
          acm001.trnty1   = "B" OR
          acm001.trnty1   = "Y" OR
          acm001.trnty1   = "Z" OR
          acm001.trnty1   = "C" OR
          acm001.trnty1   = "O" OR
          acm001.trnty1   = "T" ) AND
          /* kan */
         (acm001.bal     <>  0  OR
         (acm001.bal      =  0  AND
          acm001.latdat   >  n_asdat)) :

    IF ( YEAR(acm001.latdat) > 2999 ) AND (acm001.bal = 0)  THEN NEXT  loop_acm001.     /* A47-0108 */
/* A47-0370 */
/*        DISP  "PROCESS : " + acm001.acno + "  " + acm001.policy + "  " + acm001.trnty1 + "  " + */
/*        acm001.trnty2 + "  " + acm001.docno  @ fiProcess  WITH FRAME  frST.          */

        DISP 
            /*--- A500178 ---
            acm001.acno 
            ------*/
            acm001.acno FORMAT "X(10)"
            acm001.trndat
            acm001.policy  
            acm001.trnty1 + 
            acm001.trnty2 
            acm001.docno FORMAT "9999999"
         WITH COLOR BLACK/WHITE NO-LABEL TITLE "Process monthly ..." FRAME frProcess VIEW-AS DIALOG-BOX.

        ASSIGN
            n_day     =  0
            nt_tdat   =  ""     nt_asdat   =  ""    n_xtm600 = ""   n_clicod = ""
            n_acc     =  ""     n_add1     =  ""    n_add2   = ""
            n_add3    =  ""     n_add4     =  ""    n_insur  = ""
            n_trntyp  =  ""     n_mocom    =  0     n_prem   = 0
            n_comp    =  0      n_gross    =  0     n_year   = 0
            n_polyear =  ""     n_cedpol   =  ""    n_opnpol = ""
            n_prvpol  =  ""     n_polbrn   =  ""    n_comdat = ?

            n_comm_comp = 0     n_comm   = 0
            vcom1_t     = 0     vcom2_t  = 0
            n_startdat  = ?     n_duedat = ?
            n_sdmonth   = 0     n_sdyear = 0
            n_poldes    = ""

            n_wcr   = 0
            n_damt  = 0
            n_odue  = 0
            n_odue1 = 0
            n_odue2 = 0
            n_odue3 = 0
            n_odue4 = 0
            n_odue5 = 0
            n_odue6 = 0   /*A53-0159*/
            nn_dept = "" .

        FIND  xmm031 WHERE xmm031.poltyp = acm001.poltyp
        NO-LOCK NO-ERROR.
        IF AVAIL xmm031 THEN ASSIGN n_poldes = xmm031.poldes
                                    nn_dept  = xmm031.dept.

        
        FIND  xmm600 USE-INDEX xmm60001 WHERE
                   xmm600.acno  = acm001.acno
        /* (xmm600.acccod = "AG" OR  xmm600.acccod = "BR") */
        NO-LOCK NO-ERROR.
        IF NOT AVAIL xmm600 THEN NEXT.
        IF xmm600.acccod <> "AG"  THEN DO:
            IF  xmm600.acccod <> "BR" THEN NEXT.
        END.
        ASSIGN n_acc    = xmm600.acno
             /*n_day    = xmm600.crper ---A53-0159---*/
               n_ltamt  = xmm600.ltamt
               n_clicod = xmm600.clicod.  /* A47-0142 */

       IF nn_dept <> "G" OR nn_dept <> "M" THEN n_day = xmm600.crper.   /*--A53-0159--*/
       ELSE n_day = 0.

        FIND xtm600 USE-INDEX xtm60001 WHERE
                  xtm600.acno = xmm600.acno NO-LOCK NO-ERROR.
        IF AVAIL xtm600  THEN DO:
           n_xtm600  = TRIM(xtm600.ntitle + " " + xtm600.name).
           IF xtm600.addr1 <> "" THEN
              ASSIGN 
                 n_add1 = xtm600.addr1
                 n_add2 = xtm600.addr2
                 n_add3 = xtm600.addr3
                 n_add4 = xtm600.addr4.
           ELSE
              ASSIGN
                 n_add1 = xmm600.addr1
                 n_add2 = xmm600.addr2
                 n_add3 = xmm600.addr3
                 n_add4 = xmm600.addr4.

        END.
        ELSE
           ASSIGN
              n_xtm600 = TRIM(xmm600.ntitle + " " + xmm600.name) 
              n_add1 = xmm600.addr1
              n_add2 = xmm600.addr2
              n_add3 = xmm600.addr3
              n_add4 = xmm600.addr4.

           ASSIGN
              n_polyear = ""
              n_cedpol  = ""
              n_opnpol  = ""
              n_prvpol  = ""
              n_polbrn  = acm001.branch
              n_comdat  = acm001.comdat.

        n_mocom = 0.

        /* A47-0142 - หาข้อมูลเฉพาะ รายการที่มีการระบุเบอร์ ก/ธ  M, R */
        IF acm001.policy  <> ""  THEN DO:   
            IF  SUBSTR(acm001.policy,3,2) = "70"  THEN DO:
                FIND FIRST uwm100  USE-INDEX  uwm10001 WHERE
                           uwm100.policy = acm001.policy AND
                           uwm100.endno  = acm001.recno
                NO-LOCK  NO-ERROR.
                IF AVAIL uwm100  THEN DO:
                    ASSIGN
                        n_polyear = uwm100.undyr
                        n_cedpol  = uwm100.cedpol
                        n_opnpol  = uwm100.opnpol
                        n_prvpol  = uwm100.prvpol
                        vcom1_t   = uwm100.com1_t
                        /*--- A500178 --- กลับไปใช้ฟิลด์ branch
                        n_polbrn  = SUBSTRING(uwm100.policy,2,1)   /* A47-0370  uwm100.branch */
                        ------*/
                        n_polbrn  = uwm100.branch
                        n_comdat  = uwm100.comdat
                        vcom2_t   = uwm100.com2_t.

                   FOR EACH uwd132  WHERE
                            uwd132.policy  = uwm100.policy AND
                            uwd132.rencnt  = uwm100.rencnt AND
                            uwd132.endcnt  = uwm100.endcnt NO-LOCK .
    
                       IF uwd132.bencod = "COMP"  OR
                          uwd132.bencod = "COMG"  OR
                          uwd132.bencod = "COMH"  THEN
                          n_mocom = n_mocom + uwd132.prem_c.       /* prem_c  เบี้ย พรบ.*/
    
                   END.
                END. /* IF AVAIL uwm100 */
                ELSE DO:
                   n_mocom = 0.
                END. /* IF NOT AVAIL uwm100*/
    
                ASSIGN
                   n_prem      = acm001.prem  -  n_mocom /*Prem  หักเบี้ย พรบ. แล้ว*/
                   n_comp      = n_mocom                 /*             เบี้ย พรบ. */
                   n_comm_comp = vcom2_t                 /*commission  พรบ. */ /*uwm100.com2_t*/
                   n_comm      = acm001.comm -  vcom2_t. /*commission  =  uwm100.com1_t*/ /*uwm100.com2_t*/
    
            END. /* 70 */
            ELSE DO:
                FIND  uwm100 USE-INDEX uwm10001 WHERE
                      uwm100.policy = acm001.policy  AND
                      uwm100.rencnt = acm001.rencnt  AND
                      uwm100.endcnt = acm001.endcnt  NO-LOCK NO-ERROR.
                IF AVAIL uwm100 THEN
                    ASSIGN
                     n_polyear = uwm100.undyr
                     n_cedpol  = uwm100.cedpol
                     n_opnpol  = uwm100.opnpol
                     n_prvpol  = uwm100.prvpol
                     vcom1_t   = uwm100.com1_t
                     /*--- A500178 --- กลับไปใช้ฟิลด์ branch
                     n_polbrn  = SUBSTRING(uwm100.policy,2,1)   /* A47-0370  uwm100.branch */
                     ------*/
                     n_polbrn  = uwm100.branch
                     n_comdat  = uwm100.comdat.
    
                IF   (SUBSTR(acm001.policy,3,2) = "72" OR
                      SUBSTR(acm001.policy,3,2) = "73" OR 
                      SUBSTR(acm001.policy,3,2) = "74" )
                THEN DO:
                   ASSIGN
                     n_prem      = 0
                     n_comp      = acm001.prem  /*                 เบี้ย พรบ.*/ 
                     n_comm_comp = acm001.comm  /* commission  พรบ.*/ /*uwm100.com1_t */
                     n_comm      = 0.
                END.
                ELSE DO:      /* ทุก Line ยกเว้น 70 , 72 ,73 */
                   ASSIGN
                     n_prem      = acm001.prem
                     n_comp      = 0   
                     n_comm_comp = 0  
                     n_comm      = acm001.comm.
                END.
                 
            END.  /* loop หาเบี้ย ในแต่ละ line pol */

        END.   /* หาข้อมูลเฉพาะ รายการที่มีการระบุเบอร์ ก/ธ  M, R    A47-0142 */
                
    ASSIGN
        n_gross    = n_prem + n_comp + acm001.stamp + acm001.tax
        n_insur    = SUBSTR(acm001.ref,1,35)
        n_trntyp   = acm001.trnty1 + acm001.trnty2.
    /*===========** Cancel ** CHECK TRNDAT with in & over due ==========*/
        /*---By A53-0159---
        n_sdmonth = MONTH(acm001.trndat)
        n_sdyear  = YEAR(acm001.trndat)
        n_startdat = IF n_sdmonth = 12 THEN DATE (1,1,n_sdyear + 1)
                     ELSE DATE(n_sdmonth + 1,1,n_sdyear).  /*วันที่เริ่มนับ credit*/
        -----------------*/
        /*----A57-0401---
        RUN pdChkcomdat.  /*---A53-0159---*/
/* หา  n_duedat วันที่สุดท้ายที่อยู่ใน credit*/
        RUN pdFindDueDate.   /*A53-0159*/
        -------------*/
        /*---A57-0401---*/
          IF (acm001.branch >= "90" AND acm001.branch <= "98") OR
           (SUBSTR(acm001.policy,1,2) >= "I1" AND 
            SUBSTR(acm001.policy,1,2) <= "I9")  THEN DO:
              RUN pdChkcomdatNZI.  
              RUN pdFindDueDateNZI.
          END.
          ELSE DO:
                RUN pdChkcomdat.  /*---A53-0159---*/
        /* หา  n_duedat วันที่สุดท้ายที่อยู่ใน credit*/
                RUN pdFindDueDate.   /*A53-0159*/
          END.
          /*-----------*/
        
    v_trntyp12 = acm001.trnty1 + acm001.trnty2.
   /*--------------------------------------------------------------------*/

       FIND  FIRST agtprm_fil USE-INDEX by_trndat_acno   WHERE
             agtprm_fil.trndat = acm001.trndat  AND
             agtprm_fil.acno   = acm001.acno    AND
             agtprm_fil.poltyp = acm001.poltyp  AND
             agtprm_fil.policy = acm001.policy  AND
             agtprm_fil.endno  = acm001.recno   AND
             agtprm_fil.trntyp = v_trntyp12     AND
             agtprm_fil.docno  = acm001.docno   AND
             agtprm_fil.asdat  = n_asdat
       NO-LOCK NO-ERROR.
       IF NOT AVAIL agtprm_fil THEN DO:

          /*---A56-0047---
          RUN pdCreate (OUTPUT n_recid). /* Create Transaction*/  

          FIND agtprm_fil where recid(agtprm_fil) = n_recid NO-ERROR .
          IF  AVAIL agtprm_fil  THEN DO:
              
           ASSIGN
             agtprm_fil.asdat   = n_asdat
             agtprm_fil.acno    = acm001.acno
             agtprm_fil.agent   = acm001.agent
             agtprm_fil.poltyp  = acm001.poltyp
             agtprm_fil.polbran = n_polbrn
             agtprm_fil.polyear = n_polyear
             agtprm_fil.policy  = acm001.policy
             agtprm_fil.endno   = acm001.recno
             agtprm_fil.cedpol  = n_cedpol
             agtprm_fil.insur   = n_insur
             agtprm_fil.prem    = n_prem
             agtprm_fil.prem_comp = n_comp
             agtprm_fil.tax     = acm001.tax
             agtprm_fil.stamp   = acm001.stamp
             agtprm_fil.gross   = n_gross
             agtprm_fil.comm    = n_comm        
             agtprm_fil.comm_comp  =  n_comm_comp
             agtprm_fil.bal     = acm001.bal
             agtprm_fil.trndat  = acm001.trndat
             agtprm_fil.credit  = n_day
             agtprm_fil.trntyp  = n_trntyp
             agtprm_fil.docno   = acm001.docno
             agtprm_fil.acno_clicod =  n_clicod   /* A47-0142  acm001.clicod*/

             agtprm_fil.vehreg  = acm001.vehreg
             agtprm_fil.opnpol  = n_opnpol
             agtprm_fil.prvpol  = n_prvpol
             agtprm_fil.latdat  = acm001.latdat
             agtprm_fil.ac_name = n_xtm600
             agtprm_fil.addr1 =  n_add1
             agtprm_fil.addr2 =  n_add2
             agtprm_fil.addr3 =  n_add3
             agtprm_fil.addr4 =  n_add4
             agtprm_fil.odue6 = n_ltamt   /* credit Limit*/
             agtprm_fil.wcr   = n_wcr
             agtprm_fil.damt  = n_damt  /* 3 ช่อง */
             agtprm_fil.odue  = n_odue  /* 3 ช่อง*/

             agtprm_fil.odue1 = n_odue1
             agtprm_fil.odue2 = n_odue2
             agtprm_fil.odue3 = n_odue3
             agtprm_fil.odue4 = n_odue4
             agtprm_fil.odue5 = n_odue5

             agtprm_fil.startdat = n_startdat
             /*---A53-0159---
              agtprm_fil.duedat  = IF LOOKUP(n_trntyp,nv_YZCB) = 0 THEN n_duedat ELSE acm001.trndat  /*A46-0142  acm001.trndat */
              ------------*/
             agtprm_fil.duedat  = n_duedat
             agtprm_fil.poldes  = n_poldes
             agtprm_fil.type    = n_type
             agtprm_fil.comdat  = n_comdat.
          END.
          ----end A56-0047 ---*/

           RUN pdCreate.    /*A56-0047*/

        END. /* IF NOTAVAIL agtprm_fil*/

        RELEASE agtprm_fil.  /*A56-0047*/

       ASSIGN
            n_odmonth1  = 0  n_odmonth2 = 0  n_odmonth3 = 0  n_odmonth4  = 0
            n_odDay1    = 0  n_odDay2   = 0  n_odDay3   = 0  n_odDay4    = 0
            n_odat1     = ?  n_odat2    = ?  n_odat3    = ?  n_odat4     = ?

            nt_tdat  = STRING(n_todate,"99/99/9999")
            nt_asdat = STRING(n_asdat,"99/99/9999").

        vCountRec = vCountRec + 1 .

RELEASE agtprm_fil.
/*release acm001.*/

END.  /*acm001*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdProc_agtprm001 C-Win 
PROCEDURE pdProc_agtprm001 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_branch    AS CHAR.
DEF VAR nv_gpbranch  AS CHAR.
DEF BUFFER bf_agtprm FOR agtprm_fil.
DEF VAR nn_trnty1 AS CHAR.
ASSIGN  nn_trnty1 = "M,R,A,B,C".
/*---A61-0158---
RUN pd_creategrpstm.   /*--A60-0358 Create GroupStatement and Credit Control---*/
RUN pd_clrOverCr.      /*---A60-0358---*/
-----*/

FIND LAST agtprm_fil NO-LOCK.
nv_asdat = agtprm_fil.asdat.
DISP "Start Time" string(TIME, "HH:MM:SS").
FOR EACH bf_agtprm WHERE bf_agtprm.asdat    = 1/1/2000
                     AND bf_agtprm.startdat <> nv_asdat.
    PAUSE 0.
    DISP bf_agtprm.asdat WITH 1 COLUMN 1 DOWN TITLE "Delete Group Branch".
    DELETE bf_agtprm.
END.

FOR EACH bf_agtprm WHERE bf_agtprm.asdat    = 1/5/2000
                     AND bf_agtprm.startdat <> nv_asdat.
    PAUSE 0.
    DISP bf_agtprm.asdat WITH 1 COLUMN 1 DOWN TITLE "Delete Branch".
    DELETE bf_agtprm.
END.

FOR EACH bf_agtprm WHERE bf_agtprm.asdat    = 1/10/2000
                     AND bf_agtprm.startdat <> nv_asdat.
    PAUSE 0.
    DISP bf_agtprm.asdat WITH 1 COLUMN 1 DOWN TITLE "Delete Account".
    DELETE bf_agtprm.
END.

/*---A61-0158---*/
FOR EACH bf_agtprm WHERE bf_agtprm.asdat    = 1/11/2000
                     AND bf_agtprm.startdat <> nv_asdat.
    PAUSE 0.
    DISP bf_agtprm.asdat WITH 1 COLUMN 1 DOWN TITLE "Delete Account".
    DELETE bf_agtprm.
END.
/*-----------*/

FOR EACH bf_agtprm WHERE bf_agtprm.asdat    = 1/1/2000
                     AND bf_agtprm.startdat = nv_asdat.
    PAUSE 0.
    DISP bf_agtprm.asdat WITH 1 COLUMN 1 DOWN TITLE "Clear Group Branch".

    ASSIGN
    bf_agtprm.bal   = 0
    bf_agtprm.odue  = 0
    bf_agtprm.odue1 = 0
    bf_agtprm.odue2 = 0
    bf_agtprm.odue3 = 0
    bf_agtprm.odue4 = 0
    bf_agtprm.odue5 = 0
    bf_agtprm.odue6 = 0.
/*     DELETE bf_agtprm. */
END.

FOR EACH bf_agtprm WHERE bf_agtprm.asdat    = 1/5/2000
                     AND bf_agtprm.startdat = nv_asdat.
    PAUSE 0.
    DISP bf_agtprm.asdat WITH 1 COLUMN 1 DOWN TITLE "Clear Branch".

    ASSIGN
    bf_agtprm.bal   = 0
    bf_agtprm.odue  = 0
    bf_agtprm.odue1 = 0
    bf_agtprm.odue2 = 0
    bf_agtprm.odue3 = 0
    bf_agtprm.odue4 = 0
    bf_agtprm.odue5 = 0
    bf_agtprm.odue6 = 0.
/*     DELETE bf_agtprm. */
END.
FOR EACH bf_agtprm WHERE bf_agtprm.asdat    = 1/10/2000
                     AND bf_agtprm.startdat = nv_asdat.
    PAUSE 0.
    DISP bf_agtprm.asdat WITH 1 COLUMN 1 DOWN TITLE "Clear Acno".

    ASSIGN
    bf_agtprm.bal   = 0
    bf_agtprm.odue  = 0
    bf_agtprm.odue1 = 0
    bf_agtprm.odue2 = 0
    bf_agtprm.odue3 = 0
    bf_agtprm.odue4 = 0
    bf_agtprm.odue5 = 0
    bf_agtprm.odue6 = 0.
/*      DELETE bf_agtprm. */
END.
       
/*---A61-0158---*/
FOR EACH bf_agtprm WHERE bf_agtprm.asdat    = 1/11/2000
                     AND bf_agtprm.startdat = nv_asdat.
    PAUSE 0.
    DISP bf_agtprm.asdat WITH 1 COLUMN 1 DOWN TITLE "Clear Acno".

    ASSIGN
    bf_agtprm.bal   = 0
    bf_agtprm.odue  = 0
    bf_agtprm.odue1 = 0
    bf_agtprm.odue2 = 0
    bf_agtprm.odue3 = 0
    bf_agtprm.odue4 = 0
    bf_agtprm.odue5 = 0
    bf_agtprm.odue6 = 0.
/*      DELETE bf_agtprm. */
END.
/*--------------*/

/*--------------*/
FOR EACH bf_agtprm WHERE bf_agtprm.asdat = 1/20/2000
                      AND bf_agtprm.startdat = nv_asdat.
    PAUSE 0.
    DISP bf_agtprm.asdat WITH 1 COLUMN 1 DOWN.

    ASSIGN
    bf_agtprm.bal   = 0
    bf_agtprm.odue  = 0
    bf_agtprm.odue1 = 0
    bf_agtprm.odue2 = 0
    bf_agtprm.odue3 = 0
    bf_agtprm.odue4 = 0
    bf_agtprm.odue5 = 0
    bf_agtprm.odue6 = 0.
/*     DELETE bf_agtprm. */
END.

FOR EACH agtprm_fil NO-LOCK WHERE agtprm_fil.asdat = nv_asdat.

    nv_branch = SUBSTR(agtprm_fil.policy,1,2).
    IF SUBSTR(agtprm_fil.policy,1,1) = "9" OR
      (
        SUBSTR(agtprm_fil.policy,1,2) >= "I1" AND
        SUBSTR(agtprm_fil.policy,1,2) <= "I9"
      )
         THEN nv_gpbranch = "NZI".
         ELSE nv_gpbranch = "Safety".

    PAUSE 0.
    DISP nv_asdat nv_gpbranch nv_branch FORMAT "x(10)" 
         agtprm_fil.acno FORMAT "x(12)"
         agtprm_fil.policy WITH 1 COLUMN 1 DOWN TITLE "Process".

    /* Group Branch */
    FIND FIRST bf_agtprm WHERE bf_agtprm.asdat = 1/1/2000
                          AND  bf_agtprm.acno  = nv_gpbranch
                          NO-ERROR.
    IF NOT AVAILABLE bf_agtprm THEN DO:
        CREATE bf_agtprm.
        ASSIGN bf_agtprm.asdat = 1/1/2000
               bf_agtprm.acno  = nv_gpbranch.
                
    END.
    
    ASSIGN
    bf_agtprm.bal      = bf_agtprm.bal   + agtprm_fil.bal
    bf_agtprm.odue     = bf_agtprm.odue  + agtprm_fil.odue
    bf_agtprm.odue1    = bf_agtprm.odue1 + agtprm_fil.odue1
    bf_agtprm.odue2    = bf_agtprm.odue2 + agtprm_fil.odue2
    bf_agtprm.odue3    = bf_agtprm.odue3 + agtprm_fil.odue3
    bf_agtprm.odue4    = bf_agtprm.odue4 + agtprm_fil.odue4
    bf_agtprm.odue5    = bf_agtprm.odue5 + agtprm_fil.odue5
    bf_agtprm.odue6    = bf_agtprm.odue6 + agtprm_fil.odue6
    bf_agtprm.startdat = nv_asdat.
    /* Branch */
    FIND FIRST bf_agtprm WHERE bf_agtprm.asdat  = 1/5/2000
                          AND  bf_agtprm.acno   = nv_gpbranch
                          AND  bf_agtprm.poltyp = nv_branch NO-ERROR.
    IF NOT AVAILABLE bf_agtprm THEN DO:
        CREATE bf_agtprm.
        ASSIGN bf_agtprm.asdat = 1/5/2000
               bf_agtprm.acno  = nv_gpbranch
               bf_agtprm.poltyp = nv_branch. 
    END.

    ASSIGN
    bf_agtprm.bal      = bf_agtprm.bal   + agtprm_fil.bal
    bf_agtprm.odue     = bf_agtprm.odue  + agtprm_fil.odue
    bf_agtprm.odue1    = bf_agtprm.odue1 + agtprm_fil.odue1
    bf_agtprm.odue2    = bf_agtprm.odue2 + agtprm_fil.odue2
    bf_agtprm.odue3    = bf_agtprm.odue3 + agtprm_fil.odue3
    bf_agtprm.odue4    = bf_agtprm.odue4 + agtprm_fil.odue4
    bf_agtprm.odue5    = bf_agtprm.odue5 + agtprm_fil.odue5
    bf_agtprm.odue6    = bf_agtprm.odue6 + agtprm_fil.odue6
    bf_agtprm.startdat = nv_asdat.
    
    /* Sum by branch by Acno */
    FIND FIRST bf_agtprm WHERE bf_agtprm.asdat  = 1/10/2000
                          AND  bf_agtprm.acno   = nv_gpbranch
                          AND  bf_agtprm.poltyp = nv_branch 
                          AND  bf_agtprm.policy = agtprm_fil.acno NO-ERROR.
    IF NOT AVAILABLE bf_agtprm THEN DO:
        CREATE bf_agtprm.
        ASSIGN bf_agtprm.asdat  = 1/10/2000
               bf_agtprm.acno   = nv_gpbranch
               bf_agtprm.poltyp = nv_branch
               bf_agtprm.policy = agtprm_fil.acno. 

    END.
    IF bf_agtprm.ac_name = "" THEN DO:
       bf_agtprm.ac_name = agtprm_fil.ac_name.
    END.

    ASSIGN
    bf_agtprm.bal      = bf_agtprm.bal   + agtprm_fil.bal
    bf_agtprm.odue     = bf_agtprm.odue  + agtprm_fil.odue
    bf_agtprm.odue1    = bf_agtprm.odue1 + agtprm_fil.odue1
    bf_agtprm.odue2    = bf_agtprm.odue2 + agtprm_fil.odue2
    bf_agtprm.odue3    = bf_agtprm.odue3 + agtprm_fil.odue3
    bf_agtprm.odue4    = bf_agtprm.odue4 + agtprm_fil.odue4
    bf_agtprm.odue5    = bf_agtprm.odue5 + agtprm_fil.odue5
    bf_agtprm.odue6    = bf_agtprm.odue6 + agtprm_fil.odue6
    bf_agtprm.startdat = nv_asdat.

    /*---A61-0158----*/
    /* Sum by acno */
    IF  INDEX(nn_trnty1,SUBSTR(agtprm_fil.trntyp,1,1)) <> 0 THEN DO:

        FIND FIRST bf_agtprm WHERE bf_agtprm.asdat  = 1/11/2000
                              AND  bf_agtprm.acno   = agtprm_fil.acno
                              /*---A61-0158---
                              AND  bf_agtprm.poltyp = nv_gpbranch 
                              AND  bf_agtprm.policy = nv_branch
                              ----------*/  NO-ERROR.
        IF NOT AVAILABLE bf_agtprm THEN DO:
            CREATE bf_agtprm.
            ASSIGN bf_agtprm.asdat  = 1/11/2000
                   bf_agtprm.acno   = agtprm_fil.acno.
                   /*-----A61-0158----
                   bf_agtprm.poltyp = nv_gpbranch
                   bf_agtprm.policy = nv_branch. 
                   ----------*/
        
        END.
        IF bf_agtprm.ac_name = "" THEN DO:
           bf_agtprm.ac_name = agtprm_fil.ac_name.
        END.
    END.  /* end index(nn_trnty1) */

    ASSIGN
    bf_agtprm.bal      = bf_agtprm.bal   + agtprm_fil.bal
    bf_agtprm.odue     = bf_agtprm.odue  + agtprm_fil.odue
    bf_agtprm.odue1    = bf_agtprm.odue1 + agtprm_fil.odue1
    bf_agtprm.odue2    = bf_agtprm.odue2 + agtprm_fil.odue2
    bf_agtprm.odue3    = bf_agtprm.odue3 + agtprm_fil.odue3
    bf_agtprm.odue4    = bf_agtprm.odue4 + agtprm_fil.odue4
    bf_agtprm.odue5    = bf_agtprm.odue5 + agtprm_fil.odue5
    bf_agtprm.odue6    = bf_agtprm.odue6 + agtprm_fil.odue6
    bf_agtprm.startdat = nv_asdat.

    /*---A61-0158-----
    /*---A60-0489---*/
    IF  INDEX(nn_trnty1,SUBSTR(agtprm_fil.trntyp,1,1)) <> 0 THEN DO:

        FIND xmm600 USE-INDEX xmm60001 WHERE xmm600.acno = agtprm_fil.acno AND xmm600.crcon = YES NO-ERROR.
        IF AVAIL xmm600 THEN DO:

            DISP agtprm.policy FORMAT "X(13)" WITH 1 COLUMN 1 DOWN TITLE "Check Credit Control".
            PAUSE 0.
            
            FIND FIRST tagtprm WHERE tagtprm.asdat  = agtprm_fil.asdat AND 
                                     tagtprm.gpstmt = xmm600.gpstmt    AND
                                     tagtprm.acno   = agtprm_fil.acno   NO-ERROR.
            IF NOT AVAIL tagtprm  THEN DO:
               CREATE tagtprm.
               ASSIGN tagtprm.asdat   = agtprm_fil.asdat
                      tagtprm.gpstmt  = xmm600.gpstmt
                      tagtprm.acno    = xmm600.acno
                      tagtprm.bal     = agtprm_fil.bal
                      tagtprm.limit   = xmm600.ltamt
                      tagtprm.crcon   = xmm600.crcon.
            END.
            ELSE DO:
                ASSIGN tagtprm.bal   = tagtprm.bal + agtprm_fil.bal
                       tagtprm.limit = tagtprm.limit + xmm600.ltamt.
            END.
            
            IF tagtprm.bal > xmm600.ltamt THEN DO:
            
               ASSIGN tagtprm.iblack = "OverCredit"
                      xmm600.iblack  = "OverCredit".
            END.
            ELSE DO:
                 ASSIGN tagtprm.iblack = ""
                        xmm600.iblack  = "".
            END.

        END.  /* end FIND xmm600  */

        RELEASE xmm600 NO-ERROR.

    END.  /*---end A60-0489---*/
    -------A61-0158--------------*/

END.  /*---end each agtprm_fil---*/


DISP "End Time" string(TIME, "HH:MM:SS").


/*----A60-0489---
FOR EACH agtprm_fil NO-LOCK WHERE agtprm_fil.asdat = 1/10/2000  /*02/05/2016*/
                              AND agtprm_fil.startdat = nv_asdat
                              AND (agtprm_fil.policy  >= "A"
                              AND  agtprm_fil.policy  <= "Bzzzzzzzzz").

 FIND xmm600 USE-INDEX xmm60001 WHERE xmm600.acno = agtprm_fil.policy AND xmm600.crcon  = YES  NO-ERROR.
 IF AVAIL xmm600 THEN DO:

    

       DISP agtprm.policy WITH 1 COLUMN 1 DOWN TITLE "Check credit Control".
       PAUSE 0.

       FIND FIRST tagtprm WHERE tagtprm.asdat  = agtprm_fil.asdat AND 
                                tagtprm.gpstmt = xmm600.gpstmt    AND
                                tagtprm.acno   = agtprm_fil.policy   NO-ERROR.
         IF NOT AVAIL tagtprm  THEN DO:
            CREATE tagtprm.
            ASSIGN tagtprm.asdat   = agtprm_fil.asdat
                   tagtprm.gpstmt  = xmm600.gpstmt
                   tagtprm.acno    = xmm600.acno
                   tagtprm.bal     = agtprm_fil.bal
                   tagtprm.limit   = xmm600.ltamt
                   tagtprm.crcon   = xmm600.crcon.
         END.
         ELSE DO:
             ASSIGN tagtprm.bal   = tagtprm.bal + agtprm_fil.bal
                    tagtprm.limit = tagtprm.limit + xmm600.ltamt.
         END.

         FIND FIRST tgrpacno WHERE tgrpacno.gpstmt = xmm600.gpstmt AND
                                   tgrpacno.acno   = xmm600.acno   NO-ERROR.
         IF NOT AVAIL tgrpacno THEN  DO:
             CREATE tgrpacno.
             ASSIGN tgrpacno.gpstmt = xmm600.gpstmt
                    tgrpacno.acno   = xmm600.acno.  
         END.

         IF agtprm_fil.bal > xmm600.ltamt THEN DO:

            ASSIGN tagtprm.iblack = "OverCredit"
                   xmm600.iblack  = "OverCredit".

            OUTPUT TO VALUE (nv_output2) APPEND NO-ECHO.
            EXPORT DELIMITER ";" 
             tagtprm.asdat
             tagtprm.gpstmt
             tagtprm.acno
             tagtprm.bal
             tagtprm.limit 
             tagtprm.iblack
             tagtprm.crcon.
            OUTPUT CLOSE.
         END.
         ELSE DO:
              ASSIGN tagtprm.iblack = ""
                     xmm600.iblack  = "".
         END.

 END. /* end FIND xmm600  */
END.   /* end agtprm_fil */
RELEASE xmm600 NO-ERROR.
--------------------------------------*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdProc_agtprm001bck C-Win 
PROCEDURE pdProc_agtprm001bck :
/*------------------------------------------------------------------------------
      Purpose:     
      Parameters:  <none>
      Notes:       
    ------------------------------------------------------------------------------*/

    DEF VAR nv_asdat     LIKE agtprm_fil.asdat.
    DEF VAR nv_branch    AS CHAR.
    DEF VAR nv_gpbranch  AS CHAR.
    DEF BUFFER bf_agtprm FOR agtprm_fil.

    FIND LAST agtprm_fil NO-LOCK.
    nv_asdat = agtprm_fil.asdat.
    DISP "Start Time" string(TIME, "HH:MM:SS").
    FOR EACH bf_agtprm WHERE bf_agtprm.asdat = 1/1/2000
                          AND bf_agtprm.startdat <> nv_asdat.
        PAUSE 0.
        DISP bf_agtprm.asdat WITH 1 COLUMN 1 DOWN TITLE "Delete Group Branch".
        DELETE bf_agtprm.
    END.

    FOR EACH bf_agtprm WHERE bf_agtprm.asdat = 1/5/2000
                          AND bf_agtprm.startdat <> nv_asdat.
        PAUSE 0.
        DISP bf_agtprm.asdat WITH 1 COLUMN 1 DOWN TITLE "Delete Branch".
        DELETE bf_agtprm.
    END.

    FOR EACH bf_agtprm WHERE bf_agtprm.asdat = 1/10/2000
                          AND bf_agtprm.startdat <> nv_asdat.
        PAUSE 0.
        DISP bf_agtprm.asdat WITH 1 COLUMN 1 DOWN TITLE "Delete Account".
        DELETE bf_agtprm.
    END.

    FOR EACH bf_agtprm WHERE bf_agtprm.asdat = 1/1/2000
                          AND bf_agtprm.startdat = nv_asdat.
        PAUSE 0.
        DISP bf_agtprm.asdat WITH 1 COLUMN 1 DOWN TITLE "Clear Group Branch".

        ASSIGN
        bf_agtprm.bal   = 0
        bf_agtprm.odue  = 0
        bf_agtprm.odue1 = 0
        bf_agtprm.odue2 = 0
        bf_agtprm.odue3 = 0
        bf_agtprm.odue4 = 0
        bf_agtprm.odue5 = 0
        bf_agtprm.odue6 = 0.
    /*     DELETE bf_agtprm. */
    END.

    FOR EACH bf_agtprm WHERE bf_agtprm.asdat = 1/5/2000
                          AND bf_agtprm.startdat = nv_asdat.
        PAUSE 0.
        DISP bf_agtprm.asdat WITH 1 COLUMN 1 DOWN TITLE "Clear Branch".

        ASSIGN
        bf_agtprm.bal   = 0
        bf_agtprm.odue  = 0
        bf_agtprm.odue1 = 0
        bf_agtprm.odue2 = 0
        bf_agtprm.odue3 = 0
        bf_agtprm.odue4 = 0
        bf_agtprm.odue5 = 0
        bf_agtprm.odue6 = 0.
    /*     DELETE bf_agtprm. */
    END.
    FOR EACH bf_agtprm WHERE bf_agtprm.asdat = 1/10/2000
                          AND bf_agtprm.startdat = nv_asdat.
        PAUSE 0.
        DISP bf_agtprm.asdat WITH 1 COLUMN 1 DOWN TITLE "Clear Acno".

        ASSIGN
        bf_agtprm.bal   = 0
        bf_agtprm.odue  = 0
        bf_agtprm.odue1 = 0
        bf_agtprm.odue2 = 0
        bf_agtprm.odue3 = 0
        bf_agtprm.odue4 = 0
        bf_agtprm.odue5 = 0
        bf_agtprm.odue6 = 0.
    /*      DELETE bf_agtprm. */
    END.
    FOR EACH bf_agtprm WHERE bf_agtprm.asdat    = 1/20/2000
                         AND bf_agtprm.startdat = nv_asdat.
        PAUSE 0.
        DISP bf_agtprm.asdat WITH 1 COLUMN 1 DOWN.

        ASSIGN
        bf_agtprm.bal   = 0
        bf_agtprm.odue  = 0
        bf_agtprm.odue1 = 0
        bf_agtprm.odue2 = 0
        bf_agtprm.odue3 = 0
        bf_agtprm.odue4 = 0
        bf_agtprm.odue5 = 0
        bf_agtprm.odue6 = 0.
    /*     DELETE bf_agtprm. */
    END.

    FOR EACH agtprm_fil NO-LOCK WHERE agtprm_fil.asdat = nv_asdat.

        nv_branch = SUBSTR(agtprm_fil.policy,1,2).
        IF SUBSTR(agtprm_fil.policy,1,1) = "9" OR
          (SUBSTR(agtprm_fil.policy,1,2) >= "I1" AND
            SUBSTR(agtprm_fil.policy,1,2) <= "I9")
             THEN nv_gpbranch = "NZI".
             ELSE nv_gpbranch = "Safety".

        PAUSE 0.
        DISP nv_asdat nv_gpbranch nv_branch FORMAT "x(10)" 
             agtprm_fil.acno FORMAT "x(12)"
             agtprm_fil.policy WITH 1 COLUMN 1 DOWN TITLE "Process".

        /* Group Branch */
        FIND FIRST bf_agtprm WHERE bf_agtprm.asdat = 1/1/2000
                              AND  bf_agtprm.acno  = nv_gpbranch
                              NO-ERROR.
        IF NOT AVAILABLE bf_agtprm THEN DO:
            CREATE bf_agtprm.
            ASSIGN bf_agtprm.asdat = 1/1/2000
                   bf_agtprm.acno  = nv_gpbranch.

        END.

        ASSIGN
        bf_agtprm.bal      = bf_agtprm.bal   + agtprm_fil.bal
        bf_agtprm.odue     = bf_agtprm.odue  + agtprm_fil.odue
        bf_agtprm.odue1    = bf_agtprm.odue1 + agtprm_fil.odue1
        bf_agtprm.odue2    = bf_agtprm.odue2 + agtprm_fil.odue2
        bf_agtprm.odue3    = bf_agtprm.odue3 + agtprm_fil.odue3
        bf_agtprm.odue4    = bf_agtprm.odue4 + agtprm_fil.odue4
        bf_agtprm.odue5    = bf_agtprm.odue5 + agtprm_fil.odue5
        bf_agtprm.odue6    = bf_agtprm.odue6 + agtprm_fil.odue6
        bf_agtprm.startdat = nv_asdat.
        /* Branch */
        FIND FIRST bf_agtprm WHERE bf_agtprm.asdat  = 1/5/2000
                              AND  bf_agtprm.acno   = nv_gpbranch
                              AND  bf_agtprm.poltyp = nv_branch NO-ERROR.
        IF NOT AVAILABLE bf_agtprm THEN DO:
            CREATE bf_agtprm.
            ASSIGN bf_agtprm.asdat  = 1/5/2000
                   bf_agtprm.acno   = nv_gpbranch
                   bf_agtprm.poltyp = nv_branch. 
        END.

        ASSIGN
        bf_agtprm.bal   = bf_agtprm.bal   + agtprm_fil.bal
        bf_agtprm.odue  = bf_agtprm.odue  + agtprm_fil.odue
        bf_agtprm.odue1 = bf_agtprm.odue1 + agtprm_fil.odue1
        bf_agtprm.odue2 = bf_agtprm.odue2 + agtprm_fil.odue2
        bf_agtprm.odue3 = bf_agtprm.odue3 + agtprm_fil.odue3
        bf_agtprm.odue4 = bf_agtprm.odue4 + agtprm_fil.odue4
        bf_agtprm.odue5 = bf_agtprm.odue5 + agtprm_fil.odue5
        bf_agtprm.odue6 = bf_agtprm.odue6 + agtprm_fil.odue6
        bf_agtprm.startdat = nv_asdat.

        /* Sum by branch by Acno */
        FIND FIRST bf_agtprm WHERE bf_agtprm.asdat = 1/10/2000
                              AND  bf_agtprm.acno  = nv_gpbranch
                              AND  bf_agtprm.poltyp = nv_branch 
                              AND  bf_agtprm.policy = agtprm_fil.acno NO-ERROR.
        IF NOT AVAILABLE bf_agtprm THEN DO:
            CREATE bf_agtprm.
            ASSIGN bf_agtprm.asdat  = 1/10/2000
                   bf_agtprm.acno   = nv_gpbranch
                   bf_agtprm.poltyp = nv_branch
                   bf_agtprm.policy = agtprm_fil.acno. 

        END.
        IF bf_agtprm.ac_name = "" THEN DO:
           bf_agtprm.ac_name = agtprm_fil.ac_name.
        END.
        
        ASSIGN
        bf_agtprm.bal   = bf_agtprm.bal   + agtprm_fil.bal
        bf_agtprm.odue  = bf_agtprm.odue  + agtprm_fil.odue
        bf_agtprm.odue1 = bf_agtprm.odue1 + agtprm_fil.odue1
        bf_agtprm.odue2 = bf_agtprm.odue2 + agtprm_fil.odue2
        bf_agtprm.odue3 = bf_agtprm.odue3 + agtprm_fil.odue3
        bf_agtprm.odue4 = bf_agtprm.odue4 + agtprm_fil.odue4
        bf_agtprm.odue5 = bf_agtprm.odue5 + agtprm_fil.odue5
        bf_agtprm.odue6 = bf_agtprm.odue6 + agtprm_fil.odue6
        bf_agtprm.startdat = nv_asdat.

        /* Sum by acno by branch */
        FIND FIRST bf_agtprm WHERE bf_agtprm.asdat  = 1/11/2000
                              AND  bf_agtprm.acno   = agtprm_fil.acno
                              AND  bf_agtprm.poltyp = nv_gpbranch 
                              AND  bf_agtprm.policy = nv_branch NO-ERROR.
        IF NOT AVAILABLE bf_agtprm THEN DO:
            CREATE bf_agtprm.
            ASSIGN bf_agtprm.asdat  = 1/11/2000
                   bf_agtprm.acno   = agtprm_fil.acno
                   bf_agtprm.poltyp = nv_gpbranch
                   bf_agtprm.policy = nv_branch. 

        END.
        IF bf_agtprm.ac_name = "" THEN DO:
           bf_agtprm.ac_name = agtprm_fil.ac_name.
        END.
        
        ASSIGN
        bf_agtprm.bal   = bf_agtprm.bal   + agtprm_fil.bal
        bf_agtprm.odue  = bf_agtprm.odue  + agtprm_fil.odue
        bf_agtprm.odue1 = bf_agtprm.odue1 + agtprm_fil.odue1
        bf_agtprm.odue2 = bf_agtprm.odue2 + agtprm_fil.odue2
        bf_agtprm.odue3 = bf_agtprm.odue3 + agtprm_fil.odue3
        bf_agtprm.odue4 = bf_agtprm.odue4 + agtprm_fil.odue4
        bf_agtprm.odue5 = bf_agtprm.odue5 + agtprm_fil.odue5
        bf_agtprm.odue6 = bf_agtprm.odue6 + agtprm_fil.odue6
        bf_agtprm.startdat = nv_asdat.

    END.

    DISP "End Time" string(TIME, "HH:MM:SS").

    END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdProc_agtprm001_bck C-Win 
PROCEDURE pdProc_agtprm001_bck :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

DEF VAR nv_branch    AS CHAR.
DEF VAR nv_gpbranch  AS CHAR.
DEF BUFFER bf_agtprm FOR agtprm_fil.

FIND LAST agtprm_fil NO-LOCK.
nv_asdat = agtprm_fil.asdat.
DISP "Start Time" string(TIME, "HH:MM:SS").
FOR EACH bf_agtprm WHERE bf_agtprm.asdat    = 1/1/2000
                     AND bf_agtprm.startdat <> nv_asdat.
    PAUSE 0.
    DISP bf_agtprm.asdat WITH 1 COLUMN 1 DOWN TITLE "Delete Group Branch".
    DELETE bf_agtprm.
END.

FOR EACH bf_agtprm WHERE bf_agtprm.asdat    = 1/5/2000
                     AND bf_agtprm.startdat <> nv_asdat.
    PAUSE 0.
    DISP bf_agtprm.asdat WITH 1 COLUMN 1 DOWN TITLE "Delete Branch".
    DELETE bf_agtprm.
END.

FOR EACH bf_agtprm WHERE bf_agtprm.asdat    = 1/10/2000
                     AND bf_agtprm.startdat <> nv_asdat.
    PAUSE 0.
    DISP bf_agtprm.asdat WITH 1 COLUMN 1 DOWN TITLE "Delete Account".
    DELETE bf_agtprm.
END.

FOR EACH bf_agtprm WHERE bf_agtprm.asdat    = 1/1/2000
                     AND bf_agtprm.startdat = nv_asdat.
    PAUSE 0.
    DISP bf_agtprm.asdat WITH 1 COLUMN 1 DOWN TITLE "Clear Group Branch".

    ASSIGN
    bf_agtprm.bal   = 0
    bf_agtprm.odue  = 0
    bf_agtprm.odue1 = 0
    bf_agtprm.odue2 = 0
    bf_agtprm.odue3 = 0
    bf_agtprm.odue4 = 0
    bf_agtprm.odue5 = 0
    bf_agtprm.odue6 = 0.
/*     DELETE bf_agtprm. */
END.

FOR EACH bf_agtprm WHERE bf_agtprm.asdat    = 1/5/2000
                     AND bf_agtprm.startdat = nv_asdat.
    PAUSE 0.
    DISP bf_agtprm.asdat WITH 1 COLUMN 1 DOWN TITLE "Clear Branch".

    ASSIGN
    bf_agtprm.bal   = 0
    bf_agtprm.odue  = 0
    bf_agtprm.odue1 = 0
    bf_agtprm.odue2 = 0
    bf_agtprm.odue3 = 0
    bf_agtprm.odue4 = 0
    bf_agtprm.odue5 = 0
    bf_agtprm.odue6 = 0.
/*     DELETE bf_agtprm. */
END.
FOR EACH bf_agtprm WHERE bf_agtprm.asdat    = 1/10/2000
                     AND bf_agtprm.startdat = nv_asdat.
    PAUSE 0.
    DISP bf_agtprm.asdat WITH 1 COLUMN 1 DOWN TITLE "Clear Acno".

    ASSIGN
    bf_agtprm.bal   = 0
    bf_agtprm.odue  = 0
    bf_agtprm.odue1 = 0
    bf_agtprm.odue2 = 0
    bf_agtprm.odue3 = 0
    bf_agtprm.odue4 = 0
    bf_agtprm.odue5 = 0
    bf_agtprm.odue6 = 0.
/*      DELETE bf_agtprm. */
END.
FOR EACH bf_agtprm WHERE bf_agtprm.asdat = 1/20/2000
                      AND bf_agtprm.startdat = nv_asdat.
    PAUSE 0.
    DISP bf_agtprm.asdat WITH 1 COLUMN 1 DOWN.

    ASSIGN
    bf_agtprm.bal   = 0
    bf_agtprm.odue  = 0
    bf_agtprm.odue1 = 0
    bf_agtprm.odue2 = 0
    bf_agtprm.odue3 = 0
    bf_agtprm.odue4 = 0
    bf_agtprm.odue5 = 0
    bf_agtprm.odue6 = 0.
/*     DELETE bf_agtprm. */
END.


FOR EACH tagtprm . 
    DELETE tagtprm.
END.

ASSIGN nv_output1 = "c:\temp\agdet.slk"
       nv_output2 = "c:\temp\agovd.slk".
/*
OUTPUT TO VALUE (nv_output1) NO-ECHO.
EXPORT DELIMITER ";" 
       "Asdat"
       "Group "
       "Producer"
       "Bal"
       "Cr.Limit" 
       "Status"
       "Credit control". 
OUTPUT CLOSE.
*/

OUTPUT TO VALUE (nv_output2) NO-ECHO.
EXPORT DELIMITER ";" 
       "Asdat"
       "Group "
       "Producer"
       "Bal"
       "Cr.Limit" 
       "Status"
       "Credit control".
OUTPUT CLOSE.


FOR EACH agtprm_fil NO-LOCK WHERE agtprm_fil.asdat = nv_asdat.

    nv_branch = SUBSTR(agtprm_fil.policy,1,2).
    IF SUBSTR(agtprm_fil.policy,1,1) = "9" OR
      (
        SUBSTR(agtprm_fil.policy,1,2) >= "I1" AND
        SUBSTR(agtprm_fil.policy,1,2) <= "I9"
      )
         THEN nv_gpbranch = "NZI".
         ELSE nv_gpbranch = "Safety".

    PAUSE 0.
    DISP nv_asdat nv_gpbranch nv_branch FORMAT "x(10)" 
         agtprm_fil.acno FORMAT "x(12)"
         agtprm_fil.policy WITH 1 COLUMN 1 DOWN TITLE "Process".

    /* Group Branch */
    FIND FIRST bf_agtprm WHERE bf_agtprm.asdat = 1/1/2000
                          AND  bf_agtprm.acno  = nv_gpbranch
                          NO-ERROR.
    IF NOT AVAILABLE bf_agtprm THEN DO:
        CREATE bf_agtprm.
        ASSIGN bf_agtprm.asdat = 1/1/2000
               bf_agtprm.acno  = nv_gpbranch.
                
    END.
    
    ASSIGN
    bf_agtprm.bal      = bf_agtprm.bal   + agtprm_fil.bal
    bf_agtprm.odue     = bf_agtprm.odue  + agtprm_fil.odue
    bf_agtprm.odue1    = bf_agtprm.odue1 + agtprm_fil.odue1
    bf_agtprm.odue2    = bf_agtprm.odue2 + agtprm_fil.odue2
    bf_agtprm.odue3    = bf_agtprm.odue3 + agtprm_fil.odue3
    bf_agtprm.odue4    = bf_agtprm.odue4 + agtprm_fil.odue4
    bf_agtprm.odue5    = bf_agtprm.odue5 + agtprm_fil.odue5
    bf_agtprm.odue6    = bf_agtprm.odue6 + agtprm_fil.odue6
    bf_agtprm.startdat = nv_asdat.
    /* Branch */
    FIND FIRST bf_agtprm WHERE bf_agtprm.asdat  = 1/5/2000
                          AND  bf_agtprm.acno   = nv_gpbranch
                          AND  bf_agtprm.poltyp = nv_branch NO-ERROR.
    IF NOT AVAILABLE bf_agtprm THEN DO:
        CREATE bf_agtprm.
        ASSIGN bf_agtprm.asdat = 1/5/2000
               bf_agtprm.acno  = nv_gpbranch
               bf_agtprm.poltyp = nv_branch. 
    END.

    ASSIGN
    bf_agtprm.bal      = bf_agtprm.bal   + agtprm_fil.bal
    bf_agtprm.odue     = bf_agtprm.odue  + agtprm_fil.odue
    bf_agtprm.odue1    = bf_agtprm.odue1 + agtprm_fil.odue1
    bf_agtprm.odue2    = bf_agtprm.odue2 + agtprm_fil.odue2
    bf_agtprm.odue3    = bf_agtprm.odue3 + agtprm_fil.odue3
    bf_agtprm.odue4    = bf_agtprm.odue4 + agtprm_fil.odue4
    bf_agtprm.odue5    = bf_agtprm.odue5 + agtprm_fil.odue5
    bf_agtprm.odue6    = bf_agtprm.odue6 + agtprm_fil.odue6
    bf_agtprm.startdat = nv_asdat.
    
    /* Sum by branch by Acno */
    FIND FIRST bf_agtprm WHERE bf_agtprm.asdat  = 1/10/2000
                          AND  bf_agtprm.acno   = nv_gpbranch
                          AND  bf_agtprm.poltyp = nv_branch 
                          AND  bf_agtprm.policy = agtprm_fil.acno NO-ERROR.
    IF NOT AVAILABLE bf_agtprm THEN DO:
        CREATE bf_agtprm.
        ASSIGN bf_agtprm.asdat  = 1/10/2000
               bf_agtprm.acno   = nv_gpbranch
               bf_agtprm.poltyp = nv_branch
               bf_agtprm.policy = agtprm_fil.acno. 

    END.
    IF bf_agtprm.ac_name = "" THEN DO:
       bf_agtprm.ac_name = agtprm_fil.ac_name.
    END.

    ASSIGN
    bf_agtprm.bal      = bf_agtprm.bal   + agtprm_fil.bal
    bf_agtprm.odue     = bf_agtprm.odue  + agtprm_fil.odue
    bf_agtprm.odue1    = bf_agtprm.odue1 + agtprm_fil.odue1
    bf_agtprm.odue2    = bf_agtprm.odue2 + agtprm_fil.odue2
    bf_agtprm.odue3    = bf_agtprm.odue3 + agtprm_fil.odue3
    bf_agtprm.odue4    = bf_agtprm.odue4 + agtprm_fil.odue4
    bf_agtprm.odue5    = bf_agtprm.odue5 + agtprm_fil.odue5
    bf_agtprm.odue6    = bf_agtprm.odue6 + agtprm_fil.odue6
    bf_agtprm.startdat = nv_asdat.

    /* Sum by acno by branch */
    FIND FIRST bf_agtprm WHERE bf_agtprm.asdat  = 1/11/2000
                          AND  bf_agtprm.acno   = agtprm_fil.acno
                          AND  bf_agtprm.poltyp = nv_gpbranch 
                          AND  bf_agtprm.policy = nv_branch NO-ERROR.
    IF NOT AVAILABLE bf_agtprm THEN DO:
        CREATE bf_agtprm.
        ASSIGN bf_agtprm.asdat  = 1/11/2000
               bf_agtprm.acno   = agtprm_fil.acno
               bf_agtprm.poltyp = nv_gpbranch
               bf_agtprm.policy = nv_branch. 

    END.
    IF bf_agtprm.ac_name = "" THEN DO:
       bf_agtprm.ac_name = agtprm_fil.ac_name.
    END.

    ASSIGN
    bf_agtprm.bal      = bf_agtprm.bal   + agtprm_fil.bal
    bf_agtprm.odue     = bf_agtprm.odue  + agtprm_fil.odue
    bf_agtprm.odue1    = bf_agtprm.odue1 + agtprm_fil.odue1
    bf_agtprm.odue2    = bf_agtprm.odue2 + agtprm_fil.odue2
    bf_agtprm.odue3    = bf_agtprm.odue3 + agtprm_fil.odue3
    bf_agtprm.odue4    = bf_agtprm.odue4 + agtprm_fil.odue4
    bf_agtprm.odue5    = bf_agtprm.odue5 + agtprm_fil.odue5
    bf_agtprm.odue6    = bf_agtprm.odue6 + agtprm_fil.odue6
    bf_agtprm.startdat = nv_asdat.

END.

DISP "End Time" string(TIME, "HH:MM:SS") skip
     "And then checking for Over Credit Limit ".

FOR EACH agtprm_fil NO-LOCK WHERE agtprm_fil.asdat = 1/10/2000  /*02/05/2016*/
                              AND agtprm_fil.startdat = nv_asdat
                              AND (agtprm_fil.policy  >= "A"
                              AND  agtprm_fil.policy  <= "Bzzzzzzzzz").

 FIND xmm600 USE-INDEX xmm60001 WHERE xmm600.acno = agtprm_fil.policy NO-ERROR.
    IF AVAIL xmm600 THEN DO:

       IF xmm600.crcon  = YES  THEN DO:

          DISP agtprm.policy WITH 1 COLUMN 1 DOWN TITLE "Check credit Control".
          PAUSE 0.

          FIND FIRST tagtprm WHERE tagtprm.asdat  = agtprm_fil.asdat AND 
                                   tagtprm.gpstmt = xmm600.gpstmt    AND
                                   tagtprm.acno   = agtprm_fil.policy   NO-ERROR.
            IF NOT AVAIL tagtprm  THEN DO:
               CREATE tagtprm.
               ASSIGN tagtprm.asdat   = agtprm_fil.asdat
                      tagtprm.gpstmt  = xmm600.gpstmt
                      tagtprm.acno    = xmm600.acno
                      tagtprm.bal     = agtprm_fil.bal
                      tagtprm.limit   = xmm600.ltamt
                      tagtprm.crcon   = xmm600.crcon.
            END.
            ELSE DO:
                ASSIGN tagtprm.bal   = tagtprm.bal + agtprm_fil.bal
                       tagtprm.limit = tagtprm.limit + xmm600.ltamt.
            END.

            FIND FIRST tgrpacno WHERE tgrpacno.gpstmt = xmm600.gpstmt AND
                                      tgrpacno.acno   = xmm600.acno   NO-ERROR.
            IF NOT AVAIL tgrpacno THEN  DO:
                CREATE tgrpacno.
                ASSIGN tgrpacno.gpstmt = xmm600.gpstmt
                       tgrpacno.acno   = xmm600.acno.  
            END.

            IF agtprm_fil.bal > xmm600.ltamt THEN DO:

               ASSIGN tagtprm.iblack = "OverCredit"
                      xmm600.iblack  = "OverCredit".

               OUTPUT TO VALUE (nv_output2) APPEND NO-ECHO.
               EXPORT DELIMITER ";" 
                tagtprm.asdat
                tagtprm.gpstmt
                tagtprm.acno
                tagtprm.bal
                tagtprm.limit 
                tagtprm.iblack
                tagtprm.crcon.
               OUTPUT CLOSE.
            END.
            ELSE DO:
                 ASSIGN tagtprm.iblack = ""
                        xmm600.iblack  = "".
            END.

       END.  /* end if xmm600.crcon = YES */
    END. /* end FIND xmm600  */
END.   /* end agtprm_fil */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_clrOverCr C-Win 
PROCEDURE pd_clrOverCr :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

FIND FIRST xmm600 USE-INDEX xmm60001 
         WHERE xmm600.acno >= "A000000" AND
                xmm600.crcon  = YES     NO-ERROR NO-WAIT.
IF AVAIL xmm600 THEN DO:  
    sicsyac.xmm600.iblack = "".
    
    REPEAT:
         FIND NEXT xmm600 USE-INDEX xmm60001 
             WHERE xmm600.crcon  = YES .
         IF xmm600.acno >= "Bzzzzzzzzz" OR NOT AVAIL xmm600 THEN LEAVE.
         sicsyac.xmm600.iblack = "".
         
    END.
END. 
RELEASE xmm600 NO-ERROR.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_creategrpstm C-Win 
PROCEDURE pd_creategrpstm :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

DEF VAR n_cnt AS INT FORMAT ">,>>>,>>9" INIT 0.

DEF BUFFER bxmm600 FOR xmm600.

FOR EACH xmm600 NO-LOCK WHERE xmm600.acno >= "A000000" AND
                              xmm600.acno <= "BZZZZZZZZZ".
                              
    n_cnt = n_cnt + 1.
    DISP n_cnt  xmm600.acno FORMAT "X(10)" .
    PAUSE 0.

    FIND FIRST tgrpstm NO-LOCK WHERE  tgrpstm.acno   = xmm600.acno  AND
                                    tgrpstm.gpstmt = xmm600.gpstmt NO-ERROR.
    IF NOT AVAIL tgrpstm THEN DO:
       CREATE tgrpstm.
       ASSIGN tgrpstm.gpstmt = xmm600.gpstmt
              tgrpstm.acno   = xmm600.acno 
              tgrpstm.amt    = xmm600.ltamt.

       IF xmm600.acno = xmm600.gpstmt THEN tgrpstm.grpamt = xmm600.ltamt.
       ELSE DO:
           
           FIND FIRST bxmm600 NO-LOCK USE-INDEX xmm60001 WHERE bxmm600.acno = xmm600.gpstmt NO-ERROR.
           IF AVAIL bxmm600 THEN  tgrpstm.grpamt = bxmm600.ltamt.
           ELSE DO:
               tgrpstm.grpamt = 0.
           END.
       END.
    END.  

END.

OUTPUT TO VALUE ("D:\temp\AGBR_Credit.slk") NO-ECHO.
EXPORT DELIMITER ";"
    "Asdate of Export Data " 
    TODAY FORMAT "99/99/9999".
EXPORT DELIMITER ";"
    "Seq"
    "Group Statement"
    "Group Credit"
    "Acno"
    "Credit Limit".
OUTPUT CLOSE.

n_cnt = 0.

FOR EACH tgrpstm NO-LOCK BREAK BY tgrpstm.gpstmt
                               BY tgrpstm.acno :
    n_cnt = n_cnt + 1.
    DISP tgrpstm.acno tgrpstm.amt tgrpstm.grpamt.
    PAUSE 0.

    OUTPUT TO VALUE ("D:\temp\AGBR_Credit.slk") APPEND NO-ECHO.
    EXPORT DELIMITER ";"
         n_cnt
         tgrpstm.gpstmt FORMAT "X(10)"
         tgrpstm.grpamt
         tgrpstm.acno   FORMAT "X(10)"
         tgrpstm.amt.
    OUTPUT CLOSE.
    
END.
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
  Purpose:  
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fuNumDay C-Win 
FUNCTION fuNumDay RETURNS INTEGER
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fuNumMonth C-Win 
FUNCTION fuNumMonth RETURNS INTEGER
  (INPUT vMonth AS INT ,vDate AS DATE ) :
/*------------------------------------------------------------------------------
  Purpose:  
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

