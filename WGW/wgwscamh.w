&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          brstat           PROGRESS
*/
&Scoped-define WINDOW-NAME wgwscamh
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS wgwscamh 
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
/*program id   : wgwscamh.w   */
/*program name : Setup campaign code HCT   */
/*create  by   : Kridtiya i.A55-0151 date. 03/05/2012 เพิ่มตัวเก็บ ใบเสนอราคา */
/*create  by   : Kridtiya i.A56-0242 date. 24/07/2013 เพิ่ม export text file excel */
/*modify  by   : Kridtiya i.A57-0126 date. 08/04/2014 เพิ่มการลบข้อมูล ท้งชุด */

CREATE WIDGET-POOL.

/* ***************************  Definitions  ************************** */

/* Parameters Definitions ---                                           */

/* Local Variable Definitions ---                                       */

/*{wuw/wuwm0001.i}*/

DEF SHARED VAR n_User      AS CHAR.
DEF SHARED VAR n_Passwd    AS CHAR.
DEF VAR        cUpdate     AS CHAR.
DEF BUFFER     bComp       FOR brstat.Company.
DEF VAR        nv_progname AS CHAR.
DEF VAR        nv_objname  AS CHAR.
DEF VAR        nv_StrEnd   AS CHAR.
DEF VAR        nv_Str      AS CHAR.
DEF VAR        nv_NextPolflg  AS INT.
DEF VAR        nv_RenewPolflg AS INT.
DEF VAR        nv_PrePol   AS CHAR.
DEF VAR        pComp       AS CHAR.
DEF VAR        pRowIns     AS ROWID.
DEF NEW SHARED VAR gUser   AS CHAR.
DEF NEW SHARED VAR gPasswd AS CHAR.
DEF VAR gComp   AS CHAR.
/* gComp = "5". */
DEF NEW SHARED VAR gRecMod   AS Recid.
DEF NEW SHARED VAR gRecBen   AS Recid.
DEF NEW SHARED VAR gRecIns   AS Recid.
DEF VAR n_InsNo         AS INT.
DEFINE TEMP-TABLE  wdetail2 NO-UNDO
    FIELD model         AS CHAR FORMAT "x(30)" INIT ""   
    FIELD id            AS CHAR FORMAT "x(10)" INIT ""    
    FIELD agef          AS CHAR FORMAT "x(10)" INIT "" 
    FIELD aget          AS CHAR FORMAT "x(10)" INIT "" 
    FIELD premt         AS CHAR FORMAT "x(30)" INIT ""    
    FIELD producer      AS CHAR FORMAT "x(10)" INIT ""
    FIELD sumins        AS CHAR FORMAT "x(20)" INIT ""
    INDEX  wdetail201 id .

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
Insure.LName Insure.VatCode Insure.Text4 Insure.Text1 Insure.Branch ~
Insure.Text2 Insure.Text3 Insure.Addr1 Insure.Addr2 Insure.Addr3 ~
Insure.Addr4 Insure.TelNo 
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
DEFINE VAR wgwscamh AS WIDGET-HANDLE NO-UNDO.

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

DEFINE VARIABLE fibranch AS CHARACTER FORMAT "X(3)":U 
     VIEW-AS FILL-IN 
     SIZE 5 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiCompNo AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 19.5 BY .95
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
     SIZE 25.5 BY 1.95
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-455
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 62.5 BY 8.76.

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
     SIZE 9 BY 1
     FONT 6.

DEFINE BUTTON btnInCancel 
     LABEL "Cancel" 
     SIZE 9 BY 1
     FONT 6.

DEFINE BUTTON btnInDelete 
     LABEL "ลบ" 
     SIZE 9 BY 1
     FONT 6.

DEFINE BUTTON btnInDeleteall 
     LABEL "CLR_ALL" 
     SIZE 10 BY 1
     FONT 6.

DEFINE BUTTON btnInOK 
     LABEL "OK" 
     SIZE 9 BY 1
     FONT 6.

DEFINE BUTTON btnInUpdate 
     LABEL "แก้ไข" 
     SIZE 9 BY 1
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

DEFINE BUTTON btnoksch 
     LABEL "OK" 
     SIZE 5 BY .95
     FONT 6.

DEFINE BUTTON btnPrev 
     IMAGE-UP FILE "adeicon\pvback":U
     IMAGE-DOWN FILE "adeicon\pvbackd":U
     IMAGE-INSENSITIVE FILE "adeicon\pvbackx":U
     LABEL "<" 
     SIZE 5.5 BY 1.

DEFINE VARIABLE fiage_fr AS CHARACTER FORMAT "X(35)":U 
     VIEW-AS FILL-IN 
     SIZE 23.5 BY .95
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fiage_t AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 5 BY .95
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fiInAddr1 AS DECIMAL FORMAT "->>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 17 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiInAddr2 AS DECIMAL FORMAT "->>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 17 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiInAddr3 AS DECIMAL FORMAT "->>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 16 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiInAddr4 AS DECIMAL FORMAT "->>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 16 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiInmodel AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 5 BY .95
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fiInno AS CHARACTER FORMAT "X(5)":U INITIAL "0" 
     VIEW-AS FILL-IN 
     SIZE 17 BY .95
     BGCOLOR 15 FGCOLOR 1 FONT 2 NO-UNDO.

DEFINE VARIABLE fiInTelNo AS DECIMAL FORMAT "->>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 16 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiLName AS DECIMAL FORMAT "->>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 17 BY .95
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fipremt AS CHARACTER FORMAT "X(30)":U INITIAL "0" 
     VIEW-AS FILL-IN 
     SIZE 17 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiproducer AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 23.5 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fisearch AS CHARACTER FORMAT "X(5)":U INITIAL "0" 
     VIEW-AS FILL-IN 
     SIZE 11 BY .95
     BGCOLOR 15 FGCOLOR 1 FONT 2 NO-UNDO.

DEFINE VARIABLE fisumins AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 16.5 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-20
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 30.67 BY 1.52
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-21
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 27.17 BY 1.62
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-454
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 65.33 BY 10.52.

DEFINE RECTANGLE RECT-83
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 21 BY 1.52
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-85
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 11.83 BY 1.52
     BGCOLOR 6 .

DEFINE BUTTON btnReturn 
     LABEL "EXIT" 
     SIZE 9.83 BY 1.52
     FONT 6.

DEFINE RECTANGLE RECT-84
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 13.5 BY 2.52
     BGCOLOR 4 .

DEFINE BUTTON bu_expout 
     LABEL "EXP" 
     SIZE 6.5 BY .95.

DEFINE BUTTON bu_file 
     LABEL "..." 
     SIZE 4.5 BY .95.

DEFINE BUTTON bu_im 
     LABEL "IMP" 
     SIZE 6.5 BY .95.

DEFINE VARIABLE fiFdate AS DATE FORMAT "99/99/9999":U 
      VIEW-AS TEXT 
     SIZE 15.5 BY .62
     BGCOLOR 8 FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE fiUser AS CHARACTER FORMAT "X(10)":U 
      VIEW-AS TEXT 
     SIZE 15.5 BY .62
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_filename AS CHARACTER FORMAT "X(256)":U 
     LABEL "" 
     VIEW-AS FILL-IN 
     SIZE 55 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_output AS CHARACTER FORMAT "X(256)":U 
     LABEL "" 
     VIEW-AS FILL-IN 
     SIZE 55 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-478
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 17.33 BY 2.24
     BGCOLOR 8 .

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY brInsure FOR 
      Insure SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE brInsure
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS brInsure wgwscamh _STRUCTURED
  QUERY brInsure NO-LOCK DISPLAY
      Insure.CompNo COLUMN-LABEL "Campaign" FORMAT "X(20)":U WIDTH 12.5
      Insure.InsNo COLUMN-LABEL "SaleType" FORMAT "X(8)":U WIDTH 8.67
      Insure.LName COLUMN-LABEL "IDNo." FORMAT "X(30)":U WIDTH 6.33
      Insure.VatCode COLUMN-LABEL "CampaignName" FORMAT "X(30)":U
            WIDTH 16.33
      Insure.Text4 COLUMN-LABEL "NotifySend" FORMAT "x(20)":U WIDTH 9.83
      Insure.Text1 COLUMN-LABEL "Producer" FORMAT "X(10)":U WIDTH 11.83
      Insure.Branch COLUMN-LABEL "Premt" FORMAT "X(15)":U WIDTH 9.83
      Insure.Text2 COLUMN-LABEL "Sum Insure:" FORMAT "X(30)":U
            WIDTH 10.83
      Insure.Text3 COLUMN-LABEL "TP BI/Per:" FORMAT "x(20)":U WIDTH 11.5
      Insure.Addr1 COLUMN-LABEL "TP BI/Acc:" FORMAT "X(30)":U WIDTH 8
      Insure.Addr2 COLUMN-LABEL "TP PD/Acc:" FORMAT "X(30)":U WIDTH 8
      Insure.Addr3 COLUMN-LABEL "4.1" FORMAT "X(30)":U WIDTH 6
      Insure.Addr4 COLUMN-LABEL "4.2" FORMAT "X(20)":U WIDTH 6
      Insure.TelNo COLUMN-LABEL "4.3" FORMAT "X(30)":U WIDTH 6
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 130 BY 9.76
         BGCOLOR 15 FGCOLOR 0  ROW-HEIGHT-CHARS .86.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME frmain
     btnReturn AT ROW 22.76 COL 120.83
     RECT-84 AT ROW 22.24 COL 119
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 24
         BGCOLOR 8 .

DEFINE FRAME frUser
     fi_filename AT ROW 1.24 COL 40.5 COLON-ALIGNED
     bu_file AT ROW 1.29 COL 99.17
     bu_im AT ROW 1.29 COL 105
     fi_output AT ROW 2.33 COL 40.5 COLON-ALIGNED
     bu_expout AT ROW 2.33 COL 105
     fiUser AT ROW 1.33 COL 8.67 COLON-ALIGNED NO-LABEL
     fiFdate AT ROW 2.24 COL 8.67 COLON-ALIGNED NO-LABEL
     "IMPORT FILE" VIEW-AS TEXT
          SIZE 14.17 BY .95 AT ROW 1.24 COL 27.5
          BGCOLOR 8 FONT 6
     "User ID" VIEW-AS TEXT
          SIZE 8 BY .62 AT ROW 1.33 COL 2
          BGCOLOR 8 FGCOLOR 2 FONT 6
     "EXPORT FILE" VIEW-AS TEXT
          SIZE 14.17 BY .95 AT ROW 2.33 COL 27.5
          BGCOLOR 2 FGCOLOR 7 FONT 6
     "Date" VIEW-AS TEXT
          SIZE 8 BY .62 AT ROW 2.24 COL 2
          BGCOLOR 8 FGCOLOR 2 FONT 6
     RECT-478 AT ROW 1.14 COL 98.33
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 22.24
         SIZE 117.5 BY 2.5
         BGCOLOR 3 .

DEFINE FRAME frComp
     fiCompNo AT ROW 1.52 COL 10.83 COLON-ALIGNED NO-LABEL
     btncomplast AT ROW 1.86 COL 56.67
     btncompfirst AT ROW 1.91 COL 38.83
     btncompprev AT ROW 1.91 COL 44.5
     btncompnext AT ROW 1.91 COL 50.17
     fiabname AT ROW 2.57 COL 10.83 COLON-ALIGNED NO-LABEL
     fibranch AT ROW 2.57 COL 29.33 COLON-ALIGNED NO-LABEL
     fiName AT ROW 3.62 COL 10.83 COLON-ALIGNED NO-LABEL
     fiName2 AT ROW 4.67 COL 10.83 COLON-ALIGNED NO-LABEL
     fiAddr1 AT ROW 5.67 COL 10.83 COLON-ALIGNED NO-LABEL
     fiAddr2 AT ROW 6.71 COL 10.83 COLON-ALIGNED NO-LABEL
     fiAddr3 AT ROW 7.76 COL 10.83 COLON-ALIGNED NO-LABEL
     fiAddr4 AT ROW 8.81 COL 10.83 COLON-ALIGNED NO-LABEL
     fiTelNo AT ROW 8.81 COL 43 COLON-ALIGNED NO-LABEL
     btncompadd AT ROW 10.48 COL 3.67
     btncompupd AT ROW 10.48 COL 14.83
     btncompdel AT ROW 10.48 COL 26
     btncompok AT ROW 10.48 COL 40.5
     btncompreset AT ROW 10.48 COL 51.83
     "อักษรหลังปี" VIEW-AS TEXT
          SIZE 9.5 BY .95 AT ROW 2.57 COL 3
          BGCOLOR 8 FGCOLOR 1 
     "รหัสบริษัท" VIEW-AS TEXT
          SIZE 9.5 BY .95 AT ROW 1.52 COL 3
          BGCOLOR 8 FGCOLOR 1 
     "Branch" VIEW-AS TEXT
          SIZE 6 BY .95 AT ROW 2.57 COL 24.83
          BGCOLOR 8 FGCOLOR 1 
     "ชื่อ 2" VIEW-AS TEXT
          SIZE 9.5 BY .95 AT ROW 4.67 COL 3
          BGCOLOR 8 FGCOLOR 1 
     "โทรศัพท์" VIEW-AS TEXT
          SIZE 8 BY .95 AT ROW 8.81 COL 36.17
          BGCOLOR 8 FGCOLOR 1 
     "ชื่อบริษัท" VIEW-AS TEXT
          SIZE 9.5 BY .95 AT ROW 3.62 COL 3
          BGCOLOR 8 FGCOLOR 1 
     "ที่อยู่" VIEW-AS TEXT
          SIZE 9.5 BY .95 AT ROW 5.67 COL 3
          BGCOLOR 8 FGCOLOR 1 
     RECT-17 AT ROW 10.19 COL 2
     RECT-82 AT ROW 10.19 COL 39.17
     RECT-18 AT ROW 1.43 COL 37.5
     RECT-455 AT ROW 1.19 COL 1.83
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 65 BY 11
         BGCOLOR 31 .

DEFINE FRAME frbrIns
     brInsure AT ROW 1.24 COL 1.5
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 12.05
         SIZE 131.5 BY 10.15
         BGCOLOR 29 .

DEFINE FRAME frInsure
     fiInno AT ROW 2.67 COL 16 COLON-ALIGNED NO-LABEL
     fiInmodel AT ROW 3.71 COL 20.5 COLON-ALIGNED NO-LABEL
     fiage_fr AT ROW 3.71 COL 37.5 COLON-ALIGNED NO-LABEL
     fiage_t AT ROW 4.76 COL 20.5 COLON-ALIGNED NO-LABEL
     fiproducer AT ROW 4.76 COL 37.5 COLON-ALIGNED NO-LABEL
     fipremt AT ROW 5.81 COL 16 COLON-ALIGNED NO-LABEL
     fisumins AT ROW 5.81 COL 44.5 COLON-ALIGNED NO-LABEL
     fiLName AT ROW 6.86 COL 16 COLON-ALIGNED NO-LABEL
     fiInAddr1 AT ROW 7.86 COL 34 RIGHT-ALIGNED NO-LABEL
     fiInAddr2 AT ROW 8.86 COL 34 RIGHT-ALIGNED NO-LABEL
     fiInAddr3 AT ROW 6.86 COL 62 RIGHT-ALIGNED NO-LABEL
     fiInAddr4 AT ROW 7.86 COL 62 RIGHT-ALIGNED NO-LABEL
     fiInTelNo AT ROW 8.86 COL 45 COLON-ALIGNED NO-LABEL
     btnFirst AT ROW 1.67 COL 39
     btnPrev AT ROW 1.67 COL 44.67
     btnNext AT ROW 1.67 COL 50.33
     btnLast AT ROW 1.67 COL 56.67
     btninadd AT ROW 10.19 COL 3.5
     btnInUpdate AT ROW 10.19 COL 13.17
     btnInDelete AT ROW 10.19 COL 22.67
     btnInOK AT ROW 10.19 COL 34.67
     btnInCancel AT ROW 10.19 COL 44
     fisearch AT ROW 1.57 COL 16 COLON-ALIGNED NO-LABEL
     btnoksch AT ROW 1.57 COL 29.83
     btnInDeleteall AT ROW 10.19 COL 55
     "TP PD/Accident :" VIEW-AS TEXT
          SIZE 14.5 BY .95 AT ROW 8.86 COL 3
          BGCOLOR 20 FGCOLOR 15 
     "TP BI/Person :" VIEW-AS TEXT
          SIZE 14.5 BY .95 AT ROW 6.86 COL 3
          BGCOLOR 20 FGCOLOR 15 
     "ประเภทการขาย N/C/S:" VIEW-AS TEXT
          SIZE 19 BY .95 AT ROW 3.71 COL 3
          BGCOLOR 18 FGCOLOR 2 
     "4.1  :" VIEW-AS TEXT
          SIZE 8 BY .95 AT ROW 6.86 COL 38
          BGCOLOR 20 FGCOLOR 15 
     "             Premt :" VIEW-AS TEXT
          SIZE 14.5 BY .95 AT ROW 5.81 COL 3
          BGCOLOR 20 FGCOLOR 15 
     "  Producer :" VIEW-AS TEXT
          SIZE 11 BY .95 AT ROW 4.76 COL 28
          BGCOLOR 20 FGCOLOR 2 
     "4.3  :" VIEW-AS TEXT
          SIZE 8 BY .95 AT ROW 8.86 COL 38
          BGCOLOR 20 FGCOLOR 15 FONT 1
     "ประเภทแจ้งงาน N/R/S:" VIEW-AS TEXT
          SIZE 19 BY .95 AT ROW 4.76 COL 3
          BGCOLOR 20 FGCOLOR 2 
     "        Search :" VIEW-AS TEXT
          SIZE 14.5 BY .95 AT ROW 1.57 COL 3
          BGCOLOR 2 FGCOLOR 7 FONT 6
     "TP BI/Accident :" VIEW-AS TEXT
          SIZE 14.5 BY .95 AT ROW 7.86 COL 3
          BGCOLOR 20 FGCOLOR 15 
     "                     No :" VIEW-AS TEXT
          SIZE 14.5 BY .95 AT ROW 2.67 COL 3
          BGCOLOR 20 FGCOLOR 2 
     "Sum Insure :" VIEW-AS TEXT
          SIZE 10 BY .95 AT ROW 5.81 COL 36
          BGCOLOR 20 FGCOLOR 15 
     "4.2  :" VIEW-AS TEXT
          SIZE 8 BY .95 AT ROW 7.86 COL 38
          BGCOLOR 20 FGCOLOR 15 
     "ชื่อแคมเปญ :" VIEW-AS TEXT
          SIZE 11 BY .95 AT ROW 3.71 COL 28
          BGCOLOR 20 FGCOLOR 2 
     RECT-20 AT ROW 9.91 COL 2.33
     RECT-83 AT ROW 9.91 COL 33.17
     RECT-454 AT ROW 1.19 COL 1.67
     RECT-21 AT ROW 1.38 COL 37
     RECT-85 AT ROW 9.91 COL 54.33
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 66 ROW 1
         SIZE 66.5 BY 11
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
  CREATE WINDOW wgwscamh ASSIGN
         HIDDEN             = YES
         TITLE              = "Set Campaign Code [HCT]"
         HEIGHT             = 23.91
         WIDTH              = 131.83
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

&IF '{&WINDOW-SYSTEM}' NE 'TTY' &THEN
IF NOT wgwscamh:LOAD-ICON("I:/Safety/WALP10/WIMAGE/safety.ico":U) THEN
    MESSAGE "Unable to load icon: I:/Safety/WALP10/WIMAGE/safety.ico"
            VIEW-AS ALERT-BOX WARNING BUTTONS OK.
&ENDIF
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW wgwscamh
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
/* SETTINGS FOR FILL-IN fiage_fr IN FRAME frInsure
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fiage_t IN FRAME frInsure
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fiInAddr1 IN FRAME frInsure
   NO-ENABLE ALIGN-R                                                    */
/* SETTINGS FOR FILL-IN fiInAddr2 IN FRAME frInsure
   NO-ENABLE ALIGN-R                                                    */
/* SETTINGS FOR FILL-IN fiInAddr3 IN FRAME frInsure
   NO-ENABLE ALIGN-R                                                    */
/* SETTINGS FOR FILL-IN fiInAddr4 IN FRAME frInsure
   NO-ENABLE ALIGN-R                                                    */
/* SETTINGS FOR FILL-IN fiInmodel IN FRAME frInsure
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fiInTelNo IN FRAME frInsure
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fiLName IN FRAME frInsure
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fipremt IN FRAME frInsure
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fiproducer IN FRAME frInsure
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fisumins IN FRAME frInsure
   NO-ENABLE                                                            */
/* SETTINGS FOR FRAME frmain
   Custom                                                               */

DEFINE VARIABLE XXTABVALXX AS LOGICAL NO-UNDO.

ASSIGN XXTABVALXX = FRAME frUser:MOVE-BEFORE-TAB-ITEM (btnReturn:HANDLE IN FRAME frmain)
       XXTABVALXX = FRAME frbrIns:MOVE-AFTER-TAB-ITEM (btnReturn:HANDLE IN FRAME frmain)
/* END-ASSIGN-TABS */.

/* SETTINGS FOR FRAME frUser
                                                                        */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(wgwscamh)
THEN wgwscamh:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE brInsure
/* Query rebuild information for BROWSE brInsure
     _TblList          = "brstat.Insure"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _FldNameList[1]   > brstat.Insure.CompNo
"Insure.CompNo" "Campaign" "X(20)" "character" ? ? ? ? ? ? no ? no no "12.5" yes no no "U" "" ""
     _FldNameList[2]   > brstat.Insure.InsNo
"Insure.InsNo" "SaleType" "X(8)" "character" ? ? ? ? ? ? no ? no no "8.67" yes no no "U" "" ""
     _FldNameList[3]   > brstat.Insure.LName
"Insure.LName" "IDNo." "X(30)" "character" ? ? ? ? ? ? no ? no no "6.33" yes no no "U" "" ""
     _FldNameList[4]   > brstat.Insure.VatCode
"Insure.VatCode" "CampaignName" "X(30)" "character" ? ? ? ? ? ? no ? no no "16.33" yes no no "U" "" ""
     _FldNameList[5]   > brstat.Insure.Text4
"Insure.Text4" "NotifySend" ? "character" ? ? ? ? ? ? no ? no no "9.83" yes no no "U" "" ""
     _FldNameList[6]   > brstat.Insure.Text1
"Insure.Text1" "Producer" "X(10)" "character" ? ? ? ? ? ? no ? no no "11.83" yes no no "U" "" ""
     _FldNameList[7]   > brstat.Insure.Branch
"Insure.Branch" "Premt" "X(15)" "character" ? ? ? ? ? ? no ? no no "9.83" yes no no "U" "" ""
     _FldNameList[8]   > brstat.Insure.Text2
"Insure.Text2" "Sum Insure:" "X(30)" "character" ? ? ? ? ? ? no ? no no "10.83" yes no no "U" "" ""
     _FldNameList[9]   > brstat.Insure.Text3
"Insure.Text3" "TP BI/Per:" ? "character" ? ? ? ? ? ? no ? no no "11.5" yes no no "U" "" ""
     _FldNameList[10]   > brstat.Insure.Addr1
"Insure.Addr1" "TP BI/Acc:" "X(30)" "character" ? ? ? ? ? ? no ? no no "8" yes no no "U" "" ""
     _FldNameList[11]   > brstat.Insure.Addr2
"Insure.Addr2" "TP PD/Acc:" "X(30)" "character" ? ? ? ? ? ? no ? no no "8" yes no no "U" "" ""
     _FldNameList[12]   > brstat.Insure.Addr3
"Insure.Addr3" "4.1" "X(30)" "character" ? ? ? ? ? ? no ? no no "6" yes no no "U" "" ""
     _FldNameList[13]   > brstat.Insure.Addr4
"Insure.Addr4" "4.2" ? "character" ? ? ? ? ? ? no ? no no "6" yes no no "U" "" ""
     _FldNameList[14]   > brstat.Insure.TelNo
"Insure.TelNo" "4.3" ? "character" ? ? ? ? ? ? no ? no no "6" yes no no "U" "" ""
     _Query            is NOT OPENED
*/  /* BROWSE brInsure */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME wgwscamh
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wgwscamh wgwscamh
ON END-ERROR OF wgwscamh /* Set Campaign Code [HCT] */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wgwscamh wgwscamh
ON WINDOW-CLOSE OF wgwscamh /* Set Campaign Code [HCT] */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME brInsure
&Scoped-define SELF-NAME brInsure
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brInsure wgwscamh
ON MOUSE-SELECT-CLICK OF brInsure IN FRAME frbrIns
DO:
    GET CURRENT brInsure.
    RUN PdDispIns IN THIS-PROCEDURE. 
    FIND CURRENT Insure NO-LOCK.
    IF NOT AVAIL Insure THEN RETURN NO-APPLY.
    IF AVAIL Insure AND Insure.CompNo = pComp THEN DO:
       pRowIns = ROWID (Insure).
       RUN PdDispIns IN THIS-PROCEDURE. 
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brInsure wgwscamh
ON MOUSE-SELECT-DBLCLICK OF brInsure IN FRAME frbrIns
DO:
    APPLY "MOUSE-SELECT-CLICK" TO brInsure IN FRAME frbrins.    
    APPLY "CLOSE" TO THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brInsure wgwscamh
ON VALUE-CHANGED OF brInsure IN FRAME frbrIns
DO:
    FIND CURRENT Insure NO-LOCK NO-ERROR.
    IF AVAIL insure THEN RUN pdDispIns IN THIS-PROCEDURE. 
    ELSE DO:
        DISPLAY /*insure.compno  @ ficompno*/
                ""  @ fiInno
                ""  @ fipremt
                ""  @ fisumins
                ""  @ fiinmodel
                ""  @ fiage_fr 
                ""  @ fiage_t 
                ""  @ fiLName         
                ""  @ fiInAddr1         
                ""  @ fiInAddr2
                ""  @ fiInAddr3
                ""  @ fiInAddr4 
                ""  @ fiproducer
                ""  @ fiInTelNo WITH FRAME frinsure .
          /*DISP  Insure.FDate   @ fiFDate   WITH FRAME fruser   .*/
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frComp
&Scoped-define SELF-NAME btncompadd
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btncompadd wgwscamh
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
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btncompdel wgwscamh
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
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btncompfirst wgwscamh
ON CHOOSE OF btncompfirst IN FRAME frComp /* << */
DO:
  FIND FIRST Company WHERE Company.NAME  = "campaign"  NO-LOCK NO-ERROR.   
  IF NOT AVAIL Company THEN RETURN NO-APPLY.
  RUN PDDispLogin IN THIS-PROCEDURE.
  gComp = company.compno.
  RUN PdDispIns IN THIS-PROCEDURE. 
  RUN pdUpdateQ.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btncomplast
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btncomplast wgwscamh
ON CHOOSE OF btncomplast IN FRAME frComp /* >> */
DO:
  FIND LAST Company WHERE Company.NAME  = "campaign" NO-LOCK NO-ERROR.   
  IF NOT AVAIL Company THEN RETURN NO-APPLY.
  RUN PDDispLogin IN THIS-PROCEDURE.
  gComp = company.compno.
  RUN PdDispIns IN THIS-PROCEDURE. 
  RUN pdUpdateQ.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btncompnext
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btncompnext wgwscamh
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
    RUN PDDispLogin IN THIS-PROCEDURE.
    gComp = company.compno.
    RUN PdDispIns IN THIS-PROCEDURE. 
    RUN pdUpdateQ.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btncompok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btncompok wgwscamh
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
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btncompprev wgwscamh
ON CHOOSE OF btncompprev IN FRAME frComp /* < */
DO:
    FIND bComp WHERE ROWID (bComp) = ROWID (Company) NO-LOCK NO-ERROR.
    FIND PREV bComp WHERE bComp.NAME  = "campaign"  NO-LOCK NO-ERROR.    
    IF NOT AVAIL bComp THEN RETURN NO-APPLY.
    FIND PREV Company WHERE Company.NAME  = "campaign"  NO-LOCK NO-ERROR. 
    RUN PDDispLogin IN THIS-PROCEDURE.
    gComp = company.compno.
    RUN PdDispIns IN THIS-PROCEDURE. 
    RUN pdUpdateQ.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btncompreset
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btncompreset wgwscamh
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
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btncompupd wgwscamh
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
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnFirst wgwscamh
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
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btninadd wgwscamh
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
        cUpdate     = "ADD"
        fiinmodel   = nv_InsNo
        fiinno      = ""
        fiage_fr    = ""
        fiage_t     = ""
        fipremt     = ""   
        fisumins    = ""
        fiLName     = 0
        fiInAddr1   = 0   
        fiInAddr2   = 0    
        fiInAddr3   = 0   
        fiInAddr4   = 0
        fiInTelNo   = 0
        fiproducer     = ""
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
        fiinmodel    fiinno fiage_fr  fiage_t 
        fipremt  fisumins   fiLName  fiInAddr1  
        fiInAddr2   fiInAddr3     
        fiInAddr4   fiInTelNo   fiproducer    
        WITH FRAME frInsure.
    DISP fiFDate WITH FRAME fruser.
    APPLY "ENTRY" TO fiInno IN FRAME frInsure .
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnInCancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnInCancel wgwscamh
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
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnInDelete wgwscamh
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


&Scoped-define SELF-NAME btnInDeleteall
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnInDeleteall wgwscamh
ON CHOOSE OF btnInDeleteall IN FRAME frInsure /* CLR_ALL */
DO:
    DEF VAR logAns AS LOGI INIT No.  
    logAns = No.
    MESSAGE "คุณต้องการลบข้อมูลทั้งหมด /ทีละรายการ ??? " + TRIM (insure.compno) + " " UPDATE logAns 
        VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO
        TITLE "ลบข้อมูลทั้งหมดนี้".   
    IF logAns THEN DO:  
        MESSAGE "คุณต้องการลบข้อมูลทั้งหมด   ??? " + TRIM (insure.compno) + " " UPDATE logAns 
            VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO
            TITLE "ลบข้อมูลทั้งหมดนี้".  
        IF logAns THEN DO:
            FOR EACH  brstat.insure USE-INDEX Insure03  WHERE brstat.insure.compno  = gComp   .
                DELETE brstat.insure.
            END.
            MESSAGE "ลบข้อมูลเรียบร้อย ..." VIEW-AS ALERT-BOX INFORMATION.  
        END.
    END.  
    RUN PdUpdateQ.  
    APPLY "VALUE-CHANGED" TO brInsure IN FRAM frbrins.  
    RUN ProcDisable IN THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnInOK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnInOK wgwscamh
ON CHOOSE OF btnInOK IN FRAME frInsure /* OK */
DO:
    ASSIGN
        FRAME frInsure fiinmodel
        FRAME frInsure fiInno
        FRAM  frinsure fiage_fr 
        FRAM  frinsure fiage_t 
        FRAME frInsure fipremt
        FRAME frinsure fisumins
        FRAME frInsure fiLName 
        FRAME frInsure fiInAddr1
        FRAME frInsure fiInAddr2
        FRAME frInsure fiInAddr3
        FRAME frInsure fiInAddr4
        FRAME frInsure fiInTelNo
        FRAME frInsure fiproducer.
    
    IF (fiInno = ""  OR fiinmodel  = "" ) THEN DO:
        MESSAGE "ข้อมูลผิดพลาด  กรุณาตรวจสอบข้อมูลใหม่ "  VIEW-AS ALERT-BOX ERROR.
        APPLY "ENTRY" TO fiinmodel IN FRAME frinsure.
    END.
    ELSE DO:
        RUN ProcUpdateInsure IN THIS-PROCEDURE (INPUT cUpdate).
    END.
   
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnInUpdate
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnInUpdate wgwscamh
ON CHOOSE OF btnInUpdate IN FRAME frInsure /* แก้ไข */
DO:
  RUN PdEnable IN THIS-PROCEDURE.
  ASSIGN
    fiinmodel fiInno fiage_fr  fiage_t 
    fipremt fisumins fiLName 
    fiInAddr1 fiInAddr2 fiInAddr3 fiInAddr4 
    fiInTelNo fiproducer
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
  APPLY "ENTRY" TO fiInno IN FRAM frInsure.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnLast
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnLast wgwscamh
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
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnNext wgwscamh
ON CHOOSE OF btnNext IN FRAME frInsure /* > */
DO:
    GET NEXT brInsure.
    IF NOT AVAIL Insure THEN RETURN NO-APPLY.
    REPOSITION brInsure TO ROWID ROWID (Insure).
    APPLY "VALUE-CHANGED" TO brInsure IN FRAME frbrins.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnoksch
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnoksch wgwscamh
ON CHOOSE OF btnoksch IN FRAME frInsure /* OK */
DO:
    /*ASSIGN
        FRAME frInsure fiinmodel
        FRAME frInsure fiInno
        FRAM  frinsure fiage_fr 
        FRAM  frinsure fiage_t 
        FRAME frInsure fipremt
        FRAME frinsure fisumins
        FRAME frInsure fiLName 
        FRAME frInsure fiInAddr1
        FRAME frInsure fiInAddr2
        FRAME frInsure fiInAddr3
        FRAME frInsure fiInAddr4
        FRAME frInsure fiInTelNo
        FRAME frInsure fiproducer.
    
    IF (fiInno = ""  OR fiinmodel  = "" ) THEN DO:
        MESSAGE "ข้อมูลผิดพลาด  กรุณาตรวจสอบข้อมูลใหม่ "  VIEW-AS ALERT-BOX ERROR.
        APPLY "ENTRY" TO fiinmodel IN FRAME frinsure.
    END.
    ELSE DO:
        RUN ProcUpdateInsure IN THIS-PROCEDURE (INPUT cUpdate).

    END.*/
    FIND LAST  brstat.Insure USE-INDEX Insure06  WHERE
         brstat.insure.lname   = TRIM(fisearch)  AND 
         brstat.insure.compno  = gComp           NO-LOCK NO-ERROR . 
    IF NOT AVAIL Insure THEN RETURN NO-APPLY.
    REPOSITION brInsure TO ROWID ROWID (Insure).
    APPLY "VALUE-CHANGED" TO brInsure IN FRAME frbrins.
    /*RUN pdDispIns IN THIS-PROCEDURE. */
   
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnPrev
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnPrev wgwscamh
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
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnReturn wgwscamh
ON CHOOSE OF btnReturn IN FRAME frmain /* EXIT */
DO:
   APPLY "CLOSE" TO THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frUser
&Scoped-define SELF-NAME bu_expout
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_expout wgwscamh
ON CHOOSE OF bu_expout IN FRAME frUser /* EXP */
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
                wdetail2.id        =    brstat.insure.lname   
                wdetail2.model     =    brstat.Insure.InsNo   
                wdetail2.agef      =    brstat.insure.vatcode 
                wdetail2.aget      =    brstat.insure.text4   
                wdetail2.premt     =    brstat.insure.branch  
                wdetail2.producer  =    brstat.insure.Text1   
                wdetail2.sumins    =    brstat.insure.Text2   .
        END.
    END. 
    If  substr(fi_output,length(fi_output) - 3,4) <>  ".csv"  Then
        fi_output  =  Trim(fi_output) + ".csv"  .
    OUTPUT  TO VALUE(fi_output).
    EXPORT DELIMITER "|"
        "Campaign HCT "    SKIP.
    EXPORT DELIMITER "|"
        "Model"                                                 
        "Id"               
        "Age_From"                                    
        "Age_To"                                                         
        "Premium"                                           
        "Producer"                                        
        "Insur"  SKIP. 
    RUN proc_outputfile.                             
    OUTPUT  CLOSE.
    message "Export File  Complete"  view-as alert-box.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_file
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_file wgwscamh
ON CHOOSE OF bu_file IN FRAME frUser /* ... */
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


&Scoped-define SELF-NAME bu_im
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_im wgwscamh
ON CHOOSE OF bu_im IN FRAME frUser /* IMP */
DO:
    IF fi_filename = ""  THEN DO:
        MESSAGE "กรุณาระบุไฟล์ที่ต้องการนำเข้า"   VIEW-AS ALERT-BOX ERROR.   
        APPLY "entry" TO fi_filename IN FRAM fruser.
    END.

    For each  wdetail2 :
        DELETE  wdetail2.
    END.
    INPUT FROM VALUE(fi_FileName).
    REPEAT:
        CREATE wdetail2.
        IMPORT DELIMITER "|" 
            /*wdetail2.model              
            wdetail2.id                   
            wdetail2.agef
            wdetail2.aget
            wdetail2.premt     
            wdetail2.producer  
            wdetail2.sumins .*/
            wdetail2.id 
            wdetail2.model   
            wdetail2.agef
            wdetail2.aget
            wdetail2.producer.
    END.   /* repeat  */
    RUN  Pro_assign1.
    RUN  PDUpdateQ.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frComp
&Scoped-define SELF-NAME fiabname
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiabname wgwscamh
ON LEAVE OF fiabname IN FRAME frComp
DO:
  /*  fiabname = INPUT fiabname.
    DISP  CAPS(fiabname) @ fiabname WITH FRAME frComp.*/
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frInsure
&Scoped-define SELF-NAME fiage_fr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiage_fr wgwscamh
ON LEAVE OF fiage_fr IN FRAME frInsure
DO:
   fiage_fr  = INPUT fiage_fr.
   DISP fiage_fr WITH FRAM frinsure.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiage_t
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiage_t wgwscamh
ON LEAVE OF fiage_t IN FRAME frInsure
DO:
   fiage_t  = INPUT fiage_t.
   DISP fiage_t WITH FRAM frinsure.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frComp
&Scoped-define SELF-NAME fibranch
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fibranch wgwscamh
ON LEAVE OF fibranch IN FRAME frComp
DO:
  /*  fiabname = INPUT fiabname.
    DISP  CAPS(fiabname) @ fiabname WITH FRAME frComp.*/
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiCompNo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiCompNo wgwscamh
ON LEAVE OF fiCompNo IN FRAME frComp
DO:
      fiCompNo = caps(INPUT fiCompNo).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frInsure
&Scoped-define SELF-NAME fiInmodel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiInmodel wgwscamh
ON LEAVE OF fiInmodel IN FRAME frInsure
DO:
   fiinmodel  = caps(INPUT fiinmodel).
   DISP fiinmodel WITH FRAM frinsure.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frComp
&Scoped-define SELF-NAME fiName
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiName wgwscamh
ON LEAVE OF fiName IN FRAME frComp
DO:
  ASSIGN   fiName = "campaign".
    
/*      fiName = INPUT fiCompNo.*/
    DISP finame WITH FRAM fr_main.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiName2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiName2 wgwscamh
ON LEAVE OF fiName2 IN FRAME frComp
DO:
  ASSIGN fiName2 = "campaign".
    
/*      fiName2 = INPUT fiCompNo.*/
    DISP finame2 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frInsure
&Scoped-define SELF-NAME fiproducer
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiproducer wgwscamh
ON LEAVE OF fiproducer IN FRAME frInsure
DO:
    fiproducer = CAPS( INPUT fiproducer ).
    DISP fiproducer WITH FRAM frinsure.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fisearch
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fisearch wgwscamh
ON LEAVE OF fisearch IN FRAME frInsure
DO:
  fisearch = INPUT fisearch .
  DISP fisearch WITH FRAM frInsure.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fisumins
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fisumins wgwscamh
ON LEAVE OF fisumins IN FRAME frInsure
DO:
    fisumins = CAPS( INPUT fisumins ).
    DISP fisumins WITH FRAM frinsure.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frUser
&Scoped-define SELF-NAME fi_filename
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_filename wgwscamh
ON LEAVE OF fi_filename IN FRAME frUser
DO:
  fi_filename = INPUT fi_filename.
  DISP fi_filename WITH FRAM fruser.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_output
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_output wgwscamh
ON LEAVE OF fi_output IN FRAME frUser
DO:
  fi_output = INPUT fi_output.
  DISP fi_output WITH FRAM fruser.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frbrIns
&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK wgwscamh 


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
    DEF  VAR  gv_prgid   AS   CHAR.
    DEF  VAR  gv_prog    AS   CHAR.
    gv_prgid = "wgwscamh.w".
    gv_prog  = "SetUp  Campaign Code".
    RUN  WUT\WUTHEAD (wgwscamh:handle,gv_prgid,gv_prog).

   /* RUN WUT\WUTDICEN (wgwscamh:HANDLE).*/
    RUN  WUT\WUTWICEN (wgwscamh:handle). 
    SESSION:DATA-ENTRY-RETURN = Yes.
    ASSIGN 
    fiUser   = ""
    fiUser   = n_user
    fiFdate  = ?
    fiName   = "campaign"     
    fiName2  = "campaign"     
    fiFdate  = TODAY
    fisearch = "".
    DISP fiuser fiFdate    WITH FRAME fruser.
    DISP   fisearch  WITH FRAME frInsure.
    FIND FIRST Company WHERE  
        Company.NAME  = "campaign"  AND 
        Company.Compno = "CAM_HCT"  NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL company THEN DO:
        RUN pdDispComp.
        ASSIGN gComp = Company.Compno.
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
        /*RUN PdUpdateQ IN THIS-PROCEDURE.*/
        APPLY "VALUE-CHANGED" TO brInsure.
    END.
    IF NOT THIS-PROCEDURE:PERSISTENT THEN
        WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI wgwscamh  _DEFAULT-DISABLE
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
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(wgwscamh)
  THEN DELETE WIDGET wgwscamh.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI wgwscamh  _DEFAULT-ENABLE
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
      WITH FRAME frComp IN WINDOW wgwscamh.
  ENABLE RECT-17 RECT-82 RECT-18 RECT-455 btncomplast btncompfirst btncompprev 
         btncompnext fiName btncompadd btncompupd btncompdel btncompok 
         btncompreset 
      WITH FRAME frComp IN WINDOW wgwscamh.
  {&OPEN-BROWSERS-IN-QUERY-frComp}
  ENABLE btnReturn RECT-84 
      WITH FRAME frmain IN WINDOW wgwscamh.
  {&OPEN-BROWSERS-IN-QUERY-frmain}
  DISPLAY fiInno fiInmodel fiage_fr fiage_t fiproducer fipremt fisumins fiLName 
          fiInAddr1 fiInAddr2 fiInAddr3 fiInAddr4 fiInTelNo fisearch 
      WITH FRAME frInsure IN WINDOW wgwscamh.
  ENABLE fiInno btnFirst btnPrev btnNext btnLast btninadd btnInUpdate 
         btnInDelete btnInOK btnInCancel fisearch btnoksch btnInDeleteall 
         RECT-20 RECT-83 RECT-454 RECT-21 RECT-85 
      WITH FRAME frInsure IN WINDOW wgwscamh.
  {&OPEN-BROWSERS-IN-QUERY-frInsure}
  ENABLE brInsure 
      WITH FRAME frbrIns IN WINDOW wgwscamh.
  {&OPEN-BROWSERS-IN-QUERY-frbrIns}
  DISPLAY fi_filename fi_output fiUser fiFdate 
      WITH FRAME frUser IN WINDOW wgwscamh.
  ENABLE RECT-478 fi_filename bu_file bu_im fi_output bu_expout fiUser fiFdate 
      WITH FRAME frUser IN WINDOW wgwscamh.
  {&OPEN-BROWSERS-IN-QUERY-frUser}
  VIEW wgwscamh.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdAddCom wgwscamh 
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDDisableComp wgwscamh 
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDDispComp wgwscamh 
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
FIND FIRST insure USE-INDEX insure01 WHERE insure.compno = ficompno NO-LOCK NO-WAIT NO-ERROR.
IF AVAIL insure  THEN DO:
    ASSIGN
         fiinmodel  = insure.insno
         fiInno     = insure.lName
         fisumins   = insure.Text2
         fipremt    = insure.Branch 
         fiLName    = deci(insure.Text3)
         fiInAddr1  = deci(insure.Addr1)
         fiInAddr2  = deci(insure.Addr2)
         fiInAddr3  = deci(insure.Addr3)
         fiInAddr4  = deci(insure.Addr4)
         fiInTelno  = deci(insure.Telno) 
         fiproducer = insure.Text1  .
     DISP 
         fiinmodel  
         fiInno
         fipremt
         fisumins
         fiLName   
         fiInAddr1 
         fiInAddr2 
         fiInAddr3 
         fiInAddr4 
         fiInTelno  
         fiproducer
         WITH FRAME frinsure.
END.
ASSIGN gComp = company.compno.
RUN pdUpdateQ.
DISP brinsure  WITH FRAME frbrins.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdDispIns wgwscamh 
PROCEDURE pdDispIns :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DISPLAY /*insure.compno  @ ficompno*/
        Insure.lName   @ fiInno
        Insure.Branch  @ fipremt
        insure.text2   @ fisumins
        Insure.InsNo   @ fiinmodel
        insure.vatcode @ fiage_fr 
        insure.text4   @ fiage_t 
        Insure.text3   @ fiLName         
        Insure.Addr1   @ fiInAddr1         
        Insure.Addr2   @ fiInAddr2
        Insure.Addr3   @ fiInAddr3
        Insure.Addr4   @ fiInAddr4 
        Insure.text1   @ fiproducer
        Insure.TelNo   @ fiInTelNo WITH FRAME frinsure .
  DISP  Insure.FDate   @ fiFDate   WITH FRAME fruser   .
   /*raSex = IF Insure.Sex = "M" THEN 1 ELSE IF Insure.Sex = "F" THEN 2 ELSE 3 .     
   DISP raSex  WITH FRAME {&FRAME-NAME}.*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pddisplogin wgwscamh 
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
        fiinmodel    = insure.insNo                             
        fiInno       = insure.fname                            
        fiage_fr     = insure.vatcode 
        fiage_t      = insure.text4
        fipremt      = insure.Branch                              
        filname      = DECI(insure.text3)                       
        fiinAddr1    = DECI(insure.Addr1)                
        fiinAddr2    = DECI(insure.Addr2)                
        fiinAddr3    = DECI(insure.Addr3)                
        fiinAddr4    = DECI(insure.Addr4)                
        fiinTelNo    = DECI(insure.telno)
        fiproducer   = insure.Text1
        fisumins     = insure.text2
        brInsure:Sensitive  IN FRAM frbrins = Yes.           
END.                                                       
DISP   fiinmodel                                            
       fiInno
       fiage_fr 
       fiage_t
       fipremt 
       fisumins
       filname        
       fiinAddr1   
       fiinAddr2  
       fiinAddr3  
       fiinAddr4  
       fiinTelNo 
       fiproducer WITH FRAME frinsure.
DISP brInsure WITH FRAME frbrins.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdEnable wgwscamh 
PROCEDURE pdEnable :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ENABLE 
    fiinmodel  fiInno    fiage_fr  fiage_t
    fipremt    fisumins  
    fiLName    fiInAddr1 fiInAddr2   fiInAddr3   fiInAddr4  
    fiInTelNo  btnInOK   btnInCancel fiproducer
    WITH FRAME frinsure.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdenablecomp wgwscamh 
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDInitData wgwscamh 
PROCEDURE PDInitData :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN 
    FRAME frComp fiCompNo fiCompNo = ""
    FRAME frComp fiABName fiAbName = ""
    FRAME frComp fiName   fiName   = "campaignhct"
    FRAME frComp fiName2  fiName2  = "campaignhct"
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdUpdateQ wgwscamh 
PROCEDURE pdUpdateQ :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
OPEN QUERY brInsure  FOR EACH Insure USE-INDEX Insure03 NO-LOCK
            WHERE Insure.CompNo = gComp  
    BY Insure.lname.
                    /*BY deci(Insure.InsNo) .*/
    /*FIND CURRENT Insure NO-LOCK NO-ERROR.
    IF NOT AVAIL insure THEN DO:  
        DISPLAY  
                ""  @ fiInno
                ""  @ fipremt
                ""  @ fisumins
                ""  @ fiinmodel
                ""  @ fiage_fr 
                ""  @ fiage_t 
                ""  @ fiLName         
                ""  @ fiInAddr1         
                ""  @ fiInAddr2
                ""  @ fiInAddr3
                ""  @ fiInAddr4 
                ""  @ fiproducer
                ""  @ fiInTelNo WITH FRAME frinsure .
          /*DISP  Insure.FDate   @ fiFDate   WITH FRAME fruser   .*/
    END.*/
    IF CAN-FIND (FIRST Insure WHERE Insure.compno = gComp )  THEN DO:
        /*RUN PdUpdateQ IN THIS-PROCEDURE.*/
        RUN pdDispIns IN THIS-PROCEDURE. 
        /*APPLY "VALUE-CHANGED" TO brInsure.*/
    END.
    ELSE DISPLAY  
                ""  @ fiInno
                ""  @ fipremt
                ""  @ fisumins
                ""  @ fiinmodel
                ""  @ fiage_fr 
                ""  @ fiage_t 
                ""  @ fiLName         
                ""  @ fiInAddr1         
                ""  @ fiInAddr2
                ""  @ fiInAddr3
                ""  @ fiInAddr4 
                ""  @ fiproducer
                ""  @ fiInTelNo WITH FRAME frinsure .
   
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE ProcDisable wgwscamh 
PROCEDURE ProcDisable :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DISABLE 
    fiinmodel 
    fiInno 
    fiage_fr 
    fiage_t
    fipremt 
    fisumins
    fiLName 
    fiinAddr1  
    fiinAddr2 
    fiinAddr3 
    fiinAddr4  
    fiinTelNo fiproducer
  /*fiInsNo*/
  WITH FRAME frinsure.  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE ProcUpdateInsure wgwscamh 
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
           FIND LAST bIns   USE-INDEX Insure01 WHERE bIns.CompNo = pComp NO-LOCK NO-ERROR.
           CREATE Insure.
                          
       END.
    END. 
    ELSE IF cmode = "UPDATE" THEN DO WITH FRAME frbrins /*{&FRAME-NAME}*/:
         GET CURRENT brInsure EXCLUSIVE-LOCK.
    END. 
        
    ASSIGN 
        FRAME frcomp    ficompno
        FRAME frInsure  fiinmodel  
        FRAME frInsure  fiInno
        FRAME frinsure  fiage_fr  
        FRAME frinsure  fiage_t 
        FRAME frInsure  fipremt
        FRAME frinsure  fisumins
        FRAME frInsure  fiLName   
        FRAME frInsure  fiInAddr1 
        FRAME frInsure  fiInAddr2 
        FRAME frInsure  fiInAddr3 
        FRAME frInsure  fiInAddr4 
        FRAME frInsure  fiInTelNo
        FRAME frInsure  fiproducer

        insure.compno  = ficompno
        Insure.lName   = fiInno
        Insure.Branch  = fipremt
        insure.text2   = fisumins
        Insure.InsNo   = fiinmodel
        insure.vatcode = fiage_fr  
        insure.text4   = fiage_t  
        Insure.text3   = string(fiLName)
        Insure.Addr1   = string(fiInAddr1)
        Insure.Addr2   = string(fiInAddr2)
        Insure.Addr3   = string(fiInAddr3)
        Insure.Addr4   = string(fiInAddr4) 
        Insure.TelNo   = string(fiInTelNo)
        insure.Text1   = fiproducer
        
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_outputfile wgwscamh 
PROCEDURE proc_outputfile :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

FOR EACH   wdetail2 USE-INDEX wdetail201  NO-LOCK
BY DECI(wdetail2.id ).
    EXPORT DELIMITER "|"
        wdetail2.model   
        wdetail2.id 
        wdetail2.agef        
        wdetail2.aget        
        wdetail2.premt       
        wdetail2.producer    
        wdetail2.sumins.     
     
END. 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pro_assign1 wgwscamh 
PROCEDURE Pro_assign1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH wdetail2 .
    IF wdetail2.id  = "" THEN NEXT.
    FIND FIRST brstat.company USE-INDEX Company01 WHERE
        brstat.company.compno = gComp              NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL company THEN DO:
        /*comment by Kridtiya i. A57-0126....
        FIND FIRST brstat.insure USE-INDEX Insure03  WHERE 
            brstat.insure.compno  = company.compno       AND 
            brstat.Insure.InsNo   = wdetail2.model       AND 
            brstat.insure.lname   = wdetail2.id          AND   
            brstat.insure.vatcode = wdetail2.agef        AND
            brstat.insure.text4   = wdetail2.aget        AND
            brstat.insure.branch  = wdetail2.premt       AND
            /*brstat.insure.Text1   = wdetail2.producer*/  
            brstat.insure.Text2   = wdetail2.sumins      NO-ERROR NO-WAIT.
        IF NOT AVAIL brstat.insure THEN DO:
            CREATE brstat.insure.
            ASSIGN
                brstat.insure.compno  = company.compno    
                brstat.Insure.InsNo   = wdetail2.model    
                brstat.insure.lname   = wdetail2.id       
                brstat.insure.vatcode = wdetail2.agef
                brstat.insure.text4   = wdetail2.aget
                brstat.insure.branch  = wdetail2.premt    
                brstat.insure.Text1   = wdetail2.producer 
                brstat.insure.Text2   = wdetail2.sumins.  
        END.
        ELSE DO:
            ASSIGN
                brstat.insure.compno  = company.compno    
                brstat.Insure.InsNo   = wdetail2.model    
                brstat.insure.lname   = wdetail2.id       
                brstat.insure.vatcode = wdetail2.agef
                brstat.insure.text4   = wdetail2.aget
                brstat.insure.branch  = wdetail2.premt    
                brstat.insure.Text1   = wdetail2.producer 
                brstat.insure.Text2   = wdetail2.sumins. 
        END....comment by Kridtiya i. A57-0126....*/
        /*A57-0126*/
        FIND FIRST brstat.insure USE-INDEX Insure03  WHERE 
            brstat.insure.compno  = company.compno   AND 
            brstat.Insure.InsNo   = wdetail2.model   AND 
            brstat.insure.lname   = wdetail2.id      NO-ERROR NO-WAIT.
        IF NOT AVAIL brstat.insure THEN DO:
            CREATE brstat.insure.
            ASSIGN
                brstat.insure.compno  = company.compno    
                brstat.Insure.InsNo   = wdetail2.model    
                brstat.insure.lname   = wdetail2.id       
                brstat.insure.vatcode = wdetail2.agef
                brstat.insure.text4   = wdetail2.aget
                brstat.insure.branch  = wdetail2.premt    
                brstat.insure.Text1   = wdetail2.producer 
                brstat.insure.Text2   = wdetail2.sumins.  
        END.
        /*A57-0126*/

    END.
END.
MESSAGE "Load Data Deler Compleate "   VIEW-AS ALERT-BOX.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

