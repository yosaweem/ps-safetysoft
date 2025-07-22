&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          stat             PROGRESS
*/
&Scoped-define WINDOW-NAME WGWCODEL
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS WGWCODEL 
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
/*          This .W file was created with the Progress AppBuilder.      */
/*----------------------------------------------------------------------*/

/* Create an unnamed pool to store all the widgets created 
     by this procedure. This is a good default which assures
     that this procedure's triggers and internal procedures 
     will execute in this procedure's storage, and that proper
     cleanup will occur on deletion of the procedure. */
/*Modify by   : Kridtiya i.A53-0182 เพิ่มตัวเก็บ code producer,agent code 
              ตรวจสอบที่ table xmm600 ถ้าไม่พบไม่ให้เก็บค่า แสดงเป็นค่าว่าง */
/*Modify by   : Kridtiya i.A53-0232 ขยายการเช็คชื่อบริษัทจากเดิม ไม่เกิน 3 ตัว
              ปรับเป็น 10 ตัวอักษร                                          */
/*modify by Kridtiya i. A53-0351 date. 11/11/2010  ปรับการแสดงค่าเนื่องจากเพิ่ม format file new
                        เพิ่ม แถวสุดท้าย "อุปกรณ์เสริม"                                       */
/*modify by :  Kridtiya i. A57-0396 date .03/11/2014 ปรับขยายช่อง การแสดงแต่ละคอลัมให้แสดงข้อมูลครบ */   
/*modify by :  Kridtiya i. A57-0434 date .28/11/2014 ปรับขยายช่อง การแสดงแต่ละคอลัมให้แสดงข้อมูลครบ */ 
/*modify By :  Ranu i. A60-0261 date 09/06/2017 เพิ่มปุ่ม import นำเข้าข้อมูลจากไฟล์*/
                    
CREATE WIDGET-POOL.

/* ***************************  Definitions  ************************** */

/* Parameters Definitions ---                                           */

/* Local Variable Definitions ---                                       */

/*{wuw/wuwm0001.i}*/

DEF SHARED VAR n_User     AS CHAR.
DEF SHARED VAR n_Passwd   AS CHAR.

DEF VAR    cUpdate AS CHAR.
DEF BUFFER bComp   FOR Company.
DEF VAR nv_progname AS CHAR.
DEF VAR nv_objname AS CHAR.

DEF VAR nv_StrEnd AS CHAR.
DEF VAR nv_Str AS CHAR.
DEF VAR nv_NextPolflg AS INT.
DEF VAR nv_RenewPolflg AS INT.

DEF VAR nv_PrePol  AS CHAR.
DEF VAR pComp AS CHAR.
DEF VAR pRowIns AS ROWID.

DEF NEW SHARED VAR gUser   AS CHAR.
DEF NEW SHARED VAR gPasswd AS CHAR.
DEF VAR gComp   AS CHAR.
/* gComp = "5". */

DEF NEW SHARED VAR gRecMod   AS Recid.
DEF NEW SHARED VAR gRecBen   AS Recid.
DEF NEW SHARED VAR gRecIns     AS Recid.

DEF VAR n_InsNo         AS INT.
DEFINE   WORKFILE wdetail 
    FIELD  Company     AS CHAR FORMAT "x(20)" INIT ""   
    FIELD  Delerno     AS CHAR FORMAT "x(15)" INIT ""                               
    FIELD  Deler_Name  AS CHAR FORMAT "x(80)" INIT ""                               
    FIELD  Show_room   AS CHAR FORMAT "x(30)" INIT ""                               
    FIELD  Vatcode     AS CHAR FORMAT "x(10)" INIT ""                               
    FIELD  Branch      AS CHAR FORMAT "x(2)"  INIT ""
    FIELD  nSTATUS      AS CHAR FORMAT "x(35)" INIT ""    
    FIELD  Producer    AS CHAR FORMAT "x(30)" INIT ""   
    FIELD  Agent       AS CHAR FORMAT "x(30)" INIT ""    
    FIELD  addr4       AS CHAR FORMAT "x(35)" INIT ""   
    FIELD  Tel         AS CHAR FORMAT "x(20)" INIT "" . 

DEF VAR Company    AS CHAR FORMAT "x(20)" INIT "".  
DEF VAR Delerno    AS CHAR FORMAT "x(15)" INIT "".                           
DEF VAR Deler_Name AS CHAR FORMAT "x(80)" INIT "".                           
DEF VAR Show_room  AS CHAR FORMAT "x(30)" INIT "".                             
DEF VAR Vatcode    AS CHAR FORMAT "x(10)" INIT "".                             
DEF VAR Branch     AS CHAR FORMAT "x(2)"  INIT "".
DEF VAR nSTATUS     AS CHAR FORMAT "x(35)" INIT "".
DEF VAR Producer   AS CHAR FORMAT "x(30)" INIT "".   
DEF VAR Agent      AS CHAR FORMAT "x(30)" INIT "".  
DEF VAR addr4      AS CHAR FORMAT "x(35)" INIT "".   
DEF VAR Tel        AS CHAR FORMAT "x(20)" INIT "".

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME frbrIns
&Scoped-define BROWSE-NAME brInsure

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES Insure

/* Definitions for BROWSE brInsure                                      */
&Scoped-define FIELDS-IN-QUERY-brInsure Insure.CompNo Insure.InsNo ~
Insure.VatCode Insure.FName Insure.LName Insure.Branch Insure.Addr3 
&Scoped-define ENABLED-FIELDS-IN-QUERY-brInsure 
&Scoped-define QUERY-STRING-brInsure FOR EACH Insure NO-LOCK ~
    BY Insure.InsNo
&Scoped-define OPEN-QUERY-brInsure OPEN QUERY brInsure FOR EACH Insure NO-LOCK ~
    BY Insure.InsNo.
&Scoped-define TABLES-IN-QUERY-brInsure Insure
&Scoped-define FIRST-TABLE-IN-QUERY-brInsure Insure


/* Definitions for FRAME frbrIns                                        */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS RECT-456 RECT-457 RECT-458 brInsure bu_file ~
bu_imp bu_imp-6 fi_output bu_exit 
&Scoped-Define DISPLAYED-OBJECTS fi_output 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR WGWCODEL AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bu_exit 
     LABEL "EXIT" 
     SIZE 7.5 BY 1.

DEFINE BUTTON bu_file 
     LABEL "..." 
     SIZE 3.5 BY 1.1.

DEFINE BUTTON bu_imp 
     LABEL "IMPORT" 
     SIZE 10 BY 1
     FONT 6.

DEFINE BUTTON bu_imp-6 
     LABEL "EXPORT" 
     SIZE 10 BY 1.

DEFINE VARIABLE fi_output AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 55.33 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-456
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 10.5 BY 1.67
     BGCOLOR 6 .

DEFINE RECTANGLE RECT-457
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 11.83 BY 1.43
     BGCOLOR 4 .

DEFINE RECTANGLE RECT-458
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 11.83 BY 1.43
     BGCOLOR 2 FGCOLOR 0 .

DEFINE BUTTON btncompadd 
     LABEL "เพิ่ม" 
     SIZE 11 BY 1
     FONT 6.

DEFINE BUTTON btncompdel 
     LABEL "ลบ" 
     SIZE 11 BY 1
     FONT 6.

DEFINE BUTTON btncompfirst 
     IMAGE-UP FILE "adeicon\pvfirst":U
     IMAGE-DOWN FILE "adeicon\pvfirstd":U
     IMAGE-INSENSITIVE FILE "adeicon\pvfirstx":U
     LABEL "<<" 
     SIZE 5.5 BY .95.

DEFINE BUTTON btncomplast 
     IMAGE-UP FILE "adeicon\pvlast":U
     IMAGE-DOWN FILE "adeicon\pvlastd":U
     IMAGE-INSENSITIVE FILE "adeicon\pvlastx":U
     LABEL ">>" 
     SIZE 5.5 BY .95.

DEFINE BUTTON btncompnext 
     IMAGE-UP FILE "adeicon\pvforw":U
     IMAGE-DOWN FILE "adeicon\pvforwd":U
     IMAGE-INSENSITIVE FILE "adeicon\pvforwx":U
     LABEL ">" 
     SIZE 6 BY .95.

DEFINE BUTTON btncompok 
     LABEL "OK" 
     SIZE 11 BY 1
     FONT 6.

DEFINE BUTTON btncompprev 
     IMAGE-UP FILE "adeicon\pvback":U
     IMAGE-DOWN FILE "adeicon\pvbackd":U
     IMAGE-INSENSITIVE FILE "adeicon\pvbackx":U
     LABEL "<" 
     SIZE 5.5 BY .95.

DEFINE BUTTON btncompreset 
     LABEL "Cancel" 
     SIZE 11 BY 1
     FONT 6.

DEFINE BUTTON btncompupd 
     LABEL "แก้ไข" 
     SIZE 11 BY 1
     FONT 6.

DEFINE VARIABLE fiabname AS CHARACTER FORMAT "X(5)":U 
     VIEW-AS FILL-IN 
     SIZE 8.5 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiAddr1 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 50 BY .95
     BGCOLOR 15 FONT 1 NO-UNDO.

DEFINE VARIABLE fiAddr2 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 50 BY .95
     BGCOLOR 15 FONT 1 NO-UNDO.

DEFINE VARIABLE fiAddr3 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 50 BY .95
     BGCOLOR 15 FONT 1 NO-UNDO.

DEFINE VARIABLE fiAddr4 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 22.67 BY .95
     BGCOLOR 15 FONT 1 NO-UNDO.

DEFINE VARIABLE fibranch AS CHARACTER FORMAT "X(3)":U 
     VIEW-AS FILL-IN 
     SIZE 5 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiCompNo AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 21 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiName AS CHARACTER FORMAT "X(60)":U 
     VIEW-AS FILL-IN 
     SIZE 50 BY .95
     BGCOLOR 15 FONT 1 NO-UNDO.

DEFINE VARIABLE fiName2 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 50 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fiTelNo AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 17.83 BY .95
     BGCOLOR 15 FONT 1 NO-UNDO.

DEFINE RECTANGLE RECT-17
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 37 BY 1.62
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-18
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 25.5 BY 1.62
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-455
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 63 BY 9.

DEFINE RECTANGLE RECT-82
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 24.83 BY 1.62
     BGCOLOR 1 .

DEFINE BUTTON btnFirst 
     IMAGE-UP FILE "adeicon\pvfirst":U
     IMAGE-DOWN FILE "adeicon\pvfirstd":U
     IMAGE-INSENSITIVE FILE "adeicon\pvfirstx":U
     LABEL "<<" 
     SIZE 5.5 BY .95.

DEFINE BUTTON btninadd 
     LABEL "เพิ่ม" 
     SIZE 11 BY 1
     FONT 6.

DEFINE BUTTON btnInCancel 
     LABEL "Cancel" 
     SIZE 11 BY 1
     FONT 6.

DEFINE BUTTON btnInDelete 
     LABEL "ลบ" 
     SIZE 11 BY 1
     FONT 6.

DEFINE BUTTON btnInOK 
     LABEL "OK" 
     SIZE 11 BY 1
     FONT 6.

DEFINE BUTTON btnInUpdate 
     LABEL "แก้ไข" 
     SIZE 11 BY 1
     FONT 6.

DEFINE BUTTON btnLast 
     IMAGE-UP FILE "adeicon\pvlast":U
     IMAGE-DOWN FILE "adeicon\pvlastd":U
     IMAGE-INSENSITIVE FILE "adeicon\pvlastx":U
     LABEL ">>" 
     SIZE 5.5 BY .95.

DEFINE BUTTON btnNext 
     IMAGE-UP FILE "adeicon\pvforw":U
     IMAGE-DOWN FILE "adeicon\pvforwd":U
     IMAGE-INSENSITIVE FILE "adeicon\pvforwx":U
     LABEL ">" 
     SIZE 6 BY .95.

DEFINE BUTTON btnPrev 
     IMAGE-UP FILE "adeicon\pvback":U
     IMAGE-DOWN FILE "adeicon\pvbackd":U
     IMAGE-INSENSITIVE FILE "adeicon\pvbackx":U
     LABEL "<" 
     SIZE 5.5 BY .95.

DEFINE BUTTON bu_sch 
     LABEL "Search" 
     SIZE 8 BY .95.

DEFINE VARIABLE fiFdate AS DATE FORMAT "99/99/9999":U 
      VIEW-AS TEXT 
     SIZE 14 BY .91
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fiFName AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 51 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiInAddr1 AS CHARACTER FORMAT "X(35)":U 
     VIEW-AS FILL-IN 
     SIZE 51 BY .91
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiInAddr2 AS CHARACTER FORMAT "X(35)":U 
     VIEW-AS FILL-IN 
     SIZE 51 BY .91
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiInAddr3 AS CHARACTER FORMAT "X(35)":U 
     VIEW-AS FILL-IN 
     SIZE 33 BY .91
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiInAddr4 AS CHARACTER FORMAT "X(35)":U 
     VIEW-AS FILL-IN 
     SIZE 19.5 BY .91
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiInBranch AS CHARACTER FORMAT "X(3)":U 
     VIEW-AS FILL-IN 
     SIZE 6 BY .95
     BGCOLOR 15 FGCOLOR 1 FONT 2 NO-UNDO.

DEFINE VARIABLE fiInComp AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 11.5 BY .95
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fiInComp_sh AS CHARACTER FORMAT "X(35)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fiInTelNo AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 13 BY .91
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiLName AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 51 BY .91
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fiUser AS CHARACTER FORMAT "X(10)":U 
      VIEW-AS TEXT 
     SIZE 10 BY .91
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fivatcode AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 14.5 BY .95
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-20
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 37 BY 1.62
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-21
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 25.5 BY 1.52
     BGCOLOR 5 .

DEFINE RECTANGLE RECT-22
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 35.5 BY 1.52
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-454
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 65 BY 9.

DEFINE RECTANGLE RECT-83
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 25 BY 1.62
     BGCOLOR 1 .

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY brInsure FOR 
      Insure SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE brInsure
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS brInsure WGWCODEL _STRUCTURED
  QUERY brInsure NO-LOCK DISPLAY
      Insure.CompNo COLUMN-LABEL "Company" FORMAT "X(10)":U WIDTH 13.33
      Insure.InsNo COLUMN-LABEL "Ins No." FORMAT "X(10)":U WIDTH 14.33
      Insure.VatCode COLUMN-LABEL "Vatcode" FORMAT "X(10)":U WIDTH 14.33
      Insure.FName COLUMN-LABEL "Deler Name." FORMAT "X(50)":U
            WIDTH 49.33
      Insure.LName COLUMN-LABEL "show room" FORMAT "X(30)":U WIDTH 15.83
      Insure.Branch COLUMN-LABEL "Br." FORMAT "X(2)":U WIDTH 7.33
      Insure.Addr3 COLUMN-LABEL "status." FORMAT "X(50)":U WIDTH 6.83
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 130 BY 10.33
         BGCOLOR 15  ROW-HEIGHT-CHARS .57.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME frmain
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 24
         BGCOLOR 8 .

DEFINE FRAME frComp
     fiCompNo AT ROW 1.57 COL 11 COLON-ALIGNED NO-LABEL
     btncompfirst AT ROW 1.57 COL 38.33
     btncompprev AT ROW 1.57 COL 44
     btncompnext AT ROW 1.57 COL 49.67
     btncomplast AT ROW 1.57 COL 56.17
     fiabname AT ROW 2.62 COL 11 COLON-ALIGNED NO-LABEL
     fibranch AT ROW 2.62 COL 27 COLON-ALIGNED NO-LABEL
     fiName AT ROW 3.62 COL 11 COLON-ALIGNED NO-LABEL
     fiName2 AT ROW 4.62 COL 11 COLON-ALIGNED NO-LABEL
     fiAddr1 AT ROW 5.67 COL 11 COLON-ALIGNED NO-LABEL
     fiAddr2 AT ROW 6.71 COL 11 COLON-ALIGNED NO-LABEL
     fiAddr3 AT ROW 7.76 COL 11 COLON-ALIGNED NO-LABEL
     fiAddr4 AT ROW 8.81 COL 11 COLON-ALIGNED NO-LABEL
     fiTelNo AT ROW 8.81 COL 43.17 COLON-ALIGNED NO-LABEL
     btncompadd AT ROW 10.67 COL 3.67
     btncompupd AT ROW 10.67 COL 14.83
     btncompdel AT ROW 10.67 COL 26
     btncompok AT ROW 10.67 COL 40.5
     btncompreset AT ROW 10.67 COL 51.83
     "อักษรหลังปี" VIEW-AS TEXT
          SIZE 9.33 BY .95 AT ROW 2.62 COL 3.5
          BGCOLOR 3 FGCOLOR 15 
     "โทรศัพท์" VIEW-AS TEXT
          SIZE 8 BY .95 AT ROW 8.81 COL 36.17
          BGCOLOR 3 FGCOLOR 15 
     "ชื่อ 2" VIEW-AS TEXT
          SIZE 6 BY .95 AT ROW 4.62 COL 3.67
          BGCOLOR 3 FGCOLOR 15 
     "รหัสบริษัท" VIEW-AS TEXT
          SIZE 8 BY .95 AT ROW 1.57 COL 3.5
          BGCOLOR 3 FGCOLOR 15 
     "Branch" VIEW-AS TEXT
          SIZE 6 BY .95 AT ROW 2.62 COL 22.33
          BGCOLOR 3 FGCOLOR 15 
     "ที่อยู่" VIEW-AS TEXT
          SIZE 5.5 BY .95 AT ROW 5.67 COL 3.5
          BGCOLOR 3 FGCOLOR 15 
     "ชื่อบริษัท" VIEW-AS TEXT
          SIZE 8 BY .95 AT ROW 3.62 COL 3.5
          BGCOLOR 3 FGCOLOR 15 
     RECT-17 AT ROW 10.33 COL 2
     RECT-82 AT ROW 10.33 COL 39.17
     RECT-18 AT ROW 1.33 COL 37
     RECT-455 AT ROW 1.19 COL 2
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 65 BY 11.25
         BGCOLOR 3 .

DEFINE FRAME frbrIns
     brInsure AT ROW 1.19 COL 2
     bu_file AT ROW 11.81 COL 78.17 
     bu_imp AT ROW 11.81 COL 83 
     bu_imp-6 AT ROW 11.81 COL 95.33
     fi_output AT ROW 11.86 COL 22.17 NO-LABEL
     bu_exit AT ROW 11.95 COL 123.5
     "File name IMP/EXP :" VIEW-AS TEXT
          SIZE 20 BY 1 AT ROW 11.81 COL 1.5
          BGCOLOR 1 FGCOLOR 7 FONT 6
     RECT-456 AT ROW 11.62 COL 122
     RECT-457 AT ROW 11.62 COL 82 
     RECT-458 AT ROW 11.62 COL 94.5 
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 12.29
         SIZE 132.5 BY 12.52
         BGCOLOR 3 .

DEFINE FRAME frInsure
     fiInComp_sh AT ROW 1.62 COL 11 COLON-ALIGNED NO-LABEL
     bu_sch AT ROW 1.67 COL 29
     btnFirst AT ROW 1.57 COL 39.67
     btnPrev AT ROW 1.57 COL 45.33
     btnNext AT ROW 1.57 COL 51
     btnLast AT ROW 1.57 COL 57.33
     fiInComp AT ROW 3.05 COL 11 COLON-ALIGNED NO-LABEL
     fiInBranch AT ROW 3.05 COL 30.17 COLON-ALIGNED NO-LABEL
     fivatcode AT ROW 3.05 COL 47.5 COLON-ALIGNED NO-LABEL
     fiFName AT ROW 4.1 COL 11 COLON-ALIGNED NO-LABEL
     fiLName AT ROW 5.1 COL 11 COLON-ALIGNED NO-LABEL
     fiInAddr1 AT ROW 6.1 COL 63 RIGHT-ALIGNED NO-LABEL DEBLANK 
     fiInAddr2 AT ROW 7.1 COL 63 RIGHT-ALIGNED NO-LABEL DEBLANK 
     fiInAddr3 AT ROW 8.1 COL 44.83 RIGHT-ALIGNED NO-LABEL
     fiInAddr4 AT ROW 8.1 COL 65 RIGHT-ALIGNED NO-LABEL
     fiInTelNo AT ROW 9.1 COL 10.83 COLON-ALIGNED NO-LABEL
     btninadd AT ROW 10.67 COL 3.5
     btnInUpdate AT ROW 10.67 COL 14.83
     btnInDelete AT ROW 10.67 COL 26.17
     btnInOK AT ROW 10.67 COL 40.83
     btnInCancel AT ROW 10.67 COL 52.17
     fiUser AT ROW 9.1 COL 33 COLON-ALIGNED NO-LABEL
     fiFdate AT ROW 9.1 COL 50 COLON-ALIGNED NO-LABEL
     "Branch" VIEW-AS TEXT
          SIZE 6 BY .95 AT ROW 3.05 COL 25.5
          BGCOLOR 3 FGCOLOR 15 
     "Tel:" VIEW-AS TEXT
          SIZE 8 BY .91 AT ROW 9.1 COL 4
          BGCOLOR 3 FGCOLOR 15 FONT 1
     "Producer" VIEW-AS TEXT
          SIZE 8.5 BY .91 AT ROW 6.1 COL 3.83
          BGCOLOR 3 FGCOLOR 15 
     "User ID" VIEW-AS TEXT
          SIZE 8 BY .91 AT ROW 9.1 COL 26.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "   ค้นหา :" VIEW-AS TEXT
          SIZE 8 BY .95 AT ROW 1.62 COL 3.33
          BGCOLOR 2 FGCOLOR 7 FONT 6
     "Vat code." VIEW-AS TEXT
          SIZE 9.33 BY .95 AT ROW 3.05 COL 39.33
          BGCOLOR 3 FGCOLOR 15 
     "Date:" VIEW-AS TEXT
          SIZE 6 BY .91 AT ROW 9.1 COL 45.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "รหัสดีเลอร์" VIEW-AS TEXT
          SIZE 9.33 BY .95 AT ROW 3.05 COL 3.33
          BGCOLOR 3 FGCOLOR 15 
     "Agent" VIEW-AS TEXT
          SIZE 8.5 BY .91 AT ROW 7.1 COL 4
          BGCOLOR 3 FGCOLOR 15 
     "ชื่อดีเลอร์" VIEW-AS TEXT
          SIZE 8.5 BY .95 AT ROW 4.1 COL 3.67
          BGCOLOR 3 FGCOLOR 15 
     "Status" VIEW-AS TEXT
          SIZE 8.5 BY .91 AT ROW 8.1 COL 3.5
          BGCOLOR 3 FGCOLOR 15 
     "ชื่อดีเลอร์2" VIEW-AS TEXT
          SIZE 8.5 BY .95 AT ROW 5.1 COL 3.67
          BGCOLOR 3 FGCOLOR 15 
     RECT-20 AT ROW 10.33 COL 2
     RECT-83 AT ROW 10.33 COL 39.17
     RECT-454 AT ROW 1.19 COL 2
     RECT-21 AT ROW 1.38 COL 38.67
     RECT-22 AT ROW 1.38 COL 2.67
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 66.17 ROW 1
         SIZE 67.25 BY 11.25
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
  CREATE WINDOW WGWCODEL ASSIGN
         HIDDEN             = YES
         TITLE              = "Set Company Code Delar[wgwcodel]"
         HEIGHT             = 23.95
         WIDTH              = 132.83
         MAX-HEIGHT         = 33.71
         MAX-WIDTH          = 170.67
         VIRTUAL-HEIGHT     = 33.71
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
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW WGWCODEL
  VISIBLE,,RUN-PERSISTENT                                               */
/* REPARENT FRAME */
ASSIGN FRAME frbrIns:FRAME = FRAME frmain:HANDLE
       FRAME frComp:FRAME = FRAME frmain:HANDLE
       FRAME frInsure:FRAME = FRAME frmain:HANDLE.

/* SETTINGS FOR FRAME frbrIns
   FRAME-NAME                                                           */
/* BROWSE-TAB brInsure RECT-458 frbrIns */
ASSIGN 
       bu_file:AUTO-RESIZE IN FRAME frbrIns      = TRUE.

/* SETTINGS FOR FILL-IN fi_output IN FRAME frbrIns
   ALIGN-L                                                              */
/* SETTINGS FOR FRAME frComp
                                                                        */
/* SETTINGS FOR FILL-IN fiabname IN FRAME frComp
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fiAddr1 IN FRAME frComp
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fiAddr2 IN FRAME frComp
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fiAddr3 IN FRAME frComp
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fiAddr4 IN FRAME frComp
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fibranch IN FRAME frComp
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fiCompNo IN FRAME frComp
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fiName IN FRAME frComp
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fiTelNo IN FRAME frComp
   NO-ENABLE                                                            */
/* SETTINGS FOR FRAME frInsure
   Custom                                                               */
/* SETTINGS FOR FILL-IN fiFName IN FRAME frInsure
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fiInAddr1 IN FRAME frInsure
   NO-ENABLE ALIGN-R                                                    */
/* SETTINGS FOR FILL-IN fiInAddr2 IN FRAME frInsure
   NO-ENABLE ALIGN-R                                                    */
/* SETTINGS FOR FILL-IN fiInAddr3 IN FRAME frInsure
   NO-ENABLE ALIGN-R                                                    */
/* SETTINGS FOR FILL-IN fiInAddr4 IN FRAME frInsure
   NO-ENABLE ALIGN-R                                                    */
/* SETTINGS FOR FILL-IN fiInComp IN FRAME frInsure
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fiLName IN FRAME frInsure
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fivatcode IN FRAME frInsure
   NO-ENABLE                                                            */
/* SETTINGS FOR FRAME frmain
   Custom                                                               */

DEFINE VARIABLE XXTABVALXX AS LOGICAL NO-UNDO.

ASSIGN XXTABVALXX = FRAME frbrIns:MOVE-BEFORE-TAB-ITEM (FRAME frInsure:HANDLE)
/* END-ASSIGN-TABS */.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(WGWCODEL)
THEN WGWCODEL:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE brInsure
/* Query rebuild information for BROWSE brInsure
     _TblList          = "stat.Insure"
     _Options          = "NO-LOCK"
     _OrdList          = "stat.Insure.InsNo|yes"
     _FldNameList[1]   > stat.Insure.CompNo
"Insure.CompNo" "Company" "X(10)" "character" ? ? ? ? ? ? no ? no no "13.33" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[2]   > stat.Insure.InsNo
"Insure.InsNo" "Ins No." "X(10)" "character" ? ? ? ? ? ? no ? no no "14.33" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   > stat.Insure.VatCode
"Insure.VatCode" "Vatcode" "X(10)" "character" ? ? ? ? ? ? no ? no no "14.33" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   > stat.Insure.FName
"Insure.FName" "Deler Name." ? "character" ? ? ? ? ? ? no ? no no "49.33" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   > stat.Insure.LName
"Insure.LName" "show room" "X(30)" "character" ? ? ? ? ? ? no ? no no "15.83" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[6]   > stat.Insure.Branch
"Insure.Branch" "Br." ? "character" ? ? ? ? ? ? no ? no no "7.33" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[7]   > stat.Insure.Addr3
"Insure.Addr3" "status." ? "character" ? ? ? ? ? ? no ? no no "6.83" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _Query            is NOT OPENED
*/  /* BROWSE brInsure */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME WGWCODEL
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL WGWCODEL WGWCODEL
ON END-ERROR OF WGWCODEL /* Set Company Code Delar[wgwcodel] */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL WGWCODEL WGWCODEL
ON WINDOW-CLOSE OF WGWCODEL /* Set Company Code Delar[wgwcodel] */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME brInsure
&Scoped-define SELF-NAME brInsure
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brInsure WGWCODEL
ON MOUSE-SELECT-CLICK OF brInsure IN FRAME frbrIns
DO:
    GET CURRENT brInsure.
    RUN PdDispIns IN THIS-PROCEDURE. 

    FIND CURRENT Insure NO-LOCK.
    IF NOT AVAIL Insure THEN RETURN NO-APPLY.
    IF AVAIL Insure AND Insure.CompNo = pComp THEN DO:
       pRowIns = ROWID (Insure).
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brInsure WGWCODEL
ON MOUSE-SELECT-DBLCLICK OF brInsure IN FRAME frbrIns
DO:
    GET CURRENT brInsure.
    RUN PdDispIns IN THIS-PROCEDURE. 

    FIND CURRENT Insure NO-LOCK.
    IF NOT AVAIL Insure THEN RETURN NO-APPLY.
    IF AVAIL Insure AND Insure.CompNo = pComp THEN DO:
       pRowIns = ROWID (Insure).
    END.
    /*kridtiya i. A57-0396
    APPLY "MOUSE-SELECT-CLICK" TO brInsure IN FRAME frbrins.    
    APPLY "CLOSE" TO THIS-PROCEDURE. */
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brInsure WGWCODEL
ON VALUE-CHANGED OF brInsure IN FRAME frbrIns
DO:
  FIND CURRENT Insure NO-LOCK.
      RUN pdDispIns IN THIS-PROCEDURE. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frComp
&Scoped-define SELF-NAME btncompadd
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btncompadd WGWCODEL
ON CHOOSE OF btncompadd IN FRAME frComp /* เพิ่ม */
DO:  
  APPLY "CHOOSE" TO btnCompReset IN FRAME frcomp.
 
  RUN PDInitData IN THIS-PROCEDURE.
  RUN PDEnableComp IN THIS-PROCEDURE.
 
  ASSIGN
    cUpdate = "Add"

    btnCompAdd:Sensitive   IN FRAME frcomp = No
    btnCompUpd:Sensitive   IN FRAME frcomp = No
    btnCompDel:Sensitive   IN FRAME frcomp = No
    btnCompOK:SENSITIVE    IN FRAME frcomp = Yes
    btnCompReset:SENSITIVE IN FRAME frcomp = Yes
    btnCompFirst:SENSITIVE IN FRAME frcomp = No
    btnCompPrev:SENSITIVE  IN FRAME frcomp = No
    btnCompNext:SENSITIVE  IN FRAME frcomp = No
    btnCompLast:SENSITIVE  IN FRAME frcomp = No.
  
  DISP 
    fiCompNo fiAbName fiName fiName2 fibranch
    fiAddr1 fiAddr2 fiAddr3 fiAddr4  fiTelNo  
  WITH FRAME frComp.
  
    APPLY "ENTRY" TO fiCompNo IN FRAME frComp.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btncompdel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btncompdel WGWCODEL
ON CHOOSE OF btncompdel IN FRAME frComp /* ลบ */
DO:
    DEF VAR logAns    AS LOGI INIT No.  
    DEF BUFFER bComp  FOR Company.
    DEF VAR rComp     AS ROWID.
    ASSIGN
        logAns = No
        rComp  = ROWID (Company)
        btnCompAdd:Sensitive   = Yes
        btnCompUpd:Sensitive   = Yes
        btnCompDel:Sensitive   = Yes.
    MESSAGE "Are you want to delete " + STRING (Company.CompNo) + "-" + Company.Name + " ?" 
        UPDATE logAns 
        VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO
        TITLE " Confirm Deletion ".   
    IF logAns THEN DO:  
        FIND bComp WHERE ROWID (bComp) = rComp EXCLUSIVE-LOCK.
        FOR EACH CompDet WHERE CompDet.CompNo = bComp.CompNo EXCLUSIVE-LOCK:
            DELETE CompDet.
        END.
        DELETE Company.
        MESSAGE "Deleted Comple ..." 
            VIEW-AS ALERT-BOX INFORMATION.  
        FIND NEXT Company NO-LOCK NO-ERROR.
        IF NOT AVAIL Company THEN FIND LAST Company NO-LOCK.
        RUN PDDispComp IN THIS-PROCEDURE.
    END. 
    RUN PDDisableComp IN THIS-PROCEDURE.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btncompfirst
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btncompfirst WGWCODEL
ON CHOOSE OF btncompfirst IN FRAME frComp /* << */
DO:
  FIND FIRST Company WHERE length(Company.compno) GE  2 AND
      /*length(Company.compno) LE  3 NO-LOCK NO-ERROR.*//*kridtiya i. A53-0232*/
      length(Company.compno) LE  25 NO-LOCK NO-ERROR.   /*kridtiya i. A53-0232*/
  IF NOT AVAIL Company THEN RETURN NO-APPLY.
  RUN PDDispLogin IN THIS-PROCEDURE.
  gComp = company.compno.
  RUN pdUpdateQ.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btncomplast
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btncomplast WGWCODEL
ON CHOOSE OF btncomplast IN FRAME frComp /* >> */
DO:
  FIND LAST Company WHERE length(Company.compno) GE 2 AND 
      /*length(Company.compno) LE 3 NO-LOCK NO-ERROR.*//*kridtiya i. A53-0232*/
      length(Company.compno) LE 25 NO-LOCK NO-ERROR.   /*kridtiya i. A53-0232*/
  IF NOT AVAIL Company THEN RETURN NO-APPLY.
  RUN PDDispLogin IN THIS-PROCEDURE.
  gComp = company.compno.
  RUN pdUpdateQ.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btncompnext
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btncompnext WGWCODEL
ON CHOOSE OF btncompnext IN FRAME frComp /* > */
DO:
    FIND bComp WHERE ROWID (bComp) = ROWID (Company) NO-LOCK NO-ERROR.
    FIND NEXT bComp WHERE length(bComp.compno)   GE 2  AND
        /* length(bComp.compno) LE 3  NO-LOCK NO-ERROR.*/ /*kridtiya i. A53-0232*/
        length(bComp.compno) LE 25  NO-LOCK NO-ERROR.     /*kridtiya i. A53-0232*/
    IF NOT AVAIL bComp THEN RETURN NO-APPLY.
    FIND NEXT Company WHERE length(Company.compno) GE 2 AND
        /*length(Company.compno) LE 3 NO-LOCK NO-ERROR.*/ /*kridtiya i. A53-0232*/
        length(Company.compno) LE 10 NO-LOCK NO-ERROR.    /*kridtiya i. A53-0232*/
    RUN PDDispLogin IN THIS-PROCEDURE.
    gComp = company.compno.
    RUN pdUpdateQ.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btncompok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btncompok WGWCODEL
ON CHOOSE OF btncompok IN FRAME frComp /* OK */
DO:
  IF cUpdate = "" THEN RETURN NO-APPLY.
  DEF VAR rComp  AS ROWID.
  DEF VAR logAns AS LOGI INIT No.  
  ASSIGN 
      FRAME frComp fiCompNo
      FRAME frComp fiAbName 
      FRAME frComp fiName .
  IF fiCompNo = "" OR fiAbName = "" OR fiName = ""  THEN DO:
      MESSAGE "ข้อมูลผิดพลาด กรุณาตรวจสอบข้อมูล"           VIEW-AS ALERT-BOX ERROR.      
      RETURN NO-APPLY.  
  END.
  DO WITH FRAME frComp : 
      ASSIGN
          logAns = No.
      IF cUpdate = "ADD" THEN DO:
          MESSAGE "ต้องการเพิ่มข้อมูลรายการนี้ ?" 
          UPDATE logAns 
          VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO
          TITLE "ยืนยันการเพิ่มข้อมูล".   
          IF logAns THEN DO:
              CREATE Company.
          END. 

      END. /* ADD */
      ELSE 
          IF cUpdate = "UPDATE" THEN DO:
              FIND CURRENT Company EXCLUSIVE-LOCK.
          END.    /* UPDATE */
      ASSIGN 
          FRAME frComp fiCompNo 
          FRAME frComp fiAbName 
          FRAME frComp fibranch
          FRAME frComp fiName
          FRAME frComp fiName2
          FRAME frComp fiAddr1 
          FRAME frComp fiAddr2 
          FRAME frComp fiAddr3 
          FRAME frComp fiAddr4
          FRAME frComp fiTelNo 
          Company.CompNo   = caps(fiCompNo)
          Company.AbName   = caps(fiAbName)
          Company.Branch   = caps(fibranch)
          Company.Name     = fiName
          Company.Name2    = fiName2
          Company.Addr1     = fiAddr1
          Company.Addr2     = fiAddr2      
          Company.Addr3     = fiAddr3
          Company.Addr4     = fiAddr4
          Company.TelNo     = fiTelNo
          Company.PowerName  = fiuser
          btnCompAdd:Sensitive   IN FRAME frcomp = Yes
          btnCompUpd:Sensitive   IN FRAME frcomp = Yes
          btnCompDel:Sensitive   IN FRAME frcomp = Yes
          btnCompFirst:Sensitive IN FRAME frcomp = Yes
          btnCompPrev:Sensitive  IN FRAME frcomp = Yes
          btnCompNext:Sensitive  IN FRAME frcomp = Yes
          btnCompLast:Sensitive  IN FRAME frcomp = Yes
          btnCompOK:Sensitive    IN FRAME frcomp = No
          btnCompReset:Sensitive IN FRAME frcomp = No.
          cUpdate = "". 
      RUN PDDispComp  IN THIS-PROCEDURE.
      RUN PDDisableComp IN THIS-PROCEDURE.
      /*RUN PDEnable IN THIS-PROCEDURE.*/
      /* APPLY "CHOOSE" TO btnInAdd IN FRAME frInsure.*/
  END. /* DO WITH FRAME */
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btncompprev
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btncompprev WGWCODEL
ON CHOOSE OF btncompprev IN FRAME frComp /* < */
DO:
  FIND bComp WHERE ROWID (bComp) = ROWID (Company) NO-LOCK NO-ERROR.
  FIND PREV bComp WHERE length(bComp.compno) GE 2  AND 
      /*length(bComp.compno) LE 3  NO-LOCK NO-ERROR. *//*kridtiya i. A53-0232*/
      length(bComp.compno) LE 25  NO-LOCK NO-ERROR.    /*kridtiya i. A53-0232*/
  IF NOT AVAIL bComp THEN RETURN NO-APPLY.
  FIND PREV Company WHERE  /*length(Company.compno) LE  3 AND*//*kridtiya i. A53-0232*/
      length(Company.compno) LE  10 AND                        /*kridtiya i. A53-0232*/
      length(Company.compno) GE  2 NO-LOCK NO-ERROR.
  RUN PDDispLogin IN THIS-PROCEDURE.
  gComp = company.compno.
  RUN pdUpdateQ.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btncompreset
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btncompreset WGWCODEL
ON CHOOSE OF btncompreset IN FRAME frComp /* Cancel */
DO:
  IF cUpdate = "" THEN RETURN NO-APPLY.
  RUN PDDisableComp IN THIS-PROCEDURE.
  
  RUN PDInitData IN THIS-PROCEDURE.
  
  FIND CURRENT Company NO-LOCK.
  RUN PDDispComp IN THIS-PROCEDURE.
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btncompupd
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btncompupd WGWCODEL
ON CHOOSE OF btncompupd IN FRAME frComp /* แก้ไข */
DO:
  RUN PDEnableComp IN THIS-PROCEDURE.
  
  ASSIGN 
    cUpdate = "UPDATE"
    
    btnCompAdd:Sensitive   IN FRAME frcomp = No
    btnCompUpd:Sensitive   IN FRAME frcomp = No
    btnCompDel:Sensitive   IN FRAME frcomp = No
       
    btnCompOK:SENSITIVE    IN FRAME frcomp = Yes
    btnCompReset:SENSITIVE IN FRAME frcomp = Yes
    
    btnCompFirst:SENSITIVE IN FRAME frcomp = No
    btnCompPrev:SENSITIVE  IN FRAME frcomp = No
    btnCompNext:SENSITIVE  IN FRAME frcomp = No
    btnCompLast:SENSITIVE  IN FRAME frcomp = No.
    
  APPLY "ENTRY" TO fiCompNo IN FRAME frComp.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frInsure
&Scoped-define SELF-NAME btnFirst
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnFirst WGWCODEL
ON CHOOSE OF btnFirst IN FRAME frInsure /* << */
DO:
  GET FIRST brInsure.
  IF NOT AVAIL Insure THEN RETURN NO-APPLY.  
  REPOSITION brInsure TO ROWID ROWID (Insure).
  APPLY "VALUE-CHANGED" TO brInsure IN FRAME frbrIns.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btninadd
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btninadd WGWCODEL
ON CHOOSE OF btninadd IN FRAME frInsure /* เพิ่ม */
DO: 
  DEF BUFFER bIns FOR Insure.
  DEF VAR vInsNo    AS INTE INIT 0.
  DEF VAR vInsC     AS CHAR FORMAT "X" INIT "W".
  DEF VAR vInsFirst AS CHAR.   
  DEF VAR v_InsNo   AS char.
  DEF VAR nv_Insno  AS CHAR.
  DEF VAR nv_vinsc  AS CHAR.
  DEF VAR insno     AS CHAR.
  DEF VAR insno1    AS CHAR.
  DEF VAR n_Insno   AS INT.
  gComp = fiCompno.
  RUN PDEnable IN THIS-PROCEDURE.
  ASSIGN 
    cUpdate   = "ADD"
    fiIncomp  = nv_InsNo
    fiInbranch = ""
    fivatcode = ""
    fiFName   = ""    
    fiLName   = "" 
    fiInAddr1   = ""    
    fiInAddr2   = ""    
    fiInAddr3   = ""    
    fiInAddr4   = ""
    fiInTelNo   = ""
    fiFDate   = TODAY
    btnFirst:Sensitive  = No
    btnPrev:Sensitive   = No
    btnNext:Sensitive   = No
    btnLast:Sensitive   = No
    btnInAdd:Sensitive    = No
    btnInUpdate:Sensitive = No
    btnInDelete:Sensitive = No  
    btnInOK:Sensitive     = Yes
    btnInCancel:Sensitive = Yes.
  DISPLAY 
     fiInComp  fiInbranch fivatcode
     fifName   fiLName  fiInAddr1  
     fiInAddr2   fiInAddr3     
     fiInAddr4   fiInTelNo       
  WITH FRAME frInsure.
  DISP fiFDate WITH FRAME fruser.
  APPLY "ENTRY" TO fiInComp IN FRAME frInsure .
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnInCancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnInCancel WGWCODEL
ON CHOOSE OF btnInCancel IN FRAME frInsure /* Cancel */
DO:
  RUN ProcDisable IN THIS-PROCEDURE.
  ASSIGN 
    btnFirst:Sensitive IN FRAM frinsure = Yes
    btnPrev:Sensitive  IN FRAM frinsure = Yes
    btnNext:Sensitive  IN FRAM frinsure = Yes
    btnLast:Sensitive  IN FRAM frinsure = Yes
     
    btnInAdd:Sensitive    IN FRAM frinsure = Yes
    btnInUpdate:Sensitive IN FRAM frinsure = Yes
    btnInDelete:Sensitive IN FRAM frinsure = Yes
         
    btnInOK:Sensitive     IN FRAM frinsure = No
    btnInCancel:Sensitive IN FRAM frinsure = No.
    brInsure:Sensitive IN FRAM frbrins = Yes.
    
  APPLY "VALUE-CHANGED" TO brInsure IN FRAME frbrins.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnInDelete
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnInDelete WGWCODEL
ON CHOOSE OF btnInDelete IN FRAME frInsure /* ลบ */
DO:
    DEF VAR logAns AS LOGI INIT No.  
    logAns = No.
    MESSAGE "ต้องการลบข้อมูลรายการ " + TRIM (Insure.Insno) + " " + 
        TRIM (Insure.Fname) + " " + TRIM (Insure.LName) + " ?"  UPDATE logAns 
        VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO
        TITLE "ลบข้อมูลชื่อดีเลอร์นี้".   
    IF logAns THEN DO:  
        GET CURRENT brInsure EXCLUSIVE-LOCK.
        DELETE Insure.
        MESSAGE "ลบข้อมูลดีเลอร์เรียบร้อย ..." VIEW-AS ALERT-BOX INFORMATION.  
    END.  
    RUN PdUpdateQ.
    APPLY "VALUE-CHANGED" TO brInsure IN FRAM frbrins.  
    RUN ProcDisable IN THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnInOK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnInOK WGWCODEL
ON CHOOSE OF btnInOK IN FRAME frInsure /* OK */
DO:
    ASSIGN
        FRAME frInsure fiInBranch
        FRAME frInsure fiIncomp
        FRAM  frinsure fivatcode
        FRAME frInsure fiFName
        FRAME frInsure fiLName 
        FRAME frInsure fiInAddr1
        FRAME frInsure fiInAddr2
        FRAME frInsure fiInAddr3
        FRAME frInsure fiInAddr4
        FRAME frInsure fiInTelNo.
    IF fivatcode NE ""   THEN DO:
        FIND FIRST sicsyac.xmm600 USE-INDEX xmm60001 WHERE
            sicsyac.xmm600.acno = fivatcode NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL sicsyac.xmm600 THEN DO: 
            ASSIGN fivatcode = "".
            MESSAGE "Not found vatcode in table xmm600 Please insert again!!!!!" VIEW-AS ALERT-BOX.
            APPLY "ENTRY" TO fivatcode IN FRAME frinsure.
        END.
    END.
    /*kridtiya i. A53-0182 ตรวจสอบค่า Producer code*/
    /*IF  fiInAddr1 NE ""  THEN DO:
        FIND FIRST sicsyac.xmm600 USE-INDEX xmm60001 WHERE
            sicsyac.xmm600.acno = fiInAddr1 NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL sicsyac.xmm600 THEN DO: 
            ASSIGN fiInAddr1 = "".
            MESSAGE "Not found Producer in table xmm600 Please insert again!!!!!" VIEW-AS ALERT-BOX.
            APPLY "ENTRY" TO fiInAddr1 IN FRAME frinsure.
        END.
    END.
    IF  fiInAddr2 NE ""  THEN DO:
        FIND FIRST sicsyac.xmm600 USE-INDEX xmm60001 WHERE
            sicsyac.xmm600.acno = fiInAddr2 NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL sicsyac.xmm600 THEN DO: 
            ASSIGN fiInAddr2 = "".
            MESSAGE "Not found Producer in table xmm600 Please insert again!!!!!" VIEW-AS ALERT-BOX.
            APPLY "ENTRY" TO fiInAddr2 IN FRAME frinsure.
        END.
    END.*/
    /*kridtiya i. A53-0182 ตรวจสอบค่า Producer code*/
    IF (fiInBranch = ""  OR fiIncomp  = "" ) THEN DO:
            MESSAGE "ข้อมูลผิดพลาด  กรุณาตรวจสอบข้อมูลใหม่ "  VIEW-AS ALERT-BOX ERROR.
            APPLY "ENTRY" TO fiIncomp IN FRAME frinsure.
    END.
    ELSE DO:
        RUN ProcUpdateInsure IN THIS-PROCEDURE (INPUT cUpdate).
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnInUpdate
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnInUpdate WGWCODEL
ON CHOOSE OF btnInUpdate IN FRAME frInsure /* แก้ไข */
DO:
  RUN PdEnable IN THIS-PROCEDURE.
  ASSIGN
    fiIncomp fiInBranch fivatcode fiFName fiLName 
    fiInAddr1 fiInAddr2 fiInAddr3 fiInAddr4 
    fiInTelNo
    cUpdate = "UPDATE"
    btnFirst:SENSITIVE IN FRAME frInsure = No
    btnPrev:Sensitive  IN FRAME frInsure = No
    btnNext:Sensitive  IN FRAME frInsure = No
    btnLast:Sensitive  IN FRAME frInsure = No
    btnInAdd:Sensitive    IN FRAME frInsure = No
    btnInUpdate:Sensitive IN FRAME frInsure = No
    btnInDelete:Sensitive IN FRAME frInsure = No  
    btnInOK:Sensitive     IN FRAME frInsure = Yes
    btnInCancel:Sensitive IN FRAME frInsure = Yes
    brInsure:Sensitive IN FRAME frbrins = No.
    RUN PdDispIns IN THIS-PROCEDURE.
  APPLY "ENTRY" TO fiIncomp IN FRAM frInsure.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnLast
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnLast WGWCODEL
ON CHOOSE OF btnLast IN FRAME frInsure /* >> */
DO:
  GET LAST brInsure.
  IF NOT AVAIL Insure THEN RETURN NO-APPLY.
  REPOSITION brInsure TO ROWID ROWID (Insure).
  APPLY "VALUE-CHANGED" TO brInsure IN FRAME frbrins.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnNext
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnNext WGWCODEL
ON CHOOSE OF btnNext IN FRAME frInsure /* > */
DO:
  GET NEXT brInsure.
  IF NOT AVAIL Insure THEN RETURN NO-APPLY.
  REPOSITION brInsure TO ROWID ROWID (Insure).
  APPLY "VALUE-CHANGED" TO brInsure IN FRAME frbrins.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnPrev
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnPrev WGWCODEL
ON CHOOSE OF btnPrev IN FRAME frInsure /* < */
DO:
  GET PREV brInsure.
  IF NOT AVAIL Insure THEN RETURN NO-APPLY.
  REPOSITION brInsure TO ROWID ROWID (Insure).
  APPLY "VALUE-CHANGED" TO brInsure IN FRAME frbrins.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frbrIns
&Scoped-define SELF-NAME bu_exit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_exit WGWCODEL
ON CHOOSE OF bu_exit IN FRAME frbrIns /* EXIT */
DO:
    APPLY "CLOSE" TO THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_file
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_file WGWCODEL
ON CHOOSE OF bu_file IN FRAME frbrIns /* ... */
DO:
    DEFINE VARIABLE cvData        AS CHARACTER NO-UNDO.
    DEFINE VARIABLE OKpressed AS LOGICAL INITIAL TRUE.

    DEF VAR no_add AS CHAR FORMAT "x(8)" . /*08/11/2006*/

   SYSTEM-DIALOG GET-FILE cvData
        TITLE      "Choose Data File to Import ..."
       
       FILTERS    /* "CSV (Comma Delimited)"   "*.csv",
                            "Data Files (*.dat)"     "*.dat",*/
                    "Text Files (*.txt)" "*.csv"
                    
                            
        MUST-EXIST
        USE-FILENAME
        UPDATE OKpressed.
      
    IF OKpressed = TRUE THEN DO:
       ASSIGN
            fi_output  = cvData.
           /* fi_output1 = SUBSTRING(cvData,1,(LENGTH(fi_filename) - 4))  /* + "_SUCCESS" */ + no_add + ".fuw" /*.csv*/
            fi_output2 = SUBSTRING(cvData,1,(LENGTH(fi_filename) - 4))  /* + "_ERROR"   */ + no_add + ".err"
            fi_output3 = SUBSTRING(cvData,1,(LENGTH(fi_filename) - 4))  /* + "_SCREEN"  */ + no_add + ".sce".*/ /*txt*/

         DISP fi_output  WITH FRAME {&FRAME-NAME}. 
         APPLY "Entry" TO fi_output.
         RETURN NO-APPLY.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_imp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_imp WGWCODEL
ON CHOOSE OF bu_imp IN FRAME frbrIns /* IMPORT */
DO:
    /* create by : Ranu i. A60-0261 */
     IF fi_output = "" THEN DO:
        message "Please insert filename output..."  view-as alert-box.
        APPLY "Entry" TO fi_output.
        RETURN NO-APPLY.
    END.

    FOR EACH  wdetail :
        DELETE  wdetail.
    END.
    INPUT FROM VALUE(fi_output).
    REPEAT:
        CREATE wdetail.
        IMPORT DELIMITER "|" 
                    wdetail.Company          
                    wdetail.Delerno 
                    wdetail.Vatcode 
                    wdetail.Deler_Name         
                    wdetail.Show_room  
                    wdetail.Branch     
                    wdetail.nSTATUS    
                    wdetail.Producer   
                    wdetail.Agent      
                    wdetail.addr4      
                    wdetail.Tel  .
    END.  /* repeat  */
    FOR EACH wdetail.
        IF index(wdetail.company,"COMPANY") <> 0  THEN DELETE wdetail.
        ELSE RUN  Proc_importfile.
    END.
    /* end A60-0261 */
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_imp-6
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_imp-6 WGWCODEL
ON CHOOSE OF bu_imp-6 IN FRAME frbrIns /* EXPORT */
DO: 
    DEF VAR nv_brvatins AS CHAR FORMAT "x(5)" INIT "".
    IF fi_output = "" THEN DO:
        message "Please insert filename output..."  view-as alert-box.
        APPLY "Entry" TO fi_output.
        RETURN NO-APPLY.
    END.
    If  substr(fi_output,length(fi_output) - 3,4) <>  ".csv"  Then
        fi_output  =  Trim(fi_output) + ".csv"  .
    OUTPUT  TO VALUE(fi_output).
    EXPORT DELIMITER "|"
        "Company "                                                 
        "Delerno " 
        "Vatcode."    
        "Deler Name"                                    
        "Show room" 
        "Branch" 
        "Status"   
        "Producer"
        "Agent"
        "addr4"
        "Tel"
        "Vat_branch"
        SKIP. 
    FOR EACH  stat.insure USE-INDEX Insure03  WHERE 
        stat.insure.compno  = fiCompNo       NO-LOCK.
        ASSIGN nv_brvatins = "".
        IF stat.insure.vatcode <> ""  THEN DO:
            FIND LAST sicsyac.xmm600 USE-INDEX xmm60001 WHERE 
                        sicsyac.xmm600.acno = TRIM(stat.insure.vatcode) NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL sicsyac.xmm600 THEN ASSIGN  nv_brvatins  = sicsyac.xmm600.anlyc5.
            ELSE ASSIGN nv_brvatins = "".
        END.
        EXPORT DELIMITER "|"  
            stat.insure.compno 
            stat.Insure.InsNo 
            stat.insure.vatcode
            stat.Insure.FName 
            stat.Insure.LName 
            stat.Insure.Branch 
            stat.Insure.addr3
            stat.Insure.Addr1 
            stat.Insure.Addr2 
            stat.Insure.Addr4 
            stat.Insure.TelNo
            nv_brvatins  FORMAT "x(5)" .   
    END.
    OUTPUT  CLOSE.
    message "Export File  Complete"  view-as alert-box.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frInsure
&Scoped-define SELF-NAME bu_sch
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_sch WGWCODEL
ON CHOOSE OF bu_sch IN FRAME frInsure /* Search */
DO:
     
        FIND LAST insure USE-INDEX insure01 WHERE
            insure.compno = gComp  AND 
            insure.lName =  fiInComp_sh  NO-LOCK NO-WAIT NO-ERROR.
        IF AVAIL insure THEN DO: 
            REPOSITION brInsure TO ROWID ROWID (Insure).
            DISPLAY 
           Insure.insno     @ fiInComp     
           Insure.Branch    @ fiInBranch
           insure.vatcode   @ fivatcode
           Insure.FName     @ fiFName
           Insure.LName     @ fiLName
           Insure.Addr1     @ fiInAddr1
           Insure.Addr2     @ fiInAddr2     
           Insure.Addr3     @ fiInAddr3
           Insure.Addr4     @ fiInAddr4  
           Insure.TelNo     @ fiInTelNo
           Insure.FDate     @ fiFDate
           Insure.UserNo    @ fiUser

           WITH FRAME frinsure.
        /*DISP Insure.FDate     @ fiFDate WITH FRAME frinsure.*/
        APPLY "VALUE-CHANGED" TO brInsure IN FRAME frbrins.
        END.

         
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frComp
&Scoped-define SELF-NAME fiabname
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiabname WGWCODEL
ON LEAVE OF fiabname IN FRAME frComp
DO:
  /*  fiabname = INPUT fiabname.
    DISP  CAPS(fiabname) @ fiabname WITH FRAME frComp.*/
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fibranch
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fibranch WGWCODEL
ON LEAVE OF fibranch IN FRAME frComp
DO:
  /*  fiabname = INPUT fiabname.
    DISP  CAPS(fiabname) @ fiabname WITH FRAME frComp.*/
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiCompNo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiCompNo WGWCODEL
ON LEAVE OF fiCompNo IN FRAME frComp
DO:
      fiCompNo = caps(INPUT fiCompNo).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frInsure
&Scoped-define SELF-NAME fiFName
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiFName WGWCODEL
ON LEAVE OF fiFName IN FRAME frInsure
DO:
    fiFName  = INPUT fiFName.
    DISP fiFName WITH FRAM frInsure.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiInAddr1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiInAddr1 WGWCODEL
ON LEAVE OF fiInAddr1 IN FRAME frInsure
DO:
    fiInAddr1  = INPUT fiInAddr1 .
    DISP fiInAddr1 WITH FRAM frInsure.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiInAddr2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiInAddr2 WGWCODEL
ON LEAVE OF fiInAddr2 IN FRAME frInsure
DO:
    fiInAddr2 = INPUT fiInAddr2 .
    DISP fiInAddr2 WITH FRAM frInsure.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiInAddr3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiInAddr3 WGWCODEL
ON LEAVE OF fiInAddr3 IN FRAME frInsure
DO:
    fiInAddr3  = INPUT fiInAddr3 .
    DISP fiInAddr3 WITH FRAM frInsure.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiInAddr4
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiInAddr4 WGWCODEL
ON LEAVE OF fiInAddr4 IN FRAME frInsure
DO:
    fiInAddr4  = INPUT fiInAddr4.
    DISP fiInAddr4 WITH FRAM frInsure.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiInBranch
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiInBranch WGWCODEL
ON LEAVE OF fiInBranch IN FRAME frInsure
DO:
    fiInBranch = INPUT fiInBranch.
    DISP fiInBranch WITH FRAM frInsure.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiInComp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiInComp WGWCODEL
ON LEAVE OF fiInComp IN FRAME frInsure
DO:
    fiInComp  = INPUT fiInComp.
    DISP fiInComp WITH FRAM frInsure.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiInComp_sh
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiInComp_sh WGWCODEL
ON LEAVE OF fiInComp_sh IN FRAME frInsure
DO:
    fiInComp_sh  = INPUT fiInComp_sh.
    DISP fiInComp_sh WITH FRAM frInsure.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiInTelNo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiInTelNo WGWCODEL
ON LEAVE OF fiInTelNo IN FRAME frInsure
DO:
    fiInTelNo  = INPUT fiInTelNo.
    DISP fiInTelNo WITH FRAM frInsure.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiLName
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiLName WGWCODEL
ON LEAVE OF fiLName IN FRAME frInsure
DO:
    fiLName  = INPUT fiLName .
    DISP fiLName WITH FRAM frInsure.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frComp
&Scoped-define SELF-NAME fiName
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiName WGWCODEL
ON LEAVE OF fiName IN FRAME frComp
DO:
/*      fiName = INPUT fiCompNo.*/

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frInsure
&Scoped-define SELF-NAME fivatcode
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fivatcode WGWCODEL
ON LEAVE OF fivatcode IN FRAME frInsure
DO:
    fivatcode  = INPUT fivatcode.
    DISP fivatcode WITH FRAM frInsure.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frbrIns
&Scoped-define SELF-NAME fi_output
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_output WGWCODEL
ON LEAVE OF fi_output IN FRAME frbrIns
DO:
    fi_output = INPUT fi_output .
    DISP fi_output WITH FRAM frbrIns.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK WGWCODEL 


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
  RUN WUT\WUTDICEN (WGWCODEL:HANDLE).
  SESSION:DATA-ENTRY-RETURN = Yes.

  /*fiUser = "".
  fiUser = n_user.
  fiFdate = ?.
  fiFdate = TODAY.*/
  DISP fiuser fiFdate WITH FRAME fruser.
  
   
  /*FIND FIRST Company WHERE Company.Branch = SUBSTRING(n_user,6,1) NO-ERROR.
  IF NOT AVAIL company THEN DO:
      MESSAGE "ไม่มีการกำหนด Parameter Setup Company" SKIP(1) 
              "สำหรับออกงาน  Line70 / 72 : " SKIP(1)
              "ต้องการ Setup Company หรือไม่" VIEW-AS ALERT-BOX  INFORMATION BUTTONS YES-NO
             TITLE "Not Found Company" UPDATE choice AS LOGICAL.
      CASE choice:
      WHEN FALSE THEN /* No */
           DO:
              APPLY "CLOSE" TO THIS-PROCEDURE.
           END.
      WHEN TRUE THEN /* Yes */
           DO:
              RUN pdAddCom.
           END.
      END.
  END.*/

  FIND FIRST Company WHERE length(Company.compno) GE  4 NO-ERROR NO-WAIT.
  IF AVAIL company THEN DO:
      RUN pdDispComp.
      gComp = Company.Compno.
  END.
  ELSE DO:
      DISP "" @ fiCompNo
           "" @ fiBranch
           "" @ fiABNAme
           "" @ fiName  
           "" @ finame2 
           "" @ fiAddr1 
           "" @ fiAddr2 
           "" @ fiAddr3 
           "" @ fiAddr4 
           "" @ fiTelno WITH FRAME frComp.
  END.
  IF CAN-FIND (FIRST Insure WHERE Insure.compno = gComp )  THEN DO:
     RUN PdUpdateQ IN THIS-PROCEDURE.
     APPLY "VALUE-CHANGED" TO brInsure.
  END.
  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI WGWCODEL  _DEFAULT-DISABLE
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
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(WGWCODEL)
  THEN DELETE WIDGET WGWCODEL.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI WGWCODEL  _DEFAULT-ENABLE
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
  DISPLAY fiCompNo fiabname fibranch fiName fiName2 fiAddr1 fiAddr2 fiAddr3 
          fiAddr4 fiTelNo 
      WITH FRAME frComp IN WINDOW WGWCODEL.
  ENABLE RECT-17 RECT-82 RECT-18 RECT-455 btncompfirst btncompprev btncompnext 
         btncomplast fiName2 btncompadd btncompupd btncompdel btncompok 
         btncompreset 
      WITH FRAME frComp IN WINDOW WGWCODEL.
  {&OPEN-BROWSERS-IN-QUERY-frComp}
  VIEW FRAME frmain IN WINDOW WGWCODEL.
  {&OPEN-BROWSERS-IN-QUERY-frmain}
  DISPLAY fiInComp_sh fiInComp fiInBranch fivatcode fiFName fiLName fiInAddr1 
          fiInAddr2 fiInAddr3 fiInAddr4 fiInTelNo fiUser fiFdate 
      WITH FRAME frInsure IN WINDOW WGWCODEL.
  ENABLE fiInComp_sh bu_sch btnFirst btnPrev btnNext btnLast fiInBranch 
         fiInTelNo btninadd btnInUpdate btnInDelete btnInOK btnInCancel fiUser 
         fiFdate RECT-20 RECT-83 RECT-454 RECT-21 RECT-22 
      WITH FRAME frInsure IN WINDOW WGWCODEL.
  {&OPEN-BROWSERS-IN-QUERY-frInsure}
  DISPLAY fi_output 
      WITH FRAME frbrIns IN WINDOW WGWCODEL.
  ENABLE RECT-456 RECT-457 RECT-458 brInsure bu_file bu_imp bu_imp-6 fi_output 
         bu_exit 
      WITH FRAME frbrIns IN WINDOW WGWCODEL.
  {&OPEN-BROWSERS-IN-QUERY-frbrIns}
  VIEW WGWCODEL.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdAddCom WGWCODEL 
PROCEDURE pdAddCom :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ENABLE ALL WITH FRAME frComp.
DISABLE ALL WITH FRAME frInsure.
DISABLE ALL WITH FRAME frbrins.
APPLY "ENTRY" TO fiCompNo IN FRAME frComp.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDDisableComp WGWCODEL 
PROCEDURE PDDisableComp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
  DISABLE 
    fiCompNo fibranch fiAbName  fiName fiName2 fiAddr1 fiAddr2 fiAddr3 fiAddr4 fiTelNo 
    WITH FRAME frComp.
  /* kridtiya in .................
  DISABLE ALL WITH FRAME frinsure.*/
  /*DISABLE brinsure  WITH  FRAME frbrins.*/
  DISABLE    btnCompOK   btnCompReset   WITH FRAME frcomp.
/*  DISABLE   btnCompdet WITH FRAME frCompdet.*/
  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDDispComp WGWCODEL 
PROCEDURE PDDispComp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN
    fiCompNo = Company.Compno
    fiBranch = Company.Branch
    fiABNAme = Company.ABName
    fiName   = Company.NAME
    finame2  = Company.Name2
    fiAddr1  = Company.Addr1
    fiAddr2  = Company.Addr2
    fiAddr3  = Company.Addr3
    fiAddr4  = Company.Addr4
    fiTelno  = Company.Telno
    .
DISP fiCompNo
     fiBranch
     fiABNAme
     fiName  
     finame2 
     fiAddr1 
     fiAddr2 
     fiAddr3 
     fiAddr4 
     fiTelno WITH FRAME frComp.
 DISP fiuser fiFdate WITH FRAME fruser.
 /*FIND FIRST insure USE-INDEX insure01 WHERE insure.compno = ficompno NO-WAIT NO-ERROR.
 IF AVAIL insure  THEN DO:
     ASSIGN
         fiincomp   = insure.insno
         fiInBranch = insure.Branch
         fifNAme    = insure.FName
         fiLName    = insure.LNAME
         fiInAddr1  = insure.Addr1
         fiInAddr2  = insure.Addr2
         fiInAddr3  = insure.Addr3
         fiInAddr4  = insure.Addr4
         fiInTelno  = insure.Telno  .
     DISP fiincomp  
         fiInBranch
         fifNAme   
         fiLName   
         fiInAddr1 
         fiInAddr2 
         fiInAddr3 
         fiInAddr4 
         fiInTelno  
         WITH FRAME frinsure.
 END.*/
  gComp = company.compno.
  RUN pdUpdateQ.
 
 DISP brinsure  WITH FRAME frbrins.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdDispIns WGWCODEL 
PROCEDURE pdDispIns :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DISPLAY 
     Insure.insno     @ fiInComp     
     Insure.Branch    @ fiInBranch
     insure.vatcode   @ fivatcode
     Insure.FName     @ fiFName
     Insure.LName     @ fiLName
     Insure.Addr1     @ fiInAddr1
     Insure.Addr2     @ fiInAddr2     
     Insure.Addr3     @ fiInAddr3
     Insure.Addr4     @ fiInAddr4  
     Insure.TelNo     @ fiInTelNo
     Insure.FDate     @ fiFDate
     Insure.UserNo    @ fiUser
   WITH FRAME frinsure.

  DISP Insure.FDate     @ fiFDate WITH FRAME fruser.
   /*raSex = IF Insure.Sex = "M" THEN 1 ELSE IF Insure.Sex = "F" THEN 2 ELSE 3 .     
   DISP raSex  WITH FRAME {&FRAME-NAME}.*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pddisplogin WGWCODEL 
PROCEDURE pddisplogin :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN
    fiCompNo    = Company.CompNo
    fiABName    = Company.ABName
    fibranch    = Company.Branch
    fiName      = Company.Name
    fiName2     = Company.Name2
    fiAddr1     = Company.Addr1
    fiAddr2     = Company.Addr2
    fiAddr3     = Company.Addr3
    fiAddr4     = Company.Addr4
    fiTelNo     = Company.TelNo
    fiuser      = Company.PowerName.
DISP fiCompNo fiAbName fibranch fiName fiName2
     fiAddr1 fiAddr2 fiAddr3 fiAddr4 fiTelNo WITH FRAME frComp.
FIND FIRST insure USE-INDEX insure01 WHERE
    insure.compno = ficompno NO-WAIT NO-ERROR.
IF AVAIL insure THEN DO:
    ASSIGN
        fiincomp     = insure.insNo
        fiinbranch   = insure.Branch
        fifname      = insure.fname
        filname      = insure.lName
        fiinAddr1    = insure.Addr1  
        fiinAddr2    = insure.Addr2  
        fiinAddr3    = insure.Addr3  
        fiinAddr4    = insure.Addr4  
        fiinTelNo    = insure.telno
        brInsure:Sensitive  IN FRAM frbrins = Yes.   
END.
DISP   fiincomp 
       fiinbranch 
       fifname 
       filname
       fiinAddr1     
       fiinAddr2      
       fiinAddr3   
       fiinAddr4 
       fiinTelNo   WITH FRAME frinsure.
DISP brInsure WITH FRAME frbrins.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdEnable WGWCODEL 
PROCEDURE pdEnable :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ENABLE 
    fiInComp fiInBranch  fivatcode   fiFName 
    fiLName   fiInAddr1 fiInAddr2   fiInAddr3   fiInAddr4  
    fiInTelNo   btnInOK     btnInCancel 
    WITH FRAME frinsure.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdenablecomp WGWCODEL 
PROCEDURE pdenablecomp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ENABLE 
    fiCompNo fibranch fiAbName fiName fiName2 fiAddr1 fiAddr2 fiAddr3 fiAddr4 fiTelNo 
    WITH FRAME frComp.
    ENABLE ALL WITH  FRAME fiinsure.
    ENABLE   btnCompOK btnCompReset   WITH FRAME frcomp.
    
    ENABLE   brinsure   WITH FRAME frbrins.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDInitData WGWCODEL 
PROCEDURE PDInitData :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN 
    FRAME frComp fiCompNo fiCompNo = ""
    FRAME frComp fiABName fiAbName = ""
    FRAME frComp fiName   fiName   = ""
    FRAME frComp fiName2 fiName2 = ""
    FRAME frComp fiAddr1  fiAddr1  = ""
    FRAME frComp fiAddr2  fiAddr2  = ""
    FRAME frComp fiAddr3  fiAddr3  = ""
    FRAME frComp fiAddr4  fiAddr4  = ""
    FRAME frComp fiTelNo fiTelNo = ""

    
    btnCompAdd:Sensitive   IN FRAME frcomp = Yes
    btnCompUpd:Sensitive   IN FRAME frcomp = Yes
    btnCompDel:Sensitive   IN FRAME frcomp = Yes

    btnCompOK:Sensitive    IN FRAME frcomp = No
    btnCompReset:Sensitive IN FRAME frcomp = No    
        
    btnCompFirst:Sensitive IN FRAME frcomp = Yes
    btnCompPrev:Sensitive  IN FRAME frcomp = Yes
    btnCompNext:Sensitive  IN FRAME frcomp = Yes
    btnCompLast:Sensitive  IN FRAME frcomp = Yes
    
    cUpdate = "".
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdUpdateQ WGWCODEL 
PROCEDURE pdUpdateQ :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
OPEN QUERY brInsure  FOR EACH Insure USE-INDEX Insure01 NO-LOCK
            WHERE CompNo = gComp
                    BY Insure.InsNo .
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE ProcDisable WGWCODEL 
PROCEDURE ProcDisable :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DISABLE 
    fiincomp fiinBranch fivatcode fiFName fiLName 
    fiinAddr1  fiinAddr2 fiinAddr3 
    fiinAddr4  fiinTelNo 
  /*fiInsNo*/
  WITH FRAME frinsure.  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE ProcUpdateInsure WGWCODEL 
PROCEDURE ProcUpdateInsure :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF INPUT PARAMETER cmode AS CHAR.
DEF BUFFER bIns FOR Insure.
DEF VAR logAns    AS LOGI INIT No.  
DEF VAR rIns      AS ROWID.
DEF VAR vInsNo    AS INTE INIT 0.
DEF VAR vInsC     AS CHAR FORMAT "X" INIT "W".
DEF VAR vInsFirst AS CHAR.  /* multi  company*/
  /* vComp  = fiInbranch.*/  pComp = fiCompno.
  FIND FIRST Company WHERE Company.CompNo = /*vComp*/ pComp  .
  DO:  vInsFirst = Company.InsNoPrf. END.          
  ASSIGN
    rIns   = ROWID (Insure)
    logAns = No.
    IF cmode = "ADD" THEN DO:
       MESSAGE "เพิ่มข้อมูลรายการดีเลอร์ " UPDATE logAns 
       VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO
       TITLE "เพิ่มข้อมูลรายการดีเลอร์".

       IF logAns THEN DO:
            /*FIND LAST bIns USE-INDEX Insure01 WHERE bIns.CompNo = pComp AND
                                                      bIns.Insno  = fiInComp EXCLUSIVE-LOCK NO-ERROR.
            IF NOT AVAIL bIns THEN DO:
                CREATE insure.
                ASSIGN insure.compno  = ficompno.

            END.*/
         /* FIND LAST bIns   USE-INDEX Insure02 WHERE bIns.CompNo = pComp NO-LOCK NO-ERROR.
          CREATE Insure. *//*
           FIND LAST bIns   USE-INDEX Insure01 WHERE 
                      bIns.CompNo   = pComp   AND
                      bIns.InsNo    = fiInComp AND
                      bIns.FName    = fiFName AND
                      bIns.LName    = fiLName NO-ERROR.
           IF AVAIL Insure THEN DO:
              /*ASSIGN  nv_InsNo = Insure.Insno.*/
           END.
           IF NOT AVAIL Insure THEN DO:
               CREATE Insure.
           END.*/
           FIND LAST bIns   USE-INDEX Insure01 WHERE bIns.CompNo = pComp NO-LOCK NO-ERROR.
           CREATE Insure.
                          
       END.
   
       /*IF logAns THEN DO:
          FIND LAST bIns   USE-INDEX Insure02 WHERE bIns.CompNo = gComp NO-LOCK NO-ERROR.
          CREATE Insure.      
            IF AVAIL bIns THEN DO:                       
               IF LENGTH(bIns.InsNo) = 10 THEN DO:                  
                  IF SUBSTRING (bIns.InsNo,7,4) <> "9999" THEN 
                  ASSIGN 
                    vInsNo = INTEGER (SUBSTRING (bIns.InsNo,7,4))
                    vInsC  = SUBSTRING (bIns.InsNo,3,1).               
                  ELSE 
                  ASSIGN 
                    vInsNo = 0
                    vInsC  = CHR (ASC (SUBSTRING (bIns.InsNo,6,1)) + 1).
                    Insure.InsNo = vInsFirst + vInsC + STRING (vInsNo + 1,"9999").  
               END.
               ELSE DO:
                  IF SUBSTRING (bIns.InsNo,4,4) <> "9999" THEN 
                     ASSIGN 
                      vInsNo = INTEGER (SUBSTRING (bIns.InsNo,4,4))
                      vInsC  = SUBSTRING (bIns.InsNo,3,1).               
                  ELSE 
                  ASSIGN 
                    vInsNo = 0
                    vInsC  = CHR (ASC (SUBSTRING (bIns.InsNo,3,1)) + 1).
                    Insure.InsNo = vInsFirst + vInsC + STRING (vInsNo + 1,"9999").  
               END.      
            END.  
            ELSE 
                Insure.InsNo = vInsFirst + Company.InsNoStr + "0001".   
       END. 
       ELSE RETURN NO-APPLY.*/
    END. /* ADD */
    ELSE IF cmode = "UPDATE" THEN DO WITH FRAME frbrins /*{&FRAME-NAME}*/:
         GET CURRENT brInsure EXCLUSIVE-LOCK.
    END. 
        
    ASSIGN 
        /*fiTitle */
        FRAME frcomp    ficompno
        FRAME frInsure  fiIncomp
        FRAME frInsure  fiInBranch
        FRAME frinsure  fivatcode
        FRAME frInsure  fiFName  
        FRAME frInsure  fiLName 
        FRAME frInsure  fiInAddr1 
        FRAME frInsure  fiInAddr2 
        FRAME frInsure  fiInAddr3 
        FRAME frInsure  fiInAddr4
        FRAME frInsure  fiInTelNo

        insure.compno  = ficompno
        Insure.Branch  = fiInBranch
        insure.vatcode = fivatcode
        Insure.InsNo  = fiInComp
        Insure.FName  = fiFName
        Insure.LName  = fiLName
        Insure.Addr1  = fiInAddr1
        Insure.Addr2  = fiInAddr2
        Insure.Addr3  = fiInAddr3
        Insure.Addr4  = fiInAddr4  
        Insure.TelNo  = fiInTelNo
        Insure.FDate  = TODAY
        Insure.UserNo = n_user
        Insure.TelNo  = fiInTelNo
        btnFirst:Sensitive IN FRAM frinsure = Yes
        btnPrev:Sensitive  IN FRAM frinsure = Yes
        btnNext:Sensitive  IN FRAM frinsure = Yes
        btnLast:Sensitive  IN FRAM frinsure = Yes
          
        btnInAdd:Sensitive    IN FRAM frinsure = Yes
        btnInUpdate:Sensitive IN FRAM frinsure = Yes
        btnInDelete:Sensitive IN FRAM frinsure = Yes
          
        btnInOK:Sensitive     IN FRAM frinsure = No
        btnInCancel:Sensitive IN FRAM frinsure = NO
        brInsure:Sensitive  IN FRAM frbrins = Yes.   
        
    RUN PDUpdateQ.
    APPLY "VALUE-CHANGED" TO brInsure IN FRAME frbrins.
    /*RUN ProcDisable IN THIS-PROCEDURE.*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_importfile WGWCODEL 
PROCEDURE proc_importfile :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: create by : Ranu i. A60-0261 date 09/06/2017     
------------------------------------------------------------------------------*/
FOR EACH wdetail .
    FIND LAST sicsyac.xmm600 USE-INDEX xmm60001 WHERE 
        sicsyac.xmm600.acno = wdetail.Producer  NO-LOCK NO-ERROR NO-WAIT.
    IF NOT AVAIL sicsyac.xmm600 THEN
        ASSIGN wdetail.Producer = "".
    FIND LAST sicsyac.xmm600 USE-INDEX xmm60001 WHERE 
        sicsyac.xmm600.acno = wdetail.Agent  NO-LOCK NO-ERROR NO-WAIT.
    IF NOT AVAIL sicsyac.xmm600 THEN
        ASSIGN wdetail.Agent = "".
END.

FOR EACH wdetail.
    FIND FIRST stat.company USE-INDEX company03 WHERE
        stat.company.compno = ficompno      AND 
        stat.company.branch = fibranch     NO-ERROR NO-WAIT.
    IF AVAIL company THEN DO:
        FIND FIRST stat.insure USE-INDEX insure01  WHERE 
                stat.insure.compno = company.compno     AND   
                stat.insure.insno  = trim(wdetail.Delerno)    /*AND 
                stat.insure.fname  = trim(wdetail.Deler_Name) AND   
                stat.insure.lname  = trim(wdetail.Show_room)  AND   
                stat.insure.branch = trim(wdetail.Branch) */    NO-ERROR NO-WAIT.
            IF  AVAIL stat.insure THEN DO:  /* update data */
                ASSIGN                                                                      
                    stat.insure.compno     = trim(wdetail.Company)      /*Company   */      
                    stat.insure.insno      = trim(wdetail.Delerno)      /*Delerno   */      
                    stat.insure.vatcode    = trim(wdetail.Vatcode)      /*Vatcode.  */      
                    stat.insure.fname      = trim(wdetail.Deler_Name)   /*Deler Name*/      
                    stat.insure.lname      = trim(wdetail.Show_room)    /*Show room */      
                    stat.insure.branch     = trim(wdetail.Branch)       /*Branch    */      
                    stat.Insure.Addr3      = trim(wdetail.nSTATUS)      /*Status    */      
                    stat.insure.addr1      = trim(wdetail.Producer)     /*Producer  */      
                    stat.insure.addr2      = trim(wdetail.Agent)        /*Agent     */      
                    stat.Insure.Addr4      = trim(wdetail.addr4)        /*addr4     */      
                    stat.Insure.TelNo      = trim(wdetail.Tel)          /*Tel       */      
                    stat.Insure.FDate      = TODAY                                          
                    stat.Insure.UserNo     = n_user  .  
            END.
            ELSE DO: /* Create data*/
                CREATE stat.insure.
                ASSIGN
                    stat.insure.compno     = trim(wdetail.Company)      /*Company   */  
                    stat.insure.insno      = trim(wdetail.Delerno)      /*Delerno   */  
                    stat.insure.vatcode    = trim(wdetail.Vatcode)      /*Vatcode.  */  
                    stat.insure.fname      = trim(wdetail.Deler_Name)   /*Deler Name*/  
                    stat.insure.lname      = trim(wdetail.Show_room)    /*Show room */  
                    stat.insure.branch     = trim(wdetail.Branch)       /*Branch    */  
                    stat.Insure.Addr3      = trim(wdetail.nSTATUS)      /*Status    */  
                    stat.insure.addr1      = trim(wdetail.Producer)     /*Producer  */  
                    stat.insure.addr2      = trim(wdetail.Agent)        /*Agent     */  
                    stat.Insure.Addr4      = trim(wdetail.addr4)        /*addr4     */  
                    stat.Insure.TelNo      = trim(wdetail.Tel)          /*Tel       */  
                    stat.Insure.FDate      = TODAY                   
                    stat.Insure.UserNo     = n_user  .                
            END.
    END.
    ELSE MESSAGE "Not found Company code & branch :" ficompno fibranch    VIEW-AS ALERT-BOX.
END.
fi_output = "".
RELEASE stat.company. 
RELEASE stat.insure.  

MESSAGE "Import File Dealer Code Complete " VIEW-AS ALERT-BOX.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

