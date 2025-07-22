&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          brstat           PROGRESS
*/
&Scoped-define WINDOW-NAME wgwpar01
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS wgwpar01 
/*------------------------------------------------------------------------

  File: 

  Description:  A49-0170  ระบบมอเตอร์ไซค์ line 30 บน Safety's Soft  
               ให้สามารถคีย์งานได้ 

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

/* ***************************  Definitions  ************************** */

/* Parameters Definitions ---                                           */

/* Local Variable Definitions ---                                       */
/*{wmc\wmcm0001.i}*/
DEFINE SHARED VAR nv_Compno AS CHAR FORMAT "X(3)" NO-UNDO.
DEFINE SHARED VAR nv_Branch AS CHAR FORMAT "X(2)" NO-UNDO.
DEFINE SHARED VAR n_User    AS CHAR.
DEFINE NEW SHARED VAR nv_Tarno AS CHAR.

DEF VAR cUpdate     AS CHAR.
DEF VAR Typemotor AS CHAR.
DEF VAR TariffNo      AS CHAR.

/*------------test var------------
DEF var gUser   AS CHAR.
DEF var gPasswd AS CHAR.
DEF var gComp   AS CHAR.
DEF VAR gRecMod AS Recid.
DEF VAR gRecBen AS Recid.
DEF VAR gRecIns AS Recid.
-------------------------------------*/

DEF VAR vCompAB     AS CHAR FORMAT "X".
DEF VAR vCompName   AS CHAR.
DEF VAR rPol        AS ROWID.

DEF VAR FileName1   AS CHAR.
DEF VAR FileName2   AS CHAR.
DEF VAR Name2       AS CHAR.
DEF VAR nv_Search AS CHAR.

DEF TEMP-TABLE TTariff
FIELD  TTarNo        LIKE    brStat.Tariff.TarNo    
FIELD  TGrpClass     LIKE    brStat.Tariff.GrpClass 
FIELD  TCompNo       LIKE    brStat.Tariff.CompNo   
FIELD  TBranch       LIKE    brStat.Tariff.Branch   
FIELD  TPreTarNo     LIKE    brStat.Tariff.PreTarNo 
FIELD  TYearNo       LIKE    brStat.Tariff.YearNo   
FIELD  TSIMin        LIKE    brStat.Tariff.SIMin    
FIELD  TSIMax        LIKE    brStat.Tariff.SIMax    
FIELD  TPremium      LIKE    brStat.Tariff.Premium  
FIELD  TStamp        LIKE    brStat.Tariff.Stamp    
FIELD  TTax          LIKE    brStat.Tariff.Tax      
FIELD  TNetPrm       LIKE    brStat.Tariff.NetPrm   
FIELD  TPAPrm        LIKE    brStat.Tariff.PAPrm    
FIELD  TExtPrm       LIKE    brStat.Tariff.ExtPrm   
FIELD  TCamCode      LIKE    brStat.Tariff.CamCode  
FIELD  TEffDate      LIKE    brStat.Tariff.EffDate  
FIELD  TUserNo       LIKE    brStat.Tariff.UserNo   
FIELD  TUDate        LIKE    brStat.Tariff.UDate    
FIELD  TStat         LIKE    brStat.Tariff.Stat     
FIELD  TPreDate1     LIKE    brStat.Tariff.PreDate1 
FIELD  TPreDate2     LIKE    brStat.Tariff.PreDate2 
FIELD  TPreDate3     LIKE    brStat.Tariff.PreDate3 
FIELD  TDeci1        LIKE    brStat.Tariff.Deci1    
FIELD  TDeci2        LIKE    brStat.Tariff.Deci2    
FIELD  TDeci3        LIKE    brStat.Tariff.Deci3    
FIELD  TDeci4        LIKE    brStat.Tariff.Deci4    
FIELD  TDeci5        LIKE    brStat.Tariff.Deci5    
FIELD  TDate1        LIKE    brStat.Tariff.Date1    
FIELD  TDate2        LIKE    brStat.Tariff.Date2    
FIELD  TText1        LIKE    brStat.Tariff.Text1    
FIELD  TText2        LIKE    brStat.Tariff.Text2    
FIELD  TText3        LIKE    brStat.Tariff.Text3    
FIELD  TText4        LIKE    brStat.Tariff.Text4    
FIELD  TText5        LIKE    brStat.Tariff.Text5    
          
INDEX TTariffI IS PRIMARY  TTarNo ASC.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME frDet
&Scoped-define BROWSE-NAME brTariff

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES Tariff Company

/* Definitions for BROWSE brTariff                                      */
&Scoped-define FIELDS-IN-QUERY-brTariff Tariff.TarNo ~
Company.AbName + "." + Tariff.Compno Tariff.YearNo Tariff.SIMin ~
Tariff.Premium Tariff.Stamp Tariff.Tax Tariff.NetPrm Tariff.UDate ~
Tariff.UserNo ~
IF (brstat.Tariff.Premium * (0.4 / 100)) - TRUNCATE (brstat.Tariff.Premium * (0.4 / 100), 0) > 0 THEN TRUNCATE (brstat.Tariff.Premium * (0.4 / 100), 0) + 1 ELSE TRUNCATE (brstat.Tariff.Premium * (0.4 / 100), 0) ~
IF (brstat.Tariff.Premium * (0.4 / 100)) - TRUNCATE (brstat.Tariff.Premium * (0.4 / 100), 0) > 0 THEN (brstat.Tariff.Premium + (TRUNCATE (brstat.Tariff.Premium * (0.4 / 100), 0) + 1)) * (7 / 100) ELSE (brstat.Tariff.Premium + (TRUNCATE (brstat.Tariff.Premium * (0.4 / 100), 0))) * (7 / 100) ~
IF (brstat.Tariff.Premium * (0.4 / 100)) - TRUNCATE (brstat.Tariff.Premium * (0.4 / 100), 0) > 0 THEN brstat.Tariff.Premium + (TRUNCATE (brstat.Tariff.Premium * (0.4 / 100), 0) + 1) +          ((brstat.Tariff.Premium + (TRUNCATE (brstat.Tariff.Premium * (0.4 / 100), 0) + 1)) * (7 / 100 )) ELSE brstat.Tariff.Premium + (TRUNCATE (brstat.Tariff.Premium * (0.4 / 100), 0)) +          ((Tariff.Premium + (TRUNCATE (Tariff.Premium * (0.4 / 100), 0))) * (7 / 100 )) 
&Scoped-define ENABLED-FIELDS-IN-QUERY-brTariff 
&Scoped-define QUERY-STRING-brTariff FOR EACH Tariff NO-LOCK, ~
      EACH Company OF Tariff NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-brTariff OPEN QUERY brTariff FOR EACH Tariff NO-LOCK, ~
      EACH Company OF Tariff NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-brTariff Tariff Company
&Scoped-define FIRST-TABLE-IN-QUERY-brTariff Tariff
&Scoped-define SECOND-TABLE-IN-QUERY-brTariff Company


/* Definitions for FRAME frMain                                         */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS rbsearch fiSearch2 btnSearch4 btnSearch5 ~
rbFlag fiTarNo fiYearNo fiEffDate btnDelete btnReturn buUp1 buDown1 ~
RECT-356 RECT-359 RECT-366 RECT-451 
&Scoped-Define DISPLAYED-OBJECTS rbsearch fiSearch2 rbFlag fiType fiTarNo ~
fiYearNo fiEffDate fiSImin fiSImax fiPremium fiStamp fiTax fiNetPrm ~
fibranch fiCompNo 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VARIABLE wgwpar01 AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON btnDelete 
     LABEL "ลบ" 
     SIZE 11 BY 1.43
     FONT 6.

DEFINE BUTTON btnReturn 
     LABEL "EXIT" 
     SIZE 10 BY 1.43
     FONT 6.

DEFINE BUTTON btnSearch4 
     IMAGE-UP FILE "adeicon\first-au":U
     LABEL "PREV" 
     SIZE 5.5 BY 1.05 TOOLTIP "ค้นหาถัดไป"
     FONT 6.

DEFINE BUTTON btnSearch5 
     IMAGE-UP FILE "adeicon\last-au":U
     LABEL "NEXT" 
     SIZE 5.5 BY 1 TOOLTIP "ค้นหาก่อนหน้า"
     FONT 6.

DEFINE BUTTON buDown1 
     IMAGE-UP FILE "WIMAGE/down.jpg":U
     LABEL "" 
     SIZE 2.33 BY .62.

DEFINE BUTTON buUp1 
     IMAGE-UP FILE "WIMAGE/up.jpg":U
     LABEL "" 
     SIZE 2.33 BY .62.

DEFINE VARIABLE rbFlag AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEMS "รถใหม่","รถเก่า","รถต่ออายุ" 
     DROP-DOWN-LIST
     SIZE 15.5 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE rbsearch AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEMS "ค้นหาทุน","ค้นหารหัสเบี้ย" 
     DROP-DOWN-LIST
     SIZE 18 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fibranch AS CHARACTER FORMAT "X(2)":U 
      VIEW-AS TEXT 
     SIZE 3 BY 1
     FGCOLOR 7 FONT 6 NO-UNDO.

DEFINE VARIABLE fiCompNo AS CHARACTER FORMAT "X(3)":U 
      VIEW-AS TEXT 
     SIZE 5 BY 1
     FGCOLOR 7 FONT 6 NO-UNDO.

DEFINE VARIABLE fiEffDate AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 15.5 BY 1.05
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fiNetPrm AS DECIMAL FORMAT "->>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 13.5 BY 1
     BGCOLOR 2 FGCOLOR 7 FONT 6 NO-UNDO.

DEFINE VARIABLE fiPremium AS DECIMAL FORMAT "->>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 13.5 BY 1
     FGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiSearch2 AS CHARACTER FORMAT "X(8)":U 
     VIEW-AS FILL-IN 
     SIZE 19.5 BY 1.05
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiSImax AS DECIMAL FORMAT "->>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 13.5 BY 1
     BGCOLOR 14 FONT 6 NO-UNDO.

DEFINE VARIABLE fiSImin AS DECIMAL FORMAT "->>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 13.5 BY 1
     BGCOLOR 10 FONT 6 NO-UNDO.

DEFINE VARIABLE fiStamp AS DECIMAL FORMAT "->>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 13.5 BY 1
     BGCOLOR 3 FGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiTarNo AS CHARACTER FORMAT "X(3)":U INITIAL "0" 
     VIEW-AS FILL-IN 
     SIZE 12 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiTax AS DECIMAL FORMAT "->>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 13.5 BY 1
     BGCOLOR 3 FGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiType AS CHARACTER FORMAT "X(1)":U 
     VIEW-AS FILL-IN 
     SIZE 3.5 BY 1
     BGCOLOR 8 FONT 2 NO-UNDO.

DEFINE VARIABLE fiYearNo AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 3.5 BY 1.05
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-20
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 14 BY 2.14
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-356
     EDGE-PIXELS 0    
     SIZE 51 BY 1.67
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-359
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 13 BY 2.14
     BGCOLOR 4 .

DEFINE RECTANGLE RECT-366
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 50.5 BY 16.91.

DEFINE RECTANGLE RECT-41
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 46.5 BY 8.1
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-451
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 46.5 BY 4.76
     BGCOLOR 8 .

DEFINE BUTTON btnFirst 
     IMAGE-UP FILE "adeicon\pvfirst":U
     IMAGE-DOWN FILE "adeicon\pvfirstd":U
     IMAGE-INSENSITIVE FILE "adeicon\pvfirstx":U
     LABEL "<<" 
     SIZE 5.5 BY 1.19.

DEFINE BUTTON btnLast 
     IMAGE-UP FILE "adeicon\pvlast":U
     IMAGE-DOWN FILE "adeicon\pvlastd":U
     IMAGE-INSENSITIVE FILE "adeicon\pvlastx":U
     LABEL ">>" 
     SIZE 5.5 BY 1.19.

DEFINE BUTTON btnNext 
     IMAGE-UP FILE "adeicon\pvforw":U
     IMAGE-DOWN FILE "adeicon\pvforwd":U
     IMAGE-INSENSITIVE FILE "adeicon\pvforwx":U
     LABEL ">" 
     SIZE 5.5 BY 1.19.

DEFINE BUTTON btnPrev 
     IMAGE-UP FILE "adeicon\pvback":U
     IMAGE-DOWN FILE "adeicon\pvbackd":U
     IMAGE-INSENSITIVE FILE "adeicon\pvbackx":U
     LABEL "<" 
     SIZE 5.5 BY 1.19.

DEFINE RECTANGLE RECT-18
     EDGE-PIXELS 1 GRAPHIC-EDGE    
     SIZE 23.5 BY 1.71
     BGCOLOR 1 .

DEFINE VARIABLE fiTariff30 AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1.05
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY brTariff FOR 
      Tariff, 
      Company SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE brTariff
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS brTariff wgwpar01 _STRUCTURED
  QUERY brTariff NO-LOCK DISPLAY
      Tariff.TarNo COLUMN-LABEL "Tarno" FORMAT "X(4)":U WIDTH 5.83
      Company.AbName + "." + Tariff.Compno COLUMN-LABEL "Company"
            WIDTH 6.83
      Tariff.YearNo COLUMN-LABEL "ปี" FORMAT "X(2)":U WIDTH 5.17
      Tariff.SIMin COLUMN-LABEL "ทุนขั้นต่ำ" FORMAT "->>,>>>,>>9.99":U
            WIDTH 11
      Tariff.Premium FORMAT "->>,>>>,>>9.99":U WIDTH 11.83
      Tariff.Stamp FORMAT ">>9":U
      Tariff.Tax FORMAT "->>,>>9.99":U
      Tariff.NetPrm COLUMN-LABEL "เบี้ยสุทธิ" FORMAT "->>,>>>,>>9.99":U
      Tariff.UDate FORMAT "99/99/9999":U
      Tariff.UserNo FORMAT "X(8)":U
      IF (brstat.Tariff.Premium * (0.4 / 100)) - TRUNCATE (brstat.Tariff.Premium * (0.4 / 100), 0) > 0 THEN TRUNCATE (brstat.Tariff.Premium * (0.4 / 100), 0) + 1 ELSE TRUNCATE (brstat.Tariff.Premium * (0.4 / 100), 0) COLUMN-LABEL "Cal.Stamp" FORMAT ">>9":U
      IF (brstat.Tariff.Premium * (0.4 / 100)) - TRUNCATE (brstat.Tariff.Premium * (0.4 / 100), 0) > 0 THEN (brstat.Tariff.Premium + (TRUNCATE (brstat.Tariff.Premium * (0.4 / 100), 0) + 1)) * (7 / 100) ELSE (brstat.Tariff.Premium + (TRUNCATE (brstat.Tariff.Premium * (0.4 / 100), 0))) * (7 / 100) COLUMN-LABEL "Cal.Tax" FORMAT "->,>>9.99":U
      IF (brstat.Tariff.Premium * (0.4 / 100)) - TRUNCATE (brstat.Tariff.Premium * (0.4 / 100), 0) > 0 THEN brstat.Tariff.Premium + (TRUNCATE (brstat.Tariff.Premium * (0.4 / 100), 0) + 1) +          ((brstat.Tariff.Premium + (TRUNCATE (brstat.Tariff.Premium * (0.4 / 100), 0) + 1)) * (7 / 100 )) ELSE brstat.Tariff.Premium + (TRUNCATE (brstat.Tariff.Premium * (0.4 / 100), 0)) +          ((Tariff.Premium + (TRUNCATE (Tariff.Premium * (0.4 / 100), 0))) * (7 / 100 )) COLUMN-LABEL "Cal.NetPremiumn" FORMAT "->>,>>>,>>9.99":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 67.5 BY 23.1 FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME frMain
     brTariff AT ROW 1.24 COL 2
     btnFirst AT ROW 1.48 COL 71
     btnPrev AT ROW 1.48 COL 76.5
     btnNext AT ROW 1.48 COL 81.5
     btnLast AT ROW 1.48 COL 86.5
     RECT-18 AT ROW 1.24 COL 70
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COLUMN 1 ROW 1
         SIZE 123 BY 24.

DEFINE FRAME frDet
     rbsearch AT ROW 1.48 COL 2.5 NO-LABEL
     fiSearch2 AT ROW 1.48 COL 19 COLON-ALIGNED NO-LABEL
     btnSearch4 AT ROW 1.48 COL 41
     btnSearch5 AT ROW 1.48 COL 46.5
     rbFlag AT ROW 4.29 COL 20.5 COLON-ALIGNED NO-LABEL
     fiType AT ROW 5.38 COL 20.5 COLON-ALIGNED NO-LABEL
     fiTarNo AT ROW 5.38 COL 24 COLON-ALIGNED NO-LABEL
     fiYearNo AT ROW 6.48 COL 20.5 COLON-ALIGNED NO-LABEL
     fiEffDate AT ROW 7.67 COL 20.5 COLON-ALIGNED NO-LABEL
     fiSImin AT ROW 10.19 COL 35.5 RIGHT-ALIGNED NO-LABEL
     fiSImax AT ROW 11.24 COL 35.5 RIGHT-ALIGNED NO-LABEL
     fiPremium AT ROW 12.52 COL 35.5 RIGHT-ALIGNED NO-LABEL
     fiStamp AT ROW 13.57 COL 35.5 RIGHT-ALIGNED NO-LABEL
     fiTax AT ROW 14.62 COL 35.5 RIGHT-ALIGNED NO-LABEL
     fiNetPrm AT ROW 15.67 COL 35.5 RIGHT-ALIGNED NO-LABEL
     btnDelete AT ROW 20.14 COL 26
     btnReturn AT ROW 20.14 COL 40
     fibranch AT ROW 3.1 COL 38 COLON-ALIGNED NO-LABEL
     fiCompNo AT ROW 3.1 COL 21 COLON-ALIGNED NO-LABEL
     buUp1 AT ROW 6.43 COL 26.33 WIDGET-ID 2
     buDown1 AT ROW 7 COL 26.33 WIDGET-ID 4
     "Company Code":60 VIEW-AS TEXT
          SIZE 16 BY .95 AT ROW 3.1 COL 5.5
          FGCOLOR 15 FONT 5
     "บาท" VIEW-AS TEXT
          SIZE 4.5 BY .95 AT ROW 11.24 COL 39
          BGCOLOR 8 
     "TAX" VIEW-AS TEXT
          SIZE 11 BY .95 AT ROW 14.62 COL 7
          BGCOLOR 8 
     "Stamp" VIEW-AS TEXT
          SIZE 7 BY .95 AT ROW 13.57 COL 7
          BGCOLOR 8 
     "   วันที่เริ่มใช้":50 VIEW-AS TEXT
          SIZE 12.5 BY 1 AT ROW 7.67 COL 5.5
          BGCOLOR 8 FGCOLOR 0 FONT 5
     "เบี้ยประกัน" VIEW-AS TEXT
          SIZE 11 BY .95 AT ROW 12.52 COL 7
          BGCOLOR 8 
     "  ทุนประกันภัย":30 VIEW-AS TEXT
          SIZE 14.83 BY 1 AT ROW 8.95 COL 3.5
          BGCOLOR 1 FGCOLOR 7 FONT 5
     "บาท" VIEW-AS TEXT
          SIZE 4.5 BY .95 AT ROW 15.67 COL 38.5
          BGCOLOR 8 
     "   รหัส Tariff":30 VIEW-AS TEXT
          SIZE 12.5 BY 1 AT ROW 5.38 COL 5.5
          BGCOLOR 8 FGCOLOR 0 FONT 5
     "บาท" VIEW-AS TEXT
          SIZE 4.5 BY .95 AT ROW 12.52 COL 38.5
          BGCOLOR 8 
     "        ประเภทรถ":60 VIEW-AS TEXT
          SIZE 14.5 BY .95 AT ROW 4.33 COL 3.5
          BGCOLOR 1 FGCOLOR 7 FONT 5
     "บาท" VIEW-AS TEXT
          SIZE 4.5 BY .95 AT ROW 13.57 COL 38.5
          BGCOLOR 8 
     "Branch":30 VIEW-AS TEXT
          SIZE 7 BY .95 AT ROW 3.1 COL 31.5
          FGCOLOR 15 FONT 5
     "ขั้นต่ำ" VIEW-AS TEXT
          SIZE 10.5 BY .95 AT ROW 10.19 COL 7.5
          BGCOLOR 8 
     "ถึง" VIEW-AS TEXT
          SIZE 10.5 BY .95 AT ROW 11.24 COL 7.5
          BGCOLOR 8 
     "Net Premium" VIEW-AS TEXT
          SIZE 11 BY .95 AT ROW 15.67 COL 7.5
          BGCOLOR 8 
     "บาท" VIEW-AS TEXT
          SIZE 4.5 BY .95 AT ROW 10.19 COL 39
          BGCOLOR 8 
     "บาท" VIEW-AS TEXT
          SIZE 4.5 BY .95 AT ROW 14.62 COL 38.5
          BGCOLOR 8 
     "   Tariff  ปีที่":30 VIEW-AS TEXT
          SIZE 12.5 BY 1 AT ROW 6.48 COL 5.5
          BGCOLOR 8 FGCOLOR 0 FONT 5
     RECT-20 AT ROW 19.81 COL 24.5
     RECT-356 AT ROW 1.14 COL 1.5
     RECT-359 AT ROW 19.81 COL 38.5
     RECT-366 AT ROW 2.91 COL 2
     RECT-41 AT ROW 8.86 COL 3
     RECT-451 AT ROW 4.1 COL 3
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COLUMN 70 ROW 3.14
         SIZE 52 BY 21.19
         BGCOLOR 3 .

DEFINE FRAME frTariff30
     fiTariff30 AT ROW 2.19 COL 18 RIGHT-ALIGNED NO-LABEL
     "     เบี้ยประกันภัย 30":100 VIEW-AS TEXT
          SIZE 17.5 BY 1 AT ROW 1 COL 1
          BGCOLOR 1 FGCOLOR 7 FONT 5
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COLUMN 3 ROW 16.95
         SIZE 23 BY 2.62
         BGCOLOR 8 .


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
  CREATE WINDOW wgwpar01 ASSIGN
         HIDDEN             = YES
         TITLE              = "wgwpar01 - Tariff Setup"
         HEIGHT             = 23.76
         WIDTH              = 122.17
         MAX-HEIGHT         = 33.91
         MAX-WIDTH          = 170.67
         VIRTUAL-HEIGHT     = 33.91
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
IF NOT wgwpar01:LOAD-ICON("wimage/safety.ico":U) THEN
    MESSAGE "Unable to load icon: wimage/safety.ico"
            VIEW-AS ALERT-BOX WARNING BUTTONS OK.
&ENDIF
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW wgwpar01
  VISIBLE,,RUN-PERSISTENT                                               */
/* REPARENT FRAME */
ASSIGN FRAME frDet:FRAME = FRAME frMain:HANDLE
       FRAME frTariff30:FRAME = FRAME frDet:HANDLE.

/* SETTINGS FOR FRAME frDet
   FRAME-NAME Custom                                                    */
/* SETTINGS FOR FILL-IN fibranch IN FRAME frDet
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fiCompNo IN FRAME frDet
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fiNetPrm IN FRAME frDet
   NO-ENABLE ALIGN-R                                                    */
/* SETTINGS FOR FILL-IN fiPremium IN FRAME frDet
   NO-ENABLE ALIGN-R                                                    */
/* SETTINGS FOR FILL-IN fiSImax IN FRAME frDet
   NO-ENABLE ALIGN-R                                                    */
/* SETTINGS FOR FILL-IN fiSImin IN FRAME frDet
   NO-ENABLE ALIGN-R                                                    */
/* SETTINGS FOR FILL-IN fiStamp IN FRAME frDet
   NO-ENABLE ALIGN-R                                                    */
/* SETTINGS FOR FILL-IN fiTax IN FRAME frDet
   NO-ENABLE ALIGN-R                                                    */
/* SETTINGS FOR FILL-IN fiType IN FRAME frDet
   NO-ENABLE                                                            */
/* SETTINGS FOR COMBO-BOX rbsearch IN FRAME frDet
   ALIGN-L                                                              */
/* SETTINGS FOR RECTANGLE RECT-20 IN FRAME frDet
   NO-ENABLE                                                            */
/* SETTINGS FOR RECTANGLE RECT-41 IN FRAME frDet
   NO-ENABLE                                                            */
/* SETTINGS FOR FRAME frMain
                                                                        */
/* BROWSE-TAB brTariff RECT-18 frMain */
/* SETTINGS FOR RECTANGLE RECT-18 IN FRAME frMain
   NO-ENABLE                                                            */
/* SETTINGS FOR FRAME frTariff30
                                                                        */
/* SETTINGS FOR FILL-IN fiTariff30 IN FRAME frTariff30
   ALIGN-R                                                              */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(wgwpar01)
THEN wgwpar01:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE brTariff
/* Query rebuild information for BROWSE brTariff
     _TblList          = "brstat.Tariff,brstat.Company OF brstat.Tariff"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _FldNameList[1]   > brstat.Tariff.TarNo
"Tariff.TarNo" "Tarno" ? "character" ? ? ? ? ? ? no ? no no "5.83" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[2]   > "_<CALC>"
"Company.AbName + ""."" + Tariff.Compno" "Company" ? ? ? ? ? ? ? ? no ? no no "6.83" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   > brstat.Tariff.YearNo
"Tariff.YearNo" "ปี" ? "character" ? ? ? ? ? ? no ? no no "5.17" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   > brstat.Tariff.SIMin
"Tariff.SIMin" "ทุนขั้นต่ำ" ? "decimal" ? ? ? ? ? ? no ? no no "11" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   > brstat.Tariff.Premium
"Tariff.Premium" ? ? "decimal" ? ? ? ? ? ? no ? no no "11.83" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[6]   = brstat.Tariff.Stamp
     _FldNameList[7]   = brstat.Tariff.Tax
     _FldNameList[8]   > brstat.Tariff.NetPrm
"Tariff.NetPrm" "เบี้ยสุทธิ" ? "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[9]   = brstat.Tariff.UDate
     _FldNameList[10]   = brstat.Tariff.UserNo
     _FldNameList[11]   > "_<CALC>"
"IF (brstat.Tariff.Premium * (0.4 / 100)) - TRUNCATE (brstat.Tariff.Premium * (0.4 / 100), 0) > 0 THEN TRUNCATE (brstat.Tariff.Premium * (0.4 / 100), 0) + 1 ELSE TRUNCATE (brstat.Tariff.Premium * (0.4 / 100), 0)" "Cal.Stamp" ">>9" ? ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[12]   > "_<CALC>"
"IF (brstat.Tariff.Premium * (0.4 / 100)) - TRUNCATE (brstat.Tariff.Premium * (0.4 / 100), 0) > 0 THEN (brstat.Tariff.Premium + (TRUNCATE (brstat.Tariff.Premium * (0.4 / 100), 0) + 1)) * (7 / 100) ELSE (brstat.Tariff.Premium + (TRUNCATE (brstat.Tariff.Premium * (0.4 / 100), 0))) * (7 / 100)" "Cal.Tax" "->,>>9.99" ? ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[13]   > "_<CALC>"
"IF (brstat.Tariff.Premium * (0.4 / 100)) - TRUNCATE (brstat.Tariff.Premium * (0.4 / 100), 0) > 0 THEN brstat.Tariff.Premium + (TRUNCATE (brstat.Tariff.Premium * (0.4 / 100), 0) + 1) +          ((brstat.Tariff.Premium + (TRUNCATE (brstat.Tariff.Premium * (0.4 / 100), 0) + 1)) * (7 / 100 )) ELSE brstat.Tariff.Premium + (TRUNCATE (brstat.Tariff.Premium * (0.4 / 100), 0)) +          ((Tariff.Premium + (TRUNCATE (Tariff.Premium * (0.4 / 100), 0))) * (7 / 100 ))" "Cal.NetPremiumn" "->>,>>>,>>9.99" ? ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _Query            is NOT OPENED
*/  /* BROWSE brTariff */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME wgwpar01
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wgwpar01 wgwpar01
ON END-ERROR OF wgwpar01 /* wgwpar01 - Tariff Setup */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wgwpar01 wgwpar01
ON WINDOW-CLOSE OF wgwpar01 /* wgwpar01 - Tariff Setup */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME brTariff
&Scoped-define FRAME-NAME frMain
&Scoped-define SELF-NAME brTariff
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brTariff wgwpar01
ON MOUSE-SELECT-DBLCLICK OF brTariff IN FRAME frMain
DO:
  GET CURRENT brTariff.
  FIND CURRENT brStat.Tariff NO-LOCK NO-ERROR.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brTariff wgwpar01
ON ROW-DISPLAY OF brTariff IN FRAME frMain
DO:
  DEF VAR A AS DECI.
  DEF VAR B AS DECI.

    IF (brStat.Tariff.Premium * (0.4 / 100)) - TRUNCATE (brStat.Tariff.Premium * (0.4 / 100), 0) > 0 
    THEN 
      A = (brStat.Tariff.Premium + (TRUNCATE (brStat.Tariff.Premium * (0.4 / 100), 0) + 1)) + 
          ((brStat.Tariff.Premium + (TRUNCATE (brStat.Tariff.Premium * (0.4 / 100), 0) + 1)) * (7 / 100 )).
    ELSE 
      B = (brStat.Tariff.Premium + (TRUNCATE (brStat.Tariff.Premium * (0.4 / 100), 0))) +
          ((brStat.Tariff.Premium + (TRUNCATE (brStat.Tariff.Premium * (0.4 / 100), 0))) * (7 / 100 )).

   /*IF Tariff.Stamp <> TRUNCATE (Tariff.Premium * (0.4 / 100), 0) and*
     Tariff.NetPrm <> TRUNCATE (Tariff.Premium * (0.4 / 100), 0) + 1 THEN DO:*/
   
    IF brStat.Tariff.NetPrm <> A AND brStat.Tariff.NetPrm <> B  THEN DO:
       brStat.Tariff.Tarno:BGCOLOR IN BROWSE brTariff = 13 no-error.
       brStat.Tariff.Stamp:BGCOLOR IN BROWSE brTariff = 13 no-error.
       brStat.Tariff.Tax:BGCOLOR IN BROWSE brTariff = 13 no-error.
       brStat.Tariff.NetPrm:BGCOLOR IN BROWSE brTariff = 13 no-error.

       brStat.Tariff.Tarno:FGCOLOR IN BROWSE brTariff = 17 no-error.
       brStat.Tariff.Stamp:FGCOLOR IN BROWSE brTariff = 17 no-error.
       brStat.Tariff.Tax:FGCOLOR IN BROWSE brTariff = 17 no-error.
       brStat.Tariff.NetPrm:FGCOLOR IN BROWSE brTariff = 17 no-error. 
      
       brStat.Tariff.Tarno:FONT IN BROWSE brTariff = 6 no-error.
       brStat.Tariff.Stamp:FONT IN BROWSE brTariff = 6 no-error.
       brStat.Tariff.Tax:FONT IN BROWSE brTariff = 6 no-error.
       brStat.Tariff.NetPrm:FONT IN BROWSE brTariff = 6 no-error.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brTariff wgwpar01
ON ROW-LEAVE OF brTariff IN FRAME frMain
DO:
  brStat.Tariff.Tarno:BGCOLOR IN BROWSE brTariff = 13 no-error.
  brStat.Tariff.Stamp:BGCOLOR IN BROWSE brTariff = 13 no-error.
  brStat.Tariff.Tax:BGCOLOR IN BROWSE brTariff = 13 no-error.
  brStat.Tariff.NetPrm:BGCOLOR IN BROWSE brTariff = 13 no-error.

  brStat.Tariff.Tarno:FGCOLOR IN BROWSE brTariff = 17 no-error.
  brStat.Tariff.Stamp:FGCOLOR IN BROWSE brTariff = 17 no-error.
  brStat.Tariff.Tax:FGCOLOR IN BROWSE brTariff = 17 no-error.
  brStat.Tariff.NetPrm:FGCOLOR IN BROWSE brTariff = 17 no-error. 
  
  brStat.Tariff.Tarno:FONT IN BROWSE brTariff = 6 no-error.
  brStat.Tariff.Stamp:FONT IN BROWSE brTariff = 6 no-error.
  brStat.Tariff.Tax:FONT IN BROWSE brTariff = 6 no-error.
  brStat.Tariff.NetPrm:FONT IN BROWSE brTariff = 6 no-error. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brTariff wgwpar01
ON VALUE-CHANGED OF brTariff IN FRAME frMain
DO:
  FIND FIRST brStat.Company WHERE brStat.Company.CompNo = nv_Compno NO-LOCK NO-ERROR.
   FIND CURRENT brStat.Tariff NO-LOCK NO-ERROR.  
   IF NOT AVAIL brStat.TARIFF THEN DO:
      MESSAGE "ไม่พบข้อมูล TARIFF  : " + brStat.Company.Name VIEW-AS AlERT-BOX INFORMATION.
   END.
   ELSE DO:
   ASSIGN
     TypeMotor = SUBSTRING(brStat.Tariff.TarNo,1,1)
     TariffNo  = SUBSTRING(brStat.Tariff.TarNo,2,4)
     nv_Tarno  = brstat.Tariff.Tarno
     rbflag    = IF typemotor = "O" THEN "รถเก่า"                 
                 ELSE IF typemotor = "N" THEN "รถใหม่"
                 ELSE "รถใหม่".
   DISPLAY
        brStat.Tariff.YearNo  @ fiYearNo
        rbflag        
        typemotor      @ fiType
        TariffNo       @ fiTarNo
        brStat.Tariff.EffDate @ fiEffDate
        brStat.Tariff.SImin   @ fiSImin
        brStat.Tariff.SImax   @ fiSImax
        brStat.Tariff.Premium @ fiPremium
        brStat.Tariff.Stamp   @ fiStamp
        brStat.Tariff.TAX     @ fitax
        brStat.Tariff.NetPrm  @ fiNetPrm        
     WITH FRAME frDet.

   DISP  brStat.Tariff.ExtPrm  @ fiTariff30 WITH FRAME frTariff30.
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frDet
&Scoped-define SELF-NAME btnDelete
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnDelete wgwpar01
ON CHOOSE OF btnDelete IN FRAME frDet /* ลบ */
DO:
  DEF VAR logAns      AS LOGI INIT No.  
  
      {&WINDOW-NAME}:Hidden = Yes.  
      RUN wgw\wgwdel01.
      {&WINDOW-NAME}:Hidden = NO.   
      RUN ProcUpdateQ.
      APPLY "VALUE-CHANGED" TO brTariff IN FRAME frMain.  
      RUN ProcDisable IN THIS-PROCEDURE.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frMain
&Scoped-define SELF-NAME btnFirst
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnFirst wgwpar01
ON CHOOSE OF btnFirst IN FRAME frMain /* << */
DO:
  GET FIRST brTariff.
  IF NOT AVAIL brStat.Tariff THEN RETURN NO-APPLY.  
  REPOSITION brTariff TO ROWID ROWID (brStat.Tariff).
  APPLY "VALUE-CHANGED" TO brTariff.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnLast
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnLast wgwpar01
ON CHOOSE OF btnLast IN FRAME frMain /* >> */
DO:
  GET LAST brTariff.
  IF NOT AVAIL brStat.Tariff THEN RETURN NO-APPLY.
  REPOSITION brTariff TO ROWID ROWID (brStat.Tariff).
  APPLY "VALUE-CHANGED" TO brTariff.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnNext
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnNext wgwpar01
ON CHOOSE OF btnNext IN FRAME frMain /* > */
DO:
  GET NEXT brTariff.
  IF NOT AVAIL brStat.Tariff THEN RETURN NO-APPLY.
  REPOSITION brTariff TO ROWID ROWID (brStat.Tariff).
  APPLY "VALUE-CHANGED" TO brTariff.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnPrev
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnPrev wgwpar01
ON CHOOSE OF btnPrev IN FRAME frMain /* < */
DO:
  GET PREV brTariff.
  IF NOT AVAIL brStat.Tariff THEN RETURN NO-APPLY.
  REPOSITION brTariff TO ROWID ROWID (brStat.Tariff).
  APPLY "VALUE-CHANGED" TO brTariff.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frDet
&Scoped-define SELF-NAME btnReturn
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnReturn wgwpar01
ON CHOOSE OF btnReturn IN FRAME frDet /* EXIT */
DO:
  APPLY "CLOSE" TO THIS-PROCEDURE.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnSearch4
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnSearch4 wgwpar01
ON CHOOSE OF btnSearch4 IN FRAME frDet /* PREV */
DO:

   IF rbSearch = "ค้นหาทุน"  AND fiSearch2 <> " "  THEN DO:
    FIND PREV brStat.Tariff WHERE 
            brStat.Tariff.CompNo = nv_Compno AND
            brStat.Tariff.SIMin  =  INT(fiSearch2)  NO-LOCK NO-ERROR.
    IF NOT AVAIL brStat.Tariff THEN RETURN NO-APPLY.
    IF AVAIL brStat.Tariff THEN DO:
       rPol = ROWID (brStat.Tariff).
       REPOSITION brTariff TO ROWID rPol.

       FIND CURRENT brStat.Tariff NO-LOCK.
            ASSIGN
              TypeMotor = SUBSTRING(brStat.Tariff.TarNo,1,1)
              TariffNo  = SUBSTRING(brStat.Tariff.TarNo,2,4)
              rbflag    = IF typemotor = "N" THEN "รถใหม่"
                          ELSE IF typemotor = "O" THEN "รถเก่า"
                          ELSE IF typemotor = "R" THEN "รถต่ออายุ"
                          ELSE IF typemotor = "F" THEN "รถ STAFF"
                          ELSE "".    
             DISPLAY  
                brStat.Tariff.YearNo  @ fiYearNo
                rbflag      
                typemotor      @ fiType
                TariffNo       @ fiTarNo
                brStat.Tariff.EffDate @ fiEffDate
                brStat.Tariff.SImin   @ fiSImin
                brStat.Tariff.SImax   @ fiSImax
                brStat.Tariff.Premium @ fiPremium
                brStat.Tariff.Stamp   @ fiStamp
                brStat.Tariff.TAX     @ fitax
                brStat.Tariff.NetPrm  @ fiNetPrm   WITH FRAME frDet.
          END.

   END.
   IF rbSearch = "ค้นหารหัสเบี้ย"  AND fiSearch2 <> " "  THEN DO:
    FIND PREV Tariff WHERE
              Tariff.CompNo = nv_Compno     AND
              Tariff.TarNo  = fiSearch2 NO-LOCK NO-ERROR.
      IF NOT AVAIL Tariff THEN RETURN NO-APPLY.
      IF AVAIL Tariff THEN DO:
         rPol = ROWID (Tariff).
         REPOSITION brTariff TO ROWID rPol.

         FIND CURRENT Tariff NO-LOCK.
              ASSIGN
                TypeMotor = SUBSTRING(Tariff.TarNo,1,1)
                TariffNo  = SUBSTRING(Tariff.TarNo,2,4)
                rbflag    = IF typemotor = "N" THEN "รถใหม่"
                            ELSE IF typemotor = "O" THEN "รถเก่า"
                            ELSE IF typemotor = "R" THEN "รถต่ออายุ"
                            ELSE IF typemotor = "F" THEN "รถ STAFF"
                            ELSE "".     
               DISPLAY  
                Tariff.YearNo   @ fiYearNo
                rbflag        
                typemotor       @ fiType
                TariffNo        @ fiTarNo
                Tariff.EffDate  @ fiEffDate
                Tariff.SImin    @ fiSImin
                Tariff.SImax    @ fiSImax
                Tariff.Premium  @ fiPremium
                Tariff.Stamp    @ fiStamp
                Tariff.TAX      @ fitax
                Tariff.NetPrm   @ fiNetPrm   WITH FRAME frDet.
          END.
   END.          
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnSearch5
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnSearch5 wgwpar01
ON CHOOSE OF btnSearch5 IN FRAME frDet /* NEXT */
DO:
  IF rbSearch = "ค้นหาทุน"  AND fiSearch2 <> " "  THEN DO:
       FIND NEXT brStat.Tariff WHERE 
          brStat.Tariff.CompNo = nv_Compno  AND
          brStat.Tariff.SIMin  = INT(fiSearch2) NO-LOCK NO-ERROR.
      IF NOT AVAIL Tariff THEN RETURN NO-APPLY.
     ELSE
     rPol = ROWID (brStat.Tariff).
     REPOSITION brTariff TO ROWID rPol.
     FIND CURRENT brStat.Tariff NO-LOCK.
          ASSIGN
            TypeMotor = SUBSTRING(brStat.Tariff.TarNo,1,1)
            TariffNo  = SUBSTRING(brStat.Tariff.TarNo,2,4)
            rbflag    = IF typemotor = "N" THEN "รถใหม่"
                        ELSE IF typemotor = "O" THEN "รถเก่า"
                        ELSE IF typemotor = "R" THEN "รถต่ออายุ"
                        ELSE IF typemotor = "F" THEN "รถ STAFF"
                        ELSE "".
            DISPLAY  
              brStat.Tariff.YearNo  @ fiYearNo
              rbflag
              typemotor             @ fiType
              TariffNo              @ fiTarNo
              brStat.Tariff.EffDate @ fiEffDate
              brStat.Tariff.SImin   @ fiSImin
              brStat.Tariff.SImax   @ fiSImax
              brStat.Tariff.Premium @ fiPremium
              brStat.Tariff.Stamp   @ fiStamp
              brStat.Tariff.TAX     @ fitax
              brStat.Tariff.NetPrm  @ fiNetPrm   WITH FRAME frDet.
   END.
   IF rbSearch = "ค้นหารหัสเบี้ย"  AND fiSearch2 <> " "  THEN DO:
    FIND NEXT brStat.Tariff WHERE
              brStat.Tariff.CompNo = nv_Compno     AND
              brStat.Tariff.TarNo  = fiSearch2 NO-LOCK NO-ERROR.
     IF NOT AVAIL brStat.Tariff THEN RETURN NO-APPLY.
     IF AVAIL brStat.Tariff THEN DO:
        rPol = ROWID (brStat.Tariff).
        REPOSITION brTariff TO ROWID rPol.

        FIND CURRENT brStat.Tariff NO-LOCK.
             ASSIGN
                TypeMotor = SUBSTRING(brStat.Tariff.TarNo,1,1)
                TariffNo  = SUBSTRING(brStat.Tariff.TarNo,2,4)
                rbflag    = IF typemotor = "N" THEN "รถใหม่"
                            ELSE IF typemotor = "O" THEN "รถเก่า"
                            ELSE IF typemotor = "R" THEN "รถต่ออายุ"
                            ELSE IF typemotor = "F" THEN "รถ STAFF"
                            ELSE "".   
                DISPLAY  
                   brStat.Tariff.YearNo  @ fiYearNo
                   rbflag        
                   typemotor             @ fiType
                   TariffNo              @ fiTarNo
                   brStat.Tariff.EffDate @ fiEffDate
                   brStat.Tariff.SImin   @ fiSImin
                   brStat.Tariff.SImax   @ fiSImax
                   brStat.Tariff.Premium @ fiPremium
                   brStat.Tariff.Stamp   @ fiStamp
                   brStat.Tariff.TAX     @ fitax
                   brStat.Tariff.NetPrm  @ fiNetPrm   WITH FRAME frDet.
          END.       
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buDown1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buDown1 wgwpar01
ON CHOOSE OF buDown1 IN FRAME frDet
DO:
    fiYearNo = IF INTEGER (fiYearNo) - 1 <= 1 THEN "1" ELSE STRING (INTEGER (fiYearNo) - 1) .
    DISP fiYearNo WITH FRAME frDet.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buUp1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buUp1 wgwpar01
ON CHOOSE OF buUp1 IN FRAME frDet
DO:
    fiYearNo = STRING (INTEGER (fiYearNo) + 1).
    DISP fiYearNo WITH FRAME frDet.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiNetPrm
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiNetPrm wgwpar01
ON LEAVE OF fiNetPrm IN FRAME frDet
DO:
      fiPremium = input fiPremium.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiPremium
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiPremium wgwpar01
ON LEAVE OF fiPremium IN FRAME frDet
DO:
    fiPremium = INPUT fiPremium.
    
    IF (fiPremium * (0.4 / 100)) - TRUNCATE (fiPremium * (0.4 / 100), 0) > 0 THEN 
        fiStamp = TRUNCATE (fiPremium * (0.4 / 100), 0) + 1 .
    ELSE 
        fiStamp = TRUNCATE (fiPremium * (0.4 / 100), 0).
    
    IF (fiPremium * (0.4 / 100)) - TRUNCATE (fiPremium * (0.4 / 100), 0) > 0 THEN 
        fiTax = (fiPremium + TRUNCATE (fiPremium * (0.4 / 100), 0) + 1) * (7 / 100).
    ELSE 
        fiTax = (fiPremium + TRUNCATE (fiPremium * (0.4 / 100), 0)) * (7 / 100).
            
    DISP fiStamp fiTax WITH FRAME frDet.

    ASSIGN 
      {&SELF-NAME}
      fiNetPrm = fiPremium + fiStamp + fiTAX.
      
    DISP fiNetPrm WITH FRAME frDet.        
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiSearch2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiSearch2 wgwpar01
ON RETURN OF fiSearch2 IN FRAME frDet
DO:
   ASSIGN FRAME frDet rbSearch.

  fiSearch2 = CAPS (INPUT fiSearch2).
  DISP fisearch2 WITH FRAME frdet.
  ASSIGN 
      fiSearch2.
          
  IF fiSearch2 = ""  THEN RETURN NO-APPLY.     
  IF rbSearch = "ค้นหารหัสเบี้ย"  AND fiSearch2 <> " "  THEN DO:
    FIND FIRST brStat.Tariff WHERE  brStat.Tariff.CompNo = nv_Compno    AND
                                    brStat.Tariff.TarNo  = fiSearch2  NO-LOCK NO-ERROR.
          IF NOT AVAIL brStat.Tariff THEN DO:
               Message "ไม่พบรหัส Tariff ที่ต้องการค้นหา  " SKIP
                                "Tariff  No  = "  fiSearch2   view-as alert-box ERROR .
               APPLY "ENTRY" TO fiSearch2.
               RETURN NO-APPLY.
          END. 
          ELSE DO:
              rPol = ROWID (brStat.Tariff).
              REPOSITION brTariff TO ROWID rPol.

              FIND CURRENT brStat.Tariff NO-LOCK.
                   ASSIGN
                      TypeMotor = SUBSTRING(brStat.Tariff.TarNo,1,1)
                      TariffNo = SUBSTRING(brStat.Tariff.TarNo,2,4)
                      rbflag  = IF typemotor = "N" THEN "รถใหม่"
                                ELSE IF typemotor = "O" THEN "รถเก่า"
                                ELSE IF typemotor = "R" THEN "รถต่ออายุ"
                                ELSE IF typemotor = "P" THEN "รถพิเศษ"
                                ELSE "".
                 DISPLAY  
                      brStat.Tariff.YearNo     @ fiYearNo
                      rbflag
                      typemotor                @ fiType
                      TariffNo                 @ fiTarNo
                      brStat.Tariff.EffDate    @ fiEffDate
                      brStat.Tariff.SImin      @ fiSImin
                      brStat.Tariff.SImax      @ fiSImax
                      brStat.Tariff.Premium    @ fiPremium
                      brStat.Tariff.Stamp      @ fiStamp
                      brStat.Tariff.TAX        @ fitax
                      brStat.Tariff.NetPrm     @ fiNetPrm   WITH FRAME frDet.
                   
           END.      
   END.
   IF rbSearch = "ค้นหาทุน"  AND fiSearch2 <> " "  THEN DO:
      FIND FIRST brStat.Tariff WHERE  brStat.Tariff.CompNo = nv_Compno    AND
                                      brStat.Tariff.SIMin  = INT(fiSearch2)  NO-LOCK NO-ERROR.
          IF NOT AVAIL brStat.Tariff THEN DO:
               Message "ไม่พบข้อมูลทุนที่ต้องการค้นหา  " SKIP
                       "ทุนประกัน = "  fiSearch2   view-as alert-box ERROR .
               APPLY "ENTRY" TO fiSearch2.
               RETURN NO-APPLY.
          END. 
          ELSE DO:
              rPol = ROWID (brStat.Tariff).
              REPOSITION brTariff TO ROWID rPol.

              FIND CURRENT brStat.Tariff NO-LOCK.
                   ASSIGN
                      TypeMotor = SUBSTRING(brStat.Tariff.TarNo,1,1)
                      TariffNo  = SUBSTRING(brStat.Tariff.TarNo,2,4)
                      rbflag    = IF typemotor = "N" THEN "รถใหม่"
                                  ELSE IF typemotor = "O" THEN "รถเก่า"
                                  ELSE IF typemotor = "R" THEN "รถต่ออายุ"
                                  ELSE IF typemotor = "P" THEN "รถพิเศษ"
                                  ELSE "".
                 DISPLAY  
                      brStat.Tariff.YearNo     @ fiYearNo
                      rbflag        
                      typemotor                @ fiType
                      TariffNo                 @ fiTarNo
                      brStat.Tariff.EffDate    @ fiEffDate
                      brStat.Tariff.SImin      @ fiSImin
                      brStat.Tariff.SImax      @ fiSImax
                      brStat.Tariff.Premium    @ fiPremium
                      brStat.Tariff.Stamp      @ fiStamp
                      brStat.Tariff.TAX        @ fitax
                      brStat.Tariff.NetPrm     @ fiNetPrm   WITH FRAME frDet.
                   
           END. 
   END.

      
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiSImax
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiSImax wgwpar01
ON LEAVE OF fiSImax IN FRAME frDet
DO:
      ASSIGN fiSImax.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiSImin
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiSImin wgwpar01
ON LEAVE OF fiSImin IN FRAME frDet
DO:
      ASSIGN 
         fiSImin
         fiSImax = fiSImin.
         
      DISP fiSImax WITH FRAME frDet.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiStamp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiStamp wgwpar01
ON LEAVE OF fiStamp IN FRAME frDet
DO:

      ASSIGN 
        {&SELF-NAME}
        fiNetPrm = fiPremium + fiStamp + fiTAX.
        
      DISP fiNetPrm WITH FRAME frDet.        
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiTarNo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiTarNo wgwpar01
ON LEAVE OF fiTarNo IN FRAME frDet
DO:
      ASSIGN  fiTarNo.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiTax
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiTax wgwpar01
ON LEAVE OF fiTax IN FRAME frDet
DO:
      ASSIGN 
        {&SELF-NAME}
         fiNetPrm = fiPremium + fiStamp + fiTAX.        
         
      DISP fiNetPrm WITH FRAME frDet.        
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiType
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiType wgwpar01
ON LEAVE OF fiType IN FRAME frDet
DO:
  fiType = CAPS(INPUT fiType).
  DISP fiType WITH FRAME frDet.
  
/*เปิดช่อง fiType ให้ User สามารถคีย์เองได้แต่ คีย์ได้เฉพาะ N O S K(สินพล) ถ้าเป็น CVA จะมี Y ด้วย  */
 /*   IF gComp = "01" THEN /*CVA*/ 
 *         IF fiType <> "N" AND fiType <> "O" AND fiType <> "Y" AND 
 *              fiType <> "S" AND fiType <> "K" THEN DO:
 *             MESSAGE "Tariff must be begin 'N' or 'O' or 'S' or 'K' or 'Y' " SKIP(1)
 *                 "                     N  =  New Car" SKIP
 *                 "                     O  =  Old Car" SKIP
 *                 "                     Y  =  YAMAHA" SKIP
 *                 "                     S  =  SUZUKI" SKIP
 *                 "                     K  =  KAWASAKI" SKIP VIEW-AS ALERT-BOX ERROR.
 *             APPLY "ENTRY" TO fiType.
 *             RETURN NO-APPLY.
 *         END. 
 *         
 *     IF gComp = "02" THEN /*สินพล*/
 *         IF fiType <> "N" AND fiType <> "O" AND fiType <> "S" AND fiType <> "K" THEN DO:
 *             MESSAGE "Tariff must be begin 'N' or 'O' or 'S' or 'K' " SKIP(1)
 *                 "                     N  =  New Car" SKIP
 *                 "                     O  =  Old Car" SKIP
 *                 "                     S  =  SUZUKI" SKIP
 *                 "                     K  =  KAWASAKI" SKIP VIEW-AS ALERT-BOX ERROR.
 *             APPLY "ENTRY" TO fiType.
 *             RETURN NO-APPLY.
 *         END.*/
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiYearNo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiYearNo wgwpar01
ON LEAVE OF fiYearNo IN FRAME frDet
DO:
    ASSIGN fiYearNo.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME rbFlag
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL rbFlag wgwpar01
ON MOUSE-SELECT-DBLCLICK OF rbFlag IN FRAME frDet
DO:
   APPLY "ENTRY" TO fiTarNo.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL rbFlag wgwpar01
ON VALUE-CHANGED OF rbFlag IN FRAME frDet
DO:
DEF VAR vTarNo AS CHAR INIT "".

  rbflag = INPUT rbflag.
  IF rbFlag = "รถใหม่" THEN DO:
     FIND LAST brStat.Tariff WHERE 
               brStat.Tariff.Compno = nv_Compno  AND 
               SUBSTRING(brStat.Tariff.TarNo,1,1 ) = "N" NO-LOCK NO-ERROR.
      IF AVAIL Tariff THEN DO:
         ASSIGN
            fiType   = SUBSTRING(brStat.Tariff.TarNo,1,1)
            fiTarNo = STRING(INTEGER(SUBSTRING(brStat.Tariff.TarNo,2,3 ) ) + 1,"999" ).
            DISP fiType fiTarNo WITH FRAME frDet.
            APPLY "ENTRY" TO fiTarNo.
            RETURN NO-APPLY.
      END.
      IF NOT AVAIL brStat.Tariff THEN DO:
         DISP
            "N"   @  fiType
            "001" @  fiTarNo 
         WITH FRAME frDet.
         APPLY "ENTRY" TO fiTarNo.
         RETURN NO-APPLY.
      END.
  END.
  IF rbFlag = "รถเก่า"  THEN DO:
     FIND LAST brStat.Tariff WHERE 
               brStat.Tariff.Compno = nv_Compno AND
               SUBSTRING(brStat.Tariff.TarNo,1,1 ) = "O" NO-LOCK NO-ERROR.
       IF AVAIL brStat.Tariff THEN DO:
          ASSIGN
            fiType   = SUBSTRING(brStat.Tariff.TarNo,1,1)
            fiTarNo  = STRING(INTEGER(SUBSTRING(brStat.Tariff.TarNo,2,3 ) ) + 1,"999" ).
            DISP fiType fiTarNo WITH FRAME frDet.
       END.
       IF NOT AVAIL brStat.Tariff THEN DO:
          DISP
            "O"   @ fiType
            "001" @ fiTarNo
          WITH FRAME frDet.
       END.
   END.
   IF rbFlag = "รถต่ออายุ" THEN DO:
      FIND LAST brStat.Tariff WHERE 
                brStat.Tariff.Compno = nv_Compno AND
                SUBSTRING(brStat.Tariff.TarNo,1,1 ) = "R" NO-LOCK NO-ERROR.
       IF AVAIL brStat.Tariff THEN DO:
          ASSIGN
             fiType   = SUBSTRING(brStat.Tariff.TarNo,1,1)
             fiTarNo = STRING(INTEGER(SUBSTRING(brStat.Tariff.TarNo,2,3 ) ) + 1,"999" ).
             DISP fiType fiTarNo WITH FRAME frDet.
       END.
       IF NOT AVAIL brStat.Tariff THEN DO:
          DISP
            "R"   @ fiType
            "001" @ fiTarNo
          WITH FRAME frDet.
       END.
   END.
   IF rbFlag = "รถ STAFF" THEN DO:
      FIND LAST brStat.Tariff WHERE 
                brStat.Tariff.Compno = nv_Compno AND
                SUBSTRING(brStat.Tariff.TarNo,1,1 ) = "F" NO-LOCK NO-ERROR.
        IF AVAIL Tariff THEN DO:
           ASSIGN
             fiType   = SUBSTRING(brStat.Tariff.TarNo,1,1)
             fiTarNo = STRING(INTEGER(SUBSTRING(brStat.Tariff.TarNo,2,3 ) ) + 1,"999" ).
        END.
        IF NOT AVAIL brStat.Tariff THEN DO:
           DISP
             "F"   @ fiType
             "001" @ fiTarNo
           WITH FRAME frDet.
        END.
   END.
    APPLY "ENTRY" TO fiTarNo.
     RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME rbsearch
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL rbsearch wgwpar01
ON VALUE-CHANGED OF rbsearch IN FRAME frDet
DO:
  ASSIGN FRAME frDet rbSearch.
  nv_Search = rbSearch.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK wgwpar01 


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
  
  SESSION:DATA-ENTRY-RETURN = Yes.
  RUN WUT\WUTDICEN  (wgwpar01:HANDLE). 
  
  RECT-18:MOVE-TO-TOP().

FIND FIRST Company WHERE Company.compno = nv_compno NO-LOCK NO-ERROR.
 
 IF Company.PNameFlag = NO THEN
    HIDE Fram frTariff30.
 ELSE     VIEW Fram frTariff30.

  

  ASSIGN rbSearch = "ค้นหาทุน"
  nv_Search = rbSearch.
  DISP rbSearch WITH FRAME frDet.
  
  RUN ProcAddComp IN THIS-PROCEDURE.
  RUN ProcDisable IN THIS-PROCEDURE.

  RUN ProcUpdateQ.  
  APPLY "VALUE-CHANGED" TO brTariff.

  IF NOT THIS-PROCEDURE:PERSISTENT THEN
  WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI wgwpar01  _DEFAULT-DISABLE
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
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(wgwpar01)
  THEN DELETE WIDGET wgwpar01.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI wgwpar01  _DEFAULT-ENABLE
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
  ENABLE brTariff btnFirst btnPrev btnNext btnLast 
      WITH FRAME frMain IN WINDOW wgwpar01.
  {&OPEN-BROWSERS-IN-QUERY-frMain}
  DISPLAY rbsearch fiSearch2 rbFlag fiType fiTarNo fiYearNo fiEffDate fiSImin 
          fiSImax fiPremium fiStamp fiTax fiNetPrm fibranch fiCompNo 
      WITH FRAME frDet IN WINDOW wgwpar01.
  ENABLE rbsearch fiSearch2 btnSearch4 btnSearch5 rbFlag fiTarNo fiYearNo 
         fiEffDate btnDelete btnReturn buUp1 buDown1 RECT-356 RECT-359 RECT-366 
         RECT-451 
      WITH FRAME frDet IN WINDOW wgwpar01.
  {&OPEN-BROWSERS-IN-QUERY-frDet}
  DISPLAY fiTariff30 
      WITH FRAME frTariff30 IN WINDOW wgwpar01.
  ENABLE fiTariff30 
      WITH FRAME frTariff30 IN WINDOW wgwpar01.
  {&OPEN-BROWSERS-IN-QUERY-frTariff30}
  VIEW wgwpar01.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE ProcAddComp wgwpar01 
PROCEDURE ProcAddComp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FIND FIRST brStat.Company USE-INDEX Company01 WHERE brStat.Company.CompNo = nv_Compno NO-LOCK NO-ERROR.
        ASSIGN
               vCompName = Trim(brStat.Company.Name)
               vCompAB   = brStat.Company.ABName
               fiCompNo  = brStat.Company.CompNo
               fiBranch  = brStat.Company.Branch.
DISP fiCompNo fiBranch WITH FRAME frDet.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE ProcDisable wgwpar01 
PROCEDURE ProcDisable :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/  
  DISABLE  ALL WITH FRAME frDet.
  DISABLE  ALL WITH FRAME frTariff30.
  
  fiType:BGCOLOR = 10.
  ENABLE btnSearch4 WITH FRAME frDet.
  ENABLE btnSearch5 WITH FRAME frDet.
  ENABLE brTariff    WITH FRAME frmain.  
  ENABLE fiSearch2   WITH FRAME frDet.  
  /*ENABLE btnAdd      WITH FRAME frDet.  
  ENABLE btnUpdate   WITH FRAME frDet.  */
  ENABLE btnDelete   WITH FRAME frDet.  
  ENABLE btnReturn   WITH FRAME frDet.  
  ENABLE rbSearch   WITH FRAME frDet.
                        
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE ProcEnable wgwpar01 
PROCEDURE ProcEnable :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
  ENABLE ALL WITH FRAME frDet.
  ENABLE  ALL WITH FRAME frTariff30.
  ENABLE 
        rbflag    fiType
        fiYearNo  fiTarNo
        fiSImin   fiSImax    
        fiPremium fiStamp 
        fiTax     fiNetprm 
        fiEffDate      
        /*btnOK btnCancel*/ 
  WITH FRAME {&FRAME-NAME}.

  fiType:BGCOLOR = 15.

  DISABLE brTariff  WITH FRAME frMain.  
  DISABLE fiSearch2   WITH FRAME frDet.  
  
  FIND FIRST brStat.Company WHERE brStat.Company.compno = nv_Compno NO-LOCK NO-ERROR.
/*  IF Company.Flag4 = "NO" THEN   */
/*     HIDE Fram frTariff30.       */
/*  ELSE     VIEW Fram frTariff30. */
  VIEW Fram frTariff30.
 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE ProcUpdateQ wgwpar01 
PROCEDURE ProcUpdateQ :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
   OPEN QUERY brTariff
        FOR EACH brStat.Tariff USE-INDEX Tariff01 WHERE 
                 brStat.Tariff.CompNo = nv_Compno NO-LOCK,
            EACH brStat.Company NO-LOCK WHERE 
                 brStat.Company.CompNo = nv_Compno 
                 BY brStat.Tariff.TarNo
                 BY brStat.Tariff.EffDate                 
                 BY brStat.Tariff.YearNo .
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE ProcUpDateTariff wgwpar01 
PROCEDURE ProcUpDateTariff :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
  DEF BUFFER bufTariff FOR brStat.Tariff.
  DEF INPUT PARAMETER cmode AS CHAR.
  DEF VAR rTariff     AS ROWID.
  DEF VAR logAns      AS LOGI INIT No.
  
  ASSIGN
    logAns = No.
      
    IF cmode = "ADD" THEN DO:
       MESSAGE "ต้องการเพิ่มข้อมูลรายการนี้ ?"  UPDATE logAns 
       VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO
       TITLE "ยืนยันการเพิ่มข้อมูล".
 
       IF logAns THEN DO:
          FIND FIRST brStat.Tariff USE-INDEX Tariff07
               WHERE brStat.Tariff.CompNo   = nv_compno        AND
                     brStat.Tariff.TarNo    = fiType + fiTarNo AND
                     brStat.Tariff.YearNo   = fiYearNo AND
                     brStat.Tariff.EffDate  = fiEffDate  NO-LOCK NO-ERROR.
            IF AVAIL brStat.Tariff THEN DO:
               MESSAGE "ข้อมูลซ้ำ  กรุณาตรวจสอบข้อมูลใหม่ "  VIEW-AS ALERT-BOX ERROR.
               RETURN NO-APPLY.
            END.
            IF NOT AVAIL Tariff THEN DO:        
               FIND LAST bufTariff NO-LOCK NO-ERROR. 
               CREATE Tariff.
            END.    
       END. 
       ELSE  RETURN NO-APPLY.
    END. /* ADD */
    ELSE IF cmode = "UPDATE" THEN DO WITH FRAME {&FRAME-NAME} :
         GET CURRENT brTariff EXCLUSIVE-LOCK.
    END. /* UPDATE */
     
    ASSIGN         
        fiYearNo
        fiType 
        fiTarNo
        fiSImin     
        fiSImax
        fiPremium  
        fiStamp 
        fiTAX 
        fiNetPrm
        brStat.Tariff.Compno   = nv_compno
        brStat.Tariff.branch   = brStat.Company.branch
        brStat.Tariff.YearNo   = fiYearNo
        brStat.Tariff.TarNo    = fiType +  fiTarNo
        brStat.Tariff.SImin    = fiSImin
        brStat.Tariff.SImax    = fiSImax    
        brStat.Tariff.PreTarNo = fiType
        brStat.Tariff.EffDate  = fiEffDate
        brStat.Tariff.GrpClass = TRIM(fiType +  fiTarNo) + fiYearNo
        
        brStat.Tariff.Extprm   = fiTariff30
        brStat.Tariff.Premium  = fiPremium
        brStat.Tariff.Stamp    = fiStamp
        brStat.Tariff.TAX      = fiTAX
        brStat.Tariff.NetPrm   = fiNetPrm
         
        brStat.Tariff.UserNo   = n_User
        brStat.Tariff.UDate    = TODAY
        
        btnFirst:Sensitive IN FRAME frMain = Yes
        btnPrev:Sensitive  IN FRAME frMain = Yes
        btnNext:Sensitive  IN FRAME frMain = Yes
        btnLast:Sensitive  IN FRAME frMain = Yes
          
        /*btnAdd:Sensitive    = Yes
        btnUpdate:Sensitive = Yes */
        btnDelete:Sensitive = Yes.
        
        /*btnOK:Sensitive     = No
        btnCancel:Sensitive = No.*/
   
    RUN ProcUpdateQ.
    RUN ProcDisable IN THIS-PROCEDURE.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

