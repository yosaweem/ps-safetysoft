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

Wac
        -Wacr042.w
WPrl
        -Wacr042.prl
Whp
        -WhpBran.w
        -WhpAcno2.w

Created: A63-0125  Nattanicha K.   14/07/2020
*****************************************/    
/* ***************************  Definitions  ************************** */
DEF SHARED VAR n_User    AS CHAR.
DEF SHARED VAR n_Passwd  AS CHAR.
DEF        VAR nv_User   AS CHAR NO-UNDO. 
DEF        VAR nv_pwd    LIKE _password NO-UNDO. 

/* Definitons  Report -------                                               */

DEF  VAR report-library AS CHAR INIT "Wac/wprl/Wac042.prl". 
DEF  VAR report-name  AS CHAR INIT "Receivable Confirmation Letter_T". 

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
/*--- A500178 ---
DEF NEW SHARED VAR n_agent1  AS CHAR FORMAT "x(7)".
DEF NEW SHARED VAR n_agent2  AS CHAR FORMAT "x(7)".
------*/
DEF NEW SHARED VAR n_agent1  AS CHAR FORMAT "x(10)".
DEF NEW SHARED VAR n_agent2  AS CHAR FORMAT "x(10)".
DEF NEW SHARED VAR n_branch  AS CHAR FORMAT "x(2)".
DEF NEW SHARED VAR n_branch2 AS CHAR FORMAT "x(2)".
DEF NEW SHARED VAR n_tabcod  AS CHAR FORMAT "X(4)"    INIT "U021".   /* Table-Code  sym100*/
DEF NEW SHARED VAR n_itmcod  AS CHAR FORMAT "X(4)".

Def Var n_name     As Char Format "x(50)". /*acno name*/
Def Var n_chkname  As Char format "x(1)".  /* Acno-- chk button 1-2 */
Def Var n_bdes     As Char Format "x(50)". /*branch name*/
Def Var n_chkBname As Char format "x(1)".  /* branch-- chk button 1-2 */
Def Var n_itmdes   As Char Format "x(40)". /*Table-Code Description*/

/* Local Variable Definitions ---                                       */

DEF VAR nv_asmth   AS INTE INIT 0.
DEF VAR nv_frmth   AS INTE INIT 0.
DEF VAR nv_tomth   AS INTE INIT 0.
DEF VAR cv_mthlistT AS CHAR INIT "มกราคม,กุมภาพันธ์,มีนาคม,เมษายน,พฤษภาคม,มิถุนายน,กรกฎาคม,สิงหาคม,กันยายน,ตุลาคม,พฤศจิกายน,ธันวาคม".
DEF VAR cv_mthListE AS CHAR INIT "January, February, March, April, May, June, July, August, September, October, November, December".

DEF VAR n_asdat AS   DATE FORMAT "99/99/9999".
DEF VAR n_frbr  AS   CHAR   FORMAT "x(2)".
DEF VAR n_tobr  AS   CHAR   FORMAT "x(2)".
/*--- A500178 ---
DEF VAR n_frac  AS   CHAR   FORMAT "x(7)".
DEF VAR n_toac  AS   CHAR   FORMAT "x(7)".
------*/
DEF VAR n_frac  AS   CHAR   FORMAT "x(10)".
DEF VAR n_toac  AS   CHAR   FORMAT "x(10)".
DEF VAR n_typ   AS   CHAR   FORMAT "X".
DEF VAR n_typ1  AS   CHAR   FORMAT "X".

DEF VAR n_chkCopy    AS INTEGER.
DEF VAR n_OutputTo   AS INTEGER.
DEF VAR n_OutputFile AS Char.

DEF VAR vCliCod       AS CHAR.
DEF VAR vCliCodAll    AS CHAR.
DEF VAR vCountRec     AS INT.
DEF VAR vAcProc_fil   AS CHAR.
DEF VAR vAcProc_fil1  AS CHAR.

DEF VAR vDoc AS INT.
DEF VAR vDoc2 AS INT.

DEF VAR vContractName AS CHAR.
DEF VAR vExt AS CHAR.
DEF VAR vDate AS CHAR.
DEF VAR vMonth AS CHAR.
DEF VAR vYear AS CHAR.
DEF VAR vPowerName AS CHAR.
DEF VAR vPosition AS CHAR.

DEF VAR vMaxdoc AS INT.
DEF VAR vAcnoCount AS CHAR.

DEF BUFFER BuffAgtprm FOR agtprm_fil.

DEF VAR vAcnoInt AS CHAR INIT "1".
DEF VAR vAcnoBe AS CHAR.
DEF VAR vAcnoFi AS CHAR.
/*-- A58-0172 --*/
DEF VAR nv_pic AS CHAR INIT "". 
DEF VAR nv_bran AS CHAR FORMAT "x(2)".
DEF VAR n_int AS INT .
DEF VAR nv_year  AS CHAR INIT "".
DEF VAR nv_mon   AS CHAR INIT "".
DEF VAR nv_use   AS CHAR INIT "".
DEF VAR nv_docno AS INT INIT 0.
DEF VAR nv_doc1 AS INT INIT 0.
DEF VAR n_lbran AS CHAR.
DEF VAR branch AS CHAR.
DEF VAR n_branch1 AS CHAR.
DEF VAR n_type AS CHAR INIT "".
DEF TEMP-TABLE wdocno_fil 
        FIELD asdat     AS CHAR 
        FIELD bran      AS CHAR
        FIELD acno      AS CHAR 
        FIELD letterno  AS CHAR
    INDEX wdocno_fil01  letterno DESC 
                        asdat    DESC.

DEF VAR nv_bal      AS DECI FORMAT "->>>>>>>>9.99".
DEF VAR n_trndatfr  AS DATE FORMAT "99/99/9999".
DEF VAR n_trndatto  AS DATE FORMAT "99/99/9999".
DEF VAR n_trnty1    AS CHAR FORMAT  "X"  EXTENT 6.

DEF VAR nv_letterno  AS CHAR FORMAT "X(15)" INIT "".
DEF VAR nv_pol       AS CHAR FORMAT "X(15)" INIT "".
DEF VAR nv_insref    AS CHAR FORMAT "X(15)" INIT "".
DEF VAR nv_name      AS CHAR FORMAT "X(15)" INIT "".
DEF VAR nv_acno  AS CHAR FORMAT "x(10)".
DEF VAR nv_printdate AS DATE FORMAT "99/99/9999".
DEF VAR nv_addr1     AS CHAR FORMAT "X(100)".
DEF VAR nv_addr2     AS CHAR FORMAT "X(100)".
DEF VAR nv_addr3     AS CHAR FORMAT "X(100)".
DEF VAR nv_addr4     AS CHAR FORMAT "X(100)".
DEF VAR nv_asdate    AS DATE FORMAT "99/99/9999".
DEF VAR nv_lettyp    AS CHAR FORMAT "X(6)" INIT "".

  
/*-- end A58-0172--*/
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

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS RECT-87 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE RECTANGLE RECT-87
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 15 BY 4.43
     BGCOLOR 2 .

DEFINE RECTANGLE RECT-288
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 39 BY 4.62.

DEFINE BUTTON Btn_Cancel 
     LABEL "Cancel" 
     SIZE 15 BY 1.57
     BGCOLOR 4 FONT 36.

DEFINE BUTTON Btn_OK 
     LABEL "OK" 
     SIZE 15 BY 1.57
     FONT 36.

DEFINE RECTANGLE RECT-103
     EDGE-PIXELS 3 GRAPHIC-EDGE    
     SIZE 20 BY 5.76
     BGCOLOR 33 .

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

DEFINE RECTANGLE RECT-289
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 14 BY 3.57.

DEFINE RECTANGLE RECT-82
     EDGE-PIXELS 3 GRAPHIC-EDGE    
     SIZE 44.5 BY 4.43
     BGCOLOR 32 FGCOLOR 2 .

DEFINE BUTTON buAcno 
     LABEL "..." 
     SIZE 3 BY 1.05
     FONT 1.

DEFINE BUTTON buAcno2 
     LABEL "..." 
     SIZE 3 BY 1.05
     FONT 1.

DEFINE BUTTON buBranch 
     LABEL "..." 
     SIZE 3 BY 1 TOOLTIP "รหัสสาขา"
     FONT 1.

DEFINE BUTTON buBranch2 
     LABEL "..." 
     SIZE 3 BY 1 TOOLTIP "รหัสสาขา"
     FONT 1.

DEFINE VARIABLE fiacno1 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 14.33 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiacno2 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 14.33 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiAsdat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .95
     BGCOLOR 15 FGCOLOR 4  NO-UNDO.

DEFINE VARIABLE fibdes AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 38.5 BY 1
     BGCOLOR 34 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fibdes2 AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 38.5 BY 1
     BGCOLOR 34 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fiBranch AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 6.5 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fiBranch2 AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 6.5 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fiContractName AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 29 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fidoc AS CHARACTER FORMAT "X(4)":U INITIAL "0" 
     VIEW-AS FILL-IN 
     SIZE 7.5 BY 1
     BGCOLOR 34 FONT 6 NO-UNDO.

DEFINE VARIABLE fiDoc2 AS INTEGER FORMAT "99999":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 10.67 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiExt AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 15 FONT 1 NO-UNDO.

DEFINE VARIABLE finame1 AS CHARACTER FORMAT "X(50)":U 
      VIEW-AS TEXT 
     SIZE 36 BY 1.05
     BGCOLOR 34 FONT 6 NO-UNDO.

DEFINE VARIABLE finame2 AS CHARACTER FORMAT "X(50)":U 
      VIEW-AS TEXT 
     SIZE 36 BY 1.05
     BGCOLOR 34 FONT 6 NO-UNDO.

DEFINE VARIABLE fiPosition AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 32.83 BY 1
     BGCOLOR 34 FONT 6 NO-UNDO.

DEFINE VARIABLE fiPowerName AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 32.83 BY 1
     BGCOLOR 34 FONT 6 NO-UNDO.

DEFINE VARIABLE fiPrintdate AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fiTotprem AS DECIMAL FORMAT "->>>,>>>,>>>,>>9.99":U INITIAL 0 
      VIEW-AS TEXT 
     SIZE 29.5 BY .95
     BGCOLOR 32 FGCOLOR 6 FONT 6 NO-UNDO.

DEFINE VARIABLE fiTrndatfr AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .95
     BGCOLOR 15 FGCOLOR 4  NO-UNDO.

DEFINE VARIABLE fiTrndatto AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .95
     BGCOLOR 15 FGCOLOR 4  NO-UNDO.

DEFINE VARIABLE fiTrnty1 AS CHARACTER FORMAT "X":U 
     VIEW-AS FILL-IN 
     SIZE 3 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiTrnty2 AS CHARACTER FORMAT "X":U 
     VIEW-AS FILL-IN 
     SIZE 3 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiTrnty3 AS CHARACTER FORMAT "X":U 
     VIEW-AS FILL-IN 
     SIZE 3 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiTrnty4 AS CHARACTER FORMAT "X":U 
     VIEW-AS FILL-IN 
     SIZE 3 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiTrnty5 AS CHARACTER FORMAT "X":U 
     VIEW-AS FILL-IN 
     SIZE 3 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiTrnty6 AS CHARACTER FORMAT "X":U 
     VIEW-AS FILL-IN 
     SIZE 3 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE raOper AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "HO.", 1,
"BR.", 2
     SIZE 26.33 BY .86
     BGCOLOR 18 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-104
     EDGE-PIXELS 3 GRAPHIC-EDGE    
     SIZE 62.5 BY 1.57
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-106
     EDGE-PIXELS 3 GRAPHIC-EDGE    
     SIZE 115.5 BY 15.71
     BGCOLOR 33 .

DEFINE RECTANGLE RECT-108
     EDGE-PIXELS 3 GRAPHIC-EDGE    
     SIZE 48 BY 4.1
     BGCOLOR 32 .

DEFINE RECTANGLE RECT-109
     EDGE-PIXELS 3 GRAPHIC-EDGE    
     SIZE 62.5 BY 2.52
     BGCOLOR 32 .

DEFINE RECTANGLE RECT-110
     EDGE-PIXELS 3 GRAPHIC-EDGE    
     SIZE 47.83 BY 1.43
     BGCOLOR 32 .

DEFINE RECTANGLE RECT-290
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 62.5 BY 1.19.

DEFINE RECTANGLE RECT-291
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 62.5 BY 1.19.

DEFINE RECTANGLE RECT-292
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 62.5 BY 1.33.

DEFINE RECTANGLE RECT-293
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 62.5 BY 1.19.

DEFINE RECTANGLE RECT-296
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 48 BY 1.19.

DEFINE RECTANGLE RECT-297
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 48 BY 1.19.

DEFINE RECTANGLE RECT-83
     EDGE-PIXELS 3 GRAPHIC-EDGE    
     SIZE 62.5 BY 2.91
     BGCOLOR 32 FGCOLOR 2 .

DEFINE RECTANGLE RECT-84
     EDGE-PIXELS 3 GRAPHIC-EDGE    
     SIZE 62.5 BY 2.95
     BGCOLOR 32 .

DEFINE RECTANGLE RECT-85
     EDGE-PIXELS 3 GRAPHIC-EDGE    
     SIZE 62.5 BY 4.48
     BGCOLOR 32 FGCOLOR 2 .

DEFINE RECTANGLE RECT-88
     EDGE-PIXELS 3 GRAPHIC-EDGE    
     SIZE 48 BY 4.48
     BGCOLOR 32 .

DEFINE RECTANGLE RECT-89
     EDGE-PIXELS 3 GRAPHIC-EDGE    
     SIZE 48 BY 2.86
     BGCOLOR 32 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     RECT-87 AT ROW 11.19 COL 104
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 25.09
         BGCOLOR 34 FGCOLOR 0 .

DEFINE FRAME FRAME-A
     " 4. ให้นำ Letter No ที่ได้มาใส่ที่ช่อง Letter No" VIEW-AS TEXT
          SIZE 38.17 BY 1.29 AT ROW 5.43 COL 2.5
          BGCOLOR 32 FGCOLOR 2 
     " 1. คลิกพิมพ์ซ้ำ" VIEW-AS TEXT
          SIZE 38.17 BY 1.05 AT ROW 2.38 COL 2.5
          BGCOLOR 32 FGCOLOR 2 
     "วิธีการพิมพ์ซ้ำ" VIEW-AS TEXT
          SIZE 41 BY 1.05 AT ROW 1 COL 1
          BGCOLOR 1 FGCOLOR 7 FONT 6
     " 3. ถ้าไม่ทราบคลิกปุ่ม OK เครื่องจะบอก Letter No" VIEW-AS TEXT
          SIZE 38.17 BY 1.05 AT ROW 4.48 COL 2.5
          BGCOLOR 32 FGCOLOR 2 
     " 2. ถ้าทราบ Letter No เดิมให้ใส่ที่ช่อง Letter No" VIEW-AS TEXT
          SIZE 38.17 BY 1.05 AT ROW 3.43 COL 2.5
          BGCOLOR 32 FGCOLOR 2 
     RECT-288 AT ROW 2.24 COL 2.17
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 59.5 ROW 19.48
         SIZE 41.5 BY 6.48
         BGCOLOR 3 .

DEFINE FRAME frbtn
     Btn_OK AT ROW 2.05 COL 5
     Btn_Cancel AT ROW 4.67 COL 5
     RECT-103 AT ROW 1.29 COL 2.5
     RECT-95 AT ROW 1.76 COL 4
     RECT-97 AT ROW 4.38 COL 4
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 103 ROW 19.48
         SIZE 23.5 BY 6.48
         BGCOLOR 3 .

DEFINE FRAME frOutput
     rsOutput AT ROW 2.81 COL 4.67 NO-LABEL
     cbPrtList AT ROW 3.86 COL 16.67 COLON-ALIGNED NO-LABEL
     fiFile-Name AT ROW 5.14 COL 16.83 COLON-ALIGNED NO-LABEL
     " Output To":10 VIEW-AS TEXT
          SIZE 48.5 BY 1.05 AT ROW 1 COL 1
          BGCOLOR 1 FGCOLOR 7 FONT 2
     RECT-82 AT ROW 2.29 COL 3
     RECT-289 AT ROW 2.71 COL 4.17
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 8 ROW 19.48
         SIZE 49 BY 6.48
         BGCOLOR 3 .

DEFINE FRAME frSt
     fiacno1 AT ROW 3.91 COL 9.67 COLON-ALIGNED NO-LABEL
     fiacno2 AT ROW 5.1 COL 9.67 COLON-ALIGNED NO-LABEL
     fiTrndatfr AT ROW 8.57 COL 20.5 COLON-ALIGNED NO-LABEL WIDGET-ID 38
     fiTrndatto AT ROW 8.57 COL 40.83 COLON-ALIGNED NO-LABEL WIDGET-ID 44
     fiAsdat AT ROW 9.76 COL 20.5 COLON-ALIGNED NO-LABEL WIDGET-ID 14
     fiContractName AT ROW 13.14 COL 83.67 COLON-ALIGNED NO-LABEL
     fiTotprem AT ROW 16.76 COL 16.33 COLON-ALIGNED NO-LABEL WIDGET-ID 24
     fiExt AT ROW 14.52 COL 87.33 COLON-ALIGNED NO-LABEL
     raOper AT ROW 11.81 COL 85.67 NO-LABEL WIDGET-ID 30
     fiBranch AT ROW 13.14 COL 10.5 COLON-ALIGNED NO-LABEL
     fiPrintdate AT ROW 8.91 COL 85.17 COLON-ALIGNED NO-LABEL WIDGET-ID 34
     fiDoc2 AT ROW 3.95 COL 89.33 COLON-ALIGNED NO-LABEL
     fiBranch2 AT ROW 14.33 COL 10.5 COLON-ALIGNED NO-LABEL
     fidoc AT ROW 3.95 COL 79.33 COLON-ALIGNED NO-LABEL
     buBranch AT ROW 13.14 COL 19
     buBranch2 AT ROW 14.33 COL 19
     fiTrnty1 AT ROW 17.38 COL 80.83 COLON-ALIGNED NO-LABEL WIDGET-ID 52
     fiPowerName AT ROW 5.38 COL 79.17 COLON-ALIGNED NO-LABEL
     fiTrnty2 AT ROW 17.38 COL 84.33 COLON-ALIGNED NO-LABEL WIDGET-ID 54
     fiTrnty3 AT ROW 17.38 COL 87.83 COLON-ALIGNED NO-LABEL WIDGET-ID 56
     fiPosition AT ROW 6.71 COL 79.17 COLON-ALIGNED NO-LABEL
     fiTrnty4 AT ROW 17.38 COL 91.33 COLON-ALIGNED NO-LABEL WIDGET-ID 58
     fiTrnty5 AT ROW 17.38 COL 94.83 COLON-ALIGNED NO-LABEL WIDGET-ID 60
     fiTrnty6 AT ROW 17.38 COL 98.33 COLON-ALIGNED NO-LABEL WIDGET-ID 62
     buAcno AT ROW 3.91 COL 26
     buAcno2 AT ROW 5.1 COL 26
     fibdes AT ROW 13.14 COL 21.5 COLON-ALIGNED NO-LABEL
     fibdes2 AT ROW 14.33 COL 21.5 COLON-ALIGNED NO-LABEL
     finame1 AT ROW 3.86 COL 27.5 COLON-ALIGNED NO-LABEL
     finame2 AT ROW 5.05 COL 27.5 COLON-ALIGNED NO-LABEL
     "ชื่อผู้มีอำนาจ":20 VIEW-AS TEXT
          SIZE 11.5 BY 1 AT ROW 5.38 COL 69.5
          BGCOLOR 32 FGCOLOR 2 FONT 6
     " As Of Date":20 VIEW-AS TEXT
          SIZE 12.17 BY .95 AT ROW 9.76 COL 9.67 WIDGET-ID 10
          BGCOLOR 32 FGCOLOR 2 FONT 6
     "From" VIEW-AS TEXT
          SIZE 5.5 BY 1.05 AT ROW 13.14 COL 6
          BGCOLOR 32 FGCOLOR 2 FONT 6
     "To" VIEW-AS TEXT
          SIZE 4.5 BY 1.05 AT ROW 5.1 COL 5.5
          BGCOLOR 32 FGCOLOR 2 FONT 6
     " Producer Code":20 VIEW-AS TEXT
          SIZE 61.67 BY 1.05 AT ROW 2.43 COL 4.5
          BGCOLOR 18 FGCOLOR 4 FONT 2
     " Extension Number :":30 VIEW-AS TEXT
          SIZE 19.67 BY 1.05 AT ROW 14.52 COL 68.83
          BGCOLOR 32 FGCOLOR 2 FONT 6
     " Letter Detail":20 VIEW-AS TEXT
          SIZE 47 BY 1 AT ROW 2.57 COL 68.5
          BGCOLOR 18 FGCOLOR 4 FONT 2
     " Branch" VIEW-AS TEXT
          SIZE 61.67 BY 1.05 AT ROW 11.71 COL 4
          BGCOLOR 18 FGCOLOR 4 FONT 2
     "/" VIEW-AS TEXT
          SIZE 1.5 BY 1.05 AT ROW 3.95 COL 89.33
          BGCOLOR 32 FGCOLOR 0 FONT 2
     " Contract" VIEW-AS TEXT
          SIZE 47.17 BY 1 AT ROW 11.81 COL 68.5
          BGCOLOR 18 FGCOLOR 4 FONT 2
     "Trans.Date From":20 VIEW-AS TEXT
          SIZE 16.33 BY .95 AT ROW 8.57 COL 5.67 WIDGET-ID 40
          BGCOLOR 32 FGCOLOR 2 FONT 6
     "                        Letter to Accounts Receivable Confirmation" VIEW-AS TEXT
          SIZE 118 BY 1.05 AT ROW 1.1 COL 1
          BGCOLOR 1 FGCOLOR 7 FONT 2
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 8 ROW 1.29
         SIZE 118.33 BY 18.05
         BGCOLOR 3 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME frSt
     "Premium:" VIEW-AS TEXT
          SIZE 9.5 BY 1 AT ROW 16.71 COL 7.5 WIDGET-ID 28
          BGCOLOR 32 FGCOLOR 4 FONT 6
     "ที่ กง. R":10 VIEW-AS TEXT
          SIZE 8 BY 1.05 AT ROW 3.95 COL 73
          BGCOLOR 32 FGCOLOR 2 FONT 6
     " Print Date":20 VIEW-AS TEXT
          SIZE 17 BY .95 AT ROW 8.95 COL 69.67 WIDGET-ID 36
          BGCOLOR 18 FGCOLOR 4 FONT 2
     "To":20 VIEW-AS TEXT
          SIZE 4 BY .95 AT ROW 8.57 COL 38.17 WIDGET-ID 42
          BGCOLOR 32 FGCOLOR 2 FONT 6
     " Date" VIEW-AS TEXT
          SIZE 61.67 BY 1.05 AT ROW 6.91 COL 4.5 WIDGET-ID 46
          BGCOLOR 18 FGCOLOR 4 FONT 2
     "Trn. Typ.":30 VIEW-AS TEXT
          SIZE 9.5 BY 1.05 AT ROW 17.29 COL 70 WIDGET-ID 66
          BGCOLOR 32 FGCOLOR 2 FONT 6
     "ตำแหน่ง" VIEW-AS TEXT
          SIZE 7.5 BY 1 AT ROW 6.71 COL 69.83
          BGCOLOR 32 FGCOLOR 2 FONT 6
     "To" VIEW-AS TEXT
          SIZE 3.5 BY 1.05 AT ROW 14.33 COL 6
          BGCOLOR 32 FGCOLOR 2 FONT 6
     " Contract Name :":30 VIEW-AS TEXT
          SIZE 16.83 BY 1.05 AT ROW 13.14 COL 68.83
          BGCOLOR 32 FGCOLOR 2 FONT 6
     "From" VIEW-AS TEXT
          SIZE 5.5 BY 1.05 AT ROW 3.91 COL 5.5
          BGCOLOR 32 FGCOLOR 2 FONT 6
     RECT-104 AT ROW 13.76 COL 4
     RECT-106 AT ROW 3.14 COL 2
     RECT-108 AT ROW 12.67 COL 68
     RECT-83 AT ROW 3.52 COL 4
     RECT-84 AT ROW 12.62 COL 4
     RECT-88 AT ROW 3.71 COL 68
     RECT-290 AT ROW 2.33 COL 4
     RECT-291 AT ROW 2.43 COL 4.17
     RECT-292 AT ROW 11.57 COL 4
     RECT-296 AT ROW 2.43 COL 68
     RECT-297 AT ROW 11.62 COL 68
     RECT-89 AT ROW 8.38 COL 68 WIDGET-ID 12
     RECT-109 AT ROW 16 COL 4.5 WIDGET-ID 26
     RECT-85 AT ROW 6.71 COL 4 WIDGET-ID 48
     RECT-293 AT ROW 6.95 COL 4 WIDGET-ID 50
     RECT-110 AT ROW 17.1 COL 68.17 WIDGET-ID 64
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 8 ROW 1.29
         SIZE 118.33 BY 18.05
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
         TITLE              = "Wacr042 - Letter to Accounts Receivable Confirmation"
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

DEFINE VARIABLE XXTABVALXX AS LOGICAL NO-UNDO.

ASSIGN XXTABVALXX = FRAME frOutput:MOVE-BEFORE-TAB-ITEM (FRAME frbtn:HANDLE)
/* END-ASSIGN-TABS */.

/* SETTINGS FOR FRAME FRAME-A
                                                                        */
/* SETTINGS FOR FRAME frbtn
                                                                        */
/* SETTINGS FOR FRAME frOutput
                                                                        */
/* SETTINGS FOR FRAME frSt
   Custom                                                               */
/* SETTINGS FOR FILL-IN fidoc IN FRAME frSt
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Wacr042 - Letter to Accounts Receivable Confirmation */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Wacr042 - Letter to Accounts Receivable Confirmation */
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
            FRAME frST fibranch fibranch
            FRAME frST fibranch2 fibranch2
            FRAME frST fiTrndatfr fiTrndatfr
            FRAME frST fiTrndatto fiTrndatto
            FRAME frST fiacno1 fiacno1
            FRAME frST fiacno2 fiacno2
            FRAME frST fiDoc fiDoc
            FRAME frST fiDoc2 fiDoc2
            FRAME frST fiContractName fiContractName
            FRAME frST fiExt fiExt
            FRAME frST fiPowerName fiPowerName
            FRAME frST fiPosition fiPosition
            FRAME frST fiTrnty1 fiTrnty1
            FRAME frST fiTrnty2 fiTrnty2
            FRAME frST fiTrnty3 fiTrnty3
            FRAME frST fiTrnty4 fiTrnty4
            FRAME frST fiTrnty5 fiTrnty5
            FRAME frST fiTrnty6 fiTrnty6
                                            
            FRAME frOutput rsOutput rsOutput
            FRAME frOutput cbPrtList cbPrtList
            FRAME frOutput fiFile-Name fiFile-Name

            vContractName = fiContractName
            vExt       = fiExt
            vPowerName = fiPowerName
            vPosition  = fiPosition
            vAcnoInt   = "1"

            n_branch  = fiBranch
            n_branch2 = fiBranch2 
            n_trndatfr = fiTrndatfr
            n_trndatto = fiTrndatto
            n_frac    =  fiAcno1
            n_toac    =  fiAcno2 
            n_asdat   =  fiAsdat  
            n_Trnty1[1]    =  fiTrnty1  
            n_Trnty1[2]    =  fiTrnty2  
            n_Trnty1[3]    =  fiTrnty3  
            n_Trnty1[4]    =  fiTrnty4  
            n_Trnty1[5]    =  fiTrnty5  
            n_Trnty1[6]    =  fiTrnty6 
            n_OutputTo    =  rsOutput
            n_OutputFile  =  fiFile-Name
            vMaxdoc =   INTEGER(fiDoc + STRING(fiDoc2, "9999")).
    
   END.

   
   IF  n_frac = "" THEN  n_frac = "A000000".
   IF  n_toac = "" THEN  n_toac = "B999999999". 

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
   
      /*IF fiDoc2 = 0 THEN DO:
            Message "Please Input Letter No" VIEW-AS ALERT-BOX ERROR.
            Apply "Entry" To fiDoc2.
            RETURN NO-APPLY.
      END.
      */
      
      IF n_OutputTo = 3 And n_OutputFile = ""    THEN DO:
            Message "Please Input File Name" VIEW-AS ALERT-BOX ERROR. 
            Apply "Entry" To  fiFile-Name .
            RETURN NO-APPLY.       
      END.

 
 
      IF ( n_branch <> n_branch2)   THEN DO:
             Message "INCORRECT Branch" SKIP(1)
                     "Branch To Must be equal to Branch From" VIEW-AS ALERT-BOX ERROR. 
             Apply "Entry" To fibranch2.
             RETURN NO-APPLY.       
      END.

     IF ( n_frac > n_toac)  AND (n_frac = "" OR n_toac = "") THEN DO:
            Message "INCORRECT Producer Code" SKIP(1)
                     "Producer Code To Must be greater than Producer Code From" VIEW-AS ALERT-BOX ERROR. 
            Apply "Entry" To fiacno2  .
            RETURN NO-APPLY.       
      END.  
    
      IF n_asdat = ?   THEN DO:
            MESSAGE "ไม่พบข้อมูล  กรุณาตรวจสอบการ Process ข้อมูล" VIEW-AS ALERT-BOX ERROR.
      END.
      ELSE DO:
          MESSAGE "Branch : "  n_Branch " ถึง " n_Branch2 SKIP (1)
                              "Producer Code  : "  n_frac " ถึง " n_toac SKIP (1)
                              "As Of Date     : " STRING(n_asdat,"99/99/9999") SKIP (1)
                              VIEW-AS ALERT-BOX QUESTION
          BUTTONS YES-NO
          TITLE "Confirm"    UPDATE CHOICE AS LOGICAL.
          CASE CHOICE:
          WHEN TRUE THEN    DO:
              /*RUN ProcPrint.   */
              RUN procPrint1.
          END.
          WHEN FALSE THEN    DO:
              RETURN NO-APPLY. 
          END.
          END CASE.  
      
      END.   /* else IF asdat = ? */ 
/*--- end A58-0172 ---*/

      /*RUN ProcPrint. ---A58-0172 --*/
  
/*หาค่ามากที่สุดของเลขที่จดหมาย กรณีทำงานต่อโดยที่ยังไม่ออกจากโปรแกรม*/

  /*  RUN pdRunningNo.   /* หา running no เบอร์ ล่าสุด ใน table docno_fil */ */
/*
    toReprint = FALSE.
    DISPLAY toReprint WITH FRAME frSt.
    RUN pdDisable.
    */

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


&Scoped-define SELF-NAME buBranch
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buBranch C-Win
ON CHOOSE OF buBranch IN FRAME frSt /* ... */
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
ON CHOOSE OF buBranch2 IN FRAME frSt /* ... */
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


&Scoped-define SELF-NAME fiacno1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiacno1 C-Win
ON LEAVE OF fiacno1 IN FRAME frSt
DO:
    ASSIGN
        fiacno1 = input fiacno1
        n_agent1  = fiacno1.
        
    IF fiAcno1 <> "" THEN DO :
    
        FIND   xmm600 WHERE xmm600.acno = n_agent1  NO-LOCK NO-ERROR.
            IF AVAILABLE xmm600 THEN DO:
                finame1:Screen-value IN FRAME {&FRAME-NAME} = xmm600.name.
                fiBranch:Screen-value IN FRAME {&FRAME-NAME} = xmm600.homebr.
                fiBranch2:Screen-value IN FRAME {&FRAME-NAME} = xmm600.homebr.
            END.        
            ELSE DO:
                fiAcno1 = "".
                finame1:Screen-value IN FRAME {&FRAME-NAME} = "Not Found !".
                MESSAGE "Not Found Producer Code" VIEW-AS ALERT-BOX  ERROR.
/*                APPLY "ENTRY" TO fiacno1 IN FRAME frST.
 *                 RETURN NO-APPLY.*/
            END.
    END.

    n_agent1  = CAPS (fiAcno1).
    n_branch  = fiBranch.
    n_branch2 = fiBranch2.
    
    DISP n_agent1 @ fiAcno1
          n_agent1 @ fiAcno2 
           WITH FRAME frST.

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

    IF fiacno2 <> fiacno1 THEN DO:
        MESSAGE "INCORRECT Producer Code" SKIP(1)
                         "Producer Code To Must be equal Producer Code From" 
           VIEW-AS ALERT-BOX ERROR. 
        APPLY "Entry" TO fiacno2  .
        Return No-Apply.   
    END.
        
    DISP CAPS (fiAcno1) @ fiAcno2 WITH FRAME frST.
    
    IF INPUT  FiAcno2 <> "" Then Do :  

        FIND   xmm600 WHERE xmm600.acno = n_agent2  NO-ERROR.
        IF AVAILABLE xmm600 THEN DO:
            finame2:Screen-value IN FRAME {&FRAME-NAME} = xmm600.name.
            fiBranch2:Screen-value IN FRAME {&FRAME-NAME} = xmm600.homebr.
        END.        
        ELSE DO:
            fiAcno2 = "".
            finame2:Screen-value IN FRAME {&FRAME-NAME} = "Not Found !".
            MESSAGE "Not Found Producer Code" VIEW-AS ALERT-BOX  ERROR.
        END.
    END.
    
     DISP CAPS (fiAcno2) @ fiAcno2 WITH FRAME frST.
  

   /* IF (fiacno1 > fiacno2)  AND (fiacno1 <> "" AND fiacno2 <> "")   THEN DO:
        Message "INCORRECT Producer Code" SKIP(1)
                         "Producer Code To Must be greater than Producer Code From" 
           VIEW-AS ALERT-BOX ERROR. 
        APPLY "Entry" TO fiacno2  .
        Return No-Apply.       
    END.
    */
    
END.

/*
    IF Input  FiAcno2 <> "" THEN DO:
    
        FIND   xmm600 WHERE xmm600.acno = n_agent2  NO-LOCK NO-ERROR.
            IF AVAILABLE xmm600 THEN DO:
                finame2:Screen-value IN FRAME {&FRAME-NAME} = xmm600.name.
            END.        
            ELSE DO:
                fiAcno2 = "".
                finame2:Screen-value IN FRAME {&FRAME-NAME} = "Not Found !".
                MESSAGE "Not Found Producer Code" VIEW-AS ALERT-BOX  ERROR.
                APPLY "ENTRY" TO fiacno2 IN FRAME frST.
                RETURN NO-APPLY.
            END.
    END.
*/

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiAsdat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiAsdat C-Win
ON LEAVE OF fiAsdat IN FRAME frSt
DO:
    fiAsdat = INPUT fiasdat.
    nv_asdate = fiAsdat.

    IF fiAsdat = ? THEN DO:
       MESSAGE "Please Enter As of Date" VIEW-AS ALERT-BOX.
       APPLY "Entry" TO fiAsdat IN FRAME frST.
       RETURN NO-APPLY.
    END.
    DISP fiAsdat WITH FRAME frST.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiBranch
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiBranch C-Win
ON LEAVE OF fiBranch IN FRAME frSt
DO:
    Assign
        fibranch = INPUT fibranch
        n_branch = fibranch.
  /*MESSAGE "f1" n_branch VIEW-AS ALERT-BOX. */
  DISP CAPS(fibranch) @ fibranch WITH FRAME frST.
  
  FIND   xmm023 WHERE xmm023.branch = n_branch NO-LOCK NO-ERROR.
    IF AVAILABLE xmm023 THEN DO:
              fibdes:Screen-value IN FRAME {&FRAME-NAME} = xmm023.bdes.
              fibdes2:Screen-value IN FRAME {&FRAME-NAME} = xmm023.bdes.
    END.        
    ELSE DO:
              fibdes:Screen-value IN FRAME {&FRAME-NAME} = "Not Found !".
              MESSAGE "Not Found Branch" VIEW-AS ALERT-BOX  ERROR .
              APPLY "ENTRY" TO fiBranch IN FRAME frST.
              RETURN NO-APPLY.
    END.
  
  ASSIGN
    fibranch2 = fibranch.
    
  DISP CAPS(fibranch2) @ fibranch2 WITH FRAME frST.
/*  
    IF ( fibranch <> fibranch2)   THEN DO:
        Message "INCORRECT Branch" SKIP(1)
                              "Branch To Must be equal to Branch From" VIEW-AS ALERT-BOX ERROR. 
        Apply "Entry" To fibranch2.
        Return No-Apply.       
    END.     
*/   
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiBranch C-Win
ON RETURN OF fiBranch IN FRAME frSt
DO:
/*  Assign
    fibranch = input fibranch
    n_branch  = fibranch.
  
  FIND   xmm023 WHERE xmm023.branch = n_branch  NO-LOCK NO-ERROR.
    IF AVAILABLE xmm023 THEN DO:
              fibdes:Screen-value IN FRAME {&FRAME-NAME} = xmm023.bdes.
              fibdes2:Screen-value IN FRAME {&FRAME-NAME} = xmm023.bdes.
    END.        
    ELSE DO:
              fibdes:Screen-value IN FRAME {&FRAME-NAME} = "Not Found !".
              MESSAGE "Not Found Branch" VIEW-AS ALERT-BOX  ERROR .
              APPLY "ENTRY" TO fiBranch IN FRAME frST.
    END.
*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiBranch2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiBranch2 C-Win
ON LEAVE OF fiBranch2 IN FRAME frSt
DO:
     Assign
         fibranch2 = INPUT fibranch2
         n_branch2  = fibranch2.
    /* MESSAGE "f2" n_branch2 VIEW-AS ALERT-BOX.*/
         
     FIND   xmm023 WHERE xmm023.branch = n_branch2 NO-LOCK NO-ERROR.
        IF AVAILABLE xmm023 THEN DO:
              fibdes2:Screen-value IN FRAME {&FRAME-NAME} = xmm023.bdes.
        END.        
        ELSE DO: 
              fibdes2:Screen-value IN FRAME {&FRAME-NAME} = "Not Found !".
              MESSAGE "Not Found Branch" VIEW-AS ALERT-BOX ERROR.
              APPLY "ENTRY" TO fiBranch2 IN FRAME frST.
              RETURN NO-APPLY.
        END.       
    DISP CAPS(fibranch2)@ fibranch2 WITH FRAME frST.         
    RUN pdRunningNo.   /* หา running no เบอร์ ล่าสุด ใน table docno_fil */
    IF (fibranch <> fibranch2)   THEN DO:
        Message "INCORRECT Branch" SKIP(1)
                              "Branch To Must be equal to Branch From" VIEW-AS ALERT-BOX ERROR. 
        Apply "Entry" To fibranch2.
        Return No-Apply.       
    END.    

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiBranch2 C-Win
ON RETURN OF fiBranch2 IN FRAME frSt
DO:
  /*Assign
    fibranch2 = input fibranch2
    n_branch2  = fibranch2.
  
/*  FIND   xmm023 WHERE xmm023.branch = n_branch2  NO-LOCK NO-ERROR.
    IF AVAILABLE xmm023 THEN DO:
              fibdes2:Screen-value IN FRAME {&FRAME-NAME} = xmm023.bdes.
    END.        
    ELSE DO:
              fibdes2:Screen-value IN FRAME {&FRAME-NAME} = "Not Found !".
              MESSAGE "Not Found Branch" VIEW-AS ALERT-BOX ERROR.
              APPLY "ENTRY" TO fiBranch2 IN FRAME frST. 
    END. */
    
    IF (n_branch <> n_branch2)   THEN DO:
        Message "INCORRECT Branch" SKIP(1)
                              "Branch To Must be equal to Branch From" VIEW-AS ALERT-BOX ERROR. 
        Apply "Entry" To fibranch2.
        Return No-Apply.       
    END.    */

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiContractName
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiContractName C-Win
ON LEAVE OF fiContractName IN FRAME frSt
DO:
  fiContractName = INPUT fiContractName.
  

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fidoc
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fidoc C-Win
ON LEAVE OF fidoc IN FRAME frSt
DO:
  ASSIGN
  fiDoc = INPUT fiDoc.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiDoc2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiDoc2 C-Win
ON LEAVE OF fiDoc2 IN FRAME frSt
DO:
  /*ASSIGN
     fiDoc2 = INPUT fiDoc2.
  
  IF fiDoc2 = 0 THEN DO:
     Message "Please Input Letter No" VIEW-AS ALERT-BOX ERROR.
     Apply "Entry" To fiDoc .
     Return No-Apply.
  END.
  */
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


&Scoped-define SELF-NAME fiTrndatfr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiTrndatfr C-Win
ON LEAVE OF fiTrndatfr IN FRAME frSt
DO:
  fiTrndatfr = INPUT fiTrndatfr.

  DISP fiTrndatfr WITH FRAME frst.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiTrndatto
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiTrndatto C-Win
ON LEAVE OF fiTrndatto IN FRAME frSt
DO:
  fiTrndatto = INPUT fiTrndatto.
  fiasdat = TODAY.

  DISP fiTrndatto fiasdat WITH FRAME frst.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiTrnty1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiTrnty1 C-Win
ON LEAVE OF fiTrnty1 IN FRAME frSt
DO:
  fiTrnty1 = INPUT fiTrnty1.
  DISP fiTrnty1 WITH FRAME frST.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiTrnty2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiTrnty2 C-Win
ON LEAVE OF fiTrnty2 IN FRAME frSt
DO:
  fiTrnty2 = INPUT fiTrnty2.
  DISP fiTrnty2 WITH FRAME frST.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiTrnty3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiTrnty3 C-Win
ON LEAVE OF fiTrnty3 IN FRAME frSt
DO:
  fiTrnty3 = INPUT fiTrnty3.
  DISP fiTrnty3 WITH FRAME frST.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiTrnty4
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiTrnty4 C-Win
ON LEAVE OF fiTrnty4 IN FRAME frSt
DO:
  fiTrnty4 = INPUT fiTrnty4.
  DISP fiTrnty4 WITH FRAME frST.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiTrnty5
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiTrnty5 C-Win
ON LEAVE OF fiTrnty5 IN FRAME frSt
DO:
  fiTrnty5 = INPUT fiTrnty5.
  DISP fiTrnty5 WITH FRAME frST.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiTrnty6
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiTrnty6 C-Win
ON LEAVE OF fiTrnty6 IN FRAME frSt
DO:
  fiTrnty6 = INPUT fiTrnty6.
  DISP fiTrnty6 WITH FRAME frST.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME raOper
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL raOper C-Win
ON VALUE-CHANGED OF raOper IN FRAME frSt
DO:
  raOper = INPUT raOper.

  CASE raOper:

      WHEN 1 THEN DO:  

          ASSIGN fiContractName = nv_a4a_43        
                 /*fiMansta  = nv_a4a_46 */
                 fiext = "โทรศัพท์".
          DISP fiContractName fiext WITH FRAME frSt.
          
      END. /* when 1 สำนักงานใหญ่ */

      WHEN 2 THEN DO:  

          ASSIGN fiContractName = nv_a4a_48         
                 /*fiMansta = nv_a4a_50 */
                 fiext = "โทรศัพท์.".
          
          DISP fiContractName fiext WITH FRAME frSt.
         
            
      END. /* when 2 สาขา */
  END CASE.

  DISP raOper WITH FRAME frst.
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
           fiFile-Name:BGCOLOR = 34.
        WHEN 2 THEN  /* Printer */
          ASSIGN
           cbPrtList:SENSITIVE   = Yes
           fiFile-Name:SENSITIVE = No         
           fiFile-Name:BGCOLOR = 34.
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
  
  CURRENT-WINDOW:WINDOW-STATE = WINDOW-MAXIMIZED.
    /*RUN Wut\WutwiCen (C-Win:HANDLE).*/
    SESSION:DATA-ENTRY-RETURN = YES.
  
    
/********************  T I T L E   F O R  C - W I N  ****************/
  DEF  VAR  gv_prgid   AS   CHAR.
  DEF  VAR  gv_prog    AS   CHAR.
  
  gv_prgid = "wacr042".
  gv_prog  = "Letter to Accounts Receivable Confirmation".
  RUN  WUT\WUTHEAD (c-win:handle,gv_prgid,gv_prog).
  RUN  WUT\WUTDICEN (c-win:HANDLE).

/*********************************************************************/

    RUN ProcGetPrtList.

    ASSIGN
      rsOutput:Radio-Buttons = "Screen, 1,Printer, 2, File, 3"
      rsOutput = 2
      fiFile-Name:BGCOLOR = 34
      cbPrtList:SENSITIVE    = Yes
      fiFile-Name:SENSITIVE  = No.
    DISPLAY rsOutput WITH FRAME frOutput . 

    DO WITH FRAME frST:
        ASSIGN  
            fiacno1    = "A000000"
            fiacno2    = "A000000"
            fibranch   = "0"
            fibranch2  = "0" 
            n_lbran   =  "0" 
            n_asdat    = ?
            raOper     = 1
            fiTrndatfr  = TODAY
            fiTrndatto  = TODAY
            fiPrintDate = TODAY
            fiAsdat     = TODAY
            n_asdat    = fiasdat
            n_type     = ""
            n_trnty1[1]  =  "M" 
            n_trnty1[2]  =  "R" 
            n_trnty1[3]  =  "A" 
            n_trnty1[4]  =  "B" 
            n_trnty1[5]  =  " " 
            n_trnty1[6]  =  " "
            fitrnty1  =  n_trnty1[1] 
            fitrnty2  =  n_trnty1[2] 
            fitrnty3  =  n_trnty1[3] 
            fitrnty4  =  n_trnty1[4] 
            fitrnty5  =  n_trnty1[5] 
            fitrnty6  =  n_trnty1[6]
            fiDoc = SUBSTRING(STRING(YEAR(n_asdat ) + 543),3,2) + STRING(MONTH(TODAY),"99")    
            nv_lettyp = "LAR".

        DISPLAY  fibranch fibranch2 fiacno1 fiacno2 
                 fitrnty1 fitrnty2 fitrnty3
                 fitrnty4 fitrnty5 fitrnty6
                 fiTrndatfr fiTrndatto fiPrintDate fiAsdat fidoc.  

        RUN pdbranch.
        /*RUN pdRunningNo.   /* หา running no เบอร์ ล่าสุด ใน table docno_fil */  */ 

        RUN wuw\wuwppics3a (INPUT fiPrintDate, "dusit_pic_th", OUTPUT nv_pic).
        RUN wuw\wuwppics3a (INPUT fiPrintDate, "dusit_txt_th", OUTPUT fiPowerName).
        RUN wuw\wuwppics3a (INPUT fiPrintDate, "dusit_pos_th", OUTPUT fiPosition).  
        
        IF nv_pic = ? OR nv_pic = "" THEN DO:
            MESSAGE "not found picture" VIEW-AS ALERT-BOX.
        END.

        DISP fiPowerName fiPosition .

        ASSIGN /*fiContractName = nv_a4a_43        */
               fiContractName = "ชื่อผู้ติดต่อ"
               fiext = "โทรศัพท์".
        DISP fiContractName fiext WITH FRAME frSt.

    END.

   /* RUN pdUpdateQ.*/
   
    /*RUN pdDisable.        /*  DISABLE fiDoc2 เมื่อต้องการพิมพ์ปกติ */*/
    
    APPLY "ENTRY" TO fiBranch IN FRAME frSt.
   
  
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
/*------------------Ranu : A58-0712 --------------------*/
ASSIGN
        nv_doc1 = 0
        nv_year = SUBstr(STRING(YEAR(TODAY) + 543,"9999"),3,2)
        nv_mon  = STRING(MONTH(TODAY),"99")
        nv_use  = nv_year + nv_mon.
        /*-- for each เอาเลขที่จดหมายปัจจุบัน--*/
   FOR EACH docno_fil USE-INDEX docno01 WHERE LENGTH(docno_fil.branch) = 10 AND docno_fil.poltyp = n_branch 
                                        NO-LOCK BREAK BY docno_fil.startno DESC.
        IF SUBSTR(STRING(docno_fil.startno),1,4) = nv_use THEN DO:
                nv_doc1 = docno_fil.startno.
                LEAVE.
        END.
        ELSE DO:
                nv_doc1 = 0.
        END.
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
  ENABLE RECT-87 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  DISPLAY fiacno1 fiacno2 fiTrndatfr fiTrndatto fiAsdat fiContractName fiTotprem 
          fiExt raOper fiBranch fiPrintdate fiDoc2 fiBranch2 fidoc fiTrnty1 
          fiPowerName fiTrnty2 fiTrnty3 fiPosition fiTrnty4 fiTrnty5 fiTrnty6 
          fibdes fibdes2 finame1 finame2 
      WITH FRAME frSt IN WINDOW C-Win.
  ENABLE fiacno1 fiacno2 fiTrndatfr fiTrndatto fiAsdat fiContractName fiTotprem 
         fiExt raOper fiBranch fiPrintdate fiDoc2 fiBranch2 buBranch buBranch2 
         fiTrnty1 fiPowerName fiTrnty2 fiTrnty3 fiPosition fiTrnty4 fiTrnty5 
         fiTrnty6 buAcno buAcno2 fibdes fibdes2 finame1 finame2 RECT-104 
         RECT-106 RECT-108 RECT-83 RECT-84 RECT-88 RECT-290 RECT-291 RECT-292 
         RECT-296 RECT-297 RECT-89 RECT-109 RECT-85 RECT-293 RECT-110 
      WITH FRAME frSt IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-frSt}
  DISPLAY rsOutput cbPrtList fiFile-Name 
      WITH FRAME frOutput IN WINDOW C-Win.
  ENABLE RECT-82 RECT-289 rsOutput cbPrtList fiFile-Name 
      WITH FRAME frOutput IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-frOutput}
  ENABLE RECT-288 
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

FOR EACH AcProc_fil USE-INDEX by_type_asdat  WHERE AcProc_fil.type = "01" AND AcProc_fil.asdat >= d2 NO-LOCK BY asdat DESC  : 
  ASSIGN vAcProc_fil = vAcProc_fil + STRING( AcProc_fil.asdat,"99/99/9999")  + ",". 
END.
  
  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdBranch C-Win 
PROCEDURE pdBranch :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO WITH FRAME frST:
 ASSIGN 
         fibranch  = n_lbran
         fibranch2 = n_lbran
         n_branch  = fibranch.

    FIND  xmm023 WHERE xmm023.branch = n_branch NO-LOCK NO-ERROR.
        IF AVAILABLE xmm023 THEN DO:
              fibdes:Screen-value  = xmm023.bdes.
              fibdes2:Screen-value = xmm023.bdes.
        END.        
        ELSE DO: 
              fibdes:Screen-value = "Not Found !".
              fibdes2:Screen-value = "Not Found !".
        END. 
    
END.
    
        
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdCreate C-Win 
PROCEDURE pdCreate :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FIND FIRST smm015_fil WHERE smm015_fil.bchno = nv_letterno  /*AND smm015_fil.compy = nv_pol*/
                                              NO-ERROR.
    IF AVAIL smm015_fil THEN DO:
           MESSAGE "ข้อมูลเลขที่จดหมายนี้ซ้ำ" SKIP
                   "กรุณาตรวจสอบที่" SKIP(1) 
                   "โปรแกรม wfnr0102 - Run No. Notice for Insure"  VIEW-AS ALERT-BOX WARNING.
           RETURN NO-APPLY.
    END.
    ELSE DO:       
         CREATE smm015_fil.
         ASSIGN
             smm015_fil.bchno   = nv_letterno
             smm015_fil.compy   = acm001.acno
                                  /*STRING(YEAR(fiprintdate),"9999") + 
                                  STRING(MONTH(fiprintdate),"99") +
                                  STRING(DAY(fiprintdate),"99") */
             smm015_fil.statux  = acm001.acno
             smm015_fil.usrid   = nv_name 
             smm015_fil.vhshtot = nv_bal
           /*smm015_fil.bchtyp  = nv_user ----Comment by Amparat C. A51-0195---*/
             smm015_fil.bchtyp  = n_user
             smm015_fil.opdate  = fiprintdate
             smm015_fil.cldate  = fiAsdat
             smm015_fil.accmth  = 1
             smm015_fil.trsno   = int(nv_docno). /*A61-0385*/
    END.
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
        IF n_lbran <> "0" THEN DO:
            IF n_lbran <> "w" THEN 
                IF n_lbran <> "l" THEN 
                    IF n_lbran <> "m" THEN 
                        DISABLE fiBranch fiBranch2 buBranch buBranch2.
        END.
        ELSE DO: 
            ENABLE fiBranch fiBranch2 buBranch buBranch2. 
        END.
        
    END.

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

FIND FIRST  xmm023 NO-LOCK NO-ERROR.
    IF AVAIL xmm023  THEN  DO:
        DO WITH FRAME frST :
            ASSIGN 
                fiBranch  = xmm023.branch
                fibdes     = xmm023.bdes.
             DISP fiBranch fibdes .
         END.
    END.     

FIND Last  xmm023 NO-LOCK NO-ERROR.
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdname C-Win 
PROCEDURE pdname :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*--Comment by Ranu : A58-0172  ---*/
/*FIND FIRST xmm030 WHERE SUBSTRING(usrcod,2,1) = SUBSTRING(n_user,6,1) AND 
                        SUBSTRING(usrcod,3,2) = "FN" AND 
                        SUBSTRING(usrcod,5,2) = "01" NO-LOCK NO-ERROR.
IF AVAIL xmm030 THEN 
        ASSIGN
        fiPowerName = xmm030.second
        fiPosition  = xmm030.poltyp.
    
ELSE ASSIGN 
        fiPowerName = ""
        fiPosition  = "" .
*/
/*
FOR EACH xmm030 WHERE SUBSTRING(usrcod,2,1) = SUBSTRING(n_user,6,1) AND
                      SUBSTRING(usrcod,3,2) = "FN" AND
                      SUBSTRING(usrcod,5,2) = "01" NO-LOCK.
    ASSIGN 
        fiPowerName = xmm030.second
        fiPosition  = xmm030.poltyp.
END.                                


DISP fiPowerName fiPosition WITH FRAME frst.*/


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
ASSIGN  nv_docno = 0
        nv_year = SUBstr(STRING(YEAR(TODAY) + 543,"9999"),3,2)
        nv_mon  = STRING(MONTH(TODAY),"99")
        nv_use  = nv_year + nv_mon.

    FIND LAST docno_fil USE-INDEX docno01 WHERE docno_fil.branch = nv_use AND 
                                                docno_fil.poltyp = "CR" AND 
                                                docno_fil.seqtyp = nv_lettyp NO-LOCK NO-ERROR .
    IF AVAIL docno_fil THEN DO:
        ASSIGN fiDoc = docno_fil.branch
               nv_docno = docno_fil.startno + 1
               fiDoc2 = nv_docno.
        DISP fiDoc fiDoc2 WITH FRAME frSt.
        
    END.
    ELSE DO:
        CREATE docno_fil.
        ASSIGN docno_fil.branch = nv_use
               docno_fil.poltyp = "CR" 
               docno_fil.seqtyp = nv_lettyp
               docno_fil.startno =  1
        fiDoc2 = INTEGER(SUBSTRING(STRING(docno_fil.startno),1,4)).
        DISP fiDoc2 WITH FRAME frSt. 
        
    END.

    RELEASE docno_fil.

    nv_letterno = "R" + fiDoc + STRING(fiDoc2,"99999").
    
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdRunningNo_Old C-Win 
PROCEDURE pdRunningNo_Old :
/*------------------------------------------------------------------------------
  Purpose:     ค่าเริ่มต้นเลขที่จดหมาย
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*--------------------- Comment by RANU : A58-0172 ------------------------------
    FIND LAST docno_fil WHERE docno_fil.branch = STRING(YEAR(n_asdat), "9999") +
              STRING(MONTH(n_asdat), "99") +
              STRING(DAY(n_asdat), "99") NO-LOCK NO-ERROR.  /*หาค่ามากที่สุดของเลขที่จดหมาย*/

    IF NOT AVAIL docno_fil THEN DO:   /* ณ เดือนนั้นยังไม่เคยพิมพ์จดหมาย */
        ASSIGN
            vMaxdoc =  INTEGER(SUBSTRING(STRING(YEAR(TODAY) + 543),3,2) + STRING(MONTH(TODAY), "99") + "0001")
            fiDoc2 = 0001.
            DISP fiDoc2 WITH FRAME frSt.  
    END.
    ELSE DO:   /* เคยพิมพ์จดหมายแล้ว */

       FOR EACH docno_fil  WHERE docno_fil.branch = STRING(YEAR(n_asdat), "9999") +
                 STRING(MONTH(n_asdat), "99") +
                 STRING(DAY(n_asdat), "99") NO-LOCK
        BREAK BY branch   BY startno :     /* หา เลขที่จดหมาย เบอร์สุดท้าย ที่ asdat เดียวกัน */
            IF LAST-OF(branch) THEN DO:
                ASSIGN
                    vMaxdoc =  docno_fil.startno
                    fiDoc2 = INTEGER(SUBSTRING(STRING(vMaxdoc),5,4)) + 1.
                    DISP fiDoc2 WITH FRAME frSt.  
            END.
        END. /* for each */
        
    END. /* find last */

    RELEASE docno_fil. 
----------------------------------- end A58-0172 ------------------------------*/

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE ProcGetRptList C-Win 
PROCEDURE ProcGetRptList :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  /*DEF VAR report-list   AS CHARACTER.
 *   DEF VAR report-count  AS INTEGER.
 *   DEF VAR report-number AS INTEGER.
 * 
 *   RUN _getname (SEARCH (report-library), OUTPUT report-list,        /* aderb/_getname.p */
 *     OUTPUT report-count).
 *   
 *   IF report-count = 0 THEN RETURN NO-APPLY.
 * 
 *   DO WITH FRAME frST :
 *         ASSIGN
 *           cbRptList:List-Items = report-list
 *           report-number = LOOKUP (report-name,report-list)
 *           cbRptList     = IF report-number > 0 THEN ENTRY (report-number,report-list)
 *                                   ELSE ENTRY (1, report-list).    
 *   
 *        DISP cbRptList . 
  END. */


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE ProcPrint C-Win 
PROCEDURE ProcPrint :
/*------------------------------------------------------------------------------
  Purpose: ตรวจสอบข้อมูลว่าเคยมีการปริ้นแล้วหรือยัง    
  Parameters:  <none>
  Notes:  RANU : A58-0172 19/05/2015     
------------------------------------------------------------------------------*/
/*
DEF VAR n_letter AS CHAR FORMAT "x(8)".
ASSIGN
      nv_bran = ""
      vAcnoBe = ""
      vAcnoFi  = ""
      n_letter  = ""
      n_int = 0.

/*------------------------------ Count & Calculate -----------------------------*/    
main_loop:

    FOR EACH buffagtprm WHERE buffagtprm.asdat = n_asdat AND       /* หาจำนวน Acno ทั้งหมดในช่วง*/
            buffagtprm.polbran = n_branch AND
            (buffagtprm.acno >= n_frac AND buffagtprm.acno <= n_toac) BREAK BY buffAgtprm.acno:

        IF FIRST-OF(buffAgtprm.acno) THEN DO:
            vAcnoCount  =  buffagtprm.acno.
            
            FOR EACH Agtprm_fil USE-INDEX by_acno WHERE (Agtprm_fil.asdat = n_asdat AND       /* +1 ให้กับเลขที่จดหมายจนเท่ากับจำนวน Acno ที่ได้ */
                     Agtprm_fil.acno = vAcnoCount) AND 
                     Agtprm_fil.polbran = n_branch  BREAK BY Agtprm_fil.acno:

                     ASSIGN n_letter  = SUBSTRING(Agtprm_fil.poldes,36,1).
                     IF INDEX("0123456789",n_letter) <> 0 THEN ASSIGN n_int = 1.  /*-- เช็คค่าตัวแปร ตัวอักษร + ค่าว่าง = 0 ตัวเลข = 1 -*/
                     ELSE ASSIGN n_int = 0.
                     
             IF n_int = 1  THEN DO:
               MESSAGE "ไม่สามารถพิมพ์จดหมายได้ เนื่องจาก1" SKIP
                         "มีการพิมพ์จดหมายยืนยันยอดลูกหนี้แล้ว" SKIP
                         "Leter No : " SUBSTRING(agtprm_fil.poldes,36,4) " / " SUBSTRING(agtprm_fil.poldes,40,4)  SKIP(1)
                         "Producer Code : " vAcnoCount SKIP
                         "Branch : " n_branch SKIP
                         "As Of Date : " STRING(n_asdat,"99/99/9999")
                  VIEW-AS ALERT-BOX ERROR.
                  LEAVE main_loop.
               END.
             ELSE
                 RUN checkrunning.
             IF n_int = 0 THEN DO: /* ถ้า agtprm_fil.poldes = "" แล้วแสดงว่ายังไม่เคยพิมพ์*/
               IF (vMaxdoc > nv_doc1 AND vMaxdoc <> nv_doc1) THEN
               FIND LAST docno_fil USE-INDEX docno01 WHERE 
                         docno_fil.branch = STRING(YEAR(n_asdat), "9999") + 
                         STRING(MONTH(n_asdat), "99") + 
                         STRING(DAY(n_asdat), "99")   AND
                         docno_fil.poltyp >= n_branch   AND docno_fil.poltyp <= n_branch2 AND
                         docno_fil.startno = vMaxdoc NO-ERROR.
               IF NOT AVAIL docno_fil THEN DO:  /* หาเลขที่เอกสารใน docno_fil ไม่เจอ  assign ค่าลงไปใน agtprm_fil.poldes */
                    SUBSTRING(agtprm_fil.poldes,36,8) = STRING(vMaxdoc, "99999999").
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
                 /*IF vMaxdoc < nv_doc1 AND vMaxdoc = nv_doc1 THEN*/

                 MESSAGE n_asdat n_branch vmaxdoc VIEW-AS ALERT-BOX.

                 MESSAGE "ไม่สามารถพิมพ์จดหมายได้ เนื่องจาก เลขที่จดหมายซ้ำ" SKIP
                                   "Leter No : " SUBSTRING(STRING(docno_fil.startno),1,4) " / " SUBSTRING(STRING(docno_fil.startno),5,4)  SKIP(1)
                                   "Producer Code : " vAcnoCount SKIP
                                   "Branch : " docno_fil.poltyp SKIP
                                   "As Of Date : " STRING(docno_fil.branch,"99/99/9999")
                           VIEW-AS ALERT-BOX ERROR.
                 RETURN NO-APPLY.
               END.   
             END. /*else*/
                
               IF LAST-OF(agtprm_fil.acno) THEN DO:                   /*create เลข running ลง docno_fil*/
                  FIND LAST docno_fil USE-INDEX docno01 WHERE 
                            docno_fil.branch = STRING(YEAR(agtprm_fil.asdat), "9999") +
                            STRING(MONTH(agtprm_fil.asdat), "99") +
                            STRING(DAY(agtprm_fil.asdat), "99")  AND
                            docno_fil.poltyp = agtprm_fil.polbran   AND
                            docno_fil.seqtyp = agtprm_fil.acno   AND
                            docno_fil.startno = vMaxdoc NO-ERROR.
                  IF NOT AVAIL docno_fil THEN DO:
                      CREATE docno_fil.
                      ASSIGN
                          docno_fil.branch = STRING(YEAR(agtprm_fil.asdat), "9999") + 
                                             STRING(MONTH(agtprm_fil.asdat), "99") + 
                                             STRING(DAY(agtprm_fil.asdat), "99")
                          docno_fil.des     = n_User
                          docno_fil.poltyp  = agtprm_fil.polbran
                          docno_fil.seqtyp  = agtprm_fil.acno
                          docno_fil.startno = vMaxdoc.
                  END.
                  ELSE DO:
                    MESSAGE "ไม่สามารถพิมพ์จดหมายได้ เนื่องจาก" SKIP
                            "มีการพิมพ์จดหมายเตือนเบี้ยประกันภัยค้างชำระแล้ว" SKIP
                            "Leter No : " SUBSTRING(STRING(docno_fil.startno),1,4) " / " SUBSTRING(STRING(docno_fil.startno),5,4)  SKIP(1)
                            "Producer Code : " vAcnoCount SKIP
                            "Branch : " docno_fil.poltyp SKIP
                            "As Of Date : " STRING(docno_fil.branch,"99/99/9999")
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
*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE procPrint1 C-Win 
PROCEDURE procPrint1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN nv_bal = 0
       nv_printdate = TODAY
       nv_lettyp = "LAR".

loop_xmm600:
FOR EACH xmm600 USE-INDEX xmm60001  NO-LOCK
         WHERE  xmm600.acno    >= n_frac
         AND    xmm600.acno    <= n_toac
         AND    xmm600.homebr  >= n_branch  
         AND    xmm600.homebr  <= n_branch2  :

        ASSIGN nv_name  = xmm600.ntitle + xmm600.NAME
               nv_acno  = xmm600.acno
               nv_addr1 = xmm600.addr1
               nv_addr2 = xmm600.addr2
               nv_addr3 = xmm600.addr3
               nv_addr4 = xmm600.addr4
               .

        loop_acm001:
        FOR EACH acm001 USE-INDEX acm00103 NO-LOCK
            WHERE acm001.acno    = xmm600.acno
            AND   acm001.curcod  = "BHT"
            AND  (acm001.trndat >= n_trndatfr AND acm001.trndat <= n_trndatto)
            AND  (acm001.trnty1 = n_trnty1[1]  OR
                  acm001.trnty1 = n_trnty1[2]  OR
                  acm001.trnty1 = n_trnty1[3]  OR
                  acm001.trnty1 = n_trnty1[4]  OR
                  acm001.trnty1 = n_trnty1[5]  OR
                  acm001.trnty1 = n_trnty1[6])
            AND  (acm001.bal <> 0 OR (acm001.bal = 0 AND acm001.latdat > n_asdat) )
            BREAK BY acm001.acno
                  BY SUBSTRING (acm001.policy,3,2)
                  BY acm001.trnty1
                  BY acm001.trndat :

            IF acm001.bal <> 0 THEN DO:
               /*---------------------
               /* กรณีเหลือเบี้ยเต็มจำนวน */
               IF acm001.bal = (acm001.prem + acm001.tax + acm001.stamp) - acm001.comm  THEN DO:
                  n_bal = n_bal + acm001.bal.
               END.
               ELSE DO:
                  /* กรณีเหลือแต่ค่าคอม */
                  IF acm001.bal = acm001.comm THEN DO:
                      n_bal = 0.
                  END.
                  ELSE DO:
                  /* กรณีเหลือเบี้ยบางส่วน */
                      n_bal = n_bal + acm001.bal.
                  END.

               END.
               ---------------------*/

                nv_bal = nv_bal + acm001.bal.
            END.

            /*create เลข running ลง docno_fil*/
            IF LAST-OF (acm001.acno) THEN DO:  
               
               /*FIND LAST docno_fil USE-INDEX docno01 WHERE 
                      docno_fil.branch = "CR" + 
                                         STRING(YEAR(fiasdat), "9999") +
                                         STRING(MONTH(fiasdat), "99") AND
                      docno_fil.poltyp = STRING(YEAR(fiasdat), "9999") +
                                         STRING(MONTH(fiasdat), "99") +
                                         STRING(DAY(fiasdat), "99")   AND
                      docno_fil.seqtyp = acm001.acno   AND
                      docno_fil.startno = vMaxdoc NO-ERROR.
               IF NOT AVAIL docno_fil THEN DO:
                   CREATE docno_fil.
                   ASSIGN
                       docno_fil.branch = "CR" +
                                          STRING(YEAR(fiasdat), "9999") + 
                                          STRING(MONTH(fiasdat), "99") 
                       docno_fil.des     = n_User
                       docno_fil.poltyp  = STRING(YEAR(fiasdat), "9999") +
                                         STRING(MONTH(fiasdat), "99") +
                                         STRING(DAY(fiasdat), "99")
                       docno_fil.seqtyp  = acm001.acno
                       docno_fil.startno = vMaxdoc.
               END.
               */

              fiTotPrem =  nv_bal. 
              DISP fiTotPrem WITH FRAME frST.

              RUN pdRunningNO.   /* หา running no เบอร์ ล่าสุด ใน table docno_fil */ 

              RUN pdCreate.   /* Create smm015_fil */ 

              FIND LAST docno_fil USE-INDEX docno01 WHERE docno_fil.branch = nv_use AND 
                                                          docno_fil.poltyp = "CR" AND
                                                          docno_fil.seqtyp = nv_lettyp NO-ERROR .
              IF AVAIL docno_fil THEN DO:
                 docno_fil.startno = nv_docno.
              END.
              ELSE DO:
                 MESSAGE "Please Check Parameter Running Letter No. on Docno_fil" VIEW-AS ALERT-BOX.
                 APPLY "Entry" TO fiacno1 IN FRAME frST.
                 RETURN NO-APPLY.
              END.

              RELEASE docno_fil.

            END.
        
        END.   /* end each acm001 */

END.   /* end each xmm600 */


/*------------------------------- Finish Count & Calculate ------------------------*/      
IF fiTotprem <> 0 THEN RUN ProcReport1.
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE ProcPrint_Old C-Win 
PROCEDURE ProcPrint_Old :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

/*-------------- Comment By RANU : A58-0172 ---------------------------------------
  ASSIGN
      vAcnoBe = ""
      vAcnoFi  = "".

/*------------------------------ Count & Calculate -----------------------------*/       
main_loop:

    FOR EACH buffagtprm WHERE buffagtprm.asdat = n_asdat AND       /* หาจำนวน Acno ทั้งหมดในช่วง*/
             buffagtprm.polbran = n_branch AND 
            (buffagtprm.acno >= n_frac AND buffagtprm.acno <= n_toac) BREAK BY buffAgtprm.acno:

        IF FIRST-OF(buffAgtprm.acno) THEN DO:

            vAcnoCount  =  buffagtprm.acno.

            FOR EACH Agtprm_fil WHERE Agtprm_fil.asdat = n_asdat AND       /* +1 ให้กับเลขที่จดหมายจนเท่ากับจำนวน Acno ที่ได้ */
                     Agtprm_fil.polbran = n_branch  AND 
                     Agtprm_fil.acno = vAcnoCount  BREAK BY Agtprm_fil.acno:
               IF SUBSTRING(Agtprm_fil.poldes,36,8) <> " " THEN DO:
                   MESSAGE "ไม่สามารถพิมพ์จดหมายได้ เนื่องจาก1" SKIP
                           "มีการพิมพ์จดหมายเตือนเบี้ยประกันภัยค้างชำระแล้ว" SKIP
                           "Leter No : " SUBSTRING(agtprm_fil.poldes,36,4) " / " SUBSTRING(agtprm_fil.poldes,40,4)  SKIP(1)
                           "Producer Code : " vAcnoCount SKIP
                           "Branch : " n_branch SKIP
                           "As Of Date : " STRING(n_ashprandat,"99/99/9999")
                   VIEW-AS ALERT-BOX ERROR.
                   LEAVE main_loop. 
               END.
               ELSE
               IF SUBSTRING(Agtprm_fil.poldes,36,8) = " " THEN DO:  /* ถ้า agtprm_fil.poldes = "" แล้วแสดงว่ายังไม่เคยพิมพ์*/
                  FIND LAST docno_fil USE-INDEX docno01 WHERE 
                            docno_fil.branch = STRING(YEAR(n_asdat), "9999") + 
                            STRING(MONTH(n_asdat), "99") + 
                            STRING(DAY(n_asdat), "99")   AND  
                            docno_fil.poltyp = n_branch   AND
/*                          docno_fil.seqtyp = vAcnoCount   AND*/
                            docno_fil.startno = vMaxdoc NO-ERROR.
                  IF NOT AVAIL docno_fil THEN DO:  /* หาเลขที่เอกสารใน docno_fil ไม่เจอ  assign ค่าลงไปใน agtprm_fil.poldes */
                       SUBSTRING(agtprm_fil.poldes,36,8) = STRING(vMaxdoc, "99999999").
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
                    MESSAGE "ไม่สามารถพิมพ์จดหมายได้ เนื่องจาก เลขที่จดหมายซ้ำ" SKIP
                                      "Leter No : " SUBSTRING(STRING(docno_fil.startno),1,4) " / " SUBSTRING(STRING(docno_fil.startno),5,4)  SKIP(1)
                                      "Producer Code : " vAcnoCount SKIP
                                      "Branch : " docno_fil.poltyp SKIP
                                      "As Of Date : " STRING(docno_fil.branch,"99/99/9999")
                              VIEW-AS ALERT-BOX ERROR.
                    RETURN NO-APPLY.
                  END.   
               END. /*else*/

               IF LAST-OF(agtprm_fil.acno) THEN DO:                   /*create เลข running ลง docno_fil*/
                  FIND LAST docno_fil USE-INDEX docno01 WHERE 
                            docno_fil.branch = STRING(YEAR(agtprm_fil.asdat), "9999") +
                            STRING(MONTH(agtprm_fil.asdat), "99") +
                            STRING(DAY(agtprm_fil.asdat), "99")  AND
                            docno_fil.poltyp = agtprm_fil.polbran   AND
                            docno_fil.seqtyp = agtprm_fil.acno   AND
                            docno_fil.startno = vMaxdoc NO-ERROR.
                  IF NOT AVAIL docno_fil THEN DO:
                      CREATE docno_fil.
                      ASSIGN
                          docno_fil.branch = STRING(YEAR(agtprm_fil.asdat), "9999") + 
                                             STRING(MONTH(agtprm_fil.asdat), "99") + 
                                             STRING(DAY(agtprm_fil.asdat), "99")
                          docno_fil.poltyp  = agtprm_fil.polbran
                          docno_fil.seqtyp  = agtprm_fil.acno
                          docno_fil.startno = vMaxdoc.
                      MESSAGE docno_fil.branch  docno_fil.poltyp docno_fil.seqtyp docno_fil.startno VIEW-AS alert-BOX.
                  END.
                  ELSE DO:
                    MESSAGE "ไม่สามารถพิมพ์จดหมายได้ เนื่องจาก" SKIP
                            "มีการพิมพ์จดหมายเตือนเบี้ยประกันภัยค้างชำระแล้ว" SKIP
                            "Leter No : " SUBSTRING(STRING(docno_fil.startno),1,4) " / " SUBSTRING(STRING(docno_fil.startno),5,4)  SKIP(1)
                            "Producer Code : " vAcnoCount SKIP
                            "Branch : " docno_fil.poltyp SKIP
                            "As Of Date : " STRING(docno_fil.branch,"99/99/9999")
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
------------------------- end : A58-0172 ---------------------------------------*/ 

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

/* kan connect sicfn ---*/
      FIND FIRST dbtable WHERE dbtable.phyname = "form"  OR dbtable.phyname = "stat"
                                            NO-LOCK NO-ERROR NO-WAIT.
      IF AVAIL dbtable THEN DO:
          IF dbtable.phyname = "form" THEN DO:
                 ASSIGN
                     nv_User  = "?"
                     nv_pwd = "?".
                     RB-DB-CONNECTION  = dbtable.unixpara +  " -U " + nv_user + " -P " + nv_pwd.
          END.
          ELSE DO:
                     RB-DB-CONNECTION = dbtable.unixpara +  " -U " + n_User + " -P " + n_Passwd. 
          END.
      END.

      IF n_asdat = ?   THEN DO:
            MESSAGE "ไม่พบข้อมูล  กรุณาตรวจสอบการ Process ข้อมูล" VIEW-AS ALERT-BOX ERROR.
      END.
      ELSE DO:
         IF LENGTH(n_branch) <> 2 THEN 
             ASSIGN branch = "0" + n_branch.
         ELSE 
               ASSIGN branch = n_branch.
         
         RUN ProcReport2. 
      END.

/*---end A58-0172 --*/
/* --- Comment : A58-0172 ---
    IF n_asdat = ?   THEN DO:
            MESSAGE "ไม่พบข้อมูล  กรุณาตรวจสอบการ Process ข้อมูล" VIEW-AS ALERT-BOX ERROR.
    END.
    ELSE DO:
        MESSAGE "Branch                 : "  n_Branch " ถึง " n_Branch2 SKIP (1)
                            "Producer Code  : "  vAcnoBe " ถึง " vAcnoFi SKIP (1)
                            "As Of Date          : " STRING(n_asdat,"99/99/9999") SKIP (1)
                            VIEW-AS ALERT-BOX QUESTION
        BUTTONS YES-NO
        TITLE "Confirm"    UPDATE CHOICE AS LOGICAL.
        CASE CHOICE:
        WHEN TRUE THEN    DO:
            RUN ProcReport2.   
        END.
        WHEN FALSE THEN    DO:
            RETURN NO-APPLY. 
        END.
        END CASE.  

    END.   /* else IF asdat = ? */ 
------- end comment ------*/
    
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
DEF VAR n_chk AS INT.    
DO: 
        ASSIGN
                n_chk = 0    
                report-library =  "Wac/wprl/Wacr042.prl"
                report-name  =  "Receivable Confirmation Letter_T".
           /*---- A58-0172 : RANU ---
           ASSIGN 
                nv_pic = nv_a4a_38.
                nv_pic = SEARCH(nv_pic).
                IF nv_pic = ? OR nv_pic = "" THEN DO:
                    MESSAGE "not found picture" VIEW-AS ALERT-BOX.
                END.
            ---- end : A58-0172 ---*/

          ASSIGN
              RB-INCLUDE-RECORDS  = "O"                                                                                                                                                                                                                    
              RB-PRINT-DESTINATION = SUBSTR ("D A", rsOutput, 1)
              RB-PRINTER-NAME   = IF rsOutput = 2 THEN cbPrtList ELSE " "
              RB-OUTPUT-FILE       = IF rsOutput = 3 THEN fiFile-Name ELSE " "
              RB-NO-WAIT               = No
              RB-OTHER-PARAMETERS =  "rb_vCliCod     
                                  = " + STRING(vCliCod) + CHR(10) +
/*                                "rb_n_doc  = " + STRING(vDoc, "9999") + CHR(10) +
 *                                 "rb_n_doc2  = " + STRING(vDoc2, "9999") + CHR(10) +*/
                                  "rb_letterno = " + nv_letterno +  CHR(10) +
                                  "rb_printdate  = " + STRING(nv_printdate) + CHR(10) +  
                                  "rb_printdate1 = " + STRING(DAY(nv_printdate)) + CHR(10) +
                                  "rb_printdate2 = " + STRING(MONTH(nv_printdate)) + CHR(10) +
                                  "rb_printdate3 = " + STRING(YEAR(nv_printdate),"9999") + CHR(10) +
                                  "rb_asdate  = " + STRING(nv_asdate) + CHR(10) +  
                                  "rb_asdate1 = " + STRING(DAY(nv_asdate)) + CHR(10) +
                                  "rb_asdate2 = " + STRING(MONTH(nv_asdate)) + CHR(10) +
                                  "rb_asdate3 = " + STRING(YEAR(nv_asdate),"9999") + CHR(10) +
                                  "rb_name       = " + STRING(nv_name)    + CHR(10) +  
                                  "rb_addr1      = " + STRING(nv_addr1)   + CHR(10) +  
                                  "rb_addr2      = " + STRING(nv_addr2)   + CHR(10) +  
                                  "rb_addr3      = " + STRING(nv_addr3)   + CHR(10) +  
                                  "rb_addr4      = " + STRING(nv_addr4)   + CHR(10) +
                                  "rb_bal        = " + STRING(nv_bal,">>>>>>>>>>>9.99")   + CHR(10) + 
                                   
                                  "rb_n_ContractName  = " + STRING(vContractName) + CHR(10) +
                                  "rb_n_Ext  = " + STRING(vExt) + CHR(10) +
                                  "rb_n_PowerName = " + STRING(vPowerName) + CHR(10) +
                                  "rb_n_Position = " + STRING(vPosition) + CHR(10) +
                                  "rb_n_Date = " + STRING(vDate) + CHR(10) +
                                  "rb_n_branch = " + STRING(branch) + CHR(10) +   /*--- A58-0172 : RANU --*/
                                  "rb_n_trndatto  = " + STRING(n_trndatto,"99/99/9999") + CHR(10) +
                                  "rb_n_pic = " + STRING(nv_pic) + CHR(10) +      /*--- A58-0172 : RANU --*/
                                  "rb_pich  = " + nv_a4a_07 
                                    .
                                
            /*MESSAGE RB-OTHER-PARAMETERS VIEW-AS ALERT-BOX. */    
            /*MESSAGE rb-filter VIEW-AS ALERT-BOX.*/
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
 /*----- ranu: A58-0172 --------*/
       n_chk = 1.
       RELEASE Agtprm_fil.
END.
 IF n_chk = 1 THEN
     MESSAGE " Print Complete " VIEW-AS ALERT-BOX.
 ELSE 
     MESSAGE " Print Not Complete ! " VIEW-AS ALERT-BOX.
/*----- end: A58-0172 --------*/
  
END PROCEDURE.


/*              RB-FILTER            =    'agtprm_fil.asdat = ' + 
 *                                                     STRING (MONTH (n_asdat)) + "/" + 
 *                                                     STRING (DAY (n_asdat)) + "/" + 
 *                                                     STRING (YEAR (n_asdat)) +
 *                                                     " AND " +                                             
 *                                                     "agtprm_fil.polbran >= '" + n_branch   + "'" + " AND " + 
 *                                                     "agtprm_fil.polbran <= '" + n_branch2 + "'" +
 *                                                     " AND " + 
 *                                                     "agtprm_fil.acno >= '" + vAcnoBe + "'" + " AND " + 
 *                                                     "agtprm_fil.acno <= '" + vAcnoFi + "'" +
 *                                                     " AND " +                                                                                                
 *                                                     "( SUBSTRING(agtprm_fil.trntyp,1,1) = 'M' " + " OR " + 
 *                                                     "SUBSTRING(agtprm_fil.trntyp,1,1) = 'A' " + " OR " + 
 *                                                     "SUBSTRING(agtprm_fil.trntyp,1,1) = 'R' " + " OR " + 
 *                                                     "SUBSTRING(agtprm_fil.trntyp,1,1) = 'B' " + " OR " +                                                    
 *                                                     "SUBSTRING(agtprm_fil.trntyp,1,1) = 'C' " + " OR " +                                                     
 *                                                     "SUBSTRING(agtprm_fil.trntyp,1,1) = '" + n_typ + "'" + " OR " + 
 *                                                     "SUBSTRING(agtprm_fil.trntyp,1,1) = '" + n_typ1 + "' )"*/

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
      vAcnoFi   =  fiacno2.
 
    FIND LAST docno_fil WHERE  docno_fil.branch = STRING(YEAR(n_asdat), "9999") + STRING(MONTH(n_asdat), "99") +
              STRING(DAY(n_asdat), "99")  AND
              docno_fil.poltyp  = n_branch  AND 
              docno_fil.seqtyp = n_frac     NO-ERROR.
        IF docno_fil.startno = INTEGER(fiDoc + STRING(fiDoc2, "9999")) THEN DO:  
                                                                    /* ถ้าเจอเลขที่จดหมายนี้ใน docno_fil แล้ว เก็บค่าใส่ */
            docno_fil.startno = vMaxdoc.
        END.
        ELSE DO:                                           /* ถ้าไม่เจอเลขที่จดหมายนี้ใน docno_fil */
            IF docno_fil.startno <> INTEGER(fiDoc + STRING(fiDoc2, "9999")) AND      /* พิมพ์ซ้ำแต่ใส่เลขที่ผิด*/
                docno_fil.startno <> 0 THEN DO:
               MESSAGE "พิมพ์ซ้ำเลขที่จดหมายจะต้องเท่ากับเลขที่จดหมายเดิม" SKIP
                       "Leter No : " SUBSTRING(STRING(docno_fil.startno),1,4) " / "
                                     SUBSTRING(STRING(docno_fil.startno),5,4) SKIP(1)
                       "Producer Code : " vAcnoBe SKIP 
                       "Branch : " n_branch SKIP
                       "As Of Date : " STRING(n_asdat,"99/99/9999") SKIP
               VIEW-AS ALERT-BOX ERROR.
               APPLY "ENTRY" TO fiDoc2 IN FRAME frST.
               RETURN NO-APPLY.
            END.
            ELSE
            IF docno_fil.startno <> INTEGER(fiDoc + STRING(fiDoc2, "9999")) AND       /* พิมพ์ซ้ำแต่ ยังไม่เคยพิมพ์เลย*/
                docno_fil.startno = 0  THEN DO:
               MESSAGE "ไม่สามารถพิมพ์ซ้ำได้ เนื่องจากเป็นการพิมพ์ครั้งแรก" SKIP(1)
                       "Producer Code : " vAcnoBe SKIP
                       "Branch : " n_branch SKIP
                       "As Of Date : " STRING(n_asdat,"99/99/9999") SKIP
               VIEW-AS ALERT-BOX ERROR.
               RETURN NO-APPLY.                     
            END.
                         
        END. /*else*/

    RUN pdDisable.  
    RUN ProcReport1.
      
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

