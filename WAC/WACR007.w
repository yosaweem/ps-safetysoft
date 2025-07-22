&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          sicfn            PROGRESS
*/
&Scoped-define WINDOW-NAME wacr007
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS wacr007 
/*------------------------------------------------------------------------

  File: 

  Description: 

  Input Parameters:
      <none>

  Output Parameters:
      <none>

  Author: 

  Created: 
Created:  Amparat C. A53-0236  
  
เรียกรายงาน Statment by Billing Date  
1. Agent Code ที่จะแสดงข้อมูล ให้ดึงข้อมูลจาก Group A/C for statistic
2. กรณีที่ Producer Code ขึ้นต้นด้วย  A0,A1,B2   
    - ไม่มีการคิดภาษีมูลค่าเพิ่ม 7%
    - คิดภาษีหัก ณ ที่จ่าย 5%
3. กรณีที่ Producer Code ไม่ได้ขึ้นต้นด้วย A0,A1,B2       
    - คิดภาษีมูลค่าเพิ่ม 7%
    - คิดภาษีหัก ณ ที่จ่าย 3%

Modify By Amparat A53-0293
    - เพิ่ม  columns  Trntyp 

Modify by amparat c. A55-0140  เพิ่มเงื่อนไข
      - Due  ซึ่งดึงข้อมูลจากวันที่ <= billing date ,
      - Within Credit  ดึงข้อมูลจากวันที่  > billing date 
      - All ดึงข้อมูลจาก วันที่ <= billing date และ วันที่ > billing date    

Modify by amparat c. A55-0216  เพิ่มฟิลด์อิน  Tax% 
      - เพื่อให้ระบุว่าต้องการ Tax % เท่าไร ระหว่าง 5-30 
      - ส่งค่าไปออกรายงาน และคำนวณ

MOdify By: Lukkana M. A55-0369 04/12/2012 แก้ไขการส่งค่า parameter connect db ,    
           เพิ่มชื่อผู้พิมพ์รายงาน , วันที่พิมพ์รายงาน
    
------------------------------------------------------------------------*/
/*          This .W file was created with the Progress UIB.             */
/*----------------------------------------------------------------------*/

/* Create an unnamed pool to store all the widgets created 
     by this procedure. This is a good default which assures
     that this procedure's triggers and internal procedures 
     will execute in this procedure's storage, and that proper
     cleanup will occur on deletion of the procedure. */
/*----------------------------------------------------------------------
     Modify By: Saharat S.  A62-0279  03/12/2019
      -เปลี่ยนหัว เป็น TMSTH
----------------------------------------------------------------------*/
CREATE WIDGET-POOL.

 
/* ***************************  Definitions  ************************** */
DEF     SHARED VAR n_User               AS CHAR.
DEF     SHARED VAR n_Passwd         AS CHAR.
DEF     VAR   nv_User     AS CHAR NO-UNDO. 
DEF     VAR   nv_pwd    LIKE _password NO-UNDO.

/* Definitons  Report -------                                               */
DEF  VAR report-library AS CHAR INIT "wAC/wprl/Wacr007.prl".
DEF  VAR report-name  AS CHAR INIT "Builling Report Motor".

DEF  VAR RB-DB-CONNECTION AS CHAR INIT "".
DEF  VAR RB-INCLUDE-RECORDS AS CHAR INIT "O". /*Can Override Filter*/
DEF  VAR RB-FILTER AS CHAR INIT "".
DEF  VAR RB-MEMO-FILE AS CHAR INIT "".
DEF  VAR RB-PRINT-DESTINATION AS CHAR INIT "?". /*Direct to Screen*/
DEF  VAR RB-PRINTER-NAME AS CHAR INIT "".
DEF  VAR RB-PRINTER-PORT AS CHAR INIT "".
DEF  VAR RB-OUTPUT-FILE AS CHAR INIT "".
DEF  VAR RB-NUMBER-COPIES AS INTE INIT 1.
DEF  VAR RB-BEGIN-PAGE AS INTE INIT 0.
DEF  VAR RB-END-PAGE AS INTE INIT 0.
DEF  VAR RB-TEST-PATTERN AS LOG INIT no.
DEF  VAR RB-WINDOW-TITLE AS CHAR INIT "".
DEF  VAR RB-DISPLAY-ERRORS AS LOG INIT yes.
DEF  VAR RB-DISPLAY-STATUS AS LOG INIT yes.
DEF  VAR RB-NO-WAIT AS LOG INIT no.
DEF  VAR RB-OTHER-PARAMETERS AS CHAR INIT "".

/* Parameters Definitions ---                                           */
DEF NEW SHARED VAR n_agent1   AS CHAR FORMAT "x(7)".
DEF NEW SHARED VAR n_agent2   AS CHAR FORMAT "x(7)".
DEF NEW SHARED VAR n_branch   AS CHAR FORMAT "x(2)".
DEF NEW SHARED VAR n_branch2  AS CHAR FORMAT "x(2)".
DEF NEW SHARED VAR n_tabcod   AS CHAR FORMAT "X(4)"    INIT "U021".   /* Table-Code  sym100*/
DEF NEW SHARED VAR n_itmcod   AS CHAR FORMAT "X(4)".

Def   Var    n_name     As Char Format "x(50)".     /*acno name*/
Def   Var    n_chkname  As Char format "x(1)".        /* Acno-- chk button 1-2 */
Def   Var    n_bdes     As Char Format "x(50)".     /*branch name*/
Def   Var    n_chkBname As Char format "x(1)".        /* branch-- chk button 1-2 */
Def   Var    n_itmdes   As Char Format "x(40)".     /*Table-Code Description*/
                        
/* Local Variable Definitions ---                                       */

DEF VAR nv_asmth        AS INTE INIT 0.
DEF VAR nv_frmth        AS INTE INIT 0.
DEF VAR nv_tomth        AS INTE INIT 0.
DEF VAR cv_mthlistT     AS CHAR INIT "มกราคม,กุมภาพันธ์,มีนาคม,เมษายน,พฤษภาคม,มิถุนายน,กรกฎาคม,สิงหาคม,กันยายน,ตุลาคม,พฤศจิกายน,ธันวาคม".
DEF VAR cv_mthListE     AS CHAR INIT "January, February, March, April, May, June, July, August, September, October, November, December".

DEF VAR n_asdat         AS DATE FORMAT "99/99/9999".
DEF VAR n_frbr          AS CHAR   FORMAT "x(2)".
DEF VAR n_tobr          AS CHAR   FORMAT "x(2)".
/*---By A54-0270---
DEF VAR n_frac          AS CHAR   FORMAT "x(7)".
DEF VAR n_toac          AS CHAR   FORMAT "x(7)".
-------------*/
/*----A54-0270----*/
DEF VAR n_frac          AS CHAR   FORMAT "x(10)".
DEF VAR n_toac          AS CHAR   FORMAT "x(10)".
/*-----------------*/
DEF VAR n_typ           AS CHAR   FORMAT "X".
DEF VAR n_typ1          AS CHAR   FORMAT "X".
DEF VAR n_trndatto      AS DATE FORMAT "99/99/9999".

DEF VAR n_chkCopy       AS INTEGER.
DEF VAR n_OutputTo      AS INTEGER.
DEF VAR n_OutputFile    AS Char.
DEF VAR n_OutputFile2   AS Char.

DEF VAR vCliCod         AS CHAR.
DEF VAR vCliCodAll      AS CHAR.
DEF VAR vCountRec       AS INT.
DEF VAR vAcProc_fil     AS CHAR.

/*--------------------------------------- A46-0019 -----------------------------*/
DEF VAR nv_ProcessDate AS DATE FORMAT "99/99/9999".
DEF VAR nv_Trntyp1  AS CHAR INIT "M,R,A,B".

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

/******************** output to file*******************/
DEF VAR n_net    AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR n_wcr    AS DECI FORMAT ">>,>>>,>>>,>>9.99-".  /*with in credit*/
DEF VAR n_damt   AS DECI FORMAT ">>,>>>,>>>,>>9.99-".  /*due amount */
DEF VAR n_odue   AS DECI FORMAT ">>,>>>,>>>,>>9.99-".  /*overdue*/

DEF VAR n_odue1  AS DECI FORMAT ">>,>>>,>>9.99-".  /*overdue 1-3 months*/
DEF VAR n_odue2  AS DECI FORMAT ">>,>>>,>>9.99-".  /*overdue 3-6 months*/
DEF VAR n_odue3  AS DECI FORMAT ">>,>>>,>>9.99-".  /*overdue 6-9 months*/
DEF VAR n_odue4  AS DECI FORMAT ">>,>>>,>>9.99-".  /*overdue 9-12 months*/
DEF VAR n_odue5  AS DECI FORMAT ">>,>>>,>>9.99-".  /*overdue over 12 months*/

DEF VAR n_odmonth1  AS INT. /*month  not over  12   เดือนที่  เพื่อนำไปหาจำนวนวันในแต่ละเดือน */
DEF VAR n_odmonth2  AS INT.
DEF VAR n_odmonth3  AS INT.
DEF VAR n_odmonth4  AS INT.

DEF VAR n_odDay1    AS INT. /*count num day in over due 1 - 3   จำนวนวัน ที่เกิน ระยะเวลาให้ credit  3 เดือน */
DEF VAR n_odDay2    AS INT.
DEF VAR n_odDay3    AS INT.
DEF VAR n_odDay4    AS INT.

DEF VAR n_odat1     AS  DATE FORMAT "99/99/9999". /* วันที่ ที่เกินจากระยะเวลาให้ credit  เกินไป 3 เดือน*/
DEF VAR n_odat2     AS  DATE FORMAT "99/99/9999".
DEF VAR n_odat3     AS  DATE FORMAT "99/99/9999".
DEF VAR n_odat4     AS  DATE FORMAT "99/99/9999".
DEF VAR n_odat5     AS  DATE FORMAT "99/99/9999".

/* TOTAL */
DEF  VAR nv_tot_prem      AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_tot_prem_comp AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_tot_stamp     AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_tot_tax       AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_tot_gross     AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_tot_comm      AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_tot_comm_comp AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_tot_net       AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_tot_bal       AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".

DEF  VAR nv_tot_wcr       AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  /*with in credit*/
DEF  VAR nv_tot_damt      AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  /*due amount */
DEF  VAR nv_tot_odue      AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  /* overdue*/
                         
DEF  VAR nv_tot_odue1     AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  /*overdue*/
DEF  VAR nv_tot_odue2     AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  /*overdue*/
DEF  VAR nv_tot_odue3     AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  /*overdue*/
DEF  VAR nv_tot_odue4     AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  /*overdue*/
DEF  VAR nv_tot_odue5     AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  /*overdue*/
                         
/* GRAND TOTAL */
DEF  VAR nv_gtot_prem      AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_gtot_prem_comp AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_gtot_stamp     AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_gtot_tax       AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_gtot_gross     AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_gtot_comm      AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_gtot_comm_comp AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_gtot_net       AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_gtot_bal       AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".

DEF  VAR nv_gtot_wcr     AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  /*with in credit*/
DEF  VAR nv_gtot_damt    AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  /*due amount */
DEF  VAR nv_gtot_odue    AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  /*overdue*/
                            
DEF  VAR nv_gtot_odue1   AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  /*overdue*/
DEF  VAR nv_gtot_odue2   AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  /*overdue*/
DEF  VAR nv_gtot_odue3   AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  /*overdue*/
DEF  VAR nv_gtot_odue4   AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  /*overdue*/
DEF  VAR nv_gtot_odue5   AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  /*overdue*/

DEF VAR nv_asdatAging    AS DATE FORMAT "99/99/9999".

/************  field in atc00701.p ***************/
DEF VAR n_insur   AS CHAR FORMAT "x(100)".
/*---By A54-0270---
DEF VAR n_acbrn   AS CHAR FORMAT "X(7)".
------------------*/
DEF VAR n_acbrn   AS CHAR FORMAT "X(10)".   /*---A54-0270---*/

DEF VAR n_clityp  AS CHAR FORMAT "X(2)".
DEF VAR n_expdat  AS DATE FORMAT "99/99/9999".
DEF VAR n_campol  AS CHAR FORMAT "X(16)".  /* uwm100.opnpol */
DEF VAR n_dealer  AS CHAR FORMAT "X(100)".

DEF VAR n_veh     AS CHAR FORMAT "X(10)".
                  
DEF VAR n_chano   AS CHAR FORMAT "X(20)".
DEF VAR n_moddes  AS CHAR FORMAT "X(40)".
DEF VAR n_cedpol  AS CHAR FORMAT "X(16)".    /* uwm100.cedpol */

DEF NEW SHARED VAR n_sckno     AS CHAR   FORMAT "X(16)"   INIT ""     NO-UNDO.  /*umm301.sckno */
DEF NEW SHARED VAR nvw_sticker AS INTEGER  FORMAT "9999999999" INIT 0 NO-UNDO.
DEF NEW SHARED VAR nv_sticker  AS INTEGER  FORMAT "9999999999".
DEF NEW SHARED VAR chr_sticker AS CHAR     FORMAT "X(11)".
DEF NEW SHARED VAR nv_modulo   AS INT      FORMAT "9".
DEF NEW SHARED VAR nv_chkmod   AS CHAR     FORMAT "X".

DEF BUFFER bxmm600 FOR xmm600.

/*---By A54-0270---
DEF VAR n_gpstmt AS CHAR FORMAT "X(7)".
-------------------*/
DEF VAR n_gpstmt AS CHAR FORMAT "X(10)".   /*---A54-0270---*/

DEF VAR n_opened AS DATE FORMAT "99/99/9999".
DEF VAR n_closed AS DATE FORMAT "99/99/9999".

/* A470142 */
DEF VAR n_prnVat AS CHAR.
DEF VAR n_linePA AS CHAR INIT "60,61,62,63,64,67".

/* A48-0250*/
DEF VAR nv_res      LIKE clm131.res.
DEF VAR nv_paid     LIKE clm130.netl_d.
DEF VAR nv_outres   LIKE clm131.res.
DEF VAR tt_res      LIKE clm131.res.
DEF VAR tt_paid     LIKE clm130.netl_d.
DEF VAR tt_outres   LIKE clm131.res.
DEF VAR nv_fptr     AS RECID.
DEF VAR n_benname AS CHAR. /* Piyachat p. A51-0203 */

/*A53-0159*/
DEF VAR n_type     AS CHAR FORMAT "X(10)" INIT "".
DEF VAR vFirstTime AS CHAR INIT "".
DEF VAR vLastTime AS CHAR INIT "".
DEF VAR nv_filter1 AS CHAR INIT "".
DEF VAR nv_filter2 AS CHAR INIT "".
DEF VAR nv_filter3 AS CHAR INIT "".
DEF VAR vAcno AS CHAR INIT "".


DEF VAR nv_grptyp      AS CHAR FORMAT "X(3)".
DEF VAR nv_type      AS CHAR FORMAT "X(1)".

DEF VAR nv_insref AS CHAR FORMAT "X" INIT "".
DEF VAR nv_dir    AS CHAR FORMAT "X(3)" INIT "".
DEF VAR nv_polgrp AS CHAR FORMAT "X(6)" INIT "".
DEF VAR nv_polgrpdes AS CHAR FORMAT "X(30)" INIT "".
DEF VAR nv_grptypdes AS CHAR FORMAT "X(30)" INIT "".
DEF VAR nv_repdetail AS CHAR FORMAT "X(10)" INIT "".

DEF VAR n_day           AS INT.
DEF VAR n_month         AS INT.
DEF VAR nv_effdat       AS DATE FORMAT "99/99/9999".
DEF VAR nv_duedate1     AS CHAR FORMAT "X(15)".
DEF VAR nv_duedate2     AS  DATE FORMAT "99/99/9999".
DEF VAR nv_duedate      AS INT.
DEF VAR nv_dueday       AS CHAR.
DEF VAR nv_duedat       AS DATE FORMAT "99/99/9999".
DEF VAR nv_pdate        AS CHAR FORMAT "x(15)".
DEF VAR nv_Cdate        AS CHAR FORMAT "x(15)".
DEF VAR nv_picture1     AS CHAR.
DEF VAR nv_pic1         AS CHAR.
DEF VAR nv_Policytype   AS CHAR.
DEF VAR nv_datenon      AS DATE.
/*ADD Saharat S. A62-0279*/
{wuw\wuwppic00a.i NEW}. 
{wuw\wuwppic01a.i}
{wuw\wuwppic02a.i}
/*END Saharat S. A62-0279*/

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
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

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME


/* ************************  Function Prototypes ********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fuLeapYear wacr007 
FUNCTION fuLeapYear RETURNS LOGICAL
  ( /* parameter-definitions */ y AS int)  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fuMaxday wacr007 
FUNCTION fuMaxday RETURNS INTEGER
  (INPUT vDate AS DATE )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fuNumMonth wacr007 
FUNCTION fuNumMonth RETURNS INTEGER
  (INPUT vMonth AS INT ,vDate AS DATE )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fuNumYear wacr007 
FUNCTION fuNumYear RETURNS INTEGER
  (INPUT vDate AS DATE )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR wacr007 AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE RECTANGLE RECT-604
     EDGE-PIXELS 0    
     SIZE 132.5 BY .95
     BGCOLOR 1 .

DEFINE BUTTON Btn_Cancel AUTO-END-KEY 
     LABEL "Cancel" 
     SIZE 16.5 BY 1.52
     BGCOLOR 8 FONT 6.

DEFINE BUTTON Btn_OK AUTO-GO 
     LABEL "OK" 
     SIZE 16.5 BY 1.52
     BGCOLOR 8 FONT 6.

DEFINE RECTANGLE RECT-600
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 19 BY 2.14
     BGCOLOR 4 .

DEFINE RECTANGLE RECT-601
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 19 BY 2.14
     BGCOLOR 1 .

DEFINE VARIABLE cbPrtList AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 10
     LIST-ITEMS "cbPrtList" 
     DROP-DOWN-LIST
     SIZE 56.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE rsOutput AS INTEGER 
     VIEW-AS RADIO-SET VERTICAL
     RADIO-BUTTONS 
          "SCREEN", 1,
"PRINTER", 2
     SIZE 15 BY 3.24
     BGCOLOR 3 FGCOLOR 15 FONT 6 NO-UNDO.

DEFINE BUTTON buAcno1 
     LABEL "..." 
     SIZE 3 BY .95 TOOLTIP "รหัส Producer"
     FONT 6.

DEFINE BUTTON buAcno2 
     LABEL "..." 
     SIZE 3 BY .95 TOOLTIP "รหัส Producer"
     FONT 6.

DEFINE BUTTON buAdd 
     LABEL "Add" 
     SIZE 8.5 BY 1.1 TOOLTIP "เพิ่ม Client Type Code"
     FONT 6.

DEFINE BUTTON buBranch 
     LABEL "..." 
     SIZE 3 BY .95 TOOLTIP "รหัสสาขา"
     FONT 6.

DEFINE BUTTON buBranch2 
     LABEL "..." 
     SIZE 3 BY .95 TOOLTIP "รหัสสาขา"
     FONT 6.

DEFINE BUTTON buClicod 
     LABEL "..." 
     SIZE 3 BY .95 TOOLTIP "Client Type Code".

DEFINE BUTTON buDel 
     LABEL "Delete" 
     SIZE 8.5 BY 1.1 TOOLTIP "ลบ Client Type Code"
     FONT 6.

DEFINE VARIABLE cbRptList AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEMS "Billing Report Motor","Billing Report Non-Motor","Billing Report All" 
     DROP-DOWN-LIST
     SIZE 42 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiacno1 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 14.83 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiacno2 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 14.83 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiAsdat AS DATE FORMAT "99/99/9999":U 
     LABEL "Fill 1" 
      VIEW-AS TEXT 
     SIZE 15.83 BY 1
     BGCOLOR 19 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fibdes AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 54.83 BY .95
     BGCOLOR 19 FONT 6 NO-UNDO.

DEFINE VARIABLE fibdes2 AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 56 BY .95
     BGCOLOR 19 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fiBranch AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 5 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiBranch2 AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 5 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiCcode1 AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 13.17 BY .95 TOOLTIP "Client Type Code"
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fiInclude AS CHARACTER FORMAT "X(256)":U 
     LABEL "Fill 1" 
      VIEW-AS TEXT 
     SIZE 21 BY 1
     BGCOLOR 1 FGCOLOR 7 FONT 1 NO-UNDO.

DEFINE VARIABLE finame1 AS CHARACTER FORMAT "X(256)":U 
     LABEL "" 
      VIEW-AS TEXT 
     SIZE 47 BY .95
     BGCOLOR 19 FONT 6 NO-UNDO.

DEFINE VARIABLE finame2 AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 47 BY .95
     BGCOLOR 19 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fiProcess AS CHARACTER FORMAT "X(256)":U 
     LABEL "fiProcess" 
      VIEW-AS TEXT 
     SIZE 37 BY .95
     BGCOLOR 19 FGCOLOR 1 FONT 1 NO-UNDO.

DEFINE VARIABLE fiProcessDate AS DATE FORMAT "99/99/9999":U 
      VIEW-AS TEXT 
     SIZE 15.83 BY 1
     BGCOLOR 19 FGCOLOR 0 FONT 6 NO-UNDO.

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

DEFINE VARIABLE fi_BuillDate AS DATE FORMAT "99/99/9999":U 
     LABEL "Fill 1" 
     VIEW-AS FILL-IN 
     SIZE 16 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_Tax AS INTEGER FORMAT ">9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 4.5 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE raReportTyp AS INTEGER 
     VIEW-AS RADIO-SET VERTICAL
     RADIO-BUTTONS 
          "AG/BR", 1,
"FI/DE", 2,
"DI", 3,
"ALL", 4
     SIZE 18.17 BY 3.81
     BGCOLOR 19 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE rs_billing AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "Due", 1,
"Within Credit", 2,
"All", 3
     SIZE 61 BY 1.19
     BGCOLOR 19 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-101
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 21.67 BY 1.52
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-102
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 68 BY 1.52
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-104
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 21.67 BY 2.62
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-105
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 68 BY 2.62
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-106
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 21.67 BY 2.62
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-107
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 68 BY 2.62
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-108
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 21.67 BY 1.71
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-109
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 68 BY 1.71
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-112
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 21.67 BY 1.71
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-113
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 68 BY 1.71
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-114
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 21.67 BY 1.71
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-115
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 68 BY 1.71
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-602
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 10 BY 1.52
     BGCOLOR 2 .

DEFINE RECTANGLE RECT-603
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 9.83 BY 1.52
     BGCOLOR 4 .

DEFINE RECTANGLE RECT12
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 40.5 BY 11.91
     BGCOLOR 19 .

DEFINE VARIABLE seCliCod AS CHARACTER 
     VIEW-AS SELECTION-LIST MULTIPLE SORT SCROLLBAR-VERTICAL 
     SIZE 16.5 BY 5.62
     BGCOLOR 15  NO-UNDO.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY brAcproc_fil FOR 
      acproc_fil SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE brAcproc_fil
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS brAcproc_fil wacr007 _STRUCTURED
  QUERY brAcproc_fil DISPLAY
      acproc_fil.asdat FORMAT "99/99/9999":U COLUMN-FONT 1 LABEL-FONT 1
      acproc_fil.type COLUMN-LABEL "Ty" FORMAT "X(3)":U
      IF (acproc_fil.type = "01") THEN ("Monthly") ELSE ("Daily") COLUMN-LABEL "Detail"
            WIDTH 10
      acproc_fil.entdat COLUMN-LABEL "Process Date" FORMAT "99/99/9999":U
      acproc_fil.enttim COLUMN-LABEL "Time" FORMAT "X(8)":U
      SUBSTRING (acproc_fil.enttim,10,3) COLUMN-LABEL "Sta" FORMAT "X(1)":U
            WIDTH 3
      acproc_fil.trndatfr COLUMN-LABEL "TranDate Fr" FORMAT "99/99/9999":U
            WIDTH 12
      acproc_fil.trndatto COLUMN-LABEL "TranDate To" FORMAT "99/99/9999":U
            WIDTH 12
      acproc_fil.typdesc FORMAT "X(53)":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 130.5 BY 5.91
         BGCOLOR 15 FGCOLOR 0 FONT 1.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 24
         BGCOLOR 18 .

DEFINE FRAME frMain
     "OUTPUT  TO" VIEW-AS TEXT
          SIZE 24 BY .62 AT ROW 20.43 COL 3
          BGCOLOR 1 FGCOLOR 15 FONT 6
     RECT-604 AT ROW 20.29 COL 1
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         NO-LABELS SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 24.

DEFINE FRAME frST
     rs_billing AT ROW 10.81 COL 25 NO-LABEL
     fiBranch AT ROW 3.81 COL 23.5 COLON-ALIGNED NO-LABEL
     fiBranch2 AT ROW 5 COL 23.5 COLON-ALIGNED NO-LABEL
     fiacno1 AT ROW 6.52 COL 23.17 COLON-ALIGNED NO-LABEL
     fiacno2 AT ROW 7.52 COL 23.17 COLON-ALIGNED NO-LABEL
     raReportTyp AT ROW 3.38 COL 93.17 NO-LABEL
     fiTyp1 AT ROW 10.52 COL 93 COLON-ALIGNED NO-LABEL
     fiTyp2 AT ROW 10.52 COL 98 COLON-ALIGNED NO-LABEL
     fiTyp3 AT ROW 10.52 COL 103 COLON-ALIGNED NO-LABEL
     fiTyp4 AT ROW 10.52 COL 108 COLON-ALIGNED NO-LABEL
     fiTyp5 AT ROW 10.52 COL 113 COLON-ALIGNED NO-LABEL
     fiTyp6 AT ROW 10.57 COL 118.17 COLON-ALIGNED NO-LABEL
     fiTyp7 AT ROW 10.57 COL 123.17 COLON-ALIGNED NO-LABEL
     fiTyp8 AT ROW 11.76 COL 93 COLON-ALIGNED NO-LABEL
     fiTyp9 AT ROW 11.76 COL 98 COLON-ALIGNED NO-LABEL
     fiTyp10 AT ROW 11.76 COL 103 COLON-ALIGNED NO-LABEL
     fiTyp11 AT ROW 11.76 COL 108 COLON-ALIGNED NO-LABEL
     fiTyp12 AT ROW 11.76 COL 113 COLON-ALIGNED NO-LABEL
     fiTyp13 AT ROW 11.76 COL 118 COLON-ALIGNED NO-LABEL
     fiTyp14 AT ROW 11.76 COL 123 COLON-ALIGNED NO-LABEL
     buBranch AT ROW 3.91 COL 30.5
     buBranch2 AT ROW 5 COL 30.5
     seCliCod AT ROW 3.24 COL 114.83 NO-LABEL
     buAcno1 AT ROW 6.52 COL 39.83
     buAcno2 AT ROW 7.52 COL 39.83
     fiCcode1 AT ROW 2.29 COL 112.83 COLON-ALIGNED NO-LABEL
     buClicod AT ROW 2.33 COL 128.33
     cbRptList AT ROW 2.29 COL 23 COLON-ALIGNED NO-LABEL
     brAcproc_fil AT ROW 14.14 COL 2
     fi_BuillDate AT ROW 9.1 COL 23.17 COLON-ALIGNED
     fi_Tax AT ROW 9.1 COL 48 COLON-ALIGNED NO-LABEL
     fibdes AT ROW 3.81 COL 32.17 COLON-ALIGNED NO-LABEL
     buAdd AT ROW 7.62 COL 93.17
     buDel AT ROW 7.57 COL 103.5
     fibdes2 AT ROW 5 COL 32 COLON-ALIGNED NO-LABEL
     finame1 AT ROW 6.52 COL 41.33 COLON-ALIGNED
     finame2 AT ROW 7.52 COL 41.33 COLON-ALIGNED NO-LABEL
     fiInclude AT ROW 9.19 COL 109 COLON-ALIGNED
     fiAsdat AT ROW 12.57 COL 22.67 COLON-ALIGNED
     fiProcessDate AT ROW 12.57 COL 58.67 COLON-ALIGNED NO-LABEL
     fiProcess AT ROW 12.91 COL 93.5
     " As of Date":30 VIEW-AS TEXT
          SIZE 11.17 BY .95 AT ROW 12.57 COL 7.83
          BGCOLOR 19 FONT 6
     " Process Date":30 VIEW-AS TEXT
          SIZE 14.67 BY 1 TOOLTIP "วันที่ออกรายงาน" AT ROW 12.57 COL 43.33
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "BILLING REPORT   [CBC]" VIEW-AS TEXT
          SIZE 35.5 BY .62 AT ROW 1.14 COL 51.83
          BGCOLOR 1 FGCOLOR 15 FONT 6
     "  To":25 VIEW-AS TEXT
          SIZE 5.33 BY .95 TOOLTIP "ตั้งแต่สาขา" AT ROW 7.67 COL 16.5
          BGCOLOR 19 FONT 6
     " Include Type All":50 VIEW-AS TEXT
          SIZE 18.5 BY 1 AT ROW 9.19 COL 92.5
          BGCOLOR 1 FGCOLOR 7 FONT 6
     "Type Of Reports":50 VIEW-AS TEXT
          SIZE 15.83 BY .95 TOOLTIP "ประเภทรายงาน" AT ROW 2.33 COL 5.67
          BGCOLOR 19 FONT 6
     "  To":25 VIEW-AS TEXT
          SIZE 5.33 BY .95 TOOLTIP "ตั้งแต่สาขา" AT ROW 5.05 COL 16.83
          BGCOLOR 19 FONT 6
     " Branch From":25 VIEW-AS TEXT
          SIZE 13.83 BY 1 TOOLTIP "ตั้งแต่สาขา" AT ROW 3.76 COL 8.5
          BGCOLOR 19 FONT 6
     " Producer Code":40 VIEW-AS TEXT
          SIZE 15.83 BY 1 TOOLTIP "ตัวแทน" AT ROW 6.43 COL 6
          BGCOLOR 19 FONT 6
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         NO-LABELS SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 132.5 BY 19.29
         BGCOLOR 8 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME frST
     "Billing Date":30 VIEW-AS TEXT
          SIZE 11.83 BY .95 AT ROW 9.1 COL 10
          BGCOLOR 19 FONT 6
     "Tax":25 VIEW-AS TEXT
          SIZE 4.5 BY .95 TOOLTIP "5-30" AT ROW 9.1 COL 44.5
          BGCOLOR 19 FONT 6
     "%":25 VIEW-AS TEXT
          SIZE 6.5 BY .95 AT ROW 9.14 COL 56
          BGCOLOR 19 FONT 6
     " Client Type Code":50 VIEW-AS TEXT
          SIZE 22.17 BY 1 TOOLTIP "Client Type Code" AT ROW 2.19 COL 92.33
          BGCOLOR 1 FGCOLOR 7 FONT 6
     "":200 VIEW-AS TEXT
          SIZE 132 BY .95 AT ROW 1 COL 1
          BGCOLOR 1 FGCOLOR 15 FONT 6
     RECT-101 AT ROW 2.1 COL 1.83
     RECT-102 AT ROW 2.1 COL 23.5
     RECT-104 AT ROW 3.62 COL 1.83
     RECT-105 AT ROW 3.62 COL 23.5
     RECT-106 AT ROW 6.24 COL 1.83
     RECT-107 AT ROW 6.24 COL 23.5
     RECT12 AT ROW 2.1 COL 92
     RECT-602 AT ROW 7.38 COL 92.5
     RECT-603 AT ROW 7.38 COL 102.67
     RECT-108 AT ROW 8.86 COL 1.83
     RECT-109 AT ROW 8.86 COL 23.5
     RECT-112 AT ROW 10.57 COL 1.83
     RECT-113 AT ROW 10.57 COL 23.5
     RECT-114 AT ROW 12.29 COL 1.83
     RECT-115 AT ROW 12.29 COL 23.5
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         NO-LABELS SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 132.5 BY 19.29
         BGCOLOR 8 .

DEFINE FRAME frOK
     Btn_OK AT ROW 2.05 COL 3.33
     Btn_Cancel AT ROW 2.1 COL 22.17
     RECT-600 AT ROW 1.76 COL 20.83
     RECT-601 AT ROW 1.76 COL 2
    WITH DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 92.5 ROW 21.24
         SIZE 41 BY 3.57
         BGCOLOR 3 .

DEFINE FRAME frOutput
     rsOutput AT ROW 1.05 COL 6 NO-LABEL
     cbPrtList AT ROW 2.86 COL 19.5 COLON-ALIGNED NO-LABEL
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE 
         AT COL 1 ROW 21.24
         SIZE 91 BY 3.62
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
  CREATE WINDOW wacr007 ASSIGN
         HIDDEN             = YES
         TITLE              = "wacr007 - BILLING REPORT   [CBC]"
         HEIGHT             = 23.86
         WIDTH              = 133.33
         MAX-HEIGHT         = 44.67
         MAX-WIDTH          = 213.33
         VIRTUAL-HEIGHT     = 44.67
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
IF NOT wacr007:LOAD-ICON("wimage/safety.ico":U) THEN
    MESSAGE "Unable to load icon: wimage/safety.ico"
            VIEW-AS ALERT-BOX WARNING BUTTONS OK.
&ENDIF
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW wacr007
  VISIBLE,,RUN-PERSISTENT                                               */
/* REPARENT FRAME */
ASSIGN FRAME frMain:FRAME = FRAME DEFAULT-FRAME:HANDLE
       FRAME frOK:FRAME = FRAME frMain:HANDLE
       FRAME frOutput:FRAME = FRAME frMain:HANDLE
       FRAME frST:FRAME = FRAME frMain:HANDLE.

/* SETTINGS FOR FRAME DEFAULT-FRAME
   FRAME-NAME                                                           */
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
/* BROWSE-TAB brAcproc_fil cbRptList frST */
/* SETTINGS FOR FILL-IN fiAsdat IN FRAME frST
   LABEL "Fill 1:"                                                      */
/* SETTINGS FOR FILL-IN fiInclude IN FRAME frST
   LABEL "Fill 1:"                                                      */
/* SETTINGS FOR FILL-IN finame1 IN FRAME frST
   LABEL ":"                                                            */
/* SETTINGS FOR FILL-IN fiProcess IN FRAME frST
   ALIGN-L LABEL "fiProcess:"                                           */
ASSIGN 
       fiProcess:HIDDEN IN FRAME frST           = TRUE.

/* SETTINGS FOR FILL-IN fi_BuillDate IN FRAME frST
   LABEL "Fill 1:"                                                      */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(wacr007)
THEN wacr007:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE brAcproc_fil
/* Query rebuild information for BROWSE brAcproc_fil
     _TblList          = "sicfn.acproc_fil"
     _FldNameList[1]   > sicfn.acproc_fil.asdat
"acproc_fil.asdat" ? ? "date" ? ? 1 ? ? 1 no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[2]   > sicfn.acproc_fil.type
"acproc_fil.type" "Ty" "X(3)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   > "_<CALC>"
"IF (acproc_fil.type = ""01"") THEN (""Monthly"") ELSE (""Daily"")" "Detail" ? ? ? ? ? ? ? ? no ? no no "10" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   > sicfn.acproc_fil.entdat
"acproc_fil.entdat" "Process Date" ? "date" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   > sicfn.acproc_fil.enttim
"acproc_fil.enttim" "Time" ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[6]   > "_<CALC>"
"SUBSTRING (acproc_fil.enttim,10,3)" "Sta" "X(1)" ? ? ? ? ? ? ? no ? no no "3" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[7]   > sicfn.acproc_fil.trndatfr
"acproc_fil.trndatfr" "TranDate Fr" ? "date" ? ? ? ? ? ? no ? no no "12" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[8]   > sicfn.acproc_fil.trndatto
"acproc_fil.trndatto" "TranDate To" ? "date" ? ? ? ? ? ? no ? no no "12" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[9]   > sicfn.acproc_fil.typdesc
"acproc_fil.typdesc" ? "X(53)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _Query            is NOT OPENED
*/  /* BROWSE brAcproc_fil */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME wacr007
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wacr007 wacr007
ON END-ERROR OF wacr007 /* wacr007 - BILLING REPORT   [CBC] */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wacr007 wacr007
ON WINDOW-CLOSE OF wacr007 /* wacr007 - BILLING REPORT   [CBC] */
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
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brAcproc_fil wacr007
ON VALUE-CHANGED OF brAcproc_fil IN FRAME frST
DO:


DO WITH FRAME frST:
    IF NOT CAN-FIND(FIRST acproc_fil WHERE (acproc_fil.type = "01" OR acproc_fil.type = "05" )) THEN DO:
        ASSIGN
            fiasdat = ?
            fiProcessdate = ?
            n_trndatto = ?
            n_asdat = fiasdat.
        DISP fiasdat fiProcessdate.
    END.
    ELSE DO:
        FIND CURRENT acproc_fil NO-LOCK.
        ASSIGN
            fiasdat = acproc_fil.asdat
            fiProcessdate = acproc_fil.entdat
            n_trndatto = acproc_fil.trndatto
            n_asdat = fiasdat.
        DISP fiasdat fiProcessdate .
    END.
END. /**/

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frOK
&Scoped-define SELF-NAME Btn_Cancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_Cancel wacr007
ON CHOOSE OF Btn_Cancel IN FRAME frOK /* Cancel */
DO:
    Apply "Close" To This-Procedure.
    Return No-Apply.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_OK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_OK wacr007
ON CHOOSE OF Btn_OK IN FRAME frOK /* OK */
DO:
   DO WITH FRAME {&FRAME-NAME} :
        ASSIGN  
            FRAME frST fibranch fibranch
            FRAME frST fibranch2 fibranch2
            FRAME frST fiacno1 fiacno1
            FRAME frST fiacno2 fiacno2
            FRAME frST seCliCod seCliCod            
            FRAME frST cbRptList cbRptList
            FRAME frST fiAsdat fiAsdat
            FRAME frST raReportTyp raReportTyp
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
            FRAME frOutput rsOutput rsOutput
            FRAME frOutput cbPrtList cbPrtList

            n_branch   = fiBranch
            n_branch2  = fiBranch2
            n_frac     = fiAcno1
            n_toac     = fiAcno2 
            n_asdat    = fiasdat 
            vCliCod    = IF seCliCod:List-items = ? THEN vCliCodAll ELSE seCliCod:List-items
            n_OutputTo = rsOutput
            nv_typ1    = fityp1
            nv_typ2    = fityp2
            nv_typ3    = fityp3
            nv_typ4    = fityp4
            nv_typ5    = fityp5
            nv_typ6    = fityp6
            nv_typ7    = fityp7
            nv_typ8    = fityp8
            nv_typ9    = fityp9
            nv_typ10   = fityp10
            nv_typ11   = fityp11
            nv_typ12   = fityp12
            nv_typ13   = fityp13
            nv_typ14   = fityp14

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
            nv_trntyp1 = IF fityp14 <> "" THEN nv_trntyp1 + "," + fityp14 ELSE nv_trntyp1.


    ASSIGN  nv_filter1 = IF fityp1 <> "" THEN "(agtprm_fil.trntyp BEGINS '" + fityp1 + "') "  ELSE ""
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
            nv_filter1 = IF fityp14 <> "" THEN nv_filter1 + " OR (agtprm_fil.trntyp BEGINS '" + fityp14 + "') "  ELSE nv_filter1.

    ASSIGN  nv_filter2 = REPLACE(  vClicod,  ","  , "') OR (agtprm_fil.acno_clicod = '" )
            nv_filter2 = "(agtprm_fil.acno_clicod = '" + nv_filter2  + "')".


        
    IF  cbRptList = "Billing Report Motor" THEN n_type   = "Motor".
    ELSE IF cbRptList = "Billing Report Non-Motor" THEN n_type = "Non-Motor". 
    ELSE n_type = "All". 

   END.
   IF  n_frac = "" THEN  n_frac   = "A000000".
   IF  n_toac = "" THEN n_toac = "B999999".

   IF ( n_branch > n_branch2)   THEN DO:
         Message "ข้อมูลรหัสสาขาผิดพลาด" SKIP
                          "รหัสสาขาเริ่มต้นต้องมากกว่ารหัสสุดท้าย" VIEW-AS ALERT-BOX WARNING . 
         Apply "Entry" To fibranch.
         RETURN NO-APPLY.
   END.
   IF ( n_frac > n_toac)   THEN DO:
         Message "ข้อมูลตัวแทนผิดพลาด" SKIP
                          "รหัสตัวแทนเริ่มต้นต้องมากกว่ารหัสสุดท้าย" VIEW-AS ALERT-BOX WARNING . 
         Apply "Entry" To fiacno1.
         RETURN NO-APPLY.
   END.
    IF fi_BuillDate = ? THEN DO:
       MESSAGE "กรุณาระบุข้อมูล Billing Date" SKIP
                VIEW-AS ALERT-BOX WARNING . 
       APPLY "Entry" TO fi_BuillDate.
       RETURN NO-APPLY.
    END.

    FIND FIRST dbtable WHERE dbtable.phyname = "form"  OR dbtable.phyname = "sicfn"
                                        NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL dbtable THEN DO:
      IF dbtable.phyname = "form" THEN DO:
             ASSIGN
                 /*nv_User  = "?"
                 nv_pwd = "?". Lukkana M. A55-0369 04/11/2012*/
                 nv_User  = ""  /*Lukkana M. A55-0369 04/11/2012*/
                 nv_pwd   = "". /*Lukkana M. A55-0369 04/11/2012*/
                 RB-DB-CONNECTION = dbtable.unixpara +  " -U " + nv_user + " -P " + nv_pwd.
      END.
      ELSE DO:
                 RB-DB-CONNECTION = dbtable.unixpara +  " -U " + n_user + " -P " + n_passwd.
      END.
    END.

    IF n_asdat = ?   THEN DO:
       MESSAGE "ไม่พบข้อมูล  กรุณาตรวจสอบการ Process ข้อมูล" VIEW-AS ALERT-BOX WARNING.
    END.
    ELSE DO:
        MESSAGE "สาขา                      : "  n_Branch " ถึง " n_Branch2 SKIP(1)
                            "ตัวแทน/นายหน้า  : "  n_frac " ถึง " n_toac  SKIP(1)
                            "ข้อมูลวันที่             : " STRING(n_asdat,"99/99/9999") SKIP(1)
                            "Include Type       : " nv_trntyp1 SKIP(1)
                            "พิมพ์รายงาน        : " cbRptList VIEW-AS ALERT-BOX QUESTION
        BUTTONS YES-NO
        TITLE "Confirm"    UPDATE CHOICE AS LOGICAL.
        CASE CHOICE:
        WHEN TRUE THEN    DO:
            ASSIGN
                    nv_User   =   n_user
                    nv_pwd    =   n_passwd
              report-name     =  cbRptList.

            vFirstTime =  STRING(TIME, "HH:MM AM").

            RUN pdOutput.

                DISP "" @ fiProcess WITH FRAME  frST.
                    vLastTime =  STRING(TIME, "HH:MM AM").

            MESSAGE "As of Date     : " STRING(n_asdat,"99/99/9999")  SKIP (1)
                   "ตัวแทน          : "  n_frac " ถึง " n_toac SKIP (1)
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
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buAcno1 wacr007
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
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buAcno2 wacr007
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


&Scoped-define SELF-NAME buAdd
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buAdd wacr007
ON CHOOSE OF buAdd IN FRAME frST /* Add */
DO:
DEF VAR vChkFirstAdd AS INT.

    vCliCod = seCliCod:List-items.        
    vChkFirstAdd = IF vCliCod = ? THEN 1 ELSE 0 .

/*---------------- Check Client Type code ------------------*/
    FIND FIRST sym100 USE-INDEX sym10001          WHERE
               sym100.tabcod = "U021"              AND
               sym100.itmcod = INPUT fiCcode1
         NO-LOCK NO-ERROR NO-WAIT.
    IF NOT AVAIL sym100 THEN DO:
       IF fiCcode1 <> "" THEN DO:
           MESSAGE "ข้อมูลผิดพลาด  กรุณาตรวจสอบ ! Client Code" VIEW-AS ALERT-BOX ERROR. 
           APPLY "ENTRY" TO fiCcode1.            
           RETURN NO-APPLY.
       END.
   END.

    IF fiCcode1 = ""  THEN DO:
        MESSAGE "ข้อมูลผิดพลาด  กรุณาตรวจสอบ ! " VIEW-AS ALERT-BOX ERROR.
        APPLY "ENTRY" TO fiCcode1.            
        RETURN NO-APPLY.
    END.
        
    IF vChkFirstAdd = 1 THEN DO:
        DO WITH FRAME  frST :
               ASSIGN  fiCcode1.
                    seCliCod:Add-first(fiCcode1).
                    seCliCod = seCliCod:SCREEN-VALUE .
        END.  
    END.
    ELSE DO:          /* เพิ่มข้อมูลต่อ */
   
        IF LookUp(fiCcode1,vCliCod) <> 0 THEN DO: 
              MESSAGE "ข้อมูลซ้ำ กรุณาตรวจสอบ ! " VIEW-AS ALERT-BOX ERROR.
              APPLY "ENTRY" TO fiCcode1.            
              RETURN NO-APPLY.
        END.
        ELSE DO:               /* ข้อมูลไม่ซ้ำเพิ่มได้  */
              DO WITH FRAME  frST :
                   ASSIGN  fiCcode1.
                        seCliCod:Add-first(fiCcode1).
                        seCliCod = seCliCod:SCREEN-VALUE .
              END.  
        END.

    END.
        
        APPLY "ENTRY" TO fiCcode1.    
        vCliCod = seCliCod:List-items.    

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buBranch
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buBranch wacr007
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
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buBranch2 wacr007
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


&Scoped-define SELF-NAME buClicod
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buClicod wacr007
ON CHOOSE OF buClicod IN FRAME frST /* ... */
DO:
  
  RUN Whp\WhpClico( input-output n_itmdes).
  
  Assign    
        fiCcode1 = n_itmcod.
        
  Disp fiCcode1 with Frame {&Frame-Name}      .
 
  Return NO-APPLY.

/*     
/* input-output  n_tabcod,input-output n_itmcod, */
n_itmdes   = n_itmdes.
*/
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buDel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buDel wacr007
ON CHOOSE OF buDel IN FRAME frST /* Delete */
DO:
    DO WITH FRAME  frST :
        ASSIGN   seCliCod.
               seCliCod:Delete(seCliCod).
               seCliCod = seCliCod:SCREEN-VALUE .
    END.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME cbRptList
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cbRptList wacr007
ON RETURN OF cbRptList IN FRAME frST
DO:
    APPLY "ENTRY" TO fiTyp1 IN FRAME frST.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiacno1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiacno1 wacr007
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


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiacno1 wacr007
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
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiacno2 wacr007
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


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiacno2 wacr007
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


&Scoped-define SELF-NAME fiBranch
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiBranch wacr007
ON LEAVE OF fiBranch IN FRAME frST
DO:
  Assign
         fibranch = input fibranch
         n_branch = fibranch.

    DISP CAPS(fibranch) @ fibranch WITH FRAME frST.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiBranch wacr007
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
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiBranch2 wacr007
ON LEAVE OF fiBranch2 IN FRAME frST
DO:
     Assign
         fibranch2 = input fibranch2
         n_branch2  = fibranch2.
    DISP CAPS(fibranch2)@ fibranch2 WITH FRAME frST.         
             
     Apply "Entry" To fiAcno1.           
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiBranch2 wacr007
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


&Scoped-define SELF-NAME fiCcode1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiCcode1 wacr007
ON LEAVE OF fiCcode1 IN FRAME frST
DO:
    ASSIGN fiCcode1.
    DISP CAPS (fiCcode1) @ fiCcode1 WITH FRAME frST.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiTyp1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiTyp1 wacr007
ON LEAVE OF fiTyp1 IN FRAME frST
DO:
    fiTyp1 = CAPS(INPUT fiTyp1).
    DISP fiTyp1 WITH FRAME frST.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiTyp10
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiTyp10 wacr007
ON LEAVE OF fiTyp10 IN FRAME frST
DO:
    fiTyp10 = CAPS(INPUT fiTyp10).
    DISP fiTyp10 WITH FRAME frST.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiTyp11
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiTyp11 wacr007
ON LEAVE OF fiTyp11 IN FRAME frST
DO:
    fiTyp11 = CAPS(INPUT fiTyp11).
    DISP fiTyp11 WITH FRAME frST.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiTyp12
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiTyp12 wacr007
ON LEAVE OF fiTyp12 IN FRAME frST
DO:
    fiTyp12 = CAPS(INPUT fiTyp12).
    DISP fiTyp12 WITH FRAME frST.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiTyp13
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiTyp13 wacr007
ON LEAVE OF fiTyp13 IN FRAME frST
DO:
    fiTyp13 = CAPS(INPUT fiTyp13).
    DISP fiTyp13 WITH FRAME frST.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiTyp14
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiTyp14 wacr007
ON LEAVE OF fiTyp14 IN FRAME frST
DO:
    fiTyp14 = CAPS(INPUT fiTyp14).
    DISP fiTyp14 WITH FRAME frST.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiTyp2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiTyp2 wacr007
ON LEAVE OF fiTyp2 IN FRAME frST
DO:
    fiTyp2 = CAPS(INPUT fiTyp2).
    DISP fiTyp2 WITH FRAME frST.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiTyp3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiTyp3 wacr007
ON LEAVE OF fiTyp3 IN FRAME frST
DO:
    fiTyp3 = CAPS(INPUT fiTyp3).
    DISP fiTyp3 WITH FRAME frST.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiTyp4
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiTyp4 wacr007
ON LEAVE OF fiTyp4 IN FRAME frST
DO:
    fiTyp4 = CAPS(INPUT fiTyp4).
    DISP fiTyp4 WITH FRAME frST.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiTyp5
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiTyp5 wacr007
ON LEAVE OF fiTyp5 IN FRAME frST
DO:
    fiTyp5 = CAPS(INPUT fiTyp5).
    DISP fiTyp5 WITH FRAME frST.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiTyp6
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiTyp6 wacr007
ON LEAVE OF fiTyp6 IN FRAME frST
DO:
    fiTyp6 = CAPS(INPUT fiTyp6).
    DISP fiTyp6 WITH FRAME frST.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiTyp7
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiTyp7 wacr007
ON LEAVE OF fiTyp7 IN FRAME frST
DO:
    fiTyp7 = CAPS(INPUT fiTyp7).
    DISP fiTyp7 WITH FRAME frST.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiTyp8
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiTyp8 wacr007
ON LEAVE OF fiTyp8 IN FRAME frST
DO:
    fiTyp8 = CAPS(INPUT fiTyp8).
    DISP fiTyp8 WITH FRAME frST.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiTyp9
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiTyp9 wacr007
ON LEAVE OF fiTyp9 IN FRAME frST
DO:
    fiTyp9 = CAPS(INPUT fiTyp9).
    DISP fiTyp9 WITH FRAME frST.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_BuillDate
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_BuillDate wacr007
ON LEAVE OF fi_BuillDate IN FRAME frST /* Fill 1 */
DO:
  fi_builldate =  INPUT fi_builldate.

  /*---Comment by  Amparat c. A55-0216  
  APPLY "ENTRY" TO btn_ok IN FRAME frOK.
  RETURN NO-APPLY.
  ------------*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_Tax
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_Tax wacr007
ON LEAVE OF fi_Tax IN FRAME frST
DO:
  /*--Amparat c. A55-0216---*/
  fi_Tax = INPUT fi_Tax.
  IF fi_tax < 5 OR fi_tax > 30 THEN DO:
     MESSAGE  "List Box  fix ค่าตั้งแต่ 5 - 30 " VIEW-AS ALERT-BOX WARNING.
     RETURN NO-APPLY.
  END.

  APPLY "ENTRY" TO btn_ok IN FRAME frOK.
  RETURN NO-APPLY.

  /*--Amparat c. A55-0216---*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME raReportTyp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL raReportTyp wacr007
ON RETURN OF raReportTyp IN FRAME frST
DO:
      APPLY "ENTRY" TO seClicod IN FRAME frST.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL raReportTyp wacr007
ON VALUE-CHANGED OF raReportTyp IN FRAME frST
DO:
    raReportTyp = INPUT raReportTyp.
    
/*DO WITH FRAME frST:
 * /*    seClicod:IS-SELECTED(seClicod).*/
 *     seCliCod:Delete(seClicod).
 *     seCliCod = seCliCod:SCREEN-VALUE .
 * END.*/

    RUN pdClicod.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frOutput
&Scoped-define SELF-NAME rsOutput
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL rsOutput wacr007
ON VALUE-CHANGED OF rsOutput IN FRAME frOutput
DO:
  ASSIGN {&SELF-NAME}.
  
  CASE rsOutput:
        WHEN 1 THEN  /* Screen */
          ASSIGN
            cbPrtList:SENSITIVE   = No.
            /*fiFile-Name:SENSITIVE = No
            fiFile-Name2:SENSITIVE = No

            fiFile-Name = ""
            fiFile-Name2 = "".*/
        WHEN 2 THEN  /* Printer */
          ASSIGN
            cbPrtList:SENSITIVE   = Yes.
            /*fiFile-Name:SENSITIVE = No
            fiFile-Name2:SENSITIVE = No

            fiFile-Name = ""
            fiFile-Name2 = "".*/

       /* WHEN 3 THEN  /* File */ 
        DO:
          ASSIGN
            cbPrtList:SENSITIVE   = No
            fiFile-Name:SENSITIVE = Yes
            fiFile-Name2:SENSITIVE = No

            fiFile-Name2 = "".
          APPLY "ENTRY" TO fiFile-Name.
        END.
        WHEN 4 THEN  /* File */ 
        DO:
          ASSIGN
            cbPrtList:SENSITIVE   = No
            fiFile-Name:SENSITIVE = No
            fiFile-Name2:SENSITIVE = Yes
            
            fiFile-Name = "". 
          APPLY "ENTRY" TO fiFile-Name2.
        END.*/
        
  END CASE.

        /*DISP fiFile-Name fiFile-Name2  WITH FRAME frOutput.*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frST
&Scoped-define SELF-NAME rs_billing
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL rs_billing wacr007
ON VALUE-CHANGED OF rs_billing IN FRAME frST
DO:
  rs_billing = INPUT rs_billing .

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME DEFAULT-FRAME
&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK wacr007 


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
  DEF  VAR  gv_prgid   AS   CHAR  FORMAT "X(8)"   NO-UNDO.
  DEF  VAR  gv_prog    AS   CHAR  FORMAT "X(40)" NO-UNDO.
  
  gv_prgid = "WACR007".
  gv_prog  = "BILLING REPORT   [CBC]".
  RUN  WUT\WUTHEAD (WACR007:HANDLE,gv_prgid,gv_prog).
  RUN  WUT\WUTWICEN (WACR007:HANDLE).        
  SESSION:DATA-ENTRY-RETURN   = YES.
/*********************************************************************/   
  SESSION:DATA-ENTRY-RETURN = YES.
  
    DO WITH FRAME frST :           
        APPLY "ENTRY" TO fiBranch IN FRAME frST.
        ASSIGN   
            
          fiacno1    = ""
          fiacno2    = ""
          fiAsdat  = ?
          raReportTyp = 1
          fiInclude =  nv_Trntyp1
          fityp1 = "M"
          fityp2 = "R"
          fityp3 = "A"
          fityp4 = "B"
          fityp5 = ""
          rsOutput = 1
          rs_billing = 1.
          /*rsType = 1.*/

        DISPLAY  fiacno1 fiacno2 fiasdat raReportTyp
                  fiInclude fityp1 fityp2 fityp3 fityp4 fityp5 .

        RUN ProcGetRptList.
        RUN ProcGetPrtList.
        RUN pdInitData.  
        RUN pdSym100.
        RUN pdUpdateQ.
        RUN pdClicod.
    END.    

    cbPrtList:SENSITIVE    =  NO.
    DISPLAY rsOutput WITH FRAME frOutput .        

    APPLY "VALUE-CHANGED" TO brAcproc_fil IN FRAME FRST.   

    IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI wacr007  _DEFAULT-DISABLE
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
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(wacr007)
  THEN DELETE WIDGET wacr007.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI wacr007  _DEFAULT-ENABLE
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
  VIEW FRAME DEFAULT-FRAME IN WINDOW wacr007.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  ENABLE RECT-604 
      WITH FRAME frMain IN WINDOW wacr007.
  {&OPEN-BROWSERS-IN-QUERY-frMain}
  DISPLAY rs_billing fiBranch fiBranch2 fiacno1 fiacno2 raReportTyp fiTyp1 
          fiTyp2 fiTyp3 fiTyp4 fiTyp5 fiTyp6 fiTyp7 fiTyp8 fiTyp9 fiTyp10 
          fiTyp11 fiTyp12 fiTyp13 fiTyp14 seCliCod fiCcode1 cbRptList 
          fi_BuillDate fi_Tax fibdes fibdes2 finame1 finame2 fiInclude fiAsdat 
          fiProcessDate fiProcess 
      WITH FRAME frST IN WINDOW wacr007.
  ENABLE rs_billing fiBranch fiBranch2 fiacno1 fiacno2 raReportTyp fiTyp1 
         fiTyp2 fiTyp3 fiTyp4 fiTyp5 fiTyp6 fiTyp7 fiTyp8 fiTyp9 fiTyp10 
         fiTyp11 fiTyp12 fiTyp13 fiTyp14 buBranch buBranch2 seCliCod buAcno1 
         buAcno2 fiCcode1 buClicod cbRptList brAcproc_fil fi_BuillDate fi_Tax 
         fibdes buAdd buDel fibdes2 finame1 finame2 fiInclude fiAsdat 
         fiProcessDate fiProcess RECT-101 RECT-102 RECT-104 RECT-105 RECT-106 
         RECT-107 RECT12 RECT-602 RECT-603 RECT-108 RECT-109 RECT-112 RECT-113 
         RECT-114 RECT-115 
      WITH FRAME frST IN WINDOW wacr007.
  {&OPEN-BROWSERS-IN-QUERY-frST}
  DISPLAY rsOutput cbPrtList 
      WITH FRAME frOutput IN WINDOW wacr007.
  ENABLE rsOutput cbPrtList 
      WITH FRAME frOutput IN WINDOW wacr007.
  {&OPEN-BROWSERS-IN-QUERY-frOutput}
  ENABLE RECT-600 RECT-601 Btn_OK Btn_Cancel 
      WITH FRAME frOK IN WINDOW wacr007.
  {&OPEN-BROWSERS-IN-QUERY-frOK}
  VIEW wacr007.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDCheckDate wacr007 
PROCEDURE PDCheckDate :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN FRAME frST fi_BuillDate.
       
nv_duedat = fi_BuillDate.

IF DAY(nv_duedat) >= 16 THEN DO:
   IF MONTH(nv_duedat) = 2  THEN DO:
      nv_duedate  =  MONTH(nv_duedat) - 1.
      nv_duedate1 = "31" + "/" + STRING(nv_duedate,"99") +  "/" + STRING(YEAR(nv_duedat),"9999").
      nv_cdate  = nv_duedate1.
      nv_pdate  = "15" + "/" + STRING(MONTH(nv_duedat),"99") + "/" + STRING(YEAR(nv_duedat),"9999").
   END.
   ELSE DO:
    IF MONTH(nv_duedat)  = 1 THEN DO:
       nv_duedate  =  YEAR(nv_duedat) - 1.
       nv_duedate1 = "31" + "/" + "12" +  "/" + STRING(nv_duedate,"9999").       
       nv_Cdate  = nv_duedate1.
       nv_Pdate  = "15" + "/" + STRING(MONTH(nv_duedat),"99") + "/" + STRING(YEAR(nv_duedat),"9999").
    END.
    ELSE DO:            
           n_month = MONTH(nv_duedat) - 1 .
        IF n_month = 1 OR n_month = 3 OR
           n_month = 5 OR n_month = 7 OR
           n_month = 8 OR n_month = 10 OR
           n_month = 12  THEN DO:
           ASSIGN nv_dueday = "31".    
        END.
        ELSE DO:
            IF n_month <> 2 THEN ASSIGN nv_dueday = "30".            
            IF n_month = 2  THEN DO:
               nv_duedate = DAY(DATE(3, 1, YEAR(nv_duedat)) - 1).
               nv_duedate1  = STRING(nv_duedate) + "/" +  STRING(n_month,"99") + "/" + STRING(YEAR(nv_duedat),"9999").               
               nv_dueday = STRING(nv_duedate).
            END. 
        END.        
        nv_cdate  = STRING(nv_dueday,"99") + "/" + STRING(n_month,"99") + "/" + STRING(YEAR(nv_duedat),"9999").
        nv_Pdate  = "15" + "/" + STRING(MONTH(nv_duedat),"99") + "/" + STRING(YEAR(nv_duedat),"9999").
    END.
   END.    
END.
ELSE DO:
    IF MONTH(nv_duedat) = 1 THEN DO:
       nv_duedate  = YEAR(nv_duedat) - 1.
       nv_duedate1 = "31" + "/" + "12" +  "/" + STRING(nv_duedate,"9999").       
       nv_Pdate    = nv_duedate1.
       nv_Cdate    = "15" + "/" + "12" +  "/"  + STRING(nv_duedate,"9999"). 
    END.
    ELSE DO:
           n_month = MONTH(nv_duedat) - 1.
        IF n_month = 1 OR n_month = 3 OR
           n_month = 5 OR n_month = 7 OR
           n_month = 8 OR n_month = 10 OR
           n_month = 12  THEN DO:
           ASSIGN nv_dueday = "31".
        END.
        ELSE DO:
           IF n_month <> 2 THEN ASSIGN nv_dueday = "30".
           IF n_month = 2  THEN DO:
               nv_duedate = DAY(DATE(3, 1, YEAR(nv_duedat)) - 1).
               nv_duedate1  = STRING(nv_duedate) + "/" +  STRING(n_month,"99") + "/" + STRING(YEAR(nv_duedat),"9999").               
               nv_dueday = STRING(nv_duedate).
            END. 
        END.
       nv_pdate  = STRING(nv_dueday,"99") + "/" + STRING(n_month,"99") + "/" + STRING(YEAR(nv_duedat),"9999").
       nv_cdate  = "15" + "/" + STRING(n_month,"99") + "/" + STRING(YEAR(nv_duedat),"9999").
    END.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdClicod wacr007 
PROCEDURE pdClicod :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR  i AS INT INIT 1.

DO WITH FRAME frST:
        seCliCod:DELETE("AG,AM,BD,BM,BR,PS,RS,ST,DI,DE,FI,FN,OT,LS,").
        seCliCod = seCliCod:SCREEN-VALUE .

    IF raReportTyp = 1 THEN DO:
        vClicod = "AG,AM,BD,BM,BR,PS,RS,ST,OT".
        seCliCod:ADD-FIRST(vClicod).
        seCliCod = seCliCod:SCREEN-VALUE .
    END.
    ELSE IF raReportTyp = 2 THEN DO:
        vClicod = "FI,FN,DE".
        seCliCod:ADD-FIRST(vClicod).
        seCliCod = seCliCod:SCREEN-VALUE .
    END.
    ELSE IF raReportTyp = 3 THEN DO:
        vClicod = "DI".
        seCliCod:ADD-FIRST(vClicod).
        seCliCod = seCliCod:SCREEN-VALUE .
    END.
    ELSE DO:
        vClicod = "AG,AM,BD,BM,BR,PS,RS,ST,DI,DE,FI,FN,OT,LS".
        seCliCod:ADD-FIRST(vClicod).
        seCliCod = seCliCod:SCREEN-VALUE .
    END.

END. /**/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdDeptGrp wacr007 
PROCEDURE pdDeptGrp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN nv_dir = ""
       nv_polgrp = ""
       nv_grptypdes = ""
       nv_insref = "".

FIND FIRST xmm031 WHERE xmm031.poltyp = agtprm_fil.poltyp NO-LOCK NO-ERROR.
IF AVAIL xmm031 THEN DO:

   IF xmm031.dept = "G" THEN DO:   /*Motor*/
      nv_polgrp = "MOT".

      FIND FIRST acm001 USE-INDEX acm00101 WHERE 
                 acm001.trnty1 = SUBSTR(agtprm_fil.trntyp,1,1) AND
                 acm001.docno  = agtprm_fil.docno NO-LOCK NO-ERROR.
      IF AVAIL acm001 THEN DO:
   
         IF SUBSTR((acm001.insref),2,1) = "C" OR 
            SUBSTR((acm001.insref),3,1) = "C" THEN
            nv_insref = "C".   /*Customer Type = Corperate */
         ELSE nv_insref = "P".   /*Customer Type = Personal */

         FIND FIRST xmm600 USE-INDEX xmm60001      WHERE 
                   xmm600.acno   =  acm001.agent  NO-LOCK  NO-ERROR  NO-WAIT.
         IF NOT AVAIL xmm600 THEN NEXT.
         ELSE DO:
            /*--- -- Aging Day ---*/
              IF xmm600.autoap = YES THEN DO:     /* -- Direct */
        
                 IF nv_insref = "P" THEN 
                     ASSIGN  nv_dir = "DiP"   /* CBC------------*/
                             nv_grptypdes = "บุคคลธรรมดา".
                 ELSE  ASSIGN nv_dir = "DiC"         /* ---------*/
                              nv_grptypdes = "นิติบุคคล".
                 
              END.
              ELSE DO:              /* -- Broker */
                  IF nv_insref = "P" THEN 
                     ASSIGN nv_dir = "BrP"   /* -----------*/
                            nv_grptypdes = "บุคคลธรรมดา".
                  ELSE ASSIGN nv_dir = "BrC"     /* ---------*/    
                               nv_grptypdes = "นิติบุคคล".
              END.
             
         END.   /*end find first*/

      END.  /*end acm001*/

      nv_polgrp = nv_polgrp + nv_dir.

   END.   /* end xmm031.dept = "G" - Motor */
   ELSE IF xmm031.dept = "M" THEN DO:       /*Compulsory*/
      ASSIGN nv_polgrp = "CMP"
             nv_dir    = "CMP"
             nv_polgrp = nv_polgrp + nv_dir
             nv_grptypdes = "Compulsory". 
   END.
   ELSE DO:   /*Non-Motor*/
       ASSIGN nv_dir = "NON"
              nv_polgrp = "NON" 
              nv_polgrp = nv_polgrp + nv_dir
              nv_grptypdes = "Non Motor".   
   END.
    
END.   /* end xmm031*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdExportF1 wacr007 
PROCEDURE pdExportF1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*
DEF VAR  vCount AS INT INIT 0.
DEF VAR  i AS INT.

    ASSIGN
        nv_gtot_prem  = 0
        nv_gtot_prem_comp = 0
        nv_gtot_stamp = 0
        nv_gtot_tax   = 0
        nv_gtot_gross = 0
        nv_gtot_comm  = 0
        nv_gtot_comm_comp = 0
        nv_gtot_net   = 0
        nv_gtot_bal   = 0
        nv_gtot_wcr   = 0
        nv_gtot_damt  = 0
        nv_gtot_odue1 = 0
        nv_gtot_odue2 = 0
        nv_gtot_odue3 = 0
        nv_gtot_odue4 = 0
        nv_gtot_odue5 = 0.
        
        IF rsOutput = 3 THEN fiFile-Name = fiFile-Name.
                        ELSE fiFile-Name = fiFile-Name2.
        
/********************** Page Header *********************/           
        OUTPUT TO VALUE (STRING(fiFile-Name) ) NO-ECHO.
            IF vCount = 0 THEN DO:
/*---A48-0250
                EXPORT DELIMITER ";"
                    "asdate"
                    n_asdat
                    ""
                    "wacr02.w - " + report-name + " to excel file - FN"  /* "Statement A4 Reports By Acno"  */
                    "" "" "" "" ""
                    "Acno : " + n_frac + " - " + n_toac
                    "" ""
                    "Br. : " + n_branch + " - " + n_branch2
                    "Include Type : " +  nv_trntyp1
                    "" ""
                    "Client Type Code : " + vCliCod
                    .
                EXPORT DELIMITER ";"
                     "Account No."  " name  " "credit"  "Tran Date" "duedate" " Invoice No."  " Policy No."  " Endt No."  "Com. Date "  " Insured Name "
                     " Premium  "  " Compulsory"  " Stamp"  "Tax"  "Total"  "Comm"  "Comm_comp"  "Net amount" "Balance (Baht)".
A48-0250---*/

            END.
        OUTPUT CLOSE.
/********************** END Page Header *********************/  

/********************** DETAIL  *********************/  
    IF raReportTyp = 1 OR  raReportTyp = 2 OR  raReportTyp = 3 THEN DO:     /* A47-0142   ดึงข้อมูล เฉพาะ บาง  client type code */
    
        IF report-name = "Statement of Account By Trandate" THEN DO :
            FOR EACH  agtprm_fil USE-INDEX by_acno            WHERE
                      agtprm_fil.asdat       = n_asdat   AND
                     (agtprm_fil.acno      >= n_frac    AND agtprm_fil.acno     <= n_toac  )      AND
                     (agtprm_fil.polbran >= n_branch AND agtprm_fil.polbran <= n_branch2 ) AND
                     ( LOOKUP (SUBSTRING(agtprm_fil.trntyp,1,1) , nv_trntyp1) <> 0 ) AND
                     ( LOOKUP (agtprm_fil.acno_clicod, vCliCod) <> 0 )
            NO-LOCK BREAK BY agtprm_fil.acno
                           BY agtprm_fil.trndat
                           BY agtprm_fil.policy
                           BY agtprm_fil.endno
                           BY agtprm_fil.docno . 
    
                DISP  /*agtprm_fil.acno-- A500178 --*/
                      agtprm_fil.acno   FORMAT "X(10)"
                      agtprm_fil.trndat
                      agtprm_fil.policy
                      agtprm_fil.trntyp
                      agtprm_fil.docno
                WITH COLOR BLACK/WHITE NO-LABEL FRAME frProcess11 VIEW-AS DIALOG-BOX
                TITLE  "  Processing ...".
    
                /*--A53-0159--*/
                FIND FIRST xmm031 USE-INDEX xmm03101 WHERE 
                xmm031.poltyp = agtprm_fil.poltyp NO-LOCK NO-ERROR.
                IF AVAIL xmm031 THEN DO:
                   IF rstype   = 1 THEN DO:   /*---Motor---*/
                      IF  xmm031.dept <> "G"  AND xmm031.dept <> "M"  THEN NEXT.
                   END.
                   ELSE IF rstype = 2 THEN DO:
                      IF  xmm031.dept = "G"  OR xmm031.dept = "M"  THEN NEXT.
                   END.
                END.
                /*-- end A53-0159 --*/

                {wac\wacr02f1.i}
    
            END. /* for each agtprm_fil*/

        END.  /*  By Trandate */
        ELSE DO: /* report-name = "Statement of Account By Policy" */
            FOR EACH  agtprm_fil USE-INDEX by_acno            WHERE
                      agtprm_fil.asdat    = n_asdat    AND
                     (agtprm_fil.acno    >= n_frac     AND agtprm_fil.acno    <= n_toac  )   AND
                     (agtprm_fil.polbran >= n_branch   AND agtprm_fil.polbran <= n_branch2 ) AND
                     ( LOOKUP (SUBSTRING(agtprm_fil.trntyp,1,1) , nv_trntyp1) <> 0 ) AND
                     ( LOOKUP (agtprm_fil.acno_clicod, vCliCod) <> 0 )
            NO-LOCK BREAK BY agtprm_fil.asdat
                           BY agtprm_fil.acno
                           BY agtprm_fil.poltyp
                           BY agtprm_fil.policy
                           BY agtprm_fil.endno. 
    
                DISP  /*agtprm_fil.acno-- A500178 --*/
                      agtprm_fil.acno   FORMAT "X(10)"
                      agtprm_fil.policy
                      agtprm_fil.trntyp
                      agtprm_fil.docno
                WITH COLOR BLACK/WHITE NO-LABEL FRAME frProcess11p VIEW-AS DIALOG-BOX
                TITLE  "  Processing ...".

                 /*--A53-0159--*/
                FIND FIRST xmm031 USE-INDEX xmm03101 WHERE 
                xmm031.poltyp = agtprm_fil.poltyp NO-LOCK NO-ERROR.
                IF AVAIL xmm031 THEN DO:
                   IF rstype   = 1 THEN DO:   /*---Motor---*/
                      IF  xmm031.dept <> "G"  AND xmm031.dept <> "M"  THEN NEXT.
                   END.
                   ELSE IF rstype = 2 THEN DO:
                      IF  xmm031.dept = "G"  OR xmm031.dept = "M"  THEN NEXT.
                   END.
                END.
                /*-- end A53-0159 --*/
    
                {wac\wacr02f1.i}
    
            END. /* for each agtprm_fil*/        
        END. /* By Policy */
        
    END.
    ELSE DO:     /* ดึงข้อมูล ทุก client type code */

        IF report-name = "Statement of Account By Trandate" THEN DO :
            FOR EACH  agtprm_fil USE-INDEX by_acno            WHERE
                      agtprm_fil.asdat    = n_asdat  AND
                     (agtprm_fil.acno    >= n_frac   AND agtprm_fil.acno    <= n_toac )    AND
                     (agtprm_fil.polbran >= n_branch AND agtprm_fil.polbran <= n_branch2 ) AND
                     ( LOOKUP (SUBSTRING(agtprm_fil.trntyp,1,1) , nv_trntyp1) <> 0 )
            NO-LOCK BREAK BY agtprm_fil.acno
                          BY agtprm_fil.trndat
                          BY agtprm_fil.policy
                          BY agtprm_fil.endno.
    
                DISP  /*agtprm_fil.acno-- A500178 --*/
                      agtprm_fil.acno   FORMAT "X(10)"
                      agtprm_fil.trndat
                      agtprm_fil.policy
                      agtprm_fil.trntyp
                      agtprm_fil.docno
                WITH COLOR BLACK/WHITE NO-LABEL FRAME frProcess12 VIEW-AS DIALOG-BOX
                TITLE  "  Processing ...".

                 /*--A53-0159--*/
                FIND FIRST xmm031 USE-INDEX xmm03101 WHERE 
                xmm031.poltyp = agtprm_fil.poltyp NO-LOCK NO-ERROR.
                IF AVAIL xmm031 THEN DO:
                   IF rstype   = 1 THEN DO:   /*---Motor---*/
                      IF  xmm031.dept <> "G"  AND xmm031.dept <> "M"  THEN NEXT.
                   END.
                   ELSE IF rstype = 2 THEN DO:
                      IF  xmm031.dept = "G"  OR xmm031.dept = "M"  THEN NEXT.
                   END.
                END.
                /*-- end A53-0159 --*/
    
                {wac\wacr02f1.i}

            END. /* for each agtprm_fil*/
        END.  /*  By Trandate */
        ELSE DO: /* report-name = "Statement of Account By Policy" */
            FOR EACH  agtprm_fil USE-INDEX by_acno            WHERE
                      agtprm_fil.asdat    = n_asdat  AND
                     (agtprm_fil.acno    >= n_frac   AND agtprm_fil.acno    <= n_toac  )   AND
                     (agtprm_fil.polbran >= n_branch AND agtprm_fil.polbran <= n_branch2 ) AND
                     ( LOOKUP (SUBSTRING(agtprm_fil.trntyp,1,1) , nv_trntyp1) <> 0 )
            NO-LOCK BREAK BY agtprm_fil.asdat
                          BY agtprm_fil.acno
                          BY agtprm_fil.poltyp
                          BY agtprm_fil.policy
                          BY agtprm_fil.endno. 

                DISP  /*agtprm_fil.acno-- A500178 --*/
                      agtprm_fil.acno   FORMAT "X(10)"
                      agtprm_fil.policy
                      agtprm_fil.trntyp
                      agtprm_fil.docno
                WITH COLOR BLACK/WHITE NO-LABEL FRAME frProcess12p VIEW-AS DIALOG-BOX
                TITLE  "  Processing ...".

                /*--A53-0159--*/
                FIND FIRST xmm031 USE-INDEX xmm03101 WHERE 
                xmm031.poltyp = agtprm_fil.poltyp NO-LOCK NO-ERROR.
                IF AVAIL xmm031 THEN DO:
                   IF rstype   = 1 THEN DO:   /*---Motor---*/
                      IF  xmm031.dept <> "G"  AND xmm031.dept <> "M"  THEN NEXT.
                   END.
                   ELSE IF rstype = 2 THEN DO:
                      IF  xmm031.dept = "G"  OR xmm031.dept = "M"  THEN NEXT.
                   END.
                END.
                /*-- end A53-0159 --*/
    
                {wac\wacr02f1.i}

            END. /* for each agtprm_fil*/

        END. /* By Policy */
            
    END.
/********************** END DETAIL  *********************/

/********************** Page Footer *********************/
        OUTPUT TO VALUE (STRING(fiFile-Name) ) APPEND NO-ECHO.
                EXPORT DELIMITER ";"
                    "".
                EXPORT DELIMITER ";"
                    "GRAND TOTAL : "
                    " "    " "   " "     " " 
                    " "    " "   " "   " "
                    ""  ""
                    nv_gtot_prem
                    nv_gtot_prem_comp
                    nv_gtot_stamp
                    nv_gtot_tax
                    nv_gtot_gross
                    nv_gtot_comm
                    nv_gtot_comm_comp
                    nv_gtot_net
                    nv_gtot_bal.

        OUTPUT CLOSE.
/********************** Page Footer *********************/
                  */
END PROCEDURE.

/***
    EXPORT DELIMITER ";"
        "รหัสตัวแทน"    "ชื่อ" "เครดิต" "วันที่  " "วันครบกำหนด" "เลขที่ใบแจ้งหนี้ " "กรมธรรม์" "สลักหลัง" "วันเริ่มคุ้มครอง"  "ชื่อผู้เอาประกัน "
        "เบี้ยประกัน"  "พ.ร.บ. "   "อากร"  "ภาษี"   "ยอดรวม"  "ค่านายหน้า"  "ค่านายหน้า พรบ." "ยอดรวม หัก ค่านายหน้า(รวม)" "ยอดค้างชำระ".  
***/

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdExportF2 wacr007 
PROCEDURE pdExportF2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*
DEF VAR  vCount AS INT INIT 0.
DEF VAR  i AS INT.

    ASSIGN
        nv_gtot_prem    = 0
        nv_gtot_prem_comp = 0
        nv_gtot_stamp   = 0
        nv_gtot_tax     = 0
        nv_gtot_gross   = 0
        nv_gtot_comm    = 0
        nv_gtot_comm_comp = 0
        nv_gtot_net     = 0
        nv_gtot_bal     = 0
        
        nv_gtot_wcr     = 0
        nv_gtot_damt    = 0
        nv_gtot_odue    = 0
        
        nv_gtot_odue1   = 0
        nv_gtot_odue2   = 0
        nv_gtot_odue3   = 0
        nv_gtot_odue4   = 0
        nv_gtot_odue5   = 0.
        
        IF rsOutput = 3 THEN fiFile-Name = fiFile-Name.
                         ELSE fiFile-Name = fiFile-Name2.
        
/********************** Page Header *********************/    
        OUTPUT TO VALUE (STRING(fiFile-Name) ) NO-ECHO.
            IF vCount = 0 THEN DO:
/*---A48-0250
                EXPORT DELIMITER ";"
                    "asdate"
                    n_asdat
                    "wacr02.w - " + report-name + " to excel file - FN"  /* "Statement A4 Reports By Acno"  */
                    "" "" "" "" ""
                    "Acno : " + n_frac + " - " + n_toac
                    "" ""
                    "Br. : " + n_branch + " - " + n_branch2
                    "Include Type : " +  nv_trntyp1
                    "" ""
                    "Client Type Code : " + vCliCod
                    .

                EXPORT DELIMITER ";"
                     "Account No." "Name" "Branch"  "credit"  "Tran Date" "duedate" " Invoice No."  " Policy No."  " Endt No."  "Com. Date " "Exp. Date"  " Insured Name "  
                     " Premium  "  " Compulsory"  " Stamp"  "Tax"  "Total"  "Comm"  "Comm_comp" "Net amount"  "Balance (Baht)"
                     "Campaign Pol."  "Dealer" "Vehicle Reg." "Chassis No." "Model Desc" "Sticker No." "Lesing No."  "Print VAT"
                     " within"  "due amount "  "overdue"  "1 - 3 months"  "3 - 6 months"  "6 - 9 months"  " 9 - 12 months"  "over 12 months". 
A48-0250 END ---*/

            END.
        OUTPUT CLOSE.
/********************** END Page Header *********************/  

/********************** DETAIL  *********************/  
    IF raReportTyp = 1 OR  raReportTyp = 2 OR  raReportTyp = 3 THEN DO:     /* A47-0142   ดึงข้อมูล เฉพาะ บาง  client type code */

        IF report-name = "Statement of Account By Trandate" THEN DO :
            
            FOR EACH  agtprm_fil USE-INDEX by_acno            WHERE
                      agtprm_fil.asdat    = n_asdat  AND
                     (agtprm_fil.acno    >= n_frac   AND agtprm_fil.acno    <= n_toac  )   AND
                     (agtprm_fil.polbran >= n_branch AND agtprm_fil.polbran <= n_branch2 ) AND
                     ( LOOKUP (SUBSTRING(agtprm_fil.trntyp,1,1) , nv_trntyp1) <> 0 ) AND
                     ( LOOKUP (agtprm_fil.acno_clicod, vCliCod) <> 0 )
                    NO-LOCK BREAK BY agtprm_fil.acno
                                  BY agtprm_fil.trndat
                                  BY agtprm_fil.poltyp  /*--A53-0159--*/
                                  BY agtprm_fil.policy
                                  BY agtprm_fil.endno
                                  BY agtprm_fil.docno.
    
                DISP  /*agtprm_fil.acno-- A500178 --*/
                      agtprm_fil.acno   FORMAT "X(10)"
                      agtprm_fil.trndat
                      agtprm_fil.policy
                      agtprm_fil.trntyp
                      agtprm_fil.docno
                WITH COLOR BLACK/WHITE NO-LABEL FRAME frProcess21 VIEW-AS DIALOG-BOX
                TITLE  "  Processing ...".


                /*--A53-0159--*/
                FIND FIRST xmm031 USE-INDEX xmm03101 WHERE 
                xmm031.poltyp = agtprm_fil.poltyp NO-LOCK NO-ERROR.
                IF AVAIL xmm031 THEN DO:
                   IF rstype   = 1 THEN DO:   /*---Motor---*/
                      IF  xmm031.dept <> "G"  AND xmm031.dept <> "M"  THEN NEXT.
                   END.
                   ELSE IF rstype = 2 THEN DO:
                      IF  xmm031.dept = "G"  OR xmm031.dept = "M"  THEN NEXT.
                   END.
                END.
                /*-- end A53-0159 --*/

                 {wac\wacr02f2.i}
    
            END. /* for each agtprm_fil*/
        END.  /*  By Trandate */
        ELSE DO: /* report-name = "Statement of Account By Policy" */
            FOR EACH  agtprm_fil USE-INDEX by_acno            WHERE
                      agtprm_fil.asdat   = n_asdat   AND
                     (agtprm_fil.acno    >= n_frac   AND agtprm_fil.acno    <= n_toac  )   AND
                     (agtprm_fil.polbran >= n_branch AND agtprm_fil.polbran <= n_branch2 ) AND
                     ( LOOKUP (SUBSTRING(agtprm_fil.trntyp,1,1) , nv_trntyp1) <> 0 ) AND
                     ( LOOKUP (agtprm_fil.acno_clicod, vCliCod) <> 0 )
            NO-LOCK BREAK BY agtprm_fil.asdat
                          BY agtprm_fil.acno
                          BY agtprm_fil.poltyp
                          BY agtprm_fil.policy
                          BY agtprm_fil.endno. 

                DISP  /*agtprm_fil.acno-- A500178 --*/
                      agtprm_fil.acno   FORMAT "X(10)"
                      agtprm_fil.policy
                      agtprm_fil.trntyp
                      agtprm_fil.docno
                WITH COLOR BLACK/WHITE NO-LABEL FRAME frProcess21p VIEW-AS DIALOG-BOX
                TITLE  "  Processing ...".

                 /*--A53-0159--*/
                FIND FIRST xmm031 USE-INDEX xmm03101 WHERE 
                           xmm031.poltyp = agtprm_fil.poltyp NO-LOCK NO-ERROR.
                IF AVAIL xmm031 THEN DO:
                   IF rstype   = 1 THEN DO:   /*---Motor---*/
                      IF  xmm031.dept <> "G"  AND xmm031.dept <> "M"  THEN NEXT.
                   END.
                   ELSE IF rstype = 2 THEN DO:
                      IF  xmm031.dept = "G"  OR xmm031.dept = "M"  THEN NEXT.
                   END.
                END.
                /*-- end A53-0159 --*/
    
                {wac\wacr02f2.i}
    
            END. /* for each agtprm_fil*/
        END. /* By Policy */
           
    END.
    ELSE DO:     /* ดึงข้อมูล ทุก client type code */

        IF report-name = "Statement of Account By Trandate" THEN DO :
            FOR EACH agtprm_fil USE-INDEX by_acno            WHERE
                     agtprm_fil.asdat   = n_asdat   AND 
                    (agtprm_fil.acno    >= n_frac   AND agtprm_fil.acno    <= n_toac  )   AND
                    (agtprm_fil.polbran >= n_branch AND agtprm_fil.polbran <= n_branch2 ) AND
                    ( LOOKUP (SUBSTRING(agtprm_fil.trntyp,1,1) , nv_trntyp1) <> 0 )
                    NO-LOCK BREAK BY agtprm_fil.acno
                                  BY agtprm_fil.trndat
                                  BY agtprm_fil.policy
                                  BY agtprm_fil.endno.
    
                DISP  /*agtprm_fil.acno-- A500178 --*/
                      agtprm_fil.acno   FORMAT "X(10)"
                      agtprm_fil.trndat
                      agtprm_fil.policy
                      agtprm_fil.trntyp
                      agtprm_fil.docno
                WITH COLOR BLACK/WHITE NO-LABEL FRAME frProcess22 VIEW-AS DIALOG-BOX
                TITLE  "  Processing ...".

                 /*--A53-0159--*/
                FIND FIRST xmm031 USE-INDEX xmm03101 WHERE 
                xmm031.poltyp = agtprm_fil.poltyp NO-LOCK NO-ERROR.
                IF AVAIL xmm031 THEN DO:
                   IF rstype   = 1 THEN DO:   /*---Motor---*/
                      IF  xmm031.dept <> "G"  AND xmm031.dept <> "M"  THEN NEXT.
                   END.
                   ELSE IF rstype = 2 THEN DO:
                      IF  xmm031.dept = "G"  OR xmm031.dept = "M"  THEN NEXT.
                   END.
                END.
                /*-- end A53-0159 --*/
    
                {wac\wacr02f2.i}
    
            END. /* for each agtprm_fil*/

        END.  /*  By Trandate */
        ELSE DO: /* report-name = "Statement of Account By Policy" */

            FOR EACH  agtprm_fil USE-INDEX by_acno            WHERE
                      agtprm_fil.asdat   = n_asdat   AND
                     (agtprm_fil.acno    >= n_frac   AND agtprm_fil.acno    <= n_toac  )   AND
                     (agtprm_fil.polbran >= n_branch AND agtprm_fil.polbran <= n_branch2 ) AND
                     ( LOOKUP (SUBSTRING(agtprm_fil.trntyp,1,1) , nv_trntyp1) <> 0 )
                        NO-LOCK BREAK BY agtprm_fil.asdat
                                      BY agtprm_fil.acno
                                      BY agtprm_fil.poltyp
                                      BY agtprm_fil.policy
                                      BY agtprm_fil.endno. 
    
                DISP  /*agtprm_fil.acno-- A500178 --*/
                      agtprm_fil.acno   FORMAT "X(10)"
                      agtprm_fil.policy
                      agtprm_fil.trntyp
                      agtprm_fil.docno
                WITH COLOR BLACK/WHITE NO-LABEL FRAME frProcess22p VIEW-AS DIALOG-BOX
                TITLE  "  Processing ...".

                 /*--A53-0159--*/
                FIND FIRST xmm031 USE-INDEX xmm03101 WHERE 
                xmm031.poltyp = agtprm_fil.poltyp NO-LOCK NO-ERROR.
                IF AVAIL xmm031 THEN DO:
                   IF rstype   = 1 THEN DO:   /*---Motor---*/
                      IF  xmm031.dept <> "G"  AND xmm031.dept <> "M"  THEN NEXT.
                   END.
                   ELSE IF rstype = 2 THEN DO:
                      IF  xmm031.dept = "G"  OR xmm031.dept = "M"  THEN NEXT.
                   END.
                END.
                /*-- end A53-0159 --*/
    
                {wac\wacr02f2.i}
    
            END. /* for each agtprm_fil*/

        END. /* By Policy */

    END.

/********************** Page Footer *********************/
        OUTPUT TO VALUE (STRING(fiFile-Name) ) APPEND NO-ECHO.
                EXPORT DELIMITER ";"
                    "".        
/*---A48-0250
                EXPORT DELIMITER ";"
                    "GRAND TOTAL : "
                    " "    " "   " "   " "   " "
                    " "    " "    " "   " "   " "    " "
                    nv_gtot_prem
                    nv_gtot_prem_comp
                    nv_gtot_stamp
                    nv_gtot_tax
                    nv_gtot_gross
                    nv_gtot_comm
                    nv_gtot_comm_comp
                    nv_gtot_net
                    nv_gtot_bal
    
                    " "    " "    " "   " "   " "  " "  " "
                    " "   /* n_prnvat */
                    nv_gtot_wcr
                    nv_gtot_damt
                    nv_gtot_odue
                    nv_gtot_odue1
                    nv_gtot_odue2
                    nv_gtot_odue3
                    nv_gtot_odue4
                    nv_gtot_odue5.
A48-0250 END. ---*/


/*--- A48-0250 */
                EXPORT DELIMITER ";"
                    "GRAND TOTAL : "
                    ""  ""  ""  ""  ""
                    ""  ""   
                    nv_gtot_prem      
                    nv_gtot_prem_comp 
                    nv_gtot_stamp     
                    nv_gtot_tax       
                    nv_gtot_gross     
                    nv_gtot_comm + nv_gtot_comm_comp 
                    nv_gtot_net       
                    nv_gtot_bal       
                    ""  ""

                    ""  ""  ""  ""  ""  ""  ""  ""  ""  ""    
                    ""  ""  ""  ""  ""  ""  ""  ""  ""  ""

                    nv_gtot_wcr   
                    nv_gtot_damt  
                    nv_gtot_odue  

                    nv_gtot_odue1 
                    nv_gtot_odue2 
                    nv_gtot_odue3 
                    nv_gtot_odue4 
                    nv_gtot_odue5.
                    
/*A48-0250 END. ---*/


        OUTPUT CLOSE.
/********************** Page Footer *********************/
*/

END PROCEDURE.

/*
EXPORT DELIMITER ";"
    "A/C Branch"   "Producer"         "Producer name"  "Producer type"  "Credit Term"              /*1*/
    "Trans. Date"   "Due date"         "As date"              "Pol. Type"          "Policy"
    "Endt No."        "Com. Date"       "Exp Date"           "Tran. type"          "Doc.No"                     /*2*/
    "Campaign Pol" "Dealer"           "Agent"                "Customer"           "Premium"
    "Compulsory"  "Stamp"              "Tax"                    "Total"                  "Commission"              /*3*/
    "Comm."           "Comm_Comp"  "Net Amount"       "Balance O/S"    "Claim Paid"
    "O/S Claim"     "Vehicle Reg."  "Chassis No."   "Model Desc"      "Sticker No."                    /*4*/
    "Leasing No."  "Within"             "Due Amount"       "Over 1-3 months" "Over 3-6 months"
    "Over 6-9 months" "Over 9-12 months" "Over 12 months".                                                        /*5*/
    
    
    EXPORT DELIMITER ";"
        "รหัสตัวแทน" "ชื่อ" "สาขา" "เครดิต" "วันที่  " "วันครบกำหนด" "เลขที่ใบแจ้งหนี้ " "กรมธรรม์" "สลักหลัง" "วันเริ่มคุ้มครอง" "วันสิ้นสุดคุ้มครอง" "ชื่อผู้เอาประกัน "
        "เบี้ยประกัน"  "พ.ร.บ. "   "อากร"  "ภาษี"   "รวม"  "ค่านายหน้า"  "ค่านายหน้า พรบ."  "ยอดรวม หัก ค่านายหน้า(รวม)" "ยอดค้างชำระ"  
        "Campaign Pol."  "Dealer" "Vehicle Reg." "Chassis No." "Model Desc" "Sticker No." "Lesing No."  
        "ยอดไม่ครบกำหนด" "ครบกำหนด" "รวมยอดค้างชำระเกินกำหนด" "ค้าง 1-3 เดือน "  "ค้าง 3-6 เดือน"  "ค้าง 6-9 เดือน"   "ค้าง 9-12 เดือน"  "ค้าง เกิน 12 เดือน".
        /*"Group code" "Date A/C opened" "Date A/C closed".*/
*/

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdInitData wacr007 
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdOldOK wacr007 
PROCEDURE pdOldOK :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*

DEF VAR vAcno AS CHAR INIT "".

   DO WITH FRAME {&FRAME-NAME} :
        ASSIGN  
            FRAME frST fibranch fibranch
            FRAME frST fibranch2 fibranch2
            FRAME frST fiacno1 fiacno1
            FRAME frST fiacno2 fiacno2

            FRAME frST raY raY
            FRAME frST raZ raZ
            FRAME frST seCliCod seCliCod
            FRAME frST cbRptList cbRptList
            
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

            FRAME frOutput rsOutput rsOutput
            FRAME frOutput cbPrtList cbPrtList
            FRAME frOutput fiFile-Name fiFile-Name

            n_branch  = fiBranch
            n_branch2  = fiBranch2            
            n_frac       =  fiAcno1
            n_toac      =  fiAcno2 
            n_asdat    = fiasdat /*DATE( INPUT cbAsDat)       */     
            vCliCod    = IF seCliCod:List-items = ? THEN vCliCodAll ELSE seCliCod:List-items
            n_typ        =  IF raY = 1 THEN "" ELSE "Y"
            n_typ1      =  IF raZ = 1 THEN "" ELSE "Z"
            
            n_OutputTo    =  rsOutput
            n_OutputFile  =  fiFile-Name  .        
    
   END.
        
    FIND LAST AcProc_fil USE-INDEX by_type_asdat  
                        WHERE (AcProc_fil.type = "01" AND AcProc_fil.asdat = n_asdat)  NO-ERROR .
    IF AVAIL AcProc_fil THEN DO:
            n_trndatto   = AcProc_fil.trndatto.
    END.

   IF  n_frac = "" THEN  n_frac   = "A000000".
   IF  n_toac = "" THEN n_toac = "B999999". 

   IF ( n_branch > n_branch2)   THEN DO:
         Message "ข้อมูลรหัสสาขาผิดพลาด" SKIP
                          "รหัสสาขาเริ่มต้นต้องมากกว่ารหัสสุดท้าย" VIEW-AS ALERT-BOX WARNING . 
         Apply "Entry" To fibranch.
         Return No-Apply.       
   END.
   IF ( n_frac > n_toac)   THEN DO:
         Message "ข้อมูลตัวแทนผิดพลาด" SKIP
                          "รหัสตัวแทนเริ่มต้นต้องมากกว่ารหัสสุดท้าย" VIEW-AS ALERT-BOX WARNING . 
         Apply "Entry" To fiacno1  .
         Return No-Apply.       
   END.
   IF n_OutputTo = 3 And n_OutputFile = ""    THEN DO:
         Message "กรุณาใส่ชื่อไฟล์" VIEW-AS ALERT-BOX WARNING . 
         Apply "Entry" To  fiFile-Name .
         Return No-Apply.       
   END.

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


    IF n_asdat = ?   THEN DO:
            MESSAGE "ไม่พบข้อมูล  กรุณาตรวจสอบการ Process ข้อมูล" VIEW-AS ALERT-BOX WARNING.
    END.
    ELSE DO:
        MESSAGE "สาขา                      : "  n_Branch " ถึง " n_Branch2 skip (1)
                            "ตัวแทน/นายหน้า  : "  n_frac " ถึง " n_toac skip (1)
                            "ข้อมูลวันที่             : " STRING(n_asdat,"99/99/9999") skip (1)
                            "พิมพ์รายงาน        : " cbRptList VIEW-AS ALERT-BOX QUESTION
        BUTTONS YES-NO
        TITLE "Confirm"    UPDATE CHOICE AS LOGICAL.
        CASE CHOICE:
        WHEN TRUE THEN    DO:
           /* 23/04/2002 */
           IF (n_typ = "" AND n_typ1 = "") THEN DO:  /* ไม่ต้องการข้อมูล มี typ "Y" หรือ "Z" */
              RB-FILTER            = 'agtprm_fil.asdat = ' + 
                                                    STRING (MONTH (n_asdat)) + "/" + 
                                                    STRING (DAY (n_asdat)) + "/" + 
                                                    STRING (YEAR (n_asdat)) + 
                                                    " AND " + 
                                                    "agtprm_fil.acno >= '" + n_frac + "'" + " AND " + 
                                                    "agtprm_fil.acno <= '" + n_toac + "'" +
                                                    " AND " +
                                                    "agtprm_fil.polbran >= '" + n_branch   + "'" + " AND " + 
                                                    "agtprm_fil.polbran <= '" + n_branch2 + "'" +
                                                    " AND " +
                                                    "NOT ( agtprm_fil.trntyp  BEGINS 'Y' )" + " AND " +
                                                    "NOT ( agtprm_fil.trntyp  BEGINS 'Z' )" .
           END.
           ELSE IF  (n_typ = "Y" AND n_typ1 = "Z") THEN DO:   /* ต้องการข้อมูลทุก typ */
              RB-FILTER            = 'agtprm_fil.asdat = ' + 
                                                    STRING (MONTH (n_asdat)) + "/" + 
                                                    STRING (DAY (n_asdat)) + "/" + 
                                                    STRING (YEAR (n_asdat)) + 
                                                    " AND " + 
                                                    "agtprm_fil.acno >= '" + n_frac + "'" + " AND " + 
                                                    "agtprm_fil.acno <= '" + n_toac + "'" +
                                                    " AND " +
                                                    "agtprm_fil.polbran >= '" + n_branch   + "'" + " AND " + 
                                                    "agtprm_fil.polbran <= '" + n_branch2 + "'" .
          END.
          ELSE IF ( (n_typ = "" OR n_typ1 = "" ) AND NOT (n_typ = "" AND n_typ1 = "")) THEN DO:   /* ต้องการข้อมูล มี typ "Y" หรือ "Z" */
                
                n_typ =  IF n_typ = "" THEN "Y" ELSE "Z" .    /* ถ้า n_typ = ""   แสดงว่า ไม่print typ "Y"  แล้ว 
                                                                                                      n_typ = "Y" แสดงว่า print typ "Y"  เพราะฉะนั้น จีงระบุว่าไม่ print typ "Z"  */

                
              RB-FILTER            = 'agtprm_fil.asdat = ' + 
                                                    STRING (MONTH (n_asdat)) + "/" + 
                                                    STRING (DAY (n_asdat)) + "/" + 
                                                    STRING (YEAR (n_asdat)) + 
                                                    " AND " + 
                                                    "agtprm_fil.acno >= '" + n_frac + "'" + " AND " + 
                                                    "agtprm_fil.acno <= '" + n_toac + "'" +
                                                    " AND " +
                                                    "agtprm_fil.polbran >= '" + n_branch   + "'" + " AND " + 
                                                    "agtprm_fil.polbran <= '" + n_branch2 + "'" +
                                                    " AND " +
                                                    "NOT ( agtprm_fil.trntyp  BEGINS '" + n_typ + "' )" .
          END.   /* end if... else... */
 
            ASSIGN  
                    nv_User   =   n_user               
                    nv_pwd    =   n_passwd                 
              report-name  =  cbRptList

              /* RB-DB-CONNECTION  = "-H alpha4 -S stat" +  " -U " + nv_user + " -P " + nv_pwd */
               /*RB-DB-CONNECTION  = "-H brpy -S stattest" +  " -U " + nv_user + " -P " + nv_pwd */
              
              RB-INCLUDE-RECORDS = "O"
                                                                                                                                                                                                                    
              RB-PRINT-DESTINATION = SUBSTR ("D A", rsOutput, 1)
              RB-PRINTER-NAME   = IF rsOutput = 2 THEN cbPrtList ELSE " "
              RB-OUTPUT-FILE       = IF rsOutput = 3 THEN fiFile-Name ELSE " "
              RB-NO-WAIT               = No
              RB-OTHER-PARAMETERS =  "rb_vCliCod     = " + STRING(vCliCod) + CHR(10) +  
                                                                  "rb_n_trndatto  = " + STRING(n_trndatto,"99/99/9999") .
             
            vFirstTime =  STRING(TIME, "HH:MM AM").
 
            IF rsOutput = 3 THEN DO:
                ASSIGN
                    report-library = "wAC/wprl/wac_sm04.prl"
                    report-name  = "Statement By Trandate to Excel".
            END.
            ELSE DO:
                ASSIGN
                    report-library = "wAC/wprl/wac_sm01.prl"
                    report-name  = cbRptList.
            END.
            
            
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

                           
            vLastTime =  STRING(TIME, "HH:MM AM").

            MESSAGE "As of Date     : " STRING(n_asdat,"99/99/9999")  SKIP (1)
                               "ตัวแทน              : "  n_frac " ถึง " n_toac SKIP (1)
                               "เวลา  " vFirstTime "  -  " vLastTime   VIEW-AS ALERT-BOX INFORMATION.
         
        END.
        WHEN FALSE THEN    DO:
        
                RETURN NO-APPLY. 
        END.
        END CASE.    
        
    END.   /* IF  asdat  <> ? */

END.

/* filter ทั้งหมด */
/*              RB-FILTER            = 'agtprm_fil.asdat = ' + 
 *                                                     STRING (MONTH (n_asdat)) + "/" + 
 *                                                     STRING (DAY (n_asdat)) + "/" + 
 *                                                     STRING (YEAR (n_asdat)) + 
 *                                                     " AND " +
 *                                                     "agtprm_fil.polbran >= '" + n_branch   + "'" + " AND " + 
 *                                                     "agtprm_fil.polbran <= '" + n_branch2 + "'" +
 *                                                     " AND " + 
 *                                                     "agtprm_fil.acno >= '" + n_frac + "'" + " AND " + 
 *                                                     "agtprm_fil.acno <= '" + n_toac + "'" +
 *                                                     " AND " +
 *                                                     "LOOKUP (agtprm_fil.acno_clicod," + '"' + TRIM (vCliCod) + '"' + ")" + "  <> 0 " +
 *                                                     " AND " +
 *                                                     "( SUBSTRING(agtprm_fil.trntyp,1,1) = 'M' " + " OR " + 
 *                                                     "SUBSTRING(agtprm_fil.trntyp,1,1) = 'A' " + " OR " + 
 *                                                     "SUBSTRING(agtprm_fil.trntyp,1,1) = 'R' " + " OR " + 
 *                                                     "SUBSTRING(agtprm_fil.trntyp,1,1) = 'B' " + " OR " + 
 *                                                     "SUBSTRING(agtprm_fil.trntyp,1,1) = 'C' " + " OR " +                                                     
 *                                                     "SUBSTRING(agtprm_fil.trntyp,1,1) = '" + n_typ + "'" + " OR " + 
 *                                                     "SUBSTRING(agtprm_fil.trntyp,1,1) = '" + n_typ1 + "' )" */
                                                    
/*                                                      " AND " +
 *                                                     "(agtprm_fil.trntyp <>  ''  OR  agtprm_fil.trntyp begins  '" + n_typ   +  
 *                                                     "' OR agtprm_fil.trntyp begins  '" + n_typ1 + "' )" */
*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDOutPut wacr007 
PROCEDURE PDOutPut :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:      
------------------------------------------------------------------------------*/
/*---Str amparat c. A55-0140 ---*/
DEF VAR nv_flag AS CHAR.
    IF rs_billing = 1 THEN nv_flag = "<= ".
    IF rs_billing = 2 THEN nv_flag = " > ".
/*---End amparat c. A55-0140 ---*/
    IF rsOutput = 1 OR  rsOutput = 2 THEN DO:     /* report builder */
       IF raReportTyp = 1 OR  raReportTyp = 2 OR  raReportTyp = 3 THEN DO:    /*--AG/BR , FI/Dealer, LS--*/
               IF n_type = "Motor" THEN DO:  

                    RB-FILTER    = 'agtprm_fil.asdat = ' + 
                                       STRING (MONTH (n_asdat)) + "/" + 
                                       STRING (DAY (n_asdat)) + "/" + 
                                       STRING (YEAR (n_asdat)) + 
                                       " AND " + 
                                       /*"agtprm_fil.duedat <= " +  comment by Amparat c. A55-0140    */
                                       "agtprm_fil.duedat " + nv_flag +  /*--- Amparat c. A55-0140 ---*/
                                       STRING (MONTH (fi_builldate)) + "/" + 
                                       STRING (DAY (fi_builldate)) + "/" + 
                                       STRING (YEAR (fi_builldate)) + 
                                       " AND " + 
                                       "agtprm_fil.acno >= '" + n_frac + "'" + " AND " + 
                                       "agtprm_fil.acno <= '" + n_toac + "'" +
                                       " AND (" + "agtprm_fil.poltyp BEGINS '" + "V7" + "' ) " +  
                                     " AND ( " + nv_filter2 + " )" +  " AND " +   /* client type */
                                     "agtprm_fil.polbran >= '" + n_branch   + "'" + " AND " + 
                                     "agtprm_fil.polbran <= '" + n_branch2 + "'" . 
                  /*---Str amparat c. A55-0140 ---*/
                  IF rs_billing = 3 THEN DO:
                      RB-FILTER    = 'agtprm_fil.asdat = ' + 
                                      STRING (MONTH (n_asdat)) + "/" + 
                                      STRING (DAY (n_asdat)) + "/" + 
                                      STRING (YEAR (n_asdat)) + 
                                      " AND " +           
                                      "agtprm_fil.acno >= '" + n_frac + "'" + " AND " + 
                                      "agtprm_fil.acno <= '" + n_toac + "'" +
                                      " AND (" + "agtprm_fil.poltyp BEGINS '" + "V7" + "' ) " +  
                                      " AND ( " + nv_filter2 + " )" +  " AND " +   /* client type */
                                      "agtprm_fil.polbran >= '" + n_branch   + "'" + " AND " + 
                                      "agtprm_fil.polbran <= '" + n_branch2 + "'" . 
                  END.
                  /*---END amparat c. A55-0140 ---*/
               END. /*--end Motor--*/
               ELSE DO:
                 IF n_type = "Non-Motor" THEN DO: 
                    /*---Non---*/
                    RB-FILTER    = 'agtprm_fil.asdat = ' + 
                                     STRING (MONTH (n_asdat)) + "/" + 
                                     STRING (DAY (n_asdat)) + "/" + 
                                     STRING (YEAR (n_asdat)) +                                              
                                     " AND " + 
                                     /*"agtprm_fil.duedat <= " +  comment by Amparat c. A55-0140    */
                                     "agtprm_fil.duedat " + nv_flag +  /*--- Amparat c. A55-0140 ---*/
                                     STRING (MONTH (fi_builldate)) + "/" + 
                                     STRING (DAY (fi_builldate)) + "/" + 
                                     STRING (YEAR (fi_builldate)) + 
                                     " AND " + 
                                     "agtprm_fil.acno >= '" + n_frac + "'" + " AND " + 
                                     "agtprm_fil.acno <= '" + n_toac + "'" +
                                     " AND ( not " + "agtprm_fil.poltyp BEGINS '" + "V7" + "' ) " +  
                                     " AND ( " + nv_filter2 + " )" +  " AND " +   /* client type */
                                     "agtprm_fil.polbran >= '" + n_branch   + "'" + " AND " + 
                                     "agtprm_fil.polbran <= '" + n_branch2 + "'". 
                    /*---Str amparat c. A55-0140 ---*/
                    IF rs_billing = 3 THEN DO:
                       RB-FILTER    = 'agtprm_fil.asdat = ' + 
                                     STRING (MONTH (n_asdat)) + "/" + 
                                     STRING (DAY (n_asdat)) + "/" + 
                                     STRING (YEAR (n_asdat)) +                                              
                                     " AND " +                 
                                     "agtprm_fil.acno >= '" + n_frac + "'" + " AND " + 
                                     "agtprm_fil.acno <= '" + n_toac + "'" +
                                     " AND ( not " + "agtprm_fil.poltyp BEGINS '" + "V7" + "' ) " +  
                                     " AND ( " + nv_filter2 + " )" +  " AND " +   /* client type */
                                     "agtprm_fil.polbran >= '" + n_branch   + "'" + " AND " + 
                                     "agtprm_fil.polbran <= '" + n_branch2 + "'". 
                    END.
                    /*---END amparat c. A55-0140 ---*/
                 END.   /*--end non--*/
                 ELSE DO:   /*ALL*/
                    RB-FILTER    = 'agtprm_fil.asdat = ' + 
                                     STRING (MONTH (n_asdat)) + "/" + 
                                     STRING (DAY (n_asdat)) + "/" + 
                                     STRING (YEAR (n_asdat)) + 
                                     " AND " + 
                                     /*"agtprm_fil.duedat <= " +  comment by Amparat c. A55-0140    */
                                     "agtprm_fil.duedat " + nv_flag +  /*--- Amparat c. A55-0140 ---*/
                                     STRING (MONTH (fi_builldate)) + "/" + 
                                     STRING (DAY (fi_builldate)) + "/" + 
                                     STRING (YEAR (fi_builldate)) + 
                                     " AND " +                                              
                                     "agtprm_fil.acno >= '" + n_frac + "'" + " AND " + 
                                     "agtprm_fil.acno <= '" + n_toac + "'" +
                                     " AND ( " + nv_filter2 + " )" +  " AND " +   /* client type */
                                     "agtprm_fil.polbran >= '" + n_branch   + "'" + " AND " + 
                                     "agtprm_fil.polbran <= '" + n_branch2 + "'" .
                    /*---Str amparat c. A55-0140 ---*/
                    IF rs_billing = 3 THEN DO:
                      RB-FILTER    = 'agtprm_fil.asdat = ' + 
                                     STRING (MONTH (n_asdat)) + "/" + 
                                     STRING (DAY (n_asdat)) + "/" + 
                                     STRING (YEAR (n_asdat)) + 
                                     " AND " + 
                                     "agtprm_fil.acno >= '" + n_frac + "'" + " AND " + 
                                     "agtprm_fil.acno <= '" + n_toac + "'" +
                                     " AND ( " + nv_filter2 + " )" +  " AND " +   /* client type */
                                     "agtprm_fil.polbran >= '" + n_branch   + "'" + " AND " + 
                                     "agtprm_fil.polbran <= '" + n_branch2 + "'" .
                    END.
                    /*---END amparat c. A55-0140 ---*/
                 END.   /*--end all--*/
               END.  /*---else do---*/
            END.     /* end raReportTyp  */
    
            ELSE DO:  /*raReportTyp = ALL*/
                IF n_type = "Motor" THEN DO:  
                    RB-FILTER    = 'agtprm_fil.asdat = ' + 
                                    STRING (MONTH (n_asdat)) + "/" + 
                                    STRING (DAY (n_asdat)) + "/" + 
                                    STRING (YEAR (n_asdat)) + 
                                    " AND " +
                                    /*"agtprm_fil.duedat <= " +  comment by Amparat c. A55-0140    */
                                    "agtprm_fil.duedat " + nv_flag +  /*--- Amparat c. A55-0140 ---*/                                     
                                     STRING (MONTH (fi_builldate)) + "/" + 
                                     STRING (DAY (fi_builldate)) + "/" + 
                                     STRING (YEAR (fi_builldate)) + 
                                     " AND " +
                                    "agtprm_fil.acno >= '" + n_frac + "'" + " AND " + 
                                    "agtprm_fil.acno <= '" + n_toac + "'" +
                                    " AND (" + "agtprm_fil.poltyp BEGINS '" + "V7" + "' ) " +    /*A53-0159*/
                                    " AND " +
                                    "agtprm_fil.polbran >= '" + n_branch   + "'" + " AND " + 
                                    "agtprm_fil.polbran <= '" + n_branch2 + "'" .

                    /*---Str amparat c. A55-0140 ---*/
                    IF rs_billing = 3 THEN DO:
                       RB-FILTER    = 'agtprm_fil.asdat = ' + 
                                    STRING (MONTH (n_asdat)) + "/" + 
                                    STRING (DAY (n_asdat)) + "/" + 
                                    STRING (YEAR (n_asdat)) + 
                                    " AND " +
                                    "agtprm_fil.acno >= '" + n_frac + "'" + " AND " + 
                                    "agtprm_fil.acno <= '" + n_toac + "'" +
                                    " AND (" + "agtprm_fil.poltyp BEGINS '" + "V7" + "' ) " +    /*A53-0159*/
                                    " AND " +
                                    "agtprm_fil.polbran >= '" + n_branch   + "'" + " AND " + 
                                    "agtprm_fil.polbran <= '" + n_branch2 + "'" .
                    END.
                    /*---END amparat c. A55-0140 ---*/
                END.
                ELSE DO:
                    IF n_type = "Non-Motor" THEN DO:
                       RB-FILTER    = 'agtprm_fil.asdat = ' + 
                                    STRING (MONTH (n_asdat)) + "/" + 
                                    STRING (DAY (n_asdat)) + "/" + 
                                    STRING (YEAR (n_asdat)) + 
                                    " AND " + 
                                    /*"agtprm_fil.duedat <= " +  comment by Amparat c. A55-0140    */
                                    "agtprm_fil.duedat " + nv_flag +  /*--- Amparat c. A55-0140 ---*/
                                     STRING (MONTH (fi_builldate)) + "/" + 
                                     STRING (DAY (fi_builldate)) + "/" + 
                                     STRING (YEAR (fi_builldate)) + 
                                     " AND " +
                                    "agtprm_fil.acno >= '" + n_frac + "'" + " AND " + 
                                    "agtprm_fil.acno <= '" + n_toac + "'" +
                                    " AND ( not " + "agtprm_fil.poltyp BEGINS '" + "V7" + "' ) " +  
                                    " AND " +
                                    "agtprm_fil.polbran >= '" + n_branch   + "'" + " AND " + 
                                    "agtprm_fil.polbran <= '" + n_branch2 + "'" .

                       /*---Str amparat c. A55-0140 ---*/
                        IF rs_billing = 3 THEN DO:
                           RB-FILTER    = 'agtprm_fil.asdat = ' + 
                                    STRING (MONTH (n_asdat)) + "/" + 
                                    STRING (DAY (n_asdat)) + "/" + 
                                    STRING (YEAR (n_asdat)) + 
                                    " AND " + 
                                    "agtprm_fil.acno >= '" + n_frac + "'" + " AND " + 
                                    "agtprm_fil.acno <= '" + n_toac + "'" +
                                    " AND ( not " + "agtprm_fil.poltyp BEGINS '" + "V7" + "' ) " +  
                                    " AND " +
                                    "agtprm_fil.polbran >= '" + n_branch   + "'" + " AND " + 
                                    "agtprm_fil.polbran <= '" + n_branch2 + "'" .
                        END.
                        /*---End amparat c. A55-0140 ---*/
                    END. /*--end non--*/
                    ELSE DO:
                        RB-FILTER    = 'agtprm_fil.asdat = ' + 
                                    STRING (MONTH (n_asdat)) + "/" + 
                                    STRING (DAY (n_asdat)) + "/" + 
                                    STRING (YEAR (n_asdat)) + 
                                    " AND " + 
                                    /*"agtprm_fil.duedat <= " +  comment by Amparat c. A55-0140    */
                                    "agtprm_fil.duedat " + nv_flag +  /*--- Amparat c. A55-0140 ---*/                                     
                                     STRING (MONTH (fi_builldate)) + "/" + 
                                     STRING (DAY (fi_builldate)) + "/" + 
                                     STRING (YEAR (fi_builldate)) + 
                                     " AND " +
                                    "agtprm_fil.acno >= '" + n_frac + "'" + " AND " + 
                                    "agtprm_fil.acno <= '" + n_toac + "'" +
                                    " AND " +
                                    "agtprm_fil.polbran >= '" + n_branch   + "'" + " AND " + 
                                    "agtprm_fil.polbran <= '" + n_branch2 + "'" .
                        /*---Str amparat c. A55-0140 ---*/
                        IF rs_billing = 3 THEN DO:
                            RB-FILTER    = 'agtprm_fil.asdat = ' + 
                                        STRING (MONTH (n_asdat)) + "/" + 
                                        STRING (DAY (n_asdat)) + "/" + 
                                        STRING (YEAR (n_asdat)) + 
                                        " AND " + 
                                        "agtprm_fil.acno >= '" + n_frac + "'" + " AND " + 
                                        "agtprm_fil.acno <= '" + n_toac + "'" +
                                        " AND " +
                                        "agtprm_fil.polbran >= '" + n_branch   + "'" + " AND " + 
                                        "agtprm_fil.polbran <= '" + n_branch2 + "'" .
                        END.
                        /*---END amparat c. A55-0140 ---*/

                    END.   /*end All*/
                END.   /*end else do*/
            END.  /*---end raReportTyp = All---*/
    
            RUN PDCheckDate.

            ASSIGN                
                
                RB-INCLUDE-RECORDS = "O"
    
                RB-PRINT-DESTINATION = SUBSTR ("D A", rsOutput, 1)
                RB-PRINTER-NAME     = IF rsOutput = 2 THEN cbPrtList ELSE " "
                RB-NO-WAIT          = NO
                RB-OTHER-PARAMETERS =  "rb_vCliCod     = " + STRING(vCliCod) + CHR(10) +  
                                       "rb_n_trndatto  = " + STRING(n_trndatto,"99/99/9999") + CHR(10) +  
                                       "rb_n_Billdate  = " + STRING (DAY (fi_builldate),"99") + "/" + 
                                                             STRING (MONTH (fi_builldate),"99") + "/" + 
                                                             STRING (YEAR (fi_builldate),"9999") + CHR(10) +  
                                       "rb_n_Cradit  = " +   STRING (MONTH (fi_builldate),"99") + "/" + 
                                                             STRING (DAY (fi_builldate),"99") + "/" + 
                                                             STRING (YEAR (fi_builldate),"9999") + CHR(10) +  
                                       "rb_n_Cdate  = " + STRING (nv_Cdate) + CHR(10) +  
                                       "rb_n_Pdate  = " + STRING (nv_Pdate) + CHR(10) +  
                                       "rb_n_Policytype = " + nv_Policytype  + CHR(10) +  
                                       "rb_n_Tax = " + STRING(fi_Tax) + CHR(10) +    /*--Amparat c. A55-0216---*/
                                       "rb_n_User =" + STRING(nv_User) + CHR(10) +  /*Lukkana M. A55-0369 04/12/2012*/
                                       "rb_pich   =" + nv_a4a_07 . /*ADD Saharat S. A62-0279*/
    
            IF rsOutput = 1 OR rsOutput = 2 THEN DO:                
                ASSIGN
                    report-library = "wAC/wprl/WACR007.prl"
                    report-name  = cbRptList.
    
                RUN pdRunRB.
                
            END.
    END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdRunRB wacr007 
PROCEDURE pdRunRB :
/*------------------------------------------------------------------------------
  Purpose:     record
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdSym100 wacr007 
PROCEDURE pdSym100 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
  vCliCodAll = "" .
  FOR EACH sym100 USE-INDEX sym10001  WHERE sym100.tabcod = "U021"  :
        vCliCodAll = vCliCodAll + sym100.itmcod  + ",".
  END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdUpdateQ wacr007 
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE ProcGetPrtList wacr007 
PROCEDURE ProcGetPrtList :
/*------------------------------------------------------------------------------
  Purpose:     
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE ProcGetRptList wacr007 
PROCEDURE ProcGetRptList :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR report-list   AS CHARACTER.
DEF VAR report-count  AS INTEGER.
DEF VAR report-number AS INTEGER.

  RUN _getname (SEARCH (report-library), OUTPUT report-list,        /* aderb/_getname.p */
    OUTPUT report-count).
  
  IF report-count = 0 THEN RETURN NO-APPLY.

  DO WITH FRAME frST :
        ASSIGN     
          report-number = LOOKUP (report-name,report-list)
          cbRptList     = IF report-number > 0 THEN ENTRY (report-number,report-list)
                          ELSE ENTRY (1, report-list).
  
       DISP cbRptList . 
  END.
  
/*     message  "cbRptList" report-library  skip (1) 
 *                  cbRptList view-as alert-box.*/
 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

/* ************************  Function Implementations ***************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fuLeapYear wacr007 
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fuMaxday wacr007 
FUNCTION fuMaxday RETURNS INTEGER
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fuNumMonth wacr007 
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fuNumYear wacr007 
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

