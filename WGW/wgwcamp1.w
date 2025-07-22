&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          brstat           PROGRESS
*/
&Scoped-define WINDOW-NAME wgwcamp1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS wgwcamp1 
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
/*Modify by Kridtiya i. A56-0037 เปิดส่วนการทำงานปุ่มลบข้อมูล     */
/*Modify by Kridtiya i. A56-0118 เปิดส่วนการทำงานปุ่มแสดงข้อมูล ตามปุ่มหน้าหลัง    */
CREATE WIDGET-POOL.

/* ***************************  Definitions  ************************** */

/* Parameters Definitions ---                                           */

/* Local Variable Definitions ---                                       */

/*{wuw/wuwm0001.i}*/

DEF SHARED VAR n_User     AS CHAR.
DEF SHARED VAR n_Passwd   AS CHAR.

DEF VAR    cUpdate AS CHAR.
DEF BUFFER bComp   FOR brstat.Company.
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
DEFINE NEW SHARED WORKFILE wdetail2 NO-UNDO
    FIELD id       AS CHAR FORMAT "x(10)" INIT ""             
    FIELD tarif    AS CHAR FORMAT "x(1)"  INIT ""          
    FIELD covcod   AS CHAR FORMAT "x(1)"  INIT ""      
    FIELD tp_per   AS CHAR FORMAT "x(30)" INIT ""
    FIELD tp_acc   AS CHAR FORMAT "x(30)" INIT ""
    FIELD tp_acc2  AS CHAR FORMAT "x(30)" INIT ""
    FIELD tp_41    AS CHAR FORMAT "x(30)" INIT ""
    FIELD tp_42    AS CHAR FORMAT "x(30)" INIT ""
    FIELD tp_43    AS CHAR FORMAT "x(30)" INIT ""       
    FIELD brand    AS CHAR FORMAT "x(30)" INIT ""           
    FIELD model    AS CHAR FORMAT "x(60)" INIT ""          
    FIELD pack     AS CHAR FORMAT "x(5)"  INIT ""          
    FIELD sumins   AS CHAR FORMAT "x(30)" INIT ""      
    FIELD base     AS CHAR FORMAT "x(30)" INIT ""        
    FIELD ncb      AS CHAR FORMAT "x(20)" INIT ""       
    FIELD dspc     AS CHAR FORMAT "x(20)" INIT ""     
    FIELD engcc    AS CHAR FORMAT "x(20)" INIT ""
    FIELD seat41   AS CHAR FORMAT "x(3)"  INIT ""
    FIELD producer AS CHAR FORMAT "x(10)" INIT ""  /*Add A57-0125*/
    FIELD seats    AS CHAR FORMAT "x(2)"  INIT "".

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
Insure.FName Insure.VatCode Insure.Text3 Insure.Text4 Insure.Text5 ~
Insure.Deci1 Insure.Deci2 Insure.ICNo Insure.LName Insure.Branch ~
Insure.Addr1 Insure.Addr2 Insure.Addr3 Insure.Addr4 Insure.TelNo ~
Insure.ICAddr1 Insure.Text1 Insure.Text2 
&Scoped-define ENABLED-FIELDS-IN-QUERY-brInsure 
&Scoped-define QUERY-STRING-brInsure FOR EACH Insure NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-brInsure OPEN QUERY brInsure FOR EACH Insure NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-brInsure Insure
&Scoped-define FIRST-TABLE-IN-QUERY-brInsure Insure


/* Definitions for FRAME frbrIns                                        */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS brInsure 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR wgwcamp1 AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
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
     SIZE 5.5 BY 1.

DEFINE BUTTON btncomplast 
     IMAGE-UP FILE "adeicon\pvlast":U
     IMAGE-DOWN FILE "adeicon\pvlastd":U
     IMAGE-INSENSITIVE FILE "adeicon\pvlastx":U
     LABEL ">>" 
     SIZE 5.5 BY 1.

DEFINE BUTTON btncompnext 
     IMAGE-UP FILE "adeicon\pvforw":U
     IMAGE-DOWN FILE "adeicon\pvforwd":U
     IMAGE-INSENSITIVE FILE "adeicon\pvforwx":U
     LABEL ">" 
     SIZE 6 BY 1.

DEFINE BUTTON btncompok 
     LABEL "OK" 
     SIZE 11 BY 1
     FONT 6.

DEFINE BUTTON btncompprev 
     IMAGE-UP FILE "adeicon\pvback":U
     IMAGE-DOWN FILE "adeicon\pvbackd":U
     IMAGE-INSENSITIVE FILE "adeicon\pvbackx":U
     LABEL "<" 
     SIZE 5.5 BY 1.

DEFINE BUTTON btncompreset 
     LABEL "Cancel" 
     SIZE 11 BY 1
     FONT 6.

DEFINE BUTTON btncompupd 
     LABEL "แก้ไข" 
     SIZE 11 BY 1
     FONT 6.

DEFINE VARIABLE fiabname AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 11.67 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiAddr1 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 50 BY 1
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

DEFINE VARIABLE fibranch AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 5 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiCompNo AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 23.5 BY .95
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
     SIZE 25.5 BY 1.52
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-455
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 63.17 BY 9.29.

DEFINE RECTANGLE RECT-82
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 24.83 BY 1.62
     BGCOLOR 1 .

DEFINE BUTTON btnFirst 
     IMAGE-UP FILE "adeicon\pvfirst":U
     IMAGE-DOWN FILE "adeicon\pvfirstd":U
     IMAGE-INSENSITIVE FILE "adeicon\pvfirstx":U
     LABEL "<<" 
     SIZE 5.5 BY 1.

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
     SIZE 5.5 BY 1.

DEFINE BUTTON btnNext 
     IMAGE-UP FILE "adeicon\pvforw":U
     IMAGE-DOWN FILE "adeicon\pvforwd":U
     IMAGE-INSENSITIVE FILE "adeicon\pvforwx":U
     LABEL ">" 
     SIZE 6 BY 1.

DEFINE BUTTON btnPrev 
     IMAGE-UP FILE "adeicon\pvback":U
     IMAGE-DOWN FILE "adeicon\pvbackd":U
     IMAGE-INSENSITIVE FILE "adeicon\pvbackx":U
     LABEL "<" 
     SIZE 5.5 BY 1.

DEFINE VARIABLE fibase AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 10 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fibrand AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fidspc AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 8 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiengcc AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 12 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiFName AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 5 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiInAddr1 AS DECIMAL FORMAT "->>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 18 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiInAddr2 AS DECIMAL FORMAT "->>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 18 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiInAddr3 AS DECIMAL FORMAT "->>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 18 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiInAddr4 AS DECIMAL FORMAT "->>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 18 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiInBranch AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 8 BY .95
     BGCOLOR 15 FGCOLOR 1 FONT 2 NO-UNDO.

DEFINE VARIABLE fiInComp AS CHARACTER FORMAT "X(35)":U 
     VIEW-AS FILL-IN 
     SIZE 21.5 BY .95
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fiInproducer AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 12.5 BY .95
     BGCOLOR 15 FGCOLOR 1 FONT 2 NO-UNDO.

DEFINE VARIABLE fiInTelNo AS DECIMAL FORMAT "->>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 18 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiLName AS DECIMAL FORMAT "->>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 18 BY .95
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fimodel AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 30 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fincb AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 7 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fipack AS CHARACTER FORMAT "X(4)":U 
     VIEW-AS FILL-IN 
     SIZE 7 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiseat41 AS CHARACTER FORMAT "X(3)":U 
     VIEW-AS FILL-IN 
     SIZE 3.5 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiseats AS CHARACTER FORMAT "X(2)":U INITIAL "0" 
     VIEW-AS FILL-IN 
     SIZE 7 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fisumin AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 12 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fivatcode AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 8 BY .95
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-20
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 36.5 BY 1.76
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-21
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 27.17 BY 1.52
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-454
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 64.5 BY 11.71.

DEFINE RECTANGLE RECT-83
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 24.83 BY 1.76
     BGCOLOR 1 .

DEFINE BUTTON btnReturn 
     LABEL "EXIT" 
     SIZE 9.83 BY 1.19
     FONT 6.

DEFINE RECTANGLE RECT-84
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 14.67 BY 2.52
     BGCOLOR 4 .

DEFINE BUTTON bu_exp 
     LABEL "EXP" 
     SIZE 6 BY .95.

DEFINE BUTTON bu_im 
     LABEL "....." 
     SIZE 5.5 BY .95.

DEFINE BUTTON bu_imp 
     LABEL "IMP" 
     SIZE 6 BY .95.

DEFINE VARIABLE fiFdate AS DATE FORMAT "99/99/9999":U 
      VIEW-AS TEXT 
     SIZE 14 BY .95
     BGCOLOR 5  NO-UNDO.

DEFINE VARIABLE fiUser AS CHARACTER FORMAT "X(10)":U 
      VIEW-AS TEXT 
     SIZE 14 BY .95
     BGCOLOR 5 FGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_filename AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 50 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_fileout AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 50 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE RECTANGLE RECT-456
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 15 BY 2.33
     BGCOLOR 8 .

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY brInsure FOR 
      Insure SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE brInsure
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS brInsure wgwcamp1 _STRUCTURED
  QUERY brInsure NO-LOCK DISPLAY
      Insure.CompNo COLUMN-LABEL "Name" FORMAT "X(20)":U WIDTH 12.83
      Insure.InsNo COLUMN-LABEL "Campaign no." FORMAT "X(15)":U
            WIDTH 13.33
      Insure.FName COLUMN-LABEL "Class" FORMAT "X(10)":U WIDTH 5
      Insure.VatCode COLUMN-LABEL "Cover" FORMAT "X(7)":U WIDTH 4.83
      Insure.Text3 COLUMN-LABEL "Pack" FORMAT "x(5)":U WIDTH 4.5
      Insure.Text4 COLUMN-LABEL "sumin" FORMAT "x(15)":U WIDTH 11.5
      Insure.Text5 COLUMN-LABEL "Base" FORMAT "x(10)":U WIDTH 7
      Insure.Deci1 COLUMN-LABEL "NCB" FORMAT "->>>,>>>,>>9.99":U
            WIDTH 4.83
      Insure.Deci2 COLUMN-LABEL "Dspc" FORMAT "->>>,>>>,>>9.99":U
            WIDTH 4.83
      Insure.ICNo COLUMN-LABEL "EngCC." FORMAT "x(20)":U WIDTH 7.5
      Insure.LName COLUMN-LABEL "Per Person (BI)" FORMAT "X(50)":U
            WIDTH 10.33
      Insure.Branch COLUMN-LABEL "Tariff" FORMAT "X(5)":U WIDTH 4.33
      Insure.Addr1 COLUMN-LABEL "Per Accident" FORMAT "X(50)":U
            WIDTH 9.83
      Insure.Addr2 COLUMN-LABEL "Per Accident" FORMAT "X(50)":U
            WIDTH 8.83
      Insure.Addr3 COLUMN-LABEL "4.1" FORMAT "X(50)":U WIDTH 8
      Insure.Addr4 COLUMN-LABEL "4.2" FORMAT "X(20)":U WIDTH 8
      Insure.TelNo COLUMN-LABEL "4.3" FORMAT "X(30)":U WIDTH 10.5
      Insure.ICAddr1 COLUMN-LABEL "Seat41" FORMAT "x(3)":U
      Insure.Text1 COLUMN-LABEL "ยี่ห้อ" FORMAT "X(50)":U WIDTH 20.33
      Insure.Text2 COLUMN-LABEL "Model" FORMAT "X(40)":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 131 BY 8.52
         BGCOLOR 15 FGCOLOR 0 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME frmain
     btnReturn AT ROW 22.81 COL 121.17
     RECT-84 AT ROW 22.1 COL 118.67
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 132.5 BY 23.91
         BGCOLOR 8 .

DEFINE FRAME frUser
     fi_filename AT ROW 1.24 COL 45.83 COLON-ALIGNED NO-LABEL
     bu_im AT ROW 1.24 COL 102.5
     bu_imp AT ROW 1.24 COL 108.67
     fi_fileout AT ROW 2.33 COL 45.83 COLON-ALIGNED NO-LABEL
     bu_exp AT ROW 2.38 COL 102.5
     fiUser AT ROW 1.24 COL 15 COLON-ALIGNED NO-LABEL
     fiFdate AT ROW 2.33 COL 15 COLON-ALIGNED NO-LABEL
     "IMPORT FILE" VIEW-AS TEXT
          SIZE 15 BY .95 AT ROW 2.33 COL 32.33
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "User ID" VIEW-AS TEXT
          SIZE 8 BY .95 AT ROW 1.24 COL 5.83
          BGCOLOR 5 FGCOLOR 15 FONT 6
     "Date" VIEW-AS TEXT
          SIZE 8 BY .95 AT ROW 2.33 COL 6.17
          BGCOLOR 5 FGCOLOR 15 FONT 6
     "IMPORT FILE" VIEW-AS TEXT
          SIZE 15 BY .95 AT ROW 1.24 COL 32.33
          BGCOLOR 18 FGCOLOR 1 FONT 6
     RECT-456 AT ROW 1.1 COL 101.33
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 22.1
         SIZE 117.5 BY 2.5
         BGCOLOR 3 .

DEFINE FRAME frbrIns
     brInsure AT ROW 1.24 COL 1.5
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 13.05
         SIZE 132.5 BY 9
         BGCOLOR 18 .

DEFINE FRAME frComp
     fiCompNo AT ROW 1.52 COL 10.83 COLON-ALIGNED NO-LABEL
     btncompfirst AT ROW 1.52 COL 38.83
     btncompprev AT ROW 1.52 COL 44.5
     btncompnext AT ROW 1.52 COL 50.17
     btncomplast AT ROW 1.52 COL 56.67
     fiabname AT ROW 2.57 COL 10.83 COLON-ALIGNED NO-LABEL
     fibranch AT ROW 2.57 COL 29.33 COLON-ALIGNED NO-LABEL
     fiName AT ROW 3.62 COL 10.83 COLON-ALIGNED NO-LABEL
     fiName2 AT ROW 4.67 COL 10.83 COLON-ALIGNED NO-LABEL
     fiAddr1 AT ROW 5.71 COL 10.83 COLON-ALIGNED NO-LABEL
     fiAddr2 AT ROW 6.81 COL 10.83 COLON-ALIGNED NO-LABEL
     fiAddr3 AT ROW 7.86 COL 10.83 COLON-ALIGNED NO-LABEL
     fiAddr4 AT ROW 8.91 COL 10.83 COLON-ALIGNED NO-LABEL
     fiTelNo AT ROW 8.91 COL 43 COLON-ALIGNED NO-LABEL
     btncompadd AT ROW 10.91 COL 3.67
     btncompupd AT ROW 10.91 COL 14.83
     btncompdel AT ROW 10.91 COL 26
     btncompok AT ROW 10.91 COL 40.5
     btncompreset AT ROW 10.91 COL 51.83
     "โทรศัพท์" VIEW-AS TEXT
          SIZE 8 BY .95 AT ROW 8.91 COL 36.17
          BGCOLOR 8 FGCOLOR 1 
     "ที่อยู่" VIEW-AS TEXT
          SIZE 9.5 BY .95 AT ROW 5.71 COL 3
          BGCOLOR 8 FGCOLOR 1 
     "Branch" VIEW-AS TEXT
          SIZE 6 BY .95 AT ROW 2.57 COL 24.83
          BGCOLOR 8 FGCOLOR 1 
     "ชื่อบริษัท" VIEW-AS TEXT
          SIZE 9.5 BY .95 AT ROW 3.62 COL 3
          BGCOLOR 8 FGCOLOR 1 
     "อักษรหลังปี" VIEW-AS TEXT
          SIZE 9.5 BY .95 AT ROW 2.57 COL 3
          BGCOLOR 8 FGCOLOR 1 
     "รหัสบริษัท" VIEW-AS TEXT
          SIZE 9.5 BY .95 AT ROW 1.52 COL 3
          BGCOLOR 8 FGCOLOR 1 
     "ชื่อ 2" VIEW-AS TEXT
          SIZE 9.5 BY .95 AT ROW 4.67 COL 3
          BGCOLOR 8 FGCOLOR 1 
     RECT-17 AT ROW 10.57 COL 2
     RECT-82 AT ROW 10.57 COL 39.17
     RECT-18 AT ROW 1.33 COL 37.5
     RECT-455 AT ROW 1.1 COL 1.83
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 66 BY 12
         BGCOLOR 31 .

DEFINE FRAME frInsure
     btnFirst AT ROW 1.62 COL 39
     btnPrev AT ROW 1.62 COL 44.67
     btnNext AT ROW 1.62 COL 50.33
     btnLast AT ROW 1.62 COL 56.67
     fiInComp AT ROW 2.05 COL 12.5 COLON-ALIGNED NO-LABEL
     fiInproducer AT ROW 3.1 COL 9 COLON-ALIGNED NO-LABEL
     fiInBranch AT ROW 3.1 COL 27.5 COLON-ALIGNED NO-LABEL
     fivatcode AT ROW 3.1 COL 42.33 COLON-ALIGNED NO-LABEL
     fiFName AT ROW 3.1 COL 56 COLON-ALIGNED NO-LABEL
     fiLName AT ROW 4.1 COL 15.67 COLON-ALIGNED NO-LABEL
     fiInAddr1 AT ROW 5.1 COL 34.67 RIGHT-ALIGNED NO-LABEL
     fiInAddr2 AT ROW 6.1 COL 34.67 RIGHT-ALIGNED NO-LABEL
     fiInAddr3 AT ROW 4.1 COL 62 RIGHT-ALIGNED NO-LABEL
     fiInAddr4 AT ROW 5.1 COL 62 RIGHT-ALIGNED NO-LABEL
     fiInTelNo AT ROW 6.1 COL 43 COLON-ALIGNED NO-LABEL
     fibrand AT ROW 7.1 COL 7.25 COLON-ALIGNED NO-LABEL
     fimodel AT ROW 7.1 COL 28.83 COLON-ALIGNED NO-LABEL
     fipack AT ROW 8.1 COL 7.25 COLON-ALIGNED NO-LABEL
     fisumin AT ROW 8.1 COL 22.17 COLON-ALIGNED NO-LABEL
     fibase AT ROW 8.1 COL 40.33 COLON-ALIGNED NO-LABEL
     fincb AT ROW 8.1 COL 56.17 COLON-ALIGNED NO-LABEL
     fidspc AT ROW 9.1 COL 7.25 COLON-ALIGNED NO-LABEL
     fiengcc AT ROW 9.1 COL 22.17 COLON-ALIGNED NO-LABEL
     fiseats AT ROW 9.1 COL 41.17 COLON-ALIGNED NO-LABEL
     fiseat41 AT ROW 9.1 COL 56.33 COLON-ALIGNED NO-LABEL
     btninadd AT ROW 11 COL 3.5
     btnInUpdate AT ROW 11 COL 14.83
     btnInDelete AT ROW 11 COL 26.17
     btnInOK AT ROW 11 COL 40
     btnInCancel AT ROW 11 COL 51.67
     "EngCC:" VIEW-AS TEXT
          SIZE 6 BY .95 AT ROW 9.1 COL 17.67
          BGCOLOR 20 FGCOLOR 15 
     "Tariff" VIEW-AS TEXT
          SIZE 5 BY .95 AT ROW 3.1 COL 52.67
          BGCOLOR 20 FGCOLOR 15 
     "Seats41:" VIEW-AS TEXT
          SIZE 7 BY .95 AT ROW 9.1 COL 50.83
          BGCOLOR 20 FGCOLOR 15 
     "Brand :" VIEW-AS TEXT
          SIZE 6 BY .95 AT ROW 7.1 COL 2.67
          BGCOLOR 20 FGCOLOR 15 
     "4.3 :" VIEW-AS TEXT
          SIZE 8 BY .95 AT ROW 6.1 COL 36.5
          BGCOLOR 20 FGCOLOR 15 FONT 1
     "Producer" VIEW-AS TEXT
          SIZE 8 BY .95 AT ROW 3.1 COL 2.67
          BGCOLOR 20 FGCOLOR 15 
     "Model :" VIEW-AS TEXT
          SIZE 6.5 BY .95 AT ROW 7.1 COL 24
          BGCOLOR 20 FGCOLOR 15 
     "Pack :" VIEW-AS TEXT
          SIZE 6 BY .95 AT ROW 8.1 COL 2.67
          BGCOLOR 20 FGCOLOR 15 
     "Seats :" VIEW-AS TEXT
          SIZE 6 BY .95 AT ROW 9.1 COL 36.67
          BGCOLOR 20 FGCOLOR 15 
     "Sum SI :" VIEW-AS TEXT
          SIZE 7 BY .95 AT ROW 8.1 COL 16.83
          BGCOLOR 20 FGCOLOR 15 
     "Dspc :" VIEW-AS TEXT
          SIZE 6 BY .95 AT ROW 9.1 COL 2.67
          BGCOLOR 20 FGCOLOR 15 
     "  Per Accident     :" VIEW-AS TEXT
          SIZE 14.5 BY .95 AT ROW 5.1 COL 2.67
          BGCOLOR 20 FGCOLOR 15 
     "Base :" VIEW-AS TEXT
          SIZE 5.5 BY .95 AT ROW 8.1 COL 36.5
          BGCOLOR 20 FGCOLOR 15 
     " Class" VIEW-AS TEXT
          SIZE 5 BY .95 AT ROW 3.1 COL 24
          BGCOLOR 20 FGCOLOR 15 
     "NCB :" VIEW-AS TEXT
          SIZE 5 BY .95 AT ROW 8.1 COL 52.83
          BGCOLOR 20 FGCOLOR 15 
     "4.2   :" VIEW-AS TEXT
          SIZE 8 BY .95 AT ROW 5.1 COL 36.5
          BGCOLOR 20 FGCOLOR 15 
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 67 ROW 1
         SIZE 66 BY 12
         BGCOLOR 5 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME frInsure
     "Cover" VIEW-AS TEXT
          SIZE 6 BY .95 AT ROW 3.1 COL 38
          BGCOLOR 20 FGCOLOR 15 
     "  Per Person (BI)  :" VIEW-AS TEXT
          SIZE 14.5 BY .95 AT ROW 4.1 COL 2.67
          BGCOLOR 20 FGCOLOR 15 
     "Campaign no.:" VIEW-AS TEXT
          SIZE 11.5 BY .95 AT ROW 2.05 COL 2.67
          BGCOLOR 18 FGCOLOR 15 
     "4.1   :" VIEW-AS TEXT
          SIZE 8 BY .95 AT ROW 4.1 COL 36.5
          BGCOLOR 20 FGCOLOR 15 
     "Per Accident (PD):" VIEW-AS TEXT
          SIZE 14.5 BY .95 AT ROW 6.1 COL 2.67
          BGCOLOR 20 FGCOLOR 15 
     RECT-20 AT ROW 10.57 COL 2
     RECT-83 AT ROW 10.57 COL 39
     RECT-454 AT ROW 1.19 COL 1.5
     RECT-21 AT ROW 1.38 COL 37
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 67 ROW 1
         SIZE 66 BY 12
         BGCOLOR 5 .


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
  CREATE WINDOW wgwcamp1 ASSIGN
         HIDDEN             = YES
         TITLE              = "Set Campaign Code (wgwcanp1.w)"
         HEIGHT             = 23.91
         WIDTH              = 132.5
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
/* SETTINGS FOR WINDOW wgwcamp1
  VISIBLE,,RUN-PERSISTENT                                               */
/* REPARENT FRAME */
ASSIGN FRAME frbrIns:FRAME = FRAME frmain:HANDLE
       FRAME frComp:FRAME = FRAME frmain:HANDLE
       FRAME frInsure:FRAME = FRAME frmain:HANDLE
       FRAME frUser:FRAME = FRAME frmain:HANDLE.

/* SETTINGS FOR FRAME frbrIns
   FRAME-NAME                                                           */
/* BROWSE-TAB brInsure 1 frbrIns */
ASSIGN 
       brInsure:SEPARATOR-FGCOLOR IN FRAME frbrIns      = 0.

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
/* SETTINGS FOR FILL-IN fiName2 IN FRAME frComp
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fiTelNo IN FRAME frComp
   NO-ENABLE                                                            */
/* SETTINGS FOR FRAME frInsure
   Custom                                                               */
/* SETTINGS FOR FILL-IN fibase IN FRAME frInsure
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fibrand IN FRAME frInsure
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fidspc IN FRAME frInsure
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fiengcc IN FRAME frInsure
   NO-ENABLE                                                            */
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
/* SETTINGS FOR FILL-IN fiInTelNo IN FRAME frInsure
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fiLName IN FRAME frInsure
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fimodel IN FRAME frInsure
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fincb IN FRAME frInsure
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fipack IN FRAME frInsure
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fiseat41 IN FRAME frInsure
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fiseats IN FRAME frInsure
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fisumin IN FRAME frInsure
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fivatcode IN FRAME frInsure
   NO-ENABLE                                                            */
/* SETTINGS FOR FRAME frmain
   Custom                                                               */

DEFINE VARIABLE XXTABVALXX AS LOGICAL NO-UNDO.

ASSIGN XXTABVALXX = FRAME frUser:MOVE-BEFORE-TAB-ITEM (btnReturn:HANDLE IN FRAME frmain)
       XXTABVALXX = FRAME frbrIns:MOVE-AFTER-TAB-ITEM (btnReturn:HANDLE IN FRAME frmain)
/* END-ASSIGN-TABS */.

/* SETTINGS FOR FRAME frUser
                                                                        */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(wgwcamp1)
THEN wgwcamp1:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE brInsure
/* Query rebuild information for BROWSE brInsure
     _TblList          = "brstat.Insure"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _FldNameList[1]   > brstat.Insure.CompNo
"Insure.CompNo" "Name" "X(20)" "character" ? ? ? ? ? ? no ? no no "12.83" yes no no "U" "" ""
     _FldNameList[2]   > brstat.Insure.InsNo
"Insure.InsNo" "Campaign no." "X(15)" "character" ? ? ? ? ? ? no ? no no "13.33" yes no no "U" "" ""
     _FldNameList[3]   > brstat.Insure.FName
"Insure.FName" "Class" "X(10)" "character" ? ? ? ? ? ? no ? no no "5" yes no no "U" "" ""
     _FldNameList[4]   > brstat.Insure.VatCode
"Insure.VatCode" "Cover" ? "character" ? ? ? ? ? ? no ? no no "4.83" yes no no "U" "" ""
     _FldNameList[5]   > brstat.Insure.Text3
"Insure.Text3" "Pack" "x(5)" "character" ? ? ? ? ? ? no ? no no "4.5" yes no no "U" "" ""
     _FldNameList[6]   > brstat.Insure.Text4
"Insure.Text4" "sumin" "x(15)" "character" ? ? ? ? ? ? no ? no no "11.5" yes no no "U" "" ""
     _FldNameList[7]   > brstat.Insure.Text5
"Insure.Text5" "Base" "x(10)" "character" ? ? ? ? ? ? no ? no no "7" yes no no "U" "" ""
     _FldNameList[8]   > brstat.Insure.Deci1
"Insure.Deci1" "NCB" ? "decimal" ? ? ? ? ? ? no ? no no "4.83" yes no no "U" "" ""
     _FldNameList[9]   > brstat.Insure.Deci2
"Insure.Deci2" "Dspc" ? "decimal" ? ? ? ? ? ? no ? no no "4.83" yes no no "U" "" ""
     _FldNameList[10]   > brstat.Insure.ICNo
"Insure.ICNo" "EngCC." ? "character" ? ? ? ? ? ? no ? no no "7.5" yes no no "U" "" ""
     _FldNameList[11]   > brstat.Insure.LName
"Insure.LName" "Per Person (BI)" ? "character" ? ? ? ? ? ? no ? no no "10.33" yes no no "U" "" ""
     _FldNameList[12]   > brstat.Insure.Branch
"Insure.Branch" "Tariff" "X(5)" "character" ? ? ? ? ? ? no ? no no "4.33" yes no no "U" "" ""
     _FldNameList[13]   > brstat.Insure.Addr1
"Insure.Addr1" "Per Accident" ? "character" ? ? ? ? ? ? no ? no no "9.83" yes no no "U" "" ""
     _FldNameList[14]   > brstat.Insure.Addr2
"Insure.Addr2" "Per Accident" ? "character" ? ? ? ? ? ? no ? no no "8.83" yes no no "U" "" ""
     _FldNameList[15]   > brstat.Insure.Addr3
"Insure.Addr3" "4.1" ? "character" ? ? ? ? ? ? no ? no no "8" yes no no "U" "" ""
     _FldNameList[16]   > brstat.Insure.Addr4
"Insure.Addr4" "4.2" ? "character" ? ? ? ? ? ? no ? no no "8" yes no no "U" "" ""
     _FldNameList[17]   > brstat.Insure.TelNo
"Insure.TelNo" "4.3" ? "character" ? ? ? ? ? ? no ? no no "10.5" yes no no "U" "" ""
     _FldNameList[18]   > brstat.Insure.ICAddr1
"Insure.ICAddr1" "Seat41" "x(3)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[19]   > brstat.Insure.Text1
"Insure.Text1" "ยี่ห้อ" ? "character" ? ? ? ? ? ? no ? no no "20.33" yes no no "U" "" ""
     _FldNameList[20]   > brstat.Insure.Text2
"Insure.Text2" "Model" "X(40)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _Query            is NOT OPENED
*/  /* BROWSE brInsure */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME wgwcamp1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wgwcamp1 wgwcamp1
ON END-ERROR OF wgwcamp1 /* Set Campaign Code (wgwcanp1.w) */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wgwcamp1 wgwcamp1
ON WINDOW-CLOSE OF wgwcamp1 /* Set Campaign Code (wgwcanp1.w) */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME brInsure
&Scoped-define SELF-NAME brInsure
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brInsure wgwcamp1
ON MOUSE-SELECT-CLICK OF brInsure IN FRAME frbrIns
DO:
    /*GET CURRENT brInsure.
    RUN PdDispIns IN THIS-PROCEDURE. 
    FIND CURRENT Insure NO-LOCK.
    IF NOT AVAIL Insure THEN RETURN NO-APPLY.
    IF AVAIL Insure AND Insure.CompNo = pComp THEN DO:
        pRowIns = ROWID (Insure).
        /*RUN PdDispIns IN THIS-PROCEDURE. */
        DISPLAY /*insure.compno  @ ficompno*/
        Insure.FName   @ fiInBranch
        Insure.Branch  @ fiFName
        Insure.InsNo   @ fiInComp
        insure.vatcode @ fivatcode
        Insure.LName   @ fiLName           
        Insure.Addr1   @ fiInAddr1         
        Insure.Addr2   @ fiInAddr2
        Insure.Addr3   @ fiInAddr3
        Insure.Addr4   @ fiInAddr4 
        Insure.text1   @ fibrand
        insure.Text2   @ fimodel   
        insure.Text3   @ fipack    
        insure.Text4   @ fisumin   
        insure.Text5   @ fibase    
        insure.Deci1   @ fincb     
        insure.Deci2   @ fidspc    
        insure.icno    @ fiengcc 
        insure.ICAddr1 @ fiseat41
        Insure.TelNo   @ fiInTelNo WITH FRAME frinsure.
  DISP  Insure.FDate   @ fiFDate   WITH FRAME fruser.
    END.*/
    GET CURRENT brInsure.
    RUN PdDispIns IN THIS-PROCEDURE. 

    FIND CURRENT Insure NO-LOCK NO-ERROR.
    IF NOT AVAIL Insure THEN RETURN NO-APPLY.
    IF AVAIL Insure AND Insure.CompNo = pComp THEN DO:
       pRowIns = ROWID (Insure).
    END.
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brInsure wgwcamp1
ON VALUE-CHANGED OF brInsure IN FRAME frbrIns
DO:
    FIND CURRENT Insure NO-LOCK NO-ERROR.
    IF AVAIL insure THEN DO:
        /*RUN pdDispIns IN THIS-PROCEDURE. */
        DISPLAY /*insure.compno  @ ficompno*/
            Insure.FName   @ fiInBranch
            Insure.Branch  @ fiFName
            Insure.InsNo   @ fiInComp
            insure.vatcode @ fivatcode
            Insure.LName   @ fiLName           
            Insure.Addr1   @ fiInAddr1         
            Insure.Addr2   @ fiInAddr2
            Insure.Addr3   @ fiInAddr3
            Insure.Addr4   @ fiInAddr4 
            Insure.text1   @ fibrand
            insure.Text2   @ fimodel   
            insure.Text3   @ fipack    
            insure.Text4   @ fisumin   
            insure.Text5   @ fibase    
            insure.Deci1   @ fincb     
            insure.Deci2   @ fidspc    
            insure.icno    @ fiengcc 
            insure.ICAddr1 @ fiseat41
            insure.ICAddr2 @ fiInproducer     /*A57-0125*/
            Insure.TelNo   @ fiInTelNo   WITH FRAME frinsure.
        DISP  Insure.FDate   @ fiFDate   WITH FRAME fruser.
        RUN pdDispIns IN THIS-PROCEDURE. 
    END.
    ELSE DO: 
        ASSIGN 
            fiincomp     = ""               
            fiinbranch   = ""              
            fivatcode    = ""              
            fifname      = ""                  
            filname      = 0              
            fiinAddr1    = 0       
            fiinAddr2    = 0      
            fiinAddr3    = 0       
            fiinAddr4    = 0       
            fiinTelNo    = 0 
            fibrand      = "" 
            fimodel      = "" 
            fipack       = "" 
            fisumin      = ""
            fibase       = ""
            fincb        = 0
            fidspc       = 0
            fiengcc      = "" 
            fiseat41     = ""  
            fiInproducer = "" .   /*A57-0125*/ 
        /*DISPLAY /*insure.compno  @ ficompno*/
            ""  @ fiInBranch
            ""  @ fiFName
            ""  @ fiInComp
            ""  @ fivatcode
            ""  @ fiLName           
            ""  @ fiInAddr1         
            ""  @ fiInAddr2
            ""  @ fiInAddr3
            ""  @ fiInAddr4 
            ""  @ fibrand
            ""  @ fimodel   
            ""  @ fipack    
            ""  @ fisumin   
            ""  @ fibase    
            ""  @ fincb     
            ""  @ fidspc    
            ""  @ fiengcc 
            ""  @ fiseat41
            ""  @ fiInTelNo WITH FRAME frinsure.*/
        DISP      fiincomp  fiinbranch fivatcode  fifname   
        filname   fiinAddr1   fiinAddr2   fiinAddr3          
        fiinAddr4 fiinTelNo  fibrand    fimodel    
        fipack    fisumin    fibase   fincb   fidspc  fiInproducer     /*A57-0125*/    
        fiengcc   fiseat41   WITH FRAME frinsure.
        DISP  ""  @ fiFDate   WITH FRAME fruser.
    END. 
    /*FIND CURRENT Insure NO-LOCK NO-ERROR.
    IF AVAIL insure  THEN RUN pdDispIns IN THIS-PROCEDURE. 
    ELSE 
        DISPLAY /*insure.compno  @ ficompno*/
            ""  @ fiInBranch
            ""  @ fiFName
            ""  @ fiInComp
            ""  @ fivatcode
            ""  @ fiLName           
            ""  @ fiInAddr1         
            ""  @ fiInAddr2
            ""  @ fiInAddr3
            ""  @ fiInAddr4 
            ""  @ fibrand
            ""  @ fimodel   
            ""  @ fipack    
            ""  @ fisumin   
            ""  @ fibase    
            ""  @ fincb     
            ""  @ fidspc    
            ""  @ fiengcc 
            ""  @ fiseat41
            ""  @ fiInTelNo WITH FRAME frinsure.
        
        DISP  ""  @ fiFDate   WITH FRAME fruser.
        RETURN NO-APPLY.*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frComp
&Scoped-define SELF-NAME btncompadd
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btncompadd wgwcamp1
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
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btncompdel wgwcamp1
ON CHOOSE OF btncompdel IN FRAME frComp /* ลบ */
DO:
    DEF VAR logAns    AS LOGI INIT No.  
    DEF BUFFER bComp  FOR brstat.company.
    DEF VAR rComp     AS ROWID.
    ASSIGN
        logAns = No
        rComp  = ROWID (brstat.company)
        btnCompAdd:Sensitive   = Yes
        btnCompUpd:Sensitive   = Yes
        btnCompDel:Sensitive   = Yes.
    MESSAGE "Are you want to delete " + STRING (brstat.company.CompNo) + "-" + brstat.company.Name + " ?" 
        UPDATE logAns 
        VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO
        TITLE " Confirm Deletion ".   
    IF logAns THEN DO:  
        FIND bComp WHERE ROWID (bComp) = rComp EXCLUSIVE-LOCK.
        FOR EACH CompDet WHERE CompDet.CompNo = bComp.CompNo EXCLUSIVE-LOCK:
            DELETE CompDet.
        END.
        DELETE brstat.company.
        MESSAGE "Deleted Comple ..." 
            VIEW-AS ALERT-BOX INFORMATION.  
        FIND NEXT brstat.company NO-LOCK NO-ERROR.
        IF NOT AVAIL brstat.company THEN FIND LAST brstat.company NO-LOCK.
        RUN PDDispComp IN THIS-PROCEDURE.
    END. 
    RUN PDDisableComp IN THIS-PROCEDURE.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btncompfirst
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btncompfirst wgwcamp1
ON CHOOSE OF btncompfirst IN FRAME frComp /* << */
DO:
    FIND FIRST Company WHERE Company.NAME  = "campaign"  NO-LOCK NO-ERROR.   
    IF NOT AVAIL Company THEN RETURN NO-APPLY.
    ASSIGN gComp = company.compno.
    RUN PDDispLogin IN THIS-PROCEDURE.
    /*RUN PdDispIns IN THIS-PROCEDURE. 
    RUN pdUpdateQ.*/
    IF CAN-FIND (FIRST Insure WHERE Insure.compno = gComp )  THEN DO:
        RUN PdDispIns IN THIS-PROCEDURE. 
        RUN PdUpdateQ IN THIS-PROCEDURE.
    END.
    ELSE DO:
        DISPLAY  /*insure.compno  @ ficompno*/
        ""  @ fiInBranch
        ""  @ fiFName
        ""  @ fiInComp
        ""  @ fivatcode
        ""  @ fiLName           
        ""  @ fiInAddr1         
        ""  @ fiInAddr2
        ""  @ fiInAddr3
        ""  @ fiInAddr4 
        ""  @ fibrand
        ""  @ fimodel   
        ""  @ fipack    
        ""  @ fisumin   
        ""  @ fibase    
        ""  @ fincb     
        ""  @ fidspc    
        ""  @ fiengcc 
        ""  @ fiseat41
        ""  @ fiInTelNo WITH FRAME frinsure. 
        RUN PdUpdateQ IN THIS-PROCEDURE.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btncomplast
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btncomplast wgwcamp1
ON CHOOSE OF btncomplast IN FRAME frComp /* >> */
DO:
    FIND LAST Company WHERE Company.NAME  = "campaign" NO-LOCK NO-ERROR.   
    IF NOT AVAIL Company THEN RETURN NO-APPLY.
    ASSIGN gComp = company.compno.
    RUN PDDispLogin IN THIS-PROCEDURE.
    
    /*RUN PdDispIns IN THIS-PROCEDURE. 
    RUN pdUpdateQ.*/
    IF CAN-FIND (FIRST Insure WHERE Insure.compno = gComp )  THEN DO:
        RUN PdDispIns IN THIS-PROCEDURE. 
        RUN PdUpdateQ IN THIS-PROCEDURE.
    END.
    ELSE DO:
        DISPLAY  /*insure.compno  @ ficompno*/
        ""  @ fiInBranch
        ""  @ fiFName
        ""  @ fiInComp
        ""  @ fivatcode
        ""  @ fiLName           
        ""  @ fiInAddr1         
        ""  @ fiInAddr2
        ""  @ fiInAddr3
        ""  @ fiInAddr4 
        ""  @ fibrand
        ""  @ fimodel   
        ""  @ fipack    
        ""  @ fisumin   
        ""  @ fibase    
        ""  @ fincb     
        ""  @ fidspc    
        ""  @ fiengcc 
        ""  @ fiseat41
        ""  @ fiInTelNo WITH FRAME frinsure. 
        RUN PdUpdateQ IN THIS-PROCEDURE.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btncompnext
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btncompnext wgwcamp1
ON CHOOSE OF btncompnext IN FRAME frComp /* > */
DO:
    FIND bComp WHERE ROWID (bComp) = ROWID (Company) NO-LOCK NO-ERROR.
    FIND NEXT bComp WHERE bComp.NAME  = "campaign" NO-LOCK NO-ERROR.      
    IF NOT AVAIL bComp THEN RETURN NO-APPLY.
    FIND NEXT Company WHERE Company.NAME  = "campaign" NO-LOCK NO-ERROR.    
    /*/* RUN PDDispLogin IN THIS-PROCEDURE.*/
    gComp = company.compno.
    RUN PdDispIns IN THIS-PROCEDURE. 
    RUN pdUpdateQ.*/
    ASSIGN gComp = company.compno. 
    RUN PDDispLogin IN THIS-PROCEDURE.
    
    IF CAN-FIND (FIRST Insure WHERE Insure.compno = gComp )  THEN DO:
        RUN PdDispIns IN THIS-PROCEDURE. 
        RUN PdUpdateQ IN THIS-PROCEDURE.
    END.
    ELSE DO:
        DISPLAY  /*insure.compno  @ ficompno*/
        ""  @ fiInBranch
        ""  @ fiFName
        ""  @ fiInComp
        ""  @ fivatcode
        ""  @ fiLName           
        ""  @ fiInAddr1         
        ""  @ fiInAddr2
        ""  @ fiInAddr3
        ""  @ fiInAddr4 
        ""  @ fibrand
        ""  @ fimodel   
        ""  @ fipack    
        ""  @ fisumin   
        ""  @ fibase    
        ""  @ fincb     
        ""  @ fidspc    
        ""  @ fiengcc 
        ""  @ fiseat41
        ""  @ fiInTelNo WITH FRAME frinsure. 
        RUN PdUpdateQ IN THIS-PROCEDURE.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btncompok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btncompok wgwcamp1
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
          Company.Name     = "campaign"   
          Company.Name2    = "campaign"   
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
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btncompprev wgwcamp1
ON CHOOSE OF btncompprev IN FRAME frComp /* < */
DO:
    FIND bComp WHERE ROWID (bComp) = ROWID (Company) NO-LOCK NO-ERROR.
    FIND PREV bComp WHERE bComp.NAME  = "campaign"   NO-LOCK NO-ERROR.    
    IF NOT AVAIL bComp THEN RETURN NO-APPLY.
    FIND PREV Company WHERE Company.NAME  = "campaign"  NO-LOCK NO-ERROR. 
    ASSIGN gComp = company.compno.
    RUN PDDispLogin IN THIS-PROCEDURE.
    /*RUN PdDispIns IN THIS-PROCEDURE. 
    RUN pdUpdateQ.*/
    IF CAN-FIND (FIRST Insure WHERE Insure.compno = gComp )  THEN DO:
        RUN PdDispIns IN THIS-PROCEDURE. 
        RUN PdUpdateQ IN THIS-PROCEDURE.
    END.
    ELSE DO:
        DISPLAY  /*insure.compno  @ ficompno*/
        ""  @ fiInBranch
        ""  @ fiFName
        ""  @ fiInComp
        ""  @ fivatcode
        ""  @ fiLName           
        ""  @ fiInAddr1         
        ""  @ fiInAddr2
        ""  @ fiInAddr3
        ""  @ fiInAddr4 
        ""  @ fibrand
        ""  @ fimodel   
        ""  @ fipack    
        ""  @ fisumin   
        ""  @ fibase    
        ""  @ fincb     
        ""  @ fidspc    
        ""  @ fiengcc 
        ""  @ fiseat41
        ""  @ fiInTelNo WITH FRAME frinsure. 
        RUN PdUpdateQ IN THIS-PROCEDURE.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btncompreset
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btncompreset wgwcamp1
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
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btncompupd wgwcamp1
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
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnFirst wgwcamp1
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
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btninadd wgwcamp1
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
        fiIncomp  = fiCompNo   /*nv_InsNo*/
        fiInbranch = ""
        fivatcode = ""
        fiFName   = ""    
        fiLName     = 0
        fiInAddr1   = 0   
        fiInAddr2   = 0    
        fiInAddr3   = 0   
        fiInAddr4   = 0
        fiInTelNo   = 0
        fibrand     = ""
        fimodel     = ""
        fipack      = ""
        fisumin     = ""
        fibase      = ""
        fincb       = 0
        fidspc      = 0
        fiengcc     = ""
        fiseats     = ""
        fiseat41    = ""
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
        fiInComp    fiInbranch  fivatcode
        fifName     fiLName     fiInAddr1  
        fiInAddr2   fiInAddr3   fiseats  
        fiInAddr4   fiInTelNo   fibrand     fimodel
        fipack      fisumin     fibase      fincb
        fidspc      fiengcc    fiseat41  WITH FRAME frInsure.
    DISP fiFDate WITH FRAME fruser.
    APPLY "ENTRY" TO fiInComp IN FRAME frInsure .
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnInCancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnInCancel wgwcamp1
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
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnInDelete wgwcamp1
ON CHOOSE OF btnInDelete IN FRAME frInsure /* ลบ */
DO:
    /*
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
    RUN ProcDisable IN THIS-PROCEDURE.*/
    /*Add A56-00347 */
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
    /*Add A56-00347 */
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnInOK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnInOK wgwcamp1
ON CHOOSE OF btnInOK IN FRAME frInsure /* OK */
DO:
    ASSIGN
        FRAME frInsure fiIncomp
        FRAME frInsure fiInBranch
        FRAM  frinsure fivatcode
        FRAME frInsure fiFName
        FRAME frInsure fiLName 
        FRAME frInsure fiInAddr1
        FRAME frInsure fiInAddr2
        FRAME frInsure fiInAddr3
        FRAME frInsure fiInAddr4
        FRAME frInsure fiInTelNo
        FRAME frInsure fibrand
        FRAME frInsure fimodel 
        FRAME frInsure fipack  
        FRAME frInsure fisumin 
        FRAME frInsure fibase  
        FRAME frInsure fincb   
        FRAME frInsure fidspc  
        FRAME frInsure fiengcc 
        FRAME frInsure fiseats
        FRAME frInsure fiseat41.
    
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
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnInUpdate wgwcamp1
ON CHOOSE OF btnInUpdate IN FRAME frInsure /* แก้ไข */
DO:
  RUN PdEnable IN THIS-PROCEDURE.
  ASSIGN
    fiIncomp    fiInBranch  fivatcode   fiFName     fiLName 
    fiInAddr1   fiInAddr2   fiInAddr3   fiInAddr4   fiseats
    fiInTelNo   fibrand     fimodel     fipack      fisumin     
    fibase      fincb       fidspc      fiengcc     fiseat41

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
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnLast wgwcamp1
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
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnNext wgwcamp1
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
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnPrev wgwcamp1
ON CHOOSE OF btnPrev IN FRAME frInsure /* < */
DO:
  GET PREV brInsure.
  IF NOT AVAIL Insure THEN RETURN NO-APPLY.
  REPOSITION brInsure TO ROWID ROWID (Insure).
  APPLY "VALUE-CHANGED" TO brInsure IN FRAME frbrins.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frmain
&Scoped-define SELF-NAME btnReturn
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnReturn wgwcamp1
ON CHOOSE OF btnReturn IN FRAME frmain /* EXIT */
DO:
   APPLY "CLOSE" TO THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frUser
&Scoped-define SELF-NAME bu_exp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_exp wgwcamp1
ON CHOOSE OF bu_exp IN FRAME frUser /* EXP */
DO:
    FOR EACH wdetail2.
        DELETE wdetail2.
    END.
    FOR EACH   brstat.insure USE-INDEX Insure03  WHERE 
        brstat.insure.compno  = gComp    NO-LOCK .
        FIND LAST wdetail2 WHERE wdetail2.id = brstat.insure.lname NO-ERROR NO-WAIT.
        IF NOT AVAIL wdetail2 THEN DO:
            CREATE wdetail2.
            ASSIGN
                wdetail2.id         =    brstat.Insure.FName                                                     
                wdetail2.tarif      =    brstat.Insure.Branch             
                wdetail2.covcod     =    brstat.insure.vatcode            
                wdetail2.tp_per     =    brstat.Insure.LName                           
                wdetail2.tp_acc     =    brstat.Insure.Addr1                               
                wdetail2.tp_acc2    =    brstat.Insure.Addr2                               
                wdetail2.tp_41      =    brstat.Insure.Addr3                               
                wdetail2.tp_42      =    brstat.Insure.Addr4                               
                wdetail2.tp_43      =    brstat.Insure.TelNo                               
                wdetail2.brand      =    brstat.insure.Text1                            
                wdetail2.model      =    brstat.insure.Text2                            
                wdetail2.pack       =    brstat.insure.Text3                            
                wdetail2.sumins     =    brstat.insure.Text4                             
                wdetail2.base       =    brstat.insure.Text5                             
                wdetail2.ncb        =    string(brstat.insure.Deci1)                                 
                wdetail2.dspc       =    string(brstat.insure.Deci2)    
                wdetail2.engcc      =    brstat.insure.icno
                wdetail2.seats      =    brstat.insure.ICAddr3
                wdetail2.seat41     =    brstat.insure.ICAddr1  
                wdetail2.producer   =    brstat.insure.ICAddr2.
                
        END.
    END.
    If  substr(fi_fileout,length(fi_fileout) - 3,4) <>  ".csv"  Then
        fi_fileout  =  Trim(fi_fileout) + ".csv"  .
    OUTPUT  TO VALUE(fi_fileout).
     
    EXPORT DELIMITER "|"
        "id"
        "tariff"
        "covcod"
        "per/P"
        "per/a"
        "per/pd"
        "41"
        "42"
        "43"
        "brand"
        "model"
        "pack"
        "insured"  
        "base"
        "ncb"
        "dspc"
        "EngCC"
        "seat"
        "seat41"
        "producer"  SKIP. 
    FOR EACH   wdetail2   NO-LOCK .
        EXPORT DELIMITER "|"
             wdetail2.id           
             wdetail2.tarif       
             wdetail2.covcod      
             wdetail2.tp_per      
             wdetail2.tp_acc      
             wdetail2.tp_acc2     
             wdetail2.tp_41       
             wdetail2.tp_42       
             wdetail2.tp_43       
             wdetail2.brand       
             wdetail2.model       
             wdetail2.pack        
             wdetail2.sumins      
             wdetail2.base        
             wdetail2.ncb         
             wdetail2.dspc        
             wdetail2.engcc       
             wdetail2.seats       
             wdetail2.seat41      
             wdetail2.producer  .

    END.
    OUTPUT  CLOSE.
    message "Export File  Complete"  view-as alert-box.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_im
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_im wgwcamp1
ON CHOOSE OF bu_im IN FRAME frUser /* ..... */
DO:
    DEFINE VARIABLE cvData        AS CHARACTER NO-UNDO.
    DEFINE VARIABLE OKpressed AS LOGICAL INITIAL TRUE.
    
    SYSTEM-DIALOG GET-FILE cvData
        TITLE      "Choose Data File to Import ..."
        FILTERS    "Text Documents" "*.csv"
        
        MUST-EXIST
        USE-FILENAME
        UPDATE OKpressed.
    IF OKpressed = TRUE THEN DO:
        fi_filename  = cvData.
        DISP fi_filename WITH FRAME fruser.     
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_imp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_imp wgwcamp1
ON CHOOSE OF bu_imp IN FRAME frUser /* IMP */
DO:
    IF fi_filename = ""  THEN DO:
        MESSAGE "กรุณาระบุไฟล์ที่ต้องการนำเข้าระบบ !!!"  VIEW-AS ALERT-BOX ERROR.      
        APPLY "ENTRY" TO fi_filename IN FRAME fruser.
    END.
    For each  wdetail2 :
        DELETE  wdetail2.
    END.
    INPUT FROM VALUE(fi_FileName).
    REPEAT:
        CREATE wdetail2.
        IMPORT DELIMITER "|" 
            wdetail2.id 
            wdetail2.tarif
            wdetail2.covcod
            wdetail2.tp_per  
            wdetail2.tp_acc     
            wdetail2.tp_acc2 
            wdetail2.tp_41   
            wdetail2.tp_42   
            wdetail2.tp_43
            wdetail2.brand
            wdetail2.model              
            wdetail2.pack
            wdetail2.sumins
            wdetail2.base
            wdetail2.ncb
            wdetail2.dspc
            wdetail2.engcc
            wdetail2.seats
            wdetail2.seat41
            wdetail2.producer   .  /*A57-0125*/
END.  /* repeat  */
RUN  proc_assign1.
RUN  PDUpdateQ.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frComp
&Scoped-define SELF-NAME fiabname
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiabname wgwcamp1
ON LEAVE OF fiabname IN FRAME frComp
DO:
  /*  fiabname = INPUT fiabname.
    DISP  CAPS(fiabname) @ fiabname WITH FRAME frComp.*/
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frInsure
&Scoped-define SELF-NAME fibase
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fibase wgwcamp1
ON LEAVE OF fibase IN FRAME frInsure
DO:
  fibase  = INPUT fibase.
    DISP fibase WITH FRAM frinsure.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frComp
&Scoped-define SELF-NAME fibranch
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fibranch wgwcamp1
ON LEAVE OF fibranch IN FRAME frComp
DO:
  /*  fiabname = INPUT fiabname.
    DISP  CAPS(fiabname) @ fiabname WITH FRAME frComp.*/
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frInsure
&Scoped-define SELF-NAME fibrand
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fibrand wgwcamp1
ON LEAVE OF fibrand IN FRAME frInsure
DO:
    fibrand  = INPUT fibrand.
    DISP fibrand WITH FRAM frinsure.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frComp
&Scoped-define SELF-NAME fiCompNo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiCompNo wgwcamp1
ON LEAVE OF fiCompNo IN FRAME frComp
DO:
      fiCompNo = caps(INPUT fiCompNo).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frInsure
&Scoped-define SELF-NAME fidspc
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fidspc wgwcamp1
ON LEAVE OF fidspc IN FRAME frInsure
DO:
    fidspc  = INPUT fidspc.
    DISP fidspc WITH FRAM frinsure.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiengcc
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiengcc wgwcamp1
ON LEAVE OF fiengcc IN FRAME frInsure
DO:
    fiengcc  = INPUT fiengcc.
    DISP fiengcc WITH FRAM frinsure.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiFName
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiFName wgwcamp1
ON LEAVE OF fiFName IN FRAME frInsure
DO:
  fifname  = INPUT fifname.
   DISP fifname WITH FRAM frinsure.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiInAddr1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiInAddr1 wgwcamp1
ON LEAVE OF fiInAddr1 IN FRAME frInsure
DO:
    fiinaddr1  = INPUT fiinaddr1.
    DISP fiinaddr1 WITH FRAM frinsure.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiInAddr2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiInAddr2 wgwcamp1
ON LEAVE OF fiInAddr2 IN FRAME frInsure
DO:
    fiinaddr2  = INPUT fiinaddr2.
    DISP fiinaddr2 WITH FRAM frinsure.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiInAddr3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiInAddr3 wgwcamp1
ON LEAVE OF fiInAddr3 IN FRAME frInsure
DO:
    fiinaddr3  = INPUT fiinaddr3.
    DISP fiinaddr3 WITH FRAM frinsure.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiInAddr4
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiInAddr4 wgwcamp1
ON LEAVE OF fiInAddr4 IN FRAME frInsure
DO:
  fiinaddr4  = INPUT fiinaddr4.
    DISP fiinaddr4 WITH FRAM frinsure.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiInBranch
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiInBranch wgwcamp1
ON LEAVE OF fiInBranch IN FRAME frInsure
DO:
   fiInbranch  = INPUT fiInbranch.
   DISP fiInbranch WITH FRAM frinsure.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiInComp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiInComp wgwcamp1
ON LEAVE OF fiInComp IN FRAME frInsure
DO:
    fiInComp  = INPUT fiInComp.
    DISP fiincomp WITH FRAM frinsure.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiInproducer
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiInproducer wgwcamp1
ON LEAVE OF fiInproducer IN FRAME frInsure
DO:
    fiInproducer  = INPUT fiInproducer.
    DISP fiInproducer WITH FRAM frinsure.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiInTelNo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiInTelNo wgwcamp1
ON LEAVE OF fiInTelNo IN FRAME frInsure
DO:
    fiInTelNo  = INPUT fiInTelNo.
    DISP fiInTelNo WITH FRAM frinsure.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiLName
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiLName wgwcamp1
ON LEAVE OF fiLName IN FRAME frInsure
DO:
   filname  = INPUT filname.
   DISP filname WITH FRAM frinsure.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fimodel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fimodel wgwcamp1
ON LEAVE OF fimodel IN FRAME frInsure
DO:
    fimodel  = INPUT fimodel.
    DISP fimodel WITH FRAM frinsure. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frComp
&Scoped-define SELF-NAME fiName
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiName wgwcamp1
ON LEAVE OF fiName IN FRAME frComp
DO:
  ASSIGN   fiName = "campaign".
    
/*      fiName = INPUT fiCompNo.*/
    DISP finame WITH FRAM fr_main.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiName2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiName2 wgwcamp1
ON LEAVE OF fiName2 IN FRAME frComp
DO:
  ASSIGN fiName2 = "campaign".
    
/*      fiName2 = INPUT fiCompNo.*/
    DISP finame2 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frInsure
&Scoped-define SELF-NAME fincb
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fincb wgwcamp1
ON LEAVE OF fincb IN FRAME frInsure
DO:
  fincb  = INPUT fincb.
    DISP fincb WITH FRAM frinsure.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fipack
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fipack wgwcamp1
ON LEAVE OF fipack IN FRAME frInsure
DO:
    fipack = INPUT fipack.
    DISP fipack WITH FRAM frinsure.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiseat41
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiseat41 wgwcamp1
ON LEAVE OF fiseat41 IN FRAME frInsure
DO:
    fiseat41  = INPUT fiseat41.
    DISP fiseat41 WITH FRAM frinsure.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiseats
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiseats wgwcamp1
ON LEAVE OF fiseats IN FRAME frInsure
DO:
    fiseats = INPUT fiseats.
    DISP fiseats WITH FRAM frinsure.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fisumin
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fisumin wgwcamp1
ON LEAVE OF fisumin IN FRAME frInsure
DO:
    fisumin  = INPUT fisumin.
    DISP fisumin WITH FRAM frinsure.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fivatcode
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fivatcode wgwcamp1
ON LEAVE OF fivatcode IN FRAME frInsure
DO:
   fivatcode  = INPUT fivatcode.
   DISP fivatcode WITH FRAM frinsure.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frUser
&Scoped-define SELF-NAME fi_filename
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_filename wgwcamp1
ON LEAVE OF fi_filename IN FRAME frUser
DO:
    fi_filename = INPUT fi_filename.
    DISP fi_filename WITH FRAM fruser.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_fileout
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_fileout wgwcamp1
ON LEAVE OF fi_fileout IN FRAME frUser
DO:
    fi_fileout = INPUT fi_fileout.
    DISP fi_fileout WITH FRAM fruser.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frbrIns
&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK wgwcamp1 


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
    RUN WUT\WUTDICEN (wgwcamp1:HANDLE).
    SESSION:DATA-ENTRY-RETURN = Yes.
    ASSIGN 
    fiUser  = ""
    fiUser  = n_user
    fiFdate = ?
    fiName   = "campaign"     
    fiName2  = "campaign"     
    fiFdate = TODAY.
    DISP fiuser fiFdate  WITH FRAME fruser.
    FIND FIRST Company WHERE  Company.NAME  = "campaign" NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL company THEN DO:
        RUN pdDispComp.
        gComp = Company.Compno.
    END.
    ELSE DO:
        DISP 
            "" @ fiCompNo
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI wgwcamp1  _DEFAULT-DISABLE
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
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(wgwcamp1)
  THEN DELETE WIDGET wgwcamp1.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI wgwcamp1  _DEFAULT-ENABLE
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
      WITH FRAME frComp IN WINDOW wgwcamp1.
  ENABLE RECT-17 RECT-82 RECT-18 RECT-455 btncompfirst btncompprev btncompnext 
         btncomplast fiName btncompadd btncompupd btncompdel btncompok 
         btncompreset 
      WITH FRAME frComp IN WINDOW wgwcamp1.
  {&OPEN-BROWSERS-IN-QUERY-frComp}
  ENABLE btnReturn RECT-84 
      WITH FRAME frmain IN WINDOW wgwcamp1.
  {&OPEN-BROWSERS-IN-QUERY-frmain}
  DISPLAY fiInComp fiInproducer fiInBranch fivatcode fiFName fiLName fiInAddr1 
          fiInAddr2 fiInAddr3 fiInAddr4 fiInTelNo fibrand fimodel fipack fisumin 
          fibase fincb fidspc fiengcc fiseats fiseat41 
      WITH FRAME frInsure IN WINDOW wgwcamp1.
  ENABLE btnFirst btnPrev btnNext btnLast fiInproducer fiInBranch btninadd 
         btnInUpdate btnInDelete btnInOK btnInCancel RECT-20 RECT-83 RECT-454 
         RECT-21 
      WITH FRAME frInsure IN WINDOW wgwcamp1.
  {&OPEN-BROWSERS-IN-QUERY-frInsure}
  ENABLE brInsure 
      WITH FRAME frbrIns IN WINDOW wgwcamp1.
  {&OPEN-BROWSERS-IN-QUERY-frbrIns}
  DISPLAY fi_filename fi_fileout fiUser fiFdate 
      WITH FRAME frUser IN WINDOW wgwcamp1.
  ENABLE RECT-456 fi_filename bu_im bu_imp fi_fileout bu_exp fiUser fiFdate 
      WITH FRAME frUser IN WINDOW wgwcamp1.
  {&OPEN-BROWSERS-IN-QUERY-frUser}
  VIEW wgwcamp1.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdAddCom wgwcamp1 
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDDisableComp wgwcamp1 
PROCEDURE PDDisableComp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
  DISABLE 
      fiCompNo 
      fibranch 
      fiAbName  
      fiName 
      fiName2 
      fiAddr1 
      fiAddr2 
      fiAddr3 
      fiAddr4 
      fiTelNo 
      WITH FRAME frComp.
  DISABLE    btnCompOK   btnCompReset   WITH FRAME frcomp.
  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDDispComp wgwcamp1 
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
    fiTelno  = Company.Telno.
DISP fiCompNo
     fiBranch
     fiABNAme
     fiName  
     finame2 
     fiAddr1 
     fiAddr2 
     fiAddr3 
     fiAddr4 
     fiTelno
     WITH FRAME frComp.
 DISP fiuser fiFdate WITH FRAME fruser.
 FIND FIRST insure USE-INDEX insure01 WHERE insure.compno = ficompno NO-WAIT NO-ERROR.
 IF AVAIL insure  THEN DO:
     ASSIGN
         fiincomp   = insure.insno
         fiInBranch = insure.FName
         fifNAme    = insure.Branch
         fiLName    = deci(insure.LNAME)
         fiInAddr1  = deci(insure.Addr1)
         fiInAddr2  = deci(insure.Addr2)
         fiInAddr3  = deci(insure.Addr3)
         fiInAddr4  = deci(insure.Addr4)
         fiInTelno  = deci(insure.Telno) 
         fibrand    = insure.Text1
         fimodel    = insure.Text2
         fipack     = insure.Text3
         fisumin    = insure.Text4
         fibase     = insure.Text5
         fincb      = insure.Deci1
         fidspc     = insure.Deci2 
         fiengcc    = insure.icno
         fiInproducer  = insure.ICAddr2
         fiseats    = insure.ICAddr3
         fiseat41   = insure.ICAddr1.
     DISP 
         fiincomp  
         fiInBranch
         fifNAme   
         fiLName   
         fiInAddr1 
         fiInAddr2 
         fiInAddr3 
         fiInAddr4 
         fiInTelno  
         fibrand 
         fimodel
         fipack
         fisumin
         fibase
         fincb
         fidspc   fiInproducer
         fiengcc  fiseat41  fiseats
         WITH FRAME frinsure.
     gComp = company.compno.
  RUN pdUpdateQ.
 
 DISP brinsure  WITH FRAME frbrins.

 END.
 ELSE DO:
        DISPLAY /*insure.compno  @ ficompno*/
        ""  @ fiInBranch
        ""  @ fiFName
        ""  @ fiInComp
        ""  @ fivatcode
        ""  @ fiLName           
        ""  @ fiInAddr1         
        ""  @ fiInAddr2
        ""  @ fiInAddr3
        ""  @ fiInAddr4 
        ""  @ fibrand
        ""  @ fimodel   
        ""  @ fipack    
        ""  @ fisumin   
        ""  @ fibase    
        ""  @ fincb     
        ""  @ fidspc    
        ""  @ fiengcc
        ""  @ fiInproducer
        ""  @ fiseats
        ""  @ fiseat41
        ""  @ fiInTelNo WITH FRAME frinsure.
  DISP  ""  @ fiFDate   WITH FRAME fruser.
 END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdDispIns wgwcamp1 
PROCEDURE pdDispIns :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*comment by Kridtiya i. A56-0118
FIND FIRST insure USE-INDEX insure01 WHERE
    insure.compno = gComp NO-WAIT NO-ERROR.
IF AVAIL insure THEN DO:
    ASSIGN                                                  
        fiincomp     = insure.insNo                             
        fiinbranch   = insure.fname                            
        fivatcode    = insure.vatcode                          
        fifname      = insure.Branch                               
        filname      = DECI(insure.lName)                       
        fiinAddr1    = DECI(insure.Addr1)                
        fiinAddr2    = DECI(insure.Addr2)                
        fiinAddr3    = DECI(insure.Addr3)                
        fiinAddr4    = DECI(insure.Addr4)                
        fiinTelNo    = DECI(insure.telno)
        fibrand      = insure.Text1
        fimodel      = insure.Text2
        fipack       = insure.Text3
        fisumin      = insure.Text4
        fibase       = insure.Text5
        fincb        = insure.Deci1
        fidspc       = insure.Deci2 
        fiengcc      = insure.icno
        fiseat41     = insure.ICAddr1
        brInsure:Sensitive  IN FRAM frbrins = Yes.      */      
/*END.                                                       
DISP   fiincomp                                            
       fiinbranch 
       fivatcode  
       fifname       
       filname        
       fiinAddr1   
       fiinAddr2  
       fiinAddr3  
       fiinAddr4  
       fiinTelNo 
       fibrand 
       fimodel    
       fipack    
       fisumin   
       fibase    
       fincb     
       fidspc    
       fiengcc 
       fiseat41      WITH FRAME frinsure.
DISP brInsure WITH FRAME frbrins.
comment by Kridtiya i. A56-0118*/
ASSIGN                                                  
    fiincomp     =  ""               
    fiinbranch   =  ""              
    fivatcode    =  ""              
    fifname      =  ""                  
    filname      =  0              
    fiinAddr1    =  0       
    fiinAddr2    =  0      
    fiinAddr3    =  0       
    fiinAddr4    =  0       
    fiinTelNo    =  0 
    fibrand      =  "" 
    fimodel      =  "" 
    fipack       =  "" 
    fisumin      =  ""
    fibase       =  ""
    fincb        =  0
    fidspc       =  0
    fiengcc      =  "" 
    fiseats      =  ""
    fiseat41     =  ""  
    fiInproducer =  "" .   /*A57-0125*/ 
    brInsure:Sensitive  IN FRAM frbrins = Yes.  
DISPLAY /*insure.compno  @ ficompno*/
        Insure.FName   @ fiInBranch
        Insure.Branch  @ fiFName
        Insure.InsNo   @ fiInComp
        insure.vatcode @ fivatcode
        Insure.LName   @ fiLName           
        Insure.Addr1   @ fiInAddr1         
        Insure.Addr2   @ fiInAddr2
        Insure.Addr3   @ fiInAddr3
        Insure.Addr4   @ fiInAddr4 
        Insure.text1   @ fibrand
        insure.Text2   @ fimodel   
        insure.Text3   @ fipack    
        insure.Text4   @ fisumin   
        insure.Text5   @ fibase    
        insure.Deci1   @ fincb     
        insure.Deci2   @ fidspc    
        insure.icno    @ fiengcc 
        insure.ICAddr1 @ fiseat41
        insure.ICAddr2 @ fiInproducer     /*A57-0125*/
        insure.ICaddr3 @ fiseats
        Insure.TelNo   @ fiInTelNo WITH FRAME frinsure.
  DISP  Insure.FDate   @ fiFDate   WITH FRAME fruser.
   /*raSex = IF Insure.Sex = "M" THEN 1 ELSE IF Insure.Sex = "F" THEN 2 ELSE 3 .     
   DISP raSex  WITH FRAME {&FRAME-NAME}.*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pddisplogin wgwcamp1 
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
FIND FIRST insure USE-INDEX insure01  WHERE Insure.compno = gComp NO-LOCK  NO-ERROR.
IF AVAIL insure THEN DO:
    ASSIGN                                                  
        fiincomp     = insure.insNo                             
        fiinbranch   = insure.fname                            
        fivatcode    = insure.vatcode                          
        fifname      = insure.Branch                               
        filname      = DECI(insure.lName)                       
        fiinAddr1    = DECI(insure.Addr1)                
        fiinAddr2    = DECI(insure.Addr2)                
        fiinAddr3    = DECI(insure.Addr3)                
        fiinAddr4    = DECI(insure.Addr4)                
        fiinTelNo    = DECI(insure.telno)
        fibrand      = insure.Text1
        fimodel      = insure.Text2
        fipack       = insure.Text3
        fisumin      = insure.Text4
        fibase       = insure.Text5
        fincb        = insure.Deci1
        fidspc       = insure.Deci2 
        fiengcc      = insure.icno
        fiseat41     = insure.ICAddr1
        fiseats      = insure.ICAddr2
        fiInproducer = insure.ICAddr3
        brInsure:Sensitive  IN FRAM frbrins = Yes.  
END.
ELSE DO:
    ASSIGN                                                  
        fiincomp     =  ""               
        fiinbranch   =  ""              
        fivatcode    =  ""              
        fifname      =  ""                  
        filname      =  0              
        fiinAddr1    =  0       
        fiinAddr2    =  0      
        fiinAddr3    =  0       
        fiinAddr4    =  0       
        fiinTelNo    =  0 
        fibrand      =  "" 
        fimodel      =  "" 
        fipack       =  "" 
        fisumin      =  ""
        fibase       =  ""
        fincb        = 0
        fidspc       =  0
        fiengcc      =  "" 
        fiInproducer = ""
        fiseats      = ""
        fiseat41     =  ""  .
        brInsure:Sensitive  IN FRAM frbrins = Yes.  
END.
DISP    fiincomp  fiinbranch fivatcode  fifname   
        filname   fiinAddr1   fiinAddr2   fiinAddr3          
        fiinAddr4 fiinTelNo  fibrand    fimodel    
        fipack    fisumin   fibase   fincb   fidspc     
        fiengcc   fiseat41  fiseats    WITH FRAME frinsure.
DISP brInsure WITH FRAME frbrins.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdEnable wgwcamp1 
PROCEDURE pdEnable :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ENABLE 
    fiInComp    fiInBranch  fivatcode   fiFName 
    fiLName     fiInAddr1   fiInAddr2   fiInAddr3   fiInAddr4  
    fiInTelNo   btnInOK     btnInCancel fibrand     fimodel
    fipack      fisumin     fibase      fincb       fidspc
    fiengcc     fiseat41    fiseats     fiInproducer    WITH FRAME frinsure.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdenablecomp wgwcamp1 
PROCEDURE pdenablecomp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ENABLE 
    fiCompNo 
    fibranch 
    fiAbName 
    fiName 
    fiName2 
    fiAddr1 
    fiAddr2 
    fiAddr3 
    fiAddr4 
    fiTelNo 
    WITH FRAME frComp.
    ENABLE ALL WITH  FRAME fiinsure.
    ENABLE   btnCompOK btnCompReset   WITH FRAME frcomp.
    
    ENABLE   brinsure   WITH FRAME frbrins.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDInitData wgwcamp1 
PROCEDURE PDInitData :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN 
    FRAME frComp fiCompNo fiCompNo = ""
    FRAME frComp fiABName fiAbName = ""
    FRAME frComp fiName   fiName   = "campaign"
    FRAME frComp fiName2  fiName2  = "campaign"
    FRAME frComp fiAddr1  fiAddr1  = ""
    FRAME frComp fiAddr2  fiAddr2  = ""
    FRAME frComp fiAddr3  fiAddr3  = ""
    FRAME frComp fiAddr4  fiAddr4  = ""
    FRAME frComp fiTelNo  fiTelNo  = ""

    
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdUpdateQ wgwcamp1 
PROCEDURE pdUpdateQ :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
OPEN QUERY brInsure  FOR EACH Insure USE-INDEX Insure01 NO-LOCK
            WHERE CompNo = gComp
    BY Insure.InsNo .
    IF CAN-FIND (FIRST Insure WHERE Insure.compno = gComp )  THEN DO:
        RUN PdDispIns IN THIS-PROCEDURE. 
    END.
    ELSE DO:
        DISPLAY  /*insure.compno  @ ficompno*/
        ""  @ fiInBranch
        ""  @ fiFName
        ""  @ fiInComp
        ""  @ fivatcode
        ""  @ fiLName           
        ""  @ fiInAddr1         
        ""  @ fiInAddr2
        ""  @ fiInAddr3
        ""  @ fiInAddr4 
        ""  @ fibrand
        ""  @ fimodel   
        ""  @ fipack    
        ""  @ fisumin   
        ""  @ fibase    
        ""  @ fincb     
        ""  @ fidspc    
        ""  @ fiengcc
        ""  @ fiseats
        ""  @ fiseat41
        ""  @ fiInTelNo WITH FRAME frinsure. 
    END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE ProcDisable wgwcamp1 
PROCEDURE ProcDisable :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DISABLE 
    fiincomp 
    fiinBranch 
    fivatcode 
    fiFName 
    fiLName 
    fiinAddr1  
    fiinAddr2 
    fiinAddr3 
    fiinAddr4  
    fiinTelNo fibrand  
    fimodel
    fipack
    fisumin
    fibase
    fincb
    fidspc
    fiengcc
    fiInproducer
    fiseats
    fiseat41
  /*fiInsNo*/
  WITH FRAME frinsure.  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE ProcUpdateInsure wgwcamp1 
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
DEF VAR vInsFirst AS CHAR.  
  pComp = fiCompno.
  FIND FIRST Company WHERE Company.CompNo =  pComp  .
  DO:  vInsFirst = Company.InsNoPrf. END.          
  ASSIGN
    rIns   = ROWID (Insure)
    logAns = No.
    IF cmode = "ADD" THEN DO:
       MESSAGE "เพิ่มข้อมูลรายการดีเลอร์ " UPDATE logAns 
       VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO
       TITLE "เพิ่มข้อมูลรายการดีเลอร์".

       IF logAns THEN DO:
           FIND LAST bIns   USE-INDEX Insure01 WHERE bIns.CompNo = fiCompNo NO-LOCK NO-ERROR.
           CREATE Insure.
                          
       END.
    END. 
    ELSE IF cmode = "UPDATE" THEN DO WITH FRAME frbrins /*{&FRAME-NAME}*/:
         GET CURRENT brInsure EXCLUSIVE-LOCK.
    END. 
        
    ASSIGN 
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
        FRAME frInsure  fibrand
        FRAME frInsure  fimodel 
        FRAME frInsure  fipack  
        FRAME frInsure  fisumin 
        FRAME frInsure  fibase  
        FRAME frInsure  fincb   
        FRAME frInsure  fidspc  
        FRAME frInsure  fiengcc
        FRAME frInsure  fiinproducer
        FRAME frInsure  fiseats
        FRAME frInsure  fiseat41

        insure.compno  = ficompno
        Insure.FName   = fiInBranch
        Insure.Branch  = fiFName
        Insure.InsNo   = fiInComp
        insure.vatcode = fivatcode
        Insure.LName   = string(fiLName)
        Insure.Addr1   = string(fiInAddr1)
        Insure.Addr2   = string(fiInAddr2)
        Insure.Addr3   = string(fiInAddr3)
        Insure.Addr4   = string(fiInAddr4) 
        Insure.TelNo   = string(fiInTelNo)
        insure.Text1   = fibrand
        insure.Text2   = fimodel
        insure.Text3   = fipack 
        insure.Text4   = fisumin
        insure.Text5   = fibase 
        insure.Deci1   = fincb  
        insure.Deci2   = fidspc 
        insure.icno    = fiengcc
        insure.ICAddr1 = fiseat41
        insure.ICAddr2 = fiinproducer
        insure.ICAddr3 = fiseats

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
    
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assign1 wgwcamp1 
PROCEDURE proc_assign1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH wdetail2 NO-LOCK .
    IF wdetail2.id  = "" THEN NEXT.
    ELSE IF wdetail2.id  = "id" THEN NEXT.
    ELSE DO:
        
    FIND FIRST brstat.company USE-INDEX Company01 WHERE
        brstat.company.compno =  gComp       NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL company THEN DO:
        FIND FIRST brstat.insure USE-INDEX Insure03  WHERE 
            brstat.insure.compno  = company.compno   AND 
            brstat.insure.fname   = wdetail2.id      NO-ERROR NO-WAIT.
        IF NOT AVAIL brstat.insure THEN DO:
            CREATE brstat.insure.
            ASSIGN
                brstat.insure.compno   = caps(ficompno)         
                brstat.insure.compno   = company.compno
                brstat.Insure.InsNo    = brstat.company.compno
                brstat.Insure.FName    = wdetail2.id   
                brstat.Insure.Branch   = wdetail2.tarif
                brstat.insure.vatcode  = wdetail2.covcod 
                brstat.Insure.LName    = wdetail2.tp_per        
                brstat.Insure.Addr1    = wdetail2.tp_acc        
                brstat.Insure.Addr2    = wdetail2.tp_acc2       
                brstat.Insure.Addr3    = wdetail2.tp_41         
                brstat.Insure.Addr4    = wdetail2.tp_42         
                brstat.Insure.TelNo    = wdetail2.tp_43         
                brstat.insure.Text1    = wdetail2.brand                 
                brstat.insure.Text2    = wdetail2.model                 
                brstat.insure.Text3    = wdetail2.pack                  
                brstat.insure.Text4    = wdetail2.sumins          
                brstat.insure.Text5    = wdetail2.base                    
                brstat.insure.Deci1    = deci(wdetail2.ncb)                      
                brstat.insure.Deci2    = deci(wdetail2.dspc)                    
                brstat.insure.icno     = wdetail2.engcc
                brstat.insure.ICAddr1  = wdetail2.seat41  
                brstat.insure.ICAddr3  = wdetail2.seats 
                brstat.insure.ICAddr2  = wdetail2.producer. /*A57-0125*/
        END.
        ELSE 
            ASSIGN
                brstat.insure.compno   = caps(ficompno)         
                brstat.insure.compno   = company.compno
                brstat.Insure.InsNo    = brstat.company.compno
                brstat.Insure.FName    = wdetail2.id   
                brstat.Insure.Branch   = wdetail2.tarif
                brstat.insure.vatcode  = wdetail2.covcod 
                brstat.Insure.LName    = wdetail2.tp_per        
                brstat.Insure.Addr1    = wdetail2.tp_acc        
                brstat.Insure.Addr2    = wdetail2.tp_acc2       
                brstat.Insure.Addr3    = wdetail2.tp_41         
                brstat.Insure.Addr4    = wdetail2.tp_42         
                brstat.Insure.TelNo    = wdetail2.tp_43         
                brstat.insure.Text1    = wdetail2.brand                 
                brstat.insure.Text2    = wdetail2.model                 
                brstat.insure.Text3    = wdetail2.pack                  
                brstat.insure.Text4    = wdetail2.sumins          
                brstat.insure.Text5    = wdetail2.base                    
                brstat.insure.Deci1    = deci(wdetail2.ncb)                      
                brstat.insure.Deci2    = deci(wdetail2.dspc)                    
                brstat.insure.icno     = wdetail2.engcc
                brstat.insure.ICAddr1  = wdetail2.seat41  
                brstat.insure.ICAddr3  = wdetail2.seats 
                brstat.insure.ICAddr2  = wdetail2.producer. /*A57-0125*/
    END.
    END.
END.
MESSAGE "Load Data Deler Compleate "   VIEW-AS ALERT-BOX.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

