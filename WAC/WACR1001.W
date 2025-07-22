&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          sicfn            PROGRESS
*/
&Scoped-define WINDOW-NAME wacr1001
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS wacr1001 
/*------------------------------------------------------------------------

  File: 

  Description: 

  Input Parameters:
      <none>

  Output Parameters:
      <none>

  Author: 

  Created: 
  Modigy By A50-0178 Sayamol  11/2007  Add Branch
  Modify By A50-0218  Sayamol 11/2007
            - ปรับ Aging Report 
            - เพิ่ม Output to Screen for .pdf file (Acrobat) Statement Report
            
  Modify By A51-0124  Sayamol  เช็ค Process & Report & Branch
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
 -----------------------------------------------------------------------
 Modify By A51-0186  AMPARAT C. 
       Outward Fac ทั้ง Premium และ Claim ไม่มีข้อมูลบนโปรแกรม Safety Soft หลังการ Process  
       
       
 Modify By: Lukkana M.  Date: 30/10/2009
  Assign No: A52-0241  รายละเอียดในการแก้ไข
            ไฟล์detail 
             -  เพิ่มคอลัมน์ Producer code , Producer Name 
             -  ตรวจสอบข้อมูลช่อง Req no. เนื่องจากข้อมูลไม่ออก
             -  เพิ่มคอลัมน์ over 24 month , over 36 month , over 48 month
             ไฟล์Net
             -  สลับคอลัมน์ total มาอยู่ต่อจากคอลัมน์ Reinsured/Reinsurer
             -  เพิ่มคอลัมน์ over 24 month , over 36 month , over 48 month
             ไฟล์ summary
             -  สลับคอลัมน์ total มาอยู่ต่อจากคอลัมน์ Reinsured/Reinsurer
             -  เพิ่มคอลัมน์ over 24 month , over 36 month , over 48 month 
/* Modify By : Porntiwa T. A60-0267  Date 14/09/2018
               ปรับขยายเลข Document จาก 7 เป็น 10 หลัก เพื่อนำเข้าระบบให้ถูกต้อง                  */                 
               
*************************/

/*************************  Definitions  *************************/
DEF  SHARED VAR n_User           AS CHAR.
DEF  SHARED VAR n_Passwd         AS CHAR.
DEF  VAR  nv_User  AS CHAR NO-UNDO.
DEF  VAR  nv_pwd   LIKE _password NO-UNDO.

/* Definitons  Report -------                                               */

/* Parameters Definitions --- 
                                          */
/*----- A50-0178
DEF NEW SHARED VAR n_agent1   AS CHAR FORMAT "x(7)".
DEF NEW SHARED VAR n_agent2   AS CHAR FORMAT "x(7)".
----------------*/
DEF NEW SHARED VAR n_agent1   AS CHAR FORMAT "x(10)".
DEF NEW SHARED VAR n_agent2   AS CHAR FORMAT "x(10)".

DEF NEW SHARED VAR n_branch   AS CHAR FORMAT "x(2)".
DEF NEW SHARED VAR n_branch2 AS CHAR FORMAT "x(2)".
DEF NEW SHARED VAR n_tabcod   AS CHAR FORMAT "X(4)"  INIT "U021". /* Table-Code  sym100*/
DEF NEW SHARED VAR n_itmcod   AS CHAR FORMAT "X(4)".
DEF NEW SHARED VAR  n_poltyp   AS CHAR FORMAT "X(4)". 

Def Var n_name       As Char Format "x(50)". /*acno*/
Def Var n_chkname As Char format "x(1)".    /* Acno-- chk button 1-2 */
Def Var n_bdes       As Char Format "x(50)".  /*branch name*/
Def Var n_chkBname As Char format "x(1)".  /* branch-- chk button 1-2 */
Def Var n_itmdes   As Char Format "x(40)".   /*Table-Code Description*/

DEF VAR  n_poldes    AS CHAR FORMAT "X(35)". /* policy des*/

/* Local Variable Definitions ---                                       */

DEF VAR n_asdat  AS DATE FORMAT "99/99/9999".
DEF VAR n_frbr    AS CHAR FORMAT "x(2)".
DEF VAR n_tobr   AS CHAR FORMAT "x(2)".
/*------------A50-0178
DEF VAR n_frac   AS CHAR FORMAT "x(7)".
DEF VAR n_toac  AS CHAR FORMAT "x(7)".
-----------------*/
DEF VAR n_frac   AS CHAR FORMAT "x(10)".
DEF VAR n_toac  AS CHAR FORMAT "x(10)".
DEF VAR n_typ    AS CHAR FORMAT "X".
DEF VAR n_typ1  AS CHAR FORMAT "X".
DEF VAR n_trndatfr  AS DATE FORMAT "99/99/9999".
DEF VAR n_trndatto  AS DATE FORMAT "99/99/9999".

DEF VAR n_OutputTo    AS INTEGER.
DEF VAR n_OutputFile        AS CHAR.  /* DETAIL file*/
DEF VAR n_OutputFileSum AS CHAR.  /* SUMMARY file*/

DEF VAR n_odat1 AS  DATE FORMAT "99/99/9999".
/***************************************/

DEF VAR nv_ProcessDate AS DATE FORMAT "99/99/9999".
DEF VAR nv_asdatAging    AS DATE FORMAT "99/99/9999".

/*---------------------- A46-0142 -------------------*/
/*** เพิ่มช่องที่ระบุ type ***/
DEF VAR nv_Trntyp1  AS CHAR INIT "E , F".

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
DEF VAR nv_RptTyp  AS CHAR .
DEF VAR nv_RptName  AS CHAR.
DEF VAR nv_RptName2  AS CHAR.

DEF VAR nv_poltypFr AS CHAR.
DEF VAR nv_poltypTo AS CHAR.

/*** คำนวนวัน ***/
DEF VAR n_due AS DATE FORMAT "99/99/9999".
DEF VAR n_day AS INTE FORMAT ">>>>9".

DEF VAR i    AS INTE INIT 0.

/***------------ ตัวแปรที่รับค่า  แล้วนำไป Export file Detail --------------***/
DEF  VAR nv_premCB AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_commCB AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_totalCB  AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_net         AS DECI FORMAT ">>,>>>,>>>,>>9.99-".

DEF  VAR nv_premA AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_taxA     AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_vatA     AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_sbtA     AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_stampA AS  DECI  FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_totalA  AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_commA  AS  DECI  FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_netA    AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_retcA   AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_suspA AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_balA    AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_netarA   AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_netothA AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
/***--------------------- "Summary of : " -------------------***/

/***------------------- "G R A N D  T O T A L" -----------------***/
DEF VAR nv_blankH  AS CHAR INIT " " EXTENT 20.
DEF VAR nv-1 AS CHAR.
DEF VAR nv-2 AS CHAR.
DEF VAR nv-3 AS CHAR.
DEF VAR nv_bdes AS CHAR.
DEF VAR nv_Linedes AS CHAR.
DEF VAR nv_acname AS CHAR.

/* ตัวแปร display ใน report summary */
DEF VAR nv_RptTyp1 AS CHAR INIT "".
DEF VAR nv_RptTyp2 AS CHAR INIT "".

DEF VAR n_trnty1 AS  CHAR  FORMAT "X" .
DEF VAR n_trnty2  AS  CHAR  FORMAT "X" .
DEF VAR nv_prm LIKE ACM001.PREM .  /* Net Premium */
DEF VAR nv_com LIKE ACM001.PREM .
DEF VAR nv_sup  LIKE  ACM001.PREM .

DEF VAR nv_pprm  LIKE Acm001.Prem.  /* Prem Amount before TAX, STAMP */
DEF VAR nv_stamp LIKE Acm001.Stamp. 
DEF VAR nv_tax   LIKE Acm001.TAX.   /* < 4% of Prem is SBT Else Vat */

DEF VAR nv_netamt  LIKE ACM001.PREM.
DEF VAR nv_sumsup LIKE ACM001.PREM.
DEF VAR nv_sumprm LIKE ACM001.PREM.
DEF VAR nv_sumcom LIKE ACM001.PREM.
DEF VAR nv_spcp LIKE ACM001.PREM.

DEF VAR nv_DetSum AS CHAR .
DEF VAR n_processdate  AS DATE.

/* A47-0261 */
DEF VAR  nv_blankF  AS CHAR  INIT " " EXTENT 20.
DEF VAR  nv_racode  AS DECI  FORMAT "->>,>>>,>>>,>>9.99" INIT 0 EXTENT 18. /*14.*/
DEF VAR  nv_rbcode  AS DECI  FORMAT "->>,>>>,>>>,>>9.99" INIT 0 EXTENT 18. /*14.*/
DEF VAR  nv_rdcode  AS DECI  FORMAT "->>,>>>,>>>,>>9.99" INIT 0 EXTENT 18. /*14.*/
DEF VAR  nv_rfcode  AS DECI  FORMAT "->>,>>>,>>>,>>9.99" INIT 0 EXTENT 18. /*14.*/

DEF VAR  nv_gtotal  AS DECI  FORMAT "->>,>>>,>>>,>>9.99" INIT 0 EXTENT 18. /*13.*/
DEF VAR  nv_gprem   AS DECI  FORMAT ">>,>>>,>>>,>>9.99-" INIT 0.
DEF VAR  nv_gbal    AS DECI  FORMAT ">>,>>>,>>>,>>9.99-" INIT 0.
DEF VAR  nv_stotal  AS DECI  FORMAT ">>,>>>,>>>,>>9.99-" INIT 0.


/* Definitons  Report -------      A50-0218                           */
DEF NEW SHARED VAR report-library AS CHAR INIT "wAC/wprl/wac_sm01.prl".
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

DEF  VAR vFirstTime  AS CHAR INIT "".
DEF  VAR vLastTime   AS CHAR INIT "".
DEF VAR nv_relate AS CHAR FORMAT "X(7)".
DEF VAR n_OutputFileNet AS CHAR.  /*Net Report*/
DEF VAR nv_filter1 AS CHAR INIT "".
DEF VAR nv_filter2 AS CHAR INIT "".

/*-- Lukkana M. A52-0241 26/10/2009 --*/
DEF VAR  nv_dfield  AS DECI FORMAT ">>,>>>,>>>,>>9.99-" EXTENT 18. 
DEF VAR  nv_sfield  AS DECI FORMAT ">>,>>>,>>>,>>9.99-" EXTENT 18. 
DEF VAR  nv_gtotcl  AS DECI  FORMAT ">>,>>>,>>>,>>9.99-" INIT 0.
DEF VAR  nv_comdat  AS CHAR.
DEF VAR  nv_stardat AS CHAR.
DEF VAR  nv_num     AS INT INIT 0.
DEF VAR  nv_col     AS INT INIT 0.
DEF VAR  nv_gap     AS INT INIT 0.
/*-- Lukkana M. A52-0241 26/10/2009 --*/


/*--------------*/

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
&Scoped-define FIELDS-IN-QUERY-brAcproc_fil acproc_fil.asdat 
&Scoped-define ENABLED-FIELDS-IN-QUERY-brAcproc_fil 
&Scoped-define QUERY-STRING-brAcproc_fil FOR EACH acproc_fil NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-brAcproc_fil OPEN QUERY brAcproc_fil FOR EACH acproc_fil NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-brAcproc_fil acproc_fil
&Scoped-define FIRST-TABLE-IN-QUERY-brAcproc_fil acproc_fil


/* Definitions for FRAME frST                                           */
&Scoped-define OPEN-BROWSERS-IN-QUERY-frST ~
    ~{&OPEN-QUERY-brAcproc_fil}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS RECT-302 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR wacr1001 AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE RECTANGLE RECT-302
     EDGE-PIXELS 0    
     SIZE 129.5 BY 1.38
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
     SIZE 22.5 BY 2.19
     BGCOLOR 4 .

DEFINE RECTANGLE RECT2
     EDGE-PIXELS 3 GRAPHIC-EDGE    
     SIZE 22.5 BY 2.38
     BGCOLOR 1 .

DEFINE VARIABLE cbPrtList AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 10
     LIST-ITEMS "cbPrtList" 
     DROP-DOWN-LIST
     SIZE 56.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fiFile-Name AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 56.5 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE rsOutput AS INTEGER 
     VIEW-AS RADIO-SET VERTICAL
     RADIO-BUTTONS 
          "SCREEN FOR STATEMENT", 1,
"PRINTER", 2,
"FILE FOR AGING", 3
     SIZE 26.5 BY 3.1
     BGCOLOR 3 FGCOLOR 15  NO-UNDO.

DEFINE RECTANGLE RECT-5
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 95 BY 3.95
     BGCOLOR 3 .

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
     BGCOLOR 15 FGCOLOR 1 FONT 2 NO-UNDO.

DEFINE VARIABLE fiacno1 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 16.5 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fiacno2 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 16.5 BY .95
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
     SIZE 49.5 BY .95
     BGCOLOR 8 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fibdes2 AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 51 BY .95
     BGCOLOR 8 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fiBranch AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 5 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fiBranch2 AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 5 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fiInclude AS CHARACTER FORMAT "X(256)":U 
     LABEL "Fill 1" 
      VIEW-AS TEXT 
     SIZE 19 BY 1
     BGCOLOR 1 FGCOLOR 7 FONT 1 NO-UNDO.

DEFINE VARIABLE finame1 AS CHARACTER FORMAT "X(256)":U 
     LABEL "" 
      VIEW-AS TEXT 
     SIZE 40 BY .95
     BGCOLOR 8 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE finame2 AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 40 BY .95
     BGCOLOR 8 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fiPoldesFr AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 51.5 BY .95
     BGCOLOR 8 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fiPoldesTo AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 52 BY .95
     BGCOLOR 8 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fiPolTypFr AS CHARACTER FORMAT "X(4)":U 
     VIEW-AS FILL-IN 
     SIZE 5 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fiPolTypTo AS CHARACTER FORMAT "X(4)":U 
     VIEW-AS FILL-IN 
     SIZE 5 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fiProcess AS CHARACTER FORMAT "X(256)":U 
     LABEL "fiProcess" 
      VIEW-AS TEXT 
     SIZE 34 BY .95
     BGCOLOR 8 FGCOLOR 0 FONT 1 NO-UNDO.

DEFINE VARIABLE fiProcessDate AS DATE FORMAT "99/99/9999":U 
      VIEW-AS TEXT 
     SIZE 17.5 BY 1
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
     SIZE 85 BY 7.62
     BGCOLOR 8 FGCOLOR 0 .

DEFINE RECTANGLE re12
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 39.5 BY 7.62
     BGCOLOR 8 .

DEFINE RECTANGLE re13
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 85 BY 7.38
     BGCOLOR 8 .

DEFINE RECTANGLE re14
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 39.5 BY 7.38
     BGCOLOR 8 .

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY brAcproc_fil FOR 
      acproc_fil SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE brAcproc_fil
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS brAcproc_fil wacr1001 _STRUCTURED
  QUERY brAcproc_fil NO-LOCK DISPLAY
      acproc_fil.asdat FORMAT "99/99/9999":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 82.5 BY 4.38
         BGCOLOR 15 FGCOLOR 0 FONT 1.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     "AGING REPORT FOR CLAIM FAC.":210 VIEW-AS TEXT
          SIZE 46 BY .95 AT ROW 1.38 COL 46.5
          BGCOLOR 3 FGCOLOR 7 FONT 23
     RECT-302 AT ROW 1.29 COL 3
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 132 BY 24
         BGCOLOR 19 .

DEFINE FRAME frMain
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         NO-LABELS SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 3 ROW 2.81
         SIZE 129.5 BY 21.91
         BGCOLOR 3 .

DEFINE FRAME frOutput
     rsOutput AT ROW 2.38 COL 4.17 NO-LABEL
     cbPrtList AT ROW 3.19 COL 34.17 COLON-ALIGNED NO-LABEL
     fiFile-Name AT ROW 4.38 COL 34.17 COLON-ALIGNED NO-LABEL
     " OUTPUT TO":40 VIEW-AS TEXT
          SIZE 95 BY .95 TOOLTIP "การแสดงผล" AT ROW 1.1 COL 2.5
          BGCOLOR 1 FGCOLOR 15 FONT 6
     RECT-5 AT ROW 2.05 COL 2.5
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 2 ROW 17.43
         SIZE 98.5 BY 5.24
         BGCOLOR 19 .

DEFINE FRAME frOK
     Btn_OK AT ROW 1.76 COL 6.5
     Btn_Cancel AT ROW 3.95 COL 6.5
     RECT-3 AT ROW 3.57 COL 3.17
     RECT2 AT ROW 1.24 COL 3.17
    WITH DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 102.33 ROW 17.43
         SIZE 27.17 BY 5.19
         BGCOLOR 19 .

DEFINE FRAME frST
     fiBranch AT ROW 1.71 COL 22 COLON-ALIGNED NO-LABEL
     fiBranch2 AT ROW 2.76 COL 22 COLON-ALIGNED NO-LABEL
     fiPolTypFr AT ROW 4.1 COL 22 COLON-ALIGNED NO-LABEL
     fiPolTypTo AT ROW 5.14 COL 22 COLON-ALIGNED NO-LABEL
     fiacno1 AT ROW 6.43 COL 22 COLON-ALIGNED NO-LABEL
     fiacno2 AT ROW 7.43 COL 22 COLON-ALIGNED NO-LABEL
     fiasdatAging AT ROW 10.71 COL 21.83 COLON-ALIGNED
     buBranch AT ROW 1.71 COL 29
     buBranch2 AT ROW 2.76 COL 29
     buPoltypFr AT ROW 4.1 COL 29
     buPoltypTo AT ROW 5.14 COL 29
     buAcno2 AT ROW 7.43 COL 40.67
     coRptTyp AT ROW 3.1 COL 94.5 COLON-ALIGNED
     raDetSum AT ROW 6.57 COL 89 NO-LABEL
     brAcproc_fil AT ROW 11.95 COL 3
     fiTyp1 AT ROW 11.29 COL 92.5 COLON-ALIGNED NO-LABEL
     fiTyp2 AT ROW 11.29 COL 97.5 COLON-ALIGNED NO-LABEL
     fiTyp3 AT ROW 11.29 COL 102.5 COLON-ALIGNED NO-LABEL
     fiTyp4 AT ROW 11.29 COL 107.5 COLON-ALIGNED NO-LABEL
     fiTyp5 AT ROW 11.29 COL 112.5 COLON-ALIGNED NO-LABEL
     fiTyp6 AT ROW 12.57 COL 92.5 COLON-ALIGNED NO-LABEL
     fiTyp7 AT ROW 12.57 COL 97.5 COLON-ALIGNED NO-LABEL
     fiTyp8 AT ROW 12.57 COL 102.5 COLON-ALIGNED NO-LABEL
     fiTyp9 AT ROW 12.57 COL 107.5 COLON-ALIGNED NO-LABEL
     fiTyp10 AT ROW 12.57 COL 112.5 COLON-ALIGNED NO-LABEL
     fiTyp11 AT ROW 13.91 COL 92.5 COLON-ALIGNED NO-LABEL
     fiTyp12 AT ROW 13.91 COL 97.5 COLON-ALIGNED NO-LABEL
     fiTyp13 AT ROW 13.91 COL 102.5 COLON-ALIGNED NO-LABEL
     fiTyp14 AT ROW 13.91 COL 107.5 COLON-ALIGNED NO-LABEL
     fiTyp15 AT ROW 13.91 COL 112.5 COLON-ALIGNED NO-LABEL
     buAcno1 AT ROW 6.43 COL 40.67
     fibdes AT ROW 1.71 COL 30.5 COLON-ALIGNED NO-LABEL
     fibdes2 AT ROW 2.76 COL 30.5 COLON-ALIGNED NO-LABEL
     fiPoldesFr AT ROW 4.1 COL 30.5 COLON-ALIGNED NO-LABEL
     fiPoldesTo AT ROW 5.14 COL 30.5 COLON-ALIGNED NO-LABEL
     finame1 AT ROW 6.43 COL 42.5 COLON-ALIGNED
     finame2 AT ROW 7.43 COL 42.5 COLON-ALIGNED NO-LABEL
     fiInclude AT ROW 9.24 COL 105.5 COLON-ALIGNED
     fiAsdat AT ROW 9.67 COL 22 COLON-ALIGNED
     fiProcessDate AT ROW 9.62 COL 54 COLON-ALIGNED NO-LABEL
     fiProcess AT ROW 15.19 COL 89.33
     "Ageing = 31/01/YYYY, Statement = Process Date" VIEW-AS TEXT
          SIZE 48 BY 1 TOOLTIP "Ageing = วันที่วันสุดท้ายของเดือน/ Statement = วันที่ ณ วันที่ Process data" AT ROW 10.71 COL 38.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "  TYPE OF SEARCH":50 VIEW-AS TEXT
          SIZE 38.5 BY 1 AT ROW 1.38 COL 88
          BGCOLOR 1 FGCOLOR 7 
     "  TYPE OF REPORTS" VIEW-AS TEXT
          SIZE 39 BY 1 AT ROW 4.91 COL 88
          BGCOLOR 1 FGCOLOR 7 
     " INCLUDE TYPE ALL":50 VIEW-AS TEXT
          SIZE 19.33 BY 1 AT ROW 9.24 COL 88.17
          BGCOLOR 1 FGCOLOR 7 
     "BY :" VIEW-AS TEXT
          SIZE 3.5 BY 1 AT ROW 3.1 COL 92.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "PRODUCER FROM":100 VIEW-AS TEXT
          SIZE 18.33 BY .95 TOOLTIP "Account No. From" AT ROW 6.19 COL 3.67
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "POL. TYPE FROM":50 VIEW-AS TEXT
          SIZE 18.5 BY .95 TOOLTIP "ตั้งแต่สาขา" AT ROW 3.86 COL 4
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "TO":20 VIEW-AS TEXT
          SIZE 3.33 BY .95 TOOLTIP "รหัสตัวแทนถึง" AT ROW 7.38 COL 18.67
          BGCOLOR 8 FGCOLOR 1 FONT 6
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         NO-LABELS SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 2 ROW 1.24
         SIZE 127.5 BY 15.95
         BGCOLOR 19 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME frST
     "BRANCH FROM":30 VIEW-AS TEXT
          SIZE 16.5 BY .95 TOOLTIP "ตั้งแต่สาขา" AT ROW 1.76 COL 6
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "TO":10 VIEW-AS TEXT
          SIZE 4 BY .95 TOOLTIP "ถึงสาขา" AT ROW 2.71 COL 18
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "TO":10 VIEW-AS TEXT
          SIZE 4 BY .95 TOOLTIP "ถึงสาขา" AT ROW 5 COL 18.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     " PROCESS DATA":30 VIEW-AS TEXT
          SIZE 16.5 BY 1 TOOLTIP "วันที่ออกรายงาน" AT ROW 9.62 COL 39
          BGCOLOR 1 FGCOLOR 7 
     " ASDATE PROCESS":30 VIEW-AS TEXT
          SIZE 19.5 BY 1 AT ROW 9.62 COL 3
          BGCOLOR 1 FGCOLOR 7 
     " ASDATE OF CAL.":30 VIEW-AS TEXT
          SIZE 19.5 BY 1 AT ROW 10.71 COL 3
          BGCOLOR 1 FGCOLOR 7 
     re11 AT ROW 1.24 COL 2
     re12 AT ROW 1.24 COL 87.5
     re13 AT ROW 9.1 COL 2
     re14 AT ROW 9.14 COL 87.5
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         NO-LABELS SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 2 ROW 1.24
         SIZE 127.5 BY 15.95
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
  CREATE WINDOW wacr1001 ASSIGN
         HIDDEN             = YES
         TITLE              = "wacr1001 - Aging Report For Claim Fac."
         HEIGHT             = 24
         WIDTH              = 132
         MAX-HEIGHT         = 24.05
         MAX-WIDTH          = 135.17
         VIRTUAL-HEIGHT     = 24.05
         VIRTUAL-WIDTH      = 135.17
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
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW wacr1001
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

DEFINE VARIABLE XXTABVALXX AS LOGICAL NO-UNDO.

ASSIGN XXTABVALXX = FRAME frOutput:MOVE-BEFORE-TAB-ITEM (FRAME frOK:HANDLE)
       XXTABVALXX = FRAME frST:MOVE-BEFORE-TAB-ITEM (FRAME frOutput:HANDLE)
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

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(wacr1001)
THEN wacr1001:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE brAcproc_fil
/* Query rebuild information for BROWSE brAcproc_fil
     _TblList          = "sicfn.acproc_fil"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _FldNameList[1]   = sicfn.acproc_fil.asdat
     _Query            is OPENED
*/  /* BROWSE brAcproc_fil */
&ANALYZE-RESUME

 

&Scoped-define BROWSE-NAME brAcproc_fil

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK wacr1001 



/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


