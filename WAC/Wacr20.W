&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
&Scoped-define WINDOW-NAME WACR20
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS WACR20 
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
 /* Modify : A50-0178 11/2007  By Sayamol 
        Add Branch   */
/* Modify : A50-0218  11/2007 By Sayamol
        Uncomment Address  */      
          
Modify By A51-0124  Sayamol  เช็ค Process & Report & Branch          

 
/* โปรแกรมที่ใช่ร่วมกัน*/
Wac
        -Wacr10.w             /* PROCESS PREMIUM STATEMENT (A4) */
                                       /*  ใช้ Warc02.w สั่ง print  PRINT PREMIUM STATEMENT (A4)*/
        -Wacc10.p
Whp
        -WhpAcno.w
Wut
        -WutDiCen.p
        -WutWiCen.p
 -----------------------------------------------------------------------
 Modify By A51-0186  AMPARAT C. 
       Outward Fac ทั้ง Premium และ Claim ไม่มีข้อมูลบนโปรแกรม Safety Soft หลังการ Process  
       
       
 Modify By : Lukkana M.  Date : A52-0241
 Assign No : A52-0241  - เพิ่มคำนวณค่า suminsurer , Reserve   
 /* Modify By : Benjaporn J. [A60-0267] date 30/09/2017    
             : ขยาย Format Docno. จาก 7 หลักเป็น 10 หลัก           */ 
/* Modify By : Porntiwa T. A60-0267  Date 14/09/2018
               ปรับขยายเลข Document จาก 7 เป็น 10 หลัก เพื่อนำเข้าระบบให้ถูกต้อง                  */            

*****************************************/    
/* ***************************  Definitions  ************************** */
DEF     SHARED VAR n_User           AS CHAR.
DEF     SHARED VAR n_Passwd         AS CHAR.  
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
DEF  VAR RB-TEST-PATTERN      AS LOG  INIT no.
DEF  VAR RB-WINDOW-TITLE      AS CHAR INIT "".
DEF  VAR RB-DISPLAY-ERRORS    AS LOG  INIT yes.
DEF  VAR RB-DISPLAY-STATUS    AS LOG  INIT yes.
DEF  VAR RB-NO-WAIT           AS LOG  INIT no.
DEF  VAR RB-OTHER-PARAMETERS  AS CHAR INIT "".

/* Parameters Definitions ---                                           */
/*---- A50-0178
DEF NEW SHARED VAR n_agent1   AS CHAR FORMAT "x(7)".
DEF NEW SHARED VAR n_agent2   AS CHAR FORMAT "x(7)".
-------------*/
DEF NEW SHARED VAR n_agent1   AS CHAR FORMAT "x(10)".
DEF NEW SHARED VAR n_agent2   AS CHAR FORMAT "x(10)".

DEF NEW SHARED VAR n_branch   AS CHAR FORMAT "x(2)".
DEF NEW SHARED VAR n_branch2  AS CHAR FORMAT "x(2)".

Def   Var    n_name           AS Char Format "x(50)".     /*acno name*/
Def   Var    n_chkname        AS Char format "x(1)".        /* Acno-- chk button 1-2 */
Def   Var    n_bdes           AS Char Format "x(50)".     /*branch name*/
Def   Var    n_chkBname       AS Char format "x(1)".        /* branch-- chk button 1-2 */

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

DEF VAR n_chkCopy       AS INTEGER.
DEF VAR n_OutputTo      AS INTEGER.
DEF VAR n_OutputFile    AS Char.

DEF VAR vCliCod         AS CHAR.
DEF VAR vCliCodAll      AS CHAR.
DEF VAR vCountRec       AS INT.

/* --------------------- Define Var use in process ---------------------------*/
DEF VAR n_frbr          AS CHAR FORMAT "x(2)".
DEF VAR n_tobr          AS CHAR FORMAT "x(2)".
/*--- A50-0178
DEF VAR n_frac          AS CHAR FORMAT "x(7)".
DEF VAR n_toac          AS CHAR FORMAT "x(7)".
---------*/
DEF VAR n_frac          AS CHAR FORMAT "x(10)".
DEF VAR n_toac          AS CHAR FORMAT "x(10)".
DEF VAR n_typ           AS CHAR FORMAT "X".
DEF VAR n_typ1          AS CHAR FORMAT "X".
DEF VAR n_day           AS INTE FORMAT ">>9".
DEF VAR n_wcr           AS DECI FORMAT ">>,>>>,>>>,>>9.99-".  /*with in credit*/
DEF VAR n_damt          AS DECI FORMAT ">>,>>>,>>>,>>9.99-".  /*due amount */
DEF VAR n_odue          AS DECI FORMAT ">>,>>>,>>>,>>9.99-".  /*overdue*/

DEF VAR nt_tdat         AS CHAR FORMAT "X(10)".
DEF VAR nt_asdat        AS CHAR FORMAT "X(10)".
DEF VAR n_insur         AS CHAR FORMAT "x(100)".
DEF VAR n_trntyp        AS CHAR FORMAT "x(11)".
DEF VAR n_xtm600        LIKE xtm600.name.
DEF VAR n_acc           LIKE acm001.acno FORMAT "X(10)".
DEF VAR n_add1          LIKE xtm600.addr1.
DEF VAR n_add2          LIKE xtm600.addr2.
DEF VAR n_add3          LIKE xtm600.addr3.
DEF VAR n_add4          LIKE xtm600.addr4.
DEF VAR n_ltamt         LIKE xmm600.ltamt.
DEF VAR n_mocom         LIKE acm001.stamp.
DEF VAR n_prem          LIKE acm001.netamt.
DEF VAR n_gross         LIKE acm001.netamt.
DEF VAR n_comp          AS DECI FORMAT "->>,>>>,>>9.99".

DEF VAR n_year          AS INTE FORMAT ">>9".
DEF VAR n_polyear       AS CHAR FORMAT "X(4)".
DEF VAR n_cedpol        AS CHAR FORMAT "X(16)".
DEF VAR n_opnpol        AS CHAR FORMAT "X(16)".
DEF VAR n_prvpol        AS CHAR FORMAT "X(16)".
DEF VAR n_startdat      AS DATE FORMAT "99/99/9999".
DEF VAR n_duedat        AS DATE FORMAT "99/99/9999".
DEF VAR n_poldes        AS CHAR FORMAT "X(35)".
DEF VAR n_polbrn        AS CHAR FORMAT "X(2)".
DEF VAR n_comdat        AS DATE FORMAT "99/99/9999".
DEF VAR n_expdat        AS DATE FORMAT "99/99/9999".

DEF VAR vCountDay       AS INT.
DEF VAR n_comm          AS DECI FORMAT "->>,>>9.99".
DEF VAR n_comm_comp     AS DECI FORMAT "->>,>>9.99".
DEF VAR n_odue1         AS   DECI   FORMAT ">>,>>>,>>9.99-".  /*overdue 1-3 months*/
DEF VAR n_odue2         AS   DECI   FORMAT ">>,>>>,>>9.99-".  /*overdue 3-6 months*/
DEF VAR n_odue3         AS   DECI   FORMAT ">>,>>>,>>9.99-".  /*overdue 6-9 months*/
DEF VAR n_odue4         AS   DECI   FORMAT ">>,>>>,>>9.99-".  /*overdue 9-12 months*/
DEF VAR n_odue5         AS   DECI   FORMAT ">>,>>>,>>9.99-".  /*overdue over 12 months*/

/* pdprocess2 */
DEF VAR n_day1          AS INT.
DEF VAR n_day2          AS INT.

DEF VAR v_trntyp12      AS CHAR init "".

/*  work table */
/*  DEF  TEMP-TABLE  wacm001
 * /*  DEF  workfile  wacm001*/
 * 
 *               FIELD  acno     LIKE acm001.acno
 *               FIELD  agent     LIKE acm001.agent
 *               FIELD  trndat    LIKE acm001.trndat
 *               FIELD  trnty1     LIKE acm001.trnty1
 *               FIELD  trnty2     LIKE acm001.trnty2
 *               FIELD  docno     LIKE acm001.docno
 *               FIELD  insno     LIKE acm001.insno
 *               FIELD  clicod     LIKE acm001.clicod
 *               FIELD  prem     LIKE acm001.prem
 *               FIELD  comm     LIKE acm001.comm
 *               FIELD  stamp     LIKE acm001.stamp
 *               FIELD  tax     LIKE acm001.tax
 *               FIELD  bal     LIKE acm001.bal
 *               FIELD  policy     LIKE acm001.policy
 *               FIELD  rencnt     LIKE acm001.rencnt
 *               FIELD  endcnt     LIKE acm001.endcnt
 *               FIELD  recno     LIKE acm001.recno
 *               FIELD  poltyp     LIKE acm001.poltyp
 *               FIELD  vehreg    LIKE acm001.vehreg
 *               FIELD  latdat     LIKE acm001.latdat
 *               FIELD  comdat  LIKE acm001.comdat
 *               FIELD  ref     LIKE acm001.ref
 *       INDEX  wacm001 IS UNIQUE PRIMARY acno trndat policy 
 *                                     trnty1 trnty2 docno recno ASCENDING.*/

DEF VAR n_recid      AS RECID.
DEF VAR nv_type      AS CHAR INIT "07".  /* "PROCESS STATEMENT INWARD */
DEF VAR n_chkprocess AS LOG  INIT NO.

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

/**/
DEF VAR n_clicod     AS CHAR.

/*-- Lukkana M. A52-0241 21/10/2009 --*/
DEF VAR n_endcnt       LIKE UWM100.ENDCNT.
DEF VAR n_an           LIKE UWM120.SIGR.
DEF VAR nv_code        LIKE uwm120.sicurr.
DEF VAR nv_sum         LIKE uwm120.sigr INIT 0.
DEF VAR nvexch         LIKE uwm120.siexch.
DEF VAR nvcurr         LIKE uwm120.sicurr.
DEF VAR nv_mbsi        LIKE uwm120.sigr init 0.
DEFINE BUFFER BUWM307  FOR UWM307.
DEFINE BUFFER BUWM120  FOR UWM120.
/*-- Lukkana M. A52-0241 21/10/2009 --*/

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS RECT-408 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME


/* ************************  Function Prototypes ********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fuLeapYear WACR20 
FUNCTION fuLeapYear RETURNS LOGICAL
  ( /* parameter-definitions */ y AS int)  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fuMaxDay WACR20 
FUNCTION fuMaxDay RETURNS INTEGER
  (INPUT vDate AS DATE )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fuNumDay WACR20 
FUNCTION fuNumDay RETURNS INTEGER
  (INPUT vDate AS DATE )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fuNumMonth WACR20 
FUNCTION fuNumMonth RETURNS INTEGER
  (INPUT vMonth AS INT ,vDate AS DATE )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR WACR20 AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE RECTANGLE RECT-408
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 133 BY 1.91
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
     EDGE-PIXELS 3 GRAPHIC-EDGE    
     SIZE 23.5 BY 2.38
     BGCOLOR 4 .

DEFINE RECTANGLE RECT2
     EDGE-PIXELS 3 GRAPHIC-EDGE    
     SIZE 23.5 BY 2.38
     BGCOLOR 1 .

DEFINE BUTTON buAcno1 
     IMAGE-UP FILE "I:/SAFETY/WALP83/WIMAGE\help":U
     LABEL "..." 
     SIZE 3 BY 1 TOOLTIP "รหัส Producer"
     FONT 6.

DEFINE BUTTON buAcno2 
     IMAGE-UP FILE "I:/SAFETY/WALP83/WIMAGE\help":U
     LABEL "..." 
     SIZE 3 BY 1 TOOLTIP "รหัส Producer"
     FONT 6.

DEFINE VARIABLE cbAsMth AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 12
     LIST-ITEMS "Item 1" 
     DROP-DOWN-LIST
     SIZE 17 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiacno1 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiacno2 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiAsDay AS INTEGER FORMAT ">9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 4 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiAsYear AS INTEGER FORMAT "9999":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 6.5 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiCount AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 58 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE finame1 AS CHARACTER FORMAT "X(256)":U 
     LABEL "" 
      VIEW-AS TEXT 
     SIZE 73.5 BY .95
     BGCOLOR 8 FONT 6 NO-UNDO.

DEFINE VARIABLE finame2 AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 73.5 BY .95
     BGCOLOR 8 FONT 6 NO-UNDO.

DEFINE VARIABLE fiProcess AS CHARACTER FORMAT "X(256)":U 
     LABEL "fiProcess" 
      VIEW-AS TEXT 
     SIZE 109.5 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fiProcessDate AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 20.5 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE RECTANGLE reAsdate
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 119 BY 4.24
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-88
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 119 BY 1.76
     BGCOLOR 8 .

DEFINE RECTANGLE RECT11
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 119 BY 4.76
     BGCOLOR 8 .

DEFINE VARIABLE cbFrMth AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 12
     LIST-ITEMS "Item 1" 
     DROP-DOWN-LIST
     SIZE 17 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE cbToMth AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 12
     LIST-ITEMS "Item 1" 
     DROP-DOWN-LIST
     SIZE 17 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiFrDay AS INTEGER FORMAT ">9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 4 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiFrYear AS INTEGER FORMAT "9999":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 6.5 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiToDay AS INTEGER FORMAT ">9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 4 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiToYear AS INTEGER FORMAT "9999":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 6.5 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-409
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 87 BY 4.76
     BGCOLOR 8 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     "  PROCESS STATEMENT INWARD":120 VIEW-AS TEXT
          SIZE 45.5 BY .95 AT ROW 1.48 COL 43.67
          BGCOLOR 3 FGCOLOR 7 FONT 23
     RECT-408 AT ROW 1 COL 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 22
         BGCOLOR 19 .

DEFINE FRAME frMain
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         NO-LABELS SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 2.33 ROW 3.24
         SIZE 130.5 BY 19.19
         BGCOLOR 3 .

DEFINE FRAME frST
     fiacno1 AT ROW 3.14 COL 26.33 COLON-ALIGNED NO-LABEL
     buAcno1 AT ROW 3.19 COL 43.5
     fiacno2 AT ROW 4.33 COL 26.33 COLON-ALIGNED NO-LABEL
     buAcno2 AT ROW 4.43 COL 43.5
     fiAsDay AT ROW 7.48 COL 26 COLON-ALIGNED NO-LABEL
     cbAsMth AT ROW 7.48 COL 30.17 COLON-ALIGNED NO-LABEL
     fiAsYear AT ROW 7.48 COL 47.17 COLON-ALIGNED NO-LABEL
     fiCount AT ROW 7.48 COL 55 COLON-ALIGNED NO-LABEL
     fiProcessDate AT ROW 9.05 COL 26 COLON-ALIGNED NO-LABEL
     finame1 AT ROW 3.24 COL 48 COLON-ALIGNED
     finame2 AT ROW 4.33 COL 48 COLON-ALIGNED NO-LABEL
     fiProcess AT ROW 11.52 COL 11
     "                       TO :":40 VIEW-AS TEXT
          SIZE 21.5 BY 1 TOOLTIP "รหัสตัวแทนเริ่มตั้งแต่" AT ROW 4.43 COL 6.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "                   FROM :":40 VIEW-AS TEXT
          SIZE 21.5 BY 1 TOOLTIP "รหัสตัวแทนเริ่มตั้งแต่" AT ROW 3.14 COL 6.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "          AS OF DATE :":30 VIEW-AS TEXT
          SIZE 21.5 BY 1 AT ROW 7.48 COL 6.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "  PRODUCER  CODE":40 VIEW-AS TEXT
          SIZE 118.17 BY 1 TOOLTIP "รหัสตัวแทน" AT ROW 1.62 COL 6.33
          BGCOLOR 1 FGCOLOR 7 FONT 6
     "    PROCESS DATE :":30 VIEW-AS TEXT
          SIZE 21.5 BY 1 TOOLTIP "วันที่ออกรายงาน" AT ROW 9.1 COL 6.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     reAsdate AT ROW 6.67 COL 6
     RECT-88 AT ROW 11.14 COL 6
     RECT11 AT ROW 1.48 COL 6
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         NO-LABELS SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 2.67 ROW 1.48
         SIZE 127 BY 12.38
         BGCOLOR 19 .

DEFINE FRAME frTranDate
     fiFrDay AT ROW 3 COL 26 COLON-ALIGNED NO-LABEL
     cbFrMth AT ROW 3 COL 30.17 COLON-ALIGNED NO-LABEL
     fiFrYear AT ROW 3 COL 47.5 COLON-ALIGNED NO-LABEL
     fiToDay AT ROW 4.43 COL 26 COLON-ALIGNED NO-LABEL
     cbToMth AT ROW 4.43 COL 30.17 COLON-ALIGNED NO-LABEL
     fiToYear AT ROW 4.43 COL 47.5 COLON-ALIGNED NO-LABEL
     "FROM :":10 VIEW-AS TEXT
          SIZE 8.17 BY .95 TOOLTIP "ตั้งแต่" AT ROW 3.05 COL 19.17
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "TO :":5 VIEW-AS TEXT
          SIZE 5.5 BY .95 TOOLTIP "ถึง" AT ROW 4.48 COL 21.83
          BGCOLOR 8 FGCOLOR 1 FONT 6
     " TRANSACTION  DATE":40 VIEW-AS TEXT
          SIZE 86 BY 1 TOOLTIP "วันที่ทำกรมธรรม์" AT ROW 1.52 COL 7
          BGCOLOR 1 FGCOLOR 7 FONT 6
     RECT-409 AT ROW 1.33 COL 6.5
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 3 ROW 14.19
         SIZE 98.5 BY 5.38
         BGCOLOR 19 .

DEFINE FRAME frOK
     Btn_OK AT ROW 1.81 COL 6.33
     Btn_Cancel AT ROW 4.14 COL 6.33
     RECT-3 AT ROW 3.62 COL 2.5
     RECT2 AT ROW 1.24 COL 2.5
    WITH DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 103.17 ROW 14.19
         SIZE 26.5 BY 5.38
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
  CREATE WINDOW WACR20 ASSIGN
         HIDDEN             = YES
         TITLE              = "wacr20 - PROCESS STATEMENT INWARD"
         HEIGHT             = 22
         WIDTH              = 133
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
IF NOT WACR20:LOAD-ICON("wimage/safety.ico":U) THEN
    MESSAGE "Unable to load icon: wimage/safety.ico"
            VIEW-AS ALERT-BOX WARNING BUTTONS OK.
&ENDIF
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW WACR20
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

DEFINE VARIABLE XXTABVALXX AS LOGICAL NO-UNDO.

ASSIGN XXTABVALXX = FRAME frTranDate:MOVE-BEFORE-TAB-ITEM (FRAME frOK:HANDLE)
       XXTABVALXX = FRAME frST:MOVE-BEFORE-TAB-ITEM (FRAME frTranDate:HANDLE)
/* END-ASSIGN-TABS */.

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
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(WACR20)
THEN WACR20:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME WACR20
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL WACR20 WACR20
ON END-ERROR OF WACR20 /* wacr20 - PROCESS STATEMENT INWARD */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL WACR20 WACR20
ON WINDOW-CLOSE OF WACR20 /* wacr20 - PROCESS STATEMENT INWARD */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frOK
&Scoped-define SELF-NAME Btn_Cancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_Cancel WACR20
ON CHOOSE OF Btn_Cancel IN FRAME frOK /* CANCEL */
DO:
    APPLY "CLOSE" TO THIS-PROCEDURE.
    RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_OK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_OK WACR20
ON CHOOSE OF Btn_OK IN FRAME frOK /* OK */
DO:
   DEF VAR vAcno       AS CHAR INIT "".
   DEF VAR vFirstTime  AS CHAR INIT "".
   DEF VAR vLastTime   AS CHAR INIT "".

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
   If  n_frac = "" Then  n_frac = "0D00000".     
   If  n_toac = "" Then  n_toac = "0FZZZZZ".  
   ------*/
   If  n_frac = "" Then  n_frac = "0D00000".      /*A51-0124*/
   If  n_toac = "" Then  n_toac = "0FZZZZZZZZ".               


/* A47-0261 */
/*    IF ( n_frac > n_toac)   THEN DO:                                             */
/*          Message "ข้อมูลตัวแทนผิดพลาด" SKIP                                     */
/*          "รหัสตัวแทนเริ่มต้นต้องมากกว่ารหัสสุดท้าย" VIEW-AS ALERT-BOX WARNING . */
/*          Apply "Entry" To fiacno1  .                                            */
/*          Return No-Apply.                                                       */
/*    END.                                                                         */
/*                                                                                 */
/*    IF ( n_frdate > n_todate) OR n_frdate  = ? OR n_todate = ?   THEN DO:        */
/*          Message "ข้อมูลวันที่ทำกรมธรรม์ผิดพลาด" SKIP                           */
/*          "วันที่เริ่มต้นต้องมากกว่าวันที่สุดท้าย" VIEW-AS ALERT-BOX WARNING .   */
/*          Apply "Entry" To  fiFrDay .                                            */
/*          Return No-Apply.                                                       */
/*    END.                                                                         */

   MESSAGE "ทำการประมวลผลข้อมูล ! " SKIP (1)
           "ตัวแทน/นายหน้า        : " n_frac     " ถึง " n_toac     SKIP (1)
           "วันที่ออกรายงาน       : " STRING(n_asdat,"99/99/9999")  SKIP (1)
           "กรมธรรม์ตั้งแต่วันที่ : " STRING(n_frdate,"99/99/9999") " ถึง " STRING(n_todate,"99/99/9999") SKIP (1)
           "Type                  : " nv_Type + " - " + "PROCESS STATEMENT INWARD"
   VIEW-AS ALERT-BOX QUESTION  BUTTONS YES-NO
   UPDATE CHOICE AS LOGICAL.
   CASE CHOICE:
       WHEN TRUE THEN DO:

            DOS SILENT DEL VALUE(nv_file-name)  .   /* delete  file exports */
            RUN pdChkProcess01.  /* ตรวจสอบว่า เคยมีการ process ใน type  07 ไหม  ถ้าซ้ำ  จะไม่ process ให้ */
            
            IF n_chkprocess = YES THEN DO:
                vFirstTime =  STRING(TODAY,"99/99/9999") + STRING(TIME, "HH:MM AM") + " " + STRING(ETIME).
                    RUN pdProcess.
                    RUN pdProcessYes.        /* ถ้า process เสร็จให้ Process complete = YES  elapsed*/
                vLastTime  =  STRING(TODAY,"99/99/9999") + STRING(TIME, "HH:MM AM") + " " + STRING(ETIME).
               
                /* kan. 08/07/2002---*/
                fiCount = fiCount + "  N = " + STRING(vCountRec).
                DISP fiCount WITH FRAME frST.
                /*--- kan.*/
               
                MESSAGE "วันที่ออกรายงาน : " STRING(n_asdat,"99/99/9999")   SKIP (1)
                        "ตัวแทน              : "  n_frac " ถึง " n_toac     SKIP (1)
                        "ประมวลผลพบข้อมูลทั้งสิ้น  " vCountRec   " รายการ"  SKIP (1)
                        "เวลา  " SUBSTRING(vFirstTime,1,18) "  -  " 
                                 SUBSTRING(vLastTime ,1,18) " น."
                VIEW-AS ALERT-BOX INFORMATION.
            END.
            ELSE DO:
                MESSAGE "ไม่สามารถ Process ได้ เนื่องจาก"  SKIP (1)
                        "มีการ Process ใน As date นี้แล้ว"  /*n_chkprocess*/  VIEW-AS ALERT-BOX ERROR.
                RETURN NO-APPLY.
            END. /*  n_chkprocess = yes*/
        END.
        WHEN FALSE THEN DO:
            RETURN NO-APPLY.
        END.
    END CASE.

    OUTPUT TO VALUE (STRING(nv_File-Name)  ) APPEND NO-ECHO.
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
           fiacno1  = "0D00000"
           fiacno2  = "BZZZZZZ"
           cbAsMth:List-Items = cv_mthlistE
           fiAsDay  = DAY(TODAY)
           cbAsMth  = ENTRY(MONTH (TODAY), cv_mthlistE) 
           fiAsYear = YEAR(TODAY)
           fiProcessDate = TODAY.
        DISPLAY fiacno1 fiacno2 fiAsDay cbAsMth fiAsYear fiProcessDate.
    END.

/* ประมวลผลเสร็จออกจากโปรแกรมทันที*/
    MESSAGE "ประมวลผลเรียบร้อย"  VIEW-AS ALERT-BOX INFORMATION.
    APPLY "CHOOSE" TO btn_cancel.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frST
&Scoped-define SELF-NAME buAcno1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buAcno1 WACR20
ON CHOOSE OF buAcno1 IN FRAME frST /* ... */
DO:
  n_chkname = "1". 
  RUN Whp\WhpAcno(INPUT-OUTPUT  n_name,INPUT-OUTPUT  n_chkname).
  
  ASSIGN    
        fiacno1 = n_agent1
        finame1 = n_name.
       
  DISP fiacno1 finame1  WITH FRAME {&FRAME-NAME}.

  n_agent1 = fiacno1 .

  RETURN NO-APPLY.
 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buAcno2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buAcno2 WACR20
ON CHOOSE OF buAcno2 IN FRAME frST /* ... */
DO:
  n_chkname = "2". 
  RUN Whp\WhpAcno(INPUT-OUTPUT  n_name,INPUT-OUTPUT  n_chkname).
  
  ASSIGN    
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
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cbToMth WACR20
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
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiacno1 WACR20
ON LEAVE OF fiacno1 IN FRAME frST
DO:
    ASSIGN
        fiacno1  = INPUT fiacno1
        n_agent1 = fiacno1.
    
    DISP CAPS(fiacno1) @ fiacno1 WITH FRAME frST.
        
    IF INPUT FiAcno1 <> "" Then Do :        
        FIND xmm600 WHERE xmm600.acno = n_agent1  NO-ERROR.
        IF AVAILABLE xmm600 THEN DO:
            finame1:Screen-value IN FRAME {&FRAME-NAME} = xmm600.name.
        END.        
        ELSE DO:
            fiAcno1 = "".
            finame1:Screen-value IN FRAME {&FRAME-NAME} = "Not Found !".
            MESSAGE "ไม่พบข้อมูล" VIEW-AS ALERT-BOX  WARNING TITLE "Confirm" .
        END.
    END.
    DISP CAPS (fiAcno1) @ fiAcno1 WITH FRAME frST.
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiacno1 WACR20
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
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiacno2 WACR20
ON LEAVE OF fiacno2 IN FRAME frST
DO:
    ASSIGN
        fiacno2  = INPUT fiacno2
        n_agent2 = fiacno2.

    DISP CAPS(fiacno2) @ fiacno2 WITH FRAME frST.
            
    IF INPUT  FiAcno2 <> "" THEN DO:
        FIND   xmm600 WHERE xmm600.acno = n_agent2  NO-ERROR.
        IF AVAILABLE xmm600 THEN DO:
              finame2:SCREEN-VALUE IN FRAME {&FRAME-NAME} = xmm600.name.
        END.        
        ELSE DO:
              fiAcno2 = "".
              finame2:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "Not Found !".
              MESSAGE "ไม่พบข้อมูล" VIEW-AS ALERT-BOX  WARNING TITLE "Confirm" .
        END.
    END.
    DISP CAPS (fiAcno2) @ fiAcno2 WITH FRAME frST.
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiacno2 WACR20
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
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiAsDay WACR20
ON LEAVE OF fiAsDay IN FRAME frST
DO:
  ASSIGN fiAsDay.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frTranDate
&Scoped-define SELF-NAME fiFrDay
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiFrDay WACR20
ON LEAVE OF fiFrDay IN FRAME frTranDate
DO:
  ASSIGN fiFrDay.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiToDay
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiToDay WACR20
ON LEAVE OF fiToDay IN FRAME frTranDate
DO:
  ASSIGN fiToDay.
  
     fiToDay  = INPUT fiToDay.
   DISP fiToDay WITH FRAME frTranDate.
   
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiToYear
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiToYear WACR20
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK WACR20 


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
  
  gv_prgid = "WACR20".
  gv_prog  = "PROCESS STATEMENT INWARD".

  RUN  WUT\WUTHEAD (WACR20:handle,gv_prgid,gv_prog).
/*********************************************************************/  
  RUN WUT\WUTWICEN (WACR20:HANDLE).

  CURRENT-WINDOW:WINDOW-STATE = WINDOW-MAXIMIZED.  
/*    RUN Wut\Wutwicen.p (C-Win:HANDLE).*/
  
  SESSION:DATA-ENTRY-RETURN = YES.
  APPLY "ENTRY" TO fiToDay.

  DISABLE ALL EXCEPT fiAsDay cbAsMth fiAsYear WITH FRAME frST.

    DO WITH FRAME frST:
        /*reProducer:MOVE-TO-TOP() .   */ 
       ASSIGN   
/*            fiacno1 = "0D00000" */
/*            fiacno2 = "0FZZZZZ" */
           fiacno1 = "0D00000"
           fiacno2 = "0FZZZZZZZZ" 
           cbAsMth:List-Items = cv_mthlistE
/*            fiAsDay  =  DAY(TODAY)  /*fuNumDay(TODAY) */ */
           fiAsDAy = DAY(DATE(MONTH(TODAY),1,YEAR(TODAY)) - 1)
           
           cbAsMth = IF MONTH(TODAY) = 1 THEN ENTRY (12 , cv_mthlistE)
                     ELSE ENTRY( (MONTH (TODAY)) - 1 , cv_mthlistE)
                     
           fiAsYear = YEAR(DATE(MONTH(TODAY),1,YEAR(TODAY)) - 1)
           
/* kan--- 04/11/2002*/
           fiProcessDate = TODAY.
/* ---kan*/

        DISPLAY fiacno1  fiacno2  fiAsDay  cbAsMth 
                fiAsYear fiProcessDate.
    END.    
      
    DO WITH FRAME frTranDate:
        ASSIGN  
            cbFrMth:List-Items = cv_mthlistE 
            cbToMth:List-Items = cv_mthlistE 
            fiFrDay  = 1
            fiToDay  = DAY (TODAY)  
            cbFrMth  = ENTRY(1, cv_mthlistE)
            cbToMth  = ENTRY(MONTH (TODAY), cv_mthlistE)
            fiFrYear = 1988
            fiToYear = YEAR (TODAY).

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI WACR20  _DEFAULT-DISABLE
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
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(WACR20)
  THEN DELETE WIDGET WACR20.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI WACR20  _DEFAULT-ENABLE
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
  ENABLE RECT-408 
      WITH FRAME DEFAULT-FRAME IN WINDOW WACR20.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  DISPLAY fiacno1 fiacno2 fiAsDay cbAsMth fiAsYear fiCount fiProcessDate finame1 
          finame2 fiProcess 
      WITH FRAME frST IN WINDOW WACR20.
  ENABLE reAsdate RECT-88 RECT11 fiacno1 buAcno1 fiacno2 buAcno2 fiAsDay 
         cbAsMth fiAsYear fiCount fiProcessDate finame1 finame2 fiProcess 
      WITH FRAME frST IN WINDOW WACR20.
  {&OPEN-BROWSERS-IN-QUERY-frST}
  VIEW FRAME frMain IN WINDOW WACR20.
  {&OPEN-BROWSERS-IN-QUERY-frMain}
  DISPLAY fiFrDay cbFrMth fiFrYear fiToDay cbToMth fiToYear 
      WITH FRAME frTranDate IN WINDOW WACR20.
  ENABLE RECT-409 fiFrDay cbFrMth fiFrYear fiToDay cbToMth fiToYear 
      WITH FRAME frTranDate IN WINDOW WACR20.
  {&OPEN-BROWSERS-IN-QUERY-frTranDate}
  ENABLE RECT-3 RECT2 Btn_OK Btn_Cancel 
      WITH FRAME frOK IN WINDOW WACR20.
  {&OPEN-BROWSERS-IN-QUERY-frOK}
  VIEW WACR20.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdcan WACR20 
PROCEDURE pdcan :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*due จาก โปรแกรม uzscan.i เพื่อทำการคำนวณค่า sum insure Lukkana M. A52-0241 30/10/2009*/

IF uwm100.poltyp = "M60" OR uwm100.poltyp = "M61"  OR  uwm100.poltyp = "M62" OR
   uwm100.poltyp = "M63" OR uwm100.poltyp = "M64"  OR  uwm100.poltyp = "M67" OR
   uwm100.poltyp = "M68" 
THEN  DO:
  FOR EACH uwm307 USE-INDEX uwm30701 WHERE uwm307.policy = uwm100.policy AND 
                                           uwm307.rencnt = uwm100.rencnt AND 
                                           uwm307.endcnt = uwm100.endcnt
                                           NO-LOCK .

        IF AVAIL uwm307 THEN  DO:
             nv_sum  = nv_sum  + uwm307.mbsi[1].

        END.
  END.
END .
ELSE DO:

  FOR EACH uwm120 USE-INDEX uwm12001 WHERE uwm120.policy = uwm100.policy AND 
                                           uwm120.rencnt = uwm100.rencnt AND 
                                           uwm120.endcnt = uwm100.endcnt
                                           NO-LOCK .

     IF AVAIL uwm120 THEN  DO:
        nv_sum  = nv_sum + (uwm120.sigr - uwm120.sico).
     END.

  END.

END.
  nv_sum = nv_sum * -1.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdChkProcess01 WACR20 
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

/*     FIND LAST  acProc_fil  USE-INDEX by_type_asdat  WHERE                */
/*               (acProc_fil.asdat = n_asdat AND acProc_fil.type = "05") OR */
/*               (acProc_fil.asdat = n_asdat AND                            */
/*                acProc_fil.type = "01"     AND                            */
/*      SUBSTRING(acProc_fil.enttim,10,3)  = "YES") NO-ERROR.               */
    
    FIND LAST  acProc_fil  USE-INDEX by_type_asdat  WHERE
               acProc_fil.asdat = n_asdat  AND
               acProc_fil.type  = "07"     AND
     SUBSTRING(acProc_fil.enttim,10,3)  = "YES"  NO-ERROR.
    IF AVAIL acProc_fil THEN DO:
        n_chkprocess = NO.  /* พบใน 07 แล้ว process complete = "YES" */
    END.
    ELSE DO:
        n_chkprocess = YES.  /* ไม่พบ ใน  07  สามารถ process ได้*/
    END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdChkProcess05 WACR20 
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


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdCreate WACR20 
PROCEDURE pdCreate :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
    DEF OUTPUT PARAMETER  n_recid AS RECID.

    DO TRANSACTION :
        CREATE agtprm_fil .
    END.
    
    n_recid = RECID(agtprm_fil).

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdDel01 WACR20 
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
           
    ACCUM  1 (COUNT).
    
    DISP  "DELETE : " + STRING(agtprm_fil.asdat) + " " + 
            agtprm_fil.acno + "  " + agtprm_fil.policy + "  " + agtprm_fil.trntyp + "  " +
            agtprm_fil.docno + " " + STRING(agtprm_fil.trndat)   @ fiProcess  WITH FRAME  frST .

    DELETE agtprm_fil.
    
END.
/*--- kan.*/

fiCount = "O = " +  STRING(ACCUM count 1 ) .
DISP fiCount WITH FRAME frST.

FIND LAST  acProc_fil  USE-INDEX by_type_asdat  WHERE
           acProc_fil.type  = "07"    AND
           acProc_fil.asdat = n_asdat NO-ERROR.
    IF NOT AVAIL acProc_fil THEN DO:
        CREATE acProc_fil.
        ASSIGN
            acProc_fil.type     = "07"
            acProc_fil.typdesc  = "PROCESS STATEMENT INWARD"
            acProc_fil.asdat    = n_asdat
            acProc_fil.trndatfr = n_frdate
            acProc_fil.trndatto = n_todate
            acProc_fil.entdat   = TODAY
            acProc_fil.enttim   = STRING (TIME, "HH:MM:SS") + ":NO"
            acProc_fil.usrid    = n_user.
    END.
    IF AVAIL acProc_fil THEN DO:
        ASSIGN
            acProc_fil.type     = "07"
            acProc_fil.typdesc  = "PROCESS STATEMENT INWARD"
            acProc_fil.asdat    = n_asdat
            acProc_fil.trndatfr = n_frdate
            acProc_fil.trndatto = n_todate
            acProc_fil.entdat   = TODAY
            acProc_fil.enttim   = STRING (TIME, "HH:MM:SS") + ":NO"
            acProc_fil.usrid    = n_user.
    END. 

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdDel05 WACR20 
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
        acProc_fil.typdesc = "PROCESS PREMIUM STATEMENT (A4) EVERY DAY"
        acProc_fil.asdat   = n_asdat
        acProc_fil.trndatfr = n_frdate
        acProc_fil.trndatto = n_todate
        acProc_fil.entdat = TODAY
        acProc_fil.enttim = STRING (TIME, "HH:MM:SS") + ":NO"
        acProc_fil.usrid   = n_user.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdProcess WACR20 
PROCEDURE pdProcess :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

DEF VAR n_type  AS CHAR FORMAT "X(2)".
DEF VAR n_mocom AS DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR n_premres   AS DECI FORMAT "->>,>>>,>>>,>>9.99". /*Lukkana M. A52-0241 21/10/2009*/

ASSIGN
    vCountRec = 0
    n_type    = nv_type.

RUN pdDel01.  /* "07" Delete agtprm_fil  &  Create acproc_fil */

loop_acm001:
FOR EACH  acm001 USE-INDEX acm00103  NO-LOCK WHERE
          acm001.acno    >=  n_frac   AND
          acm001.acno    <=  n_toac   AND
          acm001.curcod   =  "BHT"    AND
          acm001.trndat  >=  n_frdate AND
          acm001.trndat  <=  n_todate AND
         (acm001.trnty1   =  "O" OR
          acm001.trnty1   =  "T" )    AND
   SUBSTR(acm001.policy,1,1) = "I"    AND
         (acm001.bal     <>  0   OR
         (acm001.bal      =  0   AND acm001.latdat   >  n_asdat) ) 
    :

    IF ( YEAR(acm001.latdat) > 2999 ) AND (acm001.bal = 0)  THEN NEXT  loop_acm001.

    DISP  "PROCESS : " + acm001.acno + "  " + acm001.policy + "  " + acm001.trnty1 + "  " +
                         acm001.trnty2 + "  " + acm001.docno FORMAT "X(10)" /* Benjaporn J. A60-0267 date 27/06/2017 */
          @ fiProcess  WITH FRAME  frST.

    ASSIGN
       
        n_insur   =  ""     n_clicod  =  ""
        nt_tdat   =  ""     nt_asdat  =  ""     
        n_polbrn  =  ""     n_cedpol  =  ""  
        n_comdat  =  ?      n_expdat  =  ? 
        n_prem    =  0      n_comp    =  0 
        n_premres =  0  . /*Lukkana M. A52-0241 21/10/2009*/

    /* check company is reinsurance only */
    FIND  xmm600 USE-INDEX xmm60001 WHERE
          xmm600.acno = acm001.acno NO-LOCK NO-ERROR.
    IF NOT AVAIL xmm600 THEN NEXT loop_acm001.

/*     IF xmm600.clicod <> "RA" AND                    */
/*        xmm600.clicod <> "RB" AND                    */
/*        xmm600.clicod <> "RD" AND                    */
/*        xmm600.clicod <> "RF" THEN NEXT loop_acm001. */

   /*------A50-0218------*/ 
   /* keep reinsurance's name & address */  
    FIND xtm600 USE-INDEX xtm60001 WHERE
         xtm600.acno = xmm600.acno NO-LOCK NO-ERROR.
    IF AVAIL xtm600  THEN DO:
       n_xtm600  =  TRIM(xtm600.ntitle + " " + xtm600.name).
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
         n_xtm600  =  TRIM(xmm600.ntitle + " " + xmm600.name)
         n_add1  = xmm600.addr1
         n_add2 = xmm600.addr2
         n_add3 = xmm600.addr3
         n_add4 = xmm600.addr4.
        /*------------A50-0218-------------*/

    ASSIGN
        n_clicod   = xmm600.clicod
        n_polbrn   = SUBSTR(acm001.policy,2,1)
        v_trntyp12 = TRIM(acm001.trnty1) + TRIM(acm001.trnty2) .
    
    /*Lukkana M. A52-0241 21/10/2009*/
    IF SUBSTR(acm001.acno,2,1) = "D" THEN
        n_premres = 0.
    ELSE DO:
        IF SUBSTR(acm001.policy,3,2) <> "90" THEN
             n_premres = (-1) * (TRUNC(acm001.prem * (0.4) ,0)) .
        ELSE n_premres = 0.
    END.
    /*--- END A48-0113 ---*/

    IF (acm001.trnty1 = "Y" OR acm001.trnty1 = "Z") THEN 
        ASSIGN 
            n_premres = 0.
    /*Lukkana M. A52-0241 21/10/2009*/


    FIND FIRST uwm100 WHERE
               uwm100.policy = acm001.policy AND
               uwm100.endno  = acm001.recno  NO-LOCK NO-ERROR.
    IF AVAIL uwm100 THEN DO:
        ASSIGN
            n_cedpol = uwm100.cedpol
            n_comdat = uwm100.comdat
            n_expdat = uwm100.expdat             
            n_insur  = TRIM(uwm100.name1) + TRIM(uwm100.name2) .

        IF SUBSTR(uwm100.policy,3,2) = "70" THEN DO:
            FOR EACH uwd132 WHERE
                     uwd132.policy = uwm100.policy AND
                     uwd132.rencnt = uwm100.rencnt AND
                     uwd132.endcnt = uwm100.endcnt NO-LOCK:
                IF uwd132.bencod = "COMP"  OR
                   uwd132.bencod = "COMG"  OR
                   uwd132.bencod = "COMH"  THEN
                    n_comp = n_comp + uwd132.prem_c.
            END.    /* end uwd132 */
            n_prem = acm001.prem - n_comp.
        END.    /* end line 70 */
        ELSE  ASSIGN
                n_prem = acm001.prem
                n_comp = 0.

        /***************Lukkana M. A52-0241 30/10/2009*******************/
        n_an     = 0.
        nv_sum   = 0.
        nv_code  = "ERR".
        nvexch   = 1.

        FIND FIRST uwm120 USE-INDEX uwm12001 WHERE uwm120.policy = uwm100.policy
                                             AND   uwm120.rencnt = uwm100.rencnt
                                             AND   uwm120.endcnt = uwm100.endcnt
                                             NO-LOCK NO-ERROR.
        IF AVAIL uwm120 THEN DO:
            nvcurr    = uwm120.sicurr.
            IF  SUBSTRING(uwm120.policy,3,2) = "90" THEN nvexch = 1.
            ELSE  nvexch = uwm120.siexch.
        END.

        N_ENDCNT =  uwm100.endcnt - 1.
    
        IF UWM100.TRANTY <> "C" THEN DO:
            RUN pdsi120.
        END.
        ELSE DO:
            RUN pdcan.
        END.
        
        IF   NVCURR <> "BHT"  THEN DO:
             n_an =  round(nvexch * nv_sum,2).
        END.
        ELSE DO:
             n_an =  nv_sum.
        END.
        nv_sum  =  n_an.
        /**************Lukkana M. A52-0241 30/10/2009********************/
    END.    /* end if avail uwm100 */
    ELSE
        ASSIGN
            n_insur  = acm001.ref
            n_comdat = acm001.comdat
            n_prem   = acm001.prem
            n_comp   = 0 .

    IF (acm001.trnty1 = "Y" OR acm001.trnty1 = "Z") THEN
        ASSIGN
            n_prem = 0
            n_comp = 0.

    FIND  FIRST agtprm_fil USE-INDEX by_trndat_acno   WHERE
                agtprm_fil.trndat = acm001.trndat   AND
                agtprm_fil.acno   = acm001.acno     AND
                agtprm_fil.poltyp = acm001.poltyp   AND
                agtprm_fil.policy = acm001.policy   AND
                agtprm_fil.endno  = acm001.recno    AND
                agtprm_fil.trntyp = v_trntyp12      AND
                agtprm_fil.docno  = acm001.docno    AND
                agtprm_fil.asdat  = n_asdat
    NO-LOCK NO-ERROR.
    IF NOT AVAIL agtprm_fil THEN DO:

       RUN pdCreate (OUTPUT n_recid). /* Create Transaction*/  

       FIND agtprm_fil WHERE RECID(agtprm_fil) = n_recid NO-ERROR .
       IF AVAIL agtprm_fil  THEN DO:
          ASSIGN
             agtprm_fil.asdat    =  n_asdat
             agtprm_fil.acno     =  acm001.acno
             agtprm_fil.poltyp   =  acm001.poltyp
             agtprm_fil.polbran  =  n_polbrn
             agtprm_fil.policy   =  acm001.policy
             agtprm_fil.endno    =  acm001.recno
             agtprm_fil.cedpol   =  n_cedpol
             agtprm_fil.insur    =  n_insur

/*              agtprm_fil.polyear =  n_polyear */
/*              agtprm_fil.polyear =  n_polyear */
/*              agtprm_fil.cedpol =  n_cedpol   */

             agtprm_fil.prem       =  n_prem
             agtprm_fil.prem_comp  =  n_comp
             agtprm_fil.tax        =  acm001.tax
             agtprm_fil.stamp      =  acm001.stamp
             agtprm_fil.gross      =  acm001.netamt
             agtprm_fil.comm       =  acm001.comm
             agtprm_fil.bal        =  acm001.bal
             agtprm_fil.comm_comp  =  n_an
             agtprm_fil.odue       =  n_premres              /* Premium Reserve Lukkana M. A52-0241 21/10/2009*/

/*              agtprm_fil.comm_comp  =  n_comm_comp */
/*              agtprm_fil.credit =  n_day */
/*              agtprm_fil.trntyp =  n_trntyp */
/*              agtprm_fil.prem    =  acm001.netamt */

             agtprm_fil.trndat  =  acm001.trndat
             agtprm_fil.trntyp  =  TRIM(acm001.trnty1) + TRIM(acm001.trnty2)
             agtprm_fil.docno   =  acm001.docno
             agtprm_fil.acno_clicod  =  n_clicod

/*              agtprm_fil.vehreg =  acm001.vehreg     */
/*              agtprm_fil.opnpol =  n_opnpol          */
/*              agtprm_fil.prvpol  =  n_prvpol         */
/*              agtprm_fil.wcr    = n_wcr              */
/*              agtprm_fil.damt = n_damt  /* 3 ช่อง */ */
/*              agtprm_fil.odue = n_odue  /* 3 ช่อง*/  */

             
             agtprm_fil.addr1    =  n_add1
             agtprm_fil.addr2    =  n_add2
             agtprm_fil.addr3    =  n_add3
             agtprm_fil.addr4    =  n_add4
             agtprm_fil.ac_name  =  n_xtm600

/*              agtprm_fil.odue1 = n_odue1                                                                                          */
/*              agtprm_fil.odue2 = n_odue2                                                                                          */
/*              agtprm_fil.odue3 = n_odue3                                                                                          */
/*              agtprm_fil.odue4 = n_odue4                                                                                          */
/*              agtprm_fil.odue5 = n_odue5                                                                                          */
/*              agtprm_fil.odue6 = n_ltamt   /* credit Limit*/                                                                      */
/*              agtprm_fil.startdat = n_startdat                                                                                    */
/*              agtprm_fil.comdat = n_comdat                                                                                        */
/*              agtprm_fil.duedat  = IF LOOKUP(n_trntyp,nv_YZCB) = 0 THEN n_duedat ELSE acm001.trndat  /*A46-0142  acm001.trndat */ */

             agtprm_fil.latdat   =  acm001.latdat
             agtprm_fil.startdat =  acm001.entdat
             agtprm_fil.duedat   =  n_expdat
/*              agtprm_fil.poldes   =  n_poldes */
             agtprm_fil.TYPE     =  n_type
             agtprm_fil.comdat   =  n_comdat
             .

       END. /* IF AVAIL agtprm_fil */

    END. /* IF NOT AVAIL agtprm_fil */

    ASSIGN
       nt_tdat   = STRING(n_todate,"99/99/9999")
       nt_asdat  = STRING(n_asdat,"99/99/9999")
       vCountRec = vCountRec + 1 .
       
    RELEASE agtprm_fil.  /*release acm001.*/

END.  /*acm001*/


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdProcessYes WACR20 
PROCEDURE pdProcessYes :
/*------------------------------------------------------------------------------
  Purpose:     ถ้า process เสร็จให้ Process complete = YES
  Parameters:  <none>  
  Notes:       
------------------------------------------------------------------------------*/

    FIND LAST  acProc_fil  USE-INDEX by_type_asdat  WHERE
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdProcess_acno WACR20 
PROCEDURE pdProcess_acno :
DEF VAR n_startdat  AS DATE FORMAT "99/99/9999".
DEF VAR n_duedat    AS DATE FORMAT "99/99/9999".
DEF VAR n_sdmonth   AS INT. /*start date*/
DEF VAR n_sdyear    AS INT.
/* หาวันที่เริ่มต้น  ต้องเป็นวันที่วันสุดท้ายของเดือนนั้น ๆ*/
DEF VAR vYear       AS INT.
DEF VAR vMonth      AS INT.
DEF VAR vDay        AS INT.
DEF VAR vdueDAY     AS INT.
DEF VAR vdueMONTH   AS INT.
DEF VAR vdueYEAR    AS INT.
DEF VAR vcrperMod   AS INT.
DEF VAR vcrperTrun  AS INT.
DEF VAR vcrperRound AS INT.
/**/
DEF VAR n_odmonth1 AS INT. /*month  not over  12   เดือนที่  เพื่อนำไปหาจำนวนวันในแต่ละเดือน */
DEF VAR n_odmonth2 AS INT.
DEF VAR n_odmonth3 AS INT.
DEF VAR n_odmonth4 AS INT.
DEF VAR n_odDay1   AS INT. /*count num day in over due 1 - 3   จำนวนวัน ที่เกิน ระยะเวลาให้ credit  3 เดือน */
DEF VAR n_odDay2   AS INT.
DEF VAR n_odDay3   AS INT.
DEF VAR n_odDay4   AS INT.

DEF VAR n_odat1 AS  DATE FORMAT "99/99/9999". /* วันที่ ที่เกินจากระยะเวลาให้ credit  เกินไป 3 เดือน*/
DEF VAR n_odat2 AS  DATE FORMAT "99/99/9999".
DEF VAR n_odat3 AS  DATE FORMAT "99/99/9999".
DEF VAR n_odat4 AS  DATE FORMAT "99/99/9999".
DEF VAR n_odat5 AS  DATE FORMAT "99/99/9999".
DEF VAR n_type  AS  CHAR FORMAT "X(2)".

DEF VAR i AS INT.
DEF VAR vcom1_t  AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR vcom2_t  AS DECI FORMAT ">>,>>>,>>>,>>9.99-".

ASSIGN
    vCountRec = 0
    n_type = nv_type.

RUN pdDel01.  /* "06" Delete agtprm_fil  &  Create acproc_fil */

loop_acm001:
FOR EACH  acm001 USE-INDEX acm00103  NO-LOCK WHERE
          acm001.acno    >=  n_frac   AND
          acm001.acno    <=  n_toac   AND
          acm001.curcod   =  "BHT"    AND
          acm001.trndat  >=  n_frdate AND
          acm001.trndat  <=  n_todate AND
         (acm001.trnty1   =  "F" OR
          acm001.trnty1   =  "E" ) AND
         (acm001.bal     <>  0   OR
         (acm001.bal      =  0   AND
          acm001.latdat   >  n_asdat)) :

    IF ( YEAR(acm001.latdat) > 2999 ) AND (acm001.bal = 0)  THEN NEXT  loop_acm001.     /* A47-0108 */

    DISP  "PROCESS : " + acm001.acno + "  " + acm001.policy + "  " + acm001.trnty1 + "  " +
                         acm001.trnty2 + "  " + acm001.docno FORMAT "X(10)" /* Benjaporn J. A60-0267 date 27/06/2017 */
         @ fiProcess  WITH FRAME  frST.

    ASSIGN
        n_day      =  0     n_year    =  0      n_mocom    =  0
        n_prem     =  0     n_comp    =  0      n_gross    =  0
        nt_tdat    =  ""    nt_asdat  =  ""     n_xtm600   = ""   
        n_acc      =  ""    
        /*----A50-0218-------
        n_add1    =  ""     n_add2     = ""
        n_add3     =  ""    n_add4    =  ""     
        -----------*/
        n_insur    = ""
        n_trntyp   =  ""    n_clicod  =  ""     n_poldes   = ""
        n_polyear  =  ""    n_cedpol  =  ""     n_opnpol   = ""
        n_prvpol   =  ""    n_polbrn  =  ""     n_comdat   = ?

        n_comm_comp = 0    n_comm   = 0
        vcom1_t     = 0    vcom2_t  = 0
        n_sdmonth   = 0    n_sdyear = 0
        n_startdat  = ?    n_duedat = ?
        
        n_wcr   = 0         n_odue2 = 0
        n_damt  = 0         n_odue3 = 0
        n_odue  = 0         n_odue4 = 0
        n_odue1 = 0         n_odue5 = 0.


    FIND  xmm600 USE-INDEX xmm60001 WHERE
          xmm600.acno = acm001.acno NO-LOCK NO-ERROR.
    IF NOT AVAIL xmm600 THEN NEXT loop_acm001.
    IF xmm600.clicod <> "RD" AND
       xmm600.clicod <> "RF" AND
       xmm600.clicod <> "RB" THEN NEXT loop_acm001.
    
    ASSIGN
/*        n_acc    = xmm600.acno */
       n_day    = xmm600.crper
/*        n_ltamt  = xmm600.ltamt */
       n_clicod = xmm600.clicod.  /* A47-0142 */

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
          

    FIND  xmm031 USE-INDEX xmm03101 WHERE 
          xmm031.poltyp = acm001.poltyp
    NO-LOCK NO-ERROR.
    IF AVAIL xmm031 THEN  n_poldes = xmm031.poldes.

    ASSIGN
       n_polyear = ""
       n_cedpol  = ""
       n_opnpol  = ""
       n_prvpol  = ""
       n_polbrn  = acm001.branch.
/*        n_comdat  = acm001.comdat. */

/*     n_mocom = 0. */

    /*--- A47-0621 ---
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
                  n_comdat  = uwm100.comdat.

               vcom2_t = uwm100.com2_t.
               
               FOR EACH uwd132 USE-INDEX uwd13290 WHERE
                        uwd132.policy = uwm100.policy AND
                        uwd132.rencnt = uwm100.rencnt AND
                        uwd132.endcnt = uwm100.endcnt NO-LOCK .

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
               n_prem      = acm001.prem  -  n_mocom        /*Prem  หักเบี้ย พรบ. แล้ว*/
               n_comp      = n_mocom                        /* เบี้ย พรบ. */
               n_comm_comp = vcom2_t                        /*commission  พรบ. */               /*uwm100.com2_t*/
               n_comm      = acm001.comm -  vcom2_t.        /*commission  =  uwm100.com1_t*/    /*uwm100.com2_t*/

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

            IF  ( SUBSTR(acm001.policy,3,2) = "72" OR
                  SUBSTR(acm001.policy,3,2) = "73" )
            THEN DO:
                ASSIGN
                  n_prem      = 0
                  n_comp      = acm001.prem             /*                 เบี้ย พรบ.*/ 
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
    --- END A47-0621 ---*/

    ASSIGN
        n_gross  = n_prem + n_comp + acm001.stamp + acm001.tax
        n_insur  = SUBSTR(acm001.ref,1,35)
        n_trntyp = acm001.trnty1 + acm001.trnty2
    /*=========== CHECK TRNDAT with in & over due ==========*/
        n_sdmonth  = MONTH(acm001.trndat)
        n_sdyear   = YEAR(acm001.trndat)
        n_startdat = IF n_sdmonth = 12 THEN DATE (1,1,n_sdyear + 1)
                                       ELSE DATE(n_sdmonth + 1,1,n_sdyear).  /*วันที่เริ่มนับ credit*/

    /* หา  n_duedat วันที่สุดท้ายที่อยู่ใน credit*/
    ASSIGN
       vdueDAY   = 0   vdueMONTH = 0  vdueYEAR = 0
       vcrperMod = 0 vcrperRound = 0.

    ASSIGN
       vdueDAY   = DAY(n_startdat)
       vdueMONTH = MONTH(n_startdat)
       vdueYEAR  = YEAR(n_startdat)

       vcrperMod   = n_day mod 30                 /* ได้จำนวนวัน*/
       vcrperRound = Round( n_day / 30 , 0). /* ได้จำนวนเดือน  ปัดเศษขึ้น*/

    IF n_day = 0 THEN DO:       /* กรณี credit term เป็น 0 */
        n_duedat = acm001.trndat.  /* DATE(MONTH(acm001.trndat) ,fuMaxDay(acm001.trndat) , YEAR(acm001.trndat)) */
    END.
    ELSE IF n_day <> 0 THEN DO:
        IF n_day mod 30  = 0 THEN DO:   /* เต็มเดือน จะได้วันที่มากสุดของเดือนนั้น */
            IF vdueMONTH + vcrperRound - 1  > 12 THEN DO:  /* ข้ามปี  - 1 ลบเดือนตัวเองด้วย */
                ASSIGN
                    vYear   = vdueYear + 1
                    vMonth = (vdueMONTH +  vcrperRound - 1 ) - 12

                    vDay    = fuMaxDay(DATE(vMonth,1,vYear)).
            END.
            ELSE DO:    /* ปีเดียวกัน*/
                ASSIGN
                    vYear   = vdueYear
                    vMonth = (vdueMONTH +  vcrperRound - 1 )
                    vDay    = fuMaxDay(DATE(vMonth,1,vYear)).
            END.
        END.
        ELSE DO:        /*ไม่เต็มเดือนจะได้วันที่ 15 ของเดือนนั้น*/
            IF vdueMONTH + vcrperRound - 1  > 12 THEN DO: /* ข้ามปี */
                ASSIGN
                    vYear   = vdueYear + 1
                    vMonth = (vdueMONTH +  vcrperRound - 1  ) - 12
                    vDay    = 15.
            END.
            ELSE DO:    /* ปีเดียวกัน*/
                ASSIGN
                    vYear   = vdueYear
                    vMonth = (vdueMONTH +  vcrperRound - 1 )
                    vDay    = 15.
            END.
        END.

            n_duedat = DATE(vMonth,vDay,vYear). /*ASSIGN ค่าให้วันที่วันสุดท้าย*/
         END.     /* if n_day <> 0 */
/**/
/*            n_duedat  = n_startdat + n_day - 1.     /*วันที่สุดท้าย  credit  (นับวันแรกด้วย) */*/
      /*------------------ หาจำนวนวันใน 3 , 6 , 9 , 12 เดือน --------------------*/
/*           n_odmonth1  =  IF (MONTH(n_duedat) + 3 )   MOD 12 = 0 THEN 1 ELSE (MONTH(n_duedat ) + 3 )   MOD 12.
 *            n_odmonth2  =  IF (MONTH(n_duedat ) + 6 )   MOD 12 = 0 THEN 1 ELSE (MONTH(n_duedat ) + 6 )   MOD 12.
 *            n_odmonth3  =  IF (MONTH(n_duedat ) + 9 )   MOD 12 = 0 THEN 1 ELSE (MONTH(n_duedat ) + 9 )   MOD 12.
 *            n_odmonth4  =  IF (MONTH(n_duedat ) + 12 ) MOD 12 = 0 THEN 1 ELSE (MONTH(n_duedat ) + 12 ) MOD 12.*/
    i = 0. 
    DO i = 0  TO 2 :   /* over due 1 - 3*/
     ASSIGN
        n_odmonth1 = IF (MONTH(n_duedat ) + i )   MOD 12 = 0 THEN 1 ELSE (MONTH(n_duedat ) + i )   MOD 12
        n_odDay1 =  n_odDay1 + fuNumMonth(n_odmonth1, n_duedat ).
    END.
    i = 0.
    DO i = 0  TO 5 :   /* over due 3 - 6*/
     ASSIGN
        n_odmonth2  =  IF (MONTH(n_duedat ) + i )   MOD 12 = 0 THEN 1 ELSE (MONTH(n_duedat ) + i )   MOD 12
        n_odDay2 =  n_odDay2 + fuNumMonth(n_odmonth2, n_duedat ).
    END.
    i = 0.
    DO i = 0  TO 8 :   /* over due 6 - 9*/
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
       n_odat2 =  n_duedat  +  n_odDay2
       n_odat3 =  n_duedat  +  n_odDay3
       n_odat4 =  n_duedat  +  n_odDay4.
    
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

    v_trntyp12 = acm001.trnty1 + acm001.trnty2.
   /*--------------------------------------------------------------------*/

   FIND  First agtprm_fil USE-INDEX by_trndat_acno   WHERE
         agtprm_fil.trndat = acm001.trndat   AND
         agtprm_fil.acno   = acm001.acno     AND
         agtprm_fil.poltyp = acm001.poltyp   AND
         agtprm_fil.policy = acm001.policy   AND
         agtprm_fil.endno  = acm001.recno    AND
         agtprm_fil.trntyp = v_trntyp12      AND
         agtprm_fil.docno  = acm001.docno    AND
         agtprm_fil.asdat  = n_asdat
   NO-LOCK NO-ERROR.
   IF NOT AVAIL agtprm_fil THEN DO:

      RUN pdCreate (OUTPUT n_recid). /* Create Transaction*/  

      FIND agtprm_fil where recid(agtprm_fil) = n_recid NO-ERROR .
      IF AVAIL agtprm_fil  THEN DO:
          ASSIGN
             agtprm_fil.asdat   =  n_asdat
             agtprm_fil.acno    =  acm001.acno
             agtprm_fil.agent   =  acm001.agent
             agtprm_fil.poltyp  =  acm001.poltyp
             agtprm_fil.polbran = n_polbrn
             agtprm_fil.polyear =  n_polyear
             agtprm_fil.policy  =  acm001.policy
             agtprm_fil.endno   =  acm001.recno
             agtprm_fil.cedpol  =  n_cedpol
             agtprm_fil.insur   =  n_insur
             agtprm_fil.prem    =  n_prem
             agtprm_fil.prem_comp = n_comp
             agtprm_fil.tax     =  acm001.tax
             agtprm_fil.stamp   =  acm001.stamp
             agtprm_fil.gross   =  n_gross
             agtprm_fil.comm    =  n_comm        agtprm_fil.comm_comp  =  n_comm_comp
             agtprm_fil.bal     =  acm001.bal
             agtprm_fil.trndat  =  acm001.trndat
             agtprm_fil.credit  =  n_day
             agtprm_fil.trntyp  =  n_trntyp
             agtprm_fil.docno   =  acm001.docno
             agtprm_fil.acno_clicod =  n_clicod   /* A47-0142  acm001.clicod*/
    
             agtprm_fil.vehreg  =  acm001.vehreg
             agtprm_fil.opnpol  =  n_opnpol
             agtprm_fil.prvpol  =  n_prvpol
             agtprm_fil.latdat  =  acm001.latdat
             agtprm_fil.ac_name =  n_xtm600
             agtprm_fil.addr1   =  n_add1
             agtprm_fil.addr2   =  n_add2
             agtprm_fil.addr3   =  n_add3
             agtprm_fil.addr4   =  n_add4
             agtprm_fil.odue6   =  n_ltamt   /* credit Limit*/
             agtprm_fil.wcr     =  n_wcr
             agtprm_fil.damt    =  n_damt  /* 3 ช่อง */
             agtprm_fil.odue    =  n_odue  /* 3 ช่อง*/
    
             agtprm_fil.odue1   = n_odue1
             agtprm_fil.odue2   = n_odue2
             agtprm_fil.odue3   = n_odue3
             agtprm_fil.odue4   = n_odue4
             agtprm_fil.odue5   = n_odue5
    
             agtprm_fil.startdat = n_startdat
             agtprm_fil.duedat   = IF LOOKUP(n_trntyp,nv_YZCB) = 0 THEN n_duedat ELSE acm001.trndat  /*A46-0142  acm001.trndat */
             agtprm_fil.poldes   = n_poldes
             agtprm_fil.type     = n_type
             agtprm_fil.comdat   = n_comdat.
      END.

   END. /* IF NOTAVAIL agtprm_fil*/

   ASSIGN
        n_odmonth1  = 0  n_odmonth2 = 0  n_odmonth3 = 0  n_odmonth4 = 0
        n_odDay1    = 0  n_odDay2   = 0  n_odDay3   = 0  n_odDay4   = 0
        n_odat1     = ?  n_odat2    = ?  n_odat3    = ?  n_odat4    = ?

        nt_tdat  = STRING(n_todate,"99/99/9999")
        nt_asdat = STRING(n_asdat,"99/99/9999").

        vCountRec = vCountRec + 1 .

   RELEASE agtprm_fil.  /*release acm001.*/

END.  /*acm001*/


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdProcess_old WACR20 
PROCEDURE pdProcess_old :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

DEF VAR n_startdat  AS DATE FORMAT "99/99/9999".
DEF VAR n_duedat    AS DATE FORMAT "99/99/9999".
DEF VAR n_sdmonth   AS INT. /*start date*/
DEF VAR n_sdyear    AS INT.
/* หาวันที่เริ่มต้น  ต้องเป็นวันที่วันสุดท้ายของเดือนนั้น ๆ*/
DEF VAR vYear       AS INT.
DEF VAR vMonth      AS INT.
DEF VAR vDay        AS INT.
DEF VAR vdueDAY     AS INT.
DEF VAR vdueMONTH   AS INT.
DEF VAR vdueYEAR    AS INT.
DEF VAR vcrperMod   AS INT.
DEF VAR vcrperTrun  AS INT.
DEF VAR vcrperRound AS INT.
/**/
DEF VAR n_odmonth1 AS INT. /*month  not over  12   เดือนที่  เพื่อนำไปหาจำนวนวันในแต่ละเดือน */
DEF VAR n_odmonth2 AS INT.
DEF VAR n_odmonth3 AS INT.
DEF VAR n_odmonth4 AS INT.
DEF VAR n_odDay1   AS INT. /*count num day in over due 1 - 3   จำนวนวัน ที่เกิน ระยะเวลาให้ credit  3 เดือน */
DEF VAR n_odDay2   AS INT.
DEF VAR n_odDay3   AS INT.
DEF VAR n_odDay4   AS INT.

DEF VAR n_odat1 AS  DATE FORMAT "99/99/9999". /* วันที่ ที่เกินจากระยะเวลาให้ credit  เกินไป 3 เดือน*/
DEF VAR n_odat2 AS  DATE FORMAT "99/99/9999".
DEF VAR n_odat3 AS  DATE FORMAT "99/99/9999".
DEF VAR n_odat4 AS  DATE FORMAT "99/99/9999".
DEF VAR n_odat5 AS  DATE FORMAT "99/99/9999".
DEF VAR n_type  AS  CHAR FORMAT "X(2)".

DEF VAR i AS INT.
DEF VAR vcom1_t  AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR vcom2_t  AS DECI FORMAT ">>,>>>,>>>,>>9.99-".

ASSIGN
    vCountRec = 0
    n_type = nv_type.

    RUN pdDel01.  /* "01" Delete agtprm_fil  &  Create acproc_fil
                                   "05"  */ 
                                   
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
          /*--- kan.*/
         (acm001.bal     <> 0  OR        
         (acm001.bal      =  0  AND
          acm001.latdat   >  n_asdat)) :

    IF ( YEAR(acm001.latdat) > 2999 ) AND (acm001.bal = 0)  THEN NEXT  loop_acm001.     /* A47-0108 */

       DISP  "PROCESS : " + acm001.acno + "  " + acm001.policy + "  " + acm001.trnty1 + "  " +
                  acm001.trnty2 + "  " + acm001.docno FORMAT "X(10)" /* Benjaporn J. A60-0267 date 27/06/2017 */
            @ fiProcess  WITH FRAME  frST.
        ASSIGN
            n_day      =  0
            nt_tdat    =  ""    nt_asdat   =  ""    n_xtm600 = ""   n_clicod = ""
            n_acc      =  ""    n_add1     =  ""    n_add2   = ""
            n_add3     =  ""    n_add4     =  ""    n_insur  = ""
            n_trntyp   =  ""    n_mocom    =  0     n_prem   = 0
            n_comp     =  0     n_gross    =  0     n_year   = 0
            n_polyear  =  ""    n_cedpol   =  ""    n_opnpol = ""
            n_prvpol   =  ""    n_polbrn   =  ""    n_comdat = ?

            n_comm_comp = 0   n_comm   = 0
            vcom1_t     = 0   vcom2_t  = 0
            n_startdat  = ?   n_duedat = ?
            n_sdmonth   = 0   n_sdyear = 0
            n_poldes    = ""

            n_wcr   = 0
            n_damt  = 0
            n_odue  = 0
            n_odue1 = 0
            n_odue2 = 0
            n_odue3 = 0
            n_odue4 = 0
            n_odue5 = 0.

        FIND  xmm031 WHERE xmm031.poltyp = acm001.poltyp
        NO-LOCK NO-ERROR.
        IF AVAIL xmm031 THEN  n_poldes = xmm031.poldes.

        
        FIND  xmm600 USE-INDEX xmm60001 WHERE
              xmm600.acno  = acm001.acno
              /* (xmm600.acccod = "AG" OR  xmm600.acccod = "BR") */
        NO-LOCK NO-ERROR.
        IF NOT AVAIL xmm600 THEN NEXT.
        IF xmm600.acccod <> "AG"  THEN DO:
            IF  xmm600.acccod <> "BR" THEN NEXT.
        END.
        ASSIGN
            n_acc    = xmm600.acno
            n_day    = xmm600.crper
            n_ltamt  = xmm600.ltamt
            n_clicod = xmm600.clicod.  /* A47-0142 */

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
              n_cedpol = ""
              n_opnpol = ""
              n_prvpol = ""
              n_polbrn = acm001.branch
              n_comdat = acm001.comdat.

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
                        n_comdat  = uwm100.comdat.
    
                    vcom2_t = uwm100.com2_t.
                   FOR EACH uwd132  WHERE
                            uwd132.policy  = uwm100.policy AND
                            uwd132.rencnt  = uwm100.rencnt AND
                            uwd132.endcnt  = uwm100.endcnt NO-LOCK .
    
                       IF uwd132.bencod = "COMP" OR
                          uwd132.bencod = "COMG"  OR
                          uwd132.bencod = "COMH"  THEN
                          n_mocom = n_mocom + uwd132.prem_c.       /* prem_c  เบี้ย พรบ.*/
    
                   END.
                END. /* IF AVAIL uwm100 */
                ELSE DO:
                   n_mocom = 0.
                END. /* IF NOT AVAIL uwm100*/
    
                ASSIGN
                   n_prem    = acm001.prem  -  n_mocom   /*Prem  หักเบี้ย พรบ. แล้ว*/
                   n_comp    = n_mocom                               /*               เบี้ย พรบ. */
                   n_comm_comp = vcom2_t                        /*commission  พรบ. */ /*uwm100.com2_t*/
                   n_comm   = acm001.comm -  vcom2_t. /*commission  =  uwm100.com1_t*/ /*uwm100.com2_t*/
    
            END. /* 70 */
            ELSE DO:
                FIND  uwm100 USE-INDEX uwm10001 WHERE
                       uwm100.policy  = acm001.policy  AND
                       uwm100.rencnt  = acm001.rencnt  AND
                       uwm100.endcnt = acm001.endcnt NO-LOCK NO-ERROR.
                IF AVAIL uwm100 THEN
                    ASSIGN
                     n_polyear = uwm100.undyr
                     n_cedpol  = uwm100.cedpol
                     n_opnpol  = uwm100.opnpol
                     n_prvpol   = uwm100.prvpol
                     vcom1_t    = uwm100.com1_t
                     n_polbrn   = uwm100.branch
                     n_comdat  = uwm100.comdat.
    
                IF   (SUBSTR(acm001.policy,3,2) = "72" OR
                        SUBSTR(acm001.policy,3,2) = "73" )
                THEN DO:
                    ASSIGN
                      n_prem    =  0
                      n_comp    = acm001.prem             /*                 เบี้ย พรบ.*/ 
                      n_comm_comp = acm001.comm  /* commission  พรบ.*/ /*uwm100.com1_t */
                      n_comm   = 0.
                 END.
                 ELSE DO:      /* ทุก Line ยกเว้น 70 , 72 ,73 */
                    ASSIGN
                      n_prem   = acm001.prem
                      n_comp   = 0
                      n_comm_comp =  0
                      n_comm  = acm001.comm.
                 END.
                 
            END.  /* loop หาเบี้ย ในแต่ละ line pol */

        END.   /* หาข้อมูลเฉพาะ รายการที่มีการระบุเบอร์ ก/ธ  M, R    A47-0142 */
                
    ASSIGN
        n_gross    = n_prem + n_comp + acm001.stamp + acm001.tax
        n_insur = SUBSTR(acm001.ref,1,35)
        n_trntyp   = acm001.trnty1 + acm001.trnty2
    /*=========== CHECK TRNDAT with in & over due ==========*/
        n_sdmonth = MONTH(acm001.trndat)
        n_sdyear  = YEAR(acm001.trndat)
        n_startdat = IF n_sdmonth = 12 THEN DATE (1,1,n_sdyear + 1)
                                       ELSE DATE(n_sdmonth + 1,1,n_sdyear).  /*วันที่เริ่มนับ credit*/
/* หา  n_duedat วันที่สุดท้ายที่อยู่ใน credit*/
ASSIGN
    vdueDAY = 0   vdueMONTH = 0  vdueYEAR = 0
    vcrperMod = 0 vcrperRound = 0.

         ASSIGN
            vdueDAY = DAY(n_startdat) 
            vdueMONTH = MONTH(n_startdat)
            vdueYEAR    = YEAR(n_startdat)

            vcrperMod    = n_day mod 30                 /* ได้จำนวนวัน*/
            vcrperRound = Round( n_day / 30 , 0). /* ได้จำนวนเดือน  ปัดเศษขึ้น*/

    IF n_day = 0 THEN DO:       /* กรณี credit term เป็น 0 */
        n_duedat = acm001.trndat.  /* DATE(MONTH(acm001.trndat) ,fuMaxDay(acm001.trndat) , YEAR(acm001.trndat)) */
    END.
    ELSE IF n_day <> 0 THEN DO:
        IF n_day mod 30  = 0 THEN DO:   /* เต็มเดือน จะได้วันที่มากสุดของเดือนนั้น */
            IF vdueMONTH + vcrperRound - 1  > 12 THEN DO:  /* ข้ามปี  - 1 ลบเดือนตัวเองด้วย */
                ASSIGN
                    vYear   = vdueYear + 1
                    vMonth = (vdueMONTH +  vcrperRound - 1 ) - 12

                    vDay    = fuMaxDay(DATE(vMonth,1,vYear)).
            END.
            ELSE DO:    /* ปีเดียวกัน*/
                ASSIGN
                    vYear   = vdueYear
                    vMonth = (vdueMONTH +  vcrperRound - 1 )
                    vDay    = fuMaxDay(DATE(vMonth,1,vYear)).
            END.
        END.
        ELSE DO:        /*ไม่เต็มเดือนจะได้วันที่ 15 ของเดือนนั้น*/
            IF vdueMONTH + vcrperRound - 1  > 12 THEN DO: /* ข้ามปี */
                ASSIGN
                    vYear   = vdueYear + 1
                    vMonth = (vdueMONTH +  vcrperRound - 1  ) - 12
                    vDay    = 15.
            END.
            ELSE DO:    /* ปีเดียวกัน*/
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
           DO i = 0  TO 2 :   /* over due 1 - 3*/
            ASSIGN
                 n_odmonth1 = IF (MONTH(n_duedat ) + i )   MOD 12 = 0 THEN 1 ELSE (MONTH(n_duedat ) + i )   MOD 12
                 n_odDay1 =  n_odDay1 + fuNumMonth(n_odmonth1, n_duedat ).
           END.
           i = 0.
           DO i = 0  TO 5 :   /* over due 3 - 6*/
            ASSIGN
                 n_odmonth2  =  IF (MONTH(n_duedat ) + i )   MOD 12 = 0 THEN 1 ELSE (MONTH(n_duedat ) + i )   MOD 12
                 n_odDay2 =  n_odDay2 + fuNumMonth(n_odmonth2, n_duedat ).
           END.
           i = 0.
           DO i = 0  TO 8 :   /* over due 6 - 9*/
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

    v_trntyp12 = acm001.trnty1 + acm001.trnty2.
   /*--------------------------------------------------------------------*/

       FIND  First agtprm_fil USE-INDEX by_trndat_acno   WHERE
             agtprm_fil.trndat = acm001.trndat   AND
             agtprm_fil.acno   = acm001.acno     AND
             agtprm_fil.poltyp = acm001.poltyp   AND
             agtprm_fil.policy = acm001.policy   AND
             agtprm_fil.endno  = acm001.recno    AND
             agtprm_fil.trntyp = v_trntyp12      AND
             agtprm_fil.docno  = acm001.docno    AND
             agtprm_fil.asdat  = n_asdat
       NO-LOCK NO-ERROR.
       IF NOT AVAIL agtprm_fil THEN DO:

          RUN pdCreate (OUTPUT n_recid). /* Create Transaction*/  

          FIND agtprm_fil where recid(agtprm_fil) = n_recid NO-ERROR .
          IF  AVAIL agtprm_fil  THEN DO:
           ASSIGN
             agtprm_fil.asdat   =  n_asdat
             agtprm_fil.acno    =  acm001.acno
             agtprm_fil.agent   =  acm001.agent
             agtprm_fil.poltyp  =  acm001.poltyp
             agtprm_fil.polbran =  n_polbrn
             agtprm_fil.polyear =  n_polyear
             agtprm_fil.policy  =  acm001.policy
             agtprm_fil.endno   =  acm001.recno
             agtprm_fil.cedpol  =  n_cedpol
             agtprm_fil.insur   =  n_insur
             agtprm_fil.prem    =  n_prem
             agtprm_fil.prem_comp = n_comp
             agtprm_fil.tax     =  acm001.tax
             agtprm_fil.stamp   =  acm001.stamp
             agtprm_fil.gross   =  n_gross
             agtprm_fil.comm    =  n_comm        agtprm_fil.comm_comp  =  n_comm_comp
             agtprm_fil.bal     =  acm001.bal
             agtprm_fil.trndat  =  acm001.trndat
             agtprm_fil.credit  =  n_day
             agtprm_fil.trntyp  =  n_trntyp
             agtprm_fil.docno   =  acm001.docno
             agtprm_fil.acno_clicod =  n_clicod   /* A47-0142  acm001.clicod*/

             agtprm_fil.vehreg  =  acm001.vehreg
             agtprm_fil.opnpol  =  n_opnpol
             agtprm_fil.prvpol  =  n_prvpol
             agtprm_fil.latdat  =  acm001.latdat
             agtprm_fil.ac_name =  n_xtm600
             agtprm_fil.addr1   =  n_add1
             agtprm_fil.addr2   =  n_add2
             agtprm_fil.addr3   =  n_add3
             agtprm_fil.addr4   =  n_add4
             agtprm_fil.odue6   =  n_ltamt   /* credit Limit*/
             agtprm_fil.wcr     =  n_wcr
             agtprm_fil.damt    =  n_damt  /* 3 ช่อง */
             agtprm_fil.odue    =  n_odue  /* 3 ช่อง*/

             agtprm_fil.odue1   = n_odue1
             agtprm_fil.odue2   = n_odue2
             agtprm_fil.odue3   = n_odue3
             agtprm_fil.odue4   = n_odue4
             agtprm_fil.odue5   = n_odue5

             agtprm_fil.startdat = n_startdat
             agtprm_fil.duedat   = IF LOOKUP(n_trntyp,nv_YZCB) = 0 THEN n_duedat ELSE acm001.trndat  /*A46-0142  acm001.trndat */
             agtprm_fil.poldes   = n_poldes
             agtprm_fil.type     = n_type
             agtprm_fil.comdat   = n_comdat.
          END.

        END. /* IF NOTAVAIL agtprm_fil*/

       ASSIGN
            n_odmonth1  = 0  n_odmonth2 = 0  n_odmonth3 = 0  n_odmonth4  = 0
            n_odDay1    = 0  n_odDay2   = 0  n_odDay3   = 0  n_odDay4    = 0
            n_odat1     = ?  n_odat2    = ?  n_odat3    = ?  n_odat4     = ?

            nt_tdat  = STRING(n_todate,"99/99/9999")
            nt_asdat = STRING(n_asdat,"99/99/9999").

        vCountRec = vCountRec + 1 .

release agtprm_fil.
/*release acm001.*/

END.  /*acm001*/


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdsi120 WACR20 
PROCEDURE pdsi120 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*due จาก โปรแกรม uzsri120.i เพื่อทำการคำนวณค่า sum insure Lukkana M. A52-0241 30/10/2009*/

/* for endorse  &  daily report */
if uwm100.poltyp  =  "M60"  or uwm100.poltyp = "M61" or uwm100.poltyp = "M62" OR
   uwm100.poltyp  =  "M63"  OR uwm100.poltyp = "M64" OR uwm100.poltyp = "M67" OR 
   uwm100.poltyp  =  "M68"
then do:
  if uwm100.endcnt > 000 then do:
    FOR EACH uwm307 USE-INDEX uwm30701 WHERE uwm307.policy = uwm100.policy and
                                             uwm307.rencnt = uwm100.rencnt and
                                             uwm307.endcnt = uwm100.endcnt
                                             NO-LOCK .
     nv_mbsi = 0.
     FIND Buwm307 use-index uwm30701 WHERE
                            Buwm307.policy = uwm307.policy and
                            Buwm307.rencnt = uwm307.rencnt and
                            Buwm307.riskgp = uwm307.riskgp and
                            Buwm307.riskno = uwm307.riskno and
                            Buwm307.itemno = uwm307.itemno and
                            Buwm307.endcnt = uwm307.endcnt
                            NO-LOCK NO-ERROR.

     IF AVAIL Buwm307 THEN  DO:
        nv_mbsi  =  uwm307.mbsi[1].
        FIND  PREV Buwm307  use-index uwm30701 WHERE
                            Buwm307.policy = uwm307.policy and
                            Buwm307.rencnt = uwm307.rencnt
                            NO-LOCK NO-ERROR.

        IF AVAIL Buwm307 THEN  DO:
          if Buwm307.riskgp = uwm307.riskgp  and
             Buwm307.riskno = uwm307.riskno  and
             Buwm307.itemno = uwm307.itemno  then   do:
             nv_sum  = nv_sum  + (nv_mbsi - Buwm307.mbsi[1]).
          end.
        END.
        ELSE DO:
             nv_sum  = nv_sum  + nv_mbsi.
        END.
     END.

    END.
  end.
  else do:
    FOR EACH uwm307 USE-INDEX uwm30701 WHERE uwm307.policy = uwm100.policy and
                                           uwm307.rencnt = uwm100.rencnt and
                                           uwm307.endcnt = uwm100.endcnt
                                           NO-LOCK .
        nv_sum  = nv_sum  + uwm307.mbsi[1].
    END.
  end.

end.
else do:
  FOR EACH uwm120 USE-INDEX uwm12002 WHERE uwm120.policy = uwm100.policy and
                                           uwm120.rencnt = uwm100.rencnt and
                                           uwm120.endcnt = uwm100.endcnt
                                           NO-LOCK .

     FIND  Buwm120  WHERE Buwm120.policy = uwm100.policy and
                          Buwm120.rencnt = uwm100.rencnt and
                          Buwm120.riskgp = uwm120.riskgp and
                          Buwm120.riskno = uwm120.riskno and
                          Buwm120.endcnt = n_endcnt
                          NO-LOCK NO-ERROR.

     IF AVAIL Buwm120 THEN  DO:
        nv_sum  = nv_sum + ((uwm120.sigr - uwm120.sico) -
                           (Buwm120.sigr - Buwm120.sico)).
     END.
     ELSE DO:
        nv_sum  = nv_sum + (uwm120.sigr - uwm120.sico).
     END.
  END.
end.
/*  END UZRSI120.I */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

/* ************************  Function Implementations ***************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fuLeapYear WACR20 
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fuMaxDay WACR20 
FUNCTION fuMaxDay RETURNS INTEGER
  (INPUT vDate AS DATE ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
    DEF VAR tday       AS INT FORMAT "99".
    DEF VAR tmon       AS INT FORMAT "99".
    DEF VAR tyear      AS INT FORMAT "9999".
    DEF VAR maxday     AS INT FORMAT "99".
      
    ASSIGN 
       tday  = DAY(vDate)
       tmon  = MONTH(vDate)
       tyear = YEAR(vDate).

    /*  ให้ค่าวันที่สูงสุดของเดือนแก่ตัวแปร*/
    maxday = DAY(  DATE(tmon,28,tyear) + 4 - DAY(DATE(tmon,28,tyear) + 4)  ).
               
    RETURN maxday .   /* Function return value.  MaxDay*/

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fuNumDay WACR20 
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fuNumMonth WACR20 
FUNCTION fuNumMonth RETURNS INTEGER
  (INPUT vMonth AS INT ,vDate AS DATE ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
  DEF VAR vNum AS INT.

  ASSIGN  vNum = 0.
  
  IF  vMonth = 1   OR  vMonth = 3    OR
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

