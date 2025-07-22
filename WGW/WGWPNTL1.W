&ANALYZE-SUSPEND _VERSION-NUMBER AB_v10r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          brstat           PROGRESS
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

  Created: Porntiwa T.  A59-0423   Date 17/11/2016
  Modify By : Chaiyong W. A61-0016 22/05/2018 add chk condition
  modify by : chonlapeet CH. A62-0224 21/05/2562 add chk tltc ,class 
              covcod ,garage ,mv1 เมื่อ import file เข้าไป  
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

DEFINE WORKFILE campntl LIKE brstat.campaign.
DEFINE VAR cmode AS CHAR.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main
&Scoped-define BROWSE-NAME brcampno

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES campaign

/* Definitions for BROWSE brcampno                                      */
&Scoped-define FIELDS-IN-QUERY-brcampno brstat.campaign.tltc brstat.campaign.CLASS brstat.campaign.covcod brstat.campaign.baseprm brstat.campaign.fleet brstat.campaign.dspc brstat.campaign.mv1 brstat.campaign.mv1s brstat.campaign.mv2 brstat.campaign.mv3 brstat.campaign.garage brstat.campaign.effdat   
&Scoped-define ENABLED-FIELDS-IN-QUERY-brcampno   
&Scoped-define SELF-NAME brcampno
&Scoped-define QUERY-STRING-brcampno FOR EACH brstat.campaign WHERE                               brstat.campaign.usrid = "NTL" NO-LOCK
&Scoped-define OPEN-QUERY-brcampno OPEN QUERY brcampno FOR EACH brstat.campaign WHERE                               brstat.campaign.usrid = "NTL" NO-LOCK.
&Scoped-define TABLES-IN-QUERY-brcampno campaign
&Scoped-define FIRST-TABLE-IN-QUERY-brcampno campaign


/* Definitions for FRAME fr_main                                        */
&Scoped-define OPEN-BROWSERS-IN-QUERY-fr_main ~
    ~{&OPEN-QUERY-brcampno}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS brcampno buImport buopen fi_camcod fi_class ~
fi_covcod fi_garage fi_effdat fi_bip fi_bia fi_pda fi_411 fi_412 fi_42 ~
fi_43 fi_comcod fifilename buExport fi_detail buAdd buDelete buExit buOK ~
buClear buUpdate RECT-1 RECT-2 RECT-3 RECT-650 RECT-651 RECT-652 RECT-654 ~
RECT-655 RECT-656 RECT-657 RECT-658 RECT-659 RECT-660 RECT-661 
&Scoped-Define DISPLAYED-OBJECTS fi_camcod fi_class fi_covcod fi_garage ~
fi_effdat fi_bip fi_bia fi_pda fi_411 fi_412 fi_42 fi_43 fi_comcod ~
fifilename fi_detail 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON buAdd 
     LABEL "Add" 
     SIZE 7.5 BY 1.1
     BGCOLOR 2 FONT 6.

DEFINE BUTTON buClear 
     LABEL "Clear" 
     SIZE 6 BY 1.1
     BGCOLOR 2 FONT 6.

DEFINE BUTTON buDelete 
     LABEL "Delete" 
     SIZE 7.5 BY 1.1
     BGCOLOR 2 FONT 6.

DEFINE BUTTON buExit 
     LABEL "Exit" 
     SIZE 7.5 BY 1.1
     BGCOLOR 4 FONT 6.

DEFINE BUTTON buExport 
     LABEL "Export" 
     SIZE 7.5 BY 1.1
     BGCOLOR 2 FONT 6.

DEFINE BUTTON buImport 
     LABEL "Import" 
     SIZE 7.5 BY 1.1
     BGCOLOR 2 FONT 6.

DEFINE BUTTON buOK 
     LABEL "OK" 
     SIZE 6 BY 1.1
     BGCOLOR 2 FONT 6.

DEFINE BUTTON buopen 
     IMAGE-UP FILE "wimage/help.bmp":U
     LABEL "Btn 2" 
     SIZE 3.33 BY 1.

DEFINE BUTTON buUpdate 
     LABEL "Update" 
     SIZE 7.5 BY 1.1
     BGCOLOR 2 FONT 6.

DEFINE VARIABLE fifilename AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 33 BY 1
     FONT 6 NO-UNDO.

DEFINE VARIABLE fi_411 AS INTEGER FORMAT "->,>>>,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1 TOOLTIP "กรณี campaign NTL = Sum Insureed"
     FONT 6 NO-UNDO.

DEFINE VARIABLE fi_412 AS INTEGER FORMAT "->,>>>,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1 TOOLTIP "กรณี campaign NTL = Base2"
     FONT 6 NO-UNDO.

DEFINE VARIABLE fi_42 AS INTEGER FORMAT "->,>>>,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1 TOOLTIP "กรณี campaign NTL = NCB"
     FONT 6 NO-UNDO.

DEFINE VARIABLE fi_43 AS INTEGER FORMAT "->,>>>,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1 TOOLTIP "กรณี campaign NTL = LoadCL"
     FONT 6 NO-UNDO.

DEFINE VARIABLE fi_bia AS INTEGER FORMAT "->,>>>,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1 TOOLTIP "กรณี campaign NTL = FLEET"
     FONT 6 NO-UNDO.

DEFINE VARIABLE fi_bip AS INTEGER FORMAT "->,>>>,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1 TOOLTIP "กรณี campaign NTL = Base Premium"
     FONT 6 NO-UNDO.

DEFINE VARIABLE fi_camcod AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 27 BY 1
     FONT 6 NO-UNDO.

DEFINE VARIABLE fi_class AS CHARACTER FORMAT "X(5)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     FONT 6 NO-UNDO.

DEFINE VARIABLE fi_comcod AS CHARACTER FORMAT "X(20)":U 
      VIEW-AS TEXT 
     SIZE 5 BY 1
     BGCOLOR 1 FGCOLOR 7 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_covcod AS CHARACTER FORMAT "X(4)":U 
     VIEW-AS FILL-IN 
     SIZE 10 BY 1
     FONT 6 NO-UNDO.

DEFINE VARIABLE fi_detail AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 101 BY 1
     FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_effdat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     FONT 6 NO-UNDO.

DEFINE VARIABLE fi_garage AS CHARACTER FORMAT "X(4)":U 
     VIEW-AS FILL-IN 
     SIZE 10 BY 1
     FONT 6 NO-UNDO.

DEFINE VARIABLE fi_pda AS INTEGER FORMAT "->,>>>,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1 TOOLTIP "กรณี campaign NTL = DSPC"
     FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 133.5 BY 1.67
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 46.33 BY 7
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-3
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 46.33 BY 9.29
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-650
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 9 BY 1.43
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-651
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 9 BY 1.43
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-652
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 133.5 BY 3.24
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-654
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 8.83 BY 1.38
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-655
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 8.83 BY 1.38
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-656
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 8.83 BY 1.38
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-657
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 8.83 BY 1.38
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-658
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 8.83 BY 1.38
     BGCOLOR 4 .

DEFINE RECTANGLE RECT-659
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 7.5 BY 1.38
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-660
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 7.5 BY 1.38
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-661
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 8.83 BY 1.38
     BGCOLOR 1 .

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY brcampno FOR 
      campaign SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE brcampno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS brcampno C-Win _FREEFORM
  QUERY brcampno DISPLAY
      brstat.campaign.tltc    COLUMN-LABEL "Campaign No." FORMAT "X(15)" 
 brstat.campaign.CLASS   COLUMN-LABEL "Class" FORMAT "X(5)"
 brstat.campaign.covcod  COLUMN-LABEL "ประเภท" FORMAT "X(5)"
 brstat.campaign.baseprm COLUMN-LABEL "TPBI/Person" FORMAT "->>,>>>,>>>,>>9"
 brstat.campaign.fleet   COLUMN-LABEL "TPBI/Acc" FORMAT "->>,>>>,>>>,>>9"
 brstat.campaign.dspc    COLUMN-LABEL "TPPD/Acc" FORMAT "->>,>>>,>>>,>>9"
 brstat.campaign.mv1     COLUMN-LABEL "411" FORMAT "->>,>>>,>>>,>>9"
 brstat.campaign.mv1s    COLUMN-LABEL "412" FORMAT "->>,>>>,>>>,>>9"
 brstat.campaign.mv2     COLUMN-LABEL "42" FORMAT "->>,>>>,>>>,>>9"
 brstat.campaign.mv3     COLUMN-LABEL "43" FORMAT "->>,>>>,>>>,>>9"
 brstat.campaign.garage  COLUMN-LABEL "ซ่อม" FORMAT "X(2)"
 brstat.campaign.effdat  COLUMN-LABEL "Effective Date" FORMAT "99/99/9999"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 86.67 BY 16.24
         FONT 6 ROW-HEIGHT-CHARS .62 FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     brcampno AT ROW 2.86 COL 1.5 WIDGET-ID 200
     buImport AT ROW 19.57 COL 52.83 WIDGET-ID 74
     buopen AT ROW 19.57 COL 47.5 WIDGET-ID 92
     fi_camcod AT ROW 4.1 COL 105 COLON-ALIGNED NO-LABEL WIDGET-ID 36
     fi_class AT ROW 5.14 COL 105 COLON-ALIGNED NO-LABEL WIDGET-ID 40
     fi_covcod AT ROW 6.19 COL 105 COLON-ALIGNED NO-LABEL WIDGET-ID 44
     fi_garage AT ROW 7.24 COL 105 COLON-ALIGNED NO-LABEL WIDGET-ID 42
     fi_effdat AT ROW 8.29 COL 105 COLON-ALIGNED NO-LABEL WIDGET-ID 38
     fi_bip AT ROW 11.24 COL 104 COLON-ALIGNED NO-LABEL WIDGET-ID 46
     fi_bia AT ROW 12.29 COL 104 COLON-ALIGNED NO-LABEL WIDGET-ID 48
     fi_pda AT ROW 13.33 COL 104 COLON-ALIGNED NO-LABEL WIDGET-ID 50
     fi_411 AT ROW 14.38 COL 104 COLON-ALIGNED NO-LABEL WIDGET-ID 52
     fi_412 AT ROW 15.43 COL 104 COLON-ALIGNED NO-LABEL WIDGET-ID 54
     fi_42 AT ROW 16.48 COL 104 COLON-ALIGNED NO-LABEL WIDGET-ID 56
     fi_43 AT ROW 17.52 COL 104 COLON-ALIGNED NO-LABEL WIDGET-ID 58
     fi_comcod AT ROW 1.43 COL 125 COLON-ALIGNED NO-LABEL WIDGET-ID 68
     fifilename AT ROW 19.57 COL 12.33 COLON-ALIGNED NO-LABEL WIDGET-ID 70
     buExport AT ROW 19.57 COL 61.67 WIDGET-ID 76
     fi_detail AT ROW 21.19 COL 2.5 NO-LABEL WIDGET-ID 82
     buAdd AT ROW 19.76 COL 99.17 WIDGET-ID 94
     buDelete AT ROW 19.76 COL 116.83 WIDGET-ID 98
     buExit AT ROW 19.76 COL 125.67 WIDGET-ID 102
     buOK AT ROW 17.48 COL 127 WIDGET-ID 106
     buClear AT ROW 16.1 COL 127 WIDGET-ID 110
     buUpdate AT ROW 19.76 COL 108 WIDGET-ID 114
     "File Name :" VIEW-AS TEXT
          SIZE 11.17 BY 1 AT ROW 19.57 COL 2.67 WIDGET-ID 72
          BGCOLOR 8 FONT 6
     "TPBI/Acc. :" VIEW-AS TEXT
          SIZE 12.17 BY 1 AT ROW 12.29 COL 91 WIDGET-ID 24
          BGCOLOR 8 FONT 6
     "TPPD/Acc. :" VIEW-AS TEXT
          SIZE 13.67 BY 1 AT ROW 13.33 COL 91 WIDGET-ID 26
          BGCOLOR 8 FONT 6
     "รย.411 :" VIEW-AS TEXT
          SIZE 8.67 BY 1 AT ROW 14.38 COL 91 WIDGET-ID 28
          BGCOLOR 8 FONT 6
     "รย.412 :" VIEW-AS TEXT
          SIZE 9.17 BY 1 AT ROW 15.43 COL 91 WIDGET-ID 30
          BGCOLOR 8 FONT 6
     "รย.42 :" VIEW-AS TEXT
          SIZE 8.67 BY 1 AT ROW 16.48 COL 91 WIDGET-ID 32
          BGCOLOR 8 FONT 6
     "รย.43 :" VIEW-AS TEXT
          SIZE 7.67 BY 1 AT ROW 17.52 COL 91 WIDGET-ID 34
          BGCOLOR 8 FONT 6
     " Coverage Detail" VIEW-AS TEXT
          SIZE 17.67 BY 1 AT ROW 9.91 COL 88.83 WIDGET-ID 66
          BGCOLOR 1 FGCOLOR 7 FONT 6
     " Load Campaign เงินติดล้อ [NTL]" VIEW-AS TEXT
          SIZE 34.5 BY 1 AT ROW 1.38 COL 44.17 WIDGET-ID 2
          BGCOLOR 1 FGCOLOR 7 FONT 17
     " Campaign Detail" VIEW-AS TEXT
          SIZE 17.67 BY 1 AT ROW 2.91 COL 88.83 WIDGET-ID 62
          BGCOLOR 1 FGCOLOR 7 FONT 6
     "Campaign No.:" VIEW-AS TEXT
          SIZE 15.67 BY 1 AT ROW 4.1 COL 91 WIDGET-ID 6
          BGCOLOR 8 FONT 6
     "Effective Date :" VIEW-AS TEXT
          SIZE 15.67 BY 1 AT ROW 8.29 COL 91 WIDGET-ID 14
          BGCOLOR 8 FONT 6
     "Class.:" VIEW-AS TEXT
          SIZE 8.67 BY 1 AT ROW 5.14 COL 91 WIDGET-ID 16
          BGCOLOR 8 FONT 6
     "Garage :" VIEW-AS TEXT
          SIZE 9.17 BY 1 AT ROW 7.24 COL 91 WIDGET-ID 18
          BGCOLOR 8 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 134.33 BY 21.52 WIDGET-ID 100.

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "Cover Type :" VIEW-AS TEXT
          SIZE 14.67 BY 1 AT ROW 6.19 COL 91 WIDGET-ID 20
          BGCOLOR 8 FONT 6
     "TPBI/Person :" VIEW-AS TEXT
          SIZE 14.67 BY 1 AT ROW 11.24 COL 91 WIDGET-ID 22
          BGCOLOR 8 FONT 6
     RECT-1 AT ROW 1.1 COL 1.5 WIDGET-ID 4
     RECT-2 AT ROW 2.81 COL 88.5 WIDGET-ID 60
     RECT-3 AT ROW 9.81 COL 88.5 WIDGET-ID 64
     RECT-650 AT ROW 19.33 COL 116 WIDGET-ID 78
     RECT-651 AT ROW 19.33 COL 124.83 WIDGET-ID 80
     RECT-652 AT ROW 19.19 COL 1.5 WIDGET-ID 84
     RECT-654 AT ROW 19.43 COL 52.17 WIDGET-ID 88
     RECT-655 AT ROW 19.43 COL 61 WIDGET-ID 90
     RECT-656 AT ROW 19.62 COL 98.5 WIDGET-ID 96
     RECT-657 AT ROW 19.62 COL 116.17 WIDGET-ID 100
     RECT-658 AT ROW 19.62 COL 125 WIDGET-ID 104
     RECT-659 AT ROW 17.33 COL 126.17 WIDGET-ID 108
     RECT-660 AT ROW 15.95 COL 126.17 WIDGET-ID 112
     RECT-661 AT ROW 19.62 COL 107.33 WIDGET-ID 116
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 134.33 BY 21.52 WIDGET-ID 100.


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
         TITLE              = "WGWPNTL1.W Laod Campaign NTL"
         HEIGHT             = 21.52
         WIDTH              = 134.33
         MAX-HEIGHT         = 45.81
         MAX-WIDTH          = 213.33
         VIRTUAL-HEIGHT     = 45.81
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
IF NOT C-Win:LOAD-ICON("wimage/iconhead.ico":U) THEN
    MESSAGE "Unable to load icon: wimage/iconhead.ico"
            VIEW-AS ALERT-BOX WARNING BUTTONS OK.
&ENDIF
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW C-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME fr_main
   FRAME-NAME Custom                                                    */
/* BROWSE-TAB brcampno 1 fr_main */
/* SETTINGS FOR FILL-IN fi_detail IN FRAME fr_main
   ALIGN-L                                                              */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE brcampno
/* Query rebuild information for BROWSE brcampno
     _START_FREEFORM
OPEN QUERY brcampno FOR EACH brstat.campaign WHERE
                              brstat.campaign.usrid = "NTL" NO-LOCK.
     _END_FREEFORM
     _Query            is OPENED
*/  /* BROWSE brcampno */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* WGWPNTL1.W Laod Campaign NTL */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* WGWPNTL1.W Laod Campaign NTL */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME brcampno
&Scoped-define SELF-NAME brcampno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brcampno C-Win
ON VALUE-CHANGED OF brcampno IN FRAME fr_main
DO:
  FIND CURRENT brstat.campaign NO-LOCK NO-ERROR.
  IF AVAIL brstat.campaign THEN DO:
      ASSIGN
          fi_class  = brstat.campaign.CLASS  
          fi_covcod = brstat.campaign.covcod 
          fi_bip    = brstat.campaign.baseprm
          fi_bia    = brstat.campaign.fleet  
          fi_pda    = brstat.campaign.dspc   
          fi_411    = brstat.campaign.mv1    
          fi_412    = brstat.campaign.mv1s   
          fi_42     = brstat.campaign.mv2    
          fi_43     = brstat.campaign.mv3    
          fi_camcod = brstat.campaign.tltc   
          fi_garage = brstat.campaign.garage 
          fi_effdat = brstat.campaign.effdat.

      DISPLAY
          brstat.campaign.CLASS   @ fi_class
          brstat.campaign.covcod  @ fi_covcod
          brstat.campaign.baseprm @ fi_bip
          brstat.campaign.fleet   @ fi_bia
          brstat.campaign.dspc    @ fi_pda
          brstat.campaign.mv1     @ fi_411
          brstat.campaign.mv1s    @ fi_412
          brstat.campaign.mv2     @ fi_42
          brstat.campaign.mv3     @ fi_43
          brstat.campaign.tltc    @ fi_camcod
          brstat.campaign.garage  @ fi_garage
          brstat.campaign.effdat  @ fi_effdat WITH FRAME fr_main.
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buAdd
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buAdd C-Win
ON CHOOSE OF buAdd IN FRAME fr_main /* Add */
DO:
  ASSIGN
      cmode = "Add".

  ENABLE fi_camcod fi_class fi_covcod fi_garage
         fi_effdat fi_bip fi_bia fi_pda fi_411
         fi_412 fi_42 fi_43 buok buclear WITH FRAME fr_main.

  DISABLE buAdd buupdate buDelete WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buClear
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buClear C-Win
ON CHOOSE OF buClear IN FRAME fr_main /* Clear */
DO:
  ASSIGN
      fi_camcod = ""
      fi_class  = ""
      fi_covcod = ""
      fi_garage = ""
      fi_effdat = ?
      fi_bip    = 0
      fi_bia    = 0
      fi_pda    = 0
      fi_411    = 0
      fi_412    = 0
      fi_42     = 0
      fi_43     = 0.

  DISP fi_camcod fi_class fi_covcod fi_garage
       fi_effdat fi_bip fi_bia fi_pda fi_411
       fi_412 fi_42 fi_43 WITH FRAME fr_main.

  DISABLE fi_camcod fi_class fi_covcod fi_garage
          fi_effdat fi_bip fi_bia fi_pda fi_411
          fi_412 fi_42 fi_43 buok buclear WITH FRAME fr_main.

  ENABLE buAdd buDelete WITH FRAME fr_main.

  RUN PDOpenQuery.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buDelete
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buDelete C-Win
ON CHOOSE OF buDelete IN FRAME fr_main /* Delete */
DO:
   /*-- 
   DEF VAR nv_row AS RECID.
   DEF VAR nv_count AS INT.
   --*/
  /*--  
    DELETE  brstat.campaign.  
    brcampno:SELECT-NEXT-ROW() .

    nv_row  =  RECID(brstat.campaign).      
    IF  nv_row =  ? THEN DO:
          brcampno:SELECT-PREV-ROW().
          nv_row    =   RECID(brstat.campaign).                      
          OPEN QUERY brcampno FOR EACH brstat.campaign NO-LOCK INDEXED-REPOSITION.                       
          REPOSITION brcampno TO  RECID(nv_row).   
    END.
    ELSE DO :   
          OPEN QUERY brcampno FOR EACH brstat.campaign NO-LOCK INDEXED-REPOSITION .                                                                                                                 
          REPOSITION brcampno TO  RECID(nv_row).   
    END.    
    --*/ 
   GET CURRENT brcampno EXCLUSIVE-LOCK. 
 
   DELETE brstat.campaign .
   
   /*--
   nv_count = 0.
   FOR EACH brstat.campaign:
         nv_count   = nv_count + 1 .
   END.
   --*/

   RUN PDOpenQuery.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buExit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buExit C-Win
ON CHOOSE OF buExit IN FRAME fr_main /* Exit */
DO:
  APPLY "CLOSE" TO THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buExport
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buExport C-Win
ON CHOOSE OF buExport IN FRAME fr_main /* Export */
DO:
OUTPUT TO VALUE(fiFileName).
FOR EACH brstat.campaign WHERE 
         brstat.campaign.usrid  = "NTL" NO-LOCK :

    EXPORT DELIMITER "|"
        brstat.campaign.effdat 
        brstat.campaign.class  
        brstat.campaign.tltc   
        brstat.campaign.covcod 
        brstat.campaign.garage 
        brstat.campaign.baseprm
        brstat.campaign.fleet  
        brstat.campaign.dspc   
        brstat.campaign.mv1    
        brstat.campaign.mv1s   
        brstat.campaign.mv2    
        brstat.campaign.mv3    
        brstat.campaign.usrid .

    ACCUMULATE 1 (COUNT).

END.
OUTPUT CLOSE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buImport
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buImport C-Win
ON CHOOSE OF buImport IN FRAME fr_main /* Import */
DO:
  DEF VAR nv_line AS INT INIT 0.
  FOR EACH campntl:
      DELETE campntl.
  END.
                                                   
  /*---Begin by Chaiyong W. A61-0016 22/05/2018*/
  FOR EACH brstat.campaign:
      DELETE brstat.campaign.
  END.
  /*End by Chaiyong W. A61-0016 22/05/2018-----*/

  INPUT FROM VALUE(fiFileName).
  REPEAT:
      CREATE campntl.
      IMPORT DELIMITER "|"
          campntl.effdat   /*วันที่เริ่มใช้*/
          campntl.class    /*Class*/
          campntl.tltc     /*Campaign No*/   
          campntl.covcod   /*Cover Type*/
          campntl.garage   /*Garage*/
          campntl.baseprm  /*TPBI/Person*/
          campntl.fleet    /*TPBI/Acc*/
          campntl.dspc     /*TPPD/Acc*/
          campntl.mv1      /*411*/
          campntl.mv1s     /*412*/
          campntl.mv2      /*42*/
          campntl.mv3      /*43*/
          campntl.usrid.

      /*---Begin by Chaiyong W. A61-0016 22/05/2018*/
      ASSIGN
          campntl.class    =  trim(campntl.class  )
          campntl.tltc     =  trim(campntl.tltc   )
          campntl.covcod   =  trim(campntl.covcod )
          campntl.garage   =  trim(campntl.garage ) 
          campntl.usrid    =  trim(campntl.usrid  ).


     nv_line  = nv_line + 1.
     IF nv_line = 100 THEN DO:
         DISP campntl.tltc  FORMAT "X(20)"
         WITH COLOR white/green NO-LABEL FRAME frProcess2 VIEW-AS DIALOG-BOX TITLE  "  Processing ...". 
         PAUSE 1 NO-MESSAGE.
         HIDE MESSAGE NO-PAUSE.

         nv_line = 0.
     END.

      /*-- add chonlapeet A62-0224 ---*/
      FIND FIRST brstat.campaign WHERE 
                 brstat.campaign.tltc   = campntl.tltc   AND
                 brstat.campaign.CLASS  = campntl.class  AND
                 brstat.campaign.covcod = campntl.covcod AND
                 brstat.campaign.garage = campntl.garage AND 
                 brstat.campaign.mv1    = campntl.mv1    NO-ERROR.

      IF AVAIL brstat.campaign THEN DO:
               ASSIGN
              brstat.campaign.effdat  =  campntl.effdat 
              brstat.campaign.class   =  campntl.class  
              brstat.campaign.tltc    =  campntl.tltc      
              brstat.campaign.covcod  =  campntl.covcod 
              brstat.campaign.garage  =  campntl.garage 
              brstat.campaign.baseprm =  campntl.baseprm
              brstat.campaign.fleet   =  campntl.fleet  
              brstat.campaign.dspc    =  campntl.dspc   
              brstat.campaign.mv1     =  campntl.mv1    
              brstat.campaign.mv1s    =  campntl.mv1s   
              brstat.campaign.mv2     =  campntl.mv2    
              brstat.campaign.mv3     =  campntl.mv3    
              brstat.campaign.usrid   =  campntl.usrid. 
          ACCUMULATE 1 (COUNT).
          NEXT.
      END.
      ELSE DO:
    
      /*-- end chonlapeet A62-0224 ---*/ 
   
      CREATE brstat.campaign.
      ASSIGN
          brstat.campaign.effdat  =  campntl.effdat 
          brstat.campaign.class   =  campntl.class  
          brstat.campaign.tltc    =  campntl.tltc      
          brstat.campaign.covcod  =  campntl.covcod 
          brstat.campaign.garage  =  campntl.garage 
          brstat.campaign.baseprm =  campntl.baseprm
          brstat.campaign.fleet   =  campntl.fleet  
          brstat.campaign.dspc    =  campntl.dspc   
          brstat.campaign.mv1     =  campntl.mv1    
          brstat.campaign.mv1s    =  campntl.mv1s   
          brstat.campaign.mv2     =  campntl.mv2    
          brstat.campaign.mv3     =  campntl.mv3    
          brstat.campaign.usrid   =  campntl.usrid. 
      /*End by Chaiyong W. A61-0016 22/05/2018---*/
     
      /*---
      FIND FIRST brstat.campaign WHERE 
                 brstat.campaign.usrid  = campntl.usrid  AND
                 brstat.campaign.CLASS  = campntl.class  AND
                 brstat.campaign.covcod = campntl.covcod AND
                 brstat.campaign.garage = campntl.garage NO-ERROR.
      IF AVAIL brstat.campaign THEN DO:
          ASSIGN
              brstat.campaign.effdat  =  campntl.effdat 
              brstat.campaign.class   =  campntl.class  
              brstat.campaign.tltc    =  campntl.tltc      
              brstat.campaign.covcod  =  campntl.covcod 
              brstat.campaign.garage  =  campntl.garage 
              brstat.campaign.baseprm =  campntl.baseprm
              brstat.campaign.fleet   =  campntl.fleet  
              brstat.campaign.dspc    =  campntl.dspc   
              brstat.campaign.mv1     =  campntl.mv1    
              brstat.campaign.mv1s    =  campntl.mv1s   
              brstat.campaign.mv2     =  campntl.mv2    
              brstat.campaign.mv3     =  campntl.mv3    
              brstat.campaign.usrid   =  campntl.usrid. 

          ACCUMULATE 1 (COUNT).
          NEXT.
      END.
      ELSE DO:
          CREATE brstat.campaign.
          ASSIGN
              brstat.campaign.effdat  =  campntl.effdat 
              brstat.campaign.class   =  campntl.class  
              brstat.campaign.tltc    =  campntl.tltc      
              brstat.campaign.covcod  =  campntl.covcod 
              brstat.campaign.garage  =  campntl.garage 
              brstat.campaign.baseprm =  campntl.baseprm
              brstat.campaign.fleet   =  campntl.fleet  
              brstat.campaign.dspc    =  campntl.dspc   
              brstat.campaign.mv1     =  campntl.mv1    
              brstat.campaign.mv1s    =  campntl.mv1s   
              brstat.campaign.mv2     =  campntl.mv2    
              brstat.campaign.mv3     =  campntl.mv3    
              brstat.campaign.usrid   =  campntl.usrid. 

          ACCUMULATE 1 (COUNT).
          NEXT.
      END. comment by Chaiyong W. A61-0016 22/05/2018*/


          ACCUMULATE 1 (COUNT).
          NEXT.
      END. /*-- ELSE DO: --*/

  END.
  INPUT CLOSE.

  MESSAGE "นำเข้าข้อมูล campaign จำนวน : " ACCUMULATE COUNT 1 "รายการ"
  VIEW-AS ALERT-BOX INFORMATION.
  RUN PDOpenQuery.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buOK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buOK C-Win
ON CHOOSE OF buOK IN FRAME fr_main /* OK */
DO:

   DO WITH FRAME fr_main:
     ASSIGN
           fi_camcod = trim(input fi_camcod)
           fi_class  = trim(input fi_class )
           fi_covcod = trim(input fi_covcod)
           fi_garage = trim(input fi_garage)
           fi_effdat = input fi_effdat
           fi_bip    = input fi_bip   
           fi_bia    = input fi_bia   
           fi_pda    = input fi_pda   
           fi_411    = input fi_411   
           fi_412    = input fi_412   
           fi_42     = input fi_42    
           fi_43     = input fi_43.  
   END.


  IF cmode = "Add" THEN DO:
      IF fi_camcod = "" THEN DO:
          MESSAGE "Not Found Campaign Code" VIEW-AS ALERT-BOX WARNING.
          APPLY "ENTRY" TO fi_camcod IN FRAME fr_main.
          RETURN NO-APPLY.
      END.
      
      IF fi_class = "" THEN DO:
          MESSAGE "Not Found Class Code" VIEW-AS ALERT-BOX WARNING.
          APPLY "ENTRY" TO fi_class IN FRAME fr_main.
          RETURN NO-APPLY.
      END.
      
      IF fi_covcod = "" THEN DO:
          MESSAGE "Not Found Cover Code" VIEW-AS ALERT-BOX WARNING.
          APPLY "ENTRY" TO fi_covcod IN FRAME fr_main.
          RETURN NO-APPLY.
      END.

      RUN PDGenCampaign.
  END.
  ELSE DO:

      IF fi_camcod = "" THEN DO:
          MESSAGE "Not Found Campaign Code" VIEW-AS ALERT-BOX WARNING.
          APPLY "ENTRY" TO fi_camcod IN FRAME fr_main.
          RETURN NO-APPLY.
      END.
      
      IF fi_class = "" THEN DO:
          MESSAGE "Not Found Class Code" VIEW-AS ALERT-BOX WARNING.
          APPLY "ENTRY" TO fi_class IN FRAME fr_main.
          RETURN NO-APPLY.
      END.
      
      IF fi_covcod = "" THEN DO:
          MESSAGE "Not Found Cover Code" VIEW-AS ALERT-BOX WARNING.
          APPLY "ENTRY" TO fi_covcod IN FRAME fr_main.
          RETURN NO-APPLY.
      END.
    
      ASSIGN
          fi_camcod = fi_camcod
          fi_class  = fi_class 
          fi_covcod = fi_covcod
          fi_garage = fi_garage
          fi_effdat = fi_effdat
          fi_bip    = fi_bip   
          fi_bia    = fi_bia   
          fi_pda    = fi_pda   
          fi_411    = fi_411   
          fi_412    = fi_412   
          fi_42     = fi_42    
          fi_43     = fi_43.    

      RUN PDGenCampaign.
  END.

  ASSIGN
      fi_camcod = ""
      fi_class  = ""
      fi_covcod = ""
      fi_garage = ""
      fi_effdat = ?
      fi_bip    = 0
      fi_bia    = 0
      fi_pda    = 0
      fi_411    = 0
      fi_412    = 0
      fi_42     = 0
      fi_43     = 0.

  DISP fi_camcod fi_class fi_covcod fi_garage
       fi_effdat fi_bip fi_bia fi_pda fi_411
       fi_412 fi_42 fi_43 WITH FRAME fr_main.

  DISABLE fi_camcod fi_class fi_covcod fi_garage
          fi_effdat fi_bip fi_bia fi_pda fi_411
          fi_412 fi_42 fi_43 buok buclear WITH FRAME fr_main.

  ENABLE buAdd buupdate buDelete WITH FRAME fr_main.

  RUN PDOpenQuery.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buopen
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buopen C-Win
ON CHOOSE OF buopen IN FRAME fr_main /* Btn 2 */
DO:
   DEFINE VARIABLE cvData    AS CHARACTER NO-UNDO.
   DEFINE VARIABLE OKpressed AS LOGICAL INITIAL TRUE.

   DEF VAR no_add AS CHAR FORMAT "x(8)". 

   SYSTEM-DIALOG GET-FILE cvData
       TITLE "Choose Data File to Import/Export...."
       FILTERS "Text Files (*.txt)" "*.csv"
       MUST-EXIST
       USE-FILENAME
       UPDATE OKpressed.

   IF OKpressed = TRUE THEN DO:
       no_add =           STRING(MONTH(TODAY),"99")    + 
                          STRING(DAY(TODAY),"99")      + 
                SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) + 
                SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2) .

       ASSIGN
          fiFileName = cvData.

       DISP fiFileName WITH FRAME {&FRAME-NAME}. 
       /*APPLY "Entry" TO fioutput3.
       RETURN NO-APPLY.*/
   END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buUpdate
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buUpdate C-Win
ON CHOOSE OF buUpdate IN FRAME fr_main /* Update */
DO:
  ASSIGN
      cmode = "Update".

  GET CURRENT brcampno EXCLUSIVE-LOCK.

  ENABLE fi_camcod fi_class fi_covcod fi_garage
         fi_effdat fi_bip fi_bia fi_pda fi_411
         fi_412 fi_42 fi_43 buok buclear WITH FRAME fr_main.

  DISABLE buAdd buupdate buDelete WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fifilename
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fifilename C-Win
ON LEAVE OF fifilename IN FRAME fr_main
DO:
  fiFileName = INPUT fiFileName.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_411
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_411 C-Win
ON LEAVE OF fi_411 IN FRAME fr_main
DO:
  fi_411 = INPUT fi_411.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_412
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_412 C-Win
ON LEAVE OF fi_412 IN FRAME fr_main
DO:
  fi_412 = INPUT fi_412.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_42
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_42 C-Win
ON LEAVE OF fi_42 IN FRAME fr_main
DO:
  fi_42 = INPUT fi_42.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_43
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_43 C-Win
ON LEAVE OF fi_43 IN FRAME fr_main
DO:
  fi_43 = INPUT fi_43.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_bia
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_bia C-Win
ON LEAVE OF fi_bia IN FRAME fr_main
DO:
  fi_bia = INPUT fi_bia.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_bip
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_bip C-Win
ON LEAVE OF fi_bip IN FRAME fr_main
DO:
  fi_bip = INPUT fi_bip.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_camcod
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_camcod C-Win
ON LEAVE OF fi_camcod IN FRAME fr_main
DO:
  fi_camcod = INPUT fi_camcod.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_class
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_class C-Win
ON LEAVE OF fi_class IN FRAME fr_main
DO:
  fi_class = INPUT fi_class.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_covcod
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_covcod C-Win
ON LEAVE OF fi_covcod IN FRAME fr_main
DO:
  fi_covcod = INPUT fi_covcod.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_effdat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_effdat C-Win
ON LEAVE OF fi_effdat IN FRAME fr_main
DO:
  fi_effdat = INPUT fi_effdat.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_garage
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_garage C-Win
ON LEAVE OF fi_garage IN FRAME fr_main
DO:
  fi_garage = INPUT fi_garage.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_pda
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_pda C-Win
ON LEAVE OF fi_pda IN FRAME fr_main
DO:
  fi_pda = INPUT fi_pda.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


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
  DEF  VAR  gv_prgid   AS   CHAR  FORMAT "X(8)"   NO-UNDO.
  DEF  VAR  gv_prog    AS   CHAR  FORMAT "X(40)" NO-UNDO.
  
  gv_prgid = "WGWPNTL1.W".
  gv_prog  = "Load Campaign เงินติดล้อ".  
  
  RUN  WUT\WUTWICEN ({&WINDOW-NAME}:HANDLE). 
  SESSION:DATA-ENTRY-RETURN = YES.
  /*********************************************************************/ 

  DISABLE fi_camcod fi_class fi_covcod fi_garage
          fi_effdat fi_bip fi_bia fi_pda fi_411
          fi_412 fi_42 fi_43 buok buclear WITH FRAME fr_main.

  FOR EACH brstat.campaign WHERE brstat.campaign.usrid = "NTL" NO-LOCK:

      CREATE  campntl.
      ASSIGN
          campntl.effdat   = campaign.effdat   
          campntl.class    = campaign.class    
          campntl.tltc     = campaign.tltc     
          campntl.makdes   = campaign.makdes   
          campntl.moddes   = campaign.moddes   
          campntl.covcod   = campaign.covcod   
          campntl.garage   = campaign.garage   
          campntl.baseprm  = campaign.baseprm  
          campntl.fleet    = campaign.fleet    
          campntl.dspc     = campaign.dspc     
          campntl.mv1      = campaign.mv1      
          campntl.mv1s     = campaign.mv1s     
          campntl.mv2      = campaign.mv2      
          campntl.mv3      = campaign.mv3      
          campntl.comp_prm = campaign.comp_prm 
          campntl.usrid    = campaign.usrid.  

      fi_comcod = brstat.campaign.usrid.
  END.

  DISPLAY fi_comcod WITH FRAME fr_main.

  /*OPEN QUERY br_campno FOR EACH campntl NO-LOCK.*/

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
  DISPLAY fi_camcod fi_class fi_covcod fi_garage fi_effdat fi_bip fi_bia fi_pda 
          fi_411 fi_412 fi_42 fi_43 fi_comcod fifilename fi_detail 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE brcampno buImport buopen fi_camcod fi_class fi_covcod fi_garage 
         fi_effdat fi_bip fi_bia fi_pda fi_411 fi_412 fi_42 fi_43 fi_comcod 
         fifilename buExport fi_detail buAdd buDelete buExit buOK buClear 
         buUpdate RECT-1 RECT-2 RECT-3 RECT-650 RECT-651 RECT-652 RECT-654 
         RECT-655 RECT-656 RECT-657 RECT-658 RECT-659 RECT-660 RECT-661 
      WITH FRAME fr_main IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDGenCampaign C-Win 
PROCEDURE PDGenCampaign :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

IF index(fi_camcod,"NTL") = 0  THEN DO:
    FIND LAST brstat.campaign WHERE               
              brstat.campaign.usrid  = "NTL"     AND
              brstat.campaign.tltc   = fi_camcod AND
              brstat.campaign.CLASS  = fi_class  AND
              brstat.campaign.covcod = fi_covcod AND
              brstat.campaign.garage = fi_garage NO-ERROR NO-WAIT.
         
    IF NOT AVAIL brstat.campaign THEN DO:
        CREATE brstat.campaign.
        ASSIGN
            brstat.campaign.effdat  = fi_effdat
            brstat.campaign.class   = fi_class
            brstat.campaign.tltc    = fi_camcod
            brstat.campaign.covcod  = fi_covcod
            brstat.campaign.garage  = fi_garage
            brstat.campaign.baseprm = fi_bip
            brstat.campaign.fleet   = fi_bia
            brstat.campaign.dspc    = fi_pda
            brstat.campaign.mv1     = fi_411
            brstat.campaign.mv1s    = fi_412
            brstat.campaign.mv2     = fi_42
            brstat.campaign.mv3     = fi_43
            brstat.campaign.usrid   = "NTL".
    END.
    ELSE DO:
        ASSIGN
            brstat.campaign.effdat  = fi_effdat
            brstat.campaign.baseprm = fi_bip
            brstat.campaign.fleet   = fi_bia
            brstat.campaign.dspc    = fi_pda
            brstat.campaign.mv1     = fi_411
            brstat.campaign.mv1s    = fi_412
            brstat.campaign.mv2     = fi_42
            brstat.campaign.mv3     = fi_43.
    END.
END.
ELSE DO:
    




    
    FIND LAST brstat.campaign WHERE     

             
            brstat.campaign.class   = fi_class     AND
            brstat.campaign.tltc    = fi_camcod    AND
            brstat.campaign.covcod  = fi_covcod    AND
            brstat.campaign.garage  = fi_garage    AND
            brstat.campaign.mv1     = fi_411       AND
            brstat.campaign.usrid   = "NTL"        NO-ERROR NO-WAIT.
         
    IF NOT AVAIL brstat.campaign THEN DO:
        CREATE brstat.campaign.
        ASSIGN
            brstat.campaign.effdat  = fi_effdat
            brstat.campaign.class   = fi_class
            brstat.campaign.tltc    = fi_camcod
            brstat.campaign.covcod  = fi_covcod
            brstat.campaign.garage  = fi_garage
            brstat.campaign.baseprm = fi_bip
            brstat.campaign.fleet   = fi_bia
            brstat.campaign.dspc    = fi_pda
            brstat.campaign.mv1     = fi_411
            brstat.campaign.mv1s    = fi_412
            brstat.campaign.mv2     = fi_42
            brstat.campaign.mv3     = fi_43
            brstat.campaign.usrid   = "NTL".
    END.
    ELSE DO:
        ASSIGN
            brstat.campaign.effdat  = fi_effdat            
            brstat.campaign.baseprm = fi_bip                   
            brstat.campaign.fleet   = fi_bia                   
            brstat.campaign.dspc    = fi_pda                   
            brstat.campaign.mv1s    = fi_412                   
            brstat.campaign.mv2     = fi_42                    
            brstat.campaign.mv3     = fi_43                    
            brstat.campaign.usrid   = "NTL".           
    END.


END.


RELEASE brstat.campaign.
MESSAGE "Update Data Campaign Complete" VIEW-AS ALERT-BOX INFORMATION.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDOpenQuery C-Win 
PROCEDURE PDOpenQuery :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

OPEN QUERY brcampno FOR EACH brstat.campaign WHERE 
                             brstat.campaign.usrid = "NTL" NO-LOCK .
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDUpCampaign C-Win 
PROCEDURE PDUpCampaign :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

