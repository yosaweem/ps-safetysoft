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
/*****************************************
/* CREATE BY :  Kanchana C.        A46-0478  */
War
        -wace1001.w   โปรแกรม query  match เบี้ย DR & CR Matching
        -wace1002.w                 หน้าจอ ขณะ  match เบี้ย  (ใช้โปรแกรมเดิม)  /**/
        wace1001.i
    Program In Premium  ใช้โปรแกรมเดิม
        wac01102.i         modify from  ACO01102.I     01.05.11.23 List of canceled
        wac01104.p                              ACO01104.P

    field acm001.disput   เป็น field ที่เก็บสถานะการ match ของแต่ละ record 
    1. ก่อน match ถ้า เป็น yes = mark ว่าต้องการ match record นี้
    2. ขณะ match    เป็น yes แสดงว่า match สำเร็จ
                        ถ้า เป็น  no แสดงว่า match ไม่สำเร็จ
    
โปรแกรมจะ 
1. ดึงรายการที่ แต่ละ record policy ที่ต่าง endose กัน  และจับคู่กัน  
2.แล้วสามารถตัดเบี้ยได้ทั้ง เบี้ย +   เบี้ย  -   แล้วให้ bal ทั้ง 2 record = 0 
    - mark รายการ ที่ต้องการ match  หรือ คลิก Match All (เลือกทั้งหมด)
    - ระบุ contra date
    - คลิก match detail
    - คลิก ปุ่ม confirm  (wace1002.w)
    
/* MODIFY BY :  Kanchana C.      A47-0999   */
- record trntyp1 = "R"  จะต้องมี trndate อยู่ในช่วงด้วย
    
******************************************/

 Modify By : TANTAWAN C.   20/05/2008   [A500178]
             ปรับ FORMAT branch เพื่อรองรับการขยายสาขา
             ขยาย FORMAT fiacno  จาก "X(7)" เป็น  Char "X(10)"
เปลี่ยน FORMAT DISPLAY ของ  Policy จาก  X-X-XX-XX/XXXXXX เป็น  XX-XX-XX/XXXXXX  

------------------------------------------------------------------------*
 Modify By : TANTAWAN C. 08/07/2008  [A51-0160]
            Defult ค่าของ Producer code From -  To  เป็น  A000000 - BZZZZZZZZZ
            ไม่ต้องเช็ค producer code เนื่องจาก user จะไม่ทราบว่า code ไหนเป็น code แรก หรือสุดท้าย
            
 Modify By : Lukkana M.  Date : 05/01/2011
 Assign No : A53-0395 เพิ่มเงื่อนไขเช็ค agent code ต้องเป็นตัวเดียวกันถึงจะดึงข้อมูลมาแสดงบนหน้าจอ    
 
 Modify By : Lukkana M.  Date : 07/08/2012
 Assign No : A55-0243 เช็คเงื่อนไข acno,agent ต้องเป็นตัวเดียวกัน      
 
 Modify By : Phaiboon W. Date : 14/06/2016
 Assign No : A59-0233 แก้ไขให้ระบุ Agent Cod ที่ไม่ต้องการได้  

 Modify By : Chonlatis j. Date 03/11/2017
 Assign    :A60-0419 แก้ไขให้ระบุ Acc No. ที่ไม่ต้องการจากเดิม Agent No.
 
 Modify By : ฤ61-0151 Nattanicha K. 23/03/2018  
            แก้ไข Loop ให้ Process เร็วขึ้น
------------------------------------------------------------------------*/
/*          This .W file was created with the Progress UIB.             */
/*----------------------------------------------------------------------*/

/* Create an unnamed pool to store all the widgets created 
     by this procedure. This is a good default which assures
     that this procedure's triggers and internal procedures 
     will execute in this procedure's storage, and that proper
     cleanup will occur on deletion of the procedure. */

CREATE WIDGET-POOL.

/* ***************************  Definitions  ************************** */
DEF     SHARED VAR n_User           AS CHAR.
DEF     SHARED VAR n_Passwd         AS CHAR.  

/* Parameters Definitions ---                                           */
/*--- A500178 ---
DEF NEW SHARED VAR n_agent1 AS CHAR FORMAT "x(7)".
DEF NEW SHARED VAR n_agent2 AS CHAR FORMAT "x(7)".
------*/
DEF NEW SHARED VAR n_agent1 AS CHAR FORMAT "x(10)".
DEF NEW SHARED VAR n_agent2 AS CHAR FORMAT "x(10)".

Def   Var    n_name    As Char Format "x(50)".     /*acno name*/
Def   Var    n_chkname As Char format "x(1)".        /* Acno-- chk button 1-2 */

DEF NEW SHARED TEMP-TABLE wacm001_m  /*LIKE acm001 */  /* + */
    /*Lukkana M. A55-0243 14/08/2012 เพิ่มเนื่องจากมีการปรับโครงสร้าง table acm001*/
    FIELD policy_m LIKE acm001.policy
    FIELD recno_m  LIKE acm001.recno
    FIELD trnty1_m LIKE acm001.trnty1
    FIELD trnty2_m LIKE acm001.trnty2
    FIELD docno_m  LIKE acm001.docno
    FIELD baloc_m  LIKE acm001.baloc
    FIELD prem_m   LIKE acm001.prem
    FIELD comm_m   LIKE acm001.comm
    FIELD stamp_m  LIKE acm001.stamp
    FIELD tax_m    LIKE acm001.tax
    FIELD fee_m    LIKE acm001.fee
    FIELD netamt_m LIKE acm001.netamt
    FIELD bal_m    LIKE acm001.bal
    FIELD trndat_m LIKE acm001.trndat
    FIELD ref_m    LIKE acm001.ref
    FIELD comdat_m LIKE acm001.comdat
    FIELD acno_m   LIKE acm001.acno
    FIELD agent_m  LIKE acm001.agent
    FIELD curcod_m LIKE acm001.curcod
    FIELD branch_m LIKE acm001.branch
    FIELD netloc_m LIKE acm001.netloc
    FIELD poltyp_m LIKE acm001.poltyp
    FIELD vehreg_m LIKE acm001.vehreg
    FIELD insno_m  LIKE acm001.insno
    FIELD instot_m LIKE acm001.instot
    FIELD dociln_m LIKE acm001.dociln
    FIELD disput_m LIKE acm001.disput
INDEX wacm00101_m trnty1_m docno_m
INDEX wacm00104_m policy_m recno_m.
    /*Lukkana M. A55-0243 14/08/2012 เพิ่มเนื่องจากมีการปรับโครงสร้าง table acm001*/
/*
DEF  TEMP-TABLE  wtGrpCode          /* workfile รายชื่อ group code ของแต่ละตัวแทน  ชื่อไฟล์ + "G" */
    FIELD wtgpage   AS CHAR
    FIELD wtgpName  AS CHAR
    FIELD wtacno    AS CHAR
    FIELD wtname    AS CHAR
INDEX  wtGrpCode1 IS UNIQUE PRIMARY wtgpage wtacno  ASCENDING
INDEX  wtGrpCode2  wtacno. */


DEF NEW SHARED TEMP-TABLE wacm001_r  /*LIKE acm001*/   /* + */
    /*Lukkana M. A55-0243 14/08/2012 เพิ่มเนื่องจากมีการปรับโครงสร้าง table acm001*/
    FIELD policy_r LIKE acm001.policy
    FIELD recno_r  LIKE acm001.recno
    FIELD trnty1_r LIKE acm001.trnty1
    FIELD trnty2_r LIKE acm001.trnty2
    FIELD docno_r  LIKE acm001.docno
    FIELD baloc_r  LIKE acm001.baloc
    FIELD prem_r   LIKE acm001.prem
    FIELD comm_r   LIKE acm001.comm
    FIELD stamp_r  LIKE acm001.stamp
    FIELD tax_r    LIKE acm001.tax
    FIELD fee_r    LIKE acm001.fee
    FIELD netamt_r LIKE acm001.netamt
    FIELD bal_r    LIKE acm001.bal
    FIELD trndat_r LIKE acm001.trndat
    FIELD ref_r    LIKE acm001.ref
    FIELD comdat_r LIKE acm001.comdat
    FIELD acno_r   LIKE acm001.acno
    FIELD agent_r  LIKE acm001.agent
    FIELD curcod_r LIKE acm001.curcod
    FIELD branch_r LIKE acm001.branch
    FIELD netloc_r LIKE acm001.netloc
    FIELD poltyp_r LIKE acm001.poltyp
    FIELD vehreg_r LIKE acm001.vehreg
    FIELD insno_r  LIKE acm001.insno
    FIELD instot_r LIKE acm001.instot
    FIELD dociln_r LIKE acm001.dociln
    FIELD disput_r LIKE acm001.disput
INDEX wacm00101_r trnty1_r docno_r
INDEX wacm00104_r policy_r recno_r .
    /*Lukkana M. A55-0243 14/08/2012 เพิ่มเนื่องจากมีการปรับโครงสร้าง table acm001*/

/* Local Variable Definitions ---                                       */

/*format rcno , polno = STRING(policy,"X-X-XX-XX/XXXXXXX".)*/
/* DEF VAR nv_frcno AS CHAR INIT "X-XXXX/XXXXX".       */
DEF VAR nv_fpolno AS CHAR INIT "XX-XX-XX/XXXXXXX".
DEF VAR nv_polno  AS CHAR INIT "".

DEF VAR nv_acno1 AS CHAR.
DEF VAR nv_acno2 AS CHAR.
DEF VAR nv_polFr  AS CHAR.
DEF VAR nv_polTo AS CHAR.
DEF VAR nv_trndatFr AS DATE.
DEF VAR nv_trndatTo AS DATE.


DEF  BUFFER   bufacm001 FOR ACM001.

DEF NEW SHARED VAR s_latdat AS DATE.

DEF NEW SHARED VAR  s_policy_m AS CHAR.
DEF NEW SHARED VAR  s_recno_m AS CHAR.
DEF NEW SHARED VAR  s_policy_r AS CHAR.
DEF NEW SHARED VAR  s_recno_r AS CHAR.

DEF VAR  n_chkmatch AS LOGIC.

DEF VAR nv_cntTotDr AS INT.
DEF VAR nv_cntTotCr AS INT.

DEF VAR nv_sumDr AS DECI.
DEF VAR nv_sumCr AS DECI.

DEF VAR nv_polclick  AS CHAR.

/*DEF INPUT-OUTPUT PARAMETER n_chkmatch AS LOGIC.*/

DEF VAR nv_chkMatch AS LOGIC.


DEF VAR nv_starttim AS CHAR.
DEF VAR nv_endtim   AS CHAR.

DEF NEW SHARED TEMP-TABLE acm001_m  /*LIKE acm001*/   /* Lukkana M. A53-0395 05/01/2011 */
    /*Lukkana M. A55-0243 14/08/2012 เพิ่มเนื่องจากมีการปรับโครงสร้าง table acm001*/
    FIELD policy_m1 LIKE acm001.policy
    FIELD recno_m1  LIKE acm001.recno
    FIELD trnty1_m1 LIKE acm001.trnty1
    FIELD trnty2_m1 LIKE acm001.trnty2
    FIELD docno_m1  LIKE acm001.docno
    FIELD baloc_m1  LIKE acm001.baloc
    FIELD prem_m1   LIKE acm001.prem
    FIELD comm_m1   LIKE acm001.comm
    FIELD stamp_m1  LIKE acm001.stamp
    FIELD tax_m1    LIKE acm001.tax
    FIELD fee_m1    LIKE acm001.fee
    FIELD netamt_m1 LIKE acm001.netamt
    FIELD bal_m1    LIKE acm001.bal
    FIELD trndat_m1 LIKE acm001.trndat
    FIELD ref_m1    LIKE acm001.ref
    FIELD comdat_m1 LIKE acm001.comdat
    FIELD acno_m1   LIKE acm001.acno
    FIELD agent_m1  LIKE acm001.agent
    FIELD curcod_m1 LIKE acm001.curcod
    FIELD branch_m1 LIKE acm001.branch
    FIELD netloc_m1 LIKE acm001.netloc
    FIELD poltyp_m1 LIKE acm001.poltyp
    FIELD vehreg_m1 LIKE acm001.vehreg
    FIELD insno_m1  LIKE acm001.insno
    FIELD instot_m1 LIKE acm001.instot
    FIELD dociln_m1 LIKE acm001.dociln
    FIELD disput_m1 LIKE acm001.disput
INDEX acm00104_m policy_m1 recno_m1.
    /*Lukkana M. A55-0243 14/08/2012 เพิ่มเนื่องจากมีการปรับโครงสร้าง table acm001*/
DEF BUFFER  bacm001 FOR acm001. /* Lukkana M. A53-0395 05/01/2011 */


DEF VAR n_acno AS CHAR. /* add by Phaiboon W. [A59-0233] 14/06/2016 */

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define BROWSE-NAME brwacm001_m

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES wacm001_m wacm001_r

/* Definitions for BROWSE brwacm001_m                                   */
&Scoped-define FIELDS-IN-QUERY-brwacm001_m IF wacm001_m.disput_m = NO THEN "" ELSE "*" wacm001_m.policy_m wacm001_m.recno_m wacm001_m.trnty1_m + wacm001_m.trnty2_m wacm001_m.docno_m wacm001_m.bal_m wacm001_m.prem_m wacm001_m.comm_m wacm001_m.stamp_m wacm001_m.tax_m wacm001_m.netamt_m wacm001_m.trndat_m wacm001_m.ref_m wacm001_m.comdat_m wacm001_m.acno_m /*-- ปรับ "X(10)" A500178 --*/ wacm001_m.agent_m /*-- ปรับ "X(10)" A500178 --*/   
&Scoped-define ENABLED-FIELDS-IN-QUERY-brwacm001_m   
&Scoped-define SELF-NAME brwacm001_m
&Scoped-define QUERY-STRING-brwacm001_m FOR EACH wacm001_m NO-LOCK
&Scoped-define OPEN-QUERY-brwacm001_m OPEN QUERY {&SELF-NAME} FOR EACH wacm001_m NO-LOCK.
&Scoped-define TABLES-IN-QUERY-brwacm001_m wacm001_m
&Scoped-define FIRST-TABLE-IN-QUERY-brwacm001_m wacm001_m


/* Definitions for BROWSE brwacm001_r                                   */
&Scoped-define FIELDS-IN-QUERY-brwacm001_r wacm001_r.policy_r wacm001_r.recno_r wacm001_r.trnty1_r + wacm001_r.trnty2_r wacm001_r.docno_r wacm001_r.bal_r wacm001_r.prem_r wacm001_r.comm_r wacm001_r.stamp_r wacm001_r.tax_r wacm001_r.netamt_r wacm001_r.trndat_r wacm001_r.ref_r wacm001_r.comdat_r wacm001_r.acno_r /*-- ปรับ "X(10)" A500178 --*/ wacm001_r.agent_r /*-- ปรับ "X(10)" A500178 --*/   
&Scoped-define ENABLED-FIELDS-IN-QUERY-brwacm001_r   
&Scoped-define SELF-NAME brwacm001_r
&Scoped-define QUERY-STRING-brwacm001_r FOR EACH wacm001_r NO-LOCK
&Scoped-define OPEN-QUERY-brwacm001_r OPEN QUERY {&SELF-NAME} FOR EACH wacm001_r NO-LOCK.
&Scoped-define TABLES-IN-QUERY-brwacm001_r wacm001_r
&Scoped-define FIRST-TABLE-IN-QUERY-brwacm001_r wacm001_r


/* Definitions for FRAME frwacm001                                      */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS IMAGE-24 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VARIABLE C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE IMAGE IMAGE-24
     FILENAME "WIMAGE\bgc01":U
     SIZE 132.5 BY 24.

DEFINE BUTTON buMatch 
     LABEL "Match Detail" 
     SIZE 15.83 BY 1.14
     FONT 6.

DEFINE VARIABLE fiBaloc_M AS DECIMAL FORMAT ">>>,>>>,>>9.99-":U INITIAL 0 
      VIEW-AS TEXT 
     SIZE 16.5 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiBaloc_R AS DECIMAL FORMAT ">>>,>>>,>>9.99-":U INITIAL 0 
      VIEW-AS TEXT 
     SIZE 16.5 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiComm_M AS DECIMAL FORMAT ">>>,>>>,>>9.99-":U INITIAL 0 
      VIEW-AS TEXT 
     SIZE 15 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiComm_R AS DECIMAL FORMAT ">>>,>>>,>>9.99-":U INITIAL 0 
      VIEW-AS TEXT 
     SIZE 15 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiLatdat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 13.5 BY 1 TOOLTIP "วันที่ที่มีผลบังคับ = Contra Date"
     BGCOLOR 15 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fiPrem_M AS DECIMAL FORMAT ">>,>>>,>>9.99-":U INITIAL 0 
      VIEW-AS TEXT 
     SIZE 15 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiPrem_R AS DECIMAL FORMAT ">>,>>>,>>9.99-":U INITIAL 0 
      VIEW-AS TEXT 
     SIZE 15 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiStamp_M AS DECIMAL FORMAT ">>>,>>9.99-":U INITIAL 0 
      VIEW-AS TEXT 
     SIZE 15 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiStamp_R AS DECIMAL FORMAT ">>>,>>9.99-":U INITIAL 0 
      VIEW-AS TEXT 
     SIZE 15 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiTax_M AS DECIMAL FORMAT ">>>,>>9.99-":U INITIAL 0 
      VIEW-AS TEXT 
     SIZE 15 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiTax_R AS DECIMAL FORMAT ">>>,>>9.99-":U INITIAL 0 
      VIEW-AS TEXT 
     SIZE 15 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 4 GRAPHIC-EDGE    
     SIZE 130.5 BY 3.67
     BGCOLOR 8 .

DEFINE BUTTON btnFirst 
     LABEL "<<" 
     SIZE 5 BY 1
     FONT 6.

DEFINE BUTTON btnLast 
     LABEL ">>" 
     SIZE 5 BY 1
     FONT 6.

DEFINE BUTTON btnNext 
     LABEL ">" 
     SIZE 5 BY 1
     FONT 6.

DEFINE BUTTON btnPrev 
     LABEL "<" 
     SIZE 5 BY 1
     FONT 6.

DEFINE BUTTON buGoto 
     IMAGE-UP FILE "wimage\zinu":U
     LABEL "" 
     SIZE 5 BY 1 TOOLTIP "Goto Policy No."
     FONT 6.

DEFINE BUTTON buAcno1 
     LABEL "..." 
     SIZE 3 BY .95 TOOLTIP "รหัส Producer"
     FONT 6.

DEFINE BUTTON buAcno2 
     LABEL "..." 
     SIZE 3 BY .95 TOOLTIP "รหัส Producer"
     FONT 6.

DEFINE BUTTON buAcno3 
     LABEL "..." 
     SIZE 3 BY .95 TOOLTIP "รหัส Producer"
     FONT 6.

DEFINE BUTTON buAdd 
     LABEL "Add" 
     SIZE 8.5 BY .95
     FONT 2.

DEFINE BUTTON buDel 
     LABEL "Del" 
     SIZE 8.5 BY .95
     FONT 2.

DEFINE BUTTON buExit 
     LABEL "Exit" 
     SIZE 13 BY 1.14
     FONT 2.

DEFINE BUTTON buReset 
     LABEL "Reset" 
     SIZE 13 BY 1.14
     FONT 2.

DEFINE BUTTON buSearch 
     LABEL "Search" 
     SIZE 13 BY 1.14
     FONT 2.

DEFINE VARIABLE fiacno1 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiacno2 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiacno3 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 16.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE finame1 AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 36.5 BY .95
     BGCOLOR 8 FONT 6 NO-UNDO.

DEFINE VARIABLE finame2 AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 36.5 BY .95
     BGCOLOR 8 FONT 6 NO-UNDO.

DEFINE VARIABLE fiPolfr AS CHARACTER FORMAT "XX-XX-XX/XXXXXXXX":U 
     VIEW-AS FILL-IN 
     SIZE 21 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiPolTo AS CHARACTER FORMAT "XX-XX-XX/XXXXXXXX":U 
     VIEW-AS FILL-IN 
     SIZE 21 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiTrnDatFr AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 13 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fiTrnDatTo AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 13 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE RECTANGLE reButton
     EDGE-PIXELS 4 GRAPHIC-EDGE    
     SIZE 17.5 BY 5.48
     BGCOLOR 8 .

DEFINE RECTANGLE reCanAcno
     EDGE-PIXELS 4 GRAPHIC-EDGE    
     SIZE 32 BY 5.48
     BGCOLOR 8 .

DEFINE RECTANGLE reOK1
     EDGE-PIXELS 4 GRAPHIC-EDGE    
     SIZE 130.5 BY 6
     BGCOLOR 19 .

DEFINE RECTANGLE reOk2
     EDGE-PIXELS 4 GRAPHIC-EDGE    
     SIZE 77.5 BY 5.48
     BGCOLOR 8 .

DEFINE VARIABLE seAcno AS CHARACTER 
     VIEW-AS SELECTION-LIST SINGLE SCROLLBAR-VERTICAL 
     SIZE 20 BY 3.57
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fiCntTotCr AS INTEGER FORMAT ">>>,>>9":U INITIAL 0 
      VIEW-AS TEXT 
     SIZE 8.5 BY 1
     FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fiCntTotDr AS INTEGER FORMAT ">>>,>>9":U INITIAL 0 
      VIEW-AS TEXT 
     SIZE 8 BY 1
     FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fiSumCr AS DECIMAL FORMAT ">>>,>>>,>>9.99-":U INITIAL 0 
      VIEW-AS TEXT 
     SIZE 19 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 2 NO-UNDO.

DEFINE VARIABLE fiSumDr AS DECIMAL FORMAT ">>>,>>>,>>9.99-":U INITIAL 0 
      VIEW-AS TEXT 
     SIZE 19 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 2 NO-UNDO.

DEFINE VARIABLE fi_endtim AS CHARACTER FORMAT "X(8)":U 
     LABEL "End Time" 
      VIEW-AS TEXT 
     SIZE 15 BY .76 NO-UNDO.

DEFINE VARIABLE fi_startim AS CHARACTER FORMAT "X(8)":U 
     LABEL "Start Time" 
      VIEW-AS TEXT 
     SIZE 15 BY .76 NO-UNDO.

DEFINE VARIABLE toMatchAll AS LOGICAL INITIAL no 
     LABEL "Match All" 
     VIEW-AS TOGGLE-BOX
     SIZE 13.5 BY 1
     BGCOLOR 1 FGCOLOR 7 FONT 6 NO-UNDO.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY brwacm001_m FOR 
      wacm001_m SCROLLING.

DEFINE QUERY brwacm001_r FOR 
      wacm001_r SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE brwacm001_m
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS brwacm001_m C-Win _FREEFORM
  QUERY brwacm001_m DISPLAY
      IF wacm001_m.disput_m = NO THEN "" ELSE "*"  FORMAT "X(1)"
    wacm001_m.policy_m FORMAT "X(14)"
    wacm001_m.recno_m COLUMN-LABEL "Endt No" FORMAT "X(11)"
    wacm001_m.trnty1_m + wacm001_m.trnty2_m  COLUMN-LABEL "Ty" FORMAT "X(3)"
    wacm001_m.docno_m  FORMAT "X(8)"
    wacm001_m.bal_m       FORMAT ">>,>>>,>>9.99-"    

    wacm001_m.prem_m
    wacm001_m.comm_m
    wacm001_m.stamp_m
    wacm001_m.tax_m
    wacm001_m.netamt_m

    wacm001_m.trndat_m
    wacm001_m.ref_m
    wacm001_m.comdat_m
    wacm001_m.acno_m  FORMAT "X(10)"  /*-- ปรับ format เป็น  "X(10)" A500178 --*/
    wacm001_m.agent_m FORMAT "X(10)"  /*-- ปรับ format เป็น  "X(10)" A500178 --*/
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS NO-COLUMN-SCROLLING SEPARATORS SIZE 65 BY 11
         BGCOLOR 15 FGCOLOR 0 FONT 6
         TITLE BGCOLOR 15 FGCOLOR 0 "Debit Note".

DEFINE BROWSE brwacm001_r
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS brwacm001_r C-Win _FREEFORM
  QUERY brwacm001_r DISPLAY
      wacm001_r.policy_r FORMAT "X(14)"
    wacm001_r.recno_r COLUMN-LABEL "Endt No" FORMAT "X(11)"
    wacm001_r.trnty1_r + wacm001_r.trnty2_r  COLUMN-LABEL "Ty" FORMAT "X(3)"
    wacm001_r.docno_r  FORMAT "X(8)"
    wacm001_r.bal_r       FORMAT ">>,>>>,>>9.99-"    

    wacm001_r.prem_r
    wacm001_r.comm_r
    wacm001_r.stamp_r
    wacm001_r.tax_r
    wacm001_r.netamt_r

    wacm001_r.trndat_r
    wacm001_r.ref_r
    wacm001_r.comdat_r
    wacm001_r.acno_r   FORMAT "X(10)"  /*-- ปรับ format เป็น  "X(10)" A500178 --*/
    wacm001_r.agent_r  FORMAT "X(10)"  /*-- ปรับ format เป็น  "X(10)" A500178 --*/
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS NO-COLUMN-SCROLLING SEPARATORS SIZE 65 BY 11
         BGCOLOR 8 FGCOLOR 0 FONT 6
         TITLE BGCOLOR 8 FGCOLOR 0 "Credit Note".


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     IMAGE-24 AT ROW 1 COL 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COLUMN 1 ROW 1
         SIZE 133 BY 24.

DEFINE FRAME frMain
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COLUMN 2 ROW 1.1
         SIZE 131.5 BY 23.8
         BGCOLOR 3 .

DEFINE FRAME frDrCr
     fiLatdat AT ROW 2.29 COL 97.33 COLON-ALIGNED NO-LABEL
     buMatch AT ROW 2.29 COL 114
     fiPrem_M AT ROW 2.29 COL 15.83 COLON-ALIGNED NO-LABEL
     fiStamp_M AT ROW 2.29 COL 31.83 COLON-ALIGNED NO-LABEL
     fiTax_M AT ROW 2.29 COL 47.83 COLON-ALIGNED NO-LABEL
     fiComm_M AT ROW 2.29 COL 63.83 COLON-ALIGNED NO-LABEL
     fiBaloc_M AT ROW 2.29 COL 79.83 COLON-ALIGNED NO-LABEL
     fiPrem_R AT ROW 3.33 COL 15.83 COLON-ALIGNED NO-LABEL
     fiStamp_R AT ROW 3.33 COL 31.83 COLON-ALIGNED NO-LABEL
     fiTax_R AT ROW 3.33 COL 47.83 COLON-ALIGNED NO-LABEL
     fiComm_R AT ROW 3.33 COL 63.83 COLON-ALIGNED NO-LABEL
     fiBaloc_R AT ROW 3.33 COL 79.83 COLON-ALIGNED NO-LABEL
     "AC | Contra Date":20 VIEW-AS TEXT
          SIZE 16.5 BY 1 AT ROW 1.24 COL 99.33
          BGCOLOR 8 FGCOLOR 2 FONT 6
     " Debit Note" VIEW-AS TEXT
          SIZE 14 BY 1 AT ROW 3.33 COL 2.33
          BGCOLOR 1 FGCOLOR 7 FONT 6
     "Premium" VIEW-AS TEXT
          SIZE 15 BY .95 AT ROW 1.24 COL 17.83
          FONT 6
     "Commission":20 VIEW-AS TEXT
          SIZE 15 BY .95 AT ROW 1.24 COL 65.83
          FONT 6
     "Bal OS.":20 VIEW-AS TEXT
          SIZE 16.5 BY .95 AT ROW 1.24 COL 81.83
          FONT 6
     " Credit Note":20 VIEW-AS TEXT
          SIZE 14 BY 1 AT ROW 2.29 COL 2.33
          BGCOLOR 1 FGCOLOR 7 FONT 6
     "Tax" VIEW-AS TEXT
          SIZE 15 BY .95 AT ROW 1.24 COL 49.83
          FONT 6
     "Stamp" VIEW-AS TEXT
          SIZE 15 BY .95 AT ROW 1.24 COL 33.83
          FONT 6
     RECT-2 AT ROW 1 COL 1
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COLUMN 1 ROW 20.91
         SIZE 131 BY 3.75
         BGCOLOR 19 .

DEFINE FRAME frOk
     buAdd AT ROW 1.71 COL 102.67
     fiacno3 AT ROW 1.71 COL 80 COLON-ALIGNED NO-LABEL
     seAcno AT ROW 2.86 COL 82 NO-LABEL
     buExit AT ROW 5.14 COL 116
     fiacno1 AT ROW 1.76 COL 20 COLON-ALIGNED NO-LABEL
     fiacno2 AT ROW 2.81 COL 20 COLON-ALIGNED NO-LABEL
     fiPolfr AT ROW 4.14 COL 20 COLON-ALIGNED NO-LABEL
     fiPolTo AT ROW 4.14 COL 54 COLON-ALIGNED NO-LABEL
     fiTrnDatFr AT ROW 5.43 COL 20 COLON-ALIGNED NO-LABEL
     fiTrnDatTo AT ROW 5.43 COL 54 COLON-ALIGNED NO-LABEL
     buSearch AT ROW 1.71 COL 116
     buReset AT ROW 3.05 COL 116
     buAcno1 AT ROW 1.81 COL 37.5
     buAcno2 AT ROW 2.81 COL 37.5
     finame1 AT ROW 1.81 COL 39 COLON-ALIGNED NO-LABEL
     finame2 AT ROW 2.81 COL 39 COLON-ALIGNED NO-LABEL
     buAcno3 AT ROW 1.71 COL 99
     buDel AT ROW 3 COL 102.67
     "Policy From":40 VIEW-AS TEXT
          SIZE 15 BY .95 TOOLTIP "Policy From" AT ROW 4.14 COL 6
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "Trndate From":50 VIEW-AS TEXT
          SIZE 15 BY .95 TOOLTIP "Trndate From" AT ROW 5.43 COL 6
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "To":20 VIEW-AS TEXT
          SIZE 6 BY .95 TOOLTIP "รหัสตัวแทนถึง" AT ROW 2.76 COL 15.5
          BGCOLOR 8 FONT 6
     "Producer From":50 VIEW-AS TEXT
          SIZE 15 BY .95 TOOLTIP "Account No. From" AT ROW 1.76 COL 6.5
          BGCOLOR 8 FONT 6
     "To":20 VIEW-AS TEXT
          SIZE 5 BY .95 TOOLTIP "Trndate To" AT ROW 5.43 COL 49.5
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "To":20 VIEW-AS TEXT
          SIZE 5 BY .95 TOOLTIP "Policy To" AT ROW 4.14 COL 49.5
          BGCOLOR 19 FGCOLOR 0 FONT 6
     reOK1 AT ROW 1 COL 1
     reOk2 AT ROW 1.24 COL 2
     reButton AT ROW 1.24 COL 113.5
     reCanAcno AT ROW 1.24 COL 80.5
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COLUMN 1 ROW 1
         SIZE 131 BY 6.09
         BGCOLOR 18 .

DEFINE FRAME frwacm001
     brwacm001_m AT ROW 1 COL 1.17
     brwacm001_r AT ROW 1 COL 66.5
     toMatchAll AT ROW 12.24 COL 1.5
     fiCntTotDr AT ROW 12.24 COL 45.5 RIGHT-ALIGNED NO-LABEL
     fiSumDr AT ROW 12.24 COL 45 COLON-ALIGNED NO-LABEL
     fiCntTotCr AT ROW 12.24 COL 111 RIGHT-ALIGNED NO-LABEL
     fiSumCr AT ROW 12.24 COL 110 COLON-ALIGNED NO-LABEL
     fi_startim AT ROW 13.86 COL 45 COLON-ALIGNED
     fi_endtim AT ROW 13.86 COL 71 COLON-ALIGNED
     "Total Cr. :":20 VIEW-AS TEXT
          SIZE 10 BY 1 AT ROW 12.24 COL 93.5
          FONT 6
     "Total Dr. :" VIEW-AS TEXT
          SIZE 10.5 BY 1 AT ROW 12.24 COL 27.5
          FONT 6
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COLUMN 1 ROW 7
         SIZE 131 BY 14.09
         BGCOLOR 8 .

DEFINE FRAME frNext
     btnFirst AT ROW 1.24 COL 2.5
     btnPrev AT ROW 1.24 COL 7.5
     btnNext AT ROW 1.24 COL 12.5
     btnLast AT ROW 1.24 COL 17.5
     buGoto AT ROW 1.24 COL 24
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE 
         AT COLUMN 1.5 ROW 13.3
         SIZE 29 BY 1.52
         BGCOLOR 18 .


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
         TITLE              = "wace1001 - Debit Note & Credit Note Matching"
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
ASSIGN FRAME frDrCr:FRAME = FRAME frMain:HANDLE
       FRAME frMain:FRAME = FRAME DEFAULT-FRAME:HANDLE
       FRAME frNext:FRAME = FRAME frwacm001:HANDLE
       FRAME frOk:FRAME = FRAME frMain:HANDLE
       FRAME frwacm001:FRAME = FRAME frMain:HANDLE.

/* SETTINGS FOR FRAME DEFAULT-FRAME
   FRAME-NAME                                                           */
/* SETTINGS FOR FRAME frDrCr
                                                                        */
/* SETTINGS FOR FRAME frMain
                                                                        */

DEFINE VARIABLE XXTABVALXX AS LOGICAL NO-UNDO.

ASSIGN XXTABVALXX = FRAME frwacm001:MOVE-BEFORE-TAB-ITEM (FRAME frDrCr:HANDLE)
       XXTABVALXX = FRAME frOk:MOVE-BEFORE-TAB-ITEM (FRAME frwacm001:HANDLE)
/* END-ASSIGN-TABS */.

/* SETTINGS FOR FRAME frNext
                                                                        */
/* SETTINGS FOR FRAME frOk
   Custom                                                               */
/* SETTINGS FOR FRAME frwacm001
                                                                        */
/* BROWSE-TAB brwacm001_m TEXT-2 frwacm001 */
/* BROWSE-TAB brwacm001_r brwacm001_m frwacm001 */
ASSIGN 
       brwacm001_m:MAX-DATA-GUESS IN FRAME frwacm001         = 150.

ASSIGN 
       brwacm001_r:MAX-DATA-GUESS IN FRAME frwacm001         = 150.

/* SETTINGS FOR FILL-IN fiCntTotCr IN FRAME frwacm001
   ALIGN-R                                                              */
/* SETTINGS FOR FILL-IN fiCntTotDr IN FRAME frwacm001
   ALIGN-R                                                              */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE brwacm001_m
/* Query rebuild information for BROWSE brwacm001_m
     _START_FREEFORM
OPEN QUERY {&SELF-NAME} FOR EACH wacm001_m NO-LOCK.
     _END_FREEFORM
     _Query            is NOT OPENED
*/  /* BROWSE brwacm001_m */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE brwacm001_r
/* Query rebuild information for BROWSE brwacm001_r
     _START_FREEFORM
OPEN QUERY {&SELF-NAME} FOR EACH wacm001_r NO-LOCK.
     _END_FREEFORM
     _Query            is NOT OPENED
*/  /* BROWSE brwacm001_r */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* wace1001 - Debit Note  Credit Note Matching */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* wace1001 - Debit Note  Credit Note Matching */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME brwacm001_m
&Scoped-define FRAME-NAME frwacm001
&Scoped-define SELF-NAME brwacm001_m
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brwacm001_m C-Win
ON MOUSE-SELECT-CLICK OF brwacm001_m IN FRAME frwacm001 /* Debit Note */
DO:

DEF BUFFER bufwacm001_m FOR wacm001_m. 
DEF BUFFER bufwacm001_m2 FOR wacm001_m.

    FIND FIRST bufwacm001_m WHERE bufwacm001_m.policy = wacm001_m.policy_m NO-ERROR .
    IF AVAIL bufwacm001_m THEN DO:
        nv_polclick = bufwacm001_m.policy.

        /*{wac\wace1002.i} Lukkana M. A55-0243 14/08/2012*/

        /*Lukkana M. A55-0243 14/08/2012*/
        DO WITH FRAME frwacm001:
                /* M */
            FOR EACH wacm001_m USE-INDEX wacm00104_m  
                WHERE wacm001_m.policy_m = nv_polclick :
                IF wacm001_m.disput_m = YES THEN DO:
                    ASSIGN
                        wacm001_m.disput_m = NO
                        nv_cntTotDr        = nv_cntTotDr - 1
                        nv_sumDr           = nv_sumDr -  wacm001_m.bal_m.
                END.
                ELSE DO:
                    ASSIGN
                        wacm001_m.disput_m = YES
                        nv_cntTotDr        = nv_cntTotDr + 1
                        nv_sumDr           = nv_sumDr +  wacm001_m.bal_m .
                END.
            END.
    
            /* R */
            FOR EACH wacm001_r  USE-INDEX wacm00104_r
                WHERE wacm001_r.policy_r = nv_polclick :
                IF wacm001_r.disput_r = YES THEN DO:
                    ASSIGN
                        wacm001_r.disput_r = NO
                        nv_cntTotCr        = nv_cntTotCr - 1
                        nv_sumCr           = nv_sumCr -  wacm001_r.bal_r.
                END.
                ELSE DO:
                    ASSIGN
                        wacm001_r.disput_r = YES
                        nv_cntTotCr        = nv_cntTotCr + 1
                        nv_sumCr           = nv_sumCr +  wacm001_r.bal_r .
                END.
            END.
    
            ASSIGN
                ficntTotDr = nv_cntTotDr
                fisumDr    = nv_sumDr   
                ficntTotCr = nv_cntTotCr
                fisumCr    = nv_sumCr.
    
            DISP ficntTotDr
                 fisumDr
                 ficntTotCr
                 fisumCr .
    
            IF /*(nv_sumDr + nv_sumCr ) <> 0   AND */ (nv_sumDr  = nv_sumCr  *  -1) THEN DO:  /* มีค่าที่จะ match */
                fisumDr:BGCOLOR = 15 .
                fisumCr:BGCOLOR = 15.
    
                nv_chkMatch = YES.
            END.
            ELSE DO:                /* ไม่มีค่าที่จะ match */
                fisumDr:BGCOLOR = 6 .
                fisumCr:BGCOLOR = 6.
    
                nv_chkMatch = NO.
            END.
            
            DISP fisumDr fisumCr.
        END. /* frame frwacm001 */
        
        nv_chkMatch = IF (nv_sumDr = 0)  OR  (nv_sumDr  <> nv_sumCr * -1 ) THEN NO ELSE YES.
        
        IF nv_chkMatch = NO THEN 
            DISABLE buMatch WITH FRAME frDrCr. 
        ELSE 
            ENABLE buMatch WITH FRAME frDrCr.

        /*Lukkana M. A55-0243 14/08/2012*/

        /*-------- DISPLAY DATA หลังจาก mark "*"  ข้อมูลทั้งหมดที่จะ  Update  ----------*/
        RUN pdOpenQ.
        
    END.
 
    FIND FIRST bufwacm001_m2 WHERE bufwacm001_m2.disput = NO NO-ERROR.
    IF AVAIL bufwacm001_m2 THEN DO:   /* ถ้า  ไม่ mark 1 รายการ  แสดงว่า เลือก match ไม่หมด*/
        toMatchAll = FALSE.
        DISP toMatchAll WITH FRAME frwacm001.
    END.
    ELSE DO:                                                /* ถ้าไม่เจอ ที่ เป็น no แสดงว่า match all  */ 
        toMatchAll = TRUE.
        DISP toMatchAll WITH FRAME frwacm001.
    END.
    

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brwacm001_m C-Win
ON MOUSE-SELECT-DBLCLICK OF brwacm001_m IN FRAME frwacm001 /* Debit Note */
DO:

/*          APPLY "CHOOSE" TO buMatch  IN FRAME frDrCr.*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brwacm001_m C-Win
ON VALUE-CHANGED OF brwacm001_m IN FRAME frwacm001 /* Debit Note */
DO:
    
    IF NOT CAN-FIND (FIRST wacm001_m  )THEN DO:
        RETURN NO-APPLY.

        ASSIGN
            s_policy_m  = ""
            s_recno_m   = ""
            s_policy_r  = ""
            s_recno_r   = "".

    END.
    ELSE DO:
        FIND CURRENT wacm001_m NO-LOCK.
        IF AVAIL wacm001_m THEN DO:
          /**/
            FIND FIRST wacm001_r WHERE wacm001_r.policy_r = wacm001_m.policy_m NO-LOCK NO-ERROR.
            IF AVAIL wacm001_r THEN DO:
                REPOSITION brwacm001_r  TO RECID  RECID(wacm001_r).
                brwacm001_r:SELECT-FOCUSED-ROW ().

                RUN pdDispDrCr.

                ASSIGN
                    s_policy_m = wacm001_m.policy_m
                    s_recno_m  = wacm001_m.recno_m
                    s_policy_r = wacm001_r.policy_r
                    s_recno_r  = wacm001_r.recno_r.
            END.
          /**/
        END.
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME brwacm001_r
&Scoped-define SELF-NAME brwacm001_r
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brwacm001_r C-Win
ON VALUE-CHANGED OF brwacm001_r IN FRAME frwacm001 /* Credit Note */
DO:
  
    
    IF NOT CAN-FIND (FIRST wacm001_r  )THEN DO:
        RETURN NO-APPLY.

        ASSIGN
            s_policy_m  = ""
            s_recno_m   = ""
            s_policy_r  = ""
            s_recno_r   = "".

    END.
    ELSE DO:
        FIND CURRENT wacm001_r NO-LOCK.
        IF AVAIL wacm001_r THEN DO:

          /**/
            FIND FIRST wacm001_m WHERE wacm001_m.policy_m = wacm001_r.policy_r NO-LOCK NO-ERROR.
            IF AVAIL wacm001_m THEN DO:
                REPOSITION brwacm001_m  TO RECID  RECID(wacm001_m).
                brwacm001_m:SELECT-FOCUSED-ROW ().

                RUN pdDispDrCr.

                ASSIGN
                    s_policy_m  = wacm001_m.policy_m
                    s_recno_m   = wacm001_m.recno_m
                    s_policy_r  = wacm001_r.policy_r
                    s_recno_r   = wacm001_r.recno_r.
            END.
          /**/
        END.
    END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frNext
&Scoped-define SELF-NAME btnFirst
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnFirst C-Win
ON CHOOSE OF btnFirst IN FRAME frNext /* << */
DO:
  GET FIRST brwacm001_m .

  IF NOT AVAIL wacm001_m THEN RETURN NO-APPLY.  
  REPOSITION  brwacm001_m  TO ROWID ROWID (wacm001_m).
  
  APPLY "VALUE-CHANGED" TO brwacm001_m  IN FRAME frwacm001.

  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnLast
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnLast C-Win
ON CHOOSE OF btnLast IN FRAME frNext /* >> */
DO:

  GET LAST brwacm001_m .

  IF NOT AVAIL wacm001_m THEN RETURN NO-APPLY.  
  REPOSITION  brwacm001_m  TO ROWID ROWID (wacm001_m).
  
  APPLY "VALUE-CHANGED" TO brwacm001_m  IN FRAME frwacm001.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnNext
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnNext C-Win
ON CHOOSE OF btnNext IN FRAME frNext /* > */
DO:

  GET NEXT brwacm001_m .

  IF NOT AVAIL wacm001_m THEN RETURN NO-APPLY.  
  REPOSITION  brwacm001_m  TO ROWID ROWID (wacm001_m).
  
  APPLY "VALUE-CHANGED" TO brwacm001_m  IN FRAME frwacm001.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnPrev
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnPrev C-Win
ON CHOOSE OF btnPrev IN FRAME frNext /* < */
DO:

  GET PREV brwacm001_m .

  IF NOT AVAIL wacm001_m THEN RETURN NO-APPLY.  
  REPOSITION  brwacm001_m  TO ROWID ROWID (wacm001_m).
  
  APPLY "VALUE-CHANGED" TO brwacm001_m  IN FRAME frwacm001.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frOk
&Scoped-define SELF-NAME buAcno1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buAcno1 C-Win
ON CHOOSE OF buAcno1 IN FRAME frOk /* ... */
DO:

    DO WITH FRAME frOK:

        n_chkname = "1". 
        RUN Whp\WhpAcno(INPUT-OUTPUT  n_name,INPUT-OUTPUT n_chkname).
        
        ASSIGN    
            fiacno1 = n_agent1
            finame1 = n_name.
        
        DISP fiacno1 finame1  with Frame {&Frame-Name}      .
         
        n_agent1 =  fiacno1 .
        
        RETURN NO-APPLY.
    
    END.
 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buAcno2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buAcno2 C-Win
ON CHOOSE OF buAcno2 IN FRAME frOk /* ... */
DO:

    DO WITH FRAME frOK:

        n_chkname = "2". 
    
        RUN Whp\WhpAcno(INPUT-OUTPUT  n_name,INPUT-OUTPUT n_chkname).
      
        ASSIGN
            fiacno2 = n_agent2
            finame2 = n_name.
           
        DISP fiacno2 finame2 .
       
        n_agent2 =  fiacno2 .
  
        RETURN NO-APPLY.
        
    END.
 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buAcno3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buAcno3 C-Win
ON CHOOSE OF buAcno3 IN FRAME frOk /* ... */
DO:

    DO WITH FRAME frOK:

        n_chkname = "1". 
        RUN Whp\WhpAcno(INPUT-OUTPUT n_name,INPUT-OUTPUT n_chkname).
        
        ASSIGN    
            fiacno3 = n_agent1.
                 
        DISP fiacno3 with Frame {&Frame-Name}      .                
        RETURN NO-APPLY.    
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buAdd
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buAdd C-Win
ON CHOOSE OF buAdd IN FRAME frOk /* Add */
DO:    
    IF fiacno3 = "" THEN DO:
        MESSAGE "Mandatory Field" VIEW-AS ALERT-BOX.

        APPLY "Entry" TO fiacno3.
        RETURN NO-APPLY.
    END.
    ELSE IF INDEX(fiacno3,",") > 0 THEN DO:
        MESSAGE "Data False!" SKIP
                "มี Comma ในข้อมูล" VIEW-AS ALERT-BOX ERROR.

        APPLY "Entry" TO fiacno3.
        RETURN NO-APPLY.
    END.

    ASSIGN seAcno.
    seAcno:ADD-FIRST(fiacno3).
    seAcno = seAcno:SCREEN-VALUE.
    n_acno = seAcno:LIST-ITEMS.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buDel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buDel C-Win
ON CHOOSE OF buDel IN FRAME frOk /* Del */
DO:
    ASSIGN seAcno.
    seAcno:DELETE(seAcno).
    seAcno = seAcno:SCREEN-VALUE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buExit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buExit C-Win
ON CHOOSE OF buExit IN FRAME frOk /* Exit */
DO:
  
  APPLY "CLOSE" TO THIS-PROCEDURE.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frNext
&Scoped-define SELF-NAME buGoto
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buGoto C-Win
ON CHOOSE OF buGoto IN FRAME frNext
DO:

    MESSAGE "กรุณาป้อน Policy No. ที่ต้องการค้นหา  :  " UPDATE nv_polno FORMAT "X(16)". 
    
    FIND FIRST wacm001_m WHERE wacm001_m.policy_m = nv_polno NO-LOCK NO-ERROR.
    IF NOT AVAIL wacm001_m THEN DO:
        MESSAGE "Policy No. " + STRING(CAPS(nv_polno),nv_fPolno) + " Not Found !" VIEW-AS ALERT-BOX ERROR.
        RETURN NO-APPLY.
    END.
    ELSE DO:
        REPOSITION  brwacm001_m  TO ROWID ROWID (wacm001_m).
        APPLY "VALUE-CHANGED" TO brwacm001_m  IN FRAME frwacm001.
    END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frDrCr
&Scoped-define SELF-NAME buMatch
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buMatch C-Win
ON CHOOSE OF buMatch IN FRAME frDrCr /* Match Detail */
DO:

    n_chkmatch = NO.

    RUN wac\wace1002 (INPUT-OUTPUT n_chkmatch).
    

        /* confirm match = yes  */
    IF n_chkmatch THEN DO:  

        OPEN QUERY brwacm001_m 
            FOR EACH wacm001_m  WHERE wacm001_m.disput_m = NO
                NO-LOCK BY wacm001_m.policy_m  BY wacm001_m.recno_m.
        OPEN QUERY brwacm001_r   
            FOR EACH wacm001_r WHERE wacm001_r.disput_r = NO 
                NO-LOCK BY wacm001_r.policy_r BY wacm001_r.recno_r.
        
        RUN pdInitDataDrCr.  /* Clear datat ใน field in frame frDrCr */

    END.  /* n_chkmatch = YES */

  
END.


/****************
        IF CAN-FIND (FIRST wacm001_m  )THEN DO:
            OPEN QUERY brwacm001_m 
                FOR EACH wacm001_m  WHERE wacm001_m.disput = NO
                                                            NO-LOCK BY wacm001_m.policy  BY wacm001_m.recno.
        END.
        
        IF CAN-FIND (FIRST wacm001_r  )THEN DO:
            OPEN QUERY brwacm001_r   
                FOR EACH wacm001_r WHERE wacm001_r.disput = NO 
                                                        NO-LOCK BY wacm001_r.policy BY wacm001_r.recno.
        END.
*******************/

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frOk
&Scoped-define SELF-NAME buReset
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buReset C-Win
ON CHOOSE OF buReset IN FRAME frOk /* Reset */
DO:
  
    RUN pdReset.

  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buSearch
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buSearch C-Win
ON CHOOSE OF buSearch IN FRAME frOk /* Search */
DO:
    fi_startim = STRING(time,"HH:MM:SS").

    DISP fi_startim WITH FRAME frwacm001.

    DO WITH FRAME {&FRAME-NAME} :
        ASSIGN  
            FRAME frOK fiacno1 fiacno1
            FRAME frOK fiacno2 fiacno2
            FRAME frOK fipolfr   fipolfr
            FRAME frOK fipolto  fipolto
            FRAME frOK fitrndatfr   fitrndatfr
            FRAME frOK fitrndatto   fitrndatto
            
            nv_acno1 = fiacno1
            nv_acno2 = IF fiacno2 = "" THEN "Z" ELSE fiacno2
            nv_polfr = fipolfr
            nv_polto = IF fipolto = "" THEN "Z" ELSE fipolto
            nv_trndatfr  = fitrndatfr
            nv_trndatto = fitrndatto .

        ASSIGN
            s_policy_m  = ""
            s_recno_m   = ""
            s_policy_r  = ""
            s_recno_r   = "".
    END.

    IF ( nv_acno1 > nv_acno2)   THEN DO:
          MESSAGE "ข้อมูลตัวแทนผิดพลาด" SKIP
                  "รหัสตัวแทนเริ่มต้นต้องน้อยกว่ารหัสสุดท้าย" VIEW-AS ALERT-BOX WARNING . 
          APPLY  "ENTRY" TO fiacno1.
          RETURN NO-APPLY.
    END.
    IF ( nv_polfr > nv_polto)   THEN DO:
          MESSAGE "ข้อมูลกรมธรรม์ผิดพลาด" SKIP
                  "กรมธรรม์เริ่มต้นต้องน้อยกว่ากรมธรรม์สุดท้าย" VIEW-AS ALERT-BOX WARNING . 
          APPLY  "ENTRY" TO fipolfr.
          RETURN NO-APPLY.
    END.
    IF ( nv_trndatfr > nv_trndatto)   THEN DO:
          MESSAGE "วันที่ผิดพลาด" SKIP
                  "วันที่เริ่มต้นต้องน้อยกว่าวันที่สุดท้าย" VIEW-AS ALERT-BOX WARNING . 
          APPLY  "ENTRY" TO fitrndatfr.
          RETURN NO-APPLY.
    END.

    MESSAGE  "ตัวแทน/นายหน้า  : "  nv_acno1 "  -  " nv_acno2  SKIP(1)
             "กรมธรรม์              : " STRING(nv_polfr,nv_fpolno)  "  -  "  STRING(nv_polto,nv_fpolno)    SKIP(1)
             "ข้อมูลตั้งแต่วันที่    : " STRING(nv_trndatfr,"99/99/9999")  "  -  "  
                                        STRING(nv_trndatto,"99/99/9999") SKIP(1)
    VIEW-AS ALERT-BOX QUESTION
    BUTTONS YES-NO
    TITLE "Confirm"    UPDATE CHOICE AS LOGICAL.
    CASE CHOICE:
    WHEN TRUE THEN    DO:
            /*RUN pdSearch. Lukkana M. A53-0395 05/01/2011*/
            RUN pdSearch1.  /*Lukkana M. A53-0395 05/01/2011*/
    END.
    WHEN FALSE THEN    DO:
            RETURN NO-APPLY.
    END.
    END CASE.

    fi_endtim = STRING(time,"HH:MM:SS").

    DISP fi_endtim WITH FRAME frwacm001.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiacno1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiacno1 C-Win
ON LEAVE OF fiacno1 IN FRAME frOk
DO:
    /*--- nok ---

    DO WITH FRAME frOK:

        ASSIGN
            fiacno1 = CAPS(INPUT fiacno1)
            n_agent1  = fiacno1.
        
        DISP fiacno1.
                
        IF fiAcno1 <> "" Then Do :        
            FIND   xmm600 WHERE xmm600.acno = n_agent1  NO-ERROR.
            IF AVAILABLE xmm600 THEN DO:
                  finame1:Screen-value IN FRAME {&FRAME-NAME} = xmm600.name.
            END.        
            ELSE DO:
                  fiAcno1 = "".
                  finame1:Screen-value IN FRAME {&FRAME-NAME} = "Not Found !".
                  MESSAGE "ไม่พบข้อมูล" VIEW-AS ALERT-BOX  WARNING TITLE "Confirm" .
            END.
        End.    

        ASSIGN
            fiacno1 = CAPS(fiacno1)
            fiAcno2 = fiAcno1.

        DISP fiAcno1 fiAcno2.
   
    END.
    -----*/
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiacno1 C-Win
ON RETURN OF fiacno1 IN FRAME frOk
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
ON LEAVE OF fiacno2 IN FRAME frOk
DO:

    /*--- A500178 ---
    DO WITH FRAME frOK:

        ASSIGN
            fiacno2 = CAPS(INPUT fiacno2)
            n_agent2  = fiacno2.
    
        DISP fiacno2 .        
            
        IF fiAcno2 <> "" Then Do :        
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
        
        fiacno2 = CAPS(fiacno2).
        DISP fiAcno2 .

    END.
    ------*/

    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiacno2 C-Win
ON RETURN OF fiacno2 IN FRAME frOk
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


&Scoped-define SELF-NAME fiacno3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiacno3 C-Win
ON LEAVE OF fiacno3 IN FRAME frOk
DO:
    fiacno3 = INPUT fiacno3.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiacno3 C-Win
ON RETURN OF fiacno3 IN FRAME frOk
DO:
    APPLY "Entry" TO buAdd.
    RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frDrCr
&Scoped-define SELF-NAME fiLatdat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiLatdat C-Win
ON LEAVE OF fiLatdat IN FRAME frDrCr
DO:

    fiLatdat = INPUT fiLatdat.
    
    s_latdat = fiLatdat.
    
    IF s_latdat > TODAY THEN DO:
        MESSAGE "AC | Contra date  ต้องน้อยกว่าหรือเท่ากันวันที่ปัจจุบัน !"  VIEW-AS ALERT-BOX ERROR.
        APPLY "ENTRY" TO fiLatdat.
        RETURN NO-APPLY.
    END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frOk
&Scoped-define SELF-NAME fiPolfr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiPolfr C-Win
ON LEAVE OF fiPolfr IN FRAME frOk
DO:

    DO WITH FRAM frOK:
        ASSIGN
           fiPolfr = CAPS(INPUT  fiPolfr)
           nv_polfr = fiPolfr
           fiPolTo = nv_polfr.
  
        DISP    fiPolFr    fiPolTo.
    END.
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiPolTo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiPolTo C-Win
ON LEAVE OF fiPolTo IN FRAME frOk
DO:

    DO WITH FRAM frOK:
        ASSIGN
           fiPolto    =  CAPS(INPUT  fiPolto)
           nv_polto = fiPolto.

        DISP fiPolTo.
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiTrnDatFr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiTrnDatFr C-Win
ON LEAVE OF fiTrnDatFr IN FRAME frOk
DO:
  fiTrndatFr = INPUT fiTrndatFr.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiTrnDatTo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiTrnDatTo C-Win
ON LEAVE OF fiTrnDatTo IN FRAME frOk
DO:
    fiTrndatTo = INPUT fiTrndatTo.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frwacm001
&Scoped-define SELF-NAME toMatchAll
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL toMatchAll C-Win
ON VALUE-CHANGED OF toMatchAll IN FRAME frwacm001 /* Match All */
DO:
    ASSIGN
        nv_cntTotDr = 0 
        nv_sumDr    = 0 
        nv_cntTotCr = 0 
        nv_sumCr    = 0 
        .

    ASSIGN
        toMatchAll = INPUT toMatchAll.

DO WITH FRAME frwacm001:
   
    IF toMatchAll = YES THEN DO:
        /* mark ค่า ที่จะตัด */
        FOR EACH wacm001_m WHERE wacm001_m.disput_m = NO  :
            ASSIGN
                wacm001_m.disput_m = YES
                nv_cntTotDr        = nv_cntTotDr + 1
                nv_sumDr           = nv_sumDr +  wacm001_m.bal_m .
        END.
        FOR EACH wacm001_r WHERE wacm001_r.disput_r = NO :
            ASSIGN
                wacm001_r.disput_r = YES
                nv_cntTotCr        = nv_cntTotCr + 1
                nv_sumCr           = nv_sumCr +  wacm001_r.bal_r.
        END.

    END.
    ELSE DO:
        /* clear ค่า ที่ mark ไว้ */
        FOR EACH wacm001_m WHERE wacm001_m.disput_m = YES  :
            ASSIGN
                wacm001_m.disput_m = NO
                nv_cntTotDr        = 0
                nv_sumDr           = 0 .
        END.
        FOR EACH wacm001_r WHERE wacm001_r.disput_r = YES :
            ASSIGN
                wacm001_r.disput_r = NO
                nv_cntTotCr        = 0
                nv_sumCr           = 0  .
        END.

    END.  /* IF toMatchAll = YES */

/*-------- DISPLAY DATA หลังจาก mark "*"  ข้อมูลทั้งหมดที่จะ  Update  ----------*/

        RUN pdOpenQ.
/*
        DISP
            nv_cntTotDr @ ficntTotDr
            nv_sumDr   @ fisumDr
            nv_cntTotCr @ ficntTotCr
            nv_sumCr   @ fisumCr
            .

        IF (nv_sumDr + nv_sumCr ) <> 0 THEN DO:
            fisumDr:BGCOLOR = 6 .
            fisumCr:BGCOLOR = 6.
        END.
        ELSE DO:
            fisumDr:BGCOLOR = 15 .
            fisumCr:BGCOLOR = 15.
        END.
*/       


        ASSIGN
            ficntTotDr = nv_cntTotDr
            fisumDr    = nv_sumDr   
            ficntTotCr = nv_cntTotCr
            fisumCr    = nv_sumCr.


        DISP
            ficntTotDr
            fisumDr
            ficntTotCr
            fisumCr
            .

        IF /*(nv_sumDr + nv_sumCr ) <> 0   AND */ (nv_sumDr  = nv_sumCr  *  -1) THEN DO:  /* มีค่าที่จะ match */
            fisumDr:BGCOLOR = 15 .
            fisumCr:BGCOLOR = 15.

            nv_chkMatch = YES.
        END.
        ELSE DO:                /* ไม่มี*/
            fisumDr:BGCOLOR = 6 .
            fisumCr:BGCOLOR = 6.

            nv_chkMatch = NO.
        END.
        
        DISP fisumDr fisumCr.
        
END. /* frame frwacm001 */

    nv_chkMatch = IF (nv_sumDr = 0)  OR  (nv_sumDr  <> nv_sumCr * -1 ) THEN NO ELSE YES.

        IF nv_chkMatch = NO THEN 
            DISABLE buMatch WITH FRAME frDrCr. 
        ELSE 
            ENABLE buMatch WITH FRAME frDrCr.


/*--------------*/

/*END.  /* DO WITH FRAME fiwacm001 */*/




END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define BROWSE-NAME brwacm001_m
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
  
  gv_prgid = "wace1001".
  gv_prog  = "Debit Note & Credit Note Matching".
  RUN  WUT\WUTHEAD (c-win:handle,gv_prgid,gv_prog).
  RUN  wut\wutdicen (c-win:HANDLE).

/*********************************************************************/

    SESSION:DATA-ENTRY-RETURN = YES.
 
    reOk1:MOVE-TO-TOP().
    reOk2:MOVE-TO-TOP().
    reButton:MOVE-TO-TOP().
    reCanAcno:MOVE-TO-TOP(). /* add by Phaiboon W. [A59-0233] 13/06/2016 */

    DO WITH FRAME frOK :
        ASSIGN
             fiacno1 = "A000000"
             fiacno2 = "BZZZZZZZZZ"
             fipolfr = ""
             fipolto = "Z"
             fitrndatFr = TODAY
             fitrndatTo = TODAY.

        DISP fiacno1  fiacno2 fipolfr fipolto fitrndatFr fitrndatTo.

    APPLY "ENTRY" TO fiacno1.
  
    END.

    DO WITH FRAME frDrCr:
        ASSIGN
            filatdat = TODAY
            s_latdat = filatdat.

        DISP  filatdat.
    END.

    DISABLE ALL WITH FRAME frNext.
    DISABLE ALL WITH FRAME frwacm001.
    
    RUN pdInitDataDrCr.
  
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
  ENABLE IMAGE-24 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  DISPLAY fiacno3 seAcno fiacno1 fiacno2 fiPolfr fiPolTo fiTrnDatFr fiTrnDatTo 
          finame1 finame2 
      WITH FRAME frOk IN WINDOW C-Win.
  ENABLE buAdd fiacno3 seAcno buExit fiacno1 fiacno2 fiPolfr fiPolTo fiTrnDatFr 
         fiTrnDatTo buSearch buReset buAcno1 buAcno2 finame1 finame2 buAcno3 
         buDel reOK1 reOk2 reButton reCanAcno 
      WITH FRAME frOk IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-frOk}
  VIEW FRAME frMain IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-frMain}
  DISPLAY toMatchAll fiCntTotDr fiSumDr fiCntTotCr fiSumCr fi_startim fi_endtim 
      WITH FRAME frwacm001 IN WINDOW C-Win.
  ENABLE brwacm001_m brwacm001_r toMatchAll fiCntTotDr fiSumDr fiCntTotCr 
         fiSumCr fi_startim fi_endtim 
      WITH FRAME frwacm001 IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-frwacm001}
  ENABLE btnFirst btnPrev btnNext btnLast buGoto 
      WITH FRAME frNext IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-frNext}
  DISPLAY fiLatdat fiPrem_M fiStamp_M fiTax_M fiComm_M fiBaloc_M fiPrem_R 
          fiStamp_R fiTax_R fiComm_R fiBaloc_R 
      WITH FRAME frDrCr IN WINDOW C-Win.
  ENABLE RECT-2 fiLatdat buMatch fiPrem_M fiStamp_M fiTax_M fiComm_M fiBaloc_M 
         fiPrem_R fiStamp_R fiTax_R fiComm_R fiBaloc_R 
      WITH FRAME frDrCr IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-frDrCr}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdDispDrCr C-Win 
PROCEDURE pdDispDrCr :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    DO WITH FRAME frDrCr :

        FIND CURRENT wacm001_m.
        DISP
            wacm001_m.prem_m  @ fiPrem_m
            wacm001_m.stamp_m @ fistamp_m
            wacm001_m.tax_m   @ fitax_m
            wacm001_m.comm_m  @ ficomm_m
            wacm001_m.baloc_m @ fibaloc_m.
            
        FIND CURRENT wacm001_r.
        DISP
            wacm001_r.prem_r  @ fiPrem_r
            wacm001_r.stamp_r @ fistamp_r
            wacm001_r.tax_r   @ fitax_r
            wacm001_r.comm_r  @ ficomm_r
            wacm001_r.baloc_r @ fibaloc_r.
    END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdInitDataDrCr C-Win 
PROCEDURE pdInitDataDrCr :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
    DO WITH FRAME frDrCr :
        DISP
            0  @ fiPrem_m
            0  @ fistamp_m
            0  @ fitax_m
            0  @ ficomm_m
            0  @ fibaloc_m.

        DISP
            0  @ fiPrem_r
            0  @ fistamp_r
            0  @ fitax_r
            0  @ ficomm_r
            0  @ fibaloc_r.
            
        nv_chkMatch = NO.
        
        IF nv_chkMatch = NO THEN 
            DISABLE buMatch. 
        ELSE 
            ENABLE buMatch.

    END.
    
    DO WITH FRAME frwacm001:
        ASSIGN    
            toMatchAll = NO
            fiCntTotDr = 0
            fiCntTotCr = 0
            fiSumDr    = 0
            fiSumCr    = 0
            .

        DISP toMatchAll 
             fiCntTotDr fiCntTotCr
             fiSumDr   fiSumCr .
    END.

    DO WITH FRAME frOK:
        ASSIGN 
            n_acno  = ""
            fiacno3 = "".

        seAcno:LIST-ITEMS = "".
        seAcno = seAcno:SCREEN-VALUE.
                                                
        DISP fiacno3.
    END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdOpenQ C-Win 
PROCEDURE pdOpenQ :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    OPEN QUERY brwacm001_m 
         FOR EACH wacm001_m BY wacm001_m.policy_m  BY wacm001_m.recno_m .

    OPEN QUERY brwacm001_r 
         FOR EACH wacm001_r  BY wacm001_r.policy_r  BY wacm001_r.recno_r.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdReset C-Win 
PROCEDURE pdReset :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    FOR EACH wacm001_m :   DELETE wacm001_m. END.
    FOR EACH wacm001_r :     DELETE wacm001_r.  END.

    FOR EACH acm001_m :   DELETE acm001_m.  END. /*Lukkana M. A53-0395 05/01/2011*/
    
    OPEN QUERY brwacm001_m FOR EACH wacm001_m  NO-LOCK.
    OPEN QUERY brwacm001_r FOR EACH wacm001_r  NO-LOCK.

    RUN pdInitDataDrCr.  /* Clear datat ใน field in frame frDrCr */

    ENABLE ALL WITH FRAME frOK.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdSearch C-Win 
PROCEDURE pdSearch :
/*-----------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
-----------------------------------------------------*/
/*--
DEF VAR nv_chkwacm001_m  AS LOGIC.
DEF VAR nv_chkwacm001_r  AS LOGIC.

FOR EACH wacm001_m :   DELETE wacm001_m. END.
FOR EACH wacm001_r :   DELETE wacm001_r.  END.

    FOR  EACH acm001 USE-INDEX acm00103  
         WHERE (acm001.acno    >= nv_acno1    AND acm001.acno   <= nv_acno2) AND
                acm001.curcod   = "BHT"       AND 
               (acm001.trndat  >= nv_trndatfr AND acm001.trndat <= nv_trndatto ) AND
                acm001.trnty1   = "M"         AND 
                acm001.bal     <> 0           AND 
               (acm001.policy  >= nv_polfr    AND acm001.policy <= nv_polto )  ,

        FIRST bufacm001 USE-INDEX acm00104
              WHERE  bufacm001.policy   =  acm001.policy      AND
                     bufacm001.recno   <>  " "                AND
                     bufacm001.acno     =  acm001.acno        AND    /* ตัดเบี้ย ต้อง acno code เดียวกัน เท่านั้น*/
                    (bufacm001.trndat  >=  nv_trndatfr        AND  bufacm001.trndat <= nv_trndatto ) AND   /* อยุ๋ในช่วง trndat ที่เรียกด้วย  A47-0999 */
                     bufacm001.trnty1   =  "R"                AND
                     bufacm001.prem     =  acm001.prem   * -1 AND
                     bufacm001.comm     =  acm001.comm   * -1 AND
                     bufacm001.tax      =  acm001.tax    * -1 AND
                     bufacm001.stamp    =  acm001.stamp  * -1 AND
                     bufacm001.netamt   =  acm001.netamt * -1 AND
                     bufacm001.bal      =  acm001.bal    * -1
        NO-LOCK BREAK BY  acm001.acno.

        DISP acm001.acno FORMAT "X(10)"
             acm001.policy
             acm001.recno
             acm001.trnty1
             acm001.docno
        WITH COLOR BLACK/WHITE NO-LABEL FRAME frProcess VIEW-AS DIALOG-BOX
        TITLE  "  Processing ...".

    /**** นำเบี้ย + เข้า temp-table  wacm001_m  ****/
        FIND FIRST wacm001_m USE-INDEX acm00101
             WHERE wacm001_m.trnty1 = acm001.trnty1 AND
                   wacm001_m.docno  = acm001.docno  NO-ERROR. 
        IF NOT AVAIL wacm001_m THEN DO:
            
            CREATE wacm001_m.
            /*  wacmat01.i                 {1}                  {2} */
            {wac\wace1001.i  wacm001_m   acm001 }
            
            nv_chkwacm001_m = YES.
            
        END.

    /**** นำเบี้ย -  เข้า temp-table  wacm001_r  ****/
        FIND FIRST wacm001_r USE-INDEX acm00101
             WHERE wacm001_r.trnty1 = bufacm001.trnty1 AND
                   wacm001_r.docno = bufacm001.docno NO-ERROR.
        IF NOT AVAIL wacm001_r THEN DO:
            CREATE wacm001_r.
            /*  wacmat01.i                 {1}                  {2} */
            {wac\wace1001.i  wacm001_r   bufacm001 }
            
            nv_chkwacm001_r = YES.
        END.
                                   
    END.   

    /*** มี data ถึงจะ open query  ใน browse เฉพาะ record ที่ disput = NO   เพื่อ check ดึง ตาม query  ที่ยังไม่เคย match ***/
    IF nv_chkwacm001_m THEN DO:
        OPEN QUERY brwacm001_m 
            FOR EACH wacm001_m  WHERE wacm001_m.disput = NO
                NO-LOCK BY wacm001_m.policy  BY wacm001_m.recno.
    END.

    IF nv_chkwacm001_r THEN DO:    
        OPEN QUERY brwacm001_r   
            FOR EACH wacm001_r WHERE wacm001_r.disput = NO 
                NO-LOCK BY wacm001_r.policy BY wacm001_r.recno.
    END.


    IF nv_chkwacm001_m AND nv_chkwacm001_r THEN DO:
        DISABLE ALL EXCEPT buSearch buReset buExit  WITH FRAME frOK.
        ENABLE ALL WITH FRAME frNext.
        ENABLE ALL WITH FRAME frwacm001.
        
    END.
    ELSE DO:
    
        MESSAGE "ไม่พบข้อมูล  ตามเงื่อนไขที่ค้นหา "  VIEW-AS ALERT-BOX  WARNING.
        RETURN NO-APPLY.

        DISABLE ALL WITH FRAME frNext.
        DISABLE ALL WITH FRAME frwacm001.
    END.
*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdSearch1 C-Win 
PROCEDURE pdSearch1 :
/*-----------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: 
  Copy จาก PDSearch มาตั้งเป็นชื่อใหม่  Lukkana M. A53-0395 05/01/2011      
-----------------------------------------------------*/
DEF VAR nv_chkwacm001_m  AS LOGIC.
DEF VAR nv_chkwacm001_r  AS LOGIC.
DEF VAR frm_acno LIKE acm001.acno.
DEF VAR TO_acno LIKE acm001.acno.
DEF VAR nv_acno LIKE acm001.acno.
            
FOR EACH wacm001_m :   DELETE wacm001_m. END.
FOR EACH wacm001_r :   DELETE wacm001_r. END.
FOR EACH acm001_m :   DELETE acm001_m.  END. /*Lukkana M. A53-0395 05/01/2011*/
frm_acno = nv_acno1.
TO_acno  = nv_acno2.
FIND FIRST acm001 NO-LOCK WHERE acm001.acno >= frm_acno AND acm001.acno <= TO_acno NO-ERROR.
IF AVAILABLE acm001 THEN
    nv_acno = acm001.acno.
ELSE
    nv_acno = "ZZZZZZZZZZ".

DO WHILE nv_acno <> "ZZZZZZZZZZ".
    DISP "Loop" nv_acno WITH OVERLAY CENTER.
    RUN PDsearchNeg      (INPUT nv_acno).
    RUN PDsearchPositive (INPUT nv_acno).                    
    frm_acno = nv_acno + "ZZZZZZZZZZZZZZZ".
    
    FIND FIRST acm001 NO-LOCK WHERE acm001.acno > frm_acno AND acm001.acno < TO_acno NO-ERROR.
    IF AVAILABLE acm001 then
        nv_acno = acm001.acno.
    ELSE
        nv_acno = "ZZZZZZZZZZ".

END.

    
    /*----- Lukkana M. A53-0395 05/01/2011 ----*/
    FOR  EACH acm001_m NO-LOCK .
        /*BREAK BY  acm001_m.acno
              BY  acm001_m.agent    
              BY  acm001_m.policy. Lukkana M. A55-0243 09/08/2012 */ 
                                
        DISP acm001_m.acno_m1 FORMAT "X(10)"
             acm001_m.policy_m1
             acm001_m.recno_m1
             acm001_m.trnty1_m1
             acm001_m.docno_m1
        WITH COLOR BLACK/WHITE NO-LABEL FRAME frProcess1 VIEW-AS DIALOG-BOX
        TITLE  "  Processing ...".
    
    /**** นำเบี้ย + เข้า temp-table  wacm001_m  ****/
        FIND FIRST wacm001_m USE-INDEX wacm00101_m
             WHERE wacm001_m.trnty1_m = acm001_m.trnty1_m1 AND
                   wacm001_m.docno_m  = acm001_m.docno_m1  NO-ERROR. 
        IF NOT AVAIL wacm001_m THEN DO:

            CREATE wacm001_m.
            /*  wacmat01.i                 {1}                  {2} */
            /*{wac\wace1001.i  wacm001_m   acm001_m } Lukkana M. A55-0243 14/08/2012*/
            RUN pd_create. /*Lukkana M. A55-0243 14/08/2012*/
            
            nv_chkwacm001_m = YES.
        END.
    END. /* for each acm001_m*/    
    /*---Lukkana M. A53-0395 05/01/2011------*/

    /*** มี data ถึงจะ open query  ใน browse เฉพาะ record ที่ disput = NO   เพื่อ check ดึง ตาม query  ที่ยังไม่เคย match ***/
    FIND FIRST wacm001_m NO-ERROR.
    IF AVAILABLE wacm001_m THEN
        nv_chkwacm001_m = YES.
    
    IF nv_chkwacm001_m THEN DO:
        OPEN QUERY brwacm001_m 
            FOR EACH wacm001_m  WHERE wacm001_m.disput_m = NO
                NO-LOCK BY wacm001_m.policy_m  BY wacm001_m.recno_m.
    END.
    FIND FIRST wacm001_r NO-ERROR.
    IF AVAILABLE wacm001_r THEN
        nv_chkwacm001_r = YES.

    IF nv_chkwacm001_r THEN DO:    
        OPEN QUERY brwacm001_r   
            FOR EACH wacm001_r WHERE wacm001_r.disput_r = NO 
                NO-LOCK BY wacm001_r.policy_r BY wacm001_r.recno_r.
    END.

    IF nv_chkwacm001_m AND nv_chkwacm001_r THEN DO:
        DISABLE ALL EXCEPT buSearch buReset buExit  WITH FRAME frOK.
        ENABLE ALL WITH FRAME frNext.
        ENABLE ALL WITH FRAME frwacm001.
    END.
    ELSE DO:
        MESSAGE "ไม่พบข้อมูล  ตามเงื่อนไขที่ค้นหา "  VIEW-AS ALERT-BOX  WARNING.
        RETURN NO-APPLY.
        DISABLE ALL WITH FRAME frNext.
        DISABLE ALL WITH FRAME frwacm001.
    END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDsearchNeg C-Win 
PROCEDURE PDsearchNeg :
/*------------------------------------------------------------------------------
  Purpose:     A61-0151
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF INPUT PARAMETER nv_acno AS CHAR FORMAT "x(10)".
FOR  EACH acm001 USE-INDEX acm00122 NO-LOCK 
         WHERE  acm001.acno    = nv_acno  AND
                acm001.baloc   < 0 AND
                acm001.curcod   = "BHT"       AND 
               (acm001.trndat  >= nv_trndatfr AND acm001.trndat <= nv_trndatto ) AND
                acm001.trnty1   = "M"         AND 
/*                 acm001.bal     <> 0           AND */
               (acm001.policy  >= nv_polfr    AND acm001.policy <= nv_polto )  ,
        
        FIRST bufacm001 USE-INDEX acm00104
              WHERE  bufacm001.policy   =  acm001.policy      AND
                     bufacm001.recno   <>  " "                AND
                     bufacm001.acno     =  acm001.acno        AND    /* ตัดเบี้ย ต้อง acno code เดียวกัน เท่านั้น*/
                    (bufacm001.trndat  >=  nv_trndatfr        AND  bufacm001.trndat <= nv_trndatto ) AND   /* อยุ๋ในช่วง trndat ที่เรียกด้วย  A47-0999 */
                     bufacm001.trnty1   =  "R"                AND
                     bufacm001.prem     =  acm001.prem   * -1 AND
                     bufacm001.comm     =  acm001.comm   * -1 AND
                     bufacm001.tax      =  acm001.tax    * -1 AND
                     bufacm001.stamp    =  acm001.stamp  * -1 AND
                     bufacm001.netamt   =  acm001.netamt * -1 AND
                     bufacm001.bal      =  acm001.bal    * -1
        NO-LOCK BREAK BY  acm001.acno 
                      BY  acm001.recno.

        DISP acm001.acno FORMAT "X(10)"
             acm001.policy
             acm001.recno
             acm001.trnty1
             acm001.docno
        WITH COLOR BLACK/WHITE NO-LABEL FRAME frProcess VIEW-AS DIALOG-BOX
        TITLE  "  Processing ...".         

        /*IF LOOKUP(acm001.agent,n_acno) <> 0 THEN NEXT. /* add by Phaiboon W. [A59-0233] */ Chonlatisj. A60-0419 03/11/2017*/
        IF LOOKUP(acm001.acno,n_acno) <> 0 THEN NEXT. /*Add by Chonlatisj. A60-0419 03/11/2017*/

    /*----- Lukkana M. A53-0395 05/01/2011
    /**** นำเบี้ย + เข้า temp-table  wacm001_m  ****/
        FIND FIRST wacm001_m USE-INDEX acm00101
             WHERE wacm001_m.trnty1 = acm001.trnty1 AND
                   wacm001_m.docno  = acm001.docno  NO-ERROR. 
        IF NOT AVAIL wacm001_m THEN DO:

            MESSAGE acm001.policy acm001.trnty1 acm001.trnty2 acm001.agent SKIP
                    wacm001_m.trnty1 wacm001_m.trnty2 wacm001_m.agent.
            CREATE wacm001_m.
            /*  wacmat01.i                 {1}                  {2} */
            {wac\wace1001.i  wacm001_m   acm001 }
            
            nv_chkwacm001_m = YES.

            END.
        END.

        /**** นำเบี้ย -  เข้า temp-table  wacm001_r  ****/
        FIND FIRST wacm001_r USE-INDEX acm00101
             WHERE wacm001_r.trnty1 = bufacm001.trnty1 AND
                   wacm001_r.docno = bufacm001.docno NO-ERROR.
        IF NOT AVAIL wacm001_r THEN DO:
            CREATE wacm001_r.
            /*  wacmat01.i                 {1}                  {2} */
            {wac\wace1001.i  wacm001_r   bufacm001 }
            
            nv_chkwacm001_r = YES.
        END.
        Lukkana M. A53-0395 05/01/2011------*/

        /*---Lukkana M. A53-0395 05/01/2011------*/
        FIND FIRST acm001_m USE-INDEX acm00104_m 
             WHERE acm001_m.policy_m1  = acm001.policy NO-ERROR.
        IF NOT AVAIL acm001_m THEN DO:
            IF bufacm001.agent = acm001.agent THEN DO: /*เอาเฉพาะ agent code เดียวกัน*/
              
                CREATE acm001_m.
                ASSIGN
                    acm001_m.policy_m1  = acm001.policy
                    acm001_m.recno_m1   = acm001.recno
                    acm001_m.trnty1_m1  = acm001.trnty1
                    acm001_m.trnty2_m1  = acm001.trnty2
                    acm001_m.docno_m1   = acm001.docno
                    acm001_m.baloc_m1   = acm001.baloc
                                             
                    acm001_m.prem_m1    = acm001.prem
                    acm001_m.comm_m1    = acm001.comm
                    acm001_m.stamp_m1   = acm001.stamp
                    acm001_m.tax_m1     = acm001.tax
                    acm001_m.fee_m1     = acm001.fee
                    acm001_m.netamt_m1  = acm001.netamt
                    acm001_m.bal_m1     = acm001.bal
                    acm001_m.trndat_m1  = acm001.trndat
                    acm001_m.ref_m1     = acm001.ref
                    acm001_m.comdat_m1  = acm001.comdat
                    acm001_m.acno_m1    = acm001.acno
                    acm001_m.agent_m1   = acm001.agent
                                             
                    acm001_m.curcod_m1  = acm001.curcod
                    acm001_m.branch_m1  = acm001.branch
                    acm001_m.netloc_m1  = acm001.netloc
                    acm001_m.poltyp_m1  = acm001.poltyp
                    acm001_m.branch_m1  = acm001.branch
                    acm001_m.vehreg_m1  = acm001.vehreg
                    acm001_m.insno_m1   = acm001.insno
                    acm001_m.instot_m1  = acm001.instot
                    acm001_m.dociln_m1  = acm001.dociln.
            
                /**** นำเบี้ย -  เข้า temp-table  wacm001_r  ****/
                FIND FIRST wacm001_r USE-INDEX wacm00101_r
                     WHERE wacm001_r.trnty1 = bufacm001.trnty1 AND
                           wacm001_r.docno = bufacm001.docno NO-ERROR.
                IF NOT AVAIL wacm001_r THEN DO:
                    CREATE wacm001_r.
                    /*  wacmat01.i                 {1}                  {2} */
                    /*{wac\wace1001.i  wacm001_r   bufacm001 } Lukkana M. A55-0243 14/08/2012*/
                    /*Lukkana M. A55-0243 14/08/2012*/
                    
                    ASSIGN
                        wacm001_r.policy_r  = bufacm001.policy
                        wacm001_r.recno_r   = bufacm001.recno
                        wacm001_r.trnty1_r  = bufacm001.trnty1
                        wacm001_r.trnty2_r  = bufacm001.trnty2
                        wacm001_r.docno_r   = bufacm001.docno
                        wacm001_r.baloc_r   = bufacm001.baloc
                                          
                        wacm001_r.prem_r    = bufacm001.prem
                        wacm001_r.comm_r    = bufacm001.comm
                        wacm001_r.stamp_r   = bufacm001.stamp
                        wacm001_r.tax_r     = bufacm001.tax
                        wacm001_r.fee_r     = bufacm001.fee
                        wacm001_r.netamt_r  = bufacm001.netamt
                        wacm001_r.bal_r     = bufacm001.bal
                                          
                        wacm001_r.trndat_r  = bufacm001.trndat
                        wacm001_r.ref_r     = bufacm001.ref
                        wacm001_r.comdat_r  = bufacm001.comdat
                        wacm001_r.acno_r    = bufacm001.acno
                        wacm001_r.agent_r   = bufacm001.agent
                                          
                        wacm001_r.curcod_r  = bufacm001.curcod
                        wacm001_r.branch_r  = bufacm001.branch
                        wacm001_r.netloc_r  = bufacm001.netloc
                        wacm001_r.poltyp_r  = bufacm001.poltyp
                                          
                        wacm001_r.branch_r  = bufacm001.branch
                        wacm001_r.vehreg_r  = bufacm001.vehreg
                        wacm001_r.insno_r   = bufacm001.insno
                        wacm001_r.instot_r  = bufacm001.instot
                        wacm001_r.dociln_r  = bufacm001.dociln
                                          
                        wacm001_r.disput_r  = NO.
                    
                    /*Lukkana M. A55-0243 14/08/2012*/
                    
/*                     nv_chkwacm001_r = YES. */
                END.
            END.
            ELSE DO:                       
                FIND FIRST bacm001 USE-INDEX acm00104      WHERE 
                           bacm001.policy = acm001.policy  AND
                           bacm001.trnty1 =  "M"           AND  
                           bacm001.docno  <> acm001.docno  AND
                           bacm001.bal    =  acm001.bal    AND /*Lukkana M. A55-0243 10/08/2012*/
                           bacm001.agent  =  acm001.agent  NO-ERROR.  /*create ครั้งแรกกรณีที่type M มี agent เหมือนกัน*/
                IF AVAIL bacm001 THEN DO:
                    
                    CREATE acm001_m.
                    ASSIGN
                        acm001_m.policy_m1  = acm001.policy
                        acm001_m.recno_m1   = acm001.recno
                        acm001_m.trnty1_m1  = acm001.trnty1
                        acm001_m.trnty2_m1  = acm001.trnty2
                        acm001_m.docno_m1   = acm001.docno
                        acm001_m.baloc_m1   = acm001.baloc
                                                 
                        acm001_m.prem_m1    = acm001.prem
                        acm001_m.comm_m1    = acm001.comm
                        acm001_m.stamp_m1   = acm001.stamp
                        acm001_m.tax_m1     = acm001.tax
                        acm001_m.fee_m1     = acm001.fee
                        acm001_m.netamt_m1  = acm001.netamt
                        acm001_m.bal_m1     = acm001.bal
                        acm001_m.trndat_m1  = acm001.trndat
                        acm001_m.ref_m1     = acm001.ref
                        acm001_m.comdat_m1  = acm001.comdat
                        acm001_m.acno_m1    = acm001.acno
                        acm001_m.agent_m1   = acm001.agent
                                                 
                        acm001_m.curcod_m1  = acm001.curcod
                        acm001_m.branch_m1  = acm001.branch
                        acm001_m.netloc_m1  = acm001.netloc
                        acm001_m.poltyp_m1  = acm001.poltyp
                        acm001_m.branch_m1  = acm001.branch
                        acm001_m.vehreg_m1  = acm001.vehreg
                        acm001_m.insno_m1   = acm001.insno
                        acm001_m.instot_m1  = acm001.instot
                        acm001_m.dociln_m1  = acm001.dociln.
                    
                END.
            END.
        END.
        ELSE DO:
            IF acm001_m.acno_m1 = acm001.acno AND acm001_m.agent_m1 = acm001.agent THEN DO: /*เอาเฉพาะ acno และ agent เดียวกัน*/
                CREATE acm001_m.
                ASSIGN
                    acm001_m.policy_m1  = acm001.policy
                    acm001_m.recno_m1   = acm001.recno
                    acm001_m.trnty1_m1  = acm001.trnty1
                    acm001_m.trnty2_m1  = acm001.trnty2
                    acm001_m.docno_m1   = acm001.docno
                    acm001_m.baloc_m1   = acm001.baloc
                                             
                    acm001_m.prem_m1    = acm001.prem
                    acm001_m.comm_m1    = acm001.comm
                    acm001_m.stamp_m1   = acm001.stamp
                    acm001_m.tax_m1     = acm001.tax
                    acm001_m.fee_m1     = acm001.fee
                    acm001_m.netamt_m1  = acm001.netamt
                    acm001_m.bal_m1     = acm001.bal
                    acm001_m.trndat_m1  = acm001.trndat
                    acm001_m.ref_m1     = acm001.ref
                    acm001_m.comdat_m1  = acm001.comdat
                    acm001_m.acno_m1    = acm001.acno
                    acm001_m.agent_m1   = acm001.agent
                                             
                    acm001_m.curcod_m1  = acm001.curcod
                    acm001_m.branch_m1  = acm001.branch
                    acm001_m.netloc_m1  = acm001.netloc
                    acm001_m.poltyp_m1  = acm001.poltyp
                    acm001_m.branch_m1  = acm001.branch
                    acm001_m.vehreg_m1  = acm001.vehreg
                    acm001_m.insno_m1   = acm001.insno
                    acm001_m.instot_m1  = acm001.instot
                    acm001_m.dociln_m1  = acm001.dociln.

                IF bufacm001.agent = acm001_m.agent_m1 THEN DO: /*Lukkana M. A53-0395 05/01/2011 เอาเฉพาะ agent code เดียวกัน*/
                    /**** นำเบี้ย -  เข้า temp-table  wacm001_r  ****/
                    FIND FIRST wacm001_r USE-INDEX wacm00101_r
                         WHERE wacm001_r.trnty1 = bufacm001.trnty1 AND
                               wacm001_r.docno = bufacm001.docno NO-ERROR.
                    IF NOT AVAIL wacm001_r THEN DO:
                        CREATE wacm001_r.
                        /*  wacmat01.i                 {1}                  {2} */
                        /*{wac\wace1001.i  wacm001_r   bufacm001 } Lukkana M. A55-0243 14/08/2012*/
                            /*Lukkana M. A55-0243 14/08/2012*/
                            ASSIGN
                                wacm001_r.policy_r  = bufacm001.policy
                                wacm001_r.recno_r   = bufacm001.recno
                                wacm001_r.trnty1_r  = bufacm001.trnty1
                                wacm001_r.trnty2_r  = bufacm001.trnty2
                                wacm001_r.docno_r   = bufacm001.docno
                                wacm001_r.baloc_r   = bufacm001.baloc
                                                  
                                wacm001_r.prem_r    = bufacm001.prem
                                wacm001_r.comm_r    = bufacm001.comm
                                wacm001_r.stamp_r   = bufacm001.stamp
                                wacm001_r.tax_r     = bufacm001.tax
                                wacm001_r.fee_r     = bufacm001.fee
                                wacm001_r.netamt_r  = bufacm001.netamt
                                wacm001_r.bal_r     = bufacm001.bal
                                                  
                                wacm001_r.trndat_r  = bufacm001.trndat
                                wacm001_r.ref_r     = bufacm001.ref
                                wacm001_r.comdat_r  = bufacm001.comdat
                                wacm001_r.acno_r    = bufacm001.acno
                                wacm001_r.agent_r   = bufacm001.agent
                                                  
                                wacm001_r.curcod_r  = bufacm001.curcod
                                wacm001_r.branch_r  = bufacm001.branch
                                wacm001_r.netloc_r  = bufacm001.netloc
                                wacm001_r.poltyp_r  = bufacm001.poltyp
                                                  
                                wacm001_r.branch_r  = bufacm001.branch
                                wacm001_r.vehreg_r  = bufacm001.vehreg
                                wacm001_r.insno_r   = bufacm001.insno
                                wacm001_r.instot_r  = bufacm001.instot
                                wacm001_r.dociln_r  = bufacm001.dociln
                                                  
                                wacm001_r.disput_r  = NO.
                        
                            /*Lukkana M. A55-0243 14/08/2012*/
                        
/*                         nv_chkwacm001_r = YES. */
                    END.
                END.
            END. /*IF acm001_m.acno = acm001.acno AND acm001_m.agent = acm001.agent THEN DO: เอาเฉพาะ acno และ agent เดียวกัน*/
        END.
        /*---Lukkana M. A53-0395 05/01/2011------*/
                                   
    END.   
    
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDsearchPositive C-Win 
PROCEDURE PDsearchPositive :
/*------------------------------------------------------------------------------
  Purpose:     A61-0151
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF INPUT PARAMETER nv_acno AS CHAR FORMAT "x(10)".
FOR  EACH acm001 USE-INDEX acm00122 NO-LOCK 
         WHERE  acm001.acno    = nv_acno  AND
                acm001.baloc   > 0 AND
                acm001.curcod   = "BHT"       AND 
               (acm001.trndat  >= nv_trndatfr AND acm001.trndat <= nv_trndatto ) AND
                acm001.trnty1   = "M"         AND 
/*                 acm001.bal     <> 0           AND */
               (acm001.policy  >= nv_polfr    AND acm001.policy <= nv_polto )  ,

        FIRST bufacm001 USE-INDEX acm00104
              WHERE  bufacm001.policy   =  acm001.policy      AND
                     bufacm001.recno   <>  " "                AND
                     bufacm001.acno     =  acm001.acno        AND    /* ตัดเบี้ย ต้อง acno code เดียวกัน เท่านั้น*/
                    (bufacm001.trndat  >=  nv_trndatfr        AND  bufacm001.trndat <= nv_trndatto ) AND   /* อยุ๋ในช่วง trndat ที่เรียกด้วย  A47-0999 */
                     bufacm001.trnty1   =  "R"                AND
                     bufacm001.prem     =  acm001.prem   * -1 AND
                     bufacm001.comm     =  acm001.comm   * -1 AND
                     bufacm001.tax      =  acm001.tax    * -1 AND
                     bufacm001.stamp    =  acm001.stamp  * -1 AND
                     bufacm001.netamt   =  acm001.netamt * -1 AND
                     bufacm001.bal      =  acm001.bal    * -1
        NO-LOCK BREAK BY  acm001.acno 
                      BY  acm001.recno.

        DISP acm001.acno FORMAT "X(10)"
             acm001.policy
             acm001.recno
             acm001.trnty1
             acm001.docno
        WITH COLOR BLACK/WHITE NO-LABEL FRAME frProcess VIEW-AS DIALOG-BOX
        TITLE  "  Processing ...".         

        /*IF LOOKUP(acm001.agent,n_acno) <> 0 THEN NEXT. /* add by Phaiboon W. [A59-0233] */ Chonlatisj. A60-0419 03/11/2017*/
        IF LOOKUP(acm001.acno,n_acno) <> 0 THEN NEXT. /*Add by Chonlatisj. A60-0419 03/11/2017*/

    /*----- Lukkana M. A53-0395 05/01/2011
    /**** นำเบี้ย + เข้า temp-table  wacm001_m  ****/
        FIND FIRST wacm001_m USE-INDEX acm00101
             WHERE wacm001_m.trnty1 = acm001.trnty1 AND
                   wacm001_m.docno  = acm001.docno  NO-ERROR. 
        IF NOT AVAIL wacm001_m THEN DO:

            MESSAGE acm001.policy acm001.trnty1 acm001.trnty2 acm001.agent SKIP
                    wacm001_m.trnty1 wacm001_m.trnty2 wacm001_m.agent.
            CREATE wacm001_m.
            /*  wacmat01.i                 {1}                  {2} */
            {wac\wace1001.i  wacm001_m   acm001 }
            
            nv_chkwacm001_m = YES.

            END.
        END.

        /**** นำเบี้ย -  เข้า temp-table  wacm001_r  ****/
        FIND FIRST wacm001_r USE-INDEX acm00101
             WHERE wacm001_r.trnty1 = bufacm001.trnty1 AND
                   wacm001_r.docno = bufacm001.docno NO-ERROR.
        IF NOT AVAIL wacm001_r THEN DO:
            CREATE wacm001_r.
            /*  wacmat01.i                 {1}                  {2} */
            {wac\wace1001.i  wacm001_r   bufacm001 }
            
            nv_chkwacm001_r = YES.
        END.
        Lukkana M. A53-0395 05/01/2011------*/

        /*---Lukkana M. A53-0395 05/01/2011------*/
        FIND FIRST acm001_m USE-INDEX acm00104_m 
             WHERE acm001_m.policy_m1  = acm001.policy NO-ERROR.
        IF NOT AVAIL acm001_m THEN DO:
            IF bufacm001.agent = acm001.agent THEN DO: /*เอาเฉพาะ agent code เดียวกัน*/
              
                CREATE acm001_m.
                ASSIGN
                    acm001_m.policy_m1  = acm001.policy
                    acm001_m.recno_m1   = acm001.recno
                    acm001_m.trnty1_m1  = acm001.trnty1
                    acm001_m.trnty2_m1  = acm001.trnty2
                    acm001_m.docno_m1   = acm001.docno
                    acm001_m.baloc_m1   = acm001.baloc
                                             
                    acm001_m.prem_m1    = acm001.prem
                    acm001_m.comm_m1    = acm001.comm
                    acm001_m.stamp_m1   = acm001.stamp
                    acm001_m.tax_m1     = acm001.tax
                    acm001_m.fee_m1     = acm001.fee
                    acm001_m.netamt_m1  = acm001.netamt
                    acm001_m.bal_m1     = acm001.bal
                    acm001_m.trndat_m1  = acm001.trndat
                    acm001_m.ref_m1     = acm001.ref
                    acm001_m.comdat_m1  = acm001.comdat
                    acm001_m.acno_m1    = acm001.acno
                    acm001_m.agent_m1   = acm001.agent
                                             
                    acm001_m.curcod_m1  = acm001.curcod
                    acm001_m.branch_m1  = acm001.branch
                    acm001_m.netloc_m1  = acm001.netloc
                    acm001_m.poltyp_m1  = acm001.poltyp
                    acm001_m.branch_m1  = acm001.branch
                    acm001_m.vehreg_m1  = acm001.vehreg
                    acm001_m.insno_m1   = acm001.insno
                    acm001_m.instot_m1  = acm001.instot
                    acm001_m.dociln_m1  = acm001.dociln.
            
                /**** นำเบี้ย -  เข้า temp-table  wacm001_r  ****/
                FIND FIRST wacm001_r USE-INDEX wacm00101_r
                     WHERE wacm001_r.trnty1 = bufacm001.trnty1 AND
                           wacm001_r.docno = bufacm001.docno NO-ERROR.
                IF NOT AVAIL wacm001_r THEN DO:
                    CREATE wacm001_r.
                    /*  wacmat01.i                 {1}                  {2} */
                    /*{wac\wace1001.i  wacm001_r   bufacm001 } Lukkana M. A55-0243 14/08/2012*/
                    /*Lukkana M. A55-0243 14/08/2012*/
                    
                    ASSIGN
                        wacm001_r.policy_r  = bufacm001.policy
                        wacm001_r.recno_r   = bufacm001.recno
                        wacm001_r.trnty1_r  = bufacm001.trnty1
                        wacm001_r.trnty2_r  = bufacm001.trnty2
                        wacm001_r.docno_r   = bufacm001.docno
                        wacm001_r.baloc_r   = bufacm001.baloc
                                          
                        wacm001_r.prem_r    = bufacm001.prem
                        wacm001_r.comm_r    = bufacm001.comm
                        wacm001_r.stamp_r   = bufacm001.stamp
                        wacm001_r.tax_r     = bufacm001.tax
                        wacm001_r.fee_r     = bufacm001.fee
                        wacm001_r.netamt_r  = bufacm001.netamt
                        wacm001_r.bal_r     = bufacm001.bal
                                          
                        wacm001_r.trndat_r  = bufacm001.trndat
                        wacm001_r.ref_r     = bufacm001.ref
                        wacm001_r.comdat_r  = bufacm001.comdat
                        wacm001_r.acno_r    = bufacm001.acno
                        wacm001_r.agent_r   = bufacm001.agent
                                          
                        wacm001_r.curcod_r  = bufacm001.curcod
                        wacm001_r.branch_r  = bufacm001.branch
                        wacm001_r.netloc_r  = bufacm001.netloc
                        wacm001_r.poltyp_r  = bufacm001.poltyp
                                          
                        wacm001_r.branch_r  = bufacm001.branch
                        wacm001_r.vehreg_r  = bufacm001.vehreg
                        wacm001_r.insno_r   = bufacm001.insno
                        wacm001_r.instot_r  = bufacm001.instot
                        wacm001_r.dociln_r  = bufacm001.dociln
                                          
                        wacm001_r.disput_r  = NO.
                    
                    /*Lukkana M. A55-0243 14/08/2012*/
                    
/*                     nv_chkwacm001_r = YES. */
                END.
            END.
            ELSE DO:                       
                FIND FIRST bacm001 USE-INDEX acm00104      WHERE 
                           bacm001.policy = acm001.policy  AND
                           bacm001.trnty1 =  "M"           AND  
                           bacm001.docno  <> acm001.docno  AND
                           bacm001.bal    =  acm001.bal    AND /*Lukkana M. A55-0243 10/08/2012*/
                           bacm001.agent  =  acm001.agent  NO-ERROR.  /*create ครั้งแรกกรณีที่type M มี agent เหมือนกัน*/
                IF AVAIL bacm001 THEN DO:
                    
                    CREATE acm001_m.
                    ASSIGN
                        acm001_m.policy_m1  = acm001.policy
                        acm001_m.recno_m1   = acm001.recno
                        acm001_m.trnty1_m1  = acm001.trnty1
                        acm001_m.trnty2_m1  = acm001.trnty2
                        acm001_m.docno_m1   = acm001.docno
                        acm001_m.baloc_m1   = acm001.baloc
                                                 
                        acm001_m.prem_m1    = acm001.prem
                        acm001_m.comm_m1    = acm001.comm
                        acm001_m.stamp_m1   = acm001.stamp
                        acm001_m.tax_m1     = acm001.tax
                        acm001_m.fee_m1     = acm001.fee
                        acm001_m.netamt_m1  = acm001.netamt
                        acm001_m.bal_m1     = acm001.bal
                        acm001_m.trndat_m1  = acm001.trndat
                        acm001_m.ref_m1     = acm001.ref
                        acm001_m.comdat_m1  = acm001.comdat
                        acm001_m.acno_m1    = acm001.acno
                        acm001_m.agent_m1   = acm001.agent
                                                 
                        acm001_m.curcod_m1  = acm001.curcod
                        acm001_m.branch_m1  = acm001.branch
                        acm001_m.netloc_m1  = acm001.netloc
                        acm001_m.poltyp_m1  = acm001.poltyp
                        acm001_m.branch_m1  = acm001.branch
                        acm001_m.vehreg_m1  = acm001.vehreg
                        acm001_m.insno_m1   = acm001.insno
                        acm001_m.instot_m1  = acm001.instot
                        acm001_m.dociln_m1  = acm001.dociln.
                    
                END.
            END.
        END.
        ELSE DO:
            IF acm001_m.acno_m1 = acm001.acno AND acm001_m.agent_m1 = acm001.agent THEN DO: /*เอาเฉพาะ acno และ agent เดียวกัน*/
                CREATE acm001_m.
                ASSIGN
                    acm001_m.policy_m1  = acm001.policy
                    acm001_m.recno_m1   = acm001.recno
                    acm001_m.trnty1_m1  = acm001.trnty1
                    acm001_m.trnty2_m1  = acm001.trnty2
                    acm001_m.docno_m1   = acm001.docno
                    acm001_m.baloc_m1   = acm001.baloc
                                             
                    acm001_m.prem_m1    = acm001.prem
                    acm001_m.comm_m1    = acm001.comm
                    acm001_m.stamp_m1   = acm001.stamp
                    acm001_m.tax_m1     = acm001.tax
                    acm001_m.fee_m1     = acm001.fee
                    acm001_m.netamt_m1  = acm001.netamt
                    acm001_m.bal_m1     = acm001.bal
                    acm001_m.trndat_m1  = acm001.trndat
                    acm001_m.ref_m1     = acm001.ref
                    acm001_m.comdat_m1  = acm001.comdat
                    acm001_m.acno_m1    = acm001.acno
                    acm001_m.agent_m1   = acm001.agent
                                             
                    acm001_m.curcod_m1  = acm001.curcod
                    acm001_m.branch_m1  = acm001.branch
                    acm001_m.netloc_m1  = acm001.netloc
                    acm001_m.poltyp_m1  = acm001.poltyp
                    acm001_m.branch_m1  = acm001.branch
                    acm001_m.vehreg_m1  = acm001.vehreg
                    acm001_m.insno_m1   = acm001.insno
                    acm001_m.instot_m1  = acm001.instot
                    acm001_m.dociln_m1  = acm001.dociln.

                IF bufacm001.agent = acm001_m.agent_m1 THEN DO: /*Lukkana M. A53-0395 05/01/2011 เอาเฉพาะ agent code เดียวกัน*/
                    /**** นำเบี้ย -  เข้า temp-table  wacm001_r  ****/
                    FIND FIRST wacm001_r USE-INDEX wacm00101_r
                         WHERE wacm001_r.trnty1 = bufacm001.trnty1 AND
                               wacm001_r.docno = bufacm001.docno NO-ERROR.
                    IF NOT AVAIL wacm001_r THEN DO:
                        CREATE wacm001_r.
                        /*  wacmat01.i                 {1}                  {2} */
                        /*{wac\wace1001.i  wacm001_r   bufacm001 } Lukkana M. A55-0243 14/08/2012*/
                            /*Lukkana M. A55-0243 14/08/2012*/
                            ASSIGN
                                wacm001_r.policy_r  = bufacm001.policy
                                wacm001_r.recno_r   = bufacm001.recno
                                wacm001_r.trnty1_r  = bufacm001.trnty1
                                wacm001_r.trnty2_r  = bufacm001.trnty2
                                wacm001_r.docno_r   = bufacm001.docno
                                wacm001_r.baloc_r   = bufacm001.baloc
                                                  
                                wacm001_r.prem_r    = bufacm001.prem
                                wacm001_r.comm_r    = bufacm001.comm
                                wacm001_r.stamp_r   = bufacm001.stamp
                                wacm001_r.tax_r     = bufacm001.tax
                                wacm001_r.fee_r     = bufacm001.fee
                                wacm001_r.netamt_r  = bufacm001.netamt
                                wacm001_r.bal_r     = bufacm001.bal
                                                  
                                wacm001_r.trndat_r  = bufacm001.trndat
                                wacm001_r.ref_r     = bufacm001.ref
                                wacm001_r.comdat_r  = bufacm001.comdat
                                wacm001_r.acno_r    = bufacm001.acno
                                wacm001_r.agent_r   = bufacm001.agent
                                                  
                                wacm001_r.curcod_r  = bufacm001.curcod
                                wacm001_r.branch_r  = bufacm001.branch
                                wacm001_r.netloc_r  = bufacm001.netloc
                                wacm001_r.poltyp_r  = bufacm001.poltyp
                                                  
                                wacm001_r.branch_r  = bufacm001.branch
                                wacm001_r.vehreg_r  = bufacm001.vehreg
                                wacm001_r.insno_r   = bufacm001.insno
                                wacm001_r.instot_r  = bufacm001.instot
                                wacm001_r.dociln_r  = bufacm001.dociln
                                                  
                                wacm001_r.disput_r  = NO.
                        
                            /*Lukkana M. A55-0243 14/08/2012*/
                        
/*                         nv_chkwacm001_r = YES. */
                    END.
                END.
            END. /*IF acm001_m.acno = acm001.acno AND acm001_m.agent = acm001.agent THEN DO: เอาเฉพาะ acno และ agent เดียวกัน*/
        END.
        /*---Lukkana M. A53-0395 05/01/2011------*/
                                   
    END.   
    
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_create C-Win 
PROCEDURE pd_create :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*Lukkana M. A55-0243 14/08/2012*/

ASSIGN
    wacm001_m.policy_m  = acm001_m.policy_m1
    wacm001_m.recno_m   = acm001_m.recno_m1
    wacm001_m.trnty1_m  = acm001_m.trnty1_m1
    wacm001_m.trnty2_m  = acm001_m.trnty2_m1
    wacm001_m.docno_m   = acm001_m.docno_m1
    wacm001_m.baloc_m   = acm001_m.baloc_m1
                      
    wacm001_m.prem_m    = acm001_m.prem_m1
    wacm001_m.comm_m    = acm001_m.comm_m1
    wacm001_m.stamp_m   = acm001_m.stamp_m1
    wacm001_m.tax_m     = acm001_m.tax_m1
    wacm001_m.fee_m     = acm001_m.fee_m1
    wacm001_m.netamt_m  = acm001_m.netamt_m1
    wacm001_m.bal_m     = acm001_m.bal_m1
                      
    wacm001_m.trndat_m  = acm001_m.trndat_m1
    wacm001_m.ref_m     = acm001_m.ref_m1
    wacm001_m.comdat_m  = acm001_m.comdat_m1
    wacm001_m.acno_m    = acm001_m.acno_m1
    wacm001_m.agent_m   = acm001_m.agent_m1
                      
    wacm001_m.curcod_m  = acm001_m.curcod_m1
    wacm001_m.branch_m  = acm001_m.branch_m1
    wacm001_m.netloc_m  = acm001_m.netloc_m1
    wacm001_m.poltyp_m  = acm001_m.poltyp_m1
                      
    wacm001_m.branch_m  = acm001_m.branch_m1
    wacm001_m.vehreg_m  = acm001_m.vehreg_m1
    wacm001_m.insno_m   = acm001_m.insno_m1
    wacm001_m.instot_m  = acm001_m.instot_m1
    wacm001_m.dociln_m  = acm001_m.dociln_m1
                      
    wacm001_m.disput_m  = NO.

/*Lukkana M. A55-0243 14/08/2012*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

