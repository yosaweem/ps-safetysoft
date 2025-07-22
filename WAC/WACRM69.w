&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
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

/************   Program   **********************
Modify by : Ranu I 20/07/2015 Assign no. A58-0246
            เป็นโปรแกรมใหม่ออกจดหมาย Line M69 ถึงตัวแทน   
            สำหรับให้สาขา NZI ใช้งาน
Wac
        -wacrท69.w  
WPrl
        -wacrท69.prl
Whp
        -WhpBran.w
        -WhpAcno2.w
 - Default branch 0-Z
 - ดึงข้อมูลเฉพาะงาน Line M69 จาก Process ST Daily- 
 - ปริ้นได้ครั้งละ 1 producer/agent 
 - เปลี่ยนเงิอนไขการ running เลขที่จดหมาย ให้เข็คจาก ปี+ "69"
-----------------------------------------------------------------------*/
/*----------------------------------------------------------------------
     Modify By: Saharat S.  A62-0279  16/12/2019
      -เปลี่ยนหัว เป็น TMSTH
     /*Modify BY   : Saharat S. A63-0377 16/09/2020
        แก้ไข : แก้ไข ขยาย Format ชื่อ ที่อยู่    */  
----------------------------------------------------------------------*/
/* ***************************  Definitions  ************************** */
DEF SHARED VAR n_User    AS CHAR.
DEF SHARED VAR n_Passwd  AS CHAR.
DEF        VAR nv_User   AS CHAR NO-UNDO. 
DEF        VAR nv_pwd    LIKE _password NO-UNDO. 

/* Definitons  Report -------                                               */

DEF  VAR report-library AS CHAR INIT "Wac/wprl/Wacr04n.prl". 
DEF  VAR report-name  AS CHAR INIT "Letter". 

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

DEF NEW SHARED VAR n_agent1  AS CHAR FORMAT "x(10)".
DEF NEW SHARED VAR n_agent2  AS CHAR FORMAT "x(10)".
DEF NEW SHARED VAR n_branch  AS CHAR FORMAT "x(2)" INIT "0".
DEF NEW SHARED VAR n_branch2 AS CHAR FORMAT "x(2)" INIT "Z".
DEF NEW SHARED VAR n_tabcod  AS CHAR FORMAT "X(4)"    INIT "U021".   /* Table-Code  sym100*/
DEF NEW SHARED VAR n_itmcod  AS CHAR FORMAT "X(4)".

Def Var n_name     As Char Format "x(50)". /*acno name*/ /*ADD Saharat S. A63-0377 */
Def Var n_chkname  As Char format "x(1)".  /* Acno-- chk button 1-2 */
Def Var n_bdes     As Char Format "x(50)". /*branch name*/
Def Var n_chkBname As Char format "x(1)".  /* branch-- chk button 1-2 */
Def Var n_itmdes   As Char Format "x(40)". /*Table-Code Description*/

/* Local Variable Definitions ---                                       */

DEF VAR nv_asmth    AS INTE INIT 0.
DEF VAR nv_frmth    AS INTE INIT 0.
DEF VAR nv_tomth    AS INTE INIT 0.
DEF VAR cv_mthlistT AS CHAR INIT "มกราคม,กุมภาพันธ์,มีนาคม,เมษายน,พฤษภาคม,มิถุนายน,กรกฎาคม,สิงหาคม,กันยายน,ตุลาคม,พฤศจิกายน,ธันวาคม".
DEF VAR cv_mthListE AS CHAR INIT "January, February, March, April, May, June, July, August, September, October, November, December".

DEF VAR n_asdat AS   DATE FORMAT "99/99/9999".
DEF VAR n_frbr  AS   CHAR   FORMAT "x(2)".
DEF VAR n_tobr  AS   CHAR   FORMAT "x(2)".
DEF VAR n_frac  AS   CHAR   FORMAT "x(10)".
DEF VAR n_toac  AS   CHAR   FORMAT "x(10)".
DEF VAR n_typ   AS   CHAR   FORMAT "X".
DEF VAR n_typ1  AS   CHAR   FORMAT "X".
DEF VAR n_trndatto  AS DATE FORMAT "99/99/9999".
DEF VAR nv_bran AS CHAR FORMAT "x(2)".
DEF VAR n_int   AS INT INIT 0.

DEF VAR n_chkCopy    AS INTEGER.
DEF VAR n_OutputTo   AS INTEGER.
DEF VAR n_OutputFile AS Char.

DEF VAR vCliCod       AS CHAR.
DEF VAR vCliCodAll    AS CHAR.
DEF VAR vCountRec     AS INT.
DEF VAR vAcProc_fil   AS CHAR.
DEF VAR vAcProc_fil1  AS CHAR.

DEF VAR vDoc        AS INT.
DEF VAR vDoc2       AS INT.

DEF VAR vContractName AS CHAR.
DEF VAR vExt        AS CHAR.
DEF VAR vDate       AS CHAR.
DEF VAR vMonth      AS CHAR.
DEF VAR vYear       AS CHAR.
DEF VAR vPowerName  AS CHAR.
DEF VAR vPosition   AS CHAR.

DEF VAR vMaxdoc     AS INT .
DEF VAR vAcnoCount  AS CHAR.
/*ADD Saharat S. A62-0279*/
{wuw\wuwppic00a.i NEW}. 
{wuw\wuwppic01a.i}
{wuw\wuwppic02a.i}
/*END Saharat S. A62-0279*/
DEF BUFFER BuffAgtprm FOR agtprm_fil.
DEF VAR vAcnoInt    AS CHAR INIT "1".
DEF VAR vAcnoBe     AS CHAR.
DEF VAR vAcnoFi     AS CHAR.
/*--- A58-0172 ---*/
DEF VAR nv_pic      AS CHAR INIT "".
DEF VAR nv_pic1     AS CHAR INIT "".
DEF VAR nv_year     AS CHAR INIT "".
DEF VAR nv_mon      AS CHAR INIT "".
DEF VAR nv_use      AS CHAR INIT "".
DEF VAR nv_docno    AS INT FORMAT 999999999 INIT 0.
DEF VAR nv_doc1     AS INT FORMAT 999999999.
DEF VAR n_doc       AS INT.
DEF VAR n_seby      AS INT.
DEF VAR n_chk       AS INT INIT 0.
DEF VAR nv_total    AS DECI FORMAT ">>>,>>>,>>9.99".
DEF VAR n_totalc    AS CHAR FORMAT "X(100)".
DEF VAR n_ode       AS CHAR FORMAT "x(20)".
DEF VAR n_type      AS CHAR FORMAT "x(10)".
DEF TEMP-TABLE wdocno_fil 
    FIELD asdat     AS CHAR 
    FIELD bran      AS CHAR
    FIELD acno      AS CHAR 
    FIELD acname    AS CHAR
    FIELD n_user    AS CHAR
    FIELD letterno  AS INT.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define BROWSE-NAME br_detail

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES wdocno_fil

/* Definitions for BROWSE br_detail                                     */
&Scoped-define FIELDS-IN-QUERY-br_detail wdocno_fil.letterno SUBSTR(wdocno_fil.asdat,7,2) + "/" + SUBSTR(wdocno_fil.asdat,5,2) + "/" + SUBSTR(wdocno_fil.asdat,1,4) wdocno_fil.acno wdocno_fil.acname SUBSTR(wdocno_fil.n_user,7,8) SUBSTR(wdocno_fil.n_user,15,8)   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_detail   
&Scoped-define SELF-NAME br_detail
&Scoped-define QUERY-STRING-br_detail FOR EACH wdocno_fil NO-LOCK
&Scoped-define OPEN-QUERY-br_detail OPEN QUERY {&SELF-NAME} FOR EACH wdocno_fil NO-LOCK.
&Scoped-define TABLES-IN-QUERY-br_detail wdocno_fil
&Scoped-define FIRST-TABLE-IN-QUERY-br_detail wdocno_fil


/* Definitions for FRAME frSt                                           */
&Scoped-define OPEN-BROWSERS-IN-QUERY-frSt ~
    ~{&OPEN-QUERY-br_detail}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS IMAGE-24 RECT-87 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE IMAGE IMAGE-24
     FILENAME "I:/SAFETY/WALP83/WIMAGE\bgc01":U
     SIZE 131.5 BY 24.76.

DEFINE RECTANGLE RECT-87
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 15 BY 4.43
     BGCOLOR 2 .

DEFINE RECTANGLE RECT-302
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 40 BY 4.67
     BGCOLOR 34 .

DEFINE BUTTON Btn_Cancel 
     LABEL "Cancel" 
     SIZE 15 BY 1.57
     BGCOLOR 4 FONT 2.

DEFINE BUTTON Btn_OK 
     LABEL "OK" 
     SIZE 15 BY 1.57
     FONT 2.

DEFINE RECTANGLE RECT-103
     EDGE-PIXELS 3 GRAPHIC-EDGE    
     SIZE 21.5 BY 5.76
     BGCOLOR 34 .

DEFINE RECTANGLE RECT-95
     EDGE-PIXELS 4 GRAPHIC-EDGE    
     SIZE 17 BY 2.1
     BGCOLOR 2 .

DEFINE RECTANGLE RECT-97
     EDGE-PIXELS 4 GRAPHIC-EDGE    
     SIZE 17 BY 2.1
     BGCOLOR 4 .

DEFINE VARIABLE cbPrtList AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEMS "Printer Name" 
     DROP-DOWN-LIST
     SIZE 27 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fiFile-Name AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 20.5 BY 1.05
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE rsOutput AS INTEGER 
     VIEW-AS RADIO-SET VERTICAL
     RADIO-BUTTONS 
          "item 1", 1,
"item 2", 2,
"item 3", 3
     SIZE 13 BY 3.38
     BGCOLOR 33 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-82
     EDGE-PIXELS 3 GRAPHIC-EDGE    
     SIZE 46 BY 4.52
     BGCOLOR 34 FGCOLOR 2 .

DEFINE BUTTON buAcno 
     LABEL "..." 
     SIZE 3 BY 1.05
     FONT 1.

DEFINE BUTTON buAcno2 
     LABEL "..." 
     SIZE 3 BY 1.05
     FONT 1.

DEFINE VARIABLE cbAsDat AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEMS "dd/mm/yyyy" 
     DROP-DOWN-LIST
     SIZE 16 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fiacno1 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 12 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fiacno2 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 12 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fiContractName AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 29 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fiDesc AS CHARACTER FORMAT "X(50)":U 
      VIEW-AS TEXT 
     SIZE 21.5 BY 1
     BGCOLOR 34 FGCOLOR 6 FONT 6 NO-UNDO.

DEFINE VARIABLE fiDoc AS INTEGER FORMAT "99999999":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 13.5 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiExt AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 15 FONT 1 NO-UNDO.

DEFINE VARIABLE finame1 AS CHARACTER FORMAT "X(50)":U 
      VIEW-AS TEXT 
     SIZE 33.67 BY 1.05
     BGCOLOR 15 FGCOLOR 2 FONT 4 NO-UNDO.

DEFINE VARIABLE finame2 AS CHARACTER FORMAT "X(50)":U 
      VIEW-AS TEXT 
     SIZE 33.67 BY 1.05
     BGCOLOR 15 FGCOLOR 2 FONT 4 NO-UNDO.

DEFINE VARIABLE fiPosition AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 40.33 BY 1
     BGCOLOR 15 FONT 1 NO-UNDO.

DEFINE VARIABLE fiPowerName AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 40.17 BY 1
     BGCOLOR 15 FONT 1 NO-UNDO.

DEFINE VARIABLE selectby AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "Producer Code", 1,
"Agent Code", 2
     SIZE 35 BY 1
     BGCOLOR 34 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-106
     EDGE-PIXELS 3 GRAPHIC-EDGE    
     SIZE 120.17 BY 15.71
     BGCOLOR 32 .

DEFINE RECTANGLE RECT-108
     EDGE-PIXELS 3 GRAPHIC-EDGE    
     SIZE 54.5 BY 1.57
     BGCOLOR 34 .

DEFINE RECTANGLE RECT-303
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 57.17 BY 2.86
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-83
     EDGE-PIXELS 3 GRAPHIC-EDGE    
     SIZE 60.5 BY 1.57
     BGCOLOR 34 FGCOLOR 2 .

DEFINE RECTANGLE RECT-84
     EDGE-PIXELS 3 GRAPHIC-EDGE    
     SIZE 60.5 BY 3.91
     BGCOLOR 34 .

DEFINE RECTANGLE RECT-86
     EDGE-PIXELS 3 GRAPHIC-EDGE    
     SIZE 60.5 BY 1.57
     BGCOLOR 34 .

DEFINE RECTANGLE RECT-88
     EDGE-PIXELS 3 GRAPHIC-EDGE    
     SIZE 60.5 BY 7.05
     BGCOLOR 34 .

DEFINE VARIABLE toReprint AS LOGICAL INITIAL no 
     LABEL "พิมพ์ซ้ำ" 
     VIEW-AS TOGGLE-BOX
     SIZE 11.5 BY 1
     BGCOLOR 34 FGCOLOR 2 FONT 6 NO-UNDO.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_detail FOR 
      wdocno_fil SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_detail
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_detail C-Win _FREEFORM
  QUERY br_detail DISPLAY
      wdocno_fil.letterno                       COLUMN-LABEL "Notic no." FORMAT  ">>>>>>>99"
      SUBSTR(wdocno_fil.asdat,7,2) + 
      "/" + SUBSTR(wdocno_fil.asdat,5,2) +
      "/" + SUBSTR(wdocno_fil.asdat,1,4)        COLUMN-LABEL "As date"    FORMAT "x(12)"
      wdocno_fil.acno                           COLUMN-LABEL "AC no."     FORMAT "x(12)"
      wdocno_fil.acname                         COLUMN-LABEL "AC Name"    FORMAT "x(35)"
      SUBSTR(wdocno_fil.n_user,7,8)             COLUMN-LABEL "Select by"    FORMAT "x(8)"
      SUBSTR(wdocno_fil.n_user,15,8)             COLUMN-LABEL "UserID"    FORMAT "x(8)"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 55 BY 11.67
         BGCOLOR 15  FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     IMAGE-24 AT ROW 1.14 COL 1.67
     RECT-87 AT ROW 11.19 COL 104
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 25.09
         BGCOLOR 31 FGCOLOR 0 .

DEFINE FRAME frOutput
     rsOutput AT ROW 2.81 COL 4.33 NO-LABEL
     cbPrtList AT ROW 3.86 COL 16 COLON-ALIGNED NO-LABEL
     fiFile-Name AT ROW 5.19 COL 16 COLON-ALIGNED NO-LABEL
     " Output To":10 VIEW-AS TEXT
          SIZE 48.5 BY 1.05 AT ROW 1 COL 1
          BGCOLOR 1 FGCOLOR 7 FONT 2
     RECT-82 AT ROW 2.33 COL 2.5
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 6.33 ROW 19.19
         SIZE 49 BY 6.26
         BGCOLOR 31 .

DEFINE FRAME FRAME-A
     " 2. ถ้าทราบ Notic No เดิมให้ใส่ที่ช่อง Notic No" VIEW-AS TEXT
          SIZE 38 BY 1 AT ROW 3.38 COL 2.5
          BGCOLOR 15 
     " 1. คลิกพิมพ์ซ้ำ" VIEW-AS TEXT
          SIZE 38 BY 1 AT ROW 2.38 COL 2.5
          BGCOLOR 15 
     " Notic Detail แล้วใส่ที่ช่อง Notic No" VIEW-AS TEXT
          SIZE 38 BY 1 AT ROW 5.33 COL 2.5
          BGCOLOR 15 
     " 3. ถ้าไม่ทราบดูรายละเอียดเลขที่เคยปริ้นจาก-" VIEW-AS TEXT
          SIZE 38 BY 1 AT ROW 4.38 COL 2.5
          BGCOLOR 15 
     "วิธีการพิมพ์ซ้ำ" VIEW-AS TEXT
          SIZE 41 BY 1.05 AT ROW 1 COL 1
          BGCOLOR 1 FGCOLOR 7 FONT 6
     RECT-302 AT ROW 2.1 COL 1.5
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 59.5 ROW 19.19
         SIZE 41.5 BY 6.26
         BGCOLOR 31 .

DEFINE FRAME frSt
     br_detail AT ROW 5.52 COL 66
     cbAsDat AT ROW 3 COL 22.83 COLON-ALIGNED NO-LABEL
     selectby AT ROW 4.71 COL 24.5 NO-LABEL
     fiacno1 AT ROW 7.38 COL 11 COLON-ALIGNED NO-LABEL
     fiacno2 AT ROW 8.67 COL 11 COLON-ALIGNED NO-LABEL
     fiContractName AT ROW 14.67 COL 21.5 COLON-ALIGNED NO-LABEL
     fiExt AT ROW 15.76 COL 21.67 COLON-ALIGNED NO-LABEL
     toReprint AT ROW 3 COL 106.83
     fiDoc AT ROW 3 COL 88.5 COLON-ALIGNED NO-LABEL
     buAcno AT ROW 7.38 COL 25
     buAcno2 AT ROW 8.67 COL 25
     fiPowerName AT ROW 11.71 COL 17.33 COLON-ALIGNED NO-LABEL
     fiPosition AT ROW 12.91 COL 17.17 COLON-ALIGNED NO-LABEL
     fiDesc AT ROW 3 COL 40 COLON-ALIGNED NO-LABEL
     finame1 AT ROW 7.38 COL 26.83 COLON-ALIGNED NO-LABEL
     finame2 AT ROW 8.57 COL 26.83 COLON-ALIGNED NO-LABEL
     "ชื่อผู้มีอำนาจ":20 VIEW-AS TEXT
          SIZE 11.5 BY 1 AT ROW 11.62 COL 6.5
          BGCOLOR 34 FGCOLOR 2 FONT 6
     "ตำแหน่ง" VIEW-AS TEXT
          SIZE 7.83 BY 1 AT ROW 12.81 COL 10
          BGCOLOR 34 FGCOLOR 2 FONT 6
     " As Of Date":20 VIEW-AS TEXT
          SIZE 16 BY 1 AT ROW 3 COL 5
          BGCOLOR 1 FGCOLOR 7 FONT 2
     "From" VIEW-AS TEXT
          SIZE 5.5 BY 1.05 AT ROW 7.38 COL 6.5
          BGCOLOR 34 FGCOLOR 2 FONT 6
     " Reprint" VIEW-AS TEXT
          SIZE 11.5 BY 1 AT ROW 3 COL 67.33
          BGCOLOR 1 FGCOLOR 7 FONT 2
     " Contract" VIEW-AS TEXT
          SIZE 60 BY 1 AT ROW 10.29 COL 4.5
          BGCOLOR 1 FGCOLOR 7 FONT 2
     "Notic No.":10 VIEW-AS TEXT
          SIZE 9.67 BY 1.05 AT ROW 3 COL 80.5
          BGCOLOR 34 FGCOLOR 2 FONT 6
     " Notic Detail" VIEW-AS TEXT
          SIZE 55 BY 1 AT ROW 4.57 COL 66
          BGCOLOR 1 FGCOLOR 7 FONT 2
     " Ext. Number :":30 VIEW-AS TEXT
          SIZE 14 BY 1.05 AT ROW 15.57 COL 8.33
          BGCOLOR 34 FGCOLOR 2 FONT 6
     " Contract Name :":30 VIEW-AS TEXT
          SIZE 16.5 BY 1.05 AT ROW 14.52 COL 6
          BGCOLOR 34 FGCOLOR 2 FONT 6
     "                            Notice Policy Travel (M69)" VIEW-AS TEXT
          SIZE 123 BY 1.05 AT ROW 1 COL 1
          BGCOLOR 2 FGCOLOR 15 FONT 2
     " Select by" VIEW-AS TEXT
          SIZE 16 BY 1 AT ROW 4.67 COL 5
          BGCOLOR 1 FGCOLOR 7 FONT 2
     " Agent/Producer Code":20 VIEW-AS TEXT
          SIZE 60.5 BY 1 AT ROW 6.14 COL 4
          BGCOLOR 1 FGCOLOR 7 FONT 2
     "To" VIEW-AS TEXT
          SIZE 4.5 BY 1.05 AT ROW 8.67 COL 6.5
          BGCOLOR 34 FGCOLOR 2 FONT 6
     RECT-106 AT ROW 2.19 COL 2.33
     RECT-108 AT ROW 2.71 COL 66
     RECT-83 AT ROW 4.43 COL 4
     RECT-84 AT ROW 6.14 COL 4
     RECT-86 AT ROW 2.71 COL 4
     RECT-88 AT ROW 10.24 COL 4.17
     RECT-303 AT ROW 11.48 COL 5.67
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 5.17 ROW 1.67
         SIZE 123.5 BY 17.19
         BGCOLOR 1 .

DEFINE FRAME frbtn
     Btn_OK AT ROW 2.05 COL 5
     Btn_Cancel AT ROW 4.67 COL 5
     RECT-103 AT ROW 1.19 COL 1.83
     RECT-95 AT ROW 1.76 COL 4
     RECT-97 AT ROW 4.38 COL 4
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 104.83 ROW 19.24
         SIZE 23.5 BY 6.26
         BGCOLOR 31 .


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
         TITLE              = "Notice Policy Travel (M69)"
         HEIGHT             = 25.24
         WIDTH              = 133.33
         MAX-HEIGHT         = 25.24
         MAX-WIDTH          = 133.33
         VIRTUAL-HEIGHT     = 25.24
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
ASSIGN FRAME FRAME-A:FRAME = FRAME DEFAULT-FRAME:HANDLE
       FRAME frbtn:FRAME = FRAME DEFAULT-FRAME:HANDLE
       FRAME frOutput:FRAME = FRAME DEFAULT-FRAME:HANDLE
       FRAME frSt:FRAME = FRAME DEFAULT-FRAME:HANDLE.

/* SETTINGS FOR FRAME DEFAULT-FRAME
   FRAME-NAME Custom                                                    */
/* SETTINGS FOR FRAME FRAME-A
                                                                        */
/* SETTINGS FOR FRAME frbtn
                                                                        */
/* SETTINGS FOR FRAME frOutput
                                                                        */
/* SETTINGS FOR FRAME frSt
   Custom                                                               */
/* BROWSE-TAB br_detail 1 frSt */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_detail
/* Query rebuild information for BROWSE br_detail
     _START_FREEFORM
OPEN QUERY {&SELF-NAME} FOR EACH wdocno_fil NO-LOCK.
     _END_FREEFORM
     _Query            is OPENED
*/  /* BROWSE br_detail */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Notice Policy Travel (M69) */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Notice Policy Travel (M69) */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frbtn
&Scoped-define SELF-NAME Btn_Cancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_Cancel C-Win
ON CHOOSE OF Btn_Cancel IN FRAME frbtn /* Cancel */
DO:
    Apply "Close" To This-Procedure.
    Return No-Apply.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_OK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_OK C-Win
ON CHOOSE OF Btn_OK IN FRAME frbtn /* OK */
DO:
   DEF VAR vAcno AS CHAR INIT "".
   DEF VAR vRet AS CHAR.
   DO WITH FRAME {&FRAME-NAME} :
        ASSIGN 
            FRAME frST fiacno1 fiacno1
            FRAME frST fiacno2 fiacno2
            FRAME frST fiDoc fiDoc
            FRAME frST toReprint toReprint
            FRAME frST fiContractName fiContractName
            FRAME frST fiExt fiExt
            FRAME frST fiPowerName fiPowerName
            FRAME frST fiPosition fiPosition
                                            
            FRAME frOutput rsOutput rsOutput
            FRAME frOutput cbPrtList cbPrtList
            FRAME frOutput fiFile-Name fiFile-Name

            vContractName = fiContractName
            vExt       = fiExt
            vPowerName = fiPowerName
            vPosition  = fiPosition
            vAcnoInt   = "1"
            n_branch  = "0"
            n_branch2 = "Z"        
            n_frac    =  fiAcno1
            n_toac    =  fiAcno2 
            n_asdat   =  DATE(INPUT cbAsDat)   
            n_typ     =   "" 
            n_typ1    =   ""  
            n_seby    = (INPUT selectby)
            n_OutputTo    =  rsOutput
            n_OutputFile  =  fiFile-Name.
            
            
   END.
    
    FIND LAST AcProc_fil USE-INDEX by_type_asdat  
       WHERE (AcProc_fil.type = "01" OR AcProc_fil.type = "05") AND AcProc_fil.asdat = n_asdat NO-LOCK NO-ERROR .
    IF AVAIL AcProc_fil THEN DO:
          n_trndatto  =  AcProc_fil.trndatto.
    END.

   IF  n_frac = "" THEN  n_frac   = "A000000".
   IF  n_toac = "" THEN n_toac = "B999999999". 

      IF fiPowerName = "" THEN DO:
         Message "กรุณาป้อนชื่อผู้มีอำนาจ" VIEW-AS ALERT-BOX ERROR. 
         Apply "Entry" To  fiPowerName.
         RETURN NO-APPLY.   
      END.
  
      IF fiPosition = "" THEN DO:
         Message "กรุณาป้อนตำแหน่ง" VIEW-AS ALERT-BOX ERROR. 
         Apply "Entry" To  fiPosition.
         RETURN NO-APPLY.   
      END.
   
      IF n_OutputTo = 3 And n_OutputFile = ""    THEN DO:
            Message "Please Input File Name" VIEW-AS ALERT-BOX ERROR. 
            Apply "Entry" To  fiFile-Name .
            RETURN NO-APPLY.       
      END.
      
/*      IF fiContractName = "" THEN DO:
 *             Message "Please Input Contract Name" VIEW-AS ALERT-BOX ERROR. 
 *             Apply "Entry" To  fiContractName.
 *             RETURN NO-APPLY.               
 *       END.
 *       
 *       IF fiExt = 0 THEN DO:
 *             Message "Please Input Contract Number" VIEW-AS ALERT-BOX ERROR. 
 *             Apply "Entry" To  fiExt.
 *             RETURN NO-APPLY.       
 *       END.*/
 
  IF toReprint = FALSE THEN DO:  /*----- Print New Record -----*/
      
      IF ( n_frac <> n_toac)   THEN DO:
            Message "ข้อมูล Agent / Producer Code ไม่ถูกต้อง" SKIP(1)
                     "Agent / Producer Code ต้องเป็นข้อมูลเดียวกัน !!" VIEW-AS ALERT-BOX ERROR. 
            Apply "Entry" To fiacno2  .
            RETURN NO-APPLY.       
      END.        
      /*-------- A58-0172 ---------------*/
      IF n_asdat = ?   THEN DO:
            MESSAGE "ไม่พบข้อมูล  กรุณาตรวจสอบการ Process ข้อมูล" VIEW-AS ALERT-BOX ERROR.
      END.
      ELSE DO:
          MESSAGE "Branch : "  n_Branch " ถึง " n_Branch2 SKIP (1)
                              "Producer Code  : "  n_frac " ถึง " n_toac SKIP (1)
                              "As Of Date       : " STRING(n_asdat,"99/99/9999") SKIP (1)
                              "Select by          : " IF n_seby = 1 THEN "Producer" ELSE "Agent" SKIP(1)
                              VIEW-AS ALERT-BOX QUESTION
          BUTTONS YES-NO
          TITLE "Confirm Print"    UPDATE CHOICE AS LOGICAL.
          CASE CHOICE:
          WHEN TRUE THEN    DO:
              RUN checkrunning.
              IF n_seby = 1 THEN RUN PdProducer.
              IF n_seby = 2 THEN RUN PdAgent.
          END.
          WHEN FALSE THEN    DO:
              RETURN NO-APPLY. 
          END.
          END CASE.  
      
      END.   /* else IF asdat = ? */ 

  END.      /*toReprint = False*/
  ELSE DO:   /*----- RePrint Record -----*/
     
      IF ( n_frac <> n_toac)   THEN DO:
            Message " ' REPRINT ' "SKIP(1)
                    "Agent / Producer Code ต้องเป็นข้อมูลเดียวกัน !!"  VIEW-AS ALERT-BOX ERROR. 
            Apply "Entry" To fiacno2  .
            RETURN NO-APPLY.       
      END. 
    /*-------- A58-0172 ---------------*/
      IF n_asdat = ?   THEN DO:
            MESSAGE "ไม่พบข้อมูล  กรุณาตรวจสอบการ Process ข้อมูล" VIEW-AS ALERT-BOX ERROR.
      END.
      ELSE DO:
          MESSAGE "Branch : "  n_Branch " ถึง " n_Branch2 SKIP (1)
                              "Producer Code  : "  n_frac " ถึง " n_toac SKIP (1)
                              "As Of Date       : " STRING(n_asdat,"99/99/9999") SKIP (1)
                              "Select by          : " IF n_seby = 1 THEN "Producer" ELSE "Agent" SKIP(1)
                              VIEW-AS ALERT-BOX QUESTION
          BUTTONS YES-NO
          TITLE "Reprint"    UPDATE CHOICE1 AS LOGICAL.
          CASE CHOICE1:
          WHEN TRUE THEN    DO:
              RUN ProcReprint.   
          END.
          WHEN FALSE THEN    DO:
              RETURN NO-APPLY. 
          END.
          END CASE.  
      
      END.   /* else IF asdat = ? */ 
    /*--- end A58-0172 ---*/
     /* RUN ProcReprint. --- A58-0172 ---*/

  END. /*toReprint = TRUE*/
/*หาค่ามากที่สุดของเลขที่จดหมาย กรณีทำงานต่อโดยที่ยังไม่ออกจากโปรแกรม*/

    RUN pdRunningNo.   /* หา running no เบอร์ ล่าสุด ใน table docno_fil */
    RUN pdDisp.

    toReprint = FALSE.
    DISPLAY toReprint WITH FRAME frSt.
    RUN pdDisable.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frSt
&Scoped-define SELF-NAME buAcno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buAcno C-Win
ON CHOOSE OF buAcno IN FRAME frSt /* ... */
DO:
  DEF Var  n_acno   AS CHAR.
  DEF Var  n_agent    AS CHAR.
  DEF Var  nv_branch AS CHAR.
  DEF Var  nv_branch2 AS CHAR.
   
  ASSIGN
    nv_branch = n_branch
    nv_branch2 = n_branch2.

  RUN Whp\WhpAcno2(OutPut  n_acno,Output n_agent, 
                                       Input-Output nv_branch, Input-Output nv_branch2).
  
  Assign    
    fiAcno1 = n_acno        
    fiName1 = n_agent.
        
  Disp fiAcno1 fiName1 with Frame {&Frame-Name}      .
 
  n_agent1 =  fiAcno1 .

  Return NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buAcno2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buAcno2 C-Win
ON CHOOSE OF buAcno2 IN FRAME frSt /* ... */
DO:

  DEF Var  n_acno   AS CHAR.
  DEF Var  n_agent    AS CHAR.
  DEF Var  nv_branch AS CHAR.
  DEF Var  nv_branch2 AS CHAR.  
   
  ASSIGN
    nv_branch = n_branch
    nv_branch2 = n_branch2.

  RUN Whp\WhpAcno2(OutPut  n_acno,Output n_agent,
                                       Input-Output nv_branch, Input-Output nv_branch2).                                       
  
  Assign    
        fiAcno2 = n_acno        
        fiName2 = n_agent.
        
  Disp fiAcno2 fiName2 with Frame {&Frame-Name}      .
 
  n_agent2 =  fiAcno2 .

  Return NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME cbAsDat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cbAsDat C-Win
ON VALUE-CHANGED OF cbAsDat IN FRAME frSt
DO:
    
    cbAsdat  = INPUT cbAsdat.
    n_asdat    =  DATE( INPUT cbAsDat) .
    RUN pdDesc.
   /* RUN pdRunningNo.  */ /* หา running no เบอร์ ล่าสุด ใน table docno_fil */
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiacno1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiacno1 C-Win
ON LEAVE OF fiacno1 IN FRAME frSt
DO:
    ASSIGN
        fiacno1 = input fiacno1
        n_agent1  = fiacno1.
        
    IF fiAcno1 <> ""  THEN DO :
        FIND   xmm600 WHERE xmm600.acno = n_agent1  NO-LOCK NO-ERROR.
            IF AVAILABLE xmm600 THEN DO:
                finame1:Screen-value IN FRAME {&FRAME-NAME} = xmm600.name.
            END.        
            ELSE DO:
                fiAcno1 = "".
                finame1:Screen-value IN FRAME {&FRAME-NAME} = "Not Found !".
                MESSAGE "Not Found Agent Code" VIEW-AS ALERT-BOX  ERROR.
/*                APPLY "ENTRY" TO fiacno1 IN FRAME frST.
 *                 RETURN NO-APPLY.*/
            END.
    END.
    n_agent1  = CAPS (fiAcno1).
    DISP n_agent1 @ fiAcno1
              n_agent1 @ fiAcno2  WITH FRAME frST.
   

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiacno2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiacno2 C-Win
ON LEAVE OF fiacno2 IN FRAME frSt
DO:
    ASSIGN
        fiacno1 = INPUT fiacno1
        fiacno2 = INPUT fiacno2
        n_agent2  = fiacno2.
        
    DISP CAPS (fiAcno1) @ fiAcno2 WITH FRAME frST.
    
    IF Input  FiAcno2 <> "" Then Do :        
        FIND   xmm600 WHERE xmm600.acno = n_agent2  NO-ERROR.
        IF AVAILABLE xmm600 THEN DO:
            finame2:Screen-value IN FRAME {&FRAME-NAME} = xmm600.name.
        END.        
        ELSE DO:
            fiAcno2 = "".
            finame2:Screen-value IN FRAME {&FRAME-NAME} = "Not Found !".
            MESSAGE "Not Found Producer Code" VIEW-AS ALERT-BOX  ERROR.
        END.
    END.
    
    DISP CAPS (fiAcno2) @ fiAcno2 WITH FRAME frST.

    IF (fiacno1 = "" OR fiacno2 = "")   THEN DO:
        Message "ข้อมูล Agent / Producer Code ไม่ถูกต้อง !!" VIEW-AS ALERT-BOX ERROR. 
        APPLY "Entry" TO fiacno1  .
        Return No-Apply.       
    END.

    IF (fiacno1 <> fiacno2)  THEN DO:
        Message "ข้อมูล Agent / Producer Code ต้องเป็นข้อมูลเดียวกัน "  VIEW-AS ALERT-BOX ERROR. 
        APPLY "Entry" TO fiacno2  .
        Return No-Apply.       
    END.
     
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiContractName
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiContractName C-Win
ON LEAVE OF fiContractName IN FRAME frSt
DO:
  fiContractName = INPUT fiContractName.
  
/*  IF fiContractName = "" THEN DO:
 *      Message "Please Input Contract Name" VIEW-AS ALERT-BOX ERROR. 
 *      Apply "Entry" To  fiContractName.
 *      Return No-Apply.   
 *   END.*/
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiDoc
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiDoc C-Win
ON LEAVE OF fiDoc IN FRAME frSt
DO:
  ASSIGN
     fiDoc = INPUT fiDoc.
     n_doc = fiDoc.
  
  IF fiDoc = 0 THEN DO:
     Message "Please Input Notic No." VIEW-AS ALERT-BOX ERROR.
     Apply "Entry" To fiDoc .
     Return No-Apply.
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiExt
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiExt C-Win
ON LEAVE OF fiExt IN FRAME frSt
DO:
  fiExt = INPUT fiExt.
  
/*  IF fiExt = 0 THEN DO:
 *     Message "Please Input Contract Number" VIEW-AS ALERT-BOX ERROR. 
 *     Apply "Entry" To  fiExt.
 *     Return No-Apply.       
 *   END.  */
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiPosition
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiPosition C-Win
ON LEAVE OF fiPosition IN FRAME frSt
DO:
  fiPosition = INPUT fiPosition.

  IF fiPosition = "" THEN DO:
     Message "กรุณาป้อนตำแหน่ง" VIEW-AS ALERT-BOX ERROR. 
     Apply "Entry" To  fiPosition.
     Return No-Apply.   
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiPowerName
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiPowerName C-Win
ON LEAVE OF fiPowerName IN FRAME frSt
DO:
  fiPowerName = INPUT fiPowerName.

  IF fiPowerName = "" THEN DO:
     Message "กรุณาป้อนชื่อผู้มีอำนาจ" VIEW-AS ALERT-BOX ERROR. 
     Apply "Entry" To  fiPowerName.
     Return No-Apply.   
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frOutput
&Scoped-define SELF-NAME rsOutput
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL rsOutput C-Win
ON VALUE-CHANGED OF rsOutput IN FRAME frOutput
DO:
    ASSIGN {&SELF-NAME}.
  
  CASE rsOutput:
        WHEN 1 THEN  /* Screen */
          ASSIGN
           cbPrtList:SENSITIVE   = No
           fiFile-Name:SENSITIVE = No
           fiFile-Name:BGCOLOR = 15.
        WHEN 2 THEN  /* Printer */
          ASSIGN
           cbPrtList:SENSITIVE   = Yes
           fiFile-Name:SENSITIVE = No         
           fiFile-Name:BGCOLOR = 15.
        WHEN 3 THEN  /* File */ 
        DO:
          ASSIGN
            cbPrtList:SENSITIVE   = No
            fiFile-Name:SENSITIVE = Yes
           fiFile-Name:BGCOLOR = 15.
          APPLY "ENTRY" TO fiFile-Name.
        END.
  END CASE.
        /*if rsoutput = 1 or rsoutput = 2 or rsoutput = 3 then 
 *           enable all with frame frdoc.
 *         else disable all with frame frdoc.  */
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frSt
&Scoped-define SELF-NAME selectby
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL selectby C-Win
ON VALUE-CHANGED OF selectby IN FRAME frSt
DO:
    ASSIGN 
        selectby = (INPUT selectby)
        n_seby   = selectby.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME toReprint
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL toReprint C-Win
ON VALUE-CHANGED OF toReprint IN FRAME frSt /* พิมพ์ซ้ำ */
DO:
    
    toReprint  = INPUT toReprint.  
    
    IF toReprint = TRUE THEN DO:
        IF fiacno1 <> fiacno2 THEN DO:
                Message " ' REPRINT ' " SKIP(1)
                                 " INCORRECT Producer Code" SKIP 
                                 " Producer Code To Must be equal to Producer Code From" VIEW-AS ALERT-BOX ERROR. 
                Apply "Entry" To fiacno2  .
                Return No-Apply.       
        END. 
    END.

    RUN pdDisable.
    RUN pdRunningNo.   /* หา running no เบอร์ ล่าสุด ใน table docno_fil */
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define BROWSE-NAME br_detail
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

/* Now enable the interface and wait for  the exit condition.            */
/* (NOTE: handle ERROR and END-KEY so cleanup code will always fire.    */
MAIN-BLOCK:
DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
   ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:
  RUN enable_UI.
  
  CURRENT-WINDOW:WINDOW-STATE = WINDOW-MAXIMIZED.
    /*RUN Wut\WutwiCen (C-Win:HANDLE).*/
    SESSION:DATA-ENTRY-RETURN = YES.
  
    
/********************  T I T L E   F O R  C - W I N  ****************/
  DEF  VAR  gv_prgid   AS   CHAR.
  DEF  VAR  gv_prog    AS   CHAR.
  
  gv_prgid = "wacrm69.w".
  gv_prog  = "Notice Policy Travel (M69)".
  RUN  WUT\WUTHEAD (c-win:handle,gv_prgid,gv_prog).
  RUN  WUT\WUTDICEN (c-win:HANDLE).

/*********************************************************************/

    RUN ProcGetPrtList.
    RUN pdAcProc_fil.

    ASSIGN
      rsOutput:Radio-Buttons = "Screen, 1,Printer, 2, File, 3"
      rsOutput = 2
      fiFile-Name:BGCOLOR = 15
      cbPrtList:SENSITIVE    = Yes
      fiFile-Name:SENSITIVE  = No.
      
    DISPLAY rsOutput WITH FRAME frOutput .  

    DO WITH FRAME frST:
        ASSIGN   
            fiacno1    = ""
            fiacno2    = ""
            cbAsdat    = vAcProc_fil
            n_asdat    =  DATE(INPUT cbAsDat)
            selectby = 1.
        RUN pdDesc.
        DISPLAY fiacno1 fiacno2 fiDesc cbAsdat selectby fiDesc.

        ASSIGN
            fiDoc = 0
            /* Benjaporn J. A59-0148 [26/04/2016]
            fiPowerName = "นางวาสนา นุชนาง" 
            fiPosition = "หัวหน้าฝ่ายบัญชีและการเงิน". */
            fiPowerName = nv_a4a_60 /*ADD Saharat S. A62-0279*/
            fiPosition  = nv_a4a_61 .  /*ADD Saharat S. A62-0279*/ 
            /* Benjaporn J. A59-0148 [26/04/2016] */

        DISP fiDoc fiPowerName fiPosition fidoc.

    END.
    /*RUN pdname.*/
    RUN pdDisable.        /*  DISABLE fiDoc2 เมื่อต้องการพิมพ์ปกติ */
    RUN pdRunningNo.   /* หา running no เบอร์ ล่าสุด ใน table docno_fil */
    RUN pdDisp.

   APPLY "ENTRY" TO fiacno1 IN FRAME frSt.
   
  
  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE checkrunning C-Win 
PROCEDURE checkrunning :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*-------------- Ranu : A58-0172 -------------------------*/
DO:
   ASSIGN
        nv_doc1 = 0
        nv_year = SUBstr(STRING(YEAR(TODAY) + 543,"9999"),3,2)
        nv_use  = nv_year + "69".
        /*-- for each เอาเลขที่จดหมายปัจจุบัน--*/
      FOR EACH docno_fil USE-INDEX docno01 WHERE poltyp = "M69"  NO-LOCK BREAK BY docno_fil.lastno DESC.
        IF SUBSTR(STRING(docno_fil.lastno),1,4) = nv_use THEN DO:
                nv_doc1 = docno_fil.lastno.
                LEAVE.
         END.
    END.
    IF (nv_doc1 = vMaxdoc OR nv_doc1 > vMaxdoc)THEN RUN pdRunningNo.
    RELEASE docno_fil.
END.
/*----------------------end A58-0712 ------------------*/
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
  ENABLE IMAGE-24 RECT-87 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  DISPLAY cbAsDat selectby fiacno1 fiacno2 fiContractName fiExt toReprint fiDoc 
          fiPowerName fiPosition fiDesc finame1 finame2 
      WITH FRAME frSt IN WINDOW C-Win.
  ENABLE br_detail cbAsDat selectby fiacno1 fiacno2 fiContractName fiExt 
         toReprint fiDoc buAcno buAcno2 fiPowerName fiPosition fiDesc finame1 
         finame2 RECT-106 RECT-108 RECT-83 RECT-84 RECT-86 RECT-88 RECT-303 
      WITH FRAME frSt IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-frSt}
  DISPLAY rsOutput cbPrtList fiFile-Name 
      WITH FRAME frOutput IN WINDOW C-Win.
  ENABLE RECT-82 rsOutput cbPrtList fiFile-Name 
      WITH FRAME frOutput IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-frOutput}
  ENABLE RECT-302 
      WITH FRAME FRAME-A IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-FRAME-A}
  ENABLE RECT-103 RECT-95 RECT-97 Btn_OK Btn_Cancel 
      WITH FRAME frbtn IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-frbtn}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdAcProc_fil C-Win 
PROCEDURE pdAcProc_fil :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/


DEFINE VARIABLE d1 AS DATE FORMAT "99/99/9999".
DEFINE VARIABLE d2 AS DATE FORMAT "99/99/9999".
DEFINE VARIABLE d-day AS INTEGER.
DEFINE VARIABLE d-mon AS INTEGER.


d-day = DAY(TODAY).
d-mon = MONTH(TODAY).
IF d-mon =2 AND d-day = 29 THEN d-day = 28.
d2 = DATE(d-mon,d-day,YEAR(TODAY) - 1).

                                   
     vAcProc_fil = "" .
  FOR EACH AcProc_fil USE-INDEX by_type_asdat  WHERE (AcProc_fil.type = "01" OR AcProc_fil.type = "05")
                             NO-LOCK BY asdat DESC  :
      IF AcProc_fil.asdat >= d2 THEN 
          ASSIGN
            vAcProc_fil = vAcProc_fil + STRING( AcProc_fil.asdat,"99/99/9999")  + ",". 
  END.

  ASSIGN
    cbAsDat:List-Items IN FRAME frST = vAcProc_fil
    cbAsDat = ENTRY (1, vAcProc_fil).
    
  DISP cbAsDat WITH FRAME frST .
  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdAgent C-Win 
PROCEDURE pdAgent :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

DEF VAR n_letter AS CHAR FORMAT "x(8)".
ASSIGN  n_type = ""
        nv_bran = ""
        vAcnoBe = ""
        vAcnoFi  = ""
        n_int = 0.
/*------------------------------ Count & Calculate -----------------------------*/ 
IF n_seby = 2 THEN
    main_loop:
    FOR EACH buffagtprm USE-INDEX by_agent WHERE buffagtprm.asdat = n_asdat AND       /* หาจำนวน Acno ทั้งหมดในช่วง*/
        (buffagtprm.agent >= n_frac AND buffagtprm.agent <= n_toac) AND 
        buffagtprm.poltyp = "M69" BREAK BY buffAgtprm.agent:

        IF FIRST-OF(buffAgtprm.agent) THEN DO:
            vAcnoCount  =  buffagtprm.agent.

            FOR EACH Agtprm_fil USE-INDEX by_agent WHERE Agtprm_fil.asdat = buffAgtprm.asdat AND       /* +1 ให้กับเลขที่จดหมายจนเท่ากับจำนวน Acno ที่ได้ */
                     Agtprm_fil.agent = buffagtprm.agent AND Agtprm_fil.poltyp = buffagtprm.poltyp 
                     BREAK BY Agtprm_fil.agent:
                     ASSIGN nv_bran = "TA0-Z"
                            n_type = "Agent   "
                            n_letter  = SUBSTRING(Agtprm_fil.poldes,48,1).

                     IF INDEX("0123456789",n_letter) <> 0 THEN 
                         ASSIGN n_int = 1.  /*--เช็คค่าตัวแปร (ตัวอักษร+ค่าว่าง = 0 ตัวเลข = 1)-*/
                     ELSE ASSIGN n_int = 0.

                    IF n_int = 1 THEN DO: /* agtprm_fil.poldes <> "" และ n_letter เป็นตัวเลข แสดงว่าเคยพิมพ์แล้ว*/
                            MESSAGE  "มีการพิมพ์จดหมายเตือนเบี้ยประกันภัยค้างชำระแล้ว" SKIP(1)
                                     "Notic No      : " SUBSTRING(agtprm_fil.poldes,48,4) " / " SUBSTRING(agtprm_fil.poldes,52,4)  SKIP(1)
                                     "Producer Code : " vAcnoCount SKIP(1)
                                     "Branch        :  0 - Z " SKIP(1)
                                     "As Of Date    : " STRING(n_asdat,"99/99/9999")
                                    VIEW-AS ALERT-BOX ERROR.
                            LEAVE main_loop.
                    END.
                    ELSE DO:
                        IF n_int = 0 THEN DO: /* agtprm_fil.poldes = "" แสดงว่ายังไม่เคยพิมพ์*/
                           FIND LAST docno_fil USE-INDEX docno01 WHERE 
                                        docno_fil.branch = STRING(YEAR(n_asdat), "9999") + 
                                        STRING(MONTH(n_asdat), "99") + 
                                        STRING(DAY(n_asdat), "99")   AND
                                        docno_fil.poltyp  = "M69" AND
                                        docno_fil.lastno = vMaxdoc NO-ERROR.
                              IF NOT AVAIL docno_fil THEN DO:  /* หาเลขที่เอกสารใน docno_fil ไม่เจอ  assign ค่าลงไปใน agtprm_fil.poldes */
                                  SUBSTRING(agtprm_fil.poldes,48,8) = STRING(vMaxdoc, "99999999").
                                  /*--- หาค่าเริ่มต้นของ Acno ---*/
                                   IF vAcnoInt  =  "1"  THEN DO:
                                        ASSIGN
                                            vAcnoBe  =  vAcnoCount
                                            vAcnoInt   =  "0".
                                   END.
                                   /*--- หาค่าสุดท้ายของ Acno ---*/
                                     vAcnoFi = vAcnoCount.
                              END.
                              ELSE DO:   /* หาเลขที่เอกสารใน docno_fil เจอ */
                                MESSAGE "ไม่สามารถพิมพ์จดหมายได้ เนื่องจาก เลขที่จดหมายซ้ำ" SKIP(1)
                                             "Notic No      : " SUBSTRING(STRING(docno_fil.lastno),1,4) " / " SUBSTRING(STRING(docno_fil.lastno),5,4)  SKIP(1)
                                             "Producer Code : " vAcnoCount SKIP(1)
                                             "Branch        :  0 - Z " SKIP(1)
                                             "As Of Date    : " STRING(docno_fil.branch,"99/99/9999")
                                          VIEW-AS ALERT-BOX ERROR.
                                    RETURN NO-APPLY.
                              END.
                        END. /* els if*/
                    END.  /*else do*/

                    IF LAST-OF(agtprm_fil.agent) THEN DO:                   /*create เลข running ลง docno_fil*/
                        FIND LAST docno_fil USE-INDEX docno01 WHERE 
                                docno_fil.branch = STRING(YEAR(agtprm_fil.asdat), "9999") +
                                STRING(MONTH(agtprm_fil.asdat), "99") +
                                STRING(DAY(agtprm_fil.asdat), "99")  AND
                                docno_fil.poltyp = agtprm_fil.poltyp   AND
                                docno_fil.seqtyp = agtprm_fil.agent   AND
                                docno_fil.lastno = vMaxdoc NO-ERROR.
                        IF NOT AVAIL docno_fil THEN DO:
                          CREATE docno_fil.
                          ASSIGN
                              docno_fil.branch = STRING(YEAR(agtprm_fil.asdat), "9999") + 
                                                 STRING(MONTH(agtprm_fil.asdat), "99") + 
                                                 STRING(DAY(agtprm_fil.asdat), "99")
                              docno_fil.des     = nv_bran + " " + n_type + " " + n_User
                              docno_fil.poltyp  = agtprm_fil.poltyp
                              docno_fil.seqtyp  = agtprm_fil.agent
                              docno_fil.lastno  = vMaxdoc.
                        END.
                        ELSE DO:
                            MESSAGE "มีการพิมพ์จดหมายเตือนเบี้ยประกันภัยค้างชำระแล้ว" SKIP(1)
                                    "Notic No       : " SUBSTRING(STRING(docno_fil.lastno),1,4) " / " SUBSTRING(STRING(docno_fil.lastno),5,4)  SKIP(1)
                                    "Producer Code  : " vAcnoCount SKIP(1)
                                    "Branch         :  0 - Z "  SKIP(1)
                                    "As Of Date     : " STRING(docno_fil.branch,"99/99/9999")
                            VIEW-AS ALERT-BOX ERROR.
                            RETURN NO-APPLY.
                        END.  
                    END. /*last-of agtprm_fil.acno*/
            END.  /*for each agtprm_fil*/
                vMaxdoc = vMaxdoc + 1. 
        END.  /*first-of*/ 
    END.  /*for each buffagtprm*/ 
/*------------------------------- Finish Count & Calculate ------------------------*/      
    IF vAcnoBe <> "" OR vAcnoFi <> "" THEN
        RUN ProcReport1.
    ELSE DO:
        MESSAGE "Not Found Record" SKIP(1)
                "Can Not Print Notice"
            VIEW-AS ALERT-BOX ERROR.
        APPLY "ENTRY" TO fiacno1 IN FRAME frSt.  
        RETURN NO-APPLY.
    END.      
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdDesc C-Win 
PROCEDURE pdDesc :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH AcProc_fil USE-INDEX by_type_asdat WHERE AcProc_fil.asdat = n_asdat NO-LOCK.
         IF acproc_fil.TYPE = "01" THEN
                 fiDesc = " Process Monthly".
          ELSE 
                 fiDesc = " Process Daily".
    END.
    DISP fiDesc WITH FRAM frST.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdDisable C-Win 
PROCEDURE pdDisable :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    DO WITH FRAME frST:
        toReprint  = INPUT toReprint.  
        IF toReprint = TRUE THEN DO:  /* พิมพ์ซ้ำ*/
            ENABLE fiDoc.
            fiDoc:BGCOLOR = 15.
        END.
        ELSE DO:
            DISABLE fiDoc.
            fiDoc:BGCOLOR = 15.
        END.
    END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdDisp C-Win 
PROCEDURE pdDisp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR name1 AS CHAR FORMAT "x(60)".

FOR EACH wdocno_fil : DELETE wdocno_fil. END.

    FOR EACH  docno_fil USE-INDEX docno01  WHERE LENGTH (docno_fil.branch) = 8 AND
                                docno_fil.poltyp = "M69"   AND
                                docno_fil.lastno <> 0 NO-LOCK.
       FIND FIRST xmm600 USE-INDEX xmm60001 WHERE xmm600.acno = docno_fil.seqtyp  NO-LOCK NO-ERROR.
        IF AVAILABLE xmm600 THEN DO:
                name1 = xmm600.name.
            END.
       IF SUBSTRING(docno_fil.branch,1,4) = STRING(YEAR(n_asdat),"9999")  THEN DO:
            CREATE wdocno_fil.
            ASSIGN 
                wdocno_fil.asdat    = docno_fil.branch
                wdocno_fil.bran     = docno_fil.poltyp
                wdocno_fil.acno     = docno_fil.seqtyp
                wdocno_fil.acname   = name1
                wdocno_fil.n_user   = docno_fil.des
                wdocno_fil.letterno = docno_fil.lastno.
        END.
        ELSE DO:
            CREATE wdocno_fil.
            ASSIGN 
                wdocno_fil.asdat    = docno_fil.branch
                wdocno_fil.bran     = docno_fil.poltyp
                wdocno_fil.acno     = docno_fil.seqtyp
                wdocno_fil.acname   = name1
                wdocno_fil.n_user   = docno_fil.des
                wdocno_fil.letterno = 0.
                
        END.
           
    END.

    RELEASE docno_fil.

OPEN QUERY br_detail FOR EACH wdocno_fil WHERE letterno <> 0 NO-LOCK BY letterno DESC.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdProducer C-Win 
PROCEDURE pdProducer :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR n_letter AS CHAR FORMAT "x(8)".
ASSIGN  n_type = ""
        nv_bran = ""
        vAcnoBe = ""
        vAcnoFi  = ""
        n_letter  = ""
        n_int = 0.
/*------------------------------ Count & Calculate -----------------------------*/ 
IF n_seby = 1 THEN
    main_loop:
    FOR EACH buffagtprm USE-INDEX by_acno WHERE buffagtprm.asdat = n_asdat AND       /* หาจำนวน Acno ทั้งหมดในช่วง*/
                 (buffagtprm.acno >= n_frac AND buffagtprm.acno <= n_toac) AND
                 buffagtprm.poltyp = "M69" BREAK BY buffAgtprm.acno:

        IF FIRST-OF(buffAgtprm.acno) THEN DO:
                vAcnoCount  =  buffagtprm.acno.

            FOR EACH Agtprm_fil USE-INDEX by_acno WHERE Agtprm_fil.asdat = buffagtprm.asdat AND       /* +1 ให้กับเลขที่จดหมายจนเท่ากับจำนวน Acno ที่ได้ */
                     Agtprm_fil.acno = buffagtprm.acno AND Agtprm_fil.poltyp = buffagtprm.poltyp 
                     BREAK BY Agtprm_fil.acno:
                    ASSIGN  nv_bran = "TA0-Z"
                            n_type  = "Producer"
                            n_letter  = SUBSTRING(Agtprm_fil.poldes,48,1).
            
                IF INDEX("0123456789",n_letter) <> 0 THEN 
                    ASSIGN n_int = 1.  /*--เช็คค่าตัวแปร (ตัวอักษร+ค่าว่าง = 0 ตัวเลข = 1)-*/
                ELSE ASSIGN n_int = 0.

                IF n_int = 1 THEN DO: /* agtprm_fil.poldes <> "" และ n_letter เป็นตัวเลข แสดงว่าเคยพิมพ์แล้ว*/
                    MESSAGE  "มีการพิมพ์จดหมายเตือนเบี้ยประกันภัยค้างชำระแล้ว" SKIP(1)
                             "Notic No      : " SUBSTRING(agtprm_fil.poldes,48,4) " / " SUBSTRING(agtprm_fil.poldes,52,4) SKIP(1) 
                             "Producer Code : " vAcnoCount SKIP(1)
                             "Branch        :  0 - Z "  SKIP(1)
                             "As Of Date    : " STRING(n_asdat,"99/99/9999")
                             VIEW-AS ALERT-BOX ERROR.
                    LEAVE main_loop.
                END.
                ELSE DO:
                    IF n_int = 0 THEN DO: /* agtprm_fil.poldes = "" แสดงว่ายังไม่เคยพิมพ์*/
                        FIND LAST docno_fil USE-INDEX docno01 WHERE 
                                      docno_fil.branch = STRING(YEAR(n_asdat), "9999") + 
                                      STRING(MONTH(n_asdat), "99") + 
                                      STRING(DAY(n_asdat), "99")   AND
                                      docno_fil.poltyp  = "M69"   AND
                                      docno_fil.lastno = vMaxdoc NO-ERROR.
                            IF NOT AVAIL docno_fil THEN DO:  /* หาเลขที่เอกสารใน docno_fil ไม่เจอ  assign ค่าลงไปใน agtprm_fil.poldes */
                               SUBSTRING(agtprm_fil.poldes,48,8) = STRING(vMaxdoc, "99999999").
                                /*--- หาค่าเริ่มต้นของ Acno ---*/
                                IF vAcnoInt  =  "1"  THEN DO:
                                    ASSIGN
                                        vAcnoBe  =  vAcnoCount
                                        vAcnoInt   =  "0".
                                END.
                                /*--- หาค่าสุดท้ายของ Acno ---*/
                                    vAcnoFi = vAcnoCount.
                                END.
                    END.
                    ELSE DO:   /* หาเลขที่เอกสารใน docno_fil เจอ */
                        MESSAGE "ไม่สามารถพิมพ์จดหมายได้ เนื่องจาก เลขที่จดหมายซ้ำ" SKIP(1)
                                   "Notic No      : " SUBSTRING(STRING(docno_fil.lastno),1,4) " / " SUBSTRING(STRING(docno_fil.lastno),5,4)  SKIP(1)
                                   "Producer Code : " vAcnoCount SKIP(1)
                                   "Branch        :  0 - Z "  SKIP(1)
                                   "As Of Date    : " STRING(docno_fil.branch,"99/99/9999")
                           VIEW-AS ALERT-BOX ERROR.
                        RETURN NO-APPLY.
                    END.   
                END. /*else do*/

                IF LAST-OF(agtprm_fil.acno) THEN DO:    /*create เลข running ลง docno_fil*/
                    FIND LAST docno_fil USE-INDEX docno01 WHERE 
                        docno_fil.branch = STRING(YEAR(agtprm_fil.asdat), "9999") +
                        STRING(MONTH(agtprm_fil.asdat), "99") +
                        STRING(DAY(agtprm_fil.asdat), "99")  AND
                        docno_fil.poltyp = agtprm_fil.poltyp   AND
                        docno_fil.seqtyp = agtprm_fil.acno   AND
                        docno_fil.lastno = vMaxdoc NO-ERROR.
                    IF NOT AVAIL docno_fil THEN DO:
                        CREATE docno_fil.
                        ASSIGN
                            docno_fil.branch = STRING(YEAR(agtprm_fil.asdat), "9999") + 
                                               STRING(MONTH(agtprm_fil.asdat), "99") + 
                                               STRING(DAY(agtprm_fil.asdat), "99")
                            docno_fil.des     = nv_bran + " " + n_type + " " + n_User
                            docno_fil.poltyp  = agtprm_fil.poltyp
                            docno_fil.seqtyp  = agtprm_fil.acno
                            docno_fil.lastno  = vMaxdoc.
                    END.
                    ELSE DO:
                        MESSAGE "ไม่สามารถพิมพ์จดหมายได้ เนื่องจาก" SKIP(1)
                            "มีการพิมพ์จดหมายเตือนเบี้ยประกันภัยค้างชำระแล้ว" SKIP(1)
                            "Notic No      : " SUBSTRING(STRING(docno_fil.lastno),1,4) " / " SUBSTRING(STRING(docno_fil.lastno),5,4)  SKIP(1)
                            "Producer Code : " vAcnoCount SKIP(1)
                            "Branch        :  0 - Z "  SKIP(1)
                            "As Of Date    : " STRING(docno_fil.branch,"99/99/9999")
                        VIEW-AS ALERT-BOX ERROR.
                        RETURN NO-APPLY.
                    END.  
                END. /*last-of agtprm_fil.acno*/

            END.  /*for each agtprm_fil*/
                vMaxdoc = vMaxdoc + 1. 
        END.  /*first-of*/ 
    END.  /*for each buffagtprm*/ 
/*------------------------------- Finish Count & Calculate ------------------------*/      
    IF vAcnoBe <> "" OR vAcnoFi <> "" THEN
        RUN ProcReport1.
    ELSE DO:
        MESSAGE "Not Found Record" SKIP(1)
                "Can Not Print Notice"
                VIEW-AS ALERT-BOX ERROR.
        APPLY "ENTRY" TO fiacno1 IN FRAME frSt.  
        RETURN NO-APPLY.
    END.      
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdRunningNO C-Win 
PROCEDURE pdRunningNO :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

ASSIGN
    nv_docno = 0
    nv_year = SUBstr(STRING(YEAR(TODAY) + 543,"9999"),3,2)
    nv_use  = nv_year + "69".
    /*-- for each เอาเลขที่จดหมายปัจจุบัน--*/
    FOR EACH docno_fil USE-INDEX docno01 WHERE poltyp <> "M69" NO-LOCK BREAK BY docno_fil.lastno DESC.
        IF SUBSTR(STRING(docno_fil.lastno),1,4) = nv_use THEN DO:
                nv_docno = docno_fil.lastno.
                LEAVE.
         END.
    END.
    IF nv_docno <> 0 THEN DO:
        ASSIGN
            vMaxdoc = nv_docno + 1.
        END.
    ELSE DO:
        ASSIGN
            vMaxdoc =  INTEGER(nv_use + "0001").
        END.
    RELEASE docno_fil.
    
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE ProcReport1 C-Win 
PROCEDURE ProcReport1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*----connect sicfn ---*/
      FIND FIRST dbtable WHERE dbtable.phyname = "form"  OR dbtable.phyname = "sicfn" NO-LOCK NO-ERROR NO-WAIT.
      IF AVAIL dbtable THEN DO:
          IF dbtable.phyname = "form" THEN DO:
                 ASSIGN
                     nv_User  = "?"
                     nv_pwd   = "?".
                     RB-DB-CONNECTION  = dbtable.unixpara +  " -U " + nv_user + " -P " + nv_pwd.
          END.
          ELSE DO:
                     RB-DB-CONNECTION = dbtable.unixpara +  " -U " + n_User + " -P " + n_Passwd. 
          END.
      END.
/*---end connect---*/

    IF n_asdat = ?   THEN DO:
            MESSAGE "ไม่พบข้อมูล  กรุณาตรวจสอบการ Process ข้อมูล" VIEW-AS ALERT-BOX ERROR.
    END.
    ELSE DO:
        ASSIGN 
             /* nv_pic = "WIMAGE\Wasana_NZI.jpg".*/   /* Benjaporn J. A59-0148 [26/04/2016] */
                nv_pic = "WIMAGE\chantana_nzi.gif"    /* Benjaporn J. A59-0148 [26/04/2016] */
                nv_pic = SEARCH(nv_pic).
                IF nv_pic = ? OR nv_pic = "" THEN DO:
                   
                    MESSAGE "not found picture" VIEW-AS ALERT-BOX.
                END.
          ASSIGN
                nv_pic1 = "WIMAGE\nzi_BW.bmp".
                nv_pic1 = SEARCH(nv_pic1).
                IF nv_pic1 = ? OR nv_pic1 = "" THEN DO:
                    
                    MESSAGE "not found picture" VIEW-AS ALERT-BOX.
                END.
               
        IF n_seby = 1 THEN RUN ReportPR.
        IF n_seby = 2 THEN RUN ReportAG.
    END.
    
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE ProcReport2 C-Win 
PROCEDURE ProcReport2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*DO:
           ASSIGN 
                n_chk =0
                report-library  =  "Wac/wprl/wacrm69.prl"
                report-name     =  "Notic TA". 

           ASSIGN 
                nv_pic = "WIMAGE\Wasana_NZI.jpg".
                nv_pic = SEARCH(nv_pic).
                IF nv_pic = ? OR nv_pic = "" THEN DO:
                    MESSAGE "not found picture" VIEW-AS ALERT-BOX.
                END.
            /* แปลงค่าเงิน ตัวเลขให้เป็นตัวอักษรไทย*/
           {wuu/wuuthvar.i}
           {wuu/wuuthamt.i &amt      = "nv_total"
                           &amt_text = "n_totalc" }
            /*--------------------------------------*/               
           IF (n_typ = "" AND n_typ1 = "") THEN DO:  /* ไม่ต้องการข้อมูล มี typ "Y" หรือ "Z" */
              RB-FILTER   = 'agtprm_fil.asdat = ' + 
                            STRING (MONTH (n_asdat)) + "/" + 
                            STRING (DAY (n_asdat)) + "/" + 
                            STRING (YEAR (n_asdat)) + 
                            " AND " + 
                            "agtprm_fil.polbran >= '" + n_branch   + "'" + " AND " + 
                            "agtprm_fil.polbran <= '" + n_branch2 + "'" +
                            " AND " + 
                            "agtprm_fil.acno >= '" + vAcnoBe + "'" + " AND " + 
                            "agtprm_fil.acno <= '" + vAcnoFi + "'" +
                            " AND " +
                            "NOT ( agtprm_fil.trntyp  BEGINS 'Y' )" + " AND " +
                            "NOT ( agtprm_fil.trntyp  BEGINS 'Z' )" .
           END.
           ELSE IF  (n_typ = "Y" AND n_typ1 = "Z") THEN DO:   /* ต้องการข้อมูลทุก typ */
              RB-FILTER    = 'agtprm_fil.asdat = ' + 
                             STRING (MONTH (n_asdat)) + "/" + 
                             STRING (DAY (n_asdat)) + "/" + 
                             STRING (YEAR (n_asdat)) + 
                             " AND " + 
                             "agtprm_fil.polbran >= '" + n_branch   + "'" + " AND " + 
                             "agtprm_fil.polbran <= '" + n_branch2 + "'" +
                             " AND " + 
                             "agtprm_fil.acno >= '" + vAcnoBe + "'" + " AND " + 
                             "agtprm_fil.acno <= '" + vAcnoFi + "'".
          END.               
          ELSE IF ( (n_typ = "" OR n_typ1 = "" ) AND NOT (n_typ = "" AND n_typ1 = "")) THEN DO:   /* ต้องการข้อมูล มี typ "Y" หรือ "Z" */
                
                n_typ =  IF n_typ = "" THEN "Y" ELSE "Z" .    /* ถ้า n_typ = ""   แสดงว่า ไม่print typ "Y"  แล้ว 
                                                                                                      n_typ = "Y" แสดงว่า print typ "Y"  เพราะฉะนั้น จีงระบุว่าไม่ print typ "Z"  */

                
              RB-FILTER    = 'agtprm_fil.asdat = ' + 
                              STRING (MONTH (n_asdat)) + "/" + 
                              STRING (DAY (n_asdat)) + "/" + 
                              STRING (YEAR (n_asdat)) + 
                              " AND " + 
                              "agtprm_fil.polbran >= '" + n_branch   + "'" + " AND " + 
                              "agtprm_fil.polbran <= '" + n_branch2 + "'" +
                              " AND " + 
                              "agtprm_fil.acno >= '" + vAcnoBe + "'" + " AND " + 
                              "agtprm_fil.acno <= '" + vAcnoFi + "'" +
                              " AND " +
                              "NOT ( agtprm_fil.trntyp  BEGINS '" + n_typ + "' )" .
          END.   /* end if... else... */

          ASSIGN
              RB-INCLUDE-RECORDS    = "O"                                                                                                                                                                                                                    
              RB-PRINT-DESTINATION  = SUBSTR ("D A", rsOutput, 1)
              RB-PRINTER-NAME       = IF rsOutput = 2 THEN cbPrtList ELSE " "
              RB-OUTPUT-FILE        = IF rsOutput = 3 THEN fiFile-Name ELSE " "
              RB-NO-WAIT            = No
              RB-OTHER-PARAMETERS =  
                                  "rb_vCliCod = " + STRING(vCliCod) + CHR(10) +                                
                                  "rb_n_ContractName  = " + STRING(vContractName) + CHR(10) +
                                  "rb_n_Ext  = " + STRING(vExt) + CHR(10) +
                                  "rb_n_PowerName = " + STRING(vPowerName) + CHR(10) +
                                  "rb_n_Position = " + STRING(vPosition) + CHR(10) +
                                  "rb_n_Date = " + STRING(vDate) + CHR(10) +
                                  "rb_n_branch = " + STRING(n_branch) + CHR(10) +
                                  "rb_n_pic  = " + STRING(nv_pic) + CHR(10) +
                                  "rb_n_trndatto  = " + STRING(n_trndatto,"99/99/9999").
                                                                              
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
            n_chk = 1.
            RELEASE Agtprm_fil.
END.

    IF n_chk = 1 THEN
       MESSAGE "Print Complete " VIEW-AS ALERT-BOX.
    ELSE 
       MESSAGE "Print Not Complete" VIEW-AS ALERT-BOX.*/
  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE ProcReprint C-Win 
PROCEDURE ProcReprint :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    ASSIGN
      vAcnoBe  =  fiacno1 
      vAcnoFi  =  fiacno2.
 
    FIND LAST docno_fil WHERE docno_fil.branch = STRING(YEAR(n_asdat), "9999") +
              STRING(MONTH(n_asdat), "99") +
              STRING(DAY(n_asdat), "99")    AND 
              docno_fil.poltyp  = "M69"  AND 
              docno_fil.seqtyp = n_frac  NO-ERROR.

                IF docno_fil.lastno = n_doc THEN DO: /* ถ้าเจอเลขที่จดหมายนี้ใน docno_fil แล้ว เก็บค่าใส่ */
                    ASSIGN docno_fil.lastno = n_doc.
                END.
                ELSE DO:                                  /* ถ้าไม่เจอเลขที่จดหมายนี้ใน docno_fil */
                    IF docno_fil.lastno <> n_doc AND docno_fil.lastno <> 0 THEN DO:     /* พิมพ์ซ้ำแต่ใส่เลขที่ผิด*/
                       MESSAGE "พิมพ์ซ้ำเลขที่จดหมายจะต้องเท่ากับเลขที่จดหมายเดิม" SKIP
                               "Notic No      : " SUBSTRING(STRING(docno_fil.lastno),1,4) " / "
                                             SUBSTRING(STRING(docno_fil.lastno),5,4) SKIP
                               "Producer Code : " vAcnoBe SKIP 
                               "Branch        : 0 - Z "  SKIP
                               "As Of Date    : " STRING(n_asdat,"99/99/9999") SKIP
                       VIEW-AS ALERT-BOX ERROR.
                       APPLY "ENTRY" TO fiDoc IN FRAME frST.
                       RETURN NO-APPLY.
                    END.
                    ELSE IF docno_fil.lastno <> n_doc AND docno_fil.lastno = 0  THEN DO:      /* พิมพ์ซ้ำแต่ ยังไม่เคยพิมพ์เลย*/
                       MESSAGE "ไม่สามารถพิมพ์ซ้ำได้ เนื่องจากเป็นการพิมพ์ครั้งแรก" SKIP(1)
                               "Producer Code : " vAcnoBe SKIP
                               "Branch        : 0 - Z "  SKIP
                               "As Of Date    : " STRING(n_asdat,"99/99/9999") SKIP
                       VIEW-AS ALERT-BOX ERROR.
                       RETURN NO-APPLY.                     
                    END.
                END. /*else*/
            
    RUN pdDisable.  
    RUN ProcReport1.
      
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE ReportAG C-Win 
PROCEDURE ReportAG :
/*------------------------------------------------------------------------------
  Purpose:  เลือกจาก Agent   
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO:
           ASSIGN 
                n_chk =0
                report-library  =  "Wac/wprl/wacrm69.prl"
                report-name     =  "Notic TA\AG".
          
              RB-FILTER    = 'agtprm_fil.asdat = ' + 
                              STRING (MONTH (n_asdat)) + "/" + 
                              STRING (DAY (n_asdat)) + "/" + 
                              STRING (YEAR (n_asdat)) + " AND " +
                              "agtprm_fil.agent >= '" + vAcnoBe + "'" + " AND " + 
                              "agtprm_fil.agent <= '" + vAcnoFi + "'" + " AND " +
                              "agtprm_fil.poltyp = '" + "M69" + "'" .

          ASSIGN
              RB-INCLUDE-RECORDS    = "O"                                                                                                                                                                                                                    
              RB-PRINT-DESTINATION  = SUBSTR ("D A", rsOutput, 1)
              RB-PRINTER-NAME       = IF rsOutput = 2 THEN cbPrtList ELSE " "
              RB-OUTPUT-FILE        = IF rsOutput = 3 THEN fiFile-Name ELSE " "
              RB-NO-WAIT            = No
              RB-OTHER-PARAMETERS =  
                                  "rb_vCliCod = " + STRING(vCliCod) + CHR(10) +                                
                                  "rb_n_ContractName  = " + STRING(vContractName) + CHR(10) +
                                  "rb_n_Ext  = " + STRING(vExt) + CHR(10) +
                                  "rb_n_PowerName = " + STRING(vPowerName) + CHR(10) +
                                  "rb_n_Position = " + STRING(vPosition) + CHR(10) +
                                  "rb_n_Date = " + STRING(vDate) + CHR(10) +
                                  "rb_n_branch = " + STRING(n_branch) + CHR(10) +
                                  /*ADD Saharat S. A62-0279*/
                                  /*"rb_pic  = " + STRING(nv_pic) + CHR(10) +
                                  "rb_pic1  = " + STRING(nv_pic1) + CHR(10) + */
                                  "rb_pic  = " + nv_a4a_59 + CHR(10) +
                                  "rb_pic1  = " + nv_a4a_69 + CHR(10) +
                                  "rb_pich  = " + nv_a4a_07 + CHR(10) +
                                  "rb_TMSTH1  = " + "ตามที่ท่านได้ขอทำสัญญาประกันภัยประเภท เดินทาง ไว้กับ" + " " + nv_a4a_34 + " " + nv_a4a_03 + CHR(10) +
                                  "rb_TMSTH2  = " + "ชื่อบัญชี" + nv_a4a_70 + CHR(10) +
                                  /*END Saharat S. A62-0279*/
                                  "rb_n_trndatto  = " + STRING(n_trndatto,"99/99/9999").

                  
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
            n_chk = 1.
            RELEASE Agtprm_fil.
END.

    IF n_chk = 1 THEN
       MESSAGE "Print Complete " VIEW-AS ALERT-BOX.
    ELSE 
       MESSAGE "Print Not Complete" VIEW-AS ALERT-BOX.
  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE ReportPR C-Win 
PROCEDURE ReportPR :
/*------------------------------------------------------------------------------
  Purpose: เลือกจาก producer  
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO:
           ASSIGN 
                n_chk = 0
                report-library  =  "Wac/wprl/wacrm69.prl"
                report-name     =  "Notic TA\PD".
                
        RB-FILTER    = 'agtprm_fil.asdat = ' + 
                              STRING (MONTH (n_asdat)) + "/" + 
                              STRING (DAY (n_asdat)) + "/" + 
                              STRING (YEAR (n_asdat)) + " AND " + 
                              "agtprm_fil.acno >= '" + vAcnoBe + "'" + " AND " + 
                              "agtprm_fil.acno <= '" + vAcnoFi + "'" + " AND " +
                              "agtprm_fil.poltyp = '" + "M69" + "'". 

          ASSIGN
              RB-INCLUDE-RECORDS    = "O"                                                                                                                                                                                                                    
              RB-PRINT-DESTINATION  = SUBSTR ("D A", rsOutput, 1)
              RB-PRINTER-NAME       = IF rsOutput = 2 THEN cbPrtList ELSE " "
              RB-OUTPUT-FILE        = IF rsOutput = 3 THEN fiFile-Name ELSE " "
              RB-NO-WAIT            = No
              RB-OTHER-PARAMETERS =  
                                  "rb_vCliCod = " + STRING(vCliCod) + CHR(10) +                                
                                  "rb_n_ContractName  = " + STRING(vContractName) + CHR(10) +
                                  "rb_n_Ext  = " + STRING(vExt) + CHR(10) +
                                  "rb_n_PowerName = " + STRING(vPowerName) + CHR(10) +
                                  "rb_n_Position = " + STRING(vPosition) + CHR(10) +
                                  "rb_n_Date = " + STRING(vDate) + CHR(10) +
                                  "rb_n_branch = " + STRING(n_branch) + CHR(10) +
                                  /*ADD Saharat S. A62-0279*/
                                  /*"rb_pic  = " + STRING(nv_pic) + CHR(10) +
                                  "rb_pic1  = " + STRING(nv_pic1) + CHR(10) + */
                                  "rb_pic  = " + nv_a4a_59 + CHR(10) +
                                  "rb_pic1  = " + nv_a4a_69 + CHR(10) +
                                  "rb_pich  = " + nv_a4a_07 + CHR(10) +
                                  "rb_TMSTH1  = " + "ตามที่ท่านได้ขอทำสัญญาประกันภัยประเภท เดินทาง ไว้กับ" + " " + nv_a4a_34 + " " + nv_a4a_03 + CHR(10) +
                                  "rb_TMSTH2  = " + "ชื่อบัญชี" + nv_a4a_70 + CHR(10) +
                                  /*END Saharat S. A62-0279*/
                                  "rb_n_trndatto  = " + STRING(n_trndatto,"99/99/9999").

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
            n_chk = 1.
            RELEASE Agtprm_fil.
END.

    IF n_chk = 1 THEN
       MESSAGE "Print Complete " VIEW-AS ALERT-BOX.
    ELSE 
       MESSAGE "Print Not Complete" VIEW-AS ALERT-BOX.
  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

