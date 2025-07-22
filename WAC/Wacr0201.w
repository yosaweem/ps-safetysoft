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

  Modify by : TANTAWAN C.   A500178    08/11/2007
              ยขยาย format fiacno1 จาก "X(7)" เป็น  Char "X(10)"  
                           fiacno2 จาก "X(7)" เป็น  Char "X(10)" 
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
/* Create By : Kanchana C.             A46-0030    13/01/2003  for Audit  
    ส่ง text file นำเข้า excel                  ให้ audit */

Wac
        -Wacr0201.w     /* PRINT PREMIUM STATEMENT (A4) FOR AUDIT*/
        -wacr0201.i       /* File for AUDIT         A46-0348 */

WPrl
        -Wac_sm01.prl
Whp
        -WhpBran.w
        -WhpAcno.w
        -WhpClico.w
Wut
        -WutDiCen.p
        -WutWiCen.p
        
/* Modify : Kanchana C.  31/10/2002  
                แก้ไข  ออก text file ให้ออกเป็น text file คั่นด้วย ";"  แล้วจึงนำเข้า Excel   */

/* Modify By : Kanchana C.             A46-0019    13/01/2003
    1. ดึงงาน เฉพาะ AG/BK เท่านั้น  ออกกระดาษ A4
        ระบุ ประเภทตัวแทน  ที่จะให้พิมพ์ จาก Client type ดังนี้  AG AM BD BM BR PS RS ST(STAFF)
        output --> Report Builder  เป็นกระดาษส่ง
        
    2. ดึงเฉพาะ xmm600.Clicod  = ที่เป็นรหัส DE  ,  FN  ,OT  
        เพิ่ม Filed จาก  Statment เดิม  คือ  Credit days  Overdue date  Overdue days 
                 Make   Model  Chassis  Sticker   
                    Output เหมือน Statement to excel  ATC00701.P
        ระบุ ประเภทตัวแทน  ที่จะให้พิมพ์ จาก Client type ดังนี้   DE FI  FN  OT
        output --> ออก text    เข้า File Excel  
*/

/* Modify By : Kanchana C.             A46-0218    27/06/2003
    ระบุ ประเภทตัวแทน  ที่จะให้พิมพ์ จาก Client type 
    ช่อง AG/BR        เพิ่ม OT
           FI/Dealer    เพิ่ม DI  ,  ย้าย  OT
*/

/* Modify By : Kanchana C.             A46-0348    02/08/2003 
    - ให้เลือก Type ได้ว่า จะเอา Type อะไรบ้าง  จะได้ดึง เฉพาะที่เป็นงาน Direct
    - default trnty1  = "M,R,A,B,Y,Z"
    - Client type = ALL
*/

/* Modify By : Kanchana C.             A47-0159    04/05/2004
   - เพิ่มช่องให้สามารถเลือก Bal filter
   ทั้ง Excel,  Report builder
*/

/* Modify By Wantanee.S A49-0139  Date 11/08/2006 Lock Database Sicfn 
   - Lock ไม่ให้ User Blank เข้าใช้ database */
/*----------------------------------------------------------------------
     Modify By: Saharat S.  A62-0279  29/01/2019
      -เปลี่ยนหัว เป็น TMSTH
----------------------------------------------------------------------*/
*****************************************/    
/* ***************************  Definitions  ************************** */
DEF     SHARED VAR n_User               AS CHAR.
DEF     SHARED VAR n_Passwd         AS CHAR.
DEF      VAR   nv_User     AS CHAR NO-UNDO. 
DEF      VAR   nv_pwd    LIKE _password NO-UNDO.

/* Definitons  Report -------                                               */
DEF  VAR report-library AS CHAR INIT "wAC/wprl/wac_sm01A.prl".
DEF  VAR report-name  AS CHAR INIT "Statement of Account By Trandate".

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
DEF NEW SHARED VAR n_agent1      AS CHAR FORMAT "x(7)".
DEF NEW SHARED VAR n_agent2      AS CHAR FORMAT "x(7)".
DEF NEW SHARED VAR n_branch      AS CHAR FORMAT "x(2)".
DEF NEW SHARED VAR n_branch2    AS CHAR FORMAT "x(2)".
DEF NEW SHARED VAR n_tabcod      AS CHAR FORMAT "X(4)"    INIT "U021".   /* Table-Code  sym100*/
DEF NEW SHARED VAR n_itmcod       AS CHAR FORMAT "X(4)".

Def   Var    n_name            As Char Format "x(50)".     /*acno name*/
Def   Var    n_chkname      As Char format "x(1)".        /* Acno-- chk button 1-2 */
Def   Var    n_bdes             As Char Format "x(50)".     /*branch name*/
Def   Var    n_chkBname    As Char format "x(1)".        /* branch-- chk button 1-2 */
Def   Var    n_itmdes          As Char Format "x(40)".     /*Table-Code Description*/

/* Local Variable Definitions ---                                       */

DEF VAR nv_asmth   AS INTE INIT 0.
DEF VAR nv_frmth   AS INTE INIT 0.
DEF VAR nv_tomth   AS INTE INIT 0.
DEF VAR cv_mthlistT AS CHAR INIT "มกราคม,กุมภาพันธ์,มีนาคม,เมษายน,พฤษภาคม,มิถุนายน,กรกฎาคม,สิงหาคม,กันยายน,ตุลาคม,พฤศจิกายน,ธันวาคม".
DEF VAR cv_mthListE AS CHAR INIT "January, February, March, April, May, June, July, August, September, October, November, December".

DEF VAR n_asdat  AS DATE FORMAT "99/99/9999".
DEF VAR n_frbr      AS   CHAR   FORMAT "x(2)".
DEF VAR n_tobr     AS   CHAR   FORMAT "x(2)".
DEF VAR n_frac     AS   CHAR   FORMAT "x(7)".
DEF VAR n_toac    AS   CHAR   FORMAT "x(7)".
DEF VAR n_typ      AS   CHAR   FORMAT "X".
DEF VAR n_typ1     AS   CHAR   FORMAT "X".
DEF VAR n_trndatto  AS DATE FORMAT "99/99/9999".

DEF VAR n_chkCopy     AS INTEGER.
DEF VAR n_OutputTo    AS INTEGER.
DEF VAR n_OutputFile  AS Char.
DEF VAR n_OutputFile2  AS Char.

DEF VAR vCliCod        AS CHAR.
DEF VAR vCliCodAll   AS CHAR.
DEF VAR vCountRec   AS INT.
DEF VAR vAcProc_fil  AS CHAR.

/*--------------------------------------- A46-0019 -----------------------------*/
DEF VAR nv_ProcessDate AS DATE FORMAT "99/99/9999".
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

/******************** output to file*******************/
DEF         VAR n_net      AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF         VAR n_wcr      AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  /*with in credit*/
DEF         VAR n_damt   AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  /*due amount */
DEF         VAR n_odue   AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  /*overdue*/

DEF         VAR n_odue1     AS   DECI   FORMAT ">>,>>>,>>9.99-".  /*overdue 1-3 months*/
DEF         VAR n_odue2     AS   DECI   FORMAT ">>,>>>,>>9.99-".  /*overdue 3-6 months*/
DEF         VAR n_odue3     AS   DECI   FORMAT ">>,>>>,>>9.99-".  /*overdue 6-9 months*/
DEF         VAR n_odue4     AS   DECI   FORMAT ">>,>>>,>>9.99-".  /*overdue 9-12 months*/
DEF         VAR n_odue5     AS   DECI   FORMAT ">>,>>>,>>9.99-".  /*overdue over 12 months*/

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

/* TOTAL */
DEF  VAR nv_tot_prem             AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_tot_prem_comp  AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_tot_stamp            AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_tot_tax                 AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_tot_gross            AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_tot_comm            AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_tot_comm_comp AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_tot_net                 AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_tot_bal                 AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".

DEF  VAR nv_tot_wcr        AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  /*with in credit*/
DEF  VAR nv_tot_damt     AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  /*due amount */
DEF  VAR nv_tot_odue     AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  /* overdue*/

DEF  VAR nv_tot_odue1   AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  /*overdue*/
DEF  VAR nv_tot_odue2   AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  /*overdue*/
DEF  VAR nv_tot_odue3   AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  /*overdue*/
DEF  VAR nv_tot_odue4   AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  /*overdue*/
DEF  VAR nv_tot_odue5   AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  /*overdue*/

/* GRAND TOTAL */
DEF  VAR nv_gtot_prem             AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_gtot_prem_comp  AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_gtot_stamp            AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_gtot_tax                 AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_gtot_gross            AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_gtot_comm            AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_gtot_comm_comp AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_gtot_net                 AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_gtot_bal                 AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".

DEF  VAR nv_gtot_wcr        AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  /*with in credit*/
DEF  VAR nv_gtot_damt     AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  /*due amount */
DEF  VAR nv_gtot_odue     AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  /*overdue*/

DEF  VAR nv_gtot_odue1   AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  /*overdue*/
DEF  VAR nv_gtot_odue2   AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  /*overdue*/
DEF  VAR nv_gtot_odue3   AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  /*overdue*/
DEF  VAR nv_gtot_odue4   AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  /*overdue*/
DEF  VAR nv_gtot_odue5   AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  /*overdue*/

DEF VAR nv_asdatAging    AS DATE FORMAT "99/99/9999".

/************  field in atc00701.p ***************/
DEF VAR n_acbrn    AS CHAR FORMAT "X(7)".
DEF VAR n_clityp     AS CHAR FORMAT "X(2)".
DEF VAR n_expdat   AS DATE FORMAT "99/99/9999".
DEF VAR n_campol  AS CHAR FORMAT "X(16)".  /* uwm100.opnpol */
DEF VAR n_dealer   AS CHAR FORMAT "X(100)".

DEF VAR n_veh        AS CHAR FORMAT "X(10)".

DEF VAR n_chano    AS CHAR FORMAT "X(20)".
DEF VAR n_moddes AS CHAR FORMAT "X(40)".
DEF VAR n_cedpol  AS CHAR FORMAT "X(16)".    /* uwm100.cedpol */

DEF NEW SHARED VAR n_sckno     AS CHAR   FORMAT "X(16)"   INIT ""     NO-UNDO.  /*umm301.sckno */
DEF NEW SHARED VAR nvw_sticker AS INTEGER  FORMAT "9999999999" INIT 0 NO-UNDO.
DEF NEW SHARED VAR nv_sticker  AS INTEGER  FORMAT "9999999999".
DEF NEW SHARED VAR chr_sticker AS CHAR     FORMAT "X(11)".
DEF NEW SHARED VAR nv_modulo AS INT      FORMAT "9".
DEF NEW SHARED VAR nv_chkmod AS CHAR     FORMAT "X".

DEF BUFFER bxmm600 FOR xmm600.

DEF VAR n_gpstmt    AS CHAR FORMAT "X(7)".
DEF VAR n_opened  AS  DATE FORMAT "99/99/9999".
DEF VAR n_closed  AS  DATE FORMAT "99/99/9999".
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fuMaxday C-Win 
FUNCTION fuMaxday RETURNS INTEGER
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
     FILENAME "I:/SAFETY/WALP83/WIMAGE\wallpape":U CONVERT-3D-COLORS
     SIZE 132.5 BY 24.

DEFINE IMAGE IMAGE-23
     FILENAME "wimage\bgc01":U CONVERT-3D-COLORS
     SIZE 122.5 BY 22.91.

DEFINE VARIABLE raAllbal AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "All", 1,
"Partial", 2
     SIZE 25.5 BY 1.05
     BGCOLOR 1 FGCOLOR 7 FONT 6 NO-UNDO.

DEFINE VARIABLE todamt AS LOGICAL INITIAL no 
     LABEL "Due Amount" 
     VIEW-AS TOGGLE-BOX
     SIZE 18 BY .76
     FONT 6 NO-UNDO.

DEFINE VARIABLE toOdue1 AS LOGICAL INITIAL no 
     LABEL "Over due 1-3 m" 
     VIEW-AS TOGGLE-BOX
     SIZE 19.5 BY .76
     FONT 6 NO-UNDO.

DEFINE VARIABLE toOdue2 AS LOGICAL INITIAL no 
     LABEL "Over due 3-6 m" 
     VIEW-AS TOGGLE-BOX
     SIZE 19.5 BY .76
     FONT 6 NO-UNDO.

DEFINE VARIABLE toOdue3 AS LOGICAL INITIAL no 
     LABEL "Over due 6-9 m" 
     VIEW-AS TOGGLE-BOX
     SIZE 19.5 BY .76
     FONT 6 NO-UNDO.

DEFINE VARIABLE toOdue4 AS LOGICAL INITIAL no 
     LABEL "Over due 9-12 m" 
     VIEW-AS TOGGLE-BOX
     SIZE 19.5 BY .76
     FONT 6 NO-UNDO.

DEFINE VARIABLE toOdue5 AS LOGICAL INITIAL no 
     LABEL "Over 12 m" 
     VIEW-AS TOGGLE-BOX
     SIZE 19.5 BY .76
     FONT 6 NO-UNDO.

DEFINE VARIABLE towcr AS LOGICAL INITIAL no 
     LABEL "With In Credit" 
     VIEW-AS TOGGLE-BOX
     SIZE 18 BY .76
     FONT 6 NO-UNDO.

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
     SIZE 18.5 BY 4.95
     BGCOLOR 1 .

DEFINE VARIABLE cbPrtList AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 10
     DROP-DOWN-LIST
     SIZE 28 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fiFile-Name AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 21.5 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE rsOutput AS INTEGER 
     VIEW-AS RADIO-SET VERTICAL
     RADIO-BUTTONS 
          "Item 1", 1,
"Item 2", 2,
"Item 3", 3
     SIZE 16.5 BY 3.91
     BGCOLOR 3 FGCOLOR 15  NO-UNDO.

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
     SIZE 8 BY .95 TOOLTIP "เพิ่ม Client Type Code".

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
     SIZE 8 BY .95 TOOLTIP "ลบ Client Type Code".

DEFINE VARIABLE cbRptList AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEMS "wac_sm01A.prl" 
     DROP-DOWN-LIST
     SIZE 33 BY 1
     BGCOLOR 15  NO-UNDO.

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

DEFINE VARIABLE fibdes AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 29.5 BY .95
     BGCOLOR 3 FGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fibdes2 AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 29.5 BY .95
     BGCOLOR 3 FGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiBranch AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 5 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fiBranch2 AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 5 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fiCcode1 AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 5 BY .95 TOOLTIP "Client Type Code"
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fiInclude AS CHARACTER FORMAT "X(256)":U 
     LABEL "Fill 1" 
      VIEW-AS TEXT 
     SIZE 19.5 BY 1
     BGCOLOR 1 FGCOLOR 7 FONT 1 NO-UNDO.

DEFINE VARIABLE finame1 AS CHARACTER FORMAT "X(256)":U 
     LABEL "" 
      VIEW-AS TEXT 
     SIZE 47 BY .95
     BGCOLOR 8 FONT 6 NO-UNDO.

DEFINE VARIABLE finame2 AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 47 BY .95
     BGCOLOR 8 FONT 6 NO-UNDO.

DEFINE VARIABLE fiProcess AS CHARACTER FORMAT "X(256)":U 
     LABEL "fiProcess" 
      VIEW-AS TEXT 
     SIZE 37 BY .95
     BGCOLOR 8 FGCOLOR 0 FONT 1 NO-UNDO.

DEFINE VARIABLE fiProcessDate AS DATE FORMAT "99/99/9999":U 
      VIEW-AS TEXT 
     SIZE 12 BY 1
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

DEFINE VARIABLE raReportTyp AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "AG/BR", 1,
"FI/Dealer", 2,
"ALL", 3
     SIZE 38 BY 1.29
     BGCOLOR 19 FGCOLOR 0 FONT 2 NO-UNDO.

DEFINE RECTANGLE RECT-86
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 38.5 BY 6.24
     BGCOLOR 8 .

DEFINE RECTANGLE RECT1
     EDGE-PIXELS 4 GRAPHIC-EDGE  NO-FILL   
     SIZE 118.5 BY 15.91
     BGCOLOR 8 .

DEFINE RECTANGLE RECT11
     EDGE-PIXELS 3 GRAPHIC-EDGE    
     SIZE 76 BY 3.38
     BGCOLOR 8 .

DEFINE RECTANGLE RECT12
     EDGE-PIXELS 3 GRAPHIC-EDGE  NO-FILL   
     SIZE 26 BY 5.76.

DEFINE RECTANGLE reReprots
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 76 BY 7.29
     BGCOLOR 8 .

DEFINE VARIABLE seCliCod AS CHARACTER 
     VIEW-AS SELECTION-LIST MULTIPLE SORT SCROLLBAR-VERTICAL 
     SIZE 11.5 BY 4.71
     BGCOLOR 15  NO-UNDO.

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
    WITH NO-ROW-MARKERS SEPARATORS SIZE 72.5 BY 3.91
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
     IMAGE-23 AT ROW 1 COL 1
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         NO-LABELS SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 6 ROW 1.5
         SIZE 123 BY 23.

DEFINE FRAME frST
     fiBranch AT ROW 2.57 COL 23 COLON-ALIGNED NO-LABEL
     fiBranch2 AT ROW 3.76 COL 23 COLON-ALIGNED NO-LABEL
     fiacno1 AT ROW 6.24 COL 7.5 COLON-ALIGNED NO-LABEL
     fiacno2 AT ROW 7.24 COL 7.5 COLON-ALIGNED NO-LABEL
     raReportTyp AT ROW 2.29 COL 80 NO-LABEL
     fiTyp1 AT ROW 11.19 COL 85.5 COLON-ALIGNED NO-LABEL
     fiTyp2 AT ROW 11.19 COL 90.5 COLON-ALIGNED NO-LABEL
     fiTyp3 AT ROW 11.19 COL 95.5 COLON-ALIGNED NO-LABEL
     fiTyp4 AT ROW 11.19 COL 100.5 COLON-ALIGNED NO-LABEL
     fiTyp5 AT ROW 11.19 COL 105.5 COLON-ALIGNED NO-LABEL
     fiTyp6 AT ROW 12.48 COL 85.5 COLON-ALIGNED NO-LABEL
     fiTyp7 AT ROW 12.48 COL 90.5 COLON-ALIGNED NO-LABEL
     fiTyp8 AT ROW 12.48 COL 95.5 COLON-ALIGNED NO-LABEL
     fiTyp9 AT ROW 12.48 COL 100.5 COLON-ALIGNED NO-LABEL
     fiTyp10 AT ROW 12.48 COL 105.5 COLON-ALIGNED NO-LABEL
     fiTyp11 AT ROW 13.76 COL 85.5 COLON-ALIGNED NO-LABEL
     fiTyp12 AT ROW 13.76 COL 90.5 COLON-ALIGNED NO-LABEL
     fiTyp13 AT ROW 13.76 COL 95.5 COLON-ALIGNED NO-LABEL
     fiTyp14 AT ROW 13.76 COL 100.5 COLON-ALIGNED NO-LABEL
     fiTyp15 AT ROW 13.76 COL 105.5 COLON-ALIGNED NO-LABEL
     buBranch AT ROW 2.67 COL 30
     buBranch2 AT ROW 3.76 COL 30
     seCliCod AT ROW 4.67 COL 82.5 NO-LABEL
     buAcno1 AT ROW 6.24 COL 21.5
     buAcno2 AT ROW 7.24 COL 21.5
     fiCcode1 AT ROW 4.67 COL 94 COLON-ALIGNED NO-LABEL
     buClicod AT ROW 4.67 COL 101
     buAdd AT ROW 6.48 COL 96
     buDel AT ROW 7.76 COL 96
     cbRptList AT ROW 9.33 COL 18.5 COLON-ALIGNED NO-LABEL
     brAcproc_fil AT ROW 11.95 COL 3.5
     fibdes AT ROW 2.57 COL 31 COLON-ALIGNED NO-LABEL
     fibdes2 AT ROW 3.76 COL 31.5 COLON-ALIGNED NO-LABEL
     finame1 AT ROW 6.24 COL 23 COLON-ALIGNED
     finame2 AT ROW 7.24 COL 23 COLON-ALIGNED NO-LABEL
     fiInclude AT ROW 9.86 COL 96.5 COLON-ALIGNED
     fiAsdat AT ROW 10.67 COL 18.5 COLON-ALIGNED
     fiProcessDate AT ROW 10.67 COL 46 COLON-ALIGNED NO-LABEL
     fiProcess AT ROW 15.1 COL 80.5
     "From":40 VIEW-AS TEXT
          SIZE 5 BY .95 TOOLTIP "Account No. From" AT ROW 6.24 COL 4
          BGCOLOR 8 
     " Include Type All":50 VIEW-AS TEXT
          SIZE 18.5 BY 1 AT ROW 9.86 COL 80
          BGCOLOR 1 FGCOLOR 7 
     " Type Of Reports":50 VIEW-AS TEXT
          SIZE 16 BY .95 TOOLTIP "ประเภทรายงาน" AT ROW 9.33 COL 3.5
          BGCOLOR 1 FGCOLOR 7 
     "Branch To":10 VIEW-AS TEXT
          SIZE 10.5 BY .95 TOOLTIP "ถึงสาขา" AT ROW 3.76 COL 10
          BGCOLOR 3 FGCOLOR 15 
     "To":20 VIEW-AS TEXT
          SIZE 5 BY .95 TOOLTIP "รหัสตัวแทนถึง" AT ROW 7.24 COL 4
          BGCOLOR 8 
     "                                          PRINT PREMIUM STATEMENT (A4) FOR AUDIT":200 VIEW-AS TEXT
          SIZE 118.5 BY .95 AT ROW 1 COL 1
          BGCOLOR 1 FGCOLOR 14 FONT 2
     "Branch From":25 VIEW-AS TEXT
          SIZE 11 BY .95 TOOLTIP "ตั้งแต่สาขา" AT ROW 2.57 COL 10
          BGCOLOR 3 FGCOLOR 15 
     " Process Date":30 VIEW-AS TEXT
          SIZE 12 BY 1 TOOLTIP "วันที่ออกรายงาน" AT ROW 10.67 COL 35.5
          BGCOLOR 1 FGCOLOR 7 
     " As of Date":30 VIEW-AS TEXT
          SIZE 16 BY .95 AT ROW 10.67 COL 3.5
          BGCOLOR 1 FGCOLOR 7 
     " Client Type Code":50 VIEW-AS TEXT
          SIZE 15 BY .76 TOOLTIP "Client Type Code" AT ROW 3.86 COL 80
          BGCOLOR 1 FGCOLOR 7 
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         NO-LABELS SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 3 ROW 1.52
         SIZE 119 BY 16
         BGCOLOR 3 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME frST
     " Producer Code":40 VIEW-AS TEXT
          SIZE 15 BY .76 TOOLTIP "ตัวแทน" AT ROW 5.19 COL 2
          BGCOLOR 1 FGCOLOR 7 
     RECT-86 AT ROW 9.86 COL 79.5
     RECT1 AT ROW 1 COL 1
     RECT11 AT ROW 5.19 COL 2
     RECT12 AT ROW 3.86 COL 80
     reReprots AT ROW 8.81 COL 2
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         NO-LABELS SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 3 ROW 1.52
         SIZE 119 BY 16
         BGCOLOR 3 .

DEFINE FRAME frOK
     Btn_OK AT ROW 1.95 COL 5.5
     Btn_Cancel AT ROW 3.86 COL 5.5
     RECT2 AT ROW 1.24 COL 2.5
    WITH DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 100.5 ROW 18
         SIZE 21.5 BY 5.39
         BGCOLOR 3 .

DEFINE FRAME frOdue
     raAllbal AT ROW 1 COL 19 NO-LABEL
     towcr AT ROW 2.29 COL 2
     toOdue1 AT ROW 2.29 COL 22
     todamt AT ROW 3.1 COL 2
     toOdue2 AT ROW 3.1 COL 22
     toOdue3 AT ROW 3.86 COL 22
     toOdue4 AT ROW 4.67 COL 22
     toOdue5 AT ROW 5.43 COL 22
     " Bal. Filter    ==>":20 VIEW-AS TEXT
          SIZE 18 BY 1.05 AT ROW 1 COL 1
          BGCOLOR 1 FGCOLOR 15 FONT 6
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         NO-LABELS SIDE-LABELS THREE-D 
         AT COL 54.5 ROW 18
         SIZE 44 BY 5.39
         BGCOLOR 8 .

DEFINE FRAME frOutput
     rsOutput AT ROW 2.05 COL 4 NO-LABEL
     cbPrtList AT ROW 3.33 COL 19 COLON-ALIGNED NO-LABEL
     fiFile-Name AT ROW 4.76 COL 19 COLON-ALIGNED NO-LABEL
     " Output To":40 VIEW-AS TEXT
          SIZE 49 BY .95 TOOLTIP "การแสดงผล" AT ROW 1 COL 1
          BGCOLOR 1 FGCOLOR 15 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE 
         AT COL 3 ROW 18
         SIZE 49 BY 5.39
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
         TITLE              = "wacr0201 - PRINT PREMIUM STATEMENT (A4) FOR AUDIT"
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
       FRAME frOdue:FRAME = FRAME frMain:HANDLE
       FRAME frOK:FRAME = FRAME frMain:HANDLE
       FRAME frOutput:FRAME = FRAME frMain:HANDLE
       FRAME frST:FRAME = FRAME frMain:HANDLE.

/* SETTINGS FOR FRAME DEFAULT-FRAME
   FRAME-NAME                                                           */
/* SETTINGS FOR FRAME frMain
                                                                        */
/* SETTINGS FOR FRAME frOdue
   UNDERLINE                                                            */
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

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE brAcproc_fil
/* Query rebuild information for BROWSE brAcproc_fil
     _TblList          = "sicfn.acproc_fil"
     _FldNameList[1]   > sicfn.acproc_fil.asdat
"acproc_fil.asdat" ? ? "date" ? ? 1 ? ? 1 no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[2]   > sicfn.acproc_fil.type
"acproc_fil.type" "Ty" ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   > "_<CALC>"
"IF (acproc_fil.type = ""01"") THEN (""Monthly"") ELSE (""Daily"")" "Detail" ? ? ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   > sicfn.acproc_fil.entdat
"acproc_fil.entdat" "Process Date" ? "date" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   > sicfn.acproc_fil.enttim
"acproc_fil.enttim" "Time" ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[6]   > "_<CALC>"
"SUBSTRING (acproc_fil.enttim,10,3)" "Sta" "X(1)" ? ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[7]   > sicfn.acproc_fil.trndatfr
"acproc_fil.trndatfr" "TranDate Fr" ? "date" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[8]   > sicfn.acproc_fil.trndatto
"acproc_fil.trndatto" "TranDate To" ? "date" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[9]   > sicfn.acproc_fil.typdesc
"acproc_fil.typdesc" ? "X(60)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _Query            is NOT OPENED
*/  /* BROWSE brAcproc_fil */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* wacr0201 - PRINT PREMIUM STATEMENT (A4) FOR AUDIT */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* wacr0201 - PRINT PREMIUM STATEMENT (A4) FOR AUDIT */
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
ON VALUE-CHANGED OF brAcproc_fil IN FRAME frST
DO:
/*  
    IF NOT CAN-FIND (FIRST docno_fil WHERE poltyp BEGINS "R")THEN DO:
       DISABLE ALL WITH FRAME frDetail.
    END.
    ELSE DO:
      FIND CURRENT docno_fil NO-LOCK.
      RUN ProcDisp IN THIS-PROCEDURE.
    END.
*/

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
DEF VAR vLastTime AS CHAR INIT "".
DEF VAR nv_filter1 AS CHAR INIT "".
DEF VAR nv_filter2 AS CHAR INIT "".

DEF VAR vAcno AS CHAR INIT "".

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
            FRAME frST fityp15 fityp15
            
            FRAME frOutput rsOutput rsOutput
            FRAME frOutput cbPrtList cbPrtList
            FRAME frOutput fiFile-Name fiFile-Name
            
            FRAME frOdue towcr  towcr
            FRAME frOdue todamt  todamt
            FRAME frOdue toodue1  toodue1
            FRAME frOdue toodue2  toodue2
            FRAME frOdue toodue3  toodue3
            FRAME frOdue toodue4  toodue4
            FRAME frOdue toodue5  toodue5

            n_branch    = fiBranch
            n_branch2   = fiBranch2
            n_frac      =  fiAcno1
            n_toac      =  fiAcno2 
            n_asdat     = fiasdat
            vCliCod     = IF seCliCod:List-items = ? THEN vCliCodAll ELSE seCliCod:List-items
            n_OutputTo    =  rsOutput
            n_OutputFile  =  fiFile-Name

            nv_typ1     = fityp1
            nv_typ2     = fityp2
            nv_typ3     = fityp3
            nv_typ4     = fityp4
            nv_typ5     = fityp5
            nv_typ6     = fityp6
            nv_typ7     = fityp7
            nv_typ8     = fityp8
            nv_typ9     = fityp9
            nv_typ10    = fityp10
            nv_typ11    = fityp11
            nv_typ12    = fityp12
            nv_typ13    = fityp13
            nv_typ14    = fityp14
            nv_typ15    = fityp15

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

    ASSIGN
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

    ASSIGN
        nv_filter2 = REPLACE(  vClicod,  ","  , "') OR (agtprm_fil.acno_clicod = '" )
        nv_filter2 = "(agtprm_fil.acno_clicod = '" + nv_filter2  + "')".

            
   END.

   /*--- A500178 ---
   IF  n_frac = "" THEN  n_frac   = "A000000".
   IF  n_toac = "" THEN n_toac = "B999999".
   ------*/
   IF  n_frac = "" THEN  n_frac   = "A000000".
   IF  n_toac = "" THEN n_toac = "B999999999".

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
   IF n_OutputTo = 3 And n_OutputFile = ""    THEN DO:
         Message "กรุณาใส่ชื่อไฟล์" VIEW-AS ALERT-BOX WARNING . 
         Apply "Entry" To  fiFile-Name .
         RETURN NO-APPLY.
   END.

/* kan connect sicfn ---*/
      FIND FIRST dbtable WHERE dbtable.phyname = "form"  OR dbtable.phyname = "sicfn"
                                            NO-LOCK NO-ERROR NO-WAIT.
      IF AVAIL dbtable THEN DO:
          IF dbtable.phyname = "form" THEN DO:
                 ASSIGN
                     nv_User  = "?"
                     nv_pwd = "?".
                     RB-DB-CONNECTION = dbtable.unixpara +  " -U " + nv_user + " -P " + nv_pwd.
          END.
          ELSE DO:
                     RB-DB-CONNECTION = dbtable.unixpara +  " -U " + n_User + " -P " + n_Passwd. /*--A49-0139--*/
          END.
      END.
/*---kan*/

    IF n_asdat = ?   THEN DO:
            MESSAGE "ไม่พบข้อมูล  กรุณาตรวจสอบการ Process ข้อมูล" VIEW-AS ALERT-BOX WARNING.
    END.
    ELSE DO:
        MESSAGE "สาขา                      : "  n_Branch " ถึง " n_Branch2 SKIP(1)
                            "ตัวแทน/นายหน้า  : "  n_frac " ถึง " n_toac  SKIP(1)
                            "ข้อมูลวันที่             : " STRING(n_asdat,"99/99/9999") /*" " vCliCod*/ SKIP(1)
                            "Include Type       : " nv_trntyp1 SKIP(1)
                            "พิมพ์รายงาน        : " cbRptList VIEW-AS ALERT-BOX QUESTION
        BUTTONS YES-NO
        TITLE "Confirm"    UPDATE CHOICE AS LOGICAL.
        CASE CHOICE:
        WHEN TRUE THEN    DO:
            ASSIGN
                    nv_User   =   n_user
                    nv_pwd    =   n_passwd
              report-name  =  cbRptList.

            vFirstTime =  STRING(TIME, "HH:MM AM").
            /******************/
            IF rsOutput = 1 OR  rsOutput = 2 THEN DO:     /* report builder */
            
                IF raReportTyp = 1 OR  raReportTyp = 2 THEN DO:  /* check  client type code */
                    IF raAllbal = 1 THEN   /* All  bal */
                        RB-FILTER    = 'agtprm_fil.asdat = ' + 
                                                    STRING (MONTH (n_asdat)) + "/" + 
                                                    STRING (DAY (n_asdat)) + "/" + 
                                                    STRING (YEAR (n_asdat)) + 
                                                    " AND " + 
                                                    "agtprm_fil.acno >= '" + n_frac + "'" + " AND " + 
                                                    "agtprm_fil.acno <= '" + n_toac + "'" +
                                                    " AND ( " + nv_filter2 + " )" +  " AND " +
                                                    "agtprm_fil.polbran >= '" + n_branch   + "'" + " AND " + 
                                                    "agtprm_fil.polbran <= '" + n_branch2 + "'" +
                                                    " AND ( " + nv_filter1 + " )"
                                                    .
                    ELSE
                        RB-FILTER    = 'agtprm_fil.asdat = ' + 
                                                    STRING (MONTH (n_asdat)) + "/" + 
                                                    STRING (DAY (n_asdat)) + "/" + 
                                                    STRING (YEAR (n_asdat)) + 
                                                    " AND " + 
                                                    "agtprm_fil.acno >= '" + n_frac + "'" + " AND " + 
                                                    "agtprm_fil.acno <= '" + n_toac + "'" +
                                                    " AND ( " + nv_filter2 + " )" +  " AND " +
                                                    "agtprm_fil.polbran >= '" + n_branch   + "'" + " AND " + 
                                                    "agtprm_fil.polbran <= '" + n_branch2 + "'" +
                                                    " AND ( " + nv_filter1 + " )"
                                                    /* A47-0159 ---*/
                                                    + " AND  ( " 
                                                    + " ( (agtprm_fil.wcr NE 0 )  AND  "  +  STRING(towcr)  + "  =  TRUE ) "  
                                                    + " OR ( (agtprm_fil.damt   NE 0 ) AND  "  +  STRING(todamt) + "  =  TRUE ) "  
                                                    + " OR ( (agtprm_fil.odue1 NE 0 ) AND "  +  STRING(toodue1) + "  =  TRUE ) "  
                                                    + " OR ( (agtprm_fil.odue2 NE 0 ) AND "  +  STRING(toodue2) + "  =  TRUE ) "  
                                                    + " OR ( (agtprm_fil.odue3 NE 0 ) AND "  +  STRING(toodue3) + "  =  TRUE ) "  
                                                    + " OR ( (agtprm_fil.odue4 NE 0 ) AND "  +  STRING(toodue4) + "  =  TRUE ) "  
                                                    + " OR ( (agtprm_fil.odue5 NE 0 ) AND "  +  STRING(toodue5) + "  =  TRUE ) "  
                                                    + ")"
                                                    /*--- A47-0159 */
                                                    .
                END.
                ELSE DO:                                                                                   /* all client type code */
                    IF raAllbal = 1 THEN   /* All  bal */
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
                                                    " AND ( " + nv_filter1 + " )"
                        .
                    ELSE
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
                                                    " AND ( " + nv_filter1 + " )"
                                                    /* A47-0159 ---*/
                                                    + " AND  ( " 
                                                    + " ( (agtprm_fil.wcr NE 0 )  AND  "  +  STRING(towcr)  + "  =  TRUE ) "  
                                                    + " OR ( (agtprm_fil.damt   NE 0 ) AND  "  +  STRING(todamt) + "  =  TRUE ) "  
                                                    + " OR ( (agtprm_fil.odue1 NE 0 ) AND "  +  STRING(toodue1) + "  =  TRUE ) "  
                                                    + " OR ( (agtprm_fil.odue2 NE 0 ) AND "  +  STRING(toodue2) + "  =  TRUE ) "  
                                                    + " OR ( (agtprm_fil.odue3 NE 0 ) AND "  +  STRING(toodue3) + "  =  TRUE ) "  
                                                    + " OR ( (agtprm_fil.odue4 NE 0 ) AND "  +  STRING(toodue4) + "  =  TRUE ) "  
                                                    + " OR ( (agtprm_fil.odue5 NE 0 ) AND "  +  STRING(toodue5) + "  =  TRUE ) "  
                                                    + ")"
                                                    /*--- A47-0159 */
                                                    .
                                                
                END.
        
                ASSIGN
                    /* RB-DB-CONNECTION  = "-H alpha4 -S stat" +  " -U " + nv_user + " -P " + nv_pwd */
                     /*RB-DB-CONNECTION  = "-H brpy -S stattest" +  " -U " + nv_user + " -P " + nv_pwd */
                    
                    RB-INCLUDE-RECORDS = "O"
    
                    RB-PRINT-DESTINATION = SUBSTR ("D A", rsOutput, 1)
                    RB-PRINTER-NAME   = IF rsOutput = 2 THEN cbPrtList ELSE " "
                    RB-OUTPUT-FILE       = IF rsOutput = 3 THEN fiFile-Name ELSE " "
                    RB-NO-WAIT               = No
                    RB-OTHER-PARAMETERS =  "rb_vCliCod     = " + STRING(vCliCod) + CHR(10) +  
                                           "rb_n_trndatto  = " + STRING(n_trndatto,"99/99/9999") + CHR(10) +
                                           "rb_pich        = " + nv_a4a_07 . /*ADD Saharat S. A62-0279*/
                IF rsOutput = 1 OR rsOutput = 2 THEN DO:
                    ASSIGN
                        report-library = "wAC/wprl/wac_sm01A.prl"
                        report-name  = cbRptList.

                    RUN pdRunRB.
                END.
            END.
            ELSE IF rsOutput = 3 THEN DO:
            /* report-bulider 
                ASSIGN
                    report-library = "wAC/wprl/wac_sm04.prl"
                    report-name  = "Statement By Trandate to Excel".
                RUN pdRunRB.
            */
                    RUN pdExportAudit.
            END.


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

/*****************/

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


&Scoped-define SELF-NAME buAdd
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buAdd C-Win
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


&Scoped-define SELF-NAME buClicod
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buClicod C-Win
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
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buDel C-Win
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
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cbRptList C-Win
ON RETURN OF cbRptList IN FRAME frST
DO:
    APPLY "ENTRY" TO fiTyp1 IN FRAME frST.
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


&Scoped-define SELF-NAME fiBranch
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiBranch C-Win
ON LEAVE OF fiBranch IN FRAME frST
DO:
  Assign
         fibranch = input fibranch
         n_branch = fibranch.

    DISP CAPS(fibranch) @ fibranch WITH FRAME frST.
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
     Assign
         fibranch2 = input fibranch2
         n_branch2  = fibranch2.
    DISP CAPS(fibranch2)@ fibranch2 WITH FRAME frST.         
             
     Apply "Entry" To fiAcno1.           
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


&Scoped-define SELF-NAME fiCcode1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiCcode1 C-Win
ON LEAVE OF fiCcode1 IN FRAME frST
DO:
    ASSIGN fiCcode1.
    DISP CAPS (fiCcode1) @ fiCcode1 WITH FRAME frST.

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


&Scoped-define FRAME-NAME frOdue
&Scoped-define SELF-NAME raAllbal
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL raAllbal C-Win
ON VALUE-CHANGED OF raAllbal IN FRAME frOdue
DO:
  
DO WITH FRAME frOdue.

    raAllbal  = INPUT raAllbal .
    
    IF raAllbal = 1 THEN  DO:   /* all  bal */
        ASSIGN
            towcr = FALSE
            todamt = FALSE
            toodue1 = FALSE
            toodue2 = FALSE
            toodue3 = FALSE
            toodue4 = FALSE
            toodue5 = FALSE
            .

        DISPLAY towcr  todamt toOdue1  toOdue2  toOdue3  toOdue4  toOdue5.
        
        DISABLE ALL EXCEPT raAllbal   .
    END.
    ELSE DO:                            /* partial bal */
        ENABLE ALL  WITH FRAME frOdue .

    END.

END.
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frST
&Scoped-define SELF-NAME raReportTyp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL raReportTyp C-Win
ON RETURN OF raReportTyp IN FRAME frST
DO:
      APPLY "ENTRY" TO seClicod IN FRAME frST.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL raReportTyp C-Win
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
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL rsOutput C-Win
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


&Scoped-define FRAME-NAME frOdue
&Scoped-define SELF-NAME todamt
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL todamt C-Win
ON VALUE-CHANGED OF todamt IN FRAME frOdue /* Due Amount */
DO:
  
    todamt = INPUT todamt.
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME toOdue1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL toOdue1 C-Win
ON VALUE-CHANGED OF toOdue1 IN FRAME frOdue /* Over due 1-3 m */
DO:
  
    toOdue1 = INPUT toOdue1.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME toOdue2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL toOdue2 C-Win
ON VALUE-CHANGED OF toOdue2 IN FRAME frOdue /* Over due 3-6 m */
DO:
  
    toOdue2 = INPUT toOdue2.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME toOdue3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL toOdue3 C-Win
ON VALUE-CHANGED OF toOdue3 IN FRAME frOdue /* Over due 6-9 m */
DO:
  
    toOdue3 = INPUT toOdue3.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME toOdue4
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL toOdue4 C-Win
ON VALUE-CHANGED OF toOdue4 IN FRAME frOdue /* Over due 9-12 m */
DO:

    toOdue4 = INPUT toOdue4.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME toOdue5
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL toOdue5 C-Win
ON VALUE-CHANGED OF toOdue5 IN FRAME frOdue /* Over 12 m */
DO:

    toOdue5 = INPUT toOdue5.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME towcr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL towcr C-Win
ON VALUE-CHANGED OF towcr IN FRAME frOdue /* With In Credit */
DO:

  towcr = INPUT towcr.
  
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
  
  gv_prgid = "wacr0201".
  gv_prog  = "PRINT STATEMENT A4 FOR  AUDIT".
  RUN  WUT\WUTHEAD (c-win:handle,gv_prgid,gv_prog).

/*********************************************************************/  

 
  CURRENT-WINDOW:WINDOW-STATE = WINDOW-MAXIMIZED.  
/*    RUN Wut\Wutwicen.p (C-Win:HANDLE).*/

  SESSION:DATA-ENTRY-RETURN = YES.
  
    DO WITH FRAME frST :
        /*reY:MOVE-TO-TOP() .
         *     reZ:MOVE-TO-TOP() .*/
          
        APPLY "ENTRY" TO fiBranch IN FRAME frST.
        
        RUN ProcGetRptList.
        RUN ProcGetPrtList.  
        
           ASSIGN   
                fiacno1    = ""
                fiacno2    = ""
                fiAsdat  = ?
                raReportTyp = 3
                
                fiInclude =  nv_Trntyp1
                fityp1 = "M"
                fityp2 = "R"
                fityp3 = "A"
                fityp4 = "B"
                fityp5 = "Y"
                fityp6 = "Z".
                
/*                fityp2 = "C"
 *                 fityp3 = "O"
 *                 fityp4 = "T".*/
                
            DISPLAY  fiacno1 fiacno2 fiasdat raReportTyp
                            fiInclude   fityp1 fityp2 fityp3 fityp4 fityp5 fityp6.
        
        RUN pdInitData.  
        RUN pdSym100.
        RUN pdUpdateQ.
        RUN pdClicod.

        APPLY "CHOOSE" TO raReportTyp.
    END.    
    DO WITH FRAME frTranDate:
         ASSIGN  
           rsOutput:Radio-Buttons = "Screen, 1,Printer, 2,File, 3" /*"หน้าจอ, 1,เครื่องพิมพ์, 2, File, 3" */
           rsOutput = 3
            
           cbPrtList:SENSITIVE    = NO
           fiFile-Name:SENSITIVE  = YES.
        DISPLAY rsOutput WITH FRAME frOutput .    
          
/*          RUN pdAcProc_fil.*/
    END.
    
    DO WITH FRAME frOdue :
        raAllbal = 1.
        DISABLE ALL EXCEPT raAllbal  WITH FRAME frOdue .
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
  ENABLE IMAGE-23 
      WITH FRAME frMain IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-frMain}
  DISPLAY fiBranch fiBranch2 fiacno1 fiacno2 raReportTyp fiTyp1 fiTyp2 fiTyp3 
          fiTyp4 fiTyp5 fiTyp6 fiTyp7 fiTyp8 fiTyp9 fiTyp10 fiTyp11 fiTyp12 
          fiTyp13 fiTyp14 fiTyp15 seCliCod fiCcode1 cbRptList fibdes fibdes2 
          finame1 finame2 fiInclude fiAsdat fiProcessDate fiProcess 
      WITH FRAME frST IN WINDOW C-Win.
  ENABLE fiBranch fiBranch2 fiacno1 fiacno2 raReportTyp fiTyp1 fiTyp2 fiTyp3 
         fiTyp4 fiTyp5 fiTyp6 fiTyp7 fiTyp8 fiTyp9 fiTyp10 fiTyp11 fiTyp12 
         fiTyp13 fiTyp14 fiTyp15 buBranch buBranch2 seCliCod buAcno1 buAcno2 
         fiCcode1 buClicod buAdd buDel cbRptList brAcproc_fil fibdes fibdes2 
         finame1 finame2 fiInclude fiAsdat fiProcessDate fiProcess RECT-86 
         RECT1 RECT11 RECT12 reReprots 
      WITH FRAME frST IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-frST}
  DISPLAY rsOutput cbPrtList fiFile-Name 
      WITH FRAME frOutput IN WINDOW C-Win.
  ENABLE rsOutput cbPrtList fiFile-Name 
      WITH FRAME frOutput IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-frOutput}
  DISPLAY raAllbal towcr toOdue1 todamt toOdue2 toOdue3 toOdue4 toOdue5 
      WITH FRAME frOdue IN WINDOW C-Win.
  ENABLE raAllbal towcr toOdue1 todamt toOdue2 toOdue3 toOdue4 toOdue5 
      WITH FRAME frOdue IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-frOdue}
  ENABLE RECT2 Btn_OK Btn_Cancel 
      WITH FRAME frOK IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-frOK}
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
/*
  ASSIGN
    nv_ProcessDate = ?
    vAcProc_fil = "" .
  FOR EACH AcProc_fil USE-INDEX by_type_asdat  
                                        WHERE (acproc_fil.type   = "01" OR acproc_fil.type   = "05")
                                        BY asdat DESC  :
        ASSIGN
            vAcProc_fil = vAcProc_fil + STRING( AcProc_fil.asdat,"99/99/9999")  + ",".
  END.

  ASSIGN
    cbAsDat:List-Items IN FRAME frST = vAcProc_fil
    cbAsDat = ENTRY (1, vAcProc_fil).
    
    FIND LAST acproc_fil WHERE (acproc_fil.type   = "01" OR acproc_fil.type   = "05") AND
                                                         acproc_fil.asdat = DATE(cbAsdat)   NO-LOCK NO-ERROR.
    IF AVAIL acproc_fil THEN DO:
        ASSIGN
            n_trndatto   = AcProc_fil.trndatto
            nv_ProcessDate = acproc_fil.entdat.
    END.
        

    fiProcessDate = nv_ProcessDate.

  DISP cbAsDat fiProcessDate  WITH FRAME frST .
*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdClicod C-Win 
PROCEDURE pdClicod :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR  i AS INT INIT 1.
/*message "(" + vClicod + ")" view-as alert-box.*/

DO WITH FRAME frST:
        seCliCod:DELETE("AG,AM,BD,BM,BR,PS,RS,ST,DI,DE,FI,FN,OT,").
        seCliCod = seCliCod:SCREEN-VALUE .

    IF raReportTyp = 1 THEN DO:
        vClicod = "AG,AM,BD,BM,BR,PS,RS,ST,OT".
        seCliCod:ADD-FIRST(vClicod).
        seCliCod = seCliCod:SCREEN-VALUE .
    END.
    ELSE IF raReportTyp = 2 THEN DO:
        vClicod = "DE,FI,FN,DI".
        seCliCod:ADD-FIRST(vClicod).
        seCliCod = seCliCod:SCREEN-VALUE .
    END.
    ELSE DO:
        vClicod = "".
        seCliCod:ADD-FIRST(vClicod).
        seCliCod = seCliCod:SCREEN-VALUE .
    END.

END. /**/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdExportAudit C-Win 
PROCEDURE pdExportAudit :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

DEF VAR  vCount AS INT INIT 0.
DEF VAR  i AS INT.

    ASSIGN
        nv_gtot_prem      = 0
        nv_gtot_prem_comp = 0
        nv_gtot_stamp     = 0
        nv_gtot_tax       = 0
        nv_gtot_gross     = 0
        nv_gtot_comm      = 0
        nv_gtot_comm_comp = 0
        nv_gtot_net       = 0
        nv_gtot_bal       = 0

        nv_gtot_wcr       = 0
        nv_gtot_damt      = 0
        nv_gtot_odue      = 0

        nv_gtot_odue1     = 0
        nv_gtot_odue2     = 0
        nv_gtot_odue3     = 0
        nv_gtot_odue4     = 0
        nv_gtot_odue5     = 0.
        
/*        IF rsOutput = 3 THEN fiFile-Name = fiFile-Name.
 *                                   ELSE fiFile-Name = fiFile-Name2.*/

        
/********************** Page Header *********************/           
        OUTPUT TO VALUE (STRING(fiFile-Name) ) APPEND NO-ECHO.
            IF vCount = 0 THEN DO:
                EXPORT DELIMITER ";"
                    "asdate"
                    n_asdat
                    "wacr0201.w - Statement to excel file - Audit"  /* "Statement A4 Reports By Acno"  */
                    "" "" ""
                    "Include Type : " +  nv_trntyp1.

/*                EXPORT DELIMITER ";"
 *                     "รหัสตัวแทน"    "ชื่อ" "เครดิต" "วันที่  " "วันครบกำหนด" "เลขที่ใบแจ้งหนี้ " "กรมธรรม์" "สลักหลัง" "วันเริ่มคุ้มครอง" /* "ชื่อผู้เอาประกัน " */
 *                     "เบี้ยประกัน"  "พ.ร.บ. "   "อากร"  "ภาษี"   "รวม"  "ค่านายหน้า"  "ค่านายหน้า พรบ." "ยอดค้างชำระ"  
 *                     "ยอดไม่ครบกำหนด" "ครบกำหนด" "ค้าง 1-3 เดือน "  "ค้าง 3-6 เดือน"  "ค้าง 6-9 เดือน"   "ค้าง 9-12 เดือน"  "ค้าง เกิน 12 เดือน".*/
                    
                EXPORT DELIMITER ";"
                     "Account No."  "Name  " "Branch" "Credit"  "Tran Date" "Duedate" " Invoice No."  " Policy No."  " Endt No."  "Com. Date " "Exp. Date"/* " Insured Name "  */
                     " Premium  "  " Compulsory"  " Stamp"  "Tax"  "Total"  "Comm"  " Comm_Comp" "Net amount"  "Balance (Baht)"  
                     " within"  "due amount "  "overdue"  "1 - 3 months"  "3 - 6 months"  "6 - 9 months"  " 9 - 12 months"  "over 12 months".
            END.
        OUTPUT CLOSE.
/********************** END Page Header *********************/  
    IF raReportTyp = 1 OR  raReportTyp = 2 THEN DO:  /* check  client type code */
        DO WITH FRAME frOdue:
        
            IF raAllbal = 1 THEN   /* All  bal */
                FOR EACH  agtprm_fil USE-INDEX by_acno            WHERE /* บางส่วน  client type code*/
                        agtprm_fil.asdat       = n_asdat  AND
                       (agtprm_fil.acno      >= n_frac    AND agtprm_fil.acno     <= n_toac  )      AND
                       (agtprm_fil.polbran >= n_branch AND agtprm_fil.polbran <= n_branch2 ) AND
                       ( LOOKUP (SUBSTRING(agtprm_fil.trntyp,1,1) , nv_trntyp1) <> 0 ) AND
                       ( LOOKUP (agtprm_fil.acno_clicod, vCliCod) <> 0 )
                NO-LOCK BREAK BY agtprm_fil.acno
                                             BY agtprm_fil.trndat
                                             BY agtprm_fil.policy
                                             BY agtprm_fil.endno.
                  DISP  agtprm_fil.acno
                             agtprm_fil.policy
                             agtprm_fil.trntyp
                             agtprm_fil.docno
                  WITH COLOR BLACK/WHITE NO-LABEL FRAME frProcess11 VIEW-AS DIALOG-BOX
                  TITLE  "  Processing ...".
          
                  {wac\wacr0201.i}
          
                END. /* for each agtprm_fil*/

           ELSE                             /* choose  bal*/
                FOR EACH  agtprm_fil USE-INDEX by_acno            WHERE /* บางส่วน client type code*/
                        agtprm_fil.asdat       = n_asdat  AND
                       (agtprm_fil.acno      >= n_frac    AND agtprm_fil.acno     <= n_toac  )      AND
                       (agtprm_fil.polbran >= n_branch AND agtprm_fil.polbran <= n_branch2 ) AND
                       ( LOOKUP (SUBSTRING(agtprm_fil.trntyp,1,1) , nv_trntyp1) <> 0 ) AND
                       ( LOOKUP (agtprm_fil.acno_clicod, vCliCod) <> 0 )
                         /* A47-0159 */
                         AND (   
                                          ( (agtprm_fil.wcr NE 0) AND towcr = TRUE )
                                    OR ( (agtprm_fil.damt NE 0) AND todamt = TRUE )
                                    OR ( (agtprm_fil.odue1 NE 0) AND toodue1 = TRUE )
                                    OR ( (agtprm_fil.odue2 NE 0) AND toodue2 = TRUE )
                                    OR ( (agtprm_fil.odue3 NE 0) AND toodue3 = TRUE )
                                    OR ( (agtprm_fil.odue4 NE 0) AND toodue4 = TRUE )
                                    OR ( (agtprm_fil.odue5 NE 0) AND toodue5 = TRUE )
                                    
                                    )
                NO-LOCK BREAK BY agtprm_fil.acno
                                             BY agtprm_fil.trndat
                                             BY agtprm_fil.policy
                                             BY agtprm_fil.endno.
                  DISP  agtprm_fil.acno
                             agtprm_fil.policy
                             agtprm_fil.trntyp
                             agtprm_fil.docno
                  WITH COLOR BLACK/WHITE NO-LABEL FRAME frProcess12 VIEW-AS DIALOG-BOX
                  TITLE  "  Processing ...".
          
                  {wac\wacr0201.i}
          
                END. /* for each agtprm_fil*/
        END. /* DO WITH FRAME frOdue*/

    END.
    ELSE DO:                                                                                   /* all client type code */
        DO WITH FRAME frOdue:
        
            IF raAllbal = 1 THEN   /* All  bal  */
                FOR EACH  agtprm_fil USE-INDEX by_acno            WHERE /* ทั้งหมด ทุก client type code*/
                          agtprm_fil.asdat       = n_asdat   AND
                         (agtprm_fil.acno      >= n_frac    AND agtprm_fil.acno     <= n_toac  )      AND
                         (agtprm_fil.polbran >= n_branch AND agtprm_fil.polbran <= n_branch2 ) AND
                         ( LOOKUP (SUBSTRING(agtprm_fil.trntyp,1,1) , nv_trntyp1) <> 0 ) 
                NO-LOCK BREAK BY agtprm_fil.acno
                                               BY agtprm_fil.trndat
                                               BY agtprm_fil.policy
                                               BY agtprm_fil.endno.
        
                    DISP  agtprm_fil.acno
                               agtprm_fil.policy
                               agtprm_fil.trntyp
                               agtprm_fil.docno
                    WITH COLOR BLACK/WHITE NO-LABEL FRAME frProcess21 VIEW-AS DIALOG-BOX
                    TITLE  "  Processing ...".
                
                    {wac\wacr0201.i}
                          
                END. /* for each agtprm_fil*/

           ELSE                             /* choose  bal*/
                FOR EACH  agtprm_fil USE-INDEX by_acno            WHERE /* ทั้งหมด ทุก client type code*/
                          agtprm_fil.asdat       = n_asdat   AND
                         (agtprm_fil.acno      >= n_frac    AND agtprm_fil.acno     <= n_toac  )      AND
                         (agtprm_fil.polbran >= n_branch AND agtprm_fil.polbran <= n_branch2 ) AND
                         ( LOOKUP (SUBSTRING(agtprm_fil.trntyp,1,1) , nv_trntyp1) <> 0 ) 
                         /* A47-0159 */
                         AND (
                                          ( (agtprm_fil.wcr NE 0) AND towcr = TRUE )
                                    OR ( (agtprm_fil.damt NE 0) AND todamt = TRUE )
                                    OR ( (agtprm_fil.odue1 NE 0) AND toodue1 = TRUE )
                                    OR ( (agtprm_fil.odue2 NE 0) AND toodue2 = TRUE )
                                    OR ( (agtprm_fil.odue3 NE 0) AND toodue3 = TRUE )
                                    OR ( (agtprm_fil.odue4 NE 0) AND toodue4 = TRUE )
                                    OR ( (agtprm_fil.odue5 NE 0) AND toodue5 = TRUE )
                                    
                                    )
                         
                NO-LOCK BREAK BY agtprm_fil.acno
                                               BY agtprm_fil.trndat
                                               BY agtprm_fil.policy
                                               BY agtprm_fil.endno.
        
                    DISP  agtprm_fil.acno
                               agtprm_fil.policy
                               agtprm_fil.trntyp
                               agtprm_fil.docno
                    WITH COLOR BLACK/WHITE NO-LABEL FRAME frProcess22 VIEW-AS DIALOG-BOX
                    TITLE  "  Processing ...".
                
                    {wac\wacr0201.i}
                          
                END. /* for each agtprm_fil*/
        
        END. /* DO WITH FRAME frOdue*/
        
    END.

/********************** Page Footer *********************/
        OUTPUT TO VALUE (STRING(fiFile-Name) ) APPEND NO-ECHO.
                EXPORT DELIMITER ";"
                    "".
                EXPORT DELIMITER ";"
                    "GRAND TOTAL : "
                    " "    " "   " "     " " 
                    " "    " "    " "   " "   " "  " "
                    nv_gtot_prem
                    nv_gtot_prem_comp
                    nv_gtot_stamp
                    nv_gtot_tax
                    nv_gtot_gross
                    nv_gtot_comm
                    nv_gtot_comm_comp
                    nv_gtot_net
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
/********************** Page Footer *********************/
                  
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdOldOK C-Win 
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdRunRB C-Win 
PROCEDURE pdRunRB :
/*------------------------------------------------------------------------------
  Purpose:     
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdSym100 C-Win 
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
  
/*     message  "cbRptList" report-library  skip (1) 
 *                  cbRptList view-as alert-box.*/
 
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fuMaxday C-Win 
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

