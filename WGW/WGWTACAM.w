&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          brstat           PROGRESS
*/
&Scoped-define WINDOW-NAME campaign
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS campaign 
/*------------------------------------------------------------------------

  File: 

  Description: 

  Input Parameters:
      <none>

  Output Parameters:
      <none>

  Author: 

  Created: 
  
  Modify By : Porntiwa P.  A55-0235    15/10/2012
            : โปรแกรมสำหรับ Set Campaing ของ Thanachat
            : Connect gw_stat -LD brstat 
            : Table clastab_fil ; Campaign 

------------------------------------------------------------------------*/
/*          This .W file was created with the Progress AppBuilder.      */
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

DEFINE VAR cmode AS CHAR FORMAT "X(20)".

/*--- Import Campaign ----*/
DEFINE VAR wCamcode  AS CHAR FORMAT "X(20)".
DEFINE VAR wtltc     AS CHAR.
DEFINE VAR weffdat   AS DATE FORMAT "99/99/9999".
DEFINE VAR wmakdes   AS CHAR.
DEFINE VAR wmoddes   AS CHAR.
DEFINE VAR wcovcodca AS CHAR.
DEFINE VAR wclassca  AS CHAR.
DEFINE VAR wseat     AS INTE.
DEFINE VAR wdspc     AS DECI.
DEFINE VAR wbaseprm  AS DECI.
/*--- END Inport Campaign ----*/

/*---- Import Cover code ----*/
DEFINE VAR wclasscl  AS CHAR.
DEFINE VAR wcovcodcl AS CHAR.
DEFINE VAR wTariff   AS CHAR.
DEFINE VAR wbip      AS INTE.
DEFINE VAR wbia      AS INTE.
DEFINE VAR wpda      AS INTE.
DEFINE VAR wmv41     AS INTE.
DEFINE VAR wmv42     AS INTE.
DEFINE VAR wmv43     AS INTE.
DEFINE VAR wSeatDri  AS INTE.
DEFINE VAR wSeatPass AS INTE.
/*--- End Import Covcod ----*/

/*--- File Error ----*/
DEF STREAM stErrFile.
DEF STREAM stErrMsg.
DEF VAR nv_FileErr1 AS CHAR.
DEF VAR nv_FileErr2 AS CHAR.
DEF VAR nv_FileErr3 AS CHAR.
DEF VAR nv_FileErr4 AS CHAR.        
DEF VAR nv_Err1Flag AS LOGIC.
DEF VAR nv_Err2Flag AS LOGIC.
DEF VAR nv_Err3Flag AS LOGIC.
DEF VAR nv_Err4Flag AS LOGIC.

DEF VAR n_msg  AS CHAR.    
DEF VAR Err AS CHAR.
DEF VAR j AS CHAR. 
DEF VAR K AS CHAR.
DEF VAR nv_delete AS INTE.
/*------------------*/

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME frmain
&Scoped-define BROWSE-NAME brcampaign

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES campaign clastab_fil

/* Definitions for BROWSE brcampaign                                    */
&Scoped-define FIELDS-IN-QUERY-brcampaign campaign.tltc campaign.makdes ~
campaign.moddes campaign.class campaign.covcod campaign.baseprm ~
campaign.dspc campaign.effdat 
&Scoped-define ENABLED-FIELDS-IN-QUERY-brcampaign 
&Scoped-define QUERY-STRING-brcampaign FOR EACH campaign NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-brcampaign OPEN QUERY brcampaign FOR EACH campaign NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-brcampaign campaign
&Scoped-define FIRST-TABLE-IN-QUERY-brcampaign campaign


/* Definitions for BROWSE brCover                                       */
&Scoped-define FIELDS-IN-QUERY-brCover clastab_fil.class clastab_fil.covcod ~
clastab_fil.tariff clastab_fil.si_41unp clastab_fil.si_42 clastab_fil.si_43 ~
clastab_fil.uom1_si clastab_fil.uom2_si clastab_fil.uom5_si ~
clastab_fil.dri_41 clastab_fil.pass_41 
&Scoped-define ENABLED-FIELDS-IN-QUERY-brCover 
&Scoped-define QUERY-STRING-brCover FOR EACH clastab_fil NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-brCover OPEN QUERY brCover FOR EACH clastab_fil NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-brCover clastab_fil
&Scoped-define FIRST-TABLE-IN-QUERY-brCover clastab_fil


/* Definitions for FRAME frmain                                         */
&Scoped-define OPEN-BROWSERS-IN-QUERY-frmain ~
    ~{&OPEN-QUERY-brcampaign}~
    ~{&OPEN-QUERY-brCover}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS brCover brcampaign fiFileNameCA buSearchCA ~
buImportCA buExportCA fiCamcode fitltc fieffdat fimakdes fimoddes ~
ficovcodCA ficlassCA fiSeat fidspc fibaseprm buaddCA bueditCA budeleteCA ~
buokCA bucancelCA fiFileNameCL buImportCL buExportCL ficlassCL ficovcodCL ~
fitariff fiBip fiBiA fiPda fimv41 fimv42 fimv43 fiSeatDriver fiSeatPass ~
buSearchCL buaddCL bueditCL budeleteCL buokCL bucancelCL buexit RECT-379 ~
RECT-381 RECT-383 RECT-384 RECT-382 RECT-385 RECT-386 RECT-387 RECT-388 ~
RECT-389 RECT-390 RECT-391 
&Scoped-Define DISPLAYED-OBJECTS fiFileNameCA fiCamcode fitltc fieffdat ~
fimakdes fimoddes ficovcodCA ficlassCA fiSeat fidspc fibaseprm fiFileNameCL ~
ficlassCL ficovcodCL fitariff fiBip fiBiA fiPda fimv41 fimv42 fimv43 ~
fiSeatDriver fiSeatPass 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR campaign AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bucel 
     LABEL "CANCEL" 
     SIZE 11 BY .95
     FONT 6.

DEFINE BUTTON budel 
     LABEL "DELETE" 
     SIZE 11 BY .95
     FONT 6.

DEFINE VARIABLE fidelform AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 16 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fidelto AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 16 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fitext AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 21 BY 1.14
     BGCOLOR 3 FGCOLOR 7 FONT 17 NO-UNDO.

DEFINE VARIABLE fitext2 AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 16.5 BY 1.14
     BGCOLOR 8 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE raitem AS INTEGER 
     VIEW-AS RADIO-SET VERTICAL
     RADIO-BUTTONS 
          "By Record  ", 1,
"Form - To ", 2,
"ALL ", 3
     SIZE 17.5 BY 5
     FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-392
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 66 BY 5.48
     BGCOLOR 8 .

DEFINE BUTTON buaddCA 
     LABEL "ADD" 
     SIZE 9 BY 1
     FONT 6.

DEFINE BUTTON buaddCL 
     LABEL "ADD" 
     SIZE 9 BY 1
     FONT 6.

DEFINE BUTTON bucancelCA 
     LABEL "CANCEL" 
     SIZE 9 BY 1
     FONT 6.

DEFINE BUTTON bucancelCL 
     LABEL "CANCEL" 
     SIZE 9 BY 1
     FONT 6.

DEFINE BUTTON budeleteCA 
     LABEL "DELETE" 
     SIZE 9 BY 1
     FONT 6.

DEFINE BUTTON budeleteCL 
     LABEL "DELETE" 
     SIZE 9 BY 1
     FONT 6.

DEFINE BUTTON bueditCA 
     LABEL "UPDATE" 
     SIZE 9 BY 1
     FONT 6.

DEFINE BUTTON bueditCL 
     LABEL "UPDATE" 
     SIZE 9 BY 1
     FONT 6.

DEFINE BUTTON buexit 
     LABEL "EXIT" 
     SIZE 9.5 BY 1.19
     FONT 6.

DEFINE BUTTON buExportCA 
     LABEL "EXPORT" 
     SIZE 9 BY 1
     FONT 6.

DEFINE BUTTON buExportCL 
     LABEL "EXPORT" 
     SIZE 9 BY 1
     FONT 6.

DEFINE BUTTON buImportCA 
     LABEL "IMPORT" 
     SIZE 9 BY 1
     FONT 6.

DEFINE BUTTON buImportCL 
     LABEL "IMPORT" 
     SIZE 9 BY 1
     FONT 6.

DEFINE BUTTON buokCA 
     LABEL "OK" 
     SIZE 9 BY 1
     FONT 6.

DEFINE BUTTON buokCL 
     LABEL "OK" 
     SIZE 9 BY 1
     FONT 6.

DEFINE BUTTON buSearchCA 
     LABEL "..." 
     SIZE 3 BY 1.05.

DEFINE BUTTON buSearchCL 
     LABEL "..." 
     SIZE 3 BY 1.05.

DEFINE VARIABLE fibaseprm AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 11.17 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiBiA AS INTEGER FORMAT "->,>>>,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 18.67 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiBip AS INTEGER FORMAT "->,>>>,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 18.67 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiCamcode AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 18.67 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE ficlassCA AS CHARACTER FORMAT "X(4)":U 
     VIEW-AS FILL-IN 
     SIZE 7.33 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE ficlassCL AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 9 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE ficovcodCA AS CHARACTER FORMAT "X(3)":U 
     VIEW-AS FILL-IN 
     SIZE 3.5 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE ficovcodCL AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 3.5 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fidspc AS DECIMAL FORMAT "->>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 7.33 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fieffdat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 13.5 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiFileNameCA AS CHARACTER FORMAT "X(60)":U 
     VIEW-AS FILL-IN 
     SIZE 27 BY 1
     FONT 6 NO-UNDO.

DEFINE VARIABLE fiFileNameCL AS CHARACTER FORMAT "X(70)":U 
     VIEW-AS FILL-IN 
     SIZE 27 BY 1
     FONT 6 NO-UNDO.

DEFINE VARIABLE fimakdes AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 35.83 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fimoddes AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 35.83 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fimv41 AS INTEGER FORMAT "->,>>>,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 18.67 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fimv42 AS INTEGER FORMAT "->,>>>,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 18.67 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fimv43 AS INTEGER FORMAT "->,>>>,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 18.67 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiPda AS INTEGER FORMAT "->,>>>,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 18.67 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiSeat AS INTEGER FORMAT "->>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 5.83 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiSeatDriver AS INTEGER FORMAT ">>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 9.5 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiSeatPass AS INTEGER FORMAT ">>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 9.5 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fitariff AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 3.5 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fitltc AS CHARACTER FORMAT "X(3)":U 
     VIEW-AS FILL-IN 
     SIZE 7.5 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-379
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 66.33 BY 25.52
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-381
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 11.83 BY 1.86
     BGCOLOR 4 .

DEFINE RECTANGLE RECT-382
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 29 BY 1.62
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-383
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 65.33 BY 8.62
     BGCOLOR 3 .

DEFINE RECTANGLE RECT-384
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 65.33 BY 9.38
     BGCOLOR 3 .

DEFINE RECTANGLE RECT-385
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 29 BY 1.62
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-386
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 20.33 BY 1.62
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-387
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 20.33 BY 1.62
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-388
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 20.33 BY 1.62
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-389
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 20.33 BY 1.62
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-390
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 44.5 BY 1.62.

DEFINE RECTANGLE RECT-391
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 44.5 BY 1.62.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY brcampaign FOR 
      campaign SCROLLING.

DEFINE QUERY brCover FOR 
      clastab_fil SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE brcampaign
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS brcampaign campaign _STRUCTURED
  QUERY brcampaign NO-LOCK DISPLAY
      campaign.tltc COLUMN-LABEL "Cam.No." FORMAT "x(20)":U WIDTH 15.33
      campaign.makdes COLUMN-LABEL "Make" FORMAT "x(20)":U
      campaign.moddes COLUMN-LABEL "Model" FORMAT "x(30)":U
      campaign.class FORMAT "x(4)":U WIDTH 5
      campaign.covcod COLUMN-LABEL "Cover Code" FORMAT "x":U WIDTH 5
      campaign.baseprm FORMAT ">>,>>9.99":U WIDTH 9
      campaign.dspc FORMAT ">>9.99":U WIDTH 7
      campaign.effdat FORMAT "99/99/9999":U WIDTH 10
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 72 BY 12.38 ROW-HEIGHT-CHARS .71 FIT-LAST-COLUMN.

DEFINE BROWSE brCover
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS brCover campaign _STRUCTURED
  QUERY brCover NO-LOCK DISPLAY
      clastab_fil.class COLUMN-LABEL "Class" FORMAT "x(5)":U
      clastab_fil.covcod FORMAT "x(1)":U WIDTH 5.17
      clastab_fil.tariff COLUMN-LABEL "Tariff" FORMAT "x(2)":U
            WIDTH 4.83
      clastab_fil.si_41unp COLUMN-LABEL "ร.ย. 41" FORMAT ">,>>>,>>>,>>9":U
            WIDTH 13
      clastab_fil.si_42 COLUMN-LABEL "ร.ย. 42" FORMAT ">,>>>,>>>,>>9":U
            WIDTH 13
      clastab_fil.si_43 COLUMN-LABEL "ร.ย. 43" FORMAT ">,>>>,>>>,>>9":U
            WIDTH 13
      clastab_fil.uom1_si COLUMN-LABEL "BI Per Person" FORMAT ">,>>>,>>>,>>9":U
      clastab_fil.uom2_si COLUMN-LABEL "BI Per Accident" FORMAT ">,>>>,>>>,>>9":U
      clastab_fil.uom5_si COLUMN-LABEL "PD Per Accident" FORMAT ">,>>>,>>>,>>9":U
            WIDTH 13
      clastab_fil.dri_41 COLUMN-LABEL "Seats Driver" FORMAT ">>9":U
      clastab_fil.pass_41 COLUMN-LABEL "Seat Passenger" FORMAT ">>9":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 72 BY 13 ROW-HEIGHT-CHARS .76 FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME frmain
     brCover AT ROW 13.71 COL 1.5
     brcampaign AT ROW 1.24 COL 1.5
     fiFileNameCA AT ROW 1.71 COL 85.33 COLON-ALIGNED NO-LABEL
     buSearchCA AT ROW 1.71 COL 114.5
     buImportCA AT ROW 1.71 COL 120.17
     buExportCA AT ROW 1.71 COL 129.17
     fiCamcode AT ROW 3.52 COL 95.33 COLON-ALIGNED NO-LABEL
     fitltc AT ROW 4.62 COL 95.33 COLON-ALIGNED NO-LABEL
     fieffdat AT ROW 4.62 COL 117.67 COLON-ALIGNED NO-LABEL
     fimakdes AT ROW 5.71 COL 95.33 COLON-ALIGNED NO-LABEL
     fimoddes AT ROW 6.81 COL 95.33 COLON-ALIGNED NO-LABEL
     ficovcodCA AT ROW 7.91 COL 95.33 COLON-ALIGNED NO-LABEL
     ficlassCA AT ROW 7.91 COL 108.67 COLON-ALIGNED NO-LABEL
     fiSeat AT ROW 7.91 COL 125.33 COLON-ALIGNED NO-LABEL
     fidspc AT ROW 9 COL 95.33 COLON-ALIGNED NO-LABEL
     fibaseprm AT ROW 9 COL 120.17 COLON-ALIGNED NO-LABEL
     buaddCA AT ROW 10.76 COL 90.33
     bueditCA AT ROW 10.76 COL 99.33
     budeleteCA AT ROW 10.76 COL 108.33
     buokCA AT ROW 10.76 COL 119.5
     bucancelCA AT ROW 10.76 COL 128.5
     fiFileNameCL AT ROW 14 COL 85.33 COLON-ALIGNED NO-LABEL
     buImportCL AT ROW 14 COL 120.17
     buExportCL AT ROW 14 COL 129.17
     ficlassCL AT ROW 16.14 COL 92.33 COLON-ALIGNED NO-LABEL
     ficovcodCL AT ROW 16.14 COL 117.17 COLON-ALIGNED NO-LABEL
     fitariff AT ROW 16.14 COL 131.83 COLON-ALIGNED NO-LABEL
     fiBip AT ROW 17.24 COL 92.33 COLON-ALIGNED NO-LABEL
     fiBiA AT ROW 18.33 COL 92.33 COLON-ALIGNED NO-LABEL
     fiPda AT ROW 19.43 COL 92.33 COLON-ALIGNED NO-LABEL
     fimv41 AT ROW 17.24 COL 117.17 COLON-ALIGNED NO-LABEL
     fimv42 AT ROW 18.33 COL 117.17 COLON-ALIGNED NO-LABEL
     fimv43 AT ROW 19.43 COL 117.17 COLON-ALIGNED NO-LABEL
     fiSeatDriver AT ROW 20.52 COL 92.33 COLON-ALIGNED NO-LABEL
     fiSeatPass AT ROW 20.52 COL 117.17 COLON-ALIGNED NO-LABEL
     buSearchCL AT ROW 14 COL 114.5
     buaddCL AT ROW 22.33 COL 90.33
     bueditCL AT ROW 22.33 COL 99.33
     budeleteCL AT ROW 22.33 COL 108.33
     buokCL AT ROW 22.33 COL 119.5
     bucancelCL AT ROW 22.33 COL 128.5
     buexit AT ROW 24.86 COL 128.33
     "4.1 :" VIEW-AS TEXT
          SIZE 5 BY .62 AT ROW 17.38 COL 113.83
          BGCOLOR 3 FGCOLOR 15 FONT 6
     "Cover Type :" VIEW-AS TEXT
          SIZE 13 BY .62 AT ROW 16.29 COL 105.17
          BGCOLOR 3 FGCOLOR 15 FONT 6
     "BI per Accident :" VIEW-AS TEXT
          SIZE 16.17 BY .62 AT ROW 18.48 COL 77
          BGCOLOR 3 FGCOLOR 15 FONT 6
     "File Name :" VIEW-AS TEXT
          SIZE 11 BY .62 AT ROW 1.91 COL 76.33
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "PD per Accident :" VIEW-AS TEXT
          SIZE 17 BY .62 AT ROW 19.57 COL 77
          BGCOLOR 3 FGCOLOR 15 FONT 6
     "4.3 :" VIEW-AS TEXT
          SIZE 5 BY .62 AT ROW 19.57 COL 113.83
          BGCOLOR 3 FGCOLOR 15 FONT 6
     "Base :" VIEW-AS TEXT
          SIZE 6.33 BY .62 AT ROW 9.19 COL 114.67
          BGCOLOR 3 FGCOLOR 15 FONT 6
     "File Name :" VIEW-AS TEXT
          SIZE 11 BY .62 AT ROW 14.19 COL 76.33
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "No. :" VIEW-AS TEXT
          SIZE 14.67 BY .62 AT ROW 4.76 COL 81.17
          BGCOLOR 3 FGCOLOR 15 FONT 6
     "DSPC :" VIEW-AS TEXT
          SIZE 7.5 BY .62 AT ROW 9.19 COL 81.17
          BGCOLOR 3 FGCOLOR 15 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 139.83 BY 25.91.

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME frmain
     "BI per Person :" VIEW-AS TEXT
          SIZE 14.67 BY .62 AT ROW 17.38 COL 77
          BGCOLOR 3 FGCOLOR 15 FONT 6
     "Tariff :" VIEW-AS TEXT
          SIZE 7 BY .62 AT ROW 16.29 COL 126
          BGCOLOR 3 FGCOLOR 15 FONT 6
     "Class Code :" VIEW-AS TEXT
          SIZE 12.5 BY .62 AT ROW 16.29 COL 77
          BGCOLOR 3 FGCOLOR 15 FONT 6
     "4.2 :" VIEW-AS TEXT
          SIZE 4.5 BY .62 AT ROW 18.52 COL 113.83
          BGCOLOR 3 FGCOLOR 15 FONT 6
     "Campaign no. :" VIEW-AS TEXT
          SIZE 14.67 BY .62 AT ROW 3.62 COL 81.17
          BGCOLOR 3 FGCOLOR 15 FONT 6
     "Seat Driver :" VIEW-AS TEXT
          SIZE 13.5 BY .62 AT ROW 20.71 COL 77
          BGCOLOR 3 FGCOLOR 15 FONT 6
     "Seat Pass. :" VIEW-AS TEXT
          SIZE 12.17 BY .62 AT ROW 20.71 COL 106.83
          BGCOLOR 3 FGCOLOR 15 FONT 6
     "Class :" VIEW-AS TEXT
          SIZE 7.33 BY .62 AT ROW 8.1 COL 103.17
          BGCOLOR 3 FGCOLOR 15 FONT 6
     "Model :" VIEW-AS TEXT
          SIZE 8 BY .62 AT ROW 6.95 COL 81.17
          BGCOLOR 3 FGCOLOR 15 FONT 6
     "Seat :" VIEW-AS TEXT
          SIZE 7 BY .62 AT ROW 8.1 COL 120.33
          BGCOLOR 3 FGCOLOR 15 FONT 6
     "Eff. Date :" VIEW-AS TEXT
          SIZE 11.17 BY .62 AT ROW 4.76 COL 106.33
          BGCOLOR 3 FGCOLOR 15 FONT 6
     "Cover Type :" VIEW-AS TEXT
          SIZE 12.67 BY .62 AT ROW 8.1 COL 81.17
          BGCOLOR 3 FGCOLOR 15 FONT 6
     "Make :" VIEW-AS TEXT
          SIZE 8.17 BY .62 AT ROW 5.86 COL 81.17
          BGCOLOR 3 FGCOLOR 15 FONT 6
     RECT-379 AT ROW 1.19 COL 74
     RECT-381 AT ROW 24.48 COL 127
     RECT-383 AT ROW 15.38 COL 74.5
     RECT-384 AT ROW 3.1 COL 74.5
     RECT-382 AT ROW 22 COL 89.33
     RECT-385 AT ROW 10.43 COL 89.33
     RECT-386 AT ROW 10.43 COL 118.33
     RECT-387 AT ROW 22 COL 118.33
     RECT-388 AT ROW 1.38 COL 119
     RECT-389 AT ROW 13.67 COL 119
     RECT-390 AT ROW 13.67 COL 74.5
     RECT-391 AT ROW 1.38 COL 74.5
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 139.83 BY 25.91.

DEFINE FRAME frdelete
     raitem AT ROW 2.67 COL 4.17 NO-LABEL
     fidelform AT ROW 4.67 COL 22.17 COLON-ALIGNED NO-LABEL
     fidelto AT ROW 4.62 COL 43.33 COLON-ALIGNED NO-LABEL
     budel AT ROW 11 COL 24.5
     bucel AT ROW 11 COL 36.33
     fitext AT ROW 1.19 COL 1.67 NO-LABEL
     fitext2 AT ROW 2.81 COL 49.33 NO-LABEL
     "To :" VIEW-AS TEXT
          SIZE 4 BY .62 AT ROW 4.86 COL 41.17
          BGCOLOR 8 FONT 6
     " คลิกเลือกลบข้อมูลจากตาราง" VIEW-AS TEXT
          SIZE 26 BY 1.1 AT ROW 2.86 COL 23.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "1. Delete Form-To Campaign ระบุเลข Campaign No." VIEW-AS TEXT
          SIZE 41 BY .62 AT ROW 8.57 COL 4.5
          FGCOLOR 7 
     "2. Delete Form-To Cover ระบุอักษรตัวแรกของ Class เช่น ~"D110~" ระบุเป็น ~"D~"" VIEW-AS TEXT
          SIZE 61.5 BY .62 AT ROW 9.38 COL 4.5
          FGCOLOR 7 
     "ลบข้อมูลทุก Record" VIEW-AS TEXT
          SIZE 18.83 BY .62 AT ROW 6.52 COL 24.67
          BGCOLOR 8 FGCOLOR 1 FONT 6
     RECT-392 AT ROW 2.43 COL 3
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 34.33 ROW 8
         SIZE 71.5 BY 12
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
  CREATE WINDOW campaign ASSIGN
         HIDDEN             = YES
         TITLE              = "Set Campaign Thanachat - WGWTACAM.W"
         HEIGHT             = 25.91
         WIDTH              = 139.83
         MAX-HEIGHT         = 46.1
         MAX-WIDTH          = 213.33
         VIRTUAL-HEIGHT     = 46.1
         VIRTUAL-WIDTH      = 213.33
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
IF NOT campaign:LOAD-ICON("wimage/safety.ico":U) THEN
    MESSAGE "Unable to load icon: wimage/safety.ico"
            VIEW-AS ALERT-BOX WARNING BUTTONS OK.
&ENDIF
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW campaign
  VISIBLE,,RUN-PERSISTENT                                               */
/* REPARENT FRAME */
ASSIGN FRAME frdelete:FRAME = FRAME frmain:HANDLE.

/* SETTINGS FOR FRAME frdelete
   Custom                                                               */
/* SETTINGS FOR FILL-IN fitext IN FRAME frdelete
   ALIGN-L                                                              */
/* SETTINGS FOR FILL-IN fitext2 IN FRAME frdelete
   ALIGN-L                                                              */
/* SETTINGS FOR FRAME frmain
   FRAME-NAME Custom                                                    */

DEFINE VARIABLE XXTABVALXX AS LOGICAL NO-UNDO.

ASSIGN XXTABVALXX = FRAME frdelete:MOVE-AFTER-TAB-ITEM (fiFileNameCA:HANDLE IN FRAME frmain)
       XXTABVALXX = FRAME frdelete:MOVE-BEFORE-TAB-ITEM (buSearchCA:HANDLE IN FRAME frmain)
/* END-ASSIGN-TABS */.

/* BROWSE-TAB brCover 1 frmain */
/* BROWSE-TAB brcampaign brCover frmain */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(campaign)
THEN campaign:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE brcampaign
/* Query rebuild information for BROWSE brcampaign
     _TblList          = "brstat.campaign"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _FldNameList[1]   > brstat.campaign.tltc
"campaign.tltc" "Cam.No." "x(20)" "character" ? ? ? ? ? ? no ? no no "15.33" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[2]   > brstat.campaign.makdes
"campaign.makdes" "Make" "x(20)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   > brstat.campaign.moddes
"campaign.moddes" "Model" "x(30)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   > brstat.campaign.class
"campaign.class" ? ? "character" ? ? ? ? ? ? no ? no no "5" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   > brstat.campaign.covcod
"campaign.covcod" "Cover Code" ? "character" ? ? ? ? ? ? no ? no no "5" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[6]   > brstat.campaign.baseprm
"campaign.baseprm" ? ? "decimal" ? ? ? ? ? ? no ? no no "9" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[7]   > brstat.campaign.dspc
"campaign.dspc" ? ? "decimal" ? ? ? ? ? ? no ? no no "7" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[8]   > brstat.campaign.effdat
"campaign.effdat" ? ? "date" ? ? ? ? ? ? no ? no no "10" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _Query            is OPENED
*/  /* BROWSE brcampaign */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE brCover
/* Query rebuild information for BROWSE brCover
     _TblList          = "brstat.clastab_fil"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _FldNameList[1]   > brstat.clastab_fil.class
"clastab_fil.class" "Class" "x(5)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[2]   > brstat.clastab_fil.covcod
"clastab_fil.covcod" ? ? "character" ? ? ? ? ? ? no ? no no "5.17" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   > brstat.clastab_fil.tariff
"clastab_fil.tariff" "Tariff" ? "character" ? ? ? ? ? ? no ? no no "4.83" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   > brstat.clastab_fil.si_41unp
"clastab_fil.si_41unp" "ร.ย. 41" ? "integer" ? ? ? ? ? ? no ? no no "13" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   > brstat.clastab_fil.si_42
"clastab_fil.si_42" "ร.ย. 42" ? "integer" ? ? ? ? ? ? no ? no no "13" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[6]   > brstat.clastab_fil.si_43
"clastab_fil.si_43" "ร.ย. 43" ? "integer" ? ? ? ? ? ? no ? no no "13" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[7]   > brstat.clastab_fil.uom1_si
"clastab_fil.uom1_si" "BI Per Person" ? "integer" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[8]   > brstat.clastab_fil.uom2_si
"clastab_fil.uom2_si" "BI Per Accident" ? "integer" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[9]   > brstat.clastab_fil.uom5_si
"clastab_fil.uom5_si" "PD Per Accident" ? "integer" ? ? ? ? ? ? no ? no no "13" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[10]   > brstat.clastab_fil.dri_41
"clastab_fil.dri_41" "Seats Driver" ? "integer" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[11]   > brstat.clastab_fil.pass_41
"clastab_fil.pass_41" "Seat Passenger" ? "integer" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _Query            is OPENED
*/  /* BROWSE brCover */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME campaign
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL campaign campaign
ON END-ERROR OF campaign /* Set Campaign Thanachat - WGWTACAM.W */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL campaign campaign
ON WINDOW-CLOSE OF campaign /* Set Campaign Thanachat - WGWTACAM.W */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME brcampaign
&Scoped-define SELF-NAME brcampaign
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brcampaign campaign
ON VALUE-CHANGED OF brcampaign IN FRAME frmain
DO:
  FIND CURRENT campaign NO-LOCK NO-ERROR.
  IF NOT AVAIL campaign THEN DO:
      DISPLAY
        ""  @ fieffdat
        ""  @ fimakdes
        ""  @ fimoddes
        ""  @ ficovcodCA
        ""  @ ficlassCA
        0   @ fiseat
        0   @ fidspc
        0   @ fibaseprm
        ""  @ fiCamcode 
        ""  @ fitltc WITH FRAME frmain.
  END.
  ELSE DO:
    IF INDEX(campaign.tltc,"|") <> 0 THEN DO:
        ASSIGN
            fiCamcode = SUBSTRING(campaign.tltc,1,INDEX(campaign.tltc,"|") - 1)
            fitltc    = SUBSTRING(campaign.tltc,INDEX(campaign.tltc,"|") + 1,4).
    END.
    ELSE DO:
        ASSIGN
            fiCamcode = ""
            fitltc    = campaign.tltc.
    END.
    

    DISPLAY
        /*campaign.tltc    @ fitltc*/
        campaign.effdat  @ fieffdat
        campaign.makdes  @ fimakdes
        campaign.moddes  @ fimoddes
        campaign.covcod  @ ficovcodCA
        campaign.class   @ ficlassCA
        campaign.mv1s    @ fiseat
        campaign.dspc    @ fidspc
        campaign.baseprm @ fibaseprm
        fiCamcode fitltc WITH FRAME frmain.
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME brCover
&Scoped-define SELF-NAME brCover
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brCover campaign
ON MOUSE-SELECT-DBLCLICK OF brCover IN FRAME frmain
DO:
  GET CURRENT brcover.
  FIND CURRENT clastab_fil NO-LOCK.

  APPLY "CLOSE" TO THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brCover campaign
ON VALUE-CHANGED OF brCover IN FRAME frmain
DO:
  FIND CURRENT clastab_fil NO-LOCK NO-ERROR.
  IF NOT AVAIL clastab_fil THEN DO:
      DISPLAY
          ""   @  ficlassCl
          ""   @  ficovcodcl
          ""   @  fiTariff
          0    @  fimv41
          0    @  fimv42
          0    @  fimv43
          0    @  fiBip
          0    @  fiBiA
          0    @  FiPdA
          0    @  fiSeatDriver
          0    @  fiSeatPass
      WITH FRAME frmain.
  END.
  ELSE DO:
      DISPLAY
          clastab_fil.class    @  ficlassCl
          clastab_fil.covcod   @  ficovcodcl
          clastab_fil.Tariff   @  fiTariff
          clastab_fil.si_41unp @  fimv41
          clastab_fil.si_42    @  fimv42
          clastab_fil.si_43    @  fimv43
          clastab_fil.uom1_si  @  fiBip
          clastab_fil.uom2_si  @  fiBiA
          clastab_fil.uom5_si  @  FiPdA
          clastab_fil.dri_41   @  fiSeatDriver
          clastab_fil.Pass_41  @  fiSeatPass
      WITH FRAME frmain.
  END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buaddCA
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buaddCA campaign
ON CHOOSE OF buaddCA IN FRAME frmain /* ADD */
DO:

  RUN PDEnableCA IN THIS-PROCEDURE.

  ASSIGN
      cmode       = "ADD"
      fiCamcode   = ""
      fitltc      = ""
      fieffdat    = ?
      fimakdes    = ""
      fimoddes    = ""
      ficovcodCA  = ""
      ficlassCA   = ""
      fiseat      = 0
      fidspc      = 0
      fibaseprm   = 0.

  DISPLAY 
      fiCamcode fitltc fieffdat fimakdes fimoddes ficovcodCA ficlassCA
      fiseat fidspc fibaseprm WITH FRAME frmain.

  ASSIGN
      buAddCA:SENSITIVE    IN FRAME frMain = NO
      bueditCA:SENSITIVE   IN FRAME frMain = NO
      buDeleteCA:SENSITIVE IN FRAME frMain = NO
    
      buOKCA:SENSITIVE     IN FRAME frMain = YES
      buCancelCA:SENSITIVE IN FRAME frMain = YES.

  APPLY "ENTRY" TO fiCamcode IN FRAME frmain.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buaddCL
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buaddCL campaign
ON CHOOSE OF buaddCL IN FRAME frmain /* ADD */
DO:
  
  RUN PDEnableCl IN THIS-PROCEDURE.

  ASSIGN
      cmode       = "ADD"
      fiClassCl   = ""
      fiCovCodCl  = ""
      fiTariff    = ""
      fiBip       = 0
      fiBiA       = 0
      fiPDA       = 0
      fimv41      = 0
      fimv42      = 0
      fimv43      = 0
      fiSeatDriver = 0
      fiSeatPass   = 0.

  DISPLAY 
      fiClassCl fiCovcodCl fiTariff fiBiP fiBiA fiPdA fimv41
      fimv42 fimv43 fiSeatDriver fiSeatPass WITH FRAME frmain.

  ASSIGN
      buAddCL:SENSITIVE    IN FRAME frMain = NO
      bueditCL:SENSITIVE   IN FRAME frMain = NO
      buDeleteCL:SENSITIVE IN FRAME frMain = NO
    
      buOKCL:SENSITIVE     IN FRAME frMain = YES
      buCancelCL:SENSITIVE IN FRAME frMain = YES.

  APPLY "ENTRY" TO ficlasscl IN FRAME frmain.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bucancelCA
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bucancelCA campaign
ON CHOOSE OF bucancelCA IN FRAME frmain /* CANCEL */
DO:
  
  RUN PDClearCA   IN THIS-PROCEDURE.
  RUN PDDisableCA IN THIS-PROCEDURE.

  ASSIGN
    buAddCA:SENSITIVE    IN FRAME frMain  = YES
    buEditCA:SENSITIVE   IN FRAME frMain  = YES
    buDeleteCA:SENSITIVE IN FRAME frmain  = YES
     
    buOKCA:SENSITIVE     IN FRAME frMain  = NO
    buCancelCA:SENSITIVE IN FRAME frMain  = NO.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bucancelCL
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bucancelCL campaign
ON CHOOSE OF bucancelCL IN FRAME frmain /* CANCEL */
DO:
  RUN PDClearCL   IN THIS-PROCEDURE.
  RUN PDDisableCL IN THIS-PROCEDURE.

  ASSIGN
    buAddCL:SENSITIVE    IN FRAME frMain  = YES
    buEditCL:SENSITIVE   IN FRAME frMain  = YES
    buDeleteCL:SENSITIVE IN FRAME frmain  = YES
     
    buOKCL:SENSITIVE     IN FRAME frMain  = NO
    buCancelCL:SENSITIVE IN FRAME frMain  = NO.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frdelete
&Scoped-define SELF-NAME bucel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bucel campaign
ON CHOOSE OF bucel IN FRAME frdelete /* CANCEL */
DO:
  ASSIGN
      fidelform = ""
      fidelto   = "".

  DISPLAY fidelform fidelto WITH FRAME frdelete.

  /*---- Campaign ---*/
  RUN PDUpdateCA.
  APPLY "VALUE-CHANGED" TO brcampaign IN FRAME frMain.

  RUN PDDisableCA IN THIS-PROCEDURE.

  /*--- Cover Code ---*/
  RUN PDUpdateCL.
  APPLY "VALUE-CHANGED" TO brcover IN FRAME frMain.

  RUN PDDisableCl IN THIS-PROCEDURE.

  HIDE FRAME frdelete.
  nv_delete = 0.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME budel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL budel campaign
ON CHOOSE OF budel IN FRAME frdelete /* DELETE */
DO:
  IF nv_delete = 1 THEN DO: /*Delete Campaign*/

      /*--- Add A55-0235 ---*/
      IF raitem = 1 THEN DO:
          GET CURRENT brCampaign EXCLUSIVE-LOCK.
          FIND CURRENT Campaign.
              DELETE Campaign.
      END.
      ELSE IF raitem = 2 THEN DO:
          FOR EACH Campaign WHERE
              TRIM(SUBSTRING(Campaign.tltc,1,INDEX(Campaign.tltc,"|") - 1)) >= fidelform AND
              TRIM(SUBSTRING(Campaign.tltc,1,INDEX(Campaign.tltc,"|") - 1)) <= fidelto :
              DELETE Campaign.
          END.
      END.
      ELSE IF raitem = 3 THEN DO:
          FOR EACH Campaign :
              DELETE Campaign.
          END.
      END.
      /*--- End Add A55-0235 ---*/

      RUN PDUpdateCA.
      APPLY "VALUE-CHANGED" TO brcampaign IN FRAME frMain.

      RUN PDDisableCA IN THIS-PROCEDURE.
  END.

  IF nv_delete = 2 THEN DO: /*Delete Cover*/
      
      /*--- Add A55-0235 ---*/
      IF raitem = 1 THEN DO:
          GET CURRENT brCover EXCLUSIVE-LOCK.
          FIND CURRENT Clastab_fil.
              DELETE Clastab_fil.
      END.
      ELSE IF raitem = 2 THEN DO:
          IF LENGTH(fidelform) = 1 THEN DO:
              FOR EACH clastab_fil WHERE 
                       SUBSTRING(clastab_fil.class,1,1) >= fidelform AND
                       SUBSTRING(clastab_fil.class,1,1) <= fidelto :
                  DELETE clastab_fil.
              END.
          END.
          ELSE DO:
              IF LENGTH(fidelform) = 3 THEN DO:
                  FOR EACH clastab_fil WHERE clastab_fil.class >= fidelform AND
                                             clastab_fil.class <= fidelto :
                      DELETE clastab_fil.
                  END.
              END.
          END.
      END.
      ELSE IF raitem = 3 THEN DO:
          FOR EACH clastab_fil :
              DELETE clastab_fil.
          END.
      END.
      /*--- End Add A55-0235 ---*/

      RUN PDUpdateCL.
      APPLY "VALUE-CHANGED" TO brcover IN FRAME frMain.

      RUN PDDisableCl IN THIS-PROCEDURE.

  END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frmain
&Scoped-define SELF-NAME budeleteCA
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL budeleteCA campaign
ON CHOOSE OF budeleteCA IN FRAME frmain /* DELETE */
DO:
    DEF VAR logAns AS LOGI INIT NO.
    logans = NO.
    MESSAGE "ต้องการลบข้อมูล Campaign ?"
    UPDATE logans
    VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO
    TITLE "ยืนยันการเพิ่มข้อมูล".

    IF logans THEN DO:
        nv_delete = 1.
        VIEW FRAME frdelete.
        fitext = " Delete Camapign".
        fitext2 = "Campaign ".
        raitem = 1.
        DISPLAY fitext fitext2 WITH FRAME frdelete. 
        APPLY "ENTRY" TO fidelform IN FRAME frdelete.
    END.

    RUN PDUpdateCA.
    APPLY "VALUE-CHANGED" TO brcampaign IN FRAME frMain.

    RUN PDDisableCA IN THIS-PROCEDURE.


END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME budeleteCL
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL budeleteCL campaign
ON CHOOSE OF budeleteCL IN FRAME frmain /* DELETE */
DO:
  DEF VAR logAns AS LOGI INIT NO.
  logans = NO.
  MESSAGE "ต้องการลบข้อมูลรายการ Cover ?"
  UPDATE logans
  VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO
  TITLE "ยืนยันการเพิ่มข้อมูล".

  IF logans THEN DO:
      nv_delete = 2.
      VIEW FRAME frdelete.
      fitext = "    Delete Cover".
      fiText2 = "Cover".
      raitem = 1.
      DISPLAY fitext fitext2 WITH FRAME frdelete.
      APPLY "ENTRY" TO fidelform IN FRAME frdelete.
  END.

  RUN PDUpdateCL.
  APPLY "VALUE-CHANGED" TO brcover IN FRAME frMain.

  RUN PDDisableCl IN THIS-PROCEDURE.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bueditCA
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bueditCA campaign
ON CHOOSE OF bueditCA IN FRAME frmain /* UPDATE */
DO:
  RUN PDEnableCA IN THIS-PROCEDURE.

  DO WITH FRAME frmain :
      ASSIGN
          fiCamcode fitltc fieffdat fimakdes fimoddes
          ficovcodca ficlassca fiseat
          fidspc fibaseprm.
          
      ASSIGN
          buAddCA:SENSITIVE    IN FRAME frMain = NO
          bueditCA:SENSITIVE   IN FRAME frMain = NO
          buDeleteCA:SENSITIVE IN FRAME frMain = NO
        
          buOKCA:SENSITIVE     IN FRAME frMain = YES
          buCancelCA:SENSITIVE IN FRAME frMain = YES

          cmode = "UPDATE".

  END.

  DISP fiCamcode fitltc fieffdat fimakdes fimoddes
       ficovcodca ficlassca fiseat
       fidspc fibaseprm WITH FRAME frmain.

  APPLY "ENTRY" TO fitltc.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bueditCL
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bueditCL campaign
ON CHOOSE OF bueditCL IN FRAME frmain /* UPDATE */
DO:
  RUN PDEnableCL IN THIS-PROCEDURE.

  DO WITH FRAME frmain :
      ASSIGN
          fiClassCl fiCovCodCl fiTariff 
          fiBiP fiBiA fiPdA fimv41 fimv42 fimv43
          fiSeatDriver fiSeatPass.
          
      ASSIGN
          buAddCL:SENSITIVE    IN FRAME frMain = NO
          bueditCL:SENSITIVE   IN FRAME frMain = NO
          buDeleteCL:SENSITIVE IN FRAME frMain = NO
        
          buOKCL:SENSITIVE     IN FRAME frMain = YES
          buCancelCL:SENSITIVE IN FRAME frMain = YES

          cmode = "UPDATE".
  END.

  DISP fiClassCl fiCovCodCl fiTariff 
       fiBiP fiBiA fiPdA fimv41 fimv42 fimv43
       fiSeatDriver fiSeatPass WITH FRAME frmain.

  APPLY "ENTRY" TO ficlassCl.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buexit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buexit campaign
ON CHOOSE OF buexit IN FRAME frmain /* EXIT */
DO:
  APPLY "CLOSE" TO THIS-PROCEDURE. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buExportCA
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buExportCA campaign
ON CHOOSE OF buExportCA IN FRAME frmain /* EXPORT */
DO:
  DEFINE VAR logAns AS LOGICAL INIT NO.

  IF fiFileNameCA = "" THEN DO:
      MESSAGE "กรุณาระบุชื่อไฟล์ที่ต้องการ Export..." VIEW-AS ALERT-BOX WARNING.
      APPLY "ENTRY" TO fiFileNameCA IN FRAME frmain.
      RETURN NO-APPLY.
  END.
  ELSE DO:
      MESSAGE "โอนข้อมูล Camapign ?" UPDATE logAns
      VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO TITLE "ยืนยันการโอนข้อมูล".
    
      IF logAns THEN DO:
          OUTPUT TO VALUE(fiFileNameCA).
          EXPORT DELIMITER ";"
              "Campaign No."
              "Sub Class"
              "Effective Date"
              "Brand"
              "Model"
              "Cover Code"
              "Class"
              "Seat"
              "Discount"
              "Base".

          FOR EACH campaign :
              EXPORT DELIMITER ";"
                  SUBSTRING(campaign.tltc,1,INDEX(campaign.tltc,"|") - 1)
                  SUBSTRING(campaign.tltc,INDEX(campaign.tltc,"|") + 1,4)
                  campaign.effdat
                  campaign.makdes
                  campaign.moddes
                  campaign.covcod
                  campaign.class
                  campaign.mv1s
                  campaign.dspc
                  campaign.baseprm.
              ACCUM 1(COUNT).
          END.
          OUTPUT CLOSE.
    
          MESSAGE "โอนข้อมูล campaign จำนวน " ACCUM COUNT 1 " รายการ" SKIP(1)
                  "ไปยังไฟล์ : " fiFileNameCA VIEW-AS ALERT-BOX INFORMATION.
      END.
      ELSE RETURN NO-APPLY.
    
      fiFileNameCA = "".
      DISP fiFileNameCA WITH FRAME frmain.
  END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buExportCL
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buExportCL campaign
ON CHOOSE OF buExportCL IN FRAME frmain /* EXPORT */
DO:
  DEFINE VAR logAns AS LOGICAL INIT NO.

  IF fiFileNameCl = "" THEN  DO:
      MESSAGE "กรุณาระบุชื่อไฟล์ที่ต้องการ Export..." VIEW-AS ALERT-BOX WARNING.
      APPLY "ENTRY" TO fiFileNameCL IN FRAME frmain.
      RETURN NO-APPLY.
  END.
  ELSE DO:
      MESSAGE "โอนข้อมูลความคุ้มครอง ?" UPDATE logAns
      VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO TITLE "ยืนยันการโอนข้อมูล".
      IF logAns THEN DO:
          OUTPUT TO VALUE(fiFileNameCL).
          EXPORT DELIMITER ";"
              "Class"
              "Cover Code"
              "Tariff"
              "BI Per Person"
              "BI Per Accident"
              "PD Per Accident"
              "รย. 4.1"
              "รย. 4.2"
              "รย. 4.3"
              "Seat Driver"
              "Seat Pass.".

          FOR EACH clastab_fil :
              EXPORT DELIMITER ";"
                  clastab_fil.class
                  clastab_fil.covcod
                  clastab_fil.Tariff
                  clastab_fil.si_41unp
                  clastab_fil.si_42
                  clastab_fil.si_43
                  clastab_fil.uom1_si
                  clastab_fil.uom2_si
                  clastab_fil.uom5_si
                  clastab_fil.dri_41  
                  clastab_fil.Pass_41 .
              ACCUM 1(COUNT).
          END.
          OUTPUT CLOSE.
    
          MESSAGE "โอนข้อมูลความคุ้มครอง จำนวน " ACCUM COUNT 1 " รายการ" SKIP(1)
                  "ไปยังไฟล์ : " fiFileNameCL VIEW-AS ALERT-BOX INFORMATION.
      END.
      ELSE RETURN NO-APPLY.
    
      fiFileNameCL = "".
      DISP fiFileNameCL WITH FRAME frmain.
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buImportCA
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buImportCA campaign
ON CHOOSE OF buImportCA IN FRAME frmain /* IMPORT */
DO:
    IF fiFileNameCA = "" THEN DO:
        MESSAGE "กรุณาระบุชื่อไฟล์ที่ต้องการ Import ..." VIEW-AS ALERT-BOX WARNING.
        APPLY "ENTRY" TO fiFileNameCA IN FRAME frmain.
        RETURN NO-APPLY.
    END.
    ELSE DO:
        INPUT FROM VALUE(fiFileNameCA).
        REPEAT:
            RUN PDClearCA.
            IMPORT DELIMITER ","
                wCamcode
                wtltc    
                weffdat  
                wmakdes  
                wmoddes  
                wcovcodca
                wclassca 
                wseat    
                wdspc    
                wbaseprm.
            
                FIND LAST  campaign WHERE
                           campaign.tltc   = wCamcode + "|" + wtltc   AND
                           campaign.effdat = weffdat AND
                           campaign.makdes = wmakdes AND
                           campaign.moddes = wmoddes NO-ERROR.
                IF AVAIL campaign THEN DO:
                    ASSIGN
                        /*campaign.tltc    =  wCamcode*/
                        campaign.tltc    =  wCamcode + "|" + wtltc
                        campaign.effdat  =  weffdat
                        campaign.makdes  =  wmakdes
                        campaign.moddes  =  wmoddes
                        campaign.covcod  =  wcovcodCA
                        campaign.class   =  wclassCA
                        campaign.mv1S    =  wseat
                        campaign.dspc    =  wdspc
                        campaign.baseprm =  wbaseprm.
                    ACCUMULATE 1 (COUNT).
                    NEXT.
                END.
                ELSE DO:
                    CREATE campaign.
                    ASSIGN
                        /*campaign.tltc    =  wCamcode*/
                        campaign.tltc    =  wCamcode + "|" + wtltc
                        campaign.effdat  =  weffdat
                        campaign.makdes  =  wmakdes
                        campaign.moddes  =  wmoddes
                        campaign.covcod  =  wcovcodCA
                        campaign.class   =  wclassCA
                        campaign.mv1S    =  wseat
                        campaign.dspc    =  wdspc
                        campaign.baseprm =  wbaseprm.
                    ACCUMULATE 1 (COUNT).
                    NEXT.
                END.
            INPUT CLOSE.
        END. /*REPEAT*/
        
        MESSAGE "นำเข้าข้อมูล Campaign จำนวน " ACCUMULATE COUNT 1  "รายการ" VIEW-AS ALERT-BOX.
        RUN PDUpdateCA.
        
        fiFileNameCA = "".
        DISP fiFileNameCA WITH FRAME frmain.

    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buImportCL
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buImportCL campaign
ON CHOOSE OF buImportCL IN FRAME frmain /* IMPORT */
DO:
    IF fiFileNameCL = "" THEN DO:
        MESSAGE "กรุณาระบุชื่อไฟล์ที่ต้องการ Import..." VIEW-AS ALERT-BOX WARNING.
        APPLY "ENTRY" TO fiFileNameCL IN FRAME frmain.
        RETURN NO-APPLY.
    END.
    ELSE DO:
        INPUT FROM VALUE(fiFileNameCL).
        REPEAT:
            RUN PDClearCL.
            IMPORT DELIMITER ","
                wClassCl    
                wCovcodCl 
                wTariff  
                wBiP  
                wBiA
                wPDA 
                wMv41    
                wMv42    
                wMv43
                wSeatDri
                wSeatPass.
        
              FIND LAST clastab_fil WHERE clastab_fil.class   = wClassCl  AND
                                          clastab_fil.covcod  = wcovcodcl AND
                                          clastab_fil.tariff  = wTariff   /*AND 
                                          clastab_fil.Pass_41 = wSeatPass*/ NO-ERROR.
              IF AVAIL clastab_fil THEN DO:
                  ASSIGN
                      clastab_fil.class    =  wclassCl
                      clastab_fil.covcod   =  wcovcodCl
                      clastab_fil.Tariff   =  wTariff
                      clastab_fil.uom1_si  =  wBiP
                      clastab_fil.uom2_si  =  wBiA
                      clastab_fil.uom5_si  =  wPDA
                      clastab_fil.si_41unp =  wMv41
                      clastab_fil.si_42    =  wMv42
                      clastab_fil.si_43    =  wMv43
                      clastab_fil.dri_41   =  wSeatDri
                      clastab_fil.Pass_41  =  wSeatPass.
                  ACCUMULATE 1 (COUNT).
                  NEXT.
              END.
              ELSE DO:
                  CREATE clastab_fil.
                  ASSIGN
                      clastab_fil.class    =  wclassCl
                      clastab_fil.covcod   =  wcovcodCl
                      clastab_fil.Tariff   =  wTariff
                      clastab_fil.uom1_si  =  wBiP
                      clastab_fil.uom2_si  =  wBiA
                      clastab_fil.uom5_si  =  wPDA
                      clastab_fil.si_41unp =  wMv41
                      clastab_fil.si_42    =  wMv42
                      clastab_fil.si_43    =  wMv43
                      clastab_fil.dri_41   =  wSeatDri
                      clastab_fil.Pass_41  =  wSeatPass.
                  ACCUMULATE 1 (COUNT).
                  NEXT.
              END.
            INPUT CLOSE.
        END. /*REPEAT*/
        
        MESSAGE "นำเข้าข้อมูลความคุ้มครอง จำนวน " ACCUMULATE COUNT 1  "รายการ" VIEW-AS ALERT-BOX.
        RUN PDUpdateCl.
        
        fiFileNameCL = "".
        DISP fiFileNameCL WITH FRAME frmain.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buokCA
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buokCA campaign
ON CHOOSE OF buokCA IN FRAME frmain /* OK */
DO:
  IF cmode = "ADD" THEN DO:
      IF fitltc = "" THEN DO:
          MESSAGE "ข้อมูลผิดพลาด, กรุณาตรวจสอบเลข Campaign" VIEW-AS ALERT-BOX ERROR.
          APPLY "ENTRY" TO fitltc IN FRAME frMain.
      END.
      ELSE IF fieffdat = ? THEN DO:
          MESSAGE "ข้อมูลผิดพลาด,กรุณาตรวจสอบวันที่เริ่มใช้เบี้ย" VIEW-AS ALERT-BOX ERROR.
          APPLY "ENTRY" TO fieffdat IN FRAME frMain.
      END.
      ELSE IF fimakdes = "" THEN DO:
          MESSAGE "ข้อมูลผิดพลาด, กรุณาตรวจสอบยี่ห้อรถ" VIEW-AS ALERT-BOX ERROR.
          APPLY "ENTRY" TO fimakdes IN FRAME frMain.
      END.
      ELSE IF fimoddes = "" THEN DO:
          MESSAGE "ข้อมูลผิดพลาด, กรุณาตรวจสอบรุ่นรถ" VIEW-AS ALERT-BOX ERROR.
          APPLY "ENTRY" TO fimoddes IN FRAME frMain.
      END.

      RUN PDAddCampaign IN THIS-PROCEDURE.
      RUN PDUpdateCA    IN THIS-PROCEDURE.
      APPLY "VALUE-CHANGED" TO brcampaign.
      RUN PDDisableCA   IN THIS-PROCEDURE.
  END. /*ADD*/
  ELSE IF cmode = "UPDATE" THEN DO:
      GET CURRENT brcampaign EXCLUSIVE-LOCK.

      ASSIGN FRAME frmain
          fiCamcode fitltc fieffdat fimakdes fimoddes 
          ficovcodCA ficlassCA fiseat
          fidspc fibaseprm.

      RUN PDAddCampaign IN THIS-PROCEDURE.
      RUN PDUpdateCA    IN THIS-PROCEDURE.
      APPLY "VALUE-CHANGED" TO brcampaign.
      RUN PDDisableCA   IN THIS-PROCEDURE.

  END. /*UPDATE*/

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buokCL
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buokCL campaign
ON CHOOSE OF buokCL IN FRAME frmain /* OK */
DO:
  IF cmode = "ADD" THEN DO:
      IF fiClassCl = "" THEN DO:
          MESSAGE "ข้อมูลผิดพลาด, กรุณาตรวจสอบ Class Code" VIEW-AS ALERT-BOX ERROR.
          APPLY "ENTRY" TO fiClassCl IN FRAME frMain.
      END.
      ELSE IF fiCovcodCl = ? THEN DO:
          MESSAGE "ข้อมูลผิดพลาด,กรุณาตรวจสอบความคุ้มครอง" VIEW-AS ALERT-BOX ERROR.
          APPLY "ENTRY" TO fiCovcodCl IN FRAME frMain.
      END.
      ELSE IF fiTariff = "" THEN DO:
          MESSAGE "ข้อมูลผิดพลาด, กรุณาตรวจสอบ Tariff" VIEW-AS ALERT-BOX ERROR.
          APPLY "ENTRY" TO fiTariff IN FRAME frMain.
      END.

      RUN PDAddCover  IN THIS-PROCEDURE.
      RUN PDUpdateCL  IN THIS-PROCEDURE.
      APPLY "VALUE-CHANGED" TO brCover.
      RUN PDDisableCL IN THIS-PROCEDURE.

  END. /*ADD*/
  ELSE IF cmode = "UPDATE" THEN DO:
      GET CURRENT brCover EXCLUSIVE-LOCK.

      ASSIGN FRAME frmain
          ficlassCl  ficovcodCl  fiTariff
          fiBiP  fiBiA fimv41  fiMv42  fiMv43.

      RUN PDAddCover  IN THIS-PROCEDURE.
      RUN PDUpdateCL  IN THIS-PROCEDURE.
      APPLY "VALUE-CHANGED" TO brCover.
      RUN PDDisableCL IN THIS-PROCEDURE.

  END. /*UPDATE*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buSearchCA
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buSearchCA campaign
ON CHOOSE OF buSearchCA IN FRAME frmain /* ... */
DO:
   DEFINE VARIABLE cvData    AS CHARACTER NO-UNDO.
   DEFINE VARIABLE OKpressed AS LOGICAL INITIAL TRUE.

   SYSTEM-DIALOG GET-FILE cvData
        TITLE     "Choose Data File to Import ..."
        FILTERS   "Text Files (*.*)" "*.*",
                  "Excel (*.csv)" "*.csv",
                  "Excel (*.er)" "*.er",
                  "Text Files (*.txt)" "*.txt"                   
        MUST-EXIST
        USE-FILENAME
        UPDATE OKpressed.
      
    IF OKpressed = TRUE THEN DO:
         fiFileNameCA = cvData. /*SUBSTRING (cvData, R-INDEX (cvData,"\") + 1).*/
         DISP fiFileNameCA WITH FRAME {&FRAME-NAME}.     
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buSearchCL
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buSearchCL campaign
ON CHOOSE OF buSearchCL IN FRAME frmain /* ... */
DO:
   DEFINE VARIABLE cvData    AS CHARACTER NO-UNDO.
   DEFINE VARIABLE OKpressed AS LOGICAL INITIAL TRUE.

   SYSTEM-DIALOG GET-FILE cvData
        TITLE     "Choose Data File to Import ..."
        FILTERS   "Text Files (*.*)" "*.*",
                  "Excel (*.csv)" "*.csv",
                  "Excel (*.er)" "*.er",
                  "Text Files (*.txt)" "*.txt"                   
        MUST-EXIST
        USE-FILENAME
        UPDATE OKpressed.
      
    IF OKpressed = TRUE THEN DO:
         fiFileNameCL = cvData. /*SUBSTRING (cvData, R-INDEX (cvData,"\") + 1).*/
         DISP fiFileNameCL WITH FRAME {&FRAME-NAME}.     
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fibaseprm
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fibaseprm campaign
ON LEAVE OF fibaseprm IN FRAME frmain
DO:
  fibaseprm = INPUT fibaseprm.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiBiA
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiBiA campaign
ON LEAVE OF fiBiA IN FRAME frmain
DO:
  fiBiA = INPUT fiBia.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiBip
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiBip campaign
ON LEAVE OF fiBip IN FRAME frmain
DO:
  fiBip = INPUT fiBip.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiCamcode
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiCamcode campaign
ON LEAVE OF fiCamcode IN FRAME frmain
DO:
  fiCamcode = INPUT fiCamcode.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ficlassCA
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ficlassCA campaign
ON LEAVE OF ficlassCA IN FRAME frmain
DO:
  ficlassCA = INPUT ficlassCA.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ficlassCL
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ficlassCL campaign
ON LEAVE OF ficlassCL IN FRAME frmain
DO:
  ficlassCl = INPUT ficlassCl.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ficovcodCA
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ficovcodCA campaign
ON LEAVE OF ficovcodCA IN FRAME frmain
DO:
  ficovcodCA = INPUT ficovcodCA.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ficovcodCL
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ficovcodCL campaign
ON LEAVE OF ficovcodCL IN FRAME frmain
DO:
  ficovcodCL = INPUT ficovcodCl.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frdelete
&Scoped-define SELF-NAME fidelform
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fidelform campaign
ON LEAVE OF fidelform IN FRAME frdelete
DO:
  fidelform = TRIM(INPUT fidelform).

  fidelto = fidelform.
  DISP fidelto WITH FRAME frdelete.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fidelform campaign
ON RETURN OF fidelform IN FRAME frdelete
DO:
  fidelform = TRIM(INPUT fidelform).

  IF raitem = 2 AND fidelform = "" THEN DO:
      MESSAGE "ไม่มีการระบุค่าแรกที่ต้องการ Delete ..." 
      VIEW-AS ALERT-BOX WARNING.
  END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fidelto
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fidelto campaign
ON LEAVE OF fidelto IN FRAME frdelete
DO:
  fidelto = TRIM(INPUT fidelto).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frmain
&Scoped-define SELF-NAME fidspc
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fidspc campaign
ON LEAVE OF fidspc IN FRAME frmain
DO:
  fidspc = INPUT fidspc.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fieffdat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fieffdat campaign
ON LEAVE OF fieffdat IN FRAME frmain
DO:
  fieffdat = INPUT fieffdat.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiFileNameCA
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiFileNameCA campaign
ON LEAVE OF fiFileNameCA IN FRAME frmain
DO:
  fiFileNameCA = INPUT fiFileNameCA.
  fiFileNameCA = CAPS(fiFileNameCA).
  DISP fiFileNameCA WITH FRAME frmain.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiFileNameCL
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiFileNameCL campaign
ON LEAVE OF fiFileNameCL IN FRAME frmain
DO:
  fiFileNameCl = INPUT fiFileNameCl.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fimakdes
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fimakdes campaign
ON LEAVE OF fimakdes IN FRAME frmain
DO:
  fimakdes = INPUT fimakdes.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fimoddes
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fimoddes campaign
ON LEAVE OF fimoddes IN FRAME frmain
DO:
  fimoddes = INPUT fimoddes.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fimv41
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fimv41 campaign
ON LEAVE OF fimv41 IN FRAME frmain
DO:
  fimv41 = INPUT fimv41.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fimv42
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fimv42 campaign
ON LEAVE OF fimv42 IN FRAME frmain
DO:
  fimv42 = INPUT fimv42.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fimv43
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fimv43 campaign
ON LEAVE OF fimv43 IN FRAME frmain
DO:
  fimv43 = INPUT fimv43.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiPda
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiPda campaign
ON LEAVE OF fiPda IN FRAME frmain
DO:
  fiPda = INPUT fiPda.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiSeat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiSeat campaign
ON LEAVE OF fiSeat IN FRAME frmain
DO:
  fiSeat = INPUT fiSeat.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiSeatDriver
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiSeatDriver campaign
ON LEAVE OF fiSeatDriver IN FRAME frmain
DO:
  fiSeatDriver = INPUT fiSeatDriver.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiSeatPass
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiSeatPass campaign
ON LEAVE OF fiSeatPass IN FRAME frmain
DO:
  fiSeatPass = INPUT fiSeatPass.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fitariff
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fitariff campaign
ON LEAVE OF fitariff IN FRAME frmain
DO:
  fiTariff = "X".
  DISP fiTariff WITH FRAME frMain.
  fiTariff = INPUT fiTariff.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frdelete
&Scoped-define SELF-NAME fitext
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fitext campaign
ON LEAVE OF fitext IN FRAME frdelete
DO:
  IF nv_delete = 1 THEN DO: 
      fitext = "Delete Camapign".
  END.
  ELSE IF nv_delete = 2 THEN fitext = "Delete Cover".
  DISPLAY fitext WITH FRAME frdelete. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fitext2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fitext2 campaign
ON LEAVE OF fitext2 IN FRAME frdelete
DO:
  IF nv_delete = 1 THEN fitext2 = "Camapign".
  ELSE IF nv_delete = 2 THEN fitext2 = "Cover".
  DISPLAY fitext2 WITH FRAME frdelete. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frmain
&Scoped-define SELF-NAME fitltc
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fitltc campaign
ON LEAVE OF fitltc IN FRAME frmain
DO:
  fitltc = INPUT fitltc.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frdelete
&Scoped-define SELF-NAME raitem
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL raitem campaign
ON VALUE-CHANGED OF raitem IN FRAME frdelete
DO:
  raitem = INPUT raitem.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frmain
&Scoped-define BROWSE-NAME brcampaign
&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK campaign 


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

  RUN WUT\WUTDICEN (campaign:HANDLE). 
  SESSION:DATA-ENTRY-RETURN = YES.
  
  /*RECT-18:MOVE-TO-TOP().*/

  HIDE FRAME frdelete.

  ASSIGN
    buAddCA:SENSITIVE    IN FRAME frMain  = YES
    buEditCA:SENSITIVE   IN FRAME frMain  = YES
    buDeleteCA:SENSITIVE IN FRAME frmain  = YES
     
    buOKCA:SENSITIVE     IN FRAME frMain  = NO
    buCancelCA:SENSITIVE IN FRAME frMain  = NO

    buAddCL:SENSITIVE    IN FRAME frMain  = YES
    buEditCL:SENSITIVE   IN FRAME frMain  = YES
    buDeleteCL:SENSITIVE IN FRAME frmain  = YES
     
    buOKCL:SENSITIVE     IN FRAME frMain  = NO
    buCancelCL:SENSITIVE IN FRAME frMain  = NO.

  IF CAN-FIND(FIRST campaign) THEN DO:
      RUN PDUpdateCA.
      APPLY "VALUE-CHANGED" TO brcampaign.
  END.

  IF CAN-FIND (FIRST clastab_fil) THEN DO:
      RUN PDUpdateCL.
      APPLY "VALUE-CHANGED" TO brCover.
  END.

  RUN PDDisableCa IN THIS-PROCEDURE. 
  RUN PDDisableCl IN THIS-PROCEDURE.

  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI campaign  _DEFAULT-DISABLE
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
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(campaign)
  THEN DELETE WIDGET campaign.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI campaign  _DEFAULT-ENABLE
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
  DISPLAY fiFileNameCA fiCamcode fitltc fieffdat fimakdes fimoddes ficovcodCA 
          ficlassCA fiSeat fidspc fibaseprm fiFileNameCL ficlassCL ficovcodCL 
          fitariff fiBip fiBiA fiPda fimv41 fimv42 fimv43 fiSeatDriver 
          fiSeatPass 
      WITH FRAME frmain IN WINDOW campaign.
  ENABLE brCover brcampaign fiFileNameCA buSearchCA buImportCA buExportCA 
         fiCamcode fitltc fieffdat fimakdes fimoddes ficovcodCA ficlassCA 
         fiSeat fidspc fibaseprm buaddCA bueditCA budeleteCA buokCA bucancelCA 
         fiFileNameCL buImportCL buExportCL ficlassCL ficovcodCL fitariff fiBip 
         fiBiA fiPda fimv41 fimv42 fimv43 fiSeatDriver fiSeatPass buSearchCL 
         buaddCL bueditCL budeleteCL buokCL bucancelCL buexit RECT-379 RECT-381 
         RECT-383 RECT-384 RECT-382 RECT-385 RECT-386 RECT-387 RECT-388 
         RECT-389 RECT-390 RECT-391 
      WITH FRAME frmain IN WINDOW campaign.
  {&OPEN-BROWSERS-IN-QUERY-frmain}
  DISPLAY raitem fidelform fidelto fitext fitext2 
      WITH FRAME frdelete IN WINDOW campaign.
  ENABLE raitem fidelform fidelto budel bucel fitext fitext2 RECT-392 
      WITH FRAME frdelete IN WINDOW campaign.
  {&OPEN-BROWSERS-IN-QUERY-frdelete}
  VIEW campaign.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDAddCampaign campaign 
PROCEDURE PDAddCampaign :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VAR logAns AS LOGICAL INIT NO.

MESSAGE "ต้องการเพิ่มข้อมูลรายการนี้หรือไม่ ?" UPDATE logAns
VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO
TITLE "ยืนยันการเพิ่มข้อมูล".

IF logAns THEN DO:
    FIND FIRST campaign WHERE campaign.tltc   = fiCamcode + "|" + fitltc   AND
                              campaign.makdes = fimakdes AND
                              campaign.moddes = fimoddes AND
                              campaign.effdat = fieffdat NO-ERROR.
    IF AVAIL campaign THEN DO:
        ASSIGN
            campaign.tltc    = fiCamcode
            campaign.tltc    = fiCamcode + "|" + fitltc
            campaign.effdat  = fieffdat
            campaign.makdes  = fimakdes
            campaign.moddes  = fimoddes
            campaign.covcod  = ficovcodCA
            campaign.class   = ficlassCA
            campaign.mv1s    = fiseat
            campaign.dspc    = fidspc
            campaign.baseprm = fibaseprm.
    END.
    ELSE DO:
        CREATE campaign.
        ASSIGN
            campaign.tltc    = fiCamcode
            campaign.tltc    = fiCamcode + "|" + fitltc
            campaign.effdat  = fieffdat
            campaign.makdes  = fimakdes
            campaign.moddes  = fimoddes
            campaign.covcod  = ficovcodCA
            campaign.class   = ficlassCA
            campaign.mv1s    = fiseat
            campaign.dspc    = fidspc
            campaign.baseprm = fibaseprm.
    END.

    buAddCA:Sensitive    IN FRAME frmain = YES.
    buEditCA:SENSITIVE   IN FRAME frmain = YES.
    buDeleteCA:SENSITIVE IN FRAME frmain = YES.
      
    buOKCA:SENSITIVE     IN FRAME frmain = NO.
    buCancelCA:SENSITIVE IN FRAME frmain = NO.

END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDAddCover campaign 
PROCEDURE PDAddCover :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VAR logAns AS LOGICAL INIT NO.

MESSAGE "ต้องการเพิ่มข้อมูลรายการนี้หรือไม่ ?" UPDATE logAns
VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO
TITLE "ยืนยันการเพิ่มข้อมูล".

IF logAns THEN DO:
    FIND FIRST clastab_fil USE-INDEX clastab01 WHERE 
               clastab_fil.class   = ficlassCl  AND
               clastab_fil.covcod  = ficovcodCl /*AND 
               clastab_fil.Pass_41 = fiSeatPass*/ NO-ERROR.
    IF AVAIL clastab_fil THEN DO:
        ASSIGN
            clastab_fil.class     = fiClassCl
            clastab_fil.covcod    = fiCovcodCl
            clastab_fil.Tariff    = fiTariff
            clastab_fil.si_41unp  = fimv41
            clastab_fil.si_42     = fimv42
            clastab_fil.si_43     = fimv43
            clastab_fil.uom1_si   = fiBip 
            clastab_fil.uom2_si   = fiBiA 
            clastab_fil.uom5_si   = FiPdA
            clastab_fil.dri_41    = fiSeatDriver
            clastab_fil.pass_41   = fiSeatPass .
    END.
    ELSE DO:
        CREATE clastab_fil.
        ASSIGN
            clastab_fil.class     = fiClassCl
            clastab_fil.covcod    = fiCovcodCl
            clastab_fil.Tariff    = fiTariff
            clastab_fil.si_41unp  = fimv41
            clastab_fil.si_42     = fimv42
            clastab_fil.si_43     = fimv43
            clastab_fil.uom1_si   = fiBip 
            clastab_fil.uom2_si   = fiBiA 
            clastab_fil.uom5_si   = FiPdA
            clastab_fil.dri_41    = fiSeatDriver
            clastab_fil.pass_41   = fiSeatPass .
    END.

    buAddCL:Sensitive    IN FRAME frmain = YES.
    buEditCL:SENSITIVE   IN FRAME frmain = YES.
    buDeleteCL:SENSITIVE IN FRAME frmain = YES.
      
    buOKCL:SENSITIVE     IN FRAME frmain = NO.
    buCancelCL:SENSITIVE IN FRAME frmain = NO.

END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDClearCA campaign 
PROCEDURE PDClearCA :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
   ASSIGN
       fiCamcode  = ""
       fitltc     = ""
       fieffdat   = ?
       fimakdes   = ""
       fimoddes   = ""
       ficovcodCa = ""
       ficlassca  = ""
       fiseat     = 0
       fidspc     = 0
       fibaseprm  = 0.

   DISP fiCamcode fitltC fiEffdat fimakdes fimoddes
        ficovcodCa ficlassca fiseat fidspc fibaseprm WITH FRAME frmain.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDClearCL campaign 
PROCEDURE PDClearCL :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN
    ficlassCl     =  ""
    ficovcodCl    =  ""
    fitariff      =  ""
    fiBip         =  0
    fiBiA         =  0
    fiPDA         =  0
    fimv41        =  0
    fimv42        =  0
    fimv43        =  0
    fiSeatDriver  =  0
    fiSeatpass    =  0.

DISP ficlassCl ficovcodCl fitariff 
     fiBip fiBiA fiPDA fimv41
     fimv42 fimv43 
     fiSeatDriver fiSeatpass WITH FRAME frmain.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDDisableCA campaign 
PROCEDURE PDDisableCA :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

DISABLE
    fiCamcode fitltC fiEffdat fimakdes fimoddes
    ficovcodCa ficlassca fiseat fidspc fibaseprm
WITH FRAME frmain.

ENABLE brcampaign WITH FRAME frmain.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDDisableCl campaign 
PROCEDURE PDDisableCl :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DISABLE
    ficlassCl ficovcodCl fitariff 
    fiBip fiBiA fiPDA fimv41
    fimv42 fimv43 
    fiSeatDriver fiSeatpass
WITH FRAME frmain.

ENABLE brcover WITH FRAME frmain.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDEnableCA campaign 
PROCEDURE PDEnableCA :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ENABLE 
    fiCamcode fitltc fieffdat fimakdes fimoddes
    ficovcodca ficlassca fiseat fidspc fibaseprm
WITH FRAME frmain.

DISABLE brcampaign WITH FRAME frmain.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDEnableCl campaign 
PROCEDURE PDEnableCl :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ENABLE
    ficlassCl ficovcodCl fiTariff fiSeatDriver fiSeatPass
    fiBiP fiBiA fiPDA fimv41 fimv42 fimv43
WITH FRAME frmain.

DISABLE brCover WITH FRAME frmain.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDErrFile campaign 
PROCEDURE PDErrFile :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR j AS INTE INIT 0.
    IF  nv_Err1Flag = NO THEN DO:
        OUTPUT STREAM stErrFile TO VALUE(nv_FileErr1).
        OUTPUT STREAM stErrFile CLOSE.

        nv_Err1Flag = YES.
    END.

    OUTPUT  TO VALUE(nv_FileErr1) APPEND.
    EXPORT DELIMITER ","
        wtltc    
        weffdat       
        wmakdes  
        wmoddes  
        wcovcodca
        wclassca 
        wseat    
        wDSPC    
        wbaseprm .
  
          j = j + 1.
    OUTPUT CLOSE.   

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDErrMsg campaign 
PROCEDURE PDErrMsg :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF INPUT PARAMETER p_Msg AS CHAR FORMAT "X(20)".
DEF INPUT PARAMETER p_PolNoMsg AS CHAR FORMAT "X(50)".

DEF VAR j AS INTE INIT 0.
    IF  nv_Err2Flag = NO THEN DO:
        OUTPUT STREAM stErrFile TO VALUE(nv_FileErr2).
        OUTPUT STREAM stErrFile CLOSE.
        nv_Err2Flag = YES.
    END.
 
   OUTPUT  TO VALUE(nv_FileErr2) APPEND.
    EXPORT DELIMITER ","
            p_Msg  + "   "          
            wtltc
            weffdat         
            wmakdes        
            wmoddes        
            wcovcodca         
            wclassca           
            wseat           
            wDSPC       
            wbaseprm                  
            p_PolNoMsg 
        SKIP.
          j = j + 1.
    OUTPUT STREAM stErrMsg CLOSE. 

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDErrName campaign 
PROCEDURE PDErrName :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
nv_FileErr1 = "C:\Certify\DataFile\" + 
              STRING(DAY(TODAY),"99") +
              STRING(MONTH(TODAY),"99") + 
              STRING(YEAR(TODAY),"9999") + ".er" .
nv_FileErr2 = "C:\Certify\DataFile\" + 
              STRING(DAY(TODAY),"99") +
              STRING(MONTH(TODAY),"99") + 
              STRING(YEAR(TODAY),"9999") + ".mg" .  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDUpdateCA campaign 
PROCEDURE PDUpdateCA :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
OPEN QUERY brcampaign
    FOR EACH campaign /*WHERE 
             campaign.tltc   = fitltc   AND
             campaign.makdes = fimakdes AND
             campaign.moddes = fimoddes*/ NO-LOCK
        BY campaign.makdes 
        BY campaign.moddes.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDUpdateCL campaign 
PROCEDURE PDUpdateCL :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
OPEN QUERY brcover
    FOR EACH clastab_fil /*USE-INDEX clastab01 WHERE 
             clastab_fil.class  = ficlassCL AND
             clastab_fil.covcod = ficovcodCL*/ NO-LOCK
        BY clastab_fil.class 
        BY clastab_fil.covcod.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

