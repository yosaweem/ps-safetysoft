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
/* CREATE BY :  Supasit S.        A45-0008  */
Wac
        -Wacr04.w
WPrl
        -Wac_sm03.prl
Whp
        -WhpBran.w
        -WhpAcno2.w

/* MODIFY BY : Kanchana C.      A46-0148              12/05/2003
    - โปรแกรมจะดึง จาก Statement A4 (Monthly)   Type = "01"  เท่านั้น

   1.  แก้การ find last เลขที่ running no ให้ดึง asdate เดียวกันเลขที่  running ล่าสุด มาให้
   2.  เปิดช่องให้คีย์เลขที่จดหมายได้  เมื่อมีการพิมพ์ซ้ำเท่านั้น
   
    เก็บข้อมูลทุก record ที่มีการออกเอกสารไปแล้วลงใน
    1. field Table agtprm_fil
        "Leter No : " SUBSTRING(agtprm_fil.poldes,36,4) " / " SUBSTRING(agtprm_fil.poldes,40,4)
    2. TABLE docno_fil 

    Field       
    docno_fil.branch      =   asdate  "YYYYMMDD"
    docno_fil.poltyp       =   branch   "X"
    docno_fil.seqtyp      =   acno      "X(7)"
    docno_fil.startno      =   docno    "46050007"  
*/

/* MODIFY BY : Kanchana C.      A46-0237              03/07/2003
1. ไม่ให้มี Br. 0 แสดงในช่อง Branch from
2. นอกจากชื่อตัวแทน/นายหน้าแล้ว  ขอเพิ่มที่อยู่ของตัวแทน/นายหน้าในบรรทัดถัดจากชื่อ
*/

/* Create by : Lukkana M.  A49-0065    (Date : 28/02/2006)     */

/* Modify By Wantanee.S A49-0139  Date 11/08/2006 Lock Database Sicfn 
   - Lock ไม่ให้ User Blank เข้าใช้ database */
   
/*------------------------------------------------------------------
 Modify By : TANTAWAN C.   26/01/2008   [A500178]
             ปรับ FORMAT branch เพื่อรองรับการขยายสาขา
ขยาย FORMAT ของ acno จากเดิม "X(7)" เป็น "X(10)"             
--------------------------------------------------------------------*/  
Modify By : Ranu I.  04/06/2015 [A58-0172]
           - แก้ไขให้จดหมายมีลายเซ็นต์อัติโนมัติ 
           - แก้ไขเลขประจำตัวผู้เสียภาษีเป็น 0107536000854
           - เปลี่ยนเงิอนไขการ running เลขที่จดหมาย ให้เข็คจาก ปี เดือน
           ปัจจุบัน
/*-----------------------------------------------------------------------*/
/*----------------------------------------------------------------------
     Modify By: Saharat S.  A62-0279  03/12/2019
      -เปลี่ยนหัว เป็น TMSTH
     /*Modify BY   : Saharat S. A63-0377 16/09/2020
        แก้ไข : แก้ไข ขยาย Format ชื่อ ที่อยู่    */  
----------------------------------------------------------------------*/
*****************************************/    
/* ***************************  Definitions  ************************** */
DEF SHARED VAR n_User    AS CHAR.
DEF SHARED VAR n_Passwd  AS CHAR.
DEF        VAR nv_User   AS CHAR NO-UNDO. 
DEF        VAR nv_pwd    LIKE _password NO-UNDO. 

/* Definitons  Report -------                                               */

DEF  VAR report-library AS CHAR INIT "Wac/wprl/Wac_sm03.prl". 
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

Def Var n_name     As Char Format "x(150)". /*acno name*/  /*ADD Saharat S. A63-0377 */
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
DEF VAR n_trndatto  AS DATE FORMAT "99/99/9999".

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
DEF TEMP-TABLE wdocno_fil 
        FIELD asdat     AS CHAR 
        FIELD bran      AS CHAR
        FIELD acno      AS CHAR 
        FIELD letterno  AS CHAR
    INDEX wdocno_fil01  letterno DESC 
                        asdat    DESC.

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
     SIZE 126 BY 23.52.

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

DEFINE VARIABLE cbAsDat AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEMS "dd/mm/yyyy" 
     DROP-DOWN-LIST
     SIZE 16 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fiacno1 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 12 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiacno2 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 12 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

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

DEFINE VARIABLE fiDate AS CHARACTER FORMAT "99":U INITIAL "00" 
     VIEW-AS FILL-IN 
     SIZE 3.5 BY 1
     BGCOLOR 174 FONT 6 NO-UNDO.

DEFINE VARIABLE fidoc AS CHARACTER FORMAT "X(4)":U INITIAL "0" 
     VIEW-AS FILL-IN 
     SIZE 7.5 BY 1
     BGCOLOR 34 FONT 6 NO-UNDO.

DEFINE VARIABLE fiDoc2 AS INTEGER FORMAT "9999":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 7.5 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiExt AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 15 FONT 1 NO-UNDO.

DEFINE VARIABLE fiMonth AS CHARACTER FORMAT "X(20)":U 
      VIEW-AS TEXT 
     SIZE 3.5 BY 1
     BGCOLOR 34 FONT 6 NO-UNDO.

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
     SIZE 30 BY 1
     BGCOLOR 34 FONT 6 NO-UNDO.

DEFINE VARIABLE fiPowerName AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 30 BY 1
     BGCOLOR 34 FONT 6 NO-UNDO.

DEFINE VARIABLE fiYear AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 5 BY 1
     BGCOLOR 34 FONT 6 NO-UNDO.

DEFINE VARIABLE raY AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "No", 1,
"Yes", 2
     SIZE 14.5 BY 1
     BGCOLOR 32 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE raZ AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "No", 1,
"Yes", 2
     SIZE 14.5 BY 1
     BGCOLOR 32 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-104
     EDGE-PIXELS 3 GRAPHIC-EDGE    
     SIZE 62.5 BY 1.57
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-106
     EDGE-PIXELS 3 GRAPHIC-EDGE    
     SIZE 115.5 BY 13.57
     BGCOLOR 33 .

DEFINE RECTANGLE RECT-108
     EDGE-PIXELS 3 GRAPHIC-EDGE    
     SIZE 48 BY 3.1
     BGCOLOR 32 .

DEFINE RECTANGLE RECT-110
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 16.5 BY 1.67
     BGCOLOR 32 .

DEFINE RECTANGLE RECT-287
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 45.5 BY 3.05
     BGCOLOR 32 .

DEFINE RECTANGLE RECT-290
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 62.5 BY 1.19.

DEFINE RECTANGLE RECT-291
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 62.5 BY 1.19.

DEFINE RECTANGLE RECT-292
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 62.5 BY 1.19.

DEFINE RECTANGLE RECT-293
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 17 BY .95.

DEFINE RECTANGLE RECT-294
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 14 BY 1.19.

DEFINE RECTANGLE RECT-295
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 13.5 BY 1.19.

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

DEFINE RECTANGLE RECT-86
     EDGE-PIXELS 3 GRAPHIC-EDGE    
     SIZE 62.5 BY 1.62
     BGCOLOR 32 .

DEFINE RECTANGLE RECT-88
     EDGE-PIXELS 3 GRAPHIC-EDGE    
     SIZE 48 BY 6.91
     BGCOLOR 32 .

DEFINE VARIABLE toReprint AS LOGICAL INITIAL no 
     LABEL "พิมพ์ซ้ำ" 
     VIEW-AS TOGGLE-BOX
     SIZE 11.33 BY 1
     BGCOLOR 32 FGCOLOR 2 FONT 6 NO-UNDO.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     IMAGE-24 AT ROW 1.52 COL 4
     RECT-87 AT ROW 11.19 COL 104
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 25.09
         BGCOLOR 63 FGCOLOR 0 .

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
         AT COL 8 ROW 18.1
         SIZE 49 BY 6.48
         BGCOLOR 3 .

DEFINE FRAME frbtn
     Btn_OK AT ROW 2.05 COL 5
     Btn_Cancel AT ROW 4.67 COL 5
     RECT-103 AT ROW 1.29 COL 2.5
     RECT-95 AT ROW 1.76 COL 4
     RECT-97 AT ROW 4.38 COL 4
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 103 ROW 18.1
         SIZE 23.5 BY 6.48
         BGCOLOR 3 .

DEFINE FRAME frSt
     fiBranch AT ROW 6.33 COL 11 COLON-ALIGNED NO-LABEL
     fiBranch2 AT ROW 7.52 COL 11 COLON-ALIGNED NO-LABEL
     fiacno1 AT ROW 10.81 COL 11 COLON-ALIGNED NO-LABEL
     fiacno2 AT ROW 12 COL 11 COLON-ALIGNED NO-LABEL
     fiDoc2 AT ROW 4.38 COL 85.17 COLON-ALIGNED NO-LABEL
     fidoc AT ROW 4.38 COL 75.17 COLON-ALIGNED NO-LABEL
     fiDate AT ROW 5.95 COL 83.17 COLON-ALIGNED NO-LABEL
     fiPowerName AT ROW 7.76 COL 79.17 COLON-ALIGNED NO-LABEL
     fiPosition AT ROW 9.1 COL 79.17 COLON-ALIGNED NO-LABEL
     fiContractName AT ROW 12.76 COL 83.5 COLON-ALIGNED NO-LABEL
     fiExt AT ROW 14 COL 87.17 COLON-ALIGNED NO-LABEL
     cbAsDat AT ROW 3.1 COL 25.5 COLON-ALIGNED NO-LABEL
     buBranch AT ROW 6.33 COL 19.5
     buBranch2 AT ROW 7.52 COL 19.5
     buAcno AT ROW 10.81 COL 25
     buAcno2 AT ROW 12 COL 25
     raY AT ROW 14.05 COL 19 NO-LABEL
     raZ AT ROW 14.05 COL 51 NO-LABEL
     toReprint AT ROW 4.38 COL 100.67
     fiMonth AT ROW 5.95 COL 89.5 COLON-ALIGNED NO-LABEL
     fiYear AT ROW 5.95 COL 95.33 COLON-ALIGNED NO-LABEL
     fibdes AT ROW 6.33 COL 22 COLON-ALIGNED NO-LABEL
     fibdes2 AT ROW 7.52 COL 22 COLON-ALIGNED NO-LABEL
     finame1 AT ROW 10.76 COL 26.83 COLON-ALIGNED NO-LABEL
     finame2 AT ROW 11.95 COL 26.83 COLON-ALIGNED NO-LABEL
     "To" VIEW-AS TEXT
          SIZE 4.5 BY 1.05 AT ROW 12 COL 6.5
          BGCOLOR 32 FGCOLOR 2 FONT 6
     "From" VIEW-AS TEXT
          SIZE 5.5 BY 1.05 AT ROW 10.81 COL 6.5
          BGCOLOR 32 FGCOLOR 2 FONT 6
     " Producer Code":20 VIEW-AS TEXT
          SIZE 61.67 BY 1 AT ROW 9.33 COL 4.5
          BGCOLOR 18 FGCOLOR 4 FONT 2
     " Extension Number :":30 VIEW-AS TEXT
          SIZE 19.67 BY 1.05 AT ROW 14 COL 68.67
          BGCOLOR 32 FGCOLOR 2 FONT 6
     " Letter Detail":20 VIEW-AS TEXT
          SIZE 47 BY 1 AT ROW 2.76 COL 68.5
          BGCOLOR 18 FGCOLOR 4 FONT 2
     "/" VIEW-AS TEXT
          SIZE 1.5 BY 1 AT ROW 5.95 COL 89.67
          BGCOLOR 32 FONT 6
     " Print Type Z" VIEW-AS TEXT
          SIZE 13 BY 1 AT ROW 14.05 COL 37
          BGCOLOR 18 FGCOLOR 4 FONT 6
     " Branch" VIEW-AS TEXT
          SIZE 61.67 BY 1.05 AT ROW 4.95 COL 4.5
          BGCOLOR 18 FGCOLOR 4 FONT 2
     "ที่ กง.":10 VIEW-AS TEXT
          SIZE 5 BY 1.05 AT ROW 4.38 COL 70.5
          BGCOLOR 32 FGCOLOR 2 FONT 6
     " Contract" VIEW-AS TEXT
          SIZE 47.17 BY 1 AT ROW 11.29 COL 68.33
          BGCOLOR 18 FGCOLOR 4 FONT 2
     "From" VIEW-AS TEXT
          SIZE 5.5 BY 1.05 AT ROW 6.33 COL 6.5
          BGCOLOR 32 FGCOLOR 2 FONT 6
     "/" VIEW-AS TEXT
          SIZE 1.5 BY 1.05 AT ROW 4.38 COL 85.17
          BGCOLOR 32 FGCOLOR 0 FONT 2
     "ชื่อผู้มีอำนาจ":20 VIEW-AS TEXT
          SIZE 11.5 BY 1 AT ROW 7.76 COL 69.5
          BGCOLOR 32 FGCOLOR 2 FONT 6
     " Print Type Y" VIEW-AS TEXT
          SIZE 13 BY 1 AT ROW 14.05 COL 5.17
          BGCOLOR 18 FGCOLOR 4 FONT 6
     " As Of Date":20 VIEW-AS TEXT
          SIZE 17 BY 1 AT ROW 3.1 COL 5
          BGCOLOR 18 FGCOLOR 4 FONT 2
     "Notice by Agent for HO (Process ST Monthly)" VIEW-AS TEXT
          SIZE 118.17 BY 1.05 AT ROW 1 COL 1
          BGCOLOR 1 FGCOLOR 7 FONT 2
     "/" VIEW-AS TEXT
          SIZE 1.5 BY 1 AT ROW 5.95 COL 95.5
          BGCOLOR 32 FONT 6
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 7.83 ROW 2.14
         SIZE 118.5 BY 15.38
         BGCOLOR 3 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME frSt
     "ตำแหน่ง" VIEW-AS TEXT
          SIZE 7.5 BY 1 AT ROW 9.1 COL 69.83
          BGCOLOR 32 FGCOLOR 2 FONT 6
     " Contract Name :":30 VIEW-AS TEXT
          SIZE 16.83 BY 1.05 AT ROW 12.76 COL 68.67
          BGCOLOR 32 FGCOLOR 2 FONT 6
     "ชำระภายในวันที่" VIEW-AS TEXT
          SIZE 14 BY 1.05 AT ROW 5.95 COL 70.33
          BGCOLOR 32 FGCOLOR 2 FONT 6
     "To" VIEW-AS TEXT
          SIZE 3.5 BY 1.05 AT ROW 7.52 COL 6.5
          BGCOLOR 32 FGCOLOR 2 FONT 6
     RECT-104 AT ROW 13.76 COL 4
     RECT-106 AT ROW 2.24 COL 2
     RECT-108 AT ROW 12.33 COL 67.83
     RECT-110 AT ROW 4.1 COL 97
     RECT-287 AT ROW 7.38 COL 69
     RECT-83 AT ROW 6 COL 4
     RECT-84 AT ROW 10.38 COL 4
     RECT-86 AT ROW 2.81 COL 4
     RECT-88 AT ROW 3.81 COL 68
     RECT-290 AT ROW 4.86 COL 4
     RECT-291 AT ROW 4.86 COL 4
     RECT-292 AT ROW 9.24 COL 4
     RECT-293 AT ROW 3.14 COL 5
     RECT-294 AT ROW 13.95 COL 4.5
     RECT-295 AT ROW 13.95 COL 36.67
     RECT-296 AT ROW 2.62 COL 68
     RECT-297 AT ROW 11.14 COL 67.83
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 7.83 ROW 2.14
         SIZE 118.5 BY 15.38
         BGCOLOR 3 .

DEFINE FRAME FRAME-A
     " 3. ถ้าไม่ทราบคลิกปุ่ม OK เครื่องจะบอก Letter No" VIEW-AS TEXT
          SIZE 38.17 BY 1.05 AT ROW 4.48 COL 2.5
          BGCOLOR 32 FGCOLOR 2 
     " 2. ถ้าทราบ Letter No เดิมให้ใส่ที่ช่อง Letter No" VIEW-AS TEXT
          SIZE 38.17 BY 1.05 AT ROW 3.43 COL 2.5
          BGCOLOR 32 FGCOLOR 2 
     " 4. ให้นำ Letter No ที่ได้มาใส่ที่ช่อง Letter No" VIEW-AS TEXT
          SIZE 38.17 BY 1.29 AT ROW 5.43 COL 2.5
          BGCOLOR 32 FGCOLOR 2 
     " 1. คลิกพิมพ์ซ้ำ" VIEW-AS TEXT
          SIZE 38.17 BY 1.05 AT ROW 2.38 COL 2.5
          BGCOLOR 32 FGCOLOR 2 
     "วิธีการพิมพ์ซ้ำ" VIEW-AS TEXT
          SIZE 41 BY 1.05 AT ROW 1 COL 1
          BGCOLOR 1 FGCOLOR 7 FONT 6
     RECT-288 AT ROW 2.24 COL 2.17
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 59.5 ROW 18.1
         SIZE 41.5 BY 6.48
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
         TITLE              = "Wacr04 - Notice for Agent"
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

ASSIGN XXTABVALXX = FRAME frbtn:MOVE-BEFORE-TAB-ITEM (FRAME frSt:HANDLE)
       XXTABVALXX = FRAME frOutput:MOVE-BEFORE-TAB-ITEM (FRAME frbtn:HANDLE)
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
ON END-ERROR OF C-Win /* Wacr04 - Notice for Agent */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Wacr04 - Notice for Agent */
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
            FRAME frST fiacno1 fiacno1
            FRAME frST fiacno2 fiacno2
            FRAME frST fiDoc fiDoc
            FRAME frST fiDoc2 fiDoc2
            FRAME frST toReprint toReprint
            FRAME frST fiContractName fiContractName
            FRAME frST fiExt fiExt
            FRAME frST fiDate fiDate
            FRAME frST fiPowerName fiPowerName
            FRAME frST fiPosition fiPosition
                                            
            FRAME frOutput rsOutput rsOutput
            FRAME frOutput cbPrtList cbPrtList
            FRAME frOutput fiFile-Name fiFile-Name

            vContractName = fiContractName
            vExt       = fiExt
            vDate      = fiDate
            vPowerName = fiPowerName
            vPosition  = fiPosition
            vAcnoInt   = "1"

            n_branch  = fiBranch
            n_branch2 = fiBranch2            
            n_frac    =  fiAcno1
            n_toac    =  fiAcno2 
            n_asdat   =  DATE( INPUT cbAsDat)   
            n_typ     =  IF raY = 1 THEN "" ELSE "Y"
            n_typ1    =  IF raZ = 1 THEN "" ELSE "Z"         
     
            n_OutputTo    =  rsOutput
            n_OutputFile  =  fiFile-Name

            vMaxdoc =   INTEGER(fiDoc + STRING(fiDoc2, "9999")).
    
   END.

   FIND LAST AcProc_fil USE-INDEX by_type_asdat  
       WHERE (AcProc_fil.type = "01" AND AcProc_fil.asdat = n_asdat) NO-LOCK NO-ERROR . 
    IF AVAIL AcProc_fil THEN DO:
          n_trndatto  =  AcProc_fil.trndatto.
    END.

   IF  n_frac = "" THEN  n_frac = "A000000".
   IF  n_toac = "" THEN  n_toac = "B999999999". 

      IF fiDate = "" THEN DO:
         Message "Please Input Date" VIEW-AS ALERT-BOX ERROR. 
         Apply "Entry" To  fiDate.
         RETURN NO-APPLY.   
      END.
    
      IF fiDate < STRING(DAY(TODAY), "99") THEN DO:
         Message "Day must be MORE than day today" VIEW-AS ALERT-BOX ERROR. 
         Apply "Entry" To  fiDate.
         RETURN NO-APPLY.   
      END.  
  
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
   
      IF fiDoc2 = 0 THEN DO:
            Message "Please Input Letter No" VIEW-AS ALERT-BOX ERROR.
            Apply "Entry" To fiDoc2.
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
    /*-------- A58-0172 ---------------*/
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
              RUN ProcPrint.   
          END.
          WHEN FALSE THEN    DO:
              RETURN NO-APPLY. 
          END.
          END CASE.  
      
      END.   /* else IF asdat = ? */ 
/*--- end A58-0172 ---*/

      /*RUN ProcPrint. ---A58-0172 --*/

  END.      /*toReprint = False*/
  ELSE DO:                                      /*----- RePrint Record -----*/
      IF ( n_branch <> n_branch2)   THEN DO:
            Message "INCORRECT Branch" SKIP(1)
                    "Branch To Must be equal to Branch From" VIEW-AS ALERT-BOX ERROR. 
            Apply "Entry" To fibranch2.
            RETURN NO-APPLY.       
      END.
      
      IF ( n_frac > n_toac) THEN DO:
            Message " ' REPRINT ' "SKIP(1)
                    "INCORRECT Producer Code" SKIP(1)
                    "Producer Code To Must be greater than Producer Code From" VIEW-AS ALERT-BOX ERROR. 
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
                              "As Of Date     : " STRING(n_asdat,"99/99/9999") SKIP (1)
                              VIEW-AS ALERT-BOX QUESTION
          BUTTONS YES-NO
          TITLE "Confirm"    UPDATE CHOICE1 AS LOGICAL.
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

/*--- A46-0148
    FIND LAST docno_fil WHERE docno_fil.branch = STRING(YEAR(n_asdat), "9999") +
                                                                                        STRING(MONTH(n_asdat), "99") +
                                                                                        STRING(DAY(n_asdat), "99")  AND
                                docno_fil.startno <> 0  NO-LOCK NO-ERROR.  /*หาค่ามากที่สุดของเลขที่จดหมาย*/

    IF AVAIL docno_fil THEN DO:
          vMaxdoc =  docno_fil.startno. 
          fiDoc2 = INTEGER(SUBSTRING(STRING(vMaxdoc),5,4)) + 1.
          DISP fiDoc2 WITH FRAME frSt.  
    END.
    ELSE DO:
          vMaxdoc =  INTEGER(SUBSTRING(STRING(YEAR(TODAY) + 543),3,2) + 
                                  STRING(MONTH(TODAY), "99") + "0000").
          fiDoc2 = 0001.                                  
          DISP fiDoc2 WITH FRAME frSt.  
    END.
A46-0148 ---*/

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


&Scoped-define SELF-NAME cbAsDat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cbAsDat C-Win
ON VALUE-CHANGED OF cbAsDat IN FRAME frSt
DO:
    
    cbAsdat  = INPUT cbAsdat.
  
    n_asdat    =  DATE( INPUT cbAsDat)   .
    

    RUN pdRunningNo.   /* หา running no เบอร์ ล่าสุด ใน table docno_fil */
  
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

    IF (fiacno1 > fiacno2)  AND (fiacno1 <> "" AND fiacno2 <> "")   THEN DO:
        Message "INCORRECT Producer Code" SKIP(1)
                         "Producer Code To Must be greater than Producer Code From" 
           VIEW-AS ALERT-BOX ERROR. 
        APPLY "Entry" TO fiacno2  .
        Return No-Apply.       
    END.
    
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
  
/*  IF fiContractName = "" THEN DO:
 *      Message "Please Input Contract Name" VIEW-AS ALERT-BOX ERROR. 
 *      Apply "Entry" To  fiContractName.
 *      Return No-Apply.   
 *   END.*/
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiDate
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiDate C-Win
ON LEAVE OF fiDate IN FRAME frSt
DO:
    fiDate = INPUT fiDate.

  IF fiDate = "" THEN DO:
     Message "Please Input Date" VIEW-AS ALERT-BOX ERROR. 
     Apply "Entry" To  fiDate.
     Return No-Apply.   
  END.
  
  IF fiDate < STRING(DAY(TODAY), "99") THEN DO:
     Message "Day must be MORE than day today" VIEW-AS ALERT-BOX ERROR. 
     Apply "Entry" To  fiDate.
     Return No-Apply.   
  END.  

/*  IF SUBSTRING(fiDate,1,2) < STRING(DAY(TODAY), "99") THEN DO:
 *      Message "Day must be MORE than day today" VIEW-AS ALERT-BOX ERROR. 
 *      Apply "Entry" To  fiDate.
 *      Return No-Apply.   
 *   END.
 * 
 *   IF SUBSTRING(fiDate,3,2) < STRING(MONTH(TODAY), "99") THEN DO:
 *      Message "Month must be EQUAL month today" VIEW-AS ALERT-BOX ERROR. 
 *      Apply "Entry" To  fiDate.
 *      Return No-Apply.   
 *   END.
 * 
 *   IF SUBSTRING(fiDate,5,4) <> STRING(YEAR(TODAY) + 543, "9999") THEN DO:
 *      Message "Year must be EQUAL year today" VIEW-AS ALERT-BOX ERROR. 
 *      Apply "Entry" To  fiDate.
 *      Return No-Apply.   
 *   END.*/

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
  ASSIGN
     fiDoc2 = INPUT fiDoc2.
  
  IF fiDoc2 = 0 THEN DO:
     Message "Please Input Letter No" VIEW-AS ALERT-BOX ERROR.
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


&Scoped-define SELF-NAME raY
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL raY C-Win
ON VALUE-CHANGED OF raY IN FRAME frSt
DO:
  assign 
  raY = input raY.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME raZ
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL raZ C-Win
ON VALUE-CHANGED OF raZ IN FRAME frSt
DO:
  assign
  raZ = input raZ.

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


&Scoped-define FRAME-NAME frSt
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
  
  gv_prgid = "wacr04".
  gv_prog  = "Notice for Agent".
  RUN  WUT\WUTHEAD (c-win:handle,gv_prgid,gv_prog).
  RUN  WUT\WUTDICEN (c-win:HANDLE).

/*********************************************************************/

  RECT-110:MOVE-TO-TOP().
  RECT-287:MOVE-TO-TOP().
    RUN ProcGetPrtList.
    RUN pdAcProc_fil.

    ASSIGN
      rsOutput:Radio-Buttons = "Screen, 1,Printer, 2, File, 3"
      rsOutput = 2
      fiFile-Name:BGCOLOR = 34
      cbPrtList:SENSITIVE    = Yes
      fiFile-Name:SENSITIVE  = No.
    DISPLAY rsOutput WITH FRAME frOutput .  

    IF LENGTH(n_User) = 6 THEN n_lbran = SUBSTR(n_User,6,1) .
    ELSE n_lbran = SUBSTR(n_User,6,2).

    DO WITH FRAME frST:
        ASSIGN   
            raY = 1
            raZ = 1
            fiacno1    = ""
            fiacno2    = ""
            fibranch   = n_lbran
            fibranch2  = n_lbran
            cbAsdat    = vAcProc_fil
            n_asdat    =  DATE(INPUT cbAsDat).
        DISPLAY  fibranch fibranch2 fiacno1 fiacno2 cbAsdat raY raZ.

        RUN pdbranch.

        ASSIGN
            fiDoc = SUBSTRING(STRING(YEAR(n_asdat ) + 543),3,2) + STRING(MONTH(TODAY),"99")          
            fiDate = "15" 
            fiMonth = STRING(MONTH(TODAY))
            fiYear = STRING(YEAR(TODAY)+ 543, "9999") 
            /*fiPowerName = "นางสาว วิไลลักษณ์ ลิ้มณรงค์" 
            fiPosition = "ผู้ช่วยผู้อำนวยการอาวุโสฝ่ายการเงิน". fon A49-0065 */
            fiPowerName  = nv_a4a_43      /*-- A58-0172 --*/   
            fiPosition  = "ผู้จัดการอาวุโสฝ่ายการเงิน" . /*-- A58-0172 --*/ 

        DISP fiDoc fiDate fiMonth fiYear fiPowerName fiPosition .

    END.
    /*RUN pdname.  ---A58-0172 --*/
    RUN pdDisable.        /*  DISABLE fiDoc2 เมื่อต้องการพิมพ์ปกติ */
    /*RUN pdRunningNo.   /* หา running no เบอร์ ล่าสุด ใน table docno_fil */*/

/*--- A46-0148
    FIND LAST docno_fil WHERE docno_fil.branch = STRING(YEAR(n_asdat), "9999") +
                                                                                        STRING(MONTH(n_asdat), "99") +
                                                                                        STRING(DAY(n_asdat), "99")  AND
                                docno_fil.startno <> 0  NO-LOCK NO-ERROR.  /*หาค่ามากที่สุดของเลขที่จดหมาย*/

    IF AVAIL docno_fil THEN DO:
          vMaxdoc =  docno_fil.startno. 
          fiDoc2 = INTEGER(SUBSTRING(STRING(vMaxdoc),5,4)) + 1.
          DISP fiDoc2 WITH FRAME frSt.  
    END.
    ELSE DO:
          vMaxdoc =  INTEGER(SUBSTRING(STRING(YEAR(TODAY) + 543),3,2) + 
                                  STRING(MONTH(TODAY), "99") + "0001").
          fiDoc2 = 0001.                                  
          DISP fiDoc2 WITH FRAME frSt.  
    END.
A46-0148---*/

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
   FOR EACH docno_fil USE-INDEX docno01 WHERE LENGTH(docno_fil.branch) = 8 AND docno_fil.poltyp = n_branch 
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
  ENABLE IMAGE-24 RECT-87 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  DISPLAY fiBranch fiBranch2 fiacno1 fiacno2 fiDoc2 fidoc fiDate fiPowerName 
          fiPosition fiContractName fiExt cbAsDat raY raZ toReprint fiMonth 
          fiYear fibdes fibdes2 finame1 finame2 
      WITH FRAME frSt IN WINDOW C-Win.
  ENABLE fiBranch fiBranch2 fiacno1 fiacno2 fiDoc2 fiDate fiPowerName 
         fiPosition fiContractName fiExt cbAsDat buBranch buBranch2 buAcno 
         buAcno2 raY raZ toReprint fiMonth fiYear fibdes fibdes2 finame1 
         finame2 RECT-104 RECT-106 RECT-108 RECT-110 RECT-287 RECT-83 RECT-84 
         RECT-86 RECT-88 RECT-290 RECT-291 RECT-292 RECT-293 RECT-294 RECT-295 
         RECT-296 RECT-297 
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

/*d-day = DAY(d1).
d-mon = MONTH(d1).
IF d-mon = 2 AND d-day = 29 THEN d-day = 28.
d2 = DATE(d-mon,d-day,YEAR(d1) - 1).*/
                               
d-day = DAY(TODAY).
d-mon = MONTH(TODAY).
IF d-mon =2 AND d-day = 29 THEN d-day = 28.
d2 = DATE(d-mon,d-day,YEAR(TODAY) - 1).

                                   
     vAcProc_fil = "" .                                                                                     
 FOR EACH AcProc_fil USE-INDEX by_type_asdat  WHERE AcProc_fil.type = "01" AND AcProc_fil.asdat >= d2 NO-LOCK BY asdat DESC  : 
       /* IF AcProc_fil.asdat >= d2 THEN */
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdBranch C-Win 
PROCEDURE pdBranch :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO WITH FRAME frST:
 ASSIGN 
         fibranch = n_lbran
         fibranch2 = n_lbran
         n_branch = fibranch.

    FIND  xmm023 WHERE xmm023.branch = n_branch NO-LOCK NO-ERROR.
        IF AVAILABLE xmm023 THEN DO:
              fibdes:Screen-value  = xmm023.bdes.
              fibdes2:Screen-value = xmm023.bdes.
        END.        
        ELSE DO: 
              fibdes:Screen-value = "Not Found !".
              fibdes2:Screen-value = "Not Found !".
        END. 
    RUN pdRunningNo.   /* หา running no เบอร์ ล่าสุด ใน table docno_fil */  
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
        toReprint  = INPUT toReprint.  
        IF toReprint = TRUE THEN DO:  /* พิมพ์ซ้ำ*/
            ENABLE fiDoc2.
            fiDoc2:BGCOLOR = 15.
        END.
        ELSE DO:
            DISABLE fiDoc2.
            fiDoc2:BGCOLOR = 34.
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
ASSIGN
    nv_docno = 0
    nv_year = SUBstr(STRING(YEAR(TODAY) + 543,"9999"),3,2)
    nv_mon  = STRING(MONTH(TODAY),"99")
    nv_use  = nv_year + nv_mon.
    /*-- for each เอาเลขที่จดหมายปัจจุบัน--*/

    FOR EACH docno_fil USE-INDEX docno01 WHERE LENGTH(docno_fil.branch) = 8 AND 
                                 docno_fil.poltyp = n_branch NO-LOCK BREAK BY docno_fil.startno DESC.
        IF SUBSTR(STRING(docno_fil.startno),1,4) = nv_use THEN DO:
                nv_docno = docno_fil.startno.
                LEAVE.
         END.
    END.

    IF nv_docno <> 0 THEN DO:
    ASSIGN
        vMaxdoc =  nv_docno
        fiDoc2 = INTEGER(SUBSTRING(STRING(vMaxdoc),5,4)) + 1.
        DISP fiDoc2 WITH FRAME frSt.
    END.
    ELSE DO:
      ASSIGN
        vMaxdoc =  INTEGER(SUBSTRING(STRING(YEAR(TODAY) + 543),3,2) + STRING(MONTH(TODAY), "99") + "0001")
        fiDoc2 = 0001.
        DISP fiDoc2 WITH FRAME frSt. 
    END.

    RELEASE docno_fil.
    
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
                         "มีการพิมพ์จดหมายเตือนเบี้ยประกันภัยค้างชำระแล้ว" SKIP
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
                     RB-DB-CONNECTION = dbtable.unixpara +  " -U " + n_User + " -P " + n_Passwd. /*--A49-0139--*/
          END.
      END.
/*---kan*/
/*---- A58-0172 ---*/
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
DEF VAR n_chk AS INT.    /*--A58-0172 : RANU --*/
DO: 
        ASSIGN
                n_chk = 0    /*--A58-0172 : RANU --*/
                report-library =  "Wac/wprl/Wac_sm03.prl"
                report-name  =  "Letter".
           /*---- A58-0172 : RANU ---*/
           ASSIGN 
                nv_pic = nv_a4a_38.
                nv_pic = SEARCH(nv_pic).
                IF nv_pic = ? OR nv_pic = "" THEN DO:
                    MESSAGE "not found picture" VIEW-AS ALERT-BOX.
                END.
            /*---- end : A58-0172 ---*/
              
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
              RB-INCLUDE-RECORDS  = "O"                                                                                                                                                                                                                    
              RB-PRINT-DESTINATION = SUBSTR ("D A", rsOutput, 1)
              RB-PRINTER-NAME   = IF rsOutput = 2 THEN cbPrtList ELSE " "
              RB-OUTPUT-FILE       = IF rsOutput = 3 THEN fiFile-Name ELSE " "
              RB-NO-WAIT               = No
              RB-OTHER-PARAMETERS =  "rb_vCliCod     
                                  = " + STRING(vCliCod) + CHR(10) +
/*                                "rb_n_doc  = " + STRING(vDoc, "9999") + CHR(10) +
 *                                 "rb_n_doc2  = " + STRING(vDoc2, "9999") + CHR(10) +*/
                                  "rb_n_ContractName  = " + STRING(vContractName) + CHR(10) +
                                  "rb_n_Ext  = " + STRING(vExt) + CHR(10) +
                                  "rb_n_PowerName = " + STRING(vPowerName) + CHR(10) +
                                  "rb_n_Position = " + STRING(vPosition) + CHR(10) +
                                  "rb_n_Date = " + STRING(vDate) + CHR(10) +
                                  "rb_n_branch = " + STRING(branch) + CHR(10) +   /*--- A58-0172 : RANU --*/
                                  "rb_n_trndatto  = " + STRING(n_trndatto,"99/99/9999") + CHR(10) +
                                  "rb_n_pic = " + STRING(nv_pic) + CHR(10) +      /*--- A58-0172 : RANU --*/
                                  "rb_pich  = " + nv_a4a_07 .
                                
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

