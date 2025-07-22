&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          stat             PROGRESS
*/
&Scoped-define WINDOW-NAME WGWTSEMO
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS WGWTSEMO 
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
/*create by   : Kridtiya i.A58-0014  เพิ่มตัวเก็บ brand model แปลงข้อมูล */  
/*              เพื่อให้สามารถค้นหา รหัสรถได้ถูกต้อง                     */                    
CREATE WIDGET-POOL.

/* ***************************  Definitions  ************************** */

/* Parameters Definitions ---                                           */

/* Local Variable Definitions ---                                       */

/*{wuw/wuwm0001.i}*/

DEF SHARED VAR     n_User         AS CHAR.
DEF SHARED VAR     n_Passwd       AS CHAR.
DEF VAR            cUpdate        AS CHAR.
DEF BUFFER         bComp          FOR Company.
DEF VAR            nv_progname    AS CHAR.
DEF VAR            nv_objname     AS CHAR.
DEF VAR            nv_StrEnd      AS CHAR.
DEF VAR            nv_Str         AS CHAR.
DEF VAR            nv_NextPolflg  AS INT.
DEF VAR            nv_RenewPolflg AS INT.
DEF VAR            nv_PrePol      AS CHAR.
DEF VAR            pComp          AS CHAR.
DEF VAR            pRowIns        AS ROWID.
DEF NEW SHARED VAR gUser          AS CHAR.
DEF NEW SHARED VAR gPasswd        AS CHAR.
DEF VAR            gComp          AS CHAR.
DEF NEW SHARED VAR gRecMod        AS Recid.
DEF NEW SHARED VAR gRecBen        AS Recid.
DEF NEW SHARED VAR gRecIns        AS Recid.
DEF VAR            n_InsNo        AS INT.
DEFINE   WORKFILE wdetail 
    FIELD  company  AS CHAR FORMAT "x(20)"  INIT ""   
    FIELD  branch   AS CHAR FORMAT "x(2)"   INIT ""                               
    FIELD  vatcode  AS CHAR FORMAT "x(10)"  INIT ""                               
    FIELD  codeid   AS CHAR FORMAT "x(10)"  INIT ""                               
    FIELD  detail1  AS CHAR FORMAT "x(150)" INIT ""                               
    FIELD  detail2  AS CHAR FORMAT "x(60)"  INIT ""
    FIELD  brand    AS CHAR FORMAT "x(30)"  INIT ""   
    FIELD  model    AS CHAR FORMAT "x(60)"  INIT ""   
    FIELD  n_redbook       AS CHAR FORMAT "x(10)" INIT ""     
    FIELD  n_year          AS CHAR FORMAT "x(4)"  INIT ""     
    FIELD  n_marketPrice   AS CHAR FORMAT "x(20)" INIT "" .  
DEF VAR company  AS CHAR FORMAT "x(20)"  INIT "" .  
DEF VAR branch   AS CHAR FORMAT "x(2)"   INIT "" .                           
DEF VAR vatcode  AS CHAR FORMAT "x(10)"  INIT "" .                           
DEF VAR codeid   AS CHAR FORMAT "x(10)"  INIT "" .                             
DEF VAR detail1  AS CHAR FORMAT "x(150)"  INIT "" .                             
DEF VAR detail2  AS CHAR FORMAT "x(60)"  INIT "" .
DEF VAR idnumber AS DECI INIT 0 .
DEF VAR n_brand  AS CHAR FORMAT "x(30)"  INIT "" .  
DEF VAR n_model  AS CHAR FORMAT "x(60)"  INIT "" .  
DEF VAR n_countload     AS DECI FORMAT "->>>>>9"  INIT "" .  
DEF VAR n_countcomplete AS DECI FORMAT "->>>>>9"  INIT "" .  
DEF VAR n_redbook       AS CHAR FORMAT "x(10)"    INIT "" .  
DEF VAR n_year          AS CHAR FORMAT "x(4)"     INIT "" .  
DEF VAR n_marketPrice   AS CHAR FORMAT "x(20)"    INIT "" .

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME frbrIns
&Scoped-define BROWSE-NAME brInsure

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES Insure

/* Definitions for BROWSE brInsure                                      */
&Scoped-define FIELDS-IN-QUERY-brInsure Insure.CompNo Insure.InsNo ~
Insure.FName Insure.LName Insure.Text5 Insure.VatCode Insure.Text3 ~
Insure.Text4 Insure.Text1 Insure.Text2 Insure.Branch Insure.Addr3 
&Scoped-define ENABLED-FIELDS-IN-QUERY-brInsure 
&Scoped-define QUERY-STRING-brInsure FOR EACH Insure NO-LOCK ~
    BY Insure.InsNo
&Scoped-define OPEN-QUERY-brInsure OPEN QUERY brInsure FOR EACH Insure NO-LOCK ~
    BY Insure.InsNo.
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
DEFINE VAR WGWTSEMO AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON buok 
     LABEL "OK" 
     SIZE 7 BY 1.

DEFINE BUTTON bu_imp-5 
     LABEL "IMPORT" 
     SIZE 9 BY 1.

DEFINE BUTTON bu_imp-6 
     LABEL "EXPORT" 
     SIZE 10 BY 1.

DEFINE BUTTON bu_link-3 
     LABEL "....." 
     SIZE 3.5 BY 1.

DEFINE BUTTON bu_schr 
     LABEL "search" 
     SIZE 9 BY 1.

DEFINE VARIABLE fiCompno AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 25 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fiFDate AS DATE FORMAT "99/99/9999":U 
     LABEL "" 
     VIEW-AS FILL-IN 
     SIZE 13 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fisearch AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 42 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fiUser AS CHARACTER FORMAT "X(10)":U 
     LABEL "" 
     VIEW-AS FILL-IN 
     SIZE 14 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_filename AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 45 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_output AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 48 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-455
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 60 BY 3.33
     BGCOLOR 8 .

DEFINE BUTTON btnFirst 
     IMAGE-UP FILE "adeicon\pvfirst":U
     IMAGE-DOWN FILE "adeicon\pvfirstd":U
     IMAGE-INSENSITIVE FILE "adeicon\pvfirstx":U
     LABEL "<<" 
     SIZE 5.5 BY 1.

DEFINE BUTTON btninadd 
     LABEL "เพิ่ม" 
     SIZE 8 BY 1
     FONT 6.

DEFINE BUTTON btnInCancel 
     LABEL "Cancel" 
     SIZE 8 BY 1
     FONT 6.

DEFINE BUTTON btnInDelete 
     LABEL "ลบ" 
     SIZE 8 BY 1
     FONT 6.

DEFINE BUTTON btnInOK 
     LABEL "OK" 
     SIZE 8 BY 1
     FONT 6.

DEFINE BUTTON btnInUpdate 
     LABEL "แก้ไข" 
     SIZE 8 BY 1
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

DEFINE BUTTON btnReturn-2 
     LABEL "EXIT" 
     SIZE 8.67 BY 1
     FONT 6.

DEFINE VARIABLE fibrand AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 20 BY .91
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fiFName AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 57 BY .91
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiInAddr1 AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .91
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiInAddr2 AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .91
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiInAddr3 AS CHARACTER FORMAT "X(35)":U 
     VIEW-AS FILL-IN 
     SIZE 42 BY .91
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiInAddr4 AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .91
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiInBranch AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 5 BY .91
     BGCOLOR 15 FGCOLOR 1 FONT 2 NO-UNDO.

DEFINE VARIABLE fiInComp AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 11.5 BY .91
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fiInmarketprice AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 20 BY .91
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiInredbook AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 13 BY .91
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiInTelNo AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .91
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiinyear AS CHARACTER FORMAT "X(4)":U INITIAL "0" 
     VIEW-AS FILL-IN 
     SIZE 6 BY .91
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiLName AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 57 BY .91
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fimodel AS CHARACTER FORMAT "X(45)":U 
     VIEW-AS FILL-IN 
     SIZE 32 BY .91
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fivatcode AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 14.5 BY .91
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-20
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 33 BY 1.76
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-21
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 25.5 BY 1.76
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-454
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 69 BY 8.67
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-83
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 21 BY 1.76
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-85
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 13 BY 1.76
     BGCOLOR 4 .

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY brInsure FOR 
      Insure SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE brInsure
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS brInsure WGWTSEMO _STRUCTURED
  QUERY brInsure NO-LOCK DISPLAY
      Insure.CompNo COLUMN-LABEL "Code" FORMAT "X(13)":U WIDTH 11.83
      Insure.InsNo COLUMN-LABEL "ID" FORMAT "X(8)":U WIDTH 6.83
      Insure.FName COLUMN-LABEL "Deler Name." FORMAT "X(65)":U
            WIDTH 40
      Insure.LName COLUMN-LABEL "show room" FORMAT "X(30)":U WIDTH 10
      Insure.Text5 COLUMN-LABEL "Class" FORMAT "x(5)":U WIDTH 4.5
      Insure.VatCode COLUMN-LABEL "Vat_Co." FORMAT "X(10)":U
      Insure.Text3 COLUMN-LABEL "Redbook" FORMAT "x(10)":U
      Insure.Text4 COLUMN-LABEL "Year" FORMAT "x(4)":U
      Insure.Text1 COLUMN-LABEL "Brand" FORMAT "X(25)":U WIDTH 16
      Insure.Text2 COLUMN-LABEL "Model" FORMAT "X(45)":U WIDTH 24
      Insure.Branch COLUMN-LABEL "Br." FORMAT "X(2)":U WIDTH 4
      Insure.Addr3 COLUMN-LABEL "status" FORMAT "X(10)":U WIDTH 8
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 131 BY 12.52
         BGCOLOR 15  ROW-HEIGHT-CHARS .57.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME frmain
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 24
         BGCOLOR 29 .

DEFINE FRAME frInsure
     fiInComp AT ROW 1.52 COL 10 COLON-ALIGNED NO-LABEL
     fiInBranch AT ROW 1.52 COL 28.33 COLON-ALIGNED NO-LABEL
     fivatcode AT ROW 2.52 COL 10 COLON-ALIGNED NO-LABEL
     fiFName AT ROW 3.52 COL 10 COLON-ALIGNED NO-LABEL
     fiLName AT ROW 4.52 COL 10 COLON-ALIGNED NO-LABEL
     fibrand AT ROW 5.52 COL 10 COLON-ALIGNED NO-LABEL
     fimodel AT ROW 5.52 COL 35.17 COLON-ALIGNED NO-LABEL
     fiInredbook AT ROW 6.52 COL 24 RIGHT-ALIGNED NO-LABEL DEBLANK 
     fiinyear AT ROW 6.52 COL 36.17 RIGHT-ALIGNED NO-LABEL DEBLANK 
     fiInmarketprice AT ROW 6.52 COL 68.17 RIGHT-ALIGNED NO-LABEL DEBLANK 
     fiInAddr3 AT ROW 7.52 COL 53 RIGHT-ALIGNED NO-LABEL
     fiInAddr4 AT ROW 7.52 COL 68.17 RIGHT-ALIGNED NO-LABEL
     fiInAddr1 AT ROW 8.52 COL 26 RIGHT-ALIGNED NO-LABEL DEBLANK 
     fiInAddr2 AT ROW 8.52 COL 47.67 RIGHT-ALIGNED NO-LABEL DEBLANK 
     fiInTelNo AT ROW 8.52 COL 52.17 COLON-ALIGNED NO-LABEL
     btnInOK AT ROW 10.24 COL 36.67
     btnFirst AT ROW 1.52 COL 38.83
     btnPrev AT ROW 1.52 COL 44.5
     btnNext AT ROW 1.52 COL 50.17
     btnLast AT ROW 1.52 COL 56.5
     btninadd AT ROW 10.24 COL 2.83
     btnInUpdate AT ROW 10.24 COL 12.67
     btnInDelete AT ROW 10.24 COL 22.83
     btnInCancel AT ROW 10.24 COL 45.5
     btnReturn-2 AT ROW 10.24 COL 59.17
     "Branch" VIEW-AS TEXT
          SIZE 6 BY .91 AT ROW 1.52 COL 24
          BGCOLOR 3 FGCOLOR 15 
     "Class  :" VIEW-AS TEXT
          SIZE 7 BY .91 AT ROW 6.52 COL 37.67
          BGCOLOR 3 FGCOLOR 15 
     "Tel :" VIEW-AS TEXT
          SIZE 4.5 BY .91 AT ROW 8.52 COL 49.33
          BGCOLOR 3 FGCOLOR 15 FONT 1
     "Producer" VIEW-AS TEXT
          SIZE 8.5 BY .91 AT ROW 8.52 COL 3
          BGCOLOR 3 FGCOLOR 15 
     "Agent" VIEW-AS TEXT
          SIZE 5.5 BY .91 AT ROW 8.52 COL 27.67
          BGCOLOR 3 FGCOLOR 15 
     "ชื่อดีเลอร์2" VIEW-AS TEXT
          SIZE 8.5 BY .91 AT ROW 4.52 COL 3
          BGCOLOR 3 FGCOLOR 15 
     "รุ่น :" VIEW-AS TEXT
          SIZE 4 BY .91 AT ROW 5.52 COL 32.5
          BGCOLOR 3 FGCOLOR 15 
     "ID" VIEW-AS TEXT
          SIZE 8.5 BY .91 AT ROW 1.52 COL 3
          BGCOLOR 3 FGCOLOR 15 
     "Status" VIEW-AS TEXT
          SIZE 8.5 BY .91 AT ROW 7.52 COL 3
          BGCOLOR 3 FGCOLOR 15 
     "ยี่ห้อ" VIEW-AS TEXT
          SIZE 8.5 BY .91 AT ROW 5.52 COL 3
          BGCOLOR 3 FGCOLOR 15 
     "Vat code." VIEW-AS TEXT
          SIZE 8.5 BY .91 AT ROW 2.52 COL 3
          BGCOLOR 3 FGCOLOR 15 
     "Redbook" VIEW-AS TEXT
          SIZE 8.5 BY .91 AT ROW 6.52 COL 3
          BGCOLOR 3 FGCOLOR 15 
     "ชื่อดีเลอร์" VIEW-AS TEXT
          SIZE 8.5 BY .91 AT ROW 3.52 COL 3
          BGCOLOR 3 FGCOLOR 15 
     "Year :" VIEW-AS TEXT
          SIZE 5 BY .91 AT ROW 6.52 COL 25.67
          BGCOLOR 3 FGCOLOR 15 
     RECT-20 AT ROW 9.95 COL 1.5
     RECT-83 AT ROW 9.95 COL 34.83
     RECT-454 AT ROW 1.14 COL 1.5
     RECT-21 AT ROW 1.19 COL 37.33
     RECT-85 AT ROW 9.95 COL 56.83
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 62 ROW 1
         SIZE 71 BY 11
         BGCOLOR 3 .

DEFINE FRAME frComp
     fiCompno AT ROW 2.81 COL 22 NO-LABEL
     buok AT ROW 2.81 COL 47.5
     fi_filename AT ROW 6 COL 2 NO-LABEL
     bu_link-3 AT ROW 6 COL 47.83
     bu_imp-5 AT ROW 6 COL 52
     fi_output AT ROW 8.38 COL 1.83 NO-LABEL
     bu_imp-6 AT ROW 8.38 COL 51
     fiFDate AT ROW 9.52 COL 1
     fiUser AT ROW 9.52 COL 14.83
     fisearch AT ROW 10.67 COL 8.5 NO-LABEL
     bu_schr AT ROW 10.67 COL 51.67
     "Search" VIEW-AS TEXT
          SIZE 6 BY 1 AT ROW 10.67 COL 2
          BGCOLOR 1 FGCOLOR 7 
     "File name EXP:" VIEW-AS TEXT
          SIZE 14 BY 1 AT ROW 7.24 COL 1.5
          BGCOLOR 1 FGCOLOR 7 FONT 6
     "     SET UP MODEL BY PACKAGE / BRANCH" VIEW-AS TEXT
          SIZE 50 BY 1 AT ROW 1.57 COL 4
          BGCOLOR 2 FGCOLOR 7 FONT 6
     "COMPANY CODE :" VIEW-AS TEXT
          SIZE 18 BY 1 AT ROW 2.81 COL 4
          BGCOLOR 3 FGCOLOR 15 FONT 6
     "File name IMP:" VIEW-AS TEXT
          SIZE 14 BY 1 AT ROW 4.86 COL 1.5
          BGCOLOR 1 FGCOLOR 7 FONT 6
     RECT-455 AT ROW 1.24 COL 1.5
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 61 BY 11
         BGCOLOR 3 .

DEFINE FRAME frbrIns
     brInsure AT ROW 1.24 COL 1.5
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 12.05
         SIZE 132.5 BY 12.9
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
  CREATE WINDOW WGWTSEMO ASSIGN
         HIDDEN             = YES
         TITLE              = "Set Company Code Delar [WGWNISMO.W]"
         HEIGHT             = 24.05
         WIDTH              = 132
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
/* SETTINGS FOR WINDOW WGWTSEMO
  VISIBLE,,RUN-PERSISTENT                                               */
/* REPARENT FRAME */
ASSIGN FRAME frbrIns:FRAME = FRAME frmain:HANDLE
       FRAME frComp:FRAME = FRAME frmain:HANDLE
       FRAME frInsure:FRAME = FRAME frmain:HANDLE.

/* SETTINGS FOR FRAME frbrIns
                                                                        */
/* BROWSE-TAB brInsure 1 frbrIns */
/* SETTINGS FOR FRAME frComp
                                                                        */
/* SETTINGS FOR FILL-IN fiCompno IN FRAME frComp
   ALIGN-L                                                              */
/* SETTINGS FOR FILL-IN fiFDate IN FRAME frComp
   ALIGN-L                                                              */
/* SETTINGS FOR FILL-IN fisearch IN FRAME frComp
   ALIGN-L                                                              */
/* SETTINGS FOR FILL-IN fiUser IN FRAME frComp
   ALIGN-L                                                              */
/* SETTINGS FOR FILL-IN fi_filename IN FRAME frComp
   ALIGN-L                                                              */
/* SETTINGS FOR FILL-IN fi_output IN FRAME frComp
   ALIGN-L                                                              */
/* SETTINGS FOR FRAME frInsure
   Custom                                                               */
/* SETTINGS FOR FILL-IN fibrand IN FRAME frInsure
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
/* SETTINGS FOR FILL-IN fiInmarketprice IN FRAME frInsure
   NO-ENABLE ALIGN-R                                                    */
/* SETTINGS FOR FILL-IN fiInredbook IN FRAME frInsure
   NO-ENABLE ALIGN-R                                                    */
/* SETTINGS FOR FILL-IN fiinyear IN FRAME frInsure
   NO-ENABLE ALIGN-R                                                    */
/* SETTINGS FOR FILL-IN fiLName IN FRAME frInsure
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fimodel IN FRAME frInsure
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fivatcode IN FRAME frInsure
   NO-ENABLE                                                            */
/* SETTINGS FOR FRAME frmain
   Custom                                                               */

DEFINE VARIABLE XXTABVALXX AS LOGICAL NO-UNDO.

ASSIGN XXTABVALXX = FRAME frbrIns:MOVE-BEFORE-TAB-ITEM (FRAME frInsure:HANDLE)
/* END-ASSIGN-TABS */.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(WGWTSEMO)
THEN WGWTSEMO:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE brInsure
/* Query rebuild information for BROWSE brInsure
     _TblList          = "stat.Insure"
     _Options          = "NO-LOCK"
     _OrdList          = "stat.Insure.InsNo|yes"
     _FldNameList[1]   > stat.Insure.CompNo
"Insure.CompNo" "Code" "X(13)" "character" ? ? ? ? ? ? no ? no no "11.83" yes no no "U" "" ""
     _FldNameList[2]   > stat.Insure.InsNo
"Insure.InsNo" "ID" "X(8)" "character" ? ? ? ? ? ? no ? no no "6.83" yes no no "U" "" ""
     _FldNameList[3]   > stat.Insure.FName
"Insure.FName" "Deler Name." "X(65)" "character" ? ? ? ? ? ? no ? no no "40" yes no no "U" "" ""
     _FldNameList[4]   > stat.Insure.LName
"Insure.LName" "show room" "X(30)" "character" ? ? ? ? ? ? no ? no no "10" yes no no "U" "" ""
     _FldNameList[5]   > stat.Insure.Text5
"Insure.Text5" "Class" "x(5)" "character" ? ? ? ? ? ? no ? no no "4.5" yes no no "U" "" ""
     _FldNameList[6]   > stat.Insure.VatCode
"Insure.VatCode" "Vat_Co." "X(10)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[7]   > stat.Insure.Text3
"Insure.Text3" "Redbook" "x(10)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[8]   > stat.Insure.Text4
"Insure.Text4" "Year" "x(4)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[9]   > stat.Insure.Text1
"Insure.Text1" "Brand" "X(25)" "character" ? ? ? ? ? ? no ? no no "16" yes no no "U" "" ""
     _FldNameList[10]   > stat.Insure.Text2
"Insure.Text2" "Model" "X(45)" "character" ? ? ? ? ? ? no ? no no "24" yes no no "U" "" ""
     _FldNameList[11]   > stat.Insure.Branch
"Insure.Branch" "Br." ? "character" ? ? ? ? ? ? no ? no no "4" yes no no "U" "" ""
     _FldNameList[12]   > stat.Insure.Addr3
"Insure.Addr3" "status" "X(10)" "character" ? ? ? ? ? ? no ? no no "8" yes no no "U" "" ""
     _Query            is NOT OPENED
*/  /* BROWSE brInsure */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME WGWTSEMO
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL WGWTSEMO WGWTSEMO
ON END-ERROR OF WGWTSEMO /* Set Company Code Delar [WGWNISMO.W] */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL WGWTSEMO WGWTSEMO
ON WINDOW-CLOSE OF WGWTSEMO /* Set Company Code Delar [WGWNISMO.W] */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME brInsure
&Scoped-define SELF-NAME brInsure
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brInsure WGWTSEMO
ON MOUSE-SELECT-CLICK OF brInsure IN FRAME frbrIns
DO:
    GET CURRENT brInsure.
    RUN PdDispIns IN THIS-PROCEDURE. 
    FIND CURRENT stat.Insure NO-LOCK.
    IF NOT AVAIL stat.Insure THEN RETURN NO-APPLY.
    IF AVAIL stat.Insure AND stat.Insure.CompNo = pComp THEN DO:
        pRowIns = ROWID (stat.Insure).
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brInsure WGWTSEMO
ON MOUSE-SELECT-DBLCLICK OF brInsure IN FRAME frbrIns
DO:
    /*APPLY "MOUSE-SELECT-CLICK" TO brInsure IN FRAME frbrins.    
    APPLY "CLOSE" TO THIS-PROCEDURE.*/
    GET CURRENT brInsure.
    RUN PdDispIns IN THIS-PROCEDURE. 

    FIND CURRENT stat.Insure NO-LOCK.
    IF NOT AVAIL stat.Insure THEN RETURN NO-APPLY.
    IF AVAIL stat.Insure AND stat.Insure.CompNo = pComp THEN DO:
       pRowIns = ROWID (Insure).
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brInsure WGWTSEMO
ON VALUE-CHANGED OF brInsure IN FRAME frbrIns
DO:
    FIND CURRENT stat.Insure NO-LOCK.
    RUN pdDispIns IN THIS-PROCEDURE. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frInsure
&Scoped-define SELF-NAME btnFirst
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnFirst WGWTSEMO
ON CHOOSE OF btnFirst IN FRAME frInsure /* << */
DO:
  GET FIRST brInsure.
  IF NOT AVAIL stat.Insure THEN RETURN NO-APPLY.  
  REPOSITION brInsure TO ROWID ROWID (stat.Insure).
  APPLY "VALUE-CHANGED" TO brInsure IN FRAME frbrIns.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btninadd
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btninadd WGWTSEMO
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
    ASSIGN gComp = trim(fiCompno).
    RUN PDEnable IN THIS-PROCEDURE.
    ASSIGN 
        cUpdate     = "ADD"
        fiIncomp    = nv_InsNo
        fiInbranch  = ""
        fivatcode   = ""
        fiFName     = ""    
        fiLName     = "" 
        fibrand     = ""  /*A57-0017*/
        fimodel     = ""  /*A57-0017*/
        fiInAddr1   = ""    
        fiInAddr2   = ""    
        fiInAddr3   = ""    
        fiInAddr4   = ""
        fiInTelNo   = ""
        fiInredbook     = "" /*A57-0088*/ 
        fiinyear        = "" /*A57-0088*/ 
        fiInmarketprice = "" /*A57-0088*/ 
        fiFDate     = TODAY
        btnFirst:Sensitive    = No
        btnPrev:Sensitive     = No
        btnNext:Sensitive     = No
        btnLast:Sensitive     = No
        btnInAdd:Sensitive    = No
        btnInUpdate:Sensitive = No
        btnInDelete:Sensitive = No  
        btnInOK:Sensitive     = Yes
        btnInCancel:Sensitive = Yes.
    DISPLAY 
        fiInComp    fiInbranch fivatcode
        fifName     fiLName    fiInAddr1  
        fiInAddr2   fiInAddr3  fibrand           /*A57-0017*/    
        fiInAddr4   fiInTelNo  fimodel           /*A57-0017*/      
        fiInredbook  fiinyear  fiInmarketprice   /*A57-0088*/
        WITH FRAME frInsure.
    DISP fiFDate WITH FRAME fruser.
    APPLY "ENTRY" TO fiInComp IN FRAME frInsure .
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnInCancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnInCancel WGWTSEMO
ON CHOOSE OF btnInCancel IN FRAME frInsure /* Cancel */
DO:
    RUN ProcDisable IN THIS-PROCEDURE.
    ASSIGN 
        btnFirst:Sensitive    IN FRAM frinsure = Yes
        btnPrev:Sensitive     IN FRAM frinsure = Yes
        btnNext:Sensitive     IN FRAM frinsure = Yes
        btnLast:Sensitive     IN FRAM frinsure = Yes
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
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnInDelete WGWTSEMO
ON CHOOSE OF btnInDelete IN FRAME frInsure /* ลบ */
DO:
    DEF VAR logAns AS LOGI INIT No.  
    logAns = No.
    MESSAGE "ต้องการลบข้อมูลรายการ " + TRIM (stat.Insure.Insno) + " " + 
        TRIM (Insure.Fname) + " " + TRIM (stat.Insure.LName) + " ?"  UPDATE logAns 
        VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO
        TITLE "ลบข้อมูลรายการนี้".   
    IF logAns THEN DO:  
        GET CURRENT brInsure EXCLUSIVE-LOCK.
        DELETE Insure.
        MESSAGE "ลบข้อมูลรายการนี้..." VIEW-AS ALERT-BOX INFORMATION.  
    END.  
    RUN PdUpdateQ.
    APPLY "VALUE-CHANGED" TO brInsure IN FRAM frbrins.  
    RUN ProcDisable IN THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnInOK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnInOK WGWTSEMO
ON CHOOSE OF btnInOK IN FRAME frInsure /* OK */
DO:
    ASSIGN
        FRAME frInsure fiInBranch
        FRAME frInsure fiIncomp
        FRAM  frinsure fivatcode
        FRAME frInsure fiFName
        FRAME frInsure fiLName 
        FRAME frInsure fibrand   /*A57-0017*/
        FRAME frInsure fimodel   /*A57-0017*/
        FRAME frInsure fiInAddr1
        FRAME frInsure fiInAddr2
        FRAME frInsure fiInAddr3
        FRAME frInsure fiInAddr4
        FRAME frInsure fiInTelNo
        FRAME frInsure fiInredbook      /*A57-0088*/
        FRAME frInsure fiinyear         /*A57-0088*/                                     
        FRAME frInsure fiInmarketprice.  /*A57-0088*/
    IF fivatcode NE ""   THEN DO:
        FIND FIRST sicsyac.xmm600 USE-INDEX xmm60001 WHERE
            sicsyac.xmm600.acno = trim(fivatcode)  NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL sicsyac.xmm600 THEN DO: 
            ASSIGN fivatcode = "".
            MESSAGE "Not found vatcode in table xmm600 Please insert again!!!!!" VIEW-AS ALERT-BOX.
            APPLY "ENTRY" TO fivatcode IN FRAME frinsure.
        END.
    END.
    /*kridtiya i. A53-0182 ตรวจสอบค่า Producer code*/
    IF  fiInAddr1 NE ""  THEN DO:
        FIND FIRST sicsyac.xmm600 USE-INDEX xmm60001 WHERE
            sicsyac.xmm600.acno = trim(fiInAddr1)    NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL sicsyac.xmm600 THEN DO: 
            ASSIGN fiInAddr1 = "".
            MESSAGE "Not found Producer in table xmm600 Please insert again!!!!!" VIEW-AS ALERT-BOX.
            APPLY "ENTRY" TO fiInAddr1 IN FRAME frinsure.
        END.
    END.
    IF  fiInAddr2 NE ""  THEN DO:
        FIND FIRST sicsyac.xmm600 USE-INDEX xmm60001 WHERE
            sicsyac.xmm600.acno = trim(fiInAddr2)    NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL sicsyac.xmm600 THEN DO: 
            ASSIGN fiInAddr2 = "".
            MESSAGE "Not found Producer in table xmm600 Please insert again!!!!!" VIEW-AS ALERT-BOX.
            APPLY "ENTRY" TO fiInAddr2 IN FRAME frinsure.
        END.
    END.
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
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnInUpdate WGWTSEMO
ON CHOOSE OF btnInUpdate IN FRAME frInsure /* แก้ไข */
DO:
    RUN PdEnable IN THIS-PROCEDURE.
    ASSIGN
        fiIncomp    fiInBranch  fivatcode   fiFName     fiLName     fibrand     fimodel   /*A57-0017*/
        fiInAddr1   fiInAddr2   fiInAddr3   fiInAddr4   fiInTelNo   
        fiInredbook fiinyear    fiInmarketprice   /*A57-0088*/
        cUpdate = "UPDATE"
        btnFirst:SENSITIVE    IN FRAME frInsure = No
        btnPrev:Sensitive     IN FRAME frInsure = No
        btnNext:Sensitive     IN FRAME frInsure = No
        btnLast:Sensitive     IN FRAME frInsure = No
        btnInAdd:Sensitive    IN FRAME frInsure = No
        btnInUpdate:Sensitive IN FRAME frInsure = No
        btnInDelete:Sensitive IN FRAME frInsure = No  
        btnInOK:Sensitive     IN FRAME frInsure = Yes
        btnInCancel:Sensitive IN FRAME frInsure = Yes
        brInsure:Sensitive    IN FRAME frbrins  = No.
    RUN PdDispIns IN THIS-PROCEDURE.
    APPLY "ENTRY" TO fiIncomp IN FRAM frInsure.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnLast
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnLast WGWTSEMO
ON CHOOSE OF btnLast IN FRAME frInsure /* >> */
DO:
  GET LAST brInsure.
  IF NOT AVAIL stat.Insure THEN RETURN NO-APPLY.
  REPOSITION brInsure TO ROWID ROWID (stat.Insure).
  APPLY "VALUE-CHANGED" TO brInsure IN FRAME frbrins.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnNext
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnNext WGWTSEMO
ON CHOOSE OF btnNext IN FRAME frInsure /* > */
DO:
  GET NEXT brInsure.
  IF NOT AVAIL stat.Insure THEN RETURN NO-APPLY.
  REPOSITION brInsure TO ROWID ROWID (stat.Insure).
  APPLY "VALUE-CHANGED" TO brInsure IN FRAME frbrins.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnPrev
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnPrev WGWTSEMO
ON CHOOSE OF btnPrev IN FRAME frInsure /* < */
DO:
  GET PREV brInsure.
  IF NOT AVAIL stat.Insure THEN RETURN NO-APPLY.
  REPOSITION brInsure TO ROWID ROWID (stat.Insure).
  APPLY "VALUE-CHANGED" TO brInsure IN FRAME frbrins.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnReturn-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnReturn-2 WGWTSEMO
ON CHOOSE OF btnReturn-2 IN FRAME frInsure /* EXIT */
DO:
   APPLY "CLOSE" TO THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frComp
&Scoped-define SELF-NAME buok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buok WGWTSEMO
ON CHOOSE OF buok IN FRAME frComp /* OK */
DO:
    IF fiCompno = "" THEN DO:
        message "Please insert company name.."  view-as alert-box.
        APPLY "Entry" TO fiCompno.
        RETURN NO-APPLY.
    END.
    ELSE DO:
        FIND FIRST stat.Company WHERE  stat.Company.compno = fiCompNo NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL stat.company THEN DO:
            RUN pdDispComp.
            gComp = stat.Company.Compno.
        END.
        ELSE DO:
            DISP "" @ fiCompNo WITH FRAME frComp.
        END.
        IF CAN-FIND (FIRST stat.Insure WHERE stat.Insure.compno = gComp )  THEN DO:
            RUN PdUpdateQ IN THIS-PROCEDURE.
        END.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_imp-5
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_imp-5 WGWTSEMO
ON CHOOSE OF bu_imp-5 IN FRAME frComp /* IMPORT */
DO:
    FOR EACH wdetail.
        DELETE wdetail.
    END.
    ASSIGN 
        idnumber = 0
        company  = ""
        branch   = ""
        vatcode  = ""
        codeid   = ""
        detail1  = ""
        detail2  = ""
        n_brand  = ""           /*A57-0017*/    
        n_model  = ""           /*A57-0017*/ 
        n_redbook     = ""      /*A57-0088*/ 
        n_year        = ""      /*A57-0088*/ 
        n_marketPrice = ""      /*A57-0088*/ 
        n_countload     = 0     /*A57-0017*/   
        n_countcomplete = 0 .   /*A57-0017*/   
    INPUT FROM VALUE(fi_FileName).
    REPEAT:
        IMPORT DELIMITER "|" 
            company
            branch 
            vatcode
            codeid 
            detail1
            detail2
            n_brand              /*A57-0017*/    
            n_model              /*A57-0017*/  
            n_redbook            /*A57-0088*/ 
            n_year               /*A57-0088*/ 
            n_marketPrice .      /*A57-0088*/  
        IF (index(company,"com") <> 0 ) OR ( company = "" ) OR (codeid   = "" ) THEN 
            ASSIGN company  = ""
            branch   = ""
            vatcode  = ""
            codeid   = ""
            detail1  = ""
            detail2  = ""
            n_brand  = ""           /*A57-0017*/    
            n_model  = ""           /*A57-0017*/ 
            n_redbook     = ""      /*A57-0088*/ 
            n_year        = ""      /*A57-0088*/ 
            n_marketPrice = "" .    /*A57-0088*/ 
        ELSE IF (detail1 <> "")  AND (detail2 <> "") AND (trim(codeid) <> "" ) THEN DO:
            FIND FIRST wdetail WHERE 
                wdetail.detail1 = trim(detail1)     AND  
                wdetail.detail2 = trim(detail2)     NO-ERROR NO-WAIT.
            IF NOT AVAIL wdetail THEN DO:
                CREATE wdetail.
                ASSIGN 
                    n_countload     = n_countload  + 1  /*A57-0017*/
                    wdetail.company = trim(company)     /* 1  */                             
                    wdetail.branch  = trim(branch)      /* 2  */                                   
                    wdetail.vatcode = trim(vatcode)     /* 3  */                               
                    wdetail.codeid  = trim(codeid)      /* 4  */                               
                    wdetail.detail1 = trim(detail1)     /* 5  */                                   
                    wdetail.detail2 = trim(detail2)     /* 6  */
                    wdetail.brand   = trim(n_brand)     /*A57-0017*/  
                    wdetail.model           = trim(n_model)     /*A57-0017*/  
                    wdetail.n_redbook       = trim(n_redbook)       /*A57-0088*/  
                    wdetail.n_year          = trim(n_year)          /*A57-0088*/  
                    wdetail.n_marketPrice   = trim(n_marketPrice) . /*A57-0088*/  
            END.
        END.
        ASSIGN 
        company  = ""
        branch   = ""
        vatcode  = ""
        codeid   = ""
        detail1  = ""
        detail2  = ""
        n_brand  = ""     /*A57-0017*/    
        n_model  = ""     /*A57-0017*/ 
        n_redbook     = ""      /*A57-0088*/ 
        n_year        = ""      /*A57-0088*/ 
        n_marketPrice = "" .    /*A57-0088*/ 
    END.
    /*comment by Kridtiya i. A57-0088....
    FOR EACH Insure   USE-INDEX Insure01 WHERE insure.compno    = fiCompno   NO-LOCK .
        IF  deci(Insure.InsNo) > idnumber  THEN ASSIGN idnumber =  deci(Insure.InsNo) .
    END.
    ASSIGN idnumber        = idnumber + 1. *//*kridtiya i. A57-00.......
    end....comment by Kridtiya i. A57-0088 */
    FOR EACH wdetail NO-LOCK.
        FIND LAST stat.Insure   USE-INDEX Insure01 WHERE 
            stat.insure.compno   = trim(fiCompno)  AND       /*company code */
            stat.Insure.FName    = wdetail.detail1 AND       /*dealer */
            stat.Insure.LName    = wdetail.detail2 NO-ERROR NO-WAIT.  /*showroom */
        IF NOT AVAIL stat.insure  THEN DO:
            IF wdetail.codeid = ""  THEN NEXT.
            ELSE DO:
                CREATE insure.
                ASSIGN 
                    n_countcomplete      = n_countcomplete + 1  /*A57-0017*/
                    stat.insure.compno   = wdetail.company
                    stat.Insure.Branch   = wdetail.branch 
                    stat.insure.vatcode  = wdetail.vatcode
                    stat.Insure.InsNo    = wdetail.codeid
                    stat.Insure.FName    = wdetail.detail1
                    stat.Insure.LName    = wdetail.detail2
                    stat.Insure.text1    = wdetail.brand           /*A57-0017*/  
                    stat.Insure.text2    = wdetail.model           /*A57-0017*/ 
                    stat.insure.Text3    = wdetail.n_redbook       /*A57-0088*/
                    stat.insure.Text4    = wdetail.n_year          /*A57-0088*/                                     
                    stat.insure.Text5    = wdetail.n_marketPrice   /*A57-0088*/
                    idnumber             = idnumber + 1 .
            END.
        END.
        ELSE DO: 
            ASSIGN 
                stat.insure.compno   = wdetail.company
                stat.Insure.Branch   = wdetail.branch 
                stat.insure.vatcode  = wdetail.vatcode
                stat.Insure.InsNo    = wdetail.codeid  
                /*stat.Insure.FName    = wdetail.detail1*/
                stat.Insure.text1    = wdetail.brand    /*A57-0017*/  
                stat.Insure.text2    = wdetail.model    /*A57-0017*/ 
                stat.Insure.LName    = wdetail.detail2   
                stat.insure.Text3    = wdetail.n_redbook       /*A57-0088*/
                stat.insure.Text4    = wdetail.n_year          /*A57-0088*/                                     
                stat.insure.Text5    = wdetail.n_marketPrice.  /*A57-0088*/
        END.
    END.
    MESSAGE "Import data Complete " SKIP 
            "จำนวนข้อมูลทั้งหมด : " n_countload     SKIP
            "จำนวนข้อมูลใหม่    : " n_countcomplete  VIEW-AS ALERT-BOX .
    RUN PDUpdateQ.
    APPLY "VALUE-CHANGED" TO brInsure IN FRAME frbrins.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_imp-6
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_imp-6 WGWTSEMO
ON CHOOSE OF bu_imp-6 IN FRAME frComp /* EXPORT */
DO:
    IF fi_output = "" THEN DO:
        message "Please insert filename output..."  view-as alert-box.
        APPLY "Entry" TO fi_output.
        RETURN NO-APPLY.
    END.
    If  substr(fi_output,length(fi_output) - 3,4) <>  ".csv"  Then
        fi_output  =  Trim(fi_output) + ".csv"  .
    OUTPUT  TO VALUE(fi_output).
    EXPORT DELIMITER "|"
        "company      "                                                 
        "branch       "               
        "vatcode      "                                    
        "codeid       "                                                         
        "detail1      "                                           
        "detail2      " 
        "Brand"        /*A57-0017*/
        "Model"        /*A57-0017*/
        "Redbook"      /*a57-0088*/
        "Year"         /*a57-0088*/
        "MarketPrice"  /*a57-0088*/
        SKIP. 
    FOR EACH  stat.insure USE-INDEX Insure03  WHERE 
        stat.insure.compno  = fiCompno        NO-LOCK.
        EXPORT DELIMITER "|"  
           stat.insure.compno 
           stat.Insure.Branch 
           stat.insure.vatcode
           stat.Insure.InsNo  
           stat.Insure.FName  
           stat.Insure.LName
           stat.Insure.text1     /*A57-0017*/ 
           stat.Insure.text2     /*A57-0017*/ 
           stat.Insure.text3     /*A57-0088*/ 
           stat.Insure.text4     /*A57-0088*/ 
           stat.Insure.text5.    /*A57-0088*/
    END.
    OUTPUT  CLOSE.
    message "Export File  Complete"  view-as alert-box.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_link-3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_link-3 WGWTSEMO
ON CHOOSE OF bu_link-3 IN FRAME frComp /* ..... */
DO:
    DEFINE VARIABLE cvData        AS CHARACTER NO-UNDO.
    DEFINE VARIABLE OKpressed AS LOGICAL INITIAL TRUE.
    DEF VAR no_add AS CHAR FORMAT "x(8)" . 
    SYSTEM-DIALOG GET-FILE cvData
        TITLE      "Choose Data File to Import ..."
        FILTERS    "Text Files (*.txt)" "*.csv"
                            
        MUST-EXIST
        USE-FILENAME
        UPDATE OKpressed.
    IF OKpressed = TRUE THEN DO:
       ASSIGN
            fi_filename  = cvData.

         DISP fi_filename   WITH FRAME frcomp.
         
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_schr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_schr WGWTSEMO
ON CHOOSE OF bu_schr IN FRAME frComp /* search */
DO:
    IF fisearch = "" THEN DO:
        MESSAGE "กรุณาคีย์ข้อมูลที่ต้องการค้น ..." VIEW-AS ALERT-BOX .  
        APPLY "VALUE-CHANGED" TO brInsure IN FRAME frbrins.
        APPLY "Entry" TO fisearch.
        RETURN NO-APPLY.
    END.
    OPEN QUERY brInsure  FOR EACH stat.Insure USE-INDEX Insure01 NO-LOCK
        WHERE stat.insure.CompNo = gComp AND 
        index(stat.Insure.FName,TRIM(fisearch)) <> 0 
        BY stat.Insure.InsNo .
        IF NOT AVAIL stat.Insure THEN DO: 
            MESSAGE "ไม่พบข้อมูลที่ต้องการค้น ..." VIEW-AS ALERT-BOX .  
            /*APPLY "Entry" TO fisearch. 
            RETURN NO-APPLY.*/
            RUN PdUpdateQ IN THIS-PROCEDURE.
        END.
        ELSE RUN pdDispIns.

    /*FIND LAST Insure USE-INDEX Insure01 
        WHERE Insure.CompNo = gComp AND
        Insure.FName    = TRIM(fisearch)  NO-LOCK NO-ERROR.
    IF AVAIL insure THEN DO:
        REPOSITION brInsure TO ROWID ROWID (Insure).
        APPLY "VALUE-CHANGED" TO brInsure IN FRAME frbrins.
    END.
    ELSE DO:
        MESSAGE "ไม่พบข้อมูลที่ต้องการค้น ..." VIEW-AS ALERT-BOX .  
        APPLY "Entry" TO fisearch.
        RETURN NO-APPLY.
    END.*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frInsure
&Scoped-define SELF-NAME fibrand
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fibrand WGWTSEMO
ON LEAVE OF fibrand IN FRAME frInsure
DO:
    fibrand = INPUT fibrand.
    DISP fibrand  WITH FRAM frinsure.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frComp
&Scoped-define SELF-NAME fiCompno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiCompno WGWTSEMO
ON LEAVE OF fiCompno IN FRAME frComp
DO:
  fiCompNo = INPUT fiCompNo.
  DISP fiCompNo WITH FRAM frcomp.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frInsure
&Scoped-define SELF-NAME fiInComp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiInComp WGWTSEMO
ON LEAVE OF fiInComp IN FRAME frInsure
DO:
   fiInComp  = INPUT fiInComp.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiInmarketprice
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiInmarketprice WGWTSEMO
ON LEAVE OF fiInmarketprice IN FRAME frInsure
DO:
    fiInmarketprice = INPUT fiInmarketprice.
    DISP fiInmarketprice  WITH FRAME frinsure.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiInredbook
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiInredbook WGWTSEMO
ON LEAVE OF fiInredbook IN FRAME frInsure
DO:
    fiInredbook = INPUT fiInredbook.
    DISP fiInredbook WITH FRAME frinsure.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiinyear
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiinyear WGWTSEMO
ON LEAVE OF fiinyear IN FRAME frInsure
DO:
    fiinyear = INPUT fiinyear.
    DISP fiinyear WITH FRAME frinsure.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fimodel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fimodel WGWTSEMO
ON LEAVE OF fimodel IN FRAME frInsure
DO:
    fimodel = INPUT fimodel.
    DISP fimodel WITH FRAM frinsure.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frComp
&Scoped-define SELF-NAME fisearch
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fisearch WGWTSEMO
ON LEAVE OF fisearch IN FRAME frComp
DO:
    fisearch = INPUT fisearch .
    DISP fisearch WITH FRAM ficomp.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frInsure
&Scoped-define SELF-NAME fivatcode
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fivatcode WGWTSEMO
ON LEAVE OF fivatcode IN FRAME frInsure
DO:
   fivatcode  = INPUT fivatcode.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frComp
&Scoped-define SELF-NAME fi_filename
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_filename WGWTSEMO
ON LEAVE OF fi_filename IN FRAME frComp
DO:
   fi_filename = INPUT fi_filename .
  DISP fi_filename WITH FRAM frcomp.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_output
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_output WGWTSEMO
ON LEAVE OF fi_output IN FRAME frComp
DO:
    fi_output = INPUT fi_output .
    DISP fi_output WITH FRAM frcomp.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frbrIns
&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK WGWTSEMO 


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
  RUN WUT\WUTDICEN (WGWTSEMO:HANDLE).
  SESSION:DATA-ENTRY-RETURN = Yes.
  ASSIGN 
      fiCompNo  = "Model_NIS"
      fiUser    = ""
      fiUser    = n_user
      fiFdate   = ?
      fiFdate   = TODAY .
  DISP fiuser fiFdate        WITH FRAME fruser.
  DISP fiCompNo  WITH FRAME frComp.
  FIND FIRST stat.Company USE-INDEX Company01 WHERE  stat.Company.compno = trim(fiCompNo) NO-LOCK NO-ERROR NO-WAIT.
  IF AVAIL stat.Company THEN DO:
      RUN pdDispComp.
      ASSIGN gComp = stat.Company.Compno.
  END.
  ELSE DO:
      DISP "" @ fiCompNo
           /*"" @ fiBranch
           "" @ fiABNAme
           "" @ fiName  
           "" @ finame2 
           "" @ fiAddr1 
           "" @ fiAddr2 
           "" @ fiAddr3 
           "" @ fiAddr4 
           "" @ fiTelno*/ WITH FRAME frComp.
  END.
  IF CAN-FIND (FIRST stat.Insure WHERE stat.Insure.compno = gComp )  THEN DO:
     RUN PdUpdateQ IN THIS-PROCEDURE.
     APPLY "VALUE-CHANGED" TO brInsure.
  END.
  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI WGWTSEMO  _DEFAULT-DISABLE
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
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(WGWTSEMO)
  THEN DELETE WIDGET WGWTSEMO.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI WGWTSEMO  _DEFAULT-ENABLE
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
  DISPLAY fiCompno fi_filename fi_output fiFDate fiUser fisearch 
      WITH FRAME frComp IN WINDOW WGWTSEMO.
  ENABLE RECT-455 fiCompno buok fi_filename bu_link-3 bu_imp-5 fi_output 
         bu_imp-6 fiFDate fiUser fisearch bu_schr 
      WITH FRAME frComp IN WINDOW WGWTSEMO.
  {&OPEN-BROWSERS-IN-QUERY-frComp}
  VIEW FRAME frmain IN WINDOW WGWTSEMO.
  {&OPEN-BROWSERS-IN-QUERY-frmain}
  DISPLAY fiInComp fiInBranch fivatcode fiFName fiLName fibrand fimodel 
          fiInredbook fiinyear fiInmarketprice fiInAddr3 fiInAddr4 fiInAddr1 
          fiInAddr2 fiInTelNo 
      WITH FRAME frInsure IN WINDOW WGWTSEMO.
  ENABLE fiInBranch fiInTelNo btnInOK btnFirst btnPrev btnNext btnLast btninadd 
         btnInUpdate btnInDelete btnInCancel btnReturn-2 RECT-20 RECT-83 
         RECT-454 RECT-21 RECT-85 
      WITH FRAME frInsure IN WINDOW WGWTSEMO.
  {&OPEN-BROWSERS-IN-QUERY-frInsure}
  ENABLE brInsure 
      WITH FRAME frbrIns IN WINDOW WGWTSEMO.
  {&OPEN-BROWSERS-IN-QUERY-frbrIns}
  VIEW WGWTSEMO.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdAddCom WGWTSEMO 
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDDisableComp WGWTSEMO 
PROCEDURE PDDisableComp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
  DISABLE 
    fiCompNo 
      /*fibranch fiAbName  fiName fiName2 fiAddr1 fiAddr2 fiAddr3 fiAddr4 fiTelNo */
    WITH FRAME frComp.
  /* kridtiya in .................
  DISABLE ALL WITH FRAME frinsure.*/
  /*DISABLE brinsure  WITH  FRAME frbrins.*/
  /*DISABLE    btnCompOK   btnCompReset   WITH FRAME frcomp.*/
  /*  DISABLE   btnCompdet WITH FRAME frCompdet.*/
  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDDispComp WGWTSEMO 
PROCEDURE PDDispComp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN
    fiCompNo = stat.Company.Compno
   /* fiBranch = Company.Branch
    fiABNAme = Company.ABName
    fiName   = Company.NAME
    finame2  = Company.Name2
    fiAddr1  = Company.Addr1
    fiAddr2  = Company.Addr2
    fiAddr3  = Company.Addr3
    fiAddr4  = Company.Addr4
    fiTelno  = Company.Telno*/    .
DISP fiCompNo
     /*fiBranch
     fiABNAme
     fiName  
     finame2 
     fiAddr1 
     fiAddr2 
     fiAddr3 
     fiAddr4 
     fiTelno*/   WITH FRAME frComp.
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
  ASSIGN gComp = stat.company.compno.
  RUN pdUpdateQ.
  DISP brinsure  WITH FRAME frbrins.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdDispIns WGWTSEMO 
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
    insure.Text1     @ fibrand          /*A57-0017*/ 
    insure.Text2     @ fimodel          /*A57-0017*/ 
    insure.Text3     @ fiInredbook      /*A57-0088*/
    insure.Text4     @ fiinyear         /*A57-0088*/                                     
    insure.Text5     @ fiInmarketprice  /*A57-0088*/
    WITH FRAME frinsure.
DISP Insure.FDate     @ fiFDate WITH FRAME fruser.
/*raSex = IF Insure.Sex = "M" THEN 1 ELSE IF Insure.Sex = "F" THEN 2 ELSE 3 .     
DISP raSex  WITH FRAME {&FRAME-NAME}.*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pddisplogin WGWTSEMO 
PROCEDURE pddisplogin :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN
    fiCompNo    = Company.CompNo
    /*fiABName    = Company.ABName
    fibranch    = Company.Branch
    fiName      = Company.Name
    fiName2     = Company.Name2
    fiAddr1     = Company.Addr1
    fiAddr2     = Company.Addr2
    fiAddr3     = Company.Addr3
    fiAddr4     = Company.Addr4
    fiTelNo     = Company.TelNo
    fiuser      = Company.PowerName*/          .
DISP fiCompNo 
     /*fiAbName fibranch fiName fiName2
     fiAddr1 fiAddr2 fiAddr3 fiAddr4 fiTelNo*/     WITH FRAME frComp.
FIND FIRST stat.insure USE-INDEX insure01 WHERE
    stat.insure.compno = trim(ficompno)  NO-WAIT NO-ERROR.
IF AVAIL insure THEN DO:
    ASSIGN
        fiincomp     = insure.insNo
        fiinbranch   = insure.Branch
        fifname      = insure.fname
        filname      = insure.lName
        fibrand      = insure.Text1   /*A57-0017*/ 
        fimodel      = insure.Text2   /*A57-0017*/ 
        fiinAddr1    = insure.Addr1  
        fiinAddr2    = insure.Addr2  
        fiinAddr3    = insure.Addr3  
        fiinAddr4    = insure.Addr4  
        fiinTelNo    = insure.telno
        fiInredbook     = insure.Text3  /*A57-0088*/ 
        fiinyear        = insure.Text4  /*A57-0088*/ 
        fiInmarketprice = insure.Text5  /*A57-0088*/
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
       fiinTelNo 
       fibrand   /*A57-0017*/ 
       fimodel   /*A57-0017*/ 
       fiInredbook  fiinyear  fiInmarketprice   /*A57-0088*/
       WITH FRAME frinsure.
DISP brInsure WITH FRAME frbrins.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdEnable WGWTSEMO 
PROCEDURE pdEnable :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ENABLE 
    fiInComp    fiInBranch  fivatcode   fiFName     fibrand     fimodel   /*A57-0017*/
    fiLName     fiInAddr1   fiInAddr2   fiInAddr3   fiInAddr4   fiInTelNo   btnInOK     btnInCancel 
    fiInredbook fiinyear    fiInmarketprice   /*A57-0088*/
    WITH FRAME  frinsure.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdenablecomp WGWTSEMO 
PROCEDURE pdenablecomp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ENABLE 
    fiCompNo 
    /*fibranch fiAbName fiName fiName2 fiAddr1 fiAddr2 fiAddr3 fiAddr4 fiTelNo */
    WITH FRAME frComp.
    ENABLE ALL WITH  FRAME fiinsure.
    /*ENABLE   btnCompOK btnCompReset   WITH FRAME frcomp.*/
    
    ENABLE   brinsure   WITH FRAME frbrins.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDInitData WGWTSEMO 
PROCEDURE PDInitData :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN 
    FRAME frComp fiCompNo fiCompNo = ""
    /*FRAME frComp fiABName fiAbName = ""
    FRAME frComp fiName   fiName   = ""
    FRAME frComp fiName2 fiName2 = ""
    FRAME frComp fiAddr1  fiAddr1  = ""
    FRAME frComp fiAddr2  fiAddr2  = ""
    FRAME frComp fiAddr3  fiAddr3  = ""
    FRAME frComp fiAddr4  fiAddr4  = ""
    FRAME frComp fiTelNo fiTelNo = ""*/

    
   /* btnCompAdd:Sensitive   IN FRAME frcomp = Yes
    btnCompUpd:Sensitive   IN FRAME frcomp = Yes
    btnCompDel:Sensitive   IN FRAME frcomp = Yes

    btnCompOK:Sensitive    IN FRAME frcomp = No
    btnCompReset:Sensitive IN FRAME frcomp = No    
        
    btnCompFirst:Sensitive IN FRAME frcomp = Yes
    btnCompPrev:Sensitive  IN FRAME frcomp = Yes
    btnCompNext:Sensitive  IN FRAME frcomp = Yes
    btnCompLast:Sensitive  IN FRAME frcomp = Yes*/
    cUpdate = "".

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdUpdateQ WGWTSEMO 
PROCEDURE pdUpdateQ :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
OPEN QUERY brInsure  FOR EACH stat.Insure USE-INDEX Insure03 NO-LOCK
            WHERE stat.Insure.CompNo = gComp
    BY Insure.InsNo .
    RUN pdDispIns.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE ProcDisable WGWTSEMO 
PROCEDURE ProcDisable :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DISABLE 
    fiincomp   fiinBranch fivatcode fiFName  fiLName 
    fiinAddr1  fiinAddr2  fiinAddr3 fibrand  fimodel   /*A57-0017*/
    fiinAddr4  fiinTelNo  fiInredbook  fiinyear  fiInmarketprice   /*A57-0088*/
  /*fiInsNo*/
  WITH FRAME frinsure.  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE ProcUpdateInsure WGWTSEMO 
PROCEDURE ProcUpdateInsure :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF INPUT PARAMETER cmode AS CHAR.
DEF BUFFER bIns   FOR Insure.
DEF VAR logAns    AS LOGI INIT No.  
DEF VAR rIns      AS ROWID.
DEF VAR vInsNo    AS INTE INIT 0.
DEF VAR vInsC     AS CHAR FORMAT "X" INIT "W".
DEF VAR vInsFirst AS CHAR.   /* multi  company*/
  /* vComp  = fiInbranch.*/  
ASSIGN pComp = trim(fiCompno).
FIND FIRST stat.Company USE-INDEX Company01 WHERE stat.Company.CompNo =   pComp  .
DO:  vInsFirst = stat.Company.InsNoPrf. END. 
ASSIGN
    rIns   = ROWID (Insure)
    logAns = No.
IF cmode = "ADD" THEN DO:
        MESSAGE "เพิ่มข้อมูลรารายการนี้" UPDATE logAns 
            VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO
            TITLE "เพิ่มข้อมูลรายการนี้".
        IF logAns THEN DO:
            FIND LAST stat.bIns   USE-INDEX Insure01 WHERE stat.bIns.CompNo = pComp NO-LOCK NO-ERROR.
            CREATE stat.Insure.
        END.
END.   /* ADD */
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
    FRAME frInsure  fibrand           /*A57-0017*/
    FRAME frInsure  fimodel           /*A57-0017*/
    FRAME frInsure  fiInAddr1         
    FRAME frInsure  fiInAddr2         
    FRAME frInsure  fiInAddr3         
    FRAME frInsure  fiInAddr4         
    FRAME frInsure  fiInTelNo         
    FRAME frInsure fiInredbook                 /*A57-0088*/
    FRAME frInsure fiinyear                    /*A57-0088*/                                     
    FRAME frInsure fiInmarketprice             /*A57-0088*/
    insure.compno  = ficompno         
    Insure.Branch  = fiInBranch       
    insure.vatcode = fivatcode        
    Insure.InsNo   = fiInComp         
    Insure.FName   = fiFName          
    Insure.LName   = fiLName          
    insure.Text1   = fibrand          /*A57-0017*/
    insure.Text2   = fimodel          /*A57-0017*/
    Insure.Addr1   = fiInAddr1        
    Insure.Addr2   = fiInAddr2        
    Insure.Addr3   = fiInAddr3        
    Insure.Addr4   = fiInAddr4        
    Insure.TelNo   = fiInTelNo        
    insure.Text3   = fiInredbook      /*A57-0088*/
    insure.Text4   = fiinyear         /*A57-0088*/                                     
    insure.Text5   = fiInmarketprice  /*A57-0088*/
    btnFirst:Sensitive    IN FRAM frinsure = Yes
    btnPrev:Sensitive     IN FRAM frinsure = Yes
    btnNext:Sensitive     IN FRAM frinsure = Yes
    btnLast:Sensitive     IN FRAM frinsure = Yes
    btnInAdd:Sensitive    IN FRAM frinsure = Yes
    btnInUpdate:Sensitive IN FRAM frinsure = Yes
    btnInDelete:Sensitive IN FRAM frinsure = Yes
    btnInOK:Sensitive     IN FRAM frinsure = No
    btnInCancel:Sensitive IN FRAM frinsure = NO
    brInsure:Sensitive    IN FRAM frbrins  = Yes.   
    RUN PDUpdateQ.
    APPLY "VALUE-CHANGED" TO brInsure IN FRAME frbrins.
    /*RUN ProcDisable IN THIS-PROCEDURE.*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

