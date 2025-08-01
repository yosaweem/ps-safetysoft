&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          sicfn            PROGRESS
*/
&Scoped-define WINDOW-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS C-Win 
CREATE WIDGET-POOL.
/*************************  Definitions  *************************/
/*--Modify By A54-0055 Sayamol N.  21/02/2011
������äӹǳ�¡�������Ңͧ Commission, Bal O/S,
 Cheque Returned, Suspense, Net. A/R, Net. OTHER  ��ҧ���� 
 ---*/
/*--- Modify By A54-0119  Sayamol N. 03/05/2011 ---*/
/*--- ����������� �������Ҥ�ҧ���� ��        ---*/
/*--- 91-120, 121-150, 151-180, 181-210, 211-240,---*/ 
/*--- 241-270, 271-300, 301-330, 331-365, over 365 ---*/


{wac\wacrloic.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of first Frame and/or Browse and/or first Query                 */
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fuMaxDay C-Win 
FUNCTION fuMaxDay RETURNS INTEGER
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
     FILENAME "wimage/wallpap4.bmp":U CONVERT-3D-COLORS
     SIZE 132.5 BY 24.

DEFINE IMAGE IMAGE-22
     FILENAME "wimage/bgc01.bmp":U CONVERT-3D-COLORS
     SIZE 126 BY 23.76.

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
     SIZE 18.5 BY 4.71
     BGCOLOR 19 .

DEFINE VARIABLE fiFile-Name AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 27.5 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE rsOutput AS INTEGER 
     VIEW-AS RADIO-SET VERTICAL
     RADIO-BUTTONS 
          "Item 1", 1
     SIZE 12.5 BY 1
     BGCOLOR 19 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-5
     EDGE-PIXELS 4 GRAPHIC-EDGE  
     SIZE 47.5 BY 4.19
     BGCOLOR 8 .

DEFINE BUTTON buAcno1 
     LABEL "..." 
     SIZE 3 BY .95 TOOLTIP "���� Producer"
     FONT 6.

DEFINE BUTTON buAcno2 
     LABEL "..." 
     SIZE 3 BY .95 TOOLTIP "���� Producer"
     FONT 6.

DEFINE BUTTON buBranch 
     LABEL "..." 
     SIZE 3 BY .95 TOOLTIP "�����Ң�"
     FONT 6.

DEFINE BUTTON buBranch2 
     LABEL "..." 
     SIZE 3 BY .95 TOOLTIP "�����Ң�"
     FONT 6.

DEFINE BUTTON buPoltypFr 
     LABEL "..." 
     SIZE 3 BY .95 TOOLTIP "��������������"
     FONT 6.

DEFINE BUTTON buPoltypTo 
     LABEL "..." 
     SIZE 3 BY .95 TOOLTIP "��������������"
     FONT 6.

DEFINE VARIABLE coRptTyp AS CHARACTER FORMAT "X(256)":U 
     LABEL "Combo 1" 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEMS "Item 1" 
     DROP-DOWN-LIST
     SIZE 22 BY 1
     BGCOLOR 15 FONT 2 NO-UNDO.

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
     BGCOLOR 90 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fiasdatAging AS DATE FORMAT "99/99/9999":U 
     LABEL "Fill 1" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 1 NO-UNDO.

DEFINE VARIABLE fibdes AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 25 BY .95
     BGCOLOR 19 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fibdes2 AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 25 BY .95
     BGCOLOR 19 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fiBranch AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 5 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fiBranch2 AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 5 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fiInclude AS CHARACTER FORMAT "X(256)":U 
     LABEL "Fill 1" 
      VIEW-AS TEXT 
     SIZE 19 BY 1
     BGCOLOR 80 FGCOLOR 1 FONT 1 NO-UNDO.

DEFINE VARIABLE finame1 AS CHARACTER FORMAT "X(256)":U 
     LABEL "" 
      VIEW-AS TEXT 
     SIZE 45 BY .95
     BGCOLOR 19 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE finame2 AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 45 BY .95
     BGCOLOR 19 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fiPoldesFr AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 40 BY .95
     BGCOLOR 19 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fiPoldesTo AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 40 BY .95
     BGCOLOR 19 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fiPolTypFr AS CHARACTER FORMAT "X(4)":U 
     VIEW-AS FILL-IN 
     SIZE 5 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fiPolTypTo AS CHARACTER FORMAT "X(4)":U 
     VIEW-AS FILL-IN 
     SIZE 5 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fiProcess AS CHARACTER FORMAT "X(256)":U 
     LABEL "fiProcess" 
      VIEW-AS TEXT 
     SIZE 34 BY .95
     BGCOLOR 8 FGCOLOR 0 FONT 1 NO-UNDO.

DEFINE VARIABLE fiProcessDate AS DATE FORMAT "99/99/9999":U 
      VIEW-AS TEXT 
     SIZE 11.5 BY 1
     BGCOLOR 90 FGCOLOR 1 FONT 1 NO-UNDO.

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
     BGCOLOR 19 FONT 6 NO-UNDO.

DEFINE VARIABLE raReport AS INTEGER 
     VIEW-AS RADIO-SET VERTICAL
     RADIO-BUTTONS 
          "Item1", 1,
"Item2", 2
     SIZE 28.5 BY 1.86
     BGCOLOR 19 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE rstype AS INTEGER 
     VIEW-AS RADIO-SET VERTICAL
     RADIO-BUTTONS 
          "MOT", 1,
"NON", 2,
"ALL", 3
     SIZE 10.5 BY 3.33
     BGCOLOR 19 FONT 6 NO-UNDO.

DEFINE RECTANGLE re1
     EDGE-PIXELS 4 GRAPHIC-EDGE  
     SIZE 118.5 BY 16.19
     BGCOLOR 19 .

DEFINE RECTANGLE re11
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 77.5 BY 7.76
     BGCOLOR 8 FGCOLOR 0 .

DEFINE RECTANGLE re12
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 38 BY 7.76
     BGCOLOR 8 .

DEFINE RECTANGLE re13
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 77.5 BY 7.57
     BGCOLOR 8 .

DEFINE RECTANGLE re14
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 38 BY 7.57
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-302
     EDGE-PIXELS 0  
     SIZE 12 BY .95
     BGCOLOR 80 .

DEFINE VARIABLE to_type AS LOGICAL INITIAL no 
     LABEL "" 
     VIEW-AS TOGGLE-BOX
     SIZE 3.5 BY .95 NO-UNDO.

DEFINE VARIABLE fiTrndatFr AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 90 FGCOLOR 1 FONT 1 NO-UNDO.

DEFINE VARIABLE fiTrndatTo AS DATE FORMAT "99/99/9999":U 
     LABEL "Fill 2" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 90 FGCOLOR 1 FONT 1 NO-UNDO.

DEFINE VARIABLE raAllbal AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "All", 1,
"Partial", 2
     SIZE 25.5 BY 1.05
     BGCOLOR 80 FGCOLOR 133 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-303
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 42 BY 3.91
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-305
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 40 BY 3.38
     BGCOLOR 8 .

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
    WITH NO-ROW-MARKERS SEPARATORS SIZE 74.5 BY 3.91
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
     IMAGE-22 AT ROW 1 COL 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         NO-LABELS SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 5 ROW 1
         SIZE 126 BY 23.74
         BGCOLOR 20 .

DEFINE FRAME frST
     to_type AT ROW 2.67 COL 60.5
     rstype AT ROW 3.86 COL 67.5 NO-LABEL
     fiBranch AT ROW 2.81 COL 15 COLON-ALIGNED NO-LABEL
     fiBranch2 AT ROW 3.86 COL 15 COLON-ALIGNED NO-LABEL
     fiPolTypFr AT ROW 5.19 COL 15 COLON-ALIGNED NO-LABEL
     fiPolTypTo AT ROW 6.24 COL 15 COLON-ALIGNED NO-LABEL
     fiacno1 AT ROW 7.52 COL 15 COLON-ALIGNED NO-LABEL
     fiacno2 AT ROW 8.52 COL 15 COLON-ALIGNED NO-LABEL
     fiasdatAging AT ROW 12.24 COL 17 COLON-ALIGNED
     buBranch AT ROW 2.81 COL 22
     buBranch2 AT ROW 3.86 COL 22
     buPoltypFr AT ROW 5.19 COL 22
     buPoltypTo AT ROW 6.24 COL 22
     buAcno2 AT ROW 8.52 COL 29
     coRptTyp AT ROW 4.14 COL 88 COLON-ALIGNED
     raReport AT ROW 5.81 COL 86 NO-LABEL
     raDetSum AT ROW 8.05 COL 83 NO-LABEL
     brAcproc_fil AT ROW 13.52 COL 3.5
     fiTyp1 AT ROW 12.48 COL 86 COLON-ALIGNED NO-LABEL
     fiTyp2 AT ROW 12.48 COL 91 COLON-ALIGNED NO-LABEL
     fiTyp3 AT ROW 12.48 COL 96 COLON-ALIGNED NO-LABEL
     fiTyp4 AT ROW 12.48 COL 101 COLON-ALIGNED NO-LABEL
     fiTyp5 AT ROW 12.48 COL 106 COLON-ALIGNED NO-LABEL
     fiTyp6 AT ROW 13.76 COL 86 COLON-ALIGNED NO-LABEL
     fiTyp7 AT ROW 13.76 COL 91 COLON-ALIGNED NO-LABEL
     fiTyp8 AT ROW 13.76 COL 96 COLON-ALIGNED NO-LABEL
     fiTyp9 AT ROW 13.76 COL 101 COLON-ALIGNED NO-LABEL
     fiTyp10 AT ROW 13.76 COL 106 COLON-ALIGNED NO-LABEL
     fiTyp11 AT ROW 15.1 COL 86 COLON-ALIGNED NO-LABEL
     fiTyp12 AT ROW 15.1 COL 91 COLON-ALIGNED NO-LABEL
     fiTyp13 AT ROW 15.1 COL 96 COLON-ALIGNED NO-LABEL
     fiTyp14 AT ROW 15.1 COL 101 COLON-ALIGNED NO-LABEL
     fiTyp15 AT ROW 15.1 COL 106 COLON-ALIGNED NO-LABEL
     buAcno1 AT ROW 7.52 COL 29
     fibdes AT ROW 2.81 COL 23.5 COLON-ALIGNED NO-LABEL
     fibdes2 AT ROW 3.86 COL 23.5 COLON-ALIGNED NO-LABEL
     fiPoldesFr AT ROW 5.19 COL 23.5 COLON-ALIGNED NO-LABEL
     fiPoldesTo AT ROW 6.24 COL 23.5 COLON-ALIGNED NO-LABEL
     finame1 AT ROW 7.52 COL 30.5 COLON-ALIGNED
     finame2 AT ROW 8.52 COL 30.5 COLON-ALIGNED NO-LABEL
     fiInclude AT ROW 10.67 COL 97 COLON-ALIGNED
     fiAsdat AT ROW 10.91 COL 17 COLON-ALIGNED
     fiProcessDate AT ROW 10.91 COL 49 COLON-ALIGNED NO-LABEL
     fiProcess AT ROW 16.38 COL 82.83
     "By" VIEW-AS TEXT
          SIZE 3.5 BY 1 AT ROW 4.14 COL 86
          BGCOLOR 8 FONT 6
     "Ageing = 31/01/YYYY, Statement = Process Date" VIEW-AS TEXT
          SIZE 44 BY 1 TOOLTIP "Ageing = �ѹ����ѹ�ش���¢ͧ��͹/ Statement = �ѹ��� � �ѹ��� Process data" AT ROW 12.24 COL 34
          BGCOLOR 19 FGCOLOR 1 
     "Branch From":30 VIEW-AS TEXT
          SIZE 12 BY .95 TOOLTIP "������Ң�" AT ROW 2.81 COL 4
          BGCOLOR 8 FGCOLOR 0 
     "To":20 VIEW-AS TEXT
          SIZE 12 BY .95 TOOLTIP "���ʵ��᷹�֧" AT ROW 8.52 COL 4
          BGCOLOR 8 FGCOLOR 0 
     "   :Select Type" VIEW-AS TEXT
          SIZE 13 BY .95 AT ROW 2.67 COL 65
          BGCOLOR 80 FGCOLOR 133 FONT 4
     " Asdate for Cal.":30 VIEW-AS TEXT
          SIZE 14.5 BY 1 AT ROW 12.24 COL 4.5
          BGCOLOR 80 FGCOLOR 133 FONT 4
     "Pol. Type From":50 VIEW-AS TEXT
          SIZE 12 BY .95 TOOLTIP "������Ң�" AT ROW 5.19 COL 4
          BGCOLOR 8 FGCOLOR 0 
     " Include Type All":50 VIEW-AS TEXT
          SIZE 17 BY 1 AT ROW 10.67 COL 82
          BGCOLOR 80 FGCOLOR 133 FONT 4
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         NO-LABELS SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 4 ROW 1.3
         SIZE 120 BY 17.44
         BGCOLOR 80 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME frST
     " Process Date":30 VIEW-AS TEXT
          SIZE 16 BY 1 TOOLTIP "�ѹ����͡��§ҹ" AT ROW 10.91 COL 34.5
          BGCOLOR 80 FGCOLOR 133 FONT 4
     "To":10 VIEW-AS TEXT
          SIZE 12 BY .95 TOOLTIP "�֧�Ң�" AT ROW 3.86 COL 4
          BGCOLOR 8 FGCOLOR 0 
     " Asdate Process":30 VIEW-AS TEXT
          SIZE 14.5 BY .95 AT ROW 10.91 COL 4.5
          BGCOLOR 80 FGCOLOR 133 FONT 4
     "Producer From":100 VIEW-AS TEXT
          SIZE 12 BY .95 TOOLTIP "Account No. From" AT ROW 7.52 COL 4
          BGCOLOR 8 FGCOLOR 0 
     "                                                    Ageing Count Day for OIC":210 VIEW-AS TEXT
          SIZE 107.5 BY .95 AT ROW 1 COL 13
          BGCOLOR 80 FGCOLOR 133 FONT 6
     "To":10 VIEW-AS TEXT
          SIZE 12 BY .95 TOOLTIP "�֧�Ң�" AT ROW 6.24 COL 4
          BGCOLOR 8 FGCOLOR 0 
     " Type Of Reports":50 VIEW-AS TEXT
          SIZE 36.5 BY 1 AT ROW 2.57 COL 82
          BGCOLOR 80 FGCOLOR 133 FONT 4
     re1 AT ROW 2.05 COL 1.5
     re11 AT ROW 2.29 COL 2.5
     re12 AT ROW 2.29 COL 81
     re13 AT ROW 10.38 COL 2.5
     re14 AT ROW 10.38 COL 81
     RECT-302 AT ROW 1 COL 1
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         NO-LABELS SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 4 ROW 1.3
         SIZE 120 BY 17.44
         BGCOLOR 80 .

DEFINE FRAME frOK
     Btn_OK AT ROW 1.71 COL 5.5
     Btn_Cancel AT ROW 3.62 COL 5.5
     RECT2 AT ROW 1.24 COL 2.5
    WITH DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 102 ROW 19
         SIZE 22 BY 5.22
         BGCOLOR 80 .

DEFINE FRAME frOutput
     rsOutput AT ROW 3.33 COL 5.5 NO-LABEL
     fiFile-Name AT ROW 3.33 COL 17.17 COLON-ALIGNED NO-LABEL
     " Output To":40 VIEW-AS TEXT
          SIZE 48.67 BY .95 TOOLTIP "����ʴ���" AT ROW 1 COL 1
          BGCOLOR 80 FGCOLOR 133 FONT 6
     RECT-5 AT ROW 2.05 COL 1.5
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 4 ROW 19
         SIZE 49 BY 5.48
         BGCOLOR 80 .

DEFINE FRAME frTrndat
     raAllbal AT ROW 1 COL 19 NO-LABEL
     fiTrndatFr AT ROW 2.81 COL 18 COLON-ALIGNED NO-LABEL
     fiTrndatTo AT ROW 4.14 COL 18 COLON-ALIGNED
     "            To" VIEW-AS TEXT
          SIZE 11.5 BY 1 AT ROW 4.14 COL 8
          BGCOLOR 80 FGCOLOR 133 FONT 4
     " Bal. Filter    ==>":20 VIEW-AS TEXT
          SIZE 18 BY 1.05 AT ROW 1 COL 1
          BGCOLOR 80 FGCOLOR 133 FONT 6
     "Trndat From" VIEW-AS TEXT
          SIZE 11.5 BY 1 AT ROW 2.81 COL 8
          BGCOLOR 80 FGCOLOR 133 FONT 4
     RECT-303 AT ROW 2.05 COL 2
     RECT-305 AT ROW 2.29 COL 3
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         NO-LABELS SIDE-LABELS THREE-D 
         AT COL 54.5 ROW 19
         SIZE 44 BY 5.39
         BGCOLOR 80 .


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
         TITLE              = "Wacrloic - Ageing Count Day for OIC"
         HEIGHT             = 23.62
         WIDTH              = 131.67
         MAX-HEIGHT         = 31.33
         MAX-WIDTH          = 170.67
         VIRTUAL-HEIGHT     = 31.33
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
       FRAME frOK:FRAME = FRAME frMain:HANDLE
       FRAME frOutput:FRAME = FRAME frMain:HANDLE
       FRAME frST:FRAME = FRAME frMain:HANDLE
       FRAME frTrndat:FRAME = FRAME frMain:HANDLE.

/* SETTINGS FOR FRAME DEFAULT-FRAME
                                                                        */
/* SETTINGS FOR FRAME frMain
                                                                        */
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

/* SETTINGS FOR FRAME frTrndat
   UNDERLINE                                                            */
/* SETTINGS FOR FILL-IN fiTrndatTo IN FRAME frTrndat
   LABEL "Fill 2:"                                                      */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE brAcproc_fil
/* Query rebuild information for BROWSE brAcproc_fil
     _TblList          = "sicfn.acproc_fil"
     _FldNameList[1]   > sicfn.acproc_fil.asdat
"acproc_fil.asdat" ? ? "date" ? ? 1 ? ? 1 no ? no no ? yes no no "U" "" ""
     _FldNameList[2]   > sicfn.acproc_fil.type
"acproc_fil.type" "Ty" ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[3]   > "_<CALC>"
"IF (acproc_fil.type = ""01"") THEN (""Monthly"") ELSE (""Daily"")" "Detail" ? ? ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[4]   > sicfn.acproc_fil.entdat
"acproc_fil.entdat" "Process Date" ? "date" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[5]   > sicfn.acproc_fil.enttim
"acproc_fil.enttim" "Time" ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[6]   > "_<CALC>"
"SUBSTRING (acproc_fil.enttim,10,3)" "Sta" "X(1)" ? ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[7]   > sicfn.acproc_fil.trndatfr
"acproc_fil.trndatfr" "TranDate Fr" ? "date" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[8]   > sicfn.acproc_fil.trndatto
"acproc_fil.trndatto" "TranDate To" ? "date" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[9]   > sicfn.acproc_fil.typdesc
"acproc_fil.typdesc" ? "X(60)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _Query            is NOT OPENED
*/  /* BROWSE brAcproc_fil */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Wacrloic - Ageing Count Day for OIC */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Wacrloic - Ageing Count Day for OIC */
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
ON RETURN OF brAcproc_fil IN FRAME frST
DO:
    APPLY "VALUE-CHANGED" TO brAcproc_fil.
    APPLY "ENTRY" TO fiasdatAging IN FRAME {&FRAME-NAME}.
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brAcproc_fil C-Win
ON VALUE-CHANGED OF brAcproc_fil IN FRAME frST
DO:

    IF NOT CAN-FIND(FIRST acproc_fil WHERE (acproc_fil.type = "01" OR acproc_fil.type = "05" )) THEN DO:
        DO WITH FRAME frST:
            ASSIGN
                fiasdat = ?
                fiProcessdate = ?
                n_trndatfr = ?
                n_trndatto = ?
                n_asdat    = fiasdat
                n_processdate  = ?

                n_trndatfrold = ?
                n_trndattoold = ?
                .
            
            DISP fiasdat fiProcessdate.
        END. /**/

        DO WITH FRAME frTrndat:
            ASSIGN
                fitrndatFr = ?
                fitrndatTo = ?
                .

            DISP fitrndatFr   fitrndatTo.
        END.
    END.
    ELSE DO:
        FIND CURRENT acproc_fil NO-LOCK.
        DO WITH FRAME frST:

            ASSIGN
                fiasdat         = acproc_fil.asdat
                fiProcessdate   = acproc_fil.entdat
                n_trndatfr      = acproc_fil.trndatfr
                n_trndatto      = acproc_fil.trndatto
                n_asdat         = fiasdat
                n_processdate   = acproc_fil.entdat

                n_trndatfrold   = acproc_fil.trndatfr
                n_trndattoold   = acproc_fil.trndatto
                .
            DISP fiasdat fiProcessdate .
        END. /**/

        DO WITH FRAME frTrndat:
            ASSIGN
                fitrndatFr = n_trndatfr
                fitrndatTo = n_trndatTo

                .

            DISP fitrndatFr   fitrndatTo.
        END.



    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frOK
&Scoped-define SELF-NAME Btn_Cancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_Cancel C-Win
ON CHOOSE OF Btn_Cancel IN FRAME frOK /* Cancel */
DO:
    RUN wac\wacdisfn.
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
DEF VAR vLastTime  AS CHAR INIT "".
DEF VAR nv_filter1 AS CHAR INIT "".
DEF VAR nv_filter2 AS CHAR INIT "".

DEF VAR vAcno AS CHAR INIT "".

   DO WITH FRAME {&FRAME-NAME} :
    ASSIGN  
        FRAME frST fibranch fibranch
        FRAME frST fibranch2 fibranch2
        FRAME frST fiacno1 fiacno1
        FRAME frST fiacno2 fiacno2
        FRAME frST fipoltypFr  fipoltypFr
        FRAME frST fipoltypTo fipoltypTo
        FRAME frST coRptTyp coRptTyp
        FRAME frST raReport raReport

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
/*         FRAME frST toprnIns  toPrnIns */
        
        FRAME frOutput rsOutput rsOutput
        FRAME frOutput fiFile-Name fiFile-Name
        /*A47-02364*/
        FRAME frTrndat raAllbal raAllbal
        FRAME frTrndat fitrndatfr fitrndatTo
        FRAME frtrndat fitrndatto fitrndatTo

        /*A47-02364*/

        n_branch  = fiBranch
        n_branch2 = fiBranch2
        n_frac    = fiAcno1
        n_toac    = fiAcno2 
        n_asdat   = fiasdat /*DATE( INPUT cbAsDat) */
        
        n_OutputTo    =  rsOutput
        n_OutputFile  =  fiFile-Name
        n_OutputFileSum = n_OutputFile + "Sum"
         
        nv_poltypFr = fipoltypFr
        nv_poltypTo = fipoltypTo
        nv_RptName  = coRptTyp
        /*nv_RptName2 = IF raReport = 1 THEN "With Credit Term"  ELSE  "By Transaction Date" ---A53-0159---*/
        /*---nv_RptName2 =  "By ComDate" ---By A54-0069---*/
        nv_RptName2 = IF raReport = 1 THEN "By ComDate"  ELSE  "By Transaction Date"   /* A54-0069 */

        nv_typ1  = fityp1
        nv_typ2  = fityp2
        nv_typ3  = fityp3
        nv_typ4  = fityp4
        nv_typ5  = fityp5
        nv_typ6  = fityp6
        nv_typ7  = fityp7
        nv_typ8  = fityp8
        nv_typ9  = fityp9
        nv_typ10 = fityp10
        nv_typ11 = fityp11
        nv_typ12 = fityp12
        nv_typ13 = fityp13
        nv_typ14 = fityp14
        nv_typ15 = fityp15

/*         nv_prninslog = toprnIns */
    /*--- disp trntyp ����к� ---*/
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

    ASSIGN  /* ���͹䢷�����֧������*/
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
   
   END.

        
    /* A48-0265 ---*/
    IF nv_RptName = "Agent" THEN DO:  
        IF  n_frac = "" THEN  n_frac = "".
        IF  n_toac = "" THEN  n_toac = "ZZZZZZZZZZ".  /*-- A500178 ���� format �� X(10)"--*/
    END.
    ELSE DO:
        /*--- A500178 ---
        IF  n_frac = "" THEN  n_frac = "A000000".
        IF  n_toac = "" THEN  n_toac = "B999999". 
        ------*/
        IF  n_frac = "" THEN  n_frac = "A000000".
        IF  n_toac = "" THEN  n_toac = "B999999999". 
    END.
    /*--- A48-0265 */

    nv_poltypFr  = IF nv_poltypFr = "" THEN "" ELSE SUBSTR(nv_poltypFr,2,2).
    nv_poltypTo  = IF nv_poltypTo = "" THEN "99" ELSE SUBSTR(nv_poltypTo,2,2).

   IF ( n_branch > n_branch2)   THEN DO:
         MESSAGE  "�����������ҢҼԴ��Ҵ" SKIP
                          "�����Ң�������鹵�ͧ�ҡ���������ش����" VIEW-AS ALERT-BOX WARNING . 
         APPLY  "Entry" TO  fibranch.
         RETURN  NO-APPLY .       
   END.
   IF ( n_frac > n_toac)   THEN DO:
         MESSAGE  "�����ŵ��᷹�Դ��Ҵ" SKIP
                          "���ʵ��᷹������鹵�ͧ�ҡ���������ش����" VIEW-AS ALERT-BOX WARNING . 
         APPLY  "Entry" TO  fiacno1  .
         RETURN  NO-APPLY .       
   END.
   IF  n_OutputFile = ""    THEN DO:  /* n_OutputTo = 3 And */
         Message "��س����������" VIEW-AS ALERT-BOX WARNING . 
         APPLY  "Entry" TO   fiFile-Name .
         RETURN  NO-APPLY .
   END.
   IF nv_asdatAging = ? THEN DO:
        MESSAGE  "��س���� Asdate for Aging "  SKIP (1)
                            "Asdate for Aging  <=  Process Date " VIEW-AS ALERT-BOX ERROR.
         APPLY "Entry" TO fiasdatAging .
         RETURN NO-APPLY .
    END.

    IF n_asdat = ?   THEN DO:
            MESSAGE "��辺������  ��سҵ�Ǩ�ͺ��� Process ������" VIEW-AS ALERT-BOX WARNING.
    END.
    ELSE DO:
        MESSAGE "�Ң�                      : "  n_Branch " �֧ " n_Branch2 SKIP(1)
                "���᷹/���˹��   : "  n_frac " �֧ " n_toac  SKIP(1)
                "Tran. date             : " n_trndatfr " �֧ " n_trndatto SKIP(1)
                "Policy Type           : " nv_poltypFr " �֧ " nv_poltypTo SKIP(1)
                "Include Type         : " nv_trntyp1 SKIP(1)
                "Asdate for ST(A4)  : " STRING(n_asdat,"99/99/9999") SKIP(1)
                "Asdate for Aging    : "  STRING(nv_asdatAging,"99/99/9999") SKIP(1)
                "Report Name          : " nv_RptName + " " + nv_RptName2
                "   (" + nv_DetSum + ")"
                VIEW-AS ALERT-BOX QUESTION
        BUTTONS YES-NO
        TITLE "Confirm"    UPDATE CHOICE AS LOGICAL.
        CASE CHOICE:
        WHEN TRUE THEN    DO:
             
            vFirstTime =  STRING(TIME, "HH:MM AM").


            IF nv_RptName = "Agent" THEN DO:  /* A48-0265 */
                    RUN pdAgentDet.
            END.
            ELSE IF nv_RptName  = "Acno" THEN DO:
                    RUN pdAcnoDet.   
            END.
            ELSE IF nv_RptName = "Line" THEN DO:
                    RUN pdLineDet.
            END.
            /*
            ELSE IF nv_RptName = "Branch" THEN DO:
                    RUN pdBranchDet.
            END.
            */
            
            RELEASE agtprm_fil.
 
            vLastTime =  STRING(TIME, "HH:MM AM").

            MESSAGE "As of Date      : " STRING(n_asdat,"99/99/9999")  SKIP (1)
                    "���᷹            : "  n_frac " �֧ " n_toac SKIP (1)
                    "����  " vFirstTime "  -  " vLastTime   VIEW-AS ALERT-BOX INFORMATION.

         
        END.
        WHEN FALSE THEN    DO:
        
                RETURN NO-APPLY. 
        END.
        END CASE.    
        
    END.   /* IF  asdat  <> ? */
END.

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


&Scoped-define SELF-NAME buPoltypFr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buPoltypFr C-Win
ON CHOOSE OF buPoltypFr IN FRAME frST /* ... */
DO:

  RUN Whp\WhpPolTy(INPUT-OUTPUT  n_poldes).
  
  ASSIGN    
        fipoltypFr = n_poltyp
        fipoldesFr = n_poldes.
       
  DISP fiPoltypFr fipoldesFr WITH FRAME {&Frame-Name}      .
 
  RETURN NO-APPLY.


END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buPoltypTo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buPoltypTo C-Win
ON CHOOSE OF buPoltypTo IN FRAME frST /* ... */
DO:

  RUN Whp\WhpPolTy(INPUT-OUTPUT  n_poldes).
  
  ASSIGN    
        fipoltypTo = n_poltyp
        fipoldesTo = n_poldes.
       
  DISP fiPoltypTo fipoldesTo WITH FRAME {&Frame-Name}      .
 
  RETURN NO-APPLY.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME coRptTyp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL coRptTyp C-Win
ON RETURN OF coRptTyp IN FRAME frST /* Combo 1 */
DO:

    APPLY "ENTRY" TO raReport IN FRAME {&FRAME-NAME}.
    RETURN NO-APPLY.
       
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL coRptTyp C-Win
ON VALUE-CHANGED OF coRptTyp IN FRAME frST /* Combo 1 */
DO:
    coRptTyp = INPUT coRptTyp.
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
              MESSAGE "��辺������" VIEW-AS ALERT-BOX  warning TITLE "Confirm" .
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
 *           MESSAGE "��辺������" VIEW-AS ALERT-BOX  warning TITLE "Confirm" .
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
              MESSAGE "��辺������" VIEW-AS ALERT-BOX  warning TITLE "Confirm" .
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
 *           MESSAGE "��辺������" VIEW-AS ALERT-BOX  warning TITLE "Confirm" .
 *   END.*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiasdatAging
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiasdatAging C-Win
ON LEAVE OF fiasdatAging IN FRAME frST /* Fill 1 */
DO:
    fiasdatAging = INPUT fiasdatAging.
    
    nv_asdatAging = fiasdatAging.
    
    IF nv_asdatAging <= fiProcessdate THEN nv_asdatAging = fiasdatAging.
    ELSE DO:
        MESSAGE  "Invaild data ! "  SKIP (1)
                            "Asdate for Aging  > Process Date " VIEW-AS ALERT-BOX ERROR.
        ASSIGN
            nv_asdatAging =  ?
            fiasdatAging = ?.
        DISP fiasdatAging WITH FRAME frST.
    END.
    
    APPLY "ENTRY" TO coRptTyp IN FRAME {&FRAME-NAME}.
    RETURN NO-APPLY.    


END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiasdatAging C-Win
ON RETURN OF fiasdatAging IN FRAME frST /* Fill 1 */
DO:
      APPLY "ENTRY" TO fiFile-Name IN FRAME froutput.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiBranch
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiBranch C-Win
ON LEAVE OF fiBranch IN FRAME frST
DO:
  ASSIGN
         fibranch = input fibranch
         n_branch = CAPS(fibranch).

    DISP n_branch @ fibranch WITH FRAME frST.
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
          MESSAGE "��辺������" VIEW-AS ALERT-BOX  warning TITLE "Confirm" .
  END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiBranch2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiBranch2 C-Win
ON LEAVE OF fiBranch2 IN FRAME frST
DO:
     ASSIGN
         fibranch2 = input fibranch2
         n_branch2  = CAPS(fibranch2).
         
    DISP n_branch2 @ fibranch2 WITH FRAME frST.

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
          MESSAGE "��辺������" VIEW-AS ALERT-BOX  warning TITLE "Confirm" .
  END.

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
&Scoped-define SELF-NAME fiPolTypFr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiPolTypFr C-Win
ON LEAVE OF fiPolTypFr IN FRAME frST
DO:

    ASSIGN
        fiPolTypFr = INPUT fiPolTypFr
        n_poltyp  = CAPS(fiPolTypFr).
        
    DISP 
        n_poltyp @ fiPoltypFr
        n_poltyp @ fiPolTypTo WITH FRAME frST.
   
    IF n_PolTyp <> ""  THEN DO :
        FIND   xmm031 WHERE xmm031.poltyp = n_poltyp  NO-ERROR.
        IF AVAILABLE xmm031 THEN DO:
              fipoldesFr:Screen-value IN FRAME {&FRAME-NAME} = xmm031.poldes.
        END.        
        ELSE DO:
              fipoldesFr:Screen-value IN FRAME {&FRAME-NAME} = "Not Found !".
              MESSAGE "��辺������" VIEW-AS ALERT-BOX  warning TITLE "Confirm" .
        END.
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiPolTypTo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiPolTypTo C-Win
ON LEAVE OF fiPolTypTo IN FRAME frST
DO:

    ASSIGN
        fiPolTypTo = INPUT fiPolTypTo
        n_poltyp  = CAPS(fiPolTypTo).
        
    DISP 
        n_poltyp @ fiPoltypTo  WITH FRAME frST. 
   
    IF n_PolTyp <> ""  THEN DO :
        FIND   xmm031 WHERE xmm031.poltyp = n_poltyp  NO-ERROR.
        IF AVAILABLE xmm031 THEN DO:
              fipoldesTo:Screen-value IN FRAME {&FRAME-NAME} = xmm031.poldes.
        END.        
        ELSE DO:
              fipoldesTo:Screen-value IN FRAME {&FRAME-NAME} = "Not Found !".
              MESSAGE "��辺������" VIEW-AS ALERT-BOX  warning TITLE "Confirm" .
        END.
    END.
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frTrndat
&Scoped-define SELF-NAME fiTrndatFr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiTrndatFr C-Win
ON LEAVE OF fiTrndatFr IN FRAME frTrndat
DO:
  fiTrndatfr = INPUT fiTrndatfr.

  n_trndatfr = fitrndatfr.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiTrndatTo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiTrndatTo C-Win
ON LEAVE OF fiTrndatTo IN FRAME frTrndat /* Fill 2 */
DO:
    fiTrndatTo = INPUT fiTrndatTo.
    
    n_trndatTo = fitrndatto.

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


&Scoped-define FRAME-NAME frTrndat
&Scoped-define SELF-NAME raAllbal
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL raAllbal C-Win
ON VALUE-CHANGED OF raAllbal IN FRAME frTrndat
DO:
  
DO WITH FRAME frTrndat.

    raAllbal  = INPUT raAllbal .
    

    IF raAllbal = 1 THEN  DO:   /* all  bal */

        DISABLE ALL EXCEPT raAllbal .

        ASSIGN
        n_trndatfr = n_trndatfrold
        n_trndatto = n_trndattoold
        
        fiTrndatfr = n_trndatfr
        fiTrndatto = n_trndatto.

        DISP fiTrndatfr fiTrndatto .

    END.
    ELSE DO:                            /* partial bal */
        ENABLE ALL .

    END.
    
    

END.
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frST
&Scoped-define SELF-NAME raDetSum
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL raDetSum C-Win
ON VALUE-CHANGED OF raDetSum IN FRAME frST
DO:

    raDetSum = INPUT raDetSum.
    
    nv_DetSum = IF raDetSum =  1 THEN "Detail" 
                            ELSE IF raDetSum =  2 THEN "Summary"
                            ELSE "All".
    

  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME raReport
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL raReport C-Win
ON RETURN OF raReport IN FRAME frST
DO:
    APPLY "ENTRY" TO fityp1  IN FRAME frST.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL raReport C-Win
ON VALUE-CHANGED OF raReport IN FRAME frST
DO:

    DO WITH FRAME frST:
        ASSIGN
            raReport= INPUT raReport
            fiasdatAging = INPUT fiasdatAging.

        DISP fiasdatAging.  
    END.
    
END.

/*        IF raChoice = 1 THEN DO: 
 *             DISABLE fiasdatAging. 
 *             ASSIGN
 *                 fiasdatAging = ?
 *                 nv_asdatAging = ?.
 *         END.
 *         ELSE DO:
 *             ENABLE fiasdatAging.
 *             nv_asdatAging = fiasdatAging.
 *         END.*/

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frOutput
&Scoped-define SELF-NAME rsOutput
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL rsOutput C-Win
ON VALUE-CHANGED OF rsOutput IN FRAME frOutput
DO:
  ASSIGN {&SELF-NAME}.
  
    fiFile-Name:SENSITIVE = Yes. 
    APPLY "ENTRY" TO fiFile-Name.

  
/*  CASE rsOutput:
 *         WHEN 1 THEN  /* Screen */
 *           ASSIGN
 *            cbPrtList:SENSITIVE   = No
 *            fiFile-Name:SENSITIVE = No.
 *         WHEN 2 THEN  /* Printer */
 *           ASSIGN
 *            cbPrtList:SENSITIVE   = Yes
 *            fiFile-Name:SENSITIVE = No.
 *         WHEN 3 THEN  /* File */ 
 *         DO:
 *           ASSIGN
 *             cbPrtList:SENSITIVE   = No
 *             fiFile-Name:SENSITIVE = Yes. 
 *           APPLY "ENTRY" TO fiFile-Name.
 *         END.
 *   END CASE.*/
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frST
&Scoped-define SELF-NAME rstype
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL rstype C-Win
ON VALUE-CHANGED OF rstype IN FRAME frST
DO:
   rstype = INPUT rstype.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME to_type
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL to_type C-Win
ON VALUE-CHANGED OF to_type IN FRAME frST
DO:
   DO WITH FRAME frST :
      to_type = INPUT to_type.
      
      IF INPUT to_type = NO THEN DO:
         ASSIGN fipoltypfr = ""
                fipoldesfr = ""
                fipoltypto = ""
                fipoldesto = "".
      
         DISABLE rstype.
         ENABLE fipoltypfr bupoltypfr fipoldesfr
                fipoltypto bupoltypto fipoldesto.
      
         DISP fipoltypfr  bupoltypfr fipoldesfr
              fipoltypto bupoltypto fipoldesto.
      END.
      ELSE DO: 
         ASSIGN fipoltypfr = ""
                fipoldesfr = ""
                fipoltypto = ""
                fipoldesto = "".
                
         ENABLE rstype.
         DISABLE fipoltypfr  bupoltypfr fipoldesfr
                 fipoltypto bupoltypto fipoldesto.
      
         DISP fipoltypfr  bupoltypfr fipoldesfr
              fipoltypto bupoltypto fipoldesto .
      
      END.
   END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME DEFAULT-FRAME
&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK C-Win 


/* ***************************  Main Block  *************************** */

/************   Program   **************
/* CREATE BY :  Sayamol N.     A53-0159    13/07/2010  */
/* Dupplicate Program from WACRLIAC.W                  */
/*--------- About Program -----------------------------*/
/* �ӵ�����ҧ�Ҩҡ  wacr05.w */
��Ѻ�ҡ����� wacr06.w ��ҧ�ѹ�����͹䢷��֧��������ҹ��
Wac
        -Wacr05.w            /*Aging Detail Report  */
        wacr0501.i
        wacr0502.i
        wacr0503.i
Whp
        -WhpBran.w
        -WhpAcno.w
        -WhpClico.w
Wut
        -WutDiCen.p
        -WutWiCen.p
��������´ �٨ҡ    wacr06.w 
- ����ѡ������ǡѺ aging report  by trndate    �����Ѻ�ӹǹ ���¤�ҧ   ��  �ӹǹ�ѹ  ᷹ �ӹǹ��͹
Wacrliac - Ageing Count Day By Trandate
    Wacrliac.w,
    Wacr0099.p,
    Wacrt01.i,
    Wacrt02.i,
    Wacrt03.i
- ����  ������¡��� Agent code
- report by line  ����¹�ҡ acno �� agent 
- ��� ...OS  �����ʹ���  ��� �ӹǹ�ѹ����
- �¡ Report Motor , Non Motor , All
- �觪�ǧ�ѹ�� 1-15, 16-30, 31-45, 46-60, 61-90, 91-180, 181-270, 271-365, �Թ 365
- ��äԴ�ѹ�ФԴ�ҡ (As Date - Com Date) + 1

- Modify by Sayamol N.  A54-0069    07/03/2011
    - �ӹǳ���  Trans.Date
*************************/

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
  
  gv_prgid = "Wacrloic".
  gv_prog  = "Ageing Count Day for OIC".
  RUN  WUT\WUTHEAD (c-win:handle,gv_prgid,gv_prog).

  Run Wut\WutDiCen(C-win:handle).
   Session:Data-Entry-Return  = Yes. 

/*********************************************************************/  

/*   CURRENT-WINDOW:WINDOW-STATE = WINDOW-MAXIMIZED. */
/*    RUN Wut\Wutwicen.p (C-Win:HANDLE).*/

  SESSION:DATA-ENTRY-RETURN = YES.
  
    DO WITH FRAME frST :
        re1:MOVE-TO-TOP().
        re11:MOVE-TO-TOP().
        re12:MOVE-TO-TOP().
        re13:MOVE-TO-TOP().
        re14:MOVE-TO-TOP().
    
/*  RUN ProcGetRptList.
 *   RUN ProcGetPrtList.  */

        ASSIGN   
             fiacno1    = ""
             fiacno2    = ""
             fiPoltypFr = ""   /*F10*/
             fiPoltypTo = ""   /*C90*/
             nv_asdatAging = ?
             fiProcess = ""

             fiInclude =  nv_Trntyp1
             fityp1 = "M"
             fityp2 = "R"
             fityp3 = "A"
             fityp4 = "B"
             fityp5 = "C"
             fityp6 = "Y"
             fityp7 = "Z"

            nv_RptTyp = "Agent,Acno,Line"
   
            coRptTyp:List-Items = nv_RptTyp
            coRptTyp = ENTRY(1,nv_RptTyp)
            /*raReport:Radio-Buttons = "With Credit Term, 1,Com Date, 2" ---A53-0159---*/
            /*--- raReport:Radio-Buttons = "Com Date, 1"  ---By A54-0069---*/
            raReport:Radio-Buttons = "Com Date, 1,Trans Date, 2"   /* A54-0069 */
            raReport = 1
            rstype   = 1    /*A53-0159*/
            
            raDetSum:radio-buttons = "Detail,1,Summary,2,All,3"
            raDetSum = 1
            nv_DetSum = IF raDetSum =  1 THEN "Detail" 
                        ELSE IF raDetSum =  2 THEN "Summary"
                        ELSE "All"
            to_type    = YES  .

        DISABLE fipoltypfr  bupoltypfr fipoldesfr
                fipoltypto bupoltypto fipoldesto.
        DISPLAY  fiacno1 fiacno2  fiasdat
                 fiInclude   fityp1  fityp2  fityp3  fityp4  fityp5  fityp6  fityp7
                 fiPoltypFr fiPoltypTo
                 coRptTyp
                 raReport
                 raDetSum
                 to_type.
        
    RUN pdInitData.
    RUN pdUpdateQ.

    APPLY "ENTRY" TO fiBranch IN FRAME frST.
  END.    
  DO WITH FRAME frTranDate:
       ASSIGN  
         rsOutput:Radio-Buttons = "File, 1" /*"˹�Ҩ�, 1,����ͧ�����, 2, File, 3" */
         rsOutput = 1.
      DISPLAY rsOutput WITH FRAME frOutput .    

  END.

    DO WITH FRAME frTrndat :
        raAllbal = 1.
        DISABLE ALL EXCEPT raAllbal  WITH FRAME frTrndat .
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
  ENABLE IMAGE-22 
      WITH FRAME frMain IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-frMain}
  DISPLAY to_type rstype fiBranch fiBranch2 fiPolTypFr fiPolTypTo fiacno1 
          fiacno2 fiasdatAging coRptTyp raReport raDetSum fiTyp1 fiTyp2 fiTyp3 
          fiTyp4 fiTyp5 fiTyp6 fiTyp7 fiTyp8 fiTyp9 fiTyp10 fiTyp11 fiTyp12 
          fiTyp13 fiTyp14 fiTyp15 fibdes fibdes2 fiPoldesFr fiPoldesTo finame1 
          finame2 fiInclude fiAsdat fiProcessDate fiProcess 
      WITH FRAME frST IN WINDOW C-Win.
  ENABLE to_type rstype fiBranch fiBranch2 fiPolTypFr fiPolTypTo fiacno1 
         fiacno2 fiasdatAging buBranch buBranch2 buPoltypFr buPoltypTo buAcno2 
         coRptTyp raReport raDetSum brAcproc_fil fiTyp1 fiTyp2 fiTyp3 fiTyp4 
         fiTyp5 fiTyp6 fiTyp7 fiTyp8 fiTyp9 fiTyp10 fiTyp11 fiTyp12 fiTyp13 
         fiTyp14 fiTyp15 buAcno1 fibdes fibdes2 fiPoldesFr fiPoldesTo finame1 
         finame2 fiInclude fiAsdat fiProcessDate fiProcess re1 re11 re12 re13 
         re14 RECT-302 
      WITH FRAME frST IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-frST}
  DISPLAY rsOutput fiFile-Name 
      WITH FRAME frOutput IN WINDOW C-Win.
  ENABLE RECT-5 rsOutput fiFile-Name 
      WITH FRAME frOutput IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-frOutput}
  DISPLAY raAllbal fiTrndatFr fiTrndatTo 
      WITH FRAME frTrndat IN WINDOW C-Win.
  ENABLE RECT-303 RECT-305 raAllbal fiTrndatFr fiTrndatTo 
      WITH FRAME frTrndat IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-frTrndat}
  ENABLE RECT2 Btn_OK Btn_Cancel 
      WITH FRAME frOK IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-frOK}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdAcnoDet C-Win 
PROCEDURE pdAcnoDet :
/*------------------------------------------------------------------------------
  Purpose: Ageing Detail  By Acno
------------------------------------------------------------------------------*/
DEF VAR  vCount AS INT INIT 0.
DEF VAR  i AS INT.

nv-1 = FILL(" ",5).

/* delete  work-table */
FOR EACH wtGrpCode: DELETE wtGrpCode. END.
FOR EACH wtGrpSum:  DELETE wtGrpSum.  END.

    RUN pdInitDataG. /* clear ��� GRAND TOTAL ��� file detail, summary */

    ASSIGN
        nv_reccnt = 0
        nv_next   = 1
        n_OutputFile = n_OutputFile + STRING(nv_next).      
/********************** Page Header *********************/
    
/*--- DISPLAY DETAIL  ---*/
    IF (nv_DetSum = "Detail")  OR (nv_DetSum = "All") THEN DO:
        OUTPUT TO VALUE (n_OutputFile ) NO-ECHO.
            RUN pdTitleDet.    /*3 row */ /*RUN pdPageHead.*/
            RUN pdPageHeadDet. /*1*/
        OUTPUT CLOSE.

        nv_reccnt = nv_reccnt + 4 . 
    END.  /* (nv_DetSum = "Detail")  OR (nv_DetSum = "All") */
    

/*** DISPLAY SUMMARY FILE & SUMMARY GRAND TOTAL***/
    IF (nv_DetSum = "Summary")  OR (nv_DetSum = "All") THEN DO:
        OUTPUT TO VALUE (n_OutputFileSum) NO-ECHO.  /* SUMMARY */
            RUN pdTitleSum.
            RUN pdPageHeadSum.
        OUTPUT CLOSE.
        
        /* A47-0264 */
        OUTPUT TO VALUE (n_OutputFileSum + "OS") NO-ECHO.  /* SUMMARY */
            RUN pdTitleSumOS.
            EXPORT DELIMITER ";"
                nv_RptName
                "Premium "
                "Comm"
                "Bal. O/S (Prem + Comm)"
                "Cheque Return"
                "Suspense"
                "Net. A/r (Bal. O/S + Cheque Ret. + Sus. )"
                "Net. Other (ex. 'YP')"
                "����Թ 15 �ѹ"
                "16 - 30 �ѹ"
                "31 - 45 �ѹ"
                "46 - 60 �ѹ"
                "61 - 90 �ѹ"
                /*---A54-0119---
                "91 - 180 �ѹ"
                "181 - 270 �ѹ"
                "271 - 365 �ѹ"
                "365 �ѹ����"
                -------------*/
                /*---A54-0119---*/
                "91 - 120 �ѹ"
                "121 - 150 �ѹ"
                "151 - 180 �ѹ"
                "181 - 210 �ѹ"
                "211 - 240 �ѹ"
                "241 - 270 �ѹ"
                "271 - 300 �ѹ"
                "301 - 330 �ѹ"
                "331 - 365 �ѹ"
                "365 �ѹ����"
                /*---end A54-0119---*/
                "Customer Type".   
                
        OUTPUT CLOSE.
    END.  /* (nv_DetSum = "Summary")  OR (nv_DetSum = "All")  */

    nv_poltyp = "".

IF rstype = 1 THEN DO:
    FOR EACH xmm031 NO-LOCK WHERE xmm031.dept = "M" OR 
                                   xmm031.dept = "G" 
     BREAK BY xmm031.poltyp:
        IF nv_poltyp = "" THEN ASSIGN nv_poltyp = xmm031.poltyp.
        ELSE ASSIGN nv_poltyp = nv_poltyp + "," + xmm031.poltyp .
    END.
 END.
 ELSE IF rstype = 2 THEN DO:
    FOR EACH xmm031 NO-LOCK WHERE xmm031.dept <> "M" OR 
                                  xmm031.dept <> "G" 
    BREAK BY xmm031.poltyp:
        IF nv_poltyp = "" THEN ASSIGN nv_poltyp = xmm031.poltyp.
        ELSE ASSIGN nv_poltyp = nv_poltyp + "," + xmm031.poltyp .
    END.
END.
ELSE DO:
    FOR EACH xmm031 NO-LOCK 
    BREAK BY xmm031.poltyp:
        IF nv_poltyp = "" THEN ASSIGN nv_poltyp = xmm031.poltyp.
        ELSE ASSIGN nv_poltyp = nv_poltyp + "," + xmm031.poltyp .
    END. 

END.

    loop_ac :

    FOR EACH  agtprm_fil USE-INDEX by_acno WHERE
              agtprm_fil.asdat    = n_asdat    AND
             (agtprm_fil.acno    >= n_frac     AND agtprm_fil.acno    <= n_toac  )   AND
             (LOOKUP(agtprm_fil.poltyp,nv_poltyp) <> 0)    AND
             (agtprm_fil.trndat  >= n_trndatFr AND agtprm_fil.trndat  <= n_trndatTo) AND
             (agtprm_fil.polbran >= n_branch   AND agtprm_fil.polbran <= n_branch2)  AND
      ( LOOKUP (SUBSTRING(agtprm_fil.trntyp,1,1) , nv_trntyp1) <> 0 )
    NO-LOCK BREAK  BY agtprm_fil.acno 
                   BY agtprm_fil.trndat
                   BY agtprm_fil.policy
                   BY agtprm_fil.endno. 
    
             DISP agtprm_fil.acno FORMAT "X(10)"
                  agtprm_fil.trndat
                  agtprm_fil.policy
                  agtprm_fil.trntyp
                  agtprm_fil.docno
             WITH COLOR BLACK/WHITE NO-LABEL FRAME frProcess VIEW-AS DIALOG-BOX
             TITLE  "  Processing ...".
        
        n_asdat = IF nv_asdatAging = ? THEN n_asdat ELSE nv_asdatAging.
    /* Begin */
          /********************** Group Header *********************/
            
        IF FIRST-OF(agtprm_fil.acno)  THEN DO:  /**/
            nv_acname = "".
            FIND  xmm600 USE-INDEX xmm60001 
                  WHERE xmm600.acno = agtprm_fil.acno NO-LOCK NO-ERROR.
            IF AVAIL xmm600 THEN nv_acname = TRIM(xmm600.ntitle) + " " + TRIM(xmm600.name).
                            ELSE nv_acname = agtprm_fil.ac_name.

            /*--- DISPLAY DETAIL  ---*/
            IF (nv_DetSum = "Detail")  OR (nv_DetSum = "All") THEN DO:
                
                /* A47-0264  - count  record �����¡���  �ҡ�Թ  65500  limit �ͧ excel*/
                    {wac\wacr0604.i}
                /* end A47-0264 */

                OUTPUT TO VALUE (STRING(n_OutputFile ) ) APPEND NO-ECHO.
                    EXPORT DELIMITER ";"
                        "Acno : " + agtprm_fil.acno + " - " +  nv_acname  + "  " +
                        "Credit Limit " + STRING(agtprm_fil.odue6,"->>>,>>>,>>>,>>9.99") + "  " +    /*xmm600.ltamt   Credit Limit*/
                                          agtprm_fil.acno_clicod  + "  " +
                        "Type : " + agtprm_fil.type.
                OUTPUT CLOSE.
            END.  /*  (nv_DetSum = "Detail")  OR (nv_DetSum = "All") */

            RUN pdInitDataTot.  /* clear data in group*/
            RUN pdDeptGrp.   
        END.  /* first-of(agtprm_fil.acno) */

        /****** �ӹǹ ��������´��� ��� display � File Detail   � dot i*****/
            {wac\wacrl01.i}
             
        /********************** Group Footer *********************/
          IF LAST-OF(agtprm_fil.acno)  THEN DO:  /**/
            nv_acname = "".
            FIND  xmm600 USE-INDEX xmm60001 
                  WHERE xmm600.acno = agtprm_fil.acno NO-LOCK NO-ERROR.
            IF AVAIL xmm600 THEN nv_acname = TRIM(xmm600.ntitle) + " " + TRIM(xmm600.name).
                            ELSE nv_acname = agtprm_fil.ac_name.
          
            ASSIGN
                nv_RptTyp1 = ""
                nv_RptTyp2 = ""
                nv_RptTyp1 = agtprm_fil.acno  /* ����¹仵�� ��Դ�ͧ report */
                nv_RptTyp2 = nv_acname.

            /*** �ӹǹ����� group, export ������ŧ SUMMARY FILE ���  �ӹǹ SUMMARY GRAND TOTAL***/
                {wac\wacrl02.i}

        /*** CREATE  WORK-TABLE for file SUMMARY GROUP CODE***/
             DO TRANSACTION:
                CREATE wtGrpSum.
                ASSIGN
                    wtGTrptName = nv_RptName
                    wtGTgpcode  = xmm600.gpage  /* ageing Group Code*/
                    wtGTacno    = agtprm_fil.acno
                    wtGTacname  = nv_acname
                    wtGTTPrem   = nv_TTprem
                    wtGTTcomm   = nv_TTcomm
                    wtGTTbal    = nv_TTbal
                    wtGTTretc   = nv_TTretc
                    wtGTTsusp   = nv_TTsusp
                    wtGTTnetar  = nv_TTnetar
                    wtGTTnetoth = nv_TTnetoth.
   
                 i = 1.
                 
                /*---A54-0119---
                 DO i = 1 to 9 : 
                 -----------*/
                 DO i = 1 TO 15 :
                 ASSIGN
                        wtGTPrem[i]   = nv_Tprem[i]
                        wtGTcomm[i]   = nv_Tcomm[i]
                        wtGTbal[i]    = nv_Tbal[i]
                        wtGTretc[i]   = nv_Tretc[i]
                        wtGTsusp[i]   = nv_Tsusp[i]
                        wtGTnetar[i]  = nv_Tnetar[i]
                        wtGTnetoth[i] = nv_Tnetoth[i]
                        .
                 END.
              END. /*transaction*/
          END. /*  LAST-OF(agtprm_fil.acno) */
        vCount = vCount + 1.
    END. /* for each agtprm_fil*/

        /********************** Page Footer *********************/

        /*** export ������ŧ DETAIL FILE ��÷Ѵ Grand Total  ���  
                                    SUMMARY FILE ��÷Ѵ Grand Total ***/
            {wac\wacrl03.i}

    RELEASE agtprm_fil.

    IF (nv_DetSum = "Summary")  OR (nv_DetSum = "All") THEN DO:
        RUN pdAcnoGp.  /* �¡ group code �͡���ա 1 file */
    END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdAcnoGp C-Win 
PROCEDURE pdAcnoGp :
/*------------------------------------------------------------------------------
  Purpose:     �¡��� summary  BREAK BY group code
  Parameters:  <none>
  Notes:        field  xmm600.gpage
------------------------------------------------------------------------------*/
DEF VAR vgpname AS CHAR.

    OUTPUT TO VALUE (n_OutputFile + "Gp") NO-ECHO.  /* SUMMARY */
        RUN pdTitleSum.
        RUN pdPageHeadSum.

        FOR EACH wtGrpSum USE-INDEX wtGrpSum2
                            BREAK BY wtGTgpcode BY wtGTacno :

            IF FIRST-OF(wtGTgpcode) THEN DO:
                FIND FIRST xmm600 USE-INDEX xmm60001 
                                WHERE xmm600.acno = wtGTgpcode NO-LOCK NO-ERROR.
                IF AVAIL xmm600 THEN vgpname = xmm600.name.  /* ���� ��ѡ�ҹ ����Թ */
                                 ELSE vgpname = "".
                    
                EXPORT DELIMITER ";" "".
                EXPORT DELIMITER ";" "GROUP CODE : " + wtGTgpcode + " - " +  vgpname.
                EXPORT DELIMITER ";" FILL("-",100).
            END.

                EXPORT DELIMITER ";"  "Summary of : " + wtGTrptname + " " + wtGTacno + " - " + wtGTacname.


                EXPORT DELIMITER ";"  wtGTrptname + " Premium"          wtGTTprem   /*--wtGTprem[1 FOR 4].  Lukkana M. A52-0318 26/11/2009---*/
                                                                                    wtGTprem[1 FOR 13].  /*---Lukkana M. A52-0318 26/11/2009---*/
                EXPORT DELIMITER ";"  wtGTrptname + " Commission"       wtGTTcomm   /*--wtGTcomm[1 FOR 4].  Lukkana M. A52-0318 26/11/2009---*/
                                                                                    wtGTcomm[1 FOR 13].  /*---Lukkana M. A52-0318 26/11/2009---*/
                EXPORT DELIMITER ";"  wtGTrptname + " Bal. O/S"         wtGTTbal    /*--wtGTbal[1 FOR 4].   Lukkana M. A52-0318 26/11/2009---*/
                                                                                    wtGTbal[1 FOR 13].   /*---Lukkana M. A52-0318 26/11/2009---*/
                EXPORT DELIMITER ";" wtGTrptname + " Cheque Returned"   wtGTTretc   /*--wtGTretc[1 FOR 4].  Lukkana M. A52-0318 26/11/2009---*/
                                                                                    wtGTretc[1 FOR 13].  /*---Lukkana M. A52-0318 26/11/2009---*/
                EXPORT DELIMITER ";"  wtGTrptname + " Suspense"         wtGTTsusp   /*--wtGTsusp[1 FOR 4].  Lukkana M. A52-0318 26/11/2009---*/
                                                                                    wtGTsusp[1 FOR 13].  /*---Lukkana M. A52-0318 26/11/2009---*/
                EXPORT DELIMITER ";"  wtGTrptname + " Net. A/R"         wtGTTnetar  /*--wtGTnetar[1 FOR 4]. Lukkana M. A52-0318 26/11/2009---*/
                                                                                    wtGTnetar[1 FOR 13]. /*--Lukkana M. A52-0318 26/11/2009---*/
                EXPORT DELIMITER ";"  wtGTrptname + " Net. OTHER"       wtGTTnetoth /*--wtGTnetoth[1 FOR 4]. Lukkana M. A52-0318 26/11/2009---*/
                                                                                    wtGTnetoth[1 FOR 13]. /*---Lukkana M. A52-0318 26/11/2009---*/

            
                EXPORT DELIMITER ";" "Summary of : " + wtGTrptname + " " + wtGTacno
                    "����Թ 30 �ѹ" + STRING(wtGTbal[1]  ,">>,>>>,>>>,>>9.99-") + nv-1 + 
                    "31 - 60 �ѹ"    + STRING(wtGTbal[2]  ,">>,>>>,>>>,>>9.99-") + nv-1 + 
                    "61 - 90 �ѹ"    + STRING(wtGTbal[3]  ,">>,>>>,>>>,>>9.99-") + nv-1 + 
                    "91 - 120 �ѹ"   + STRING(wtGTbal[4]  ,">>,>>>,>>>,>>9.99-") + nv-1 +
                    "121 - 150 �ѹ"  + STRING(wtGTbal[5]  ,">>,>>>,>>>,>>9.99-") + nv-1 +
                    "151 - 180 �ѹ"  + STRING(wtGTbal[6]  ,">>,>>>,>>>,>>9.99-") + nv-1 +
                    "181 - 210 �ѹ"  + STRING(wtGTbal[7]  ,">>,>>>,>>>,>>9.99-") + nv-1 +
                    "211 - 240 �ѹ"  + STRING(wtGTbal[8]  ,">>,>>>,>>>,>>9.99-") + nv-1 +        
                    "241 - 270 �ѹ"  + STRING(wtGTbal[9]  ,">>,>>>,>>>,>>9.99-") + nv-1 +
                    "271 - 300 �ѹ"  + STRING(wtGTbal[10] ,">>,>>>,>>>,>>9.99-") + nv-1 +
                    "301 - 330 �ѹ"  + STRING(wtGTbal[11] ,">>,>>>,>>>,>>9.99-") + nv-1 +
                    "331 - 365 �ѹ"  + STRING(wtGTbal[12] ,">>,>>>,>>>,>>9.99-") + nv-1 +        
                    "365 �ѹ����"  + STRING(wtGTbal[13] ,">>,>>>,>>>,>>9.99-") .
                   
        END.  /* first-of(wtGTgpcode) */
        
        EXPORT DELIMITER ";"  "".
        EXPORT DELIMITER ";"  "".
        EXPORT DELIMITER ";"  "G R A N D  T O T A L".

        EXPORT DELIMITER ";"  "Grand Premium"           nv_GTTprem      nv_GTprem[1 FOR 13]. 
        EXPORT DELIMITER ";"  "Grand Commission"        nv_GTTcomm      nv_GTcomm[1 FOR 13]. 
        EXPORT DELIMITER ";"  "Grand Bal. O/S"          nv_GTTbal       nv_GTbal[1 FOR 13].   
        EXPORT DELIMITER ";"  "Grand Cheque Returned"   nv_GTTretc      nv_GTretc[1 FOR 13].  
        EXPORT DELIMITER ";"  "Grand Suspense"          nv_GTTsusp      nv_GTsusp[1 FOR 13].  
        EXPORT DELIMITER ";"  "Grand Net. A/R"          nv_GTTnetar     nv_GTnetar[1 FOR 13]. 
        EXPORT DELIMITER ";"  "Grand Net. OTHER"        nv_GTTnetoth    nv_GTnetoth[1 FOR 13].
        EXPORT DELIMITER ";"  "".
        EXPORT DELIMITER ";" "G R A N D  T O T A L"
                "����Թ 30 �ѹ" + STRING(nv_GTbal[1] ,">>,>>>,>>>,>>9.99-") + nv-1 +     
                "31 - 60 �ѹ"    + STRING(nv_GTbal[2] ,">>,>>>,>>>,>>9.99-") + nv-1 +     
                "61 - 90 �ѹ"    + STRING(nv_GTbal[3] ,">>,>>>,>>>,>>9.99-") + nv-1 +  
                "91 - 120 �ѹ"   + STRING(nv_GTbal[4] ,">>,>>>,>>>,>>9.99-") + nv-1 +           
                "121 - 150 �ѹ"  + STRING(nv_GTbal[5] ,">>,>>>,>>>,>>9.99-") + nv-1 +     
                "151 - 180 �ѹ"  + STRING(nv_GTbal[6] ,">>,>>>,>>>,>>9.99-") + nv-1 +     
                "181 - 210 �ѹ"  + STRING(nv_GTbal[7] ,">>,>>>,>>>,>>9.99-") + nv-1 +  
                "211 - 240 �ѹ"  + STRING(nv_GTbal[8] ,">>,>>>,>>>,>>9.99-") + nv-1 +           
                "241 - 270 �ѹ"  + STRING(nv_GTbal[9] ,">>,>>>,>>>,>>9.99-") + nv-1 +     
                "271 - 300 �ѹ"  + STRING(nv_GTbal[10] ,">>,>>>,>>>,>>9.99-") + nv-1 +     
                "301 - 330 �ѹ"  + STRING(nv_GTbal[11] ,">>,>>>,>>>,>>9.99-") + nv-1 +  
                "331 - 365 �ѹ"  + STRING(nv_GTbal[12] ,">>,>>>,>>>,>>9.99-") + nv-1 +         
                "365 �ѹ����"  + STRING(nv_GTbal[13] ,">>,>>>,>>>,>>9.99-") .

    OUTPUT CLOSE.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdAgentDet C-Win 
PROCEDURE pdAgentDet :
/*------------------------------------------------------------------------------
  Purpose: Ageing Detail  By Agent  
------------------------------------------------------------------------------*/
                
DEF VAR  vCount AS INT INIT 0.
DEF VAR  i AS INT.

nv-1 = FILL(" ",5).

/* delete  work-table */
FOR EACH wtGrpCode: DELETE wtGrpCode. END.
FOR EACH wtGrpSum:  DELETE wtGrpSum.  END.
FOR EACH wtOICSum:  DELETE wtOICSum.  END.
FOR EACH wtDet:     DELETE wtDet.     END.

    RUN pdInitDataG. /* clear ��� GRAND TOTAL ��� file detail, summary */

    ASSIGN
        nv_reccnt = 0
        nv_next   = 1
        n_OutputFile = n_OutputFile + STRING(nv_next).      
    /********************** Page Header *********************/
    
/*--- DISPLAY DETAIL  ---*/
    IF (nv_DetSum = "Detail")  OR (nv_DetSum = "All") THEN DO:
        OUTPUT TO VALUE (n_OutputFile ) NO-ECHO.
            RUN pdTitleDet.    /*3 row */
            RUN pdPageHeadDet. /*1*/
        OUTPUT CLOSE.

        nv_reccnt = nv_reccnt + 4 . /*A47-0263 */
    END.  /* (nv_DetSum = "Detail")  OR (nv_DetSum = "All") */

/*** DISPLAY SUMMARY FILE & SUMMARY GRAND TOTAL***/
    IF (nv_DetSum = "Summary")  OR (nv_DetSum = "All") THEN DO:
        OUTPUT TO VALUE (n_OutputFileSum) NO-ECHO.  /* SUMMARY */
            RUN pdTitleSum.
            RUN pdPageHeadSum.
        OUTPUT CLOSE.
        
        OUTPUT TO VALUE (n_OutputFileSum + "OS") NO-ECHO.  /* SUMMARY */
            RUN pdTitleSumOS.
            EXPORT DELIMITER ";"
                nv_RptName
                "Premium "
                "Comm"
                "Bal. O/S (Prem + Comm)"
                "Cheque Return"
                "Suspense"
                "Net. A/r (Bal. O/S + Cheque Ret. + Sus. )"
                "Net. Other (ex. 'YP')"
                "����Թ 15 �ѹ"
                "16 - 30 �ѹ"
                "31 - 45 �ѹ"
                "46 - 60 �ѹ"
                "61 - 90 �ѹ"
                /*---A54-0119---
                "91 - 180 �ѹ"
                "181 - 270 �ѹ"
                "271 - 365 �ѹ"
                "365 �ѹ����"
                -------------*/
                /*---A54-0119---*/
                "91 - 120 �ѹ"
                "121 - 150 �ѹ"
                "151 - 180 �ѹ"
                "181 - 210 �ѹ"
                "211 - 240 �ѹ"
                "241 - 270 �ѹ"
                "271 - 300 �ѹ"
                "301 - 330 �ѹ"
                "331 - 365 �ѹ"
                "365 �ѹ����"
                /*---end A54-0119---*/
                "Group"
                "Customer Type".
        OUTPUT CLOSE.
       
         OUTPUT TO VALUE (n_OutputFileSum + "OSIC") NO-ECHO.  /* SUMMARY */
            RUN pdTitleSumOS.
            EXPORT DELIMITER ";"
                nv_RptName
                "Name"
                "Premium "
                "Comm"
                "Bal. O/S (Prem + Comm)"
                "Cheque Return"
                "Suspense"
                "Net. A/r (Bal. O/S + Cheque Ret. + Sus. )"
                "Net. Other (ex. 'YP')"
                "����Թ 15 �ѹ"
                "16 - 30 �ѹ"
                "31 - 45 �ѹ"
                "46 - 60 �ѹ"
                "61 - 90 �ѹ"
                /*---A54-0119---
                "91 - 180 �ѹ"
                "181 - 270 �ѹ"
                "271 - 365 �ѹ"
                "365 �ѹ����"
                -------------*/
                /*---A54-0119---*/
                "91 - 120 �ѹ"
                "121 - 150 �ѹ"
                "151 - 180 �ѹ"
                "181 - 210 �ѹ"
                "211 - 240 �ѹ"
                "241 - 270 �ѹ"
                "271 - 300 �ѹ"
                "301 - 330 �ѹ"
                "331 - 365 �ѹ"
                "365 �ѹ����"
                /*---end A54-0119---*/
                "Group"
                "Customer Type".
        OUTPUT CLOSE.
       
    END.  /* (nv_DetSum = "Summary")  OR (nv_DetSum = "All")  */


    IF to_type = NO THEN RUN pdAgentDet_po.  /*�к� Pol Type*/
    ELSE RUN pdAgentDet_to.

        /********************** Page Footer *********************/

        /*** export ������ŧ DETAIL FILE ��÷Ѵ Grand Total  ���  
                                    SUMMARY FILE ��÷Ѵ Grand Total ***/
   {wac\wacrl03.i}
           
    RELEASE agtprm_fil.

    IF (nv_DetSum = "Summary")  OR (nv_DetSum = "All") THEN DO:
         RUN pdAgentGp.
    END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdAgentDet_po C-Win 
PROCEDURE pdAgentDet_po :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
    loop_ac :
    FOR EACH  agtprm_fil   use-index by_agent WHERE
              agtprm_fil.asdat        = n_asdat     AND
             (agtprm_fil.agent       >= n_frac      AND agtprm_fil.agent   <= n_toac  ) AND
             (agtprm_fil.trndat      >= n_trndatFr  AND agtprm_fil.trndat  <= n_trndatTo) AND
             (agtprm_fil.polbran     >= n_branch    AND agtprm_fil.polbran <= n_branch2) AND
      (SUBSTR(agtprm_fil.policy,3,2) >= nv_poltypFr AND SUBSTR(agtprm_fil.policy,3,2) <= nv_poltypTo)  AND
      ( LOOKUP (SUBSTRING(agtprm_fil.trntyp,1,1) , nv_trntyp1) <> 0 )
    NO-LOCK BREAK  BY agtprm_fil.agent 
                   BY agtprm_fil.trndat
                   BY agtprm_fil.policy
                   BY agtprm_fil.endno. 
      
             DISP agtprm_fil.agent  FORMAT "X(10)"
                  agtprm_fil.trndat 
                  agtprm_fil.policy FORMAT "X(12)"
                  agtprm_fil.trntyp
                  agtprm_fil.docno
             WITH COLOR BLACK/WHITE NO-LABEL FRAME frProcess VIEW-AS DIALOG-BOX
             TITLE  "  Processing ...".
        
        n_asdat = IF nv_asdatAging = ? THEN n_asdat ELSE nv_asdatAging.
    /* Begin */
          /********************** Group Header *********************/
       
        IF FIRST-OF(agtprm_fil.agent)  THEN DO:  /**/
            nv_acname = "".
            FIND  xmm600 USE-INDEX xmm60001 
                         WHERE xmm600.acno = agtprm_fil.agent NO-LOCK NO-ERROR.
            IF AVAIL xmm600 THEN nv_acname = TRIM(xmm600.ntitle) + " " + TRIM(xmm600.name).
                            ELSE nv_acname = agtprm_fil.ac_name.

            /*--- DISPLAY DETAIL  ---*/
            IF (nv_DetSum = "Detail")  OR (nv_DetSum = "All") THEN DO:

               {wac\wacr0604.i}

                OUTPUT TO VALUE (STRING(n_OutputFile ) ) APPEND NO-ECHO.
                    EXPORT DELIMITER ";"
                    "Agent : " + agtprm_fil.Agent + " - " +  nv_acname  + "  " +
                    agtprm_fil.acno_clicod  + "  " +
                    "Type : " + agtprm_fil.type.
                OUTPUT CLOSE.
            
            END.  /*  (nv_DetSum = "Detail")  OR (nv_DetSum = "All") */

            RUN pdInitDataTot.  /* clear data in group*/
         
        END.  /* first-of(agtprm_fil.acno) */

        /****** �ӹǹ ��������´��� ��� display � File Detail   � dot i*****/
            {wac\wacrl01.i}
          
          /*** CREATE  WORK-TABLE for file SUMMARY GROUP CODE***/
             DO TRANSACTION:

                FIND FIRST wtOICsum USE-INDEX wtOICSum1 WHERE wtOICsum.wtICagent = agtprm_fil.agent AND
                                          wtOICsum.wtICpolgrp = nv_polgrp AND
                                          wtOICsum.wtICinsref = nv_insref NO-ERROR.
                IF NOT AVAIL wtOICsum THEN DO:
                CREATE wtOICSum.
                ASSIGN
                    wtICPrem = 0
                    wtICrptName = nv_RptName
                    wtICagent   = agtprm_fil.agent
                    wtICacname  = nv_acname
                    wtICpolgrp  = nv_polgrp
                    wtICpoltyp  = agtprm_fil.poltyp
                    wtICinsref  = nv_insref
                    wtICTPrem   = nv_premA  
                    wtICTcomm   = nv_commA  
                    wtICTbal    = nv_balA   
                    wtICTretc   = nv_retcA  
                    wtICTsusp   = nv_suspA  
                    wtICTnetar  = nv_netarA 
                    wtICTnetoth = nv_netothA
                    wtICPrem[lip] = nv_baldet[lip]
                    wtICComm[lip] = nv_comdet[lip]
                    wtICNet[lip] = nv_netdet[lip]
                    wtICRetc[lip] = nv_retcdet[lip]
                    wtICSusp[lip] = nv_suspdet[lip]
                    wtICNetar[lip] = nv_netardet[lip]
                    wtICBal[lip] = nv_balcdet[lip]
                    wtICNetoth[lip] = nv_Netothdet[lip].

                END.    /*if not avail wtOICsum */
                ELSE DO:
                    ASSIGN
                    wtICPrem[lip] = wtICPrem[lip] + nv_baldet[lip]
                    wtICcomm[lip] = wtICcomm[lip] + nv_comdet[lip]
                    wtICNet[lip]    = wtICNet[lip]    + nv_netdet[lip]        
                    wtICRetc[lip]   = wtICRetc[lip]   + nv_retcdet[lip]      
                    wtICSusp[lip]   = wtICSusp[lip]   + nv_suspdet[lip]      
                    wtICNetar[lip]  = wtICNetar[lip]  + nv_netardet[lip]    
                    wtICBal[lip]   = wtICBal[lip]   + nv_balcdet[lip]      
                    wtICNetoth[lip] = wtICNetoth[lip] + nv_Netothdet[lip]  
                    wtICTPrem     = wtICTPrem   + nv_premA  
                    wtICTcomm     = wtICTcomm   + nv_commA  
                    wtICTbal      = wtICTbal    + nv_balA   
                    wtICTretc     = wtICTretc   + nv_retcA  
                    wtICTsusp     = wtICTsusp   + nv_suspA  
                    wtICTnetar    = wtICTnetar  + nv_netarA 
                    wtICTnetoth   = wtICTnetoth + nv_netothA.
                   
                END.

             END. /*transaction*/
             
        /********************** Group Footer *********************/
          IF LAST-OF(agtprm_fil.agent)  THEN DO:  /**/
            ASSIGN
                nv_RptTyp1 = ""
                nv_RptTyp2 = ""
                nv_RptTyp1 = agtprm_fil.agent  /* ����¹仵�� ��Դ�ͧ report */
                nv_RptTyp2 = nv_acname.

            /*** �ӹǹ����� group, export ������ŧ SUMMARY FILE ���  �ӹǹ SUMMARY GRAND TOTAL***/
                {wac\wacrl02.i}
                /*---A53-0159---*/
                 FOR EACH wtDet NO-LOCK WHERE wtDet.wtDetagent = agtprm_fil.agent
                 BREAK BY wtDetAgent 
                       BY wtDetpolgrp
                       BY wtDetinsref:
                     OUTPUT TO VALUE (STRING(n_OutputFile ) ) APPEND NO-ECHO.
                     EXPORT DELIMITER ";"
                       "ToTal of " + wtDetagent + " - " + wtDetpolgrp + " - " + wtDetinsref
                       ""
                       ""
                       ""
                       ""
                       ""
                       ""
                       ""
                       ""
                       ""
                       ""
                       ""
                       wtDetprem
                       wtDetcomm
                       wtDetbal
                       wtDetretc
                       wtDetsusp
                       wtDetnetar
                       wtDetnetoth
                       /*---A54-0119---
                       wtDetbalDet[1 FOR 9]
                       ----*/
                       wtDetbalDet[1 FOR 15]
                       .
                    OUTPUT CLOSE.
                 END.
                 /*-----end A53-0159-------*/

          END. /*  LAST-OF(agtprm_fil.acno) */
       /* 
          vCount = vCount + 1.
          */
    END. /* for each agtprm_fil*/


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdAgentDet_to C-Win 
PROCEDURE pdAgentDet_to :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
nv_poltyp = "".

 IF rstype = 1 THEN DO:
    FOR EACH xmm031 NO-LOCK WHERE xmm031.dept = "M" OR 
                                   xmm031.dept = "G" 
     BREAK BY xmm031.poltyp:
        IF nv_poltyp = "" THEN ASSIGN nv_poltyp = xmm031.poltyp.
        ELSE ASSIGN nv_poltyp = nv_poltyp + "," + xmm031.poltyp .
    END.
 END.
 ELSE IF rstype = 2 THEN DO:
    FOR EACH xmm031 NO-LOCK WHERE xmm031.dept <> "M" OR 
                                  xmm031.dept <> "G" 
    BREAK BY xmm031.poltyp:
        IF nv_poltyp = "" THEN ASSIGN nv_poltyp = xmm031.poltyp.
        ELSE ASSIGN nv_poltyp = nv_poltyp + "," + xmm031.poltyp .
    END.
END.
ELSE DO:
    FOR EACH xmm031 NO-LOCK 
    BREAK BY xmm031.poltyp:
        IF nv_poltyp = "" THEN ASSIGN nv_poltyp = xmm031.poltyp.
        ELSE ASSIGN nv_poltyp = nv_poltyp + "," + xmm031.poltyp .
    END. 

END.
 
   loop_ac :
    FOR EACH  agtprm_fil   use-index by_agent WHERE
              agtprm_fil.asdat        = n_asdat     AND
             (agtprm_fil.agent       >= n_frac      AND agtprm_fil.agent   <= n_toac  ) AND
             (LOOKUP(agtprm_fil.poltyp,nv_poltyp) <> 0)    AND
             (agtprm_fil.trndat      >= n_trndatFr  AND agtprm_fil.trndat  <= n_trndatTo) AND
             (agtprm_fil.polbran     >= n_branch    AND agtprm_fil.polbran <= n_branch2) AND 
      ( LOOKUP (SUBSTRING(agtprm_fil.trntyp,1,1) , nv_trntyp1) <> 0 )
    NO-LOCK BREAK  BY agtprm_fil.agent 
                   BY agtprm_fil.trndat
                   BY agtprm_fil.policy
                   BY agtprm_fil.endno. 
    
             DISP agtprm_fil.agent  FORMAT "X(10)"
                  agtprm_fil.trndat 
                  agtprm_fil.policy FORMAT "X(12)"
                  agtprm_fil.trntyp
                  agtprm_fil.docno
             WITH COLOR BLACK/WHITE NO-LABEL FRAME frProcess VIEW-AS DIALOG-BOX
             TITLE  "  Processing ...".
        
        n_asdat = IF nv_asdatAging = ? THEN n_asdat ELSE nv_asdatAging.
    /* Begin */
          /********************** Group Header *********************/
       
        IF FIRST-OF(agtprm_fil.agent)  THEN DO:  /**/
            nv_acname = "".
            FIND  xmm600 USE-INDEX xmm60001 
                         WHERE xmm600.acno = agtprm_fil.agent NO-LOCK NO-ERROR.
            IF AVAIL xmm600 THEN nv_acname = TRIM(xmm600.ntitle) + " " + TRIM(xmm600.name).
                            ELSE nv_acname = agtprm_fil.ac_name.

            /*--- DISPLAY DETAIL  ---*/
            IF (nv_DetSum = "Detail")  OR (nv_DetSum = "All") THEN DO:

               {wac\wacr0604.i}

                OUTPUT TO VALUE (STRING(n_OutputFile ) ) APPEND NO-ECHO.
                    EXPORT DELIMITER ";"
                    "Agent : " + agtprm_fil.Agent + " - " +  nv_acname  + "  " +
                    agtprm_fil.acno_clicod  + "  " +
                    "Type : " + agtprm_fil.type.
                OUTPUT CLOSE.
            
            END.  /*  (nv_DetSum = "Detail")  OR (nv_DetSum = "All") */

            RUN pdInitDataTot.  /* clear data in group*/
         
        END.  /* first-of(agtprm_fil.acno) */

         RUN pdDeptGrp.   /*A53-0159*/

        /****** �ӹǹ ��������´��� ��� display � File Detail   � dot i*****/
            {wac\wacrl01.i}
          
          /*** CREATE  WORK-TABLE for file SUMMARY GROUP CODE***/
             DO TRANSACTION:

                FIND FIRST wtOICsum USE-INDEX wtOICSum1 WHERE wtOICsum.wtICagent = agtprm_fil.agent AND
                                          wtOICsum.wtICpolgrp = nv_polgrp AND
                                          wtOICsum.wtICinsref = nv_insref NO-ERROR.
                IF NOT AVAIL wtOICsum THEN DO:
                CREATE wtOICSum.
                ASSIGN
                    wtICPrem = 0
                    wtICrptName = nv_RptName
                    wtICagent   = agtprm_fil.agent
                    wtICacname  = nv_acname
                    wtICpolgrp  = nv_polgrp
                    wtICpoltyp  = agtprm_fil.poltyp
                    wtICinsref  = nv_insref
                    wtICTPrem   = nv_premA  
                    wtICTcomm   = nv_commA  
                    wtICTbal    = nv_balA   
                    wtICTretc   = nv_retcA  
                    wtICTsusp   = nv_suspA  
                    wtICTnetar  = nv_netarA 
                    wtICTnetoth = nv_netothA
                    wtICPrem[lip] = nv_baldet[lip]
                    wtICComm[lip] = nv_comdet[lip]
                    wtICNet[lip]    =  nv_netdet[lip]        
                    wtICRetc[lip]   =  nv_retcdet[lip]      
                    wtICSusp[lip]   =  nv_suspdet[lip]      
                    wtICNetar[lip]  =  nv_netardet[lip]    
                    wtICBal[lip]    =  nv_balcdet[lip]      
                    wtICNetoth[lip] =  nv_Netothdet[lip] .
                 
                END.    /*if not avail wtOICsum */
                ELSE DO:
                    ASSIGN
                    wtICPrem[lip] = wtICPrem[lip] + nv_baldet[lip]
                    wtICComm[lip] = wtICCom[lip] + nv_comdet[lip]
                    wtICNet[lip]    = wtICNet[lip]    + nv_netdet[lip]        
                    wtICRetc[lip]   = wtICRetc[lip]   + nv_retcdet[lip]      
                    wtICSusp[lip]   = wtICSusp[lip]   + nv_suspdet[lip]      
                    wtICNetar[lip]  = wtICNetar[lip]  + nv_netardet[lip]    
                    wtICBal[lip]   = wtICBal[lip]   + nv_balcdet[lip]      
                    wtICNetoth[lip] = wtICNetoth[lip] + nv_Netothdet[lip] 
                    wtICTPrem     = wtICTPrem   + nv_premA  
                    wtICTcomm     = wtICTcomm   + nv_commA  
                    wtICTbal      = wtICTbal    + nv_balA   
                    wtICTretc     = wtICTretc   + nv_retcA  
                    wtICTsusp     = wtICTsusp   + nv_suspA  
                    wtICTnetar    = wtICTnetar  + nv_netarA 
                    wtICTnetoth   = wtICTnetoth + nv_netothA.
                   
                END.

             END. /*transaction*/
             
        /********************** Group Footer *********************/
          IF LAST-OF(agtprm_fil.agent)  THEN DO:  /**/
            ASSIGN
                nv_RptTyp1 = ""
                nv_RptTyp2 = ""
                nv_RptTyp1 = agtprm_fil.agent  /* ����¹仵�� ��Դ�ͧ report */
                nv_RptTyp2 = nv_acname.

            /*** �ӹǹ����� group, export ������ŧ SUMMARY FILE ���  �ӹǹ SUMMARY GRAND TOTAL***/
                {wac\wacrl02.i}
                /*---A53-0159---*/
                 FOR EACH wtDet NO-LOCK WHERE wtDet.wtDetagent = agtprm_fil.agent
                 BREAK BY wtDetAgent 
                       BY wtDetpolgrp
                       BY wtDetinsref:
                     OUTPUT TO VALUE (STRING(n_OutputFile ) ) APPEND NO-ECHO.
                     EXPORT DELIMITER ";"
                       "ToTal of " + wtDetagent + " - " + wtDetpolgrp + " - " + wtDetinsref
                       ""
                       ""
                       ""
                       ""
                       ""
                       ""
                       ""
                       ""
                       ""
                       ""
                       ""
                       wtDetprem
                       wtDetcomm
                       wtDetbal
                       wtDetretc
                       wtDetsusp
                       wtDetnetar
                       wtDetnetoth
                       /*---A54-0119---
                       wtDetbalDet[1 FOR 9]
                       ------------*/
                        wtDetbalDet[1 FOR 15]
                       .
                    OUTPUT CLOSE.
                 END.
                 /*-----end A53-0159-------*/

          END. /*  LAST-OF(agtprm_fil.acno) */
          /*
          vCount = vCount + 1.
          */
    END. /* for each agtprm_fil*/
         


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdAgentGp C-Win 
PROCEDURE pdAgentGp :
/*------------------------------------------------------------------------------
  Purpose:     �¡��� summary  BREAK BY group code
  Parameters:  <none>
  Notes:        field  xmm600.gpage
------------------------------------------------------------------------------*/
DEF VAR agpname AS CHAR.

ASSIGN nv_GTTprem     = 0
       nv_GTTcomm     = 0
       nv_GTTbal      = 0 
       nv_GTTretc     = 0
       nv_GTTsusp     = 0
       nv_GTTnetar    = 0 
       nv_GTTnetoth   = 0
       nv_GTprem      = 0 .

    OUTPUT TO VALUE (n_OutputFile + "sumIC") NO-ECHO.  /* SUMMARY */
        RUN pdTitleSum.
        RUN pdPageHeadSum.
        OUTPUT CLOSE.

        FOR EACH wtoicSum BREAK BY wtICAgent 
                                BY wtICpolgrp
                                BY wtICinsref:

            IF FIRST-OF(wtoicSum.wtICAgent) THEN DO:
                FIND FIRST xmm600 USE-INDEX xmm60001 
                                  WHERE xmm600.acno = wtoicSum.wtICAgent NO-LOCK NO-ERROR.
                IF AVAIL xmm600 THEN agpname = xmm600.name.  /* ���� ��ѡ�ҹ ����Թ */
                ELSE agpname = "".
 
                OUTPUT TO VALUE (n_OutputFile + "sumIC") APPEND NO-ECHO.  /* SUMMARY */    
                    EXPORT DELIMITER ";" "".
                    EXPORT DELIMITER ";" "AGENT CODE : " + wtICAgent + " - " +  agpname.
                    EXPORT DELIMITER ";" FILL("-",100).
                OUTPUT CLOSE.
            END.

            /*----A54-0119---
            OUTPUT TO VALUE (n_OutputFile + "sumIC") APPEND NO-ECHO.  /* SUMMARY */    
                EXPORT DELIMITER ";"  "Summary of : " + wtICrptname + " " + wtICAgent + " - " + wtICacname + " :: " + wtICpolgrp + " :: " + wtICinsref.     
                EXPORT DELIMITER ";"  wtICrptname + " Premium"          wtICTprem   wtICprem[1 FOR 9].  
                EXPORT DELIMITER ";"  wtICrptname + " Commission"       wtICTcomm   wtICcomm[1 FOR 9].  
                EXPORT DELIMITER ";"  wtICrptname + " Bal. O/S"         wtICTbal    wtICbal[1 FOR 9].  
                EXPORT DELIMITER ";"  wtICrptname + " Cheque Returned"  wtICTretc   wtICretc[1 FOR 9].  
                EXPORT DELIMITER ";"  wtICrptname + " Suspense"         wtICTsusp   wtICsusp[1 FOR 9].  
                EXPORT DELIMITER ";"  wtICrptname + " Net. A/R"         wtICTnetar  wtICnetar[1 FOR 9]. 
                EXPORT DELIMITER ";"  wtICrptname + " Net. OTHER"       wtICTnetoth wtICnetoth[1 FOR 9].
                EXPORT DELIMITER ";" "Summary of : " + wtICrptname + " " + wtICAgent + " :: " + wtICpolgrp + " :: " + wtICinsref    
                        "����Թ 15 �ѹ" + STRING(wtICprem[1]  ,">>,>>>,>>>,>>9.99-") + nv-1 + 
                        "16 - 30 �ѹ"    + STRING(wtICprem[2]  ,">>,>>>,>>>,>>9.99-") + nv-1 + 
                        "31 - 45 �ѹ"    + STRING(wtICprem[3]  ,">>,>>>,>>>,>>9.99-") + nv-1 + 
                        "46 - 60 �ѹ"    + STRING(wtICprem[4]  ,">>,>>>,>>>,>>9.99-") + nv-1 +
                        "61 - 90 �ѹ"    + STRING(wtICprem[5]  ,">>,>>>,>>>,>>9.99-") + nv-1 +
                        "91 - 180 �ѹ"   + STRING(wtICprem[6]  ,">>,>>>,>>>,>>9.99-") + nv-1 +
                        "181 - 270 �ѹ"  + STRING(wtICprem[7]  ,">>,>>>,>>>,>>9.99-") + nv-1 +
                        "271 - 365 �ѹ"  + STRING(wtICprem[8]  ,">>,>>>,>>>,>>9.99-") + nv-1 +        
                        "365 �ѹ����"  + STRING(wtICprem[9]  ,">>,>>>,>>>,>>9.99-") .
                EXPORT DELIMITER ";" "".
             OUTPUT CLOSE.
             -------------------------*/
             /*----A54-0119---*/
            OUTPUT TO VALUE (n_OutputFile + "sumIC") APPEND NO-ECHO.  /* SUMMARY */    
                EXPORT DELIMITER ";"  "Summary of : " + wtICrptname + " " + wtICAgent + " - " + wtICacname + " :: " + wtICpolgrp + " :: " + wtICinsref.     
                EXPORT DELIMITER ";"  wtICrptname + " Premium"          wtICTprem   wtICprem[1 FOR 15].  
                EXPORT DELIMITER ";"  wtICrptname + " Commission"       wtICTcomm   wtICcomm[1 FOR 15].  
                EXPORT DELIMITER ";"  wtICrptname + " Bal. O/S"         wtICTbal    wtICbal[1 FOR 15].  
                EXPORT DELIMITER ";"  wtICrptname + " Cheque Returned"  wtICTretc   wtICretc[1 FOR 15].  
                EXPORT DELIMITER ";"  wtICrptname + " Suspense"         wtICTsusp   wtICsusp[1 FOR 15].  
                EXPORT DELIMITER ";"  wtICrptname + " Net. A/R"         wtICTnetar  wtICnetar[1 FOR 15]. 
                EXPORT DELIMITER ";"  wtICrptname + " Net. OTHER"       wtICTnetoth wtICnetoth[1 FOR 15].
                EXPORT DELIMITER ";" "Summary of : " + wtICrptname + " " + wtICAgent + " :: " + wtICpolgrp + " :: " + wtICinsref    
                        "����Թ 15 �ѹ" + STRING(wtICprem[1]  ,">>,>>>,>>>,>>9.99-") + nv-1 + 
                        "16 - 30 �ѹ"    + STRING(wtICprem[2]  ,">>,>>>,>>>,>>9.99-") + nv-1 + 
                        "31 - 45 �ѹ"    + STRING(wtICprem[3]  ,">>,>>>,>>>,>>9.99-") + nv-1 + 
                        "46 - 60 �ѹ"    + STRING(wtICprem[4]  ,">>,>>>,>>>,>>9.99-") + nv-1 +
                        "61 - 90 �ѹ"    + STRING(wtICprem[5]  ,">>,>>>,>>>,>>9.99-") + nv-1 +
                        "91 - 120 �ѹ"   + STRING(wtICprem[6]  ,">>,>>>,>>>,>>9.99-") + nv-1 +
                        "121 - 150 �ѹ"  + STRING(wtICprem[7]  ,">>,>>>,>>>,>>9.99-") + nv-1 +
                        "151 - 180 �ѹ"  + STRING(wtICprem[8]  ,">>,>>>,>>>,>>9.99-") + nv-1 +        
                        "181 - 210 �ѹ"  + STRING(wtICprem[9]  ,">>,>>>,>>>,>>9.99-") + nv-1 +
                        "211 - 240 �ѹ"  + STRING(wtICprem[10]  ,">>,>>>,>>>,>>9.99-") + nv-1 + 
                        "241 - 270 �ѹ"  + STRING(wtICprem[11]  ,">>,>>>,>>>,>>9.99-") + nv-1 + 
                        "271 - 300 �ѹ"  + STRING(wtICprem[12]  ,">>,>>>,>>>,>>9.99-") + nv-1 + 
                        "301 - 330 �ѹ"  + STRING(wtICprem[13]  ,">>,>>>,>>>,>>9.99-") + nv-1 +
                        "331 - 365 �ѹ"  + STRING(wtICprem[14]  ,">>,>>>,>>>,>>9.99-") + nv-1 +
                        "365 �ѹ����"  + STRING(wtICprem[15]  ,">>,>>>,>>>,>>9.99-").
                EXPORT DELIMITER ";" "".
             OUTPUT CLOSE.
             /*--- end A54-0119 ---*/

             OUTPUT TO VALUE (n_OutputFileSum + "OSIC") APPEND NO-ECHO.  /* SUMMARY */
               EXPORT DELIMITER ";"
               wtoicSum.wtICAgent
               wtICacname     
               wtICTprem      /*"Premium "*/
               wtICTcomm      /*"Comm"*/
               wtICTbal       /*"Bal. O/S"*/
               wtICTretc      /* cheque return */
               wtICTsusp      /* suspense */
               wtICTnetar     /* net. a/r */
               wtICTnetoth    /* net. other */
               wtICprem[1] 
               wtICprem[2]
               wtICprem[3]
               wtICprem[4]
               wtICprem[5]
               wtICprem[6]
               wtICprem[7]
               wtICprem[8]
               wtICprem[9]
               /*---A54-0119---*/
               wtICprem[10]
               wtICprem[11]
               wtICprem[12]
               wtICprem[13]
               wtICprem[14]
               wtICprem[15]
               /*--A54-0119---*/
               wtICpolgrp
               wtICinsref
               .
           OUTPUT CLOSE.
           
            ASSIGN 
            nv_GTTprem     =    nv_GTTprem    +  wtICTprem      
            nv_GTTcomm     =    nv_GTTcomm    +  wtICTcomm      
            nv_GTTbal      =    nv_GTTbal     +  wtICTbal       
            nv_GTTretc     =    nv_GTTretc    +  wtICTretc      
            nv_GTTsusp     =    nv_GTTsusp    +  wtICTsusp      
            nv_GTTnetar    =    nv_GTTnetar   +  wtICTnetar     
            nv_GTTnetoth   =    nv_GTTnetoth  +  wtICTnetoth    
            nv_GTprem[1]   =    nv_GTprem[1]  +  wtICprem[1]                          
            nv_GTprem[2]   =    nv_GTprem[2]  +  wtICprem[2]                          
            nv_GTprem[3]   =    nv_GTprem[3]  +  wtICprem[3]                          
            nv_GTprem[4]   =    nv_GTprem[4]  +  wtICprem[4]                          
            nv_GTprem[5]   =    nv_GTprem[5]  +  wtICprem[5]                          
            nv_GTprem[6]   =    nv_GTprem[6]  +  wtICprem[6]                          
            nv_GTprem[7]   =    nv_GTprem[7]  +  wtICprem[7]                          
            nv_GTprem[8]   =    nv_GTprem[8]  +  wtICprem[8]                          
            nv_GTprem[9]   =    nv_GTprem[9]  +  wtICprem[9]   
            /*---A54-0119---*/
            nv_GTprem[10]   =    nv_GTprem[10]  +  wtICprem[10]                          
            nv_GTprem[11]   =    nv_GTprem[11]  +  wtICprem[11]                          
            nv_GTprem[12]   =    nv_GTprem[12]  +  wtICprem[12]                          
            nv_GTprem[13]   =    nv_GTprem[13]  +  wtICprem[13]                          
            nv_GTprem[14]   =    nv_GTprem[14]  +  wtICprem[14]                          
            nv_GTprem[15]   =    nv_GTprem[15]  +  wtICprem[15]  
           .                                    

        END.  

        /*---A54-0119---
        OUTPUT TO VALUE (n_OutputFile + "sumIC") APPEND NO-ECHO.  /* SUMMARY */    
        EXPORT DELIMITER ";"  "".
        EXPORT DELIMITER ";"  "".
        EXPORT DELIMITER ";"  "G R A N D  T O T A L".
        EXPORT DELIMITER ";"  "Grand Premium"           nv_GTTprem      nv_GTprem[1 FOR 9].  
        EXPORT DELIMITER ";"  "Grand Commission"        nv_GTTcomm      nv_GTcomm[1 FOR 9].
        EXPORT DELIMITER ";"  "Grand Bal. O/S"          nv_GTTbal       nv_GTbal[1 FOR 9].   
        EXPORT DELIMITER ";"  "Grand Cheque Returned"   nv_GTTretc      nv_GTretc[1 FOR 9].
        EXPORT DELIMITER ";"  "Grand Suspense"          nv_GTTsusp      nv_GTsusp[1 FOR 9].  
        EXPORT DELIMITER ";"  "Grand Net. A/R"          nv_GTTnetar     nv_GTnetar[1 FOR 9].
        EXPORT DELIMITER ";"  "Grand Net. OTHER"        nv_GTTnetoth    nv_GTnetoth[1 FOR 9]. 
        EXPORT DELIMITER ";"  "".
        EXPORT DELIMITER ";" "G R A N D  T O T A L"
                "����Թ 15 �ѹ" + STRING(nv_GTprem[1] ,">>,>>>,>>>,>>9.99-") + nv-1 +     
                "16 - 30 �ѹ"    + STRING(nv_GTprem[2] ,">>,>>>,>>>,>>9.99-") + nv-1 +     
                "31 - 45 �ѹ"    + STRING(nv_GTprem[3] ,">>,>>>,>>>,>>9.99-") + nv-1 +  
                "46 - 60 �ѹ"   + STRING(nv_GTprem[4] ,">>,>>>,>>>,>>9.99-") + nv-1 +           
                "61 - 90 �ѹ"  + STRING(nv_GTprem[5] ,">>,>>>,>>>,>>9.99-") + nv-1 +     
                "91 - 180 �ѹ"  + STRING(nv_GTprem[6] ,">>,>>>,>>>,>>9.99-") + nv-1 +     
                "181 - 270 �ѹ"  + STRING(nv_GTprem[7] ,">>,>>>,>>>,>>9.99-") + nv-1 +  
                "271 - 365 �ѹ"  + STRING(nv_GTprem[8] ,">>,>>>,>>>,>>9.99-") + nv-1 +           
                "365 �ѹ����"  + STRING(nv_GTprem[9] ,">>,>>>,>>>,>>9.99-") .
                /*---Lukkana M. A52-0318 26/11/2009---*/

    OUTPUT CLOSE.
    -------------*/
        OUTPUT TO VALUE (n_OutputFile + "sumIC") APPEND NO-ECHO.  /* SUMMARY */    
        EXPORT DELIMITER ";"  "".
        EXPORT DELIMITER ";"  "".
        EXPORT DELIMITER ";"  "G R A N D  T O T A L".
        EXPORT DELIMITER ";"  "Grand Premium"           nv_GTTprem      nv_GTprem[1 FOR 15].  
        EXPORT DELIMITER ";"  "Grand Commission"        nv_GTTcomm      nv_GTcomm[1 FOR 15].
        EXPORT DELIMITER ";"  "Grand Bal. O/S"          nv_GTTbal       nv_GTbal[1 FOR 15].   
        EXPORT DELIMITER ";"  "Grand Cheque Returned"   nv_GTTretc      nv_GTretc[1 FOR 15].
        EXPORT DELIMITER ";"  "Grand Suspense"          nv_GTTsusp      nv_GTsusp[1 FOR 15].  
        EXPORT DELIMITER ";"  "Grand Net. A/R"          nv_GTTnetar     nv_GTnetar[1 FOR 15].
        EXPORT DELIMITER ";"  "Grand Net. OTHER"        nv_GTTnetoth    nv_GTnetoth[1 FOR 15]. 
        EXPORT DELIMITER ";"  "".
        EXPORT DELIMITER ";" "G R A N D  T O T A L"
                "����Թ 15 �ѹ" + STRING(nv_GTprem[1] ,">>,>>>,>>>,>>9.99-") + nv-1 +     
                "16 - 30 �ѹ"    + STRING(nv_GTprem[2] ,">>,>>>,>>>,>>9.99-") + nv-1 +     
                "31 - 45 �ѹ"    + STRING(nv_GTprem[3] ,">>,>>>,>>>,>>9.99-") + nv-1 +  
                "46 - 60 �ѹ"   + STRING(nv_GTprem[4] ,">>,>>>,>>>,>>9.99-") + nv-1 +           
                "61 - 90 �ѹ"   + STRING(nv_GTprem[5] ,">>,>>>,>>>,>>9.99-") + nv-1 +     
                "91 - 120 �ѹ"   + STRING(nv_GTprem[6] ,">>,>>>,>>>,>>9.99-") + nv-1 +     
                "121 - 150 �ѹ"   + STRING(nv_GTprem[7] ,">>,>>>,>>>,>>9.99-") + nv-1 +  
                "151 - 180 �ѹ"   + STRING(nv_GTprem[8] ,">>,>>>,>>>,>>9.99-") + nv-1 +           
                "181 - 210 �ѹ"   + STRING(nv_GTprem[9] ,">>,>>>,>>>,>>9.99-") + nv-1 +
                "211 - 240 �ѹ"   + STRING(nv_GTprem[10] ,">>,>>>,>>>,>>9.99-") + nv-1 +   
                "241 - 270 �ѹ"   + STRING(nv_GTprem[11] ,">>,>>>,>>>,>>9.99-") + nv-1 +  
                "271 - 300 �ѹ"   + STRING(nv_GTprem[12] ,">>,>>>,>>>,>>9.99-") + nv-1 +  
                "301 - 330 �ѹ"   + STRING(nv_GTprem[13] ,">>,>>>,>>>,>>9.99-") + nv-1 +   
                "331 - 365 �ѹ"    + STRING(nv_GTprem[14] ,">>,>>>,>>>,>>9.99-") + nv-1 +  
                "365 �ѹ����"    + STRING(nv_GTprem[15] ,">>,>>>,>>>,>>9.99-").
    OUTPUT CLOSE.

      OUTPUT TO VALUE (n_OutputFileSum + "OSIC") APPEND NO-ECHO.  /* SUMMARY */
               EXPORT DELIMITER ";"
               "Grand Total : "
               ""
               nv_GTTprem      /*"Premium "*/
               nv_GTTcomm     /*"Comm"*/
               nv_GTTbal       /*"Bal. O/S"*/
               nv_GTTretc      /* cheque return */
               nv_GTTsusp      /* suspense */
               nv_GTTnetar     /* net. a/r */
               nv_GTTnetoth    /* net. other */
               nv_GTprem[1] 
               nv_GTprem[2]
               nv_GTprem[3]
               nv_GTprem[4]
               nv_GTprem[5]
               nv_GTprem[6]
               nv_GTprem[7]
               nv_GTprem[8]
               nv_GTprem[9]
               /*---A54-0119---*/
               nv_GTprem[10] 
               nv_GTprem[11] 
               nv_GTprem[12] 
               nv_GTprem[13] 
               nv_GTprem[14] 
               nv_GTprem[15] 
               /*---------------*/
               .
           OUTPUT CLOSE.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdCrtwtDet C-Win 
PROCEDURE pdCrtwtDet :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

IF nv_RptName = "agent" THEN DO:
  
    FIND FIRST wtDet USE-INDEX wtDet1 WHERE wtDet.wtDetAgent = agtprm_fil.agent AND
                           wtDet.wtDetpolgrp = nv_polgrp NO-ERROR.
    IF NOT AVAIL wtDet THEN DO:
        CREATE wtDet.
        ASSIGN wtDet.wtDetbaldet = 0
               wtDet.wtDetAgent  = agtprm_fil.agent  
               wtDet.wtDetpolgrp = nv_polgrp  
               wtDet.wtDetpoltyp = agtprm_fil.poltyp
               wtDet.wtDetinsref = nv_insref
               wtDet.wtDETprem   = nv_premA  
               wtDet.wtDETcomm   = nv_commA 
               wtDet.wtDetBal    = nv_balA  
               wtDet.wtDETretc   = nv_retcA 
               wtDet.wtDETsusp   = nv_suspA   
               wtDet.wtDETnetar  = nv_netarA 
               wtDet.wtDetnetoth = nv_netothA 
               wtDet.wtDETbaldet[lip]  =  nv_baldet[lip]
            .
          /*
          i = 1.
            DO i = 1 to 9 : 
               ASSIGN
                    wtDet.wtDETbaldet[lip]  =  nv_premA.
            END.
            */
          
            
    END.
    ELSE DO:
        ASSIGN wtDet.wtDETprem   = wtDet.wtDETprem     +  nv_premA  
               wtDet.wtDETcomm   = wtDet.wtDETcomm     +  nv_commA 
               wtDet.wtDetBal    = wtDet.wtDetBal      +  nv_balA  
               wtDet.wtDETretc   = wtDet.wtDETretc     +  nv_retcA 
               wtDet.wtDETsusp   = wtDet.wtDETsusp     +  nv_suspA   
               wtDet.wtDETnetar  = wtDet.wtDETnetar    +  nv_netarA 
               wtDet.wtDetnetoth = wtDet.wtDetnetoth   +  nv_netothA 
               wtDet.wtDetbaldet[lip]  =  wtDet.wtdetbaldet[lip]  +  nv_baldet[lip]
            .
         
    END.
    
END.
ELSE IF nv_RptName = "Line" THEN DO:

 FIND FIRST wtDet USE-INDEX wtDet2 WHERE wtDet.wtDetpoltyp = agtprm_fil.poltyp AND
                        wtDet.wtDetpolgrp = nv_polgrp AND
                        wtDet.wtDetinsref = nv_insref NO-ERROR.
    IF NOT AVAIL wtDet THEN DO:
        CREATE wtDet.
        ASSIGN wtDet.wtDetAgent  = agtprm_fil.agent  
               wtDet.wtDetpolgrp = nv_polgrp  
               wtDet.wtDetpoltyp = agtprm_fil.poltyp
               wtDet.wtDetinsref = nv_insref
               wtDet.wtDETprem   = nv_premA  
               wtDet.wtDETcomm   = nv_commA 
               wtDet.wtDetBal    = nv_balA  
               wtDet.wtDETretc   = nv_retcA 
               wtDet.wtDETsusp   = nv_suspA   
               wtDet.wtDETnetar  = nv_netarA 
               wtDet.wtDetnetoth = nv_netothA 
               
            .
             /*
            i = 1.
            DO i = 1 to 9 : 
               ASSIGN
                    wtDETbaldet[i]  = nv_balDet[i].
            END.
            */
    END.
    ELSE DO:
        ASSIGN wtDet.wtDETprem   = wtDet.wtDETprem     +   nv_premA  
               wtDet.wtDETcomm   = wtDet.wtDETcomm     +  nv_commA 
               wtDet.wtDetBal    = wtDet.wtDetBal      +  nv_balA  
               wtDet.wtDETretc   = wtDet.wtDETretc     +  nv_retcA 
               wtDet.wtDETsusp   = wtDet.wtDETsusp     +  nv_suspA   
               wtDet.wtDETnetar  = wtDet.wtDETnetar    +  nv_netarA 
               wtDet.wtDetnetoth = wtDet.wtDetnetoth   +  nv_netothA
              
             .
         /*
         i = 1.
            DO i = 1 to 9 : 
               ASSIGN
                    wtDETbaldet[i]  = wtDETbaldet[i] + nv_balDet[i].
            END.
            */
    END.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdDeptGrp C-Win 
PROCEDURE pdDeptGrp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN nv_polgrp = ""
       nv_insref = "".

FIND FIRST xmm031 WHERE xmm031.poltyp = agtprm_fil.poltyp NO-LOCK.
IF AVAIL xmm031 THEN DO:
    IF xmm031.dept = "G" OR xmm031.dept = "M" THEN DO:   /*Motor*/
       IF xmm031.dept = "G" THEN nv_polgrp = "MOT".
       ELSE  nv_polgrp = "CMP".

       FIND FIRST acm001 USE-INDEX acm00101 WHERE 
                  acm001.trnty1 = SUBSTR(agtprm_fil.trntyp,1,1) AND
                  acm001.docno  = agtprm_fil.docno NO-LOCK NO-ERROR.
       IF AVAIL acm001 THEN DO:
          IF LENGTH(acm001.insref) = 7 THEN DO:
             IF SUBSTR((acm001.insref),2,1) = "C" THEN nv_insref = "Coperate".   /*Customer Type = Corperate */
             ELSE  nv_insref = "Personal". 
          END.
          ELSE DO:
             IF SUBSTR((acm001.insref),3,1) = "C" THEN nv_insref = "Coperate".   /*Customer Type = Corperate */
             ELSE nv_insref = "Personal".   /*Customer Type = Personal */
          END.
       END.
    END.
    ELSE DO:
        ASSIGN  nv_insref = "None"
                nv_polgrp = "NON".
    END.
END.


                    
/* end xmm031*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdForGrpCode C-Win 
PROCEDURE pdForGrpCode :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

DEF BUFFER bxmm600 FOR xmm600.
DEF VAR vgpname AS CHAR.

    FOR EACH wtGrpCode: DELETE wtGrpCode. END.

    FOR EACH   xmm600 USE-INDEX xmm60001 
        WHERE (xmm600.acno >= n_frac) AND (xmm600.acno <= n_toac) AND
              (xmm600.acccod = "AG") OR (xmm600.acccod  = "BR"  )
    NO-LOCK:
    
        FIND FIRST bxmm600 USE-INDEX xmm60001 
             WHERE bxmm600.acno = xmm600.gpage NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL bxmm600 THEN vgpname = bxmm600.name.  /* ���� ��ѡ�ҹ ����Թ */
                         ELSE vgpname = "".
        CREATE wtGrpCode.
        ASSIGN
            wtGrpCode.wtGpage   = xmm600.gpage
            wtGrpCode.wtGpname  = vgpname
            wtGrpCode.wtacno    = xmm600.acno
            wtGrpCode.wtname    = xmm600.name.
    END.  /* for each xmm600*/

    OUTPUT TO VALUE (n_OutputFile + "G") .
        EXPORT DELIMITER ";"
        "Group Code" "Name" "Acno" "Ac. Name".

        FOR EACH wtGrpCode USE-INDEX wtGrpCode1 :
            EXPORT DELIMITER ";" wtGrpCode.
        END.

    OUTPUT CLOSE.

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdInitDataG C-Win 
PROCEDURE pdInitDataG :
/*------------------------------------------------------------------------------
  Purpose:      use in Procedure pdAcnoDet, pdBranchDet, pdLineDet :
  Parameters:  <none>
  Notes:       clear ��� grand total
------------------------------------------------------------------------------*/
ASSIGN
/*--- In File Detail ---*/
        nv_gtot_prem = 0
        nv_gtot_prem_comp = 0
        nv_gtot_stamp = 0
        nv_gtot_tax   = 0
        nv_gtot_gross = 0
        nv_gtot_comm  = 0
        nv_gtot_comm_comp = 0
        nv_gtot_net   = 0
        nv_gtot_netar = 0
        nv_gtot_bal   = 0
        
        nv_gtot_wcr   = 0
        nv_gtot_damt  = 0
        nv_gtot_odue1 = 0
        nv_gtot_odue2 = 0
        nv_gtot_odue3 = 0
        nv_gtot_odue4 = 0
        nv_gtot_odue5 = 0

        nv_gtot_balDet = 0
        
        nv_gtot_retc   = 0
        nv_gtot_susp   = 0
        nv_gtot_netoth = 0

/*--- In File Summary ---*/     /*---  Initial Value array [i] ---*/
        nv_GTprem  = 0
        nv_GTtax   = 0
        nv_GTvat   = 0
        nv_GTsbt   = 0
        nv_GTstamp = 0
        nv_GTtotal = 0
        nv_GTcomm  = 0
        nv_GTnet   = 0
        nv_GTbal   = 0

        nv_GTretc  = 0
        nv_GTsusp  = 0
        nv_GTnetar = 0
        nv_GTnetoth = 0

        nv_GTTprem   = 0
        nv_GTTtax    = 0
        nv_GTTvat    = 0
        nv_GTTsbt    = 0
        nv_GTTstamp  = 0
        nv_GTTtotal  = 0
        nv_GTTcomm   = 0
        nv_GTTnet    = 0
        nv_GTTbal    = 0

        nv_GTTretc   = 0
        nv_GTTsusp   = 0
        nv_GTTnetar  = 0
        nv_GTTnetoth = 0
        .

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdInitDataTot C-Win 
PROCEDURE pdInitDataTot :
/*------------------------------------------------------------------------------
  Purpose:      use in Procedure pdAcnoDet, pdBranchDet, pdLineDet :
  Parameters:  <none>
  Notes:       clear ��� summary
------------------------------------------------------------------------------*/
     ASSIGN
     /*---  Initial Value total �  file summary   ---*/
        nv_tot_prem  = 0
        nv_tot_prem_comp = 0
        nv_tot_stamp = 0
        nv_tot_tax   = 0
        nv_tot_gross = 0
        nv_tot_comm  = 0
        nv_tot_comm_comp = 0
        nv_tot_net   = 0
        nv_tot_bal   = 0

        nv_tot_retc  = 0 
        nv_tot_susp  = 0 
        nv_tot_netar = 0
        nv_tot_netoth = 0
        nv_tot_balDet = 0
             
     /*---  Initial Value array [i] ������ file summary    "Summary of : " ---*/
        nv_Tprem  = 0
        nv_Ttax   = 0
        nv_Tvat   = 0
        nv_Tsbt   = 0
        nv_Tstamp = 0
        nv_Ttotal = 0
        nv_Tcomm  = 0
        nv_Tnet   = 0
        nv_Tbal   = 0
        nv_Tretc  = 0
        nv_Tsusp  = 0
        nv_Tnetar = 0
        nv_Tnetoth = 0
        nv_TTprem  = 0
        nv_TTtax   = 0
        nv_TTvat   = 0
        nv_TTsbt   = 0
        nv_TTstamp = 0
        nv_TTtotal = 0
        nv_TTcomm  = 0
        nv_TTnet   = 0
        nv_TTbal   = 0
        nv_TTretc  = 0
        nv_TTsusp  = 0
        nv_TTnetar = 0
        nv_TTnetoth  = 0
        .

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdLineDet C-Win 
PROCEDURE pdLineDet :
/*------------------------------------------------------------------------------
  Purpose: Ageing Detail  By Line
------------------------------------------------------------------------------*/

DEF VAR  vCount AS INT INIT 0.
DEF VAR  i AS INT.

nv-1 = FILL(" ",5).

/* delete  work-table */
FOR EACH wtGrpCode:  DELETE wtGrpCode.  END.
FOR EACH wtGrpSum:   DELETE wtGrpSum.  END.
FOR EACH wtOICSum:   DELETE wtOICSum.  END.
FOR EACH wtDet:      DELETE wtDet.     END.

    RUN pdInitDataG.  /* clear ��� GRAND TOTAL ��� file detail ,  summary */

    ASSIGN
        nv_reccnt = 0
        nv_next   = 1
        n_OutputFile = n_OutputFile + STRING(nv_next).

      /**************** Page Header ***********/
/*--- DISPLAY DETAIL  ---*/
    IF (nv_DetSum = "Detail")  OR (nv_DetSum = "All") THEN DO:
        OUTPUT TO VALUE (n_OutputFile ) NO-ECHO.
            RUN pdTitleDet.     /*RUN pdPageHead.*/
            RUN pdPageHeadDet.
        OUTPUT CLOSE.
            nv_reccnt = nv_reccnt + 5 .
    END.  /* (nv_DetSum = "Detail")  OR (nv_DetSum = "All") */

/*** DISPLAY SUMMARY FILE & SUMMARY GRAND TOTAL***/
    IF (nv_DetSum = "Summary")  OR (nv_DetSum = "All") THEN DO:
        OUTPUT TO VALUE (n_OutputFileSum) NO-ECHO.  /* SUMMARY */
            RUN pdTitleSum.
            RUN pdPageHeadSum.
        OUTPUT CLOSE.

        OUTPUT TO VALUE (n_OutputFileSum + "OS") NO-ECHO.  /* SUMMARY */
            RUN pdTitleSumOS.
            EXPORT DELIMITER ";"
            nv_RptName
            "Premium "
            "Comm"
            "Bal. O/S (Prem + Comm)"
            "Cheque Return"
            "Suspense"
            "Net. A/r (Bal. O/S + Cheque Ret. + Sus. )"
            "Net. Other (ex. 'YP')"
            "����Թ 15 �ѹ"
            "16 - 30 �ѹ"
            "31 - 45 �ѹ"
            "46 - 60 �ѹ"
            "61 - 90 �ѹ"
            /*---A54-0119---         
            "91 - 180 �ѹ"           
            "181 - 270 �ѹ"          
            "271 - 365 �ѹ"          
            "365 �ѹ����"          
            -------------*/          
            /*---A54-0119---*/       
            "91 - 120 �ѹ"           
            "121 - 150 �ѹ"          
            "151 - 180 �ѹ"          
            "181 - 210 �ѹ"          
            "211 - 240 �ѹ"          
            "241 - 270 �ѹ"          
            "271 - 300 �ѹ"          
            "301 - 330 �ѹ"          
            "331 - 365 �ѹ"          
            "365 �ѹ����"          
            /*---end A54-0119---*/   
            "Group"
            "Customer Type".  
        OUTPUT CLOSE.

        OUTPUT TO VALUE (n_OutputFileSum + "OSIC") NO-ECHO.  /* SUMMARY */
            RUN pdTitleSumOS.
            EXPORT DELIMITER ";"
                nv_RptName
                "Premium "
                "Comm"
                "Bal. O/S (Prem + Comm)"
                "Cheque Return"
                "Suspense"
                "Net. A/r (Bal. O/S + Cheque Ret. + Sus. )"
                "Net. Other (ex. 'YP')"
                "����Թ 15 �ѹ"
                "16 - 30 �ѹ"
                "31 - 45 �ѹ"
                "46 - 60 �ѹ"
                "61 - 90 �ѹ"
                /*---A54-0119---         
                "91 - 180 �ѹ"           
                "181 - 270 �ѹ"          
                "271 - 365 �ѹ"          
                "365 �ѹ����"          
                -------------*/          
                /*---A54-0119---*/       
                "91 - 120 �ѹ"           
                "121 - 150 �ѹ"          
                "151 - 180 �ѹ"          
                "181 - 210 �ѹ"          
                "211 - 240 �ѹ"          
                "241 - 270 �ѹ"          
                "271 - 300 �ѹ"          
                "301 - 330 �ѹ"          
                "331 - 365 �ѹ"          
                "365 �ѹ����"          
                /*---end A54-0119---*/   
                "Group"
                "Customer Type".
        OUTPUT CLOSE.
       
    END.  /* (nv_DetSum = "Summary")  OR (nv_DetSum = "All")  */


nv_poltyp = "".

 IF rstype = 1 THEN DO:
    FOR EACH xmm031 NO-LOCK WHERE xmm031.dept = "M" OR 
                                   xmm031.dept = "G" 
     BREAK BY xmm031.poltyp:
        IF nv_poltyp = "" THEN ASSIGN nv_poltyp = xmm031.poltyp.
        ELSE ASSIGN nv_poltyp = nv_poltyp + "," + xmm031.poltyp .
    END.
 END.
 ELSE IF rstype = 2 THEN DO:
    FOR EACH xmm031 NO-LOCK WHERE xmm031.dept <> "M" OR 
                                  xmm031.dept <> "G" 
    BREAK BY xmm031.poltyp:
        IF nv_poltyp = "" THEN ASSIGN nv_poltyp = xmm031.poltyp.
        ELSE ASSIGN nv_poltyp = nv_poltyp + "," + xmm031.poltyp .
    END.
END.
ELSE DO:
    FOR EACH xmm031 NO-LOCK 
    BREAK BY xmm031.poltyp:
        IF nv_poltyp = "" THEN ASSIGN nv_poltyp = xmm031.poltyp.
        ELSE ASSIGN nv_poltyp = nv_poltyp + "," + xmm031.poltyp .
    END. 

END.

    loop_li :
    FOR EACH  agtprm_fil WHERE 
              agtprm_fil.asdat        = n_asdat     AND
             (agtprm_fil.acno        >= n_frac      AND agtprm_fil.acno    <= n_toac  ) AND
             (agtprm_fil.trndat      >= n_trndatFr  AND agtprm_fil.trndat  <= n_trndatTo) AND
             (agtprm_fil.polbran     >= n_branch    AND agtprm_fil.polbran <= n_branch2) AND
      (LOOKUP(agtprm_fil.poltyp,nv_poltyp) <> 0)    AND
      (LOOKUP (SUBSTRING(agtprm_fil.trntyp,1,1) , nv_trntyp1) <> 0 )
       NO-LOCK BREAK BY SUBSTRING(agtprm_fil.policy,3,2)
                  BY agtprm_fil.agent
                  BY agtprm_fil.trndat
                  BY agtprm_fil.policy.
    
            DISP SUBSTRING(agtprm_fil.policy,3,2) FORMAT "X(5)"
                 agtprm_fil.agent FORMAT "X(10)"
                 agtprm_fil.trndat
                 agtprm_fil.policy
                 agtprm_fil.trntyp
                 agtprm_fil.docno
            WITH COLOR BLACK/WHITE NO-LABEL FRAME frProcess VIEW-AS DIALOG-BOX
            TITLE  "  Processing ...".

        n_asdat = IF nv_asdatAging = ? THEN n_asdat ELSE nv_asdatAging.

        /* Begin */
           /********************** Group Header *********************/
             IF FIRST-OF(SUBSTRING(agtprm_fil.policy,3,2))  THEN DO:  /**/

                nv_Linedes = "".
                FIND xmm031 WHERE SUBSTR(xmm031.poltyp,2,2) = SUBSTRING(agtprm_fil.policy,3,2) NO-LOCK NO-ERROR.
                IF AVAIL xmm031 THEN nv_LineDes = TRIM(xmm031.poldes).
                /*--- DISPLAY DETAIL  ---*/
                IF (nv_DetSum = "Detail")  OR (nv_DetSum = "All") THEN DO:
                        {wac\wacr0604.i}
                        nv_reccnt = nv_reccnt + 1 .
                   

                    OUTPUT TO VALUE (STRING(n_OutputFile ) ) APPEND NO-ECHO.
                        EXPORT DELIMITER ";" "".
                        EXPORT DELIMITER ";"
                            "Line : " + SUBSTRING(agtprm_fil.policy,3,2) + " - " + nv_Linedes + "  " +
                            "Type : " + agtprm_fil.type.
                    OUTPUT CLOSE.
    
                END.  /*  (nv_DetSum = "Detail")  OR (nv_DetSum = "All") */

                RUN pdInitDataTot.  /* clear data in group*/

             END.  /* first-of(SUBSTRING(agtprm_fil.policy,3,2)) */

             RUN pdDeptGrp.   /*A53-0159*/
        /****** �ӹǹ ��������´��� ��� display � File Detail   � dot i*****/
            {wac\wacrl01.i} .
            
          /*** CREATE  WORK-TABLE for file SUMMARY GROUP CODE***/
             DO TRANSACTION:

                FIND FIRST wtOICsum USE-INDEX wtOICsum1 WHERE wtOICsum.wtICpoltyp = agtprm_fil.poltyp AND
                                          wtOICsum.wtICpolgrp = nv_polgrp AND
                                          wtOICsum.wtICinsref = nv_insref NO-ERROR.
                IF NOT AVAIL wtOICsum THEN DO:
                CREATE wtOICSum.
                ASSIGN
                    wtICPrem = 0
                    wtICrptName = nv_RptName
                    wtICagent   = agtprm_fil.agent
                    wtICacname  = nv_acname
                    wtICpolgrp  = nv_polgrp
                    wtICpoltyp  = agtprm_fil.poltyp
                    wtICinsref  = nv_insref
                    wtICTPrem   = nv_premA  
                    wtICTcomm   = nv_commA  
                    wtICTbal    = nv_balA   
                    wtICTretc   = nv_retcA  
                    wtICTsusp   = nv_suspA  
                    wtICTnetar  = nv_netarA 
                    wtICTnetoth = nv_netothA
                    wtICPrem[lip] = nv_baldet[lip]
                    /*---A54-0055---*/
                    wtICComm[lip] = nv_comdet[lip]
                    wtICNet[lip]    =  nv_netdet[lip]        
                    wtICRetc[lip]   =  nv_retcdet[lip]      
                    wtICSusp[lip]   =  nv_suspdet[lip]      
                    wtICNetar[lip]  =  nv_netardet[lip]    
                    wtICBal[lip]    =  nv_balcdet[lip]      
                    wtICNetoth[lip] =  nv_Netothdet[lip] .
                    /*---A54-0055---*/
                 
                END.    /*if not avail wtOICsum */
                ELSE DO:
                    ASSIGN
                    wtICPrem[lip] = wtICPrem[lip] + nv_baldet[lip]
                    /*---A54-0055---*/
                    wtICComm[lip] = wtICCom[lip] + nv_comdet[lip]
                    wtICNet[lip]    = wtICNet[lip]    + nv_netdet[lip]        
                    wtICRetc[lip]   = wtICRetc[lip]   + nv_retcdet[lip]      
                    wtICSusp[lip]   = wtICSusp[lip]   + nv_suspdet[lip]      
                    wtICNetar[lip]  = wtICNetar[lip]  + nv_netardet[lip]    
                    wtICBal[lip]   = wtICBal[lip]   + nv_balcdet[lip]      
                    wtICNetoth[lip] = wtICNetoth[lip] + nv_Netothdet[lip] 
                    /*---A54-0055---*/
                    wtICTPrem     = wtICTPrem   + nv_premA  
                    wtICTcomm     = wtICTcomm   + nv_commA  
                    wtICTbal      = wtICTbal    + nv_balA   
                    wtICTretc     = wtICTretc   + nv_retcA  
                    wtICTsusp     = wtICTsusp   + nv_suspA  
                    wtICTnetar    = wtICTnetar  + nv_netarA 
                    wtICTnetoth   = wtICTnetoth + nv_netothA.
                   
                END.
             END.
             /*transaction*/
            
        /********************** Group Footer *********************/
         IF LAST-OF(SUBSTRING(agtprm_fil.policy,3,2))  THEN DO:  /**/
            ASSIGN
                nv_RptTyp1 = ""
                nv_RptTyp2 = ""
                nv_RptTyp1 = SUBSTRING(agtprm_fil.policy,3,2)  /* ����¹仵�� ��Դ�ͧ report */
                nv_RptTyp2 = nv_Linedes.

                /*** �ӹǹ����� group, export ������ŧ SUMMARY FILE ���  �ӹǹ SUMMARY GRAND TOTAL***/
                    {wac\wacrl02.i}
                 
                        FOR EACH wtdet NO-LOCK WHERE wtdet.wtdetpoltyp = SUBSTR(agtprm_fil.poltyp,2,2)
                        BREAK BY wtDetpoltyp
                              BY wtDetpolgrp
                              BY wtDetinsref:
                            OUTPUT TO VALUE (STRING(n_OutputFile ) ) APPEND NO-ECHO.
                            EXPORT DELIMITER ";"
                                 "ToTal of " + wtDetpoltyp + " - " + wtDetpolgrp + " - " + wtDetinsref
                                ""
                                ""
                                ""
                                ""
                                ""
                                ""
                                ""
                                ""
                                ""
                                ""
                                wtDetprem
                                wtDetcomm
                                wtDetbal
                                wtDetretc
                                wtDetsusp
                                wtDetnetar
                                wtDetnetoth
                                /*---A54-0119---
                                wtDetbalDet[1 FOR 9].
                                ------------*/
                                wtDetbalDet[1 FOR 15].
                            OUTPUT CLOSE.
                        END.
               
         END. /*  LAST-OF(SUBSTRING(agtprm_fil.policy,3,2)) */
            vCount = vCount + 1.
    END. /* for each agtprm_fil*/

        /********************** Page Footer *********************/
        /*** export ������ŧ DETAIL FILE ��÷Ѵ Grand Total  ���  
                                    SUMMARY FILE ��÷Ѵ Grand Total ***/
            {wac\wacrl03.i}

    RELEASE agtprm_fil.

    IF (nv_DetSum = "Summary")  OR (nv_DetSum = "All") THEN DO:
         RUN pdLineGp.
    END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdLineGp C-Win 
PROCEDURE pdLineGp :
/*------------------------------------------------------------------------------
  Purpose:     �¡��� summary  BREAK BY group code
  Parameters:  <none>
  Notes:        field  xmm600.gpage
------------------------------------------------------------------------------*/
DEF VAR liname       AS CHAR INIT "".
DEF VAR n_liname     AS CHAR INIT "".

ASSIGN nv_GTTprem     = 0
       nv_GTTcomm     = 0
       nv_GTTbal      = 0 
       nv_GTTretc     = 0
       nv_GTTsusp     = 0
       nv_GTTnetar    = 0 
       nv_GTTnetoth   = 0
       nv_GTprem      = 0 .

OUTPUT TO VALUE (n_OutputFile + "sumIC") NO-ECHO.  /* SUMMARY */
RUN pdTitleSum.
RUN pdPageHeadSum.
OUTPUT CLOSE.

FOR EACH wtoicSum BREAK BY wtICPoltyp
                          BY wtICpolgrp
                          BY wtICinsref:

    IF FIRST-OF(wtoicSum.wtICPoltyp) THEN DO:
        liname = "".

        FIND xmm031 WHERE xmm031.poltyp = wtoicsum.wtICpoltyp NO-LOCK NO-ERROR.
        IF AVAIL xmm031 THEN liname = TRIM(xmm031.poldes).
        ELSE liname = "".

        OUTPUT TO VALUE (n_OutputFile + "sumIC") APPEND NO-ECHO.  /* SUMMARY */    
        EXPORT DELIMITER ";" "".
        EXPORT DELIMITER ";" "Line : " + wtICPoltyp + " - " +  liname.
        EXPORT DELIMITER ";" FILL("-",100).
        OUTPUT CLOSE.
        n_liname = liname.
    END.

    /*---A54-0119---
    OUTPUT TO VALUE (n_OutputFile + "sumIC") APPEND NO-ECHO.  /* SUMMARY */    
    EXPORT DELIMITER ";"  "Summary of : " + wtICrptname + " " + wtICpoltyp + " - " + n_liname + " :: " + wtICpolgrp + " :: " + wtICinsref.
    EXPORT DELIMITER ";"  wtICrptname + " Premium"          wtICTprem   wtICprem[1 FOR 9].  
    EXPORT DELIMITER ";"  wtICrptname + " Commission"       wtICTcomm   wtICcomm[1 FOR 9].  
    EXPORT DELIMITER ";"  wtICrptname + " Bal. O/S"         wtICTbal    wtICbal[1 FOR 9].  
    EXPORT DELIMITER ";"  wtICrptname + " Cheque Returned"  wtICTretc   wtICretc[1 FOR 9].  
    EXPORT DELIMITER ";"  wtICrptname + " Suspense"         wtICTsusp   wtICsusp[1 FOR 9].  
    EXPORT DELIMITER ";"  wtICrptname + " Net. A/R"         wtICTnetar  wtICnetar[1 FOR 9]. 
    EXPORT DELIMITER ";"  wtICrptname + " Net. OTHER"       wtICTnetoth wtICnetoth[1 FOR 9].
    EXPORT DELIMITER ";" "Summary of : " + wtICrptname + " " + wtICpoltyp + " :: " + wtICpolgrp + " :: " + wtICinsref
        "����Թ 15 �ѹ" + STRING(wtICprem[1]  ,">>,>>>,>>>,>>9.99-") + nv-1 + 
        "16 - 30 �ѹ"    + STRING(wtICprem[2]  ,">>,>>>,>>>,>>9.99-") + nv-1 + 
        "31 - 45 �ѹ"    + STRING(wtICprem[3]  ,">>,>>>,>>>,>>9.99-") + nv-1 + 
        "46 - 60 �ѹ"   + STRING(wtICprem[4]  ,">>,>>>,>>>,>>9.99-") + nv-1 +
        "61 - 90 �ѹ"  + STRING(wtICprem[5]  ,">>,>>>,>>>,>>9.99-") + nv-1 +
        "91 - 180 �ѹ"  + STRING(wtICprem[6]  ,">>,>>>,>>>,>>9.99-") + nv-1 +
        "181 - 270 �ѹ"  + STRING(wtICprem[7]  ,">>,>>>,>>>,>>9.99-") + nv-1 +
        "271 - 365 �ѹ"  + STRING(wtICprem[8]  ,">>,>>>,>>>,>>9.99-") + nv-1 +        
        "365 �ѹ����"  + STRING(wtICprem[9] ,">>,>>>,>>>,>>9.99-") .
    EXPORT DELIMITER ";" "".
    OUTPUT CLOSE.
    ------------*/
    OUTPUT TO VALUE (n_OutputFile + "sumIC") APPEND NO-ECHO.  /* SUMMARY */    
    EXPORT DELIMITER ";"  "Summary of : " + wtICrptname + " " + wtICpoltyp + " - " + n_liname + " :: " + wtICpolgrp + " :: " + wtICinsref.
    EXPORT DELIMITER ";"  wtICrptname + " Premium"          wtICTprem   wtICprem[1 FOR 15].  
    EXPORT DELIMITER ";"  wtICrptname + " Commission"       wtICTcomm   wtICcomm[1 FOR 15].  
    EXPORT DELIMITER ";"  wtICrptname + " Bal. O/S"         wtICTbal    wtICbal[1 FOR 15].  
    EXPORT DELIMITER ";"  wtICrptname + " Cheque Returned"  wtICTretc   wtICretc[1 FOR 15].  
    EXPORT DELIMITER ";"  wtICrptname + " Suspense"         wtICTsusp   wtICsusp[1 FOR 15].  
    EXPORT DELIMITER ";"  wtICrptname + " Net. A/R"         wtICTnetar  wtICnetar[1 FOR 15]. 
    EXPORT DELIMITER ";"  wtICrptname + " Net. OTHER"       wtICTnetoth wtICnetoth[1 FOR 15].
    EXPORT DELIMITER ";" "Summary of : " + wtICrptname + " " + wtICpoltyp + " :: " + wtICpolgrp + " :: " + wtICinsref
        "����Թ 15 �ѹ" + STRING(wtICprem[1]  ,">>,>>>,>>>,>>9.99-") + nv-1 + 
        "16 - 30 �ѹ"    + STRING(wtICprem[2]  ,">>,>>>,>>>,>>9.99-") + nv-1 + 
        "31 - 45 �ѹ"    + STRING(wtICprem[3]  ,">>,>>>,>>>,>>9.99-") + nv-1 + 
        "46 - 60 �ѹ"   + STRING(wtICprem[4]  ,">>,>>>,>>>,>>9.99-") + nv-1 +
        "61 - 90 �ѹ"  + STRING(wtICprem[5]  ,">>,>>>,>>>,>>9.99-") + nv-1 +
        "91 - 120 �ѹ"  + STRING(wtICprem[6]  ,">>,>>>,>>>,>>9.99-") + nv-1 +
        "121 - 150 �ѹ" + STRING(wtICprem[7]  ,">>,>>>,>>>,>>9.99-") + nv-1 +
        "151 - 180 �ѹ" + STRING(wtICprem[8]  ,">>,>>>,>>>,>>9.99-") + nv-1 +        
        "181 - 210 �ѹ" + STRING(wtICprem[9] ,">>,>>>,>>>,>>9.99-")  + nv-1 +
        "211 - 240 �ѹ" + STRING(wtICprem[10]  ,">>,>>>,>>>,>>9.99-") + nv-1 +
        "241 - 270 �ѹ" + STRING(wtICprem[11]  ,">>,>>>,>>>,>>9.99-") + nv-1 +
        "271 - 300 �ѹ" + STRING(wtICprem[12]  ,">>,>>>,>>>,>>9.99-") + nv-1 +
        "301 - 330 �ѹ" + STRING(wtICprem[13]  ,">>,>>>,>>>,>>9.99-") + nv-1 +
        "331 - 365 �ѹ" + STRING(wtICprem[14]  ,">>,>>>,>>>,>>9.99-") + nv-1 +
        "365 �ѹ����" + STRING(wtICprem[15]  ,">>,>>>,>>>,>>9.99-").
    EXPORT DELIMITER ";" "".
    OUTPUT CLOSE.

        FIND FIRST wtnTLi USE-INDEX wtnTli1 WHERE wtnTli.ntline   = wtoicSum.wticpoltyp AND 
                                wtnTli.ntPolgrp = wtoicSum.wticpolgrp AND 
                                wtnTli.ntinsref = wtoicSum.wticinsref NO-ERROR.
        IF NOT AVAIL wtnTLi THEN DO:
            CREATE wtnTli.
            ASSIGN wtntli.ntline   = wtoicSum.wticpoltyp
                   wtnTli.ntPolgrp = wtoicSum.wticpolgrp
                   wtnTli.ntinsref = wtoicSum.wticinsref
                   wtnTli.ntprem   = wtoicSum.wtICTprem 
                   wtntli.nTcomm   = wtoicSum.wtICTcomm 
                   wtnTli.nTbal    = wtoicSum.wtICTbal  
                   wtnTli.nTretc   = wtoicSum.wtICTretc 
                   wtnTli.nTsusp   = wtoicSum.wtICTsusp 
                   wtntli.nTnetar  = wtoicSum.wtICTnetar
                   wtnTli.nTnetoth = wtoicSum.wtICTnetot
                   wtnTli.nTTbal[1]  = wtoicSum.wtICprem[1]
                   wtnTli.nTTbal[2]  = wtoicSum.wtICprem[2]
                   wtntli.nTTbal[3]  = wtoicSum.wtICprem[3]
                   wtnTli.nTTbal[4]  = wtoicSum.wtICprem[4]
                   wtnTli.nTTbal[5]  = wtoicSum.wtICprem[5]
                   wtnTli.nTTbal[6]  = wtoicSum.wtICprem[6]
                   wtntli.nTTbal[7]  = wtoicSum.wtICprem[7]
                   wtnTli.nTTbal[8]  = wtoicSum.wtICprem[8]
                   wtnTli.nTTbal[9]  = wtoicSum.wtICprem[9]
                   /*---A54-0119---*/
                   wtnTli.nTTbal[10]  = wtoicSum.wtICprem[10]
                   wtnTli.nTTbal[11]  = wtoicSum.wtICprem[11]
                   wtnTli.nTTbal[12]  = wtoicSum.wtICprem[12]
                   wtntli.nTTbal[13]  = wtoicSum.wtICprem[13]
                   wtnTli.nTTbal[14]  = wtoicSum.wtICprem[14]
                   wtnTli.nTTbal[15]  = wtoicSum.wtICprem[15].
                                   
        END.
        ELSE DO:
            ASSIGN  wtnTli.ntprem   = wtnTli.ntprem   + wtoicSum.wtICTprem  
                    wtntli.nTcomm   = wtntli.nTcomm   + wtoicSum.wtICTcomm  
                    wtnTli.nTbal    = wtnTli.nTbal    + wtoicSum.wtICTbal   
                    wtnTli.nTretc   = wtnTli.nTretc   + wtoicSum.wtICTretc  
                    wtnTli.nTsusp   = wtnTli.nTsusp   + wtoicSum.wtICTsusp  
                    wtntli.nTnetar  = wtntli.nTnetar  + wtoicSum.wtICTnetar 
                    wtnTli.nTnetoth = wtnTli.nTnetoth + wtoicSum.wtICTnetot 
                    wtnTli.nTTbal[1]  = wtnTli.nTTbal[1]  + wtoicSum.wtICprem[1] 
                    wtnTli.nTTbal[2]  = wtnTli.nTTbal[2]  + wtoicSum.wtICprem[2] 
                    wtntli.nTTbal[3]  = wtntli.nTTbal[3]  + wtoicSum.wtICprem[3] 
                    wtnTli.nTTbal[4]  = wtnTli.nTTbal[4]  + wtoicSum.wtICprem[4] 
                    wtnTli.nTTbal[5]  = wtnTli.nTTbal[5]  + wtoicSum.wtICprem[5] 
                    wtnTli.nTTbal[6]  = wtnTli.nTTbal[6]  + wtoicSum.wtICprem[6] 
                    wtntli.nTTbal[7]  = wtntli.nTTbal[7]  + wtoicSum.wtICprem[7] 
                    wtnTli.nTTbal[8]  = wtnTli.nTTbal[8]  + wtoicSum.wtICprem[8] 
                    wtnTli.nTTbal[9]  = wtnTli.nTTbal[9]  + wtoicSum.wtICprem[9]
                    /*---A54-0119----*/
                    wtnTli.nTTbal[10]  = wtnTli.nTTbal[10]  + wtoicSum.wtICprem[10] 
                    wtnTli.nTTbal[11]  = wtnTli.nTTbal[11]  + wtoicSum.wtICprem[11] 
                    wtnTli.nTTbal[12]  = wtnTli.nTTbal[12]  + wtoicSum.wtICprem[12] 
                    wtntli.nTTbal[13]  = wtntli.nTTbal[13]  + wtoicSum.wtICprem[13] 
                    wtnTli.nTTbal[14]  = wtnTli.nTTbal[14]  + wtoicSum.wtICprem[14] 
                    wtnTli.nTTbal[15]  = wtnTli.nTTbal[15]  + wtoicSum.wtICprem[15].
        END.

         ASSIGN 
            nv_GTTprem     =    nv_GTTprem    +  wtnTli.ntprem   
            nv_GTTcomm     =    nv_GTTcomm    +  wtntli.nTcomm   
            nv_GTTbal      =    nv_GTTbal     +  wtnTli.nTbal    
            nv_GTTretc     =    nv_GTTretc    +  wtnTli.nTretc   
            nv_GTTsusp     =    nv_GTTsusp    +  wtnTli.nTsusp   
            nv_GTTnetar    =    nv_GTTnetar   +  wtntli.nTnetar  
            nv_GTTnetoth   =    nv_GTTnetoth  +  wtnTli.nTnetoth 
            nv_GTprem[1]   =    nv_GTprem[1]  +  wtnTli.nTTbal[1]                         
            nv_GTprem[2]   =    nv_GTprem[2]  +  wtnTli.nTTbal[2]                         
            nv_GTprem[3]   =    nv_GTprem[3]  +  wtntli.nTTbal[3]                         
            nv_GTprem[4]   =    nv_GTprem[4]  +  wtnTli.nTTbal[4]                         
            nv_GTprem[5]   =    nv_GTprem[5]  +  wtnTli.nTTbal[5]                         
            nv_GTprem[6]   =    nv_GTprem[6]  +  wtnTli.nTTbal[6]                         
            nv_GTprem[7]   =    nv_GTprem[7]  +  wtntli.nTTbal[7]                         
            nv_GTprem[8]   =    nv_GTprem[8]  +  wtnTli.nTTbal[8]                         
            nv_GTprem[9]   =    nv_GTprem[9]  +  wtnTli.nTTbal[9]       
            /*--A54-0119--*/
            nv_GTprem[10]   =    nv_GTprem[10]  +  wtnTli.nTTbal[10]                         
            nv_GTprem[11]   =    nv_GTprem[11]  +  wtnTli.nTTbal[11]                         
            nv_GTprem[12]   =    nv_GTprem[12]  +  wtnTli.nTTbal[12]                         
            nv_GTprem[13]   =    nv_GTprem[13]  +  wtntli.nTTbal[13]                         
            nv_GTprem[14]   =    nv_GTprem[14]  +  wtnTli.nTTbal[14]                         
            nv_GTprem[15]   =    nv_GTprem[15]  +  wtnTli.nTTbal[15]
           .    
       
        IF LAST-OF (wtoicSum.wtICpoltyp) THEN DO:
           FOR EACH wtnTLi NO-LOCK WHERE wtnTLi.ntLine = wtoicSum.wtICpoltyp 
           BREAK BY wtnTLi.ntpolgrp.
               OUTPUT TO VALUE (n_OutputFileSum + "OSIC") APPEND NO-ECHO.  /* SUMMARY */
                 EXPORT DELIMITER ";"
                 wtICrptname + " : " +  wtnTLi.ntLine
                 wtnTli.ntprem       /*"Premium "*/
                 wtntli.nTcomm       /*"Comm"*/
                 wtnTli.nTbal        /*"Bal. O/S"*/
                 wtnTli.nTretc       /* cheque return */
                 wtnTli.nTsusp       /* suspense */
                 wtntli.nTnetar      /* net. a/r */
                 wtnTli.nTnetoth     /* net. other */
                 wtnTli.nTTbal[1]  
                 wtnTli.nTTbal[2]  
                 wtntli.nTTbal[3]  
                 wtnTli.nTTbal[4]  
                 wtnTli.nTTbal[5]  
                 wtnTli.nTTbal[6]  
                 wtntli.nTTbal[7]  
                 wtnTli.nTTbal[8]  
                 wtnTli.nTTbal[9]  
                 /*--A54-0119--*/
                 wtnTli.nTTbal[10]  
                 wtnTli.nTTbal[11]  
                 wtnTli.nTTbal[12]  
                 wtntli.nTTbal[13]  
                 wtnTli.nTTbal[14]  
                 wtnTli.nTTbal[15]
                 wtnTLi.ntpolgrp
                 wtnTLi.ntinsref
                 .
                OUTPUT CLOSE.
           END.
        END.
END.  
/*---A54-0119---
OUTPUT TO VALUE (n_OutputFile + "sumIC") APPEND NO-ECHO.  /* SUMMARY */    
EXPORT DELIMITER ";"  "".
EXPORT DELIMITER ";"  "".
EXPORT DELIMITER ";"  "G R A N D  T O T A L".
EXPORT DELIMITER ";"  "Grand Premium"           nv_GTTprem      nv_GTprem[1 FOR 9].  
EXPORT DELIMITER ";"  "Grand Commission"        nv_GTTcomm      nv_GTcomm[1 FOR 9].
EXPORT DELIMITER ";"  "Grand Bal. O/S"          nv_GTTbal       nv_GTbal[1 FOR 9].   
EXPORT DELIMITER ";"  "Grand Cheque Returned"   nv_GTTretc      nv_GTretc[1 FOR 9].
EXPORT DELIMITER ";"  "Grand Suspense"          nv_GTTsusp      nv_GTsusp[1 FOR 9].  
EXPORT DELIMITER ";"  "Grand Net. A/R"          nv_GTTnetar     nv_GTnetar[1 FOR 9].
EXPORT DELIMITER ";"  "Grand Net. OTHER"        nv_GTTnetoth    nv_GTnetoth[1 FOR 9]. 
EXPORT DELIMITER ";"  "".
EXPORT DELIMITER ";" "G R A N D  T O T A L"
        "����Թ 15 �ѹ" + STRING(nv_GTprem[1] ,">>,>>>,>>>,>>9.99-") + nv-1 +     
        "16 - 30 �ѹ"    + STRING(nv_GTprem[2] ,">>,>>>,>>>,>>9.99-") + nv-1 +     
        "31 - 45 �ѹ"    + STRING(nv_GTprem[3] ,">>,>>>,>>>,>>9.99-") + nv-1 +  
        "46 - 60 �ѹ"   + STRING(nv_GTprem[4] ,">>,>>>,>>>,>>9.99-") + nv-1 +           
        "61 - 90 �ѹ"  + STRING(nv_GTprem[5] ,">>,>>>,>>>,>>9.99-") + nv-1 +     
        "91 - 180 �ѹ"  + STRING(nv_GTprem[6] ,">>,>>>,>>>,>>9.99-") + nv-1 +     
        "181 - 270 �ѹ"  + STRING(nv_GTprem[7] ,">>,>>>,>>>,>>9.99-") + nv-1 +  
        "271 - 365 �ѹ"  + STRING(nv_GTprem[8] ,">>,>>>,>>>,>>9.99-") + nv-1 +           
        "365 �ѹ����"  + STRING(nv_GTprem[9] ,">>,>>>,>>>,>>9.99-") .
        
OUTPUT CLOSE.
---------*/
OUTPUT TO VALUE (n_OutputFile + "sumIC") APPEND NO-ECHO.  /* SUMMARY */    
EXPORT DELIMITER ";"  "".
EXPORT DELIMITER ";"  "".
EXPORT DELIMITER ";"  "G R A N D  T O T A L".
EXPORT DELIMITER ";"  "Grand Premium"           nv_GTTprem      nv_GTprem[1 FOR 15].  
EXPORT DELIMITER ";"  "Grand Commission"        nv_GTTcomm      nv_GTcomm[1 FOR 15].
EXPORT DELIMITER ";"  "Grand Bal. O/S"          nv_GTTbal       nv_GTbal[1 FOR 15].   
EXPORT DELIMITER ";"  "Grand Cheque Returned"   nv_GTTretc      nv_GTretc[1 FOR 15].
EXPORT DELIMITER ";"  "Grand Suspense"          nv_GTTsusp      nv_GTsusp[1 FOR 15].  
EXPORT DELIMITER ";"  "Grand Net. A/R"          nv_GTTnetar     nv_GTnetar[1 FOR 15].
EXPORT DELIMITER ";"  "Grand Net. OTHER"        nv_GTTnetoth    nv_GTnetoth[1 FOR 15]. 
EXPORT DELIMITER ";"  "".
EXPORT DELIMITER ";" "G R A N D  T O T A L"
        "����Թ 15 �ѹ" + STRING(nv_GTprem[1] ,">>,>>>,>>>,>>9.99-") + nv-1 +     
        "16 - 30 �ѹ"    + STRING(nv_GTprem[2] ,">>,>>>,>>>,>>9.99-") + nv-1 +     
        "31 - 45 �ѹ"    + STRING(nv_GTprem[3] ,">>,>>>,>>>,>>9.99-") + nv-1 +  
        "46 - 60 �ѹ"     + STRING(nv_GTprem[4] ,">>,>>>,>>>,>>9.99-") + nv-1 +           
        "61 - 90 �ѹ"     + STRING(nv_GTprem[5] ,">>,>>>,>>>,>>9.99-") + nv-1 +     
        "91 - 120 �ѹ"    + STRING(nv_GTprem[6] ,">>,>>>,>>>,>>9.99-") + nv-1 +     
        "121 - 150 �ѹ"   + STRING(nv_GTprem[7] ,">>,>>>,>>>,>>9.99-") + nv-1 +  
        "151 - 180 �ѹ"   + STRING(nv_GTprem[8] ,">>,>>>,>>>,>>9.99-") + nv-1 +           
        "181 - 210 �ѹ"   + STRING(nv_GTprem[9] ,">>,>>>,>>>,>>9.99-") + nv-1 +
        "211 - 240 �ѹ"   + STRING(nv_GTprem[10] ,">>,>>>,>>>,>>9.99-") + nv-1 + 
        "241 - 270 �ѹ"   + STRING(nv_GTprem[11] ,">>,>>>,>>>,>>9.99-") + nv-1 + 
        "271 - 300 �ѹ"   + STRING(nv_GTprem[12] ,">>,>>>,>>>,>>9.99-") + nv-1 + 
        "301 - 330 �ѹ"   + STRING(nv_GTprem[13] ,">>,>>>,>>>,>>9.99-") + nv-1 + 
        "331 - 365 �ѹ"   + STRING(nv_GTprem[14] ,">>,>>>,>>>,>>9.99-") + nv-1 + 
        "365 �ѹ����"   + STRING(nv_GTprem[15] ,">>,>>>,>>>,>>9.99-") .
OUTPUT CLOSE.

OUTPUT TO VALUE (n_OutputFileSum + "OSIC") APPEND NO-ECHO.  /* SUMMARY */
       EXPORT DELIMITER ";"
       "Grand Total : " + " : " 
       nv_GTTprem      /*"Premium "*/
       nv_GTTcomm     /*"Comm"*/
       nv_GTTbal       /*"Bal. O/S"*/
       nv_GTTretc      /* cheque return */
       nv_GTTsusp      /* suspense */
       nv_GTTnetar     /* net. a/r */
       nv_GTTnetoth    /* net. other */
       nv_GTprem[1] 
       nv_GTprem[2]
       nv_GTprem[3]
       nv_GTprem[4]
       nv_GTprem[5]
       nv_GTprem[6]
       nv_GTprem[7]
       nv_GTprem[8]
       nv_GTprem[9]
       /*---A54-0119---*/
       nv_GTprem[10]
       nv_GTprem[11]
       nv_GTprem[12]
       nv_GTprem[13]
       nv_GTprem[14]
       nv_GTprem[15]
       .
   OUTPUT CLOSE.



END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdPageHead C-Win 
PROCEDURE pdPageHead :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

nv_blankH = FILL(" " , 15).

/********************** Page Header *********************/
/* ��ǹ����͡��� ŧ file : Detail */

    /* line 1*/
EXPORT DELIMITER ";"
    "From : " + n_frac + " To " + n_toac
    nv_blankH[1 FOR 14]       /* ��� ��ͧ��ҧ  14 ��ͧ*/
    "SAFETY INSURANCE PUBLIC COMPANY LIMITED"
    nv_blankH[1 FOR 14]
    "RUN DATE : " + STRING(TODAY,"99/99/9999").

    /* line 2*/
EXPORT DELIMITER ";"
    "Branch : " + n_Branch + " To " + n_Branch2
     nv_blankH[1 FOR 14]
    "Ageing Report By " + nv_RptName + " " + nv_RptName2 + " " + "for OIC"
     nv_blankH[1 FOR 14]
    "RUN TIME : " + STRING(TIME,"HH:MM:SS").
    
    /* line 3*/
EXPORT DELIMITER ";"
    "Tran. Date : " + STRING(n_trndatfr,"99/99/9999") + " To " + STRING(n_trndatto,"99/99/9999")
     nv_blankH[1 FOR 14]
    "As Of  Date : " + STRING(n_asdat,"99/99/9999")
     nv_blankH[1 FOR 14]
    "Program Name : Wacrloic.W".

END PROCEDURE.





/*------------------------------------------------------------------------------- Old */
/*



nv-1 = FILL(" ", 202).
nv_blankH = FILL(" " , 15).

/********************** Page Header *********************/
/* ��ǹ����͡��� ŧ file : Detail */

    /* line 1*/
EXPORT DELIMITER ";"
    "From : " + n_frac + " To " + n_toac
    nv-1  /*       nv_blankH[1 FOR 14]       /* ��� ��ͧ��ҧ  14 ��ͧ*/*/
    "SAFETY INSURANCE PUBLIC COMPANY LIMITED"
    nv-1
    "RUN DATE : " + STRING(TODAY,"99/99/9999").


    /* line 2*/
EXPORT DELIMITER ";"
    "Branch : " + n_Branch + " To " + n_Branch2
     nv-1
    "Ageing Report By " + nv_RptName + " " + nv_RptName2
     nv-1
    "RUN TIME : " + STRING(TIME,"HH:MM:SS").
    
    /* line 3*/
EXPORT DELIMITER ";"
    "Tran. Date : " + STRING(n_trndatfr,"99/99/9999") + " To " + STRING(n_trndatto,"99/99/9999")
     nv-1
    "As Of  Date : " + STRING(n_asdat,"99/99/9999")
     nv-1
    "Program Name : wacr05.w".
    

*/

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdPageHeadDet C-Win 
PROCEDURE pdPageHeadDet :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

IF nv_RptName = "Line" THEN DO:
    EXPORT DELIMITER ";"
        "Agent No."  "Agent Name  " "Branch" "Credit Term"  "Tran Date" "Due Date" " Invoice No."  " Policy No."  " Endt No."  "Endt Date" " Com. Date " "Exp .date"  /*" Insured Name "*/  
        "Premium  "   "Comm."  "Balance (Baht)"
        "Cheque Returned"   "Suspense"  "Net A/R" "Net Other" 
        "����Թ 15 �ѹ"
        "16 - 30 �ѹ"
        "31 - 45 �ѹ"
        "46 - 60 �ѹ"
        "61 - 90 �ѹ"
        /*---A54-0119---
        "91 - 180 �ѹ"
        "181 - 270 �ѹ"
        "271 - 365 �ѹ"
        "365 �ѹ����"
        -------------*/
        /*---A54-0119---*/
        "91 - 120 �ѹ"
        "121 - 150 �ѹ"
        "151 - 180 �ѹ"
        "181 - 210 �ѹ"
        "211 - 240 �ѹ"
        "241 - 270 �ѹ"
        "271 - 300 �ѹ"
        "301 - 330 �ѹ"
        "331 - 365 �ѹ"
        "365 �ѹ����"
        /*---end A54-0119---*/
        "Group"
        "Customer Type".
END.
ELSE DO:
    EXPORT DELIMITER ";"
        "Account No."  "Account Name  " "Branch" "Credit Term"  "Tran Date" "Due Date" " Invoice No."  " Policy No."  " Endt No."  "Endt Date" " Com. Date " "Exp date" /*" Insured Name "*/  
        "Premium  "   "Comm."  "Balance (Baht)"
        "Cheque Returned"   "Suspense"  "Net A/R" "Net Other" 
        "����Թ 15 �ѹ"
        "16 - 30 �ѹ"
        "31 - 45 �ѹ"
        "46 - 60 �ѹ"
        "61 - 90 �ѹ"
        /*---A54-0119---
        "91 - 180 �ѹ"
        "181 - 270 �ѹ"
        "271 - 365 �ѹ"
        "365 �ѹ����"
        -------------*/
        /*---A54-0119---*/
        "91 - 120 �ѹ"
        "121 - 150 �ѹ"
        "151 - 180 �ѹ"
        "181 - 210 �ѹ"
        "211 - 240 �ѹ"
        "241 - 270 �ѹ"
        "271 - 300 �ѹ"
        "301 - 330 �ѹ"
        "331 - 365 �ѹ"
        "365 �ѹ����"
        /*---end A54-0119---*/
        "Group"
        "Customer Type".
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdPageHeadSum C-Win 
PROCEDURE pdPageHeadSum :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

EXPORT DELIMITER ";"
    "Summary Type"
    "Total"
    "����Թ 15 �ѹ"
    "16 - 30 �ѹ"
    "31 - 45 �ѹ"
    "46 - 60 �ѹ"
    "61 - 90 �ѹ"
    /*---A54-0119---
    "91 - 180 �ѹ"
    "181 - 270 �ѹ"
    "271 - 365 �ѹ"
    "365 �ѹ����".
    -------------*/
    /*---A54-0119---*/
    "91 - 120 �ѹ"
    "121 - 150 �ѹ"
    "151 - 180 �ѹ"
    "181 - 210 �ѹ"
    "211 - 240 �ѹ"
    "241 - 270 �ѹ"
    "271 - 300 �ѹ"
    "301 - 330 �ѹ"
    "331 - 365 �ѹ"
    "365 �ѹ����".
    /*---end A54-0119---*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdTitleDet C-Win 
PROCEDURE pdTitleDet :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

/*nv_blankH = FILL(" " , 15).*/

/********************** Page Header *********************/
/* ��ǹ����͡��� ŧ file : Detail */

    /* line 1*/
EXPORT DELIMITER ";"
    "From : " + n_frac + " To " + n_toac
    nv_blankH[1 FOR 10]       /* ��� ��ͧ��ҧ  14 ��ͧ*/
    "SAFETY INSURANCE PUBLIC COMPANY LIMITED"
    nv_blankH[1 FOR 5]
    "Run Date : " + STRING(TODAY,"99/99/9999") + "  " + "Run Time : " + STRING(TIME,"HH:MM:SS").

    /* line 2*/
EXPORT DELIMITER ";"
    "Branch : " + n_Branch + " To " + n_Branch2
     nv_blankH[1 FOR 10]
    "Ageing Report By " + nv_RptName + " " + nv_RptName2 + " " + "for OIC"
     nv_blankH[1 FOR 5]
    "Include Type : " + nv_trntyp1.
    
    /* line 3*/
EXPORT DELIMITER ";"
    "Tran. Date : " + STRING(n_trndatfr,"99/99/9999") + " To " + STRING(n_trndatto,"99/99/9999")
     nv_blankH[1 FOR 10]
    "As Of  Date : " + STRING(nv_asdatAging,"99/99/9999")
     nv_blankH[1 FOR 5]
    "Program Name : Wacrloic.w".

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdTitleSum C-Win 
PROCEDURE pdTitleSum :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

/*nv_blankH = FILL(" " , 15).*/

/********************** Page Header *********************/
/* ��ǹ����͡��� ŧ file : Detail */

    /* line 1*/
EXPORT DELIMITER ";"
    "From : " + n_frac + " To " + n_toac
    nv_blankH[1 FOR 2]       /* ��� ��ͧ��ҧ  5 ��ͧ*/
    "SAFETY INSURANCE PUBLIC COMPANY LIMITED"
    nv_blankH[1 FOR 3]
    "Run Date : " + STRING(TODAY,"99/99/9999") + "  " + "Run Time : " + STRING(TIME,"HH:MM:SS").

    /* line 2*/
EXPORT DELIMITER ";"
    "Branch : " + n_Branch + " To " + n_Branch2
     nv_blankH[1 FOR 2]
    "Ageing Report By " + nv_RptName + " " + nv_RptName2 + " " + "for OIC"
     nv_blankH[1 FOR 3]
    "Include Type : " + nv_trntyp1.    

    /* line 3*/
EXPORT DELIMITER ";"
    "Tran. Date : " + STRING(n_trndatfr,"99/99/9999") + " To " + STRING(n_trndatto,"99/99/9999")
     nv_blankH[1 FOR 2]
    "As Of  Date : " + STRING(nv_asdatAging,"99/99/9999")
     nv_blankH[1 FOR 3]
    "Program Name : Wacrloic.w".

END PROCEDURE.

/*
            EXPORT DELIMITER ";" "Grand"
                "Current = " + STRING(nv_GTbal[1] + nv_GTbal[2] ,">>,>>>,>>>,>>9.99-") + nv-1 +
                "Over 1-3 = " + STRING(nv_GTbal[3] + nv_GTbal[4] + nv_GTbal[5],">>,>>>,>>>,>>9.99-") + nv-1 +
                "Over 3-6 = " + STRING(nv_GTbal[6] + nv_GTbal[7] + nv_GTbal[8],">>,>>>,>>>,>>9.99-") + nv-1 +
                "Over 6-9 = " + STRING(nv_GTbal[9] + nv_GTbal[10] + nv_GTbal[11] ,">>,>>>,>>>,>>9.99-") + nv-1 +
                "Over 9-12 = " + STRING(nv_GTbal[12] + nv_GTbal[13] + nv_GTbal[14] ,">>,>>>,>>>,>>9.99-") + nv-1 +
                "Over 12 = " + STRING(nv_GTbal[15] ,">>,>>>,>>>,>>9.99-").
*/

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdTitleSumOS C-Win 
PROCEDURE pdTitleSumOS :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

/*nv_blankH = FILL(" " , 15).*/

/********************** Page Header *********************/
/* ��ǹ����͡��� ŧ file : Detail */

    /* line 1*/
EXPORT DELIMITER ";"
    "From : " + n_frac + " To " + n_toac
    "SAFETY INSURANCE PUBLIC COMPANY LIMITED"
    "Run Date : " + STRING(TODAY,"99/99/9999") + "  " + "Run Time : " + STRING(TIME,"HH:MM:SS").

    /* line 2*/
EXPORT DELIMITER ";"
    "Branch : " + n_Branch + " To " + n_Branch2
    "Ageing Report By " + nv_RptName + " " + nv_RptName2 + " " + "for OIC"
    "Include Type : " + nv_trntyp1.    

    /* line 3*/
EXPORT DELIMITER ";"
    "Tran. Date : " + STRING(n_trndatfr,"99/99/9999") + " To " + STRING(n_trndatto,"99/99/9999")
    "As Of  Date : " + STRING(nv_asdatAging,"99/99/9999")
    "Program Name : Wacrloic.w".

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
    FOR EACH acproc_fil  WHERE (acproc_fil.type = "01" OR acproc_fil.type = "05" ) AND
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
/*
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

*/

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
/*
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
 
*/
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fuMaxDay C-Win 
FUNCTION fuMaxDay RETURNS INTEGER
  (INPUT vDate AS DATE ) :
/*------------------------------------------------------------------------------
  Purpose:  fuMaxDay
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
               /*  ������ѹ����٧�ش�ͧ��͹������*/
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
  Purpose:  fuNumYear
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

