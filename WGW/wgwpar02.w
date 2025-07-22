&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          brstat           PROGRESS
*/
&Scoped-define WINDOW-NAME WGWPAR02
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS WGWPAR02 
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

/* ***************************  Definitions  ************************** */

/* Parameters Definitions ---                                           */
DEF INPUT                   PARAMETER vComp     AS CHAR.
DEF INPUT-OUTPUT  PARAMETER vTarNo    AS CHAR.
DEF INPUT                   PARAMETER vCarNO   AS CHAR.
/*DEF INPUT-OUTPUT PARAMETER vEffDate AS DATE.*/

/* Local Variable Definitions ---                                       */

DEFINE SHARED VAR nv_Compno AS CHAR FORMAT "X(3)" NO-UNDO.
DEFINE SHARED VAR nv_Branch AS CHAR FORMAT "X(2)" NO-UNDO.
DEFINE SHARED VAR n_User AS CHAR.
DEFINE NEW SHARED VAR nv_Modno  AS CHAR.

/*DEFINE VAR vCarNo AS CHAR. 
DEFINE VAR vTarno AS CHAR.*/

DEF VAR rPol AS ROWID.

DEF VAR cUpdate AS CHAR.
DEF VAR vCompAB AS CHAR FORMAT "X".
DEF VAR vCompName AS CHAR.

/*{wmc\wmcm0001.i}*/ 

DEF VAR nv_EffDate     AS  DATE.
DEF VAR FileName1 AS CHAR.
DEF VAR FileName2 AS CHAR.
DEF VAR Name1 AS CHAR.

 DEF TEMP-TABLE TModel
    FIELD TCompNo         LIKE  brstat.Model.CompNo
    FIELD TBranch         LIKE  brstat.Model.Branch
    FIELD TTarNo          LIKE  brstat.Model.TarNo
    FIELD TModNo          LIKE  brstat.Model.ModNo
    FIELD TBrand          LIKE  brstat.Model.Brand
    FIELD TClass          LIKE  brstat.Model.Class
    FIELD TCC             LIKE  brstat.Model.CC
    FIELD TPrice          LIKE  brstat.Model.Price
    FIELD TSI             LIKE  brstat.Model.SI
    FIELD TISRate         LIKE  brstat.Model.ISRate
    FIELD TPAPrm          LIKE  brstat.Model.PAPrm
    FIELD TExtPrm         LIKE  brstat.Model.ExtPrm
    FIELD TPremium        LIKE  brstat.Model.Premium
    FIELD TUserNo         LIKE  brstat.Model.UserNo    
    FIELD TUDate          LIKE  brstat.Model.UDate
    FIELD TMarketName     LIKE  brstat.Model.MarketName
    FIELD TPreEng         LIKE  brstat.Model.PreEng
    FIELD TPreBody        LIKE  brstat.Model.PreBody
    FIELD TTarNo1         LIKE  brstat.Model.TarNo1
    FIELD TTarNo2         LIKE  brstat.Model.TarNo2
    FIELD TYrmnu          LIKE  brstat.Model.Yrmnu
    FIELD TCrPrm          LIKE  brstat.Model.CrPrm
    FIELD TStat           LIKE  brstat.Model.Stat
    FIELD TFlag           LIKE  brstat.Model.Flag
    FIELD TDeci1          LIKE  brstat.Model.Deci1
    FIELD TDeci2          LIKE  brstat.Model.Deci2
    FIELD TDate1          LIKE  brstat.Model.Date1
    FIELD TDate2          LIKE  brstat.Model.Date2
    FIELD TPreDate1       LIKE  brstat.Model.PreDate1
    FIELD TPreDate2       LIKE  brstat.Model.PreDate2
    FIELD TPreDate3       LIKE  brstat.Model.PreDate3
    FIELD TText1          LIKE  brstat.Model.Text1
    FIELD TText2          LIKE  brstat.Model.Text2
    FIELD TText3          LIKE  brstat.Model.Text3
    FIELD TText4          LIKE  brstat.Model.Text4
    FIELD TText5          LIKE  brstat.Model.Text5
    INDEX TModel IS PRIMARY  TModNo ASC.

DEF VAR Min1 AS DECI.
DEF VAR Max1 AS DECI.
DEF VAR Min2 AS DECI.
DEF VAR Max2 AS DECI.
DEF VAR Min3 AS DECI.
DEF VAR Max3 AS DECI.
DEF VAR Netprm1 AS DECI.
DEF VAR Netprm2 AS DECI.
DEF VAR Netprm3 AS DECI.


def var typemotor as char .

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME frDet
&Scoped-define BROWSE-NAME brModel

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES Model Company

/* Definitions for BROWSE brModel                                       */
&Scoped-define FIELDS-IN-QUERY-brModel Model.ModNo Model.TarNo ~
brstat.Company.ABName + "." + brstat.Model.Compno Model.Class Model.Brand 
&Scoped-define ENABLED-FIELDS-IN-QUERY-brModel 
&Scoped-define QUERY-STRING-brModel FOR EACH Model NO-LOCK, ~
      EACH Company OF Model NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-brModel OPEN QUERY brModel FOR EACH Model NO-LOCK, ~
      EACH Company OF Model NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-brModel Model Company
&Scoped-define FIRST-TABLE-IN-QUERY-brModel Model
&Scoped-define SECOND-TABLE-IN-QUERY-brModel Company


/* Definitions for FRAME frMain                                         */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS RECT-19 RECT-452 fiSearch btnSearch-3 ~
btnSearch-2 fiMarketName rbMotor fiEffDate btnSPrev btnSNext btnTariff ~
btnDelete btnReturn fiComp fiText30 
&Scoped-Define DISPLAYED-OBJECTS fiSearch fiBranch fiCode fiCC fiBrand ~
fiClass fiMarketName fiPreBody fiPreEng rbMotor fiTarNo fiEffDate fiText4 ~
fiSiMin1 fiText3 fiSiMax1 fiNetprm1 fiNetprm30-1 fiText6 fiSiMin2 fiText5 ~
fiSiMax2 fiNetprm2 fiNetprm30-2 fiText7 fiSiMin3 fiText8 fiSiMax3 fiNetprm3 ~
fiNetprm30-3 fiComp fiText30 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR WGWPAR02 AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON btnDelete 
     LABEL "ลบ" 
     SIZE 14 BY 1.43
     FONT 6.

DEFINE BUTTON btnReturn 
     LABEL "EXIT" 
     SIZE 14 BY 1.38
     FONT 6.

DEFINE BUTTON btnSearch-2 
     IMAGE-UP FILE "adeicon\last-au":U
     LABEL "NEXT" 
     SIZE 5.5 BY 1 TOOLTIP "ค้นหาก่อนหน้า"
     FONT 6.

DEFINE BUTTON btnSearch-3 
     IMAGE-UP FILE "adeicon\first-au":U
     LABEL "PREV" 
     SIZE 5.5 BY 1.05 TOOLTIP "ค้นหาถัดไป"
     FONT 6.

DEFINE BUTTON btnSNext 
     LABEL ">>" 
     SIZE 5.5 BY 1 TOOLTIP "ค้นหาถัดไป"
     FONT 1.

DEFINE BUTTON btnSPrev 
     LABEL "<<" 
     SIZE 5.5 BY 1 TOOLTIP "ค้นหาก่อนหน้า"
     FONT 1.

DEFINE BUTTON btnTariff 
     LABEL "Tariff" 
     SIZE 14 BY 1.43
     FONT 6.

DEFINE VARIABLE rbMotor AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEMS "รถใหม่","รถเก่า","รถต่ออายุ" 
     DROP-DOWN-LIST
     SIZE 14 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiBranch AS CHARACTER FORMAT "X(1)":U 
     VIEW-AS FILL-IN 
     SIZE 6 BY 1.05
     BGCOLOR 3 FGCOLOR 7 FONT 2 NO-UNDO.

DEFINE VARIABLE fiBrand AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 16.5 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiCC AS CHARACTER FORMAT "X(5)":U 
     VIEW-AS FILL-IN 
     SIZE 6 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiClass AS CHARACTER FORMAT "X(80)":U 
     VIEW-AS FILL-IN 
     SIZE 25 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiCode AS CHARACTER FORMAT "X(5)":U 
     VIEW-AS FILL-IN 
     SIZE 16.5 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiComp AS CHARACTER FORMAT "X(50)":U 
      VIEW-AS TEXT 
     SIZE 12.5 BY .95
     FGCOLOR 7 FONT 6 NO-UNDO.

DEFINE VARIABLE fiEffDate AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     FGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiMarketName AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 49 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiNetprm1 AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 12.5 BY 1
     FGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiNetprm2 AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 12.5 BY 1
     FGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiNetprm3 AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 12.5 BY 1.05
     FGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiNetprm30-1 AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 14.5 BY 1
     FGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiNetprm30-2 AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 14.5 BY 1
     FGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiNetprm30-3 AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 14.5 BY 1
     FGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiPreBody AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 34.5 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiPreEng AS CHARACTER FORMAT "X(250)":U 
     VIEW-AS FILL-IN 
     SIZE 34.5 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiSearch AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 34 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fiSiMax1 AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 10.5 BY 1
     BGCOLOR 3 FGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiSiMax2 AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 10.5 BY 1
     BGCOLOR 3 FGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiSiMax3 AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 10.5 BY 1.05
     BGCOLOR 3 FGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiSiMin1 AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 10.5 BY 1
     BGCOLOR 3 FGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiSiMin2 AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 10.5 BY 1
     BGCOLOR 3 FGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiSiMin3 AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 10.5 BY 1.05
     BGCOLOR 3 FGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiTarNo AS CHARACTER FORMAT "X(4)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     FGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiText3 AS CHARACTER FORMAT "X(256)":U INITIAL "-" 
     VIEW-AS FILL-IN 
     SIZE 2.5 BY 1
     FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fiText30 AS CHARACTER FORMAT "X(256)":U INITIAL " เบี้ยประกันภัย 30" 
      VIEW-AS TEXT 
     SIZE 14.5 BY .76
     BGCOLOR 1 FGCOLOR 7  NO-UNDO.

DEFINE VARIABLE fiText4 AS CHARACTER FORMAT "X(256)":U INITIAL "ปีที่ 1" 
     VIEW-AS FILL-IN 
     SIZE 5.5 BY 1
     BGCOLOR 8 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fiText5 AS CHARACTER FORMAT "X(256)":U INITIAL "-" 
     VIEW-AS FILL-IN 
     SIZE 2.5 BY 1
     FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fiText6 AS CHARACTER FORMAT "X(256)":U INITIAL "ปีที่ 2" 
     VIEW-AS FILL-IN 
     SIZE 5.5 BY 1
     BGCOLOR 8 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fiText7 AS CHARACTER FORMAT "X(256)":U INITIAL "ปีที่ 3" 
     VIEW-AS FILL-IN 
     SIZE 5.5 BY 1
     BGCOLOR 8 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fiText8 AS CHARACTER FORMAT "X(256)":U INITIAL "-" 
     VIEW-AS FILL-IN 
     SIZE 2.5 BY 1.05
     FGCOLOR 15  NO-UNDO.

DEFINE RECTANGLE RECT-19
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 60.5 BY 16.48
     FGCOLOR 15 .

DEFINE RECTANGLE RECT-20
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 17.5 BY 2.29
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-21
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 17.5 BY 2.29
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-41
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 59.5 BY 8.48
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-452
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 16.5 BY 2.29
     BGCOLOR 4 .

DEFINE BUTTON bBrand 
     LABEL "ยี่ห้อ" 
     SIZE 11 BY .86.

DEFINE BUTTON bClass 
     LABEL "รุ่นรถ" 
     SIZE 25.33 BY .86.

DEFINE BUTTON bCompany 
     LABEL "Company" 
     SIZE 10.67 BY .86.

DEFINE BUTTON bModel 
     LABEL "Modno" 
     SIZE 8 BY .86.

DEFINE BUTTON bTarno 
     LABEL "Tarno" 
     SIZE 8 BY .86.

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
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 24.5 BY 1.81
     BGCOLOR 1 .

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY brModel FOR 
      brstat.Model, 
      brstat.Company SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE brModel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS brModel WGWPAR02 _STRUCTURED
  QUERY brModel NO-LOCK DISPLAY
      Model.ModNo FORMAT "X(10)":U WIDTH 7.33
      Model.TarNo FORMAT "X(4)":U WIDTH 7.33
      Company.ABName + "." + Model.Compno WIDTH 9.33
      Model.Class FORMAT "X(40)":U WIDTH 10.33
      Model.Brand FORMAT "X(18)":U WIDTH 22.17
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-LABELS NO-ROW-MARKERS NO-COLUMN-SCROLLING SEPARATORS SIZE 63 BY 22.86 ROW-HEIGHT-CHARS .71 EXPANDABLE.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME frMain
     bModel AT ROW 1.29 COL 2
     bTarno AT ROW 1.29 COL 10
     bCompany AT ROW 1.29 COL 18
     bBrand AT ROW 1.29 COL 28.5
     bClass AT ROW 1.29 COL 39.5
     btnFirst AT ROW 1.52 COL 72
     btnPrev AT ROW 1.52 COL 77.5
     btnNext AT ROW 1.52 COL 82.5
     btnLast AT ROW 1.52 COL 87.5
     brModel AT ROW 2.14 COL 2
     RECT-18 AT ROW 1.24 COL 70
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 128.33 BY 24.38.

DEFINE FRAME frDet
     fiSearch AT ROW 1.24 COL 14.5 COLON-ALIGNED NO-LABEL
     btnSearch-3 AT ROW 1.24 COL 51
     btnSearch-2 AT ROW 1.24 COL 57.5
     fiBranch AT ROW 2.91 COL 34.5 COLON-ALIGNED NO-LABEL
     fiCode AT ROW 4.1 COL 10 COLON-ALIGNED NO-LABEL
     fiCC AT ROW 4.1 COL 34 COLON-ALIGNED NO-LABEL
     fiBrand AT ROW 5.14 COL 10 COLON-ALIGNED NO-LABEL
     fiClass AT ROW 5.14 COL 34 COLON-ALIGNED NO-LABEL
     fiMarketName AT ROW 6.19 COL 10 COLON-ALIGNED NO-LABEL
     fiPreBody AT ROW 7.24 COL 24.5 COLON-ALIGNED NO-LABEL
     fiPreEng AT ROW 8.29 COL 24.5 COLON-ALIGNED NO-LABEL
     rbMotor AT ROW 10.05 COL 19 COLON-ALIGNED NO-LABEL
     fiTarNo AT ROW 11.14 COL 19 COLON-ALIGNED NO-LABEL
     fiEffDate AT ROW 12.19 COL 19 COLON-ALIGNED NO-LABEL
     btnSPrev AT ROW 12.19 COL 35
     btnSNext AT ROW 12.19 COL 40.5
     fiText4 AT ROW 14.38 COL 2 COLON-ALIGNED NO-LABEL
     fiSiMin1 AT ROW 14.38 COL 7.5 COLON-ALIGNED NO-LABEL
     fiText3 AT ROW 14.38 COL 20 NO-LABEL
     fiSiMax1 AT ROW 14.38 COL 20 COLON-ALIGNED NO-LABEL
     fiNetprm1 AT ROW 14.38 COL 31.5 COLON-ALIGNED NO-LABEL
     fiNetprm30-1 AT ROW 14.38 COL 44.5 COLON-ALIGNED NO-LABEL
     fiText6 AT ROW 15.43 COL 2 COLON-ALIGNED NO-LABEL
     fiSiMin2 AT ROW 15.43 COL 7.5 COLON-ALIGNED NO-LABEL
     fiText5 AT ROW 15.43 COL 20 NO-LABEL
     fiSiMax2 AT ROW 15.43 COL 20 COLON-ALIGNED NO-LABEL
     fiNetprm2 AT ROW 15.43 COL 31.5 COLON-ALIGNED NO-LABEL
     fiNetprm30-2 AT ROW 15.43 COL 44.5 COLON-ALIGNED NO-LABEL
     fiText7 AT ROW 16.48 COL 2 COLON-ALIGNED NO-LABEL
     fiSiMin3 AT ROW 16.48 COL 7.5 COLON-ALIGNED NO-LABEL
     fiText8 AT ROW 16.48 COL 20 NO-LABEL
     fiSiMax3 AT ROW 16.48 COL 20 COLON-ALIGNED NO-LABEL
     fiNetprm3 AT ROW 16.48 COL 31.5 COLON-ALIGNED NO-LABEL
     fiNetprm30-3 AT ROW 16.48 COL 44.5 COLON-ALIGNED NO-LABEL
     btnTariff AT ROW 20.19 COL 13.5
     btnDelete AT ROW 20.19 COL 30.83
     btnReturn AT ROW 20.19 COL 48
     fiComp AT ROW 2.91 COL 10.5 COLON-ALIGNED NO-LABEL
     fiText30 AT ROW 13.62 COL 44.5 COLON-ALIGNED NO-LABEL
     "บริษัท" VIEW-AS TEXT
          SIZE 6 BY .95 AT ROW 2.91 COL 4.5
          FGCOLOR 15 
     " วันที่เริ่มใช้":50 VIEW-AS TEXT
          SIZE 10.5 BY 1 AT ROW 12.19 COL 9.5
          BGCOLOR 1 FGCOLOR 7 
     "ความจุ" VIEW-AS TEXT
          SIZE 5.5 BY .95 AT ROW 4.1 COL 30
          FGCOLOR 15 
     "รหัสรุ่น" VIEW-AS TEXT
          SIZE 6.5 BY .95 AT ROW 4.1 COL 4
          FGCOLOR 15 
     " ประเภทรถ":31 VIEW-AS TEXT
          SIZE 10.5 BY 1 AT ROW 10.1 COL 9.5
          BGCOLOR 1 FGCOLOR 7 
     "ชื่อเรียก" VIEW-AS TEXT
          SIZE 6.5 BY 1.05 AT ROW 6.19 COL 4
          FGCOLOR 15 
     "รุ่น" VIEW-AS TEXT
          SIZE 3.5 BY .95 AT ROW 5.14 COL 30
          FGCOLOR 15 
     "ยี่ห้อ" VIEW-AS TEXT
          SIZE 6.5 BY .95 AT ROW 5.14 COL 4
          FGCOLOR 15 
     "  ทุนประกันภัย   Min  -  Max":U VIEW-AS TEXT
          SIZE 23 BY .76 AT ROW 13.62 COL 9.5
          BGCOLOR 1 FGCOLOR 7 
     " เบี้ยประกันภัย":U VIEW-AS TEXT
          SIZE 12.5 BY .76 AT ROW 13.62 COL 33.5
          BGCOLOR 1 FGCOLOR 7 
     "หมายเลขเครื่องยนต์เริ่มต้น":35 VIEW-AS TEXT
          SIZE 21.5 BY 1.05 AT ROW 8.24 COL 4
          FGCOLOR 15 
     "Branch" VIEW-AS TEXT
          SIZE 6 BY 1.05 AT ROW 2.91 COL 30
          FGCOLOR 15 
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 66 ROW 3.14
         SIZE 63 BY 21.86
         BGCOLOR 3 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME frDet
     "CC" VIEW-AS TEXT
          SIZE 3 BY .95 AT ROW 4.1 COL 42.5
          FGCOLOR 15 
     " Tariff":30 VIEW-AS TEXT
          SIZE 10.5 BY 1 AT ROW 11.14 COL 9.5
          BGCOLOR 1 FGCOLOR 7 
     "   ค้นหารุ่นรถ":U VIEW-AS TEXT
          SIZE 13 BY .95 AT ROW 1.24 COL 3
          BGCOLOR 1 FGCOLOR 7 FONT 13
     "หมายเลขตัวถังเริ่มต้น":35 VIEW-AS TEXT
          SIZE 17.5 BY 1.05 AT ROW 7.19 COL 4
          FGCOLOR 15 
     RECT-41 AT ROW 9.57 COL 3
     RECT-19 AT ROW 2.38 COL 2.5
     RECT-452 AT ROW 19.71 COL 46.5
     RECT-20 AT ROW 19.71 COL 29
     RECT-21 AT ROW 19.71 COL 11.67
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 66 ROW 3.14
         SIZE 63 BY 21.86
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
  CREATE WINDOW WGWPAR02 ASSIGN
         HIDDEN             = YES
         TITLE              = "WGWPAR02  Model Setup"
         HEIGHT             = 24.24
         WIDTH              = 128.33
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
IF NOT WGWPAR02:LOAD-ICON("wimage/safety.ico":U) THEN
    MESSAGE "Unable to load icon: wimage/safety.ico"
            VIEW-AS ALERT-BOX WARNING BUTTONS OK.
&ENDIF
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW WGWPAR02
  VISIBLE,,RUN-PERSISTENT                                               */
/* REPARENT FRAME */
ASSIGN FRAME frDet:FRAME = FRAME frMain:HANDLE.

/* SETTINGS FOR FRAME frDet
                                                                        */
/* SETTINGS FOR FILL-IN fiBranch IN FRAME frDet
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fiBrand IN FRAME frDet
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fiCC IN FRAME frDet
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fiClass IN FRAME frDet
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fiCode IN FRAME frDet
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fiNetprm1 IN FRAME frDet
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fiNetprm2 IN FRAME frDet
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fiNetprm3 IN FRAME frDet
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fiNetprm30-1 IN FRAME frDet
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fiNetprm30-2 IN FRAME frDet
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fiNetprm30-3 IN FRAME frDet
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fiPreBody IN FRAME frDet
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fiPreEng IN FRAME frDet
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fiSiMax1 IN FRAME frDet
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fiSiMax2 IN FRAME frDet
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fiSiMax3 IN FRAME frDet
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fiSiMin1 IN FRAME frDet
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fiSiMin2 IN FRAME frDet
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fiSiMin3 IN FRAME frDet
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fiTarNo IN FRAME frDet
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fiText3 IN FRAME frDet
   NO-ENABLE ALIGN-L                                                    */
/* SETTINGS FOR FILL-IN fiText4 IN FRAME frDet
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fiText5 IN FRAME frDet
   NO-ENABLE ALIGN-L                                                    */
/* SETTINGS FOR FILL-IN fiText6 IN FRAME frDet
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fiText7 IN FRAME frDet
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fiText8 IN FRAME frDet
   NO-ENABLE ALIGN-L                                                    */
/* SETTINGS FOR RECTANGLE RECT-20 IN FRAME frDet
   NO-ENABLE                                                            */
/* SETTINGS FOR RECTANGLE RECT-21 IN FRAME frDet
   NO-ENABLE                                                            */
/* SETTINGS FOR RECTANGLE RECT-41 IN FRAME frDet
   NO-ENABLE                                                            */
/* SETTINGS FOR FRAME frMain
                                                                        */
/* BROWSE-TAB brModel btnLast frMain */
/* SETTINGS FOR RECTANGLE RECT-18 IN FRAME frMain
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(WGWPAR02)
THEN WGWPAR02:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE brModel
/* Query rebuild information for BROWSE brModel
     _TblList          = "brstat.Model,brstat.Company OF brstat.Model"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _FldNameList[1]   > brstat.Model.ModNo
"Model.ModNo" ? ? "character" ? ? ? ? ? ? no ? no no "7.33" yes no no "U" "" ""
     _FldNameList[2]   > brstat.Model.TarNo
"Model.TarNo" ? ? "character" ? ? ? ? ? ? no ? no no "7.33" yes no no "U" "" ""
     _FldNameList[3]   > "_<CALC>"
"brstat.Company.ABName + ""."" + brstat.Model.Compno" ? ? ? ? ? ? ? ? ? no ? no no "9.33" yes no no "U" "" ""
     _FldNameList[4]   > brstat.Model.Class
"Model.Class" ? ? "character" ? ? ? ? ? ? no ? no no "10.33" yes no no "U" "" ""
     _FldNameList[5]   > brstat.Model.Brand
"Model.Brand" ? ? "character" ? ? ? ? ? ? no ? no no "22.17" yes no no "U" "" ""
     _Query            is NOT OPENED
*/  /* BROWSE brModel */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME WGWPAR02
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL WGWPAR02 WGWPAR02
ON END-ERROR OF WGWPAR02 /* WGWPAR02  Model Setup */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL WGWPAR02 WGWPAR02
ON WINDOW-CLOSE OF WGWPAR02 /* WGWPAR02  Model Setup */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frMain
&Scoped-define SELF-NAME bBrand
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bBrand WGWPAR02
ON CHOOSE OF bBrand IN FRAME frMain /* ยี่ห้อ */
DO:
      OPEN QUERY brModel
                FOR EACH brStat.Model USE-INDEX Model01 WHERE brStat.Model.CompNo = nv_Compno /*gComp*/ NO-LOCK,
                         EACH brStat.Company  NO-LOCK WHERE brStat.Company.CompNo = nv_Compno /*gComp*/ 
                                BY brStat.Model.Brand.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bClass
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bClass WGWPAR02
ON CHOOSE OF bClass IN FRAME frMain /* รุ่นรถ */
DO:
      OPEN QUERY brModel
                FOR EACH brStat.Model USE-INDEX Model01 WHERE brStat.Model.CompNo = nv_Compno /*gComp*/ NO-LOCK,
                         EACH brStat.Company  NO-LOCK WHERE brStat.Company.CompNo = nv_Compno /*gComp*/ 
                                BY brStat.Model.Brand
                                BY brStat.Model.Class.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bModel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bModel WGWPAR02
ON CHOOSE OF bModel IN FRAME frMain /* Modno */
DO:
    OPEN QUERY brModel
                FOR EACH brStat.Model USE-INDEX Model01 WHERE brStat.Model.CompNo = nv_Compno /*gComp*/ NO-LOCK,
                         EACH brStat.Company  NO-LOCK WHERE brStat.Company.CompNo = nv_Compno /*gComp*/ 
                                BY brStat.Model.ModNo.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME brModel
&Scoped-define SELF-NAME brModel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brModel WGWPAR02
ON MOUSE-SELECT-DBLCLICK OF brModel IN FRAME frMain
DO:
    GET CURRENT brModel.
    FIND CURRENT brStat.Model NO-LOCK.
    Assign
        vTarNo = brStat.Model.TarNo.
    
    APPLY "CLOSE" TO THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brModel WGWPAR02
ON VALUE-CHANGED OF brModel IN FRAME frMain
DO:
    DEF VAR typemotor AS CHAR.
    FIND FIRST brStat.Company WHERE brStat.Company.compno = nv_Compno /*gComp*/ NO-LOCK NO-ERROR.
     FIND CURRENT brStat.Model /*WHERE Model.CompNo = gComp*/ NO-LOCK NO-ERROR.
     IF NOT AVAIL brStat.Model THEN DO:
        MESSAGE "ไม่พบข้อมูล Model  : " + brStat.Company.Name VIEW-AS AlERT-BOX INFORMATION.
     END.
     ELSE DO:
         ASSIGN
              typemotor = substr(brStat.Model.TarNo,1,1)
              vTarno    = brStat.Model.Tarno
              nv_Modno  = brstat.Model.Modno.
             IF typemotor = "N" THEN  rbMotor  = "รถใหม่".
             ELSE  IF typemotor = "O" THEN  rbMotor  =  "รถเก่า".
             ELSE   rbMotor  = "รถต่ออายุ".
    
         DISPLAY 
           brStat.Model.CompNo  @ fiComp
           brStat.Model.Branch  @ fiBranch
           brStat.Model.ModNo   @ fiCode   
           brStat.Model.Brand   @ fiBrand
           brStat.Model.Class   @ fiClass
           brStat.Model.CC      @ fiCC
           rbMotor
           brStat.Model.TarNo   @ fiTarNo
    
           brStat.Model.MarketName @ fiMarketName
           brStat.Model.PreEng  @ fiPreEng
           brStat.Model.PreBody @ fiPreBody
         WITH FRAME frDet.
     END.
     RUN PDDispTariffQ.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bTarno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bTarno WGWPAR02
ON CHOOSE OF bTarno IN FRAME frMain /* Tarno */
DO:
      OPEN QUERY brModel
                FOR EACH brStat.Model USE-INDEX Model01 WHERE brStat.Model.CompNo = nv_Compno /*gComp*/ NO-LOCK,
                         EACH brStat.Company  NO-LOCK WHERE brStat.Company.CompNo = nv_Compno /*gComp*/ 
                                BY brStat.Model.TarNo.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frDet
&Scoped-define SELF-NAME btnDelete
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnDelete WGWPAR02
ON CHOOSE OF btnDelete IN FRAME frDet /* ลบ */
DO: 
  DEF VAR logAns      AS LOGI INIT No. 

      RUN  wgw\wgwdel02.
      RUN ProcUpdateQ.
      APPLY "VALUE-CHANGED" TO brModel IN FRAME frMain.  
      RUN ProcDisable IN THIS-PROCEDURE.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frMain
&Scoped-define SELF-NAME btnFirst
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnFirst WGWPAR02
ON CHOOSE OF btnFirst IN FRAME frMain /* << */
DO:
  GET FIRST brModel.
  IF NOT AVAIL brStat.Model THEN RETURN NO-APPLY.  
  REPOSITION brModel TO ROWID ROWID (brStat.Model).
  APPLY "VALUE-CHANGED" TO brModel.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnLast
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnLast WGWPAR02
ON CHOOSE OF btnLast IN FRAME frMain /* >> */
DO:
  GET LAST brModel.
  IF NOT AVAIL brStat.Model THEN RETURN NO-APPLY.
  REPOSITION brModel TO ROWID ROWID (brStat.Model).
  APPLY "VALUE-CHANGED" TO brModel.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnNext
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnNext WGWPAR02
ON CHOOSE OF btnNext IN FRAME frMain /* > */
DO:
  GET NEXT brModel.
  IF NOT AVAIL brStat.Model THEN RETURN NO-APPLY.
  REPOSITION brModel TO ROWID ROWID (brStat.Model).
  APPLY "VALUE-CHANGED" TO brModel.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnPrev
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnPrev WGWPAR02
ON CHOOSE OF btnPrev IN FRAME frMain /* < */
DO:
  GET PREV brModel.
  IF NOT AVAIL brStat.Model THEN RETURN NO-APPLY.
  REPOSITION brModel TO ROWID ROWID (brStat.Model).
  APPLY "VALUE-CHANGED" TO brModel.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frDet
&Scoped-define SELF-NAME btnReturn
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnReturn WGWPAR02
ON CHOOSE OF btnReturn IN FRAME frDet /* EXIT */
DO:

  APPLY "CLOSE" TO THIS-PROCEDURE.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnSearch-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnSearch-2 WGWPAR02
ON CHOOSE OF btnSearch-2 IN FRAME frDet /* NEXT */
DO:
     FIND NEXT  brStat.Model  WHERE  brStat.Model.CompNo = nv_Compno /*gcomp*/    AND
                                     brStat.Model.Class  MATCHES "*" + TRIM (fiSearch) + "*"   NO-LOCK NO-ERROR.
          IF NOT AVAIL brStat.Model THEN DO:
               RETURN NO-APPLY.
          END. 
          ELSE DO:
              rPol = ROWID (brStat.Model).
              REPOSITION brModel  TO ROWID rPol.

    FIND CURRENT brStat.Model  NO-LOCK NO-ERROR.
   ASSIGN
        typemotor = substr(brStat.Model.TarNo,1,1).
       IF typemotor = "N" THEN  rbMotor  = "รถใหม่".
       ELSE  IF typemotor = "O" THEN  rbMotor  =  "รถเก่า".
       ELSE   rbMotor  = "รถต่ออายุ".
   
   DISPLAY 
     brStat.Model.CompNo     @ fiComp
     brStat.Model.Branch     @ fiBranch
     brStat.Model.ModNo      @ fiCode   
     brStat.Model.Brand      @ fiBrand
     brStat.Model.Class      @ fiClass
     brStat.Model.CC         @ fiCC
     rbMotor
     brStat.Model.TarNo      @ fiTarNo
     
     brStat.Model.MarketName @ fiMarketName
     brStat.Model.PreEng     @ fiPreEng
     brStat.Model.PreBody    @ fiPreBody   WITH FRAME frDet.
     
  RUN PDDispTariff.
 END. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnSearch-3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnSearch-3 WGWPAR02
ON CHOOSE OF btnSearch-3 IN FRAME frDet /* PREV */
DO:
    FIND PREV  brStat.Model  WHERE  brStat.Model.CompNo = nv_Compno /*gcomp*/    AND
                                    brStat.Model.Class  MATCHES "*" + TRIM (fiSearch) + "*"  NO-LOCK NO-ERROR.
          IF NOT AVAIL brStat.Model THEN DO:
                         Message "ไม่พบข้อมูลรุ่นรถที่ต้องการค้นหา  " SKIP
                                          "รุ่นรถ = "  fiSearch   view-as alert-box ERROR .
                         RETURN NO-APPLY.
                    END. 
                    ELSE DO:
                        rPol = ROWID (brStat.Model).
                        REPOSITION brModel TO ROWID rPol.
          
             FIND CURRENT brStat.Model  NO-LOCK NO-ERROR.
   ASSIGN
        typemotor = substr(brStat.Model.TarNo,1,1).
       IF typemotor = "N" THEN  rbMotor  = "รถใหม่".
       ELSE  IF typemotor = "O" THEN  rbMotor  =  "รถเก่า".
       ELSE   rbMotor  = "รถต่ออายุ".
             
             DISPLAY 
               brStat.Model.CompNo     @ fiComp
               brStat.Model.Branch     @ fiBranch
               brStat.Model.ModNo      @ fiCode   
               brStat.Model.Brand      @ fiBrand
               brStat.Model.Class      @ fiClass
               brStat.Model.CC         @ fiCC
               rbMotor
               brStat.Model.TarNo      @ fiTarNo
               
               brStat.Model.MarketName @ fiMarketName
               brStat.Model.PreEng     @ fiPreEng
               brStat.Model.PreBody    @ fiPreBody   WITH FRAME frDet.
                           
               RUN PDDispTariff.
           END.  
  END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnSNext
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnSNext WGWPAR02
ON CHOOSE OF btnSNext IN FRAME frDet /* >> */
DO:
   ASSIGN FRAME frDet fiEffDate.
   HIDE fiNetprm30-1 IN FRAME frDet.
   HIDE fiNetprm30-2 IN FRAME frDet.
   HIDE fiNetprm30-3 IN FRAME frDet.
   HIDE fiText30 IN FRAME frDet.
   
   FOR EACH brStat.Tariff  USE-INDEX Tariff01 WHERE brStat.Tariff.Compno  = nv_Compno /*vComp*/ AND
                                                    brStat.Tariff.TarNo   = brStat.Model.Tarno AND
                                                    brStat.Tariff.EffDate > fiEffDate   NO-LOCK.
         IF brStat.Tariff.YearNo = "1"  THEN DO:
              ASSIGN            
                Min1       = brStat.Tariff.Simin
                Max1       =  brStat.Tariff.Simax
                NetPrm1    = brStat.Tariff.NetPrm
                fiEffDate  = brStat.Tariff.EffDate.
                DISP min1  @ fisimin1
                     Max1  @ fisiMax1 
                     Netprm1 @ fiNetprm1
                     fiEffDate WITH frame frdet.
                VIEW fiText3 IN FRAME frDet.
                VIEW fiText4 IN FRAME frDet. 
              IF brStat.Tariff.ExtPrm <> 0 THEN  DO:
                   VIEW  fiText30 IN FRAME frDet.              
                   VIEW  fiNetprm30-1 IN FRAME frDet.
                   ASSIGN fiNetPrm30-1 = Tariff.ExtPrm.
                   DISP fiNetPrm30-1 WITH FRAME frDet.
              END.
         END.
         /*----------------------------------------*/
         ELSE IF brStat.Tariff.YearNo = "2" THEN DO:
             ASSIGN
               Min2    = brStat.Tariff.Simin
               Max2    = brStat.Tariff.Simax
               NetPrm2 = brStat.Tariff.NetPrm.
               Disp min2  @ fisimin2
                    Max2  @ fisiMax2
                    Netprm2 @ fiNetprm2 with frame frdet.
              VIEW fiText5 IN FRAME frDet.
              VIEW fiText6 IN FRAME frDet.                           
              IF brStat.Tariff.ExtPrm <> 0 THEN  DO:
                   VIEW  fiText30 IN FRAME frDet.              
                   VIEW  fiNetprm30-2 IN FRAME frDet.
                   ASSIGN fiNetPrm30-2 = Tariff.ExtPrm.
                   DISP fiNetPrm30-2 WITH FRAME frDet.
              END.
         END. 
       /*----------------------------------------*/
       ELSE IF  brStat.Tariff.YearNo = "3"  THEN DO:
             ASSIGN
               Min3    = brStat.Tariff.Simin
               Max3    = brStat.Tariff.Simax
               NetPrm3 = brStat.Tariff.NetPrm.
               Disp min3  @ fisimin3
                    Max3  @ fisiMax3
                    Netprm3 @ fiNetprm3 with frame frdet.
              VIEW fiText7 IN FRAME frDet.
              VIEW fiText8 IN FRAME frDet.                           
              IF brStat.Tariff.ExtPrm <> 0 THEN  DO:
                   VIEW  fiText30 IN FRAME frDet.              
                   VIEW  fiNetprm30-3 IN FRAME frDet.
                   ASSIGN fiNetPrm30-3 = Tariff.ExtPrm.
                   DISP fiNetPrm30-3 WITH FRAME frDet.
              END.
           END.
           ELSE DO:
                HIDE fiSimax2 IN FRAME frDet.
                HIDE fiSimin2 IN FRAME frDet.
                HIDE fiNetprm2 IN FRAME frDet.
                HIDE fiText5 IN FRAME frDet.
                HIDE fiText6 IN FRAME frDet.                
                
                HIDE fiSimax3 IN FRAME frDet.
                HIDE fiSimin3 IN FRAME frDet.
                HIDE fiNetprm3 IN FRAME frDet.
                HIDE fiText7 IN FRAME frDet.
                HIDE fiText8 IN FRAME frDet.          
           END.
   END.
 END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnSPrev
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnSPrev WGWPAR02
ON CHOOSE OF btnSPrev IN FRAME frDet /* << */
DO:
   FOR EACH brStat.Tariff  USE-INDEX Tariff01  WHERE brStat.Tariff.Compno   = nv_COmpno /*vComp*/ AND
                                                     brStat.Tariff.TarNo    = brstat.Model.Tarno AND
                                                     brStat.Tariff.EffDate  < fiEffDate   NO-LOCK.
         
         IF brStat.Tariff.YearNo = "1"  THEN DO:
              ASSIGN            
                Min1       = brStat.Tariff.Simin
                Max1       = brStat.Tariff.Simax
                NetPrm1    = brStat.Tariff.NetPrm
                fiEffDate  = brStat.Tariff.EffDate.
                DISP min1    @ fisimin1
                     Max1    @ fisiMax1 
                     Netprm1 @ fiNetprm1
                     fiEffDate WITH frame frdet.
                VIEW fiText3 IN FRAME frDet.
                VIEW fiText4 IN FRAME frDet. 
                 IF brStat.Tariff.ExtPrm <> 0 THEN  DO:
                   VIEW  fiText30 IN FRAME frDet.              
                   VIEW  fiNetprm30-1 IN FRAME frDet.
                   ASSIGN fiNetPrm30-1 = Tariff.ExtPrm.
                   DISP fiNetPrm30-1 WITH FRAME frDet.
              END.

         END.
         /*----------------------------------------*/
         IF brStat.Tariff.YearNo = "2" THEN DO:
             ASSIGN
               Min2    = brStat.Tariff.Simin
               Max2    = brStat.Tariff.Simax
               NetPrm2 = brStat.Tariff.NetPrm.
               Disp min2  @ fisimin2
                    Max2  @ fisiMax2
                    Netprm2 @ fiNetprm2 with frame frdet.
              VIEW fiText5 IN FRAME frDet.
              VIEW fiText6 IN FRAME frDet.        
              IF brStat.Tariff.ExtPrm <> 0 THEN  DO:
                   VIEW  fiText30 IN FRAME frDet.              
                   VIEW  fiNetprm30-2 IN FRAME frDet.
                   ASSIGN fiNetPrm30-2 = Tariff.ExtPrm.
                   DISP fiNetPrm30-2 WITH FRAME frDet.
              END.                   
         END. 
         ELSE DO:
                HIDE fiSimax2 IN FRAME frDet.
                HIDE fiSimin2 IN FRAME frDet.
                HIDE fiNetprm2 IN FRAME frDet.
                HIDE fiText5 IN FRAME frDet.
                HIDE fiText6 IN FRAME frDet.                     
         END.
         /*----------------------------------------*/         
         IF  brStat.Tariff.YearNo = "3"  THEN DO:
             ASSIGN
               Min3    = brStat.Tariff.Simin
               Max3    = brStat.Tariff.Simax
               NetPrm3 = brStat.Tariff.NetPrm.
               Disp min3  @ fisimin3
                    Max3  @ fisiMax3
                    Netprm3 @ fiNetprm3 with frame frdet.
              VIEW fiText7 IN FRAME frDet.
              VIEW fiText8 IN FRAME frDet.                           
              IF brStat.Tariff.ExtPrm <> 0 THEN  DO:
                   VIEW  fiText30 IN FRAME frDet.              
                   VIEW  fiNetprm30-3 IN FRAME frDet.
                   ASSIGN fiNetPrm30-3 = Tariff.ExtPrm.
                   DISP fiNetPrm30-3 WITH FRAME frDet.
              END.              
           END.
           ELSE DO:
                HIDE fiSimax3 IN FRAME frDet.
                HIDE fiSimin3 IN FRAME frDet.
                HIDE fiNetprm3 IN FRAME frDet.
                HIDE fiText7 IN FRAME frDet.
                HIDE fiText8 IN FRAME frDet.          
           END.
   END.
   

/*   FIND PREV Tariff WHERE Tariff.CompNo = vComp AND
 *                                                  Tariff.TarNo    =  Model.Tarno AND
 *                                                  Tariff.EffDate  < fiEffDate  AND
 *                                                  Tariff.YearNo  =  "1"   USE-INDEX Tariff01 NO-LOCK NO-ERROR.
 *         IF AVAIL Tariff THEN DO:
 *             ASSIGN            
 *             Min1 = Tariff.Simin
 *             Max1 =  Tariff.Simax
 *             NetPrm1 = Tariff.NetPrm
 *             fiEffDate  = Tariff.EffDate.
 *             Disp min1  @ fisimin1
 *                      Max1  @ fisiMax1 
 *                      Netprm1 @ fiNetprm1
 *                      fiEffDate WITH frame frdet.
 *               VIEW fiText3 IN FRAME frDet.
 *               VIEW fiText4 IN FRAME frDet. 
 *         END.
 *               FIND  PREV Tariff WHERE Tariff.CompNo = vComp AND
 *                                                  Tariff.TarNo    =  Model.Tarno AND
 *                                                  Tariff.EffDate  < fiEffDate  AND
 *                                                  Tariff.YearNo  =  "2"   USE-INDEX Tariff01 NO-LOCK NO-ERROR.
 *                  IF AVAIL Tariff THEN DO:
 *              ASSIGN
 *                Min2 = Tariff.Simin
 *                Max2 =  Tariff.Simax
 *                NetPrm2 = Tariff.NetPrm.
 *                Disp min2  @ fisimin2
 *                         Max2  @ fisiMax2
 *                         Netprm2 @ fiNetprm2 with frame frdet.
 *               VIEW fiText5 IN FRAME frDet.
 *               VIEW fiText6 IN FRAME frDet.                           
 *          END.*/
                 
   
/*          IF NOT AVAIL Tariff THEN DO:
 *                 HIDE fiSimax2 IN FRAME frDet.
 *                 HIDE fiSimin2 IN FRAME frDet.
 *                 HIDE fiNetprm2 IN FRAME frDet.
 *                 HIDE fiText5 IN FRAME frDet.
 *                 HIDE fiText6 IN FRAME frDet.                               
 *            END.
*/

                
        
        
/*        IF NOT AVAIL Tariff THEN DO:
 *                 HIDE fiSimax1 IN FRAME frDet.
 *                 HIDE fiSimin1 IN FRAME frDet.
 *                 HIDE fiNetprm1 IN FRAME frDet.
 *                 HIDE fiText3 IN FRAME frDet.
 *                 HIDE fiText4 IN FRAME frDet.                
 *          END.*/

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnTariff
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnTariff WGWPAR02
ON CHOOSE OF btnTariff IN FRAME frDet /* Tariff */
DO: 
   RUN wgw\wgwpar01.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiBranch
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiBranch WGWPAR02
ON LEAVE OF fiBranch IN FRAME frDet
DO:
  fiBranch  =  INPUT fiBranch.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiBrand
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiBrand WGWPAR02
ON LEAVE OF fiBrand IN FRAME frDet
DO:
      fiBrand = input fiBrand.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiCC
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiCC WGWPAR02
ON LEAVE OF fiCC IN FRAME frDet
DO:
      fiCC = input fiCC.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiClass
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiClass WGWPAR02
ON LEAVE OF fiClass IN FRAME frDet
DO:
      fiClass = input fiClass.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiCode
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiCode WGWPAR02
ON LEAVE OF fiCode IN FRAME frDet
DO:
        fiCode = input fiCode.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiComp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiComp WGWPAR02
ON LEAVE OF fiComp IN FRAME frDet
DO:
       fiComp = input fiComp.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiMarketName
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiMarketName WGWPAR02
ON LEAVE OF fiMarketName IN FRAME frDet
DO:
  fiMarketName = input fiMarketName.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiPreBody
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiPreBody WGWPAR02
ON LEAVE OF fiPreBody IN FRAME frDet
DO:
  fiPreBody = input fiPreBody.
  ASSIGN 
  fiPreBody
  fiPreEng = fiPreBody.

  DISP 
    fiPreEng WITH FRAME frDet.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiPreEng
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiPreEng WGWPAR02
ON LEAVE OF fiPreEng IN FRAME frDet
DO:
  fiPreEng = input fiPreEng.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiSearch
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiSearch WGWPAR02
ON RETURN OF fiSearch IN FRAME frDet
DO:
  fiSearch = INPUT fiSearch.
  DISP CAPS(fiSearch) @ fiSearch WITH FRAME frDet.

  ASSIGN 
      fiSearch.

  IF fiSearch = " "   THEN RETURN NO-APPLY.     
    FIND FIRST brStat.Model  WHERE  brStat.Model.CompNo = nv_Compno /*gcomp*/    AND
                             brStat.Model.Class  MATCHES "*" + TRIM (fiSearch) + "*"  NO-LOCK NO-ERROR.
          IF NOT AVAIL brStat.Model THEN DO:
               Message "ไม่พบข้อมูลรุ่นรถที่ต้องการค้นหา  " SKIP
                       "รุ่นรถ = "  fiSearch   view-as alert-box ERROR .
               RETURN NO-APPLY.
          END. 
          ELSE DO:
              rPol = ROWID (brStat.Model).
              REPOSITION brModel TO ROWID rPol.

   FIND CURRENT brStat.Model  NO-LOCK NO-ERROR.
   ASSIGN
        typemotor = substr(brStat.Model.TarNo,1,1).
       IF typemotor = "N" THEN  rbMotor  = "รถใหม่".
       ELSE  IF typemotor = "O" THEN  rbMotor  =  "รถเก่า".
       ELSE   rbMotor  = "รถต่ออายุ".
   
   DISPLAY 
     brStat.Model.CompNo     @ fiComp
     brStat.Model.Branch     @ fiBranch
     brStat.Model.ModNo      @ fiCode   
     brStat.Model.Brand      @ fiBrand
     brStat.Model.Class      @ fiClass
     brStat.Model.CC         @ fiCC
     rbMotor
     brStat.Model.TarNo      @ fiTarNo
     
     brStat.Model.MarketName @ fiMarketName
     brStat.Model.PreEng     @ fiPreEng
     brStat.Model.PreBody    @ fiPreBody   WITH FRAME frDet.
   
   /* RUN ProcUpdateQ.*/
   
       RUN PDDispTariffQ.
  END.
 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiSiMax1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiSiMax1 WGWPAR02
ON LEAVE OF fiSiMax1 IN FRAME frDet
DO:
  fiPreBody = input fiPreBody.
  ASSIGN 
  fiPreBody
  fiPreEng = fiPreBody.

  DISP 
    fiPreEng WITH FRAME frDet.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiSiMax2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiSiMax2 WGWPAR02
ON LEAVE OF fiSiMax2 IN FRAME frDet
DO:
  fiPreBody = input fiPreBody.
  ASSIGN 
  fiPreBody
  fiPreEng = fiPreBody.

  DISP 
    fiPreEng WITH FRAME frDet.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiSiMax3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiSiMax3 WGWPAR02
ON LEAVE OF fiSiMax3 IN FRAME frDet
DO:
  fiPreBody = input fiPreBody.
  ASSIGN 
  fiPreBody
  fiPreEng = fiPreBody.

  DISP 
    fiPreEng WITH FRAME frDet.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiSiMin1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiSiMin1 WGWPAR02
ON LEAVE OF fiSiMin1 IN FRAME frDet
DO:
  fiPreBody = input fiPreBody.
  ASSIGN 
  fiPreBody
  fiPreEng = fiPreBody.

  DISP 
    fiPreEng WITH FRAME frDet.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiSiMin2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiSiMin2 WGWPAR02
ON LEAVE OF fiSiMin2 IN FRAME frDet
DO:
  fiPreBody = input fiPreBody.
  ASSIGN 
  fiPreBody
  fiPreEng = fiPreBody.

  DISP 
    fiPreEng WITH FRAME frDet.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiSiMin3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiSiMin3 WGWPAR02
ON LEAVE OF fiSiMin3 IN FRAME frDet
DO:
  fiPreBody = input fiPreBody.
  ASSIGN 
  fiPreBody
  fiPreEng = fiPreBody.

  DISP 
    fiPreEng WITH FRAME frDet.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiTarNo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiTarNo WGWPAR02
ON LEAVE OF fiTarNo IN FRAME frDet
DO:
  fiCode = input fiCode.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME rbMotor
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL rbMotor WGWPAR02
ON VALUE-CHANGED OF rbMotor IN FRAME frDet
DO:
    rbMotor = Input rbMotor.
     IF rbMotor = "รถใหม่" THEN  vCarNo = "N" .
     ELSE IF rbMotor = "รถเก่า" THEN  vCarNo = "O" .
     ELSE vCarNo = "R".
    
/*    Assign
 *             fiTarNo = "".     
 *    DISP     fiTarNo     WITH FRAME {&FRAME-NAME}. */
   ASSIGN 
    fiComp       = nv_Compno /*gComp*/

    fiBranch     = brStat.Company.Branch
    fiCode       = ""
    fiBrand      = "" 
    fiClass      = ""
    fiCC         = ""
    fiTarNo      = ""
    cUpdate      = "ADD" 
    
    fiMarketName = ""
    fiPreEng     = ""
    fiPreBody    = ""
    /*rbMotor      = "รถใหม่"*//*Porn Comment A52-0140*/
    
    fiSimin1  = 0
    fiSimax1  = 0
    fiSimin2  = 0
    fiSimax2  = 0    
    fiNetprm1 = 0 
    fiNetprm2 = 0 .
  
  DISP 
    fiComp fiBranch fiCode fiBrand fiClass fiCC  fiTarNo 
    fiMarketName fiPreEng fiPreBody rbMotor  fiSimax1   fiSimin1    
    fiSimax2   fiSimin2     fiNetprm1    fiNetprm2 
  WITH FRAME frDet.
   
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK WGWPAR02 


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
  
  RUN WUT\WUTDICEN (WGWPAR02:HANDLE). 
  SESSION:DATA-ENTRY-RETURN = Yes.
  
  RECT-18:MOVE-TO-TOP().
 
  
  RUN ProcAddComp IN THIS-PROCEDURE.
  RUN ProcDisable IN THIS-PROCEDURE.  
  Assign
     fiComp  = nv_Compno
     vComp   = fiComp
     vCarNO  = "N"
     rbmotor = "รถใหม่".
  DISP rbMotor WITH FRAME frDet.

  IF CAN-FIND (FIRST brStat.Model WHERE brStat.Model.CompNo = vComp) THEN DO:
      RUN ProcUpdateQ.  
      APPLY "VALUE-CHANGED" TO brModel.
  END.
  ELSE DO:
      MESSAGE "ไม่พบข้อมูล Model  : " + brStat.Company.Name VIEW-AS AlERT-BOX INFORMATION.

  END.


  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI WGWPAR02  _DEFAULT-DISABLE
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
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(WGWPAR02)
  THEN DELETE WIDGET WGWPAR02.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI WGWPAR02  _DEFAULT-ENABLE
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
  ENABLE bModel bTarno bCompany bBrand bClass btnFirst btnPrev btnNext btnLast 
         brModel 
      WITH FRAME frMain IN WINDOW WGWPAR02.
  {&OPEN-BROWSERS-IN-QUERY-frMain}
  DISPLAY fiSearch fiBranch fiCode fiCC fiBrand fiClass fiMarketName fiPreBody 
          fiPreEng rbMotor fiTarNo fiEffDate fiText4 fiSiMin1 fiText3 fiSiMax1 
          fiNetprm1 fiNetprm30-1 fiText6 fiSiMin2 fiText5 fiSiMax2 fiNetprm2 
          fiNetprm30-2 fiText7 fiSiMin3 fiText8 fiSiMax3 fiNetprm3 fiNetprm30-3 
          fiComp fiText30 
      WITH FRAME frDet IN WINDOW WGWPAR02.
  ENABLE RECT-19 RECT-452 fiSearch btnSearch-3 btnSearch-2 fiMarketName rbMotor 
         fiEffDate btnSPrev btnSNext btnTariff btnDelete btnReturn fiComp 
         fiText30 
      WITH FRAME frDet IN WINDOW WGWPAR02.
  {&OPEN-BROWSERS-IN-QUERY-frDet}
  VIEW WGWPAR02.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDDispTariff WGWPAR02 
PROCEDURE PDDispTariff :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
   HIDE fiNetprm30-1 IN FRAME frDet.
   HIDE fiNetprm30-2 IN FRAME frDet.
   HIDE fiNetprm30-3 IN FRAME frDet.
   HIDE fiText30 IN FRAME frDet.
   ASSIGN 
   FRAME frDet fiTarno.

   FIND LAST brStat.Tariff WHERE brStat.Tariff.CompNo = nv_Compno AND
             /*brStat.Tariff.TarNo    =  vTarno AND*/
             brStat.Tariff.EffDate  =  fiEffDate  AND
             brStat.Tariff.YearNo   =  "1" USE-INDEX Tariff01 NO-LOCK NO-ERROR.
        IF AVAIL Tariff THEN DO:            
            ASSIGN
                Min1       = brStat.Tariff.Simin
                Max1       = brStat.Tariff.Simax
                NetPrm1    = brStat.Tariff.NetPrm
                fiEffDate  = brStat.Tariff.EffDate.
            Disp min1  @ fisimin1
                 Max1  @ fisiMax1 
                 Netprm1 @ fiNetprm1
                 fiEffDate WITH frame frdet.
            VIEW fiText3 IN FRAME frDet.
            VIEW fiText4 IN FRAME frDet.        
            IF brStat.Tariff.ExtPrm <> 0 THEN  DO:
               VIEW  fiText30 IN FRAME frDet.              
               VIEW  fiNetprm30-1 IN FRAME frDet.
               ASSIGN fiNetPrm30-1 = Tariff.ExtPrm.
               DISP fiNetPrm30-1 WITH FRAME frDet.
            END.
        END.
        IF NOT AVAIL brStat.Tariff THEN DO:          
            HIDE fiSimax1 IN FRAME frDet.
            HIDE fiSimin1 IN FRAME frDet.
            HIDE fiNetprm1 IN FRAME frDet.
            HIDE fiText3 IN FRAME frDet.
            HIDE fiText4 IN FRAME frDet.                
        END.
        FIND LAST brStat.Tariff WHERE brStat.Tariff.CompNo = nv_Compno AND
              /*brStat.Tariff.TarNo   =  vTarno AND*/
              brStat.Tariff.EffDate =  fiEffDate AND
              brStat.Tariff.YearNo  =  "2" USE-INDEX Tariff01 NO-LOCK NO-ERROR.                                            
        IF AVAIL Tariff THEN DO:            
            ASSIGN
               Min2    = brStat.Tariff.Simin
               Max2    = brStat.Tariff.Simax
               NetPrm2 = brStat.Tariff.NetPrm.
            Disp min2  @ fisimin2
                Max2  @ fisiMax2
                Netprm2 @ fiNetprm2 with frame frdet.
            VIEW fiText5 IN FRAME frDet.
            VIEW fiText6 IN FRAME frDet.                           
            IF brStat.Tariff.ExtPrm <> 0 THEN  DO:
               VIEW  fiText30 IN FRAME frDet.              
               VIEW  fiNetprm30-2 IN FRAME frDet.
               ASSIGN fiNetPrm30-2 = Tariff.ExtPrm.
               DISP fiNetPrm30-2 WITH FRAME frDet.
            END.
          
        END.
        IF NOT AVAIL brStat.Tariff THEN DO:
            HIDE fiSimax2 IN FRAME frDet.
            HIDE fiSimin2 IN FRAME frDet.
            HIDE fiNetprm2 IN FRAME frDet.
            HIDE fiText5 IN FRAME frDet.
            HIDE fiText6 IN FRAME frDet.                               
        END.
/*-----------------------------------*/                                           
  FIND LAST brStat.Tariff WHERE brStat.Tariff.CompNo   =  nv_Compno  AND
                               /* brStat.Tariff.TarNo    =  vTarno AND*/
                                brStat.Tariff.EffDate  =  fiEffDate AND
                                brStat.Tariff.YearNo   =  "3" USE-INDEX Tariff01 NO-LOCK NO-ERROR.                                            
         IF AVAIL brStat.Tariff THEN DO:
             ASSIGN
               Min3    = brStat.Tariff.Simin
               Max3    = brStat.Tariff.Simax
               NetPrm3 = brStat.Tariff.NetPrm.
             Disp min3  @ fisimin3
                 Max3  @ fisiMax3
                 Netprm3 @ fiNetprm3 with frame frdet.
             VIEW fiText7 IN FRAME frDet.
             VIEW fiText8 IN FRAME frDet.                           
             IF brStat.Tariff.ExtPrm <> 0 THEN  DO:
                VIEW  fiText30 IN FRAME frDet.              
                VIEW  fiNetprm30-3 IN FRAME frDet.
                ASSIGN fiNetPrm30-3 = Tariff.ExtPrm.
                DISP fiNetPrm30-3 WITH FRAME frDet.
             END.

         END.
          IF NOT AVAIL brStat.Tariff THEN DO:
                HIDE fiSimax3 IN FRAME frDet.
                HIDE fiSimin3 IN FRAME frDet.
                HIDE fiNetprm3 IN FRAME frDet.
                HIDE fiText7 IN FRAME frDet.
                HIDE fiText8 IN FRAME frDet.                                
         END.
/*-----------------------------------*/     
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDDispTariffQ WGWPAR02 
PROCEDURE PDDispTariffQ :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
   HIDE fiNetprm30-1 IN FRAME frDet.
   HIDE fiNetprm30-2 IN FRAME frDet.
   HIDE fiNetprm30-3 IN FRAME frDet.
   HIDE fiText30     IN FRAME frDet.
 FIND LAST brStat.Tariff WHERE brStat.Tariff.CompNo = nv_Compno AND
           brStat.Tariff.TarNo    =  brStat.Model.Tarno AND
           brStat.Tariff.EffDate  <> ?  AND
           brStat.Tariff.YearNo   =  "1" USE-INDEX Tariff01 NO-LOCK NO-ERROR.
        IF AVAIL Tariff THEN DO:
            ASSIGN
            Min1       = brStat.Tariff.Simin
            Max1       = brStat.Tariff.Simax
            NetPrm1    = brStat.Tariff.NetPrm
            fiEffDate  = brStat.Tariff.EffDate.
            Disp min1    @ fisimin1
                 Max1    @ fisiMax1 
                 Netprm1 @ fiNetprm1
                 fiEffDate WITH frame frdet.
            VIEW fiText3 IN FRAME frDet.
            VIEW fiText4 IN FRAME frDet.        
            IF brStat.Tariff.ExtPrm <> 0 THEN  DO:
               VIEW  fiText30     IN FRAME frDet.              
               VIEW  fiNetprm30-1 IN FRAME frDet.
               ASSIGN fiNetPrm30-1 = Tariff.ExtPrm.
               DISP fiNetPrm30-1 WITH FRAME frDet.
            END.
        END.
        IF NOT AVAIL brStat.Tariff THEN DO:
            HIDE fiSimax1  IN FRAME frDet.
            HIDE fiSimin1  IN FRAME frDet.
            HIDE fiNetprm1 IN FRAME frDet.
            HIDE fiText3   IN FRAME frDet.
            HIDE fiText4   IN FRAME frDet.                
        END.
        FIND LAST brStat.Tariff WHERE brStat.Tariff.CompNo   = nv_Compno AND
                                      brStat.Tariff.TarNo    =  brStat.Model.Tarno AND
                                      brStat.Tariff.EffDate  <> ? AND
                                      brStat.Tariff.YearNo   =  "2" USE-INDEX Tariff01 NO-LOCK NO-ERROR.                                            
         IF AVAIL brStat.Tariff THEN DO:
             ASSIGN
               Min2    = brStat.Tariff.Simin
               Max2    = brStat.Tariff.Simax
               NetPrm2 = brStat.Tariff.NetPrm.
             Disp min2    @ fisimin2
                  Max2    @ fisiMax2
                  Netprm2 @ fiNetprm2 with frame frdet.
             VIEW fiText5 IN FRAME frDet.
             VIEW fiText6 IN FRAME frDet.                           
             IF Tariff.ExtPrm <> 0 THEN  DO:
                VIEW  fiText30     IN FRAME frDet.              
                VIEW  fiNetprm30-2 IN FRAME frDet.
                ASSIGN fiNetPrm30-2 = Tariff.ExtPrm.
                DISP fiNetPrm30-2 WITH FRAME frDet.
             END.
              
         END.
         IF NOT AVAIL brStat.Tariff THEN DO:
             HIDE fiSimax2  IN FRAME frDet.
             HIDE fiSimin2  IN FRAME frDet.
             HIDE fiNetprm2 IN FRAME frDet.
             HIDE fiText5   IN FRAME frDet.
             HIDE fiText6   IN FRAME frDet.                               
         END.
/*-----------------------------------*/                                           
  FIND LAST brStat.Tariff WHERE brStat.Tariff.CompNo   = nv_Compno AND
                                brStat.Tariff.TarNo    =  brStat.Model.Tarno AND
                                brStat.Tariff.EffDate  <> ?  AND
                                brStat.Tariff.YearNo   =  "3" USE-INDEX Tariff01 NO-LOCK NO-ERROR.                                            
         IF AVAIL brStat.Tariff THEN DO:
             ASSIGN
               Min3    = brStat.Tariff.Simin
               Max3    = brStat.Tariff.Simax
               NetPrm3 = brStat.Tariff.NetPrm.
              Disp min3    @ fisimin3
                   Max3    @ fisiMax3
                   Netprm3 @ fiNetprm3 with frame frdet.
              VIEW fiText7 IN FRAME frDet.
              VIEW fiText8 IN FRAME frDet.                           
              IF brStat.Tariff.ExtPrm <> 0 THEN  DO:
                 VIEW  fiText30     IN FRAME frDet.              
                 VIEW  fiNetprm30-3 IN FRAME frDet.
                 ASSIGN fiNetPrm30-3 = Tariff.ExtPrm.
                 DISP fiNetPrm30-3 WITH FRAME frDet.
              END.

         END.
         IF NOT AVAIL brStat.Tariff THEN DO:
             HIDE fiSimax3  IN FRAME frDet.
             HIDE fiSimin3  IN FRAME frDet.
             HIDE fiNetprm3 IN FRAME frDet.
             HIDE fiText7   IN FRAME frDet.
             HIDE fiText8   IN FRAME frDet.                                
         END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE ProcAddComp WGWPAR02 
PROCEDURE ProcAddComp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/  
    FIND FIRST brStat.Company USE-INDEX Company01 WHERE brStat.Company.CompNo = nv_Compno NO-LOCK NO-ERROR.
        ASSIGN
               vCompName = TRIM(brStat.Company.Name)
               vCompAB   = brStat.Company.ABName.
                   
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE ProcDisable WGWPAR02 
PROCEDURE ProcDisable :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*IF gUser <> "safety" AND gUser <> "uwsucw" THEN 
 *     DISABLE ALL EXCEPT btnReturn WITH FRAME {&FRAME-NAME} .
 * ELSE 
 *     DISABLE ALL EXCEPT btnAdd btnUpdate btnDelete btnReturn WITH FRAME {&FRAME-NAME} .*/

  DISABLE 
        fiComp fiCode fiBrand fiClass fiCC 
        fiMarketName fiPreEng fiPreBody
        rbMotor /*fiBranch*/
        /*btnTariff
        btnOK btnCancel*//*A52-0140*/
        fiEffDate
  WITH FRAME {&FRAME-NAME}.
  
  ENABLE brModel  WITH FRAME frMain.  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE ProcEnable WGWPAR02 
PROCEDURE ProcEnable :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*IF gUser = "safety" OR gUser = "uwsucw" THEN 
 *     ENABLE ALL WITH FRAME {&FRAME-NAME}.*/

  ENABLE 
        fiComp fiCode fiBrand fiClass fiCC 
        fiMarketName fiPreEng fiPreBody
        rbMotor /*fiBranch*/
        /*btnTariff        
        btnOK btnCancel*//*A52-0140*/
         fiEffDate
  WITH FRAME {&FRAME-NAME}.
  
  DISABLE brModel  WITH FRAME frMain.  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE ProcUpDateModel WGWPAR02 
PROCEDURE ProcUpDateModel :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEF INPUT PARAMETER cmode AS CHAR.

  DEF VAR rModel      AS ROWID.
  DEF VAR logAns      AS LOGI INIT No.  
  
  DEF BUFFER bufModel FOR brstat.Model.

    ASSIGN
      logAns = No.
  
    IF cmode = "ADD" THEN DO:
        MESSAGE "ต้องการเพิ่มข้อมูลรายการนี้ ?" 
           UPDATE logAns 
        VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO
        TITLE "ยืนยันการเพิ่มข้อมูล".   
   
        IF logAns THEN DO:
            FIND FIRST brStat.Model USE-INDEX Model01 
                 WHERE brStat.Model.CompNo = nv_Compno /*gComp*/  AND
                       brStat.Model.ModNo = fiCode NO-LOCK NO-ERROR.
            IF  AVAIL brStat.Model THEN DO:
                MESSAGE "ข้อมูลซ้ำ  กรุณาตรวจสอบข้อมูลใหม่ "  VIEW-AS ALERT-BOX ERROR.
                RETURN NO-APPLY.
            END.
            IF NOT AVAIL brStat.Model THEN DO:        
                FIND LAST bufModel NO-LOCK NO-ERROR. 
                CREATE brStat.Model.
            END.    
        END. 
        ELSE
               RETURN NO-APPLY.
    END. /* ADD */
    ELSE IF cmode = "UPDATE" THEN DO WITH FRAME {&FRAME-NAME}:
       GET CURRENT brModel EXCLUSIVE-LOCK.
    END. /* UPDATE */
     
  ASSIGN 
  FRAME frDet
    fiComp fiCode fiBrand fiClass  fiCC 
    fiMarketName fiPreEng fiPreBody
        
    brStat.Model.CompNo      = fiComp
    brStat.Model.Branch      = fiBranch
    
    brStat.Model.ModNo       = fiCode
    brStat.Model.Brand       = fiBrand
    brStat.Model.Class       = fiClass
    brStat.Model.CC          = fiCC
    brStat.Model.TarNo       = fiTarNo  
    brStat.Model.UserNo      = n_User
    brStat.Model.UDate       = TODAY
    
    brStat.Model.MarketName  = fiMarketName
    brStat.Model.PreEng      = fiPreEng
    brStat.Model.PreBody     = fiPreBody
    
    btnFirst:Sensitive IN FRAME frMain = Yes
    btnPrev:Sensitive  IN FRAME frMain = Yes
    btnNext:Sensitive  IN FRAME frMain = Yes
    btnLast:Sensitive  IN FRAME frMain = Yes
      
    /*btnAdd:Sensitive    = Yes
    btnUpdate:Sensitive = Yes*//*A52-0140*/
    btnDelete:Sensitive = Yes.
      
    /*btnOK:Sensitive     = No
    btnCancel:Sensitive = No.*//*A52-0140*/

    RUN ProcUpdateQ.
    APPLY "VALUE-CHANGED" TO brModel.  
    RUN ProcDisable IN THIS-PROCEDURE.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE ProcUpdateQ WGWPAR02 
PROCEDURE ProcUpdateQ :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
    OPEN QUERY brModel
          FOR EACH brStat.Model USE-INDEX Model01 WHERE brStat.Model.CompNo = nv_Compno /*gComp*/ NO-LOCK,
                   EACH brStat.Company  NO-LOCK WHERE brStat.Company.CompNo = nv_Compno /*gComp*/ 
                          BY brStat.Model.ModNo.
/*-----------------------------------*/ 

RUN PDDispTariffQ.                   

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

